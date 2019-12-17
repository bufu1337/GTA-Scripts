#include <a_samp>
//#include <streamer>
#include <zcmd>
//Defines
#define MAX_CRANES 20
#define DISTANCE(%1,%2,%3,%4,%5,%6) floatsqroot((%1-%4)*(%1-%4) + (%2-%5)*(%2-%5) + (%3-%6)*(%3-%6))
//Enums
enum CRANE_ENUM
{
	EXIST,
	INUSE,
	Float:CRANE_POS_X,
	Float:CRANE_POS_Y,
	Float:CRANE_POS_Z,
	Float:PICKUP_POS_X,
	Float:PICKUP_POS_Y,
	Float:PICKUP_POS_Z,
	Float:CRANE_ANGLE,
	PICKUP,
	CRANE_TOP
}
//Arrays
new
	cranes[MAX_CRANES][CRANE_ENUM],
	usingCrane[MAX_PLAYERS][2];
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Usable Cranes by dowster");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}
stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{                                                 // Created by Y_Less
    new Float:a;
    GetPlayerPos(playerid, x, y, a);
    GetPlayerFacingAngle(playerid, a);
    if (GetPlayerVehicleID(playerid)) { GetVehicleZAngle(GetPlayerVehicleID(playerid), a); }
    x += (distance * floatsin(-a, degrees));
    y += (distance * floatcos(-a, degrees));
}
stock ShowPos(playerid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	new string[128];
	format(string, 512, "Player X: %f, Player Y: %f, Player Z: %f",x, y, z);
	SendClientMessage(playerid, 0x0000FFFF, string);
	return 1;
}
	
stock CreateCrane(row)
{
	CreateObject( 1391, cranes[row][CRANE_POS_X], cranes[row][CRANE_POS_Y], cranes[row][CRANE_POS_Z], 0, 0, 0);
	cranes[row][CRANE_TOP] = CreateObject( 1388, cranes[row][CRANE_POS_X], cranes[row][CRANE_POS_Y], (cranes[row][CRANE_POS_Z]+12.539), 0, 0, 0);
	cranes[row][PICKUP] = CreatePickup( 1317, 23 , cranes[row][PICKUP_POS_X], cranes[row][PICKUP_POS_Y], cranes[row][PICKUP_POS_Z], 0);
	cranes[row][EXIST] = 1;
	//new string[128]; //For Debug Purposes
	//format(string, 512, "Crane X: %f, Crane Y: %f, Crane Z: %f", cranes[row][CRANE_POS_X], cranes[row][CRANE_POS_Y], cranes[row][CRANE_POS_Z]); //For Debug Purposes
	//SendClientMessage(playerid, 0x0000FFFF, string); //For Debug Purposes
	return 1;
}

CMD:newcrane(playerid)
{
	new row = MAX_CRANES;
	for(new i = 0; i < MAX_CRANES; i++)
	{
		if(cranes[i][EXIST] == 0)
		{
			row = i;
		}
	}
	if(row == MAX_CRANES) return SendClientMessage(playerid, 0xFF0000FF, "No crane slots left");
	else
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, cranes[row][PICKUP_POS_X], cranes[row][PICKUP_POS_Y], z);
		GetXYInFrontOfPlayer(playerid, x, y, 6);
		cranes[row][CRANE_POS_Z] = (z + 30);
		cranes[row][PICKUP_POS_Z] =  (z - 1);
		cranes[row][CRANE_POS_Y] = y;
		cranes[row][CRANE_POS_X] = x;
		CreateCrane(row);
		//ShowPos(playerid); //For Debug Purposes
	}
	return 1;
}

CMD:crane(playerid)
{
	if(usingCrane[playerid][0] == 1)
	{
		SetPlayerPos(playerid, cranes[usingCrane[playerid][1]][PICKUP_POS_X], cranes[usingCrane[playerid][1]][PICKUP_POS_Y], (cranes[usingCrane[playerid][1]][PICKUP_POS_Z]+2));
		cranes[usingCrane[playerid][1]][INUSE] = 0;
		TogglePlayerControllable(playerid, 1);
		usingCrane[playerid][0] = 0;
		SetCameraBehindPlayer(playerid);
		return 1;
	}
	new crane = MAX_CRANES;
	for (new i = 0; i < MAX_CRANES; i++)
	{
		if (IsPlayerInRangeOfPoint(playerid, 3, cranes[i][PICKUP_POS_X], cranes[i][PICKUP_POS_Y], cranes[i][PICKUP_POS_Z]))
		{
			crane = i;
		}
	}
	if(crane == MAX_CRANES) return SendClientMessage(playerid, 0xFF0000FF, "You are not in a crane pickup!");
	if(cranes[crane][INUSE] == 1) return SendClientMessage(playerid, 0xFF0000FF, "Someone is using this crane");
	else
	{
		SetPlayerPos(playerid, cranes[crane][CRANE_POS_X], cranes[crane][CRANE_POS_Y], (cranes[crane][CRANE_POS_Z] - 30));
		SetPlayerCameraPos(playerid, cranes[crane][CRANE_POS_X], cranes[crane][CRANE_POS_Y], (cranes[crane][CRANE_POS_Z] + 20));
		SetPlayerFacingAngle(playerid, cranes[crane][CRANE_ANGLE]);
		new Float:x, Float:y;
		GetXYInFrontOfPlayer(playerid, x, y, 41);
		SetPlayerCameraLookAt(playerid, x, y, (cranes[usingCrane[playerid][1]][CRANE_POS_Z]+12.539));
		usingCrane[playerid][0] = 1;
		usingCrane[playerid][1] = crane;
		cranes[crane][INUSE] = 1;
	}
	return 1;
}
public OnPlayerUpdate(playerid)
{
	if(usingCrane[playerid][0] == 1)
	{
		new Keys,ud,lr;
		GetPlayerKeys(playerid,Keys,ud,lr);
		if(lr < 0)
		{
			new Float:fa;
			GetPlayerFacingAngle(playerid, fa);
			SetPlayerFacingAngle(playerid, (fa+1));
			cranes[usingCrane[playerid][1]][CRANE_ANGLE] = (fa + 1);
			SetObjectRot(cranes[usingCrane[playerid][1]][CRANE_TOP], 0, 0, cranes[usingCrane[playerid][1]][CRANE_ANGLE]);
			new Float:x, Float:y;
			GetXYInFrontOfPlayer(playerid, x, y, 41);
			SetPlayerCameraLookAt(playerid, x, y, (cranes[usingCrane[playerid][1]][CRANE_POS_Z]+12.539));
		}
		if(lr > 0)
		{
			new Float:fa;
			GetPlayerFacingAngle(playerid, fa);
			SetPlayerFacingAngle(playerid, (fa-1));
			cranes[usingCrane[playerid][1]][CRANE_ANGLE] = (fa - 1);
			SetObjectRot(cranes[usingCrane[playerid][1]][CRANE_TOP], 0, 0, cranes[usingCrane[playerid][1]][CRANE_ANGLE]);
			new Float:x, Float:y;
			GetXYInFrontOfPlayer(playerid, x, y, 41);
			SetPlayerCameraLookAt(playerid, x, y, (cranes[usingCrane[playerid][1]][CRANE_POS_Z]+12.539));
		}
	}
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	for(new i = 0; i < MAX_CRANES; i++)
	{
		if(pickupid == cranes[i][PICKUP])
		{
			GameTextForPlayer( playerid, "/crane", 2000, 1);
		}
	}
	return 1;
}

