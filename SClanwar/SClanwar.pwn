/*
 ----------------------------------------
|========================================|
|================SClanwar================|
|============by=Schummi[CoD]=============|
|========================================|
 ----------------------------------------

zuschauerkill raus genommen weil es noch nicht richtig klappt
*/

#include <a_samp>
#include <core>
#include <float>

//Color Defines
#define COLOR_RED 0xAA3333AA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_GREY 0xAFAFAFAA
//Team Defines
#define TEAM_1 0
#define TEAM_2 1
#define TEAM_REF 2
#define MAX_STRING 255

new killername[MAX_PLAYER_NAME];
new killedname[MAX_PLAYER_NAME];

new roundwinner[255],killwinner[256],winner[256];

new gTeam[MAX_PLAYERS];
new TEAM1[256], TEAM2[256], ROUNDKILLS, ROUND;
new wpn1, wpn2, wpn3;
new ammo1, ammo2, ammo3;
new Count=5;
new COUNTDOWN=3;
new astring[256],mstring[256];
new aAutoS; //
new Text:Textdraw0;
new Text:Textdraw1;
new Text:Textdraw2;
new Text:Textdraw3;
new Text:Textdraw4;

new DeathCount[MAX_PLAYERS];
new Kills[MAX_PLAYERS];
new tkscore[MAX_PLAYERS];
new bestT1[60],bestT2[60];
new worstT1[60],worstT2[60];
new mosttkillT1[60],mosttkillT2[60];
new bestg[60];
new worstg[60];
new mosttkillg[60];
new warbestT1[60],warbestT2[60];
new warworstT1[60],warworstT2[60];
new warmtkillT1[60],warmtkillT2[60];
new warbestg[60];
new warworstg[60];
new warmtkillg[60];
new warbestT1val,warbestT2val;
new warworstT1val,warworstT2val;
new warmtkillT1val,warmtkillT2val;
new warbestgval;
new warworstgval;
new warmtkillgval;

new sCount1, sCount2;
new rCount1, rCount2;
new rCount;
//new zuschauerkill[MAX_PLAYERS];
new warkillsT1,warkillsT2;

forward CalcStats();
forward spawn();
forward CountDown();
forward iFreeze();
forward SetupPlayerForClassSelection(playerid);
forward NextRund();
forward resets();
forward COUNT();

new CWInfo[MAX_PLAYERS];

//------------------------------------------------------------------------------

main()
{
	print("\n|------------------------------------|");
	print("|          ClanWar Script            |");
	print("|Coded by Scarface  Edited by Schummi|");
	print("|------------------------------------|\n");
	print("Loading Config......\n");
	printf("     |  %s VS. %s  |            ",TEAM1, TEAM2);
	printf("     | %d Runden mit %d Kills |  ",ROUND,ROUNDKILLS);
	print("| Clan mit meisten Runden gewinnt | ");
//	if(aAutoS > 0){ print("    |Auto-Clan-Detection   [Activated]\n"); }else{ print("    |Auto-Clan-Detection   [Disabled]\n");}
}

//------------------------------------------------------------------------------

public OnGameModeInit()
{
	new ustring[255];
	SetDisabledWeapons(43,44,45);
	SetTeamCount(3);
	ShowNameTags(1);
	ShowPlayerMarkers(0);
	rConfig();
	format(ustring,sizeof(ustring),"%s gegen %s",TEAM1,TEAM2);
	SetGameModeText(ustring);
    UsePlayerPedAnims();
    SetWorldTime(8);

	AddPlayerClass(115,-2053.0,-132.8756,35.3216,180.0,wpn1,ammo1,wpn2,ammo2,wpn3,ammo3); // Team1 spawn
	AddPlayerClass(114,-2053.0,-262.8756,35.3216,0.0,wpn1,ammo1,wpn2,ammo2,wpn3,ammo3); // Team2 spawn
	AddPlayerClass(21,-2047.2230,-206.6431,52.4003,270.0,43,500,0,0,0,0); //
	
	CreateObject(5005, 1817.106201, -2508.876221, 16.106205, 0.0000, 0.0000, 0.0000);
	CreateObject(5005, 1900.440674, -2481.250244, 16.090637, 0.0000, 0.0000, 90.0000);
	CreateObject(5005, 1820.962646, -2398.275146, 16.106205, 0.0000, 0.0000, 180.0000);
	CreateObject(5005, 1737.480835, -2431.977783, 16.106205, 0.0000, 0.0000, 90.0002);
	
	format(astring,sizeof(astring),"%s %d  :  %d %s",TEAM1,sCount1,sCount2,TEAM2);
	Textdraw0 = TextDrawCreate(430.000000,105.000000,astring);
	format(mstring,sizeof(mstring),"%s %d  :  %d %s",TEAM1,rCount1,rCount2,TEAM2);
	Textdraw1 = TextDrawCreate(430.000000,115.000000,mstring);
	Textdraw2 = TextDrawCreate(385.000000,105.000000,"Kills:");
	Textdraw3 = TextDrawCreate(360.000000,115.000000,"Runden:");
	Textdraw4 = TextDrawCreate(0.00000000,436.000000,"Script by Schummi[CoD]                        www.clan-of-destruction.de.ms");
	TextDrawAlignment(Textdraw0,0);
	TextDrawAlignment(Textdraw1,0);
	TextDrawAlignment(Textdraw2,0);
	TextDrawAlignment(Textdraw3,0);
	TextDrawAlignment(Textdraw4,0);
	TextDrawBackgroundColor(Textdraw0,0x000000ff);
	TextDrawBackgroundColor(Textdraw1,0x000000ff);
	TextDrawBackgroundColor(Textdraw2,0x000000ff);
	TextDrawBackgroundColor(Textdraw3,0x000000ff);
	TextDrawBackgroundColor(Textdraw4,0x000000ff);
	TextDrawFont(Textdraw0,1);
	TextDrawLetterSize(Textdraw0,0.499999,1.100000);
	TextDrawFont(Textdraw1,1);
	TextDrawLetterSize(Textdraw1,0.499999,1.100000);
	TextDrawFont(Textdraw2,1);
	TextDrawLetterSize(Textdraw2,0.499999,1.100000);
	TextDrawFont(Textdraw3,1);
	TextDrawLetterSize(Textdraw3,0.499999,1.100000);
	TextDrawFont(Textdraw4,1);
	TextDrawLetterSize(Textdraw4,0.499999,1.100000);
	TextDrawColor(Textdraw0,0xffffffff);
	TextDrawColor(Textdraw1,0xffffffff);
	TextDrawColor(Textdraw2,0xffffffff);
	TextDrawColor(Textdraw3,0xffffffff);
	TextDrawColor(Textdraw4,0xff0000ff);
	TextDrawSetProportional(Textdraw0,1);
	TextDrawSetProportional(Textdraw1,1);
	TextDrawSetProportional(Textdraw2,1);
	TextDrawSetProportional(Textdraw3,1);
	TextDrawSetProportional(Textdraw4,1);
	TextDrawSetShadow(Textdraw0,1);
	TextDrawSetShadow(Textdraw1,1);
	TextDrawSetShadow(Textdraw2,1);
	TextDrawSetShadow(Textdraw3,1);
	TextDrawSetShadow(Textdraw4,1);
	
	
	return 1;
 }

