#include <a_samp>
#define red 0xff0000ff


public OnGameModeInit()
{

	// NPCS
	
	ConnectNPC("busdriver","bus");
	ConnectNPC("traindriver","train");
	ConnectNPC("planedriver","plane");
	ConnectNPC("ambulancedriver","medic");
	ConnectNPC("JobCentre","jc");
	ConnectNPC("DrugSeller","drug");
	return 1;
}


public OnPlayerSpawn(playerid)
{
    if(!IsPlayerNPC(playerid)) return 0;

	new playername[64];
	GetPlayerName(playerid,playername,64);

    if(!strcmp(playername,"busdriver",true)) {
        SetSpawnInfo( playerid, 0, 61, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0 );
        PutPlayerInVehicle(playerid, 1, 0);
        SetPVarInt(playerid, "Cash", 100);
	}
	else if(!strcmp(playername,"traindriver",true)) {
        SetSpawnInfo( playerid, 0, 61, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0 );
        PutPlayerInVehicle(playerid, 2, 0);
	}
	else if(!strcmp(playername,"planedriver",true)) {
        SetSpawnInfo( playerid, 0, 61, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0 );
        PutPlayerInVehicle(playerid, 6, 0);
	}
	else if(!strcmp(playername,"ambulancedriver",true)) {
        SetSpawnInfo( playerid, 0, 276, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0 );
		PutPlayerInVehicle(playerid, 7, 0);
		SetPVarInt(playerid,"Team", 3);
	}
	else if(!strcmp(playername,"JobCentre",true)) {
        SetSpawnInfo( playerid, 0, 211, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0 );
		PutPlayerInVehicle(playerid, 7, 1);
		SetPlayerVirtualWorld(playerid, 1344);
	}  
	else if(!strcmp(playername,"DrugSeller",true)) {
        SetSpawnInfo( playerid, 0, 28, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0 );
		PutPlayerInVehicle(playerid, 7, 1);
	}
    return 1;
}


