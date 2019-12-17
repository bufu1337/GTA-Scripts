//-------------This game mode was designed by tAxI aka Necrioss------------//
//-------------------email <::> cptnsausage@hotmail.com--------------------//
//---------If you are having problems please feel free to contact me-------//
//--------If u use this code in your gamemode you MUST give me credit------//
#include <a_samp>
#include <dini>
#include <dudb>
#include <time>
#include <file>
#include <dutils>
#include <float>

#pragma dynamic 40000

#define FILE_SETTINGS "settings.ini"

#define CallCost 1

#define MAX_CARS 251
#define MAX_POINTS 83
#define BIZ_AMOUNT 60

#define GasMax 100
#define RunOutTime 6250

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
#define BIZ1 			23
#define BIZ2			24
#define BIZ3    25
#define BIZ4    26
#define BIZ5    27
#define BIZ6    28
#define BIZ7    29
#define BIZ8    30
#define BIZ9    31
#define BIZ10   32
#define BIZ11   33
#define BIZ12   34
#define BIZ13   35
#define BIZ14   36
#define BIZ15   37
#define BIZ16   38
#define BIZ17   39
#define BIZ18   40
#define BIZ19   41
#define BIZ20   42
#define BIZ21   43
#define BIZ22   44
#define BIZ23   45
#define BIZ24   46
#define BIZ25   47
#define BIZ26   48
#define BIZ27   49
#define BIZ28   50
#define BIZ29   51
#define BIZ30   52
#define BIZ31   53
#define BIZ32   54
#define BIZ33   55
#define BIZ34   56
#define BIZ35   57
#define BIZ36   58
#define BIZ37   59
#define BIZ38   60
#define BIZ39   61
#define BIZ40   62
#define BIZ41   63
#define BIZ42   64
#define BIZ43   65
#define BIZ44   66
#define BIZ45   67
#define BIZ46   68
#define BIZ47   69
#define BIZ48   70
#define BIZ49   71
#define BIZ50   72
#define BIZ51   73
#define BIZ52   74
#define BIZ53   75
#define BIZ54   76
#define BIZ55   77
#define BIZ56   78
#define BIZ57   79
#define BIZ58   80
#define BIZ59   81
#define BIZ60   82

new VehicleName[212][0] = {
   "Landstalker",
   "Bravura",
   "Buffalo",
   "Linerunner",
   "Pereniel",
   "Sentinel",
   "Dumper",
   "Firetruck",
   "Trashmaster",
   "Stretch",
   "Manana",
   "Infernus",
   "Voodoo",
   "Pony",
   "Mule",
   "Cheetah",
   "Ambulance",
   "Leviathan",
   "Moonbeam",
   "Esperanto",
   "Taxi",
   "Washington",
   "Bobcat",
   "Mr Whoopee",
   "BF Injection",
   "Hunter",
   "Premier",
   "Enforcer",
   "Securicar",
   "Banshee",
   "Predator",
   "Bus",
   "Rhino",
   "Barracks",
   "Hotknife",
   "Trailer", //artict1
   "Previon",
   "Coach",
   "Cabbie",
   "Stallion",
   "Rumpo",
   "RC Bandit",
   "Romero",
   "Packer",
   "Monster Truck",
   "Admiral",
   "Squalo",
   "Seasparrow",
   "Pizzaboy",
   "Tram",
   "Trailer", //artict2
   "Turismo",
   "Speeder",
   "Reefer",
   "Tropic",
   "Flatbed",
   "Yankee",
   "Caddy",
   "Solair",
   "Berkley's RC Van",
   "Skimmer",
   "PCJ-600",
   "Faggio",
   "Freeway",
   "RC Baron",
   "RC Raider",
   "Glendale",
   "Oceanic",
   "Sanchez",
   "Sparrow",
   "Patriot",
   "Quad",
   "Coastguard",
   "Dinghy",
   "Hermes",
   "Sabre",
   "Rustler",
   "ZR-350",
   "Walton",
   "Regina",
   "Comet",
   "BMX",
   "Burrito",
   "Camper",
   "Marquis",
   "Baggage",
   "Dozer",
   "Maverick",
   "News Chopper",
   "Rancher",
   "FBI Rancher",
   "Virgo",
   "Greenwood",
   "Jetmax",
   "Hotring",
   "Sandking",
   "Blista Compact",
   "Police Maverick",
   "Boxville",
   "Benson",
   "Mesa",
   "RC Goblin",
   "Hotring Racer", //hotrina
   "Hotring Racer", //hotrinb
   "Bloodring Banger",
   "Rancher",
   "Super GT",
   "Elegant",
   "Journey",
   "Bike",
   "Mountain Bike",
   "Beagle",
   "Cropdust",
   "Stunt",
   "Tanker", //petro
   "RoadTrain",
   "Nebula",
   "Majestic",
   "Buccaneer",
   "Shamal",
   "Hydra",
   "FCR-900",
   "NRG-500",
   "HPV1000",
   "Cement Truck",
   "Tow Truck",
   "Fortune",
   "Cadrona",
   "FBI Truck",
   "Willard",
   "Forklift",
   "Tractor",
   "Combine",
   "Feltzer",
   "Remington",
   "Slamvan",
   "Blade",
   "Freight",
   "Streak",
   "Vortex",
   "Vincent",
   "Bullet",
   "Clover",
   "Sadler",
   "Firetruck", //firela
   "Hustler",
   "Intruder",
   "Primo",
   "Cargobob",
   "Tampa",
   "Sunrise",
   "Merit",
   "Utility",
   "Nevada",
   "Yosemite",
   "Windsor",
   "Monster Truck", //monstera
   "Monster Truck", //monsterb
   "Uranus",
   "Jester",
   "Sultan",
   "Stratum",
   "Elegy",
   "Raindance",
   "RC Tiger",
   "Flash",
   "Tahoma",
   "Savanna",
   "Bandito",
   "Freight", //freiflat
   "Trailer", //streakc
   "Kart",
   "Mower",
   "Duneride",
   "Sweeper",
   "Broadway",
   "Tornado",
   "AT-400",
   "DFT-30",
   "Huntley",
   "Stafford",
   "BF-400",
   "Newsvan",
   "Tug",
   "Trailer", //petrotr
   "Emperor",
   "Wayfarer",
   "Euros",
   "Hotdog",
   "Club",
   "Trailer", //freibox
   "Trailer", //artict3
   "Andromada",
   "Dodo",
   "RC Cam",
   "Launch",
   "Police Car (LSPD)",
   "Police Car (SFPD)",
   "Police Car (LVPD)",
   "Police Ranger",
   "Picador",
   "S.W.A.T. Van",
   "Alpha",
   "Phoenix",
   "Glendale",
   "Sadler",
   "Luggage Trailer", //bagboxa
   "Luggage Trailer", //bagboxb
   "Stair Trailer", //tugstair
   "Boxville",
   "Farm Plow", //farmtr1
   "Utility Trailer" //utiltr1
};

new	heavycar[24][0] = {
	{406},
	{444},
	{556},
	{557},
	{573},
	{601},
	{407},
	{427},
	{433},
	{434},
	{499},
	{498},
	{482},
	{431},
	{524},
	{578},
	{455},
	{403},
	{414},
	{443},
	{515},
	{428},
	{408},
	{456}
};
new	boat[11][0] = {
	{472},
	{473},
	{493},
	{595},
	{484},
	{430},
	{453},
	{452},
	{446},
	{454},
	{539}
};
new	mbike[11][0] = {
	{581},
	{521},
	{462},
	{463},
	{468},
	{471},
	{586},
	{522},
	{523},
	{461},
	{448}
};
new	pbike[3][0] = {
	{481},
	{509},
	{510}
};
new	splane[6][0] = {
	{593},
	{512},
	{513},
	{460},
	{464},
	{465}
};
new	mplane[2][0] = {
	{519},
	{511}
};
new	lplane[2][0] = {
	{553},
	{592}
};
new milair[4][0] = {
	{520},
	{476},
	{447},
	{425}
};
new sheli[4][0] = {
	{487},
	{488},
	{469},
	{497}
};
new lheli[3][0] = {
	{417},
	{548},
	{563}
};


new spoiler[20][0] = {
	{1000},
	{1001},
	{1002},
	{1003},
	{1014},
	{1015},
	{1016},
	{1023},
	{1058},
	{1060},
	{1049},
	{1050},
	{1138},
	{1139},
	{1146},
	{1147},
	{1158},
	{1162},
	{1163},
	{1164}
};

new nitro[3][0] = {
    {1008},
    {1009},
    {1010}
};

new fbumper[23][0] = {
    {1117},
    {1152},
    {1153},
    {1155},
    {1157},
    {1160},
    {1165},
    {1167},
    {1169},
    {1170},
    {1171},
    {1172},
    {1173},
    {1174},
    {1175},
    {1179},
    {1181},
    {1182},
    {1185},
    {1188},
    {1189},
    {1192},
    {1193}
};

new rbumper[22][0] = {
    {1140},
    {1141},
    {1148},
    {1149},
    {1150},
    {1151},
    {1154},
    {1156},
    {1159},
    {1161},
    {1166},
    {1168},
    {1176},
    {1177},
    {1178},
    {1180},
    {1183},
    {1184},
    {1186},
    {1187},
    {1190},
    {1191}
};

new exhaust[28][0] = {
    {1018},
    {1019},
    {1020},
    {1021},
    {1022},
    {1028},
    {1029},
    {1037},
    {1043},
    {1044},
    {1045},
    {1046},
    {1059},
    {1064},
    {1065},
    {1066},
    {1089},
    {1092},
    {1104},
    {1105},
    {1113},
    {1114},
    {1126},
    {1127},
    {1129},
    {1132},
    {1135},
    {1136}
};

new bventr[2][0] = {
    {1042},
    {1044}
};

new bventl[2][0] = {
    {1043},
    {1045}
};

new bscoop[4][0] = {
	{1004},
	{1005},
	{1011},
	{1012}
};

new rscoop[13][0] = {
    {1006},
    {1032},
    {1033},
    {1035},
    {1038},
    {1053},
    {1054},
    {1055},
    {1061},
    {1067},
    {1068},
    {1088},
    {1091}
};

new lskirt[21][0] = {
    {1007},
    {1026},
    {1031},
    {1036},
    {1039},
    {1042},
    {1047},
    {1048},
    {1056},
    {1057},
    {1069},
    {1070},
    {1090},
    {1093},
    {1106},
    {1108},
    {1118},
    {1119},
    {1133},
    {1122},
    {1134}
};

new rskirt[21][0] = {
    {1017},
    {1027},
    {1030},
    {1040},
    {1041},
    {1051},
    {1052},
    {1062},
    {1063},
    {1071},
    {1072},
    {1094},
    {1095},
    {1099},
    {1101},
    {1102},
    {1107},
    {1120},
    {1121},
    {1124},
    {1137}
};

new hydraulics[1][0] = {
    {1087}
};

new base[1][0] = {
    {1086}
};

new rbbars[2][0] = {
    {1109},
    {1110}
};

new fbbars[2][0] = {
    {1115},
    {1116}
};

new wheels[17][0] = {
    {1025},
    {1073},
    {1074},
    {1075},
    {1076},
    {1077},
    {1078},
    {1079},
    {1080},
    {1081},
    {1082},
    {1083},
    {1084},
    {1085},
    {1096},
    {1097},
    {1098}
};

new lights[2][0] = {
	{1013},
	{1024}
};

enum pInfo
{
    pAdmin,
    pJailedby,
}

new modtier[MAX_CARS];
new col1[MAX_CARS];
new col2[MAX_CARS];

new gVehicleClass[MAX_VEHICLES];
new gVC;

new playercount[MAX_PLAYERS];
new biznote[MAX_PLAYERS];
new carnote[MAX_PLAYERS];
new Calling[MAX_PLAYERS];
new Answered[MAX_PLAYERS];
new Callerid[MAX_PLAYERS];
new allowprofit[MAX_PLAYERS];
new profit[MAX_PLAYERS];
new totalprofit[MAX_PLAYERS];
new bizid[MAX_PLAYERS];
new cttmp[256];
new tmpname[256];
new ownername[256];
new propmess[256];
new propcost[MAX_PLAYERS];
new propowned[MAX_PLAYERS];
new buyable[MAX_PLAYERS];
new playernameh[MAX_PLAYER_NAME];
new playerbiz[MAX_PLAYERS];
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
new amount[MAX_PLAYERS];
new biznum[MAX_PLAYERS];
new telemoney[MAX_PLAYERS];
new carbuyable[MAX_PLAYERS];
new bizbuyable[MAX_PLAYERS];
new tempid[MAX_PLAYERS];
new carname[256];
new lockmess[256];
new securemess[256];
new carmess[256];
new password[256];
new oldvehcount;

new modded[MAX_CARS];
new savemods[MAX_CARS];

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
forward Float:PlayerDistToVehicleSpawn(playerid,vehicleid);

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
{2059.7805,1020.1033,2289.0493,1193.4093},
{2055.5642,1533.3348,2200.9768,1753.8568},
{2114.8748,1775.9012,2277.7209,1891.3472},
{2146.1289,1893.4567,2342.6091,1950.9486},
{2137.8066,2038.1023,2223.3726,2143.6411},
{2225.2517,2088.4695,2359.3306,2143.9646},
{1842.4160,1264.5808,2059.4907,1454.3223},
{1968.2183,929.2423,2054.0447,1096.8796},
{2056.7427,1444.7155,2190.7131,1537.8398},
{2537.2771,2232.3604,2664.7832,2461.8420},
{2027.6141,2288.6062,2177.2280,2443.9287},
{2322.5151,1603.0068,2550.0662,1714.9113},
{1976.6951,1846.7843,2138.2932,2028.0287},
{2517.0713,2125.2759,2540.1426,2140.9841},
{2517.1316,2279.6184,2540.0034,2314.0369},
{2309.3223,2231.9849,2239.1592,2263.0171},
{2307.8157,2404.8630,2365.8564,2427.3931},
{2113.8269,1420.0763,2169.8450,1448.3851},
{2133.8765,1424.9305,2158.0867,1449.6304},
{2081.6860,2033.0593,2136.8855,2121.2231},
{2405.2615,2044.4905,2429.2261,2070.7527},
{2512.7620,2292.9004,2538.0837,2316.1021},
{2405.6833,2001.2031,2427.2678,2024.1396},
{2210.8799,1418.5393,2221.6172,1434.6121}, //num24
{1004.0436,1378.4221,1238.1447,1789.2527},
{1303.5311,2043.1515,1575.4657,2310.8394},
{1982.6249,1481.2999,2055.5203,1587.4567},
{2138.1567,908.3344,2207.1643,980.6557},
{2518.3003,2046.3043,2621.8103,2114.5112},
{2501.6440,1985.4578,2550.4285,2055.2839},
{2484.2690,2229.0103,2534.2617,2246.9116},
{2166.9695,1354.7913,2251.1807,1443.4131},
{1921.2307,2014.2312,1995.0787,2118.3655},
{2076.9065,2203.9939,2086.9548,2222.7378},
{2516.0190,2140.3875,2549.2168,2156.4136},
{2579.2708,1827.0596,2638.5925,1869.3435},
{2102.8501,2225.0020,2128.5029,2233.7532},
{2341.3113,2023.0891,2418.6460,2059.8914},
{2601.2441,1656.5068,2637.8970,1678.0903},
{2336.8066,2054.1135,2403.8230,2083.4001},
{2421.8442,1971.7770,2507.7588,2059.8337},
{1101.3241,2043.9854,1189.1630,2148.9053},
{2427.3594,2044.5748,2449.6052,2070.0330},
{2467.3035,2037.6560,2527.0105,2068.9089},
{2347.1316,2086.8259,2436.4583,2143.5769},
{2102.3923,2232.8354,2132.9700,2279.6086},
{2086.9155,2206.2480,2095.4680,2223.6389},
{2404.2832,1967.7424,2439.7622,2000.2843},
{2172.5940,1458.2136,2201.1655,1537.2443},
{2094.0740,2204.3918,2104.2151,2223.1936},
{2206.0823,1947.1849,2137.1362,2023.3031},
{2449.7007,2043.6879,2469.7415,2074.7456},
{2503.3691,1940.5511,2610.8059,2002.4291},
{2514.7412,2153.7595,2546.4314,2176.9170},
{2515.2012,2324.6948,2542.5288,2350.3384},
{2089.9951,2107.3723,2129.4351,2138.4326},
{2035.4915,2104.2634,2089.2329,2126.5642},
{2337.3936,1961.5359,2392.2026,2023.3726},
{2197.4590,1418.8319,2212.3408,1436.3138},
{2219.5940,1416.0967,2250.4465,1436.7446}
};

