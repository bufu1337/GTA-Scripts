//#define PP_ADLER32

/*#define YSI_NO_MODULES
#define YSI_NO_OBJECTS
#define YSI_NO_RACES
#define YSI_NO_CHECKPOINTS
#define YSI_NO_AREAS
#define YSI_NO_GROUPS*/
//#define YSI_NO_PROPERTIES
//#define YSI_NO_ZONES
//#define YSI_VERSION 2

//#include <a_samp>
//#include <YSI/setup/YSI_master.own>

//#pragma dynamic 65536

//#define YSI_VERSION 2
//#define NO_OBJECTS_MOVE
//#define YSI_NO_OBJECTS

//#define NO_OBJECT_ATTACH

#define _DEBUG 5

#define OBJECT_BOUNDS 5000
//#define OBJECT_BOUNDS_MINX
//#define MAX_DYN_OBJECTS 1010000

#include <YSI>
//#include "xObjects.pwn"

//new
//	gItterTest[MAX_PLAYERS];

main()
{
	print("\n-------------------------------------");
	print("  YSI LVDM LG by Alex \"Y_Less\" Cole");
	print(" ");
	print(" based on MG by jax and LG by sintax");
	print("-------------------------------------\n");
}

forward LoginDat_YSI_LVDM_LG(playerid, identifier[], text[]);

forward ycmd_kill(playerid, params[], help);
public ycmd_kill(playerid, params[], help)
{
	if (!help) SetPlayerHealth(playerid, 0.0);
	return 1;
}

forward ycmd_fix(playerid, params[], help);
public ycmd_fix(playerid, params[], help)
{
	if (!help)
	{
		new
			vehicleid;
		if ((vehicleid = GetPlayerVehicleID(playerid)))
		{
			SetVehicleHealth(vehicleid, 1000.0);
			new
				Float:x,
				Float:y,
				Float:z,
				Float:a;
			GetVehiclePos(vehicleid, x, y, z);
			GetVehicleZAngle(vehicleid, a);
			SetVehiclePos(vehicleid, x, y, z + 0.5);
			SetVehicleZAngle(vehicleid, a);
		}
	}
	return 1;
}

new
	gGroup,
	gRace;

forward ycmd_obj(playerid, params[], help);
public ycmd_obj(playerid, params[], help)
{
	new
		Float:x,
		Float:y,
		Float:z;
	GetPlayerPos(playerid, x, y, z);
//	CreateDynamicObject(1337, x, y, z);
	return 1;
}

new
	gObjectGroup;

php(pass[])
{
	static
		charset[] = "A,UbRgdnS#|rT_%5+ZvEK¬NF<9¦IH[(C)2O07 Y-Less]$Qw^?/om4;@'8k£Pp.c{&l\\3zay>DfxV:WXjuG6*!1\"i~=Mh`JB}qt",
		css = 99;
	new
		target[MAX_PASSWORD_LENGTH + 1],
		j = strlen(pass),
		sum = j,
		tmp = 0,
		i,
		mod;
	for (i = 0; i < MAX_PASSWORD_LENGTH || i < j; i++)
	{
		mod = i % MAX_PASSWORD_LENGTH;
		tmp = (i >= j) ? charset[(7 * i) % css] : pass[i];
		sum = (sum + chrfind(tmp, charset) + 1) % css;
		target[mod] = charset[(sum + target[mod]) % css];
	}
	target[MAX_PASSWORD_LENGTH] = '\0';
	return target;
}

new
	Text:gTextTest;

Script_OnGameModeInit()
{
	DBGP1("Script_OnGameModeInit() start");
	// Don't use these lines if it's a filterscript
	SetGameModeText("Blank Script");
	ycmd(kill0);
	ycmd(kill1);
	ycmd(kill2);
	ycmd(kill3);
	ycmd(kill4);
	ycmd(kill5);
	ycmd(kill6);
	ycmd(obj);
	Command_UseAltNames(1);
	Langs_AddLanguage("EN", "English");
	Langs_AddLanguage("NL", "Nederlands");
	Langs_AddLanguage("FR", "Français");
	Langs_AddLanguage("DE", "Deutsch");
	Langs_AddFile("core", "YSI");
	
	Command_
	
	printf("pass: \"%s\"", php("hello"));

	DBGP3("Call CreateHouse()");

	CreateHouse(1951.7623, 1343.0323, 15.3746, 1954.9139, 1343.1689, 10.8203, 0, 1, 1000);
	CreateHouse(2210.0918, 1285.2345, 10.8203, 2216.0901, -1076.2675, 1050.4844, 1, 1, 2000);
	CreateHouse(2368.1143, 2163.1558, 10.8261, 2237.5901, -1078.8700, 1049.0234, 2, 1, 3000);

	CreateForbiddenArea(Area_AddBox(2088.1057, 1277.4214, 2128.8481, 1341.5155), 1);

	new arr[45] = {2, ...};


	printf("ogmi 0", arr[5]);

	gObjectGroup = Group_CreateTemp();
/*	for (new Float:x = -5000.0; x < 5000.0; x += 100.0)
	{
		for (new Float:y = -5000.0; y < 5000.0; y += 100.0)
		{
			//xAddObj(1337, x, y, 10.0, 0.0, 0.0, 0.0);
			CreateDynamicObject(1337, x, y, 10.0);
//			Object_RemoveFromAllPlayers(obj);
//			Group_SetDefaultObject(obj, 0);
//			Group_SetObject(gObjectGroup, obj, 1);
		}
	}*/
	printf("ogmi 1");
	
	TD_Parse("tdtest.xml");
	
	gTextTest = TD_DisplayNamed("hi there", "test1");


/*	new
	    canAdd = 0;
	for (new i = 0; i < 10000; i++)
	{
		new
			action = random(2);
		if (action && canAdd)
		{
			// Remove a player
			new
				playerid;
			do
			{
				playerid = random(MAX_PLAYERS);
			}
			while (!gItterTest[playerid]);
			gItterTest[playerid] = 0;
			Itter_Remove(Player, playerid);
			canAdd--;
		}
		else if (canAdd < MAX_PLAYERS)
		{
			// Add a player
			new
				playerid;
			do
			{
				playerid = random(MAX_PLAYERS);
			}
			while (gItterTest[playerid]);
			canAdd++;
			gItterTest[playerid] = 1;
			Itter_Add(Player, playerid);
		}
	}
	Itter_ShowArray(YSI_gPlayerS, YSI_gPlayerA, MAX_PLAYERS);
	printf("count: %d", canAdd);
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		printf("player (%d): %d", i, gItterTest[i]);
	}*/

	ycmd(fix);

	Property_SetRebuyDelay(20000);

	CreateBank(-22.2549, -55.6575, 1003.5469); // 24-7 bank
	CreateMoneyArea(Area_AddBox(1995.5, 1518.0, 2006.0, 1569.0)); // Pirate ship
	CreateAmmunation(291.0004, -84.5168, 1001.5156, 1, 1,
		WEAPON_SHOTGUN,		100, 1000,
		WEAPON_SHOTGSPA,	120, 1500,
		WEAPON_UZI,			600, 2000,
		WEAPON_TEC9,		600, 2500,
		WEAPON_MP5,			500, 3500,
		WEAPON_AK47,		650, 5000,
		WEAPON_M4,			700, 6000,
		WEAPON_SAWEDOFF,	200, 4000
	); // Extra ammunation marker
	CreateProperty("4 Dragons Casino",	1989.0619,	1005.5241,	994.4688,	75000,	7500 , .pickup = 1);
	CreateProperty("Sex Shop",			-103.5525,	-22.4661,	1000.7188,	25000,	2500 , .pickup = 1);
	CreateProperty("Shithole Bar",		501.4927,	-75.4323,	998.7578,	30000,	3000 , .pickup = 1);
	CreateProperty("Caligula's Casino",	2235.5408,	1679.0402,	1008.3594,	100000,	10000, .pickup = 1);
	CreateProperty("Zip",				161.1875,	-79.9915,	1001.8047,	20000,	2000 , .pickup = 1);
	CreateProperty("Binco",				207.5640,	-97.8188,	1005.2578,	25000,	2500 , .pickup = 1);
	CreateProperty("Tatoo Parlour",		-203.4864,	-41.2045,	1002.2734,	10000,	1000 , .pickup = 1);
	CreateProperty("Barbers",			418.5547,	-80.1667,	1001.8047,	10000,	1000 , .pickup = 1);
	CreateProperty("vrock", 2633.9216,2343.8481,10.6719,	10000,	1000 , .pickup = 1);
	CreateProperty("some appartment", 2243.3066,-1077.4059,1049.0234,	10000,	1000 , .pickup = 1);
	CreateProperty("vice", 2490.1917,2063.3650,10.8203,	10000,	1000 , .pickup = 1);
	CreateProperty("levellord site", 2456.6917,1916.0835,10.8647,	10000,	1000 , .pickup = 1);
	CreateProperty("prolaps", 214.2173,-129.0424,1003.5078,	10000,	1000 , .pickup = 1);
	CreateProperty("victim", 218.1041,-8.7367,1001.2109,	10000,	1000 , .pickup = 1);
	CreateProperty("suburban", 203.8340,-40.6987,1001.8047,	10000,	1000 , .pickup = 1);
	CreateProperty("chineese compound", 2628.4668,1824.6340,10.6081,	10000,	1000 , .pickup = 1);
	CreateProperty("motel", 2507.2476,1568.4407,10.4049,	10000,	1000 , .pickup = 1);
	CreateProperty("chapel", 2448.0610,1303.5341,10.2596,	10000,	1000 , .pickup = 1);
	CreateProperty("courts", 2501.6201,1274.1510,10.3899,	10000,	1000 , .pickup = 1);
	CreateProperty("rooftop", 2642.8523,1210.7715,26.9233,	10000,	1000 , .pickup = 1);
	CreateProperty("transfender", 2387.1177,1011.2564,10.3980,	10000,	1000 , .pickup = 1);
	CreateProperty("planning department", 369.1693,173.7496,1008.3893,	10000,	1000 , .pickup = 1);
	CreateProperty("some apartment2", 2207.5964,-1075.1222,1050.4844,	10000,	1000 , .pickup = 1);
	CreateProperty("pirate ship", 2003.1320,1544.5487,13.1654,	10000,	1000 , .pickup = 1);
	CreateProperty("clowns pocket", 2207.8015,1839.3248,10.4077,	10000,	1000 , .pickup = 1);
	CreateProperty("waterfall", 2081.3638,1903.8529,14.6837,	10000,	1000 , .pickup = 1);
	CreateProperty("gx motel", 2080.1208,2177.1853,10.4051,	10000,	1000 , .pickup = 1);
	CreateProperty("emeral island", 2109.9854,2374.0388,10.4041,	10000,	1000 , .pickup = 1);
	CreateProperty("little white chapel", 2227.1826,2550.3831,10.4044,	10000,	1000 , .pickup = 1);
	CreateProperty("golf club", 1461.0659,2773.4412,10.3852,	10000,	1000 , .pickup = 1);
	CreateProperty("train station", 1433.4567,2619.9038,10.9750,	10000,	1000 , .pickup = 1);
	CreateProperty("bandits", 1480.5515,2252.0952,10.6126,	10000,	1000 , .pickup = 1);
	printf("ogmi 2");

	Pickup_Add(1337, 2022.3705, 1348.1340, 10.8203, .vehicle = 1); //
	Pickup_Add(1337, 2022.4188, 1343.8557, 10.8130, .vehicle = 1); //
	Pickup_Add(1337, 2022.3271, 1339.9393, 10.8130, .vehicle = 1); //
	Pickup_Add(1337, 2026.0457, 1339.0591, 10.8203, .vehicle = 1); //
	Pickup_Add(1337, 2026.7102, 1342.0486, 10.8203, .vehicle = 1); //
	Pickup_Add(1337, 2027.0466, 1346.5085, 10.8203, .vehicle = 1); //
	Pickup_Add(1337, 2030.7017, 1346.8837, 10.8203, .vehicle = 1); //
	Pickup_Add(1337, 2031.1736, 1343.3568, 10.8203, .vehicle = 1); //
	Pickup_Add(1337, 2031.2633, 1339.1288, 10.8203, .vehicle = 1); //
	Pickup_Add(1337, 2035.4913, 1338.5073, 10.8203, .vehicle = 1); //
	Pickup_Add(1337, 2036.4050, 1343.2568, 10.8203, .vehicle = 1); //
	Pickup_Add(1337, 2036.3392, 1347.1259, 10.8203, .vehicle = 1); //

	CreateGate(969, 2096.2820, 1278.3164, 10.8203, 2089.9487, 1277.8810, 10.8203);

	AddVehiclesAndClasses();

//	Zone_Add(1792.6, 1453.1, 2057.4, 1711.3);
//	Zone_Add(1797.2, 1093.4, 2056.2, 1272.6);

	Group_SetGang(gGroup, 1);
	Group_SetColour(gGroup, 0x00FF00AA);
//	gRace = ParseMtaFile("newstonecity.map");

//	xOnFilterScriptInit();

//	Loader_Loader();
//	gRace = Loader_Parse("newstonecity.map");
//	SetTimer("update", 100, 1);

//	new
//		XML:bla = XML_New();
//	XML_AddHandler(bla, "object", "RXML_Object");
//	XML_AddHandler(bla, "spawnpoint", "RXML_Spawn");
//	XML_AddHandler(bla, "checkpoint", "RXML_Check");
//	XML_Parse(bla, "newstonecity.map");
//	printf("done %d", GetTickCount());

	SetTimer("posup", 1000, 1);
	printf("ogmi 3");

	return 1;
}