//------------------------------------------------------------------------------



public OnPlayerConnect(playerid)
{
	SetWorldTime(8);
    new wString[256],pName[MAX_PLAYER_NAME];
    
    SetDisabledWeapons(43,44,45,38);
    //zuschauerkill[playerid]=0;
    TextDrawShowForPlayer(playerid,Text:Textdraw0);
    TextDrawShowForPlayer(playerid,Text:Textdraw1);
    TextDrawShowForPlayer(playerid,Text:Textdraw2);
    TextDrawShowForPlayer(playerid,Text:Textdraw3);
    TextDrawShowForPlayer(playerid,Text:Textdraw4);
    
    GetPlayerName(playerid,pName,sizeof(pName));
    
	format(wString,sizeof(wString),"%s hat den ClanWar Server betreten!",pName);
	SendClientMessageToAll(COLOR_GREY,wString);
	SendClientMessage(playerid,COLOR_GREEN,"Schau dir /help und /commands durch");
	
	SetPlayerColor(playerid, COLOR_GREY);
//	gTeam[playerid] = ClanDetect(playerid);
    if(CWInfo[playerid] == 1)
	{
	SendClientMessage(playerid,COLOR_RED,"Bitte nimm den REF skin und nimm erst nen Team skin wenn diese Runde beendet ist!");
	}else if(CWInfo[playerid]==0)
	{
	}
	return 1;
}

public OnPlayerDisconnect(playerid,reason)
{
	new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pName,sizeof(pName));
	//zuschauerkill[playerid]=0;
	switch(reason)
	{
	case 0:format(astring,sizeof(astring),"%s hat den ClanWar Server verlassen. (Crash)",pName);
	case 1:format(astring,sizeof(astring),"%s hat den ClanWar Server verlassen. (Verlassen)",pName);
	case 2:format(astring,sizeof(astring),"%s hat den ClanWar Server verlassen. (Kick/Ban)",pName);
	}
	SendClientMessageToAll(COLOR_GREY,astring);
	return 1;
}



//------------------------------------------------------------------------------



public OnPlayerSpawn(playerid)
{
	SetDisabledWeapons(43,44,45);
	SetPlayerInterior(playerid,0);
	if(gTeam[playerid] == TEAM_1)
	{
	SetPlayerColor(playerid,COLOR_RED);// Red
	}
	else if(gTeam[playerid] == TEAM_2)
	{
	SetPlayerColor(playerid,COLOR_BLUE); // Blue
	}
	else if(gTeam[playerid] == TEAM_REF)
	{
	SetPlayerColor(playerid,COLOR_LIGHTBLUE); // Light Blue
	}
	if(CWInfo[playerid]==0)
	{
	if(gTeam[playerid] == TEAM_1 || gTeam[playerid] == TEAM_2)
	{
	new pname7[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pname7,sizeof(pname7));
	TogglePlayerControllable(playerid,0);
	SendClientMessage(playerid,COLOR_RED,"Clanwar noch nicht gestartet!Du wirst gefreezed!");
	format(astring, sizeof(astring), "%s gegen %s", TEAM1, TEAM2);
	GameTextForPlayer(playerid,astring,1500,5);
 	}
 	}else
 	{
 	TogglePlayerControllable(playerid,1);
 	}
	
	
	if(aAutoS == 1) // AUTO SPAWN IMPLEMENTATION
	{
	    if(gTeam[playerid] == TEAM_1)
		{
		SetPlayerFacingAngle(playerid, 90);
		SetPlayerSkin(playerid, 115);
		return 1;
  		}
		else if(gTeam[playerid] == TEAM_2)
		{
		SetPlayerFacingAngle(playerid, 270);
	 	SetPlayerSkin(playerid, 114);
	 	return 1;
		}
		else if(gTeam[playerid] == TEAM_REF)
		{
		SetPlayerFacingAngle(playerid, 180);
		SetPlayerSkin(playerid, 21);
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 43,500);
		return 1;
		}
		}
		
	return 1;
 }






//------------------------------------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
//new sstring[256];

if(gTeam[killerid] != gTeam[playerid])
{

/*if(gTeam[playerid] == TEAM_REF && gTeam[killerid] == TEAM_1)
  {
  new name[MAX_PLAYER_NAME];
  zuschauerkill[killerid]++;
  GetPlayerName(killerid,name,sizeof(name));
  if(zuschauerkill[killerid]<5)
  format(sstring,sizeof(sstring),"%s hat einen Zuschauer getˆtet und nun schon %d auf dem Gewissen",name,zuschauerkill);
  SendClientMessageToAll(COLOR_RED,sstring);
  }else if(zuschauerkill[killerid]==5){
  new name[MAX_PLAYER_NAME];
  format(astring,sizeof(astring),"%s hat 5 Zuschauer auf dem Gewissen und wurde gekickt!",name);
  SendClientMessageToAll(COLOR_RED,astring);
  Kick(killerid);

  }else if(gTeam[playerid] == TEAM_REF && gTeam[killerid] == TEAM_2)
  {
  new name[MAX_PLAYER_NAME];
  zuschauerkill[killerid]++;
  GetPlayerName(killerid,name,sizeof(name));
  if(zuschauerkill[killerid]<5)
  format(sstring,sizeof(sstring),"%s hat einen Zuschauer getˆtet und nun schon %d auf dem Gewissen",name,zuschauerkill);
  SendClientMessageToAll(COLOR_RED,sstring);
  }else if(zuschauerkill[killerid]==5){
  new name[MAX_PLAYER_NAME];
  format(astring,sizeof(astring),"%s hat 5 Zuschauer auf dem Gewissen und wurde gekickt!",name);
  SendClientMessageToAll(COLOR_RED,astring);
  Kick(killerid);
  }*/

if(gTeam[killerid] == TEAM_1 && gTeam[playerid] == TEAM_2)
{
	SendDeathMessage(killerid,playerid,reason);
	SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
	GetPlayerName(killerid,killername,sizeof(killername));
	GetPlayerName(playerid,killedname,sizeof(killedname));
	Kills[killerid]++;
	DeathCount[playerid]++;
}
else if(gTeam[killerid] == TEAM_2 && gTeam[playerid] == TEAM_1)
{
	SendDeathMessage(killerid,playerid,reason);
	SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
	Kills[killerid]++;
	DeathCount[playerid]++;
}
}
  else if(gTeam[killerid] == TEAM_1 && gTeam[playerid] == TEAM_1)
  {
  new warning[256];
  format(warning, sizeof(warning),"Kein Teamkill");
  GameTextForPlayer(killerid,warning,2000,5);
  SendDeathMessage(killerid,playerid,reason);
  tkscore[killerid]++;
  

  }else if(gTeam[killerid] == TEAM_2 && gTeam[playerid] == TEAM_2)
  {
  new warning[256];
  format(warning, sizeof(warning), "Achtung!Kein Teamkill");
  SendClientMessage(killerid, 0xFFFF00AA, warning);
  SendDeathMessage(killerid,playerid,reason);
  tkscore[killerid]++;
  }
  