new Float:checkpoints[MAX_POINTS][4] = {
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
{2181.2170,1117.3793,12.2120,2.5},
{2185.4421,1691.4431,10.6553,2.5},
{2219.9041,1839.5925,10.3847,2.5},
{2162.7468,1903.8865,10.3884,2.5},
{2167.2166,2117.6150,10.3809,2.5},
{2317.3208,2117.7710,10.3882,2.5},
{1934.8152,1344.3130,9.5411,2.5},
{2028.6173,997.6895,10.3901,2.5},
{2139.1824,1483.6544,10.3850,2.5},
{2634.2117,2342.9260,10.2322,2.5},
{2127.1482,2374.2432,10.3928,2.5},
{2433.9910,1694.5219,10.3891,2.5},
{2027.4666,1919.8239,11.8970,2.5},
{2535.0242,2137.1760,10.3844,2.5},
{2533.9272,2290.7966,10.3965,2.5},
{2292.8953,2250.4241,10.3915,2.5},
{2327.7629,2418.4009,10.3137,2.5},
{2125.8101,1439.5314,10.3825,2.5},
{2144.4243,1438.7078,10.3857,2.5},
{2088.1013,2080.2449,10.5105,2.5},
{2413.2683,2063.5012,10.3790,2.5},
{2516.7546,2302.4880,10.3827,2.5},
{2412.0635,2016.4637,10.3789,2.5},
{2215.1062,1431.6699,10.6265,2.5},
{1098.4010,1611.0776,12.1107,2.5},
{1479.4565,2252.0762,10.5973,2.5},
{2004.3060,1544.7435,13.1615,2.5},
{2155.3611,937.0895,10.3759,2.5},
{2536.4421,2078.7681,10.3914,2.5},
{2518.4578,2033.5502,10.6029,2.5},
{2500.1050,2240.7932,10.3955,2.5},
{2200.1270,1388.8220,10.3802,2.5},
{1945.0096,2069.8103,10.3847,2.5},
{2081.3513,2221.6086,10.3705,2.5},
{2537.7957,2151.2844,10.3940,2.5},
{2634.9871,1845.2051,10.5572,2.5},
{2107.3560,2229.2830,10.7454,2.5},
{2395.3364,2044.5300,10.3796,2.5},
{2635.2498,1673.8412,10.5941,2.5},
{2364.5168,2076.1494,10.3798,2.5},
{2464.9089,2034.4392,10.5851,2.5},
{1162.8470,2070.3850,10.3921,2.5},
{2436.7664,2061.3137,10.3951,2.5},
{2490.2861,2062.2139,10.3753,2.5},
{2366.6399,2123.9949,10.4007,2.5},
{2106.3506,2250.8586,10.5889,2.5},
{2090.6064,2220.4714,10.3877,2.5},
{2411.2610,1992.9418,10.3783,2.5},
{2195.4019,1469.8882,10.3641,2.5},
{2095.6563,2221.7317,10.3953,2.5},
{2192.3142,1986.8772,11.6534,2.5},
{2456.7498,2060.2307,10.3932,2.5},
{2542.1289,1969.6676,10.3852,2.5},
{2536.7393,2162.0422,10.3918,2.5},
{2519.7532,2335.0073,10.3927,2.5},
{2099.8533,2120.0144,10.3961,2.5},
{2070.7163,2120.6021,10.3895,2.5},
{2366.6096,1981.6423,10.3858,2.5},
{2206.2791,1431.5449,10.6267,2.5},
{2228.6863,1431.7811,10.6125,2.5}

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
	BIZ1,
	BIZ2,
	BIZ3,
	BIZ4,
	BIZ5,
	BIZ6,
	BIZ7,
	BIZ8,
	BIZ9,
	BIZ10,
	BIZ11,
	BIZ12,
	BIZ13,
	BIZ14,
	BIZ15,
	BIZ16,
	BIZ17,
	BIZ18,
	BIZ19,
	BIZ20,
	BIZ21,
	BIZ22,
	BIZ23,
	BIZ24,
	BIZ25,
	BIZ26,
	BIZ27,
	BIZ28,
	BIZ29,
	BIZ30,
	BIZ31,
	BIZ32,
	BIZ33,
	BIZ34,
	BIZ35,
	BIZ36,
	BIZ37,
	BIZ38,
	BIZ39,
	BIZ40,
	BIZ41,
	BIZ42,
	BIZ43,
	BIZ44,
	BIZ45,
	BIZ46,
	BIZ47,
	BIZ48,
	BIZ49,
	BIZ50,
	BIZ51,
	BIZ52,
    BIZ53,
    BIZ54,
    BIZ55,
    BIZ56,
    BIZ57,
    BIZ58,
    BIZ59,
    BIZ60,
};

new Float:ta, Float:tb, Float:tc;
new logged[MAX_PLAYERS];
new bank[999];
new PlayerInterior[MAX_PLAYERS];
new gPlayerClass[MAX_PLAYERS];
new carused[MAX_PLAYERS];
new Gas[256];
new Filling[MAX_PLAYERS];
new playerCheckpoint[MAX_PLAYERS];
new reset[MAX_PLAYERS];
new ejected[MAX_PLAYERS];
new atone[MAX_PLAYERS];
new gSpawnx[MAX_CARS];
new gSpawny[MAX_CARS];
new gSpawnz[MAX_CARS];

main()
{
	print("\n----------------------------------");
	print("  tAxI's Freeroam with Vehicle & Business Saving v5.1b");
	print("----------------------------------\n");
}

public PhoneCut()
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			if (Calling[i] > -1 && Answered[i] == 1 && Callerid[i] == 1)
			{
				if (GetPlayerMoney(i) >= CallCost)
				{
					GivePlayerMoney(i, -CallCost);
				}
				if (GetPlayerMoney(i) < CallCost)
				{
					SendClientMessage(i, COLOR_BRIGHTRED, "CUT OFF: You don't have enough cash to continue this call");
					SendClientMessage(Calling[i], COLOR_BRIGHTRED, "CUT OFF: Your recipient's phone has been cut off due to lack of credit");
					Calling[Calling[i]] = -1;
					Answered[Calling[i]] = 0;
					Calling[i] = -1;
					Answered[i] = 0;
					Callerid[i] = 0;
				}
			}
		}
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if (Calling[playerid] > -1 && Answered[playerid] == 1)
	{
    	new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s: %s", sendername, text);
		SendClientMessage(Calling[playerid], COLOR_YELLOW, string);
		format(string, sizeof(string), "%s: %s", sendername, text);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "%s: %s", sendername, text);
		print(string);
		format(string, sizeof(string), "%s: %s", sendername, text);
		print(string);
		return 0;
	}
	return 1;
}

public OnGameModeExit()
{
	dini_IntSet(FILE_SETTINGS,"vehicleresetcount",gVC);
	return 1;
}