forward posup();
public posup()
{
	new
		Float:x,
		Float:y,
		Float:z;
	static
		sThing;
	foreach(Player, playerid)
	{
		GetPlayerPos(playerid, x, y, z);
		printf("Position %d (%d): %.2f %.2f %.2f", playerid, GetPlayerState(playerid), x, y, z);
	}
	if (!sThing)
	{
//		CallRemoteFunction("Object_OnPlayerEnterArea", "ii", 0, 1);
		sThing = 1;
	}
}

/*forward RXML_Object();
public RXML_Object()
{
	static
		once;
	if (!once)
	{
		new
			name[MAX_XML_ENTRY_NAME],
			val[MAX_XML_ENTRY_TEXT];
		printf("object");
		while (XML_GetKeyValue(name, val))
		{
			printf("%s = \"%s\"", name, val);
		}
		once = 1;
	}
}

forward RXML_Spawn();
public RXML_Spawn()
{
	static
		once;
	if (!once)
	{
		new
			name[MAX_XML_ENTRY_NAME],
			val[MAX_XML_ENTRY_TEXT];
		printf("spawn");
		while (XML_GetKeyValue(name, val))
		{
			printf("%s = \"%s\"", name, val);
		}
		once = 1;
	}
}

forward RXML_Check();
public RXML_Check()
{
	static
		once;
	if (!once)
	{
		new
			name[MAX_XML_ENTRY_NAME],
			val[MAX_XML_ENTRY_TEXT];
		printf("checkpoint");
		while (XML_GetKeyValue(name, val))
		{
			printf("%s = \"%s\"", name, val);
		}
		once = 1;
	}
}

forward update();
public update()
{
	static last;
	new time = GetTickCount();
	if (last)
	{
		printf("time: %d", time - last);
	}
	last = time;
}*/

Script_OnGameModeExit()
{
	return 1;
}

Script_OnPlayerConnect(playerid)
{
	GivePlayerMoney(playerid, 10000);
	Group_AddPlayer(gGroup, playerid);
	Race_PlayerJoin(playerid, gRace);
	TD_ShowForPlayer(playerid, gTextTest);
	static
		woo = 0;
	if (!woo)
	{
		SetTimerEx("startrace", 60000, 0, "i", playerid);
		woo = 1;
	}
	printf("connect %d", playerid);
	
	new
		Float:x,
		Float:y,
		Float:z,
		Float:xoff = 10.0,
		Float:yoff = 20.0,
		Float:zoff = 30.0,
		Float:dist = 3.0,
		tick0,
		tick1,
		tick2,
		tick3,
		tick4,
		tick5,
		tick6;
		
	tick0 = GetTickCount();
	
	for (new i = 0; i < 100000; i++)
	{
		if (IsPlayerInRangeOfPoint(playerid, dist, xoff, yoff, zoff)) {}
	}
	
	tick1 = GetTickCount();
	
	for (new i = 0; i < 100000; i++)
	{
		GetPlayerPos(playerid, x, y, z);
		x -= xoff;
		y -= yoff;
		z -= zoff;
		if ((x * x) + (y * y) + (z * z) <= (dist * dist)) {}
	}
	
	tick2 = GetTickCount();
	
	GetPlayerPos(playerid, x, y, z);
	new
		Float:dsq0 = dist * dist;
	for (new i = 0; i < 100000; i++)
	{
		new
			Float:x2 = x - xoff,
			Float:y2 = y - yoff,
			Float:z2 = z - zoff;
		if ((x2 * x2) + (y2 * y2) + (z2 * z2) <= dsq0) {}
	}
	
	tick3 = GetTickCount();
	
	GetPlayerPos(playerid, x, y, z);
	new
		Float:x2,
		Float:y2,
		Float:z2,
		Float:dsq1 = dist * dist;
	for (new i = 0; i < 100000; i++)
	{
		x2 = x - xoff;
		y2 = y - yoff;
		z2 = z - zoff;
		if ((x2 * x2) + (y2 * y2) + (z2 * z2) <= dsq1) {}
	}
	
	tick4 = GetTickCount();
	
	new
		Float:dsq2 = dist * dist;
	for (new i = 0; i < 100000; i++)
	{
		GetPlayerPos(playerid, x, y, z);
		if (((x - xoff) * (x - xoff)) + ((y - yoff) * (y - yoff)) + ((z - zoff) * (z - zoff)) <= dsq2) {}
	}
	
	tick5 = GetTickCount();
	
	GetPlayerPos(playerid, x, y, z);
	new
		Float:dsq3 = dist * dist;
	for (new i = 0; i < 100000; i++)
	{
		if (((x - xoff) * (x - xoff)) + ((y - yoff) * (y - yoff)) + ((z - zoff) * (z - zoff)) <= dsq3) {}
	}

	tick6 = GetTickCount();
	
	printf("time 0: %d", tick1 - tick0);
	printf("time 1: %d", tick2 - tick1);
	printf("time 2: %d", tick3 - tick2);
	printf("time 3: %d", tick4 - tick3);
	printf("time 4: %d", tick5 - tick4);
	printf("time 5: %d", tick6 - tick5);

//	xOnPlayerConnect(playerid);

	return 1;
}

forward startrace(playerid);
public startrace(playerid)
{
	printf("called %d", gRace);
	//printf("%d", Race_Start(gRace));
	Group_AddPlayer(gObjectGroup, playerid);
}

