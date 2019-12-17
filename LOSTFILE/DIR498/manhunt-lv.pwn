//---------------------------------------------------------
//
// Manhunt: Las Venturas. Hunt a randomly picked player and murder them brutally
//
//---------------------------------------------------------

#include <a_samp>
#include <core>
#include <float>

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF33AA

new Float:gRandomPlayerSpawns[24][3] = {
	{1958.3783,1343.1572,15.3746},
	{2199.6531,1393.3678,10.8203},
	{2483.5977,1222.0825,10.8203},
	{2637.2712,1129.2743,11.1797},
	{2000.0106,1521.1111,17.0625},
	{2024.8190,1917.9425,12.3386},
	{2261.9048,2035.9547,10.8203},
	{2262.0986,2398.6572,10.8203},
	{2244.2566,2523.7280,10.8203},
	{2335.3228,2786.4478,10.8203},
	{2150.0186,2734.2297,11.1763},
	{2158.0811,2797.5488,10.8203},
	{1969.8301,2722.8564,10.8203},
	{1652.0555,2709.4072,10.8265},
	{1564.0052,2756.9463,10.8203},
	{1271.5452,2554.0227,10.8203},
	{1441.5894,2567.9099,10.8203},
	{1480.6473,2213.5718,11.0234},
	{1400.5906,2225.6960,11.0234},
	{1598.8419,2221.5676,11.0625},
	{1318.7759,1251.3580,10.8203},
	{1558.0731,1007.8292,10.8125},
	{1705.2347,1025.6808,10.8203},
	{968.8336,1805.8030,8.6484}
};

// Manhunt stuff
new gStarted = 0;							// Are we playing?
new gActivePlayers[MAX_PLAYERS];            // Players in the game, spawned or not
new gSpawnedPlayers[MAX_PLAYERS];           // Keep track of the spawned players
new gMinimumPlayers = 3;                    // Minimum players before manhunt will select a player
new gHunted = INVALID_PLAYER_ID;            // The hunted player.
new gScores[MAX_PLAYERS];                   // Local score tracker
new gSurvivalTime = 180000;					// 3 mins
new gSurvivalTimer = -1;					// To keep track of the timer
new gScoreIncreases[4] = {                  // Score changes
	5,											// Surviving the hunt
	-1,											// Dying during the hunt
	2,											// Killing the hunted
	1											// Killing a non-hunted player
};
//new gRoundTime = 1200000;					// Round time - 20 mins
//new gRoundTime = 900000;					// Round time - 15 mins
new gRoundTime = 600000;					// Round time - 10 mins
//new gRoundTime = 300000;					// Round time - 5 mins
//new gRoundTime = 120000;					// Round time - 2 mins
//new gRoundTime = 60000;					// Round time - 1 min