new string[256], string2[256], string3[256];
	
if(IsPlayerConnected(killerid))
	{
if(gTeam[killerid] == TEAM_1 && gTeam[playerid] == TEAM_2)
	{
	    new pName[MAX_PLAYER_NAME];
	    new pNAme[MAX_PLAYER_NAME];
		sCount1++;
		warkillsT1++;
		GetPlayerName(killerid,pName,sizeof(pName));
		GetPlayerName(playerid,pNAme,sizeof(pNAme));
		format(string2, sizeof(string2), "%s punktet!",TEAM1);
		SendClientMessageToAll(COLOR_GREY, string2);
		printf("%s und %s punkten: %s  %d  ||  %d  %s", pName, TEAM1, TEAM1, sCount1, sCount2, TEAM2);
		format(astring,sizeof(astring),"%s %d  :  %d %s",TEAM1,sCount1,sCount2,TEAM2);
		TextDrawSetString(Text:Textdraw0,astring);
	}
	
if(gTeam[killerid] == TEAM_2 && gTeam[playerid] == TEAM_1)
	{
	    new pName2[MAX_PLAYER_NAME];
	    new pNAme2[MAX_PLAYER_NAME];
	    sCount2++;
	    warkillsT2++;
	    GetPlayerName(killerid,pName2,sizeof(pName2));
	    GetPlayerName(playerid,pNAme2,sizeof(pNAme2));
		format(string3, sizeof(string3), "%s punktet!",TEAM2);
		SendClientMessageToAll(COLOR_GREY, string3);
  		printf("%s und %s punkten: %s  %d  ||  %d  %s", pName2, TEAM2, TEAM1, sCount1, sCount2, TEAM2);
  		format(astring,sizeof(astring),"%s %d  :  %d %s",TEAM1,sCount1,sCount2,TEAM2);
		TextDrawSetString(Text:Textdraw0,astring);
	}
	}
if(sCount1 == ROUNDKILLS)
	{
		rCount1++;
		rCount++;
		if(rCount != ROUND)
		{
		    strins(roundwinner,TEAM1,0,sizeof(roundwinner));
			format(string, sizeof(string), "%s gewinnt die %d. Runde mit %d zu %d Kills", TEAM1, rCount,sCount1, sCount2);
	    	SendClientMessageToAll(COLOR_YELLOW,string);
	    	format(astring,sizeof(astring),"%s %d  :  %d %s",TEAM1,rCount1,rCount2,TEAM2);
			TextDrawSetString(Text:Textdraw1,astring);
			CalcStats();
			iFreeze();
			iStats();
			SetTimer("resets",5600,0);
			SetTimer("NextRund",10000,0);
			SetTimer("COUNT",10000,0);
		}
		
		if(rCount == ROUND)
		{
			if(rCount1 > rCount2)
	    	{
	    	    strins(roundwinner,TEAM1,0,sizeof(roundwinner));
	    	    strins(winner,TEAM1,0,sizeof(winner));
	    		format(string, sizeof(string), "%s hat die %d. Runde mit %d zu %d Kills und damit den ClanWar mit %d zu %d gewonnen!", TEAM1, rCount,sCount1, sCount2, rCount1, rCount2);
	    		SendClientMessageToAll(COLOR_YELLOW,string);
	    		format(astring,sizeof(astring),"%s %d  :  %d %s",TEAM1,rCount1,rCount2,TEAM2);
				TextDrawSetString(Text:Textdraw1,astring);
				CalcStats();
	    		iFreeze();
	    		iStats();
	    		Stats();
				SetTimer("resets",5600,0);
				SetTimer("spawn",4500,0);
	    		}
			if(rCount2 > rCount1)
			{
			    strins(roundwinner,TEAM1,0,sizeof(roundwinner));
			    strins(winner,TEAM2,0,sizeof(winner));
	    		format(string, sizeof(string), "%s hat die %d. Runde mit %d zu %d Kills gewonnen, doch %s hat den ClanWar mit %d zu %d gewonnen!", TEAM1, rCount,sCount1, sCount2, TEAM2, rCount2, rCount1);
	    		SendClientMessageToAll(COLOR_YELLOW,string);
	    		format(astring,sizeof(astring),"%s %d  :  %d %s",TEAM1,rCount1,rCount2,TEAM2);
				TextDrawSetString(Text:Textdraw1,astring);
				CalcStats();
	    		iFreeze();
	    		iStats();
	    		Stats();
				SetTimer("resets",4900,0);
				SetTimer("spawn",4500,0);
			}
			for (new i; i < MAX_PLAYERS; i++)
			CWInfo[i]=0;
		}
	}
	