public OnGameModeInit()
{
    EnableTirePopping(1);
	print("GameModeInit()");
	SetGameModeText("tAxI's Freeroam with Vehicle & Business Saving v5.1b");
	SetTimer("SaveData",2000,1);
    SetTimer("Settings",5000,1);
    SetTimer("checkpointUpdate",500, 1);
    SetTimer("scoreupdate",1000,1);
    SetTimer("FuelDown", RunOutTime, 1);
    SetTimer("CheckGas", 500, 1);
    SetTimer("Fill", 200, 1);
    SetTimer("fillcheck", 100, 1);
    SetTimer("ctimer",1000,1);
    SetTimer("profitup",300000,1);
    SetTimer("PhoneCut",1000,1);
    SetTimer("modvehicletimed",1000,1);
	oldvehcount = dini_Int(FILE_SETTINGS,"vehicleresetcount");

    
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
	AddStaticVehicle2(553,423.4869,2502.1841,17.8202,89.0666,1,8); //
	
	//Passenger Jet - $3,500,000
	AddStaticVehicle2(592,1477.7163,1806.5377,12.0074,179.7712,1,1); //
	
	//private jets - $1,000,000
	AddStaticVehicle2(519,1360.0583,1756.0156,11.7412,269.0888,1,1); //
	AddStaticVehicle2(519,1357.5444,1714.6675,11.7392,272.2202,1,1); //
	
	//basic plane...dodo - $400,000
	AddStaticVehicle2(593,325.8835,2539.8596,17.2716,180.3894,58,8); //
	AddStaticVehicle2(593,291.1174,2541.4001,17.2777,181.4973,58,8); //
	AddStaticVehicle2(593,1621.7692,1291.2151,11.2733,134.9260,58,8); //
	AddStaticVehicle2(593,1627.8450,1258.3723,11.2710,89.9188,58,8); //
	
	//monstertrucks - $100,000
	AddStaticVehicle2(444,420.4435,2530.6880,16.9836,182.9841,1,3); //
	AddStaticVehicle2(444,429.5020,2533.3752,16.8653,177.6943,1,3); //
	AddStaticVehicle2(557,307.8141,2535.6982,17.1916,180.2179,1,1); //
	AddStaticVehicle2(556,-384.5375,2191.6282,42.7897,284.9403,1,1); //
	AddStaticVehicle2(556,-373.6553,2268.8379,42.5869,94.9769,1,1); //13
	
	//militery - armed - $2,000,000
	AddStaticVehicle2(425,372.8860,1907.0579,18.2127,89.8701,43,0); //
	AddStaticVehicle2(476,1283.0006,1324.8849,9.5332,275.0468,7,6);
	AddStaticVehicle2(476,1283.5107,1361.3171,9.5382,271.1684,1,6);
	AddStaticVehicle2(476,1283.6847,1386.5137,11.5300,272.1003,89,91);
	AddStaticVehicle2(476,1288.0499,1403.6605,11.5295,243.5028,119,117);
	AddStaticVehicle2(520,279.2560,1957.0870,18.3605,271.5373,0,0); //19
	
	//millitary truck - $100,000
	AddStaticVehicle2(433,278.4932,2017.9794,18.0773,301.3855,43,0); //20
	AddStaticVehicle2(433,276.5954,2030.9923,18.0772,244.9951,43,0); //21
	
	//large helicopter - $750,000
	AddStaticVehicle2(548,374.5181,1941.1318,19.2787,91.4614,1,1); //
	AddStaticVehicle2(548,364.7947,1981.3463,19.2466,90.8673,1,1); //
	AddStaticVehicle2(417,1284.6808,1521.0535,10.9101,273.2997,0,0); //
	AddStaticVehicle2(417,1285.1741,1553.1807,10.9067,270.2105,0,0); //
	AddStaticVehicle2(563,1348.2197,1623.1259,11.5257,269.6316,1,6); //
	AddStaticVehicle2(563,1356.4004,1582.4369,11.5257,267.4544,1,6); //27
	
	//small helicopter - $450,000
	AddStaticVehicle2(487,2093.2754,2414.9421,74.7556,89.0247,26,57);
	AddStaticVehicle2(487,1614.7153,1548.7513,11.2749,347.1516,58,8);
	AddStaticVehicle2(487,1647.7902,1538.9934,11.2433,51.8071,0,8);
	AddStaticVehicle2(487,1608.3851,1630.7268,11.2840,174.5517,58,8);//31
	
 	AddStaticVehicle2(451,2040.0520,1319.2799,10.3779,183.2439,16,16);
	AddStaticVehicle2(429,2040.5247,1359.2783,10.3516,177.1306,13,13);
	AddStaticVehicle2(421,2110.4102,1398.3672,10.7552,359.5964,13,13);
	AddStaticVehicle2(411,2074.9624,1479.2120,10.3990,359.6861,64,64);
	AddStaticVehicle2(477,2075.6038,1666.9750,10.4252,359.7507,94,94);
	AddStaticVehicle2(541,2119.5845,1938.5969,10.2967,181.9064,22,22);
	AddStaticVehicle2(541,1843.7881,1216.0122,10.4556,270.8793,60,1);
	AddStaticVehicle2(402,1944.1003,1344.7717,8.9411,0.8168,30,30);
	AddStaticVehicle2(402,1679.2278,1316.6287,10.6520,180.4150,90,90);
	AddStaticVehicle2(415,1685.4872,1751.9667,10.5990,268.1183,25,1);
	AddStaticVehicle2(411,2034.5016,1912.5874,11.9048,0.2909,123,1);
	AddStaticVehicle2(411,2172.1682,1988.8643,10.5474,89.9151,116,1);
	AddStaticVehicle2(429,2245.5759,2042.4166,10.5000,270.7350,14,14);
	AddStaticVehicle2(477,2361.1538,1993.9761,10.4260,178.3929,101,1);
	AddStaticVehicle2(550,2221.9946,1998.7787,9.6815,92.6188,53,53);
	AddStaticVehicle2(558,2243.3833,1952.4221,14.9761,359.4796,116,1);
	AddStaticVehicle2(587,2276.7085,1938.7263,31.5046,359.2321,40,1);
	AddStaticVehicle2(587,2602.7769,1853.0667,10.5468,91.4813,43,1);
	AddStaticVehicle2(603,2610.7600,1694.2588,10.6585,89.3303,69,1);
	AddStaticVehicle2(587,2635.2419,1075.7726,10.5472,89.9571,53,1);
	AddStaticVehicle2(562,2577.2354,1038.8063,10.4777,181.7069,35,1);
	AddStaticVehicle2(562,2394.1021,989.4888,10.4806,89.5080,17,1);
	AddStaticVehicle2(562,1881.0510,957.2120,10.4789,270.4388,11,1);
	AddStaticVehicle2(535,2039.1257,1545.0879,10.3481,359.6690,123,1);
	AddStaticVehicle2(535,2009.8782,2411.7524,10.5828,178.9618,66,1);
	AddStaticVehicle2(429,2010.0841,2489.5510,10.5003,268.7720,1,2);
	AddStaticVehicle2(415,2076.4033,2468.7947,10.5923,359.9186,36,1);
	AddStaticVehicle2(506,2352.9026,2577.9768,10.5201,0.4091,7,7);
	AddStaticVehicle2(506,2166.6963,2741.0413,10.5245,89.7816,52,5);
	AddStaticVehicle2(411,1960.9989,2754.9072,10.5473,200.4316,112,1);
	AddStaticVehicle2(429,1919.5863,2760.7595,10.5079,100.0753,2,1);
	AddStaticVehicle2(415,1673.8038,2693.8044,10.5912,359.7903,40,1);
	AddStaticVehicle2(402,1591.0482,2746.3982,10.6519,172.5125,30,30);
	AddStaticVehicle2(603,1580.4537,2838.2886,10.6614,181.4573,75,77);
	AddStaticVehicle2(550,1555.2734,2750.5261,10.6388,91.7773,62,62);
	AddStaticVehicle2(535,1455.9305,2878.5288,10.5837,181.0987,118,1);
	AddStaticVehicle2(477,1537.8425,2578.0525,10.5662,0.0650,121,1);
	AddStaticVehicle2(451,1433.1594,2607.3762,10.3781,88.0013,16,16);
	AddStaticVehicle2(603,2223.5898,1288.1464,10.5104,182.0297,18,1);
	AddStaticVehicle2(558,2451.6707,1207.1179,10.4510,179.8960,24,1);
	AddStaticVehicle2(550,2461.7253,1357.9705,10.6389,180.2927,62,62);
	AddStaticVehicle2(558,2461.8162,1629.2268,10.4496,181.4625,117,1);
	AddStaticVehicle2(477,2395.7554,1658.9591,10.5740,359.7374,0,1);
	AddStaticVehicle2(404,1553.3696,1020.2884,10.5532,270.6825,119,5);
	AddStaticVehicle2(400,1380.8304,1159.1782,10.9128,355.7117,123,1);
	AddStaticVehicle2(418,1383.4630,1035.0420,10.9131,91.2515,117,227);
	AddStaticVehicle2(404,1445.4526,974.2831,10.5534,1.6213,109,100);
	AddStaticVehicle2(400,1704.2365,940.1490,10.9127,91.9048,113,1);
	AddStaticVehicle2(404,1658.5463,1028.5432,10.5533,359.8419,101,1);
	AddStaticVehicle2(581,1677.6628,1040.1930,10.4136,178.7038,58,1);
	AddStaticVehicle2(581,1383.6959,1042.2114,10.4121,85.7269,66,1);
	AddStaticVehicle2(581,1064.2332,1215.4158,10.4157,177.2942,72,1);
	AddStaticVehicle2(581,1111.4536,1788.3893,10.4158,92.4627,72,1);
	AddStaticVehicle2(522,953.2818,1806.1392,8.2188,235.0706,3,8);
	AddStaticVehicle2(522,995.5328,1886.6055,10.5359,90.1048,3,8);
	AddStaticVehicle2(521,993.7083,2267.4133,11.0315,1.5610,75,13);
	AddStaticVehicle2(535,1439.5662,1999.9822,10.5843,0.4194,66,1);
	AddStaticVehicle2(522,1430.2354,1999.0144,10.3896,352.0951,6,25);
	AddStaticVehicle2(522,2156.3540,2188.6572,10.2414,22.6504,6,25);
	AddStaticVehicle2(598,2277.6846,2477.1096,10.5652,180.1090,0,1);
	AddStaticVehicle2(598,2268.9888,2443.1697,10.5662,181.8062,0,1);
	AddStaticVehicle2(598,2256.2891,2458.5110,10.5680,358.7335,0,1);
	AddStaticVehicle2(598,2251.6921,2477.0205,10.5671,179.5244,0,1);
	AddStaticVehicle2(523,2294.7305,2441.2651,10.3860,9.3764,0,0);
	AddStaticVehicle2(523,2290.7268,2441.3323,10.3944,16.4594,0,0);
	AddStaticVehicle2(523,2295.5503,2455.9656,2.8444,272.6913,0,0);
	AddStaticVehicle2(522,2476.7900,2532.2222,21.4416,0.5081,8,82);
	AddStaticVehicle2(522,2580.5320,2267.9595,10.3917,271.2372,8,82);
	AddStaticVehicle2(522,2814.4331,2364.6641,10.3907,89.6752,36,105);
	AddStaticVehicle2(535,2827.4143,2345.6953,10.5768,270.0668,97,1);
	AddStaticVehicle2(521,1670.1089,1297.8322,10.3864,359.4936,87,118);
	AddStaticVehicle2(415,1319.1038,1279.1791,10.5931,0.9661,62,1);
	AddStaticVehicle2(521,1710.5763,1805.9275,10.3911,176.5028,92,3);
	AddStaticVehicle2(521,2805.1650,2027.0028,10.3920,357.5978,92,3);
	AddStaticVehicle2(535,2822.3628,2240.3594,10.5812,89.7540,123,1);
	AddStaticVehicle2(521,2876.8013,2326.8418,10.3914,267.8946,115,118);
	AddStaticVehicle2(429,2842.0554,2637.0105,10.5000,182.2949,1,3);
	AddStaticVehicle2(549,2494.4214,2813.9348,10.5172,316.9462,72,39);
	AddStaticVehicle2(549,2327.6484,2787.7327,10.5174,179.5639,75,39);
	AddStaticVehicle2(549,2142.6970,2806.6758,10.5176,89.8970,79,39);
	AddStaticVehicle2(521,2139.7012,2799.2114,10.3917,229.6327,25,118);
	AddStaticVehicle2(521,2104.9446,2658.1331,10.3834,82.2700,36,0);
	AddStaticVehicle2(521,1914.2322,2148.2590,10.3906,267.7297,36,0);
	AddStaticVehicle2(549,1904.7527,2157.4312,10.5175,183.7728,83,36);
	AddStaticVehicle2(549,1532.6139,2258.0173,10.5176,359.1516,84,36);
	AddStaticVehicle2(521,1534.3204,2202.8970,10.3644,4.9108,118,118);
	AddStaticVehicle2(549,1613.1553,2200.2664,10.5176,89.6204,89,35);
	AddStaticVehicle2(400,1552.1292,2341.7854,10.9126,274.0815,101,1);
	AddStaticVehicle2(404,1637.6285,2329.8774,10.5538,89.6408,101,101);
	AddStaticVehicle2(400,1357.4165,2259.7158,10.9126,269.5567,62,1);
	AddStaticVehicle2(411,1281.7458,2571.6719,10.5472,270.6128,106,1);
	AddStaticVehicle2(522,1305.5295,2528.3076,10.3955,88.7249,3,8);
	AddStaticVehicle2(521,993.9020,2159.4194,10.3905,88.8805,74,74);
	AddStaticVehicle2(415,1512.7134,787.6931,10.5921,359.5796,75,1);
	AddStaticVehicle2(522,2299.5872,1469.7910,10.3815,258.4984,3,8);
	AddStaticVehicle2(522,2133.6428,1012.8537,10.3789,87.1290,3,8);
	AddStaticVehicle2(470,276.6493,1981.2705,17.6349,291.1576,0,0); //
	AddStaticVehicle2(470,278.8036,1997.4153,17.6370,241.6500,0,0); //
	AddStaticVehicle2(470,221.4106,1855.7897,12.9794,1.5015,0,0); //
	AddStaticVehicle2(470,214.1406,1854.3761,12.8916,0.7010,0,0); //
	AddStaticVehicle2(522,1282.0393,1287.6530,10.3828,268.2269,1,2); //
	AddStaticVehicle2(522,1281.8605,1290.7844,10.3923,268.2268,3,2); //
	AddStaticVehicle2(522,1281.9668,1294.2249,10.3923,268.2269,5,8); //
	AddStaticVehicle2(522,1282.0627,1297.3253,10.3923,268.2269,1,8); //
	AddStaticVehicle2(522,1282.1558,1300.3281,10.3923,268.2270,3,1); //
	AddStaticVehicle2(522,1282.2622,1303.7687,10.3923,268.2270,4,8); //
	AddStaticVehicle2(522,1282.3561,1306.7932,10.3923,268.2270,9,4); //
	AddStaticVehicle2(568,-371.2209,2234.9131,42.3500,104.7362,9,39); //
	AddStaticVehicle2(568,-436.0441,2222.0293,42.2475,357.2560,9,39); //
	AddStaticVehicle2(568,-393.4612,2221.3335,42.2957,282.7452,9,39); //
	
	for(new c=0;c<=gVC;c++)
	{
	 	Gas[c] = GasMax;
 	}
	for(new i=1;i<=gVC;i++) {
	    carcost[i] = 50000;
    	for(new s=0; s<24; s++) {
     		if(gVehicleClass[i] == heavycar[s][0]) {
       			carcost[i] = 100000;
   	        }
		}
		for(new a=0; a<11; a++) {
     		if(gVehicleClass[i] == boat[a][0]) {
       			carcost[i] = 50000;
   	        }
		}
		for(new b=0; b<11; b++) {
     		if(gVehicleClass[i] == mbike[b][0]) {
       			carcost[i] = 40000;
   	        }
		}
		for(new d=0; d<3; d++) {
     		if(gVehicleClass[i] == pbike[d][0]) {
       			carcost[i] = 3000;
   	        }
		}
		for(new e=0; e<6; e++) {
     		if(gVehicleClass[i] == splane[e][0]) {
       			carcost[i] = 500000;
   	        }
		}
		for(new f=0; f<2; f++) {
     		if(gVehicleClass[i] == mplane[f][0]) {
       			carcost[i] = 1500000;
   	        }
		}
		for(new v=0; v<2; v++) {
     		if(gVehicleClass[i] == lplane[v][0]) {
       			carcost[i] = 2000000;
   	        }
		}
		for(new n=0; n<4; n++) {
     		if(gVehicleClass[i] == milair[n][0]) {
       			carcost[i] = 4000000;
   	        }
		}
		for(new j=0; j<4; j++) {
     		if(gVehicleClass[i] == sheli[j][0]) {
       			carcost[i] = 750000;
   	        }
		}
		for(new k=0; k<3; k++) {
     		if(gVehicleClass[i] == lheli[k][0]) {
       			carcost[i] = 1250000;
   	        }
		}
		format(tmpname,sizeof(tmpname),"%d",i);
		format(carname,sizeof(carname),"%s", VehicleName[gVehicleClass[i]-400][0]);
		if (!dini_Exists(tmpname)) {
    	    	dini_Create(tmpname);
				dini_Set(tmpname, "owner", "server");
				dini_Set(tmpname, "carname", carname);
				dini_IntSet(tmpname, "carcost", carcost[i]);
				dini_IntSet(tmpname, "carlock", 0);
				dini_IntSet(tmpname, "bought", 0);
				dini_IntSet(tmpname, "secure", 0);
				dini_IntSet(tmpname, "asecure", 0);
				dini_IntSet(tmpname, "used", 0);
				dini_IntSet(tmpname, "buybar", 0);
				GetVehiclePos(i,t,u,o);
        		dini_IntSet(tmpname, "sx", floatround(t));
        		dini_IntSet(tmpname, "sy", floatround(u));
        		dini_IntSet(tmpname, "sz", floatround(o));
        		dini_IntSet(tmpname, "mod1", 0);
        		dini_IntSet(tmpname, "mod2", 0);
        		dini_IntSet(tmpname, "mod3", 0);
        		dini_IntSet(tmpname, "mod4", 0);
        		dini_IntSet(tmpname, "mod5", 0);
        		dini_IntSet(tmpname, "mod6", 0);
        		dini_IntSet(tmpname, "mod7", 0);
        		dini_IntSet(tmpname, "mod8", 0);
        		dini_IntSet(tmpname, "mod9", 0);
        		dini_IntSet(tmpname, "mod10", 0);
        		dini_IntSet(tmpname, "mod11", 0);
        		dini_IntSet(tmpname, "mod12", 0);
        		dini_IntSet(tmpname, "mod13", 0);
        		dini_IntSet(tmpname, "mod14", 0);
        		dini_IntSet(tmpname, "mod15", 0);
        		dini_IntSet(tmpname, "mod16", 0);
        		dini_IntSet(tmpname, "mod17", 0);
        		dini_IntSet(tmpname, "col1", -1);
        		dini_IntSet(tmpname, "col2", -1);
        		dini_IntSet(tmpname, "paintjob", -1);
    	}
    	if(gVC != oldvehcount) {
            format(tmpname,sizeof(tmpname),"%d",i);
			format(carname,sizeof(carname),"%s", VehicleName[gVehicleClass[i]-400][0]);
  			dini_Create(tmpname);
			dini_Set(tmpname, "owner", "server");
			dini_Set(tmpname, "carname", carname);
			dini_IntSet(tmpname, "carcost", carcost[i]);
			dini_IntSet(tmpname, "carlock", 0);
			dini_IntSet(tmpname, "bought", 0);
			dini_IntSet(tmpname, "secure", 0);
			dini_IntSet(tmpname, "asecure", 0);
			dini_IntSet(tmpname, "used", 0);
			dini_IntSet(tmpname, "buybar", 0);
			GetVehiclePos(i,t,u,o);
 			dini_IntSet(tmpname, "sx", floatround(t));
 			dini_IntSet(tmpname, "sy", floatround(u));
 			dini_IntSet(tmpname, "sz", floatround(o));
		}
	}
    for(new p=0; p <= gVC; p++) {
        new filename[256];
        format(filename, sizeof(filename), "%d", p);
        if (dini_Exists(filename)) {
			dini_IntSet(filename, "used", 0);
		}
    }
	for(new tempb=1;tempb<=BIZ_AMOUNT;tempb++) {
    	if(tempb >= 1 && tempb <=9) {
 			propcost[tempb] = 14000000;
 			profit[tempb] = 7500;
		}
		if(tempb >= 10 && tempb <=13) {
 			propcost[tempb] = 11000000;
 			profit[tempb] = 4750;
		}
		if(tempb >= 14 && tempb <=19) {
 			propcost[tempb] = 11000;
 			profit[tempb] = 55;
		}
		if(tempb >= 20 && tempb <=24) {
 			propcost[tempb] = 1200000;
 			profit[tempb] = 600;
		}
		if(tempb >= 25) {
 			propcost[tempb] = 20000000;
 			profit[tempb] = 10000;
		}
		if(tempb >= 26) {
 			propcost[tempb] = 18000000;
 			profit[tempb] = 8500;
		}
		if(tempb >= 27) {
 			propcost[tempb] = 15000000;
 			profit[tempb] = 8000;
		}
		if(tempb >= 28 && tempb <=29) {
 			propcost[tempb] = 2500000;
 			profit[tempb] = 800;
		}
		if(tempb >= 30 && tempb <=31) {
 			propcost[tempb] = 850000;
 			profit[tempb] = 290;
		}
		if(tempb >= 32 && tempb <=33) {
 			propcost[tempb] = 900000;
 			profit[tempb] = 330;
		}
		if(tempb >= 34 && tempb <=36) {
 			propcost[tempb] = 500000;
 			profit[tempb] = 230;
		}
		if(tempb >= 37 && tempb <=39) {
 			propcost[tempb] = 600000;
 			profit[tempb] = 250;
		}
		if(tempb >= 40 && tempb <=42) {
 			propcost[tempb] = 700000;
 			profit[tempb] = 290;
		}
		if(tempb == 43) {
 			propcost[tempb] = 1200000;
 			profit[tempb] = 690;
		}
		if(tempb == 44) {
 			propcost[tempb] = 1100000;
 			profit[tempb] = 590;
		}
		if(tempb == 45) {
 			propcost[tempb] = 650000;
 			profit[tempb] = 200;
		}
		if(tempb == 46) {
 			propcost[tempb] = 800000;
 			profit[tempb] = 225;
		}
		if(tempb == 47) {
 			propcost[tempb] = 1000000;
 			profit[tempb] = 490;
		}
		if(tempb >= 48 && tempb <=49) {
 			propcost[tempb] = 25000;
 			profit[tempb] = 99;
		}
		if(tempb >= 50 && tempb <=53) {
 			propcost[tempb] = 80000;
 			profit[tempb] = 175;
		}
		if(tempb >= 54 && tempb <=60) {
 			propcost[tempb] = 50000;
 			profit[tempb] = 99;
		}
		format(tmpname,sizeof(tmpname),"BIZ%d",tempb);
		if (!dini_Exists(tmpname)) {
    	    	dini_Create(tmpname);
				dini_Set(tmpname, "owner", "server");
				dini_IntSet(tmpname, "propcost", propcost[tempb]);
				dini_IntSet(tmpname, "profit", profit[tempb]);
				dini_IntSet(tmpname, "totalprofit", 0);
				dini_IntSet(tmpname, "bought", 0);
				dini_IntSet(tmpname, "idnumber", tempb);
				dini_IntSet(tmpname, "buybar", 0);
				
    	}
	}
	return 1;
}

public IsPlayerNameOnline(compname[])
{
	new playername[MAX_PLAYER_NAME];
    for(new i=0;i<=MAX_PLAYERS;i++) {
        if(IsPlayerConnected(i)) {
            GetPlayerName(i, playername, sizeof(playername));
            if(strcmp(playername,compname,false) == 0) {
                return i;
			}
		}
	}
	return 100;
}

public profitup()
{
	for(new tempa=1;tempa<=BIZ_AMOUNT;tempa++) {
		format(tmpname,sizeof(tmpname),"BIZ%d",tempa);
	 	propowned[tempa] = dini_Int(tmpname, "bought");
		if (propowned[tempa] == 1) {
		    new tmp[256];
			totalprofit[tempa] = dini_Int(tmpname, "totalprofit");
			profit[tempa] = dini_Int(tmpname, "profit");
			tmp[tempa] = profit[tempa]+totalprofit[tempa];
			dini_IntSet(tmpname, "totalprofit", tmp[tempa]);
    	}
	}
	for(new i=0;i<=MAX_PLAYERS;i++) {
	    if(IsPlayerConnected(i)) {
	    	new ownera[MAX_PLAYERS],playername[256];
		   	GetPlayerName(i, playername, sizeof(playername));
		    ownera[i] = dini_Int(udb_encode(playername),"bizowned");
	    	if(ownera[i] > 0) {
				SendClientMessage(i,COLOR_LIGHTBLUE,"The profit for your property has been updated. Return to your owned property");
    			SendClientMessage(i,COLOR_LIGHTBLUE,"checkpoint and type /getprofit to claim your business's takings.");
			}
		}
	}
	return 1;
}
		

