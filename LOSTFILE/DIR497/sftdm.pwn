//------------------------------------------------------------------------------
//
// San Fierro TDM. A Team Deathmtach script for SA-MP 0.1
//
//------------------------------------------------------------------------------

#include <a_samp>
#include <core>
#include <float>
//Global stuff and defines for our gamemode
static gTeam[MAX_PLAYERS]; // Tracks the team assignment for each player
new gPlayerClass[MAX_PLAYERS];
//Color Defines
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_ORANGE 0xFF9900AA
//Team Defines
#define TEAM_WORKER 0
#define TEAM_PIMP 1
#define TEAM_GOLFER 2
#define TEAM_TRIAD 3
#define TEAM_MECHANIC 4
#define TEAM_VALET 5
#define TEAM_MEDIC 6
#define TEAM_FBI 7

// Round duration
new gRoundTime = 3600000; // 60 mins
//new gRoundTime = 900000; //15 mins
//new gRoundTime = 300000; // 5 mins

//------------------------------------------------------------------------------

main()
{
	print("\n----------------------------------");
	print("  SFTDM by Cam (2006)\n");
	print("----------------------------------\n");
}

//------------------------------------------------------------------------------

public OnGameModeInit()
{
	SetGameModeText("San Fierro TDM");
	SetTeamCount(7);
	ShowNameTags(1);
	ShowPlayerMarkers(1);
	SetWorldTime(18);

	AddPlayerClass(260,-2062.5583,237.4662,35.7149,268.8936,22,272,25,40,4,1); //Worker
	AddPlayerClass(249,-2653.6443,1388.2767,7.1301,212.8453,23,272,29,270,5,1); //Pimp
	AddPlayerClass(259,-2642.2583,-274.9985,7.5393,135.0036,25,40,32,250,9,1); //Golfer
	AddPlayerClass(118,-2157.2119,649.5484,52.3672,267.0820,24,70,31,250,4,1); //Triad
	AddPlayerClass(50,-1377.4271,466.0897,7.1875,1.0348,22,272,30,300,9,1); //Mechanic
	AddPlayerClass(253,-1754.9976,958.5851,24.8828,163.2550,25,40,24,70,4,1); //Valet
	AddPlayerClass(274,-2665.4282,635.6348,14.4531,179.8403,33,40,23,272,4,1); //Medic
    AddPlayerClass(286,-1635.0077,665.8105,7.1875,264.2244,29,300,22,170,3,1); //FBI
	AddStaticVehicle(401,-2118.9319,194.8274,35.7567,2.7513,-1,-1);
	AddStaticVehicle(401,-2036.5212,305.6321,35.9090,359.8144,-1,-1);
	AddStaticVehicle(413,-2087.8369,255.6416,37.0341,357.9168,-1,-1);
	AddStaticVehicle(457,-2652.9031,-297.2605,8.0617,315.6009,-1,-1);
	AddStaticVehicle(457,-2659.7441,-289.6562,8.0920,313.6239,-1,-1);
	AddStaticVehicle(457,-2642.9949,-301.7552,8.0090,47.6567,-1,-1);
	AddStaticVehicle(421,-2681.7434,-276.2391,8.0605,44.2241,-1,-1);
	AddStaticVehicle(575,-2618.9480,1376.7870,7.7322,181.1998,-1,-1);
	AddStaticVehicle(411,-2645.5964,1376.7522,7.8935,267.8349,-1,-1);
	AddStaticVehicle(409,-2628.6924,1377.4845,7.9350,180.7913,-1,-1);
	AddStaticVehicle(409,-2633.1638,1332.7010,7.9953,269.6430,-1,-1);
	AddStaticVehicle(405,-2126.2573,650.7344,53.2421,88.8335,-1,-1);
	AddStaticVehicle(405,-2125.8604,658.0598,53.3040,92.1547,-1,-1);
	AddStaticVehicle(445,-2158.0305,657.3961,53.2440,272.5298,-1,-1);
	AddStaticVehicle(522,-2151.1257,629.7889,52.8293,180.7068,-1,-1);
	AddStaticVehicle(484,-1476.5386,700.1740,1.1248,355.3123,-1,-1);
	AddStaticVehicle(446,-1571.3143,1263.2914,1.2879,269.1020,-1,-1);
	AddStaticVehicle(446,-1720.0265,1436.3821,1.4272,3.3108,-1,-1);
	AddStaticVehicle(445,-2156.6838,942.3219,80.8784,269.6746,-1,-1);
	AddStaticVehicle(480,-2223.2629,1083.2794,80.7819,359.6700,-1,-1);
	AddStaticVehicle(444,-2517.2996,1229.3512,38.7999,209.3221,-1,-1);
	AddStaticVehicle(522,-1654.1005,1211.9901,14.2380,315.9562,-1,-1);
	AddStaticVehicle(415,-1660.4161,1213.3704,8.0209,295.4768,-1,-1);
	AddStaticVehicle(415,-1553.3494,1089.8568,7.9584,89.1789,-1,-1);
	AddStaticVehicle(420,-1497.4607,845.8477,7.9671,88.5197,-1,-1);
	AddStaticVehicle(421,-1699.4597,1035.9624,46.0932,91.6588,-1,-1);
	AddStaticVehicle(559,-1786.6871,1206.5266,25.7813,178.8742,-1,-1);
	AddStaticVehicle(559,-1703.9169,1339.6957,7.8358,133.6003,-1,-1);
	AddStaticVehicle(539,-1835.1257,1425.9342,1.5476,184.1130,-1,-1);
	AddStaticVehicle(539,-2441.2109,1414.1995,1.4429,86.1079,-1,-1);
	AddStaticVehicle(547,-2438.0117,1340.9783,8.7316,86.7979,-1,-1);
	AddStaticVehicle(411,-2166.5498,1251.0760,28.2782,1.6030,-1,-1);
	AddStaticVehicle(411,-2636.3838,932.3286,72.5378,187.1212,-1,-1);
	AddStaticVehicle(461,-2566.5906,989.6594,78.8568,358.1472,-1,-1);
	AddStaticVehicle(461,-2464.8860,896.7036,63.6223,0.6326,-1,-1);
	AddStaticVehicle(542,-2273.8679,921.3689,67.3102,359.9958,-1,-1);
	AddStaticVehicle(400,-2459.9055,786.4501,36.2643,89.8722,-1,-1);
	AddStaticVehicle(400,-2673.5830,802.1517,51.0693,0.3607,-1,-1);
	AddStaticVehicle(539,-2952.4602,495.9247,1.9517,0.4375,-1,-1);
	AddStaticVehicle(446,-2970.6746,497.2838,1.3557,4.0073,-1,1);
	AddStaticVehicle(444,-2902.7820,342.5712,6.3723,138.7612,-1,-1);
	AddStaticVehicle(444,-2876.3977,26.3173,7.2123,118.5961,-1,-1);
	AddStaticVehicle(470,-1382.4279,455.8060,7.1838,359.9849,-1,-1);
	AddStaticVehicle(470,-1439.3396,455.1034,7.1739,0.1531,-1,-1);
	AddStaticVehicle(542,-1465.0304,455.6730,7.9280,358.9676,-1,-1);
	AddStaticVehicle(571,-1677.1865,438.8195,7.4635,227.1910,-1,-1);
	AddStaticVehicle(476,-1433.3817,-504.8247,15.8794,158.2625,-1,-1);
	AddStaticVehicle(476,-1464.6495,-522.4009,15.8899,234.2019,-1,-1);
	AddStaticVehicle(593,-1354.2429,-467.9689,15.6386,162.9646,-1,-1);
	AddStaticVehicle(593,-1387.8518,-484.0513,15.6341,247.9289,-1,-1);
	AddStaticVehicle(487,-1162.1279,-460.9374,15.3257,53.8622,-1,-1);
	AddStaticVehicle(553,-1317.8910,-260.4665,16.4827,288.2876,-1,-1);
	AddStaticVehicle(553,-1362.9397,-183.5522,16.4848,308.6994,-1,-1);
	AddStaticVehicle(447,-1187.9520,26.1456,15.1604,45.3312,-1,-1);
	AddStaticVehicle(447,-1222.7996,-10.4235,15.1594,45.5780,-1,-1);
	AddStaticVehicle(475,-1872.5575,-820.7949,32.8273,90.7921,-1,-1);
	AddStaticVehicle(444,-1898.3019,-915.5814,33.3947,91.2857,-1,-1);
	AddStaticVehicle(496,-2124.4800,-929.0856,32.7397,269.1853,-1,-1);
	AddStaticVehicle(496,-2133.3015,-847.1439,32.7396,88.8312,-1,-1);
	AddStaticVehicle(516,-2134.1038,-775.5048,32.8568,91.5838,-1,-1);
	AddStaticVehicle(516,-2134.1428,-453.9576,36.1699,95.0875,-1,-1);
	AddStaticVehicle(541,-2035.6851,170.2529,29.4610,268.9087,-1,-1);
	AddStaticVehicle(500,-2219.7209,-83.2318,36.4367,2.0481,-1,-1);
	AddStaticVehicle(541,-2018.4379,-98.9675,35.7890,358.5420,-1,-1);
	AddStaticVehicle(541,-2352.0959,-126.8848,35.9374,179.5324,-1,-1);
	AddStaticVehicle(405,-2180.1277,41.8536,36.1953,269.9865,-1,-1);
	AddStaticVehicle(522,-2269.4526,69.5823,35.7279,89.6104,-1,-1);
	AddStaticVehicle(522,-2266.0090,145.0206,35.7322,92.0045,-1,-1);
	AddStaticVehicle(475,-2129.2864,787.6249,70.3666,87.1679,-1,-1);
	AddStaticVehicle(475,-2424.9958,740.8871,35.8205,177.6701,-1,-1);
	AddStaticVehicle(400,-2684.7639,636.4294,14.5454,179.2696,-1,-1);
	AddStaticVehicle(496,-2545.7666,627.5895,15.1684,89.1952,-1,-1);
	AddStaticVehicle(496,-2428.7107,514.7900,30.6451,207.9893,-1,-1);
	AddStaticVehicle(429,-2498.4822,357.5526,35.7969,58.0823,-1,-1);
	AddStaticVehicle(429,-2664.9673,268.9968,5.0156,357.6026,-1,-1);
	AddStaticVehicle(420,-2626.5276,-53.6779,5.1144,357.7703,-1,-1);
	AddStaticVehicle(434,-2718.5354,-124.4790,5.3071,269.1429,-1,-1);
	AddStaticVehicle(434,-2487.5295,-125.3075,26.5715,90.9363,-1,-1);
	AddStaticVehicle(400,-2486.0298,51.5018,27.7954,177.2178,-1,-1);
	AddStaticVehicle(400,-2574.9736,146.5981,5.4279,1.8790,-1,-1);
	AddStaticVehicle(559,-2800.0251,205.2155,7.8399,92.2606,-1,-1);
	AddStaticVehicle(549,-1741.0009,811.0599,25.5879,270.6703,-1,-1);
	AddStaticVehicle(549,-1920.7559,875.2713,36.1113,270.0973,-1,-1);
	AddStaticVehicle(500,-2040.4465,1107.7076,54.4032,89.8491,-1,-1);
	AddStaticVehicle(500,-1968.8488,465.6065,36.2766,89.3124,-1,-1);
	AddStaticVehicle(401,-1938.2876,584.4863,35.9137,1.1244,-1,-1);
	AddStaticVehicle(401,-1825.2035,-0.4858,15.8965,270.0104,-1,-1);
	AddStaticVehicle(579,-1820.0182,-175.9391,10.3323,87.9147,-1,-1);
	AddStaticVehicle(429,-1687.9076,1003.5587,18.2656,91.3972,-1,-1);
	AddStaticVehicle(439,-1704.8613,1058.0004,18.4810,182.3475,-1,-1);
	AddStaticVehicle(579,-1702.2262,1028.7677,18.5187,270.2923,-1,-1);
	AddStaticVehicle(480,-1735.9534,1016.0621,18.3580,268.5771,-1,-1);
	AddStaticVehicle(400,-2782.3508,442.1533,5.5383,57.1401,-1,-1);
	AddStaticVehicle(400,-2836.3665,865.6495,44.1470,268.7662,-1,-1);
	AddStaticVehicle(415,-2899.3823,1112.4786,27.3954,268.9744,-1,-1);
	AddStaticVehicle(516,-2654.5662,615.2198,15.2873,0.1598,-1,-1);
	AddStaticVehicle(416,-2618.7363,627.2617,15.6024,179.6464,-1,-1);
	AddStaticVehicle(401,-1968.8031,-400.9335,35.1227,88.2282,-1,-1);
	AddStaticVehicle(516,-1904.3373,-599.6174,24.4277,344.2378,-1,-1);
	AddStaticVehicle(475,-1639.3912,-567.4948,13.9482,80.1914,-1,-1);
	AddStaticVehicle(475,-1405.5500,-309.2615,13.9504,174.9827,-1,-1);
	AddStaticVehicle(475,-2132.1143,160.2086,35.1341,270.0023,-1,-1);
	AddStaticVehicle(500,-2151.4924,428.9210,35.1902,176.6156,-1,-1);
	AddStaticVehicle(500,-2304.8279,360.0154,35.2835,201.6184,-1,-1);
	AddStaticVehicle(522,-1696.7413,977.0867,17.1574,7.0263,-1,-1);
	AddStaticVehicle(429,-2641.7395,1333.0645,6.8700,356.7557,-1,-1);
	AddStaticVehicle(457,-2650.6292,-280.5106,7.0874,132.0127,-1,-1);
	AddStaticVehicle(421,-1409.6693,456.0711,7.0672,3.2988,-1,-1);
	AddStaticVehicle(487,-1681.5756,706.4234,30.7777,266.5047,-1,-1);
    AddStaticVehicle(603,-2617.2964,1349.0765,7.0217,358.1852,-1,-1); //
	AddStaticVehicle(475,-2129.8242,288.0418,34.9864,269.9582,-1,-1); //
	AddStaticVehicle(475,-2664.0950,-259.9579,6.5482,74.4868,-1,-1); //
	AddStaticVehicle(597,-1628.6875,652.5107,6.9568,0.9097,-1,-1); //
	AddStaticVehicle(597,-1616.7957,652.5980,6.9551,0.6199,-1,-1); //
	AddStaticVehicle(597,-1594.2644,672.5858,6.9564,176.7420,-1,-1); //
    AddStaticVehicle(597,-1593.5823,652.3891,6.9567,1.3142,0,1); //
	AddStaticVehicle(597,-1611.9730,673.5499,6.9567,181.6088,0,1); //
//Trains
//	AddStaticVehicle(537,-1943.3127,158.0254,27.0006,357.3614,121,1);
//	AddStaticVehicle(569,-1943.3127,158.0254,27.0006,357.3614,121,1);
//	AddStaticVehicle(569,-1943.3127,158.0254,27.0006,357.3614,121,1);
//	AddStaticVehicle(569,-1943.3127,158.0254,27.0006,357.3614,121,1);
//Pickups
	AddStaticPickup(370, 15, -2209.4707,294.1174,35.1172); // jetpack
	AddStaticPickup(370, 15, -1765.4392,-174.7473,3.5547); // jetpack
	SetTimer("GameModeExitFunc", gRoundTime, 0);
	return 1;
 }

