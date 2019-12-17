#include <a_samp>
#include <dini>
#include <dudb>
#include <time>
#include <file>
#include <dutils>
#include <sinterior>
#include <float>

#define FILE_SETTINGS "settings.ini"
#define FILE_TOTALSTAT "totalstat.ini"
#define FILE_BLACKLIST "blacklist.ini"

#define MAX_POINTS 24
#define MAX_GANGS 1
#define MAX_CARS 251
#define PROP_AMOUNT 2

#define GasMax 100
#define RunOutTime 6250

#define CAR_AMOUNT 141

#define COLOR_AQUA 0x7CFC00AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x0AFF0AAA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_BRIGHTRED 0xFF0000AA
#define COLOR_INDIGO 0x4B00B0AA

#define TEAM_BALLA 0
#define TEAM_GROVE 1
#define TEAM_VAGO 2
#define TEAM_AZTEC 3
#define TEAM_TRIAD 4
#define TEAM_FIRE 5
#define TEAM_MEDIC 6
#define TEAM_COP 7
#define TEAM_CIV 8
#define TEAM_ARMY 9

#define CP_STATION1   0
#define CP_STATION2   1
#define CP_STATION3   2
#define CP_STATION4   3
#define CP_STATION5   4
#define CP_STATION6   5
#define CP_STATION7   6
#define CP_STATION8   7
#define CP_STATION9   8
#define CP_STATION10  9
#define CP_STATION11  10
#define CP_STATION12  11
#define CP_STATION13  12
#define CP_STATION14  13
#define CP_STATION15  14
#define CP_STATION16  15
#define CP_LVSTATION  16
#define CP_VMSTATION  17
#define CP_LSSTATION  18
#define CP_SFSTATION  19
#define CP_BANK 		20
#define CP_BANK_2 		21
#define CP_BANK_3 		22
#define PROP1 			23

enum pInfo
{
    pAdmin,
    pJailedby,
}


new houseid[MAX_PLAYERS];
new cttmp[256];
new tmpname[256];
new ownername[256];
new propmess[256];
new housecost[MAX_PLAYERS];
new propowned[MAX_PLAYERS];
new buyable[MAX_PLAYERS];
new playernameh[MAX_PLAYER_NAME];
new playerhouse[MAX_PLAYERS];
new Count[MAX_PLAYERS];
new cseconds,cstring[40];
new PlayerInfo[MAX_PLAYERS][pInfo];
new moneyed[MAX_PLAYERS];
new ignition[MAX_PLAYERS];
new secure[MAX_PLAYERS];
new admined[MAX_PLAYERS];
new bought[MAX_PLAYERS];
new carowned[MAX_PLAYERS];
new currentvehicle[MAX_PLAYERS];
new carcost[256];
new server[256];
new passenger[MAX_PLAYERS];
new cartemp[MAX_PLAYERS];
new gTeam[MAX_PLAYERS];
new Spawned[MAX_PLAYERS];
new tmpcar[MAX_PLAYERS];
new welcome[MAX_PLAYERS];
new frozen[MAX_PLAYERS];
new speedo[MAX_PLAYERS];
new messaged[MAX_PLAYERS];
new used[MAX_PLAYERS];
new CashScoreOld;
new tmpcar2[MAX_PLAYERS];
new aMessage[MAX_PLAYERS];
new setd[MAX_PLAYERS];
new propactive[MAX_PLAYERS];

new Float:g, Float:h, Float:l;
new Float:t, Float:u, Float:o;

new Float:PlayerRandomSpawn[9][4] = {
{2031.2622,1343.2483,10.8203,270.1700},
{2017.6318,1545.4016,10.8292,269.8567},
{1704.9874,1454.4901,10.8166,266.0967},
{2140.9788,2281.4158,10.8203,267.0366},
{2294.7498,2421.5452,10.8203,181.1824},
{2179.7900,1286.4680,10.8203,270.4599},
{2176.1526,1119.2438,12.6617,63.0313},
{2027.6475,1007.7634,10.8203,271.0866},
{2390.8379,986.6993,10.8203,46.7612}
};

forward SetPlayerRandomSpawn(playerid);

new Float:checkCoords[MAX_POINTS][4] = {
{2098.1316,901.7380,2137.7456,963.0146},
{2617.5967,1062.8710,2656.6526,1142.5109},
{501.7475,1626.7821,653.2095,1774.1093},
{-1351.2833,2638.8943,-1265.1661,2738.6450},
{-2450.3767,949.5080,-2400.8530,1069.8329},
{-1715.5112,349.5567,-1658.8451,458.3686},
{-2265.3027,-2586.3762,-2219.1868,-2558.2539},
{-1657.4102,-2763.3518,-1501.5303,-2666.7454},
{1903.7450,-1795.7990,1955.5667,-1759.5187},
{-135.2077,-1199.8291,-43.7008,-1134.7999},
{1336.7378,454.7961,1430.0760,483.9776},
{648.2494,-592.9003,670.9278,-540.8264},
{-1494.2593,1854.1290,-1449.4076,1885.2032},
{2097.0452,2708.1218,2172.7161,2762.7495},
{2187.6587,2462.8057,2215.5042,2495.0332},
{1577.7729,2182.5112,1616.5842,2242.3628},
{1222.9973,1131.6495,1696.9778,1867.5173},          //plane refuell area
{-133.6581,2370.6445,475.5992,2579.4866},
{1347.2618,-2676.1130,2164.3130,-2109.9678},
{-1821.5753,-706.3364,-957.4259,299.8364},
{-36.5483,-57.9948, -17.2655,-49.2967},     	//BANK
{-37.2183,-91.8006, -14.1099,-74.6845},      	//BANK_2
{-34.6621,-31.4095, -2.6782,-25.6232},     		//BANK_3
{2020.2234,998.9155,2036.7882,1016.8185}		//property number 1 area
};

new Float:checkpoints[MAX_POINTS][20] = {
{2109.2126,917.5845,10.8203,3.0},
{2640.1831,1103.9224,10.8203,3.0},
{611.8934,1694.7921,6.7193,3.0},
{-1327.5398,2682.9771,49.7896,3.0},
{-2413.7427,975.9317,45.0031,3.0},
{-1672.3597,414.2950,6.8866,3.0},
{-2244.1365,-2560.6294,31.6276,3.0},
{-1603.0166,-2709.3589,48.2419,3.0},
{1939.3275,-1767.6813,13.2787,3.0},
{-94.7651,-1174.8079,1.9979,3.0},
{1381.6699,462.6467,19.8540,3.0},
{657.8167,-559.6507,16.0630,3.0},
{-1478.2916,1862.8318,32.3617,3.0},
{2147.3054,2744.9377,10.5263,3.0},
{2204.9602,2480.3494,10.5278,3.0},
{1590.9493,2202.2637,10.5247,3.0},
{1561.5695,1448.6895,10.3636,10.0},
{366.4071,2535.3784,16.8363,10.0},
{1969.3317,-2303.8423,13.2547,10.0},
{-1299.7939,-26.2385,13.8556,10.0},
{-22.2549,-55.6575,1003.5469,2.5},
{-23.0664,-90.0882,1003.5469,2.5},
{-33.9593,-29.0792,1003.5573,2.5},
{2026.9135,1007.9958,10.8203,3.0}//property one checkpoint - PROP1
};

enum SavePlayerPosEnum
{
    Float:LastX,
    Float:LastY,
    Float:LastZ
}
new SavePlayerPos[MAX_PLAYERS][SavePlayerPosEnum];

new checkpointType[MAX_POINTS] = {
	CP_STATION1,
	CP_STATION2,
	CP_STATION3,
	CP_STATION4,
	CP_STATION5,
	CP_STATION6,
	CP_STATION7,
	CP_STATION8,
	CP_STATION9,
	CP_STATION10,
	CP_STATION11,
	CP_STATION12,
	CP_STATION13,
	CP_STATION14,
	CP_STATION15,
	CP_STATION16,
	CP_LVSTATION,
	CP_VMSTATION,
	CP_LSSTATION,
	CP_SFSTATION,
	CP_BANK,
	CP_BANK_2,
	CP_BANK_3,
	PROP1,
};

new Float:ta, Float:tb, Float:tc;
new playerGang[MAX_PLAYERS];
new gangBank[MAX_GANGS];
new logged[MAX_PLAYERS];
new bank[MAX_PLAYERS];
new PlayerInterior[MAX_PLAYERS];
new gPlayerClass[MAX_PLAYERS];
new carused[MAX_PLAYERS];
new Gas[CAR_AMOUNT];
new Filling[MAX_PLAYERS];
new playerCheckpoint[MAX_PLAYERS];
new reset[MAX_PLAYERS];
new ejected[MAX_PLAYERS];

