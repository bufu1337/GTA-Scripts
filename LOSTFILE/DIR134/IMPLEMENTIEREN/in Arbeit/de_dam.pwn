/*---------------------------------------------------------

de_dam - Counter-Strike in San Andreas

-----------------------------------------------------------

° sry for crappy style of programming, this is my first gamemode!
° BIG THX go out to:
		- DracoBlue, who spent two hours on helping little Eightball with his weird problem
		- mabako for hosting my server and important scripting help
		- switch who solved the server-crash problem
		- driver2, MaXx, Y_Less for looking into this source and helping me again and again
		- the whole SA-MP team for the best GTA mod ever!
° P.S: I hope you like this!
° PP.S: TIMERS SUCK! ;-) */

#include <a_samp>
#include <core>
#include <float>

#define CT_WIN 1
#define T_WIN 2

#define COLOR_GREY 0xAFAFAFAA       // Grey --> Spectators
#define COLOR_RED 0xAA3333AA 		// Red --> Terrors
#define COLOR_BLUE 0x3333AAAA 		// Blue --> CTs
#define COLOR_YELLOW 0xFFFF00AA 	// Yellow --> Planter

#define PLANT_DEF_TIME 10   // Seconds to plant/defuse bomb
#define C4TIMER 140         // Seconds for bomb to blow
#define ROUNDS 5            // Number of rounds the gamemode is played
#define ROUNDTIME 5    		// Roundtime in Minutes!

#define BOMBPLACE -651.2541,2153.4880,60.3828 // x, y and z coordinates for Bombplace Checkpoint

new gPlayerClass[MAX_PLAYERS];
new player_spawned[MAX_PLAYERS]; // Teamchat

new timer, timer2, timer3, timer4, timer5;
new bombtime = PLANT_DEF_TIME;
new secs_to_blow = C4TIMER;
new maxrounds = ROUNDS;

new create_t_cp = 1;
new defuser = -1, planter = -1;
new ctWins = 0, tWins = 0;
new roundtimer = 1;
new playerCount = 0;

//---------------------------------------------------------
main()
{
	print("\n---------------------------------------");
	print("  de_dam - Counter-Strike in San Andreas");
	print("  by Eightball and mabako");
	print("---------------------------------------\n");
}
//---------------------------------------------------------

public OnGameModeInit()
{
	SetGameModeText("de_dam");
	ShowNameTags(1);
	ShowPlayerMarkers(0);
	SetWorldTime(15);
	timer5 = SetTimer("GameModeExitFunc", 1800000, 0);      // Change gamemode after 30 Minutes without any Players

	// Counter-Terrorists
	AddPlayerClass(285,-909.2404,1988.0868,60.9141,307.8163,4,0,24,42,29,360); // CT-Spawn

	// Terrorists
	AddPlayerClass(108,-432.8786,2041.2721,61.2029,100.9345,4,0,22,102,30,360); // Terror-Spawn
	return 1;
}

//---------------------------------------------------------
public SetupPlayerForClassSelection(playerid)
{
    SetPlayerColor(playerid,COLOR_GREY);
	SetPlayerPos(playerid,-732.2563,2285.9695,125.7310);
    SetPlayerCameraPos(playerid,-733.5353,2293.9878,131.5632);
	SetPlayerCameraLookAt(playerid,-732.2563,2285.9695,125.7310);
	SetPlayerFacingAngle(playerid,0.0);
}
//---------------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	SetupPlayerForClassSelection(playerid);
	gPlayerClass[playerid] = classid;
	if(classid == 0) {
		GameTextForPlayer(playerid,"~b~Counter-Terrorists",1000,3);
	} else if(classid == 1) {
	    GameTextForPlayer(playerid,"~r~Terrorists",1000,3);
	}

	return 1;
}

//---------------------------------------------------------

