/*
 * ---- breadfishs object editor ----
 * -- copyright (c) 2007 breadfish --
 * ----- breadfish@breadfish.de -----
 */
#include <a_samp>

#pragma dynamic 8192

#define MAX_STRING 256

/* -- FARBEN -- */
#define COLOR_RED 0xFF0000FF
#define COLOR_YELLOW 0xFFFF00FF
#define COLOR_GREEN 0x00FF00FF
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_BLUE 0x0000FFFF

/* -- LIMITS -- */
#define MAX_OBJECTS 150

/* -- OBJECT-EDITINGMODES -- */
#define OED_NONE 0
#define OED_MOVE 1
#define OED_ROTATE 2
#define OED_MOVE_XY 3
#define OED_MOVE_Z 4
#define OED_ROTATE_XY 5
#define OED_ROTATE_Z 6

/* -- ACHSEN -- */
#define AXIS_NONE 0
#define AXIS_X 1
#define AXIS_Y 2
#define AXIS_Z 3

/* -- KEY FIXES -- */
#undef KEY_UP
#undef KEY_DOWN
#undef KEY_LEFT
#undef KEY_RIGHT
#define KEY_UP 65408
#define KEY_DOWN 128
#define KEY_LEFT 65408
#define KEY_RIGHT 128

/* -- VKEYS -- */
#define VKEY_LEFT 32768
#define VKEY_RIGHT 65536
#define VKEY_UP 131072
#define VKEY_DOWN 262144

/* -- MENUMODES -- */
#define MM_SELECT_EDITMODE 1
#define MM_SELECT_EDITMODE_DETACHONLY 2
#define MM_SELECT_MULTIPLIER 3
/* -- UMLAUTE FIX -- */
#define fixchars(%1) for(new charfixloop=0;charfixloop<strlen(%1);charfixloop++)if(%1[charfixloop]<0)%1[charfixloop]+=256

/* -- FORWARDS -- */
forward Float:strflt(string[]);
forward Float:GetDistanceBetweenCoords(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2);
forward Float:FloatBubbleSort(Float:lArray[MAX_OBJECTS][2], lArraySize);
//Timer
forward ObjectEditTimer(playerid, editmode, axis, Float:value);
forward UpDownLeftRightAdditionTimer();
forward SetObjectCoords(playerid, obj_id);

//objektdaten
enum OBJECTDATA() {
    ModelID,
    Float:obj_x,
    Float:obj_y,
    Float:obj_z,
    Float:rot_x,
    Float:rot_y,
    Float:rot_z,
    Name[MAX_STRING],
    bool:savetofile
}
//spielerdaten
enum PLAYERDATA {
    Name[25],
    Level                                 
}
//script-konfiguration
enum SCRIPTDATA {
    PLAYER_MAX_HOUSES,
    PLAYER_MAX_JOBS,
    CAR_STANDARD_TANKINHALT,
    CAR_RESPAWN_DELAY,
    PLAYER_DEFAULT_MONEY
}
//currently edited object
enum EDITINGOBJECT {
    object_id,
    mode,
    bool:domove,
    Float:movestep,
    Float:rotatestep,
    Float:StickDistance,
    Float:EditMultiplier,
    bool:stuck
}

//datenhaltung
new gPlayer[MAX_PLAYERS][PLAYERDATA];   //player-infos
new gObjects[150][OBJECTDATA];          //objekte

new gEditingObject[MAX_PLAYERS][EDITINGOBJECT];
new gObjectEditTimer[MAX_PLAYERS];
new gCameraSetTimer[MAX_PLAYERS];
new gLastPlayerKeys[MAX_PLAYERS][2];
new bool:gPlayerMenu[MAX_PLAYERS];
new gSelectedMultiplier[MAX_PLAYERS];
new Menu:gMenus[MAX_PLAYERS];
new gMenuMode[MAX_PLAYERS];
//limits
new gObjectCount;

/*---------------------------------------------------------------------------------------------------*/

public OnFilterScriptInit() {
    print("+---------------+");
    print("| Object editor |");
    print("|  Filterscript |");
    print("|  by breadfish |");
    print("+---------------+");

    ReadObjects();
    SetTimer("UpDownLeftRightAdditionTimer", 50, 1);
    return 1;
}

/*---------------------------------------------------------------------------------------------------*/

public OnPlayerConnect(playerid) {
    new name[25];

    if (!IsPlayerConnected(playerid)) return 0;
    
    GetPlayerName(playerid, name, sizeof name);

    //reset playerdata
    gPlayer[playerid][Name] = name;
    gSelectedMultiplier[playerid] = 3;
    
    return 1;
}

/*---------------------------------------------------------------------------------------------------*/

public OnPlayerText(playerid, text[]) {
    if (!IsPlayerConnected(playerid)) return 0;
    
    fixchars(text);
    return 1;
}

/*---------------------------------------------------------------------------------------------------*/