main()
{
	print("\n----------------------------------");
	print("  Manhunt Las Venturas\n    By Mike (2006)");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	new id;
	SetGameModeText("Manhunt LV");

	ShowPlayerMarkers(1);
	ShowNameTags(1);

	// Player Classes
	for (id=209; id<=253; id++) {
		AddPlayerClass(id,0.0,0.0,0.0,0.0,24,300,29,1000,31,1000);
	}

	// Car Spawns
	
	AddStaticVehicle(473,-2680.0557,1584.3536,-0.0836,66.7176,56,56);
	AddStaticVehicle(451,2040.0520,1319.2799,10.3779,183.2439,16,16);
	AddStaticVehicle(429,2040.5247,1359.2783,10.3516,177.1306,13,13);
	AddStaticVehicle(421,2110.4102,1398.3672,10.7552,359.5964,13,13);
	AddStaticVehicle(411,2074.9624,1479.2120,10.3990,359.6861,64,64);
	AddStaticVehicle(477,2075.6038,1666.9750,10.4252,359.7507,94,94);
	AddStaticVehicle(541,2119.5845,1938.5969,10.2967,181.9064,22,22);
	AddStaticVehicle(541,1843.7881,1216.0122,10.4556,270.8793,60,1);
	AddStaticVehicle(402,1944.1003,1344.7717,8.9411,0.8168,30,30);
	AddStaticVehicle(402,1679.2278,1316.6287,10.6520,180.4150,90,90);
	AddStaticVehicle(415,1685.4872,1751.9667,10.5990,268.1183,25,1);
	AddStaticVehicle(411,2034.5016,1912.5874,11.9048,0.2909,123,1);
	AddStaticVehicle(411,2172.1682,1988.8643,10.5474,89.9151,116,1);
	AddStaticVehicle(429,2245.5759,2042.4166,10.5000,270.7350,14,14);
	AddStaticVehicle(477,2361.1538,1993.9761,10.4260,178.3929,101,1);
	AddStaticVehicle(550,2221.9946,1998.7787,9.6815,92.6188,53,53);
	AddStaticVehicle(558,2243.3833,1952.4221,14.9761,359.4796,116,1);
	AddStaticVehicle(587,2276.7085,1938.7263,31.5046,359.2321,40,1);
	AddStaticVehicle(587,2602.7769,1853.0667,10.5468,91.4813,43,1);
	AddStaticVehicle(603,2610.7600,1694.2588,10.6585,89.3303,69,1);
	AddStaticVehicle(587,2635.2419,1075.7726,10.5472,89.9571,53,1);
	AddStaticVehicle(562,2577.2354,1038.8063,10.4777,181.7069,35,1);
	AddStaticVehicle(562,2394.1021,989.4888,10.4806,89.5080,17,1);
	AddStaticVehicle(562,1881.0510,957.2120,10.4789,270.4388,11,1);
	AddStaticVehicle(535,2039.1257,1545.0879,10.3481,359.6690,123,1);
	AddStaticVehicle(535,2009.8782,2411.7524,10.5828,178.9618,66,1);
	AddStaticVehicle(429,2010.0841,2489.5510,10.5003,268.7720,1,2);
	AddStaticVehicle(415,2076.4033,2468.7947,10.5923,359.9186,36,1);
	AddStaticVehicle(506,2352.9026,2577.9768,10.5201,0.4091,7,7);
	AddStaticVehicle(506,2166.6963,2741.0413,10.5245,89.7816,52,52);
	AddStaticVehicle(411,1960.9989,2754.9072,10.5473,200.4316,112,1);
	AddStaticVehicle(429,1919.5863,2760.7595,10.5079,100.0753,2,1);
	AddStaticVehicle(415,1673.8038,2693.8044,10.5912,359.7903,40,1);
	AddStaticVehicle(402,1591.0482,2746.3982,10.6519,172.5125,30,30);
	AddStaticVehicle(603,1580.4537,2838.2886,10.6614,181.4573,75,77);
	AddStaticVehicle(550,1555.2734,2750.5261,10.6388,91.7773,62,62);
	AddStaticVehicle(535,1455.9305,2878.5288,10.5837,181.0987,118,1);
	AddStaticVehicle(477,1537.8425,2578.0525,10.5662,0.0650,121,1);
	AddStaticVehicle(451,1433.1594,2607.3762,10.3781,88.0013,16,16);
	AddStaticVehicle(603,2223.5898,1288.1464,10.5104,182.0297,18,1);
	AddStaticVehicle(558,2451.6707,1207.1179,10.4510,179.8960,24,1);
	AddStaticVehicle(550,2461.7253,1357.9705,10.6389,180.2927,62,62);
	AddStaticVehicle(558,2461.8162,1629.2268,10.4496,181.4625,117,1);
	AddStaticVehicle(477,2395.7554,1658.9591,10.5740,359.7374,0,1);
	AddStaticVehicle(404,1553.3696,1020.2884,10.5532,270.6825,119,50);
	AddStaticVehicle(400,1380.8304,1159.1782,10.9128,355.7117,123,1);
	AddStaticVehicle(418,1383.4630,1035.0420,10.9131,91.2515,117,227);
	AddStaticVehicle(404,1445.4526,974.2831,10.5534,1.6213,109,100);
	AddStaticVehicle(400,1704.2365,940.1490,10.9127,91.9048,113,1);
	AddStaticVehicle(404,1658.5463,1028.5432,10.5533,359.8419,101,101);
	AddStaticVehicle(581,1677.6628,1040.1930,10.4136,178.7038,58,1);
	AddStaticVehicle(581,1383.6959,1042.2114,10.4121,85.7269,66,1);
	AddStaticVehicle(581,1064.2332,1215.4158,10.4157,177.2942,72,1);
	AddStaticVehicle(581,1111.4536,1788.3893,10.4158,92.4627,72,1);
	AddStaticVehicle(522,953.2818,1806.1392,8.2188,235.0706,3,8);
	AddStaticVehicle(522,995.5328,1886.6055,10.5359,90.1048,3,8);
	AddStaticVehicle(521,993.7083,2267.4133,11.0315,1.5610,75,13);
	AddStaticVehicle(535,1439.5662,1999.9822,10.5843,0.4194,66,1);
	AddStaticVehicle(522,1430.2354,1999.0144,10.3896,352.0951,6,25);
	AddStaticVehicle(522,2156.3540,2188.6572,10.2414,22.6504,6,25);
	AddStaticVehicle(598,2277.6846,2477.1096,10.5652,180.1090,0,1);
	AddStaticVehicle(598,2268.9888,2443.1697,10.5662,181.8062,0,1);
	AddStaticVehicle(598,2256.2891,2458.5110,10.5680,358.7335,0,1);
	AddStaticVehicle(598,2251.6921,2477.0205,10.5671,179.5244,0,1);
	AddStaticVehicle(523,2294.7305,2441.2651,10.3860,9.3764,0,0);
	AddStaticVehicle(523,2290.7268,2441.3323,10.3944,16.4594,0,0);
	AddStaticVehicle(523,2295.5503,2455.9656,2.8444,272.6913,0,0);
	AddStaticVehicle(522,2476.7900,2532.2222,21.4416,0.5081,8,82);
	AddStaticVehicle(522,2580.5320,2267.9595,10.3917,271.2372,8,82);
	AddStaticVehicle(522,2814.4331,2364.6641,10.3907,89.6752,36,105);
	AddStaticVehicle(535,2827.4143,2345.6953,10.5768,270.0668,97,1);
	AddStaticVehicle(521,1670.1089,1297.8322,10.3864,359.4936,87,118);
	AddStaticVehicle(415,1319.1038,1279.1791,10.5931,0.9661,62,1);
	AddStaticVehicle(521,1710.5763,1805.9275,10.3911,176.5028,92,3);
	AddStaticVehicle(521,2805.1650,2027.0028,10.3920,357.5978,92,3);
	AddStaticVehicle(535,2822.3628,2240.3594,10.5812,89.7540,123,1);
	AddStaticVehicle(521,2876.8013,2326.8418,10.3914,267.8946,115,118);
	AddStaticVehicle(429,2842.0554,2637.0105,10.5000,182.2949,1,3);
	AddStaticVehicle(549,2494.4214,2813.9348,10.5172,316.9462,72,39);
	AddStaticVehicle(549,2327.6484,2787.7327,10.5174,179.5639,75,39);
	AddStaticVehicle(549,2142.6970,2806.6758,10.5176,89.8970,79,39);
	AddStaticVehicle(521,2139.7012,2799.2114,10.3917,229.6327,25,118);
	AddStaticVehicle(521,2104.9446,2658.1331,10.3834,82.2700,36,0);
	AddStaticVehicle(521,1914.2322,2148.2590,10.3906,267.7297,36,0);
	AddStaticVehicle(549,1904.7527,2157.4312,10.5175,183.7728,83,36);
	AddStaticVehicle(549,1532.6139,2258.0173,10.5176,359.1516,84,36);
	AddStaticVehicle(521,1534.3204,2202.8970,10.3644,4.9108,118,118);
	AddStaticVehicle(549,1613.1553,2200.2664,10.5176,89.6204,89,35);
	AddStaticVehicle(400,1552.1292,2341.7854,10.9126,274.0815,101,1);
	AddStaticVehicle(404,1637.6285,2329.8774,10.5538,89.6408,101,101);
	AddStaticVehicle(400,1357.4165,2259.7158,10.9126,269.5567,62,1);
	AddStaticVehicle(411,1281.7458,2571.6719,10.5472,270.6128,106,1);
	AddStaticVehicle(522,1305.5295,2528.3076,10.3955,88.7249,3,8);
	AddStaticVehicle(521,993.9020,2159.4194,10.3905,88.8805,74,74);
	AddStaticVehicle(415,1512.7134,787.6931,10.5921,359.5796,75,1);
	AddStaticVehicle(522,2299.5872,1469.7910,10.3815,258.4984,3,8);
	AddStaticVehicle(522,2133.6428,1012.8537,10.3789,87.1290,3,8);
	AddStaticVehicle(415,2266.7336,648.4756,11.0053,177.8517,0,1);
	AddStaticVehicle(461,2404.6636,647.9255,10.7919,183.7688,53,1);
	AddStaticVehicle(506,2628.1047,746.8704,10.5246,352.7574,3,3);
	AddStaticVehicle(549,2817.6445,928.3469,10.4470,359.5235,72,39);

	SetTimer("EndTheRound", gRoundTime, 0);
	
	return 1;
}

