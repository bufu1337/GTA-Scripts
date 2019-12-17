#include <a_samp>

new Incargobob[MAX_PLAYERS];
new Watching[MAX_PLAYERS];
new Float:Pos[MAX_PLAYERS][3];
new Float:Angle[MAX_PLAYERS];
new Interior[MAX_PLAYERS];
new Goto[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("  cargobob Interior Loaded!");
    CreateObject(11292, 2417.691162, -2145.928711, 497.850128, 0.0000, 0.0000, 0.0000);
    CreateObject(16775, 2418.205933, -2147.501953, 497.263794, 0.0000, 0.0000, 0.0000);
    CreateObject(16775, 2418.641846, -2143.758301, 497.298462, 0.0000, 0.0000, 0.0000);
    CreateObject(17566, 2413.567871, -2145.533203, 498.364685, 0.0000, 0.0000, 0.0000);
    CreateObject(17566, 2421.860229, -2145.739746, 498.364685, 0.0000, 0.0000, 0.0000);
    CreateObject(941, 2420.439575, -2144.412109, 497.118805, 0.0000, 0.0000, 0.0000);
    CreateObject(2063, 2418.181641, -2144.168457, 497.503082, 0.0000, 0.0000, 0.0000);
    CreateObject(2063, 2415.663086, -2144.195801, 497.628052, 0.0000, 0.0000, 0.0000);
    CreateObject(2063, 2414.292603, -2145.213379, 497.628052, 0.0000, 0.0000, 90.0000);
    CreateObject(2046, 2413.728394, -2146.952148, 497.174988, 0.0000, 0.0000, 90.0000);
    CreateObject(2046, 2413.826172, -2146.917480, 498.245087, 0.0000, 0.0000, 90.0000);
    CreateObject(3790, 2418.003296, -2144.009277, 498.392029, 0.0000, 0.0000, 0.0000);
    CreateObject(3790, 2418.041626, -2144.150879, 497.987946, 0.0000, 0.0000, 0.0000);
    CreateObject(3790, 2418.030518, -2144.150879, 497.534424, 0.0000, 0.0000, 0.0000);
    CreateObject(3790, 2418.130981, -2144.125977, 497.047485, 0.0000, 0.0000, 0.0000);
    CreateObject(1252, 2419.836914, -2144.258301, 497.844147, 0.0000, 0.0000, 0.0000);
    CreateObject(1252, 2419.834473, -2144.568848, 497.844147, 0.0000, 0.0000, 0.0000);
    CreateObject(1636, 2420.577881, -2144.541992, 497.707397, 0.0000, 0.0000, 90.0000);
    CreateObject(1654, 2421.442017, -2144.469238, 497.911438, 0.0000, 0.0000, 0.0000);
    CreateObject(1654, 2421.442627, -2144.625488, 497.911438, 0.0000, 0.0000, 0.0000);
    CreateObject(1654, 2421.455444, -2144.787109, 497.911438, 0.0000, 0.0000, 0.0000);
    CreateObject(1654, 2421.457886, -2144.997559, 497.904541, 0.0000, 0.0000, 0.0000);
    CreateObject(1672, 2421.185059, -2144.847656, 497.675079, 0.0000, 0.0000, 33.7500);
    CreateObject(1672, 2420.948853, -2144.897949, 497.687805, 0.0000, 0.0000, 56.2500);
    CreateObject(1672, 2420.757568, -2144.922852, 497.680664, 0.0000, 0.0000, 67.5000);
    CreateObject(2035, 2415.725220, -2144.327637, 497.577148, 0.0000, 0.0000, 0.0000);
    CreateObject(2035, 2415.888306, -2144.377441, 498.107727, 0.0000, 0.0000, 0.0000);
    CreateObject(2035, 2415.869141, -2144.275391, 498.336578, 0.0000, 0.0000, 0.0000);
    CreateObject(2044, 2416.512207, -2144.228027, 497.089600, 0.0000, 0.0000, 326.2500);
    CreateObject(2044, 2416.187866, -2144.252930, 497.086639, 0.0000, 0.0000, 326.2500);
    CreateObject(2690, 2421.117188, -2143.910645, 498.344666, 0.0000, 0.0000, 0.0000);
    CreateObject(2036, 2415.307983, -2144.203125, 497.087860, 0.0000, 0.0000, 0.0000);
    CreateObject(2037, 2416.387207, -2144.266602, 498.484467, 0.0000, 0.0000, 0.0000);
    CreateObject(2291, 2421.899780, -2147.017090, 496.500671, 0.0000, 0.0000, 180.0000);
    CreateObject(2291, 2421.005371, -2147.011230, 496.479675, 0.0000, 0.0000, 180.0000);
    CreateObject(2291, 2420.078369, -2147.010742, 496.483673, 0.0000, 0.0000, 180.0000);
    CreateObject(2291, 2419.558350, -2147.523438, 496.507690, 0.0000, 0.0000, 90.0000);
    CreateObject(2918, 2415.130249, -2146.292480, 497.758423, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 2416.297485, -2146.855469, 496.999878, 0.0000, 0.0000, 0.0000);
    CreateObject(2985, 2416.258301, -2146.051758, 496.625610, 0.0000, 0.0000, 270.0000);
    CreateObject(2228, 2421.249268, -2147.401855, 498.109741, 0.0000, 0.0000, 0.0000);
    CreateObject(2228, 2419.589478, -2147.401855, 498.092896, 0.0000, 0.0000, 0.0000);
    CreateObject(2237, 2414.625488, -2144.554199, 497.743195, 0.0000, 0.0000, 56.2500);
    CreateObject(2064, 2417.802246, -2146.730957, 497.273315, 0.0000, 0.0000, 247.5000);
    CreateObject(2061, 2418.184570, -2146.411621, 496.936035, 0.0000, 0.0000, 326.2500);
    CreateObject(2061, 2418.490723, -2146.598633, 496.936035, 0.0000, 0.0000, 326.2500);
    CreateObject(2061, 2418.798462, -2146.607910, 496.936035, 0.0000, 0.0000, 292.5000);
    CreateObject(2060, 2414.282715, -2145.955566, 498.518768, 0.0000, 0.0000, 270.0000);
    CreateObject(2060, 2414.247803, -2144.915527, 498.545959, 0.0000, 0.0000, 270.0000);
    CreateObject(2060, 2414.988647, -2144.195801, 498.546967, 0.0000, 0.0000, 180.0000);
    CreateObject(1242, 2414.398804, -2144.718750, 497.693939, 0.0000, 0.0000, 270.0000);
    CreateObject(1242, 2414.323730, -2144.724609, 498.136292, 0.0000, 0.0000, 270.0000);
    CreateObject(1242, 2414.398804, -2145.241211, 498.127899, 0.0000, 0.0000, 270.0000);
    CreateObject(3280, 2421.811768, -2146.600098, 498.463379, 268.8998, 0.0000, 89.3814);
    CreateObject(3280, 2421.786743, -2145.058594, 498.343018, 268.8998, 0.0000, 89.3814);
    CreateObject(3280, 2421.811768, -2146.519043, 498.363892, 267.1809, 0.0000, 274.0564);
    CreateObject(3280, 2421.761719, -2144.512207, 498.363037, 267.1809, 0.0000, 274.0564);
    CreateObject(3797, 2415.594849, -2146.420410, 498.368103, 0.0000, 0.0000, 326.2500);
}