public OnPlayerCommandText(playerid, cmdtext[]) {
    new cmd[MAX_STRING], idx;
    new syntax[MAX_STRING];
    new Float:x, Float:y, Float:z, Float:angle;
    new msg[MAX_STRING];
    
    if (!IsPlayerConnected(playerid)) return 0;
    
    fixchars(cmdtext);
    
    //wird immer mal wieder gebraucht...
    if (IsPlayerInAnyVehicle(playerid)) {
        GetVehiclePos(GetPlayerVehicleID(playerid),x, y, z);
        GetVehicleZAngle(GetPlayerVehicleID(playerid), angle);
    } else {
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, angle);
    }
    
    
    cmd = strtok(cmdtext, idx);
    
    if (IsPlayerAdmin(playerid)) {
    
        // objekte erzeugen
        if (strcmp(cmd, "/oadd", true) == 0) {
            new modelid, name[MAX_STRING], newoid;
            syntax = "SYNTAX: /oadd [modelid] [name]";
            
            //modelid
            cmd = strtok(cmdtext, idx);
            if (!(strlen(cmd))) {
                SystemMessage(playerid, syntax, COLOR_YELLOW);
                return 1;
            } else {
                modelid = strval(cmd);
            }
            
            //name
            cmd = strtok(cmdtext, idx);
            if (!(strlen(cmd))) {
                SystemMessage(playerid, syntax, COLOR_YELLOW);
                return 1;
            } else {
                name = cmd;
            }
            
            if (!(gCameraSetTimer[playerid] == 0)) {
                KillTimer(gCameraSetTimer[playerid]);
                gCameraSetTimer[playerid] = 0;
                SetCameraBehindPlayer(playerid);
            }
            
            TogglePlayerControllable(playerid, 1);
            
            newoid = AddNewObjectToScript(modelid, x, y + 2, z, 0, 0, 0, name);
            gEditingObject[playerid][object_id] = newoid;
            if (gEditingObject[playerid][mode] == OED_NONE) gEditingObject[playerid][mode] = OED_MOVE_XY;
            gEditingObject[playerid][movestep] = 0.05;
            gEditingObject[playerid][rotatestep] = 1.0;
            gObjects[newoid][savetofile] = true;
            if (gEditingObject[playerid][EditMultiplier] == 0) gEditingObject[playerid][EditMultiplier] = 1;
            
            SaveObjects();
            
            format(msg, sizeof msg, "Objekt: '%s' ModelID: %d ObjectID: %d", name, gObjects[newoid][ModelID], newoid);
            SystemMessage(playerid, msg, COLOR_GREEN);
            
            return 1;
        }
        
        // objekte kopieren
        if (strcmp(cmd, "/ocopy", true) == 0) {
            new name[MAX_STRING], newoid;
            new Float:rx, Float:ry, Float:rz;
            syntax = "SYNTAX: /ocopy [name]";
            
            //name
            cmd = strtok(cmdtext, idx);
            if (!(strlen(cmd))) {
                SystemMessage(playerid, syntax, COLOR_YELLOW);
                return 1;
            } else {
                name = cmd;
            }
            
            if (!(gCameraSetTimer[playerid] == 0)) {
                KillTimer(gCameraSetTimer[playerid]);
                gCameraSetTimer[playerid] = 0;
                SetCameraBehindPlayer(playerid);
            }
            
            x = gObjects[gEditingObject[playerid][object_id]][obj_x];
            y = gObjects[gEditingObject[playerid][object_id]][obj_y];
            z = gObjects[gEditingObject[playerid][object_id]][obj_z];
            rx = gObjects[gEditingObject[playerid][object_id]][rot_x];
            ry = gObjects[gEditingObject[playerid][object_id]][rot_y];
            rz = gObjects[gEditingObject[playerid][object_id]][rot_z];
            
            newoid = AddNewObjectToScript(gObjects[gEditingObject[playerid][object_id]][ModelID], x, y, z, rx, ry, rz, name);
            gEditingObject[playerid][object_id] = newoid;
            if (gEditingObject[playerid][mode] == OED_NONE) gEditingObject[playerid][mode] = OED_MOVE_XY;
            gEditingObject[playerid][movestep] = 0.05;
            gEditingObject[playerid][rotatestep] = 1.0;
            gObjects[newoid][savetofile] = true;
            if (gEditingObject[playerid][EditMultiplier] == 0) gEditingObject[playerid][EditMultiplier] = 1;
            
            SaveObjects();
            
            format(msg, sizeof msg, "Created copy: '%s' ModelID: %d ObjectID: %d", name, gObjects[newoid][ModelID], newoid);
            SystemMessage(playerid, msg, COLOR_GREEN);
            
            return 1;
        }
        
        // objekt löschen
        if (strcmp(cmd, "/odel", true) == 0) {
            if (!(gEditingObject[playerid][object_id] == 0)) {
                new oid = gEditingObject[playerid][object_id];
                new empty[MAX_STRING];
                
                DestroyObject(oid);
                gObjects[oid][savetofile] = false;
                gEditingObject[playerid][object_id] = 0;
                gObjects[oid][Name] = empty;
                gObjectCount--;
                
                if (!(gCameraSetTimer[playerid] == 0)) {
                    KillTimer(gCameraSetTimer[playerid]);
                    gCameraSetTimer[playerid] = 0;
                    SetCameraBehindPlayer(playerid);
                }
                
                SaveObjects();
                TogglePlayerControllable(playerid, 1);
                
                format(msg, sizeof msg, "Objekt '%s' (ModelID:%d ObjectID:%d) deleted",  gObjects[oid][Name], gObjects[oid][ModelID], oid);
                SystemMessage(playerid, msg, COLOR_GREEN);
            } else {
                SystemMessage(playerid, "No object selected", COLOR_YELLOW);
            }
            return 1;
        }
        
        // bearbeitungsmodus setzen
        if (strcmp(cmd, "/omode", true) == 0) {
            if (!(gEditingObject[playerid][object_id] == 0)) {
                new newmode;
                syntax = "SYNTAX: /omode [m_xy|m_z|r_xy|r_z]";
                
                //mode
                cmd = strtok(cmdtext, idx);
                if (!(strlen(cmd))) {
                    SystemMessage(playerid, syntax, COLOR_YELLOW);
                    return 1;
                } else {
                    if (strcmp(cmd, "m_xy", true) == 0) newmode = OED_MOVE_XY;
                    if (strcmp(cmd, "m_z", true) == 0) newmode = OED_MOVE_Z;
                    if (strcmp(cmd, "r_xy", true) == 0) newmode = OED_ROTATE_XY;
                    if (strcmp(cmd, "r_z", true) == 0) newmode = OED_ROTATE_Z;
                }
                
                if (!(newmode == 0)) {
                    gEditingObject[playerid][mode] = newmode;
                
                    SystemMessage(playerid, "New edit-mode set", COLOR_GREEN);
                    return 1;
                } else {
                    SystemMessage(playerid, syntax, COLOR_YELLOW);
                    return 1;
                }
            } else {
                SystemMessage(playerid, "No object selected", COLOR_YELLOW);
            }
        }
        
        // objekte in der umgebung zeigen
        if (strcmp(cmd, "/onext", true) == 0) {
            new objects[24], oid, objnames[MAX_STRING];
            objects = GetPlayerNearestObjects(playerid);
            
            for (new i=1;(i<=gObjectCount) && (i<24);i++) {
                oid = objects[i];
                
                strcat(objnames, gObjects[oid][Name]);
                strcat(objnames, ", ");
            }
            
            if (strlen(objnames)) {
                strmid(objnames, objnames, 0, strlen(objnames) - 2);
            }
            
            format(objnames, sizeof objnames, "Nearest objects: %s", objnames);
            SystemMessage(playerid, objnames, COLOR_YELLOW);
            return 1;
        }
        
        //objekt zum bearbeiten auswählen
        if (strcmp(cmd, "/osel", true) == 0) {
            new name[MAX_STRING], oid;
            syntax = "SYNTAX: /osel [Objektname]";
            
            //name
            cmd = strtok(cmdtext, idx);
            if (!(strlen(cmd))) {
                SystemMessage(playerid, syntax, COLOR_YELLOW);
                return 1;
            } else {
                name = cmd;
            }
            
            for (new i=1;i<=gObjectCount;i++) {
                if (strcmp(gObjects[i][Name], name, true) == 0) {
                    oid = i;
                    break;
                }
            }
            
            if (oid) {
                if (!(gCameraSetTimer[playerid] == 0)) {
                    KillTimer(gCameraSetTimer[playerid]);
                    gCameraSetTimer[playerid] = 0;
                    SetCameraBehindPlayer(playerid);
                }
            
                gEditingObject[playerid][object_id] = oid;
                if (gEditingObject[playerid][mode] == OED_NONE) gEditingObject[playerid][mode] = OED_MOVE_XY;
                gEditingObject[playerid][movestep] = 0.05;
                gEditingObject[playerid][rotatestep] = 1.0;
                
                format(msg, sizeof msg, "Object '%s' (ModelID: %d ObjectID: %d) selected", gObjects[oid][Name], gObjects[oid][ModelID], oid);
                SystemMessage(playerid, msg, COLOR_YELLOW);
                return 1;
            } else {
                format(msg, sizeof msg, "Objekt '%s' not found", name);
                SystemMessage(playerid, msg, COLOR_YELLOW);
                return 1;
            }
        }
        
        //objekt an player pappen
        if (strcmp(cmd, "/ostick", true) == 0) {
            new Float:distance;
            syntax = "SYNTAX: /ostick <distance>";
            
            //distance
            cmd = strtok(cmdtext, idx);
            if (!(strlen(cmd))) {
                distance = 2;
            } else {
                distance = strflt(cmd);
            }
            
            if (!(gCameraSetTimer[playerid] == 0)) {
                KillTimer(gCameraSetTimer[playerid]);
                gCameraSetTimer[playerid] = 0;
                SetCameraBehindPlayer(playerid);
            }
            
            TogglePlayerControllable(playerid, 1);
            
            gEditingObject[playerid][StickDistance] = distance;
            gEditingObject[playerid][stuck] = true;
            
            AttachObjectToPlayer(gEditingObject[playerid][object_id],playerid, 0, gEditingObject[playerid][StickDistance], 0, 0, 0, 0);
            return 1;
        }
        
        //objeckt lösen
        if (strcmp(cmd, "/orelease", true) == 0) {
            new oid;
            new model_id;
            new Float:x2, Float:y2;
            new objname[MAX_STRING];
            
            if (gEditingObject[playerid][stuck]) {
                gEditingObject[playerid][stuck] = false;
                
                oid = gEditingObject[playerid][object_id];
                model_id = gObjects[oid][ModelID];
                format(objname, sizeof objname, "%s", gObjects[oid][Name]);
                
                x2 = x + (gEditingObject[playerid][StickDistance] * floatsin(-angle, degrees));
                y2 = y + (gEditingObject[playerid][StickDistance] * floatcos(-angle, degrees));
                
                DestroyObject(oid);
                
                oid = AddNewObjectToScript(model_id, x2, y2, z, 0, 0, angle, objname);
                gEditingObject[playerid][object_id] = oid;
                gEditingObject[playerid][mode] = OED_MOVE_XY;
                gEditingObject[playerid][movestep] = 0.05;
                gEditingObject[playerid][rotatestep] = 1.0;
                gObjects[oid][savetofile] = true;
                
                SaveObjects();
            }
            return 1;
        }
        
        //multiplikator setzen
        if (strcmp(cmd, "/ofaktor", true) == 0) {
            syntax = "SYNTAX:  /ofaktor [faktor]";
            new Float:mul;
            
            //mul
            cmd = strtok(cmdtext, idx);
            if (!(strlen(cmd))) {
                SystemMessage(playerid, syntax, COLOR_YELLOW);
                return 1;
            } else {
                mul = strflt(cmd);
            }
            
            gEditingObject[playerid][EditMultiplier] = mul;
            format(msg, sizeof msg, "New multiplier set: %f", mul);
            SystemMessage(playerid, msg, COLOR_GREEN);
            return 1;
        }
    }
    
    return 0;
}

