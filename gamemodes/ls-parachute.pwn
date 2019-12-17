//---------------------------------------------------------
//
// Los Santos Parachuting.
//
//---------------------------------------------------------

#include <a_samp>
#include <core>
#include <float>

#define COLOR_RED 0xAA3333AA

//---------------------------------------------------------

main()
{
	print("\n----------------------------------");
	print("  Los Santos Parachuting\n   By Mike (2006)");
	print("----------------------------------\n");
}

//---------------------------------------------------------

public OnGameModeInit()
{
	new count;
	new id;
	
	SetGameModeText("Los Santos Parachuting");
	ShowNameTags(1);
	ShowPlayerMarkers(1);

	id = 47;
	for(count = 0; count < 15; count++) {
		AddPlayerClass(id,1545.5275,-1370.0961,329.4535,7.9780,0,0,0,0,0,0); // playerspawn
		id++;
	}
	AddPlayerClass(id,1969.9589,-1185.5995,2000.0,90.0527,0,0,0,0,0,0); // pondspawn

	AddStaticVehicle(487,1544.3810,-1354.1403,329.6510,0.9474,54,29); // heli1
	AddStaticVehicle(487,1668.1875,-1267.6479,233.5519,80.6809,3,29); // heli2
	AddStaticVehicle(487,1423.8759,-1189.4307,195.2232,272.4731,3,29); // heli
	AddStaticVehicle(487,1427.8669,-1206.7137,195.2205,253.2966,3,29); // heli
	AddStaticVehicle(487,1514.6334,-1067.3450,181.3798,269.2993,3,29); // heli
	AddStaticVehicle(487,1532.8845,-1074.3094,181.3804,271.0264,3,29); // heli
	AddStaticVehicle(487,1667.1321,-1222.7820,233.5480,288.6899,3,29); // heli
	AddStaticVehicle(487,1560.2428,-1358.4150,329.6322,89.3433,3,29); // heli
	AddStaticVehicle(487,1654.5442,-1637.0603,83.9570,201.0777,3,29); // heli

	AddStaticPickup(371, 15, 1545.5070,-1225.3750,261.5938);
	AddStaticPickup(371, 15, 1440.8297,-1227.1548,187.1926);
	AddStaticPickup(371, 15, 1498.3612,-1282.6539,113.7795);
	AddStaticPickup(371, 15, 1552.8856,-1264.9105,277.8750);
	AddStaticPickup(371, 15, 1548.4478,-1268.6362,261.5938);
	AddStaticPickup(371, 15, 1544.6133,-1272.7666,250.6563);
	AddStaticPickup(371, 15, 1656.8127,-1249.7767,233.3750);
	AddStaticPickup(371, 15, 1656.8175,-1274.2491,200.5234);
	AddStaticPickup(371, 15, 1661.2855,-1644.0159,87.3735);
	
	return 1;
}

//---------------------------------------------------------

public OnPlayerConnect(playerid)
{
	GameTextForPlayer(playerid,"~w~Los Santos Parachuting!",5000,5);
	return 1;
}

//---------------------------------------------------------

SetupPlayerForClassSelection(playerid)
{
	SetPlayerPos(playerid,1545.5275,-1370.0961,329.4535);
	SetPlayerCameraPos(playerid,1545.5275,-1365.0961,329.4535);
	SetPlayerCameraLookAt(playerid,1545.5275,-1370.0961,329.4535);
}

//---------------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	SetupPlayerForClassSelection(playerid);
	printf("Classid: %d", classid);
	switch (classid) {
	    case 0..14:
	        {
				GameTextForPlayer(playerid, "Building", 1000, 3);
			}
		case 15:
		    {
				GameTextForPlayer(playerid, "Pond", 1000, 3);
			}
	}
	return 1;
}

//---------------------------------------------------------

public OnPlayerSpawn(playerid)
{
	GameTextForPlayer(playerid,"~r~Fly like a bird.",3000,5);
	return 1;
}

//---------------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
	new name[MAX_PLAYER_NAME+1];
	new string[256];
	GetPlayerName(playerid, name, sizeof(name));
	format(string, sizeof(string), "*** %s died.", name, reason);
	SendClientMessageToAll(COLOR_RED, string);
 	return 1;
}

//---------------------------------------------------------