public AddStaticVehicle2(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2)
{
	if(gVC<=MAX_CARS){
		gVC++;
		gVehicleClass[gVC] = modelid;
		gSpawnx[gVC] = floatround(spawn_x);
		gSpawny[gVC] = floatround(spawn_y);
		gSpawnz[gVC] = floatround(spawn_z);
		modded[gVC] = 0;
		col1[gVC] = color1;
		col2[gVC] = color2;
		AddStaticVehicle(modelid, spawn_x, spawn_y, spawn_z, z_angle, color1, color2);
	}
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
	if(logged[playerid] == 1) {
	    new playername[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, playername, sizeof(playername));
		bank[playerid] = dini_Int(udb_encode(playername), "bank");
		if(bank[playerid] > 20000) {
			amount[playerid] = 0;
			SendClientMessage(playerid,COLOR_YELLOW, "You have $20000 or more in your bank account and have been denied the $10000 spawn allowance.");
		}
		if(bank[playerid] < 20000) {
			amount[playerid] = 10000;
			SendClientMessage(playerid,COLOR_YELLOW, "You do not yet have $20000 in your bank account and have been allowed the $10000 spawn allowance.");
		}
		GivePlayerMoney(playerid,amount[playerid]);
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

public OnPlayerConnect(playerid)
{
	printf("OnPlayerConnect(%d)", playerid);
	allowprofit[playerid] = 0;
	speedo[playerid] = 1;
    buyable[playerid] = 0;
	bank[playerid]=0;
	Calling[playerid] = -1;
	Answered[playerid] = 0;
	Callerid[playerid] = 0;
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
	format(string, sizeof(string), "Welcome %s, to tAxI's Freeroam with Vehicle & Business and Business Ownership v5.1b", playername);
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
	GetPlayerName(playerid, playername, sizeof(playername));
	if (dini_Exists(udb_encode(playername)) && logged[playerid] == 1) {
		dini_IntSet(udb_encode(playername), "money", GetPlayerMoney(playerid));
       	dini_IntSet(udb_encode(playername), "bank", bank[playerid]);
       	dini_IntSet(udb_encode(playername), "vehicleresetcount", gVC);
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
    new moneytemp[MAX_PLAYERS];
	moneytemp[playerid] = GetPlayerMoney(playerid);
	GivePlayerMoney(playerid,-moneytemp[playerid]/2);
    GivePlayerMoney(killerid,moneytemp[playerid]/2);
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
					}
				}
				else {
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
			    		SendClientMessage(playerid, COLOR_BRIGHTRED, "Wrong password.");
					}
					else {
						logged[playerid] = 1;
						dini_Set(udb_encode(playername),"pass",tmp);
						new tmp4[256];
      					new Float:x, Float:y, Float:z;
						new Float:a;
						playercount[playerid] = dini_Int(udb_encode(playername), "vehicleresetcount");
						if(playercount[playerid] != gVC) {
						    dini_IntSet(udb_encode(playername), "carowned", 0);
						    dini_IntSet(udb_encode(playername), "car", 0);
						    dini_IntSet(udb_encode(playername), "notified", 1);
						    SendClientMessage(playerid, COLOR_BRIGHTRED, "NOTICE <::> The server vehicles have been changed since your last visit, ownership of all vehicles was reset!");
						}
						x = dini_Int(udb_encode(playername), "x");
						y = dini_Int(udb_encode(playername), "y");
						z = dini_Int(udb_encode(playername), "z");
						a = dini_Int(udb_encode(playername), "a");
						carowned[playerid] = dini_Int(udb_encode(playername), "carowned");
						moneys[playerid] = dini_Int(udb_encode(playername), "money");
						if(moneys[playerid] < 10000) {
							bank[playerid] = dini_Int(udb_encode(playername), "bank");
							if(bank[playerid] > 20000) {
								SendClientMessage(playerid,COLOR_YELLOW, "You have $20000 or more in your bank account and have been denied the $10000 pocket money.");
							}
							if(bank[playerid] < 20000) {
								moneys[playerid] = 10000;
								SendClientMessage(playerid,COLOR_YELLOW, "You do not yet have $20000 in your bank account and have been allowed the $10000 pocket money.");
							}
							GivePlayerMoney(playerid,moneys[playerid]);
						}
						if(moneys[playerid] >= 10000) {
						    GivePlayerMoney(playerid,moneys[playerid]);
						}
		                tmp4 = dini_Get(udb_encode(playername), "bank");
		                PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(playername), "level");
		                bank[playerid] = strval(tmp4);
	                	SetPlayerPos(playerid,x,y,z);
						SetPlayerFacingAngle(playerid,a);
						SendClientMessage(playerid, COLOR_GREEN, "You are now logged in and have been restored to your last known position.");
						SendClientMessage(playerid, COLOR_GREEN, "Money and bank will be Auto-Saved periodically and when you exit the game!");
						biznote[playerid] = dini_Int(udb_encode(playername), "bizsold");
						carnote[playerid] = dini_Int(udb_encode(playername), "carsold");
						if(biznote[playerid] == 1) {
						    SendClientMessage(playerid, COLOR_BRIGHTRED, "NOTICE <::> Your business has been reset by an admin recently. The money from the sale was transferred into your bank account!");
						    dini_IntSet(udb_encode(playername), "bizsold", 0);
						}
						if(carnote[playerid] == 1) {
						    SendClientMessage(playerid, COLOR_BRIGHTRED, "NOTICE <::> Your vehicle has been reset by an admin recently. The money from the sale was transferred into your bank account!");
						    dini_IntSet(udb_encode(playername), "carsold", 0);
						}
				}
			}
			else {
			    format(string, sizeof(string), "The account %s, does not exist on this server. Please type /register [password] to create an account.", playername);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
		}

		return 1;
	}

	if(strcmp(cmd, "/register", true) == 0) {
		if(Spawned[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must spawn before you can use /login or /register");
		    return 1;
		}
	    tmp = strtok(cmdtext, idx);
 		GetPlayerName(playerid, playername, sizeof(playername));
        if(20 < strlen(tmp) || strlen(tmp) < 5) {
			SendClientMessage(playerid, COLOR_YELLOW, "Password length must be 5-20 characters long.");
			return 1;
		}
	    if(!strlen(tmp))
			SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /register [password]");

		else {
			if (!dini_Exists(udb_encode(playername))) {
				dini_Create(udb_encode(playername));
				dini_IntSet(udb_encode(playername), "password", udb_hash(tmp));
				dini_Set(udb_encode(playername),"pass",tmp);
				new Float:x, Float:y, Float:z;
      			new Float:a;
				GetPlayerFacingAngle(playerid,a);
				dini_IntSet(udb_encode(playername), "a", floatround(a));
 				GetPlayerPos(playerid,x,y,z);
				dini_IntSet(udb_encode(playername), "x", floatround(x));
				dini_IntSet(udb_encode(playername), "y", floatround(y));
				dini_IntSet(udb_encode(playername), "z", floatround(z));
    			dini_IntSet(udb_encode(playername), "carowned", 0);
    			dini_IntSet(udb_encode(playername), "car", 0);
    			dini_IntSet(udb_encode(playername), "level", 0);
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
			        dini_Set(udb_encode(playername),"pass",tmp);
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

	if(strcmp(cmd, "/deposit", true) == 0) {
	    if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK && getCheckpointType(playerid) != CP_BANK_2 && getCheckpointType(playerid) != CP_BANK_3) {
	        SendClientMessage(playerid, COLOR_LIGHTBLUE, "You must be at a bank area to use this. ATMs are located in convenience stores.");
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
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must enter an amount greater than 0!");
			return 1;
		}

		if(GetPlayerMoney(playerid) < moneys[playerid]) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You don't have the money for that!");
			return 1;
		}
		GivePlayerMoney(playerid, 0-moneys[playerid]);
		bank[playerid] = bank[playerid]+moneys[playerid];
		format(string, sizeof(string), "You have deposited $%d, your current balance is $%d.", moneys[playerid], bank[playerid]);
		SendClientMessage(playerid, COLOR_GREEN, string);
		return 1;
	}
	if(strcmp(cmd, "/withdraw", true) == 0) {
	    if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK && getCheckpointType(playerid) != CP_BANK_2 && getCheckpointType(playerid) != CP_BANK_3) {
	        SendClientMessage(playerid, COLOR_LIGHTBLUE, "You must be at a bank area to use this. ATMs are located in convenience stores.");
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
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must enter an amount greater than 0!");
			return 1;
		}
  		if(moneys[playerid] > bank[playerid]) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "You don't have the money for that!");
			return 1;
     	}
		GivePlayerMoney(playerid, moneys[playerid]);
		bank[playerid] = bank[playerid]-moneys[playerid];
		format(string, sizeof(string), "You have withdrawn $%d, your current balance is $%d.", moneys[playerid], bank[playerid]);
		SendClientMessage(playerid, COLOR_GREEN, string);
		return 1;
   	}
	if(strcmp(cmd, "/balance", true) == 0) {
		if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK && getCheckpointType(playerid) != CP_BANK_2 && getCheckpointType(playerid) != CP_BANK_3) {
	        SendClientMessage(playerid, COLOR_LIGHTBLUE, "You must be at a bank area to use this. ATMs are located in convenience stores.");
			return 1;
		}
		format(string, sizeof(string), "You have $%d in the bank.", bank[playerid]);
		SendClientMessage(playerid, COLOR_GREEN, string);
		return 1;
	}
 	if(strcmp(cmd, "/givecash", true) == 0) {
      tmp = strtok(cmdtext, idx);
      if(!strlen(tmp)) {
         SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /givecash [playerid] [amount]");
         return 1;
      }
      giveplayerid = strval(tmp);
      tmp = strtok(cmdtext, idx);
      if(!strlen(tmp)) {
         SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /givecash [playerid] [amount]");
         return 1;
      }
       moneys[playerid] = strval(tmp);
      if (IsPlayerConnected(giveplayerid)) {
         GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
         GetPlayerName(playerid, sendername, sizeof(sendername));
         playermoney[playerid] = GetPlayerMoney(playerid);
         if (moneys[playerid] > 0 && playermoney[playerid] >= moneys[playerid]) {
            GivePlayerMoney(playerid, (0 - moneys[playerid]));
            GivePlayerMoney(giveplayerid, moneys[playerid]);
            format(string, sizeof(string), "You have sent %s (id: %d), $%d.", giveplayer,giveplayerid, moneys[playerid]);
            SendClientMessage(playerid, COLOR_GREEN, string);
            format(string, sizeof(string), "You have recieved $%d from %s (id: %d).", moneys[playerid], sendername, playerid);
            SendClientMessage(giveplayerid, COLOR_GREEN, string);
            printf("%s(playerid:%d) has transfered %d to %s(playerid:%d)",sendername, playerid, moneys[playerid], giveplayer, giveplayerid);
         }
         else {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "Invalid transaction amount.");
         }
      }
      else {
            format(string, sizeof(string), "ID:%d is not an active player.", giveplayerid);
            SendClientMessage(playerid, COLOR_BRIGHTRED, string);
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
		PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
		if (PlayerInfo[playerid][pAdmin] < 1) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use this command!");
            return 1;
  		}
      level[playerid] = strval(tmp);
      if(level[playerid] < 0) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "Invalid Admin Level -=(0 = no admin/1 = min admin/2 = full admin)=-");
            return 1;
      }
      if(level[playerid] > 2) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "Invalid Admin Level -=(0 = no admin/1 = min admin/2 = full admin)=-");
            return 1;
      }
      if(level[playerid] == PlayerInfo[giveplayerid][pAdmin]) {
            format(string, sizeof(string), "That player already has level %d admin privelages.", level[playerid]);
            SendClientMessage(playerid, COLOR_BRIGHTRED, string);
            return 1;
      }
      if (IsPlayerConnected(giveplayerid)) {
         GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
         GetPlayerName(playerid, sendername, sizeof(sendername));
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
            format(string, sizeof(string), "ID:%d is not an active player ID number.", giveplayerid);
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
			format(string, sizeof(string), "ID:%d is not an active player ID number.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}
		if (!IsPlayerConnected(teleid)) {
			format(string, sizeof(string), "ID:%d is not an active player ID number.", teleid);
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
			format(string, sizeof(string), "ID:%d is not an active player ID number.", giveplayerid);
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
  		if (seconds > 20) {
  			SendClientMessage(giveplayerid, COLOR_BRIGHTRED, "You must enter a duration between 1 and 20 seconds");
  			return 1;
  		}

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
	if(strcmp(cmd, "/stats", true) == 0) {
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        new vehicle[MAX_PLAYERS], business[MAX_PLAYERS];
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /stats [playerid]");
			return 1;
		}
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 2) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Only Level 2 Admins have permission to use that command!");
		    return 1;
		}
		if (IsPlayerConnected(giveplayerid)) {
		    new infostring[256];
		    new Float:hp;
		    GetPlayerHealth(giveplayerid, hp);
		    format(infostring,sizeof(infostring),"-------<:: Player Information - %s ::>-------",giveplayer);
		    SendClientMessage(playerid, COLOR_ORANGE,infostring);
		    new log[256];
		    if(logged[giveplayerid] == 0) {
				format(log,sizeof(log),"Not logged in");
		        if(!dini_Exists(udb_encode(giveplayer))) {
		        	format(infostring,sizeof(infostring),"General Info - Name: %s / Health: %d (Not yet registered)",giveplayer, floatround(hp));
                    SendClientMessage(playerid, COLOR_GREEN,infostring);
					format(infostring,sizeof(infostring),"Money Info - Wallet: $%d", GetPlayerMoney(giveplayerid));
					SendClientMessage(playerid, COLOR_GREEN,infostring);
					format(infostring,sizeof(infostring),"Vehicle Info - N/A");
                	SendClientMessage(playerid, COLOR_GREEN,infostring);
                	format(infostring,sizeof(infostring),"Business Info - N/A");
                	SendClientMessage(playerid, COLOR_GREEN,infostring);
		        	return 1;
				}
		    }
		    if(logged[giveplayerid] == 1) {
				format(log,sizeof(log),"Logged in");
			}
		    PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		    vehicle[giveplayerid] = dini_Int(udb_encode(giveplayer), "carowned");
        	business[giveplayerid] = dini_Int(udb_encode(giveplayer), "bizowned");
		    password = dini_Get(udb_encode(giveplayer),"pass");
			format(infostring,sizeof(infostring),"General Info - Name: %s / Level: %d / Health: %d / Password: %s / Status: %s", giveplayer, PlayerInfo[giveplayerid][pAdmin], floatround(hp), password, log);
			SendClientMessage(playerid, COLOR_GREEN,infostring);
			format(infostring,sizeof(infostring),"Money Info - Wallet: $%d / Bank: $%d", GetPlayerMoney(giveplayerid), bank[giveplayerid]);
			SendClientMessage(playerid, COLOR_GREEN,infostring);
			if(vehicle[giveplayerid] > 0) {
			    new filename[256],cost[MAX_PLAYERS],securelvl[MAX_PLAYERS],asecurelvl[MAX_PLAYERS];
			    new secmess[256],asecmess[256];
			    format(filename,sizeof(filename),"%d",vehicle[giveplayerid]);
			    carname = dini_Get(filename, "carname");
			    cost[giveplayerid] = dini_Int(filename, "carcost");
			    securelvl[giveplayerid] = dini_Int(filename, "secure");
			    asecurelvl[giveplayerid] = dini_Int(filename, "asecure");
			    if(securelvl[giveplayerid] == 0) {
			        format(secmess,sizeof(secmess),"None");
			    }
			    if(securelvl[giveplayerid] == 1) {
			        format(secmess,sizeof(secmess),"Eject");
			    }
			    if(securelvl[giveplayerid] == 2) {
			        format(secmess,sizeof(secmess),"Lethal");
			    }
			    if(asecurelvl[giveplayerid] == 0) {
			        format(asecmess,sizeof(asecmess),"None");
			    }
			    if(asecurelvl[giveplayerid] == 1) {
			        format(asecmess,sizeof(asecmess),"Eject");
			    }
			    if(asecurelvl[giveplayerid] == 2) {
			        format(asecmess,sizeof(asecmess),"Lethal");
			    }
			    format(infostring,sizeof(infostring),"Vehicle Info - Model: %s (ID:%d) / Cost: $%d / Security: %s / Admin security: %s", carname,vehicle[giveplayerid],cost[giveplayerid],secmess,asecmess);
                SendClientMessage(playerid, COLOR_GREEN,infostring);
			}
			if(vehicle[giveplayerid] == 0) {
			    SendClientMessage(playerid, COLOR_GREEN,"Vehicle Info - No owned vehicle yet");
			}
			if(business[giveplayerid] > 0) {
			    new filename[256],bcost[MAX_PLAYERS],earnings[MAX_PLAYERS];
			    format(filename,sizeof(filename),"BIZ%d", business[giveplayerid]);
			    bcost[giveplayerid] = dini_Int(filename,"propcost");
			    earnings[giveplayerid] = dini_Int(filename,"profit");
			    format(infostring,sizeof(infostring),"Business Info - Name: %s / Cost: $%d / Profit level: $%d", filename,bcost[giveplayerid],earnings[giveplayerid]);
                SendClientMessage(playerid, COLOR_GREEN,infostring);
			}
			if(business[giveplayerid] == 0) {
			    SendClientMessage(playerid, COLOR_GREEN,"Business Info - No owned business yet");
			}
			return 1;
		}
		else {
			format(string, sizeof(string), "ID:%d is not an active player ID number.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
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
			format(string, sizeof(string), "ID:%d is not an active player ID number.", giveplayerid);
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
			format(string, sizeof(string), "ID:%d is not an active player ID number.", giveplayerid);
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
				format(string, sizeof(string), "ID:%d is not an active player ID number.", giveplayerid);
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
			format(string, sizeof(string), "ID:%d is not an active player ID number.", giveplayerid);
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
			format(string, sizeof(string), "ID:%d is not an active player ID number.", giveplayerid);
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
			format(string, sizeof(string), "ID:%d is not an active player ID number.", giveplayerid);
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
			format(string, sizeof(string), "ID:%d is not an active player ID number.", giveplayerid);
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
			format(string, sizeof(string), "ID:%d is not an active player ID number.", giveplayerid);
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
		carname = dini_Get(filename, "carname");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to purchase a vehicle!");
			return 1;
		}
		carbuyable[playerid] = dini_Int(filename, "buybar");
  		if(carbuyable[playerid] == 1) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle has been set as non-buyable by server administration!");
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
		if(gVehicleClass[GetPlayerVehicleID(playerid)] == 571) {
	 		SendClientMessage(playerid,COLOR_BRIGHTRED,"This car is not for sale Dumbass!!");
	 		return 1;
		}
		if(gVehicleClass[GetPlayerVehicleID(playerid)] == 471) {
	 		SendClientMessage(playerid,COLOR_BRIGHTRED,"This car is not for sale Dumbass!!");
	 		return 1;
		}
		if(gVehicleClass[GetPlayerVehicleID(playerid)] == 539) {
	 		SendClientMessage(playerid,COLOR_BRIGHTRED,"This car is not for sale Dumbass!!");
	 		return 1;
		}
		if (strcmp(tmp,playername,false) == 0) {
				format(string, sizeof(string), "You already own this %s, %s", carname, playername);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
				return 1;
			}
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		bought[playerid] = dini_Int(filename, "bought");
		if(cartemp[playerid] == 0 && bought[playerid] == 1) {
			format(string, sizeof(string), "This %s is owned by %s, and is not for sale!", carname, tmp);
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
				tmp[playerid] = GetPlayerVehicleID(playerid);
				format(string5, sizeof(string5), "You just bought this %s for $%d. Your %s currently has %d%s of its fuel remaining!", carname, carcost[playerid],carname,Gas[tmp[playerid]],"%");
				SendClientMessage(playerid, COLOR_GREEN, string5);
				return 1;
			}
			if(cash[playerid] < carcost[playerid]) {
			    new string6[256];
				format(string6, sizeof(string6), "You do not have $%d and cannot afford this %s!", carcost[playerid], carname);
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
   	    carname = dini_Get(filename, "carname");
   	    tmp[playerid] = GetPlayerVehicleID(playerid);
   	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to sell a vehicle!");
			return 1;
		}
		carbuyable[playerid] = dini_Int(filename, "buybar");
  		if(carbuyable[playerid] == 1) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle has been set as non-buyable by server administration!");
      		return 1;
    	}
		if(passenger[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers' seat of your vehicle to sell it!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle in order to sell it!");
			return 1;
		}
		if(gVehicleClass[GetPlayerVehicleID(playerid)] == 571) {
	 		SendClientMessage(playerid,COLOR_BRIGHTRED,"This car is not for sale Dumbass!!");
	 		return 1;
		}
		if(gVehicleClass[GetPlayerVehicleID(playerid)] == 471) {
	 		SendClientMessage(playerid,COLOR_BRIGHTRED,"This car is not for sale Dumbass!!");
	 		return 1;
		}
		if(gVehicleClass[GetPlayerVehicleID(playerid)] == 539) {
	 		SendClientMessage(playerid,COLOR_BRIGHTRED,"This car is not for sale Dumbass!!");
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
			modded[tmp[playerid]] = 0;
			format(string, sizeof(string), "You just sold your %s for $%d, enjoy the walk!!", carname, carcost[playerid]);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
  		}
  		else {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "What are you trying to pull here, you don't own the vehicle!!!");
			return 1;
		}
	}
	if(strcmp(cmd, "/asellcar", true) == 0) {
		new var1[256];
		new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
   	    var1 = dini_Get(filename, "owner");
   	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to use this command!");
			return 1;
		}
		if(passenger[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers seat of this vehicle to use this command!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle in order to use this command!");
			return 1;
		}
		if (strcmp(var1,server,false) == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle has no owner as of yet and cannot be sold!");
			return 1;
		}
   	    if (PlayerInfo[playerid][pAdmin] == 2) {
   	        GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
   	    	format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
			dini_Set(filename, "owner", "server");
			dini_IntSet(filename, "bought", 0);
			dini_IntSet(filename, "secure", 0);
			if(dini_Exists(udb_encode(var1))) {
			    tempid[playerid] = IsPlayerNameOnline(var1);
			    if(tempid[playerid] >= 0 || tempid[playerid] < 100) {
			        bank[tempid[playerid]] = bank[tempid[playerid]]+carcost[playerid];
					dini_IntSet(udb_encode(var1), "car", 0);
					dini_IntSet(udb_encode(var1), "carowned", 0);
					format(string, sizeof(string), "You just sold %s's %s. The sale money ($%d) was sent to %s's online bank account", var1, carname, carcost[playerid], var1);
					SendClientMessage(playerid, COLOR_ORANGE, string);
					format(string, sizeof(string), "Admin (%s) has just sold your %s! The sale money ($%d) was sent to your online bank account!", carname, playername, carcost[playerid]);
                    SendClientMessage(playerid, COLOR_ORANGE, string);
					return 1;
				}
				else {
					bank[tempid[playerid]] = dini_Int(udb_encode(var1), "bank");
				    bank[tempid[playerid]] = bank[tempid[playerid]]+carcost[playerid];
				    dini_IntSet(udb_encode(var1), "car", 0);
					dini_IntSet(udb_encode(var1), "carowned", 0);
					dini_IntSet(udb_encode(var1), "carsold", 1);
					dini_IntSet(udb_encode(var1), "bank", bank[tempid[playerid]]);
					format(string, sizeof(string), "You just sold %s's %s. The sale money ($%d) was sent to %s's online bank account", var1, carname, carcost[playerid], var1);
					SendClientMessage(playerid, COLOR_ORANGE, string);
					return 1;
				}
			}
			if(!dini_Exists(udb_encode(var1))) {
				format(string, sizeof(string), "You just sold %s's %s. The player file was not found and cannot be altered.", var1, carname);
				SendClientMessage(playerid, COLOR_GREEN, string);
				return 1;
			}
		}
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not a server administrator and cannot use this command!");
		return 1;

	}
	if(strcmp(cmd, "/cbuy", true) == 0) {
		new var1[256];
		new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
   	    var1 = dini_Get(filename, "owner");
   	    carname = dini_Get(filename, "carname");
   	    tmp[playerid] = GetPlayerVehicleID(playerid);
   	    carbuyable[playerid] = dini_Int(filename, "buybar");
   	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to use this command!");
			return 1;
		}
		if(passenger[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers seat to use this command");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle in order to use this command");
			return 1;
		}
   	    if (PlayerInfo[playerid][pAdmin] == 2) {
   	        if(carbuyable[playerid] == 1) {
   	        	format(string,sizeof(string),"You have set this %s to buyable!", carname);
   	        	SendClientMessage(playerid,COLOR_ORANGE,string);
				dini_IntSet(filename, "buybar", 0);
				return 1;
			}
			SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is already set to buyable!");
			return 1;
		}
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not a server administrator and cannot use this command!");
		return 1;
	}
	if(strcmp(cmd, "/cunbuy", true) == 0) {
		new var1[256];
		new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
   	    var1 = dini_Get(filename, "owner");
   	    carname = dini_Get(filename, "carname");
   	    carbuyable[playerid] = dini_Int(filename, "buybar");
   	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to use this command!");
			return 1;
		}
		if(passenger[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers seat to use this command");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle in order to use this command");
			return 1;
		}
		if(carbuyable[playerid] == 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is already set as un-buyable!");
			return 1;
		}
   	    if (PlayerInfo[playerid][pAdmin] == 2) {
   	        if (strcmp(server,var1,false) == 0) {
   	            carname = dini_Get(filename, "carname");
 				format(string,sizeof(string),"You have set this %d to non-buyable!",carname);
 				SendClientMessage(playerid,COLOR_ORANGE,string);
   				dini_IntSet(filename, "buybar", 1);
				return 1;
			}
   	        GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
   	    	format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
   	    	var1 = dini_Get(filename, "owner");
			dini_Set(filename, "owner", "server");
			dini_IntSet(filename, "bought", 0);
			dini_IntSet(filename, "secure", 0);
			dini_IntSet(filename, "buybar", 1);
			if(dini_Exists(udb_encode(var1))) {
			    tempid[playerid] = IsPlayerNameOnline(var1);
			    if(tempid[playerid] >= 0 || tempid[playerid] < 100) {
			        bank[tempid[playerid]] = bank[tempid[playerid]]+carcost[playerid];
					dini_IntSet(udb_encode(var1), "car", 0);
					dini_IntSet(udb_encode(var1), "carowned", 0);
					format(string, sizeof(string), "You just sold %s's %s and set it to non-buyable. The sale money ($%d) was sent to %s's online bank account", var1, carname, carcost[playerid], var1);
					SendClientMessage(playerid, COLOR_ORANGE, string);
					format(string, sizeof(string), "Admin (%s) has just sold your %s and set it to non-buyable! The sale money ($%d) was sent to your online bank account!", playername, carname, carcost[playerid]);
                    SendClientMessage(tempid[playerid], COLOR_ORANGE, string);
					return 1;
				}
				else {
					bank[tempid[playerid]] = dini_Int(udb_encode(var1), "bank");
				    bank[tempid[playerid]] = bank[tempid[playerid]]+carcost[playerid];
				    dini_IntSet(udb_encode(var1), "car", 0);
					dini_IntSet(udb_encode(var1), "carowned", 0);
					dini_IntSet(udb_encode(var1), "carsold", 1);
					dini_IntSet(udb_encode(var1), "bank", bank[tempid[playerid]]);
					format(string, sizeof(string), "You just sold %s's %s and set it to non-buyable. The sale money ($%d) was sent to %s's online bank account", var1, carname, carcost[playerid], var1);
					SendClientMessage(playerid, COLOR_ORANGE, string);
					return 1;
				}
			}
			if(!dini_Exists(udb_encode(var1))) {
				format(string, sizeof(string), "You just sold %s's %s and set it to non-buyable. The player file was not found and cannot be altered.", var1, carname);
				SendClientMessage(playerid, COLOR_GREEN, string);
				return 1;
			}
		}
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not a server administrator and cannot use this command!");
		return 1;
	}
	if(strcmp(cmd, "/credits", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "----- tAxI's Freeroam and Car & Business Ownership Script v5.1b <::> By tAxI -----");
		SendClientMessage(playerid, COLOR_YELLOW, "Script designer and concept - tAxI aka Necrioss (email <::> cptnsausage@hotmail.com)");
		SendClientMessage(playerid, COLOR_YELLOW, "Class selection, Team sorting and checkpoint system basic design - Project San Andreas - Pixels^");
		SendClientMessage(playerid, COLOR_YELLOW, "Cellphone system code designed and made by [eLg]Beckzyboi (www.elg.uk.tt)");
		SendClientMessage(playerid, COLOR_GREEN, "If you wish to use this script or any parts of it in your own gamemode please fee free but you must GIVE CREDIT!!!");
		return 1;
	}
	if(strcmp(cmd, "/help", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "----- tAxI's Freeroam and Car & Business Ownership Script v5.1b <::> By tAxI -----");
		SendClientMessage(playerid, COLOR_YELLOW, "For BUSINESS help please type /bizhelp.");
		SendClientMessage(playerid, COLOR_YELLOW, "For CELLPHONE help please type /cellhelp.");
		SendClientMessage(playerid, COLOR_YELLOW, "For BANK commands please type /bankhelp.");
		SendClientMessage(playerid, COLOR_YELLOW, "For VEHICLE commands, please type /vehiclehelp.");
		SendClientMessage(playerid, COLOR_YELLOW, "For ADMIN commands, please type /adminhelp.");
		SendClientMessage(playerid, COLOR_YELLOW, "For GENERAL commands, please type /commands.");
		SendClientMessage(playerid, COLOR_YELLOW, "For FUEL SYSTEM info and the location of the refuelling stations, please type /fuelhelp.");
		SendClientMessage(playerid, COLOR_ORANGE, "All your stats are saved permanently, including your own car and business!");
		SendClientMessage(playerid, COLOR_ORANGE, "Type /credits to see a list of the ppl who contributed to this script.");
		return 1;
	}
	if(strcmp(cmd, "/bizhelp", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Business System Help ----------");
		SendClientMessage(playerid, COLOR_YELLOW, "Business checkpoints are located around the whole of LV (currently 60 availlable to buy with permanent saving!");
		SendClientMessage(playerid, COLOR_YELLOW, "More businesses coming soon!!");
		SendClientMessage(playerid, COLOR_YELLOW, "Buy a business (must be in business checkpoint) - /buybiz");
		SendClientMessage(playerid, COLOR_YELLOW, "Sell a business (must be in business checkpoint) - /sellbiz");
		SendClientMessage(playerid, COLOR_YELLOW, "Collect your business's earnings (must be in your business's checkpoint) - /getprofit");
		SendClientMessage(playerid, COLOR_YELLOW, "Teleport to your business checkpoint (costs 5 mins worth of profit every time you use it) - /gotobiz");
		return 1;
	}
	if(strcmp(cmd, "/cellhelp", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Cellphone System Help ----------");
		SendClientMessage(playerid, COLOR_YELLOW, "Every person has their own cellphone - calls cost $1/second.");
		SendClientMessage(playerid, COLOR_YELLOW, "To make a call - /call [player id].");
		SendClientMessage(playerid, COLOR_YELLOW, "To answer a call - /answer.");
		SendClientMessage(playerid, COLOR_YELLOW, "To end a call - /hangup.");
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
		SendClientMessage(playerid, COLOR_YELLOW, "Set a vehicle to buyable and unbuyable - /cbuy & /cunbuy");
		SendClientMessage(playerid, COLOR_YELLOW, "Set a business to buyable and unbuyable - /bbuy & /bunbuy");
		SendClientMessage(playerid, COLOR_YELLOW, "Reset any vehicle or business owned in-game - /asellcar & /asellbiz");
		SendClientMessage(playerid, COLOR_YELLOW, "Set player admin level - /setadmin [player id] [admin level] :: (0 - no admin <> 1 - moderator <> 2 - full admin)");
        SendClientMessage(playerid, COLOR_YELLOW, "Get detailed player information - /stats [playerid]");
		return 1;
	}
	if(strcmp(cmd, "/bankhelp", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Bank Help ----------");
		SendClientMessage(playerid, COLOR_YELLOW, "You must be in a ATM area (located in the 24/7 shops):");
		SendClientMessage(playerid, COLOR_YELLOW, "Deposit Amount - /deposit [amount]");
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
		SendClientMessage(playerid, COLOR_YELLOW, "Toggle dashboard display on/off - /dash");
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
		    if(gVehicleClass[GetPlayerVehicleID(playerid)] == 571) {
	 			SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot lock this vehicle!");
	 			return 1;
			}
			if(gVehicleClass[GetPlayerVehicleID(playerid)] == 471) {
	 			SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot lock this vehicle!");
	 			return 1;
			}
			if(gVehicleClass[GetPlayerVehicleID(playerid)] == 539) {
	 			SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot lock this vehicle!");
	 			return 1;
			}
		    new filename[256];
			format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
			carname = dini_Get(filename, "carname");
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
			format(lockmess,sizeof(lockmess),"Your %s is now locked.",carname);
			SendClientMessage(playerid,COLOR_GREEN, lockmess);
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
		    new filename[256];
			format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
			carname = dini_Get(filename, "carname");
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
			format(lockmess,sizeof(lockmess),"Your %s is now unlocked.",carname);
			SendClientMessage(playerid,COLOR_GREEN, lockmess);
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
		tmpcar[playerid] = dini_Int(udb_encode(playername), "carowned");
	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to use this command!");
			return 1;
		}
  		if(carbuyable[playerid] == 1) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is un-buyable and these commands will not work!");
			return 1;
    	}
		if(tmpcar[playerid] == 0) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "You must first own a vehicle before you can use this command!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid)) {
            if (strcmp(val1,playername,false) == 0) {
				dini_IntSet(filename, "secure", 1);
				carname = dini_Get(filename, "carname");
				format(securemess,sizeof(securemess),"You have set your %s as secure, no other player will be able to use it even when you are offline.", carname);
				SendClientMessage(playerid, COLOR_GREEN, securemess);
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
		tmpcar[playerid] = dini_Int(udb_encode(playername), "carowned");
	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to use this command!");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] > 0) {
			if(IsPlayerInAnyVehicle(playerid)) {
				dini_IntSet(filename, "asecure", 1);
				carname = dini_Get(filename, "carname");
				format(securemess,sizeof(securemess),"You have set this %s as admin only, no other player will be able to use it unless they too are an admin.", carname);
				SendClientMessage(playerid, COLOR_GREEN, securemess);
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
		tmpcar[playerid] = dini_Int(udb_encode(playername), "carowned");
	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to use this command!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid)) {
            if (PlayerInfo[playerid][pAdmin] > 0) {
				dini_IntSet(filename, "asecure", 2);
				carname = dini_Get(filename, "carname");
				format(securemess,sizeof(securemess),"You have set this %s as admin only with lethal protection, no other player will be able to use it unless they too are an admin.", carname);
				SendClientMessage(playerid, COLOR_GREEN, securemess);
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
		tmpcar[playerid] = dini_Int(udb_encode(playername), "carowned");
	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to use this command!");
			return 1;
		}
		if(tmpcar[playerid] == 0) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "You must first own a vehicle before you can use this command!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid)) {
            if (PlayerInfo[playerid][pAdmin] > 0) {
				dini_IntSet(filename, "asecure", 0);
				carname = dini_Get(filename, "carname");
				format(securemess,sizeof(securemess),"You have set this %s as accessable to everyone.", carname);
				SendClientMessage(playerid, COLOR_GREEN, securemess);
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
		tmpcar[playerid] = dini_Int(udb_encode(playername), "carowned");
	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to use this command!");
			return 1;
		}
  		if(carbuyable[playerid] == 1) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is un-buyable and these commands will not work!");
			return 1;
    	}
		if(tmpcar[playerid] == 0) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "You must first own a vehicle before you can use this command!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid)) {
            if (strcmp(val1,playername,false) == 0) {
				dini_IntSet(filename, "secure", 0);
				carname = dini_Get(filename, "carname");
				format(securemess,sizeof(securemess),"You have set your %s as accessable to everyone.", carname);
				SendClientMessage(playerid, COLOR_GREEN, securemess);
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
		tmpcar[playerid] = dini_Int(udb_encode(playername), "carowned");
	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to use this command!");
			return 1;
		}
  		if(carbuyable[playerid] == 1) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is un-buyable and these commands will not work!");
			return 1;
    	}
		if(tmpcar[playerid] == 0) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "You must first own a vehicle before you can use this command!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid)) {
            if (strcmp(val1,playername,false) == 0) {
				dini_IntSet(filename, "secure", 2);
				carname = dini_Get(filename, "carname");
				format(securemess,sizeof(securemess),"You have set your %s as secure with lethal protection, no other player will be able to use it even when you are offline.", carname);
				SendClientMessage(playerid, COLOR_GREEN, securemess);
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
     	carname = dini_Get(filename, "carname");
     	carused[playerid] = dini_Int(filename, "used");
	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to call a vehicle to you!");
			return 1;
		}
		carbuyable[playerid] = dini_Int(filename, "buybar");
  		if(carbuyable[playerid] == 1) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle has been set as non-buyable by server administration!");
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
			format(carmess,sizeof(carmess),"Your %s has been successfully transported to your location!",carname);
			SendClientMessage(playerid, COLOR_GREEN, carmess);
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
		carbuyable[playerid] = dini_Int(filename, "buybar");
  		if(carbuyable[playerid] == 1) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle has been set as non-buyable by server administration!");
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
		modded[tmpcar[playerid]] = 0;
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
 			format(string, sizeof(string), "ID:%d is not an active player ID number.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}
		return 1;
	}
	if(strcmp(cmd,"/refuel",true)==0)
	 {
       if(IsPlayerInCheckpoint(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	   {
	   	   if(GetPlayerMoney(playerid) >= 20)
	   	   {
             SendClientMessage(playerid,COLOR_YELLOW,"Your vehicle is being refuelled. Please wait for confirmation that your tank is full...");
			 Filling[playerid] = 1;
			 return 1;
		   }
		   if(GetPlayerMoney(playerid) <= 2) {
		    SendClientMessage(playerid,COLOR_BRIGHTRED,"You do not have enough money to use this fuel refill point!");
		    Filling[playerid] = 0;
		    return 1;
		   }

	   }
	   else {
	        SendClientMessage(playerid,COLOR_BRIGHTRED,"You must be driving a vehicle and also in a refuelling checkpoint to use this command!");
            SendClientMessage(playerid,COLOR_BRIGHTRED,"These can be found in all Gas Stations or within any airport in San Andreas (indicated by red blip on radar).");
	   }
      return 1;
     }
     if(strcmp(cmd,"/dash",true)==0)
	 {
	    if(gVehicleClass[GetPlayerVehicleID(playerid)] == 571) {
	        SendClientMessage(playerid,COLOR_BRIGHTRED,"This vehicle has no dashboard");
	        return 1;
	    }
	    if(gVehicleClass[GetPlayerVehicleID(playerid)] == 539) {
	        SendClientMessage(playerid,COLOR_BRIGHTRED,"This vehicle has no dashboard");
	        return 1;
	    }
	    if(gVehicleClass[GetPlayerVehicleID(playerid)] == 471) {
	        SendClientMessage(playerid,COLOR_BRIGHTRED,"This vehicle has no dashboard");
	        return 1;
	    }
       if(speedo[playerid] == 1 || speedo[playerid] == 2) {
			speedo[playerid] = 0;
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Your dashboard display is now switched OFF!");
			return 1;
		}
		if(speedo[playerid] == 0) {
		    speedo[playerid] = 1;
		    for(new d=0; d<3; d++) {
  				if(gVehicleClass[GetPlayerVehicleID(playerid)] == pbike[d][0]) {
 					speedo[playerid] = 2;
       			}
			}
			SendClientMessage(playerid,COLOR_GREEN,"Your dashboard display is now switched ON!");
			return 1;
		}
      return 1;
     }
     if(strcmp(cmd, "/achat", true) == 0)
        {
			GetPlayerName(playerid, playername, sizeof(playername));
        	PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(playername), "level");
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
             	    PlayerInfo[i][pAdmin] = dini_Int(udb_encode(playername), "level");
            		if (PlayerInfo[i][pAdmin] > 0)
           			{
                 		format(string, sizeof(string), "Admin Chat (%s): %s", playername, tmp);
                  		SendClientMessage(i, COLOR_ORANGE, string); }
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
   	if(strcmp(cmd, "/gotobiz", true) == 0) {
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	    biznum[playerid] = dini_Int(udb_encode(playername), "bizowned");
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]);
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to use the business checkpoint teleport!");
			return 1;
		}
		bizbuyable[playerid] = dini_Int(cttmp,"buybar");
		if(bizbuyable[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "That business has been set as un-buyable by server administration and business commands will not work!");
	   		return 1;
		}
		if(biznum[playerid] == 0) {
  			SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not yet own a business, you must buy one before you can teleport to it's checkpoint!");
     		return 1;
		}
		if(PlayerInterior[playerid] > 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must move outside to teleport to your business!");
     		return 1;
		}
		if(biznum[playerid] > 0) {
		    new Float:tx,Float:ty,Float:tz;
		    format(string,sizeof(string),"BIZ%d",biznum[playerid]);
		    telemoney[playerid] = dini_Int(string,"profit");
		    if(GetPlayerMoney(playerid) >= telemoney[playerid]) {
		    	biznum[playerid] = dini_Int(udb_encode(playername), "teleid");
		    	tx = checkpoints[biznum[playerid]][0];
		    	ty = checkpoints[biznum[playerid]][1];
		    	tz = checkpoints[biznum[playerid]][2];
		    	SetPlayerPos(playerid,tx,ty,tz);
		    	GivePlayerMoney(playerid,-telemoney[playerid]);
		    	format(string,sizeof(string),"You have been teleported to your business!! You were charged 5 minutes worth of profit ($%d), OUCH!",telemoney[playerid]);
				SendClientMessage(playerid, COLOR_GREEN, string);
				return 1;
			}
			else {
			    format(string,sizeof(string),"You do not enough money on you to use that command!!! (cost = $%d)",telemoney[playerid]);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
				return 1;
			}
		}

	}
   	if(strcmp(cmd, "/buybiz", true) == 0) {
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]);
	    ownername = dini_Get(cttmp,"owner");
	    playerbiz[playerid] = dini_Int(udb_encode(playername), "bizowned");
	    bizid[playerid] = dini_Int(cttmp,"idnumber");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to purchase a business!");
			return 1;
		}
		if(propactive[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a property checkpoint in order to buy a business!");
			return 1;
		}
		bizbuyable[playerid] = dini_Int(cttmp,"buybar");
		if(bizbuyable[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration and business commands will not work!");
	   		return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be on foot to purchase a business!");
			return 1;
		}
		if(strcmp(ownername,playername,false) == 0) {
				format(propmess, sizeof(propmess), "You already own this property, %s", playername);
				SendClientMessage(playerid, COLOR_YELLOW, propmess);
				return 1;
			}
		if(playerbiz[playerid] > 0) {
  			SendClientMessage(playerid, COLOR_BRIGHTRED, "You can only own ONE business at a time! You must sell your other business first!");
     		return 1;
		}
		if(strcmp(ownername,server,false) == 0) {
			new cash[MAX_PLAYERS];
			cash[playerid] = GetPlayerMoney(playerid);
			if(cash[playerid] >= propcost[playerid]) {
				GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
				dini_IntSet(udb_encode(playername), "teleid", playerCheckpoint[playerid]);
				dini_Set(cttmp,"owner", playername);
				dini_IntSet(udb_encode(playername), "bizowned", bizid[playerid]);
				dini_IntSet(cttmp, "bought", 1);
				GivePlayerMoney(playerid, -propcost[playerid]);
				allowprofit[playerid] = 1;
				profit[playerid] = dini_Int(cttmp,"profit");
				format(propmess, sizeof(propmess), "You just bought this business for $%d. You can sell it using /sellbiz. Your business makes $%d every 5 minutes.", propcost[playerid],profit[playerid]);
				SendClientMessage(playerid, COLOR_GREEN, propmess);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "You may return to the checkpoint at any time to collect your earnings by typing /getprofit and");
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "your property will continue to make money at regular intervals even when you are offline!");
				return 1;
			}
			if(cash[playerid] < propcost[playerid]) {
				format(propmess, sizeof(propmess), "You do not have $%d and cannot afford this business!", propcost[playerid]);
				SendClientMessage(playerid, COLOR_BRIGHTRED, propmess);
				return 1;
			}
		}
		format(propmess, sizeof(propmess), "This business belongs to %s, and cannot be purchased!",ownername);
		SendClientMessage(playerid, COLOR_BRIGHTRED, propmess);
		return 1;
	}
	if(strcmp(cmd, "/sellbiz", true) == 0) {
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]);
	    playerbiz[playerid] = dini_Int(udb_encode(playername), "bizowned");
		ownername = dini_Get(cttmp,"owner");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to sell a business!");
			return 1;
		}
		if(propactive[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a property checkpoint in order to sell a business!");
			return 1;
		}
		bizbuyable[playerid] = dini_Int(cttmp,"buybar");
		if(bizbuyable[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration and business commands will not work!");
	   		return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be on foot to sell a business!");
			return 1;
		}
		if (strcmp(server,ownername,false) == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Nobody has bought this business yet and you are prohibited from selling it!");
			return 1;
		}
		if(playerbiz[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not yet own any business, nice try loser!");
		    return 1;
		}
		if (strcmp(playername,ownername,false) == 0) {
			new cash[MAX_PLAYERS];
			cash[playerid] = GetPlayerMoney(playerid);
			GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
			dini_IntSet(udb_encode(playername), "teleid", 0);
			dini_Set(cttmp,"owner", "server");
			dini_IntSet(udb_encode(playername), "bizowned", 0);
			dini_IntSet(cttmp, "bought", 0);
			dini_IntSet(cttmp, "totalprofit", 0);
			GivePlayerMoney(playerid, propcost[playerid]);
			format(propmess, sizeof(propmess), "You just sold your business for $%d.", propcost[playerid]);
			SendClientMessage(playerid, COLOR_GREEN, propmess);
			return 1;
		}
		format(propmess, sizeof(propmess), "You do not own this business, %s owns it and only they can sell it!", ownername);
		SendClientMessage(playerid, COLOR_BRIGHTRED, propmess);
		return 1;
	}
	if(strcmp(cmd, "/asellbiz", true) == 0) {
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]);
		ownername = dini_Get(cttmp,"owner");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to use this command!");
			return 1;
		}
		if(propactive[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a property checkpoint in order to use this command!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be on foot to use this command!");
			return 1;
		}
		if (strcmp(server,ownername,false) == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Nobody has bought this business yet!");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] == 2) {
			dini_Set(cttmp,"owner", "server");
			dini_IntSet(cttmp, "bought", 0);
			dini_IntSet(cttmp, "totalprofit", 0);
			if(dini_Exists(udb_encode(ownername))) {
			    tempid[playerid] = IsPlayerNameOnline(ownername);
			    if(tempid[playerid] >= 0 || tempid[playerid] < 100) {
			        bank[tempid[playerid]] = bank[tempid[playerid]]+propcost[playerid];
					dini_IntSet(udb_encode(ownername), "bizowned", 0);
					dini_IntSet(udb_encode(ownername), "teleid", 0);
					format(propmess, sizeof(propmess), "You just sold %s's business. The money ($%d) was sent to %s's online bank account.", ownername, propcost[playerid], ownername);
					SendClientMessage(playerid, COLOR_ORANGE, propmess);
					format(propmess, sizeof(propmess), "Admin (%s) has just sold your business! The sale money ($%d) was sent to your onlne bank account!", playername, propcost[playerid]);
                    SendClientMessage(tempid[playerid], COLOR_ORANGE, propmess);
					return 1;
				}
				else {
                    bank[tempid[playerid]] = dini_Int(udb_encode(ownername), "bank");
				    bank[tempid[playerid]] = bank[tempid[playerid]]+propcost[playerid];
				    dini_IntSet(udb_encode(ownername), "bizowned", 0);
					dini_IntSet(udb_encode(ownername), "teleid", 0);
					dini_IntSet(udb_encode(ownername), "bank", bank[tempid[playerid]]);
					format(propmess, sizeof(propmess), "You just sold %s's business. The money ($%d) was sent to %s's online bank account.", ownername, propcost[playerid], ownername);
					SendClientMessage(playerid, COLOR_ORANGE, propmess);
					return 1;
				}
			}
			if(!dini_Exists(udb_encode(ownername))) {
				format(propmess, sizeof(propmess), "You just sold %s's business. The player file is missing and could not be changed.", ownername);
				SendClientMessage(playerid, COLOR_ORANGE, propmess);
				return 1;
			}
		}
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not a server administrator and cannot use this command!");
		return 1;
	}
	if(strcmp(cmd, "/bbuy", true) == 0) {
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]);
	    bizbuyable[playerid] = dini_Int(cttmp, "buybar");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to use this command!");
			return 1;
		}
		if(propactive[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a business checkpoint in order to use this command!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be on foot to use this command!");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] == 2) {
		    if (bizbuyable[playerid] == 1) {
		    	SendClientMessage(playerid, COLOR_ORANGE, "You have set this business to buyable!");
		    	dini_IntSet(cttmp, "buybar", 0);
				return 1;
			}
			SendClientMessage(playerid, COLOR_BRIGHTRED, "This business is already buyable!");
			return 1;
		}
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not a server administrator and cannot use this command!");
		return 1;
	}

	if(strcmp(cmd, "/bunbuy", true) == 0) {
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]);
		ownername = dini_Get(cttmp,"owner");
		bizbuyable[playerid] = dini_Int(cttmp, "buybar");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to use this command!");
			return 1;
		}
		if(propactive[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a business checkpoint in order to use this command!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be on foot to use this command!");
			return 1;
		}
		if(bizbuyable[playerid] == 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "This business is already set as un-buyable!");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] == 2) {
		    if (strcmp(server,ownername,false) == 0) {
		    	SendClientMessage(playerid, COLOR_ORANGE, "You have set this business to non-buyable!");
		    	dini_IntSet(cttmp, "buybar", 1);
				return 1;
			}
			dini_Set(cttmp,"owner", "server");
			dini_IntSet(cttmp, "bought", 0);
			dini_IntSet(cttmp, "totalprofit", 0);
			dini_IntSet(cttmp, "buybar", 1);
			if(dini_Exists(udb_encode(ownername))) {
			    tempid[playerid] = IsPlayerNameOnline(ownername);
			    if(tempid[playerid] >= 0 || tempid[playerid] < 100) {
			        bank[tempid[playerid]] = bank[tempid[playerid]]+propcost[playerid];
					dini_IntSet(udb_encode(ownername), "bizowned", 0);
					dini_IntSet(udb_encode(ownername), "teleid", 0);
					format(propmess, sizeof(propmess), "You just sold %s's business and set it to unbuyable. The money ($%d) was sent to %s's online bank account.", ownername, propcost[playerid], ownername);
					SendClientMessage(playerid, COLOR_ORANGE, propmess);
					format(propmess, sizeof(propmess), "Admin (%s) has just sold your business and set it to unbuyable! The sale money ($%d) was sent to your onlne bank account!", playername, propcost[playerid]);
                    SendClientMessage(tempid[playerid], COLOR_ORANGE, propmess);
					return 1;
				}
				else {
                    bank[tempid[playerid]] = dini_Int(udb_encode(ownername), "bank");
				    bank[tempid[playerid]] = bank[tempid[playerid]]+propcost[playerid];
				    dini_IntSet(udb_encode(ownername), "bizowned", 0);
					dini_IntSet(udb_encode(ownername), "teleid", 0);
					dini_IntSet(udb_encode(ownername), "bank", bank[tempid[playerid]]);
					format(propmess, sizeof(propmess), "You just sold %s's business and set it to unbuyable. The money ($%d) was sent to %s's online bank account.", ownername, propcost[playerid], ownername);
					SendClientMessage(playerid, COLOR_ORANGE, propmess);
					return 1;
				}
			}
			if(!dini_Exists(udb_encode(ownername))) {
				format(propmess, sizeof(propmess), "You just sold %s's business and set it to unbuyable. The player file is missing and could not be changed.", ownername);
				SendClientMessage(playerid, COLOR_ORANGE, propmess);
				return 1;
			}
		}
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not a server administrator and cannot use this command!");
		return 1;
	}
	if(strcmp(cmd, "/getprofit", true) == 0) {
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]);
	    ownername = dini_Get(cttmp,"owner");
	    playerbiz[playerid] = dini_Int(udb_encode(playername), "bizowned");
	    bizid[playerid] = dini_Int(cttmp,"idnumber");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to collect your earnings!");
			return 1;
		}
		if(propactive[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a business checkpoint in order to collect your earnings!");
			return 1;
		}
		bizbuyable[playerid] = dini_Int(cttmp,"buybar");
		if(bizbuyable[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration and business commands will not work!");
	   		return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be on foot to collect your earnings!");
			return 1;
		}
		if(strcmp(ownername,server,false) == 0) {
				format(propmess, sizeof(propmess), "Nobody has bought this business yet, what are you trying to pull punk!");
				SendClientMessage(playerid, COLOR_BRIGHTRED, propmess);
				return 1;
		}
		if(playerbiz[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not yet own any business, nice try loser!");
		    return 1;
		}
		if(strcmp(ownername,playername,false) == 0) {
			totalprofit[playerid] = dini_Int(cttmp, "totalprofit");
			if(totalprofit[playerid] == 0) {
				SendClientMessage(playerid,COLOR_BRIGHTRED,"Your business has not yet made any earnings since your last visit. Please wait for notification of updated earnings!");
				return 1;
			}
			GivePlayerMoney(playerid,totalprofit[playerid]);
			dini_IntSet(cttmp, "totalprofit", 0);
			format(propmess, sizeof(propmess), "You have collected $%d of earnings from your current business, %s! Enjoy!", totalprofit[playerid],ownername);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, propmess);
			return 1;
		}
		format(propmess, sizeof(propmess), "This business belongs to %s, nice try loser! Stop trying to steal other peoples business earnings!",ownername);
		SendClientMessage(playerid, COLOR_BRIGHTRED, propmess);
		return 1;
	}
	if(strcmp(cmd, "/call", true) == 0)
		{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Usage: /call [playerid]");
			return 1;
		}
		giveplayerid = strval(tmp);

		if (logged[playerid] != 1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to make a phone call!");
			return 1;
		}
		if (GetPlayerMoney(playerid) < CallCost)
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have enough money to make a phone call!");
			return 1;
		}
		if (giveplayerid == playerid)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You cannot call yourself!");
		    return 1;
		}
		if (!(IsPlayerConnected(giveplayerid)))
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Inactive player id!");
		    return 1;
		}
		if (Calling[playerid] > -1)
		{
			GetPlayerName(Calling[playerid], giveplayer, sizeof(giveplayer));
			format(string, sizeof(string), "You are already on the phone to %s!", giveplayer);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}
		if (Calling[giveplayerid] > -1)
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			format(string, sizeof(string), "%s is already on the phone, try again later", giveplayer);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			return 1;
		}
		else
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "%s is ringing you, type /answer to answer the call or /hangup to ignore it", sendername);
			SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
			format(string, sizeof(string), "You are ringing %s", giveplayer);
			SendClientMessage(playerid, COLOR_GREEN, string);
   			Calling[playerid] = giveplayerid;
   			Calling[giveplayerid] = playerid;
			Callerid[playerid] = 1;
		    return 1;
	}
	if(strcmp(cmd, "/answer", true) == 0)
		{
		if (logged[playerid] != 1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to answer a phone call!");
			return 1;
		}
		if (Calling[playerid] == -1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Nobody is calling you!");
		    return 1;
		}
		if (Answered[playerid] == 1)
		{
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "You are already on the phone!");
		    return 1;
		}
		else
			GetPlayerName(Calling[playerid], giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "%s has answered your call, talk away", sendername);
			SendClientMessage(Calling[playerid], COLOR_GREEN, string);
			format(string, sizeof(string), "You have answered %s's call, talk away", giveplayer);
			SendClientMessage(playerid, COLOR_GREEN, string);
   			Answered[playerid] = 1;
   			Answered[Calling[playerid]] = 1;
			Callerid[Calling[playerid]] = 1;
		    return 1;
	}
	if(strcmp(cmd, "/hangup", true) == 0)
		{
		if (logged[playerid] != 1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to hang up a phone call!");
			return 1;
		}
		if (Calling[playerid] == -1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not on the phone!");
		    return 1;
		}
		else
		{
			GetPlayerName(Calling[playerid], giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "%s has hung up the phone on you", sendername);
			SendClientMessage(Calling[playerid], COLOR_LIGHTBLUE, string);
			format(string, sizeof(string), "You have hung up on %s", giveplayer);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		new bCalling = Calling[playerid];
   			Calling[playerid] = -1;
   			Answered[playerid] = 0;
			Callerid[playerid] = 0;
   			Calling[bCalling] = -1;
   			Answered[bCalling] = 0;
			Callerid[bCalling] = 0;
		}
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

public eject()
{
	for(new i=0; i < MAX_PLAYERS; i++) {
		if (IsPlayerConnected(i) == 1) {
			if (IsPlayerInAnyVehicle(i) == 1) {
				if (GetPlayerVehicleID(i) == tmpcar2[i] && ejected[i] == 1) {
				    new filename[256];
                    format(filename, sizeof(filename), "%d", GetPlayerVehicleID(i));
					carname = dini_Get(filename, "carname");
   					RemovePlayerFromVehicle(i);
					SetPlayerPos(i,g,h,l);
					ejected[i] = 0;
					format(carmess,sizeof(carmess),"The owner of this %s has called it and you were ejected. Enjoy the walk loser!!!", carname);
                    SendClientMessage(i, COLOR_BRIGHTRED, carmess);
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
            new filename[256];
            format(filename, sizeof(filename), "%d", GetPlayerVehicleID(i));
			carname = dini_Get(filename, "carname");
            GetPlayerPos(i, x, y, z);
            distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
            value = floatround(distance * 11000);
            format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~Vehicle: ~g~%s~n~~b~MpH: ~g~%d ~r~/ ~b~KpH: ~g~%d ~n~~r~Fuel: ~g~%d%s",carname,floatround(value/2200),floatround(value/1400),Gas[GetPlayerVehicleID(i)],"%");
	        GameTextForPlayer(i,string,850,3);
            SavePlayerPos[i][LastX] = x;
            SavePlayerPos[i][LastY] = y;
            SavePlayerPos[i][LastZ] = z;
			}
			if(speedo[i] == 2 && aMessage[i] == 0 && Count[i] == 0)
	        {
	        new Float:x,Float:y,Float:z;
            new Float:distance,value;
            new filename[256];
            format(filename, sizeof(filename), "%d", GetPlayerVehicleID(i));
			carname = dini_Get(filename, "carname");
            GetPlayerPos(i, x, y, z);
            distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
            value = floatround(distance * 11000);
            format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~Vehicle: ~g~%s~n~MpH: ~g~%d ~r~/ ~b~KpH: ~g~%d ~n~~g~Fuel: ~r~N/A",carname,floatround(value/2200),floatround(value/1400));
	        GameTextForPlayer(i,string,850,3);
            SavePlayerPos[i][LastX] = x;
            SavePlayerPos[i][LastY] = y;
            SavePlayerPos[i][LastZ] = z;
			}
			// this next section should be uncommented to allow fuel warnings in the chat window - will display at ever 10% drop
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
    		new filename[256];
			 format(filename, sizeof(filename), "%d", GetPlayerVehicleID(i));
			 carname = dini_Get(filename, "carname");
			 format(carmess, sizeof(carmess), "Your %ss fuel has dropped to 0% and it broke down, Enjoy the walk!",carname);
			 SendClientMessage(i,COLOR_BRIGHTRED,carmess);
			 messaged[i] = 1;
			 dini_IntSet(filename, "used", 0);
			 Gas[GetPlayerVehicleID(i)] = 100;
			 new cara[256];
			 cara[i] = GetPlayerVehicleID(i);
			 SetVehicleToRespawn(GetPlayerVehicleID(i));
			 modded[cara[i]] = 0;
			 SetTimer("resetmessage",7000,0);
			 return 1;
		   }
		   if(GetPlayerMoney(i) <= 2 && Filling[i] == 1) {
		    Filling[i] = 0;
			 SendClientMessage(i,COLOR_BRIGHTRED, "You do not have sufficient money to continue filling your vehicle!");
			 return 1;
		   }
	   }
   }
  return 1;
 }

public fillcheck()
{
	for(new i=0;i<MAX_PLAYERS;i++) {
		if(Gas[GetPlayerVehicleID(i)] > 99 && Filling[i] == 1)
		   {
             new filename[256];
			 format(filename, sizeof(filename), "%d", GetPlayerVehicleID(i));
			 carname = dini_Get(filename, "carname");
			 Filling[i] = 0;
			 format(carmess, sizeof(carmess), "Your %s's tank is now full. Have a nice day!",carname);
             SendClientMessage(i,COLOR_GREEN,carmess);
			 return 1;
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
				carname = dini_Get(filename, "carname");
				format(carmess,sizeof(carmess),"Your %s has been reset and you have been teleported to it. /callcar will",carname);
                SendClientMessage(i, COLOR_ORANGE, carmess);
				SendClientMessage(i, COLOR_ORANGE, "work properly once you have entered it. Have a nice day!");
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
    for(new d=0; d<3; d++) {
  		if(gVehicleClass[GetPlayerVehicleID(i)] == pbike[d][0]) {
 			return 1;
       }
	}
	if(gVehicleClass[GetPlayerVehicleID(i)] == 571) {
 			return 1;
    }
    if(gVehicleClass[GetPlayerVehicleID(i)] == 471) {
 			return 1;
    }
    if(gVehicleClass[GetPlayerVehicleID(i)] == 539) {
 			return 1;
    }
	if(GetPlayerState(i) == PLAYER_STATE_DRIVER) {
    	Gas[GetPlayerVehicleID(i)]--;
	}
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
	new filename[256];
	propactive[playerid] = 0;
	allowprofit[playerid] = 0;
	switch(getCheckpointType(playerid))
	{
		case CP_STATION1:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
	 		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
       	case CP_STATION2:
		if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
		}
       	case CP_STATION3:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
		}
       	case CP_STATION4:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
       	case CP_STATION5:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
         format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
       	case CP_STATION6:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
   		case CP_STATION7:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
       	case CP_STATION8:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
       	case CP_STATION9:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
       	case CP_STATION10:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
       	case CP_STATION11:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
       	case CP_STATION12:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
        	case CP_STATION13:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
       	case CP_STATION14:
	  	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
        case CP_STATION15:
	   	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
	   	case CP_STATION16:
	   	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
	   	case CP_LVSTATION:
	   	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
	   	case CP_VMSTATION:
	   	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
	   	case CP_LSSTATION:
	   	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
	   	case CP_SFSTATION:
	   	if(IsPlayerInAnyVehicle(playerid) && Filling[playerid] == 1)
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
	   	    format(fuelper,sizeof(fuelper),"You stopped refuelling and the %s is only %d%s full!", carname,Gas[GetPlayerVehicleID(playerid)], "%");
		   	SendClientMessage(playerid,COLOR_BRIGHTRED,fuelper);
            Filling[playerid] = 0;
	   	}
	}
}