/*---------------------------------------------------------------------------------------------------*/

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
    new msg[MAX_STRING];
    new axis_updown, axis_leftright;
    new editmode;
    new Float:value;    
    new Float:x, Float:y, Float:z, Float:angle;
    
    new obj_id = gEditingObject[playerid][object_id];
    
    if (IsPlayerInAnyVehicle(playerid)) {
        GetVehiclePos(GetPlayerVehicleID(playerid),x, y, z);
        GetVehicleZAngle(GetPlayerVehicleID(playerid), angle);
    } else {
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, angle);
    }
    
    if (IsPlayerAdmin(playerid)) {
        if (!(IsPlayerInAnyVehicle(playerid))) {
            if (!(gEditingObject[playerid][object_id] == 0)) {
                new oid = gEditingObject[playerid][object_id];
                
                if ((gEditingObject[playerid][domove]) && (!gPlayerMenu[playerid]))  {
                    switch(gEditingObject[playerid][mode]) {
                    case OED_MOVE_XY:
                        {
                            editmode = OED_MOVE;
                            axis_updown = AXIS_Y;
                            axis_leftright = AXIS_X;
                            value = gEditingObject[playerid][movestep];
                        }
                    case OED_MOVE_Z:
                        {
                            editmode = OED_MOVE;
                            axis_updown = AXIS_Z;
                            axis_leftright = AXIS_NONE;
                            value = gEditingObject[playerid][movestep];
                        }
                    case OED_ROTATE_XY:
                        {
                            editmode = OED_ROTATE;
                            axis_updown = AXIS_X;
                            axis_leftright = AXIS_Y;
                            value = gEditingObject[playerid][rotatestep];
                        }
                    case OED_ROTATE_Z:
                        {
                            editmode = OED_ROTATE;
                            axis_updown = AXIS_NONE;
                            axis_leftright = AXIS_Z;
                            value = gEditingObject[playerid][rotatestep];
                        }
                    }
                    
                    if (!(gObjectEditTimer[playerid] == 0)) {
                        axis_updown = AXIS_NONE;
                        axis_leftright = AXIS_NONE;
                    }
                    
                    //hoch+runter
                    if (newkeys & VKEY_UP) {
                        if (editmode == OED_ROTATE) {
                            if (!(axis_updown == AXIS_NONE)) gObjectEditTimer[playerid] = SetTimerEx("ObjectEditTimer", 50, 1, "iiif", playerid, editmode, axis_updown, value);
                        } else if (editmode == OED_MOVE) {
                            switch (axis_updown) {
                            case AXIS_Y: MoveObject(oid, gObjects[oid][obj_x],gObjects[oid][obj_y]+2000,gObjects[oid][obj_z],value*gEditingObject[playerid][EditMultiplier]*10);
                            case AXIS_Z: MoveObject(oid, gObjects[oid][obj_x],gObjects[oid][obj_y],gObjects[oid][obj_z]+2000,value*gEditingObject[playerid][EditMultiplier]*10);
                            }
                        }
                    }
                    if (newkeys & VKEY_DOWN) {
                        if (editmode == OED_ROTATE) {
                            if (!(axis_updown == AXIS_NONE)) gObjectEditTimer[playerid] = SetTimerEx("ObjectEditTimer", 50, 1, "iiif", playerid, editmode, axis_updown, -value);
                        } else if (editmode == OED_MOVE) {
                            switch (axis_updown) {
                            case AXIS_Y: MoveObject(oid, gObjects[oid][obj_x],gObjects[oid][obj_y]-2000,gObjects[oid][obj_z],value*gEditingObject[playerid][EditMultiplier]*10);
                            case AXIS_Z: MoveObject(oid, gObjects[oid][obj_x],gObjects[oid][obj_y],gObjects[oid][obj_z]-2000,value*gEditingObject[playerid][EditMultiplier]*10);
                            }
                        }
                    }
                    //links+rechts
                    if (newkeys & VKEY_LEFT) {
                        if (editmode == OED_ROTATE) {
                            if (!(axis_leftright == AXIS_NONE)) gObjectEditTimer[playerid] = SetTimerEx("ObjectEditTimer", 50, 1, "iiif", playerid, editmode, axis_leftright, -value);
                        } else if (editmode == OED_MOVE) {
                            switch (axis_leftright) {
                            case AXIS_X: MoveObject(oid, gObjects[oid][obj_x]-2000,gObjects[oid][obj_y],gObjects[oid][obj_z],value*gEditingObject[playerid][EditMultiplier]*10);
                            }
                        }
                    }
                    if (newkeys & VKEY_RIGHT) {
                        if (editmode == OED_ROTATE) {
                            if (!(axis_leftright == AXIS_NONE)) gObjectEditTimer[playerid] = SetTimerEx("ObjectEditTimer", 50, 1, "iiif", playerid, editmode, axis_leftright, value);
                        } else if (editmode == OED_MOVE) {
                            switch (axis_leftright) {
                            case AXIS_X: MoveObject(oid, gObjects[oid][obj_x]+2000,gObjects[oid][obj_y],gObjects[oid][obj_z],value*gEditingObject[playerid][EditMultiplier]*10);
                            }
                        }
                    }
                    
                    
                    if ((oldkeys & VKEY_UP) | 
                        (oldkeys & VKEY_DOWN) |
                        (oldkeys & VKEY_LEFT) |
                        (oldkeys & VKEY_RIGHT))  {
                        
                        if (!(gObjectEditTimer[playerid] == 0)) {
                            KillTimer(gObjectEditTimer[playerid]);
                            gObjectEditTimer[playerid] = 0;
                        }
                        
                        StopObject(oid);
                        SaveObjects();
                    }
                }

                if (newkeys & KEY_WALK) {
                    if (!(obj_id == 0)) {
                        format(msg, sizeof msg, "- %s -", gObjects[obj_id][Name]);
                        gMenus[playerid] = CreateMenu(msg, 1, 350, 200, 250, 0);
                        if (gEditingObject[playerid][stuck]) {
                            AddMenuItem(gMenus[playerid], 0, "Detach from player");
                            gMenuMode[playerid] = MM_SELECT_EDITMODE_DETACHONLY;
                        } else {
                            AddMenuItem(gMenus[playerid], 0, "Attach to player");
                            AddMenuItem(gMenus[playerid], 0, "Move on X/Y Axis");
                            AddMenuItem(gMenus[playerid], 0, "Move on Z Axis");
                            AddMenuItem(gMenus[playerid], 0, "Rotate on X/Y Axis");
                            AddMenuItem(gMenus[playerid], 0, "Rotate on Z Axis");
                            AddMenuItem(gMenus[playerid], 0, "Copy");
                            AddMenuItem(gMenus[playerid], 0, "Delete");
                            AddMenuItem(gMenus[playerid], 0, "Multiplier");
                            AddMenuItem(gMenus[playerid], 0, "Cancel");
                            
                            gMenuMode[playerid] = MM_SELECT_EDITMODE;
                        }
                        if (!(gObjectEditTimer[playerid] == 0)) {
                            KillTimer(gObjectEditTimer[playerid]);
                            gObjectEditTimer[playerid] = 0;
                        }
                        
                        StopObject(oid);
                        SaveObjects();
                        
                        TogglePlayerControllable(playerid, 0);
                        ShowMenuForPlayer(gMenus[playerid], playerid);
                        gPlayerMenu[playerid] = true;
                    }
                }
                
                if (newkeys & KEY_CROUCH) {
                    gEditingObject[playerid][domove] = !gEditingObject[playerid][domove];
                    if (gEditingObject[playerid][domove]) {
                        format(msg, sizeof msg, "Movement enabled: %s", gObjects[gEditingObject[playerid][object_id]][Name]);
                        OnPlayerCommandText(playerid, "/orelease");
                        TogglePlayerControllable(playerid, 0);
                        if (gCameraSetTimer[playerid] == 0) gCameraSetTimer[playerid] = SetTimerEx("SetObjectCoords", 25, 1, "ii", playerid, oid);
                    } else {
                        if (!(gObjectEditTimer[playerid] == 0)) {
                            KillTimer(gObjectEditTimer[playerid]);
                            gObjectEditTimer[playerid] = 0;
                        }
                        
                        if (!(gCameraSetTimer[playerid] == 0)) {
                            KillTimer(gCameraSetTimer[playerid]);
                            gCameraSetTimer[playerid] = 0;
                            SetCameraBehindPlayer(playerid);
                        }
                        
                        StopObject(oid);
                        SaveObjects();
                        
                        format(msg, sizeof msg, "Movement disabled: %s", gObjects[gEditingObject[playerid][object_id]][Name]);
                        TogglePlayerControllable(playerid, 1);
                    }
                    SystemMessage(playerid, msg, COLOR_YELLOW);
                }   
            }
        }
    }
    
    return 1;
}

