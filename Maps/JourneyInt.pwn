#include <a_samp>

new IsInJourney[MAX_PLAYERS];
new Timer[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("  ----- xxjackoxx  -----");
    print("  ----- Present Journey Int  -----");
    
CreateObject(9254, 2397.9270019531, -1713.2739257813, -47.167297363281, 0.000000, 0.000000, 0.000000); //
CreateObject(2885, 2389.0124511719, -1716.1533203125, -40.979881286621, 0.000000, 0.000000, 270); //
CreateObject(2885, 2393.830078125, -1716.0244140625, -40.979881286621, 0.000000, 0.000000, 90); //
CreateObject(2885, 2391.4201660156, -1718.9754638672, -40.979881286621, 0.000000, 0.000000, 0.000000); //
CreateObject(2885, 2391.8889160156, -1710.6071777344, -41.025550842285, 0.000000, 0.000000, 180); //
CreateObject(2527, 2389.7473144531, -1712.1853027344, -47.81685256958, 0.000000, 0.000000, 0.000000); //
CreateObject(2528, 2390.9201660156, -1711.3419189453, -47.617176055908, 0.000000, 0.000000, 0.000000); //
CreateObject(2518, 2391.3471679688, -1711.384765625, -47.730716705322, 0.000000, 0.000000, 0.000000); //
CreateObject(3055, 2388.2602539063, -1712.4587402344, -45.621444702148, 0.000000, 0.000000, 0.000000); //
CreateObject(2136, 2393.2084960938, -1717.3947753906, -47.940734863281, 0.000000, 0.000000, 270); //
CreateObject(2296, 2391.6018066406, -1718.4923095703, -47.616020202637, 0.000000, 0.000000, 180); //
CreateObject(2417, 2393.3388671875, -1716.4033203125, -47.721035003662, 0.000000, 0.000000, 270); //
CreateObject(2286, 2390.9653320313, -1712.7858886719, -45.606357574463, 0.000000, 0.000000, 0.000000); //
CreateObject(2239, 2392.0244140625, -1712.6984863281, -47.731761932373, 0.000000, 0.000000, 0.000000); //
CreateObject(14762, 2393.4826660156, -1716.6477050781, -45.56750869751, 0.000000, 0.000000, 180); //
CreateObject(3055, 2391.6254882813, -1712.8116455078, -44.533626556396, 90, 0.000000, 0.000000); //
CreateObject(3055, 2391.59765625, -1717.6613769531, -44.611110687256, 90, 0.000000, 0.000000); //
CreateObject(2948, 2393.5910644531, -1714.0437011719, -47.728107452393, 0.000000, 0.000000, 0.000000); //
CreateObject(1794, 2389.7436523438, -1716.0491943359, -47.854393005371, 0.000000, 0.000000, 0.000000); //
CreateObject(1828, 2391.1423339844, -1716.1761474609, -47.720722198486, 0.000000, 0.000000, 90); //
CreateObject(2262, 2389.7778320313, -1714.7452392578, -46.283229827881, 0.000000, 0.000000, 90); //
CreateObject(1960, 2389.25, -1716.7752685547, -46.244590759277, 0.000000, 0.000000, 90); //
CreateObject(1738, 2389.3430175781, -1715.8942871094, -47.179550170898, 0.000000, 0.000000, 90); //
CreateObject(2858, 2393.3334960938, -1717.3041992188, -46.887481689453, 0.000000, 0.000000, 0.000000); //
CreateObject(948, 2393.20703125, -1715.5140380859, -47.598487854004, 0.000000, 0.000000, 0.000000); //

	return 1;
}

public OnFilterScriptExit()
{
	print(" ----xxjackoxx----");

	return 1;
}

public OnPlayerConnect(playerid)
{
	IsInJourney[playerid] = 0;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new vehicleid = GetPlayerVehicleID(playerid);
	if(newstate == PLAYER_STATE_PASSENGER)
	{
	    if (GetVehicleModel(vehicleid) == 508 || GetVehicleModel(vehicleid) == 508)
	    {
            SetPlayerPos(playerid, 2392.7415,-1714.5696,-46.7258);
            SetPlayerTime(playerid, 00,00);
			SetPlayerFacingAngle(playerid, 0);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 1);
            Timer[playerid] = SetTimerEx("STime", 60000, 1, "i", playerid);
	        IsInJourney[playerid] = vehicleid;
	    }
	}
	return 1;
}


forward STime(playerid);


public STime(playerid)
{
	SetPlayerTime(playerid, 00,00);
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys == 16 && IsInJourney[playerid] > 0)
	{
		new Float:X,Float:Y,Float:Z;
		GetVehiclePos(IsInJourney[playerid], X, Y, Z);
		SetPlayerPos(playerid, X+4, Y, Z);
		SetPlayerInterior(playerid, 0);
		IsInJourney[playerid] = 0;
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(IsInJourney[playerid] == 1)
	{
		IsInJourney[playerid] = 0;

	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	IsInJourney[playerid] = 0;
	return 1;
}
