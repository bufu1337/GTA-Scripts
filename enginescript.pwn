//----------------------------------//
//| Enginescript Engine On/Off FS  |//
//|  by LarzI aka. D'x-Orzizt      |//
//|Tested and fixed by bogeyman_EST|//
//----------------------------------//


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

enum pInfo
{
	pThief
}
new PlayerInfo[MAX_PLAYERS][pInfo];
new CodeMessages[][MAX_STRING] =
{
	"rniuyj",
	"iet owrh",
	"siegtlan",
	"orbyerb",
	"srd asnaae"
};
new RealMessages[][MAX_STRING] =
{
	"injury",
	"hot wire",
	"stealing",
	"robbery",
	"san andreas"
};
new engineOn[MAX_VEHICLES];
new vehicleEntered[MAX_PLAYERS][MAX_VEHICLES];
new isInVehicle[MAX_PLAYERS];
new str[MAX_STRING];
new tries[MAX_PLAYERS];
new hasRecievedCodeMessage[MAX_PLAYERS];
new recievedCodeMessage[MAX_PLAYERS];
new thieftimer[MAX_PLAYERS];
new openingveh[MAX_PLAYERS];

new engineEnabled;

forward CarAlarm(playerid);
forward Startup(playerid, vehicleid);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward CheckPlayerToCarDistance(playerid);
forward Float:PlayerToPointReturn(p1, Float:x2, Float:y2, Float:z2);

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("      Engine On/Off FS by LarzI");
	print("--------------------------------------\n");
	return true;
}

