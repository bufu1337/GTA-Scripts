#include <a_samp>

new Intropic[MAX_PLAYERS];
new Watching[MAX_PLAYERS];
//new Float:Pos[MAX_PLAYERS][3];
//new Float:Angle[MAX_PLAYERS];
//new Interior[MAX_PLAYERS];
new Goto[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("  Tropic Interior Loaded!");
    CreateObject(11292, 1610.404297, 615.577942, 2.593594, 0.0000, 0.0000, 303.7500);
    CreateObject(2395, 1609.096680, 615.235535, 1.435197, 0.0000, 0.0000, 90.0000);
    CreateObject(2395, 1609.168457, 618.093506, 1.216520, 0.0000, 0.0000, 337.5000);
    CreateObject(1536, 1613.025391, 612.061829, 1.334850, 0.0000, 0.0000, 33.7500);
    CreateObject(1754, 1609.324219, 617.752808, 1.238446, 0.0000, 0.0000, 33.7500);
    CreateObject(2139, 1611.698730, 611.811401, 1.317648, 0.0000, 0.0000, 123.7499);
    CreateObject(2141, 1611.106445, 612.611633, 1.369593, 0.0000, 0.0000, 123.7499);
    CreateObject(2208, 1609.448730, 614.549255, 1.425490, 0.0000, 0.0000, 303.7500);
    CreateObject(2292, 1609.450684, 617.566956, 1.220647, 0.0000, 0.0000, 348.7500);
    CreateObject(2291, 1609.369141, 616.249207, 1.216878, 0.0000, 0.0000, 90.0000);
    CreateObject(2291, 1609.365723, 615.375061, 1.202157, 0.0000, 0.0000, 90.0000);
    CreateObject(2291, 1609.770996, 617.571960, 1.216375, 0.0000, 0.0000, 337.5000);
    CreateObject(2291, 1610.567871, 617.246643, 1.216375, 0.0000, 0.0000, 337.5000);
    CreateObject(2291, 1611.377930, 616.900085, 1.221709, 0.0000, 0.0000, 337.5000);
    CreateObject(2291, 1609.377441, 614.486633, 1.205709, 0.0000, 0.0000, 90.0000);
    CreateObject(1664, 1610.467285, 613.434509, 2.458188, 0.0000, 0.0000, 0.0000);
    CreateObject(1667, 1610.087402, 614.103760, 2.379401, 0.0000, 0.0000, 0.0000);
    CreateObject(1667, 1610.038574, 614.291382, 2.388065, 0.0000, 0.0000, 0.0000);
    CreateObject(1668, 1610.626953, 613.254639, 2.457193, 0.0000, 0.0000, 0.0000);
    CreateObject(1669, 1610.332520, 613.610596, 2.465527, 0.0000, 0.0000, 0.0000);
    CreateObject(1659, 1610.193848, 616.563293, 3.779366, 0.0000, 0.0000, 0.0000);
    CreateObject(1717, 1612.576660, 616.180786, 1.304539, 0.0000, 0.0000, 202.5000);
    CreateObject(1736, 1610.104004, 613.841919, 3.258557, 0.0000, 0.0000, 123.7499);
    CreateObject(1828, 1611.966797, 614.091125, 1.379279, 0.0000, 0.0000, 303.7500);
    CreateObject(2002, 1612.984863, 614.643860, 1.355110, 0.0000, 0.0000, 303.7500);
    CreateObject(2103, 1609.483887, 614.374329, 2.290238, 0.0000, 0.0000, 123.7500);
}

public OnFilterScriptExit()
{
	print("  Tropic Interior Unloaded...");
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
	DestroyObject(29);
}

public OnPlayerConnect(playerid)
{
	Intropic[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	Intropic[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	Intropic[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_PASSENGER && GetVehicleModel(GetPlayerVehicleID(playerid)) == 454)
	{
     	SetPlayerPos(playerid, 1612.906738, 613.277405, 2.310597);
     	SetPlayerFacingAngle(playerid, 0);
        SetCameraBehindPlayer(playerid);
        SetPlayerInterior(playerid, 1);
		Intropic[playerid] = GetPlayerVehicleID(playerid);
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == 16 && Intropic[playerid])
	{
		new Float:X, Float:Y, Float:Z;
		GetVehiclePos(Intropic[playerid], X, Y, Z);
		SetPlayerPos(playerid, X+4, Y, Z);
		SetPlayerInterior(playerid, 0);
		Intropic[playerid] = 0;
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(GetVehicleModel(vehicleid) == 454 && ispassenger == 1)
    {
    PutPlayerInVehicle(playerid, vehicleid, 1);
    TogglePlayerControllable(playerid, 1);
    Intropic[playerid] = vehicleid;
    }
    return 1;
}

