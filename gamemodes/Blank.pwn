//$ region Includes
	#include <a_samp>
	#include <a_npc>
	#include <a_objects>
	#include <a_players>
	#include <a_vehicles>
	#include <dudb>
	#include <dini>
	#include <dutils>
	#include <dcallbacks>
//$ endregion Includes
//$ region Forwards
	forward InitiateSectorSystem();
	forward SectorScan();
	forward GetPlayerDistanceToPointEx(playerid,Float:x,Float:y,Float:z);
	forward Float:GetDistanceBetweenPoints(Float:X, Float:Y, Float:Z, Float:PointX, Float:PointY, Float:PointZ);
	forward GetDistanceBetweenPlayers(playerid,playerid2);
	forward DestroyVehicleEx( vehicleid );
	forward TimeUpdate();
	forward F_OnPlayerSelectedMenuRow(playerid, menuid, row, leftright);
	forward F_OnPlayerSelectMenuRow(playerid, menuid, row);
	forward F_OnPlayerExitedMenu(playerid, menuid);
	forward OnStreamVehicleMod(playerid, vehicleid, componentid);
	forward OnStreamVehiclePaintjob(playerid, vehicleid, paintjobid);
	forward OnStreamVehicleRespray(playerid, vehicleid, color1, color2);
	forward UpdateCar( playerid );
	forward UpdateCar2( playerid );
	forward StreamVehicles();
	forward CreateStreamVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2);
	forward DestroyStreamVehicle(svehicleid);
	forward LockCar(svehicleid);
	forward UnLockCar(svehicleid);
	forward LoadVehicle(svehicleid);
	forward UnLoadVehicle(svehicleid);
	forward LoadCars();
	forward SaveCar(svehicleid);
	forward SaveCars();
	forward GetLastPriority();
	forward GetLastPriority2();
	forward LinkStreamVehicleToInterior(svehicleid,interiorid);
	forward SetStreamVehicleVirtualWorld(svehicleid,worldid);
	forward GetStreamVehicleVirtualWorld(svehicleid);
	forward SetStreamVehicleHealth(svehicleid,Float:health2);
	forward GetStreamVehicleHealth(svehicleid, &Float:health2);
	forward AddStreamVehicleComponent(svehicleid,componentid);
	forward RemoveStreamVehicleComponent(svehicleid,componentid);
	forward GetStreamVehicleModel(svehicleid);
	forward GetVehicleStreamID(vehicleid);
	forward GetStreamVehicleVehicleID(svehicleid);
	forward GetPlayerStreamVehicleID(playerid);
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
	forward F_PressKeyDetection();
	forward F_HoldKey(playerid);
	forward DestroyMenuColor();
	forward UnloadMenuColor();
	forward CreateMenuColor();
	forward HideMenuColor(playerid);
	forward HideMenuColor2(playerid);
	forward ShowMenuColor(playerid);
	forward ShowMenuColor2(playerid);
	forward UpdateColSel(playerid);
	forward CreateCarMenu(playerid);
	forward DestroyCarMenu(playerid);
	forward UnloadCarMenu(playerid);
	forward SetPlayerMoneyEx(playerid, amount);
	forward GivePlayerMoneyEx(playerid, amount);
	forward LoadPlayer(playerid);
	forward SavePlayer(playerid);
	forward OnCheckpointEnter(playerid, checkpointid);
	forward OnCheckpointExit(playerid, checkpointid);
	forward StreamCheckpoints();
	forward TogglePlayerControllableTimed(playerid, toggle);
	forward DeleteBusID(playerid);
//$ endregion Forwards
//$ region Defines
	#define line(%1,%2) for(new i=0; i<86; i++) msg[i] = ' '; msg[2] = %1; msg[xmax] = %2; for(new i=3; i<xmax; i++) msg[i] = 196; print(msg)
	#define line2(%1,%2) for(new i=0; i<86; i++) msg[i] = ' '; msg[2] = %1; msg[xmax] = %2; for(new i=3; i<xmax; i++) msg[i] = 205; print(msg)
	#define VIEW_DISTANCE 200
	#define SLOTS 500
	#define MAX_TEXTDRAW 9999
	#define MAX_SKINS 169
	#define MAX_LABELS 1000
	#define MAX_CHECKPOINTS 1000
	#define MAX_BUSSTOPS 76
	#define MAX_BUSROUTES 6
	#define GLOBAL_OWNER_ID -1
	#define F_MAX_MENUS 500
	#define F_MAX_MENU_ROWS 20
	#define MIN_PASS_CHAR 4 //The minimum password characters
	#define Register 987
	#define Login 988
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
		#define WHITE "{FFFFFF}"
		#define GREENN "{00B000}"
		#define BLUE "{0025E1}"
		#define REDD "{FF0000}"
		#define ORANGEE "{FF7E19}"
		#define YELLOW "{FF9E00}"
		#define LIGHTBLUE "{4290FE}"
		#define weiss	0xFFFFFFAA
		#define gelb 	0xFFFF00AA
		#define rot 	0xAA3333AA
		#define RED		0xFF0000AA
		#define GREEN	0x33AA33FF
		#define ORANGE	0xFF9900AA
		#define C 0xFFFFFFFF
		#define COLOR_NEUTRALGREEN 0x81CFAB00
	//$ endregion Colors
	//$ region VType
		#define VTYPE_CAR 1
		#define VTYPE_HEAVY 2
		#define VTYPE_BIKE 3
		#define VTYPE_AIR 4
		#define VTYPE_SEA 5
	//$ endregion VType
	//$ region Key-Status
		#define HOLDING(%0) \
					((newkeys & (%0)) == (%0))
		#define PRESSED(%0) \
					(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
		#define RELEASED(%0) \
					(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
	//$ endregion Key-Status
	//$ region VehicleStreamerDef
		#define MAX_CARS 205
		#define MAX_ACTIVE_VEHICLES 1999
		#define MODEL_LIMIT 212
		#define MAX_ACTIVE_MODELS 150
		#define MAX_STREAM_VEHICLES 9999
		#define MAX_PRIORITY 31
		#define TOTAL_COLORS 128
		#define MAX_COMPONENTS 17
	//$ endregion VehicleStreamerDef
	//$ region ObjectStreamerDef
		#define MAX_OVERALL_OBJECTS 3000
		#define MAX_ACTIVE_OBJECTS 395
		#define MAX_SECTOR_OBJECTS 200
	//$ endregion ObjectStreamerDef
	//$ region PickupStreamerDef
		#define MAX_STREAM_PICKUPS 3000
		#define MAX_ACTIVE_PICKUPS 250
		#define MAX_SECTOR_PICKUPS 200
	//$ endregion PickupStreamerDef
//$ endregion Defines
//$ region Enums
	enum carTypeE {
		nameb[20],
		shoppid
	};
	enum carDefinesE {
		ID,
		namec[40],
		Price,
		Fuel,
		Tank,
		type1
	};
	enum puInfo {
		model,
		ptype,
		Float:x_spawn,
		Float:y_spawn,
		Float:z_spawn,
		spawned,
		idnum,
		valid
	};
	enum vInfo{
		CREATED,
		streamid,
		idnum,
		idobj,
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
		owner[255],
		tank,
		meters,
		oilpress,
		oilminimum,
		oildamage,
		messagesend,
		messagesend2,
		messagesend3,
		locked,
		security,
		priority,
		playerpriority[MAX_PLAYERS]

	};
	enum OBInfo {
		Float:x_ent,
		Float:y_ent,
		Float:z_ent,
		Float:x_rot,
		Float:y_rot,
		Float:z_rot,
		Float:x_off,
		Float:y_off,
		Float:z_off,
		Float:x_rt,
		Float:y_rt,
		Float:z_rt,
		model,
		valid,
		priority,
		show,
		Float:spawndist,
		id_prev_used,
		attached,
		a_player,
		status[MAX_PLAYERS],
		poid[MAX_PLAYERS],
		null[MAX_PLAYERS],
		pattached[MAX_PLAYERS]
	};
	enum pInfo {
		BusID,
		BusCost,
		BusRoute,
		VisibleCheckpoint,
		Float:Pathdistance,
		Float:PathPos[4],
		pathedit,
		logwarning,
		money,
		Skin,
		NormalSkin,
		skinused,
		loggedin,
		SpeedClock[4],
		Float:PlayerPos[4],
		Float:Speed,
		//$ region F_menu
			bool:AKeyPressed,
			F_HoldKeyt,
			menushown,
		//$ endregion F_menu
		//$ region Vehbuy-Menu
		updatetimer,
		vehbuymenu[35],
		carSelect,
		playerCar,
		colorpage,
		colorselect,
		confirmselect,
		itemPlace[7],
		bool:destroyCar
		//$ endregion Vehbuy-Menu
	}
	enum tInfo{
		TAlign,
		BgColor,
		BColor,
		TColor,
		TFont,
		Float:TPos[2],
		Float:LSize[2],
		Float:TSize[2],
		TOutL,
		TProp,
		TShadow,
		TString[255],
		TBox,
		Text:DrawId,
		TCreated,
		TLoaded,
		TShown[MAX_PLAYERS],
	}
	enum mInfo{
		Rows,
		bool:Shown[MAX_PLAYERS],
		bool:UsedMenu,
		SelectedRow[MAX_PLAYERS],
		menu_id,
		menu_row[F_MAX_MENU_ROWS],
		SelectedRowTextColor,
		SelectedRowBgColor,
		SelectedRowBoxColor,
		ItemTextColor,
		ItemBgColor,
		ItemBoxColor,
	}
	enum lblInfo{
		lblcreated,
		labelid,
		lblshow,
		lblpriority,
		lblname[255],
		Float:lblpos[3],
		lblcolor,
		playerattach,
		vehicleattach,
		Float:lbldistance,
		lblLOS
	}
	enum checkpointEnum{
		chp_created,
		Float:chp_posX,
		Float:chp_posY,
		Float:chp_posZ,
		Float:chp_size,
		Float:chp_viewDistance,
		bool:chp_active,
		chp_interior_id,
		chp_world_id,
		chp_shown[MAX_PLAYERS]
	};
//$ endregion Enums
//$ region Variables
	new TDSpeedClock[15];
	new carType[36][carTypeE]={
		{"Airportveh",7},//job
		{"2 Doors",1},//Shop	1
		{"2 Doors",0},//Shop	1
		{"4 Doors",1},//Shop	1
		{"4 Doors",0},//Shop	1
		{"Army",8},//Job
		{"Bau",7},//Job
		{"Bikes",2},//Shop	2
		{"Boats",3},//Shop	3
		{"Bus",1},//Shop	1
		{"Carmechanic",7},//Job
		{"Essen",7},//Job
		{"Farm",7},//Job
		{"FBI",8},//Job
		{"Fire",8},//Job
		{"Helis",4},//Shop	4
		{"Trailers",1},//Shop	1
		{"Luxus",1},//Shop	1
		{"Motorbikes",5},//Shop	5
		{"Planes",4},//Shop	4
		{"Police",8},//Job
		{"RC",6},//Shop	6
		{"Small",1},//Shop	1
		{"Specials",1},//Shop	1
		{"Sportcars",1},//Shop	1
		{"Sportcars",0},//Shop	1
		{"Swat",8},//Job
		{"Taxi",7},//Job
		{"Train",9},//Job
		{"Trucks",1},//Shop	1
		{"News",7},//Job
		{"Trashmission",7},//Job
		{"Security",7},
		{"Policeboat-heli",8},
		{"Newsheli",7},
		{"Medic",8}
	};
	new carDefines[MAX_CARS][carDefinesE]={
		{ 485, "Baggage", 5000, 40, 200, 0},
		{ 583, "Tug", 4500, 27, 200, 0},
		{ 606, "BagBoxA", 10000, 0, 0, 0},
		{ 607, "BagBoxB", 10000, 0, 0, 0},
		{ 608, "Tugstairs", 5000, 0, 0, 0},
		{ 401, "Bravura", 34000, 82, 550, 1},
		{ 410, "Manana", 39000, 85, 550, 1},
		{ 412, "Voodoo", 56000, 100, 600, 1},
		{ 419, "Esperant", 36500, 92, 550, 1},
		{ 422, "Bobcat", 40500, 80, 550, 1},
		{ 436, "Previon", 37000, 91, 550, 1},
		{ 439, "Stallion", 48500, 110, 600, 1},
		{ 440, "Rumpo", 34000, 98, 550, 1},
		{ 442, "Romero", 31500, 82, 550, 1},
		{ 474, "Hermes", 40000, 95, 550, 1},
		{ 475, "Sabre", 54500, 109, 600, 1},
		{ 478, "Walton", 24500, 76, 550, 1},
		{ 489, "Rancher", 48000, 92, 550, 1},
		{ 491, "Virgo", 39500, 95, 550, 1},
		{ 499, "Benson", 22000, 70, 550, 1},
		{ 500, "Mesa", 50000, 98, 600, 2},
		{ 517, "Majestic", 50000, 99, 550, 2},
		{ 518, "Buccanee", 58500, 96, 550, 2},
		{ 526, "Fortune", 42500, 88, 550, 2},
		{ 527, "Cadrona", 40000, 90, 550, 2},
		{ 534, "Remington", 49000, 94, 550, 2},
		{ 536, "Blade", 55000, 108, 600, 2},
		{ 542, "Clover", 49000, 90, 600, 2},
		{ 543, "Sadler", 49500, 90, 550, 2},
		{ 549, "Tampa", 48000, 96, 600, 2},
		{ 550, "Sunrise", 35000, 88, 550, 2},
		{ 554, "Yosemite", 58000, 104, 600, 2},
		{ 575, "Broadway", 43000, 105, 600, 2},
		{ 576, "Tornado", 46000, 100, 600, 2},
		{ 600, "Picador", 52000, 94, 550, 2},
		{ 400, "Landstal", 55000, 97, 550, 3},
		{ 404, "Pereninal", 28000, 74, 550, 3},
		{ 405, "Sentinel", 55000, 110, 600, 3},
		{ 413, "Pony", 30000, 112, 600, 3},
		{ 418, "Moonbeam", 25000, 68, 550, 3},
		{ 421, "Washington", 53000, 96, 550, 3},
		{ 426, "Premier", 46000, 115, 600, 3},
		{ 445, "Admiral", 50000, 90, 550, 3},
		{ 458, "Solair", 45000, 90, 550, 3},
		{ 466, "Glendale", 44500, 99, 550, 3},
		{ 467, "Oceanic", 36000, 80, 550, 3},
		{ 479, "Regina", 32000, 85, 550, 3},
		{ 482, "Burrito", 42000, 120, 600, 3},
		{ 483, "Camper", 23000, 90, 550, 4},
		{ 492, "Greenwood", 41000, 82, 550, 4},
		{ 507, "Elegant", 43500, 105, 600, 4},
		{ 516, "Nebula", 44000, 100, 600, 4},
		{ 529, "Willard", 37500, 88, 550, 4},
		{ 540, "Vincent", 39000, 96, 550, 4},
		{ 546, "Intruder", 38000, 86, 550, 4},
		{ 547, "Primo", 37500, 87, 550, 4},
		{ 551, "Merit", 48000, 102, 600, 4},
		{ 561, "Stratum", 52000, 103, 600, 4},
		{ 566, "Tahoma", 49000, 94, 550, 4},
		{ 567, "Savanna", 53000, 90, 550, 4},
		{ 585, "Emperor", 49500, 101, 600, 4},
		{ 425, "Hunter", 2500000, 5500, 10000, 5},
		{ 432, "Rhino", 3000000, 400, 1000, 5},
		{ 447, "SeaSparrow", 1000000, 3500, 7000, 5},
		{ 520, "Hydra", 2000000, 6000, 10000, 5},
		{ 406, "Dumper", 100000, 300, 850, 6},
		{ 486, "Dozer", 70000, 230, 600, 6},
		{ 524, "Cement", 90000, 250, 750, 6},
		{ 481, "BMX", 2000, 0, 0, 7},
		{ 509, "Bike", 2000, 0, 0, 7},
		{ 510, "Mountainbike", 3000, 0, 0, 7},
		{ 446, "Squalo", 240000, 520, 1700, 8},
		{ 452, "Speeder", 200000, 420, 1500, 8},
		{ 453, "Reefer", 75000, 230, 1000, 8},
		{ 454, "Tropic", 150000, 350, 1200, 8},
		{ 472, "Coastg", 180000, 250, 1000, 8},
		{ 473, "Dinghy", 50000, 220, 500, 8},
		{ 484, "Marquis", 65000, 150, 350, 8},
		{ 493, "Jetmax", 250000, 470, 1600, 8},
		{ 595, "Launch", 175000, 280, 1000, 8},
		{ 431, "Bus", 80000, 241, 1300, 9},
		{ 437, "Coach", 75000, 223, 1200, 9},
		{ 525, "Towtruck", 50000, 100, 650, 10},
		{ 552, "UtilityTruck", 35000, 110, 650, 10},
		{ 423, "MrWhoop", 29000, 130, 600, 11},
		{ 448, "Pizzamoped", 9000, 40, 200, 11},
		{ 588, "Hotdog", 36000, 150, 600, 11},
		{ 531, "Tractor", 5000, 50, 200, 12},
		{ 532, "Combine", 80000, 244, 800, 12},
		{ 610, "Harvester", 15000, 0, 0, 12},
		{ 490, "FBIRancher", 70000, 163, 720, 13},
		{ 528, "FBITruck", 50000, 172, 700, 13},
		{ 407, "Firetruck", 65000, 247, 700, 14},
		{ 544, "FireLadder", 65000, 255, 700, 14},
		{ 417, "Leviathn", 1200000, 4800, 15000, 15},
		{ 469, "Sparrow", 600000, 3200, 6000, 15},
		{ 487, "Maverick", 750000, 3750, 10000, 15},
		{ 548, "Cargobob", 1100000, 4500, 15000, 15},
		{ 563, "Raindanc", 1150000, 4700, 15000, 15},
		{ 435, "Trailer Open", 20000, 0, 0, 16},
		{ 450, "Trailer Close", 17500, 0, 0, 16},
		{ 584, "Trailer Oil", 25000, 0, 0, 16},
		{ 409, "Stretch", 120000, 120, 600, 17},
		{ 470, "Patriot", 70000, 200, 700, 17},
		{ 535, "Slamvan", 70000, 137, 650, 17},
		{ 545, "Hustler", 62000, 137, 650, 17},
		{ 579, "Huntley", 65000, 144, 650, 17},
		{ 580, "Stafford", 61000, 123, 600, 17},
		{ 461, "PCJ600", 10500, 80, 350, 18},
		{ 462, "Faggio", 7000, 45, 200, 18},
		{ 463, "Freeway", 11000, 65, 300, 18},
		{ 468, "Dirtbike", 8000, 70, 250, 18},
		{ 471, "Quadbike", 10000, 60, 250, 18},
		{ 521, "FCR900", 13000, 80, 350, 18},
		{ 522, "NRG500", 18000, 87, 350, 18},
		{ 571, "Kart", 6000, 40, 200, 18},
		{ 581, "BF400", 10000, 82, 350, 18},
		{ 586, "Wayfarer", 15000, 74, 300, 18},
		{ 460, "Skimmer", 500000, 2000, 5000, 19},
		{ 476, "Rustler", 1000000, 3750, 5000, 19},
		{ 511, "Beagle", 900000, 4500, 7500, 19},
		{ 512, "Cropdust", 550000, 2850, 5000, 19},
		{ 513, "Stunt", 700000, 2400, 5000, 19},
		{ 519, "Shamal", 1500000, 6000, 12000, 19},
		{ 553, "Nevada", 1400000, 6600, 12000, 19},
		{ 577, "AT400", 2700000, 9000, 13000, 19},
		{ 592, "Androm", 3000000, 8750, 14000, 19},
		{ 593, "Dodo", 400000, 2000, 5000, 19},
		{ 523, "Policebike", 10000, 72, 350, 20},
		{ 596, "PoliceLA", 35000, 114, 700, 20},
		{ 597, "PoliceSF", 35000, 114, 700, 20},
		{ 598, "PoliceLV", 35000, 114, 700, 20},
		{ 599, "PoliceRancher", 40000, 132, 750, 20},
		{ 441, "RCBandit", 5000, 21, 50, 21},
		{ 464, "RCBaron", 5000, 22, 50, 21},
		{ 465, "RCRaider", 5000, 21, 50, 21},
		{ 501, "RCGoblin", 5000, 21, 50, 21},
		{ 564, "RCTiger", 5000, 24, 50, 21},
		{ 457, "Golfkart", 20000, 42, 200, 22},
		{ 530, "Fortklift", 5000, 35, 200, 22},
		{ 539, "Vortex", 20000, 55, 200, 22},
		{ 572, "Mower", 4000, 30, 200, 22},
		{ 574, "Sweeper", 4000, 30, 200, 22},
		{ 424, "BFINJECT", 75000, 132, 650, 23},
		{ 444, "Monster", 90000, 250, 750, 23},
		{ 495, "Sandking", 69000, 140, 550, 23},
		{ 504, "Blood-a", 60000, 105, 600, 23},
		{ 508, "Journey", 30000, 143, 650, 23},
		{ 556, "Monster-A", 90000, 250, 750, 23},
		{ 557, "Monster-B", 90000, 250, 750, 23},
		{ 568, "Bandito", 55000, 180, 700, 23},
		{ 402, "Buffalo", 85000, 145, 650, 24},
		{ 411, "Infernus", 120000, 179, 700, 24},
		{ 415, "Cheetah", 113000, 176, 700, 24},
		{ 429, "Banshee", 105000, 182, 700, 24},
		{ 434, "Hotknife", 81000, 173, 700, 24},
		{ 451, "Turismo", 122000, 185, 700, 24},
		{ 477, "ZR350", 90000, 145, 650, 24},
		{ 480, "Comet", 97000, 135, 650, 24},
		{ 494, "Hotring", 88000, 190, 700, 24},
		{ 496, "Blistac", 62000, 110, 600, 24},
		{ 502, "Hotring-A", 88000, 190, 700, 24},
		{ 503, "Hotring-B", 88000, 190, 700, 24},
		{ 506, "SuperGT", 95000, 159, 650, 24},
		{ 533, "Feltzer", 82000, 126, 600, 25},
		{ 541, "Bullet", 115000, 178, 700, 25},
		{ 555, "Windsor", 85000, 155, 650, 25},
		{ 558, "Uranus", 63000, 121, 600, 25},
		{ 559, "Jester", 87000, 137, 650, 25},
		{ 560, "Sultan", 77000, 128, 600, 25},
		{ 562, "Elegy", 89000, 132, 650, 25},
		{ 565, "Flash", 60000, 120, 600, 25},
		{ 587, "Euros", 59500, 137, 650, 25},
		{ 589, "Club", 94000, 138, 650, 25},
		{ 602, "Alpha", 73000, 140, 650, 25},
		{ 603, "Phoenix", 72000, 158, 650, 25},
		{ 427, "Enforcer", 60000, 180, 750, 26},
		{ 601, "SwatVan", 57000, 170, 750, 26},
		{ 420, "Taxi", 45000, 126, 750, 27},
		{ 438, "Cabbie", 40000, 113, 750, 27},
		{ 449, "Tram", 0, 0, 0, 28},
		{ 537, "TrainFreight", 0, 0, 0, 28},
		{ 538, "TrainPublic", 0, 0, 0, 28},
		{ 569, "TrainFrei", 0, 0, 0, 28},
		{ 570, "TrainPassanger", 0, 0, 0, 28},
		{ 590, "TrainBox", 0, 0, 0, 28},
		{ 403, "Linerunner", 65000, 228, 750, 29},
		{ 414, "Mule", 26000, 133, 700, 29},
		{ 433, "Barracks", 50000, 256, 850, 29},
		{ 443, "Packer", 80000, 225, 800, 29},
		{ 455, "Flatbed", 54000, 253, 850, 29},
		{ 456, "Yankee", 27500, 167, 700, 29},
		{ 498, "Boxville", 21000, 160, 650, 29},
		{ 514, "PetrolTruck", 70000, 230, 800, 29},
		{ 515, "RoadTruck", 73000, 234, 800, 29},
		{ 573, "Dune", 37000, 200, 800, 29},
		{ 578, "DFT30", 35000, 150, 650, 29},
		{ 609, "Boxburg", 72000, 158, 650, 29},
		{ 582, "NewsVan", 30000, 122, 650, 30},
		{ 408, "Trash", 40000, 230, 700, 31},
		{ 428, "Securitycar", 120000, 220, 750, 32},
		{ 430, "Policeboat", 200000, 500, 1750, 33},
		{ 488, "NewsMav", 600000, 3000, 8000, 34},
		{ 497, "PoliceMav", 650000, 3500, 9000, 34},
		{ 416, "Ambulance", 50000, 180, 700, 35}
	};
	new PlayerInfo[MAX_PLAYERS][pInfo];
	new MenuInfo[F_MAX_MENUS][mInfo];
	new TextInfo[MAX_TEXTDRAW][tInfo];
	new checkpoints[MAX_CHECKPOINTS][checkpointEnum];
	new Float:BusStop[MAX_BUSSTOPS][3] = {
		{1173.1272, -1796.636, 13.35},
		{1181.7648, -1796.7993, 13.35},
		{1491.5524, -1594.7327, 13.36},
		{1471.6519, -1589.8295, 13.36},
		{1792.2515, -1613.7677, 13.3},
		{1772.6884, -1604.1948, 13.3},
		{1819.217, -1910.5862, 13.33},
		{1824.142, -1895.4591, 13.33},
		{1991.2813, -2169.0051, 13.35},
		{1990.3077, -2164.0571, 13.35},
		{2216.2278, -1990.4828, 13.3},
		{2211.2324, -1993.356, 13.3},
		{2287.5957, -1734.9489, 13.3},
		{2284.7324, -1729.8083, 13.3},
		{2667.0183, -1659.8756, 10.65},
		{2692.3054, -1654.8678, 10.65},
		{2694.2813, -1254.9674, 59.0},
		{2675.8928, -1259.1382, 54.55},
		{2250.7861, -1139.5347, 26.22},
		{2245.8176, -1143.4265, 26.22},
		{1679.5975, -1158.3826, 23.6},
		{1659.0007, -1163.3831, 23.6},
		{1386.9443, -1139.8973, 23.6},
		{1384.1986, -1144.6317, 23.6},
		{930.3464, -1138.1982, 23.63},
		{912.6407, -1152.0281, 23.63},
		{830.4883, -1330.194, 13.35},
		{858.5819, -1317.448, 13.35},
		{972.3418, -1569.8539, 13.33},
		{972.3502, -1574.7491, 13.33},
		{455.0503, -1542.7678, 28.55},
		{441.0592, -1531.1978, 29.7},
		{336.4989, -1378.9565, 14.15},
		{330.3566, -1399.2789, 14.15},
		{349.8544, -1718.6948, 6.6},
		{365.0901, -1699.3051, 6.75},
		{812.0262, -1786.5819, 13.5},
		{849.859, -1767.019, 13.33},
		{1432.7529, -2267.4685, 13.3},
		{1436.3409, -2250.9949, 13.3},
		{2087.6584, -1779.8943, 13.33},
		{2083.0771, -1777.4233, 13.33},
		{2375.3357, -1974.8844, 13.35},
		{2395.2258, -1969.8831, 13.35},
		{2711.6499, -1959.6233, 13.35},
		{2716.7549, -1964.4015, 13.35},
		{2860.0715, -1553.2804, 10.87},
		{2852.1814, -1561.4766, 10.87},
		{2673.1514, -1045.2059, 69.35},
		{2675.4102, -1050.3376, 69.35},
		{2300.967, -1208.6901, 23.92},
		{2306.0103, -1193.7444, 24.8},
		{2372.0278, -1521.7166, 23.73},
		{2374.7952, -1526.8162, 23.73},
		{1972.3932, -1457.9819, 13.3},
		{2003.106, -1468.8135, 13.3},
		{1563.2853, -1295.506, 16.9},
		{1577.4319, -1306.3096, 17.2},
		{1239.2627, -1392.7761, 13.05},
		{1216.5017, -1408.2666, 13.05},
		{771.5927, -1392.6962, 13.35},
		{752.4459, -1408.1522, 13.35},
		{320.4879, -1601.7123, 33.1},
		{336.4837, -1622.316, 32.95},
		{1208.7626, -1374.308, 13.25},
		{1192.7582, -1370.9066, 13.25},
		{1399.2383, -951.2995, 34.8},
		{1409.4182, -937.5938, 35.3},
		{2296.563, -5.2379, 26.3},
		{2291.3066, 6.2892, 26.3},
		{1347.3774, 302.8814, 19.35},
		{1336.4071, 302.0915, 19.35},
		{230.2578, -105.5506, 1.35},
		{235.2995, -53.2054, 1.35},
		{679.1426, -559.006, 16.15},
		{684.3329, -574.8741, 16.15}
	};
	new BusRoutes[MAX_BUSROUTES][20] = {
		{1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 0},
		{2, 38, 36, 34, 32, 30, 28, 26, 24, 22, 20, 18, 16, 14, 12, 10, 8, 6, 4, 0},
		{1, 39, 42, 43, 45, 47, 49, 51, 53, 55, 57, 3, 59, 61, 63, 30, 0, 0, 0, 0},
		{2, 29, 64, 62, 60, 4, 58, 56, 54, 52, 50, 48, 46, 44, 41, 13, 40, 0, 0, 0},
		{1, 38, 62, 76, 74, 72, 70, 19, 68, 66, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		{2, 65, 67, 20, 69, 71, 73, 75, 61, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	};
	new BusCheckpoint[MAX_BUSSTOPS];
	new Busses[MAX_BUSROUTES];
	new BusInterior[70];
	new totalCheckpoints;
	new report[255];
	new Zeit[3];
	new skinpl[MAX_SKINS]={
		0, 1, 2, 7, 14, 15, 17, 19, 20, 21, 22, 23, 24, 25, 26, 28, 29, 30, 32, 33, 34, 35, 36, 37,
		38, 43, 44, 46, 47, 48, 49, 51, 52, 57, 58, 59, 60, 62, 66, 67, 72, 73, 78, 79, 82, 83, 84,
		94, 95, 96, 98, 99, 101, 128, 132, 133, 134, 135, 136, 137, 142, 143, 144, 156, 158, 159,
		160, 161, 162, 168, 170, 171, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 188, 189,
		200, 202, 203, 204, 206, 210, 212, 213, 217, 220, 221, 222, 223, 227, 228, 229, 230, 234,
		235, 236, 239, 240, 241, 242, 249, 250, 258, 259, 261, 262, 268, 9, 10, 11, 12, 13, 31, 39,
		40, 41, 54, 55, 56, 69, 76, 77, 88, 89, 90, 92, 93, 129, 130, 131, 141, 148, 150, 151, 157,
		169, 172, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 201, 211, 214, 215, 216, 218,
		219, 224, 225, 226, 231, 232, 233, 263
	};
	//$ region Carbuy-Menu
		new CarColors[TOTAL_COLORS] = {
			0x000000ff,
			0xf5f5f5ff,
			0x2a77a1ff,
			0x840510ff,
			0x253739ff,
			0x87446fff,
			0xd68f11ff,
			0x4c75b7ff,
			0xbdbdc5ff,
			0x5e7072ff,
			0x46597aff,
			0x66697aff,
			0x5e7e8dff,
			0x58595bff,
			0xd6dbd5ff,
			0x9ca1a4ff,
			0x34603fff,
			0x740e1bff,
			0x7c0a2bff,
			0xa09d94ff,
			0x3b4e79ff,
			0x732e40ff,
			0x691e3cff,
			0x96918dff,
			0x515459ff,
			0x3f3e46ff,
			0xa5a9a8ff,
			0x645c5aff,
			0x3c4969ff,
			0x969591ff,
			0x431f21ff,
			0x5f272aff,
			0x8494abff,
			0x757a7dff,
			0x646464ff,
			0x5b5853ff,
			0x252527ff,
			0x2e3a36ff,
			0x93a398ff,
			0x6d7a8aff,
			0x28201eff,
			0x6f6860ff,
			0x7c1c28ff,
			0x600a15ff,
			0x193828ff,
			0x5c1b1fff,
			0x9c9872ff,
			0x7a7561ff,
			0x989586ff,
			0xacb0b1ff,
			0x848a88ff,
			0x305045ff,
			0x4e6368ff,
			0x162248ff,
			0x282f4cff,
			0x7e6257ff,
			0x9fa4aaff,
			0x9c8d70ff,
			0x6e1821ff,
			0x4e6881ff,
			0x9c9d98ff,
			0x907347ff,
			0x661d26ff,
			0x949c9fff,
			0xa3a8a4ff,
			0x8f8c47ff,
			0x331a1dff,
			0x697a8aff,
			0xaaad8eff,
			0xac988fff,
			0x86202eff,
			0x708298ff,
			0x585953ff,
			0x9aa68eff,
			0x601a1aff,
			0x21212dff,
			0xa4a097ff,
			0xab9d83ff,
			0x78222bff,
			0x0e326eff,
			0x722a40ff,
			0x7a715fff,
			0x741c28ff,
			0x1d2f31ff,
			0x4e322fff,
			0x7d1b44ff,
			0x2f5b20ff,
			0x395a83ff,
			0x6c2837ff,
			0xa7a28fff,
			0xb0b2b1ff,
			0x364155ff,
			0x6d6d6fff,
			0x0f6a89ff,
			0x204b6dff,
			0x2c3d57ff,
			0x9a9e9dff,
			0x6d8494ff,
			0x4d5c5fff,
			0xac9b7fff,
			0x416c8fff,
			0x20253bff,
			0xac9277ff,
			0x124574ff,
			0x96816cff,
			0x64686bff,
			0x115083ff,
			0xa19984ff,
			0x385694ff,
			0x525661ff,
			0x7e6956ff,
			0x8d919aff,
			0x596d86ff,
			0x483433ff,
			0x456250ff,
			0x730a28ff,
			0x223556ff,
			0x630d1aff,
			0xa3adc6ff,
			0x6a5854ff,
			0x9b8a80ff,
			0x620b1cff,
			0x5c5d5fff,
			0x634428ff,
			0x741827ff,
			0x1c376eff,
			0xed6aaeff,
			0xed6aaeff
		};
		new carsmenucreated;
		new vbmcolordraw[TOTAL_COLORS+3];
	//$ endregion Carbuy-Menu
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
	//$ region VehicleStreamer
		new vehcount=0;
		new vehcount2=0;
		new vehcount3=0;
		new modelscount=0;
		new modelcount[MODEL_LIMIT];
		new VehicleInfo[MAX_STREAM_VEHICLES][vInfo];
		new VehStreamid[MAX_VEHICLES];
	//$ endregion VehicleStreamer
	//$ region PickupStreamer
		new pustream[MAX_ACTIVE_PICKUPS];
		new PickupInfo[MAX_STREAM_PICKUPS][puInfo];
		new pucount = 0;
		new pucount2 = -1;
		new pustreamcount = 0;
	//$ endregion PickupStreamer
	//$ region ObjectStreamer
		new ObjectInfo[MAX_OVERALL_OBJECTS][OBInfo];
		new overallobjectcount = -1;
		new OBstreamcount[MAX_PLAYERS];
		new PlAO[MAX_PLAYERS];
		//new ObjectStatus[MAX_PLAYERS][MAX_OVERALL_OBJECTS];
		//new ObjectID[MAX_PLAYERS][MAX_OVERALL_OBJECTS];
		//new ObjectNull[MAX_PLAYERS][MAX_OVERALL_OBJECTS];
		//new ObjAtt[MAX_PLAYERS][MAX_OVERALL_OBJECTS];
	//$ endregion ObjectStreamer
		new Label3dInfo[MAX_LABELS][lblInfo];
		new labelcount;
//$ endregion Variables
//$ region Is-Abfragen
	stock IsABoat(carid){
		if(carid >= 86 && carid <=90){
			return 1;
		}
		return 0;
	}
	stock IsAPlane(carid){
		if(carid==39||carid==40||carid==60||carid==83||carid==91||carid==92||carid==93||carid==95||carid==96||carid==99||carid==100||carid==101||carid==102||carid==103||carid==104||carid==105||carid==106||carid==107||carid==108||carid==109){
			return 1;
		}
		return 0;
	}
	stock IsACopCar(carid){
		if((carid >= 35) && (carid <= 60) || carid == 66 || carid == 67 || carid == 91 || carid == 92 || carid == 93 || carid == 36){
		    if(carid == 45 || carid == 46 || carid == 55 || carid == 59) { return 0; }
			return 1;
		}
		return 0;
	}
	stock IsAnAmbulance(carid){
		if((carid >= 61) && (carid <= 63)|| carid == 83){
			return 1;
		}
		return 0;
	}
	stock IsATruck(carid){
		if(carid >= 78 && carid <= 81){
			return 1;
		}
		return 0;
	}
	stock IsPlayerInAmmu(playerid){
	    for(new i = 0; i < sizeof(Ammunation_Coordinates); i++){
	      if(IsPlayerInRangeOfPoint(playerid, 70.0, Ammunation_Coordinates[i][0], Ammunation_Coordinates[i][1], Ammunation_Coordinates[i][2])) return 1;
	     }
	     return 0;
	}
	stock IsNumeric(string[]){
		for (new i = 0, j = strlen(string); i < j; i++)	{
			if (string[i] > '9' || string[i] < '0') return 0;
		}
		return 1;
	}
	stock IsValidWeapon(weaponid){
	    if (weaponid > 0 && weaponid < 19 || weaponid > 21 && weaponid < 47) return 1;
	    return 0;
	}
	stock IsPlayerOnline(name[]){
		new pname[MAX_PLAYER_NAME];
		for (new i = 0; i < MAX_PLAYERS; i++){
			GetPlayerName(i,pname,sizeof(pname));
			if(strcmp(name,pname,true) == 0){
				return 1;
			}
		}
		return 0;
	}
	stock IsPlayerInFrontVehicle(playerid,vehicleid,Float:radius,Float:vehiclelength){
		new Float:x,Float:y,Float:z,Float:a;
		GetVehiclePos(vehicleid, x, y, z);
		GetPlayerFacingAngle(vehicleid, a);
		x += (vehiclelength* floatsin(-a, degrees));
		 y += (vehiclelength* floatcos(-a, degrees));
		return IsPlayerInRangeOfPoint(playerid,radius,x,y,z);
	}
	stock IsPlayerInRangeOfVehicle(playerid, vehicleid, radius){
	    new Float: CarPpX, Float: CarPpY, Float: CarPpZ;
	    GetVehiclePos(playerid, CarPpX, CarPpY, CarPpZ);
	    if(IsPlayerInRangeOfPoint(playerid, radius, CarPpX, CarPpY, CarPpZ)){
	      return 1;
	    }
	    else{
	        return 0;
	    }
	}
	stock IsPlayerInArea(playerid, Float:minx, Float:maxx, Float:miny, Float:maxy, Float:minz, Float:maxz){
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		if (x > minx && x < maxx && y > miny && y < maxy && z > minz && z < maxz) return 1;
		return 1;
	}
	stock PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z){
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tmpposx, Float:tmpposy, Float:tmpposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tmpposx = (oldposx -x);
		tmpposy = (oldposy -y);
		tmpposz = (oldposz -z);
		if (((tmpposx < radi) && (tmpposx > -radi)) && ((tmpposy < radi) && (tmpposy > -radi)) && ((tmpposz < radi) && (tmpposz > -radi))){
			return 1;
		}
		return 0;
	}
	stock PlayerClose(playerid,Float:x,Float:y,Float:z,Float:MAX){
		new Float:PPos[3];
		if(IsPlayerConnected(playerid)){
			GetPlayerPos(playerid, PPos[0], PPos[1], PPos[2]);
			if (PPos[0] >= floatsub(x, MAX) && PPos[0] <= floatadd(x, MAX)
			&& PPos[1] >= floatsub(y, MAX) && PPos[1] <= floatadd(y, MAX)
			&& PPos[2] >= floatsub(z, MAX) && PPos[2] <= floatadd(z, MAX)){
				return 1;
			}
		}
		return 0;
	}
	stock PlayersClose(Float:x,Float:y,Float:z,Float:MAX){
		new Float:PPos[3];
		for(new i = 0;i<MAX_PLAYERS;i++) {
			if(IsPlayerConnected(i)) {
				GetPlayerPos(i, PPos[0], PPos[1], PPos[2]);
				if (PPos[0] >= floatsub(x, MAX) && PPos[0] <= floatadd(x, MAX)
				&& PPos[1] >= floatsub(y, MAX) && PPos[1] <= floatadd(y, MAX)
				&& PPos[2] >= floatsub(z, MAX) && PPos[2] <= floatadd(z, MAX)){
					return 1;
				}
			}
		}
		return 0;
	}
	stock IsPlayerLookingAtPlayer(playerid,playerid2){
		GetPlayerPos(playerid,_IPLAP[0],_IPLAP[1],_IPLAP[2]);
		GetPlayerCameraUpVector(playerid,_IPLAP[3],_IPLAP[4],_IPLAP[5]);
		_IPLAP[0]+=_IPLAP[3];
		_IPLAP[1]+=_IPLAP[4];
		_IPLAP[2]+=_IPLAP[5];
		GetPlayerCameraFrontVector(playerid,_IPLAP[6],_IPLAP[7],_IPLAP[8]);
		GetPlayerPos(playerid2,_IPLAP[9],_IPLAP[10],_IPLAP[11]);
		_IPLAP[12]=floatsqroot(((_IPLAP[9]-_IPLAP[0])*(_IPLAP[9]-_IPLAP[0])) + ((_IPLAP[10]-_IPLAP[1])*(_IPLAP[10]-_IPLAP[1])) + ((_IPLAP[11]-_IPLAP[2])*(_IPLAP[11]-_IPLAP[2])));
		_IPLAP[0]=_IPLAP[6]*_IPLAP[12]+_IPLAP[0];
		_IPLAP[1]=_IPLAP[7]*_IPLAP[12]+_IPLAP[1];
		_IPLAP[2]=_IPLAP[8]*_IPLAP[12]+_IPLAP[2];
		if((_IPLAP[0]>(_IPLAP[9]-0.25)) && (_IPLAP[0]<(_IPLAP[9]+0.25)) && (_IPLAP[1]>(_IPLAP[10]-0.25)) && (_IPLAP[1]<(_IPLAP[10]+0.25)) && (_IPLAP[2]>(_IPLAP[11])) && (_IPLAP[2]<(_IPLAP[11]+2.0))) return 1;
		return 0;
	}
	stock IsPlayerLookingAtPoint(playerid,Float:X,Float:Y,Float:Z){
		GetPlayerPos(playerid,_IPLAP[0],_IPLAP[1],_IPLAP[2]);
		GetPlayerCameraUpVector(playerid,_IPLAP[3],_IPLAP[4],_IPLAP[5]);
		_IPLAP[0]+=_IPLAP[3];
		_IPLAP[1]+=_IPLAP[4];
	    _IPLAP[2]+=_IPLAP[5];
	    GetPlayerCameraFrontVector(playerid,_IPLAP[6],_IPLAP[7],_IPLAP[8]);
	    GetPlayerPos(playerid2,_IPLAP[9],_IPLAP[10],_IPLAP[11]);
	    _IPLAP[12]=floatsqroot( ((X-_IPLAP[0])*(X-_IPLAP[0])) + ((Y-_IPLAP[1])*(Y-_IPLAP[1])) + ((Z-_IPLAP[2])*(Z-_IPLAP[2])) );
	    _IPLAP[0]=_IPLAP[6]*_IPLAP[12]+_IPLAP[0];
	    _IPLAP[1]=_IPLAP[7]*_IPLAP[12]+_IPLAP[1];
	    _IPLAP[2]=_IPLAP[8]*_IPLAP[12]+_IPLAP[2];
	    if( (_IPLAP[0]>(X-0.25)) && (_IPLAP[0]<(X+0.25)) && (_IPLAP[1]>(Y-0.25)) && (_IPLAP[1]<(Y+0.25)) && (_IPLAP[2]>(Z)) && (_IPLAP[2]<(Z+2.0)) ) return 1;
	    return 0;
	}
	stock IsARolePlayName(name[]){
		new	szLastCell;
		new	bool:bUnderScore;
		for(new i; i < strlen(name); i++){
			if(name[i] == '_'){
				if(bUnderScore == true){
					return 0;
				}
				bUnderScore = true;
			}
			// Check if capitalized where it should be
			else if(!szLastCell || szLastCell == '_'){
				if(name[i] < 'A' || name[i] > 'Z'){
					return 0;
				}
			}
			else{
				if(name[i] < 'a' || name[i] > 'z')
					return 0;
			}
			szLastCell = name[i];
		}
		if(bUnderScore == false)
			return 0;
		return 1;
	}
	/*stock IsEngineOn(vehicleid){
		new engine,lights,alarm,doors,bonnet,boot,objective;
		GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		if(engine == VEHICLE_PARAMS_ON) return 1;
		return 0;
	}*/
//$ endregion Is-Abfragen
//$ region Get-Functions
	stock Float:GetDistanceBetweenPoints(Float:X, Float:Y, Float:Z, Float:PointX, Float:PointY, Float:PointZ){
		new Float:Distance;
		Distance = floatabs(floatsub(X, PointX)) + floatabs(floatsub(Y, PointY)) + floatabs(floatsub(Z, PointZ));
		return Distance;
	}
	public GetPlayerDistanceToPointEx(playerid,Float:x,Float:y,Float:z){
		new Float:x1,Float:y1,Float:z1;
		new Float:tmpdis;
		GetPlayerPos(playerid,x1,y1,z1);
		tmpdis = floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2)+floatpower(floatabs(floatsub(z,z1)),2));
		return floatround(tmpdis);
	}
	public GetDistanceBetweenPlayers(playerid,playerid2){
		new Float:x1,Float:y1,Float:z1,Float:x3,Float:y3,Float:z3;
		new Float:tmpdis;
		GetPlayerPos(playerid,x1,y1,z1);
		GetPlayerPos(playerid2,x3,y3,z3);
		tmpdis = floatsqroot(floatpower(floatabs(floatsub(x3,x1)),2)+floatpower(floatabs(floatsub(y3,y1)),2)+floatpower(floatabs(floatsub(z3,z1)),2));
		return floatround(tmpdis);
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
					}
				}
			}
		}
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
	stock GetVehicleSpeed(vehicleid, &Float:Speedy){
		new Float:X, Float:Y, Float:Z;
		GetVehicleVelocity(vehicleid, X, Y, Z);
		Speedy = floatsqroot(X*X + Y*Y + Z*Z)*200;
	}
	stock SetVehicleSpeed(vehicleid, Float:Speedy){
		new Float:X, Float:Y, Float:Z, Float:Angle;
		GetVehicleZAngle(vehicleid, Angle);
		Speedy = Speedy/200;
		X = Speed * floatsin(-Angle, degrees);
		Y = Speed * floatcos(-Angle, degrees);
		SetVehicleVelocity(vehicleid, X, Y, Z);
	}
	Float:GetPlayerArmourEx(p){
		new Float:b;
		GetPlayerArmour(p, b);
		return b;
	}
	stock GetPlayerID(name[]){
		new pname[MAX_PLAYER_NAME];
		for (new i = 0; i < MAX_PLAYERS; i++){
			GetPlayerName(i,pname,sizeof(pname));
			if(strcmp(name,pname,true) == 0){
				return i;
			}
		}
		return -1;
	}
	Float:GetXYOfVehicle(vehicleid, &Float:x, &Float:y, Float:distance){
		new Float:a;
		GetPlayerPos(vehicleid, x, y, a);
		GetVehicleZAngle(vehicleid, a);
		x += (distance * floatsin(-a, degrees));
		y += (distance * floatcos(-a, degrees));
		return a;
	}
	GetPlayerPosPower(playerid,Float: X,Float: Y,Float: Z,Float:PowX,Float:PowY,Float:PowZ,Float: PowXYZ){
		new Float: CtX,Float:CtY,Float:CtZ;
		new Float: DtX,Float: DtY,Float:DtZ;
		GetPlayerPos(playerid,CtX,CtY,CtZ);
		DtX = (CtX -X); DtY = (CtY -Y); DtZ = (CtZ -Z);
		if(DtX< PowXYZ+PowX && DtX> -PowXYZ+PowX && DtY < PowXYZ+PowY  && DtY > -PowXYZ+PowY && DtZ < PowXYZ+PowZ && DtZ > -PowXYZ+PowZ){
			return true;
		}
		return false;
	}
	stock PlayerName(playerid) {
	  new name[255];
	  GetPlayerName(playerid, name, 255);
	  return name;
	}
	stock GetDotXY(Float:StartPosX, Float:StartPosY, &Float:NewX, &Float:NewY, Float:alpha, Float:dist){
		NewX = StartPosX + (dist * floatsin(alpha, degrees));
		NewY = StartPosY + (dist * floatcos(alpha, degrees));
	}
