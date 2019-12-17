// Coded By Jax of the SA-MP Team. Based off Rivershell coded by Kyeman.
#include <a_samp>
#include <core>
#include <float>

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define OBJECTIVE_COLOR 0xE2C063FF

forward SetPlayerToTeamColor(playerid);
forward SetPlayerTeamFromClass(playerid,classid);
forward SetPlayerRandomSpawn(playerid);
forward ExitTheGameMode();
forward SetupPlayerForClassSelection(playerid);


static gTeam[MAX_PLAYERS]; // Tracks the team assignment for each player

#define OBJECTIVE_VEHICLE_BLUE 2
#define OBJECTIVE_VEHICLE_GREEN 1
#define TEAM_BLUE 1  //tg
#define TEAM_GREEN 2  //tb
#define TEAM_BLUE_COLOR 0x0000FFAA
#define TEAM_GREEN_COLOR 0x33AA33AA

#define GAME_ROUNDLIMIT 3

new gObjectiveBluePlayer=(-1);
new gObjectiveGreenPlayer=(-1);
new gObjectiveReached=0;
new gGreenScore=0;
new gBlueScore=0;

new Float:gTeam1RandomPlayerSpawns[4][3] = {
{1253.6213,368.9244,19.5614},
{1263.1244,369.7004,19.5547},
{1246.1509,368.8576,19.5547},
{1256.1157,364.1463,19.5614}
};

new Float:gTeam2RandomPlayerSpawns[4][3] = {
{2508.5364,123.0080,26.4863},
{2507.9368,131.3073,26.6412},
{2512.0205,128.9519,26.8512},
{2497.5527,123.0576,26.6734}
};

new Float:gTeam1CapCarSpawns[3][4] = {
{1225.2269,302.1154,19.5547,133.5687},
{1252.3326,250.5466,19.5547,24.2379},
{1218.9547,187.7312,20.1417,338.1774}
};

new Float:gTeam2CapCarSpawns[3][4] = {
{2496.3718,4.6243,26.7704,180.3226},
{2518.0750,-20.9396,26.7207,359.2587},
{2552.4460,9.5014,26.8401,92.5670}
};

main()
{
	print("\n----------------------------------");
	print("  Running LocalYokel: Sports Edition\n");
	print("----------------------------------\n");
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new vehicleid;

	if(newstate == PLAYER_STATE_DRIVER)
	{
		vehicleid = GetPlayerVehicleID(playerid);

		if(gTeam[playerid] == TEAM_GREEN && vehicleid == OBJECTIVE_VEHICLE_BLUE)
		{ // It's the objective vehicle
		    SetPlayerColor(playerid,OBJECTIVE_COLOR);
		    GameTextForPlayer(playerid,"~w~Take the ~y~truck ~w~back to our hometown!",5000,5);
		    gObjectiveBluePlayer = playerid;
		    SetPlayerCheckpoint(playerid,1370.1049,475.6131,19.9169,7.0);
		}

		if(gTeam[playerid] == TEAM_BLUE && vehicleid == OBJECTIVE_VEHICLE_GREEN)
		{ // It's the objective vehicle
		    SetPlayerColor(playerid,OBJECTIVE_COLOR);
      		    GameTextForPlayer(playerid,"~w~Take the ~y~truck ~w~back to our hometown!",5000,5);
		    gObjectiveGreenPlayer = playerid;
		    SetPlayerCheckpoint(playerid,2552.1548,14.3830,26.8371,7.0);
		}
	}
	else if(newstate == PLAYER_STATE_ONFOOT)
	{
		if(playerid == gObjectiveBluePlayer) {
		    gObjectiveBluePlayer = (-1);
		    SetPlayerToTeamColor(playerid);
		    DisablePlayerCheckpoint(playerid);
		}

		if(playerid == gObjectiveGreenPlayer) {
		    gObjectiveGreenPlayer = (-1);
		    SetPlayerToTeamColor(playerid);
		    DisablePlayerCheckpoint(playerid);
		}
	}

	return 1;
}

public SetPlayerTeamFromClass(playerid,classid)
{
	// Set their team number based on the class they selected.
	if(classid == 0 || classid == 1) {
		gTeam[playerid] = TEAM_GREEN;
	} else if(classid == 2 || classid == 3) {
	    gTeam[playerid] = TEAM_BLUE;
	}
}

