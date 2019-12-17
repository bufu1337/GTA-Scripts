#include <a_samp>
#include <core>
#include <float>

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_ORANGE 0xFF9900AA

#define PocketMoney 1000  // Amount player recieves on spawn.
#define INACTIVE_PLAYER_ID 255
#define GIVECASH_DELAY 5000 // Time in ms between /givecash commands.

#define CP_BANK         0
#define CP_PIRATE       1
#define CP_AMMU         2
#define CP_WANGEXPORTS  3
#define CP_HEAVENS      4
#define CP_HELL		5
#define CP_DRAGON       6
#define CP_CALIGULA     7
#define CP_SEXSHOP      8
#define CP_BAR          9
#define CP_ZIP         10
#define CP_BINCO       11
#define CP_TATOO       12
#define CP_BOTIQUE     13
#define CP_STRIPCLUB   14
#define CP_WANGCARS    15
#define CP_AIRSTRIP    16
#define CP_EMERALD     17
#define CP_VISAGE      18
#define CP_SPREADRANCH 19

#define P_DRAGON        0
#define P_CALIGULA      1
#define P_SEXSHOP       2
#define P_BAR           3
#define P_ZIP           4
#define P_BINCO         5
#define P_TATOO         6
#define P_BOTIQUE       7
#define P_STRIPCLUB     8
#define P_WANGCARS      9
#define P_AIRSTRIP     10
#define P_EMERALD      11
#define P_VISAGE       12
#define P_SPREADRANCH  13

#define P_OFFSET    6

forward MoneyGrubScoreUpdate();
forward Givecashdelaytimer(playerid);
//forward GrubModeReset();
forward SetPlayerRandomSpawn(playerid);
forward SetupPlayerForClassSelection(playerid);
forward GameModeExitFunc();

//------------------------------------------------------------------------------------------------------

new CashScoreOld;
new iPlayerRole[MAX_PLAYERS];
new bank[MAX_PLAYERS];
new bounty[MAX_PLAYERS];
new playerCheckpoint[MAX_PLAYERS];
new dmWarning[MAX_PLAYERS];
new savePos;
new worldTime;
new vehicleModel[254];

new playerColors[100] = {
0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,0xEE82EEFF,0xFFD720FF,
0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,
0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,
0x275222FF,0xF09F5BFF,0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,
0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,0x4B8987FF,
0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,0x48C000FF,0x2A51E2FF,0xE3AC12FF,
0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,
0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,
0x9F945CFF,0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,
0x3FE65CFF
};

new Float:gRandomPlayerSpawns[14][3] = {
{2001.6309,1914.6458,40.3516},
{2208.8589,1839.1924,10.8203},
{1970.2393,1622.4781,12.8669},
{2232.3596,1285.6245,10.6719},
{2486.1292,1413.6133,12.3983},
{2578.0166,1663.4172,10.8203},
{2602.7380,2183.7473,14.1161},
{2627.3213,2348.1069,10.8203},
{986.2977,1880.0288,11.4683},
{1502.4791,2026.9261,14.7396},
{1607.5032,1816.2596,10.8203},
{1645.9166,1614.2948,14.8222},
{1958.6238,694.7397,14.2681},
{1491.2498,2773.8394,15.9924}
};

new Float:gCopPlayerSpawns[3][3] = {
{2297.1064,2452.0115,10.8203},
{2297.0452,2468.6743,10.8203},
{2268.0566,2449.2874,3.5313}
};

#define MAX_POINTS 20

new Float:checkCoords[MAX_POINTS][4] = {
{-36.5483,-57.9948, -17.2655,-49.2967},     //BANK
{1894.6128,1445.3431, 2084.9739,1637.8186}, //PIRATE
{284.0546,-86.4384, 302.9315,-56.6674},     //AMMUNATION
{-1924.2008,245.8384,-1897.0090,310.0460},  //WANG EXPORTS
{2301.1162,1260.2860,2346.1741,1305.4763},  //HEAVENS SKYDIVE
{-2549.7979,-1660.4034,-2339.2673,-1589.3324},  //HELL FALL
{1925.1511,968.2358, 2019.0715,1067.4276},  //DRAGON
{2216.7971,1638.0493, 2255.2097,1714.0806}, //CALIGULA
{-115.9544,-24.2706, -99.1631,-7.1391},     //SEXSHOP
{487.6558,-88.5900, 512.0635, -67.7503},    //BAR
{144.9131,-96.0927, 177.4128,-70.7923},     //ZIP
{201.4462,-112.4556, 218.5237,-95.1238},    //BINCO
{-204.7623,-44.0326, -200.2330,-39.8128},   //TATOO
{416.7485,-84.4242, 422.6890,-74.0611},     //BOTIQUE
{1201.1422,-16.6343,1223.4420,12.6656},     //STRIPCLUB
{-1996.0801,253.4684,-1942.0564,310.0717},  //WANG CARS
{413.4203,2534.9907,421.4078,2542.7031},    //VERDANT MEADOWS AIR STRIP
{2099.1985,2328.5200,2179.1382,2405.8721},  //EMERALD ISLE
{1998.3783,1875.9679,2066.3425,1957.0034},  //THE VISAGE
{1205.7026,-41.1453,1216.8755,-23.9896}     //THE BIG SPREAD RANCH
};

new Float:checkpoints[MAX_POINTS][3] = {
{-22.2549,-55.6575,1003.5469},
{2000.3132,1538.6012,13.5859},
{291.0004,-84.5168,1001.5156},
{-1920.6711,303.1555,41.0469},
{2323.7454,1283.1440,97.5579},
{-2432.6628,-1620.0771,526.8676},
{1989.0619,1005.5241,994.4688}, 
{2235.5408,1679.0402,1008.3594},
{-103.5525,-22.4661,1000.7188},
{501.4927,-75.4323,998.7578},
{161.1875,-79.9915,1001.8047},
{207.5640,-97.8188,1005.2578},
{-203.4864,-41.2045,1002.2734},
{418.5547,-80.1667,1001.8047},
{1212.3918,-10.9459,1000.9219},
{-1957.5327,300.2131,35.4688},
{418.1210,2536.8762,10.0000},
{2127.5940,2370.4255,10.8203},
{2022.5179,1916.6848,12.3397},
{1208.5027,-32.6044,1000.9531}
};

new checkpointType[MAX_POINTS] = {
	CP_BANK,
	CP_PIRATE,
	CP_AMMU,
	CP_WANGEXPORTS,
	CP_HEAVENS,
	CP_HELL,
	CP_DRAGON,
	CP_CALIGULA,
	CP_SEXSHOP,
	CP_BAR,
	CP_ZIP,
	CP_BINCO,
	CP_TATOO,
	CP_BOTIQUE,
	CP_STRIPCLUB,
	CP_WANGCARS,
	CP_AIRSTRIP,
	CP_EMERALD,
	CP_VISAGE,
	CP_SPREADRANCH	
};

#define MAX_PROPERTIES	14

new propertyNames[MAX_PROPERTIES][32] = {
	"Four Dragons",
	"Caligula",
	"Sex Shop",
	"Shithole Bar",
	"Zip Shop",
	"Binco Shop",
	"Tatoo Parlor",
	"Botique",
	"Strip Club",
	"Wang Cars",
	"Verdant Meadows Air Strip",
	"Emerald Isle",
	"The Visage",
	"The Big Spread Ranch"
};

new propertyValues[MAX_PROPERTIES] = {
	75000,
	100000,
	25000,
	20000,
	15000,
	15000,
	10000,
	20000,
	30000,
	20000,
	25000,
	60000,
	110000,
	25000
};

new propertyEarnings[MAX_PROPERTIES] = {
	5000,
	7000,
	2000,
	1500,
	1000,
	1000,
	700,
	1500,
	2500,
	1500,
	2000,
	6000,
	8000,
	2000
};

new propertyOwner[MAX_PROPERTIES] = {999,999,999,999,999,999,999,999,999,999,999,999,999,999};

#define MAX_WEAPONS 47
#define MAX_SPAWNWEAPONS 9
new weaponNames[MAX_WEAPONS][32] = {
	"Unarmed",
	"Brass Knuckles", //crash game
	"Golf Club",
	"Night Stick",
	"Knife",
	"Baseball Bat",
	"Shovel",
	"Pool Cue",
	"Katana",
	"Chainsaw",
	"Purple Dildo",
	"White Dildo",
	"Long White Dildo",
	"White Dildo 2",
	"Flowers",
	"Cane",
	"Grenades", //crash game
	"Tear Gas", //crash game
	"Molotovs", //crash game
	"UNKNOWN",
	"UNKNOWN",
	"UNKNOWN",
	"Pistol",
	"Silenced Pistol",
	"Desert Eagle",
	"Shotgun",
	"Sawn Off Shotgun",
	"Combat Shotgun",
	"Micro Uzi (Mac 10)",
	"MP5",
	"AK47",
	"M4",
	"Tec9",
	"Rifle",
	"Sniper Rifle",
	"RPG",
	"Missile Launcher",
	"Flame Thrower",
	"Minigun",
	"Sachel Charges", //crash game
	"Detonator", //crash game
	"Spray Paint",
	"Fire Extinguisher",
	"Camera",
	"Nightvision Goggles", //crash game
	"Thermal Goggles", //crash game
	"Parachute"
};

new spawnWeapons[MAX_SPAWNWEAPONS][3] = {
	{23,34,4000},
	{25,15,7000},
	{27,20,15000},
	{28,120,7000},
	{32,120,5000},
	{29,120,15000},
	{30,120,25000},
	{31,120,30000},
	{9,0,70000}
};

new playerWeapons[MAX_PLAYERS][MAX_SPAWNWEAPONS];

//---> Pit Boss
#define MAX_GAMBLINGFEE   10000
#define MIN_GAMBLINGFEE       1
#define MAX_CASINO            2
new casinoVehicles[MAX_CASINO][2] = {
	{1,2},
	{3,4}
};
new gamblingFee[MAX_CASINO] = {
	300,
	300
};
new Float:gambleAreas[MAX_CASINO][4] = {
	{2040.0,2055.0, 1300.0,1400.0}, //Four Dragons
	{2171.3618,1584.2649, 2279.4915,1628.6199} //Caligula's
};
new pbGameText = 1;

//---> WANG EXPORT VEHICLES
#define MAX_WANGEXPORTVEHICLES	15		// Maximum Wang Export vehicles
new wantedWangExportVehicle;			// Wanted Wang Export vehicle model id
new wantedWangExportVehicles[MAX_WANGEXPORTVEHICLES] = {				// Wanted Wang Exports modelid's
	400,
	411,
	434,
	451,
	461,
	463,
	468,
	470,
	480,
	482,
	495,
	535,
	541,
	567,
	603
};
new wantedWangExportVehicleNames[MAX_WANGEXPORTVEHICLES][32] = {		// Wanted Wang Exports vehicle names (match modelid's)
	"Landstalker",
	"Infernus",
	"Hotknife",
	"Turismo",
	"PCJ-600",
	"Freeway",
	"Sanchez",
	"Patriot",
	"Comet",
	"Burrito",
	"Sandking",
	"Slamvan",
	"Bullet",
	"Savanna",
	"Phoenix"
};

//---> Gang DM
#define MAX_DMZONES 		9		// Maximum gang deathmatch zones
new Float:dmCoords[MAX_DMZONES][4] = {		// dm coordinates
	{-1940.5177,-1794.1295,-1658.0635,-1535.5846},
	{2336.2014,-1724.6854,2542.1138,-1625.6139},
	{1153.1282,197.6021,1531.6736,435.2268},
	{2496.7122,2616.0457,2749.8606,2858.5027},
	{-939.4901,1384.7155,-707.3583,1636.4291},
	{2374.1794,-2696.3215,2810.3977,-2330.2258},
	{-1679.7235,2459.0403,-1274.9779,2756.8276},
	{-1470.3805,486.9461,-1243.6833,520.1677},
	{-2851.9526,-1818.3044,-2642.0146,-1270.1024}
};
new Float:dmSpawnCoords[MAX_DMZONES][6] = {	// dm spawn coordinates [spawn1x,spawn1y,spawn1z,spawn2x,spawn2y,spawn2z]
	{-1860.3270,-1555.7944,27.7882,-1852.2899,-1709.3114,23.2031},
	{2350.9478,-1633.9509,16.3725,2517.8013,-1721.8979,18.5821},
	{1447.7856,362.7201,18.9239,1247.3853,204.2742,23.0547},
	{2511.5542,2850.3467,14.8222,2599.9905,2679.6770,14.2559},
	{-938.8171,1427.7638,30.4340,-734.1335,1546.4265,39.0080},
	{2790.4875,-2378.6331,16.2244,2414.8733,-2651.1584,17.9107},
	{-1308.0055,2544.7805,87.7422,-1665.8292,2551.0815,88.3455},
	{-1462.5336,489.2468,3.0414,-1358.9319,497.6422,24.2969},
	{-2798.1133,-1360.4624,132.4197,-2816.5259,-1652.0499,141.5092}
};
new dmGangs[MAX_DMZONES][2] = {		// dm gangs (2 per zone)
	{0,0},
	{0,0},
	{0,0},
	{0,0},
	{0,0},
	{0,0},
	{0,0},
	{0,0},
	{0,0}
};
new dmNames[MAX_DMZONES][32] = {	// dm zone names
	"Whetstone",
	"Grove Street",
	"Montgomery",
	"K.A.C.C. Military Fuels",
	"Las Barrancas",
	"Ocean Docks",
	"El Quebrados",
	"Easter Basin",
	"Mount Chiliad"
};
new dmWeapons[MAX_DMZONES][2] = {	// dm weapons [weaponid,ammo]
	{6,0},
	{32,1500},
	{30,1500},
	{38,5000},
	{24,120},
	{27,120},
	{22,240},
	{23,170},
	{24,120}
};
new dmPlayers[MAX_PLAYERS];

#define MAX_SAVE 64
new savedInfo[MAX_SAVE][4];
new savedNames[MAX_SAVE][MAX_PLAYER_NAME];
new savedWeapons[MAX_SAVE][MAX_SPAWNWEAPONS];

#define MAX_GANGS 			32
#define MAX_GANG_MEMBERS	12
#define MAX_GANG_NAME       16
new gangMembers[MAX_GANGS][MAX_GANG_MEMBERS];
new gangNames[MAX_GANGS][MAX_GANG_NAME];
new gangInfo[MAX_GANGS][3]; //0-created,1-members,2-color
new gangBank[MAX_GANGS];
new playerGang[MAX_PLAYERS];
new gangInvite[MAX_PLAYERS];

//Round code stolen from mike's Manhunt :P
//new gRoundTime = 3600000;                   // Round time - 1 hour
//new gRoundTime = 1200000;					// Round time - 20 mins
//new gRoundTime = 900000;					// Round time - 15 mins
//new gRoundTime = 600000;					// Round time - 10 mins
//new gRoundTime = 300000;					// Round time - 5 mins
//new gRoundTime = 120000;					// Round time - 2 mins
//new gRoundTime = 60000;					// Round time - 1 min

new gActivePlayers[MAX_PLAYERS];
new gLastGaveCash[MAX_PLAYERS];

//------------------------------------------------------------------------------------------------------

main()
{
		print("\n--------------------------------------------------------------");
		print("  Running LVDM ~MoneyGrub(+LandGrab) +PitBoss+GangDM");
		print("--------------------------------------------------------------");
		print("  Coded By Jax (+Sintax) [LVDM ~MoneyGrub(+LandGrab)]");
		print("  Coded By Betamaster [+PitBoss+GangDM]");
		print("--------------------------------------------------------------\n");
		worldTime = 13;
}

//------------------------------------------------------------------------------------------------------

public PlayerLeaveGang(playerid) {
	new string[256];
	new playername[MAX_PLAYER_NAME];
	new gangnum = playerGang[playerid];

    if(gangnum > 0) {
		for(new i = 0; i < gangInfo[gangnum][1]; i++) {
			if(gangMembers[gangnum][i]==playerid) {

			    //One less gang member
			    gangInfo[gangnum][1]--;

      		    for(new j = i; j < gangInfo[gangnum][1]; j++) {
				    //Shift gang members
				    gangMembers[gangnum][j]=gangMembers[gangnum][j+1];
	    		}

			    //Disband gang if no more members
			    if(gangInfo[gangnum][1]<1) {
			        gangInfo[gangnum][0]=0;
			        gangInfo[gangnum][1]=0;
			        gangBank[gangnum]=0;
       			}

				//Notify other members
				for(new j = 0; j < gangInfo[gangnum][1]; j++) {
				    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
					format(string, sizeof(string),"%s has quit your gang.", playername);
					SendClientMessage(gangMembers[gangnum][j], COLOR_ORANGE, string);
					if(j==0) {
						AutoLockCasinoVehicles(gangMembers[gangnum][j]);
					}
				}
				
				format(string, sizeof(string),"You have quit the gang '%s' (id: %d)", gangNames[gangnum], gangnum);
				SendClientMessage(playerid, COLOR_ORANGE, string);

				playerGang[playerid]=0;
				
				SetPlayerColor(playerid,playerColors[playerid]);

				return;
			}
		}
	} else {
		SendClientMessage(playerid, COLOR_RED, "You are not in a gang.");
	}
}

public getCheckpointType(playerID) {
	return checkpointType[playerCheckpoint[playerID]];
}

public isPlayerInArea(playerID, Float:data[4])
{
	new Float:X, Float:Y, Float:Z;

	GetPlayerPos(playerID, X, Y, Z);
	if(X >= data[0] && X <= data[1] && Y >= data[2] && Y <= data[3]) {
		return 1;
	}
	return 0;
}

