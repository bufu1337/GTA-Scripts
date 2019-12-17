#include <a_samp>

new IsInBus[MAX_PLAYERS];
new Timer1[MAX_PLAYERS];
new Timer2[MAX_PLAYERS];
new Timer3[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("  ===== Bus Interior by Cybertron =======");

    CreateObject(2631, 2022.0, 2236.7, 2102.9, 0.0, 0.0, 90.0);
	CreateObject(2631, 2022.0, 2240.6, 2102.9, 0.0, 0.0, 90.0);
	CreateObject(2631, 2022.0, 2244.5, 2102.9, 0.0, 0.0, 90.0);
	CreateObject(2631, 2022.0, 2248.4, 2102.9, 0.0, 0.0, 90.0);
	CreateObject(16501, 2022.1, 2238.3, 2102.8, 0.0, 90.0, 0.0);
	CreateObject(16501, 2022.1, 2245.3, 2102.8, 0.0, 90.0, 0.0);
	CreateObject(16000, 2024.2, 2240.1, 2101.2, 0.0, 0.0, 90.0);
	CreateObject(16000, 2019.8, 2240.6, 2101.2, 0.0, 0.0, -90.0);
	CreateObject(16000, 2022.2, 2248.7, 2101.2, 0.0, 0.0, 180.0);
	CreateObject(16501, 2021.8, 2246.5, 2107.3, 0.0, 270.0, 90.0);
	CreateObject(16501, 2022.0, 2240.8, 2107.3, 0.0, 270.0, 0.0);
	CreateObject(16501, 2022.0, 2233.7, 2107.3, 0.0, 270.0, 0.0);
	CreateObject(18098, 2024.3, 2239.6, 2104.8, 0.0, 0.0, 90.0);
	CreateObject(18098, 2024.3, 2239.7, 2104.7, 0.0, 0.0, 450.0);
	CreateObject(18098, 2020.1, 2239.6, 2104.8, 0.0, 0.0, 90.0);
	CreateObject(18098, 2020.0, 2239.6, 2104.7, 0.0, 0.0, 90.0);
	CreateObject(2180, 2023.6, 2236.1, 2106.7, 0.0, 180.0, 90.0);
	CreateObject(2180, 2023.6, 2238.1, 2106.7, 0.0, 180.0, 90.0);
	CreateObject(2180, 2023.6, 2240.1, 2106.7, 0.0, 180.0, 90.0);
	CreateObject(2180, 2023.6, 2242.1, 2106.7, 0.0, 180.0, 90.0);
	CreateObject(2180, 2023.6, 2244.1, 2106.7, 0.0, 180.0, 90.0);
	CreateObject(2180, 2023.6, 2246.1, 2106.7, 0.0, 180.0, 90.0);
	CreateObject(2180, 2023.6, 2248.1, 2106.7, 0.0, 180.0, 90.0);
	CreateObject(2180, 2020.3, 2235.1, 2106.7, 0.0, 180.0, 270.0);
	CreateObject(2180, 2020.3, 2237.1, 2106.7, 0.0, 180.0, 270.0);
	CreateObject(2180, 2020.3, 2239.1, 2106.7, 0.0, 180.0, 270.0);
	CreateObject(2180, 2020.3, 2241.1, 2106.7, 0.0, 180.0, 270.0);
	CreateObject(2180, 2020.3, 2243.1, 2106.7, 0.0, 180.0, 270.0);
	CreateObject(2180, 2020.3, 2245.1, 2106.7, 0.0, 180.0, 270.0);
	CreateObject(2674, 2023.4, 2238.3, 2102.9, 0.0, 0.0, 600.0);
	CreateObject(2674, 2020.4, 2242.3, 2102.9, 0.0, 0.0, 600.0);
	CreateObject(2674, 2023.4, 2246.3, 2102.9, 0.0, 0.0, 600.0);
	CreateObject(14405, 2022.0, 2242.1, 2103.5, 0.0, 0.0, 540.0);
	CreateObject(14405, 2022.0, 2243.6, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2022.0, 2245.1, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2022.0, 2246.6, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2022.0, 2248.1, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2022.0, 2249.6, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2022.0, 2251.1, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2024.6, 2242.1, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2024.6, 2243.6, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2024.6, 2245.1, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2024.6, 2246.6, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2024.6, 2248.1, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2024.6, 2249.6, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2024.6, 2251.1, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2019.4, 2242.1, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2019.4, 2243.6, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2019.4, 2245.1, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2019.4, 2246.6, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2019.4, 2248.1, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2019.4, 2249.6, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2019.4, 2251.1, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(14405, 2022.0, 2253.6, 2104.0, -6.0, 0.0, 180.0);
	CreateObject(14405, 2021.1, 2253.6, 2104.0, -6.0, 0.0, 180.0);
	CreateObject(14405, 2024.6, 2253.6, 2103.5, 0.0, 0.0, 180.0);
	CreateObject(2674, 2020.4, 2235.7, 2102.9, 0.0, 0.0, 52.0);
	CreateObject(2673, 2020.4, 2246.7, 2102.9, 0.0, 0.0, 270.0);
	CreateObject(2700, 2023.5, 2235.1, 2105.5, 180.0, -4.0, 90.0);
	CreateObject(2700, 2020.4, 2235.1, 2105.5, 180.0, 0.0, 90.0);
	CreateObject(2700, 2023.5, 2242.1, 2105.5, 180.0, -4.0, 90.0);
	CreateObject(2700, 2020.4, 2242.1, 2105.5, 180.0, 0.0, 90.0);
	CreateObject(1799, 2023.1, 2234.2, 2105.7, 270.0, 0.0, 360.0);
	CreateObject(1799, 2019.8, 2234.2, 2105.7, 270.0, 0.0, 0.0);
	CreateObject(1538, 2022.7, 2234.7, 2102.8, 0.0, 0.0, 180.0);
	CreateObject(1799, 2022.1, 2234.2, 2106.1, 720.0, 90.0, 450.0);
	CreateObject(1799, 2021.8, 2234.2, 2105.1, 0.0, 270.0, 270.0);
	CreateObject(1799, 2022.1, 2234.2, 2107.3, 0.0, 90.0, 90.0);
	CreateObject(1799, 2021.6, 2234.2, 2106.3, 0.0, 270.0, 270.0);
	CreateObject(1799, 2022.3, 2234.2, 2104.3, 90.0, 0.0, 180.0);
	
	return 1;
}

public OnFilterScriptExit()
{
	print("  ==== Bus Interior Unloaded ======");
	
	return 1;
}

public OnPlayerConnect(playerid)
{
	IsInBus[playerid] = 0;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new vehicleid = GetPlayerVehicleID(playerid);
	if(newstate == PLAYER_STATE_PASSENGER)
	{
	    if (GetVehicleModel(vehicleid) == 431 || GetVehicleModel(vehicleid) == 437)
	    {
            SetPlayerPos(playerid, 2022.0273, 2235.2402, 2103.9536);
            SetPlayerTime(playerid, 00,00);
			SetPlayerFacingAngle(playerid, 0);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 1);
            Timer1[playerid] = SetTimerEx("HornA", 60000, 1, "i", playerid);
            Timer2[playerid] = SetTimerEx("HornB", 60500, 1, "i", playerid);
            Timer3[playerid] = SetTimerEx("STime", 60000, 1, "i", playerid);
	        IsInBus[playerid] = vehicleid;
	    }
	}
	return 1;
}

