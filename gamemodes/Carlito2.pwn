//$ region includes
	#include <a_samp>
	#include <dudb>
	#include <dini>
	#include <dutils>
	#include <dcallbacks>
//	#include <dini>
//	#include <crash>
//	#include <danticheat>
//	#include <core>
//	#include <float>
//$ endregion includes
//$ region forwards
	forward Speedometer();
	forward SODA(playerid);
	forward SNACK(playerid);
	forward FASTFOOD(playerid);
	forward bizup();
	forward payup();
	forward profitup();
	forward ClearPlayerChatBox(playerid);
	forward GetVehicleType(vid);
	forward IsPlayerInArea(playerid, Float:minx, Float:maxx, Float:miny, Float:maxy, Float:minz, Float:maxz);
	forward fick(playerid);
	forward Menutimer(playerid);
	forward VEHICLEHEALTH();
	forward DestroyVehicleEx2(vehicleid);
	forward GetDistanceBetweenPlayers(playerid,playerid2);
	forward Float:GetDistanceToPoint(playerid,Float:x2,Float:y2,Float:z2);
	forward Float:checkpointGAScheck(player,Float:distOld2);
	forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
	forward getCheckpointType(playerID);
	forward checkpointupdate();
	forward CalculateSpeed(playerid);
	forward justbdown(playerid);
	forward public DestroyVehicleEx(vehicleid);
	forward Float:GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance);
	forward Float:GetXYInFrontOfObject(objectid, &Float:x, &Float:y, &Float:z, Float:distance);
	forward GetClosestObject(Float:x, Float:y, Float:z, &Object );
	forward GetPlayerDistanceToPointEx(playerid,Float:x,Float:y,Float:z);
	forward Float:GetPlayerDistanceToPoint(playerid,Float:x,Float:y,Float:z);
	forward GetVehicleWithinDistance( playerid, Float:x1, Float:y1, Float:z1, Float:dist, &veh);
	forward NextObject(oid);
	forward PreviousObject(oid);
	forward SelectObject(oid);
	forward InitiateSectorSystem();
	forward SectorScan();
	forward Float:GetPlayerArmourEx(p);
	forward PlayerPickUpPickupSetArmour(playerid, Float:playerarmour);
	forward PlayerPickUpPickupSetAmmo(playerid, slotid, slotammo);
	forward PickDestroy(o);
	forward GetKeys3(playerid);
	forward RotateObject(objectid,type);
	forward MoveObj(objectid,direction);
	forward GetKeys1(playerid);
	forward GetKeys2(playerid);
	forward SpawnObject(objectid);
	forward SaveObjects(playerid);
	//$ region carbot forwards
	forward Float:itan(Float:opp,Float:adj);
	forward ObjectUpdate();
	forward ObjectToObjectUpdate();
	forward Horn(playerid);
	//$ endregion carbot forwards
	//$ region Zombie forwards
	forward HoldingFire();
	forward zombieAtaca(playerid);
	forward attacknearest();
	forward QuitarArmasZombie(playerid);
	forward DevolverArmasZombie(playerid);
	forward CreateRandomZombie();
	forward CreateStreamVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2);
	forward DestroyStreamVehicle(svehicleid);
	forward LockCar(carid);
	forward UnLockCar(carid);
	forward LoadVehicle(svehicleid);
	forward StreamVehicles();
	forward GetLastPriority();
	forward LinkStreamVehicleToInterior(svehicleid,interiorid);
	forward SetStreamVehicleVirtualWorld(svehicleid,worldid);
	forward GetStreamVehicleVirtualWorld(svehicleid);
	forward GetStreamVehicleHealth(svehicleid, &Float:health2);
	forward SetStreamVehicleHealth(svehicleid,Float:health2);
	forward AddStreamVehicleComponent(svehicleid,componentid);
	forward RemoveStreamVehicleComponent(svehicleid,componentid);
	forward GetStreamVehicleModel(svehicleid);
	forward GetVehicleStreamID(vehicleid);
	forward ChangeStreamVehicleColor(svehicleid,color1,color2);
	forward ChangeStreamVehiclePaintjob(svehicleid,paintjobid);
	forward GetStreamVehiclePos(svehicleid, &Float:x, &Float:y, &Float:z);
	forward GetStreamVehicleZAngle(svehicleid, &Float:z_angle);
	forward SetStreamVehiclePos(svehicleid, Float:x, Float:y, Float:z);
	forward SetStreamVehicleZAngle(svehicleid, Float:z_angle);
	forward PutPlayerInStreamVehicle(playerid, svehicleid, seatid);
	forward SetStreamVehicleParamsForPlayer(svehicleid,playerid,objective,doorslocked);
	forward SetStreamVehicleNumberPlate(svehicleid, numberplate2[]);
	forward GetStreamVehicleColors(svehicleid,&color1,&color2);
	forward GetStreamVehiclePaintjob(svehicleid);
	//$ endregion Zombie forwards
//$ endregion forwards
//$ region defines
	#define line(%1,%2) for(new i=0; i<86; i++) msg[i] = ' '; msg[2] = %1; msg[xmax] = %2; for(new i=3; i<xmax; i++) msg[i] = 196; print(msg)
	#define line2(%1,%2) for(new i=0; i<86; i++) msg[i] = ' '; msg[2] = %1; msg[xmax] = %2; for(new i=3; i<xmax; i++) msg[i] = 205; print(msg)
	#define VTYPE_CAR 1
	#define VTYPE_HEAVY 2
	#define VTYPE_BIKE 3
	#define VTYPE_AIR 4
	#define VTYPE_SEA 5
	//$ region Colors
	#define COLOR_SYSTEM 0xEFEFF7AA
	#define COLOR_GREY 0xAFAFAFAA
	#define COLOR_GREEN 0x33AA33AA
	#define COLOR_RED 0xAA3333AA
	#define COLOR_YELLOW 0xFFFF00AA
	#define COLOR_PINK 0xFF66FFAA
	#define COLOR_BLUE 0x0000BBAA
	#define COLOR_LIGHTBLUE 0x33CCFFAA
	#define COLOR_DARKRED 0x660000AA
	#define COLOR_ORANGE 0xFF9900AA
	#define COLOR_BLACK 0x000000AA
	#define COLOR_WHITE 0xFFFFFFAA
	#define weiss	0xFFFFFFAA
	#define gelb 	0xFFFF00AA
	#define rot 	0xAA3333AA
	#define RED		0xFF0000AA
	#define GREEN	0x33AA33FF
	#define ORANGE	0xFF9900AA
	#define C 0xFFFFFFFF
	#define COLOR_NEUTRALGREEN 0x81CFAB00
	//$ endregion Colors
	#define MAX_PLAYER_NAME 255
	#define MAX_PLAYER_CARS 300 // Chenge this to set cars per player
	#define MAX_CARS 200
	#define MAX_POINTS 19
	#define MAX_POS 16
	#define PRECIOLITRO 20
	#define Gasstation0 0
	#define Gasstation1 1
	#define Gasstation2 2
	#define Gasstation3 3
	#define Gasstation4 4
	#define Gasstation5 5
	#define Gasstation6 6
	#define Gasstation7 7
	#define Gasstation8 8
	#define Gasstation9 9
	#define Gasstation10 10
	#define Gasstation11 11
	#define Gasstation12 12
	#define Gasstation13 13
	#define Gasstation14 14
	#define Gasstation15 15
	#define Gasstation16 16
	#define Gasstation17 17
	#define Gasstation18 18
	#define SLOTS 200
	#define MAX_SKINS 240
	//Timer Variables & Defines
	#define MENU_TIMER 500 //Sets interval for timer
	/// Menu Position Defines
	#define MENU_X 35.0
	#define MENU_Y 180.0
	#define SPACER 18
	#define MENU_WIDTH 205.0
	#define MENU_HEIGHT 50.0
	#define MAX_MENUG_ITEMS 3
	#define MAX_MENU_ITEMS 6
	// Menu Player Variables & Defines
	#define TOTAL_COLORS 128
	#define CURRENT 0
	#define END_CAR 1
	#define VIEW_DISTANCE 200
	#define MAX_COMPONENTS 17
	#define MAX_CAR_ITEMS 200
	#define MAX_TYPE_ITEMS 29
	#define MAX_OBJECTS2 100
	#define MAX_SECTORS 256
	#define MIN_RESPAWN_TIME 4500
	#define MAX_STREAM_PICKUPS 30000
	#define MAX_ACTIVE_PICKUPS 250
	#define MAX_SECTOR_PICKUPS 200
	#define MAX_HOUSES 2177
	#define MAX_SODA 40
	#define MAX_SNACK 26
	#define MAX_POS 16
	#define HOLDING(%0) \
				((newkeys & (%0)) == (%0))
	#define PRESSED(%0) \
				(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
	#define RELEASED(%0) \
				(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
	//$ region carbot
	#define MAX_CARBOTS 150
	#define MAX_DRIVEPOINTS 309
	#define MAX_DRIVEPOINTS2 27087
//	#define pi 3.14159265
	//$ endregion carbot
	//$ region Zombie defines
	#define PRESS 123
	#define HOLD 456
	#define MAX_ZOMBIES 100
	#define brazo1 1
	#define brazo2 2
	#define pierna1 4
	#define pierna2 8
	#define delay 500
	//$ endregion Zombie defines
	#define NOT_IN_CARGO "You need to be in a cargobob."
	#define ENTERED_CARGO "You entered the cargobob's back."
	#define TO_FAROF_CARGO "You need to be at a cargobob's back."
	#define SPAWN_DISTANCE 150
	#define MAX_ACTIVE_VEHICLES 1995
	#define MODEL_LIMIT 212
	#define MAX_ACTIVE_MODELS 150
	#define MAX_STREAM_VEHICLES 99999
	#define MAX_PRIORITY 100
//$ endregion defines
//$ region enum
	enum SavePlayerPosEnum {
	Float:LastX,
	Float:LastY,
	Float:LastZ
	};
	enum SPEEDO_PREF {
	bool:enabled,
	bool:metric
	};
	enum carDefinesE {
	ID,
	namec[40],
	Price,
	Fuel,
	Tank,
	typeName[40],
	type1
	};
	enum carTypesE {
	typeName[40],
	typenum,
	typeStart,
	typeEnd
	};
	enum puInfo {
	model,
	ptype,
	Float:x_spawn,
	Float:y_spawn,
	Float:z_spawn,
	spawned,
	idnum,
	valid,
	id_prev_used,
	};
	enum vInfo{
	CREATED,
	streamid,
	idnum,
	model,
	Float:veh_pos[4],
	colors[2],
	interior,
	world,
	Float:health,
	paintjob,
	numberplate[10],
	COMPONENTS[MAX_COMPONENTS],
	ownerid,
	owner[MAX_PLAYER_NAME],
	tank,
	meters,
	oilpress,
	oilminimum,
	oildamage,
	messagesend,
	messagesend2,
	messagesend3,
	locked,
	key,
	security,
	priority
	};
	enum houseinfo {
	Float:hx,
	Float:hy,
	Float:hz,
	Float:ha,
	hname[256],
	hminibet,
	hmaxbet,
	hminiskill,
	hmaxskill,
	inter,
	hprofit,
	hvirtual,
	people
	};
	enum player_info {
	object_id
	};
	//$ region Zombie enums
		enum weapParts{
			WeapId,
			allow,
			Float:range,
			Float:wide,
			damageMin,
			damageMax,
			cutting,
			instaGib,
			continua,
			mnsg[150]
		};
		enum zombiPos{
			partModel,
			Float:RelX,
			Float:RelY,
			Float:RelZ,
			Float:RelrX,
			Float:RelrY,
			Float:RelrZ
		};
		enum zpart{
			rLegZ,
			rArmZ,
			torsoZ,
			lArmZ,
			headZ,
			lLegZ
		};
		enum zombiParts{
			rArm,
			lArm,
			rLeg,
			lLeg,
			head,
			torso,
			pedazos,
			HP,
			Float:ArmAngle,
			Float:ArmStatus,
			Float:angulo,
			Float:speed,
			LegsH,
			undead,
			target
		};
		enum zArm{
			Float:AZ,
			Float:AA
		};
		enum tipo{
			der,
			izq
		};
		enum WeaponType{
			pWeapId,
			pAmmo
		};
		enum SavePlayerPosCbotEnum {
			Float:LastX,
			Float:LastY,
			Float:LastZ
		};
	//$ endregion Zombie enums
//$ endregion enum
//$ region new variables
	//$ region House-var
	//$ endregion House-var
	//$ region CargoBob
		new InCargoBob[MAX_PLAYERS];
		new CargoHours[MAX_PLAYERS];
		new CargoMinutes[MAX_PLAYERS];
		new bool:ObjectsAdded[MAX_PLAYERS];
	//$ endregion CargoBob
	//$ region Carbot variables
		new SavePlayerPosCbot[MAX_PLAYERS][SavePlayerPosCbotEnum];
		new tmpstring[256];
		//new drivepickup[MAX_DRIVEPOINTS2];
		//new drivearea[MAX_DRIVEPOINTS2];
		new bool:drivepbool=false;
		new Float:DrivePoints[309][3] ={
			{0.000000,0.000000,0.000000},
			{2069.030029,971.324890,10.424200},
			{2144.351318,970.795227,10.812700},
			{2069.661132,1187.941528,10.671898},
			{2071.963867,1026.744018,10.671898},
			{2126.911865,1066.955810,11.838998},
			{2188.838623,1189.775878,10.979700},
			{2052.779296,1187.068115,10.671898},
			{2048.159667,1093.402709,10.671898},
			{2043.992187,1032.449951,10.671898},
			{2046.442382,977.030090,10.580598},
			{2006.638549,971.694091,10.671898},
			{2159.938232,1101.943359,12.630000},
			{2185.692626,1153.818481,11.680898},
			{1873.186035,1095.756103,10.793684},
			{1865.289916,1091.136840,10.794721},
			{1874.850830,1090.285156,10.770083},
			{1867.198730,934.215698,10.671875},
			{2006.478149,931.857543,10.671875},
			{2011.241210,967.305847,10.671875},
			{2037.783325,970.329284,10.507884},
			{2003.139038,937.727172,10.671875},
			{1872.371704,936.894714,10.671875},
			{1869.834838,1085.519409,10.729228},
			{2144.687500,917.524841,10.767271},
			{2187.822509,914.170898,10.820311},
			{2151.767089,917.562438,10.793498},
			{2149.860839,952.868957,10.787966},
			{2149.853271,966.189697,10.744853},
			{2157.733398,970.465637,10.677720},
			{2147.875000,976.265014,10.751502},
			{2167.660400,969.935180,10.753146},
			{2281.477294,970.899658,10.764949},
			{2170.347412,985.073303,10.820311},
			{2173.053466,975.861877,10.770638},
			{2179.443603,1003.784118,10.820311},
			{2178.500976,1022.084411,10.820311},
			{2172.965576,1039.077636,10.820311},
			{2161.269531,1038.984741,10.820311},
			{2155.255859,1026.785766,10.820311},
			{2155.206542,1003.931823,10.820311},
			{2164.738281,983.897705,10.741579},
			{2157.624267,976.182800,10.674760},
			{2284.895019,962.699096,10.671875},
			{2284.563232,930.597778,10.778841},
			{2264.391601,921.592224,10.661478},
			{2231.527832,906.612121,9.794798},
			{2196.035156,880.643676,7.541965},
			{2158.802734,859.382446,6.734375},
			{2113.062500,854.929931,6.734375},
			{2069.771484,863.572448,6.745526},
			{2062.928222,969.428710,10.461606},
			{2056.768554,973.553894,10.524024},
			{2033.244995,976.392944,10.598347},
			{2063.217041,1026.975219,10.671875},
			{2076.850097,1037.286865,10.791381},
			{2104.651123,1043.682373,10.690179},
			{2144.659912,1074.769165,12.400374},
			{2062.696044,1186.390625,10.671875},
			{2038.739990,1090.401489,10.681414},
			{2051.545410,1000.957336,10.671875},
			{2081.509033,1196.425048,10.679657},
			{2055.149414,978.750488,10.609047},
			{2078.027099,971.180297,10.771459},
			{2077.330078,976.587341,10.802631},
			{2182.587890,1190.138549,10.937080},
			{2180.015136,1149.603149,11.977753},
			{2146.485839,1084.896118,12.590996},
			{2051.031250,953.363952,10.121750},
			{2044.699707,953.702270,10.129933},
			{2052.154785,861.676269,6.734375},
			{2044.633056,861.716491,6.734375},
			{2053.101074,843.497131,6.703125},
			{2142.398193,831.274353,6.734375},
			{2183.094238,814.624267,6.733025},
			{2224.955322,783.394836,9.557232},
			{2257.703369,764.499816,10.566732},
			{2281.948730,760.858398,10.912244},
			{2289.442138,773.040344,10.674028},
			{2289.598876,837.482666,14.631114},
			{2289.855224,919.081542,10.928419},
			{2290.688720,968.490783,10.800736},
			{2274.611572,976.385742,10.671875},
			{2176.732177,1196.038574,10.671875},
			{2189.875976,1203.522827,10.671875},
			{2184.529296,1198.758300,10.903369},
			{2190.165527,1368.243530,10.812524},
			{2184.708496,1368.115356,10.813219},
			{2176.955566,1370.806396,10.679672},
			{2178.377685,1375.660034,10.697630},
			{2070.906005,1366.480590,10.679657},
			{2062.226562,1364.635864,10.671875},
			{2082.600097,1370.632324,10.671875},
			{2082.021240,1375.905761,10.679657},
			{2056.571044,1367.570556,10.679657},
			{2051.290283,1361.184814,10.671875},
			{2062.882080,1267.713623,10.671875},
			{2068.589599,1266.664428,10.671875},
			{2052.353271,1266.769897,10.671875},
			{2112.239501,1375.740112,10.790472},
			{2101.333007,1375.615722,10.746793},
			{2103.770751,1370.775390,10.779636},
			{2110.284912,1370.472900,10.766404},
			{2110.170654,1385.758666,10.820311},
			{2104.629394,1384.598510,10.820311},
			{2114.827636,1391.265502,10.820311},
			{2148.166503,1391.181762,10.820311},
			{2156.658203,1396.645019,10.820311},
			{2159.490234,1405.265869,10.820311},
			{2156.040039,1412.879882,10.820311},
			{2147.577636,1415.402343,10.820311},
			{2111.698974,1414.938720,10.820311},
			{2093.756591,1411.129028,10.820311},
			{2091.452880,1399.567260,10.820311},
			{2197.138916,1190.625854,10.681571},
			{2227.850341,1190.485717,10.763015},
			{2229.312988,1203.537475,10.676162},
			{2225.552001,1203.514404,10.675662},
			{2218.150878,1195.389404,10.683667},
			{2198.865966,1195.653564,10.679661},
			{2229.156250,1362.827514,10.675539},
			{2225.529296,1362.769653,10.676404},
			{2216.670898,1370.598510,10.671875},
			{2216.907226,1374.863525,10.671875},
			{2194.072021,1376.590087,10.747546},
			{2236.152832,1371.593627,10.697423},
			{2339.290771,1191.651000,10.715437},
			{2345.052978,1183.247558,10.671157},
			{2349.714599,1183.140014,10.671875},
			{2338.178466,1196.359252,10.691264},
			{2354.989746,1196.567382,10.724664},
			{2234.300048,1195.884399,10.745515},
			{2345.514160,1075.289672,10.801842},
			{2344.182861,997.173095,10.743606},
			{2341.922851,975.633850,10.671875},
			{2297.916015,975.639099,10.671875},
			{2347.451171,973.213806,10.671875},
			{2350.352294,988.954711,10.787583},
			{2349.985107,1067.456665,10.757444},
			{2144.459472,944.889648,10.713379},
			{2144.211669,957.898986,10.781758},
			{2132.624023,950.029785,10.812988},
			{2125.608886,923.420715,10.820311},
			{2114.689941,922.727844,10.820311},
			{2112.654296,922.640563,10.820311},
			{2101.173583,923.002319,10.820311},
			{2102.092529,930.007751,10.820311},
			{2137.836425,952.894226,10.681410},
			{2235.996337,1375.770996,10.703617},
			{2361.293457,1371.362426,10.763519},
			{2369.466308,1383.136474,10.682813},
			{2364.929687,1383.458984,10.671875},
			{2359.433349,1375.747436,10.718145},
			{2372.399902,1370.790771,10.776416},
			{2373.472656,1374.017456,10.753103},
			{2419.686279,1368.923217,10.797465},
			{2421.374511,1375.358276,10.878271},
			{2425.508789,1363.308105,10.669621},
			{2424.869628,1200.409179,10.815851},
			{2417.825195,1195.757568,10.688323},
			{2355.124267,1191.181640,10.712582},
			{2417.735839,1191.394042,10.685585},
			{2430.234130,1199.436401,10.866272},
			{2430.157226,1363.426879,10.675209},
			{2246.923095,1370.895874,10.783927},
			{2304.958740,1370.944580,10.786059},
			{2310.019287,1369.566162,10.725762},
			{2310.542968,1375.441772,10.816857},
			{2304.905029,1375.528442,10.832358},
			{2305.774169,1386.537475,10.820311},
			{2311.367187,1398.898437,10.820311},
			{2294.797363,1398.021362,10.820311},
			{2280.476318,1401.172973,10.823410},
			{2284.427490,1505.817504,17.218750},
			{2331.503173,1505.618041,17.218750},
			{2330.024169,1400.578613,23.625000},
			{2283.945312,1401.421386,23.631227},
			{2285.881835,1505.676025,30.023437},
			{2330.247314,1504.542968,30.023437},
			{2329.863525,1400.486694,36.421875},
			{2289.335937,1400.097167,36.421875},
			{2283.506591,1505.346313,42.820312},
			{2305.973876,1505.241577,42.820312},
			{2309.637451,1480.823364,42.820312},
			{2312.649658,1402.919677,42.820312},
			{2321.951416,1396.248291,42.820312},
			{2338.407226,1403.740112,42.820312},
			{2317.301025,1510.056518,42.820312},
			{2273.126953,1512.165405,42.820312},
			{2281.276855,1394.129638,36.421875},
			{2338.511474,1395.366455,36.421875},
			{2334.737792,1513.045043,30.023437},
			{2274.602539,1511.788085,30.023437},
			{2279.151367,1394.786987,23.625000},
			{2339.796386,1397.201049,23.625000},
			{2335.242919,1511.564086,17.218750},
			{2273.894531,1509.580200,17.218750},
			{2272.947998,1396.538452,10.820311},
			{2296.199707,1392.881103,10.820311},
			{2302.945556,1384.368041,10.820311},
			{2252.070312,1375.759887,10.789852},
			{2310.831542,1526.715820,10.740991},
			{2328.350097,1530.261840,10.756682},
			{2363.384033,1530.958129,10.805248},
			{2365.334228,1472.951293,10.805212},
			{2369.881835,1468.999023,10.801582},
			{2372.063720,1529.234619,10.775918},
			{2365.258544,1536.522216,10.751004},
			{2331.498779,1535.625976,10.795968},
			{2307.210449,1536.530029,10.750661},
			{2308.749511,1505.503540,10.820311},
			{2309.062011,1402.694946,10.820311},
			{2325.854248,1445.138793,10.820311},
			{2150.292724,956.023315,10.769075},
			{2144.692138,845.218322,13.909811},
			{2150.162841,845.441162,13.903931},
			{2144.789306,758.285888,10.775938},
			{2144.928955,713.837585,10.786995},
			{2156.838623,710.144653,10.688958},
			{2283.231445,710.770996,10.963127},
			{2290.332275,720.442382,10.819996},
			{2289.816650,756.862731,10.854039},
			{2284.644042,753.357055,10.672756},
			{2285.153808,717.690307,10.957260},
			{2152.599365,716.141723,10.804161},
			{2149.679199,754.054687,10.786747},
			{2284.499511,841.438842,13.915192},
			{2285.475341,766.710815,10.979884},
			{2171.739501,969.503112,10.734245},
			{2072.696533,1200.411499,10.679657},
			{2145.294921,975.339782,10.791975},
			{2123.020263,929.147460,10.820311},
			{2116.744384,927.744873,10.820311},
			{2115.234375,927.491210,10.820311},
			{2110.559326,930.995849,10.820311},
			{2144.143554,837.195495,6.741998},
			{2466.683837,837.072143,6.734375},
			{2524.764892,850.744689,6.734375},
			{2525.093261,844.233703,6.734375},
			{2582.573242,868.225036,6.734375},
			{2580.936767,875.498352,6.734375},
			{2644.817138,915.046936,6.734375},
			{2638.829345,919.482055,6.734375},
			{2690.061035,974.720703,6.742077},
			{2683.879394,977.309143,6.734375},
			{2720.428710,1043.995605,6.734375},
			{2714.497314,1048.452758,6.734375},
			{2729.449951,1119.124511,6.734375},
			{2723.342285,1121.079711,6.734375},
			{2729.646728,1329.927490,6.734375},
			{2729.569091,1964.615234,6.734375},
			{2723.331542,2288.774169,6.734375},
			{2729.196289,2286.919921,6.734375},
			{2714.312500,2366.166503,6.734375},
			{2720.804687,2366.411865,6.742077},
			{2688.842773,2437.458740,6.734375},
			{2694.634765,2439.412597,6.734375},
			{2645.972656,2502.516845,6.676309},
			{2649.812011,2507.527099,6.646635},
			{2582.741943,2562.533691,5.209569},
			{2587.373291,2567.783935,5.219065},
			{2504.463623,2606.905029,4.901741},
			{2501.107177,2614.531494,4.978972},
			{2416.568603,2627.858642,6.525168},
			{2419.460693,2634.166748,6.490110},
			{2296.276611,2625.757080,6.750000},
			{2297.939941,2631.624755,6.750000},
			{2120.792968,2590.174316,6.781140},
			{2121.217773,2596.340087,6.773437},
			{1803.174926,2499.007080,6.820312},
			{1796.467529,2504.921142,6.820312},
			{1633.885253,2470.285644,6.835937},
			{1642.501220,2477.082763,6.835937},
			{1414.598999,2469.155761,6.734375},
			{1411.186767,2474.982177,6.734375},
			{1359.436401,2461.021728,6.734375},
			{1359.926391,2467.903076,6.734375},
			{1297.853881,2430.602050,6.734375},
			{1298.928222,2440.698242,6.734375},
			{1254.691528,2390.156494,6.734375},
			{1250.375366,2395.216308,6.734375},
			{1224.261718,2333.947998,6.734375},
			{1218.847534,2340.157714,6.734375},
			{1211.664428,2271.022216,6.734375},
			{1204.969482,2271.535400,6.734375},
			{1204.790527,1958.907348,6.741998},
			{1211.736694,1036.600585,6.812500},
			{1204.794311,1033.264038,6.812500},
			{1222.442749,978.515502,6.812500},
			{1215.792236,976.147460,6.812500},
			{1249.739135,923.018249,6.820202},
			{1242.957397,921.701782,6.812500},
			{1290.772460,881.758361,6.812500},
			{1285.390991,875.748718,6.812500},
			{1343.784423,851.633178,6.812500},
			{1340.107910,845.365173,6.812500},
			{1402.174438,837.752380,6.812500},
			{1402.798339,831.819335,6.812500},
			{1802.169311,836.961181,10.671875},
			{1782.338378,831.756652,10.671875},
			{2061.446289,837.091796,6.742155},
			{1658.563842,831.374572,6.780540},
			{1658.819824,836.891540,6.788921},
			{2041.150146,831.265014,6.734375},
			{2039.755981,837.182678,6.742155},
			{2440.199707,831.229553,6.734375},
			{2382.905029,808.826049,7.240807},
			{2338.905517,776.734802,9.959637},
			{2298.413574,762.508483,10.642457}
		};
		new Connections[309][4] ={
			{0,0,0,0},
			{2,4,54,0},
			{24,29,140,0},
			{65,97,96,0},
			{3,56,0,0},
			{55,0,0,0},
			{83,84,114,0},
			{8,0,0,0},
			{9,14,60,0},
			{10,10,0,0},
			{11,53,69,68},
			{21,0,0,0},
			{13,0,0,0},
			{6,12,0,0},
			{15,0,0,0},
			{16,17,17,0},
			{59,0,0,0},
			{18,0,0,0},
			{19,0,0,0},
			{20,0,0,0},
			{1,69,68,52},
			{22,0,0,0},
			{23,0,0,0},
			{16,0,0,0},
			{25,214,214,0},
			{26,0,0,0},
			{27,0,0,0},
			{28,141,28,28},
			{29,30,0,0},
			{31,0,0,0},
			{64,0,0,0},
			{32,33,32,32},
			{43,136,0,0},
			{35,0,0,0},
			{33,42,42,0},
			{36,0,0,0},
			{37,0,0,0},
			{38,0,0,0},
			{39,0,0,0},
			{40,0,0,0},
			{41,0,0,0},
			{228,42,0,0},
			{30,230,0,0},
			{44,0,0,0},
			{45,226,0,0},
			{46,0,0,0},
			{47,0,0,0},
			{48,0,0,0},
			{49,0,0,0},
			{50,0,0,0},
			{1,51,0,0},
			{52,4,0,0},
			{53,0,0,0},
			{11,0,0,0},
			{3,58,0,0},
			{3,58,0,0},
			{57,0,0,0},
			{12,0,0,0},
			{7,96,97,0},
			{9,60,0,0},
			{62,68,69,0},
			{7,229,0,0},
			{63,0,0,0},
			{2,0,0,0},
			{4,54,53,0},
			{66,114,0,0},
			{67,0,0,0},
			{5,0,0,0},
			{70,70,70,71},
			{71,71,71,70},
			{72,0,0,0},
			{72,0,0,0},
			{73,235,0,0},
			{74,305,0,0},
			{75,0,0,0},
			{76,0,0,0},
			{77,0,0,0},
			{78,222,0,0},
			{79,0,0,0},
			{80,0,0,0},
			{45,81,0,0},
			{82,136,0,0},
			{34,0,0,0},
			{61,0,0,0},
			{86,0,0,0},
			{65,83,114,0},
			{89,122,0,0},
			{85,0,0,0},
			{87,0,0,0},
			{93,99,0,0},
			{92,0,0,0},
			{94,0,0,0},
			{88,101,0,0},
			{94,0,0,0},
			{95,0,0,0},
			{98,0,0,0},
			{98,91,90,0},
			{90,90,91,0},
			{7,0,0,0},
			{103,0,0,0},
			{93,0,0,0},
			{103,0,0,0},
			{88,0,0,0},
			{105,0,0,0},
			{100,102,0,0},
			{106,0,0,0},
			{107,0,0,0},
			{108,0,0,0},
			{109,0,0,0},
			{110,0,0,0},
			{111,0,0,0},
			{112,0,0,0},
			{113,0,0,0},
			{104,0,0,0},
			{115,0,0,0},
			{116,126,0,0},
			{120,0,0,0},
			{118,118,0,0},
			{119,0,0,0},
			{84,83,65,0},
			{123,125,0,0},
			{117,148,0,0},
			{121,0,0,0},
			{124,0,0,0},
			{89,87,0,0},
			{149,164,0,0},
			{127,160,0,0},
			{132,0,0,0},
			{129,160,0,0},
			{131,0,0,0},
			{129,127,0,0},
			{116,118,0,0},
			{133,0,0,0},
			{134,0,0,0},
			{135,0,0,0},
			{82,43,0,0},
			{137,0,0,0},
			{138,0,0,0},
			{128,0,0,0},
			{24,0,0,0},
			{141,139,139,139},
			{142,231,0,0},
			{143,0,0,0},
			{144,0,0,0},
			{145,0,0,0},
			{146,0,0,0},
			{147,0,0,0},
			{139,213,0,0},
			{123,0,0,0},
			{150,0,0,0},
			{205,0,0,0},
			{152,153,0,0},
			{148,167,0,0},
			{155,0,0,0},
			{150,152,0,0},
			{157,0,0,0},
			{154,0,0,0},
			{158,0,0,0},
			{159,0,0,0},
			{130,0,0,0},
			{161,0,0,0},
			{162,0,0,0},
			{163,0,0,0},
			{156,0,0,0},
			{165,0,0,0},
			{169,0,0,0},
			{149,0,0,0},
			{169,0,0,0},
			{200,0,0,0},
			{171,170,170,0},
			{212,0,0,0},
			{172,0,0,0},
			{173,0,0,0},
			{174,0,0,0},
			{175,0,0,0},
			{176,0,0,0},
			{177,0,0,0},
			{178,0,0,0},
			{179,0,0,0},
			{180,0,0,0},
			{181,0,0,0},
			{182,0,0,0},
			{183,0,0,0},
			{184,0,0,0},
			{185,0,0,0},
			{186,0,0,0},
			{187,0,0,0},
			{188,0,0,0},
			{189,0,0,0},
			{190,0,0,0},
			{191,0,0,0},
			{192,0,0,0},
			{193,0,0,0},
			{194,0,0,0},
			{195,0,0,0},
			{196,0,0,0},
			{197,0,0,0},
			{198,0,0,0},
			{199,0,0,0},
			{168,166,0,0},
			{148,0,0,0},
			{202,0,0,0},
			{203,0,0,0},
			{204,0,0,0},
			{151,0,0,0},
			{206,0,0,0},
			{207,0,0,0},
			{208,0,0,0},
			{209,0,0,0},
			{210,0,0,0},
			{211,0,0,0},
			{171,199,199,0},
			{201,0,0,0},
			{28,0,0,0},
			{216,0,0,0},
			{26,0,0,0},
			{217,0,0,0},
			{218,0,0,0},
			{219,0,0,0},
			{220,0,0,0},
			{221,0,0,0},
			{78,308,0,0},
			{223,0,0,0},
			{224,0,0,0},
			{225,0,0,0},
			{215,0,0,0},
			{227,0,0,0},
			{222,308,0,0},
			{32,0,0,0},
			{97,97,97,96},
			{140,0,0,0},
			{232,0,0,0},
			{233,0,0,0},
			{234,0,0,0},
			{147,0,0,0},
			{236,0,0,0},
			{237,238,0,0},
			{240,0,0,0},
			{239,0,0,0},
			{241,0,0,0},
			{242,0,0,0},
			{243,0,0,0},
			{244,0,0,0},
			{245,0,0,0},
			{246,0,0,0},
			{247,0,0,0},
			{248,0,0,0},
			{249,249,0,0},
			{249,250,251,0},
			{250,0,0,0},
			{251,252,0,0},
			{253,254,0,0},
			{254,0,0,0},
			{255,0,0,0},
			{256,0,0,0},
			{257,0,0,0},
			{258,0,0,0},
			{259,0,0,0},
			{260,0,0,0},
			{261,0,0,0},
			{262,0,0,0},
			{263,0,0,0},
			{264,0,0,0},
			{265,0,0,0},
			{266,0,0,0},
			{267,268,0,0},
			{268,267,0,0},
			{269,0,0,0},
			{270,269,0,0},
			{271,0,0,0},
			{272,0,0,0},
			{273,0,0,0},
			{274,0,0,0},
			{275,0,0,0},
			{276,0,0,0},
			{277,0,0,0},
			{278,0,0,0},
			{279,0,0,0},
			{280,0,0,0},
			{281,0,0,0},
			{282,0,0,0},
			{283,0,0,0},
			{284,283,0,0},
			{285,286,286,0},
			{285,287,0,0},
			{287,0,0,0},
			{288,0,0,0},
			{289,0,0,0},
			{290,0,0,0},
			{291,0,0,0},
			{292,0,0,0},
			{293,0,0,0},
			{294,0,0,0},
			{295,0,0,0},
			{296,0,0,0},
			{297,296,0,0},
			{301,302,0,0},
			{301,302,0,0},
			{304,303,0,0},
			{303,304,0,0},
			{50,0,0,0},
			{299,0,0,0},
			{298,0,0,0},
			{73,235,0,0},
			{300,235,73,0},
			{238,0,0,0},
			{305,0,0,0},
			{306,0,0,0},
			{307,0,0,0}
		};
		new Float:KMH[309] ={
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,20.000000,25.000000,25.000000,30.000000,25.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			20.000000,20.000000,25.000000,25.000000,23.000000,20.000000,18.000000,0.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,5.000000,5.000000,0.100000,2.000000,5.000000,5.000000,9.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,
			0.000000,5.000000,0.100000,5.000000,5.000000,30.000000,30.000000,30.000000,30.000000,30.000000,
			30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,
			30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,
			30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,
			30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,
			30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,
			30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,30.000000,
			25.000000,30.000000,30.000000,30.000000,28.000000,30.000000,27.000000,23.000000,20.000000
		};
		new ConnectionsAmount[MAX_DRIVEPOINTS];
		new CAR_AMOUNT_USED;
		new bool:calculations;
		new BrakeTimer;
		new ObjectBrakeTimer;
		new AutomaticCars[MAX_CARBOTS];
		new CarPosition[MAX_CARBOTS];
		new LastCarPosition[MAX_CARBOTS];
		new bool:HasFreezed[MAX_PLAYERS][MAX_CARBOTS];
		new Freezed[MAX_CARBOTS];
		new BotAngle[MAX_CARBOTS];
		new bool:ObjectHasFreezed[MAX_CARBOTS][MAX_CARBOTS];
	//$ endregion Carbot variables
	//$ region Objectselector-Menu
		new Menu:Main;
		new Menu:one;
		new Menu:two;
		new Menu:tree;
		new Menu:four;
		new Menu:five;
		new Menu:six;
		new Menu:seven;
		new Menu:eight;
		new Menu:nine;
	//$ endregion Objectselector-Menu
	//$ region Zombie vairables
		new Ticket[MAX_PLAYERS];
		new weapL[55][weapParts]={
			//  ID                  	allow	range   wide	dMin	dMax	cutting	insGib	continua    msng
			{0,                     true,   1.0,    45.0,    5,		10,    	false,	false,	false,  "~n~~n~~n~~n~~n~~n~~n~~w~Punch!!!"},
			{WEAPON_BRASSKNUCKLE,	true,	1.5,	45.0,	5,		15,		false,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~y~Plack~w~!!!"},
			{WEAPON_GOLFCLUB,		true,	2.0,	35.0,	20,		25,		false,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~w~Fiuuuff!!! ~b~~h~Fiuuuff~w~!!!"},
			{WEAPON_NITESTICK,		true,	1.5,	35.0,	10,		15,		false,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~b~~h~Plafff~w~!!!"},
			{WEAPON_KNIFE,			true,	1.5,	15.0,	10,		15,		false,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~r~Fisss~w~!!!"},
			{WEAPON_BAT,			true,	2.0,	35.0,	10,		15,		false,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~g~~h~Paffffff~w~!!!"},
			{WEAPON_SHOVEL,			true,	2.0,	35.0,	10,		25,		true,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~r~~h~~h~PlanK~w~!!!"},
			{WEAPON_POOLSTICK,		true,	2.0,	35.0,	10,		15,		false,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~g~~h~Paffffff~w~!!!"},
			{WEAPON_KATANA,			true,	2.0,	45.0,	20,		45,		true,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~b~SWIFT~w~! ~b~SWIFT~w~!"},
			{WEAPON_CHAINSAW,		true,	2.5,	35.0,	20,		35,		true,	false,	true,	"~n~~n~~n~~n~~n~~n~~n~~g~BRRRRRRRNNNNNN~w~!!!!"},
			{WEAPON_DILDO,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_DILDO2,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_VIBRATOR,		false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_VIBRATOR2,		false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_FLOWER,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_CANE,			true,	2.0,	35.0,	10,		15,		false,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~g~~h~Paffffff~w~!!!"},
			{WEAPON_GRENADE,		false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_TEARGAS,		false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_MOLTOV,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_COLT45,			true,	20.0,	7.0,	10,		15,		false,	false,	true,	"~n~~n~~n~~n~~n~~n~~n~~r~Bang~w~!!~r~Bang~w~!!"},
			{WEAPON_SILENCED,		true,	20.0,	3.0,	10,		15,		false,	false,	false,	"~n~~n~~n~~n~~n~~n~~n~~r~Piuufff~w~!!"},
			{WEAPON_DEAGLE,			true,	25.0,	3.0,	15,		20,		false,	true,	true,	"~n~~n~~n~~n~~n~~n~~n~~r~Baaang~w~!!"},
			{WEAPON_SHOTGUN,		true,	18.0,	7.0,	10,		25,		true,	true,	true,	"~n~~n~~n~~n~~n~~n~~n~~r~BUM~w~!!!!"},
			{WEAPON_SAWEDOFF,		true,	12.0,	10.0,	12,		18,		true,	true,	true,	"~n~~n~~n~~n~~n~~n~~n~~r~BUM~w~!!~r~BUM~w~!!"},
			{WEAPON_SHOTGSPA,		true,	18.0,	7.0,	25,		45,		true,	true,	true,	"~n~~n~~n~~n~~n~~n~~n~~r~BUUUM~w~!!!!"},
			{WEAPON_UZI,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_MP5,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_AK47,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_M4,				false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_TEC9,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_RIFLE,			true,	50.0,	2.0,	0,		50,		false,	true,	true,	"~n~~n~~n~~n~~n~~n~~n~~g~PUUUM~w~!!!!"},
			{WEAPON_SNIPER,			true,	100.0,	1.0,	0,		60,		false,	true,	false,	"~n~~n~~n~~n~~n~~n~~n~~g~PUUUUUUUUMMMMM~w~!!!!"},
			{WEAPON_ROCKETLAUNCHER,	false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_HEATSEEKER,		false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_FLAMETHROWER,	true,	8.0,	15.0,	10,		20,		false,	false,	true,	"~n~~n~~n~~n~~n~~n~~n~~r~Fuuu~y~uffffff~w~!!!!"},
			{WEAPON_MINIGUN,		true,	25.0,	3.0,	1,		99,		true,	true,	true,	"~n~~n~~n~~n~~n~~n~~n~~r~MUAJAJAJAJAJAJ~w~!!!!!"},
			{WEAPON_SATCHEL,		false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_BOMB,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_SPRAYCAN,		true,	2.0,	25.0,	10,		0,		false,	false,	true,	"~n~~n~~n~~n~~n~~n~~n~~y~FS~b~SS~r~SS~g~SS~y~SS~w~!!!"},
			{WEAPON_FIREEXTINGUISHER,true,	3.5,	15.0,	10,		0,		false,	false,	true,	"~n~~n~~n~~n~~n~~n~~n~~w~Fuuuusssshhh~b~!!!!"},
			{WEAPON_CAMERA,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_PARACHUTE,		false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_VEHICLE,		false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{-1,					false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_DROWN,			false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."},
			{WEAPON_COLLISION,		false,	0.0,	0.0,	0,		0,		false,	false,	false,	"~w~This ~r~weapon ~w~is not yet ~b~available ~w~for beeing used against ~g~zombies~w~!!!! ~y~sorry~w~. ~n~~b~zeruel_angel~w~."}
		};
		new NOFZombies=0;
		new TOTALZombies=10;
		new Float:Zspeed = 2.0;
		new ZTimerSpeed = 500;
		new Float:vaiven = 5.0;
		new Float:oX,Float:oY,Float:oZ;
		new zombie[MAX_ZOMBIES][zombiParts];
		new zombie1[zpart][zombiPos]={
			{2905,-0.115479,-0.023924, -1.280131, -90.000000, 90.000000,0.000000},
			{2906, -0.218995, 0.200928, -0.253135, 0.000000, 180.000000, 0.000000},
			{2907, -0.032227, -0.045897, -0.544213, 270.000000, 0.000000, 0.000000},
			{2906, 0.187987, 0.158448, -0.265793, 0.000000, 0.000000, 0.000000},
			{2908, 0.000000, 0.000000, 0.000000, 270.000000, 90.000000, 0.000000},
			{2905, 0.101074, -0.012694, -1.288253, 270.000000, 90.000000, 0.000000}
		};
		new zombie2[6][zombiPos]={
			{2905, 0.005614, -0.110107, -1.280131, -90.000000, 90.000000, 90.000000},
			{2906, -0.148926, -0.180663, -0.253135, 0.000000, 180.000000, 90.000000},
			{2907, 0.047852, -0.039061, -0.544213, 270.000000, 0.000000, 90.000000},
			{2906, -0.152343, 0.171387, -0.265793, 0.000000, 0.000000, 90.000000},
			{2908, 0.000000, 0.000000, 0.000000, 270.000000, 90.000000, 90.000000},
			{2905, 0.000977, 0.090332, -1.288253, 270.000000, 90.000000, 90.000000}
		};
		new A1[tipo][zArm]={
			{-0.253135,0.0},
			{-0.265793,0.0}
		};
		new A2[tipo][zArm]={
			{-0.359635, -90.0},
			{-0.338874, -90.0}
		};
		new TimerAtaca=-1;
		new TimerAPO=-1;
		new PlayerDeath[MAX_PLAYERS];
		new apocalipsis = false;
		new WeaponList[MAX_PLAYERS][12][WeaponType];
		new LastWeaponUsed[MAX_PLAYERS];
		new money[MAX_PLAYERS];
		new scorez=0;
		new scorep=0;

	//$ endregion Zombie vairables
	//$ region Carbuy-Menu
	new Text:colordraw[TOTAL_COLORS+1];
	new Text:menuDraws[MAX_PLAYERS][33];
	new Text:menuDraws2[MAX_PLAYERS][MAX_MENUG_ITEMS+1];
	new menutypeNames[MAX_PLAYERS][MAX_TYPE_ITEMS][40];
	new colorpage[MAX_PLAYERS];
	new menuPlace[MAX_PLAYERS];
	new itemPlace[MAX_PLAYERS][MAX_MENU_ITEMS];
	new menuNames[MAX_PLAYERS][MAX_MENU_ITEMS][40];
	new totalItems[MAX_PLAYERS][MAX_MENU_ITEMS];
	new itemStart[MAX_PLAYERS][MAX_MENU_ITEMS];
	new Float:PlayerPos[MAX_PLAYERS][4];
	new playerCar[MAX_PLAYERS];
	new bool:destroyCar[MAX_PLAYERS][2];
	new carSelect[MAX_PLAYERS];
	//$ endregion Carbuy-Menu
	new CarColors[TOTAL_COLORS][0] = {
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x45B931FF},
		{0xF1AD30FF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x45B931FF},
		{0xF1AD30FF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x45B931FF},
		{0xF1AD30FF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x45B931FF},
		{0xF1AD30FF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x45B931FF},
		{0xF1AD30FF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x45B931FF},
		{0xF1AD30FF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x45B931FF},
		{0xF1AD30FF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x45B931FF},
		{0xF1AD30FF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x45B931FF},
		{0xF1AD30FF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x45B931FF},
		{0xF1AD30FF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x45B931FF},
		{0xF1AD30FF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x45B931FF},
		{0xF1AD30FF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x8EE89FF},
		{0xF3B025FF},
		{0xA59D47FF},
		{0xD1441BFF},
		{0x45B931FF},
		{0xF1AD30FF},
		{0x8EE89FF},
		{0xF3B025FF}
	};
	new Float:checkpoints[MAX_POINTS][3] = {
		{1595.5406, 2198.0520, 10.3863},
		{2202.0649, 2472.6697, 10.5677},
		{2115.1929, 919.9908, 10.5266},
		{2640.7209, 1105.9565, 10.5274},
		{608.5971, 1699.6238, 6.9922},
		{618.4878, 1684.5792, 6.9922},
		{2146.3467, 2748.2893, 10.5245},
		{-1679.4595, 412.5129, 6.9973},
		{-1327.5607, 2677.4316, 49.8093},
		{-1470.0050, 1863.2375, 32.3521},
		{-2409.2200, 976.2798, 45.2969},
		{-2244.1396, -2560.5833, 31.9219},
		{-1606.0544, -2714.3083, 48.5335},
		{1937.4293, -1773.1865, 13.3828},
		{-91.3854, -1169.9175, 2.4213},
		{1383.4221, 462.5385, 20.1506},
		{660.4590, -565.0394, 16.3359},
		{1381.7206,459.1907,20.3452},
		{-1605.7156,-2714.4573,48.5335}
	};
	new checkpointType[MAX_POINTS] = {
		Gasstation0,
		Gasstation1,
		Gasstation2,
		Gasstation3,
		Gasstation4,
		Gasstation5,
		Gasstation6,
		Gasstation7,
		Gasstation8,
		Gasstation9,
		Gasstation10,
		Gasstation11,
		Gasstation12,
		Gasstation13,
		Gasstation14,
		Gasstation15,
		Gasstation16,
		Gasstation17,
		Gasstation18
	};
	//$ region StreamPickups
	new pustream[MAX_ACTIVE_PICKUPS];
	new SectorPickups[MAX_SECTORS][MAX_SECTOR_PICKUPS];
	new SectorPickupCount[MAX_SECTORS];
	new PickupInfo[MAX_STREAM_PICKUPS][puInfo];
	new pustreamactive = 1;
	new pucount = -1;
	new PUstreamcount = 0;
	//$ endregion StreamPickups
	//$ region carmod
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
	//$ endregion carmod
	new MAX_SLOTS_tAxI;
	//new vSecActive[MAX_SECTORS];
	new gateobj[MAX_OBJECTS2];
	new BIZNAME2[256];
	new SavePlayerPos[SLOTS][SavePlayerPosEnum];
	new SpeedoInfo[MAX_PLAYERS][SPEEDO_PREF];
	new carType[29][carTypesE]={
		{"2DOORS", 0, 0, 30},
		{"4DOORS", 1, 30, 56},
		{"Army", 2, 56, 59},
		{"Bau", 3, 59, 62},
		{"BIKES", 4, 62, 65},
		{"BOATS", 5, 65, 74},
		{"Bus", 6, 74, 76},
		{"Carmechanic", 7, 76, 78},
		{"Essen", 8, 78, 81},
		{"Farm", 9, 81, 83},
		{"FBI", 10, 83, 86},
		{"Fire", 11, 86, 88},
		{"Helis", 12, 88, 93},
		{"LKW", 13, 93, 96},
		{"LUXUS", 14, 96, 102},
		{"Medic", 15, 102, 103},
		{"Motorbikes", 16, 103, 113},
		{"Müllmission", 17, 113, 114},
		{"News", 18, 114, 116},
		{"Planes", 19, 116, 126},
		{"Police", 20, 126, 133},
		{"RC", 21, 133, 138},
		{"Small", 22, 138, 144},
		{"Specials", 23, 144, 154},
		{"Sportcars", 24, 154, 179},
		{"Swat", 25, 179, 181},
		{"Taxi", 26, 181, 183},
		{"Train", 27, 183, 189},
		{"Trucks", 28, 189, 200}
		};
	new carDefines[MAX_CARS][carDefinesE]={
		{ 499, "Benson", 22000, 70, 550, "2DOORS", 1},
		{ 478, "Walton", 24500, 76, 550, "2DOORS", 1},
		{ 442, "Romero", 31500, 82, 550, "2DOORS", 1},
		{ 401, "Bravura", 34000, 82, 550, "2DOORS", 1},
		{ 440, "Rumpo", 34000, 98, 550, "2DOORS", 1},
		{ 550, "Sunrise", 35000, 88, 550, "2DOORS", 1},
		{ 419, "Esperant", 36500, 92, 550, "2DOORS", 1},
		{ 436, "Previon", 37000, 91, 550, "2DOORS", 1},
		{ 410, "Manana", 39000, 85, 550, "2DOORS", 1},
		{ 491, "Virgo", 39500, 95, 550, "2DOORS", 1},
		{ 474, "Hermes", 40000, 95, 550, "2DOORS", 1},
		{ 527, "Cadrona", 40000, 90, 550, "2DOORS", 1},
		{ 422, "Bobcat", 40500, 80, 550, "2DOORS", 1},
		{ 526, "Fortune", 42500, 88, 550, "2DOORS", 1},
		{ 575, "Broadway", 43000, 105, 600, "2DOORS", 1},
		{ 576, "Tornado", 46000, 100, 600, "2DOORS", 1},
		{ 489, "Rancher", 48000, 92, 550, "2DOORS", 1},
		{ 549, "Tampa", 48000, 96, 600, "2DOORS", 1},
		{ 439, "Stallion", 48500, 110, 600, "2DOORS", 1},
		{ 534, "Remington", 49000, 94, 550, "2DOORS", 1},
		{ 542, "Clover", 49000, 90, 600, "2DOORS", 1},
		{ 543, "Sadler", 49500, 90, 550, "2DOORS", 1},
		{ 500, "Mesa", 50000, 98, 600, "2DOORS", 1},
		{ 517, "Majestic", 50000, 99, 550, "2DOORS", 1},
		{ 600, "Picador", 52000, 94, 550, "2DOORS", 1},
		{ 475, "Sabre", 54500, 109, 600, "2DOORS", 1},
		{ 536, "Blade", 55000, 108, 600, "2DOORS", 1},
		{ 412, "Voodoo", 56000, 100, 600, "2DOORS", 1},
		{ 554, "Yosemite", 58000, 104, 600, "2DOORS", 1},
		{ 518, "Buccanee", 58500, 96, 550, "2DOORS", 1},
		{ 483, "Camper", 23000, 90, 550, "4DOORS", 2},
		{ 418, "Moonbeam", 25000, 68, 550, "4DOORS", 2},
		{ 404, "Pereninal", 28000, 74, 550, "4DOORS", 2},
		{ 413, "Pony", 30000, 112, 600, "4DOORS", 2},
		{ 479, "Regina", 32000, 85, 550, "4DOORS", 2},
		{ 467, "Oceanic", 36000, 80, 550, "4DOORS", 2},
		{ 529, "Willard", 37500, 88, 550, "4DOORS", 2},
		{ 547, "Primo", 37500, 87, 550, "4DOORS", 2},
		{ 546, "Intruder", 38000, 86, 550, "4DOORS", 2},
		{ 540, "Vincent", 39000, 96, 550, "4DOORS", 2},
		{ 492, "Greenwood", 41000, 82, 550, "4DOORS", 2},
		{ 482, "Burrito", 42000, 120, 600, "4DOORS", 2},
		{ 507, "Elegant", 43500, 105, 600, "4DOORS", 2},
		{ 516, "Nebula", 44000, 100, 600, "4DOORS", 2},
		{ 466, "Glendale", 44500, 99, 550, "4DOORS", 2},
		{ 458, "Solair", 45000, 90, 550, "4DOORS", 2},
		{ 426, "Premier", 46000, 115, 600, "4DOORS", 2},
		{ 551, "Merit", 48000, 102, 600, "4DOORS", 2},
		{ 566, "Tahoma", 49000, 94, 550, "4DOORS", 2},
		{ 585, "Emperor", 49500, 101, 600, "4DOORS", 2},
		{ 445, "Admiral", 50000, 90, 550, "4DOORS", 2},
		{ 561, "Stratum", 52000, 103, 600, "4DOORS", 2},
		{ 421, "Washington", 53000, 96, 550, "4DOORS", 2},
		{ 567, "Savanna", 53000, 90, 550, "4DOORS", 2},
		{ 400, "Landstal", 55000, 97, 550, "4DOORS", 2},
		{ 405, "Sentinel", 55000, 110, 600, "4DOORS", 2},
		{ 520, "Hydra", 2000000, 6000, 10000, "Army", 3},
		{ 425, "Hunter", 2500000, 5500, 10000, "Army", 3},
		{ 432, "Rhino", 3000000, 400, 1000, "Army", 3},
		{ 486, "Dozer", 70000, 230, 600, "Bau", 4},
		{ 524, "Cement", 90000, 250, 750, "Bau", 4},
		{ 406, "Dumper", 100000, 300, 850, "Bau", 4},
		{ 481, "BMX", 2000, 0, 0, "BIKES", 5},
		{ 509, "Bike", 2000, 0, 0, "BIKES", 5},
		{ 510, "Mountainbike", 3000, 0, 0, "BIKES", 5},
		{ 473, "Dinghy", 50000, 220, 500, "BOATS", 6},
		{ 484, "Marquis", 65000, 150, 350, "BOATS", 6},
		{ 453, "Reefer", 75000, 230, 1000, "BOATS", 6},
		{ 454, "Tropic", 150000, 350, 1200, "BOATS", 6},
		{ 595, "Launch", 175000, 280, 1000, "BOATS", 6},
		{ 472, "Coastg", 180000, 250, 1000, "BOATS", 6},
		{ 452, "Speeder", 200000, 420, 1500, "BOATS", 6},
		{ 446, "Squalo", 240000, 520, 1700, "BOATS", 6},
		{ 493, "Jetmax", 250000, 470, 1600, "BOATS", 6},
		{ 437, "Coach", 75000, 223, 1200, "Bus", 7},
		{ 431, "Bus", 80000, 241, 1300, "Bus", 7},
		{ 552, "UtilityTruck", 35000, 110, 650, "Carmechanic", 8},
		{ 525, "Towtruck", 50000, 100, 650, "Carmechanic", 8},
		{ 448, "Pizzamoped", 9000, 40, 200, "Essen", 9},
		{ 423, "MrWhoop", 29000, 130, 600, "Essen", 9},
		{ 588, "Hotdog", 36000, 150, 600, "Essen", 9},
		{ 531, "Tractor", 5000, 50, 200, "Farm", 10},
		{ 532, "Combine", 80000, 244, 800, "Farm", 10},
		{ 528, "FBITruck", 50000, 172, 700, "FBI", 11},
		{ 490, "FBIRancher", 70000, 163, 720, "FBI", 11},
		{ 447, "SeaSparrow", 1000000, 3500, 7000, "FBI", 11},
		{ 407, "Firetruck", 65000, 247, 700, "Fire", 12},
		{ 544, "FireLadder", 65000, 255, 700, "Fire", 12},
		{ 469, "Sparrow", 600000, 3200, 6000, "Helis", 13},
		{ 487, "Maverick", 750000, 3750, 10000, "Helis", 13},
		{ 548, "Cargobob", 1100000, 4500, 15000, "Helis", 13},
		{ 563, "Raindanc", 1150000, 4700, 15000, "Helis", 13},
		{ 417, "Leviathn", 1200000, 4800, 15000, "Helis", 13},
		{ 450, "LKWAAUF", 17500, 0, 0, "LKWAnhänger", 14},
		{ 435, "LKWAZU", 20000, 0, 0, "LKWAnhänger", 14},
		{ 584, "LKWAOIL", 25000, 0, 0, "LKWAnhänger", 14},
		{ 580, "Stafford", 61000, 123, 600, "LUXUS", 15},
		{ 545, "Hustler", 62000, 137, 650, "LUXUS", 15},
		{ 579, "Huntley", 65000, 144, 650, "LUXUS", 15},
		{ 470, "Patriot", 70000, 200, 700, "LUXUS", 15},
		{ 535, "Slamvan", 70000, 137, 650, "LUXUS", 15},
		{ 409, "Stretch", 120000, 120, 600, "LUXUS", 15},
		{ 416, "Ambulance", 50000, 180, 700, "Medic", 15},
		{ 571, "Kart", 6000, 40, 200, "MOTORBIKES", 16},
		{ 462, "Faggio", 7000, 45, 200, "MOTORBIKES", 16},
		{ 468, "Dirtbike", 8000, 70, 250, "MOTORBIKES", 16},
		{ 471, "Quadbike", 10000, 60, 250, "MOTORBIKES", 16},
		{ 581, "BF400", 10000, 82, 350, "MOTORBIKES", 16},
		{ 461, "PCJ600", 10500, 80, 350, "MOTORBIKES", 16},
		{ 463, "Freeway", 11000, 65, 300, "MOTORBIKES", 16},
		{ 521, "FCR900", 13000, 80, 350, "MOTORBIKES", 16},
		{ 586, "Wayfarer", 15000, 74, 300, "MOTORBIKES", 16},
		{ 522, "NRG500", 18000, 87, 350, "MOTORBIKES", 16},
		{ 408, "Trash", 40000, 230, 700, "Müllmission", 17},
		{ 582, "NewsVan", 30000, 122, 650, "News", 18},
		{ 488, "NewsMav", 600000, 3000, 8000, "News", 18},
		{ 593, "Dodo", 400000, 2000, 5000, "Planes", 19},
		{ 460, "Skimmer", 500000, 2000, 5000, "Planes", 19},
		{ 512, "Cropdust", 550000, 2850, 5000, "Planes", 19},
		{ 513, "Stunt", 700000, 2400, 5000, "Planes", 19},
		{ 511, "Beagle", 900000, 4500, 7500, "Planes", 19},
		{ 476, "Rustler", 1000000, 3750, 5000, "Planes", 19},
		{ 553, "Nevada", 1400000, 6600, 12000, "Planes", 19},
		{ 519, "Shamal", 1500000, 6000, 12000, "Planes", 19},
		{ 577, "AT400", 2700000, 9000, 13000, "Planes", 19},
		{ 592, "Androm", 3000000, 8750, 14000, "Planes", 19},
		{ 523, "Policebike", 10000, 72, 350, "Police", 20},
		{ 596, "PoliceLA", 35000, 114, 700, "Police", 20},
		{ 597, "PoliceSF", 35000, 114, 700, "Police", 20},
		{ 598, "PoliceLV", 35000, 114, 700, "Police", 20},
		{ 599, "PoliceRancher", 40000, 132, 750, "Police", 20},
		{ 430, "Policeboat", 200000, 500, 1750, "Police", 20},
		{ 497, "PoliceMav", 650000, 3500, 9000, "Police", 20},
		{ 441, "RCBandit", 5000, 21, 50, "RC", 21},
		{ 464, "RCBaron", 5000, 22, 50, "RC", 21},
		{ 465, "RCRaider", 5000, 21, 50, "RC", 21},
		{ 501, "RCGoblin", 5000, 21, 50, "RC", 21},
		{ 564, "RCTiger", 5000, 24, 50, "RC", 21},
		{ 572, "Mower", 4000, 30, 200, "Small", 22},
		{ 574, "Sweeper", 4000, 30, 200, "Small", 22},
		{ 583, "Tug", 4500, 27, 200, "Small", 22},
		{ 485, "Baggage", 5000, 40, 200, "Small", 22},
		{ 457, "Golfkart", 20000, 42, 200, "Small", 22},
		{ 539, "Vortex", 20000, 55, 200, "Small", 22},
		{ 530, "Fortklift", 5000, 35, 200, "SPECIALS", 23},
		{ 508, "Journey", 30000, 143, 650, "SPECIALS", 23},
		{ 568, "Bandito", 55000, 180, 700, "SPECIALS", 23},
		{ 504, "Blood-a", 60000, 105, 600, "SPECIALS", 23},
		{ 495, "Sandking", 69000, 140, 550, "SPECIALS", 23},
		{ 424, "BFINJECT", 75000, 132, 650, "SPECIALS", 23},
		{ 444, "Monster", 90000, 250, 750, "SPECIALS", 23},
		{ 556, "Monster-A", 90000, 250, 750, "SPECIALS", 23},
		{ 557, "Monster-B", 90000, 250, 750, "SPECIALS", 23},
		{ 428, "Securitycar", 120000, 220, 750, "SPECIALS", 23},
		{ 587, "Euros", 59500, 137, 650, "SPORTCARS", 24},
		{ 565, "Flash", 60000, 120, 600, "SPORTCARS", 24},
		{ 496, "Blistac", 62000, 110, 600, "SPORTCARS", 24},
		{ 558, "Uranus", 63000, 121, 600, "SPORTCARS", 24},
		{ 603, "Phoenix", 72000, 158, 650, "SPORTCARS", 24},
		{ 602, "Alpha", 73000, 140, 650, "SPORTCARS", 24},
		{ 560, "Sultan", 77000, 128, 600, "SPORTCARS", 24},
		{ 434, "Hotknife", 81000, 173, 700, "SPORTCARS", 24},
		{ 533, "Feltzer", 82000, 126, 600, "SPORTCARS", 24},
		{ 402, "Buffalo", 85000, 145, 650, "SPORTCARS", 24},
		{ 555, "Windsor", 85000, 155, 650, "SPORTCARS", 24},
		{ 559, "Jester", 87000, 137, 650, "SPORTCARS", 24},
		{ 494, "Hotring", 88000, 190, 700, "SPORTCARS", 24},
		{ 502, "Hotring-A", 88000, 190, 700, "SPORTCARS", 24},
		{ 503, "Hotring-B", 88000, 190, 700, "SPORTCARS", 24},
		{ 562, "Elegy", 89000, 132, 650, "SPORTCARS", 24},
		{ 477, "ZR350", 90000, 145, 650, "SPORTCARS", 24},
		{ 589, "Club", 94000, 138, 650, "SPORTCARS", 24},
		{ 506, "SuperGT", 95000, 159, 650, "SPORTCARS", 24},
		{ 480, "Comet", 97000, 135, 650, "SPORTCARS", 24},
		{ 429, "Banshee", 105000, 182, 700, "SPORTCARS", 24},
		{ 415, "Cheetah", 113000, 176, 700, "SPORTCARS", 24},
		{ 541, "Bullet", 115000, 178, 700, "SPORTCARS", 24},
		{ 411, "Infernus", 120000, 179, 700, "SPORTCARS", 24},
		{ 451, "Turismo", 122000, 185, 700, "SPORTCARS", 24},
		{ 601, "SwatVan", 57000, 170, 750, "Swat", 25},
		{ 427, "Enforcer", 60000, 180, 750, "Swat", 25},
		{ 438, "Cabbie", 40000, 113, 750, "Taxi", 26},
		{ 420, "Taxi", 45000, 126, 750, "Taxi", 26},
		{ 449, "Tram", 0, 0, 0, "Train", 27},
		{ 537, "TrainFreight", 0, 0, 0, "Train", 27},
		{ 538, "TrainPublic", 0, 0, 0, "Train", 27},
		{ 569, "TrainFrei", 0, 0, 0, "TrainA", 27},
		{ 570, "TrainPassanger", 0, 0, 0, "TrainA", 27},
		{ 590, "TrainBox", 0, 0, 0, "TrainA", 27},
		{ 498, "Boxville", 21000, 160, 650, "TRUCKS", 28},
		{ 414, "Mule", 26000, 133, 700, "TRUCKS", 28},
		{ 456, "Yankee", 27500, 167, 700, "TRUCKS", 28},
		{ 578, "DFT30", 35000, 150, 650, "TRUCKS", 28},
		{ 573, "Dune", 37000, 200, 800, "TRUCKS", 28},
		{ 433, "Barracks", 50000, 256, 850, "TRUCKS", 28},
		{ 455, "Flatbed", 54000, 253, 850, "TRUCKS", 28},
		{ 403, "Linerunner", 65000, 228, 750, "TRUCKS", 28},
		{ 514, "PetrolTruck", 70000, 230, 800, "TRUCKS", 28},
		{ 515, "RoadTruck", 73000, 234, 800, "TRUCKS", 28},
		{ 443, "Packer", 80000, 225, 800, "TRUCKS", 28}
	};

	new menuliter[MAX_PLAYERS][MAX_MENUG_ITEMS][40];
	new playerCheckpoint[MAX_PLAYERS];
	new Text:SpeedoString[MAX_PLAYERS][4];

	new Text:TimeHour;
	new Text:TimeSec;
	new Text:TimeYear;
	new Text:vehiclebar[12];

//$ region CarStreamer
	new vehcount=0;
	new vehcount2=0;
	new vehcount3=0;
	new modelscount=0;
	new modelcount[MODEL_LIMIT];
	new playervehpriority[MAX_PLAYERS][MAX_STREAM_VEHICLES];
	new VehicleInfo[MAX_STREAM_VEHICLES][vInfo];
	new VehStreamid[MAX_VEHICLES];
//$ endregion CarStreamer
//$ region Playervars
	new PLAYERLIST_authed[MAX_PLAYERS];
	new menuPlace2[MAX_PLAYERS];
	new justbought[MAX_PLAYERS];
	new gasselect[MAX_PLAYERS];
	new Speedo[MAX_PLAYERS];
	new Speedom[MAX_PLAYERS];
	new liters[MAX_PLAYERS];
	new SinGas[MAX_PLAYERS];
	new Float:Pos[MAX_PLAYERS][4];
	new playervehiclebar[MAX_PLAYERS] = 1;
	new Float:SEXY[MAX_PLAYERS];
	new Float:HUNGRY[MAX_PLAYERS];
	new Float:THIRSTY[MAX_PLAYERS];
	new Float:HUNGERHP[MAX_PLAYERS];
	new Float:THIRSTHP[MAX_PLAYERS];
	new Float:SEXHP[MAX_PLAYERS];
	new bufu[MAX_PLAYERS];
	new Skin[MAX_PLAYERS];
	new seclevup[MAX_PLAYERS];
	new minlevup[MAX_PLAYERS];
	new NeededHour[MAX_PLAYERS];
	new NeededlevCash[MAX_PLAYERS];
	new Playerlevel[MAX_PLAYERS];
	new Hourlevel[MAX_PLAYERS];
	new giveRespectpoints[MAX_PLAYERS];
	new NormalSkin[MAX_PLAYERS];
	new interi[MAX_PLAYERS];
	new bidorbuy[MAX_PLAYERS];
	new hpayd[MAX_PLAYERS];
	new cash1[MAX_PLAYERS];
	new selling[MAX_PLAYERS];
	new thebet[MAX_PLAYERS];
	new propcost[MAX_PLAYERS];
	new playerbiz[MAX_PLAYERS];
	new profit[MAX_PLAYERS];
	new propowned[MAX_PLAYERS];
	new totalprofit[MAX_PLAYERS];
	new biznum[MAX_PLAYERS];
	new propactive[MAX_PLAYERS];
	new miniskill[MAX_PLAYERS];
	new maxiskill[MAX_PLAYERS];
	new minibet[MAX_PLAYERS];
	new maxibet[MAX_PLAYERS];
	new oldbet[MAX_PLAYERS];
	new cash[MAX_PLAYERS];
	new bool:patheditor[MAX_PLAYERS];
	new obi[MAX_PLAYERS];
	new pkey[MAX_PLAYERS];
	new Interior[MAX_PLAYERS];
	new BIZNAME[MAX_PLAYERS][256];
	new Playertimer4[MAX_PLAYERS];
//$ endregion Playervars

	new players[SLOTS][player_info];

	new propmess[256];
	new cttmp[256];
	new tmpname[256];
	new ownername[256];
	new playername1[256];
	new playername2[256];
	new playernameh[256];
	new oldname1[256];
	new str[255];
	new msv[256];

	new bizupmin=0;
	new bizbet1;
	new fastfood1;
	new fastfood2;
	new fastfood3;
	new	timer1;
	new	timer2;
	new	timer3;
	new Float:oldhealth;
	new Sodamoney;
	new newSodamoney;
	new Snackmoney;
	new newSnackmoney;
	new foodmoney;
	new newfoodmoney;
	new hvn=0;
	new keys;
	new id;
	new Float:dis;
	new Float:x2,Float:y2,Float:z2;
	new object;
	new pid2;
	new obj;
	new ob[150];
	new movespeed;
	new carsmenucreated;
//$ region Paintshopareas
	new PSvegas;
	new TSvegas;
	new PSdesertSouth;
	new PSdesertNorth;
	new PSsanfranNorth;
	new PSsanfranSouth;
	new TSsanfran;
	new TSSpecialSF;
	new PSlaCountry;
	new TSLosAngeles;
	new PSlaNorth;
	new PSlaWest;
	new PSlaEast;
	new TSlaSpecial;
//$ endregion Paintshopareas
	// --------- SODA's ------------------ SODA's ------------------ SODA's ---------
	new Float:Soda[MAX_SODA][6]={
		{2086.0, 2087.0, 2071.0, 2072.0, 11.0, 12.0},
		{2325.5,2326.5,-1646.5,-1645.5,14.0,16.0},
		{1929.0,1930.0,-1773.0,-1772.0,13.0,15.0},
		{1729.3,1730.3,-1944.4,-1943.4,13.0,15.0},
		{2352.6,2353.6,-1357.6,-1356.6,24.0,26.0},
		{2059.6,2060.6,-1899.0,-1898.0,13.0,15.0},
		{1787.8,1788.8,-1369.8,-1368.8,15.0,17.0},
		{1153.3,1154.3,-1461.4,-1460.4,15.0,17.0},
		{1278.0,1279.1,371.7,372.7,19.0,21.0},
		{199.6,200.6,-108.1,-107.1,1.0,3.0},
		{-2120.1,-2118.8,-424.0,-421.6,35.0,37.0},
		{-19.8,-18.4,-57.8,-56.4,1003.0,1005.0},
		{-1982.1,-1981.1,142.1,143.1,27.0,29.0},
		{-2420.0,-2419.0,984.0,986.5,44.5,46.5},
		{-16.8,-15.5,-91.5,-90.0,1003.0,1005.0},
		{-863.3,-862.3,1537.0,1538.0,22.0,24.0},
		{-1349.8,-1348.8,491.5,493.0,10.0,13.0},
		{-253.5,-252.5,2597.5,2599.0,62.0,64.0},
		{-2063.7,-2062.7,-491.5,-490.0,35.0,37.0},
		{-2035.0,-2034.0,-491.5,-490.0,35.0,37.0},
		{-2092.7,-2091.2,-491.5,-490.0,35.0,37.0},
		{-2006.5,-2005.0,-491.5,-490.0,35.0,37.0},
		{-2011.8,-2010.5,-398.0,-397.0,35.0,37.0},
		{-2040.5,-2039.0,-398.0,-397.0,35.0,37.0},
		{-2069.3,-2068.0,-398.0,-397.0,35.0,37.0},
		{-2098.0,-2096.5,-398.0,-397.0,35.0,37.0},
		{2319.3,2320.8,2531.5,2532.5,10.0,12.0},
		{1518.5,1519.8,1054.5,1056.0,10.0,12.0},
		{2502.5,2503.8,1244.0,1245.0,10.0,12.0},
		{-33.0,-32.0,-186.6,-185.4,1003.0,1005.0},
		{501.3,502.4,-2.9,-1.6,1000.0,1002.0},
		{495.3,496.4,-24.1,-22.8,1000.0,1002.0},
		{373.3,374.4,-179.5,-178.3,1000.0,1002.0},
		{2223.8,2225.0,-1154.0,-1152.8,1025.0,1027.0},
		{2575.3,2576.5,-1285.1,-1283.8,1060.0,1062.0},
		{-36.4,-35.0,-140.1,-138.8,1003.0,1005.0},
		{-15.7,-14.4,-140.1,-138.8,1003.0,1005.0},
		{2156.0,2157.3,1606.2,1607.4,999.0,1001.0},
		{2222.3,2223.7,1606.1,1607.4,999.0,1001.0},
		{2208.4,2209.8,1606.4,1607.7,999.0,1001.0}};
	new Float:Snack[MAX_SNACK][6]={
		{2480.2,2481.5,-1959.2,-1957.8,13.0,15.0},
		{2139.6,2140.9,-1162.1,-1160.8,23.0,25.0},
		{1633.5,1634.7,-2239.0,-2237.6,13.0,15.0},
		{2153.2,2154.5,-1016.4,-1015.0,62.0,64.0},
		{661.8,663.0,-552.0,-550.8,16.0,18.0},
		{-2229.9,-2228.5,286.5,287.8,35.0,37.0},
		{-76.0,-74.6,1227.2,1228.6,19.0,21.0},
		{-1350.0,-1348.6,493.2,494.5,10.5,12.5},
		{-253.6,-252.3,2599.0,2600.3,62.0,64.0},
		{1398.0,1399.3,2222.7,2224.0,10.5,12.5},
		{2845.0,2846.4,1293.7,1295.0,10.5,12.5},
		{2647.0,2648.4,1128.2,1129.6,10.5,12.5},
		{-34.6,-33.2,-186.7,-185.3,1003.0,1005.0},
		{499.8,501.2,-2.8,-1.4,1000.0,1002.0},
		{377.6,379.0,-179.5,-178.1,1000.0,1002.0},
		{-17.3,-15.9,-140.2,-138.8,1003.0,1005.0},
		{374.3,375.7,187.5,188.9,1007.5,1009.5},
		{360.8,362.2,158.6,160.0,1007.5,1009.5},
		{350.9,352.3,205.4,206.8,1007.5,1009.5},
		{371.0,372.3,176.8,178.2,1019.0,1021.0},
		{330.0,332.7,177.0,178.4,1019.0,1021.0},
		{2156.0,2157.3,1607.41,1608.7,999.0,1001.0},
		{315.1,316.5,-141.2,-139.8,999.0,1001.0},
		{2201.7,2203.1,1617.0,1618.4,999.0,1001.0},
		{2208.6,2210.0,1619.8,1621.2,999.0,1001.0},
		{2222.4,2223.8,1602.0,1603.4,999.0,1001.0}};
	new	Sodaarea[MAX_SODA];
	new Snackarea[MAX_SNACK];
	new skinpl[MAX_SKINS]={
	0, 1, 2, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35,
 	36,	37, 38, 39, 40, 41, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 66,
 	67, 68, 69, 70, 71, 72, 73, 76, 77, 78, 79, 80,	81, 82, 83, 84, 85, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98,
 	99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110,	111, 112, 113, 114, 115, 116, 117, 118, 120, 121, 122,
 	123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145,
 	146, 147, 148, 150, 151, 152, 153, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170,
	171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193,
 	194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205,	206, 207, 209, 210, 211, 212, 213, 214, 215, 216, 217,
 	218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240,
 	241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253,};

	new weapmod[600] = {1212,331,333,334,335,336,337,338,339,341,321,322,323,324,
		325,326,342,343,344,345,345,345,346,347,348,349,350,351,352,353,355,356,372,357,
	358,359,360,361,362,363,364,365,366,367,368,369,371};

	new VehicleModels[260];
	new PickUpMoney[101] = {false, ...};
	new Float:PickUpArmour[101] = {0.0, ...}; // added by uncajesse
	new PickUpMoneyAmmount[101] = {0, ...}; // added by uncajesse
	new PickUpWeaponSlot[101] = {0, ...}; // added by uncajesse
	new PickUpWeaponAmmo[101] = {0, ...}; // added by uncajesse
	new DropPick[101] = {false, ...};
//$ endregion new variables
Float:GetPlayerArmourEx(p){
	new Float:b;
	GetPlayerArmour(p, b);
	return b;}
Float:GetXYOfVehicle(vehicleid, &Float:x, &Float:y, Float:distance){
	new Float:a;
	GetPlayerPos(vehicleid, x, y, a);
	GetVehicleZAngle(vehicleid, a);
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
	return a;}
GetPlayerPosPower(playerid,Float: X,Float: Y,Float: Z,Float:PowX,Float:PowY,Float:PowZ,Float: PowXYZ){
	new Float: CtX,Float:CtY,Float:CtZ;
	new Float: DtX,Float: DtY,Float:DtZ;
	GetPlayerPos(playerid,CtX,CtY,CtZ);
	DtX = (CtX -X); DtY = (CtY -Y); DtZ = (CtZ -Z);
	if(DtX< PowXYZ+PowX && DtX> -PowXYZ+PowX && DtY < PowXYZ+PowY  && DtY > -PowXYZ+PowY && DtZ < PowXYZ+PowZ && DtZ > -PowXYZ+PowZ){
		return true;}
	return false;}
main(){
	print("\n----------------------------------");
	print("  Carlito's Way (Under Construction)");
	print("----------------------------------\n");
}
public SODA(playerid){
	newSodamoney = GetPlayerMoney(playerid);
	if (newSodamoney==Sodamoney-1){
	THIRSTY[playerid]= THIRSTY[playerid]-2;
	Sodamoney=newSodamoney;}
	if (THIRSTY[playerid]< 0){
	THIRSTY[playerid]=0;}
	}
public SNACK(playerid){
	newSnackmoney = GetPlayerMoney(playerid);
	if (newSnackmoney==Snackmoney-1){
	HUNGRY[playerid]= HUNGRY[playerid]-1;
	Snackmoney=newSnackmoney;}
	if (HUNGRY[playerid]< 0){
	HUNGRY[playerid]=0;}
	}
public FASTFOOD(playerid){
	newfoodmoney = GetPlayerMoney(playerid);
	if (newfoodmoney==foodmoney-2){
	HUNGRY[playerid]= HUNGRY[playerid]-2;
	SendClientMessage(playerid, COLOR_YELLOW, "eat for 2$");
	foodmoney=newfoodmoney;}
	else if (newfoodmoney==foodmoney-5){
	HUNGRY[playerid]= HUNGRY[playerid]-4;
	SendClientMessage(playerid, COLOR_YELLOW, "eat for 5$");
	foodmoney=newfoodmoney;}
	else if (newfoodmoney==foodmoney-6){
	HUNGRY[playerid]= HUNGRY[playerid]-5;
	SendClientMessage(playerid, COLOR_YELLOW, "eat for 6$");
	foodmoney=newfoodmoney;}
	else if (newfoodmoney==foodmoney-10){
	HUNGRY[playerid]= HUNGRY[playerid]-7;
	SendClientMessage(playerid, COLOR_YELLOW, "eat for 10$");
	foodmoney=newfoodmoney;}
	else if (newfoodmoney==foodmoney-12){
	HUNGRY[playerid]= HUNGRY[playerid]-8;
	SendClientMessage(playerid, COLOR_YELLOW, "eat for 12$");
	foodmoney=newfoodmoney;}
	if (HUNGRY[playerid]< 0){
	HUNGRY[playerid]=0;}
	}
public bizup(){
	//wird jede minute augeführt
	new h, m, s;
	new lastowner[256];
	new lastowned;
	new currentown;
	new oldbuysum;
	new oldbuy;
	new bid;
	new payd;
	new ownerb[256];
	new totalprofit1;
	new name2[256];
	new playername3[256];
	new playername4[256];
	new forsell;
	gettime(h, m, s); //Zeit
	if (m == bizupmin && s == 0){ //Wenn die minute 30 kommt
	for(new tempa=0;tempa<=MAX_HOUSES;tempa++) { // Für jedes biz
		format(tmpname,sizeof(tmpname),"BIZ%d",tempa);  //-wird eine "BIZnummer" erstellt und mit tmpname festgelegt
    	lastowner = dini_Get(tmpname,"owner");
		playername3 = dini_Get(tmpname,"oldbetor");
		name2 = dini_Get(tmpname,"name");
		lastowned = dUserINT(lastowner).("bizowned");
		currentown = dUserINT(playername3).("bizowned");
		oldbuysum = dini_Int(tmpname,"oldbet");
		oldbuy = dini_Int(tmpname,"oldbuy");
		totalprofit1 = dini_Int(tmpname,"totalprofit");
		payd = dini_Int(tmpname,"payd");
		forsell = dini_Int(tmpname,"forselling");
		if(strcmp(playername3,"Goverment",false) == 0 || (payd < 1 && forsell==0)){
			return 1;}
		else if (forsell==2 || payd > 1){
		dini_IntSet(tmpname, "bought",1);
		dUserSetINT(lastowner).("bizowned", lastowned - 1);
		dUserSetINT(playername3).("bizowned", currentown + 1);
	 //Hier wird festgelegt, welches biz der spieler besitzt, und die biznummer festgehalten
		dini_Set(tmpname,"owner", playername3); //der neue besitzer wird festgelegtdini_IntSet(tmpname, "bought", 1);
		ownerb = dini_Get(tmpname,"owner");
		dini_IntSet(tmpname,"oldbuy", oldbuysum);
		dini_IntSet(cttmp, "totalprofit", 0);
		dini_Set(tmpname,"oldbetor","Goverment");
		dini_IntSet(tmpname,"oldbet",0);
		dini_IntSet(tmpname, "propcost", 0);
		for(new k=0;k<=MAX_PLAYERS;k++) {
	    if(IsPlayerConnected(k)) {
			GetPlayerName(k,playername4,sizeof(playername4));
  	 		if(strcmp(ownerb,playername4,false) == 0) {
			format(propmess, sizeof(propmess), "You just bought the %s for $%d. U can get your earnings at your buisness", name2, oldbuysum);
			SendClientMessage(k, COLOR_GREEN, propmess);}
  	 		if(strcmp(lastowner,playername4,false) == 0) {
                GivePlayerMoney(k, oldbuy + totalprofit1);
				format(propmess, sizeof(propmess), "%s just bought your %s for $%d. Here is your businessbid and the profit back ($%d)", ownerb, name2, oldbuysum, oldbuy + totalprofit1);
				SendClientMessage(k, COLOR_GREEN, propmess);}
				else{
				bid = dUserINT(lastowner).("bid");
				dUserSetINT(lastowner).("bid",oldbuy + totalprofit1 + bid);}}
    			}}}}
				//das biz wurde gekauft, der totalprofit steigt
	return 1;
}
public payup(){
	new payd;
	new hbought;
	for(new tempa=0;tempa<=MAX_HOUSES;tempa++) {
		// Für jedes biz
		format(tmpname,sizeof(tmpname),"BIZ%d",tempa);  //-wird eine "BIZnummer" erstellt und mit tmpname festgelegt
        if (!dini_Exists(tmpname)) {
			hbought = dini_Int(tmpname, "bought");
			if (hbought == 1){
				payd = dini_Int(tmpname,"payd");
				dini_IntSet(tmpname,"payd",payd+1);}
		}
	}
}
public profitup(){
	//wird jede volle stunde angewendet
	for(new tempa=0;tempa<=MAX_HOUSES;tempa++) {
		format(tmpname,sizeof(tmpname),"BIZ%d",tempa);  //-wird eine "BIZnummer" erstellt und mit tmpname festgelegt
	 	propowned[tempa] = dini_Int(tmpname, "bought"); //-wird eine 1 ausgegeben wenn jemand es gekauft hat
		if (propowned[tempa] == 1) {
		    new tmp[256];   //totalprofit und profit zusammen
			totalprofit[tempa] = dini_Int(tmpname, "totalprofit"); //Der totalProfit von biz der schon gegeben ist
			profit[tempa] = dini_Int(tmpname, "profit"); // Der Profit den das biz verdient
			tmp[tempa] = profit[tempa]+totalprofit[tempa]; //beides zusammen
			dini_IntSet(tmpname, "totalprofit", tmp[tempa]); //der neue totalprofit
    	}
		else{
			new tmp[256];   //govermentprofit FÜR DIE REGIERUNG
			totalprofit[tempa] = dini_Int(tmpname, "govermentprofit"); //Der totalProfit von biz der schon gegeben ist
			profit[tempa] = dini_Int(tmpname, "profit"); // Der Profit den das biz verdient
			tmp[tempa] = profit[tempa]+totalprofit[tempa]; //beides zusammen
			dini_IntSet(tmpname, "govermentprofit", tmp[tempa]); //der neue totalprofit
			}
	}
	for(new i=0;i<=MAX_PLAYERS;i++) {
	    if(IsPlayerConnected(i)) {
	    	new ownera[MAX_PLAYERS];
			new playername4[256];
		   	GetPlayerName(i, playername4, sizeof(playername4)); //jeder playername
		    ownera[i] = dUserINT(playername4).("bizowned"); //hier wird gecheckt welcher dieser playernamen ein biz besitzt
	    	if(ownera[i] > 0) { //wenn jemand ein biz beistzt
				SendClientMessage(i,COLOR_GREEN,"The profit for your propertys has been updated.");
    			SendClientMessage(i,COLOR_GREEN,"Return to your propertys and type /getprofit to get your earnings.");
			}
		}
	}
	return 1;
}
public fick(playerid){
	SendClientMessage(playerid,COLOR_RED,"U have left the Server. U have to /register or /login first before spawning!!! ");
	Kick(playerid);}
public ClearPlayerChatBox(playerid){
	SendClientMessage(playerid, COLOR_YELLOW, " ");
 	SendClientMessage(playerid, COLOR_YELLOW, " ");
  	SendClientMessage(playerid, COLOR_YELLOW, " ");
   	SendClientMessage(playerid, COLOR_YELLOW, " ");
   	SendClientMessage(playerid, COLOR_YELLOW, " ");
   	SendClientMessage(playerid, COLOR_YELLOW, " ");
   	SendClientMessage(playerid, COLOR_YELLOW, " ");
   	SendClientMessage(playerid, COLOR_YELLOW, " ");
   	SendClientMessage(playerid, COLOR_YELLOW, " ");
   	SendClientMessage(playerid, COLOR_YELLOW, " ");
}
showinfo(playerid,s[],t[],u[],v,w,Float:x,Float:y,Float:z){
GameTextForPlayer(playerid,t,6000,6);hvn=v;
format(msv,sizeof(msv),"Angle: %d",w);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"Interior: %d",hvn);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"X: %f",x);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"Y: %f",y);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"Z: %f",z);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"Title: %s",t);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"Scm/User name: %s",u);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"Comments: %s",s);SendClientMessage(playerid,C,msv);
SetCameraBehindPlayer(playerid);SetPlayerInterior(playerid,hvn);
SetPlayerFacingAngle(playerid,w);SetPlayerPos(playerid,x,y,z);return 1;}
public GetVehicleType(vid) {
	new type;
// ================== CARS =======
	switch(VehicleModels[vid]) {
	case
	416,   //ambulan  -  car
	445,   //admiral  -  car
	602,   //alpha  -  car
	485,   //baggage  -  car
	568,   //bandito  -  car
	429,   //banshee  -  car
	499,   //benson  -  car
	424,   //bfinject,   //car
	536,   //blade  -  car
	496,   //blistac  -  car
	504,   //bloodra  -  car
	422,   //bobcat  -  car
	609,   //boxburg  -  car
	498,   //boxville,   //car
	401,   //bravura  -  car
	575,   //broadway,   //car
	518,   //buccanee,   //car
	402,   //buffalo  -  car
	541,   //bullet  -  car
	482,   //burrito  -  car
	431,   //bus  -  car
	438,   //cabbie  -  car
	457,   //caddy  -  car
	527,   //cadrona  -  car
	483,   //camper  -  car
	524,   //cement  -  car
	415,   //cheetah  -  car
	542,   //clover  -  car
	589,   //club  -  car
	480,   //comet  -  car
	596,   //copcarla,   //car
	599,   //copcarru,   //car
	597,   //copcarsf,   //car
	598,   //copcarvg,   //car
	578,   //dft30  -  car
	486,   //dozer  -  car
	507,   //elegant  -  car
	562,   //elegy  -  car
	585,   //emperor  -  car
	427,   //enforcer,   //car
	419,   //esperant,   //car
	587,   //euros  -  car
	490,   //fbiranch,   //car
	528,   //fbitruck,   //car
	533,   //feltzer  -  car
	544,   //firela  -  car
	407,   //firetruk,   //car
	565,   //flash  -  car
	455,   //flatbed  -  car
	530,   //forklift,   //car
	526,   //fortune  -  car
	466,   //glendale,   //car
	604,   //glenshit,   //car
	492,   //greenwoo,   //car
	474,   //hermes  -  car
	434,   //hotknife,   //car
	502,   //hotrina  -  car
	503,   //hotrinb  -  car
	494,   //hotring  -  car
	579,   //huntley  -  car
	545,   //hustler  -  car
	411,   //infernus,   //car
	546,   //intruder,   //car
	559,   //jester  -  car
	508,   //journey  -  car
	571,   //kart  -  car
	400,   //landstal,   //car
	403,   //linerun  -  car
	517,   //majestic,   //car
	410,   //manana  -  car
	551,   //merit  -  car
	500,   //mesa  -  car
	418,   //moonbeam,   //car
	572,   //mower  -  car
	423,   //mrwhoop  -  car
	516,   //nebula  -  car
	582,   //newsvan  -  car
	467,   //oceanic  -  car
	404,   //peren  -  car
	514,   //petro  -  car
	603,   //phoenix  -  car
	600,   //picador  -  car
	413,   //pony  -  car
	426,   //premier  -  car
	436,   //previon  -  car
	547,   //primo  -  car
	489,   //rancher  -  car
	441,   //rcbandit,   //car
	594,   //rccam  -  car
	564,   //rctiger  -  car
	515,   //rdtrain  -  car
	479,   //regina  -  car
	534,   //remingtn,   //car
	505,   //rnchlure,   //car
	442,   //romero  -  car
	440,   //rumpo  -  car
	475,   //sabre  -  car
	543,   //sadler  -  car
	605,   //sadlshit,   //car
	495,   //sandking,   //car
	567,   //savanna  -  car
	428,   //securica,   //car
	405,   //sentinel,   //car
	535,   //slamvan  -  car
	458,   //solair  -  car
	580,   //stafford,   //car
	439,   //stallion,   //car
	561,   //stratum  -  car
	409,   //stretch  -  car
	560,   //sultan  -  car
	550,   //sunrise  -  car
	506,   //supergt  -  car
	601,   //swatvan  -  car
	574,   //sweeper  -  car
	566,   //tahoma  -  car
	549,   //tampa  -  car
	420,   //taxi  -  car
	459,   //topfun  -  car
	576,   //tornado  -  car
	583,   //tug  -  car
	451,   //turismo  -  car
	558,   //uranus  -  car
	552,   //utility  -  car
	540,   //vincent  -  car
	491,   //virgo  -  car
	412,   //voodoo  -  car
	478,   //walton  -  car
	421,   //washing  -  car
	529,   //willard  -  car
	555,   //windsor  -  car
	456,   //yankee  -  car
	554,   //yosemite,   //car
	477   //zr3	50  -  car
	: type = VTYPE_CAR;

// ================== BIKES =======
	case
	581,   //bf400  -  bike
	523,   //copbike  -  bike
	462,   //faggio  -  bike
	521,   //fcr900  -  bike
	463,   //freeway  -  bike
	522,   //nrg500  -  bike
	461,   //pcj600  -  bike
	448,   //pizzaboy,   //bike
	468,   //sanchez  -  bike
	586,   //wayfarer,   //bike
	509,   //bike  -  bmx
	481,   //bmx  -  bmx
	510,   //mtbike  -  bmx
	471   //quad  -  quad
	: type = VTYPE_BIKE;

// ================== SEA =======
	case
	472,   //coastg  -  boat
	473,   //dinghy  -  boat
	493,   //jetmax  -  boat
	595,   //launch  -  boat
	484,   //marquis  -  boat
	430,   //predator,   //boat
	453,   //reefer  -  boat
	452,   //speeder  -  boat
	446,   //squalo  -  boat
	454   //tropic  -  boat
	: type = VTYPE_SEA;

// ================== AIR =======
	case
	548,   //cargobob,   //heli
	425,   //hunter  -  heli
	417,   //leviathn,   //heli
	487,   //maverick,   //heli
	497,   //polmav  -  heli
	563,   //raindanc,   //heli
	501,   //rcgoblin,   //heli
	465,   //rcraider,   //heli
	447,   //seaspar  -  heli
	469,   //sparrow  -  heli
	488,   //vcnmav  -  heli
	592,   //androm  -  plane
	577,   //at	400  -  plane
	511,   //beagle  -  plane
	512,   //cropdust,   //plane
	593,   //dodo  -  plane
	520,   //hydra  -  plane
	553,   //nevada  -  plane
	464,   //rcbaron  -  plane
	476,   //rustler  -  plane
	519,   //shamal  -  plane
	460,   //skimmer  -  plane
	513,   //stunt  -  plane
	539   //vortex  -  plane
	: type = VTYPE_AIR;

// ================== HEAVY =======
	case
	588,   //hotdog  -  car
	437,   //coach  -  car
	532,   //combine  -  car
	433,   //barracks,   //car
	414,   //mule  -  car
	443,   //packer  -  car
	470,   //patriot  -  car
	432,   //rhino  -  car
	525,   //towtruck,   //car
	531,   //tractor  -  car
	408,   //trash  -  car
	406,   //dumper  -  mtruck
	573,   //duneride,   //mtruck
	444,   //monster  -  mtruck
	556,   //monstera,   //mtruck
	557,   //monsterb,   //mtruck
	435,   //artict1  -  trailer
	450,   //artict2  -  trailer
	591,   //artict3  -  trailer
	606,   //bagboxa  -  trailer
	607,   //bagboxb  -  trailer
	610,   //farmtr1  -  trailer
	584,   //petrotr  -  trailer
	608,   //tugstair,   //trailer
	611,   //utiltr1  -  trailer
	590,   //freibox  -  train
	569,   //freiflat,   //train
	537,   //freight  -  train
	538,   //streak  -  train
	570,   //streakc  -  train
	449   //tram  -  train
	: type = VTYPE_HEAVY;
	}
	return type;
}
stock PlayerName(playerid) {
  new name[MAX_PLAYER_NAME];
  GetPlayerName(playerid, name, MAX_PLAYER_NAME);
  return name;}
public PlayerPickUpPickupSetAmmo(playerid, slotid, slotammo){
	SetPlayerAmmo(playerid,slotid,slotammo);
}
public PlayerPickUpPickupSetArmour(playerid, Float:playerarmour){
	SetPlayerArmour(playerid,playerarmour);
}
public PickDestroy(o)DestroyPickup(o); // Destroy pickup ! Muha xD!
stock PutAtPos(playerid) {
  if (dUserINT(PlayerName(playerid)).("oldvehicle")!=0) {
	PutPlayerInVehicle(playerid,(dUserINT(PlayerName(playerid)).("oldvehicle")),0);
  }
  if (dUserINT(PlayerName(playerid)).("x")!=0) {
      SendClientMessage(playerid,COLOR_GREEN,"Setting you to your last position. Welcome back!");
      SetPlayerPos(playerid,
                   float(dUserINT(PlayerName(playerid)).("x")),
                   float(dUserINT(PlayerName(playerid)).("y")),
                   float(dUserINT(PlayerName(playerid)).("z")));}
  if (dUserINT(PlayerName(playerid)).("a")!=0) {
	SetPlayerFacingAngle(playerid,float(dUserINT(PlayerName(playerid)).("a")));  }  }
public CalculateSpeed(playerid)	{
	new Float:x,Float:y,Float:z,Float:carba;
	new Float:distance,value,value2;
	new string[255];
	for(new i=0; i<MAX_PLAYERS; i++){
		if(IsPlayerConnected(i)){
			GetPlayerPos(i, x, y, z);
			distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
        	value = floatround(distance * 3600);
        	value2 = floatround(distance);
			Speedo[i] = (value/1000);
			Speedom[i] = value2;
			SavePlayerPos[i][LastX] = x;
			SavePlayerPos[i][LastY] = y;
			SavePlayerPos[i][LastZ] = z;
			if (patheditor[i]&&Speedo[i]!=0){
				GetVehicleZAngle(GetPlayerVehicleID(playerid),carba);
				format(string, sizeof(string),"distance: %f  value: %d  Speedo: %d Speedom: %d  POS: %f X, %f Y, %f Z, %f Angle", distance, value, Speedo[i], Speedom[i], SavePlayerPos[i][LastX], SavePlayerPos[i][LastY], SavePlayerPos[i][LastZ],carba);
				SendClientMessage(playerid,COLOR_WHITE,string);
				writepath(playerid,string);}
		}
	}
}
public OnGameModeInit(){
	new carname[256];
	new modname[256];
	print("Carlito's Way");
	SetGameModeText("Carlito's Way");
	LimitGlobalChatRadius(30);
	AllowInteriorWeapons(0);
	//$ region time-textdraw
    TimeHour = TextDrawCreate(548, 16, "00:00");
    TimeYear = TextDrawCreate(505.0, 1.5, "00:00 0000");
	TimeSec = TextDrawCreate(606, 16, "00");
	TextDrawLetterSize(TimeYear, 0.6, 1.8);
	TextDrawFont(TimeYear, 2);
	TextDrawSetOutline(TimeYear, 2);
	TextDrawLetterSize(TimeSec, 0.4, 1.1);
	TextDrawFont(TimeSec, 2);
	TextDrawSetShadow(TimeSec, 2);
	TextDrawSetOutline(TimeSec,2);
	TextDrawLetterSize(TimeHour, 0.5, 1.5);
	TextDrawFont(TimeHour, 2);
	TextDrawSetShadow(TimeHour, 2);
	TextDrawSetOutline(TimeHour,2);
	//$ endregion time-textdraw
	//$ region vehiclehealthbar-textdraw
	vehiclebar[0] = TextDrawCreate(549.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[0], true);
	TextDrawBoxColor(vehiclebar[0], 0x000000ff);
	TextDrawSetShadow(vehiclebar[0],0);
	TextDrawTextSize(vehiclebar[0], 604, 0);
	vehiclebar[1] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[1], true);
	TextDrawBoxColor(vehiclebar[1], 0x004400ff);
	TextDrawSetShadow(vehiclebar[1],0);
	TextDrawTextSize(vehiclebar[1], 602, 0);
	vehiclebar[2] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[2], true);
	TextDrawBoxColor(vehiclebar[2], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[2],0);
	TextDrawTextSize(vehiclebar[2], 556, 0);
	vehiclebar[3] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[3], true);
	TextDrawBoxColor(vehiclebar[3], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[3],0);
	TextDrawTextSize(vehiclebar[3], 561, 0);
	vehiclebar[4] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[4], true);
	TextDrawBoxColor(vehiclebar[4], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[4],0);
	TextDrawTextSize(vehiclebar[4], 566, 0);
	vehiclebar[5] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[5], true);
	TextDrawBoxColor(vehiclebar[5], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[5],0);
	TextDrawTextSize(vehiclebar[5], 571, 0);
	vehiclebar[6] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[6], true);
	TextDrawBoxColor(vehiclebar[6], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[6],0);
	TextDrawTextSize(vehiclebar[6], 576, 0);
	vehiclebar[7] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[7], true);
	TextDrawBoxColor(vehiclebar[7], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[7],0);
	TextDrawTextSize(vehiclebar[7], 581, 0);
	vehiclebar[8] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[8], true);
	TextDrawBoxColor(vehiclebar[8], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[8],0);
	TextDrawTextSize(vehiclebar[8], 586, 0);
	vehiclebar[9] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[9], true);
	TextDrawBoxColor(vehiclebar[9], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[9],0);
	TextDrawTextSize(vehiclebar[9], 591, 0);
	vehiclebar[10] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[10], true);
	TextDrawBoxColor(vehiclebar[10], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[10],0);
	TextDrawTextSize(vehiclebar[10], 596, 0);
	vehiclebar[11] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[11], true);
	TextDrawBoxColor(vehiclebar[11], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[11],0);
	TextDrawTextSize(vehiclebar[11], 602, 0);
	//$ endregion vehiclehealthbar-textdraw
	//$ region Timers
	SetTimer("Speedometer",1000,1);
	SetTimer("checkpointupdate",1000,1);
	SetTimer("InitiateSectorSystem",5000,0);
	SetTimer("TIMER_DCallbacks",1,true);
	SetTimer("profitup",300000,1); //FUNCTION profitup wird jede 5min angewendet
	SetTimer("bizup",60000,1);
	SetTimer("payup",60000,1);
	SetTimer("VEHICLEHEALTH",250,1);
	SetTimer("Menutimer", 350, true);
	SetTimer("StreamVehicles",1000,1);
	SetTimer("SaveCars",10000,1);
	BrakeTimer = SetTimer("ObjectUpdate",700,1);
	ObjectBrakeTimer = SetTimer("ObjectToObjectUpdate",800,1);
	//$ endregion Timers
	for(new u=0;u<MAX_DRIVEPOINTS;u++){
		for(new j=0;j<4;j++){
			if(Connections[u][j] != 0){
				ConnectionsAmount[u]++;
			}
		}
	}
	for (new l = 0; l < MAX_SODA; l++){
		Sodaarea[l]=AddAreaCheck(Soda[l][0], Soda[l][1], Soda[l][2], Soda[l][3], Soda[l][4], Soda[l][5]);
	}
	for (new o = 0; o < MAX_SNACK; o++){
		Snackarea[o]=AddAreaCheck(Snack[o][0], Snack[o][1], Snack[o][2], Snack[o][3], Snack[o][4], Snack[o][5]);
	}
	for (new sk = 0; sk < MAX_SKINS; sk++){
		AddPlayerClass(skinpl[sk], 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	}
	/*for (new b = 0; b < MAX_DRIVEPOINTS2; b++){
		drivepickup[b] = CreateStreamPickup(1239,23,DrivePoints2[b][0],DrivePoints2[b][1],DrivePoints2[b][2]);
		drivearea[b] = AddAreaCheck(DrivePoints2[b][0]-0.5,DrivePoints2[b][0]+0.5,DrivePoints2[b][1]-0.5,DrivePoints2[b][1]+0.5,DrivePoints2[b][2]-0.5,DrivePoints2[b][2]+0.5);
	}
	for (new k = 0; k < MAX_HOUSES; k++){
		streampick[k] = CreateStreamPickup(1239,23,Houses[k][hx],Houses[k][hy],Houses[k][hz]);
		housearea[k] = AddAreaCheck(Houses[k][hx]-1,Houses[k][hx]+1,Houses[k][hy]-1,Houses[k][hy]+1,Houses[k][hz]-1,Houses[k][hz]+1);
	}*/
	for (new i=0;i < MAX_PLAYERS;i++){
	    SpeedoInfo[i][enabled]=true;
	    SpeedoInfo[i][metric]=true;
	}
	for(new n = 0; n < MAX_STREAM_VEHICLES; n++){
		format(carname,sizeof(carname),"Car%d",n);
		VehicleInfo[n][idnum]=-1;
		if (dini_Exists(carname)){
			VehicleInfo[n][veh_pos][0]=dini_Float(carname,"x");
			VehicleInfo[n][veh_pos][1]=dini_Float(carname,"y");
			VehicleInfo[n][veh_pos][2]=dini_Float(carname,"z");
			VehicleInfo[n][veh_pos][3]=dini_Float(carname,"a");
			for (new mo = 0; mo < MAX_COMPONENTS; mo++){
				format(modname,sizeof(modname),"mod%d",mo);
				VehicleInfo[n][COMPONENTS][mo]=dini_Int(carname,modname);
			}
			VehicleInfo[n][paintjob]=dini_Int(carname,"paintjob");
			VehicleInfo[n][security]=dini_Int(carname,"security");
			VehicleInfo[n][priority]=dini_Int(carname,"priority");
			VehicleInfo[n][model]=dini_Int(carname,"model");
			VehicleInfo[n][owner]=dini_Get(carname,"ownername");
			//VehicleInfo[n][ownerid]=dini_Int(carname,"ownerid");
			VehicleInfo[n][CREATED]=dini_Int(carname,"CREATED");
			VehicleInfo[n][tank]=dini_Int(carname,"tank");
			VehicleInfo[n][meters]=dini_Int(carname,"meters");
			VehicleInfo[n][oilpress]=dini_Int(carname,"oilpress");
			VehicleInfo[n][oilminimum]=dini_Int(carname,"oilminimum");
			VehicleInfo[n][oildamage]=dini_Int(carname,"oildamage");
			VehicleInfo[n][locked]=dini_Int(carname,"locked");
			//VehicleInfo[n][numberplate]=dini_Get(carname,"numberplate");
			VehicleInfo[n][health]=dini_Float(carname,"health");
			VehicleInfo[n][key]=dini_Int(carname,"key");
			VehicleInfo[n][world]=dini_Int(carname,"world");
			VehicleInfo[n][interior]=dini_Int(carname,"interior");
			VehicleInfo[n][colors][0]=dini_Int(carname,"color1");
			VehicleInfo[n][colors][1]=dini_Int(carname,"color2");
			VehicleInfo[n][streamid]=dini_Int(carname,"streamid");
		}
	}
	PSvegas=AddAreaCheck(1967.0, 1968.0, 2158.74, 2166.1, 10.0, 13.0);
	TSvegas=AddAreaCheck(2382.9, 2390.35, 1041.8, 1042.8, 10.0, 13.0);
	PSdesertSouth=AddAreaCheck(-103.73, -96.16, 1109.95, 1110.95, 19.2, 23.0);
	PSdesertNorth=AddAreaCheck(-1424.25, -1416.7, 2591.6, 2592.6, 55.3, 59.0);
	PSsanfranNorth=AddAreaCheck(-2429.4, -2421.86, 1028.69, 1029.69, 50.0, 53.0);
	PSsanfranSouth=AddAreaCheck(-1908.25, -1900.8, 276.22, 277.22, 40.5, 44.0);
	TSsanfran=AddAreaCheck(-1939.44, -1932.3, 237.05, 238.05, 33.9, 36.0);
	TSSpecialSF=AddAreaCheck(-2716.56, -2715.56, 213.9, 221.05, 4.0, 7.0);
	PSlaCountry=AddAreaCheck(717.5, 722.4, -463.05, -462.05, 16.0, 19.0);
	TSLosAngeles=AddAreaCheck(1038.35, 1044.1, -1026.43, -1025.43, 31.8, 35.0);
	PSlaNorth=AddAreaCheck(1022.78, 1027.23, -1029.9, -1028.9, 31.8, 35.0);
	PSlaWest=AddAreaCheck(485.92, 490.7, -1735.0, -1734.0, 10.8, 14.0);
	PSlaEast=AddAreaCheck(2071.0, 2072.0, -1833.72, -1829.15, 13.0, 16.0);
	TSlaSpecial=AddAreaCheck(2641.21, 2648.82, -2039.74, -2038.74, 13.0, 16.0);
	fastfood1=AddAreaCheck(372.0,379.0,-71.7,-64.7,1001.0,1003.0);
	fastfood2=AddAreaCheck(365.3,372.3,-10.3,-3.3,1001.0,1003.0);
	fastfood3=AddAreaCheck(370.5,377.5,-123.0,-116.0,1001.0,1003.0);
	LoadTotalItems();
	MAX_SLOTS_tAxI = GetMaxPlayers();
/*	gateobj[0] = CreateObject(11327,1534.783203,-1451.301269,14.8,0.000000,-360.000000,-450.000000); //gate im zentrum //aud 20 Z-Pos
	gateobj[1] = CreateObject(11327,1534.783203,-1451.301269,17.8,0.000000,-360.000000,-450.000000); //gate im zentrum //aud 20 Z-Pos
	gateobj[2] = CreateObject(968,1544.704956,-1630.855590,13.265414,2.000000,-91.000000,-90.000000); //policegate1 LS //auf 0 Y-Rot
	gateobj[3] = CreateObject(994,1544.676269,-1617.597290,12.617223,0.000000,0.000000,-90.000000);//policegate1 LS fest
	gateobj[4] = CreateObject(995,1543.796020,-1633.644409,13.382812,-271.000000,-85.000000,-5.000000);//policegate1 LS fest
	gateobj[5] = CreateObject(6400,1590.603759,-1638.147216,14.611213,360.000000,0.000000,-92.000000);//policegate2 LS //auf 80 Y-Rot & z verschieben
	gateobj[6] = CreateObject(6400,1586.774291,-1637.963378,14.611213,360.000000,0.000000,-92.000000);//policegate2 LS //auf 80 Y-Rot & z verschieben
	gateobj[7] = CreateObject(1497,1582.578979,-1638.021972,12.446459,0.000000,0.000000,2.000000);//policegaragedoor LS //auf -80 Z-Rot
	gateobj[8] = CreateObject(8041,1811.435424,-1889.830078,18.008668,0.000000,0.000000,0.000000);//P UnityStation P-Bude
	gateobj[9] = CreateObject(991,1777.994140,-1942.22,13.7,0.000000,0.000000,-180.000000);//Zaun P UnityStation
	gateobj[0] = CreateObject(991,1771.410766,-1942.22,13.7,0.000000,0.000000,-180.000000);//Zaun P UnityStation
	gateobj[11] = CreateObject(991,1764.798583,-1942.22,13.7,0.000000,0.000000,-180.000000);//Zaun P UnityStation
	gateobj[12] = CreateObject(1497,1759.605102,-1942.192382,12.548379,0.000000,0.000000,0.000000);//P UnityStation Door
	gateobj[13] = CreateObject(968,1811.233764,-1881.620605,13.414062,0.000000,-91.000000,90.000000);//P UnityStation Gate1 //auf -3 Y-Rot
	gateobj[14] = CreateObject(968,1810.733764,-1897.905517,13.414062,0.000000,90.000000,90.000000);//P UnityStation Gate2 //auf 3 Y-Rot
	gateobj[15] = CreateObject(1250,1635.821899,-1707.266723,13.388300,0.000000,0.000000,-135.000000);//Parkhaus LS-Zentrum ticketannahme
	gateobj[16] = CreateObject(966,1638.385620,-1709.454101,12.490382,0.000000,0.000000,46.000000);//Parkhaus LS-Zentrum schranke fest
	gateobj[17] = CreateObject(968,1638.430541,-1709.398559,13.402589,0.000000,-91.000000,46.000000);//Parkhaus LS-Zentrum schranke //auf 0 Y-Rot
	gateobj[18] = CreateObject(4639,1643.805419,-1688.904418,22.087759,0.000000,0.000000,90.000000);//Parkhaus LS-Zentrum paystation1
	gateobj[19] = CreateObject(4639,1653.998291,-1689.900512,16.330642,0.000000,0.000000,0.000000);//Parkhaus LS-Zentrum paystation2
	gateobj[20] = CreateObject(975,1761.377685,-1691.945556,14.090826,0.000000,0.000000,90.000000);//Markt LS-Zentrum tor1 //auf x & y verschieben
	gateobj[21] = CreateObject(975,1761.351074,-1699.126953,14.140275,0.000000,0.000000,90.000000);//Markt LS-Zentrum tor2 //auf x & y verschieben
	gateobj[22] = CreateObject(975,1803.391723,-1720.732543,14.197936,0.000000,0.000000,-192.000000);//Markt LS-Zentrum tor3 //auf x & y verschieben
	gateobj[23] = CreateObject(11102,2178.498046,-2254.376953,15.695,0.000000,0.000000,-225.000000);//warehouse LS BODO GATE1 //auf 20 Z-Pos
	gateobj[24] = CreateObject(11102,2174.534667,-2258.250634,15.695,0.000000,0.000000,-225.000000);//warehouse LS BODO GATE2//auf 20 Z-Pos
	gateobj[25] = CreateObject(2066,2123.696044,-2277.109130,19.655078,0.000000,0.000000,136.000000);//warehouse LS BODO aktenschrank
	gateobj[26] = CreateObject(1726,2131.460693,-2284.893798,19.665969,0.000000,0.000000,134.000000);//warehouse LS BODO sofa
	gateobj[27] = CreateObject(1727,2133.646972,-2280.292724,19.696683,0.000000,0.000000,-45.000000);//warehouse LS BODO sessel
	gateobj[28] = CreateObject(1827,2132.449218,-2282.464355,19.621009,0.000000,0.000000,0.000000);//warehouse LS BODO tisch
	gateobj[29] = CreateObject(1497,2118.457763,-2274.227539,19.668355,0.000000,0.000000,-40.000000);//warehouse LS BODO door //auf +43 Z-Rot
	gateobj[30] = CreateObject(969,2234.557373,-2215.837402,12.713875,0.000000,0.000000,-45.000000);//warehouse LS BODO Gate4 //auf 2239.161865,-2220.441894,12.713875,0.000000,0.000000,-45.000000
	gateobj[31] = CreateObject(969,2234.376464,-2215.686279,12.714805,0.000000,0.000000,135.000000);//warehouse LS BODO Gate5 //auf 2229.421630,-2210.681396,12.714805,0.000000,0.000000,135.000000
	gateobj[32] = CreateObject(10671,2264.295166,-2254.730468,14.418926,0.000000,0.000000,44.000000);//warehouse LS BODO TrainGate6 //auf 18 Z-pos
	gateobj[33] = CreateObject(975,2424.6,-2086.236431,14.225,0.000000,0.000000,90.000000);//ölrafenerie LS BODO Gate1 //auf 2424.6,-2072.596191,14.225
	gateobj[34] = CreateObject(975,2424.6,-2095.055664,14.225,0.000000,0.000000,-90.000000);//ölrafenerie LS BODO Gate2 //auf 2424.6,-2103.851074,14.225
	gateobj[35] = CreateObject(967,2425.531250,-2080.960449,12.546871,0.000000,0.000000,-180.000000);//ölrafenerie LS BODO gate-häuschen
	gateobj[36] = CreateObject(1967,2424.771240,-2078.718750,13.451070,0.000000,0.000000,0.000000);//ölrafenerie LS BODO gate3
	gateobj[37] = CreateObject(4639,1790.490722,-1882.664672,14.227060,0.000000,0.000000,0.000000);//P UnityStation paystation1
	gateobj[38] = CreateObject(4697,1783.111572,-1923.890014,12.479097,0.000000,0.000000,0.000000);//P UnityStation Parkmarkierung1
	gateobj[39] = CreateObject(4697,1783.107055,-1887.074340,12.447018,0.000000,0.000000,0.000000);//P UnityStation Parkmarkierung2
	gateobj[40] = CreateObject(4697,1813.747314,-1923.735717,12.862206,0.000000,-3.000000,0.000000);//P UnityStation Parkmarkierung3
	gateobj[41] = CreateObject(4697,1798.517211,-1916.704589,12.737087,0.000000,-2.000000,0.000000);//P UnityStation Parkmarkierung4
	gateobj[42] = CreateObject(1250,1813.863037,-1889.169311,13.410976,0.000000,0.000000,90.000000);//P UnityStation ticketannahme
	gateobj[43] = CreateObject(8041,1637.633911,-1146.371093,28.561765,0.000000,0.000000,-90.000000);//P Sunrise P-Bude
	gateobj[44] = CreateObject(968,1645.837890,-1146.160766,24.03,0.000000,-91.000000,0.000000);//P Sunrise P-Bude //auf -3 Y-Rot
	gateobj[45] = CreateObject(968,1629.481079,-1145.714965,24.03,0.000000,90.000000,0.000000);//P Sunrise P-Bude //auf 3 Y-Rot
	gateobj[46] = CreateObject(1250,1638.304687,-1148.578979,23.906250,0.000000,0.000000,0.000000);//P Sunrise ticketannahme
	gateobj[47] = CreateObject(3475,1625.276367,-1146.364013,25.422742,0.000000,0.000000,-90.000000);
	gateobj[48] = CreateObject(3475,1619.309082,-1146.364013,25.422742,0.000000,0.000000,-90.000000);
	gateobj[49] = CreateObject(3475,1613.343082,-1146.364013,25.422742,0.000000,0.000000,-90.000000);
	gateobj[50] = CreateObject(3475,1607.919067,-1144.498657,25.422742,0.000000,0.000000,-125.000000);
	gateobj[51] = CreateObject(3475,1605.536865,-1139.613159,25.422742,0.000000,0.000000,181.000000);
	gateobj[52] = CreateObject(3475,1605.397583,-1133.670166,25.422742,0.000000,0.000000,-178.000000);
	gateobj[53] = CreateObject(3475,1604.883178,-1127.787231,25.422742,0.000000,0.000000,188.000000);
	gateobj[54] = CreateObject(3475,1604.142211,-1121.815551,25.422742,0.000000,0.000000,186.000000);
	gateobj[55] = CreateObject(3475,1603.399169,-1115.865356,25.422742,0.000000,0.000000,188.000000);
	gateobj[56] = CreateObject(3475,1602.406860,-1109.989257,25.422742,0.000000,0.000000,-169.000000);
	gateobj[57] = CreateObject(3475,1601.301513,-1104.237060,25.422742,0.000000,0.000000,-169.000000);
	gateobj[58] = CreateObject(3475,1600.052490,-1098.469238,25.422742,0.000000,0.000000,-167.000000);
	gateobj[59] = CreateObject(3475,1598.409667,-1092.778320,25.422742,0.000000,0.000000,-161.000000);
	gateobj[60] = CreateObject(3475,1596.506591,-1087.182739,25.422742,0.000000,0.000000,-161.000000);
	gateobj[61] = CreateObject(3475,1594.378417,-1081.671630,25.422742,0.000000,0.000000,-157.000000);
	gateobj[62] = CreateObject(3475,1591.778808,-1076.376342,25.422742,0.000000,0.000000,-151.000000);
	gateobj[63] = CreateObject(3475,1589.005371,-1071.146484,25.422742,0.000000,0.000000,-153.000000);
	gateobj[64] = CreateObject(3475,1586.212402,-1065.909545,25.422742,0.000000,0.000000,-151.000000);
	gateobj[65] = CreateObject(3475,1582.934936,-1060.989501,25.422742,0.000000,0.000000,-142.000000);
	gateobj[66] = CreateObject(3475,1579.309814,-1056.307006,25.422742,0.000000,0.000000,-142.000000);
	gateobj[67] = CreateObject(3475,1575.663818,-1051.663085,25.422742,0.000000,0.000000,-142.000000);
	gateobj[68] = CreateObject(3475,1571.633056,-1047.306762,25.422742,0.000000,0.000000,-133.000000);
	gateobj[69] = CreateObject(3475,1567.132690,-1043.380371,25.422742,0.000000,0.000000,-129.000000);
	gateobj[70] = CreateObject(3475,1562.327148,-1040.056152,25.422742,0.000000,0.000000,-121.000000);
	gateobj[71] = CreateObject(3475,1557.030029,-1037.500854,25.422742,0.000000,0.000000,-111.000000);
	gateobj[72] = CreateObject(3475,1550.750244,-1035.252441,25.422742,0.000000,0.000000,-108.000000);
	gateobj[73] = CreateObject(3475,1545.082397,-1033.402465,25.422742,0.000000,0.000000,-108.000000);
	gateobj[74] = CreateObject(3475,1539.366943,-1031.543212,25.422742,0.000000,0.000000,-108.000000);
	gateobj[75] = CreateObject(3475,1535.803100,-1027.465454,25.422742,0.000000,0.000000,-166.000000);
	gateobj[76] = CreateObject(3475,1536.499877,-1021.825500,25.422742,0.000000,0.000000,-204.000000);
	gateobj[77] = CreateObject(3475,1538.934082,-1016.370300,25.422742,0.000000,0.000000,-204.000000);
	gateobj[78] = CreateObject(3475,1541.504516,-1011.024536,25.422742,0.000000,0.000000,-207.000000);
	gateobj[79] = CreateObject(3475,1543.952270,-1005.603454,25.422742,0.000000,0.000000,-202.000000);
	gateobj[80] = CreateObject(3475,1649.762573,-1146.438842,25.422742,0.000000,0.000000,-89.000000);
	gateobj[81] = CreateObject(3475,1655.785522,-1146.380493,25.422742,0.000000,0.000000,-90.000000);
	gateobj[82] = CreateObject(3475,1661.751708,-1146.346191,25.422742,0.000000,0.000000,-90.000000);
	gateobj[83] = CreateObject(3475,1667.709228,-1146.402832,25.422742,0.000000,0.000000,-90.000000);
	gateobj[84] = CreateObject(3475,1673.654296,-1146.408203,25.422742,0.000000,0.000000,-90.000000);
	gateobj[85] = CreateObject(3475,1679.607666,-1146.442260,25.422742,0.000000,0.000000,-90.000000);
	gateobj[86] = CreateObject(3475,1684.345458,-1144.113281,25.422742,0.000000,0.000000,-32.000000);
	gateobj[87] = CreateObject(3475,1686.055053,-1138.564697,25.422742,0.000000,0.000000,0.000000);
	gateobj[88] = CreateObject(3475,1686.051269,-1132.607299,25.422742,0.000000,0.000000,0.000000);
	gateobj[89] = CreateObject(3475,1686.046142,-1126.644287,25.422742,0.000000,0.000000,0.000000);
	gateobj[90] = CreateObject(3475,1686.050292,-1120.654418,25.422742,0.000000,0.000000,0.000000);
	gateobj[91] = CreateObject(3475,1686.055297,-1114.711425,25.422742,0.000000,0.000000,0.000000);
	gateobj[92] = CreateObject(3475,1686.069956,-1108.795410,25.422742,0.000000,0.000000,0.000000);
	gateobj[93] = CreateObject(3475,1686.074838,-1103.077392,25.422742,0.000000,0.000000,0.000000);
	gateobj[94] = CreateObject(3475,1685.891723,-1097.205810,25.422742,0.000000,0.000000,4.000000);
	gateobj[95] = CreateObject(7371,1697.691284,-1094.027954,23.048835,0.000000,0.000000,90.000000);
	gateobj[96] = CreateObject(7371,1817.689086,-1082.117065,23.048835,0.000000,0.000000,-180.000000);
	gateobj[97] = CreateObject(4100,1651.974243,-1690.5,19.2,0.000000,0.000000,-40.000000);//Parkhaus LS-Zentrum absperrung oben //wenn spieler mit car in area dann auf 22
	gateobj[98] = CreateObject(4100,1668.901855,-1690.5,19.2,0.000000,0.000000,-40.000000);//Parkhaus LS-Zentrum absprrrung oben //wenn spieler mit car in area dann auf 22
	gateobj[99] = CreateObject(980,1961.835937,-2189.826416,15.290057,0.000000,0.000000,0.000000);//LS AIRPORT GATE1 //auf 1972.55 X-Pos
	CreateObject(14383,1870.747436,-2600.979492,50,0.000000,0.000000,0.000000);
	CreateObject(14474,1460.106811,-2610.416259,48.0,0.000000,0.000000,0.000000);
	CreateObject(14475,1460.016479,-2607.861328,50,0.000000,0.000000,0.000000);
	CreateObject(15054,1226.865600,-2622.616455,50,0.000000,0.000000,0.000000);
	CreateObject(15055,1062.013427,-2653.701904,50,0.000000,0.000000,0.000000);
	CreateObject(15059,614.643188,-2656.554931,50,0.000000,0.000000,0.000000);
	CreateObject(15048,614.643493,-2656.554443,50.0,0.000000,0.000000,0.000000);
	CreateObject(15046,482.652343,-2673.071044,50,0.000000,0.000000,0.000000);
	CreateObject(15058,260.769897,-2674.623779,50,0.000000,0.000000,0.000000);
	CreateObject(15041,32.877197,-2664.844970,50,0.000000,0.000000,0.000000);
	CreateObject(15031,1899.635620,-2368.010009,50,0.000000,0.000000,0.000000);
	CreateObject(15029,1627.789428,-2330.256835,50,0.000000,0.000000,0.000000);
	CreateObject(15030,1476.467773,-2376.112304,50,0.000000,0.000000,0.000000);
	CreateObject(15034,1290.814941,-2301.634521,50,0.000000,0.000000,0.000000);
	CreateObject(15033,1055.322387,-2396.912109,50,0.000000,0.000000,0.000000);
	CreateObject(15053,832.385986,-2382.354736,50,0.000000,0.000000,0.000000);
	CreateObject(14639,638.971923,-2386.169921,50,0.000000,0.000000,0.000000);//casinointerior1
	CreateObject(8378,625.963012,-2404.642578,48.001167,-90.000000,0.000000,0.000000); //casinointerior1 boden
	CreateObject(14572,436.582153,-2393.937988,50,0.000000,0.000000,0.000000);
	CreateObject(14655,231.593139,-2340.435302,50,0.000000,0.000000,0.000000);
	CreateObject(14593,35.449584,-2333.416503,50,0.000000,0.000000,0.000000);
	CreateObject(14712,-203.990478,-2346.118408,50,0.000000,0.000000,0.000000);
	CreateObject(14717,-479.925292,-2351.138916,50,0.000000,0.000000,0.000000);
	CreateObject(14417,1463.834106,1948.857666,49.582700,0.000000,0.000000,0.000000);
	CreateObject(14389,1463.872192,1948.857910,49.569536,0.000000,0.000000,0.000000);
	CreateObject(14484,1463.870361,1948.860351,49.580421,0.000000,0.000000,0.000000);
	CreateObject(14418,1463.898071,1948.859252,49.540372,0.000000,0.000000,0.000000);
	CreateObject(14488,1442.720703,1997.753051,48.710344,0.000000,0.000000,0.000000);
	CreateObject(14390,1463.866577,1948.857055,49.567247,0.000000,0.000000,0.000000);
	CreateObject(14419,1463.869995,1948.855346,49.561264,0.000000,0.000000,0.000000);
	CreateObject(14393,1460.377563,1957.399414,48.553358,0.000000,0.000000,0.000000);
	CreateObject(14420,1463.871826,1948.857421,49.567678,0.000000,0.000000,0.000000);
	CreateObject(14388,1463.861206,1948.870117,49.562824,0.000000,0.000000,0.000000);
	CreateObject(14422,1463.863891,1948.871704,49.565544,0.000000,0.000000,0.000000);
	CreateObject(14421,1463.864624,1948.827514,49.552555,0.000000,0.000000,0.000000);
	CreateObject(14423,1463.835083,1948.865966,49.554460,0.000000,0.000000,0.000000);
	CreateObject(14424,1463.853027,1948.840820,49.577142,0.000000,0.000000,0.000000);
	CreateObject(14425,1463.865600,1948.847045,49.573482,0.000000,0.000000,0.000000);
	CreateObject(14485,1463.861938,1948.839721,49.571800,0.000000,0.000000,0.000000);
	CreateObject(14430,1463.864990,1948.849731,49.570772,0.000000,0.000000,0.000000);
	CreateObject(14431,1463.898315,1948.850463,49.570415,0.000000,0.000000,0.000000);
	CreateObject(14427,1463.872558,1948.848388,49.569786,0.000000,0.000000,0.000000);
	CreateObject(14426,1463.862060,1948.851440,49.577331,0.000000,0.000000,0.000000);
	CreateObject(14429,1463.867675,1948.844482,49.566656,0.000000,0.000000,0.000000);
	CreateObject(14428,1463.859863,1948.851074,49.576286,0.000000,0.000000,0.000000);
	CreateObject(14803,1878.089111,1764.000732,51.862524,0.000000,0.000000,0.000000);
	CreateObject(14801,1658.975341,1763.050537,51.080318,0.000000,0.000000,0.000000);
	CreateObject(14795,1415.056030,1764.018066,55.180320,0.000000,0.000000,0.000000);
	CreateObject(14784,1202.088989,1771.471313,59.410509,0.000000,0.000000,0.000000);
	CreateObject(14814,1008.501953,1794.951416,51.540328,0.000000,0.000000,0.000000);
	CreateObject(14815,2047.302612,1591.220703,51.625505,0.000000,0.000000,0.000000);
	CreateObject(14789,1646.143310,1550.336914,54.100387,0.000000,0.000000,0.000000);
	CreateObject(14794,1450.919433,1587.898315,52.430349,0.000000,0.000000,0.000000);
	CreateObject(14798,1210.299194,1593.829223,51.220321,0.000000,0.000000,0.000000);
	CreateObject(14783,1071.274902,1593.514648,51.880336,0.000000,0.000000,0.000000);
	CreateObject(14776,1874.542480,1356.716186,56.650445,0.000000,0.000000,0.000000);
	CreateObject(18056,1636.897949,1333.695312,51.630331,0.000000,0.000000,0.000000);
	CreateObject(18082,1454.016479,1298.875610,52.090341,0.000000,0.000000,0.000000);
	CreateObject(18007,1287.927246,1312.500610,52.010339,0.000000,0.000000,0.000000);
	CreateObject(18088,1092.423461,1286.677490,51.830335,0.000000,0.000000,0.000000);
	CreateObject(18008,1871.299438,1072.085083,54.460395,0.000000,0.000000,0.000000);
	CreateObject(18024,1608.053955,1062.167846,53.020362,0.000000,0.000000,0.000000);
	CreateObject(18030,1407.622436,1096.517700,52.310346,0.000000,0.000000,0.000000);
	CreateObject(18026,1216.115112,1018.723388,50.130296,0.000000,0.000000,0.000000);
	CreateObject(18025,1009.080932,1038.958496,52.437844,0.000000,0.000000,0.000000);
	CreateObject(18031,1848.898559,838.171508,52.578673,0.000000,0.000000,0.000000);
	CreateObject(14889,1624.317993,894.355346,52.204735,0.000000,0.000000,0.000000);
	CreateObject(14876,1451.770874,886.693359,55.049103,0.000000,0.000000,0.000000);
	CreateObject(14865,1224.218872,844.804199,51.974514,0.000000,0.000000,0.000000);
	CreateObject(14859,1055.950805,845.144165,51.832390,0.000000,0.000000,0.000000);
	CreateObject(14479,1841.507446,613.287109,51.644516,0.000000,0.000000,0.000000);
	CreateObject(14707,1609.602172,611.629150,54.569072,0.000000,0.000000,0.000000);
	CreateObject(14706,1418.182373,655.758911,53.307920,0.000000,0.000000,0.000000);
	CreateObject(14708,1245.587890,617.650756,51.705018,0.000000,0.000000,0.000000);
	CreateObject(14735,1061.522827,679.058349,51.482515,0.000000,0.000000,0.000000);
	CreateObject(14709,1893.212158,482.620361,51.322511,0.000000,0.000000,0.000000);
	CreateObject(14702,1685.249633,436.413818,54.510396,0.000000,0.000000,0.000000);
	CreateObject(14718,1407.818725,485.370361,59.980293,0.000000,0.000000,0.000000);
	CreateObject(14713,1253.811401,476.398803,51.860336,0.000000,0.000000,0.000000);
	CreateObject(14760,1095.216064,417.662719,51.912525,0.000000,0.000000,0.000000);
	CreateObject(14759,1835.258666,210.681396,56.440441,0.000000,0.000000,0.000000);
	CreateObject(14756,1636.037841,247.903930,51.910337,0.000000,0.000000,0.000000);
	CreateObject(14755,1421.575073,279.148559,51.130319,0.000000,0.000000,0.000000);
	CreateObject(14748,1283.642700,217.054809,51.860336,0.000000,0.000000,0.000000);
	CreateObject(14750,1097.607421,282.741210,56.540443,0.000000,0.000000,0.000000);
	CreateObject(14754,1840.164428,87.339233,53.830381,0.000000,0.000000,0.000000);
	CreateObject(14758,1630.758300,38.497314,51.739002,0.000000,0.000000,0.000000);
	CreateObject(14714,1467.661132,5.254882,52.110342,0.000000,0.000000,0.000000);
	CreateObject(14700,1199.470092,38.831542,51.450326,0.000000,0.000000,0.000000);
	CreateObject(14711,943.752807,42.908447,51.503002,0.000000,0.000000,0.000000);
	CreateObject(14710,1888.588989,-242.475830,51.352512,0.000000,0.000000,0.000000);
	CreateObject(14701,1628.874755,-238.168701,52.060340,0.000000,0.000000,0.000000);
	CreateObject(14703,1452.649780,-299.001098,54.410394,0.000000,0.000000,0.000000);
	CreateObject(14736,1257.310058,-294.461547,50.970315,0.000000,0.000000,0.000000);
	CreateObject(14588,1066.156250,-257.656860,53.880382,0.000000,0.000000,0.000000);
	CreateObject(14603,1816.377807,-458.874145,101.650331,0.000000,0.000000,0.000000);//interior72
	CreateObject(14581,1685.921997,-420.036865,102.260345,0.000000,0.000000,0.000000);//interior73
	CreateObject(8378,1699.081298,-420.064178,99.239845,-90.000000,0.000000,0.000000);//interior73 boden
	CreateObject(14534,1484.202514,-447.023193,104.673067,0.000000,0.000000,0.000000);
	CreateObject(14530,1209.067138,-483.318237,101.670331,0.000000,0.000000,0.000000);
	CreateObject(14576,1076.694335,-435.022705,108.180480,0.000000,0.000000,0.000000);*/
	//$ region Objectselector-Menu
	Main =CreateMenu(" ",1,100,130,150,100);
	AddMenuItem(Main,0,"Beach_And_Sea");
	AddMenuItem(Main,0,"Buildings");
	AddMenuItem(Main,0,"Industrial");
	AddMenuItem(Main,0,"Interior Objects");
	AddMenuItem(Main,0,"Land_Masses");
	AddMenuItem(Main,0,"Miscellaneous");
	AddMenuItem(Main,0,"Nature");
	AddMenuItem(Main,0,"Structure");
	AddMenuItem(Main,0,"Transportation");
	one =CreateMenu("Beach_And_Sea",1,100,130,150,100);
	AddMenuItem(one,0,"General");
	AddMenuItem(one,0,"Ships docks and piers");
	two =CreateMenu("Buildings",1,100,130,150,100);
	AddMenuItem(two,0,"Bars clubs and casino");
	AddMenuItem(two,0,"Factories and warehouses");
	AddMenuItem(two,0,"Houses and apartments");
	AddMenuItem(two,0,"Offices and skyscrapers");
	AddMenuItem(two,0,"Other buildings");
	AddMenuItem(two,0,"Restaurant and Hotels");
	AddMenuItem(two,0,"Sports and stadium");
	AddMenuItem(two,0,"Stores and Shops");
	tree =CreateMenu("Industrial",1,100,130,150,100);
	AddMenuItem(tree,0,"Cranes");
	AddMenuItem(tree,0,"Crates drums and racks");
	AddMenuItem(tree,0,"General");
	four =CreateMenu("Interior_Objects",1,100,130,150,100);
	AddMenuItem(four,0,"Bar Items");
	AddMenuItem(four,0,"Casino Items");
	AddMenuItem(four,0,"Clothes");
	AddMenuItem(four,0,"Doors and Windows");
	AddMenuItem(four,0,"Furniture");
	AddMenuItem(four,0,"Household");
	AddMenuItem(four,0,"Shop Items");
	AddMenuItem(four,0,"Tables and Chairs");
	five =CreateMenu("Land Masses",1,100,130,150,100);
	AddMenuItem(five,0,"Concrete and Rock");
	AddMenuItem(five,0,"Grass and Dirt");
	six =CreateMenu("Miscellaneous",1,100,130,150,100);
	AddMenuItem(six,0,"Food and Drinks");
	AddMenuItem(six,0,"Ladders,Stairs, and Scaffolding");
	AddMenuItem(six,0,"Military");
	AddMenuItem(six,0,"Pickups and Icons");
	AddMenuItem(six,0,"Special");
	AddMenuItem(six,0,"Street and Road Items");
	AddMenuItem(six,0,"Trash");
	seven =CreateMenu("Nature",1,100,130,150,100);
	AddMenuItem(seven,0,"Plants");
	AddMenuItem(seven,0,"Rocks");
	AddMenuItem(seven,0,"Trees");
	eight =CreateMenu("Structure",1,100,130,150,100);
	AddMenuItem(eight,0,"Airport and Aircraft Objects");
	AddMenuItem(eight,0,"Car Parks");
	AddMenuItem(eight,0,"Farm Objects");
	AddMenuItem(eight,0,"Fences, Walls, Gates, and Barriers");
		//	AddMenuItem(eight,0,"Big Fences");
	AddMenuItem(eight,0,"Garages and Petrol Stations");
	AddMenuItem(eight,0,"Ramps");
	nine =CreateMenu("Transportation",1,100,130,150,100);
	AddMenuItem(nine,0,"Railroads");
	AddMenuItem(nine,0,"Roads, Bridges, and Tunnels");
	//$ endregion Objectselector-Menu
	return 1;
}
public OnGameModeExit(){
	new Float:x, Float:y, Float:z, Float:a;
	new carname[256];
	new modname[256];
	for(new i=0;i<CAR_AMOUNT_USED;i++){
 		if(IsValidObject(AutomaticCars[i])){
			DestroyObject(AutomaticCars[i]);
		}
	}
	for (new h = 0; h < MAX_VEHICLES; h++){
		GetVehiclePos(VehStreamid[h],x,y,z);
		GetVehicleZAngle(VehStreamid[h],a);
		VehicleInfo[VehStreamid[h]][veh_pos][0]=x;
		VehicleInfo[VehStreamid[h]][veh_pos][1]=y;
		VehicleInfo[VehStreamid[h]][veh_pos][2]=z;
		VehicleInfo[VehStreamid[h]][veh_pos][3]=a;
	}
	for (new j = 0; j < MAX_STREAM_VEHICLES; j++){
		if (VehicleInfo[j][CREATED]){
			format(carname,sizeof(carname),"Car%d",j);
			if (!dini_Exists(carname)){
				dini_Create(carname);}
			dini_FloatSet(carname,"x",VehicleInfo[j][veh_pos][0]);
			dini_FloatSet(carname,"y",VehicleInfo[j][veh_pos][1]);
			dini_FloatSet(carname,"z",VehicleInfo[j][veh_pos][2]);
			dini_FloatSet(carname,"a",VehicleInfo[j][veh_pos][3]);
			for (new mo = 0; mo < MAX_COMPONENTS; mo++){
				format(modname,sizeof(modname),"mod%d",mo);
				dini_IntSet(carname,modname,VehicleInfo[j][COMPONENTS][mo]);
			}
			dini_IntSet(carname,"paintjob",VehicleInfo[j][paintjob]);
			dini_IntSet(carname,"security",VehicleInfo[j][security]);
			dini_IntSet(carname,"priority",VehicleInfo[j][priority]);
			dini_IntSet(carname,"model",VehicleInfo[j][model]);
			dini_IntSet(carname,"CREATED",VehicleInfo[j][CREATED]);
			dini_Set(carname,"ownername",VehicleInfo[j][owner]);
			dini_IntSet(carname,"ownerid",VehicleInfo[j][ownerid]);
			dini_IntSet(carname,"tank",VehicleInfo[j][tank]);
			dini_IntSet(carname,"meters",VehicleInfo[j][meters]);
			dini_IntSet(carname,"oilpress",VehicleInfo[j][oilpress]);
			dini_IntSet(carname,"oilminimum",VehicleInfo[j][oilminimum]);
			dini_IntSet(carname,"oildamage",VehicleInfo[j][oildamage]);
			dini_IntSet(carname,"locked",VehicleInfo[j][locked]);
			dini_Set(carname,"numberplate",VehicleInfo[j][numberplate]);
			dini_FloatSet(carname,"health",VehicleInfo[j][health]);
			dini_IntSet(carname,"key",VehicleInfo[j][key]);
			dini_IntSet(carname,"world",VehicleInfo[j][world]);
			dini_IntSet(carname,"interior",VehicleInfo[j][interior]);
			dini_IntSet(carname,"color1",VehicleInfo[j][colors][0]);
			dini_IntSet(carname,"color2",VehicleInfo[j][colors][1]);
			dini_IntSet(carname,"streamid",VehicleInfo[j][streamid]);
		}
	}
	KillTimer(BrakeTimer);
	KillTimer(ObjectBrakeTimer);
	TextDrawDestroy(TimeYear);
	TextDrawDestroy(TimeHour);
	TextDrawDestroy(TimeSec);
	cleanZombies();
	return 1;
}
public OnPlayerRequestClass(playerid, classid){
//    NormalSkin[playerid] = skinpl[classid];
	if (!udb_Exists(PlayerName(playerid))){
	SetPlayerPos(playerid, 1174.8, -1182.6, 91.41113);
	SetWorldTime(1);
	SetPlayerFacingAngle(playerid, 90);
	SetPlayerCameraPos(playerid, 1173.0, -1182.8, 90.8);
	SetPlayerCameraLookAt(playerid, 1175.0, -1183.0, 92.0);
	}
	return 1;
}
public OnPlayerDisconnect(playerid) {
	new oldvehicle;
	for(new i=0;i<CAR_AMOUNT_USED;i++)	{
	    if(HasFreezed[playerid][i])		{
			Freezed[i]--;
			if(Freezed[i] < 0) Freezed[i] = 0;
			if(Freezed[i] == 0)
			{
				if(KMH[LastCarPosition[i]] != 0.00000){
					MoveObject(AutomaticCars[i],DrivePoints[CarPosition[i]][0],
					DrivePoints[CarPosition[i]][1],
					DrivePoints[CarPosition[i]][2],
				KMH[LastCarPosition[i]]);}
	   			else{
	    			MoveObject(AutomaticCars[i],DrivePoints[CarPosition[i]][0],DrivePoints[CarPosition[i]][1],DrivePoints[CarPosition[i]][2],15.0);
				}
			}
		}
		HasFreezed[playerid][i] = false;
	}
	if (PLAYERLIST_authed[playerid]) {
    	dUserSetINT(PlayerName(playerid)).("money",GetPlayerMoney(playerid));
    	new Float:x,Float:y,Float:z,Float:a;
    	GetPlayerPos(playerid,x,y,z);
    	GetPlayerFacingAngle(playerid,a);
		dUserSetINT(PlayerName(playerid)).("x",floatround(x));
    	dUserSetINT(PlayerName(playerid)).("y",floatround(y));
    	dUserSetINT(PlayerName(playerid)).("z",floatround(z));
    	dUserSetINT(PlayerName(playerid)).("a",floatround(a));
    	dUserSetINT(PlayerName(playerid)).("thirsty",floatround(THIRSTY[playerid]));
    	dUserSetINT(PlayerName(playerid)).("hungry",floatround(HUNGRY[playerid]));
    	dUserSetINT(PlayerName(playerid)).("sexy",floatround(SEXY[playerid]));
		dUserSetINT(PlayerName(playerid)).("skin",Skin[playerid]);
		dUserSetINT(PlayerName(playerid)).("seclevup",seclevup[playerid]);
	 	dUserSetINT(PlayerName(playerid)).("minlevup",minlevup[playerid]);
 		dUserSetINT(PlayerName(playerid)).("neededhour",NeededHour[playerid]);
 		dUserSetINT(PlayerName(playerid)).("neededlevcash",NeededlevCash[playerid]);
 		dUserSetINT(PlayerName(playerid)).("playerlevel",Playerlevel[playerid]);
 		dUserSetINT(PlayerName(playerid)).("hourlevel",Hourlevel[playerid]);
 		dUserSetINT(PlayerName(playerid)).("giveRpoints",giveRespectpoints[playerid]);
    	if (IsPlayerInAnyVehicle(playerid)){
		oldvehicle = GetPlayerVehicleID(playerid);
		dUserSetINT(PlayerName(playerid)).("oldvehicle",oldvehicle);}}
	if(InCargoBob[playerid] != 0){
		InCargoBob[playerid] = 0;
		ObjectsAdded[playerid] = false;}
	return false;
	}
public OnPlayerSpawn(playerid){
	TextDrawShowForPlayer(playerid,TimeHour);
	TextDrawShowForPlayer(playerid,TimeSec);
	TextDrawShowForPlayer(playerid,TimeYear);
	UpdatecartypeMenu(playerid);
	if (bufu[playerid]==1){
		NormalSkin[playerid] = GetPlayerSkin(playerid);
 		dUserSetINT(PlayerName(playerid)).("normalskin",NormalSkin[playerid]);
        dUserSetINT(PlayerName(playerid)).("bizbet", 0);
		Skin[playerid]=NormalSkin[playerid];
		bufu[playerid]=0;
		return 1;}
	else{
		SetPlayerSkin(playerid,Skin[playerid]);}
	if (!PLAYERLIST_authed[playerid]){
		TogglePlayerControllable(playerid,false);
		SendClientMessage(playerid,COLOR_RED,"U forgot to /login. U have 10sec to login.");
		Playertimer4[playerid] = SetTimerEx("fick",10000,0, "i",playerid);
	}
	if( carSelect[playerid] > 0  ){
	    carSelect[playerid] = 0;
		return 0;
	}
	return 1;
}
public OnPlayerConnect(playerid){
	players[playerid][object_id] = INVALID_OBJECT_ID;
	seclevup[playerid] = (dUserINT(PlayerName(playerid)).("seclevup"));
	minlevup[playerid] = (dUserINT(PlayerName(playerid)).("minlevup"));
	NeededHour[playerid] = (dUserINT(PlayerName(playerid)).("neededhour"));
	NeededlevCash[playerid] = (dUserINT(PlayerName(playerid)).("neededlevcash"));
	Playerlevel[playerid] = (dUserINT(PlayerName(playerid)).("playerlevel"));
	Hourlevel[playerid] = (dUserINT(PlayerName(playerid)).("hourlevel"));
	giveRespectpoints[playerid] = (dUserINT(PlayerName(playerid)).("giveRpoints"));
	totalItems[playerid][0] = 29;
	GameTextForPlayer(playerid,"Carlito's Way",8000,1);
	SetPlayerCameraPos(playerid, 1948.0, -1606.0, 150.0);
	SetPlayerCameraLookAt(playerid, 1560.0, -1380.0, 220.0);
	PLAYERLIST_authed[playerid]=false;
	Skin[playerid] = dUserINT(PlayerName(playerid)).("skin");
	playerCar[playerid]=0;
	if (apocalipsis)	{
	    money[playerid]=GetPlayerMoney(playerid);
	    ResetPlayerMoney(playerid);
	    QuitarArmasZombie(playerid);
	}
	if (udb_Exists(PlayerName(playerid))){
		SendClientMessage(playerid, COLOR_GREEN, "Account found. Login now.");}
		else {
		SendClientMessage(playerid, COLOR_GREEN, "Please /register first !!!");}
	AddCargoObjects(playerid);
	ObjectsAdded[playerid] = true;
	return true;
}
public OnPlayerDeath(playerid, killerid, reason){
	// defines
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	new weap[200];
	new ammo;
	new temp;
	new s[256];
	new PX;
	new PY;
	new PickUpMoneyBit = false; // added by uncajesse
	// loop through weapon slots
 	for(new i=0;i<15;i++){
		// placing pickups
		if(i<12){
			GetPlayerWeaponData(playerid, i, weap[i], ammo);
			if(weapmod[weap[i]] == 1212){
				PickUpMoneyBit=true;}
				else {
			 	// calculating random pos near to player
			    format(s, 256 ,"%.0f", X);
				temp = strval(s);
				PX = random((temp+2)-(temp-2))+(temp-2);
				format(s, 256 ,"%.0f", Y);
				temp = strval(s);
				PY = random((temp+2)-(temp-2))+(temp-2);
				// create pickup
			    new pickid = CreatePickup(weapmod[weap[i]], 3,PX, PY, Z);
			    PickUpWeaponSlot[pickid]=i;
			    PickUpWeaponAmmo[pickid]=ammo;
				DropPick[pickid]=true;
				PickUpArmour[pickid]=0.0;
				PickUpMoney[pickid]=false; // added by uncajesse
			}
	 	}
 		if(i==14){
 		    new Float:playerarmour = GetPlayerArmourEx(playerid);
			if(playerarmour>0.0){
			 	// calculating random pos near to player
			    format(s, 256 ,"%.0f", X);
				temp = strval(s);
				PX = random((temp+2)-(temp-2))+(temp-2);
				format(s, 256 ,"%.0f", Y);
				temp = strval(s);
				PY = random((temp+2)-(temp-2))+(temp-2);
				// create pickup
			    new pickid = CreatePickup(373, 3,PX, PY, Z);
			    PickUpWeaponSlot[pickid]=14;
			    PickUpWeaponAmmo[pickid]=0;
			    PickUpArmour[pickid]=playerarmour; // added by uncajesse
				DropPick[pickid]=true;
				PickUpMoney[pickid]=false;}
			else {
				PickUpMoneyBit=true; // added by uncajesse
			}
	 	}
		if(i==15){
			PickUpMoneyBit=true; // added by uncajesse
		}
 	}
	// create money pickup
	if(PickUpMoneyBit)
	{ // added by uncajesse
		new pi;
		cash1[playerid] = GetPlayerMoney(playerid);
	 	// calculating random pos near to player
	    format(s, 256 ,"%.0f", X);
		temp = strval(s);
		PX = random((temp+2)-(temp-2))+(temp-2);
		format(s, 256 ,"%.0f", Y);
		temp = strval(s);
		PY = random((temp+2)-(temp-2))+(temp-2);
		// placing money pickup
		if(cash1[playerid]==0){return 1;}
		else if(cash1[playerid]<5000){pi=1212;}
		else if(cash1[playerid]<50000){pi=1210;}
		else {pi=1550;}
		new pickid = CreatePickup(pi, 3,PX, PY, Z);
		PickUpMoney[pickid]=true;
		PickUpMoneyAmmount[pickid]=cash1[playerid];
		PickUpWeaponAmmo[pickid]=0;
		PickUpArmour[pickid]=0.0;
		DropPick[pickid]=true;
	}
	// end placing pickups
	ResetPlayerMoney(playerid);
	if (apocalipsis && killerid==INVALID_PLAYER_ID)	{
	    new tmp[255];
	    format(tmp,255,"~w~SCORE~n~~r~Zombies~w~: %d ~y~+1 ~n~~b~Humans~w~: %d",scorez,scorep);
	    scorez++;
	    GameTextForAll(tmp,2000,4);
	    attacknearest();
	}
	if(InCargoBob[playerid] != 0){
	InCargoBob[playerid] = 0;
	SetPlayerVirtualWorld(playerid,0);}
	return 1;
}
public OnPlayerPickUpPickup(playerid, pickupid){

/*	new streamid;
	streamid = GetPickupStreamID(pickupid);
	for (new i = 0; i < MAX_DRIVEPOINTS2 ; i++)	{
	if(drivepickup[i]==streamid){
	new string[256];
	format(string,sizeof(string),"ID: %d  X: %f  Y: %f  Z: %f  A: %f  DP: %d  pID: %d",streamid, DrivePoints2[i][0],DrivePoints2[i][1],DrivePoints2[i][2],DrivePoints2[i][3],i,pickupid);
	SendClientMessage(playerid, COLOR_YELLOW, string);
	}
	else{SendClientMessage(playerid, COLOR_YELLOW, "Sorry!");}}*/
	if(PickUpMoney[pickupid]){
		GivePlayerMoney(playerid,PickUpMoneyAmmount[pickupid]); // added by uncajesse
	}
	if(PickUpArmour[pickupid]>0){ // added by uncajesse
		new Float:currentarmour = GetPlayerArmourEx(playerid);
		if(currentarmour<255.0)
		{
			new Float:newarmour = currentarmour + PickUpArmour[pickupid];
			if(newarmour>255.0)
			{
				newarmour = float(255);
			}
			SetTimerEx("PlayerPickUpPickupSetArmour", 500, 0, "df", playerid, newarmour);}
		else {
		    return 0;
		}
	}
	if(PickUpWeaponAmmo[pickupid]>0){
	    new currentslotweapon, currentslotammo;
	    GetPlayerWeaponData(playerid,PickUpWeaponSlot[pickupid],currentslotweapon,currentslotammo);
	    new newslotammo = currentslotammo + PickUpWeaponAmmo[pickupid]; // added by uncajesse
        SetTimerEx("PlayerPickUpPickupSetAmmo", 500, 0, "d", playerid, PickUpWeaponSlot[pickupid], newslotammo);  // added by uncajesse
	}
	if(DropPick[pickupid]){
	    DropPick[pickupid]=false; // added by uncajesse
	    PickUpMoney[pickupid]=false; // added by uncajesse
	    PickUpArmour[pickupid]=0;
		SetTimerEx("PickDestroy", 1000, 0, "d", pickupid); // Destroying pickups
	}
	return 1;
}
public OnVehicleSpawn(vehicleid){
	printf("OnVehicleSpawn(%d)", vehicleid);
	return 1;
}
public OnVehicleDeath( vehicleid,  killerid ){
SetTimerEx("DestroyVehicleEx2", 7000, false, "i", vehicleid);
if(GetVehicleModel(vehicleid) == 548)	{
	for(new i = 0;i < MAX_PLAYERS;i++)	{
		if(InCargoBob[i] == vehicleid)		{
			new Float:X,Float:Y,Float:Z;
			GetPlayerPos(i,X,Y,Z);
			CreateExplosion(X,Y,Z,3,10);
			SetPlayerHealth(i,0.0);
			InCargoBob[i] = 0;}}}
return 1;}
public OnVehicleMod(playerid, vehicleid, componentid){
	for(new i=0;i<MAX_COMPONENTS;i++)
	{
	    if(!VehicleInfo[GetVehicleStreamID(vehicleid)][COMPONENTS][i])
	    {
	        VehicleInfo[GetVehicleStreamID(vehicleid)][COMPONENTS][i]=componentid;
	        break;
		}
	}

	return CallLocalFunction("OnStreamVehicleMod","iii",playerid,GetVehicleStreamID(vehicleid),componentid);
}
public OnVehiclePaintjob(playerid, vehicleid, paintjobid){
    VehicleInfo[GetVehicleStreamID(vehicleid)][paintjob]=paintjobid;
    return CallLocalFunction("OnStreamVehiclePaintjob","iii",playerid,GetVehicleStreamID(vehicleid),paintjobid);
}
public OnVehicleRespray(playerid, vehicleid, color1, color2){
	/*
	VehicleInfo[GetVehicleStreamID(vehicleid)[COLORS][0]=color1;
	VehicleInfo[GetVehicleStreamID(vehicleid)[COLORS][1]=color2
	*/
    return CallLocalFunction("OnStreamVehicleRespray","iiii",playerid,GetVehicleStreamID(vehicleid),color1,color2);
}
public OnPlayerText(playerid){
	return 1;}
public OnPlayerCommandText(playerid, cmdtext[]){
	new cmd[256];
	new tmp[256];
	new Playername[MAX_PLAYER_NAME];
	new idx;
	new s[256];
	new t[256];
	new u[256];
	new v;
	new w;
	new Float:x,Float:y,Float:z;
	cmd = strtok(cmdtext, idx);
	//$ region Cargobob
	if (strcmp(cmd, "/cargo", true)==0) {
		for(new i = 0;i < MAX_VEHICLES;i++)	{
			if(GetVehicleModel(i) == 548){
				new Float:vX,Float:vY,Float:vZ;
				GetVehiclePos(i,vX,vY,vZ);
				GetXYOfVehicle(i,vX,vY,-5.5);
				vZ -= 1.932519;
				if (GetPlayerPosPower(playerid,vX,vY,vZ,0,0,0,2.5)){
					if (ObjectsAdded[playerid] == false)
					{
						AddCargoObjects(playerid);
						ObjectsAdded[playerid] = true;
					}
					InCargoBob[playerid] = i;
					SendClientMessage(playerid,COLOR_NEUTRALGREEN,ENTERED_CARGO);
					GetPlayerTime(playerid,CargoHours[playerid],CargoMinutes[playerid]);
					SetPlayerTime(playerid,0,0);
					SetPlayerPos(playerid,222.251160, 82.851181, 10639.714844);
					SetPlayerVirtualWorld(playerid,i);
					return true;
				}
			}
		}
		SendClientMessage(playerid,COLOR_NEUTRALGREEN,TO_FAROF_CARGO);
		return true;
	}
	if (strcmp(cmd, "/cargoout", true)==0) {
		if(InCargoBob[playerid] == 0)
		return SendClientMessage(playerid,COLOR_NEUTRALGREEN,NOT_IN_CARGO);
		new Float:vX,Float:vY,Float:vZ;
		GetVehiclePos(InCargoBob[playerid],vX,vY,vZ);
		vZ -= 1.932519;
		new Float:a = GetXYOfVehicle(InCargoBob[playerid],vX,vY,-5.5);
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,vX,vY,vZ);
		SetPlayerFacingAngle(playerid,a-180);
		SetPlayerVirtualWorld(playerid,0);
		SetPlayerTime(playerid,CargoHours[playerid],CargoMinutes[playerid]);
		InCargoBob[playerid] = 0;
		return true;
	}
	//$ endregion Cargobob
	//$ region Carbot
		if (strcmp(cmd, "/drivepoints", true)==0) {
			if(drivepbool==false){
				drivepbool=true;
				return 1;
			}
			else{
				drivepbool=false;
				return 1;
			}
		}
		if (strcmp(cmd, "/startcarbots", true)==0)	{

			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_WHITE, "Benutze: /startcarbots [Amount]");
				return 1;
			}
			new amount = strval(tmp);

			for(new i=0;i<MAX_CARBOTS;i++)
			{
				if(IsValidObject(AutomaticCars[i])) DestroyObject(AutomaticCars[i]);
			}

			CorrectAmount(playerid,amount);

			CAR_AMOUNT_USED = amount;
			for(new i=1;i<amount;i++)
			{
				new rand = random(MAX_DRIVEPOINTS);
				new oid = CreateObject(3593+random(2),DrivePoints[rand][0],DrivePoints[rand][1],DrivePoints[rand][2]+20,0.0,0.0,0.0); //3593 //12957
				AutomaticCars[i] = oid;
				CarPosition[i] = rand;
				MoveObject(AutomaticCars[i],DrivePoints[rand][0],DrivePoints[rand][1],DrivePoints[rand][2],5.0);
			}


			return 1;
		}
		if (strcmp(cmd, "/stopcarbots", true)==0)	{
			for(new i=0;i<CAR_AMOUNT_USED;i++)
			{
				if(IsValidObject(AutomaticCars[i])) DestroyObject(AutomaticCars[i]);
			}
			return 1;
		}
		if (strcmp(cmd, "/botcommands", true)==0)	{
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"~~~~~~~~~~~~~~~B~o~t~~~C~o~m~m~a~n~d~s~~~~~~~~~~~~~~~");
			SendClientMessage(playerid,COLOR_GREEN,"/startcarbots [Amount (1- ~150)] ---> An amount of car bots start");
			SendClientMessage(playerid,COLOR_GREEN,"/autostop ---> Removes all Car Bots from the map");
			SendClientMessage(playerid,COLOR_GREEN,"/calculations ---> Debug (Shows the ID of the bot that has been moved at last)");
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"~~~~~~~~~~~~~~~B~o~t~~~C~o~m~m~a~n~d~s~~~~~~~~~~~~~~~");
			return 1;
		}
		if (strcmp(cmd, "/calculations", true)==0)	{
			if(!calculations) calculations = true; else calculations = false;
			return 1;
		}
	//$ endregion Carbot
	//$ region Zombie mod
		if 	(strcmp(cmd, "/zspeed", true)==0)	{
			tmp = strtok(cmdtext, idx);
			if	(!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "USE: /zspeed [speed]");
				return 1;
			}
			Zspeed=floatstr(tmp);
			return 1;
		}
		if 	(strcmp(cmd, "/ZTimerSpeed", true)==0)	{
			tmp = strtok(cmdtext, idx);
			if	(!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "USE: /ZTimerSpeed [timer speed]");
				return 1;
			}
			ZTimerSpeed=strval(tmp);
			OnPlayerCommandText(playerid, "/zstop");
			OnPlayerCommandText(playerid, "/zstart");
			return 1;
		}
		if (strcmp(cmd, "/zo", true)==0)	{
			new Float:pX,Float:pY,Float:pZ,Float:Ang;
			GetPlayerPos(playerid,pX,pY,pZ);
			GetPlayerFacingAngle(playerid,Ang);
			pX=pX+3.0*floatsin(-Ang,degrees);
			pY=pY+3.0*floatcos(-Ang,degrees);
			pZ=pZ+0.7;
			CrearZombie(pX,pY,pZ,Ang+180.0);
			return 1;
		}
		if 	(strcmp(cmd, "/zstart", true)==0)	{
			if (NOFZombies>0)
			{
				new idztarget;
				tmp = strtok(cmdtext, idx);
				if	(!strlen(tmp))
				{
					idztarget = playerid;
				}
				else
				{
					if (!IsPlayerConnected(strval(tmp)))
					{
						SendClientMessage(playerid, 0xFFFFFFAA, "That player is not conected!");
						return 1;
					}
					idztarget = strval(tmp);
				}
				if (TimerAtaca!=-1){KillTimer(TimerAtaca);}
				for (new j=0;j<TOTALZombies;j++){zombie[j][target]=idztarget;}
				TimerAtaca=SetTimer("zombieAtaca",ZTimerSpeed,1);
				return 1;
			}
			SendClientMessage(playerid, 0xFFFFFFAA, "There are no zombies");
			return 1;
		}
		if 	(strcmp(cmd, "/zstop", true)==0)	{
			if (NOFZombies>0)
			{
				if (TimerAtaca!=-1)
				{
					KillTimer(TimerAtaca);
				}
				for (new j=0;j<TOTALZombies;j++)
				{
					if (zombie[j][undead])
					{
						StopObject(zombie[j][head]);
						StopObject(zombie[j][torso]);
						StopObject(zombie[j][rArm]);
						StopObject(zombie[j][lArm]);
						StopObject(zombie[j][rLeg]);
						StopObject(zombie[j][lLeg]);
					}
				}
				return 1;
			}
			SendClientMessage(playerid, 0xFFFFFFAA, "There are no zombies");
			return 1;
		}
		if 	(strcmp(cmd, "/zclean", true)==0)	{
			cleanZombies();
			SendClientMessage(playerid, 0xFFFFFFAA, "There are no zombies anymore!");
			return 1;
		}
		if 	(strcmp(cmd, "/ttt", true)==0)	{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "USO: /ttt [hora]");
				return 1;
			}
			new hora = strval(tmp);
			SetWorldTime(hora);
			format(tmp, sizeof(tmp), "Ahora la hora es: %d", hora);
			SendClientMessage(playerid, 0xFFFFFFAA, tmp);
			return 1;
		}
		if 	(strcmp(cmd, "/www", true)==0)	{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "USO: /www [weather]");
				return 1;
			}
			new www = strval(tmp);
			SetWeather(www);
			format(tmp, sizeof(tmp), "Ahora el clima es: %d", www);
			SendClientMessage(playerid, 0xFFFFFFAA, tmp);
			return 1;
		}
		if 	(strcmp(cmd, "/zcantZombies", true)==0)	{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "USO: /zcantZombies [cuantity]");
				return 1;
			}
			cleanZombies();
			TOTALZombies = strval(tmp);
			return 1;
		}
		if 	(strcmp(cmd, "/ambient", true)==0)	{
			SetWorldTime(0);
			SetWeather(8);
			return 1;
		}
		if 	(strcmp(cmd, "/apocalipsison", true)==0)	{
			apocalipsis = true;
			for (new i=0;i<MAX_PLAYERS;i++)
			{
				if(IsPlayerConnected(i))
				{
					QuitarArmasZombie(i);
					money[playerid]=GetPlayerMoney(playerid);
					ResetPlayerMoney(playerid);
				}
			}
			scorez=0;
			scorep=0;
			SetWorldTime(0);
			SetWeather(8);
			GameTextForAll("~r~apocalipsis ~w~mode:~b~on~w~! ~n~~n~~n~~g~ZOMBIES~w~!!!",5000,5);
			if (TimerAPO!=-1){KillTimer(TimerAPO);}
			TimerAPO = SetTimer("attacknearest",10000,1);
			if (TimerAtaca!=-1){KillTimer(TimerAtaca);}
			TimerAtaca=SetTimer("zombieAtaca",ZTimerSpeed,1);
			while (NOFZombies<TOTALZombies)CreateRandomZombie();
			attacknearest();
			return 1;
		}
		if 	(strcmp(cmd, "/apocalipsisoff", true)==0)	{
			if (apocalipsis)
			{
				for (new i=0;i<MAX_PLAYERS;i++)if(IsPlayerConnected(i)){DevolverArmasZombie(i);GivePlayerMoney(i,money[i]);}
				format(tmp,255,"~w~SCORE ~r~Zombies~w~: %d ~b~Humans~w~: %d~n~~n~~r~apocalipsis ~w~mode:~b~off~w~",scorez,scorep);
				GameTextForAll(tmp,6000,4);
				apocalipsis = false;
				SetWorldTime(12);
				SetWeather(7);
				cleanZombies();
			}
			if (TimerAPO!=-1){KillTimer(TimerAPO);}
			if (TimerAtaca!=-1){KillTimer(TimerAtaca);}
			return 1;
		}
		if  (strcmp(cmd, "/vaiven", true)==0)    {
			tmp = strtok(cmdtext, idx);
			if      (!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "USO: /vaiven [angulo]");
				return 1;
			}
			vaiven=floatstr(tmp);
			return 1;
		}
		if  (strcmp(cmd, "/zGetWeapon", true)==0)    {
			tmp = strtok(cmdtext, idx);
			if      (!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "USO: /zGetWeapon [weapon]");
				return 1;
			}
			GivePlayerWeapon(playerid,strval(tmp),10000);
			return 1;
		}
		if  (strcmp(cmd, "/zGiveWeaponForAll", true)==0)    {
			tmp = strtok(cmdtext, idx);
			if      (!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "USO: /zGiveWeaponForAll [weapon]");
				return 1;
			}
			new weapzo = strval(tmp);
			for (new i=0;i<MAX_PLAYERS;i++)if(IsPlayerConnected(i))
			GivePlayerWeapon(i,weapzo,10000);
			return 1;
		}

	//$ endregion Zombie mod
	if(strcmp(cmd, "/giveweapon", true) == 0){
		new tesxx[256], nam[256], tmp2[256], tmp3[256];
		tmp = strtok(cmdtext,idx);
		tmp2 = strtok(cmdtext,idx);
		tmp3 = strtok(cmdtext,idx);
		if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /giveweapon [playerid] [weapon id/weapon name] [ammo]");
		new player1 = strval(tmp), weap, ammo, WeapName[32];
		if(!strlen(tmp3) || !IsNumeric(tmp3) || strval(tmp3) <= 0 || strval(tmp3) > 99999) {
			ammo = 500;
		}
		else {
			ammo = strval(tmp3);
		}
		if(!IsNumeric(tmp2)) weap = GetWeaponIDFromName(tmp2);
		else weap = strval(tmp2);
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(!IsValidWeapon(weap)) return SendClientMessage(playerid,COLOR_WHITE,"ERROR: Invalid weapon ID");
			GetWeaponName(weap,WeapName,32);
			GetPlayerName(playerid, nam, sizeof(nam));
			format(tesxx, sizeof(tesxx), "You have given \"%s\" a %s (%d) with %d rounds of ammo", nam, WeapName, weap, ammo); SendClientMessage(playerid,COLOR_WHITE,tesxx);
			if(player1 != playerid) { format(tesxx,sizeof(tesxx),"Administrator \"%s\" has given you a %s (%d) with %d rounds of ammo", nam, WeapName, weap, ammo); SendClientMessage(player1,COLOR_WHITE,tesxx); }
			return GivePlayerWeapon(player1, weap, ammo);}
			else {return SendClientMessage(playerid,COLOR_WHITE,"ERROR: Player is not connected");}
	}
	if(strcmp(cmd, "/pathedit", true) == 0){
		tmp = strtok(cmdtext,idx);
		new string[256];
	if(strlen(tmp)){
		format(string, sizeof(string),"Streetname: %s", tmp);
		SendClientMessage(playerid,COLOR_WHITE,string);
		format(string, sizeof(string),"//$ endregion");
		writepath(playerid,string);
		format(string, sizeof(string),"//$ region %s", tmp);
		writepath(playerid,string);
		return 1;
	}
	if (patheditor[playerid]){
		SendClientMessage(playerid,COLOR_GREEN,"Patheditor: OFF");
		patheditor[playerid]=false;}
	else {
		SendClientMessage(playerid,COLOR_GREEN,"Patheditor: ON");
		patheditor[playerid]=true;}
	return 1;
	}
	if(strcmp(cmd, "/jet", true) == 0){
	GetPlayerPos(playerid,x,y,z);
	CreatePickup(370,3,x,y,z);
	return 1;
	}
	if(strcmp(cmd, "/movespeed", true) == 0){
		new string[255];
		tmp = strtok(cmdtext,idx);
		if	(!strlen(tmp)){
			SendClientMessage(playerid, COLOR_WHITE, "USO: /movespeed [speed in m]");
			return 1;}
		movespeed = strval(tmp);
		format(string, sizeof(string), "MOVESPEED: %d.", movespeed);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		return 1;
	}
	if(strcmp(cmd, "/vehiclehealth", true) == 0){
		if(playervehiclebar[playerid] == 0){
			playervehiclebar[playerid] = 1;}
		else if(playervehiclebar[playerid] == 1){
			playervehiclebar[playerid] = 0;}
		return 1;
	}
	if(strcmp(cmd, "/osel", true) == 0)	{
		tmp = strtok(cmdtext,idx);
		if (!strlen(tmp)){
		GetPlayerPos(playerid,x2,y2,z2);
		SetPlayerCameraPos(playerid,x2+10,y2+10,z2+100);
		dis = 10;
		SetPlayerCameraLookAt(playerid,x2,y2,z2+100);
		TogglePlayerControllable(playerid,0);
		ShowMenuForPlayer(Main,playerid);
		GetKeys1(playerid);
		GetKeys2(playerid);
		keys = 0;
		return 1;}
		else{
		obi[playerid] = strval(tmp);
		GetPlayerPos(playerid,x2,y2,z2);
      	//id = obi[playerid];
        SpawnObject(obi[playerid]);
		keys = 2;
		GetKeys3(playerid);
		return 1;}
	}
	if(strcmp(cmd, "/object", true) == 0)	{
		tmp = strtok(cmdtext,idx);
		if (!strlen(tmp)){
		format(tmp,sizeof(tmp),"Object: %d", object);
		SendClientMessage(playerid, COLOR_RED, tmp);
		return 1;
		}
		object = strval(tmp);
		return 1;
	}
	if((strcmp(cmd,"/SetPlayerGas", true)==0)||(strcmp(cmd, "/SPG", true)==0))	  		{
			tmp = strtok(cmdtext, idx);
			if	(!strlen(tmp))				{
				SendClientMessage(playerid, COLOR_WHITE, "USO: /SetPlayerGas [playerid] [cant]");
				return 1;
				}
            new pid=strval(tmp);
	  		tmp = strtok(cmdtext, idx);
			if	(!strlen(tmp))				{
				SendClientMessage(playerid, COLOR_WHITE, "USO: /SetPlayerGas [playerid] [cant]");
				return 1;
				}
            new cant=strval(tmp);
			if  (!IsPlayerInAnyVehicle(pid))			    {
			    SendClientMessage(playerid, COLOR_WHITE, "That player is on FOOT...");
			    return 1;
			    }
			new vid = GetPlayerVehicleID(pid);
			new wm = GetVehicleModel(vid);
 			for (new h=0;h<MAX_CARS;h++){
			if (carDefines[h][ID]==wm){

			if	((VehicleInfo[VehStreamid[vid]][tank]/1000000 + cant) > carDefines[h][Tank]/10)		        {
		        cant=(carDefines[h][Tank]-VehicleInfo[VehStreamid[vid]][tank]/100000)/10;
		        }}}
	        VehicleInfo[VehStreamid[vid]][tank]=VehicleInfo[VehStreamid[vid]][tank]+cant*1000000;
			new string[255];
			new string2[255];
			format(string, sizeof(string), "An Admin have put %d litres in your vehicle", cant);
			format(string2, sizeof(string2), "You have added %d litres to a vehicle.", cant);
			SendClientMessage(pid, COLOR_YELLOW, string);
			SendClientMessage(playerid, COLOR_YELLOW, string2);
			format(string, sizeof(string), "Fuel:%d L", VehicleInfo[VehStreamid[vid]][tank]/1000000);
//			TankString[pid]=string;
// 			format(tmp, sizeof(tmp),"%s %s %s %s",TankString[pid],SpeedString[pid],KMString[pid], OilString[pid]);
			TextDrawSetString(SpeedoString[pid][0],string);
			TogglePlayerControllable(pid, true);
			return 1;
			}
	if(strcmp(cmd,"/tankinfo", true)==0){
            new wid = GetPlayerVehicleID(playerid);
            new lol[255];
            format(lol, sizeof(lol),"%d",VehicleInfo[VehStreamid[wid]][tank]);
            SendClientMessage(playerid,COLOR_RED,lol);
			return 1;}
	if(strcmp(cmd,"/speedo", true)==0){
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp)){
	 		SendClientMessage(playerid,COLOR_GREEN,"Usage: /speedo [on,off,kph,mph]");return 1;}
			if (!strcmp(tmp,"on",true,2))			{
			SpeedoInfo[playerid][enabled] = true;
			if (IsPlayerInAnyVehicle(playerid)){
			TextDrawShowForPlayer(playerid,SpeedoString[playerid][0]);
			TextDrawShowForPlayer(playerid,SpeedoString[playerid][1]);
			TextDrawShowForPlayer(playerid,SpeedoString[playerid][2]);
			TextDrawShowForPlayer(playerid,SpeedoString[playerid][3]);}
			SendClientMessage(playerid,COLOR_GREEN,"Speedometer: Enabled.");
			return 1;
			}

			else if (!strcmp(tmp,"off",true,3))			{
			SpeedoInfo[playerid][enabled] = false;
			if (IsPlayerInAnyVehicle(playerid)){
			TextDrawHideForPlayer(playerid,SpeedoString[playerid][0]);
			TextDrawHideForPlayer(playerid,SpeedoString[playerid][1]);
			TextDrawHideForPlayer(playerid,SpeedoString[playerid][2]);
			TextDrawHideForPlayer(playerid,SpeedoString[playerid][3]);}
			SendClientMessage(playerid,COLOR_GREEN,"Speedometer: Disabled.");
			return 1;
			}
			else if (!strcmp(tmp,"kph",true,3))			{
			SpeedoInfo[playerid][metric] = true;
			SendClientMessage(playerid,COLOR_GREEN,"Speedometer Units: Kph");
			return 1;
			}
			else if (!strcmp(tmp,"mph",true,3))
			{
			SpeedoInfo[playerid][metric] = false;
			SendClientMessage(playerid,COLOR_GREEN,"Speedometer Units: Mph");
			return 1;
	}}
	if(strcmp(cmd, "/car", true) ==0)	{
	        if(carSelect[playerid] == 0){
				PlayerPos[playerid][2] = GetXYInFrontOfPlayer(playerid,  PlayerPos[playerid][0],  PlayerPos[playerid][1], 5.0);
				GetPlayerFacingAngle(playerid, PlayerPos[playerid][3]);
				//UpdateNextCar(playerid);
				itemPlace[playerid][2]=0;
				UpdateCar(playerid);
				CreateCarSMenu(playerid);
				UpdatespideyMenu(playerid);
				carSelect[playerid] = 1;
				SendClientMessage(playerid, COLOR_YELLOW, "Use Arrow-Keys to navigate and Shift-Key (Sprint-key) to select");}
			return 1;}
	if(strcmp(cmd,"/carinfo", true)==0)	{
			new infoid, string3[255];
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp)){
	 		SendClientMessage(playerid,COLOR_GREEN,"Usage: /carinfo id");return 1;}
			infoid = strval(tmp);
			format(string3, sizeof(string3), "ID: %d   Name: %s   Fuel: %d   Tank: %d   Price: %d", carDefines[infoid][ID], carDefines[infoid][namec],carDefines[infoid][Fuel],carDefines[infoid][Tank],carDefines[infoid][Price]);
			SendClientMessage(playerid, COLOR_YELLOW, string3);return 1;}
	if(strcmp(cmd,"/vehinfo", true)==0)	{
		new infoid, string3[255];
		new pathfile[256];
		new string_[256];
		tmp = strtok(cmdtext, idx);
		format(pathfile,sizeof(pathfile),"carinfo.txt");
		if(!fexist(pathfile))fclose(fopen(pathfile,io_write));
		new File:handler = fopen(pathfile,io_append);
		if (!strlen(tmp)){
			for (new j = 0; j < MAX_STREAM_VEHICLES; j++){
				if (VehicleInfo[j][CREATED]){
					format(string_,256,"%d : X: %f Y: %f Z: %f Paint: %d Security: %d Priority: %d", j, VehicleInfo[j][veh_pos][0], VehicleInfo[j][veh_pos][1],VehicleInfo[j][veh_pos][2],	VehicleInfo[j][veh_pos][3],	VehicleInfo[j][paintjob], VehicleInfo[j][security], VehicleInfo[j][priority]);
					fwrite(handler,string_);
					format(string_,256,"Model: %d Owner: %s Tank: %d Meters: %d Oil: %d Oilmini: %d Oildamage: %d",VehicleInfo[j][model],VehicleInfo[j][owner],VehicleInfo[j][tank],VehicleInfo[j][meters],VehicleInfo[j][oilpress],VehicleInfo[j][oilminimum],VehicleInfo[j][oildamage]);
					fwrite(handler,string_);
					format(string_,256,"Locked: %d Plate: %s Health: %f World : %d Interior: %d Colors: %d . %d\r\n",VehicleInfo[j][locked],VehicleInfo[j][numberplate],VehicleInfo[j][health],VehicleInfo[j][world],VehicleInfo[j][interior],	VehicleInfo[j][colors][0],VehicleInfo[j][colors][1]);
					fwrite(handler,string_);
				}
			}
			fclose(handler);
		}
		else{
			new h = strval(tmp);
			if (VehicleInfo[h][CREATED]){
				format(string_,256,"%d : X: %f Y: %f Z: %f Paint: %d Security: %d Priority: %d", VehicleInfo[h][veh_pos][0], VehicleInfo[h][veh_pos][1],VehicleInfo[h][veh_pos][2],VehicleInfo[h][veh_pos][3],VehicleInfo[h][paintjob], VehicleInfo[h][security], VehicleInfo[h][priority]);
				SendClientMessage(playerid, COLOR_YELLOW, string_);
				format(string_,256,"Model: %d Owner: %s Tank: %d Meters: %d Oil: %d Oilmini: %d Oildamage: %d",VehicleInfo[h][model],VehicleInfo[h][owner],VehicleInfo[h][tank],VehicleInfo[h][meters],VehicleInfo[h][oilpress],VehicleInfo[h][oilminimum],VehicleInfo[h][oildamage]);
				SendClientMessage(playerid, COLOR_YELLOW, string_);
				format(string_,256,"Locked: %d Plate: %s Health: %f World : %d Interior: %d Colors: %d . %d\r\n",VehicleInfo[h][locked],VehicleInfo[h][numberplate],VehicleInfo[h][health],VehicleInfo[h][world],VehicleInfo[h][interior],	VehicleInfo[h][colors][0],VehicleInfo[h][colors][1]);
				SendClientMessage(playerid, COLOR_YELLOW, string_);
				return 1;
			}
			}
		return 1;
	}
	if(!strcmp(cmd,"/pos",true,4))	{
		GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
		GetPlayerFacingAngle(playerid,Pos[playerid][3]);
		Interior[playerid] = GetPlayerInterior(playerid);
		tmp = strtok(cmdtext,idx);
		BIZNAME[playerid]= tmp;
		format(str,256,"%s succesfully defined .. X: %.4f .. Y: %.4f .. Z: %.4f .. Angle: %.4f .. Interior: %d", tmp,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2],Pos[playerid][3],Interior[playerid]);
		SendClientMessage(playerid,gelb,str);
	    new File:fhandle;
    	fhandle = fopen("TeleportMaker.txt",io_append);
	    fwrite(fhandle,	" \r\n");
   		format(str,256,	"      %s\r\n ",BIZNAME[playerid]);
		fwrite(fhandle,str);
		format(str,256,	"      SetPlayerPos(playerid,%.4f,%.4f,%.4f);\r\n",Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
		fwrite(fhandle,str);
		format(str,256,	"      SetPlayerFacingAngle(playerid,%.4f);\r\n",Pos[playerid][3]);
		fwrite(fhandle,str);
		format(str,256,	"      SetPlayerInterior(playerid,%d);\r\n",Interior[playerid]);
		fwrite(fhandle,str);
  		fwrite(fhandle, "\r\n");
  		fclose(fhandle);
  		SendClientMessage(playerid,gelb,"Your Teleport has been created in the file 'TeleportMaker.txt' in your scriptfiles");
	    return 1;
	}
	if(strcmp("/getpos", cmd, true) == 0)	{
	new Float:xp,Float:yp,Float:zp,Float:ap;
	GetPlayerPos(playerid, xp, yp, zp);
	GetPlayerFacingAngle(playerid, ap);
    format(tmp,255,"Position: X: %.4f   Y: %.4f   Z: %.4f   Angle: %.4f", xp,yp,zp,ap);
	SendClientMessage(playerid, COLOR_YELLOW, tmp);
	return 1;
	}
	if(strcmp(cmd,"/setpos", true) == 0)	{
	new Float:xp,Float:yp,Float:zp,Float:ap;
	new Float:xx,Float:yy,Float:zz;
	new tmpp[255];
	GetPlayerPos(playerid, xp, yp, zp);
	GetPlayerFacingAngle(playerid, ap);
    tmp = strtok(cmdtext,idx);
	xx = strval(tmp);
	tmp = strtok(cmdtext,idx);
	yy = strval(tmp);
	tmp = strtok(cmdtext,idx);
	zz = strval(tmp);
	SetPlayerPos(playerid, xp+xx,yp+yy,zp+zz);
    format(tmpp,255,"Position: X: %.4f   Y: %.4f   Z: %.4f   Angle: %.4f", x+xx,y+yy,z+zz,ap);
	SendClientMessage(playerid, COLOR_YELLOW, tmp);
	return 1;
	}
	if(strcmp("/omove", cmd, true) == 0)	{
		new obi2;
		tmp = strtok(cmdtext,idx);
		obi2 = strval(tmp);
		if (strlen(tmp)){
		GetPlayerPos(playerid,x2,y2,z2);
//		for(new i = 0; i<MAX_OBJECTS2; i++){
//		if{gateobj[i]>0){
	    id = gateobj[obi2];
		ob[gateobj[obi2]] = id;
		keys = 2;
		GetKeys3(playerid);
		return 1;}
	}
	if(strcmp("/osav", cmd, true) == 0)	{
	SaveObjects(playerid);
	}
	if(strcmp("/opause", cmd, true) == 0)	{
	keys = 4;
	GameTextForPlayer(playerid,"~w~Map Designer Has Been ~r~PAUSED",1000,6);
	}
	if(strcmp("/oresume", cmd, true) == 0)	{
	keys = 2;
	GameTextForPlayer(playerid,"~w~Map Designer Has Been ~g~RESUMED",1000,6);
	}
	if(strcmp("/undo", cmd, true) == 0)	{
	DestroyObject(object);
	}
	if(strcmp(cmd, "/login", true) == 0) {
    if (PLAYERLIST_authed[playerid]){
	SendClientMessage(playerid,COLOR_GREEN,"Already logged in.");return 1;}
	GetPlayerName(playerid, Playername, sizeof(Playername));
	if (!udb_Exists(PlayerName(playerid))){
	 SendClientMessage(playerid,COLOR_GREEN,"Account doesn't exist, please use '/register password'.");return 1;}
    tmp = strtok(cmdtext, idx);
	if (!strlen(tmp)){
	SendClientMessage(playerid,COLOR_GREEN,"Usage: /login password'");return 1;}
	else {
		if (udb_CheckLogin(PlayerName(playerid),tmp)) {
		if(Playertimer4[playerid]){KillTimer(Playertimer4[playerid]);TogglePlayerControllable(playerid,true);}
		GivePlayerMoney(playerid,dUserINT(PlayerName(playerid)).("money")-GetPlayerMoney(playerid)+dUserINT(PlayerName(playerid)).("bizbet")+dUserINT(PlayerName(playerid)).("bid"));
        dUserSetINT(PlayerName(playerid)).("bizbet",0);
        dUserSetINT(PlayerName(playerid)).("bid",0);
		PLAYERLIST_authed[playerid]=true;
		bufu[playerid] = 0;
		SpawnPlayer(playerid);
		THIRSTY[playerid] = (dUserINT(PlayerName(playerid)).("thirsty"));
		HUNGRY[playerid] = (dUserINT(PlayerName(playerid)).("hungry"));
		SEXY[playerid] = (dUserINT(PlayerName(playerid)).("sexy"));
		PutAtPos(playerid);
		}
		else {SendClientMessage(playerid,COLOR_GREEN,"Wrong Password! Login failed!");}
	}
	return 1;
	}
	if(strcmp(cmd, "/register", true) == 0) {

    if (PLAYERLIST_authed[playerid]){
	 SendClientMessage(playerid,COLOR_GREEN,"Already logged in.");
	 return 1;}

	GetPlayerName(playerid, Playername, sizeof(Playername));
    if (udb_Exists(PlayerName(playerid))){
	 SendClientMessage(playerid,COLOR_GREEN,"Account already exists, please use /login password'.");
	 return 1;}

    tmp = strtok(cmdtext, idx);
    if (!strlen(tmp)){
		SendClientMessage(playerid,COLOR_GREEN,"Usage: /register password'");return 1;}
	else {
    	if (udb_Create(PlayerName(playerid),tmp)){
		PLAYERLIST_authed[playerid]=true;
		bufu[playerid] = 1;
		SendClientMessage(playerid,COLOR_RED,"Account successfully created. Choose your civilian skin!");}
	}
    return 1;
	}
	if(strcmp(cmd, "/bid", true) == 0) {
		//wenn man /bet schreibt
		new propmess2[256];
		new oldoffmassage[256];
		cash[playerid] = GetPlayerMoney(playerid); //geld
	    GetPlayerName(playerid, playername1, MAX_PLAYER_NAME); //name
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]); //Um das buisness zu identifizieren wird cttmp verwendet und die biznum die vorher festgelegt wurde wenn man das pickup aufhebt
//		ownername = dini_Get(cttmp,"owner"); //Der name des besitzers
 		BIZNAME2 = dini_Get(cttmp,"name");
        tmp = strtok(cmdtext, idx);
        oldname1 = dini_Get(cttmp,"oldbetor");
		thebet[playerid] = strval(tmp); //nimm das wort nach /bet als tmp
        format(propmess, sizeof(propmess), "The minimallevel is %d. The maximallevel is %d. Dein Gebot ist %d. Dein Prop ist %d.The Minimalbet is %d. The Maximalbet is %d. ", miniskill[playerid], maxiskill[playerid], thebet[playerid],propactive[playerid], minibet[playerid], maxibet[playerid]);
        SendClientMessage(playerid,COLOR_GREEN,propmess);
        format(propmess, sizeof(propmess), "Die Biznummer ist die %d. Das Höchstgebot ist derzeit $%d. Der Profit ist $%d. Der Besitzer heist %s. Das Biz heißt %s",biznum[playerid],propcost[playerid],profit[playerid], ownername, BIZNAME2);
        SendClientMessage(playerid,COLOR_GREEN,propmess);
        if (bidorbuy[playerid] == 1){
			SendClientMessage(playerid, COLOR_GREEN, "There is no Auction. You can buy the biz by typing /buy.");
			return 1;
		}
		if (!strlen(tmp)){ //wenn keine summe angegeben ist nicht weiter !!!
	 		SendClientMessage(playerid,COLOR_GREEN,"Usage: /bid [amount]'");
	 		return 1;}
		if(propactive[playerid] == 0 || bidorbuy[playerid] == 0) { //Wenn ich in keinem Dollarsymbol stehe nicht weiter !!!
		    SendClientMessage(playerid, COLOR_GREEN, "You must be in a property checkpoint in order to buy a business/house!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {//wenn in einem vehicle bin nicht weiter !!!
			SendClientMessage(playerid, COLOR_GREEN, "You must be on foot to purchase a business!");
			return 1;
		}
		if (bidorbuy[playerid] == 2){
		if(minibet[playerid] > thebet[playerid] || thebet[playerid] > 2*maxibet[playerid]){ //wenn gebot unter oder über der grenze liegt nicht weiter !!!
            format(propmess, sizeof(propmess), "The minimalbid is $%d. The maximalbid is $%d. Give a bid between this.", minibet[playerid], maxibet[playerid]);
			SendClientMessage(playerid, COLOR_GREEN, propmess);
	  		return 1;}
		if(miniskill[playerid] > Playerlevel[playerid] || Playerlevel[playerid] > maxiskill[playerid]){ //wenn gebot unter oder über der grenze liegt nicht weiter !!!
			format(propmess, sizeof(propmess), "U don't have the necessary Level. The minimallevel is %d. The maximallevel is %d", miniskill[playerid], maxiskill[playerid]);
		    SendClientMessage(playerid, COLOR_GREEN, propmess);
	  		return 1;}
		if(cash[playerid] >= thebet[playerid] && thebet[playerid] > propcost[playerid]) { //wenn das geld auf der hand größer ist als das gebot und das gebot größer ist als das Höchstgebot nicht weiter !!!
                dini_IntSet(cttmp, "propcost", thebet[playerid]); //die kosten werden auf dem server aktualisiert
				bizbet1 = dUserINT(oldname1).("bizbet");
				oldoffmassage = dUser(oldname1).("offlinemassage");
				format(propmess, sizeof(propmess), "oldplayername=%s", playername2);
				SendClientMessage(playerid, COLOR_GREEN,propmess);
                GivePlayerMoney(playerid, -thebet[playerid]); //
                if (oldbet[playerid] > 0){
					format(propmess, sizeof(propmess), "Ur bid for the %s has been overbid! Here is ur old bid ($%d) back!", BIZNAME2, oldbet[playerid]);
					for(new k=0;k<=MAX_PLAYERS;k++) { //jeder spieler der
				    if(IsPlayerConnected(k)) { //wenn der spieler online ist
					GetPlayerName(k,playername2,sizeof(playername2));
					if(strcmp(playername2,oldname1,false) == 0) {
   					GivePlayerMoney(k, oldbet[playerid]);
					SendClientMessage(k, COLOR_GREEN, propmess);}
					else{ 	dUserSetINT(oldname1).("bizbet",oldbet[playerid] + bizbet1);
							format(propmess2, sizeof(propmess2),"%s~n~%s",oldoffmassage, propmess);
							dUserSet(oldname1).("offlinemassage",propmess2);}}}}
                dini_Set(cttmp,"oldbetor", playername1);
				dini_IntSet(cttmp, "oldbet", thebet[playerid]);
				format(propmess, sizeof(propmess), "Your bet is the highest bet for the %s, the bizowner changes every Hour. U will get ur bid back when someone overbid u or when u loose the biz.", BIZNAME2);
				SendClientMessage(playerid, COLOR_GREEN, propmess);
				return 1;
			}
		else if(cash[playerid] < thebet[playerid]) {
				//wenn das geld weniger ist als das gebot
				format(propmess, sizeof(propmess), "You do not have enough cash to cover ur bet and cannot afford the %s!", BIZNAME2);
				SendClientMessage(playerid, COLOR_GREEN, propmess);
			}
		else if(thebet[playerid] <= propcost[playerid]) {
				//wenn das gebot kleiner oder gleich ist als das Höchstgebot nicht weiter !!!
				format(propmess, sizeof(propmess), "Your bet is under the highest bet.");
				SendClientMessage(playerid, COLOR_GREEN, propmess);
				return 1;
			}}
		return 1;
	}
	if(strcmp(cmd, "/buy", true) == 0) {
		new propmess2[256];
		new oldoffmassage[256];
		cash[playerid] = GetPlayerMoney(playerid); //geld
	    GetPlayerName(playerid, playername1, MAX_PLAYER_NAME); //name
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]);
		ownername = dini_Get(cttmp,"owner"); //Der name des besitzers
 		BIZNAME2 = dini_Get(cttmp,"name");
        oldname1 = dini_Get(cttmp,"oldbetor");

        if(bidorbuy[playerid] == 2){
			SendClientMessage(playerid, COLOR_GREEN, "There is a Auction. You can bid for the biz by typing /bid.");
			return 1;
		}
		if(propactive[playerid] == 0) {
			//Wenn ich in keinem Dollarsymbol stehe nicht weiter !!!
		    SendClientMessage(playerid, COLOR_GREEN, "You must be in a property checkpoint in order to buy a business/house!");
			return 1;
		}
		if(bidorbuy[playerid] == 0) {
			//Wenn ich in keinem Dollarsymbol stehe nicht weiter !!!
            format(propmess, sizeof(propmess), "You already own the %s.", BIZNAME2);
			SendClientMessage(playerid, COLOR_GREEN, propmess);
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			//wenn in einem vehicle bin nicht weiter !!!
			SendClientMessage(playerid, COLOR_GREEN, "You must be on foot to purchase a business!");
			return 1;
		}
		if(bidorbuy[playerid] == 1){
		if(miniskill[playerid] > Playerlevel[playerid] || Playerlevel[playerid] > maxiskill[playerid]){
			//wenn gebot unter oder über der grenze liegt nicht weiter !!!
			format(propmess, sizeof(propmess), "U don't have the necessary Level. The minimallevel is %d. The maximallevel is %d", miniskill[playerid], maxiskill[playerid]);
		    SendClientMessage(playerid, COLOR_GREEN, propmess);
	  		return 1;}
		if(cash[playerid] < propcost[playerid]){
 			//wenn gebot unter oder über der grenze liegt nicht weiter !!!
            format(propmess, sizeof(propmess), "U don't have enough cash. The business costs $%d.", propcost[playerid]);
			SendClientMessage(playerid, COLOR_GREEN, propmess);
	  		return 1;}
                format(propmess, sizeof(propmess), "The minimallevel is %d. The maximallevel is %d. Dein Gebot ist %d. Dein Prop ist %d.The Minimalbet is %d. The Maximalbet is %d. ", miniskill[playerid], maxiskill[playerid], thebet[playerid],propactive[playerid], minibet[playerid], maxibet[playerid]);
        		SendClientMessage(playerid,COLOR_GREEN,propmess);
        		format(propmess, sizeof(propmess), "Die Biznummer ist die %d. Das Höchstgebot ist derzeit $%d. Der Profit ist $%d. Der Besitzer heist %s. Das Biz heißt %s",biznum[playerid],propcost[playerid],profit[playerid], ownername, BIZNAME2);
             	SendClientMessage(playerid,COLOR_GREEN,propmess);
				bizbet1 = dUserINT(oldname1).("bizbet");
                GivePlayerMoney(playerid, -thebet[playerid]);
				oldoffmassage = dUser(oldname1).("offlinemassage");
				if (oldbet[playerid] > 0){
					format(propmess, sizeof(propmess), "You sold the %s for $%d!", BIZNAME2, propcost[playerid]);
					for(new k=0;k<=MAX_PLAYERS;k++) { //jeder spieler der
						if(IsPlayerConnected(k)) { //wenn der spieler online ist
							GetPlayerName(k,playername2,sizeof(playername2));
							if(strcmp(playername2,oldname1,false) == 0) {
								GivePlayerMoney(k, oldbet[playerid]);
							SendClientMessage(k, COLOR_GREEN, propmess);}
							else{ 	dUserSetINT(oldname1).("bizbet",oldbet[playerid] + bizbet1);
								format(propmess2, sizeof(propmess2),"%s~n~%s",oldoffmassage, propmess);
							dUserSet(oldname1).("offlinemassage",propmess2);}}}}

                dini_Set(cttmp,"oldbetor", playername1);
				dini_IntSet(cttmp, "oldbet", propcost[playerid]);
				format(propmess, sizeof(propmess), "You have bought the %s for %d. Don't forget to pay ur bills or the biz will be auctioned. With sell the biz with /sellbiz.", BIZNAME2, propcost[playerid]);
				SendClientMessage(playerid, COLOR_GREEN, propmess);
				return 1;
			}
		return 1;
	}
	if(strcmp(cmd, "/sellbiz", true) == 0) {
		new bizowned;
		new priced;
		GetPlayerName(playerid, playername1, MAX_PLAYER_NAME); //spielername
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]); //Um das buisness zu identifizieren wird cttmp verwendet und die biznum die vorher festgelegt wurde wenn man das pickup aufhebt
	    playerbiz[playerid] = dUserINT(playername1).("bizowned");
		ownername = dini_Get(cttmp,"owner");
		BIZNAME2 = dini_Get(cttmp,"name");
		if(propactive[playerid] == 0) {
			//Wenn ich in keinem Dollarsymbol stehe nicht weiter !!!
		    SendClientMessage(playerid, COLOR_GREEN, "You must be in a property checkpoint in order to sell a business!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			//wenn in einem vehicle bin nicht weiter !!!
			SendClientMessage(playerid, COLOR_GREEN, "You must be on foot to sell a business!");
			return 1;
		}
		if (strcmp("Goverment",ownername,false) == 0) {
			//wenn das biz keinem gehört dann nicht weiter !!!
		    SendClientMessage(playerid, COLOR_GREEN, "Nobody has bought this business yet and you are prohibited from selling it!");
			return 1;
		}
		if(playerbiz[playerid] == 0) {
			//wenn der spieler kein biz hat
		    SendClientMessage(playerid, COLOR_GREEN, "You do not yet own any business, nice try loser!");
		    return 1;
		}
		if (strcmp(playername1,ownername,false) == 0) {
			tmp = strtok(cmdtext,idx);
			priced = strval(tmp);
			if (!strlen(tmp) || (priced<=0 && strcmp(tmp,"Auction",true) == 0)){
				SendClientMessage(playerid,COLOR_GREEN,"Usage: /sellbiz [Price ($)/Auction]");
				return 1;
				}
			if (strcmp(tmp,"Auction",false) == 0) {
				dini_IntSet(cttmp,"forselling",2);
				format(propmess, sizeof(propmess), "You set an auction on %s!", BIZNAME2);
				SendClientMessage(playerid, COLOR_GREEN, propmess);
				SendClientMessage(playerid,COLOR_GREEN,"The government will buy it in case there 'll be no bids. Auctions take 2hours.");
				}
			else if (priced > 0 && priced < 2*maxibet[playerid]){
				dini_IntSet(cttmp,"forselling",1);}
			else if (priced > 0 && priced > 2*maxibet[playerid]){}
			//wenn der spielername gleich dem Besitzernamen ist
			cash[playerid] = GetPlayerMoney(playerid); //geld
			GetPlayerName(playerid, playername1, MAX_PLAYER_NAME);
			dini_Set(cttmp,"owner", "Goverment");
			bizowned = dUserINT(playername1).("bizowned");
			dUserSetINT(playername1).("bizowned", bizowned - 1);
			dini_IntSet(cttmp, "bought", 0);
			dini_IntSet(cttmp, "totalprofit", 0);
			GivePlayerMoney(playerid, propcost[playerid]);
			format(propmess, sizeof(propmess), "You just sold your business for $%d.", propcost[playerid]);
			SendClientMessage(playerid, COLOR_GREEN, propmess);
			return 1;
		}
		SendClientMessage(playerid, COLOR_GREEN, "You do not own this business!");
		return 1;
	}
	if(strcmp(cmd, "/getprofit", true) == 0) {
	    GetPlayerName(playerid, playername1, MAX_PLAYER_NAME);
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]);
	    ownername = dini_Get(cttmp,"owner");
	    playerbiz[playerid] = dUserINT(playername1).("bizowned");
	    biznum[playerid] = dini_Int(cttmp,"idnumber");
		BIZNAME2 = dini_Get(cttmp, "name");
		if(propactive[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_GREEN, "You must be in a business checkpoint in order to collect your earnings!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_GREEN, "You must be on foot to collect your earnings!");
			return 1;
		}
		if(strcmp(ownername,"server",false) == 0) {
				format(propmess, sizeof(propmess), "Nobody has bought this business yet, what are you trying to pull punk!");
				SendClientMessage(playerid, COLOR_GREEN, propmess);
				return 1;
		}
		if(playerbiz[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_GREEN, "You do not yet own any business, nice try loser!");
		    return 1;
		}
		if(strcmp(ownername,playername1,false) == 0) {
			totalprofit[playerid] = dini_Int(cttmp, "totalprofit");

			if(totalprofit[playerid] == 0) {
				SendClientMessage(playerid,COLOR_GREEN,"Your business has not yet made any earnings since your last visit. Please wait for notification of updated earnings!");
				return 1;
			}
			GivePlayerMoney(playerid,totalprofit[playerid]);
			dini_IntSet(cttmp, "totalprofit", 0);
			format(propmess, sizeof(propmess), "You have collected $%d of earnings from your %d, %s! Enjoy!", totalprofit[playerid], BIZNAME2, ownername);
			SendClientMessage(playerid, COLOR_GREEN, propmess);
			return 1;
		}
		format(propmess, sizeof(propmess), "This business belongs to %s, nice try loser! Stop trying to steal other peoples business earnings!",ownername);
		SendClientMessage(playerid, COLOR_GREEN, propmess);
		return 1;
	}
	//$ region interiors
		///////////////////////// 24/7 /////////////////////////
		if(strcmp(cmd,"/247",true)==0){
			SendClientMessage(playerid,C,"=== 24/7 Stores ===");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/2471 - Version 1 - Big - L-shaped - NO EXIT");
			SendClientMessage(playerid,C,"/2472 - Version 2 - Big - Oblong   - NO EXIT");
			SendClientMessage(playerid,C,"/2473 - Version 3 - Med - Square   - Creek, LV");
			SendClientMessage(playerid,C,"/2474 - Version 4 - Med - Square   - NO EXIT");
			SendClientMessage(playerid,C,"/2475 - Version 5 - Sml - Long     - Mulholland");
			SendClientMessage(playerid,C,"/2476 - Version 6 - Sml - Square   - Whetstone");
			SendClientMessage(playerid,C,"\n");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/2471",true)==0){
		s="Large - Lshaped";t="24/7 (V1)";u="X7_11D";v=17;w=0;x=-25.884499;y=-185.868988;z=1003.549988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/2472",true)==0){
		s="Large - Oblong";t="24/7 (V2) - (large)";u="X711S3";v=10;w=0;x=6.091180;y=-29.271898;z=1003.549988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/2473",true)==0){
		s="Medium - Square";t="24/7 (V3)";u="X7_11B";v=18;w=0;x=-30.946699;y=-89.609596;z=1003.549988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/2474",true)==0){
		s="Medium - Square";t="24/7 (V4)";u="X7_11C";v=16;w=0;x=-25.132599;y=-139.066986;z=1003.549988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/2475",true)==0){
		s="Small - Long";t="24/7 (V5)";u="X711S2";v=4;w=0;x=-27.312300;y=-29.277599;z=1003.549988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/2476",true)==0){
		s="Small - Square";t="24/7 (V6)";u="X7_11S";v=6;w=0;x=-26.691599;y=-55.714897;z=1003.549988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// AERODYNAMICS /////////////////////////
		if(strcmp(cmd,"/AIR",true)==0){
			SendClientMessage(playerid,C,"=== ALL THINGS AERODYNAMIC ===");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/AIR1 - Francis Intn'l Airport - Ticket sales");
			SendClientMessage(playerid,C,"/AIR2 - Francis Intn'l Airport - Baggage claim");
			SendClientMessage(playerid,C,"/AIR3 - Shamal cabin (good jump spot)");
			SendClientMessage(playerid,C,"/AIR4 - Andromada cargo hold");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"\n");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/AIR1",true)==0){
		s="Remove your shoes please...";t="Francis Int. Airport (Front Exterior & Ticket Sales)";u="AIRPORT";	v=14;w=0;x=-1827.147338;y=7.207418;z=1061.143554;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/AIR2",true)==0){
		s="Why is your bag ticking sir?";t="Francis Int. Airport (Baggage Claim)";u="AIRPOR2";	v=14;w=0;x=-1855.568725;y=41.263156;z=1061.143554;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/AIR3",true)==0){
		s="Nice jump area in back";t="Shamal Interior";u="JETINT";v=1;w=0;x=2.384830;y=33.103397;z=1199.849976;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/AIR4",true)==0){
		s="Cargo Hold";t="Andromada";u="Spectre";v=9;w=0;x=315.856170;y=1024.496459;z=1949.797363;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// AMMUNATION /////////////////////////
		if(strcmp(cmd,"/AMU",true)==0){
			SendClientMessage(playerid,C,"=== Ammunations ===");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/AMU1 - Ocean Flats, SF");
			SendClientMessage(playerid,C,"/AMU2 - Palomino Creek, LV");
			SendClientMessage(playerid,C,"/AMU3 - Angel Pine, SF");
			SendClientMessage(playerid,C,"/AMU4 - (2 story)");
			SendClientMessage(playerid,C,"/AMU5 - El Quebrados, LV");
			SendClientMessage(playerid,C,"/AMU6 - Inside the booths");
			SendClientMessage(playerid,C,"/AMU7 - Inside the range");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/AMU1",true)==0){
			s="NONE";t="Ammunation (V2)";u="AMMUN1";
		v=1;w=315;x=286.148987;y=-40.644398;z=1001.569946;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/AMU2",true)==0){
			s="NONE";t="Ammunation (V3)";u="AMMUN2";
		v=4;w=315;x=286.800995;y=-82.547600;z=1001.539978;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/AMU3",true)==0){
			s="NONE";t="Ammunation (V4)";u="AMMUN3";
		v=6;w=90;x=296.919983;y=-108.071999;z=1001.569946;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/AMU4",true)==0){
			s="Check the machine to your right";t="Ammunation (V1)(2 floors)";u="AMMUN4";
		v=7;w=45;x=314.820984;y=-141.431992;z=999.661987;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/AMU5",true)==0){
			s="NONE";t="Ammunation (V5)";u="AMMUN5";
		v=6;w=45;x=316.524994;y=-167.706985;z=999.661987;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/AMU6",true)==0){
			s="Lock and Load";t="Ammunation Booths";u="Spectre";
		v=7;w=0;x=302.292877;y=-143.139099;z=1004.062500;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/AMU7",true)==0){
			s="Now you know what a target sees";t="Ammunation Range";u="Spectre";
		v=7;w=270;x=280.795104;y=-135.203353;z=1004.062500;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// BURGLARY HOUSES /////////////////////////
		if(strcmp(cmd,"/X",true)==0){
			SendClientMessage(playerid,C,"=== BURGLARY HOUSES ===");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"I've counted 23 burglary houses and will call them X1 thru X23...");
			SendClientMessage(playerid,C,"Some of these were obviously tests that R* never removed (they do that");
			SendClientMessage(playerid,C,"a lot). A lot of them have bad textures, doors that go nowhere, etc..");
			SendClientMessage(playerid,C,"Some are clearly early models of later and better designed safe houses");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"Clan folk - You'll probably find some of these perfect for home bases.");
			SendClientMessage(playerid,C,"\n");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/X1",true)==0){
			s="Large/2 story/3 bedrooms/clone of X9";t="X1";u="LAHSB4";
		v=3;w=0;x=235.508994;y=1189.169897;z=1080.339966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X2",true)==0){
			s="Medium/1 story/1 bedroom";t="X2";u="LAHS1A";
		v=2;w=90;x=225.756989;y=1240.000000;z=1082.149902;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X3",true)==0){
			s="Small/1 story/1 bedroom";t="X3";u="LAHS1B";
		v=1;w=0;x=223.043991;y=1289.259888;z=1082.199951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X4",true)==0){
			s="VERY Large/2 story/4 bedrooms";t="X4";u="LAHSB2";
		v=7;w=0;x=225.630997;y=1022.479980;z=1084.069946;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X5",true)==0){
			s="Small/1 story/2 bedrooms";t="X5";u="VGHSS1";
		v=15;w=0;x=295.138977;y=1474.469971;z=1080.519897;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X6",true)==0){
			s="Small/1 story/2 bedrooms";t="X6";u="VGSHS2";
		v=15;w=0;x=328.493988;y=1480.589966;z=1084.449951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X7",true)==0){
			s="Small/1 story/1 bedroom/NO BATHROOM!";t="X7";u="VGSHM2";
		v=15;w=90;x=385.803986;y=1471.769897;z=1080.209961;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X8",true)==0){
			s="Small/1 story/1 bedroom";t="X8";u="VGSHM3";
		v=15;w=90;x=375.971985;y=1417.269897;z=1081.409912;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X9",true)==0){
			s="Large/2 story/3 bedrooms/clone of X1";t="X9";u="VGHSB3";
		v=2;w=0;x=490.810974;y=1401.489990;z=1080.339966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X10",true)==0){
			s="Medium/1 story/2 bedrooms";t="X10";u="VGHSB1";
		v=2;w=0;x=447.734985;y=1400.439941;z=1084.339966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X11",true)==0){
			s="Large/2 story/4 bedrooms";t="X11";u="LAHSB3";
		v=5;w=270;x=227.722992;y=1114.389893;z=1081.189941;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X12",true)==0){
			s="Small/1 story/1 bedroom";t="X12";u="LAHS2A";
		v=4;w=0;x=260.983978;y=1286.549927;z=1080.299927;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X13",true)==0){
			s="Small/1 story/1 bedroom/NO BATHROOM!";t="X13";u="LAHSS6";
		v=4;w=0;x=221.666992;y=1143.389893;z=1082.679932;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X14",true)==0){
			s="Medium/2 story/1 bedroom";t="X14";u="VGHSM3";
		v=10;w=0;x=27.132700;y=1341.149902;z=1084.449951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X15",true)==0){
			s="Large/2 story/1 bedroom/NO BATHROOM!";t="X15";u="SFHSM2";
		v=4;w=90;x=-262.601990;y=1456.619995;z=1084.449951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X16",true)==0){
			s="Medium/1 story/2 bedrooms/NO BATHROOM or DOORS!";t="X16";u="VGHSM2";
		v=5;w=0;x=22.778299;y=1404.959961;z=1084.449951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X17",true)==0){
			s="Large/2 story/4 bedrooms/NO BATHROOM!";t="X17";u="SFHSB1";
		v=5;w=0;x=140.278000;y=1368.979980;z=1083.969971;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X18",true)==0){
			s="Large/2 story/3 bedrooms";t="X18";u="LAHSB1";
		v=6;w=0;x=234.045990;y=1064.879883;z=1084.309937;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X19",true)==0){
			s="Small/1 story/NO BEDROOM!";t="X19";u="SFHSS2";
		v=6;w=0;x=-68.294098;y=1353.469971;z=1080.279907;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X20",true)==0){
			s="Something is SERIOUSLY wrong with this model";t="X20";u="SFHSM1";
		v=15;w=0;x=-285.548981;y=1470.979980;z=1084.449951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X21",true)==0){
			s="Small/1 story/NO BEDROOM!";t="X21";u="SFHSS1";
		v=8;w=0;x=-42.581997;y=1408.109985;z=1084.449951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X22",true)==0){
			s="Medium/2 story/2 bedrooms";t="X22";u="SFHSB3";
		v=9;w=0;x=83.345093;y=1324.439941;z=1083.889893;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/X23",true)==0){
			s="Small/1 story/1 bedroom";t="X23";u="LAHS2B";
		v=9;w=0;x=260.941986;y=1238.509888;z=1084.259888;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// BUSINESSES /////////////////////////
		if(strcmp(cmd,"/BUS",true)==0){
			SendClientMessage(playerid,C,"=== BLANK ===");
			SendClientMessage(playerid,C,"/BUS1 - Blastin' Fools Records hallway");
			SendClientMessage(playerid,C,"/BUS2 - Budget Inn Motel room");
			SendClientMessage(playerid,C,"/BUS3 - Jefferson Motel");
			SendClientMessage(playerid,C,"/BUS4 - Off Track Betting");
			SendClientMessage(playerid,C,"/BUS5 - Sex Shop");
			SendClientMessage(playerid,C,"/BUS6 - Sindacco Meat Processing Plant");
			SendClientMessage(playerid,C,"/BUS7 - Zero's RC Shop");
			SendClientMessage(playerid,C,"/BUS8 - Gasso gas station in Dillimore");
		SendClientMessage(playerid,C,"type /Menu to return to the full category list");return 1;}
		if(strcmp(cmd,"/BUS1",true)==0){
			s="ONLY THE FLOOR IS SOLID!";t="Blastin' Fools Records corridor";u="STUDIO";
		v=3;w=0;x=1038.509888;y=-0.663752;z=1001.089966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/BUS2",true)==0){
			s="MOtel ROOM";t="Budget Inn Motel Room";u="MOROOM";
		v=12;w=0;x=446.622986;y=509.318970;z=1001.419983;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/BUS3",true)==0){
			s="NONE";t="Jefferson Motel";u="MOTEL1";
		v=15;w=0;x=2216.339844;y=-1150.509888;z=1025.799927;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/BUS4",true)==0){
			s="GENeric Off Track Betting";t="Off Track Betting";u="GENOTB";
		v=3;w=90;x=833.818970;y=7.418000;z=1004.179993;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/BUS5",true)==0){
			s="Uh, because they sell sex stuff?";t="Sex Shop";u="SEXSHOP";
		v=3;w=45;x=-100.325996;y=-22.816500;z=1000.741943;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/BUS6",true)==0){
			s="We've found Jimmy Hoffa!";t="Sindacco Meat Processing Plant";u="ABATOIR";
		v=1;w=180;x=964.376953;y=2157.329834;z=1011.019958;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/BUS7",true)==0){
			s="NONE";t="Zero's RC Shop";u="RCPLAY";
		v=6;w=0;x=-2239.569824;y=130.020996;z=1035.419922; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/BUS8", true)==0){
			s="Northern wall and shelves are non-solid";t="Gasso gas station in Dillimore";u="Spectre";
		v=0;w=90;x=662.641601;y=-571.398803;z=16.343263;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// CAR MOD SHOPS /////////////////////////
		if(strcmp(cmd,"/CART",true)==0){
			SendClientMessage(playerid,C,"=== CAR MOD SHOPS ===");
			SendClientMessage(playerid,C,"YOU ARE NOT SUPPOSED TO BE IN A MOD SHOP WHILE NOT IN A VEHICLE!");
			SendClientMessage(playerid,C,"These coordinates are safe but MOVE AND YOU RISK A MAJOR CRASH!");
			SendClientMessage(playerid,C,"/CAR1 - Transfenders - safely on the roof.../CAR1X - inside - DANGER!");
			SendClientMessage(playerid,C,"/CAR2 - Loco Low Co - safely on the roof.../CAR2X - inside - DANGER!");
			SendClientMessage(playerid,C,"/CAR3 - Wheels Arch Angels - safely on the roof.../CAR3Xx - inside - DANGER!");
			SendClientMessage(playerid,C,"/CAR4 - Michelle's Garage - safely on the roof - camera goes funny if inside");
			SendClientMessage(playerid,C,"/CAR5 - CJ's Garage in SF - camera acts funny*");
			SendClientMessage(playerid,C,"* If you believe the calendar, the game is set in 1998 as that's the only year Jan starts on a Thursday");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/CAR1x",true)==0){
			s="YOU HAVE BEEN WARNED!";t="Transfenders - inside";u="CARDMOD1";
		v=1;w=0;x=614.581420;y=-23.066856;z=1004.781250;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CAR2x",true)==0){
			s="YOU HAVE BEEN WARNED!";t="Loco Low Co - inside";u="CARMOD2";
		v=2;w=180;x=620.420410;y=-72.015701;z=997.992187;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CAR3x",true)==0){
			s="YOU HAVE BEEN WARNED!";t="Wheels Arch Angels - inside";u="CARMOD3";
		v=3;w=315;x=612.508605;y=-129.236114;z=997.992187;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CAR1",true)==0){
			s="You're safe up here";t="Transfenders";u="CARMOD1 - on the roof";
		v=1;w=0;x=614.581420;y=-23.066856;z=1009.781250;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CAR2",true)==0){
			s="You're safe up here";t="Loco Low Co";u="CARMOD2 - on the roof";
		v=2;w=180;x=620.420410;y=-72.015701;z=1001.992187;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CAR3",true)==0){
			s="You're safe up here";t="Wheels Arch Angels";u="CARMOD3 - on the roof";
		v=3;w=315;x=612.508605;y=-129.236114;z=1001.992187;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CAR4",true)==0){
			s="You're safe up here";t="Michelle's Garage";u="Spectre";
		v=0;w=0;x=-1786.603759;y=1215.553466;z=28.531250;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CAR5",true)==0){
			s="Go in the oil pits";t="CJ's Garage in SF";u="Spectre";
		v=1;w=0;x=-2048.605957;y=162.093444;z=28.835937;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		////////////////// CASINO ODDITIES /////////////////////////
		if(strcmp(cmd,"/CAS",true)==0){
			SendClientMessage(playerid,C,"=== CASINO ODDITIES ===");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/CAS1 - Caligula's locked basement");
			SendClientMessage(playerid,C,"/CAS2 - FDC Janitor's office");
			SendClientMessage(playerid,C,"/CAS3 - FDC Woozie's office (downstairs");
			SendClientMessage(playerid,C,"/CAS4 - FDC Woozie's office (upstairs)");
			SendClientMessage(playerid,C,"/CAS5 - Redsands West Casino");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"\n");
		SendClientMessage(playerid,C,"type /Menu to return to the full category list");return 1;}
		if(strcmp(cmd,"/CAS1",true)==0){
			s="Only open during one mission";t="Caligulas locked basement";u="Spectre";
		v=1;w=0;x=2170.284;y=1618.629;z=999.9766;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CAS2",true)==0){
			s="Small, ain't it? DON'T LEAVE THE ROOM!";t="Four Dragons Casino Janitor's office";u="FDJANITOR";
		v=10;w=270;x=1889.975;y=1018.055;z=31.88281;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CAS3",true)==0){
			s="Woozie's office - (teller area)";
			t="Woozie's Office in the FDC - TRY LEAVING THROUGH DOOR!";u="WUZIBET";
		v=1;w=90;x=-2158.719971;y=641.287964;z=1052.369995;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CAS4",true)==0){
			s="Woozie's office - wish he could see it!";
			t="Woozie's Office in the FDC";u="Spectre";
		v=1;w=270;x=-2169.846435;y=642.365905;z=1057.586059;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CAS5",true)==0){
			s="Don't remember seeing it playing the game!";
			t="Small Casino in Redsands West";u="CASINO2";
		v=12;w=0;x=1133.069946;y=-9.573059;z=1000.750000;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// CLOTHING STORES /////////////////////////
		if(strcmp(cmd,"/CLO",true)==0){
			SendClientMessage(playerid,C,"=== Clothing Stores ===");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/CLO1 - Binco");
			SendClientMessage(playerid,C,"/CLO2 - Didier Sachs");
			SendClientMessage(playerid,C,"/CLO3 - ProLaps");
			SendClientMessage(playerid,C,"/CLO4 - SubUrban");
			SendClientMessage(playerid,C,"/CLO5 - Victim");
			SendClientMessage(playerid,C,"/CLO6 - Zip");
			SendClientMessage(playerid,C,"\n");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/CLO1",true)==0){
			s="Clothing Store/CHeaP";t="Binco (cheap)";u="CSCHP";
		v=15;w=0;x=207.737991;y=-109.019997;z=1005.269958;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CLO2",true)==0){
			s="Clothing Store EXcLusive";t="Didier Sachs (exclusive)";u="CSEXL";
		v=14;w=0;x=204.332993;y=-166.694992;z=1000.578979;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CLO3",true)==0){
			s="Clothing Store/SPoRT";t="ProLaps (sport)";u="CSSPRT";
		v=3;w=0;x=207.054993;y=-138.804993;z=1003.519958;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CLO4",true)==0){
			s="Rockstar refers to Los Santos as Los Angeles a lot --- LA Clothing Store?";t="SubUrban";u="LACS1";
		v=1;w=0;x=203.778000;y=-48.492397;z=1001.799988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CLO5",true)==0){
			s="Clothing Store/DESiGNer";t="Victim (designer)";u="CSDESGN";
		v=5;w=90;x=226.293991;y=-7.431530;z=1002.259949; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CLO6",true)==0){
			s="Clothing Store like the GaP? General Purpose?";t="Zip (general purpose)";u="CLOTHGP";
		v=18;w=0;x=161.391006;y=-93.159156;z=1001.804687; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// BARS & CLUBS /////////////////////////
		if(strcmp(cmd,"/CLU",true)==0){
			SendClientMessage(playerid,C,"=== BARS & CLUBS ===");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/CLU1 - Dance Club template");
			SendClientMessage(playerid,C,"/CLU2 - Dance Club DJ room");
			SendClientMessage(playerid,C,"/CLU3 - 'Pool Table' Bar template");
			SendClientMessage(playerid,C,"/CLU4 - Lil' Probe Inn");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"\n");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/CLU1",true)==0){
			s="Alhambra, Gaydar Station, The 'Artwork' Club east of the Camel's Toe";t="Dance Club template";u="BAR1";
		v=17;w=0;x=493.390991;y=-22.722799;z=1000.686951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CLU2",true)==0){
			s="Alhambra, Gaydar Station, The 'Artwork' Club east of the Camel's Toe";t="Dance Club DJ room";u="Spectre";
		v=17;w=270;x=476.068328;y=-14.893922;z=1003.695312;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CLU3",true)==0){
			s="Misty's, the Craw Bar, 10 Green bottles";t="'Pool table' Bar template";u="BAR2";
		v=11;w=180;x=501.980988;y=-69.150200;z=998.834961;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/CLU4",true)==0){
			s="based on the real life Little A'le'Inn near Area 51";t="Lil' Probe Inn";u="UFOBAR";
		v=18;w=315;x=-227.028000;y=1401.229980;z=27.769798;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// EATERIES /////////////////////////
		if(strcmp(cmd,"/EAT",true)==0){
			SendClientMessage(playerid,C,"=== Diners & Restaurants ===");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/EAT1 - Jay's Diner");
			SendClientMessage(playerid,C,"/EAT2 - Diner near Gant Bridge");
			SendClientMessage(playerid,C,"/EAT3 - Secret Valley Diner (no solid surfaces)");
			SendClientMessage(playerid,C,"/EAT4 - World of Coq");
			SendClientMessage(playerid,C,"/EAT5 - Welcome Pump Truck Stop Diner*");
			SendClientMessage(playerid,C,"* complete but unused in game - DON'T GO OUT DOOR!");
			SendClientMessage(playerid,C,"\n");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/EAT1",true)==0){
			s="I don't remember this being used";t="Jay's Diner";u="DINER1";
		v=4;w=90;x=460.099976;y=-88.428497;z=999.621948; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/EAT2",true)==0){
			s="Only booth seats are solid!";t="Unnamed Diner (near Gant Bridge)";u="DINER2";
		v=5;w=90;x=454.973950;y=-110.104996;z=999.717957; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/EAT3",true)==0){
			s="View from Jay's Diner thanx to -[HTB]-Kfgus3";t="Secret Valley Diner (No solid surfaces)";u="REST2";
		v=6;w=337;x=435.271331;y=-80.958938;z=999.554687;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/EAT4",true)==0){
			s="FooD RESTaurant - DON'T FALL OFF!";t="World of Coq";u="FDREST1";
		v=1;w=45;x=452.489990;y=-18.179699;z=1001.179993; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/EAT5",true)==0){
			s="Complete but unused in game";t="Welcome Pump Truck Stop Diner";u="TSDINER";
		v=1;w=180;x=681.474976;y=-451.150970;z=-25.616798; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// FAST FOOD /////////////////////////
		if(strcmp(cmd,"/FST",true)==0){
			SendClientMessage(playerid,C,"=== Fast Food ===");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/FST1 - Burger Shot");
			SendClientMessage(playerid,C,"/FST2 - Cluckin' Bell");
			SendClientMessage(playerid,C,"/FST3 - Well Stacked Pizza");
			SendClientMessage(playerid,C,"/FST4 - Rusty Brown's Donuts*");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"* complete but unused in game");
			SendClientMessage(playerid,C,"\n");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/FST1",true)==0){
			s="FooD/BURGers";t="Burger Shot";u="FDBURG";
		v=10;w=315;x=366.923980;y=-72.929359;z=1001.507812; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/FST2",true)==0){
			s="FooD CHICKen";t="Cluckin' Bell";u="FDCHICK";
		v=9;w=315;x=365.672974;y=-10.713200;z=1001.869995; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/FST3",true)==0){
			s="FooD PIZzA";t="Well Stacked Pizza";u="FDPIZA";
		v=5;w=0;x=372.351990;y=-131.650986;z=1001.449951; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/FST4",true)==0){
			s="FooD/DONUTs - complete but unused in game";
			t="Rusty Brown's Donuts";u="FDDONUT";v=17;w=0;x=377.098999;y=-192.439987;z=1000.643982;
		showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// GIRLFRIENDS /////////////////////////
		if(strcmp(cmd,"/GRL",true)==0){
			SendClientMessage(playerid,C,"=== Girlfriend Bedrooms ===");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/GRL1 - Denise Robinson (Home Girl/Violent tendencies)");
			SendClientMessage(playerid,C,"/GRL2 - Katie Zhan (Nurse/Neurotic)");
			SendClientMessage(playerid,C,"/GRL3 - Helena Wankstein (Lawyer/Gun Nut)");
			SendClientMessage(playerid,C,"/GRL4 - Michelle Cannes (Mechanic/Speed Freak)");
			SendClientMessage(playerid,C,"/GRL5 - Barbara Schternvart (Cop/Control Freak)");
			SendClientMessage(playerid,C,"/GRL6 - Millie Perkins (Croupier/Sex Fiend)");
			SendClientMessage(playerid,C,"   --- THERE ARE NO EXITS FROM THESE ROOMS! ---");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/GRL1",true)==0){
			s="Rewards: Pimp suit & Green Hustler";t="Denise's Bedroom";u="GF1";
		v=1;w=235;x=244.411987;y=305.032990;z=999.231995;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/GRL2",true)==0){
			s="Rewards: Medic outfit & White Romero";t="Katie's Bedroom";u="GF2";
		v=2;w=90;x=271.884979;y=306.631989;z=999.325989;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/GRL3",true)==0){
			s="Rewards: Coveralls & Bandito";t="Helena's Bedroom (barn) - limited movement";
		u="GF3";v=3;w=90;x=291.282990;y=310.031982;z=999.154968;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/GRL4",true)==0){
			s="Rewards: Racing outfit & Monster Truck";t="Michelle's Bedroom";u="GF4";
		v=4;w=0;x=302.181000;y=300.722992;z=999.231995;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/GRL5",true)==0){
			s="Rewards: Police uniform & Ranger";t="Barbara's Bedroom";u="GF5";
		v=5;w=0;x=322.197998;y=302.497986;z=999.231995;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/GRL6",true)==0){
			s="Rewards: Gimp suit & Pink Club";t="Millie's Bedroom";u="GF6";
		v=6;w=180;x=346.870025;y=309.259033;z=999.155700;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// GOVERNMENT /////////////////////////
		if(strcmp(cmd,"/GOV",true)==0){
			SendClientMessage(playerid,C,"=== GOVERNMENT BUILDINGS ===");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/GOV1 - Sherman Dam");
			SendClientMessage(playerid,C,"/GOV2 - Planning Department");
			SendClientMessage(playerid,C,"/GOV3 - Area 69 - Upper level entrance");
			SendClientMessage(playerid,C,"/GOV4 - Area 69 - Middle level - Map room");
			SendClientMessage(playerid,C,"/GOV5 - Area 69 - Lowest level - Jetpack room");
			SendClientMessage(playerid,C,"/GOV6 - Area 69 - Secret Vent entrance");
			SendClientMessage(playerid,C,"\n");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/GOV1",true)==0){
			s="sherman DAM INside";t="Sherman Dam";u="DAMIN";
		v=17;w=180;x=-959.873962;y=1952.000000;z=9.044310;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/GOV2",true)==0){
			s="This place is HUGE!  Make your own spawn points!";t="Planning Department";u="PAPER";
		v=3;w=90;x=388.871979;y=173.804993;z=1008.389954;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/GOV3",true)==0){
			s="Wasn't this easy during the game...";t="AREA 69 entrance";u="Spectre";
		v=0;w=90;x=220.4109;y=1862.277;z=13.147;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/GOV4",true)==0){
			s="Great spawn screen possibilities!";t="AREA 69 Map room";u="Spectre";
		v=0;w=90;x=226.853637;y=1822.760498;z=7.414062;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/GOV5",true)==0){
			s="Lowest point in game not underwater?";t="AREA 69 Jetpack room";u="Spectre";
		v=0;w=180;x=268.725585;y=1883.816406;z=-30.093750;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/GOV6",true)==0){
			s="Now what are you gonna do?";t="AREA 69 Vent entrance";u="Spectre";
		v=0;w=120;x=245.696197;y=1862.490844;z=18.070953;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// GYMS /////////////////////////
		if(strcmp(cmd,"/GYM",true)==0){
			SendClientMessage(playerid,C,"=== GYMS ===");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/GYM1 - Ganton, LS");
			SendClientMessage(playerid,C,"/GYM2 - Cobra Gym in Garcia, SF");
			SendClientMessage(playerid,C,"/GYM3 - Below the Belt Gym in Redsands East, LV");
			SendClientMessage(playerid,C,"/GYM4 - Verona Beach Gym in LS*");
			SendClientMessage(playerid,C,"/GYM5 - Madd Dogg's in Mulholland, LS*");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"* I threw these in because they ARE Gyms, Interior or not");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/GYM1",true)==0){
			s="Instrumental in initially reaching the Interiors";t="Ganton Gym in Ganton, LS";u="GYM1";
		v=5;w=0;x=772.112000;y=-3.898650;z=1000.687988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/GYM2",true)==0){
			s="Sign outside misspells MarTIal as MarITal";t="Cobra Gym in Garcia, SF";u="GYM2";
		v=6;w=0;x=774.213989;y=-48.924297;z=1000.687988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/GYM3",true)==0){
			s="The graffiti to your left is backwards";t="Below The Belt Gym in Redsands East, LV";u="GYM3";
		v=7;w=0;x=773.579956;y=-77.096695;z=1000.687988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/GYM4",true)==0){
			s="I know it's not an Interior but it IS a Gym";t="Verona Beach Gym";u="Spectre";
		v=0;w=90;x=668.393188;y=-1867.325439;z=5.453720;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/GYM5",true)==0){
			s="Mentioned for continuity purposes only";t="Madd Dogg's Gym in Mulholland, LS";u="Spectre";
		v=5;w=0;x=1234.144409;y=-764.087158;z=1084.007202; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// HOMIES ////////////////////////
		if(strcmp(cmd,"/HOM",true)==0){
			SendClientMessage(playerid,C,"=== HOME BOYS ===");
			SendClientMessage(playerid,C,"/HOM1 & /HOM2 - B Dup's Apt. & Crack pad");
			SendClientMessage(playerid,C,"/HOM3 - Carl's Mom's House");
			SendClientMessage(playerid,C,"/HOM4 thru /HOM6 - Madd Dogg's Mansion");
			SendClientMessage(playerid,C,"/HOM7 - OG Loc's");
			SendClientMessage(playerid,C,"/HOM8 - Ryder's House");
			SendClientMessage(playerid,C,"/HOM9 - Sweet's House");
			SendClientMessage(playerid,C,"/HOM10 thru /HOM17 - Big Smoke's Palace*");
			SendClientMessage(playerid,C,"* The Crack Factory from the ground floor up");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/HOM1",true)==0){
			s="ONLY THE FLOOR IS SOLID!";t="B Dup's Apartment";u="BDUPS";
		v=3;w=0;x=1527.229980;y=-11.574499;z=1002.269958;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/HOM2",true)==0){
			s="ONLY THE FLOOR IS SOLID!";t="B Dup's Crack Pad";u="BDUPS1";
		v=2;w=0;x=1523.509888;y=-47.821198;z=1002.269958;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/HOM3",true)==0){
			s="There's no place like home";t="CJ's Mom's House in Ganton, LS";u="CARLS";
		v=3;w=180;x=2496.049805;y=-1693.929932;z=1014.750000; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/HOM4",true)==0){
			s="Upper (West) Entrance";t="Madd Dogg's Mansion (West door)";u="MADDOGS";
		v=5;w=0;x=1263.079956;y=-785.308960;z=1091.959961;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/HOM5",true)==0){
			s="Lower (East) Entrance";t="Madd Dogg's Mansion (East door)";u="MDDOGS";
		v=5;w=0;x=1299.079956;y=-795.226990;z=1084.029907;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/HOM6",true)==0){
			s="Helipad";t="Madd Dogg's Mansion Helipad";u="Spectre";
		v=0;w=90;x=1291.725341;y=-788.319885;z=96.460937;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/HOM7",true)==0){
			s="ONLY FLOOR IS SOLID! (Check front door)";t="OG Loc's House";u="OGLOCS";
		v=3;w=0;x=516.650;y=-18.611898;z=1001.459961;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/HOM8",true)==0){
			s="Funky lighting in the kitchen";t="Ryder's house";u="RYDERS";
		v=2;w=90;x=2464.109863;y=-1698.659912;z=1013.509949;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/HOM9",true)==0){
			s="DON'T GO ON SOUTH SIDE OF HOUSE!";t="Sweet's House";u="SWEETS";
		v=1;w=270;x=2526.459961;y=-1679.089966;z=1015.500000;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/HOM10",true)==0){
			s="Ground floor";t="Big Smoke's Crack Factory";u="Spectre";
		v=2;w=180;x=2543.659912;y=-1303.629883;z=1025.069946;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/HOM11",true)==0){
			s="Warehouse floor";t="Big Smoke's Crack Factory";u="Spectre";
		v=2;w=270;x=2530.980468;y=-1294.163085;z=1031.421875;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/HOM12",true)==0){
			s="Warehouse office";t="Big Smoke's Crack Factory";u="Spectre";
		v=2;w=180;x=2569.185058;y=-1281.929809;z=1037.773437;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/HOM13",true)==0){
			s="Factory floor";t="Big Smoke's Crack Factory";u="Spectre";
		v=2;w=90;x=2564.201171;y=-1297.117797;z=1044.125000;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/HOM14",true)==0){
			s="Factory office";t="Big Smoke's Crack Factory";u="Spectre";
		v=2;w=180;x=2526.605468;y=-1281.239259;z=1048.289062;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/HOM15",true)==0){
			s="Waiting Room";t="Big Smoke's Crack Factory";u="Spectre";
		v=2;w=180;x=2535.017822;y=-1281.242553;z=1054.640625;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/HOM16",true)==0){
			s="Statue Hallway (Check out side rooms)";t="Big Smoke's Crack Factory";u="Spectre";
		v=2;w=0;x=2547.268310;y=-1295.931762;z=1054.640625;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/HOM17",true)==0){
			s="Outside the Living Area (Check the doormat!)";t="Big Smoke's Crack Factory";u="Spectre";
		v=2;w=90;x=2580.114501;y=-1300.392944;z=1060.992187;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// PLACES OF ILL REPUTE /////////////////////////
		if(strcmp(cmd,"/ILL",true)==0)	{
			SendClientMessage(playerid,C,"=== PLACES OF ILL REPUTE ===");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/ILL1 - Big Spread Ranch");
			SendClientMessage(playerid,C,"/ILL2 - Fanny Batter's Whore House");
			SendClientMessage(playerid,C,"/ILL3 & /ILL4- World Class Topless Girls Strip Club & Private room");
			SendClientMessage(playerid,C,"/ILL5 - Unnamed Brothel");
			SendClientMessage(playerid,C,"/ILL6 - 'Tiger Skin Rug' Brothel");
			SendClientMessage(playerid,C,"/ILL7 & /ILL8 - Jizzy's Pleasure Domes");
			SendClientMessage(playerid,C,"\n");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/ILL1",true)==0){
			s="NONE";t="Big Spread Ranch Strip Club";u="STRIP2";
		v=3;w=180;x=1212.019897;y=-28.663099;z=1001.089966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/ILL2",true)==0){
			s="Check out the artwork";t="Fanny Batter's Whore House*";u="BROTHEL";
		v=6;w=290;x=744.542969;y=1437.669922;z=1102.739990;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/ILL3",true)==0){
			s="This is also the Pig Pen Interior";t="World Class Topless Girls Strip Club in Old Venturas Strip, LV";u="LASTRIP";
		v=2;w=0;x=1204.809937;y=-11.586800;z=1001.089966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/ILL4",true)==0){
			s="ONLY THE FLOOR IS SOLID!";
			t="World Class Topless Girls Strip Club Private Dance Room";u="Spectre";
		v=2;w=0;x=1204.809937;y=13.586800;z=1001.089966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/ILL5",true)==0){
			s="Furniture not solid";t="Unnamed Brothel";u="BROTHL1";
		v=3;w=0;x=940.921997;y=-17.007000;z=1001.179993;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/ILL6",true)==0){
			s="VERY Elaborate and NO, you can't ride the horsey!";
			t="Tiger Skin Rug Brothel";u="BROTHL2";
		v=3;w=90;x=964.106995;y=-53.205498;z=1001.179993;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/ILL7",true)==0){
			s="Pleasure DOMES (roof scaffolding)";t="Jizzy's Pleasure Domes";u="PDOMES";
		v=3;w=180;x=-2661.009766;y=1415.739990;z=923.305969;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/ILL8",true)==0){
			s="Pleasure DOMES (front entrance)";t="Jizzy's Pleasure Domes";u="PDOMES2";
		v=3;w=90;x=-2637.449951;y=1404.629883;z=906.457947;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// LIBERTY CITY /////////////////////////
		if(strcmp(cmd,"/LIB",true)==0){
			SendClientMessage(playerid,C,"=== Liberty City ===");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/LIB1 - Marco's Bistro (from the street)");
			SendClientMessage(playerid,C,"/LIB2 - Marco's Bistro Front Patio");
			SendClientMessage(playerid,C,"/LIB3 - Marco's Bistro Inside/Upstairs");
			SendClientMessage(playerid,C,"/LIB4 - Marco's Bistro Back yard");
			SendClientMessage(playerid,C,"/LIB5 - Marco's Bistro Roof (Photo Op)");
			SendClientMessage(playerid,C,"/LIB6 - Marco's Bistro Kitchen");
			SendClientMessage(playerid,C,"There's not much up here but everybody wants to get here!");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/LIB1",true)==0){
			s="Positioning is mine";t="Marco's Bistro (from the street)";u="Spectre";
		v=1;w=40;x=-735.5619504;y=484.351318;z=1371.952270;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/LIB2",true)==0){
			s="Positioning is mine";t="Marco's Bistro Front Patio";u="Spectre";
		v=1;w=90;x=-777.7556764;y=500.178070;z=1376.600463;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/LIB3",true)==0){
			s="Positioning is mine";t="Marco's Bistro Inside/Upstairs";u="Spectre";
		v=1;w=0;x=-794.8064;y=491.6866;z=1376.195;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/LIB4",true)==0){
			s="Positioning is mine";t="Marco's Bistro Back Yard";u="Spectre";
		v=1;w=0;x=-835.2504;y=500.9161;z=1358.305;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/LIB5",true)==0){
			s="Positioning is mine (good photo op)";t="Marco's Bistro Rooftop";u="Spectre";
		v=1;w=90;x=-813.431518;y=533.231079;z=1390.782958;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/LIB6",true)==0){
			s="Positioning is mine";t="Marco's Bistro Kitchen";u="Spectre";
		v=1;w=180;x=-789.432800;y=509.146972;z=1367.374511;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// MISCELLANEOUS /////////////////////////
		if(strcmp(cmd,"/MSC",true)==0){
			SendClientMessage(playerid,C,"=== MISCELLANEOUS STUFF === ");
			SendClientMessage(playerid,C,"/MSC1 - Burning Desire Gang House");
			SendClientMessage(playerid,C,"/MSC2 - Colonel Furburgher's House");
			SendClientMessage(playerid,C,"/MSC3 - Crack Den");
			SendClientMessage(playerid,C,"/MSC4 & /MSC5 -  2 Warehouses (4-empty/5-pillars)");
			SendClientMessage(playerid,C,"/MSC6 - Sweet's Garage");
			SendClientMessage(playerid,C,"/MSC7 - Lil' Probe Inn bathroom");
			SendClientMessage(playerid,C,"/MSC8 - Unused Safe House");
			SendClientMessage(playerid,C,"/MSC9 & /MSC10 - RC Battlefield(roof & inside)");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/MSC1",true)==0){
			s="Where you 1st meet Denise";t="Burning Desire Gang House";u="GANG";
		v=5;w=90;x=2350.339844;y=-1181.649902;z=1028.000000; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/MSC2",true)==0){
			s="Built a lot like CJ's house";t="Colonel Furhberger's";u="BURHOUS";
		v=8;w=0;x=2807.619873;y=-1171.899902;z=1025.579956;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/MSC3",true)==0){
			s="Notorious for the back room couch bj";t="Crack House";u="LACRAK";
		v=5;w=0;x=318.564972;y=1118.209961;z=1083.979980; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/MSC4",true)==0){
			s="Big & empty with no roof";t="Warehouse";u="SMASHTV";
		v=1;w=135;x=1412.639893;y=-1.787510;z=1000.931946;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/MSC5",true)==0){
			s="GENeric WaReHouSe - Lots of pillars";t="Warehouse";u="GENWRHS";
		v=18;w=135;x=1302.519897;y=-1.787510;z=1000.931946;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/MSC6",true)==0){
			s="Would make a good jail cell";t="Inside Sweet's Garage";u="Spectre";
		v=0;w=90;x=2522.0;y=-1673.383911;z=14.8;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/MSC7",true)==0){
			s="Would make a good jail cell";t="Lil' Probe Inn bathroom";u="Spectre";
		v=18;w=90;x=-219.322601;y=1410.444824;z=27.773437;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/MSC8",true)==0){
			s="Pretty nice place...BUT NO BATHROOM!",t="Unused Safe House";u="SVLABIG";
		v=12;w=0;x=2324.419922;y=-1147.539917;z=1050.719971;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/MSC9",true)==0){
			s="On the roof";t="RC Battlefield (on the roof)";u="Spectre";
		v=10;w=90;x=-972.4957;y=1060.983;z=1358.914;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/MSC10",true)==0){
			s="On the Battlefield";t="RC Battlefield (on the field)";u="Spectre";
		v=10;w=90;x=-972.4957;y=1060.983;z=1345.669;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// PERSONAL GROOMING /////////////////////////
		if(strcmp(cmd,"/PER",true)==0){
			SendClientMessage(playerid,C,"=== Barber Shops & Tattoo Parlors ===");
			SendClientMessage(playerid,C,"/PER1 - Old Reece's Hair Facial Studio in Idlewood, LS");
			SendClientMessage(playerid,C,"/PER2 - Gay Gordo's Barber Shop in Dillimore, the");
			SendClientMessage(playerid,C,"               Barber's Pole in Queens, SF and");
			SendClientMessage(playerid,C,"               Gay Gordo's Boufon Boutique in Redsands East, LV");
			SendClientMessage(playerid,C,"/PER3 - Macisla's Unisex Hair Salon in Playa Del Seville, LS");
			SendClientMessage(playerid,C,"/PER4 - Unnamed Tattoo Parlor in Idlewood, LS");
			SendClientMessage(playerid,C,"/PER5 - Hemlock Tattoo parlor in Hashbury, SF");
			SendClientMessage(playerid,C,"/PER6 - Unnamed Tattoo parlor in Redsands East, LV");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/PER1",true)==0){
			s="Check out the Jackson 5 pix on the wall!";
			t="Old Reece's Hair Facial Studio in Idlewood,LS";u="BARBERS";
		v=2;w=315;x=411.625977;y=-21.433298;z=1001.799988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/PER2",true)==0){
			s="Gay Gordo's got a shop in 'Queens'? Go figure.";
			t="Gay Gordo's Barber Shop in Dillimore, The Barber's Pole in Queens and Gay Gordo's Boufon Boutique in Redsands East";
		u="BARBER2";v=3;w=0;x=418.652985;y=-82.639793;z=1001.959961;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/PER3",true)==0){
			s="The writing on the windows isn't visible from the outside!";
			t="Macisla's Unisex Hair Salon";u="BARBER3";
		v=12;w=270;x=412.021973;y=-52.649899;z=1001.959961;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/PER4",true)==0){
			s="NONE";t="Unnamed Tattoo Parlor Idlewood & Willowfield";u="TATTOO";
		v=16;w=315;x=-204.439987;y=-26.453999;z=1002.299988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/PER5",true)==0){
			s="TATTOo Parlor on Island 2";t="Hemlock Tattoo parlor in Hashbury, SF";u="TATTO2";
		v=17;w=315;x=-204.439987;y=-8.469600;z=1002.299988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/PER6",true)==0){
			s="TATTOo Parlor on Island 3";t="Unnamed Tattoo parlor in Redsands East, LV";u="TATTO3";
		v=3;w=315;x=-204.439987;y=-43.652496;z=1002.299988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// POLICE DEPARTMENTS /////////////////////////
		if(strcmp(cmd,"/POL",true)==0){
			SendClientMessage(playerid,C,"=== POLICE DEPARTMENTS ===");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/POL1 - Los Santos");
			SendClientMessage(playerid,C,"/POL2 - San Fierro");
			SendClientMessage(playerid,C,"/POL3 - Las Venturas (upper entrance)");
			SendClientMessage(playerid,C,"/POL4 - Las Venturas (street entrance)");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"\n");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/POL1",true)==0){
			s="NONE";t="Los Santos PD";u="POLICE1";
		v=6;w=0;x=246.783997;y=63.900200;z=1003.639954; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/POL2",true)==0){
			s="NONE";t="San Fierro PD";u="POLICE2";
		v=10;w=0;x=246.375992;y=109.245995;z=1003.279968; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/POL3",true)==0){
			s="NONE";t="Las Venturas PD (upper entrance)";u="POLICE3";
		v=3;w=0;x=288.745972;y=169.350998;z=1007.179993; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/POL4",true)==0){
			s="NONE";t="Las Venturas PD (street entrance)";u="POLICE4";
		v=3;w=0;x=238.661987;y=141.051987;z=1003.049988; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// SCHOOLS /////////////////////////
		if(strcmp(cmd,"/SCH",true)==0){
			SendClientMessage(playerid,C,"=== SCHOOLS ===");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/SCH1 - Cycle School");
			SendClientMessage(playerid,C,"/SCH2 - Automobile School");
			SendClientMessage(playerid,C,"/SCH3 - Plane School");
			SendClientMessage(playerid,C,"/SCH4 - Boat School*");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"* added for continuity purposes");
			SendClientMessage(playerid,C,"\n");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/SCH1",true)==0){
			s="BIKe SCHool";t="Bike School";u="BIKESCH";
		v=3;w=90;x=1494.429932;y=1305.629883;z=1093.289917;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/SCH2",true)==0){
			s="DRIVE School";t="Driving School";u="DRIVES";
		v=3;w=90;x=-2029.719971;y=-115.067993;z=1035.169922;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/SCH3",true)==0){
			s="DESerted HOUSe? DESert HOUSE?";t="Abandoned AC tower";u="DESHOUS";
		v=10;w=45;x=420.484985;y=2535.589844;z=10.020289;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/SCH4",true)==0){
			s="Mentioned for continuity purposes only";t="Boat School";u="Spectre";
		v=0;w=45;x=-2184.751464;y=2413.111816;z=5.156250;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///////////////////////// STADIUMS /////////////////////////
		if(strcmp(cmd,"/STA",true)==0){
			SendClientMessage(playerid,C,"=== STADIUMS ===");
			SendClientMessage(playerid,C,"/STA1 - 8Track");
			SendClientMessage(playerid,C,"/STA2 & /STA3 - Bloodbowl - lowel/upper levels");
			SendClientMessage(playerid,C,"/STA4 - DirtBike");
			SendClientMessage(playerid,C,"/STA5 - Kickstart");
			SendClientMessage(playerid,C,"/STA6 - Vice Street Racers");
			SendClientMessage(playerid,C,"/STA7 - Bandits Baseball Field");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"(all the coordinates are of my choosing)");
		SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
		if(strcmp(cmd,"/STA1",true)==0){
			s="Um, 'cause it's shaped like an eight?";t="8-Track Stadium";u="8TRACK";
		v=7;w=90;x=-1397.782470;y=-203.723114;z=1051.346801;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/STA2",true)==0){
			s="On the garage roof";t="Bloodbowl Stadium (in the bowl)";u="Spectre";
		v=15;w=0;x=-1398.103515;y=933.445434;z=1041.531250;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/STA3",true)==0){
			s="Lighting is strange";t="Bloodbowl Stadium (upper loop)";u="Spectre";
		v=15;w=315;x=-1396.110351;y=903.513671;z=1041.525390;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/STA4",true)==0){
			s="DIRt BIKE";t="Dirtbike Stadium";u="DIRBIKE";
		v=4;w=45;x=-1428.809448;y=-663.595886;z=1060.219848;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/STA5",true)==0){
			s="This is just TOO cool!";t="Kickstart Stadium";u="Spectre";
		v=14;w=225;x=-1486.861816;y=1642.145996;z=1060.671875;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/STA6",true)==0){
			s="Only center area is solid";t="Vice Stadium";u="Spectre";
		v=1;w=90;x=-1401.830000;y=107.051300;z=1032.273000;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
		if(strcmp(cmd,"/STA7",true)==0){
			s="Included for continuity purposes";t="Bandits Baseball field";u="Spectre";
		v=0;w=135;x=1382.615600;y=2184.345703;z=11.023437;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

		///// ///// ///// ///// ///// ///// ///// FUNCTIONAL OPTIONS ///// ///// ///// ///// ///// /////



		if(strcmp(cmd,"/MENU",true)==0){
			SendClientMessage(playerid,C," --- Main Menu  --- to see the submenus type /code (ex: /MENU1)");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/MENU1 - 24/7s thru Car Mod shops");
			SendClientMessage(playerid,C,"/MENU2 - Casino Oddities thru Girlfriends");
			SendClientMessage(playerid,C,"/MENU3 - Government thru Miscellaneous");
			SendClientMessage(playerid,C,"/MENU4 - Personal Grooming thru Stadiums");
			SendClientMessage(playerid,C,"/MENU5 - other");
			SendClientMessage(playerid,C,"/MENU6 - other");
		SendClientMessage(playerid,C,"type /MENU to return to this screen...");return 1;}

		if(strcmp(cmd,"/MENU1",true)==0){
			SendClientMessage(playerid,C," --- Menu 1 --- to see the submenus type /code (ex: /AIR)");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/247 - 24/7s (6)");
			SendClientMessage(playerid,C,"/AIR - All things aerodynamic (4)");
			SendClientMessage(playerid,C,"/AMU - Ammunations (6)");
			SendClientMessage(playerid,C,"/X - Burglary Houses (23)");
			SendClientMessage(playerid,C,"/BUS - Businesses (8)");
			SendClientMessage(playerid,C,"/CAR - Car Mod shops (5) (DANGER!...CRASH HAZARD!)");
			SendClientMessage(playerid,C,"\n");
		SendClientMessage(playerid,C,"type /MENU1 to return to this screen...");return 1;}

		if(strcmp(cmd,"/MENU2",true)==0){
			SendClientMessage(playerid,C," --- Menu 2 --- to see the submenus type /code (ex: /CAS)");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/CAS - Casino oddities (5)");
			SendClientMessage(playerid,C,"/CLO - Clothing shops (6)");
			SendClientMessage(playerid,C,"/CLU - Bars & Clubs (4)");
			SendClientMessage(playerid,C,"/EAT - Diners & Eateries (5)");
			SendClientMessage(playerid,C,"/FST - Fast Food joints (4)");
			SendClientMessage(playerid,C,"/GRL - Girlfriend Bedrooms (6)");
			SendClientMessage(playerid,C,"\n");
		SendClientMessage(playerid,C,"type /MENU2 to return to this screen...");return 1;}

		if(strcmp(cmd,"/MENU3",true)==0){
			SendClientMessage(playerid,C," --- Menu 3 --- to see the submenus type /code (ex: /GOV)");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/GOV - Government related businesses (6)");
			SendClientMessage(playerid,C,"/GYM - Gyms (5)");
			SendClientMessage(playerid,C,"/HOM - Homies (17)");
			SendClientMessage(playerid,C,"/ILL - Places of Ill Repute (8)");
			SendClientMessage(playerid,C,"/LIB - Liberty City (6) (pretty boring actually)");
			SendClientMessage(playerid,C,"/MSC - Miscellaneous stuff (8)");
			SendClientMessage(playerid,C,"\n");
		SendClientMessage(playerid,C,"type /MENU3 to return to this screen...");return 1;}

		if(strcmp(cmd,"/MENU4",true)==0){
			SendClientMessage(playerid,C," --- Menu 4 --- to see the submenus type /code (ex: /PER)");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"/PER - Personal Grooming (6) (Barbershops & Tattoo parlors)");
			SendClientMessage(playerid,C,"/POL - Police Departments (4)");
			SendClientMessage(playerid,C,"/SCH - Vehicle Schools (4)");
			SendClientMessage(playerid,C,"/STA - Stadiums (8)");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"\n");
			SendClientMessage(playerid,C,"\n");
		SendClientMessage(playerid,C,"type /MENU4 to return to this screen...");return 1;}
		if(strcmp(cmd, "/menu5", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Menu 5 (1st list of interior catagories)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/aira - for all things aerodynamic (6)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/stra - strip club interiors (3)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gara - garage interiors (3)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Type /menu6 to see the 2nd list of catagories");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

		if(strcmp(cmd, "/menu6", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Menu 6 (2nd list of interior catagories)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/wara - warehouse interiors (3)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/casa - casino oddities (3)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/busa - businesses (6)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gova - government run organizations (6)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Type /menu5 to go to the 1st list of catagories");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

		if(strcmp(cmd, "/aira", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Aerodynamic Interiors");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/aira1 - LS Int Airport (baggage reclaim)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/aira2 - Verdant Meadow AC Tower");
		    SendClientMessage(playerid, COLOR_YELLOW, "/aira3 - LS Customs Cabin");
		    SendClientMessage(playerid, COLOR_YELLOW, "/aira4 - SF Customs Cabin (main gates)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/aira5 - SF Customs Cabin (rear gates)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/aira6 - LV Customs Cabin");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

		if(strcmp(cmd, "/aira1", true)==0)
		{
			SetPlayerInterior(playerid, 14);
			SetPlayerFacingAngle(playerid, 125);
			SetPlayerPos(playerid, -1856.061401,59.451751,1056.354492);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: -1856.061401");
			SendClientMessage(playerid, COLOR_WHITE, "Y: 59.451751");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 1056.354492");
			SendClientMessage(playerid, COLOR_WHITE, "A: 125");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 14");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Los Santos International Airport (baggage reclaim)");
			SendClientMessage(playerid, COLOR_RED, "DO NOT MOVE, ROOM ISN'T SOLID!");
			return 1;
		}

		if(strcmp(cmd, "/aira2", true)==0)
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerFacingAngle(playerid, 180);
			SetPlayerPos(playerid, 412.940093,2543.499267,26.582641);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 412.940093");
			SendClientMessage(playerid, COLOR_WHITE, "Y: 2543.499267");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 26.582641");
			SendClientMessage(playerid, COLOR_WHITE, "A: 180");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Verdant Meadow Abandoned AC Tower");
			SendClientMessage(playerid, COLOR_YELLOW, "Nice view =)");
			return 1;
		}


		if(strcmp(cmd, "/aira3", true)==0)
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerFacingAngle(playerid, 270);
			SetPlayerPos(playerid, 1955.634033,-2181.589355,13.586477);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1955.634033");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -2181.589355");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 13.586477");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 270");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Los Santos Customs Cabin");
		    SendClientMessage(playerid, COLOR_YELLOW, "It's empty, no furniture =O");
		    return 1;
		}


		if(strcmp(cmd, "/aira4", true)==0)
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerFacingAngle(playerid, 45);
			SetPlayerPos(playerid, -1544.394897,-443.713562,6.100000);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: -1544.394897");
			SendClientMessage(playerid, COLOR_WHITE, "Y: -443.713562");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 6.100000");
			SendClientMessage(playerid, COLOR_WHITE, "A: 45");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "San Fiero Customs Cabin (main gates)");
			SendClientMessage(playerid, COLOR_YELLOW, "Furniture isn't solid");
			return 1;
		}

		if(strcmp(cmd, "/aira5", true)==0)
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerFacingAngle(playerid, 320);
			SetPlayerPos(playerid, -1229.471191,55.351161,14.232812);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: -1229.471191");
			SendClientMessage(playerid, COLOR_WHITE, "Y: 55.351161");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 14.232812");
			SendClientMessage(playerid, COLOR_WHITE, "A: 320");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "San Fiero Customs Cabin (rear gates)");
			SendClientMessage(playerid, COLOR_YELLOW, "Furniture isn't solid");
			return 1;
		}

		if(strcmp(cmd, "/aira6", true)==0)
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerFacingAngle(playerid, 160);
			SetPlayerPos(playerid, 1717.427612,1617.371337,10.117187);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 1717.427612");
			SendClientMessage(playerid, COLOR_WHITE, "Y: 1617.371337");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 10.117187");
			SendClientMessage(playerid, COLOR_WHITE, "A: 160");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Las Venturas Customs Cabin");
			SendClientMessage(playerid, COLOR_YELLOW, "All complete (would be good for roleplay)");
			return 1;
		}

		if(strcmp(cmd, "/stra", true) == 0)
		{
			SendClientMessage(playerid, COLOR_YELLOW, " ");
			SendClientMessage(playerid, COLOR_YELLOW, " ");
			SendClientMessage(playerid, COLOR_YELLOW, " ");
			SendClientMessage(playerid, COLOR_YELLOW, "Strip Club Interiors");
			SendClientMessage(playerid, COLOR_YELLOW, " ");
			SendClientMessage(playerid, COLOR_YELLOW, "/stra1 - Big Spread Ranch");
			SendClientMessage(playerid, COLOR_YELLOW, "/stra2 - Big Spread Ranch (private dance room)");
			SendClientMessage(playerid, COLOR_YELLOW, "/stra3 - Big Spread Ranch (behind bar)");
			SendClientMessage(playerid, COLOR_YELLOW, " ");
			SendClientMessage(playerid, COLOR_YELLOW, " ");
			SendClientMessage(playerid, COLOR_YELLOW, " ");
			return 1;
		}

		if(strcmp(cmd, "/stra1", true)==0)
		{
			SetPlayerInterior(playerid, 3);
			SetPlayerFacingAngle(playerid, 90);
			SetPlayerPos(playerid, 1215.219726,-30.991367,1000.960571);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 1215.219726");
			SendClientMessage(playerid, COLOR_WHITE, "Y: -30.991367");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 1000.960571");
			SendClientMessage(playerid, COLOR_WHITE, "A: 90");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 3");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Big Spread Ranch");
			SendClientMessage(playerid, COLOR_YELLOW, "Also same interior as 'Nude Strippers Daily'");
			return 1;
		}

		if(strcmp(cmd, "/stra2", true)==0)
		{
			SetPlayerInterior(playerid, 3);
			SetPlayerFacingAngle(playerid, 180);
			SetPlayerPos(playerid, 1207.651123,-42.554019,1000.953125);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 1207.651123");
			SendClientMessage(playerid, COLOR_WHITE, "Y: -42.554019");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 1000.953125");
			SendClientMessage(playerid, COLOR_WHITE, "A: 180");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 3");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Big Spread Ranch (private dance room)");
			SendClientMessage(playerid, COLOR_RED, "ONLY THE FLOOR IS SOLID!");
			return 1;
		}

		if(strcmp(cmd, "/stra3", true)==0)
		{
			SetPlayerInterior(playerid, 3);
			SetPlayerFacingAngle(playerid, 270);
			SetPlayerPos(playerid, 1206.233398,-29.270675,1000.953125);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 1206.233398");
			SendClientMessage(playerid, COLOR_WHITE, "Y: -29.270675");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 1000.953125");
			SendClientMessage(playerid, COLOR_WHITE, "A: 270");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 3");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Big Spread Ranch (behind bar)");
			SendClientMessage(playerid, COLOR_YELLOW, "You've never been here, roof is too low to jump ;)");
			return 1;
		}

		if(strcmp(cmd, "/gara", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Garage Interiors");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gara1 - Garage in Esplanade North, SF");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gara2 - Garage in Commerce, LS");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gara3 - SF Bomb Shop");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

		if(strcmp(cmd, "/gara1", true)==0)
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerFacingAngle(playerid, 0);
			SetPlayerPos(playerid, -1790.264160,1432.254638,7.187500);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: -1790.264160");
			SendClientMessage(playerid, COLOR_WHITE, "Y: 1432.254638");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 7.187500");
			SendClientMessage(playerid, COLOR_WHITE, "A: 0");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Garage in Esplanade North, at the docks");
			SendClientMessage(playerid, COLOR_YELLOW, "Used in a mission cut scene for storage");
			return 1;
		}

		if(strcmp(cmd, "/gara2", true)==0)
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerFacingAngle(playerid, 0);
			SetPlayerPos(playerid, 1644.026489,-1518.588500,13.567542);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 1644.026489");
			SendClientMessage(playerid, COLOR_WHITE, "Y: -1518.588500");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 13.567542");
			SendClientMessage(playerid, COLOR_WHITE, "A: 0");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Garage in Commerce, Los Santos");
			SendClientMessage(playerid, COLOR_YELLOW, "Used in mission 'Life's a Beach' for OG Loc");
			return 1;
		}


		if(strcmp(cmd, "/gara3", true)==0)
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerFacingAngle(playerid, 90);
			SetPlayerPos(playerid, -1684.447631,1035.754516,45.210937);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: -1684.447631");
			SendClientMessage(playerid, COLOR_WHITE, "Y: 1035.754516");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 45.210937");
			SendClientMessage(playerid, COLOR_WHITE, "A: 90");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "San Fiero Bomb Shop");
			SendClientMessage(playerid, COLOR_YELLOW, "Remember this?");
			return 1;
		}


		if(strcmp(cmd, "/wara", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Warehouse Interiors");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/wara1 - Warehouse in Blueberry, RC");
		    SendClientMessage(playerid, COLOR_YELLOW, "/wara2 - Warehouse in Whitewood Estates, LV (part 1)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/wara3 - Warehouse in Whitewood Estates, LV (part 2)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

		if(strcmp(cmd, "/wara1", true)==0)
		{
	    	SetPlayerInterior(playerid, 0);	SetPlayerFacingAngle(playerid, 180);	SetPlayerPos(playerid, 52.093002,-302.419616,1.700098);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 52.093002");
			SendClientMessage(playerid, COLOR_WHITE, "Y: -302.419616");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 1.700098");
			SendClientMessage(playerid, COLOR_WHITE, "A: 180");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Warehouse in Blueberry, Red County");
			SendClientMessage(playerid, COLOR_YELLOW, "Good for a hideout, can't remember it ever being used");
			return 1;
		}

		if(strcmp(cmd, "/wara2", true)==0)
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerFacingAngle(playerid, 270);
			SetPlayerPos(playerid, 1058.787353,2087.521240,10.820312);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 1058.787353");
			SendClientMessage(playerid, COLOR_WHITE, "Y: 2087.521240");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 10.820312");
			SendClientMessage(playerid, COLOR_WHITE, "A: 270");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Warehouse in Whitewood Estates, Las Venturas");
			SendClientMessage(playerid, COLOR_YELLOW, "Used in mission 'You've Had Your Chips' for Woozie");
			return 1;
		}
		if(strcmp(cmd, "/wara3", true)==0)
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerFacingAngle(playerid, 270);
			SetPlayerPos(playerid, 1057.757446,2148.187988,10.820312);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 1057.757446");
			SendClientMessage(playerid, COLOR_WHITE, "Y: 2148.187988");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 10.820312");
			SendClientMessage(playerid, COLOR_WHITE, "A: 270");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Warehouse in Whitewood Estates, Las Venturas");
			SendClientMessage(playerid, COLOR_YELLOW, "This is a hidden part of the warehouse never seen in San Andreas");
			return 1;
		}
		if(strcmp(cmd, "/casa", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Caligula's >VS< Four Dragons");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/casa1 - Caligula's Casino (hidden room)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/casa2 - Caligula's Casino (office) - Don't get excited!");
		    SendClientMessage(playerid, COLOR_YELLOW, "/casa3 - Four Dragons Casino (garage)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/casa4 - Four Dragons Casino (management room)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

		if(strcmp(cmd, "/casa1", true)==0)
		{
			SetPlayerInterior(playerid, 1);
			SetPlayerFacingAngle(playerid, 90);
			SetPlayerPos(playerid, 2133.730712,1599.510375,1008.359375);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 2133.730712");
			SendClientMessage(playerid, COLOR_WHITE, "Y: 1599.510375");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 1008.359375");
			SendClientMessage(playerid, COLOR_WHITE, "A: 90");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 1");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Caligula's Casino Hidden Room");
			SendClientMessage(playerid, COLOR_YELLOW, "Just an empty room hidden behind a door in Caligula's");
			return 1;
		}

		if(strcmp(cmd, "/casa3", true)==0)
		{
			SetPlayerInterior(playerid, 0);
  			SetPlayerFacingAngle(playerid, 0);
			SetPlayerPos(playerid, 1903.478149,970.919982,10.820312);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 1903.478149");
			SendClientMessage(playerid, COLOR_WHITE, "Y: 970.919982");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 10.820312");
			SendClientMessage(playerid, COLOR_WHITE, "A: 0");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "The Four Dragons Casino Garage");
			SendClientMessage(playerid, COLOR_YELLOW, "Has been seen in end of mission cut scenes");
			return 1;
		}


		if(strcmp(cmd, "/casa4", true)==0)
		{
			SetPlayerInterior(playerid, 11);
			SetPlayerFacingAngle(playerid, 0);
			SetPlayerPos(playerid, 2013.760986,1016.695556,39.091094);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 2013.760986");
			SendClientMessage(playerid, COLOR_WHITE, "Y: 1016.695556");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 39.091094");
			SendClientMessage(playerid, COLOR_WHITE, "A: 0   Interior: 11");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "The Four Dragons Casino Management Room");
			SendClientMessage(playerid, COLOR_YELLOW, "An all time favourite interior, you are safe up on the roof =)");
			SendClientMessage(playerid, COLOR_RED, "Room isn't solid, DO NOT cross onto the north side of the roof!");
			return 1;
		}

		if(strcmp(cmd, "/busa", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Interiors of Commerce");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus1 - Liquor Store, Blueberry");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus2 - unused Motel room 1");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus3 - unused Motel room 2");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus4 - Bank, Palomino Creek");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus5 - Bank, Palomino Creek (behind counter)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus6 - Atrium, LS");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}


		if(strcmp(cmd, "/busa1", true)==0)
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerFacingAngle(playerid, 180);
			SetPlayerPos(playerid, 252.107192,-54.828540,1.577644);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 252.107192");
			SendClientMessage(playerid, COLOR_WHITE, "Y: -54.828540");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 1.577644");
			SendClientMessage(playerid, COLOR_WHITE, "A: 180");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Liquor Store in Blueberry, Red County");
			SendClientMessage(playerid, COLOR_YELLOW, "Nice place, once seen in a mission with Catalina");
			return 1;
		}

		if(strcmp(cmd, "/busa2", true)==0)
		{
			SetPlayerInterior(playerid, 10);
			SetPlayerFacingAngle(playerid, 270);
			SetPlayerPos(playerid, 2261.401123,-1135.940551,1050.632812);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 2261.401123");
			SendClientMessage(playerid, COLOR_WHITE, "Y: -1135.940551");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 1050.632812");
			SendClientMessage(playerid, COLOR_WHITE, "A: 270");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 10");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "An unused Motel room");
			SendClientMessage(playerid, COLOR_YELLOW, "Even got a wardrobe =D");
			return 1;
		}

		if(strcmp(cmd, "/busa3", true)==0)
		{
			SetPlayerInterior(playerid, 9);
			SetPlayerFacingAngle(playerid, 90);
			SetPlayerPos(playerid, 2253.139892,-1140.089965,1050.632812);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 2253.139892");
			SendClientMessage(playerid, COLOR_WHITE, "Y: -1140.089965");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 1050.632812");
			SendClientMessage(playerid, COLOR_WHITE, "A: 90");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 9");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Another unused Motel room");
			SendClientMessage(playerid, COLOR_YELLOW, "Also got a wardrobe =D");
			return 1;
		}


		if(strcmp(cmd, "/busa4", true)==0)
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerFacingAngle(playerid, 270);
			SetPlayerPos(playerid, 2306.387695,-16.136718,26.749565);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 2306.387695");
			SendClientMessage(playerid, COLOR_WHITE, "Y: -16.136718");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 26.749565");
			SendClientMessage(playerid, COLOR_WHITE, "A: 270");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Bank in Palomino Creek, Red County");
			SendClientMessage(playerid, COLOR_YELLOW, "Once seen in a mission with Catalina, would be great for Roleplay!");
			return 1;
		}

		if(strcmp(cmd, "/busa5", true)==0)
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerFacingAngle(playerid, 90);
			SetPlayerPos(playerid, 2318.324951,-7.291463,26.749565);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 2318.324951");
			SendClientMessage(playerid, COLOR_WHITE, "Y: -7.291463");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 26.749565");
			SendClientMessage(playerid, COLOR_WHITE, "A: 90");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Bank in Palomino Creek, Red County (behind counter)");
			SendClientMessage(playerid, COLOR_YELLOW, "'There is your change, and here is your receipt. Have a good day sir'");
			return 1;
		}


		if(strcmp(cmd, "/busa6", true)==0)
		{
			SetPlayerInterior(playerid, 18);	SetPlayerFacingAngle(playerid, 40);	SetPlayerPos(playerid, 1728.494995,-1668.352294,22.609375);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 1728.494995");
			SendClientMessage(playerid, COLOR_WHITE, "Y: -1668.352294");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 22.609375");
			SendClientMessage(playerid, COLOR_WHITE, "A: 40");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 18");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Atrium Hotel in Commerce, Los Santos");
			SendClientMessage(playerid, COLOR_YELLOW, "Used in mission 'Just Business' for Big Smoke");
			return 1;
		}


		if(strcmp(cmd, "/gova", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Government Interiors");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gova4 - Dillimore PD");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gova5 - Dillimore PD (jail cell)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gova6 - Dillimore PD (private room)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		return 1;}

		if(strcmp(cmd, "/gova4", true)==0)
		{
			SetPlayerInterior(playerid, 6);
			SetPlayerFacingAngle(playerid, 0);
			SetPlayerPos(playerid, 246.682373,65.300575,1003.640625);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 246.682373");
			SendClientMessage(playerid, COLOR_WHITE, "Y: 65.300575");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 1003.640625");
			SendClientMessage(playerid, COLOR_WHITE, "A: 0");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 6");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Dillimore Police Dept");
			SendClientMessage(playerid, COLOR_YELLOW, "Same interior as Los Santos PD");
			return 1;
		}

		if(strcmp(cmd, "/gova5", true)==0)
		{
	    	SetPlayerInterior(playerid, 6);
			SetPlayerFacingAngle(playerid, 270);
	        SetPlayerPos(playerid, 264.250000,77.507400,1001.039062);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 264.250000");
			SendClientMessage(playerid, COLOR_WHITE, "Y: 77.507400");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 1001.039062");
			SendClientMessage(playerid, COLOR_WHITE, "A: 270");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 6");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Dillimore Police Dept (jail cell)");
			SendClientMessage(playerid, COLOR_YELLOW, "Very useful for RPG gamemodes =)");
			return 1;
		}

		if(strcmp(cmd, "/gova6", true)==0)
		{
			SetPlayerInterior(playerid, 6);	SetPlayerFacingAngle(playerid, 0);	SetPlayerPos(playerid, 232.118377,66.382949,1005.039062);
			SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "X: 232.118377");
			SendClientMessage(playerid, COLOR_WHITE, "Y: 66.382949");
			SendClientMessage(playerid, COLOR_WHITE, "Z: 1005.039062");
			SendClientMessage(playerid, COLOR_WHITE, "A: 0");
			SendClientMessage(playerid, COLOR_WHITE, "Interior: 6");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Dillimore Police Dept (private room)");
			SendClientMessage(playerid, COLOR_RED, "Walls are NON-solid!");
			return 1;
		}


		if(strcmp(cmd, "/clear", true) == 0)
		{
			ClearPlayerChatBox(playerid);
			return 1;
		}
		if(strcmp(cmd, "/play", true) == 0)
		{
			new Float:xx,Float:yy,Float:zz;
			new soundi;
			tmp = strtok(cmdtext, idx);
			soundi = strval(tmp);
			GetPlayerPos(playerid,xx,yy,zz);
		PlayerPlaySound(playerid,soundi,xx,yy,zz);return 1;}

		if(strcmp(cmdtext,"/getvehid", true) == 0)
	    {
			new playervehid;
			playervehid = GetPlayerVehicleID(playerid);
			format(str,sizeof(str),"%s",playervehid);
		SendClientMessage(playerid,COLOR_RED,str);return 1;}
		if(strcmp(cmdtext,"/destroyveh", true) == 0)
	    {
			new carrid;
			tmp = strtok(cmdtext, idx);
			carrid = strval(tmp);
	    DestroyVehicle(carrid);return 1;}
		if(strcmp(cmdtext, "/?", true) == 0)
		{
     		new Float:xa,Float:ya,Float:za,Float:a;
    		new string1[256],string2[256],string3[256],string4[256];
			GetPlayerPos(playerid,xa,ya,za);
			GetPlayerFacingAngle(playerid,a);
     		format(string1,sizeof(string1),"X: %f",xa);
     		format(string2,sizeof(string2),"Y: %f",ya);
     		format(string3,sizeof(string3),"Z: %f",za);
     		format(string4,sizeof(string4),"A: %f",a);
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Current Position");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, string1);
			SendClientMessage(playerid, COLOR_WHITE, string2);
			SendClientMessage(playerid, COLOR_WHITE, string3);
			SendClientMessage(playerid, COLOR_WHITE, string4);
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, " ");
		return 1;}

	//$ endregion interiors
	if(strcmp(cmd,"/thirst", true) == 0) {
	    	new thirststring[256];	format(thirststring,256,"THIRST: %f %s",THIRSTY[playerid], "%");	SendClientMessage(playerid, COLOR_GREEN, thirststring);	return 1;}
   	if(strcmp(cmd,"/hunger", true) == 0) {
        new hungerstring[256];	format(hungerstring,256,"HUNGER: %f %s",HUNGRY[playerid], "%");	SendClientMessage(playerid, COLOR_GREEN, hungerstring);	return 1;}
	if(strcmp(cmd,"/sex", true) == 0) {
 		new sexstring[256];
		format(sexstring,256,"SEX: %f %s",SEXY[playerid], "%");
		SendClientMessage(playerid, COLOR_GREEN, sexstring);
		return 1;}
 	if(strcmp(cmd,"/getmoney", true) == 0) {
		new betrag;
		tmp = strtok(cmdtext, idx);
		betrag = strval(tmp);
		GivePlayerMoney(playerid,betrag);
		return 1;}
	if(strcmp(cmd,"/bizupmin", true) == 0) {
		new str1[256];
		tmp = strtok(cmdtext, idx);
		bizupmin = strval(tmp);
		format(str1,256,"bizupmin= %d",bizupmin);
		SendClientMessage(playerid, COLOR_GREEN, str1);
		return 1;}
	return 0;
}
public OnPlayerInfoChange(playerid){
	printf("OnPlayerInfoChange(%d)");
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)	{
	#pragma unused oldkeys
	if ((NOFZombies>0) && (newkeys & KEY_FIRE)&&(!IsPlayerInAnyVehicle(playerid))&&(Ticket[playerid]<tickcount()))    {
        fire(playerid,PRESS);
    }
	if 	((SinGas[playerid]!=0)&&(newkeys==KEY_SECONDARY_ATTACK)&&(IsPlayerInAnyVehicle(playerid))&&(IsPlayerInVehicle(playerid,SinGas[playerid])))	{
		RemovePlayerFromVehicle(playerid);
		return 1;
	}
	if ( carSelect[playerid]>0 ){
		if(carSelect[playerid]==1){
			if(RELEASED(KEY_CROUCH)){
				menuPlace[playerid] = menuPlace[playerid]-1;
				if(menuPlace[playerid] < 0){ menuPlace[playerid] = MAX_MENU_ITEMS-1;}
				UpdatespideyMenu(playerid);
			}
			if(RELEASED(KEY_JUMP)){
				menuPlace[playerid] = menuPlace[playerid]+1;
				if(menuPlace[playerid] > MAX_MENU_ITEMS-1){ menuPlace[playerid] = 0;}
				UpdatespideyMenu(playerid);
			}
			if(RELEASED(KEY_SPRINT)){
				if (menuPlace[playerid]==0){
					carSelect[playerid] = 2;
					ClearCarMenu(playerid);
					TextDrawSetString(menuDraws[playerid][32],"Car Types");
					TextDrawHideForPlayer(playerid , menuDraws[playerid][30]);
					TextDrawShowForPlayer(playerid , menuDraws[playerid][31]);
					UpdatecartypeMenu(playerid);
				}
				else if (menuPlace[playerid]==1){
					carSelect[playerid] = 3;
					ClearCarMenu(playerid);
					TextDrawHideForPlayer(playerid , menuDraws[playerid][30]);
					if ( totalItems[playerid][menuPlace[playerid]]-itemStart[playerid][menuPlace[playerid]]<=15 ){
						TextDrawLetterSize(menuDraws[playerid][30],1.000000,(0.7+(0.45*(totalItems[playerid][menuPlace[playerid]]-itemStart[playerid][menuPlace[playerid]]))));
						TextDrawShowForPlayer(playerid , menuDraws[playerid][30]);
						colorpage[playerid]=2;}
					else{
						TextDrawShowForPlayer(playerid , menuDraws[playerid][31]);
						colorpage[playerid]=3;
					}
					TextDrawSetString(menuDraws[playerid][32],menuNames[playerid][0]);
					UpdateCarmMenu(playerid);
				}
				else if (menuPlace[playerid]==2 || menuPlace[playerid]==3){
					carSelect[playerid] = 4;
					ClearCarMenu(playerid);
					ShowMenuColor(playerid);
				}
				else if (menuPlace[playerid]==4){
					DestroyCarMenu(playerid);
					carsmenucreated=carsmenucreated-1;
					if ( carsmenucreated==0 ){
						DestroyMenuColor();
					}
					TogglePlayerSpectating(playerid, 0);
					PutPlayerInVehicle(playerid, VehicleInfo[playerCar[playerid]][idnum], 0);
					LockCarForAll( VehicleInfo[playerCar[playerid]][idnum], false );
					VehicleInfo[playerCar[playerid]][owner] = PlayerName(playerid);
					VehicleInfo[playerCar[playerid]][ownerid] = playerid;
					destroyCar[playerid][1] = false;
					destroyCar[playerid][0] = true;
					carSelect[playerid] = 0;
					menuPlace[playerid]=0;
					playerCar[playerid]=0;
				}
				else if (menuPlace[playerid]==5){
					DestroyCarMenu(playerid);
					carsmenucreated=carsmenucreated-1;
					if ( carsmenucreated==0 ){
					DestroyMenuColor();}
					TogglePlayerSpectating(playerid, 0);
					DestroyStreamVehicle(VehicleInfo[playerCar[playerid]][streamid]);
					SetPlayerPos(playerid, PlayerPos[playerid][0],  PlayerPos[playerid][1], PlayerPos[playerid][2]);
					destroyCar[playerid][1] = false;
					destroyCar[playerid][0] = true;
					carSelect[playerid] = 0;
					menuPlace[playerid]=0;
					playerCar[playerid]=0;
				}
			}
			if(RELEASED(KEY_SECONDARY_ATTACK)){
				DestroyCarMenu(playerid);
				carsmenucreated=carsmenucreated-1;
				if ( carsmenucreated==0 ){
				DestroyMenuColor();}
				TogglePlayerSpectating(playerid, 0);
				DestroyStreamVehicle(VehicleInfo[playerCar[playerid]][streamid]);
				SetPlayerPos(playerid, PlayerPos[playerid][0],  PlayerPos[playerid][1], PlayerPos[playerid][2]);
				destroyCar[playerid][1] = false;
				destroyCar[playerid][0] = true;
				carSelect[playerid] = 0;
				menuPlace[playerid]=0;
				playerCar[playerid]=0;
			}
		}
		else if(carSelect[playerid]==2){
			if(RELEASED(KEY_CROUCH)){
				itemPlace[playerid][menuPlace[playerid]] = (itemPlace[playerid][menuPlace[playerid]] == itemStart[playerid][menuPlace[playerid]] ) ? totalItems[playerid][menuPlace[playerid]]-1:itemPlace[playerid][menuPlace[playerid]]-1;
				itemStart[playerid][1] = carType[itemPlace[playerid][0]][typeStart];
				totalItems[playerid][1] = carType[itemPlace[playerid][0]][typeEnd];
				itemPlace[playerid][1] = itemStart[playerid][1];
				UpdateCar(playerid);
				UpdatecartypeMenu(playerid);
			}
			if(RELEASED(KEY_JUMP)){
				itemPlace[playerid][menuPlace[playerid]] = (itemPlace[playerid][menuPlace[playerid]] == totalItems[playerid][menuPlace[playerid]]-1 ) ? itemStart[playerid][menuPlace[playerid]]:itemPlace[playerid][menuPlace[playerid]]+1;
				itemStart[playerid][1] = carType[itemPlace[playerid][0]][typeStart];
				totalItems[playerid][1] = carType[itemPlace[playerid][0]][typeEnd];
				itemPlace[playerid][1] = itemStart[playerid][1];
				UpdateCar(playerid);
				UpdatecartypeMenu(playerid);
			}
			if(RELEASED(KEY_SPRINT)){
				carSelect[playerid] = 1;
				ClearCarMenu(playerid);
				TextDrawHideForPlayer(playerid , menuDraws[playerid][31]);
				TextDrawLetterSize(menuDraws[playerid][30],1.000000,2.95);
				TextDrawShowForPlayer(playerid , menuDraws[playerid][30]);
				UpdatespideyMenu(playerid);
			}
		}
		else if(carSelect[playerid]==3){
			if(RELEASED(KEY_CROUCH)){
				itemPlace[playerid][menuPlace[playerid]] = (itemPlace[playerid][menuPlace[playerid]] == itemStart[playerid][menuPlace[playerid]] ) ? totalItems[playerid][menuPlace[playerid]]-1:itemPlace[playerid][menuPlace[playerid]]-1;
				UpdateCarmMenu(playerid);
			}
			if(RELEASED(KEY_JUMP)){
				itemPlace[playerid][menuPlace[playerid]] = (itemPlace[playerid][menuPlace[playerid]] == totalItems[playerid][menuPlace[playerid]]-1 ) ? itemStart[playerid][menuPlace[playerid]]:itemPlace[playerid][menuPlace[playerid]]+1;
				UpdateCarmMenu(playerid);
			}
			if(RELEASED(KEY_SPRINT)){
				carSelect[playerid] = 5;
				UpdateCar(playerid);
			}
		}
		else if(carSelect[playerid]==4){
			if(RELEASED(KEY_CROUCH)){
				itemPlace[playerid][menuPlace[playerid]] = itemPlace[playerid][menuPlace[playerid]]-8;
				if(itemPlace[playerid][menuPlace[playerid]] < 0 && colorpage[playerid]==0){
					itemPlace[playerid][menuPlace[playerid]] = totalItems[playerid][menuPlace[playerid]]-9;
					HideMenuColor(playerid);
					ShowMenuColor2(playerid);
					colorpage[playerid]=1;
				}
				else if (itemPlace[playerid][menuPlace[playerid]] < 64 && colorpage[playerid]==1){
					HideMenuColor2(playerid);
					ShowMenuColor(playerid);
					colorpage[playerid]=0;
				}
				ChangeVehicleColor(VehicleInfo[playerCar[playerid]][idnum], itemPlace[playerid][2],itemPlace[playerid][3]);
				UpdateColSel(playerid);
			}
			if(RELEASED(KEY_JUMP)){
				itemPlace[playerid][menuPlace[playerid]] = itemPlace[playerid][menuPlace[playerid]]+8;
				if (itemPlace[playerid][menuPlace[playerid]] > totalItems[playerid][menuPlace[playerid]]-1 && colorpage[playerid]==1){
					itemPlace[playerid][menuPlace[playerid]] = itemPlace[playerid][menuPlace[playerid]]-totalItems[playerid][menuPlace[playerid]]-1;
					HideMenuColor2(playerid);
					ShowMenuColor(playerid);
					colorpage[playerid]=0;}
				else if(itemPlace[playerid][menuPlace[playerid]] > 63 && colorpage[playerid]==0){
					HideMenuColor(playerid);
					ShowMenuColor2(playerid);
					colorpage[playerid]=1;
				}
				ChangeVehicleColor(VehicleInfo[playerCar[playerid]][idnum], itemPlace[playerid][2],itemPlace[playerid][3]);
				UpdateColSel(playerid);
			}
			if(RELEASED(KEY_WALK)){
				itemPlace[playerid][menuPlace[playerid]] = itemPlace[playerid][menuPlace[playerid]]-1;
				if(itemPlace[playerid][menuPlace[playerid]] < 0 && colorpage[playerid]==0){
					itemPlace[playerid][menuPlace[playerid]] = totalItems[playerid][menuPlace[playerid]]-1;
					HideMenuColor(playerid);
					ShowMenuColor2(playerid);
					colorpage[playerid]=1;
				}
				else if (itemPlace[playerid][menuPlace[playerid]] < 64 && colorpage[playerid]==1){
					HideMenuColor2(playerid);
					ShowMenuColor(playerid);
					colorpage[playerid]=0;
				}
				ChangeVehicleColor(VehicleInfo[playerCar[playerid]][idnum], itemPlace[playerid][2],itemPlace[playerid][3]);
				UpdateColSel(playerid);
			}
			if(RELEASED(KEY_LOOK_BEHIND)){
				itemPlace[playerid][menuPlace[playerid]] = itemPlace[playerid][menuPlace[playerid]]+1;
				if (itemPlace[playerid][menuPlace[playerid]] > totalItems[playerid][menuPlace[playerid]]-1 && colorpage[playerid]==1){
					itemPlace[playerid][menuPlace[playerid]] = 0;
					HideMenuColor2(playerid);
					ShowMenuColor(playerid);
					colorpage[playerid]=0;
				}
				else if(itemPlace[playerid][menuPlace[playerid]] > 63 && colorpage[playerid]==0){
					HideMenuColor(playerid);
					ShowMenuColor2(playerid);
					colorpage[playerid]=1;
				}
				ChangeVehicleColor(VehicleInfo[playerCar[playerid]][idnum], itemPlace[playerid][2],itemPlace[playerid][3]);
				UpdateColSel(playerid);
			}
			if(RELEASED(KEY_SPRINT)){
				carSelect[playerid] = 1;
				VehicleInfo[playerCar[playerid]][colors][0] = itemPlace[playerid][2];
				VehicleInfo[playerCar[playerid]][colors][1] = itemPlace[playerid][3];
				if ( colorpage[playerid]==0 ){
					HideMenuColor(playerid);}
				else if (colorpage[playerid]==1){
					HideMenuColor2(playerid);}
				colorpage[playerid]=0;
				UpdatespideyMenu(playerid);
			}
			if (RELEASED(KEY_SECONDARY_ATTACK)){
				itemPlace[playerid][2]=VehicleInfo[playerCar[playerid]][colors][0];
				itemPlace[playerid][3]=VehicleInfo[playerCar[playerid]][colors][1];
				ChangeVehicleColor(VehicleInfo[playerCar[playerid]][idnum], itemPlace[playerid][2],itemPlace[playerid][3]);
			}
		}
		else if(carSelect[playerid]==5){
			if(RELEASED(KEY_SPRINT)){
				carSelect[playerid] = 1;
				ClearCarMenu(playerid);
	//			itemPlace[i][menuPlace[i]]=0;
				if ( colorpage[playerid]==2 ){
					TextDrawHideForPlayer(playerid , menuDraws[playerid][30]);}
				if ( colorpage[playerid]==3 ){
					TextDrawHideForPlayer(playerid , menuDraws[playerid][31]);}
				colorpage[playerid]=0;
				TextDrawLetterSize(menuDraws[playerid][30],1.000000,2.95);
				TextDrawShowForPlayer(playerid , menuDraws[playerid][30]);
				UpdatespideyMenu(playerid);
			}
		}
	}
	return 1;
}
public OnPlayerEnterVehicle(playerid, vehicleid){
	for (new i = 0; i < MAX_PLAYERS; i++){
		playervehpriority[i][GetVehicleStreamID(vehicleid)]=0;
	}
	for (new j = 0; j < vehcount3; j++){
		if (playervehpriority[playerid][j]==1){
			VehicleInfo[j][priority]++;
		}
	}
	VehicleInfo[GetVehicleStreamID(vehicleid)][priority]=0;
	playervehpriority[playerid][GetVehicleStreamID(vehicleid)]=1;
	SendClientMessage(playerid,COLOR_WHITE,"u entered a vehicle!");
	return 1;
}
public OnPlayerExitVehicle(playerid, vehicleid){
    VehicleInfo[VehStreamid[vehicleid]][messagesend2]=0;
    VehicleInfo[VehStreamid[vehicleid]][messagesend3]=0;
	return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate)	{
 	#pragma unused oldstate
	if (newstate==PLAYER_STATE_DRIVER){
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	SavePlayerPos[playerid][LastX] = x;
	SavePlayerPos[playerid][LastY] = y;
	SavePlayerPos[playerid][LastZ] = z;
	SpeedoString[playerid][0] = TextDrawCreate(490.0,105.0,"Fuel:0000 L");
	TextDrawAlignment(SpeedoString[playerid][0],0);
	TextDrawFont(SpeedoString[playerid][0],3);
	TextDrawLetterSize(SpeedoString[playerid][0],0.8,0.8);
	TextDrawColor(SpeedoString[playerid][0],0x00ff0066);
	TextDrawSetProportional(SpeedoString[playerid][0],0);
	TextDrawSetShadow(SpeedoString[playerid][0],1);
	SpeedoString[playerid][1] = TextDrawCreate(490.0,113.0,"Km /h:000");
	TextDrawAlignment(SpeedoString[playerid][1],0);
	TextDrawFont(SpeedoString[playerid][1],3);
	TextDrawLetterSize(SpeedoString[playerid][1],0.8,0.8);
	TextDrawColor(SpeedoString[playerid][1],0x00ff0066);
	TextDrawSetProportional(SpeedoString[playerid][1],0);
	TextDrawSetShadow(SpeedoString[playerid][1],1);
	SpeedoString[playerid][2] = TextDrawCreate(490.0,121.0,"KM: 00000");
	TextDrawAlignment(SpeedoString[playerid][2],0);
	TextDrawFont(SpeedoString[playerid][2],3);
	TextDrawLetterSize(SpeedoString[playerid][2],0.8,0.8);
	TextDrawColor(SpeedoString[playerid][2],0x00ff0066);
	TextDrawSetProportional(SpeedoString[playerid][2],0);
	TextDrawSetShadow(SpeedoString[playerid][2],1);
	SpeedoString[playerid][3] = TextDrawCreate(490.0,129.0,"Oil: 00%");
	TextDrawAlignment(SpeedoString[playerid][3],0);
	TextDrawFont(SpeedoString[playerid][3],3);
	TextDrawLetterSize(SpeedoString[playerid][3],0.8,0.8);
	TextDrawColor(SpeedoString[playerid][3],0x00ff0066);
	TextDrawSetProportional(SpeedoString[playerid][3],0);
	TextDrawSetShadow(SpeedoString[playerid][3],1);
	if (SpeedoInfo[playerid][enabled]){
		TextDrawShowForPlayer(playerid,SpeedoString[playerid][0]);
		TextDrawShowForPlayer(playerid,SpeedoString[playerid][1]);
		TextDrawShowForPlayer(playerid,SpeedoString[playerid][2]);
		TextDrawShowForPlayer(playerid,SpeedoString[playerid][3]);}
		return 1;}
	if (newstate==PLAYER_STATE_PASSENGER && SpeedoInfo[playerid][enabled])
	    {
	    TextDrawShowForPlayer(playerid,SpeedoString[playerid][0]);
	    TextDrawShowForPlayer(playerid,SpeedoString[playerid][1]);
	    TextDrawShowForPlayer(playerid,SpeedoString[playerid][2]);
	    TextDrawShowForPlayer(playerid,SpeedoString[playerid][3]);
	    }
	if (newstate==PLAYER_STATE_ONFOOT)
	    {
	    TextDrawDestroy(SpeedoString[playerid][0]);
	    TextDrawDestroy(SpeedoString[playerid][1]);
	    TextDrawDestroy(SpeedoString[playerid][2]);
	    TextDrawDestroy(SpeedoString[playerid][3]);
	    if  (SinGas[playerid]!=0)
	        {
	        TogglePlayerControllable(playerid,true);
	        }
	    SinGas[playerid]=0;
	    }
	return 1;
	}
public OnPlayerEnterCheckpoint(playerid)	{
        switch(getCheckpointType(playerid))
        {
 	       case Gasstation0 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
				UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation1 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation2 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
				UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation3 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation4 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation5 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation6 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation7 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation8 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation9 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation10 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
				}}
	       case Gasstation11 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation12 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation13 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation14 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation15 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation16 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation17 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation18 : {
 if 	(IsPlayerInAnyVehicle(playerid) && gasselect[playerid]==0)  	{
				gasselect[playerid]=1;
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
        }
 }
public OnPlayerLeaveCheckpoint(playerid){
    TogglePlayerControllable(playerid,true);
	gasselect[playerid]=0;
	return 1;
}
public OnPlayerSelectedMenuRow(playerid, row){
new Menu:Current = GetPlayerMenu(playerid);
if (Current == Main){
if (row == 0){ShowMenuForPlayer(one,playerid);}
if (row == 1){ShowMenuForPlayer(two,playerid);}
if (row == 2){ShowMenuForPlayer(tree,playerid);}
if (row == 3){ShowMenuForPlayer(four,playerid);}
if (row == 4){ShowMenuForPlayer(five,playerid);}
if (row == 5){ShowMenuForPlayer(six,playerid);}
if (row == 6){ShowMenuForPlayer(seven,playerid);}
if (row == 7){ShowMenuForPlayer(eight,playerid);}
if (row == 8){ShowMenuForPlayer(nine,playerid);}
}
if (Current == one){
if (row == 0){SelectObject(10023);}//902
if (row == 1){SelectObject(1612);}
keys = 1;
}
if (Current == two){
if (row == 0){SelectObject(3249 );}
if (row == 1){SelectObject(3689  );}
if (row == 2){SelectObject(1675  );}
if (row == 3){SelectObject(3781  );}
if (row == 4){SelectObject(967  );}
if (row == 5){SelectObject(3436  );}
if (row == 6){SelectObject(3452  );}
if (row == 7){SelectObject(3988  );}
keys = 1;
}
if (Current == tree){
if (row == 0){SelectObject(1376   );}
if (row == 1){SelectObject(925   );}
if (row == 2){SelectObject(914   );}
keys = 1;
}
if (Current == four){
if (row == 0){SelectObject(1455    );}
if (row == 1){SelectObject(1515    );}
if (row == 2){SelectObject(2052    );}
if (row == 3){SelectObject(977    );}
if (row == 4){SelectObject(936    );}
if (row == 5){SelectObject(1208    );}
if (row == 6){SelectObject(1513    );}
if (row == 7){SelectObject(643    );}
keys = 1;
}
if (Current == five){
if (row == 0){SelectObject(3975     );}
if (row == 1){SelectObject(3522     );}
keys = 1;
}
if (Current == six){
if (row == 0){SelectObject(955      );}
if (row == 1){SelectObject(1426      );}
if (row == 2){SelectObject(3268      );}
if (row == 3){SelectObject(954      );}
if (row == 4){SelectObject(918      );}
if (row == 5){SelectObject(1211      );}
if (row == 6){SelectObject(849      );}
keys = 1;

}
if (Current == seven){
if (row == 0){SelectObject(625       );}
if (row == 1){SelectObject(744       );}
if (row == 2){SelectObject(615       );}
keys = 1;
}
if (Current == eight){
if (row == 0){SelectObject(1681        );}
if (row == 1){SelectObject(3448        );}
if (row == 2){SelectObject(1451        );}
if (row == 3){SelectObject(966        );}
if (row == 4){SelectObject(3187        );}
if (row == 5){SelectObject(1245        );}
keys = 1;
}
if (Current == nine){
if (row == 0){SelectObject(4817         );}
if (row == 1){SelectObject(3330         );}
keys = 1;
}
if (Current == one || two || tree || four || five || six || seven || eight || nine){
SendClientMessage(playerid,0xFFFFFFAA,"----------------------------------------------------------------------------");
SendClientMessage(playerid,0xFFFFFFAA,"HINT: You can use LEFT and RIGHT arrow keys to scroll among those objects.");
SendClientMessage(playerid,0xFFFFFFAA,"HINT: You can use UP and DOWN arrow keys to move your camera position.");
SendClientMessage(playerid,0xFFFFFFAA,"HINT: Once you have found the object you wanted press ENTER.");
SendClientMessage(playerid,0xFFFFFFAA,"----------------------------------------------------------------------------");
}
return 1;
}
public OnPlayerExitedMenu(playerid){
new Menu:Current = GetPlayerMenu(playerid);
if (Current == one){ShowMenuForPlayer(Main,playerid);}
if (Current == two){ShowMenuForPlayer(Main,playerid);}
if (Current == tree){ShowMenuForPlayer(Main,playerid);}
if (Current == four){ShowMenuForPlayer(Main,playerid);}
if (Current == five){ShowMenuForPlayer(Main,playerid);}
if (Current == six){ShowMenuForPlayer(Main,playerid);}
if (Current == seven){ShowMenuForPlayer(Main,playerid);}
if (Current == eight){ShowMenuForPlayer(Main,playerid);}
if (Current == nine){ShowMenuForPlayer(Main,playerid);}
if (Current == Main){
SetCameraBehindPlayer(playerid);
TogglePlayerControllable(playerid,1);
}
return 1;
}
OnPlayerEnterArea(playerid,areaid) {
new Float:ax, Float:ay, Float:az;
new vehicle2 = GetPlayerVehicleID(playerid);
/*	new hstr[255];
		for(new tempb=1;tempb<=BIZ_AMOUNT;tempb++) {
			//Für jedes biz wird mit tempb ein -ä-
			if(tempb == 1) {
			new newpropcost;
			newpropcost=dini_Int(tmpname,"propcost");
        	minibet[tempb] = 1000; //minimalgebot,
        	maxibet[tempb] = 3000; //maximalgebot,
        	miniskill[tempb] = 0; //minimalskill,
        	maxiskill[tempb] = 3; //maximalskill,
			profit[tempb] = 750; //profit
			format(bizname,sizeof(bizname),"First Business"); //bizname wird festgelegt
        	if (newpropcost > minibet[k]){ //wenn das Höchstgebot größer ist als das minimalgebot
			propcost[k] = newpropcost;} //dann kann er die Höchstgebot aus dem biz nehmen
			else { propcost[k] = minibet[k];} //ansonsten ist es das minimalgebot
    	}
		if(tempb >= 3 && tempb <=4) {
 			propcost[tempb] = 11000000;
 			profit[tempb] = 4750;
		}
*/
/*
for (new i = 0; i < MAX_DRIVEPOINTS2 ; i++)	{
if(areaid==drivearea[i]&&drivepbool==true){
		new string[256];
		format(string,sizeof(string),"ID: %d  X: %f  Y: %f  Z: %f  A: %f",i,DrivePoints2[i][0],DrivePoints2[i][1],DrivePoints2[i][2],DrivePoints2[i][3]);
		SendClientMessage(playerid, COLOR_YELLOW, string);}}
for (new k = 0; k < MAX_HOUSES; k++){
if(areaid==housearea[k]){
		format(tmpname,sizeof(tmpname),"BIZ%d", k); //name der Dateien
		if (!dini_Exists(tmpname)) { //wenn noch keine daten für diese biznummer existieren
    	    	dini_Create(tmpname); //erstellt eine datei und setzt ihre variablen
    	    	dini_IntSet(tmpname, "propcost", Houses[k][hmaxbet]);
				dini_Set(tmpname, "owner", "Goverment");
				dini_Set(tmpname, "name", Houses[k][hname]);
				dini_IntSet(tmpname, "totalprofit", 0);
				dini_IntSet(tmpname, "bought", 0);
				dini_IntSet(tmpname, "idnumber", k);
				dini_Set(tmpname,"oldbetor","Goverment");
				dini_IntSet(tmpname,"oldbet", 0);
				dini_IntSet(tmpname,"oldbuy", 0);
				dini_IntSet(tmpname,"payd",0);
				dini_IntSet(tmpname,"forselling",0);
    	}
//		else{ dini_IntSet(tmpname, "propcost", propcost[k]);} // -ä- werden die jeweiligen Kosten in der biznummer gespeichert
	    if(propactive[playerid] == 0) {
				format(cttmp, sizeof(cttmp), "BIZ%d",k); //die biznummer für das biz um mit cttmp die daten zu hohlen
				biznum[playerid] = dini_Int(cttmp,"idnumber"); //die biznummer wird hier festgelegt um sie später zu indetifizieren
				ownername = dini_Get(cttmp,"owner"); //der besitzername, wenn einer existiert
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME); //der jetzt in dem symbol steht
				propcost[playerid] = dini_Int(cttmp,"propcost");
				//holt die jeweiligen Kosten, cttmp ist die biznummer für den spieler
//				if (newpropcost > minibet[k]){ //wenn das Höchstgebot größer ist als das minimalgebot
//				propcost[k] = newpropcost;} //dann kann er die Höchstgebot aus dem biz nehmen
//				else { propcost[k] = minibet[k];} //ansonsten ist es das minimalgebot
        		profit[playerid] = Houses[k][hprofit];
				totalprofit[playerid] = dini_Int(cttmp,"totalprofit");
				hpayd[playerid] = dini_Int(cttmp,"payd");
				minibet[playerid] = Houses[k][hminibet]; //minimalgebot " " " "
 				maxibet[playerid] = Houses[k][hmaxbet]; //maximalgebot " " " "
				miniskill[playerid] = Houses[k][hminiskill]; //minimalgebot " " " "
 				maxiskill[playerid] = Houses[k][hmaxskill]; //maximalgebot " " " "
 				interi[playerid] = Houses[k][inter]; //maximalgebot " " " "
				oldbet[playerid] = dini_Int(cttmp,"oldbet");
				selling[playerid] = dini_Int(cttmp,"forselling");
				oldname1 = dini_Get(cttmp,"oldbetor");
           		BIZNAME2 = dini_Get(cttmp,"name");
        		propactive[playerid] = 1; // -ü- bid wird hier nicht FALSE und geht weiter
        		format(propmess,sizeof(propmess),"~r~%s~n~~b~Owner: ~w~%s   ~b~Highest bid: ~w~%d ~n~~b~Profit/ 5 min: ~w~%d ~b~Required Level: ~w~%d - %d", BIZNAME2, ownername, propcost[playerid], profit[playerid], miniskill[playerid], maxiskill[playerid]);
				GameTextForPlayer(playerid,propmess,10000,3);
			 	if(strcmp(ownername,"Goverment",false) == 0 || selling[playerid] == 1){
					//wenn das business zu verkaufen ist
	   				bidorbuy[playerid] = 1;
	   	    		format(propmess,sizeof(propmess),"The %s is currently for sale. U can buy it by typing /buy.", BIZNAME2);
		 			SendClientMessage(playerid,COLOR_GREEN,propmess);
		 			SendClientMessage(playerid, COLOR_GREEN, "The buisness will continue to make money at every 5min even when you are offline!");
		 			return 1;}
	   			if(strcmp(ownername,playernameh,false) == 0) { //ist der in dem symbol der besitzer?
	   				format(propmess,sizeof(propmess),"Welcome back to your %s, %s. Type /getprofit to collect the earnings ($ %d) your business has made since your last collection.", BIZNAME2, ownername, totalprofit[playerid]);
   		       		SendClientMessage(playerid,COLOR_GREEN,propmess);
   		       		return 1;}
				if(hpayd[playerid] > 1){
				    bidorbuy[playerid] = 2;
               		SendClientMessage(playerid, COLOR_GREEN, "The Owner forgot to pay his bills. There is an auction on this house.");
               		SendClientMessage(playerid,COLOR_GREEN,"Type /bid to make ur bid. Auctions end every full hour.");
               		SendClientMessage(playerid, COLOR_GREEN, "The buisness will continue to make money at every 5min even when you are offline!");
					return 1;}
				if(selling[playerid] == 2){
					bidorbuy[playerid] = 2;
					format(propmess,sizeof(propmess),"The Owner set an Auction to sell the %s.", BIZNAME2);
					SendClientMessage(playerid, COLOR_GREEN, propmess);
					SendClientMessage(playerid,COLOR_GREEN,"Type /bid to make ur bid. Auctions end every full hour.");
					return 1;}
               		format(propmess,sizeof(propmess),"The %s has currently a owner. The Owner payed his bills %d mins ago.", BIZNAME2, hpayd[playerid]);
                    SendClientMessage(playerid, COLOR_GREEN, propmess);
					return 1;}
return 1;}}
*/
for (new h = 0; h < MAX_SODA; h++){
if (areaid==Sodaarea[h]) {
	SendClientMessage(playerid, 0xFF7B7BAA, "Entered Soda");
    GetPlayerHealth(playerid,oldhealth);
    Sodamoney = GetPlayerMoney(playerid);
	timer1 = SetTimer("SODA",1,1);}}
for (new g = 0; g < MAX_SNACK; g++){
if (areaid==Snackarea[g]) {
	SendClientMessage(playerid, 0xFF7B7BAA, "Entered Snack");
    GetPlayerHealth(playerid,oldhealth);
    Snackmoney = GetPlayerMoney(playerid);
	timer2 = SetTimer("SNACK",1,1);}}
if (areaid==PSvegas) {
	SendClientMessage(playerid, 0xFF7B7BAA, "U Are NOT a Carmechanic");
	if (IsPlayerInAnyVehicle(playerid)){
	GetPlayerPos(playerid,ax,ay,az);
	SetVehicleZAngle(vehicle2,90.0);
	SetVehiclePos(vehicle2,ax-1,ay,az);
	}
	else {
	GetPlayerPos(playerid,ax,ay,az);
	SetPlayerFacingAngle(playerid,90.0);
   	SetPlayerPos(playerid,ax-1,ay,az);}
   	}
if (areaid==PSlaEast || areaid==TSSpecialSF) {
   	SendClientMessage(playerid, 0xFF7B7BAA, "U Are NOT a Carmechanic");
	if (IsPlayerInAnyVehicle(playerid)){
	GetPlayerPos(playerid,ax,ay,az);
	SetVehicleZAngle(vehicle2,270.0);
	SetVehiclePos(vehicle2,ax+1,ay,az);
	}
	else {
	GetPlayerPos(playerid,ax,ay,az);
	SetPlayerFacingAngle(playerid,270.0);
   	SetPlayerPos(playerid,ax+1,ay,az);}}
if (areaid==PSdesertNorth || areaid==PSsanfranNorth || areaid==PSlaWest || areaid==TSlaSpecial) {
   	SendClientMessage(playerid, 0xFF7B7BAA, "U Are NOT a Carmechanic");
	if (IsPlayerInAnyVehicle(playerid)){
	GetPlayerPos(playerid,ax,ay,az);
	SetVehicleZAngle(vehicle2,0.0);
	SetVehiclePos(vehicle2,ax,ay+1,az);
	}
	else {
	GetPlayerPos(playerid,ax,ay,az);
	SetPlayerFacingAngle(playerid,0.0);
   	SetPlayerPos(playerid,ax,ay+1,az);}}
if (areaid==TSvegas || areaid==PSdesertSouth || areaid==PSsanfranSouth || areaid==TSsanfran || areaid==PSlaNorth || areaid==PSlaCountry || areaid==TSLosAngeles ) {
   	SendClientMessage(playerid, 0xFF7B7BAA, "U Are NOT a Carmechanic");
	if (IsPlayerInAnyVehicle(playerid)){
	GetPlayerPos(playerid,ax,ay,az);
	SetVehicleZAngle(vehicle2,180.0);
	SetVehiclePos(vehicle2,ax,ay-1,az);
	}
	else {
	GetPlayerPos(playerid,ax,ay,az);
	SetPlayerFacingAngle(playerid,180.0);
   	SetPlayerPos(playerid,ax,ay-1,az);}}
if (areaid==fastfood1 || areaid==fastfood2 || areaid==fastfood3) {
	SendClientMessage(playerid, 0xFF7B7BAA, "Entered Fastfood");
    GetPlayerHealth(playerid,oldhealth);
    foodmoney = GetPlayerMoney(playerid);
	timer3 = SetTimer("FASTFOOD",1,1);}
return 1;}
OnPlayerLeaveArea(playerid,areaid) {
for (new h = 0; h < MAX_SODA; h++){
if (areaid==Sodaarea[h]) {
	KillTimer(timer1);
    SendClientMessage(playerid, 0xFF7B7BAA, "Exit Soda");
	SetPlayerHealth(playerid,oldhealth);}}
for (new g = 0; g < MAX_SNACK; g++){
if (areaid==Snackarea[g]) {
	KillTimer(timer2);
    SendClientMessage(playerid, 0xFF7B7BAA, "Exit Snack");
	SetPlayerHealth(playerid,oldhealth);}}
/*
for (new k = 0; k < MAX_HOUSES; k++){
if(areaid==housearea[k]){
	SendClientMessage(playerid,COLOR_YELLOW,"exit house");
	propactive[playerid] = 0;
	bidorbuy[playerid] = 0;}}
*/
if (areaid==fastfood1 || areaid==fastfood2 || areaid==fastfood3) {
	KillTimer(timer3);
    SendClientMessage(playerid, 0xFF7B7BAA, "Exit Fastfood");
	SetPlayerHealth(playerid,oldhealth);}
	return 1;
	}
//$ region carmod-textdrawupdate
DestroyCarMenu(playerid){
	for(new i = 0; i < 33; i++){
	     TextDrawDestroy(menuDraws[playerid][i]);	}}
DestroyMenuColor(){
	for(new i = 0; i < TOTAL_COLORS+1; i++){
	    TextDrawDestroy(colordraw[i]);}}
HideMenuColor(playerid){
	for(new g=0; g < 64; g++){
		TextDrawHideForPlayer(playerid,colordraw[g]);}}
HideMenuColor2(playerid){
	for(new i=64; i < TOTAL_COLORS; i++){
		TextDrawHideForPlayer(playerid,colordraw[i]);}}
ShowMenuColor(playerid){
TextDrawSetString(menuDraws[playerid][32],"Colors - Page 1");
for(new g=0; g < 64; g++){
TextDrawShowForPlayer(playerid,colordraw[g]);}}
ShowMenuColor2(playerid){
TextDrawSetString(menuDraws[playerid][32],"Colors - Page 2");
for(new i=64; i < TOTAL_COLORS; i++){
TextDrawShowForPlayer(playerid,colordraw[i]);}}
UpdateColSel(playerid){}
UpdateCarmMenu(playerid){
  		TextDrawSetString(menuDraws[playerid][32],menuNames[playerid][0]);
		for(new i = itemStart[playerid][menuPlace[playerid]]; i < totalItems[playerid][menuPlace[playerid]]; i++){
		TextDrawHideForPlayer(playerid , menuDraws[playerid][i-itemStart[playerid][menuPlace[playerid]]]);
     	TextDrawSetString(menuDraws[playerid][i-itemStart[playerid][menuPlace[playerid]]], carDefines[i][namec]);
	    if(itemPlace[playerid][menuPlace[playerid]] == i){
			TextDrawColor( menuDraws[playerid][i-itemStart[playerid][menuPlace[playerid]]] , COLOR_WHITE);}
		else {
			TextDrawColor(menuDraws[playerid][i-itemStart[playerid][menuPlace[playerid]]], COLOR_LIGHTBLUE);}
		TextDrawShowForPlayer(playerid , menuDraws[playerid][i-itemStart[playerid][menuPlace[playerid]]]);
		}
}
UpdatecartypeMenu(playerid){
	for(new i = 0; i < MAX_TYPE_ITEMS; i++){
		//strmid(menutypeNames[playerid][i], carType[i][typeName], 0, 40);
		TextDrawHideForPlayer(playerid , menuDraws[playerid][i]);
		format(menutypeNames[playerid][i], 40, "%s", carType[i][typeName]);
     	TextDrawSetString(menuDraws[playerid][i], menutypeNames[playerid][i]);
	    if(itemPlace[playerid][menuPlace[playerid]] == i){
			TextDrawColor( menuDraws[playerid][i] , COLOR_WHITE);}
		else {
			TextDrawColor(menuDraws[playerid][i], COLOR_LIGHTBLUE);}
		TextDrawShowForPlayer(playerid , menuDraws[playerid][i]);
	}
}
UpdatespideyMenu(playerid){
//	strmid(menuNames[playerid][0], carType[itemPlace[playerid][0]][typeName], 0, 40, 40);
	TextDrawSetString(menuDraws[playerid][32], "Autohaus");
	format(menuNames[playerid][0], 40, "%s", carType[itemPlace[playerid][0]][typeName]);
	format(menuNames[playerid][1], 40, "%s", carDefines[itemPlace[playerid][1]][namec]);
	format(menuNames[playerid][2], 40, "COLOR1 - %d", itemPlace[playerid][2]);
	format(menuNames[playerid][3], 40, "COLOR2 - %d", itemPlace[playerid][3]);
	format(menuNames[playerid][4], 40, "Buy It!");
	format(menuNames[playerid][5], 40, "Exit");
	for(new i = 0; i < MAX_MENU_ITEMS; i++){
		TextDrawHideForPlayer(playerid , menuDraws[playerid][i]);
		TextDrawSetString(menuDraws[playerid][i], menuNames[playerid][i]);
	    if(menuPlace[playerid] == i){
			TextDrawColor(menuDraws[playerid][i], COLOR_WHITE);}
		else {
			TextDrawColor(menuDraws[playerid][i], COLOR_LIGHTBLUE);}
		TextDrawShowForPlayer(playerid , menuDraws[playerid][i]);
	}
}
ClearCarMenu(playerid){
	for (new i = 0; i < 30; i++){
		TextDrawSetString(menuDraws[playerid][i], " ");}}
CreateCarSMenu(playerid){
	if ( carsmenucreated==0 ){
		carsmenucreated=carsmenucreated+1;
	    colordraw[0] = TextDrawCreate(47.500000,140.000000,"  ");
	    colordraw[1] = TextDrawCreate(65.000000,140.000000,"  ");
	    colordraw[2] = TextDrawCreate(82.500000,140.000000,"  ");
	    colordraw[3] = TextDrawCreate(100.000000,140.000000,"  ");
	    colordraw[4] = TextDrawCreate(117.500000,140.000000,"  ");
	    colordraw[5] = TextDrawCreate(135.000000,140.000000,"  ");
	    colordraw[6] = TextDrawCreate(152.500000,140.000000,"  ");
	    colordraw[7] = TextDrawCreate(170.000000,140.000000,"  ");
	    colordraw[8] = TextDrawCreate(47.500000, 157.500000,"  ");
	    colordraw[9] = TextDrawCreate(65.000000, 157.500000,"  ");
	    colordraw[10] = TextDrawCreate(82.500000, 157.500000,"  ");
	    colordraw[11] = TextDrawCreate(100.000000, 157.500000,"  ");
	    colordraw[12] = TextDrawCreate(117.500000, 157.500000,"  ");
	    colordraw[13] = TextDrawCreate(135.000000, 157.500000,"  ");
	    colordraw[14] = TextDrawCreate(152.500000, 157.500000,"  ");
	    colordraw[15] = TextDrawCreate(170.000000, 157.500000,"  ");
	    colordraw[16] = TextDrawCreate(47.500000, 175.000000,"  ");
	    colordraw[17] = TextDrawCreate(65.000000, 175.000000,"  ");
	    colordraw[18] = TextDrawCreate(82.500000, 175.000000,"  ");
	    colordraw[19] = TextDrawCreate(100.000000, 175.000000,"  ");
	    colordraw[20] = TextDrawCreate(117.500000, 175.000000,"  ");
	    colordraw[21] = TextDrawCreate(135.000000, 175.000000,"  ");
	    colordraw[22] = TextDrawCreate(152.500000, 175.000000,"  ");
	    colordraw[23] = TextDrawCreate(170.000000, 175.000000,"  ");
	    colordraw[24] = TextDrawCreate(47.500000, 192.500000,"  ");
	    colordraw[25] = TextDrawCreate(65.000000, 192.500000,"  ");
	    colordraw[26] = TextDrawCreate(82.500000, 192.500000,"  ");
	    colordraw[27] = TextDrawCreate(100.000000, 192.500000,"  ");
	    colordraw[28] = TextDrawCreate(117.500000, 192.500000,"  ");
	    colordraw[29] = TextDrawCreate(135.000000, 192.500000,"  ");
	    colordraw[30] = TextDrawCreate(152.500000, 192.500000,"  ");
	    colordraw[31] = TextDrawCreate(170.000000, 192.500000,"  ");
	    colordraw[32] = TextDrawCreate(47.500000, 210.000000,"  ");
	    colordraw[33] = TextDrawCreate(65.000000, 210.000000,"  ");
	    colordraw[34] = TextDrawCreate(82.500000, 210.000000,"  ");
	    colordraw[35] = TextDrawCreate(100.000000, 210.000000,"  ");
	    colordraw[36] = TextDrawCreate(117.500000, 210.000000,"  ");
	    colordraw[37] = TextDrawCreate(135.000000, 210.000000,"  ");
	    colordraw[38] = TextDrawCreate(152.500000, 210.000000,"  ");
	    colordraw[39] = TextDrawCreate(170.000000, 210.000000,"  ");
	    colordraw[40] = TextDrawCreate(47.500000, 227.500000,"  ");
	    colordraw[41] = TextDrawCreate(65.000000, 227.500000,"  ");
	    colordraw[42] = TextDrawCreate(82.500000, 227.500000,"  ");
	    colordraw[43] = TextDrawCreate(100.000000, 227.500000,"  ");
	    colordraw[44] = TextDrawCreate(117.500000, 227.500000,"  ");
	    colordraw[45] = TextDrawCreate(135.000000, 227.500000,"  ");
	    colordraw[46] = TextDrawCreate(152.500000, 227.500000,"  ");
	    colordraw[47] = TextDrawCreate(170.000000, 227.500000,"  ");
	    colordraw[48] = TextDrawCreate(47.500000, 245.000000,"  ");
	    colordraw[49] = TextDrawCreate(65.000000, 245.000000,"  ");
	    colordraw[50] = TextDrawCreate(82.500000, 245.000000,"  ");
	    colordraw[51] = TextDrawCreate(100.000000, 245.000000,"  ");
	    colordraw[52] = TextDrawCreate(117.500000, 245.000000,"  ");
	    colordraw[53] = TextDrawCreate(135.000000, 245.000000,"  ");
	    colordraw[54] = TextDrawCreate(152.500000, 245.000000,"  ");
	    colordraw[55] = TextDrawCreate(170.000000, 245.000000,"  ");
	    colordraw[56] = TextDrawCreate(47.500000, 262.500000,"  ");
	    colordraw[57] = TextDrawCreate(65.000000, 262.500000,"  ");
	    colordraw[58] = TextDrawCreate(82.500000, 262.500000,"  ");
	    colordraw[59] = TextDrawCreate(100.000000, 262.500000,"  ");
	    colordraw[60] = TextDrawCreate(117.500000, 262.500000,"  ");
	    colordraw[61] = TextDrawCreate(135.000000, 262.500000,"  ");
	    colordraw[62] = TextDrawCreate(152.500000, 262.500000,"  ");
	    colordraw[63] = TextDrawCreate(170.000000, 262.500000,"  ");
	    colordraw[64] = TextDrawCreate(47.500000,140.000000,"  ");
	    colordraw[65] = TextDrawCreate(65.000000,140.000000,"  ");
	    colordraw[66] = TextDrawCreate(82.500000,140.000000,"  ");
	    colordraw[67] = TextDrawCreate(100.000000,140.000000,"  ");
	    colordraw[68] = TextDrawCreate(117.500000,140.000000,"  ");
	    colordraw[69] = TextDrawCreate(135.000000,140.000000,"  ");
	    colordraw[70] = TextDrawCreate(152.500000,140.000000,"  ");
	    colordraw[71] = TextDrawCreate(170.000000,140.000000,"  ");
	    colordraw[72] = TextDrawCreate(47.500000, 157.500000,"  ");
	    colordraw[73] = TextDrawCreate(65.000000, 157.500000,"  ");
	    colordraw[74] = TextDrawCreate(82.500000, 157.500000,"  ");
	    colordraw[75] = TextDrawCreate(100.000000, 157.500000,"  ");
	    colordraw[76] = TextDrawCreate(117.500000, 157.500000,"  ");
	    colordraw[77] = TextDrawCreate(135.000000, 157.500000,"  ");
	    colordraw[78] = TextDrawCreate(152.500000, 157.500000,"  ");
	    colordraw[79] = TextDrawCreate(170.000000, 157.500000,"  ");
	    colordraw[80] = TextDrawCreate(47.500000, 175.000000,"  ");
	    colordraw[81] = TextDrawCreate(65.000000, 175.000000,"  ");
	    colordraw[82] = TextDrawCreate(82.500000, 175.000000,"  ");
	    colordraw[83] = TextDrawCreate(100.000000, 175.000000,"  ");
	    colordraw[84] = TextDrawCreate(117.500000, 175.000000,"  ");
	    colordraw[85] = TextDrawCreate(135.000000, 175.000000,"  ");
	    colordraw[86] = TextDrawCreate(152.500000, 175.000000,"  ");
	    colordraw[87] = TextDrawCreate(170.000000, 175.000000,"  ");
	    colordraw[88] = TextDrawCreate(47.500000, 192.500000,"  ");
	    colordraw[89] = TextDrawCreate(65.000000, 192.500000,"  ");
	    colordraw[90] = TextDrawCreate(82.500000, 192.500000,"  ");
	    colordraw[91] = TextDrawCreate(100.000000, 192.500000,"  ");
	    colordraw[92] = TextDrawCreate(117.500000, 192.500000,"  ");
	    colordraw[93] = TextDrawCreate(135.000000, 192.500000,"  ");
	    colordraw[94] = TextDrawCreate(152.500000, 192.500000,"  ");
	    colordraw[95] = TextDrawCreate(170.000000, 192.500000,"  ");
	    colordraw[96] = TextDrawCreate(47.500000, 210.000000,"  ");
	    colordraw[97] = TextDrawCreate(65.000000, 210.000000,"  ");
	    colordraw[98] = TextDrawCreate(82.500000, 210.000000,"  ");
	    colordraw[99] = TextDrawCreate(100.000000, 210.000000,"  ");
	    colordraw[100] = TextDrawCreate(117.500000, 210.000000,"  ");
	    colordraw[101] = TextDrawCreate(135.000000, 210.000000,"  ");
	    colordraw[102] = TextDrawCreate(152.500000, 210.000000,"  ");
	    colordraw[103] = TextDrawCreate(170.000000, 210.000000,"  ");
	    colordraw[104] = TextDrawCreate(47.500000, 227.500000,"  ");
	    colordraw[105] = TextDrawCreate(65.000000, 227.500000,"  ");
	    colordraw[106] = TextDrawCreate(82.500000, 227.500000,"  ");
	    colordraw[107] = TextDrawCreate(100.000000, 227.500000,"  ");
	    colordraw[108] = TextDrawCreate(117.500000, 227.500000,"  ");
	    colordraw[109] = TextDrawCreate(135.000000, 227.500000,"  ");
	    colordraw[110] = TextDrawCreate(152.500000, 227.500000,"  ");
	    colordraw[111] = TextDrawCreate(170.000000, 227.500000,"  ");
	    colordraw[112] = TextDrawCreate(47.500000, 245.000000,"  ");
	    colordraw[113] = TextDrawCreate(65.000000, 245.000000,"  ");
	    colordraw[114] = TextDrawCreate(82.500000, 245.000000,"  ");
	    colordraw[115] = TextDrawCreate(100.000000, 245.000000,"  ");
	    colordraw[116] = TextDrawCreate(117.500000, 245.000000,"  ");
	    colordraw[117] = TextDrawCreate(135.000000, 245.000000,"  ");
	    colordraw[118] = TextDrawCreate(152.500000, 245.000000,"  ");
	    colordraw[119] = TextDrawCreate(170.000000, 245.000000,"  ");
	    colordraw[120] = TextDrawCreate(47.500000, 262.500000,"  ");
	    colordraw[121] = TextDrawCreate(65.000000, 262.500000,"  ");
	    colordraw[122] = TextDrawCreate(82.500000, 262.500000,"  ");
	    colordraw[123] = TextDrawCreate(100.000000, 262.500000,"  ");
	    colordraw[124] = TextDrawCreate(117.500000, 262.500000,"  ");
	    colordraw[125] = TextDrawCreate(135.000000, 262.500000,"  ");
	    colordraw[126] = TextDrawCreate(152.500000, 262.500000,"  ");
	    colordraw[127] = TextDrawCreate(170.000000, 262.500000,"  ");
		colordraw[128] = TextDrawCreate(32.500000,130.000000,"                                                                                                                                                                                                                        ");
		TextDrawBackgroundColor(colordraw[128], 0x000000ff);
		TextDrawSetProportional(colordraw[128],1);
		TextDrawFont(colordraw[128], 0);
		TextDrawAlignment(colordraw[128],0);
		TextDrawColor(colordraw[128], 0x0000ffcc);
		TextDrawLetterSize(colordraw[128], 1.000000, 1.000000);
		TextDrawSetShadow(colordraw[128],1);
		TextDrawTextSize(colordraw[128],172.500000,180.000000);
		TextDrawUseBox(colordraw[128],1);
		TextDrawBoxColor(colordraw[128], 0x00000066);
		for(new i=0; i < TOTAL_COLORS; i++){
			TextDrawAlignment(colordraw[i],2);
			TextDrawBackgroundColor(colordraw[i], 0x000000ff);
			TextDrawBoxColor(colordraw[i], CarColors[i][0]);
			TextDrawColor(colordraw[i], 0xffffffff);
			TextDrawFont(colordraw[i], 1);
			TextDrawLetterSize(colordraw[i], 1.000000, 1.000000);
			TextDrawSetOutline(colordraw[i],1);
			TextDrawSetProportional(colordraw[i],1);
			TextDrawSetShadow(colordraw[i],1);
			TextDrawTextSize(colordraw[i],10.000000,10.000000);
			TextDrawUseBox(colordraw[i],1);}
	}
	menuDraws[playerid][30] = TextDrawCreate(200.000000,127.500000,"    ");
	TextDrawUseBox(menuDraws[playerid][30],1);
	TextDrawBoxColor(menuDraws[playerid][30],0x00000099);
	TextDrawTextSize(menuDraws[playerid][30],40.000000,0.000000);
	TextDrawAlignment(menuDraws[playerid][30],0);
	TextDrawBackgroundColor(menuDraws[playerid][30],0x000000ff);
	TextDrawFont(menuDraws[playerid][30],3);
	TextDrawLetterSize(menuDraws[playerid][30],1.000000,2.95);
	TextDrawColor(menuDraws[playerid][30],0xffffffff);
	TextDrawSetOutline(menuDraws[playerid][30],0);
	TextDrawSetProportional(menuDraws[playerid][30],1);
	TextDrawSetShadow(menuDraws[playerid][30],1);
	TextDrawShowForPlayer(playerid , menuDraws[playerid][30]);
	menuDraws[playerid][31] = TextDrawCreate(360.000000,127.500000,"    ");
	TextDrawUseBox(menuDraws[playerid][31],1);
	TextDrawBoxColor(menuDraws[playerid][31],0x00000099);
	TextDrawTextSize(menuDraws[playerid][31],40.000000,0.000000);
	TextDrawAlignment(menuDraws[playerid][31],0);
	TextDrawBackgroundColor(menuDraws[playerid][31],0x000000ff);
	TextDrawFont(menuDraws[playerid][31],3);
	TextDrawLetterSize(menuDraws[playerid][31],1.000000,6.9);
	TextDrawColor(menuDraws[playerid][31],0xffffffff);
	TextDrawSetOutline(menuDraws[playerid][31],0);
	TextDrawSetProportional(menuDraws[playerid][31],1);
	TextDrawSetShadow(menuDraws[playerid][31],1);
	menuDraws[playerid][32] = TextDrawCreate(45.000000,115.000000,"Autohaus");
	TextDrawBackgroundColor(menuDraws[playerid][31], 0x000000ff);
	TextDrawColor(menuDraws[playerid][32], 0xffffffff);
	TextDrawAlignment(menuDraws[playerid][32],0);
	TextDrawFont(menuDraws[playerid][32], 0);
	TextDrawSetOutline(menuDraws[playerid][32],1);
	TextDrawSetProportional(menuDraws[playerid][32],1);
	TextDrawLetterSize(menuDraws[playerid][32], 1.300000, 1.600000);
	TextDrawSetShadow(menuDraws[playerid][32],1);
	TextDrawUseBox(menuDraws[playerid][32],0);
	TextDrawTextSize( menuDraws[playerid][32] , 300, 50);
	TextDrawShowForPlayer(playerid , menuDraws[playerid][32]);

	for (new k = 0; k < 15; k++){
		menuDraws[playerid][k] = TextDrawCreate(50, (135+(k*12)),"  ");
		TextDrawUseBox( menuDraws[playerid][k] , 0);
		TextDrawAlignment(menuDraws[playerid][k],1);
		TextDrawBackgroundColor(menuDraws[playerid][k], 0x000000ff);
		TextDrawFont(menuDraws[playerid][k], 1);
		TextDrawSetShadow(menuDraws[playerid][k],1);
		TextDrawSetProportional(menuDraws[playerid][k],1);
		TextDrawSetOutline(menuDraws[playerid][k],1);
		TextDrawLetterSize(menuDraws[playerid][k], 0.8, 0.8);
		TextDrawTextSize( menuDraws[playerid][k] , MENU_WIDTH, MENU_HEIGHT);}
	for (new l = 15; l < 30; l++){
		menuDraws[playerid][l] = TextDrawCreate(200, (135+((l-15)*12)),"  ");
		TextDrawUseBox(menuDraws[playerid][l] , 0);
		TextDrawAlignment(menuDraws[playerid][l],1);
		TextDrawBackgroundColor(menuDraws[playerid][l], 0x000000ff);
		TextDrawFont(menuDraws[playerid][l], 1);
		TextDrawSetShadow(menuDraws[playerid][l],1);
		TextDrawSetOutline(menuDraws[playerid][l],1);
		TextDrawSetProportional(menuDraws[playerid][l],1);
		TextDrawLetterSize(menuDraws[playerid][l], 0.8, 0.8);
		TextDrawTextSize( menuDraws[playerid][l] , MENU_WIDTH, MENU_HEIGHT);}
	for(new j = 0; j < 30; j++){
		TextDrawShowForPlayer(playerid , menuDraws[playerid][j]);}
}
public UpdateCar( playerid ){
	new jojo[256];
	if(carSelect[playerid]==0){
		while (VehicleInfo[playerCar[playerid]][CREATED]) {
			playerCar[playerid]++;}
	}
	format(jojo, sizeof(jojo), "Playercar: %d", playerCar[playerid]);
	SendClientMessage(playerid, COLOR_YELLOW, jojo);
	if( destroyCar[playerid][1] == true ){
		DestroyStreamVehicle(VehStreamid[VehicleInfo[playerCar[playerid]][idnum]]); // Destroy the Car in menu and creates the next one
		SendClientMessage(playerid, COLOR_YELLOW, "TempCar destroyed");
	}
	CreateStreamVehicle( carDefines[itemPlace[playerid][1]][ID], PlayerPos[playerid][0], PlayerPos[playerid][1], PlayerPos[playerid][2], PlayerPos[playerid][3], 0, itemPlace[playerid][3]);
	format(jojo, sizeof(jojo), "Model: %d PlayerPos: %f %f %f Farbe: %d / %d", carDefines[itemPlace[playerid][1]][ID], PlayerPos[playerid][0], PlayerPos[playerid][1], PlayerPos[playerid][2], PlayerPos[playerid][3], 0, itemPlace[playerid][3]);
	SendClientMessage(playerid, COLOR_YELLOW, jojo);
	SetTimerEx("UpdateCar2", 3000, 0, "i",playerid);
	destroyCar[playerid][1] = true;
}
public UpdateCar2(playerid){
	TogglePlayerSpectating(playerid, 1);
	LockCarForAll( VehStreamid[VehicleInfo[playerCar[playerid]][idnum]], true );
	PlayerSpectateVehicle(playerid, VehicleInfo[playerCar[playerid]][idnum], SPECTATE_MODE_NORMAL);
	format(str, sizeof(str), "Streamid: %d", VehStreamid[VehicleInfo[playerCar[playerid]][idnum]]);
	SendClientMessage(playerid, COLOR_YELLOW, str);
}
//$ endregion carmod-textdrawupdate
public Menutimer(){
	new Keys[3];
	new string3[256];
	for (new i = 0; i < MAX_PLAYERS; i++){
	if(gasselect[i]==1){
		new string2[255];
		new string[255];
		new tmp2[255];
		new vid = GetPlayerVehicleID(i);
		new wm = GetVehicleModel(vid);
		GetPlayerKeys(i, Keys[0], Keys[1], Keys[2]);
		format(string3, 256, "%d %d %d", Keys[0],Keys[1],Keys[2]);
		SendClientMessage(i, COLOR_RED, string3);
		for (new h=0;h<MAX_CARS;h++){
		if (carDefines[h][ID]==wm){
			if(Keys[1] == KEY_UP){
		        menuPlace2[i] = menuPlace2[i]-1;
				if(menuPlace2[i] < 0){ menuPlace2[i] = MAX_MENUG_ITEMS-1;}
                DestroyMenuGas(i);
				UpdategasMenu(i);}
			if(Keys[1] == KEY_DOWN ){
		        menuPlace2[i] = menuPlace2[i]+1;
				if(menuPlace2[i] > MAX_MENUG_ITEMS-1){ menuPlace2[i] = 0;}
                DestroyMenuGas(i);
				UpdategasMenu(i);
		 	}
			if(Keys[2] == KEY_RIGHT ){
			if(menuPlace2[i]==1){
				liters[i] = liters[i]+1;
				if(liters[i] + VehicleInfo[VehStreamid[vid]][tank]/1000000 > carDefines[h][Tank]/10){
				liters[i]=0;
				format(tmp2, sizeof(tmp2), "Your car can only take %d Liters.", carDefines[h][Tank]/10);
				SendClientMessage(i, COLOR_YELLOW, tmp2);}
                DestroyMenuGas(i);
				UpdategasMenu(i);
	 		}}
			if(Keys[2] == KEY_LEFT ){
			if(menuPlace2[i]==1){
				liters[i] = liters[i]-1;
				if(liters[i] < 0){
				liters[i] = ((carDefines[h][Tank]-VehicleInfo[VehStreamid[vid]][tank]/100000)/10 + 1);}
                DestroyMenuGas(i);
				UpdategasMenu(i);}}
            if(Keys[0] == KEY_SPRINT ){
				if (menuPlace2[i]==0){
    				if (VehicleInfo[VehStreamid[vid]][tank]/100000 ==  carDefines[h][Tank])					{
					SendClientMessage(i, COLOR_RED, "This car is already refuelled.");
					TogglePlayerControllable(i,true);
					DestroyMenuGas(i);
					menuPlace2[i]=0;
					justbought[i]=1;
					gasselect[i]=0;
					SetTimerEx("justbdown", 15000, 0, "y",i);
					return 1;
					}
					new cant = (carDefines[h][Tank]-VehicleInfo[VehStreamid[vid]][tank]/100000)/10;
					if (PRECIOLITRO*cant>GetPlayerMoney(i))
					{
					SendClientMessage(i, COLOR_RED, "You don't have enough money..");
					return 1;}
      		 		VehicleInfo[VehStreamid[vid]][tank]=VehicleInfo[VehStreamid[vid]][tank]+cant*1000000;
    				GivePlayerMoney(i,PRECIOLITRO*cant*-1);
					format(string2, sizeof(string2), "Your car has been refuelled with %d liters. The tank is full.", cant);
					SendClientMessage(i, COLOR_YELLOW, string2);
					format(string, sizeof(string), "Fuel:%d L", VehicleInfo[VehStreamid[vid]][tank]/1000000);
					TextDrawSetString(SpeedoString[i][0],string);
					menuPlace2[i]=0;
					justbought[i]=1;
					TogglePlayerControllable(i,true);
					SetTimerEx("justbdown", 15000, 0, "y",i);
					DestroyMenuGas(i);
					gasselect[i]=0;}
				if (menuPlace2[i]==1){
					if (PRECIOLITRO*liters[i]>GetPlayerMoney(i))
	    			{
       					SendClientMessage(i, COLOR_RED, "You don't have enough money.");
        				//TogglePlayerControllable(i,true);
						return 1;
		    		}
			        VehicleInfo[VehStreamid[vid]][tank]=VehicleInfo[VehStreamid[vid]][tank]+(liters[i]*1000000);
			        GivePlayerMoney(i,PRECIOLITRO*liters[i]*-1);
					format(string, sizeof(string), "You bought %d liters of fuel, the tank is full", liters[i]);
					format(string2, sizeof(string2), "Your car has been refuelled with %d liters of fuel, the tank is full", liters[i]);
					SendClientMessage(i, COLOR_YELLOW, string2);
					liters[i] = 0;
					format(string, sizeof(string), "Fuel:%d L", VehicleInfo[VehStreamid[vid]][tank]/1000000);
//					TankString[i]=string;
//					format(tmp, sizeof(tmp),"%s %s %s %s",TankString[i],SpeedString[i],KMString[i], OilString[i]);
					TextDrawSetString(SpeedoString[i][0],string);
       		 		TogglePlayerControllable(i,true);
					menuPlace2[i]=0;
					justbought[i]=1;
					SetTimerEx("justbdown", 15000, 0, "y",i);
					DestroyMenuGas(i);
					gasselect[i]=0;	}
				if (menuPlace2[i]==2){
					TogglePlayerControllable(i,true);
					menuPlace2[i]=0;
					justbought[i]=1;
					SetTimerEx("justbdown", 15000, 0, "y",i);
					DestroyMenuGas(i);
					gasselect[i]=0;}
			}
}}}
	}
	return 1;
}
public justbdown(playerid){
		justbought[playerid]=0;
}
UpdategasMenu(playerid){
		format(menuliter[playerid][0], 40, "Full Tank");
		format(menuliter[playerid][1], 40, "Refuel: %d L", liters[playerid]);
		format(menuliter[playerid][2], 40, "Exit");
        menuDraws2[playerid][3] = TextDrawCreate(45.00000,195.000000,"                                                                                         ");
        TextDrawAlignment(menuDraws2[playerid][3],0);
		TextDrawBackgroundColor(menuDraws2[playerid][3], 0x000000ff);
		TextDrawBoxColor(menuDraws2[playerid][3], 0x00000066);
		TextDrawColor(menuDraws2[playerid][3], 0x0000ffcc);
		TextDrawFont(menuDraws2[playerid][3], 0);
		TextDrawUseBox(menuDraws2[playerid][3],1);
		TextDrawTextSize(menuDraws2[playerid][3],205.000000,110.000000);
		TextDrawSetShadow(menuDraws2[playerid][3],1);
		TextDrawSetProportional(menuDraws2[playerid][3],1);
		TextDrawLetterSize(menuDraws2[playerid][3], 1.000000, 1.000000);
		TextDrawShowForPlayer(playerid,menuDraws2[playerid][3]);
		for(new i = 0; i < MAX_MENUG_ITEMS; i++){
     	menuDraws2[playerid][i] = TextDrawCreate( 50, (200 +(i * 15)), menuliter[playerid][i]);
      	TextDrawUseBox(menuDraws2[playerid][i],0);
		TextDrawAlignment(menuDraws2[playerid][i],1);
		TextDrawBackgroundColor(menuDraws2[playerid][i],0x000000ff);
		TextDrawFont(menuDraws2[playerid][i],1);
		TextDrawLetterSize(menuDraws2[playerid][i],0.9,0.9);
		TextDrawSetProportional(menuDraws2[playerid][i],1);
		TextDrawSetShadow(menuDraws2[playerid][i],1);
	    if(menuPlace2[playerid] == i){
	        TextDrawColor(menuDraws2[playerid][i] , COLOR_WHITE);}
		else {
			TextDrawColor(menuDraws2[playerid][i], COLOR_LIGHTBLUE);}
		TextDrawShowForPlayer(playerid , menuDraws2[playerid][i]);
		}
}
DestroyMenuGas(playerid){
	for(new i = 0; i < MAX_MENUG_ITEMS+1; i++){
	     TextDrawDestroy(menuDraws2[playerid][i]);	}
}
FlagVehicleDestroy( vehicleid ){
	SetVehicleToRespawn(vehicleid);
	SetTimerEx("DestroyVehicleEx", 250, false, "i", vehicleid);
}
public DestroyVehicleEx( vehicleid ){
	for(new i = 0; i < GetMaxPlayers(); i++){
	    if(IsPlayerConnected(i)){
	    	if(IsPlayerInVehicle(i,vehicleid)){
	    	    FlagVehicleDestroy(vehicleid);
	    	    return 1;
			}
		}
	}
	DestroyVehicle(vehicleid);
	return 1;
}
public DestroyVehicleEx2( vehicleid ){
	for(new i = 0; i < GetMaxPlayers(); i++){
	    if(IsPlayerConnected(i)){
	    	if(!IsPlayerInVehicle(i,vehicleid)){
	    	    DestroyStreamVehicle(VehStreamid[vehicleid]);
			}
		}
	}
	return 1;
}
stock GetDistanceBetweenVehicles(vehicleid, vehicleid2){
        new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
        new Float:tmpdis;
        GetVehiclePos(vehicleid,x1,y1,z1);
        GetVehiclePos(vehicleid2,x2,y2,z2);
        tmpdis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
        return floatround(tmpdis);
}
Float:GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance){
	new Float:a ,Float:z;
	GetPlayerPos(playerid, x, y, z);
	if (IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	else GetPlayerFacingAngle(playerid, a);
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
	return z;
}
stock GetVehicleWithinDistance(playerid, Float:x1, Float:y1, Float:z1, Float:dist, &veh){
	for(new i = 1; i < MAX_VEHICLES; i++){
		if(GetVehicleModel(i) > 0){
			if(GetPlayerVehicleID(playerid) != i ){
	        	new Float:x, Float:y, Float:z;
	        	new Float:x2, Float:y2, Float:z2;
				GetVehiclePos(i, x, y, z);
				x2 = x1 - x; y2 = y1 - y; z2 = z1 - z;
				new Float:vDist = (x2*x2+y2*y2+z2*z2);
				printf("vehicle %d is %f", i, vDist);

				if( vDist < dist){
					veh = i;
				}			}		}	}}
LoadCarDefines(fileName[255]){
	if(fexist(fileName)){
	    new File:cDefines = fopen(fileName, io_read);
	    new line[255], i = 0, j=0;
	    while( fread(cDefines, line))
	    {
	        if(!strcmp( line[0], "*", true, 1)){
	            new tmp2[40];
	        	strmid(tmp2, line, 1,40);
				strcat(carType[j][typeName], tmp2, 40);
				carType[j][typeStart] = i;

				if(j != 0){
				    carType[j-1][typeEnd] = i;
//				    printf("CarType End %d - %d , %s", j-1, carType[j-1][typeEnd], carType[j-1][typeName]);
				   // new heap = heapspace();
				   // printf("HeapSpace - %d", heap);
				}
				j++;
			}

	        else{
	        	new name2[255],  modelid, tmp[255], fuelv, tank3, price, idx;
				tmp = strtok(line, idx);
	        	modelid = strval(tmp);
	        	carDefines[i][ID] = modelid;
				name2  = strtok(line, idx);
				strcat(carDefines[i][namec], name2, 255);
				tmp = strtok(line, idx);
				price = strval(tmp);
				carDefines[i][Price] = price;
				tmp = strtok(line, idx);
				fuelv = strval(tmp);
				carDefines[i][Fuel] = fuelv;
				tmp = strtok(line, idx);
				tank3 = strval(tmp);
				carDefines[i][Tank] = tank3;
//				printf("ID: %d   Name: %s   Price: %d   Fuel: %d   Tank: %d   \n", carDefines[i][ID], carDefines[i][namec], carDefines[i][Price], carDefines[i][Fuel], carDefines[i][Tank]);
	        	i++;
			}
		}
		carType[j-1][typeEnd] = i;
		printf("CarType End %d - %d", j-1, carType[j-1][typeEnd]);
		for(new h= 0; h < GetMaxPlayers(); h++){
		    totalItems[h][0] = j;
		}
		printf("Total Cars Loaded - %d", i);
		printf("Total Car Types Loaded - %d", j);
	}
}
LoadTotalItems(){
	for(new i = 0; i < MAX_PLAYERS; i++){
	    totalItems[i][1] = carType[0][typeEnd];
	    totalItems[i][2] = TOTAL_COLORS;
	    totalItems[i][3] = TOTAL_COLORS;
	}
}
LockCarForAll(svehicleid, bool:lock){
	for(new i = 0; i < GetMaxPlayers(); i++ ){
		SetStreamVehicleParamsForPlayer(svehicleid, i, false, lock);
	}
}
public checkpointupdate(){
        for(new i=0; i<MAX_PLAYERS; i++)
        {
            if(IsPlayerConnected(i)) {
                for(new j=0; j < MAX_POINTS; j++) {
                    if(PlayerToPoint(4, i, checkpoints[j][0],checkpoints[j][1],checkpoints[j][2])&&justbought[i]==0) {
                        if(playerCheckpoint[i]!=j) {
                            DisablePlayerCheckpoint(i);
                            SetPlayerCheckpoint(i, checkpoints[j][0],checkpoints[j][1],checkpoints[j][2],5);
                            playerCheckpoint[i] = j;
                        }}
					else {
                        if(playerCheckpoint[i]==j) {
                            DisablePlayerCheckpoint(i);
                            playerCheckpoint[i] = 999;}}		}}	}}
public getCheckpointType(playerID) {
        return checkpointType[playerCheckpoint[playerID]];
}
public Speedometer(){
	new tmp[255];
	new string[255];
	new stringi[255];
	new stringj[255];
	new Hour, Min, Sec, TimeString[256], TimeString2[256],TimeString3[256];
	new day, month, year;
	new Float:v;
	new Float:HUNGERHPLOSS;
	new Float:THIRSTHPLOSS;
	new Float:SEXHPLOSS;
	getdate( year, month, day );
	gettime(Hour, Min, Sec);
	format(TimeString3,256,"%d:%d %d",month,day,year);
	if (Min <= 9){format(TimeString,25,"%d:0%d",Hour, Min);}
	else{format(TimeString,256,"%d:%d",Hour, Min);}
	if (Sec <= 9){format(TimeString2,25,"0%d",Sec);}
	else{format(TimeString2,256,"%d",Sec);}
	TextDrawSetString(TimeHour,TimeString);
	TextDrawSetString(TimeSec,TimeString2);
	TextDrawSetString(TimeYear,TimeString3);
	for(new j = 0; j < MAX_VEHICLES;j++){
		for (new h=0;h<MAX_CARS;h++){
			if (carDefines[h][ID]== GetVehicleModel(j)){
				/* && enginestatus[j]==1*/
				if (VehicleInfo[VehStreamid[j]][tank]>0){VehicleInfo[VehStreamid[j]][tank] = VehicleInfo[VehStreamid[j]][tank]-(carDefines[h][Fuel]);}
                if (VehicleInfo[VehStreamid[j]][oilpress]==0){VehicleInfo[VehStreamid[j]][oilminimum]=300; VehicleInfo[VehStreamid[j]][oilpress]=VehicleInfo[VehStreamid[j]][oilminimum];}
				else if (VehicleInfo[VehStreamid[j]][oilpress]> 400 && VehicleInfo[VehStreamid[j]][oilpress]<=500 && VehicleInfo[VehStreamid[j]][oilminimum]<350){ VehicleInfo[VehStreamid[j]][oilminimum]=350;}
				else if (VehicleInfo[VehStreamid[j]][oilpress]> 500 && VehicleInfo[VehStreamid[j]][oilpress]<=600 && VehicleInfo[VehStreamid[j]][oilminimum]<425){ VehicleInfo[VehStreamid[j]][oilminimum]=425;}
				else if (VehicleInfo[VehStreamid[j]][oilpress]> 600 && VehicleInfo[VehStreamid[j]][oilpress]<=700 && VehicleInfo[VehStreamid[j]][oilminimum]<500){ VehicleInfo[VehStreamid[j]][oilminimum]=500;}
				else if (VehicleInfo[VehStreamid[j]][oilpress]> 700 && VehicleInfo[VehStreamid[j]][oilpress]<=800 && VehicleInfo[VehStreamid[j]][oilminimum]<575){ VehicleInfo[VehStreamid[j]][oilminimum]=575;}
				else if (VehicleInfo[VehStreamid[j]][oilpress]> 800 && VehicleInfo[VehStreamid[j]][oilpress]<=900 && VehicleInfo[VehStreamid[j]][oilminimum]<650){ VehicleInfo[VehStreamid[j]][oilminimum]=650;}
				else if (VehicleInfo[VehStreamid[j]][oilpress]> 900 && VehicleInfo[VehStreamid[j]][oilpress]<=999 && VehicleInfo[VehStreamid[j]][oilminimum]<725){ VehicleInfo[VehStreamid[j]][oilminimum]=725;}
				if (VehicleInfo[VehStreamid[j]][oilpress]>VehicleInfo[VehStreamid[j]][oilminimum] && VehicleInfo[VehStreamid[j]][oildamage]==0){VehicleInfo[VehStreamid[j]][oilpress]=VehicleInfo[VehStreamid[j]][oilpress]-2;}
				else if (VehicleInfo[VehStreamid[j]][oilpress]>VehicleInfo[VehStreamid[j]][oilminimum] && VehicleInfo[VehStreamid[j]][oildamage]==1){VehicleInfo[VehStreamid[j]][oilpress]=VehicleInfo[VehStreamid[j]][oilpress]-1;}
			}}}
	for(new i = 0; i < MAX_PLAYERS; i++){
		if(IsPlayerConnected(i)){
		// SpeedoInfo[i][speed] wird für jeden spieler jede sekunde berechnet
		CalculateSpeed(i);
		GetPlayerHealth(i, v);
		//--- Thirst ---
		if ( THIRSTY[i] < 100 )	{
		   THIRSTY[i] = THIRSTY[i] + 0.01;	}
		if (THIRSTY[i] >=20 && THIRSTY[i] <=40){
			THIRSTHPLOSS = 0.1;}
		else if (THIRSTY[i] >40 && THIRSTY[i] <=60){
			THIRSTHPLOSS = 0.2;}
		else if (THIRSTY[i] >60 && THIRSTY[i] <=80){
			THIRSTHPLOSS = 0.3;}
		else if (THIRSTY[i] >80 && THIRSTY[i] <=100){
			THIRSTHPLOSS = 0.4;}
			THIRSTHP[i] = THIRSTHP[i]+THIRSTHPLOSS;
		//--- Hunger ---
		if ( HUNGRY[i] < 100 )	{
		HUNGRY[i] = HUNGRY[i] + 0.01;	}
		if (HUNGRY[i] >=20 && HUNGRY[i] <=40){
		HUNGERHPLOSS = 0.1;}
		else if (HUNGRY[i] >40 && HUNGRY[i] <=60){
		HUNGERHPLOSS = 0.2;}
		else if (HUNGRY[i] >60 && HUNGRY[i] <=80){
		HUNGERHPLOSS = 0.3;}
		else if (HUNGRY[i] >80 && HUNGRY[i] <=100){
		HUNGERHPLOSS = 0.4;}
		HUNGERHP[i] = HUNGERHP[i]+HUNGERHPLOSS;
		//--- SEX ---
		if ( SEXY[i] < 100 )	{
		SEXY[i] = SEXY[i] + 0.01;	}
		if (SEXY[i] >=20 && SEXY[i] <=40){
		SEXHPLOSS = 0.1;}
		else if (SEXY[i] >40 && SEXY[i] <=60){
		SEXHPLOSS = 0.2;}
		else if (SEXY[i] >60 && SEXY[i] <=80){
		SEXHPLOSS = 0.3;}
		else if (SEXY[i] >80 && SEXY[i] <=100){
		SEXHPLOSS = 0.4;}
		SEXHP[i] = SEXHP[i]+SEXHPLOSS;
		if ( v > 1 ){
			//SetPlayerHealth(i, v-THIRSTHPLOSS-HUNGERHPLOSS-SEXHPLOSS);
		}
		seclevup[i] = seclevup[i] + 1;
		if(seclevup[i] == 60){
			giveRespectpoints[i] = giveRespectpoints[i] + 1;
			minlevup[i]=minlevup[i]+1;
			seclevup[i] = 0;}
		if(minlevup[i] == 60){
			Hourlevel[i]=Hourlevel[i]+1;
			minlevup[i] = 0;}
		if(Playerlevel[i] == 0){
			NeededHour[i]=4;
			NeededlevCash[i]=10000;
			//NeededR[i];
			}
		if(Hourlevel[i]==NeededHour[i]){
			//&& Respect[i]=NeededR[i]
			Hourlevel[i] = 0;
			Playerlevel[i] = Playerlevel[i] + 1;
			NeededHour[i]=NeededHour[i]+2;
			NeededlevCash[i] = NeededlevCash[i] + 10000 * (NeededlevCash[i]/10000 + Playerlevel[i]/NeededHour[i]);}
		if(GetPlayerState(i) == PLAYER_STATE_DRIVER){
				new wid = GetPlayerVehicleID(i);
				new wm = GetVehicleModel(wid);
				for (new h=0;h<MAX_CARS;h++){
					if (carDefines[h][ID]==wm && Speedom[i]>0 && VehicleInfo[VehStreamid[wid]][tank]>0){
								VehicleInfo[VehStreamid[wid]][meters] = VehicleInfo[VehStreamid[wid]][meters] + (Speedom[i]);
								VehicleInfo[VehStreamid[wid]][tank] = VehicleInfo[VehStreamid[wid]][tank]-(carDefines[h][Fuel]*Speedom[i]);	}}

		switch(SpeedoInfo[i][metric]){
		case true : {
			format(tmp, sizeof(tmp), "Km /h:%d", (Speedo[i]));
			format(stringi, sizeof(stringi), "KM : %d", VehicleInfo[VehStreamid[wid]][meters]/1000);}
		case false: {
			format(tmp, sizeof(tmp), "M /h:%d", floatround((Speedo[i])/1.6));
			format(stringi, sizeof(stringi), "Miles : %d", VehicleInfo[VehStreamid[wid]][meters]/1600);}}

		if (Speedo[i]>=25 && Speedo[i]<50){VehicleInfo[VehStreamid[wid]][oilpress]=VehicleInfo[VehStreamid[wid]][oilpress]+1;}
		else if (Speedo[i]>=50 && Speedo[i]<100){VehicleInfo[VehStreamid[wid]][oilpress]=VehicleInfo[VehStreamid[wid]][oilpress]+2;}
		else if (Speedo[i]>=100 && Speedo[i]<170){VehicleInfo[VehStreamid[wid]][oilpress]=VehicleInfo[VehStreamid[wid]][oilpress]+3;}
		else if (Speedo[i]>=170){VehicleInfo[VehStreamid[wid]][oilpress]=VehicleInfo[VehStreamid[wid]][oilpress]+4;}
		if (VehicleInfo[VehStreamid[wid]][tank]<=0){
			format(string, sizeof(string), "EM PTY");
			if (VehicleInfo[VehStreamid[wid]][messagesend3]==0) {
				SendClientMessage(i, COLOR_YELLOW, "U ran out of gas. Call a mechanic to tow away ur car to the next gas-station");
				VehicleInfo[VehStreamid[wid]][messagesend3]=1;}
				SinGas[i]=wid;
				TogglePlayerControllable(i,false);
				VehicleInfo[VehStreamid[wid]][tank]=0;}
		else if (VehicleInfo[VehStreamid[wid]][tank]<50000000) {
			if (VehicleInfo[VehStreamid[wid]][messagesend2]==0){
			SendClientMessage(i, COLOR_YELLOW, "Ur gas is running low. Drive to the next gas-station to refuel.");
			VehicleInfo[VehStreamid[wid]][messagesend2]=1;}
			format(string, sizeof(string), "Fuel:%d L", VehicleInfo[VehStreamid[wid]][tank]/1000000);
			VehicleInfo[VehStreamid[wid]][messagesend3]=0;}
		else if (VehicleInfo[VehStreamid[wid]][tank]>=50000000 ){
			if (VehicleInfo[VehStreamid[wid]][messagesend2]==1){
			VehicleInfo[VehStreamid[wid]][messagesend2]=0;}
			format(string, sizeof(string), "Fuel:%d L", VehicleInfo[VehStreamid[wid]][tank]/1000000);
			VehicleInfo[VehStreamid[wid]][messagesend3]=0;}
		if (VehicleInfo[VehStreamid[wid]][oilpress]<=880){
				if (VehicleInfo[VehStreamid[wid]][oildamage]==1 && VehicleInfo[VehStreamid[wid]][messagesend]==0){
				SendClientMessage(i, COLOR_YELLOW, "Car cooled down. Drive slowly to avoide raising the Oilpressure.");
				VehicleInfo[VehStreamid[wid]][messagesend]=1;
				TogglePlayerControllable(i,true);}}
				else if (VehicleInfo[VehStreamid[wid]][oilpress]>880 && VehicleInfo[VehStreamid[wid]][oilpress]<1000){
				if (VehicleInfo[VehStreamid[wid]][oildamage]==1 && VehicleInfo[VehStreamid[wid]][messagesend]==0){
					SendClientMessage(i, COLOR_YELLOW, "The engine is still cooling down. Wait a little bit longer.");
					TogglePlayerControllable(i,false);
					SinGas[i]=wid;}}
					else if (VehicleInfo[VehStreamid[wid]][oilpress]>=1000){
				VehicleInfo[VehStreamid[wid]][oildamage] = VehicleInfo[VehStreamid[wid]][oildamage]+1;
				VehicleInfo[VehStreamid[wid]][oilpress]=990;
				if (VehicleInfo[VehStreamid[wid]][oildamage]==1){
				SendClientMessage(i, COLOR_YELLOW, "U wrecked the car. The Oilpump is damaged. Turn off the engine to prevent damage to the car.");
				SendClientMessage(i, COLOR_YELLOW, "The engine must cool down for 2mins. After that its recommended to drive slowly and let it repair as quickly as possible.");
				VehicleInfo[VehStreamid[wid]][messagesend]=1;
				TogglePlayerControllable(i,false);
				SinGas[i]=wid;}
			 	if (VehicleInfo[VehStreamid[wid]][oildamage]==2){
				SendClientMessage(i, COLOR_YELLOW, "U wrecked the car total. The Oilpump catched fire. U have 5sec to leave before the car explode!!!");
				TogglePlayerControllable(i,false);
				SinGas[i]=wid;}}
		format(stringj, sizeof(stringj), "Oil: %d%", VehicleInfo[VehStreamid[wid]][oilpress]/10);
		TextDrawSetString(SpeedoString[i][0],string);
		TextDrawSetString(SpeedoString[i][1],tmp);
		TextDrawSetString(SpeedoString[i][2],stringi);
		TextDrawSetString(SpeedoString[i][3],stringj);
		return 1;
		}
//		Speedo[i] = 0;
//		Speedom[i] = 0;
		}
	}
	return 1;
}
public VEHICLEHEALTH(){
for(new i=0; i<MAX_PLAYERS; i++){
TextDrawHideForPlayer(i,vehiclebar[0]);
TextDrawHideForPlayer(i,vehiclebar[1]);
TextDrawHideForPlayer(i,vehiclebar[2]);
TextDrawHideForPlayer(i,vehiclebar[3]);
TextDrawHideForPlayer(i,vehiclebar[4]);
TextDrawHideForPlayer(i,vehiclebar[5]);
TextDrawHideForPlayer(i,vehiclebar[6]);
TextDrawHideForPlayer(i,vehiclebar[7]);
TextDrawHideForPlayer(i,vehiclebar[8]);
TextDrawHideForPlayer(i,vehiclebar[9]);
TextDrawHideForPlayer(i,vehiclebar[10]);
TextDrawHideForPlayer(i,vehiclebar[11]);
if(IsPlayerInAnyVehicle(i) == 1 && playervehiclebar[i] == 1){
TextDrawShowForPlayer(i,vehiclebar[0]);
TextDrawShowForPlayer(i,vehiclebar[1]);
new vehicleid2;
vehicleid2 = GetPlayerVehicleID(i);
new vhp;
//new Float:vhp2;
GetVehicleHealth(vehicleid2,vhp);
if(vhp >= 0 && vhp <= 1133903872){
}else if(vhp >= 1133903873 && vhp <= 1134723072){
TextDrawShowForPlayer(i,vehiclebar[2]);
}else if(vhp >= 1134723073 && vhp <= 1137180672){
TextDrawShowForPlayer(i,vehiclebar[3]);
}else if(vhp >= 1137180673 && vhp <= 1139638272){
TextDrawShowForPlayer(i,vehiclebar[4]);
}else if(vhp >= 1139638273 && vhp <= 1141473280){
TextDrawShowForPlayer(i,vehiclebar[5]);
}else if(vhp >= 1141473281 && vhp <= 1142702080){
TextDrawShowForPlayer(i,vehiclebar[6]);
}else if(vhp >= 1142702081 && vhp <= 1143930880){
TextDrawShowForPlayer(i,vehiclebar[7]);
}else if(vhp >= 1143930880 && vhp <= 1145159680){
TextDrawShowForPlayer(i,vehiclebar[8]);
}else if(vhp >= 1145159681 && vhp <= 1146388480){
TextDrawShowForPlayer(i,vehiclebar[9]);
}else if(vhp >= 1146388481 && vhp <= 1147617280){
TextDrawShowForPlayer(i,vehiclebar[10]);
}else if(vhp >= 1147617281 && vhp <= 1148846080){
TextDrawShowForPlayer(i,vehiclebar[11]);
/*if(vhp >= 0 && vhp <= 9){
}else if(vhp > 9 && vhp <= 18){
TextDrawShowForPlayer(i,vehiclebar[2]);
}else if(vhp > 18 && vhp <= 28){
TextDrawShowForPlayer(i,vehiclebar[3]);
}else if(vhp > 28 && vhp <= 37){
TextDrawShowForPlayer(i,vehiclebar[4]);
}else if(vhp > 37 && vhp <= 46){
TextDrawShowForPlayer(i,vehiclebar[5]);
}else if(vhp > 46 && vhp <= 55){
TextDrawShowForPlayer(i,vehiclebar[6]);
}else if(vhp > 55 && vhp <= 64){
TextDrawShowForPlayer(i,vehiclebar[7]);
}else if(vhp > 64 && vhp <= 73){
TextDrawShowForPlayer(i,vehiclebar[8]);
}else if(vhp > 73 && vhp <= 82){
TextDrawShowForPlayer(i,vehiclebar[9]);
}else if(vhp > 82 && vhp <= 91){
TextDrawShowForPlayer(i,vehiclebar[10]);
}else if(vhp > 91 && vhp <= 100){
TextDrawShowForPlayer(i,vehiclebar[11]);
new tnp[255];
format(tnp,sizeof(tnp), "%d VEHICLEHEALTH", vhp);
SendClientMessage(i, COLOR_YELLOW, tnp);*/
}}}
return 1;
}
//$ region Object-Selector
	public NextObject(oid){
		new cid;
		switch(oid){
			case 902:{cid = 903;}// file: 1
			case 903:{cid = 953;}// file: 1
			case 953:{cid = 1461;}// file: 1
			case 1461:{cid = 1598;}// file: 1
			case 1598:{cid = 1599;}// file: 1
			case 1599:{cid = 1600;}// file: 1
			case 1600:{cid = 1601;}// file: 1
			case 1601:{cid = 1602;}// file: 1
			case 1602:{cid = 1603;}// file: 1
			case 1603:{cid = 1604;}// file: 1
			case 1604:{cid = 1605;}// file: 1
			case 1605:{cid = 1606;}// file: 1
			case 1606:{cid = 1607;}// file: 1
			case 1607:{cid = 1608;}// file: 1
			case 1608:{cid = 1609;}// file: 1
			case 1609:{cid = 1610;}// file: 1
			case 1610:{cid = 1611;}// file: 1
			case 1611:{cid = 1637;}// file: 1
			case 1637:{cid = 1640;}// file: 1
			case 1640:{cid = 1641;}// file: 1
			case 1641:{cid = 1642;}// file: 1
			case 1642:{cid = 1643;}// file: 1
			case 1643:{cid = 2404;}// file: 1
			case 2404:{cid = 2405;}// file: 1
			case 2405:{cid = 2406;}// file: 1
			case 2406:{cid = 2410;}// file: 1
			case 2410:{cid = 2782;}// file: 1
			case 2782:{cid = 6050;}// file: 1
			case 6050:{cid = 6295;}// file: 1
			case 6295:{cid = 9237;}// file: 1
			case 9237:{cid = 9245;}// file: 1
			case 9245:{cid = 1612;}// file: 1
			case 1612:{cid = 3406;}// file: 1
			case 3406:{cid = 3578;}// file: 1
			case 3578:{cid = 3620;}// file: 1
			case 3620:{cid = 3753;}// file: 1
			case 3753:{cid = 3879;}// file: 1
			case 3879:{cid = 3886;}// file: 1
			case 3886:{cid = 5108;}// file: 1
			case 5108:{cid = 5109;}// file: 1
			case 5109:{cid = 5115;}// file: 1
			case 5115:{cid = 5143;}// file: 1
			case 5143:{cid = 5145;}// file: 1
			case 5145:{cid = 5146;}// file: 1
			case 5146:{cid = 5154;}// file: 1
			case 5154:{cid = 5155;}// file: 1
			case 5155:{cid = 5156;}// file: 1
			case 5156:{cid = 5157;}// file: 1
			case 5157:{cid = 5158;}// file: 1
			case 5158:{cid = 5160;}// file: 1
			case 5160:{cid = 5166;}// file: 1
			case 5166:{cid = 5167;}// file: 1
			case 5167:{cid = 5176;}// file: 1
			case 5176:{cid = 5184;}// file: 1
			case 5184:{cid = 6188;}// file: 1
			case 6188:{cid = 6189;}// file: 1
			case 6189:{cid = 6230;}// file: 1
			case 6230:{cid = 6300;}// file: 1
			case 6300:{cid = 8373;}// file: 1
			case 8373:{cid = 9090;}// file: 1
			case 9090:{cid = 9229;}// file: 1
			case 9229:{cid = 9230;}// file: 1
			case 9230:{cid = 9253;}// file: 1
			case 9253:{cid = 9257;}// file: 1
			case 9257:{cid = 9329;}// file: 1
			case 9329:{cid = 9584;}// file: 1
			case 9584:{cid = 9585;}// file: 1
			case 9585:{cid = 9586;}// file: 1
			case 9586:{cid = 9590;}// file: 1
			case 9590:{cid = 9612;}// file: 1
			case 9612:{cid = 9613;}// file: 1
			case 9613:{cid = 9818;}// file: 1
			case 9818:{cid = 9819;}// file: 1
			case 9819:{cid = 9820;}// file: 1
			case 9820:{cid = 9821;}// file: 1
			case 9821:{cid = 9822;}// file: 1
			case 9822:{cid = 9829;}// file: 1
			case 9829:{cid = 9858;}// file: 1
			case 9858:{cid = 9902;}// file: 1
			case 9902:{cid = 9954;}// file: 1
			case 9954:{cid = 9955;}// file: 1
			case 9955:{cid = 9956;}// file: 1
			case 9956:{cid = 9958;}// file: 1
			case 9958:{cid = 10140;}// file: 1
			case 10140:{cid = 10226;}// file: 1
			case 10226:{cid = 10227;}// file: 1
			case 10227:{cid = 10229;}// file: 1
			case 10229:{cid = 10230;}// file: 1
			case 10230:{cid = 10300;}// file: 1
			case 10300:{cid = 10301;}// file: 1
			case 10301:{cid = 10305;}// file: 1
			case 10305:{cid = 10771;}// file: 1
			case 10771:{cid = 10793;}// file: 1
			case 10793:{cid = 10794;}// file: 1
			case 10794:{cid = 10795;}// file: 1
			case 10795:{cid = 10824;}// file: 1
			case 10824:{cid = 10826;}// file: 1
			case 10826:{cid = 10827;}// file: 1
			case 10827:{cid = 10828;}// file: 1
			case 10828:{cid = 10830;}// file: 1
			case 10830:{cid = 10831;}// file: 1
			case 10831:{cid = 10833;}// file: 1
			case 10833:{cid = 10834;}// file: 1
			case 10834:{cid = 10841;}// file: 1
			case 10841:{cid = 11009;}// file: 1
			case 11009:{cid = 11145;}// file: 1
			case 11145:{cid = 11146;}// file: 1
			case 11146:{cid = 11237;}// file: 1
			case 11237:{cid = 11495;}// file: 1
			case 11495:{cid = 12990;}// file: 1
			case 12990:{cid = 16502;}// file: 1
			case 16502:{cid = 17068;}// file: 1
			case 17068:{cid = 18024;}// file: 1
			case 18024:{cid = 4817;}// file: 1
			case 4817:{cid = 4818;}// file: 1
			case 4818:{cid = 4819;}// file: 1
			case 4819:{cid = 4853;}// file: 1
			case 4853:{cid = 4884;}// file: 1
			case 4884:{cid = 4885;}// file: 1
			case 4885:{cid = 5064;}// file: 1
			case 5064:{cid = 5117;}// file: 1
			case 5117:{cid = 5118;}// file: 1
			case 5118:{cid = 5119;}// file: 1
			case 5119:{cid = 5127;}// file: 1
			case 5127:{cid = 5272;}// file: 1
			case 5272:{cid = 5275;}// file: 1
			case 5275:{cid = 5277;}// file: 1
			case 5277:{cid = 5347;}// file: 1
			case 5347:{cid = 5396;}// file: 1
			case 5396:{cid = 5398;}// file: 1
			case 5398:{cid = 5399;}// file: 1
			case 5399:{cid = 5477;}// file: 1
			case 5477:{cid = 5478;}// file: 1
			case 5478:{cid = 5479;}// file: 1
			case 5479:{cid = 5480;}// file: 1
			case 5480:{cid = 5513;}// file: 1
			case 5513:{cid = 5674;}// file: 1
			case 5674:{cid = 5679;}// file: 1
			case 5679:{cid = 5772;}// file: 1
			case 5772:{cid = 5773;}// file: 1
			case 5773:{cid = 6248;}// file: 1
			case 6248:{cid = 6249;}// file: 1
			case 6249:{cid = 6250;}// file: 1
			case 6250:{cid = 6251;}// file: 1
			case 6251:{cid = 6252;}// file: 1
			case 6252:{cid = 6290;}// file: 1
			case 6290:{cid = 6292;}// file: 1
			case 6292:{cid = 6501;}// file: 1
			case 6501:{cid = 6502;}// file: 1
			case 6502:{cid = 6912;}// file: 1
			case 6912:{cid = 6913;}// file: 1
			case 6913:{cid = 6914;}// file: 1
			case 6914:{cid = 6915;}// file: 1
			case 6915:{cid = 6916;}// file: 1
			case 6916:{cid = 6917;}// file: 1
			case 6917:{cid = 6980;}// file: 1
			case 6980:{cid = 6981;}// file: 1
			case 6981:{cid = 6982;}// file: 1
			case 6982:{cid = 6983;}// file: 1
			case 6983:{cid = 6984;}// file: 1
			case 6984:{cid = 7498;}// file: 1
			case 7498:{cid = 7499;}// file: 1
			case 7499:{cid = 7500;}// file: 1
			case 7500:{cid = 7501;}// file: 1
			case 7501:{cid = 7502;}// file: 1
			case 7502:{cid = 7503;}// file: 1
			case 7503:{cid = 8538;}// file: 1
			case 8538:{cid = 8539;}// file: 1
			case 8539:{cid = 8540;}// file: 1
			case 8540:{cid = 8541;}// file: 1
			case 8541:{cid = 8542;}// file: 1
			case 8542:{cid = 8586;}// file: 1
			case 8586:{cid = 8587;}// file: 1
			case 8587:{cid = 8588;}// file: 1
			case 8588:{cid = 8624;}// file: 1
			case 8624:{cid = 8625;}// file: 1
			case 8625:{cid = 8626;}// file: 1
			case 8626:{cid = 8627;}// file: 1
			case 8627:{cid = 8628;}// file: 1
			case 8628:{cid = 8629;}// file: 1
			case 8629:{cid = 8630;}// file: 1
			case 8630:{cid = 8631;}// file: 1
			case 8631:{cid = 8632;}// file: 1
			case 8632:{cid = 8633;}// file: 1
			case 8633:{cid = 8634;}// file: 1
			case 8634:{cid = 8635;}// file: 1
			case 8635:{cid = 8858;}// file: 1
			case 8858:{cid = 8860;}// file: 1
			case 8860:{cid = 9164;}// file: 1
			case 9164:{cid = 9165;}// file: 1
			case 9165:{cid = 9166;}// file: 1
			case 9166:{cid = 9167;}// file: 1
			case 9167:{cid = 9168;}// file: 1
			case 9168:{cid = 9705;}// file: 1
			case 9705:{cid = 10752;}// file: 1
			case 10752:{cid = 10927;}// file: 1
			case 10927:{cid = 10931;}// file: 1
			case 10931:{cid = 10933;}// file: 1
			case 10933:{cid = 10934;}// file: 1
			case 10934:{cid = 10935;}// file: 1
			case 10935:{cid = 11101;}// file: 1
			case 11101:{cid = 11228;}// file: 1
			case 11228:{cid = 11229;}// file: 1
			case 11229:{cid = 11230;}// file: 1
			case 11230:{cid = 11231;}// file: 1
			case 11231:{cid = 11232;}// file: 1
			case 11232:{cid = 11464;}// file: 1
			case 11464:{cid = 11465;}// file: 1
			case 11465:{cid = 11466;}// file: 1
			case 11466:{cid = 11467;}// file: 1
			case 11467:{cid = 11468;}// file: 1
			case 11468:{cid = 12831;}// file: 1
			case 12831:{cid = 12832;}// file: 1
			case 12832:{cid = 12833;}// file: 1
			case 12833:{cid = 12835;}// file: 1
			case 12835:{cid = 12836;}// file: 1
			case 12836:{cid = 12837;}// file: 1
			case 12837:{cid = 12838;}// file: 1
			case 12838:{cid = 13312;}// file: 1
			case 13312:{cid = 13491;}// file: 1
			case 13491:{cid = 16024;}// file: 1
			case 16024:{cid = 16025;}// file: 1
			case 16025:{cid = 16026;}// file: 1
			case 16026:{cid = 16027;}// file: 1
			case 16027:{cid = 16028;}// file: 1
			case 16028:{cid = 16029;}// file: 1
			case 16029:{cid = 16030;}// file: 1
			case 16030:{cid = 16031;}// file: 1
			case 16031:{cid = 16032;}// file: 1
			case 16032:{cid = 16033;}// file: 1
			case 16033:{cid = 16034;}// file: 1
			case 16034:{cid = 16035;}// file: 1
			case 16035:{cid = 16036;}// file: 1
			case 16036:{cid = 16156;}// file: 1
			case 16156:{cid = 17283;}// file: 1
			case 17283:{cid = 17284;}// file: 1
			case 17284:{cid = 17285;}// file: 1
			case 17285:{cid = 17286;}// file: 1
			case 17286:{cid = 17287;}// file: 1
			case 17287:{cid = 17288;}// file: 1
			case 17288:{cid = 17289;}// file: 1
			case 17289:{cid = 17290;}// file: 1
			case 17290:{cid = 17291;}// file: 1
			case 17291:{cid = 17292;}// file: 1
			case 17292:{cid = 17296;}// file: 1
			case 17296:{cid = 17297;}// file: 1
			case 17297:{cid = 3249;}// file: 1
			case 3249:{cid = 6869;}// file: 3
			case 6869:{cid = 6985;}// file: 3
			case 6985:{cid = 6987;}// file: 3
			case 6987:{cid = 6988;}// file: 3
			case 6988:{cid = 6989;}// file: 3
			case 6989:{cid = 7071;}// file: 3
			case 7071:{cid = 7263;}// file: 3
			case 7263:{cid = 7265;}// file: 3
			case 7265:{cid = 7289;}// file: 3
			case 7289:{cid = 7521;}// file: 3
			case 7521:{cid = 8395;}// file: 3
			case 8395:{cid = 8399;}// file: 3
			case 8399:{cid = 8400;}// file: 3
			case 8400:{cid = 8501;}// file: 3
			case 8501:{cid = 8663;}// file: 3
			case 8663:{cid = 9070;}// file: 3
			case 9070:{cid = 9071;}// file: 3
			case 9071:{cid = 9072;}// file: 3
			case 9072:{cid = 9076;}// file: 3
			case 9076:{cid = 9104;}// file: 3
			case 9104:{cid = 9582;}// file: 3
			case 9582:{cid = 10398;}// file: 3
			case 10398:{cid = 10713;}// file: 3
			case 10713:{cid = 13132;}// file: 3
			case 13132:{cid = 14399;}// file: 3
			case 14399:{cid = 14463;}// file: 3
			case 14463:{cid = 14533;}// file: 3
			case 14533:{cid = 14536;}// file: 3
			case 14536:{cid = 14537;}// file: 3
			case 14537:{cid = 14546;}// file: 3
			case 14546:{cid = 14560;}// file: 3
			case 14560:{cid = 14563;}// file: 3
			case 14563:{cid = 14581;}// file: 3
			case 14581:{cid = 14590;}// file: 3
			case 14590:{cid = 14606;}// file: 3
			case 14606:{cid = 14607;}// file: 3
			case 14607:{cid = 14614;}// file: 3
			case 14614:{cid = 14623;}// file: 3
			case 14623:{cid = 14624;}// file: 3
			case 14624:{cid = 14625;}// file: 3
			case 14625:{cid = 14738;}// file: 3
			case 14738:{cid = 14777;}// file: 3
			case 14777:{cid = 14785;}// file: 3
			case 14785:{cid = 14808;}// file: 3
			case 14808:{cid = 14809;}// file: 3
			case 14809:{cid = 14815;}// file: 3
			case 14815:{cid = 14821;}// file: 3
			case 14821:{cid = 14831;}// file: 3
			case 14831:{cid = 14832;}// file: 3
			case 14832:{cid = 14835;}// file: 3
			case 14835:{cid = 14836;}// file: 3
			case 14836:{cid = 14838;}// file: 3
			case 14838:{cid = 16021;}// file: 3
			case 16021:{cid = 16051;}// file: 3
			case 16051:{cid = 16146;}// file: 3
			case 16146:{cid = 16150;}// file: 3
			case 16150:{cid = 16690;}// file: 3
			case 16690:{cid = 17523;}// file: 3
			case 17523:{cid = 17700;}// file: 3
			case 17700:{cid = 18018;}// file: 3
			case 18018:{cid = 18028;}// file: 3
			case 18028:{cid = 18090;}// file: 3
			case 18090:{cid = 3689;}// file: 3
			case 3689:{cid = 3707;}// file: 4
			case 3707:{cid = 3755;}// file: 4
			case 3755:{cid = 3776;}// file: 4
			case 3776:{cid = 4860;}// file: 4
			case 4860:{cid = 5129;}// file: 4
			case 5129:{cid = 5131;}// file: 4
			case 5131:{cid = 5135;}// file: 4
			case 5135:{cid = 5137;}// file: 4
			case 5137:{cid = 5138;}// file: 4
			case 5138:{cid = 5139;}// file: 4
			case 5139:{cid = 5174;}// file: 4
			case 5174:{cid = 5175;}// file: 4
			case 5175:{cid = 5177;}// file: 4
			case 5177:{cid = 5180;}// file: 4
			case 5180:{cid = 5183;}// file: 4
			case 5183:{cid = 5192;}// file: 4
			case 5192:{cid = 5278;}// file: 4
			case 5278:{cid = 5309;}// file: 4
			case 5309:{cid = 5310;}// file: 4
			case 5310:{cid = 5313;}// file: 4
			case 5313:{cid = 5397;}// file: 4
			case 5397:{cid = 5728;}// file: 4
			case 5728:{cid = 6340;}// file: 4
			case 6340:{cid = 6404;}// file: 4
			case 6404:{cid = 6490;}// file: 4
			case 6490:{cid = 6925;}// file: 4
			case 6925:{cid = 7019;}// file: 4
			case 7019:{cid = 7020;}// file: 4
			case 7020:{cid = 7021;}// file: 4
			case 7021:{cid = 7035;}// file: 4
			case 7035:{cid = 7269;}// file: 4
			case 7269:{cid = 7490;}// file: 4
			case 7490:{cid = 7492;}// file: 4
			case 7492:{cid = 7494;}// file: 4
			case 7494:{cid = 7495;}// file: 4
			case 7495:{cid = 7496;}// file: 4
			case 7496:{cid = 7497;}// file: 4
			case 7497:{cid = 7513;}// file: 4
			case 7513:{cid = 7627;}// file: 4
			case 7627:{cid = 7832;}// file: 4
			case 7832:{cid = 7861;}// file: 4
			case 7861:{cid = 8057;}// file: 4
			case 8057:{cid = 8058;}// file: 4
			case 8058:{cid = 8059;}// file: 4
			case 8059:{cid = 8060;}// file: 4
			case 8060:{cid = 8061;}// file: 4
			case 8061:{cid = 8062;}// file: 4
			case 8062:{cid = 8063;}// file: 4
			case 8063:{cid = 8064;}// file: 4
			case 8064:{cid = 8065;}// file: 4
			case 8065:{cid = 8066;}// file: 4
			case 8066:{cid = 8067;}// file: 4
			case 8067:{cid = 8069;}// file: 4
			case 8069:{cid = 8254;}// file: 4
			case 8254:{cid = 8255;}// file: 4
			case 8255:{cid = 8260;}// file: 4
			case 8260:{cid = 8300;}// file: 4
			case 8300:{cid = 8544;}// file: 4
			case 8544:{cid = 8545;}// file: 4
			case 8545:{cid = 8546;}// file: 4
			case 8546:{cid = 9243;}// file: 4
			case 9243:{cid = 9244;}// file: 4
			case 9244:{cid = 9247;}// file: 4
			case 9247:{cid = 9260;}// file: 4
			case 9260:{cid = 9680;}// file: 4
			case 9680:{cid = 10775;}// file: 4
			case 10775:{cid = 10776;}// file: 4
			case 10776:{cid = 10840;}// file: 4
			case 10840:{cid = 10843;}// file: 4
			case 10843:{cid = 10844;}// file: 4
			case 10844:{cid = 10845;}// file: 4
			case 10845:{cid = 10846;}// file: 4
			case 10846:{cid = 10847;}// file: 4
			case 10847:{cid = 10856;}// file: 4
			case 10856:{cid = 10965;}// file: 4
			case 10965:{cid = 10966;}// file: 4
			case 10966:{cid = 11010;}// file: 4
			case 11010:{cid = 11011;}// file: 4
			case 11011:{cid = 11012;}// file: 4
			case 11012:{cid = 11081;}// file: 4
			case 11081:{cid = 11085;}// file: 4
			case 11085:{cid = 11086;}// file: 4
			case 11086:{cid = 11087;}// file: 4
			case 11087:{cid = 11089;}// file: 4
			case 11089:{cid = 11090;}// file: 4
			case 11090:{cid = 11093;}// file: 4
			case 11093:{cid = 11233;}// file: 4
			case 11233:{cid = 11234;}// file: 4
			case 11234:{cid = 11235;}// file: 4
			case 11235:{cid = 11236;}// file: 4
			case 11236:{cid = 11244;}// file: 4
			case 11244:{cid = 11290;}// file: 4
			case 11290:{cid = 11293;}// file: 4
			case 11293:{cid = 11295;}// file: 4
			case 11295:{cid = 11461;}// file: 4
			case 11461:{cid = 11543;}// file: 4
			case 11543:{cid = 12847;}// file: 4
			case 12847:{cid = 12931;}// file: 4
			case 12931:{cid = 12941;}// file: 4
			case 12941:{cid = 12981;}// file: 4
			case 12981:{cid = 12988;}// file: 4
			case 12988:{cid = 13059;}// file: 4
			case 13059:{cid = 13060;}// file: 4
			case 13060:{cid = 13061;}// file: 4
			case 13061:{cid = 13065;}// file: 4
			case 13065:{cid = 13066;}// file: 4
			case 13066:{cid = 13077;}// file: 4
			case 13077:{cid = 13078;}// file: 4
			case 13078:{cid = 13198;}// file: 4
			case 13198:{cid = 14572;}// file: 4
			case 14572:{cid = 14577;}// file: 4
			case 14577:{cid = 14588;}// file: 4
			case 14588:{cid = 14784;}// file: 4
			case 14784:{cid = 14795;}// file: 4
			case 14795:{cid = 16271;}// file: 4
			case 16271:{cid = 16272;}// file: 4
			case 16272:{cid = 16385;}// file: 4
			case 16385:{cid = 16398;}// file: 4
			case 16398:{cid = 16399;}// file: 4
			case 16399:{cid = 16400;}// file: 4
			case 16400:{cid = 17012;}// file: 4
			case 17012:{cid = 17013;}// file: 4
			case 17013:{cid = 17014;}// file: 4
			case 17014:{cid = 17015;}// file: 4
			case 17015:{cid = 17016;}// file: 4
			case 17016:{cid = 17017;}// file: 4
			case 17017:{cid = 17021;}// file: 4
			case 17021:{cid = 17022;}// file: 4
			case 17022:{cid = 17023;}// file: 4
			case 17023:{cid = 17024;}// file: 4
			case 17024:{cid = 17038;}// file: 4
			case 17038:{cid = 17040;}// file: 4
			case 17040:{cid = 17049;}// file: 4
			case 17049:{cid = 17050;}// file: 4
			case 17050:{cid = 17051;}// file: 4
			case 17051:{cid = 17072;}// file: 4
			case 17072:{cid = 17073;}// file: 4
			case 17073:{cid = 17538;}// file: 4
			case 17538:{cid = 17546;}// file: 4
			case 17546:{cid = 17636;}// file: 4
			case 17636:{cid = 18200;}// file: 4
			case 18200:{cid = 18365;}// file: 4
			case 18365:{cid = 18496;}// file: 4
			case 18496:{cid = 3781;}// file: 4
			case 3781:{cid = 4002;}// file: 6
			case 4002:{cid = 4005;}// file: 6
			case 4005:{cid = 4006;}// file: 6
			case 4006:{cid = 4007;}// file: 6
			case 4007:{cid = 4008;}// file: 6
			case 4008:{cid = 4017;}// file: 6
			case 4017:{cid = 4019;}// file: 6
			case 4019:{cid = 4021;}// file: 6
			case 4021:{cid = 4023;}// file: 6
			case 4023:{cid = 4028;}// file: 6
			case 4028:{cid = 4033;}// file: 6
			case 4033:{cid = 4113;}// file: 6
			case 4113:{cid = 4193;}// file: 6
			case 4193:{cid = 4550;}// file: 6
			case 4550:{cid = 4558;}// file: 6
			case 4558:{cid = 4559;}// file: 6
			case 4559:{cid = 4563;}// file: 6
			case 4563:{cid = 4564;}// file: 6
			case 4564:{cid = 4569;}// file: 6
			case 4569:{cid = 4570;}// file: 6
			case 4570:{cid = 4571;}// file: 6
			case 4571:{cid = 4572;}// file: 6
			case 4572:{cid = 4573;}// file: 6
			case 4573:{cid = 4576;}// file: 6
			case 4576:{cid = 4585;}// file: 6
			case 4585:{cid = 4586;}// file: 6
			case 4586:{cid = 4587;}// file: 6
			case 4587:{cid = 4600;}// file: 6
			case 4600:{cid = 4601;}// file: 6
			case 4601:{cid = 4602;}// file: 6
			case 4602:{cid = 4603;}// file: 6
			case 4603:{cid = 4681;}// file: 6
			case 4681:{cid = 4690;}// file: 6
			case 4690:{cid = 4718;}// file: 6
			case 4718:{cid = 5033;}// file: 6
			case 5033:{cid = 5735;}// file: 6
			case 5735:{cid = 5736;}// file: 6
			case 5736:{cid = 5740;}// file: 6
			case 5740:{cid = 5767;}// file: 6
			case 5767:{cid = 5881;}// file: 6
			case 5881:{cid = 5882;}// file: 6
			case 5882:{cid = 5999;}// file: 6
			case 5999:{cid = 6059;}// file: 6
			case 6059:{cid = 6063;}// file: 6
			case 6063:{cid = 6087;}// file: 6
			case 6087:{cid = 6088;}// file: 6
			case 6088:{cid = 6099;}// file: 6
			case 6099:{cid = 6100;}// file: 6
			case 6100:{cid = 6102;}// file: 6
			case 6102:{cid = 6148;}// file: 6
			case 6148:{cid = 6159;}// file: 6
			case 6159:{cid = 6199;}// file: 6
			case 6199:{cid = 6205;}// file: 6
			case 6205:{cid = 6211;}// file: 6
			case 6211:{cid = 6212;}// file: 6
			case 6212:{cid = 6288;}// file: 6
			case 6288:{cid = 6332;}// file: 6
			case 6332:{cid = 6336;}// file: 6
			case 6336:{cid = 6342;}// file: 6
			case 6342:{cid = 6351;}// file: 6
			case 6351:{cid = 6364;}// file: 6
			case 6364:{cid = 6366;}// file: 6
			case 6366:{cid = 6368;}// file: 6
			case 6368:{cid = 6371;}// file: 6
			case 6371:{cid = 6373;}// file: 6
			case 6373:{cid = 6388;}// file: 6
			case 6388:{cid = 6389;}// file: 6
			case 6389:{cid = 6390;}// file: 6
			case 6390:{cid = 6391;}// file: 6
			case 6391:{cid = 6966;}// file: 6
			case 6966:{cid = 6993;}// file: 6
			case 6993:{cid = 7009;}// file: 6
			case 7009:{cid = 7528;}// file: 6
			case 7528:{cid = 7584;}// file: 6
			case 7584:{cid = 7585;}// file: 6
			case 7585:{cid = 7696;}// file: 6
			case 7696:{cid = 8391;}// file: 6
			case 8391:{cid = 8392;}// file: 6
			case 8392:{cid = 8393;}// file: 6
			case 8393:{cid = 8419;}// file: 6
			case 8419:{cid = 8421;}// file: 6
			case 8421:{cid = 8422;}// file: 6
			case 8422:{cid = 8424;}// file: 6
			case 8424:{cid = 8434;}// file: 6
			case 8434:{cid = 8480;}// file: 6
			case 8480:{cid = 8482;}// file: 6
			case 8482:{cid = 8485;}// file: 6
			case 8485:{cid = 8488;}// file: 6
			case 8488:{cid = 8489;}// file: 6
			case 8489:{cid = 8490;}// file: 6
			case 8490:{cid = 8527;}// file: 6
			case 8527:{cid = 8528;}// file: 6
			case 8528:{cid = 8555;}// file: 6
			case 8555:{cid = 8565;}// file: 6
			case 8565:{cid = 8566;}// file: 6
			case 8566:{cid = 8568;}// file: 6
			case 8568:{cid = 9361;}// file: 6
			case 9361:{cid = 9907;}// file: 6
			case 9907:{cid = 9919;}// file: 6
			case 9919:{cid = 10027;}// file: 6
			case 10027:{cid = 10041;}// file: 6
			case 10041:{cid = 10044;}// file: 6
			case 10044:{cid = 10056;}// file: 6
			case 10056:{cid = 10060;}// file: 6
			case 10060:{cid = 10063;}// file: 6
			case 10063:{cid = 10143;}// file: 6
			case 10143:{cid = 10308;}// file: 6
			case 10308:{cid = 10610;}// file: 6
			case 10610:{cid = 10619;}// file: 6
			case 10619:{cid = 10676;}// file: 6
			case 10676:{cid = 10871;}// file: 6
			case 10871:{cid = 10945;}// file: 6
			case 10945:{cid = 10947;}// file: 6
			case 10947:{cid = 10948;}// file: 6
			case 10948:{cid = 11431;}// file: 6
			case 11431:{cid = 11566;}// file: 6
			case 11566:{cid = 13006;}// file: 6
			case 13006:{cid = 14593;}// file: 6
			case 14593:{cid = 14594;}// file: 6
			case 14594:{cid = 14595;}// file: 6
			case 14595:{cid = 14597;}// file: 6
			case 14597:{cid = 14602;}// file: 6
			case 14602:{cid = 16004;}// file: 6
			case 16004:{cid = 16326;}// file: 6
			case 16326:{cid = 17533;}// file: 6
			case 17533:{cid = 967;}// file: 6
			case 967:{cid = 1638;}// file: 7
			case 1638:{cid = 1684;}// file: 7
			case 1684:{cid = 3243;}// file: 7
			case 3243:{cid = 3292;}// file: 7
			case 3292:{cid = 3293;}// file: 7
			case 3293:{cid = 3504;}// file: 7
			case 3504:{cid = 3615;}// file: 7
			case 3615:{cid = 3866;}// file: 7
			case 3866:{cid = 3873;}// file: 7
			case 3873:{cid = 3887;}// file: 7
			case 3887:{cid = 3976;}// file: 7
			case 3976:{cid = 3980;}// file: 7
			case 3980:{cid = 3986;}// file: 7
			case 3986:{cid = 3998;}// file: 7
			case 3998:{cid = 4013;}// file: 7
			case 4013:{cid = 4014;}// file: 7
			case 4014:{cid = 4079;}// file: 7
			case 4079:{cid = 4101;}// file: 7
			case 4101:{cid = 4103;}// file: 7
			case 4103:{cid = 4552;}// file: 7
			case 4552:{cid = 4554;}// file: 7
			case 4554:{cid = 5116;}// file: 7
			case 5116:{cid = 5402;}// file: 7
			case 5402:{cid = 5403;}// file: 7
			case 5403:{cid = 5408;}// file: 7
			case 5408:{cid = 5426;}// file: 7
			case 5426:{cid = 5705;}// file: 7
			case 5705:{cid = 5706;}// file: 7
			case 5706:{cid = 5708;}// file: 7
			case 5708:{cid = 5710;}// file: 7
			case 5710:{cid = 5711;}// file: 7
			case 5711:{cid = 5712;}// file: 7
			case 5712:{cid = 5716;}// file: 7
			case 5716:{cid = 5720;}// file: 7
			case 5720:{cid = 5763;}// file: 7
			case 5763:{cid = 5835;}// file: 7
			case 5835:{cid = 5837;}// file: 7
			case 5837:{cid = 5863;}// file: 7
			case 5863:{cid = 5864;}// file: 7
			case 5864:{cid = 5865;}// file: 7
			case 5865:{cid = 5886;}// file: 7
			case 5886:{cid = 6036;}// file: 7
			case 6036:{cid = 6037;}// file: 7
			case 6037:{cid = 6040;}// file: 7
			case 6040:{cid = 6296;}// file: 7
			case 6296:{cid = 6337;}// file: 7
			case 6337:{cid = 6863;}// file: 7
			case 6863:{cid = 6864;}// file: 7
			case 6864:{cid = 6866;}// file: 7
			case 6866:{cid = 6871;}// file: 7
			case 6871:{cid = 6872;}// file: 7
			case 6872:{cid = 6873;}// file: 7
			case 6873:{cid = 6874;}// file: 7
			case 6874:{cid = 6875;}// file: 7
			case 6875:{cid = 6962;}// file: 7
			case 6962:{cid = 6994;}// file: 7
			case 6994:{cid = 7011;}// file: 7
			case 7011:{cid = 7023;}// file: 7
			case 7023:{cid = 7027;}// file: 7
			case 7027:{cid = 7094;}// file: 7
			case 7094:{cid = 7511;}// file: 7
			case 7511:{cid = 7525;}// file: 7
			case 7525:{cid = 8034;}// file: 7
			case 8034:{cid = 8079;}// file: 7
			case 8079:{cid = 8130;}// file: 7
			case 8130:{cid = 8131;}// file: 7
			case 8131:{cid = 8136;}// file: 7
			case 8136:{cid = 8168;}// file: 7
			case 8168:{cid = 8169;}// file: 7
			case 8169:{cid = 8230;}// file: 7
			case 8230:{cid = 8231;}// file: 7
			case 8231:{cid = 8237;}// file: 7
			case 8237:{cid = 8397;}// file: 7
			case 8397:{cid = 8431;}// file: 7
			case 8431:{cid = 8493;}// file: 7
			case 8493:{cid = 8500;}// file: 7
			case 8500:{cid = 8575;}// file: 7
			case 8575:{cid = 8578;}// file: 7
			case 8578:{cid = 8591;}// file: 7
			case 8591:{cid = 8620;}// file: 7
			case 8620:{cid = 8675;}// file: 7
			case 8675:{cid = 8867;}// file: 7
			case 8867:{cid = 8870;}// file: 7
			case 8870:{cid = 8881;}// file: 7
			case 8881:{cid = 8882;}// file: 7
			case 8882:{cid = 8955;}// file: 7
			case 8955:{cid = 9037;}// file: 7
			case 9037:{cid = 9039;}// file: 7
			case 9039:{cid = 9052;}// file: 7
			case 9052:{cid = 9078;}// file: 7
			case 9078:{cid = 9106;}// file: 7
			case 9106:{cid = 9114;}// file: 7
			case 9114:{cid = 9310;}// file: 7
			case 9310:{cid = 9593;}// file: 7
			case 9593:{cid = 9623;}// file: 7
			case 9623:{cid = 9624;}// file: 7
			case 9624:{cid = 9834;}// file: 7
			case 9834:{cid = 9835;}// file: 7
			case 9835:{cid = 9836;}// file: 7
			case 9836:{cid = 9900;}// file: 7
			case 9900:{cid = 9901;}// file: 7
			case 9901:{cid = 9918;}// file: 7
			case 9918:{cid = 9931;}// file: 7
			case 9931:{cid = 9949;}// file: 7
			case 9949:{cid = 9950;}// file: 7
			case 9950:{cid = 9951;}// file: 7
			case 9951:{cid = 10023;}// file: 7
			case 10023:{cid = 10031;}// file: 7
			case 10031:{cid = 10049;}// file: 7
			case 10049:{cid = 10270;}// file: 7
			case 10270:{cid = 10368;}// file: 7
			case 10368:{cid = 10377;}// file: 7
			case 10377:{cid = 10378;}// file: 7
			case 10378:{cid = 10379;}// file: 7
			case 10379:{cid = 10380;}// file: 7
			case 10380:{cid = 10381;}// file: 7
			case 10381:{cid = 10401;}// file: 7
			case 10401:{cid = 10433;}// file: 7
			case 10433:{cid = 10631;}// file: 7
			case 10631:{cid = 10829;}// file: 7
			case 10829:{cid = 10832;}// file: 7
			case 10832:{cid = 10941;}// file: 7
			case 10941:{cid = 10942;}// file: 7
			case 10942:{cid = 11008;}// file: 7
			case 11008:{cid = 11015;}// file: 7
			case 11015:{cid = 11088;}// file: 7
			case 11088:{cid = 11425;}// file: 7
			case 11425:{cid = 11426;}// file: 7
			case 11426:{cid = 11427;}// file: 7
			case 11427:{cid = 11428;}// file: 7
			case 11428:{cid = 11440;}// file: 7
			case 11440:{cid = 11441;}// file: 7
			case 11441:{cid = 11442;}// file: 7
			case 11442:{cid = 11443;}// file: 7
			case 11443:{cid = 11444;}// file: 7
			case 11444:{cid = 11445;}// file: 7
			case 11445:{cid = 11446;}// file: 7
			case 11446:{cid = 11447;}// file: 7
			case 11447:{cid = 11451;}// file: 7
			case 11451:{cid = 11454;}// file: 7
			case 11454:{cid = 11457;}// file: 7
			case 11457:{cid = 11458;}// file: 7
			case 11458:{cid = 11459;}// file: 7
			case 11459:{cid = 11492;}// file: 7
			case 11492:{cid = 12805;}// file: 7
			case 12805:{cid = 12925;}// file: 7
			case 12925:{cid = 12928;}// file: 7
			case 12928:{cid = 12929;}// file: 7
			case 12929:{cid = 12935;}// file: 7
			case 12935:{cid = 12942;}// file: 7
			case 12942:{cid = 12943;}// file: 7
			case 12943:{cid = 12959;}// file: 7
			case 12959:{cid = 12960;}// file: 7
			case 12960:{cid = 12978;}// file: 7
			case 12978:{cid = 12983;}// file: 7
			case 12983:{cid = 13007;}// file: 7
			case 13007:{cid = 13027;}// file: 7
			case 13027:{cid = 13190;}// file: 7
			case 13190:{cid = 13295;}// file: 7
			case 13295:{cid = 13725;}// file: 7
			case 13725:{cid = 14408;}// file: 7
			case 14408:{cid = 14412;}// file: 7
			case 14412:{cid = 14413;}// file: 7
			case 14413:{cid = 14415;}// file: 7
			case 14415:{cid = 14444;}// file: 7
			case 14444:{cid = 14445;}// file: 7
			case 14445:{cid = 14447;}// file: 7
			case 14447:{cid = 14466;}// file: 7
			case 14466:{cid = 14530;}// file: 7
			case 14530:{cid = 14576;}// file: 7
			case 14576:{cid = 14592;}// file: 7
			case 14592:{cid = 16095;}// file: 7
			case 16095:{cid = 16096;}// file: 7
			case 16096:{cid = 16137;}// file: 7
			case 16137:{cid = 16138;}// file: 7
			case 16138:{cid = 16287;}// file: 7
			case 16287:{cid = 16344;}// file: 7
			case 16344:{cid = 16348;}// file: 7
			case 16348:{cid = 16352;}// file: 7
			case 16352:{cid = 16354;}// file: 7
			case 16354:{cid = 16359;}// file: 7
			case 16359:{cid = 16364;}// file: 7
			case 16364:{cid = 16376;}// file: 7
			case 16376:{cid = 16386;}// file: 7
			case 16386:{cid = 16387;}// file: 7
			case 16387:{cid = 16563;}// file: 7
			case 16563:{cid = 16564;}// file: 7
			case 16564:{cid = 16769;}// file: 7
			case 16769:{cid = 16770;}// file: 7
			case 16770:{cid = 16774;}// file: 7
			case 16774:{cid = 17688;}// file: 7
			case 17688:{cid = 17946;}// file: 7
			case 17946:{cid = 18033;}// file: 7
			case 18033:{cid = 18036;}// file: 7
			case 18036:{cid = 18045;}// file: 7
			case 18045:{cid = 18049;}// file: 7
			case 18049:{cid = 18065;}// file: 7
			case 18065:{cid = 18234;}// file: 7
			case 18234:{cid = 18235;}// file: 7
			case 18235:{cid = 18236;}// file: 7
			case 18236:{cid = 18274;}// file: 7
			case 18274:{cid = 18552;}// file: 7
			case 18552:{cid = 3436;}// file: 7
			case 3436:{cid = 3469;}// file: 8
			case 3469:{cid = 4016;}// file: 8
			case 4016:{cid = 4141;}// file: 8
			case 4141:{cid = 4857;}// file: 8
			case 4857:{cid = 4887;}// file: 8
			case 4887:{cid = 4888;}// file: 8
			case 4888:{cid = 5168;}// file: 8
			case 5168:{cid = 5189;}// file: 8
			case 5189:{cid = 5406;}// file: 8
			case 5406:{cid = 5413;}// file: 8
			case 5413:{cid = 5418;}// file: 8
			case 5418:{cid = 5430;}// file: 8
			case 5430:{cid = 5718;}// file: 8
			case 5718:{cid = 5732;}// file: 8
			case 5732:{cid = 5814;}// file: 8
			case 5814:{cid = 6010;}// file: 8
			case 6010:{cid = 6257;}// file: 8
			case 6257:{cid = 6283;}// file: 8
			case 6283:{cid = 6907;}// file: 8
			case 6907:{cid = 7037;}// file: 8
			case 7037:{cid = 7240;}// file: 8
			case 7240:{cid = 7387;}// file: 8
			case 7387:{cid = 7389;}// file: 8
			case 7389:{cid = 7426;}// file: 8
			case 7426:{cid = 7509;}// file: 8
			case 7509:{cid = 7596;}// file: 8
			case 7596:{cid = 7972;}// file: 8
			case 7972:{cid = 7973;}// file: 8
			case 7973:{cid = 8409;}// file: 8
			case 8409:{cid = 8411;}// file: 8
			case 8411:{cid = 8498;}// file: 8
			case 8498:{cid = 8499;}// file: 8
			case 8499:{cid = 8534;}// file: 8
			case 8534:{cid = 8535;}// file: 8
			case 8535:{cid = 8710;}// file: 8
			case 8710:{cid = 9615;}// file: 8
			case 9615:{cid = 9824;}// file: 8
			case 9824:{cid = 9859;}// file: 8
			case 9859:{cid = 9860;}// file: 8
			case 9860:{cid = 9898;}// file: 8
			case 9898:{cid = 10193;}// file: 8
			case 10193:{cid = 10194;}// file: 8
			case 10194:{cid = 10195;}// file: 8
			case 10195:{cid = 10196;}// file: 8
			case 10196:{cid = 10197;}// file: 8
			case 10197:{cid = 10310;}// file: 8
			case 10310:{cid = 10412;}// file: 8
			case 10412:{cid = 10425;}// file: 8
			case 10425:{cid = 10446;}// file: 8
			case 10446:{cid = 10606;}// file: 8
			case 10606:{cid = 10718;}// file: 8
			case 10718:{cid = 10744;}// file: 8
			case 10744:{cid = 11469;}// file: 8
			case 11469:{cid = 11549;}// file: 8
			case 11549:{cid = 11674;}// file: 8
			case 11674:{cid = 12924;}// file: 8
			case 12924:{cid = 12976;}// file: 8
			case 12976:{cid = 13361;}// file: 8
			case 13361:{cid = 14383;}// file: 8
			case 14383:{cid = 14479;}// file: 8
			case 14479:{cid = 14506;}// file: 8
			case 14506:{cid = 14655;}// file: 8
			case 14655:{cid = 14674;}// file: 8
			case 14674:{cid = 14675;}// file: 8
			case 14675:{cid = 15029;}// file: 8
			case 15029:{cid = 15030;}// file: 8
			case 15030:{cid = 15033;}// file: 8
			case 15033:{cid = 15034;}// file: 8
			case 15034:{cid = 15053;}// file: 8
			case 15053:{cid = 16012;}// file: 8
			case 16012:{cid = 16066;}// file: 8
			case 16066:{cid = 16067;}// file: 8
			case 16067:{cid = 16070;}// file: 8
			case 16070:{cid = 16106;}// file: 8
			case 16106:{cid = 16143;}// file: 8
			case 16143:{cid = 16144;}// file: 8
			case 16144:{cid = 16562;}// file: 8
			case 16562:{cid = 16568;}// file: 8
			case 16568:{cid = 16605;}// file: 8
			case 16605:{cid = 16673;}// file: 8
			case 16673:{cid = 16767;}// file: 8
			case 16767:{cid = 16781;}// file: 8
			case 16781:{cid = 17534;}// file: 8
			case 17534:{cid = 18009;}// file: 8
			case 18009:{cid = 18020;}// file: 8
			case 18020:{cid = 18021;}// file: 8
			case 18021:{cid = 18022;}// file: 8
			case 18022:{cid = 18023;}// file: 8
			case 18023:{cid = 18029;}// file: 8
			case 18029:{cid = 18056;}// file: 8
			case 18056:{cid = 18058;}// file: 8
			case 18058:{cid = 18237;}// file: 8
			case 18237:{cid = 18239;}// file: 8
			case 18239:{cid = 18242;}// file: 8
			case 18242:{cid = 3988;}// file: 8
			case 3988:{cid = 4001;}// file: 10
			case 4001:{cid = 4004;}// file: 10
			case 4004:{cid = 4011;}// file: 10
			case 4011:{cid = 4018;}// file: 10
			case 4018:{cid = 4022;}// file: 10
			case 4022:{cid = 4048;}// file: 10
			case 4048:{cid = 4058;}// file: 10
			case 4058:{cid = 4059;}// file: 10
			case 4059:{cid = 4060;}// file: 10
			case 4060:{cid = 4112;}// file: 10
			case 4112:{cid = 4114;}// file: 10
			case 4114:{cid = 4117;}// file: 10
			case 4117:{cid = 4123;}// file: 10
			case 4123:{cid = 4176;}// file: 10
			case 4176:{cid = 4555;}// file: 10
			case 4555:{cid = 4593;}// file: 10
			case 4593:{cid = 4594;}// file: 10
			case 4594:{cid = 4682;}// file: 10
			case 4682:{cid = 4683;}// file: 10
			case 4683:{cid = 4708;}// file: 10
			case 4708:{cid = 4848;}// file: 10
			case 4848:{cid = 4850;}// file: 10
			case 4850:{cid = 4877;}// file: 10
			case 4877:{cid = 4880;}// file: 10
			case 4880:{cid = 4894;}// file: 10
			case 4894:{cid = 5016;}// file: 10
			case 5016:{cid = 5017;}// file: 10
			case 5017:{cid = 5040;}// file: 10
			case 5040:{cid = 5042;}// file: 10
			case 5042:{cid = 5110;}// file: 10
			case 5110:{cid = 5134;}// file: 10
			case 5134:{cid = 5136;}// file: 10
			case 5136:{cid = 5140;}// file: 10
			case 5140:{cid = 5142;}// file: 10
			case 5142:{cid = 5173;}// file: 10
			case 5173:{cid = 5179;}// file: 10
			case 5179:{cid = 5181;}// file: 10
			case 5181:{cid = 5182;}// file: 10
			case 5182:{cid = 5187;}// file: 10
			case 5187:{cid = 5267;}// file: 10
			case 5267:{cid = 5392;}// file: 10
			case 5392:{cid = 5393;}// file: 10
			case 5393:{cid = 5410;}// file: 10
			case 5410:{cid = 5414;}// file: 10
			case 5414:{cid = 5521;}// file: 10
			case 5521:{cid = 5532;}// file: 10
			case 5532:{cid = 5628;}// file: 10
			case 5628:{cid = 5704;}// file: 10
			case 5704:{cid = 5709;}// file: 10
			case 5709:{cid = 5717;}// file: 10
			case 5717:{cid = 5719;}// file: 10
			case 5719:{cid = 5721;}// file: 10
			case 5721:{cid = 5725;}// file: 10
			case 5725:{cid = 5726;}// file: 10
			case 5726:{cid = 5727;}// file: 10
			case 5727:{cid = 5729;}// file: 10
			case 5729:{cid = 5730;}// file: 10
			case 5730:{cid = 5731;}// file: 10
			case 5731:{cid = 5733;}// file: 10
			case 5733:{cid = 5734;}// file: 10
			case 5734:{cid = 5737;}// file: 10
			case 5737:{cid = 5738;}// file: 10
			case 5738:{cid = 5760;}// file: 10
			case 5760:{cid = 5761;}// file: 10
			case 5761:{cid = 5762;}// file: 10
			case 5762:{cid = 5765;}// file: 10
			case 5765:{cid = 5768;}// file: 10
			case 5768:{cid = 5769;}// file: 10
			case 5769:{cid = 5771;}// file: 10
			case 5771:{cid = 5781;}// file: 10
			case 5781:{cid = 5782;}// file: 10
			case 5782:{cid = 5784;}// file: 10
			case 5784:{cid = 5787;}// file: 10
			case 5787:{cid = 5792;}// file: 10
			case 5792:{cid = 5810;}// file: 10
			case 5810:{cid = 5813;}// file: 10
			case 5813:{cid = 5819;}// file: 10
			case 5819:{cid = 5848;}// file: 10
			case 5848:{cid = 5870;}// file: 10
			case 5870:{cid = 5896;}// file: 10
			case 5896:{cid = 6048;}// file: 10
			case 6048:{cid = 6053;}// file: 10
			case 6053:{cid = 6060;}// file: 10
			case 6060:{cid = 6061;}// file: 10
			case 6061:{cid = 6095;}// file: 10
			case 6095:{cid = 6096;}// file: 10
			case 6096:{cid = 6098;}// file: 10
			case 6098:{cid = 6103;}// file: 10
			case 6103:{cid = 6104;}// file: 10
			case 6104:{cid = 6130;}// file: 10
			case 6130:{cid = 6145;}// file: 10
			case 6145:{cid = 6150;}// file: 10
			case 6150:{cid = 6151;}// file: 10
			case 6151:{cid = 6157;}// file: 10
			case 6157:{cid = 6158;}// file: 10
			case 6158:{cid = 6186;}// file: 10
			case 6186:{cid = 6187;}// file: 10
			case 6187:{cid = 6282;}// file: 10
			case 6282:{cid = 6334;}// file: 10
			case 6334:{cid = 6338;}// file: 10
			case 6338:{cid = 6354;}// file: 10
			case 6354:{cid = 6355;}// file: 10
			case 6355:{cid = 6369;}// file: 10
			case 6369:{cid = 6406;}// file: 10
			case 6406:{cid = 6488;}// file: 10
			case 6488:{cid = 6908;}// file: 10
			case 6908:{cid = 6919;}// file: 10
			case 6919:{cid = 6924;}// file: 10
			case 6924:{cid = 6944;}// file: 10
			case 6944:{cid = 6946;}// file: 10
			case 6946:{cid = 6947;}// file: 10
			case 6947:{cid = 6977;}// file: 10
			case 6977:{cid = 7088;}// file: 10
			case 7088:{cid = 7234;}// file: 10
			case 7234:{cid = 7424;}// file: 10
			case 7424:{cid = 7493;}// file: 10
			case 7493:{cid = 7506;}// file: 10
			case 7506:{cid = 7507;}// file: 10
			case 7507:{cid = 7508;}// file: 10
			case 7508:{cid = 7510;}// file: 10
			case 7510:{cid = 7526;}// file: 10
			case 7526:{cid = 7529;}// file: 10
			case 7529:{cid = 7531;}// file: 10
			case 7531:{cid = 7554;}// file: 10
			case 7554:{cid = 7599;}// file: 10
			case 7599:{cid = 7650;}// file: 10
			case 7650:{cid = 7658;}// file: 10
			case 7658:{cid = 7985;}// file: 10
			case 7985:{cid = 8068;}// file: 10
			case 8068:{cid = 8242;}// file: 10
			case 8242:{cid = 8401;}// file: 10
			case 8401:{cid = 8403;}// file: 10
			case 8403:{cid = 8432;}// file: 10
			case 8432:{cid = 8435;}// file: 10
			case 8435:{cid = 8436;}// file: 10
			case 8436:{cid = 8494;}// file: 10
			case 8494:{cid = 8495;}// file: 10
			case 8495:{cid = 8496;}// file: 10
			case 8496:{cid = 8503;}// file: 10
			case 8503:{cid = 8504;}// file: 10
			case 8504:{cid = 8505;}// file: 10
			case 8505:{cid = 8506;}// file: 10
			case 8506:{cid = 8507;}// file: 10
			case 8507:{cid = 8508;}// file: 10
			case 8508:{cid = 8509;}// file: 10
			case 8509:{cid = 8516;}// file: 10
			case 8516:{cid = 8567;}// file: 10
			case 8567:{cid = 8569;}// file: 10
			case 8569:{cid = 8570;}// file: 10
			case 8570:{cid = 8571;}// file: 10
			case 8571:{cid = 8581;}// file: 10
			case 8581:{cid = 8639;}// file: 10
			case 8639:{cid = 8643;}// file: 10
			case 8643:{cid = 8668;}// file: 10
			case 8668:{cid = 8687;}// file: 10
			case 8687:{cid = 8688;}// file: 10
			case 8688:{cid = 8689;}// file: 10
			case 8689:{cid = 8839;}// file: 10
			case 8839:{cid = 8842;}// file: 10
			case 8842:{cid = 8849;}// file: 10
			case 8849:{cid = 9054;}// file: 10
			case 9054:{cid = 9055;}// file: 10
			case 9055:{cid = 9162;}// file: 10
			case 9162:{cid = 9163;}// file: 10
			case 9163:{cid = 9299;}// file: 10
			case 9299:{cid = 9300;}// file: 10
			case 9300:{cid = 9301;}// file: 10
			case 9301:{cid = 9302;}// file: 10
			case 9302:{cid = 9303;}// file: 10
			case 9303:{cid = 9494;}// file: 10
			case 9494:{cid = 9514;}// file: 10
			case 9514:{cid = 9595;}// file: 10
			case 9595:{cid = 9906;}// file: 10
			case 9906:{cid = 9908;}// file: 10
			case 9908:{cid = 9910;}// file: 10
			case 9910:{cid = 9911;}// file: 10
			case 9911:{cid = 9912;}// file: 10
			case 9912:{cid = 9913;}// file: 10
			case 9913:{cid = 9914;}// file: 10
			case 9914:{cid = 9917;}// file: 10
			case 9917:{cid = 9921;}// file: 10
			case 9921:{cid = 9922;}// file: 10
			case 9922:{cid = 9923;}// file: 10
			case 9923:{cid = 9924;}// file: 10
			case 9924:{cid = 9925;}// file: 10
			case 9925:{cid = 9926;}// file: 10
			case 9926:{cid = 9928;}// file: 10
			case 9928:{cid = 9929;}// file: 10
			case 9929:{cid = 9953;}// file: 10
			case 9953:{cid = 10025;}// file: 10
			case 10025:{cid = 10028;}// file: 10
			case 10028:{cid = 10030;}// file: 10
			case 10030:{cid = 10035;}// file: 10
			case 10035:{cid = 10037;}// file: 10
			case 10037:{cid = 10038;}// file: 10
			case 10038:{cid = 10039;}// file: 10
			case 10039:{cid = 10045;}// file: 10
			case 10045:{cid = 10046;}// file: 10
			case 10046:{cid = 10052;}// file: 10
			case 10052:{cid = 10054;}// file: 10
			case 10054:{cid = 10142;}// file: 10
			case 10142:{cid = 10148;}// file: 10
			case 10148:{cid = 10288;}// file: 10
			case 10288:{cid = 10369;}// file: 10
			case 10369:{cid = 10375;}// file: 10
			case 10375:{cid = 10376;}// file: 10
			case 10376:{cid = 10383;}// file: 10
			case 10383:{cid = 10388;}// file: 10
			case 10388:{cid = 10390;}// file: 10
			case 10390:{cid = 10391;}// file: 10
			case 10391:{cid = 10392;}// file: 10
			case 10392:{cid = 10393;}// file: 10
			case 10393:{cid = 10423;}// file: 10
			case 10423:{cid = 10428;}// file: 10
			case 10428:{cid = 10429;}// file: 10
			case 10429:{cid = 10430;}// file: 10
			case 10430:{cid = 10431;}// file: 10
			case 10431:{cid = 10432;}// file: 10
			case 10432:{cid = 10434;}// file: 10
			case 10434:{cid = 10435;}// file: 10
			case 10435:{cid = 10439;}// file: 10
			case 10439:{cid = 10441;}// file: 10
			case 10441:{cid = 10447;}// file: 10
			case 10447:{cid = 10624;}// file: 10
			case 10624:{cid = 10625;}// file: 10
			case 10625:{cid = 10626;}// file: 10
			case 10626:{cid = 10627;}// file: 10
			case 10627:{cid = 10628;}// file: 10
			case 10628:{cid = 10630;}// file: 10
			case 10630:{cid = 10633;}// file: 10
			case 10633:{cid = 10722;}// file: 10
			case 10722:{cid = 10891;}// file: 10
			case 10891:{cid = 10925;}// file: 10
			case 10925:{cid = 10949;}// file: 10
			case 10949:{cid = 10950;}// file: 10
			case 10950:{cid = 10951;}// file: 10
			case 10951:{cid = 10952;}// file: 10
			case 10952:{cid = 10953;}// file: 10
			case 10953:{cid = 10973;}// file: 10
			case 10973:{cid = 10974;}// file: 10
			case 10974:{cid = 10975;}// file: 10
			case 10975:{cid = 10977;}// file: 10
			case 10977:{cid = 10978;}// file: 10
			case 10978:{cid = 10979;}// file: 10
			case 10979:{cid = 10980;}// file: 10
			case 10980:{cid = 10981;}// file: 10
			case 10981:{cid = 10982;}// file: 10
			case 10982:{cid = 10994;}// file: 10
			case 10994:{cid = 10996;}// file: 10
			case 10996:{cid = 10997;}// file: 10
			case 10997:{cid = 10999;}// file: 10
			case 10999:{cid = 11000;}// file: 10
			case 11000:{cid = 11092;}// file: 10
			case 11092:{cid = 11301;}// file: 10
			case 11301:{cid = 11312;}// file: 10
			case 11312:{cid = 11314;}// file: 10
			case 11314:{cid = 11315;}// file: 10
			case 11315:{cid = 11317;}// file: 10
			case 11317:{cid = 11434;}// file: 10
			case 11434:{cid = 11436;}// file: 10
			case 11436:{cid = 11449;}// file: 10
			case 11449:{cid = 11450;}// file: 10
			case 11450:{cid = 11456;}// file: 10
			case 11456:{cid = 11471;}// file: 10
			case 11471:{cid = 11475;}// file: 10
			case 11475:{cid = 11497;}// file: 10
			case 11497:{cid = 11545;}// file: 10
			case 11545:{cid = 11546;}// file: 10
			case 11546:{cid = 11615;}// file: 10
			case 11615:{cid = 12822;}// file: 10
			case 12822:{cid = 12841;}// file: 10
			case 12841:{cid = 12843;}// file: 10
			case 12843:{cid = 12844;}// file: 10
			case 12844:{cid = 12845;}// file: 10
			case 12845:{cid = 12849;}// file: 10
			case 12849:{cid = 12850;}// file: 10
			case 12850:{cid = 12855;}// file: 10
			case 12855:{cid = 12862;}// file: 10
			case 12862:{cid = 12863;}// file: 10
			case 12863:{cid = 12923;}// file: 10
			case 12923:{cid = 12944;}// file: 10
			case 12944:{cid = 12945;}// file: 10
			case 12945:{cid = 12946;}// file: 10
			case 12946:{cid = 12947;}// file: 10
			case 12947:{cid = 12948;}// file: 10
			case 12948:{cid = 12949;}// file: 10
			case 12949:{cid = 12951;}// file: 10
			case 12951:{cid = 12953;}// file: 10
			case 12953:{cid = 12962;}// file: 10
			case 12962:{cid = 12963;}// file: 10
			case 12963:{cid = 12964;}// file: 10
			case 12964:{cid = 12979;}// file: 10
			case 12979:{cid = 12980;}// file: 10
			case 12980:{cid = 12982;}// file: 10
			case 12982:{cid = 12984;}// file: 10
			case 12984:{cid = 13008;}// file: 10
			case 13008:{cid = 13012;}// file: 10
			case 13012:{cid = 13013;}// file: 10
			case 13013:{cid = 13014;}// file: 10
			case 13014:{cid = 13015;}// file: 10
			case 13015:{cid = 13022;}// file: 10
			case 13022:{cid = 13131;}// file: 10
			case 13131:{cid = 13363;}// file: 10
			case 13363:{cid = 13364;}// file: 10
			case 13364:{cid = 13761;}// file: 10
			case 13761:{cid = 14531;}// file: 10
			case 14531:{cid = 14661;}// file: 10
			case 14661:{cid = 14664;}// file: 10
			case 14664:{cid = 14665;}// file: 10
			case 14665:{cid = 14667;}// file: 10
			case 14667:{cid = 14670;}// file: 10
			case 14670:{cid = 14671;}// file: 10
			case 14671:{cid = 14672;}// file: 10
			case 14672:{cid = 14676;}// file: 10
			case 14676:{cid = 14682;}// file: 10
			case 14682:{cid = 14689;}// file: 10
			case 14689:{cid = 14668;}// file: 10
			case 14668:{cid = 14669;}// file: 10
			case 14669:{cid = 16005;}// file: 10
			case 16005:{cid = 16007;}// file: 10
			case 16007:{cid = 16011;}// file: 10
			case 16011:{cid = 16053;}// file: 10
			case 16053:{cid = 16054;}// file: 10
			case 16054:{cid = 16064;}// file: 10
			case 16064:{cid = 16065;}// file: 10
			case 16065:{cid = 16068;}// file: 10
			case 16068:{cid = 16069;}// file: 10
			case 16069:{cid = 16361;}// file: 10
			case 16361:{cid = 16396;}// file: 10
			case 16396:{cid = 16475;}// file: 10
			case 16475:{cid = 17066;}// file: 10
			case 17066:{cid = 17503;}// file: 10
			case 17503:{cid = 17508;}// file: 10
			case 17508:{cid = 17517;}// file: 10
			case 17517:{cid = 17519;}// file: 10
			case 17519:{cid = 17520;}// file: 10
			case 17520:{cid = 17521;}// file: 10
			case 17521:{cid = 17522;}// file: 10
			case 17522:{cid = 17524;}// file: 10
			case 17524:{cid = 17526;}// file: 10
			case 17526:{cid = 17529;}// file: 10
			case 17529:{cid = 17531;}// file: 10
			case 17531:{cid = 17536;}// file: 10
			case 17536:{cid = 17537;}// file: 10
			case 17537:{cid = 17542;}// file: 10
			case 17542:{cid = 17543;}// file: 10
			case 17543:{cid = 17544;}// file: 10
			case 17544:{cid = 17577;}// file: 10
			case 17577:{cid = 17853;}// file: 10
			case 17853:{cid = 17862;}// file: 10
			case 17862:{cid = 18007;}// file: 10
			case 18007:{cid = 18008;}// file: 10
			case 18008:{cid = 18025;}// file: 10
			case 18025:{cid = 18026;}// file: 10
			case 18026:{cid = 18027;}// file: 10
			case 18027:{cid = 18030;}// file: 10
			case 18030:{cid = 18031;}// file: 10
			case 18031:{cid = 18038;}// file: 10
			case 18038:{cid = 18082;}// file: 10
			case 18082:{cid = 18083;}// file: 10
			case 18083:{cid = 18088;}// file: 10
			case 18088:{cid = 18203;}// file: 10
			case 18203:{cid = 18233;}// file: 10
			case 18233:{cid = 18238;}// file: 10
			case 18238:{cid = 18240;}// file: 10
			case 18240:{cid = 18241;}// file: 10
			case 18241:{cid = 18261;}// file: 10
			case 18261:{cid = 18264;}// file: 10
			case 18264:{cid = 18265;}// file: 10
			case 18265:{cid = 18266;}// file: 10
			case 18266:{cid = 18282;}// file: 10
			case 18282:{cid = 1376;}// file: 10
			case 1376:{cid = 1378;}// file: 11
			case 1378:{cid = 1380;}// file: 11
			case 1380:{cid = 1381;}// file: 11
			case 1381:{cid = 1383;}// file: 11
			case 1383:{cid = 1384;}// file: 11
			case 1384:{cid = 1386;}// file: 11
			case 1386:{cid = 1387;}// file: 11
			case 1387:{cid = 1388;}// file: 11
			case 1388:{cid = 1389;}// file: 11
			case 1389:{cid = 1390;}// file: 11
			case 1390:{cid = 1391;}// file: 11
			case 1391:{cid = 1392;}// file: 11
			case 1392:{cid = 1393;}// file: 11
			case 1393:{cid = 1394;}// file: 11
			case 1394:{cid = 1395;}// file: 11
			case 1395:{cid = 3474;}// file: 11
			case 3474:{cid = 5126;}// file: 11
			case 5126:{cid = 10825;}// file: 11
			case 10825:{cid = 11400;}// file: 11
			case 11400:{cid = 11401;}// file: 11
			case 11401:{cid = 11406;}// file: 11
			case 11406:{cid = 16328;}// file: 11
			case 16328:{cid = 16332;}// file: 11
			case 16332:{cid = 16337;}// file: 11
			case 16337:{cid = 16355;}// file: 11
			case 16355:{cid = 16356;}// file: 11
			case 16356:{cid = 914;}// file: 11
			case 914:{cid = 915;}// file: 13
			case 915:{cid = 919;}// file: 13
			case 919:{cid = 920;}// file: 13
			case 920:{cid = 927;}// file: 13
			case 927:{cid = 929;}// file: 13
			case 929:{cid = 934;}// file: 13
			case 934:{cid = 943;}// file: 13
			case 943:{cid = 958;}// file: 13
			case 958:{cid = 959;}// file: 13
			case 959:{cid = 1353;}// file: 13
			case 1353:{cid = 1354;}// file: 13
			case 1354:{cid = 1420;}// file: 13
			case 1420:{cid = 1617;}// file: 13
			case 1617:{cid = 1618;}// file: 13
			case 1618:{cid = 1623;}// file: 13
			case 1623:{cid = 1624;}// file: 13
			case 1624:{cid = 1625;}// file: 13
			case 1625:{cid = 1626;}// file: 13
			case 1626:{cid = 1628;}// file: 13
			case 1628:{cid = 1629;}// file: 13
			case 1629:{cid = 1630;}// file: 13
			case 1630:{cid = 1635;}// file: 13
			case 1635:{cid = 1687;}// file: 13
			case 1687:{cid = 1688;}// file: 13
			case 1688:{cid = 1689;}// file: 13
			case 1689:{cid = 1690;}// file: 13
			case 1690:{cid = 1691;}// file: 13
			case 1691:{cid = 2649;}// file: 13
			case 2649:{cid = 2653;}// file: 13
			case 2653:{cid = 3214;}// file: 13
			case 3214:{cid = 3255;}// file: 13
			case 3255:{cid = 3256;}// file: 13
			case 3256:{cid = 3257;}// file: 13
			case 3257:{cid = 3258;}// file: 13
			case 3258:{cid = 3259;}// file: 13
			case 3259:{cid = 3272;}// file: 13
			case 3272:{cid = 3273;}// file: 13
			case 3273:{cid = 3287;}// file: 13
			case 3287:{cid = 3384;}// file: 13
			case 3384:{cid = 3427;}// file: 13
			case 3427:{cid = 3470;}// file: 13
			case 3470:{cid = 3502;}// file: 13
			case 3502:{cid = 3529;}// file: 13
			case 3529:{cid = 3530;}// file: 13
			case 3530:{cid = 3631;}// file: 13
			case 3631:{cid = 3636;}// file: 13
			case 3636:{cid = 3637;}// file: 13
			case 3637:{cid = 3638;}// file: 13
			case 3638:{cid = 3643;}// file: 13
			case 3643:{cid = 3673;}// file: 13
			case 3673:{cid = 3675;}// file: 13
			case 3675:{cid = 3804;}// file: 13
			case 3804:{cid = 3805;}// file: 13
			case 3805:{cid = 3812;}// file: 13
			case 3812:{cid = 3813;}// file: 13
			case 3813:{cid = 3865;}// file: 13
			case 3865:{cid = 6867;}// file: 13
			case 6867:{cid = 6928;}// file: 13
			case 6928:{cid = 6929;}// file: 13
			case 6929:{cid = 6930;}// file: 13
			case 6930:{cid = 6931;}// file: 13
			case 6931:{cid = 6932;}// file: 13
			case 6932:{cid = 6933;}// file: 13
			case 6933:{cid = 6934;}// file: 13
			case 6934:{cid = 7024;}// file: 13
			case 7024:{cid = 7103;}// file: 13
			case 7103:{cid = 7105;}// file: 13
			case 7105:{cid = 7201;}// file: 13
			case 7201:{cid = 7236;}// file: 13
			case 7236:{cid = 7238;}// file: 13
			case 7238:{cid = 7291;}// file: 13
			case 7291:{cid = 7947;}// file: 13
			case 7947:{cid = 7950;}// file: 13
			case 7950:{cid = 10675;}// file: 13
			case 10675:{cid = 11147;}// file: 13
			case 11147:{cid = 11148;}// file: 13
			case 11148:{cid = 11149;}// file: 13
			case 11149:{cid = 11484;}// file: 13
			case 11484:{cid = 11485;}// file: 13
			case 11485:{cid = 11486;}// file: 13
			case 11486:{cid = 11487;}// file: 13
			case 11487:{cid = 12911;}// file: 13
			case 12986:{cid = 14573;}// file: 13
			case 14573:{cid = 14584;}// file: 13
			case 14584:{cid = 14635;}// file: 13
			case 14635:{cid = 14882;}// file: 13
			case 14882:{cid = 16071;}// file: 13
			case 16071:{cid = 16072;}// file: 13
			case 16072:{cid = 16073;}// file: 13
			case 16073:{cid = 16074;}// file: 13
			case 16074:{cid = 16075;}// file: 13
			case 16075:{cid = 16076;}// file: 13
			case 16076:{cid = 16078;}// file: 13
			case 16078:{cid = 16079;}// file: 13
			case 16079:{cid = 16080;}// file: 13
			case 16080:{cid = 16081;}// file: 13
			case 16081:{cid = 16083;}// file: 13
			case 16083:{cid = 16086;}// file: 13
			case 16086:{cid = 16087;}// file: 13
			case 16087:{cid = 16267;}// file: 13
			case 16267:{cid = 16301;}// file: 13
			case 16301:{cid = 16309;}// file: 13
			case 16309:{cid = 16311;}// file: 13
			case 16311:{cid = 16314;}// file: 13
			case 16314:{cid = 16316;}// file: 13
			case 16316:{cid = 16318;}// file: 13
			case 16318:{cid = 16340;}// file: 13
			case 16340:{cid = 16342;}// file: 13
			case 16342:{cid = 16345;}// file: 13
			case 16345:{cid = 16346;}// file: 13
			case 16346:{cid = 16349;}// file: 13
			case 16349:{cid = 16395;}// file: 13
			case 16395:{cid = 16446;}// file: 13
			case 16446:{cid = 16481;}// file: 13
			case 16481:{cid = 16530;}// file: 13
			case 16530:{cid = 16531;}// file: 13
			case 16531:{cid = 16532;}// file: 13
			case 16532:{cid = 16533;}// file: 13
			case 16533:{cid = 16534;}// file: 13
			case 16534:{cid = 16535;}// file: 13
			case 16535:{cid = 16666;}// file: 13
			case 16666:{cid = 16766;}// file: 13
			case 16766:{cid = 17001;}// file: 13
			case 17001:{cid = 18201;}// file: 13
			case 18201:{cid = 1455;}// file: 13
			case 1455:{cid = 1484;}// file: 14
			case 1484:{cid = 1485;}// file: 14
			case 1485:{cid = 1486;}// file: 14
			case 1486:{cid = 1487;}// file: 14
			case 1487:{cid = 1488;}// file: 14
			case 1488:{cid = 1509;}// file: 14
			case 1509:{cid = 1510;}// file: 14
			case 1510:{cid = 1511;}// file: 14
			case 1511:{cid = 1512;}// file: 14
			case 1512:{cid = 1517;}// file: 14
			case 1517:{cid = 1520;}// file: 14
			case 1520:{cid = 1541;}// file: 14
			case 1541:{cid = 1542;}// file: 14
			case 1542:{cid = 1543;}// file: 14
			case 1543:{cid = 1544;}// file: 14
			case 1544:{cid = 1545;}// file: 14
			case 1545:{cid = 1546;}// file: 14
			case 1546:{cid = 1547;}// file: 14
			case 1547:{cid = 1548;}// file: 14
			case 1548:{cid = 1551;}// file: 14
			case 1551:{cid = 1664;}// file: 14
			case 1664:{cid = 1665;}// file: 14
			case 1665:{cid = 1666;}// file: 14
			case 1666:{cid = 1667;}// file: 14
			case 1667:{cid = 1668;}// file: 14
			case 1668:{cid = 1669;}// file: 14
			case 1669:{cid = 1732;}// file: 14
			case 1732:{cid = 1950;}// file: 14
			case 1950:{cid = 1951;}// file: 14
			case 1951:{cid = 14565;}// file: 14
			case 14565:{cid = 16151;}// file: 14
			case 16151:{cid = 16152;}// file: 14
			case 16152:{cid = 1515;}// file: 14
			case 1515:{cid = 1830;}// file: 15
			case 1830:{cid = 1831;}// file: 15
			case 1831:{cid = 1832;}// file: 15
			case 1832:{cid = 1833;}// file: 15
			case 1833:{cid = 1834;}// file: 15
			case 1834:{cid = 1835;}// file: 15
			case 1835:{cid = 1836;}// file: 15
			case 1836:{cid = 1837;}// file: 15
			case 1837:{cid = 1838;}// file: 15
			case 1838:{cid = 1851;}// file: 15
			case 1851:{cid = 1852;}// file: 15
			case 1852:{cid = 1853;}// file: 15
			case 1853:{cid = 1854;}// file: 15
			case 1854:{cid = 1855;}// file: 15
			case 1855:{cid = 1856;}// file: 15
			case 1856:{cid = 1857;}// file: 15
			case 1857:{cid = 1858;}// file: 15
			case 1858:{cid = 1859;}// file: 15
			case 1859:{cid = 1860;}// file: 15
			case 1860:{cid = 1861;}// file: 15
			case 1861:{cid = 1862;}// file: 15
			case 1862:{cid = 1863;}// file: 15
			case 1863:{cid = 1864;}// file: 15
			case 1864:{cid = 1865;}// file: 15
			case 1865:{cid = 1866;}// file: 15
			case 1866:{cid = 1867;}// file: 15
			case 1867:{cid = 1868;}// file: 15
			case 1868:{cid = 1869;}// file: 15
			case 1869:{cid = 1870;}// file: 15
			case 1870:{cid = 1871;}// file: 15
			case 1871:{cid = 1872;}// file: 15
			case 1872:{cid = 1873;}// file: 15
			case 1873:{cid = 1874;}// file: 15
			case 1874:{cid = 1875;}// file: 15
			case 1875:{cid = 1876;}// file: 15
			case 1876:{cid = 1877;}// file: 15
			case 1877:{cid = 1878;}// file: 15
			case 1878:{cid = 1879;}// file: 15
			case 1879:{cid = 1880;}// file: 15
			case 1880:{cid = 1881;}// file: 15
			case 1881:{cid = 1882;}// file: 15
			case 1882:{cid = 1895;}// file: 15
			case 1895:{cid = 1897;}// file: 15
			case 1897:{cid = 1898;}// file: 15
			case 1898:{cid = 1899;}// file: 15
			case 1899:{cid = 1900;}// file: 15
			case 1900:{cid = 1901;}// file: 15
			case 1901:{cid = 1902;}// file: 15
			case 1902:{cid = 1903;}// file: 15
			case 1903:{cid = 1904;}// file: 15
			case 1904:{cid = 1905;}// file: 15
			case 1905:{cid = 1906;}// file: 15
			case 1906:{cid = 1907;}// file: 15
			case 1907:{cid = 1908;}// file: 15
			case 1908:{cid = 1909;}// file: 15
			case 1909:{cid = 1910;}// file: 15
			case 1910:{cid = 1911;}// file: 15
			case 1911:{cid = 1912;}// file: 15
			case 1912:{cid = 1913;}// file: 15
			case 1913:{cid = 1914;}// file: 15
			case 1914:{cid = 1915;}// file: 15
			case 1915:{cid = 1916;}// file: 15
			case 1916:{cid = 1917;}// file: 15
			case 1917:{cid = 1918;}// file: 15
			case 1918:{cid = 1919;}// file: 15
			case 1919:{cid = 1920;}// file: 15
			case 1920:{cid = 1921;}// file: 15
			case 1921:{cid = 1922;}// file: 15
			case 1922:{cid = 1923;}// file: 15
			case 1923:{cid = 1924;}// file: 15
			case 1924:{cid = 1925;}// file: 15
			case 1925:{cid = 1926;}// file: 15
			case 1926:{cid = 1927;}// file: 15
			case 1927:{cid = 1928;}// file: 15
			case 1928:{cid = 1929;}// file: 15
			case 1929:{cid = 1930;}// file: 15
			case 1930:{cid = 1931;}// file: 15
			case 1931:{cid = 1932;}// file: 15
			case 1932:{cid = 1933;}// file: 15
			case 1933:{cid = 1934;}// file: 15
			case 1934:{cid = 1935;}// file: 15
			case 1935:{cid = 1936;}// file: 15
			case 1936:{cid = 1937;}// file: 15
			case 1937:{cid = 1938;}// file: 15
			case 1938:{cid = 1939;}// file: 15
			case 1939:{cid = 1940;}// file: 15
			case 1940:{cid = 1941;}// file: 15
			case 1941:{cid = 1942;}// file: 15
			case 1942:{cid = 1943;}// file: 15
			case 1943:{cid = 1944;}// file: 15
			case 1944:{cid = 1945;}// file: 15
			case 1945:{cid = 1947;}// file: 15
			case 1947:{cid = 1948;}// file: 15
			case 1948:{cid = 1952;}// file: 15
			case 1952:{cid = 1953;}// file: 15
			case 1953:{cid = 1955;}// file: 15
			case 1955:{cid = 1956;}// file: 15
			case 1956:{cid = 1978;}// file: 15
			case 1978:{cid = 1979;}// file: 15
			case 1979:{cid = 2188;}// file: 15
			case 2188:{cid = 2189;}// file: 15
			case 2189:{cid = 2324;}// file: 15
			case 2324:{cid = 2325;}// file: 15
			case 2325:{cid = 2326;}// file: 15
			case 2326:{cid = 2327;}// file: 15
			case 2327:{cid = 2347;}// file: 15
			case 2347:{cid = 2348;}// file: 15
			case 2348:{cid = 2349;}// file: 15
			case 2349:{cid = 2618;}// file: 15
			case 2618:{cid = 2640;}// file: 15
			case 2640:{cid = 2681;}// file: 15
			case 2681:{cid = 2754;}// file: 15
			case 2754:{cid = 2778;}// file: 15
			case 2778:{cid = 2779;}// file: 15
			case 2779:{cid = 2783;}// file: 15
			case 2783:{cid = 2785;}// file: 15
			case 2785:{cid = 2872;}// file: 15
			case 2872:{cid = 3430;}// file: 15
			case 3430:{cid = 3437;}// file: 15
			case 3437:{cid = 3438;}// file: 15
			case 3438:{cid = 3440;}// file: 15
			case 3440:{cid = 3441;}// file: 15
			case 3441:{cid = 3494;}// file: 15
			case 3494:{cid = 3498;}// file: 15
			case 3498:{cid = 3499;}// file: 15
			case 3499:{cid = 3503;}// file: 15
			case 3503:{cid = 14566;}// file: 15
			case 14566:{cid = 14567;}// file: 15
			case 14567:{cid = 14568;}// file: 15
			case 14568:{cid = 14582;}// file: 15
			case 14582:{cid = 2052;}// file: 15
			case 2052:{cid = 2053;}// file: 16
			case 2053:{cid = 2054;}// file: 16
			case 2054:{cid = 2371;}// file: 16
			case 2371:{cid = 2372;}// file: 16
			case 2372:{cid = 2373;}// file: 16
			case 2373:{cid = 2374;}// file: 16
			case 2374:{cid = 2377;}// file: 16
			case 2377:{cid = 2378;}// file: 16
			case 2378:{cid = 2380;}// file: 16
			case 2380:{cid = 2381;}// file: 16
			case 2381:{cid = 2382;}// file: 16
			case 2382:{cid = 2383;}// file: 16
			case 2383:{cid = 2384;}// file: 16
			case 2384:{cid = 2386;}// file: 16
			case 2386:{cid = 2389;}// file: 16
			case 2389:{cid = 2390;}// file: 16
			case 2390:{cid = 2391;}// file: 16
			case 2391:{cid = 2392;}// file: 16
			case 2392:{cid = 2394;}// file: 16
			case 2394:{cid = 2396;}// file: 16
			case 2396:{cid = 2397;}// file: 16
			case 2397:{cid = 2398;}// file: 16
			case 2398:{cid = 2399;}// file: 16
			case 2399:{cid = 2401;}// file: 16
			case 2401:{cid = 2402;}// file: 16
			case 2402:{cid = 2407;}// file: 16
			case 2407:{cid = 2408;}// file: 16
			case 2408:{cid = 2409;}// file: 16
			case 2409:{cid = 2411;}// file: 16
			case 2411:{cid = 2689;}// file: 16
			case 2689:{cid = 2704;}// file: 16
			case 2704:{cid = 2705;}// file: 16
			case 2705:{cid = 2706;}// file: 16
			case 2706:{cid = 2843;}// file: 16
			case 2843:{cid = 2844;}// file: 16
			case 2844:{cid = 2845;}// file: 16
			case 2845:{cid = 2846;}// file: 16
			case 2846:{cid = 14520;}// file: 16
			case 14520:{cid = 14521;}// file: 16
			case 14521:{cid = 14863;}// file: 16
			case 14863:{cid = 14864;}// file: 16
			case 14864:{cid = 15027;}// file: 16
			case 15027:{cid = 15028;}// file: 16
			case 15028:{cid = 18094;}// file: 16
			case 18094:{cid = 977;}// file: 16
			case 977:{cid = 1491;}// file: 17
			case 1491:{cid = 1492;}// file: 17
			case 1492:{cid = 1493;}// file: 17
			case 1493:{cid = 1494;}// file: 17
			case 1494:{cid = 1495;}// file: 17
			case 1495:{cid = 1496;}// file: 17
			case 1496:{cid = 1497;}// file: 17
			case 1497:{cid = 1498;}// file: 17
			case 1498:{cid = 1499;}// file: 17
			case 1499:{cid = 1500;}// file: 17
			case 1500:{cid = 1501;}// file: 17
			case 1501:{cid = 1502;}// file: 17
			case 1502:{cid = 1504;}// file: 17
			case 1504:{cid = 1505;}// file: 17
			case 1505:{cid = 1506;}// file: 17
			case 1506:{cid = 1507;}// file: 17
			case 1507:{cid = 1508;}// file: 17
			case 1508:{cid = 1522;}// file: 17
			case 1522:{cid = 1523;}// file: 17
			case 1523:{cid = 1532;}// file: 17
			case 1532:{cid = 1533;}// file: 17
			case 1533:{cid = 1534;}// file: 17
			case 1534:{cid = 1535;}// file: 17
			case 1535:{cid = 1536;}// file: 17
			case 1536:{cid = 1537;}// file: 17
			case 1537:{cid = 1538;}// file: 17
			case 1538:{cid = 1555;}// file: 17
			case 1555:{cid = 1556;}// file: 17
			case 1556:{cid = 1557;}// file: 17
			case 1557:{cid = 1560;}// file: 17
			case 1560:{cid = 1561;}// file: 17
			case 1561:{cid = 1566;}// file: 17
			case 1566:{cid = 1567;}// file: 17
			case 1567:{cid = 1569;}// file: 17
			case 1569:{cid = 1649;}// file: 17
			case 1649:{cid = 1651;}// file: 17
			case 1651:{cid = 1692;}// file: 17
			case 1692:{cid = 1693;}// file: 17
			case 1693:{cid = 1965;}// file: 17
			case 1965:{cid = 1966;}// file: 17
			case 1966:{cid = 1967;}// file: 17
			case 1967:{cid = 1980;}// file: 17
			case 1980:{cid = 2004;}// file: 17
			case 2004:{cid = 2558;}// file: 17
			case 2558:{cid = 2559;}// file: 17
			case 2559:{cid = 2560;}// file: 17
			case 2560:{cid = 2561;}// file: 17
			case 2561:{cid = 2634;}// file: 17
			case 2634:{cid = 2664;}// file: 17
			case 2664:{cid = 2873;}// file: 17
			case 2873:{cid = 2875;}// file: 17
			case 2875:{cid = 2876;}// file: 17
			case 2876:{cid = 2877;}// file: 17
			case 2877:{cid = 2878;}// file: 17
			case 2878:{cid = 2879;}// file: 17
			case 2879:{cid = 3278;}// file: 17
			case 3278:{cid = 3294;}// file: 17
			case 3294:{cid = 3352;}// file: 17
			case 3352:{cid = 3354;}// file: 17
			case 3354:{cid = 3851;}// file: 17
			case 3851:{cid = 4015;}// file: 17
			case 4015:{cid = 4084;}// file: 17
			case 4084:{cid = 5043;}// file: 17
			case 5043:{cid = 5302;}// file: 17
			case 5302:{cid = 5340;}// file: 17
			case 5340:{cid = 5422;}// file: 17
			case 5422:{cid = 5779;}// file: 17
			case 5779:{cid = 5856;}// file: 17
			case 5856:{cid = 6400;}// file: 17
			case 6400:{cid = 7927;}// file: 17
			case 7927:{cid = 7930;}// file: 17
			case 7930:{cid = 7931;}// file: 17
			case 7931:{cid = 8378;}// file: 17
			case 8378:{cid = 8948;}// file: 17
			case 8948:{cid = 9093;}// file: 17
			case 9093:{cid = 9099;}// file: 17
			case 9099:{cid = 9308;}// file: 17
			case 9308:{cid = 9625;}// file: 17
			case 9625:{cid = 9823;}// file: 17
			case 9823:{cid = 10024;}// file: 17
			case 10024:{cid = 10149;}// file: 17
			case 10149:{cid = 10154;}// file: 17
			case 10154:{cid = 10182;}// file: 17
			case 10182:{cid = 10246;}// file: 17
			case 10246:{cid = 10575;}// file: 17
			case 10575:{cid = 10632;}// file: 17
			case 10632:{cid = 10671;}// file: 17
			case 10671:{cid = 11007;}// file: 17
			case 11007:{cid = 11102;}// file: 17
			case 11102:{cid = 11103;}// file: 17
			case 11103:{cid = 11313;}// file: 17
			case 11313:{cid = 11319;}// file: 17
			case 11319:{cid = 11327;}// file: 17
			case 11327:{cid = 11359;}// file: 17
			case 11359:{cid = 11360;}// file: 17
			case 11360:{cid = 11416;}// file: 17
			case 11416:{cid = 13028;}// file: 17
			case 13028:{cid = 13187;}// file: 17
			case 13187:{cid = 13188;}// file: 17
			case 13188:{cid = 13360;}// file: 17
			case 13360:{cid = 13817;}// file: 17
			case 13817:{cid = 14443;}// file: 17
			case 14443:{cid = 14482;}// file: 17
			case 14482:{cid = 14483;}// file: 17
			case 14483:{cid = 14499;}// file: 17
			case 14499:{cid = 14522;}// file: 17
			case 14522:{cid = 14523;}// file: 17
			case 14523:{cid = 14598;}// file: 17
			case 14598:{cid = 14638;}// file: 17
			case 14638:{cid = 14740;}// file: 17
			case 14740:{cid = 14747;}// file: 17
			case 14747:{cid = 14751;}// file: 17
			case 14751:{cid = 14752;}// file: 17
			case 14752:{cid = 14753;}// file: 17
			case 14753:{cid = 14762;}// file: 17
			case 14762:{cid = 14819;}// file: 17
			case 14819:{cid = 14822;}// file: 17
			case 14822:{cid = 14823;}// file: 17
			case 14823:{cid = 14824;}// file: 17
			case 14824:{cid = 14852;}// file: 17
			case 14852:{cid = 14892;}// file: 17
			case 14892:{cid = 14902;}// file: 17
			case 14902:{cid = 16500;}// file: 17
			case 16500:{cid = 16501;}// file: 17
			case 16501:{cid = 16637;}// file: 17
			case 16637:{cid = 16773;}// file: 17
			case 16773:{cid = 16775;}// file: 17
			case 16775:{cid = 17564;}// file: 17
			case 17564:{cid = 17566;}// file: 17
			case 17566:{cid = 17951;}// file: 17
			case 17951:{cid = 18001;}// file: 17
			case 18001:{cid = 18072;}// file: 17
			case 18072:{cid = 18079;}// file: 17
			case 18079:{cid = 18080;}// file: 17
			case 18080:{cid = 18084;}// file: 17
			case 18084:{cid = 18095;}// file: 17
			case 18095:{cid = 18098;}// file: 17
			case 18098:{cid = 18553;}// file: 17
			case 18553:{cid = 1208;}// file: 17
			case 1208:{cid = 1481;}// file: 19
			case 1481:{cid = 1518;}// file: 19
			case 1518:{cid = 1659;}// file: 19
			case 1659:{cid = 1661;}// file: 19
			case 1661:{cid = 1700;}// file: 19
			case 1700:{cid = 1701;}// file: 19
			case 1701:{cid = 1717;}// file: 19
			case 1717:{cid = 1718;}// file: 19
			case 1718:{cid = 1719;}// file: 19
			case 1719:{cid = 1725;}// file: 19
			case 1725:{cid = 1736;}// file: 19
			case 1736:{cid = 1738;}// file: 19
			case 1738:{cid = 1745;}// file: 19
			case 1745:{cid = 1747;}// file: 19
			case 1747:{cid = 1748;}// file: 19
			case 1748:{cid = 1749;}// file: 19
			case 1749:{cid = 1750;}// file: 19
			case 1750:{cid = 1751;}// file: 19
			case 1751:{cid = 1752;}// file: 19
			case 1752:{cid = 1771;}// file: 19
			case 1771:{cid = 1778;}// file: 19
			case 1778:{cid = 1780;}// file: 19
			case 1780:{cid = 1781;}// file: 19
			case 1781:{cid = 1782;}// file: 19
			case 1782:{cid = 1783;}// file: 19
			case 1783:{cid = 1785;}// file: 19
			case 1785:{cid = 1786;}// file: 19
			case 1786:{cid = 1787;}// file: 19
			case 1787:{cid = 1788;}// file: 19
			case 1788:{cid = 1789;}// file: 19
			case 1789:{cid = 1790;}// file: 19
			case 1790:{cid = 1791;}// file: 19
			case 1791:{cid = 1792;}// file: 19
			case 1792:{cid = 1793;}// file: 19
			case 1793:{cid = 1794;}// file: 19
			case 1794:{cid = 1795;}// file: 19
			case 1795:{cid = 1796;}// file: 19
			case 1796:{cid = 1797;}// file: 19
			case 1797:{cid = 1798;}// file: 19
			case 1798:{cid = 1799;}// file: 19
			case 1799:{cid = 1800;}// file: 19
			case 1800:{cid = 1801;}// file: 19
			case 1801:{cid = 1802;}// file: 19
			case 1802:{cid = 1803;}// file: 19
			case 1803:{cid = 1804;}// file: 19
			case 1804:{cid = 1808;}// file: 19
			case 1808:{cid = 1809;}// file: 19
			case 1809:{cid = 1812;}// file: 19
			case 1812:{cid = 1828;}// file: 19
			case 1828:{cid = 1829;}// file: 19
			case 1829:{cid = 1839;}// file: 19
			case 1839:{cid = 1840;}// file: 19
			case 1840:{cid = 1841;}// file: 19
			case 1841:{cid = 1971;}// file: 19
			case 1971:{cid = 2002;}// file: 19
			case 2002:{cid = 2003;}// file: 19
			case 2003:{cid = 2005;}// file: 19
			case 2005:{cid = 2006;}// file: 19
			case 2006:{cid = 2013;}// file: 19
			case 2013:{cid = 2017;}// file: 19
			case 2017:{cid = 2028;}// file: 19
			case 2028:{cid = 2090;}// file: 19
			case 2090:{cid = 2091;}// file: 19
			case 2091:{cid = 2093;}// file: 19
			case 2093:{cid = 2097;}// file: 19
			case 2097:{cid = 2099;}// file: 19
			case 2099:{cid = 2100;}// file: 19
			case 2100:{cid = 2101;}// file: 19
			case 2101:{cid = 2102;}// file: 19
			case 2102:{cid = 2103;}// file: 19
			case 2103:{cid = 2104;}// file: 19
			case 2104:{cid = 2127;}// file: 19
			case 2127:{cid = 2130;}// file: 19
			case 2130:{cid = 2131;}// file: 19
			case 2131:{cid = 2132;}// file: 19
			case 2132:{cid = 2135;}// file: 19
			case 2135:{cid = 2136;}// file: 19
			case 2136:{cid = 2144;}// file: 19
			case 2144:{cid = 2146;}// file: 19
			case 2146:{cid = 2147;}// file: 19
			case 2147:{cid = 2149;}// file: 19
			case 2149:{cid = 2150;}// file: 19
			case 2150:{cid = 2170;}// file: 19
			case 2170:{cid = 2186;}// file: 19
			case 2186:{cid = 2190;}// file: 19
			case 2190:{cid = 2192;}// file: 19
			case 2192:{cid = 2201;}// file: 19
			case 2201:{cid = 2202;}// file: 19
			case 2202:{cid = 2224;}// file: 19
			case 2224:{cid = 2225;}// file: 19
			case 2225:{cid = 2226;}// file: 19
			case 2226:{cid = 2227;}// file: 19
			case 2227:{cid = 2229;}// file: 19
			case 2229:{cid = 2230;}// file: 19
			case 2230:{cid = 2231;}// file: 19
			case 2231:{cid = 2232;}// file: 19
			case 2232:{cid = 2233;}// file: 19
			case 2233:{cid = 2294;}// file: 19
			case 2294:{cid = 2296;}// file: 19
			case 2296:{cid = 2297;}// file: 19
			case 2297:{cid = 2298;}// file: 19
			case 2298:{cid = 2299;}// file: 19
			case 2299:{cid = 2300;}// file: 19
			case 2300:{cid = 2301;}// file: 19
			case 2301:{cid = 2302;}// file: 19
			case 2302:{cid = 2312;}// file: 19
			case 2312:{cid = 2316;}// file: 19
			case 2316:{cid = 2317;}// file: 19
			case 2317:{cid = 2318;}// file: 19
			case 2318:{cid = 2320;}// file: 19
			case 2320:{cid = 2322;}// file: 19
			case 2322:{cid = 2331;}// file: 19
			case 2331:{cid = 2332;}// file: 19
			case 2332:{cid = 2333;}// file: 19
			case 2333:{cid = 2336;}// file: 19
			case 2336:{cid = 2337;}// file: 19
			case 2337:{cid = 2339;}// file: 19
			case 2339:{cid = 2340;}// file: 19
			case 2340:{cid = 2344;}// file: 19
			case 2344:{cid = 2360;}// file: 19
			case 2360:{cid = 2361;}// file: 19
			case 2361:{cid = 2415;}// file: 19
			case 2415:{cid = 2417;}// file: 19
			case 2417:{cid = 2421;}// file: 19
			case 2421:{cid = 2426;}// file: 19
			case 2426:{cid = 2452;}// file: 19
			case 2452:{cid = 2514;}// file: 19
			case 2514:{cid = 2515;}// file: 19
			case 2515:{cid = 2516;}// file: 19
			case 2516:{cid = 2517;}// file: 19
			case 2517:{cid = 2518;}// file: 19
			case 2518:{cid = 2519;}// file: 19
			case 2519:{cid = 2520;}// file: 19
			case 2520:{cid = 2521;}// file: 19
			case 2521:{cid = 2522;}// file: 19
			case 2522:{cid = 2523;}// file: 19
			case 2523:{cid = 2524;}// file: 19
			case 2524:{cid = 2525;}// file: 19
			case 2525:{cid = 2526;}// file: 19
			case 2526:{cid = 2527;}// file: 19
			case 2527:{cid = 2528;}// file: 19
			case 2528:{cid = 2563;}// file: 19
			case 2563:{cid = 2564;}// file: 19
			case 2564:{cid = 2565;}// file: 19
			case 2565:{cid = 2566;}// file: 19
			case 2566:{cid = 2575;}// file: 19
			case 2575:{cid = 2595;}// file: 19
			case 2595:{cid = 2596;}// file: 19
			case 2596:{cid = 2602;}// file: 19
			case 2602:{cid = 2603;}// file: 19
			case 2603:{cid = 2613;}// file: 19
			case 2613:{cid = 2627;}// file: 19
			case 2627:{cid = 2628;}// file: 19
			case 2628:{cid = 2629;}// file: 19
			case 2629:{cid = 2630;}// file: 19
			case 2630:{cid = 2631;}// file: 19
			case 2631:{cid = 2632;}// file: 19
			case 2632:{cid = 2648;}// file: 19
			case 2648:{cid = 2700;}// file: 19
			case 2700:{cid = 2713;}// file: 19
			case 2713:{cid = 2718;}// file: 19
			case 2718:{cid = 2738;}// file: 19
			case 2738:{cid = 2739;}// file: 19
			case 2739:{cid = 2741;}// file: 19
			case 2741:{cid = 2742;}// file: 19
			case 2742:{cid = 2812;}// file: 19
			case 2812:{cid = 2813;}// file: 19
			case 2813:{cid = 2815;}// file: 19
			case 2815:{cid = 2816;}// file: 19
			case 2816:{cid = 2817;}// file: 19
			case 2817:{cid = 2818;}// file: 19
			case 2818:{cid = 2819;}// file: 19
			case 2819:{cid = 2820;}// file: 19
			case 2820:{cid = 2822;}// file: 19
			case 2822:{cid = 2824;}// file: 19
			case 2824:{cid = 2826;}// file: 19
			case 2826:{cid = 2827;}// file: 19
			case 2827:{cid = 2828;}// file: 19
			case 2828:{cid = 2829;}// file: 19
			case 2829:{cid = 2830;}// file: 19
			case 2830:{cid = 2831;}// file: 19
			case 2831:{cid = 2832;}// file: 19
			case 2832:{cid = 2833;}// file: 19
			case 2833:{cid = 2834;}// file: 19
			case 2834:{cid = 2835;}// file: 19
			case 2835:{cid = 2836;}// file: 19
			case 2836:{cid = 2841;}// file: 19
			case 2841:{cid = 2842;}// file: 19
			case 2842:{cid = 2847;}// file: 19
			case 2847:{cid = 2848;}// file: 19
			case 2848:{cid = 2849;}// file: 19
			case 2849:{cid = 2850;}// file: 19
			case 2850:{cid = 2851;}// file: 19
			case 2851:{cid = 2852;}// file: 19
			case 2852:{cid = 2853;}// file: 19
			case 2853:{cid = 2854;}// file: 19
			case 2854:{cid = 2855;}// file: 19
			case 2855:{cid = 2862;}// file: 19
			case 2862:{cid = 2863;}// file: 19
			case 2863:{cid = 2864;}// file: 19
			case 2864:{cid = 2865;}// file: 19
			case 2865:{cid = 2868;}// file: 19
			case 2868:{cid = 2869;}// file: 19
			case 2869:{cid = 2870;}// file: 19
			case 2870:{cid = 5678;}// file: 19
			case 5678:{cid = 9437;}// file: 19
			case 9437:{cid = 9438;}// file: 19
			case 9438:{cid = 9439;}// file: 19
			case 9439:{cid = 9440;}// file: 19
			case 9440:{cid = 10249;}// file: 19
			case 10249:{cid = 11666;}// file: 19
			case 11666:{cid = 14384;}// file: 19
			case 14384:{cid = 14386;}// file: 19
			case 14386:{cid = 14391;}// file: 19
			case 14391:{cid = 14392;}// file: 19
			case 14392:{cid = 14393;}// file: 19
			case 14393:{cid = 14446;}// file: 19
			case 14446:{cid = 14457;}// file: 19
			case 14457:{cid = 14480;}// file: 19
			case 14480:{cid = 14481;}// file: 19
			case 14481:{cid = 14494;}// file: 19
			case 14494:{cid = 14515;}// file: 19
			case 14515:{cid = 14516;}// file: 19
			case 14516:{cid = 14517;}// file: 19
			case 14517:{cid = 14518;}// file: 19
			case 14518:{cid = 14519;}// file: 19
			case 14519:{cid = 14527;}// file: 19
			case 14527:{cid = 14532;}// file: 19
			case 14532:{cid = 14583;}// file: 19
			case 14583:{cid = 14604;}// file: 19
			case 14604:{cid = 14705;}// file: 19
			case 14705:{cid = 14757;}// file: 19
			case 14757:{cid = 14772;}// file: 19
			case 14772:{cid = 14806;}// file: 19
			case 14806:{cid = 14861;}// file: 19
			case 14861:{cid = 14866;}// file: 19
			case 14866:{cid = 14867;}// file: 19
			case 14867:{cid = 14879;}// file: 19
			case 14879:{cid = 14880;}// file: 19
			case 14880:{cid = 14891;}// file: 19
			case 14891:{cid = 15035;}// file: 19
			case 15035:{cid = 15039;}// file: 19
			case 15039:{cid = 15040;}// file: 19
			case 15040:{cid = 15050;}// file: 19
			case 15050:{cid = 15063;}// file: 19
			case 15063:{cid = 16377;}// file: 19
			case 16377:{cid = 16444;}// file: 19
			case 16444:{cid = 1513;}// file: 19
			case 1513:{cid = 1514;}// file: 20
			case 1514:{cid = 1842;}// file: 20
			case 1842:{cid = 1843;}// file: 20
			case 1843:{cid = 1844;}// file: 20
			case 1844:{cid = 1845;}// file: 20
			case 1845:{cid = 1846;}// file: 20
			case 1846:{cid = 1847;}// file: 20
			case 1847:{cid = 1848;}// file: 20
			case 1848:{cid = 1849;}// file: 20
			case 1849:{cid = 1850;}// file: 20
			case 1850:{cid = 1883;}// file: 20
			case 1883:{cid = 1884;}// file: 20
			case 1884:{cid = 1885;}// file: 20
			case 1885:{cid = 1886;}// file: 20
			case 1886:{cid = 1887;}// file: 20
			case 1887:{cid = 1888;}// file: 20
			case 1888:{cid = 1889;}// file: 20
			case 1889:{cid = 1890;}// file: 20
			case 1890:{cid = 1891;}// file: 20
			case 1891:{cid = 1959;}// file: 20
			case 1959:{cid = 1972;}// file: 20
			case 1972:{cid = 1973;}// file: 20
			case 1973:{cid = 1981;}// file: 20
			case 1981:{cid = 1982;}// file: 20
			case 1982:{cid = 1983;}// file: 20
			case 1983:{cid = 1984;}// file: 20
			case 1984:{cid = 1986;}// file: 20
			case 1986:{cid = 1987;}// file: 20
			case 1987:{cid = 1988;}// file: 20
			case 1988:{cid = 1989;}// file: 20
			case 1989:{cid = 1990;}// file: 20
			case 1990:{cid = 1991;}// file: 20
			case 1991:{cid = 1992;}// file: 20
			case 1992:{cid = 1993;}// file: 20
			case 1993:{cid = 1994;}// file: 20
			case 1994:{cid = 1995;}// file: 20
			case 1995:{cid = 1996;}// file: 20
			case 1996:{cid = 2012;}// file: 20
			case 2012:{cid = 2362;}// file: 20
			case 2362:{cid = 2365;}// file: 20
			case 2365:{cid = 2366;}// file: 20
			case 2366:{cid = 2367;}// file: 20
			case 2367:{cid = 2368;}// file: 20
			case 2368:{cid = 2369;}// file: 20
			case 2369:{cid = 2375;}// file: 20
			case 2375:{cid = 2376;}// file: 20
			case 2376:{cid = 2379;}// file: 20
			case 2379:{cid = 2385;}// file: 20
			case 2385:{cid = 2387;}// file: 20
			case 2387:{cid = 2388;}// file: 20
			case 2388:{cid = 2393;}// file: 20
			case 2393:{cid = 2403;}// file: 20
			case 2403:{cid = 2412;}// file: 20
			case 2412:{cid = 2413;}// file: 20
			case 2413:{cid = 2414;}// file: 20
			case 2414:{cid = 2422;}// file: 20
			case 2422:{cid = 2423;}// file: 20
			case 2423:{cid = 2424;}// file: 20
			case 2424:{cid = 2433;}// file: 20
			case 2433:{cid = 2434;}// file: 20
			case 2434:{cid = 2435;}// file: 20
			case 2435:{cid = 2436;}// file: 20
			case 2436:{cid = 2439;}// file: 20
			case 2439:{cid = 2440;}// file: 20
			case 2440:{cid = 2441;}// file: 20
			case 2441:{cid = 2442;}// file: 20
			case 2442:{cid = 2443;}// file: 20
			case 2443:{cid = 2444;}// file: 20
			case 2444:{cid = 2445;}// file: 20
			case 2445:{cid = 2446;}// file: 20
			case 2446:{cid = 2447;}// file: 20
			case 2447:{cid = 2448;}// file: 20
			case 2448:{cid = 2449;}// file: 20
			case 2449:{cid = 2450;}// file: 20
			case 2450:{cid = 2454;}// file: 20
			case 2454:{cid = 2455;}// file: 20
			case 2455:{cid = 2457;}// file: 20
			case 2457:{cid = 2458;}// file: 20
			case 2458:{cid = 2459;}// file: 20
			case 2459:{cid = 2460;}// file: 20
			case 2460:{cid = 2461;}// file: 20
			case 2461:{cid = 2467;}// file: 20
			case 2467:{cid = 2484;}// file: 20
			case 2484:{cid = 2485;}// file: 20
			case 2485:{cid = 2486;}// file: 20
			case 2486:{cid = 2487;}// file: 20
			case 2487:{cid = 2488;}// file: 20
			case 2488:{cid = 2489;}// file: 20
			case 2489:{cid = 2490;}// file: 20
			case 2490:{cid = 2491;}// file: 20
			case 2491:{cid = 2492;}// file: 20
			case 2492:{cid = 2493;}// file: 20
			case 2493:{cid = 2494;}// file: 20
			case 2494:{cid = 2495;}// file: 20
			case 2495:{cid = 2496;}// file: 20
			case 2496:{cid = 2497;}// file: 20
			case 2497:{cid = 2498;}// file: 20
			case 2498:{cid = 2499;}// file: 20
			case 2499:{cid = 2500;}// file: 20
			case 2500:{cid = 2505;}// file: 20
			case 2505:{cid = 2506;}// file: 20
			case 2506:{cid = 2507;}// file: 20
			case 2507:{cid = 2508;}// file: 20
			case 2508:{cid = 2535;}// file: 20
			case 2535:{cid = 2536;}// file: 20
			case 2536:{cid = 2537;}// file: 20
			case 2537:{cid = 2538;}// file: 20
			case 2538:{cid = 2539;}// file: 20
			case 2539:{cid = 2540;}// file: 20
			case 2540:{cid = 2541;}// file: 20
			case 2541:{cid = 2542;}// file: 20
			case 2542:{cid = 2543;}// file: 20
			case 2543:{cid = 2544;}// file: 20
			case 2544:{cid = 2545;}// file: 20
			case 2545:{cid = 2546;}// file: 20
			case 2546:{cid = 2547;}// file: 20
			case 2547:{cid = 2548;}// file: 20
			case 2548:{cid = 2549;}// file: 20
			case 2549:{cid = 2550;}// file: 20
			case 2550:{cid = 2551;}// file: 20
			case 2551:{cid = 2552;}// file: 20
			case 2552:{cid = 2553;}// file: 20
			case 2553:{cid = 2554;}// file: 20
			case 2554:{cid = 2555;}// file: 20
			case 2555:{cid = 2556;}// file: 20
			case 2556:{cid = 2557;}// file: 20
			case 2557:{cid = 2577;}// file: 20
			case 2577:{cid = 2578;}// file: 20
			case 2578:{cid = 2579;}// file: 20
			case 2579:{cid = 2581;}// file: 20
			case 2581:{cid = 2582;}// file: 20
			case 2582:{cid = 2583;}// file: 20
			case 2583:{cid = 2584;}// file: 20
			case 2584:{cid = 2585;}// file: 20
			case 2585:{cid = 2586;}// file: 20
			case 2586:{cid = 2589;}// file: 20
			case 2589:{cid = 2590;}// file: 20
			case 2590:{cid = 2593;}// file: 20
			case 2593:{cid = 2594;}// file: 20
			case 2594:{cid = 2597;}// file: 20
			case 2597:{cid = 2598;}// file: 20
			case 2598:{cid = 2601;}// file: 20
			case 2601:{cid = 2620;}// file: 20
			case 2620:{cid = 2621;}// file: 20
			case 2621:{cid = 2622;}// file: 20
			case 2622:{cid = 2623;}// file: 20
			case 2623:{cid = 2624;}// file: 20
			case 2624:{cid = 2625;}// file: 20
			case 2625:{cid = 2626;}// file: 20
			case 2626:{cid = 2652;}// file: 20
			case 2652:{cid = 2698;}// file: 20
			case 2698:{cid = 2699;}// file: 20
			case 2699:{cid = 2701;}// file: 20
			case 2701:{cid = 2749;}// file: 20
			case 2749:{cid = 2750;}// file: 20
			case 2750:{cid = 2751;}// file: 20
			case 2751:{cid = 2752;}// file: 20
			case 2752:{cid = 2753;}// file: 20
			case 2753:{cid = 2771;}// file: 20
			case 2771:{cid = 2803;}// file: 20
			case 2803:{cid = 2804;}// file: 20
			case 2804:{cid = 2805;}// file: 20
			case 2805:{cid = 2806;}// file: 20
			case 2806:{cid = 2871;}// file: 20
			case 2871:{cid = 12854;}// file: 20
			case 12854:{cid = 14403;}// file: 20
			case 14403:{cid = 14650;}// file: 20
			case 14650:{cid = 14651;}// file: 20
			case 14651:{cid = 14652;}// file: 20
			case 14652:{cid = 14653;}// file: 20
			case 14653:{cid = 14654;}// file: 20
			case 14654:{cid = 14660;}// file: 20
			case 14660:{cid = 14666;}// file: 20
			case 14666:{cid = 14678;}// file: 20
			case 14678:{cid = 14679;}// file: 20
			case 14679:{cid = 14685;}// file: 20
			case 14685:{cid = 14686;}// file: 20
			case 14686:{cid = 14693;}// file: 20
			case 14693:{cid = 14811;}// file: 20
			case 14811:{cid = 14890;}// file: 20
			case 14890:{cid = 18061;}// file: 20
			case 18061:{cid = 18064;}// file: 20
			case 18064:{cid = 18070;}// file: 20
			case 18070:{cid = 18092;}// file: 20
			case 18092:{cid = 955;}// file: 20
			case 955:{cid = 956;}// file: 22
			case 956:{cid = 1209;}// file: 22
			case 1209:{cid = 1302;}// file: 22
			case 1302:{cid = 1775;}// file: 22
			case 1775:{cid = 1776;}// file: 22
			case 1776:{cid = 1977;}// file: 22
			case 1977:{cid = 2212;}// file: 22
			case 2212:{cid = 2213;}// file: 22
			case 2213:{cid = 2214;}// file: 22
			case 2214:{cid = 2215;}// file: 22
			case 2215:{cid = 2216;}// file: 22
			case 2216:{cid = 2217;}// file: 22
			case 2217:{cid = 2218;}// file: 22
			case 2218:{cid = 2219;}// file: 22
			case 2219:{cid = 2220;}// file: 22
			case 2220:{cid = 2221;}// file: 22
			case 2221:{cid = 2222;}// file: 22
			case 2222:{cid = 2223;}// file: 22
			case 2223:{cid = 2342;}// file: 22
			case 2342:{cid = 2353;}// file: 22
			case 2353:{cid = 2354;}// file: 22
			case 2354:{cid = 2355;}// file: 22
			case 2355:{cid = 2420;}// file: 22
			case 2420:{cid = 2425;}// file: 22
			case 2425:{cid = 2427;}// file: 22
			case 2427:{cid = 2429;}// file: 22
			case 2429:{cid = 2438;}// file: 22
			case 2438:{cid = 2453;}// file: 22
			case 2453:{cid = 2647;}// file: 22
			case 2647:{cid = 2663;}// file: 22
			case 2663:{cid = 2683;}// file: 22
			case 2683:{cid = 2702;}// file: 22
			case 2702:{cid = 2703;}// file: 22
			case 2703:{cid = 2767;}// file: 22
			case 2767:{cid = 2768;}// file: 22
			case 2768:{cid = 2769;}// file: 22
			case 2769:{cid = 2814;}// file: 22
			case 2814:{cid = 2821;}// file: 22
			case 2821:{cid = 2823;}// file: 22
			case 2823:{cid = 2837;}// file: 22
			case 2837:{cid = 2838;}// file: 22
			case 2838:{cid = 2839;}// file: 22
			case 2839:{cid = 2840;}// file: 22
			case 2840:{cid = 2856;}// file: 22
			case 2856:{cid = 2857;}// file: 22
			case 2857:{cid = 2858;}// file: 22
			case 2858:{cid = 2859;}// file: 22
			case 2859:{cid = 2860;}// file: 22
			case 2860:{cid = 2861;}// file: 22
			case 2861:{cid = 2866;}// file: 22
			case 2866:{cid = 2867;}// file: 22
			case 2867:{cid = 2880;}// file: 22
			case 2880:{cid = 2881;}// file: 22
			case 2881:{cid = 1426;}// file: 22
			case 1426:{cid = 1428;}// file: 23
			case 1428:{cid = 1436;}// file: 23
			case 1436:{cid = 1437;}// file: 23
			case 1437:{cid = 1464;}// file: 23
			case 1464:{cid = 1465;}// file: 23
			case 1465:{cid = 1466;}// file: 23
			case 1466:{cid = 1467;}// file: 23
			case 1467:{cid = 1469;}// file: 23
			case 1469:{cid = 1470;}// file: 23
			case 1470:{cid = 1471;}// file: 23
			case 1471:{cid = 1472;}// file: 23
			case 1472:{cid = 1473;}// file: 23
			case 1473:{cid = 1474;}// file: 23
			case 1474:{cid = 1475;}// file: 23
			case 1475:{cid = 1476;}// file: 23
			case 1476:{cid = 1477;}// file: 23
			case 1477:{cid = 1519;}// file: 23
			case 1519:{cid = 1521;}// file: 23
			case 1521:{cid = 1656;}// file: 23
			case 1656:{cid = 1698;}// file: 23
			case 1698:{cid = 2633;}// file: 23
			case 2633:{cid = 3361;}// file: 23
			case 3361:{cid = 3399;}// file: 23
			case 3399:{cid = 3671;}// file: 23
			case 3671:{cid = 3674;}// file: 23
			case 3674:{cid = 3867;}// file: 23
			case 3867:{cid = 4106;}// file: 23
			case 4106:{cid = 4120;}// file: 23
			case 4120:{cid = 4121;}// file: 23
			case 4121:{cid = 4170;}// file: 23
			case 4170:{cid = 4171;}// file: 23
			case 4171:{cid = 4180;}// file: 23
			case 4180:{cid = 4231;}// file: 23
			case 4231:{cid = 4565;}// file: 23
			case 4565:{cid = 4575;}// file: 23
			case 4575:{cid = 4737;}// file: 23
			case 4737:{cid = 4738;}// file: 23
			case 4738:{cid = 4824;}// file: 23
			case 4824:{cid = 4881;}// file: 23
			case 4881:{cid = 4882;}// file: 23
			case 4882:{cid = 5130;}// file: 23
			case 5130:{cid = 5268;}// file: 23
			case 5268:{cid = 5301;}// file: 23
			case 5301:{cid = 5308;}// file: 23
			case 5308:{cid = 5627;}// file: 23
			case 5627:{cid = 5822;}// file: 23
			case 5822:{cid = 7659;}// file: 23
			case 7659:{cid = 8572;}// file: 23
			case 8572:{cid = 8580;}// file: 23
			case 8580:{cid = 8613;}// file: 23
			case 8613:{cid = 8614;}// file: 23
			case 8614:{cid = 8615;}// file: 23
			case 8615:{cid = 9316;}// file: 23
			case 9316:{cid = 9484;}// file: 23
			case 9484:{cid = 9566;}// file: 23
			case 9566:{cid = 9618;}// file: 23
			case 9618:{cid = 9766;}// file: 23
			case 9766:{cid = 9767;}// file: 23
			case 9767:{cid = 9814;}// file: 23
			case 9814:{cid = 9815;}// file: 23
			case 9815:{cid = 9816;}// file: 23
			case 9816:{cid = 10008;}// file: 23
			case 10008:{cid = 10009;}// file: 23
			case 10009:{cid = 10026;}// file: 23
			case 10026:{cid = 10033;}// file: 23
			case 10033:{cid = 10042;}// file: 23
			case 10042:{cid = 10152;}// file: 23
			case 10152:{cid = 10153;}// file: 23
			case 10153:{cid = 10173;}// file: 23
			case 10173:{cid = 10174;}// file: 23
			case 10174:{cid = 10175;}// file: 23
			case 10175:{cid = 10176;}// file: 23
			case 10176:{cid = 10177;}// file: 23
			case 10177:{cid = 10178;}// file: 23
			case 10178:{cid = 10179;}// file: 23
			case 10179:{cid = 10180;}// file: 23
			case 10180:{cid = 10181;}// file: 23
			case 10181:{cid = 10185;}// file: 23
			case 10185:{cid = 10234;}// file: 23
			case 10234:{cid = 10309;}// file: 23
			case 10309:{cid = 10672;}// file: 23
			case 10672:{cid = 11472;}// file: 23
			case 11472:{cid = 11479;}// file: 23
			case 11479:{cid = 11493;}// file: 23
			case 11493:{cid = 11496;}// file: 23
			case 11496:{cid = 11544;}// file: 23
			case 11544:{cid = 12839;}// file: 23
			case 12839:{cid = 12950;}// file: 23
			case 12950:{cid = 12958;}// file: 23
			case 12958:{cid = 12985;}// file: 23
			case 12985:{cid = 12987;}// file: 23
			case 12987:{cid = 13011;}// file: 23
			case 13011:{cid = 13644;}// file: 23
			case 13644:{cid = 13749;}// file: 23
			case 13749:{cid = 14387;}// file: 23
			case 14387:{cid = 14394;}// file: 23
			case 14394:{cid = 14395;}// file: 23
			case 14395:{cid = 14407;}// file: 23
			case 14407:{cid = 14409;}// file: 23
			case 14409:{cid = 14410;}// file: 23
			case 14410:{cid = 14411;}// file: 23
			case 14411:{cid = 14414;}// file: 23
			case 14414:{cid = 14416;}// file: 23
			case 14416:{cid = 14596;}// file: 23
			case 14596:{cid = 14874;}// file: 23
			case 14874:{cid = 14877;}// file: 23
			case 14877:{cid = 16082;}// file: 23
			case 16082:{cid = 16322;}// file: 23
			case 16322:{cid = 16649;}// file: 23
			case 16649:{cid = 16651;}// file: 23
			case 16651:{cid = 16661;}// file: 23
			case 16661:{cid = 16731;}// file: 23
			case 16731:{cid = 17904;}// file: 23
			case 17904:{cid = 18366;}// file: 23
			case 18366:{cid = 18368;}// file: 23
			case 18368:{cid = 3268;}// file: 23
			case 3268:{cid = 3271;}// file: 24
			case 3271:{cid = 3277;}// file: 24
			case 3277:{cid = 3279;}// file: 24
			case 3279:{cid = 3280;}// file: 24
			case 3280:{cid = 3386;}// file: 24
			case 3386:{cid = 3387;}// file: 24
			case 3387:{cid = 3388;}// file: 24
			case 3388:{cid = 3389;}// file: 24
			case 3389:{cid = 3390;}// file: 24
			case 3390:{cid = 3391;}// file: 24
			case 3391:{cid = 3392;}// file: 24
			case 3392:{cid = 3393;}// file: 24
			case 3393:{cid = 3394;}// file: 24
			case 3394:{cid = 3395;}// file: 24
			case 3395:{cid = 3396;}// file: 24
			case 3396:{cid = 3397;}// file: 24
			case 3397:{cid = 3400;}// file: 24
			case 3400:{cid = 3401;}// file: 24
			case 3401:{cid = 3786;}// file: 24
			case 3786:{cid = 3787;}// file: 24
			case 3787:{cid = 3788;}// file: 24
			case 3788:{cid = 3789;}// file: 24
			case 3789:{cid = 3790;}// file: 24
			case 3790:{cid = 3791;}// file: 24
			case 3791:{cid = 3792;}// file: 24
			case 3792:{cid = 3793;}// file: 24
			case 3793:{cid = 3794;}// file: 24
			case 3794:{cid = 3795;}// file: 24
			case 3795:{cid = 3797;}// file: 24
			case 3797:{cid = 3885;}// file: 24
			case 3885:{cid = 12911;}// file: 24
			case 12911:{cid = 12912;}// file: 24
			case 12912:{cid = 16093;}// file: 24
			case 16093:{cid = 16639;}// file: 24
			case 16639:{cid = 16640;}// file: 24
			case 16640:{cid = 16641;}// file: 24
			case 16641:{cid = 16642;}// file: 24
			case 16642:{cid = 16643;}// file: 24
			case 16643:{cid = 16644;}// file: 24
			case 16644:{cid = 16645;}// file: 24
			case 16645:{cid = 16647;}// file: 24
			case 16647:{cid = 16648;}// file: 24
			case 16648:{cid = 16654;}// file: 24
			case 16654:{cid = 16656;}// file: 24
			case 16656:{cid = 16657;}// file: 24
			case 16657:{cid = 16658;}// file: 24
			case 16658:{cid = 16660;}// file: 24
			case 16660:{cid = 16662;}// file: 24
			case 16662:{cid = 16663;}// file: 24
			case 16663:{cid = 16665;}// file: 24
			case 16665:{cid = 16681;}// file: 24
			case 16681:{cid = 16682;}// file: 24
			case 16682:{cid = 954;}// file: 24
			case 954:{cid = 1210;}// file: 25
			case 1210:{cid = 1212;}// file: 25
			case 1212:{cid = 1213;}// file: 25
			case 1213:{cid = 1239;}// file: 25
			case 1239:{cid = 1240;}// file: 25
			case 1240:{cid = 1241;}// file: 25
			case 1241:{cid = 1242;}// file: 25
			case 1242:{cid = 1247;}// file: 25
			case 1247:{cid = 1248;}// file: 25
			case 1248:{cid = 1252;}// file: 25
			case 1252:{cid = 1253;}// file: 25
			case 1253:{cid = 1254;}// file: 25
			case 1254:{cid = 1272;}// file: 25
			case 1272:{cid = 1273;}// file: 25
			case 1273:{cid = 1274;}// file: 25
			case 1274:{cid = 1275;}// file: 25
			case 1275:{cid = 1276;}// file: 25
			case 1276:{cid = 1277;}// file: 25
			case 1277:{cid = 1279;}// file: 25
			case 1279:{cid = 1310;}// file: 25
			case 1310:{cid = 1313;}// file: 25
			case 1313:{cid = 1314;}// file: 25
			case 1314:{cid = 1318;}// file: 25
			case 1318:{cid = 1550;}// file: 25
			case 1550:{cid = 1575;}// file: 25
			case 1575:{cid = 1576;}// file: 25
			case 1576:{cid = 1577;}// file: 25
			case 1577:{cid = 1578;}// file: 25
			case 1578:{cid = 1579;}// file: 25
			case 1579:{cid = 1580;}// file: 25
			case 1580:{cid = 1581;}// file: 25
			case 1581:{cid = 1582;}// file: 25
			case 1582:{cid = 1636;}// file: 25
			case 1636:{cid = 1644;}// file: 25
			case 1644:{cid = 1650;}// file: 25
			case 1650:{cid = 1654;}// file: 25
			case 1654:{cid = 1672;}// file: 25
			case 1672:{cid = 2033;}// file: 25
			case 2033:{cid = 2034;}// file: 25
			case 2034:{cid = 2035;}// file: 25
			case 2035:{cid = 2036;}// file: 25
			case 2036:{cid = 2037;}// file: 25
			case 2037:{cid = 2044;}// file: 25
			case 2044:{cid = 2045;}// file: 25
			case 2045:{cid = 2057;}// file: 25
			case 2057:{cid = 2058;}// file: 25
			case 2058:{cid = 2059;}// file: 25
			case 2059:{cid = 2060;}// file: 25
			case 2060:{cid = 2061;}// file: 25
			case 2061:{cid = 2064;}// file: 25
			case 2064:{cid = 2068;}// file: 25
			case 2068:{cid = 2228;}// file: 25
			case 2228:{cid = 2237;}// file: 25
			case 2237:{cid = 2690;}// file: 25
			case 2690:{cid = 2709;}// file: 25
			case 2709:{cid = 2710;}// file: 25
			case 2710:{cid = 14673;}// file: 25
			case 14673:{cid = 918;}// file: 25
			case 918:{cid = 1217;}// file: 26
			case 1217:{cid = 1218;}// file: 26
			case 1218:{cid = 1222;}// file: 26
			case 1222:{cid = 1225;}// file: 26
			case 1225:{cid = 1243;}// file: 26
			case 1243:{cid = 1244;}// file: 26
			case 1244:{cid = 1676;}// file: 26
			case 1676:{cid = 1686;}// file: 26
			case 1686:{cid = 1985;}// file: 26
			case 1985:{cid = 2780;}// file: 26
			case 2780:{cid = 3057;}// file: 26
			case 3057:{cid = 3267;}// file: 26
			case 3267:{cid = 3374;}// file: 26
			case 3374:{cid = 3425;}// file: 26
			case 3425:{cid = 3426;}// file: 26
			case 3426:{cid = 3461;}// file: 26
			case 3461:{cid = 3472;}// file: 26
			case 3472:{cid = 3515;}// file: 26
			case 3515:{cid = 3524;}// file: 26
			case 3524:{cid = 3525;}// file: 26
			case 3525:{cid = 3528;}// file: 26
			case 3528:{cid = 3534;}// file: 26
			case 3534:{cid = 3586;}// file: 26
			case 3586:{cid = 3743;}// file: 26
			case 3743:{cid = 3864;}// file: 26
			case 3864:{cid = 3877;}// file: 26
			case 3877:{cid = 6865;}// file: 26
			case 6865:{cid = 6965;}// file: 26
			case 6965:{cid = 7073;}// file: 26
			case 7073:{cid = 7268;}// file: 26
			case 7268:{cid = 7388;}// file: 26
			case 7388:{cid = 7392;}// file: 26
			case 7392:{cid = 7916;}// file: 26
			case 7916:{cid = 8483;}// file: 26
			case 8483:{cid = 8491;}// file: 26
			case 8491:{cid = 8492;}// file: 26
			case 8492:{cid = 8979;}// file: 26
			case 8979:{cid = 8980;}// file: 26
			case 8980:{cid = 9831;}// file: 26
			case 9831:{cid = 9833;}// file: 26
			case 9833:{cid = 10397;}// file: 26
			case 10397:{cid = 10764;}// file: 26
			case 10764:{cid = 11417;}// file: 26
			case 11417:{cid = 13562;}// file: 26
			case 13562:{cid = 13667;}// file: 26
			case 13667:{cid = 14608;}// file: 26
			case 14608:{cid = 16135;}// file: 26
			case 16135:{cid = 16368;}// file: 26
			case 16368:{cid = 16777;}// file: 26
			case 16777:{cid = 16776;}// file: 26
			case 16776:{cid = 16778;}// file: 26
			case 16778:{cid = 16779;}// file: 26
			case 16779:{cid = 16782;}// file: 26
			case 16782:{cid = 1211;}// file: 26
			case 1211:{cid = 1214;}// file: 27
			case 1214:{cid = 1215;}// file: 27
			case 1215:{cid = 1216;}// file: 27
			case 1216:{cid = 1223;}// file: 27
			case 1223:{cid = 1226;}// file: 27
			case 1226:{cid = 1231;}// file: 27
			case 1231:{cid = 1232;}// file: 27
			case 1232:{cid = 1238;}// file: 27
			case 1238:{cid = 1244;}// file: 27
			case 1257:{cid = 1258;}// file: 27
			case 1258:{cid = 1262;}// file: 27
			case 1262:{cid = 1263;}// file: 27
			case 1263:{cid = 1269;}// file: 27
			case 1269:{cid = 1270;}// file: 27
			case 1270:{cid = 1278;}// file: 27
			case 1278:{cid = 1283;}// file: 27
			case 1283:{cid = 1284;}// file: 27
			case 1284:{cid = 1285;}// file: 27
			case 1285:{cid = 1286;}// file: 27
			case 1286:{cid = 1287;}// file: 27
			case 1287:{cid = 1288;}// file: 27
			case 1288:{cid = 1289;}// file: 27
			case 1289:{cid = 1290;}// file: 27
			case 1290:{cid = 1291;}// file: 27
			case 1291:{cid = 1292;}// file: 27
			case 1292:{cid = 1293;}// file: 27
			case 1293:{cid = 1294;}// file: 27
			case 1294:{cid = 1295;}// file: 27
			case 1295:{cid = 1296;}// file: 27
			case 1296:{cid = 1297;}// file: 27
			case 1297:{cid = 1298;}// file: 27
			case 1298:{cid = 1306;}// file: 27
			case 1306:{cid = 1307;}// file: 27
			case 1307:{cid = 1308;}// file: 27
			case 1308:{cid = 1315;}// file: 27
			case 1315:{cid = 1319;}// file: 27
			case 1319:{cid = 1340;}// file: 27
			case 1340:{cid = 1341;}// file: 27
			case 1341:{cid = 1342;}// file: 27
			case 1342:{cid = 1346;}// file: 27
			case 1346:{cid = 1350;}// file: 27
			case 1350:{cid = 1351;}// file: 27
			case 1351:{cid = 1352;}// file: 27
			case 1352:{cid = 1363;}// file: 27
			case 1363:{cid = 1366;}// file: 27
			case 1366:{cid = 1367;}// file: 27
			case 1367:{cid = 1478;}// file: 27
			case 1478:{cid = 1568;}// file: 27
			case 1568:{cid = 1570;}// file: 27
			case 1570:{cid = 1571;}// file: 27
			case 1571:{cid = 2600;}// file: 27
			case 2600:{cid = 3398;}// file: 27
			case 3398:{cid = 3407;}// file: 27
			case 3407:{cid = 3408;}// file: 27
			case 3408:{cid = 3447;}// file: 27
			case 3447:{cid = 3459;}// file: 27
			case 3459:{cid = 3460;}// file: 27
			case 3460:{cid = 3463;}// file: 27
			case 3463:{cid = 3516;}// file: 27
			case 3516:{cid = 3853;}// file: 27
			case 3853:{cid = 3854;}// file: 27
			case 3854:{cid = 3855;}// file: 27
			case 3855:{cid = 3860;}// file: 27
			case 3860:{cid = 3861;}// file: 27
			case 3861:{cid = 3862;}// file: 27
			case 3862:{cid = 3863;}// file: 27
			case 3863:{cid = 3875;}// file: 27
			case 3875:{cid = 6289;}// file: 27
			case 6289:{cid = 6299;}// file: 27
			case 6299:{cid = 6462;}// file: 27
			case 6462:{cid = 625;}// file: 27
			case 625:{cid = 626;}// file: 29
			case 626:{cid = 627;}// file: 29
			case 627:{cid = 628;}// file: 29
			case 628:{cid = 630;}// file: 29
			case 630:{cid = 631;}// file: 29
			case 631:{cid = 632;}// file: 29
			case 632:{cid = 633;}// file: 29
			case 633:{cid = 635;}// file: 29
			case 635:{cid = 636;}// file: 29
			case 636:{cid = 637;}// file: 29
			case 637:{cid = 638;}// file: 29
			case 638:{cid = 639;}// file: 29
			case 639:{cid = 640;}// file: 29
			case 640:{cid = 644;}// file: 29
			case 644:{cid = 646;}// file: 29
			case 646:{cid = 647;}// file: 29
			case 647:{cid = 650;}// file: 29
			case 650:{cid = 651;}// file: 29
			case 651:{cid = 653;}// file: 29
			case 653:{cid = 675;}// file: 29
			case 675:{cid = 677;}// file: 29
			case 677:{cid = 678;}// file: 29
			case 678:{cid = 679;}// file: 29
			case 679:{cid = 682;}// file: 29
			case 682:{cid = 692;}// file: 29
			case 692:{cid = 701;}// file: 29
			case 701:{cid = 702;}// file: 29
			case 702:{cid = 728;}// file: 29
			case 728:{cid = 741;}// file: 29
			case 741:{cid = 742;}// file: 29
			case 742:{cid = 743;}// file: 29
			case 743:{cid = 753;}// file: 29
			case 753:{cid = 754;}// file: 29
			case 754:{cid = 755;}// file: 29
			case 755:{cid = 756;}// file: 29
			case 756:{cid = 757;}// file: 29
			case 757:{cid = 759;}// file: 29
			case 759:{cid = 760;}// file: 29
			case 760:{cid = 761;}// file: 29
			case 761:{cid = 762;}// file: 29
			case 762:{cid = 800;}// file: 29
			case 800:{cid = 801;}// file: 29
			case 801:{cid = 802;}// file: 29
			case 802:{cid = 803;}// file: 29
			case 803:{cid = 804;}// file: 29
			case 804:{cid = 805;}// file: 29
			case 805:{cid = 806;}// file: 29
			case 806:{cid = 808;}// file: 29
			case 808:{cid = 809;}// file: 29
			case 809:{cid = 810;}// file: 29
			case 810:{cid = 811;}// file: 29
			case 811:{cid = 812;}// file: 29
			case 812:{cid = 813;}// file: 29
			case 813:{cid = 814;}// file: 29
			case 814:{cid = 815;}// file: 29
			case 815:{cid = 817;}// file: 29
			case 817:{cid = 818;}// file: 29
			case 818:{cid = 819;}// file: 29
			case 819:{cid = 820;}// file: 29
			case 820:{cid = 821;}// file: 29
			case 821:{cid = 822;}// file: 29
			case 822:{cid = 823;}// file: 29
			case 823:{cid = 824;}// file: 29
			case 824:{cid = 825;}// file: 29
			case 825:{cid = 826;}// file: 29
			case 826:{cid = 827;}// file: 29
			case 827:{cid = 855;}// file: 29
			case 855:{cid = 856;}// file: 29
			case 856:{cid = 857;}// file: 29
			case 857:{cid = 859;}// file: 29
			case 859:{cid = 860;}// file: 29
			case 860:{cid = 861;}// file: 29
			case 861:{cid = 862;}// file: 29
			case 862:{cid = 863;}// file: 29
			case 863:{cid = 864;}// file: 29
			case 864:{cid = 865;}// file: 29
			case 865:{cid = 866;}// file: 29
			case 866:{cid = 869;}// file: 29
			case 869:{cid = 870;}// file: 29
			case 870:{cid = 871;}// file: 29
			case 871:{cid = 872;}// file: 29
			case 872:{cid = 873;}// file: 29
			case 873:{cid = 874;}// file: 29
			case 874:{cid = 875;}// file: 29
			case 875:{cid = 876;}// file: 29
			case 876:{cid = 877;}// file: 29
			case 877:{cid = 878;}// file: 29
			case 878:{cid = 948;}// file: 29
			case 948:{cid = 949;}// file: 29
			case 949:{cid = 950;}// file: 29
			case 950:{cid = 1360;}// file: 29
			case 1360:{cid = 1361;}// file: 29
			case 1361:{cid = 1364;}// file: 29
			case 1364:{cid = 1597;}// file: 29
			case 1597:{cid = 1807;}// file: 29
			case 1807:{cid = 2001;}// file: 29
			case 2001:{cid = 2010;}// file: 29
			case 2010:{cid = 2011;}// file: 29
			case 2011:{cid = 2194;}// file: 29
			case 2194:{cid = 2195;}// file: 29
			case 2195:{cid = 2203;}// file: 29
			case 2203:{cid = 2240;}// file: 29
			case 2240:{cid = 2241;}// file: 29
			case 2241:{cid = 2242;}// file: 29
			case 2242:{cid = 2243;}// file: 29
			case 2243:{cid = 2244;}// file: 29
			case 2244:{cid = 2245;}// file: 29
			case 2245:{cid = 2246;}// file: 29
			case 2246:{cid = 2247;}// file: 29
			case 2247:{cid = 2248;}// file: 29
			case 2248:{cid = 2249;}// file: 29
			case 2249:{cid = 2250;}// file: 29
			case 2250:{cid = 2251;}// file: 29
			case 2251:{cid = 2252;}// file: 29
			case 2252:{cid = 2253;}// file: 29
			case 2253:{cid = 2254;}// file: 29
			case 2254:{cid = 2345;}// file: 29
			case 2345:{cid = 2811;}// file: 29
			case 2811:{cid = 3409;}// file: 29
			case 3409:{cid = 3439;}// file: 29
			case 3439:{cid = 3450;}// file: 29
			case 3450:{cid = 3520;}// file: 29
			case 3520:{cid = 3532;}// file: 29
			case 3532:{cid = 3660;}// file: 29
			case 3660:{cid = 3802;}// file: 29
			case 3802:{cid = 3806;}// file: 29
			case 3806:{cid = 3810;}// file: 29
			case 3810:{cid = 3811;}// file: 29
			case 3811:{cid = 4034;}// file: 29
			case 4034:{cid = 4172;}// file: 29
			case 4172:{cid = 4173;}// file: 29
			case 4173:{cid = 4174;}// file: 29
			case 4174:{cid = 4175;}// file: 29
			case 4175:{cid = 4184;}// file: 29
			case 4184:{cid = 4185;}// file: 29
			case 4185:{cid = 4981;}// file: 29
			case 4981:{cid = 4982;}// file: 29
			case 4982:{cid = 4984;}// file: 29
			case 4984:{cid = 4985;}// file: 29
			case 4985:{cid = 4986;}// file: 29
			case 4986:{cid = 4992;}// file: 29
			case 4992:{cid = 4993;}// file: 29
			case 4993:{cid = 5023;}// file: 29
			case 5023:{cid = 5024;}// file: 29
			case 5024:{cid = 5025;}// file: 29
			case 5025:{cid = 5078;}// file: 29
			case 5078:{cid = 5150;}// file: 29
			case 5150:{cid = 5234;}// file: 29
			case 5234:{cid = 5265;}// file: 29
			case 5265:{cid = 5266;}// file: 29
			case 5266:{cid = 5290;}// file: 29
			case 5290:{cid = 5322;}// file: 29
			case 5322:{cid = 5324;}// file: 29
			case 5324:{cid = 5325;}// file: 29
			case 5325:{cid = 5327;}// file: 29
			case 5327:{cid = 5328;}// file: 29
			case 5328:{cid = 5339;}// file: 29
			case 5339:{cid = 5407;}// file: 29
			case 5407:{cid = 5412;}// file: 29
			case 5412:{cid = 5417;}// file: 29
			case 5417:{cid = 5565;}// file: 29
			case 5565:{cid = 5629;}// file: 29
			case 5629:{cid = 5633;}// file: 29
			case 5633:{cid = 5634;}// file: 29
			case 5634:{cid = 5635;}// file: 29
			case 5635:{cid = 5636;}// file: 29
			case 5636:{cid = 5637;}// file: 29
			case 5637:{cid = 5638;}// file: 29
			case 5638:{cid = 5641;}// file: 29
			case 5641:{cid = 5682;}// file: 29
			case 5682:{cid = 5847;}// file: 29
			case 5847:{cid = 5877;}// file: 29
			case 5877:{cid = 5888;}// file: 29
			case 5888:{cid = 6046;}// file: 29
			case 6046:{cid = 6204;}// file: 29
			case 6204:{cid = 6214;}// file: 29
			case 6214:{cid = 6237;}// file: 29
			case 6237:{cid = 6362;}// file: 29
			case 6362:{cid = 6372;}// file: 29
			case 6372:{cid = 6386;}// file: 29
			case 6386:{cid = 6399;}// file: 29
			case 6399:{cid = 6403;}// file: 29
			case 6403:{cid = 6421;}// file: 29
			case 6421:{cid = 6430;}// file: 29
			case 6430:{cid = 6431;}// file: 29
			case 6431:{cid = 6444;}// file: 29
			case 6444:{cid = 6499;}// file: 29
			case 6499:{cid = 7095;}// file: 29
			case 7095:{cid = 7595;}// file: 29
			case 7595:{cid = 7662;}// file: 29
			case 7662:{cid = 7884;}// file: 29
			case 7884:{cid = 7952;}// file: 29
			case 7952:{cid = 7953;}// file: 29
			case 7953:{cid = 7954;}// file: 29
			case 7954:{cid = 7986;}// file: 29
			case 7986:{cid = 8319;}// file: 29
			case 8319:{cid = 8321;}// file: 29
			case 8321:{cid = 8617;}// file: 29
			case 8617:{cid = 8619;}// file: 29
			case 8619:{cid = 8623;}// file: 29
			case 8623:{cid = 8660;}// file: 29
			case 8660:{cid = 8679;}// file: 29
			case 8679:{cid = 8825;}// file: 29
			case 8825:{cid = 8826;}// file: 29
			case 8826:{cid = 8827;}// file: 29
			case 8827:{cid = 8828;}// file: 29
			case 8828:{cid = 8835;}// file: 29
			case 8835:{cid = 8836;}// file: 29
			case 8836:{cid = 8837;}// file: 29
			case 8837:{cid = 8846;}// file: 29
			case 8846:{cid = 8852;}// file: 29
			case 8852:{cid = 8887;}// file: 29
			case 8887:{cid = 8888;}// file: 29
			case 8888:{cid = 8889;}// file: 29
			case 8889:{cid = 8982;}// file: 29
			case 8982:{cid = 8989;}// file: 29
			case 8989:{cid = 8990;}// file: 29
			case 8990:{cid = 8991;}// file: 29
			case 8991:{cid = 9019;}// file: 29
			case 9019:{cid = 9034;}// file: 29
			case 9034:{cid = 9035;}// file: 29
			case 9035:{cid = 9152;}// file: 29
			case 9152:{cid = 9153;}// file: 29
			case 9153:{cid = 9317;}// file: 29
			case 9317:{cid = 9318;}// file: 29
			case 9318:{cid = 9331;}// file: 29
			case 9331:{cid = 9333;}// file: 29
			case 9333:{cid = 9334;}// file: 29
			case 9334:{cid = 9335;}// file: 29
			case 9335:{cid = 9336;}// file: 29
			case 9336:{cid = 9344;}// file: 29
			case 9344:{cid = 9347;}// file: 29
			case 9347:{cid = 9348;}// file: 29
			case 9348:{cid = 9350;}// file: 29
			case 9350:{cid = 9812;}// file: 29
			case 9812:{cid = 10445;}// file: 29
			case 10445:{cid = 11413;}// file: 29
			case 11413:{cid = 11414;}// file: 29
			case 11414:{cid = 13174;}// file: 29
			case 13174:{cid = 13699;}// file: 29
			case 13699:{cid = 13748;}// file: 29
			case 13748:{cid = 13802;}// file: 29
			case 13802:{cid = 14400;}// file: 29
			case 14400:{cid = 14402;}// file: 29
			case 14402:{cid = 14468;}// file: 29
			case 14468:{cid = 14469;}// file: 29
			case 14469:{cid = 14804;}// file: 29
			case 14804:{cid = 14834;}// file: 29
			case 14834:{cid = 15038;}// file: 29
			case 15038:{cid = 16390;}// file: 29
			case 16390:{cid = 17528;}// file: 29
			case 17528:{cid = 17532;}// file: 29
			case 17532:{cid = 17872;}// file: 29
			case 17872:{cid = 17874;}// file: 29
			case 17874:{cid = 17875;}// file: 29
			case 17875:{cid = 17876;}// file: 29
			case 17876:{cid = 17879;}// file: 29
			case 17879:{cid = 17886;}// file: 29
			case 17886:{cid = 17887;}// file: 29
			case 17887:{cid = 17891;}// file: 29
			case 17891:{cid = 17905;}// file: 29
			case 17905:{cid = 17907;}// file: 29
			case 17907:{cid = 17937;}// file: 29
			case 17937:{cid = 17938;}// file: 29
			case 17938:{cid = 17939;}// file: 29
			case 17939:{cid = 17941;}// file: 29
			case 17941:{cid = 17942;}// file: 29
			case 17942:{cid = 17947;}// file: 29
			case 17947:{cid = 17958;}// file: 29
			case 17958:{cid = 18011;}// file: 29
			case 18011:{cid = 18012;}// file: 29
			case 18012:{cid = 18013;}// file: 29
			case 18013:{cid = 18014;}// file: 29
			case 18014:{cid = 18015;}// file: 29
			case 18015:{cid = 744;}// file: 29
			case 744:{cid = 745;}// file: 30
			case 745:{cid = 746;}// file: 30
			case 746:{cid = 747;}// file: 30
			case 747:{cid = 748;}// file: 30
			case 748:{cid = 749;}// file: 30
			case 749:{cid = 750;}// file: 30
			case 750:{cid = 751;}// file: 30
			case 751:{cid = 752;}// file: 30
			case 752:{cid = 758;}// file: 30
			case 758:{cid = 807;}// file: 30
			case 807:{cid = 816;}// file: 30
			case 816:{cid = 828;}// file: 30
			case 828:{cid = 867;}// file: 30
			case 867:{cid = 868;}// file: 30
			case 868:{cid = 879;}// file: 30
			case 879:{cid = 880;}// file: 30
			case 880:{cid = 896;}// file: 30
			case 896:{cid = 897;}// file: 30
			case 897:{cid = 898;}// file: 30
			case 898:{cid = 899;}// file: 30
			case 899:{cid = 900;}// file: 30
			case 900:{cid = 901;}// file: 30
			case 901:{cid = 905;}// file: 30
			case 905:{cid = 906;}// file: 30
			case 906:{cid = 1207;}// file: 30
			case 1207:{cid = 1303;}// file: 30
			case 1303:{cid = 1304;}// file: 30
			case 1304:{cid = 1305;}// file: 30
			case 1305:{cid = 4816;}// file: 30
			case 4816:{cid = 9044;}// file: 30
			case 9044:{cid = 9045;}// file: 30
			case 9045:{cid = 9743;}// file: 30
			case 9743:{cid = 9744;}// file: 30
			case 9744:{cid = 9745;}// file: 30
			case 9745:{cid = 9746;}// file: 30
			case 9746:{cid = 10166;}// file: 30
			case 10166:{cid = 10984;}// file: 30
			case 10984:{cid = 10985;}// file: 30
			case 10985:{cid = 10986;}// file: 30
			case 10986:{cid = 11498;}// file: 30
			case 11498:{cid = 11556;}// file: 30
			case 11556:{cid = 13023;}// file: 30
			case 13023:{cid = 13635;}// file: 30
			case 13635:{cid = 16104;}// file: 30
			case 16104:{cid = 16110;}// file: 30
			case 16110:{cid = 16111;}// file: 30
			case 16111:{cid = 16112;}// file: 30
			case 16112:{cid = 16113;}// file: 30
			case 16113:{cid = 16114;}// file: 30
			case 16114:{cid = 16115;}// file: 30
			case 16115:{cid = 16116;}// file: 30
			case 16116:{cid = 16117;}// file: 30
			case 16117:{cid = 16118;}// file: 30
			case 16118:{cid = 16119;}// file: 30
			case 16119:{cid = 16120;}// file: 30
			case 16120:{cid = 16121;}// file: 30
			case 16121:{cid = 16122;}// file: 30
			case 16122:{cid = 16123;}// file: 30
			case 16123:{cid = 16124;}// file: 30
			case 16124:{cid = 16125;}// file: 30
			case 16125:{cid = 16126;}// file: 30
			case 16126:{cid = 16127;}// file: 30
			case 16127:{cid = 16128;}// file: 30
			case 16128:{cid = 16129;}// file: 30
			case 16129:{cid = 16130;}// file: 30
			case 16130:{cid = 16131;}// file: 30
			case 16131:{cid = 16133;}// file: 30
			case 16133:{cid = 16139;}// file: 30
			case 16139:{cid = 16140;}// file: 30
			case 16140:{cid = 16141;}// file: 30
			case 16141:{cid = 16142;}// file: 30
			case 16142:{cid = 16145;}// file: 30
			case 16145:{cid = 16411;}// file: 30
			case 16411:{cid = 16503;}// file: 30
			case 16503:{cid = 16667;}// file: 30
			case 16667:{cid = 16675;}// file: 30
			case 16675:{cid = 16692;}// file: 30
			case 16692:{cid = 17025;}// file: 30
			case 17025:{cid = 17026;}// file: 30
			case 17026:{cid = 17027;}// file: 30
			case 17027:{cid = 17028;}// file: 30
			case 17028:{cid = 17029;}// file: 30
			case 17029:{cid = 17030;}// file: 30
			case 17030:{cid = 17031;}// file: 30
			case 17031:{cid = 17032;}// file: 30
			case 17032:{cid = 17033;}// file: 30
			case 17033:{cid = 17034;}// file: 30
			case 17034:{cid = 17035;}// file: 30
			case 17035:{cid = 17069;}// file: 30
			case 17069:{cid = 17071;}// file: 30
			case 17071:{cid = 17076;}// file: 30
			case 17076:{cid = 17299;}// file: 30
			case 17299:{cid = 17456;}// file: 30
			case 17456:{cid = 18225;}// file: 30
			case 18225:{cid = 18226;}// file: 30
			case 18226:{cid = 18227;}// file: 30
			case 18227:{cid = 18228;}// file: 30
			case 18228:{cid = 1681;}// file: 30
			case 1681:{cid = 1682;}// file: 32
			case 1682:{cid = 1683;}// file: 32
			case 1683:{cid = 2469;}// file: 32
			case 2469:{cid = 2470;}// file: 32
			case 2470:{cid = 2472;}// file: 32
			case 2472:{cid = 2473;}// file: 32
			case 2473:{cid = 2510;}// file: 32
			case 2510:{cid = 2511;}// file: 32
			case 2511:{cid = 2512;}// file: 32
			case 2512:{cid = 2773;}// file: 32
			case 2773:{cid = 2774;}// file: 32
			case 2774:{cid = 2775;}// file: 32
			case 2775:{cid = 2781;}// file: 32
			case 2781:{cid = 2792;}// file: 32
			case 2792:{cid = 2793;}// file: 32
			case 2793:{cid = 2794;}// file: 32
			case 2794:{cid = 2795;}// file: 32
			case 2795:{cid = 2796;}// file: 32
			case 2796:{cid = 2797;}// file: 32
			case 2797:{cid = 3489;}// file: 32
			case 3489:{cid = 3491;}// file: 32
			case 3491:{cid = 3526;}// file: 32
			case 3526:{cid = 3629;}// file: 32
			case 3629:{cid = 3658;}// file: 32
			case 3658:{cid = 3659;}// file: 32
			case 3659:{cid = 3666;}// file: 32
			case 3666:{cid = 3814;}// file: 32
			case 3814:{cid = 3816;}// file: 32
			case 3816:{cid = 3881;}// file: 32
			case 3881:{cid = 3882;}// file: 32
			case 3882:{cid = 4726;}// file: 32
			case 4726:{cid = 4727;}// file: 32
			case 4727:{cid = 4828;}// file: 32
			case 4828:{cid = 4829;}// file: 32
			case 4829:{cid = 4830;}// file: 32
			case 4830:{cid = 4831;}// file: 32
			case 4831:{cid = 4832;}// file: 32
			case 4832:{cid = 4833;}// file: 32
			case 4833:{cid = 4838;}// file: 32
			case 4838:{cid = 4854;}// file: 32
			case 4854:{cid = 4855;}// file: 32
			case 4855:{cid = 4856;}// file: 32
			case 4856:{cid = 4862;}// file: 32
			case 4862:{cid = 4863;}// file: 32
			case 4863:{cid = 4864;}// file: 32
			case 4864:{cid = 4865;}// file: 32
			case 4865:{cid = 4866;}// file: 32
			case 4866:{cid = 4867;}// file: 32
			case 4867:{cid = 4869;}// file: 32
			case 4869:{cid = 4874;}// file: 32
			case 4874:{cid = 4890;}// file: 32
			case 4890:{cid = 4990;}// file: 32
			case 4990:{cid = 4991;}// file: 32
			case 4991:{cid = 4995;}// file: 32
			case 4995:{cid = 4996;}// file: 32
			case 4996:{cid = 4997;}// file: 32
			case 4997:{cid = 4998;}// file: 32
			case 4998:{cid = 4999;}// file: 32
			case 4999:{cid = 5000;}// file: 32
			case 5000:{cid = 5002;}// file: 32
			case 5002:{cid = 5003;}// file: 32
			case 5003:{cid = 5004;}// file: 32
			case 5004:{cid = 5006;}// file: 32
			case 5006:{cid = 5009;}// file: 32
			case 5009:{cid = 5034;}// file: 32
			case 5034:{cid = 6973;}// file: 32
			case 6973:{cid = 7153;}// file: 32
			case 7153:{cid = 7978;}// file: 32
			case 7978:{cid = 7981;}// file: 32
			case 7981:{cid = 8038;}// file: 32
			case 8038:{cid = 8171;}// file: 32
			case 8171:{cid = 8172;}// file: 32
			case 8172:{cid = 8240;}// file: 32
			case 8240:{cid = 8247;}// file: 32
			case 8247:{cid = 8249;}// file: 32
			case 8249:{cid = 8251;}// file: 32
			case 8251:{cid = 8253;}// file: 32
			case 8253:{cid = 8281;}// file: 32
			case 8281:{cid = 8343;}// file: 32
			case 8343:{cid = 8344;}// file: 32
			case 8344:{cid = 8350;}// file: 32
			case 8350:{cid = 8354;}// file: 32
			case 8354:{cid = 8355;}// file: 32
			case 8355:{cid = 8356;}// file: 32
			case 8356:{cid = 8357;}// file: 32
			case 8357:{cid = 8550;}// file: 32
			case 8550:{cid = 9241;}// file: 32
			case 9241:{cid = 10029;}// file: 32
			case 10029:{cid = 10755;}// file: 32
			case 10755:{cid = 10756;}// file: 32
			case 10756:{cid = 10757;}// file: 32
			case 10757:{cid = 10758;}// file: 32
			case 10758:{cid = 10760;}// file: 32
			case 10760:{cid = 10761;}// file: 32
			case 10761:{cid = 10763;}// file: 32
			case 10763:{cid = 10766;}// file: 32
			case 10766:{cid = 10767;}// file: 32
			case 10767:{cid = 10768;}// file: 32
			case 10768:{cid = 10769;}// file: 32
			case 10769:{cid = 10810;}// file: 32
			case 10810:{cid = 10815;}// file: 32
			case 10815:{cid = 10816;}// file: 32
			case 10816:{cid = 10817;}// file: 32
			case 10817:{cid = 10818;}// file: 32
			case 10818:{cid = 10819;}// file: 32
			case 10819:{cid = 11283;}// file: 32
			case 11283:{cid = 11285;}// file: 32
			case 11285:{cid = 14404;}// file: 32
			case 14404:{cid = 14548;}// file: 32
			case 14548:{cid = 14550;}// file: 32
			case 14550:{cid = 14553;}// file: 32
			case 14553:{cid = 16098;}// file: 32
			case 16098:{cid = 16100;}// file: 32
			case 16100:{cid = 16407;}// file: 32
			case 16407:{cid = 16408;}// file: 32
			case 16408:{cid = 16409;}// file: 32
			case 16409:{cid = 16771;}// file: 32
			case 16771:{cid = 3448;}// file: 32
			case 3448:{cid = 3493;}// file: 33
			case 3493:{cid = 4032;}// file: 33
			case 4032:{cid = 4232;}// file: 33
			case 4232:{cid = 4597;}// file: 33
			case 4597:{cid = 4598;}// file: 33
			case 4598:{cid = 4638;}// file: 33
			case 4638:{cid = 4639;}// file: 33
			case 4639:{cid = 4640;}// file: 33
			case 4640:{cid = 4641;}// file: 33
			case 4641:{cid = 4642;}// file: 33
			case 4642:{cid = 4697;}// file: 33
			case 4697:{cid = 6387;}// file: 33
			case 6387:{cid = 6971;}// file: 33
			case 6971:{cid = 6997;}// file: 33
			case 6997:{cid = 7010;}// file: 33
			case 7010:{cid = 7184;}// file: 33
			case 7184:{cid = 7244;}// file: 33
			case 7244:{cid = 7245;}// file: 33
			case 7245:{cid = 7419;}// file: 33
			case 7419:{cid = 7488;}// file: 33
			case 7488:{cid = 7984;}// file: 33
			case 7984:{cid = 8040;}// file: 33
			case 8040:{cid = 8390;}// file: 33
			case 8390:{cid = 8407;}// file: 33
			case 8407:{cid = 8410;}// file: 33
			case 8410:{cid = 8420;}// file: 33
			case 8420:{cid = 8841;}// file: 33
			case 8841:{cid = 9957;}// file: 33
			case 9957:{cid = 10010;}// file: 33
			case 10010:{cid = 10051;}// file: 33
			case 10051:{cid = 10621;}// file: 33
			case 10621:{cid = 10629;}// file: 33
			case 10629:{cid = 10778;}// file: 33
			case 10778:{cid = 10779;}// file: 33
			case 10779:{cid = 10780;}// file: 33
			case 10780:{cid = 10781;}// file: 33
			case 10781:{cid = 10782;}// file: 33
			case 10782:{cid = 10783;}// file: 33
			case 10783:{cid = 10784;}// file: 33
			case 10784:{cid = 10785;}// file: 33
			case 10785:{cid = 10786;}// file: 33
			case 10786:{cid = 10787;}// file: 33
			case 10787:{cid = 10788;}// file: 33
			case 10788:{cid = 17556;}// file: 33
			case 17556:{cid = 17557;}// file: 33
			case 17557:{cid = 17558;}// file: 33
			case 17558:{cid = 1451;}// file: 33
			case 1451:{cid = 1452;}// file: 34
			case 1452:{cid = 1453;}// file: 34
			case 1453:{cid = 1454;}// file: 34
			case 1454:{cid = 1457;}// file: 34
			case 1457:{cid = 1458;}// file: 34
			case 1458:{cid = 1479;}// file: 34
			case 1479:{cid = 1480;}// file: 34
			case 1480:{cid = 1482;}// file: 34
			case 1482:{cid = 1483;}// file: 34
			case 1483:{cid = 3252;}// file: 34
			case 3252:{cid = 3286;}// file: 34
			case 3286:{cid = 3375;}// file: 34
			case 3375:{cid = 3402;}// file: 34
			case 3402:{cid = 3403;}// file: 34
			case 3403:{cid = 3419;}// file: 34
			case 3419:{cid = 12915;}// file: 34
			case 12915:{cid = 12917;}// file: 34
			case 12917:{cid = 12918;}// file: 34
			case 12918:{cid = 12919;}// file: 34
			case 12919:{cid = 12920;}// file: 34
			case 12920:{cid = 12921;}// file: 34
			case 12921:{cid = 12922;}// file: 34
			case 12922:{cid = 13002;}// file: 34
			case 13002:{cid = 13206;}// file: 34
			case 13206:{cid = 13367;}// file: 34
			case 13367:{cid = 14871;}// file: 34
			case 14871:{cid = 14873;}// file: 34
			case 14873:{cid = 14875;}// file: 34
			case 14875:{cid = 16108;}// file: 34
			case 16108:{cid = 16388;}// file: 34
			case 16388:{cid = 16389;}// file: 34
			case 16389:{cid = 16404;}// file: 34
			case 16404:{cid = 16405;}// file: 34
			case 16405:{cid = 16406;}// file: 34
			case 16406:{cid = 17000;}// file: 34
			case 17000:{cid = 17009;}// file: 34
			case 17009:{cid = 17010;}// file: 34
			case 17010:{cid = 17011;}// file: 34
			case 17011:{cid = 17039;}// file: 34
			case 17039:{cid = 17052;}// file: 34
			case 17052:{cid = 17053;}// file: 34
			case 17053:{cid = 17054;}// file: 34
			case 17054:{cid = 17057;}// file: 34
			case 17057:{cid = 17058;}// file: 34
			case 17058:{cid = 17059;}// file: 34
			case 17059:{cid = 17060;}// file: 34
			case 17060:{cid = 17061;}// file: 34
			case 17061:{cid = 17063;}// file: 34
			case 17063:{cid = 17074;}// file: 34
			case 17074:{cid = 17298;}// file: 34
			case 17298:{cid = 17324;}// file: 34
			case 17324:{cid = 17457;}// file: 34
			case 17457:{cid = 3187;}// file: 34
			case 3187:{cid = 3359;}// file: 36
			case 3359:{cid = 3458;}// file: 36
			case 3458:{cid = 3627;}// file: 36
			case 3627:{cid = 4199;}// file: 36
			case 4199:{cid = 4892;}// file: 36
			case 4892:{cid = 5401;}// file: 36
			case 5401:{cid = 5409;}// file: 36
			case 5409:{cid = 5774;}// file: 36
			case 5774:{cid = 5853;}// file: 36
			case 5853:{cid = 6909;}// file: 36
			case 6909:{cid = 6910;}// file: 36
			case 6910:{cid = 7520;}// file: 36
			case 7520:{cid = 7971;}// file: 36
			case 7971:{cid = 8947;}// file: 36
			case 8947:{cid = 8954;}// file: 36
			case 8954:{cid = 9169;}// file: 36
			case 9169:{cid = 9171;}// file: 36
			case 9171:{cid = 9321;}// file: 36
			case 9321:{cid = 9899;}// file: 36
			case 9899:{cid = 10282;}// file: 36
			case 10282:{cid = 10789;}// file: 36
			case 10789:{cid = 11292;}// file: 36
			case 11292:{cid = 11326;}// file: 36
			case 11326:{cid = 11387;}// file: 36
			case 11387:{cid = 11388;}// file: 36
			case 11388:{cid = 11389;}// file: 36
			case 11389:{cid = 11390;}// file: 36
			case 11390:{cid = 11391;}// file: 36
			case 11391:{cid = 11392;}// file: 36
			case 11392:{cid = 11393;}// file: 36
			case 11393:{cid = 11480;}// file: 36
			case 11480:{cid = 11494;}// file: 36
			case 11494:{cid = 11504;}// file: 36
			case 11504:{cid = 11505;}// file: 36
			case 11505:{cid = 11547;}// file: 36
			case 11547:{cid = 12853;}// file: 36
			case 12853:{cid = 13296;}// file: 36
			case 13296:{cid = 14776;}// file: 36
			case 14776:{cid = 14783;}// file: 36
			case 14783:{cid = 14796;}// file: 36
			case 14796:{cid = 14797;}// file: 36
			case 14797:{cid = 14798;}// file: 36
			case 14798:{cid = 14826;}// file: 36
			case 14826:{cid = 14876;}// file: 36
			case 14876:{cid = 16107;}// file: 36
			case 16107:{cid = 16360;}// file: 36
			case 16360:{cid = 16362;}// file: 36
			case 16362:{cid = 16477;}// file: 36
			case 16477:{cid = 17036;}// file: 36
			case 17036:{cid = 17037;}// file: 36
			case 17037:{cid = 17064;}// file: 36
			case 17064:{cid = 17065;}// file: 36
			case 17065:{cid = 17852;}// file: 36
			case 17852:{cid = 17950;}// file: 36
			case 17950:{cid = 18232;}// file: 36
			case 18232:{cid = 18283;}// file: 36
			case 18283:{cid = 18284;}// file: 36
			case 18284:{cid = 18452;}// file: 36
			case 18452:{cid = 18474;}// file: 36
			case 18474:{cid = 1245;}// file: 36
			case 1245:{cid = 1503;}// file: 37
			case 1503:{cid = 1631;}// file: 37
			case 1631:{cid = 1632;}// file: 37
			case 1632:{cid = 1633;}// file: 37
			case 1633:{cid = 1634;}// file: 37
			case 1634:{cid = 1655;}// file: 37
			case 1655:{cid = 1660;}// file: 37
			case 1660:{cid = 1696;}// file: 37
			case 1696:{cid = 1697;}// file: 37
			case 1697:{cid = 1894;}// file: 37
			case 1894:{cid = 2931;}// file: 37
			case 2931:{cid = 3269;}// file: 37
			case 3269:{cid = 3270;}// file: 37
			case 3270:{cid = 3363;}// file: 37
			case 3363:{cid = 3364;}// file: 37
			case 3364:{cid = 3625;}// file: 37
			case 3625:{cid = 3663;}// file: 37
			case 3663:{cid = 3664;}// file: 37
			case 3664:{cid = 3665;}// file: 37
			case 3665:{cid = 3852;}// file: 37
			case 3852:{cid = 5152;}// file: 37
			case 5152:{cid = 5153;}// file: 37
			case 5153:{cid = 6052;}// file: 37
			case 6052:{cid = 7979;}// file: 37
			case 7979:{cid = 7980;}// file: 37
			case 7980:{cid = 16401;}// file: 37
			case 16401:{cid = 8302;}// file: 37
			case 8302:{cid = 8375;}// file: 37
			case 8375:{cid = 12914;}// file: 37
			case 12914:{cid = 12956;}// file: 37
			case 12956:{cid = 13590;}// file: 37
			case 13590:{cid = 13593;}// file: 37
			case 13593:{cid = 13604;}// file: 37
			case 13604:{cid = 13636;}// file: 37
			case 13636:{cid = 13638;}// file: 37
			case 13638:{cid = 13639;}// file: 37
			case 13639:{cid = 13640;}// file: 37
			case 13640:{cid = 13641;}// file: 37
			case 13641:{cid = 13643;}// file: 37
			case 13643:{cid = 13645;}// file: 37
			case 13645:{cid = 13647;}// file: 37
			case 13647:{cid = 13648;}// file: 37
			case 13648:{cid = 16077;}// file: 37
			case 16077:{cid = 16084;}// file: 37
			case 16084:{cid = 16085;}// file: 37
			case 16085:{cid = 16134;}// file: 37
			case 16134:{cid = 16302;}// file: 37
			case 16302:{cid = 16303;}// file: 37
			case 16303:{cid = 16304;}// file: 37
			case 16304:{cid = 16305;}// file: 37
			case 16305:{cid = 16317;}// file: 37
			case 16317:{cid = 16367;}// file: 37
			case 16367:{cid = 17565;}// file: 37
			case 17565:{cid = 18262;}// file: 37
			case 18262:{cid = 18367;}// file: 37
			case 18367:{cid = 18451;}// file: 37
			case 18451:{cid = 18565;}// file: 37
			case 18565:{cid = 18566;}// file: 37
			case 18566:{cid = 18567;}// file: 37
			case 18567:{cid = 18568;}// file: 37
			case 18568:{cid = 18569;}// file: 37
			case 18569:{cid = 18609;}// file: 37
			case 18609:{cid = 1229;}// file: 37
			case 1229:{cid = 1233;}// file: 38
			case 1233:{cid = 1234;}// file: 38
			case 1234:{cid = 1259;}// file: 38
			case 1259:{cid = 1260;}// file: 38
			case 1260:{cid = 1267;}// file: 38
			case 1267:{cid = 1324;}// file: 38
			case 1324:{cid = 1309;}// file: 38
			case 1309:{cid = 1311;}// file: 38
			case 1311:{cid = 1312;}// file: 38
			case 1312:{cid = 1320;}// file: 38
			case 1320:{cid = 1321;}// file: 38
			case 1321:{cid = 1322;}// file: 38
			case 1322:{cid = 1323;}// file: 38
			case 1323:{cid = 1443;}// file: 38
			case 1443:{cid = 1444;}// file: 38
			case 1444:{cid = 1540;}// file: 38
			case 1540:{cid = 1673;}// file: 38
			case 1673:{cid = 1774;}// file: 38
			case 1774:{cid = 2047;}// file: 38
			case 2047:{cid = 2048;}// file: 38
			case 2048:{cid = 2363;}// file: 38
			case 2363:{cid = 2364;}// file: 38
			case 2364:{cid = 2430;}// file: 38
			case 2430:{cid = 2431;}// file: 38
			case 2431:{cid = 2432;}// file: 38
			case 2432:{cid = 2456;}// file: 38
			case 2456:{cid = 2580;}// file: 38
			case 2580:{cid = 2587;}// file: 38
			case 2587:{cid = 2588;}// file: 38
			case 2588:{cid = 2599;}// file: 38
			case 2599:{cid = 2665;}// file: 38
			case 2665:{cid = 2682;}// file: 38
			case 2682:{cid = 2684;}// file: 38
			case 2684:{cid = 2685;}// file: 38
			case 2685:{cid = 2686;}// file: 38
			case 2686:{cid = 2687;}// file: 38
			case 2687:{cid = 2688;}// file: 38
			case 2688:{cid = 2714;}// file: 38
			case 2714:{cid = 2727;}// file: 38
			case 2727:{cid = 2729;}// file: 38
			case 2729:{cid = 2730;}// file: 38
			case 2730:{cid = 2731;}// file: 38
			case 2731:{cid = 2732;}// file: 38
			case 2732:{cid = 2733;}// file: 38
			case 2733:{cid = 2734;}// file: 38
			case 2734:{cid = 2735;}// file: 38
			case 2735:{cid = 2736;}// file: 38
			case 2736:{cid = 2745;}// file: 38
			case 2745:{cid = 2765;}// file: 38
			case 2765:{cid = 2766;}// file: 38
			case 2766:{cid = 2789;}// file: 38
			case 2789:{cid = 2790;}// file: 38
			case 2790:{cid = 2791;}// file: 38
			case 2791:{cid = 3262;}// file: 38
			case 3262:{cid = 3263;}// file: 38
			case 3263:{cid = 3264;}// file: 38
			case 3264:{cid = 3265;}// file: 38
			case 3265:{cid = 3334;}// file: 38
			case 3334:{cid = 3335;}// file: 38
			case 3335:{cid = 3336;}// file: 38
			case 3336:{cid = 3337;}// file: 38
			case 3337:{cid = 3410;}// file: 38
			case 3410:{cid = 3435;}// file: 38
			case 3435:{cid = 3462;}// file: 38
			case 3462:{cid = 3467;}// file: 38
			case 3467:{cid = 3468;}// file: 38
			case 3468:{cid = 3471;}// file: 38
			case 3471:{cid = 3513;}// file: 38
			case 3513:{cid = 3514;}// file: 38
			case 3514:{cid = 3521;}// file: 38
			case 3521:{cid = 3554;}// file: 38
			case 3554:{cid = 3715;}// file: 38
			case 3715:{cid = 3754;}// file: 38
			case 3754:{cid = 3757;}// file: 38
			case 3757:{cid = 3818;}// file: 38
			case 3818:{cid = 3856;}// file: 38
			case 3856:{cid = 4230;}// file: 38
			case 4230:{cid = 4235;}// file: 38
			case 4235:{cid = 4238;}// file: 38
			case 4238:{cid = 4239;}// file: 38
			case 4239:{cid = 4729;}// file: 38
			case 4729:{cid = 4730;}// file: 38
			case 4730:{cid = 4731;}// file: 38
			case 4731:{cid = 4732;}// file: 38
			case 4732:{cid = 4733;}// file: 38
			case 4733:{cid = 4734;}// file: 38
			case 4734:{cid = 4735;}// file: 38
			case 4735:{cid = 4736;}// file: 38
			case 4736:{cid = 4891;}// file: 38
			case 4891:{cid = 4988;}// file: 38
			case 4988:{cid = 4994;}// file: 38
			case 4994:{cid = 5724;}// file: 38
			case 5724:{cid = 5742;}// file: 38
			case 5742:{cid = 5811;}// file: 38
			case 5811:{cid = 5854;}// file: 38
			case 5854:{cid = 6056;}// file: 38
			case 6056:{cid = 6328;}// file: 38
			case 6328:{cid = 6422;}// file: 38
			case 6422:{cid = 6524;}// file: 38
			case 6524:{cid = 6958;}// file: 38
			case 6958:{cid = 6963;}// file: 38
			case 6963:{cid = 6978;}// file: 38
			case 6978:{cid = 6986;}// file: 38
			case 6986:{cid = 7093;}// file: 38
			case 7093:{cid = 7246;}// file: 38
			case 7246:{cid = 7304;}// file: 38
			case 7304:{cid = 7305;}// file: 38
			case 7305:{cid = 7306;}// file: 38
			case 7306:{cid = 7307;}// file: 38
			case 7307:{cid = 7308;}// file: 38
			case 7308:{cid = 7315;}// file: 38
			case 7315:{cid = 7415;}// file: 38
			case 7415:{cid = 7425;}// file: 38
			case 7425:{cid = 7597;}// file: 38
			case 7597:{cid = 7606;}// file: 38
			case 7606:{cid = 7610;}// file: 38
			case 7610:{cid = 7666;}// file: 38
			case 7666:{cid = 7900;}// file: 38
			case 7900:{cid = 7901;}// file: 38
			case 7901:{cid = 7902;}// file: 38
			case 7902:{cid = 7903;}// file: 38
			case 7903:{cid = 7904;}// file: 38
			case 7904:{cid = 7905;}// file: 38
			case 7905:{cid = 7906;}// file: 38
			case 7906:{cid = 7907;}// file: 38
			case 7907:{cid = 7908;}// file: 38
			case 7908:{cid = 7909;}// file: 38
			case 7909:{cid = 7910;}// file: 38
			case 7910:{cid = 7911;}// file: 38
			case 7911:{cid = 7912;}// file: 38
			case 7912:{cid = 7913;}// file: 38
			case 7913:{cid = 7914;}// file: 38
			case 7914:{cid = 7915;}// file: 38
			case 7915:{cid = 7918;}// file: 38
			case 7918:{cid = 8044;}// file: 38
			case 8044:{cid = 8132;}// file: 38
			case 8132:{cid = 8292;}// file: 38
			case 8292:{cid = 8293;}// file: 38
			case 8293:{cid = 8294;}// file: 38
			case 8294:{cid = 8310;}// file: 38
			case 8310:{cid = 8322;}// file: 38
			case 8322:{cid = 8323;}// file: 38
			case 8323:{cid = 8325;}// file: 38
			case 8325:{cid = 8326;}// file: 38
			case 8326:{cid = 8327;}// file: 38
			case 8327:{cid = 8328;}// file: 38
			case 8328:{cid = 8329;}// file: 38
			case 8329:{cid = 8330;}// file: 38
			case 8330:{cid = 8331;}// file: 38
			case 8331:{cid = 8332;}// file: 38
			case 8332:{cid = 8406;}// file: 38
			case 8406:{cid = 8408;}// file: 38
			case 8408:{cid = 8412;}// file: 38
			case 8412:{cid = 8526;}// file: 38
			case 8526:{cid = 8530;}// file: 38
			case 8530:{cid = 8536;}// file: 38
			case 8536:{cid = 8548;}// file: 38
			case 8548:{cid = 8618;}// file: 38
			case 8618:{cid = 8621;}// file: 38
			case 8621:{cid = 8644;}// file: 38
			case 8644:{cid = 9132;}// file: 38
			case 9132:{cid = 9184;}// file: 38
			case 9184:{cid = 9185;}// file: 38
			case 9185:{cid = 9186;}// file: 38
			case 9186:{cid = 9187;}// file: 38
			case 9187:{cid = 9188;}// file: 38
			case 9188:{cid = 9189;}// file: 38
			case 9189:{cid = 9190;}// file: 38
			case 9190:{cid = 9191;}// file: 38
			case 9191:{cid = 9314;}// file: 38
			case 9314:{cid = 9526;}// file: 38
			case 9526:{cid = 9527;}// file: 38
			case 9527:{cid = 9528;}// file: 38
			case 9528:{cid = 10236;}// file: 38
			case 10236:{cid = 10271;}// file: 38
			case 10271:{cid = 10281;}// file: 38
			case 10281:{cid = 10837;}// file: 38
			case 10837:{cid = 10838;}// file: 38
			case 10838:{cid = 11395;}// file: 38
			case 11395:{cid = 11432;}// file: 38
			case 11432:{cid = 11435;}// file: 38
			case 11435:{cid = 11500;}// file: 38
			case 11500:{cid = 12846;}// file: 38
			case 12846:{cid = 12936;}// file: 38
			case 12936:{cid = 13722;}// file: 38
			case 13722:{cid = 13831;}// file: 38
			case 13831:{cid = 14467;}// file: 38
			case 14467:{cid = 14539;}// file: 38
			case 14539:{cid = 14562;}// file: 38
			case 14562:{cid = 14626;}// file: 38
			case 14626:{cid = 14637;}// file: 38
			case 14637:{cid = 16002;}// file: 38
			case 16002:{cid = 16480;}// file: 38
			case 16480:{cid = 16760;}// file: 38
			case 16760:{cid = 17042;}// file: 38
			case 17042:{cid = 17323;}// file: 38
			case 17323:{cid = 17535;}// file: 38
			case 17535:{cid = 17539;}// file: 38
			case 17539:{cid = 17540;}// file: 38
			case 17540:{cid = 17915;}// file: 38
			case 17915:{cid = 17916;}// file: 38
			case 17916:{cid = 17917;}// file: 38
			case 17917:{cid = 17918;}// file: 38
			case 17918:{cid = 17919;}// file: 38
			case 17919:{cid = 18243;}// file: 38
			case 18243:{cid = 18244;}// file: 38
			case 18244:{cid = 3330;}// file: 38
			case 3330:{cid = 3331;}// file: 2
			case 3331:{cid = 3381;}// file: 2
			case 3381:{cid = 3411;}// file: 2
			case 3411:{cid = 3412;}// file: 2
			case 3412:{cid = 3990;}// file: 2
			case 3990:{cid = 3991;}// file: 2
			case 3991:{cid = 3992;}// file: 2
			case 3992:{cid = 3993;}// file: 2
			case 3993:{cid = 3994;}// file: 2
			case 3994:{cid = 3995;}// file: 2
			case 3995:{cid = 3996;}// file: 2
			case 3996:{cid = 4085;}// file: 2
			case 4085:{cid = 4086;}// file: 2
			case 4086:{cid = 4087;}// file: 2
			case 4087:{cid = 4088;}// file: 2
			case 4088:{cid = 4089;}// file: 2
			case 4089:{cid = 4090;}// file: 2
			case 4090:{cid = 4091;}// file: 2
			case 4091:{cid = 4107;}// file: 2
			case 4107:{cid = 4108;}// file: 2
			case 4108:{cid = 4125;}// file: 2
			case 4125:{cid = 4127;}// file: 2
			case 4127:{cid = 4128;}// file: 2
			case 4128:{cid = 4129;}// file: 2
			case 4129:{cid = 4131;}// file: 2
			case 4131:{cid = 4133;}// file: 2
			case 4133:{cid = 4139;}// file: 2
			case 4139:{cid = 4142;}// file: 2
			case 4142:{cid = 4144;}// file: 2
			case 4144:{cid = 4146;}// file: 2
			case 4146:{cid = 4148;}// file: 2
			case 4148:{cid = 4150;}// file: 2
			case 4150:{cid = 4152;}// file: 2
			case 4152:{cid = 4154;}// file: 2
			case 4154:{cid = 4156;}// file: 2
			case 4156:{cid = 4158;}// file: 2
			case 4158:{cid = 4160;}// file: 2
			case 4160:{cid = 4163;}// file: 2
			case 4163:{cid = 4165;}// file: 2
			case 4165:{cid = 4168;}// file: 2
			case 4168:{cid = 4182;}// file: 2
			case 4182:{cid = 4203;}// file: 2
			case 4203:{cid = 4207;}// file: 2
			case 4207:{cid = 4209;}// file: 2
			case 4209:{cid = 4233;}// file: 2
			case 4233:{cid = 4553;}// file: 2
			case 4553:{cid = 4557;}// file: 2
			case 4557:{cid = 4567;}// file: 2
			case 4567:{cid = 4589;}// file: 2
			case 4589:{cid = 4644;}// file: 2
			case 4644:{cid = 4645;}// file: 2
			case 4645:{cid = 4646;}// file: 2
			case 4646:{cid = 4647;}// file: 2
			case 4647:{cid = 4648;}// file: 2
			case 4648:{cid = 4649;}// file: 2
			case 4649:{cid = 4650;}// file: 2
			case 4650:{cid = 4651;}// file: 2
			case 4651:{cid = 4652;}// file: 2
			case 4652:{cid = 4653;}// file: 2
			case 4653:{cid = 4654;}// file: 2
			case 4654:{cid = 4656;}// file: 2
			case 4656:{cid = 4658;}// file: 2
			case 4658:{cid = 4660;}// file: 2
			case 4660:{cid = 4662;}// file: 2
			case 4662:{cid = 4664;}// file: 2
			case 4664:{cid = 4666;}// file: 2
			case 4666:{cid = 4679;}// file: 2
			case 4679:{cid = 4692;}// file: 2
			case 4692:{cid = 4694;}// file: 2
			case 4694:{cid = 4695;}// file: 2
			case 4695:{cid = 4710;}// file: 2
			case 4710:{cid = 4807;}// file: 2
			case 4807:{cid = 4808;}// file: 2
			case 4808:{cid = 4809;}// file: 2
			case 4809:{cid = 4820;}// file: 2
			case 4820:{cid = 4821;}// file: 2
			case 4821:{cid = 4822;}// file: 2
			case 4822:{cid = 4823;}// file: 2
			case 4823:{cid = 4827;}// file: 2
			case 4827:{cid = 4834;}// file: 2
			case 4834:{cid = 4835;}// file: 2
			case 4835:{cid = 4836;}// file: 2
			case 4836:{cid = 4837;}// file: 2
			case 4837:{cid = 4839;}// file: 2
			case 4839:{cid = 4840;}// file: 2
			case 4840:{cid = 4841;}// file: 2
			case 4841:{cid = 4846;}// file: 2
			case 4846:{cid = 4868;}// file: 2
			case 4868:{cid = 4870;}// file: 2
			case 4870:{cid = 4871;}// file: 2
			case 4871:{cid = 4872;}// file: 2
			case 4872:{cid = 4878;}// file: 2
			case 4878:{cid = 4895;}// file: 2
			case 4895:{cid = 5013;}// file: 2
			case 5013:{cid = 5021;}// file: 2
			case 5021:{cid = 5026;}// file: 2
			case 5026:{cid = 5028;}// file: 2
			case 5028:{cid = 5038;}// file: 2
			case 5038:{cid = 5046;}// file: 2
			case 5046:{cid = 5052;}// file: 2
			case 5052:{cid = 5106;}// file: 2
			case 5106:{cid = 5112;}// file: 2
			case 5112:{cid = 5113;}// file: 2
			case 5113:{cid = 5120;}// file: 2
			case 5120:{cid = 5121;}// file: 2
			case 5121:{cid = 5124;}// file: 2
			case 5124:{cid = 5125;}// file: 2
			case 5125:{cid = 5128;}// file: 2
			case 5128:{cid = 5133;}// file: 2
			case 5133:{cid = 5141;}// file: 2
			case 5141:{cid = 5147;}// file: 2
			case 5147:{cid = 5149;}// file: 2
			case 5149:{cid = 5178;}// file: 2
			case 5178:{cid = 5188;}// file: 2
			case 5188:{cid = 5191;}// file: 2
			case 5191:{cid = 5250;}// file: 2
			case 5250:{cid = 5271;}// file: 2
			case 5271:{cid = 5276;}// file: 2
			case 5276:{cid = 5296;}// file: 2
			case 5296:{cid = 5297;}// file: 2
			case 5297:{cid = 5298;}// file: 2
			case 5298:{cid = 5314;}// file: 2
			case 5314:{cid = 5329;}// file: 2
			case 5329:{cid = 5330;}// file: 2
			case 5330:{cid = 5333;}// file: 2
			case 5333:{cid = 5349;}// file: 2
			case 5349:{cid = 5353;}// file: 2
			case 5353:{cid = 5391;}// file: 2
			case 5391:{cid = 5394;}// file: 2
			case 5394:{cid = 5395;}// file: 2
			case 5395:{cid = 5411;}// file: 2
			case 5411:{cid = 5431;}// file: 2
			case 5431:{cid = 5432;}// file: 2
			case 5432:{cid = 5433;}// file: 2
			case 5433:{cid = 5434;}// file: 2
			case 5434:{cid = 5435;}// file: 2
			case 5435:{cid = 5436;}// file: 2
			case 5436:{cid = 5437;}// file: 2
			case 5437:{cid = 5438;}// file: 2
			case 5438:{cid = 5439;}// file: 2
			case 5439:{cid = 5440;}// file: 2
			case 5440:{cid = 5441;}// file: 2
			case 5441:{cid = 5442;}// file: 2
			case 5442:{cid = 5456;}// file: 2
			case 5456:{cid = 5469;}// file: 2
			case 5469:{cid = 5470;}// file: 2
			case 5470:{cid = 5472;}// file: 2
			case 5472:{cid = 5473;}// file: 2
			case 5473:{cid = 5481;}// file: 2
			case 5481:{cid = 5482;}// file: 2
			case 5482:{cid = 5483;}// file: 2
			case 5483:{cid = 5484;}// file: 2
			case 5484:{cid = 5485;}// file: 2
			case 5485:{cid = 5486;}// file: 2
			case 5486:{cid = 5487;}// file: 2
			case 5487:{cid = 5488;}// file: 2
			case 5488:{cid = 5489;}// file: 2
			case 5489:{cid = 5490;}// file: 2
			case 5490:{cid = 5491;}// file: 2
			case 5491:{cid = 5492;}// file: 2
			case 5492:{cid = 5493;}// file: 2
			case 5493:{cid = 5494;}// file: 2
			case 5494:{cid = 5495;}// file: 2
			case 5495:{cid = 5496;}// file: 2
			case 5496:{cid = 5497;}// file: 2
			case 5497:{cid = 5498;}// file: 2
			case 5498:{cid = 5499;}// file: 2
			case 5499:{cid = 5500;}// file: 2
			case 5500:{cid = 5501;}// file: 2
			case 5501:{cid = 5502;}// file: 2
			case 5502:{cid = 5503;}// file: 2
			case 5503:{cid = 5504;}// file: 2
			case 5504:{cid = 5505;}// file: 2
			case 5505:{cid = 5506;}// file: 2
			case 5506:{cid = 5507;}// file: 2
			case 5507:{cid = 5508;}// file: 2
			case 5508:{cid = 5509;}// file: 2
			case 5509:{cid = 5510;}// file: 2
			case 5510:{cid = 5511;}// file: 2
			case 5511:{cid = 5512;}// file: 2
			case 5512:{cid = 5528;}// file: 2
			case 5528:{cid = 5650;}// file: 2
			case 5650:{cid = 5668;}// file: 2
			case 5668:{cid = 5703;}// file: 2
			case 5703:{cid = 5707;}// file: 2
			case 5707:{cid = 5744;}// file: 2
			case 5744:{cid = 5745;}// file: 2
			case 5745:{cid = 5746;}// file: 2
			case 5746:{cid = 5747;}// file: 2
			case 5747:{cid = 5748;}// file: 2
			case 5748:{cid = 5749;}// file: 2
			case 5749:{cid = 5750;}// file: 2
			case 5750:{cid = 5751;}// file: 2
			case 5751:{cid = 5752;}// file: 2
			case 5752:{cid = 5753;}// file: 2
			case 5753:{cid = 5754;}// file: 2
			case 5754:{cid = 5755;}// file: 2
			case 5755:{cid = 5756;}// file: 2
			case 5756:{cid = 5757;}// file: 2
			case 5757:{cid = 5758;}// file: 2
			case 5758:{cid = 5759;}// file: 2
			case 5759:{cid = 5793;}// file: 2
			case 5793:{cid = 5794;}// file: 2
			case 5794:{cid = 5795;}// file: 2
			case 5795:{cid = 5796;}// file: 2
			case 5796:{cid = 5797;}// file: 2
			case 5797:{cid = 5798;}// file: 2
			case 5798:{cid = 5799;}// file: 2
			case 5799:{cid = 5800;}// file: 2
			case 5800:{cid = 5801;}// file: 2
			case 5801:{cid = 5802;}// file: 2
			case 5802:{cid = 5803;}// file: 2
			case 5803:{cid = 5804;}// file: 2
			case 5804:{cid = 5805;}// file: 2
			case 5805:{cid = 5806;}// file: 2
			case 5806:{cid = 5807;}// file: 2
			case 5807:{cid = 5808;}// file: 2
			case 5808:{cid = 5809;}// file: 2
			case 5809:{cid = 5859;}// file: 2
			case 5859:{cid = 5860;}// file: 2
			case 5860:{cid = 5861;}// file: 2
			case 5861:{cid = 5862;}// file: 2
			case 5862:{cid = 5866;}// file: 2
			case 5866:{cid = 5994;}// file: 2
			case 5994:{cid = 5995;}// file: 2
			case 5995:{cid = 6035;}// file: 2
			case 6035:{cid = 6054;}// file: 2
			case 6054:{cid = 6055;}// file: 2
			case 6055:{cid = 6111;}// file: 2
			case 6111:{cid = 6112;}// file: 2
			case 6112:{cid = 6113;}// file: 2
			case 6113:{cid = 6114;}// file: 2
			case 6114:{cid = 6115;}// file: 2
			case 6115:{cid = 6116;}// file: 2
			case 6116:{cid = 6117;}// file: 2
			case 6117:{cid = 6118;}// file: 2
			case 6118:{cid = 6119;}// file: 2
			case 6119:{cid = 6120;}// file: 2
			case 6120:{cid = 6121;}// file: 2
			case 6121:{cid = 6122;}// file: 2
			case 6122:{cid = 6123;}// file: 2
			case 6123:{cid = 6124;}// file: 2
			case 6124:{cid = 6125;}// file: 2
			case 6125:{cid = 6126;}// file: 2
			case 6126:{cid = 6127;}// file: 2
			case 6127:{cid = 6128;}// file: 2
			case 6128:{cid = 6129;}// file: 2
			case 6129:{cid = 6225;}// file: 2
			case 6225:{cid = 6231;}// file: 2
			case 6231:{cid = 6235;}// file: 2
			case 6235:{cid = 6291;}// file: 2
			case 6291:{cid = 6301;}// file: 2
			case 6301:{cid = 6302;}// file: 2
			case 6302:{cid = 6303;}// file: 2
			case 6303:{cid = 6304;}// file: 2
			case 6304:{cid = 6305;}// file: 2
			case 6305:{cid = 6306;}// file: 2
			case 6306:{cid = 6307;}// file: 2
			case 6307:{cid = 6308;}// file: 2
			case 6308:{cid = 6309;}// file: 2
			case 6309:{cid = 6310;}// file: 2
			case 6310:{cid = 6311;}// file: 2
			case 6311:{cid = 6314;}// file: 2
			case 6314:{cid = 6316;}// file: 2
			case 6316:{cid = 6317;}// file: 2
			case 6317:{cid = 6318;}// file: 2
			case 6318:{cid = 6319;}// file: 2
			case 6319:{cid = 6320;}// file: 2
			case 6320:{cid = 6321;}// file: 2
			case 6321:{cid = 6322;}// file: 2
			case 6322:{cid = 6323;}// file: 2
			case 6323:{cid = 6324;}// file: 2
			case 6324:{cid = 6325;}// file: 2
			case 6325:{cid = 6326;}// file: 2
			case 6326:{cid = 6327;}// file: 2
			case 6327:{cid = 6329;}// file: 2
			case 6329:{cid = 6330;}// file: 2
			case 6330:{cid = 6331;}// file: 2
			case 6331:{cid = 6333;}// file: 2
			case 6333:{cid = 6341;}// file: 2
			case 6341:{cid = 6345;}// file: 2
			case 6345:{cid = 6427;}// file: 2
			case 6427:{cid = 6428;}// file: 2
			case 6428:{cid = 6448;}// file: 2
			case 6448:{cid = 6449;}// file: 2
			case 6449:{cid = 6450;}// file: 2
			case 6450:{cid = 6507;}// file: 2
			case 6507:{cid = 6508;}// file: 2
			case 6508:{cid = 6509;}// file: 2
			case 6509:{cid = 6876;}// file: 2
			case 6876:{cid = 6877;}// file: 2
			case 6877:{cid = 6878;}// file: 2
			case 6878:{cid = 6879;}// file: 2
			case 6879:{cid = 6880;}// file: 2
			case 6880:{cid = 6881;}// file: 2
			case 6881:{cid = 6886;}// file: 2
			case 6886:{cid = 6887;}// file: 2
			case 6887:{cid = 6888;}// file: 2
			case 6888:{cid = 6897;}// file: 2
			case 6897:{cid = 6898;}// file: 2
			case 6898:{cid = 6899;}// file: 2
			case 6899:{cid = 6900;}// file: 2
			case 6900:{cid = 6945;}// file: 2
			case 6945:{cid = 6948;}// file: 2
			case 6948:{cid = 6949;}// file: 2
			case 6949:{cid = 6950;}// file: 2
			case 6950:{cid = 6951;}// file: 2
			case 6951:{cid = 6952;}// file: 2
			case 6952:{cid = 6953;}// file: 2
			case 6953:{cid = 6956;}// file: 2
			case 6956:{cid = 6974;}// file: 2
			case 6974:{cid = 6990;}// file: 2
			case 6990:{cid = 6991;}// file: 2
			case 6991:{cid = 6999;}// file: 2
			case 6999:{cid = 7036;}// file: 2
			case 7036:{cid = 7041;}// file: 2
			case 7041:{cid = 7042;}// file: 2
			case 7042:{cid = 7043;}// file: 2
			case 7043:{cid = 7052;}// file: 2
			case 7052:{cid = 7053;}// file: 2
			case 7053:{cid = 7054;}// file: 2
			case 7054:{cid = 7055;}// file: 2
			case 7055:{cid = 7056;}// file: 2
			case 7056:{cid = 7057;}// file: 2
			case 7057:{cid = 7064;}// file: 2
			case 7064:{cid = 7069;}// file: 2
			case 7069:{cid = 7320;}// file: 2
			case 7320:{cid = 7321;}// file: 2
			case 7321:{cid = 7324;}// file: 2
			case 7324:{cid = 7326;}// file: 2
			case 7326:{cid = 7327;}// file: 2
			case 7327:{cid = 7334;}// file: 2
			case 7334:{cid = 7335;}// file: 2
			case 7335:{cid = 7336;}// file: 2
			case 7336:{cid = 7337;}// file: 2
			case 7337:{cid = 7355;}// file: 2
			case 7355:{cid = 7362;}// file: 2
			case 7362:{cid = 7364;}// file: 2
			case 7364:{cid = 7383;}// file: 2
			case 7383:{cid = 7427;}// file: 2
			case 7427:{cid = 7428;}// file: 2
			case 7428:{cid = 7429;}// file: 2
			case 7429:{cid = 7430;}// file: 2
			case 7430:{cid = 7431;}// file: 2
			case 7431:{cid = 7432;}// file: 2
			case 7432:{cid = 7433;}// file: 2
			case 7433:{cid = 7434;}// file: 2
			case 7434:{cid = 7435;}// file: 2
			case 7435:{cid = 7436;}// file: 2
			case 7436:{cid = 7437;}// file: 2
			case 7437:{cid = 7438;}// file: 2
			case 7438:{cid = 7439;}// file: 2
			case 7439:{cid = 7440;}// file: 2
			case 7440:{cid = 7441;}// file: 2
			case 7441:{cid = 7442;}// file: 2
			case 7442:{cid = 7443;}// file: 2
			case 7443:{cid = 7444;}// file: 2
			case 7444:{cid = 7445;}// file: 2
			case 7445:{cid = 7446;}// file: 2
			case 7446:{cid = 7447;}// file: 2
			case 7447:{cid = 7476;}// file: 2
			case 7476:{cid = 7477;}// file: 2
			case 7477:{cid = 7478;}// file: 2
			case 7478:{cid = 7479;}// file: 2
			case 7479:{cid = 7480;}// file: 2
			case 7480:{cid = 7481;}// file: 2
			case 7481:{cid = 7482;}// file: 2
			case 7482:{cid = 7483;}// file: 2
			case 7483:{cid = 7484;}// file: 2
			case 7484:{cid = 7485;}// file: 2
			case 7485:{cid = 7486;}// file: 2
			case 7486:{cid = 7544;}// file: 2
			case 7544:{cid = 7545;}// file: 2
			case 7545:{cid = 7546;}// file: 2
			case 7546:{cid = 7547;}// file: 2
			case 7547:{cid = 7548;}// file: 2
			case 7548:{cid = 7549;}// file: 2
			case 7549:{cid = 7550;}// file: 2
			case 7550:{cid = 7551;}// file: 2
			case 7551:{cid = 7552;}// file: 2
			case 7552:{cid = 7558;}// file: 2
			case 7558:{cid = 7559;}// file: 2
			case 7559:{cid = 7580;}// file: 2
			case 7580:{cid = 7581;}// file: 2
			case 7581:{cid = 7587;}// file: 2
			case 7587:{cid = 7589;}// file: 2
			case 7589:{cid = 7590;}// file: 2
			case 7590:{cid = 7605;}// file: 2
			case 7605:{cid = 7629;}// file: 2
			case 7629:{cid = 7631;}// file: 2
			case 7631:{cid = 7632;}// file: 2
			case 7632:{cid = 7633;}// file: 2
			case 7633:{cid = 7634;}// file: 2
			case 7634:{cid = 7729;}// file: 2
			case 7729:{cid = 7730;}// file: 2
			case 7730:{cid = 7731;}// file: 2
			case 7731:{cid = 7755;}// file: 2
			case 7755:{cid = 7849;}// file: 2
			case 7849:{cid = 7852;}// file: 2
			case 7852:{cid = 7854;}// file: 2
			case 7854:{cid = 7863;}// file: 2
			case 7863:{cid = 7864;}// file: 2
			case 7864:{cid = 7865;}// file: 2
			case 7865:{cid = 7866;}// file: 2
			case 7866:{cid = 7867;}// file: 2
			case 7867:{cid = 7868;}// file: 2
			case 7868:{cid = 7878;}// file: 2
			case 7878:{cid = 7881;}// file: 2
			case 7881:{cid = 7938;}// file: 2
			case 7938:{cid = 7945;}// file: 2
			case 7945:{cid = 7963;}// file: 2
			case 7963:{cid = 7965;}// file: 2
			case 7965:{cid = 7967;}// file: 2
			case 7967:{cid = 7969;}// file: 2
			case 7969:{cid = 7987;}// file: 2
			case 7987:{cid = 7988;}// file: 2
			case 7988:{cid = 7989;}// file: 2
			case 7989:{cid = 7990;}// file: 2
			case 7990:{cid = 7991;}// file: 2
			case 7991:{cid = 7992;}// file: 2
			case 7992:{cid = 7993;}// file: 2
			case 7993:{cid = 7995;}// file: 2
			case 7995:{cid = 8009;}// file: 2
			case 8009:{cid = 8010;}// file: 2
			case 8010:{cid = 8036;}// file: 2
			case 8036:{cid = 8039;}// file: 2
			case 8039:{cid = 8045;}// file: 2
			case 8045:{cid = 8046;}// file: 2
			case 8046:{cid = 8047;}// file: 2
			case 8047:{cid = 8048;}// file: 2
			case 8048:{cid = 8049;}// file: 2
			case 8049:{cid = 8050;}// file: 2
			case 8050:{cid = 8051;}// file: 2
			case 8051:{cid = 8052;}// file: 2
			case 8052:{cid = 8053;}// file: 2
			case 8053:{cid = 8054;}// file: 2
			case 8054:{cid = 8055;}// file: 2
			case 8055:{cid = 8056;}// file: 2
			case 8056:{cid = 8070;}// file: 2
			case 8070:{cid = 8080;}// file: 2
			case 8080:{cid = 8128;}// file: 2
			case 8128:{cid = 8135;}// file: 2
			case 8135:{cid = 8137;}// file: 2
			case 8137:{cid = 8212;}// file: 2
			case 8212:{cid = 8213;}// file: 2
			case 8213:{cid = 8214;}// file: 2
			case 8214:{cid = 8215;}// file: 2
			case 8215:{cid = 8216;}// file: 2
			case 8216:{cid = 8217;}// file: 2
			case 8217:{cid = 8218;}// file: 2
			case 8218:{cid = 8219;}// file: 2
			case 8219:{cid = 8236;}// file: 2
			case 8236:{cid = 8244;}// file: 2
			case 8244:{cid = 8245;}// file: 2
			case 8245:{cid = 8246;}// file: 2
			case 8246:{cid = 8256;}// file: 2
			case 8256:{cid = 8290;}// file: 2
			case 8290:{cid = 8305;}// file: 2
			case 8305:{cid = 8368;}// file: 2
			case 8368:{cid = 8377;}// file: 2
			case 8377:{cid = 8380;}// file: 2
			case 8380:{cid = 8382;}// file: 2
			case 8382:{cid = 8383;}// file: 2
			case 8383:{cid = 8386;}// file: 2
			case 8386:{cid = 8388;}// file: 2
			case 8388:{cid = 8438;}// file: 2
			case 8438:{cid = 8439;}// file: 2
			case 8439:{cid = 8440;}// file: 2
			case 8440:{cid = 8441;}// file: 2
			case 8441:{cid = 8442;}// file: 2
			case 8442:{cid = 8443;}// file: 2
			case 8443:{cid = 8444;}// file: 2
			case 8444:{cid = 8445;}// file: 2
			case 8445:{cid = 8446;}// file: 2
			case 8446:{cid = 8447;}// file: 2
			case 8447:{cid = 8448;}// file: 2
			case 8448:{cid = 8449;}// file: 2
			case 8449:{cid = 8450;}// file: 2
			case 8450:{cid = 8451;}// file: 2
			case 8451:{cid = 8452;}// file: 2
			case 8452:{cid = 8453;}// file: 2
			case 8453:{cid = 8454;}// file: 2
			case 8454:{cid = 8455;}// file: 2
			case 8455:{cid = 8456;}// file: 2
			case 8456:{cid = 8457;}// file: 2
			case 8457:{cid = 8458;}// file: 2
			case 8458:{cid = 8471;}// file: 2
			case 8471:{cid = 8472;}// file: 2
			case 8472:{cid = 8473;}// file: 2
			case 8473:{cid = 8474;}// file: 2
			case 8474:{cid = 8475;}// file: 2
			case 8475:{cid = 8476;}// file: 2
			case 8476:{cid = 8477;}// file: 2
			case 8477:{cid = 8510;}// file: 2
			case 8510:{cid = 8511;}// file: 2
			case 8511:{cid = 8512;}// file: 2
			case 8512:{cid = 8514;}// file: 2
			case 8514:{cid = 8517;}// file: 2
			case 8517:{cid = 8518;}// file: 2
			case 8518:{cid = 8519;}// file: 2
			case 8519:{cid = 8520;}// file: 2
			case 8520:{cid = 8521;}// file: 2
			case 8521:{cid = 8522;}// file: 2
			case 8522:{cid = 8523;}// file: 2
			case 8523:{cid = 8524;}// file: 2
			case 8524:{cid = 8525;}// file: 2
			case 8525:{cid = 8543;}// file: 2
			case 8543:{cid = 8552;}// file: 2
			case 8552:{cid = 8561;}// file: 2
			case 8561:{cid = 8562;}// file: 2
			case 8562:{cid = 8609;}// file: 2
			case 8609:{cid = 8610;}// file: 2
			case 8610:{cid = 8611;}// file: 2
			case 8611:{cid = 8612;}// file: 2
			case 8612:{cid = 8616;}// file: 2
			case 8616:{cid = 8622;}// file: 2
			case 8622:{cid = 8637;}// file: 2
			case 8637:{cid = 8638;}// file: 2
			case 8638:{cid = 8824;}// file: 2
			case 8824:{cid = 8832;}// file: 2
			case 8832:{cid = 8838;}// file: 2
			case 8838:{cid = 8932;}// file: 2
			case 8932:{cid = 9000;}// file: 2
			case 9000:{cid = 9001;}// file: 2
			case 9001:{cid = 9002;}// file: 2
			case 9002:{cid = 9003;}// file: 2
			case 9003:{cid = 9004;}// file: 2
			case 9004:{cid = 9005;}// file: 2
			case 9005:{cid = 9006;}// file: 2
			case 9006:{cid = 9007;}// file: 2
			case 9007:{cid = 9008;}// file: 2
			case 9008:{cid = 9021;}// file: 2
			case 9021:{cid = 9022;}// file: 2
			case 9022:{cid = 9023;}// file: 2
			case 9023:{cid = 9024;}// file: 2
			case 9024:{cid = 9025;}// file: 2
			case 9025:{cid = 9026;}// file: 2
			case 9026:{cid = 9027;}// file: 2
			case 9027:{cid = 9028;}// file: 2
			case 9028:{cid = 9036;}// file: 2
			case 9036:{cid = 9042;}// file: 2
			case 9042:{cid = 9115;}// file: 2
			case 9115:{cid = 9116;}// file: 2
			case 9116:{cid = 9117;}// file: 2
			case 9117:{cid = 9118;}// file: 2
			case 9118:{cid = 9119;}// file: 2
			case 9119:{cid = 9120;}// file: 2
			case 9120:{cid = 9150;}// file: 2
			case 9150:{cid = 9205;}// file: 2
			case 9205:{cid = 9222;}// file: 2
			case 9222:{cid = 9231;}// file: 2
			case 9231:{cid = 9232;}// file: 2
			case 9232:{cid = 9233;}// file: 2
			case 9233:{cid = 9250;}// file: 2
			case 9250:{cid = 9251;}// file: 2
			case 9251:{cid = 9252;}// file: 2
			case 9252:{cid = 9262;}// file: 2
			case 9262:{cid = 9264;}// file: 2
			case 9264:{cid = 9265;}// file: 2
			case 9265:{cid = 9266;}// file: 2
			case 9266:{cid = 9267;}// file: 2
			case 9267:{cid = 9269;}// file: 2
			case 9269:{cid = 9476;}// file: 2
			case 9476:{cid = 9485;}// file: 2
			case 9485:{cid = 9486;}// file: 2
			case 9486:{cid = 9487;}// file: 2
			case 9487:{cid = 9488;}// file: 2
			case 9488:{cid = 9489;}// file: 2
			case 9489:{cid = 9490;}// file: 2
			case 9490:{cid = 9491;}// file: 2
			case 9491:{cid = 9492;}// file: 2
			case 9492:{cid = 9493;}// file: 2
			case 9493:{cid = 9570;}// file: 2
			case 9570:{cid = 9571;}// file: 2
			case 9571:{cid = 9575;}// file: 2
			case 9575:{cid = 9591;}// file: 2
			case 9591:{cid = 9600;}// file: 2
			case 9600:{cid = 9601;}// file: 2
			case 9601:{cid = 9602;}// file: 2
			case 9602:{cid = 9603;}// file: 2
			case 9603:{cid = 9652;}// file: 2
			case 9652:{cid = 9653;}// file: 2
			case 9653:{cid = 9683;}// file: 2
			case 9683:{cid = 9685;}// file: 2
			case 9685:{cid = 9689;}// file: 2
			case 9689:{cid = 9690;}// file: 2
			case 9690:{cid = 9693;}// file: 2
			case 9693:{cid = 9694;}// file: 2
			case 9694:{cid = 9696;}// file: 2
			case 9696:{cid = 9699;}// file: 2
			case 9699:{cid = 9700;}// file: 2
			case 9700:{cid = 9701;}// file: 2
			case 9701:{cid = 9702;}// file: 2
			case 9702:{cid = 9703;}// file: 2
			case 9703:{cid = 9704;}// file: 2
			case 9704:{cid = 9706;}// file: 2
			case 9706:{cid = 9707;}// file: 2
			case 9707:{cid = 9708;}// file: 2
			case 9708:{cid = 9709;}// file: 2
			case 9709:{cid = 9710;}// file: 2
			case 9710:{cid = 9711;}// file: 2
			case 9711:{cid = 9712;}// file: 2
			case 9712:{cid = 9713;}// file: 2
			case 9713:{cid = 9714;}// file: 2
			case 9714:{cid = 9715;}// file: 2
			case 9715:{cid = 9716;}// file: 2
			case 9716:{cid = 9717;}// file: 2
			case 9717:{cid = 9718;}// file: 2
			case 9718:{cid = 9719;}// file: 2
			case 9719:{cid = 9720;}// file: 2
			case 9720:{cid = 9721;}// file: 2
			case 9721:{cid = 9722;}// file: 2
			case 9722:{cid = 9723;}// file: 2
			case 9723:{cid = 9724;}// file: 2
			case 9724:{cid = 9725;}// file: 2
			case 9725:{cid = 9726;}// file: 2
			case 9726:{cid = 9727;}// file: 2
			case 9727:{cid = 9728;}// file: 2
			case 9728:{cid = 9729;}// file: 2
			case 9729:{cid = 9730;}// file: 2
			case 9730:{cid = 9731;}// file: 2
			case 9731:{cid = 9732;}// file: 2
			case 9732:{cid = 9733;}// file: 2
			case 9733:{cid = 9734;}// file: 2
			case 9734:{cid = 9735;}// file: 2
			case 9735:{cid = 9736;}// file: 2
			case 9736:{cid = 9747;}// file: 2
			case 9747:{cid = 9827;}// file: 2
			case 9827:{cid = 9832;}// file: 2
			case 9832:{cid = 9837;}// file: 2
			case 9837:{cid = 9838;}// file: 2
			case 9838:{cid = 10018;}// file: 2
			case 10018:{cid = 10065;}// file: 2
			case 10065:{cid = 10066;}// file: 2
			case 10066:{cid = 10067;}// file: 2
			case 10067:{cid = 10068;}// file: 2
			case 10068:{cid = 10069;}// file: 2
			case 10069:{cid = 10070;}// file: 2
			case 10070:{cid = 10071;}// file: 2
			case 10071:{cid = 10072;}// file: 2
			case 10072:{cid = 10073;}// file: 2
			case 10073:{cid = 10074;}// file: 2
			case 10074:{cid = 10075;}// file: 2
			case 10075:{cid = 10076;}// file: 2
			case 10076:{cid = 10077;}// file: 2
			case 10077:{cid = 10078;}// file: 2
			case 10078:{cid = 10110;}// file: 2
			case 10110:{cid = 10111;}// file: 2
			case 10111:{cid = 10112;}// file: 2
			case 10112:{cid = 10113;}// file: 2
			case 10113:{cid = 10114;}// file: 2
			case 10114:{cid = 10115;}// file: 2
			case 10115:{cid = 10116;}// file: 2
			case 10116:{cid = 10117;}// file: 2
			case 10117:{cid = 10118;}// file: 2
			case 10118:{cid = 10119;}// file: 2
			case 10119:{cid = 10120;}// file: 2
			case 10120:{cid = 10121;}// file: 2
			case 10121:{cid = 10122;}// file: 2
			case 10122:{cid = 10123;}// file: 2
			case 10123:{cid = 10124;}// file: 2
			case 10124:{cid = 10125;}// file: 2
			case 10125:{cid = 10126;}// file: 2
			case 10126:{cid = 10127;}// file: 2
			case 10127:{cid = 10128;}// file: 2
			case 10128:{cid = 10129;}// file: 2
			case 10129:{cid = 10130;}// file: 2
			case 10130:{cid = 10131;}// file: 2
			case 10131:{cid = 10132;}// file: 2
			case 10132:{cid = 10133;}// file: 2
			case 10133:{cid = 10134;}// file: 2
			case 10134:{cid = 10135;}// file: 2
			case 10135:{cid = 10136;}// file: 2
			case 10136:{cid = 10137;}// file: 2
			case 10137:{cid = 10138;}// file: 2
			case 10138:{cid = 10139;}// file: 2
			case 10139:{cid = 10165;}// file: 2
			case 10165:{cid = 10235;}// file: 2
			case 10235:{cid = 10247;}// file: 2
			case 10247:{cid = 10275;}// file: 2
			case 10275:{cid = 10276;}// file: 2
			case 10276:{cid = 10294;}// file: 2
			case 10294:{cid = 10295;}// file: 2
			case 10295:{cid = 10296;}// file: 2
			case 10296:{cid = 10359;}// file: 2
			case 10359:{cid = 10360;}// file: 2
			case 10360:{cid = 10361;}// file: 2
			case 10361:{cid = 10362;}// file: 2
			case 10362:{cid = 10363;}// file: 2
			case 10363:{cid = 10364;}// file: 2
			case 10364:{cid = 10365;}// file: 2
			case 10365:{cid = 10367;}// file: 2
			case 10367:{cid = 10424;}// file: 2
			case 10424:{cid = 10426;}// file: 2
			case 10426:{cid = 10440;}// file: 2
			case 10440:{cid = 10448;}// file: 2
			case 10448:{cid = 10449;}// file: 2
			case 10449:{cid = 10450;}// file: 2
			case 10450:{cid = 10452;}// file: 2
			case 10452:{cid = 10455;}// file: 2
			case 10455:{cid = 10456;}// file: 2
			case 10456:{cid = 10457;}// file: 2
			case 10457:{cid = 10458;}// file: 2
			case 10458:{cid = 10459;}// file: 2
			case 10459:{cid = 10460;}// file: 2
			case 10460:{cid = 10461;}// file: 2
			case 10461:{cid = 10462;}// file: 2
			case 10462:{cid = 10463;}// file: 2
			case 10463:{cid = 10464;}// file: 2
			case 10464:{cid = 10465;}// file: 2
			case 10465:{cid = 10466;}// file: 2
			case 10466:{cid = 10467;}// file: 2
			case 10467:{cid = 10468;}// file: 2
			case 10468:{cid = 10469;}// file: 2
			case 10469:{cid = 10470;}// file: 2
			case 10470:{cid = 10471;}// file: 2
			case 10471:{cid = 10472;}// file: 2
			case 10472:{cid = 10473;}// file: 2
			case 10473:{cid = 10474;}// file: 2
			case 10474:{cid = 10475;}// file: 2
			case 10475:{cid = 10476;}// file: 2
			case 10476:{cid = 10477;}// file: 2
			case 10477:{cid = 10478;}// file: 2
			case 10478:{cid = 10479;}// file: 2
			case 10479:{cid = 10480;}// file: 2
			case 10480:{cid = 10481;}// file: 2
			case 10481:{cid = 10482;}// file: 2
			case 10482:{cid = 10483;}// file: 2
			case 10483:{cid = 10484;}// file: 2
			case 10484:{cid = 10485;}// file: 2
			case 10485:{cid = 10486;}// file: 2
			case 10486:{cid = 10487;}// file: 2
			case 10487:{cid = 10488;}// file: 2
			case 10488:{cid = 10489;}// file: 2
			case 10489:{cid = 10490;}// file: 2
			case 10490:{cid = 10493;}// file: 2
			case 10493:{cid = 10614;}// file: 2
			case 10614:{cid = 10617;}// file: 2
			case 10617:{cid = 10636;}// file: 2
			case 10636:{cid = 10639;}// file: 2
			case 10639:{cid = 10649;}// file: 2
			case 10649:{cid = 10750;}// file: 2
			case 10750:{cid = 10751;}// file: 2
			case 10751:{cid = 10753;}// file: 2
			case 10753:{cid = 10754;}// file: 2
			case 10754:{cid = 10759;}// file: 2
			case 10759:{cid = 10770;}// file: 2
			case 10770:{cid = 10777;}// file: 2
			case 10777:{cid = 10790;}// file: 2
			case 10790:{cid = 10791;}// file: 2
			case 10791:{cid = 10792;}// file: 2
			case 10792:{cid = 10820;}// file: 2
			case 10820:{cid = 10821;}// file: 2
			case 10821:{cid = 10822;}// file: 2
			case 10822:{cid = 10823;}// file: 2
			case 10823:{cid = 10848;}// file: 2
			case 10848:{cid = 10849;}// file: 2
			case 10849:{cid = 10852;}// file: 2
			case 10852:{cid = 10854;}// file: 2
			case 10854:{cid = 10855;}// file: 2
			case 10855:{cid = 10857;}// file: 2
			case 10857:{cid = 10858;}// file: 2
			case 10858:{cid = 10859;}// file: 2
			case 10859:{cid = 10860;}// file: 2
			case 10860:{cid = 10866;}// file: 2
			case 10866:{cid = 10867;}// file: 2
			case 10867:{cid = 10868;}// file: 2
			case 10868:{cid = 10869;}// file: 2
			case 10869:{cid = 10870;}// file: 2
			case 10870:{cid = 10928;}// file: 2
			case 10928:{cid = 10929;}// file: 2
			case 10929:{cid = 10930;}// file: 2
			case 10930:{cid = 10937;}// file: 2
			case 10937:{cid = 10940;}// file: 2
			case 10940:{cid = 10958;}// file: 2
			case 10958:{cid = 10967;}// file: 2
			case 10967:{cid = 10968;}// file: 2
			case 10968:{cid = 10970;}// file: 2
			case 10970:{cid = 10971;}// file: 2
			case 10971:{cid = 11003;}// file: 2
			case 11003:{cid = 11071;}// file: 2
			case 11071:{cid = 11072;}// file: 2
			case 11072:{cid = 11073;}// file: 2
			case 11073:{cid = 11074;}// file: 2
			case 11074:{cid = 11075;}// file: 2
			case 11075:{cid = 11076;}// file: 2
			case 11076:{cid = 11077;}// file: 2
			case 11077:{cid = 11078;}// file: 2
			case 11078:{cid = 11079;}// file: 2
			case 11079:{cid = 11080;}// file: 2
			case 11080:{cid = 11084;}// file: 2
			case 11084:{cid = 11094;}// file: 2
			case 11094:{cid = 11095;}// file: 2
			case 11095:{cid = 11096;}// file: 2
			case 11096:{cid = 11098;}// file: 2
			case 11098:{cid = 11100;}// file: 2
			case 11100:{cid = 11104;}// file: 2
			case 11104:{cid = 11105;}// file: 2
			case 11105:{cid = 11110;}// file: 2
			case 11110:{cid = 11111;}// file: 2
			case 11111:{cid = 11112;}// file: 2
			case 11112:{cid = 11113;}// file: 2
			case 11113:{cid = 11114;}// file: 2
			case 11114:{cid = 11115;}// file: 2
			case 11115:{cid = 11116;}// file: 2
			case 11116:{cid = 11117;}// file: 2
			case 11117:{cid = 11118;}// file: 2
			case 11118:{cid = 11119;}// file: 2
			case 11119:{cid = 11120;}// file: 2
			case 11120:{cid = 11121;}// file: 2
			case 11121:{cid = 11122;}// file: 2
			case 11122:{cid = 11123;}// file: 2
			case 11123:{cid = 11124;}// file: 2
			case 11124:{cid = 11125;}// file: 2
			case 11125:{cid = 11126;}// file: 2
			case 11126:{cid = 11127;}// file: 2
			case 11127:{cid = 11128;}// file: 2
			case 11128:{cid = 11129;}// file: 2
			case 11129:{cid = 11130;}// file: 2
			case 11130:{cid = 11131;}// file: 2
			case 11131:{cid = 11132;}// file: 2
			case 11132:{cid = 11133;}// file: 2
			case 11133:{cid = 11134;}// file: 2
			case 11134:{cid = 11135;}// file: 2
			case 11135:{cid = 11136;}// file: 2
			case 11136:{cid = 11137;}// file: 2
			case 11137:{cid = 11138;}// file: 2
			case 11138:{cid = 11252;}// file: 2
			case 11252:{cid = 11253;}// file: 2
			case 11253:{cid = 11254;}// file: 2
			case 11254:{cid = 11255;}// file: 2
			case 11255:{cid = 11256;}// file: 2
			case 11256:{cid = 11257;}// file: 2
			case 11257:{cid = 11258;}// file: 2
			case 11258:{cid = 11259;}// file: 2
			case 11259:{cid = 11260;}// file: 2
			case 11260:{cid = 11261;}// file: 2
			case 11261:{cid = 11299;}// file: 2
			case 11299:{cid = 11302;}// file: 2
			case 11302:{cid = 11308;}// file: 2
			case 11308:{cid = 11345;}// file: 2
			case 11345:{cid = 11351;}// file: 2
			case 11351:{cid = 11365;}// file: 2
			case 11365:{cid = 11386;}// file: 2
			case 11386:{cid = 11409;}// file: 2
			case 11409:{cid = 11421;}// file: 2
			case 11421:{cid = 11462;}// file: 2
			case 11462:{cid = 12800;}// file: 2
			case 12800:{cid = 12801;}// file: 2
			case 12801:{cid = 12802;}// file: 2
			case 12802:{cid = 12803;}// file: 2
			case 12803:{cid = 12806;}// file: 2
			case 12806:{cid = 12809;}// file: 2
			case 12809:{cid = 12810;}// file: 2
			case 12810:{cid = 12811;}// file: 2
			case 12811:{cid = 12812;}// file: 2
			case 12812:{cid = 12813;}// file: 2
			case 12813:{cid = 12815;}// file: 2
			case 12815:{cid = 12816;}// file: 2
			case 12816:{cid = 12817;}// file: 2
			case 12817:{cid = 12818;}// file: 2
			case 12818:{cid = 12819;}// file: 2
			case 12819:{cid = 12820;}// file: 2
			case 12820:{cid = 12826;}// file: 2
			case 12826:{cid = 12827;}// file: 2
			case 12827:{cid = 12828;}// file: 2
			case 12828:{cid = 12829;}// file: 2
			case 12829:{cid = 12830;}// file: 2
			case 12830:{cid = 12851;}// file: 2
			case 12851:{cid = 12852;}// file: 2
			case 12852:{cid = 12856;}// file: 2
			case 12856:{cid = 12857;}// file: 2
			case 12857:{cid = 12867;}// file: 2
			case 12867:{cid = 12873;}// file: 2
			case 12873:{cid = 12874;}// file: 2
			case 12874:{cid = 12875;}// file: 2
			case 12875:{cid = 12876;}// file: 2
			case 12876:{cid = 12877;}// file: 2
			case 12877:{cid = 12878;}// file: 2
			case 12878:{cid = 12879;}// file: 2
			case 12879:{cid = 12880;}// file: 2
			case 12880:{cid = 12881;}// file: 2
			case 12881:{cid = 12882;}// file: 2
			case 12882:{cid = 12883;}// file: 2
			case 12883:{cid = 12884;}// file: 2
			case 12884:{cid = 12885;}// file: 2
			case 12885:{cid = 12886;}// file: 2
			case 12886:{cid = 12887;}// file: 2
			case 12887:{cid = 12888;}// file: 2
			case 12888:{cid = 12889;}// file: 2
			case 12889:{cid = 12890;}// file: 2
			case 12890:{cid = 12891;}// file: 2
			case 12891:{cid = 12892;}// file: 2
			case 12892:{cid = 12893;}// file: 2
			case 12893:{cid = 12894;}// file: 2
			case 12894:{cid = 12895;}// file: 2
			case 12895:{cid = 12896;}// file: 2
			case 12896:{cid = 12897;}// file: 2
			case 12897:{cid = 12898;}// file: 2
			case 12898:{cid = 12899;}// file: 2
			case 12899:{cid = 12900;}// file: 2
			case 12900:{cid = 12901;}// file: 2
			case 12901:{cid = 12902;}// file: 2
			case 12902:{cid = 12903;}// file: 2
			case 12903:{cid = 12904;}// file: 2
			case 12904:{cid = 12905;}// file: 2
			case 12905:{cid = 12906;}// file: 2
			case 12906:{cid = 12907;}// file: 2
			case 12907:{cid = 12909;}// file: 2
			case 12909:{cid = 12910;}// file: 2
			case 12910:{cid = 12965;}// file: 2
			case 12965:{cid = 12966;}// file: 2
			case 12966:{cid = 12967;}// file: 2
			case 12967:{cid = 12968;}// file: 2
			case 12968:{cid = 12970;}// file: 2
			case 12970:{cid = 12971;}// file: 2
			case 12971:{cid = 12972;}// file: 2
			case 12972:{cid = 12973;}// file: 2
			case 12973:{cid = 12974;}// file: 2
			case 12974:{cid = 12975;}// file: 2
			case 12975:{cid = 12992;}// file: 2
			case 12992:{cid = 12993;}// file: 2
			case 12993:{cid = 12994;}// file: 2
			case 12994:{cid = 12995;}// file: 2
			case 12995:{cid = 12996;}// file: 2
			case 12996:{cid = 12997;}// file: 2
			case 12997:{cid = 12998;}// file: 2
			case 12998:{cid = 12999;}// file: 2
			case 12999:{cid = 13000;}// file: 2
			case 13000:{cid = 13001;}// file: 2
			case 13001:{cid = 13020;}// file: 2
			case 13020:{cid = 13033;}// file: 2
			case 13033:{cid = 13034;}// file: 2
			case 13034:{cid = 13038;}// file: 2
			case 13038:{cid = 13058;}// file: 2
			case 13058:{cid = 13088;}// file: 2
			case 13088:{cid = 13092;}// file: 2
			case 13092:{cid = 13095;}// file: 2
			case 13095:{cid = 13119;}// file: 2
			case 13119:{cid = 13127;}// file: 2
			case 13127:{cid = 13128;}// file: 2
			case 13128:{cid = 13129;}// file: 2
			case 13129:{cid = 13138;}// file: 2
			case 13138:{cid = 13139;}// file: 2
			case 13139:{cid = 13141;}// file: 2
			case 13141:{cid = 13142;}// file: 2
			case 13142:{cid = 13168;}// file: 2
			case 13168:{cid = 13169;}// file: 2
			case 13169:{cid = 13170;}// file: 2
			case 13170:{cid = 13173;}// file: 2
			case 13173:{cid = 13321;}// file: 2
			case 13321:{cid = 13323;}// file: 2
			case 13323:{cid = 13324;}// file: 2
			case 13324:{cid = 13325;}// file: 2
			case 13325:{cid = 13332;}// file: 2
			case 13332:{cid = 13342;}// file: 2
			case 13342:{cid = 13345;}// file: 2
			case 13345:{cid = 13347;}// file: 2
			case 13347:{cid = 13348;}// file: 2
			case 13348:{cid = 13349;}// file: 2
			case 13349:{cid = 13368;}// file: 2
			case 13368:{cid = 13422;}// file: 2
			case 13422:{cid = 13470;}// file: 2
			case 13470:{cid = 13626;}// file: 2
			case 13626:{cid = 13652;}// file: 2
			case 13652:{cid = 13655;}// file: 2
			case 13655:{cid = 13664;}// file: 2
			case 13664:{cid = 13672;}// file: 2
			case 13672:{cid = 13673;}// file: 2
			case 13673:{cid = 13674;}// file: 2
			case 13674:{cid = 13676;}// file: 2
			case 13676:{cid = 13677;}// file: 2
			case 13677:{cid = 13678;}// file: 2
			case 13678:{cid = 13680;}// file: 2
			case 13680:{cid = 13682;}// file: 2
			case 13682:{cid = 13683;}// file: 2
			case 13683:{cid = 13684;}// file: 2
			case 13684:{cid = 13685;}// file: 2
			case 13685:{cid = 13688;}// file: 2
			case 13688:{cid = 13689;}// file: 2
			case 13689:{cid = 13690;}// file: 2
			case 13690:{cid = 13693;}// file: 2
			case 13693:{cid = 13703;}// file: 2
			case 13703:{cid = 13704;}// file: 2
			case 13704:{cid = 13706;}// file: 2
			case 13706:{cid = 13707;}// file: 2
			case 13707:{cid = 13708;}// file: 2
			case 13708:{cid = 13709;}// file: 2
			case 13709:{cid = 13713;}// file: 2
			case 13713:{cid = 13717;}// file: 2
			case 13717:{cid = 13718;}// file: 2
			case 13718:{cid = 13720;}// file: 2
			case 13720:{cid = 13726;}// file: 2
			case 13726:{cid = 13727;}// file: 2
			case 13727:{cid = 13730;}// file: 2
			case 13730:{cid = 13732;}// file: 2
			case 13732:{cid = 13733;}// file: 2
			case 13733:{cid = 13735;}// file: 2
			case 13735:{cid = 13736;}// file: 2
			case 13736:{cid = 13738;}// file: 2
			case 13738:{cid = 13739;}// file: 2
			case 13739:{cid = 13751;}// file: 2
			case 13751:{cid = 13752;}// file: 2
			case 13752:{cid = 13784;}// file: 2
			case 13784:{cid = 13789;}// file: 2
			case 13789:{cid = 13814;}// file: 2
			case 13814:{cid = 13845;}// file: 2
			case 13845:{cid = 13865;}// file: 2
			case 13865:{cid = 13882;}// file: 2
			case 13882:{cid = 13887;}// file: 2
			case 13887:{cid = 16037;}// file: 2
			case 16037:{cid = 16266;}// file: 2
			case 16266:{cid = 16357;}// file: 2
			case 16357:{cid = 16358;}// file: 2
			case 16358:{cid = 16384;}// file: 2
			case 16384:{cid = 16430;}// file: 2
			case 16430:{cid = 16571;}// file: 2
			case 16571:{cid = 16610;}// file: 2
			case 16610:{cid = 17002;}// file: 2
			case 17002:{cid = 17003;}// file: 2
			case 17003:{cid = 17004;}// file: 2
			case 17004:{cid = 17043;}// file: 2
			case 17043:{cid = 17062;}// file: 2
			case 17062:{cid = 17077;}// file: 2
			case 17077:{cid = 17078;}// file: 2
			case 17078:{cid = 17110;}// file: 2
			case 17110:{cid = 17111;}// file: 2
			case 17111:{cid = 17112;}// file: 2
			case 17112:{cid = 17120;}// file: 2
			case 17120:{cid = 17146;}// file: 2
			case 17146:{cid = 17148;}// file: 2
			case 17148:{cid = 17150;}// file: 2
			case 17150:{cid = 17152;}// file: 2
			case 17152:{cid = 17154;}// file: 2
			case 17154:{cid = 17156;}// file: 2
			case 17156:{cid = 17158;}// file: 2
			case 17158:{cid = 17160;}// file: 2
			case 17160:{cid = 17162;}// file: 2
			case 17162:{cid = 17164;}// file: 2
			case 17164:{cid = 17166;}// file: 2
			case 17166:{cid = 17168;}// file: 2
			case 17168:{cid = 17170;}// file: 2
			case 17170:{cid = 17172;}// file: 2
			case 17172:{cid = 17174;}// file: 2
			case 17174:{cid = 17176;}// file: 2
			case 17176:{cid = 17178;}// file: 2
			case 17178:{cid = 17180;}// file: 2
			case 17180:{cid = 17182;}// file: 2
			case 17182:{cid = 17184;}// file: 2
			case 17184:{cid = 17186;}// file: 2
			case 17186:{cid = 17188;}// file: 2
			case 17188:{cid = 17190;}// file: 2
			case 17190:{cid = 17192;}// file: 2
			case 17192:{cid = 17194;}// file: 2
			case 17194:{cid = 17196;}// file: 2
			case 17196:{cid = 17198;}// file: 2
			case 17198:{cid = 17200;}// file: 2
			case 17200:{cid = 17202;}// file: 2
			case 17202:{cid = 17204;}// file: 2
			case 17204:{cid = 17208;}// file: 2
			case 17208:{cid = 17210;}// file: 2
			case 17210:{cid = 17212;}// file: 2
			case 17212:{cid = 17214;}// file: 2
			case 17214:{cid = 17216;}// file: 2
			case 17216:{cid = 17218;}// file: 2
			case 17218:{cid = 17220;}// file: 2
			case 17220:{cid = 17222;}// file: 2
			case 17222:{cid = 17224;}// file: 2
			case 17224:{cid = 17226;}// file: 2
			case 17226:{cid = 17228;}// file: 2
			case 17228:{cid = 17230;}// file: 2
			case 17230:{cid = 17232;}// file: 2
			case 17232:{cid = 17234;}// file: 2
			case 17234:{cid = 17236;}// file: 2
			case 17236:{cid = 17238;}// file: 2
			case 17238:{cid = 17240;}// file: 2
			case 17240:{cid = 17242;}// file: 2
			case 17242:{cid = 17244;}// file: 2
			case 17244:{cid = 17246;}// file: 2
			case 17246:{cid = 17248;}// file: 2
			case 17248:{cid = 17250;}// file: 2
			case 17250:{cid = 17252;}// file: 2
			case 17252:{cid = 17254;}// file: 2
			case 17254:{cid = 17256;}// file: 2
			case 17256:{cid = 17258;}// file: 2
			case 17258:{cid = 17260;}// file: 2
			case 17260:{cid = 17262;}// file: 2
			case 17262:{cid = 17267;}// file: 2
			case 17267:{cid = 17269;}// file: 2
			case 17269:{cid = 17271;}// file: 2
			case 17271:{cid = 17273;}// file: 2
			case 17273:{cid = 17275;}// file: 2
			case 17275:{cid = 17277;}// file: 2
			case 17277:{cid = 17279;}// file: 2
			case 17279:{cid = 17281;}// file: 2
			case 17281:{cid = 17293;}// file: 2
			case 17293:{cid = 17294;}// file: 2
			case 17294:{cid = 17295;}// file: 2
			case 17295:{cid = 17300;}// file: 2
			case 17300:{cid = 17303;}// file: 2
			case 17303:{cid = 17305;}// file: 2
			case 17305:{cid = 17307;}// file: 2
			case 17307:{cid = 17308;}// file: 2
			case 17308:{cid = 17309;}// file: 2
			case 17309:{cid = 17310;}// file: 2
			case 17310:{cid = 17326;}// file: 2
			case 17326:{cid = 17327;}// file: 2
			case 17327:{cid = 17329;}// file: 2
			case 17329:{cid = 17331;}// file: 2
			case 17331:{cid = 17333;}// file: 2
			case 17333:{cid = 17334;}// file: 2
			case 17334:{cid = 17501;}// file: 2
			case 17501:{cid = 17502;}// file: 2
			case 17502:{cid = 17525;}// file: 2
			case 17525:{cid = 17550;}// file: 2
			case 17550:{cid = 17561;}// file: 2
			case 17561:{cid = 17576;}// file: 2
			case 17576:{cid = 17595;}// file: 2
			case 17595:{cid = 17596;}// file: 2
			case 17596:{cid = 17597;}// file: 2
			case 17597:{cid = 17598;}// file: 2
			case 17598:{cid = 17599;}// file: 2
			case 17599:{cid = 17600;}// file: 2
			case 17600:{cid = 17602;}// file: 2
			case 17602:{cid = 17603;}// file: 2
			case 17603:{cid = 17604;}// file: 2
			case 17604:{cid = 17605;}// file: 2
			case 17605:{cid = 17606;}// file: 2
			case 17606:{cid = 17607;}// file: 2
			case 17607:{cid = 17608;}// file: 2
			case 17608:{cid = 17609;}// file: 2
			case 17609:{cid = 17610;}// file: 2
			case 17610:{cid = 17611;}// file: 2
			case 17611:{cid = 17612;}// file: 2
			case 17612:{cid = 17613;}// file: 2
			case 17613:{cid = 17621;}// file: 2
			case 17621:{cid = 17622;}// file: 2
			case 17622:{cid = 17623;}// file: 2
			case 17623:{cid = 17624;}// file: 2
			case 17624:{cid = 17625;}// file: 2
			case 17625:{cid = 17626;}// file: 2
			case 17626:{cid = 17627;}// file: 2
			case 17627:{cid = 17628;}// file: 2
			case 17628:{cid = 17629;}// file: 2
			case 17629:{cid = 17630;}// file: 2
			case 17630:{cid = 17631;}// file: 2
			case 17631:{cid = 17632;}// file: 2
			case 17632:{cid = 17634;}// file: 2
			case 17634:{cid = 17635;}// file: 2
			case 17635:{cid = 17637;}// file: 2
			case 17637:{cid = 17638;}// file: 2
			case 17638:{cid = 17639;}// file: 2
			case 17639:{cid = 17640;}// file: 2
			case 17640:{cid = 17641;}// file: 2
			case 17641:{cid = 17642;}// file: 2
			case 17642:{cid = 17643;}// file: 2
			case 17643:{cid = 17644;}// file: 2
			case 17644:{cid = 17646;}// file: 2
			case 17646:{cid = 17647;}// file: 2
			case 17647:{cid = 17648;}// file: 2
			case 17648:{cid = 17649;}// file: 2
			case 17649:{cid = 17650;}// file: 2
			case 17650:{cid = 17651;}// file: 2
			case 17651:{cid = 17652;}// file: 2
			case 17652:{cid = 17653;}// file: 2
			case 17653:{cid = 17654;}// file: 2
			case 17654:{cid = 17655;}// file: 2
			case 17655:{cid = 17656;}// file: 2
			case 17656:{cid = 17657;}// file: 2
			case 17657:{cid = 17658;}// file: 2
			case 17658:{cid = 17659;}// file: 2
			case 17659:{cid = 17660;}// file: 2
			case 17660:{cid = 17661;}// file: 2
			case 17661:{cid = 17662;}// file: 2
			case 17662:{cid = 17663;}// file: 2
			case 17663:{cid = 17666;}// file: 2
			case 17666:{cid = 17667;}// file: 2
			case 17667:{cid = 17668;}// file: 2
			case 17668:{cid = 17669;}// file: 2
			case 17669:{cid = 17670;}// file: 2
			case 17670:{cid = 17671;}// file: 2
			case 17671:{cid = 17672;}// file: 2
			case 17672:{cid = 17673;}// file: 2
			case 17673:{cid = 17674;}// file: 2
			case 17674:{cid = 17675;}// file: 2
			case 17675:{cid = 17676;}// file: 2
			case 17676:{cid = 17680;}// file: 2
			case 17680:{cid = 17681;}// file: 2
			case 17681:{cid = 17682;}// file: 2
			case 17682:{cid = 17683;}// file: 2
			case 17683:{cid = 17684;}// file: 2
			case 17684:{cid = 17686;}// file: 2
			case 17686:{cid = 17687;}// file: 2
			case 17687:{cid = 17692;}// file: 2
			case 17692:{cid = 17693;}// file: 2
			case 17693:{cid = 17695;}// file: 2
			case 17695:{cid = 17829;}// file: 2
			case 17829:{cid = 17849;}// file: 2
			case 17849:{cid = 17867;}// file: 2
			case 17867:{cid = 17920;}// file: 2
			case 17920:{cid = 17921;}// file: 2
			case 17921:{cid = 17927;}// file: 2
			case 17927:{cid = 17936;}// file: 2
			case 17936:{cid = 17968;}// file: 2
			case 17968:{cid = 18229;}// file: 2
			case 18229:{cid = 18256;}// file: 2
			case 18256:{cid = 18369;}// file: 2
			case 18369:{cid = 18370;}// file: 2
			case 18370:{cid = 18371;}// file: 2
			case 18371:{cid = 18372;}// file: 2
			case 18372:{cid = 18373;}// file: 2
			case 18373:{cid = 18374;}// file: 2
			case 18374:{cid = 18375;}// file: 2
			case 18375:{cid = 18376;}// file: 2
			case 18376:{cid = 18377;}// file: 2
			case 18377:{cid = 18378;}// file: 2
			case 18378:{cid = 18379;}// file: 2
			case 18379:{cid = 18380;}// file: 2
			case 18380:{cid = 18381;}// file: 2
			case 18381:{cid = 18382;}// file: 2
			case 18382:{cid = 18383;}// file: 2
			case 18383:{cid = 18384;}// file: 2
			case 18384:{cid = 18385;}// file: 2
			case 18385:{cid = 18386;}// file: 2
			case 18386:{cid = 18387;}// file: 2
			case 18387:{cid = 18388;}// file: 2
			case 18388:{cid = 18389;}// file: 2
			case 18389:{cid = 18390;}// file: 2
			case 18390:{cid = 18391;}// file: 2
			case 18391:{cid = 18392;}// file: 2
			case 18392:{cid = 18393;}// file: 2
			case 18393:{cid = 18394;}// file: 2
			case 18394:{cid = 18449;}// file: 2
			case 18449:{cid = 18450;}// file: 2
			case 18450:{cid = 18561;}// file: 2
			case 18561:{cid = 1675;}// file: 2
			case 1675:{cid = 1677;}// file: 5
			case 1677:{cid = 3167;}// file: 5
			case 3167:{cid = 3168;}// file: 5
			case 3168:{cid = 3169;}// file: 5
			case 3169:{cid = 3170;}// file: 5
			case 3170:{cid = 3171;}// file: 5
			case 3171:{cid = 3172;}// file: 5
			case 3172:{cid = 3173;}// file: 5
			case 3173:{cid = 3174;}// file: 5
			case 3174:{cid = 3175;}// file: 5
			case 3175:{cid = 3178;}// file: 5
			case 3178:{cid = 3241;}// file: 5
			case 3241:{cid = 3242;}// file: 5
			case 3242:{cid = 3246;}// file: 5
			case 3246:{cid = 3250;}// file: 5
			case 3250:{cid = 3253;}// file: 5
			case 3253:{cid = 3283;}// file: 5
			case 3283:{cid = 3284;}// file: 5
			case 3284:{cid = 3285;}// file: 5
			case 3285:{cid = 3303;}// file: 5
			case 3303:{cid = 3304;}// file: 5
			case 3304:{cid = 3305;}// file: 5
			case 3305:{cid = 3306;}// file: 5
			case 3306:{cid = 3307;}// file: 5
			case 3307:{cid = 3308;}// file: 5
			case 3308:{cid = 3309;}// file: 5
			case 3309:{cid = 3310;}// file: 5
			case 3310:{cid = 3311;}// file: 5
			case 3311:{cid = 3312;}// file: 5
			case 3312:{cid = 3313;}// file: 5
			case 3313:{cid = 3314;}// file: 5
			case 3314:{cid = 3315;}// file: 5
			case 3315:{cid = 3316;}// file: 5
			case 3316:{cid = 3317;}// file: 5
			case 3317:{cid = 3351;}// file: 5
			case 3351:{cid = 3353;}// file: 5
			case 3353:{cid = 3355;}// file: 5
			case 3355:{cid = 3356;}// file: 5
			case 3356:{cid = 3362;}// file: 5
			case 3362:{cid = 3414;}// file: 5
			case 3414:{cid = 3415;}// file: 5
			case 3415:{cid = 3417;}// file: 5
			case 3417:{cid = 3418;}// file: 5
			case 3418:{cid = 3442;}// file: 5
			case 3442:{cid = 3443;}// file: 5
			case 3443:{cid = 3444;}// file: 5
			case 3444:{cid = 3445;}// file: 5
			case 3445:{cid = 3446;}// file: 5
			case 3446:{cid = 3449;}// file: 5
			case 3449:{cid = 3454;}// file: 5
			case 3454:{cid = 3455;}// file: 5
			case 3455:{cid = 3456;}// file: 5
			case 3456:{cid = 3457;}// file: 5
			case 3457:{cid = 3464;}// file: 5
			case 3464:{cid = 3466;}// file: 5
			case 3466:{cid = 3483;}// file: 5
			case 3483:{cid = 3484;}// file: 5
			case 3484:{cid = 3485;}// file: 5
			case 3485:{cid = 3486;}// file: 5
			case 3486:{cid = 3487;}// file: 5
			case 3487:{cid = 3488;}// file: 5
			case 3488:{cid = 3501;}// file: 5
			case 3501:{cid = 3555;}// file: 5
			case 3555:{cid = 3556;}// file: 5
			case 3556:{cid = 3557;}// file: 5
			case 3557:{cid = 3558;}// file: 5
			case 3558:{cid = 3580;}// file: 5
			case 3580:{cid = 3582;}// file: 5
			case 3582:{cid = 3583;}// file: 5
			case 3583:{cid = 3584;}// file: 5
			case 3584:{cid = 3587;}// file: 5
			case 3587:{cid = 3588;}// file: 5
			case 3588:{cid = 3589;}// file: 5
			case 3589:{cid = 3590;}// file: 5
			case 3590:{cid = 3595;}// file: 5
			case 3595:{cid = 3596;}// file: 5
			case 3596:{cid = 3597;}// file: 5
			case 3597:{cid = 3598;}// file: 5
			case 3598:{cid = 3599;}// file: 5
			case 3599:{cid = 3600;}// file: 5
			case 3600:{cid = 3601;}// file: 5
			case 3601:{cid = 3602;}// file: 5
			case 3602:{cid = 3603;}// file: 5
			case 3603:{cid = 3604;}// file: 5
			case 3604:{cid = 3605;}// file: 5
			case 3605:{cid = 3606;}// file: 5
			case 3606:{cid = 3607;}// file: 5
			case 3607:{cid = 3608;}// file: 5
			case 3608:{cid = 3609;}// file: 5
			case 3609:{cid = 3612;}// file: 5
			case 3612:{cid = 3613;}// file: 5
			case 3613:{cid = 3614;}// file: 5
			case 3614:{cid = 3616;}// file: 5
			case 3616:{cid = 3617;}// file: 5
			case 3617:{cid = 3618;}// file: 5
			case 3618:{cid = 3619;}// file: 5
			case 3619:{cid = 3622;}// file: 5
			case 3622:{cid = 3623;}// file: 5
			case 3623:{cid = 3624;}// file: 5
			case 3624:{cid = 3626;}// file: 5
			case 3626:{cid = 3628;}// file: 5
			case 3628:{cid = 3634;}// file: 5
			case 3634:{cid = 3635;}// file: 5
			case 3635:{cid = 3639;}// file: 5
			case 3639:{cid = 3640;}// file: 5
			case 3640:{cid = 3641;}// file: 5
			case 3641:{cid = 3642;}// file: 5
			case 3642:{cid = 3644;}// file: 5
			case 3644:{cid = 3646;}// file: 5
			case 3646:{cid = 3648;}// file: 5
			case 3648:{cid = 3649;}// file: 5
			case 3649:{cid = 3651;}// file: 5
			case 3651:{cid = 3653;}// file: 5
			case 3653:{cid = 3655;}// file: 5
			case 3655:{cid = 3661;}// file: 5
			case 3661:{cid = 3676;}// file: 5
			case 3676:{cid = 3677;}// file: 5
			case 3677:{cid = 3678;}// file: 5
			case 3678:{cid = 3684;}// file: 5
			case 3684:{cid = 3697;}// file: 5
			case 3697:{cid = 3698;}// file: 5
			case 3698:{cid = 3700;}// file: 5
			case 3700:{cid = 3702;}// file: 5
			case 3702:{cid = 3704;}// file: 5
			case 3704:{cid = 3711;}// file: 5
			case 3711:{cid = 3713;}// file: 5
			case 3713:{cid = 3741;}// file: 5
			case 3741:{cid = 3759;}// file: 5
			case 3759:{cid = 3762;}// file: 5
			case 3762:{cid = 3764;}// file: 5
			case 3764:{cid = 3765;}// file: 5
			case 3765:{cid = 3783;}// file: 5
			case 3783:{cid = 3820;}// file: 5
			case 3820:{cid = 3821;}// file: 5
			case 3821:{cid = 3822;}// file: 5
			case 3822:{cid = 3823;}// file: 5
			case 3823:{cid = 3824;}// file: 5
			case 3824:{cid = 3825;}// file: 5
			case 3825:{cid = 3826;}// file: 5
			case 3826:{cid = 3827;}// file: 5
			case 3827:{cid = 3828;}// file: 5
			case 3828:{cid = 3829;}// file: 5
			case 3829:{cid = 3830;}// file: 5
			case 3830:{cid = 3842;}// file: 5
			case 3842:{cid = 3843;}// file: 5
			case 3843:{cid = 3844;}// file: 5
			case 3844:{cid = 3845;}// file: 5
			case 3845:{cid = 4178;}// file: 5
			case 4178:{cid = 4861;}// file: 5
			case 4861:{cid = 4886;}// file: 5
			case 4886:{cid = 5060;}// file: 5
			case 5060:{cid = 5151;}// file: 5
			case 5151:{cid = 5341;}// file: 5
			case 5341:{cid = 5416;}// file: 5
			case 5416:{cid = 5421;}// file: 5
			case 5421:{cid = 5423;}// file: 5
			case 5423:{cid = 5425;}// file: 5
			case 5425:{cid = 5444;}// file: 5
			case 5444:{cid = 5445;}// file: 5
			case 5445:{cid = 5446;}// file: 5
			case 5446:{cid = 5447;}// file: 5
			case 5447:{cid = 5448;}// file: 5
			case 5448:{cid = 5450;}// file: 5
			case 5450:{cid = 5451;}// file: 5
			case 5451:{cid = 5452;}// file: 5
			case 5452:{cid = 5453;}// file: 5
			case 5453:{cid = 5461;}// file: 5
			case 5461:{cid = 5462;}// file: 5
			case 5462:{cid = 5475;}// file: 5
			case 5475:{cid = 5476;}// file: 5
			case 5476:{cid = 5520;}// file: 5
			case 5520:{cid = 5626;}// file: 5
			case 5626:{cid = 5642;}// file: 5
			case 5642:{cid = 5643;}// file: 5
			case 5643:{cid = 5655;}// file: 5
			case 5655:{cid = 5656;}// file: 5
			case 5656:{cid = 5722;}// file: 5
			case 5722:{cid = 5723;}// file: 5
			case 5723:{cid = 5775;}// file: 5
			case 5775:{cid = 5874;}// file: 5
			case 5874:{cid = 5891;}// file: 5
			case 5891:{cid = 5892;}// file: 5
			case 5892:{cid = 5986;}// file: 5
			case 5986:{cid = 6038;}// file: 5
			case 6038:{cid = 6039;}// file: 5
			case 6039:{cid = 6041;}// file: 5
			case 6041:{cid = 6042;}// file: 5
			case 6042:{cid = 6047;}// file: 5
			case 6047:{cid = 6057;}// file: 5
			case 6057:{cid = 6058;}// file: 5
			case 6058:{cid = 6132;}// file: 5
			case 6132:{cid = 6133;}// file: 5
			case 6133:{cid = 6134;}// file: 5
			case 6134:{cid = 6135;}// file: 5
			case 6135:{cid = 6136;}// file: 5
			case 6136:{cid = 6137;}// file: 5
			case 6137:{cid = 6138;}// file: 5
			case 6138:{cid = 6284;}// file: 5
			case 6284:{cid = 6285;}// file: 5
			case 6285:{cid = 6286;}// file: 5
			case 6286:{cid = 6294;}// file: 5
			case 6294:{cid = 6436;}// file: 5
			case 6436:{cid = 6522;}// file: 5
			case 6522:{cid = 6868;}// file: 5
			case 6868:{cid = 6920;}// file: 5
			case 6920:{cid = 6921;}// file: 5
			case 6921:{cid = 6922;}// file: 5
			case 6922:{cid = 6923;}// file: 5
			case 6923:{cid = 6926;}// file: 5
			case 6926:{cid = 7200;}// file: 5
			case 7200:{cid = 7287;}// file: 5
			case 7287:{cid = 7489;}// file: 5
			case 7489:{cid = 7491;}// file: 5
			case 7491:{cid = 7533;}// file: 5
			case 7533:{cid = 7534;}// file: 5
			case 7534:{cid = 7535;}// file: 5
			case 7535:{cid = 7681;}// file: 5
			case 7681:{cid = 7885;}// file: 5
			case 7885:{cid = 7929;}// file: 5
			case 7929:{cid = 7932;}// file: 5
			case 7932:{cid = 7940;}// file: 5
			case 7940:{cid = 8425;}// file: 5
			case 8425:{cid = 8427;}// file: 5
			case 8427:{cid = 8428;}// file: 5
			case 8428:{cid = 8433;}// file: 5
			case 8433:{cid = 8437;}// file: 5
			case 8437:{cid = 8513;}// file: 5
			case 8513:{cid = 9098;}// file: 5
			case 9098:{cid = 9220;}// file: 5
			case 9220:{cid = 9221;}// file: 5
			case 9221:{cid = 9227;}// file: 5
			case 9227:{cid = 9228;}// file: 5
			case 9228:{cid = 9238;}// file: 5
			case 9238:{cid = 9258;}// file: 5
			case 9258:{cid = 9259;}// file: 5
			case 9259:{cid = 9270;}// file: 5
			case 9270:{cid = 9271;}// file: 5
			case 9271:{cid = 9272;}// file: 5
			case 9272:{cid = 9273;}// file: 5
			case 9273:{cid = 9274;}// file: 5
			case 9274:{cid = 9275;}// file: 5
			case 9275:{cid = 9319;}// file: 5
			case 9319:{cid = 9320;}// file: 5
			case 9320:{cid = 9322;}// file: 5
			case 9322:{cid = 9323;}// file: 5
			case 9323:{cid = 9324;}// file: 5
			case 9324:{cid = 9325;}// file: 5
			case 9325:{cid = 9326;}// file: 5
			case 9326:{cid = 9327;}// file: 5
			case 9327:{cid = 9328;}// file: 5
			case 9328:{cid = 9341;}// file: 5
			case 9341:{cid = 9495;}// file: 5
			case 9495:{cid = 9496;}// file: 5
			case 9496:{cid = 9497;}// file: 5
			case 9497:{cid = 9498;}// file: 5
			case 9498:{cid = 9499;}// file: 5
			case 9499:{cid = 9500;}// file: 5
			case 9500:{cid = 9501;}// file: 5
			case 9501:{cid = 9502;}// file: 5
			case 9502:{cid = 9503;}// file: 5
			case 9503:{cid = 9504;}// file: 5
			case 9504:{cid = 9506;}// file: 5
			case 9506:{cid = 9507;}// file: 5
			case 9507:{cid = 9509;}// file: 5
			case 9509:{cid = 9510;}// file: 5
			case 9510:{cid = 9511;}// file: 5
			case 9511:{cid = 9512;}// file: 5
			case 9512:{cid = 9513;}// file: 5
			case 9513:{cid = 9515;}// file: 5
			case 9515:{cid = 9516;}// file: 5
			case 9516:{cid = 9517;}// file: 5
			case 9517:{cid = 9518;}// file: 5
			case 9518:{cid = 9520;}// file: 5
			case 9520:{cid = 9521;}// file: 5
			case 9521:{cid = 9522;}// file: 5
			case 9522:{cid = 9523;}// file: 5
			case 9523:{cid = 9524;}// file: 5
			case 9524:{cid = 9529;}// file: 5
			case 9529:{cid = 9547;}// file: 5
			case 9547:{cid = 9549;}// file: 5
			case 9549:{cid = 9550;}// file: 5
			case 9550:{cid = 9572;}// file: 5
			case 9572:{cid = 9573;}// file: 5
			case 9573:{cid = 9576;}// file: 5
			case 9576:{cid = 9577;}// file: 5
			case 9577:{cid = 9578;}// file: 5
			case 9578:{cid = 9579;}// file: 5
			case 9579:{cid = 9580;}// file: 5
			case 9580:{cid = 9581;}// file: 5
			case 9581:{cid = 9592;}// file: 5
			case 9592:{cid = 9598;}// file: 5
			case 9598:{cid = 9599;}// file: 5
			case 9599:{cid = 9737;}// file: 5
			case 9737:{cid = 9738;}// file: 5
			case 9738:{cid = 9739;}// file: 5
			case 9739:{cid = 9740;}// file: 5
			case 9740:{cid = 9741;}// file: 5
			case 9741:{cid = 9742;}// file: 5
			case 9742:{cid = 9748;}// file: 5
			case 9748:{cid = 9749;}// file: 5
			case 9749:{cid = 9750;}// file: 5
			case 9750:{cid = 9751;}// file: 5
			case 9751:{cid = 9752;}// file: 5
			case 9752:{cid = 9753;}// file: 5
			case 9753:{cid = 9754;}// file: 5
			case 9754:{cid = 9762;}// file: 5
			case 9762:{cid = 9763;}// file: 5
			case 9763:{cid = 9764;}// file: 5
			case 9764:{cid = 9765;}// file: 5
			case 9765:{cid = 9894;}// file: 5
			case 9894:{cid = 9895;}// file: 5
			case 9895:{cid = 9903;}// file: 5
			case 9903:{cid = 9904;}// file: 5
			case 9904:{cid = 9909;}// file: 5
			case 9909:{cid = 9916;}// file: 5
			case 9916:{cid = 9920;}// file: 5
			case 9920:{cid = 9927;}// file: 5
			case 9927:{cid = 9947;}// file: 5
			case 9947:{cid = 9948;}// file: 5
			case 9948:{cid = 9952;}// file: 5
			case 9952:{cid = 10013;}// file: 5
			case 10013:{cid = 10014;}// file: 5
			case 10014:{cid = 10015;}// file: 5
			case 10015:{cid = 10016;}// file: 5
			case 10016:{cid = 10017;}// file: 5
			case 10017:{cid = 10019;}// file: 5
			case 10019:{cid = 10020;}// file: 5
			case 10020:{cid = 10021;}// file: 5
			case 10021:{cid = 10022;}// file: 5
			case 10022:{cid = 10043;}// file: 5
			case 10043:{cid = 10048;}// file: 5
			case 10048:{cid = 10050;}// file: 5
			case 10050:{cid = 10053;}// file: 5
			case 10053:{cid = 10055;}// file: 5
			case 10055:{cid = 10080;}// file: 5
			case 10080:{cid = 10084;}// file: 5
			case 10084:{cid = 10086;}// file: 5
			case 10086:{cid = 10101;}// file: 5
			case 10101:{cid = 10187;}// file: 5
			case 10187:{cid = 10188;}// file: 5
			case 10188:{cid = 10189;}// file: 5
			case 10189:{cid = 10278;}// file: 5
			case 10278:{cid = 10287;}// file: 5
			case 10287:{cid = 10289;}// file: 5
			case 10289:{cid = 10306;}// file: 5
			case 10306:{cid = 10427;}// file: 5
			case 10427:{cid = 10634;}// file: 5
			case 10634:{cid = 10988;}// file: 5
			case 10988:{cid = 10989;}// file: 5
			case 10989:{cid = 10990;}// file: 5
			case 10990:{cid = 10991;}// file: 5
			case 10991:{cid = 10992;}// file: 5
			case 10992:{cid = 10993;}// file: 5
			case 10993:{cid = 10995;}// file: 5
			case 10995:{cid = 10998;}// file: 5
			case 10998:{cid = 11001;}// file: 5
			case 11001:{cid = 11002;}// file: 5
			case 11002:{cid = 11004;}// file: 5
			case 11004:{cid = 11433;}// file: 5
			case 11433:{cid = 11490;}// file: 5
			case 11490:{cid = 11491;}// file: 5
			case 11491:{cid = 11501;}// file: 5
			case 11501:{cid = 11502;}// file: 5
			case 11502:{cid = 11503;}// file: 5
			case 11503:{cid = 12937;}// file: 5
			case 12937:{cid = 12938;}// file: 5
			case 12938:{cid = 12939;}// file: 5
			case 12939:{cid = 12940;}// file: 5
			case 12940:{cid = 12991;}// file: 5
			case 12991:{cid = 13681;}// file: 5
			case 13681:{cid = 13687;}// file: 5
			case 13687:{cid = 13694;}// file: 5
			case 13694:{cid = 13695;}// file: 5
			case 13695:{cid = 13696;}// file: 5
			case 13696:{cid = 13697;}// file: 5
			case 13697:{cid = 13701;}// file: 5
			case 13701:{cid = 13721;}// file: 5
			case 13721:{cid = 13724;}// file: 5
			case 13724:{cid = 13729;}// file: 5
			case 13729:{cid = 13746;}// file: 5
			case 13746:{cid = 13747;}// file: 5
			case 13747:{cid = 13753;}// file: 5
			case 13753:{cid = 13754;}// file: 5
			case 13754:{cid = 13755;}// file: 5
			case 13755:{cid = 13816;}// file: 5
			case 13816:{cid = 14385;}// file: 5
			case 14385:{cid = 14388;}// file: 5
			case 14388:{cid = 14389;}// file: 5
			case 14389:{cid = 14390;}// file: 5
			case 14390:{cid = 14417;}// file: 5
			case 14417:{cid = 14418;}// file: 5
			case 14418:{cid = 14419;}// file: 5
			case 14419:{cid = 14420;}// file: 5
			case 14420:{cid = 14421;}// file: 5
			case 14421:{cid = 14422;}// file: 5
			case 14422:{cid = 14423;}// file: 5
			case 14423:{cid = 14424;}// file: 5
			case 14424:{cid = 14425;}// file: 5
			case 14425:{cid = 14426;}// file: 5
			case 14426:{cid = 14427;}// file: 5
			case 14427:{cid = 14428;}// file: 5
			case 14428:{cid = 14429;}// file: 5
			case 14429:{cid = 14430;}// file: 5
			case 14430:{cid = 14431;}// file: 5
			case 14431:{cid = 14471;}// file: 5
			case 14471:{cid = 14474;}// file: 5
			case 14474:{cid = 14475;}// file: 5
			case 14475:{cid = 14476;}// file: 5
			case 14476:{cid = 14484;}// file: 5
			case 14484:{cid = 14485;}// file: 5
			case 14485:{cid = 14492;}// file: 5
			case 14492:{cid = 14495;}// file: 5
			case 14495:{cid = 14500;}// file: 5
			case 14500:{cid = 14512;}// file: 5
			case 14512:{cid = 14525;}// file: 5
			case 14525:{cid = 14526;}// file: 5
			case 14526:{cid = 14534;}// file: 5
			case 14534:{cid = 14639;}// file: 5
			case 14639:{cid = 14700;}// file: 5
			case 14700:{cid = 14701;}// file: 5
			case 14701:{cid = 14702;}// file: 5
			case 14702:{cid = 14703;}// file: 5
			case 14703:{cid = 14706;}// file: 5
			case 14706:{cid = 14707;}// file: 5
			case 14707:{cid = 14708;}// file: 5
			case 14708:{cid = 14709;}// file: 5
			case 14709:{cid = 14710;}// file: 5
			case 14710:{cid = 14711;}// file: 5
			case 14711:{cid = 14712;}// file: 5
			case 14712:{cid = 14713;}// file: 5
			case 14713:{cid = 14714;}// file: 5
			case 14714:{cid = 14717;}// file: 5
			case 14717:{cid = 14718;}// file: 5
			case 14718:{cid = 14735;}// file: 5
			case 14735:{cid = 14736;}// file: 5
			case 14736:{cid = 14746;}// file: 5
			case 14746:{cid = 14748;}// file: 5
			case 14748:{cid = 14750;}// file: 5
			case 14750:{cid = 14754;}// file: 5
			case 14754:{cid = 14755;}// file: 5
			case 14755:{cid = 14756;}// file: 5
			case 14756:{cid = 14758;}// file: 5
			case 14758:{cid = 14759;}// file: 5
			case 14759:{cid = 14760;}// file: 5
			case 14760:{cid = 14771;}// file: 5
			case 14771:{cid = 14801;}// file: 5
			case 14801:{cid = 14803;}// file: 5
			case 14803:{cid = 14859;}// file: 5
			case 14859:{cid = 14865;}// file: 5
			case 14865:{cid = 14889;}// file: 5
			case 14889:{cid = 15031;}// file: 5
			case 15031:{cid = 15041;}// file: 5
			case 15041:{cid = 15042;}// file: 5
			case 15042:{cid = 15046;}// file: 5
			case 15046:{cid = 15048;}// file: 5
			case 15048:{cid = 15054;}// file: 5
			case 15054:{cid = 15055;}// file: 5
			case 15055:{cid = 15058;}// file: 5
			case 15058:{cid = 15059;}// file: 5
			case 15059:{cid = 16105;}// file: 5
			case 16105:{cid = 16280;}// file: 5
			case 16280:{cid = 16285;}// file: 5
			case 16285:{cid = 16689;}// file: 5
			case 16689:{cid = 17005;}// file: 5
			case 17005:{cid = 17008;}// file: 5
			case 17008:{cid = 17041;}// file: 5
			case 17041:{cid = 17044;}// file: 5
			case 17044:{cid = 17045;}// file: 5
			case 17045:{cid = 17067;}// file: 5
			case 17067:{cid = 17335;}// file: 5
			case 17335:{cid = 17547;}// file: 5
			case 17547:{cid = 17549;}// file: 5
			case 17549:{cid = 17551;}// file: 5
			case 17551:{cid = 17552;}// file: 5
			case 17552:{cid = 17553;}// file: 5
			case 17553:{cid = 17554;}// file: 5
			case 17554:{cid = 17555;}// file: 5
			case 17555:{cid = 17560;}// file: 5
			case 17560:{cid = 17562;}// file: 5
			case 17562:{cid = 17573;}// file: 5
			case 17573:{cid = 17575;}// file: 5
			case 17575:{cid = 17679;}// file: 5
			case 17679:{cid = 17690;}// file: 5
			case 17690:{cid = 17697;}// file: 5
			case 17697:{cid = 17698;}// file: 5
			case 17698:{cid = 17699;}// file: 5
			case 17699:{cid = 17700;}// file: 5
			case 17804:{cid = 17807;}// file: 5
			case 17807:{cid = 17809;}// file: 5
			case 17809:{cid = 17859;}// file: 5
			case 17859:{cid = 17888;}// file: 5
			case 17888:{cid = 17893;}// file: 5
			case 17893:{cid = 17894;}// file: 5
			case 17894:{cid = 17901;}// file: 5
			case 17901:{cid = 17922;}// file: 5
			case 17922:{cid = 17926;}// file: 5
			case 17926:{cid = 17928;}// file: 5
			case 17928:{cid = 17934;}// file: 5
			case 17934:{cid = 17944;}// file: 5
			case 17944:{cid = 18230;}// file: 5
			case 18230:{cid = 18258;}// file: 5
			case 18258:{cid = 18259;}// file: 5
			case 18259:{cid = 18267;}// file: 5
			case 18267:{cid = 3452;}// file: 5
			case 3452:{cid = 3453;}// file: 9
			case 3453:{cid = 3819;}// file: 9
			case 3819:{cid = 5390;}// file: 9
			case 5390:{cid = 5400;}// file: 9
			case 5400:{cid = 6066;}// file: 9
			case 6066:{cid = 7416;}// file: 9
			case 7416:{cid = 7417;}// file: 9
			case 7417:{cid = 7420;}// file: 9
			case 7420:{cid = 7421;}// file: 9
			case 7421:{cid = 7422;}// file: 9
			case 7422:{cid = 7600;}// file: 9
			case 7600:{cid = 7601;}// file: 9
			case 7601:{cid = 7602;}// file: 9
			case 7602:{cid = 7603;}// file: 9
			case 7603:{cid = 7604;}// file: 9
			case 7604:{cid = 7617;}// file: 9
			case 7617:{cid = 7983;}// file: 9
			case 7983:{cid = 8201;}// file: 9
			case 8201:{cid = 8333;}// file: 9
			case 8333:{cid = 8417;}// file: 9
			case 8417:{cid = 10385;}// file: 9
			case 10385:{cid = 10405;}// file: 9
			case 10405:{cid = 10406;}// file: 9
			case 10406:{cid = 10407;}// file: 9
			case 10407:{cid = 10408;}// file: 9
			case 10408:{cid = 10409;}// file: 9
			case 10409:{cid = 10410;}// file: 9
			case 10410:{cid = 10561;}// file: 9
			case 10561:{cid = 10954;}// file: 9
			case 10954:{cid = 10955;}// file: 9
			case 10955:{cid = 13592;}// file: 9
			case 13592:{cid = 13595;}// file: 9
			case 13595:{cid = 13598;}// file: 9
			case 13598:{cid = 13599;}// file: 9
			case 13599:{cid = 13602;}// file: 9
			case 13602:{cid = 13603;}// file: 9
			case 13603:{cid = 13606;}// file: 9
			case 13606:{cid = 13607;}// file: 9
			case 13607:{cid = 13608;}// file: 9
			case 13608:{cid = 13609;}// file: 9
			case 13609:{cid = 13610;}// file: 9
			case 13610:{cid = 13611;}// file: 9
			case 13611:{cid = 13612;}// file: 9
			case 13612:{cid = 13613;}// file: 9
			case 13613:{cid = 13614;}// file: 9
			case 13614:{cid = 13615;}// file: 9
			case 13615:{cid = 13616;}// file: 9
			case 13616:{cid = 13617;}// file: 9
			case 13617:{cid = 13618;}// file: 9
			case 13618:{cid = 13619;}// file: 9
			case 13619:{cid = 13620;}// file: 9
			case 13620:{cid = 13621;}// file: 9
			case 13621:{cid = 13624;}// file: 9
			case 13624:{cid = 13625;}// file: 9
			case 13625:{cid = 13627;}// file: 9
			case 13627:{cid = 13631;}// file: 9
			case 13631:{cid = 13628;}// file: 9
			case 13628:{cid = 13632;}// file: 9
			case 13632:{cid = 13629;}// file: 9
			case 13629:{cid = 13633;}// file: 9
			case 13633:{cid = 13630;}// file: 9
			case 13630:{cid = 13634;}// file: 9
			case 13634:{cid = 13642;}// file: 9
			case 13642:{cid = 13650;}// file: 9
			case 13650:{cid = 13651;}// file: 9
			case 13651:{cid = 13657;}// file: 9
			case 13657:{cid = 13661;}// file: 9
			case 13661:{cid = 13662;}// file: 9
			case 13662:{cid = 13659;}// file: 9
			case 13659:{cid = 13660;}// file: 9
			case 13660:{cid = 13666;}// file: 9
			case 13666:{cid = 13801;}// file: 9
			case 13801:{cid = 14449;}// file: 9
			case 14449:{cid = 14486;}// file: 9
			case 14486:{cid = 14488;}// file: 9
			case 14488:{cid = 14778;}// file: 9
			case 14778:{cid = 14779;}// file: 9
			case 14779:{cid = 14780;}// file: 9
			case 14780:{cid = 14781;}// file: 9
			case 14781:{cid = 14782;}// file: 9
			case 14782:{cid = 14786;}// file: 9
			case 14786:{cid = 14787;}// file: 9
			case 14787:{cid = 14788;}// file: 9
			case 14788:{cid = 14789;}// file: 9
			case 14789:{cid = 14790;}// file: 9
			case 14790:{cid = 14791;}// file: 9
			case 14791:{cid = 14792;}// file: 9
			case 14792:{cid = 14794;}// file: 9
			case 14794:{cid = 14825;}// file: 9
			case 14825:{cid = 14827;}// file: 9
			case 14827:{cid = 17511;}// file: 9
			case 17511:{cid = 17513;}// file: 9
			case 17513:{cid = 17515;}// file: 9
			case 17515:{cid = 17563;}// file: 9
			case 17563:{cid = 17582;}// file: 9
			case 17582:{cid = 17841;}// file: 9
			case 17841:{cid = 925;}// file: 9
			case 925:{cid = 930;}// file: 12
			case 930:{cid = 931;}// file: 12
			case 931:{cid = 944;}// file: 12
			case 944:{cid = 964;}// file: 12
			case 964:{cid = 1271;}// file: 12
			case 1271:{cid = 1348;}// file: 12
			case 1348:{cid = 1362;}// file: 12
			case 1362:{cid = 1431;}// file: 12
			case 1431:{cid = 1685;}// file: 12
			case 1685:{cid = 2038;}// file: 12
			case 2038:{cid = 2039;}// file: 12
			case 2039:{cid = 2040;}// file: 12
			case 2040:{cid = 2041;}// file: 12
			case 2041:{cid = 2042;}// file: 12
			case 2042:{cid = 2043;}// file: 12
			case 2043:{cid = 2358;}// file: 12
			case 2358:{cid = 2359;}// file: 12
			case 2359:{cid = 2464;}// file: 12
			case 2464:{cid = 2465;}// file: 12
			case 2465:{cid = 2466;}// file: 12
			case 2466:{cid = 2468;}// file: 12
			case 2468:{cid = 2476;}// file: 12
			case 2476:{cid = 2477;}// file: 12
			case 2477:{cid = 2478;}// file: 12
			case 2478:{cid = 2479;}// file: 12
			case 2479:{cid = 2480;}// file: 12
			case 2480:{cid = 2481;}// file: 12
			case 2481:{cid = 2483;}// file: 12
			case 2483:{cid = 2567;}// file: 12
			case 2567:{cid = 2654;}// file: 12
			case 2654:{cid = 2669;}// file: 12
			case 2669:{cid = 2678;}// file: 12
			case 2678:{cid = 2679;}// file: 12
			case 2679:{cid = 2694;}// file: 12
			case 2694:{cid = 3565;}// file: 12
			case 3565:{cid = 3566;}// file: 12
			case 3566:{cid = 3568;}// file: 12
			case 3568:{cid = 3569;}// file: 12
			case 3569:{cid = 3570;}// file: 12
			case 3570:{cid = 3571;}// file: 12
			case 3571:{cid = 3572;}// file: 12
			case 3572:{cid = 3573;}// file: 12
			case 3573:{cid = 3574;}// file: 12
			case 3574:{cid = 3575;}// file: 12
			case 3575:{cid = 3576;}// file: 12
			case 3576:{cid = 3577;}// file: 12
			case 3577:{cid = 3621;}// file: 12
			case 3621:{cid = 3630;}// file: 12
			case 3630:{cid = 3632;}// file: 12
			case 3632:{cid = 3633;}// file: 12
			case 3633:{cid = 3722;}// file: 12
			case 3722:{cid = 3724;}// file: 12
			case 3724:{cid = 3761;}// file: 12
			case 3761:{cid = 3796;}// file: 12
			case 3796:{cid = 3798;}// file: 12
			case 3798:{cid = 3799;}// file: 12
			case 3799:{cid = 3800;}// file: 12
			case 3800:{cid = 5132;}// file: 12
			case 5132:{cid = 5259;}// file: 12
			case 5259:{cid = 5260;}// file: 12
			case 5260:{cid = 5261;}// file: 12
			case 5261:{cid = 5262;}// file: 12
			case 5262:{cid = 5269;}// file: 12
			case 5269:{cid = 5855;}// file: 12
			case 5855:{cid = 7025;}// file: 12
			case 7025:{cid = 7040;}// file: 12
			case 7040:{cid = 7102;}// file: 12
			case 7102:{cid = 7104;}// file: 12
			case 7104:{cid = 7172;}// file: 12
			case 7172:{cid = 7186;}// file: 12
			case 7186:{cid = 7317;}// file: 12
			case 7317:{cid = 7515;}// file: 12
			case 7515:{cid = 7516;}// file: 12
			case 7516:{cid = 7527;}// file: 12
			case 7527:{cid = 7561;}// file: 12
			case 7561:{cid = 7620;}// file: 12
			case 7620:{cid = 7621;}// file: 12
			case 7621:{cid = 7622;}// file: 12
			case 7622:{cid = 7834;}// file: 12
			case 7834:{cid = 7836;}// file: 12
			case 7836:{cid = 8073;}// file: 12
			case 8073:{cid = 8074;}// file: 12
			case 8074:{cid = 8075;}// file: 12
			case 8075:{cid = 8076;}// file: 12
			case 8076:{cid = 8077;}// file: 12
			case 8077:{cid = 8078;}// file: 12
			case 8078:{cid = 8335;}// file: 12
			case 8335:{cid = 8337;}// file: 12
			case 8337:{cid = 8339;}// file: 12
			case 8339:{cid = 8341;}// file: 12
			case 8341:{cid = 8883;}// file: 12
			case 8883:{cid = 8884;}// file: 12
			case 8884:{cid = 8885;}// file: 12
			case 8885:{cid = 8886;}// file: 12
			case 8886:{cid = 9587;}// file: 12
			case 9587:{cid = 9588;}// file: 12
			case 9588:{cid = 9589;}// file: 12
			case 9589:{cid = 9604;}// file: 12
			case 9604:{cid = 10231;}// file: 12
			case 10231:{cid = 10248;}// file: 12
			case 10248:{cid = 10576;}// file: 12
			case 10576:{cid = 10773;}// file: 12
			case 10773:{cid = 10774;}// file: 12
			case 10774:{cid = 10811;}// file: 12
			case 10811:{cid = 10814;}// file: 12
			case 10814:{cid = 12821;}// file: 12
			case 12821:{cid = 12859;}// file: 12
			case 12859:{cid = 12860;}// file: 12
			case 12860:{cid = 12861;}// file: 12
			case 12861:{cid = 12913;}// file: 12
			case 12913:{cid = 12927;}// file: 12
			case 12927:{cid = 12930;}// file: 12
			case 12930:{cid = 12955;}// file: 12
			case 12955:{cid = 12977;}// file: 12
			case 12977:{cid = 13025;}// file: 12
			case 13025:{cid = 13489;}// file: 12
			case 13489:{cid = 14549;}// file: 12
			case 14549:{cid = 14552;}// file: 12
			case 14552:{cid = 14558;}// file: 12
			case 14558:{cid = 14612;}// file: 12
			case 14612:{cid = 14613;}// file: 12
			case 14613:{cid = 14800;}// file: 12
			case 14800:{cid = 14878;}// file: 12
			case 14878:{cid = 16599;}// file: 12
			case 16599:{cid = 16601;}// file: 12
			case 16601:{cid = 17019;}// file: 12
			case 17019:{cid = 17020;}// file: 12
			case 17020:{cid = 17055;}// file: 12
			case 17055:{cid = 18257;}// file: 12
			case 18257:{cid = 18260;}// file: 12
			case 18260:{cid = 936;}// file: 12
			case 936:{cid = 937;}// file: 18
			case 937:{cid = 941;}// file: 18
			case 941:{cid = 1416;}// file: 18
			case 1416:{cid = 1417;}// file: 18
			case 1417:{cid = 1421;}// file: 18
			case 1421:{cid = 1645;}// file: 18
			case 1645:{cid = 1646;}// file: 18
			case 1646:{cid = 1647;}// file: 18
			case 1647:{cid = 1730;}// file: 18
			case 1730:{cid = 1740;}// file: 18
			case 1740:{cid = 1741;}// file: 18
			case 1741:{cid = 1742;}// file: 18
			case 1742:{cid = 1743;}// file: 18
			case 1743:{cid = 1744;}// file: 18
			case 1744:{cid = 1754;}// file: 18
			case 1754:{cid = 1755;}// file: 18
			case 1755:{cid = 1758;}// file: 18
			case 1758:{cid = 1759;}// file: 18
			case 1759:{cid = 1762;}// file: 18
			case 1762:{cid = 1765;}// file: 18
			case 1765:{cid = 1767;}// file: 18
			case 1767:{cid = 1769;}// file: 18
			case 1769:{cid = 1813;}// file: 18
			case 1813:{cid = 1814;}// file: 18
			case 1814:{cid = 1815;}// file: 18
			case 1815:{cid = 1816;}// file: 18
			case 1816:{cid = 1817;}// file: 18
			case 1817:{cid = 1818;}// file: 18
			case 1818:{cid = 1819;}// file: 18
			case 1819:{cid = 1820;}// file: 18
			case 1820:{cid = 1821;}// file: 18
			case 1821:{cid = 1822;}// file: 18
			case 1822:{cid = 1823;}// file: 18
			case 1823:{cid = 2000;}// file: 18
			case 2000:{cid = 2007;}// file: 18
			case 2007:{cid = 2014;}// file: 18
			case 2014:{cid = 2015;}// file: 18
			case 2015:{cid = 2016;}// file: 18
			case 2016:{cid = 2018;}// file: 18
			case 2018:{cid = 2019;}// file: 18
			case 2019:{cid = 2020;}// file: 18
			case 2020:{cid = 2021;}// file: 18
			case 2021:{cid = 2022;}// file: 18
			case 2022:{cid = 2024;}// file: 18
			case 2024:{cid = 2025;}// file: 18
			case 2025:{cid = 2046;}// file: 18
			case 2046:{cid = 2063;}// file: 18
			case 2063:{cid = 2065;}// file: 18
			case 2065:{cid = 2066;}// file: 18
			case 2066:{cid = 2067;}// file: 18
			case 2067:{cid = 2078;}// file: 18
			case 2078:{cid = 2081;}// file: 18
			case 2081:{cid = 2082;}// file: 18
			case 2082:{cid = 2083;}// file: 18
			case 2083:{cid = 2084;}// file: 18
			case 2084:{cid = 2087;}// file: 18
			case 2087:{cid = 2088;}// file: 18
			case 2088:{cid = 2089;}// file: 18
			case 2089:{cid = 2092;}// file: 18
			case 2092:{cid = 2094;}// file: 18
			case 2094:{cid = 2095;}// file: 18
			case 2095:{cid = 2126;}// file: 18
			case 2126:{cid = 2128;}// file: 18
			case 2128:{cid = 2129;}// file: 18
			case 2129:{cid = 2133;}// file: 18
			case 2133:{cid = 2134;}// file: 18
			case 2134:{cid = 2137;}// file: 18
			case 2137:{cid = 2138;}// file: 18
			case 2138:{cid = 2139;}// file: 18
			case 2139:{cid = 2140;}// file: 18
			case 2140:{cid = 2141;}// file: 18
			case 2141:{cid = 2142;}// file: 18
			case 2142:{cid = 2143;}// file: 18
			case 2143:{cid = 2145;}// file: 18
			case 2145:{cid = 2148;}// file: 18
			case 2148:{cid = 2151;}// file: 18
			case 2151:{cid = 2152;}// file: 18
			case 2152:{cid = 2153;}// file: 18
			case 2153:{cid = 2154;}// file: 18
			case 2154:{cid = 2155;}// file: 18
			case 2155:{cid = 2156;}// file: 18
			case 2156:{cid = 2157;}// file: 18
			case 2157:{cid = 2158;}// file: 18
			case 2158:{cid = 2159;}// file: 18
			case 2159:{cid = 2160;}// file: 18
			case 2160:{cid = 2161;}// file: 18
			case 2161:{cid = 2162;}// file: 18
			case 2162:{cid = 2163;}// file: 18
			case 2163:{cid = 2164;}// file: 18
			case 2164:{cid = 2167;}// file: 18
			case 2167:{cid = 2168;}// file: 18
			case 2168:{cid = 2187;}// file: 18
			case 2187:{cid = 2191;}// file: 18
			case 2191:{cid = 2197;}// file: 18
			case 2197:{cid = 2199;}// file: 18
			case 2199:{cid = 2200;}// file: 18
			case 2200:{cid = 2204;}// file: 18
			case 2204:{cid = 2208;}// file: 18
			case 2208:{cid = 2210;}// file: 18
			case 2210:{cid = 2211;}// file: 18
			case 2211:{cid = 2234;}// file: 18
			case 2234:{cid = 2235;}// file: 18
			case 2235:{cid = 2236;}// file: 18
			case 2236:{cid = 2291;}// file: 18
			case 2291:{cid = 2292;}// file: 18
			case 2292:{cid = 2295;}// file: 18
			case 2295:{cid = 2303;}// file: 18
			case 2303:{cid = 2304;}// file: 18
			case 2304:{cid = 2305;}// file: 18
			case 2305:{cid = 2306;}// file: 18
			case 2306:{cid = 2307;}// file: 18
			case 2307:{cid = 2323;}// file: 18
			case 2323:{cid = 2328;}// file: 18
			case 2328:{cid = 2329;}// file: 18
			case 2329:{cid = 2330;}// file: 18
			case 2330:{cid = 2334;}// file: 18
			case 2334:{cid = 2335;}// file: 18
			case 2335:{cid = 2338;}// file: 18
			case 2338:{cid = 2341;}// file: 18
			case 2341:{cid = 2416;}// file: 18
			case 2416:{cid = 2418;}// file: 18
			case 2418:{cid = 2419;}// file: 18
			case 2419:{cid = 2451;}// file: 18
			case 2451:{cid = 2462;}// file: 18
			case 2462:{cid = 2463;}// file: 18
			case 2463:{cid = 2475;}// file: 18
			case 2475:{cid = 2482;}// file: 18
			case 2482:{cid = 2502;}// file: 18
			case 2502:{cid = 2509;}// file: 18
			case 2509:{cid = 2529;}// file: 18
			case 2529:{cid = 2530;}// file: 18
			case 2530:{cid = 2531;}// file: 18
			case 2531:{cid = 2532;}// file: 18
			case 2532:{cid = 2533;}// file: 18
			case 2533:{cid = 2534;}// file: 18
			case 2534:{cid = 2562;}// file: 18
			case 2562:{cid = 2568;}// file: 18
			case 2568:{cid = 2569;}// file: 18
			case 2569:{cid = 2570;}// file: 18
			case 2570:{cid = 2573;}// file: 18
			case 2573:{cid = 2574;}// file: 18
			case 2574:{cid = 2576;}// file: 18
			case 2576:{cid = 2591;}// file: 18
			case 2591:{cid = 2604;}// file: 18
			case 2604:{cid = 2606;}// file: 18
			case 2606:{cid = 2608;}// file: 18
			case 2608:{cid = 2609;}// file: 18
			case 2609:{cid = 2610;}// file: 18
			case 2610:{cid = 2708;}// file: 18
			case 2708:{cid = 2737;}// file: 18
			case 2737:{cid = 5171;}// file: 18
			case 5171:{cid = 9362;}// file: 18
			case 9362:{cid = 11334;}// file: 18
			case 11334:{cid = 13003;}// file: 18
			case 13003:{cid = 13890;}// file: 18
			case 13890:{cid = 14455;}// file: 18
			case 14455:{cid = 14472;}// file: 18
			case 14472:{cid = 14477;}// file: 18
			case 14477:{cid = 14491;}// file: 18
			case 14491:{cid = 14493;}// file: 18
			case 14493:{cid = 14502;}// file: 18
			case 14502:{cid = 14503;}// file: 18
			case 14503:{cid = 14504;}// file: 18
			case 14504:{cid = 14505;}// file: 18
			case 14505:{cid = 14507;}// file: 18
			case 14507:{cid = 14508;}// file: 18
			case 14508:{cid = 14509;}// file: 18
			case 14509:{cid = 14510;}// file: 18
			case 14510:{cid = 14535;}// file: 18
			case 14535:{cid = 14540;}// file: 18
			case 14540:{cid = 14543;}// file: 18
			case 14543:{cid = 14544;}// file: 18
			case 14544:{cid = 14556;}// file: 18
			case 14556:{cid = 14632;}// file: 18
			case 14632:{cid = 14633;}// file: 18
			case 14633:{cid = 14640;}// file: 18
			case 14640:{cid = 14704;}// file: 18
			case 14704:{cid = 14719;}// file: 18
			case 14719:{cid = 14720;}// file: 18
			case 14720:{cid = 14721;}// file: 18
			case 14721:{cid = 14739;}// file: 18
			case 14739:{cid = 14741;}// file: 18
			case 14741:{cid = 14745;}// file: 18
			case 14745:{cid = 14802;}// file: 18
			case 14802:{cid = 14805;}// file: 18
			case 14805:{cid = 14813;}// file: 18
			case 14813:{cid = 14816;}// file: 18
			case 14816:{cid = 14817;}// file: 18
			case 14817:{cid = 14828;}// file: 18
			case 14828:{cid = 14839;}// file: 18
			case 14839:{cid = 14850;}// file: 18
			case 14850:{cid = 14888;}// file: 18
			case 14888:{cid = 14895;}// file: 18
			case 14895:{cid = 15025;}// file: 18
			case 15025:{cid = 15026;}// file: 18
			case 15026:{cid = 15032;}// file: 18
			case 15032:{cid = 15036;}// file: 18
			case 15036:{cid = 15052;}// file: 18
			case 15052:{cid = 16154;}// file: 18
			case 16154:{cid = 16378;}// file: 18
			case 16378:{cid = 18019;}// file: 18
			case 18019:{cid = 18077;}// file: 18
			case 18077:{cid = 643;}// file: 18
			case 643:{cid = 1256;}// file: 21
			case 1256:{cid = 1280;}// file: 21
			case 1280:{cid = 1281;}// file: 21
			case 1281:{cid = 1368;}// file: 21
			case 1368:{cid = 1432;}// file: 21
			case 1432:{cid = 1433;}// file: 21
			case 1433:{cid = 1516;}// file: 21
			case 1516:{cid = 1562;}// file: 21
			case 1562:{cid = 1563;}// file: 21
			case 1563:{cid = 1594;}// file: 21
			case 1594:{cid = 1663;}// file: 21
			case 1663:{cid = 1670;}// file: 21
			case 1670:{cid = 1671;}// file: 21
			case 1671:{cid = 1679;}// file: 21
			case 1679:{cid = 1704;}// file: 21
			case 1704:{cid = 1705;}// file: 21
			case 1705:{cid = 1708;}// file: 21
			case 1708:{cid = 1711;}// file: 21
			case 1711:{cid = 1714;}// file: 21
			case 1714:{cid = 1715;}// file: 21
			case 1715:{cid = 1716;}// file: 21
			case 1716:{cid = 1720;}// file: 21
			case 1720:{cid = 1721;}// file: 21
			case 1721:{cid = 1722;}// file: 21
			case 1722:{cid = 1723;}// file: 21
			case 1723:{cid = 1724;}// file: 21
			case 1724:{cid = 1726;}// file: 21
			case 1726:{cid = 1727;}// file: 21
			case 1727:{cid = 1728;}// file: 21
			case 1728:{cid = 1729;}// file: 21
			case 1729:{cid = 1735;}// file: 21
			case 1735:{cid = 1739;}// file: 21
			case 1739:{cid = 1746;}// file: 21
			case 1746:{cid = 1805;}// file: 21
			case 1805:{cid = 1806;}// file: 21
			case 1806:{cid = 1810;}// file: 21
			case 1810:{cid = 1811;}// file: 21
			case 1811:{cid = 1824;}// file: 21
			case 1824:{cid = 1825;}// file: 21
			case 1825:{cid = 1826;}// file: 21
			case 1826:{cid = 1827;}// file: 21
			case 1827:{cid = 1896;}// file: 21
			case 1896:{cid = 1954;}// file: 21
			case 1954:{cid = 1957;}// file: 21
			case 1957:{cid = 1963;}// file: 21
			case 1963:{cid = 1968;}// file: 21
			case 1968:{cid = 1969;}// file: 21
			case 1969:{cid = 1970;}// file: 21
			case 1970:{cid = 1998;}// file: 21
			case 1998:{cid = 1999;}// file: 21
			case 1999:{cid = 2008;}// file: 21
			case 2008:{cid = 2009;}// file: 21
			case 2009:{cid = 2027;}// file: 21
			case 2027:{cid = 2079;}// file: 21
			case 2079:{cid = 2096;}// file: 21
			case 2096:{cid = 2120;}// file: 21
			case 2120:{cid = 2121;}// file: 21
			case 2121:{cid = 2122;}// file: 21
			case 2122:{cid = 2123;}// file: 21
			case 2123:{cid = 2124;}// file: 21
			case 2124:{cid = 2125;}// file: 21
			case 2125:{cid = 2165;}// file: 21
			case 2165:{cid = 2166;}// file: 21
			case 2166:{cid = 2169;}// file: 21
			case 2169:{cid = 2171;}// file: 21
			case 2171:{cid = 2172;}// file: 21
			case 2172:{cid = 2173;}// file: 21
			case 2173:{cid = 2174;}// file: 21
			case 2174:{cid = 2175;}// file: 21
			case 2175:{cid = 2180;}// file: 21
			case 2180:{cid = 2181;}// file: 21
			case 2181:{cid = 2182;}// file: 21
			case 2182:{cid = 2183;}// file: 21
			case 2183:{cid = 2184;}// file: 21
			case 2184:{cid = 2185;}// file: 21
			case 2185:{cid = 2193;}// file: 21
			case 2193:{cid = 2198;}// file: 21
			case 2198:{cid = 2205;}// file: 21
			case 2205:{cid = 2206;}// file: 21
			case 2206:{cid = 2207;}// file: 21
			case 2207:{cid = 2209;}// file: 21
			case 2209:{cid = 2293;}// file: 21
			case 2293:{cid = 2308;}// file: 21
			case 2308:{cid = 2309;}// file: 21
			case 2309:{cid = 2310;}// file: 21
			case 2310:{cid = 2311;}// file: 21
			case 2311:{cid = 2313;}// file: 21
			case 2313:{cid = 2314;}// file: 21
			case 2314:{cid = 2315;}// file: 21
			case 2315:{cid = 2319;}// file: 21
			case 2319:{cid = 2321;}// file: 21
			case 2321:{cid = 2343;}// file: 21
			case 2343:{cid = 2346;}// file: 21
			case 2346:{cid = 2350;}// file: 21
			case 2350:{cid = 2356;}// file: 21
			case 2356:{cid = 2370;}// file: 21
			case 2370:{cid = 2592;}// file: 21
			case 2592:{cid = 2605;}// file: 21
			case 2605:{cid = 2607;}// file: 21
			case 2607:{cid = 2635;}// file: 21
			case 2635:{cid = 2636;}// file: 21
			case 2636:{cid = 2637;}// file: 21
			case 2637:{cid = 2638;}// file: 21
			case 2638:{cid = 2639;}// file: 21
			case 2639:{cid = 2644;}// file: 21
			case 2644:{cid = 2723;}// file: 21
			case 2723:{cid = 2724;}// file: 21
			case 2724:{cid = 2725;}// file: 21
			case 2725:{cid = 2746;}// file: 21
			case 2746:{cid = 2747;}// file: 21
			case 2747:{cid = 2748;}// file: 21
			case 2748:{cid = 2762;}// file: 21
			case 2762:{cid = 2763;}// file: 21
			case 2763:{cid = 2764;}// file: 21
			case 2764:{cid = 2776;}// file: 21
			case 2776:{cid = 2777;}// file: 21
			case 2777:{cid = 2784;}// file: 21
			case 2784:{cid = 2788;}// file: 21
			case 2788:{cid = 2799;}// file: 21
			case 2799:{cid = 2800;}// file: 21
			case 2800:{cid = 2801;}// file: 21
			case 2801:{cid = 2802;}// file: 21
			case 2802:{cid = 2807;}// file: 21
			case 2807:{cid = 2808;}// file: 21
			case 2808:{cid = 3383;}// file: 21
			case 3383:{cid = 3657;}// file: 21
			case 3657:{cid = 3752;}// file: 21
			case 3752:{cid = 11631;}// file: 21
			case 11631:{cid = 11665;}// file: 21
			case 11665:{cid = 12842;}// file: 21
			case 12842:{cid = 14401;}// file: 21
			case 14401:{cid = 14405;}// file: 21
			case 14405:{cid = 14458;}// file: 21
			case 14458:{cid = 14490;}// file: 21
			case 14490:{cid = 14619;}// file: 21
			case 14619:{cid = 14620;}// file: 21
			case 14620:{cid = 14657;}// file: 21
			case 14657:{cid = 14770;}// file: 21
			case 14770:{cid = 14810;}// file: 21
			case 14810:{cid = 14833;}// file: 21
			case 14833:{cid = 14837;}// file: 21
			case 14837:{cid = 14869;}// file: 21
			case 14869:{cid = 18055;}// file: 21
			case 18055:{cid = 18057;}// file: 21
			case 18057:{cid = 18059;}// file: 21
			case 18059:{cid = 18060;}// file: 21
			case 18060:{cid = 849;}// file: 21
			case 849:{cid = 850;}// file: 28
			case 850:{cid = 851;}// file: 28
			case 851:{cid = 852;}// file: 28
			case 852:{cid = 853;}// file: 28
			case 853:{cid = 854;}// file: 28
			case 854:{cid = 910;}// file: 28
			case 910:{cid = 911;}// file: 28
			case 911:{cid = 912;}// file: 28
			case 912:{cid = 913;}// file: 28
			case 913:{cid = 916;}// file: 28
			case 916:{cid = 917;}// file: 28
			case 917:{cid = 922;}// file: 28
			case 922:{cid = 923;}// file: 28
			case 923:{cid = 924;}// file: 28
			case 924:{cid = 926;}// file: 28
			case 926:{cid = 928;}// file: 28
			case 928:{cid = 933;}// file: 28
			case 933:{cid = 939;}// file: 28
			case 939:{cid = 942;}// file: 28
			case 942:{cid = 952;}// file: 28
			case 952:{cid = 960;}// file: 28
			case 960:{cid = 961;}// file: 28
			case 961:{cid = 1219;}// file: 28
			case 1219:{cid = 1220;}// file: 28
			case 1220:{cid = 1221;}// file: 28
			case 1221:{cid = 1224;}// file: 28
			case 1224:{cid = 1227;}// file: 28
			case 1227:{cid = 1230;}// file: 28
			case 1230:{cid = 1235;}// file: 28
			case 1235:{cid = 1236;}// file: 28
			case 1236:{cid = 1264;}// file: 28
			case 1264:{cid = 1265;}// file: 28
			case 1265:{cid = 1299;}// file: 28
			case 1299:{cid = 1300;}// file: 28
			case 1300:{cid = 1327;}// file: 28
			case 1327:{cid = 1328;}// file: 28
			case 1328:{cid = 1329;}// file: 28
			case 1329:{cid = 1330;}// file: 28
			case 1330:{cid = 1331;}// file: 28
			case 1331:{cid = 1332;}// file: 28
			case 1332:{cid = 1333;}// file: 28
			case 1333:{cid = 1334;}// file: 28
			case 1334:{cid = 1335;}// file: 28
			case 1335:{cid = 1336;}// file: 28
			case 1336:{cid = 1337;}// file: 28
			case 1337:{cid = 1338;}// file: 28
			case 1338:{cid = 1339;}// file: 28
			case 1339:{cid = 1343;}// file: 28
			case 1343:{cid = 1344;}// file: 28
			case 1344:{cid = 1345;}// file: 28
			case 1345:{cid = 1347;}// file: 28
			case 1347:{cid = 1349;}// file: 28
			case 1349:{cid = 1355;}// file: 28
			case 1355:{cid = 1356;}// file: 28
			case 1356:{cid = 1357;}// file: 28
			case 1357:{cid = 1358;}// file: 28
			case 1358:{cid = 1359;}// file: 28
			case 1359:{cid = 1365;}// file: 28
			case 1365:{cid = 1369;}// file: 28
			case 1369:{cid = 1371;}// file: 28
			case 1371:{cid = 1372;}// file: 28
			case 1372:{cid = 1409;}// file: 28
			case 1409:{cid = 1415;}// file: 28
			case 1415:{cid = 1429;}// file: 28
			case 1429:{cid = 1430;}// file: 28
			case 1430:{cid = 1438;}// file: 28
			case 1438:{cid = 1439;}// file: 28
			case 1439:{cid = 1440;}// file: 28
			case 1440:{cid = 1441;}// file: 28
			case 1441:{cid = 1442;}// file: 28
			case 1442:{cid = 1448;}// file: 28
			case 1448:{cid = 1449;}// file: 28
			case 1449:{cid = 1450;}// file: 28
			case 1450:{cid = 1462;}// file: 28
			case 1462:{cid = 1549;}// file: 28
			case 1549:{cid = 1558;}// file: 28
			case 1558:{cid = 1572;}// file: 28
			case 1572:{cid = 1574;}// file: 28
			case 1574:{cid = 1733;}// file: 28
			case 1733:{cid = 1773;}// file: 28
			case 1773:{cid = 1777;}// file: 28
			case 1777:{cid = 2062;}// file: 28
			case 2062:{cid = 2670;}// file: 28
			case 2670:{cid = 2671;}// file: 28
			case 2671:{cid = 2672;}// file: 28
			case 2672:{cid = 2673;}// file: 28
			case 2673:{cid = 2674;}// file: 28
			case 2674:{cid = 2675;}// file: 28
			case 2675:{cid = 2676;}// file: 28
			case 2676:{cid = 2677;}// file: 28
			case 2677:{cid = 2770;}// file: 28
			case 2770:{cid = 3593;}// file: 28
			case 3593:{cid = 3594;}// file: 28
			case 3594:{cid = 5291;}// file: 28
			case 5291:{cid = 12954;}// file: 28
			case 12954:{cid = 12957;}// file: 28
			case 12957:{cid = 13591;}// file: 28
			case 13591:{cid = 14600;}// file: 28
			case 14600:{cid = 18245;}// file: 28
			case 18245:{cid = 18246;}// file: 28
			case 18246:{cid = 18247;}// file: 28
			case 18247:{cid = 18248;}// file: 28
			case 18248:{cid = 18249;}// file: 28
			case 18249:{cid = 18250;}// file: 28
			case 18250:{cid = 18251;}// file: 28
			case 18251:{cid = 18252;}// file: 28
			case 18252:{cid = 18253;}// file: 28
			case 18253:{cid = 18254;}// file: 28
			case 18254:{cid = 615;}// file: 28
			case 615:{cid = 616;}// file: 31
			case 616:{cid = 617;}// file: 31
			case 617:{cid = 618;}// file: 31
			case 618:{cid = 619;}// file: 31
			case 619:{cid = 620;}// file: 31
			case 620:{cid = 621;}// file: 31
			case 621:{cid = 622;}// file: 31
			case 622:{cid = 623;}// file: 31
			case 623:{cid = 624;}// file: 31
			case 624:{cid = 629;}// file: 31
			case 629:{cid = 634;}// file: 31
			case 634:{cid = 641;}// file: 31
			case 641:{cid = 645;}// file: 31
			case 645:{cid = 648;}// file: 31
			case 648:{cid = 649;}// file: 31
			case 649:{cid = 652;}// file: 31
			case 652:{cid = 654;}// file: 31
			case 654:{cid = 655;}// file: 31
			case 655:{cid = 656;}// file: 31
			case 656:{cid = 657;}// file: 31
			case 657:{cid = 658;}// file: 31
			case 658:{cid = 659;}// file: 31
			case 659:{cid = 660;}// file: 31
			case 660:{cid = 661;}// file: 31
			case 661:{cid = 664;}// file: 31
			case 664:{cid = 669;}// file: 31
			case 669:{cid = 670;}// file: 31
			case 670:{cid = 671;}// file: 31
			case 671:{cid = 672;}// file: 31
			case 672:{cid = 673;}// file: 31
			case 673:{cid = 674;}// file: 31
			case 674:{cid = 676;}// file: 31
			case 676:{cid = 680;}// file: 31
			case 680:{cid = 681;}// file: 31
			case 681:{cid = 683;}// file: 31
			case 683:{cid = 685;}// file: 31
			case 685:{cid = 686;}// file: 31
			case 686:{cid = 687;}// file: 31
			case 687:{cid = 688;}// file: 31
			case 688:{cid = 689;}// file: 31
			case 689:{cid = 690;}// file: 31
			case 690:{cid = 691;}// file: 31
			case 691:{cid = 693;}// file: 31
			case 693:{cid = 694;}// file: 31
			case 694:{cid = 695;}// file: 31
			case 695:{cid = 696;}// file: 31
			case 696:{cid = 697;}// file: 31
			case 697:{cid = 698;}// file: 31
			case 698:{cid = 700;}// file: 31
			case 700:{cid = 703;}// file: 31
			case 703:{cid = 704;}// file: 31
			case 704:{cid = 705;}// file: 31
			case 705:{cid = 706;}// file: 31
			case 706:{cid = 707;}// file: 31
			case 707:{cid = 708;}// file: 31
			case 708:{cid = 709;}// file: 31
			case 709:{cid = 710;}// file: 31
			case 710:{cid = 711;}// file: 31
			case 711:{cid = 712;}// file: 31
			case 712:{cid = 713;}// file: 31
			case 713:{cid = 714;}// file: 31
			case 714:{cid = 715;}// file: 31
			case 715:{cid = 716;}// file: 31
			case 716:{cid = 717;}// file: 31
			case 717:{cid = 718;}// file: 31
			case 718:{cid = 719;}// file: 31
			case 719:{cid = 720;}// file: 31
			case 720:{cid = 721;}// file: 31
			case 721:{cid = 722;}// file: 31
			case 722:{cid = 723;}// file: 31
			case 723:{cid = 724;}// file: 31
			case 724:{cid = 725;}// file: 31
			case 725:{cid = 726;}// file: 31
			case 726:{cid = 727;}// file: 31
			case 727:{cid = 729;}// file: 31
			case 729:{cid = 730;}// file: 31
			case 730:{cid = 731;}// file: 31
			case 731:{cid = 732;}// file: 31
			case 732:{cid = 733;}// file: 31
			case 733:{cid = 734;}// file: 31
			case 734:{cid = 735;}// file: 31
			case 735:{cid = 736;}// file: 31
			case 736:{cid = 737;}// file: 31
			case 737:{cid = 738;}// file: 31
			case 738:{cid = 739;}// file: 31
			case 739:{cid = 740;}// file: 31
			case 740:{cid = 763;}// file: 31
			case 763:{cid = 764;}// file: 31
			case 764:{cid = 765;}// file: 31
			case 765:{cid = 766;}// file: 31
			case 766:{cid = 767;}// file: 31
			case 767:{cid = 768;}// file: 31
			case 768:{cid = 769;}// file: 31
			case 769:{cid = 770;}// file: 31
			case 770:{cid = 771;}// file: 31
			case 771:{cid = 772;}// file: 31
			case 772:{cid = 773;}// file: 31
			case 773:{cid = 774;}// file: 31
			case 774:{cid = 775;}// file: 31
			case 775:{cid = 776;}// file: 31
			case 776:{cid = 777;}// file: 31
			case 777:{cid = 778;}// file: 31
			case 778:{cid = 779;}// file: 31
			case 779:{cid = 780;}// file: 31
			case 780:{cid = 781;}// file: 31
			case 781:{cid = 782;}// file: 31
			case 782:{cid = 789;}// file: 31
			case 789:{cid = 790;}// file: 31
			case 790:{cid = 791;}// file: 31
			case 791:{cid = 792;}// file: 31
			case 792:{cid = 858;}// file: 31
			case 858:{cid = 881;}// file: 31
			case 881:{cid = 882;}// file: 31
			case 882:{cid = 883;}// file: 31
			case 883:{cid = 884;}// file: 31
			case 884:{cid = 885;}// file: 31
			case 885:{cid = 886;}// file: 31
			case 886:{cid = 887;}// file: 31
			case 887:{cid = 888;}// file: 31
			case 888:{cid = 889;}// file: 31
			case 889:{cid = 890;}// file: 31
			case 890:{cid = 891;}// file: 31
			case 891:{cid = 892;}// file: 31
			case 892:{cid = 893;}// file: 31
			case 893:{cid = 894;}// file: 31
			case 894:{cid = 895;}// file: 31
			case 895:{cid = 904;}// file: 31
			case 904:{cid = 3505;}// file: 31
			case 3505:{cid = 3506;}// file: 31
			case 3506:{cid = 3507;}// file: 31
			case 3507:{cid = 3508;}// file: 31
			case 3508:{cid = 3509;}// file: 31
			case 3509:{cid = 3510;}// file: 31
			case 3510:{cid = 3511;}// file: 31
			case 3511:{cid = 3512;}// file: 31
			case 3512:{cid = 3517;}// file: 31
			case 3517:{cid = 16060;}// file: 31
			case 16060:{cid = 16061;}// file: 31
			case 16061:{cid = 18268;}// file: 31
			case 18268:{cid = 18269;}// file: 31
			case 18269:{cid = 18270;}// file: 31
			case 18270:{cid = 18271;}// file: 31
			case 18271:{cid = 18272;}// file: 31
			case 18272:{cid = 18273;}// file: 31
			case 18273:{cid = 966;}// file: 31
			case 966:{cid = 968;}// file: 35
			case 968:{cid = 969;}// file: 35
			case 969:{cid = 970;}// file: 35
			case 970:{cid = 971;}// file: 35
			case 971:{cid = 972;}// file: 35
			case 972:{cid = 973;}// file: 35
			case 973:{cid = 974;}// file: 35
			case 974:{cid = 975;}// file: 35
			case 975:{cid = 976;}// file: 35
			case 976:{cid = 978;}// file: 35
			case 978:{cid = 979;}// file: 35
			case 979:{cid = 980;}// file: 35
			case 980:{cid = 981;}// file: 35
			case 981:{cid = 982;}// file: 35
			case 982:{cid = 983;}// file: 35
			case 983:{cid = 984;}// file: 35
			case 984:{cid = 985;}// file: 35
			case 985:{cid = 986;}// file: 35
			case 986:{cid = 987;}// file: 35
			case 987:{cid = 988;}// file: 35
			case 988:{cid = 989;}// file: 35
			case 989:{cid = 990;}// file: 35
			case 990:{cid = 991;}// file: 35
			case 991:{cid = 992;}// file: 35
			case 992:{cid = 993;}// file: 35
			case 993:{cid = 994;}// file: 35
			case 994:{cid = 995;}// file: 35
			case 995:{cid = 996;}// file: 35
			case 996:{cid = 997;}// file: 35
			case 997:{cid = 998;}// file: 35
			case 998:{cid = 1228;}// file: 35
			case 1228:{cid = 1237;}// file: 35
			case 1237:{cid = 1250;}// file: 35
			case 1250:{cid = 1251;}// file: 35
			case 1251:{cid = 1282;}// file: 35
			case 1282:{cid = 1374;}// file: 35
			case 1374:{cid = 1407;}// file: 35
			case 1407:{cid = 1408;}// file: 35
			case 1408:{cid = 1410;}// file: 35
			case 1410:{cid = 1411;}// file: 35
			case 1411:{cid = 1412;}// file: 35
			case 1412:{cid = 1413;}// file: 35
			case 1413:{cid = 1414;}// file: 35
			case 1414:{cid = 1418;}// file: 35
			case 1418:{cid = 1419;}// file: 35
			case 1419:{cid = 1422;}// file: 35
			case 1422:{cid = 1423;}// file: 35
			case 1423:{cid = 1424;}// file: 35
			case 1424:{cid = 1425;}// file: 35
			case 1425:{cid = 1427;}// file: 35
			case 1427:{cid = 1434;}// file: 35
			case 1434:{cid = 1435;}// file: 35
			case 1435:{cid = 1446;}// file: 35
			case 1446:{cid = 1447;}// file: 35
			case 1447:{cid = 1456;}// file: 35
			case 1456:{cid = 1459;}// file: 35
			case 1459:{cid = 1460;}// file: 35
			case 1460:{cid = 1468;}// file: 35
			case 1468:{cid = 1552;}// file: 35
			case 1552:{cid = 1553;}// file: 35
			case 1553:{cid = 1648;}// file: 35
			case 1648:{cid = 1652;}// file: 35
			case 1652:{cid = 1653;}// file: 35
			case 1653:{cid = 1662;}// file: 35
			case 1662:{cid = 2098;}// file: 35
			case 2098:{cid = 2395;}// file: 35
			case 2395:{cid = 2400;}// file: 35
			case 2400:{cid = 2650;}// file: 35
			case 2650:{cid = 2651;}// file: 35
			case 2651:{cid = 2755;}// file: 35
			case 2755:{cid = 3260;}// file: 35
			case 3260:{cid = 3275;}// file: 35
			case 3275:{cid = 3276;}// file: 35
			case 3276:{cid = 3282;}// file: 35
			case 3282:{cid = 3451;}// file: 35
			case 3451:{cid = 3475;}// file: 35
			case 3475:{cid = 3550;}// file: 35
			case 3550:{cid = 3749;}// file: 35
			case 3749:{cid = 3771;}// file: 35
			case 3771:{cid = 3850;}// file: 35
			case 3850:{cid = 4099;}// file: 35
			case 4099:{cid = 4100;}// file: 35
			case 4100:{cid = 4190;}// file: 35
			case 4190:{cid = 4195;}// file: 35
			case 4195:{cid = 4196;}// file: 35
			case 4196:{cid = 4201;}// file: 35
			case 4201:{cid = 4202;}// file: 35
			case 4202:{cid = 4724;}// file: 35
			case 4724:{cid = 5001;}// file: 35
			case 5001:{cid = 5005;}// file: 35
			case 5005:{cid = 5007;}// file: 35
			case 5007:{cid = 5030;}// file: 35
			case 5030:{cid = 5062;}// file: 35
			case 5062:{cid = 5070;}// file: 35
			case 5070:{cid = 5071;}// file: 35
			case 5071:{cid = 5072;}// file: 35
			case 5072:{cid = 5073;}// file: 35
			case 5073:{cid = 5074;}// file: 35
			case 5074:{cid = 5075;}// file: 35
			case 5075:{cid = 5076;}// file: 35
			case 5076:{cid = 5077;}// file: 35
			case 5077:{cid = 5051;}// file: 35
			case 5051:{cid = 5068;}// file: 35
			case 5068:{cid = 5081;}// file: 35
			case 5081:{cid = 5082;}// file: 35
			case 5082:{cid = 5190;}// file: 35
			case 5190:{cid = 5306;}// file: 35
			case 5306:{cid = 5338;}// file: 35
			case 5338:{cid = 5893;}// file: 35
			case 5893:{cid = 6049;}// file: 35
			case 6049:{cid = 6960;}// file: 35
			case 6960:{cid = 6961;}// file: 35
			case 6961:{cid = 6967;}// file: 35
			case 6967:{cid = 6968;}// file: 35
			case 6968:{cid = 6969;}// file: 35
			case 6969:{cid = 6970;}// file: 35
			case 6970:{cid = 7022;}// file: 35
			case 7022:{cid = 7026;}// file: 35
			case 7026:{cid = 7028;}// file: 35
			case 7028:{cid = 7029;}// file: 35
			case 7029:{cid = 7030;}// file: 35
			case 7030:{cid = 7031;}// file: 35
			case 7031:{cid = 7033;}// file: 35
			case 7033:{cid = 7034;}// file: 35
			case 7034:{cid = 7038;}// file: 35
			case 7038:{cid = 7039;}// file: 35
			case 7039:{cid = 7191;}// file: 35
			case 7191:{cid = 7192;}// file: 35
			case 7192:{cid = 7196;}// file: 35
			case 7196:{cid = 7197;}// file: 35
			case 7197:{cid = 7198;}// file: 35
			case 7198:{cid = 7209;}// file: 35
			case 7209:{cid = 7210;}// file: 35
			case 7210:{cid = 7212;}// file: 35
			case 7212:{cid = 7223;}// file: 35
			case 7223:{cid = 7224;}// file: 35
			case 7224:{cid = 7227;}// file: 35
			case 7227:{cid = 7277;}// file: 35
			case 7277:{cid = 7292;}// file: 35
			case 7292:{cid = 7319;}// file: 35
			case 7319:{cid = 7361;}// file: 35
			case 7361:{cid = 7367;}// file: 35
			case 7367:{cid = 7368;}// file: 35
			case 7368:{cid = 7369;}// file: 35
			case 7369:{cid = 7370;}// file: 35
			case 7370:{cid = 7371;}// file: 35
			case 7371:{cid = 7377;}// file: 35
			case 7377:{cid = 7378;}// file: 35
			case 7378:{cid = 7379;}// file: 35
			case 7379:{cid = 7380;}// file: 35
			case 7380:{cid = 7381;}// file: 35
			case 7381:{cid = 7418;}// file: 35
			case 7418:{cid = 7423;}// file: 35
			case 7423:{cid = 7504;}// file: 35
			case 7504:{cid = 7505;}// file: 35
			case 7505:{cid = 7514;}// file: 35
			case 7514:{cid = 7517;}// file: 35
			case 7517:{cid = 7518;}// file: 35
			case 7518:{cid = 7522;}// file: 35
			case 7522:{cid = 7524;}// file: 35
			case 7524:{cid = 7538;}// file: 35
			case 7538:{cid = 7539;}// file: 35
			case 7539:{cid = 7540;}// file: 35
			case 7540:{cid = 7556;}// file: 35
			case 7556:{cid = 7560;}// file: 35
			case 7560:{cid = 7592;}// file: 35
			case 7592:{cid = 7593;}// file: 35
			case 7593:{cid = 7611;}// file: 35
			case 7611:{cid = 7612;}// file: 35
			case 7612:{cid = 7613;}// file: 35
			case 7613:{cid = 7614;}// file: 35
			case 7614:{cid = 7615;}// file: 35
			case 7615:{cid = 7623;}// file: 35
			case 7623:{cid = 7624;}// file: 35
			case 7624:{cid = 7625;}// file: 35
			case 7625:{cid = 7657;}// file: 35
			case 7657:{cid = 7663;}// file: 35
			case 7663:{cid = 7664;}// file: 35
			case 7664:{cid = 7665;}// file: 35
			case 7665:{cid = 7692;}// file: 35
			case 7692:{cid = 7837;}// file: 35
			case 7837:{cid = 7838;}// file: 35
			case 7838:{cid = 7839;}// file: 35
			case 7839:{cid = 7840;}// file: 35
			case 7840:{cid = 7841;}// file: 35
			case 7841:{cid = 7842;}// file: 35
			case 7842:{cid = 7893;}// file: 35
			case 7893:{cid = 7894;}// file: 35
			case 7894:{cid = 7919;}// file: 35
			case 7919:{cid = 7920;}// file: 35
			case 7920:{cid = 7921;}// file: 35
			case 7921:{cid = 7922;}// file: 35
			case 7922:{cid = 7923;}// file: 35
			case 7923:{cid = 7924;}// file: 35
			case 7924:{cid = 7933;}// file: 35
			case 7933:{cid = 7939;}// file: 35
			case 7939:{cid = 7956;}// file: 35
			case 7956:{cid = 8041;}// file: 35
			case 8041:{cid = 8042;}// file: 35
			case 8042:{cid = 8147;}// file: 35
			case 8147:{cid = 8148;}// file: 35
			case 8148:{cid = 8149;}// file: 35
			case 8149:{cid = 8150;}// file: 35
			case 8150:{cid = 8151;}// file: 35
			case 8151:{cid = 8152;}// file: 35
			case 8152:{cid = 8153;}// file: 35
			case 8153:{cid = 8154;}// file: 35
			case 8154:{cid = 8155;}// file: 35
			case 8155:{cid = 8165;}// file: 35
			case 8165:{cid = 8167;}// file: 35
			case 8167:{cid = 8173;}// file: 35
			case 8173:{cid = 8174;}// file: 35
			case 8174:{cid = 8175;}// file: 35
			case 8175:{cid = 8176;}// file: 35
			case 8176:{cid = 8177;}// file: 35
			case 8177:{cid = 8178;}// file: 35
			case 8178:{cid = 8185;}// file: 35
			case 8185:{cid = 8186;}// file: 35
			case 8186:{cid = 8187;}// file: 35
			case 8187:{cid = 8188;}// file: 35
			case 8188:{cid = 8189;}// file: 35
			case 8189:{cid = 8194;}// file: 35
			case 8194:{cid = 8206;}// file: 35
			case 8206:{cid = 8207;}// file: 35
			case 8207:{cid = 8208;}// file: 35
			case 8208:{cid = 8209;}// file: 35
			case 8209:{cid = 8210;}// file: 35
			case 8210:{cid = 8229;}// file: 35
			case 8229:{cid = 8262;}// file: 35
			case 8262:{cid = 8263;}// file: 35
			case 8263:{cid = 8311;}// file: 35
			case 8311:{cid = 8313;}// file: 35
			case 8313:{cid = 8314;}// file: 35
			case 8314:{cid = 8315;}// file: 35
			case 8315:{cid = 8320;}// file: 35
			case 8320:{cid = 8342;}// file: 35
			case 8342:{cid = 8369;}// file: 35
			case 8369:{cid = 8416;}// file: 35
			case 8416:{cid = 8481;}// file: 35
			case 8481:{cid = 8549;}// file: 35
			case 8549:{cid = 8556;}// file: 35
			case 8556:{cid = 8559;}// file: 35
			case 8559:{cid = 8645;}// file: 35
			case 8645:{cid = 8646;}// file: 35
			case 8646:{cid = 8647;}// file: 35
			case 8647:{cid = 8648;}// file: 35
			case 8648:{cid = 8649;}// file: 35
			case 8649:{cid = 8650;}// file: 35
			case 8650:{cid = 8651;}// file: 35
			case 8651:{cid = 8652;}// file: 35
			case 8652:{cid = 8653;}// file: 35
			case 8653:{cid = 8656;}// file: 35
			case 8656:{cid = 8657;}// file: 35
			case 8657:{cid = 8658;}// file: 35
			case 8658:{cid = 8659;}// file: 35
			case 8659:{cid = 8662;}// file: 35
			case 8662:{cid = 8673;}// file: 35
			case 8673:{cid = 8674;}// file: 35
			case 8674:{cid = 8680;}// file: 35
			case 8680:{cid = 8681;}// file: 35
			case 8681:{cid = 8682;}// file: 35
			case 8682:{cid = 8683;}// file: 35
			case 8683:{cid = 8684;}// file: 35
			case 8684:{cid = 8685;}// file: 35
			case 8685:{cid = 8686;}// file: 35
			case 8686:{cid = 8869;}// file: 35
			case 8869:{cid = 8871;}// file: 35
			case 8871:{cid = 9029;}// file: 35
			case 9029:{cid = 9030;}// file: 35
			case 9030:{cid = 9031;}// file: 35
			case 9031:{cid = 9032;}// file: 35
			case 9032:{cid = 9033;}// file: 35
			case 9033:{cid = 9041;}// file: 35
			case 9041:{cid = 9292;}// file: 35
			case 9292:{cid = 9293;}// file: 35
			case 9293:{cid = 9294;}// file: 35
			case 9294:{cid = 9295;}// file: 35
			case 9295:{cid = 9296;}// file: 35
			case 9296:{cid = 9297;}// file: 35
			case 9297:{cid = 9298;}// file: 35
			case 9298:{cid = 9330;}// file: 35
			case 9330:{cid = 9332;}// file: 35
			case 9332:{cid = 9337;}// file: 35
			case 9337:{cid = 9339;}// file: 35
			case 9339:{cid = 9340;}// file: 35
			case 9340:{cid = 9343;}// file: 35
			case 9343:{cid = 9349;}// file: 35
			case 9349:{cid = 9482;}// file: 35
			case 9482:{cid = 9608;}// file: 35
			case 9608:{cid = 9893;}// file: 35
			case 9893:{cid = 10252;}// file: 35
			case 10252:{cid = 10396;}// file: 35
			case 10396:{cid = 10402;}// file: 35
			case 10402:{cid = 10437;}// file: 35
			case 10437:{cid = 10442;}// file: 35
			case 10442:{cid = 10611;}// file: 35
			case 10611:{cid = 10682;}// file: 35
			case 10682:{cid = 10683;}// file: 35
			case 10683:{cid = 10806;}// file: 35
			case 10806:{cid = 10807;}// file: 35
			case 10807:{cid = 10808;}// file: 35
			case 10808:{cid = 10809;}// file: 35
			case 10809:{cid = 10835;}// file: 35
			case 10835:{cid = 10836;}// file: 35
			case 10836:{cid = 10874;}// file: 35
			case 10874:{cid = 10875;}// file: 35
			case 10875:{cid = 10885;}// file: 35
			case 10885:{cid = 10889;}// file: 35
			case 10889:{cid = 10890;}// file: 35
			case 10890:{cid = 11014;}// file: 35
			case 11014:{cid = 11091;}// file: 35
			case 11091:{cid = 11238;}// file: 35
			case 11238:{cid = 11239;}// file: 35
			case 11239:{cid = 11240;}// file: 35
			case 11240:{cid = 11241;}// file: 35
			case 11241:{cid = 11242;}// file: 35
			case 11242:{cid = 11243;}// file: 35
			case 11243:{cid = 11247;}// file: 35
			case 11247:{cid = 11438;}// file: 35
			case 11438:{cid = 11452;}// file: 35
			case 11452:{cid = 11473;}// file: 35
			case 11473:{cid = 11474;}// file: 35
			case 11474:{cid = 11499;}// file: 35
			case 11499:{cid = 11551;}// file: 35
			case 11551:{cid = 11567;}// file: 35
			case 11567:{cid = 11568;}// file: 35
			case 11568:{cid = 11571;}// file: 35
			case 11571:{cid = 11607;}// file: 35
			case 11607:{cid = 11623;}// file: 35
			case 11623:{cid = 12848;}// file: 35
			case 12848:{cid = 12858;}// file: 35
			case 12858:{cid = 12933;}// file: 35
			case 12933:{cid = 13016;}// file: 35
			case 13016:{cid = 13018;}// file: 35
			case 13018:{cid = 13024;}// file: 35
			case 13024:{cid = 13045;}// file: 35
			case 13045:{cid = 13096;}// file: 35
			case 13096:{cid = 13097;}// file: 35
			case 13097:{cid = 13098;}// file: 35
			case 13098:{cid = 13118;}// file: 35
			case 13118:{cid = 13153;}// file: 35
			case 13153:{cid = 13336;}// file: 35
			case 13336:{cid = 13438;}// file: 35
			case 13438:{cid = 13445;}// file: 35
			case 13445:{cid = 13663;}// file: 35
			case 13663:{cid = 13665;}// file: 35
			case 13665:{cid = 13705;}// file: 35
			case 13705:{cid = 14464;}// file: 35
			case 14464:{cid = 14459;}// file: 35
			case 14459:{cid = 14843;}// file: 35
			case 14843:{cid = 14856;}// file: 35
			case 14856:{cid = 14883;}// file: 35
			case 14883:{cid = 16016;}// file: 35
			case 16016:{cid = 16017;}// file: 35
			case 16017:{cid = 16018;}// file: 35
			case 16018:{cid = 16019;}// file: 35
			case 16019:{cid = 16020;}// file: 35
			case 16020:{cid = 16022;}// file: 35
			case 16022:{cid = 16052;}// file: 35
			case 16052:{cid = 16094;}// file: 35
			case 16094:{cid = 16136;}// file: 35
			case 16136:{cid = 16281;}// file: 35
			case 16281:{cid = 16293;}// file: 35
			case 16293:{cid = 16294;}// file: 35
			case 16294:{cid = 16295;}// file: 35
			case 16295:{cid = 16296;}// file: 35
			case 16296:{cid = 16297;}// file: 35
			case 16297:{cid = 16298;}// file: 35
			case 16298:{cid = 16299;}// file: 35
			case 16299:{cid = 16300;}// file: 35
			case 16300:{cid = 16312;}// file: 35
			case 16312:{cid = 16313;}// file: 35
			case 16313:{cid = 16315;}// file: 35
			case 16315:{cid = 16320;}// file: 35
			case 16320:{cid = 16321;}// file: 35
			case 16321:{cid = 16324;}// file: 35
			case 16324:{cid = 16369;}// file: 35
			case 16369:{cid = 16370;}// file: 35
			case 16370:{cid = 16627;}// file: 35
			case 16627:{cid = 16628;}// file: 35
			case 16628:{cid = 16629;}// file: 35
			case 16629:{cid = 16630;}// file: 35
			case 16630:{cid = 16631;}// file: 35
			case 16631:{cid = 16632;}// file: 35
			case 16632:{cid = 16633;}// file: 35
			case 16633:{cid = 16634;}// file: 35
			case 16634:{cid = 16635;}// file: 35
			case 16635:{cid = 16636;}// file: 35
			case 16636:{cid = 16638;}// file: 35
			case 16638:{cid = 16664;}// file: 35
			case 16664:{cid = 16668;}// file: 35
			case 16668:{cid = 16669;}// file: 35
			case 16669:{cid = 16670;}// file: 35
			case 16670:{cid = 16671;}// file: 35
			case 16671:{cid = 16683;}// file: 35
			case 16683:{cid = 17510;}// file: 35
			case 17510:{cid = 18074;}// file: 35
			case 18074:{cid = 18202;}// file: 35
			case 18202:{cid = 18216;}// file: 35
			case 18216:{cid = 18218;}// file: 35
			case 18218:{cid = 18219;}// file: 35
			case 18219:{cid = 18220;}// file: 35
			case 18220:{cid = 18221;}// file: 35
			case 18221:{cid = 18222;}// file: 35
			case 18222:{cid = 18223;}// file: 35
			case 18223:{cid = 18224;}// file: 35
			case 18224:{cid = 18255;}// file: 35
			case 18255:{cid = 18276;}// file: 35
			case 18276:{cid = 18277;}// file: 35
			case 18277:{cid = 18278;}// file: 35
			case 18278:{cid = 18279;}// file: 35
			case 18279:{cid = 18280;}// file: 35
			case 18280:{cid = 18281;}// file: 35
			case 18281:{cid = 18286;}// file: 35
			case 18286:{cid = 18287;}// file: 35
			case 18287:{cid = 18288;}// file: 35
			case 18288:{cid = 18289;}// file: 35
			case 18289:{cid = 18290;}// file: 35
			case 18290:{cid = 18291;}// file: 35
			case 18291:{cid = 18292;}// file: 35
			case 18292:{cid = 18432;}// file: 35
			case 18432:{cid = 18433;}// file: 35
			case 18433:{cid = 18434;}// file: 35
			case 18434:{cid = 18440;}// file: 35
			case 18440:{cid = 18441;}// file: 35
			case 18441:{cid = 18442;}// file: 35
			case 18442:{cid = 18443;}// file: 35
			case 18443:{cid = 18444;}// file: 35
			case 18444:{cid = 18445;}// file: 35
			case 18445:{cid = 18446;}// file: 35
			case 18446:{cid = 902;}// file: 35
		}
		return cid;
	}
	public PreviousObject(oid){
		new i;
		while (NextObject(i) != oid){
			i = i + 1;
		}
		return i;
	}
	public SelectObject(oid){
		new string[256];
		DestroyPickup(obj);
		obj = CreatePickup(oid,1,x2,y2,z2+100);
		id = oid;
		format(string,255,"~n~~n~~n~~n~~n~Object ID: %d",oid);
		GameTextForPlayer(pid2,string,1000,5);
	}
	public SpawnObject(objectid){
		object = CreateObject(objectid,x2+2,y2+2,z2,0,0,0);
		ob[object] = id;

	}
	public  MoveObj(objectid,direction){
		new Float:x1,Float:y1,Float:z1;
		if (direction == 1){
			GetObjectPos(objectid,x1,y1,z1);
			MoveObject(objectid,x1+(movespeed - (movespeed*0.99)),y1,z1,2);
		}
		else if(direction == 2){
			GetObjectPos(objectid,x1,y1,z1);
			MoveObject(objectid,x1,y1+(movespeed - (movespeed*0.99)),z1,2);

		}
		else if(direction == 3){
			GetObjectPos(objectid,x1,y1,z1);
			MoveObject(objectid,x1,y1,z1+(movespeed - (movespeed*0.99)),2);

		}
		else if (direction == 4){
			GetObjectPos(objectid,x1,y1,z1);
			MoveObject(objectid,x1-(movespeed - (movespeed*0.99)),y1,z1,2);

		}
		else if(direction == 5){
			GetObjectPos(objectid,x1,y1,z1);
			MoveObject(objectid,x1,y1-(movespeed - (movespeed*0.99)),z1,2);

		}
		else if(direction == 6){
			GetObjectPos(objectid,x1,y1,z1);
			MoveObject(objectid,x1,y1,z1-(movespeed - (movespeed*0.99)),2);

		}
		GetObjectPos(objectid,x1,y1,z1);
		printf("OBJECTROTATE: X: %.4f   Y: %.4f   Z: %.4f", x1,y1,z1);
	}
	public GetKeys1(playerid){
		pid2 = playerid;
		pkey[playerid] = SetTimerEx("GetKeys1",600,0,"i",playerid);
		if (keys == 1){
			new key1;
			new key2;
			new key3;
			new oid;
			GetPlayerKeys(playerid,key1,key2,key3);
			if (key3 == KEY_RIGHT){
				oid = NextObject(id);
				SelectObject(oid);
			}
			if (key3 == KEY_LEFT){

				SelectObject(PreviousObject(id));
			}
			if (key1 == KEY_SECONDARY_ATTACK){
				SetCameraBehindPlayer(playerid);
				TogglePlayerControllable(playerid,1);
				SpawnObject(id);
				keys = 2;
				GetKeys3(playerid);
				KillTimer(pkey[playerid]);
				SendClientMessage(playerid,0xFFFFFFAA,"----------------------------------------------------------------------------");
				SendClientMessage(playerid,0xFFFFFFAA,"HINT: Now  you have spawned that object.");
				SendClientMessage(playerid,0xFFFFFFAA,"HINT: You can press SPACE to mod its position.");
				SendClientMessage(playerid,0xFFFFFFAA,"----------------------------------------------------------------------------");
			}
		}}
	public GetKeys2(playerid){
		SetTimerEx("GetKeys2",300,0,"i",playerid);
		if (keys == 1){
			new key1;
			new updown;
			new key3;

			GetPlayerKeys(playerid,key1,updown,key3);
			if (updown == KEY_DOWN){
				SetPlayerCameraPos(playerid,x2+dis+2,y2+dis+2,z2+100);
				SetPlayerCameraLookAt(playerid,x2,y2,z2+100);
				dis = dis + 2;
			}
			if (updown == KEY_UP ){
				SetPlayerCameraPos(playerid,x2+dis-2,y2+dis-2,z2+100);
				SetPlayerCameraLookAt(playerid,x2,y2,z2+100);
				dis = dis - 2;
			}
		}}
	public GetKeys3(playerid){
		SetTimerEx("GetKeys3",200,0,"i",playerid);
		new key1;
		new key2;
		new key3;
		GetPlayerKeys(playerid,key1,key2,key3);
		if (keys == 3){
			if (key1 == KEY_FIRE && key2 == KEY_UP){
				MoveObj(object,1);
			}
			else if (key1 == KEY_FIRE && key2 == KEY_DOWN){
				MoveObj(object,4);
			}
			else if (key1 == KEY_FIRE && key3 == KEY_LEFT){
				MoveObj(object,2);
			}
			else if (key1 == KEY_FIRE && key3 == KEY_RIGHT){
				MoveObj(object,5);
			}
			else if (key1 == KEY_WALK && key2 == KEY_UP){
				MoveObj(object,3);
			}
			else if (key1 == KEY_WALK && key2 == KEY_DOWN){
				MoveObj(object,6);
			}
			else if (key1 == KEY_JUMP && key3 == KEY_LEFT){
				RotateObject(object,1);
			}
			else if (key1 == KEY_JUMP && key3 == KEY_RIGHT){
				RotateObject(object,2);
			}
			else if (key1 == KEY_JUMP && key2 == KEY_DOWN){
				RotateObject(object,3);
			}
			else if (key1 == KEY_JUMP && key2 == KEY_UP){
				RotateObject(object,4);
			}
			else if (key1 == KEY_CROUCH){
				RotateObject(object,5);
			}
			else if (key1 == KEY_LOOK_BEHIND){
				RotateObject(object,6);
			}
			else if (key1 == KEY_SECONDARY_ATTACK){
				GameTextForPlayer(playerid,"~w~Object Position Modifier~n~~r~        DECTIVATED",1000,6);
				TogglePlayerControllable(playerid,1);
				keys = 2;
			}
		}

		else if (keys == 2){
			if (key1 == KEY_SPRINT){
				GameTextForPlayer(playerid,"~w~Object Position Modifier~n~~g~        ACTIVATED",1000,6);
				SendClientMessage(playerid,0xFFFFFFAA,"----------------------------------------------------------------------------");
				SendClientMessage(playerid,0xFFFFFFAA,"HINT: Now you can change the objects position by press CTRL + ARROW KEYS.");
				SendClientMessage(playerid,0xFFFFFFAA,"HINT: You can change the level of the object by pressing ALT + ARROW KEYS.");
				SendClientMessage(playerid,0xFFFFFFAA,"HINT: You can rotate the object by pressing SHIFT + ARROW KEYS.");
				SendClientMessage(playerid,0xFFFFFFAA,"HINT: You can Dectivate Object Position Modifier by pressing ENTER.");
				SendClientMessage(playerid,0xFFFFFFAA,"HINT: Once you have finished editing object position do /osav.");
				SendClientMessage(playerid,0xFFFFFFAA,"----------------------------------------------------------------------------");
				TogglePlayerControllable(playerid,0);
				keys = 3;
			}}

		else if (keys== 4){

		}
	}
	public RotateObject(objectid,type){
		new Float:rx,Float:ry,Float:rz;
		GetObjectRot(objectid,rx,ry,rz);
		if (type == 1){
			SetObjectRot(objectid,rx+1,ry,ry);
		}
		else if(type == 2){
			SetObjectRot(objectid,rx-1,ry,rz);
		}
		else if(type == 3){
			SetObjectRot(objectid,rx,ry+1,rz);
		}
		else if(type == 4){
			SetObjectRot(objectid,rx,ry-1,rz);
		}
		else if(type == 5){
			SetObjectRot(objectid,rx,ry,rz+1);
		}
		else if(type == 6){
			SetObjectRot(objectid,rx,ry,rz-1);
		}
		GetObjectRot(objectid,rx,ry,rz);
		printf("OBJECTROTATE: X: %.4f   Y: %.4f   Z: %.4f", rx,ry,rz);

	}
	public SaveObjects(playerid){
		new Float:x1,Float:y1,Float:z1;
		new Float:rx1,Float:ry1,Float:rz1;
		new string[256];
		new File:hand;
		new q;
		new hr,minn;
		GetPlayerTime(playerid,hr,minn);
		hand = fopen("ObjectPositions.txt",io_append);
		format(string,255,"\r\n//-------------[ Hour: %d | Min: %d ]--------------------",hr,minn);
		fwrite(hand,string);
		for(q = 0; q <= object; q++){
			if (IsValidObject(q)){
				GetObjectPos(q,x1,y1,z1);
				GetObjectRot(q,rx1,ry1,rz1);
				format(string,255,"\r\nCreateObject(%d,%f,%f,%f,%f,%f,%f);",ob[q],x1,y1,z1,rx1,ry1,rz1);
				fwrite(hand,string);
			}}
		fclose(hand);
		SendClientMessage(playerid,0xFFFFFFAA,"HINT: Objects were succesfully saved.");
		SendClientMessage(playerid,0xFFFFFFAA,"----------------------------------------------------------------------------");
		SendClientMessage(playerid,0xFFFFFFAA,"HINT: Now the object positions is saved in file Objectposition.txt.");
		SendClientMessage(playerid,0xFFFFFFAA,"HINT: You can find that file in your scriptfolder directory.");
	SendClientMessage(playerid,0xFFFFFFAA,"----------------------------------------------------------------------------");}
//$ endregion Object-Selector
//$ region carbot
	Float:GetXYInBackOfPlayer(playerid, &Float:x, &Float:y, Float:distance){
		new Float:a;
		GetPlayerPos(playerid, x, y, a);
		if (IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
		else GetPlayerFacingAngle(playerid, a);
		x -= (distance * floatsin(-a, degrees));
		y -= (distance * floatcos(-a, degrees));
		return a;
	}
	Float:GetXYInBackOfObject(objectid, &Float:x, &Float:y, Float:distance){
		new Float:a;
		new Float:xx,Float:yy;
		GetObjectPos(AutomaticCars[objectid], x, y, a);
		GetObjectRot(AutomaticCars[objectid],xx,yy,a);
		x -= (distance * floatsin(-a, degrees));
		y -= (distance * floatcos(-a, degrees));
		return a;
	}
	Float:GetXYInFrontOfObject(objectid, &Float:x, &Float:y, &Float:z, Float:distance){
		new Float:a;
		new Float:xx,Float:yy;
		GetObjectPos(AutomaticCars[objectid], x, y, z);
		GetObjectRot(AutomaticCars[objectid],xx,yy,a);
		x += (distance * floatsin(a, degrees));
		y += (distance * floatcos(a, degrees));
		z += (distance * floatcos(a, degrees));
		return a;
	}
	public ObjectToObjectUpdate(){
		for(new i=0; i<CAR_AMOUNT_USED; i++)
		{
			new Float:x,Float:y,Float:z,Float:x3,Float:y3/*,Float:z2*/;
			GetXYInBackOfObject(i,x3,y3,15.0);
			for(new j=0;j<CAR_AMOUNT_USED;j++)
			{
				if(Freezed[i] > 0)
				{
					GetObjectPos(AutomaticCars[j],x,y,z);
					if(GetPointDistanceToPoint(x,y,x3,y3) < 5 && (floatabs(BotAngle[j] - BotAngle[i]) < 50 || floatabs(BotAngle[j] - BotAngle[i]) > 310) && !ObjectHasFreezed[j][i] && i!=j)
					{
						if(!ObjectHasFreezed[i][j])
						{
							StopObject(AutomaticCars[j]);
							ObjectHasFreezed[i][j] = true;
							Freezed[j]++;
							j=0;
						}
					}
				}
				else {
					if(ObjectHasFreezed[i][j])
					{
						Freezed[j]--;
						if(Freezed[j] < 0) Freezed[j] = 0;
						if(Freezed[j] == 0)
						{
							if(KMH[LastCarPosition[j]] != 0.00000)
							MoveObject(AutomaticCars[j],DrivePoints[CarPosition[j]][0],
							DrivePoints[CarPosition[j]][1],
							DrivePoints[CarPosition[j]][2],
							KMH[LastCarPosition[j]]);
							else
	    					MoveObject(AutomaticCars[j],DrivePoints[CarPosition[j]][0],
							DrivePoints[CarPosition[j]][1],
							DrivePoints[CarPosition[j]][2],
							15.0);
							//END IF
						}
						ObjectHasFreezed[i][j] = false;
					}
				}
			}
		}
	}
	public ObjectUpdate(){
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				new Float:x,Float:y,Float:z,Float:x3,Float:y3,Float:z3;

				new Vi;
				Vi=GetPlayerVehicleID(i);
				new Float:vang;
				if(IsPlayerInAnyVehicle(i)) GetVehicleZAngle(Vi,vang);
				for(new j=0;j<CAR_AMOUNT_USED;j++)
				{
					GetXYInFrontOfObject(j,x3,y3,z3,1.0);
					GetObjectPos(AutomaticCars[j],x,y,z);
					if(GetPlayerDistanceToPointEx(i,x3,y3,z3) < 8)
					{
						if(!HasFreezed[i][j])
						{
							StopObject(AutomaticCars[j]);
							HasFreezed[i][j] = true;
							Freezed[j]++;
							PlayerPlaySound(i,1147,x,y,z);
							new ran = random(6);
							if(ran == 0)
				    		SendClientMessage(i,COLOR_BLUE,"***Car Bot: Drive, you idiot!");
							else if(ran == 1)
				    	    SendClientMessage(i,COLOR_BLUE,"***Car Bot: What are you waiting for?!?");
							else if(ran == 2)
				    	    SendClientMessage(i,COLOR_BLUE,"***Car Bot: Standing... I hate standing!!!");
							else if(ran == 3)
				    	    SendClientMessage(i,COLOR_BLUE,"***Car Bot: If you've found the 'W' Button let me know...");
							else if(ran == 4)
				    	    SendClientMessage(i,COLOR_BLUE,"***Car Bot: Mooove, MOOOVE!!!");
							else if(ran == 5)
				    	    SendClientMessage(i,COLOR_BLUE,"***Car Bot: Sunday Driver!!!");
							//END IF
							SetTimerEx("Horn",500,0,"t",i);
						}
					}
					else {
						if(HasFreezed[i][j])
						{
							Freezed[j]--;
							if(Freezed[j] < 0) Freezed[j] = 0;
							if(Freezed[j] == 0)
							{
								if(KMH[LastCarPosition[j]] != 0.00000)
								MoveObject(AutomaticCars[j],DrivePoints[CarPosition[j]][0],
								DrivePoints[CarPosition[j]][1],
								DrivePoints[CarPosition[j]][2],
								KMH[LastCarPosition[j]]);
								else
	    						MoveObject(AutomaticCars[j],DrivePoints[CarPosition[j]][0],DrivePoints[CarPosition[j]][1],DrivePoints[CarPosition[j]][2],15.0);
								//END IF
							}
							HasFreezed[i][j] = false;
						}
					}
				}
				SavePlayerPosCbot[i][LastX] = x3;
				SavePlayerPosCbot[i][LastY] = y3;
				SavePlayerPosCbot[i][LastZ] = z3;
			}
		}
	}
	public Horn(playerid){
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		PlayerPlaySound(playerid,1147,x,y,z);
	}
	public OnObjectMoved(objectid){
		new bool:IsObjectBot;
		new i;
		for(i=0;i<CAR_AMOUNT_USED;i++)
		{
			if(objectid == AutomaticCars[i])
			{
				if(calculations)
				{
					format(tmpstring,sizeof(tmpstring),"Object Moved: ~g~%d",i);
					GameTextForAll(tmpstring,5000,6);
				}
				IsObjectBot = true;
				break;
			}
		}

		if(IsObjectBot)
		{
			//STM("TEST");
			new aim;
			if(IsNoCrossway(CarPosition[i]))
			{
				aim = Connections[CarPosition[i]][0];
				LastCarPosition[i] = CarPosition[i];
				CarPosition[i] = aim;}

			else aim = ChooseAim(i,CarPosition[i]);
			if(Connections[LastCarPosition[i]][0] == 0) aim = 1;
			//STM(str(aim));
			new Float:ang;
			new Float:x,Float:y,Float:lx,Float:ly;
			new Float:xdiff,Float:ydiff;
			x = DrivePoints[aim][0];
			y = DrivePoints[aim][1];
			lx = DrivePoints[LastCarPosition[i]][0];
			ly = DrivePoints[LastCarPosition[i]][1];
			xdiff = floatabs(x) - floatabs(lx);
			ydiff = floatabs(y) - floatabs(ly);
			new eins;
			new winkel;
			if(xdiff >= 0 && ydiff >= 0){
				winkel = 0;
				eins = -1;}
			else if(xdiff <= 0 && ydiff >= 0){
				winkel = 0;
				eins = 1;}
			else if(xdiff >= 0 && ydiff <= 0){
				winkel = 180;
				eins = 1;}
			else if(xdiff <= 0 && ydiff <= 0){
				winkel = 180;
				eins = -1;}

			if(floatabs(ydiff) == 0) ydiff = 1;
			new Float:divi = floatdiv(floatabs(xdiff),floatabs(ydiff));
			if(divi > 2) divi = 2;

			ang = winkel + (floatmul(45,divi) * eins);
			BotAngle[i] = floatround(ang);
			SetObjectRot(objectid,0.0,0.0,ang);
			if(KMH[LastCarPosition[i]] != 0.00000)
			{
				MoveObject(objectid,DrivePoints[aim][0],DrivePoints[aim][1],DrivePoints[aim][2],KMH[LastCarPosition[i]]);
			}
			else {
				MoveObject(objectid,DrivePoints[aim][0],DrivePoints[aim][1],DrivePoints[aim][2],15.0);
			}
			CarPosition[i] = aim;
		}
		return 1;
	}
	stock PositionsWechsel(i){
		new Float:x,Float:y,Float:z;
		GetPlayerPos(i, x, y, z);
		if(floatabs(floatabs(SavePlayerPosCbot[i][LastX]) - floatabs(x)) + floatabs(floatabs(SavePlayerPosCbot[i][LastY]) - floatabs(y)) > 10) return 1;
		return 0;
	}
	stock GetPointDistanceToPoint(Float:x,Float:y,Float:x3,Float:y3) {
		new Float:tmpdis;
		tmpdis = floatsqroot(floatpower(floatabs(floatsub(x,x3)),2)+floatpower(floatabs(floatsub(y,y3)),2));
		return floatround(tmpdis);
	}
	stock IsNoCrossway(Drivepoint){
		return (ConnectionsAmount[Drivepoint] > 1) ? 0 : 1;
	}
	stock ChooseAim(oid,Drivepoint){
		new zufall = Connections[Drivepoint][random(ConnectionsAmount[Drivepoint])];
		LastCarPosition[oid] = CarPosition[oid];
		CarPosition[oid] = zufall;
		return zufall;
	}
	stock CorrectAmount(playerid,&anzahl){
		new oid = CreateObject(3593,0.0,0.0,1000.0,0.0,0.0,0.0); //Normal:3593 //Walton:12957 //Kuh: 16442
		DestroyObject(oid);
		if(oid + anzahl > 145)
		{
			anzahl = 145 - oid;
			SendClientMessage(playerid,COLOR_RED,"Attention! You've created too much Car Bots. The amount has been automatically decreased.");
			SendClientMessage(playerid,COLOR_RED,"The amount of the bots + your other server objects mustn't be above 150");
		}
	}

//$ endregion carbot
//$ region Zombie mod
	fire(playerid,STAT){
		new tmp[250];
		new  weap = GetPlayerWeapon(playerid);
		format(tmp,sizeof(tmp),"ARMA ID : %d ", weap);
		SendClientMessageToAll(0xFFFF00AA,tmp);
		if (!weapL[weap][allow])
		{

			GameTextForPlayer(playerid,weapL[weap][mnsg],2000,5);
			return 1;
		}
		if (!weapL[weap][continua] && STAT==HOLD)
		{
			return 1;
		}
		Ticket[playerid]=tickcount()+delay;

		new Float:pX,Float:pY,Float:pZ,Float:pA,Float:PEPE,Float:PIPO;
		new Float:zzX,Float:zzY,Float:zzA;
		GetPlayerPos(playerid,pX,pY,pZ);
		GetPlayerFacingAngle(playerid,pA);
		pZ=pZ+0.7;
		new ran;
		for (new j=0;j<TOTALZombies;j++)
		{
			if (IsValidObject(zombie[j][torso]))
			{
				GetObjectPos(zombie[j][head],oX,oY,oZ);
				zzX=oX-pX;zzY=oY-pY;zzA=atan2(zzX,zzY);if(zzA>0)zzA-=360.0;
			}
			if (zombie[j][undead]&&(floatsqroot(floatpower(zzX,2)+floatpower(zzY,2)))<weapL[weap][range] && (floatabs(zzA+pA)<weapL[weap][wide]))
			{
				oZ-=1.7;
				zombie[j][HP]-= random(weapL[weap][damageMax]-weapL[weap][damageMin])+weapL[weap][damageMin];
				GameTextForPlayer(playerid,weapL[weap][mnsg],delay-100,5);
				PEPE = floatsin((zombie[j][angulo]*3.14159/180.0));
				PIPO = floatcos((zombie[j][angulo]*3.14159/180.0));
/*			if (weapL[weap][cutting] || weapL[weap][instaGib])
			{
				ran = random (30);
			    if (ran < 5)
			    {
			        zombie[j][undead]=false;
			        NOFZombies--;
	   				if (apocalipsis)
					{
						format(tmp,sizeof(tmp),"~w~SCORE~n~~r~Zombies~w~: %d ~n~~b~Humans~w~: %d ~y~+1",scorez,scorep);
						scorep++;
						GameTextForAll(tmp,2000,4);
						SetTimer("CreateRandomZombie",10000,0);
						attacknearest();
					}
					Z+=1.7;
					DestroyObject(zombie[j][head]);
	                StopObject(zombie[j][torso]);
	     			if (zombie[j][pedazos] & brazo1)
					MoveObject(zombie[j][rArm],X+zombie1[rArmZ][RelX]*PIPO+PEPE*zombie2[rArmZ][RelX],Y+zombie1[rArmZ][RelY]*PIPO+PEPE*zombie2[rArmZ][RelY],Z-0.253135,100.0);
					if (zombie[j][pedazos] & brazo2)
					MoveObject(zombie[j][lArm],X+zombie1[lArmZ][RelX]*PIPO+PEPE*zombie2[lArmZ][RelX],Y+zombie1[lArmZ][RelY]*PIPO+PEPE*zombie2[lArmZ][RelY],Z-0.265793,100.0);
					if (zombie[j][pedazos] & pierna1)
					MoveObject(zombie[j][rLeg],X+zombie1[rLegZ][RelX]*PIPO+PEPE*zombie2[rLegZ][RelX],Y+zombie1[rLegZ][RelY]*PIPO+PEPE*zombie2[rLegZ][RelY],Z+zombie1[rLegZ][RelZ],100.0);
	                if (zombie[j][pedazos] & pierna2)
					MoveObject(zombie[j][lLeg],X+zombie1[lLegZ][RelX]*PIPO+PEPE*zombie2[lLegZ][RelX],Y+zombie1[lLegZ][RelY]*PIPO+PEPE*zombie2[lLegZ][RelY],Z+zombie1[lLegZ][RelZ],100.0);
					NOFZombies--;
					Z-=1.7;
			    }

			    else
*/
		if (weapL[weap][cutting])
					{
					if  ((zombie[j][pedazos] & brazo1) || (zombie[j][pedazos] & brazo2))
					{
						if (ran < 20)
						{
							if (( ran < 10 || !(zombie[j][pedazos] & brazo2)) && (zombie[j][pedazos] & brazo1))
							{
								zombie[j][pedazos]-=brazo1;MoveObject(zombie[j][rArm],oX+zombie1[rArmZ][RelX]*PIPO+PEPE*zombie2[rArmZ][RelX],oY+zombie1[rArmZ][RelY]*PIPO+PEPE*zombie2[rArmZ][RelY],oZ,1.0);
							}
							else
							{
								zombie[j][pedazos]-=brazo2;MoveObject(zombie[j][lArm],oX+zombie1[lArmZ][RelX]*PIPO+PEPE*zombie2[lArmZ][RelX],oY+zombie1[lArmZ][RelY]*PIPO+PEPE*zombie2[lArmZ][RelY],oZ,1.0);
							}
						}
					}
					else if  (zombie[j][HP]<40 && (zombie[j][pedazos] & pierna1 ) && (zombie[j][pedazos] & pierna2))
					{
						if (ran < 15){zombie[j][pedazos]-=pierna1;MoveObject(zombie[j][rLeg],oX+zombie1[rLegZ][RelX]*PIPO+PEPE*zombie2[rLegZ][RelX],oY+zombie1[rLegZ][RelY]*PIPO+PEPE*zombie2[rLegZ][RelY],oZ,1.0);}
						else{zombie[j][pedazos]-=pierna2;MoveObject(zombie[j][lLeg],oX+zombie1[lLegZ][RelX]*PIPO+PEPE*zombie2[lLegZ][RelX],oY+zombie1[lLegZ][RelY]*PIPO+PEPE*zombie2[lLegZ][RelY],oZ,1.0);}
						zombie[j][speed]-=float(40);
					}
					//			}
				}
				if (zombie[j][HP]<0 && zombie[j][undead])
				{
					zombie[j][undead]=false;
					NOFZombies--;
					MoveObject(zombie[j][head],oX,oY,oZ,1.5);
					MoveObject(zombie[j][torso],oX+zombie1[torsoZ][RelX]*PIPO+PEPE*zombie2[torsoZ][RelX],oY+zombie1[torsoZ][RelY]*PIPO+PEPE*zombie2[torsoZ][RelY],oZ+0.4,1.5);
					if (zombie[j][pedazos] & brazo1)
					MoveObject(zombie[j][rArm],oX+zombie1[rArmZ][RelX]*PIPO+PEPE*zombie2[rArmZ][RelX],oY+zombie1[rArmZ][RelY]*PIPO+PEPE*zombie2[rArmZ][RelY],oZ,1.5);
					if (zombie[j][pedazos] & brazo2)
					MoveObject(zombie[j][lArm],oX+zombie1[lArmZ][RelX]*PIPO+PEPE*zombie2[lArmZ][RelX],oY+zombie1[lArmZ][RelY]*PIPO+PEPE*zombie2[lArmZ][RelY],oZ,1.5);
					if (zombie[j][pedazos] & pierna1)
					StopObject(zombie[j][rLeg]);
					if (zombie[j][pedazos] & pierna2)
					StopObject(zombie[j][lLeg]);
					if (apocalipsis)
					{
						format(tmp,sizeof(tmp),"~w~SCORE~n~~r~Zombies~w~: %d ~n~~b~Humans~w~: %d ~y~+1",scorez,scorep);
						scorep++;
						GameTextForAll(tmp,2000,4);
						ran = random(10);
						SetTimer("CreateRandomZombie",ran*1000,0);
						attacknearest();
					}
				}
			}
		}
		return 1;
	}
	public HoldingFire(){
		new keys1,updown,leftright;
		for (new i=0;i<MAX_PLAYERS;i++)
		{
			if (IsPlayerConnected(i))
			{
				GetPlayerKeys(i,keys1,updown,leftright);
				if ((keys1 & KEY_FIRE)&&(!IsPlayerInAnyVehicle(i))&&(Ticket[i]<tickcount()))
				{
					fire(i,HOLD);
				}
			}
		}
	}
	public CreateRandomZombie(){
		new playerid = random(MAX_PLAYERS);
		while (!IsPlayerConnected(playerid)&&GetPlayerInterior(playerid)==0)playerid = random(MAX_PLAYERS);
		new Float:pX,Float:pY,Float:pZ,Float:Ang;
		GetPlayerPos(playerid,pX,pY,pZ);
		Ang=float(random(360));
		pX=pX+50.0*floatsin(Ang,degrees);
		pY=pY+50.0*floatcos(Ang,degrees);
		pZ=pZ+0.7;
		CrearZombie(pX,pY,pZ,Ang);
	}
	public QuitarArmasZombie(playerid){
		LastWeaponUsed[playerid]=GetPlayerWeapon(playerid);GetPlayerWeapon(playerid);
		new WeaponId;
		new ammo;
		for (new i=0;i<11;i++)
		{
			GetPlayerWeaponData(playerid, i, WeaponId, ammo);
			WeaponList[playerid][i][pWeapId]=WeaponId;
			WeaponList[playerid][i][pAmmo]=ammo;
		}
		ResetPlayerWeapons(playerid);
		return 1;
	}
	public DevolverArmasZombie(playerid){
		new index;
		for (new i=0;i<11;i++)
		{
			if      (WeaponList[playerid][i][pWeapId]!=0)
			{
				if  (WeaponList[playerid][i][pWeapId]!=LastWeaponUsed[playerid])
				{
					GivePlayerWeapon(playerid,WeaponList[playerid][i][pWeapId],WeaponList[playerid][i][pAmmo]);
				}
				else
				{
					index=i;
				}
			}
		}
		GivePlayerWeapon(playerid,WeaponList[playerid][index][pWeapId],WeaponList[playerid][index][pAmmo]);
		return 1;
	}
	public attacknearest(){
		new Float:pX,Float:pY,Float:pZ;
		new Float:distNew,Float:distOld;
		new candidato;
		for (new j=0;j<TOTALZombies;j++)
		{
			if (zombie[j][undead])
			{
				distOld=9999.9;
				candidato=-1;
				GetObjectPos(zombie[j][head],oX,oY,oZ);
				for(new i=0;i<MAX_PLAYERS;i++)
				{
					if(IsPlayerConnected(i))
					{
						GetPlayerPos(i,pX,pY,pZ);
						distNew = floatabs(pX-oX) + floatabs(pY-oY);
						if (distNew<distOld)
						{
							distOld = distNew;
							candidato = i;
						}
					}
				}
				if (distOld>100.0)
				{
					DestroyObject(zombie[j][head]);
					DestroyObject(zombie[j][rLeg]);
					DestroyObject(zombie[j][lLeg]);
					DestroyObject(zombie[j][rArm]);
					DestroyObject(zombie[j][lArm]);
					DestroyObject(zombie[j][torso]);
					NOFZombies--;
					zombie[j][undead]=false;
					SetTimer("CreateRandomZombie",1000,0);
				}
				zombie[j][target]=candidato;
			}
		}
	}
	cleanZombies(){
		for (new j=0;j<TOTALZombies;j++)
		{
			zombie[j][undead]=false;
			if (IsValidObject(zombie[j][torso]))DestroyObject(zombie[j][torso]);
			if (IsValidObject(zombie[j][head]))	DestroyObject(zombie[j][head]);
			if (IsValidObject(zombie[j][rLeg]))	DestroyObject(zombie[j][rLeg]);
			if (IsValidObject(zombie[j][lLeg]))	DestroyObject(zombie[j][lLeg]);
			if (IsValidObject(zombie[j][rArm]))	DestroyObject(zombie[j][rArm]);
			if (IsValidObject(zombie[j][lArm]))	DestroyObject(zombie[j][lArm]);
			NOFZombies--;
		}
		if (TimerAPO!=-1){KillTimer(TimerAPO);}
		if (TimerAtaca!=-1){KillTimer(TimerAtaca);}
	}
	CrearZombie(Float:pX,Float:pY,Float:pZ,Float:angle){
		new Float:PEPE = floatsin((angle*3.14159/180.0));
		new Float:PIPO = floatcos((angle*3.14159/180.0));
		if (NOFZombies<TOTALZombies)
		{
			new j=0;
			while ((zombie[j][undead])){j++;}
			if (IsValidObject(zombie[j][torso]))
			{
				DestroyObject(zombie[j][head]);
				DestroyObject(zombie[j][rLeg]);
				DestroyObject(zombie[j][lLeg]);
				DestroyObject(zombie[j][rArm]);
				DestroyObject(zombie[j][lArm]);
				DestroyObject(zombie[j][torso]);
			}
			zombie[j][head]=CreateObject(zombie1[headZ][partModel],pX,pY,pZ,zombie1[headZ][RelrX],zombie1[headZ][RelrY],angle);
			zombie[j][torso]=CreateObject(zombie1[torsoZ][partModel],pX+zombie1[torsoZ][RelX]*PIPO+PEPE*zombie2[torsoZ][RelX],pY+zombie1[torsoZ][RelY]*PIPO+PEPE*zombie2[torsoZ][RelY],pZ+zombie1[torsoZ][RelZ],zombie1[torsoZ][RelrX],zombie1[torsoZ][RelrY],angle);
			zombie[j][lArm]=CreateObject(zombie1[lArmZ][partModel],pX+zombie1[lArmZ][RelX]*PIPO+PEPE*zombie2[lArmZ][RelX],pY+zombie1[lArmZ][RelY]*PIPO+PEPE*zombie2[lArmZ][RelY],pZ+zombie1[lArmZ][RelZ],zombie1[lArmZ][RelrX],zombie1[lArmZ][RelrY],angle);
			zombie[j][rArm]=CreateObject(zombie1[rArmZ][partModel],pX+zombie1[rArmZ][RelX]*PIPO+PEPE*zombie2[rArmZ][RelX],pY+zombie1[rArmZ][RelY]*PIPO+PEPE*zombie2[rArmZ][RelY],pZ+zombie1[rArmZ][RelZ],zombie1[rArmZ][RelrX],zombie1[rArmZ][RelrY],angle);
			zombie[j][rLeg]=CreateObject(zombie1[rLegZ][partModel],pX+zombie1[rLegZ][RelX]*PIPO+PEPE*zombie2[rLegZ][RelX],pY+zombie1[rLegZ][RelY]*PIPO+PEPE*zombie2[rLegZ][RelY],pZ+zombie1[rLegZ][RelZ],zombie1[rLegZ][RelrX],zombie1[rLegZ][RelrY],angle);
			zombie[j][lLeg]=CreateObject(zombie1[lLegZ][partModel],pX+zombie1[lLegZ][RelX]*PIPO+PEPE*zombie2[lLegZ][RelX],pY+zombie1[lLegZ][RelY]*PIPO+PEPE*zombie2[lLegZ][RelY],pZ+zombie1[lLegZ][RelZ],zombie1[lLegZ][RelrX],zombie1[lLegZ][RelrY],angle);

			zombie[j][LegsH]=true;
			zombie[j][speed]=random(100)+50;
			zombie[j][ArmAngle]=0;
			zombie[j][ArmStatus]=random(5)+5;
			zombie[j][undead]=true;
			zombie[j][HP]=100;
			zombie[j][pedazos]= brazo1 + brazo2 + pierna1 + pierna2;
			zombie[j][angulo]=angle;
			NOFZombies++;
		}
		return 1;
	}
	public zombieAtaca(){
		new Float:pX,Float:pY,Float:pZ,Float:angle,Float:PEPE,Float:PIPO,Float:AA1,Float:AA2,Float:H;
		new vehicleStatus;
		if (NOFZombies<1 && !apocalipsis)
		{
			if (TimerAPO!=-1){KillTimer(TimerAPO);}
			if (TimerAtaca!=-1){KillTimer(TimerAtaca);}
		}
		HoldingFire();
		for (new j=0;j<TOTALZombies;j++)
		{
			if(zombie[j][undead]&&IsPlayerConnected(zombie[j][target]) && GetPlayerInterior(zombie[j][target])==0)
			{
				vehicleStatus = IsPlayerInAnyVehicle(zombie[j][target]);
				GetPlayerPos(zombie[j][target],pX,pY,pZ);
				pZ+=0.7;
				GetObjectPos(zombie[j][head],oX,oY,oZ);
				angle = 180.0-atan2(oX-pX,oY-pY);
				angle+=vaiven;
				vaiven*=-1;
				PEPE = floatsin((angle*3.14159/180.0));
				PIPO = floatcos((angle*3.14159/180.0));
				zombie[j][angulo]=angle;
				if(floatabs(zombie[j][ArmAngle])>10.0){zombie[j][ArmStatus]*=-1;}
				zombie[j][ArmAngle]+=zombie[j][ArmStatus];

				zombie[j][LegsH]=!zombie[j][LegsH];

				AA1 = floatcos(zombie[j][ArmAngle]*3.14159/180.0);
				AA2 = floatsin(zombie[j][ArmAngle]*3.14159/180.0);

				if ((pZ-oZ)>3.0)
				{
					oZ+=1.0;
				}
				else if((pZ-oZ)<-3.0)
				{
					oZ-=1.0;
				}
				//we destroy the old zombi
				DestroyObject(zombie[j][torso]);
				DestroyObject(zombie[j][head]);
				if (zombie[j][pedazos] & brazo1) DestroyObject(zombie[j][rArm]);
				if (zombie[j][pedazos] & brazo2) DestroyObject(zombie[j][lArm]);
				if (zombie[j][pedazos] & pierna1) DestroyObject(zombie[j][rLeg]);
				if (zombie[j][pedazos] & pierna2) DestroyObject(zombie[j][lLeg]);

				//we recreate the zombie
				zombie[j][head]=CreateObject(zombie1[headZ][partModel],oX,oY,pZ,zombie1[headZ][RelrX],zombie1[headZ][RelrY],angle+vaiven);
				zombie[j][torso]=CreateObject(zombie1[torsoZ][partModel],oX+zombie1[torsoZ][RelX]*PIPO+PEPE*zombie2[torsoZ][RelX],oY+zombie1[torsoZ][RelY]*PIPO+PEPE*zombie2[torsoZ][RelY],pZ+zombie1[torsoZ][RelZ],zombie1[torsoZ][RelrX],zombie1[torsoZ][RelrY],angle);
				if (zombie[j][pedazos] & brazo1)
				zombie[j][rArm]=CreateObject(zombie1[rArmZ][partModel],oX+zombie1[rArmZ][RelX]*PIPO+PEPE*zombie2[rArmZ][RelX],oY+zombie1[rArmZ][RelY]*PIPO+PEPE*zombie2[rArmZ][RelY],pZ+A1[der][AZ]*AA1+AA2*A2[der][AZ],(-1)*zombie[j][ArmAngle],zombie1[rArmZ][RelrY],angle);
				if (zombie[j][pedazos] & brazo2)
				zombie[j][lArm]=CreateObject(zombie1[lArmZ][partModel],oX+zombie1[lArmZ][RelX]*PIPO+PEPE*zombie2[lArmZ][RelX],oY+zombie1[lArmZ][RelY]*PIPO+PEPE*zombie2[lArmZ][RelY],pZ+A1[izq][AZ]*AA1-AA2*A2[izq][AZ],zombie[j][ArmAngle],zombie1[lArmZ][RelrY],angle);
				if (zombie[j][pedazos] & pierna1)
				zombie[j][rLeg]=CreateObject(zombie1[rLegZ][partModel],oX+zombie1[rLegZ][RelX]*PIPO+PEPE*zombie2[rLegZ][RelX],oY+zombie1[rLegZ][RelY]*PIPO+PEPE*zombie2[rLegZ][RelY],pZ+zombie1[rLegZ][RelZ]+float(zombie[j][LegsH])*0.2,zombie1[rLegZ][RelrX],zombie1[rLegZ][RelrY],angle);

				if (zombie[j][pedazos] & pierna2)
				zombie[j][lLeg]=CreateObject(zombie1[lLegZ][partModel],oX+zombie1[lLegZ][RelX]*PIPO+PEPE*zombie2[lLegZ][RelX],oY+zombie1[lLegZ][RelY]*PIPO+PEPE*zombie2[lLegZ][RelY],pZ+zombie1[lLegZ][RelZ]+float(!zombie[j][LegsH])*0.2,zombie1[lLegZ][RelrX],zombie1[lLegZ][RelrY],angle);

				if ( (floatabs(pX-oX) + floatabs(pY-oY) + floatabs(pZ-oZ) )>(2.0+6.0*vehicleStatus))//The zombie will move to your position to eat you because if you are too far away
				{
					MoveObject(zombie[j][head],pX,pY,pZ,zombie[j][speed]*0.01*Zspeed);
					MoveObject(zombie[j][torso],pX+zombie1[torsoZ][RelX]*PIPO+PEPE*zombie2[torsoZ][RelX],pY+zombie1[torsoZ][RelY]*PIPO+PEPE*zombie2[torsoZ][RelY],pZ+zombie1[torsoZ][RelZ],zombie[j][speed]*0.01*Zspeed);
					if (zombie[j][pedazos] & brazo1)
					MoveObject(zombie[j][rArm],pX+zombie1[rArmZ][RelX]*PIPO+PEPE*zombie2[rArmZ][RelX],pY+zombie1[rArmZ][RelY]*PIPO+PEPE*zombie2[rArmZ][RelY],pZ+A1[der][AZ]*AA1+AA2*A2[der][AZ],zombie[j][speed]*0.01*Zspeed);
					if (zombie[j][pedazos] & brazo2)
					MoveObject(zombie[j][lArm],pX+zombie1[lArmZ][RelX]*PIPO+PEPE*zombie2[lArmZ][RelX],pY+zombie1[lArmZ][RelY]*PIPO+PEPE*zombie2[lArmZ][RelY],pZ+A1[izq][AZ]*AA1-AA2*A2[izq][AZ],zombie[j][speed]*0.01*Zspeed);
					if (zombie[j][pedazos] & pierna1)
					MoveObject(zombie[j][rLeg],pX+zombie1[rLegZ][RelX]*PIPO+PEPE*zombie2[rLegZ][RelX],pY+zombie1[rLegZ][RelY]*PIPO+PEPE*zombie2[rLegZ][RelY],pZ+zombie1[rLegZ][RelZ]+float(zombie[j][LegsH])*0.2,zombie[j][speed]*0.01*Zspeed);
					if (zombie[j][pedazos] & pierna2)
					MoveObject(zombie[j][lLeg],pX+zombie1[lLegZ][RelX]*PIPO+PEPE*zombie2[lLegZ][RelX],pY+zombie1[lLegZ][RelY]*PIPO+PEPE*zombie2[lLegZ][RelY],pZ+zombie1[lLegZ][RelZ]+float(!zombie[j][LegsH])*0.2,zombie[j][speed]*0.01*Zspeed);
				}
				else//the zombie EATS you unless you are in a vehicle or you are alredy dead
				{
					StopObject(zombie[j][head]);
					StopObject(zombie[j][torso]);
					StopObject(zombie[j][rArm]);
					StopObject(zombie[j][lArm]);
					StopObject(zombie[j][rLeg]);
					StopObject(zombie[j][lLeg]);
					GetPlayerHealth(zombie[j][target],H);
					if ( !vehicleStatus && !PlayerDeath[zombie[j][target]])
					{
						SetPlayerHealth(zombie[j][target],H-5.0);
					}
				}
			}
		}
		return 1;
	}
//$ endregion Zombie mod
//$ region Streamer
	public InitiateSectorSystem(){
		SetTimer("SectorScan",1000,1);
		LoadCars();
		return 1;
	}
	public SectorScan(){
		for(new i = 0;i<MAX_SLOTS_tAxI;i++) {
			if(IsPlayerConnected(i)) {
				if(pustreamactive == 1) {
					StreamPickups(i);
				}
			}
		}
		CleanupPickups();
	}
	stock GetPointSector(Float:x,Float:y){
		new xsec = floatround(((x +4000) / 500), floatround_floor);
		new ysec = floatround(((y +4000) / 500), floatround_floor);
		return (xsec * 16) + ysec;
	}
//$ region Vehicle-Streamer
public CreateStreamVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2){
	for(new i=0;i<MAX_STREAM_VEHICLES;i++){
	    if(!VehicleInfo[i][CREATED]){
            VehicleInfo[i][CREATED]=true;
            VehicleInfo[i][idnum]=-1;
            VehicleInfo[i][model]=vehicletype;
            VehicleInfo[i][veh_pos][0]=x;
            VehicleInfo[i][veh_pos][1]=y;
            VehicleInfo[i][veh_pos][2]=z;
            VehicleInfo[i][veh_pos][3]=rotation;
            VehicleInfo[i][interior]=0;
            VehicleInfo[i][world]=0;
            VehicleInfo[i][colors][0]=color1;
            VehicleInfo[i][colors][1]=color2;
            VehicleInfo[i][health]=1000;
            VehicleInfo[i][paintjob]=0;
			VehicleInfo[i][numberplate][0]='\0';
			VehicleInfo[i][tank]=5;
			VehicleInfo[i][meters]=0;
			VehicleInfo[i][oilpress]=0;
			VehicleInfo[i][oilminimum]=0;
			VehicleInfo[i][oildamage]=0;
			VehicleInfo[i][locked]=0;
			VehicleInfo[i][security]=0;
			VehicleInfo[i][priority]=0;
			VehicleInfo[i][streamid]=i;
            for(new j=0;j<MAX_COMPONENTS;j++){
                VehicleInfo[i][COMPONENTS][j]=0;}
			if ( i+1>vehcount3 ){
				vehcount3=i+1;
			}
			format(str, sizeof(str), "Car created ! /nStreamid: %d Priority: %d Model: %d Farbe: %d . %d ", VehicleInfo[i][streamid], VehicleInfo[i][priority], VehicleInfo[i][model], VehicleInfo[i][colors][0], VehicleInfo[i][colors][1]);
			SendClientMessageToAll(COLOR_YELLOW, str);
            return i;
	    }
	}
	return 0;
}
public DestroyStreamVehicle(svehicleid){
	new carname[256];
	if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)	{
	    if(VehicleInfo[svehicleid][CREATED])	    {
	        if(VehicleInfo[svehicleid][idnum])	        {
	            DestroyVehicle(VehicleInfo[svehicleid][idnum]);
	            vehcount--;
			}
	        VehicleInfo[svehicleid][CREATED]=false;
			VehicleInfo[svehicleid][model]=0;
			VehicleInfo[svehicleid][veh_pos][0] = 0;
			VehicleInfo[svehicleid][veh_pos][1] = 0;
			VehicleInfo[svehicleid][veh_pos][2] = 0;
			VehicleInfo[svehicleid][veh_pos][3] = 0;
			VehicleInfo[svehicleid][colors][0] = 0;
			VehicleInfo[svehicleid][colors][1] = 0;
			for (new k = 0; k < MAX_COMPONENTS; k++)
			{
				VehicleInfo[svehicleid][COMPONENTS][k] = 0;
			}
			VehicleInfo[svehicleid][paintjob] = 0;
			VehicleInfo[svehicleid][security] = 0;
			VehicleInfo[svehicleid][priority] = 0;
			if ( svehicleid==vehcount3 ){
				do {
					vehcount3--;
				}
				while (!VehicleInfo[vehcount3][CREATED]);
			}
			format(carname,sizeof(carname),"Car%d",svehicleid);
			fremove(carname);
	        return 1;
	    }
	}
	return 0;
}
stock IsAnyPlayerNearStreamVehicle(svehicleid,Float:distance){
	for (new i = 0; i < MAX_PLAYERS; i++){
	    if(PlayerClose(i,VehicleInfo[svehicleid][veh_pos][0],VehicleInfo[svehicleid][veh_pos][1],VehicleInfo[svehicleid][veh_pos][2],distance)|| (IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i)==VehicleInfo[svehicleid][idnum]))
		    return true;

	}
	return false;
}
public LockCar(carid){
	for(new i = 0; i < MAX_PLAYERS; i++){
		if(IsPlayerConnected(i)){
			SetVehicleParamsForPlayer(carid,i,0,1);
		}
	}
}
public UnLockCar(carid){
	for(new i = 0; i < MAX_PLAYERS; i++)	{
		if(IsPlayerConnected(i)){
			if(!IsAPlane(carid)){
				SetVehicleParamsForPlayer(carid,i,0,0);
			}
		}
	}
}
public UnLoadVehicle(svehicleid){
	if(VehicleInfo[svehicleid][idnum]>-1){
		GetVehiclePos(VehicleInfo[svehicleid][idnum],VehicleInfo[svehicleid][veh_pos][0],VehicleInfo[svehicleid][veh_pos][1],VehicleInfo[svehicleid][veh_pos][2]);
		GetVehicleZAngle(VehicleInfo[svehicleid][idnum],VehicleInfo[svehicleid][veh_pos][3]);
		GetVehicleHealth(VehicleInfo[svehicleid][idnum],VehicleInfo[svehicleid][health]);
		DestroyVehicle(VehicleInfo[svehicleid][idnum]);
		VehStreamid[VehicleInfo[svehicleid][idnum]]=-1;
		VehicleInfo[svehicleid][idnum]=-1;
		vehcount--;
		modelcount[VehicleInfo[svehicleid][model]]--;
		if ( modelcount[VehicleInfo[svehicleid][model]]==0 ){
			modelscount--;
		}
		format(str, sizeof(str), "Car onloaded ! /nStreamid: %d Priority: %d Model: %d Farbe: %d / %d ", VehicleInfo[svehicleid][streamid], VehicleInfo[svehicleid][priority], VehicleInfo[svehicleid][model], VehicleInfo[svehicleid][colors][0], VehicleInfo[svehicleid][colors][1]);
		SendClientMessageToAll(COLOR_YELLOW, str);
	}
	return 0;
}
public LoadVehicle(svehicleid){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][idnum]==-1){
            vehcount++;
        	VehicleInfo[svehicleid][idnum]=CreateVehicle(VehicleInfo[svehicleid][model],VehicleInfo[svehicleid][veh_pos][0],VehicleInfo[svehicleid][veh_pos][1],VehicleInfo[svehicleid][veh_pos][2],VehicleInfo[svehicleid][veh_pos][3],VehicleInfo[svehicleid][colors][0],VehicleInfo[svehicleid][colors][1],-1);
			VehStreamid[VehicleInfo[svehicleid][idnum]]=svehicleid;
			SetVehicleHealth(VehicleInfo[svehicleid][idnum],VehicleInfo[svehicleid][health]);
			if(VehicleInfo[svehicleid][paintjob])
			    ChangeVehiclePaintjob(VehicleInfo[svehicleid][idnum],VehicleInfo[svehicleid][paintjob]);
			for(new i=0;i<MAX_COMPONENTS;i++){
			    if(VehicleInfo[svehicleid][COMPONENTS][i]){
			        AddVehicleComponent(VehicleInfo[svehicleid][idnum],VehicleInfo[svehicleid][COMPONENTS][i]);
				}
			}
			SetVehicleVirtualWorld(VehicleInfo[svehicleid][idnum],VehicleInfo[svehicleid][world]);
			LinkVehicleToInterior(VehicleInfo[svehicleid][idnum],VehicleInfo[svehicleid][interior]);
			if(strlen(VehicleInfo[svehicleid][numberplate])){
			    SetVehicleNumberPlate(VehicleInfo[svehicleid][idnum],VehicleInfo[svehicleid][numberplate]);
			}
			for(new i=0;i<MAX_PLAYERS;i++){
			    if(IsPlayerConnected(i)){
			        SetVehicleParamsForPlayer(VehicleInfo[svehicleid][idnum],i,0,VehicleInfo[svehicleid][locked]);
				}
			}
			if ( modelcount[VehicleInfo[svehicleid][model]]==0 ){
				modelscount++;
			}
			modelcount[VehicleInfo[svehicleid][model]]++;
			format(str, sizeof(str), "Car loaded ! /nID: %d Streamid: %d Priority: %d Model: %d Farbe: %d / %d ", VehicleInfo[svehicleid][idnum], VehicleInfo[svehicleid][streamid], VehicleInfo[svehicleid][priority], VehicleInfo[svehicleid][model], VehicleInfo[svehicleid][colors][0], VehicleInfo[svehicleid][colors][1]);
			SendClientMessageToAll(COLOR_YELLOW, str);
			return VehicleInfo[svehicleid][idnum];
		}
	}
	return 0;
}
public SaveCars(){
	for (new i = 0; i < vehcount3; i++){
		if (VehicleInfo[i][CREATED]){
			if(VehicleInfo[i][idnum]>-1){
				GetVehiclePos(VehicleInfo[i][idnum],VehicleInfo[i][veh_pos][0],VehicleInfo[i][veh_pos][1],VehicleInfo[i][veh_pos][2]);
				GetVehicleZAngle(VehicleInfo[i][idnum],VehicleInfo[i][veh_pos][3]);
			}
			new carname[256];
			new modname[256];
			format(carname,sizeof(carname),"Car%d",i);
			if (!dini_Exists(carname)){
				dini_Create(carname);}
			dini_FloatSet(carname,"x",VehicleInfo[i][veh_pos][0]);
			dini_FloatSet(carname,"y",VehicleInfo[i][veh_pos][1]);
			dini_FloatSet(carname,"z",VehicleInfo[i][veh_pos][2]);
			dini_FloatSet(carname,"a",VehicleInfo[i][veh_pos][3]);
			for (new mo = 0; mo < MAX_COMPONENTS; mo++){
				format(modname,sizeof(modname),"mod%d",mo);
				dini_IntSet(carname,modname,VehicleInfo[i][COMPONENTS][mo]);
			}
			dini_IntSet(carname,"paintjob",VehicleInfo[i][paintjob]);
			dini_IntSet(carname,"security",VehicleInfo[i][security]);
			dini_IntSet(carname,"priority",VehicleInfo[i][priority]);
			dini_IntSet(carname,"model",VehicleInfo[i][model]);
			dini_IntSet(carname,"CREATED",VehicleInfo[i][CREATED]);
			dini_Set(carname,"ownername",VehicleInfo[i][owner]);
			dini_IntSet(carname,"ownerid",VehicleInfo[i][ownerid]);
			dini_IntSet(carname,"tank",VehicleInfo[i][tank]);
			dini_IntSet(carname,"meters",VehicleInfo[i][meters]);
			dini_IntSet(carname,"oilpress",VehicleInfo[i][oilpress]);
			dini_IntSet(carname,"oilminimum",VehicleInfo[i][oilminimum]);
			dini_IntSet(carname,"oildamage",VehicleInfo[i][oildamage]);
			dini_IntSet(carname,"locked",VehicleInfo[i][locked]);
			dini_Set(carname,"numberplate",VehicleInfo[i][numberplate]);
			dini_FloatSet(carname,"health",VehicleInfo[i][health]);
			dini_IntSet(carname,"key",VehicleInfo[i][key]);
			dini_IntSet(carname,"world",VehicleInfo[i][world]);
			dini_IntSet(carname,"interior",VehicleInfo[i][interior]);
			dini_IntSet(carname,"color1",VehicleInfo[i][colors][0]);
			dini_IntSet(carname,"color2",VehicleInfo[i][colors][1]);
			dini_IntSet(carname,"streamid",VehicleInfo[i][streamid]);
		}
	}
	return 1;
}
public LoadCars(){
	new carname[256];
	new modname[256];
	for(new n = 0; n < MAX_STREAM_VEHICLES; n++){
		format(carname,sizeof(carname),"Car%d",n);
		if (dini_Exists(carname)){
			VehicleInfo[n][idnum]=-1;
			VehicleInfo[n][veh_pos][0]=dini_Float(carname,"x");
			VehicleInfo[n][veh_pos][1]=dini_Float(carname,"y");
			VehicleInfo[n][veh_pos][2]=dini_Float(carname,"z");
			VehicleInfo[n][veh_pos][3]=dini_Float(carname,"a");
			for (new mo = 0; mo < MAX_COMPONENTS; mo++){
				format(modname,sizeof(modname),"mod%d",mo);
				VehicleInfo[n][COMPONENTS][mo]=dini_Int(carname,modname);
			}
			VehicleInfo[n][paintjob]=dini_Int(carname,"paintjob");
			VehicleInfo[n][security]=dini_Int(carname,"security");
			VehicleInfo[n][priority]=dini_Int(carname,"priority");
			VehicleInfo[n][model]=dini_Int(carname,"model");
			VehicleInfo[n][owner]=dini_Get(carname,"ownername");
			//VehicleInfo[n][ownerid]=dini_Int(carname,"ownerid");
			VehicleInfo[n][CREATED]=dini_Int(carname,"CREATED");
			VehicleInfo[n][tank]=dini_Int(carname,"tank");
			VehicleInfo[n][meters]=dini_Int(carname,"meters");
			VehicleInfo[n][oilpress]=dini_Int(carname,"oilpress");
			VehicleInfo[n][oilminimum]=dini_Int(carname,"oilminimum");
			VehicleInfo[n][oildamage]=dini_Int(carname,"oildamage");
			VehicleInfo[n][locked]=dini_Int(carname,"locked");
			//VehicleInfo[n][numberplate]=dini_Get(carname,"numberplate");
			VehicleInfo[n][health]=dini_Float(carname,"health");
			VehicleInfo[n][key]=dini_Int(carname,"key");
			VehicleInfo[n][world]=dini_Int(carname,"world");
			VehicleInfo[n][interior]=dini_Int(carname,"interior");
			VehicleInfo[n][colors][0]=dini_Int(carname,"color1");
			VehicleInfo[n][colors][1]=dini_Int(carname,"color2");
			VehicleInfo[n][streamid]=dini_Int(carname,"streamid");
			vehcount3=n+1;
		}
	}
	return 1;
}
/*public StreamVehicles(){
	for(new i=0;i<MAX_STREAM_VEHICLES;i++){
	    if(VehicleInfo[i][CREATED]){
			if (VehicleInfo[i][priority]==0){
				if (vehcount==MAX_ACTIVE_VEHICLES){
					new j;
					while(VehicleInfo[j][priority]!=3 && j < MAX_STREAM_VEHICLES;){
						j++;
					}
					if (j < MAX_STREAM_VEHICLES && VehicleInfo[j][idnum]>=0){
						GetVehiclePos(VehicleInfo[j][idnum],VehicleInfo[j][veh_pos][0],VehicleInfo[j][veh_pos][1],VehicleInfo[j][veh_pos][2]);
						GetVehicleZAngle(VehicleInfo[j][idnum],VehicleInfo[j][veh_pos][3]);
						GetVehicleHealth(VehicleInfo[j][idnum],VehicleInfo[j][health]);
						DestroyVehicle(VehicleInfo[j][idnum]);
						VehStreamid[VehicleInfo[j][idnum]]=INVALID_STREAM_ID;
						VehicleInfo[j][idnum]=-1;
						vehcount--;
					}
					else{
						j=0;
						while(VehicleInfo[j][priority]!=2 && j < MAX_STREAM_VEHICLES+2;){
							j++;
						}
						if (j < MAX_STREAM_VEHICLES && VehicleInfo[j][idnum]>=0){
							GetVehiclePos(VehicleInfo[j][idnum],VehicleInfo[j][veh_pos][0],VehicleInfo[j][veh_pos][1],VehicleInfo[j][veh_pos][2]);
							GetVehicleZAngle(VehicleInfo[j][idnum],VehicleInfo[j][veh_pos][3]);
							GetVehicleHealth(VehicleInfo[j][idnum],VehicleInfo[j][health]);
							DestroyVehicle(VehicleInfo[j][idnum]);
							VehStreamid[VehicleInfo[j][idnum]]=INVALID_STREAM_ID;
							VehicleInfo[j][idnum]=-1;
							vehcount--;
						}
						new h[256];
						format(h,sizeof(h),"",);
						SendClientMessageToAll(COLOR_RED, "" );
						return 1;
						}
				}

				LoadVehicle(i);
			}
			else if(VehicleInfo[i][priority]==3){

			}
	        if(IsAnyPlayerNearStreamVehicle(i,VIEW_DISTANCE)){
	            LoadVehicle(i);

			}
			else{
				if(VehicleInfo[i][idnum]>=0){
				    GetVehiclePos(VehicleInfo[i][idnum],VehicleInfo[i][veh_pos][0],VehicleInfo[i][veh_pos][1],VehicleInfo[i][veh_pos][2]);
				    GetVehicleZAngle(VehicleInfo[i][idnum],VehicleInfo[i][veh_pos][3]);
				    GetVehicleHealth(VehicleInfo[i][idnum],VehicleInfo[i][health]);
					DestroyVehicle(VehicleInfo[i][idnum]);
					VehStreamid[VehicleInfo[i][idnum]]=INVALID_STREAM_ID;
				    VehicleInfo[i][idnum]=-1;
				    vehcount--;
				}
			}
	    }
	}
	return 1;
}*/
public StreamVehicles(){
	for (new i = 0; i < MAX_PRIORITY; i++){
		for (new j = 0; j < vehcount3 ; j++){
			if(VehicleInfo[j][CREATED] && VehicleInfo[j][priority]==i && IsPlayerOnline(VehicleInfo[j][owner])){
				vehcount2++;
				if (vehcount2 <= MAX_ACTIVE_VEHICLES-500){
					if(VehicleInfo[j][idnum]==-1){
						if (vehcount <= MAX_ACTIVE_VEHICLES){
							LoadVehicle(j);
						}
						else{
							new h = GetLastPriority() ;
							UnLoadVehicle(h);
							LoadVehicle(j);
						}
					}
				}
				else if ( vehcount2 > MAX_ACTIVE_VEHICLES -500 && vehcount2 < MAX_ACTIVE_VEHICLES ){
					if(IsAnyPlayerNearStreamVehicle(j,VIEW_DISTANCE)){
						LoadVehicle(j);
					}
					else{
						if(VehicleInfo[j][idnum]>=0){
							UnLoadVehicle(j);
						}
					}
				}
			}
		}
	}
	vehcount2=0;
}
public GetLastPriority(){
	for (new i = MAX_PRIORITY-1; i >= 0; i--){
		for (new j = 0; j < MAX_STREAM_VEHICLES ; j++){
			if(VehicleInfo[j][CREATED] && VehicleInfo[j][idnum]>=0){
				if (VehicleInfo[j][priority]==i){
					return j;
				}
			}
		}
	}
	return 0;
}
/*public SetStreamVehicleToRespawn(svehicleid){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
	{
	    if(VehicleInfo[svehicleid][VEHICLE_ID] && VehicleInfo[svehicleid][CREATED])
        {
            VehicleInfo[svehicleid][HEALTH]=1000;
		    VehicleInfo[svehicleid][PAINTJOB]=0;

		    for(new i=0;i<MAX_COMPONENTS;i++)
		        VehicleInfo[svehicleid][COMPONENTS][i]=0;

		    VehicleInfo[svehicleid][CURRENT_POS]=VehicleInfo[svehicleid][SPAWN_POS];

			//For correct respawn:
		    DestroyVehicle(VehicleInfo[svehicleid][VEHICLE_ID]);
		  	VehicleInfo[svehicleid][VEHICLE_ID]=0;
		  	VehicleCount--;
		  	return CallLocalFunction("OnStreamVehicleSpawn","i",svehicleid);
        }
	}
	return 0;
}*/
public LinkStreamVehicleToInterior(svehicleid,interiorid){
	if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
	        if(VehicleInfo[svehicleid][idnum]>=0){
	            LinkVehicleToInterior(VehicleInfo[svehicleid][idnum],interiorid);
			}
	        VehicleInfo[svehicleid][interior]=interiorid;
	        return 1;
	    }
	}
	return 0;
}
public SetStreamVehicleVirtualWorld(svehicleid,worldid){
	if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
			if(VehicleInfo[svehicleid][idnum]>=0){
	            SetVehicleVirtualWorld(VehicleInfo[svehicleid][idnum],worldid);
			}
	        VehicleInfo[svehicleid][world]=worldid;
	        return 1;
	    }
	}
	return 0;
}
public GetStreamVehicleVirtualWorld(svehicleid){
	if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
			return VehicleInfo[svehicleid][world];
		}
	}
	return 0;
}
public GetStreamVehicleHealth(svehicleid, &Float:health2){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
			if(VehicleInfo[svehicleid][idnum]>=0){
				GetVehicleHealth(VehicleInfo[svehicleid][idnum],health2);
			}
			else{
			    health2=VehicleInfo[svehicleid][health];
			}
			return 1;
	    }
	}
	return 0;
}
public SetStreamVehicleHealth(svehicleid,Float:health2){
	if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED])	    {
			if(VehicleInfo[svehicleid][idnum]>=0){
	            SetVehicleHealth(VehicleInfo[svehicleid][idnum],health2);
			}
	        VehicleInfo[svehicleid][health]=health2;
	        return 1;
	    }
	}
	return 0;
}
public AddStreamVehicleComponent(svehicleid,componentid){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
	        for(new i=0;i<MAX_COMPONENTS;i++){
			    if(!VehicleInfo[svehicleid][COMPONENTS][i]){
			        if(VehicleInfo[svehicleid][idnum]>=0){
	            		AddVehicleComponent(VehicleInfo[svehicleid][idnum],componentid);
					}
			        VehicleInfo[svehicleid][COMPONENTS][i]=componentid;
			        return 1;
				}
			}
	    }
	}
	return 0;
}
public RemoveStreamVehicleComponent(svehicleid,componentid){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
	        for(new i=0;i<MAX_COMPONENTS;i++){
   				if(VehicleInfo[svehicleid][COMPONENTS][i]==componentid){
			        if(VehicleInfo[svehicleid][idnum]>=0){
	            		RemoveVehicleComponent(VehicleInfo[svehicleid][idnum],componentid);
					}
			        VehicleInfo[svehicleid][COMPONENTS][i]=0;
			        return 1;
				}
			}
	    }
	}
	return 0;
}
public GetStreamVehicleModel(svehicleid){
	if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
			return VehicleInfo[svehicleid][model];
		}
	}
	return 0;
}
public GetVehicleStreamID(vehicleid){
	return VehStreamid[vehicleid];
}
public GetStreamVehicleVehicleID(svehicleid){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
			return VehicleInfo[svehicleid][idnum];
		}
	}
	return 0;
}
public GetPlayerStreamVehicleID(playerid){
	if(IsPlayerInAnyVehicle(playerid)){
		return VehStreamid[GetPlayerVehicleID(playerid)];
	}
	return -1;
}
public ChangeStreamVehicleColor(svehicleid,color1,color2){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
	        if(VehicleInfo[svehicleid][idnum]>=0){
	            ChangeVehicleColor(VehicleInfo[svehicleid][idnum],color1,color2);
			}
            VehicleInfo[svehicleid][colors][0]=color1;
            VehicleInfo[svehicleid][colors][1]=color2;
            return 1;
	    }
	}
	return 0;
}
public ChangeStreamVehiclePaintjob(svehicleid,paintjobid){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
	        if(VehicleInfo[svehicleid][idnum]>=0){
	            ChangeVehiclePaintjob(VehicleInfo[svehicleid][idnum],paintjobid);
			}
            VehicleInfo[svehicleid][paintjob]=paintjobid;
            return 1;
	    }
	}
	return 0;
}
public GetStreamVehiclePos(svehicleid, &Float:x, &Float:y, &Float:z){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
	        if(VehicleInfo[svehicleid][idnum]>=0){
	            GetVehiclePos(VehicleInfo[svehicleid][idnum],x,y,z);
			}
			else{
			    x=VehicleInfo[svehicleid][veh_pos][0];
			    y=VehicleInfo[svehicleid][veh_pos][1];
			    z=VehicleInfo[svehicleid][veh_pos][2];
			}
            return 1;
	    }
	}
	return 0;
}
public GetStreamVehicleZAngle(svehicleid, &Float:z_angle){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
	        if(VehicleInfo[svehicleid][idnum]>=0){
	            GetVehicleZAngle(VehicleInfo[svehicleid][idnum],z_angle);
			}
			else{
			    z_angle=VehicleInfo[svehicleid][veh_pos][3];
			}
            return 1;
	    }
	}
	return 0;
}
public SetStreamVehiclePos(svehicleid, Float:x, Float:y, Float:z){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
	        if(VehicleInfo[svehicleid][idnum]>=0){
	            SetVehiclePos(VehicleInfo[svehicleid][idnum],x,y,z);
			}
			VehicleInfo[svehicleid][veh_pos][0]=x;
		    VehicleInfo[svehicleid][veh_pos][1]=y;
		    VehicleInfo[svehicleid][veh_pos][2]=z;
            return 1;
	    }
	}
	return 0;
}
public SetStreamVehicleZAngle(svehicleid, Float:z_angle){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
	        if(VehicleInfo[svehicleid][idnum]>=0){
	            SetVehicleZAngle(VehicleInfo[svehicleid][idnum],z_angle);
			}
			VehicleInfo[svehicleid][veh_pos][3]=z_angle;
            return 1;
	    }
	}
	return 0;
}
public PutPlayerInStreamVehicle(playerid, svehicleid, seatid){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
	        if(VehicleInfo[svehicleid][idnum]>=0){
	            PutPlayerInVehicle(playerid,VehicleInfo[svehicleid][idnum],seatid);
			}
			else{
			    new vehicleid=LoadVehicle(svehicleid);
			    if(vehicleid){
				    PutPlayerInVehicle(playerid,vehicleid,seatid);
				    return 1;
				}
			}
	    }
	}
	return 0;
}
public SetStreamVehicleParamsForPlayer(svehicleid,playerid,objective,doorslocked){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
	        VehicleInfo[svehicleid][locked]=doorslocked;
	        if(VehicleInfo[svehicleid][idnum]>=0){
	            SetVehicleParamsForPlayer(VehicleInfo[svehicleid][idnum],playerid,0,doorslocked);
			}
			return 1;
	    }
	}
	return 0;
}
public SetStreamVehicleNumberPlate(svehicleid, numberplate2[]){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
	        format(VehicleInfo[svehicleid][numberplate],10,numberplate2);
	        if(VehicleInfo[svehicleid][idnum]>=0 && strlen(numberplate2)){
	            SetVehicleNumberPlate(VehicleInfo[svehicleid][idnum],VehicleInfo[svehicleid][numberplate]);
			}
			return 1;
	    }
	}
	return 0;
}
public GetStreamVehicleColors(svehicleid,&color1,&color2){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
	       	color1=VehicleInfo[svehicleid][colors][0];
	       	color2=VehicleInfo[svehicleid][colors][1];
			return 1;
	    }
	}
	return 0;
}
public GetStreamVehiclePaintjob(svehicleid){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
	    if(VehicleInfo[svehicleid][CREATED]){
		    return VehicleInfo[svehicleid][paintjob];
		}
	}
	return 0;
}
//$ endregion Vehicle-Streamer
//$ region Streamer-Pickups
	stock GetPickupSpawnSector(pstreamid){
		new xsec = floatround(((PickupInfo[pstreamid][x_spawn] +4000) / 500), floatround_floor);
		new ysec = floatround(((PickupInfo[pstreamid][y_spawn] +4000) / 500), floatround_floor);
		return (xsec * 16) + ysec;
	}
	stock CleanupPickups(){
		for(new i = 0;i<pucount;i++) {
			if(PickupInfo[i][spawned] == 1 && PlayersClose(PickupInfo[i][x_spawn],PickupInfo[i][y_spawn],PickupInfo[i][z_spawn],20) == 0) {
				PickupInfo[i][spawned] = 0;
				DestroyPickup(PickupInfo[i][idnum]);
				PUstreamcount--;
				PickupInfo[i][idnum] = -1;
				}
			}
		}
	stock StreamPickups(playerid){
		for(new p = 0;p<pucount;p++) {
			if(drivepbool==true && PickupInfo[p][valid] == 1 && PickupInfo[p][spawned] == 0 && PlayerClose(playerid,PickupInfo[p][x_spawn],PickupInfo[p][y_spawn],PickupInfo[p][z_spawn],20) == 1) {
				if(PUstreamcount < MAX_ACTIVE_PICKUPS) {
					//new string[256];
					PickupInfo[p][spawned] = 1;
					PickupInfo[p][idnum] = CreatePickup(PickupInfo[p][model],PickupInfo[p][ptype],PickupInfo[p][x_spawn],PickupInfo[p][y_spawn],PickupInfo[p][z_spawn]);
					pustream[PickupInfo[p][idnum]] = p;
					//format(string,sizeof(string),"Pickup created: %d, %d", p, PickupInfo[p][idnum]);
					//SendClientMessage(playerid, COLOR_YELLOW, string);
					PUstreamcount++;
				}}}
	}
	stock UpdatePickupSectorInfo(){
		new secnum;
		for(new i = 0;i<MAX_SECTORS;i++) {
			SectorPickupCount[i] = 0;
		}
		for(new i = 0;i<MAX_STREAM_PICKUPS;i++) {
			if(PickupInfo[i][valid] == 1) {
				secnum = GetPickupSpawnSector(i);
				SectorPickupCount[secnum]++;
				SectorPickups[secnum][SectorPickupCount[secnum]] = i;
			}
		}
		return 1;
	}
	stock CreateStreamPickup(modelid,type,Float:x,Float:y,Float:z){
		for(new i = 0;i<MAX_STREAM_PICKUPS;i++) {
			if(PickupInfo[i][valid] == 0) {

				PickupInfo[i][valid] = 1;
				PickupInfo[i][model] = modelid;
				PickupInfo[i][x_spawn] = x;
				PickupInfo[i][y_spawn] = y;
				PickupInfo[i][z_spawn] = z;
				PickupInfo[i][idnum] = 0;
				PickupInfo[i][ptype] = type;
				//			if(PickupInfo[i][id_prev_used] == 0) {
				pucount++;
//			}
//			printf("%d : %d",i,PickupInfo[i][valid]);
				//UpdatePickupSectorInfo();
				return i;
			}
		}
		return 0;
	}
	stock DestroyStreamPickup(pstreamid){
		PickupInfo[pstreamid][valid] = 0;
		PickupInfo[pstreamid][id_prev_used] = 1;
		//PickupInfo[pstreamid][cust_type] = -1;
		if(PickupInfo[pstreamid][spawned] == 1) {
			DestroyPickup(PickupInfo[pstreamid][idnum]);
		}
		//UpdatePickupSectorInfo();
		return 1;
	}
	stock SetStreamPickupInfo(pstreamid,modelid,type,Float:x,Float:y,Float:z,custom_type){
		if(PickupInfo[pstreamid][valid] == 1) {
			PickupInfo[pstreamid][model] = modelid;
			PickupInfo[pstreamid][x_spawn] = x;
			PickupInfo[pstreamid][y_spawn] = y;
			PickupInfo[pstreamid][z_spawn] = z;
			PickupInfo[pstreamid][ptype] = type;
			PickupInfo[pstreamid][cust_type] = custom_type;
			//UpdatePickupSectorInfo();
			return 1;
		}
		return 0;
	}
	stock GetPickupStreamID(pickupid){
		return pustream[pickupid];
	}
	stock GetStreamPickupID(pstreamid){
		if(PickupInfo[pstreamid][spawned] == 0) {
			return -1;
		}
		return PickupInfo[pstreamid][idnum];
	}
	stock GetStreamPickupCustomType(pstreamid){
		if(PickupInfo[pstreamid][spawned] == 0) {
			return -1;
		}
		return PickupInfo[pstreamid][cust_type];
	}

//$ endregion Streamer-Pickups
//$ endregion Streamer
stock IsABoat(carid){
	if(carid >= 86 && carid <=90)
	{
		return 1;
	}
	return 0;
}

stock IsAPlane(carid){
	if(carid==39||carid==40||carid==60||carid==83||carid==91||carid==92||carid==93||carid==95||carid==96||carid==99||carid==100||carid==101||carid==102||carid==103||carid==104||carid==105||carid==106||carid==107||carid==108||carid==109)
	{
		return 1;
	}
	return 0;
}

stock IsACopCar(carid){
	if((carid >= 35) && (carid <= 60) || carid == 66 || carid == 67 || carid == 91 || carid == 92 || carid == 93 || carid == 36)
	{
	    if(carid == 45 || carid == 46 || carid == 55 || carid == 59) { return 0; }
		return 1;
	}
	return 0;
}
stock IsAnAmbulance(carid){
	if((carid >= 61) && (carid <= 63)|| carid == 83)
	{
		return 1;
	}
	return 0;
}
stock IsATruck(carid){
	if(carid >= 78 && carid <= 81)
	{
		return 1;
	}
	return 0;
}

stock PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z){
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tmpposx, Float:tmpposy, Float:tmpposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tmpposx = (oldposx -x);
	tmpposy = (oldposy -y);
	tmpposz = (oldposz -z);
	if (((tmpposx < radi) && (tmpposx > -radi)) && ((tmpposy < radi) && (tmpposy > -radi)) && ((tmpposz < radi) && (tmpposz > -radi)))
	{
		return 1;
	}
	return 0;
}
public IsPlayerInArea(playerid, Float:minx, Float:maxx, Float:miny, Float:maxy, Float:minz, Float:maxz){
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if (x > minx && x < maxx && y > miny && y < maxy && z > minz && z < maxz) return 1;
return 1;}
stock PlayerClose(playerid,Float:x,Float:y,Float:z,Float:MAX){
	new Float:PPos[3];
	if(IsPlayerConnected(playerid)) {
			GetPlayerPos(playerid, PPos[0], PPos[1], PPos[2]);
			if (PPos[0] >= floatsub(x, MAX) && PPos[0] <= floatadd(x, MAX)
			&& PPos[1] >= floatsub(y, MAX) && PPos[1] <= floatadd(y, MAX)
			&& PPos[2] >= floatsub(z, MAX) && PPos[2] <= floatadd(z, MAX))
			{
				return 1;
			}
	}
	return 0;
}
stock PlayersClose(Float:x,Float:y,Float:z,Float:MAX){
	new Float:PPos[3];
	for(new i = 0;i<MAX_SLOTS_tAxI;i++) {
		if(IsPlayerConnected(i)) {
			GetPlayerPos(i, PPos[0], PPos[1], PPos[2]);
			if (PPos[0] >= floatsub(x, MAX) && PPos[0] <= floatadd(x, MAX)
			&& PPos[1] >= floatsub(y, MAX) && PPos[1] <= floatadd(y, MAX)
			&& PPos[2] >= floatsub(z, MAX) && PPos[2] <= floatadd(z, MAX))
			{
				return 1;
			}
		}
	}
	return 0;
}
public IsPlayerOnline(name[]){
	new pname[MAX_PLAYER_NAME];
	for (new i = 0; i < MAX_PLAYERS; i++){
		GetPlayerName(i,pname,sizeof(pname));
		if(strcmp(name,pname,false) == 0){
			return 1;
		}
	}
	return 0;
}
stock writepath(playerid,text[]){
	new pathplayername[256];
	new pathfile[256];
	GetPlayerName(playerid, pathplayername, sizeof(pathplayername));
	format(pathfile,sizeof(pathfile),"carpath(%s).txt",pathplayername);
	if(!fexist(pathfile))fclose(fopen(pathfile,io_write));
	new File:handler = fopen(pathfile,io_append);
	new string_[256];
	format(string_,256,"%s\r\n",text);
	fwrite(handler,string_);
	fclose(handler);
}
stock IsNumeric(string[]){
	for (new i = 0, j = strlen(string); i < j; i++)	{
		if (string[i] > '9' || string[i] < '0') return 0;	}
	return 1;
}
stock GetWeaponIDFromName(WeaponName[]){
	if(strfind("molotov",WeaponName,true)!=-1) return 18;
	for(new i = 0; i <= 46; i++){
		switch(i){
			case 0,19,20,21,44,45: continue;
			default:{
				new name[32]; GetWeaponName(i,name,32);
				if(strfind(name,WeaponName,true) != -1) return i;
			}
		}
	}
	return -1;
}
stock IsValidWeapon(weaponid){
    if (weaponid > 0 && weaponid < 19 || weaponid > 21 && weaponid < 47) return 1;
    return 0;
}
public GetPlayerDistanceToPointEx(playerid,Float:x,Float:y,Float:z){
	new Float:x1,Float:y1,Float:z1;
	new Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	tmpdis = floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2)+floatpower(floatabs(floatsub(z,z1)),2));
	return floatround(tmpdis);}
public GetDistanceBetweenPlayers(playerid,playerid2){
	new Float:x1,Float:y1,Float:z1,Float:x3,Float:y3,Float:z3;
	new Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	GetPlayerPos(playerid2,x3,y3,z3);
	tmpdis = floatsqroot(floatpower(floatabs(floatsub(x3,x1)),2)+floatpower(floatabs(floatsub(y3,y1)),2)+floatpower(floatabs(floatsub(z3,z1)),2));
return floatround(tmpdis);}
AddCargoObjects(playerid){
	CreatePlayerObject(playerid,5152, 226.368317, 80.976151, 10640.210938, 0.0000, 304.9961, 270.0000);
	CreatePlayerObject(playerid,5152, 224.218292, 81.001152, 10640.185547, 0.0000, 304.9961, 270.0000);
    CreatePlayerObject(playerid,5152, 222.118256, 81.001152, 10640.160156, 0.0000, 304.9961, 270.0000);
    CreatePlayerObject(playerid,5152, 219.968353, 81.001152, 10640.134766, 0.0000, 304.9961, 270.0000);
    CreatePlayerObject(playerid,17950, 222.161911, 85.046188, 10641.463867, 0.0000, 0.0000, 180.0000);
    CreatePlayerObject(playerid,16644, 225.152069, 82.224739, 10639.169922, 0.0000, 0.0000, 180.0000);
    CreatePlayerObject(playerid,16644, 225.152069, 84.824745, 10639.169922, 0.0000, 0.0000, 180.0000);
    CreatePlayerObject(playerid,16644, 225.152069, 87.424706, 10639.169922, 0.0000, 0.0000, 180.0000);
    CreatePlayerObject(playerid,1801, 223.812393, 84.994156, 10639.186523, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1801, 223.812393, 84.994156, 10640.249023, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1801, 219.312515, 84.994156, 10640.249023, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1801, 219.312515, 84.994156, 10639.194336, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,936, 224.351379, 85.508743, 10639.678711, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,936, 219.851501, 85.508743, 10639.678711, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,937, 224.319031, 85.485367, 10640.628906, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,2063, 219.275833, 82.755394, 10640.115234, 0.0000, 0.0000, 270.0000);
    CreatePlayerObject(playerid,2737, 225.210800, 83.374687, 10640.906250, 0.0000, 0.0000, 270.0000);
    CreatePlayerObject(playerid,14532, 222.043198, 88.440086, 10640.145508, 0.0000, 0.0000, 180.0000);
    CreatePlayerObject(playerid,16779, 221.681305, 83.962280, 10643.164063, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1215, 225.351257, 87.852737, 10641.887695, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1215, 218.826202, 87.852737, 10641.887695, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1485, 220.475174, 85.166641, 10640.143555, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1487, 220.133194, 85.811607, 10640.351563, 0.0000, 0.0000, 315.0000);
    CreatePlayerObject(playerid,1487, 219.850510, 85.519630, 10640.351563, 0.0000, 0.0000, 202.5000);
    CreatePlayerObject(playerid,1520, 220.168503, 85.400864, 10640.213867, 0.0000, 0.0000, 236.2501);
    CreatePlayerObject(playerid,1543, 219.897476, 85.657196, 10640.149414, 0.0000, 0.0000, 281.2500);
    CreatePlayerObject(playerid,1546, 219.513016, 85.285851, 10640.192383, 0.0000, 92.8191, 87.6625);
    CreatePlayerObject(playerid,2690, 223.368210, 85.511871, 10640.409180, 0.0000, 0.0000, 281.2500);
    CreatePlayerObject(playerid,2068, 222.325272, 85.086929, 10642.511719, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,2058, 224.326752, 85.524803, 10640.370117, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,2044, 219.295761, 83.865089, 10640.487305, 0.0000, 0.0000, 146.7229);
    CreatePlayerObject(playerid,2044, 219.295761, 83.565086, 10640.487305, 0.0000, 0.0000, 146.7229);
    CreatePlayerObject(playerid,2044, 219.295761, 83.290085, 10640.487305, 0.0000, 0.0000, 146.7229);
    CreatePlayerObject(playerid,2036, 219.279907, 82.316414, 10640.906250, 0.0000, 0.0000, 90.0000);
    CreatePlayerObject(playerid,2035, 219.220779, 82.025429, 10640.055664, 0.0000, 0.0000, 236.2501);
    CreatePlayerObject(playerid,2035, 219.220779, 82.775429, 10640.055664, 0.0000, 0.0000, 236.2501);
    CreatePlayerObject(playerid,2035, 219.220779, 83.525429, 10640.055664, 0.0000, 0.0000, 236.2501);
    CreatePlayerObject(playerid,1672, 219.095810, 83.898651, 10639.670898, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1672, 219.220779, 83.898651, 10639.670898, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1672, 219.095871, 83.648651, 10639.670898, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1672, 219.120865, 83.798660, 10639.670898, 0.0000, 0.0000, 0.0000);
    CreatePlayerObject(playerid,1654, 219.320755, 83.319298, 10639.650391, 272.4414, 0.0000, 326.2500);
    CreatePlayerObject(playerid,1654, 219.320755, 82.994293, 10639.650391, 272.4414, 0.0000, 326.2500);
    CreatePlayerObject(playerid,2037, 219.195786, 81.650864, 10639.649414, 0.0000, 0.0000, 123.7499);
    CreatePlayerObject(playerid,2037, 219.195786, 82.150864, 10639.649414, 0.0000, 0.0000, 67.5000);
    CreatePlayerObject(playerid,2037, 219.420731, 81.850876, 10639.649414, 0.0000, 0.0000, 101.2500);
}
