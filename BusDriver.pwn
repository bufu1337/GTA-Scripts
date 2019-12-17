/*
[==============================================================================]

						BusDriver by Lurk
						  for game mode
						Life in Los Santos
							 © 2014

[==============================================================================]
*/

#include "a_samp"

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define MAX_PLAYERS_EX 100

enum PLAYER_INFO{
	Jobs
}

enum MISE_INFO{
	SecurityMission,
	BusMission,
	BusStop,
	BusStopTime,
	BusStopTimeFail
}

new Text:Subtitles[MAX_PLAYERS_EX];
new Player[MAX_PLAYERS_EX][PLAYER_INFO];
new Mise[MAX_PLAYERS_EX][MISE_INFO];

public OnGameModeInit()
{
	SetTimer("UpdatePlayer",1000,1);
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(PRESSED( KEY_YES )){
		if(GetVehicleModel(vehicleid) == 437 || GetVehicleModel(vehicleid) == 431){ //bus
			if(Player[playerid][Jobs] != 1){
				Player[playerid][Jobs] = 1; Mise[playerid][BusMission] = 999;
				BusMissions(playerid);
			}
		}
	}
	return 0;
}
public OnPlayerConnect(playerid){
	Subtitles[playerid] = TextDrawCreate(351,375," ");
	TextDrawLetterSize(Subtitles[playerid],0.5,1.700000);
	TextDrawAlignment(Subtitles[playerid],2);
	TextDrawFont(Subtitles[playerid],1);
	TextDrawSetOutline(Subtitles[playerid],1);
	return 1;
}
public OnPlayerEnterCheckpoint(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerConnected(playerid)){
	    if(GetVehicleModel(vehicleid) == 437 || GetVehicleModel(vehicleid) == 431){
	        if(Player[playerid][Jobs] == 1){
				if(Mise[playerid][BusMission] != 999){
					if(IsPlayerInSphere(playerid,361.7982,-1527.4463,33.0697,5) ||
					IsPlayerInSphere(playerid,535.0513,-1262.2404,16.3687,5) ||
					IsPlayerInSphere(playerid,626.7946,-1636.8909,16.0026,5) ||
					IsPlayerInSphere(playerid,770.7590,-1676.8026,12.9227,5) ||
					IsPlayerInSphere(playerid,796.7376,-1472.4398,13.3828,5) ||
					IsPlayerInSphere(playerid,886.7276,-997.1920,35.92730,5) ||
					IsPlayerInSphere(playerid,1030.4622,-1152.1044,23.6563,5) ||
					IsPlayerInSphere(playerid,1207.4020,-948.4581,42.7275,5) ||
					IsPlayerInSphere(playerid,1414.8257,-1158.7787,23.6563,5) ||
					IsPlayerInSphere(playerid,1712.4600,-1274.5700,13.3800,5) ||
					IsPlayerInSphere(playerid,1933.5078,-1044.9818,23.9135,5) ||
					IsPlayerInSphere(playerid,2268.4385,-1192.2931,24.8130,5) ||
					IsPlayerInSphere(playerid,2317.0918,-1386.5325,23.8715,5) ||
					IsPlayerInSphere(playerid,2420.4346,-1259.8356,23.8316,5) ||
					IsPlayerInSphere(playerid,2508.8904,-1414.6725,28.3594,5) ||
					IsPlayerInSphere(playerid,2740.5342,-1460.7323,30.2813,5) ||
					IsPlayerInSphere(playerid,2795.3704,-1380.3308,21.2550,5) ||
					IsPlayerInSphere(playerid,2771.5024,-1654.8423,11.6193,5) ||
					IsPlayerInSphere(playerid,2479.2590,-1729.6877,13.3828,5) ||
					IsPlayerInSphere(playerid,2450.0835,-1934.4447,13.3361,5) ||
					IsPlayerInSphere(playerid,2711.8206,-2026.3109,13.3270,5) ||
					IsPlayerInSphere(playerid,2223.9805,-2136.5171,13.3324,5) ||
					IsPlayerInSphere(playerid,1995.4023,-2163.7217,13.3828,5) ||
					IsPlayerInSphere(playerid,1825.7169,-2083.2720,13.3828,5) ||
					IsPlayerInSphere(playerid,1964.0333,-2001.6047,13.3828,5) ||
					IsPlayerInSphere(playerid,1824.5422,-1884.4218,13.3277,5) ||
					IsPlayerInSphere(playerid,2053.2000,-1815.0000,13.3800,5) ||
					IsPlayerInSphere(playerid,1823.6591,-1649.7051,13.3828,5) ||
					IsPlayerInSphere(playerid,2107.2432,-1714.2798,13.3892,5) ||
					IsPlayerInSphere(playerid,2007.6346,-1457.7531,13.3906,5) ||
					IsPlayerInSphere(playerid,1741.2539,-1596.0043,13.3817,5) ||
					IsPlayerInSphere(playerid,1526.8031,-1672.5814,13.3828,5) ||
					IsPlayerInSphere(playerid,1458.7119,-1869.5370,13.3906,5) ||
					IsPlayerInSphere(playerid,1182.7495,-1816.8263,13.3984,5) ||
					IsPlayerInSphere(playerid,1208.2617,-1350.3226,13.4014,5) ||
					IsPlayerInSphere(playerid,1003.3614,-1317.4762,13.3906,5) ||
					IsPlayerInSphere(playerid,508.0580,-1662.4474,18.9118,5)) {
					    DisablePlayerCheckpoint(playerid);
						Mise[playerid][BusStop] = 1;
						ShowInfo(playerid,"Wait at the bus stop");
	        		}
				}
			}
		}
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(newstate == PLAYER_STATE_DRIVER){
	    if(GetVehicleModel(vehicleid) == 437 || GetVehicleModel(vehicleid) == 431){ //bus
	        if(Player[playerid][Jobs] != 1){
	            ShowInfo(playerid,"Press ~y~~k~~CONVERSATION_YES~~w~ for employed bus driver");
	        }else BusMissions(playerid);
	    }
	}
	if(newstate == PLAYER_STATE_ONFOOT){
        if(GetVehicleModel(vehicleid) == 437 &&  Player[playerid][Jobs] == 1 && Mise[playerid][BusMission] != 999 || GetVehicleModel(vehicleid) == 431 && Player[playerid][Jobs] == 1 && Mise[playerid][BusMission] != 999){
			Mise[playerid][BusMission] = 999; DisablePlayerCheckpoint(playerid);
		}
	}
	return 1;
}