public PayPlayerInArea(playerID, Float:x1, Float:y1, Float:x2, Float:y2, cash)
{

	if(IsPlayerConnected(playerID))
	{
		new Float:X, Float:Y, Float:Z;

		GetPlayerPos(playerID, X, Y, Z);
		if(X >= x1 && X <= x2 && Y >= y1 && Y <= y2)
		{
			GivePlayerMoney(playerID, cash);
			return 1;
		}
	}
	return 0;
}
//------------------------------------------------------------------------------------------------------

public TimeUpdate() {
	worldTime++;
	worldTime%=24;
	SetWorldTime(worldTime);
	if(worldTime==6 || worldTime==12 || worldTime==18) {
		new string[256];
		new n = random(MAX_WANGEXPORTVEHICLES);
		format(string, sizeof(string),"*** Wang Exports are currently buying %s's ***", wantedWangExportVehicleNames[n]);
		SendClientMessageToAll(COLOR_YELLOW, string);
		wantedWangExportVehicle = wantedWangExportVehicles[n];
	}
}

//------------------------------------------------------------------------------------------------------

public UnlockVehicleUpdate() {
	new i,j;
	new vehicleDriver = 0;
	for(i=MAX_CASINO*2+1;i<=sizeof(vehicleModel);i++) {
		for(j=0;j<MAX_PLAYERS;j++) {
			if(IsPlayerConnected(j)) {
				if(IsPlayerInVehicle(j,i)) {
					if(GetPlayerState(j)==PLAYER_STATE_DRIVER) {
						vehicleDriver = 1;
						break;
					}
				}
			}
		}
		if(!vehicleDriver) {
			for(j=0;j<MAX_PLAYERS;j++) {
				if(IsPlayerConnected(j)) {
					SetVehicleParamsForPlayer(i,j,0,0);
				}
			}
		}
	}
}

//------------------------------------------------------------------------------------------------------

public DeathmatchUpdate() {
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i)) {
			for(new j=0;j<MAX_DMZONES;j++) {
				if(isPlayerInArea(i,dmCoords[j]) && dmPlayers[i]!=j && (dmGangs[j][0]!=0 || dmGangs[j][1]!=0)) {
					dmWarning[i]++;
					GameTextForPlayer(i,"~r~YOU ARE IN A DEATHMATCH ZONE ~g~Leave for your own safety or be ~r~SHOT",10000,5);
					if(dmWarning[i] > 3) {
						SetPlayerHealth(i,0);
						ResetPlayerMoney(i);
					}
				}
			}
		}
	}
	
}

//------------------------------------------------------------------------------------------------------

public PirateShipScoreUpdate()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 100);
//		{
//            SendClientMessage(i, COLOR_YELLOW, "You earned money for holding the pirate ship.");
//		}
	}
}

//------------------------------------------------------------------------------------------------------

public GambleUpdate()
{
	new owner;
	new string[256];
	new ownername[MAX_PLAYER_NAME];
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i)) {
			for(new j=0;j<MAX_CASINO;j++) {
				if(isPlayerInArea(i,gambleAreas[j])) {
SendClientMessage(i, COLOR_RED, "bufu");
					owner = propertyOwner[j];
					if(owner!=i) {
						if(GetPlayerMoney(i) >= gamblingFee[j]) {
							if(owner!=999) {
								GetPlayerName(owner, ownername, MAX_PLAYER_NAME);
								format(string, sizeof(string), "You don't own this casino! Pay a $%d gambling fee to %s at once!",gamblingFee[j],ownername);
							} else {
								format(string, sizeof(string), "You don't own this casino! Pay a $%d gambling fee at once!",gamblingFee[j]);
							}
							SendClientMessage(i, COLOR_RED, string);
							GivePlayerMoney(i, 0-gamblingFee[j]);
							if(IsPlayerConnected(owner)) {
								GivePlayerMoney(owner,gamblingFee[j]);
							}
						} else {
							SendClientMessage(i, COLOR_RED, "You can't afford to gamble here! Leave at once!");
						}
					} else {
						//SendClientMessage(i, COLOR_YELLOW, "Welcome back.");
					}
				}
			}
		}
	}
}

//------------------------------------------------------------------------------------------------------

public checkpointUpdate()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i)) {
	        for(new j=0; j < MAX_POINTS; j++) {
	            if(isPlayerInArea(i, checkCoords[j])) {
	                if(playerCheckpoint[i]!=j) {
	                    DisablePlayerCheckpoint(i);
						SetPlayerCheckpoint(i, checkpoints[j][0],checkpoints[j][1],checkpoints[j][2],2);
						playerCheckpoint[i] = j;
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

//------------------------------------------------------------------------------------------------------

public PropertyScoreUpdate()
{
	new owners[MAX_PROPERTIES];
	new payments[MAX_PROPERTIES];
	
	for(new i=0; i < MAX_PROPERTIES; i++)
	    owners[i]=999;

	for(new i=0; i < MAX_PROPERTIES; i++)
	{
		if(propertyOwner[i] < 999) {
		
			for(new j=0; j < MAX_PROPERTIES; j++) {
			    if(owners[j]==propertyOwner[i]) {
			        payments[j]+=propertyEarnings[i];
			        j = MAX_PROPERTIES;
			    } else if (owners[j]==999) {
					owners[j]=propertyOwner[i];
					payments[j]+=propertyEarnings[i];
			        j = MAX_PROPERTIES;
				}
			}

		}
	}

	for(new i=0; i < MAX_PROPERTIES; i++) {
		if(owners[i] < 999 && IsPlayerConnected(owners[i])) {
			new string[256];

			if(dmPlayers[owners[i]]!=999) {
				bank[owners[i]]+=payments[i];
			} else {
				GivePlayerMoney(owners[i], payments[i]);

				format(string, sizeof(string), "You earned $%d from your properties.", payments[i]);
				SendClientMessage(owners[i], COLOR_GREEN, string);
			}
		}
	}

}

//------------------------------------------------------------------------------------------------------

public SavedUpdate()
{
	for(new i = 0; i < MAX_SAVE; i++) {
		if(savedInfo[i][3] < 5) {
			if(savedInfo[i][3]==4) {
				savedInfo[i][0]=savedInfo[i][1]=savedInfo[i][2]=0;
				savedNames[i][0]=0;
			}
			savedInfo[i][3]++;
		}
	}
}

//------------------------------------------------------------------------------------------------------

public MoneyGrubScoreUpdate()
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
				//format(string, sizeof(string), "$$$ %s is now in the lead $$$", name);
				//SendClientMessageToAll(COLOR_YELLOW, string);
			}
		}
	}
}

//------------------------------------------------------------------------------------------------------

/*public GrubModeReset()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			SetPlayerScore(i, PocketMoney);
			SetPlayerRandomSpawn(i, classid);
		}
	}

}*/

//------------------------------------------------------------------------------------------------------

public OnPlayerConnect(playerid)
{
	new playrname[MAX_PLAYER_NAME];

	GameTextForPlayer(playerid,"~w~SA-MP: ~r~Las Venturas ~g~MoneyGrub~b~(+LandGrab) ~y~+PitBoss +GangDM(modify by Smrtak)",5000,5);
	SendPlayerFormattedText(playerid, "Vitej v Las Venturas MoneyGrub(+LandGrab)+PitBoss+GangDM(modify by Smrtak)",0);
	SendClientMessage(playerid, COLOR_GREEN, "Prosim napis /help pro napovedu, nebo /whatsnew pro novinky.");
	SendClientMessage(playerid, COLOR_YELLOW,"Dodrzujte prosim pravidla /rules.");
    SendClientMessage(playerid, COLOR_YELLOW,"Novinka prikaz /warps, prikaz /ochranka a /tuning pro tuning prikazy");

	gActivePlayers[playerid]++;
	gLastGaveCash[playerid] = GetTickCount();

	playerCheckpoint[playerid]=999;
	bank[playerid]=0;
	playerGang[playerid]=0;
	gangInvite[playerid]=0;
	dmPlayers[playerid]=999;

	GetPlayerName(playerid, playrname, sizeof(playrname));
	for(new i = 0; i < MAX_SAVE; i++) {

	    if(isStringSame(savedNames[i], playrname, MAX_PLAYER_NAME)) {
			GivePlayerMoney(playerid, savedInfo[i][0]);
			bank[playerid] = savedInfo[i][1];
			bounty[playerid] = savedInfo[i][2];
			
			savedInfo[i][0]=savedInfo[i][1]=savedInfo[i][2]=0;
			savedNames[i][0]=0;

			for(new j = 0; j < MAX_SPAWNWEAPONS; j++) {
				playerWeapons[playerid][j]=savedWeapons[i][j];
				savedWeapons[i][j]=0;
			}

			SendClientMessage(playerid, COLOR_GREEN, "Your money has been restored.");
		}
	}

	return 1;
}

//------------------------------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid)
{
	new playername[MAX_PLAYER_NAME];
	gActivePlayers[playerid]--;

	for(new i = 0; i < MAX_PROPERTIES; i++) {
		if(propertyOwner[i]==playerid) {
		    propertyOwner[i] = 999;
		    GivePlayerMoney(playerid, propertyValues[i]);
  		}
	}

	//Save temp info for timeouts/crashes
	GetPlayerName(playerid, playername, sizeof(playername));
	format(savedNames[savePos], MAX_PLAYER_NAME, "%s",playername);

	savedInfo[savePos][0] = GetPlayerMoney(playerid);
	savedInfo[savePos][1] = bank[playerid];
	savedInfo[savePos][2] = bounty[playerid];
	savedInfo[savePos][3] = 0;

	for(new i = 0; i < MAX_SPAWNWEAPONS; i++)
		savedWeapons[savePos][i]=playerWeapons[playerid][i];
	//
	savePos++;
	if(savePos >= MAX_SAVE)
	    savePos = 0;

	PlayerLeaveGang(playerid);
	bounty[playerid] = 0;

	for(new i = 0; i < MAX_SPAWNWEAPONS;i++) {
		playerWeapons[playerid][i]=0;
	}
	
	//duel
	duelOnPlayerLeave(playerid);
}

//*************START DRAG FUNKCTIONS AND PARMS
#define MAX_DRAG_MEMBER 32
#define DRAG_COUNTER 5
#define DRAG_MAX_TIME 60000
#define DRAG_UPDATE_TIME 50

new Float:dragStartArea[8] = {
	-1688.0394,-155.4579,-1653.3419,-190.5280,-1642.1689,-180.0375,-1675.8800,-146.3983
};
new Float:dragEndArea[8] = {
	-1125.9200,407.4429,-1086.0991,367.7178,-1000.0145,452.8905,-1039.7690,492.7749
};


new dragMembers[MAX_DRAG_MEMBER];
new dragMembersStatus[MAX_DRAG_MEMBER];     //0 out , 1 ok
new dragCost;
new dragStart;
new dragMemberCount;
new dragCounter;
new dragCreated;
new dragTime;
new dragTimer;
new dragTimer2;

//-----------funkce

public isPlayerInRectangle(playerID, Float:data[8])
{
	new Float:X, Float:Y, Float:Z;

	GetPlayerPos(playerID, X, Y, Z);

	//first triangle
	new Float:t1,Float:t2,Float:t3,Float:t4;
	new Float:a1,Float:a2,Float:a3;

	t1 = (((data[2] - data[4])*(data[5] - Y)) - ((data[4] - X)*(data[3] - data[5])));
	t2 = (((data[0] - data[4])*(data[3] - data[5])) - ((data[2] - data[4])*(data[1] - data[5])));
	t3 = (((data[0] - data[4])*(data[5] - Y)) - ((data[4] - X)*(data[1] - data[5])));
	t4 = (((data[2] - data[4])*(data[1] - data[5])) - ((data[0] - data[4])*(data[3] - data[5])));

	if(t2 != 0) {
		a1 = t1/t2;
	} else {
		a1 = 0;
	}
	if(t4 != 0) {
		a2 = t3/t4;
	} else {
		a2 = 0;
	}
	a3 = 1.0-a1-a2;
	if((a1 < 0) || (a2 < 0) || (a3 < 0)){
		// then the point is not inside the first triang
  		//second triangle
		t1 = (((data[6] - data[4])*(data[5] - Y)) - ((data[4] - X)*(data[7] - data[5])));
		t2 = (((data[0] - data[4])*(data[7] - data[5])) - ((data[6] - data[4])*(data[1] - data[5])));
		t3 = (((data[0] - data[4])*(data[5] - Y)) - ((data[4] - X)*(data[1] - data[5])));
		t4 = (((data[6] - data[4])*(data[1] - data[5])) - ((data[0] - data[4])*(data[7] - data[5])));

		if(t2 != 0) {
			a1 = t1/t2;
		} else {
			a1 = 0;
		}
		if(t4 != 0) {
			a2 = t3/t4;
		} else {
			a2 = 0;
		}
		a3 = 1.0-a1-a2;
		if((a1 < 0) || (a2 < 0) || (a3 < 0)){
	  		// then the point is not inside the second triang
	  		return 0;
		}
	}
	return 1;
}

public startDrag(){
  
	new string[256];
	new playername[MAX_PLAYER_NAME];

    dragStart=true;
	if(dragCounter>1){
	    dragCounter--;
		//zvuk startu 321
		for(new i =0;i<dragMemberCount;i++){
  			if(dragMembersStatus[i]>0&&IsPlayerConnected(dragMembers[i]))
  			{
	  				PlayerPlaySound(dragMembers[i],1056,-1654.2109,-161.2337,13.8525);
			}
		}

	}
	else{
	    //START!!
		dragCounter=0;
  		KillTimer(dragTimer);
  		//zvuk startu :)
  		for(new i =0;i<dragMemberCount;i++){
  			if(dragMembersStatus[i]>0&&IsPlayerConnected(dragMembers[i]))
  			{
  				PlayerPlaySound(dragMembers[i],1057,-1654.2109,-161.2337,13.8525);
			}
  		}
		//timer2
		KillTimer(dragTimer2);      //pro jistotu
		dragTimer2 = SetTimer("updateDrag",DRAG_UPDATE_TIME,1);
	}
	format(string, sizeof(string), "%d", dragCounter);
	SendClientMessageToAll(COLOR_GREEN, string);

	//projed vsechny hrace a prover jestli neodstartovaly :)
   	for(new i =0;i<dragMemberCount;i++){
   	    if(dragMembersStatus[i]>0){
   	    	GameTextForPlayer(dragMembers[i],string,1000,5);
   	    }
		if(dragMembersStatus[i]>0&&IsPlayerConnected(dragMembers[i])&&!isPlayerInRectangle(dragMembers[i],dragStartArea)){
			//zjisti nazev hrace
		    GetPlayerName(dragMembers[i], playername, MAX_PLAYER_NAME);
		    //posli zpravu vsem
		    format(string, sizeof(string), "Hrac %s diskvalifikovan za predcasny start!", playername);
		    SendClientMessageToAll(COLOR_YELLOW,string);
		    //zprava pro hrace
  		    GameTextForPlayer(dragMembers[i],"~r~Byl jsi diskvalifikovan za predcasny start!",10000,5);
			//oznac zavodnika jako diskvalifikovaneho
			dragMembersStatus[i] = 0;
		 }
	}
}


public clearDrag(){
    dragCost = 0;
	dragStart = false;
	dragMemberCount = 0;
	dragTime = 0;
	dragCreated = false;

	for(new i = 0;i<MAX_DRAG_MEMBER;i++){
		dragMembers[i] = 999;
	}
}

public dragEnd(){
	print("dragEnd");

	KillTimer(dragTimer);
	KillTimer(dragTimer2);

	for(new i =0;i<dragMemberCount;i++){
		if(IsPlayerConnected(i)){
		    SendClientMessage(dragMembers[i], COLOR_GREEN,"Obdrzel si tve penize zpet ze zruseneho dragu.");
			GivePlayerMoney(dragMembers[i], dragCost);
		}
 	}
 	SendClientMessageToAll(COLOR_GREEN, "Drag byl zrusen");
 	clearDrag();
}
public dragEndWinner(id){
	new string[256];
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(id, playername, MAX_PLAYER_NAME);

	KillTimer(dragTimer);
	KillTimer(dragTimer2);

    format(string, sizeof(string), "Vitezem dragu v case %d ms se stava %s! Ziskava vyhru %d.", dragTime, playername,dragCost*dragMemberCount);
	SendClientMessageToAll(COLOR_GREEN, string);

	if(IsPlayerConnected(id)){
	    SendClientMessage(id, COLOR_GREEN,"Stal jsi se vitezem dragu!");
		GivePlayerMoney(id, dragCost*dragMemberCount);
	}
    clearDrag();
}

public updateDrag(){
	dragTime+=DRAG_UPDATE_TIME;
	if(dragTime>DRAG_MAX_TIME)
	{
	    dragEnd();
 	}
	for(new i =0;i<dragMemberCount;i++){
		if(IsPlayerConnected(dragMembers[i])){
			if(dragMembersStatus[i]>0 && isPlayerInRectangle(dragMembers[i],dragEndArea))
			{
	    		dragEndWinner(dragMembers[i]);
			}
		}
	}
}
//****************END DRAG FUNCTIONS


//***************START DUEL FUNCTION
#define DUEL_MAX_MEMBER 2
new DUEL_Member[DUEL_MAX_MEMBER][2] = {{-1,-1},{-1,-1}};    //0 id //1 weaponduelid
new DUEL_Started;
new DUEL_Counter;
new DUEL_TimerStart;
new DUEL_TimerUpdate;
#define DUEL_UPDATE_TIME 1000
#define DUEL_MAX_TIME 300000        //5Min