public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid, COLOR_YELLOW, "de_dam - Counter-Strike in San Andreas - by Eightball");
	SendClientMessage(playerid, COLOR_YELLOW, "Type /help for detailed Instructions");
	SetPlayerColor(playerid,COLOR_GREY);
	player_spawned[playerid] = 0; // Teamchat
	playerCount++;
	KillTimer(timer5);
	if (playerCount > 1) {
		new string[128];
		format(string, sizeof(string), "Counter-Terrorists won %d round(s). Terrorists won %d round(s). %d rounds left.", ctWins, tWins, maxrounds);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		}
	return 1;
}
//---------------------------------------------------------
public OnPlayerDisconnect(playerid)
{
	playerCount--;
	if(playerCount == 0) {
		KillTimer(timer);
		KillTimer(timer2);
	    KillTimer(timer3);
	    KillTimer(timer4);
	    bombtime = PLANT_DEF_TIME;
		secs_to_blow = C4TIMER;
		maxrounds = ROUNDS;
		create_t_cp = 1;
	    ctWins = 0;
	    tWins = 0;
	    timer5 = SetTimer("GameModeExitFunc", 1800000, 0);
	    }
	UpdateCheckpoint(playerid);
	return 1;
}
//---------------------------------------------------------
public OnPlayerSpawn(playerid)
{
	if(roundtimer == 1) {
		timer3 = SetTimer("DamDefended",(ROUNDTIME * 60000),0);
		roundtimer = 0;
		}
	DisablePlayerCheckpoint(playerid);
	player_spawned[playerid] = 1; // Teamchat
	SetPlayerWorldBounds(playerid,-373.9443,-1096.5013,2310.0920,1730.0231);
	GivePlayerMoney(playerid, 800);
	SetPlayerHealth(playerid, 100);
	switch (gPlayerClass[playerid]) {
	    case 0:
	        {
				GameTextForPlayer(playerid, "~g~GO GO GO~n~~b~Defend the Dam!", 4000, 3);
				SetPlayerColor(playerid,COLOR_BLUE);
				if(create_t_cp == 0) SetPlayerCheckpoint(playerid,BOMBPLACE,2.0);
			}
	    case 1:
	        {
				GameTextForPlayer(playerid, "~g~GO GO GO~n~~r~Blow up the Dam!", 4000, 3);
				SetPlayerColor(playerid,COLOR_RED);
				if(create_t_cp == 1) SetPlayerCheckpoint(playerid,BOMBPLACE,2.0);
			}
   }
	return 1;
}

//---------------------------------------------------------
public OnPlayerDeath(playerid, killerid, reason)
{
	SendDeathMessage(killerid, playerid, reason);
	player_spawned[playerid] = 0; // Teamchat
	UpdateCheckpoint(playerid);
	
	if(gPlayerClass[playerid] == gPlayerClass[killerid]) {
		new Float:health;
		GetPlayerHealth(killerid, health);
	    SetPlayerHealth(killerid, floatsub(health,50)); // Teamkill Punishment
	    GameTextForPlayer(killerid, "~r~Don't kill your Teammates!", 4000, 3);
	    }
	else {
		SetPlayerScore(killerid, GetPlayerScore(killerid) + 1);
		GivePlayerMoney(killerid, 300);
	}
 	return 1;
	}
	
//---------------------------------------------------------
public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp(cmdtext, "/help", true)==0)
	{
	    SendClientMessage(playerid, COLOR_YELLOW, "The Terrorists have to plant a bomb on the dam and defend it until it blows up.");
		SendClientMessage(playerid, COLOR_YELLOW, "The Counter-Terrorists have to defend the dam and defuse the bomb if it got planted.");
		SendClientMessage(playerid, COLOR_YELLOW, "For Team-Chat just type \"![text]\" and only your teammates will receive the message.");
		return 1;
	}
	
	if (strcmp(cmdtext, "/score", true)==0)
	{
	    new string[128];
		format(string, sizeof(string), "Counter-Terrorists won %d rounds. Terrorists won %d rounds.", ctWins, tWins);
		SendClientMessageToAll(COLOR_YELLOW, string);
		return 1;
	}
	return 0;
}

//---------------------------------------------------------
public OnPlayerText(playerid, text[])
{
	if(text[0] == '!' && player_spawned[playerid] == 1) {
    	new teamChat[256];
    	new playername[MAX_PLAYER_NAME];
    	new string[256];
    	strmid(teamChat,text,1,strlen(text));
    	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
    	format(string, sizeof(string),"[TEAM] %s: %s", playername, teamChat);
    	for(new i = 0; i < MAX_PLAYERS; i++) {
    	    if (gPlayerClass[i] == gPlayerClass[playerid] && player_spawned[i]) SendClientMessage(i, COLOR_YELLOW, string);
		}
	return 0;
	}
	return 1;
}

