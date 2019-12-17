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

#define PocketMoney 4000  // Amount player recieves on spawn.
#define INACTIVE_PLAYER_ID 255
#define GIVECASH_DELAY 5000 // Time in ms between /givecash commands.

#define NUMVALUES 4

#define CP_BANK 		0
#define CP_PIRATE 		1
#define CP_SKYSCARPER 	2
#define CP_ZOMBOTECH 	3
#define CP_AMMU     	4
#define CP_AMMU_2     	5
#define CP_BANK_2 		6
#define CP_BANK_3 		7
#define CP_LS_AIR 		8
#define CP_SF_AIR 		9
#define CP_LV_AIR 		10
#define CP_ALAHAM   	11
#define CP_DIDERSACHS   12
#define CP_BAR      	13
#define CP_HAIRSTUD 	14
#define CP_ZIP      	15
#define CP_BINCO    	16
#define CP_TATOO    	17
#define CP_GOLF 		18
#define CP_WANG 		19
#define CP_HOTEL 		20
#define CP_OTTOS 		21
#define CP_DRAGON       22
#define CP_CALIGULA     23
#define CP_SEXSHOP      24
#define CP_CATHAY     	25
#define CP_VERONA     	26
#define CP_ZERORC     	27
#define CP_JIZZYS     	28

#define P_ALAHAM    	0
#define P_DIDERSACHS  	1
#define P_BAR       	2
#define P_HAIRSTUD  	3
#define P_ZIP       	4
#define P_BINCO     	5
#define P_TATOO     	6
#define P_GOLF 			7
#define P_WANG 			8
#define P_HOTEL 		9
#define P_OTTOS 		10
#define P_DRAGON      	11
#define P_CALIGULA   	12
#define P_SEXSHOP    	13
#define P_CATHAY      	14
#define P_VERONA      	15
#define P_ZERORC     	16
#define P_JIZZYS      	17

#define P_OFFSET    11

forward MoneyGrubScoreUpdate();
forward Givecashdelaytimer(playerid);
//forward GrubModeReset();
forward SetPlayerRandomSpawn(playerid);
forward SetupPlayerForClassSelection(playerid);
forward GameModeExitFunc();

//------------------------------------------------------------------------------------------------------

new CashScoreOld;
new iSpawnSet[MAX_PLAYERS];
new bank[MAX_PLAYERS];
new bounty[MAX_PLAYERS];
new playerCheckpoint[MAX_PLAYERS];
new gambleWarning[MAX_PLAYERS];
new savePos;
new worldTime;

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

new Float:gRandomPlayerSpawns[78][3] = {
{2805.0862,-1180.9579,25.4536},
{2530.4785,-1063.5999,69.5695},
{-2275.2280,42.3125,35.3125},
{2042.9279,-1013.6509,39.7422},
{1497.0605,-689.1375,95.1092},
{1255.1125,-803.2986,84.1406},
{829.4501,-858.8712,70.1248},
{699.3003,-1059.2599,49.4217},
{299.0901,-1155.5858,80.9099},
{315.2544,-1772.5730,4.6776},
{-2062.5583,237.4662,35.7149},
{333.3540,-1519.2587,35.8672},
{763.0789,-1564.3256,13.5536},
{986.0850,-1095.0150,27.6041},
{1109.6948,-972.4279,42.7656},
{-2123.6570,-425.2528,35.5313},
{1438.9014,-927.2687,39.6406},
{1656.6252,-1076.3080,23.8984},
{1956.1605,-1116.0430,27.8305},
{-2653.6443,1388.2767,7.1301},
{2224.1555,-1240.3496,25.1478},
{2338.8757,-1289.3113,27.9766},
{-2838.1958,880.8605,44.0547},
{2436.4819,-1303.6724,24.6679},
{2450.9358,-1493.6650,24.0000},
{-2319.8889,578.0090,31.2498},
{2519.8420,-1678.7356,14.8524},
{2507.6228,-2019.1085,13.5469},
{-2642.2583,-274.9985,7.5393},
{1957.7228,-2183.6519,13.5469},
{1857.9117,-2042.3588,13.5469},
{-1771.3396,1205.8127,25.1250},
{1734.1467,-2099.2144,13.8666},
{2511.4326,-2589.3069,13.6443},
{2785.9890,-2417.7148,13.6341},
{2261.2937,-1930.7488,12.8935},
{2105.2878,-1913.1111,13.3828},
{-2157.2119,649.5484,52.3672},
{-2478.9902,1141.1311,55.7266},
{1833.2399,-1681.1813,13.4816},
{1665.9006,-1559.9375,13.5469},
{1125.5248,-1372.0935,13.9844},
{-2652.8887,1347.5245,7.1592},
{1289.0425,-1134.7928,23.8281},
{2842.1575,-1335.5879,14.7421},
{2767.4480,-1610.6735,10.9219},
{2753.1375,-1308.9150,53.0938},
{2789.2317,-2494.3286,13.6485},
{-1377.4271,466.0897,7.1875},
{1958.3783,1343.1572,15.3746},
{2199.6531,1393.3678,10.8203},
{2483.5977,1222.0825,10.8203},
{2637.2712,1129.2743,11.1797},
{2000.0106,1521.1111,17.0625},
{2024.8190,1917.9425,12.3386},
{-2569.5093,894.0370,64.9844},
{2261.9048,2035.9547,10.8203},
{2262.0986,2398.6572,10.8203},
{-2442.7913,752.1005,35.1786},
{2244.2566,2523.7280,10.8203},
{2335.3228,2786.4478,10.8203},
{-1754.9976,958.5851,24.8828},
{2150.0186,2734.2297,11.1763},
{2158.0811,2797.5488,10.8203},
{1969.8301,2722.8564,10.8203},
{-2790.7754,69.6904,7.2020},
{1652.0555,2709.4072,10.8265},
{1564.0052,2756.9463,10.8203},
{1271.5452,2554.0227,10.8203},
{1441.5894,2567.9099,10.8203},
{-2665.4282,635.6348,14.4531},
{1480.6473,2213.5718,11.0234},
{1400.5906,2225.6960,11.0234},
{-1939.9021,-858.7451,32.0234},
{1598.8419,2221.5676,11.0625},
{1318.7759,1251.3580,10.8203},
{-1660.7620,1207.0634,21.1563},
{1558.0731,1007.8292,10.8125}
};

new Float:gCopPlayerSpawns[6][3] = {
{1579.9010, -1636.5945, 13.5587},
{1525.2365, -1678.0016, 5.8906},
{2297.1064, 2452.0115, 10.8203},
{2297.0452, 2468.6743, 10.8203},
{-1635.0077, 665.8105, 7.1875},
{-1636.9252, 662.2247, 7.1875}
};


#define MAX_POINTS 29

new Float:checkCoords[MAX_POINTS][4] = {
{-36.5483,-57.9948, -17.2655,-49.2967},     	//BANK
{1894.6128,1445.3431, 2084.9739,1637.8186}, 	//LV_PIRATE
{1526.1332,-1370.5281,1558.4066,-1346.3019}, 	//LS_SKYSCARPER
{-2020.2151,593.7877,-1882.4504,745.5773}, 		//SF_ZOMBOTECH
{285.5186,-40.8558, 299.3870,-30.2428},     	//AMMUNATION
{284.0546,-86.4384, 302.9315,-56.6674},     	//AMMUNATION_2
{-37.2183,-91.8006, -14.1099,-74.6845},      	//BANK_2
{-34.6621,-31.4095, -2.6782,-25.6232},     		//BANK_3
{1406.4838,-2372.7078,1836.9307,-2205.9673},    //LS_AIRPORT
{-1720.8835,-692.9379,-1229.0609,-244.2898},    //SF_AIRPORT
{1631.2246,1319.9592,1815.6743,1549.8381},      //LV_AIRPORT
{473.8677,-24.4651, 503.5214,-10.7020},  		//ALHAMBRA
{200.4548,-168.0065, 211.3137,-156.5380},     	//DIDERSACHS
{487.6558,-88.5900, 512.0635, -67.7503},    	//BAR
{410.9893,-24.1658,415.1630,-12.6853}, 			//HAIRSTUD
{144.9131,-96.0927, 177.4128,-70.7923},    		//ZIP
{201.4462,-112.4556, 218.5237,-95.1238},    	//BINCO
{-204.7587,-27.0317, -200.2572,-22.7652},   	//TATOO
{-2815.8892,-330.0380,-2637.8352,-202.6930}, 	//SF GOLF CLUB
{-2014.8904,218.3705,-1900.5179,327.4985}, 		//SF WANG CARS
{-1804.7817,904.1232,-1682.8546,979.6241,}, 	//SF HOTEL
{-1681.0754,1168.9130,-1554.2562,1254.3335},  	//OTTO'S AUTOS
{1925.1511,968.2358, 2019.0715,1067.4276},  	//DRAGONS
{2216.7971,1638.0493, 2255.2097,1714.0806}, 	//CALIGULA
{-115.9544,-24.2706, -99.1631,-7.1391},     	//SEXSHOP
{954.5639,-1158.5366,1073.8862,-1086.4647},     //CATHAY
{1020.2889,-1581.0238,1214.4883,-1387.2167},    //VERONA
{-2240.6978,128.3114,-2224.1711,137.5221},     //ZERORC
{-2689.9849,1389.1598,-2631.0308,1431.7599}     //JIZZYS
};