main()
{
	print("\n----------------------------------");
	print("  tAxI's Freeroam with Car Saving v4.0(final)");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
    for(new c=0;c<CAR_AMOUNT;c++)
	{
	 	Gas[c] = GasMax;
 	}
	print("GameModeInit()");
	SetGameModeText("tAxI's Freeroam with Car Saving v4.0(final)");
	SetTimer("SaveData",1000,1);
    SetTimer("Settings",1000,1);
    SetTimer("checkpointUpdate",100, 1);
    SetTimer("scoreupdate",1000,1);
    SetTimer("FuelDown", RunOutTime, 1);
    SetTimer("CheckGas", 750, 1);
    SetTimer("Fill", 200, 1);
    SetTimer("ctimer",1000,true);
    SetTimer("planerefuelarea",100, 1);
    
    AddPlayerClass(102,832.2958,-1080.4476,24.2969,107.7328,0,0,0,0,0,0); //balla
    AddPlayerClass(103,832.2958,-1080.4476,24.2969,107.7328,0,0,0,0,0,0); //balla
    AddPlayerClass(104,832.2958,-1080.4476,24.2969,107.7328,0,0,0,0,0,0); //balla
    AddPlayerClass(105,2495.2207,-1687.3169,13.5152,107.7328,0,0,0,0,0,0); //grove
    AddPlayerClass(106,2495.2207,-1687.3169,13.5152,107.7328,0,0,0,0,0,0); //grove
    AddPlayerClass(107,2495.2207,-1687.3169,13.5152,107.7328,0,0,0,0,0,0); //grove
    AddPlayerClass(108,2459.0442,-949.4450,80.0800,107.7328,0,0,0,0,0,0); //vago
    AddPlayerClass(110,2459.0442,-949.4450,80.0800,107.7328,0,0,0,0,0,0); //vago
    AddPlayerClass(114,1761.7893,-1892.7225,13.5551,107.7328,0,0,0,0,0,0); //azteca
    AddPlayerClass(115,1761.7893,-1892.7225,13.5551,107.7328,0,0,0,0,0,0); //azteca
    AddPlayerClass(116,1761.7893,-1892.7225,13.5551,107.7328,0,0,0,0,0,0); //azteca
    AddPlayerClass(122,1499.2067,-937.3587,37.4407,107.7328,0,0,0,0,0,0); //Triad
    AddPlayerClass(123,1499.2067,-937.3587,37.4407,107.7328,0,0,0,0,0,0); //Triad
    AddPlayerClass(274,1499.2067,-937.3587,37.4407,107.7328,0,0,0,0,0,0); //Medic
    AddPlayerClass(275,1499.2067,-937.3587,37.4407,107.7328,0,0,0,0,0,0); //Medic
    AddPlayerClass(277,1499.2067,-937.3587,37.4407,107.7328,0,0,0,0,0,0); //Fireman
    AddPlayerClass(280,1552.5618,-1675.3375,16.1953,107.7328,0,0,0,0,0,0); //Cop
    AddPlayerClass(281,1552.5618,-1675.3375,16.1953,107.7328,0,0,0,0,0,0); //Cop
    AddPlayerClass(283,1552.5618,-1675.3375,16.1953,107.7328,0,0,0,0,0,0); //Cop
    AddPlayerClass(287,1552.5618,-1675.3375,16.1953,112.5582,0,0,0,0,0,0); //Army
    AddPlayerClass(286,1552.5618,-1675.3375,16.1953,112.5582,0,0,0,0,0,0); //Swat
	AddPlayerClass(214,1552.5618,-1675.3375,16.1953,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(215,1552.5618,-1675.3375,16.1953,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(216,1552.5618,-1675.3375,16.1953,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(251,1552.5618,-1675.3375,16.1953,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(253,1552.5618,-1675.3375,16.1953,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(254,1552.5618,-1675.3375,16.1953,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(255,1552.5618,-1675.3375,16.1953,269.1425,0,0,24,300,-1,-1);
	
	//twin prop plane - $2,500,000
	AddStaticVehicle(553,423.4869,2502.1841,17.8202,89.0666,1,8); //
	
	//Passenger Jet - $3,500,000
	AddStaticVehicle(592,1477.7163,1806.5377,12.0074,179.7712,1,1); //
	
	//private jets - $1,000,000
	AddStaticVehicle(519,1360.0583,1756.0156,11.7412,269.0888,1,1); //
	AddStaticVehicle(519,1357.5444,1714.6675,11.7392,272.2202,1,1); //
	
	//basic plane...dodo - $400,000
	AddStaticVehicle(593,325.8835,2539.8596,17.2716,180.3894,58,8); //
	AddStaticVehicle(593,291.1174,2541.4001,17.2777,181.4973,58,8); //
	AddStaticVehicle(593,1621.7692,1291.2151,11.2733,134.9260,58,8); //
	AddStaticVehicle(593,1627.8450,1258.3723,11.2710,89.9188,58,8); //
	
	//monstertrucks - $100,000
	AddStaticVehicle(444,420.4435,2530.6880,16.9836,182.9841,1,3); //
	AddStaticVehicle(444,429.5020,2533.3752,16.8653,177.6943,1,3); //
	AddStaticVehicle(557,307.8141,2535.6982,17.1916,180.2179,1,1); //
	AddStaticVehicle(556,-384.5375,2191.6282,42.7897,284.9403,1,1); //
	AddStaticVehicle(556,-373.6553,2268.8379,42.5869,94.9769,1,1); //13
	
	//militery - armed - $2,000,000
	AddStaticVehicle(425,372.8860,1907.0579,18.2127,89.8701,43,0); //
	AddStaticVehicle(476,1283.0006,1324.8849,9.5332,275.0468,7,6);
	AddStaticVehicle(476,1283.5107,1361.3171,9.5382,271.1684,1,6);
	AddStaticVehicle(476,1283.6847,1386.5137,11.5300,272.1003,89,91);
	AddStaticVehicle(476,1288.0499,1403.6605,11.5295,243.5028,119,117);
	AddStaticVehicle(520,279.2560,1957.0870,18.3605,271.5373,0,0); //19
	
	//millitary truck - $100,000
	AddStaticVehicle(433,278.4932,2017.9794,18.0773,301.3855,43,0); //20
	AddStaticVehicle(433,276.5954,2030.9923,18.0772,244.9951,43,0); //21
	
	//large helicopter - $750,000
	AddStaticVehicle(548,374.5181,1941.1318,19.2787,91.4614,1,1); //
	AddStaticVehicle(548,364.7947,1981.3463,19.2466,90.8673,1,1); //
	AddStaticVehicle(417,1284.6808,1521.0535,10.9101,273.2997,0,0); //
	AddStaticVehicle(417,1285.1741,1553.1807,10.9067,270.2105,0,0); //
	AddStaticVehicle(563,1348.2197,1623.1259,11.5257,269.6316,1,6); //
	AddStaticVehicle(563,1356.4004,1582.4369,11.5257,267.4544,1,6); //27
	
	//small helicopter - $450,000
	AddStaticVehicle(487,2093.2754,2414.9421,74.7556,89.0247,26,57);
	AddStaticVehicle(487,1614.7153,1548.7513,11.2749,347.1516,58,8);
	AddStaticVehicle(487,1647.7902,1538.9934,11.2433,51.8071,0,8);
	AddStaticVehicle(487,1608.3851,1630.7268,11.2840,174.5517,58,8);//31
	
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
	AddStaticVehicle(506,2166.6963,2741.0413,10.5245,89.7816,52,5);
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
	AddStaticVehicle(404,1553.3696,1020.2884,10.5532,270.6825,119,5);
	AddStaticVehicle(400,1380.8304,1159.1782,10.9128,355.7117,123,1);
	AddStaticVehicle(418,1383.4630,1035.0420,10.9131,91.2515,117,227);
	AddStaticVehicle(404,1445.4526,974.2831,10.5534,1.6213,109,100);
	AddStaticVehicle(400,1704.2365,940.1490,10.9127,91.9048,113,1);
	AddStaticVehicle(404,1658.5463,1028.5432,10.5533,359.8419,101,1);
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
	AddStaticVehicle(470,276.6493,1981.2705,17.6349,291.1576,0,0); //
	AddStaticVehicle(470,278.8036,1997.4153,17.6370,241.6500,0,0); //
	AddStaticVehicle(470,221.4106,1855.7897,12.9794,1.5015,0,0); //
	AddStaticVehicle(470,214.1406,1854.3761,12.8916,0.7010,0,0); //
	AddStaticVehicle(522,1282.0393,1287.6530,10.3828,268.2269,1,2); //
	AddStaticVehicle(522,1281.8605,1290.7844,10.3923,268.2268,3,2); //
	AddStaticVehicle(522,1281.9668,1294.2249,10.3923,268.2269,5,8); //
	AddStaticVehicle(522,1282.0627,1297.3253,10.3923,268.2269,1,8); //
	AddStaticVehicle(522,1282.1558,1300.3281,10.3923,268.2270,3,1); //
	AddStaticVehicle(522,1282.2622,1303.7687,10.3923,268.2270,4,8); //
	AddStaticVehicle(522,1282.3561,1306.7932,10.3923,268.2270,9,4); //
	AddStaticVehicle(568,-371.2209,2234.9131,42.3500,104.7362,9,39); //
	AddStaticVehicle(568,-436.0441,2222.0293,42.2475,357.2560,9,39); //
	AddStaticVehicle(568,-393.4612,2221.3335,42.2957,282.7452,9,39); //
	
	for(new i=1;i<CAR_AMOUNT;i++) {
    	if(i == 1) {
 			carcost[i] = 2500000;
		}
		if(i == 2) {
 			carcost[i] = 3500000;
		}
		if(i >= 3) {
 			carcost[i] = 1000000;
		}
		if(i >= 5) {
 			carcost[i] = 400000;
		}
		if(i >= 9) {
 			carcost[i] = 100000;
		}
		if(i >= 14) {
 			carcost[i] = 2000000;
		}
		if(i >= 20) {
 			carcost[i] = 100000;
		}
		if(i >= 22) {
 			carcost[i] = 750000;
		}
		if(i >= 28) {
 			carcost[i] = 450000;
		}
		if(i >= 32) {
 			carcost[i] = 50000;
		}
		format(tmpname,sizeof(tmpname),"%d",i);
		if (!dini_Exists(tmpname)) {
    	    	dini_Create(tmpname);
				dini_Set(tmpname, "owner", "server");
				dini_IntSet(tmpname, "carcost", carcost[i]);
				dini_IntSet(tmpname, "carlock", 0);
				dini_IntSet(tmpname, "bought", 0);
				dini_IntSet(tmpname, "secure", 0);
				dini_IntSet(tmpname, "asecure", 0);
				dini_IntSet(tmpname, "used", 1);
				GetVehiclePos(i,t,u,o);
        		dini_IntSet(tmpname, "sx", floatround(t));
        		dini_IntSet(tmpname, "sy", floatround(u));
        		dini_IntSet(tmpname, "sz", floatround(o));
    	}
	}
	for(new tempa=1;tempa<PROP_AMOUNT;tempa++) {
    	if(tempa == 16 || tempa == 29 || tempa == 30) {
 			housecost[tempa] = 60000;
		}
		if(tempa == 1 || tempa == 21 || tempa == 10) {
 			housecost[tempa] = 80000;
		}
		if(tempa == 23 || tempa == 27) {
 			housecost[tempa] = 70000;
		}
		if(tempa == 2 || tempa == 5 || tempa == 13 || tempa == 20 || tempa == 22) {
 			housecost[tempa] = 110000;
		}
		if(tempa == 11) {
 			housecost[tempa] = 120000;
		}
		if(tempa == 3 || tempa == 4 || tempa == 9) {
 			housecost[tempa] = 160000;
		}
		if(tempa == 7 || tempa == 18 || tempa == 28) {
 			housecost[tempa] = 190000;
		}
		if(tempa == 8 || tempa == 17 || tempa == 24 || tempa == 25 || tempa == 31) {
 			housecost[tempa] = 220000;
		}
		if(tempa == 14 || tempa == 15) {
 			housecost[tempa] = 280000;
		}
		if(tempa == 26 || tempa == 19) {
 			housecost[tempa] = 320000;
		}
		if(tempa == 12) {
 			housecost[tempa] = 350000;
		}
		if(tempa == 6) {
 			housecost[tempa] = 425000;
		}
		format(tmpname,sizeof(tmpname),"PROP%d",tempa);
		if (!dini_Exists(tmpname)) {
    	    	dini_Create(tmpname);
				dini_Set(tmpname, "owner", "server");
				dini_IntSet(tmpname, "housecost", housecost[tempa]);
				dini_IntSet(tmpname, "bought", 0);
				dini_IntSet(tmpname, "idnumber", tempa);
    	}
	}
	return 1;
}
		


public SetPlayerRandomSpawn(playerid)
{
	new rand = random(sizeof(PlayerRandomSpawn));
	SetPlayerPos(playerid, PlayerRandomSpawn[rand][0], PlayerRandomSpawn[rand][1], PlayerRandomSpawn[rand][2]);
	SetPlayerFacingAngle(playerid,PlayerRandomSpawn[rand][3]);
	return 1;
}


public SetupPlayerForClassSelection(playerid)
{
	SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
	SetPlayerFacingAngle(playerid, 89.8567);
	SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
	SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
  SetPlayerClass(playerid, classid);
  SetupPlayerForClassSelection(playerid);
  gPlayerClass[playerid] = classid;
  switch (classid) {
    case 0: {
    GameTextForPlayer(playerid,"~p~Balla",700,6);
	}
    case 1: {
    GameTextForPlayer(playerid,"~p~Balla",700,6);
	}
    case 2: {
    GameTextForPlayer(playerid,"~p~Balla",700,6);
	}
    case 3: {
    GameTextForPlayer(playerid,"~g~Grove",700,6);
	}
    case 4: {
    GameTextForPlayer(playerid,"~g~Grove",700,6);
	}
    case 5: {
    GameTextForPlayer(playerid,"~g~Grove",700,6);
	}
    case 6: {
    GameTextForPlayer(playerid,"~y~Vago",700,6);
	}
    case 7: {
    GameTextForPlayer(playerid,"~y~Vago",700,6);
    }
    case 8: {
    GameTextForPlayer(playerid,"~h~~b~Azteca",700,6);
    }
    case 9: {
    GameTextForPlayer(playerid,"~h~~b~Azteca",700,6);
    }
    case 10: {
    GameTextForPlayer(playerid,"~h~~b~Azteca",700,6);
    }
    case 11: {
    GameTextForPlayer(playerid,"~r~Triad",700,6);
    }
    case 12: {
    GameTextForPlayer(playerid,"~r~Triad",700,6);
    }
    case 13: {
    GameTextForPlayer(playerid,"~b~Medic",700,6);
    }
    case 14: {
    GameTextForPlayer(playerid,"~b~Medic",700,6);
    }
    case 15: {
    GameTextForPlayer(playerid,"~r~Fireman",700,6);
    }
    case 16: {
    GameTextForPlayer(playerid,"~b~Cop",700,6);
    }
    case 17: {
    GameTextForPlayer(playerid,"~b~Cop",700,6);
    }
    case 18: {
    GameTextForPlayer(playerid,"~b~Cop",700,6);
    }
    case 19: {
    GameTextForPlayer(playerid,"~g~Army",700,6);
    }
    case 20: {
    GameTextForPlayer(playerid,"~b~Swat",700,6);
    }
    case 21: {
    GameTextForPlayer(playerid,"~w~Civilian",700,6);
    }
    case 22: {
    GameTextForPlayer(playerid,"~w~Civilian",700,6);
    }
    case 23: {
    GameTextForPlayer(playerid,"~w~Civilian",700,6);
    }
    case 24: {
    GameTextForPlayer(playerid,"~w~Civilian",700,6);
    }
    case 25: {
    GameTextForPlayer(playerid,"~w~Civilian",700,6);
    }
    case 26: {
    GameTextForPlayer(playerid,"~w~Civilian",700,6);
    }
    case 27: {
    GameTextForPlayer(playerid,"~w~Civilian",700,6);
    }
  }
	return 1;
}

SetPlayerClass(playerid, classid)
{
  switch(classid) {

    case 0: {
    gTeam[playerid] = TEAM_BALLA;
	}
    case 1: {
    gTeam[playerid] = TEAM_BALLA;
	}
    case 2: {
    gTeam[playerid] = TEAM_BALLA;
	}
    case 3: {
    gTeam[playerid] = TEAM_GROVE;
	}
    case 4: {
    gTeam[playerid] = TEAM_GROVE;
	}
    case 5: {
    gTeam[playerid] = TEAM_GROVE;
	}
    case 6: {
    gTeam[playerid] = TEAM_VAGO;
	}
    case 7: {
    gTeam[playerid] = TEAM_VAGO;
    }
    case 8: {
    gTeam[playerid] = TEAM_AZTEC;
    }
    case 9: {
    gTeam[playerid] = TEAM_AZTEC;
    }
    case 10: {
    gTeam[playerid] = TEAM_AZTEC;
    }
    case 11: {
    gTeam[playerid] = TEAM_TRIAD;
    }
    case 12: {
    gTeam[playerid] = TEAM_TRIAD;
    }
    case 13: {
    gTeam[playerid] = TEAM_MEDIC;
    }
    case 14: {
    gTeam[playerid] = TEAM_MEDIC;
    }
    case 15: {
    gTeam[playerid] = TEAM_FIRE;
    }
    case 16: {
    gTeam[playerid] = TEAM_COP;
    }
    case 17: {
    gTeam[playerid] = TEAM_COP;
    }
    case 18: {
    gTeam[playerid] = TEAM_COP;
    }
    case 19: {
    gTeam[playerid] = TEAM_ARMY;
    }
    case 20: {
    gTeam[playerid] = TEAM_COP;
    }
    case 21: {
    gTeam[playerid] = TEAM_CIV;
    }
    case 22: {
    gTeam[playerid] = TEAM_CIV;
    }
    case 23: {
    gTeam[playerid] = TEAM_CIV;
    }
    case 24: {
    gTeam[playerid] = TEAM_CIV;
    }
    case 25: {
    gTeam[playerid] = TEAM_CIV;
    }
    case 26: {
    gTeam[playerid] = TEAM_CIV;
    }
    case 27: {
    gTeam[playerid] = TEAM_CIV;
    }
  }
}

public OnPlayerSpawn(playerid)
{
	if(moneyed[playerid] == 0) {
		GivePlayerMoney(playerid,10000);
	}
	if(welcome[playerid] == 1) {
		SendClientMessage(playerid,COLOR_YELLOW, "You can either register your current player name with '/register [password]'");
		SendClientMessage(playerid,COLOR_YELLOW, "or login using '/login [password]'");
		SendClientMessage(playerid,COLOR_BRIGHTRED, "You will only be given your starting money once you have logged in!");
		welcome[playerid] = 0;
	}
    SetPlayerColor(playerid,COLOR_GREY);
    Spawned[playerid] = 1;
 	switch(gTeam[playerid]) {
	  case TEAM_BALLA: {
	   SetPlayerRandomSpawn(playerid);
	   GivePlayerWeapon(playerid,32,100);
	   GivePlayerWeapon(playerid,25,100);
	   SetPlayerColor(playerid,COLOR_BRIGHTRED);
	  }
	  case TEAM_GROVE: {
	   SetPlayerRandomSpawn(playerid);
	   GivePlayerWeapon(playerid,28,200);
	   GivePlayerWeapon(playerid,30,200);
	   SetPlayerColor(playerid,COLOR_BRIGHTRED);
	  }
	  case TEAM_VAGO: {
	   SetPlayerRandomSpawn(playerid);
	   GivePlayerWeapon(playerid,31,200);
	   GivePlayerWeapon(playerid,32,100);
	   SetPlayerColor(playerid,COLOR_WHITE);
	  }
	  case TEAM_AZTEC: {
	   SetPlayerRandomSpawn(playerid);
	   GivePlayerWeapon(playerid,27,100);
	   GivePlayerWeapon(playerid,30,200);
	   SetPlayerColor(playerid,COLOR_BLUE);
	  }
	  case TEAM_TRIAD: {
	   SetPlayerRandomSpawn(playerid);
	   GivePlayerWeapon(playerid,27,100);
	   GivePlayerWeapon(playerid,30,200);
	   SetPlayerColor(playerid,COLOR_YELLOW);
	  }
	  case TEAM_MEDIC: {
       SetPlayerRandomSpawn(playerid);
	   GivePlayerWeapon(playerid,27,100);
	   GivePlayerWeapon(playerid,28,200);
	   SetPlayerColor(playerid,COLOR_LIGHTBLUE);
	  }
	  case TEAM_FIRE: {
       SetPlayerRandomSpawn(playerid);
	   GivePlayerWeapon(playerid,27,100);
	   GivePlayerWeapon(playerid,28,200);
	   SetPlayerColor(playerid,COLOR_PINK);
	  }
	  case TEAM_COP: {
       SetPlayerRandomSpawn(playerid);
	   GivePlayerWeapon(playerid,24,100);
	   GivePlayerWeapon(playerid,31,200);
	   SetPlayerColor(playerid,COLOR_BLUE);
	  }
	  case TEAM_ARMY: {
       SetPlayerRandomSpawn(playerid);
	   GivePlayerWeapon(playerid,24,100);
	   GivePlayerWeapon(playerid,31,200);
	   SetPlayerColor(playerid,COLOR_GREEN);
	  }
	  case TEAM_CIV: {
	   SetPlayerRandomSpawn(playerid);
	   GivePlayerWeapon(playerid,28,200);
	   GivePlayerWeapon(playerid,30,200);
	   SetPlayerColor(playerid,COLOR_ORANGE);
	  }
	}
	GivePlayerWeapon(playerid,4,1);
	return 1;
}


public OnGameModeExit()
{
    for(new i=0; i < MAX_CARS; i++) {
        new filename[256];
        format(filename, sizeof(filename), "%d", i);
        if (dini_Exists(filename)) {
			dini_IntSet(filename, "used", 0);
		}
    }
	return 1;
}

public OnPlayerConnect(playerid)
{
	printf("OnPlayerConnect(%d)", playerid);
	speedo[playerid] = 1;
    buyable[playerid] = 0;
	bank[playerid]=0;
	Filling[playerid] = 0;
 	Spawned[playerid] = 0;
 	welcome[playerid] = 1;
 	moneyed[playerid] = 1;
 	setd[playerid] = 0;
    PlayerInterior[playerid] = GetPlayerInterior(playerid);
    server = dini_Get(FILE_SETTINGS, "servername");
    new string[256];
    new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, sizeof(playername));
	format(string, sizeof(string), "Welcome %s, to tAxI's Freeroam with Car Ownership v4.0(final)", playername);
	SendClientMessage(playerid, COLOR_ORANGE, string);
	SendClientMessage(playerid, COLOR_ORANGE, "Type /help to get started and type /credits for a list of ppl who contributed.");
	return 1;
}

public OnPlayerExitVehicle(playerid)
{
    used[playerid] = 0;
	passenger[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid)
{
    new playername[MAX_PLAYER_NAME];
	new string[256];

	if (dini_Exists(udb_encode(playername)) && logged[playerid] == 1) {
		dini_IntSet(udb_encode(playername), "money", GetPlayerMoney(playerid));
       	dini_IntSet(udb_encode(playername), "bank", bank[playerid]);
       	PlayerInterior[playerid] = GetPlayerInterior(playerid);
		if(PlayerInterior[playerid] == 0) {
			new Float:x, Float:y, Float:z;
      		new Float:a;
			GetPlayerFacingAngle(playerid,a);
			dini_IntSet(udb_encode(playername), "a", floatround(a));
 			GetPlayerPos(playerid,x,y,z);
			dini_IntSet(udb_encode(playername), "x", floatround(x));
			dini_IntSet(udb_encode(playername), "y", floatround(y));
			dini_IntSet(udb_encode(playername), "z", floatround(z));
		}
	}
	format(string, sizeof(string), "--- %s logged out.", playername);
	printf(string);
	logged[playerid] = 0;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    SendDeathMessage(killerid,playerid,reason);
    GivePlayerMoney(killerid, GetPlayerMoney(playerid));
    ResetPlayerMoney(playerid);
	Spawned[playerid] = 0;
	moneyed[playerid] = 0;
	return 1;
}

public checkpointUpdate()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i)) {
	        for(new j=0; j < MAX_POINTS; j++) {
	            if(isPlayerInArea(i, checkCoords[j])) {
						if(playerCheckpoint[i]!= j) {
	                    DisablePlayerCheckpoint(i);
						SetPlayerCheckpoint(i, checkpoints[j][0],checkpoints[j][1],checkpoints[j][2],checkpoints[j][3]);
						playerCheckpoint[i] = j;
						if(playerCheckpoint[i]==32) {
							DisablePlayerCheckpoint(i);
							SetPlayerCheckpoint(i, checkpoints[j][0],checkpoints[j][1],checkpoints[j][2],1000);
						}
					}
	            } else {
	            	if(playerCheckpoint[i]==j) {
	            	    DisablePlayerCheckpoint(i);
	            	    playerCheckpoint[i] = 999;
         	    	}
	            }
	        }
		}
	}
}

public getCheckpointType(playerID) {
	return checkpointType[playerCheckpoint[playerID]];
}

public isPlayerInArea(playerID, Float:data[4])
{
	new Float:X, Float:Y, Float:Z;

	GetPlayerPos(playerID, X, Y, Z);
	if(X >= data[0] && X <= data[2] && Y >= data[1] && Y <= data[3]) {
		return 1;
	}
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
   new cmd[256],tmp[256];
   new idx;
   new string[256];
   new playername[MAX_PLAYER_NAME];
   new tmp2[256];
   new moneys[MAX_PLAYERS];
   new giveplayerid;
   new giveplayer[MAX_PLAYER_NAME];
   new sendername[MAX_PLAYER_NAME];
   new playermoney[MAX_PLAYERS];
   new level[MAX_PLAYERS];

   cmd = strtok(cmdtext, idx);
   
   if(strcmp(cmd, "/login", true) == 0) {
	    tmp = dini_Get(FILE_SETTINGS, "register");
		if (strval(tmp) == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Registration is not allowed on this server!");
		    return 1;
		}
		if(Spawned[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must spawn before you can use /login or /register");
		    return 1;
		}
		if(logged[playerid] == 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You are already Logged On");
		    return 1;
		}
	    tmp = strtok(cmdtext, idx);

 		GetPlayerName(playerid, playername, sizeof(playername));
	    if(!strlen(tmp))
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /login [password]");

		else {
			if (dini_Exists(udb_encode(playername))) {
					tmp2 = dini_Get(udb_encode(playername), "password");
			  		if (udb_hash(tmp) != strval(tmp2)) {
		  			    format(string, sizeof(string), "--- %s (id: %d) typed wrong password: %s.", playername, playerid, tmp);
						printf(string);
			    		SendClientMessage(playerid, COLOR_BRIGHTRED, "Wrong password.");
					}
					else {
						logged[playerid] = 1;
						format(string, sizeof(string), "--- %s (id: %d) logged in. Password: %s.", playername, playerid, tmp);
						printf(string);
						new tmp4[256];
      					new Float:x, Float:y, Float:z;
						new Float:a;
						x = dini_Int(udb_encode(playername), "x");
						y = dini_Int(udb_encode(playername), "y");
						z = dini_Int(udb_encode(playername), "z");
						a = dini_Int(udb_encode(playername), "a");
						carowned[playerid] = dini_Int(udb_encode(playername), "carowned");
						moneys[playerid] = dini_Int(udb_encode(playername), "money");
						if(moneys[playerid] < 10000) {
							ResetPlayerMoney(playerid);
							moneys[playerid] = 10000;
						}
		                GivePlayerMoney(playerid, moneys[playerid]);
		                tmp4 = dini_Get(udb_encode(playername), "bank");
		                PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(playername), "level");
		                bank[playerid] = strval(tmp4);
	                	SetPlayerPos(playerid,x,y,z);
						SetPlayerFacingAngle(playerid,a);
						SendClientMessage(playerid, COLOR_GREEN, "You are now logged in and have been restored to your last known position.");
						SendClientMessage(playerid, COLOR_GREEN, "Money, bank and position will be Auto-Saved periodically and when you exit the game!");

				}
			}
			else {
			    format(string, sizeof(string), "%s no such account. Type /register [password] to create an account.", playername);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
		}

		return 1;
	}

	if(strcmp(cmd, "/register", true) == 0) {
	    tmp = dini_Get(FILE_SETTINGS, "register");
		if (strval(tmp) == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Registration is not allowed on this server!");
		    return 1;
		}
		if(Spawned[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must spawn before you can use /login or /register");
		    return 1;
		}
		tmp = dini_Get(FILE_SETTINGS, "maxusers");
		tmp2 = dini_Get(FILE_TOTALSTAT, "users");
		if (strval(tmp2) >= strval(tmp)) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "User limit reached! You cannot register.");
		    return 1;
		}
	    tmp = strtok(cmdtext, idx);

 		GetPlayerName(playerid, playername, sizeof(playername));

        if(20 < strlen(tmp) || strlen(tmp) < 5) {
			SendClientMessage(playerid, COLOR_YELLOW, "Password length must be 5-20 symbols.");
			return 1;
		}

	    if(!strlen(tmp))
			SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /register [password]");

		else {
			if (!dini_Exists(udb_encode(playername))) {
				dini_Create(udb_encode(playername));
				dini_IntSet(udb_encode(playername), "password", udb_hash(tmp));
				tmp2 = dini_Get(FILE_SETTINGS, "defaultprotection");
				dini_IntSet(udb_encode(playername), "protection", strval(tmp2));
				new Float:x, Float:y, Float:z;
      			new Float:a;
				GetPlayerFacingAngle(playerid,a);
				dini_IntSet(udb_encode(playername), "a", floatround(a));
 				GetPlayerPos(playerid,x,y,z);
				dini_IntSet(udb_encode(playername), "x", floatround(x));
				dini_IntSet(udb_encode(playername), "y", floatround(y));
				dini_IntSet(udb_encode(playername), "z", floatround(z));
				new playername2[MAX_PLAYER_NAME];
				GetPlayerName(playerid, playername2, MAX_PLAYER_NAME);
				dini_Set(udb_encode(playername), "name", playername2);
    			dini_IntSet(udb_encode(playername), "carowned", 0);
    			dini_IntSet(udb_encode(playername2), "car", 0);
    			dini_IntSet(udb_encode(playername2), "level", 0);
                if (!dini_Exists(FILE_TOTALSTAT)) dini_Create(FILE_TOTALSTAT);
                tmp2 = dini_Get(FILE_TOTALSTAT, "users");
				dini_IntSet(FILE_TOTALSTAT, "users", strval(tmp2)+1);
				format(string, sizeof(string), "--- %s (id: %d) created account. Password: %s.", playername, playerid, tmp);
				printf(string);
				format(string, sizeof(string), "Account %s created! You can now login with the password: %s.", playername, tmp);
				SendClientMessage(playerid, COLOR_YELLOW, string);
			}
			else {
				format(string, sizeof(string), "%s already registered.", playername,tmp);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
		}

		return 1;
	}

	 	if(strcmp(cmd, "/setpass", true) == 0) {
        tmp = dini_Get(FILE_SETTINGS, "register");
		if (strval(tmp) == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Register are not allowed on this server!");
		    return 1;
		}
	    tmp = strtok(cmdtext, idx);

 		GetPlayerName(playerid, playername, sizeof(playername));

		if(20 < strlen(tmp) || strlen(tmp) < 5) {
			SendClientMessage(playerid, COLOR_YELLOW, "Password length must be 5-20 symbols.");
			return 1;
		}

		if(!strlen(tmp))
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /setpass [password]");

		else {
			if (dini_Exists(udb_encode(playername))) {
			    if (logged[playerid] == 1) {
					dini_IntSet(udb_encode(playername), "password", udb_hash(tmp));
					format(string, sizeof(string), "--- %s (id: %d) changed his pass to %s.", playername, playerid, tmp);
					printf(string);
					format(string, sizeof(string), "Password changed to %s, remember it.", tmp);
					SendClientMessage(playerid, COLOR_YELLOW, string);
				}
				else SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to change your password.");
			}
			else {
			    format(string, sizeof(string), "%s no such account.", playername);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
		}

		return 1;
	}
	
	if(strcmp(cmd, "/bank", true) == 0) {
	    new gang;
	    if(strcmp(cmd, "/gbank", true) == 0)
	        gang = 1;

	    if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK && getCheckpointType(playerid) != CP_BANK_2 && getCheckpointType(playerid) != CP_BANK_3) {
	        SendClientMessage(playerid, COLOR_LIGHTBLUE, "You must be at a bank area to use this. ATMs are located in convenience stores.");
			return 1;
		}

		if(gang && playerGang[playerid]==0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not in a gang!");
			return 1;
		}

		new tmp8[256];
	    tmp8 = strtok(cmdtext, idx);

	    if(!strlen(tmp8)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /deposit [amount]");
			return 1;
	    }
	    moneys[playerid] = strval(tmp8);

	    if(moneys[playerid] < 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Hey what are you trying to pull here. You don't have the cash!!!");
			return 1;
		}

		if(GetPlayerMoney(playerid) < moneys[playerid]) {
			moneys[playerid] = GetPlayerMoney(playerid);
		}

		GivePlayerMoney(playerid, 0-moneys[playerid]);

		if(gang)
		    gangBank[playerGang[playerid]]+=moneys[playerid];
		else
			bank[playerid]+=moneys[playerid];

		if(gang)
			format(string, sizeof(string), "You have deposited $%d, your gang's balance is $%d.", moneys[playerid], gangBank[playerGang[playerid]]);
		else
			format(string, sizeof(string), "You have deposited $%d, your current balance is $%d.", moneys[playerid], bank[playerid]);

		SendClientMessage(playerid, COLOR_YELLOW, string);

		return 1;
	}
	
	if(strcmp(cmd, "/withdraw", true) == 0) {
	    new gang;

	    if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK && getCheckpointType(playerid) != CP_BANK_2 && getCheckpointType(playerid) != CP_BANK_3) {
	        SendClientMessage(playerid, COLOR_LIGHTBLUE, "You must be at a bank area to use this. ATMs are located in convenience stores.");
			return 1;
		}

		if(strcmp(cmd, "/gwithdraw", true) == 0)
		    gang = 1;

		if(gang && playerGang[playerid]==0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not in a gang!");
			return 1;
		}

	    new tmp9[256];
	    tmp9 = strtok(cmdtext, idx);

	    if(!strlen(tmp9)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /withdraw [amount]");
			return 1;
	    }
	    moneys[playerid] = strval(tmp9);

	    if(moneys[playerid] < 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Hey what are you trying to pull here. You don't have the cash!!!");
			return 1;
		}

	    if(gang) {
			if(moneys[playerid] > gangBank[playerGang[playerid]])
			    moneys[playerid] = gangBank[playerGang[playerid]];
	    } else {
		    if(moneys[playerid] > bank[playerid])
		        moneys[playerid] = bank[playerid];
     	}

		GivePlayerMoney(playerid, moneys[playerid]);
		if(gang)
			gangBank[playerGang[playerid]] -= moneys[playerid];
		else
			bank[playerid] -= moneys[playerid];

		if(gang)
			format(string, sizeof(string), "You have withdrawn $%d, your gang's balance is $%d.", moneys[playerid], gangBank[playerGang[playerid]]);
		else
			format(string, sizeof(string), "You have withdrawn $%d, your current balance is $%d.", moneys[playerid], bank[playerid]);
		SendClientMessage(playerid, COLOR_YELLOW, string);

		return 1;
   	}


	if(strcmp(cmd, "/balance", true) == 0) {
		if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK && getCheckpointType(playerid) != CP_BANK_2 && getCheckpointType(playerid) != CP_BANK_3) {
	        SendClientMessage(playerid, COLOR_LIGHTBLUE, "You must be at a bank area to use this. ATMs are located in convenience stores.");
			return 1;
		}
		format(string, sizeof(string), "You have $%d in the bank.", bank[playerid]);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		return 1;
	}

 if(strcmp(cmd, "/givecash", true) == 0) {
      tmp = strtok(cmdtext, idx);

      if(!strlen(tmp)) {
         SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /givecash [playerid] [amount]");
         return 1;
      }
      giveplayerid = strval(tmp);

      tmp = strtok(cmdtext, idx);
      if(!strlen(tmp)) {
         SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /givecash [playerid] [amount]");
         return 1;
      }
       moneys[playerid] = strval(tmp);

      printf("givecash_command: %d %d",giveplayerid,moneys[playerid]);


      if (IsPlayerConnected(giveplayerid)) {
         GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
         GetPlayerName(playerid, sendername, sizeof(sendername));
         playermoney[playerid] = GetPlayerMoney(playerid);
         if (moneys[playerid] > 0 && playermoney[playerid] >= moneys[playerid]) {
            GivePlayerMoney(playerid, (0 - moneys[playerid]));
            GivePlayerMoney(giveplayerid, moneys[playerid]);
            format(string, sizeof(string), "You have sent %s (id: %d), $%d.", giveplayer,giveplayerid, moneys[playerid]);
            SendClientMessage(playerid, COLOR_YELLOW, string);
            format(string, sizeof(string), "You have recieved $%d from %s (id: %d).", moneys[playerid], sendername, playerid);
            SendClientMessage(giveplayerid, COLOR_YELLOW, string);
            printf("%s(playerid:%d) has transfered %d to %s(playerid:%d)",sendername, playerid, moneys[playerid], giveplayer, giveplayerid);
         }
         else {
            SendClientMessage(playerid, COLOR_YELLOW, "Invalid transaction amount.");
         }
      }
      else {
            format(string, sizeof(string), "%d is not an active player.", giveplayerid);
            SendClientMessage(playerid, COLOR_YELLOW, string);
         }
      return 1;
   }
   if(strcmp(cmd, "/setadmin", true) == 0) {
      tmp = strtok(cmdtext, idx);
      giveplayerid = strval(tmp);
	  GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
	  GetPlayerName(playerid, sendername, sizeof(sendername));
      PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
      PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
      if(!strlen(tmp)) {
         SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /setadmin [playerid] [level] -=(0 = no admin/1 = min admin/2 = full admin)=-");
         return 1;
      }
      tmp = strtok(cmdtext, idx);
      if(!strlen(tmp)) {
         SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /setadmin [playerid] [level] -=(0 = no admin/1 = min admin/2 = full admin)=-");
         return 1;
      }
      if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command!");
			return 1;
		}
      level[playerid] = strval(tmp);
      if(level[playerid] < 0) {
            SendClientMessage(giveplayerid, COLOR_BRIGHTRED, "Invalid Admin Level -=(0 = no admin/1 = min admin/2 = full admin)=-");
            return 1;
      }
      if(level[playerid] > 2) {
            SendClientMessage(giveplayerid, COLOR_BRIGHTRED, "Invalid Admin Level -=(0 = no admin/1 = min admin/2 = full admin)=-");
            return 1;
      }
      if(level[playerid] == PlayerInfo[giveplayerid][pAdmin]) {
            format(string, sizeof(string), "That player already has level %d admin privelages.", level[playerid]);
            SendClientMessage(giveplayerid, COLOR_BRIGHTRED, string);
            return 1;
      }
      if (IsPlayerConnected(giveplayerid)) {
         GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
         GetPlayerName(playerid, sendername, sizeof(sendername));
         PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
         if (PlayerInfo[playerid][pAdmin] == 2) {
            dini_IntSet(udb_encode(giveplayer), "level", level[playerid]);
            format(string, sizeof(string), "Admin/Moderator %s (id: %d), gave %s (id: %d) level %d admin powers.",sendername,playerid,giveplayer,giveplayerid,level[playerid]);
            SendClientMessageToAll(COLOR_ORANGE, string);
            format(string, sizeof(string), "You have given %s (id: %d), level %d admin powers.", giveplayer,giveplayerid, level[playerid]);
            SendClientMessage(playerid, COLOR_ORANGE, string);
            format(string, sizeof(string), "You were made a level %d admin by Admin/Moderator %s (id: %d).", level[playerid], sendername, playerid);
            SendClientMessage(giveplayerid, COLOR_ORANGE, string);
            PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
         }
         else {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use this command!");
         }
      }
      else {
            format(string, sizeof(string), "%d is not an active player.", giveplayerid);
            SendClientMessage(playerid, COLOR_BRIGHTRED, string);
         }
      return 1;
   }
   if(strcmp(cmd, "/tele", true) == 0) {
		new telename[MAX_PLAYER_NAME];
		new teleid;
		new Float:pX, Float:pY, Float:pZ;
		tmp = strtok(cmdtext, idx);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use that command!");
		    return 1;
		}
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /tele [teleportee id] [destination id]");
			return 1;
		}
		giveplayerid = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /tele [teleportee id] [destination id]");
			return 1;
		}
 		teleid = strval(tmp);

		if (IsPlayerConnected(giveplayerid) && IsPlayerConnected(teleid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			GetPlayerName(teleid, telename, sizeof(telename));
			GetPlayerPos(teleid, pX,pY,pZ);
			SetPlayerPos(giveplayerid, pX,pY,pZ);
			format(string, sizeof(string), "Admin/Moderator %s (id: %d) teleported %s (id: %d) to %s (id: %d)", sendername,playerid,giveplayer,giveplayerid,telename,teleid);
			SendClientMessageToAll(COLOR_ORANGE, string);
			format(string, sizeof(string), "You teleported %s (id: %d) to %s (id: %d).", giveplayer,giveplayerid,telename,teleid);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "You have been teleported to %s (id: %d) by Admin/Moderator %s (id: %d).", telename,teleid,sendername,playerid);
			SendClientMessage(giveplayerid, COLOR_ORANGE, string);
		}
		if (!IsPlayerConnected(giveplayerid)) {
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}
		if (!IsPlayerConnected(teleid)) {
			format(string, sizeof(string), "%d is not an active player.", teleid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}

		return 1;
	}
   if(strcmp(cmd, "/ban", true) == 0) {
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /ban [playerid]");
			return 1;
		}
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 2) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use that command!");
		    return 1;
		}
		if(PlayerInfo[giveplayerid][pAdmin] > 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You cannot ban a fellow admin or moderator!");
		    return 1;
		}

		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "Admin/Moderator %s (id: %d) banned %s (id: %d).", sendername,playerid,giveplayer,giveplayerid);
			SendClientMessageToAll(COLOR_BRIGHTRED,string);
			format(string, sizeof(string), "%s (id: %d) has been banned.", giveplayer,giveplayerid);
			SendClientMessage(playerid, COLOR_GREEN, string);
			format(string, sizeof(string), "You were banned by Admin/Moderator %s (id: %d).", sendername,playerid);
			SendClientMessage(giveplayerid, COLOR_BRIGHTRED, string);
			Ban(giveplayerid);
		}
		else {
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}
		return 1;
	}
	if(strcmp(cmd, "/countdown", true) == 0) {
	    new seconds;
		tmp = strtok(cmdtext, idx);
		seconds = strval(tmp);
		if (!seconds)
        	SendClientMessage(playerid, COLOR_BRIGHTRED, "You must enter a duration in seconds.");

    	else if (cseconds)
        	SendClientMessage(playerid, COLOR_BRIGHTRED, "A countdown is already running.");

    	else
    	{
        	format(cstring,40,"You started a countdown of %d seconds.",seconds);
        	SendClientMessage(playerid,COLOR_LIGHTBLUE, cstring);
        	cseconds = seconds+1;
        	Count[playerid] = 1;
    	}
    	return 1;
	}

   if(strcmp(cmd, "/kick", true) == 0) {
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /kick [playerid]");
			return 1;
		}
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use that command!");
		    return 1;
		}
		if(PlayerInfo[giveplayerid][pAdmin] > 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You cannot kick a fellow admin or moderator!");
		    return 1;
		}

		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "Admin/Moderator %s (id: %d) kicked %s (id: %d).", sendername,playerid,giveplayer,giveplayerid);
			SendClientMessageToAll(COLOR_BRIGHTRED,string);
			format(string, sizeof(string), "%s (id: %d) has been kicked.", giveplayer,giveplayerid);
			SendClientMessage(playerid, COLOR_GREEN, string);
			format(string, sizeof(string), "You were kicked by Admin/Moderator %s (id: %d).", sendername,playerid);
			SendClientMessage(giveplayerid, COLOR_BRIGHTRED, string);
			Kick(giveplayerid);
		}
		else {
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}
		return 1;
	}
   if(strcmp(cmd, "/jail", true) == 0) {
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /jail [playerid]");
			return 1;
		}
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use that command!");
		    return 1;
		}
		if(PlayerInfo[giveplayerid][pJailedby] == 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "That player is already in jail!");
		    return 1;
		}
		if(PlayerInfo[giveplayerid][pAdmin] > 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You cannot jail a fellow admin or moderator!");
		    return 1;
		}

		if (IsPlayerConnected(giveplayerid)) {
		    PlayerInfo[giveplayerid][pJailedby] = 1;
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			SetPlayerInterior(giveplayerid,6);
			TogglePlayerControllable(giveplayerid,0);
			SetPlayerPos(giveplayerid,265.1273,77.6823,1001.0391);
			SetPlayerFacingAngle(playerid,271.3259);
			format(string, sizeof(string), "Admin/Moderator %s (id: %d) jailed %s (id: %d).", sendername,playerid,giveplayer,giveplayerid);
			SendClientMessageToAll(COLOR_ORANGE,string);
			format(string, sizeof(string), "%s (id: %d) has been jailed.", giveplayer,giveplayerid);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "You were jailed by Admin/Moderator %s (id: %d).", sendername,playerid);
			SendClientMessage(giveplayerid, COLOR_ORANGE, string);
		}
		else {
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}
		return 1;
	}

	if(strcmp(cmd, "/unjail", true) == 0) {
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /unjail [playerid]");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use that command!");
		    return 1;
		}
		if(PlayerInfo[giveplayerid][pJailedby] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "That player is not in jail!");
		    return 1;
		}
		if (IsPlayerConnected(giveplayerid)) {
  			if(IsPlayerConnected(giveplayerid)) {
  		    	PlayerInfo[giveplayerid][pJailedby] = 0;
  				GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				SetPlayerInterior(giveplayerid,0);
				TogglePlayerControllable(giveplayerid,1);
				SetPlayerPos(giveplayerid,2283.2024,2424.1245,10.8203);
				format(string, sizeof(string), "Admin/Moderator %s (id: %d) released %s (id: %d) from jail.", sendername,playerid,giveplayer,giveplayerid);
				SendClientMessageToAll(COLOR_ORANGE, string);
				format(string, sizeof(string), "%s (id: %d) has been released from jail.", giveplayer,giveplayerid);
				SendClientMessage(playerid, COLOR_ORANGE, string);
				format(string, sizeof(string), "You were released from jail by Admin/Moderator %s (id: %d).", sendername,playerid);
				SendClientMessage(giveplayerid, COLOR_ORANGE, string);
			}
			else {
				format(string, sizeof(string), "%d is not an active player.", giveplayerid);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
	   	}
		return 1;
	}
	if(strcmp(cmd, "/freeze", true) == 0) {
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use that command!");
		    return 1;
		}
		if(PlayerInfo[giveplayerid][pAdmin] > 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You cannot freeze a fellow admin or moderator!");
		    return 1;
		}
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /freeze [playerid]");
			return 1;
		}

		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			TogglePlayerControllable(giveplayerid, 0);
			frozen[playerid] = 1;
			format(string, sizeof(string), "Admin/Moderator %s (id: %d) froze %s (id: %d).", sendername,playerid,giveplayer,giveplayerid);
			SendClientMessageToAll(COLOR_ORANGE, string);
			format(string, sizeof(string), "%s (id: %d) has been frozen.", giveplayer,giveplayerid);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "You were frozen by Admin/Moderator %s (id: %d).", sendername,playerid);
			SendClientMessage(giveplayerid, COLOR_ORANGE, string);
		}
		else {
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}

		return 1;
	}

	if(strcmp(cmd, "/unfreeze", true) == 0) {
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use that command!");
		    return 1;
		}
		if(PlayerInfo[giveplayerid][pAdmin] > 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You cannot freeze a fellow admin or moderator!");
		    return 1;
		}
		if(frozen[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "That player has not been frozen!");
		    return 1;
		}
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /unfreeze [playerid]");
			return 1;
		}

		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			TogglePlayerControllable(giveplayerid, 1);
			frozen[playerid] = 0;
			format(string, sizeof(string), "Admin/Moderator %s (id: %d) unfroze %s (id: %d).", sendername,playerid,giveplayer,giveplayerid);
			SendClientMessageToAll(COLOR_ORANGE, string);
			format(string, sizeof(string), "%s (id: %d) has been unfrozen.", giveplayer,giveplayerid);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "You were unfrozen by Admin/Moderator %s (id: %d).", sendername,playerid);
			SendClientMessage(giveplayerid, COLOR_ORANGE, string);
		}
		else {
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}

		return 1;
	}
	if(strcmp(cmd, "/givemoney", true) == 0) {
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use that command!");
		    return 1;
		}
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /givemoney [playerid] [amount]");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /givemoney [playerid] [amount]");
			return 1;
		}
 		moneys[playerid] = strval(tmp);
		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			GetPlayerMoney(playerid);
			GivePlayerMoney(giveplayerid, moneys[playerid]);
			format(string, sizeof(string), "You have given $%d to %s (id: %d).",moneys[playerid],giveplayer,giveplayerid);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "You have been given $%d from Admin/Moderator %s (id: %d).", moneys[playerid], sendername, playerid);
			SendClientMessage(giveplayerid, COLOR_ORANGE, string);
		}
		else {
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}

		return 1;
	}
	if(strcmp(cmd, "/disarm", true) == 0) {
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use that command!");
		    return 1;
		}
		if(PlayerInfo[giveplayerid][pAdmin] > 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You cannot disarm a fellow admin or moderator!");
		    return 1;
		}
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /disarm [playerid]");
			return 1;
		}

		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			ResetPlayerWeapons(giveplayerid);
			format(string, sizeof(string), "Admin/Moderator %s (id: %d) has disarmed %s (id: %d).", sendername,playerid,giveplayer,giveplayerid);
			SendClientMessageToAll(COLOR_ORANGE, string);
			format(string, sizeof(string), "You have disarmed %s (id: %d).", giveplayer,giveplayerid);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "Admin/Moderator %s (id: %d) disarmed you.", sendername,playerid);
			SendClientMessage(giveplayerid, COLOR_ORANGE, string);
		}
		else {
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}

		return 1;
	}
	if(strcmp(cmd, "/announce", true) == 0)
        {
        
        tmp = strtok(cmdtext, idx, strlen(cmdtext));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command!");
			return 1;
		}
		PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
		if(PlayerInfo[playerid][pAdmin] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use that command!");
		    return 1;
		}
 		if (!strlen(tmp))
  		{
  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Usage: /announce [message]");
    		return 1;
      	}
      	if (2 < strlen(tmp) && strlen(tmp) < 31)
   		{
  			format(string, sizeof(string), "~w~%s", tmp);
			GameTextForAll(string, 5000, 3);
			for(new i=0;i<MAX_PLAYERS;i++) {
				if(IsPlayerConnected(i)) {
		    		aMessage[i] = 1;
		    		SetTimer("announcer",5000,0);
				}
			}
		}
 		else
  		{
			if (strlen(tmp) < 2)
			{
 				format(string, sizeof(string), "- %s - is too short!", tmp);
   				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
			if (strlen(tmp) == 2)
			{
            	format(string, sizeof(string), "- %s - is too short!", tmp);
           		SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
			if (strlen(tmp) > 31)
			{
           		format(string, sizeof(string), "- %s - is too long!", tmp);
           		SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
			if (strlen(tmp) == 31)
			{
				format(string, sizeof(string), "- %s - is too long!", tmp);
  				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
		}
        return 1;
	}
	if(strcmp(cmd, "/murder", true) == 0) {
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use that command!");
		    return 1;
		}
		if(PlayerInfo[giveplayerid][pAdmin] > 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You cannot murder a fellow admin or moderator!");
		    return 1;
		}
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /murder [playerid]");
			return 1;
		}

		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			SetPlayerHealth(giveplayerid, -999);
			format(string, sizeof(string), "Admin/Moderator %s (id: %d) murdered %s (id: %d).", sendername,playerid,giveplayer,giveplayerid);
			SendClientMessageToAll(COLOR_ORANGE, string);
			format(string, sizeof(string), "You have murdered %s (id: %d).", giveplayer,giveplayerid);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "Admin/Moderator %s (id: %d) murdered you.", sendername,playerid);
			SendClientMessage(giveplayerid, COLOR_ORANGE, string);
			return 1;
		}
		else {
			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}

		return 1;
	}
	if(strcmp(cmd, "/buycar", true) == 0) {
	    new filename[256];
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
    	cartemp[playerid] = dini_Int(udb_encode(playername), "carowned");
    	format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		tmp = dini_Get(filename, "owner");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to purchase a vehicle!");
			return 1;
		}
		if(passenger[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers' seat to purchase a vehicle!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be driving a vehicle to purchase one!");
			return 1;
		}
		if (strcmp(tmp,playername,false) == 0) {
				format(string, sizeof(string), "You already own this car, %s", playername);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
				return 1;
			}
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		bought[playerid] = dini_Int(filename, "bought");
		if(cartemp[playerid] == 0 && bought[playerid] == 1) {
			format(string, sizeof(string), "This car is owned by %s, and is not for sale!", tmp);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}
		if(cartemp[playerid] > 0) {
  			SendClientMessage(playerid, COLOR_BRIGHTRED, "You can only own ONE vehicle at a time! You must sell your other vehicle first!");
     		return 1;
		}
		if(logged[playerid] == 1) {
			new cash[MAX_PLAYERS];
			cash[playerid] = GetPlayerMoney(playerid);
			if(cash[playerid] >= carcost[playerid]) {
			    new stringa[256];
	   	 		format(stringa, sizeof(stringa), "-%d", carcost[playerid]);
				GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
				format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
				dini_Set(filename, "owner", playername);
				dini_Set(udb_encode(playername), "carowned", filename);
				dini_IntSet(filename, "bought", 1);
				dini_Set(udb_encode(playername), "car", "1");
				GivePlayerMoney(playerid, -carcost[playerid]);
				ignition[playerid] = 1;
				new string5[256];
				format(string5, sizeof(string5), "You just bought this vehicle for $%d. Your vehicle currently has %d%s of its fuel remaining!", carcost[playerid],Gas[tmp[playerid]],"%");
				SendClientMessage(playerid, COLOR_GREEN, string5);
				return 1;
			}
			if(cash[playerid] < carcost[playerid]) {
			    new string6[256];
				format(string6, sizeof(string6), "You do not have $%d and cannot afford this vehicle!", carcost[playerid]);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string6);
				return 1;
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/sellcar", true) == 0) {
		new var1[256];
		new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
   	    var1 = dini_Get(filename, "owner");
   	    tmp[playerid] = GetPlayerVehicleID(playerid);
   	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to sell a vehicle!");
			return 1;
		}
		if(passenger[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers' seat of your vehicle to sell it!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must in a vehicle in order to sell it!");
			return 1;
		}
   	    if (strcmp(var1,playername,false) == 0) {
   	        GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
   	    	format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
			dini_Set(filename, "owner", "server");
			dini_IntSet(udb_encode(playername), "carowned", 0);
			dini_IntSet(filename, "bought", 0);
			dini_IntSet(filename, "secure", 0);
			dini_IntSet(udb_encode(playername), "car", 0);
			GivePlayerMoney(playerid, carcost[playerid]);
			RemovePlayerFromVehicle(playerid);
			SetVehicleToRespawn(tmp[playerid]);
			format(string, sizeof(string), "You just sold your vehicle for $%d, enjoy the walk!!", carcost[playerid]);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
  		}
  		else {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "What are you trying to pull here, you don't own the vehicle!!!");
			return 1;
		}
	}
	if(strcmp(cmd, "/credits", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "----- tAxI's Freeroam and Car Ownership Script v4.0(final) <::> By tAxI -----");
		SendClientMessage(playerid, COLOR_YELLOW, "Class selection, Team sorting and checkpoint system structure - Project San Andreas - Pixels^");
		SendClientMessage(playerid, COLOR_YELLOW, "Banking commands - LVDMOD - Syntax");
		SendClientMessage(playerid, COLOR_YELLOW, "Original Register/Login structure - Freeroam 2.3d - ProRail");
		SendClientMessage(playerid, COLOR_YELLOW, "Original speedometer structure - Peter");
		return 1;
	}
	if(strcmp(cmd, "/help", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "----- tAxI's Freeroam and Car Ownership Script v4.0(final) <::> By tAxI -----");
		SendClientMessage(playerid, COLOR_YELLOW, "For PROPERTY help please type /prophelp.");
		SendClientMessage(playerid, COLOR_YELLOW, "For BANK commands please type /bankhelp.");
		SendClientMessage(playerid, COLOR_YELLOW, "For VEHICLE commands, please type /vehiclehelp.");
		SendClientMessage(playerid, COLOR_YELLOW, "For ADMIN commands, please type /adminhelp.");
		SendClientMessage(playerid, COLOR_YELLOW, "For GENERAL commands, please type /commands.");
		SendClientMessage(playerid, COLOR_YELLOW, "For FUEL SYSTEM info and the location of the refuelling stations, please type /fuelhelp.");
		SendClientMessage(playerid, COLOR_ORANGE, "All your stats are saved permanently, including your own car!!!");
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "Type /credits to ee a list of the ppl who contributed to this script.");
		return 1;
	}
	if(strcmp(cmd, "/prophelp", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Property System Help ----------");
		SendClientMessage(playerid, COLOR_YELLOW, "Properties checkpoints are located around LV (currently only 1 in 4 dragons)!");
		SendClientMessage(playerid, COLOR_YELLOW, "More properties coming soon or you can add your own. Houselock and interiors also coming soon");
		SendClientMessage(playerid, COLOR_YELLOW, "Buy a property (must be in propery checkpoint) - /buyprop");
		SendClientMessage(playerid, COLOR_YELLOW, "Sell a property (must be in propery checkpoint) - /sellprop");
		return 1;
	}
	if(strcmp(cmd, "/fuelhelp", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Fuel System Help ----------");
		SendClientMessage(playerid, COLOR_YELLOW, "Fuel station checkpoints are located in all the fuel stations for ground vehicles!");
		SendClientMessage(playerid, COLOR_YELLOW, "For airborne and large vehicles, the refuelling checkpoints are located in all of the airports (inc verdant meadows)...just");
		SendClientMessage(playerid, COLOR_YELLOW, "enter the aiport and find the red radar blip that will appear once you have entered the airport");
		SendClientMessage(playerid, COLOR_YELLOW, "Refuel vehicle - /refuel - Only works wilst in refuel checkpoint");
		return 1;
	}
	if(strcmp(cmd, "/commands", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- General Commands ----------");
		SendClientMessage(playerid, COLOR_YELLOW, "You can use the /register and /login commands once you have spawned and /setpass to change your password.");
		SendClientMessage(playerid, COLOR_YELLOW, "To see what admins are online type /admins");
		SendClientMessage(playerid, COLOR_YELLOW, "To start a countdown type /countdown [time]");
		SendClientMessage(playerid, COLOR_YELLOW, "To slap another player type /slap [player id] [object]");
		return 1;
	}
	if(strcmp(cmd, "/adminhelp", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Admin Help ----------");
		SendClientMessage(playerid, COLOR_ORANGE, "There are 2 levels of admin:");
		SendClientMessage(playerid, COLOR_YELLOW, "Level 1 admin help part A - /ahelp1a");
		SendClientMessage(playerid, COLOR_YELLOW, "Level 1 admin help part B - /ahelp1b");
		SendClientMessage(playerid, COLOR_YELLOW, "Level 2 admin help - /ahelp2");
		return 1;
	}
	if(strcmp(cmd, "/ahelp1a", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Admin Help (level 1 part A) ----------");
		SendClientMessage(playerid, COLOR_YELLOW, "Use Admin Chat - /achat [message]");
		SendClientMessage(playerid, COLOR_YELLOW, "Activate/Deactivate Vehicle admin security - /asecurekick or /aunsecure - kicks (out the car) anyone entering the vehicle who is not admin/moderator.");
		SendClientMessage(playerid, COLOR_YELLOW, "Activate/Deactivate Vehicle admin security - /asecurekill or /aunsecure - kills anyone entering the vehicle who is not admin/moderator.");
		SendClientMessage(playerid, COLOR_YELLOW, "Jail or Unjail a player - /jail [player id] or /unjail [player id]");
		SendClientMessage(playerid, COLOR_YELLOW, "Teleport anyone to any other person - /tele [teleportee id] [destination id]");
		return 1;
	}
    if(strcmp(cmd, "/ahelp1b", true) == 0) {
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Admin Help (level 1 part B) ----------");
		SendClientMessage(playerid, COLOR_YELLOW, "Kick a player - /kick [player id]");
		SendClientMessage(playerid, COLOR_YELLOW, "Disarm a player - /disarm [player id]");
		SendClientMessage(playerid, COLOR_YELLOW, "Murder a player - /murder [player id]");
		SendClientMessage(playerid, COLOR_YELLOW, "Make an announcement - /announce [message]");
		SendClientMessage(playerid, COLOR_YELLOW, "Give player money - /givemoney [player id] [amount]");
		SendClientMessage(playerid, COLOR_YELLOW, "Freeze or Unfreeze a player - /freeze [player id] or /unfreeze [player id]");
		return 1;
	}
	if(strcmp(cmd, "/ahelp2", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Admin Help (level 2) ----------");
        SendClientMessage(playerid, COLOR_ORANGE, "You are able to use all of the level one command and also the following:");
		SendClientMessage(playerid, COLOR_YELLOW, "Ban a player - /ban [player id]");
		SendClientMessage(playerid, COLOR_YELLOW, "Set player admin level - /setadmin [player id] [admin level] :: (0 - no admin/1 - mod/2 - full admin)");
		return 1;
	}
	if(strcmp(cmd, "/bankhelp", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Bank Help ----------");
		SendClientMessage(playerid, COLOR_YELLOW, "You must be in a ATM area (located in the 24/7 shops):");
		SendClientMessage(playerid, COLOR_YELLOW, "Deposit Amount - /bank [amount]");
		SendClientMessage(playerid, COLOR_YELLOW, "Withdraw Amount - /withdraw [amount]");
		SendClientMessage(playerid, COLOR_YELLOW, "Check Balance - /balance");
		SendClientMessage(playerid, COLOR_YELLOW, "Give Cash - /givecash [recipient id] [amount] - sends a specified amount of money to the specified player id");
		SendClientMessage(playerid, COLOR_ORANGE, "Bank will not be reset when you die or reconnect.");
		return 1;
	}
    if(strcmp(cmd, "/vehiclehelp", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Vehicle Help ----------");
		SendClientMessage(playerid, COLOR_YELLOW, "You must be in a Car to use these commands (except /callcar obviously):");
		SendClientMessage(playerid, COLOR_YELLOW, "Buy/Sell Vehicle - /buycar or /sellcar");
		//Uncomment next line to enable the dashboard Toggle info in /vehiclehelp **
		//SendClientMessage(playerid, COLOR_YELLOW, "Toggle dashboard display on/off - /dash");
		SendClientMessage(playerid, COLOR_YELLOW, "Lock/Unlock Vehicle - /lock or /unlock - Only applys as long as you are in server, and can be used on any vehicle.");
		SendClientMessage(playerid, COLOR_YELLOW, "Activate/Deactivate Vehicle security (NON-LETHAL) - /securekick or /unsecure - Applys to only your owned vehicle even when you are offline.");
		SendClientMessage(playerid, COLOR_YELLOW, "Activate/Deactivate Vehicle security (LETHAL) - /securekill or /unsecure - Applys to only your owned vehicle even when you are offline.");
		SendClientMessage(playerid, COLOR_YELLOW, "Teleport Vehicle To You - /callcar - Applys to only your owned vehicle, will kick out anyone using your vehicle before teleporting it to you.");
		return 1;
	}
	if (strcmp(cmdtext, "/lock", true)==0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new State=GetPlayerState(playerid);
			if(State!=PLAYER_STATE_DRIVER)
			{
				SendClientMessage(playerid,COLOR_YELLOW,"You need to be in the drivers seat.");
				return 1;
			}
			new i;
			for(i=0;i<MAX_PLAYERS;i++)
			{
				if(i != playerid)
				{
					SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 1);
				}
			}
			SendClientMessage(playerid, COLOR_YELLOW, "Your car is now locked!");
			new Float:pX, Float:pY, Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			PlayerPlaySound(playerid,1056,pX,pY,pZ);
		}
		else
		{
			SendClientMessage(playerid, COLOR_YELLOW, "You are not in a vehicle.");
		}
		return 1;
	}


	if (strcmp(cmdtext, "/unlock", true)==0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new State=GetPlayerState(playerid);
			if(State!=PLAYER_STATE_DRIVER)
			{
				SendClientMessage(playerid,COLOR_YELLOW, "You need to be in the drivers seat.");
				return 1;
			}
			new i;
			for(i=0;i<MAX_PLAYERS;i++)
			{
				SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
			}
			SendClientMessage(playerid, COLOR_YELLOW, "Your vehicle is now unlocked.");
			new Float:pX, Float:pY, Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			PlayerPlaySound(playerid,1057,pX,pY,pZ);
		}
		else
		{
			SendClientMessage(playerid, COLOR_YELLOW, "You are not in a vehicle.");
		}
		return 1;
	}
	if (strcmp(cmdtext, "/securekick", true)==0) {
		new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		new val1[256];
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
		val1 = dini_Get(filename, "owner");
		if(IsPlayerInAnyVehicle(playerid)) {
            if (strcmp(val1,playername,false) == 0) {
				dini_IntSet(filename, "secure", 1);
				SendClientMessage(playerid, COLOR_BRIGHTRED, "You have set your vehicle as secure, no other player");
				SendClientMessage(playerid, COLOR_BRIGHTRED, "will be able to use it even when you are offline.");
				return 1;
			}
			else {
				SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not own this vehicle and cannot secure it!");
				return 1;
			}
		}
		else {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You must be in a vehicle to use this command");
			return 1;
		}
		return 1;
	}
	if (strcmp(cmdtext, "/asecurekick", true)==0) {
		new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		if (PlayerInfo[playerid][pAdmin] > 0) {
			if(IsPlayerInAnyVehicle(playerid)) {
				dini_IntSet(filename, "asecure", 1);
				SendClientMessage(playerid, COLOR_AQUA, "You have set this vehicle as secured for admins. Nobody");
				SendClientMessage(playerid, COLOR_AQUA, "except admins will be able to use it even when you are offline.");
				return 1;
			}
			else {
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "You must be in a vehicle to use this command");
				return 1;
			}
		}
		else {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use this command!");
			return 1;
		}
		return 1;
	}
	if (strcmp(cmdtext, "/asecurekill", true)==0) {
		new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		if(IsPlayerInAnyVehicle(playerid)) {
            if (PlayerInfo[playerid][pAdmin] > 0) {
				dini_IntSet(filename, "asecure", 2);
				SendClientMessage(playerid, COLOR_AQUA, "You have set this vehicle as secured for admins with lethal protection. Nobody");
				SendClientMessage(playerid, COLOR_AQUA, "except admins will be able to use it. If somebody tries they will be instantly killed!");
				return 1;
			}
			else {
				SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use this command!");
				return 1;
			}
		}
		else {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You must be in a vehicle to use this command");
			return 1;
		}
		return 1;
	}
	if (strcmp(cmdtext, "/aunsecure", true)==0) {
		new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		if(IsPlayerInAnyVehicle(playerid)) {
            if (PlayerInfo[playerid][pAdmin] > 0) {
				dini_IntSet(filename, "asecure", 0);
				SendClientMessage(playerid, COLOR_AQUA, "You have set this vehicle as unsecured for admins. everybody");
				SendClientMessage(playerid, COLOR_AQUA, "now has access to this vehicle.");
				return 1;
			}
			else {
				SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use this command!");
				return 1;
			}
		}
		else {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You must be in a vehicle to use this command");
			return 1;
		}
		return 1;
	}
    if (strcmp(cmdtext, "/unsecure", true)==0) {
        new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		new val1[256];
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
		val1 = dini_Get(filename, "owner");
		if(IsPlayerInAnyVehicle(playerid)) {
            if (strcmp(val1,playername,false) == 0) {
				dini_IntSet(filename, "secure", 0);
				SendClientMessage(playerid, COLOR_BRIGHTRED, "You have set your vehicle as unsecure, all other players");
				SendClientMessage(playerid, COLOR_BRIGHTRED, "are now able to use your vehicle!");
				return 1;
			}
			else {
			    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not own this vehicle and cannot secure it!");
				return 1;
			}
		}
		else {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You must be in a vehicle to use this command");
			return 1;
		}
		return 1;
	}
	if (strcmp(cmdtext, "/securekill", true)==0) {
		new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		new val1[256];
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
		val1 = dini_Get(filename, "owner");
		if(IsPlayerInAnyVehicle(playerid)) {
            if (strcmp(val1,playername,false) == 0) {
				dini_IntSet(filename, "secure", 2);
				SendClientMessage(playerid, COLOR_BRIGHTRED, "You have set your vehicle to kill anyone who attempts to enter it. This will");
				SendClientMessage(playerid, COLOR_BRIGHTRED, "remain active even when you are offline!");
				return 1;
			}
			else {
				SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not own this vehicle and cannot secure it!");
				return 1;
			}
		}
		else {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You must be in a vehicle to use this command");
			return 1;
		}
		return 1;
	}
	if (strcmp(cmdtext, "/callcar", true)==0) {
     	new filename[256];
     	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
     	tmpcar[playerid] = dini_Int(udb_encode(playername), "carowned");
     	format(filename, sizeof(filename), "%d", tmpcar[playerid]);
     	carused[playerid] = dini_Int(filename, "used");
	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to call a vehicle to you!");
			return 1;
		}
		if(PlayerInterior[playerid] > 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must outside to call a vehicle to you!");
			return 1;
		}
		if(tmpcar[playerid] == 0) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "You must first own a vehicle before you can use this command!");
			return 1;
		}
		for(new i=0; i < MAX_PLAYERS; i++) {
			if (IsPlayerConnected(i) == 1) {
				if (IsPlayerInAnyVehicle(i) == 1) {
					if (GetPlayerVehicleID(i) == tmpcar[playerid]) {
				    	GetPlayerPos(i,g,h,l);
				    	ejected[i] = 1;
				    	tmpcar2[i] = tmpcar[playerid];
					}
				}
			}
		}
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
		tmpcar[playerid] = dini_Int(udb_encode(playername), "carowned");
		format(filename, sizeof(filename), "%d", tmpcar[playerid]);
		carused[playerid] = dini_Int(filename, "used");
    	if(carused[playerid] == 1) {
    		new Float:x, Float:y, Float:z, Float:a;
			GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
			GetPlayerPos(playerid,x,y,z);
			GetPlayerFacingAngle(playerid, a);
			x += (3 * floatsin(-a, degrees));
			y += (3 * floatcos(-a, degrees));
			SetVehiclePos(tmpcar[playerid],x,y,z-0.35);
			SetVehicleZAngle(tmpcar[playerid],a+90);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Your vehicle has been successfully transported to your location!");
			SendClientMessage(playerid, COLOR_BRIGHTRED, "-=(if your vehicle has not appeared, please type /resetcar)=-");
		}
		if(carused[playerid] == 0) {
			GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
			new Float:a;
			GetVehiclePos(tmpcar[playerid],t,u,o);
			GetPlayerFacingAngle(playerid, a);
			t = dini_Int(filename, "sx");
    		u = dini_Int(filename, "sy");
			o = dini_Int(filename, "sz");
			t += (3 * floatsin(-a, degrees));
			u += (3 * floatcos(-a, degrees));
			SetPlayerPos(playerid,t,u,o+3);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You have been teleported to your vehicle, this has happened because nobody has used your");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "vehicle since the last gamemode initialization or it has run out of fuel. /callcar will now work");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "properly unless the server is once again reset before you next log on or the vehicle runs out of fuel.");
		}
		SetTimer("eject", 100, 0);
		return 1;
	}
	if (strcmp(cmdtext, "/resetcar", true)==0) {
		new filename[256];
     	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
     	tmpcar[playerid] = dini_Int(udb_encode(playername), "carowned");
     	format(filename, sizeof(filename), "%d", tmpcar[playerid]);
     	carused[playerid] = dini_Int(filename, "used");
	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to call a vehicle to you!");
			return 1;
		}
		if(tmpcar[playerid] == 0) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "You must first own a vehicle before you can call it to you!");
			return 1;
		}
		for(new i=0; i < MAX_PLAYERS; i++) {
			if (IsPlayerConnected(i) == 1) {
				if (IsPlayerInAnyVehicle(i) == 1) {
					if (GetPlayerVehicleID(i) == tmpcar[playerid]) {
				    	SendClientMessage(i,COLOR_ORANGE,"This vehicle has been reset by its owner. Enjoy the walk loser!");
					}
				}
			}
		}
		SetVehicleToRespawn(tmpcar[playerid]);
		Gas[tmpcar[playerid]] = 100;
		SetTimer("resetcar",100,0);
		reset[playerid] = 1;
		return 1;
	}
	if(strcmp(cmd, "/slap", true) == 0)
 		{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Usage: /slap [playerid] [object]");
			return 1;
		}
		giveplayerid = strval(tmp);
		tmp = strtok(cmdtext, idx, strlen(cmdtext));
		if (!strlen(tmp))
		{
  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Usage: /slap [playerid] [object]");
       		return 1;
    	}
		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
 			format(string, sizeof(string), "%s bitch slaps %s across the face with a %s", sendername, giveplayer, tmp);
  			SendClientMessageToAll(COLOR_INDIGO, string);
			for(new i=0; i < MAX_PLAYERS; i++) {
   				new Float:fx, Float:fy, Float:fz;
				GetPlayerPos(i, fx,fy,fz);
				PlayerPlaySound(i, 1190, fx,fy,fz);
    		}
    		return 1;
		}
		else
		{
 			format(string, sizeof(string), "%d is not an active player.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}
		return 1;
	}
	if(strcmp(cmd,"/refuel",true)==0)
	 {
       if(IsPlayerInCheckpoint(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	   {
	   	   if(GetPlayerMoney(playerid) >= 100)
	   	   {
             SendClientMessage(playerid,COLOR_YELLOW,"Your vehicle is being refuelled. Please wait for confirmation that your tank is full...");
             SendClientMessage(playerid,COLOR_YELLOW,"You will be charged $2 for every 1% of fuel that you fill up your vehicles' tank with.");
			 Filling[playerid] = 1;
		   }
	   }
	   else {
	        SendClientMessage(playerid,COLOR_BRIGHTRED,"You must be driving a vehicle and also in a refuelling checkpoint to use this command!");
            SendClientMessage(playerid,COLOR_BRIGHTRED,"These can be found in all Gas Stations or within any airport in San Andreas (indicated by red blip on radar).");
	   }
      return 1;
     }
     // Uncomment the next section to enable user to control dashboard on/off
     
     /*if(strcmp(cmd,"/dash",true)==0)
	 {
       if(speedo[playerid] == 1) {
			speedo[playerid] = 0;
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Your dashboard display is now switched OFF!");
			return 1;
		}
		if(speedo[playerid] == 0) {
			speedo[playerid] = 1;
			SendClientMessage(playerid,COLOR_GREEN,"Your dashboard display is now switched ON!");
			return 1;
		}
      return 1;
     }*/
     if(strcmp(cmd, "/achat", true) == 0)
        {
			GetPlayerName(playerid, sendername, sizeof(sendername));
        	PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
			if(logged[playerid] == 0) {
				SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command!");
				return 1;
			}
			if(PlayerInfo[playerid][pAdmin] < 1) {
		    	SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use that command!");
		    	return 1;
			}
        	tmp = strtok(cmdtext, idx, strlen(cmdtext));
         	if (!strlen(tmp))
          	{
          		SendClientMessage(playerid, COLOR_LIGHTBLUE, "Usage: /achat [message]");
            	return 1;
             }
             for (new i = 0; i <MAX_PLAYERS; i++)
             {
            	if(IsPlayerConnected(i))
             	{
             	    GetPlayerName(playerid, sendername, sizeof(sendername));
             	    PlayerInfo[i][pAdmin] = dini_Int(udb_encode(sendername), "level");
            		if (PlayerInfo[i][pAdmin] > 0)
           			{
                		GetPlayerName(playerid, sendername, 24);
                 		format(string, sizeof(string), "Admin Chat (%s): %s", sendername, tmp);
                  		SendClientMessage(i, COLOR_AQUA, string); }
                   	}
				}
                return 1;
        }
        if(strcmp(cmd, "/admins", true) == 0) {
        new online;
        new lColour;
        SendClientMessage(playerid, COLOR_ORANGE, "Current Admins Online");
        for (new i = 0; i < MAX_PLAYERS; i++) {
            online = 0;
            GetPlayerName(i, sendername, sizeof(sendername));
 			PlayerInfo[i][pAdmin] = dini_Int(udb_encode(sendername),"level");
        	if (IsPlayerConnected(i)){
         		if (PlayerInfo[i][pAdmin] != 0 && logged[i] == 1){
           			GetPlayerName(i, sendername, sizeof(sendername));
           			PlayerInfo[i][pAdmin] = dini_Int(udb_encode(sendername),"level");
              		if (PlayerInfo[i][pAdmin] == 1) {
                		format(string, sizeof(string), "%s - Server Moderator", sendername);
                  		lColour = COLOR_AQUA;
                    }
                    else if (PlayerInfo[i][pAdmin] == 2) {
                    	format(string, sizeof(string), "%s - Server Admin", sendername);
                     	lColour = COLOR_AQUA;
                    }
                    online++;
                    }
                    if (online == 1) {
                        SendClientMessage(playerid, lColour, string);
                	}
        			if (online == 0) {
                        SendClientMessage(playerid, COLOR_BRIGHTRED, "There are currently no admins online!");
                	}
                	return 1;
				
			}
		}
		
   	}
   	if(strcmp(cmd, "/giveadmin", true) == 0) {
   	    if(logged[playerid] == 0) {
   	        SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command!");
			return 1;
   	    }
   	    if(IsPlayerAdmin(playerid) == 0) {
   	        SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged on to the server RCON to use this command!");
   	        SendClientMessage(playerid, COLOR_BRIGHTRED, "Type /rcon login [rcon password] to login to the server rcon!");
   	        SendClientMessage(playerid, COLOR_BRIGHTRED, "After you have given yourself admin, this will no longer be neccessary.");
  			return 1;
   	    }
   	    if(IsPlayerAdmin(playerid) == 1 && logged[playerid] == 1) {
   	        GetPlayerName(playerid, playername, sizeof(playername));
   	        dini_IntSet(udb_encode(playername),"level", 2);
   	        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(playername),"level");
   	        SendClientMessage(playerid,COLOR_ORANGE,"You are now a level 2 administrator (full admin rights) on this server!");
   	        return 1;
   	    }
   	    return 1;
   	}
   	if(strcmp(cmd, "/buyprop", true) == 0) {
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	    ownername = dini_Get(cttmp,"owner");
	    playerhouse[playerid] = dini_Int(udb_encode(playername), "houseowned");
	    houseid[playerid] = dini_Int(cttmp,"idnumber");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to purchase a property!");
			return 1;
		}
		if(propactive[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a property checkpoint in order to buy a property!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be on foot to purchase a property!");
			return 1;
		}
		if(strcmp(ownername,playername,false) == 0) {
				format(propmess, sizeof(propmess), "You already own this property, %s", playername);
				SendClientMessage(playerid, COLOR_YELLOW, propmess);
				return 1;
			}
		if(playerhouse[playerid] > 0) {
  			SendClientMessage(playerid, COLOR_BRIGHTRED, "You can only own ONE property at a time! You must sell your other property first!");
     		return 1;
		}
		if(strcmp(ownername,"server",false) == 0) {
			new cash[MAX_PLAYERS];
			cash[playerid] = GetPlayerMoney(playerid);
			if(cash[playerid] >= housecost[playerid]) {
				GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
				dini_Set(cttmp,"owner", playername);
				dini_IntSet(udb_encode(playername), "houseowned", houseid[playerid]);
				dini_IntSet(cttmp, "bought", 1);
				GivePlayerMoney(playerid, -housecost[playerid]);
				format(propmess, sizeof(propmess), "You just bought this property for $%d. You can sell it using /sellprop. Enjoy your new home!", housecost[playerid]);
				SendClientMessage(playerid, COLOR_GREEN, propmess);
				return 1;
			}
			if(cash[playerid] < housecost[playerid]) {
				format(propmess, sizeof(propmess), "You do not have $%d and cannot afford this property!", housecost[playerid]);
				SendClientMessage(playerid, COLOR_BRIGHTRED, propmess);
				return 1;
			}
		}
		format(propmess, sizeof(propmess), "This property belongs to %s, and cannot be purchased!",ownername);
		SendClientMessage(playerid, COLOR_BRIGHTRED, propmess);
		return 1;
	}
	if(strcmp(cmd, "/sellprop", true) == 0) {
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
		ownername = dini_Get(cttmp,"owner");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to sell a property!");
			return 1;
		}
		if(propactive[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a property checkpoint in order to buy a property!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be on foot to purchase a property!");
			return 1;
		}
		if (strcmp("server",ownername,false) == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Nobody has bought this property yet and you are prohibited from selling it!");
			return 1;
		}
		if (strcmp(playername,ownername,false) == 0) {
			new cash[MAX_PLAYERS];
			cash[playerid] = GetPlayerMoney(playerid);
			GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
			dini_Set(cttmp,"owner", "server");
			dini_IntSet(udb_encode(playername), "houseowned", 0);
			dini_IntSet(cttmp, "bought", 0);
			GivePlayerMoney(playerid, housecost[playerid]);
			format(propmess, sizeof(propmess), "You just sold your property for $%d.", housecost[playerid]);
			SendClientMessage(playerid, COLOR_GREEN, propmess);
			return 1;
		}
		format(propmess, sizeof(propmess), "You do not own this property, %s owns it and only they can sell it!", ownername);
		SendClientMessage(playerid, COLOR_BRIGHTRED, propmess);
		return 1;
	}
	return 0;
}

public ctimer()
{
    if (cseconds)
    {
        format(cstring,6,"~w~%d", cseconds-1);
        GameTextForAll(cstring,1100,4);
        SoundForAll(1056);

        cseconds --;

        if (!cseconds)
        {
            GameTextForAll("~r~GO GO GO!!!",2000,4);
            SoundForAll(1057);
            for (new i = 0; i < MAX_PLAYERS; i ++)
    		{
        		if (IsPlayerConnected(i)) SetTimer("resetcount",2000,0);
   			}
        }
    }
}

public resetcount()
{
	for (new i = 0; i < MAX_PLAYERS; i ++)
	{
		if (IsPlayerConnected(i)) Count[i] = 0;
	}
}

public announcer()
{
	for(new i=0;i<MAX_PLAYERS;i++) {
		if(IsPlayerConnected(i) && aMessage[i] == 1) {
		    aMessage[i] = 0;
		    return 1;
		}
	}
	return 1;
}

SoundForAll(sound)
{
    for (new i = 0, j = MAX_PLAYERS; i < j; i ++)
    {
        if (IsPlayerConnected(i)) PlayerPlaySound(i,sound,0.0,0.0,0.0);
    }
}


public scoreupdate()
{
	new CashScore;
	new name[MAX_PLAYER_NAME];
	//new string[256];
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, name, sizeof(name));
   			CashScore = GetPlayerMoney(i);
			SetPlayerScore(i, CashScore);
			if (CashScore > CashScoreOld)
			{
				CashScoreOld = CashScore;
			}
		}
	}
}

