// This is a comment
// uncomment the line below if you want to write a filterscript
#define FILTERSCRIPT

#include <a_samp>
#define KEY_ENTER 16
#pragma tabsize 0

enum qInfo
{
	Float:hqEntrancex,
	Float:hqEntrancey,
	Float:hqEntrancez,
	Float:hqExitx,
	Float:hqExity,
	Float:hqExitz,
	hqInt,
	hqInfo[64],
	hqLock
};

new CommandInfo[1][qInfo];


strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}



public OnFilterScriptInit()
{
    DisableInteriorEnterExits();
    LoadHq();
   	print(" Enter/Exit system by TouR ");
	for(new h = 0; h < sizeof(CommandInfo); h++)
	{
	new tour[64];
	format(tour, sizeof(tour), "%s",CommandInfo[h][hqInfo] );
 	Create3DTextLabel(tour,0x0080FFFF,CommandInfo[h][hqEntrancex], CommandInfo[h][hqEntrancey], CommandInfo[h][hqEntrancez]+0.75,20.0,0,1);
	AddStaticPickup(1239, 2, CommandInfo[h][hqEntrancex], CommandInfo[h][hqEntrancey], CommandInfo[h][hqEntrancez]);
	}
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}




public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid, 0xB4B5B7FF, "Enter/Exit system by TouR");
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == KEY_ENTER)
    {
    	if(IsPlayerConnected(playerid))
		{
			for(new i = 0; i < sizeof(CommandInfo); i++)
			{
				if (PlayerToPoint(5, playerid,CommandInfo[i][hqEntrancex], CommandInfo[i][hqEntrancey], CommandInfo[i][hqEntrancez]))
				{
    				if(CommandInfo[i][hqLock] == 1)
				   	 {
						GameTextForPlayer(playerid,"~r~Locked", 2500, 1);
						return 1;
						}
				        new string[256];
						SetPlayerInterior(playerid,CommandInfo[i][hqInt]);
						SetPlayerPos(playerid,CommandInfo[i][hqExitx],CommandInfo[i][hqExity],CommandInfo[i][hqExitz]);
						format(string, sizeof(string), "%s",CommandInfo[i][hqInfo]);
		    			GameTextForPlayer(playerid, string, 2500, 1);
					}

			}
	}
	}
	
		if(newkeys == KEY_ENTER)
    {
    	    if(IsPlayerConnected(playerid))
		{
			for(new i = 0; i <  sizeof(CommandInfo); i++)
			{
				if (PlayerToPoint(5, playerid,CommandInfo[i][hqExitx], CommandInfo[i][hqExity], CommandInfo[i][hqExitz]))
				{
						SetPlayerInterior(playerid,0);
						SetPlayerPos(playerid, CommandInfo[i][hqEntrancex],CommandInfo[i][hqEntrancey],CommandInfo[i][hqEntrancez]);
					}
				}
			}
			}
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



public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new idx;
	cmd = strtok(cmdtext, idx);
	
	
	if(strcmp(cmd, "/enter", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			for(new i = 0; i < sizeof(CommandInfo); i++)
			{
				if (PlayerToPoint(5, playerid,CommandInfo[i][hqEntrancex], CommandInfo[i][hqEntrancey], CommandInfo[i][hqEntrancez]))
				{
				     if(CommandInfo[i][hqLock] == 1)
				   	 {
						GameTextForPlayer(playerid,"~r~Locked", 2500, 1);
						return 1;
					}
						SetPlayerInterior(playerid,CommandInfo[i][hqInt]);
						SetPlayerPos(playerid,CommandInfo[i][hqExitx],CommandInfo[i][hqExity],CommandInfo[i][hqExitz]);
					}

			}
	}
		return 1;
	}
			
	if(strcmp(cmd, "/exit", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			for(new i = 0; i <  sizeof(CommandInfo); i++)
			{
				if (PlayerToPoint(5, playerid,CommandInfo[i][hqExitx], CommandInfo[i][hqExity], CommandInfo[i][hqExitz]))
				{
						SetPlayerInterior(playerid,0);
						SetPlayerPos(playerid, CommandInfo[i][hqEntrancex],CommandInfo[i][hqEntrancey],CommandInfo[i][hqEntrancez]);
					}
				}
			}
			return 1;
		}
		
    if(strcmp(cmd, "/lock", true) == 0)
	{
	    if(IsPlayerAdmin(playerid))
	    {
  			for(new i = 0; i < sizeof(CommandInfo); i++)
			{
				if (PlayerToPoint(1, playerid,CommandInfo[i][hqEntrancex], CommandInfo[i][hqEntrancey], CommandInfo[i][hqEntrancez]))
				{
				    if(CommandInfo[i][hqLock] == 0)
				    {
					CommandInfo[i][hqLock] = 1;
					SendClientMessage(playerid, 0xB4B5B7FF, "Entrance Admin Locked");
					}
					else if(CommandInfo[i][hqLock] == 1)
				    {
   					CommandInfo[i][hqLock] = 0;
					SendClientMessage(playerid, 0xB4B5B7FF, "Entrance Admin Unlocked");
					}
				}
			}
		}
		return 1;
	}
	return 0;
}



forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}
forward LoadHq();
public LoadHq()
{
	new arrCoords[9][256];
	new strFromFile2[256];
	new File: file = fopen("Locations.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(CommandInfo))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, '|');
			CommandInfo[idx][hqEntrancex] = floatstr(arrCoords[0]);
			CommandInfo[idx][hqEntrancey] = floatstr(arrCoords[1]);
			CommandInfo[idx][hqEntrancez] = floatstr(arrCoords[2]);
			CommandInfo[idx][hqExitx] = floatstr(arrCoords[3]);
			CommandInfo[idx][hqExity] = floatstr(arrCoords[4]);
			CommandInfo[idx][hqExitz] = floatstr(arrCoords[5]);
			CommandInfo[idx][hqInt] = strval(arrCoords[6]);
			strmid(CommandInfo[idx][hqInfo], arrCoords[7], 0, strlen(arrCoords[7]), 255);
			CommandInfo[idx][hqLock] = strval(arrCoords[8]);
			idx++;
		}
		fclose(file);
	}
	return 1;
}

forward split(const strsrc[], strdest[][], delimiter);
public split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}