new Float:DUEL_StartPos[DUEL_MAX_MEMBER][4] = {
    {2449.7778,2378.5486,71.0496,270.0000},
    {2489.5415,2378.6658,71.0496,90.0000}
};
new Float:DUEL_SoundPos[3] = {2449.7778,2378.5486,71.0496
};
new Float:DUEL_GuestPos[1][3] = {
    {2460.1892,2336.0178,82.7734}
};

new Float:DUEL_ArenaPos[8] = {
	2444.8340,2350.7146,2497.4763,2350.5933,2497.5388,2403.1243,2444.8198,2403.1897
};

#define DUEL_MAX_WEAPONS 10
new DUEL_WeaponNames[DUEL_MAX_WEAPONS][32] = {
	"Baseball Bat",
	"Desert Eagle",
	"Shotgun",
	"Sawn Off Shotgun",
	"Combat Shotgun",
	"Micro Uzi (Mac 10)",
	"MP5",
	"AK47",
	"M4",
	"Tec9"
};

new DUEL_Weapons[DUEL_MAX_WEAPONS][2] = {
	{5,1},
	{24,200},
	{25,150},
	{26,150},
	{27,150},
	{28,2000},
	{29,2000},
	{30,1000},
	{31,1000},
	{32,2000}
};

public duelTimerStart(){
	new string[256];
	new i;

	if(DUEL_Counter>1){
	    DUEL_Counter--;
		//zvuk startu 321
		for(i =0;i<DUEL_MAX_MEMBER;i++){
  			if(DUEL_Member[i][0]>=0&&IsPlayerConnected(DUEL_Member[i][0])){
 				PlayerPlaySound(DUEL_Member[i][0],1056,DUEL_SoundPos[0],DUEL_SoundPos[1],DUEL_SoundPos[2]);
			}
		}
	}
	else{
	    //START!!
		DUEL_Counter=0;
  		KillTimer(DUEL_TimerStart);
  		//zvuk startu :)
		for(i =0;i<DUEL_MAX_MEMBER;i++){
  			if(DUEL_Member[i][0]>=0&&IsPlayerConnected(DUEL_Member[i][0])){
 				PlayerPlaySound(DUEL_Member[i][0],1057,DUEL_SoundPos[0],DUEL_SoundPos[1],DUEL_SoundPos[2]);
			}
		}
		//predej zbrane vsem ucastnikum
		for(i=0;i<DUEL_MAX_MEMBER;i++){
		    if(DUEL_Member[i][0]>=0&&IsPlayerConnected(DUEL_Member[i][0])){
		        //dej zbrane zivot a armor
		        SetPlayerHealth(DUEL_Member[i][0],100);
		        GivePlayerWeapon(DUEL_Member[i][0],DUEL_Weapons[DUEL_Member[i][1]][0],DUEL_Weapons[DUEL_Member[i][1]][1]);
		    }
		}
	}
	format(string, sizeof(string), "%d", DUEL_Counter);
	for(i=0;i<DUEL_MAX_MEMBER;i++){
 		if(DUEL_Member[i][0]>=0&&IsPlayerConnected(DUEL_Member[i][0])){
   	    	GameTextForPlayer(DUEL_Member[i][0],string,1000,5);
   	    }
    }
	//SendClientMessageToAll(COLOR_GREEN, string);
}
public duelTimerUpdate(){
	new i;
	//zkontroluj jestli jsou hraci v arene
	for(i =0;i<DUEL_MAX_MEMBER;i++){
		if(DUEL_Member[i][0]>=0&&IsPlayerConnected(DUEL_Member[i][0])&&!isPlayerInRectangle(DUEL_Member[i][0],DUEL_ArenaPos)){
			duelQuit(DUEL_Member[i][0]);
		}
	}
}

public duelOnPlayerLeave(playerid){
	duelQuit(playerid);
}

public duelEndLastWinner(){
	new string[256];
	new jmeno[MAX_PLAYER_NAME];
	new i;
	//vyhod vsechny hrace z duelu
	for(i=0;i<DUEL_MAX_MEMBER;i++){
 		//jestli ze je slot volny
		if(DUEL_Member[i][0]>=0&&IsPlayerConnected(DUEL_Member[i][0])){
		    GetPlayerName(DUEL_Member[i][0], jmeno, sizeof(jmeno));
			format(string,sizeof(string),"Vitezem duelu je %s.",jmeno);
		    SendClientMessageToAll(COLOR_LIGHTBLUE,string);
		}
	}

	return duelEnd();
}
//ukonci duel
public duelEnd(){
	new i;
	//vyhod vsechny hrace z duelu
	for(i=0;i<DUEL_MAX_MEMBER;i++){
 		//jestli ze je slot volny
		if(DUEL_Member[i][0]>=0){
		    duelQuit(DUEL_Member[i][0]);
		}
	}
	KillTimer(DUEL_TimerUpdate);
	DUEL_Started = false;
	return true;
}
//pripoji do duelu
public duelJoin(playerid,weaponid){
	new i;
	for(i=0;i<DUEL_MAX_MEMBER;i++){
	    //jestli ze je slot volny
		if(DUEL_Member[i][0]<0){
		    new string[256];
			new jmeno[100];
			//zapni kontorlu pozic
			KillTimer(DUEL_TimerUpdate);      //pro jistotu
			DUEL_TimerUpdate = SetTimer("duelTimerUpdate",DUEL_UPDATE_TIME,1);
            //odeber zbrane
            ResetPlayerWeapons(playerid);
            //presun hrace
            SetPlayerInterior(playerid,0);
            SetPlayerPos(playerid,DUEL_StartPos[i][0],DUEL_StartPos[i][1],DUEL_StartPos[i][2]);
            SetPlayerFacingAngle(playerid,DUEL_StartPos[i][3]);
			//zjisti jmeno
            GetPlayerName(playerid, jmeno, sizeof(jmeno));
			format(string,sizeof(string),"Hrac %s byl pripojen do duelu se zbrani %s (%d)",jmeno,DUEL_WeaponNames[weaponid],weaponid);
		    SendClientMessageToAll(COLOR_LIGHTBLUE,string);
            //obsad hracem
            DUEL_Member[i][0] = playerid;
            //dej duelzbran
            DUEL_Member[i][1] = weaponid;
			return true;
		}
	}
	return false;
}

public duelJoinGuest(playerid){
	new jmeno[MAX_PLAYER_NAME];
	new string[256];
	if(!IsPlayerConnected(playerid))
		return false;
	//presun hrace
 	SetPlayerInterior(playerid,0);
  	SetPlayerPos(playerid,DUEL_GuestPos[0][0],DUEL_GuestPos[0][1],DUEL_GuestPos[0][2]);
    //odeber zbrane
    ResetPlayerWeapons(playerid);
    GetPlayerName(playerid, jmeno, sizeof(jmeno));
	format(string,sizeof(string),"Hrac %s se prisel podivat na duel.",jmeno);
    SendClientMessageToAll(COLOR_LIGHTBLUE,string);
	return true;
}


public duelQuit(playerid){
	new i;
	for(i=0;i<DUEL_MAX_MEMBER;i++){
	    //jestli ze je slot volny
		if(DUEL_Member[i][0]==playerid){
			new string[256];
			new jmeno[100];
		    //vymaz slot hracem
            DUEL_Member[i][0] = -1;
            //vymaz duelzbran
            DUEL_Member[i][1] = -1;
            //zab hrace :)
            SetPlayerHealth(playerid,0);
            //bezi duel a zbyva v nem nekdo?
			if(DUEL_Started && duelGetMemberCount()==1){
				duelEndLastWinner();
			}
            //text
            GetPlayerName(playerid, jmeno, sizeof(jmeno));
			format(string,sizeof(string),"Hrac %s oputstil dueal.",jmeno);
 			SendClientMessageToAll(COLOR_LIGHTBLUE,string);
 			duelOnPlayerLeave(playerid);
 			if(duelGetMemberCount()<=0){
 				KillTimer(DUEL_TimerUpdate);
 			}
            return true;
		}
	}
	return false;
}
public duelGetMemberCount(){
	new i;
	new j = 0;
	for(i=0;i<DUEL_MAX_MEMBER;i++){
	    //jestli ze je slot volny
		if(DUEL_Member[i][0]>=0){
			j++;
		}
	}
	return j;
}

public duelIsIn(playerid){
	new i;
	for(i=0;i<DUEL_MAX_MEMBER;i++){
	    //jestli ze je slot volny
		if(DUEL_Member[i][0]==playerid){
			return true;
		}
	}
	return false;
}

public duelStart(){
	KillTimer(DUEL_TimerStart);     //pro jistotu :)
    DUEL_TimerStart = SetTimer("duelTimerStart",1000,1);
	DUEL_Started = true;
	DUEL_Counter = 4;
	
	SendClientMessageToAll(COLOR_LIGHTBLUE,"Duel zahajen, pripravit...");
	return true;
}


//***************END DUEL FUNCTION

//------------------------------------------------------------------------------------------------------