//------------------------------------------------------------------------------

public OnPlayerConnect(playerid)
{
	GameTextForPlayer(playerid,"San Fierro: ~r~TDM",2500,5);
	GivePlayerMoney(playerid, 1000);
	SetPlayerColor(playerid, COLOR_GREY); // Set the player's color to inactive
	return 1;
}

//------------------------------------------------------------------------------

public OnPlayerSpawn(playerid)
{
	SetPlayerInterior(playerid,0);
	if(gTeam[playerid] == TEAM_WORKER) {
	SetPlayerColor(playerid,COLOR_GREEN); // Green
		}
	else if(gTeam[playerid] == TEAM_PIMP) {
	SetPlayerColor(playerid,COLOR_RED); // Red
		}
	else if(gTeam[playerid] == TEAM_GOLFER) {
	SetPlayerColor(playerid,COLOR_YELLOW); // Yellow
		}
	else if(gTeam[playerid] == TEAM_TRIAD) {
	SetPlayerColor(playerid,COLOR_PINK); // Pink
		}
	else if(gTeam[playerid] == TEAM_MECHANIC) {
	SetPlayerColor(playerid,COLOR_BLUE); // Blue
		}
	else if(gTeam[playerid] == TEAM_VALET) {
	SetPlayerColor(playerid,COLOR_LIGHTBLUE); // Light Blue
		}
	else if(gTeam[playerid] == TEAM_MEDIC) {
	SetPlayerColor(playerid,COLOR_DARKRED); // Dark Red
		}
	else if(gTeam[playerid] == TEAM_FBI) {
	SetPlayerColor(playerid,COLOR_ORANGE); // Orange
	}
	return 1;
}

