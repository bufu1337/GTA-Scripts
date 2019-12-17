#include <a_samp>

new Random;

public OnGameModeInit()
{

	// NPCS
	ConnectNPC("Vago1","vago1");
	ConnectNPC("Vago2","vago2");
	ConnectNPC("Vago3","vago3");
	ConnectNPC("Vago4","vago4");
	ConnectNPC("Vago5","vago5");
	
	Random =	AddStaticVehicle(420,2044.8854,1473.2106,10.4494,181.3339,6,1); // Makes sure the NPC Spawns

	return 1;
}

public OnPlayerSpawn(playerid)
{
    if(!IsPlayerNPC(playerid)) return 0;

	new playername[64];
	GetPlayerName(playerid,playername,64);

 	if(!strcmp(playername,"Vago1",true)) {
 		PutPlayerInVehicle(playerid, Random, 0);
 	    SetSpawnInfo( playerid, 0, 108, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
        SetPlayerColor(playerid,0xFFFF00AA);
	}
	else if(!strcmp(playername,"Vago2",true)) {
        PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 109, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	    SetPlayerColor(playerid,0xFFFF00AA);
	}
	else if(!strcmp(playername,"Vago3",true)) {
	    PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 110, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
        SetPlayerColor(playerid,0xFFFF00AA);
	}
	else if(!strcmp(playername,"Vago4",true)) {
	    PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 108, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
	    SetPlayerColor(playerid,0xFFFF00AA);
	}
	else if(!strcmp(playername,"Vago5",true)) {
	    PutPlayerInVehicle(playerid, Random, 0);
	    SetSpawnInfo( playerid, 0, 109, 1958.33, 1343.12, 15.36, 269.15, 31, 1000, 0, 0, 0, 0 );
		SetPlayerColor(playerid,0xFFFF00AA);
	}

    return 1;
}