public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[256];
	new playermoney;
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new cmd[256];
	new giveplayerid, moneys, idx, weaponid;
	new Float:X, Float:Y, Float:Z;
	
	cmd = strtok(cmdtext, idx);
	
	//------------------- /help

	if(strcmp(cmd, "/help", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN,"LV MoneyGrub(+LandGrab)+PitBoss+GangDM Help");
		SendClientMessage(playerid, COLOR_YELLOW,"Na piratkse lodi obdrzite penize do zacatku, muzete take skupovat nemovitosti,");
		SendClientMessage(playerid, COLOR_YELLOW,"nebo hrat v casinu. Muzete nastivit ATMs v 24x7 hodinovych obchodech, kde se nachazi banka.");
		SendClientMessage(playerid, COLOR_YELLOW,"Muzete pouzit prikaz /hitman pro vypsani odmeny na hrace, ");
		SendClientMessage(playerid, COLOR_YELLOW,"/givecash pro predani penez ostatnim hracum. Muzete kupovat zbrane v ammo shopu i do spawnu.");
		SendClientMessage(playerid, COLOR_ORANGE,"Napis /commands pro vypis prikazu, a /gangcommands pro vypis prikazu gangu.");
		SendClientMessage(playerid, COLOR_ORANGE,"Napis /whatsnew pro vypis novinek v PitBoss+GangDM.");
		SendClientMessage(playerid, COLOR_LIGHTBLUE,"Limusina je pristupna pouze pro majitele casina a jeho gang.");
		return 1;
	}

	if(strcmp(cmd, "/commands", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN,"Available commands:");
		SendClientMessage(playerid, COLOR_YELLOW,"/bank [amount], /withdraw [amount], /balance");
		SendClientMessage(playerid, COLOR_YELLOW,"/givecash [playerid] [amount]");
		SendClientMessage(playerid, COLOR_YELLOW,"/hitman [playerid] [amount], /bounty [playerid]");
		SendClientMessage(playerid, COLOR_YELLOW,"/buy, /properties1, /properties2");
		SendClientMessage(playerid, COLOR_YELLOW,"/buyweapon, /weaponist");
		SendClientMessage(playerid, COLOR_YELLOW,"/bounties, /gangs");
		SendClientMessage(playerid, COLOR_YELLOW,"/lock, /unlock");
		SendClientMessage(playerid, COLOR_YELLOW,"/exports, /ochranka, /tuning, /duel");
		SendClientMessage(playerid, COLOR_YELLOW,"/gamblingfee [amount]");
		return 1;
	}

	if(strcmp(cmd, "/gangcommands", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN,"Gang commands:");
		SendClientMessage(playerid, COLOR_YELLOW,"/gang create [name]");
		SendClientMessage(playerid, COLOR_YELLOW,"/gang join");
		SendClientMessage(playerid, COLOR_YELLOW,"/gang invite [playerID]");
		SendClientMessage(playerid, COLOR_YELLOW,"/gang quit");
		SendClientMessage(playerid, COLOR_YELLOW,"/ganginfo [number] (no number given shows your gang's info)");
		SendClientMessage(playerid, COLOR_YELLOW,"/gbank [money], /gwithdraw [money], /gbalance");
		SendClientMessage(playerid, COLOR_YELLOW,"/gdeathmatch [zone]");
		SendClientMessage(playerid, COLOR_YELLOW,"! (prefix text for gang-chat)");
		return 1;
	}

	if(strcmp(cmd, "/rules", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN,"Pravidla:");
		SendClientMessage(playerid, COLOR_YELLOW,"Zakazan spawnkilling,bikekilling,carkilling,helikill,spawnkill a samozrejmne cheatovani.");
        SendClientMessage(playerid, COLOR_YELLOW,"Hraci mohou uplatnit /votekick pokud neni pritomny admin.");
        SendClientMessage(playerid, COLOR_YELLOW,"V oblasti SF tuning srazu je zakazano pouzivani zbrani, ci jakekoli.");
		SendClientMessage(playerid, COLOR_YELLOW,"ohrozovani tuneru, v opacnem pripade jsou hraci opravneni pouzit /votekick.");
		SendClientMessage(playerid, COLOR_YELLOW,"Na poradek v SF smi dohlizet ochranka (/ochranka).");
		SendClientMessage(playerid, COLOR_YELLOW,"EN rules: DO NOT USE: pawnkilling,bikekilling,carkilling,helikill,interior killing,spawnkill");
		SendClientMessage(playerid, COLOR_YELLOW,"Do not use weapons in SF area.");
		return 1;
	}


	//------------------- /version

	if (strcmp(cmdtext, "/version", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW, "0.4 moded by smrtak");
		return 1;
	}

	//------------------- /set pit boss game text

	if (strcmp(cmdtext, "/pbgametext", true) == 0) {
		if(IsPlayerAdmin(playerid)) {
			pbGameText = !pbGameText;
			if(pbGameText) {
				SendClientMessage(playerid, COLOR_YELLOW, "Pit Boss game text has been enabled.");
			} else {
				SendClientMessage(playerid, COLOR_YELLOW, "Pit Boss game text has been disabled.");
			}
		} else {
			SendClientMessage(playerid, COLOR_YELLOW, "You must be logged in as an administrator to use this feature.");
		}
		return 1;
	}

	//------------------- /whatsnew

	if (strcmp(cmdtext, "/whatsnew", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN, "Novinky v Pit Boss a Gang DM:");
		SendClientMessage(playerid, COLOR_YELLOW, "- Vozidla a hraci maji nove startovaci pozice.");
		SendClientMessage(playerid, COLOR_YELLOW, "- Vozidla mohou byt zamknuta/odemknuta uzitim prikazu /lock a /unlock, a");
		SendClientMessage(playerid, COLOR_YELLOW, "a budou automaticky odemcena jestlize odejdete ze hry.");
		SendClientMessage(playerid, COLOR_YELLOW, "- Vozidla mohou byt prodana v Wang Exports na...(zadne otazky:) ).");
		SendClientMessage(playerid, COLOR_YELLOW, "- Las Venturas Strip Club, Emerald Isle, The Visage, Verdant Meadows Air Strip,");
		SendClientMessage(playerid, COLOR_YELLOW, "The Big Spread Ranch a Wang Cars mohou byt zkoupena prikazem /buy.");
		SendClientMessage(playerid, COLOR_YELLOW, "- Byly znovu pridany hazardni hry do kasin, hraci musi platit majitely kasina");
		SendClientMessage(playerid, COLOR_YELLOW, " (pit bossovi).");
		SendClientMessage(playerid, COLOR_YELLOW, "- Exluzivni zona pro gang deatmatch (napis /gdeathmatch).");
		return 1;
	}
	
	
		//***************START DRAG ON COMMAND TEXT
	//------------------- /movealltuning
	if(strcmp(cmd, "/movealltuning", true) == 0 && IsPlayerAdmin(playerid)) {
        for(new i=0; i<MAX_PLAYERS; i++)
		{
	    	if(IsPlayerConnected(i)) {
		    	//zprava pro hrace
		    	SetPlayerInterior(i,0);
		    	SetPlayerPos(i,-1980.8552,253.6175,35.3494);
  		    	GameTextForPlayer(i,"~r~Byl jsi presunut administratorem na TUNING sraz, obrdzel si 50000. ZAKAZ STRILENI!(DONT FIRE)",10000,1);
                GivePlayerMoney(i, 50000);
	 		}
		}
		SendClientMessageToAll(COLOR_YELLOW,"Vsichni hraci byly presunuti administratorem na TUNING SRAZ!");
		return 1;
	}
	//------------------- /giveallmoney
	if(strcmp(cmd, "/giveallmoney", true) == 0 && IsPlayerAdmin(playerid)) {
        for(new i=0; i<MAX_PLAYERS; i++)
		{
	    	if(IsPlayerConnected(i)) {
		    	//zprava pro hrace
		    	GivePlayerMoney(i, 50000);
	 		}
		}
		SendClientMessageToAll(COLOR_YELLOW,"Vsichni hraci obdrzely 50tisic!");
		return 1;
	}
	//------------------- /tuning & ochranka & duel
	//HELP
	if(strcmp(cmd, "/tuning", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN,"Prikazy tuningu:");
		SendClientMessage(playerid, COLOR_WHITE,"Draha na drag se nachazi na SF runwayi,start je na care.");
		SendClientMessage(playerid, COLOR_YELLOW,"/dragcreate [castka]");
		SendClientMessage(playerid, COLOR_YELLOW,"/dragjoin");
		SendClientMessage(playerid, COLOR_YELLOW,"/dragstart");
		SendClientMessage(playerid, COLOR_YELLOW,"/draginfo");
		SendClientMessage(playerid, COLOR_YELLOW,"/dragend");
		SendClientMessage(playerid, COLOR_YELLOW,"/warptuning");
		return 1;
	}
	if(strcmp(cmd, "/ochranka", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN,"Hraci jsou povini uhradit vstup do vyse 2000 za 1 automobil, byt slusni, dodrzovat pravidla,");
        SendClientMessage(playerid, COLOR_GREEN,"nepouzivat zbrane ci jakkoli narusovat beh zavodu. V opacnem pripade je ochranka");
        SendClientMessage(playerid, COLOR_GREEN,"letiste opravnena jej eskortovat ven, nebo i usmrtit.");
        SendClientMessage(playerid, COLOR_GREEN,"Clenove ochranky nesmi napadat bezduvodne hrace dodrzujici pravidla.");
        SendClientMessage(playerid, COLOR_GREEN,"Zastupovat cleny ochranky je mozno pouze pod jejich pravym skinem skinem(144-147).");
		SendClientMessage(playerid, COLOR_YELLOW,"/alarm [playerid]  -upozorni hrace na poruseni pravidel");
		SendClientMessage(playerid, COLOR_YELLOW,"/ticket [playerid]  -da hraci listek - kvetinu");

		return 1;
	}
	if(strcmp(cmd, "/duel", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN,"Prikazy duelu:");
		SendClientMessage(playerid, COLOR_YELLOW,"/dueljoin [zbranid]");
		SendClientMessage(playerid, COLOR_YELLOW,"/duelstart");
		SendClientMessage(playerid, COLOR_YELLOW,"/duelguest");
		SendClientMessage(playerid, COLOR_YELLOW,"/duelweaponlist");
		return 1;
	}
		//------------------- /warps
	if(strcmp(cmd, "/warps", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN,"Seznam warpu:");
		SendClientMessage(playerid, COLOR_YELLOW,"/warptuning");
		SendClientMessage(playerid, COLOR_YELLOW,"/warphora");
		SendClientMessage(playerid, COLOR_YELLOW,"/warpmrakodrap");
		return 1;
	}
	//DUEL
	if(strcmp(cmd, "/dueljoin", true) == 0){
	    new tmp[256];
		new zbranid;
	    tmp = strtok(cmdtext, idx);

	    if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "POUZITI: /dueljoin [zbranid]");
			return 1;
	    }
	    //kontrola udaju
	    //nono dodelat
	    if(DUEL_Started) {
			SendClientMessage(playerid, COLOR_WHITE, "Duel jiz probiha, vyckejte!");
            return 1;
		}
		//duplicita
		if(duelIsIn(playerid)) {
			SendClientMessage(playerid, COLOR_WHITE, "Jiz jsi v duelu!");
            return 1;
		}
		zbranid = strval(tmp);
		if(zbranid>=DUEL_MAX_WEAPONS||zbranid<0) {
			SendClientMessage(playerid, COLOR_WHITE, "Spatne zvolena zbran! Mrknete se na /duelweaponlist");
            return 1;
		}
		//vytvor duel
		if(!duelJoin(playerid,zbranid)){
		    SendClientMessage(playerid,COLOR_WHITE,"Nebyl jsi pripojen do duelu, nejspis je jiz plny!");
		}
		//start pokud je plny pocet hracu
		if(duelGetMemberCount()==DUEL_MAX_MEMBER){
			duelStart();
		}
		return 1;
	}
	if(strcmp(cmd, "/duelstart", true) == 0){
	    //kontrola udaju
	    //nono dodelat
	    if(DUEL_Started) {
			SendClientMessage(playerid, COLOR_WHITE, "Duel jiz probiha!");
            return 1;
		}
		if(!duelIsIn(playerid)) {
			SendClientMessage(playerid, COLOR_WHITE, "Nejsi v duelu nemuzes ho odstartovat!");
            return 1;
		}
		if(duelGetMemberCount()<2) {
			SendClientMessage(playerid, COLOR_WHITE, "Nedostatecny pocet hracu!");
            return 1;
		}
		//vytvor duel
		duelStart();
		return 1;
	}
	//------------------- /duelguest
	if(strcmp(cmd, "/duelguest", true) == 0){
		duelJoinGuest(playerid);
		return 1;
	}
	//------------------- /duelweaponlist
	if(strcmp(cmd, "/duelweaponlist", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN, "Duel Weapons List:");
		for(new i = 0; i < DUEL_MAX_WEAPONS; i++) {
			format (string, sizeof(string), "%d. %s",i,DUEL_WeaponNames[i]);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
		return 1;
	}
	//TUNING
	//------------------- /warptuning
	if(strcmp(cmd, "/warptuning", true) == 0){
	    SetPlayerInterior(playerid,0);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		SetPlayerPos(playerid,-1980.8552,253.6175,35.3494);
		//SetPlayerPos(playerid,-1688.0394,-155.4579,35.3494);
		format(string, sizeof(string), "Hrac %s byl odwarpovan na tuning do SF.", sendername);
		SendClientMessageToAll(COLOR_YELLOW, string);
		return 1;
	}
	//------------------- /dragend
	if(strcmp(cmd, "/dragend", true) == 0){
		if(!dragCreated) {
			SendClientMessage(playerid, COLOR_WHITE, "Neni vytvoren zadny drag!");
            return 1;
		}
		if(dragStart) {
			SendClientMessage(playerid, COLOR_WHITE, "Drag je odstartovan nelze zrusit, vyckejte.");
            return 1;
		}
		dragEnd();
		return 1;
 	}
	//------------------- /createdrag
	if(strcmp(cmd, "/dragcreate", true) == 0){
		new tmp[256];
		new castka;
	    tmp = strtok(cmdtext, idx);

	    if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "POUZITI: /dragcreate [castka]");
			return 1;
	    }
	    if(dragCreated) {
			SendClientMessage(playerid, COLOR_WHITE, "Jiz je drag vytvoren!");
            return 1;
		}
	    castka = strval(tmp);
	    if(castka<0){
            SendClientMessage(playerid, COLOR_WHITE, "Neplatne zadani!");
            return 1;
		}
		if(GetPlayerMoney(playerid) < castka) {
		    format(string, sizeof(string), "Nemas dostatek financi! Je potreba %d.", castka);
			SendClientMessage(playerid, COLOR_WHITE, string);
			return 1;
		}
		//vse ok vytvor novy drag
		if(dragCreated)
			dragEnd();
		dragCreated = true;
		dragCost = castka;
		//join
		dragMembers[dragMemberCount] = playerid;
		dragMembersStatus[dragMemberCount] = 1;
		dragMemberCount++;
		GivePlayerMoney(playerid, 0-dragCost);

		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "Hrac %s vytvoril drag se zapisnym %d.", sendername,castka);
		SendClientMessageToAll(COLOR_YELLOW, string);
		return 1;
	}

	//------------------- /draginfo
	if(strcmp(cmd, "/draginfo", true) == 0){
	    SendClientMessage(playerid, COLOR_GREEN,"Vypis ucastniku dragu:");
	    for(new i =0;i<dragMemberCount;i++){
	    	if(IsPlayerConnected(dragMembers[i]))
	    	{
		        GetPlayerName(dragMembers[i], sendername, sizeof(sendername));
		        if(dragMembersStatus[i]>0)
		    		format(string, sizeof(string), "%s - OK", sendername);
				else
				    format(string, sizeof(string), "%s - DISKVALIFIKOVAN", sendername);
				SendClientMessage(playerid, COLOR_YELLOW,string);
			}
		}
		return 1;
	}
	//------------------- /dragjoin
	if(strcmp(cmd, "/dragjoin", true) == 0){
		if(GetPlayerMoney(playerid) < dragCost) {
		    format(string, sizeof(string), "Nemas dostatek financi! Je potreba %d.", dragCost);
			SendClientMessage(playerid, COLOR_WHITE, string);
			return 1;
		}
		if(!dragCreated){
  			SendClientMessage(playerid, COLOR_YELLOW, "Neni vytvoren zadny drag, pouzijte /dragcreate [castka]!");
  			return 1;
		}
		for(new i =0;i<dragMemberCount;i++){
			if(dragMembers[i]==playerid){
			    SendClientMessage(playerid, COLOR_YELLOW, "Jiz si prihlasen v dragu!");
			    return 1;
			}
		}
		if(dragStart){
  			SendClientMessage(playerid, COLOR_YELLOW, "Drag probiha, vyckejte!");
  			return 1;
		}

		//join
        dragMembers[dragMemberCount] = playerid;
        dragMembersStatus[dragMemberCount] = 1;
		dragMemberCount++;
		GivePlayerMoney(playerid, 0-dragCost);
		//text
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "Hrac %s se pripojil do dragu.", sendername);
		SendClientMessageToAll(COLOR_YELLOW, string);
		return 1;
	}
	//------------------- /dragstart
	if(strcmp(cmd, "/dragstart", true) == 0){
		if(!dragCreated)
		{
		    SendClientMessage(playerid, COLOR_YELLOW,"Neni pripraven zadny drag, pouzijte /dragcreate [castka].");
			return 1;
		}
		if(dragStart)
		{
		    SendClientMessage(playerid, COLOR_YELLOW,"Jiz je jeden drag odstartovan!");
			return 1;
		}
	    SendClientMessageToAll(COLOR_GREEN, "Drag zahajen! Pripravit pozor:");
		dragCounter = DRAG_COUNTER;
		KillTimer(dragTimer);   //pro jistotu
		dragTimer = SetTimer("startDrag",1000,1);
		return 1;
	}
	//********************END DRAG ON COMMAND TEXT
	//warpy
	if(strcmp(cmd, "/warpmrakodrap", true) == 0){
	    SetPlayerInterior(playerid,0);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		SetPlayerPos(playerid,1540.3540,-1359.2543,329.4631);
		//SetPlayerPos(playerid,-1688.0394,-155.4579,35.3494);
		format(string, sizeof(string), "Hrac %s byl odwarpovan na mrakodrap do LS.", sendername);
		SendClientMessageToAll(COLOR_YELLOW, string);
		return 1;
	}
	if(strcmp(cmd, "/warphora", true) == 0){
	    SetPlayerInterior(playerid,0);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		SetPlayerPos(playerid,-2235.8953,-1735.8722,480.7959);
		//SetPlayerPos(playerid,-1688.0394,-155.4579,35.3494);
		format(string, sizeof(string), "Hrac %s byl odwarpovan na horu Chilliad.", sendername);
		SendClientMessageToAll(COLOR_YELLOW, string);
		return 1;
	}
	//OCHRANKA
	if(strcmp(cmd, "/alarm", true) == 0 && iPlayerRole[playerid] == 2){
        new tmp[256];
		new alarmid;
	    tmp = strtok(cmdtext, idx);

	    if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "POUZITI: /alarm [playerid]");
			return 1;
	    }
	    alarmid = strval(tmp);
	    if(!IsPlayerConnected(alarmid)){
            SendClientMessage(playerid, COLOR_WHITE, "Hrac neni pripojen!");
            return 1;
		}
		GetPlayerName(alarmid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "Clen ochranky %s upozornuje hrace %s na poruseni pravidel.", sendername,giveplayer);
		SendClientMessageToAll(COLOR_RED, string);
		GameTextForPlayer(alarmid,"~r~OCHRANKA: porusujete pravidla! Pokud neuposlechnete budete zabiti.",5000,1);
		return 1;
	}
	if(strcmp(cmd, "/ticket", true) == 0 && iPlayerRole[playerid] == 2){
        new tmp[256];
		new alarmid;
	    tmp = strtok(cmdtext, idx);

	    if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "POUZITI: /ticket [playerid]");
			return 1;
	    }
	    alarmid = strval(tmp);
	    if(!IsPlayerConnected(alarmid)){
            SendClientMessage(playerid, COLOR_WHITE, "Hrac neni pripojen!");
            return 1;
		}
		GetPlayerName(alarmid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "Clen ochranky %s predal hraci %s listek(kvetinu).", sendername,giveplayer);
		SendClientMessageToAll(COLOR_GREEN, string);
		GameTextForPlayer(alarmid,"~G~OCHRANKA: obdrzel jste listek(kvetinu).",5000,1);
        GivePlayerWeapon(alarmid,14,1);
		return 1;
	}


	//------------------- /gamblingfee

	if (strcmp(cmd, "/gamblingfee", true) == 0) {
		new tmp[256];
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp) || (propertyOwner[P_DRAGON]!=playerid && propertyOwner[P_CALIGULA]!=playerid)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /gamblingfee [amount]");
			SendClientMessage(playerid, COLOR_YELLOW, "This command is only available to Casino owners.");
		} else {
			new fee = strval(tmp);
			new ownername[MAX_PLAYER_NAME];
			if(fee>=MIN_GAMBLINGFEE && fee<=MAX_GAMBLINGFEE) {
				for(new i=0;i<MAX_CASINO;i++) {
					if(propertyOwner[i]==playerid) {
						GetPlayerName(playerid, ownername, sizeof(ownername));
						gamblingFee[i]=fee;
						format(string, sizeof(string), "Gambling fee for %s has been set to $%d by Pit Boss %s.",propertyNames[i],fee,ownername);
						SendClientMessageToAll(COLOR_YELLOW, string);
					}
				}
			} else {
				format(string, sizeof(string), "Gambling fee range is $%d to $%d.",MIN_GAMBLINGFEE,MAX_GAMBLINGFEE);
				SendClientMessage(playerid, COLOR_YELLOW, string);
			}
		}
		return 1;
	}

	//------------------- /lock

	if (strcmp(cmd, "/lock", true) == 0) {
		new limo = 0;
		if(IsPlayerInAnyVehicle(playerid)) {
			for(new i=0;i<MAX_CASINO;i++) {
				if(GetPlayerVehicleID(playerid)==casinoVehicles[i][0] || GetPlayerVehicleID(playerid)==casinoVehicles[i][1]) {
					limo = 1;
					break;
				}
			}
			if(!limo && GetPlayerState(playerid)==PLAYER_STATE_DRIVER) {
				for(new i=0;i<MAX_PLAYERS;i++) {
					if(i!=playerid) {
						SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 1);
					}
				}
				SendClientMessage(playerid, COLOR_GREY, "Vehicle locked.");
				GetPlayerPos(playerid,X,Y,Z);
				PlayerPlaySound(playerid,1056,X,Y,Z);
			} else {
				SendClientMessage(playerid, COLOR_GREY, "You cannot lock this vehicle.");
			}
		}
		else {
			SendClientMessage(playerid, COLOR_GREY, "You're not in a vehicle!");
		}
		return 1;
	}

	//------------------- /unlock

	if (strcmp(cmd, "/unlock", true) == 0) {
		new limo = 0;
		if(IsPlayerInAnyVehicle(playerid)) {
			for(new i=0;i<MAX_CASINO;i++) {
				if(GetPlayerVehicleID(playerid)==casinoVehicles[i][0] || GetPlayerVehicleID(playerid)==casinoVehicles[i][1]) {
					limo = 1;
					break;
				}
			}
			if(!limo && GetPlayerState(playerid)==PLAYER_STATE_DRIVER) {
				for(new i=0;i<MAX_PLAYERS;i++) {
					if(i!=playerid) {
						SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
					}
				}
				SendClientMessage(playerid, COLOR_GREY, "Vehicle unlocked.");
				GetPlayerPos(playerid,X,Y,Z);
				PlayerPlaySound(playerid,1057,X,Y,Z);
			} else {
				SendClientMessage(playerid, COLOR_GREY, "You cannot unlock this vehicle.");
			}
		} else {
			SendClientMessage(playerid, COLOR_GREY, "You're not in a vehicle!");
		}
		return 1;
	}

	//------------------- /exports

	if (strcmp(cmd, "/exports", true) == 0) {
		new vehicleName[32];
		vehicleName = "";
		for(new i=0; i < MAX_WANGEXPORTVEHICLES; i++) {
			if(wantedWangExportVehicles[i]==wantedWangExportVehicle) {
				format(vehicleName, sizeof(vehicleName), "%s",wantedWangExportVehicleNames[i]);
			}
		}
		if(strlen(vehicleName)==0) {
			format(string, sizeof(string), "Sorry, Wang Exports are not buying any vehicles at this time.");
		} else {
			format(string, sizeof(string), "Wang Exports are currently buying %s's.",vehicleName);
		}
		SendClientMessage(playerid, COLOR_YELLOW, string);
		return 1;
	}

	//------------------- /gdeathmatch

	if (strcmp(cmd, "/gdeathmatch", true) == 0 || strcmp(cmd, "/gdm", true) == 0) {
		if (playerGang[playerid]>0) {
			new tmp[256];
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /deathmatch [zone]");
				SendClientMessage(playerid, COLOR_GREEN, "Available deathmatch zones:");
				for(new i=0;i<MAX_DMZONES;i++){
					format(string, sizeof(string), "%d. %s (%s).",i,dmNames[i],weaponNames[dmWeapons[i][0]]);
					SendClientMessage(playerid, COLOR_YELLOW, string);
				}
			} else {
				new dmZone = strval(tmp);
				if(dmZone>=0 && dmZone<MAX_DMZONES) {
					new gangnum;
					new ganginarea = 0;

					// Kill player if already in a deathmatch
					if(dmPlayers[playerid]!=999) {
						SendClientMessage(playerid, COLOR_YELLOW, "Hey what are you trying to pull here. You must complete your deathmatch round.");
						SetPlayerHealth(playerid,0);
						return 1;
					}

					// If no gang players are left inside a deathmatch zone, remove gang exlusive to zone
					gangnum = dmGangs[dmZone][0];
					if(gangnum>0) {
						for(new i=0;i<gangInfo[gangnum][1];i++) {
							if(isPlayerInArea(gangMembers[gangnum][i],dmCoords[dmZone]) && dmPlayers[gangMembers[gangnum][i]]==dmZone) {
								ganginarea = 1;
							}
						}
						if(!ganginarea) {
							dmGangs[dmZone][0] = 0;
						}
					}
					gangnum = dmGangs[dmZone][1];
					if(gangnum>0) {
						for(new i=0;i<gangInfo[gangnum][1];i++) {
							if(isPlayerInArea(gangMembers[gangnum][i],dmCoords[dmZone]) && dmPlayers[gangMembers[gangnum][i]]==dmZone) {
								ganginarea = 1;
							}
						}
						if(!ganginarea) {
							dmGangs[dmZone][1] = 0;
						}
					}

					// Add player to deathmatch zone
					gangnum = playerGang[playerid];
					if (dmGangs[dmZone][0]==gangnum || dmGangs[dmZone][1]==gangnum) {
						OnPlayerEnterDeathmatch(playerid,gangnum,dmZone);
					} else {
						if(dmGangs[dmZone][0]==0) {
							dmGangs[dmZone][0] = gangnum;
						} else if(dmGangs[dmZone][1]==0) {
							dmGangs[dmZone][1] = gangnum;
						} else {
							format(string, sizeof(string), "Sorry, deathmatch zone %s is full. Please wait for next round or select an alternate zone.",dmNames[dmZone]);
							SendClientMessage(playerid, COLOR_YELLOW, string);
							return 1;
						}
						new playername[MAX_PLAYER_NAME];
						GetPlayerName(playerid, playername, sizeof(playername));
						format(string, sizeof(string), "%s has entered deathmatch zone %s (id: %d).",playername,dmNames[dmZone],dmZone);
						SendClientMessageToAll(COLOR_YELLOW, string);
						format(string, sizeof(string), "All %s gang members can now join.",gangNames[gangnum]);
						SendClientMessageToAll(COLOR_YELLOW, string);
						OnPlayerEnterDeathmatch(playerid,gangnum,dmZone);
					}
				} else {
					SendClientMessage(playerid, COLOR_YELLOW, "You have selected an invalid zone.");
					SendClientMessage(playerid, COLOR_GREEN, "Available deathmatch zones:");
					for(new i=0;i<MAX_DMZONES;i++){
						format(string, sizeof(string), "%d. %s (%s).",i,dmNames[i],weaponNames[dmWeapons[i][0]]);
						SendClientMessage(playerid, COLOR_YELLOW, string);
					}
				}
			}
		} else {
			SendClientMessage(playerid, COLOR_YELLOW, "You must be a gang member to enter a deathmatch zone (create a gang or join a gang).");
		}
		return 1;
	}

	//------------------- /bank
	
	if(strcmp(cmd, "/bank", true) == 0 || strcmp(cmd, "/gbank", true) == 0) {
	    new gang;
	    if(strcmp(cmd, "/gbank", true) == 0)
	        gang = 1;
	
	    if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK) {
	        SendClientMessage(playerid, COLOR_YELLOW, "You must be at a bank area to use this. ATMs are located in convenience stores.");
			return 1;
		}
	
		if(gang && playerGang[playerid]==0) {
			SendClientMessage(playerid, COLOR_RED, "You are not in a gang!");
			return 1;
		}

		new tmp[256];
	    tmp = strtok(cmdtext, idx);
	    
	    if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /(g)bank [amount]");
			return 1;
	    }
	    moneys = strval(tmp);
	    
	    if(moneys < 1) {
			SendClientMessage(playerid, COLOR_YELLOW, "Hey what are you trying to pull here.");
			return 1;
		}
		
		if(GetPlayerMoney(playerid) < moneys) {
			moneys = GetPlayerMoney(playerid);
		}

		GivePlayerMoney(playerid, 0-moneys);
		
		if(gang)
		    gangBank[playerGang[playerid]]+=moneys;
		else
			bank[playerid]+=moneys;

		if(gang)
			format(string, sizeof(string), "You have deposited $%d, your gang's balance is $%d.", moneys, gangBank[playerGang[playerid]]);
		else
			format(string, sizeof(string), "You have deposited $%d, your current balance is $%d.", moneys, bank[playerid]);

		SendClientMessage(playerid, COLOR_YELLOW, string);
		
		return 1;
	}
	
	//------------------- /withdraw

	if(strcmp(cmd, "/withdraw", true) == 0 || strcmp(cmd, "/gwithdraw", true) == 0) {
	    new gang;
	
	    if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK) {
	        SendClientMessage(playerid, COLOR_YELLOW, "You must be at a bank area to use this. ATMs are located in convenience stores.");
			return 1;
		}

		if(strcmp(cmd, "/gwithdraw", true) == 0)
		    gang = 1;

		if(gang && playerGang[playerid]==0) {
			SendClientMessage(playerid, COLOR_RED, "You are not in a gang!");
			return 1;
		}

	    new tmp[256];
	    tmp = strtok(cmdtext, idx);

	    if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /(g)withdraw [amount]");
			return 1;
	    }
	    moneys = strval(tmp);

	    if(moneys < 1) {
			SendClientMessage(playerid, COLOR_YELLOW, "Hey what are you trying to pull here.");
			return 1;
		}
	    
	    if(gang) {
			if(moneys > gangBank[playerGang[playerid]])
			    moneys = gangBank[playerGang[playerid]];
	    } else {
		    if(moneys > bank[playerid])
		        moneys = bank[playerid];
     	}

		GivePlayerMoney(playerid, moneys);
		if(gang)
			gangBank[playerGang[playerid]] -= moneys;
		else
			bank[playerid] -= moneys;
	    
		if(gang)
			format(string, sizeof(string), "You have withdrawn $%d, your gang's balance is $%d.", moneys, gangBank[playerGang[playerid]]);
		else
			format(string, sizeof(string), "You have withdrawn $%d, your current balance is $%d.", moneys, bank[playerid]);
		SendClientMessage(playerid, COLOR_YELLOW, string);

		return 1;
   	}

	//------------------- /balance
	
	if(strcmp(cmd, "/balance", true) == 0 || strcmp(cmd, "/gbalance", true) == 0) {
		new gang;
		if(strcmp(cmd, "/gbalance", true) == 0)
			gang = 1;
	
	    if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK) {
	        SendClientMessage(playerid, COLOR_YELLOW, "You must be at a bank area to use this. ATMs are located in convenience stores.");
			return 1;
		}

		if(gang && playerGang[playerid]==0) {
			SendClientMessage(playerid, COLOR_RED, "You are not in a gang!");
			return 1;
		}
		
		if(gang)
			format(string, sizeof(string), "Your gang has $%d in the bank.", gangBank[playerGang[playerid]]);
		else
			format(string, sizeof(string), "You have $%d in the bank.", bank[playerid]);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		
		return 1;
	}



	//------------------- /givecash
	
	if(strcmp(cmd, "/givecash", true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givecash [playerid] [amount]");
			return 1;
		}
		giveplayerid = strval(tmp);
		
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givecash [playerid] [amount]");
			return 1;
		}
 		moneys = strval(tmp);
		
		//printf("givecash_command: %d %d",giveplayerid,moneys);
		
		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			if(dmPlayers[giveplayerid]==999) {
				playermoney = GetPlayerMoney(playerid);
				if (moneys > 0 && playermoney >= moneys) {
					GivePlayerMoney(playerid, (0 - moneys));
					GivePlayerMoney(giveplayerid, moneys);
					format(string, sizeof(string), "You have sent %s (id: %d), $%d.", giveplayer,giveplayerid, moneys);
					SendClientMessage(playerid, COLOR_YELLOW, string);
					format(string, sizeof(string), "You have recieved $%d from %s (id: %d).", moneys, sendername, playerid);
					SendClientMessage(giveplayerid, COLOR_YELLOW, string);
					printf("%s(playerid:%d) has transfered %d to %s(playerid:%d)",sendername, playerid, moneys, giveplayer, giveplayerid);
				}
				else {
					SendClientMessage(playerid, COLOR_YELLOW, "Invalid transaction amount.");
				}
			} else {
				format(string, sizeof(string), "%s is currently in a deathmatch. You cannot give them money at this time.", giveplayer);
				SendClientMessage(playerid, COLOR_YELLOW, string);				
			}
		}
		else {
				format(string, sizeof(string), "%d is not an active player.", giveplayerid);
				SendClientMessage(playerid, COLOR_YELLOW, string);
			}
		return 1;
	}

	//------------------- /hitman

	if(strcmp(cmd, "/hitman", true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /hitman [playerid] [amount]");
			return 1;
		}
		giveplayerid = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /hitman [playerid] [amount]");
			return 1;
		}
 		moneys = strval(tmp);
	
	    if(moneys > GetPlayerMoney(playerid)) {
			SendClientMessage(playerid, COLOR_RED, "You don't have enough money!");
			return 1;
	    }
	    if(moneys < 1) {
			SendClientMessage(playerid, COLOR_YELLOW, "Hey what are you trying to pull here.");
			return 1;
		}
		if(IsPlayerConnected(giveplayerid)==0) {
			SendClientMessage(playerid, COLOR_RED, "No such player exists.");
			return 1;
		}

		bounty[giveplayerid]+=moneys;
		GivePlayerMoney(playerid, 0-moneys);

		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		