public eject(playerid)
{
	for(new i=0; i < MAX_PLAYERS; i++) {
		if (IsPlayerConnected(i) == 1) {
			if (IsPlayerInAnyVehicle(i) == 1) {
				if (GetPlayerVehicleID(i) == tmpcar2[i] && ejected[i] == 1) {
   					RemovePlayerFromVehicle(i);
					SetPlayerPos(i,g,h,l);
					ejected[i] = 0;
					SendClientMessage(i, COLOR_LIGHTBLUE, "The owner of this vehicle has called it and you were ejected. Enjoy the walk loser!!!");
				}
			}
		}
	}
}

public CheckGas()
 {
  new string[256];
  for(new i=0;i<MAX_PLAYERS;i++)
   {
      if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i))
       {
          if(speedo[i] == 1 && aMessage[i] == 0 && Count[i] == 0)
	        {
	        new Float:x,Float:y,Float:z;
            new Float:distance,value;
            GetPlayerPos(i, x, y, z);
            distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
            value = floatround(distance * 11000);
            format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~b~MpH:~h~~g~%d ~r~/ ~b~KpH:~h~~g~%d ~n~~g~Fuel:~h~~r~%d",floatround(value/3600),floatround(value/2400),Gas[GetPlayerVehicleID(i)]);
	        GameTextForPlayer(i,string,850,3);
            SavePlayerPos[i][LastX] = x;
            SavePlayerPos[i][LastY] = y;
            SavePlayerPos[i][LastZ] = z;
			}
	        /*if(Gas[GetPlayerVehicleID(i)] == 90 && messaged[i] == 0 && Filling[i] == 0)
		   {
			 SendClientMessage(i,COLOR_BRIGHTRED, "Your vehicles fuel has dropped to 90%!");
			 messaged[i] = 1;
			 SetTimer("resetmessage",7000,0);
			 return 1;
		   }
  		   if(Gas[GetPlayerVehicleID(i)] == 80 && messaged[i] == 0 && Filling[i] == 0)
		   {
			 SendClientMessage(i,COLOR_BRIGHTRED, "Your vehicles fuel has dropped to 80%!");
			 messaged[i] = 1;
			 SetTimer("resetmessage",7000,0);
			 return 1;
		   }
		   if(Gas[GetPlayerVehicleID(i)] == 70 && messaged[i] == 0 && Filling[i] == 0)
		   {
			 SendClientMessage(i,COLOR_BRIGHTRED, "Your vehicles fuel has dropped to 70%!");
			 messaged[i] = 1;
			 SetTimer("resetmessage",7000,0);
			 return 1;
		   }
		   if(Gas[GetPlayerVehicleID(i)] == 60 && messaged[i] == 0 && Filling[i] == 0)
		   {
			 SendClientMessage(i,COLOR_BRIGHTRED, "Your vehicles fuel has dropped to 60%!");
			 messaged[i] = 1;
			 SetTimer("resetmessage",7000,0);
			 return 1;
		   }
		   if(Gas[GetPlayerVehicleID(i)] == 50 && messaged[i] == 0 && Filling[i] == 0)
		   {
			 SendClientMessage(i,COLOR_BRIGHTRED, "Your vehicles fuel has dropped to 50%");
			 messaged[i] = 1;
			 SetTimer("resetmessage",7000,0);
			 return 1;
		   }
		   if(Gas[GetPlayerVehicleID(i)] == 40 && messaged[i] == 0 && Filling[i] == 0)
		   {
			 SendClientMessage(i,COLOR_BRIGHTRED, "Your vehicles fuel has dropped to 40%");
			 messaged[i] = 1;
			 SetTimer("resetmessage",7000,0);
			 return 1;
		   }
		   if(Gas[GetPlayerVehicleID(i)] == 30 && messaged[i] == 0 && Filling[i] == 0)
		   {
			 SendClientMessage(i,COLOR_BRIGHTRED, "Your vehicles fuel has dropped to 30%");
			 messaged[i] = 1;
			 SetTimer("resetmessage",7000,0);
			 return 1;
		   }
		   if(Gas[GetPlayerVehicleID(i)] == 20 && messaged[i] == 0 && Filling[i] == 0)
		   {
			 SendClientMessage(i,COLOR_BRIGHTRED, "Your vehicles fuel has dropped to 20%");
			 messaged[i] = 1;
			 SetTimer("resetmessage",7000,0);
			 return 1;
		   }
		   if(Gas[GetPlayerVehicleID(i)] == 10 && messaged[i] == 0 && Filling[i] == 0)
		   {
			 SendClientMessage(i,COLOR_BRIGHTRED, "Your vehicles fuel has dropped to 10%, refuel now!!!");
			 messaged[i] = 1;
			 SetTimer("resetmessage",7000,0);
			 return 1;
		   }*/
		   if(Gas[GetPlayerVehicleID(i)] == 0 && messaged[i] == 0 && Filling[i] == 0)
		   {
			 SendClientMessage(i,COLOR_BRIGHTRED, "Your vehicles fuel has dropped to 0% and your vehicle broke down, Enjoy the walk!");
			 messaged[i] = 1;
			 new filename[256];
			 format(filename, sizeof(filename), "%d", GetPlayerVehicleID(i));
			 dini_IntSet(filename, "used", 0);
			 Gas[GetPlayerVehicleID(i)] = 100;
			 SetVehicleToRespawn(GetPlayerVehicleID(i));
			 SetTimer("resetmessage",7000,0);
			 return 1;
		   }
	      if(Gas[GetPlayerVehicleID(i)] >= 100 && Filling[i] == 1)
		   {
			 Filling[i] = 0;
			 SendClientMessage(i,COLOR_GREEN, "Your vehicle is now full. Have a nice day!");
			 return 1;
		   }
		   
	   }
   }
  return 1;
 }
 
