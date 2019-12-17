//  Copyright (c) Epsilon 2009
#include <a_samp>
#if defined _eafkn_included
  #endinput
#endif
#define _eafk_included
#pragma library eafk
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_BRIGHTRED 0xFF0000AA

/*
	native AFKInit();
	native AFKUpdate(playerid);
	native AFKConnect(playerid);
	native ECommand(playerid, cmdtext[]);
*/
stock AFKInit()
{
	print("\n--------------------------------------");
	print(" Euro-AFK System by: Epsilon");
	print("--------------------------------------\n");
	SetTimer("AFKTimer",1800,1);
}

enum Afkinfo
{
	inafk,
	afkcount,
	x,
	y,
	z,
	vw
};
new namep[MAX_PLAYER_NAME];
new string[256],afkp=0;
new AFK[MAX_PLAYERS][Afkinfo];
forward AFKTimer();
forward StartFK(id);
stock AFKUpdate(playerid)
{
	if(AFK[playerid][afkcount] < 9) AFK[playerid][afkcount]++;
	return 1;
}
public StartFK(id)
{
	AFK[id][afkcount] = 0;
	return 1;
}
stock AFKConnect(playerid)
{
	AFK[playerid][afkcount] =-1;
	SetTimerEx("StartFK",20000,0,"%i",playerid);
	return 1;
}
stock ECommand(playerid, cmdtext[])
{
    if(strcmp(cmdtext, "/afk", true) == 0)
    {
	    if(AFK[playerid][inafk] == 0)
		{
		SetPlayerVirtualWorld(playerid,playerid+1);
		TogglePlayerControllable(playerid,0);
		AFK[playerid][inafk] = 1;
		GetPlayerName(playerid, namep, sizeof(namep));
	    format(string, sizeof(string), "Euro-AFK: %s elment a számítógéptõl!", namep);
		SendClientMessageToAll(COLOR_GREEN, string);
		} else SendClientMessage(playerid,COLOR_BRIGHTRED,"Euro-AFK: Már AFK-ban vagy!");
	    return 1;
    }

	if(strcmp(cmdtext, "/listafk", true) == 0)
	{
	afkp = 0;
	SendClientMessage(playerid,COLOR_BRIGHTRED,"Euro-AFK: A játékosok akik AFKban vannak:");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(AFK[i][inafk] == 1)
			{
			    afkp++;
				GetPlayerName(i,namep,sizeof(namep));
				format(string,256,"Név: %s || ID: %i",namep,i);
				SendClientMessage(playerid,COLOR_WHITE,string);
			}
			if(afkp == 0) SendClientMessage(playerid,COLOR_WHITE,"Senki sincs AFK módban!");
		}
	}
	return 1;
	}
    if(strcmp(cmdtext, "/back", true) == 0)
    {
	    if(AFK[playerid][inafk] == 1)
		{
		SetPlayerVirtualWorld(playerid,0);
		TogglePlayerControllable(playerid,1);
		AFK[playerid][inafk] = 0;
		GetPlayerName(playerid, namep, sizeof(namep));
	    format(string, sizeof(string), "Euro-AFK: %s visszaült a számítógéphez!", namep);
		SendClientMessageToAll(COLOR_GREEN, string);
		AFK[playerid][afkcount] =-1;
		SetTimerEx("StartFK",20000,0,"%i",playerid);
		} else SendClientMessage(playerid,COLOR_BRIGHTRED,"Euro-AFK: Nem vagy AFK-ban!");
	    return 1;
    }
	if(AFK[playerid][inafk] == 1) return SendClientMessage(playerid,COLOR_BRIGHTRED,"Euro-AFK: AFK módban vagy! A parancsok nagy részét nem használhatod!  /back - Hogy visszamenj a játékbba.");
    return 0;
}
public AFKTimer()
{
	for(new i = 0; i < 200; i++)
	{
	    if(IsPlayerConnected(i))
		{
		    if(AFK[i][inafk]) TogglePlayerControllable(i,0);
		    if(!AFK[i][inafk])
		    {
				if(AFK[i][afkcount] > 0 && AFK[i][afkcount] != -1) AFK[i][afkcount]--;
				if(AFK[i][afkcount] <= 0 && AFK[i][afkcount] != -1)
				{
				SetPlayerVirtualWorld(i,i+1);
				TogglePlayerControllable(i,0);
				AFK[i][inafk] = 1;
				GetPlayerName(i, namep, sizeof(namep));
		        format(string, sizeof(string), "Euro-AFK: %s elment a számítógéptõl!", namep);
				SendClientMessageToAll(COLOR_GREEN, string);
				}
			}
		}
	}
}