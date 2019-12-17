#include <a_samp>

// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("Katana War by Hor1z0n");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Katana War by Hor1z0n");
	print("----------------------------------\n");
}

#endif

public OnGameModeInit()
{
	CreateObject(3886, 1928.235229, -2848.523682, -0.597737, 0.0000, 0.0000, 0.0000);
	CreateObject(3886, 1928.268188, -2838.075195, -0.502617, 0.0000, 0.0000, 0.0000);
	CreateObject(3886, 1928.109985, -2827.900635, -0.666332, 0.0000, 0.0000, 0.0000);
	CreateObject(10828, 1931.417114, -2868.684570, 11.875670, 0.0000, 0.0000, 0.0000);
	CreateObject(10828, 1950.540649, -2850.456787, 12.587356, 0.0000, 0.0000, 82.2651);
	CreateObject(10828, 1953.693481, -2825.794434, 12.087287, 0.0000, 0.0000, 82.2651);
	CreateObject(10828, 1937.931885, -2810.729248, 12.407168, 0.0000, 0.0000, 183.5151);
	CreateObject(10828, 1913.441284, -2823.182861, 12.437818, 0.0000, 0.0000, 228.5151);
	CreateObject(10828, 1907.525269, -2851.260010, 12.494788, 0.0000, 0.0000, 296.0152);
	CreateObject(10828, 1938.343262, -2849.930176, 13.797755, 91.9597, 320.4659, 306.3283);
	CreateObject(10841, 1913.305664, -2841.531250, -0.415587, 90.2408, 0.0000, 0.0000);
	CreateObject(10841, 1912.781738, -2851.231934, -0.547268, 90.2408, 0.0000, 0.0000);
	CreateObject(10841, 1913.203613, -2831.738281, -0.445251, 90.2408, 0.0000, 0.0000);
	CreateObject(3886, 1935.142700, -2848.989502, -0.839243, 0.0000, 0.0000, 90.0000);
	CreateObject(3886, 1928.185669, -2858.763184, -0.680381, 0.0000, 0.0000, 0.0000);
	CreateObject(10841, 1912.626221, -2853.465820, 7.681755, 0.0000, 0.0000, 0.0000);
	CreateObject(10841, 1923.712769, -2841.739014, 8.189204, 0.0000, 0.0000, 90.0000);
	CreateObject(10841, 1913.610229, -2823.928223, 7.856005, 0.0000, 0.0000, 180.0000);
	CreateObject(3886, 1925.102539, -2827.332031, -0.771172, 0.0000, 0.0000, 90.0000);
	CreateObject(3886, 1938.298706, -2842.292480, -0.823836, 0.0000, 0.0000, 180.0000);
	CreateObject(3886, 1938.259399, -2832.276367, -0.919237, 0.0000, 0.0000, 180.0000);
	CreateObject(3886, 1945.348145, -2829.009033, -0.944531, 0.0000, 0.0000, 270.0000);
	CreateObject(3886, 1922.407471, -2861.875488, -0.932096, 0.0000, 0.0000, 270.0000);
	CreateObject(3886, 1918.398193, -2858.987061, -1.028431, 0.0000, 0.0000, 180.0000);
	CreateObject(10828, 1936.128906, -2820.840332, 14.449776, 89.3814, 355.7028, 175.7801);
	CreateObject(10828, 1924.147949, -2849.299805, 13.990986, 91.9597, 320.4659, 306.3283);
	CreateObject(10828, 1909.458618, -2848.725586, 13.955990, 91.9597, 320.4659, 306.3283);
	CreateObject(10828, 1937.925171, -2809.804688, 14.358390, 89.3814, 355.7028, 175.7801);
	CreateObject(10828, 1908.665039, -2828.667969, 14.383556, 89.3814, 355.7028, 232.0301);
	CreateObject(3886, 1931.768433, -2818.588867, -0.544920, 0.0000, 0.0000, 135.0000);
	CreateObject(3886, 1941.021729, -2817.452881, -0.448095, 0.0000, 0.0000, 67.5000);
	CreateObject(3886, 1947.972412, -2822.798828, -1.020304, 0.0000, 0.0000, 0.0001);
	CreateObject(3886, 1946.752563, -2836.163818, -1.052061, 0.0000, 0.0000, 168.7500);
	CreateObject(3886, 1938.072388, -2856.260742, -0.830326, 0.0000, 0.0000, 180.0000);
	CreateObject(3886, 1938.010010, -2862.999756, -0.915000, 0.0000, 0.0000, 180.0000);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/katanawar", cmdtext, true, 10) == 0)
	{
		SetPlayerPos(playerid,1914.210449, -2841.532471, 1.170496);
		SetPlayerHealth(playerid, 100);
		GivePlayerWeapon(playerid, 8, 1);
		return 1;
	}
	return 0;
}

public OnPlayerInfoChange(playerid)
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

