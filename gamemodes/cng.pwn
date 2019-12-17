//---------------------------------------------------------
//
// Cop'n'Gangs v2 by kyeman 2006
//
//---------------------------------------------------------

#include <a_samp>
#include <core>
#include <float>

// Global stuff and defines for our gamemode.

static gTeam[MAX_PLAYERS]; // Tracks the team assignment for each player

#define OBJECTIVE_VEHICLE_GREEN 2
#define OBJECTIVE_VEHICLE_BLUE 1
#define TEAM_GREEN 1
#define TEAM_BLUE 2
#define OBJECTIVE_COLOR 0xAA0000FF
#define TEAM_GREEN_COLOR 0x33AA33AA
#define TEAM_BLUE_COLOR 0x3333AAAA

new gObjectiveGreenPlayer=(-1);
new gObjectiveBluePlayer=(-1);
new gObjectiveReached=0;

forward SetPlayerToTeamColor(playerid);
forward SetupPlayerForClassSelection(playerid);
forward SetPlayerTeamFromClass(playerid,classid);
forward ExitTheGameMode();

//---------------------------------------------------------

main()
{
	print("\n----------------------------------");
	print("  Cops'n'Gangs v2 by kyeman 2006\n");
	print("----------------------------------\n");
}

//---------------------------------------------------------

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new vehicleid;

	if(newstate == PLAYER_STATE_DRIVER)
	{
		vehicleid = GetPlayerVehicleID(playerid);
		
		if(gTeam[playerid] == TEAM_GREEN && vehicleid == OBJECTIVE_VEHICLE_GREEN)
		{ // It's the objective vehicle
		    SetPlayerColor(playerid,OBJECTIVE_COLOR);
		    GameTextForPlayer(playerid,"~w~Take the ~r~van ~w~back to the spawn!",3000,5);
		    gObjectiveGreenPlayer = playerid;
		}
		
		if(gTeam[playerid] == TEAM_BLUE && vehicleid == OBJECTIVE_VEHICLE_BLUE)
		{ // It's the objective vehicle
		    SetPlayerColor(playerid,OBJECTIVE_COLOR);
		    GameTextForPlayer(playerid,"~w~Take the ~r~van ~w~back to the spawn!",3000,5);
		    gObjectiveBluePlayer = playerid;
		}
	}
	else if(newstate == PLAYER_STATE_ONFOOT)
	{
		if(playerid == gObjectiveGreenPlayer) {
		    gObjectiveGreenPlayer = (-1);
		    SetPlayerToTeamColor(playerid);
		}
		
		if(playerid == gObjectiveBluePlayer) {
		    gObjectiveBluePlayer = (-1);
		    SetPlayerToTeamColor(playerid);
		}
	}

    return 1;
}

//---------------------------------------------------------

public OnGameModeInit()
{
	SetGameModeText("CopsNGangs");
	
	ShowPlayerMarkers(0);
	ShowNameTags(1);
	SetWorldTime(19);

	// GANG CLASSES
	AddPlayerClass(105,2500.2688,-1685.4584,13.4607,44.8214,9,0,25,25,32,200);
	AddPlayerClass(106,2512.8611,-1673.2799,13.5104,87.7485,42,400,30,100,32,200);
	AddPlayerClass(107,2508.1372,-1656.6781,13.5938,129.4222,5,0,30,100,29,200);

 	// POLICE CLASSES
	AddPlayerClass(280,1559.3831,-1609.0282,13.3828,177.0690,42,400,31,100,29,200);
	AddPlayerClass(281,1578.1378,-1608.7106,13.3828,125.6820,3,0,31,100,29,200);
	AddPlayerClass(284,1569.6345,-1635.0394,13.5540,42.6713,3,0,25,25,32,200);

	// OBJECTIVE VEHICLES
    AddStaticVehicle(609,2473.5884,-1694.7870,13.3833,359.1481,114,1); // gr objective van
    AddStaticVehicle(609,1549.3060,-1610.8313,13.5591,89.2093,0,1); // bl objective van
    
    // GANGS VEHICLES
   	AddStaticVehicle(567,2509.9382,-1667.7566,13.3356,5.5935,114,1);
	AddStaticVehicle(567,2506.9841,-1677.4115,13.3292,325.3867,114,1);
	AddStaticVehicle(567,2501.5195,-1655.5464,13.3189,69.0657,114,1);
	AddStaticVehicle(567,2484.7808,-1653.7554,13.2652,86.9443,114,1);
	AddStaticVehicle(567,2468.3486,-1653.4425,13.2643,91.4342,114,1);

	// COPS VEHICLES
	AddStaticVehicle(596,1603.2410,-1629.1624,13.2215,88.5687,0,1);
	AddStaticVehicle(596,1572.9598,-1607.0868,13.1032,177.8650,0,1);
	AddStaticVehicle(596,1582.5460,-1606.9911,13.1032,177.5342,0,1);
	AddStaticVehicle(596,1590.7076,-1607.5624,13.1032,181.6846,0,1);
	AddStaticVehicle(596,1603.3566,-1618.9797,13.2220,90.0969,0,1);

   return 1;
}