/*---------------------------------------------------------------------------------------------------*/

public OnPlayerExitedMenu(playerid) {
    DestroyMenu(gMenus[playerid]);
    gPlayerMenu[playerid] = false;
    
    TogglePlayerControllable(playerid, !(gEditingObject[playerid][domove]) * true);
    return 1;
}

/*---------------------------------------------------------------------------------------------------*/

public OnPlayerSelectedMenuRow(playerid, row) {
    TogglePlayerControllable(playerid, !(gEditingObject[playerid][domove]) * true);
    new obj_id = gEditingObject[playerid][object_id];
    
    DestroyMenu(gMenus[playerid]);
    gPlayerMenu[playerid] = false;
    
    switch (gMenuMode[playerid]) {
    case MM_SELECT_EDITMODE:
        {
            switch (row) {
            case 0: //"Attach to player",
                {
                    OnPlayerCommandText(playerid, "/ostick");
                }
            case 1: //"Move on X/Y Axis"
                {
                    gEditingObject[playerid][domove] = true;
                    TogglePlayerControllable(playerid, 0);
                    if (gCameraSetTimer[playerid] == 0) gCameraSetTimer[playerid] = SetTimerEx("SetObjectCoords", 25, 1, "ii", playerid, obj_id);
                    OnPlayerCommandText(playerid, "/omode m_xy");
                }
            case 2: //"Move on Z Axis"
                {
                    gEditingObject[playerid][domove] = true;
                    TogglePlayerControllable(playerid, 0);
                    if (gCameraSetTimer[playerid] == 0) gCameraSetTimer[playerid] = SetTimerEx("SetObjectCoords", 25, 1, "ii", playerid, obj_id);
                    OnPlayerCommandText(playerid, "/omode m_z");
                }
            case 3: //"Rotate on X/Y Axis"
                {
                    gEditingObject[playerid][domove] = true;
                    TogglePlayerControllable(playerid, 0);
                    if (gCameraSetTimer[playerid] == 0) gCameraSetTimer[playerid] = SetTimerEx("SetObjectCoords", 25, 1, "ii", playerid, obj_id);
                    OnPlayerCommandText(playerid, "/omode r_xy");
                }
            case 4: //"Rotate on Z Axis"
                {
                    gEditingObject[playerid][domove] = true;
                    TogglePlayerControllable(playerid, 0);
                    if (gCameraSetTimer[playerid] == 0) gCameraSetTimer[playerid] = SetTimerEx("SetObjectCoords", 25, 1, "ii", playerid, obj_id);
                    OnPlayerCommandText(playerid, "/omode r_z");
                }
            case 5: //"Copy"
                {
                    new objname[MAX_STRING];
                    format(objname, sizeof objname, "/ocopy cpy_%s", gObjects[obj_id][Name]);
                    OnPlayerCommandText(playerid, objname);
                }
            case 6: //"Delete"
                {
                    OnPlayerCommandText(playerid, "/odel");
                }
            case 7: //"Multiplier"
                {
                    gMenus[playerid] = CreateMenu("Multipliers", 1, 350,180, 250, 0);
                    new temp[MAX_STRING];
                    new items[10][MAX_STRING] = {
                    "0.005x",
                    "0.05x",
                    "0.5x",
                    "1x",
                    "2x",
                    "5x",
                    "10x",
                    "20x",
                    "25x",
                    "45x"
                    };
                    
                    temp = "~w~";
                    strcat(temp, items[gSelectedMultiplier[playerid]]);
                    items[gSelectedMultiplier[playerid]] = temp;
                    
                    for(new i=0;i<=9;i++) {
                        AddMenuItem(gMenus[playerid], 0, items[i]);
                    }
                    
                    gMenuMode[playerid] = MM_SELECT_MULTIPLIER;
                    TogglePlayerControllable(playerid, 0);
                    ShowMenuForPlayer(gMenus[playerid], playerid);
                    gPlayerMenu[playerid] = true;
                }
            case 8: //"Cancel"
                {
                    if (!(gObjectEditTimer[playerid] == 0)) {
                        KillTimer(gObjectEditTimer[playerid]);
                        gObjectEditTimer[playerid] = 0;
                    }
                    
                    if (!(gCameraSetTimer[playerid] == 0)) {
                        KillTimer(gCameraSetTimer[playerid]);
                        gCameraSetTimer[playerid] = 0;
                        SetCameraBehindPlayer(playerid);
                    }
                    
                    StopObject(obj_id);
                    SaveObjects();
                }
            }
        }
    case MM_SELECT_EDITMODE_DETACHONLY:
        {
            switch (row) {
            case 0: //"Detach from player",
                {
                    OnPlayerCommandText(playerid, "/orelease");
                }
            }    
        }
    case MM_SELECT_MULTIPLIER:
        {
            switch (row) {
            case 0: gEditingObject[playerid][EditMultiplier]  = 0.005;       //"0.005x",
            case 1: gEditingObject[playerid][EditMultiplier]  = 0.050;       //"0.05x",
            case 2: gEditingObject[playerid][EditMultiplier]  = 0.5;       //"0.5x",
            case 3: gEditingObject[playerid][EditMultiplier]  = 1;       //"1x",
            case 4: gEditingObject[playerid][EditMultiplier]  = 2;       //"2x",
            case 5: gEditingObject[playerid][EditMultiplier]  = 5;       //"5x",
            case 6: gEditingObject[playerid][EditMultiplier]  = 10;       //"10x",
            case 7: gEditingObject[playerid][EditMultiplier]  = 20;       //"20x",
            case 8: gEditingObject[playerid][EditMultiplier]  = 25;       //"25x",
            case 9: gEditingObject[playerid][EditMultiplier]  = 45;       //"45x"
            }
            
            gSelectedMultiplier[playerid] = row;
            TogglePlayerControllable(playerid, !gEditingObject[playerid][domove]);
        }
    }
    
    DestroyMenu(gMenus[playerid]);
    
    return 1;
}