//		format(string, sizeof(string), "You have put a $%d bounty on the head of %s (id: %d).", moneys, giveplayer,giveplayerid);
//		SendClientMessage(playerid, COLOR_YELLOW, string);

		format(string, sizeof(string), "%s has had a $%d bounty put on his head from %s (total: $%d).", giveplayer, moneys, sendername, bounty[giveplayerid]);
		SendClientMessageToAll(COLOR_ORANGE, string);

		format(string, sizeof(string), "You have had a $%d bounty put on you from %s (id: %d).", moneys, sendername, playerid);
		SendClientMessage(giveplayerid, COLOR_RED, string);
		
		return 1;
	}
	
	//------------------- /bounty

	if(strcmp(cmd, "/bounty", true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /bounty [playerid]");
			return 1;
		}
		giveplayerid = strval(tmp);
		
		if(IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			format(string, sizeof(string), "Player %s (id: %d) has a  $%d bounty on his head.", giveplayer,giveplayerid,bounty[giveplayerid]);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		} else {
			SendClientMessage(playerid, COLOR_RED, "No such player exists!");
		}
		
		return 1;
	}

	//------------------- /bounties

	if(strcmp(cmd, "/bounties", true) == 0)
	{
//		new tmp[256];
		new x;
	
		SendClientMessage(playerid, COLOR_GREEN, "Current Bounties:");
	    for(new i=0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && bounty[i] > 0) {
				GetPlayerName(i, giveplayer, sizeof(giveplayer));
				format(string, sizeof(string), "%s%s(%d): $%d", string,giveplayer,i,bounty[i]);

				x++;
				if(x > 3) {
				    SendClientMessage(playerid, COLOR_YELLOW, string);
				    x = 0;
					format(string, sizeof(string), "");
				} else {
					format(string, sizeof(string), "%s, ", string);
				}
			}
		}
		
		if(x <= 3 && x > 0) {
			string[strlen(string)-2] = '.';
		    SendClientMessage(playerid, COLOR_YELLOW, string);
		}
		
		return 1;
	}

	//------------------- /buy

	if(strcmp(cmd, "/buy", true) == 0) {
		new property=999;
		new previousowner;

		if(IsPlayerInCheckpoint(playerid)) {
			switch (playerCheckpoint[playerid]) {
				case CP_DRAGON:{
					property = P_DRAGON;
				}
				case CP_CALIGULA:{
					property = P_CALIGULA;
				}
				case CP_SEXSHOP:{
					property = P_SEXSHOP;
				}
				case CP_BAR:{
					property = P_BAR;
				}
				case CP_ZIP:{
					property = P_ZIP;
				}
				case CP_BINCO:{
					property = P_BINCO;
				}
				case CP_TATOO:{
					property = P_TATOO;
				}
				case CP_BOTIQUE:{
					property = P_BOTIQUE;
				}
				case CP_STRIPCLUB:{
					property = P_STRIPCLUB;
				}
				case CP_WANGCARS:{
					property = P_WANGCARS;
				}
				case CP_AIRSTRIP:{
					property = P_AIRSTRIP;
				}
				case CP_EMERALD:{
					property = P_EMERALD;
				}
				case CP_VISAGE:{
					property = P_VISAGE;
				}
				case CP_SPREADRANCH:{
					property = P_SPREADRANCH;
				}
			}

			if(property==999) {
				SendClientMessage(playerid, COLOR_YELLOW, "You need to be in a property checkpoint to /buy it.");
				return 1;
			}
			
//			property--;
			
			if(GetPlayerMoney(playerid) < propertyValues[property]) {
				SendClientMessage(playerid, COLOR_RED, "You don't have enough money to buy this property.");
				return 1;
			}
			if(propertyOwner[property]==playerid) {
				SendClientMessage(playerid, COLOR_RED, "You already own this property.");
				return 1;
			}

			GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
			if(propertyOwner[property] < 999) {
				GivePlayerMoney(propertyOwner[property], propertyValues[property]);
				format (string, sizeof(string), "Your property, the %s, has been bought out by %s (id: %d).",propertyNames[property],giveplayer,playerid);
				SendClientMessage(propertyOwner[property], COLOR_RED, string);
				previousowner = propertyOwner[property];
			}

			GivePlayerMoney(playerid, 0-propertyValues[property]);
			
			propertyOwner[property]=playerid;
			AutoLockCasinoVehicles(playerid);
			AutoLockCasinoVehicles(previousowner);
			
			format(string, sizeof(string), "You have purchased the %s!", propertyNames[property]);
			SendClientMessage(playerid, COLOR_GREEN, string);

			if(property==P_DRAGON || property==P_CALIGULA) {
				if(pbGameText) {
					format(string, sizeof(string),"~y~%s is the ~g~Pit Boss ~y~of %s",giveplayer,propertyNames[property]);
					GameTextForAll(string,5000,3);
				} else {
					format(string, sizeof(string),"%s is the Pit Boss of %s",giveplayer,propertyNames[property]);
					SendClientMessageToAll(COLOR_LIGHTBLUE, string);
				}
				format(string, sizeof(string),"Sir, your %s limousine's are now available to you and any gang members.",propertyNames[property]);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			}
		} else {
			SendClientMessage(playerid, COLOR_YELLOW, "You need to be in a property checkpoint to /buy it.");
			return 1;
		}


		return 1;
	}

	//------------------- /properties1

	if(strcmp(cmd, "/properties1", true) == 0 || strcmp(cmd, "/properties", true) == 0) {
		new propertiestemp = MAX_PROPERTIES;
		if(propertiestemp>9) {
			propertiestemp = 9;
		}
		SendClientMessage(playerid, COLOR_GREEN, "Property Set 1/2 Owners:");
		for(new i = 0; i < propertiestemp; i++) {
			if(propertyOwner[i] < 999) {
				GetPlayerName(propertyOwner[i], giveplayer, sizeof(giveplayer));
				format(string, sizeof(string), "%d. %s - %s", i, propertyNames[i], giveplayer);
			} else
				format(string, sizeof(string), "%d. %s - None", i, propertyNames[i]);

			SendClientMessage(playerid, COLOR_YELLOW, string);
		}

		return 1;
	}
	
	//------------------- /properties2

	if(strcmp(cmd, "/properties2", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN, "Property Set 2/2 Owners:");
		for(new i = 9; i < MAX_PROPERTIES; i++) {
			if(propertyOwner[i] < 999) {
				GetPlayerName(propertyOwner[i], giveplayer, sizeof(giveplayer));
				format(string, sizeof(string), "%d. %s - %s", i, propertyNames[i], giveplayer);
			} else
				format(string, sizeof(string), "%d. %s - None", i, propertyNames[i]);

			SendClientMessage(playerid, COLOR_YELLOW, string);
		}

		return 1;
	}
	
	//------------------- /buyweapon

	if(strcmp(cmd, "/buyweapon", true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /buyweapon [weapon number]");
			return 1;
		}
		weaponid = strval(tmp);

		if(IsPlayerInCheckpoint(playerid)==0 || playerCheckpoint[playerid]!=CP_AMMU) {
			SendClientMessage(playerid, COLOR_YELLOW, "You need to be in an Ammunation to purchase weapons.");
			return 1;
		}
		if(GetPlayerMoney(playerid) < spawnWeapons[weaponid][2]) {
			SendClientMessage(playerid, COLOR_RED, "You don't have enough money!");
			return 1;
		}
		if(weaponid < 0 || weaponid > MAX_SPAWNWEAPONS-1){
			SendClientMessage(playerid, COLOR_RED, "Invalid weapon number.");
			return 1;
		}
		
		format (string, sizeof(string), "You purchased 1 %s for when you spawn.",weaponNames[spawnWeapons[weaponid][0]]);
		SendClientMessage(playerid, COLOR_GREEN, string);
		
		GivePlayerWeapon(playerid, spawnWeapons[weaponid][0], spawnWeapons[weaponid][1]);
		playerWeapons[playerid][weaponid]++;
		
		GivePlayerMoney(playerid, 0-spawnWeapons[weaponid][2]);
		return 1;
	}

	//------------------- /weaponlist

	if(strcmp(cmd, "/weaponlist", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN, "Weapons List:");
		for(new i = 0; i < MAX_SPAWNWEAPONS; i++) {
			format (string, sizeof(string), "%d. %s - $%d",i,weaponNames[spawnWeapons[i][0]],spawnWeapons[i][2]);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
		return 1;
	}

	//------------------- /gang

	if(strcmp(cmd, "/gang", true) == 0) {
	    new tmp[256];
	    new gangcmd, gangnum;
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /gang [create/join/invite/quit] [name/number]");
			return 1;
		}
		giveplayerid = strval(tmp);
		
		if(strcmp(tmp, "create", true)==0)
		    gangcmd = 1;
		else if(strcmp(tmp, "invite", true)==0)
		    gangcmd = 2;
		else if(strcmp(tmp, "join", true)==0)
		    gangcmd = 3;
		else if(strcmp(tmp, "quit", true)==0)
		    gangcmd = 4;

		tmp = strtok(cmdtext, idx);
		if(gangcmd < 3 && !strlen(tmp)) {
		    if(gangcmd==0)
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /gang [create/join/invite/quit] [name/number]");
			else if(gangcmd==1)
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /gang [create] [name]");
			else if(gangcmd==2)
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /gang [invite] [playerID]");
			return 1;
		}
		
		//Create Gang//
		if(gangcmd==1) {
		    if(playerGang[playerid]>0) {
				SendClientMessage(playerid, COLOR_RED, "You are already in a gang!");
				return 1;
		    }
		    
			for(new i = 1; i < MAX_GANGS; i++) {
				if(gangInfo[i][0]==0) {
				    //name gang
					format(gangNames[i], MAX_GANG_NAME, "%s", tmp);
					//Gang exists
					gangInfo[i][0]=1;
					//There is one member
					gangInfo[i][1]=1;
					//Gang color is player's color
					gangInfo[i][2]=playerColors[playerid];

					//Player is the first gang member
					gangMembers[i][0] = playerid;
					format(string, sizeof(string),"You have created the gang '%s' (id: %d)", gangNames[i], i);
					SendClientMessage(playerid, COLOR_GREEN, string);

					playerGang[playerid]=i;

					return 1;
				}
			}
			
			return 1;
			
		//Join Gang//
		} else if (gangcmd==3) {
	 		gangnum = gangInvite[playerid];
	 		
		    if(playerGang[playerid]>0) {
				SendClientMessage(playerid, COLOR_RED, "You are already in a gang!");
				return 1;
		    }
	 		if(gangInvite[playerid]==0) {
				SendClientMessage(playerid, COLOR_RED, "You have not been invited to a gang.");
				return 1;
			}
			if(gangInfo[gangnum][0]==0) {
				SendClientMessage(playerid, COLOR_RED, "That gang does not exist!");
				return 1;
			}

			if(gangInfo[gangnum][1] < MAX_GANG_MEMBERS) {
			    new i = gangInfo[gangnum][1];
			    
				gangInvite[playerid]=0;

				gangMembers[gangnum][i] = playerid;

			    GetPlayerName(playerid, sendername, MAX_PLAYER_NAME);
				for(new j = 0; j < gangInfo[gangnum][1]; j++) {
					format(string, sizeof(string),"%s has joined your gang.", sendername);
					SendClientMessage(gangMembers[gangnum][j], COLOR_ORANGE, string);
				}
				
				gangInfo[gangnum][1]++;
				playerGang[playerid] = gangnum;

				AutoLockCasinoVehicles(playerid);

				SetPlayerColor(playerid,gangInfo[gangnum][2]);

				format(string, sizeof(string),"You have joined the gang '%s' (id: %d)", gangNames[gangnum], gangnum);
				SendClientMessage(playerid, COLOR_GREEN, string);

				return 1;
			}
			
			SendClientMessage(playerid, COLOR_RED, "That gang is full.");
			return 1;

		//Invite to Gang//
		} else if (gangcmd==2) {
	 		giveplayerid = strval(tmp);

			if(playerGang[playerid]==0) {
				SendClientMessage(playerid, COLOR_RED, "You are not in a gang!");
				return 1;
			}
//			if(gangMembers[playerGang[playerid]][0]!=playerid) {
//				SendClientMessage(playerid, COLOR_RED, "You need to be the gang leader to send an invite.");
//				return 1;
//			}

			if(IsPlayerConnected(giveplayerid)) {
				GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));

				format(string, sizeof(string),"You have sent a gang invite to %s.", giveplayer);
				SendClientMessage(playerid, COLOR_GREEN, string);
				format(string, sizeof(string),"You have recieved a gang invite from %s to '%s' (id: %d)", sendername, gangNames[playerGang[playerid]],playerGang[playerid]);
				SendClientMessage(giveplayerid, COLOR_GREEN, string);
				
				gangInvite[giveplayerid]=playerGang[playerid];

			} else
				SendClientMessage(playerid, COLOR_RED, "No such player exists!");
				
		//Leave Gang//
		} else if (gangcmd==4) {
		    PlayerLeaveGang(playerid);
		}
		
		return 1;
	}

	//------------------- /ganginfo

	if(strcmp(cmd, "/ganginfo", true) == 0) {
	    new tmp[256];
	    new gangnum;
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp) && playerGang[playerid]==0) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /ganginfo [number]");
			return 1;
		} else if (!strlen(tmp))
			gangnum = playerGang[playerid];
		else
			gangnum = strval(tmp);

		if(gangInfo[gangnum][0]==0) {
			SendClientMessage(playerid, COLOR_RED, "No such gang exists!");
			return 1;
		}

		format(string, sizeof(string),"'%s' Gang Members (id: %d)", gangNames[gangnum], gangnum);
		SendClientMessage(playerid, COLOR_GREEN, string);

		for(new i = 0; i < gangInfo[gangnum][1]; i++) {
			GetPlayerName(gangMembers[gangnum][i], giveplayer, sizeof(giveplayer));
			format(string, sizeof(string),"%s (%d)", giveplayer, gangMembers[gangnum][i]);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
		
		return 1;
	}

	//------------------- /gangs

	if(strcmp(cmd, "/gangs", true) == 0)
	{
		new x;

		SendClientMessage(playerid, COLOR_GREEN, "Current Gangs:");
	    for(new i=0; i < MAX_GANGS; i++) {
			if(gangInfo[i][0]==1) {
				format(string, sizeof(string), "%s%s(%d) - %d members", string,gangNames[i],i,gangInfo[i][1]);

				x++;
				if(x > 2) {
				    SendClientMessage(playerid, COLOR_YELLOW, string);
				    x = 0;
					format(string, sizeof(string), "");
				} else {
					format(string, sizeof(string), "%s, ", string);
				}
			}
		}

		if(x <= 2 && x > 0) {
			string[strlen(string)-2] = '.';
		    SendClientMessage(playerid, COLOR_YELLOW, string);
		}

		return 1;
	}
	
	return 0;
}

