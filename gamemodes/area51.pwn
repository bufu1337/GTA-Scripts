//---------------------------------------------------------
//
// AREA51 Break-in. Break into the depths of Area 51.
//
//---------------------------------------------------------

#include <a_samp>

#define TEAM_ATTACK 1
#define TEAM_DEFENCE 2

#define CHECKPOINT_NONE 0
#define CHECKPOINT_PLANE 1
#define CHECKPOINT_AREA51 2

#define DEFENCE_WIN 0
#define ATTACK_WIN 1

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA

forward DefenceWin();
forward GameModeExitFunc();

new gTeam[MAX_PLAYERS];
new gPlayerClass[MAX_PLAYERS];
new gPlayerCheckpointStatus[MAX_PLAYERS];
new gRoundTimer;

// If the army defend the lab for this amount of time, they win.
//new gRoundTime = 1200000;					// Round time - 20 mins
//new gRoundTime = 900000;					// Round time - 15 mins
new gRoundTime = 600000;					// Round time - 10 mins
//new gRoundTime = 300000;					// Round time - 5 mins
//new gRoundTime = 120000;					// Round time - 2 mins
//new gRoundTime = 60000;					// Round time - 1 min

//---------------------------------------------------------

main()
{
	print("\n----------------------------------");
	print("  Area 51 break-in\n   by Mike (2006)");
	print("----------------------------------\n");
}

//---------------------------------------------------------

public OnGameModeInit()
{

	SetGameModeText("Area 51 Break-in");
	ShowNameTags(1);
	ShowPlayerMarkers(0);
	SetWorldTime(0);

	// Attack team
	AddPlayerClass(111,315.4792,984.1290,1959.1129,353.5, 3, 0, 23, 1000, 25, 100); // Mafia dude, andromeda

	// Defence team
	AddPlayerClass(287,245.1233,1859.1162,14.0840,358.717, 4, 0, 32, 1000, 31, 5000); // Army
	AddPlayerClass(70,271.6828,1873.8666,8.7578,229.4508, 4, 0, 24, 1000, 32, 1000); // Lab

	/// Parachutes in plane
	AddStaticPickup(371, 15, 319.3416, 1020.7169,1950.6696);
	AddStaticPickup(371, 15, 312.6138, 1020.7346,1950.6655);
	
	//AddStaticPickup(370, 15, 268.5821, 1883.8224, -30.0938); // jetpack

	gRoundTimer = SetTimer("DefenceWin", gRoundTime, 0);
	
	return 1;
}

//---------------------------------------------------------

public DefenceWin() {
	EndTheRound(DEFENCE_WIN);
}

//---------------------------------------------------------

public OnPlayerConnect(playerid)
{
	GameTextForPlayer(playerid,"~w~SA:MP Area51 Break-in!",4000,3);
	SetPlayerColor(playerid,COLOR_GREY);
	return 1;
}

//---------------------------------------------------------

SetupPlayerForClassSelection(playerid)
{
	SetPlayerInterior(playerid,9);
	SetPlayerFacingAngle(playerid,0.0);
	SetPlayerPos(playerid,315.7802,972.0253,1961.8705);
	SetPlayerCameraPos(playerid,315.7802,975.0253,1961.8705);
	SetPlayerCameraLookAt(playerid,315.7802,972.0253,1961.8705);
	return;
}

//---------------------------------------------------------

SetPlayerTeamFromClass(playerid, classid) {
	if(classid == 0) {
		gTeam[playerid] = TEAM_ATTACK;
	} else if(classid == 1 || classid == 2) {
	    gTeam[playerid] = TEAM_DEFENCE;
	}
}

//---------------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerTeamFromClass(playerid, classid);
	SetupPlayerForClassSelection(playerid);
	
	gPlayerClass[playerid] = classid;
	switch (classid) {
		case 0:
		    {
				GameTextForPlayer(playerid, "~r~Attack", 1000, 3);
			}
	    case 1, 2:
	        {
				GameTextForPlayer(playerid, "~g~Defence", 1000, 3);
			}
	}
	return 1;
}

//---------------------------------------------------------

public OnPlayerSpawn(playerid)
{
	SetPlayerToTeamColour(playerid);
	SetPlayerWorldBounds(playerid, 388.6190, -7.9993, 2147.0618, 1655.8849);
	switch (gPlayerClass[playerid]) {
	    case 0:
	        {
			 	gPlayerCheckpointStatus[playerid] = CHECKPOINT_PLANE;
			 	SetPlayerCheckpoint(playerid,315.7353,1035.6589,1945.1191,5.0);
				SetPlayerInterior(playerid,9);
				GameTextForPlayer(playerid, "Grab a parachute~n~Then exit the plane via the ~r~ramp", 2000, 5);
			}
	    case 1, 2:
	        {
			 	gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
				GameTextForPlayer(playerid, "Defend Area 51", 2000, 5);
				SetPlayerInterior(playerid,0);
			}
	}
	return 1;
}

//---------------------------------------------------------

SetPlayerToTeamColour(playerid) {
	if(gTeam[playerid] == TEAM_ATTACK) {
		SetPlayerColor(playerid,COLOR_RED); // Red
	} else if(gTeam[playerid] == TEAM_DEFENCE) {
	    SetPlayerColor(playerid,COLOR_GREEN); // Green
	}
}

//---------------------------------------------------------

public OnPlayerEnterCheckpoint(playerid) {
	switch (gPlayerCheckpointStatus[playerid]) {
		case CHECKPOINT_PLANE:
		    {
	            GameTextForPlayer(playerid, "Now parachute to ~r~Area 51", 2000, 5);
	            SetPlayerInterior(playerid,0);
	            SetPlayerPos(playerid, 239.5148, 1813.7039, 500.6836);
	            SetPlayerCheckpoint(playerid,268.5821,1883.8224,-30.0938, 5.0);
	            gPlayerCheckpointStatus[playerid] = CHECKPOINT_AREA51;
			}
		case CHECKPOINT_AREA51:
		    {
		        DisablePlayerCheckpoint(playerid);
		        gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
		        EndTheRound(ATTACK_WIN);
		    }
  		default:
	        {
				DisablePlayerCheckpoint(playerid);
	        }
	}
	return 1;
}

//---------------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
	if (killerid != INVALID_PLAYER_ID) {
		
		if (gTeam[playerid] == gTeam[killerid]) {
			SetPlayerScore(killerid, GetPlayerScore(killerid) - 1);
		}
		else {
			SetPlayerScore(killerid, GetPlayerScore(killerid) + 1);
		}
	}
	SendDeathMessage(killerid, playerid, reason);

	DisablePlayerCheckpoint(playerid);
	gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
	
	SetPlayerColor(playerid,COLOR_GREY);
 	return 1;
}

//---------------------------------------------------------

EndTheRound(winner) {
	switch (winner) {
	    case ATTACK_WIN:
	    {
	        GameTextForAll("The attackers broke into Area 51.", 2000, 5);
	        KillTimer(gRoundTimer);
	    }
	    case DEFENCE_WIN:
	    {
	        GameTextForAll("Area 51 was successfully defended.", 2000, 5);
	    }
	}
	SetTimer("GameModeExitFunc", 5000, 0);
}

//---------------------------------------------------------

public GameModeExitFunc()
{
	GameModeExit();
}
