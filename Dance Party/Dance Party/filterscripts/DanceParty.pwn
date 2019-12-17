#include <a_samp>

new Random;

public OnGameModeInit()
{

	// NPCS
	ConnectNPC("Dancer1","dancer1");
	ConnectNPC("Dancer2","dancer2");
	ConnectNPC("Dancer3","dancer3");
	ConnectNPC("Dancer4","dancer4");
	ConnectNPC("Dancer5","dancer5");
	ConnectNPC("Dancer6","dancer6");
	ConnectNPC("Dancer7","dancer7");
	ConnectNPC("Dancer8","dancer8");
    ConnectNPC("Dancer9","dancer9");
    ConnectNPC("Dancer10","dancer10");
    ConnectNPC("Dancer11","dancer11");
    ConnectNPC("Dancer12","dancer12");
    ConnectNPC("Dancer13","dancer13");
    ConnectNPC("Dancer14","dancer14");
    ConnectNPC("StageDancer1","stagedancer1");
    ConnectNPC("StageDancer2","stagedancer2");
    ConnectNPC("StageDancer3","stagedancer3");
    ConnectNPC("Bystander","bystander");
    ConnectNPC("DrinkServer","drinkserver");
    ConnectNPC("VIPMember","vipmember");
    ConnectNPC("Security","security");
	
	Random =	AddStaticVehicle(420,2044.8854,1473.2106,10.4494,181.3339,6,1); // Makes sure the NPC Spawns

	return 1;
}

public OnPlayerSpawn(playerid)
{
    if(!IsPlayerNPC(playerid)) return 0;

	new playername[64];
	GetPlayerName(playerid,playername,64);

 	if(!strcmp(playername,"Dancer1",true)) {
 		PutPlayerInVehicle(playerid, Random, 0);
 	    SetSpawnInfo( playerid, 0, 12, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"Dancer2",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 101, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"Dancer3",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 13, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"Dancer4",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 169, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"Dancer5",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 170, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"Dancer6",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 180, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"Dancer7",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 216, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"Dancer8",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 21, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"Dancer9",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 214, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"Dancer10",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 226, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"Dancer11",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 223, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"Dancer12",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 24, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"Dancer13",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 25, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"Dancer14",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 40, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"StageDancer1",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 277, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"StageDancer2",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 280, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"StageDancer3",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 287, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"Bystander",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 59, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"DrinkServer",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 93, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
    else if(!strcmp(playername,"VIPMember",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 103, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}
	else if(!strcmp(playername,"Security",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 164, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	}

    return 1;
}