public SetPlayerToTeamColor(playerid)
{
	if(gTeam[playerid] == TEAM_BLUE) {
		SetPlayerColor(playerid,TEAM_BLUE_COLOR); // blue
	} else if(gTeam[playerid] == TEAM_GREEN) {
	    SetPlayerColor(playerid,TEAM_GREEN_COLOR); // green
	}
}

public OnGameModeExit()
{
	print("GameModeExit()");
	return 1;
}

public OnPlayerConnect(playerid)
{
	GameTextForPlayer(playerid,"~w~SA-MP:~g~LocalYokel~w~:~r~SE",8000,5);
	SendPlayerFormattedText(playerid, "Welcome to Local Yokel: Sports Edition, for help type /help.", 0);
	GivePlayerMoney(playerid, 500);
	return 1;
}

public OnPlayerDisconnect(playerid)
{
	printf("OnPlayerDisconnect(%d)", playerid);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new idx;

	cmd = strtok(cmdtext, idx);

	if(strcmp(cmd, "/help", true) == 0) {
		SendPlayerFormattedText(playerid,"Local Yokel:Sports Edition Coded By Jax and the SA-MP Team.",0);
		SendPlayerFormattedText(playerid,"Type: /objective : to find out what to do in this gamemode.",0);
    return 1;
	}
	if(strcmp(cmd, "/objective", true) == 0) {
		SendPlayerFormattedText(playerid,"The Objective of this gamemode is to steal the other teams flag car, which in",0);
		SendPlayerFormattedText(playerid,"this particular gamemode is a Semi (Linerunner). The first team to capture,",0);
		SendPlayerFormattedText(playerid,"the oppositions truck three times wins.",0);
    return 1;
	}


	// PROCESS OTHER COMMANDS


	return 0;
}

public OnPlayerSpawn(playerid)
{

	SetPlayerToTeamColor(playerid);
	
	if(gTeam[playerid] == TEAM_BLUE) {
		SetPlayerRandomSpawn(playerid);
		SetVehicleParamsForPlayer(OBJECTIVE_VEHICLE_GREEN,playerid,1,0); // objective; unlocked
		SetVehicleParamsForPlayer(OBJECTIVE_VEHICLE_BLUE,playerid,1,1); // objective; locked

		//SetPlayerWorldBounds(playerid,2444.4185,1687.5696,631.2963,-454.9898);
		GameTextForPlayer(playerid,
		   "Defend the ~b~BLUE ~w~team's ~r~Semi~n~~w~Capture the ~g~GREEN ~w~team's ~r~Semi",
		   6000,5);
	}
	else if(gTeam[playerid] == TEAM_GREEN) {
		SetPlayerRandomSpawn(playerid);
		SetVehicleParamsForPlayer(OBJECTIVE_VEHICLE_BLUE,playerid,1,0); // objective; unlocked
		SetVehicleParamsForPlayer(OBJECTIVE_VEHICLE_GREEN,playerid,1,1); // objective; locked
		//SetPlayerWorldBounds(playerid,2444.4185,1687.5696,631.2963,-454.9898);
		GameTextForPlayer(playerid,
		   "Defend the ~g~GREEN ~w~team's ~r~Semi~n~~w~Capture the ~b~BLUE ~w~team's ~r~Semi",
		   6000,5);
	}
	SetPlayerInterior(playerid,0);

	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
 	new playervehicleid = GetPlayerVehicleID(playerid);

 	if(gObjectiveReached) return;

	if(playervehicleid == OBJECTIVE_VEHICLE_GREEN && gTeam[playerid] == TEAM_BLUE)
	{   // Green OBJECTIVE REACHED.
		GameTextForAll("~b~Blue ~w~team has ~r~Scored~w~!!!",5000,5);
		gObjectiveReached = 1;
		SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
		
		if (gBlueScore < GAME_ROUNDLIMIT)  {
	        gBlueScore++;
  			RemovePlayerFromVehicle(playerid);
	        SetPlayerColor(playerid, TEAM_BLUE_COLOR);
	        SetVehicleToRespawn(OBJECTIVE_VEHICLE_GREEN);
	        gObjectiveReached = 0;
	        }
		else if (gBlueScore == GAME_ROUNDLIMIT)  {
			SetTimer("ExitTheGameMode", 4000, 0); // Set up a timer to exit this mode.
			}
		return;
	}
	else if(playervehicleid == OBJECTIVE_VEHICLE_BLUE && gTeam[playerid] == TEAM_GREEN)
	{   // Blue OBJECTIVE REACHED.
     	GameTextForAll("~g~Green ~w~team has ~r~Scored~w~!!!",5000,5);
	    gObjectiveReached = 1;
	    SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
	    
	    if (gGreenScore < GAME_ROUNDLIMIT)  {
	        gGreenScore++;
	        RemovePlayerFromVehicle(playerid);
	        SetPlayerColor(playerid, TEAM_GREEN_COLOR);
	        SetVehicleToRespawn(OBJECTIVE_VEHICLE_BLUE);
	        gObjectiveReached = 0;
	        }
		else if (gGreenScore == GAME_ROUNDLIMIT)  {
			SetTimer("ExitTheGameMode", 4000, 0); // Set up a timer to exit this mode.
			}
	    return;
	}
}

