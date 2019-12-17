/*
ProjectRealLife
Made by Sebihunter
Big Thanks to: Mr-Tape, Donny k, Firzen
---------------------------------------
Update 13.6.2008
Car Seller added
---------------------------------------
Update 8.5.2008
Little Bugfix in job menu
---------------------------------------
Update 5.5.2008
Translated variables and indents
"Fixed" some bad english :P
---------------------------------------
First Release 3.5.2008
*/
#include <a_samp>
#include <dudb>
#include <Dini>
#include <dutils>
#include <seif_text>
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_CYAN 0x00BFF3AA
#define COLOR_BLACK 0x000000AA
#define COLOR_BROWN 0XA52A2AAA
#define COLOR_GOLD 0xB8860BAA
#define COLOR_INDIGO 0x4B00B0AA
#define COLOR_LAWNGREEN 0x7CFC00AA
#define COLOR_LIMEGREEN 0x32CD32AA
#define COLOR_OLIVE 0x808000AA
#define COLOR_SEAGREEN 0x2E8B57AA
#define COLOR_TOMATO 0xFF6347AA
#define COLOR_YELLOWGREEN 0x9ACD32AA
#define COLOR_MEDIUMAQUA 0x83BFBFAA
#define COLOR_FLBLUE 0x6495EDAA
#define COLOR_MAGENTA 0xFF00FFFF
#define COLOR_PURPLE 0x800080AA

#define TEAM_TUTORIAL 1
#define TEAM_TUTORIAL2 2
#define TEAM_TUTORIAL3 3
#define TEAM_TUTORIAL4 4
#define TEAM_JOBLESS 5
#define TEAM_POLICE 6
#define TEAM_MECHANIC 7
#define TEAM_DSCHOOL 8
#define TEAM_CARSELLER 9

//#define MAX_POINTS 19
#define MAX_POINTS 16

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
/*#define CP_POLICE  16
#define CP_MECHANIC  17
#define CP_DSCHOOL 18*/
//Speedometer
#define SLOTS 200
//Petrol/Fuel
#define TIME 4000
#define AMOUNT 100
#define MAX_CARS 1000

#define MAX_JOBS 5
#define MAX_passport 2
#define MAX_license 2
#define MAX_nolicense 2

enum SavePlayerPosEnum{
Float:LastX,
Float:LastY,
Float:LastZ
}

public Float:GetDistanceBetweenPlayers(p1,p2){
new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
if (!IsPlayerConnected(p1) || !IsPlayerConnected(p2)){
return -1.00;
}
GetPlayerPos(p1,x1,y1,z1);
GetPlayerPos(p2,x2,y2,z2);
return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));

}

new playerCheckpoint[MAX_PLAYERS];
new Petrol[MAX_CARS];
new logged[MAX_PLAYERS];
new Float:health;
new Float:armour;
new SpeedMode = 0;
new UpdateSeconds = 1;
new SavePlayerPos[SLOTS][SavePlayerPosEnum];
new job[MAX_PLAYERS];
new passport[MAX_PLAYERS];
new license[MAX_PLAYERS];
new nolicense[MAX_PLAYERS];
new tmpstring[256];
new gTeam[MAX_PLAYERS];
new Menu:warehouse;
new Menu:jobmenu;

forward PutAtPos(playerid);
forward UpdateSpeed();
forward checkit();

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
{1577.7729,2182.5112,1616.5842,2242.3628}
/*{2239.3586,2432.2524,2295.6482,2479.7510},
{2088.2542,1384.3591,2235.7737,1422.5857},
{1058.6143,1225.3031,1096.8842,1295.9443}*/
};


new Float:checkpoints[MAX_POINTS][4] = {
{2109.2126,917.5845,10.8203,5.0},
{2640.1831,1103.9224,10.8203,5.0},
{611.8934,1694.7921,6.7193,5.0},
{-1327.5398,2682.9771,49.7896,5.0},
{-2413.7427,975.9317,45.0031,5.0},
{-1672.3597,414.2950,6.8866,5.0},
{-2244.1365,-2560.6294,31.6276,5.0},
{-1603.0166,-2709.3589,48.2419,5.0},
{1939.3275,-1767.6813,13.2787,5.0},
{-94.7651,-1174.8079,1.9979,5.0},
{1381.6699,462.6467,19.8540,5.0},
{657.8167,-559.6507,16.0630,5.0},
{-1478.2916,1862.8318,32.3617,5.0},
{2147.3054,2744.9377,10.5263,5.0},
{2204.9602,2480.3494,10.5278,5.0},
{1590.9493,2202.2637,10.5247,5.0}
/*{2295.1941,2460.7080,10.8203,5.0},
{2171.2793,1405.3374,11.0625,5.0},
{1058.8782,1270.1970,10.8203,5.0}*/
};




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
CP_STATION16
/*CP_POLIZEI,
CP_AUTOHAUS,
CP_FAHRSCHULE*/
};

new jobs[MAX_JOBS][256] = {
{"Jobless"},
{"Police Officer"},
{"Mechanic"},
{"Driving Teacher"},
{"Car Seller"}
};




main()
{
	print("----------------------------------");
	print(" ProjectRealLife");
	print(" By Sebihunter | Copright Sebihunter");
	print("----------------------------------");
	print(" Preview Version - Alpha 12");
}


