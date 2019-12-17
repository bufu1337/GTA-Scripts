#include <a_samp>

#define COLOR_RED 0xCC0000AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_GREEN 0x33FF00AA
#define COLOR_CYAN 0x33FFFFAA
#define COLOR_BLUE 0x0000FFAA
#define COLOR_ORANGE 0xFFCC00AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BLACK 0x000000AA
#define COLOR_GREY 0xCCCCCCAA

#define MAX_STRING 255

new engineOn[MAX_VEHICLES];
new vehicleEntered[MAX_PLAYERS][MAX_VEHICLES];
new isInVehicle[MAX_PLAYERS];
new str[MAX_STRING];

new engineEnabled;

forward CarAlarm(playerid);
forward Startup(playerid, vehicleid);

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("      Engine On/Off FS by LarzI");
	print("--------------------------------------\n");
	return true;
}

public OnPlayerText(playerid, text[])
{
	if(!strcmp(text[0], "#", true))
	{
		for(new i=0; i<GetMaxPlayers(); i++)
		{
		    new playerveh = GetPlayerVehicleID(playerid);
		    if(IsPlayerInAnyVehicle(playerid))
		        SendClientMessage(playerid, COLOR_RED, "You must be inside a vehicle!");
		    if((IsPlayerInAnyVehicle(i) || !IsPlayerInAnyVehicle(i)) && GetPlayerVehicleID(i) != playerveh)
				SendClientMessage(playerid, COLOR_RED, "You don't have any passengers!");
			if(IsPlayerInAnyVehicle(i) && (GetPlayerVehicleID(i) == playerveh) && (GetPlayerState(i) == PLAYER_STATE_PASSENGER))
			{
				format(str, MAX_STRING, "Driver %s says: %s", Name(playerid), text[1]);
				SendClientMessage(i, COLOR_YELLOW, str);
			}
			if(IsPlayerInAnyVehicle(i) && (GetPlayerVehicleID(i) == playerveh) && (GetPlayerState(playerid) == PLAYER_STATE_PASSENGER))
			{
				format(str, MAX_STRING, "Passenger %s says: %s", Name(playerid), text[1]);
				SendClientMessage(i, COLOR_YELLOW, str);
			}
		}
		return false;
	}
	return true;
}