public resetmessage()
{
    for(new i=0;i<MAX_PLAYERS;i++) {
		if(IsPlayerConnected(i) && messaged[i] == 1) {
		    messaged[i] = 0;
		    return 1;
		}
	}
	return 1;
}
public resetcar()
{
   for(new i=0;i<MAX_PLAYERS;i++) {
		if(IsPlayerConnected(i) && reset[i] == 1) {
		    reset[i] = 0;
		    new playername[MAX_PLAYER_NAME];
		    new filename[256];
    		GetPlayerName(i, playername, MAX_PLAYER_NAME);
			tmpcar[i] = dini_Int(udb_encode(playername), "carowned");
			format(filename, sizeof(filename), "%d", tmpcar[i]);
			dini_IntSet(filename, "used", 0);
			carused[i] = dini_Int(filename, "used");
			if(carused[i] == 0) {
				GetPlayerName(i, playername, MAX_PLAYER_NAME);
				new Float:a;
				GetPlayerFacingAngle(i, a);
				t = dini_Int(filename, "sx");
    			u = dini_Int(filename, "sy");
				o = dini_Int(filename, "sz");
				t += (3 * floatsin(-a, degrees));
				u += (3 * floatcos(-a, degrees));
				SetPlayerPos(i,t,u,o+3);
				SendClientMessage(i, COLOR_ORANGE, "Your vehicle has been reset and you have been teleported to it. /callcar will");
				SendClientMessage(i, COLOR_ORANGE, "work properly once you have entered your vehicle. Have a nice day!");
				return 1;
			}
		}
	}
	return 1;
}