//------------------------------------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid == INVALID_PLAYER_ID) {
        SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
	} else {
        if(gTeam[killerid] != gTeam[playerid]) {
	    	// Valid kill
	    	SendDeathMessage(killerid,playerid,reason);
			SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
			GivePlayerMoney(killerid, 1000);
}
		else {
			//Team Killer!
		new warning[256];
		format(warning, sizeof(warning), "Be careful! You have been punished for teamkilling.");
		SendClientMessage(killerid, 0xFFFF00AA, warning);
		SendDeathMessage(killerid,playerid,reason);
		GivePlayerMoney(killerid, -1000);
		SetPlayerScore(killerid, GetPlayerScore(killerid) - 1);
}
	}
 	return 1;
}

//------------------------------------------------------------------------------

public SetupPlayerForClassSelection(playerid)
{
	SetPlayerInterior(playerid,14);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerFacingAngle(playerid, 90.0);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1003.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
}

//------------------------------------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerClass(playerid, classid);
	SetupPlayerForClassSelection(playerid);
	gPlayerClass[playerid] = classid;
	switch (classid) {
	    case 0:
	        {
				GameTextForPlayer(playerid, "~g~Worker", 500, 3);
			}
		case 1:
		    {
				GameTextForPlayer(playerid, "~g~Pimp", 500, 3);
			}
		case 2:
	        {
				GameTextForPlayer(playerid, "~g~Golfer", 500, 3);
			}
		case 3:
	        {
				GameTextForPlayer(playerid, "~g~Triad", 500, 3);
			}
		case 4:
	        {
				GameTextForPlayer(playerid, "~g~Mechanic", 500, 3);
			}
		case 5:
	        {
				GameTextForPlayer(playerid, "~g~Valet", 500, 3);
			}
		case 6:
	        {
				GameTextForPlayer(playerid, "~g~Medic", 500, 3);
			}
		case 7:
	        {
				GameTextForPlayer(playerid, "~g~FBI", 500, 3);
	}
}
	return 1;
}

//------------------------------------------------------------------------------

public GameModeExitFunc()
 {
	GameModeExit();
	return 1;
 }

//------------------------------------------------------------------------------

SetPlayerClass(playerid, classid) {
	if(classid == 0) {
	gTeam[playerid] = TEAM_WORKER;
	} else if(classid == 1) {
	gTeam[playerid] = TEAM_PIMP;
	} else if(classid == 2) {
	gTeam[playerid] = TEAM_GOLFER;
	} else if(classid == 3) {
	gTeam[playerid] = TEAM_TRIAD;
	} else if(classid == 4) {
	gTeam[playerid] = TEAM_MECHANIC;
	} else if(classid == 5) {
 	gTeam[playerid] = TEAM_VALET;
	} else if(classid == 6) {
 	gTeam[playerid] = TEAM_MEDIC;
 	} else if(classid == 7) {
 	gTeam[playerid] = TEAM_FBI;
	}
}

//------------------------------------------------------------------------------
