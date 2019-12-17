/*===================================================================================================*\
||===================================================================================================||
||                    ________    ________    ___    _    ______     ______     ________                 ||
||              \    |   _____|  |  ____  |  |   \  | |  |   _  \   |  _   \   |  ____  |    /           ||
||      ======== \   |  |_____   | |____| |  | |\ \ | |  |  | |  |  | |_|  /   | |____| |   / ========   ||
||                |  | _____  |  |  ____  |  | | \ \| |  |  | |  |  |  _  \    |  ____  |  |             ||
||      ======== /    ______| |  | |    | |  | |  \ \ |  |  |_|  |  | |  \ \   | |    | |   \ ========   ||
||              /    |________|  |_|    |_|  |_|   \__|  |______/   |_|   \_|  |_|    |_|    \           ||
||                                                                                                   ||
||===================================================================================================||
||                          Created on the 10th of March 2009 by =>Sandra<=                          ||
||                                    Do NOT remove my credits!!                                     ||
\*===================================================================================================*/


#include <a_samp>

#define MAX_CCTVS 100
#define MAX_CCTVMENUS 10  //(This number should be MAX_CCTVS divided by 10  (round up))

//CameraInfo
new TotalCCTVS;
new CameraName[MAX_CCTVS][32];
new Float:CCTVLA[MAX_PLAYERS][3];  //CCTV LookAt
new Float:CCTVLAO[MAX_CCTVS][3];
new Float:CCTVRadius[MAX_PLAYERS]; //CCTV Radius
new Float:CCTVDegree[MAX_PLAYERS] = 0.0;
new Float:CCTVCP[MAX_CCTVS][4]; //CCTV CameraPos
new CurrentCCTV[MAX_PLAYERS] = -1;

//TextDraw
new Text:TD;

//Menus:
new Menu:CCTVMenu[MAX_CCTVMENUS];
new MenuType[MAX_CCTVMENUS];
new TotalMenus;
new PlayerMenu[MAX_PLAYERS];

enum LP
{
        Float:LX,
        Float:LY,
        Float:LZ,
        Float:LA,
        LInterior
}
new Spawned[MAX_PLAYERS];
new LastPos[MAX_PLAYERS][LP];

new KeyTimer[MAX_PLAYERS];

public OnFilterScriptInit()
{

        //Put All AddCCTV-lines here below:
        //======================================================
        //======================================================
        AddCCTV("LS Grovestreet", 2491.7839, -1666.6194, 46.3232, 0.0);
        AddCCTV("LS Downtown", 1102.6440, -837.8973, 122.7000, 180.0);
        AddCCTV("SF Wang Cars", -1952.4282,285.9786,57.7031, 90.0);
        AddCCTV("SF Airport", -1275.8070, 52.9402, 82.9162, 0.0);
        AddCCTV("SF Crossroad", -1899.0861,731.0627,65.2969, 90.0);
        AddCCTV("SF Tower", -1753.6606,884.7520,305.8750, 150.0);
        AddCCTV("LV The Strip 1", 2137.2390, 2143.8286, 30.6719, 270.0);
        AddCCTV("LV The Strip 2", 1971.7627, 1423.9323, 82.1563, 270.0);
    AddCCTV("Mount Chiliad", -2432.5852, -1620.1143, 546.8554, 270.0);
        AddCCTV("Sherman Dam", -702.9260, 1848.8094, 116.0507, 0.0);
        AddCCTV("Desert", 35.1291, 2245.0901, 146.6797, 310.0);
        AddCCTV("Query", 588.1079,889.4715,-14.9023, 270.0);
        AddCCTV("Water", 635.6223,498.1748,20.3451, 90.0);
        //======================================================
    //======================================================

        //Creating Textdraw
        TD = TextDrawCreate(160, 400, "~y~Keys:~n~Arrow-Keys: ~w~Move The Camera~n~~y~Sprint-Key: ~w~Speed Up~n~~y~Crouch-Key: ~w~Exit Camera");
    TextDrawLetterSize(TD, 0.4, 0.9);
    TextDrawSetShadow(TD, 0);
    TextDrawUseBox(TD,1);
        TextDrawBoxColor(TD,0x00000055);
        TextDrawTextSize(TD, 380, 400);

        //Creating Menu's
        new Count, Left = TotalCCTVS;
        for(new menu; menu<MAX_CCTVMENUS; menu++)
        {
            if(Left > 12)
            {
                CCTVMenu[menu] = CreateMenu("Choose Camera:", 1, 200, 100, 220);
                TotalMenus++;
                MenuType[menu] = 1;
                for(new i; i<11; i++)
                {
                        AddMenuItem(CCTVMenu[menu], 0, CameraName[Count]);
                        Count++;
                        Left--;
                        }
                        AddMenuItem(CCTVMenu[menu], 0, "Next");
                }
                else if(Left<13 && Left > 0)
                {
                    CCTVMenu[menu] = CreateMenu("Choose Camera:", 1, 200, 100, 220);
                    TotalMenus++;
                    MenuType[menu] = 2;
                    new tmp = Left;
                for(new i; i<tmp; i++)
                {
                        AddMenuItem(CCTVMenu[menu], 0, CameraName[Count]);
                        Count++;
                        Left--;
                        }
                }
        }

        print("\n\n-----------------------------------------------");
        print(" Remote CCTV Filterscript by =>Sandra<= Loaded!");
        print("-----------------------------------------------\n\n");
        return 1;
}