public OnPlayerEnterVehicle(playerid, vehicleid)
{
	isInVehicle[playerid] = true;
	return true;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	isInVehicle[playerid] = false;
	return true;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(isInVehicle[playerid] && newkeys == KEY_JUMP)
	{
	    engineOn[GetPlayerVehicleID(playerid)] = true;
	}
	return true;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new pveh = GetVehicleModel(GetPlayerVehicleID(playerid));
	new vehicle = GetPlayerVehicleID(playerid);
	if(newstate == PLAYER_STATE_DRIVER && (pveh == 522 || pveh == 581 || pveh == 462 || pveh == 521 || pveh == 463 || pveh == 461 || pveh == 448 || pveh == 471 || pveh == 468 || pveh == 586) && (pveh != 509 && pveh != 481 && pveh != 510))
	{
		SetTimerEx("Startup", 1, false, "ii", playerid, vehicle);
	}
	else if(newstate == PLAYER_STATE_DRIVER && (pveh != 509 && pveh != 481 && pveh != 510))
	{
		SetTimerEx("Startup", 1, false, "ii", playerid, vehicle);
	}
	return true;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[MAX_STRING], idx;
	cmd = strtok(cmdtext, idx);
	
	if(!strcmp(cmd, "/ecommands", true))
	{
		SendClientMessage(playerid, COLOR_YELLOW, "Available commands for Engine Script:");
		SendClientMessage(playerid, COLOR_YELLOW, "Admins: /enablee, /disablee");
		SendClientMessage(playerid, COLOR_YELLOW, "Others: /startup, /turnoff, # [text], /echathelp, /ecommands");
		return true;
	}
	if(!strcmp(cmd, "/echathelp", true))
	{
	    SendClientMessage(playerid, COLOR_YELLOW, "Usage for passenger chat: # [text-to-send]");
	    return true;
	}
	if(!strcmp(cmd, "/enablee", true))
	{
	    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_RED, "RCON Admins Only!");
	    if(engineEnabled) return SendClientMessage(playerid, COLOR_RED, "Engine Script already activated!");
	    
	    engineEnabled = true;
	    SendClientMessageToAll(COLOR_WHITE, "Engine Script is now enabled! You have to do /startup or press shift to drive!");
	    return true;
	}
	if(!strcmp(cmd, "/disablee", true))
	{
	    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_RED, "RCON Admins Only!");
	    if(!engineEnabled) return SendClientMessage(playerid, COLOR_RED, "Engine Script already deactivated!");

	    engineEnabled = false;
	    SendClientMessageToAll(COLOR_WHITE, "Engine Script is now disabled! You don't longer need to do /startup or press shift to drive!");
	    return true;
	}
	if(engineEnabled)
	{
		if(!strcmp(cmd, "/startup", true))
		{
			if(engineOn[GetPlayerVehicleID(playerid)]) return SendClientMessage(playerid, COLOR_RED, "Engine already started!");
			if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED, "Do you think that you can start an engine which you don't have?");
			if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return SendClientMessage(playerid, COLOR_RED, "Only the driver can do this!");

			engineOn[GetPlayerVehicleID(playerid)] = true;
			TogglePlayerControllable(playerid, true);
			new playerveh = GetPlayerVehicleID(playerid);
			PutPlayerInVehicle(playerid, playerveh, 0);
			SendClientMessage(playerid, COLOR_GREEN, "Engine started!");
			format(str, 255, "%s has started up his vehicle", Name(playerid));
			SendClientMessageToAll(COLOR_WHITE, str);
			return true;
		}
		if(!strcmp(cmd, "/turnoff", true))
		{
			if(!engineOn[GetPlayerVehicleID(playerid)]) return SendClientMessage(playerid, COLOR_RED, "Engine not started!");
			if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED, "Do you think that you can start an engine which you don't have?");
			if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return SendClientMessage(playerid, COLOR_RED, "Only the driver can do this!");

			engineOn[GetPlayerVehicleID(playerid)] = false;
			SendClientMessage(playerid, COLOR_GREEN, "Engine stopped!");
			return true;
		}
	}
	format(str, MAX_STRING, "\"%s\" - Unknown Command. Type /enginehelp for commands (Engine Script)", cmdtext[0]);
	return SendClientMessage(playerid, COLOR_RED, str);
}

public Startup(playerid, vehicleid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER || engineOn[vehicleid])
	{
		//I do nothing!
	}
	else if(!engineOn[vehicleid] && !vehicleEntered[playerid][vehicleid] && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "You have to do /startup or press shift to start your engine!");
		TogglePlayerControllable(playerid, false);
		vehicleEntered[playerid][vehicleid] = true;
	}
	else if(!engineOn[vehicleid] && vehicleEntered[playerid][vehicleid] && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "You have to do /startup or press shift to start your engine!");
		TogglePlayerControllable(playerid, false);
	}
}

Name(playerid)
{
	new name[24];
	GetPlayerName(playerid, name, 24);
	return name;
}

stock GetDistanceFromPlayerToVehicle(playerid, vehicleid)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	new Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	GetVehiclePos(vehicleid,x2,y2,z2);
	tmpdis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
	return floatround(tmpdis);
}

strtok(const string[], &index, const seperator[] = " ")
{
	new index2, result[30];
	index2 =  strfind(string, seperator, false, index);

	if(index2 == -1)
	{
		if(strlen(string) > index)
		{
			strmid(result, string, index, strlen(string), 30);
			index = strlen(string);
		}
		return result; // This string is empty, probably, if index came to an end
	}
	if(index2 > (index + 29))
	{
		index2 = index + 29;
		strmid(result, string, index, index2, 30);
		index = index2;
		return result;
	}
	strmid(result, string, index, index2, 30);
	index = index2 + 1;
	return result;
}

