/*
Script Title: Wheel Rotator
Scripter: zDivine aka Mercenary
Script Date: 20130418 (YYYYMMDD)
Script Version: 1.0.0.0

*/

#define FILTERSCRIPT

#include <a_samp> // Credits to SA-MP Team
#include <sscanf2> // Credits to Y_Less
#include <zcmd> // Credits to Zeex
#include <YSI\y_colours> // Credits to Y_Less

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("    Wheel Rotator by zDivine loaded!    ");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#endif

// Variables
new bool:pWheelRotator[MAX_PLAYERS] = false; // Used to make sure it's enabled, to decrease faults.
new iWheel[MAX_PLAYERS] = 0;
new timerID;

// Settings
#define MAX_VEHICLEWHEELS 5 // The max amount of wheels they can have rotating on their vehicle at once.
#define WHEEL_CHANGE_TIMER 2000 // (In milliseconds) - The time in which the wheels change.

// Enums
enum pvwInfo
{
	pvwWheelID
}
new PVWI[MAX_PLAYERS][MAX_VEHICLEWHEELS][pvwInfo];

// Stocks
stock IsValidWheelID(wheelid)
{
	switch(wheelid)
	{
	    case 1073, 1074: return 1;
	    case 1053: return 1;
	    case 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085: return 1;
	    case 1097, 1098: return 1;
	    case 1025: return 1;
		default: return 0;
	}
	return 0;
}
stock GetFreeWheelSlot(playerid)
{
	for(new i = 0; i < MAX_VEHICLEWHEELS; i++)
	{
		if(PVWI[playerid][i][pvwWheelID] == 0) return i;
	}
	return -1;
}
stock GetWheelName(wheelid)
{
	new wText[24];
	switch(wheelid)
	{
	    case 1073: wText = "Shadow";
	    case 1074: wText = "Mega";
	    case 1053: wText = "Rimshine";
	    case 1076: wText = "Wires";
	    case 1077: wText = "Classic";
	    case 1078: wText = "Twist";
	    case 1079: wText = "Cutter";
	    case 1080: wText = "Switch";
	    case 1081: wText = "Grove";
	    case 1082: wText = "Import";
	    case 1083: wText = "Dollar";
	    case 1084: wText = "Trance";
	    case 1085: wText = "Atomic";
	    case 1096: wText = "Ahab";
	    case 1097: wText = "Virtual";
	    case 1098: wText = "Access";
	    case 1025: wText = "Offroad";
	    default: wText = "Unknown";
	}
	return wText;
}
stock GetWheelCount(playerid)
{
	new wheelcount;
	for(new i = 0; i < MAX_VEHICLEWHEELS; i++)
	{
	    if(PVWI[playerid][i][pvwWheelID] != 0)
	    {
	        wheelcount++;
	    }
	}
	return wheelcount;
}

// Timers
forward ChangeWheel();
public ChangeWheel()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    new iWheelCount = GetWheelCount(i);
	    if(iWheel[i] == MAX_VEHICLEWHEELS || iWheel[i] == iWheelCount) { iWheel[i] = 0; }
	    if(pWheelRotator[i] == true)
	    {
	        if(PVWI[i][iWheel[i]][pvwWheelID] != 0)
	        {
	        	if(IsPlayerInAnyVehicle(i))
				{
					AddVehicleComponent(GetPlayerVehicleID(i), PVWI[i][iWheel[i]][pvwWheelID]);
					iWheel[i]++;
				}
			}
		}
	}
}

// Commands
CMD:wrhelp(playerid, params[])
{
	SendClientMessage(playerid, X11_WHITE, "WHEEL ROTATOR: /listwheels /addwheel /removewheel /enablewr /disablewr /wheellist");
	return 1;
}

CMD:listwheels(playerid, params[])
{
	SendClientMessage(playerid, X11_BLUE, "Listing current wheels...");
	for(new i = 0; i < MAX_VEHICLEWHEELS; i++)
	{
	    if(PVWI[playerid][i][pvwWheelID] != 0)
	    {
			new string[128];
			format(string, sizeof(string), "Wheel Slot: %d | Wheel ID: %d | Wheel Name: %s", i, PVWI[playerid][i][pvwWheelID], GetWheelName(PVWI[playerid][i][pvwWheelID]));
			SendClientMessage(playerid, X11_WHITE, string);
	    }
	}
	return 1;
}

CMD:enablewr(playerid, params[])
{
	pWheelRotator[playerid] = true;
	SendClientMessage(playerid, X11_GREEN, "Wheel rotator enabled.");
	timerID = SetTimer("ChangeWheel", WHEEL_CHANGE_TIMER, true);
	return 1;
}

CMD:disablewr(playerid, params[])
{
	pWheelRotator[playerid] = false;
	SendClientMessage(playerid, X11_RED, "Wheel rotator disabled.");
	KillTimer(timerID);
	return 1;
}