//------------------------------------------------------------------------------------------------------

public AutoLockCasinoVehicles(playerid)
{
	new owner, player, gang;
	new playername[MAX_PLAYER_NAME];
	new ownername[MAX_PLAYER_NAME];
	new string[256];

	if(IsPlayerConnected(playerid)) {
		for(new i=0; i<MAX_CASINO; i++) {
			owner = propertyOwner[i];
			if(owner!=999) {
				gang = playerGang[owner];
				if(gang>0) {
					for(new j=0; j<gangInfo[gang][1]; j++) {
						player = gangMembers[gang][j];
						if(IsPlayerConnected(player)) {
							SetVehicleParamsForPlayer(casinoVehicles[i][0],player, 0, 0);
							SetVehicleParamsForPlayer(casinoVehicles[i][1],player, 0, 0);
						}
					}
				} else {
					if(owner==playerid) {
						SetVehicleParamsForPlayer(casinoVehicles[i][0],playerid, 0, 0);
						SetVehicleParamsForPlayer(casinoVehicles[i][1],playerid, 0, 0);
					} else {
						new contract = random(30)*1000;
						GetPlayerName(owner, ownername, MAX_PLAYER_NAME);
						gang = playerGang[playerid];
						if(gang>0) {
							for(new j=0; j<gangInfo[gang][1]; j++) {
								player = gangMembers[gang][j];
								GetPlayerName(player, playername, MAX_PLAYER_NAME);
								if(IsPlayerConnected(player)) {
									SetVehicleParamsForPlayer(casinoVehicles[i][0],player, 0, 1);
									SetVehicleParamsForPlayer(casinoVehicles[i][1],player, 0, 1);
									if(IsPlayerInVehicle(player,casinoVehicles[i][0]) || IsPlayerInVehicle(player,casinoVehicles[i][1])) {
										if(GetPlayerState(player)==PLAYER_STATE_DRIVER) {
											format(string, sizeof(string),"%s has stolen a limousine. Pit boss %s has issued a $%d contract.",playername,ownername,contract);
										} else {
											format(string, sizeof(string),"%s is a passenger in a stolen limousine. Pit boss %s has issued a $%d contract.",playername,ownername,contract);
										}
										SendClientMessageToAll(COLOR_LIGHTBLUE, string);
										bounty[player]+=contract;
									}
								}
							}
						} else {
							GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
							SetVehicleParamsForPlayer(casinoVehicles[i][0],playerid, 0, 1);
							SetVehicleParamsForPlayer(casinoVehicles[i][1],playerid, 0, 1);
							if(IsPlayerInVehicle(playerid,casinoVehicles[i][0]) || IsPlayerInVehicle(playerid,casinoVehicles[i][1])) {
								if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER) {
									format(string, sizeof(string),"%s has stolen a limousine. Pit boss %s has issued a $%d contract.",playername,ownername,contract);
								} else {
									format(string, sizeof(string),"%s is a passenger in a stolen limousine. Pit boss %s has issued a $%d contract.",playername,ownername,contract);
								}
								SendClientMessageToAll(COLOR_LIGHTBLUE, string);
								bounty[playerid]+=contract;
							}
						}
					}
				}
			} else {
				SetVehicleParamsForPlayer(casinoVehicles[i][0],playerid, 0, 1);
				SetVehicleParamsForPlayer(casinoVehicles[i][1],playerid, 0, 1);
			}
		}
	}
}

//------------------------------------------------------------------------------------------------------

public SellWangExportVehicle(playerid) {
	new string[256];
	new wantedVehicle = -1;
	new i;
	for(i=0;i<MAX_WANGEXPORTVEHICLES;i++) {
		if(wantedWangExportVehicles[i]==wantedWangExportVehicle) {
			wantedVehicle = i;
			break;
		}
	}
	if(wantedVehicle>=0) {
		if(IsPlayerInAnyVehicle(playerid)) {
			if(vehicleModel[GetPlayerVehicleID(playerid)-1]==wantedWangExportVehicle) {
				if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER) {
					new payment = (random(20)+10)*1000;
					format(string, sizeof(string), "Excellent, we will export your %s at once! Here is $%d for your services.",wantedWangExportVehicleNames[i],payment);
					SendClientMessage(playerid, COLOR_GREEN, string);
					GivePlayerMoney(playerid, payment);
					SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				}
				SetPlayerPos(playerid, checkpoints[CP_WANGEXPORTS][0],checkpoints[CP_WANGEXPORTS][1],checkpoints[CP_WANGEXPORTS][2]);
			} else {
				SendClientMessage(playerid, COLOR_YELLOW, "Sorry, we're not buying that particular vehicle at this time.");
			}
		} else {
			format(string, sizeof(string), "We are currently buying %s's for export.",wantedWangExportVehicleNames[i]);
			SendClientMessage(playerid, COLOR_GREEN, string);
		}
	} else {
		SendClientMessage(playerid, COLOR_YELLOW, "Sorry, we're not buying any vehicles at this time.");
	}
	return 1;
}

//------------------------------------------------------------------------------------------------------

public OnPlayerEnterDeathmatch(playerid, gangnum, zone) {
	new string[256];
	new money = GetPlayerMoney(playerid);

	dmPlayers[playerid] = zone;
	if(IsPlayerInAnyVehicle(playerid)) {
		new vehicle = GetPlayerVehicleID(playerid);
		SetVehicleToRespawn(vehicle);
	}
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid,dmWeapons[zone][0],dmWeapons[zone][1]);
	if(money>0) {
		format(string, sizeof(string), "Your $%d has been deposited to your bank account.",money);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		GivePlayerMoney(playerid, 0-money);
		bank[playerid]+=money;
	}
	SendClientMessage(playerid, COLOR_YELLOW, "Any money you earn while in a deathmatch zone will be deposited to your bank account.");
	SetPlayerHealth(playerid,100);

	if(dmGangs[zone][0]==gangnum) {
		SetPlayerPos(playerid,dmSpawnCoords[zone][0],dmSpawnCoords[zone][1],dmSpawnCoords[zone][2]);
	} else {
		SetPlayerPos(playerid,dmSpawnCoords[zone][3],dmSpawnCoords[zone][4],dmSpawnCoords[zone][5]);
	}

	SetPlayerWorldBounds(playerid,dmCoords[zone][2],dmCoords[zone][0],dmCoords[zone][3],dmCoords[zone][1]);
	return 1;
}

//------------------------------------------------------------------------------------------------------

public OnPlayerText(playerid, text[])
{
	if(text[0] == '!') {
		if(playerGang[playerid] > 0) {
		    new gangChat[256];
		    new senderName[MAX_PLAYER_NAME];
		    new string[256];
		    
//		    for(new i = 1; i < strlen(text)+1; i++)
//				gangChat[i]=text[i];

			strmid(gangChat,text,1,strlen(text));
		    
			GetPlayerName(playerid, senderName, sizeof(senderName));
			format(string, sizeof(string),"%s: %s", senderName, gangChat);

			for(new i = 0; i < gangInfo[playerGang[playerid]][1]; i++) {
				SendClientMessage(gangMembers[playerGang[playerid]][i], COLOR_LIGHTBLUE, string);
			}
		}
		
		return 0;
	}
	return 1;
}

//------------------------------------------------------------------------------------------------------

public OnPlayerSpawn(playerid)
{
//	SetVehicleParamsForPlayer(CAR_MARKER_PIRATE,playerid,1,1);
//	SetVehicleParamsForPlayer(CAR_MARKER_STORE,playerid,1,1);

	AutoLockCasinoVehicles(playerid);

	if(GetPlayerMoney(playerid)>=0)
	{
		GivePlayerMoney(playerid, PocketMoney);
	}
	SetPlayerInterior(playerid,0);
	SetPlayerRandomSpawn(playerid);

	ResetPlayerWeapons(playerid);
	for(new i=0;i<MAX_SPAWNWEAPONS;i++) {
		if(playerWeapons[playerid][i] > 0) {
			GivePlayerWeapon(playerid,spawnWeapons[i][0],spawnWeapons[i][1]*playerWeapons[playerid][i]);
		}
	}
	//class weapon - why is this lost???
	GivePlayerWeapon(playerid,24,300);
	//OCHRANKA
	if(iPlayerRole[playerid]==2){
        GivePlayerWeapon(playerid,31,300);
        GivePlayerWeapon(playerid,28,400);
        GivePlayerWeapon(playerid,27,50);
	}

	dmWarning[playerid]=0;
	
	return 1;
}

/*public SetPlayerRandomSpawn(playerid)
{
	if (iSpawnSet[playerid] == 1)
	{
		new rand = random(sizeof(gCopPlayerSpawns));
		SetPlayerPos(playerid, gCopPlayerSpawns[rand][0], gCopPlayerSpawns[rand][1], gCopPlayerSpawns[rand][2]); // Warp the player
		SetPlayerFacingAngle(playerid, 270.0);
    }
    else if (iSpawnSet[playerid] == 0)
    {
		new rand = random(sizeof(gRandomPlayerSpawns));
		SetPlayerPos(playerid, gRandomPlayerSpawns[rand][0], gRandomPlayerSpawns[rand][1], gRandomPlayerSpawns[rand][2]); // Warp the player
	}
	return 1;
}*/
public SetPlayerRandomSpawn(playerid)
{
	if (iPlayerRole[playerid] == 1)
	{
		new rand = random(sizeof(gCopPlayerSpawns));
		SetPlayerPos(playerid, gCopPlayerSpawns[rand][0], gCopPlayerSpawns[rand][1], gCopPlayerSpawns[rand][2]); // Warp the player
		SetPlayerFacingAngle(playerid, 270.0);
    }
    else
	if (iPlayerRole[playerid] == 0)
    {
		new rand = random(sizeof(gRandomPlayerSpawns));
		SetPlayerPos(playerid, gRandomPlayerSpawns[rand][0], gRandomPlayerSpawns[rand][1], gRandomPlayerSpawns[rand][2]); // Warp the player
	}
	//ochranka
	if (iPlayerRole[playerid] == 2)
    {
		SetPlayerPos(playerid, -1537.0317,-430.1761,5.8516); // Warp the player
	}
	return 1;
}

//------------------------------------------------------------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
    new playercash;
	new killedplayer[MAX_PLAYER_NAME];
	new string[256];
	
	SetPlayerWorldBounds(playerid,20000.0000,-20000.0000,20000.0000,-20000.0000); //Reset world to player
	dmPlayers[playerid]=999;

	playercash = GetPlayerMoney(playerid);
	
	if(killerid == INVALID_PLAYER_ID)
	{
        SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
	}
	 else
	{
    	SendDeathMessage(killerid,playerid,reason);
		SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
		if(bounty[playerid] > 0 && (playerGang[killerid] == 0 || playerGang[playerid] != playerGang[killerid])) {
			GetPlayerName(playerid, killedplayer, sizeof(killedplayer));
			format(string, sizeof(string), "You earned a bounty of %d for killing %s.", bounty[playerid], killedplayer);
			SendClientMessage(killerid, COLOR_GREEN, string);

			GivePlayerMoney(killerid, bounty[playerid]);
			bounty[playerid] = 0;
		}
		if(playercash > 0)  {
			GivePlayerMoney(killerid, playercash);
		}
   	}
   	
   	if(playercash > 0)
   	{
	    ResetPlayerMoney(playerid);
    }
    
    //duel
    duelOnPlayerLeave(playerid);
    
 	return 1;
}

//------------------------------------------------------------------------------------------------------