public OnPlayerSpawn(playerid)
{
	if(PlayerInfo[playerid][pThief])
	{
	    for(new i=0, m=MAX_VEHICLES; i<m; i++)
	    {
	    	SetVehicleParamsForPlayer(i, playerid, 0, 1);
	    	tries[playerid] = 3;
		}
	}
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
	if(hasRecievedCodeMessage[playerid])
	{
		if(recievedCodeMessage[playerid] <= 0) hasRecievedCodeMessage[playerid] = false;
		if(recievedCodeMessage[playerid] == 1)
		{
		    if(!strcmp(text[0], RealMessages[0]))
		    {
				SendClientMessage(playerid, COLOR_GREEN, "Correct answer! The doors is now open for you!");
				hasRecievedCodeMessage[playerid] = false;
		        SetVehicleParamsForPlayer(openingveh[playerid], playerid, 0, false);
				return 0;
			}
			tries[playerid]--;
			new errorMsg[256];
			format(errorMsg, 256, "Wrong answer! %d tries left", tries[playerid]);
			SendClientMessage(playerid, COLOR_RED, errorMsg);
			return 0;
		}
		if(recievedCodeMessage[playerid] == 2)
		{
		    if(!strcmp(text[0], RealMessages[1]))
		    {
				SendClientMessage(playerid, COLOR_GREEN, "Correct answer! The doors is now open for you!");
				hasRecievedCodeMessage[playerid] = false;
		        SetVehicleParamsForPlayer(openingveh[playerid], playerid, 0, false);
				return 0;
			}
			tries[playerid]--;
			new errorMsg[256];
			format(errorMsg, 256, "Wrong answer! %d tries left", tries[playerid]);
			SendClientMessage(playerid, COLOR_RED, errorMsg);
			return 0;
		}
		if(recievedCodeMessage[playerid] == 3)
		{
		    if(!strcmp(text[0], RealMessages[2]))
		    {
				SendClientMessage(playerid, COLOR_GREEN, "Correct answer! The doors is now open for you!");
				hasRecievedCodeMessage[playerid] = false;
		        SetVehicleParamsForPlayer(openingveh[playerid], playerid, 0, false);
				return 0;
			}
			tries[playerid]--;
			new errorMsg[256];
			format(errorMsg, 256, "Wrong answer! %d tries left", tries[playerid]);
			SendClientMessage(playerid, COLOR_RED, errorMsg);
			return 0;
		}
		if(recievedCodeMessage[playerid] == 4)
		{
		    if(!strcmp(text[0], RealMessages[3]))
		    {
				SendClientMessage(playerid, COLOR_GREEN, "Correct answer! The doors is now open for you!");
				hasRecievedCodeMessage[playerid] = false;
		        SetVehicleParamsForPlayer(openingveh[playerid], playerid, 0, false);
				return 0;
			}
			tries[playerid]--;
			new errorMsg[256];
			format(errorMsg, 256, "Wrong answer! %d tries left", tries[playerid]);
			SendClientMessage(playerid, COLOR_RED, errorMsg);
			return 0;
		}
		if(recievedCodeMessage[playerid] == 5)
		{
		    if(!strcmp(text[0], RealMessages[4]))
		    {
				SendClientMessage(playerid, COLOR_GREEN, "Correct answer! The doors is now open for you!");
				hasRecievedCodeMessage[playerid] = false;
		        SetVehicleParamsForPlayer(openingveh[playerid], playerid, 0, false);
				return 0;
			}
			tries[playerid]--;
			new errorMsg[256];
			format(errorMsg, 256, "Wrong answer! %d tries left", tries[playerid]);
			SendClientMessage(playerid, COLOR_RED, errorMsg);
			return 0;
		}
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
	if((newkeys == KEY_JUMP) && (isInVehicle[playerid]))
 		engineOn[GetPlayerVehicleID(playerid)] = true;
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
		SendClientMessage(playerid, COLOR_YELLOW, "Others: /startup, /turnoff, #[text], /echathelp, /ecommands, /bethief, /quitthief");
		return true;
	}
	if(!strcmp(cmd, "/echathelp", true))
	    return SendClientMessage(playerid, COLOR_YELLOW, "Usage for passenger chat: # [text-to-send]");

	if(!strcmp(cmd, "/enablee", true))
	{
	    if(!IsPlayerAdmin(playerid))
			return SendClientMessage(playerid, COLOR_RED, "RCON Admins Only!");
	    if(engineEnabled)
			return SendClientMessage(playerid, COLOR_RED, "Engine Script already activated!");

	    engineEnabled = true;
	    SendClientMessageToAll(COLOR_WHITE, "Engine Script is now enabled! You have to do /startup or press shift to drive!");
	    return true;
	}
	if(!strcmp(cmd, "/disablee", true))
	{
	    if(!IsPlayerAdmin(playerid))
			return SendClientMessage(playerid, COLOR_RED, "RCON Admins Only!");
	    if(!engineEnabled)
			return SendClientMessage(playerid, COLOR_RED, "Engine Script already deactivated!");

	    engineEnabled = false;
	    return SendClientMessageToAll(COLOR_WHITE, "Engine Script is now disabled! You don't longer need to do /startup or press shift to drive!");
	}
	if(engineEnabled)
	{
		if(!strcmp(cmd, "/startup", true))
		{
			if(engineOn[GetPlayerVehicleID(playerid)])
				return SendClientMessage(playerid, COLOR_RED, "Engine already started!");
			if(!IsPlayerInAnyVehicle(playerid))
				return SendClientMessage(playerid, COLOR_RED, "Do you think that you can start an engine which you don't have?");
			if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
				return SendClientMessage(playerid, COLOR_RED, "Only the driver can do this!");

			engineOn[GetPlayerVehicleID(playerid)] = true;
			TogglePlayerControllable(playerid, true);
			new playerveh = GetPlayerVehicleID(playerid);
			PutPlayerInVehicle(playerid, playerveh, 0);
			SendClientMessage(playerid, COLOR_GREEN, "Engine started!");
			format(str, 255, "%s has started up his vehicle", Name(playerid));
			return SendClientMessageToAll(COLOR_WHITE, str);
		}
		if(!strcmp(cmd, "/turnoff", true))
		{
			if(!engineOn[GetPlayerVehicleID(playerid)])
				return SendClientMessage(playerid, COLOR_RED, "Engine not started!");
			if(!IsPlayerInAnyVehicle(playerid))
				return SendClientMessage(playerid, COLOR_RED, "Do you think that you can start an engine which you don't have?");
			if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
				return SendClientMessage(playerid, COLOR_RED, "Only the driver can do this!");

			engineOn[GetPlayerVehicleID(playerid)] = false;
			return SendClientMessage(playerid, COLOR_GREEN, "Engine stopped!");
		}
		if(!strcmp(cmd, "/bethief", true))
		{
		    if(PlayerInfo[playerid][pThief])
		        return SendClientMessage(playerid, COLOR_RED, "You're already a thief!");
			PlayerInfo[playerid][pThief] = true;
			for(new i=0, m=MAX_VEHICLES; i<m; i++)
			{
				SetVehicleParamsForPlayer(i, playerid, 0, 1);
				tries[playerid] = 3;
			}
			thieftimer[playerid] = SetTimerEx("CheckPlayerToCarDistance", 1000, true, "i", playerid);
			return SendClientMessage(playerid, COLOR_YELLOW, "You are now a thief, you have to break a code to get into cars!");
		}
		if(!strcmp(cmd, "/quitthief", true))
		{
		    if(!PlayerInfo[playerid][pThief])
		        return SendClientMessage(playerid, COLOR_RED, "You can't quit being a thief, when you aren't!");
			PlayerInfo[playerid][pThief] = false;
			KillTimer(thieftimer[playerid]);
			return SendClientMessage(playerid, COLOR_YELLOW, "You're no longer a thief, you can enters cars normally!");
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

public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

public CheckPlayerToCarDistance(playerid)
{
	if(PlayerInfo[playerid][pThief] && !hasRecievedCodeMessage[playerid])
	{
		for(new i=0, m=MAX_VEHICLES; i<m; i++)
		{
			new Float:x, Float:y, Float:z;
			GetVehiclePos(i, x, y, z);
			if(PlayerToPoint(5, playerid, x, y, z))
			{
				if(openingveh[playerid] != i)
				{
					new iRandom = random(5);
					SendClientMessage(playerid, COLOR_WHITE, "Break the code and type the correct word.");
					SendClientMessage(playerid, COLOR_YELLOW, CodeMessages[iRandom]);
					hasRecievedCodeMessage[playerid] = true;
					switch(iRandom)
					{
						case 0: recievedCodeMessage[playerid] = 1;
						case 1: recievedCodeMessage[playerid] = 2;
						case 2: recievedCodeMessage[playerid] = 3;
						case 3: recievedCodeMessage[playerid] = 4;
						case 4: recievedCodeMessage[playerid] = 5;
					}
					openingveh[playerid] = i;
				}
			}
		}
	}
	return true;
}

public Float:PlayerToPointReturn(p1, Float:x2, Float:y2, Float:z2)
{
	new Float:x1,Float:y1,Float:z1;
	if (!IsPlayerConnected(p1))
	{
		return -1.00;
	}
	GetPlayerPos(p1,x1,y1,z1);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

stock GetPlayerNearestVehicle(playerid)
{
    for(new j=0, n=MAX_VEHICLES; j<n; j++)
    {
        new Float:closestvehpos = 9999999.99;
        new closestvehid;
        new Float:vX, Float:vY, Float:vZ;
        GetVehiclePos(j, vX, vY, vZ);
        if(PlayerToPointReturn(playerid, vX, vY, vZ) < closestvehpos)
        {
             closestvehpos = PlayerToPointReturn(playerid, vX, vY, vZ);
             closestvehid = j;
             return closestvehid;
        }
    }
    return -1;
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
