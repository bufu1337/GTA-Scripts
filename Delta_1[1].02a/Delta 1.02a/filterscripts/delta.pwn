/*
'================================================================='
|	Delta All-In-One coded by Ramjet:                             |
|	o  Admin Script                                               |
|	o  Anti-Cheat                                                 |
|	o  Player Profiles                                            |
|	o  Anti-Spam                                                  |
|	o  Anti-Interior Kill                                         |
|	o  Chat System                                                |
|	o  Playerban and Clanban (Supported by Cheaterwatch)          |
|	o  Anti-Driveby abuse                                         |
'================================================================='
|	Credits:                                                      |
|	o  Cheaterwatch Community for hacker libraries.               |
|	o  Dracoblue for Dutils, Dini, Dudb, DCMD and dprop           |
|	o  Sacky for SInterior, Playerban, Clanban and listening to   |
|	   me bitch and complain lol.								  |
|	o  SHAC for AntiSpam and AntiHealth Hack protection.          |
|	o  Scarface for anti-driveby abuse                            |
'================================================================='
|	Installation:                                                 |
|                                                                 |
|	Run this filterscript, join your server and log into rcon.    |
|	Delta All-In-One will detect you are an rcon admin            |
|	and prompt you to install Delta.                              |
|	Type /install to install required files, then /configure to   |
|	personalize the script to do what you want it to do.          |
'================================================================='
|	Requirements:                                                 |
|                                                                 |
|	Dutils - v1.6 or later									      |
|	Dini - v1.4 or later							              |
|	Sinterior - v1 or later			                              |
|	DDUDB (Delta - Dracoblue user database) - Included with script|
|	dprop - v1 or later                                           |
'================================================================='
*/

// Insert l33t definitions here :P

#define MAX_PLAYERS 100
#define INVALID_PLAYER_ID 255
#define MAX_PLAYER_NAME 24
#define MAX_STRING 255

// Colour definitions

#define COLOUR_YELLOW 0xFFFF00AA
#define COLOUR_GREY 0xAFAFAFAA
#define COLOUR_RED 0xAA3333AA
#define COLOUR_GREEN 0x33AA33FF
#define COLOUR_WHITE 0xFFFFFFAA
#define COLOUR_LIGHTBLUE 0x33CCFFAA

// Used to ignore vehicle killings in driveby abuse.
#define WEAPON_VEHICLE 49

// DCMD (Fast Command Processor)

#define dcmd(%1,%2,%3) if ((strcmp(%3, "/%1", true, %2+1) == 0)&&(((%3[%2+1]==0)&&(dcmd_%1(playerid,"")))||((%3[%2+1]==32)&&(dcmd_%1(playerid,%3[%2+2]))))) return 1

// Version

new VERSION = 1;

// Config Variables

new Install;
new AntiHealthHack;
new AntiSpam;
new AntiDriveBy;
new AntiIntKill;
new ProfileAllowed;
new HackPunishment; // Kick = 1, Ban = 2, Reset = 3
new IntKillPunishment; // Kick = 1, Ban = 2, Reset = 3
new MaxDriveBys;
new chat = 1;

// Timers
new InstallRefresh;

// Stats
new Kills, Deaths, Suicides, Pjoined, Lols;

// Installer
new InstallPrivs;
new InstallContinue[MAX_PLAYERS];
new ConfigContinue[MAX_PLAYERS];
new ProfileContinue[MAX_PLAYERS];
new tCount[MAX_PLAYERS];

