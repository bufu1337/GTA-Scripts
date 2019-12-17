#include <a_samp>

new Indune[MAX_PLAYERS];
new Watching[MAX_PLAYERS];
new Float:Pos[MAX_PLAYERS][3];
new Float:Angle[MAX_PLAYERS];
new Interior[MAX_PLAYERS];
new Goto[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("  dune Interior Loaded!");
    CreateObject(11292, 2014.717773, -1226.941284, 582.552307, 0.0000, 0.0000, 0.0000);
    CreateObject(2395, 2010.905762, -1224.911987, 581.339722, 0.0000, 0.0000, 0.0000);
    CreateObject(2395, 2014.602539, -1224.919312, 581.340881, 0.0000, 0.0000, 0.0000);
    CreateObject(2395, 2018.197266, -1224.926636, 581.348694, 0.0000, 0.0000, 0.0000);
    CreateObject(2395, 2018.967773, -1225.281616, 581.346985, 0.0000, 0.0000, 270.0000);
    CreateObject(2395, 2018.663086, -1228.169922, 581.108276, 0.0000, 0.0000, 180.0000);
    CreateObject(2395, 2014.998535, -1228.165527, 581.121704, 0.0000, 0.0000, 180.0000);
    CreateObject(2395, 2011.385254, -1228.161133, 581.112366, 0.0000, 0.0000, 180.0000);
    CreateObject(2395, 2010.565430, -1228.072388, 581.103455, 0.0000, 0.0000, 90.0000);
    CreateObject(1965, 2019.011719, -1225.136475, 582.852234, 0.0000, 0.0000, 180.0000);
    CreateObject(1965, 2019.015137, -1227.870850, 582.833130, 0.0000, 0.0000, 0.0004);
    CreateObject(937, 2011.427246, -1227.867798, 581.821045, 0.0000, 0.0000, 0.0000);
    CreateObject(1742, 2013.321777, -1228.314331, 581.341797, 0.0000, 0.0000, 180.0000);
    CreateObject(1744, 2014.671387, -1224.875122, 582.770325, 0.0000, 0.0000, 0.0000);
    CreateObject(1758, 2010.774902, -1226.742188, 581.341980, 0.0000, 0.0000, 33.7500);
    CreateObject(2007, 2014.318359, -1227.746704, 581.291870, 0.0000, 0.0000, 180.0000);
    CreateObject(1659, 2013.692871, -1226.727295, 583.754700, 0.0000, 0.0000, 0.0000);
    CreateObject(1661, 2013.758789, -1226.743530, 583.712646, 0.0000, 0.0000, 0.0000);
    CreateObject(1736, 2010.820313, -1226.567017, 583.200623, 0.0000, 0.0000, 90.0000);
    CreateObject(1749, 2010.811035, -1228.064697, 582.291260, 0.0000, 0.0000, 180.0000);
    CreateObject(1782, 2011.802734, -1227.798828, 582.380066, 0.0000, 0.0000, 180.0000);
    CreateObject(1797, 2014.110840, -1227.479004, 581.339905, 0.0000, 0.0000, 270.0000);
    CreateObject(1808, 2013.142090, -1225.064331, 581.341187, 0.0000, 0.0000, 0.0000);
    CreateObject(1828, 2014.264160, -1226.538086, 581.344055, 0.0000, 0.0000, 0.0000);
    CreateObject(1829, 2011.408691, -1225.324585, 581.810852, 0.0000, 0.0000, 90.0000);
    CreateObject(1841, 2015.937988, -1225.171265, 583.098389, 0.0000, 0.0000, 90.0000);
    CreateObject(1841, 2014.345703, -1225.187012, 583.108643, 0.0000, 0.0000, 90.0000);
    CreateObject(1839, 2015.188965, -1225.096191, 583.080627, 0.0000, 0.0000, 90.0000);
    CreateObject(2192, 2011.032227, -1225.686646, 582.289246, 0.0000, 0.0000, 225.0000);
    CreateObject(2229, 2018.929688, -1225.307739, 581.346313, 0.0000, 0.0000, 270.0000);
    CreateObject(2229, 2019.124023, -1228.404663, 581.346313, 0.0000, 0.0000, 270.0000);
}

public OnFilterScriptExit()
{
	print("  dune Interior Unloaded...");
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
	Indune[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	Indune[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	Indune[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_PASSENGER && GetVehicleModel(GetPlayerVehicleID(playerid)) == 573)
	{
     	SetPlayerPos(playerid, 2017.419922, -1226.117920, 582.591797);
     	SetPlayerFacingAngle(playerid, 0);
        SetCameraBehindPlayer(playerid);
        SetPlayerInterior(playerid, 1);
		Indune[playerid] = GetPlayerVehicleID(playerid);
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == 16 && Indune[playerid])
	{
		new Float:X, Float:Y, Float:Z;
		GetVehiclePos(Indune[playerid], X, Y, Z);
		SetPlayerPos(playerid, X+4, Y, Z);
		SetPlayerInterior(playerid, 0);
		Indune[playerid] = 0;
	}
	return 1;
	}
	
public OnVehicleDeath(vehicleid, killerid)
{
    for(new i = 0; i <= MAX_PLAYERS; i++)
    {
        if(vehicleid == Indune[i])
        {
			SetPlayerHealth(i, 0);
			Indune[i] = 0;
			Watching[i] = 0;
			Goto[i] = 0;
        }
    }
    return 1;
}



#pragma unused Angle
#pragma unused Pos
#pragma unused Interior