forward UpdatePlayer(playerid);
public UpdatePlayer(playerid){
	new vehicleid = GetPlayerVehicleID(playerid);
	if(Mise[playerid][BusStop] == 1 && Mise[playerid][BusMission] != 999 && Player[playerid][Jobs] == 1 && GetVehicleModel(vehicleid) == 437 || Mise[playerid][BusStop] == 1 && Mise[playerid][BusMission] != 999 && Player[playerid][Jobs] == 1 && GetVehicleModel(vehicleid) == 431){
		if(IsPlayerInSphere(playerid,361.7982,-1527.4463,33.0697,5) ||
			IsPlayerInSphere(playerid,535.0513,-1262.2404,16.3687,5) ||
			IsPlayerInSphere(playerid,626.7946,-1636.8909,16.0026,5) ||
			IsPlayerInSphere(playerid,770.7590,-1676.8026,12.9227,5) ||
			IsPlayerInSphere(playerid,796.7376,-1472.4398,13.3828,5) ||
			IsPlayerInSphere(playerid,886.7276,-997.1920,35.92730,5) ||
			IsPlayerInSphere(playerid,1030.4622,-1152.1044,23.6563,5) ||
			IsPlayerInSphere(playerid,1207.4020,-948.4581,42.7275,5) ||
			IsPlayerInSphere(playerid,1414.8257,-1158.7787,23.6563,5) ||
			IsPlayerInSphere(playerid,1712.4600,-1274.5700,13.3800,5) ||
			IsPlayerInSphere(playerid,1933.5078,-1044.9818,23.9135,5) ||
			IsPlayerInSphere(playerid,2268.4385,-1192.2931,24.8130,5) ||
			IsPlayerInSphere(playerid,2317.0918,-1386.5325,23.8715,5) ||
			IsPlayerInSphere(playerid,2420.4346,-1259.8356,23.8316,5) ||
			IsPlayerInSphere(playerid,2508.8904,-1414.6725,28.3594,5) ||
			IsPlayerInSphere(playerid,2740.5342,-1460.7323,30.2813,5) ||
			IsPlayerInSphere(playerid,2795.3704,-1380.3308,21.2550,5) ||
			IsPlayerInSphere(playerid,2771.5024,-1654.8423,11.6193,5) ||
			IsPlayerInSphere(playerid,2479.2590,-1729.6877,13.3828,5) ||
			IsPlayerInSphere(playerid,2450.0835,-1934.4447,13.3361,5) ||
			IsPlayerInSphere(playerid,2711.8206,-2026.3109,13.3270,5) ||
			IsPlayerInSphere(playerid,2223.9805,-2136.5171,13.3324,5) ||
			IsPlayerInSphere(playerid,1995.4023,-2163.7217,13.3828,5) ||
			IsPlayerInSphere(playerid,1825.7169,-2083.2720,13.3828,5) ||
			IsPlayerInSphere(playerid,1964.0333,-2001.6047,13.3828,5) ||
			IsPlayerInSphere(playerid,1824.5422,-1884.4218,13.3277,5) ||
			IsPlayerInSphere(playerid,2053.2000,-1815.0000,13.3800,5) ||
			IsPlayerInSphere(playerid,1823.6591,-1649.7051,13.3828,5) ||
			IsPlayerInSphere(playerid,2107.2432,-1714.2798,13.3892,5) ||
			IsPlayerInSphere(playerid,2007.6346,-1457.7531,13.3906,5) ||
			IsPlayerInSphere(playerid,1741.2539,-1596.0043,13.3817,5) ||
			IsPlayerInSphere(playerid,1526.8031,-1672.5814,13.3828,5) ||
			IsPlayerInSphere(playerid,1458.7119,-1869.5370,13.3906,5) ||
			IsPlayerInSphere(playerid,1182.7495,-1816.8263,13.3984,5) ||
			IsPlayerInSphere(playerid,1208.2617,-1350.3226,13.4014,5) ||
			IsPlayerInSphere(playerid,1003.3614,-1317.4762,13.3906,5) ||
			IsPlayerInSphere(playerid,508.0580,-1662.4474,18.9118,5)) {
		    Mise[playerid][BusStopTime] +=1;
		    if(Mise[playerid][BusStopTime] == 10){
		        HideInfo(playerid);
			    Mise[playerid][BusStop] = 0;
			    Mise[playerid][BusStopTime] = 0;
			    Mise[playerid][BusMission] += 1;
				BusMissions(playerid);
			}
		}else{
		    ShowInfo(playerid,"Let's go back to the bus stop");
		    Mise[playerid][BusStopTime] = 0;
		    Mise[playerid][BusStopTimeFail] += 1;
		    if(Mise[playerid][BusStopTimeFail] == 10){
			    Mise[playerid][BusMission] += 1;
			    Mise[playerid][BusStop] = 0;
			    Mise[playerid][BusStopTime] = 0;
				BusMissions(playerid);
			}
		}
	}
	return 1;
}