public OnFilterScriptExit()
{
        TextDrawHideForAll(TD);
        TextDrawDestroy(TD);
        for(new i; i<TotalMenus; i++)
        {
                DestroyMenu(CCTVMenu[i]);
        }
        return 1;
}

public OnPlayerConnect(playerid)
{
    Spawned[playerid] = 0;
    CurrentCCTV[playerid] = -1;
        return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
        if(CurrentCCTV[playerid] > -1)
        {
            KillTimer(KeyTimer[playerid]);
            TextDrawHideForPlayer(playerid, TD);
        }
        CurrentCCTV[playerid] = -1;
        return 1;
}

public OnPlayerSpawn(playerid)
{
        Spawned[playerid] = 1;
        return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
    Spawned[playerid] = 0;
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
        if (strcmp("/cctv", cmdtext, true) == 0)
        {
                if(Spawned[playerid] == 1)
                {
                    PlayerMenu[playerid] = 0;
                    TogglePlayerControllable(playerid, 0);
                        ShowMenuForPlayer(CCTVMenu[0], playerid);
                }
                else
                {
                    SendClientMessage(playerid, 0xFF0000AA, "Please spawn first!");
                }
                return 1;
        }

        if (strcmp("/exitcctv", cmdtext, true) == 0)
        {
            if(CurrentCCTV[playerid] > -1)
            {
                    SetPlayerPos(playerid, LastPos[playerid][LX], LastPos[playerid][LY], LastPos[playerid][LZ]);
                        SetPlayerFacingAngle(playerid, LastPos[playerid][LA]);
                SetPlayerInterior(playerid, LastPos[playerid][LInterior]);
                    TogglePlayerControllable(playerid, 1);
                    KillTimer(KeyTimer[playerid]);
                    SetCameraBehindPlayer(playerid);
                    TextDrawHideForPlayer(playerid, TD);
            CurrentCCTV[playerid] = -1;
            return 1;
                }
        }
        return 0;
}


forward CheckKeyPress(playerid);
public CheckKeyPress(playerid)
{
    new keys, updown, leftright;
    GetPlayerKeys(playerid, keys, updown, leftright);
        if(CurrentCCTV[playerid] > -1 && PlayerMenu[playerid] == -1)
        {
            if(leftright == KEY_RIGHT)
                {
                    if(keys == KEY_SPRINT)
                        {
                        CCTVDegree[playerid] = (CCTVDegree[playerid] - 2.0);
                        }
                        else
                        {
                            CCTVDegree[playerid] = (CCTVDegree[playerid] - 0.5);
                        }
                    if(CCTVDegree[playerid] < 0)
                    {
                        CCTVDegree[playerid] = 359;
                        }
                    MovePlayerCCTV(playerid);

                }
            if(leftright == KEY_LEFT)
            {
                if(keys == KEY_SPRINT)
                        {
                        CCTVDegree[playerid] = (CCTVDegree[playerid] + 2.0);
                        }
                        else
                        {
                            CCTVDegree[playerid] = (CCTVDegree[playerid] + 0.5);
                        }
                        if(CCTVDegree[playerid] >= 360)
                    {
                        CCTVDegree[playerid] = 0;
                        }
                MovePlayerCCTV(playerid);

            }
            if(updown == KEY_UP)
            {
                if(CCTVRadius[playerid] < 25)
                {
                        if(keys == KEY_SPRINT)
                                {
                                    CCTVRadius[playerid] =  (CCTVRadius[playerid] + 0.5);
                                MovePlayerCCTV(playerid);
                                }
                                else
                                {
                                    CCTVRadius[playerid] =  (CCTVRadius[playerid] + 0.1);
                                MovePlayerCCTV(playerid);
                                }
                        }
                }
                if(updown == KEY_DOWN)
            {
                        if(keys == KEY_SPRINT)
                        {
                            if(CCTVRadius[playerid] >= 0.6)
                        {
                                    CCTVRadius[playerid] =  (CCTVRadius[playerid] - 0.5);
                                MovePlayerCCTV(playerid);
                                }
                        }
                        else
                        {
                            if(CCTVRadius[playerid] >= 0.2)
                        {
                                    CCTVRadius[playerid] =  (CCTVRadius[playerid] - 0.1);
                                MovePlayerCCTV(playerid);
                                }
                        }
                }
                if(keys == KEY_CROUCH)
                {
                    OnPlayerCommandText(playerid, "/exitcctv");
                }
        }
        MovePlayerCCTV(playerid);
}

