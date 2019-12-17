#define RECORDING2 "cop" //This is the filename of your recording without the extension.
#define RECORDING2_TYPE 2 //1 for in vehicle and 2 for on foot.
#define RECORDING3 "guard" //This is the filename of your recording without the extension.
#define RECORDING3_TYPE 2 //1 for in vehicle and 2 for on foot.
#define RECORDING1 "police" //This is the filename of your recording without the extension.
#define RECORDING1_TYPE 1 //1 for in vehicle and 2 for on foot.
#define RECORDING4 "fly" //This is the filename of your recording without the extension.
#define RECORDING4_TYPE 1 //1 for in vehicle and 2 for on foot.
#define RECORDING5 "police3" //This is the filename of your recording without the extension.
#define RECORDING5_TYPE 1 //1 for in vehicle and 2 for on foot.

#include <a_samp>

new police2;
new fly;
new Random;
new police3;

public OnFilterScriptInit()
{
	print("Police Force For RP by GAGLETS");
	// NPCS
	ConnectNPC("police2","police");
	ConnectNPC("cop1","cop1");
	ConnectNPC("guard","guard");
    ConnectNPC("fly","fly");
    ConnectNPC("police3","police3");

	police2 =	AddStaticVehicle(597,1535.8085,-1678.8069,13.1522,359.4198,77,100); // police car renew
	fly =   AddStaticVehicle(497,1556.6639,-1651.4907,28.5736,108.3272,45,192); // police fly rere
	Random =	AddStaticVehicle(420,0,0,0,0,0,0); // Makes sure the NPC Spawns
	police3 =   AddStaticVehicle(597,1524.2937,-1657.2635,13.2267,182.2271,77,100); // POLICE 3

	return 1;
}

public OnPlayerSpawn(playerid)
{
    if(IsPlayerNPC(playerid)) //Checks if the player that just spawned is an NPC.
    {
        new npcname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, npcname, sizeof(npcname)); //Getting the NPC's name.
        if(!strcmp(npcname, "police2", true)) //Checking if the NPC's name is MyFirstNPC
        {
            PutPlayerInVehicle(playerid, police2, 0); //Putting the NPC into the vehicle we created for it.
            ShowPlayerMarkers(0);
			return 1;
        }
        new npcname2[MAX_PLAYER_NAME];
        GetPlayerName(playerid, npcname2, sizeof(npcname2)); //Getting the NPC's name.
        if(!strcmp(npcname2,"cop1",true))
		{
 			PutPlayerInVehicle(playerid, Random, 0);
 	    	SetSpawnInfo( playerid, 0, 288,256.4685,69.5772,1003.6406,85.3320,0,0,0,0,0,0);
            ShowPlayerMarkers(0);
			return 1;
		}
        new npcname3[MAX_PLAYER_NAME];
        GetPlayerName(playerid, npcname3, sizeof(npcname3)); //Getting the NPC's name.
        if(!strcmp(npcname3, "guard", true))
        {
            PutPlayerInVehicle(playerid, Random, 0);
            SetSpawnInfo( playerid, 0, 164,1544.0894,-1631.9235,13.3828,93.1440,0,0,0,0,0,0);
            ShowPlayerMarkers(0);
			return 1;
        }
		new npcname4[MAX_PLAYER_NAME];
		GetPlayerName(playerid, npcname4, sizeof(npcname4)); //Getting the NPC's name.
        if(!strcmp(npcname4, "fly", true))
        {
			PutPlayerInVehicle(playerid, fly, 0);
            ShowPlayerMarkers(0);
			return 1;
        }
		new npcname5[MAX_PLAYER_NAME];
		GetPlayerName(playerid, npcname5, sizeof(npcname5)); //Getting the NPC's name.
        if(!strcmp(npcname5, "police3", true))
        {
            PutPlayerInVehicle(playerid, police3, 0);
            ShowPlayerMarkers(0);
            return 1;
        }
        return 1;
    }
    return 1;
}
    //Other stuff for normal players goes here!