new Float:checkpoints[MAX_POINTS][3] = {
{-22.2549,-55.6575,1003.5469},
{2000.3132,1538.6012,13.5859},
{1544.3478,	-1356.1665,	329.469},
{-1951.9886,686.6917,46.5625},
{291.1157,-39.9011,1001.5156},
{291.0004,-84.5168,1001.5156},
{-23.0664,-90.0882,1003.5469},
{-33.9593,-29.0792,1003.5573},
{1685.4951,-2333.1021,13.5469},
{-1423.1083,-289.5751,14.1484},
{1677.3966,1447.7908,10.7758},
{475.2822,-18.4801,1003.6953},
{204.0677,-157.7979,1000.5234},
{501.4927,-75.4323,998.7578},
{411.9587,-17.9706,1001.8047},
{161.1875,-79.9915,1001.8047},
{207.5640,-97.8188,1005.2578},
{-201.5237,-26.2863,1002.2734},
{-2724.3921,-314.7957,7.1861},
{-1957.3124,302.8924,35.4688},
{-1754.2139,960.2347,24.8828},
{-1660.4781,1218.4636,7.2500},
{1994.7078,1017.6371,994.8906},
{2235.5408,1679.0402,1008.3594},
{-103.9330,-21.0203,1000.7188},
{1022.7669,-1124.1028,23.8708},
{1129.0569,-1489.0812,22.7690},
{-2233.7097,133.7087,1035.4210},
{-2650.8259,1410.2885,906.2734}
};

new checkpointType[MAX_POINTS] = {
	CP_BANK,
	CP_PIRATE,
	CP_SKYSCARPER,
	CP_ZOMBOTECH,
	CP_AMMU,
	CP_AMMU_2,
	CP_BANK_2,
	CP_BANK_3,
	CP_LS_AIR,
	CP_SF_AIR,
	CP_LV_AIR,
	CP_ALAHAM,
	CP_DIDERSACHS,
	CP_BAR,
	CP_HAIRSTUD,
	CP_ZIP,
	CP_BINCO,
	CP_TATOO,
	CP_GOLF,
	CP_WANG,
	CP_HOTEL,
	CP_OTTOS,
	CP_DRAGON,
	CP_CALIGULA,
	CP_SEXSHOP,
	CP_CATHAY,
	CP_VERONA,
	CP_ZERORC,
	CP_JIZZYS
};

#define MAX_PROPERTIES 18

new propertyNames[MAX_PROPERTIES][32] = {
	"LS Alhambra Club",
	"Dider Sachs Boutiques",
	"Ten Green Bottles, Shithole Bar",
	"Hair Studios",
	"Zip Shops",
	"Binco Shops",
	"Tatoo Parlors",
	"SF Country Club",
	"SF Wang Cars",
	"SF Hotel",
	"SF Otto's Autos",
	"LV Four Dragons Casino",
	"LV Caligula Casino",
	"LV Sexshop",
	"LS Kathay Chineese Theatre",
	"LS Verona Mall",
	"SF Zero RC Shop",
	"SF Jizzy's Club"
};

new propertyValues[MAX_PROPERTIES] = {
	70000,
	100000,
	20000,
	30000,
	15000,
	15000,
	10000,
	220000,
	170000,
	200000,
	190000,
	75000,
	100000,
	25000,
	130000,
	150000,
	25000,
	70000
};

new propertyEarnings[MAX_PROPERTIES] = {
	4500,
	7000,
	1500,
	4000,
	1000,
	1000,
	700,
	14000,
	95000,
	12000,
	10000,
	5000,
	7000,
	2000,
	8500,
	9000,
	1500,
	4500
};

new propertyOwner[MAX_PROPERTIES] = {999,999,999,999,999,999,999,999,999,999,999,999,999,999,999,999,999,999};

#define MAX_WEAPONS 7
new weaponNames[MAX_WEAPONS][32] = {
	"Shotgun",
	"Combat Shotgun",
	"Micro Uzi",
	"Tec9",
	"MP5",
	"AK47",
	"M4"
};
new weaponIDs[MAX_WEAPONS] = {
	25,     //Shotgun
	27,     //Combat shotgun
	28,     //Micro Uzi
	32,     //Tec9
	29,     //MP5
	30,     //AK47
	31      //M4
};
new weaponCost[MAX_WEAPONS] = {
	7000,
	15000,
	7000,
	5000,
	15000,
	25000,
	30000
};
new weaponAmmo[MAX_WEAPONS] = {
	15,
	20,
	120,
	120,
	120,
	120,
	120
};
new playerWeapons[MAX_PLAYERS][MAX_WEAPONS];

#define MAX_CASINO      3
new Float:gambleAreas[MAX_CASINO][4] = {
	{1928.1771,987.5739, 1970.5675,1042.8369},
	{2171.3618,1584.2649, 2279.4915,1628.6199},
	{1117.5068,-11.2747, 1142.4843,12.5986}
};

#define MAX_SAVE 64
new savedInfo[MAX_SAVE][4];
new savedNames[MAX_SAVE][MAX_PLAYER_NAME];
new savedWeapons[MAX_SAVE][MAX_WEAPONS];

#define MAX_GANGS 			32
#define MAX_GANG_MEMBERS	6
#define MAX_GANG_NAME       16
new gangMembers[MAX_GANGS][MAX_GANG_MEMBERS];
new gangNames[MAX_GANGS][MAX_GANG_NAME];
new gangInfo[MAX_GANGS][3]; //0-created,1-members,2-color
new gangBank[MAX_GANGS];
new playerGang[MAX_PLAYERS];
new gangInvite[MAX_PLAYERS];

new gActivePlayers[MAX_PLAYERS];
new gLastGaveCash[MAX_PLAYERS];

//------------------------------------------------------------------------------------------------------

main()
{
		print("\n----------------------------------");
		print("  SAN ANDREAS DM ~MoneyGrub 0.5");
		print("   LVDM MoneyGrub Remake By");
		print("            Axel[Phoenix]");
		print("----------------------------------\n");
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
	if(X >= data[0] && X <= data[2] && Y >= data[1] && Y <= data[3]) {
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
}

//------------------------------------------------------------------------------------------------------

public PirateShipScoreUpdate()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 200);
		PayPlayerInArea(i, 1516.1332, -1380.5281, 1568.4066, -1336.3019, 200);
		PayPlayerInArea(i, -1988.4744, 639.1348, -1917.0579, 715.5820, 200);
//		{
//            SendClientMessage(i, COLOR_YELLOW, "You earned money for holding pirate ship area.");
//		}
	}
}

//------------------------------------------------------------------------------------------------------