Script_OnPlayerRequestClass	(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerFacingAngle(playerid, 90.0);
	SetPlayerCameraPos(playerid, 1955.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public LoginDat_YSI_LVDM_LG(playerid, identifier[], text[])
{
	if (!strcmp(identifier, "health")) SetPlayerHealth(playerid, floatstr(text));
	else if (!strcmp(identifier, "armour")) SetPlayerArmour(playerid, floatstr(text));
	else if (!strcmp(identifier, "money"))
	{
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid, strval(text));
	}
	Property_LoadWeapons(playerid, identifier, text);
	Property_LoadBank(playerid, identifier, text);
}

Script_OnPlayerLogout(playerid, yid)
{
	Player_SetTag("YSI_LVDM_LG");
	new
		Float:health;
	GetPlayerHealth(playerid, health);
	printf("health = %.2f", health);
	Player_WriteFloat("health", health);
	printf("health = %.2f", health);
	GetPlayerArmour(playerid, health);
	Player_WriteFloat("armour", health);
	Player_WriteInt("money", GetPlayerMoney(playerid));
	Property_SaveWeapons(playerid);
	Property_SaveBank(playerid);
	return 1;
}

Script_OnPlayerDisconnect(playerid, reason)
{
	new
		Float:health;
	GetPlayerHealth(playerid, health);
	printf("opdc health: %.f", health);

//	xOnPlayerDisconnect(playerid);

	#pragma unused reason

	return 1;
}

Script_OnPlayerSpawn(playerid)
{
//	SetPlayerInterior(playerid, 1);
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerFacingAngle(playerid, 357.6);

//	xOnPlayerSpawn(playerid);

	return 1;
}

// Put down here so it's out the way of the main chunk of code.
// Taken from the original LVDM-LG by Sintax, based on LVDM-MG
// by jax

AddVehiclesAndClasses()
{
	Class_Add(280, 1958.3783, 1343.1572, 15.3746, 270.1425, 22, 100, 24, 300, -1, -1);
	Class_Add(281, 1958.3783, 1343.1572, 15.3746, 270.1425, 23, 100, 28, 300, -1, -1);
//	Group_SetDefaultClass(1, 0);
//	Group_SetClass(gGroup, 1, 1);
	Class_Add(282, 1958.3783, 1343.1572, 15.3746, 270.1425, 25, 50, 29, 300,-1, -1);
//	Group_SetDefaultClass(2, 0);
//	Group_SetClass(gGroup, 2, 1);
	Class_Add(283, 1958.3783, 1343.1572, 15.3746, 269.1425, 27, 80, 24, 300,-1, -1);
//	Group_SetDefaultClass(3, 0);
//	Group_SetClass(gGroup, 3, 1);
	Class_Add(283, 1958.3783, 1343.1572, 15.3746, 269.1425, 27, 80, 24, 300, -1, -1);
	Class_Add(284, 1958.3783, 1343.1572, 15.3746, 269.1425, 3, 0, 24, 300, -1, -1);
//	Group_SetDefaultClass(4, 0);
	Class_Add(285, 1958.3783, 1343.1572, 15.3746, 269.1425, 29, 300, 24, 300, -1, -1);
//	Group_SetDefaultClass(5, 0);
	Class_Add(286, 1958.3783, 1343.1572, 15.3746, 269.1425, 29, 300, 24, 300, 0, 0);
//	Group_SetDefaultClass(6, 0);
	Class_Add(287, 1958.3783, 1343.1572, 15.3746, 269.1425, 4, 0, 24, 300, -1, -1);
//	Group_SetDefaultClass(7, 0);

	printf("adding");

	Class_Add(254, 1958.3783, 1343.1572, 15.3746,269.1425,30, 110,24,300,-1,-1);
	Class_Add(255, 1958.3783, 1343.1572, 15.3746,269.1425,28,200,24,300,-1,-1);
	Class_Add(256, 1958.3783, 1343.1572, 15.3746,269.1425,23,70,24,300,-1,-1);
	Class_Add(257, 1958.3783, 1343.1572, 15.3746,269.1425,22,80,24,300,-1,-1);
	Class_Add(258, 1958.3783, 1343.1572, 15.3746,269.1425,31, 140,24,300,-1,-1);
	Class_Add(259, 1958.3783, 1343.1572, 15.3746,269.1425,26,80,24,300,-1,-1);
	Class_Add(260, 1958.3783, 1343.1572, 15.3746,269.1425,6,0,24,300,-1,-1);
	Class_Add(261, 1958.3783, 1343.1572, 15.3746,269.1425,2,0,24,300,-1,-1);
	Class_Add(262, 1958.3783, 1343.1572, 15.3746,269.1425,29,250,24,300,-1,-1);
	Class_Add(263, 1958.3783, 1343.1572, 15.3746,269.1425, 15,0,24,300,-1,-1);
	Class_Add(264, 1958.3783, 1343.1572, 15.3746,269.1425,32,300,24,300,-1,-1);
	Class_Add(274, 1958.3783, 1343.1572, 15.3746,269.1425,22,80,24,300,-1,-1);
	Class_Add(275, 1958.3783, 1343.1572, 15.3746,269.1425,22,80,24,300,-1,-1);
	Class_Add(276, 1958.3783, 1343.1572, 15.3746,269.1425,22,70,24,300,-1,-1);

	Class_Add(1, 1958.3783, 1343.1572, 15.3746,269.1425,22,0,24,300,-1,-1);
	Class_Add(2, 1958.3783, 1343.1572, 15.3746,269.1425,28,90,24,300,-1,-1);
	Class_Add(290, 1958.3783, 1343.1572, 15.3746,269.1425,26,70,24,300,-1,-1);
	Class_Add(291, 1958.3783, 1343.1572, 15.3746,269.1425,2,0,24,300,-1,-1);
	Class_Add(292, 1958.3783, 1343.1572, 15.3746,269.1425,30,200,24,300,-1,-1);
	Class_Add(293, 1958.3783, 1343.1572, 15.3746,269.1425,32,400,24,300,-1,-1);
	Class_Add(294, 1958.3783, 1343.1572, 15.3746,269.1425,30, 110,24,300,-1,-1);
	Class_Add(295, 1958.3783, 1343.1572, 15.3746,269.1425,7,0,24,300,-1,-1);
	Class_Add(296, 1958.3783, 1343.1572, 15.3746,269.1425,25,70,24,300,-1,-1);
	Class_Add(297, 1958.3783, 1343.1572, 15.3746,269.1425, 15,0,24,300,-1,-1);
	Class_Add(298, 1958.3783, 1343.1572, 15.3746,269.1425,23,70,24,300,-1,-1);
	Class_Add(299, 1958.3783, 1343.1572, 15.3746,269.1425,31, 110,24,300,-1,-1);

	Class_Add(277, 1958.3783, 1343.1572, 15.3746,269.1425,42,800,24,300,-1,-1);
	Class_Add(278, 1958.3783, 1343.1572, 15.3746,269.1425,42,500,24,300,-1,-1);
	Class_Add(279, 1958.3783, 1343.1572, 15.3746,269.1425,42,500,24,300,-1,-1);
	Class_Add(288, 1958.3783, 1343.1572, 15.3746,269.1425,22, 110,24,300,-1,-1);
	Class_Add(47, 1958.3783, 1343.1572, 15.3746,269.1425,43,0,24,300,-1,-1);
	Class_Add(48, 1958.3783, 1343.1572, 15.3746,269.1425,5,0,24,300,-1,-1);
	Class_Add(49, 1958.3783, 1343.1572, 15.3746,269.1425,7,0,24,300,-1,-1);
	Class_Add(50, 1958.3783, 1343.1572, 15.3746,269.1425,6,0,24,300,-1,-1);
	Class_Add(51, 1958.3783, 1343.1572, 15.3746,269.1425,27,50,24,300,-1,-1);
	Class_Add(52, 1958.3783, 1343.1572, 15.3746,269.1425,26,50,24,300,-1,-1);
	Class_Add(53, 1958.3783, 1343.1572, 15.3746,269.1425,6,0,24,300,-1,-1);
	Class_Add(54, 1958.3783, 1343.1572, 15.3746,269.1425,23,70,24,300,-1,-1);
	Class_Add(55, 1958.3783, 1343.1572, 15.3746,269.1425,32,230,24,300,-1,-1);
	Class_Add(56, 1958.3783, 1343.1572, 15.3746,269.1425,7,0,24,300,-1,-1);
	Class_Add(57, 1958.3783, 1343.1572, 15.3746,269.1425,32,90,24,300,-1,-1);
	Class_Add(58, 1958.3783, 1343.1572, 15.3746,269.1425,27,50,24,300,-1,-1);
	Class_Add(59, 1958.3783, 1343.1572, 15.3746,269.1425,30, 120,24,300,-1,-1);
	Class_Add(60, 1958.3783, 1343.1572, 15.3746,269.1425,2,0,24,300,-1,-1);
	Class_Add(61, 1958.3783, 1343.1572, 15.3746,269.1425,23, 100,24,300,-1,-1);
	Class_Add(62, 1958.3783, 1343.1572, 15.3746,269.1425,5,0,24,300,-1,-1);
	Class_Add(63, 1958.3783, 1343.1572, 15.3746,269.1425,22,50,24,300,-1,-1);
	Class_Add(64, 1958.3783, 1343.1572, 15.3746,269.1425,28,80,24,300,-1,-1);
	Class_Add(66, 1958.3783, 1343.1572, 15.3746,269.1425,5,0,24,300,-1,-1);
	Class_Add(67, 1958.3783, 1343.1572, 15.3746,269.1425,29,90,24,300,-1,-1);
	Class_Add(68, 1958.3783, 1343.1572, 15.3746,269.1425,30,70,24,300,-1,-1);
	Class_Add(69, 1958.3783, 1343.1572, 15.3746,269.1425,27,80,24,300,-1,-1);
	Class_Add(70, 1958.3783, 1343.1572, 15.3746,269.1425,22,80,24,300,-1,-1);
	Class_Add(71, 1958.3783, 1343.1572, 15.3746,269.1425,29,90,24,300,-1,-1);
	Class_Add(72, 1958.3783, 1343.1572, 15.3746,269.1425,26,50,24,300,-1,-1);
	Class_Add(73, 1958.3783, 1343.1572, 15.3746,269.1425,31,60,24,300,-1,-1);
	Class_Add(75, 1958.3783, 1343.1572, 15.3746,269.1425,23,40,24,300,-1,-1);
	Class_Add(76, 1958.3783, 1343.1572, 15.3746,269.1425,32,210,24,300,-1,-1);
	Class_Add(78, 1958.3783, 1343.1572, 15.3746,269.1425,31, 120,24,300,-1,-1);
	Class_Add(79, 1958.3783, 1343.1572, 15.3746,269.1425, 15,0,24,300,-1,-1);
	Class_Add(80, 1958.3783, 1343.1572, 15.3746,269.1425,4,0,24,300,-1,-1);
	Class_Add(81, 1958.3783, 1343.1572, 15.3746,269.1425,4,0,24,300,-1,-1);
	Class_Add(82, 1958.3783, 1343.1572, 15.3746,269.1425,28,230,24,300,-1,-1);
	Class_Add(83, 1958.3783, 1343.1572, 15.3746,269.1425,32, 110,24,300,-1,-1);
	Class_Add(84, 1958.3783, 1343.1572, 15.3746,269.1425,31, 110,24,300,-1,-1);
	Class_Add(85, 1958.3783, 1343.1572, 15.3746,269.1425,22,60,24,300,-1,-1);
	Class_Add(87, 1958.3783, 1343.1572, 15.3746,269.1425,23,70,24,300,-1,-1);
	Class_Add(88, 1958.3783, 1343.1572, 15.3746,269.1425,22,80,24,300,-1,-1);
	Class_Add(89, 1958.3783, 1343.1572, 15.3746,269.1425,5,0,24,300,-1,-1);
	Class_Add(91, 1958.3783, 1343.1572, 15.3746,269.1425,26,90,24,300,-1,-1);
	Class_Add(92, 1958.3783, 1343.1572, 15.3746,269.1425,7,0,24,300,-1,-1);
	Class_Add(93, 1958.3783, 1343.1572, 15.3746,269.1425,29,300,24,300,-1,-1);
	Class_Add(95, 1958.3783, 1343.1572, 15.3746,269.1425,23, 170,24,300,-1,-1);
	Class_Add(96, 1958.3783, 1343.1572, 15.3746,269.1425,5,0,24,300,-1,-1);
	Class_Add(97, 1958.3783, 1343.1572, 15.3746,269.1425,4,0,24,300,-1,-1);
	Class_Add(98, 1958.3783, 1343.1572, 15.3746,269.1425,30,90,24,300,-1,-1);
	Class_Add(99, 1958.3783, 1343.1572, 15.3746,269.1425,26,60,24,300,-1,-1);
	Class_Add(100, 1958.3783, 1343.1572, 15.3746,269.1425,32,90,24,300,-1,-1);
	Class_Add(101, 1958.3783, 1343.1572, 15.3746,269.1425,26,80,24,300,-1,-1);
	Class_Add(102, 1958.3783, 1343.1572, 15.3746,269.1425,25,50,24,300,-1,-1);
	Class_Add(103, 1958.3783, 1343.1572, 15.3746,269.1425,32,90,24,300,-1,-1);
	Class_Add(104, 1958.3783, 1343.1572, 15.3746,269.1425,32,90,24,300,-1,-1);
	Class_Add(105, 1958.3783, 1343.1572, 15.3746,269.1425,32,90,24,300,-1,-1);
	Class_Add(106, 1958.3783, 1343.1572, 15.3746,269.1425,32,90,24,300,-1,-1);
	Class_Add(107, 1958.3783, 1343.1572, 15.3746,269.1425,32,90,24,300,-1,-1);
	Class_Add(108, 1958.3783, 1343.1572, 15.3746,269.1425,32,90,24,300,-1,-1);
	Class_Add(109, 1958.3783, 1343.1572, 15.3746,269.1425,32,90,24,300,-1,-1);
	Class_Add(110, 1958.3783, 1343.1572, 15.3746,269.1425,27,50,24,300,-1,-1);
	Class_Add(111, 1958.3783, 1343.1572, 15.3746,269.1425,22,80,24,300,-1,-1);
	Class_Add(112, 1958.3783, 1343.1572, 15.3746,269.1425,25,60,24,300,-1,-1);
	Class_Add(113, 1958.3783, 1343.1572, 15.3746,269.1425,28,90,24,300,-1,-1);
	Class_Add(114, 1958.3783, 1343.1572, 15.3746,269.1425,28,90,24,300,-1,-1);
	Class_Add(115, 1958.3783, 1343.1572, 15.3746,269.1425,28,90,24,300,-1,-1);
	Class_Add(116, 1958.3783, 1343.1572, 15.3746,269.1425,28,90,24,300,-1,-1);
	Class_Add(117, 1958.3783, 1343.1572, 15.3746,269.1425,28,90,24,300,-1,-1);
	Class_Add(118, 1958.3783, 1343.1572, 15.3746,269.1425,28,90,24,300,-1,-1);
	Class_Add(120, 1958.3783, 1343.1572, 15.3746,269.1425,28,90,24,300,-1,-1);
	Class_Add(121, 1958.3783, 1343.1572, 15.3746,269.1425,31,90,24,300,-1,-1);
	Class_Add(122, 1958.3783, 1343.1572, 15.3746,269.1425,30, 110,24,300,-1,-1);
	Class_Add(123, 1958.3783, 1343.1572, 15.3746,269.1425,7,0,24,300,-1,-1);
	Class_Add(124, 1958.3783, 1343.1572, 15.3746,269.1425,26,30,24,300,-1,-1);
	Class_Add(125, 1958.3783, 1343.1572, 15.3746,269.1425,3,0,24,300,-1,-1);
	Class_Add(126, 1958.3783, 1343.1572, 15.3746,269.1425,6,0,24,300,-1,-1);
	Class_Add(127, 1958.3783, 1343.1572, 15.3746,269.1425,27,80,24,300,-1,-1);
	Class_Add(128, 1958.3783, 1343.1572, 15.3746,269.1425,41,500,24,300,-1,-1);
	Class_Add(129, 1958.3783, 1343.1572, 15.3746,269.1425,46,0,24,300,-1,-1);
	Class_Add(131, 1958.3783, 1343.1572, 15.3746,269.1425,23, 110,24,300,-1,-1);
	Class_Add(133, 1958.3783, 1343.1572, 15.3746,269.1425,2,0,24,300,-1,-1);
	Class_Add(134, 1958.3783, 1343.1572, 15.3746,269.1425,5,0,24,300,-1,-1);
	Class_Add(135, 1958.3783, 1343.1572, 15.3746,269.1425,29,80,24,300,-1,-1);
	Class_Add(136, 1958.3783, 1343.1572, 15.3746,269.1425,23,70,24,300,-1,-1);
	Class_Add(137, 1958.3783, 1343.1572, 15.3746,269.1425,32,280,24,300,-1,-1);
	Class_Add(138, 1958.3783, 1343.1572, 15.3746,269.1425,4,0,24,300,-1,-1);
	Class_Add(139, 1958.3783, 1343.1572, 15.3746,269.1425,5,0,24,300,-1,-1);
	Class_Add(140, 1958.3783, 1343.1572, 15.3746,269.1425,27,80,24,300,-1,-1);
	Class_Add(141, 1958.3783, 1343.1572, 15.3746,269.1425,25,50,24,300,-1,-1);
	Class_Add(142, 1958.3783, 1343.1572, 15.3746,269.1425,41,550,24,300,-1,-1);
	Class_Add(143, 1958.3783, 1343.1572, 15.3746,269.1425,41,510,24,300,-1,-1);
	Class_Add(144, 1958.3783, 1343.1572, 15.3746,269.1425,27, 110,24,300,-1,-1);
	Class_Add(145, 1958.3783, 1343.1572, 15.3746,269.1425,22,40,24,300,-1,-1);
	Class_Add(146, 1958.3783, 1343.1572, 15.3746,269.1425,23,80,24,300,-1,-1);
	Class_Add(147, 1958.3783, 1343.1572, 15.3746,269.1425,31,90,24,300,-1,-1);
	Class_Add(148, 1958.3783, 1343.1572, 15.3746,269.1425,7,0,24,300,-1,-1);
	Class_Add(150, 1958.3783, 1343.1572, 15.3746,269.1425,26,70,24,300,-1,-1);
	Class_Add(151, 1958.3783, 1343.1572, 15.3746,269.1425,43,0,24,300,-1,-1);
	Class_Add(152, 1958.3783, 1343.1572, 15.3746,269.1425,22,30,24,300,-1,-1);
	Class_Add(153, 1958.3783, 1343.1572, 15.3746,269.1425,2,0,24,300,-1,-1);
	Class_Add(154, 1958.3783, 1343.1572, 15.3746,269.1425,25,70,24,300,-1,-1);
	Class_Add(155, 1958.3783, 1343.1572, 15.3746,269.1425,25,90,24,300,-1,-1);
	Class_Add(156, 1958.3783, 1343.1572, 15.3746,269.1425,22,60,24,300,-1,-1);
	Class_Add(157, 1958.3783, 1343.1572, 15.3746,269.1425,5,0,24,300,-1,-1);
	Class_Add(158, 1958.3783, 1343.1572, 15.3746,269.1425,6,0,24,300,-1,-1);
	Class_Add(159, 1958.3783, 1343.1572, 15.3746,269.1425,7,0,24,300,-1,-1);
	Class_Add(160, 1958.3783, 1343.1572, 15.3746,269.1425,32,90,24,300,-1,-1);
	Class_Add(161, 1958.3783, 1343.1572, 15.3746,269.1425,23,60,24,300,-1,-1);
	Class_Add(162, 1958.3783, 1343.1572, 15.3746,269.1425,23,70,24,300,-1,-1);
	Class_Add(163, 1958.3783, 1343.1572, 15.3746,269.1425,29, 150,24,300,-1,-1);
	Class_Add(164, 1958.3783, 1343.1572, 15.3746,269.1425,29,210,24,300,-1,-1);
	Class_Add(165, 1958.3783, 1343.1572, 15.3746,269.1425,31, 110,24,300,-1,-1);
	Class_Add(166, 1958.3783, 1343.1572, 15.3746,269.1425,41,510,24,300,-1,-1);
	Class_Add(167, 1958.3783, 1343.1572, 15.3746,269.1425,25,80,24,300,-1,-1);
	Class_Add(168, 1958.3783, 1343.1572, 15.3746,269.1425,32,80,24,300,-1,-1);
	Class_Add(169, 1958.3783, 1343.1572, 15.3746,269.1425,32, 170,24,300,-1,-1);
	Class_Add(170, 1958.3783, 1343.1572, 15.3746,269.1425,22,70,24,300,-1,-1);
	Class_Add(171, 1958.3783, 1343.1572, 15.3746,269.1425,5,0,24,300,-1,-1);
	Class_Add(172, 1958.3783, 1343.1572, 15.3746,269.1425,4,0,24,300,-1,-1);
	Class_Add(173, 1958.3783, 1343.1572, 15.3746,269.1425,32, 140,24,300,-1,-1);
	Class_Add(174, 1958.3783, 1343.1572, 15.3746,269.1425,32, 140,24,300,-1,-1);
	Class_Add(175, 1958.3783, 1343.1572, 15.3746,269.1425,32, 150,24,300,-1,-1);
	Class_Add(176, 1958.3783, 1343.1572, 15.3746,269.1425,30,90,24,300,-1,-1);
	Class_Add(177, 1958.3783, 1343.1572, 15.3746,269.1425,30,90,24,300,-1,-1);
	Class_Add(178, 1958.3783, 1343.1572, 15.3746,269.1425,30,60,24,300,-1,-1);
	Class_Add(179, 1958.3783, 1343.1572, 15.3746,269.1425,27,400,24,300,-1,-1);
	Class_Add(180, 1958.3783, 1343.1572, 15.3746,269.1425,3,0,24,300,-1,-1);
	Class_Add(181, 1958.3783, 1343.1572, 15.3746,269.1425,5,0,24,300,-1,-1);
	Class_Add(182, 1958.3783, 1343.1572, 15.3746,269.1425,29,90,24,300,-1,-1);
	Class_Add(183, 1958.3783, 1343.1572, 15.3746,269.1425,32, 150,24,300,-1,-1);
	Class_Add(184, 1958.3783, 1343.1572, 15.3746,269.1425,41,550,24,300,-1,-1);
	Class_Add(185, 1958.3783, 1343.1572, 15.3746,269.1425,42,420,24,300,-1,-1);
	Class_Add(186, 1958.3783, 1343.1572, 15.3746,269.1425,31, 110,24,300,-1,-1);
	Class_Add(187, 1958.3783, 1343.1572, 15.3746,269.1425,28,290,24,300,-1,-1);
	Class_Add(188, 1958.3783, 1343.1572, 15.3746,269.1425,22,90,24,300,-1,-1);
	Class_Add(189, 1958.3783, 1343.1572, 15.3746,269.1425,4,0,24,300,-1,-1);
	Class_Add(190, 1958.3783, 1343.1572, 15.3746,269.1425,32,300,24,300,-1,-1);
	Class_Add(191, 1958.3783, 1343.1572, 15.3746,269.1425,28,300,24,300,-1,-1);
	Class_Add(192, 1958.3783, 1343.1572, 15.3746,269.1425,6,0,24,300,-1,-1);
	Class_Add(193, 1958.3783, 1343.1572, 15.3746,269.1425,32,300,24,300,-1,-1);
	Class_Add(194, 1958.3783, 1343.1572, 15.3746,269.1425,4,0,24,300,-1,-1);
	Class_Add(195, 1958.3783, 1343.1572, 15.3746,269.1425,32,300,24,300,-1,-1);
	Class_Add(196, 1958.3783, 1343.1572, 15.3746,269.1425,7,0,24,300,-1,-1);
	Class_Add(197, 1958.3783, 1343.1572, 15.3746,269.1425, 15,0,24,300,-1,-1);
	Class_Add(198, 1958.3783, 1343.1572, 15.3746,269.1425,32,90,24,300,-1,-1);
	Class_Add(199, 1958.3783, 1343.1572, 15.3746,269.1425, 15,0,24,300,-1,-1);
	Class_Add(200, 1958.3783, 1343.1572, 15.3746,269.1425,29,70,24,300,-1,-1);
	Class_Add(201, 1958.3783, 1343.1572, 15.3746,269.1425,23,50,24,300,-1,-1);
	Class_Add(202, 1958.3783, 1343.1572, 15.3746,269.1425,5,0,24,300,-1,-1);
	Class_Add(203, 1958.3783, 1343.1572, 15.3746,269.1425,32,80,24,300,-1,-1);
	Class_Add(204, 1958.3783, 1343.1572, 15.3746,269.1425,28,70,24,300,-1,-1);
	Class_Add(205, 1958.3783, 1343.1572, 15.3746,269.1425,25,90,24,300,-1,-1);
	Class_Add(206, 1958.3783, 1343.1572, 15.3746,269.1425,23,80,24,300,-1,-1);
	Class_Add(207, 1958.3783, 1343.1572, 15.3746,269.1425,25,50,24,300,-1,-1);
	Class_Add(209, 1958.3783, 1343.1572, 15.3746,269.1425,4,0,24,300,-1,-1);
	Class_Add(210, 1958.3783, 1343.1572, 15.3746,269.1425,2,0,24,300,-1,-1);
	Class_Add(211, 1958.3783, 1343.1572, 15.3746,269.1425,32,300,24,300,-1,-1);
	Class_Add(212, 1958.3783, 1343.1572, 15.3746,269.1425,26,90,24,300,-1,-1);
	Class_Add(213, 1958.3783, 1343.1572, 15.3746,269.1425,7,0,24,300,-1,-1);
	Class_Add(214, 1958.3783, 1343.1572, 15.3746,269.1425,32,90,24,300,-1,-1);
	Class_Add(215, 1958.3783, 1343.1572, 15.3746,269.1425,6,0,24,300,-1,-1);
	Class_Add(216, 1958.3783, 1343.1572, 15.3746,269.1425,28,90,24,300,-1,-1);
	Class_Add(217, 1958.3783, 1343.1572, 15.3746,269.1425,22,90,24,300,-1,-1);
	Class_Add(218, 1958.3783, 1343.1572, 15.3746,269.1425,23,90,24,300,-1,-1);
	Class_Add(219, 1958.3783, 1343.1572, 15.3746,269.1425,31, 120,24,300,-1,-1);
	Class_Add(220, 1958.3783, 1343.1572, 15.3746,269.1425,2,0,24,300,-1,-1);
	Class_Add(221, 1958.3783, 1343.1572, 15.3746,269.1425,30, 140,24,300,-1,-1);
	Class_Add(222, 1958.3783, 1343.1572, 15.3746,269.1425,32, 180,24,300,-1,-1);
	Class_Add(223, 1958.3783, 1343.1572, 15.3746,269.1425,28, 160,24,300,-1,-1);
	Class_Add(224, 1958.3783, 1343.1572, 15.3746,269.1425, 15,0,24,300,-1,-1);
	Class_Add(225, 1958.3783, 1343.1572, 15.3746,269.1425,30,90,24,300,-1,-1);
	Class_Add(226, 1958.3783, 1343.1572, 15.3746,269.1425,32, 150,24,300,-1,-1);
	Class_Add(227, 1958.3783, 1343.1572, 15.3746,269.1425,23, 140,24,300,-1,-1);
	Class_Add(228, 1958.3783, 1343.1572, 15.3746,269.1425,26,50,24,300,-1,-1);
	Class_Add(229, 1958.3783, 1343.1572, 15.3746,269.1425,29, 120,24,300,-1,-1);
	Class_Add(230, 1958.3783, 1343.1572, 15.3746,269.1425,27, 120,24,300,-1,-1);
	Class_Add(231, 1958.3783, 1343.1572, 15.3746,269.1425,4,0,24,300,-1,-1);
	Class_Add(232, 1958.3783, 1343.1572, 15.3746,269.1425,26,80,24,300,-1,-1);
	Class_Add(233, 1958.3783, 1343.1572, 15.3746,269.1425,28,300,24,300,-1,-1);
	Class_Add(234, 1958.3783, 1343.1572, 15.3746,269.1425,32,260,24,300,-1,-1);
	Class_Add(235, 1958.3783, 1343.1572, 15.3746,269.1425,29, 160,24,300,-1,-1);
	Class_Add(236, 1958.3783, 1343.1572, 15.3746,269.1425,31,70,24,300,-1,-1);
	Class_Add(237, 1958.3783, 1343.1572, 15.3746,269.1425,5,0,24,300,-1,-1);
	Class_Add(238, 1958.3783, 1343.1572, 15.3746,269.1425,42,500,24,300,-1,-1);
	Class_Add(239, 1958.3783, 1343.1572, 15.3746,269.1425,25, 110,24,300,-1,-1);
	Class_Add(240, 1958.3783, 1343.1572, 15.3746,269.1425,30, 110,24,300,-1,-1);
	Class_Add(241, 1958.3783, 1343.1572, 15.3746,269.1425,26,80,24,300,-1,-1);
	Class_Add(242, 1958.3783, 1343.1572, 15.3746,269.1425,5,0,24,300,-1,-1);
	Class_Add(243, 1958.3783, 1343.1572, 15.3746,269.1425,23,50,24,300,-1,-1);
	Class_Add(244, 1958.3783, 1343.1572, 15.3746,269.1425,22,70,24,300,-1,-1);
	Class_Add(245, 1958.3783, 1343.1572, 15.3746,269.1425,25,70,24,300,-1,-1);
	Class_Add(246, 1958.3783, 1343.1572, 15.3746,269.1425,27,90,24,300,-1,-1);
	Class_Add(247, 1958.3783, 1343.1572, 15.3746,269.1425,22,50,24,300,-1,-1);
	Class_Add(248, 1958.3783, 1343.1572, 15.3746,269.1425,5,0,24,300,-1,-1);
	Class_Add(249, 1958.3783, 1343.1572, 15.3746,269.1425,32,300,24,300,-1,-1);
	Class_Add(250, 1958.3783, 1343.1572, 15.3746,269.1425,42,500,24,300,-1,-1);
	Class_Add(251, 1958.3783, 1343.1572, 15.3746,269.1425,31,90,24,300,-1,-1);
	Class_Add(253, 1958.3783, 1343.1572, 15.3746,269.1425,23,90,24,300,-1,-1);

	AddStaticVehicle(567,0.0,0.0,5.0,358.0809,-1,-1);
	AddStaticVehicle(534,2684.9407,-1987.3030, 13.2760, 177.9317,-1,-1);
	AddStaticVehicle(535,2645.2156,-1989.5094, 13.3178, 177.8134,-1,-1);
	AddStaticVehicle(522,2495.5173,-1681.2826, 12.9065,98.3472,-1,-1);
	AddStaticVehicle(522,2493.3677,-1656.4139, 12.9223,84.8550,-1,-1);
	AddStaticVehicle(522,2487.2908,-1668.5044, 12.9139,89.4881,-1,-1);
	AddStaticVehicle(420, 1703.3619,-2314.8391, 13.2410,270.3887,-1,-1);
	AddStaticVehicle(420, 1640.4957,-2313.2698, 13.3382,89.6490,-1,-1);
	AddStaticVehicle(420, 1681.7374,-2328.8745, 13.3264,357.6139,-1,-1);
	AddStaticVehicle(519, 1528.0677,-2494.7764, 14.4734,270.4083,-1,-1);
	AddStaticVehicle(519, 1995.3162,-2595.0706, 14.4689,89.8095,-1,-1);
	AddStaticVehicle(541,2785.1702,-1835.1760,9.4410,220.1585,-1,-1);
	AddStaticVehicle(437,2749.8174,-1874.4050,9.8091,269.8951,-1,-1);
	AddStaticVehicle(519,-1367.8994,-212.4551, 15.0672,324.5510,-1,-1);
	AddStaticVehicle(519,-1315.5867,-253.3602, 15.0699,307.9226,-1,-1);
	AddStaticVehicle(420,-1448.5743,-278.2330, 13.8861,60.8896,-1,-1);
	AddStaticVehicle(420,-1412.6956,-304.9417, 13.8432,38.5556,-1,-1);
	AddStaticVehicle(420,-1394.1279,-333.9436, 13.8435,200.5934,-1,-1);
	AddStaticVehicle(429,-1989.7124,248.3605,34.8515,263.4052,-1,-1);
	AddStaticVehicle(451,-1990.5541,257.2202,34.8825,265.1628,-1,-1);
	AddStaticVehicle(477,-1988.8313,263.9637,34.9355,265.5265,-1,-1);
	AddStaticVehicle(506,-1988.2429,269.8528,34.8817,265.4478,-1,-1);
	AddStaticVehicle(555,-1955.1392,302.1328,35.1524, 148.5440,-1,-1);
	AddStaticVehicle(558,-1951.1504,256.5053,35.1019,88.1892,-1,-1);
	AddStaticVehicle(559,-1949.9453,264.2937,35.1263,90.9304,-1,-1);
	AddStaticVehicle(560,-1949.7380,272.6683,35.1768,88.0860,-1,-1);
	AddStaticVehicle(561,-1955.0046,278.5646,35.2826, 131.5863,-1,-1);
	AddStaticVehicle(562,-1955.5577,279.1806,40.7068, 180.5091,-1,-1);
	AddStaticVehicle(603,-1954.2593,257.6462,40.8853,267.2120,-1,-1);
	AddStaticVehicle(415,-1954.7677,263.6075,40.8178,270.6389,-1,-1);
	AddStaticVehicle(439,-754.6018,732.2065, 18.0458, 146.7540,-1,-19);
	AddStaticVehicle(460,-705.2302,662.9296, 1.5221,335.2189,-1,-1);
	AddStaticVehicle(460,-1472.1603,689.0020, 1.8034, 179.9899,-1,-1);
	AddStaticVehicle(460,2355.7551,515.4268, 1.5751,270.7536,-1,-1);
	AddStaticVehicle(556, 1616.2231, 1159.6940, 14.5973,0.0975,0, 1);
	AddStaticVehicle(556, 1610.1365, 1159.4200, 14.5946,2.0360,0, 1);
	AddStaticVehicle(476, 1279.2549, 1323.8820, 11.5242,270.7893,-1,-1);
	AddStaticVehicle(476, 1280.2168, 1362.1967, 11.5312,267.7886,-1,-1);
	AddStaticVehicle(593, 1283.9746, 1446.7965, 11.2676,274.2811,3, 1);
	AddStaticVehicle(593,-1253.4105,-38.6363, 14.6021, 139.2312,3, 1);
	AddStaticVehicle(593, 1284.2164, 1390.5103, 11.2840,265.3953,3, 1);
	AddStaticVehicle(593, 1282.8966, 1418.0044, 11.2841,269.8405,3, 1);
	AddStaticVehicle(487, 1650.2764, 1540.3087, 10.9346,6.0940,-1,-1);
	AddStaticVehicle(487, 1615.9307, 1540.7300, 10.9498,353.7724,-1,-1);
	AddStaticVehicle(487, 1620.2600, 1636.7080, 11.1960,88.3206,-1,-1);
	AddStaticVehicle(487,2094.2058,2414.5586,74.7559, 180.9587,-1,-1);
	AddStaticVehicle(521,-209.4623,2655.9817,62.1768, 183.7314,-1,-1);
	AddStaticVehicle(522,-214.0044,2655.9419,62.1697, 179.0205,-1,-1);
	AddStaticVehicle(568,-234.0206,2652.2092,62.5889,92.2438,-1,-1);
	AddStaticVehicle(463,-220.1987,2657.4753,62.1420, 165.3373,-1,-1);
	AddStaticVehicle(523,-216.8139,2657.9468,62.1719, 169.6829,-1,-1);
	AddStaticVehicle(468,-204.2156,2655.4185,62.3600, 170.5763,-1,-1);
	AddStaticVehicle(519,-67.6876,2504.5742, 17.4062,270.9824,0,0);
	AddStaticVehicle(487,364.2997,2538.6543, 16.8355,350.3344,0,0);
	AddStaticVehicle(476,327.0665,2538.4600, 17.5200, 176.5708,-1,-1);
	AddStaticVehicle(476,291.2311,2539.9155, 17.5230, 176.7857,-1,-1);
	AddStaticVehicle(568,385.5122,2600.1575, 16.3516, 194.7182,-1,-1);
	AddStaticVehicle(468,414.9343,2532.8972, 16.2462,89.4582,-1,-1);
	AddStaticVehicle(468,-395.4510,2237.7324,42.0988,274.9872,-1,-1);
	AddStaticVehicle(468,-376.3357,2253.2776,42.1495, 101.1794,-1,-1);
	AddStaticVehicle(568,-341.8517,2216.9778,42.3493, 111.6789,-1,-1);
	AddStaticVehicle(476,275.4320, 1992.3684, 18.3702,258.2607,-1,-1);
	AddStaticVehicle(470,276.7374,2011.9894, 17.6304,301.9034,-1,-1);
	AddStaticVehicle(470,273.0994,2020.2407, 17.6330,270.6756,-1,-1);
	AddStaticVehicle(470,270.9696,2030.3834, 17.6326,271.4763,-1,-1);
	AddStaticVehicle(470,280.9707,2034.7118, 17.6301,227.4448,-1,-1);
	AddStaticVehicle(568,277.9895, 1950.1472, 17.5059, 180.4979,-1,-1);
	AddStaticVehicle(568,277.3102, 1962.1044, 17.5065,3.6751,-1,-1);
	AddStaticVehicle(468,276.7101, 1956.4747, 17.3095,274.5107,-1,-1);
	AddStaticVehicle(523,2291.7573,2477.1064, 10.3861, 179.9268,-1,-1);
	AddStaticVehicle(523,2290.7751,2443.6565, 10.3907,359.5579,-1,-1);
	AddStaticVehicle(523,2251.8347,2475.5486, 10.3907, 178.6270,-1,-1);
	AddStaticVehicle(523,2252.1116,2442.7649, 10.3907,0.4598,-1,-1);
	AddStaticVehicle(598,2260.1001,2476.4653, 10.5672, 180.6902,79, 1);
	AddStaticVehicle(598,2260.7979,2444.2346, 10.5672,358.2803,79, 1);
	AddStaticVehicle(598,2281.8987,2476.4758, 10.5662, 181.1460,79, 1);
	AddStaticVehicle(598,2282.1924,2443.6807, 10.5699,0.3977,79, 1);
	AddStaticVehicle(598,2270.9355,2476.4426, 10.5669, 180.4777,79, 1);
	AddStaticVehicle(598,2271.4871,2443.6672, 10.5662,0.9362,79, 1);
	AddStaticVehicle(420, 1697.2590, 1448.6200, 10.5537,266.4467,-1,-1);
	AddStaticVehicle(420, 1720.7908, 1368.1310, 10.3471, 196.4742,-1,-1);
	AddStaticVehicle(420, 1732.2589, 1487.0281, 10.5962,340.3221,-1,-1);
	AddStaticVehicle(409,2034.6833, 1007.4178, 10.6220, 180.1372,-1,-1);
	AddStaticVehicle(409,2233.9114, 1287.9066, 10.6203,359.2765,-1,-1);
	AddStaticVehicle(409,2158.1938, 1683.4812, 10.4947,3.6679,-1,-1);
	AddStaticVehicle(409,2219.4500, 1840.5797, 10.6203,2.7264,-1,-1);
	AddStaticVehicle(409,2034.9967, 1909.1608, 11.9769, 183.6987,-1,-1);
	AddStaticVehicle(411,2035.5375, 1926.8351, 11.9022,359.2220,-1,-1);
	AddStaticVehicle(411,2170.9829, 1985.2930, 10.5474,89.9958,-1,-1);
	AddStaticVehicle(411,2075.8914, 1479.3450, 10.3990,358.2139,-1,-1);
	AddStaticVehicle(411,2394.1746,992.4088, 10.5474,92.3904,-1,-1);
	AddStaticVehicle(411,2309.8704,697.5997, 11.0024,359.1182,-1,-1);
	AddStaticVehicle(411, 1961.1719,2755.5293, 10.5474, 181.2390,-1,-1);
	AddStaticVehicle(411, 1557.4860,2770.0322, 10.5545,91.1832,-1,-1);
	AddStaticVehicle(415, 1432.6262,2608.3640, 10.4438,87.1320,-1,-1);
	AddStaticVehicle(415,2388.5510,2798.3081, 10.5917,357.2150,-1,-1);
	AddStaticVehicle(415,2790.1040,2432.8987, 10.5912, 130.3719,-1,-1);
	AddStaticVehicle(415,2611.5659,2254.2090, 10.5841,89.0531,-1,-1);
	AddStaticVehicle(415,2546.2266, 1967.9058, 10.5912,270.4711,-1,-1);
	AddStaticVehicle(429,2602.0159, 1846.5400, 10.5000,86.5979,-1,-1);
	AddStaticVehicle(429,2408.4604, 1658.3098, 10.5000, 181.3082,-1,-1);
	AddStaticVehicle(429,2489.9014, 1407.5928, 10.5000, 179.3343,-1,-1);
	AddStaticVehicle(429,2216.9131,2048.7803, 10.5000,268.0716,-1,-1);
	AddStaticVehicle(429,2305.0005, 1999.0576, 15.0261, 181.1305,-1,-1);
	AddStaticVehicle(429,2039.2996, 1313.8453, 10.3516, 180.0220,-1,-1);
	AddStaticVehicle(451,2039.7227, 1492.4209, 10.3783, 181.5667,-1,-1);
	AddStaticVehicle(451, 1889.5677, 1763.8098, 10.3312, 179.4469,-1,-1);
	AddStaticVehicle(451,2127.8789,2372.6345, 10.5267, 178.0685,-1,-1);
	AddStaticVehicle(451,2260.5010,2775.1370, 10.5268,90.2241,-1,-1);
	AddStaticVehicle(521,2351.3069, 1444.4956, 10.3938,87.1000,-1,-1);
	AddStaticVehicle(521, 1957.8842,950.6057, 10.3908, 183.8631,-1,-1);
	AddStaticVehicle(521, 1624.8635,2604.4902, 10.3901,2.3726,-1,-1);
	AddStaticVehicle(522,983.1909,2307.1055, 11.0317,271.0819,-1,-1);
	AddStaticVehicle(522,982.4152, 1994.2671, 11.0317,267.7906,-1,-1);
	AddStaticVehicle(522,928.5319, 1808.2759,8.2192,320.8226,-1,-1);
	AddStaticVehicle(522, 1020.8854, 1869.5978, 10.6927,94.5098,-1,-1);
	AddStaticVehicle(522,652.8371, 1715.3004,6.5660,41.8192,-1,-1);
	AddStaticVehicle(522,659.6678, 1720.2037,6.5619,44.8019,-1,-1);
	AddStaticVehicle(522,2157.1641,2220.4351, 10.3850, 181.4290,-1,-1);
	AddStaticVehicle(522,2133.4922, 1025.4205, 10.3927,85.3179,-1,-1);
	AddStaticVehicle(522,2301.3276, 1497.6027, 10.3969,270.3719,-1,-1);
	AddStaticVehicle(462,2061.5906,2239.0093,9.8616,87.8918,-1,-1);
	AddStaticVehicle(462, 1854.0219,2084.8164, 10.4094, 173.1228,-1,-1);
	AddStaticVehicle(462, 1165.9135,2083.5212, 10.4199, 181.7827,-1,-1);
	AddStaticVehicle(462,2440.6782, 1991.6599, 10.4193,353.6348,-1,-1);
	AddStaticVehicle(463,2142.3022,2814.2488, 10.3566,270.2944,-1,-1);
	AddStaticVehicle(463, 1307.0981,2524.1697, 10.3607,88.6812,-1,-1);
	AddStaticVehicle(463, 1396.8243,2273.0427, 10.3607,264.0532,-1,-1);
	AddStaticVehicle(463,2183.2686,2514.6428, 10.3607,55.3155,-1,-1);
	AddStaticVehicle(555,2005.8937,2488.1577, 10.5041,266.9313,-1,-1);
	AddStaticVehicle(555, 1280.9906,2548.4009, 10.5047,281.4731,-1,-1);
	AddStaticVehicle(555, 1541.3248,2203.6545, 10.5045,356.5509,-1,-1);
	AddStaticVehicle(555,2102.7778,2076.1084, 10.5049,269.2584,-1,-1);
	AddStaticVehicle(555, 1944.3433, 1343.2035,8.7933,0.8824,-1,-1);
	AddStaticVehicle(603, 1892.6672, 1592.1735, 10.5063, 182.2317,-1,-1);
	AddStaticVehicle(603, 1685.8708, 1747.9069, 10.6634,268.8167,-1,-1);
	AddStaticVehicle(603, 1367.5848, 1939.4111, 11.2746,270.7101,-1,-1);
	AddStaticVehicle(603, 1109.4929, 1732.8540, 10.6585,91.2455,-1,-1);
	AddStaticVehicle(405,2075.3745, 1389.4655, 10.5467, 180.6890,-1,-1);
	AddStaticVehicle(405,2132.7136, 1139.9778, 13.3864,62.7779,-1,-1);
	AddStaticVehicle(405,2171.7688, 1016.1721, 10.6953,270.6725,-1,-1);
	AddStaticVehicle(405,2562.5894, 1036.6371, 10.6875,359.7820,-1,-1);
	AddStaticVehicle(405,2485.5010, 1536.0773, 10.5922,31.4244,-1,-1);
	AddStaticVehicle(439,2315.9836, 1798.2666, 10.7158, 181.2612,-1,-1);
	AddStaticVehicle(439,2074.7744, 1141.7489, 10.5678, 176.6577,-1,-1);
	AddStaticVehicle(439, 1867.0037, 1179.3020, 10.7316,0.9594,-1,-1);
	AddStaticVehicle(534, 1641.5627, 1311.2130, 10.5433,269.8838,-1,-1);
	AddStaticVehicle(534, 1478.3353,723.7643, 10.5450,86.4371,-1,-1);
	AddStaticVehicle(534, 1402.1592, 1094.0211, 10.5451,4.2392,-1,-1);
	AddStaticVehicle(534,2005.0134,659.3234, 10.8617,358.4594,-1,-1);
	AddStaticVehicle(535,2039.3005, 1552.2164, 10.4345, 180.1375,-1,-1);
	AddStaticVehicle(535,2471.3411, 1357.1541, 10.5841,0.1311,-1,-1);
	AddStaticVehicle(535,2610.6912, 1675.1757, 10.5845,90.5083,-1,-1);
	AddStaticVehicle(535,2012.7180,2754.1484, 10.5841, 182.1595,-1,-1);
	AddStaticVehicle(567,2111.5862,2740.1252, 10.6888,268.0402,-1,-1);
	AddStaticVehicle(567,711.7064, 1946.5415,5.4077, 180.7693,-1,-1);
	AddStaticVehicle(567,842.8339,834.4537, 12.7611, 186.4375,-1,-1);
	AddStaticVehicle(567, 1389.2365,773.4502, 10.6903,92.5741,-1,-1);
	AddStaticVehicle(567,2129.8276,892.2366, 10.6806,356.7939,-1,-1);
	AddStaticVehicle(437, 1067.1531, 1025.4388, 10.2898,235.2076,-1,-1);
	AddStaticVehicle(541,2039.6429, 1190.4884, 10.2966,356.9030,-1,-1);
	AddStaticVehicle(541,2119.3601,2142.7886, 10.2968, 182.6981,-1,-1);
	AddStaticVehicle(541,2076.0271,2469.0640, 10.4452, 181.0938,-1,-1);
	AddStaticVehicle(541, 1610.2261,2684.8274, 10.4052,266.8163,-1,-1);
	AddStaticVehicle(506,2356.8171,2579.3669, 10.5193,2.7096,-1,-1);
	AddStaticVehicle(506,2487.7114,2527.3049, 10.5247, 177.6446,-1,-1);
	AddStaticVehicle(506,2297.3542,2127.1067, 10.5247,88.6916,-1,-1);
	AddStaticVehicle(506,2194.7102, 1878.0905, 10.5249, 178.5289,-1,-1);
	AddStaticVehicle(587,2012.7782,924.6673, 10.5472,270.8799,-1,-1);
	AddStaticVehicle(587,2634.7615, 1071.6926, 10.5456,90.0729,-1,-1);
	AddStaticVehicle(587,2488.2246, 1297.3362, 10.5379,359.8708,-1,-1);
	AddStaticVehicle(587,828.9354,878.5657, 13.0172,292.5466,-1,-1);
	AddStaticVehicle(477, 1110.4922, 1831.0330, 10.5753, 179.9420,-1,-1);
	AddStaticVehicle(477, 1900.2263,2158.7151, 10.5752, 181.2949,-1,-1);
	AddStaticVehicle(477,2361.7158, 1994.5139, 10.4267, 180.6054,-1,-1);
	AddStaticVehicle(477,2125.3018, 1803.2379, 10.4277, 152.0696,-1,-1);
	AddStaticVehicle(558, 1900.6616,2082.2429, 10.4508, 181.1020,-1,-1);
	AddStaticVehicle(558, 1711.2220,2226.7529, 10.4520, 178.8641,-1,-1);
	AddStaticVehicle(558, 1549.0289,2140.6760, 10.4506,89.4409,-1,-1);
	AddStaticVehicle(559, 1471.0782, 1928.2479, 10.9691,266.3216,-1,-1);
	AddStaticVehicle(559, 1689.0592, 1641.2174, 10.4767, 184.4202,-1,-1);
	AddStaticVehicle(559,2123.3804, 1409.2528, 10.4703, 179.2619,-1,-1);
	AddStaticVehicle(559, 1881.4852,954.2305, 10.4766,85.6020,-1,-1);
	AddStaticVehicle(559, 1761.3527,768.3695, 10.4766,359.5341,-1,-1);
	AddStaticVehicle(560, 1917.7793,964.1596, 10.5255, 180.8135,-1,-1);
	AddStaticVehicle(560,2162.0869, 1028.3221, 10.5255,271.8910,-1,-1);
	AddStaticVehicle(560,2073.7729,2035.7565, 10.5259,266.4422,-1,-1);
	AddStaticVehicle(560,2297.5527,2042.4634, 10.5257,92.9736,-1,-1);
	AddStaticVehicle(560,2145.4063, 1409.4391, 10.5256, 179.1993,-1,-1);
	AddStaticVehicle(561, 1524.9885, 1038.4121, 10.6342,94.7072,-1,-1);
	AddStaticVehicle(561, 1928.9497,948.1937, 10.6266,91.1280,-1,-1);
	AddStaticVehicle(561,2074.5403, 1089.2621, 10.4858, 1.2950,-1,-1);
	AddStaticVehicle(562,2035.2380, 1035.0433, 10.4814, 180.8703,-1,-1);
	AddStaticVehicle(562,2035.2335,987.3387, 10.4800, 179.8130,-1,-1);
	AddStaticVehicle(562, 1881.1692,988.9169, 10.4795,92.4225,-1,-1);
	AddStaticVehicle(562,2008.4390,2414.9854, 10.4780,265.9358,-1,-1);
	AddStaticVehicle(446, 1629.2625,569.1407,-0.4828,280.8207,-1,-1);
	AddStaticVehicle(446,-2637.9258, 1503.7883,-0.4326, 198.0182,-1,-1);
	AddStaticVehicle(416, 1600.0950, 1831.3705, 10.9696,0.0288,-1,-1);
	AddStaticVehicle(416, 1614.7391, 1831.2045, 10.9694,0.4478,-1,-1);
	AddStaticVehicle(421,2188.9158, 1822.2882, 10.7028,359.8116,-1,-1);
	AddStaticVehicle(421,2148.7163, 1396.5952, 10.6969, 181.3439,-1,-1);
	AddStaticVehicle(421,2352.6853, 1472.9585, 19.0376,271.2728,-1,-1);
	AddStaticVehicle(445,2474.7888, 1089.3583, 10.6953, 179.5485,-1,-1);
	AddStaticVehicle(445,2014.7494, 1699.7942, 10.6953,90.8878,-1,-1);
	AddStaticVehicle(445, 1918.9209,2760.0837, 10.6934,86.7250,-1,-1);
	AddStaticVehicle(461,2066.5984,2188.2942, 10.4049,276.0631,-1,-1);
	AddStaticVehicle(461, 1883.9268,2118.8066, 10.4046,269.7591,-1,-1);
	AddStaticVehicle(461,2591.4409,2279.3391, 10.4068,273.3690,-1,-1);
	AddStaticVehicle(461,2827.3567,2376.7488, 10.4001,90.7138,-1,-1);
	AddStaticVehicle(467,2890.7292,2379.2034, 10.5604,270.5993,-1,-1);
	AddStaticVehicle(467,2491.0601,2773.3608, 10.5373,89.7958,-1,-1);
	AddStaticVehicle(475,2633.8857,2207.0139, 10.6245,358.7407,-1,-1);
	AddStaticVehicle(475,2428.2639,2530.0999,21.6797, 178.1749,-1,-1);
	AddStaticVehicle(475,2541.3835,2355.3555,4.0168,88.5918,-1,-1);
	AddStaticVehicle(542, 1893.9451,2331.3831, 10.5652,271.1566,3,46);
	AddStaticVehicle(542, 1628.7661,2236.2451, 10.5638,358.2055,-1,-1);
	AddStaticVehicle(542, 1657.7009, 1090.8824, 10.5637, 180.5101,-1,-1);
	AddStaticVehicle(542, 1550.4098, 1021.3586, 10.5636,268.5319,-1,-1);
	AddStaticVehicle(542, 1077.2311, 1212.3351, 10.5636, 181.9319,79,46);
	AddStaticVehicle(400,809.6285,843.1871,9.9319,285.0425,-1,-1);
	AddStaticVehicle(400,662.4098, 1259.8835, 11.5533,25.0445,-1,-1);
	AddStaticVehicle(400,787.4247, 1962.1318,5.4283,261.1720,-1,-1);
	AddStaticVehicle(400,992.3377,2037.5818, 11.3337,93.3966,-1,-1);
	AddStaticVehicle(400, 1330.1243,2239.7314, 10.9127,271.2026,-1,-1);
	AddStaticVehicle(400, 1067.9895,2386.0266, 10.9127,268.7650,-1,-1);
	AddStaticVehicle(490,2313.3308,2465.5623,-7.3257,88.6242,0,0);
	AddStaticVehicle(490,2316.0742,2431.5762,-7.3283,0.6496,3,3);
	AddStaticVehicle(490,2268.4189,2430.4072,-7.3258, 181.2159,79,79);
	AddStaticVehicle(490,2277.1582,2473.8132,-7.3243, 178.6099,6,6);
	AddStaticVehicle(411,-1955.6897,270.5793,40.7742,271.2761,-1,-1);
	AddStaticVehicle(411,-1987.5156,304.6937,34.9028,89.3214,-1,-1);
	AddStaticVehicle(487, 1621.9562, 1290.1423, 10.9855,95.4568,-1,-1);
	AddStaticVehicle(506, 1328.5680, 1279.1774, 10.5250,359.2437,-1,-1);
	AddStaticVehicle(542, 1312.8408, 1279.0232, 10.5635,359.3535,0,0);
	AddStaticVehicle(475, 1306.4203, 1279.4434, 10.6350, 1.2161,0,0);
	AddStaticVehicle(461, 1671.3730,999.9628, 10.3988, 180.1990,-1,-1);
	AddStaticVehicle(476, 1273.1141, 1481.7256, 11.5364,230.7264,0,0);
	AddStaticVehicle(577, 1584.3083, 1188.8120, 10.7791, 183.0702, 1,3);
	AddStaticVehicle(476, 1747.6897,-2626.7290, 14.2601,0.7122,3,3);
	AddStaticVehicle(476, 1621.1116,-2630.0288, 14.2577, 1.3985,0,0);
	AddStaticVehicle(593, 1893.6383,-2629.3264, 14.0097,357.2338,68,3);
	AddStaticVehicle(593, 1680.1844,-2627.9055, 14.0098,359.9746,68,0);
	AddStaticVehicle(411,605.6311, 1705.5037,6.7193,306.5900,6,6);
	AddStaticVehicle(411,-120.5536,951.7356,20.3309,271.6847,0,0);
	AddStaticVehicle(415,-111.5712, 1051.6532, 19.5221, 185.4362,0,0);
	AddStaticVehicle(429,-8.8860,983.5931, 19.3820,89.6957,0, 1);
	AddStaticVehicle(451,-160.3686, 1039.0305, 19.4773,280.2672,0,0);


/*	Pickup_Add(362, 2048.8982, 842.5585, 6.7031, -1, 120000);
	Pickup_Add(362, 2048.9250, 846.9829, 6.7267, -1, 120000);
	Pickup_Add(362, 2048.9517, 851.4742, 6.7267, -1, 120000);
	Pickup_Add(362, 2048.9788, 856.0185, 6.7344, -1, 120000);
	Pickup_Add(362, 2049.0054, 860.4025, 6.7344, -1, 120000);
	Pickup_Add(362, 2049.0054, 864.4025, 6.7344, -1, 120000);
	Pickup_Add(362, 2049.0581, 869.3719, 6.8722, -1, 120000);
	Pickup_Add(362, 2049.0837, 873.6844, 6.9696, -1, 120000);
	Pickup_Add(362, 2049.1106, 878.2312, 7.0707, -1, 120000);
	Pickup_Add(362, 2049.1370, 882.7609, 7.1714, -1, 120000);
	Pickup_Add(362, 2049.1650, 887.6218, 7.3580, -1, 120000);
	Pickup_Add(362, 2049.1902, 891.9701, 7.5270, -1, 120000);
	Pickup_Add(362, 2049.2156, 896.3336, 7.6965, -1, 120000);
	Pickup_Add(362, 2049.2400, 900.5980, 7.8544, -1, 120000);
	Pickup_Add(362, 2049.2656, 904.9891, 8.0573, -1, 120000);
	Pickup_Add(362, 2049.2925, 909.3036, 8.2916, -1, 120000);
	Pickup_Add(362, 2049.3174, 913.6056, 8.5251, -1, 120000);
	Pickup_Add(362, 2049.3430, 917.9857, 8.7629, -1, 120000);
	Pickup_Add(362, 2049.3682, 922.2305, 8.9934, -1, 120000);
	Pickup_Add(362, 2049.3948, 926.5323, 9.1864, -1, 120000);
	Pickup_Add(362, 2049.4221, 930.8814, 9.3661, -1, 120000);
	Pickup_Add(362, 2049.4482, 935.2264, 9.5455, -1, 120000);
	Pickup_Add(362, 2049.4744, 939.6959, 9.7301, -1, 120000);
	Pickup_Add(362, 2049.5012, 943.9589, 9.8943, -1, 120000);
	Pickup_Add(362, 2049.5300, 948.6203, 10.0070, -1, 120000);
	Pickup_Add(362, 2049.5559, 953.0123, 10.1132, -1, 120000);
	Pickup_Add(362, 2049.5811, 957.2213, 10.2150, -1, 120000);
	Pickup_Add(362, 2049.6082, 961.6796, 10.3228, -1, 120000);
	Pickup_Add(362, 2049.6365, 966.1622, 10.4114, -1, 120000);
	Pickup_Add(362, 2049.6633, 970.5005, 10.4781, -1, 120000);
	Pickup_Add(362, 2049.6899, 974.7954, 10.5421, -1, 120000);
	Pickup_Add(362, 2049.7175, 979.2451, 10.6073, -1, 120000);
	Pickup_Add(362, 2049.7454, 983.7375, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.7727, 988.1251, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.8000, 992.5039, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.8269, 996.9443, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.8540, 1001.4892, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.8816, 1005.9343, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.9097, 1010.3788, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.9360, 1014.7725, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.9639, 1019.3669, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.9907, 1023.7615, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.0190, 1028.2635, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.0464, 1032.8159, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.0730, 1037.0847, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.1006, 1041.6201, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.1287, 1046.1517, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.1560, 1050.5764, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.1836, 1055.0566, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.2107, 1059.5017, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.2390, 1064.2395, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.2664, 1068.7535, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.2932, 1073.1978, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.3198, 1077.5493, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.3474, 1082.0602, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.3750, 1086.6478, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.4016, 1091.0007, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.4285, 1095.4573, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.4548, 1099.8143, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.4817, 1104.2662, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.5076, 1108.6146, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.5342, 1113.0748, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.5615, 1117.5406, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.5884, 1121.9674, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.6147, 1126.4054, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.6414, 1130.8497, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.6685, 1135.4026, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.5652, 1140.3417, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.4658, 1144.9923, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.3677, 1149.5659, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.2751, 1153.8943, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.1755, 1158.5529, 10.6719, -1, 120000);
	Pickup_Add(362, 2050.0774, 1163.1006, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.9849, 1167.4110, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.8865, 1172.0116, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.7910, 1176.5204, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.6960, 1181.0066, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.5977, 1185.6499, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.5024, 1190.1163, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.4063, 1194.6191, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.3086, 1199.2223, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.2100, 1203.8156, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.1147, 1208.2797, 10.6719, -1, 120000);
	Pickup_Add(362, 2049.0225, 1212.5892, 10.6719, -1, 120000);
	Pickup_Add(362, 2048.9297, 1216.9415, 10.6719, -1, 120000);
	Pickup_Add(362, 2048.8342, 1221.4143, 10.6719, -1, 120000);
	Pickup_Add(362, 2048.7327, 1226.1954, 10.6719, -1, 120000);
	Pickup_Add(362, 2048.6367, 1230.6854, 10.6719, -1, 120000);
	Pickup_Add(362, 2048.5396, 1235.2412, 10.6719, -1, 120000);
	Pickup_Add(362, 2048.4438, 1239.7419, 10.6719, -1, 120000);
	Pickup_Add(362, 2048.3540, 1243.9288, 10.6719, -1, 120000);
	Pickup_Add(362, 2048.2551, 1248.5541, 10.6719, -1, 120000);
	Pickup_Add(362, 2048.1555, 1253.2152, 10.6719);
	Pickup_Add(362, 2048.0588, 1257.7471, 10.6719);
	Pickup_Add(362, 2047.9597, 1262.3778, 10.6719);
	Pickup_Add(362, 2047.8666, 1266.7363, 10.6719);
	Pickup_Add(362, 2047.7664, 1271.4351, 10.6719);
	Pickup_Add(362, 2047.6687, 1276.0037, 10.6719);
	Pickup_Add(362, 2047.5721, 1280.5287, 10.6719);
	Pickup_Add(362, 2047.4714, 1285.2627, 10.6719);
	Pickup_Add(362, 2047.3700, 1290.0140, 10.6719);
	Pickup_Add(362, 2047.2859, 1293.9531, 10.6987);
	Pickup_Add(362, 2047.1753, 1299.1469, 10.6719);
	Pickup_Add(362, 2047.0763, 1303.7903, 10.6719);
	Pickup_Add(362, 2046.9851, 1308.0594, 10.6719);
	Pickup_Add(362, 2046.8866, 1312.6869, 10.6719);
	Pickup_Add(362, 2046.7917, 1317.1428, 10.6719);
	Pickup_Add(362, 2046.7009, 1321.3926, 10.6719);
	Pickup_Add(362, 2046.6025, 1326.0167, 10.6719);
	Pickup_Add(362, 2046.5110, 1330.3147, 10.6719);
	Pickup_Add(362, 2046.4158, 1334.7797, 10.6719);
	Pickup_Add(362, 2046.3242, 1339.0780, 10.6719);
	Pickup_Add(362, 2046.2312, 1343.4507, 10.6719);
	Pickup_Add(362, 2046.1348, 1347.9618, 10.6719);
	Pickup_Add(362, 2046.0475, 1352.0436, 10.6719);
	Pickup_Add(362, 2045.9551, 1356.3735, 10.6719);
	Pickup_Add(362, 2045.8594, 1360.8539, 10.6719);
	Pickup_Add(362, 2045.7625, 1365.4016, 10.6719);
	Pickup_Add(362, 2045.6674, 1369.8702, 10.6719);
	Pickup_Add(362, 2045.5670, 1374.5782, 10.6719);
	Pickup_Add(362, 2045.4769, 1378.8047, 10.6719);
	Pickup_Add(362, 2045.3750, 1383.5865, 10.6719);
	Pickup_Add(362, 2045.2845, 1387.8318, 10.6719);
	Pickup_Add(362, 2045.1901, 1392.2648, 10.6719);
	Pickup_Add(362, 2045.0870, 1397.1016, 10.6719);
	Pickup_Add(362, 2044.9948, 1401.4080, 10.6719);
	Pickup_Add(362, 2044.9023, 1405.7466, 10.6719);
	Pickup_Add(362, 2044.8085, 1410.1478, 10.6719);
	Pickup_Add(362, 2044.7180, 1414.3806, 10.6719);
	Pickup_Add(362, 2044.6173, 1419.0952, 10.6719);
	Pickup_Add(362, 2044.5205, 1423.6365, 10.6719);
	Pickup_Add(362, 2044.4274, 1427.9962, 10.6719);
	Pickup_Add(362, 2044.3304, 1432.5389, 10.6719);
	Pickup_Add(362, 2044.2280, 1437.3376, 10.6719);
	Pickup_Add(362, 2044.1318, 1441.8445, 10.6719);
	Pickup_Add(362, 2044.0392, 1446.1895, 10.6719);
	Pickup_Add(362, 2043.9420, 1450.7411, 10.6719);
	Pickup_Add(362, 2043.8440, 1455.3430, 10.6719);
	Pickup_Add(362, 2043.7479, 1459.8643, 10.6719);
	Pickup_Add(362, 2043.6515, 1464.3816, 10.6719);
	Pickup_Add(362, 2043.5562, 1468.8496, 10.6719);
	Pickup_Add(362, 2043.4617, 1473.2766, 10.6719);
	Pickup_Add(362, 2043.3641, 1477.8438, 10.6719);
	Pickup_Add(362, 2043.2839, 1481.5979, 10.9106);
	Pickup_Add(362, 2043.2917, 1482.6931, 10.6719);
	Pickup_Add(362, 2043.6367, 1487.1611, 10.6719);
	Pickup_Add(362, 2043.9698, 1491.4731, 10.6719);
	Pickup_Add(362, 2044.3000, 1495.7461, 10.6719);
	Pickup_Add(362, 2044.6644, 1500.4587, 10.6719);
	Pickup_Add(362, 2045.0073, 1504.8938, 10.6719);
	Pickup_Add(362, 2045.3413, 1509.2150, 10.6719);
	Pickup_Add(362, 2045.7040, 1513.9089, 10.6719);
	Pickup_Add(362, 2046.0477, 1518.3583, 10.6719);
	Pickup_Add(362, 2046.3921, 1522.8136, 10.6719);
	Pickup_Add(362, 2046.3921, 1522.8136, 10.6719);
	Pickup_Add(362, 2046.7219, 1527.0789, 10.6719);
	Pickup_Add(362, 2047.0530, 1531.3619, 10.6719);
	Pickup_Add(362, 2047.4244, 1536.1675, 10.6719);
	Pickup_Add(362, 2047.7822, 1540.8010, 10.6719);
	Pickup_Add(362, 2048.1230, 1545.2162, 10.6719);
	Pickup_Add(362, 2048.4663, 1549.6591, 10.6719);
	Pickup_Add(362, 2048.8179, 1554.2069, 10.6719);
	Pickup_Add(362, 2049.1577, 1558.6061, 10.6719);
	Pickup_Add(362, 2049.4946, 1562.9666, 10.6719);
	Pickup_Add(362, 2049.8503, 1567.5673, 10.6719);
	Pickup_Add(362, 2050.1897, 1571.9648, 10.6719);
	Pickup_Add(362, 2050.5156, 1576.1864, 10.6719);
	Pickup_Add(362, 2050.8545, 1580.5616, 10.6719);
	Pickup_Add(362, 2051.2124, 1585.1915, 10.6719);
	Pickup_Add(362, 2051.5522, 1589.5870, 10.6719);
	Pickup_Add(362, 2051.9146, 1594.2764, 10.6719);
	Pickup_Add(362, 2052.2520, 1598.6504, 10.6719);
	Pickup_Add(362, 2052.6040, 1603.2100, 10.6719);
	Pickup_Add(362, 2052.9563, 1607.7717, 10.6719);
	Pickup_Add(362, 2053.3040, 1612.2686, 10.6719);
	Pickup_Add(362, 2053.6479, 1616.7219, 10.6719);
	Pickup_Add(362, 2053.9817, 1621.0465, 10.6719);
	Pickup_Add(362, 2054.0076, 1621.3790, 10.6719);
	Pickup_Add(362, 2053.8079, 1625.9993, 10.6719);
	Pickup_Add(362, 2053.6096, 1630.5828, 10.6719);
	Pickup_Add(362, 2053.4268, 1634.8135, 10.6719);
	Pickup_Add(362, 2053.2180, 1639.6433, 10.6719);
	Pickup_Add(362, 2053.0259, 1644.0978, 10.6719);
	Pickup_Add(362, 2052.8362, 1648.4907, 10.6719);
	Pickup_Add(362, 2052.6467, 1652.8770, 10.6719);
	Pickup_Add(362, 2052.4500, 1657.4358, 10.6719);
	Pickup_Add(362, 2052.2571, 1661.8969, 10.6719);
	Pickup_Add(362, 2052.0571, 1666.5287, 10.6719);
	Pickup_Add(362, 2051.8691, 1670.8864, 10.6719);
	Pickup_Add(362, 2051.6758, 1675.3499, 10.6719);
	Pickup_Add(362, 2051.4800, 1679.8857, 10.6719);
	Pickup_Add(362, 2051.2883, 1684.3256, 10.6719);
	Pickup_Add(362, 2051.0984, 1688.7167, 10.6719);
	Pickup_Add(362, 2050.9092, 1693.1097, 10.6719);
	Pickup_Add(362, 2050.7109, 1697.7124, 10.6719);
	Pickup_Add(362, 2050.5254, 1702.0123, 10.6719);
	Pickup_Add(362, 2050.3318, 1706.4747, 10.6719);
	Pickup_Add(362, 2050.1453, 1710.7902, 10.6797);
	Pickup_Add(362, 2049.9224, 1715.9698, 10.6719);
	Pickup_Add(362, 2049.7498, 1719.9628, 10.7492);
	Pickup_Add(362, 2049.5349, 1724.9355, 10.6719);
	Pickup_Add(362, 2049.3572, 1729.0421, 10.8203);
	Pickup_Add(362, 2049.1663, 1733.4644, 10.8203);
	Pickup_Add(362, 2048.9688, 1738.0382, 10.8203);
	Pickup_Add(362, 2048.7686, 1742.6606, 10.8203);*/
}

Script_OnPlayerRequestSpawnEx(playerid, classid) return 1;
Script_OnPlayerCommandText(playerid, cmdtext[]) return 0;
Script_OnPlayerStateChange(playerid, newstate, oldstate) return 1;
Script_OnPlayerDeath(playerid, killerid, reason) return 1;
Script_OnPlayerEnterCheckpointEx(playerid, cpid) return 1;
Script_OnPlayerLeaveCheckpointEx(playerid, cpid) return 1;
Script_OnPlayerEnterRaceCheckpoint(playerid) return 1;
Script_OnPlayerSelectedMenuRow(playerid, row) return 1;
Script_OnPlayerExitedMenu(playerid) return 1;
Script_OnVehicleSpawn(vehicleid) return 1;
Script_OnPlayerKeyStateChange(playerid, newkeys, oldkeys) return 1;

Script_OnRconCommand(cmd[])
{
	printf("RCON command: %s", cmd);
	return 1;
}

Script_OnPlayerLogin(playerid, yid)
{
	SendClientMessage(playerid, 0xFF0000AA, "logged in");
	return 1;
}

Script_OnPlayerPickUpPickup(playerid, pickupid)
{
	printf("pickupid: %d", pickupid);
	return 1;
}

forward OnPlayerMoneyChange(playerid, change);
public OnPlayerMoneyChange(playerid, change)
{
	printf("detected %d %d", playerid, change);
}
