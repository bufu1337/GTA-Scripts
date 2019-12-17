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
	print(" Loaded L4D RoofTop");
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
	

	
	AddPlayerClass(285,-2233.8010,123.0607,57.9079,16.4415,31,4000,25,100,17,18); // CT
	AddPlayerClass(179,-2173.4407,160.3662,62.1094,59.5898,30,4000,25,100,17,18); // T
	
	CreateObject( 972 , -2230.586669 , 161.494750 , 54.172832 , 8.000000 , -88.000000 , 0.000000 );
	CreateObject( 925 , -2240.546142 , 196.337554 , 58.269149 , 0.000000 , 0.000000 , 0.000000 );
	CreateObject( 3403 , -2234.970947 , 186.802871 , 60.091663 , 0.000000 , 0.000000 , 0.000000 );
	CreateObject( 1652 , -2225.823486 , 183.613021 , 59.070167 , 0.000000 , 0.000000 , 272.000000 );
	CreateObject( 9247 , -2209.265136 , 153.148239 , 65.338653 , 0.000000 , 0.000000 , 0.000000 );
	CreateObject( 3359 , -2216.919921 , 187.276657 , 58.206798 , 0.000000 , 0.000000 , 0.000000 );
	CreateObject( 3620 , -2214.484130 , 184.059967 , 74.838546 , 0.000000 , 0.000000 , 0.000000 );
	CreateObject( 972 , -2191.360107 , 179.194946 , 55.499099 , 0.000000 , -812.000000 , 450.000000 );
	CreateObject( 8483 , -2162.070312 , 191.995605 , 62.729248 , 0.000000 , 0.000000 , 586.000000 );
	CreateObject( 852 , -2172.835205 , 175.701980 , 57.205566 , 0.000000 , 0.000000 , 0.000000 );
	CreateObject( 952 , -2167.063964 , 172.214019 , 58.265625 , 0.000000 , 0.000000 , 0.000000 );
	CreateObject( 10984 , -2215.914794 , 171.152526 , 58.709037 , 0.000000 , 0.000000 , 0.000000 );
	CreateObject( 13206 , -2236.226318 , 147.670730 , 56.060695 , 0.000000 , 0.000000 , 1532.000000 );
	CreateObject( 972 , -2233.860595 , 130.294876 , 56.286746 , 0.000000 , 0.000000 , 0.000000 );
	CreateObject( 972 , -2233.860595 , 130.294876 , 56.286746 , 0.000000 , 0.000000 , 0.000000 );
	CreateObject( 971 , -2230.154052 , 119.815773 , 57.907890 , 0.000000 , 0.000000 , 90.000000 );



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
	SendClientMessage(playerid,WHITE_COLOR, "GameMode: Rooftop SF");
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
    SendRconCommand("mapname Rooftop SF");
	return 1;
}
