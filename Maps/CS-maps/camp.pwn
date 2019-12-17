#include <a_samp>

#pragma tabsize 0

//---------------COLOURS----------------
#define WHITE_COLOR  0xFFFFFFAA // white
#define BLUE_COLOR 0x0000BBAA // blue
#define COLOR_RED 0xAA3333AA //red

//--------GM EXIT And Restaarter----------
forward GameModeExitFunc();
forward Restart();
forward mapname();

//----Game Over---
forward OVER();

//---TEAMS-----
#define TEAM_1 0
#define TEAM_2 1

//--TEAM DEFINE------
new Team[MAX_PLAYERS];

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
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
	print("\n----------------------------------");
	print(" Loaded Camp LV");
	print("----------------------------------\n");
}

#endif

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("  CS-MAPS  ");
	SetTimer("mapname", 1000,false);
	ShowPlayerMarkers(0);
	SetWeather(15);
	UsePlayerPedAnims();
	SetWorldTime(12);

	//-------10 minutes-----------
 	SetTimer("OVER", 600000, 0);


	AddPlayerClass(285,41.9064,1370.6542,9.1719,134.0735,31,4000,25,100,17,18); // CTCamp
	AddPlayerClass(179,-32.6649,1362.4492,9.2003,310.7718,30,4000,25,100,17,18); // TCamp

	CreateObject(3243, -10.798485, 1338.472412, 8.206940, 0.0000, 0.0000, 11.2500);
	CreateObject(3504, 21.584732, 1388.450195, 9.514238, 0.0000, 0.0000, 337.5000);
	CreateObject(3504, 21.858498, 1380.147217, 9.514238, 0.0000, 0.0000, 281.2500);
	CreateObject(3504, 15.164641, 1384.818848, 9.514238, 0.0000, 0.0000, 0.0000);
	CreateObject(18234, 50.501270, 1383.067383, 9.475988, 0.0000, 0.0000, 11.2499);
	CreateObject(987, 45.005245, 1392.054810, 9.427811, 0.0000, 0.0000, 157.5000);
	CreateObject(987, 34.051147, 1396.475708, 9.411490, 0.0000, 0.0000, 157.5000);
	CreateObject(987, 23.301104, 1401.331787, 9.042052, 0.0000, 0.0000, 157.5000);
	CreateObject(987, 12.301994, 1405.995850, 9.127668, 0.0000, 0.0000, 168.7500);
	CreateObject(987, 0.316235, 1408.633789, 9.169403, 0.0000, 0.0000, 180.0000);
	CreateObject(987, -12.037277, 1409.141113, 9.112035, 0.0000, 0.0000, 180.0000);
	CreateObject(987, -24.124298, 1409.259155, 9.192215, 0.0000, 0.0000, 202.5000);
	CreateObject(987, -35.885452, 1405.435181, 8.864407, 0.0000, 0.0000, 236.2501);
	CreateObject(987, -42.737762, 1395.513550, 8.685099, 0.0000, 0.0000, 270.0000);
	CreateObject(987, -42.979485, 1383.367310, 8.597017, 0.0000, 0.0000, 270.0000);
	CreateObject(987, -43.349739, 1370.919312, 8.507059, 0.0000, 0.0000, 270.0000);
	CreateObject(987, -43.432739, 1358.853149, 8.501451, 0.0000, 0.0000, 281.2500);
	CreateObject(987, -41.451767, 1346.110596, 8.623877, 0.0000, 0.0000, 303.7500);
	CreateObject(987, -34.889023, 1335.727173, 8.807434, 0.0000, 0.0000, 337.5000);
	CreateObject(987, -23.891308, 1330.981079, 8.796404, 0.0000, 0.0000, 348.7500);
	CreateObject(987, -11.967974, 1328.483032, 8.745362, 0.0000, 0.0000, 348.7500);
	CreateObject(987, 0.299221, 1325.702393, 8.752378, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 13.134196, 1324.879150, 8.739278, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 25.370436, 1324.718750, 8.802795, 0.0000, 0.0000, 0.0000);
	CreateObject(987, 37.181751, 1324.728760, 8.965546, 0.0000, 0.0000, 45.0000);
	CreateObject(987, 46.105854, 1333.138550, 9.399200, 0.0000, 0.0000, 78.7500);
	CreateObject(987, 48.605602, 1344.653198, 9.389797, 0.0000, 0.0000, 78.7500);
	CreateObject(987, 51.163910, 1356.417358, 9.412247, 0.0000, 0.0000, 90.0000);
	CreateObject(987, 51.481049, 1368.664429, 9.353582, 0.0000, 0.0000, 90.0000);
	CreateObject(987, 51.810345, 1373.437134, 14.410927, 0.0000, 0.0000, 101.2500);
	CreateObject(987, 49.855156, 1384.642822, 13.782770, 0.0000, 0.0000, 123.7499);
	CreateObject(1225, 48.519005, 1386.713257, 15.241725, 0.0000, 0.0000, 0.0000);
	CreateObject(1225, 50.609497, 1377.756470, 15.208030, 0.0000, 0.0000, 0.0000);
	CreateObject(1225, 7.394691, 1375.697266, 8.577630, 0.0000, 0.0000, 0.0000);
	CreateObject(2780, 50.864983, 1372.223755, 12.693587, 0.0000, 0.0000, 0.0000);
	CreateObject(2780, 45.642475, 1392.288818, 12.990057, 0.0000, 0.0000, 0.0000);
	CreateObject(3525, 48.767094, 1372.511841, 10.278730, 0.0000, 0.0000, 90.0000);



	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1644.4078,-1133.8214,58.2172);
	SetPlayerCameraPos(playerid, 1647.6301,-1134.5725,58.2489);
	SetPlayerCameraLookAt(playerid, 1644.4078,-1133.8214,58.2172);
	SetPlayerFacingAngle(playerid,258.5584);

 	if(classid == 0)
	{
		GameTextForPlayer(playerid, "~b~ Counter Terriost", 9000, 3);
		Team[playerid] = TEAM_1;
	}
	else if(classid == 1)
	{
		GameTextForPlayer(playerid, "~r~ Terriost", 9000, 3);
		Team[playerid] = TEAM_2;
	}
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
//---------------------WELCOME MESSAGE-----------------------------
	SendClientMessage(playerid,BLUE_COLOR, "Server: Counter Strike 1.6");
	SendClientMessage(playerid,WHITE_COLOR, "GameMode: Camp LV");
	SendClientMessage(playerid,WHITE_COLOR, "Author: [FD]MiDNiGhT");
	SendClientMessage(playerid,WHITE_COLOR, "Idea: [FD]MiDNiGhT");
	SendClientMessage(playerid,BLUE_COLOR, "Site: www.rdremixdrift.tk");
	SendClientMessage(playerid,WHITE_COLOR, "-------------HELP------------------");
	SendClientMessage(playerid,BLUE_COLOR," Type /Buymenu To Buy Weapons");
	SetPlayerArmour(playerid,100);
	GivePlayerMoney(playerid,50000);
	return 1;
}