public FuelDown()
 {
  for(new i=0;i<MAX_PLAYERS;i++)
   {
    Gas[GetPlayerVehicleID(i)]--;
   }
  return 1;
 }

public Settings()
{
	if (!dini_Exists(FILE_SETTINGS)) {
		dini_Create(FILE_SETTINGS);
		dini_Set(FILE_SETTINGS, "servername", "server");
		dini_IntSet(FILE_SETTINGS, "moneyscan", 1);
		dini_IntSet(FILE_SETTINGS, "maxmoney", 9000000);
		dini_IntSet(FILE_SETTINGS, "register", 1);
		dini_IntSet(FILE_SETTINGS, "maxusers", 2000);
		dini_IntSet(FILE_SETTINGS, "bank", 1);
		dini_IntSet(FILE_SETTINGS, "manualsaving", 1);
	}
}
public SaveData()
{
    new playername[MAX_PLAYER_NAME];

    for (new i=0;i<MAX_PLAYERS;i++) {
	    GetPlayerName(i, playername, MAX_PLAYER_NAME);
	    if (dini_Exists(udb_encode(playername)) && logged[i] == 1) {
			dini_IntSet(udb_encode(playername), "money", GetPlayerMoney(i));
       		dini_IntSet(udb_encode(playername), "bank", bank[i]);
       		PlayerInterior[i] = GetPlayerInterior(i);
       		if(PlayerInterior[i] == 0) {
				new Float:x, Float:y, Float:z;
				GetPlayerPos(i,x,y,z);
      			new Float:a;
 				GetPlayerFacingAngle(i,a);
 				dini_IntSet(udb_encode(playername), "a", floatround(a));
				dini_IntSet(udb_encode(playername), "x", floatround(x));
				dini_IntSet(udb_encode(playername), "y", floatround(y));
				dini_IntSet(udb_encode(playername), "z", floatround(z));
			}
		}
	}

    return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	new fuelper[256];
	switch(getCheckpointType(playerid))
	{
		case CP_STATION1:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
       	case CP_STATION2:
		if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
		}
       	case CP_STATION3:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
		}
       	case CP_STATION4:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
       	case CP_STATION5:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
       	case CP_STATION6:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
   		case CP_STATION7:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
       	case CP_STATION8:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
       	case CP_STATION9:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
       	case CP_STATION10:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
       	case CP_STATION11:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
       	case CP_STATION12:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
        	case CP_STATION13:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
       	case CP_STATION14:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
        case CP_STATION15:
	   	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
	   	case CP_STATION16:
	   	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
	   	case CP_LVSTATION:
	   	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
	   	case CP_VMSTATION:
	   	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
	   	case CP_LSSTATION:
	   	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
	   	case CP_SFSTATION:
	   	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(fuelper,sizeof(fuelper),"You stopped refuelling and the vehicle is only %d%s full!",Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
	   	case PROP1: {
			propactive[playerid] = 0;
		}
	}
}


