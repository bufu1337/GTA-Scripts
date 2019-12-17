/*
									NPC Generator
											   By Yuri_

Copyright © Balkan Role-Play Team. All Rights Reserved.

*/
#define FILTERSCRIPT

#include <a_samp>
#define red 0xFF4500AA
#define royalblue 0x4169FFAA
new IsInNpcMode[MAX_PLAYERS];
new IsInNpcRecordMode[MAX_PLAYERS];
#if defined FILTERSCRIPT
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" NPC Generator Loaded");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
    print("\n--------------------------------------");
	print(" NPC Generator Unloaded");
	print("--------------------------------------\n");
	return 1;
}
#endif
public OnPlayerConnect(playerid)
{
    IsInNpcRecordMode[playerid] = 0;
    IsInNpcMode[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    IsInNpcRecordMode[playerid] = 0;
    IsInNpcMode[playerid] = 0;
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new idx;
	cmd = strtok(cmdtext, idx);
	if (strcmp(cmd, "/createnpc", true) == 0)
	{
		if(!IsPlayerAdmin(playerid))
		{
		    SendClientMessage(playerid,red," Only Rcon Administrator Can use this command!");
		}
		else if(IsInNpcMode[playerid] == 1)
		{
		    SendClientMessage(playerid,red," You are already in NPC Mode!");
		}
		else
		{
			IsInNpcMode[playerid] = 1;
			ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"Npc Creator","Hello and welcome to the NPC Creator.\nUsing this NPC Creator, creating a NPC will be very simple.\nPlease follow all the steps, so you can create your own NPC.\nClick 'Ok' to proced to the NPC Creator and 'Exit' to exit the NPC Creator.","Ok","Exit");
		}
		return 1;
	}
	if (strcmp(cmd, "/sr", true) == 0)
	{
	    if(IsInNpcRecordMode[playerid] == 0)
	    {
			return 1;
	    }
	    else if(IsInNpcRecordMode[playerid] == 1)
	    {
	        ShowPlayerDialog(playerid,6,DIALOG_STYLE_MSGBOX,"Step 5","Step 5:\nYour NPC is Created.\nClick on ' Done ' to exit or on ' More '\nto create another NPC.","Done","More");
	        StopRecordingPlayerData(playerid);
     		IsInNpcRecordMode[playerid] = 0;
		}
		return 1;
	}
	return 0;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new string[248];
	new idx;
	new tmp[256];
    tmp = strtok(inputtext, idx);
    new skin = strval(tmp);
	new weapon = strval(tmp);
	if(dialogid == 0)
	{
	    if(response)
	    {
	        ShowPlayerDialog(playerid,1,DIALOG_STYLE_MSGBOX,"Step 1","Step 1:\nSelect your NPC Mode.\nIf you want to exit, click ' Exit '.","On Foot","Exit");
	    }
	    else
	    {
	        IsInNpcMode[playerid] = 0;
	        SendClientMessage(playerid,royalblue," You've exited the NPC Creator.");
		}
	}
	else if(dialogid == 1)
	{
	    if(response)
	    {
	    	format(string,sizeof(string),"Write below your NPC Skin ID then click ' Use Skin '.\nTo return back, click on ' Back '");
			ShowPlayerDialog(playerid,2,DIALOG_STYLE_INPUT,"Step 2",string,"Use Skin","Back");
		}
		else
		{
		    IsInNpcMode[playerid] = 0;
	        SendClientMessage(playerid,royalblue," You've exited the NPC Creator.");
		}
	}
	else if(dialogid == 2)
	{
 		if(response)
		{
			if(skin < 0 || skin > 289 || IsInvalidSkin(skin))
	    	{
	           	format(string,sizeof(string),"The Skin ID you did inserted is invalid.\n Try an other skin.");
				ShowPlayerDialog(playerid,3,DIALOG_STYLE_INPUT,"Step 2",string,"Use Skin","Back");
	    	}
	    	else
	    	{
  		  		SetPlayerSkin(playerid,skin);
   		   		format(string,sizeof(string),"Skin ID Selected! \nStep 3: Write down an Weapon ID for your NPC.\n If you want no weapon, click on ' No Weapon '.");
				ShowPlayerDialog(playerid,4,DIALOG_STYLE_INPUT,"Step 3",string,"Select","No Weapon");
			}
		}
		else
		{
  			ShowPlayerDialog(playerid,1,DIALOG_STYLE_MSGBOX,"Step 1","Step 1:\nSelect your NPC Mode.\nIf you want to exit, click ' Exit '.","On Foot","Exit");
		}
	}
	else if(dialogid == 3)
	{
	    if(response)
		{
			if(skin < 0 || skin > 289 || IsInvalidSkin(skin))
	    	{
	           	format(string,sizeof(string),"The Skin ID you did inserted is invalid.\n Try an other skin.");
				ShowPlayerDialog(playerid,3,DIALOG_STYLE_INPUT,"Step 2",string,"Use Skin","Back");
				new bigstring[456];
        		new string2[256];
        		format(bigstring,sizeof(bigstring),"#include <a_npc>\n\n\n\nmain() {}\n\n\n\nNextPlayBack(playerid)\n{\n	StartRecordingPlayback(PLAYER_RECORDING_TYPE_ONFOOT,NPC);\n	SetPlayerSkin(playerid,%d);\n	GivePlayerWeapon(playerid,%d,999999);\n}\npublic OnRecordingPlaybackEnd()\n{\n	NextPlayback(playerid);\n}\npublic OnNPCSpawn()\n{\n	NextPlayback(playerid);\n}\npublic OnNPCExitVehicle()\n{\n	StopRecordingPlayback();\n}",skin,weapon);
        		format(string2,sizeof(string2),"NPC.pwn");
        		new File: PwnFile;
        		PwnFile = fopen(string2,io_write);
        		fwrite(PwnFile,bigstring);
        		fclose(PwnFile);
	    	}
	    	else
	    	{
  		  		SetPlayerSkin(playerid,skin);
   		   		format(string,sizeof(string),"Skin ID Selected! \nStep 3: Write down an Weapon ID for your NPC.\n If you want no weapon, click on ' No Weapon '.");
				ShowPlayerDialog(playerid,4,DIALOG_STYLE_INPUT,"Step 3",string,"Use Weapon","No Weapon");
				new bigstring[456];
        		new string2[256];
        		format(bigstring,sizeof(bigstring),"#include <a_npc>\n\n\n\nmain() {}\n\n\n\nNextPlayBack(playerid)\n{\n	StartRecordingPlayback(PLAYER_RECORDING_TYPE_ONFOOT,NPC);\n	SetPlayerSkin(playerid,%d);\n	GivePlayerWeapon(playerid,%d,999999);\n}\npublic OnRecordingPlaybackEnd()\n{\n	NextPlayback(playerid);\n}\npublic OnNPCSpawn()\n{\n	NextPlayback(playerid);\n}\npublic OnNPCExitVehicle()\n{\n	StopRecordingPlayback();\n}",skin,weapon);
        		format(string2,sizeof(string2),"NPC.pwn");
        		new File: PwnFile;
        		PwnFile = fopen(string2,io_write);
        		fwrite(PwnFile,bigstring);
        		fclose(PwnFile);
			}
		}
		else
		{
  			ShowPlayerDialog(playerid,1,DIALOG_STYLE_MSGBOX,"Step 1","Step 1:\nSelect your NPC Mode Bettwen ' On Foot ' and ' On Vehicle '.","On Foot","On Vehicle");
		}
	}
	else if(dialogid == 4)
	{
	    if(response)
		{
			if(weapon < 0 || weapon > 46)
	    	{
	           	format(string,sizeof(string),"The Weapon ID you did inserted is invalid.\n Try an other Weapon.");
				ShowPlayerDialog(playerid,4,DIALOG_STYLE_INPUT,"Step 3",string,"Use Weapon","Back");
	    	}
	    	else
	    	{
	    	    ResetPlayerWeapons(playerid);
	    	    GivePlayerWeapon(playerid,weapon,9999999);
                format(string,sizeof(string),"Weapon ID Selected! \nStep 4: Write down the File Name for the NPC.\n Once you will click ' Save ', the record will start.\n Click on ' Back ' to go Back.");
				ShowPlayerDialog(playerid,5,DIALOG_STYLE_INPUT,"Step 4",string,"Save","Back");
				new bigstring[456];
        		new string2[256];
        		format(bigstring,sizeof(bigstring),"#include <a_npc>\n\n\n\nmain() {}\n\n\n\nNextPlayBack(playerid)\n{\n	StartRecordingPlayback(PLAYER_RECORDING_TYPE_ONFOOT,NPC);\n	SetPlayerSkin(playerid,%d);\n	GivePlayerWeapon(playerid,%d,999999);\n}\npublic OnRecordingPlaybackEnd()\n{\n	NextPlayback(playerid);\n}\npublic OnNPCSpawn()\n{\n	NextPlayback(playerid);\n}\npublic OnNPCExitVehicle()\n{\n	StopRecordingPlayback();\n}",skin,weapon);
        		format(string2,sizeof(string2),"NPC.pwn");
        		new File: PwnFile;
        		PwnFile = fopen(string2,io_write);
        		fwrite(PwnFile,bigstring);
        		fclose(PwnFile);
			}
		}
		else
		{
		    ResetPlayerWeapons(playerid);
		    format(string,sizeof(string),"Weapon ID Selected! \nStep 4: Write down the File Name for the NPC.\n Once you will click ' Save ', the record will start.\n Click on ' Back ' to go Back.");
			ShowPlayerDialog(playerid,5,DIALOG_STYLE_INPUT,"Step 4",string,"Save","Back");
			new bigstring[456];
        	new string2[256];
        	format(bigstring,sizeof(bigstring),"#include <a_npc>\n\n\n\nmain() {}\n\n\n\nNextPlayBack(playerid)\n{\n	StartRecordingPlayback(PLAYER_RECORDING_TYPE_ONFOOT,NPC);\n	SetPlayerSkin(playerid,%d);\n	GivePlayerWeapon(playerid,%d,999999);\n}\npublic OnRecordingPlaybackEnd()\n{\n	NextPlayback(playerid);\n}\npublic OnNPCSpawn()\n{\n	NextPlayback(playerid);\n}\npublic OnNPCExitVehicle()\n{\n	StopRecordingPlayback();\n}",skin,weapon);
        	format(string2,sizeof(string2),"NPC.pwn");
        	new File: PwnFile;
        	PwnFile = fopen(string2,io_write);
        	fwrite(PwnFile,bigstring);
        	fclose(PwnFile);
		}
	}
	else if(dialogid == 5)
	{
	    if(response)
		{
			if(!strlen(inputtext))
	    	{
	           	format(string,sizeof(string),"Missed File Name. Please Write a Name:");
				ShowPlayerDialog(playerid,4,DIALOG_STYLE_INPUT,"Step 3",string,"Save","Back");
	    	}
	    	else
	    	{
	    	    IsInNpcRecordMode[playerid] = 1;
	    	    SendClientMessage(playerid,royalblue," Record Started! Write /sr to stop it.");
	    	    StartRecordingPlayerData(playerid,PLAYER_RECORDING_TYPE_ONFOOT,inputtext);
			}
		}
		else
		{
		    format(string,sizeof(string),"Skin ID Selected! \nStep 3: Write down an Weapon ID for your NPC.\n If you want no weapon, click on ' No Weapon '.");
			ShowPlayerDialog(playerid,4,DIALOG_STYLE_INPUT,"Step 3",string,"Use Weapon","No Weapon");
		}
	}
	else if(dialogid == 6)
	{
	    if(response)
	    {
      		IsInNpcMode[playerid] = 0;
       		SendClientMessage(playerid,royalblue," NPC Was successfuly created.Check your ' scriptfiles ' folder for more informations.");
        	SendClientMessage(playerid,royalblue," To create another NPC, use /createnpc.");
        	
		}
		else
		{
		    ShowPlayerDialog(playerid,1,DIALOG_STYLE_MSGBOX,"Step 1","Step 1:\nSelect your NPC Mode.\nIf you want to exit, click ' Exit '.","On Foot","Exit");
		}
	}
	return 1;
}

IsInvalidSkin(skinid)
{
    #define MAX_BAD_SKINS 22
    new InSkin[MAX_BAD_SKINS] = {
    0, 3, 4, 5, 6, 8, 42, 65, 74, 86,
    119, 149, 208,  273, 289};
    for (new i = 0; i < MAX_BAD_SKINS; i++) {
    if (skinid == InSkin[i]) return true;}
    return 0;
}
stock strtok(const string[], &index,seperator=' ')
{
	new length = strlen(string);
	new offset = index;
	new result[128];
	while ((index < length) && (string[index] != seperator) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}

	result[index - offset] = EOS;
	if ((index < length) && (string[index] == seperator))
	{
		index++;
	}
	return result;
}
