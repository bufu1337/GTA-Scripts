#include <a_samp>

new Inenforcer[MAX_PLAYERS];
new Watching[MAX_PLAYERS];
new Float:Pos[MAX_PLAYERS][3];
new Float:Angle[MAX_PLAYERS];
new Interior[MAX_PLAYERS];
new Goto[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("  enforcer Interior Loaded!");
    CreateObject(11292, 2081.333496, -1375.118530, 300.764832, 0.0000, 0.0000, 0.0000);
    CreateObject(976, 2081.332031, -1368.392456, 299.178619, 0.0000, 0.0000, 270.0000);
    CreateObject(974, 2077.989258, -1376.559937, 300.831085, 0.0000, 0.0000, 0.0000);
    CreateObject(974, 2077.123047, -1374.362671, 300.655640, 0.0000, 0.0000, 270.0000);
    CreateObject(974, 2078.161133, -1373.030640, 300.330536, 0.0000, 0.0000, 0.0000);
    CreateObject(2395, 2080.772949, -1376.560547, 299.490601, 0.0000, 0.0000, 180.0000);
    CreateObject(1533, 2085.592773, -1373.328857, 299.552917, 0.0000, 0.0000, 270.0000);
    CreateObject(1533, 2085.569824, -1374.802246, 299.539307, 0.0000, 0.0000, 270.0000);
    CreateObject(1754, 2083.981445, -1373.538574, 299.553741, 0.0000, 0.0000, 0.0000);
    CreateObject(1754, 2083.128906, -1373.539063, 299.553741, 0.0000, 0.0000, 0.0000);
    CreateObject(1754, 2082.262695, -1373.549194, 299.553741, 0.0000, 0.0000, 0.0000);
    CreateObject(2063, 2083.147461, -1376.328369, 300.467773, 0.0000, 0.0000, 180.0000);
    CreateObject(2606, 2083.026855, -1376.472412, 301.498108, 0.0000, 0.0000, 180.0000);
    CreateObject(1771, 2078.658691, -1375.866943, 299.992523, 0.0000, 0.0000, 90.0000);
    CreateObject(1808, 2084.688965, -1373.058960, 299.553650, 0.0000, 0.0000, 0.0000);
    CreateObject(2103, 2083.819824, -1376.272217, 300.833984, 0.0000, 0.0000, 180.0000);
    CreateObject(2514, 2077.520996, -1373.509888, 299.558014, 0.0000, 0.0000, 0.0000);
    CreateObject(2523, 2077.728027, -1373.486938, 299.378540, 0.0000, 0.0000, 0.0000);
    CreateObject(2817, 2077.505371, -1374.029419, 299.558380, 0.0000, 0.0000, 0.0000);
    CreateObject(1672, 2083.020996, -1376.322266, 300.889191, 0.0000, 0.0000, 0.0000);
    CreateObject(1672, 2082.845703, -1376.347290, 300.887634, 0.0000, 0.0000, 0.0000);
    CreateObject(2035, 2082.496094, -1376.297241, 300.420898, 0.0000, 0.0000, 0.0000);
    CreateObject(2044, 2083.236816, -1376.297241, 300.415588, 0.0000, 0.0000, 326.2500);
    CreateObject(2044, 2083.569336, -1376.322266, 300.414001, 0.0000, 0.0000, 326.2500);
    CreateObject(2044, 2083.948730, -1376.322266, 300.421326, 0.0000, 0.0000, 326.2500);
    CreateObject(2690, 2085.007813, -1376.560669, 300.435913, 0.0000, 0.0000, 180.0000);
    CreateObject(1279, 2082.449707, -1376.334839, 299.890808, 0.0000, 0.0000, 0.0000);
    CreateObject(1279, 2083.660645, -1376.330078, 299.865814, 0.0000, 0.0000, 0.0000);
    CreateObject(1580, 2082.326172, -1376.297241, 300.787231, 0.0000, 0.0000, 0.0000);
}

public OnFilterScriptExit()
{
	print("  enforcer Interior Unloaded...");
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
	DestroyObject(30);
	DestroyObject(31);
	DestroyObject(32);
	DestroyObject(33);
	DestroyObject(34);
	DestroyObject(35);
	DestroyObject(36);
	DestroyObject(37);
	DestroyObject(38);
	DestroyObject(39);
	DestroyObject(40);
	DestroyObject(41);
	DestroyObject(42);
	DestroyObject(43);
	DestroyObject(44);
	DestroyObject(45);
	DestroyObject(46);
	DestroyObject(47);
	DestroyObject(48);
	DestroyObject(49);
	DestroyObject(50);
	DestroyObject(51);
	DestroyObject(52);
	DestroyObject(53);
	DestroyObject(54);
	DestroyObject(55);
	DestroyObject(56);
	DestroyObject(57);
	DestroyObject(58);
	DestroyObject(59);
	DestroyObject(60);
	DestroyObject(61);
	DestroyObject(62);
}

public OnPlayerConnect(playerid)
{
	Inenforcer[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	Inenforcer[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	Inenforcer[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_PASSENGER && GetVehicleModel(GetPlayerVehicleID(playerid)) == 427)
	{
     	SetPlayerPos(playerid, 2084.479980, -1374.825928, 300.628052);
     	SetPlayerFacingAngle(playerid, 0);
        SetCameraBehindPlayer(playerid);
        SetPlayerInterior(playerid, 1);
		Inenforcer[playerid] = GetPlayerVehicleID(playerid);
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == 16 && Inenforcer[playerid])
	{
		new Float:X, Float:Y, Float:Z;
		GetVehiclePos(Inenforcer[playerid], X, Y, Z);
		SetPlayerPos(playerid, X+4, Y, Z);
		SetPlayerInterior(playerid, 0);
		Inenforcer[playerid] = 0;
	}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    for(new i = 0; i <= MAX_PLAYERS; i++)
    {
        if(vehicleid == Inenforcer[i])
        {
			SetPlayerHealth(i, 0);
			Inenforcer[i] = 0;
			Watching[i] = 0;
			Goto[i] = 0;
        }
    }
    return 1;
}


#pragma unused Angle
#pragma unused Pos
#pragma unused Interior