//---------------------------------------------------------
public OnPlayerEnterCheckpoint(playerid)
{
	new playernick[MAX_PLAYER_NAME];
	new string[128];
	GetPlayerName(playerid, playernick, sizeof(playernick));
	PlaySoundForAll(1054);
	for(new i=0; i<MAX_PLAYERS; i++) if(i != playerid) DisablePlayerCheckpoint(i);
	switch (gPlayerClass[playerid]) {
	    	case 0:
	        {
	            defuser = playerid;
				SetPlayerColor(playerid,COLOR_YELLOW);
				format(string, sizeof(string), "*** %s is defusing the bomb!", playernick);
				SendClientMessageToAll(COLOR_YELLOW, string);
				timer4 = SetTimer("DefuseTheBomb",1000,1);
			}
	    	case 1:
	        {
				planter = playerid;
				SetPlayerColor(playerid,COLOR_YELLOW);
				format(string, sizeof(string), "*** %s is planting the bomb!", playernick);
				SendClientMessageToAll(COLOR_YELLOW, string);
				timer = SetTimer("PlantTheBomb",1000,1);
			}
		}
	return 1;
}

//---------------------------------------------------------
public OnPlayerLeaveCheckpoint(playerid)
{
	UpdateCheckpoint(playerid);
	return 1;
}

//---------------------------------------------------------
public PlantTheBomb() {
	bombtime--;
	if (bombtime == 0) {
		timer2 = SetTimer("TerrorsWin",1000,1);
		create_t_cp = 0; // Create Checkpoint at Spawn only for CTs
		SetPlayerColor(planter,COLOR_RED);
		PlaySoundForAll(1057);
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if (IsPlayerConnected(i))
			{
				DisablePlayerCheckpoint(i);
				switch (gPlayerClass[i]) {
			    	case 0:
			        {
						GameTextForPlayer(i, "~r~The bomb has been planted!", 5000, 3);
			 			SetPlayerCheckpoint(i,BOMBPLACE,2.0);
					}
			    	case 1:
			        {
						GameTextForPlayer(i, "~w~The bomb has been planted!", 5000, 3);
					}
				}

			}
		}

		planter = -1;
		KillTimer(timer);
		SetPlayerScore(planter, GetPlayerScore(planter) + 3);
		bombtime = PLANT_DEF_TIME;
		}
	else {
		create_t_cp = 2; // Create Checkpoint at Spawn for no team
		new output[128];
		format(output, sizeof(output), "~w~Planting: %d", bombtime);
		GameTextForPlayer(planter,output,3000,4);
    	}
	return;
}

//---------------------------------------------------------
public DefuseTheBomb() {
	bombtime--;
	if (bombtime == 0) {
		SetPlayerColor(defuser,COLOR_BLUE);
 		create_t_cp = 2; // Create Checkpoint at Spawn for no team
		defuser = -1;
		SetPlayerScore(defuser, GetPlayerScore(defuser) + 3);
		EndTheRound(CT_WIN);
		}
	else {
		new output[128];
		format(output, sizeof(output), "~w~Defusing: %d", bombtime);
		GameTextForPlayer(defuser,output,3000,4);
    	}
	return;
}

//---------------------------------------------------------
public TerrorsWin() {
	secs_to_blow--;
	new output[128];
	switch (secs_to_blow) {
	    case 0: EndTheRound(T_WIN);
	    case 1: { format(output, sizeof(output), "~r~Detonation in: %d seconds!", secs_to_blow); PlaySoundForAll(1057); }
	    case 2: { format(output, sizeof(output), "~r~Detonation in: %d seconds!", secs_to_blow); PlaySoundForAll(1057); }
	    case 3: { format(output, sizeof(output), "~r~Detonation in: %d seconds!", secs_to_blow); PlaySoundForAll(1057); }
	    case 4: { format(output, sizeof(output), "~r~Detonation in: %d seconds!", secs_to_blow); PlaySoundForAll(1057); }
	    case 5: { format(output, sizeof(output), "~r~Detonation in: %d seconds!", secs_to_blow); PlaySoundForAll(1057); }
	    case 10: format(output, sizeof(output), "~r~The Dam will blow up in %d seconds!", secs_to_blow);
	    case 20: format(output, sizeof(output), "~w~The Dam will blow up in %d seconds!", secs_to_blow);
	    case 30: format(output, sizeof(output), "~w~The Dam will blow up in %d seconds!", secs_to_blow);
	    case 60: format(output, sizeof(output), "~w~The Dam will blow up in %d seconds!", secs_to_blow);
	    case 120: format(output, sizeof(output), "~w~The Dam will blow up in %d seconds!", secs_to_blow);
	    }
	if(strlen(output) > 0) GameTextForAll(output,2000,3);
	return;
}