// Player information
new authenticated[MAX_PLAYERS];
new level[MAX_PLAYERS];
new mute[MAX_PLAYERS];
new jail[MAX_PLAYERS];
new SpawnJail[MAX_PLAYERS];
new Float:hp[MAX_PLAYERS];
new dbcount[MAX_PLAYERS];
new Kicked[MAX_PLAYERS];
new Banned[MAX_PLAYERS];
new PKills[MAX_PLAYERS];
new PDeaths[MAX_PLAYERS];
new PSuicides[MAX_PLAYERS];
new PLols[MAX_PLAYERS];
new Age[MAX_PLAYERS][MAX_STRING];
new Gender[MAX_PLAYERS][MAX_STRING];
new State[MAX_PLAYERS][MAX_STRING];
new Country[MAX_PLAYERS][MAX_STRING];
new Likes[MAX_PLAYERS][MAX_STRING];
new Dislikes[MAX_PLAYERS][MAX_STRING];
new Sport[MAX_PLAYERS][MAX_STRING];
new Music[MAX_PLAYERS][MAX_STRING];
new Moreinfo[MAX_PLAYERS][MAX_STRING];
new talking[MAX_PLAYERS];
new convo[MAX_PLAYERS][MAX_PLAYERS];
new Ignore[MAX_PLAYERS][MAX_PLAYERS];

new connect[MAX_PLAYERS];
new hack;
new names[MAX_PLAYERS][MAX_PLAYER_NAME];

// Scriptfiles Definitions
#define CONFIG_FILE "delta\\Delta CFG.cfg"
#define STATS_FILE "delta\\Delta Stats.cfg"
#define CLANBAN_FILE "delta\\Delta ClanBan.cfg"
#define PLAYERBAN_FILE "delta\\Delta PBan.cfg"
#define CW_CLANBAN_FILE "delta\\cheaterwatch\\cwcblacklist.ini"
#define CW_BAN_FILE "delta\\cheaterwatch\\cwpblacklist.ini"

//  Base libraries
#include <a_samp>
#include <dini>
#include <dprop>
#include "DDUDB"
#include <sinterior.pwn>


// Other includes to make the script more organised :)
#include "chat\chatsystem"
#include "installer\install"
#include "installer\profile"
#include "commands\profile"
#include "commands\admin"
#include "commands\help"
#include "commands\chat"
#include "commands\stats"

ReadConfig()  // Shows settings in console
{
	if(fexist(CONFIG_FILE))
	{
		new tmp[256];
		tmp = dini_Get(CONFIG_FILE, "Install");
		Install = strval(tmp);
	    printf("    Install mode = %d \n",Install);
  		tmp = dini_Get(CONFIG_FILE, "AntiHealthHack");
		AntiHealthHack = strval(tmp);
		printf("    Anti health hack mode = %d \n",AntiHealthHack);
		tmp = dini_Get(CONFIG_FILE, "AntiSpam");
		AntiSpam = strval(tmp);
		printf("    Anti spam mode = %d \n",AntiSpam);
		tmp = dini_Get(CONFIG_FILE, "AntiIntKill");
		AntiIntKill = strval(tmp);
		printf("    Anti interior kill mode = %d \n",AntiIntKill);
		tmp = dini_Get(CONFIG_FILE, "IntKillPunishment");
        IntKillPunishment = strval(tmp);
		printf("    Interior kill punishment = %d \n",IntKillPunishment);
		tmp = dini_Get(CONFIG_FILE, "ProfileAllowed");
		ProfileAllowed = strval(tmp);
		printf("    Allow profiles = %d \n",ProfileAllowed);
		tmp = dini_Get(CONFIG_FILE, "AntiDriveBy");
		AntiDriveBy = strval(tmp);
		printf("    Allow Driveby Protection = %d \n",AntiDriveBy);
		tmp = dini_Get(CONFIG_FILE, "MaxDriveBys");
		MaxDriveBys = strval(tmp);
		printf("    Maximum DriveBy Count = %d \n",MaxDriveBys);
 	}
 	else
 	{
 	    Install = 1; // Sets Delta ready to install because it hasn't found a config file
	}
}