public OnPlayerEnterCheckpoint(playerid)
{   new fuelper[256];
	new filename[256];
    switch(getCheckpointType(playerid))
	{
		case CP_STATION1:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
	   	    format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
        }
       	case CP_STATION2:
		if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
	   	}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION3:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION4:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION5:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION6:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
   		case CP_STATION7:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION8:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION9:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION10:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION11:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION12:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
        	case CP_STATION13:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
       	case CP_STATION14:
	  	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
        case CP_STATION15:
	   	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
	   	case CP_STATION16:
	   	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
	   	case CP_LVSTATION:
	   	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
	   	case CP_VMSTATION:
	   	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
	   	case CP_LSSTATION:
	   	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
	   	case CP_SFSTATION:
	   	if(IsPlayerInAnyVehicle(playerid))
	   	{
       		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
	 		carname = dini_Get(filename, "carname");
       		format(fuelper,sizeof(fuelper),"Type /refuel to re-fuel this %s", carname);
            SendClientMessage(playerid,COLOR_LIGHTBLUE,fuelper);
		}
	   	else
	   	{
	   		SendClientMessage(playerid, COLOR_BRIGHTRED, "You need to be in a vehicle to refill at a gas station!");
       	}
		case CP_BANK: {
			SendClientMessage(playerid, COLOR_GREEN, "Welcome to the tAxI Systems inc. ATM Banking service!");
			SendClientMessage(playerid, COLOR_GREEN, "Type /bankhelp to see how to control your personal bank account!");
		}
		case CP_BANK_2: {
			SendClientMessage(playerid, COLOR_GREEN, "Welcome to the tAxI Systems inc. ATM Banking service!");
			SendClientMessage(playerid, COLOR_GREEN, "Type /bankhelp to see how to control your personal bank account!");
		}
		case CP_BANK_3: {
			SendClientMessage(playerid, COLOR_GREEN, "Welcome to the tAxI Systems inc. ATM Banking service!");
			SendClientMessage(playerid, COLOR_GREEN, "Type /bankhelp to see how to control your personal bank account!");
		}
		case BIZ1: {
			if(propactive[playerid] == 0) {
				biznum[playerid] = 1;
				format(cttmp, sizeof(cttmp), "%s","BIZ1");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
               		format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
  		case BIZ2: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 2;
				format(cttmp, sizeof(cttmp), "%s","BIZ2");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ3: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 3;
				format(cttmp, sizeof(cttmp), "%s","BIZ3");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ4: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 4;
				format(cttmp, sizeof(cttmp), "%s","BIZ4");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ5: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 5;
				format(cttmp, sizeof(cttmp), "%s","BIZ5");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ6: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 6;
				format(cttmp, sizeof(cttmp), "%s","BIZ6");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ7: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 7;
				format(cttmp, sizeof(cttmp), "%s","BIZ7");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ8: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 8;
				format(cttmp, sizeof(cttmp), "%s","BIZ8");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ9: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 9;
				format(cttmp, sizeof(cttmp), "%s","BIZ9");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ10: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 10;
				format(cttmp, sizeof(cttmp), "%s","BIZ10");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ11: {
			if(propactive[playerid] == 0) {
				biznum[playerid] = 11;
				format(cttmp, sizeof(cttmp), "%s","BIZ11");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
               		format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
  		case BIZ12: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 12;
				format(cttmp, sizeof(cttmp), "%s","BIZ12");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ13: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 13;
				format(cttmp, sizeof(cttmp), "%s","BIZ13");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ14: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 14;
				format(cttmp, sizeof(cttmp), "%s","BIZ14");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ15: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 15;
				format(cttmp, sizeof(cttmp), "%s","BIZ15");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ16: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 16;
				format(cttmp, sizeof(cttmp), "%s","BIZ16");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ17: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 17;
				format(cttmp, sizeof(cttmp), "%s","BIZ17");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ18: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 18;
				format(cttmp, sizeof(cttmp), "%s","BIZ18");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ19: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 19;
				format(cttmp, sizeof(cttmp), "%s","BIZ19");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ20: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 20;
				format(cttmp, sizeof(cttmp), "%s","BIZ20");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}case BIZ21: {
			if(propactive[playerid] == 0) {
				biznum[playerid] = 21;
				format(cttmp, sizeof(cttmp), "%s","BIZ21");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
               		format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
  		case BIZ22: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 22;
				format(cttmp, sizeof(cttmp), "%s","BIZ22");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ23: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 23;
				format(cttmp, sizeof(cttmp), "%s","BIZ23");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ24: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 24;
				format(cttmp, sizeof(cttmp), "%s","BIZ24");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ25: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 25;
				format(cttmp, sizeof(cttmp), "%s","BIZ25");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ26: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 26;
				format(cttmp, sizeof(cttmp), "%s","BIZ26");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ27: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 27;
				format(cttmp, sizeof(cttmp), "%s","BIZ27");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ28: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 28;
				format(cttmp, sizeof(cttmp), "%s","BIZ28");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ29: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 29;
				format(cttmp, sizeof(cttmp), "%s","BIZ29");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ30: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 30;
				format(cttmp, sizeof(cttmp), "%s","BIZ30");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}case BIZ31: {
			if(propactive[playerid] == 0) {
				biznum[playerid] = 31;
				format(cttmp, sizeof(cttmp), "%s","BIZ31");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
               		format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
  		case BIZ32: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 32;
				format(cttmp, sizeof(cttmp), "%s","BIZ32");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ33: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 33;
				format(cttmp, sizeof(cttmp), "%s","BIZ33");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ34: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 34;
				format(cttmp, sizeof(cttmp), "%s","BIZ34");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ35: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 35;
				format(cttmp, sizeof(cttmp), "%s","BIZ35");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ36: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 36;
				format(cttmp, sizeof(cttmp), "%s","BIZ36");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ37: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 37;
				format(cttmp, sizeof(cttmp), "%s","BIZ37");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ38: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 38;
				format(cttmp, sizeof(cttmp), "%s","BIZ38");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ39: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 39;
				format(cttmp, sizeof(cttmp), "%s","BIZ39");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ40: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 40;
				format(cttmp, sizeof(cttmp), "%s","BIZ40");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}case BIZ41: {
			if(propactive[playerid] == 0) {
				biznum[playerid] = 41;
				format(cttmp, sizeof(cttmp), "%s","BIZ41");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
               		format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
  		case BIZ42: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 42;
				format(cttmp, sizeof(cttmp), "%s","BIZ42");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ43: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 43;
				format(cttmp, sizeof(cttmp), "%s","BIZ43");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ44: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 44;
				format(cttmp, sizeof(cttmp), "%s","BIZ44");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ45: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 45;
				format(cttmp, sizeof(cttmp), "%s","BIZ45");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ46: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 46;
				format(cttmp, sizeof(cttmp), "%s","BIZ46");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ47: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 47;
				format(cttmp, sizeof(cttmp), "%s","BIZ47");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ48: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 48;
				format(cttmp, sizeof(cttmp), "%s","BIZ48");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ49: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 49;
				format(cttmp, sizeof(cttmp), "%s","BIZ49");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ50: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 50;
				format(cttmp, sizeof(cttmp), "%s","BIZ50");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}case BIZ51: {
			if(propactive[playerid] == 0) {
				biznum[playerid] = 51;
				format(cttmp, sizeof(cttmp), "%s","BIZ51");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
               		format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
  		case BIZ52: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 52;
				format(cttmp, sizeof(cttmp), "%s","BIZ52");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ53: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 53;
				format(cttmp, sizeof(cttmp), "%s","BIZ53");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ54: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 54;
				format(cttmp, sizeof(cttmp), "%s","BIZ54");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ55: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 55;
				format(cttmp, sizeof(cttmp), "%s","BIZ55");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ56: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 56;
				format(cttmp, sizeof(cttmp), "%s","BIZ56");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ57: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 57;
				format(cttmp, sizeof(cttmp), "%s","BIZ57");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ58: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 58;
				format(cttmp, sizeof(cttmp), "%s","BIZ58");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ59: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 59;
				format(cttmp, sizeof(cttmp), "%s","BIZ59");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ60: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 60;
				format(cttmp, sizeof(cttmp), "%s","BIZ60");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "This business has been set as un-buyable by server administration!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"This business is currently vacant and can be purchased for $%d by typing /buybiz. This business earns $%d every 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Welcome back to your business, %s. Type /getprofit to collect the earnings your business has made since your last collection.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"This business belongs to %s, and is not for sale!", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
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
		carname = dini_Get(filename, "carname");
		new val1[256];
		new playername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
		val1 = dini_Get(filename, "owner");
 		secure[playerid] = dini_Int(filename, "secure");
 		admined[playerid] = dini_Int(filename, "asecure");
        if(admined[playerid] == 1) {
            if(PlayerInfo[playerid][pAdmin] > 0) {
				format(carmess,sizeof(carmess),"This %s is currently set for admin use only. It will eject anyone who is not an admin.",carname);
                SendClientMessage(playerid,COLOR_ORANGE,carmess);
				used[playerid] = 1;
				if(IsPlayerAtVehicleSpawn(playerid,GetPlayerVehicleID(playerid)) == 1) {
		    	    Gas[GetPlayerVehicleID(playerid)] = 100;
		    	}
				SetTimer("fuelremain",100,0);
 		    	return 1;
			}
     		GetPlayerPos(playerid,ta,tb,tc);
     		SetPlayerPos(playerid,ta,tb,tc+5);
     		RemovePlayerFromVehicle(playerid);
 			format(string, sizeof(string), "This %s has been set to allow admin/moderator control only and you are prohibited from using it.",carname);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			return 1;
		}
		if(admined[playerid] == 2) {
		    if(PlayerInfo[playerid][pAdmin] > 0) {
		        format(carmess,sizeof(carmess),"This %s is currently set for admin use only. It will kill anyone who is not an admin.",carname);
                SendClientMessage(playerid,COLOR_ORANGE,carmess);
				used[playerid] = 1;
				if(IsPlayerAtVehicleSpawn(playerid,GetPlayerVehicleID(playerid)) == 1) {
		    	    Gas[GetPlayerVehicleID(playerid)] = 100;
		    	}
				SetTimer("fuelremain",100,0);
 		    	return 1;
			}
			RemovePlayerFromVehicle(playerid);
			SetPlayerHealth(playerid, -999);
 			format(string, sizeof(string), "Server administration has set this %s to kill anyone who try's to drive it...R.I.P loser!",carname);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "%s just tried to steal an admin only %s and was killed by the security system...R.I.P loser!",playername,carname);
			SendClientMessageToAll(COLOR_ORANGE, string);
			return 1;
		}
		if(secure[playerid] == 0) {
			if (strcmp(val1,playername,false) == 0) {
				SendClientMessage(playerid, COLOR_GREEN, "Your vehicle security system is currently deactivated.");
		    	used[playerid] = 1;
		    	if(IsPlayerAtVehicleSpawn(playerid,GetPlayerVehicleID(playerid)) == 1) {
		    	    Gas[GetPlayerVehicleID(playerid)] = 100;
		    	}
				SetTimer("fuelremain",100,0);
		    	return 1;
			}
		}
	 	if(secure[playerid] == 1) {
	 	    if (strcmp(val1,playername,false) == 0) {
				SendClientMessage(playerid, COLOR_GREEN, "Your vehicle security system is currently set to eject intruders.");
		    	used[playerid] = 1;
		    	if(IsPlayerAtVehicleSpawn(playerid,GetPlayerVehicleID(playerid)) == 1) {
		    	    Gas[GetPlayerVehicleID(playerid)] = 100;
		    	}
				SetTimer("fuelremain",100,0);
		    	return 1;
			}
			if(PlayerInfo[playerid][pAdmin] > 1) {
			    format(string, sizeof(string), "The owner of this %s (%s), has secured this vehicle but as level 2 ADMIN you can still use it.",carname, val1);
				SendClientMessage(playerid, COLOR_ORANGE, string);
				return 1;
			}
     		GetPlayerPos(playerid,ta,tb,tc);
     		SetPlayerPos(playerid,ta,tb,tc+5);
     		RemovePlayerFromVehicle(playerid);
 			format(string, sizeof(string), "The owner of this %s (%s), has secured this vehicle and you are prohibited from using it.", carname, val1);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}
 		if(secure[playerid] == 2) {
 		    if (strcmp(val1,playername,false) == 0) {
				SendClientMessage(playerid, COLOR_GREEN, "Your vehicle security system is currently set to kill intruders.");
		    	used[playerid] = 1;
		    	if(IsPlayerAtVehicleSpawn(playerid,GetPlayerVehicleID(playerid)) == 1) {
		    	    Gas[GetPlayerVehicleID(playerid)] = 100;
		    	}
				SetTimer("fuelremain",100,0);
		    	return 1;
			}
			if(PlayerInfo[playerid][pAdmin] > 1) {
			    format(string, sizeof(string), "The owner of this %s (%s), has set the vehicle to kill intruders but as level 2 ADMIN you can still use it.", carname, val1);
				SendClientMessage(playerid, COLOR_ORANGE, string);
				return 1;
			}
			RemovePlayerFromVehicle(playerid);
			SetPlayerHealth(playerid, -999);
 			format(string, sizeof(string), "The owner of this %s (%s), has set this vehicle to kill anyone who try's to drive it...R.I.P loser!",carname, val1);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			format(string, sizeof(string), "%s just tried to steal %s's %s and was killed by the security system...R.I.P loser!",playername,val1,carname);
			SendClientMessageToAll(COLOR_LIGHTBLUE, string);
			return 1;
		}
		used[playerid] = 1;
		if(IsPlayerAtVehicleSpawn(playerid,GetPlayerVehicleID(playerid)) == 1) {
  			Gas[GetPlayerVehicleID(playerid)] = 100;
 		}
		SetTimer("fuelremain",100,0);
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    for(new d=0; d<3; d++) {
  		if(gVehicleClass[vehicleid] == pbike[d][0]) {
 			speedo[playerid] = 2;
       }
	}
	new filename[256];
	format(filename, sizeof(filename), "%d", vehicleid);
	carname = dini_Get(filename, "carname");
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
	if(tmp[playerid] == 0) {
		format(filename, sizeof(filename), "%d", vehicleid);
    	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
    	    new tmp1[256];
    	    tmp1 = dini_Get(filename, "owner");
    	    carbuyable[playerid] = dini_Int(filename, "buybar");
    	    if (strcmp(tmp1,playername,false) == 0) {
				new string[256];
				carcost[playerid] = dini_Int(filename, "carcost");
				format(string, sizeof(string), "Welcome to your %s %s, please drive carefully!", carname, tmp1);
				SendClientMessage(playerid, COLOR_GREEN, string);
				ignition[playerid] = 1;
				return 1;
			}
			if (strcmp(tmp1,server,false) == 0 && logged[playerid] == 1) {
                if(carbuyable[playerid] == 1) {
                	new string[256];
			        format(string,sizeof(string),"This %s has been set as non-buyable by server administration!",carname);
			        SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			        return 1;
			    }
			    new string[256];
			    carcost[playerid] = dini_Int(filename, "carcost");
    	        format(string, sizeof(string), "This %s is for sale and costs $%d, type /buycar to buy this vehicle.",carname, carcost[playerid]);
    	        SendClientMessage(playerid, COLOR_YELLOW, string);
    	        return 1;
			}
			if (strcmp(tmp1,server,false) == 0 && logged[playerid] == 0) {
			    if(carbuyable[playerid] == 1) {
			        new string[256];
			        format(string,sizeof(string),"This %s has been set as non-buyable by server administration!",carname);
			        SendClientMessage(playerid, COLOR_BRIGHTRED, string);
					return 1;
			    }
			    new string[256];
			    carcost[playerid] = dini_Int(filename, "carcost");
    	        format(string, sizeof(string), "This %s is for sale and costs $%d, but you cannot purchase it untill you /login.", carname, carcost[playerid]);
    	        SendClientMessage(playerid, COLOR_BRIGHTRED, string);
    	        return 1;
			}
   			else {
    	        new string[256];
    	        carcost[playerid] = dini_Int(filename, "carcost");
    	        format(string, sizeof(string), "This %s belongs to %s, and cannot be purchased.", carname, tmp1);
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
   	    new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(i));
		carname = dini_Get(filename, "carname");
		if(used[i] == 1)
		{
		    if(IsPlayerInAnyVehicle(i))
		    {
		    	new fuelper[256];
		    	used[i] = 0;
        		format(fuelper,sizeof(fuelper),"This %s has %d%s of it's fuel remaining.", carname, Gas[GetPlayerVehicleID(i)],"%");
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

public Float:PlayerDistToVehicleSpawn(playerid,vehicleid)
{
	new Float:x1,Float:y1,Float:z1;
	new Float:x2,Float:y2,Float:z2;
	GetVehiclePos(vehicleid,x1,y1,z1);
	GetPlayerPos(playerid,x2,y2,z2);
	return floatsqroot(floatpower(x1 - x2, 2) + floatpower(y1 - y2, 2) + floatpower(z1 - z2, 2));
}

public IsPlayerAtVehicleSpawn(playerid,vehicleid)
{
    new Float:x,Float:y,Float:z;
    GetPlayerPos(playerid,x,y,z);
	if(gSpawnx[vehicleid] == floatround(x) && gSpawny[vehicleid] == floatround(y) && gSpawnz[vehicleid] == floatround(z)) {
	    return 1;
	}
	return 0;
}

public OnVehicleMod(vehicleid,componentid)
{
	new playerid = GetDriverID(vehicleid);
	new filename[256];
	format(filename, sizeof(filename), "%d", vehicleid);
	carname = dini_Get(filename, "carname");
	new val1[256];
	new playername[MAX_PLAYER_NAME];
	dini_IntSet(filename, "used", 1);
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	val1 = dini_Get(filename, "owner");
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
    	    if (strcmp(val1,playername,false) == 0) {
				for(new s=0; s<20; s++) {
     				if(componentid == spoiler[s][0]) {
       					modtier[vehicleid] = 1;
   	        		}
				}
				for(new s=0; s<3; s++) {
     				if(componentid == nitro[s][0]) {
       					modtier[vehicleid] = 2;
   	        		}
				}
				for(new s=0; s<23; s++) {
     				if(componentid == fbumper[s][0]) {
       					modtier[vehicleid] = 3;
   	        		}
				}
				for(new s=0; s<22; s++) {
     				if(componentid == rbumper[s][0]) {
       					modtier[vehicleid] = 4;
   	        		}
				}
				for(new s=0; s<28; s++) {
     				if(componentid == exhaust[s][0]) {
       					modtier[vehicleid] = 5;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == bventr[s][0]) {
       					modtier[vehicleid] = 6;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == bventl[s][0]) {
       					modtier[vehicleid] = 7;
   	        		}
				}
				for(new s=0; s<4; s++) {
     				if(componentid == bscoop[s][0]) {
       					modtier[vehicleid] = 8;
   	        		}
				}
				for(new s=0; s<13; s++) {
     				if(componentid == rscoop[s][0]) {
       					modtier[vehicleid] = 9;
   	        		}
				}
				for(new s=0; s<21; s++) {
     				if(componentid == lskirt[s][0]) {
       					modtier[vehicleid] = 10;
   	        		}
				}
				for(new s=0; s<21; s++) {
     				if(componentid == rskirt[s][0]) {
       					modtier[vehicleid] = 11;
   	        		}
				}
				for(new s=0; s<1; s++) {
     				if(componentid == hydraulics[s][0]) {
       					modtier[vehicleid] = 12;
   	        		}
				}
				for(new s=0; s<1; s++) {
     				if(componentid == base[s][0]) {
       					modtier[vehicleid] = 13;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == rbbars[s][0]) {
       					modtier[vehicleid] = 14;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == fbbars[s][0]) {
       					modtier[vehicleid] = 15;
   	        		}
				}
				for(new s=0; s<17; s++) {
     				if(componentid == wheels[s][0]) {
       					modtier[vehicleid] = 16;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == lights[s][0]) {
       					modtier[vehicleid] = 17;
   	        		}
				}
				new modname[256],carfile[256];
				format(modname,sizeof(modname),"mod%d",modtier[vehicleid]);
				format(carfile,sizeof(carfile),"%d",vehicleid);
				dini_IntSet(carfile,"modded",1);
				dini_IntSet(carfile,modname,componentid);
				return 1;
			}
	}
	return 0;
}

public OnVehiclePaintjob(vehicleid,paintjobid)
{
    new playerid = GetDriverID(vehicleid);
	new filename[256];
	format(filename, sizeof(filename), "%d", vehicleid);
	carname = dini_Get(filename, "carname");
	new val1[256];
	new playername[MAX_PLAYER_NAME];
	dini_IntSet(filename, "used", 1);
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	val1 = dini_Get(filename, "owner");
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
    	    if (strcmp(val1,playername,false) == 0) {
    	        new carfile[256];
				format(carfile,sizeof(carfile),"%d",vehicleid);
				dini_IntSet(carfile,"modded",1);
				dini_IntSet(carfile,"paintjob",paintjobid);
				return 1;
			}
	}
	return 0;
}

public OnVehicleRespray(vehicleid,color1,color2)
{
    new playerid = GetDriverID(vehicleid);
	new filename[256];
	format(filename, sizeof(filename), "%d", vehicleid);
	carname = dini_Get(filename, "carname");
	new val1[256];
	new playername[MAX_PLAYER_NAME];
	dini_IntSet(filename, "used", 1);
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	val1 = dini_Get(filename, "owner");
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
    	    if (strcmp(val1,playername,false) == 0) {
    	        new carfile[256];
				format(carfile,sizeof(carfile),"%d",vehicleid);
				dini_IntSet(carfile,"modded",1);
				dini_IntSet(carfile,"col1",color1);
				dini_IntSet(carfile,"col2",color2);
				return 1;
			}
	}
	return 0;
}

public IsVehicleAtSpawn(vehicleid)
{
    new Float:x,Float:y,Float:z;
    GetVehiclePos(vehicleid,x,y,z);
	if(gSpawnx[vehicleid] == floatround(x) && gSpawny[vehicleid] == floatround(y) && gSpawnz[vehicleid] == floatround(z)) {
	    return 1;
	}
	return 0;
}

public OnVehicleRespawn(vehicleid)
{
	modded[vehicleid] = 0;
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	modded[vehicleid] = 0;
	return 1;
}

public modvehicletimed()
{
    for(new vehicleid=1; vehicleid<=MAX_CARS; vehicleid++) {
        if(modded[vehicleid] == 0) {
        	if(IsVehicleAtSpawn(vehicleid) == 1) {
				modded[vehicleid] = 1;
				new modname[256],carfile[256],cmod[MAX_CARS];
    			format(carfile,sizeof(carfile),"%d",vehicleid);
    			savemods[vehicleid] = dini_Int(carfile,"modded");
    			modded[vehicleid] = 1;
				format(carfile,sizeof(carfile),"%d",vehicleid);
				for(new c=1; c<=17; c++) {
					format(modname,sizeof(modname),"mod%d",c);
					cmod[vehicleid] = dini_Int(carfile,modname);
					if(cmod[vehicleid] > 0) {
						AddVehicleComponent(vehicleid,cmod[vehicleid]);
 					}
				}
				col1[vehicleid] = dini_Int(carfile,"col1");
				col2[vehicleid] = dini_Int(carfile,"col2");
				if(col1[vehicleid] > -1 || col2[vehicleid] != -1) {
 					ChangeVehicleColor(vehicleid,col1[vehicleid],col2[vehicleid]);
				}
				cmod[vehicleid] = dini_Int(carfile,"paintjob");
				if(cmod[vehicleid] > -1) {
					ChangeVehiclePaintjob(vehicleid,cmod[vehicleid]);
				}
			}
		}
	}
}

public ModVehicle(vehicleid)
{
    new modname[256],carfile[256],cmod[MAX_CARS];
    format(carfile,sizeof(carfile),"%d",vehicleid);
    savemods[vehicleid] = dini_Int(carfile,"modded");
    modded[vehicleid] = 1;
	format(carfile,sizeof(carfile),"%d",vehicleid);
	for(new c=1; c<=17; c++) {
		format(modname,sizeof(modname),"mod%d",c);
		cmod[vehicleid] = dini_Int(carfile,modname);
		if(cmod[vehicleid] > 0) {
			AddVehicleComponent(vehicleid,cmod[vehicleid]);
 		}
	}
	col1[vehicleid] = dini_Int(carfile,"col1");
	col2[vehicleid] = dini_Int(carfile,"col2");
	if(col1[vehicleid] > -1 || col2[vehicleid] != -1) {
 		ChangeVehicleColor(vehicleid,col1[vehicleid],col2[vehicleid]);
	}
	cmod[vehicleid] = dini_Int(carfile,"paintjob");
	if(cmod[vehicleid] > -1) {
		ChangeVehiclePaintjob(vehicleid,cmod[vehicleid]);
	}
}

public GetDriverID(vehicleid)
{
    for(new i=0; i<MAX_PLAYERS; i++) {
        if(IsPlayerConnected(i)) {
            if(IsPlayerInAnyVehicle(i)) {
                if(GetPlayerVehicleID(i) == vehicleid) {
					return i;
                }
            }
        }
    }
    return -1;
}