//---------------------------------------------------------
public DamDefended() {
    SendClientMessageToAll(COLOR_YELLOW, "*** Counter-Terrorists successfully defended the dam!");
    EndTheRound(CT_WIN);
    return;
    }

//---------------------------------------------------------
public EndTheRound(winner) {
	switch (winner) {
	    case CT_WIN:
	    {
	        GameTextForAll("~b~Counter-Terrorists win!", 5000, 3);
	        ctWins++;
	        PlaySoundForAll(1183);
       		for(new i=0; i<MAX_PLAYERS; i++) { if (gPlayerClass[i] == 0) GivePlayerMoney(i, 2000); }
	    }
	    case T_WIN:
	    {
	        GameTextForAll("~r~Terrorists win!", 5000, 3);
	        tWins++;
	        PlaySoundForAll(1159);
       		for(new i=0; i<MAX_PLAYERS; i++) { if (gPlayerClass[i] == 1) GivePlayerMoney(i, 2000); }
	    }
	}
	for(new i=0; i<MAX_PLAYERS; i++) DisablePlayerCheckpoint(i);

 	if (maxrounds == 1)	{
		SetTimer("GameModeExitFunc",18000,0);
		new string[128];
		format(string, sizeof(string), "~b~Counter-Terrorists ~w~won %d rounds.~n~~r~Terrorists ~w~won %d rounds.", ctWins, tWins);
		GameTextForAll(string, 5000, 3);
		}
	else {
		maxrounds--;
		SetTimer("RoundRestart", 7050, 0);
		new string[128];
		format(string, sizeof(string), "Counter-Terrorists won %d round(s). Terrorists won %d round(s). %d rounds left.", ctWins, tWins, maxrounds);
		SendClientMessageToAll(COLOR_YELLOW, string);
	}
	KillTimer(timer);
	KillTimer(timer2);
	KillTimer(timer3);
	KillTimer(timer4);
}

//---------------------------------------------------------
public RoundRestart()
{
    PlaySoundForAll(1186);
	create_t_cp = 1;
	bombtime = PLANT_DEF_TIME;
	secs_to_blow = C4TIMER;
	roundtimer = 1;
	for(new i=0; i<MAX_PLAYERS; i++) { SetPlayerInterior(i,0); SpawnPlayer(i); }
}

//---------------------------------------------------------
public PlaySoundForAll(soundid)
{
    for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			new Float:x;
			new Float:y;
			new Float:z;
			GetPlayerPos(i, x, y, z);
			PlayerPlaySound(i, soundid, x, y, z);
		}
	}
}

//---------------------------------------------------------
public UpdateCheckpoint(playerid)
{
	if(playerid == planter) {
		KillTimer(timer);
  		bombtime = PLANT_DEF_TIME;
		SetPlayerColor(planter,COLOR_RED);
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if (IsPlayerConnected(i))
			{
				if(gPlayerClass[i] == 1)
		        {
					SetPlayerCheckpoint(i,BOMBPLACE,2.0); // Set Checkpoint for all Terrors
				}

			}
		planter = -1;
		create_t_cp = 1;
		}

	}
	else if (playerid == defuser) {
		KillTimer(timer4);
  		bombtime = PLANT_DEF_TIME;
		SetPlayerColor(defuser,COLOR_BLUE);
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if (IsPlayerConnected(i))
			{
				if(gPlayerClass[i] == 0)
		        {
					SetPlayerCheckpoint(i,BOMBPLACE,2.0);// Set Checkpoint for all CTs
				}

			}
		}
		defuser = -1;
		create_t_cp = 0;
	}
}

//---------------------------------------------------------
public GameModeExitFunc()
{
	PlaySoundForAll(1186);
	GameModeExit();
}