public OnPlayerEnterCheckpoint(playerid)
{
    switch(getCheckpointType(playerid))
	{
		case CP_STATION1:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel your vehicle");

	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
        }
       	case CP_STATION2:
		if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel your vehicle");
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION3:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel your vehicle");
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION4:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel your vehicle");
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION5:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel your vehicle");
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION6:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel your vehicle");
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
   		case CP_STATION7:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel your vehicle");
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION8:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel your vehicle");
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION9:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel your vehicle");
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION10:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel your vehicle");
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION11:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel your vehicle");
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION12:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel your vehicle");
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
        	case CP_STATION13:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel your vehicle");
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION14:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel your vehicle");
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
        case CP_STATION15:
	   	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel your vehicle");
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
	   	case CP_STATION16:
	   	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel your vehicle");
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
	   	case CP_LVSTATION:
	   	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel plane or helicopter");
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
	   	case CP_VMSTATION:
	   	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel plane or helicopter");
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
	   	case CP_LSSTATION:
	   	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel plane or helicopter");
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
	   	case CP_SFSTATION:
	   	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Type /refuel to re-fuel plane or helicopter");
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
		case CP_BANK: {
			SendClientMessage(playerid, COLOR_YELLOW, "You are at an ATM. To store money use '/bank amount', to withdraw");
			SendClientMessage(playerid, COLOR_YELLOW, "money, use '/withdraw amount', and use '/balance' to see your balance.");
		}
		case CP_BANK_2: {
			SendClientMessage(playerid, COLOR_YELLOW, "You are at an ATM. To store money use '/bank amount', to withdraw");
			SendClientMessage(playerid, COLOR_YELLOW, "money, use '/withdraw amount', and use '/balance' to see your balance.");
		}
		case CP_BANK_3: {
			SendClientMessage(playerid, COLOR_YELLOW, "You are at an ATM. To store money use '/bank amount', to withdraw");
			SendClientMessage(playerid, COLOR_YELLOW, "money, use '/withdraw amount', and use '/balance' to see your balance.");
		}
		case PROP1: {
		format(cttmp, sizeof(cttmp), "%s","PROP1");
		ownername = dini_Get(cttmp,"owner");
 		GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
		housecost[playerid] = dini_Int(cttmp,"housecost");
        propowned[playerid] = dini_Int(cttmp,"bought");
        propactive[playerid] = 1;
	  	if(strcmp(ownername,"server",false) == 0)
	   	{
	   	    format(propmess,sizeof(propmess),"This property is currently vacant and can be purchased for $%d by typing /buyprop", housecost[playerid]);
		 	buyable[playerid] = 1;
		 	SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 	return 1;
	   	}
	   	if(strcmp(ownername,playernameh,false) == 0) {
	    	   	format(propmess,sizeof(propmess),"Welcome home %s", ownername);
   		       	buyable[playerid] = 0;
   		       	SendClientMessage(playerid,COLOR_GREEN,propmess);
   		       	return 1;
		}
		else {
               format(propmess,sizeof(propmess),"This property belongs to %s, and is not for sale!", ownername);
               buyable[playerid] = 0;
               SendClientMessage(playerid,COLOR_YELLOW,propmess);
               return 1;
			}
		}
   }
   return 0;
}