else if(sCount2 == ROUNDKILLS)
	{
		rCount2++;
		rCount++;
		if(rCount != ROUND)
		{
		    strins(roundwinner,TEAM2,0,sizeof(roundwinner));
			format(string, sizeof(string), "%s gewinnt die %d. Runde mit %d zu %d Kills", TEAM2, rCount,sCount2, sCount1);
	    	SendClientMessageToAll(COLOR_YELLOW,string);
	    	format(astring,sizeof(astring),"%s %d  :  %d %s",TEAM1,rCount1,rCount2,TEAM2);
			TextDrawSetString(Text:Textdraw1,astring);
			CalcStats();
	    	iFreeze();
	    	iStats();
			SetTimer("resets",5600,0);
			SetTimer("NextRund",10000,0);
			SetTimer("COUNT",10000,0);
		}

		if(rCount == ROUND)
		{
			if(rCount2 > rCount1)
	    	{
	    	    strins(roundwinner,TEAM2,0,sizeof(roundwinner));
	    	    strins(winner,TEAM2,0,sizeof(winner));
	    		format(string, sizeof(string), "%s hat die %d. Runde mit %d zu %d Kills und damit den ClanWar mit %d zu %d gewonnen!", TEAM2, rCount,sCount2, sCount1, rCount2, rCount1);
	    		SendClientMessageToAll(COLOR_YELLOW,string);
	    		format(astring,sizeof(astring),"%s %d  :  %d %s",TEAM1,rCount1,rCount2,TEAM2);
				TextDrawSetString(Text:Textdraw1,astring);
				CalcStats();
	    		iFreeze();
	    		iStats();
	    		Stats();
				SetTimer("resets",5600,0);
				SetTimer("spawn",4500,0);
	    		}
			if(rCount1 > rCount2)
			{
			    strins(roundwinner,TEAM2,0,sizeof(roundwinner));
			    strins(winner,TEAM1,0,sizeof(winner));
	    		format(string, sizeof(string), "%s hat die %d. Runde mit %d zu %d Kills gewonnen, doch %s hat den ClanWar mit %d zu %d gewonnen!", TEAM2, rCount,sCount2, sCount1, TEAM1, rCount1, rCount2);
	    		SendClientMessageToAll(COLOR_YELLOW,string);
	    		format(astring,sizeof(astring),"%s %d  :  %d %s",TEAM1,rCount1,rCount2,TEAM2);
				TextDrawSetString(Text:Textdraw1,astring);
				CalcStats();
	    		iFreeze();
	    		iStats();
	    		Stats();
				SetTimer("resets",4900,0);
				SetTimer("spawn",4500,0);
			}
			for (new i; i < MAX_PLAYERS; i++)
			CWInfo[i]=0;
		}
	}

return 1;
}


//------------------------------------------------------------------------------


public OnPlayerRequestClass(playerid, classid)
{
            SetPlayerClass(playerid,classid);


			if(gTeam[playerid] == TEAM_1)
	        {
         		SetPlayerSkin(playerid, 115);
				GameTextForPlayer(playerid,TEAM1,2000,3);
				SetPlayerInterior(playerid, 0);
				SetPlayerPos(playerid,-2053.0,-132.8756,35.3216);
				SetPlayerFacingAngle(playerid, 180);
				SetPlayerCameraPos(playerid,-2053.0,-138.8756,35.3216);
				SetPlayerCameraLookAt(playerid,-2053.0,-132.8756,35.3216);
			}
			else if(gTeam[playerid] == TEAM_2)
	        {
	            SetPlayerSkin(playerid, 114);
				GameTextForPlayer(playerid,TEAM2,2000,3);
				SetPlayerInterior(playerid, 0);
				SetPlayerPos(playerid,-2053.0,-262.8756,35.3216);
				SetPlayerFacingAngle(playerid, 0);
				SetPlayerCameraPos(playerid,-2053.0,-256.8756,35.3216);
				SetPlayerCameraLookAt(playerid,-2053.0,-262.8756,35.3216);
			}
			else if(gTeam[playerid] == TEAM_REF)
		    {
                SetPlayerSkin(playerid, 21);
				GameTextForPlayer(playerid,"~g~Ref",2000,3);
				SetPlayerInterior(playerid, 0);
				SetPlayerPos(playerid,-2047.2230,-206.6431,52.4003);
				SetPlayerFacingAngle(playerid, 270);
				SetPlayerCameraPos(playerid,-2041.2230,-206.6431,52.4003);
				SetPlayerCameraLookAt(playerid,-2047.2230,-206.6431,52.4003);
   			}
   			return 1;
		}




//------------------------------------------------------------------------------


SetPlayerClass(playerid, classid) {

	if(classid == 0){ gTeam[playerid] = TEAM_1;
	}
	else if(classid == 1){ gTeam[playerid] = TEAM_2;
	}
	else if(classid == 2){ gTeam[playerid] = TEAM_REF;
	}
	return 1;
}

//------------------------------------------------------------------------------

// READ FILE CONFIG

rConfig()
{
	new File:fhandle;
	new cname[256];
	new temp[256];
	new value[256];
	fhandle = fopen("ClanConfig.txt",io_readwrite);
	while(fread(fhandle,temp,sizeof(temp),false))
		{
		    cname = strtok(temp,0);
			value = strtok(temp,(strlen(cname)+1));
			
			if(strcmp(cname,"Team-1",true) == 0) strins(TEAM1,value,0,MAX_STRING);
			else if(strcmp(cname,"Team-2",true) == 0) strins(TEAM2,value,0,MAX_STRING);
			else if(strcmp(cname,"ROUND",true) == 0) ROUND = strval(value);
			else if(strcmp(cname,"ROUNDKILLS",true) == 0) ROUNDKILLS = strval(value);
			else if(strcmp(cname,"Weapon1",true) == 0) wpn1 = strval(value);
			else if(strcmp(cname,"Weapon2",true) == 0) wpn2 = strval(value);
			else if(strcmp(cname,"Weapon3",true) == 0) wpn3 = strval(value);
			else if(strcmp(cname,"Ammo1",true) == 0) ammo1 = strval(value);
			else if(strcmp(cname,"Ammo2",true) == 0) ammo2 = strval(value);
			else if(strcmp(cname,"Ammo3",true) == 0) ammo3 = strval(value);
//			else if(strcmp(cname,"Clan-Detect",true) == 0) aAutoS = strval(value);
		}
    fclose(fhandle);
	return 1;
}

/*
========================
        Team Chat
========================
*/

public OnPlayerText(playerid, text[])
{
	new strName[MAX_PLAYER_NAME];
 	new strOut[MAX_STRING];
  	new i;
  	i++;

	GetPlayerName(playerid, strName, sizeof(strName));
	if(text[0] == '!')
	{
 		new string[MAX_STRING];
	   	strmid(string, text, 1, strlen(text), MAX_STRING);
		format(strOut, MAX_STRING, "[TC] [%s]: %s", strName, string);

		for(i = 0; i<MAX_PLAYERS; i++)
     	{
	       	if(gTeam[i] == gTeam[playerid])
			SendClientMessage(i, COLOR_LIGHTBLUE, strOut);
		}
  		return 0;
	}
 	return 1;
}