public OnPlayerEnterCheckpoint(playerid)
{
	new string[256];
	new ownplayer[MAX_PLAYER_NAME];
	
	switch(getCheckpointType(playerid))
	{
		case CP_BANK: {
			SendClientMessage(playerid, COLOR_YELLOW, "You are at an ATM. To store money use '/bank amount', to withdraw");
			SendClientMessage(playerid, COLOR_YELLOW, "money use '/withdraw amount', and '/balance' to see your balance.");
		}
		case CP_PIRATE: {
			SendClientMessage(playerid, COLOR_YELLOW, "You can hold the pirate ship area to gain money.");
		}
		case CP_AMMU: {
			SendClientMessage(playerid, COLOR_GREEN, "You can purchase weapons here so that you have them every");
			SendClientMessage(playerid, COLOR_GREEN, "time you spawn. You can purchase more than once for more ammo.");
			SendClientMessage(playerid, COLOR_YELLOW, "Type /buyweapon [weapon number] and /weaponlist for a list of weapons.");
		}
		case CP_WANGEXPORTS: {
			SellWangExportVehicle(playerid);
		}
		case CP_HEAVENS: {
			SendClientMessage(playerid, COLOR_YELLOW, "It's a stairway to heaven baby.");
			SetPlayerPos(playerid,2096.1462,1285.2556,1000.000);
		}
		case CP_HELL: {
			SendClientMessage(playerid, COLOR_YELLOW, "It's a gateway to hell baby.");
			SetPlayerPos(playerid,-2458.7756,-1399.5762,1000.000);
		}
	}
	if(getCheckpointType(playerid)>= P_OFFSET) {
		format(string, sizeof(string), "You can buy the %s for $%d with /buy.", propertyNames[playerCheckpoint[playerid]-P_OFFSET], propertyValues[playerCheckpoint[playerid]-P_OFFSET]);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		format(string, sizeof(string), "You will earn $%d regularly.", propertyEarnings[playerCheckpoint[playerid]-P_OFFSET]);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		if(propertyOwner[playerCheckpoint[playerid]-P_OFFSET]<999) {
			GetPlayerName(propertyOwner[playerCheckpoint[playerid]-P_OFFSET], ownplayer, sizeof(ownplayer));
			format(string, sizeof(string), "This property is currently owned by %s.", ownplayer);
			SendClientMessage(playerid, COLOR_RED, string);
		}
	}
}

//------------------------------------------------------------------------------------------------------

/*public OnPlayerRequestClass(playerid, classid)
{
	if(classid == 0 || classid == 1 || classid == 2 || classid == 3 || classid == 4 || classid == 5 || classid == 6)
	{
		iSpawnSet[playerid] = 1;
	}
	else
	{
		iSpawnSet[playerid] = 0;
	}
	SetupPlayerForClassSelection(playerid);
	return 1;
}*/
public OnPlayerRequestClass(playerid, classid)
{
	if(classid == 0 || classid == 1 || classid == 2 || classid == 3 || classid == 4 || classid == 5 || classid == 6 )
	{
		iPlayerRole[playerid] = 1;
	}
	else
	{
		iPlayerRole[playerid] = 0;
	}
	//ochranka
	if(classid >= 144 && classid <= 147)
	{
		GameTextForPlayer(playerid,"~r~OCHRANKA",1000,1);
		iPlayerRole[playerid] = 2;
	}
	SetupPlayerForClassSelection(playerid);
	return 1;
}


public SetupPlayerForClassSelection(playerid)
{
 	SetPlayerInterior(playerid,0);
	SetPlayerPos(playerid,1256.1487,-791.2058,92.0313);
	SetPlayerFacingAngle(playerid, 28.4421);
	SetPlayerCameraPos(playerid,1254.3755,-787.7794,92.0302);
	SetPlayerCameraLookAt(playerid,1256.1487,-791.2058,92.0313);
}

public GameModeExitFunc()
{
	GameModeExit();
}