CMD:addwheel(playerid, params[])
{
	new wheelid, string[128];
	if(sscanf(params, "d", wheelid))
	{
		SendClientMessage(playerid, X11_BLUE, "CMD: /addwheel [wheelid]");
		SendClientMessage(playerid, X11_WHITE, "You can use /wheellist to get a full list of wheel ID's.");
		return 1;
	}

	if(IsValidWheelID(wheelid))
	{
		new wid = GetFreeWheelSlot(playerid);
		if(wid == -1) return SendClientMessage(playerid, X11_RED, "ERROR: You cannot add anymore wheels to your rotator.");

		PVWI[playerid][wid][pvwWheelID] = wheelid;
		format(string, sizeof(string), "You have added a new wheel to your wheel rotator. [Wheel ID: %d | Wheel Name: %s]", wheelid, GetWheelName(wheelid));
		SendClientMessage(playerid, X11_ORANGE, string);
	}
	else
	{
	    SendClientMessage(playerid, X11_RED, "ERROR: Invalid wheel ID. See /wheellist.");
	    return 1;
	}
	return 1;
}

CMD:removewheel(playerid, params[])
{
	new wslot, string[128];
	if(sscanf(params, "d", wslot))
	{
	    SendClientMessage(playerid, X11_BLUE, "CMD: /removewheel ]slot]");
        for(new i = 0; i < MAX_VEHICLEWHEELS; i++)
		{
		    if(PVWI[playerid][i][pvwWheelID] != 0)
		    {
				format(string, sizeof(string), "Wheel Slot: %d | Wheel ID: %d | Wheel Name: %s", i, PVWI[playerid][i][pvwWheelID], GetWheelName(PVWI[playerid][i][pvwWheelID]));
				SendClientMessage(playerid, X11_WHITE, string);
		    }
		}
		return 1;
	}

	if(wslot >= 0 && wslot < MAX_VEHICLEWHEELS)
	{
	    if(PVWI[playerid][wslot][pvwWheelID] != 0)
	    {
	        PVWI[playerid][wslot][pvwWheelID] = 0;
	        format(string, sizeof(string), "Wheel slot %d was removed.", wslot);
	        SendClientMessage(playerid, X11_ORANGE, string);
	    }
	    else
	    {
	        SendClientMessage(playerid, X11_RED, "ERROR: That slot doesn't contain a wheel.");
	        return 1;
	    }
	}
	else
	{
	    SendClientMessage(playerid, X11_RED, "ERROR: Invalid slot.");
	    return 1;
	}
	return 1;
}

CMD:wheellist(playerid, params[])
{
    SendClientMessage(playerid, X11_BLUE, "Listing wheel names and ID's...");
	SendClientMessage(playerid, X11_WHITE, "Wheel Name: Shadow | Wheel ID: 1073");
	SendClientMessage(playerid, X11_WHITE, "Wheel Name: Mega | Wheel ID: 1074");
	SendClientMessage(playerid, X11_WHITE, "Wheel Name: Rimshine | Wheel ID: 1053");
	SendClientMessage(playerid, X11_WHITE, "Wheel Name: Wires | Wheel ID: 1076");
	SendClientMessage(playerid, X11_WHITE, "Wheel Name: Classic | Wheel ID: 1077");
	SendClientMessage(playerid, X11_WHITE, "Wheel Name: Twist | Wheel ID: 1078");
	SendClientMessage(playerid, X11_WHITE, "Wheel Name: Cutter | Wheel ID: 1079");
	SendClientMessage(playerid, X11_WHITE, "Wheel Name: Switch | Wheel ID: 1080");
	SendClientMessage(playerid, X11_WHITE, "Wheel Name: Grove | Wheel ID: 1081");
	SendClientMessage(playerid, X11_WHITE, "Wheel Name: Import | Wheel ID: 1082");
	SendClientMessage(playerid, X11_WHITE, "Wheel Name: Dolllar | Wheel ID: 1083");
	SendClientMessage(playerid, X11_WHITE, "Wheel Name: Trance | Wheel ID: 1084");
	SendClientMessage(playerid, X11_WHITE, "Wheel Name: Atomic | Wheel ID: 1085");
	SendClientMessage(playerid, X11_WHITE, "Wheel Name: Ahab | Wheel ID: 1096");
	SendClientMessage(playerid, X11_WHITE, "Wheel Name: Virtual | Wheel ID: 1097");
	SendClientMessage(playerid, X11_WHITE, "Wheel Name: Access | Wheel ID: 1098");
	SendClientMessage(playerid, X11_WHITE, "Wheel Name: Offroad | Wheel ID: 1025");
	SendClientMessage(playerid, X11_ORANGE, "You may need to scroll up to see the entire list.");
	return 1;
}