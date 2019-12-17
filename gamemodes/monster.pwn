//---------------------------------------------------------
//
// MONSTER! A freeroam script centered around the desert.
//   by Mike
//---------------------------------------------------------

#include <a_samp>

#define COLOR_RED 0xAA3333AA

forward GameModeExitFunc();

// This is how long the round lasts before exiting
//  Set to 0 to disable the timer
//new gRoundTime = 1200000;
new gRoundTime = 0;

//---------------------------------------------------------

main()
{
	print("\n----------------------------------");
	print("  Monster freeroam by Mike (2006)\n");
	print("----------------------------------\n");
}

//---------------------------------------------------------

public OnGameModeInit()
{
	new Float:monsterX = 414.9143;
	new Float:boatX = 260.0439;
	new Float:bikeX = 393.8199;
	new id;
	new count;
	
	SetGameModeText("Monster freeroam");
	
	// Players
	for (id = 254; id <= 288; id++) {
		if (id == 265) id = 274; // Skip over the bad ones
		AddPlayerClass(id,389.8672,2543.0046,16.5391,173.7645,0,0,0,0,0,0);
	}
	
	// Mike's special monster truck
	AddStaticVehicle(556,423.9143,2482.2766,16.8594,0.0,1,1);
	for(count = 0; count <= 50; count++) {
		AddStaticVehicle(557,monsterX,2482.4856,16.8594,0.0,1,1);
		monsterX -= 9.0;
	}
	
	// Boats
	for(count = 0; count <= 15; count++) {
		AddStaticVehicle(446,boatX,2970.7834,-1.0287,7.0391,-1,-1);
		boatX += 6.0;
	}
	
	// Mountain bikes/BMXes
	for(count = 0; count <= 10; count++) {
		AddStaticVehicle(481,bikeX,2547.0911,16.0545,356.9482,-1,-1);
		AddStaticVehicle(510,bikeX,2538.3503,16.1516,356.1028,-1,-1);
		bikeX -= 2.5;
	}
	
	AddStaticVehicle(513,324.7664,2546.0984,16.4876,178.8663,-1,-1); // stuntplane
	AddStaticVehicle(513,290.2709,2544.7771,16.5000,178.0178,-1,-1); // stuntplane
	AddStaticVehicle(487,261.9073,2522.6987,16.4046,175.9395,-1,-1); // heli
	AddStaticVehicle(487,244.0523,2524.3516,16.4171,180.8316,-1,-1); // heli
	AddStaticVehicle(592,-73.1792,2502.1990,16.1641,270.0,-1,-1); //adromeda
	AddStaticVehicle(532,101.5550,2584.0725,17.4540,178.0316,-1,-1); // combine

	if (gRoundTime > 0) {
	    SetTimer("GameModeExitFunc", gRoundTime, 0);
	}
	return 1;
}

//---------------------------------------------------------

public OnPlayerConnect(playerid)
{
	GameTextForPlayer(playerid,"~w~Monster freeroam!",1000,5);
	return 1;
}

//---------------------------------------------------------

SetupPlayerForClassSelection(playerid)
{
	SetPlayerPos(playerid,398.4077,2540.5049,19.6311);
	SetPlayerCameraPos(playerid,398.4077,2530.5049,19.6311);
	SetPlayerCameraLookAt(playerid,398.4077,2540.5049,19.6311);
	SetPlayerFacingAngle(playerid, 180.0);
}

//---------------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	SetupPlayerForClassSelection(playerid);
	return 1;
}

//---------------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
	new name[256];
	new string[256];
	GetPlayerName(playerid, name, sizeof(name));
	format(string, sizeof(string), "*** %s died.", name);
	SendClientMessageToAll(COLOR_RED, string);
 	return 1;
}

//---------------------------------------------------------

public GameModeExitFunc() {
	GameModeExit();
}