iStats()
{
 new File:fhandle;
 new var[256];
 new var2[256];
 new var3[256];
 new var4[256];
 new var5[256];
 fhandle = fopen("ClanStats.txt",io_append);
 fwrite(fhandle,"------------------------------------------------------------------------\r\n");
 format(var,  sizeof(var),  "Runde %i von %i\r\n",rCount,ROUND);
 format(var2, sizeof(var2), "Rundengewinner: %s\r\n",roundwinner);
 format(var5, sizeof(var5), "Runden:           %s %i   %s %i\r\n",TEAM1,rCount1,TEAM2,rCount2);
 format(var3, sizeof(var3), "Rundenkills:      %s %i   %s %i\r\n",TEAM1,sCount1,TEAM2,sCount2);
 format(var4, sizeof(var4), "Rundendeaths:     %s %i   %s %i\r\n",TEAM1,sCount2,TEAM2,sCount1);
 fwrite(fhandle,var);
 fwrite(fhandle,var2);
 fwrite(fhandle,var5);
 fwrite(fhandle,var3);
 fwrite(fhandle,var4);
 format(var, sizeof(var), "Meiste Kills im Team %s: %s\r\n",TEAM1,bestT1);
 format(var2, sizeof(var2), "Meiste Kills im Team %s: %s\r\n",TEAM2,bestT2);
 format(var3, sizeof(var3), "Meiste Kills der Runde: %s\r\n",bestg);
 format(var4, sizeof(var4), "Meiste Deaths im Team %s: %s\r\n",TEAM1,worstT1);
 fwrite(fhandle,var);
 fwrite(fhandle,var2);
 fwrite(fhandle,var3);
 fwrite(fhandle,var4);
 format(var, sizeof(var), "Meiste Deaths im Team %s: %s\r\n",TEAM2,worstT2);
 format(var2,sizeof(var2),"Meiste Deaths der Runde: %s\r\n",worstg);
 format(var3,sizeof(var3),"Meiste Teamkills im Team %s: %s\r\n",TEAM1,mosttkillT1);
 format(var4,sizeof(var4),"Meiste Teamkills im Team %s: %s\r\n",TEAM2,mosttkillT2);
 fwrite(fhandle,var);
 fwrite(fhandle,var2);
 fwrite(fhandle,var3);
 fwrite(fhandle,var4);
 format(var,sizeof(var),"Meiste Teamkills der Runde: %s\r\n",mosttkillg);
 fwrite(fhandle,var);
 fwrite(fhandle,"------------------------------------------------------------------------\r\n");
 fclose(fhandle);
 return 1;
}


Stats()
{
 new File:fhandle;
 new var[256];
 new var2[256];
 new var3[256];
 new var4[256];
 fhandle = fopen("ClanStats.txt",io_append);
 fwrite(fhandle,"------------------------------------------------------------------------\r\n");
 format(var, sizeof(var), "Runden:           %s %i   %s %i\r\n",TEAM1,rCount1,TEAM2,rCount2);
 format(var2, sizeof(var2), "Meiste Runden:    %s\r\n",winner);
 format(var3, sizeof(var3), "Gesamtkills:      %s %i   %s %i\r\n",TEAM1,sCount1,TEAM2,sCount2);
 format(var4, sizeof(var4), "Meiste Kills:     %s\r\n",killwinner);
 fwrite(fhandle,var);
 fwrite(fhandle,var2);
 fwrite(fhandle,var3);
 format(var, sizeof(var), "Meiste Kills im Team %s: %s\r\n",TEAM1,warbestT1);
 format(var2, sizeof(var2), "Meiste Kills im Team %s: %s\r\n",TEAM2,warbestT2);
 format(var3, sizeof(var3), "Meiste Kills des Clanwars: %s\r\n",warbestg);
 format(var4, sizeof(var4), "Meiste Deaths im Team %s: %s\r\n",TEAM1,warworstT1);
 fwrite(fhandle,var);
 fwrite(fhandle,var2);
 fwrite(fhandle,var3);
 fwrite(fhandle,var4);
 format(var, sizeof(var), "Meiste Deaths im Team %s: %s\r\n",TEAM2,warworstT2);
 format(var2,sizeof(var2),"Meiste Deaths des Clanwars: %s\r\n",warworstg);
 format(var3,sizeof(var3),"Meiste Teamkills im Team %s: %s\r\n",TEAM1,warmtkillT1);
 format(var4,sizeof(var4),"Meiste Teamkills im Team %s: %s\r\n",TEAM2,warmtkillT2);
 fwrite(fhandle,var);
 fwrite(fhandle,var2);
 fwrite(fhandle,var3);
 fwrite(fhandle,var4);
 format(var,sizeof(var),"Meiste Teamkills des Clanwars: %s\r\n",warmtkillg);
 fwrite(fhandle,var);
 fwrite(fhandle,"------------------------------------------------------------------------\r\n");
 fclose(fhandle);
 return 1;
}

/*
Schlussstats()
{
    new File:fhandle;
    new temp[256], temp2[256], temp3[256],temp4[256],temp5[256],temp6[256],temp7[256],temp8[256],temp9[256],temp10[256],temp11[256],temp12[256];
    for(new i=0;i<MAX_PLAYERS;i++)
 	{
    if(IsPlayerConnected(i))
    {
	if(rCount==3)
	{
 	fhandle = fopen("ClanStats.txt",io_append);
	format(temp, sizeof(temp), 		"		========================================================================\r\n");
    format(temp2,sizeof(temp2),		"		=============================ClanWar: %s VS %s==========================\r\n",TEAM1,TEAM2);
	format(temp3, sizeof(temp3), 	"		Sieger des Clanwars: %s\r\n",winner);
	format(temp4, sizeof(temp4), 	"		%s  %d  ||  %d  %s\r\n", TEAM1, rCount1,rCount2,TEAM2);
	format(temp5,sizeof(temp5),		"		%s  %d  ||  %d  %s\r\n",TEAM1,allcount1,allcount2,TEAM2);
	format(temp6, sizeof(temp6), 	"		Meiste Kills des Clanwars : %d\r\n", allendkills);
	format(temp7, sizeof(temp7), 	"		Meiste Deaths des Clanwars : %d\r\n", allenddeaths);
	format(temp8, sizeof(temp8), 	"		Meiste Team-Kills des Clanwars : %d\r\n", allendtk);
	format(temp9, sizeof(temp9), 	"		========================================================================\r\n");
 	format(temp10, sizeof(temp10), 	"		========================================================================\r\n");
 	format(temp11,sizeof(temp11),	"		%s : Gesamtkills: %d Gesamtdeaths: %d Gesamtteamkills: %d\r\n",pname(i),endkills[i],enddeaths[i],endtk[i]);
 	format(temp12, sizeof(temp12), 	"		========================================================================\r\n");
	fwrite(fhandle,temp);
	fwrite(fhandle,temp2);
	fwrite(fhandle,temp3);
	fwrite(fhandle,temp4);
	fwrite(fhandle,temp5);
	fwrite(fhandle,temp6);
	fwrite(fhandle,temp7);
	fwrite(fhandle,temp8);
	fwrite(fhandle,temp9);
	fwrite(fhandle,temp10);
	fwrite(fhandle,temp11);
	fwrite(fhandle,temp12);
	fclose(fhandle);
	}
	}
	}
	return 1;
}
*/
/*
public ClanDetect(playerid)
{
 if(IsPlayerConnected(playerid))
	{
	    SendClientMessage(playerid, COLOR_YELLOW, "Detecting Clan...");
		new tmpnick[MAX_PLAYER_NAME];
		new ctxt[256];
		GetPlayerName(playerid, tmpnick, sizeof(tmpnick));
		for(new n=0; n<strlen(tmpnick); n++)
		{
		    if(TEAM1[0] == tmpnick[n])
		    {
		        if(TEAM1[1] == tmpnick[(n+1)])
		        {
		            if(TEAM1[2] == tmpnick[(n+2)])
		            {
		                format(ctxt, sizeof(ctxt), "Detected Clan: %s", TEAM1);
		                SendClientMessage(playerid, COLOR_YELLOW, ctxt);
		    			return TEAM_1;
					}
 			  	}
			 }
		     else if(TEAM2[0] == tmpnick[n])
		     {
		     	if(TEAM2[1] == tmpnick[(n+1)])
		        {
		            if(TEAM2[2] == tmpnick[(n+2)])
		            {
              			format(ctxt, sizeof(ctxt), "Detected Clan: %s", TEAM2);
		                SendClientMessage(playerid, COLOR_YELLOW, ctxt);
					   	return TEAM_2;
					}
 			  	 }
			  }
			}
      		SendClientMessage(playerid, COLOR_YELLOW, "Clan not detected, Set as REF!");
			return TEAM_REF;
		}
		return 0;
}

		

========================
	    Commands
========================
*/