public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(Team[playerid] == TEAM_1)
	{
		SetPlayerColor(playerid, BLUE_COLOR);
	}
	else if(Team[playerid] == TEAM_2)
	{
		SetPlayerColor(playerid, COLOR_RED);
	}



	return 1;
}


public OnPlayerDeath(playerid, killerid, reason)
{
	SendDeathMessage(killerid, playerid, reason);
    SetPlayerScore(killerid,(GetPlayerScore(killerid))+1);
    GivePlayerMoney(killerid,500);
    SendClientMessage(killerid,WHITE_COLOR,"Nice Job Pwning That Noob!");
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
	if (strcmp("/kill", cmdtext, true, 10) == 0)
	{
		SendClientMessage(playerid,COLOR_RED,"You Killed YourSelf");
		SetPlayerHealth(playerid,0);
		return 1;
	}
	if (strcmp("/help", cmdtext, true, 10) == 0)
	{
		SendClientMessage(playerid,COLOR_RED,"CT Kill T Till 10 Min Untill Next Map");
		SendClientMessage(playerid,COLOR_RED,"T Kill CT Till 10 Min Untill Next Map");
		return 1;
	}
	if (strcmp("/buymenuass", cmdtext, true, 10) == 0)
	{
		SendClientMessage(playerid,COLOR_RED,"Weapons:4000$ Armour 4000$ Health 5000$ m4 4000$ ak47 5000$ grenade FREE! Shotgun 2000$ CockTail  ");
		return 1;
	}
	if (strcmp("/m4", cmdtext, true, 10) == 0)
	{
		SendClientMessage(playerid,COLOR_RED,"You Bought A M4 4000$");
		GivePlayerWeapon(playerid,31,400);
		GivePlayerMoney(playerid,-5000);
		return 1;
	}
	if (strcmp("/shotgun", cmdtext, true, 10) == 0)
	{
		SendClientMessage(playerid,COLOR_RED,"You Got A free Shotgun");
		GivePlayerWeapon(playerid,25,100);
		return 1;
	}
	if (strcmp("/armour", cmdtext, true, 10) == 0)
	{
		SendClientMessage(playerid,COLOR_RED,"You Bought A Armour");
		SetPlayerArmour(playerid,100);
		GivePlayerMoney(playerid,-4000);
		return 1;
	}
	if (strcmp("/health", cmdtext, true, 10) == 0)
	{
		SendClientMessage(playerid,COLOR_RED,"You Bought A Armour");
		SetPlayerHealth(playerid,100);
		GivePlayerMoney(playerid,-4000);
		return 1;
	}
	if (strcmp("/grenade", cmdtext, true, 10) == 0)
	{
		SendClientMessage(playerid,COLOR_RED,"You Bought A Grenade");
		GivePlayerWeapon(playerid,16,10);
		GivePlayerMoney(playerid,-5000);
		return 1;
	}
	if (strcmp("/ak47", cmdtext, true, 10) == 0)
	{
		SendClientMessage(playerid,COLOR_RED,"You Bought A AK-47");
		GivePlayerWeapon(playerid,30,400);
		GivePlayerMoney(playerid,-4000);
		return 1;
	}
	if (strcmp("/cocktail", cmdtext, true, 10) == 0)
	{
		SendClientMessage(playerid,COLOR_RED,"You Bought A CockTail");
		GivePlayerWeapon(playerid,18,10);
		GivePlayerMoney(playerid,-2000);
		return 1;
	}
	if (strcmp("/credits", cmdtext, true, 10) == 0)
	{
		SendClientMessage(playerid,COLOR_RED,"GameMode Created By: [FD]Left4Dead");
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
public OVER()
{
	GameTextForAll("~r~ TIME UP! ~b~ Next Map Loading", 2500 , 0);
	SetTimer("Restart", 10000 , 0);
}
public GameModeExitFunc()
{
	GameModeExit();
}
public Restart()
{
	GameTextForAll("~g~ Restarting~r~...", 2500, 0);
	SendRconCommand("gmx");
}
public mapname()
{
    SendRconCommand("mapname Camp LV");
	return 1;
}
