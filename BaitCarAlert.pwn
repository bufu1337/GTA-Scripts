/*
* Script Title: Bait Car
* Script Version: 1.0.0.0
* Scripter: zDivine aka Mercenary
* Date: 20130411 (YYYYMMDD)
*/

#define FILTERSCRIPT

#include <a_samp>
#include <zcmd>
#include <sscanf2>
#include <YSI\y_timers>

#if defined FILTERSCRIPT

// Colors
#define COLOR_ORANGE 0xFF8000FF
#define COLOR_GREEN 0x33AA33AA
#define COLOR_REALRED 0xFF0606FF
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA

// Forwards
forward SendBCMsg(string[]);
forward SendBCAlertMsg(string[]);

// Variables
new BaitCar;
new bool: LoggedIn[MAX_PLAYERS] = false;
new bool: BaitCarPlaced = false;
new bool: BaitCarActivated = false;
new bool: BaitCarMarked = false;

// Defines
#define BC_LOGIN_PASS "ChangeMe"
#define BC_DEFAULT_VEHICLE 411


// Stocks and Functions
GPNE(playerid)
{
	new sz_playerName[MAX_PLAYER_NAME], i_pos;

	GetPlayerName(playerid, sz_playerName, MAX_PLAYER_NAME);
	while ((i_pos = strfind(sz_playerName, "_", false, i_pos)) != -1) sz_playerName[i_pos] = ' ';
	return sz_playerName;
}

SendBCMsg(string[])
{
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(LoggedIn[i] == true)
	    {
	        SendClientMessage(i, COLOR_YELLOW, string);
		}
	}
}

SendBCAlertMsg(string[])
{
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(LoggedIn[i] == true)
	    {
	        SendClientMessage(i, COLOR_ORANGE, string);
		}
	}
}

FreezeBaitCar()
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(BaitCar, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(BaitCar, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, alarm, VEHICLE_PARAMS_ON, bonnet, boot, objective);
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerInVehicle(i, BaitCar))
	    {
	        TogglePlayerControllable(i, false);
	        SendClientMessage(i, COLOR_REALRED, "This car has been locked down by law enforcement, you may not exit until told to do so.");
	    }
	}
}

UnfreezeBaitCar()
{
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerInVehicle(i, BaitCar))
	    {
	        TogglePlayerControllable(i, true);
	        SendClientMessage(i, COLOR_GREEN, "The bait car has been unlocked, you may now exit the vehicle.");
	    }
	}
}

MarkBaitCar()
{
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(LoggedIn[i] == true)
	    {
	        new engine, lights, alarm, doors, bonnet, boot, objective, string[128];
	        GetVehicleParamsEx(BaitCar, engine, lights, alarm, doors, bonnet, boot, objective);
	        SetVehicleParamsEx(BaitCar, engine, lights, alarm, doors, bonnet, boot, VEHICLE_PARAMS_ON);
			format(string, sizeof(string), "ATTENTION: %s has enabled the gps locator on the bait car.");
			BaitCarMarked = true;
			SendBCMsg(string);
	    }
	}
}

UnmarkBaitCar()
{
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(LoggedIn[i] == true)
	    {
			new engine, lights, alarm, doors, bonnet, boot, objective, string[128];
	        GetVehicleParamsEx(BaitCar, engine, lights, alarm, doors, bonnet, boot, objective);
	        SetVehicleParamsEx(BaitCar, engine, lights, alarm, doors, bonnet, boot, VEHICLE_PARAMS_OFF);
			format(string, sizeof(string), "ATTENTION: %s has disabled the gps locator on the bait car.");
			BaitCarMarked = false;
			SendBCMsg(string);
	    }
	}
}

