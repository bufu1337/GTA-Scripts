#include <M.I.C>

#if defined FILTERSCRIPT
public OnFilterScriptInit()
{
	print("\n------------[ MIC ]---[ 1.0 ]----");
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
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
	print("\n------------[ MIC ]---[ 1.0 ]----");
	print("\n----------------------------------");
	print(" Blank Script by your name here");
	print("----------------------------------\n");
}
#endif

public OnGameModeInit()
{
	SetGameModeText("My Game Mode [ MIC ]");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	ToggleRealClock(0);
	EnableGantonGym(1);
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

public OnPlayerEnterCheckpoint(checkpointid,playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(checkpointid,playerid)
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
public OnPlayerEnterZone(playerid,zoneid)
{
	return 1;
}

public OnPlayerLeaveZone(playerid,zoneid)
{
	return 1;
}

public OnPlayerPickPik(playerid,pikid)
{
	return 1;
}

public OnPlayerKeyPress(playerid,key)
{
	return 1;
}

public OnPlayerEnterHouse(playerid,houseid)
{
	SetPlayerVirtualWorld(playerid,worldid);
	return 1;
}

public OnPlayerEnterBiz(playerid,bizid)
{
	SetPlayerVirtualWorld(playerid,worldid);
	return 1;
}

public OnPlayerLeaveHouse(playerid,houseid)
{
	SetPlayerVirtualWorld(playerid,0);
	return 1;
}

public OnPlayerLeaveBiz(playerid,bizid)
{
	SetPlayerVirtualWorld(playerid,0);
	return 1;
}

public OnPlayerRentHouse(playerid,houseid)
{
	return 1;
}

public OnPlayerBuyHouse(playerid,houseid)
{
	return 1;
}

public OnPlayerBuyBiz(playerid,bizid)
{
	return 1;
}

public OnPlayerSellHouse(playerid,houseid)
{
	return 1;
}

public OnPlayerSellBiz(playerid,bizid)
{
	return 1;
}