//$ endregion Get-Functions
public DestroyVehicleEx( vehicleid ){
	for(new i = 0; i < GetMaxPlayers(); i++){
	    if(IsPlayerConnected(i)){
	    	if(IsPlayerInVehicle(i,vehicleid)){
				RemovePlayerFromVehicle(i);
			}
		}
	}
	DestroyStreamVehicle(VehStreamid[vehicleid]);
	return 1;
}
main(){
	print("\n----------------------------------");
	print("  Carlito's Way (Under Construction)");
	print("----------------------------------\n");
}
//$ region Callbacks
public OnGameModeInit(){
	CreateMenuColor();
	print("Carlito's Way");
	SetGameModeText("Carlito's Way");
	AllowInteriorWeapons(0);
	//$ region Speedoclock
	TDSpeedClock[0] = TextDrawStreamCreate(496.000000,400.000000,"~g~20");
 	TDSpeedClock[1] = TextDrawStreamCreate(487.000000,388.000000,"~g~40");
 	TDSpeedClock[2] = TextDrawStreamCreate(483.000000,375.000000,"~g~60");
 	TDSpeedClock[3] = TextDrawStreamCreate(488.000000,362.000000,"~g~80");
 	TDSpeedClock[4] = TextDrawStreamCreate(491.000000,349.000000,"~g~100");
 	TDSpeedClock[5] = TextDrawStreamCreate(508.000000,336.500000,"~g~120");
 	TDSpeedClock[6] = TextDrawStreamCreate(536.000000,332.000000,"~g~140");
 	TDSpeedClock[7] = TextDrawStreamCreate(567.000000,337.000000,"~g~160");
 	TDSpeedClock[8] = TextDrawStreamCreate(584.000000,348.000000,"~g~180");
 	TDSpeedClock[9] = TextDrawStreamCreate(595.000000,360.000000,"~g~200");
 	TDSpeedClock[10] = TextDrawStreamCreate(603.000000,374.000000,"~g~220");
 	TDSpeedClock[11] = TextDrawStreamCreate(594.000000,386.000000,"~g~240");
 	TDSpeedClock[12] = TextDrawStreamCreate(585.000000,399.000000,"~g~260");
 	TDSpeedClock[13] = TextDrawStreamCreate(534.000000,396.000000,"~r~/\\");
 	TextDrawStreamLetterSize(TDSpeedClock[13], 1.059999, 2.100000);
 	TDSpeedClock[14] = TextDrawStreamCreate(548.000000,401.000000,".");
	TextDrawStreamLetterSize(TDSpeedClock[14], 0.73, -2.60);
	TextDrawStreamSetOutline(TDSpeedClock[14], 0);
 	TextDrawStreamSetShadow(TDSpeedClock[14], 1);
	TextDrawStreamUseBox(TDSpeedClock[14], 0);
	for(new i; i < 14; i++){
 		TextDrawStreamSetShadow(TDSpeedClock[i], 0);
		TextDrawStreamUseBox(TDSpeedClock[i], 0);
	}
	//$ endregion Speedoclock
	for (new sk = 0; sk < MAX_SKINS; sk++){
		AddPlayerClass(skinpl[sk], 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	}
	for (new chp = 0; chp < MAX_BUSSTOPS; chp++){
		BusCheckpoint[chp] = CreateCheckpoint(BusStop[chp][0], BusStop[chp][1], BusStop[chp][2], 2.0, 0, 0, 0);
	}
	//$ region time-textdraw
    Zeit[0] = TextDrawStreamCreate(606, 16, "00");
    Zeit[1] = TextDrawStreamCreate(503.0, 1.5, "00:00 0000");
	Zeit[2] = TextDrawStreamCreate(548, 16, "00:00");
	TextDrawStreamLetterSize(Zeit[0], 0.4, 1.1);
	TextDrawStreamFont(Zeit[0], 2);
	TextDrawStreamSetShadow(Zeit[0], 0);
	TextDrawStreamUseBox(Zeit[0], 0);
	TextDrawStreamSetOutline(Zeit[0],2);
	TextDrawStreamLetterSize(Zeit[1], 0.6, 1.8);
	TextDrawStreamFont(Zeit[1], 2);
	TextDrawStreamSetShadow(Zeit[1], 0);
	TextDrawStreamBackgroundColor(Zeit[1],COLOR_BLACK);
	TextDrawStreamUseBox(Zeit[1], 0);
	TextDrawStreamSetOutline(Zeit[1], 2);
	TextDrawStreamLetterSize(Zeit[2], 0.5, 1.5);
	TextDrawStreamFont(Zeit[2], 2);
	TextDrawStreamSetShadow(Zeit[2], 0);
	TextDrawStreamBackgroundColor(Zeit[2],COLOR_BLACK);
	TextDrawStreamUseBox(Zeit[2], 0);
	TextDrawStreamSetOutline(Zeit[2],2);
	//$ endregion time-textdraw
	//$ region Timers
	SetTimer("F_PressKeyDetection", 200, 1);
	SetTimer("InitiateSectorSystem",5000,0);
	SetTimer("TimeUpdate",1000,1);
	for (new h = 0; h < MAX_PLAYERS; h++){
		SetTimerEx("SavePlayer",60000,1,"i",h);
	}
	//$ endregion Timers

	CreateStreamObject(968, 1544.70, -1630.86, 13.27,   2.00, -91.00, -90.00, 300, 0);
	CreateStreamObject(1497, 1582.58, -1638.02, 12.45,   0.00, 0.00, 2.00, 300, 0);
	CreateStreamObject(8041, 1811.44, -1889.83, 18.01,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(991, 1779.62, -1941.38, 13.75,   0.00, 0.00, -180.00, 300, 0);
	CreateStreamObject(991, 1772.98, -1941.38, 13.75,   0.00, 0.00, -180.00, 300, 0);
	CreateStreamObject(991, 1771.03, -1938.10, 13.75,   0.00, 0.00, -270.00, 300, 0);
	CreateStreamObject(1497, 1769.47, -1941.43, 12.55,   0.00, 0.00, -90.00, 300, 0);
	CreateStreamObject(968, 1811.23, -1881.62, 13.41,   0.00, -91.00, 90.00, 300, 0);
	CreateStreamObject(968, 1810.79, -1897.93, 13.41,   0.00, 90.00, 90.00, 300, 0);
	CreateStreamObject(1250, 1635.82, -1707.27, 13.39,   0.00, 0.00, -135.00, 300, 0);
	CreateStreamObject(966, 1638.39, -1709.45, 12.49,   0.00, 0.00, 46.00, 300, 0);
	CreateStreamObject(968, 1638.43, -1709.40, 13.40,   0.00, -91.00, 46.00, 300, 0);
	CreateStreamObject(4639, 1643.81, -1688.90, 22.09,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(4639, 1654.00, -1689.90, 16.33,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(975, 1761.38, -1691.95, 14.09,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(975, 1761.35, -1699.13, 14.14,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(975, 1803.39, -1720.73, 14.20,   0.00, 0.00, -192.00, 300, 0);
	CreateStreamObject(11102, 2178.50, -2254.38, 15.69,   0.00, 0.00, -225.00, 300, 0);
	CreateStreamObject(11102, 2174.53, -2258.25, 15.69,   0.00, 0.00, -225.00, 300, 0);
	CreateStreamObject(2066, 2123.70, -2277.11, 19.66,   0.00, 0.00, 136.00, 300, 0);
	CreateStreamObject(1726, 2131.46, -2284.89, 19.67,   0.00, 0.00, 134.00, 300, 0);
	CreateStreamObject(1727, 2133.65, -2280.29, 19.70,   0.00, 0.00, -45.00, 300, 0);
	CreateStreamObject(1827, 2132.45, -2282.46, 19.62,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1497, 2118.46, -2274.23, 19.67,   0.00, 0.00, -40.00, 300, 0);
	CreateStreamObject(969, 2234.56, -2215.84, 12.71,   0.00, 0.00, -45.00, 300, 0);
	CreateStreamObject(969, 2234.38, -2215.69, 12.71,   0.00, 0.00, 135.00, 300, 0);
	CreateStreamObject(10671, 2264.30, -2254.73, 14.42,   0.00, 0.00, 44.00, 300, 0);
	CreateStreamObject(975, 2424.60, -2086.24, 14.23,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(975, 2424.60, -2095.06, 14.23,   0.00, 0.00, -90.00, 300, 0);
	CreateStreamObject(967, 2425.53, -2080.96, 12.55,   0.00, 0.00, -180.00, 300, 0);
	CreateStreamObject(1967, 2424.77, -2078.72, 13.45,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(4639, 1790.49, -1882.66, 14.23,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1250, 1813.86, -1889.17, 13.41,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(8041, 1637.63, -1146.37, 28.56,   0.00, 0.00, -90.00, 300, 0);
	CreateStreamObject(968, 1645.84, -1146.16, 24.03,   0.00, -91.00, 0.00, 300, 0);
	CreateStreamObject(968, 1629.48, -1145.71, 24.03,   0.00, 90.00, 0.00, 300, 0);
	CreateStreamObject(1250, 1638.30, -1148.58, 23.91,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(3475, 1625.28, -1146.36, 25.42,   0.00, 0.00, -90.00, 300, 0);
	CreateStreamObject(3475, 1619.31, -1146.36, 25.42,   0.00, 0.00, -90.00, 300, 0);
	CreateStreamObject(3475, 1613.34, -1146.36, 25.42,   0.00, 0.00, -90.00, 300, 0);
	CreateStreamObject(3475, 1607.92, -1144.50, 25.42,   0.00, 0.00, -125.00, 300, 0);
	CreateStreamObject(3475, 1605.54, -1139.61, 25.42,   0.00, 0.00, 181.00, 300, 0);
	CreateStreamObject(3475, 1605.40, -1133.67, 25.42,   0.00, 0.00, -178.00, 300, 0);
	CreateStreamObject(3475, 1604.88, -1127.79, 25.42,   0.00, 0.00, 188.00, 300, 0);
	CreateStreamObject(3475, 1604.14, -1121.82, 25.42,   0.00, 0.00, 186.00, 300, 0);
	CreateStreamObject(3475, 1603.40, -1115.87, 25.42,   0.00, 0.00, 188.00, 300, 0);
	CreateStreamObject(3475, 1602.41, -1109.99, 25.42,   0.00, 0.00, -169.00, 300, 0);
	CreateStreamObject(3475, 1601.30, -1104.24, 25.42,   0.00, 0.00, -169.00, 300, 0);
	CreateStreamObject(3475, 1600.05, -1098.47, 25.42,   0.00, 0.00, -167.00, 300, 0);
	CreateStreamObject(3475, 1598.41, -1092.78, 25.42,   0.00, 0.00, -161.00, 300, 0);
	CreateStreamObject(3475, 1596.51, -1087.18, 25.42,   0.00, 0.00, -161.00, 300, 0);
	CreateStreamObject(3475, 1594.38, -1081.67, 25.42,   0.00, 0.00, -157.00, 300, 0);
	CreateStreamObject(3475, 1591.78, -1076.38, 25.42,   0.00, 0.00, -151.00, 300, 0);
	CreateStreamObject(3475, 1589.01, -1071.15, 25.42,   0.00, 0.00, -153.00, 300, 0);
	CreateStreamObject(3475, 1586.21, -1065.91, 25.42,   0.00, 0.00, -151.00, 300, 0);
	CreateStreamObject(3475, 1582.93, -1060.99, 25.42,   0.00, 0.00, -142.00, 300, 0);
	CreateStreamObject(3475, 1579.31, -1056.31, 25.42,   0.00, 0.00, -142.00, 300, 0);
	CreateStreamObject(3475, 1575.66, -1051.66, 25.42,   0.00, 0.00, -142.00, 300, 0);
	CreateStreamObject(3475, 1571.63, -1047.31, 25.42,   0.00, 0.00, -133.00, 300, 0);
	CreateStreamObject(3475, 1567.13, -1043.38, 25.42,   0.00, 0.00, -129.00, 300, 0);
	CreateStreamObject(3475, 1562.33, -1040.06, 25.42,   0.00, 0.00, -121.00, 300, 0);
	CreateStreamObject(3475, 1557.03, -1037.50, 25.42,   0.00, 0.00, -111.00, 300, 0);
	CreateStreamObject(3475, 1552.45, -1035.70, 25.42,   0.00, 0.00, -288.00, 300, 0);
	CreateStreamObject(3475, 1545.08, -1033.40, 25.42,   0.00, 0.00, -108.00, 300, 0);
	CreateStreamObject(3475, 1539.37, -1031.54, 25.42,   0.00, 0.00, -108.00, 300, 0);
	CreateStreamObject(3475, 1535.80, -1027.47, 25.42,   0.00, 0.00, -166.00, 300, 0);
	CreateStreamObject(3475, 1536.50, -1021.83, 25.42,   0.00, 0.00, -204.00, 300, 0);
	CreateStreamObject(3475, 1538.93, -1016.37, 25.42,   0.00, 0.00, -204.00, 300, 0);
	CreateStreamObject(3475, 1541.50, -1011.02, 25.42,   0.00, 0.00, -207.00, 300, 0);
	CreateStreamObject(3475, 1543.95, -1005.60, 25.42,   0.00, 0.00, -202.00, 300, 0);
	CreateStreamObject(3475, 1650.40, -1146.70, 25.42,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(3475, 1686.08, -1144.45, 25.42,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(3475, 1686.06, -1138.56, 25.42,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(3475, 1686.05, -1132.61, 25.42,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(3475, 1686.05, -1126.64, 25.42,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(3475, 1686.05, -1120.65, 25.42,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(3475, 1686.06, -1114.71, 25.42,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(3475, 1686.07, -1108.80, 25.42,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(3475, 1686.07, -1103.08, 25.42,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(3475, 1685.89, -1097.21, 25.42,   0.00, 0.00, 4.00, 300, 0);
	CreateStreamObject(7371, 1697.69, -1094.03, 23.05,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(7371, 1817.69, -1082.12, 23.05,   0.00, 0.00, -180.00, 300, 0);
	CreateStreamObject(980, 1961.84, -2189.83, 15.29,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(10183, 1778.50, -1914.90, 12.41,   0.00, 0.00, 135.50, 300, 0);
	CreateStreamObject(10183, 1778.50, -1884.70, 12.41,   0.00, 0.00, 135.50, 300, 0);
	CreateStreamObject(10183, 1802.52, -1920.33, 12.41,   0.00, 0.10, 315.50, 300, 0);
	CreateStreamObject(10183, 1802.52, -1950.50, 12.41,   0.00, 0.10, 315.50, 300, 0);
	CreateStreamObject(9825, 1780.31, -1934.18, 12.40,   0.00, 0.14, 90.00, 300, 0);
	CreateStreamObject(10183, 2096.04, -1806.97, 12.41,   0.00, 0.10, 315.50, 300, 0);
	CreateStreamObject(10183, 2113.74, -1782.25, 12.41,   0.00, 0.00, 225.00, 300, 0);
	CreateStreamObject(10183, 2155.59, -1793.90, 12.41,   0.00, 0.00, 45.00, 300, 0);
	CreateStreamObject(10183, 2170.61, -1807.72, 12.41,   0.00, 0.00, 225.00, 300, 0);
	CreateStreamObject(10183, 1346.23, -1753.55, 12.39,   0.00, 0.00, 225.00, 300, 0);
	CreateStreamObject(10183, 1014.85, -1361.99, 12.39,   0.00, 0.00, 315.00, 300, 0);
	CreateStreamObject(10183, 1000.72, -1356.93, 12.39,   0.00, 0.00, 135.00, 300, 0);
	CreateStreamObject(10183, 1213.07, -876.34, 42.03,   0.00, 1.00, 55.50, 300, 0);
	CreateStreamObject(10183, 1193.16, -879.86, 42.13,   0.00, 1.00, 55.50, 300, 0);
	CreateStreamObject(10183, 2792.60, -1446.30, 39.10,   0.00, 0.00, 135.50, 300, 0);
	CreateStreamObject(10183, 2816.90, -1446.30, 39.10,   0.00, 0.00, 315.50, 300, 0);
	CreateStreamObject(10183, 2816.90, -1446.30, 35.10,   0.00, 0.00, 315.50, 300, 0);
	CreateStreamObject(10183, 2816.90, -1446.30, 31.13,   0.00, 0.00, 315.50, 300, 0);
	CreateStreamObject(10183, 2816.90, -1446.30, 27.16,   0.00, 0.00, 315.50, 300, 0);
	CreateStreamObject(10183, 2816.90, -1446.30, 23.19,   0.00, 0.00, 315.50, 300, 0);
	CreateStreamObject(10183, 2816.90, -1446.30, 19.22,   0.00, 0.00, 315.50, 300, 0);
	CreateStreamObject(10183, 2816.90, -1446.30, 15.26,   0.00, 0.00, 315.50, 300, 0);
	CreateStreamObject(10183, 2792.60, -1446.30, 35.10,   0.00, 0.00, 135.50, 300, 0);
	CreateStreamObject(10183, 2792.60, -1446.30, 31.13,   0.00, 0.00, 135.50, 300, 0);
	CreateStreamObject(10183, 2792.60, -1446.30, 27.16,   0.00, 0.00, 135.50, 300, 0);
	CreateStreamObject(10183, 2792.60, -1446.30, 23.19,   0.00, 0.00, 135.50, 300, 0);
	CreateStreamObject(10183, 2792.60, -1446.30, 19.22,   0.00, 0.00, 135.50, 300, 0);
	CreateStreamObject(10183, 2792.60, -1446.30, 15.25,   0.00, 0.00, 135.50, 300, 0);
	CreateStreamObject(10183, 1246.43, -2024.11, 58.90,   0.00, 0.00, 135.00, 300, 0);
	CreateStreamObject(10183, 1276.21, -2026.80, 58.06,   0.00, -0.20, 315.62, 300, 0);
	CreateStreamObject(10183, 1261.98, -2017.75, 58.46,   0.00, 0.00, 135.00, 300, 0);
	CreateStreamObject(10183, -1781.50, 1292.00, 21.59,   0.00, 0.00, 222.50, 300, 0);
	CreateStreamObject(10183, -1845.30, 1283.20, 21.59,   0.00, 0.00, 245.50, 300, 0);
	CreateStreamObject(1280, 1542.50, -1658.80, 12.96,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1280, 1542.50, -1664.10, 12.96,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1280, 1542.50, -1687.30, 12.96,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1280, 1542.50, -1692.60, 12.96,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1359, 1542.50, -1661.45, 13.24,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1359, 1542.50, -1689.95, 13.24,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1229, 1798.80, -1617.60, 14.11,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 1795.70, -1621.50, 13.82,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 1771.30, -1597.28, 13.82,   0.00, 0.00, 76.00, 300, 0);
	CreateStreamObject(1229, 1767.50, -1599.40, 14.11,   0.00, 0.00, 76.00, 300, 0);
	CreateStreamObject(1257, 1812.60, -1914.00, 13.82,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(1229, 1815.70, -1916.80, 14.11,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(1257, 1830.60, -1892.10, 13.70,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1229, 1827.40, -1889.40, 14.11,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1257, 1994.70, -2175.55, 13.82,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1229, 1997.50, -2172.30, 14.11,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 1986.80, -2157.50, 13.82,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 1983.90, -2160.75, 14.11,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1257, 2223.80, -1987.20, 13.82,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1229, 2219.70, -1984.00, 14.11,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1257, 2204.75, -1996.90, 13.82,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(1229, 2208.00, -1999.80, 14.11,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(1257, 2291.30, -1741.30, 13.82,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1229, 2294.30, -1737.90, 14.11,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 2281.25, -1722.60, 13.82,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 2278.20, -1726.40, 14.11,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1257, 2670.50, -1666.40, 11.13,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1229, 2673.50, -1663.00, 11.45,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 2688.90, -1648.40, 11.84,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 2685.80, -1651.70, 12.09,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1257, 2690.90, -1248.43, 57.20,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1850, 2693.22, -1247.37, 55.59,   90.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1850, 2690.23, -1247.37, 55.10,   90.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1850, 2690.23, -1247.44, 53.97,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1229, 2687.70, -1251.40, 56.53,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 2682.30, -1262.60, 55.55,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 2679.10, -1265.75, 55.09,   0.00, 0.00, 267.00, 300, 0);
	CreateStreamObject(1850, 2690.22, -1247.38, 55.59,   90.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1850, 2677.91, -1266.76, 53.46,   90.00, 0.00, 177.00, 300, 0);
	CreateStreamObject(1850, 2680.90, -1266.92, 53.46,   90.00, 0.00, 177.00, 300, 0);
	CreateStreamObject(1850, 2677.90, -1266.76, 52.90,   90.00, 0.00, 177.00, 300, 0);
	CreateStreamObject(1257, 2249.80, -1132.30, 26.55,   0.00, 0.00, 69.00, 300, 0);
	CreateStreamObject(1229, 2245.70, -1134.00, 26.70,   0.00, 0.00, 70.00, 300, 0);
	CreateStreamObject(1257, 2247.80, -1150.35, 26.37,   0.00, 0.00, 254.50, 300, 0);
	CreateStreamObject(1229, 2251.40, -1148.10, 26.71,   0.00, 0.00, 260.00, 300, 0);
	CreateStreamObject(1499, 1548.05, -1034.33, 23.10,   0.00, 0.00, 340.00, 300, 0);
	CreateStreamObject(3475, 1656.36, -1146.70, 25.42,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(3475, 1662.32, -1146.70, 25.42,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(3475, 1668.28, -1146.70, 25.42,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(3475, 1674.24, -1146.70, 25.42,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(3475, 1680.20, -1146.70, 25.42,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1257, 1676.10, -1151.90, 24.10,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1257, 1662.49, -1169.92, 24.10,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1229, 1673.10, -1155.10, 24.40,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 1665.70, -1166.70, 24.40,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 1383.90, -1132.40, 24.10,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 1380.60, -1135.80, 24.40,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1257, 1386.60, -1152.80, 24.10,   0.00, 0.00, 260.00, 300, 0);
	CreateStreamObject(1229, 1390.30, -1149.30, 24.40,   0.00, 0.00, 260.00, 300, 0);
	CreateStreamObject(1229, 923.70, -1135.20, 24.40,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1257, 926.80, -1132.00, 24.12,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 919.10, -1154.80, 24.40,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 916.00, -1157.00, 24.12,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 854.90, -1310.00, 13.83,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 851.90, -1314.40, 14.10,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 837.20, -1333.10, 14.10,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 834.00, -1336.33, 13.83,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 975.80, -1581.20, 13.82,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 968.80, -1563.40, 13.82,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 979.00, -1578.10, 14.10,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1229, 965.80, -1566.60, 14.10,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1257, 460.95, -1539.40, 29.60,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1849, 462.02, -1539.28, 27.96,   90.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1229, 458.00, -1536.30, 30.07,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1229, 438.30, -1537.80, 30.07,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(1257, 434.76, -1534.70, 29.93,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(1257, 330.30, -1374.80, 14.53,   0.00, 0.00, 118.00, 300, 0);
	CreateStreamObject(1229, 329.30, -1379.50, 14.84,   0.00, 0.00, 118.00, 300, 0);
	CreateStreamObject(1229, 337.85, -1398.85, 14.84,   0.00, 0.00, 298.00, 300, 0);
	CreateStreamObject(1257, 336.50, -1403.25, 14.53,   0.00, 0.00, 296.00, 300, 0);
	CreateStreamObject(1257, 353.00, -1725.40, 7.07,   0.00, 0.00, 266.00, 300, 0);
	CreateStreamObject(1229, 356.30, -1722.20, 7.41,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 361.90, -1692.80, 7.07,   0.00, 0.00, 86.00, 300, 0);
	CreateStreamObject(1229, 358.40, -1695.90, 7.41,   0.00, 0.00, 87.00, 300, 0);
	CreateStreamObject(1257, 846.60, -1760.70, 13.82,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 843.30, -1763.60, 14.10,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1257, 815.60, -1793.00, 13.69,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1229, 818.60, -1789.60, 14.10,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 756.00, -1415.00, 13.80,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 768.00, -1386.00, 13.80,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 759.35, -1411.50, 14.10,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1229, 764.80, -1389.50, 14.10,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1257, 342.70, -1618.80, 33.31,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1229, 339.50, -1615.75, 33.59,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1229, 317.50, -1608.70, 33.59,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(1257, 314.20, -1605.20, 33.66,   0.00, 0.00, 182.00, 300, 0);
	CreateStreamObject(1257, 1186.80, -1374.20, 13.80,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(1229, 1189.80, -1377.80, 14.10,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(1229, 1211.65, -1367.85, 14.10,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1257, 1214.90, -1370.90, 13.80,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1229, 1232.30, -1389.50, 14.10,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 1223.70, -1411.50, 14.10,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 1219.85, -1414.75, 13.80,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 1235.90, -1386.00, 13.80,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1257, 1407.10, -930.79, 35.46,   0.00, 0.00, 80.00, 300, 0);
	CreateStreamObject(1229, 1403.24, -933.20, 35.65,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 1405.60, -955.80, 35.65,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 1401.40, -958.30, 35.50,   0.00, 0.00, 261.00, 300, 0);
	CreateStreamObject(1257, 1581.00, -1312.30, 17.73,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1229, 1584.40, -1309.20, 18.10,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1229, 1556.40, -1292.60, 17.40,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1257, 1559.80, -1290.30, 17.73,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1257, 1969.00, -1452.00, 13.80,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 1965.60, -1455.30, 14.10,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 2010.00, -1471.50, 14.10,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 2006.60, -1474.85, 13.80,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 2368.70, -1514.70, 24.27,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 2365.40, -1518.50, 24.55,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 2381.50, -1529.90, 24.55,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 2378.40, -1533.35, 24.27,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 2312.30, -1190.20, 25.81,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1229, 2309.00, -1187.00, 26.10,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1257, 2294.50, -1212.00, 24.28,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(1229, 2297.90, -1215.60, 24.57,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(1257, 2679.00, -1056.80, 69.85,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 2669.60, -1038.80, 69.85,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 2682.30, -1053.30, 70.13,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1229, 2666.30, -1042.30, 70.13,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 2846.70, -1567.10, 11.65,   0.00, 0.00, 160.00, 300, 0);
	CreateStreamObject(1257, 2844.80, -1562.50, 11.36,   0.00, 0.00, 161.00, 300, 0);
	CreateStreamObject(1257, 2867.10, -1552.10, 11.36,   0.00, 0.00, 341.50, 300, 0);
	CreateStreamObject(1229, 2865.00, -1547.80, 11.65,   0.00, 0.00, 340.00, 300, 0);
	CreateStreamObject(1257, 2723.10, -1961.40, 13.82,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1229, 2719.80, -1957.50, 14.10,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1257, 2705.20, -1963.00, 13.82,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(1229, 2708.60, -1966.40, 14.10,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(1257, 2379.00, -1981.30, 13.82,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 2391.70, -1963.45, 13.82,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 2388.20, -1966.80, 14.10,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 2382.50, -1978.00, 14.10,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1257, 2094.70, -1778.23, 13.82,   0.00, 0.00, 345.00, 300, 0);
	CreateStreamObject(1229, 2092.40, -1774.00, 14.10,   0.00, 0.00, 345.00, 300, 0);
	CreateStreamObject(1229, 2078.20, -1783.20, 14.10,   0.00, 0.00, 165.00, 300, 0);
	CreateStreamObject(1257, 2075.50, -1779.10, 13.82,   0.00, 0.00, 163.00, 300, 0);
	CreateStreamObject(1257, 1439.54, -2266.60, 13.82,   0.00, 0.00, 339.00, 300, 0);
	CreateStreamObject(1257, 1428.70, -2250.10, 13.82,   0.00, 0.00, 145.00, 300, 0);
	CreateStreamObject(1229, 1429.40, -2254.60, 14.10,   0.00, 0.00, 145.00, 300, 0);
	CreateStreamObject(1229, 1437.95, -2262.10, 14.10,   0.00, 0.00, 340.00, 300, 0);
	CreateStreamObject(1257, 690.20, -571.50, 16.61,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1257, 672.70, -562.30, 16.61,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(1229, 687.40, -568.20, 16.90,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1229, 676.10, -565.50, 16.90,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(1257, 241.70, -49.80, 1.85,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1257, 223.80, -109.00, 1.85,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(1229, 227.20, -112.30, 2.14,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(1229, 238.40, -46.40, 2.14,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1257, 1346.90, 310.00, 19.83,   0.00, 0.00, 66.00, 300, 0);
	CreateStreamObject(1257, 1336.80, 294.90, 19.83,   0.00, 0.00, 246.00, 300, 0);
	CreateStreamObject(1229, 1342.60, 308.40, 20.11,   0.00, 0.00, 66.00, 300, 0);
	CreateStreamObject(1229, 1341.10, 296.60, 20.11,   0.00, 0.00, 246.00, 300, 0);
	CreateStreamObject(1257, 2285.00, 2.80, 26.76,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(1257, 2302.80, -1.89, 26.76,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1229, 2299.70, 1.40, 27.03,   0.00, 0.00, 0.00, 300, 0);
	CreateStreamObject(1229, 2288.30, -0.40, 27.03,   0.00, 0.00, 180.00, 300, 0);
	CreateStreamObject(10183, -2620.20, 1335.00, 5.94,   0.00, 1.05, 315.50, 300, 0);
	CreateStreamObject(10183, -2644.20, 1370.81, 6.07,   0.00, 0.00, 135.50, 300, 0);
	CreateStreamObject(10183, -2644.20, 1350.70, 6.07,   0.00, 0.00, 135.50, 300, 0);
	CreateStreamObject(10183, -2635.78, 1328.40, 5.94,   0.00, 1.05, 270.50, 300, 0);
	CreateStreamObject(10183, -2620.20, 1358.50, 5.94,   0.00, 1.05, 315.50, 300, 0);
	CreateStreamObject(1257, 1469.00, -1583.36, 13.82,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1257, 1494.80, -1600.80, 13.82,   0.00, 0.00, 270.00, 300, 0);
	CreateStreamObject(1229, 1465.50, -1586.70, 14.11,   0.00, 0.00, 90.00, 300, 0);
	CreateStreamObject(1229, 1497.93, -1597.97, 14.11,   0.00, 0.00, 270.00, 300, 0);

	BusInterior[0] = CreateStreamObject(2631, 2022.0, 2236.7, 2102.9, 0.0, 0.0, 90.0, 100, 0);//Bus Interior
    BusInterior[1] = CreateStreamObject(2631, 2022.0, 2240.6, 2102.9, 0.0, 0.0, 90.0, 100, 0);
    BusInterior[2] = CreateStreamObject(2631, 2022.0, 2244.5, 2102.9, 0.0, 0.0, 90.0, 100, 0);
    BusInterior[3] = CreateStreamObject(2631, 2022.0, 2248.4, 2102.9, 0.0, 0.0, 90.0, 100, 0);
    BusInterior[4] = CreateStreamObject(16501, 2022.1, 2238.3, 2102.8, 0.0, 90.0, 0.0, 100, 0);
    BusInterior[5] = CreateStreamObject(16501, 2022.1, 2245.3, 2102.8, 0.0, 90.0, 0.0, 100, 0);
    BusInterior[6] = CreateStreamObject(16000, 2024.2, 2240.1, 2101.2, 0.0, 0.0, 90.0, 100, 0);
    BusInterior[7] = CreateStreamObject(16000, 2019.8, 2240.6, 2101.2, 0.0, 0.0, -90.0, 100, 0);
    BusInterior[8] = CreateStreamObject(16000, 2022.2, 2248.7, 2101.2, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[9] = CreateStreamObject(16501, 2021.8, 2246.5, 2107.3, 0.0, 270.0, 90.0, 100, 0);
    BusInterior[10] = CreateStreamObject(16501, 2022.0, 2240.8, 2107.3, 0.0, 270.0, 0.0, 100, 0);
    BusInterior[11] = CreateStreamObject(16501, 2022.0, 2233.7, 2107.3, 0.0, 270.0, 0.0, 100, 0);
    BusInterior[12] = CreateStreamObject(18098, 2024.3, 2239.6, 2104.8, 0.0, 0.0, 90.0, 100, 0);
    BusInterior[13] = CreateStreamObject(18098, 2024.3, 2239.7, 2104.7, 0.0, 0.0, 450.0, 100, 0);
    BusInterior[14] = CreateStreamObject(18098, 2020.1, 2239.6, 2104.8, 0.0, 0.0, 90.0, 100, 0);
    BusInterior[15] = CreateStreamObject(18098, 2020.0, 2239.6, 2104.7, 0.0, 0.0, 90.0, 100, 0);
    BusInterior[16] = CreateStreamObject(2180, 2023.6, 2236.1, 2106.7, 0.0, 180.0, 90.0, 100, 0);
    BusInterior[17] = CreateStreamObject(2180, 2023.6, 2238.1, 2106.7, 0.0, 180.0, 90.0, 100, 0);
    BusInterior[18] = CreateStreamObject(2180, 2023.6, 2240.1, 2106.7, 0.0, 180.0, 90.0, 100, 0);
    BusInterior[19] = CreateStreamObject(2180, 2023.6, 2242.1, 2106.7, 0.0, 180.0, 90.0, 100, 0);
    BusInterior[20] = CreateStreamObject(2180, 2023.6, 2244.1, 2106.7, 0.0, 180.0, 90.0, 100, 0);
    BusInterior[21] = CreateStreamObject(2180, 2023.6, 2246.1, 2106.7, 0.0, 180.0, 90.0, 100, 0);
    BusInterior[22] = CreateStreamObject(2180, 2023.6, 2248.1, 2106.7, 0.0, 180.0, 90.0, 100, 0);
    BusInterior[23] = CreateStreamObject(2180, 2020.3, 2235.1, 2106.7, 0.0, 180.0, 270.0, 100, 0);
    BusInterior[24] = CreateStreamObject(2180, 2020.3, 2237.1, 2106.7, 0.0, 180.0, 270.0, 100, 0);
    BusInterior[25] = CreateStreamObject(2180, 2020.3, 2239.1, 2106.7, 0.0, 180.0, 270.0, 100, 0);
    BusInterior[26] = CreateStreamObject(2180, 2020.3, 2241.1, 2106.7, 0.0, 180.0, 270.0, 100, 0);
    BusInterior[27] = CreateStreamObject(2180, 2020.3, 2243.1, 2106.7, 0.0, 180.0, 270.0, 100, 0);
    BusInterior[28] = CreateStreamObject(2180, 2020.3, 2245.1, 2106.7, 0.0, 180.0, 270.0, 100, 0);
    BusInterior[29] = CreateStreamObject(2674, 2023.4, 2238.3, 2102.9, 0.0, 0.0, 600.0, 100, 0);
    BusInterior[30] = CreateStreamObject(2674, 2020.4, 2242.3, 2102.9, 0.0, 0.0, 600.0, 100, 0);
    BusInterior[31] = CreateStreamObject(2674, 2023.4, 2246.3, 2102.9, 0.0, 0.0, 600.0, 100, 0);
    BusInterior[32] = CreateStreamObject(14405, 2022.0, 2242.1, 2103.5, 0.0, 0.0, 540.0, 100, 0);
    BusInterior[33] = CreateStreamObject(14405, 2022.0, 2243.6, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[34] = CreateStreamObject(14405, 2022.0, 2245.1, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[35] = CreateStreamObject(14405, 2022.0, 2246.6, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[36] = CreateStreamObject(14405, 2022.0, 2248.1, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[37] = CreateStreamObject(14405, 2022.0, 2249.6, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[38] = CreateStreamObject(14405, 2022.0, 2251.1, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[39] = CreateStreamObject(14405, 2024.6, 2242.1, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[40] = CreateStreamObject(14405, 2024.6, 2243.6, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[41] = CreateStreamObject(14405, 2024.6, 2245.1, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[42] = CreateStreamObject(14405, 2024.6, 2246.6, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[43] = CreateStreamObject(14405, 2024.6, 2248.1, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[44] = CreateStreamObject(14405, 2024.6, 2249.6, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[45] = CreateStreamObject(14405, 2024.6, 2251.1, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[46] = CreateStreamObject(14405, 2019.4, 2242.1, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[47] = CreateStreamObject(14405, 2019.4, 2243.6, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[48] = CreateStreamObject(14405, 2019.4, 2245.1, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[49] = CreateStreamObject(14405, 2019.4, 2246.6, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[50] = CreateStreamObject(14405, 2019.4, 2248.1, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[51] = CreateStreamObject(14405, 2019.4, 2249.6, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[52] = CreateStreamObject(14405, 2019.4, 2251.1, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[53] = CreateStreamObject(14405, 2022.0, 2253.6, 2104.0, -6.0, 0.0, 180.0, 100, 0);
    BusInterior[54] = CreateStreamObject(14405, 2021.1, 2253.6, 2104.0, -6.0, 0.0, 180.0, 100, 0);
    BusInterior[55] = CreateStreamObject(14405, 2024.6, 2253.6, 2103.5, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[56] = CreateStreamObject(2674, 2020.4, 2235.7, 2102.9, 0.0, 0.0, 52.0, 100, 0);
    BusInterior[57] = CreateStreamObject(2673, 2020.4, 2246.7, 2102.9, 0.0, 0.0, 270.0, 100, 0);
    BusInterior[58] = CreateStreamObject(2700, 2023.5, 2235.1, 2105.5, 180.0, -4.0, 90.0, 100, 0);
    BusInterior[59] = CreateStreamObject(2700, 2020.4, 2235.1, 2105.5, 180.0, 0.0, 90.0, 100, 0);
    BusInterior[60] = CreateStreamObject(2700, 2023.5, 2242.1, 2105.5, 180.0, -4.0, 90.0, 100, 0);
    BusInterior[61] = CreateStreamObject(2700, 2020.4, 2242.1, 2105.5, 180.0, 0.0, 90.0, 100, 0);
    BusInterior[62] = CreateStreamObject(1799, 2023.1, 2234.2, 2105.7, 270.0, 0.0, 360.0, 100, 0);
    BusInterior[63] = CreateStreamObject(1799, 2019.8, 2234.2, 2105.7, 270.0, 0.0, 0.0, 100, 0);
    BusInterior[64] = CreateStreamObject(1538, 2022.7, 2234.7, 2102.8, 0.0, 0.0, 180.0, 100, 0);
    BusInterior[65] = CreateStreamObject(1799, 2022.1, 2234.2, 2106.1, 720.0, 90.0, 450.0, 100, 0);
    BusInterior[66] = CreateStreamObject(1799, 2021.8, 2234.2, 2105.1, 0.0, 270.0, 270.0, 100, 0);
    BusInterior[67] = CreateStreamObject(1799, 2022.1, 2234.2, 2107.3, 0.0, 90.0, 90.0, 100, 0);
    BusInterior[68] = CreateStreamObject(1799, 2021.6, 2234.2, 2106.3, 0.0, 270.0, 270.0, 100, 0);
    BusInterior[69] = CreateStreamObject(1799, 2022.3, 2234.2, 2104.3, 90.0, 0.0, 180.0, 100, 0);//
	return 1;
}
public OnGameModeExit(){
	DestroyMenuColor();
	TextDrawStreamDestroy(Zeit[0]);
	TextDrawStreamDestroy(Zeit[1]);
	TextDrawStreamDestroy(Zeit[2]);
	SaveCars();
	return 1;
}
public OnPlayerRequestClass(playerid, classid){
	new string[255];
	if(!udb_Exists(PlayerName(playerid))){
		SetPlayerPos(playerid, 1174.8, -1182.6, 91.41113);
		SetWorldTime(1);
		SetPlayerFacingAngle(playerid, 90);
		SetPlayerCameraPos(playerid, 1173.0, -1182.8, 90.8);
		SetPlayerCameraLookAt(playerid, 1175.0, -1183.0, 92.0);
		format(string, sizeof string, ""WHITE"Welcome "BLUE"%s! \n"WHITE"Please Register your account!", PlayerName(playerid));
		ShowPlayerDialog(playerid, Register, DIALOG_STYLE_INPUT, ""WHITE"Account Register", string, "Register", "Cancel");
	}
	else if(!PlayerInfo[playerid][loggedin]){
		format(string, sizeof string, ""WHITE"Welcome "BLUE"%s! "WHITE"\n\nPlease Login to your account!", PlayerName(playerid));
		ShowPlayerDialog(playerid, Login, DIALOG_STYLE_INPUT, ""BLUE"Account Login", string, "Login", "Cancel");
	}
	return 1;
}
public OnPlayerConnect(playerid){
	GameTextForPlayer(playerid,"Carlito's Way",8000,1);
	SetPlayerCameraPos(playerid, 1948.0, -1606.0, 150.0);
	SetPlayerCameraLookAt(playerid, 1560.0, -1380.0, 220.0);
	PlayerInfo[playerid][menushown] = -1;
	PlayerInfo[playerid][loggedin]=false;
	PlayerInfo[playerid][pathedit] = false;
	PlayerInfo[playerid][Pathdistance] = 5.0;
	PlayerInfo[playerid][BusID] = -1;
    PlayerInfo[playerid][BusCost] = 0;
	CreateCarMenu(playerid);
	for (new i = 0; i < 4; i++){
		PlayerInfo[playerid][SpeedClock][i] = TextDrawStreamCreate(0.0, 0.0, "~b~.");
		TextDrawStreamLetterSize(PlayerInfo[playerid][SpeedClock][i], 0.73, 2.60);
		TextDrawStreamFont(PlayerInfo[playerid][SpeedClock][i], 2);
		TextDrawStreamSetOutline(PlayerInfo[playerid][SpeedClock][i], 0);
		TextDrawStreamSetShadow(PlayerInfo[playerid][SpeedClock][i], 1);
		TextDrawStreamUseBox(PlayerInfo[playerid][SpeedClock][i], 0);
	}
	return 1;
}
public OnPlayerDisconnect(playerid, reason){
	DestroyCarMenu(playerid);
	PlayerInfo[playerid][loggedin]=false;
	PlayerInfo[playerid][pathedit] = false;
	PlayerInfo[playerid][BusRoute] = -1;
	TextDrawStreamHideForPlayer(playerid,Zeit[0]);
	TextDrawStreamHideForPlayer(playerid,Zeit[1]);
	TextDrawStreamHideForPlayer(playerid,Zeit[2]);
	return 1;
}
public OnPlayerSpawn(playerid){
	TextDrawStreamShowForPlayer(playerid,Zeit[0]);
	TextDrawStreamShowForPlayer(playerid,Zeit[1]);
	TextDrawStreamShowForPlayer(playerid,Zeit[2]);
	if( PlayerInfo[playerid][carSelect] > 0  ){
	    PlayerInfo[playerid][carSelect] = 0;
		return 0;
	}
	PlayerInfo[playerid][Skin] = GetPlayerSkin(playerid);
	SavePlayer(playerid);
	return 1;
}
public OnPlayerDeath(playerid, killerid, reason){
	return 1;
}
public OnPlayerText(playerid, text[]){
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[]){
	new cmd[256], tmp[256];
	new idx;
	new string[255];
	cmd = strtok(cmdtext, idx);
	if(strcmp(cmd, "/car", true) ==0){
		if(PlayerInfo[playerid][carSelect] == 0){
			PlayerInfo[playerid][PlayerPos][2] = GetXYInFrontOfPlayer(playerid,  PlayerInfo[playerid][PlayerPos][0],  PlayerInfo[playerid][PlayerPos][1], 5.0);
			GetPlayerFacingAngle(playerid, PlayerInfo[playerid][PlayerPos][3]);
			PlayerInfo[playerid][itemPlace][0] = 1;
			PlayerInfo[playerid][itemPlace][1] = GetFirstCar(PlayerInfo[playerid][itemPlace][0]);
			PlayerInfo[playerid][itemPlace][2] = 0;
			PlayerInfo[playerid][itemPlace][3] = 0;
			UpdateCar(playerid);
			PlayerInfo[playerid][carSelect] = 1;
			carsmenucreated++;
			format( string, sizeof(string), "%s", carType[PlayerInfo[playerid][itemPlace][0]][nameb]);
			F_ChangeMenuItem(PlayerInfo[playerid][vehbuymenu][30],0,string);
			format( string, sizeof(string), "%s", carDefines[PlayerInfo[playerid][itemPlace][1]][namec]);
			F_ChangeMenuItem(PlayerInfo[playerid][vehbuymenu][30],1,string);
			F_ShowMenu(PlayerInfo[playerid][vehbuymenu][30], playerid);
			return 1;
		}
	}
	if(strcmp(cmd, "/pathedit", true) == 0){
		tmp = strtok(cmdtext,idx);
		if(strlen(tmp)){
			format(string, sizeof(string),"//$ endregion");
			writepath(playerid,string);
			format(string, sizeof(string),"Streetname: %s", tmp);
			SendClientMessage(playerid,COLOR_WHITE,string);
			format(string, sizeof(string),"//$ region %s", tmp);
			writepath(playerid,string);
			return 1;
		}
		if (PlayerInfo[playerid][pathedit] >= 1){
			SendClientMessage(playerid,COLOR_GREEN,"Patheditor: OFF");
			PlayerInfo[playerid][pathedit] = 0;
		}
		else {
			SendClientMessage(playerid,COLOR_GREEN,"Patheditor: ON");
			PlayerInfo[playerid][pathedit] = 1;
		}
		return 1;
	}
	if(strcmp(cmd, "/pathdistance", true) == 0){
		tmp = strtok(cmdtext,idx);
		if(!strlen(tmp)){
			SendClientMessage(playerid,COLOR_GREEN,"Usage: /pathdistance [distance]");
			return 1;
		}
		PlayerInfo[playerid][Pathdistance] = strval(tmp);
		return 1;
	}
	if(strcmp(cmd, "/setbus", true) == 0){
		tmp = strtok(cmdtext,idx);
		if(!strlen(tmp)){
			SendClientMessage(playerid,COLOR_GREEN,"Usage: /setbus LSBlueF | LSBlueR | LSBlackF | LSBlackR | LSRedF | LSRedR");
			return 1;
		}
		if ( IsPlayerInAnyVehicle(playerid) && GetVehicleModel(GetPlayerVehicleID(playerid)) ==  431){
			if(strcmp(tmp, "LSBlueF", true) == 0){
				Busses[0] = GetPlayerStreamVehicleID(playerid);
				SendClientMessage(playerid,COLOR_GREEN,"U set the Bus for Los Santos Blue Lane forward!");
			}
			else if(strcmp(tmp, "LSBlueR", true) == 0){
				Busses[1] = GetPlayerStreamVehicleID(playerid);
				SendClientMessage(playerid,COLOR_GREEN,"U set the Bus for Los Santos Blue Lane reverse!");
			}
			else if(strcmp(tmp, "LSBlackF", true) == 0){
				Busses[2] = GetPlayerStreamVehicleID(playerid);
				SendClientMessage(playerid,COLOR_GREEN,"U set the Bus for Los Santos Black Lane forward!");
			}
			else if(strcmp(tmp, "LSBlackR", true) == 0){
				Busses[3] = GetPlayerStreamVehicleID(playerid);
				SendClientMessage(playerid,COLOR_GREEN,"U set the Bus for Los Santos Black Lane reverse!");
			}
			else if(strcmp(tmp, "LSRedF", true) == 0){
				Busses[4] = GetPlayerStreamVehicleID(playerid);
				SendClientMessage(playerid,COLOR_GREEN,"U set the Bus for Los Santos Red Lane forward!");
			}
			else if(strcmp(tmp, "LSRedR", true) == 0){
				Busses[5] = GetPlayerStreamVehicleID(playerid);
				SendClientMessage(playerid,COLOR_GREEN,"U set the Bus for the Red Lane reverse!");
			}
			else{
				SendClientMessage(playerid,COLOR_GREEN,"Usage: /setbus LSBlueF | LSBlueR | LSBlackF | LSBlackR | LSRedF | LSRedR");
				return 1;
			}
		}
		else{
			SendClientMessage(playerid,COLOR_GREEN,"U are not in a Bus!");
		}
		return 1;
	}
	return 0;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
    new string[128];
    if(newkeys == KEY_SECONDARY_ATTACK){
        if(IsPlayerConnected(playerid)){
            if(IsPlayerInRangeOfPoint(playerid, 1, 2021.9740,2235.6626,2103.9536)){
				/*
				new Float:busx, Float:busy, Float:busz, Float:angle;
				if(BusID[playerid] == 1){
		            GetVehiclePos(NPCBlueBus, busx, busy, busz);
				    GetVehicleZAngle(NPCBlueBus, angle);
				}
				else{
					GetVehiclePos(NPCBlackBus, busx, busy, busz);
				    GetVehicleZAngle(NPCBlackBus, angle);
				}
				angle = 360 - angle;
				busx = floatsin(angle,degrees) * 1.5 + floatcos(angle,degrees) * 1.5 + busx;
				busy = floatcos(angle,degrees) * 1 - floatsin(angle,degrees) * 1 + busy;
				busz = 1 + busz;
				*/
				GetPlayerName(playerid, string, sizeof(string));
				format(string, sizeof(string), "%s opens the door and exits the bus.", string);
				for(new i=0; i<MAX_PLAYERS; i++){
				    if(PlayerInfo[i][BusID] == PlayerInfo[playerid][BusID]){
						SendClientMessage(i, COLOR_GREEN, string);
				    }
				}
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerInterior(playerid, 0);
				PutPlayerInStreamVehicle(playerid, PlayerInfo[playerid][BusID], 1);
				if ( PlayerInfo[playerid][BusCost] > 0 ){
					format(string, sizeof(string), "~r~-$%d", PlayerInfo[playerid][BusCost]);
					GameTextForPlayer(playerid, string, 3000, 1);
					GivePlayerMoneyEx(playerid, -PlayerInfo[playerid][BusCost]);
					PlayerInfo[playerid][BusCost] = 0;
				}
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("DeleteBusID",1000,0,"i", playerid)
            }
		}
    }
	return 1;
}
public OnPlayerUpdate(playerid){
	new Float:fPos[3], Float:Pos[4][2], Float:PPos[4], Float:Pathdist;
	new string[255];
	new moneyz = GetPlayerMoney(playerid);
	if ( PlayerInfo[playerid][pathedit] >= 1 ){
		GetPlayerPos(playerid, PPos[0], PPos[1], PPos[2]);
		GetPlayerFacingAngle(playerid, PPos[3]);
		if ( PlayerInfo[playerid][pathedit] == 1 ){
			PlayerInfo[playerid][PathPos][0] = PPos[0];
			PlayerInfo[playerid][PathPos][1] = PPos[1];
			PlayerInfo[playerid][PathPos][2] = PPos[2];
			PlayerInfo[playerid][PathPos][3] = PPos[3];
			PlayerInfo[playerid][pathedit]++;
			format(string, sizeof(string),"%f, %f, %f, %f ", PlayerInfo[playerid][PathPos][0], PlayerInfo[playerid][PathPos][1], PlayerInfo[playerid][PathPos][2], PlayerInfo[playerid][PathPos][3]);
			SendClientMessage(playerid,COLOR_WHITE,string);
			writepath(playerid, string);
		}
		else{
			Pathdist = GetDistanceBetweenPoints(PPos[0], PPos[1], PPos[2], PlayerInfo[playerid][PathPos][0], PlayerInfo[playerid][PathPos][1], PlayerInfo[playerid][PathPos][2]);
			if ( Pathdist >= PlayerInfo[playerid][Pathdistance] ){
				PlayerInfo[playerid][PathPos][0] = PPos[0];
				PlayerInfo[playerid][PathPos][1] = PPos[1];
				PlayerInfo[playerid][PathPos][2] = PPos[2];
				PlayerInfo[playerid][PathPos][3] = PPos[3];
				format(string, sizeof(string),"%f, %f, %f, %f ", PlayerInfo[playerid][PathPos][0], PlayerInfo[playerid][PathPos][1], PlayerInfo[playerid][PathPos][2], PlayerInfo[playerid][PathPos][3]);
				SendClientMessage(playerid,COLOR_WHITE,string);
				writepath(playerid, string);
			}
		}
	}
	if(moneyz != PlayerInfo[playerid][money]){
		SetPlayerMoneyEx(playerid, PlayerInfo[playerid][money]);
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)	{
		GetVehicleVelocity(GetPlayerVehicleID(playerid), fPos[0], fPos[1], fPos[2]);
		PlayerInfo[playerid][Speed] = floatsqroot(floatpower(fPos[0], 2) + floatpower(fPos[1], 2) + floatpower(fPos[2], 2)) * 200;
		new Float:alpha = 320 - PlayerInfo[playerid][Speed];
		for(new i; i < 4; i++){
	  		GetDotXY(548, 401, Pos[i][0], Pos[i][1], alpha, (i + 1) * 8);
			TextDrawStreamPos(PlayerInfo[playerid][SpeedClock][i], Pos[i][0], Pos[i][1]);
		}
	}
	return 1;
}
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger){

	return 1;
}
public OnPlayerExitVehicle(playerid, vehicleid){
	SetTimerEx("SaveCar", 3000, 0, "i",GetVehicleStreamID(vehicleid));
	VehicleInfo[VehStreamid[vehicleid]][messagesend2]=0;
	VehicleInfo[VehStreamid[vehicleid]][messagesend3]=0;

	return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate){
	if(newstate == PLAYER_STATE_DRIVER)	{
		for (new i = 0; i < MAX_BUSROUTES; i++){
			if(GetPlayerStreamVehicleID(playerid) == Busses[i]){
				PlayerInfo[playerid][BusRoute] = i;
				ShowCheckpoint(playerid, BusCheckpoint[BusRoutes[PlayerInfo[playerid][BusRoute]][0]-1]);
			}
		}
		for(new i; i < 15; i++){
			TextDrawStreamShowForPlayer(playerid, TDSpeedClock[i]);
		}
		for(new i; i < 4; i++){
	  		TextDrawStreamShowForPlayer(playerid, PlayerInfo[playerid][SpeedClock][i]);
		}
		SendClientMessage(playerid,COLOR_WHITE,"u entered a vehicle!");
		for (new i = 0; i < MAX_PLAYERS; i++){
			VehicleInfo[GetPlayerStreamVehicleID(playerid)][playerpriority][i]=0;
		}
		for (new j = 0; j < vehcount3; j++){
			if (VehicleInfo[j][playerpriority][playerid]==1 && VehicleInfo[j][priority]!=MAX_PRIORITY-1){
				VehicleInfo[j][priority]++;
			}
		}
		VehicleInfo[GetPlayerStreamVehicleID(playerid)][priority]=0;
		VehicleInfo[GetPlayerStreamVehicleID(playerid)][playerpriority][playerid]=1;
	}
	else if(newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER){
		for(new i; i < 4; i++){
		    TextDrawStreamUnload(PlayerInfo[playerid][SpeedClock][i]);
		}
		for(new i; i < 15; i++){
			TextDrawStreamHideForPlayer(playerid, TDSpeedClock[i]);
		}
		for (new i = 0; i < MAX_BUSROUTES; i++){
			if(GetPlayerStreamVehicleID(playerid) == Busses[i]){
				PlayerInfo[playerid][BusRoute] = -1;
				for (new j = 0; j < MAX_CHECKPOINTS; j++){
					HideCheckpoint(playerid, i);
				}
			}
		}
	}
	else if ( newstate == PLAYER_STATE_PASSENGER ){
		if ( PlayerInfo[playerid][BusID] == -1 ){
			if(GetPlayerStreamVehicleID(playerid) == Busses[0]){
				GameTextForPlayer(playerid, "~w~Blue Bus Lane Forward", 3000, 1);
				PlayerInfo[playerid][BusCost] = 1;
			}
			else if(GetPlayerStreamVehicleID(playerid) == Busses[0]){
				GameTextForPlayer(playerid, "~w~Blue Bus Lane Reverse", 3000, 1);
				PlayerInfo[playerid][BusCost] = 1;
			}
			else if(GetPlayerStreamVehicleID(playerid) == Busses[0]){
				GameTextForPlayer(playerid, "~w~Black Bus Lane Forward", 3000, 1);
				PlayerInfo[playerid][BusCost] = 1;
			}
			else if(GetPlayerStreamVehicleID(playerid) == Busses[0]){
				GameTextForPlayer(playerid, "~w~Black Bus Lane Reverse", 3000, 1);
				PlayerInfo[playerid][BusCost] = 1;
			}
			else if(GetPlayerStreamVehicleID(playerid) == Busses[0]){
				GameTextForPlayer(playerid, "~w~Red Bus Lane Forward", 3000, 1);
				PlayerInfo[playerid][BusCost] = 1;
			}
			else if(GetPlayerStreamVehicleID(playerid) == Busses[0]){
				GameTextForPlayer(playerid, "~w~Red Bus Lane Reverse", 3000, 1);
				PlayerInfo[playerid][BusCost] = 1;
			}
			TogglePlayerControllable(playerid,0);
			SetPlayerVirtualWorld(playerid, GetPlayerStreamVehicleID(playerid));
			SetPlayerPos(playerid, 2021.9740,2235.6626,2103.9536);
			SetPlayerFacingAngle(playerid, 355.3504);
			SetCameraBehindPlayer(playerid);
			SetPlayerInterior(playerid, 1);
			PlayerInfo[playerid][BusID] = GetPlayerStreamVehicleID(playerid);
			SetTimerEx("TogglePlayerControllableTimed", 1100, 0, "ib", playerid, true);
		}
	}
	return 1;
}
public OnPlayerEnterCheckpoint(playerid){
	VerifyCheckpoint(playerid, 1);
	return 1;
}
public OnCheckpointEnter(playerid, checkpointid){
	for (new i = 0; i < 20; i++){
		if ( checkpointid == BusCheckpoint[BusRoutes[PlayerInfo[playerid][BusRoute]][i]-1]){
			for (new j = 0; j < MAX_PLAYERS; j++){
				if ( PlayerInfo[i][BusID] == GetPlayerStreamVehicleID(playerid) ){
					PlayerInfo[i][BusCost]++;
				}
			}
			if ( BusRoutes[PlayerInfo[playerid][BusRoute]][i+1] == 0 ){
				ShowCheckpoint(playerid, BusCheckpoint[BusRoutes[PlayerInfo[playerid][BusRoute]][0]-1]);
				return 1;
			}
			else{
				ShowCheckpoint(playerid, BusCheckpoint[BusRoutes[PlayerInfo[playerid][BusRoute]][i+1]-1]);
				return 1;
			}
		}
	}
	return 0;
}
public OnPlayerLeaveCheckpoint(playerid){
	VerifyCheckpoint(playerid, 1);
	return 1;
}
public OnCheckpointExit(playerid, checkpointid){
	return 0;
}
public OnPlayerEnterRaceCheckpoint(playerid){
	return 1;
}
public OnPlayerLeaveRaceCheckpoint(playerid){
	return 1;
}
public OnPlayerObjectMoved(playerid, objectid){
	return 1;
}
public OnPlayerPickUpPickup(playerid, pickupid){
	return 1;
}
public OnPlayerRequestSpawn(playerid){
	return 1;
}
public OnPlayerSelectedMenuRow(playerid, row){
	return 1;
}
public OnPlayerExitedMenu(playerid){
	return 1;
}
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid){
	return 1;
}
public OnPlayerStreamIn(playerid, forplayerid){
	return 1;
}
public OnPlayerStreamOut(playerid, forplayerid){
	return 1;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source){
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]){
	new string[255];
	if (dialogid == Register){
		if (response){
	        if(strlen(inputtext) <= MIN_PASS_CHAR){
				format(string, sizeof string, "Please Enter A Password\n\n"YELLOW"The Password Must Be More Then [%d] Character",MIN_PASS_CHAR);
				ShowPlayerDialog(playerid, Register, DIALOG_STYLE_INPUT, ""BLUE"Enter Password", string, "Register", "Cancel");
				return 0;
			}
			udb_Create(PlayerName(playerid),inputtext);
			PlayerInfo[playerid][loggedin] = true;
			new IP[80]; GetPlayerIp(playerid, IP, sizeof(IP));
			format(string, sizeof string, ""WHITE"You account is registered!\n\n"GREENN"USERNAME: "BLUE"%s\n"GREENN"PASSWORD: "BLUE"%s\n"GREENN"IP ADDRESS: "BLUE"%s",PlayerName(playerid),inputtext,IP);
			ShowPlayerDialog(playerid, 4568, DIALOG_STYLE_MSGBOX, ""BLUE"Your Stats!", string, "Ok", "");
			SendClientMessage(playerid, COLOR_GREEN, "||-Success-||"WHITE" You have successfully registered a new account");
			format(string, sizeof(string), ""YELLOW"[SERVER] "GREENN"%s "WHITE"Has Successfully Registered A New Account", PlayerName(playerid) );
			SendClientMessageToAll(COLOR_GREEN, string);
		}
		else{
			format(string, sizeof string, ""WHITE"Welcome "BLUE"%s! \n"WHITE"Please Register your account!", PlayerName(playerid));
			ShowPlayerDialog(playerid, Register, DIALOG_STYLE_INPUT, ""WHITE"Account Register", string, "Register", "Cancel");
		}
	}
	if (dialogid == Login){
		if( response ){
			if(udb_CheckLogin(PlayerName(playerid),inputtext)){
				PlayerInfo[playerid][loggedin] = true;
				SetCameraBehindPlayer(playerid);
				LoadPlayer(playerid);
				SendClientMessage(playerid, COLOR_GREEN, "||-Success-|| "WHITE"You have successfully logged Into Your Account");
				format(string, sizeof(string), "[SERVER] %s has successfully loged In", PlayerName(playerid) );
				SendClientMessageToAll(COLOR_GREEN, string);
			}
			else{
				if(PlayerInfo[playerid][logwarning]==2){
					PlayerInfo[playerid][logwarning]=0;
					format(string, sizeof (string), "%s kicked || Reason: incorrect password [3/3 Tries]",PlayerName(playerid));
					SendClientMessageToAll(COLOR_RED,string);
					ShowPlayerDialog(playerid, 1231, DIALOG_STYLE_INPUT, ""REDD"[ERROR]", ""REDD"FAILD TO LOGIN \n\nIncorrect Password\n"BLUE"[3/3 Tries]", "Login", "Cancel");
					Kick(playerid);
				}
				if(PlayerInfo[playerid][logwarning]==1){
					PlayerInfo[playerid][logwarning]++;
					ShowPlayerDialog(playerid, Login, DIALOG_STYLE_INPUT, ""REDD"[ERROR]", ""REDD"Incorrect Password \n"BLUE"[2/3 Tries]", "Login", "Cancel");
				}
				if(PlayerInfo[playerid][logwarning]==0){
					PlayerInfo[playerid][logwarning]++;
					ShowPlayerDialog(playerid, Login, DIALOG_STYLE_INPUT, ""REDD"[ERROR]", ""REDD"Incorrect Password \n"BLUE"[1/3 Tries]", "Login", "Cancel");
				}
			}

		}
		else{
			format(string, sizeof string, ""WHITE"Welcome "BLUE"%s! "WHITE"\n\nPlease Login to your account!", PlayerName(playerid));
			ShowPlayerDialog(playerid, Login, DIALOG_STYLE_INPUT, ""BLUE"Account Login", string, "Login", "Cancel");
		}
	}
	return 0;
}
public OnRconCommand(cmd[]){
	return 1;
}
public OnRconLoginAttempt(ip[], password[], success){
	return 1;
}
public OnObjectMoved(objectid){
	return 1;
}
public OnVehicleMod(playerid, vehicleid, componentid){
	for(new i=0;i<MAX_COMPONENTS;i++){
		if(!VehicleInfo[GetVehicleStreamID(vehicleid)][COMPONENTS][i]){
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
	VehicleInfo[GetVehicleStreamID(vehicleid)][colors][0]=color1;
	VehicleInfo[GetVehicleStreamID(vehicleid)][colors][1]=color2;
	return CallLocalFunction("OnStreamVehicleRespray","iiii",playerid,GetVehicleStreamID(vehicleid),color1,color2);
}
public OnStreamVehicleMod(playerid, vehicleid, componentid){
	return 1;
}
public OnStreamVehiclePaintjob(playerid, vehicleid, paintjobid){
	return 1;
}
public OnStreamVehicleRespray(playerid, vehicleid, color1, color2){
	return 1;
}
public OnVehicleStreamIn(vehicleid, forplayerid){
	return 1;
}
public OnVehicleStreamOut(vehicleid, forplayerid){
	return 1;
}
public OnVehicleSpawn(vehicleid){
	return 1;
}
public OnVehicleDeath(vehicleid, killerid){
	SetTimerEx("DestroyVehicleEx", 7000, false, "i", vehicleid);
	if ( GetVehicleModel(vehicleid) == 431 ){
		for (new i = 0; i < MAX_BUSROUTES; i++){
			if ( Busses[i] == GetVehicleStreamID(vehicleid)){
				Busses[i] = -1;
				switch (i){
					case 0:	SendClientMessageToAll(COLOR_GREEN, "Bus for Los Santos Blue Lane forward destroyed!");
					case 1:	SendClientMessageToAll(COLOR_GREEN, "Bus for Los Santos Blue Lane reverse destroyed!");
					case 2:	SendClientMessageToAll(COLOR_GREEN, "Bus for Los Santos Black Lane forward destroyed!");
					case 3:	SendClientMessageToAll(COLOR_GREEN, "Bus for Los Santos Black Lane reverse destroyed!");
					case 4:	SendClientMessageToAll(COLOR_GREEN, "Bus for Los Santos Red Lane forward destroyed!");
					case 5:	SendClientMessageToAll(COLOR_GREEN, "Bus for Los Santos Red Lane reverse destroyed!");
				}
			}
		}
	}
	return 1;
}
OnPlayerEnterArea(playerid,areaid){
}
OnPlayerLeaveArea(playerid,areaid){
}
//$ endregion Callbacks
public SetPlayerMoneyEx(playerid, amount){
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, amount);
}
public GivePlayerMoneyEx(playerid, amount){
	PlayerInfo[playerid][money] = PlayerInfo[playerid][money] + amount;
}
public LoadPlayer(playerid){
	new string[255];
	if (PlayerInfo[playerid][loggedin]){
		SpawnPlayer(playerid);
		PlayerInfo[playerid][PlayerPos][0] = (dUserFLOAT(PlayerName(playerid)).("x"));
		PlayerInfo[playerid][PlayerPos][1] = (dUserFLOAT(PlayerName(playerid)).("y"));
		PlayerInfo[playerid][PlayerPos][2] = (dUserFLOAT(PlayerName(playerid)).("z"));
		PlayerInfo[playerid][PlayerPos][3] = (dUserFLOAT(PlayerName(playerid)).("a"));
		SetPlayerPos(playerid, PlayerInfo[playerid][PlayerPos][0], PlayerInfo[playerid][PlayerPos][1], PlayerInfo[playerid][PlayerPos][2]);
		SetPlayerFacingAngle(playerid, PlayerInfo[playerid][PlayerPos][3]);
		PlayerInfo[playerid][Skin] = (dUserINT(PlayerName(playerid)).("skin"));
		SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);
		format(string, sizeof(string), "[PlayerLoaded] X: %f Y: %f Z: %f A: %f Skin: %d", PlayerInfo[playerid][PlayerPos][0], PlayerInfo[playerid][PlayerPos][1], PlayerInfo[playerid][PlayerPos][2], PlayerInfo[playerid][PlayerPos][3], PlayerInfo[playerid][Skin] );
		SendClientMessageToAll(COLOR_GREEN, string);
	}
	return 1;
}
public SavePlayer(playerid){
	new string[255];
	new Float:x,Float:y,Float:z,Float:a;
	if (PlayerInfo[playerid][loggedin]){
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		dUserSetFLOAT(PlayerName(playerid)).("x",x);
		dUserSetFLOAT(PlayerName(playerid)).("y",y);
		dUserSetFLOAT(PlayerName(playerid)).("z",z);
		dUserSetFLOAT(PlayerName(playerid)).("a",a);
		dUserSetINT(PlayerName(playerid)).("skin",PlayerInfo[playerid][Skin]);
		//dUserSetINT(PlayerName(playerid)).("money",PlayerInfo[playerid][money]);
		//dUserSetINT(PlayerName(playerid)).("thirsty",floatround(THIRSTY[playerid]));
		//dUserSetINT(PlayerName(playerid)).("hungry",floatround(HUNGRY[playerid]));
		//dUserSetINT(PlayerName(playerid)).("sexy",floatround(SEXY[playerid]));
		//dUserSetINT(PlayerName(playerid)).("seclevup",seclevup[playerid]);
		//dUserSetINT(PlayerName(playerid)).("minlevup",minlevup[playerid]);
		//dUserSetINT(PlayerName(playerid)).("neededhour",NeededHour[playerid]);
		//dUserSetINT(PlayerName(playerid)).("neededlevcash",NeededlevCash[playerid]);
		//dUserSetINT(PlayerName(playerid)).("playerlevel",Playerlevel[playerid]);
		//dUserSetINT(PlayerName(playerid)).("hourlevel",Hourlevel[playerid]);
		//dUserSetINT(PlayerName(playerid)).("giveRpoints",giveRespectpoints[playerid]);
		//if (IsPlayerInAnyVehicle(playerid)){
			//oldvehicle = GetPlayerVehicleID(playerid);
			//dUserSetINT(PlayerName(playerid)).("oldvehicle",oldvehicle);
		//}
		format(string, sizeof(string), "[PlayerSaved] X: %f Y: %f Z: %f A: %f Skin: %d", x, y, z, a, PlayerInfo[playerid][Skin] );
		SendClientMessageToAll(COLOR_GREEN, string);
	}
	return 1;
}
public TogglePlayerControllableTimed(playerid, toggle){
	TogglePlayerControllable(playerid,toggle);
}
public DeleteBusID(playerid){
	PlayerInfo[playerid][BusID] = -1;
}
public TimeUpdate(){
	new TimeString[255], TimeString2[255],TimeString3[255];
	new day, month, year;
	new Hour, Min, Sec;
	getdate( year, month, day );
	gettime( Hour, Min, Sec );
	format(TimeString3,256,"%d:%d %d",month,day,year);
	if (Min <= 9){
		format(TimeString,25,"%d:0%d",Hour, Min);
	}
	else{
		format(TimeString,256,"%d:%d",Hour, Min);
	}
	if (Sec <= 9){
		format(TimeString2,25,"0%d",Sec);
	}
	else{
		format(TimeString2,256,"%d",Sec);
	}
	TextDrawStreamSetString(Zeit[2],TimeString);
	TextDrawStreamSetString(Zeit[0],TimeString2);
	TextDrawStreamSetString(Zeit[1],TimeString3);
	return 1;
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
//$ region carmod-textdrawupdate
	public DestroyMenuColor(){
		for(new i = 0; i < TOTAL_COLORS; i++){
		    TextDrawStreamDestroy(vbmcolordraw[i]);
		}
		return 1;
	}
	public UnloadMenuColor(){
		for(new i = 0; i < TOTAL_COLORS; i++){
		    TextDrawStreamUnload(vbmcolordraw[i]);
		}
		return 1;
	}
	public CreateMenuColor(){
		vbmcolordraw[0] = TextDrawStreamCreate(47.500000,140.000000,"  ");
	    vbmcolordraw[1] = TextDrawStreamCreate(65.000000,140.000000,"  ");
	    vbmcolordraw[2] = TextDrawStreamCreate(82.500000,140.000000,"  ");
	    vbmcolordraw[3] = TextDrawStreamCreate(100.000000,140.000000,"  ");
	    vbmcolordraw[4] = TextDrawStreamCreate(117.500000,140.000000,"  ");
	    vbmcolordraw[5] = TextDrawStreamCreate(135.000000,140.000000,"  ");
	    vbmcolordraw[6] = TextDrawStreamCreate(152.500000,140.000000,"  ");
	    vbmcolordraw[7] = TextDrawStreamCreate(170.000000,140.000000,"  ");
	    vbmcolordraw[8] = TextDrawStreamCreate(47.500000, 157.500000,"  ");
	    vbmcolordraw[9] = TextDrawStreamCreate(65.000000, 157.500000,"  ");
	    vbmcolordraw[10] = TextDrawStreamCreate(82.500000, 157.500000,"  ");
	    vbmcolordraw[11] = TextDrawStreamCreate(100.000000, 157.500000,"  ");
	    vbmcolordraw[12] = TextDrawStreamCreate(117.500000, 157.500000,"  ");
	    vbmcolordraw[13] = TextDrawStreamCreate(135.000000, 157.500000,"  ");
	    vbmcolordraw[14] = TextDrawStreamCreate(152.500000, 157.500000,"  ");
	    vbmcolordraw[15] = TextDrawStreamCreate(170.000000, 157.500000,"  ");
	    vbmcolordraw[16] = TextDrawStreamCreate(47.500000, 175.000000,"  ");
	    vbmcolordraw[17] = TextDrawStreamCreate(65.000000, 175.000000,"  ");
	    vbmcolordraw[18] = TextDrawStreamCreate(82.500000, 175.000000,"  ");
	    vbmcolordraw[19] = TextDrawStreamCreate(100.000000, 175.000000,"  ");
	    vbmcolordraw[20] = TextDrawStreamCreate(117.500000, 175.000000,"  ");
	    vbmcolordraw[21] = TextDrawStreamCreate(135.000000, 175.000000,"  ");
	    vbmcolordraw[22] = TextDrawStreamCreate(152.500000, 175.000000,"  ");
	    vbmcolordraw[23] = TextDrawStreamCreate(170.000000, 175.000000,"  ");
	    vbmcolordraw[24] = TextDrawStreamCreate(47.500000, 192.500000,"  ");
	    vbmcolordraw[25] = TextDrawStreamCreate(65.000000, 192.500000,"  ");
	    vbmcolordraw[26] = TextDrawStreamCreate(82.500000, 192.500000,"  ");
	    vbmcolordraw[27] = TextDrawStreamCreate(100.000000, 192.500000,"  ");
	    vbmcolordraw[28] = TextDrawStreamCreate(117.500000, 192.500000,"  ");
	    vbmcolordraw[29] = TextDrawStreamCreate(135.000000, 192.500000,"  ");
	    vbmcolordraw[30] = TextDrawStreamCreate(152.500000, 192.500000,"  ");
	    vbmcolordraw[31] = TextDrawStreamCreate(170.000000, 192.500000,"  ");
	    vbmcolordraw[32] = TextDrawStreamCreate(47.500000, 210.000000,"  ");
	    vbmcolordraw[33] = TextDrawStreamCreate(65.000000, 210.000000,"  ");
	    vbmcolordraw[34] = TextDrawStreamCreate(82.500000, 210.000000,"  ");
	    vbmcolordraw[35] = TextDrawStreamCreate(100.000000, 210.000000,"  ");
	    vbmcolordraw[36] = TextDrawStreamCreate(117.500000, 210.000000,"  ");
	    vbmcolordraw[37] = TextDrawStreamCreate(135.000000, 210.000000,"  ");
	    vbmcolordraw[38] = TextDrawStreamCreate(152.500000, 210.000000,"  ");
	    vbmcolordraw[39] = TextDrawStreamCreate(170.000000, 210.000000,"  ");
	    vbmcolordraw[40] = TextDrawStreamCreate(47.500000, 227.500000,"  ");
	    vbmcolordraw[41] = TextDrawStreamCreate(65.000000, 227.500000,"  ");
	    vbmcolordraw[42] = TextDrawStreamCreate(82.500000, 227.500000,"  ");
	    vbmcolordraw[43] = TextDrawStreamCreate(100.000000, 227.500000,"  ");
	    vbmcolordraw[44] = TextDrawStreamCreate(117.500000, 227.500000,"  ");
	    vbmcolordraw[45] = TextDrawStreamCreate(135.000000, 227.500000,"  ");
	    vbmcolordraw[46] = TextDrawStreamCreate(152.500000, 227.500000,"  ");
	    vbmcolordraw[47] = TextDrawStreamCreate(170.000000, 227.500000,"  ");
	    vbmcolordraw[48] = TextDrawStreamCreate(47.500000, 245.000000,"  ");
	    vbmcolordraw[49] = TextDrawStreamCreate(65.000000, 245.000000,"  ");
	    vbmcolordraw[50] = TextDrawStreamCreate(82.500000, 245.000000,"  ");
	    vbmcolordraw[51] = TextDrawStreamCreate(100.000000, 245.000000,"  ");
	    vbmcolordraw[52] = TextDrawStreamCreate(117.500000, 245.000000,"  ");
	    vbmcolordraw[53] = TextDrawStreamCreate(135.000000, 245.000000,"  ");
	    vbmcolordraw[54] = TextDrawStreamCreate(152.500000, 245.000000,"  ");
	    vbmcolordraw[55] = TextDrawStreamCreate(170.000000, 245.000000,"  ");
	    vbmcolordraw[56] = TextDrawStreamCreate(47.500000, 262.500000,"  ");
	    vbmcolordraw[57] = TextDrawStreamCreate(65.000000, 262.500000,"  ");
	    vbmcolordraw[58] = TextDrawStreamCreate(82.500000, 262.500000,"  ");
	    vbmcolordraw[59] = TextDrawStreamCreate(100.000000, 262.500000,"  ");
	    vbmcolordraw[60] = TextDrawStreamCreate(117.500000, 262.500000,"  ");
	    vbmcolordraw[61] = TextDrawStreamCreate(135.000000, 262.500000,"  ");
	    vbmcolordraw[62] = TextDrawStreamCreate(152.500000, 262.500000,"  ");
	    vbmcolordraw[63] = TextDrawStreamCreate(170.000000, 262.500000,"  ");
	    vbmcolordraw[64] = TextDrawStreamCreate(47.500000,140.000000,"  ");
	    vbmcolordraw[65] = TextDrawStreamCreate(65.000000,140.000000,"  ");
	    vbmcolordraw[66] = TextDrawStreamCreate(82.500000,140.000000,"  ");
	    vbmcolordraw[67] = TextDrawStreamCreate(100.000000,140.000000,"  ");
	    vbmcolordraw[68] = TextDrawStreamCreate(117.500000,140.000000,"  ");
	    vbmcolordraw[69] = TextDrawStreamCreate(135.000000,140.000000,"  ");
	    vbmcolordraw[70] = TextDrawStreamCreate(152.500000,140.000000,"  ");
	    vbmcolordraw[71] = TextDrawStreamCreate(170.000000,140.000000,"  ");
	    vbmcolordraw[72] = TextDrawStreamCreate(47.500000, 157.500000,"  ");
	    vbmcolordraw[73] = TextDrawStreamCreate(65.000000, 157.500000,"  ");
	    vbmcolordraw[74] = TextDrawStreamCreate(82.500000, 157.500000,"  ");
	    vbmcolordraw[75] = TextDrawStreamCreate(100.000000, 157.500000,"  ");
	    vbmcolordraw[76] = TextDrawStreamCreate(117.500000, 157.500000,"  ");
	    vbmcolordraw[77] = TextDrawStreamCreate(135.000000, 157.500000,"  ");
	    vbmcolordraw[78] = TextDrawStreamCreate(152.500000, 157.500000,"  ");
	    vbmcolordraw[79] = TextDrawStreamCreate(170.000000, 157.500000,"  ");
	    vbmcolordraw[80] = TextDrawStreamCreate(47.500000, 175.000000,"  ");
	    vbmcolordraw[81] = TextDrawStreamCreate(65.000000, 175.000000,"  ");
	    vbmcolordraw[82] = TextDrawStreamCreate(82.500000, 175.000000,"  ");
	    vbmcolordraw[83] = TextDrawStreamCreate(100.000000, 175.000000,"  ");
	    vbmcolordraw[84] = TextDrawStreamCreate(117.500000, 175.000000,"  ");
	    vbmcolordraw[85] = TextDrawStreamCreate(135.000000, 175.000000,"  ");
	    vbmcolordraw[86] = TextDrawStreamCreate(152.500000, 175.000000,"  ");
	    vbmcolordraw[87] = TextDrawStreamCreate(170.000000, 175.000000,"  ");
	    vbmcolordraw[88] = TextDrawStreamCreate(47.500000, 192.500000,"  ");
	    vbmcolordraw[89] = TextDrawStreamCreate(65.000000, 192.500000,"  ");
	    vbmcolordraw[90] = TextDrawStreamCreate(82.500000, 192.500000,"  ");
	    vbmcolordraw[91] = TextDrawStreamCreate(100.000000, 192.500000,"  ");
	    vbmcolordraw[92] = TextDrawStreamCreate(117.500000, 192.500000,"  ");
	    vbmcolordraw[93] = TextDrawStreamCreate(135.000000, 192.500000,"  ");
	    vbmcolordraw[94] = TextDrawStreamCreate(152.500000, 192.500000,"  ");
	    vbmcolordraw[95] = TextDrawStreamCreate(170.000000, 192.500000,"  ");
	    vbmcolordraw[96] = TextDrawStreamCreate(47.500000, 210.000000,"  ");
	    vbmcolordraw[97] = TextDrawStreamCreate(65.000000, 210.000000,"  ");
	    vbmcolordraw[98] = TextDrawStreamCreate(82.500000, 210.000000,"  ");
	    vbmcolordraw[99] = TextDrawStreamCreate(100.000000, 210.000000,"  ");
	    vbmcolordraw[100] = TextDrawStreamCreate(117.500000, 210.000000,"  ");
	    vbmcolordraw[101] = TextDrawStreamCreate(135.000000, 210.000000,"  ");
	    vbmcolordraw[102] = TextDrawStreamCreate(152.500000, 210.000000,"  ");
	    vbmcolordraw[103] = TextDrawStreamCreate(170.000000, 210.000000,"  ");
	    vbmcolordraw[104] = TextDrawStreamCreate(47.500000, 227.500000,"  ");
	    vbmcolordraw[105] = TextDrawStreamCreate(65.000000, 227.500000,"  ");
	    vbmcolordraw[106] = TextDrawStreamCreate(82.500000, 227.500000,"  ");
	    vbmcolordraw[107] = TextDrawStreamCreate(100.000000, 227.500000,"  ");
	    vbmcolordraw[108] = TextDrawStreamCreate(117.500000, 227.500000,"  ");
	    vbmcolordraw[109] = TextDrawStreamCreate(135.000000, 227.500000,"  ");
	    vbmcolordraw[110] = TextDrawStreamCreate(152.500000, 227.500000,"  ");
	    vbmcolordraw[111] = TextDrawStreamCreate(170.000000, 227.500000,"  ");
	    vbmcolordraw[112] = TextDrawStreamCreate(47.500000, 245.000000,"  ");
	    vbmcolordraw[113] = TextDrawStreamCreate(65.000000, 245.000000,"  ");
	    vbmcolordraw[114] = TextDrawStreamCreate(82.500000, 245.000000,"  ");
	    vbmcolordraw[115] = TextDrawStreamCreate(100.000000, 245.000000,"  ");
	    vbmcolordraw[116] = TextDrawStreamCreate(117.500000, 245.000000,"  ");
	    vbmcolordraw[117] = TextDrawStreamCreate(135.000000, 245.000000,"  ");
	    vbmcolordraw[118] = TextDrawStreamCreate(152.500000, 245.000000,"  ");
	    vbmcolordraw[119] = TextDrawStreamCreate(170.000000, 245.000000,"  ");
	    vbmcolordraw[120] = TextDrawStreamCreate(47.500000, 262.500000,"  ");
	    vbmcolordraw[121] = TextDrawStreamCreate(65.000000, 262.500000,"  ");
	    vbmcolordraw[122] = TextDrawStreamCreate(82.500000, 262.500000,"  ");
	    vbmcolordraw[123] = TextDrawStreamCreate(100.000000, 262.500000,"  ");
	    vbmcolordraw[124] = TextDrawStreamCreate(117.500000, 262.500000,"  ");
	    vbmcolordraw[125] = TextDrawStreamCreate(135.000000, 262.500000,"  ");
	    vbmcolordraw[126] = TextDrawStreamCreate(152.500000, 262.500000,"  ");
	    vbmcolordraw[127] = TextDrawStreamCreate(170.000000, 262.500000,"  ");
		vbmcolordraw[128] = TextDrawStreamCreate(32.5, 130.0, "  ");
		vbmcolordraw[129] = TextDrawStreamCreate(45.0, 115.0, "Colors - Page 1");
		vbmcolordraw[130] = TextDrawStreamCreate(45.0, 115.0, "Colors - Page 2");
		TextDrawStreamAlignment(vbmcolordraw[128],0);
		TextDrawStreamBackgroundColor(vbmcolordraw[128], 0x000000ff);
		TextDrawStreamBoxColor(vbmcolordraw[128], 0x00000066);
		TextDrawStreamColor(vbmcolordraw[128], 0x0000ffcc);
		TextDrawStreamFont(vbmcolordraw[128], 0);
		TextDrawStreamLetterSize(vbmcolordraw[128], 1.000000, 1.000000);
		TextDrawStreamSetOutline(vbmcolordraw[128],0);
		TextDrawStreamSetProportional(vbmcolordraw[128],1);
		TextDrawStreamSetShadow(vbmcolordraw[128],1);
		TextDrawStreamTextSize(vbmcolordraw[128],172.5,180.0);
		TextDrawStreamUseBox(vbmcolordraw[128],1);
		TextDrawStreamAlignment(vbmcolordraw[129],0);
		TextDrawStreamBackgroundColor(vbmcolordraw[129], 0x000000ff);
		TextDrawStreamBoxColor(vbmcolordraw[129], 0x000000ff);
		TextDrawStreamColor(vbmcolordraw[129], 0xffffffff);
		TextDrawStreamFont(vbmcolordraw[129], 0);
		TextDrawStreamLetterSize(vbmcolordraw[129], 1.300000, 1.600000);
		TextDrawStreamSetOutline(vbmcolordraw[129],1);
		TextDrawStreamSetProportional(vbmcolordraw[129],1);
		TextDrawStreamSetShadow(vbmcolordraw[129],1);
		TextDrawStreamTextSize(vbmcolordraw[129],300.0,50.0);
		TextDrawStreamUseBox(vbmcolordraw[129],0);
		TextDrawStreamAlignment(vbmcolordraw[130],0);
		TextDrawStreamBackgroundColor(vbmcolordraw[130], 0x000000ff);
		TextDrawStreamBoxColor(vbmcolordraw[130], 0x000000ff);
		TextDrawStreamColor(vbmcolordraw[130], 0xffffffff);
		TextDrawStreamFont(vbmcolordraw[130], 0);
		TextDrawStreamLetterSize(vbmcolordraw[130], 1.300000, 1.600000);
		TextDrawStreamSetOutline(vbmcolordraw[130],1);
		TextDrawStreamSetProportional(vbmcolordraw[130],1);
		TextDrawStreamSetShadow(vbmcolordraw[130],1);
		TextDrawStreamTextSize(vbmcolordraw[130],300.0,50.0);
		TextDrawStreamUseBox(vbmcolordraw[130],0);
		for(new i=0; i < TOTAL_COLORS; i++){
			TextDrawStreamAlignment(vbmcolordraw[i],2);
			TextDrawStreamBackgroundColor(vbmcolordraw[i], 0x000000ff);
			TextDrawStreamBoxColor(vbmcolordraw[i], CarColors[i]);
			TextDrawStreamColor(vbmcolordraw[i], 0xffffffff);
			TextDrawStreamFont(vbmcolordraw[i], 1);
			TextDrawStreamLetterSize(vbmcolordraw[i], 1.000000, 1.000000);
			TextDrawStreamSetOutline(vbmcolordraw[i],1);
			TextDrawStreamSetProportional(vbmcolordraw[i],1);
			TextDrawStreamSetShadow(vbmcolordraw[i],1);
			TextDrawStreamTextSize(vbmcolordraw[i],10.000000,10.000000);
			TextDrawStreamUseBox(vbmcolordraw[i],1);
		}
		return 1;
	}
	public HideMenuColor(playerid){
		TextDrawStreamHideForPlayer(playerid,vbmcolordraw[128]);
		TextDrawStreamHideForPlayer(playerid,vbmcolordraw[129]);
		for(new g=0; g < 64; g++){
			TextDrawStreamHideForPlayer(playerid,vbmcolordraw[g]);
		}
		return 1;
	}
	public HideMenuColor2(playerid){
		TextDrawStreamHideForPlayer(playerid,vbmcolordraw[128]);
		TextDrawStreamHideForPlayer(playerid,vbmcolordraw[130]);
		for(new i=64; i < TOTAL_COLORS; i++){
			TextDrawStreamHideForPlayer(playerid,vbmcolordraw[i]);
		}
		return 1;
	}
	public ShowMenuColor(playerid){
		TextDrawStreamShowForPlayer(playerid,vbmcolordraw[128]);
		TextDrawStreamShowForPlayer(playerid,vbmcolordraw[129]);
		for(new g=0; g < 64; g++){
			TextDrawStreamShowForPlayer(playerid,vbmcolordraw[g]);
		}
		return 1;
	}
	public ShowMenuColor2(playerid){
		TextDrawStreamShowForPlayer(playerid,vbmcolordraw[128]);
		TextDrawStreamShowForPlayer(playerid,vbmcolordraw[130]);
		for(new i=64; i < TOTAL_COLORS; i++){
			TextDrawStreamShowForPlayer(playerid,vbmcolordraw[i]);
		}
		return 1;
	}
	public UpdateColSel(playerid){
		new j;
		if ( PlayerInfo[playerid][colorpage] < 3 ){
			j = 2;
		}
		else{
			j = 3;
		}
		new i = PlayerInfo[playerid][itemPlace][j];
		if ( i > 63 ){
			i = i -64;
		}
		new h = 0;
		while ( i > 7 ) {
			i = i - 8;
			h++;
		}
		TextDrawStreamPos(PlayerInfo[playerid][colorselect], 40 + (17.5 * i), 137.5 + (17.5 * h));
		TextDrawStreamTextSize(PlayerInfo[playerid][colorselect], 55 + (17.5 * i), 15.0);
		return 1;
	}
	stock GetFirstCar(type){
		for (new i = 0; i < MAX_CARS; i++){
			if ( carDefines[i][type1] == type){
				return i;
			}
		}
		return 0;
	}
	public CreateCarMenu(playerid){
		new string[255];
		PlayerInfo[playerid][vehbuymenu][30] = F_CreateMenu("Carshop", 100.0, 127.5, 205.0);
		format( string, sizeof(string), "%s", carType[PlayerInfo[playerid][itemPlace][0]][nameb]);
		F_AddMenuItem(PlayerInfo[playerid][vehbuymenu][30], string);
		format( string, sizeof(string), "%s", carDefines[PlayerInfo[playerid][itemPlace][1]][namec]);
		F_AddMenuItem(PlayerInfo[playerid][vehbuymenu][30], string);
		format( string, sizeof(string), "Color 1 - %d", PlayerInfo[playerid][itemPlace][2]);
		F_AddMenuItem(PlayerInfo[playerid][vehbuymenu][30], string);
		format( string, sizeof(string), "Color 2 - %d", PlayerInfo[playerid][itemPlace][3]);
		F_AddMenuItem(PlayerInfo[playerid][vehbuymenu][30], string);
		F_AddMenuItem(PlayerInfo[playerid][vehbuymenu][30], "Buy Vehicle");
		F_AddMenuItem(PlayerInfo[playerid][vehbuymenu][30], "Exit");
		PlayerInfo[playerid][vehbuymenu][31] = F_CreateMenu("Cars", 100.0, 127.5, 205.0);
		for (new i = 0; i < 36; i++){
			if ( carType[i][shoppid] == 1){
				format( string, sizeof(string), "%s", carType[i][nameb]);
				F_AddMenuItem(PlayerInfo[playerid][vehbuymenu][31], string);
			}
		}
		PlayerInfo[playerid][vehbuymenu][32] = F_CreateMenu("Airvehicles", 100.0, 127.5, 205.0);
		for (new i = 0; i < 36; i++){
			if ( carType[i][shoppid] == 4){
				format( string, sizeof(string), "%s", carType[i][nameb]);
				F_AddMenuItem(PlayerInfo[playerid][vehbuymenu][32], string);
			}
		}
		PlayerInfo[playerid][vehbuymenu][33] = F_CreateMenu("Jobvehicles", 100.0, 127.5, 205.0);
		for (new i = 0; i < 36; i++){
			if ( carType[i][shoppid] == 7){
				format( string, sizeof(string), "%s", carType[i][nameb]);
				F_AddMenuItem(PlayerInfo[playerid][vehbuymenu][33], string);
			}
		}
		PlayerInfo[playerid][vehbuymenu][34] = F_CreateMenu("Goverment", 100.0, 127.5, 205.0);
		for (new i = 0; i < 36; i++){
			if ( carType[i][shoppid] == 8){
				format( string, sizeof(string), "%s", carType[i][nameb]);
				F_AddMenuItem(PlayerInfo[playerid][vehbuymenu][34], string);
			}
		}
		for (new i = 0; i < 30; i++){
			format( string, sizeof(string), "%s", carType[i][nameb]);
			PlayerInfo[playerid][vehbuymenu][i] = F_CreateMenu(string, 100.0, 127.5, 205.0);
			for (new j = 0; j < MAX_CARS; j++){
				if ( carDefines[j][type1] == i){
					format( string, sizeof(string), "%s", carDefines[j][namec]);
					F_AddMenuItem(PlayerInfo[playerid][vehbuymenu][i], string);
				}
			}
		}
		F_AddMenuItem(PlayerInfo[playerid][vehbuymenu][1], "Next Page");
		F_AddMenuItem(PlayerInfo[playerid][vehbuymenu][2], "Previous Page");
		F_AddMenuItem(PlayerInfo[playerid][vehbuymenu][3], "Next Page");
		F_AddMenuItem(PlayerInfo[playerid][vehbuymenu][4], "Previous Page");
		F_AddMenuItem(PlayerInfo[playerid][vehbuymenu][24], "Next Page");
		F_AddMenuItem(PlayerInfo[playerid][vehbuymenu][25], "Previous Page");
		PlayerInfo[playerid][colorselect] = TextDrawStreamCreate(57.5, 137.5, "  ");
		TextDrawStreamUseBox(PlayerInfo[playerid][colorselect],1);
		TextDrawStreamBoxColor(PlayerInfo[playerid][colorselect],0xffffffff);
		TextDrawStreamTextSize(PlayerInfo[playerid][colorselect],55.0,15.0);
		TextDrawStreamAlignment(PlayerInfo[playerid][colorselect],0);
		TextDrawStreamBackgroundColor(PlayerInfo[playerid][colorselect],0x000000ff);
		TextDrawStreamFont(PlayerInfo[playerid][colorselect],0);
		TextDrawStreamLetterSize(PlayerInfo[playerid][colorselect],1.000000,1.500000);
		TextDrawStreamColor(PlayerInfo[playerid][colorselect],0xffffffff);
		TextDrawStreamSetOutline(PlayerInfo[playerid][colorselect],1);
		TextDrawStreamSetProportional(PlayerInfo[playerid][colorselect],1);
		TextDrawStreamSetShadow(PlayerInfo[playerid][colorselect],0);
		return 1;
	}
	public DestroyCarMenu(playerid){
		for(new i = 0; i < 35; i++){
			F_DestroyMenu(PlayerInfo[playerid][vehbuymenu][i]);
		}
		return 1;
	}
	public UnloadCarMenu(playerid){
		for (new i = 0; i < 35; i++){
			F_UnloadMenu(PlayerInfo[playerid][vehbuymenu][i]);
		}
		return 1;
	}
	public UpdateCar( playerid ){
		new jojo[256];
		if( PlayerInfo[playerid][destroyCar] == true ){
			DestroyStreamVehicle(PlayerInfo[playerid][playerCar]); // Destroy the Car in menu and creates the next one
			SendClientMessage(playerid, COLOR_YELLOW, "TempCar destroyed");
		}
		PlayerInfo[playerid][playerCar] = CreateStreamVehicle( carDefines[PlayerInfo[playerid][itemPlace][1]][ID], PlayerInfo[playerid][PlayerPos][0], PlayerInfo[playerid][PlayerPos][1], PlayerInfo[playerid][PlayerPos][2], PlayerInfo[playerid][PlayerPos][3], PlayerInfo[playerid][itemPlace][2], PlayerInfo[playerid][itemPlace][3]);
		PlayerInfo[playerid][destroyCar] = true;
		format(jojo, sizeof(jojo), "Playercar: %d", PlayerInfo[playerid][playerCar]);
		SendClientMessage(playerid, COLOR_YELLOW, jojo);
		format(jojo, sizeof(jojo), "Model: %d PlayerPos: %f %f %f Farbe: %d / %d", carDefines[PlayerInfo[playerid][itemPlace][1]][ID], PlayerInfo[playerid][PlayerPos][0], PlayerInfo[playerid][PlayerPos][1], PlayerInfo[playerid][PlayerPos][2], PlayerInfo[playerid][PlayerPos][3], PlayerInfo[playerid][itemPlace][2], PlayerInfo[playerid][itemPlace][3]);
		SendClientMessage(playerid, COLOR_YELLOW, jojo);
		PlayerInfo[playerid][updatetimer] = SetTimerEx("UpdateCar2", 3000, 0, "i",playerid);
	}
	public UpdateCar2(playerid){
		TogglePlayerSpectating(playerid, 1);
		//LockCarForAll( PlayerInfo[playerid][playerCar], true );
		PlayerSpectateVehicle(playerid, VehicleInfo[PlayerInfo[playerid][playerCar]][idnum], SPECTATE_MODE_NORMAL);
	}
//$ endregion carmod-textdrawupdate
//$ region MenuCreator
	stock F_CreateMenu(title[255], Float:x, Float:y, Float:boxlength){
		new id;
		while(MenuInfo[id][UsedMenu] == true) id++;
		MenuInfo[id][menu_id] = TextDrawStreamCreateEx(x, y, boxlength, 0.000000, 0.699999, 1.100000, title, 0x000000ff, 0x000000CC, 0xffffffff, 0, 1, 0, 1, 1, 1);
	    MenuInfo[id][Rows] = 0;
	    MenuInfo[id][SelectedRowTextColor] = 0xffffffff;
	    MenuInfo[id][SelectedRowBgColor] = 0x000000ff;
	    MenuInfo[id][SelectedRowBoxColor] = 0xffffff99;
		MenuInfo[id][ItemTextColor] = 0xffffffff;
		MenuInfo[id][ItemBgColor] = 0x000000ff;
		MenuInfo[id][ItemBoxColor] = 0x00000099;
	    for(new i=0; i<MAX_PLAYERS; i++){
	    	MenuInfo[id][Shown][i] = false;
	    }
	    MenuInfo[id][UsedMenu] = true;
	    return id;
	}
	stock F_DestroyMenu(menuid){
		if(MenuInfo[menuid][UsedMenu] == true){
			TextDrawStreamDestroy(MenuInfo[menuid][menu_id]);
			for (new h = 0; h < MenuInfo[menuid][Rows]; h++){
				TextDrawStreamDestroy(MenuInfo[menuid][menu_row][h]);
			}
		    for(new i=0; i<MAX_PLAYERS; i++){
				if(MenuInfo[menuid][Shown][i] == true){
				    MenuInfo[menuid][Shown][i] = false;
				}
			}
			MenuInfo[menuid][UsedMenu] = false;
	    	return 1;
		}
		return 0;
	}
	stock F_LoadMenu(menuid){
		TextDrawStreamLoad(MenuInfo[menuid][menu_id]);
		for (new i = 0; i < MenuInfo[menuid][Rows]; i++){
			TextDrawStreamLoad(MenuInfo[menuid][menu_row][i]);
		}
		return 1;
	}
	stock F_UnloadMenu(menuid){
		for (new i = 0; i < MAX_PLAYERS; i++){
			F_HideMenu(menuid, i);
		}
		TextDrawStreamUnload(MenuInfo[menuid][menu_id]);
		for (new i = 0; i < MenuInfo[menuid][Rows]; i++){
			TextDrawStreamUnload(MenuInfo[menuid][menu_row][i]);
		}
		for(new i=0; i<MAX_PLAYERS; i++){
			if(MenuInfo[menuid][Shown][i] == true){
				MenuInfo[menuid][Shown][i] = false;
			}
		}
		return 1;
	}
	stock F_AddMenuItem(menuid, title[255]){
		if(MenuInfo[menuid][UsedMenu] == true && MenuInfo[menuid][Rows] < F_MAX_MENU_ROWS){
			MenuInfo[menuid][menu_row][MenuInfo[menuid][Rows]] = TextDrawStreamCreateEx(TextInfo[MenuInfo[menuid][menu_id]][TPos][0], floatadd(TextInfo[MenuInfo[menuid][menu_id]][TPos][1], floatmul(MenuInfo[menuid][Rows]+1, 13.4)), TextInfo[MenuInfo[menuid][menu_id]][TSize][0], 0.0, 0.299999, 1.100000, title, MenuInfo[menuid][ItemBgColor], MenuInfo[menuid][ItemBoxColor], MenuInfo[menuid][ItemTextColor], 1, 1, 0, 1, 1, 1);
	    	MenuInfo[menuid][Rows] ++;
	    	return MenuInfo[menuid][Rows] -1;
		}
		return 0;
	}
	stock F_ChangeMenuItem(menuid, row, title[255]){
		if(MenuInfo[menuid][UsedMenu] == true && row < MenuInfo[menuid][Rows]){
	    	TextDrawStreamSetString(MenuInfo[menuid][menu_row][row], title);
		}
	}
	stock F_ChangeMenuParams(menuid, title[], Float:x, Float:y, Float:boxlength){
		if(MenuInfo[menuid][UsedMenu] == true){
			TextDrawStreamPos(MenuInfo[menuid][menu_id], x, y);
			TextDrawStreamTextSize(MenuInfo[menuid][menu_id], boxlength, 0.0);
			TextDrawStreamSetString(MenuInfo[menuid][menu_id], title);
		}
	}
	stock F_SetMenuTitleTextColor(menuid, color){
	    if(MenuInfo[menuid][UsedMenu] == true){
			TextDrawStreamColor(MenuInfo[menuid][menu_id], color);
			return 1;
		}
		return 0;
	}
	stock F_SetMenuTitleBgColor(menuid, color){
	    if(MenuInfo[menuid][UsedMenu] == true){
			TextDrawStreamBackgroundColor(MenuInfo[menuid][menu_id], color);
			return 1;
		}
		return 0;
	}
	stock F_SetMenuTitleBoxColor(menuid, color){
	    if(MenuInfo[menuid][UsedMenu] == true){
			TextDrawStreamBoxColor(MenuInfo[menuid][menu_id], color);
			return 1;
		}
		return 0;
	}
	stock F_SetMenuItemTextColor(menuid, color){
	    if(MenuInfo[menuid][UsedMenu] == true){
		    for(new i=0; i<F_MAX_MENU_ROWS; i++){
			    if(i < MenuInfo[menuid][Rows]){
					TextDrawStreamColor(MenuInfo[menuid][menu_row][i], color);
					MenuInfo[menuid][ItemTextColor] = color;
			    }
			}
			return 1;
		}
		return 0;
	}
	stock F_SetMenuItemBgColor(menuid, color){
	    if(MenuInfo[menuid][UsedMenu] == true){
		    for(new i=0; i<F_MAX_MENU_ROWS; i++){
			    if(i < MenuInfo[menuid][Rows]){
					TextDrawStreamBackgroundColor(MenuInfo[menuid][menu_row][i], color);
					MenuInfo[menuid][ItemBgColor] = color;
			    }
			}
			return 1;
		}
		return 0;
	}
	stock F_SetMenuItemBoxColor(menuid, color){
	    if(MenuInfo[menuid][UsedMenu] == true){
		    for(new i=0; i<F_MAX_MENU_ROWS; i++){
			    if(i < MenuInfo[menuid][Rows]){
					TextDrawStreamBoxColor(MenuInfo[menuid][menu_row][i], color);
					MenuInfo[menuid][ItemBoxColor] = color;
			    }
			}
			return 1;
		}
		return 0;
	}
	stock F_SetMenuSelectedItemTextColor(menuid, color){
	    if(MenuInfo[menuid][UsedMenu] == true){
	        MenuInfo[menuid][SelectedRowTextColor] = color;
			return 1;
		}
		return 0;
	}
	stock F_SetMenuSelectedItemBgColor(menuid, color){
	    if(MenuInfo[menuid][UsedMenu] == true){
	        MenuInfo[menuid][SelectedRowBgColor] = color;
			return 1;
		}
		return 0;
	}
	stock F_SetMenuSelectedItemBoxColor(menuid, color){
	    if(MenuInfo[menuid][UsedMenu] == true){
	        MenuInfo[menuid][SelectedRowBoxColor] = color;
			return 1;
		}
		return 0;
	}
	stock F_HideMenu(menuid, playerid){
		if(IsPlayerConnected(playerid)){
			if(MenuInfo[menuid][Shown][playerid] == true){
				TextDrawStreamHideForPlayer(playerid, MenuInfo[menuid][menu_id]);
				for(new i=0; i<F_MAX_MENU_ROWS; i++){
					if(i < MenuInfo[menuid][Rows]){
						TextDrawStreamHideForPlayer(playerid, MenuInfo[menuid][menu_row][i]);
					}
				}
				MenuInfo[menuid][Shown][playerid] = false;
				PlayerInfo[playerid][menushown] = -1;
				format(report, sizeof(report), "Hide Menu: %d", menuid);
				SendClientMessage(playerid, COLOR_YELLOW, report);
			}
		}
		return 0;
	}
	stock F_ShowMenu(menuid, playerid){
		if(IsPlayerConnected(playerid)){
			for(new m=0; m<F_MAX_MENUS; m++){
				F_HideMenu(m, playerid);
			}
			if(MenuInfo[menuid][Shown][playerid] == false && MenuInfo[menuid][UsedMenu] == true){
			    TextDrawStreamShowForPlayer(playerid, MenuInfo[menuid][menu_id]);
				TextDrawStreamBoxColor(MenuInfo[menuid][menu_row][0], MenuInfo[menuid][SelectedRowBoxColor]);
				TextDrawStreamColor(MenuInfo[menuid][menu_row][0], MenuInfo[menuid][SelectedRowTextColor]);
				TextDrawStreamBackgroundColor(MenuInfo[menuid][menu_row][0], MenuInfo[menuid][SelectedRowBgColor]);
				for(new i=0; i<F_MAX_MENU_ROWS; i++){
				    if(i < MenuInfo[menuid][Rows]){
						if(i != 0){
							TextDrawStreamBoxColor(MenuInfo[menuid][menu_row][i], MenuInfo[menuid][ItemBoxColor]);
							TextDrawStreamColor(MenuInfo[menuid][menu_row][i], MenuInfo[menuid][ItemTextColor]);
							TextDrawStreamBackgroundColor(MenuInfo[menuid][menu_row][i], MenuInfo[menuid][ItemBgColor]);
						}
						TextDrawStreamShowForPlayer(playerid, MenuInfo[menuid][menu_row][i]);
				    }
				}
			    MenuInfo[menuid][Shown][playerid] = true;
				PlayerInfo[playerid][menushown] = menuid;
			    MenuInfo[menuid][SelectedRow][playerid] = 0;
				format(report, sizeof(report), "Show Menu: %d", menuid);
				SendClientMessage(playerid, COLOR_YELLOW, report);
		    	return 1;
			}
		}
		return 0;
	}
	stock F_SelectMenuRow(playerid, updown){
		if(IsPlayerConnected(playerid)){
			for(new menuid=0; menuid<F_MAX_MENUS; menuid++){
				if(MenuInfo[menuid][Shown][playerid] == true){
					PlayerInfo[playerid][confirmselect] = 0;
					TextDrawStreamColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][ItemTextColor]);
					TextDrawStreamBackgroundColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][ItemBgColor]);
					TextDrawStreamBoxColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][ItemBoxColor]);
					switch (updown){
						case 0:{
							if(MenuInfo[menuid][SelectedRow][playerid] > 0){
								MenuInfo[menuid][SelectedRow][playerid] --;
							}
							else{
								MenuInfo[menuid][SelectedRow][playerid] = MenuInfo[menuid][Rows]-1;
							}
							PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
						}
						case 1:{
							if(MenuInfo[menuid][SelectedRow][playerid] < MenuInfo[menuid][Rows]-1){
								MenuInfo[menuid][SelectedRow][playerid] ++;
							}
							else{
								MenuInfo[menuid][SelectedRow][playerid] = 0;
							}
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
						}
					}
					//MenuInfo[menuid][SelectedRow][playerid] = row;
					CallRemoteFunction("F_OnPlayerSelectMenuRow", "iii", playerid, menuid, MenuInfo[menuid][SelectedRow][playerid]);
					TextDrawStreamColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][SelectedRowTextColor]);
					TextDrawStreamBackgroundColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][SelectedRowBgColor]);
					TextDrawStreamBoxColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][SelectedRowBoxColor]);
					return 1;
				}
			}
		}
		return 0;
	}
	public F_PressKeyDetection(){
	    new keys, updown, leftright;
		new string[255];
	    for(new i=0; i<MAX_PLAYERS; i++){
	        if(IsPlayerConnected(i)){
	            GetPlayerKeys(i, keys, updown, leftright);
	            new bool:Pressed;
				if ( PlayerInfo[i][menushown] > -1 ){
		            if(updown == KEY_UP){
		                Pressed = true;
		                if(PlayerInfo[i][AKeyPressed] == false){
			                PlayerInfo[i][AKeyPressed] = true;
			        		PlayerInfo[i][F_HoldKeyt] = SetTimerEx("F_HoldKey", 800, 0, "i", i);
							F_SelectMenuRow(i, 0);
							//CallRemoteFunction("F_OnPlayerSelectMenuRow", "iii", i, menuid, MenuInfo[menuid][SelectedRow][i]);
						}
			        }
			        if(updown == KEY_DOWN){
			            Pressed = true;
			            if(PlayerInfo[i][AKeyPressed] == false){
				            PlayerInfo[i][AKeyPressed] = true;

			        		PlayerInfo[i][F_HoldKeyt] = SetTimerEx("F_HoldKey", 800, 0, "i", i);
							F_SelectMenuRow(i, 1);
						}
			        }
					if(leftright == KEY_LEFT){
			            Pressed = true;
			            if(PlayerInfo[i][AKeyPressed] == false){
				            PlayerInfo[i][AKeyPressed] = true;
							for(new menuid=0; menuid<F_MAX_MENUS; menuid++){
								if(MenuInfo[menuid][Shown][i] == true){
						 		 	CallRemoteFunction("F_OnPlayerSelectedMenuRow", "iiii", i, menuid, MenuInfo[menuid][SelectedRow][i], 1);
									PlayerPlaySound(i, 1053, 0.0, 0.0, 0.0);
								}
							}
						}
			        }
					if(leftright == KEY_RIGHT){
			            Pressed = true;
			            if(PlayerInfo[i][AKeyPressed] == false){
				            PlayerInfo[i][AKeyPressed] = true;
							for(new menuid=0; menuid<F_MAX_MENUS; menuid++){
								if(MenuInfo[menuid][Shown][i] == true){
							 		 	CallRemoteFunction("F_OnPlayerSelectedMenuRow", "iiii", i, menuid, MenuInfo[menuid][SelectedRow][i], 2);
										PlayerPlaySound(i, 1052, 0.0, 0.0, 0.0);
									}
								}
							}
				        }
				    if(keys == KEY_SPRINT){
				        Pressed = true;
				        if(PlayerInfo[i][AKeyPressed] == false){
					        PlayerInfo[i][AKeyPressed] = true;
							for(new menuid=0; menuid<F_MAX_MENUS; menuid++){
								if(MenuInfo[menuid][Shown][i] == true){
									TextDrawStreamColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][i]], MenuInfo[menuid][ItemTextColor]);
									TextDrawStreamBackgroundColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][i]], MenuInfo[menuid][ItemBgColor]);
									TextDrawStreamBoxColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][i]], MenuInfo[menuid][ItemBoxColor]);
							        //F_HideMenu(menuid, i);
							 		CallRemoteFunction("F_OnPlayerSelectedMenuRow", "iiii", i, menuid, MenuInfo[menuid][SelectedRow][i], 0);
									//PlayerPlaySound(i, 1083, 0.0, 0.0, 0.0);
									return 1;
								}
							}
						}
				    }
				    if(keys == KEY_SECONDARY_ATTACK){
						Pressed = true;
				        if(PlayerInfo[i][AKeyPressed] == false){
					        PlayerInfo[i][AKeyPressed] = true;
							for(new menuid=0; menuid<F_MAX_MENUS; menuid++){
								if(MenuInfo[menuid][Shown][i] == true){
									TextDrawStreamColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][i]], MenuInfo[menuid][ItemTextColor]);
									TextDrawStreamBackgroundColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][i]], MenuInfo[menuid][ItemBgColor]);
									TextDrawStreamBoxColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][i]], MenuInfo[menuid][ItemBoxColor]);
							        F_HideMenu(menuid, i);
							        CallRemoteFunction("F_OnPlayerExitedMenu", "ii", i, menuid);
									PlayerPlaySound(i, 1084, 0.0, 0.0, 0.0);
								}
							}
						}
				    }
				    if(Pressed == false){
				        PlayerInfo[i][AKeyPressed] = false;
				        KillTimer(PlayerInfo[i][F_HoldKeyt]);
				    }
				}
				if ( PlayerInfo[i][colorpage] > 0 ){
					new j;
					if ( PlayerInfo[i][colorpage] < 3 ){
						j = 2;
					}
					else{
						j = 3;
					}
					if(updown == KEY_UP){
						PlayerInfo[i][itemPlace][j] = PlayerInfo[i][itemPlace][j]-8;
						if(PlayerInfo[i][itemPlace][j] < 0 && PlayerInfo[i][colorpage]==1){
							PlayerInfo[i][itemPlace][j] = TOTAL_COLORS+PlayerInfo[i][itemPlace][j];
							HideMenuColor(i);
							ShowMenuColor2(i);
							PlayerInfo[i][colorpage]=2;
						}
						else if (PlayerInfo[i][itemPlace][j] < 64 && PlayerInfo[i][colorpage]==2){
							HideMenuColor2(i);
							ShowMenuColor(i);
							PlayerInfo[i][colorpage]=1;
						}
						else if(PlayerInfo[i][itemPlace][j] < 0 && PlayerInfo[i][colorpage]==3){
							PlayerInfo[i][itemPlace][j] = TOTAL_COLORS+PlayerInfo[i][itemPlace][j];
							HideMenuColor(i);
							ShowMenuColor2(i);
							PlayerInfo[i][colorpage]=4;
						}
						else if (PlayerInfo[i][itemPlace][j] < 64 && PlayerInfo[i][colorpage]==4){
							HideMenuColor2(i);
							ShowMenuColor(i);
							PlayerInfo[i][colorpage]=3;
						}
						ChangeVehicleColor(VehicleInfo[PlayerInfo[i][playerCar]][idnum], PlayerInfo[i][itemPlace][2],PlayerInfo[i][itemPlace][3]);
						UpdateColSel(i);
					}
					if(updown == KEY_DOWN){
						PlayerInfo[i][itemPlace][j] = PlayerInfo[i][itemPlace][j]+8;
						if(PlayerInfo[i][itemPlace][j] >= TOTAL_COLORS && PlayerInfo[i][colorpage]==2){
							PlayerInfo[i][itemPlace][j] = PlayerInfo[i][itemPlace][j]-TOTAL_COLORS;
							HideMenuColor2(i);
							ShowMenuColor(i);
							PlayerInfo[i][colorpage]=1;
						}
						else if (PlayerInfo[i][itemPlace][j] > 63 && PlayerInfo[i][colorpage]==1){
							HideMenuColor(i);
							ShowMenuColor2(i);
							PlayerInfo[i][colorpage]=2;
						}
						else if(PlayerInfo[i][itemPlace][j] >= TOTAL_COLORS && PlayerInfo[i][colorpage]==4){
							PlayerInfo[i][itemPlace][j] = PlayerInfo[i][itemPlace][j]-TOTAL_COLORS;
							HideMenuColor2(i);
							ShowMenuColor(i);
							PlayerInfo[i][colorpage]=3;
						}
						else if (PlayerInfo[i][itemPlace][j] > 63 && PlayerInfo[i][colorpage]==3){
							HideMenuColor(i);
							ShowMenuColor2(i);
							PlayerInfo[i][colorpage]=4;
						}
						ChangeVehicleColor(VehicleInfo[PlayerInfo[i][playerCar]][idnum], PlayerInfo[i][itemPlace][2],PlayerInfo[i][itemPlace][3]);
						UpdateColSel(i);
					}
					if(leftright == KEY_LEFT){
						PlayerInfo[i][itemPlace][j] = PlayerInfo[i][itemPlace][j]-1;
						if(PlayerInfo[i][itemPlace][j] < 0 && PlayerInfo[i][colorpage]==1){
							PlayerInfo[i][itemPlace][j] = TOTAL_COLORS+PlayerInfo[i][itemPlace][j];
							HideMenuColor(i);
							ShowMenuColor2(i);
							PlayerInfo[i][colorpage]=2;
						}
						else if (PlayerInfo[i][itemPlace][j] < 64 && PlayerInfo[i][colorpage]==2){
							HideMenuColor2(i);
							ShowMenuColor(i);
							PlayerInfo[i][colorpage]=1;
						}
						else if(PlayerInfo[i][itemPlace][j] < 0 && PlayerInfo[i][colorpage]==3){
							PlayerInfo[i][itemPlace][j] = TOTAL_COLORS+PlayerInfo[i][itemPlace][j];
							HideMenuColor(i);
							ShowMenuColor2(i);
							PlayerInfo[i][colorpage]=4;
						}
						else if (PlayerInfo[i][itemPlace][j] < 64 && PlayerInfo[i][colorpage]==4){
							HideMenuColor2(i);
							ShowMenuColor(i);
							PlayerInfo[i][colorpage]=3;
						}
						ChangeVehicleColor(VehicleInfo[PlayerInfo[i][playerCar]][idnum], PlayerInfo[i][itemPlace][2],PlayerInfo[i][itemPlace][3]);
						UpdateColSel(i);
					}
					if(leftright == KEY_RIGHT){
						PlayerInfo[i][itemPlace][j] = PlayerInfo[i][itemPlace][j]+1;
						if(PlayerInfo[i][itemPlace][j] >= TOTAL_COLORS && PlayerInfo[i][colorpage]==2){
							PlayerInfo[i][itemPlace][j] = PlayerInfo[i][itemPlace][j]-TOTAL_COLORS;
							HideMenuColor2(i);
							ShowMenuColor(i);
							PlayerInfo[i][colorpage]=1;
						}
						else if (PlayerInfo[i][itemPlace][j] > 63 && PlayerInfo[i][colorpage]==1){
							HideMenuColor(i);
							ShowMenuColor2(i);
							PlayerInfo[i][colorpage]=2;
						}
						else if(PlayerInfo[i][itemPlace][j] >= TOTAL_COLORS && PlayerInfo[i][colorpage]==4){
							PlayerInfo[i][itemPlace][j] = PlayerInfo[i][itemPlace][j]-TOTAL_COLORS;
							HideMenuColor2(i);
							ShowMenuColor(i);
							PlayerInfo[i][colorpage]=3;
						}
						else if (PlayerInfo[i][itemPlace][j] > 63 && PlayerInfo[i][colorpage]==3){
							HideMenuColor(i);
							ShowMenuColor2(i);
							PlayerInfo[i][colorpage]=4;
						}
						ChangeVehicleColor(VehicleInfo[PlayerInfo[i][playerCar]][idnum], PlayerInfo[i][itemPlace][2],PlayerInfo[i][itemPlace][3]);
						UpdateColSel(i);
					}
					if(keys == KEY_SPRINT){
						if ( PlayerInfo[i][colorpage] == 1 || PlayerInfo[i][colorpage] == 3 ){
							HideMenuColor(i);}
						else if ( PlayerInfo[i][colorpage] == 2 || PlayerInfo[i][colorpage] == 4 ){
							HideMenuColor2(i);}
						PlayerInfo[i][colorpage] = 0;
						TextDrawStreamUnload(PlayerInfo[i][colorselect]);
						format( string, sizeof(string), "Color %d - %d", j-1, PlayerInfo[i][itemPlace][j]);
						F_ChangeMenuItem(PlayerInfo[i][vehbuymenu][30],j,string);
						F_ShowMenu(PlayerInfo[i][vehbuymenu][30], i);
					}
					if (keys == KEY_SECONDARY_ATTACK){
						if ( PlayerInfo[i][colorpage] == 1 || PlayerInfo[i][colorpage] == 3 ){
							HideMenuColor(i);}
						else if ( PlayerInfo[i][colorpage] == 2 || PlayerInfo[i][colorpage] == 4 ){
							HideMenuColor2(i);}
						PlayerInfo[i][colorpage] = 0;
						TextDrawStreamUnload(PlayerInfo[i][colorselect]);
						PlayerInfo[i][itemPlace][2] = PlayerInfo[i][itemPlace][5];
						PlayerInfo[i][itemPlace][3] = PlayerInfo[i][itemPlace][6];
						ChangeVehicleColor(VehicleInfo[PlayerInfo[i][playerCar]][idnum], PlayerInfo[i][itemPlace][2],PlayerInfo[i][itemPlace][3]);
						F_ShowMenu(PlayerInfo[i][vehbuymenu][30], i);
					}
				}
		    }
		}
		return 1;
	}
	public F_HoldKey(playerid){
		if(IsPlayerConnected(playerid)){
			new keys, updown, leftright;
			GetPlayerKeys(playerid, keys, updown, leftright);
			new bool:Pressed;
			if ( PlayerInfo[playerid][menushown] > -1 ){
				if(updown == KEY_UP){
				    Pressed = true;
					F_SelectMenuRow(playerid, 0);
				}
				if(updown == KEY_DOWN){
				    Pressed = true;
					F_SelectMenuRow(playerid, 1);
				}
				if(keys == KEY_LEFT){
					Pressed = true;
					for(new menuid=0; menuid<F_MAX_MENUS; menuid++){
						if(MenuInfo[menuid][Shown][playerid] == true){
							CallRemoteFunction("F_OnPlayerSelectedMenuRow", "iii", playerid, menuid, MenuInfo[menuid][SelectedRow][playerid], 1);
							PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
						}
					}
				}
				if(keys == KEY_RIGHT){
					Pressed = true;
					for(new menuid=0; menuid<F_MAX_MENUS; menuid++){
						if(MenuInfo[menuid][Shown][playerid] == true){
							CallRemoteFunction("F_OnPlayerSelectedMenuRow", "iii", playerid, menuid, MenuInfo[menuid][SelectedRow][playerid], 2);
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
						}
					}
				}
			}
			if ( PlayerInfo[playerid][colorpage] > 0 ){
				new i;
				if ( PlayerInfo[playerid][colorpage] < 3 ){
					i = 2;
				}
				else{
					i = 3;
				}
				if(updown == KEY_UP){
					PlayerInfo[playerid][itemPlace][i] = PlayerInfo[playerid][itemPlace][i]-8;
					if(PlayerInfo[playerid][itemPlace][i] < 0 && PlayerInfo[playerid][colorpage]==1){
						PlayerInfo[playerid][itemPlace][i] = TOTAL_COLORS-PlayerInfo[playerid][itemPlace][i]-1;
						HideMenuColor(playerid);
						ShowMenuColor2(playerid);
						PlayerInfo[playerid][colorpage]=2;
					}
					else if (PlayerInfo[playerid][itemPlace][i] < 64 && PlayerInfo[playerid][colorpage]==2){
						HideMenuColor2(playerid);
						ShowMenuColor(playerid);
						PlayerInfo[playerid][colorpage]=1;
					}
					else if(PlayerInfo[playerid][itemPlace][i] < 0 && PlayerInfo[playerid][colorpage]==3){
						PlayerInfo[playerid][itemPlace][i] = TOTAL_COLORS-PlayerInfo[playerid][itemPlace][i]-1;
						HideMenuColor(playerid);
						ShowMenuColor2(playerid);
						PlayerInfo[playerid][colorpage]=4;
					}
					else if (PlayerInfo[playerid][itemPlace][i] < 64 && PlayerInfo[playerid][colorpage]==4){
						HideMenuColor2(playerid);
						ShowMenuColor(playerid);
						PlayerInfo[playerid][colorpage]=3;
					}
					ChangeVehicleColor(VehicleInfo[PlayerInfo[playerid][playerCar]][idnum], PlayerInfo[playerid][itemPlace][2],PlayerInfo[playerid][itemPlace][3]);
					UpdateColSel(playerid);
				}
				if(updown == KEY_DOWN){
					PlayerInfo[playerid][itemPlace][i] = PlayerInfo[playerid][itemPlace][i]+8;
					if(PlayerInfo[playerid][itemPlace][i] > TOTAL_COLORS-1 && PlayerInfo[playerid][colorpage]==2){
						PlayerInfo[playerid][itemPlace][i] = PlayerInfo[playerid][itemPlace][i]-TOTAL_COLORS-1;
						HideMenuColor2(playerid);
						ShowMenuColor(playerid);
						PlayerInfo[playerid][colorpage]=1;
					}
					else if (PlayerInfo[playerid][itemPlace][i] > 63 && PlayerInfo[playerid][colorpage]==1){
						HideMenuColor(playerid);
						ShowMenuColor2(playerid);
						PlayerInfo[playerid][colorpage]=2;
					}
					else if(PlayerInfo[playerid][itemPlace][i] > TOTAL_COLORS-1 && PlayerInfo[playerid][colorpage]==4){
						PlayerInfo[playerid][itemPlace][i] = PlayerInfo[playerid][itemPlace][i]-TOTAL_COLORS-1;
						HideMenuColor2(playerid);
						ShowMenuColor(playerid);
						PlayerInfo[playerid][colorpage]=3;
					}
					else if (PlayerInfo[playerid][itemPlace][i] > 63 && PlayerInfo[playerid][colorpage]==3){
						HideMenuColor(playerid);
						ShowMenuColor2(playerid);
						PlayerInfo[playerid][colorpage]=4;
					}
					ChangeVehicleColor(VehicleInfo[PlayerInfo[playerid][playerCar]][idnum], PlayerInfo[playerid][itemPlace][2],PlayerInfo[playerid][itemPlace][3]);
					UpdateColSel(playerid);
				}
				if(leftright == KEY_LEFT){
					PlayerInfo[playerid][itemPlace][i] = PlayerInfo[playerid][itemPlace][i]-1;
					if(PlayerInfo[playerid][itemPlace][i] < 0 && PlayerInfo[playerid][colorpage]==1){
						PlayerInfo[playerid][itemPlace][i] = TOTAL_COLORS-PlayerInfo[playerid][itemPlace][i]-1;
						HideMenuColor(playerid);
						ShowMenuColor2(playerid);
						PlayerInfo[playerid][colorpage]=2;
					}
					else if (PlayerInfo[playerid][itemPlace][i] < 64 && PlayerInfo[playerid][colorpage]==2){
						HideMenuColor2(playerid);
						ShowMenuColor(playerid);
						PlayerInfo[playerid][colorpage]=1;
					}
					else if(PlayerInfo[playerid][itemPlace][i] < 0 && PlayerInfo[playerid][colorpage]==3){
						PlayerInfo[playerid][itemPlace][i] = TOTAL_COLORS-PlayerInfo[playerid][itemPlace][i]-1;
						HideMenuColor(playerid);
						ShowMenuColor2(playerid);
						PlayerInfo[playerid][colorpage]=4;
					}
					else if (PlayerInfo[playerid][itemPlace][i] < 64 && PlayerInfo[playerid][colorpage]==4){
						HideMenuColor2(playerid);
						ShowMenuColor(playerid);
						PlayerInfo[playerid][colorpage]=3;
					}
					ChangeVehicleColor(VehicleInfo[PlayerInfo[playerid][playerCar]][idnum], PlayerInfo[playerid][itemPlace][2],PlayerInfo[playerid][itemPlace][3]);
					UpdateColSel(playerid);
				}
				if(leftright == KEY_RIGHT){
					PlayerInfo[playerid][itemPlace][i] = PlayerInfo[playerid][itemPlace][i]+1;
					if(PlayerInfo[playerid][itemPlace][i] > TOTAL_COLORS-1 && PlayerInfo[playerid][colorpage]==2){
						PlayerInfo[playerid][itemPlace][i] = PlayerInfo[playerid][itemPlace][i]-TOTAL_COLORS-1;
						HideMenuColor2(playerid);
						ShowMenuColor(playerid);
						PlayerInfo[playerid][colorpage]=1;
					}
					else if (PlayerInfo[playerid][itemPlace][i] > 63 && PlayerInfo[playerid][colorpage]==1){
						HideMenuColor(playerid);
						ShowMenuColor2(playerid);
						PlayerInfo[playerid][colorpage]=2;
					}
					else if(PlayerInfo[playerid][itemPlace][i] > TOTAL_COLORS-1 && PlayerInfo[playerid][colorpage]==4){
						PlayerInfo[playerid][itemPlace][i] = PlayerInfo[playerid][itemPlace][i]-TOTAL_COLORS-1;
						HideMenuColor2(playerid);
						ShowMenuColor(playerid);
						PlayerInfo[playerid][colorpage]=3;
					}
					else if (PlayerInfo[playerid][itemPlace][i] > 63 && PlayerInfo[playerid][colorpage]==3){
						HideMenuColor(playerid);
						ShowMenuColor2(playerid);
						PlayerInfo[playerid][colorpage]=4;
					}
					ChangeVehicleColor(VehicleInfo[PlayerInfo[playerid][playerCar]][idnum], PlayerInfo[playerid][itemPlace][2],PlayerInfo[playerid][itemPlace][3]);
					UpdateColSel(playerid);
				}
			}
			if(Pressed == true){
				SetTimerEx("F_HoldKey", 200, 0, "i", playerid);
			}
		    return 1;
		}
		return 0;
	}
	public F_OnPlayerSelectedMenuRow(playerid, menuid, row, leftright){
		// leftright = 0 == Sprinttaste
		// leftright = 1 == Links
		// leftright = 2 == Rechts
		new string[255];
		format(report, sizeof(report), "Click Menu: %d Row: %d OK: %d", menuid, row, leftright);
		SendClientMessage(playerid, COLOR_YELLOW, report);
		if ( PlayerInfo[playerid][vehbuymenu][30] == menuid){
			if ( row == 0 ){
				if ( leftright == 0 ){
					switch ( PlayerInfo[playerid][carSelect] ){
						case 1:{
							F_ShowMenu(PlayerInfo[playerid][vehbuymenu][31], playerid);
						}
						case 2:{
							F_ShowMenu(PlayerInfo[playerid][vehbuymenu][32], playerid);
						}
						case 3:{
							F_ShowMenu(PlayerInfo[playerid][vehbuymenu][33], playerid);
						}
						case 4:{
							F_ShowMenu(PlayerInfo[playerid][vehbuymenu][34], playerid);
						}
						default:{
							F_ShowMenu(PlayerInfo[playerid][vehbuymenu][30], playerid);
						}
					}
				}
				else if ( leftright == 1 ){

				}
				else if ( leftright == 2 ){

				}
			}
			else if ( row == 1 ){
				if ( leftright == 0  ){
					PlayerInfo[playerid][itemPlace][4] = PlayerInfo[playerid][itemPlace][1];
					F_ShowMenu(PlayerInfo[playerid][vehbuymenu][PlayerInfo[playerid][itemPlace][0]], playerid);
				}
				else if ( leftright == 1 ){

				}
				else if ( leftright == 2 ){

				}
			}
			else if ( row == 2 ){
				if ( leftright == 0  ){
					F_HideMenu(PlayerInfo[playerid][vehbuymenu][30], playerid);	//das mainmenu schlieﬂen
					PlayerInfo[playerid][itemPlace][5] = PlayerInfo[playerid][itemPlace][2]; //erste Farbe zwischenspeichern
					PlayerInfo[playerid][itemPlace][6] = PlayerInfo[playerid][itemPlace][3]; //zweite Farbe zwischenspeichern
					SendClientMessage(playerid, COLOR_YELLOW, "report");
					ShowMenuColor(playerid);
					TextDrawStreamShowForPlayer(playerid, PlayerInfo[playerid][colorselect]);
					UpdateColSel(playerid);
					SendClientMessage(playerid, COLOR_YELLOW, "report2");
					PlayerInfo[playerid][colorpage] = 1;
				}
				else if ( leftright == 1 ){

				}
				else if ( leftright == 2 ){

				}
			}
			else if ( row == 3 ){
				if ( leftright == 0  ){
					F_HideMenu(PlayerInfo[playerid][vehbuymenu][30], playerid);
					PlayerInfo[playerid][itemPlace][5] = PlayerInfo[playerid][itemPlace][2];
					PlayerInfo[playerid][itemPlace][6] = PlayerInfo[playerid][itemPlace][3];
					ShowMenuColor(playerid);
					TextDrawStreamShowForPlayer(playerid, PlayerInfo[playerid][colorselect]);
					UpdateColSel(playerid);
					PlayerInfo[playerid][colorpage] = 3;
				}
				else if ( leftright == 1 ){

				}
				else if ( leftright == 2 ){

				}
			}
			else if ( row == 4 ){
				UnloadCarMenu(playerid);
				carsmenucreated--;
				if ( carsmenucreated == 0 ){
					UnloadMenuColor();
				}
				PlayerInfo[playerid][destroyCar] = false;
				PlayerInfo[playerid][carSelect] = 0;
				TogglePlayerSpectating(playerid, 0);
				PutPlayerInVehicle(playerid, VehicleInfo[PlayerInfo[playerid][playerCar]][idnum], 0);
				PlayerInfo[playerid][playerCar]=0;
				VehicleInfo[PlayerInfo[playerid][playerCar]][owner] = PlayerName(playerid);
				VehicleInfo[PlayerInfo[playerid][playerCar]][ownerid] = playerid;
				KillTimer(PlayerInfo[playerid][updatetimer]);
			}
			else if ( row == 5 ){
				UnloadCarMenu(playerid);
				carsmenucreated--;
				if ( carsmenucreated == 0 ){
					UnloadMenuColor();
				}
				DestroyStreamVehicle(PlayerInfo[playerid][playerCar]);
				PlayerInfo[playerid][playerCar]=0;
				PlayerInfo[playerid][destroyCar] = false;
				PlayerInfo[playerid][carSelect] = 0;
				TogglePlayerSpectating(playerid, 0);
				SetPlayerPos(playerid, PlayerInfo[playerid][PlayerPos][0],  PlayerInfo[playerid][PlayerPos][1], PlayerInfo[playerid][PlayerPos][2]);
			}
		}
		else if ( PlayerInfo[playerid][vehbuymenu][31] == menuid){
			if ( leftright == 0){
				switch(row){
					case 0:{
						PlayerInfo[playerid][itemPlace][0] = 1;
					}
					case 1:{
						PlayerInfo[playerid][itemPlace][0] = 3;
					}
					case 2:{
						PlayerInfo[playerid][itemPlace][0] = 9;
					}
					case 3:{
						PlayerInfo[playerid][itemPlace][0] = 16;
					}
					case 4:{
						PlayerInfo[playerid][itemPlace][0] = 17;
					}
					case 5:{
						PlayerInfo[playerid][itemPlace][0] = 22;
					}
					case 6:{
						PlayerInfo[playerid][itemPlace][0] = 23;
					}
					case 7:{
						PlayerInfo[playerid][itemPlace][0] = 24;
					}
					case 8:{
						PlayerInfo[playerid][itemPlace][0] = 29;
					}
				}
				PlayerInfo[playerid][itemPlace][1] = GetFirstCar(PlayerInfo[playerid][itemPlace][0]);
				UpdateCar(playerid);
				format( string, sizeof(string), "%s", carType[PlayerInfo[playerid][itemPlace][0]][nameb]);
				F_ChangeMenuItem(PlayerInfo[playerid][vehbuymenu][30],0,string);
				format( string, sizeof(string), "%s", carDefines[PlayerInfo[playerid][itemPlace][1]][namec]);
				F_ChangeMenuItem(PlayerInfo[playerid][vehbuymenu][30],1,string);
				F_ShowMenu(PlayerInfo[playerid][vehbuymenu][30], playerid);
			}
		}
		else if ( PlayerInfo[playerid][vehbuymenu][32] == menuid){
				if ( leftright == 0){
					switch(row){
						case 0:{
							PlayerInfo[playerid][itemPlace][0] = 15;
						}
						case 1:{
							PlayerInfo[playerid][itemPlace][0] = 19;
						}
					}
					PlayerInfo[playerid][itemPlace][1] = GetFirstCar(PlayerInfo[playerid][itemPlace][0]);
					UpdateCar(playerid);
					format( string, sizeof(string), "%s", carType[PlayerInfo[playerid][itemPlace][0]][nameb]);
					F_ChangeMenuItem(PlayerInfo[playerid][vehbuymenu][30],0,string);
					format( string, sizeof(string), "%s", carDefines[PlayerInfo[playerid][itemPlace][1]][namec]);
					F_ChangeMenuItem(PlayerInfo[playerid][vehbuymenu][30],1,string);
					F_ShowMenu(PlayerInfo[playerid][vehbuymenu][30], playerid);
				}
		}
		else if ( PlayerInfo[playerid][vehbuymenu][33] == menuid){
				if ( leftright == 0){
					switch(row){
						case 0:{
							PlayerInfo[playerid][itemPlace][0] = 0;
						}
						case 1:{
							PlayerInfo[playerid][itemPlace][0] = 6;
						}
						case 2:{
							PlayerInfo[playerid][itemPlace][0] = 10;
						}
						case 3:{
							PlayerInfo[playerid][itemPlace][0] = 11;
						}
						case 4:{
							PlayerInfo[playerid][itemPlace][0] = 12;
						}
						case 5:{
							PlayerInfo[playerid][itemPlace][0] = 27;
						}
						case 6:{
							PlayerInfo[playerid][itemPlace][0] = 30;
						}
						case 7:{
							PlayerInfo[playerid][itemPlace][0] = 31;
						}
						case 8:{
							PlayerInfo[playerid][itemPlace][0] = 32;
						}
						case 9:{
							PlayerInfo[playerid][itemPlace][0] = 34;
						}
					}
					PlayerInfo[playerid][itemPlace][1] = GetFirstCar(PlayerInfo[playerid][itemPlace][0]);
					UpdateCar(playerid);
					format( string, sizeof(string), "%s", carType[PlayerInfo[playerid][itemPlace][0]][nameb]);
					F_ChangeMenuItem(PlayerInfo[playerid][vehbuymenu][30],0,string);
					format( string, sizeof(string), "%s", carDefines[PlayerInfo[playerid][itemPlace][1]][namec]);
					F_ChangeMenuItem(PlayerInfo[playerid][vehbuymenu][30],1,string);
					F_ShowMenu(PlayerInfo[playerid][vehbuymenu][30], playerid);
				}
		}
		else if ( PlayerInfo[playerid][vehbuymenu][34] == menuid){
			if ( leftright == 0){
				switch(row){
					case 0:{
						PlayerInfo[playerid][itemPlace][0] = 5;
					}
					case 1:{
						PlayerInfo[playerid][itemPlace][0] = 13;
					}
					case 2:{
						PlayerInfo[playerid][itemPlace][0] = 14;
					}
					case 3:{
						PlayerInfo[playerid][itemPlace][0] = 20;
					}
					case 4:{
						PlayerInfo[playerid][itemPlace][0] = 26;
					}
					case 5:{
						PlayerInfo[playerid][itemPlace][0] = 33;
					}
					case 6:{
						PlayerInfo[playerid][itemPlace][0] = 35;
					}
				}
				PlayerInfo[playerid][itemPlace][1] = GetFirstCar(PlayerInfo[playerid][itemPlace][0]);
				format( string, sizeof(string), "%s", carType[PlayerInfo[playerid][itemPlace][0]][nameb]);
				F_ChangeMenuItem(PlayerInfo[playerid][vehbuymenu][30],0,string);
				format( string, sizeof(string), "%s", carDefines[PlayerInfo[playerid][itemPlace][1]][namec]);
				F_ChangeMenuItem(PlayerInfo[playerid][vehbuymenu][30],1,string);
				F_ShowMenu(PlayerInfo[playerid][vehbuymenu][30], playerid);
			}
		}
		else if ( PlayerInfo[playerid][vehbuymenu][1] == menuid && leftright == 0 && row == 15){
			PlayerInfo[playerid][itemPlace][0]++;
			PlayerInfo[playerid][itemPlace][1] = GetFirstCar(PlayerInfo[playerid][itemPlace][0]);
			UpdateCar(playerid);
			F_ShowMenu(PlayerInfo[playerid][vehbuymenu][2], playerid);
		}
		else if ( PlayerInfo[playerid][vehbuymenu][2] == menuid && leftright == 0 && row == 15){
			PlayerInfo[playerid][itemPlace][0]--;
			PlayerInfo[playerid][itemPlace][1] = GetFirstCar(PlayerInfo[playerid][itemPlace][0]);
			UpdateCar(playerid);
			F_ShowMenu(PlayerInfo[playerid][vehbuymenu][1], playerid);
		}
		else if ( PlayerInfo[playerid][vehbuymenu][3] == menuid && leftright == 0 && row == 13){
			PlayerInfo[playerid][itemPlace][0]++;
			PlayerInfo[playerid][itemPlace][1] = GetFirstCar(PlayerInfo[playerid][itemPlace][0]);
			UpdateCar(playerid);
			F_ShowMenu(PlayerInfo[playerid][vehbuymenu][4], playerid);
		}
		else if ( PlayerInfo[playerid][vehbuymenu][4] == menuid && leftright == 0 && row == 13){
			PlayerInfo[playerid][itemPlace][0]--;
			PlayerInfo[playerid][itemPlace][1] = GetFirstCar(PlayerInfo[playerid][itemPlace][0]);
			UpdateCar(playerid);
			F_ShowMenu(PlayerInfo[playerid][vehbuymenu][3], playerid);
		}
		else if ( PlayerInfo[playerid][vehbuymenu][24] == menuid && leftright == 0 && row == 13){
			PlayerInfo[playerid][itemPlace][0]++;
			PlayerInfo[playerid][itemPlace][1] = GetFirstCar(PlayerInfo[playerid][itemPlace][0]);
			UpdateCar(playerid);
			F_ShowMenu(PlayerInfo[playerid][vehbuymenu][25], playerid);
		}
		else if ( PlayerInfo[playerid][vehbuymenu][25] == menuid && leftright == 0 && row == 12){
			PlayerInfo[playerid][itemPlace][0]--;
			PlayerInfo[playerid][itemPlace][1] = GetFirstCar(PlayerInfo[playerid][itemPlace][0]);
			UpdateCar(playerid);
			F_ShowMenu(PlayerInfo[playerid][vehbuymenu][24], playerid);
		}
		else {
			for (new i = 0; i < 30; i++){
				if ( PlayerInfo[playerid][vehbuymenu][i] == menuid){
					if ( leftright == 0 ){
						if ( PlayerInfo[playerid][confirmselect] == 0 ){
							SendClientMessage(playerid, COLOR_YELLOW, "Please confirm your Selection...");
							PlayerInfo[playerid][confirmselect] = 1;
							PlayerInfo[playerid][itemPlace][1] = GetFirstCar(PlayerInfo[playerid][itemPlace][0])+row;
							UpdateCar(playerid);
							F_ShowMenu(PlayerInfo[playerid][vehbuymenu][i], playerid);
						}
						else if ( PlayerInfo[playerid][confirmselect] == 1 ){
							PlayerInfo[playerid][confirmselect] = 0;
							format( string, sizeof(string), "%s", carDefines[PlayerInfo[playerid][itemPlace][1]][namec]);
							F_ChangeMenuItem(PlayerInfo[playerid][vehbuymenu][30], 1, string);
							if ( i == 2 || i == 4 || i == 25 ){
								PlayerInfo[playerid][itemPlace][0]--;
							}
							F_ShowMenu(PlayerInfo[playerid][vehbuymenu][30], playerid);
						}
					}
				}
			}
		}
		return 1;
	}
	public F_OnPlayerSelectMenuRow(playerid, menuid, row){
	}
	public F_OnPlayerExitedMenu(playerid, menuid){
		format(report, sizeof(report), "Exit Menu: %d", menuid);
		SendClientMessage(playerid, COLOR_YELLOW, report);
		for (new i = 0; i < 30; i++){
			if ( PlayerInfo[playerid][vehbuymenu][i] == menuid){
				if ( i == 2 || i == 4 || i == 25 ){
					PlayerInfo[playerid][itemPlace][0]--;
				}
				PlayerInfo[playerid][itemPlace][1] = PlayerInfo[playerid][itemPlace][4];
				UpdateCar(playerid);
				F_ShowMenu(PlayerInfo[playerid][vehbuymenu][30], playerid);
			}
		}
		if ( PlayerInfo[playerid][vehbuymenu][30] == menuid ){
			UnloadCarMenu(playerid);
			carsmenucreated--;
			if ( carsmenucreated == 0 ){
				UnloadMenuColor();
			}
			DestroyStreamVehicle(PlayerInfo[playerid][playerCar]);
			PlayerInfo[playerid][playerCar]=0;
			PlayerInfo[playerid][destroyCar] = false;
			PlayerInfo[playerid][carSelect] = 0;
			TogglePlayerSpectating(playerid, 0);
			SetPlayerPos(playerid, PlayerInfo[playerid][PlayerPos][0],  PlayerInfo[playerid][PlayerPos][1], PlayerInfo[playerid][PlayerPos][2]);
		}
		else if ( PlayerInfo[playerid][vehbuymenu][31] == menuid ){
			F_ShowMenu(PlayerInfo[playerid][vehbuymenu][30], playerid);
		}
		else if ( PlayerInfo[playerid][vehbuymenu][32] == menuid ){
			F_ShowMenu(PlayerInfo[playerid][vehbuymenu][30], playerid);
		}
		else if ( PlayerInfo[playerid][vehbuymenu][33] == menuid ){
			F_ShowMenu(PlayerInfo[playerid][vehbuymenu][30], playerid);
		}
		else if ( PlayerInfo[playerid][vehbuymenu][34] == menuid ){
			F_ShowMenu(PlayerInfo[playerid][vehbuymenu][30], playerid);
		}
		return 1;
	}
//$ endregion MenuCreator
//$ region Streamer
	public InitiateSectorSystem(){
		SetTimer("SectorScan",1000,1);
		LoadCars();
		return 1;
	}
	public SectorScan(){
		StreamPickups();
		StreamVehicles();
		StreamObjects();
		CleanupPickups();
		StreamCheckpoints();
	}
	//$ region Vehicle-Streamer
		stock IsAnyPlayerNearStreamVehicle(svehicleid,Float:distance){
			for (new i = 0; i < MAX_PLAYERS; i++){
			    if(PlayerClose(i,VehicleInfo[svehicleid][veh_pos][0],VehicleInfo[svehicleid][veh_pos][1],VehicleInfo[svehicleid][veh_pos][2],distance)|| (IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i)==VehicleInfo[svehicleid][idnum]))
				    return true;
			}
			return false;
		}
		stock IsPlayerNearStreamVehicle(name[],svehicleid,Float:distance){
			new h = GetPlayerID(name);
			if (h != -1){
				if(PlayerClose(h,VehicleInfo[svehicleid][veh_pos][0],VehicleInfo[svehicleid][veh_pos][1],VehicleInfo[svehicleid][veh_pos][2],distance)|| (IsPlayerInAnyVehicle(h) && GetPlayerVehicleID(h)==VehicleInfo[svehicleid][idnum]))
				return true;
			}
			return false;
		}
		public StreamVehicles(){
			for (new i = 0; i < MAX_PRIORITY; i++){
				for (new j = 0; j < vehcount3 ; j++){
					if(VehicleInfo[j][CREATED] && VehicleInfo[j][priority]==i){
						vehcount2++;
						if (vehcount2 <= MAX_ACTIVE_VEHICLES-1000){
							if (i < 3 || (i >= 3 && modelscount <= MAX_ACTIVE_MODELS) || modelcount[VehicleInfo[j][model]-400]>0){
								if(VehicleInfo[j][idnum]==-1){
									if (vehcount < MAX_ACTIVE_VEHICLES){
										LoadVehicle(j);
									}
									else{
										new h = GetLastPriority() ;
										UnLoadVehicle(h);
										LoadVehicle(j);
									}
								}
							}
							else if (i >= 3 && modelscount > MAX_ACTIVE_MODELS){
								new h = GetLastPriority2() ;
								if (h != -1){
									if (VehicleInfo[j][idnum]==-1){
										UnLoadVehicle(h);
										LoadVehicle(j);
									}
								}
								else {
									if (VehicleInfo[j][idnum]>=0){
										UnLoadVehicle(j);
									}
									vehcount2--;
								}
							}
						}
						else if ( vehcount2 > MAX_ACTIVE_VEHICLES -1000 && vehcount2 < MAX_ACTIVE_VEHICLES ){
							if(IsAnyPlayerNearStreamVehicle(j,VIEW_DISTANCE) && VehicleInfo[j][priority]!=MAX_PRIORITY-1 && VehicleInfo[j][idnum]==-1 && modelcount[VehicleInfo[j][model]-400]>=1){
								LoadVehicle(j);
							}
							else if(IsPlayerNearStreamVehicle(VehicleInfo[j][owner],j,VIEW_DISTANCE) && VehicleInfo[j][priority]==MAX_PRIORITY-1 && VehicleInfo[j][idnum]==-1 && modelcount[VehicleInfo[j][model]-400]>=1){
								LoadVehicle(j);
							}
							else if(!IsPlayerNearStreamVehicle(VehicleInfo[j][owner],j,VIEW_DISTANCE)){
								if(VehicleInfo[j][idnum]>=0){
									UnLoadVehicle(j);
								}
								vehcount2--;
							}
						}
					}
				}
			}
			vehcount2=0;
		}
		public CreateStreamVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2){
			new str1[255];
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
					VehicleInfo[i][idobj] = CreateStreamObject(3593+random(2),x,y,z,0,0,rotation,VIEW_DISTANCE,3);
					format(str1, sizeof(str1), "Car created ! /nStreamid: %d Priority: %d Model: %d Farbe: %d . %d ", VehicleInfo[i][streamid], VehicleInfo[i][priority], VehicleInfo[i][model], VehicleInfo[i][colors][0], VehicleInfo[i][colors][1]);
					SendClientMessageToAll(COLOR_YELLOW, str1);
		            return i;
			    }
			}
			return 0;
		}
		public DestroyStreamVehicle(svehicleid){
			new carname[256];
			if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)	{
			    if(VehicleInfo[svehicleid][CREATED]){
			        if(VehicleInfo[svehicleid][idnum]){
			            DestroyVehicle(VehicleInfo[svehicleid][idnum]);
			            vehcount--;
					}
					for (new k = 0; k < MAX_COMPONENTS; k++){
						VehicleInfo[svehicleid][COMPONENTS][k] = 0;
					}
					if ( svehicleid==vehcount3-1 ){
						do {
							vehcount3--;
						}
						while (!VehicleInfo[vehcount3-1][CREATED] || vehcount3!=1);
						if (vehcount3==1 && !VehicleInfo[vehcount3-1][CREATED]){
							vehcount3--;
						}
					}
			        VehicleInfo[svehicleid][CREATED]=false;
					VehicleInfo[svehicleid][idnum]=-1;
					VehicleInfo[svehicleid][model]=0;
					VehicleInfo[svehicleid][veh_pos][0] = 0;
					VehicleInfo[svehicleid][veh_pos][1] = 0;
					VehicleInfo[svehicleid][veh_pos][2] = 0;
					VehicleInfo[svehicleid][veh_pos][3] = 0;
					VehicleInfo[svehicleid][colors][0] = 0;
					VehicleInfo[svehicleid][colors][1] = 0;
					VehicleInfo[svehicleid][paintjob] = 0;
					VehicleInfo[svehicleid][security] = 0;
					VehicleInfo[svehicleid][priority] = 0;
					DestroyStreamObject(VehicleInfo[svehicleid][idobj]);
					format(carname,sizeof(carname),"Car%d",svehicleid);
					fremove(carname);
			        return 1;
			    }
			}
			return 0;
		}
		public LockCar(svehicleid){
			for(new i = 0; i < MAX_PLAYERS; i++){
				if(IsPlayerConnected(i)){
					SetVehicleParamsForPlayer(svehicleid,i,0,1);
					VehicleInfo[svehicleid][locked]=1;
				}
			}
		}
		public UnLockCar(svehicleid){
			for(new i = 0; i < MAX_PLAYERS; i++)	{
				if(IsPlayerConnected(i)){
					if(!IsAPlane(svehicleid)){
						SetVehicleParamsForPlayer(svehicleid,i,0,0);
						VehicleInfo[svehicleid][locked]=0;
					}
				}
			}
		}
		public LoadVehicle(svehicleid){
			new str1[255];
		    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
			    if(VehicleInfo[svehicleid][idnum]==-1){
		            vehcount++;
					HideStreamObject(VehicleInfo[svehicleid][idobj]);
		        	VehicleInfo[svehicleid][idnum]=CreateVehicle(VehicleInfo[svehicleid][model],VehicleInfo[svehicleid][veh_pos][0],VehicleInfo[svehicleid][veh_pos][1],VehicleInfo[svehicleid][veh_pos][2],VehicleInfo[svehicleid][veh_pos][3],VehicleInfo[svehicleid][colors][0],VehicleInfo[svehicleid][colors][1],-1);
					VehStreamid[VehicleInfo[svehicleid][idnum]]=svehicleid;
					SetVehicleHealth(VehicleInfo[svehicleid][idnum],VehicleInfo[svehicleid][health]);
					if(VehicleInfo[svehicleid][paintjob]){
					    ChangeVehiclePaintjob(VehicleInfo[svehicleid][idnum],VehicleInfo[svehicleid][paintjob]);
					}
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
					if ( modelcount[VehicleInfo[svehicleid][model]-400]==0 ){
						modelscount++;
					}
					modelcount[VehicleInfo[svehicleid][model]-400]++;
					format(str1, sizeof(str1), "Car loaded ! /nID: %d Streamid: %d Priority: %d Model: %d Farbe: %d - %d ", VehicleInfo[svehicleid][idnum], VehicleInfo[svehicleid][streamid], VehicleInfo[svehicleid][priority], VehicleInfo[svehicleid][model], VehicleInfo[svehicleid][colors][0], VehicleInfo[svehicleid][colors][1]);
					SendClientMessageToAll(COLOR_YELLOW, str1);
					return VehicleInfo[svehicleid][idnum];
				}
			}
			return 0;
		}
		public UnLoadVehicle(svehicleid){
			new str1[255];
			if(VehicleInfo[svehicleid][idnum]>-1){
				GetVehiclePos(VehicleInfo[svehicleid][idnum],VehicleInfo[svehicleid][veh_pos][0],VehicleInfo[svehicleid][veh_pos][1],VehicleInfo[svehicleid][veh_pos][2]);
				GetVehicleZAngle(VehicleInfo[svehicleid][idnum],VehicleInfo[svehicleid][veh_pos][3]);
				GetVehicleHealth(VehicleInfo[svehicleid][idnum],VehicleInfo[svehicleid][health]);
				DestroyVehicle(VehicleInfo[svehicleid][idnum]);
				ShowStreamObject(VehicleInfo[svehicleid][idobj]);
				VehStreamid[VehicleInfo[svehicleid][idnum]]=-1;
				VehicleInfo[svehicleid][idnum]=-1;
				vehcount--;
				modelcount[VehicleInfo[svehicleid][model]-400]--;
				if ( modelcount[VehicleInfo[svehicleid][model]-400]==0 ){
					modelscount--;
				}
				format(str1, sizeof(str1), "Car unloaded ! /nStreamid: %d Priority: %d Model: %d Farbe: %d - %d ", VehicleInfo[svehicleid][streamid], VehicleInfo[svehicleid][priority], VehicleInfo[svehicleid][model], VehicleInfo[svehicleid][colors][0], VehicleInfo[svehicleid][colors][1]);
				SendClientMessageToAll(COLOR_YELLOW, str1);
			}
			return 0;
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
					VehicleInfo[n][world]=dini_Int(carname,"world");
					VehicleInfo[n][interior]=dini_Int(carname,"interior");
					VehicleInfo[n][colors][0]=dini_Int(carname,"color1");
					VehicleInfo[n][colors][1]=dini_Int(carname,"color2");
					VehicleInfo[n][streamid]=dini_Int(carname,"streamid");
					for (new mo = 0; mo < MAX_COMPONENTS; mo++){
						format(modname,sizeof(modname),"mod%d",mo);
						VehicleInfo[n][COMPONENTS][mo]=dini_Int(carname,modname);
					}
					vehcount3=n+1;
				}
			}
			return 1;
		}
		public SaveCar(svehicleid){
			if (VehicleInfo[svehicleid][CREATED]){
				if(VehicleInfo[svehicleid][idnum]>-1){
					GetVehiclePos(VehicleInfo[svehicleid][idnum],VehicleInfo[svehicleid][veh_pos][0],VehicleInfo[svehicleid][veh_pos][1],VehicleInfo[svehicleid][veh_pos][2]);
					GetVehicleZAngle(VehicleInfo[svehicleid][idnum],VehicleInfo[svehicleid][veh_pos][3]);
				}
				new carname[256];
				new modname[256];
				format(carname,sizeof(carname),"Car%d",svehicleid);
				if (!dini_Exists(carname)){
					dini_Create(carname);
				}
				dini_FloatSet(carname,"x",VehicleInfo[svehicleid][veh_pos][0]);
				dini_FloatSet(carname,"y",VehicleInfo[svehicleid][veh_pos][1]);
				dini_FloatSet(carname,"z",VehicleInfo[svehicleid][veh_pos][2]);
				dini_FloatSet(carname,"a",VehicleInfo[svehicleid][veh_pos][3]);
				dini_IntSet(carname,"paintjob",VehicleInfo[svehicleid][paintjob]);
				dini_IntSet(carname,"security",VehicleInfo[svehicleid][security]);
				dini_IntSet(carname,"priority",VehicleInfo[svehicleid][priority]);
				dini_IntSet(carname,"model",VehicleInfo[svehicleid][model]);
				dini_IntSet(carname,"CREATED",VehicleInfo[svehicleid][CREATED]);
				dini_Set(carname,"ownername",VehicleInfo[svehicleid][owner]);
				dini_IntSet(carname,"ownerid",VehicleInfo[svehicleid][ownerid]);
				dini_IntSet(carname,"tank",VehicleInfo[svehicleid][tank]);
				dini_IntSet(carname,"meters",VehicleInfo[svehicleid][meters]);
				dini_IntSet(carname,"oilpress",VehicleInfo[svehicleid][oilpress]);
				dini_IntSet(carname,"oilminimum",VehicleInfo[svehicleid][oilminimum]);
				dini_IntSet(carname,"oildamage",VehicleInfo[svehicleid][oildamage]);
				dini_IntSet(carname,"locked",VehicleInfo[svehicleid][locked]);
				dini_Set(carname,"numberplate",VehicleInfo[svehicleid][numberplate]);
				dini_FloatSet(carname,"health",VehicleInfo[svehicleid][health]);
				dini_IntSet(carname,"world",VehicleInfo[svehicleid][world]);
				dini_IntSet(carname,"interior",VehicleInfo[svehicleid][interior]);
				dini_IntSet(carname,"color1",VehicleInfo[svehicleid][colors][0]);
				dini_IntSet(carname,"color2",VehicleInfo[svehicleid][colors][1]);
				dini_IntSet(carname,"streamid",VehicleInfo[svehicleid][streamid]);
				for (new mo = 0; mo < MAX_COMPONENTS; mo++){
					format(modname,sizeof(modname),"mod%d",mo);
					dini_IntSet(carname,modname,VehicleInfo[svehicleid][COMPONENTS][mo]);
				}
			}
		}
		public SaveCars(){
			for (new i = 0; i < vehcount3; i++){
				SaveCar(i);
			}
			return 1;
		}
		public GetLastPriority(){
			for (new i = MAX_PRIORITY-1; i >= 0; i--){
				for (new j = 0; j < MAX_STREAM_VEHICLES ; j++){
					if(VehicleInfo[j][CREATED] && VehicleInfo[j][priority]==i && VehicleInfo[j][idnum]>=0){
						return j;
					}
				}
			}
			return -1;
		}
		public GetLastPriority2(){
			for (new i = MAX_PRIORITY-1; i >= 0; i--){
				for (new j = 0; j < MAX_STREAM_VEHICLES ; j++){
					if(VehicleInfo[j][CREATED] && VehicleInfo[j][priority]==i && VehicleInfo[j][idnum]>=0 && modelcount[VehicleInfo[j][model]-400]==1 && i > 3){
						return j;
					}
				}
			}
			return -1;
		}
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
		public SetStreamVehicleHealth(svehicleid,Float:health2){
			if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES){
			    if(VehicleInfo[svehicleid][CREATED]){
					if(VehicleInfo[svehicleid][idnum]>=0){
			            SetVehicleHealth(VehicleInfo[svehicleid][idnum],health2);
					}
			        VehicleInfo[svehicleid][health]=health2;
			        return 1;
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
	//$ region Pickup-Streamer
		stock GetPickupSpawnSector(pstreamid){
			new xsec = floatround(((PickupInfo[pstreamid][x_spawn] +4000) / 500), floatround_floor);
			new ysec = floatround(((PickupInfo[pstreamid][y_spawn] +4000) / 500), floatround_floor);
			return (xsec * 16) + ysec;
		}
		stock GetMaxPickups(){
			new j;
			for (new i = 0; i < MAX_STREAM_PICKUPS; i++){
				if( PickupInfo[i][valid]==1 ){
					j=i+1;
				}
			}
			return j;
		}
		stock CleanupPickups(){
			for(new i = 0;i<pucount2;i++) {
				if(PickupInfo[i][spawned] == 1 && PlayersClose(PickupInfo[i][x_spawn],PickupInfo[i][y_spawn],PickupInfo[i][z_spawn],20) == 0) {
					PickupInfo[i][spawned] = 0;
					DestroyPickup(PickupInfo[i][idnum]);
					pustreamcount--;
					PickupInfo[i][idnum] = -1;
				}
			}
		}
		stock StreamPickups(){
			for(new p = 0;p<pucount2;p++) {
				if(PickupInfo[p][valid] == 1 && PickupInfo[p][spawned] == 0 && PlayersClose(PickupInfo[p][x_spawn],PickupInfo[p][y_spawn],PickupInfo[p][z_spawn],20) == 1) {
					if(pustreamcount < MAX_ACTIVE_PICKUPS) {
						//new string[256];
						PickupInfo[p][spawned] = 1;
						PickupInfo[p][idnum] = CreatePickup(PickupInfo[p][model],PickupInfo[p][ptype],PickupInfo[p][x_spawn],PickupInfo[p][y_spawn],PickupInfo[p][z_spawn]);
						pustream[PickupInfo[p][idnum]] = p;
						//format(string,sizeof(string),"Pickup created: %d, %d", p, PickupInfo[p][idnum]);
						//SendClientMessage(playerid, COLOR_YELLOW, string);
						pustreamcount++;
					}
				}
			}
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
					PickupInfo[i][spawned] = 0;
					pucount++;
					pucount2 = GetMaxPickups();
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
	//$ endregion Pickup-Streamer
	//$ region Object-Streamer
		stock AttachCheck(playerid){
		    for(new n = 0;n<overallobjectcount;n++){
		 		if(ObjectInfo[n][valid] == 1 && ObjectInfo[n][attached] == 1){
					PlayerViewAttachedObject(playerid,n);
				}
			}
		}
		stock StreamObjects(){
			for (new i = 0; i < 5; i++){
			    for(new j = 0;j<MAX_PLAYERS;j++){
					for (new n = 0; n < overallobjectcount; n++){
						if(ObjectInfo[n][valid] == 1  && ObjectInfo[n][priority] == i && ObjectInfo[n][attached] == 0){
							if ( ObjectInfo[n][show] == 1 ){
								if(ObjectInfo[n][status][j] == 0 && (PlayerClose(j, ObjectInfo[n][x_ent],ObjectInfo[n][y_ent],ObjectInfo[n][z_ent],ObjectInfo[n][spawndist]) == 1 || ObjectInfo[n][spawndist] == 0)){
									if(OBstreamcount[j] < MAX_ACTIVE_OBJECTS){
								    	OBstreamcount[j]++;
								    	ObjectInfo[n][poid][j] = CreatePlayerObject(j,ObjectInfo[n][model],ObjectInfo[n][x_ent],ObjectInfo[n][y_ent],ObjectInfo[n][z_ent],ObjectInfo[n][x_rot],ObjectInfo[n][y_rot],ObjectInfo[n][z_rot]);
										ObjectInfo[n][status][j] = 1;
									}
								}
								else if(ObjectInfo[n][status][j] == 1 && PlayerClose(j,ObjectInfo[n][x_ent],ObjectInfo[n][y_ent],ObjectInfo[n][z_ent],ObjectInfo[n][spawndist]) == 0 && ObjectInfo[n][spawndist] > 0){
									DestroyPlayerObject(j,ObjectInfo[n][poid][j]);
									OBstreamcount[j]--;
									ObjectInfo[n][status][j] = 0;
								}
							}
							else if(ObjectInfo[n][status][j] == 1){
								DestroyPlayerObject(j,ObjectInfo[n][poid][j]);
								OBstreamcount[j]--;
								ObjectInfo[n][status][j] = 0;
							}
						}
					}
					AttachCheck(j);
				}
			}
		}
		stock PlayerViewAttachedObject(playerid,objectid){
			if(ObjectInfo[objectid][status][playerid] == 1 && ObjectInfo[objectid][pattached][playerid] == 0){
			    ObjectInfo[objectid][pattached][playerid] = 1;
			    AttachPlayerObjectToPlayer(playerid,ObjectInfo[objectid][poid][playerid],ObjectInfo[objectid][a_player],ObjectInfo[objectid][x_off],ObjectInfo[objectid][y_off],ObjectInfo[objectid][z_off],ObjectInfo[objectid][x_rt],ObjectInfo[objectid][y_rt],ObjectInfo[objectid][z_rt]);
				return 1;
			}
			new Float:posx,Float:posy,Float:posz;
			GetPlayerPos(ObjectInfo[objectid][a_player],posx,posy,posz);
		    if(ObjectInfo[objectid][status][playerid] == 0 && PlayerClose(playerid,posx,posy,posz,ObjectInfo[objectid][spawndist]) == 1 && ObjectInfo[objectid][attached] == 0 && ObjectInfo[objectid][pattached][playerid] == 0){
				if(OBstreamcount[playerid] < MAX_ACTIVE_OBJECTS){
		  			OBstreamcount[playerid]++;
			    	ObjectInfo[objectid][poid][playerid] = CreatePlayerObject(playerid,ObjectInfo[objectid][model],0.0,0.0,0.0,0.0,0.0,0.0);
					AttachPlayerObjectToPlayer(playerid,ObjectInfo[objectid][poid][playerid],ObjectInfo[objectid][a_player],ObjectInfo[objectid][x_off],ObjectInfo[objectid][y_off],ObjectInfo[objectid][z_off],ObjectInfo[objectid][x_rt],ObjectInfo[objectid][y_rt],ObjectInfo[objectid][z_rt]);
					ObjectInfo[objectid][status][playerid] = 1;
					ObjectInfo[objectid][pattached][playerid] = 1;
					return 1;
				}
			}
			if(PlayerClose(playerid,posx,posy,posz,ObjectInfo[objectid][spawndist]) == 0 && ObjectInfo[objectid][status][playerid] == 1){
			    DestroyPlayerObject(playerid,ObjectInfo[objectid][poid][playerid]);
			   	OBstreamcount[playerid]--;
			   	ObjectInfo[objectid][status][playerid] = 0;
			   	ObjectInfo[objectid][attached] = 0;
			   	return 1;
			}
			if(ObjectInfo[objectid][null][playerid] == 1){
		 		DestroyPlayerObject(playerid,ObjectInfo[objectid][poid][playerid]);
				OBstreamcount[playerid]--;
				ObjectInfo[objectid][status][playerid] = 0;
				ObjectInfo[objectid][null][playerid] = 0;
				ObjectInfo[objectid][attached] = 0;
				return 1;
			}
			return 0;
		}
		stock GetObjectSector(objectid){
			new xsec = floatround(((ObjectInfo[objectid][x_ent] +4000) / 500), floatround_floor);
			new ysec = floatround(((ObjectInfo[objectid][y_ent] +4000) / 500), floatround_floor);
			return (xsec * 16) + ysec;
		}
		stock CreateStreamObject(modelid,Float:x,Float:y,Float:z,Float:xrot,Float:yrot,Float:zrot,Float:spawn_dist,prior){
		    for(new i = 0;i<MAX_OVERALL_OBJECTS;i++){
			    if(ObjectInfo[i][valid] == 0){
					ObjectInfo[i][model] = modelid;
					ObjectInfo[i][x_ent] = x;
					ObjectInfo[i][y_ent] = y;
					ObjectInfo[i][z_ent] = z;
					ObjectInfo[i][x_rot] = xrot;
					ObjectInfo[i][y_rot] = yrot;
					ObjectInfo[i][z_rot] = zrot;
					ObjectInfo[i][valid] = 1;
					ObjectInfo[i][spawndist] = spawn_dist;
					ObjectInfo[i][priority] = prior;
					ObjectInfo[i][show] = 1;
					if(ObjectInfo[i][id_prev_used] == 0){
					    overallobjectcount++;
					}
					return i;
				}
			}
			return 0;
		}
		stock DestroyStreamObject(objectid){
			if(ObjectInfo[objectid][valid] == 1){
				ObjectInfo[objectid][valid] = 0;
				ObjectInfo[objectid][id_prev_used] = 1;
				for(new player = 0;player<MAX_PLAYERS;player++){
		        	if(ObjectInfo[objectid][status][player] == 1){
				   		DestroyPlayerObject(player,ObjectInfo[objectid][poid][player]);
				   		OBstreamcount[player]--;
				   		ObjectInfo[objectid][status][player] = 0;
					}
				}
				return 1;
		    }
		    return 0;
		}
		stock AttachStreamObjectToPlayer(objectid,playerid,Float:xoffset,Float:yoffset,Float:zoffset,Float:rotX,Float:rotY,Float:rotZ){
			if(PlAO[playerid] > -1){
			    return 0;
			}
		    ObjectInfo[objectid][attached] = 1;
			ObjectInfo[objectid][a_player] = playerid;
			ObjectInfo[objectid][x_off] = xoffset;
			ObjectInfo[objectid][y_off] = yoffset;
			ObjectInfo[objectid][z_off] = zoffset;
			ObjectInfo[objectid][x_rt] = rotX;
			ObjectInfo[objectid][y_rt] = rotY;
			ObjectInfo[objectid][z_rt] = rotZ;
			PlAO[playerid] = objectid;
			return 1;
		}
		stock DetachStreamObjectFromPlayer(playerid){
			if(ObjectInfo[PlAO[playerid]][attached] == 1 && ObjectInfo[PlAO[playerid]][a_player] == playerid){
				ObjectInfo[PlAO[playerid]][null][playerid] = 1;
				ObjectInfo[PlAO[playerid]][pattached][playerid] = 0;
				PlAO[playerid] = -1;
			}
		}
		stock IsAnyObjectAttachedToPlayer(playerid){
			if(PlAO[playerid] > -1){
			    return 1;
			}
			return 0;
		}
		stock GetPlayerAttachedObject(playerid){
			if(IsAnyObjectAttachedToPlayer(playerid) == 1) {
			    return PlAO[playerid];
			}
			return -1;
		}
		stock IsObjectAttachedToPlayer(objectid,playerid){
		    if(IsAnyObjectAttachedToPlayer(playerid) == 1){
		        if(PlAO[playerid] == objectid){
		            return 1;
		        }
		    }
		    return 0;
		}
		stock IsObjectAttachedToAnyPlayer(objectid){
			if(ObjectInfo[objectid][attached] == 1){
			    return 1;
			}
			return 0;
		}
		stock MoveStreamObject(objectid,Float:X,Float:Y,Float:Z,Float:Speedy){
		    for(new i = 0;i<MAX_PLAYERS;i++){
		        if(ObjectInfo[objectid][status][i] == 1 && ObjectInfo[objectid][attached] == 0){
		            MovePlayerObject(i,ObjectInfo[objectid][poid][i],X,Y,Z,Speedy);
		        }
		    }
			ObjectInfo[objectid][x_ent] = X;
			ObjectInfo[objectid][y_ent] = Y;
			ObjectInfo[objectid][z_ent] = Z;
		}
		stock StopStreamObject(objectid){
		    for(new i = 0;i<MAX_PLAYERS;i++){
		        if(ObjectInfo[objectid][status][i] == 1 && ObjectInfo[objectid][attached] == 0){
		            StopPlayerObject(i,ObjectInfo[objectid][poid][i]);
		        }
		    }
		}
		stock HideStreamObject(objectid){
			ObjectInfo[objectid][show] = 0;
		}
		stock ShowStreamObject(objectid){
			ObjectInfo[objectid][show] = 1;
		}
		stock IsValidPlayerStreamObject(objectid,playerid){
			if(ObjectInfo[objectid][status][playerid] == 1){
			    return 1;
			}
			return 0;
		}
		stock SetObjectInfo(objectid,modelid,Float:X,Float:Y,Float:Z,Float:rotX,Float:rotY,Float:rotZ){
			new tmp = ObjectInfo[objectid][model];
		    ObjectInfo[objectid][model] = modelid;
		    ObjectInfo[objectid][x_ent] = X;
		    ObjectInfo[objectid][y_ent] = Y;
		    ObjectInfo[objectid][z_ent] = Z;
		    ObjectInfo[objectid][x_rot] = rotX;
		    ObjectInfo[objectid][y_rot] = rotY;
		    ObjectInfo[objectid][z_rot] = rotZ;
		    for(new p = 0;p<MAX_PLAYERS;p++){
		        if(ObjectInfo[objectid][status][p] == 1 && ObjectInfo[objectid][attached] == 0){
		            if(tmp == modelid){
		                SetPlayerObjectPos(p,ObjectInfo[objectid][poid][p],X,Y,Z);
		                SetPlayerObjectRot(p,ObjectInfo[objectid][poid][p],rotX,rotY,rotZ);
		            }
		            else{
		            	DestroyPlayerObject(p,ObjectInfo[objectid][poid][p]);
		            	ObjectInfo[objectid][poid][p] = CreatePlayerObject(p,ObjectInfo[objectid][model],ObjectInfo[objectid][x_ent],ObjectInfo[objectid][y_ent],ObjectInfo[objectid][z_ent],ObjectInfo[objectid][x_rot],ObjectInfo[objectid][y_rot],ObjectInfo[objectid][z_rot]);
					}
		        }
		    }
		}
	//$ endregion Object-Streamer
	//$ region Textdraw-Streamer
		stock TextDrawStreamPos(textdid,Float:x, Float:y){
			if ( TextInfo[textdid][TCreated] == 1 ){
				TextInfo[textdid][TPos][0] = x;
				TextInfo[textdid][TPos][1] = y;
				TextDrawStreamReload(textdid);
				return 1;
			}
			return 0;
		}
		stock TextDrawStreamTextSize(textdid, Float:x, Float:y){
			if ( TextInfo[textdid][TCreated] == 1 ){
				TextInfo[textdid][TSize][0] = x;
				TextInfo[textdid][TSize][1] = y;
				TextDrawStreamReload(textdid);
				return 1;
			}
			return 0;
		}
		stock TextDrawStreamLetterSize(textdid, Float:x, Float:y){
			if ( TextInfo[textdid][TCreated] == 1 ){
				TextInfo[textdid][LSize][0] = x;
				TextInfo[textdid][LSize][1] = y;
				TextDrawStreamReload(textdid);
				return 1;
			}
			return 0;
		}
		stock TextDrawStreamSetOutline(textdid, size){
			if ( TextInfo[textdid][TCreated] == 1 ){
				TextInfo[textdid][TOutL] = size;
				TextDrawStreamReload(textdid);
				return 1;
			}
			return 0;

		}
		stock TextDrawStreamSetProportional(textdid, set){
			if ( TextInfo[textdid][TCreated] == 1 ){
				TextInfo[textdid][TProp] = set;
				TextDrawStreamReload(textdid);
				return 1;
			}
			return 0;

		}
		stock TextDrawStreamSetShadow(textdid, size){
			if ( TextInfo[textdid][TCreated] == 1 ){
				TextInfo[textdid][TShadow] = size;
				TextDrawStreamReload(textdid);
				return 1;
			}
			return 0;

		}
		stock TextDrawStreamSetString(textdid, string[255]){
			if ( TextInfo[textdid][TCreated] == 1 ){
				TextInfo[textdid][TString] = string;
				TextDrawStreamReload(textdid);
				return 1;
			}
			return 0;
		}
		stock TextDrawStreamAlignment(textdid,align){
			if ( TextInfo[textdid][TCreated] == 1 ){
				TextInfo[textdid][TAlign] = align;
				TextDrawStreamReload(textdid);
				return 1;
			}
			return 0;
		}
		stock TextDrawStreamUseBox(textdid, use){
			if ( TextInfo[textdid][TCreated] == 1 ){
				TextInfo[textdid][TBox] = use;
				TextDrawStreamReload(textdid);
				return 1;
			}
			return 0;
		}
		stock TextDrawStreamFont(textdid, font){
			if ( TextInfo[textdid][TCreated] == 1 ){
				TextInfo[textdid][TFont] = font;
				TextDrawStreamReload(textdid);
				return 1;
			}
			return 0;
		}
		stock TextDrawStreamBackgroundColor(textdid,color){
			if ( TextInfo[textdid][TCreated] == 1 ){
				TextInfo[textdid][BgColor] = color;
				TextDrawStreamReload(textdid);
				return 1;
			}
			return 0;
		}
		stock TextDrawStreamBoxColor(textdid,color){
			if ( TextInfo[textdid][TCreated] == 1 ){
				TextInfo[textdid][BColor] = color;
				TextDrawStreamReload(textdid);
				return 1;
			}
			return 0;

		}
		stock TextDrawStreamColor(textdid,color){
			if ( TextInfo[textdid][TCreated] == 1 ){
				TextInfo[textdid][TColor] = color;
				TextDrawStreamReload(textdid);
				return 1;
			}
			return 0;
		}
		stock TextDrawStreamCreateEx(Float:x, Float:y, Float:TdSizeX, Float:TdSizeY, Float:LeSizeX, Float:LeSizeY, String[255], BackGColor, BoxColor, Color, font, outline, align, proportional, shadow, usebox){
			new i;
			while ( TextInfo[i][TCreated] == 1) {
				i++;
			}
			TextInfo[i][TPos][0] = x;
			TextInfo[i][TPos][1] = y;
			TextInfo[i][TSize][0] = TdSizeX;
			TextInfo[i][TSize][1] = TdSizeY;
			TextInfo[i][LSize][0] = LeSizeX;
			TextInfo[i][LSize][1] = LeSizeY;
			TextInfo[i][TString] = String;
			TextInfo[i][BgColor] = BackGColor;
			TextInfo[i][BColor] = BoxColor;
			TextInfo[i][TColor] = Color;
			TextInfo[i][TFont] = font;
			TextInfo[i][TOutL] = outline;
			TextInfo[i][TAlign] = align;
			TextInfo[i][TProp] = proportional;
			TextInfo[i][TShadow] = shadow;
			TextInfo[i][TBox] = usebox;
			TextInfo[i][TCreated] = 1;
			return i;
		}
		stock TextDrawStreamCreate(Float:x, Float:y, String[255]){
			new i;
			while ( TextInfo[i][TCreated] == 1) {
				i++;
			}
			TextInfo[i][TPos][0] = x;
			TextInfo[i][TPos][1] = y;
			TextInfo[i][TSize][0] = 1.0;
			TextInfo[i][TSize][1] = 1.0;
			TextInfo[i][LSize][0] = 1.0;
			TextInfo[i][LSize][1] = 1.0;
			TextInfo[i][TString] = String;
			TextInfo[i][BgColor] = 0xAFAFAFAA;
			TextInfo[i][BColor] = 0x000000AA;
			TextInfo[i][TColor] = 0xFFFFFFAA;
			TextInfo[i][TFont] = 1;
			TextInfo[i][TOutL] = 1;
			TextInfo[i][TAlign] = 1;
			TextInfo[i][TProp] = 1;
			TextInfo[i][TShadow] = 1;
			TextInfo[i][TBox] = 1;
			TextInfo[i][TCreated] = 1;
			return i;
		}
		stock TextDrawStreamDestroy(textdid){
			if ( TextInfo[textdid][TCreated] == 1 ){
				if ( TextInfo[textdid][TLoaded] == 1 ){
					TextDrawStreamUnload(textdid);
				}
				TextDrawStreamSetString(textdid, "");
				TextInfo[textdid][TPos][0] = 0;
				TextInfo[textdid][TPos][1] = 0;
				TextInfo[textdid][TSize][0] = 0;
				TextInfo[textdid][TSize][1] = 0;
				TextInfo[textdid][LSize][0] = 0;
				TextInfo[textdid][LSize][1] = 0;
				TextInfo[textdid][BgColor] = 0;
				TextInfo[textdid][BColor] = 0;
				TextInfo[textdid][TColor] = 0;
				TextInfo[textdid][TFont] = 0;
				TextInfo[textdid][TOutL] = 0;
				TextInfo[textdid][TAlign] = 0;
				TextInfo[textdid][TProp] = 0;
				TextInfo[textdid][TShadow] = 0;
				TextInfo[textdid][TBox] = 0;
				TextInfo[textdid][TCreated] = 0;
				return 1;
			}
			return 0;
		}
		stock TextDrawStreamLoad(textdid){
			if ( TextInfo[textdid][TCreated] == 1 ){
				if ( TextInfo[textdid][TLoaded] == 0 ){
					TextInfo[textdid][DrawId]=TextDrawCreate(TextInfo[textdid][TPos][0],TextInfo[textdid][TPos][1],TextInfo[textdid][TString]);
					TextDrawLetterSize(TextInfo[textdid][DrawId],TextInfo[textdid][LSize][0],TextInfo[textdid][LSize][1]);
					TextDrawTextSize(TextInfo[textdid][DrawId],TextInfo[textdid][TSize][0],TextInfo[textdid][TSize][1]);
					TextDrawBackgroundColor (TextInfo[textdid][DrawId],TextInfo[textdid][BgColor]);
					TextDrawBoxColor(TextInfo[textdid][DrawId],TextInfo[textdid][BColor]);
					TextDrawColor(TextInfo[textdid][DrawId],TextInfo[textdid][TColor]);
					TextDrawFont(TextInfo[textdid][DrawId],TextInfo[textdid][TFont]);
					TextDrawAlignment(TextInfo[textdid][DrawId],TextInfo[textdid][TAlign]);
					TextDrawSetOutline(TextInfo[textdid][DrawId],TextInfo[textdid][TOutL]);
					TextDrawSetProportional(TextInfo[textdid][DrawId],TextInfo[textdid][TProp]);
					TextDrawSetShadow(TextInfo[textdid][DrawId],TextInfo[textdid][TShadow]);
					TextDrawUseBox(TextInfo[textdid][DrawId],TextInfo[textdid][TBox]);
					TextInfo[textdid][TLoaded] = 1;
					return 1;
				}
			}
			return 0;
		}
		stock TextDrawStreamUnload(textdid){
			if ( TextInfo[textdid][TCreated] == 1 && TextInfo[textdid][TLoaded] == 1 ){
				TextDrawStreamHideForAll(textdid);
				TextDrawDestroy(TextInfo[textdid][DrawId]);
				TextInfo[textdid][TLoaded] = 0;
				return 1;
			}
			return 0;
		}
		stock TextDrawStreamReload(textdid){
			if ( TextInfo[textdid][TCreated] == 1 && TextInfo[textdid][TLoaded] == 1){
				new j[MAX_PLAYERS];
				for (new h = 0; h < MAX_PLAYERS; h++){
					j[h] = TextInfo[textdid][TShown][h];
				}
				TextDrawStreamUnload(textdid);
				for (new i = 0; i < MAX_PLAYERS; i++){
					if ( j[i] == 1){
						TextDrawStreamShowForPlayer(i, textdid);
					}
				}
				return 1;
			}
			return 0;
		}
		stock TextDrawStreamShowForAll(textdid){
			if ( TextInfo[textdid][TCreated] == 1 ){
				if ( TextInfo[textdid][TLoaded] == 0 ){
					TextDrawStreamLoad(textdid);
				}
				TextDrawShowForAll(TextInfo[textdid][DrawId]);
				for (new i = 0; i < MAX_PLAYERS; i++){
					TextInfo[textdid][TShown][i] = 1;
				}
				return 1;
			}
			return 0;
		}
		stock TextDrawStreamHideForAll(textdid){
			if ( TextInfo[textdid][TCreated] == 1 ){
				for (new i = 0; i < MAX_PLAYERS; i++){
					if ( TextInfo[textdid][TShown][i] == 1){
						TextInfo[textdid][TShown][i] = 0;
					}
				}
				TextDrawHideForAll(TextInfo[textdid][DrawId]);
				return 1;
			}
			return 0;
		}
		stock TextDrawStreamShowForPlayer(playerid, textdid){
			if ( TextInfo[textdid][TCreated] == 1 ){
				if ( TextInfo[textdid][TLoaded] == 0 ){
					TextDrawStreamLoad(textdid);
				}
				if ( TextInfo[textdid][TShown][playerid] == 0){
					TextInfo[textdid][TShown][playerid] = 1;
					TextDrawShowForPlayer(playerid, TextInfo[textdid][DrawId]);
				}
				return 1;
			}
			return 0;
		}
		stock TextDrawStreamHideForPlayer(playerid, textdid){
			if ( TextInfo[textdid][TCreated] == 1 ){
				if ( TextInfo[textdid][TShown][playerid] == 1){
					TextInfo[textdid][TShown][playerid] = 0;
					TextDrawHideForPlayer(playerid, TextInfo[textdid][DrawId]);
				}
				return 1;
			}
			return 0;
		}
		stock TextDrawStreamSet(textdid, Float:x, Float:y, Float:TdSizeX, Float:TdSizeY, Float:LeSizeX, Float:LeSizeY, String[], BackGColor, BoxColor, Color, font, outline, align, proportional, shadow, usebox){
			if ( TextInfo[textdid][TCreated] == 1 ){
				TextInfo[textdid][TPos][0] = x;
				TextInfo[textdid][TPos][1] = y;
				TextInfo[textdid][TSize][0] = TdSizeX;
				TextInfo[textdid][TSize][1] = TdSizeY;
				TextInfo[textdid][LSize][0] = LeSizeX;
				TextInfo[textdid][LSize][1] = LeSizeY;
				TextInfo[textdid][TString] = String;
				TextInfo[textdid][BgColor] = BackGColor;
				TextInfo[textdid][BColor] = BoxColor;
				TextInfo[textdid][TColor] = Color;
				TextInfo[textdid][TFont] = font;
				TextInfo[textdid][OutL] = outline;
				TextInfo[textdid][TAlign] = align;
				TextInfo[textdid][Prop] = proportional;
				TextInfo[textdid][Shadow] = shadow;
				TextInfo[textdid][Box] = usebox;
				TextDrawStreamReload(textdid);
				return 1;
			}
			return 0;
		}
	//$ endregion Textdraw-Streamer
	//$ region 3D-Label-Streamer
		stock CreatStreamLabel3d(text[], color, Float:X, Float:Y, Float:Z, Float:DrawDistance, attachedplayer, attachedvehicle, testLOS, priorityy){
			for (new i = 0; i < MAX_LABELS; i++){
				if ( !Label3dInfo[i][lblcreated] ){
					Label3dInfo[i][lblname] = text;
					Label3dInfo[i][lblcolor] = color;
					Label3dInfo[i][lblpos][0] = X;
					Label3dInfo[i][lblpos][1] = Y;
					Label3dInfo[i][lblpos][2] = Z;
					Label3dInfo[i][lbldistance] = DrawDistance;
					Label3dInfo[i][playerattach] = attachedplayer;
					Label3dInfo[i][vehicleattach] = attachedvehicle;
					Label3dInfo[i][lblLOS] = testLOS;
					Label3dInfo[i][lblpriority] = priorityy;
					Label3dInfo[i][lblcreated] = true;
					if ( i+1>labelcount ){
						labelcount = i+1;
					}
					return i;
				}
			}
			return 0;
		}
		stock DeleteStreamLabel3d(lblid){
			if ( Label3dInfo[lblid][lblcreated] ){
				if ( lblid==Label3dInfo-1 ){
					do {
						labelcount--;
					}
					while (!Label3dInfo[Label3dInfo-1][CREATED] || Label3dInfo!=1);
					if (labelcount==1 && !Label3dInfo[labelcount-1][CREATED]){
						labelcount--;
					}
				}
				Label3dInfo[lblid][lblname] = "  ";
				Label3dInfo[lblid][lblcolor] = COLOR_BLACK;
				Label3dInfo[lblid][lblpos][0] = 0;
				Label3dInfo[lblid][lblpos][1] = 0;
				Label3dInfo[lblid][lblpos][2] = 0;
				Label3dInfo[lblid][lbldistance] = 0;
				Label3dInfo[lblid][playerattach] = INVALID_PLAYER_ID;
				Label3dInfo[lblid][vehicleattach] = INVALID_VEHICLE_ID;
				Label3dInfo[lblid][lblLOS] = 0;
				Label3dInfo[lblid][lblpriority] = 0;
				Label3dInfo[lblid][lblcreated] = false;
				return i;
			}
		}
		stock UpdateStreamLabel3d(lblid, text[], color, Float:X, Float:Y, Float:Z, Float:DrawDistance, attachedplayer, attachedvehicle, testLOS, priorityy){
			if ( Label3dInfo[lblid][lblcreated] ){
				Label3dInfo[lblid][lblname] = text;
				Label3dInfo[lblid][lblcolor] = color;
				Label3dInfo[lblid][lblpos][0] = X;
				Label3dInfo[lblid][lblpos][1] = Y;
				Label3dInfo[lblid][lblpos][2] = Z;
				Label3dInfo[lblid][lbldistance] = DrawDistance;
				Label3dInfo[lblid][playerattach] = attachedplayer;
				Label3dInfo[lblid][vehicleattach] = attachedvehicle;
				Label3dInfo[lblid][lblLOS] = testLOS;
				Label3dInfo[lblid][lblpriority] = priorityy;
				Label3dInfo[lblid][lblcreated] = true;
				return i;
			}
		}
		stock AttachStreamLabel3dToPlayer(){

		}
		stock AttachStreamLabel3dToVehicle(){

		}
		stock AttachStreamLabel3dToObject(){

		}
		stock DetachStreamLabel3dFromPlayer(){

		}
		stock DetachStreamLabel3dFromVehicle(){

		}
		stock DetachStreamLabel3dFromObject(){

		}
		stock ShowLabel3d(playerid,lblid){

		}
	//$ endregion 3D-Label-Streamer
	//$ region Checkpoint-Streamer
		stock CreateCheckpoint(Float:posX, Float:posY, Float:posZ, Float:size, Float:viewDistance, CHPinterior, CHPworld){
			// Max checkpoint reached?
			if(totalCheckpoints == MAX_CHECKPOINTS) return 0;
			if(!totalCheckpoints){
				for(new i; i < MAX_PLAYERS; i++) PlayerInfo[i][VisibleCheckpoint] = -1;
				for(new i; i < MAX_CHECKPOINTS; i++){
					checkpoints[i][chp_created] = false;
				}
			}
			new slot;
			for(new i = 0; i < MAX_CHECKPOINTS; i++){
				if(!checkpoints[i][chp_created]){
					slot = i;
					break;
				}
			}
			checkpoints[slot][chp_created] = true;
			checkpoints[slot][chp_posX] = posX;
			checkpoints[slot][chp_posY] = posY;
			checkpoints[slot][chp_posZ] = posZ;
			checkpoints[slot][chp_size] = size;
			checkpoints[slot][chp_viewDistance] = viewDistance;
			checkpoints[slot][chp_active] = true;
			checkpoints[slot][chp_interior_id] = CHPinterior;
			checkpoints[slot][chp_world_id] = CHPworld;
			for (new i = 0; i < MAX_PLAYERS; i++){
				checkpoints[slot][chp_shown][i] = false;
			}
			totalCheckpoints++;
			return slot;
		}
		stock ShowCheckpoint(playerid, chpid){
			if ( checkpoints[chpid][chp_created] && checkpoints[chpid][chp_active] && !checkpoints[chpid][chp_shown][playerid]){
				for (new i = 0; i < MAX_CHECKPOINTS; i++){
					HideCheckpoint(playerid, i);
				}
				checkpoints[chpid][chp_shown][playerid] = true;
				return 1;
			}
			return 0;
		}
		stock HideCheckpoint(playerid, chpid){
			if ( checkpoints[chpid][chp_created] && checkpoints[chpid][chp_active] && checkpoints[chpid][chp_shown][playerid]){
				checkpoints[chpid][chp_shown][playerid] = false;
				return 1;
			}
			return 0;
		}
		stock SetCheckpointSize(chpid, Float:size){
			if(checkpoints[chpid][chp_created]){
				checkpoints[chpid][chp_size] = size;
				return 1;
			}
			return 0;
		}
		stock SetCheckpointPos(chpid, Float:posX, Float:posY, Float:posZ){
			if(checkpoints[chpid][chp_created]){
				checkpoints[chpid][chp_posX] = posX;
				checkpoints[chpid][chp_posY] = posY;
				checkpoints[chpid][chp_posZ] = posZ;
				return 1;
			}
			return 0;
		}
		stock SetCheckpointInterior(chpid, CHPinterior){
			if(checkpoints[chpid][chp_created]){
				checkpoints[chpid][chp_interior_id] = CHPinterior;
				return 1;
			}
			return 0;
		}
		stock SetCheckpointVirtualWorld(chpid, CHPworld){
			if(checkpoints[chpid][chp_created]){
				checkpoints[chpid][chp_world_id] = CHPworld;
				return 1;
			}
			return 0;
		}
		stock ToggleCheckpointActive(chpid, bool:active){
			if(checkpoints[chpid][chp_created]){
				checkpoints[chpid][chp_active] = active;
				return 1;
			}
			return 0;
		}
		stock RemoveCheckpoint(chpid){
			if(checkpoints[chpid][chp_created]){
				checkpoints[chpid][chp_created] = false;
				checkpoints[chpid][chp_id] = -1;
				checkpoints[chpid][chp_posX] = -1;
				checkpoints[chpid][chp_posY] = -1;
				checkpoints[chpid][chp_posZ] = -1;
				checkpoints[chpid][chp_size] = -1;
				checkpoints[chpid][chp_viewDistance] = -1;
				checkpoints[chpid][chp_active] = false;
				checkpoints[chpid][chp_interior_id] = -1;
				checkpoints[chpid][chp_world_id] = -1;
				for (new i = 0; i < MAX_PLAYERS; i++){
					checkpoints[chpid][chp_shown][i] = false;
				}
				totalCheckpoints--;
				return 1;
			}
			return 0;
		}
		stock VerifyCheckpoint(playerid, EnterExit){
			if(PlayerInfo[playerid][VisibleCheckpoint] >= 0){
				if ( EnterExit == 1 ){
					OnCheckpointEnter(playerid, PlayerInfo[playerid][VisibleCheckpoint]);
				}
				else{
					OnCheckpointExit(playerid, PlayerInfo[playerid][VisibleCheckpoint]);
				}
				return 1;
			}
			return 0;
		}
		public StreamCheckpoints(){
			new Float:posX, Float:posY, Float:posZ;
			new chpinterior;
			new chpvirtualWorld;
			for(new i; i < MAX_PLAYERS; i++){
				if(IsPlayerConnected(i)){
					if(PlayerInfo[i][VisibleCheckpoint] > -1){
						if((!PlayerClose(i,checkpoints[PlayerInfo[i][VisibleCheckpoint]][chp_posX],checkpoints[PlayerInfo[i][VisibleCheckpoint]][chp_posY],checkpoints[PlayerInfo[i][VisibleCheckpoint]][chp_posZ],checkpoints[PlayerInfo[i][VisibleCheckpoint]][chp_viewDistance]) && checkpoints[PlayerInfo[i][VisibleCheckpoint]][chp_viewDistance] > 0) || !checkpoints[PlayerInfo[i][VisibleCheckpoint]][chp_active] || !checkpoints[PlayerInfo[i][VisibleCheckpoint]][chp_shown][i]){
							DisablePlayerCheckpoint(i);
							PlayerInfo[i][VisibleCheckpoint] = -1;
						}
					}
					else{
						chpinterior = GetPlayerInterior(i);
						chpvirtualWorld = GetPlayerVirtualWorld(i);
						for(new j = 0; j < MAX_CHECKPOINTS; j++){
							if(!checkpoints[j][chp_created]) continue;
							if(checkpoints[j][chp_interior_id] != chpinterior) continue;
							if(checkpoints[j][chp_world_id] != chpvirtualWorld) continue;
							if(checkpoints[j][chp_active]){
								if((PlayerClose(i,checkpoints[j][chp_posX],checkpoints[j][chp_posY],checkpoints[j][chp_posZ],checkpoints[j][chp_viewDistance]) || checkpoints[j][chp_viewDistance] == 0) && checkpoints[j][chp_shown][i]){
									SetPlayerCheckpoint(i, checkpoints[j][chp_posX], checkpoints[j][chp_posY], checkpoints[j][chp_posZ], checkpoints[j][chp_size]);
									PlayerInfo[i][VisibleCheckpoint] = j;
									break;
								}
							}
						}
					}
				}
			}
			return 1;
		}
	//$ endregion Checkpoint-Streamer
//$ endregion Streamer