//---------------------------------------------------------

public OnPlayerConnect(playerid)
{
	SetPlayerColor(playerid,0x888888FF);
	GameTextForPlayer(playerid,"~r~SA-MP:~w~CopsNGangs",2000,5);
	return 1;
}

//---------------------------------------------------------

public SetupPlayerForClassSelection(playerid)
{
	SetPlayerInterior(playerid,11);
	SetPlayerPos(playerid,508.7362,-87.4335,998.9609);
    SetPlayerCameraPos(playerid,508.7362,-83.4335,998.9609);
	SetPlayerCameraLookAt(playerid,508.7362,-87.4335,998.9609);
	SetPlayerFacingAngle(playerid,0.0);
}

//---------------------------------------------------------

public SetPlayerTeamFromClass(playerid,classid)
{
	// Set their team number based on the class they selected.
	if(classid == 0 || classid == 1 || classid == 2) {
		gTeam[playerid] = TEAM_GREEN;
	} else if(classid == 3 || classid == 4 || classid == 5) {
	    gTeam[playerid] = TEAM_BLUE;
	}
}

//---------------------------------------------------------

public SetPlayerToTeamColor(playerid)
{
	if(gTeam[playerid] == TEAM_GREEN) {
		SetPlayerColor(playerid,TEAM_GREEN_COLOR); // green
	} else if(gTeam[playerid] == TEAM_BLUE) {
	    SetPlayerColor(playerid,TEAM_BLUE_COLOR); // blue
	}
}

//---------------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	SetupPlayerForClassSelection(playerid);
	SetPlayerTeamFromClass(playerid,classid);
	
	if(classid == 0 || classid == 1 || classid == 2) {
		GameTextForPlayer(playerid,"~g~GANG ~w~TEAM",1000,5);
	} else if(classid == 3 || classid == 4 || classid == 5) {
	    GameTextForPlayer(playerid,"~b~COP ~w~TEAM",1000,5);
	}
	
	return 1;
}

//---------------------------------------------------------

public OnPlayerSpawn(playerid)
{
	SetPlayerToTeamColor(playerid);
	SetPlayerInterior(playerid,0);

	if(gTeam[playerid] == TEAM_GREEN) {
	    SetVehicleParamsForPlayer(OBJECTIVE_VEHICLE_GREEN,playerid,1,0); // objective; unlocked
		SetVehicleParamsForPlayer(OBJECTIVE_VEHICLE_BLUE,playerid,1,1); // objective; locked
	    SetPlayerCheckpoint(playerid,2486.7344,-1679.3959,13.3358,5.0);
	    SetPlayerWorldBounds(playerid,2535.4392,1434.0455,-1581.9657,-1715.8713);
	    GameTextForPlayer(playerid,
		   "Defend the ~g~GANG ~w~team's ~r~Van~n~~w~Capture the ~b~COP ~w~team's ~r~Van",
		   6000,5);
	}
	else if(gTeam[playerid] == TEAM_BLUE) {
		SetVehicleParamsForPlayer(OBJECTIVE_VEHICLE_BLUE,playerid,1,0); // objective; unlocked
		SetVehicleParamsForPlayer(OBJECTIVE_VEHICLE_GREEN,playerid,1,1); // objective; locked
	    SetPlayerCheckpoint(playerid,1513.3240,-1660.7247,13.6131,7.0);
		SetPlayerWorldBounds(playerid,2535.4392,1434.0455,-1581.9657,-1715.8713);
	    GameTextForPlayer(playerid,
		   "Defend the ~b~COP ~w~team's ~r~Van~n~~w~Capture the ~g~GANG ~w~team's ~r~Van",
		   6000,5);
	}

	return 1;
}

//---------------------------------------------------------

public OnPlayerEnterCheckpoint(playerid)
{
 	new playervehicleid = GetPlayerVehicleID(playerid);
 	
 	if(gObjectiveReached) return;
 	
	if(playervehicleid == OBJECTIVE_VEHICLE_GREEN && gTeam[playerid] == TEAM_GREEN)
	{   // Green OBJECTIVE REACHED.
	    GameTextForAll("~g~GANG ~w~team wins!",3000,5);
	    gObjectiveReached = 1;
	    SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
	    SetTimer("ExitTheGameMode", 4000, 0); // Set up a timer to exit this mode.
	    return;
	}
	else if(playervehicleid == OBJECTIVE_VEHICLE_BLUE && gTeam[playerid] == TEAM_BLUE)
	{   // Blue OBJECTIVE REACHED.
	    GameTextForAll("~b~COP ~w~team wins!",3000,5);
	    gObjectiveReached = 1;
	    SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
	    SetTimer("ExitTheGameMode", 4000, 0); // Set up a timer to exit this mode.
	    return;
	}
}

//---------------------------------------------------------

public ExitTheGameMode()
{
    GameModeExit();
}

//---------------------------------------------------------

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
		    SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
		}
	}
 	return 1;
}

//---------------------------------