public OnPlayerCommandText(playerid, cmdtext[])
{

new kickid,idx;
new cmd[256];
cmd = strtok(cmdtext, idx);

if(strcmp(cmdtext,"/start",true)==0)
{
new File:fhandle;
new write[256],write2[256];
if(CWInfo[playerid]==1)
{
SendClientMessage(playerid,COLOR_RED,"Der ClanWar wurde schon gestartet!");
return 1;
}
if(IsPlayerAdmin(playerid))
{
if(Count>=5)
{
for(new i=0;i<MAX_PLAYERS;i++)
{
CWInfo[i]=1;
TogglePlayerControllable(i,1);
}
fhandle = fopen("ClanStats.txt",io_append);
fwrite(fhandle,"========================================================================\r\n");
fwrite(fhandle,"================================STATISTIK===============================\r\n");
fwrite(fhandle,"========================================================================\r\n");
format(write,sizeof(write),"========================Clanwar : %s gegen %s============================\r\n",TEAM1,TEAM2);
format(write2,sizeof(write2),"=======================%d Runden mit je %d Kills======================\r\n",ROUND,ROUNDKILLS);
fwrite(fhandle,write);
fwrite(fhandle,write2);
fclose(fhandle);
rCount=0;
SetTimer("CountDown", 1000, 0);
GameTextForAll("Der Clanwar wurde gestartet. Viel Glueck",1000,5);
print("Clanwar gestartet");

}else
{
SendClientMessage(playerid,COLOR_RED,"Der CD ist nicht verf¸gbar");
}
}else
{
SendClientMessage(playerid,COLOR_RED,"Du musst ein Rcon Admin sein!");
}
return 1;
}






if(strcmp(cmdtext, "/scores", true)==0)
{
new sstring[256], sstring2[256];
new rstring[256], rstring2[256];
format(sstring, sizeof(sstring), "%s: %d Kills", TEAM1, sCount1);
format(sstring2, sizeof(sstring2), "%s: %d Kills", TEAM2, sCount2);
format(rstring, sizeof(rstring), "%s: %d Runden", TEAM1, rCount1);
format(rstring2, sizeof(rstring2), "%s: %d Runden", TEAM2, rCount2);
SendClientMessage(playerid,COLOR_BLUE, sstring);
SendClientMessage(playerid,COLOR_BLUE, sstring2);
SendClientMessage(playerid,COLOR_BLUE, rstring);
SendClientMessage(playerid,COLOR_BLUE, rstring2);
return 1;
}





	
if(strcmp(cmdtext, "/reset", true)==0)
{
new cstr[255];
if(CWInfo[playerid]==0)
{
SendClientMessage(playerid,COLOR_RED,"Der Clanwar wurde doch nicht mal gestartet");
return 1;
}
if(CWInfo[playerid]==1)
{
if(IsPlayerConnected(playerid) && IsPlayerAdmin(playerid))
{
SendClientMessageToAll(COLOR_YELLOW, "Clan War Reset!");
print("Clanwar resetted");
format(cstr,sizeof(cstr),"%s 0  :  0 %s",TEAM1,TEAM2);
TextDrawSetString(Text:Textdraw0,cstr);
TextDrawSetString(Text:Textdraw1,cstr);
for(new i=0;i<MAX_PLAYERS;i++)
{
sCount1 = 0;
sCount2 = 0;
rCount1 = 0;
rCount2 = 0;
rCount=0;
Kills[i]=0;
DeathCount[i]=0;
tkscore[i]=0;
CWInfo[i]=0;
SpawnPlayer(i);
SetPlayerScore(i,0);
SetPlayerHealth(i,100);
bestT1 = "";
bestT2 = "";
bestg = "";
worstT1 = "";
worstT2 = "";
worstg = "";
mosttkillT1 = "";
mosttkillT2 = "";
mosttkillg = "";

}
}else
{
SendClientMessage(playerid,COLOR_RED,"Du musst ein Rcon Admin sein");
}
}
return 1;
}
		



if(strcmp(cmdtext,"/commands",true)==0)
{
SendClientMessage(playerid, COLOR_YELLOW, "/reset(Admins) /start(Admins) /next(Admins) /kick(Admins) /myscore /scores");
return 1;
}




if(strcmp(cmdtext,"/team1pl",true)==0)
{
if(IsPlayerAdmin(playerid))
{
sCount1++;
}else
{
SendClientMessage(playerid,COLOR_RED,"Du musst ein Rcon Admin sein");
}
return 1;
}



if(strcmp(cmdtext,"/team2pl",true)==0)
{
if(IsPlayerAdmin(playerid))
{
sCount2++;
}else
{
SendClientMessage(playerid,COLOR_RED,"Du musst ein Rcon Admin sein");
}
return 1;
}



if(strcmp(cmdtext,"/myscore",true)==0)
{
new string[256],string2[256],string3[256];
new playerscore;
playerscore=GetPlayerScore(playerid);
format(string,sizeof(string),"Kills:%d",playerscore);
format(string2,sizeof(string2),"Deaths:%d",DeathCount[playerid]);
format(string3,sizeof(string3),"Teamkills:%d",tkscore[playerid]);
SendClientMessage(playerid,COLOR_BLUE,string);
SendClientMessage(playerid,COLOR_BLUE,string2);
SendClientMessage(playerid,COLOR_BLUE,string3);
return 1;
}

if(strcmp(cmdtext,"/next",true)==0)
{
if(IsPlayerAdmin(playerid))
{
for(new i;i<MAX_PLAYERS;i++)
{
SpawnPlayer(i);
TogglePlayerControllable(i,0);
sCount1=0;
sCount2=0;
SetPlayerScore(i,0);
SetPlayerHealth(i,100);
DeathCount[i] = 0;
tkscore[i] = 0;
Kills[i] = 0;
bestT1 = "";
bestT2 = "";
bestg = "";
worstT1 = "";
worstT2 = "";
worstg = "";
mosttkillT1 = "";
mosttkillT2 = "";
mosttkillg = "";

}
}else
{
SendClientMessage(playerid,COLOR_RED,"Du bist kein Admin");
}
return 1;
}

if(strcmp(cmd,"/bekicker",true)==0)
{
if(IsPlayerAdmin(playerid))
{
new tmp[256];
new playername[MAX_PLAYER_NAME];
new kickedname[MAX_PLAYER_NAME];
tmp = strtok(cmdtext, idx);
kickid=strval(tmp);

if(!strlen(tmp))
{
SendClientMessage(playerid, COLOR_GREY, "/bekicker [SpielerID]");
return 1;
}

GetPlayerName(playerid,playername,sizeof(playername));
GetPlayerName(kickid,kickedname,sizeof(kickedname));

format(astring,sizeof(astring),"%s wurde von Administrator %s gekickt",kickedname,playername);
SendClientMessageToAll(COLOR_GREY,astring);
Kick(kickid);

}else
{
SendClientMessage(playerid,COLOR_RED,"Du bist kein Admin");
}
return 1;
}


if(strcmp(cmdtext,"/help",true)==0)
{
new helpstring[256];

if(ROUND>1)
{
SendClientMessage(playerid,COLOR_LIGHTBLUE,"In diesem Server l‰uft gerade ein War Mode, das heiﬂt, versuche nicht aus der Map zu gelangen.");
format(helpstring,sizeof(helpstring),"Es werden %d Runden von %d Kills gespielt. Rechts seht ihr zwei Textdraws die den aktuellen",ROUND,ROUNDKILLS);
SendClientMessage(playerid,COLOR_LIGHTBLUE,helpstring);
SendClientMessage(playerid,COLOR_LIGHTBLUE,"Spielstand anzeigen. Mit ! vor deinem Text kannst du eine Nachricht an all deine Teammitglieder");
SendClientMessage(playerid,COLOR_LIGHTBLUE,"senden.Die Commands die du hier im Server benutzen kannst, sind bei /commands aufgelistet");
}else if(ROUND==1)
{
SendClientMessage(playerid,COLOR_LIGHTBLUE,"In diesem Server l‰uft gerade ein War Mode, das heiﬂt, versuche nicht aus der Map zu gelangen.");
format(helpstring,sizeof(helpstring),"Es wird %d Runde von %d Kills gespielt. Rechts seht ihr zwei Textdraws die den aktuellen",ROUND,ROUNDKILLS);
SendClientMessage(playerid,COLOR_LIGHTBLUE,helpstring);
SendClientMessage(playerid,COLOR_LIGHTBLUE,"Spielstand anzeigen. Mit ! vor deinem Text kannst du eine Nachricht an all deine Teammitglieder");
SendClientMessage(playerid,COLOR_LIGHTBLUE,"senden.Die Commands die du hier im Server benutzen kannst, sind bei /commands aufgelistet");
}
return 1;
}




return 0;
}