public OnFilterScriptInit()
{
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#endif

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	new string[128];
	if(vehicleid == BaitCar)
	{
	    if(BaitCarActivated == true)
	    {
		    if(!ispassenger)
		    {
				format(string, sizeof(string), "ATTENTION: Someone has been detected entering the driver seat of the bait car.");
				SendBCAlertMsg(string);
		    }
		    else
		    {
		        format(string, sizeof(string), "ATTENTION: Someone has been detected entering the passenger seat of the bait car.");
				SendBCAlertMsg(string);
		    }
		}
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	new string[128];
	if(vehicleid == BaitCar)
	{
	    if(BaitCarActivated == true)
	    {
	        format(string, sizeof(string), "ATTENTION: Someone has been detected exiting the bait car.");
			SendBCAlertMsg(string);
	    }
	}
	return 1;
}

CMD:bclogin(playerid, params[])
{
	new pass[24];
	if(sscanf(params, "s[24", pass)) return SendClientMessage(playerid, COLOR_ORANGE, "COMMAND: /bclogin [pass]");
	
	if(strcmp(pass, BC_LOGIN_PASS, true) == 0)
	{
		LoggedIn[playerid] = true;
 		SendClientMessage(playerid, COLOR_GREEN, "Login successful. - Brought to you by zDivine -aka- Mercenary");
	}
 	else
 	{
 		SendClientMessage(playerid, COLOR_REALRED, "ERROR: Invalid login password.");
 	}
 	return 1;
}

CMD:bc(playerid, params[])
{
	if(LoggedIn[playerid] == false) return SendClientMessage(playerid, COLOR_REALRED, "ERROR: Permission denied.");

	new option[24], value, string[128];
	if(sscanf(params, "s[24]D", option, value))
	{
	    SendClientMessage(playerid, COLOR_ORANGE, "COMMAND: /bc [option] [value(optional)]");
	    SendClientMessage(playerid, COLOR_WHITE, "OPTIONS: place | activate | remove | gps | (l)ock(a)nd(k)ill | (u)n(l)ock");
	    return 1;
	}

	if(strcmp(option, "place", true) == 0)
	{
	    if(BaitCarPlaced == true) return SendClientMessage(playerid, COLOR_REALRED, "ERROR: The bait car is already palced somewhere.");

        new Float: x, Float: y, Float: z, Float: a;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
		if(value >= 400 && value <= 611)
	    {
		    BaitCar = CreateVehicle(value, x, y, z, a, -1, -1, -1);
		    BaitCarPlaced = true;
		    format(string, sizeof(string), "ATTENTION: %s has placed the bait car [Model: %d] at [X: %.02f] [Y: %.02f] [Z: %.02f]", GPNE(playerid), value, x, y, z);
		    SendBCMsg(string);
		}
		else
		{
		    BaitCar = CreateVehicle(BC_DEFAULT_VEHICLE, x, y, z, a, -1, -1, -1);
		    BaitCarPlaced = true;
		    format(string, sizeof(string), "ATTENTION: %s has placed the bait car [Model: %d] at [X: %.02f] [Y: %.02f] [Z: %.02f]", GPNE(playerid), BC_DEFAULT_VEHICLE, x, y, z);
		    SendBCMsg(string);
		}
	}
	else if(strcmp(option, "remove", true) == 0)
	{
	    if(BaitCarPlaced == true)
	    {
			DestroyVehicle(BaitCar);
			BaitCarPlaced = false;
			format(string, sizeof(string), "ATTENTION: %s has destroyed the bait car.", GPNE(playerid));
			SendBCMsg(string);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_REALRED, "ERROR: The bait car hasn't been placed yet.");
		    return 1;
		}
	}
	else if(strcmp(option, "lak", true) == 0)
	{
	    if(BaitCarPlaced == true)
	    {
	        if(BaitCarActivated == true)
	        {
		        FreezeBaitCar();
		        format(string, sizeof(string), "ATTENTION: %s has locked the doors and killed the engine on the bait car.", GPNE(playerid));
		        SendBCMsg(string);
			}
			else
			{
			    SendClientMessage(playerid, COLOR_REALRED, "ERROR: The bait car is not activated.");
			    return 1;
			}
	    }
	    else
	    {
	        SendClientMessage(playerid, COLOR_REALRED, "ERROR: The bait car is not currently placed.");
	        return 1;
		}
	}
	else if(strcmp(option, "ul", true) == 0)
	{
	    UnfreezeBaitCar();
	    format(string, sizeof(string), "ATTENTION: %s has unlocked the doors on the bait car.", GPNE(playerid));
     	SendBCMsg(string);
	}
	else if(strcmp(option, "activate", true) == 0)
	{
	    if(BaitCarPlaced == true)
	    {
	        if(BaitCarActivated == false)
	        {
		        BaitCarActivated = true;
		        format(string, sizeof(string), "ATTENTION: %s has activated the bait car.", GPNE(playerid));
		        SendBCMsg(string);
			}
			else
			{
				BaitCarActivated = false;
		        format(string, sizeof(string), "ATTENTION: %s has deactivated the bait car.", GPNE(playerid));
		        SendBCMsg(string);
			}
	    }
	    else
	    {
	        SendClientMessage(playerid, COLOR_REALRED, "ERROR: The bait car is not currently placed.");
	        return 1;
		}
	}
	else if(strcmp(option, "gps", true) == 0)
	{
	    if(BaitCarPlaced == true)
		{
		    if(BaitCarMarked == false)
		    {
		        MarkBaitCar();
			}
			else
			{
			    UnmarkBaitCar();
			}
		}
		else
	    {
	        SendClientMessage(playerid, COLOR_REALRED, "ERROR: The bait car is not currently placed.");
	        return 1;
		}
	}
	return 1;
}