public OnFilterScriptExit()
{
	print("  cargobob Interior Unloaded...");
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
}

public OnPlayerConnect(playerid)
{
	Incargobob[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	Incargobob[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	Incargobob[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_PASSENGER && GetVehicleModel(GetPlayerVehicleID(playerid)) == 548)
	{
     	SetPlayerPos(playerid, 2418.859253, -2145.565430, 497.988281);
     	SetPlayerFacingAngle(playerid, 0);
        SetCameraBehindPlayer(playerid);
        SetPlayerInterior(playerid, 1);
		Incargobob[playerid] = GetPlayerVehicleID(playerid);
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == 16 && Incargobob[playerid])
	{
		new Float:X, Float:Y, Float:Z;
		GetVehiclePos(Incargobob[playerid], X, Y, Z);
		SetPlayerPos(playerid, X+4, Y, Z);
		SetPlayerInterior(playerid, 0);
		Incargobob[playerid] = 0;
	}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    for(new i = 0; i <= MAX_PLAYERS; i++)
    {
        if(vehicleid == Incargobob[i])
        {
			SetPlayerHealth(i, 0);
			Incargobob[i] = 0;
			Watching[i] = 0;
			Goto[i] = 0;
        }
    }
    return 1;
}


#pragma unused Angle
#pragma unused Pos
#pragma unused Interior