stock MovePlayerCCTV(playerid)
{
        CCTVLA[playerid][0] = CCTVLAO[CurrentCCTV[playerid]][0] + (floatmul(CCTVRadius[playerid], floatsin(-CCTVDegree[playerid], degrees)));
        CCTVLA[playerid][1] = CCTVLAO[CurrentCCTV[playerid]][1] + (floatmul(CCTVRadius[playerid], floatcos(-CCTVDegree[playerid], degrees)));
        SetPlayerCameraLookAt(playerid, CCTVLA[playerid][0], CCTVLA[playerid][1], CCTVLA[playerid][2]);
}


stock AddCCTV(name[], Float:X, Float:Y, Float:Z, Float:Angle)
{
        if(TotalCCTVS >= MAX_CCTVS) return 0;
        format(CameraName[TotalCCTVS], 32, "%s", name);
        CCTVCP[TotalCCTVS][0] = X;
        CCTVCP[TotalCCTVS][1] = Y;
        CCTVCP[TotalCCTVS][2] = Z;
        CCTVCP[TotalCCTVS][3] = Angle;
        CCTVLAO[TotalCCTVS][0] = X;
        CCTVLAO[TotalCCTVS][1] = Y;
        CCTVLAO[TotalCCTVS][2] = Z-10;
        TotalCCTVS++;
        return TotalCCTVS-1;
}

SetPlayerToCCTVCamera(playerid, CCTV)
{
        if(CCTV >= TotalCCTVS)
        {
            SendClientMessage(playerid, 0xFF0000AA, "Invald CCTV");
            return 1;
        }
        if(CurrentCCTV[playerid] == -1)
    {
            GetPlayerPos(playerid, LastPos[playerid][LX], LastPos[playerid][LY], LastPos[playerid][LZ]);
                GetPlayerFacingAngle(playerid, LastPos[playerid][LA]);
        LastPos[playerid][LInterior] = GetPlayerInterior(playerid);
        }
        else
        {
                KillTimer(KeyTimer[playerid]);
        }
        CurrentCCTV[playerid] = CCTV;
    TogglePlayerControllable(playerid, 0);
        //SetPlayerPos(playerid, CCTVCP[CCTV][0], CCTVCP[CCTV][1], (CCTVCP[CCTV][2]-50));
        SetPlayerPos(playerid, CCTVCP[CCTV][0], CCTVCP[CCTV][1], -100.0);
        SetPlayerCameraPos(playerid, CCTVCP[CCTV][0], CCTVCP[CCTV][1], CCTVCP[CCTV][2]);
        SetPlayerCameraLookAt(playerid, CCTVLAO[CCTV][0], (CCTVLAO[CCTV][1]+0.2), CCTVLAO[CCTV][2]);
        CCTVLA[playerid][0] = CCTVLAO[CCTV][0];
        CCTVLA[playerid][1] = CCTVLAO[CCTV][1]+0.2;
        CCTVLA[playerid][2] = CCTVLAO[CCTV][2];
        CCTVRadius[playerid] = 12.5;
        CCTVDegree[playerid] = CCTVCP[CCTV][3];
        MovePlayerCCTV(playerid);
    KeyTimer[playerid] = SetTimerEx("CheckKeyPress", 75, 1, "i", playerid);
    TextDrawShowForPlayer(playerid, TD);
        return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
        new Menu:Current = GetPlayerMenu(playerid);
        for(new menu; menu<TotalMenus; menu++)
        {

                if(Current == CCTVMenu[menu])
                {
                    if(MenuType[PlayerMenu[playerid]] == 1)
                    {
                        if(row == 11)
                        {
                            ShowMenuForPlayer(CCTVMenu[menu+1], playerid);
                            TogglePlayerControllable(playerid, 0);
                            PlayerMenu[playerid] = (menu+1);
                                }
                                else
                                {
                                    if(PlayerMenu[playerid] == 0)
                                    {
                                        SetPlayerToCCTVCamera(playerid, row);
                                        PlayerMenu[playerid] = -1;
                                        }
                                        else
                                        {
                                            SetPlayerToCCTVCamera(playerid, ((PlayerMenu[playerid]*11)+row));
                                            PlayerMenu[playerid] = -1;
                                        }
                                }
                        }
                        else
                        {
                            if(PlayerMenu[playerid] == 0)
                            {
                                SetPlayerToCCTVCamera(playerid, row);
                                PlayerMenu[playerid] = -1;
                                }
                                else
                                {
                                    SetPlayerToCCTVCamera(playerid, ((PlayerMenu[playerid]*11)+row));
                                    PlayerMenu[playerid] = -1;
                                }
                        }
                }
        }

        return 1;
}

public OnPlayerExitedMenu(playerid)
{
        TogglePlayerControllable(playerid, 1);
        PlayerMenu[playerid] = -1;
        return 1;
}