/*---------------------------------------------------------------------------------------------------*/

stock SystemMessage (playerid, text[], color) {
    new msg[MAX_STRING];
    
    format(msg, sizeof msg, "* %s", text);
    
    if (playerid == -1) {   //an alle
        SendClientMessageToAll(color, msg);
    } else {
        if (IsPlayerConnected(playerid)) {
            SendClientMessage(playerid, color, msg);
        }
    }
    
    return 1;
}

/*---------------------------------------------------------------------------------------------------*/

stock PrintError(text[], type) {
    switch(type) {
    case 0: printf("* ERROR:    %s", text);
    case 1: printf("* WARNING:  %s", text);
    }
    
    return 1;
}

/*===================================================================================================*/
/* Objektfunktionen */
stock ReadObjects() {
    new File:hFile;
    new line[MAX_STRING];
    new commentpos;
    new values[8][MAX_STRING];
    
    new newoid;
    
    new modelid;
    new Float:x;
    new Float:y;
    new Float:z;
    new Float:rotx;
    new Float:roty;
    new Float:rotz;
    new ObjectName[MAX_STRING];
    
    if (!(fexist("BREAD_OED.TXT"))) {
        PrintError("'scriptfiles/BREAD_OED.TXT' not found; skipping objects", 1);
        return 0;
    }
    
    hFile = fopen("BREAD_OED.TXT", io_read);
    
    while (fread(hFile, line)) {
        strmid(line,line,0,strlen(line)-2);
        
        commentpos = strfind(line,";",true);
        if (commentpos!=-1) {
            strmid(line,line,0,commentpos);
        }
        
        if (strlen(line) > 0) {
            split(line, values, ',', sizeof values);
            
            //modelid
            modelid = strval(values[0]);
            //spawn X
            x = strflt(values[1]);
            //spawn Y
            y = strflt(values[2]);
            //spawn Z
            z = strflt(values[3]);
            //rotation x
            rotx = strflt(values[4]);
            //rotation y
            roty = strflt(values[5]);
            //rotation z
            rotz = strflt(values[6]);
            //name
            ObjectName = values[7];
            
            if (gObjectCount < MAX_OBJECTS) {
                newoid = CreateObject(modelid, x, y, z, rotx, roty, rotz);
                
                gObjects[newoid][ModelID] = modelid;
                gObjects[newoid][obj_x] = x;
                gObjects[newoid][obj_y] = y;
                gObjects[newoid][obj_z] = z;
                gObjects[newoid][rot_x] = rotx;
                gObjects[newoid][rot_y] = roty;
                gObjects[newoid][rot_z] = rotz;
                gObjects[newoid][Name] = ObjectName;
                
                gObjects[newoid][savetofile] = true;
                gObjectCount++;
            }
        }
    }
    
    fclose(hFile);
    
    return 1;
}