forward HornA(playerid);
forward HornB(playerid);
forward STime(playerid);

public HornA(playerid)
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	PlayerPlaySound(playerid, 1147, X, Y, Z);
}

public HornB(playerid)
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	PlayerPlaySound(playerid, 1147, X, Y+5, Z);
}

public STime(playerid)
{
	SetPlayerTime(playerid, 00,00);
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys == 16 && IsInBus[playerid] > 0)
	{
		new Float:X,Float:Y,Float:Z;
		GetVehiclePos(IsInBus[playerid], X, Y, Z);
		SetPlayerPos(playerid, X+4, Y, Z);
		SetPlayerInterior(playerid, 0);
		KillTimer(Timer1[playerid]);
		KillTimer(Timer2[playerid]);
		IsInBus[playerid] = 0;
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/gotobus", cmdtext, true, 8) == 0)
	{
	    if(IsPlayerAdmin(playerid))
	    {
  		   	SetPlayerPos(playerid, 2022.0273, 2235.2402, 2103.9536);
  		 	SetPlayerFacingAngle(playerid, 0);
        	SetCameraBehindPlayer(playerid);
           	SetPlayerInterior(playerid, 1);
        }
        else return 0;
		return 1;
	}
	return 0;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(IsInBus[playerid] == 1)
	{
		IsInBus[playerid] = 0;
  		KillTimer(Timer1[playerid]);
		KillTimer(Timer2[playerid]);
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	IsInBus[playerid] = 0;
	return 1;
}