public Fill()
 {
  for(new i=0;i<MAX_PLAYERS;i++)
   {
	if(Filling[i] == 1)
	  {
        Gas[GetPlayerVehicleID(i)]++;
        GivePlayerMoney(i,-2);
      }
   }
  return 1;
 }

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new filename[256];
	if(newstate == PLAYER_STATE_DRIVER) {
	    new string[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		new val1[256];
		new playername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
		val1 = dini_Get(filename, "owner");
 		secure[playerid] = dini_Int(filename, "secure");
 		admined[playerid] = dini_Int(filename, "asecure");
        if(admined[playerid] == 1) {
            if(PlayerInfo[playerid][pAdmin] > 0) {
				SendClientMessage(playerid,COLOR_AQUA,"This vehicle is currently set for admin use only. It will eject anyone who is not an admin.");
				used[playerid] = 1;
				SetTimer("fuelremain",100,0);
 		    	return 1;
			}
     		GetPlayerPos(playerid,ta,tb,tc);
     		SetPlayerPos(playerid,ta,tb,tc+5);
     		RemovePlayerFromVehicle(playerid);
 			format(string, sizeof(string), "This vehicle has been set to allow admin/moderator control only and you are prohibited from using it.", val1);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}
		if(admined[playerid] == 2) {
		    if(PlayerInfo[playerid][pAdmin] > 0) {
		        SendClientMessage(playerid,COLOR_AQUA,"This vehicle is currently set for admin use only. It will kill anyone who is not an admin.");
		        used[playerid] = 1;
				SetTimer("fuelremain",100,0);
 		    	return 1;
			}
			RemovePlayerFromVehicle(playerid);
			SetPlayerHealth(playerid, -999);
 			format(string, sizeof(string), "Server administration has set this vehicle to kill anyone who try's to drive it...R.I.P loser!");
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			format(string, sizeof(string), "%s just tried to steal an admin only vehicle and was killed by the security system...R.I.P loser!",playername);
			SendClientMessageToAll(COLOR_AQUA, string);
			return 1;
		}
		if(secure[playerid] == 0) {
			if (strcmp(val1,playername,false) == 0) {
				SendClientMessage(playerid, COLOR_GREEN, "Your vehicle security system is currently deactivated.");
		    	used[playerid] = 1;
				SetTimer("fuelremain",100,0);
		    	return 1;
			}
		}
	 	if(secure[playerid] == 1) {
	 	    if (strcmp(val1,playername,false) == 0) {
				SendClientMessage(playerid, COLOR_GREEN, "Your vehicle security system is currently set to eject intruders.");
		    	used[playerid] = 1;
				SetTimer("fuelremain",100,0);
		    	return 1;
			}
     		GetPlayerPos(playerid,ta,tb,tc);
     		SetPlayerPos(playerid,ta,tb,tc+5);
     		RemovePlayerFromVehicle(playerid);
 			format(string, sizeof(string), "The owner of this vehicle %s, has secured this vehicle and you are prohibited from using it.", val1);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}
 		if(secure[playerid] == 2) {
 		    if (strcmp(val1,playername,false) == 0) {
				SendClientMessage(playerid, COLOR_GREEN, "Your vehicle security system is currently set to kill intruders.");
		    	used[playerid] = 1;
				SetTimer("fuelremain",100,0);
		    	return 1;
			}
			RemovePlayerFromVehicle(playerid);
			SetPlayerHealth(playerid, -999);
 			format(string, sizeof(string), "The owner of this vehicle %s, has set this vehicle to kill anyone who try's to drive it...R.I.P loser!", val1);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			format(string, sizeof(string), "%s just tried to steal %s's vehicle and was killed by the security system...R.I.P loser!",playername,val1);
			SendClientMessageToAll(COLOR_LIGHTBLUE, string);
			return 1;
		}
		used[playerid] = 1;
		SetTimer("fuelremain",100,0);
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	new filename[256];
	format(filename, sizeof(filename), "%d", vehicleid);
	new val1[256];
	new playername[MAX_PLAYER_NAME];
	dini_IntSet(filename, "used", 1);
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	val1 = dini_Get(filename, "owner");
 	secure[playerid] = dini_Int(filename, "secure");
	new tmp[256];
	tmp[playerid] = ispassenger;
	passenger[playerid] = ispassenger;
	currentvehicle[playerid] = GetPlayerVehicleID(playerid);
	if(tmp[playerid] == 0 && logged[playerid] == 1) {
		format(filename, sizeof(filename), "%d", vehicleid);
    	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
    	    new tmp1[256], tmp2[256];
    	    tmp1 = dini_Get(filename, "owner");
    	    tmp2 = dini_Get(udb_encode(playername), "name");
    	    if (strcmp(tmp1,tmp2,false) == 0) {
				new string[256];
				carcost[playerid] = dini_Int(filename, "carcost");
				format(string, sizeof(string), "Welcome to your vehicle %s, please drive carefully!", tmp1);
				SendClientMessage(playerid, COLOR_GREEN, string);
				ignition[playerid] = 1;
				return 1;
			}
			if (strcmp(tmp1,server,false) == 0) {
			    new string[256];
			    carcost[playerid] = dini_Int(filename, "carcost");
    	        format(string, sizeof(string), "This vehicle is for sale and costs $%d, type /buycar to buy this vehicle.", carcost[playerid]);
    	        SendClientMessage(playerid, COLOR_YELLOW, string);
    	        return 1;
			}
   			else {
    	        new string[256];
    	        carcost[playerid] = dini_Int(filename, "carcost");
    	        format(string, sizeof(string), "This vehicle belongs to %s, and cannot be purchased.", tmp1);
    	        SendClientMessage(playerid, COLOR_BRIGHTRED, string);
    	        return 1;
			}
    	
    }
	return 1;
}

public fuelremain()
{
	for(new i=0;i<MAX_PLAYERS;i++)
   	{
		if(used[i] == 1)
		{
		    if(IsPlayerInAnyVehicle(i))
		    {
		    	new fuelper[256];
		    	used[i] = 0;
        		format(fuelper,sizeof(fuelper),"This vehicle has %d%s of it's fuel remaining.",Gas[GetPlayerVehicleID(i)],"%");
    			SendClientMessage(i, COLOR_BRIGHTRED, fuelper);
    			return 1;
    		}
 		}
 		if(used[i] == 1)
	 	{
 			used[i] = 0;
		}
   	}
   	return 1;
}