forward BusMissions(playerid);
public BusMissions(playerid){
	new vehicleid = GetPlayerVehicleID(playerid);
	if(Player[playerid][Jobs] == 1 && GetVehicleModel(vehicleid) == 437 || Player[playerid][Jobs] == 1 && GetVehicleModel(vehicleid) == 431){
		if(Mise[playerid][BusMission] == 999){
			switch(random(37)){
			    case 0:{ SetPlayerCheckpoint(playerid,361.7982,-1527.4463,33.069700,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Rodeo"); 				Mise[playerid][BusMission] = 0;}
			    case 1:{ SetPlayerCheckpoint(playerid,535.0513,-1262.2404,16.368700,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Rodeo"); 				Mise[playerid][BusMission] = 1;}
			    case 2:{ SetPlayerCheckpoint(playerid,626.7946,-1636.8909,16.002600,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Rodeo"); 				Mise[playerid][BusMission] = 2;}
			    case 3:{ SetPlayerCheckpoint(playerid,770.7590,-1676.8026,12.922700,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Marina"); 				Mise[playerid][BusMission] = 3;}
			    case 4:{ SetPlayerCheckpoint(playerid,796.7376,-1472.4398,13.382800,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Marina"); 				Mise[playerid][BusMission] = 4;}
			    case 5:{ SetPlayerCheckpoint(playerid,886.7276,-997.1920,35.9273000,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Vinewood"); 				Mise[playerid][BusMission] = 5;}
			    case 6:{ SetPlayerCheckpoint(playerid,1030.4622,-1152.1044,23.65600,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Market"); 				Mise[playerid][BusMission] = 6;}
			    case 7:{ SetPlayerCheckpoint(playerid,1207.4020,-948.4581,42.727500,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Temple"); 				Mise[playerid][BusMission] = 7;}
			    case 8:{ SetPlayerCheckpoint(playerid,1414.8257,-1158.7787,23.65630,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Downtown Los Santos"); 	Mise[playerid][BusMission] = 8;}
			    case 9:{ SetPlayerCheckpoint(playerid,1712.4600,-1274.5700,13.38000,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Downtown Los Santos"); 	Mise[playerid][BusMission] = 9;}
			    case 10:{ SetPlayerCheckpoint(playerid,1933.5078,-1044.9818,23.9135,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Glen Park"); 			Mise[playerid][BusMission] = 10;}
			    case 11:{ SetPlayerCheckpoint(playerid,2268.4385,-1192.2931,24.8130,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Jefferson"); 			Mise[playerid][BusMission] = 11;}
			    case 12:{ SetPlayerCheckpoint(playerid,2317.0918,-1386.5325,23.8715,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area East Los Santos"); 		Mise[playerid][BusMission] = 12;}
			    case 13:{ SetPlayerCheckpoint(playerid,2420.4346,-1259.8356,23.8316,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area East Los Santos"); 		Mise[playerid][BusMission] = 13;}
			    case 14:{ SetPlayerCheckpoint(playerid,2508.8904,-1414.6725,28.3594,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area East Los Santos"); 		Mise[playerid][BusMission] = 14;}
			    case 15:{ SetPlayerCheckpoint(playerid,2740.5342,-1460.7323,30.2813,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area East Beach"); 			Mise[playerid][BusMission] = 15;}
			    case 16:{ SetPlayerCheckpoint(playerid,2795.3704,-1380.3308,21.2550,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area East Beach"); 			Mise[playerid][BusMission] = 16;}
			    case 17:{ SetPlayerCheckpoint(playerid,2771.5024,-1654.8423,11.6193,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Ganton"); 				Mise[playerid][BusMission] = 17;}
			    case 18:{ SetPlayerCheckpoint(playerid,2479.2590,-1729.6877,13.3828,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Willowfield"); 			Mise[playerid][BusMission] = 18;}
			    case 19:{ SetPlayerCheckpoint(playerid,2450.0835,-1934.4447,13.3361,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Playa Del Seville"); 	Mise[playerid][BusMission] = 19;}
			    case 20:{ SetPlayerCheckpoint(playerid,2711.8206,-2026.3109,13.3270,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Ocean Docks"); 			Mise[playerid][BusMission] = 20;}
			    case 21:{ SetPlayerCheckpoint(playerid,2223.9805,-2136.5171,13.3324,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Willowfield"); 			Mise[playerid][BusMission] = 21;}
			    case 22:{ SetPlayerCheckpoint(playerid,1995.4023,-2163.7217,13.3828,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area El Corona"); 			Mise[playerid][BusMission] = 22;}
			    case 23:{ SetPlayerCheckpoint(playerid,1825.7169,-2083.2720,13.3828,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area El Corona"); 			Mise[playerid][BusMission] = 23;}
			    case 24:{ SetPlayerCheckpoint(playerid,1964.0333,-2001.6047,13.3828,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area El Corona");				Mise[playerid][BusMission] = 24;}
			    case 25:{ SetPlayerCheckpoint(playerid,1824.5422,-1884.4218,13.3277,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Willowfield"); 			Mise[playerid][BusMission] = 25;}
			    case 26:{ SetPlayerCheckpoint(playerid,1823.6591,-1649.7051,13.3828,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Idlewood"); 				Mise[playerid][BusMission] = 26;}
			    case 27:{ SetPlayerCheckpoint(playerid,2053.2000,-1815.0000,13.3800,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Idlewood"); 				Mise[playerid][BusMission] = 27;}
			    case 28:{ SetPlayerCheckpoint(playerid,2107.2432,-1714.2798,13.3892,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Idlewood"); 				Mise[playerid][BusMission] = 28;}
			    case 29:{ SetPlayerCheckpoint(playerid,2007.6346,-1457.7531,13.3906,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Commerce"); 				Mise[playerid][BusMission] = 29;}
			    case 30:{ SetPlayerCheckpoint(playerid,1741.2539,-1596.0043,13.3817,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Pershing Square"); 		Mise[playerid][BusMission] = 30;}
			    case 31:{ SetPlayerCheckpoint(playerid,1526.8031,-1672.5814,13.3828,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Verdant Bluffs"); 		Mise[playerid][BusMission] = 31;}
			    case 32:{ SetPlayerCheckpoint(playerid,1458.7119,-1869.5370,13.3906,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Commerce"); 				Mise[playerid][BusMission] = 32;}
			    case 33:{ SetPlayerCheckpoint(playerid,1182.7495,-1816.8263,13.3984,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Conference Center"); 	Mise[playerid][BusMission] = 33;}
			    case 34:{ SetPlayerCheckpoint(playerid,1208.2617,-1350.3226,13.4014,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Market"); 				Mise[playerid][BusMission] = 34;}
			    case 35:{ SetPlayerCheckpoint(playerid,1003.3614,-1317.4762,13.3906,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Market"); 				Mise[playerid][BusMission] = 35;}
			    case 36:{ SetPlayerCheckpoint(playerid,508.0580,-1662.4474,18.9118 ,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Rodeo"); 				Mise[playerid][BusMission] = 36;}
		    }
		}
		if(Mise[playerid][BusMission] != 999){
			switch(Mise[playerid][BusMission]){
			    case 0:{ SetPlayerCheckpoint(playerid,361.7982,-1527.4463,33.069700,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Rodeo"); 				Mise[playerid][BusMission] = 0;}
			    case 1:{ SetPlayerCheckpoint(playerid,535.0513,-1262.2404,16.368700,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Rodeo"); 				Mise[playerid][BusMission] = 1;}
			    case 2:{ SetPlayerCheckpoint(playerid,626.7946,-1636.8909,16.002600,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Rodeo"); 				Mise[playerid][BusMission] = 2;}
			    case 3:{ SetPlayerCheckpoint(playerid,770.7590,-1676.8026,12.922700,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Marina"); 				Mise[playerid][BusMission] = 3;}
			    case 4:{ SetPlayerCheckpoint(playerid,796.7376,-1472.4398,13.382800,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Marina"); 				Mise[playerid][BusMission] = 4;}
			    case 5:{ SetPlayerCheckpoint(playerid,886.7276,-997.1920,35.9273000,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Vinewood"); 				Mise[playerid][BusMission] = 5;}
			    case 6:{ SetPlayerCheckpoint(playerid,1030.4622,-1152.1044,23.65600,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Market"); 				Mise[playerid][BusMission] = 6;}
			    case 7:{ SetPlayerCheckpoint(playerid,1207.4020,-948.4581,42.727500,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Temple"); 				Mise[playerid][BusMission] = 7;}
			    case 8:{ SetPlayerCheckpoint(playerid,1414.8257,-1158.7787,23.65630,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Downtown Los Santos"); 	Mise[playerid][BusMission] = 8;}
			    case 9:{ SetPlayerCheckpoint(playerid,1712.4600,-1274.5700,13.38000,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Downtown Los Santos"); 	Mise[playerid][BusMission] = 9;}
			    case 10:{ SetPlayerCheckpoint(playerid,1933.5078,-1044.9818,23.9135,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Glen Park"); 			Mise[playerid][BusMission] = 10;}
			    case 11:{ SetPlayerCheckpoint(playerid,2268.4385,-1192.2931,24.8130,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Jefferson"); 			Mise[playerid][BusMission] = 11;}
			    case 12:{ SetPlayerCheckpoint(playerid,2317.0918,-1386.5325,23.8715,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area East Los Santos"); 		Mise[playerid][BusMission] = 12;}
			    case 13:{ SetPlayerCheckpoint(playerid,2420.4346,-1259.8356,23.8316,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area East Los Santos"); 		Mise[playerid][BusMission] = 13;}
			    case 14:{ SetPlayerCheckpoint(playerid,2508.8904,-1414.6725,28.3594,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area East Los Santos"); 		Mise[playerid][BusMission] = 14;}
			    case 15:{ SetPlayerCheckpoint(playerid,2740.5342,-1460.7323,30.2813,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area East Beach"); 			Mise[playerid][BusMission] = 15;}
			    case 16:{ SetPlayerCheckpoint(playerid,2795.3704,-1380.3308,21.2550,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area East Beach"); 			Mise[playerid][BusMission] = 16;}
			    case 17:{ SetPlayerCheckpoint(playerid,2771.5024,-1654.8423,11.6193,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Ganton"); 				Mise[playerid][BusMission] = 17;}
			    case 18:{ SetPlayerCheckpoint(playerid,2479.2590,-1729.6877,13.3828,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Willowfield"); 			Mise[playerid][BusMission] = 18;}
			    case 19:{ SetPlayerCheckpoint(playerid,2450.0835,-1934.4447,13.3361,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Playa Del Seville"); 	Mise[playerid][BusMission] = 19;}
			    case 20:{ SetPlayerCheckpoint(playerid,2711.8206,-2026.3109,13.3270,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Ocean Docks"); 			Mise[playerid][BusMission] = 20;}
			    case 21:{ SetPlayerCheckpoint(playerid,2223.9805,-2136.5171,13.3324,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Willowfield"); 			Mise[playerid][BusMission] = 21;}
			    case 22:{ SetPlayerCheckpoint(playerid,1995.4023,-2163.7217,13.3828,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area El Corona"); 			Mise[playerid][BusMission] = 22;}
			    case 23:{ SetPlayerCheckpoint(playerid,1825.7169,-2083.2720,13.3828,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area El Corona"); 			Mise[playerid][BusMission] = 23;}
			    case 24:{ SetPlayerCheckpoint(playerid,1964.0333,-2001.6047,13.3828,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area El Corona");				Mise[playerid][BusMission] = 24;}
			    case 25:{ SetPlayerCheckpoint(playerid,1824.5422,-1884.4218,13.3277,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Willowfield"); 			Mise[playerid][BusMission] = 25;}
			    case 26:{ SetPlayerCheckpoint(playerid,1823.6591,-1649.7051,13.3828,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Idlewood"); 				Mise[playerid][BusMission] = 26;}
			    case 27:{ SetPlayerCheckpoint(playerid,2053.2000,-1815.0000,13.3800,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Idlewood"); 				Mise[playerid][BusMission] = 27;}
			    case 28:{ SetPlayerCheckpoint(playerid,2107.2432,-1714.2798,13.3892,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Idlewood"); 				Mise[playerid][BusMission] = 28;}
			    case 29:{ SetPlayerCheckpoint(playerid,2007.6346,-1457.7531,13.3906,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Commerce"); 				Mise[playerid][BusMission] = 29;}
			    case 30:{ SetPlayerCheckpoint(playerid,1741.2539,-1596.0043,13.3817,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Pershing Square"); 		Mise[playerid][BusMission] = 30;}
			    case 31:{ SetPlayerCheckpoint(playerid,1526.8031,-1672.5814,13.3828,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Verdant Bluffs"); 		Mise[playerid][BusMission] = 31;}
			    case 32:{ SetPlayerCheckpoint(playerid,1458.7119,-1869.5370,13.3906,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Commerce"); 				Mise[playerid][BusMission] = 32;}
			    case 33:{ SetPlayerCheckpoint(playerid,1182.7495,-1816.8263,13.3984,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Conference Center"); 	Mise[playerid][BusMission] = 33;}
			    case 34:{ SetPlayerCheckpoint(playerid,1208.2617,-1350.3226,13.4014,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Market"); 				Mise[playerid][BusMission] = 34;}
			    case 35:{ SetPlayerCheckpoint(playerid,1003.3614,-1317.4762,13.3906,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Market"); 				Mise[playerid][BusMission] = 35;}
			    case 36:{ SetPlayerCheckpoint(playerid,508.0580,-1662.4474,18.9118 ,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Rodeo"); 				Mise[playerid][BusMission] = 36;}
			    case 37:{ SetPlayerCheckpoint(playerid,361.7982,-1527.4463,33.069700,3); ShowInfo(playerid,"Go to ~r~bus stop ~w~in area Rodeo"); 				Mise[playerid][BusMission] = 0;}
		    }
		}
	}
	return 1;
}

stock ShowInfo(playerid,text[],time=5){
	new string[128];
	format(string,128,text);
	TextDrawShowForPlayer(playerid,Subtitles[playerid]);
	TextDrawSetString(Subtitles[playerid], string);
    SetTimerEx("HideInfo",time*1000,0,"i",playerid);
	return 1;
}

forward HideInfo(playerid);
public HideInfo(playerid){
	TextDrawHideForPlayer(playerid,Subtitles[playerid]);
	TextDrawSetString(Subtitles[playerid], "");
	return 1;
}

IsPlayerInSphere(playerid,Float:x,Float:y,Float:z,radius)
{
	if(GetPlayerDistanceToPointEx(playerid,x,y,z) < radius){
		return 1;
	}
	return 0;
}

GetPlayerDistanceToPointEx(playerid,Float:x,Float:y,Float:z)
{
	new Float:x1,Float:y1,Float:z1;
	new Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	tmpdis = floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2)+floatpower(floatabs(floatsub(z,z1)),2));
	return floatround(tmpdis);
}