/*---------------------------------------------------------------------------------------------------*/

stock SaveObjects() {
    new File:hFile;
    new line[MAX_STRING];
    
    hFile = fopen("BREAD_OED.TXT", io_write);
    
    fwrite(hFile,";ModelID,x,y,z,rotx,roty,rotz,name\r\n");
    for (new i=1;i<=gObjectCount;i++) {
        if (gObjects[i][savetofile]) {
            format(line, sizeof line, "%d,%f,%f,%f,%f,%f,%f,%s\r\n", gObjects[i][ModelID], gObjects[i][obj_x], gObjects[i][obj_y], gObjects[i][obj_z], gObjects[i][rot_x], gObjects[i][rot_y], gObjects[i][rot_z], gObjects[i][Name]);
            
            fwrite(hFile, line);
        }
    }
    
    fclose(hFile);

    return 1;
}

/*---------------------------------------------------------------------------------------------------*/

stock AddNewObjectToScript(modelid,Float:x,Float:y,Float:z,Float:rotx,Float:roty,Float:rotz,ObjectName[MAX_STRING]) {
    new newoid;
    
    if (gObjectCount < MAX_OBJECTS) {
        newoid = CreateObject(modelid, x, y, z, rotx, roty, rotz);
        
        gObjects[newoid][ModelID] = modelid;
        gObjects[newoid][obj_x] = x;
        gObjects[newoid][obj_y] = y;
        gObjects[newoid][obj_z] = z;
        gObjects[newoid][rot_x] = rotx;
        gObjects[newoid][rot_y] = roty;
        gObjects[newoid][rot_z] = rotz;
        gObjects[newoid][Name] = ObjectName;
        
        gObjectCount++;
        
        return newoid;
    } else {
        return 0;
    }
}