public ExitTheGameMode()
{
    GameModeExit();
}

public SetPlayerRandomSpawn(playerid)
{

	if(gTeam[playerid] == TEAM_GREEN) {
		new rand = random(sizeof(gTeam1RandomPlayerSpawns));
		SetPlayerPos(playerid, gTeam1RandomPlayerSpawns[rand][0], gTeam1RandomPlayerSpawns[rand][1], gTeam1RandomPlayerSpawns[rand][2]); // Warp the player
		}
	else if(gTeam[playerid] == TEAM_BLUE) {
		new rand = random(sizeof(gTeam2RandomPlayerSpawns));
		SetPlayerPos(playerid, gTeam2RandomPlayerSpawns[rand][0], gTeam2RandomPlayerSpawns[rand][1], gTeam2RandomPlayerSpawns[rand][2]); // Warp the player
		}
	return 1;
}


//------------------------------------------------------------------------------------------------------

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

//------------------------------------------------------------------------------------------------------

public SetupPlayerForClassSelection(playerid)
{
	SetPlayerInterior(playerid,14);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerFacingAngle(playerid, 180.0);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1004.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
}

public OnPlayerText(playerid)
{
	printf("OnPlayerText(%d)", playerid);
	return 1;
}

public OnPlayerInfoChange(playerid)
{
	printf("OnPlayerInfoChange(%d)");
	return 1;
}


public OnPlayerRequestClass(playerid, classid)
{
	SetupPlayerForClassSelection(playerid);
	SetPlayerTeamFromClass(playerid,classid);

	if(classid == 0 || classid == 1) {
		GameTextForPlayer(playerid,"~g~GREEN ~w~TEAM",1000,5);
	} else if(classid == 2 || classid == 3) {
	    GameTextForPlayer(playerid,"~b~BLUE ~w~TEAM",1000,5);
	}

	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	printf("OnPlayerEnterVehicle(%d, %d, %d)", playerid, vehicleid, ispassenger);
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	printf("OnPlayerExitVehicle(%d, %d)", playerid, vehicleid);
	return 1;
}

