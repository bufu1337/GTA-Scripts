#include <a_samp>

new InCamper[MAX_PLAYERS];
new Watching[MAX_PLAYERS];
new Float:Pos[MAX_PLAYERS][3];
new Float:Angle[MAX_PLAYERS];
new Interior[MAX_PLAYERS];
new Goto[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("  Camper Interior Loaded!");
	CreateObject(11292, 2653.935059, -1975.493042, 401.083130, 0.0000, 0.0000, 0.0000);
	CreateObject(2395, 2651.801270, -1976.931396, 399.877106, 0.0000, 0.0000, 180.0000);
	CreateObject(2395, 2649.746094, -1976.510864, 399.877106, 0.0000, 0.0000, 90.0000);
	CreateObject(2395, 2649.090820, -1973.446167, 399.877106, 0.0000, 0.0000, 0.0000);
	CreateObject(1523, 2652.284668, -1977.110352, 399.877655, 0.0000, 0.0000, 90.0000);
	CreateObject(2395, 2652.416504, -1975.119629, 399.871368, 0.0000, 0.0000, 90.0000);
	CreateObject(2395, 2652.158203, -1972.359009, 399.864197, 0.0000, 0.0000, 270.0000);
	CreateObject(1533, 2658.222656, -1974.321899, 399.871216, 0.0000, 0.0000, 270.0000);
	CreateObject(14527, 2656.144043, -1975.185059, 400.203613, 0.0000, 0.0000, 0.0000);
	CreateObject(2841, 2656.116699, -1975.710205, 399.877106, 0.0000, 0.0000, 0.0000);
	CreateObject(2842, 2650.073242, -1974.266113, 399.859619, 0.0000, 0.0000, 0.0000);
	CreateObject(2739, 2650.619629, -1973.830566, 399.876312, 0.0000, 0.0000, 0.0000);
	CreateObject(2738, 2650.137695, -1973.767334, 400.479950, 0.0000, 0.0000, 0.0000);
	CreateObject(2527, 2650.277832, -1975.551636, 399.869293, 0.0000, 0.0000, 180.0000);
	CreateObject(2515, 2651.110840, -1973.647705, 400.929321, 0.0000, 0.0000, 0.0000);
	CreateObject(2297, 2652.445801, -1975.238159, 399.871124, 0.0000, 0.0000, 45.0000);
	CreateObject(2299, 2654.803223, -1976.441650, 399.870972, 0.0000, 0.0000, 270.0000);
	CreateObject(2332, 2655.305664, -1976.587891, 400.339996, 0.0000, 0.0000, 180.0000);
	CreateObject(2231, 2652.302734, -1975.072998, 400.601929, 0.0000, 0.0000, 90.0000);
	CreateObject(2231, 2652.311035, -1973.453247, 400.621307, 0.0000, 0.0000, 90.0000);
	CreateObject(2005, 2655.277832, -1976.672607, 400.249115, 0.0000, 0.0000, 180.0000);
	CreateObject(1808, 2654.663574, -1976.832397, 399.871948, 0.0000, 0.0000, 180.0000);
	CreateObject(1736, 2655.063477, -1973.679565, 401.805695, 0.0000, 0.0000, 0.0000);
	CreateObject(1738, 2657.419434, -1973.573730, 400.456757, 0.0000, 0.0000, 0.0000);
	CreateObject(2292, 2654.869629, -1973.841797, 399.875671, 0.0000, 0.0000, 270.0000);
	CreateObject(2292, 2654.866699, -1974.741089, 399.875671, 0.0000, 0.0000, 180.0000);
	CreateObject(1742, 2655.899902, -1973.254150, 399.887665, 0.0000, 0.0000, 0.0000);
	CreateObject(1746, 2653.577637, -1973.885864, 399.872040, 0.0000, 0.0000, 0.0000);
}

public OnFilterScriptExit()
{
	print("  Camper Interior Unloaded...");
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
	DestroyObject(16);
	DestroyObject(17);
	DestroyObject(18);
	DestroyObject(19);
	DestroyObject(20);
	DestroyObject(21);
	DestroyObject(22);
	DestroyObject(23);
	DestroyObject(24);
	DestroyObject(25);
	DestroyObject(26);
	DestroyObject(27);
	DestroyObject(28);
}

public OnPlayerConnect(playerid)
{
	InCamper[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	InCamper[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	InCamper[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_PASSENGER && GetVehicleModel(GetPlayerVehicleID(playerid)) == 483)
	{
     	SetPlayerPos(playerid, 2657.091309, -1974.997559, 401.196289);
     	SetPlayerFacingAngle(playerid, 0);
        SetCameraBehindPlayer(playerid);
        SetPlayerInterior(playerid, 1);
		InCamper[playerid] = GetPlayerVehicleID(playerid);
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == 16 && InCamper[playerid])
	{
		new Float:X, Float:Y, Float:Z;
		GetVehiclePos(InCamper[playerid], X, Y, Z);
		SetPlayerPos(playerid, X+4, Y, Z);
		SetPlayerInterior(playerid, 0);
		InCamper[playerid] = 0;
	}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    for(new i = 0; i <= MAX_PLAYERS; i++)
    {
        if(vehicleid == InCamper[i])
        {
			SetPlayerHealth(i, 0);
			InCamper[i] = 0;
			Watching[i] = 0;
			Goto[i] = 0;
        }
    }
    return 1;
}


#pragma unused Angle
#pragma unused Pos
#pragma unused Interior