/*
==================================
iFreeze = TogglePlayerControllable
==================================
*/

public iFreeze()
{
for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
		{
		TogglePlayerControllable(i,0);
		}
	}
}

/*
========================
     String Defines
========================
*/

strtok(const string[],valve)
{
	new index=valve;
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

public NextRund()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		SpawnPlayer(i);
		TogglePlayerControllable(i,1);
	}
	return 1;
}

public spawn()
{
	for(new i;i<MAX_PLAYERS;i++)
	SpawnPlayer(i);
	rCount1 = 0;
	rCount2 = 0;
	rCount = 0;
	format(mstring,sizeof(mstring),"%s %d  :  %d %s",TEAM1,rCount1,rCount2,TEAM2);
	TextDrawSetString(Text:Textdraw1,mstring);
	return 1;
}

public resets()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		format(mstring,sizeof(mstring),"%s 0  :  0 %s",TEAM1,TEAM2);
		TextDrawSetString(Text:Textdraw0,mstring);
	    TogglePlayerControllable(i,0);
	    sCount1=0;
	    sCount2=0;
		SetPlayerHealth(i,100);
	 	bestT1 = "";
	 	bestT2 = "";
 		bestg = "";
 		worstT1 = "";
 		worstT2 = "";
 		worstg = "";
 		mosttkillT1 = "";
 		mosttkillT2 = "";
 		mosttkillg = "";
 		roundwinner = "";
 		new File:fhandle;
 		fhandle = fopen("ClanStats.txt",io_append);
 		new str3[256];
 		new name[32];
 		if(IsPlayerConnected(i))
     	{
      		GetPlayerName(i,name,sizeof(name));
      		format(str3,sizeof(str3),"Name:   %s || Kills:   %i || Deaths:   %i || TeamKills:   %i\r\n",name,Kills[i],DeathCount[i],tkscore[i]);
      		fwrite(fhandle,str3);
   			DeathCount[i] = 0;
			tkscore[i] = 0;
   			Kills[i] = 0;
   			SetPlayerScore(i, 0);
 		}
 		fclose(fhandle);
	}
	return 1;
}

public CountDown()
{
if (Count == 5)
{
GameTextForAll("~r~Der Clanwar beginnt in ~n~5 ~n~Sekunden", 2000, 3);
SetTimer("CountDown", 1000, 0);
Count--;
}
else if (Count == 4)
{
GameTextForAll("~r~Der Clanwar beginnt in ~n~4 ~n~Sekunden", 2000, 3);
SetTimer("CountDown", 1000, 0);
Count--;
}
else if (Count == 3)
{
GameTextForAll("~r~Der Clanwar beginnt in ~n~3 ~n~Sekunden", 2000, 3);
SetTimer("CountDown", 1000, 0);
Count--;
}
else if (Count == 2)
{
GameTextForAll("~r~Der Clanwar beginnt in ~n~2 ~n~Sekunden", 2000, 3);
SetTimer("CountDown", 1000, 0);
Count--;
}
else if (Count == 1)
{
GameTextForAll("~r~Der Clanwar beginnt in ~n~1 ~n~Sekunde", 2000, 3);
SetTimer("CountDown", 1000, 0);
Count--;
}
else if (Count == 0)
{
GameTextForAll("~r~Go ~r~Go ~r~Go", 2500, 3);
Count=5;
}
return 1;
}

