//---------------------------------------------------------
//
// Da Nang Thang SE. A Team vs Team script for SA:MP 0.1.
//          Freighter, ship, blah, wtf, etc.
//
//---------------------------------------------------------

#include <a_samp>
#include <core>
#include <float>

// Global stuff and defines for our gamemode.

static gTeam[MAX_PLAYERS]; // Tracks the team assignment for each player
new gPlayerClass[MAX_PLAYERS];
new gObjectiveReached = 0;

#define TEAM_TRIAD 1
#define TEAM_NANG 2
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define CAPS_TO_WIN 5
#define DEFENCE_WIN 0
#define ATTACK_WIN 1

//new gRoundTime = 1800000; // 20 mins
new gRoundTime = 900000; // 15 mins
//new gRoundTime = 600000; // 10 mins
//new gRoundTime = 300000; // 5 mins
//new gRoundTime = 100000; // 5 mins
new gTriadWin=0;
new gRoundTimer;

forward SetPlayerToTeam(playerid, classid);
forward SetupPlayerForClassSelection(playerid);
forward GameModeExitFunc();
forward DefenceWin();

//---------------------------------------------------------

main()
{
	print("\n----------------------------------");
	print(" Attack the Freighter by Cam (2006)\n");
	print(" Code parts from Rivershell & A51\n");
	print("----------------------------------\n");
}

//---------------------------------------------------------

public OnGameModeInit()
{
	print("GameModeInit()");
	SetGameModeText("Da Nang Boys SE");
	SetTeamCount(2);
	ShowNameTags(1);
	ShowPlayerMarkers(1);
	SetWorldTime(2);

//-----------------------------------TRIAD SPAWNS-------------------------------

	AddPlayerClass(117,-1617.5673,1390.0602,7.1747,333.2159,4,1,23,170,30,300); //
	AddPlayerClass(118,-1627.7346,1416.2467,7.1875,274.6219,4,1,23,170,29,300); //
	AddPlayerClass(120,-1652.5309,1431.6616,7.1754,276.1652,4,1,23,170,25,40); //

//-----------------------------------Nang SPAWNS--------------------------------

	AddPlayerClass(121,-1435.4781,1490.7441,1.8672,56.5062,4,1,23,170,30,300); //
	AddPlayerClass(122,-1420.6646,1483.1548,1.8672,93.7932,4,1,23,170,29,300); //
	AddPlayerClass(123,-1405.0182,1497.0150,1.8672,111.9667,4,1,23,170,25,40); //

//------------------------------Boats/helis and shit----------------------------

	AddStaticVehicle(454,-1427.9684,1470.6309,0.5181,135.1407,-1,-1); //
	AddStaticVehicle(454,-1364.0269,1470.2139,0.3568,165.0191,-1,-1); //
	AddStaticVehicle(484,-1394.0040,1468.3309,0.1742,99.7403,-1,-1); //
	AddStaticVehicle(484,-1404.9385,1507.1971,-0.0963,60.9265,-1,-1); //
	AddStaticVehicle(446,-1603.1550,1391.8168,-0.8820,310.2346,-1,-1); //
	AddStaticVehicle(446,-1698.8333,1411.8612,-0.4988,333.6676,-1,-1); //
	AddStaticVehicle(446,-1710.4403,1430.0688,-0.5722,322.3057,-1,-1); //
	AddStaticVehicle(473,-1623.9312,1438.3147,-0.2109,280.8999,-1,-1); //
	AddStaticVehicle(473,-1609.0120,1405.0123,-0.1395,300.4936,-1,-1); //
	AddStaticVehicle(487,-1651.4410,1302.6608,7.2126,310.4509,-1,-1); //
	AddStaticVehicle(487,-1736.8011,1400.1903,7.3641,293.3916,-1,-1); //
//Added 3-1-06
	AddStaticVehicle(473,-1579.3042,1318.4962,-0.5421,249.5810,56,15); //
	AddStaticVehicle(473,-1508.2705,1299.4720,-0.5357,266.5089,56,15); //
	AddStaticVehicle(473,-1461.9438,1468.2045,-0.7344,106.3914,56,15); //
	AddStaticVehicle(454,-1469.2281,1520.6353,0.3672,130.2039,26,26); //
 	SetTimer("DefenceWin", gRoundTime, 0);
 	return 1;
 }

//---------------------------------------------------------

public DefenceWin() {
	EndTheRound(DEFENCE_WIN);
}

//------------------------------------------------------------------------------

public OnPlayerConnect(playerid)
{
	SetPlayerColor(playerid,0x888888FF);
	GameTextForPlayer(playerid,"Da Nang Boys[SE]",2500,5);
	return 1;
}

//------------------------------------------------------------------------------

public SetupPlayerForClassSelection(playerid)
{
	SetPlayerInterior(playerid,14);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerFacingAngle(playerid, 90.0);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1003.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
}

//------------------------------------------------------------------------------