/*===================================================================================================*/
/* Stringfunktionen */
stock strtok(const string[], &index) {
    new length = strlen(string);
    while ((index < length) && (string[index] <= ' '))
    {
        index++;
    }
    new offset = index;
    new result[20];
    while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
    {
        result[index - offset] = string[index];
        index++;
    }
    result[index - offset] = EOS;
    return result;
}

/*---------------------------------------------------------------------------------------------------*/

stock Float:strflt(string[]) {
    new dotpos,absval,decval;
    new abs[255],dec[255];
    new Float:value;

    dotpos = strfind(string,".");
    if (dotpos != -1) {
        strmid(abs,string,0,dotpos);
        strmid(dec,string,dotpos+1,strlen(string));

        absval = strval(abs);
        decval = strval(dec);

        value = float(absval);
        value = floatadd(value,(floatdiv(float(decval),float(power(10, strlen(dec))))));
    } else {
        absval = strval(string);
        value = float(absval);
    }
    return value;
}

/*---------------------------------------------------------------------------------------------------*/

stock power(base, exp) {
    new i,value;
    value = base;
    for (i=1;i<exp;i++) {
        value = value * base;
    }
    return value;
}

/*---------------------------------------------------------------------------------------------------*/

stock split(const strsrc[], strdest[][], delimiter, maxitems) {
    new i, li;
    new aNum;
    new len;
    new remdel;
    
    while((i <= strlen(strsrc)) && (aNum < maxitems)){
        if(strsrc[i]==0x22){    // 0x22 = " 
            if(delimiter != 0x22){
                remdel = delimiter;
                delimiter = 0x22;
                i++;
                li++;  
            }
        }
        if((strsrc[i]==delimiter) || (i==strlen(strsrc))){
            len = strmid(strdest[aNum], strsrc, li, i, 128);
            strdest[aNum][len] = 0; // zero terminate string
            li = i+1;
            aNum++;
            if(delimiter==0x22){
                delimiter = remdel;
                li++;
                i++;
            }
        }
        i++;
    }
    
    return 1;
}

/*---------------------------------------------------------------------------------------------------*/

stock GetPlayerNearestObjects(playerid) {
    new Float:x1, Float:y1, Float:z1;
    new Float:x2, Float:y2, Float:z2;
    new Float:distances[MAX_OBJECTS][2];
    new j;
    new objects[24];
    
    GetPlayerPos(playerid, x1, y1, z1);
    
    for (new i=1;i<=gObjectCount;i++) {
        GetObjectPos(i, x2, y2, z2);
        distances[i][0] = GetDistanceBetweenCoords(x1, y1, z1, x2, y2, z2);
        distances[i][1] = float(i);
    }
    
    distances = FloatBubbleSort(distances, MAX_OBJECTS);
    
    for (new i=0;i<MAX_OBJECTS;i++) {
        if (!(floatround(distances[i][1]) == 0)) {
            if (j < 24) {
                j++;
                objects[j] = floatround(distances[i][1]);
            }
        }
    }
    
    return objects;
}