public COUNT()
{
if(COUNTDOWN==3)
{
GameTextForAll("~r~Die Runde beginnt in ~n~3 ~n~Sekunden",2000,3);
SetTimer("COUNT",1000,0);
COUNTDOWN--;
}
else if(COUNTDOWN==2)
{
GameTextForAll("~r~Die Runde beginnt in ~n~2 ~n~Sekunden",2000,3);
SetTimer("COUNT",1000,0);
COUNTDOWN--;
}
else if(COUNTDOWN==1)
{
GameTextForAll("~r~Die Runde beginnt in ~n~1 ~n~Sekunde",2000,3);
SetTimer("COUNT",1000,0);
COUNTDOWN--;
}
else if(COUNTDOWN==0)
{
GameTextForAll("~r~Die Runde hat begonnen",2000,3);
COUNTDOWN=3;
}
return 1;
}

public CalcStats()
{
	SendClientMessageToAll(COLOR_GREY,"*** Berechne Statistiken...");
	new i;
	//=======================RUNDENBASIEREND=======================
	//bester Spieler T1
	new high;
	new id;
	new name[32];
	i = 0;
	for(i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(gTeam[i]==TEAM_1)
			{
			    if(Kills[i]>high)
			    {
			        high = Kills[i];
			        id = i;
				}
			}
		}
	}
	GetPlayerName(id,name,sizeof(name));
	format(bestT1,sizeof(bestT1),"%s (%i)",name,high);
	new highT1;
	highT1 = high;
	//bester Spieler T2
	high = 0;
	id = -1;
	name = "";
	i = 0;
	for(i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(gTeam[i]==TEAM_2)
	        {
	            if(Kills[i]>high)
	            {
	                high = Kills[i];
	                id = i;
				}
			}
		}
	}
	GetPlayerName(id,name,sizeof(name));
	format(bestT2,sizeof(bestT2),"%s (%i)",name,high);
	new highT2;
	highT2 = high;
	//bester Spieler gesamt
	new highg;
	if(highT1<highT2)
	{
		bestg = bestT2;
		highg = highT2;
	}
	if(highT1>highT2)
	{
	    bestg = bestT1;
	    highg = highT1;
	}
	//schlechtester Spieler T1
	new down;
	down = 0;
	name = "";
	id = -1;
	i = 0;
	for(i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(gTeam[i]==TEAM_1)
	        {
	            if(DeathCount[i]>down)
	            {
	                down = DeathCount[i];
	                id = i;
				}
			}
		}
	}
	GetPlayerName(id,name,sizeof(name));
	format(worstT1,sizeof(worstT1),"%s (-%i)",name,down);
	new downT1;
	downT1 = down;
	//schlechtester Spieler T2
	down = 0;
	name = "";
	id = -1;
	i = 0;
	for(i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(gTeam[i]==TEAM_2)
	        {
	            if(DeathCount[i]>down)
	            {
	                down = DeathCount[i];
	                id = i;
				}
			}
		}
	}
	GetPlayerName(id,name,sizeof(name));
	format(worstT2,sizeof(worstT2),"%s (-%i)",name,down);
	new downT2;
	downT2 = down;
	//schlechtester Spieler gesamt
	new downg;
	if(downT1<downT2)
	{
	    worstg = worstT2;
	    downg = downT2;
	}
	if(downT1>downT2)
	{
	    worstg = worstT1;
	    downg = downT1;
	}
	//meiste Teamkills T1
	id = -1;
	i = 0;
	name = "";
	new cteamk;
	cteamk = 0;
	for(i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(gTeam[i]==TEAM_1)
	        {
	            if(tkscore[i]>cteamk)
	            {
	                cteamk = tkscore[i];
	                id = i;
				}
			}
		}
	}
	GetPlayerName(id,name,sizeof(name));
	format(mosttkillT1,sizeof(mosttkillT1),"%s (%i)",name,cteamk);
	new mtkT1;
	mtkT1 = cteamk;
	//meiste TeamKills T2
	id = -1;
	i = 0;
	name = "";
	cteamk = 0;
	for(i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(gTeam[i]==TEAM_2)
	        {
	            if(tkscore[i]>cteamk)
	            {
	                cteamk = tkscore[i];
	                id = i;
				}
			}
		}
	}
	GetPlayerName(id,name,sizeof(name));
	format(mosttkillT2,sizeof(mosttkillT2),"%s (%i)",name,cteamk);
	new mtkT2;
	mtkT2 = cteamk;
	//meiste Teamkills gesammt
	new mtkg;
	if(mtkT1<mtkT2)
	{
	    mosttkillg = mosttkillT2;
	    mtkg = mtkT2;
	}
	if(mtkT1>mtkT2)
	{
	    mosttkillg = mosttkillT1;
	    mtkg = mtkT1;
	}
	//===================WARBASIEREND=================
	if(warkillsT1 > warkillsT2)
	{
	 	TEAM1 = killwinner;
	}
	if(warkillsT1 < warkillsT1)
	{
	    TEAM2 = killwinner;
	}
	if(highT1>warbestT1val)
	{
	    warbestT1val = highT1;
	    warbestT1 = bestT1;
	}
	if(highT2>warbestT2val)
	{
	    warbestT2val = highT2;
	    warbestT2 = bestT2;
	}
	if(highg>warbestgval)
	{
	    warbestgval = highg;
	    warbestg = bestg;
	}
	if(downT1>warworstT1val)
	{
	    warworstT1val = downT1;
	    warworstT1 = worstT1;
	}
	if(downT2>warworstT2val)
	{
	    warworstT2val = downT2;
	    warworstT2 = worstT2;
	}
	if(downg>warworstgval)
	{
	    warworstgval = downg;
	    warworstg = worstg;
	}
	if(mtkT1>warmtkillT1val)
	{
	    warmtkillT1val = mtkT1;
	    warmtkillT1 = mosttkillT1;
	}
	if(mtkT2>warmtkillT2val)
	{
	    warmtkillT2val = mtkT2;
	    warmtkillT2 = mosttkillT2;
	}
	if(mtkg>warmtkillgval)
	{
	    warmtkillgval = mtkg;
	    warmtkillg = mosttkillg;
	}
	//SendClientMessageToAll(COLOR_GREY,"*** Debug: Done");
	return 1;
}


