#include <a_samp>

new Invan[MAX_PLAYERS];
new Watching[MAX_PLAYERS];
//new Float:Pos[MAX_PLAYERS][3];
//new Float:Angle[MAX_PLAYERS];
//new Interior[MAX_PLAYERS];
new Goto[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("  van Interior Loaded!");
    CreateObject(11292, 4058.344727, -914.495117, 138.562683, 0.0000, 0.0000, 0.0000);
    CreateObject(2395, 4056.847900, -915.557068, 137.356659, 0.0000, 0.0000, 90.0000);
    CreateObject(1493, 4062.606445, -912.755554, 137.348099, 0.0000, 0.0000, 270.0000);
    CreateObject(1493, 4062.608887, -915.780823, 137.348099, 0.0000, 0.0000, 90.0000);
    CreateObject(1663, 4058.348877, -913.866211, 137.816879, 0.0000, 0.0000, 135.0000);
    CreateObject(3397, 4058.476318, -912.654968, 137.229477, 0.0000, 0.0000, 90.0000);
    CreateObject(3396, 4060.683350, -912.664001, 137.229477, 0.0000, 0.0000, 90.0000);
    CreateObject(1663, 4060.648682, -913.759338, 137.785034, 0.0000, 0.0000, 135.0000);
    CreateObject(3388, 4057.165771, -915.573486, 137.156708, 0.0000, 0.0000, 270.0000);
    CreateObject(3389, 4058.150635, -915.572021, 137.356659, 0.0000, 0.0000, 270.0000);
    CreateObject(3387, 4059.139893, -915.551331, 137.356659, 0.0000, 0.0000, 270.0000);
    CreateObject(3386, 4060.137451, -915.545837, 136.981750, 0.0000, 0.0000, 270.0000);
    CreateObject(2596, 4060.627686, -912.706665, 139.171539, 0.0000, 0.0000, 0.0000);
    CreateObject(2818, 4058.974365, -914.695984, 137.349045, 0.0000, 0.0000, 0.0000);
    CreateObject(2606, 4056.803711, -913.815796, 139.517899, 0.0000, 0.0000, 90.0000);
    CreateObject(2606, 4056.803711, -913.817139, 139.067825, 0.0000, 0.0000, 90.0000);
}

public OnFilterScriptExit()
{
	print("  Van Interior Unloaded...");
	DestroyObject(1);
	DestroyObject(2);
	DestroyObject(3);
	DestroyObject(4);
	DestroyObject(5);
	DestroyObject(6);
	DestroyObject(7);
	DestroyObject(8);
	DestroyObject(9);
	DestroyObject(10);
	DestroyObject(11);
	DestroyObject(12);
	DestroyObject(13);
	DestroyObject(14);
	DestroyObject(15);
}

public OnPlayerConnect(playerid)
{
	Invan[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	Invan[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	Invan[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_PASSENGER && GetVehicleModel(GetPlayerVehicleID(playerid)) == 582)
	{
     	SetPlayerPos(playerid, 4061.719727, -914.996704, 138.026016);
     	SetPlayerFacingAngle(playerid, 0);
        SetCameraBehindPlayer(playerid);
        SetPlayerInterior(playerid, 1);
		Invan[playerid] = GetPlayerVehicleID(playerid);
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == 16 && Invan[playerid] > 0)
	{
		new Float:X, Float:Y, Float:Z;
		GetVehiclePos(Invan[playerid], X, Y, Z);
		SetPlayerPos(playerid, X+4, Y, Z);
		SetPlayerInterior(playerid, 0);
		Invan[playerid] = 0;
	}
	return 1;
}