public OnGameModeInit()
{

	for(new c=0;c<MAX_CARS;c++)
	 {
	 Petrol[c] = AMOUNT;
  }
    SetTimer("CheckFuel", TIME, 1);
    SetTimer("checkpointUpdate", 1100, 1);
    SetTimer("UpdateSpeed", UpdateSeconds*1000, 1);
    SetTimer("PayDay",600000,1);

	SetGameModeText("ProjectRealLife Preview");
	SetDisabledWeapons(43,44,45);
    EnableTirePopping(1);
    EnableZoneNames(0);
    AllowInteriorWeapons(1);
    EnableStuntBonusForAll(0);
    AllowAdminTeleport(1);
    DisableInteriorEnterExits(1);

warehouse = CreateMenu("Warehouse", 1, 50.0, 180.0, 200.0, 200.0);
AddMenuItem(warehouse, 0, "Armour");
AddMenuItem(warehouse, 0, "Medikit");
AddMenuItem(warehouse, 0, "Pistol");
AddMenuItem(warehouse, 0, "Everything");
AddMenuItem(warehouse, 0, "Exit");

jobmenu = CreateMenu("Job", 1, 50.0, 180.0, 200.0, 200.0);
AddMenuItem(jobmenu, 0, "Start job");
AddMenuItem(jobmenu, 0, "Quit job");
AddMenuItem(jobmenu, 0, "Exit");



    CreatePickup ( 1239, 23, 1091.2158,2120.1648,15.3504 ); //Warehouse Menu
    CreatePickup ( 1559, 23, 1062.3185,2075.2961,10.8203 ); //Warehouse GetIn
    CreatePickup ( 1559, 23, 1062.1703,2077.5857,10.8203 ); //Warehouse GetOut
    CreatePickup ( 1272, 23, 2294.9189,2460.3972,10.8203 ); //Police
    CreatePickup ( 1272, 23, 2847.0732,982.9391,10.7500 ); //Mechanic
    CreatePickup ( 1272, 23, 1173.3378,1349.1436,10.9219 ); //Driving School
    CreatePickup ( 1272, 23, 2136.7747,1397.8428,10.8203 ); //Car Seller
    
    AddPlayerClass(254,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(255,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(256,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(257,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(258,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(259,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(260,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(261,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(262,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);



	AddPlayerClass(1,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(2,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(290,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(291,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(292,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(293,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(294,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(295,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(296,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(297,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(298,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
    AddPlayerClass(299,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);


	AddPlayerClass(47,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(48,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(49,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(50,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(51,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(52,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(53,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(54,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(55,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(56,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(57,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(58,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(59,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(60,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(61,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(62,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(63,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(64,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(66,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(67,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(68,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(69,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(70,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(71,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(72,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(73,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(75,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(76,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(78,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(79,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(80,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(81,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(82,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(83,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(84,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(85,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(87,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(88,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(89,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(91,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(92,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(93,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(95,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(96,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(97,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(98,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(99,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(100,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(101,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(102,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(103,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(104,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(105,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(106,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(107,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(108,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(109,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(110,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(111,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(112,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(113,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(114,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(115,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(116,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(117,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(118,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(120,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(121,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(122,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(123,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(124,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(125,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(126,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(127,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(128,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(129,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(131,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(133,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(134,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(135,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(136,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(137,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(138,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(139,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(140,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(141,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(142,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(143,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(144,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(145,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(146,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(147,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(148,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(150,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(151,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(152,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(153,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(154,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(155,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(156,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(157,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(158,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(159,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(160,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(161,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(162,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(163,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(164,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(165,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(166,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(167,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(168,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(169,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(170,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(171,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(172,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(173,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(174,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(175,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(176,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(177,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(178,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(179,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(180,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(181,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(182,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(183,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(184,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(185,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(186,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(187,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(188,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(189,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(190,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(191,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(192,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(193,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(194,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(195,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(196,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(197,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(198,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(199,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(200,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(201,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(202,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(203,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(204,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(205,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(206,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(207,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(209,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(210,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(211,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(212,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(213,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(214,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(215,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(216,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(217,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(218,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(219,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(220,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(221,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(222,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(223,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(224,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(225,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(226,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(227,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(228,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(229,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(230,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(231,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(232,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(233,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(234,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(235,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(236,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(237,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(238,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(239,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(240,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(241,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(242,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(243,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(244,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(245,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(246,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(247,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(248,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(249,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(250,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(251,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);
	AddPlayerClass(253,1682.0997,1447.2916,10.7724,269.8194,0,0,0,0,0,0);


	 


//Loading vehicles from Scriptfiles
new string[256];
new tmp[256];
for(new count;count<MAX_VEHICLES;count++){
format(string, sizeof(string),"vehicle_%d.sav",count);
	if(dini_Exists(string)){
		new Float:x,Float:y,Float:z,Float:a,model,name;
		tmp = dini_Get(string,"model");
		model = strval(tmp);
		tmp = dini_Get(string,"x");
		x = strval(tmp);
		tmp = dini_Get(string,"y");
		y = strval(tmp);
		tmp = dini_Get(string,"z");
		z = strval(tmp);
		tmp = dini_Get(string,"a");
		a = strval(tmp);
		tmp = dini_Get(string,"name");
		name = strval(tmp);
		CreateVehicle(model,x,y,z,a,-1,-1,300000);
	}
}


 	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
            SetPlayerPos(playerid, -688.0414,938.6726,13.6328);
            SetPlayerCameraPos(playerid, -683.0414,938.6726,13.6328);
	        SetPlayerCameraLookAt(playerid, -688.0414,938.6726,13.6328);


	        return 1;

}



public OnPlayerRequestSpawn(playerid)
{

	return 1;
}

public OnPlayerConnect(playerid)
{

    new pName[MAX_PLAYER_NAME];
    new string[48];
    GetPlayerName(playerid, pName, sizeof(pName));
    format(string, sizeof(string), "%s has joined the server!", pName);
    SendClientMessageToAll(0xAAAAAAAA, string);
    
    if (!udb_Exists(PlayerName(playerid)))
    {
    SendClientMessage(playerid, COLOR_RED, "Welcome to the ProjectRealLife Preview Version");
	SendClientMessage(playerid, COLOR_GREEN, "You will proceed a little tutorial");
	SendClientMessage(playerid,COLOR_ORANGE,"ProjectRealLife Version: Public Preview");
	SetPlayerColor(playerid, COLOR_GREY);
	gTeam[playerid] = TEAM_TUTORIAL;
	return 1;
}
	//time();
	GivePlayerMoney(playerid,1000);
    SendClientMessage(playerid, COLOR_RED, "Welcome to the ProjectRealLife Preview Version");
	SendClientMessage(playerid, COLOR_GREEN, "Please login!");
	SendClientMessage(playerid,COLOR_RED,"If you want to see the commands type /commands");
	SendClientMessage(playerid,COLOR_ORANGE,"ProjectRealLife Version: Public Preview");
	SetPlayerColor(playerid, COLOR_GREY);
	gTeam[playerid] = TEAM_JOBLESS;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{


 if (logged[playerid] == 1) dUserSetINT(PlayerName(playerid)).("money", GetPlayerMoney(playerid));
     new Float:x,Float:y,Float:z;
     GetPlayerPos(playerid,x,y,z);
     dUserSetINT(PlayerName(playerid)).("x",floatround(x));
     dUserSetINT(PlayerName(playerid)).("y",floatround(y));
     dUserSetINT(PlayerName(playerid)).("z",floatround(z));
     GetPlayerHealth(playerid,health);
     dUserSetINT(PlayerName(playerid)).("health",floatround(health));
     GetPlayerArmour(playerid, armour);
     dUserSetINT(PlayerName(playerid)).("armour",floatround(armour));
	logged[playerid] = 0;

    new pName[MAX_PLAYER_NAME];
    new string[56];
    GetPlayerName(playerid, pName, sizeof(pName));

    switch(reason)
    {
        case 0: format(string, sizeof(string), "%s has left the server. (Timeout)", pName);
        case 1: format(string, sizeof(string), "%s has left the server. (Left)", pName);
        case 2: format(string, sizeof(string), "%s has left the server. (Kicked)", pName);
    }

    SendClientMessageToAll(0xAAAAAAAA, string);
    return 1;


}

public OnPlayerSpawn(playerid)
{
	if (logged[playerid] != 1 && udb_Exists(PlayerName(playerid)))
	{
	SendClientMessage(playerid, COLOR_GREEN, "You got kicked! Login next time....");
	Kick(playerid);
		return 1;
}
    if (!udb_Exists(PlayerName(playerid)))
    {
SetPlayerPos(playerid,2838.8821,-2370.4937,31.0078);
SendClientMessage(playerid, COLOR_GREEN, "Welcome to ProjectRealLife");
SendClientMessage(playerid, COLOR_GREY, "We will teach you some things about this script.");
SendClientMessage(playerid, COLOR_GREY, "If you want more information visit our Page: www.mega-host-4you.de");
SendClientMessage(playerid,COLOR_GREY,"Go into the next Checkpoint!");
SetPlayerCheckpoint(playerid, 2830.1892,-2354.3398,22.7987, 1.0);


	return 1;
}

 if (dUserINT(PlayerName(playerid)).("passport")==0) {
SetPlayerWorldBounds(playerid, 2782.829, 2657.336, -2341.135, -2570.104);
  }
  if (dUserINT(PlayerName(playerid)).("x")!=0) {
      SetPlayerPos(playerid,
                   float(dUserINT(PlayerName(playerid)).("x")),
                   float(dUserINT(PlayerName(playerid)).("y")),
                   float(dUserINT(PlayerName(playerid)).("z")));
  }
    if (dUserINT(PlayerName(playerid)).("health")!=0) {
      SetPlayerHealth(playerid,
                   float(dUserINT(PlayerName(playerid)).("health")));
                   }
                    if (dUserINT(PlayerName(playerid)).("armour")!=0) {
      SetPlayerArmour(playerid,
                   float(dUserINT(PlayerName(playerid)).("armour")));
  }


	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	SendDeathMessage(killerid,playerid,reason);
	     new Float:x,Float:y,Float:z;
	     
	     if (logged[playerid] == 1)
     GetPlayerPos(playerid,x,y,z);
     dUserSetINT(PlayerName(playerid)).("x",floatround(x));
     dUserSetINT(PlayerName(playerid)).("y",floatround(y));
     dUserSetINT(PlayerName(playerid)).("z",floatround(z));
     dUserSetINT(PlayerName(playerid)).("health",(100));
     dUserSetINT(PlayerName(playerid)).("armour",(0));
     
     GameTextForPlayer(playerid,"~r~Wasted",2000,2);
     
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{

	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[256];
	new playermoney;
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new cmd[256];
	new giveplayerid, moneys, idx;


	cmd = strtok(cmdtext, idx);
//-------------------------------------------------("Car Seller")-------------------------------------------------

	if(strcmp(cmdtext, "/parken", true)==0  && gTeam[playerid] == TEAM_CARSELLER){
	if(IsPlayerInAnyVehicle(playerid)){
		new Float:x,Float:y,Float:z,Float:a,model,vehicleid;
		vehicleid = GetPlayerVehicleID(playerid);
		GetVehiclePos(vehicleid,x,y,z);
		GetVehicleZAngle(vehicleid,a);
		model = GetVehicleModel(vehicleid);
		SendClientMessage(playerid,0xFFFFFFFF,"Car parked.");
		for(new count;count<MAX_VEHICLES;count++){
		    format(string, sizeof(string),"vehicle_%d.sav",vehicleid);
			if(dini_Exists(string)){
				dini_FloatSet(string,"x",x);
				dini_FloatSet(string,"y",y);
				dini_FloatSet(string,"z",z);
				dini_FloatSet(string,"a",a);
				count = MAX_VEHICLES;
			}
		}
	}else{
	    SendClientMessage(playerid,0xFFFFFFFF,"You must be in a car to use this command.");
	}

	return 1;
}

if(strcmp(cmd, "/buycar", true)==0 && gTeam[playerid] == TEAM_CARSELLER){

new tmp[256];
new modelid;

	 	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "Use: /buycar [modelid]");
			return 1;
		}
		modelid = strval(tmp);

        SendClientMessage(playerid,COLOR_SEAGREEN,"=================================================");
		SendClientMessage(playerid,0xFFFFFFFF,"Car bought.");
		SendClientMessage(playerid,0xFFFFFFFF,"The Mechanic will bring the car now to your job pickup!");
		SendClientMessage(playerid,0xFFFFFFFF,"Please park it when it arrices!!");
		SendClientMessage(playerid,COLOR_SEAGREEN,"=================================================");
		for(new count;count<MAX_VEHICLES;count++){
        format(string, sizeof(string),"vehicle_%d.sav",count);
			if(!dini_Exists(string)){
				dini_Create(string);
				dini_IntSet(string,"model",modelid);
				dini_FloatSet(string,"x",(2778.2478));
				dini_FloatSet(string,"y",(-2437.1582));
				dini_FloatSet(string,"z",(13.3631));
				dini_FloatSet(string,"a",(91.5577));
				count = MAX_VEHICLES;
				CreateVehicle(modelid,2778.2478,-2437.1582,13.3631,91.5577,0,0,300000);

  }
}
	return 1;
}
//-------------------------------------------------("Mechanic")-------------------------------------------------
if(strcmp(cmd, "/tow", true)==0 && gTeam[playerid] == TEAM_MECHANIC){
if(IsPlayerInAnyVehicle(playerid)){
new vehid = GetPlayerVehicleID(playerid);
if(!IsTrailerAttachedToVehicle(vehid)){
    new Float:x, Float:y, Float:z;
    GetVehiclePos(vehid, x, y, z );
new vehiclet;
GetVehicleWithinDistance(playerid, x, y, z, 100.0, vehiclet);
AttachTrailerToVehicle(vehiclet, vehid);
}
else{
DetachTrailerFromVehicle(vehid);
}
}
return 1;
}

//-------------------------------------------------("Police")-------------------------------------------------

	if(strcmp(cmd, "/jail", true) == 0 && gTeam[playerid] == TEAM_POLICE) {
             new tmp[256];
                	tmp = strtok(cmdtext, idx);
                	if(!strlen(tmp)) {
                       SendClientMessage(playerid, COLOR_ORANGE, "Use: /jail [Player ID]");
                        	return 1;
                }
        	giveplayerid = strval(tmp);
        	if(GetDistanceBetweenPlayers(playerid,giveplayerid)<11) {
		if (IsPlayerConnected(giveplayerid))
	{
	SendClientMessage(playerid,COLOR_RED,"You jailed this player!");
	Jail(giveplayerid);
}else{
SendClientMessage(playerid,COLOR_RED,"This player doens´t exists or you can´t jail him");
}
	return 1;
	}
 }

	if(strcmp(cmd, "/unjail", true) == 0 && gTeam[playerid] == TEAM_POLICE) {
             new tmp[256];
                tmp = strtok(cmdtext, idx);
                if(!strlen(tmp)) {
                       SendClientMessage(playerid, COLOR_ORANGE, "Use: /unjail [Player ID]");
                }
        giveplayerid = strval(tmp);
        	if (IsPlayerConnected(giveplayerid))
	if (IsPlayerConnected(giveplayerid))
	{
	SendClientMessage(playerid,COLOR_RED,"You unjailed this player!");
	Unjail(giveplayerid);
	}else{
SendClientMessage(playerid,COLOR_RED,"This player doesn´t exists!");
}
	return 1;
	}

	
if(strcmp(cmd, "/stopnow", true) == 0 && gTeam[playerid] == TEAM_POLICE) {
             new tmp[256];
				tmp = strtok(cmdtext, idx);
                if(!strlen(tmp)) {
                       SendClientMessage(playerid, COLOR_ORANGE, "Use: /stopnow [Player ID]");
				return 1;
                }
        	giveplayerid = strval(tmp);
		if (IsPlayerConnected(giveplayerid))
	{
	SendClientMessage(playerid,COLOR_RED,"You: Police. Stop now!");
	GameTextForPlayer(giveplayerid,"Police. Stop now!",8000,6);
	return 1;
	}
	}


	 if (strcmp(cmd, "/suspendlicense", true)==0 && gTeam[playerid] == TEAM_POLICE )
	{

        new tmp[256];
        new targetplayer,licenseid;
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "Use: /suspendlicense [ID] [0]");
			return 1;
		}
		targetplayer = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "Use: /suspendlicense [ID] [0]");
			return 1;
		}
		licenseid = strval(tmp);


		if(IsPlayerConnected(targetplayer))
		{

	    		nolicense[targetplayer] = licenseid;

				dUserSetINT(PlayerName(targetplayer)).("license",licenseid);
				SendClientMessage(targetplayer, COLOR_WHITE, "Your license got suspended!!");


	    } else {
	        SendClientMessage(playerid,COLOR_RED,"Wrong playerid!");
	    }

		return 1;
	}

/*
 if (strcmp(cmd, "/passport", true)==0 && gTeam[playerid] == TEAM_POLICE )
	{

        new tmp[256];
        new targetplayer,papierid;
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "Use: /passport [ID] [0/1]");
			return 1;
		}
		targetplayer = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "Use: /passport [ID] [0/1]");
			return 1;
		}
		papierid = strval(tmp);


		if(IsPlayerConnected(targetplayer))
		{

	    		passport[targetplayer] = papierid;

				dUserSetINT(PlayerName(targetplayer)).("passport",papierid);
				SendClientMessage(targetplayer, COLOR_WHITE, "You got a passport!");
				SendClientMessage(targetplayer, COLOR_WHITE, "You can now leave the starting area");
				SetPlayerWorldBounds(targetplayer, 9999.999, -9999.9991, 9999.999, -9999.9991);


	    } else {
	        SendClientMessage(playerid,COLOR_RED,"Wrong playerid!");
	    }

		return 1;
	}*/
//-------------------------------------------------("Driving School")-------------------------------------------------



 if (strcmp(cmd, "/license", true)==0 && gTeam[playerid] == TEAM_DSCHOOL )
	{

        new tmp[256];
        new targetplayer,licenseid;
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "Use: /license [ID] [0/1]");
			return 1;
		}
		targetplayer = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "Use: /license [ID] [0/1]");
			return 1;
		}
		licenseid = strval(tmp);


		if(IsPlayerConnected(targetplayer))
		{

	    		license[targetplayer] = licenseid;

				dUserSetINT(PlayerName(targetplayer)).("license",licenseid);
				SendClientMessage(targetplayer, COLOR_WHITE, "You got a driving license!");


	    } else {
	         SendClientMessage(playerid,COLOR_RED,"Wrong playerid!");
	    }

		return 1;
	}
	
	
//-------------------------------------------------("Main Commands")-------------------------------------------------

/*	if(strcmp(cmdtext, "/beginjob", true)==0)
	{

  if (dUserINT(PlayerName(playerid)).("job")==1){
	if(playerCheckpoint[playerid]==CP_POLICE){
	if (logged[playerid] == 1) dUserSetINT(PlayerName(playerid)).("skin", GetPlayerSkin(playerid));
	gTeam[playerid] = TEAM_POLICE;
	SetPlayerColor(playerid, COLOR_GREEN);
	SetPlayerSkin(playerid, 283);
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, 33, 500);
	GivePlayerWeapon(playerid, 3, 500);
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	format(string, 256, "%s is now a police officer!", name);
	SendClientMessageToAll(COLOR_FLBLUE, string);/r
  SendClientMessage(playerid, COLOR_WHITE, "Wrong checkpoint!");
				     	   return 1;
	   }
  	return 1;
}
 if (dUserINT(PlayerName(playerid)).("job")==2){
	if(playerCheckpoint[playerid]==CP_MECHANIC){
if (logged[playerid] == 1) dUserSetINT(PlayerName(playerid)).("skin", GetPlayerSkin(playerid));
	gTeam[playerid] = TEAM_AUTOHAUS;
	SetPlayerColor(playerid, COLOR_LIGHTBLUE);
	SetPlayerSkin(playerid, 187);
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	format(string, 256, "%s is now a mechanic!", name);
	SendClientMessageToAll(COLOR_FLBLUE, string);
	}else{
  SendClientMessage(playerid, COLOR_WHITE, "Wrong checkpoint!");
				     	   return 1;
	   }
  	return 1;
}
 if (dUserINT(PlayerName(playerid)).("job")==3){
	if(playerCheckpoint[playerid]==CP_DSCHOOL){
if (logged[playerid] == 1) dUserSetINT(PlayerName(playerid)).("skin", GetPlayerSkin(playerid));
	gTeam[playerid] = TEAM_DSCHOOL;
	SetPlayerColor(playerid, COLOR_RED);
	SetPlayerSkin(playerid, 147);
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	format(string, 256, "%s is now a driving school teacher!", name);
	SendClientMessageToAll(COLOR_FLBLUE, string);
	}else{
  SendClientMessage(playerid, COLOR_WHITE, "Wrong checkpoint!");
				     	   return 1;
	   }
  	return 1;
}
  	return 1;
}

	if(strcmp(cmdtext, "/endjob", true)==0)
	{

  if (dUserINT(PlayerName(playerid)).("job")==1){
	if(playerCheckpoint[playerid]==CP_POLIZEI){
	SetPlayerSkin(playerid, dUserINT(PlayerName(playerid)).("skin"));
	ResetPlayerWeapons(playerid);
	gTeam[playerid] = TEAM_JOBLESS;
	SetPlayerColor(playerid, COLOR_GREY);
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	format(string, 256, "%s is now a civillian!", name);
	SendClientMessageToAll(COLOR_FLBLUE, string);
	}else{
  SendClientMessage(playerid, COLOR_WHITE, "Wrong checkpoint!");
				     	   return 1;
	   }
  	return 1;
}
 if (dUserINT(PlayerName(playerid)).("job")==2){
	if(playerCheckpoint[playerid]==CP_AUTOHAUS){
SetPlayerSkin(playerid, dUserINT(PlayerName(playerid)).("skin"));
	gTeam[playerid] = TEAM_JOBLESS;
	SetPlayerColor(playerid, COLOR_GREY);
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	format(string, 256, "%s is now a civillian!", name);
	SendClientMessageToAll(COLOR_FLBLUE, string);
	}else{
  SendClientMessage(playerid, COLOR_WHITE, "Wrong checkpoint!");
				     	   return 1;
	   }
  	return 1;
}
 if (dUserINT(PlayerName(playerid)).("job")==3){
	if(playerCheckpoint[playerid]==CP_FAHRSCHULE){
SetPlayerSkin(playerid, dUserINT(PlayerName(playerid)).("skin"));
	gTeam[playerid] = TEAM_JOBLESS;
	SetPlayerColor(playerid, COLOR_GREY);
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	format(string, 256, "%s is now a civillian!", name);
	SendClientMessageToAll(COLOR_FLBLUE, string);
	}else{
  SendClientMessage(playerid, COLOR_WHITE, "Wrong checkpoint!");
				     	   return 1;
	   }
  	return 1;
}
  	return 1;
}
*/

    if (strcmp(cmd, "/job", true)==0)
	{
		if(IsPlayerAdmin(playerid))
		{
        new tmp[256];
        new targetplayer,jobid;
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "Use: /job [ID] [JobID]");
			return 1;
		}
		targetplayer = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "Use: /job [ID] [JobID]");
			return 1;
		}
		jobid = strval(tmp);


		if(IsPlayerConnected(targetplayer))
		{

	    		job[targetplayer] = jobid;

				dUserSetINT(PlayerName(targetplayer)).("job",jobid);

	    		format(tmpstring,sizeof(tmpstring),"%s got a new job: %s",PlayerName(targetplayer),jobs[jobid]);
	    		SendClientMessage(playerid,COLOR_GREEN,tmpstring);
	    		format(tmpstring,sizeof(tmpstring),"You got a new job: %s",jobs[jobid]);
	    		SendClientMessage(targetplayer,COLOR_GREEN,tmpstring);

	    } else {
	        SendClientMessage(playerid,COLOR_RED,"Wrong playerid!");
	    }
		}
		return 1;
	}
//-------------------------------------------------("Money Commands")-------------------------------------------------

	if(strcmp(cmd, "/givecash", true) == 0) {
    new tmp[256];
    tmp = strtok(cmdtext, idx);
    if(!strlen(tmp)) {
    SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givecash [playerid] [amount]");
    return 1; }

    giveplayerid = strval(tmp);
    tmp = strtok(cmdtext, idx);
    if(!strlen(tmp)) {
       SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givecash [playerid] [amount]");
       return 1;
    }
  	new moneys;
  	moneys = strval(tmp);

  	if (IsPlayerConnected(giveplayerid)) {
   GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
   GetPlayerName(playerid, sendername, sizeof(sendername));
   new playermoney = GetPlayerMoney(playerid);
   if (moneys > 0 && playermoney >= moneys) {
     GivePlayerMoney(playerid, (0 - moneys));
     GivePlayerMoney(giveplayerid, moneys);
     format(string, sizeof(string), "You have sent %s(player: %d), $%d.", giveplayer,giveplayerid, moneys);
     SendClientMessage(playerid, COLOR_YELLOW, string);
     format(string, sizeof(string), "You have recieved $%d from %s(player: %d).", moneys, sendername, playerid);
     SendClientMessage(giveplayerid, COLOR_YELLOW, string);
     printf("%s(playerid:%d) has transfered %d to %s(playerid:%d)",sendername, playerid, moneys, giveplayer, giveplayerid);
   } else {
     SendClientMessage(playerid, COLOR_YELLOW, "Invalid transaction amount.");
   }
 	 } else {
     format(string, sizeof(string), "%d is not an active player.", giveplayerid);
     SendClientMessage(playerid, COLOR_YELLOW, string);
  }
  	return 1;
}
//-------------------------------------------------("Need something commands")-------------------------------------------------
  if(strcmp(cmdtext, "/limo", true)==0)
{
    new name[MAX_PLAYER_NAME];
GetPlayerName(playerid, name, MAX_PLAYER_NAME);
format(string, 256, "%s needs a stretch limo!", name);
SendClientMessageToAll(0xFF00FFAA, string);
return 1;
}
  if(strcmp(cmdtext, "/bus", true)==0)
{
    new name[MAX_PLAYER_NAME];
GetPlayerName(playerid, name, MAX_PLAYER_NAME);
format(string, 256, "%s needs a Bus!", name);
SendClientMessageToAll(0xFF00FFAA, string);
return 1;
}
if(strcmp(cmdtext, "/start", true)==0)
{
    new name[MAX_PLAYER_NAME];
GetPlayerName(playerid, name, MAX_PLAYER_NAME);
format(string, 256, "%s needs a start permission!", name);
SendClientMessageToAll(0xFF00FFAA, string);
return 1;
}
if(strcmp(cmdtext, "/land", true)==0)
{
    new name[MAX_PLAYER_NAME];
GetPlayerName(playerid, name, MAX_PLAYER_NAME);
format(string, 256, "%s needs a land permission!", name);
SendClientMessageToAll(0xFF00FFAA, string);
return 1;
}
if(strcmp(cmdtext, "/mayday", true)==0)
{
    new name[MAX_PLAYER_NAME];
GetPlayerName(playerid, name, MAX_PLAYER_NAME);
format(string, 256, "%s have a broken plane! He/She needs a land permission!", name);
SendClientMessageToAll(0xFF00FFAA, string);
return 1;
}
if(strcmp(cmdtext, "/taxi", true)==0)
{
    new name[MAX_PLAYER_NAME];
GetPlayerName(playerid, name, MAX_PLAYER_NAME);
format(string, 256, "%s needs a taxi!", name);
SendClientMessageToAll(0xFF00FFAA, string);
return 1;
}
if(strcmp(cmdtext, "/911", true)==0)
{
    new name[MAX_PLAYER_NAME];
GetPlayerName(playerid, name, MAX_PLAYER_NAME);
format(string, 256, "%s needs police help!", name);
SendClientMessageToAll(0xFF00FFAA, string);
return 1;
}
if(strcmp(cmdtext, "/adminhelp", true)==0)
{
    new name[MAX_PLAYER_NAME];
GetPlayerName(playerid, name, MAX_PLAYER_NAME);
format(string, 256, "%s needs admin help!", name);
SendClientMessageToAll(0xFF00FFAA, string);
return 1;
}
//-------------------------------------------------("DUDB")-------------------------------------------------
if(strcmp(cmdtext, "/newpos", true)==0  && IsPlayerAdmin(playerid)){
	if(IsPlayerInAnyVehicle(playerid)){
		new Float:x,Float:y,Float:z,Float:a,model,vehicleid;
		vehicleid = GetPlayerVehicleID(playerid);
		GetVehiclePos(vehicleid,x,y,z);
		GetVehicleZAngle(vehicleid,a);
		model = GetVehicleModel(vehicleid);
		SendClientMessage(playerid,0xFFFFFFFF,"Spawn position changed.");
		for(new count;count<MAX_VEHICLES;count++){
		    format(string, sizeof(string),"vehicle_%d.sav",vehicleid);
			if(dini_Exists(string)){
				dini_FloatSet(string,"x",x);
				dini_FloatSet(string,"y",y);
				dini_FloatSet(string,"z",z);
				dini_FloatSet(string,"a",a);
				count = MAX_VEHICLES;
			}
		}
	}else{
	    SendClientMessage(playerid,0xFFFFFFFF,"You must be in a car to use this command");
	}

	return 1;
}


	if (strcmp(cmd, "/login", true) == 0)
	{
		if (logged[playerid] != 1 && udb_Exists(PlayerName(playerid)))
		{
			new dir[256];
			dir = strtok(cmdtext, idx);
			if (strlen(dir) && strcmp(dir, dUser(PlayerName(playerid)).("password"), true) == 0)
		{
			logged[playerid] = 1;
			DisplayTextForPlayer(playerid,"~g~logged in!", 5, 1, 2);
			GivePlayerMoney(playerid, dUserINT(PlayerName(playerid)).("money"));
		}
 }

	else{
 DisplayTextForPlayer(playerid,"~r~ERROR", 5, 1, 2);
 }
	return 1;
}

	if (strcmp(cmd, "/register", true) == 0)
	{
	if (logged[playerid] != 1 && !udb_Exists(PlayerName(playerid)) && gTeam[playerid] == TEAM_JOBLESS)
			{
			new dir[256];
			dir = strtok(cmdtext, idx);
			if (strlen(dir))
		{
			new fname[MAX_STRING];
			format(fname,sizeof(fname),"%s.dudb.sav",udb_encode(PlayerName(playerid)));
			dini_Create(fname);
			dUserSet(PlayerName(playerid)).("password", dir);
			//dUserSetINT(PlayerName(playerid)).("passport",(0)); //You must get a passport to play!
			dUserSetINT(PlayerName(playerid)).("passport",(1)); //You get a passport on registering
			SetPlayerPos(playerid,2799.6394,-2436.8999,13.6308);
			//SetPlayerWorldBounds(playerid, 2782.829, 2657.336, -2341.135, -2570.104); //Disable if you don´t want passports
			DisplayTextForPlayer(playerid,"~g~registered", 5, 1, 2);
			GivePlayerMoney(playerid,15000);
		SendClientMessage(playerid,COLOR_GREEN,"You got 15000$");
		}
 }

	else{
 DisplayTextForPlayer(playerid,"~r~ERROR", 5, 1, 2);
 }
	return 1;
}
//-------------------------------------------------("Others")-------------------------------------------------
	if(strcmp(cmdtext, "/kill", true)==0)
	{
	SetPlayerHealth(playerid,0);
	return 1;
}
	
	if(strcmp(cmdtext, "/me", true, 3)==0)
	{
	new str[256], pname[256]; GetPlayerName(playerid, pname, 256);
	format(str, 256, "%s %s", pname, cmdtext[4]);
	SendClientMessageToAll(COLOR_TOMATO, str);
	return 1;
}
	
	if(strcmp(cmdtext, "/afk", true)==0)
	{
    new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	SetPlayerVirtualWorld(playerid, 1);
	format(string, 256, "%s is afk!", name);
	SendClientMessageToAll(0xFF9900AA, string);
	return 1;
}

	if(strcmp(cmdtext, "/back", true)==0)
	{
    new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	SetPlayerVirtualWorld(playerid, 0);
	format(string, 256, "%s is back!", name);
	SendClientMessageToAll(0xFF9900AA, string);
	return 1;
}

 if (strcmp(cmdtext, "/lock", true)==0)
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new State=GetPlayerState(playerid);
				if(State!=PLAYER_STATE_DRIVER)
				{
					SendClientMessage(playerid,COLOR_RED,"You must be the driver of this vehicle to lock it!");
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
				SendClientMessage(playerid, COLOR_GREEN, "***Vehicle locked!");
		    	new Float:pX, Float:pY, Float:pZ;
				GetPlayerPos(playerid,pX,pY,pZ);
				PlayerPlaySound(playerid,1056,pX,pY,pZ);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "You are not in a vehicle!");
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
				SendClientMessage(playerid,COLOR_RED,"You must be the driver of this vehicle to unlock it!");
				return 1;
			}
			new i;
			for(i=0;i<MAX_PLAYERS;i++)
			{
				SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
			}
			SendClientMessage(playerid, COLOR_GREEN, "***Vehicle unlocked!");
			new Float:pX, Float:pY, Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			PlayerPlaySound(playerid,1057,pX,pY,pZ);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "You are not in a vehicle!");
		}
	return 1;
	}
//-------------------------------------------------("Help and Rules and Infos")-------------------------------------------------

	if(strcmp(cmdtext, "/commands", true)==0)
	{
	SendClientMessage(playerid, COLOR_WHITE, "/kill - Kill yourself");
	SendClientMessage(playerid, COLOR_WHITE, "/911 - Call the police");
	SendClientMessage(playerid, COLOR_WHITE, "/adminhelp - Call an admin");
	SendClientMessage(playerid, COLOR_WHITE, "/taxi - Call a taxi");
	SendClientMessage(playerid, COLOR_WHITE, "/limo - Call a strech");
	SendClientMessage(playerid, COLOR_WHITE, "/bus - Call a bus");
	SendClientMessage(playerid, COLOR_WHITE, "/afk - You will be set into the AFK Mode");
    SendClientMessage(playerid, COLOR_WHITE, "/back - You will be back from the AFK Mode");
	SendClientMessage(playerid, COLOR_WHITE, "/commands1 - More commands");
	return 1;
}

	if(strcmp(cmdtext, "/commands1", true)==0)
	{

SendClientMessage(playerid, COLOR_WHITE, "/lock - Lock your car");
SendClientMessage(playerid, COLOR_WHITE, "/unlock - Unlock your car");
SendClientMessage(playerid, COLOR_GREEN, "/jail - Jail someone");
SendClientMessage(playerid, COLOR_GREEN, "/unjail - Unjail someone");
SendClientMessage(playerid, COLOR_GREEN, "/stopnow - Stop someones car");
SendClientMessage(playerid, COLOR_GREEN, "/suspendlicense - Suspend someones driving license");
SendClientMessage(playerid, COLOR_GREEN, "/stopnow - Unlock your car");
SendClientMessage(playerid, COLOR_LIGHTBLUE, "/tow - Unlock your car");
SendClientMessage(playerid, COLOR_WHITE, "/commands2 - More commands");
	return 1;
}
	if(strcmp(cmdtext, "/commands2", true)==0)
	{

SendClientMessage(playerid, COLOR_RED, "/license - Give/Supsend someones driving license");
SendClientMessage(playerid, COLOR_WHITE, "This is just a Preview Version : More commands coming soon!");
	return 1;
}




	return 0;
}

public OnPlayerInfoChange(playerid)
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{

    

	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{

	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
        if((newstate==PLAYER_STATE_DRIVER)&&dUserINT(PlayerName(playerid)).("license")==0)
        {
            SendClientMessage(playerid,0xFF000000,"You want do drive without driving license?.");
                    RemovePlayerFromVehicle(playerid);

        }

	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
if ( pickupid == 0 ){
ShowMenuForPlayer(warehouse, playerid);
TogglePlayerControllable(playerid, 0);
}
if ( pickupid == 1 ){
SetPlayerPos(playerid,1062.2139,2080.0471,10.8203);
}
if ( pickupid == 2 ){
SetPlayerPos(playerid,1062.6241,2071.0715,10.8203);
}
if ( pickupid == 3 ){
 if (dUserINT(PlayerName(playerid)).("job")==1){
 ShowMenuForPlayer(jobmenu, playerid);
 TogglePlayerControllable(playerid, 0);
}
}
if ( pickupid == 4 ){
 if (dUserINT(PlayerName(playerid)).("job")==2){
 ShowMenuForPlayer(jobmenu, playerid);
 TogglePlayerControllable(playerid, 0);
}
}if ( pickupid == 5 ){
 if (dUserINT(PlayerName(playerid)).("job")==3){
 ShowMenuForPlayer(jobmenu, playerid);
 TogglePlayerControllable(playerid, 0);
}
}if ( pickupid == 6 ){
 if (dUserINT(PlayerName(playerid)).("job")==4){
 ShowMenuForPlayer(jobmenu, playerid);
 TogglePlayerControllable(playerid, 0);
}
}
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:current;
    new string[256];
    current = GetPlayerMenu(playerid);
    if(current == warehouse)
    {
        switch(row)
        {
            case 0:{
                SetPlayerArmour(playerid,100);
                GivePlayerMoney(playerid,-200);
                ShowMenuForPlayer(warehouse, playerid);
            }
            case 1:{
                SetPlayerHealth(playerid,100);
                GivePlayerMoney(playerid,-100);
                ShowMenuForPlayer(warehouse, playerid);
            }
            case 2:{
                GivePlayerWeapon(playerid,22,50);
                GivePlayerMoney(playerid,-500);
                ShowMenuForPlayer(warehouse, playerid);
            }
            case 3:{
                SetPlayerArmour(playerid,100);
                SetPlayerHealth(playerid,100);
                GivePlayerWeapon(playerid,22,50);
                GivePlayerMoney(playerid,-700);
                ShowMenuForPlayer(warehouse, playerid);
            }
            case 4:{
                HideMenuForPlayer(warehouse, playerid);
                TogglePlayerControllable(playerid, 1);
            }
        }

    }
     if(current == jobmenu)
    {
        switch(row)
        {
            case 0:{
                  if (dUserINT(PlayerName(playerid)).("job")==1){
	if (logged[playerid] == 1) dUserSetINT(PlayerName(playerid)).("skin", GetPlayerSkin(playerid));
	gTeam[playerid] = TEAM_POLICE;
	SetPlayerColor(playerid, COLOR_GREEN);
	SetPlayerSkin(playerid, 283);
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, 33, 500);
	GivePlayerWeapon(playerid, 3, 500);
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	format(string, 256, "%s is now a police officer!", name);
	SendClientMessageToAll(COLOR_FLBLUE, string);
		 ShowMenuForPlayer(jobmenu, playerid);

  	return 1;
}
 if (dUserINT(PlayerName(playerid)).("job")==2){
if (logged[playerid] == 1) dUserSetINT(PlayerName(playerid)).("skin", GetPlayerSkin(playerid));
	gTeam[playerid] = TEAM_MECHANIC;
	SetPlayerColor(playerid, COLOR_LIGHTBLUE);
	SetPlayerSkin(playerid, 187);
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	format(string, 256, "%s is now a mechanic!", name);
	SendClientMessageToAll(COLOR_FLBLUE, string);
		 ShowMenuForPlayer(jobmenu, playerid);

  	return 1;
}
 if (dUserINT(PlayerName(playerid)).("job")==3){
if (logged[playerid] == 1) dUserSetINT(PlayerName(playerid)).("skin", GetPlayerSkin(playerid));
	gTeam[playerid] = TEAM_DSCHOOL;
	SetPlayerColor(playerid, COLOR_RED);
	SetPlayerSkin(playerid, 147);
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	format(string, 256, "%s is now a driving school teacher!", name);
	SendClientMessageToAll(COLOR_FLBLUE, string);
		 ShowMenuForPlayer(jobmenu, playerid);
  	return 1;
}
 if (dUserINT(PlayerName(playerid)).("job")==4){
if (logged[playerid] == 1) dUserSetINT(PlayerName(playerid)).("skin", GetPlayerSkin(playerid));
	gTeam[playerid] = TEAM_CARSELLER;
	SetPlayerColor(playerid, COLOR_PINK);
	SetPlayerSkin(playerid, 187);
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	format(string, 256, "%s is now a car seller!", name);
	SendClientMessageToAll(COLOR_FLBLUE, string);
	 ShowMenuForPlayer(jobmenu, playerid);
  	return 1;
}

            }
            case 1:{
  if (dUserINT(PlayerName(playerid)).("job")==1){
	SetPlayerSkin(playerid, dUserINT(PlayerName(playerid)).("skin"));
	ResetPlayerWeapons(playerid);
	gTeam[playerid] = TEAM_JOBLESS;
	SetPlayerColor(playerid, COLOR_GREY);
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	format(string, 256, "%s is now a civillian!", name);
	SendClientMessageToAll(COLOR_FLBLUE, string);
		 ShowMenuForPlayer(jobmenu, playerid);
  	return 1;
}
 if (dUserINT(PlayerName(playerid)).("job")==2){
SetPlayerSkin(playerid, dUserINT(PlayerName(playerid)).("skin"));
	gTeam[playerid] = TEAM_JOBLESS;
	SetPlayerColor(playerid, COLOR_GREY);
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	format(string, 256, "%s is now a civillian!", name);
	SendClientMessageToAll(COLOR_FLBLUE, string);
		 ShowMenuForPlayer(jobmenu, playerid);
  	return 1;
}
 if (dUserINT(PlayerName(playerid)).("job")==3){

SetPlayerSkin(playerid, dUserINT(PlayerName(playerid)).("skin"));
	gTeam[playerid] = TEAM_JOBLESS;
	SetPlayerColor(playerid, COLOR_GREY);
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	format(string, 256, "%s is now a civillian!", name);
	SendClientMessageToAll(COLOR_FLBLUE, string);
		 ShowMenuForPlayer(jobmenu, playerid);
    return 1;
}
 if (dUserINT(PlayerName(playerid)).("job")==4){

SetPlayerSkin(playerid, dUserINT(PlayerName(playerid)).("skin"));
	gTeam[playerid] = TEAM_JOBLESS;
	SetPlayerColor(playerid, COLOR_GREY);
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	format(string, 256, "%s is now a civillian!", name);
	SendClientMessageToAll(COLOR_FLBLUE, string);
		 ShowMenuForPlayer(jobmenu, playerid);
    return 1;
}

            }
            case 2:{
                HideMenuForPlayer(jobmenu, playerid);
                TogglePlayerControllable(playerid, 1);
            }
        }
}
    return 1;
}


public OnPlayerExitedMenu(playerid)
{
 if(warehouse)
    {
ShowMenuForPlayer(warehouse, playerid);
    }
     if(jobmenu)
    {
ShowMenuForPlayer(jobmenu, playerid);
    }
	return 1;
}



public checkit()
{
	for(new i=0;i<GetMaxPlayers();i++)
	{
		if(IsPlayerConnected(i))
		{
			SetPlayerScore(i,GetPlayerMoney(i));
		}
	}
}



stock PlayerName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	return name;
}

//Check point type function
public getCheckpointType(playerID) {
return checkpointType[playerCheckpoint[playerID]];
}

//IsPlayerInArea function
public isPlayerInArea(playerID, Float:data[4])
{
new Float:X, Float:Y, Float:Z;
GetPlayerPos(playerID, X, Y, Z);
if(X >= data[0] && X <= data[2] && Y >= data[1] && Y <= data[3])
{
return 1;
}
return 0;
}

//Update the players checkpoint function
public checkpointUpdate()
{
for(new i=0; i<MAX_PLAYERS; i++)
{
 if(IsPlayerConnected(i))
  {
  for(new j=0; j < MAX_POINTS; j++)
  {
  if(isPlayerInArea(i, checkCoords[j]))
   {
   if(playerCheckpoint[i]!=j)
    {
    DisablePlayerCheckpoint(i);
    SetPlayerCheckpoint(i, checkpoints[j][0],checkpoints[j][1],checkpoints[j][2],checkpoints[j][3]);
    playerCheckpoint[i] = j;
    }
   }
   else
   {
   if(playerCheckpoint[i]==j)
    {
    DisablePlayerCheckpoint(i);
    playerCheckpoint[i] = 999;
    }
   }
  }
  }
}
}

//Fuel check function
public CheckFuel(playerid)
{
new Ptmess[32];
for(new i=0;i<MAX_PLAYERS;i++)
 {
  if(IsPlayerConnected(i) == 1 && IsPlayerInAnyVehicle(i) == 1)
   {
   if(GetPlayerState(i) == 2)
    {
	 new Vi;
     Vi = GetPlayerVehicleID(i);
     Petrol[Vi]--;

     if(Petrol[Vi] >= 1)
      {
      format(Ptmess, sizeof(Ptmess), "~w~Petrol ->~r~%d", Petrol[Vi]);
      DisplayTextForPlayer(i, Ptmess, 5, 2, 3);
      }
      else
      {
      RemovePlayerFromVehicle(i);
      DisplayTextForPlayer(i,"~r~You run out of fuel! Call a Mechanic", 5, 1, 2);
      if(Petrol[Vi] < 0)
	   {
	   Petrol[Vi] = 0;
	   }
      }


	 }
    }
 }
}

//Refill fuel function
public FuelRefill(playerid)
{
new VID;
VID = GetPlayerVehicleID(playerid);
if(Petrol[VID] < AMOUNT)
 {
 new FillUp;
 FillUp = AMOUNT - Petrol[VID];
 if(GetPlayerMoney(playerid) >= FillUp)
  {
  Petrol[VID] +=FillUp;
  new mess[64];
  format(mess, sizeof(mess), "Car sucessfully refilled! (Refilled: %d )", FillUp);
  SendClientMessage(playerid, COLOR_WHITE, mess);
  GivePlayerMoney(playerid, -FillUp);
  return 1;
  }
  else
  {
  SendClientMessage(playerid, COLOR_RED, "You don´t got enough money to refill your car!!");
  return 1;
  }
 }
 else
 {
 SendClientMessage(playerid, COLOR_RED, "Your car is allready full! You don´t need to refill it!");
 return 1;
 }
return 1;
}


public OnPlayerEnterCheckpoint(playerid)
{
	printf("OnPlayerEnterCheckpoint(%d)", playerid);

	   //	if(playerCheckpoint[playerid] == CP_STATION1)
	   		if(playerCheckpoint[playerid]>=CP_STATION1 && playerCheckpoint[playerid]<=CP_STATION16)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	   {
       DisplayTextForPlayer(playerid,"~b~Car refilled", 5, 1, 2);
       FuelRefill(playerid);
	   }
	   else
	   {
	   SendClientMessage(playerid, COLOR_RED, "Yummy. You like fuel in your mouth right? <.<");
	   }
	   return 1;
	   }
	/*   		if(playerCheckpoint[playerid] == CP_POLICE)
	{
	   SendClientMessage(playerid, COLOR_GREEN, "------------Police------------");
       SendClientMessage(playerid, COLOR_YELLOW, "Commands: /beginjob, /endjob");
       SendClientMessage(playerid, COLOR_GREEN, "------------Police------------");

	   return 1;
	   }
	   	   		if(playerCheckpoint[playerid] == CP_MECHANIC)
	{
	   SendClientMessage(playerid, COLOR_GREEN, "------------MECHANIC------------");
       SendClientMessage(playerid, COLOR_YELLOW, "Commands: /beginjob, /endjob");
       SendClientMessage(playerid, COLOR_GREEN, "------------Autohaus------------");

	   return 1;
	   }
	   	   		if(playerCheckpoint[playerid] == CP_DSCHOOL)
	{
	   SendClientMessage(playerid, COLOR_GREEN, "------------DSCHOOL------------");
       SendClientMessage(playerid, COLOR_YELLOW, "Commands: /beginjob, /endjob");
       SendClientMessage(playerid, COLOR_GREEN, "------------DSCHOOL------------");

	   return 1;
	   }*/
	   	   	   		if(gTeam[playerid] == TEAM_TUTORIAL)
	{
                    DisablePlayerCheckpoint(playerid);
                    		SendClientMessage(playerid,COLOR_GREEN,"Jobs:");
		SendClientMessage(playerid,COLOR_GREY,"You must do jobs to earn money.");
		SendClientMessage(playerid,COLOR_GREY,"The current jobs are:");
		SendClientMessage(playerid,COLOR_GREY,"Police Officer, Mechanic and Driving Teacher.");
		SendClientMessage(playerid,COLOR_GREY,"Please go into the next checkpoint!");
		SetPlayerCheckpoint(playerid, 2837.9045,-2341.5154,19.2058, 1.0);
        gTeam[playerid] = TEAM_TUTORIAL2;
	   return 1;
	   }
	   	   	   	   		if(gTeam[playerid] == TEAM_TUTORIAL2)
	{
                    DisablePlayerCheckpoint(playerid);
        SendClientMessage(playerid,COLOR_GREEN,"Street Rules:");
		SendClientMessage(playerid,COLOR_GREY,"You can´t drive vehicles without a driving license.");
		SendClientMessage(playerid,COLOR_GREY,"You can get one at the Driving School.");
		SendClientMessage(playerid,COLOR_GREY,"The street rules are the same like in Real Life");
		SendClientMessage(playerid,COLOR_GREY,"Plase go into the next checkpoint!");
		SetPlayerCheckpoint(playerid, 2836.8694,-2335.9983,12.0470, 1.0);
		gTeam[playerid] = TEAM_TUTORIAL3;

	   return 1;
	   }
	   	   	   	   	   		if(gTeam[playerid] == TEAM_TUTORIAL3)
	{
                    DisablePlayerCheckpoint(playerid);
		SendClientMessage(playerid,COLOR_GREEN,"Waffen:");
		SendClientMessage(playerid,COLOR_GREY,"You are allowed to have weapons if you have a weapon license.");
		SendClientMessage(playerid,COLOR_RED,"The license isn´t in the script right now! Just RP it until it is in the script");
		SendClientMessage(playerid,COLOR_GREY,"You can do everything with your weapons but remember.");
		SendClientMessage(playerid,COLOR_GREY,"This is no DM Server.");
		SendClientMessage(playerid,COLOR_GREY,"Plase go into the next checkpoint!");
		SetPlayerCheckpoint(playerid, 2836.8428,-2377.6096,12.0747, 1.0);
		gTeam[playerid] = TEAM_TUTORIAL4;

	   return 1;
	   }
	     	   	   	   	   		if(gTeam[playerid] == TEAM_TUTORIAL4)
	{
                    DisablePlayerCheckpoint(playerid);
		SendClientMessage(playerid,COLOR_GREEN,"Last information:");
		SendClientMessage(playerid,COLOR_GREY,"Respect other Players!!");
		SendClientMessage(playerid,COLOR_GREY,"If you want to see all commands type: /commands");
		SendClientMessage(playerid,COLOR_YELLOW,"You can now register yourself with /register.");
		SendClientMessage(playerid,COLOR_YELLOW,"Warning: The admins can see your password!.");
		gTeam[playerid] = TEAM_JOBLESS;

	   return 1;
	   }
	  return 1;
}


public UpdateSpeed(){
new Float:x,Float:y,Float:z;
new Float:distance,value,string[256];
for(new i=0; i<SLOTS; i++){
if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i)){
GetPlayerPos(i, x, y, z);
distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
value = floatround(distance * 2500);
if(UpdateSeconds > 1){
value = floatround(value / UpdateSeconds);
}
if(SpeedMode){
format(string,sizeof(string),"~r~%d MPH",floatround(value/1600));
GameTextForPlayer(i, string, 1100, 5);
}
else{
format(string,sizeof(string),"~n~~w~KM/H ->~r~%d",floatround(value/1000));
DisplayTextForPlayer(i, string, 1, 2,3);
      //DisplayTextForPlayer(i, Ptmess, 8, 2, 3);
}
SavePlayerPos[i][LastX] = x;
SavePlayerPos[i][LastY] = y;
SavePlayerPos[i][LastZ] = z;
}
}
}

stock Jail(jailid)
{
SetPlayerInterior(jailid,10);
SetPlayerPos(jailid,223.2217,111.1841,999.0156);
}

stock Unjail(unjailid)
{
SetPlayerInterior(unjailid,0);
SetPlayerPos(unjailid,2287.1262,2429.4392,10.8203);
}

// Tow Function
GetVehicleWithinDistance( playerid, Float:x1, Float:y1, Float:z1, Float:dist, &vehic){
for(new i = 1; i < MAX_VEHICLES; i++){
if(GetVehicleModel(i) > 0){
if(GetPlayerVehicleID(playerid) != i ){
        new Float:x, Float:y, Float:z;
        new Float:x2, Float:y2, Float:z2;
GetVehiclePos(i, x, y, z);
x2 = x1 - x; y2 = y1 - y; z2 = z1 - z;
new Float:iDist = (x2*x2+y2*y2+z2*z2);
printf("Vehicle %d is %f", i, iDist);

if( iDist < dist){
vehic = i;
}
}
}
}
}

public PayDay()
{
for (new i; i < MAX_PLAYERS; i++)
{
if (IsPlayerConnected(i))
{
GivePlayerMoney(i,5000);
SendClientMessage(i,COLOR_GREEN,"--PayDay--5000$--");
}
}
}
