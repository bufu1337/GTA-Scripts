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
	AllowInteriorWeapons(1);

	//-------10 minutes-----------
 	SetTimer("OVER", 600000, 0);



	AddPlayerClass(285,2532.8860,-1284.5112,1054.6406,204.9671,31,4000,25,100,17,18); // CTcrackPlace
	AddPlayerClass(179,2560.9048,-1303.9884,1060.9844,273.1059,30,4000,25,100,17,18); // TCrackPlace






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
	SendClientMessage(playerid,WHITE_COLOR, "GameMode: Crack Place");
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
	SetPlayerInterior(playerid,2);


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
		SendClientMessage(playerid,COLOR_RED,"GameMode Created By: [FD]MiDNiGhT");
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
    SendRconCommand("mapname Crack Place");
	return 1;
}