public OnFilterScriptInit()
{
	printf("\n   Delta All-In-One version %d initialised \n",VERSION);
	ReadConfig();
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
 	dini_IntSet(STATS_FILE,"PlayersJoined", dini_Int(STATS_FILE,"PlayersJoined")+1);
 	Pjoined = dini_Int(STATS_FILE,"PlayersJoined");
	authenticated[playerid] = 0;
	level[playerid] = 0;
	// This Section has been taken from Sacky's Cheaterwatch script.
	// Pretty much all of the code for playerban and clanban derives from it.
	new playername[MAX_PLAYER_NAME];
	new temp[256];
	new clan[256];
	new string[256];
	new clanname[256];
	GetPlayerName(playerid,playername,sizeof(playername));
	clan = GetPlayerClan(playerid);
	if(dini_Exists(PLAYERBAN_FILE))
	{
		new File:fhandle;
		fhandle = fopen(PLAYERBAN_FILE,io_read);
		while(fread(fhandle,temp,sizeof(temp),false))
		{
			clanname = strrest(temp,0);
			if(strcmp(playername,clanname,true) == 0)
			{
				format(string,sizeof(string),"*** DELTA: %s is banned from this server",clanname);
				SendClientMessageToAll(COLOUR_RED,string);
				printf(string);
				Banned[playerid] = 1;
				SetTimer("TBan",500,0);
			}
		}
		fclose(fhandle);
	}
	if(dini_Exists(CLANBAN_FILE))
	{
		new File:fhandle;
		fhandle = fopen(CLANBAN_FILE,io_read);
		while(fread(fhandle,temp,sizeof(temp),false))
		{
			clanname = strrest(temp,0);
			if(strfind(playername,clanname,true) == 0)
			{
				format(string,sizeof(string),"*** DELTA: The clan %s has been banned from this server",clanname);
				SendClientMessageToAll(COLOUR_RED,string);
				printf(string);
				Banned[playerid] = 1;
				SetTimer("TBan",500,0);
			}
		}
		fclose(fhandle);
	}
	// End playerban and clanban section :). Thanks Sacky!
	if(!PropertyExists("Timer"))
	{
		PropertySet("Timer","On");
		SetTimer("SecTimer",1000,true);
		SetTimer("ClearHack",60000,true);
		if(AntiSpam == 1)SetTimer("SpamCheckTimer", 1000, true);
		if(Install == 1)InstallRefresh = SetTimer("FindAnAdmin", 1000, true);
		else
		SendClientMessage(playerid, COLOUR_YELLOW, "DELTA: This server requires authentification. Use /login to login or /register to create an account");
		if(AntiHealthHack == 1)SetTimer("HealthHackDetect", 500, true);
	}
	GetPlayerName(playerid,names[playerid],MAX_PLAYER_NAME);
	connect[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid)
{
    authenticated[playerid] = 0;
	level[playerid] = 0;
 	if(connect[playerid] < 5)
	{
		new playername[MAX_PLAYER_NAME];
		GetPlayerName(playerid,playername,sizeof(playername));
		new p;
		for(new i=0;i<MAX_PLAYERS;i++)
		{
			if(equal(playername,names[i],false)) break;
			p++;
		}
		if(p == MAX_PLAYERS) hack++;
		if(hack > 5)
		{
			hack = 0;
			Ban(playerid);
			printf("DELTA: %s has been banned for flood hacking",playername);
		}
	}
	return 1;
}

public SecTimer() for(new i=0;i<MAX_PLAYERS;i++) if(IsPlayerConnected(i)) connect[i]++;

public ClearHack() hack = 0;

public OnPlayerSpawn(playerid)
{
	if(Install == 0 || authenticated[playerid])SetPlayerHealth(playerid,hp[playerid]);
	if(jail[playerid] == 1)
	{
		SpawnJail[playerid] = 1;
		SetTimer("JailPlayer", 500, 0);
	}
	return 1;
}

public JailPlayer()
{
	for(new i = 0; i <= MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(SpawnJail[i] == 1)
	    	{
	    		SetPlayerInterior(i,3);
				SetPlayerPos(i,198.3797,160.8905,1003.0300);
				SetPlayerFacingAngle(i,177.0350);
				SetCameraBehindPlayer(i);
				SpawnJail[i] = 0;
			}
		}
	}
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new pname[MAX_PLAYER_NAME], kname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(killerid, kname, sizeof(kname));
	if(killerid == INVALID_PLAYER_ID)
	{
 		dini_IntSet(STATS_FILE,"Suicides", dini_Int(STATS_FILE,"Suicides")+1);
 		dini_IntSet(STATS_FILE,"Deaths", dini_Int(STATS_FILE,"Deaths")+1);
		Suicides = dini_Int(STATS_FILE,"Suicides");
		Deaths = dini_Int(STATS_FILE,"Deaths");
		dUserSetINT(pname).("Deaths",dUserINT(pname).("Deaths") + 1);
                PDeaths[playerid] = dUserINT(pname).("Deaths");
		dUserSetINT(pname).("Suicides",dUserINT(pname).("Suicides") + 1);
                PSuicides[playerid] = dUserINT(pname).("Suicides");
	}
	else
	{
	    dini_IntSet(STATS_FILE,"Kills", dini_Int(STATS_FILE,"Kills")+1);
 		dini_IntSet(STATS_FILE,"Deaths", dini_Int(STATS_FILE,"Deaths")+1);
		Kills = dini_Int(STATS_FILE,"Kills");
		Deaths = dini_Int(STATS_FILE,"Deaths");
		dUserSetINT(pname).("Deaths",dUserINT(pname).("Deaths") + 1);
                PDeaths[playerid] = dUserINT(pname).("Deaths");
		dUserSetINT(kname).("Kills",dUserINT(kname).("Kills") + 1);
                PDeaths[killerid] = dUserINT(kname).("Kills");
	}
	if(AntiDriveBy == 1)
	{
		if(killerid != INVALID_PLAYER_ID)   // Thanks to Scarface
		{
			if(IsPlayerInAnyVehicle(killerid) && reason != WEAPON_VEHICLE)
			{
				dbcount[killerid]++;
			}
			else if(IsPlayerInAnyVehicle(killerid) == 0)
			{
				dbcount[killerid] = 0;
			}
		}
		if(dbcount[killerid] >= MaxDriveBys)
		{
            new string[256];
			format(string, sizeof(string), "DELTA: %s has been reset (Too many Drivebys)",pname);
			SendClientMessageToAll(COLOUR_RED, string);
			ResetPlayerWeapons(playerid);
			ResetPlayerMoney(playerid);
		}
	}
	if(AntiIntKill == 1)
	{
	    if(IsPlayerInAnyInterior(killerid) && killerid != INVALID_PLAYER_ID)
	    {
            new string[256];
			switch(IntKillPunishment)
			{
				case 1:
				{
					format(string, sizeof(string), "DELTA: %s has been kicked (Interior killing)",pname);
					SendClientMessageToAll(COLOUR_RED, string);
					Kicked[playerid]=1;
					SetTimer("TKick", 500, 0);
				}
				case 2:
				{
				    format(string, sizeof(string), "DELTA: %s has been banned (Interior killing)",pname);
					SendClientMessageToAll(COLOUR_RED, string);
					Banned[playerid]=1;
					SetTimer("TBan", 500, 0);
				}
				case 3:
				{
					format(string, sizeof(string), "DELTA: %s has been reset (Interior killing)",pname);
					SendClientMessageToAll(COLOUR_RED, string);
					ResetPlayerWeapons(playerid);
					ResetPlayerMoney(playerid);
				}
			}
		}
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	new idx;
	new tmp[256];
	new playername[256];
	tmp = strtok(text, idx);
	GetPlayerName(playerid, playername, sizeof(playername));
	if(AntiSpam == 1)
	{
		if(strlen(messages_str[playerid])>0 && strcmp(text, messages_str[playerid], true)==0)
		{
    		messages_num[playerid]++;
   		}
   		else
  		{
    		format(messages_str[playerid], 255, "%s", text);
    		messages_num[playerid] = 0;
   		}
	}
	if(ConfigContinue[playerid] >= 1)InstallInput(playerid, text);
	if(ProfileContinue[playerid] >= 1)ProfileInput(playerid, text);
	if(ProfileContinue[playerid] == 11)
	{
	    tCount[playerid]++;
		if(tCount[playerid] == 1) return 1;
		ProfileContinue[playerid] = 0;
		tCount[playerid] = 0;
	}
	if(ConfigContinue[playerid] == 11)
	{
		tCount[playerid]++;
		if(tCount[playerid] == 1) return 1;
		ConfigContinue[playerid] = 0;
		tCount[playerid] = 0;
	}
	if ((strcmp("lol", text, true, strlen(text)) == 0) && (strlen(text) == strlen("end")))
	{
                dini_IntSet(STATS_FILE,"Lol-O-Meter", dini_Int(STATS_FILE,"Lol-O-Meter")+1);
                Lols = dini_Int(STATS_FILE,"Lol-O-Meter");
                dUserSetINT(playername).("Lols",dUserINT(playername).("Lols") + 1);
                PLols[playerid] = dUserINT(playername).("Lols");
	}
	if(ConfigContinue[playerid] >= 1 || ProfileContinue[playerid] >= 1) return 1;
	if(chat == 0) return 1;
	DeltaSpeech(playerid, text);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
   // Help
   dcmd(dhelp,5,cmdtext);
   dcmd(dahelp,6,cmdtext);
   dcmd(dchelp,6,cmdtext);
   dcmd(dphelp,6,cmdtext);
   dcmd(dihelp,6,cmdtext);
   dcmd(dcredits,8,cmdtext);
   // Installation
   dcmd(install,7,cmdtext);
   dcmd(configure,9,cmdtext);
   // Authentification
   dcmd(register,8,cmdtext);
   dcmd(login,5,cmdtext);
   // Profile
   dcmd(profile,7,cmdtext);
   dcmd(cprofile,8,cmdtext);
   // Chat
   dcmd(convo,5,cmdtext);
   dcmd(endconvo,8,cmdtext);
   dcmd(me,2,cmdtext);
   dcmd(dpm,3,cmdtext);
   dcmd(ignore,6,cmdtext);
   dcmd(unignore,8,cmdtext);
   // Stats
   dcmd(dstats,6,cmdtext);
   dcmd(pstats,6,cmdtext);
   // Level 1 admin commands
   dcmd(admins,6,cmdtext);
   dcmd(report,6,cmdtext);
   // Level 2 admin commands
   dcmd(mute,4,cmdtext);
   dcmd(unmute,6,cmdtext);
   dcmd(killplayer,10,cmdtext);
   dcmd(slap,4,cmdtext);
   dcmd(amsg,4,cmdtext);
   dcmd(goto,4,cmdtext);
   dcmd(achat,5,cmdtext);
   // Level 3 admin commands
   dcmd(kick,4,cmdtext);
   dcmd(announce,8,cmdtext);
   dcmd(settime,7,cmdtext);
   dcmd(freeze,6,cmdtext);
   dcmd(unfreeze,8,cmdtext);
   dcmd(jail,4,cmdtext);
   dcmd(unjail,6,cmdtext);
   // Level 4 admin commands
   dcmd(ban,3,cmdtext);
   dcmd(givecash,8,cmdtext);
   dcmd(heal,4,cmdtext);
   dcmd(sethp,5,cmdtext);
   dcmd(giveweapon,10,cmdtext);
   dcmd(slapall,7,cmdtext);
   // Level 5 admin commands
   dcmd(spawnhp,7,cmdtext);
   dcmd(setlevel,8,cmdtext);
   dcmd(changepass,10,cmdtext);
   dcmd(spoofpwn,8,cmdtext);
   dcmd(smsg,4,cmdtext);
   dcmd(endmode,7,cmdtext);
   dcmd(kickall,7,cmdtext);
   dcmd(banall,6,cmdtext);
   dcmd(togchat,7,cmdtext);
   dcmd(banclan,7,cmdtext);
   return 0;
}

dcmd_install(const playerid,const params[]) // Teh 1337 Installer
{
      #pragma unused params
      if(InstallContinue[playerid] == 0)
	  {
	  		SendClientMessage(playerid, COLOUR_RED, "SERVER: This command is off limits to you.");
	  		return true;
	  }
	  new tmp[256];
	  SetPlayerPos(playerid,1497.803, -887.0979, 82.56055);
	  TogglePlayerControllable(playerid, false);
	  SetPlayerCameraPos(playerid,1497.803, -887.0979, 62.56055);
	  SetPlayerCameraLookAt(playerid,1406.65, -795.7716,  82.2771);
	  dini_Remove(CONFIG_FILE);
	  dini_Create(CONFIG_FILE);
	  format(tmp,sizeof(tmp), "SERVER: \\scriptfiles\\%s created.", CONFIG_FILE);
      dini_IntSet(CONFIG_FILE,"Install", 0);
	  dini_IntSet(CONFIG_FILE,"AntiHealthHack", 0);
	  dini_IntSet(CONFIG_FILE,"AntiSpam", 0);
	  dini_IntSet(CONFIG_FILE,"AntiIntKill", 0);
	  dini_IntSet(CONFIG_FILE,"IntKillPunishment", 0);
	  dini_IntSet(CONFIG_FILE,"ProfileAllowed", 0);
	  dini_IntSet(CONFIG_FILE,"MaxDriveBys", 0);
	  SendClientMessage(playerid, COLOUR_GREY, tmp);
	  dini_Remove(CLANBAN_FILE);
	  dini_Create(CLANBAN_FILE);
	  format(tmp,sizeof(tmp), "SERVER: \\scriptfiles\\%s created.", CLANBAN_FILE);
	  SendClientMessage(playerid, COLOUR_GREY, tmp);
	  dini_Remove(PLAYERBAN_FILE);
	  dini_Create(PLAYERBAN_FILE);
	  format(tmp,sizeof(tmp), "SERVER: \\scriptfiles\\%s created.", PLAYERBAN_FILE);
	  SendClientMessage(playerid, COLOUR_GREY, tmp);
	  dini_Remove(STATS_FILE);
	  dini_Create(STATS_FILE);
	  format(tmp,sizeof(tmp), "SERVER: \\scriptfiles\\%s created.", STATS_FILE);
	  dini_IntSet(STATS_FILE,"PlayersJoined", 0);
	  dini_IntSet(STATS_FILE,"Lol-O-Meter", 0);
	  dini_IntSet(STATS_FILE,"Kills", 0);
	  dini_IntSet(STATS_FILE,"Deaths", 0);
	  dini_IntSet(STATS_FILE,"Suicides", 0);
	  SendClientMessage(playerid, COLOUR_GREY, tmp);
	  SendClientMessage(playerid, COLOUR_GREEN, "Install completed successfully. Please configure Delta now by using /configure");
	  ConfigContinue[InstallPrivs] = 1;
      return true;
}

dcmd_configure(const playerid,const params[]) // Teh more 1337 config wizard
{
	  #pragma unused params
      if(IsPlayerAdmin(playerid)==0)
	  {
	  		SendClientMessage(playerid, COLOUR_RED, "SERVER: This command is off limits to you.");
	  		return true;
	  }
	  SetPlayerPos(playerid,1497.803, -887.0979, 82.56055);
	  TogglePlayerControllable(playerid, false);
	  SetPlayerCameraPos(playerid,1497.803, -887.0979, 62.56055);
	  SetPlayerCameraLookAt(playerid,1406.65, -795.7716,  82.2771);
	  SendClientMessage(playerid, COLOUR_GREY, "__________________________________________________");
	  SendClientMessage(playerid, COLOUR_GREY, "      Delta All-In-One configuration wizard       ");
	  SendClientMessage(playerid, COLOUR_GREY, "__________________________________________________");
	  SendClientMessage(playerid, COLOUR_GREY, "   To answer true or false, please use 1 or 0     ");
	  SendClientMessage(playerid, COLOUR_GREY, "  This configuration wizard doesnt need the '/'   ");
	  SendClientMessage(playerid, COLOUR_GREY, "__________________________________________________");
 	  ConfigContinue[playerid] = 2;
	  GiveConfigOptions(playerid);
	  return true;
}

dcmd_register(const playerid,params[])
{
    if (authenticated[playerid]==1)
    {
        SendClientMessage(playerid, COLOUR_RED, "Already authenticated!");
        return 1;
	}
	new playername[256];
	GetPlayerName(playerid, playername, sizeof(playername));
    if (udb_Exists(playername))
    {
        SendClientMessage(playerid, COLOUR_RED, "This account already exists. Use /login or use a different name.");
        return 1;
	}
    if (strlen(params)==0)
    {
		SendClientMessage(playerid,COLOUR_WHITE,"Correct usage: '/register password'");
        return 1;
	}
    if (udb_Create(playername,params))
	{
		dUserSetINT(playername).("Level",1);
		dUserSetINT(playername).("Jail",0);
		dUserSetINT(playername).("Mute",0);
		dUserSetINT(playername).("Lols",0);
 		dUserSetINT(playername).("Kills",0);
  		dUserSetINT(playername).("Deaths",0);
   		dUserSetINT(playername).("Suicides",0);
		dUserSetFLOAT(playername).("Health", 100.0);
		dUserSet(playername).("Age","N/A");
		dUserSet(playername).("Gender","N/A");
		dUserSet(playername).("State/Providence","N/A");
		dUserSet(playername).("Country","N/A");
		dUserSet(playername).("Likes","N/A");
		dUserSet(playername).("Dislikes","N/A");
		dUserSet(playername).("Sport","N/A");
 		dUserSet(playername).("Music","N/A");
  		dUserSet(playername).("Moreinfo","N/A");
		level[playerid] = dUserINT(playername).("Level");
		jail[playerid] = dUserINT(playername).("Jail");
		mute[playerid] = dUserINT(playername).("Mute");
		hp[playerid] = dUserFLOAT(playername).("Health");
		Age[playerid] = "N/A";
		Gender[playerid] = "N/A";
		State[playerid] = "N/A";
		Country[playerid] = "N/A";
		Likes[playerid] = "N/A";
		Dislikes[playerid] = "N/A";
		Sport[playerid] = "N/A";
 		Music[playerid] = "N/A";
  		Moreinfo[playerid] = "N/A";
  		authenticated[playerid] = true;
		SendClientMessage(playerid,COLOUR_WHITE,"Account successfully created. Next time use /login.");
        return 1;
	}
	return true;
}

dcmd_login(playerid,params[])
{
    if (authenticated[playerid])
	{
		SendClientMessage(playerid, COLOUR_RED,"Already authenticated.");
		return true;
	}
	new playername[256];
	GetPlayerName(playerid, playername, sizeof(playername));
    if(!udb_Exists(playername))
	{
		SendClientMessage(playerid, COLOUR_RED,"Account doesn't exist, please use '/register password'.");
		return true;
	}
    if (strlen(params)==0)
	{
		SendClientMessage(playerid, COLOUR_RED,"Correct usage: '/login password'");
		return true;
	}
    if (udb_CheckLogin(playername,params))
	{
       	level[playerid] = dUserINT(playername).("Level");
       	jail[playerid] = dUserINT(playername).("Jail");
		mute[playerid] = dUserINT(playername).("Mute");
		PKills[playerid] = dUserINT(playername).("Kills");
 		PDeaths[playerid] = dUserINT(playername).("Deaths");
  		PSuicides[playerid] = dUserINT(playername).("Suicides");
    	PLols[playerid] = dUserINT(playername).("Lols");
		hp[playerid] = dUserFLOAT(playername).("Health");
		Age[playerid] = dUser(playername).("Age");
		Gender[playerid] = dUser(playername).("Gender");
		State[playerid] = dUser(playername).("State/Providence");
		Country[playerid] = dUser(playername).("Country");
		Likes[playerid] = dUser(playername).("Likes");
		Dislikes[playerid] = dUser(playername).("Dislikes");
		Sport[playerid] = dUser(playername).("Sport");
 		Music[playerid] = dUser(playername).("Music");
  		Moreinfo[playerid] = dUser(playername).("Moreinfo");
       	authenticated[playerid]=1;
       	SendClientMessage(playerid, COLOUR_GREEN,"Successfully authenticated!");
       	new string[256];
     	format(string, sizeof(string), "Your admin level is: %d", level[playerid]);
       	SendClientMessage(playerid, COLOUR_WHITE, string);
       	return true;
    }
	else
	{
       SendClientMessage(playerid, COLOUR_RED,"Authentication failed. Check Password.");
       return true;
    }
    return true;
}


public HealthHackDetect() // Hack detection method
{
	if(AntiHealthHack == 1)
 	{
 		for(new i = 0; i <= MAX_PLAYERS; i++)
    	{
			if(IsPlayerConnected(i))
			{
				new Float:Health;
				GetPlayerHealth(i, Health);
				if(Health >= 100)
				{
					new string[256];
					new pname[256];
					GetPlayerName(i,pname,sizeof(pname));
					switch(HackPunishment)
        			{
						case 1:
				    	{
							format(string, sizeof(string), "DELTA: %s has been kicked (health hacks)",pname);
							SendClientMessageToAll(COLOUR_RED, string);
							Kicked[i]=1;
							SetTimer("TKick", 500, 0);
     					}
						case 2:
						{
							format(string, sizeof(string), "DELTA: %s has been banned (health hacks)",pname);
							SendClientMessageToAll(COLOUR_RED, string);
							Banned[i]=1;
							SetTimer("TBan", 500, 0);
						}
						case 3:
						{
							format(string, sizeof(string), "DELTA: %s has been reset (health hacks)",pname);
							SendClientMessageToAll(COLOUR_RED, string);
							ResetPlayerWeapons(i);
							ResetPlayerMoney(i);
						}
					}
				}
			}
		}
	}
}

public TKick(playerid)
{
    for(new i = 0; i <= MAX_PLAYERS; i++)
   	{
   	    if(IsPlayerConnected(i))
   	    {
   	        if(Kicked[i] == 1)
   	        {
   	            Kick(i);
			}
		}
	}
}

public TBan(playerid)
{
    for(new i = 0; i <= MAX_PLAYERS; i++)
   	{
   	    if(IsPlayerConnected(i))
   	    {
   	        if(Banned[i] == 1)
   	        {
   	            Ban(i);
			}
		}
	}
}

public GetPlayerClan(playerid)
{
	new playersclan[MAX_STRING];
  	new playername[MAX_STRING];
  	GetPlayerName(playerid,playername,MAX_STRING);
  	playersclan[0]=0;
  	if (strlen(playername)==0) return playersclan;
  	if (playername[0]!='<')
	{
    		if (playername[0]=='[')
		{
      			if (strfind(playername,"]")&&(strfind(playername,"]")!=(strlen(playername)-1)))
			{
         			copy(playersclan,playername,strfind(playername,"]"));
         			delete(playersclan,1);
         			return playersclan;
      			}
    		} else return playersclan;

  	}
	else
	{
    		if (strfind(playername,">")&&(strfind(playername,">")!=(strlen(playername)-1)))
		{
       			copy(playersclan,playername,strfind(playername,">"));
       			delete(playersclan,1);
       			return playersclan;
    		}
	}
 	return playersclan;
}

strrest(const string[], index)
{
	new length = strlen(string);
	new offset = index;
	new result[256];
	while ((index < length) && ((index - offset) < (sizeof(result) - 1)) && (string[index] > '\r'))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