//---------------------------------------------------------

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if (playerid == gHunted) {
	    new name[MAX_PLAYER_NAME];
	    new string[256];
	    GetPlayerName(playerid, name, sizeof(name));
	    switch (newstate) {
	        case PLAYER_STATE_ONFOOT:
	            format(string, sizeof(string), "*** %s is now on foot", name);
	        case PLAYER_STATE_DRIVER:
	            format(string, sizeof(string), "*** %s is now driving a vehicle", name);
	        case PLAYER_STATE_PASSENGER:
	            format(string, sizeof(string), "*** %s is now a passenger in a vehicle", name);
	    }
	    if (strlen(string) > 0) {
			SendClientMessageToAll(COLOR_GREEN, string);
	    }
	}
	return 1;
}

//---------------------------------------------------------

public OnPlayerConnect(playerid)
{
	GameTextForPlayer(playerid,"~w~Manhunt: ~r~Las Venturas",2000,5);
	gActivePlayers[playerid] = 1;
	gScores[playerid] = 0;
	SetPlayerColor(playerid, COLOR_GREEN);
	if (gHunted != INVALID_PLAYER_ID) {
		new name[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(gHunted, name, sizeof(name));
		format(string, sizeof(string), "*** %s is the hunted player", name);
		SendClientMessage(playerid, COLOR_RED, string);
	}
	return 1;
}

//---------------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	SetupPlayerForClassSelection(playerid);
	return 1;
}

