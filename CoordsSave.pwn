#include <a_samp>

new SaveMode;
new SaveFile[32];

new Menu: SelectMenu;

#define COLOR_MODE 0x024EFDFF

#define respawn_delay 180

#define FILTERSCRIPT
//------------------------------------------------------------------------------
//=====FILTERSCRIPT=============================================================
//------------------------------------------------------------------------------
#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Coords-Saver by Rafelder");
	print("--------------------------------------\n");
	SendClientMessageToAdmins(COLOR_MODE, "Coords-Saver loaded. Tipe '/savemode [1-7]' to select your savemode.");
	SendClientMessageToAdmins(COLOR_MODE, "You also can use '/savemodemenu' to select the savemode in the menu.");
	
	SelectMenu = Menu:CreateMenu("~w~Savemode Select", 1, 200, 150, 300);
	SetMenuColumnHeader(SelectMenu, 0, "Select your savemode.");
	AddMenuItem(SelectMenu, 0, " Playerclasses");
	AddMenuItem(SelectMenu, 0, " Vehicles");
	AddMenuItem(SelectMenu, 0, " Pickups");
	AddMenuItem(SelectMenu, 0, " Explosion");
	AddMenuItem(SelectMenu, 0, " PlayerCheckpoint");
	AddMenuItem(SelectMenu, 0, " RaceCheckpoint");
	AddMenuItem(SelectMenu, 0, " BlankCoords");
	AddMenuItem(SelectMenu, 0, "=> Exit Menu");
	return 1;
}