/*---------------------------------------------------------------------------------------------------*/

stock Float:GetDistanceBetweenCoords(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2) {
    return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

/*---------------------------------------------------------------------------------------------------*/

stock Float:FloatBubbleSort(Float:lArray[MAX_OBJECTS][2], lArraySize) {
    new Float:lSwap;
    new bool:bSwapped = true;
    new I;
    
    while(bSwapped) {
        bSwapped = false;
        for(I = 0; I < lArraySize - 1; I++) {
            if(lArray[I+1][0] < lArray[I][0]) {            
                lSwap = lArray[I][0];
                lArray[I][0] = lArray[I+1][0];
                lArray[I+1][0] = lSwap;
                
                lSwap = lArray[I][1];
                lArray[I][1] = lArray[I+1][1];
                lArray[I+1][1] = lSwap;
                
                bSwapped = true;
            }
        }
    }
    
    return lArray;
}

/*---------------------------------------------------------------------------------------------------*/

public ObjectEditTimer(playerid, editmode, axis, Float:value){
    new Float:x, Float:y, Float:z;
    new Float:rotx, Float:roty, Float:rotz;
    new oid;
        
    if ((gEditingObject[playerid][domove]) && (gEditingObject[playerid][object_id] > 0)) {
        value = floatmul(value, gEditingObject[playerid][EditMultiplier]);
        
        oid = gEditingObject[playerid][object_id];
        
        GetObjectPos(oid, x, y, z);
        GetObjectRot(oid, rotx, roty, rotz);
        
        switch(axis) {
        case AXIS_X:
            {
                x = floatadd(x, value);
                rotx = floatadd(rotx, value);
            }
        case AXIS_Y:
            {
                y = floatadd(y, value);
                roty = floatadd(roty, value);
            }
        case AXIS_Z:
            {
                z = floatadd(z, value);
                rotz = floatadd(rotz, value);
            }
        }
        
        switch (editmode) {
        case OED_MOVE:
            {
                SetObjectPos(oid, x, y, z);
                gObjects[oid][obj_x] = x;
                gObjects[oid][obj_y] = y;
                gObjects[oid][obj_z] = z;
            }
        case OED_ROTATE:
            {
                SetObjectRot(oid, rotx, roty, rotz);
                gObjects[oid][rot_x] = rotx;
                gObjects[oid][rot_y] = roty;
                gObjects[oid][rot_z] = rotz;
            }
        }
    }
    
    return 1;
}

/*---------------------------------------------------------------------------------------------------*/

public UpDownLeftRightAdditionTimer() {
    new keys, leftright, updown;
    new oldkeys;
    
    for (new i=0;i<MAX_PLAYERS;i++) {
        if (IsPlayerConnected(i)) {
            GetPlayerKeys(i, keys, updown, leftright);
            
            //links+rechts
            if (leftright == KEY_LEFT) {
                if (!(gLastPlayerKeys[i][0] == leftright)) OnPlayerKeyStateChange(i, VKEY_LEFT, 0);
            } else if (leftright == KEY_RIGHT) {
                if (!(gLastPlayerKeys[i][0] == leftright)) OnPlayerKeyStateChange(i, VKEY_RIGHT, 0);
            } else {
                if (gLastPlayerKeys[i][0] == KEY_LEFT) {
                    oldkeys = VKEY_LEFT;
                } else if (gLastPlayerKeys[i][0] == KEY_RIGHT) {
                    oldkeys = VKEY_DOWN;
                }
                if (!(gLastPlayerKeys[i][0] == leftright)) OnPlayerKeyStateChange(i, 0, oldkeys);
            }
            
            //hoch+runter
            if (updown == KEY_UP) {
                if (!(gLastPlayerKeys[i][1] == updown)) OnPlayerKeyStateChange(i, VKEY_UP, 0);
            } else if (updown == KEY_DOWN) {
                if (!(gLastPlayerKeys[i][1] == updown)) OnPlayerKeyStateChange(i, VKEY_DOWN, 0);
            } else {
                if (gLastPlayerKeys[i][1] == KEY_UP) {
                    oldkeys = VKEY_UP;
                } else if (gLastPlayerKeys[i][1] == KEY_DOWN){
                    oldkeys = VKEY_DOWN;
                }
                if (!(gLastPlayerKeys[i][1] == updown)) OnPlayerKeyStateChange(i, 0, oldkeys);
            }
            
            gLastPlayerKeys[i][0] = leftright;
            gLastPlayerKeys[i][1] = updown;
        }    
    } 
    
    return 1;
}

/*---------------------------------------------------------------------------------------------------*/

public SetObjectCoords(playerid, obj_id) {            
    new Float:x, Float:y, Float:z;
    
    GetObjectPos(obj_id, x, y, z);
    
    if (!((x == gObjects[obj_id][obj_x]) &&
          (y == gObjects[obj_id][obj_y]) &&
          (z == gObjects[obj_id][obj_z]))) {
          
        gObjects[obj_id][obj_x] = x;
        gObjects[obj_id][obj_y] = y;
        gObjects[obj_id][obj_z] = z;
    }
    
    GetPlayerPos(playerid, x, y, z);
    SetPlayerCameraPos(playerid, x, y, z);
    SetPlayerCameraLookAt(playerid, gObjects[obj_id][obj_x], gObjects[obj_id][obj_y], gObjects[obj_id][obj_z]);
    
    return 1;
}