//---------------------------------------------------------

public OnPlayerDisconnect(playerid)
{
	gSpawnedPlayers[playerid] = 0;
	gActivePlayers[playerid] = 0;
	gScores[playerid] = 0;
	if (playerid == gHunted) { SetHuntedPlayer(INVALID_PLAYER_ID, INVALID_PLAYER_ID); }
	return 1;
}

//---------------------------------------------------------

public OnPlayerSpawn(playerid)
{
	SetPlayerColor(playerid, COLOR_GREEN);
	gSpawnedPlayers[playerid] = 1;
	SetPlayerWorldBounds(playerid, 2977.8831, 591.4855, 3101.7141, 507.4137);
	if (gHunted == INVALID_PLAYER_ID) {
		if (!gStarted) {
			new count = 0;
			for (new i = 0; i < sizeof(gSpawnedPlayers); i++) {
			    if (gSpawnedPlayers[i] == 1) {
			        count++;
			    }
			}
			if (count >= gMinimumPlayers) {
				gStarted = 1;
				SetHuntedPlayer(INVALID_PLAYER_ID, INVALID_PLAYER_ID); // Passing invalid_player_id chooses a random player
			} else {
				new NeededPlayers = gMinimumPlayers - count;
				new message[50];
				format(message, sizeof(message), "*** We need %d more player(s) to start manhunt!", NeededPlayers);
				SendClientMessageToAll(COLOR_RED, message);
			}
		}
		else {
		    SetHuntedPlayer(playerid, INVALID_PLAYER_ID);
		}
	}
	SetPlayerRandomSpawn(playerid);
	return 1;
}

//---------------------------------------------------------

public SetPlayerRandomSpawn(playerid)
{
	new rand = random(sizeof(gRandomPlayerSpawns));
	SetPlayerPos(playerid, gRandomPlayerSpawns[rand][0], gRandomPlayerSpawns[rand][1], gRandomPlayerSpawns[rand][2]); // Warp the player
	return 1;
}

//---------------------------------------------------------

public SurvivalOfTheHunted() {
	gSurvivalTimer = -1;
	HuntedSurvived();
	SetHuntedPlayer(INVALID_PLAYER_ID, gHunted);
}

//---------------------------------------------------------