public GambleUpdate()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i)) {
	        for(new j=0; j < MAX_CASINO; j++) {
	            if(isPlayerInArea(i,gambleAreas[j])) {
					gambleWarning[i]++;
					GameTextForPlayer(i,"~r~NO GAMBLING ~g~Gamblers will be ~r~SHOT",10000,5);
					if(gambleWarning[i] > 3) {
						SetPlayerHealth(i,0);
						ResetPlayerMoney(i);
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

			GivePlayerMoney(owners[i], payments[i]);

			format(string, sizeof(string), "You earned $%d from your properties.", payments[i]);
			SendClientMessage(owners[i], COLOR_GREEN, string);
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

	GameTextForPlayer(playerid,"~w~SA-MP: ~r~San Andreas ~g~MoneyGrub",5000,5);
		SendPlayerFormattedText(playerid, "              ~San Andreas MoneyGrub~", 0);
	SendClientMessage(playerid,0x00FF00FF,"type /help for some useful inforamtion");
	
	gActivePlayers[playerid]++;
	gLastGaveCash[playerid] = GetTickCount();

	playerCheckpoint[playerid]=999;
	bank[playerid]=0;
	playerGang[playerid]=0;
	gangInvite[playerid]=0;

	GetPlayerName(playerid, playrname, sizeof(playrname));
	for(new i = 0; i < MAX_SAVE; i++) {

	    if(isStringSame(savedNames[i], playrname, MAX_PLAYER_NAME)) {
			GivePlayerMoney(playerid, savedInfo[i][0]);
			bank[playerid] = savedInfo[i][1];
			bounty[playerid] = savedInfo[i][2];
			
			savedInfo[i][0]=savedInfo[i][1]=savedInfo[i][2]=0;
			savedNames[i][0]=0;

			for(new j = 0; j < MAX_WEAPONS; j++) {
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
	
	for(new i = 0; i < MAX_WEAPONS; i++)
		savedWeapons[savePos][i]=playerWeapons[playerid][i];
	//
	savePos++;
	if(savePos >= MAX_SAVE)
	    savePos = 0;

	PlayerLeaveGang(playerid);
	bounty[playerid] = 0;
	
	for(new i = 0; i < MAX_WEAPONS;i++) {
		playerWeapons[playerid][i]=0;
	}
}
//------------------------------------------------------------------------------------------------------

public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[256];
	new playermoney;
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new cmd[256];
	new giveplayerid, moneys, idx, weaponid;
	
	cmd = strtok(cmdtext, idx);
	
	//------------------- /help

	if(strcmp(cmd, "/help", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN,"San Andreas MoneyGrub(+LandGrab) Help");
		SendClientMessage(playerid, COLOR_YELLOW,"This is a freeroam gamemode where you can kill playes to receive their money. You can hold");
		SendClientMessage(playerid, COLOR_YELLOW,"certain places to gain money: Pirat Ship, Skyscarper rooof and Zombotech lobby. You can buy");
		SendClientMessage(playerid, COLOR_YELLOW,"properties in order to constantly gain money, go to the checkpoints in the interiors of");
		SendClientMessage(playerid, COLOR_YELLOW,"most stores in San Andreas for more information. You can visit ATMs in convenience stores");
		SendClientMessage(playerid, COLOR_YELLOW,"to bank your money. You can use the /hitman command to put a bounty on someone's head and");
		SendClientMessage(playerid, COLOR_YELLOW,"/givecash to send money to other players. Finally, you can purchase weapons in the");
		SendClientMessage(playerid, COLOR_YELLOW,"Ammunation that you will have every time you spawn and buy plane tickets at the Airport.");
		SendClientMessage(playerid, COLOR_ORANGE,"Type /commands for a full list of commands, and /gangcommands for a list of gang commands.");
		return 1;
	}
	if(strcmp(cmd, "/commands", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN,"Available commands:");
		SendClientMessage(playerid, COLOR_YELLOW,"/bank [amount], /withdraw [amount], /balance");
		SendClientMessage(playerid, COLOR_YELLOW,"/givecash [playerid] [amount]");
		SendClientMessage(playerid, COLOR_YELLOW,"/hitman [playerid] [amount]");
		SendClientMessage(playerid, COLOR_YELLOW,"/bounty [playerid]");
		SendClientMessage(playerid, COLOR_YELLOW,"/buy, /properties, /properties2");
		SendClientMessage(playerid, COLOR_YELLOW,"/buyweapon, /weaponist");
		SendClientMessage(playerid, COLOR_YELLOW,"/bounties, /gangs");
		SendClientMessage(playerid, COLOR_YELLOW,"/flylv, /flysf, /flyls");
		return 1;
	}
	if(strcmp(cmd, "/gangcommands", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN,"Gang commands:");
		SendClientMessage(playerid, COLOR_YELLOW,"/gang create [name]");
		SendClientMessage(playerid, COLOR_YELLOW,"/gang join");
		SendClientMessage(playerid, COLOR_YELLOW,"/gang invite [playerID]");
		SendClientMessage(playerid, COLOR_YELLOW,"/gang quit");
		SendClientMessage(playerid, COLOR_YELLOW,"/ganginfo [number] (no number given shows your gang's info)");
		SendClientMessage(playerid, COLOR_YELLOW,"/gbank [money] /gwithdraw [money] /gbalance");
		SendClientMessage(playerid, COLOR_YELLOW,"! (prefix text for gang-chat)");
		return 1;
	}
	//------------------- /flysf

			if(strcmp(cmd, "/flysf", true) == 0) {
	
			if (GetPlayerMoney(playerid) < 2500)
			{
				SendClientMessage(playerid,COLOR_RED,"You are out of cash.");
				return 1;
			}
			else if (IsPlayerInCheckpoint(playerid) == 0)
			{
			    SendClientMessage(playerid, COLOR_YELLOW, "You must be at a the LS or LV Airport to use this.");
				return 1;
			}
	        else if (getCheckpointType(playerid) == CP_SF_AIR)
			{
			    SendClientMessage(playerid, COLOR_YELLOW, "You must be at a the LS or LV Airport to use this.");
				return 1;
			}
			else if (GetPlayerMoney(playerid) > 2499 && getCheckpointType(playerid) == CP_LV_AIR && IsPlayerInCheckpoint(playerid) == 1)
			{
				GivePlayerMoney(playerid,-2500);
				SetPlayerPos(playerid,-1397.0,-317.0,14.0);
				SetPlayerFacingAngle(playerid,116.0);
				GameTextForPlayer(playerid,"~w~Welcome to the ~b~San Fierro~w~.",2000,5);
			}
			else if (GetPlayerMoney(playerid) > 2499 && getCheckpointType(playerid) == CP_LS_AIR && IsPlayerInCheckpoint(playerid) == 1)
			{
				GivePlayerMoney(playerid,-2500);
				SetPlayerPos(playerid,-1397.0,-317.0,14.0);
				SetPlayerFacingAngle(playerid,116.0);
				GameTextForPlayer(playerid,"~w~Welcome to the ~b~San Fierro~w~.",2000,5);
			}
			
		return 1;
		}
    //------------------- /flyls
        	if(strcmp(cmd, "/flyls", true) == 0) {
        	
			if (GetPlayerMoney(playerid) < 2500)
			{
				SendClientMessage(playerid,COLOR_RED,"You are out of cash.");
				return 1;
			}
        	else if (IsPlayerInCheckpoint(playerid) == 0)
			{
			    SendClientMessage(playerid, COLOR_YELLOW, "You must be at a the LV or SF Airport to use this.");
				return 1;
			}

        	else if (getCheckpointType(playerid) == CP_LS_AIR)
			{
			    SendClientMessage(playerid, COLOR_YELLOW, "You must be at a the LV or SF Airport to use this.");
				return 1;
			}

	    	else if (GetPlayerMoney(playerid) > 2499 && getCheckpointType(playerid) == CP_LV_AIR && IsPlayerInCheckpoint(playerid) == 1)
			{
				GivePlayerMoney(playerid,-2500);
				SetPlayerPos(playerid,1642.0,-2332.0,13.0);
				SetPlayerFacingAngle(playerid,360.0);
				GameTextForPlayer(playerid,"~w~Welcome to the ~b~Los Santos~w~.",2000,5);
			}
			else if (GetPlayerMoney(playerid) > 2499 && getCheckpointType(playerid) == CP_SF_AIR && IsPlayerInCheckpoint(playerid) == 1)
			{
				GivePlayerMoney(playerid,-2500);
				SetPlayerPos(playerid,1642.0,-2332.0,13.0);
				SetPlayerFacingAngle(playerid,360.0);
				GameTextForPlayer(playerid,"~w~Welcome to the ~b~Los Santos~w~.",2000,5);
			}
		return 1;
		}
  	//------------------- /flylv
    		if(strcmp(cmd, "/flylv", true) == 0) {
    	
			if (GetPlayerMoney(playerid) < 2500)
			{
				SendClientMessage(playerid,COLOR_RED,"You are out of cash.");
				return 1;
			}
    	    else if (IsPlayerInCheckpoint(playerid) == 0)
			{
			    SendClientMessage(playerid, COLOR_YELLOW, "You must be at a the LS or SF Airport to use this.");
				return 1;
			}
    		else if (getCheckpointType(playerid) == CP_LV_AIR)
			{
			    SendClientMessage(playerid, COLOR_YELLOW, "You must be at a the LS or SF Airport to use this.");
				return 1;
			}
			else if (GetPlayerMoney(playerid) > 2499 && getCheckpointType(playerid) == CP_SF_AIR && IsPlayerInCheckpoint(playerid) == 1)
			{
				GivePlayerMoney(playerid,-2500);
				SetPlayerPos(playerid,1704.0,1365.0,10.0);
				SetPlayerFacingAngle(playerid,354.0);
				GameTextForPlayer(playerid,"~w~Welcome to the ~b~Las Venturas~w~.",2000,5);
			}
			else if (GetPlayerMoney(playerid) > 2499 && getCheckpointType(playerid) == CP_LS_AIR && IsPlayerInCheckpoint(playerid) == 1)
			{
				GivePlayerMoney(playerid,-2500);
				SetPlayerPos(playerid,1704.0,1365.0,10.0);
				SetPlayerFacingAngle(playerid,354.0);
				GameTextForPlayer(playerid,"~w~Welcome to the ~b~Las Venturas~w~.",2000,5);
			}
			else if (GetPlayerMoney(playerid) < 2500)
			{
				SendClientMessage(playerid,COLOR_RED,"You are out of cash.");
			}
			
		return 1;
		}
	//------------------- /bank
	
	if(strcmp(cmd, "/bank", true) == 0 || strcmp(cmd, "/gbank", true) == 0) {
	    new gang;
	    if(strcmp(cmd, "/gbank", true) == 0)
	        gang = 1;
	
	    if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK && getCheckpointType(playerid) != CP_BANK_2 && getCheckpointType(playerid) != CP_BANK_3) {
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
	
	    if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK && getCheckpointType(playerid) != CP_BANK_2 && getCheckpointType(playerid) != CP_BANK_3 ) {
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
	
	    if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK && getCheckpointType(playerid) != CP_BANK_2 && getCheckpointType(playerid) != CP_BANK_3) {
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

		if(IsPlayerInCheckpoint(playerid)) {
			switch (playerCheckpoint[playerid]) {
				case CP_ALAHAM:{
					property = P_ALAHAM;
				}
				case CP_DIDERSACHS:{
					property = P_DIDERSACHS;
				}
				case CP_BAR:{
					property = P_BAR;
				}
				case CP_HAIRSTUD:{
					property = P_HAIRSTUD;
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
				case CP_GOLF:{
					property = P_GOLF;
				}
				case CP_WANG:{
					property = P_WANG;
				}
				case CP_HOTEL:{
					property = P_HOTEL;
				}
				case CP_OTTOS:{
					property = P_OTTOS;
				}
				case CP_DRAGON:{
					property = P_DRAGON;
				}
				case CP_CALIGULA:{
					property = P_CALIGULA;
				}
				case CP_SEXSHOP:{
					property = P_SEXSHOP;
				}
				case CP_CATHAY:{
					property = P_CATHAY;
				}
				case CP_VERONA:{
					property = P_VERONA;
				}
				case CP_ZERORC:{
					property = P_ZERORC;
				}
				case CP_JIZZYS:{
					property = P_JIZZYS;
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

			if(propertyOwner[property] < 999) {
				GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
				GivePlayerMoney(propertyOwner[property], propertyValues[property]);
				format (string, sizeof(string), "Your property, the %s, has been bought out by %s (id: %d).",propertyNames[property],giveplayer,playerid);
				SendClientMessage(propertyOwner[property], COLOR_RED, string);
			}

			GivePlayerMoney(playerid, 0-propertyValues[property]);
			
			propertyOwner[property]=playerid;
			
			format(string, sizeof(string), "You have purchased the %s!", propertyNames[property]);
			SendClientMessage(playerid, COLOR_GREEN, string);

		} else {
			SendClientMessage(playerid, COLOR_YELLOW, "You need to be in a property checkpoint to /buy it.");
			return 1;
		}


		return 1;
	}

	//------------------- /properties

	if(strcmp(cmd, "/properties", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN, "Property Owners List 1:");
		for(new i = 0; i < 8; i++) {
			if(propertyOwner[i] < 999) {
				GetPlayerName(propertyOwner[i], giveplayer, sizeof(giveplayer));
				format(string, sizeof(string), "%d. %s - %s", i, propertyNames[i], giveplayer);
			} else
				format(string, sizeof(string), "%d. %s - None", i, propertyNames[i]);

			SendClientMessage(playerid, COLOR_YELLOW, string);
		}

		return 1;
	}
	
	if(strcmp(cmd, "/properties2", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN, "Property Owners List 2:");
		for(new i = 9; i < 18; i++) {
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

		if(IsPlayerInCheckpoint(playerid)==0) {
			SendClientMessage(playerid, COLOR_YELLOW, "You need to be in an Ammunation to purchase weapons.");
			return 1;
		}
		if(playerCheckpoint[playerid]!=CP_AMMU && playerCheckpoint[playerid]!=CP_AMMU_2) {
			SendClientMessage(playerid, COLOR_YELLOW, "You need to be in an Ammunation to purchase weapons.");
			return 1;
		}
		if(GetPlayerMoney(playerid) < weaponCost[weaponid]) {
			SendClientMessage(playerid, COLOR_RED, "You don't have enough money!");
			return 1;
		}
		if(weaponid < 0 || weaponid > MAX_WEAPONS-1){
			SendClientMessage(playerid, COLOR_RED, "Invalid weapon number.");
			return 1;
		}
		
		format (string, sizeof(string), "You purchased 1 %s for when you spawn.",weaponNames[weaponid]);
		SendClientMessage(playerid, COLOR_GREEN, string);
		
		GivePlayerWeapon(playerid, weaponIDs[weaponid], weaponAmmo[weaponid]);
		playerWeapons[playerid][weaponid]++;
		
		GivePlayerMoney(playerid, 0-weaponCost[weaponid]);

		return 1;
	}

	//------------------- /weaponlist

	if(strcmp(cmd, "/weaponlist", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN, "Weapons List:");
		for(new i = 0; i < MAX_WEAPONS; i++) {
			format (string, sizeof(string), "%d. %s - $%d",i,weaponNames[i],weaponCost[i]);
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
//	SetVehicleParamsForPlayer(CAR_MARKER_SKYSCARPER,playerid,1,1);
//	SetVehicleParamsForPlayer(CAR_MARKER_STORE,playerid,1,1);

	if(GetPlayerMoney(playerid)>=0)
	{
		GivePlayerMoney(playerid, PocketMoney);
	}
	SetPlayerInterior(playerid,0);
	SetPlayerRandomSpawn(playerid);
	
	for(new i = 0; i < MAX_WEAPONS; i++) {
		if(playerWeapons[playerid][i] > 0) {
			GivePlayerWeapon(playerid,weaponIDs[i],weaponAmmo[i]*playerWeapons[playerid][i]);
		}
	}
	
	gambleWarning[playerid]=0;
	
	return 1;
}

public SetPlayerRandomSpawn(playerid)
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
}

//------------------------------------------------------------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
    new playercash;
	new killedplayer[MAX_PLAYER_NAME];
	new string[256];
	
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
		case CP_BANK_2: {
			SendClientMessage(playerid, COLOR_YELLOW, "You are at an ATM. To store money use '/bank amount', to withdraw");
			SendClientMessage(playerid, COLOR_YELLOW, "money use '/withdraw amount', and '/balance' to see your balance.");
		}
		case CP_BANK_3: {
			SendClientMessage(playerid, COLOR_YELLOW, "You are at an ATM. To store money use '/bank amount', to withdraw");
			SendClientMessage(playerid, COLOR_YELLOW, "money use '/withdraw amount', and '/balance' to see your balance.");
		}
		case CP_PIRATE: {
			SendClientMessage(playerid, COLOR_YELLOW, "You can hold the Pirate Ship area to gain money.");
		}
		case CP_SKYSCARPER: {
			SendClientMessage(playerid, COLOR_YELLOW, "You can hold the Skyscarper rooftop area to gain money.");
		}
		case CP_ZOMBOTECH: {
			SendClientMessage(playerid, COLOR_YELLOW, "You can hold the Zombotech Corp. lobby area to gain money.");
		}
		case CP_AMMU: {
			SendClientMessage(playerid, COLOR_GREEN, "You can purchase weapons here so that you have them every");
			SendClientMessage(playerid, COLOR_GREEN, "time you spawn. You can purchase more than once for more ammo.");
			SendClientMessage(playerid, COLOR_YELLOW, "Type /buyweapon [weapon number] and /weaponlist for a list of weapons.");
        }
        case CP_AMMU_2: {
			SendClientMessage(playerid, COLOR_GREEN, "You can purchase weapons here so that you have them every");
			SendClientMessage(playerid, COLOR_GREEN, "time you spawn. You can purchase more than once for more ammo.");
			SendClientMessage(playerid, COLOR_YELLOW, "Type /buyweapon [weapon number] and /weaponlist for a list of weapons.");
        }
		case CP_LS_AIR: {
			SendClientMessage(playerid, COLOR_YELLOW, "You are at the Airport. To buy a ticket to the San Fierro type /flysf");
			SendClientMessage(playerid, COLOR_YELLOW, "If you want to fly to the Las Venturas type /flylv. Ticket price - $2500.");
		
		}
		case CP_SF_AIR: {
			SendClientMessage(playerid, COLOR_YELLOW, "You are at the Airport. To buy a ticket to the Los Santos type /flyls");
			SendClientMessage(playerid, COLOR_YELLOW, "If you want to fly to the Las Venturas type /flylv. Ticket price - $2500.");

		}
		case CP_LV_AIR: {
			SendClientMessage(playerid, COLOR_YELLOW, "You are at the Airport. To buy a ticket to the Los Santos type /flyls");
			SendClientMessage(playerid, COLOR_YELLOW, "If you want to fly to the San Fierro type /flysf. Ticket price - $2500.");

		}
/*		case CP_DRAGON: {
			SendClientMessage(playerid, COLOR_YELLOW, "You can buy the Four Dragons Casino for $75,000 with /buy.");
			SendClientMessage(playerid, COLOR_YELLOW, "You will earn $5,000 regularly.");

		}
		case CP_SEXSHOP: {
			SendClientMessage(playerid, COLOR_YELLOW, "You can buy the Sex Shop for $25,000 with /buy.");
			SendClientMessage(playerid, COLOR_YELLOW, "You will earn $2,000 regularly.");
		}
		case CP_BAR: {
			SendClientMessage(playerid, COLOR_YELLOW, "You can buy the Shithole Bar for $20,000 with /buy.");
			SendClientMessage(playerid, COLOR_YELLOW, "You will earn $1,500 regularly.");
		}
		case CP_CALIGULA: {
			SendClientMessage(playerid, COLOR_YELLOW, "You can buy the Caligula Casino for $100,000 with /buy.");
			SendClientMessage(playerid, COLOR_YELLOW, "You will earn $7,000 regularly.");
		}
		case CP_ZIP: {
			SendClientMessage(playerid, COLOR_YELLOW, "You can buy the Zip clothes store for $15,000 with /buy.");
			SendClientMessage(playerid, COLOR_YELLOW, "You will earn $1,000 regularly.");
		}*/
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

public OnPlayerRequestClass(playerid, classid)
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
}

public SetupPlayerForClassSelection(playerid)
{
 	SetPlayerInterior(playerid,14);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerFacingAngle(playerid, 270.0);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1004.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
}

public GameModeExitFunc()
{
	GameModeExit();
}

public OnGameModeInit()
{
	SetGameModeText("sAn aND's DM~MG+Landgrab v0.5");

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
	AddPlayerClass(144,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(145,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(146,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
	AddPlayerClass(147,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);
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
	AddPlayerClass(0,1958.3783,1343.1572,15.3746,269.1425,0,0,24,300,-1,-1);

	// Car Spawns
	AddStaticVehicle(567,2508.2312,-1666.4536,13.1796,11.6929,-1,-1);
 	AddStaticVehicle(534,2473.1646,-1697.4138,13.2988,1.1746,-1,-1);
	AddStaticVehicle(482,2297.2532,-1633.3859,14.4298,269.4626,-1,-1);
	AddStaticVehicle(507,2158.4851,-1808.1165,13.4877,359.4795,-1,-1);
	AddStaticVehicle(562,2119.6868,-1782.6039,13.2567,179.7940,-1,-1);
	AddStaticVehicle(411,2069.0737,-1881.9088,13.1172,269.2706,-1,-1);
	AddStaticVehicle(603,2529.3069,-2003.3335,13.0598,133.2911,-1,-1);
	AddStaticVehicle(507,2498.8933,-1953.5988,13.3193,359.7628,-1,-1);
	AddStaticVehicle(439,2728.9031,-1935.3430,13.2556,90.0094,-1,-1);
	AddStaticVehicle(560,2854.1719,-1909.5021,10.5896,179.5905,-1,-1);
	AddStaticVehicle(477,2822.0244,-1553.3268,10.6042,89.4986,-1,-1);
	AddStaticVehicle(549,2742.9841,-1463.0424,30.2372,359.1269,-1,-1);
	AddStaticVehicle(475,2791.5891,-1284.7643,42.8108,178.8319,-1,-1);
	AddStaticVehicle(522,2806.3848,-1186.9303,25.0279,307.7415,-1,-1);
	AddStaticVehicle(451,2752.6775,-1177.2931,69.2420,89.6505,-1,-1);
	AddStaticVehicle(534,2322.5037,-1159.1552,26.7191,266.7604,-1,-1);
	AddStaticVehicle(567,2506.4182,-1287.6383,34.5474,178.1351,-1,-1);
	AddStaticVehicle(558,2432.1082,-1224.7516,24.8794,356.5074,-1,-1);
	AddStaticVehicle(480,2391.1511,-1497.3237,23.6727,89.4172,-1,-1);
	AddStaticVehicle(533,2489.6265,-1558.6204,23.5562,359.5309,-1,-1);
	AddStaticVehicle(470,2473.1877,-1545.3008,23.4819,181.2033,-1,-1);
	AddStaticVehicle(404,2106.5850,-1364.1143,23.8393,0.3906,-1,-1);
	AddStaticVehicle(580,2229.1389,-1363.6033,23.8190,89.8660,-1,-1);
	AddStaticVehicle(415,2235.8062,-1262.7324,23.4519,285.3175,-1,-1);
	AddStaticVehicle(542,2148.6777,-1138.4310,25.2664,270.0773,-1,-1);
	AddStaticVehicle(487,2148.7661,-1199.0145,23.4831,89.3399,-1,-1);//maverick chopper
	AddStaticVehicle(496,2031.4387,-1141.1813,24.3093,269.8185,-1,-1);
	AddStaticVehicle(445,1803.7166,-1931.8333,13.1109,359.8419,-1,-1);
	AddStaticVehicle(555,1779.4896,-1887.1788,13.2558,268.6338,-1,-1);
	AddStaticVehicle(535,1904.1558,-2047.0872,13.2997,90.4966,-1,-1);
	AddStaticVehicle(559,2757.5005,-2388.5466,13.6266,179.3206,-1,-1);
	AddStaticVehicle(579,2763.6816,-2510.6714,13.6339,0.0716,-1,-1);
	AddStaticVehicle(587,2488.0601,-2242.5610,13.4219,358.8076,-1,-1);
	AddStaticVehicle(491,2192.6189,-2247.0283,13.2067,222.6344,-1,-1);
	AddStaticVehicle(534,1981.1094,-1985.5371,13.2902,359.5516,-1,-1);
	AddStaticVehicle(405,1924.2258,-2122.6487,13.3471,359.0740,-1,-1);
	AddStaticVehicle(487,1972.9603,-2345.6387,13.7229,49.2012,-1,-1);//maverick chopper
	AddStaticVehicle(487,1974.8606,-2312.5300,13.7203,47.3370,-1,-1);//maverick chopper
	AddStaticVehicle(593,1960.2064,-2647.5012,14.0086,0.6559,-1,-1);//dodo plane
	AddStaticVehicle(519,1468.4178,-2436.6125,13.1128,244.4017,-1,-1);//shamal plane
	AddStaticVehicle(489,2657.2908,-1691.8491,9.0838,269.6595,-1,-1);
	AddStaticVehicle(585,1731.0698,-1008.6317,23.6590,347.0643,-1,-1);
	AddStaticVehicle(565,1713.7269,-1069.0457,23.5859,179.0714,-1,-1);
	AddStaticVehicle(602,1947.5813,-1376.5216,18.0939,57.1534,-1,-1);
	AddStaticVehicle(541,1974.1716,-1448.2616,13.0208,54.7374,-1,-1);
	AddStaticVehicle(402,1623.8126,-1858.7850,13.3271,180.6303,-1,-1);
	AddStaticVehicle(482,1646.7180,-1597.9443,13.1843,269.8346,-1,-1);
	AddStaticVehicle(596,1535.9027,-1673.6801,13.1024,0.9604,-1,-1);//cop car
	AddStaticVehicle(596,1585.8513,-1667.6764,5.6129,270.8032,-1,-1);//cop car
	AddStaticVehicle(507,1460.4645,-1506.9532,13.4812,87.2633,-1,-1);
	AddStaticVehicle(562,1333.5404,-1081.1383,24.8731,269.0622,-1,-1);
	AddStaticVehicle(411,1065.3420,-1221.7240,16.5594,0.1669,-1,-1);
	AddStaticVehicle(555,1146.9253,-1313.1802,14.0365,0.3839,-1,-1);
	AddStaticVehicle(400,867.5660,-1282.5898,14.8665,0.5736,-1,-1);
	AddStaticVehicle(603,840.1666,-1391.3821,13.2792,92.0202,-1,-1);
	AddStaticVehicle(507,1450.4374,-930.1359,36.6003,173.5922,-1,-1);
	AddStaticVehicle(487,1291.1396,-787.5708,96.6350,179.5610,-1,-1);//maverick chopper
	AddStaticVehicle(439,1351.2683,-621.1136,108.9058,19.9575,-1,-1);
	AddStaticVehicle(560,1363.1368,-1354.7874,13.2996,357.4546,-1,-1);
	AddStaticVehicle(477,685.3112,-1072.3215,49.2644,60.1660,-1,-1);
	AddStaticVehicle(549,283.8333,-1161.1090,80.7880,223.3897,-1,-1);
	AddStaticVehicle(475,405.2888,-1262.5371,50.5532,22.5417,-1,-1);
	AddStaticVehicle(506,782.5436,-1633.8582,13.1803,269.1530,-1,-1);
	AddStaticVehicle(451,1357.6841,-1748.9628,13.0077,89.7186,-1,-1);
	AddStaticVehicle(420,974.6000,-1106.2140,23.4440,56.1713,-1,-1);//car taxi
	AddStaticVehicle(480,660.3052,-1678.1238,14.1770,266.8718,-1,-1);
	AddStaticVehicle(533,1034.0940,-2042.7858,12.8263,167.7733,-1,-1);
	AddStaticVehicle(470,331.0582,-1883.9817,1.5477,134.3129,-1,-1);
	AddStaticVehicle(580,441.8103,-1303.0439,14.7358,245.0446,-1,-1);
	AddStaticVehicle(415,1246.0278,-2011.6395,59.6959,0.9539,-1,-1);
	AddStaticVehicle(542,1276.6846,-2010.6200,58.6758,178.7380,-1,-1);
	AddStaticVehicle(496,1271.2167,-2042.6799,59.0398,1.4495,-1,-1);
	AddStaticVehicle(522,545.3229,-1477.2467,14.4734,1.8863,-1,-1);
	AddStaticVehicle(555,1240.9360,-1566.8942,13.3638,87.8000,-1,-1);
	AddStaticVehicle(535,582.2130,-1885.4453,3.8559,220.5502,-1,-1);
	AddStaticVehicle(559,362.5190,-1641.1151,32.5754,83.0536,-1,-1);
	AddStaticVehicle(579,2088.4944,-2089.7324,14.1534,180.1658,-1,-1);
	AddStaticVehicle(587,166.3514,-1341.6031,69.3802,178.2354,-1,-1);
	AddStaticVehicle(491,797.0284,-843.6050,60.4141,191.0260,-1,-1);
	AddStaticVehicle(550,133.5142,-1489.0701,18.4300,58.3215,-1,-1);
	AddStaticVehicle(523,1560.7695,-1694.4358,5.6122,32.7235,-1,-1);//cop bike
	AddStaticVehicle(523,1563.5020,-1694.8240,5.4627,21.6809,-1,-1);//cop bike
	AddStaticVehicle(420,1713.9504,-2323.2983,12.9492,273.7584,-1,-1);//car taxi
	AddStaticVehicle(565,2489.3066,-2605.5688,13.3711,0.4802,-1,-1);
	AddStaticVehicle(596,1570.5022,-1710.5771,5.6091,179.8262,-1,-1);//cop car
	//Car Spawns Las Venturas
	AddStaticVehicle(567,2040.0520,1319.2799,10.3779,183.2439,-1,-1);
	AddStaticVehicle(558,2040.5247,1359.2783,10.3516,177.1306,-1,-1);
	AddStaticVehicle(602,2110.4102,1398.3672,10.7552,359.5964,-1,-1);
	AddStaticVehicle(541,2075.6038,1666.9750,10.4252,359.7507,-1,-1);
	AddStaticVehicle(402,2119.5845,1938.5969,10.2967,181.9064,-1,-1);
	AddStaticVehicle(482,1944.1003,1344.7717,8.9411,0.8168,-1,-1);
	AddStaticVehicle(562,2172.1682,1988.8643,10.5474,89.9151,-1,-1);
	AddStaticVehicle(411,2245.5759,2042.4166,10.5000,270.7350,-1,-1);
	AddStaticVehicle(400,2361.1538,1993.9761,10.4260,178.3929,-1,-1);
	AddStaticVehicle(603,2221.9946,1998.7787,9.6815,92.6188,-1,-1);
	AddStaticVehicle(507,2602.7769,1853.0667,10.5468,91.4813,-1,-1);
	AddStaticVehicle(439,2610.7600,1694.2588,10.6585,89.3303,-1,-1);
	AddStaticVehicle(560,2635.2419,1075.7726,10.5472,89.9571,-1,-1);
	AddStaticVehicle(477,2394.1021,989.4888,10.4806,89.5080,-1,-1);
	AddStaticVehicle(411,2039.1257,1545.0879,10.3481,359.6690,-1,-1);
	AddStaticVehicle(475,2009.8782,2411.7524,10.5828,178.9618,-1,-1);
	AddStaticVehicle(506,2076.4033,2468.7947,10.5923,359.9186,-1,-1);
	AddStaticVehicle(451,1919.5863,2760.7595,10.5079,100.0753,-1,-1);
	AddStaticVehicle(415,1673.8038,2693.8044,10.5912,359.7903,-1,-1);
	AddStaticVehicle(480,1591.0482,2746.3982,10.6519,172.5125,-1,-1);
	AddStaticVehicle(533,1455.9305,2878.5288,10.5837,181.0987,-1,-1);
	AddStaticVehicle(470,1537.8425,2578.0525,10.5662,0.0650,-1,-1);
	AddStaticVehicle(404,1433.1594,2607.3762,10.3781,88.0013,-1,-1);
	AddStaticVehicle(580,2223.5898,1288.1464,10.5104,182.0297,-1,-1);
	AddStaticVehicle(415,2461.8162,1629.2268,10.4496,181.4625,-1,-1);
	AddStaticVehicle(542,2395.7554,1658.9591,10.5740,359.7374,-1,-1);
	AddStaticVehicle(496,1553.3696,1020.2884,10.5532,270.6825,-1,-1);
	AddStaticVehicle(445,1383.4630,1035.0420,10.9131,91.2515,-1,-1);
	AddStaticVehicle(555,1445.4526,974.2831,10.5534,1.6213,-1,-1);
	AddStaticVehicle(535,1658.5463,1028.5432,10.5533,359.8419,-1,-1);
	AddStaticVehicle(559,1383.6959,1042.2114,10.4121,85.7269,-1,-1);
	AddStaticVehicle(579,1064.2332,1215.4158,10.4157,177.2942,-1,-1);
	AddStaticVehicle(522,1111.4536,1788.3893,10.4158,92.4627,-1,-1);
	AddStaticVehicle(550,1439.5662,1999.9822,10.5843,0.4194,-1,-1);
	AddStaticVehicle(405,2156.3540,2188.6572,10.2414,22.6504,-1,-1);
	AddStaticVehicle(598,2256.2891,2458.5110,10.5680,358.7335,-1,-1);//cop car
	AddStaticVehicle(598,2251.6921,2477.0205,10.5671,179.5244,-1,-1);//cop car
	AddStaticVehicle(523,2290.7268,2441.3323,10.3944,16.4594,-1,-1);//cop bike
	AddStaticVehicle(523,2295.5503,2455.9656,2.8444,272.6913,-1,-1);//cop bike
	AddStaticVehicle(420,2580.5320,2267.9595,10.3917,271.2372,-1,-1);//car taxi
	AddStaticVehicle(489,2827.4143,2345.6953,10.5768,270.0668,-1,-1);
	AddStaticVehicle(585,1670.1089,1297.8322,10.3864,359.4936,-1,-1);
	AddStaticVehicle(487,1614.7153,1548.7513,11.2749,347.1516,-1,-1);//maverick chopper
	AddStaticVehicle(593,1283.5107,1361.3171,9.5382,271.1684,-1,-1);//dodo plane
	AddStaticVehicle(593,1283.6847,1386.5137,11.5300,272.1003,-1,-1);//dodo plane
	AddStaticVehicle(565,1319.1038,1279.1791,10.5931,0.9661,-1,-1);
	AddStaticVehicle(534,2805.1650,2027.0028,10.3920,357.5978,-1,-1);
	AddStaticVehicle(567,2822.3628,2240.3594,10.5812,89.7540,-1,-1);
	AddStaticVehicle(558,2842.0554,2637.0105,10.5000,182.2949,-1,-1);
	AddStaticVehicle(602,2327.6484,2787.7327,10.5174,179.5639,-1,-1);
	AddStaticVehicle(541,2104.9446,2658.1331,10.3834,82.2700,-1,-1);
	AddStaticVehicle(402,1914.2322,2148.2590,10.3906,267.7297,-1,-1);
	AddStaticVehicle(482,1904.7527,2157.4312,10.5175,183.7728,-1,-1);
	AddStaticVehicle(507,1532.6139,2258.0173,10.5176,359.1516,-1,-1);
	AddStaticVehicle(562,1552.1292,2341.7854,10.9126,274.0815,-1,-1);
	AddStaticVehicle(411,1637.6285,2329.8774,10.5538,89.6408,-1,-1);
	AddStaticVehicle(400,1357.4165,2259.7158,10.9126,269.5567,-1,-1);
	AddStaticVehicle(603,1305.5295,2528.3076,10.3955,88.7249,-1,-1);
	AddStaticVehicle(507,993.9020,2159.4194,10.3905,88.8805,-1,-1);
	AddStaticVehicle(522,2299.5872,1469.7910,10.3815,258.4984,-1,-1);
	AddStaticVehicle(439,2404.6636,647.9255,10.7919,183.7688,-1,-1);
	AddStaticVehicle(560,2628.1047,746.8704,10.5246,352.7574,-1,-1);
	AddStaticVehicle(477,2817.6445,928.3469,10.4470,359.5235,-1,-1);
	AddStaticVehicle(420,661.7609,1720.9894,6.5641,19.1231,-1,-1);//car taxi
	AddStaticVehicle(549,660.0554,1719.1187,6.5642,12.7699,-1,-1);
	AddStaticVehicle(475,1031.8435,1920.3726,11.3369,89.4978,-1,-1);
	AddStaticVehicle(506,1641.6802,1299.2113,10.6869,271.4891,-1,-1);
	AddStaticVehicle(451,2135.8757,1408.4512,10.6867,180.4562,-1,-1);
	AddStaticVehicle(480,2461.7380,1345.5385,10.6975,0.9317,-1,-1);
	AddStaticVehicle(533,2804.4365,1332.5348,10.6283,271.7682,-1,-1);
	AddStaticVehicle(470,2805.1685,1361.4004,10.4548,270.2340,-1,-1);
	AddStaticVehicle(451,2119.9751,2049.3127,10.5423,180.1963,-1,-1);
	AddStaticVehicle(580,2785.0261,-1835.0374,9.6874,226.9852,-1,-1);
	AddStaticVehicle(420,1713.9319,1467.8354,10.5219,342.8006,-1,-1);//car taxi
	AddStaticVehicle(415,2038.1359,1009.4887,10.2686,178.2425,-1,-1);
	AddStaticVehicle(542,2142.2698,1019.3512,10.4130,91.3079,-1,-1);
	AddStaticVehicle(496,2075.0247,1149.5356,10.2645,2.6380,-1,-1);
	AddStaticVehicle(445,2132.7168,1028.6659,10.4175,275.6147,-1,-1);
	AddStaticVehicle(555,2004.5626,740.4858,10.6432,183.2937,-1,-1);
	AddStaticVehicle(535,1654.2909,730.8658,10.4145,5.3444,-1,-1);
	AddStaticVehicle(519,1323.9281,1573.8071,10.3853,271.3071,-1,-1);//shamal plane
    //Car Spawns San Fierro
	AddStaticVehicle(587,-2652.9031,-297.2605,8.0617,315.6009,-1,-1);
	AddStaticVehicle(491,-2618.9480,1376.7870,7.7322,181.1998,-1,-1);
	AddStaticVehicle(550,-2645.5964,1376.7522,7.8935,267.8349,-1,-1);
	AddStaticVehicle(405,-2126.2573,650.7344,53.2421,88.8335,-1,-1);
	AddStaticVehicle(522,-2223.2629,1083.2794,80.7819,359.6700,-1,-1);
	AddStaticVehicle(565,-2517.2996,1229.3512,38.7999,209.3221,-1,-1);
	AddStaticVehicle(534,-1654.1005,1211.9901,14.2380,315.9562,-1,-1);
	AddStaticVehicle(477,-1660.4161,1213.3704,8.0209,295.4768,-1,-1);
	AddStaticVehicle(558,-1497.4607,845.8477,7.9671,88.5197,-1,-1);
	AddStaticVehicle(602,-1699.4597,1035.9624,46.0932,91.6588,-1,-1);
	AddStaticVehicle(541,-1786.6871,1206.5266,25.7813,178.8742,-1,-1);
	AddStaticVehicle(482,-2438.0117,1340.9783,8.7316,86.7979,-1,-1);
	AddStaticVehicle(507,-2166.5498,1251.0760,28.2782,1.6030,-1,-1);
	AddStaticVehicle(562,-2636.3838,932.3286,72.5378,187.1212,-1,-1);
	AddStaticVehicle(411,-2464.8860,896.7036,63.6223,0.6326,-1,-1);
	AddStaticVehicle(400,-2459.9055,786.4501,36.2643,89.8722,-1,-1);
	AddStaticVehicle(603,-2673.5830,802.1517,51.0693,0.3607,-1,-1);
	AddStaticVehicle(507,-2970.6746,497.2838,1.3557,4.0073,-1,1);
	AddStaticVehicle(439,-2902.7820,342.5712,6.3723,138.7612,-1,-1);
	AddStaticVehicle(477,-1382.4279,455.8060,7.1838,359.9849,-1,-1);
	AddStaticVehicle(549,-1465.0304,455.6730,7.9280,358.9676,-1,-1);
	AddStaticVehicle(519,-1387.8518,-484.0513,15.6341,247.9289,-1,-1);//shamal plane
	AddStaticVehicle(519,-1317.8910,-260.4665,16.4827,288.2876,-1,-1);//shamal plane
	AddStaticVehicle(593,-1362.9397,-183.5522,16.4848,308.6994,-1,-1);//dodo plane
	AddStaticVehicle(487,-1222.7996,-10.4235,15.1594,45.5780,-1,-1);//maverick chopper
	AddStaticVehicle(475,-1872.5575,-820.7949,32.8273,90.7921,-1,-1);
	AddStaticVehicle(506,-1898.3019,-915.5814,33.3947,91.2857,-1,-1);
	AddStaticVehicle(451,-2124.4800,-929.0856,32.7397,269.1853,-1,-1);
	AddStaticVehicle(480,-2134.1428,-453.9576,36.1699,95.0875,-1,-1);
	AddStaticVehicle(533,-2035.6851,170.2529,29.4610,268.9087,-1,-1);
	AddStaticVehicle(470,-2352.0959,-126.8848,35.9374,179.5324,-1,-1);
	AddStaticVehicle(404,-2180.1277,41.8536,36.1953,269.9865,-1,-1);
	AddStaticVehicle(580,-2269.4526,69.5823,35.7279,89.6104,-1,-1);
	AddStaticVehicle(415,-2129.2864,787.6249,70.3666,87.1679,-1,-1);
	AddStaticVehicle(542,-2424.9958,740.8871,35.8205,177.6701,-1,-1);
	AddStaticVehicle(496,-2545.7666,627.5895,15.1684,89.1952,-1,-1);
	AddStaticVehicle(445,-2498.4822,357.5526,35.7969,58.0823,-1,-1);
	AddStaticVehicle(555,-2664.9673,268.9968,5.0156,357.6026,-1,-1);
	AddStaticVehicle(522,-2626.5276,-53.6779,5.1144,357.7703,-1,-1);
	AddStaticVehicle(559,-2487.5295,-125.3075,26.5715,90.9363,-1,-1);
	AddStaticVehicle(579,-2486.0298,51.5018,27.7954,177.2178,-1,-1);
	AddStaticVehicle(587,-2574.9736,146.5981,5.4279,1.8790,-1,-1);
	AddStaticVehicle(491,-1741.0009,811.0599,25.5879,270.6703,-1,-1);
	AddStaticVehicle(550,-1920.7559,875.2713,36.1113,270.0973,-1,-1);
	AddStaticVehicle(420,-2040.4465,1107.7076,54.4032,89.8491,-1,-1);//car taxi
	AddStaticVehicle(405,-1968.8488,465.6065,36.2766,89.3124,-1,-1);
	AddStaticVehicle(489,-1825.2035,-0.4858,15.8965,270.0104,-1,-1);
	AddStaticVehicle(585,-1687.9076,1003.5587,18.2656,91.3972,-1,-1);
	AddStaticVehicle(534,-2782.3508,442.1533,5.5383,57.1401,-1,-1);
	AddStaticVehicle(567,-2836.3665,865.6495,44.1470,268.7662,-1,-1);
	AddStaticVehicle(558,-2899.3823,1112.4786,27.3954,268.9744,-1,-1);
	AddStaticVehicle(602,-2618.7363,627.2617,15.6024,179.6464,-1,-1);
	AddStaticVehicle(541,-2151.4924,428.9210,35.1902,176.6156,-1,-1);
	AddStaticVehicle(482,-2641.7395,1333.0645,6.8700,356.7557,-1,-1);
	AddStaticVehicle(507,-2129.8242,288.0418,34.9864,269.9582,-1,-1);
	AddStaticVehicle(562,-2664.0950,-259.9579,6.5482,74.4868,-1,-1);
	AddStaticVehicle(597,-1594.2644,672.5858,6.9564,176.7420,-1,-1);//cop car
	AddStaticVehicle(597,-1622.6423,651.3411,6.9558,179.1608,-1,-1);//cop car
	AddStaticVehicle(597,-1584.1769,749.3150,-5.4735,1.1909,-1,-1);//cop car
	AddStaticVehicle(411,-1231.5951,48.1695,13.7616,229.8069,-1,-1);
	AddStaticVehicle(420,-1425.8613,-294.0004,13.5707,54.8251,-1,-1);//car taxi
	AddStaticVehicle(400,-2147.9944,-406.9189,35.0502,43.5458,-1,-1);
	AddStaticVehicle(415,-2899.2644,1112.4993,26.5128,270.6545,-1,-1);
	AddStaticVehicle(559,-1852.7903,569.7672,34.9839,223.2814,-1,-1);
	//boats
	AddStaticVehicle(493,720.9388,-1700.4620,-0.5290,35.6348,-1,-1);
	AddStaticVehicle(493,2355.2488,-2514.3970,-0.5287,158.8268,-1,-1);
	AddStaticVehicle(493,2364.3354,517.6652,-0.4520,89.2890,-1,-1);
	AddStaticVehicle(493,-1476.2301,691.7451,-0.4462,356.6588,-1,-1);
	//+ v0.3 added
	AddStaticVehicle(420,-1393.3545,-336.3529,13.8505,24.0909,-1,-1); // car taxi
	AddStaticVehicle(420,1660.3115,-2314.4729,13.2351,90.8312,-1,-1);
	AddStaticVehicle(405,1127.3945,-940.5890,42.5764,92.2462,-1,-1);
	//+ v0.4 added
	AddStaticVehicle(602,-2330.9387,558.7618,29.3441,270.7266,-1,-1);
	AddStaticVehicle(402,-2480.8093,1069.6036,55.6982,180.6722,-1,-1);
	AddStaticVehicle(411,-1954.0840,262.1563,40.7033,60.7457,-1,-1);
	AddStaticVehicle(475,-1722.1432,1345.3258,6.9462,45.2691,-1,-1);
	AddStaticVehicle(506,1596.8951,1850.6595,10.5247,0.1090,-1,-1);
	AddStaticVehicle(415,1316.5466,1933.3358,11.1649,179.9110,-1,-1);
	AddStaticVehicle(550,1040.6141,2298.2034,10.4479,91.5839,-1,-1);
	AddStaticVehicle(480,1461.3431,787.6978,10.5246,358.7591,-1,-1);
	AddStaticVehicle(477,2535.2056,2014.5221,10.5246,270.1910,-1,-1);
	AddStaticVehicle(580,1808.8506,-1718.1846,13.3794,0.0484,-1,-1);
	AddStaticVehicle(560,-2796.0449,88.3034,6.8933,91.3375,-1,-1);
	AddStaticVehicle(541,1560.3633,-2254.2666,13.1725,269.4279,-1,-1);
	AddStaticVehicle(420,-1384.6299,-375.4851,13.8536,4.7845,-1,-1); //  car taxi
	AddStaticVehicle(445,374.6159,-2031.1123,7.7402,359.6444,-1,-1);
	AddStaticVehicle(603,1062.9089,-1772.4189,13.0404,90.6724,-1,-1);
	AddStaticVehicle(580,1617.2734,-1293.5737,16.8480,89.0802,-1,-1);
	//+ v0.5 added
    AddStaticVehicle(402,-2248.0791,336.6792,34.3907,6.0747,-1,-1);

	//PICKUPS
	AddStaticPickup(371,2,-772.5848,2423.1196,157.0880); // sse_para
	AddStaticPickup(371,2,-809.8860,2429.0366,156.9699); // sse_para
	AddStaticPickup(371,2,-226.1909,1394.2926,172.4141); // bigear_para
	AddStaticPickup(371,2,-224.0347,1394.2474,172.4141); // bigear_para
	AddStaticPickup(371,2,2051.6555,2407.1292,150.4766); // emerald_para
	AddStaticPickup(371,2,-1753.7095,885.9033,295.8750); // para_pointy_build
	AddStaticPickup(371,2,-1520.9993,674.6617,139.2734); // bridge1_para
	AddStaticPickup(371,2,-1518.5388,677.5485,139.2734); // bringe1_para
	AddStaticPickup(371,2,-1532.2827,688.2155,133.0514); // bridge1_para
	AddStaticPickup(371,15,-2667.5481,1933.8230,181.5822); // bridge2_para2
	AddStaticPickup(371,15,-2667.5481,1933.8230,181.5822); // bridge2_para2
	AddStaticPickup(371,2,-2311.0059,-1572.5967,479.9083); // para_chill
	AddStaticPickup(371,2,-2264.2344,-1684.8676,481.1554); // parachute
	AddStaticPickup(371,2,-2230.6846,-1743.9265,480.8720); // parachute
	AddStaticPickup(371,2,-2255.2649,-1749.4268,487.5909); // parachute
	AddStaticPickup(371,2,-2432.3979,-1620.2229,526.8325); // parachute
	AddStaticPickup(371,2,1524.3611,-1358.8881,330.0000); // para_1
	AddStaticPickup(371,2,1537.5822,-1338.6387,329.9711); // para_2
	AddStaticPickup(371,2,1562.1649,-1346.8159,329.9346); // para_3
	AddStaticPickup(371,2,1557.6104,-1369.5931,329.8975); // para_4
	AddStaticPickup(371,2,1541.5498,-1364.5927,326.2109); // para_5
	
	SetTimer("MoneyGrubScoreUpdate", 1000, 1);
	SetTimer("checkpointUpdate", 1100, 1);
	SetTimer("PirateShipScoreUpdate", 2001, 1);
	SetTimer("PropertyScoreUpdate", 40005, 1);
	SetTimer("GambleUpdate", 5013, 1);
	SetTimer("SavedUpdate",60017, 1);
	SetTimer("TimeUpdate",60009, 1);

	//SetTimer("GameModeExitFunc", gRoundTime, 0);

	return 1;
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