public SetPlayerToTeam(playerid, classid) {
	if(classid == 0 || classid == 1 || classid == 2) {
		gTeam[playerid] = TEAM_TRIAD;
		} else if(classid == 3 || classid == 4 || classid == 5) {
	    gTeam[playerid] = TEAM_NANG;
	}
}

//------------------------------------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerToTeam(playerid, classid);
	SetupPlayerForClassSelection(playerid);
	gPlayerClass[playerid] = classid;
	switch (classid) {
	    case 0:
	        {
				GameTextForPlayer(playerid, "~g~Attack", 500, 3);
			}
		case 1:
		    {
				GameTextForPlayer(playerid, "~g~Attack", 500, 3);
			}
		case 2:
	        {
				GameTextForPlayer(playerid, "~g~Attack", 500, 3);
			}
		case 3:
	        {
				GameTextForPlayer(playerid, "~b~Defend", 500, 3);
			}
		case 4:
	        {
				GameTextForPlayer(playerid, "~b~Defend", 500, 3);
			}
		case 5:
	        {
				GameTextForPlayer(playerid, "~b~Defend", 500, 3);
			}
	}
	return 1;
}

//------------------------------------------------------------------------------


public OnPlayerEnterCheckpoint(playerid)
{
	if(gObjectiveReached) return;
	if(gTeam[playerid] == TEAM_TRIAD)
	{
	    gTriadWin++;
	    SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
	if(gTriadWin==CAPS_TO_WIN) {
	        GameTextForAll("The ~g~Triads ~w~have broken in sucessfully!",3000,5);
			gObjectiveReached = 1; PlayerPlaySound(playerid, 1185, 0.0, 0.0, 0.0);
 			SetTimer("ExitTheGameMode", 600, 0); // Set up a timer to exit this mode.
            EndTheRound(ATTACK_WIN);
		} else {
	  GameTextForAll("A ~g~Triad ~w~ broke in!",3000,5);
		DisablePlayerCheckpoint(playerid);
		}
	    return;
	}
	else if(gTeam[playerid] == TEAM_NANG)
	{
			GameTextForAll("You failed to defend the ship.",3000,5);
	        gObjectiveReached = 1; PlayerPlaySound(playerid, 1185, 0.0, 0.0, 0.0);
			SetTimer("ExitTheGameMode", 6000, 0); // Set up a timer to exit this mode.
		} else {
            GameTextForAll("A~g~ Triad~w~ broke in! kill!",3000,5);
	}
	    return;
	}

//------------------------------------------------------------------------------

public OnPlayerSpawn(playerid)
{

	SetPlayerInterior(playerid,0);
	if(gTeam[playerid] == TEAM_TRIAD) {
		SetPlayerCheckpoint(playerid,-1436.3929,1490.9489,1.8672,5.0);
		SetPlayerColor(playerid,0x33AA33AA); // Triad green
		GameTextForPlayer(playerid,"~w~Take over the ~r~Freighter.",3000,5);
		SetPlayerWorldBounds(playerid,-1200.4141,-1758.9939,1635.8176,1200.2998);
	}
	else if(gTeam[playerid] == TEAM_NANG) {
		DisablePlayerCheckpoint(playerid);
		GameTextForPlayer(playerid,"~w~Defend the ship.",3000,5);
		SetPlayerWorldBounds(playerid,-1200.4141,-1758.9939,1635.8176,1200.2998);
		SetPlayerColor(playerid,0x3333AAAA); // Nang blue
	}
	return 1;
}

//------------------------------------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid == INVALID_PLAYER_ID) {
        SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
	} else {
        if(gTeam[killerid] != gTeam[playerid]) {
	    	// Valid kill
	    	SendDeathMessage(killerid,playerid,reason);
			SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
     	}
		else {
		    // Team kill
		    SendDeathMessage(killerid,playerid,reason);
		}
	}
 	return 1;
}

//------------------------------------------------------------------------------

EndTheRound(winner) {
	switch (winner) {
	    case ATTACK_WIN:
	    {
	        GameTextForAll("The ~g~Triads ~w~ have broken in.", 2000, 5);
	        KillTimer(gRoundTimer);
	    }
	    case DEFENCE_WIN:
	    {
	        GameTextForAll("The ~r~ship ~w~ was defended successfully.", 2000, 5);
	    }
	}
	SetTimer("GameModeExitFunc", 5000, 0);
}

//------------------------------------------------------------------------------

public GameModeExitFunc()
{
    PlaySoundForAll(1186, 0.0, 0.0, 0.0);
	GameModeExit();
}

//------------------------------------------------------------------------------

PlaySoundForAll(soundid, Float:x, Float:y, Float:z)
{
	for (new i=0; i<MAX_PLAYERS; i++)
	{
	    if (IsPlayerConnected(i))
	    {
		    PlayerPlaySound(i, soundid, x, y, z);
	    }
	}
}