public HuntedSurvived() {
	new name[MAX_PLAYER_NAME];
	new string[256];
	GetPlayerName(gHunted, name, sizeof(name));
	format(string, sizeof(string), "*** %s survived the hunt!", name);
	SetPlayerColor(gHunted, COLOR_GREEN);
	gScores[gHunted] += gScoreIncreases[0];
	SetPlayerScore(gHunted, gScores[gHunted]);
	SendClientMessageToAll(COLOR_GREEN, string);
}

//---------------------------------------------------------

public SetHuntedPlayer(playerid, exclude) { // Exclude only works for random pickage!
	new name[MAX_PLAYER_NAME];
	new string[256];
	if (gSurvivalTimer > -1) {
		KillTimer(gSurvivalTimer);
		gSurvivalTimer = -1;
	}
	gHunted = INVALID_PLAYER_ID;

	if (playerid == INVALID_PLAYER_ID) {
		new spawnedids[MAX_PLAYERS];
		new count = 0;
		for (new id = 0; id < sizeof(gSpawnedPlayers); id++) {
			if ((gSpawnedPlayers[id] == 1) && (id != exclude)) {
				printf("Added %d to the spawnedids, cause it's not %d", id, exclude);
				spawnedids[count] = id;
				count++;
		    }
		}
		if (count > 0) {
			gHunted = spawnedids[random(count)];
		}
		else {
		    // No people are spawned, we'll wait for the next person to spawn
		    SendClientMessageToAll(COLOR_GREEN, "*** No-one is spawned. The next person to spawn will be hunted!");
		    return 0;
		}
	}
	else {
	    gHunted = playerid;
	}
	GetPlayerName(gHunted, name, sizeof(name));
	format(string, sizeof(string), "*** The new hunted player is: %s!", name);
	SendClientMessageToAll(COLOR_RED, string);
	SetPlayerColor(gHunted, COLOR_RED);
	gSurvivalTimer = SetTimer("SurvivalOfTheHunted", gSurvivalTime, 0);
	return 1;
}

//---------------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
	gSpawnedPlayers[playerid] = 0;
	if (killerid == INVALID_PLAYER_ID) {
		if (playerid == gHunted) {
			gScores[playerid] += gScoreIncreases[1];
			SetPlayerScore(playerid, gScores[playerid]);
		}
	}
	else {
		if (playerid == gHunted) {
			gScores[playerid] += gScoreIncreases[1];
			SetPlayerScore(playerid, gScores[playerid]);
			gScores[killerid] += gScoreIncreases[2];
			SetPlayerScore(killerid, gScores[killerid]);
		}
		else {
			gScores[killerid] += gScoreIncreases[3];
			SetPlayerScore(killerid, gScores[killerid]);
		}
	}
	if (playerid == gHunted) { SetHuntedPlayer(killerid, playerid); }
	SetPlayerColor(playerid, COLOR_GREY);
	SendDeathMessage(killerid, playerid, reason);
	return 1;
}

//---------------------------------------------------------

public SetupPlayerForClassSelection(playerid)
{
	SetPlayerPos(playerid,1958.3783,1343.1572,15.3746);
	SetPlayerFacingAngle(playerid,0.0);
	SetPlayerCameraPos(playerid,1958.3783,1347.1572,16.3746);
	SetPlayerCameraLookAt(playerid,1958.3783,1343.1572,15.3746);
}

//---------------------------------------------------------

public EndTheRound() {
	new draw = false;
	new winner = INVALID_PLAYER_ID;
	for (new i=0; i<MAX_PLAYERS; i++) {
	    if (gActivePlayers[i]) {
	        if (winner == INVALID_PLAYER_ID) winner = i;
	        if (i != winner) {
		        if (gScores[i] > gScores[winner]) {
		            draw = false;
		            winner = i;
		        }
		        else if (gScores[i] == gScores[winner]) {
		            draw = true;
		        }
	        }
	    }
	}
	if (winner == INVALID_PLAYER_ID) {  } // Do nothing cause there's no players
	else if (draw) { GameTextForAll("The result was a draw!", 5000, 3); }
	else {
	    new name[MAX_PLAYER_NAME];
	    new string[256];
	    GetPlayerName(winner, name, sizeof(name));
	    format(string, sizeof(string), "%s won~n~With a score of: %d", name, gScores[winner]);
	    GameTextForAll(string, 5000, 3);
	}
	SetTimer("GameModeExitFunc", 5000, 0);
}

//---------------------------------------------------------

public GameModeExitFunc()
{
	GameModeExit();
}