public OnGameModeInit()
{
	SetGameModeText("LV DM+GDM~MG+LG+PB(modify by SMRTAK)");

	ShowPlayerMarkers(1);
	ShowNameTags(1);

	// Player Class's
	AddPlayerClass(280,1958.3783,1343.1572,15.3746,270.1425,0,0,24,300,-1,-1);
	AddPlayerClass(281,1958.3783,1343.1572,15.3746,270.1425,0,0,24,300,-1,-1);
	AddPlayerClass(282,1958.3783,1343.1572,15.3746,270.1425,0,0,24,300,-1,-1);
	AddPlayerClass(283,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(284,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(285,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(286,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(287,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	
	AddPlayerClass(254,1958.3783,1343.1572,15.3746,0.0,0,0,24,300,-1,-1);
	AddPlayerClass(255,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(256,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(257,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(258,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(259,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(260,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(261,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(262,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(263,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(264,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(274,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(275,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(276,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	
	AddPlayerClass(1,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(2,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(290,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(291,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(292,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(293,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(294,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(295,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(296,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(297,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(298,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
    AddPlayerClass(299,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);

	AddPlayerClass(277,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(278,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(279,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(288,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(47,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(48,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(49,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(50,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(51,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(52,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(53,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(54,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(55,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(56,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(57,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(58,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(59,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(60,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(61,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(62,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(63,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(64,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(66,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(67,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(68,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(69,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(70,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(71,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(72,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(73,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(75,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(76,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(78,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(79,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(80,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(81,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(82,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(83,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(84,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(85,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(87,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(88,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(89,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(91,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(92,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(93,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(95,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(96,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(97,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(98,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(99,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(100,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(101,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(102,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(103,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(104,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(105,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(106,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(107,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(108,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(109,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(110,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(111,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(112,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(113,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(114,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(115,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(116,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(117,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(118,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(120,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(121,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(122,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(123,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(124,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(125,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(126,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(127,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(128,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(129,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(131,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(133,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(134,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(135,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(136,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(137,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(138,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(139,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(140,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(141,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(142,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(143,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	//ochranka
	AddPlayerClass(144,-1537.0317,-430.1761,5.8516,96.8039,31,300,24,300,28,400);
	AddPlayerClass(145,-1537.0317,-430.1761,5.8516,96.8039,31,300,24,300,28,400);
	AddPlayerClass(146,-1537.0317,-430.1761,5.8516,96.8039,31,300,24,300,28,400);
	AddPlayerClass(147,-1537.0317,-430.1761,5.8516,96.8039,31,300,24,300,28,400);

	//dalsi
	AddPlayerClass(148,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(150,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(151,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(152,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(153,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(154,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(155,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(156,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(157,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(158,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(159,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(160,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(161,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(162,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(163,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(164,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(165,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(166,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(167,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(168,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(169,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(170,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(171,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(172,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(173,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(174,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(175,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(176,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(177,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(178,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(179,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(180,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(181,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(182,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(183,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(184,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(185,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(186,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(187,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(188,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(189,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(190,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(191,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(192,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(193,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(194,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(195,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(196,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(197,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(198,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(199,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(200,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(201,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(202,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(203,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(204,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(205,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(206,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(207,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(209,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(210,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(211,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(212,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(213,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(214,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(215,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(216,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(217,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(218,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(219,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(220,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(221,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(222,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(223,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(224,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(225,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(226,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(227,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(228,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(229,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(230,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(231,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(232,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(233,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(234,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(235,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(236,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(237,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(238,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(239,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(240,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(241,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(242,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(243,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(244,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(245,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(246,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(247,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(248,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(249,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(250,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(251,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(253,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);

	// Car Spawns
	//---> LV
	// The Strip, Old Venturas Strip
	AddVehicle(409,2038.9760,1004.2764,10.4725,180.5512,0,0);     // Four Dragons Casino Limo (left)
	AddVehicle(409,2038.9464,1014.8927,10.4723,180.3020,0,0);     // Four Dragons Casino Limo (right)
	AddVehicle(409,2168.4163,1683.0472,10.6207,7.5586,1,1);       // Caligula's Casino Limo (left)
	AddVehicle(409,2167.8572,1672.6106,10.6220,342.3914,1,1);     // Caligula's Casino Limo (right)
	//AddVehicle(451,2123.1328,2356.9666,10.3785,270.9722,3,3);   // Emerald Isle Turismo (left)
	//AddVehicle(451,2132.3799,2357.1135,10.3784,269.3539,3,3);   // Emerald Isle Turismo (left)
	//AddVehicle(541,2032.8828,1911.7253,11.8778,180.5847,36,8);  // The Visage Bullet (left)
	//AddVehicle(541,2032.9601,1920.1212,11.8621,182.8593,36,8);  // The Visage Bullet (right)

	// Police Station
	AddVehicle(598,2269.1013,2460.0193,10.5665,1.8127,0,1); // 
	AddVehicle(598,2256.0642,2477.8748,10.5659,180.1925,0,1); // 
	AddVehicle(598,2277.5566,2477.5100,10.5655,181.4603,0,1); // 
	AddVehicle(598,2290.8252,2442.5459,10.5664,0.8304,0,1); // 
	AddVehicle(523,2273.4575,2443.2056,10.3913,358.3958,0,0); // 
	AddVehicle(523,2277.8516,2443.0400,10.3911,358.4349,0,0); // 
	AddVehicle(523,2277.1509,2430.7817,2.8431,12.9150,0,0); //
	AddVehicle(523,2272.7656,2430.9031,2.8389,14.5799,0,0); // 
	AddVehicle(598,2264.0320,2430.7473,3.0213,1.1038,0,1); // 
	AddVehicle(497,2092.6572,2415.2773,74.7654,268.4450,0,1); // polchopper

	// Airport
	AddVehicle(476,1280.7679,1324.7982,11.5296,271.5213,1,6); // 
	AddVehicle(476,1281.5981,1360.7289,11.5310,270.5776,1,6); // 
	AddVehicle(411,1309.6434,1279.0077,10.8123,358.3326,43,0); // 
	AddVehicle(553,1581.4080,1323.3933,12.1851,45.4289,38,9); // 
	AddVehicle(487,1601.6499,1627.3640,10.9989,203.7898,54,29); // 
	AddVehicle(487,1630.7175,1536.9312,10.9760,0.0009,26,57); // 
	AddVehicle(487,1666.0521,1632.2396,11.0244,226.1210,29,42); // 
	AddVehicle(488,1280.3417,1393.3505,10.9700,271.4767,2,29); // 

	// Misc
	AddVehicle(434,2078.4536,2416.5383,26.5907,268.9259,12,12); // 
	AddVehicle(506,2155.6711,2179.5710,10.3764,358.9250,7,7); // 
	AddVehicle(415,2103.5591,2066.0535,10.9383,269.1483,43,0); // 
	AddVehicle(480,2171.7354,1981.3954,10.5944,89.6501,51,51); // 
	AddVehicle(480,2135.9514,1398.1245,10.5931,0.6450,57,47); // 
	AddVehicle(480,2764.8193,1272.0735,10.5236,88.8599,79,79); // 
	AddVehicle(429,2074.9216,1492.4568,10.4249,1.2817,0,1); // 
	AddVehicle(415,2039.3994,1608.0022,10.4426,180.8127,75,1); // 
	AddVehicle(411,2039.3031,1322.4712,10.3990,180.7149,96,1); // 
	AddVehicle(411,2142.2039,1019.3549,10.5474,88.5775,6,1); // 
	AddVehicle(541,2132.9229,1025.6819,10.4453,268.2834,68,8); // 
	AddVehicle(535,2162.8530,1025.7147,10.5830,269.2941,55,1); // 
	AddVehicle(522,2125.7844,987.5491,10.3914,23.7679,51,118); // 
	AddVehicle(522,2122.2378,987.5867,10.3867,22.3758,36,105); // 
	AddVehicle(522,2352.3040,1404.9818,10.3863,244.2791,36,105); // 
	AddVehicle(567,2262.5303,1451.5692,13.7654,90.9435,54,75); // 
	AddVehicle(411,2039.6870,1545.2351,10.3990,2.4781,40,1); // 
	AddVehicle(420,1713.4498,1474.1285,10.5998,341.0948,6,1); // 
	AddVehicle(560,1666.6497,1297.9918,10.9148,358.4848,109,1); // 
	AddVehicle(400,1676.1722,1306.1077,10.6518,180.3893,30,30); // 
	AddVehicle(522,1669.8522,1316.7325,10.4078,344.0396,75,1); // 
	AddVehicle(481,2005.5536,1239.7672,10.3302,308.1699,65,9); // 
	AddVehicle(411,1913.0405,698.0679,10.9133,359.1315,41,41); // 
	AddVehicle(411,2212.4106,727.7373,10.8987,0.5340,112,1); // 
	AddVehicle(415,2442.1519,654.6589,10.9774,269.8957,0,1); // 
	AddVehicle(541,2714.1694,892.1317,10.5610,185.3413,2,2); // 
	AddVehicle(429,2783.8354,1973.7738,10.7229,140.3986,1,1); // 
	AddVehicle(402,2826.3005,2360.4773,10.5462,88.8986,101,1); // 
	AddVehicle(451,2793.2578,2428.0522,10.8787,314.5567,0,0); // 
	AddVehicle(461,2033.6586,2754.9363,10.4177,334.8470,66,1); // 
	AddVehicle(541,1601.0358,2674.0632,10.7575,164.4919,11,11); // 
	AddVehicle(565,1555.8459,2751.5300,10.4462,269.6317,62,62); // 
	AddVehicle(545,1597.0334,2834.4602,10.6313,0.0475,40,96); // 
	AddVehicle(451,1464.0612,2773.7410,10.3789,359.5333,61,61); // 
	AddVehicle(451,1118.4825,2088.6055,10.5226,97.3911,61,61); // 
	AddVehicle(521,1082.6248,1889.8755,10.7155,358.9037,65,79); // 
	AddVehicle(429,1372.0859,1904.3009,10.9363,89.5160,3,1); // 
	AddVehicle(558,992.1266,1886.5604,11.0969,93.6190,75,1); // 
	AddVehicle(415,954.7383,1806.6174,8.4207,270.9821,40,1); // 
	AddVehicle(400,701.6837,1946.9165,5.2751,1.4710,83,110); // 
	AddVehicle(521,691.3638,1947.5439,5.1051,357.1463,36,0); // 
	AddVehicle(482,1021.1492,1968.4868,11.2628,270.4432,10,10); // 
	AddVehicle(565,1907.0430,2082.3601,10.5742,255.3108,94,1); // 
	AddVehicle(603,2008.1945,2487.0833,10.6454,270.6761,11,11); // 
	AddVehicle(567,1900.6580,2403.5984,10.5247,82.2076,52,52); // 
	AddVehicle(522,2541.1194,2363.1489,3.7821,254.6702,39,106); // 
	AddVehicle(521,2511.9788,2369.3059,10.3847,289.2283,92,3); // 
	AddVehicle(506,2511.7473,2388.8484,10.5247,271.0111,52,52); // 
	AddVehicle(470,2530.6445,2506.2998,21.9769,267.9510,43,0); // 
	AddVehicle(411,2297.7175,2528.5786,10.5368,270.3729,22,22); // 
	AddVehicle(522,1893.8524,2115.7625,10.4177,359.9979,75,1); // 
	AddVehicle(545,1634.2186,2082.1187,10.9931,269.5952,53,53); // 
	AddVehicle(429,1512.3464,2001.3075,10.6885,180.2998,97,96); // 
	AddVehicle(541,1603.3695,1839.0663,10.5446,179.6657,2,78); // 
	AddVehicle(429,1623.2260,1850.8583,10.4452,1.6924,2,0); // 
	AddVehicle(402,1529.8992,1019.6284,10.5841,1.1433,97,1); // 
	AddVehicle(422,1413.9534,714.5236,10.8120,89.4846,16,0); // 
	AddVehicle(603,982.2697,1730.0231,8.3916,270.6754,51,1); // 
	AddVehicle(463,1021.3074,2020.6182,10.6648,262.1683,36,36); // 
	AddVehicle(461,1310.5831,2578.5259,10.4116,157.6011,36,1); // 
	AddVehicle(461,1234.3383,2606.2632,10.4020,64.9231,79,1); // 
	AddVehicle(411,1640.3064,2576.4785,10.5545,359.4968,106,1); // 
	AddVehicle(461,1636.1115,2576.2866,10.4060,6.8278,61,1); // 
	AddVehicle(603,2100.6445,1397.7743,10.6583,359.7213,45,45); // 
	AddVehicle(451,2603.4785,2142.9934,10.5252,89.5199,126,0); // 
	AddVehicle(541,2426.8665,2131.0986,10.3688,88.8057,58,8); // 
	AddVehicle(482,2561.9648,746.7307,10.9434,359.2504,64,64); // 
	AddVehicle(479,2361.7429,648.4590,11.1009,0.2114,54,31); // 
	AddVehicle(603,2114.4250,901.8270,10.6250,271.0256,37,0); // 
	AddVehicle(429,2393.7859,987.6761,10.5000,91.1308,2,1); // 
	AddVehicle(411,2492.3496,1232.0537,10.7027,92.0766,6,6); // 
	AddVehicle(415,2461.6316,1345.9426,10.5989,178.7844,62,1); // 
	AddVehicle(400,2441.6130,1351.7134,10.5474,89.8914,112,1); // 
	AddVehicle(558,2525.6709,1456.8545,10.4731,358.5329,36,1); // 
	AddVehicle(400,2470.4424,1428.6765,10.5533,177.9176,101,101); // 
	AddVehicle(480,2372.7192,1648.5884,10.9127,0.0007,101,1); // 
	AddVehicle(480,2363.4490,1668.6566,10.4784,270.2787,22,22); // 
	AddVehicle(400,2565.8206,1671.4277,10.5468,87.5994,53,1); // 
	AddVehicle(415,2186.9312,2000.2557,10.6915,269.8876,93,64); // 
	AddVehicle(522,2142.0264,1408.3706,10.4099,194.4707,61,1); // 
	AddVehicle(567,2075.4434,1005.0959,10.5453,0.6719,97,96); // 
	AddVehicle(565,2182.4255,1286.8412,10.3682,0.6061,10,10); // 
	AddVehicle(545,2619.3079,2099.2168,10.6276,359.8427,28,96); // 
	AddVehicle(506,2119.2561,1924.6890,10.3762,179.9013,3,3); // 
	AddVehicle(451,2507.0249,2131.2458,10.4495,90.6109,125,125); // 
	AddVehicle(541,2029.5710,1912.6765,11.9289,0.8390,58,8); // 
	AddVehicle(482,1471.4332,974.3174,10.9375,0.5948,48,48); // 
	AddVehicle(429,1661.8137,988.1861,10.5577,359.4649,12,1); // 
	AddVehicle(434,2612.5117,2258.4634,10.7843,268.9683,12,12); // 
	AddVehicle(451,2563.9819,2275.1680,10.5272,90.0273,36,36); // 
	AddVehicle(422,1624.0474,687.7905,10.4453,268.0920,8,8); // 
	AddVehicle(541,1399.5751,973.1689,10.4433,358.6299,58,8); // 
	AddVehicle(482,1727.6675,910.3063,10.4453,0.9494,58,8); // 
	AddVehicle(415,1881.7091,957.6345,10.4454,90.5756,58,8); // 
	AddVehicle(560,1881.5790,966.7969,10.4453,91.4834,7,7); // 
	AddVehicle(451,2038.7554,928.7838,8.9050,180.4548,60,60); // 
	AddVehicle(451,2217.1121,1838.6136,10.4453,178.6115,1,1); // 
	AddVehicle(400,2169.0996,1787.4244,10.4451,178.6473,0,0); // 
	AddVehicle(480,2440.7048,2013.0469,10.4452,90.3542,58,8); // 
	AddVehicle(463,2588.6907,2071.0215,10.4378,269.7279,0,0); // 
	AddVehicle(400,2821.8601,2161.4551,10.4452,267.4652,58,18); //
	AddVehicle(468,1876.2561,2674.1755,10.4693,91.1653,68,8); // 
	AddVehicle(429,1358.0430,2644.5254,10.4452,176.5554,68,8); // 
	AddVehicle(506,1963.8176,1098.2622,10.3688,88.4614,0,0); // 
	AddVehicle(400,2504.1506,1400.6128,10.4452,268.0431,36,36); // 
	AddVehicle(451,2476.1882,2496.6238,10.4453,0.7559,1,1); // 
	AddVehicle(541,2200.8469,2529.5012,10.4417,1.6308,2,1); // 
	AddVehicle(565,2095.8804,2413.5701,10.4454,268.4109,2,1); // 
	AddVehicle(451,2121.6719,2356.7603,10.2970,271.2130,17,17); // 
	AddVehicle(541,1976.4221,2049.4558,10.4451,92.4529,2,1); // 
	AddVehicle(482,1843.4327,2093.2883,10.4452,180.2701,10,10); // 
	AddVehicle(480,2648.8965,1083.5039,10.4452,180.1957,2,1); // 

	//--->LS
	// East Beach, Ganton, Willowfield
	AddVehicle(481,2650.0088,-2017.7560,13.0646,29.0515,74,1); // 
	AddVehicle(535,2685.0107,-2019.1812,13.3017,359.8802,31,1); // 
	AddVehicle(567,2785.0378,-1835.8467,9.3931,19.0242,37,1); // 
	AddVehicle(575,2741.5583,-1850.8942,9.4041,0.3303,28,1); // 
	AddVehicle(402,2503.3235,-1025.6926,69.8234,173.4962,26,96); // 
	AddVehicle(463,2491.5068,-1686.2706,13.0519,249.6828,84,84); // 

	// Airport
	AddVehicle(488,1972.3531,-2626.4558,14.0067,0.0064,58,8); // 
	AddVehicle(487,1950.7859,-2626.6453,13.7244,0.0010,29,42); // 

	//---> SF
	// Wang Cars
	AddVehicle(422,-2030.6837,178.8957,28.8258,269.7478,97,25); // 
	AddVehicle(429,-1949.4998,259.3121,40.7309,69.8158,13,13); // 
	AddVehicle(562,-1950.2374,268.5992,40.7105,123.1579,35,1); // 
	AddVehicle(415,-1987.0792,303.9890,34.9472,89.0182,25,1); // 
	AddVehicle(559,-1988.0957,273.5093,34.8319,84.0481,58,8); // 
	AddVehicle(560,-1948.2877,259.1573,35.1743,67.8661,9,39); // 
	AddVehicle(561,-1948.6843,273.2557,35.2867,124.6799,43,21); // 
	AddVehicle(558,-1947.0178,265.9857,35.1050,92.1937,116,1); // 
	AddVehicle(522,-1988.0233,300.5991,34.7454,75.9571,3,8); // 

	// Arch Angels
	AddVehicle(565,-2675.7153,204.8967,3.9608,0.5800,42,42); // 
	AddVehicle(562,-2663.0750,204.6316,3.9947,359.6160,102,1); // 

	// Police Station
	AddVehicle(497,-1679.2753,705.6859,30.7784,89.5848,0,1); // 
	AddVehicle(601,-1589.2710,708.3482,-5.4793,89.1182,1,1); // SWAT Van

	// Airport
	AddVehicle(519,-1369.3688,-231.3658,15.0668,287.6136,1,1); // 
	AddVehicle(519,-1340.6844,-256.7870,15.0787,359.7783,1,1); // 

	// Misc
	AddVehicle(495,-2133.3811,-923.3005,31.6483,270.1331,119,122); // 

	//---> Country/Desert (non main cities)
	// Restricted Area
	AddVehicle(548,291.2460,1921.7194,19.3292,0.0189,1,1); // 
	AddVehicle(568,275.8834,1963.5010,18.0796,243.1062,9,39); // 
	AddVehicle(470,274.5848,1954.6525,17.6337,289.9502,43,0); // 
	AddVehicle(470,276.2512,1948.9298,17.6354,316.9448,43,0); // 
	AddVehicle(470,275.2954,1994.8942,17.6343,255.0645,43,0); // 
	AddVehicle(470,276.9151,1984.6567,17.6347,299.7661,43,0); // 

	// Verdant Meadows Air Strip
	AddVehicle(468,432.9102,2537.1130,15.7590,142.1203,103,111); // 
	AddVehicle(476,290.8257,2540.9556,17.5273,181.2132,1,6); // 
	AddVehicle(476,325.8478,2541.2153,17.5251,180.5804,1,6); // 

	// Bone County
	AddVehicle(568,-367.2715,2218.3394,42.3572,64.5478,9,39); // 
	AddVehicle(495,-370.5393,2232.3438,42.8357,131.6836,119,122); // 

	// Road House
	AddVehicle(400,640.1936,1261.1899,12.6632,318.1856,62,77); // 
	AddVehicle(506,612.6583,1695.3147,6.6968,301.5790,76,76); // 
	AddVehicle(521,659.3052,1720.4465,6.5856,25.6903,72,1); // 

	// El Quebrados
	AddVehicle(422,-1567.0131,2640.4790,55.5524,270.6975,1,0); // 
	AddVehicle(400,-1486.3691,2688.9424,55.5903,179.8032,61,8); // 

	// Tierra Nobada
	AddVehicle(522,-1256.1470,2717.0349,49.6315,10.8651,8,82); // 
	AddVehicle(522,-1258.8401,2715.5261,49.6300,10.4651,6,25); // 
	AddVehicle(522,-1261.9171,2713.9377,49.6229,14.3367,3,3); // 
	AddVehicle(495,-681.7900,965.7326,12.5079,91.1233,119,122); // 

	// Valle Ocultado
	AddVehicle(539,-922.6368,2705.8784,41.8895,187.5998,61,98); // 
	AddVehicle(539,-918.9246,2706.3591,41.7437,188.2234,79,74); // 
	AddVehicle(539,-915.4460,2706.7656,41.7272,188.0342,96,67); // 

	// Fort Carson
	AddVehicle(463,81.3197,1165.8784,18.1918,332.3361,84,84); // 
	AddVehicle(463,76.8479,1165.7139,18.1974,347.5230,11,11); // 
	AddVehicle(482,97.1682,1060.8798,13.6953,218.7233,15,32); // 
	AddVehicle(422,113.6845,1060.4882,13.2982,176.2666,51,1); // 

	// Montgomery
	AddVehicle(463,1291.0779,341.4617,19.0949,237.2159,11,11); // 
	AddVehicle(463,1292.0476,343.6703,19.0877,239.8954,22,22); // 

	// Whetstone
	AddVehicle(468,-1539.0784,-2741.5198,48.2034,176.8269,6,6); // 
	AddVehicle(468,-1543.4103,-2739.8008,48.2043,174.6410,53,53); // 

	// Angel Pine
	AddVehicle(599,-2178.1401,-2370.9922,30.8200,142.7593,0,1); // 

	// Dillimore
	AddVehicle(415,652.0016,-560.5439,16.0959,358.8031,40,1); // 
	AddVehicle(400,748.9370,-582.0951,17.3157,270.2272,75,1); // 
	AddVehicle(599,612.9755,-601.6046,17.4305,89.9096,0,1); // 
	AddVehicle(463,668.3681,-470.8224,15.8764,250.8467,53,53); // 
	AddVehicle(468,668.1896,-467.7370,16.0010,251.8381,3,3); // 
	AddVehicle(522,668.1157,-461.5945,15.8983,256.0298,6,25); // 

	// Mount Chilliad
	AddVehicle(468,-2403.3167,-2179.3162,32.7640,258.5335,103,111); // 
	AddVehicle(468,-2404.0413,-2183.2051,32.7803,269.9269,66,71); // 

	// Misc Sea vehicles
	AddVehicle(460,1645.7194,583.3002,1.8784,179.1372,1,30); // 
	AddVehicle(446,1616.5696,586.4661,-0.5112,179.5861,1,44); // 
	AddVehicle(446,-426.3815,1170.4220,-0.5113,274.9250,1,53); // 
	AddVehicle(460,-623.0481,1940.8014,1.7043,165.0326,57,34); // 
	AddVehicle(446,-1173.3484,365.0544,0.0110,134.6141,56,15); // 
	AddVehicle(460,-1248.3275,983.0996,1.7858,315.3705,1,30); // 
	AddVehicle(446,-2099.7043,1416.2181,0.2422,178.9061,56,15); // 
	AddVehicle(446,-2203.1504,2419.9490,-0.3840,43.6997,1,53); // 
	AddVehicle(446,-2263.4724,2424.1611,-0.4167,226.2654,1,44); // 

	// In-game pickups
	AddStaticPickup(371, 15, 1710.3359,1614.3585,10.1191); //parachute
	AddStaticPickup(371, 15, 1964.4523,1917.0341,130.9375); //parachute
	AddStaticPickup(371, 15, 2055.7258,2395.8589,150.4766); //parachute
	AddStaticPickup(371, 15, 2265.0120,1672.3837,94.9219); //parachute
	AddStaticPickup(371, 15, 2265.9739,1623.4060,94.9219); //parachute
	AddStaticPickup(371, 15, 2301.8430,1298.3070,67.4688); //parachute
	AddStaticPickup(321, 22, 1212.4238,-34.9983,1000.9531); //dildo
	AddStaticPickup(321, 22, 1202.5164,11.0296,1000.9219); //dildo
	//AddStaticPickup(341,2,2527.1021,-1677.7054,19.9302); // chainsaw (ls)
	//AddStaticPickup(355,2,-1531.3032,687.3546,133.0514); // ak47 (sf)
	//AddStaticPickup(352,2,-127.2575,2258.3354,28.4193); // tech 9 (desert)
	//AddStaticPickup(356,2,1874.8624,2078.6260,16.0869); // mp4 (burger shot)
	//AddStaticPickup(361,2,-214.6140,1777.1444,102.1347); // flamethrower (desert cliff)
	//AddStaticPickup(353,2,2242.7139,1131.7731,10.8203); // mp5 (castle casino)
	//AddStaticPickup(1242,2,1643.5042,1673.4307,10.8203); // armour (lv airport)
	//AddStaticPickup(1242,2,-415.3339,1353.0487,12.8818); // armour (cave)
	//AddStaticPickup(1240,2,-413.8541,1346.3662,13.0434); // health (cave)
	AddStaticPickup(367, 15, 2097.9463,1160.1179,11.6484);	//camera (lv)
	AddStaticPickup(367, 15, -1954.8512,303.8038,41.0471);	//camera (sf)
	AddStaticPickup(367, 15, 2830.9158,-1875.0287,11.1049);	//camera (ls)
	
/*
	   //SF SALON
    AddVehicle(506,-1988.0621,260.5870,34.8360,85.3194,58,8); //
	AddVehicle(506,-1989.8890,252.4907,34.8281,91.7933,58,8); //
	AddVehicle(559,-1945.5182,260.9862,35.1251,98.5174,58,8); //
	AddVehicle(559,-1944.9082,269.8913,35.1303,127.2044,58,8); //
	AddVehicle(598,-1956.2609,264.3039,40.7739,157.2504,112,1); //
	AddVehicle(560,-1986.2206,241.2095,34.9280,178.5328,112,1); //
//	AddVehicle(571,-1968.4318,306.0425,34.8989,176.8656,3,0); //
//	AddVehicle(571,-1973.9335,306.0411,34.8993,177.6349,3,0); //
//	AddVehicle(571,-1977.9741,306.9793,34.8990,180.9476,3,0); //
	AddVehicle(560,-1989.0129,266.5294,34.8840,86.9628,41,29); //
	AddVehicle(560,-1988.6573,274.2037,34.8813,87.6094,41,29); //
	AddVehicle(560,-1989.8080,248.8328,34.8767,270.9730,41,29); //
	AddVehicle(560,-1956.9740,267.2586,35.1730,259.8907,41,29); //
	//AddVehicle(431,-2013.5542,84.6701,27.3907,173.5501,41,29); //buss
	AddVehicle(415,-1992.5892,101.4553,27.2434,273.6185,41,29); //

	AddVehicle(562,-1972.3071,242.6328,34.8797,4.9244,58,8); //
	AddVehicle(562,-1969.5133,242.3669,34.8843,358.5947,58,8); //
	AddVehicle(562,-1981.5055,243.2786,34.8762,1.0496,58,8); //
	AddVehicle(522,-1953.4897,300.6418,35.1734,90.3273,1,3); //
	AddVehicle(522,-1954.1561,295.8688,35.1733,89.5692,1,3); //
	AddVehicle(522,-1953.0272,291.8360,35.1734,90.5831,1,3); //
	AddVehicle(522,-1957.9965,305.3066,35.1730,357.3229,1,3); //
	AddVehicle(522,-1960.7324,305.9839,35.1781,359.9474,1,3); //
*/
	//mrakodrap
	AddStaticPickup(371, 2, 1537.4963,-1338.4032,330.0000); //para
	AddStaticPickup(371, 2, 1551.5488,-1338.8550,329.9241); //para
	AddStaticPickup(371, 2, 1562.4327,-1346.6812,329.9926); //para
	AddStaticPickup(371, 2, 1564.9810,-1359.0807,329.9926); //para
	AddStaticPickup(371, 2, 1557.7407,-1369.8779,330.0003); //para

	AddVehicle(560,1532.8462,-1310.1464,15.7714,265.7324,41,29);
	AddVehicle(560,1556.4845,-1310.3226,16.8394,270.4325,41,29);
	//hora
	AddStaticPickup(371, 2, -2233.3118,-1742.0326,480.8474); //para
	AddStaticPickup(371, 2, -2237.6833,-1745.5320,480.8568); //para

	AddVehicle(522,-2250.3816,-1726.6918,480.0524,40.4203,1,3);
	//ochranka
	AddVehicle(560,-1564.8549,-416.6711,5.7960,126.9454,0,0); //
	AddVehicle(560,-1561.3524,-423.0657,5.7671,127.3485,0,0); //

    AddStaticPickup(1242, 2, -1536.9955,-443.9548,6.0155); //veeta?
	//AddStaticPickup(351, 2, -1539.3059,-446.4327,6.0655); //brokovnice
    //AddStaticPickup(355, 2, -1537.3793,-448.5412,6.0960); //m4




		
	SetTimer("MoneyGrubScoreUpdate", 1000, 1);
	SetTimer("checkpointUpdate", 1100, 1);
	SetTimer("PirateShipScoreUpdate", 2001, 1);
	SetTimer("DeathmatchUpdate", 7003, 1);
	SetTimer("PropertyScoreUpdate", 40005, 1);
	SetTimer("GambleUpdate", 50013, 1);
	SetTimer("SavedUpdate",60017, 1);
	SetTimer("TimeUpdate",60009, 1);
	SetTimer("UnlockVehicleUpdate",120000, 1);

	//SetTimer("GameModeExitFunc", gRoundTime, 0);

	return 1;
}

public AddVehicle(modelid,Float:spawn_x,Float:spawn_y,Float:spawn_z,Float:z_angle,color1,color2) {
	vehicleModel[AddStaticVehicle(modelid,spawn_x,spawn_y,spawn_z,z_angle,color1,color2)-1]=modelid;
}

public SendPlayerFormattedText(playerid, const str[], define)
{
	new tmpbuf[256];
	format(tmpbuf, sizeof(tmpbuf), str, define);
	SendClientMessage(playerid, 0xFFFF00AA, tmpbuf);
}

public SendAllFormattedText(playerid, const str[], define)
{
	new tmpbuf[256];
	format(tmpbuf, sizeof(tmpbuf), str, define);
	SendClientMessageToAll(0xFFFF00AA, tmpbuf);
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

isStringSame(const string1[], const string2[], len) {
	for(new i = 0; i < len; i++) {
	    if(string1[i]!=string2[i])
	        return 0;
		if(string1[i] == 0 || string1[i] == '\n')
		    return 1;
	}
	return 1;
}