public OnGameModeInit()
{
	SetGameModeText("LocalYokel~SE");

	ShowPlayerMarkers(1);
	ShowNameTags(1);

	// Player Class's
	AddPlayerClass(45,1958.3783,1343.1572,15.3746,269.1425,0,0,31,400,29,400);
	AddPlayerClass(101,1958.3783,1343.1572,15.3746,269.1425,0,0,31,400,29,400);
	AddPlayerClass(44,1958.3783,1343.1572,15.3746,269.1425,0,0,31,400,29,400);
	AddPlayerClass(79,1958.3783,1343.1572,15.3746,269.1425,0,0,31,400,29,400);


	//Uber haxed
	new rand = random(sizeof(gTeam1CapCarSpawns));
	AddStaticVehicle(403,gTeam1CapCarSpawns[rand][0], gTeam1CapCarSpawns[rand][1], gTeam1CapCarSpawns[rand][2], gTeam1CapCarSpawns[rand][3],16,86); //    1
	new rand2 = random(sizeof(gTeam2CapCarSpawns));
	AddStaticVehicle(403,gTeam2CapCarSpawns[rand2][0], gTeam2CapCarSpawns[rand2][1], gTeam2CapCarSpawns[rand2][2], gTeam2CapCarSpawns[rand2][3],53,79); //   2
	AddStaticVehicle(429,1291.5171,386.0683,19.3427,224.2558,16,86); //
	AddStaticVehicle(506,1289.8990,339.4082,19.3367,62.4070,16,86); //
	AddStaticVehicle(506,1201.0231,210.6816,19.6471,254.7104,16,86); //
	AddStaticVehicle(558,1283.6090,194.3443,19.6934,140.9890,16,86); //
	AddStaticVehicle(558,1333.6827,289.6975,19.3389,248.0371,16,86); //
	AddStaticVehicle(559,1382.8953,462.3477,19.9157,249.8025,16,86); //
	AddStaticVehicle(451,1351.9758,474.8747,19.9638,160.9584,16,86); // pursuit
	AddStaticVehicle(415,1436.6161,352.6960,18.6253,246.4098,16,86); //
	
	AddStaticVehicle(429,2479.9863,-21.7586,26.8191,357.6076,53,79); //
	AddStaticVehicle(506,2447.3662,11.4693,26.2659,271.7852,53,79); //
	AddStaticVehicle(506,2451.3882,54.4292,26.7069,180.9931,53,79); //
	AddStaticVehicle(558,2480.5303,72.1693,26.2643,87.3403,53,79); //
	AddStaticVehicle(558,2450.0662,86.1454,26.8901,271.4482,53,79); //
	AddStaticVehicle(559,2503.5571,130.6548,26.2573,182.5659,53,79); //
	AddStaticVehicle(559,2528.5684,129.9435,26.2665,180.5040,53,79); //
	AddStaticVehicle(415,2358.4480,-57.9099,27.2476,359.3354,53,79); //
	AddStaticVehicle(576,2255.1567,-83.8130,26.3011,180.7819,53,79); //
	
	AddStaticVehicle(559,2543.7505,-21.8345,27.1899,52.6054,53,79); //
	AddStaticVehicle(560,2532.9011,-20.9020,26.9682,44.2714,53,79); //
	AddStaticVehicle(559,1237.1293,216.0368,19.4196,67.2298,16,86); //
	AddStaticVehicle(560,1233.4669,210.4867,19.4207,71.8665,16,86); //
	AddStaticVehicle(451,2412.3945,87.1468,27.0779,90.2884,53,79); // pursuit
	
	// middle cars
	
	AddStaticVehicle(532,1983.6481,192.9661,30.2435,118.7291,-1,-1); //
	AddStaticVehicle(500,1535.5183,211.1319,22.2397,250.1303,-1,-1); //
	AddStaticVehicle(599,1892.3500,33.9616,34.8752,7.7706,-1,-1); //
	
	// quads
	
	AddStaticVehicle(522,1291.5033,343.9851,19.3353,63.9255,16,86); //
	AddStaticVehicle(522,1285.4846,379.3808,19.3397,226.8902,16,86); //
	AddStaticVehicle(522,1364.0281,261.8433,19.3482,67.5361,16,86); //
	AddStaticVehicle(522,2508.0095,133.3255,26.4635,178.1469,53,79); //
	AddStaticVehicle(522,2469.3633,127.8933,26.2566,181.8120,53,79); //
	AddStaticVehicle(522,2476.6206,53.3900,26.3040,94.0562,53,79); //
	
	AddVehicleComponent(OBJECTIVE_VEHICLE_GREEN, 1010);
	AddVehicleComponent(OBJECTIVE_VEHICLE_BLUE, 1010);
	AddVehicleComponent(OBJECTIVE_VEHICLE_GREEN, 1096);
	AddVehicleComponent(OBJECTIVE_VEHICLE_BLUE, 1096);

	return 1;
}

public SendPlayerFormattedText(playerid, const str[], define)
{
	new tmpbuf[256];
	format(tmpbuf, sizeof(tmpbuf), str, define);
	SendClientMessage(playerid, 0xFFFF00AA, tmpbuf);
}

public SendAllFormattedText(playerid, const str[], define)
{
	new tmpbuf[256];
	format(tmpbuf, sizeof(tmpbuf), str, define);
	SendClientMessageToAll(0xFFFF00AA, tmpbuf);
}

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