public OnFilterScriptExit()
{
	SendClientMessageToAdmins(COLOR_MODE, "Coords-Saver unloaded.");
	for (new i=0; i<MAX_PLAYERS; i++) {
	if (IsPlayerConnected(i))
	HideMenuForPlayer(SelectMenu, i);
	}
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

#endif
//------------------------------------------------------------------------------
//=====(DIS)CONNECT=============================================================
//------------------------------------------------------------------------------
public OnPlayerConnect(playerid)
{
	return 1;
}
//------------------------------------------------------------------------------
//=====CMDS+TEXT================================================================
//------------------------------------------------------------------------------
public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    new cmd[256], idx;
	cmd = strtok(cmdtext, idx);
	
	if (IsPlayerAdmin(playerid)) {
	
	if (strcmp(cmd, "/savemodemenu", true) == 0) {
		ShowMenuForPlayer(SelectMenu, playerid);
		TogglePlayerControllable(playerid, 0);
		return 1;
	}
	
	if (strcmp(cmd, "/savemode", true) == 0) {
	new string[256], mode[256];
	mode = strtok(cmdtext, idx);
	if (!strlen(mode)) {
		SendClientMessage(playerid, COLOR_MODE, "[USAGE]: '/savemode [1-7]'");
	    SendClientMessage(playerid, COLOR_MODE, "[1 = PlayerClass, 2 = Vehicle, 3 = Pickup, 4 = Explosion, 5 = PlayerCheckpoint, 6 = RaceCheckpoint, 7 = Blank Coords]");
	    return 1;
	}
	new gmode = strval(mode);
	if ((gmode < 1) || (gmode > 7)) {
	    SendClientMessage(playerid, COLOR_MODE, "[ERROR]: Savemode must between 1-7");
	    SendClientMessage(playerid, COLOR_MODE, "[1 = PlayerClass, 2 = Vehicle, 3 = Pickup, 4 = Explosion, 5 = PlayerCheckpoint, 6 = RaceCheckpoint, 7 = Blank Coords]");
	    return 1;
	}
	SaveMode = gmode;
	switch(SaveMode) {
	    case 1: SaveFile = "player_coords.txt";
	    case 2: SaveFile = "car_coords.txt";
	    case 3: SaveFile = "pickup_coords.txt";
	    case 4: SaveFile = "xplode_coords.txt";
	    case 5: SaveFile = "playercp_coords.txt";
	    case 6: SaveFile = "racecp_coords.txt";
	    case 7: SaveFile = "blank_coords.txt";
	}
	format(string, 256, "Savemode %d activated.", SaveMode);
	SendClientMessageToAdmins(COLOR_MODE, string);
 	SendClientMessageToAdmins(COLOR_MODE, "[1 = PlayerClass, 2 = Vehicle, 3 = Pickup, 4 = Explosion, 5 = PlayerCheckpoint, 6 = RaceCheckpoint, 7 = Blank Coords]");
	return 1;
	}
	
	if (strcmp(cmd, "/c", true) == 0) {
	if ((!SaveMode) || (SaveMode < 1) || (SaveMode > 7)) {
	    SendClientMessage(playerid, COLOR_MODE, "[ERROR]: No '/savemode' activated!");
	    return 1;
	}
	new text[256];
	text = strtok(cmdtext, idx);
	if (!strlen(text)) {
	SendClientMessage(playerid, COLOR_MODE, "[USAGE]: '/c [text]'");
	return 1;
	}
	new string[256], File:handle;
	handle = fopen(SaveFile, io_append);
	if (handle) {
	    format(string, sizeof(string), "//%s\r\n", text);
	    SendClientMessageToAdmins(COLOR_MODE, string);
		print(string);
		fwrite(handle, string);
		fclose(handle);
	}
	return 1;
	}
	
	if (strcmp(cmd, "/del", true) == 0) {
	if ((!SaveMode) || (SaveMode < 1) || (SaveMode > 7)) {
	    SendClientMessage(playerid, COLOR_MODE, "[ERROR]: No '/savemode' activated!");
	    return 1;
	}
	new string[256], string2[256], File:handle = fopen(SaveFile, io_readwrite);
	if (handle) {
	new File:handle2 = fopen("tmp.txt", io_readwrite);
	while (fread(handle, string)) {
	if (string2[0]) fwrite(handle2, string2);
	string2 = string;
	}
  	fclose(handle);
	fclose(handle2);
	handle = fopen(SaveFile, io_write);
	handle2 = fopen("tmp.txt", io_read);
	while (fread(handle2, string)) {
		fwrite(handle, string);
   	}
   	fclose(handle);
	fclose(handle2);
	fremove("tmp.txt");
	SendClientMessageToAdmins(COLOR_MODE, "Last line deleted");
	}
	return 1;
	}
	
	if (strcmp(cmd, "/savepos", true) == 0) {
	
	if ((!SaveMode) || (SaveMode < 1) || (SaveMode > 7)) {
	    SendClientMessage(playerid, COLOR_MODE, "[ERROR]: No '/savemode' activated!");
	    return 1;
	}
	
    new Float:X, Float:Y, Float:Z, Float:angle;
    new string[256];
    new File:handle = fopen(SaveFile, io_append);
	switch(SaveMode) {
	    case 1: {
		    if (handle) {
		    if (!IsPlayerInAnyVehicle(playerid)) {
			    GetPlayerPos(playerid, X, Y, Z);
			    GetPlayerFacingAngle(playerid, angle);
			    format(string, sizeof(string), "AddPlayerClass( %d, %f, %f, %f, %f, 0, 0, 0, 0, 0, 0);\r\n", GetPlayerSkin(playerid), X, Y, Z, angle);
			    SendClientMessageToAdmins(COLOR_MODE, string);
			    print(string);
		    	fwrite(handle, string);
		    	fclose(handle);
				return 1;
				} else SendClientMessage(playerid, COLOR_MODE, "[ERROR]: You have to be outside a vehicle!");
			return 1;
			}
		}
		case 2: {
			if (handle) {
   			if (IsPlayerInAnyVehicle(playerid)) {
			    new vehicleid = GetPlayerVehicleID(playerid);
		    	GetVehiclePos(vehicleid, X, Y, Z);
		    	GetVehicleZAngle(vehicleid, angle);
		    	format(string, sizeof(string), "CreateVehicle( %d, %f, %f, %f, %f, -1, -1, %d);\r\n", GetVehicleModel(vehicleid), X, Y, Z, angle, respawn_delay);
		    	SendClientMessageToAdmins(COLOR_MODE, string);
		    	print(string);
		    	fwrite(handle, string);
		    	fclose(handle);
		    	return 1;
				} else SendClientMessage(playerid, COLOR_MODE, "[ERROR]: You have to sit in a vehicle!");
			return 1;
			}
		}
		case 3: {
		    new modelid = strval(strtok(cmdtext,idx));
		    new type = strval(strtok(cmdtext,idx));
		    if (!modelid || !type) {
		    SendClientMessage(playerid, COLOR_MODE, "[USAGE]: '/savepos [modelid][type]'");
		    return 1;
		    }
		    if (handle) {
			    GetPlayerPos(playerid, X, Y, Z);
			    format(string, sizeof(string), "CreatePickup(%d, %d, %f, %f, %f);\r\n", modelid, type, X, Y, Z);
			    SendClientMessageToAdmins(COLOR_MODE, string);
			    print(string);
		    	fwrite(handle, string);
		    	fclose(handle);
			}
		}
		case 4: {
		    new type = strval(strtok(cmdtext,idx));
		    new radius = strval(strtok(cmdtext,idx));
		    if (!type || !radius) {
		    SendClientMessage(playerid, COLOR_MODE, "[USAGE]: '/savepos [type][radius]'");
		    return 1;
		    }
		    if (handle) {
			    GetPlayerPos(playerid, X, Y, Z);
			    format(string, sizeof(string), "CreateExplosion(%f, %f, %f, %d, %d);\r\n", X, Y, Z, type, radius);
			    SendClientMessageToAdmins(COLOR_MODE, string);
			    print(string);
		    	fwrite(handle, string);
		    	fclose(handle);
			}
		}
		case 5: {
		    new size = strval(strtok(cmdtext,idx));
		    if (!size) {
		    SendClientMessage(playerid, COLOR_MODE, "[USAGE]: '/savepos [size]'");
		    return 1;
		    }
		    if (handle) {
			    GetPlayerPos(playerid, X, Y, Z);
			    format(string, sizeof(string), "SetPlayerCheckpoint(playerid, %f, %f, %f, %d);\r\n", X, Y, Z, size);
			    SendClientMessageToAdmins(COLOR_MODE, string);
			    print(string);
		    	fwrite(handle, string);
		    	fclose(handle);
			}
		}
		case 6: {
		    new type = strval(strtok(cmdtext,idx));
		    new size = strval(strtok(cmdtext,idx));
		    if (!type || !size) {
		    SendClientMessage(playerid, COLOR_MODE, "[USAGE]: '/savepos [type][size]'");
		    return 1;
		    }
		    if (handle) {
			    GetPlayerPos(playerid, X, Y, Z);
			    format(string, sizeof(string), "SetPlayerRaceCheckpoint(playerid, %d, %f, %f, %f, 0.0, 0.0, 0.0, %d);\r\n", type, X, Y, Z, size);
			    SendClientMessageToAdmins(COLOR_MODE, string);
			    print(string);
		    	fwrite(handle, string);
		    	fclose(handle);
			}
		}
		case 7: {
		    if (handle) {
		        if (IsPlayerInAnyVehicle(playerid)) {
		        new vehicleid = GetPlayerVehicleID(playerid);
		        GetVehiclePos(vehicleid, X, Y, Z);
		        GetVehicleZAngle(vehicleid, angle);
		        } else {
			    GetPlayerPos(playerid, X, Y, Z);
			    GetPlayerFacingAngle(playerid, angle);
			    }
			    format(string, sizeof(string), "[Coords: %f, %f, %f] [Angle: %f] [Interior: %d]", X, Y, Z, angle, GetPlayerInterior(playerid));
			    SendClientMessageToAdmins(COLOR_MODE, string);
			    print(string);
		    	fwrite(handle, string);
		    	fclose(handle);
			}
		}
	}
	return 1;
	}
	
	}

	return 0;
}
//------------------------------------------------------------------------------
//=====MENUS====================================================================
//------------------------------------------------------------------------------
public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:PlayerMenu;
    PlayerMenu=Menu:GetPlayerMenu(playerid);
    new string[256];
    new show=0;

    if(PlayerMenu == SelectMenu) {
        TogglePlayerControllable(playerid, 0);
        switch(row) {
       		case 0: SaveFile = "player_coords.txt", SaveMode = 1, show = 1;
		    case 1: SaveFile = "car_coords.txt", SaveMode = 2, show = 1;
		    case 2: SaveFile = "pickup_coords.txt", SaveMode = 3, show = 1;
		    case 3: SaveFile = "xplode_coords.txt", SaveMode = 4, show = 1;
		    case 4: SaveFile = "playercp_coords.txt", SaveMode = 5, show = 1;
		    case 5: SaveFile = "racecp_coords.txt", SaveMode = 6, show = 1;
		    case 6: SaveFile = "blank_coords.txt", SaveMode = 7, show = 1;
       		case 7: TogglePlayerControllable(playerid, 1), show = 0;
		}
		if (show == 1) {
	 	format(string, 256, "Savemode %d activated.", SaveMode);
	 	SendClientMessageToAdmins(COLOR_MODE, string);
	 	SendClientMessageToAdmins(COLOR_MODE, "[1 = PlayerClass, 2 = Vehicle, 3 = Pickup, 4 = Explosion, 5 = PlayerCheckpoint, 6 = RaceCheckpoint, 7 = Blank Coords]");
	 	TogglePlayerControllable(playerid, 1);
	 	}
	}
	
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
    TogglePlayerControllable(playerid, 1);
	return 1;
}
//------------------------------------------------------------------------------
//=====KEYS=====================================================================
//------------------------------------------------------------------------------
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}
//------------------------------------------------------------------------------
//=====STRTOK===================================================================
//------------------------------------------------------------------------------
strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' ')) {
		index++;
	}
	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1))) {
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
//------------------------------------------------------------------------------
//=====STOCK====================================================================
//------------------------------------------------------------------------------
stock SendClientMessageToAdmins(COLOR, const message[])
{
    	for(new a=0; a<MAX_PLAYERS; a++) {
        if(IsPlayerConnected(a)) {
        if(IsPlayerAdmin(a)) {
        	SendClientMessage(a, COLOR, message);
        }
        }
		}
}
