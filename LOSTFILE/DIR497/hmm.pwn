/* SA:MP PAWN Debug -
 *  Debugging Filterscript used
 *  for creation of gamemode.
 *
 *  Simon Campbell
 *  10/03/2007, 6:31pm
*/

//==============================================================================

#include <a_samp>

#define DEBUG_VERSION   "0.4"

#define SKIN_SELECT   	true
#define	VEHI_SELECT   	true
#define WORL_SELECT     true
#define CAME_SELECT     true

#define MISCEL_CMDS     true
#define ADMINS_ONLY     false

#define SKIN_SEL_STAT   1
#define VEHI_SEL_STAT   2
#define WORL_SEL_STAT   3
#define CAME_SEL_STAT   4

#define COLOR_RED   	0xFF4040FF
#define COLOR_GREEN 	0x40FF40FF
#define COLOR_BLUE  	0x4040FFFF

#define COLOR_CYAN  	0x40FFFFFF
#define COLOR_PINK  	0xFF40FFFF
#define COLOR_YELLOW    0xFFFF40FF

#define COLOR_WHITE		0xFFFFFFFF
#define COLOR_BLACK		0x000000FF
#define COLOR_NONE      0x00000000

#define MIN_SKIN_ID		0
#define MAX_SKIN_ID		299

#define MIN_VEHI_ID		400
#define MAX_VEHI_ID		611

#define MIN_TIME_ID		0
#define MAX_TIME_ID		23

#define MIN_WEAT_ID     0
#define MAX_WEAT_ID		45

#define DEFAULT_GRA     0.008

#define VEHI_DIS        5.0

#define CMODE_A			0
#define CMODE_B			1

#define PI				3.14159265

#define CAMERA_TIME     40

#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

//==============================================================================

new gPlayerStatus[MAX_PLAYERS]; // Player Status
new gPlayerTimers[MAX_PLAYERS]; // Player TimerID's for keypresses
new gWorldStatus[3] =  {12, 4}; // Time, Weather

new curPlayerSkin[MAX_PLAYERS]				= {MIN_SKIN_ID, ...}; // Current Player Skin ID
new curPlayerVehM[MAX_PLAYERS]				= {MIN_VEHI_ID, ...}; // Current Player Vehicle ID
new curPlayerVehI[MAX_PLAYERS]				= {-1, ...};

enum P_CAMERA_D {
	CMODE,
	Float:RATE,
	Float:CPOS_X,
	Float:CPOS_Y,
	Float:CPOS_Z,
	Float:CLOO_X,
	Float:CLOO_Y,
	Float:CLOO_Z
};

new curPlayerCamD[MAX_PLAYERS][P_CAMERA_D];

enum CURVEHICLE {
	bool:spawn,
	vmodel,
	vInt
};

new curServerVehP[MAX_VEHICLES][CURVEHICLE];

new aSelNames[4][] = {			// Menu selection names
	{"SkinSelect"},
	{"VehicleSelect"},
	{"WeatherSelect"},
	{"CameraSelect"}
};

new aWeaponNames[][32] = {
	{"Unarmed (Fist)"}, // 0
	{"Brass Knuckles"}, // 1
	{"Golf Club"}, // 2
	{"Night Stick"}, // 3
	{"Knife"}, // 4
	{"Baseball Bat"}, // 5
	{"Shovel"}, // 6
	{"Pool Cue"}, // 7
	{"Katana"}, // 8
	{"Chainsaw"}, // 9
	{"Purple Dildo"}, // 10
	{"Big White Vibrator"}, // 11
	{"Medium White Vibrator"}, // 12
	{"Small White Vibrator"}, // 13
	{"Flowers"}, // 14
	{"Cane"}, // 15
	{"Grenade"}, // 16
	{"Teargas"}, // 17
	{"Molotov"}, // 18
	{" "}, // 19
	{" "}, // 20
	{" "}, // 21
	{"Colt 45"}, // 22
	{"Colt 45 (Silenced)"}, // 23
	{"Desert Eagle"}, // 24
	{"Normal Shotgun"}, // 25
	{"Sawnoff Shotgun"}, // 26
	{"Combat Shotgun"}, // 27
	{"Micro Uzi (Mac 10)"}, // 28
	{"MP5"}, // 29
	{"AK47"}, // 30
	{"M4"}, // 31
	{"Tec9"}, // 32
	{"Country Rifle"}, // 33
	{"Sniper Rifle"}, // 34
	{"Rocket Launcher"}, // 35
	{"Heat-Seeking Rocket Launcher"}, // 36
	{"Flamethrower"}, // 37
	{"Minigun"}, // 38
	{"Satchel Charge"}, // 39
	{"Detonator"}, // 40
	{"Spray Can"}, // 41
	{"Fire Extinguisher"}, // 42
	{"Camera"}, // 43
	{"Night Vision Goggles"}, // 44
	{"Infrared Vision Goggles"}, // 45
	{"Parachute"}, // 46
	{"Fake Pistol"} // 47
};


new aVehicleNames[212][] = {	// Vehicle Names - Betamaster
	{"Landstalker"},
	{"Bravura"},
	{"Buffalo"},
	{"Linerunner"},
	{"Perrenial"},
	{"Sentinel"},
	{"Dumper"},
	{"Firetruck"},
	{"Trashmaster"},
	{"Stretch"},
	{"Manana"},
	{"Infernus"},
	{"Voodoo"},
	{"Pony"},
	{"Mule"},
	{"Cheetah"},
	{"Ambulance"},
	{"Leviathan"},
	{"Moonbeam"},
	{"Esperanto"},
	{"Taxi"},
	{"Washington"},
	{"Bobcat"},
	{"Mr Whoopee"},
	{"BF Injection"},
	{"Hunter"},
	{"Premier"},
	{"Enforcer"},
	{"Securicar"},
	{"Banshee"},
	{"Predator"},
	{"Bus"},
	{"Rhino"},
	{"Barracks"},
	{"Hotknife"},
	{"Trailer 1"}, //artict1
	{"Previon"},
	{"Coach"},
	{"Cabbie"},
	{"Stallion"},
	{"Rumpo"},
	{"RC Bandit"},
	{"Romero"},
	{"Packer"},
	{"Monster"},
	{"Admiral"},
	{"Squalo"},
	{"Seasparrow"},
	{"Pizzaboy"},
	{"Tram"},
	{"Trailer 2"}, //artict2
	{"Turismo"},
	{"Speeder"},
	{"Reefer"},
	{"Tropic"},
	{"Flatbed"},
	{"Yankee"},
	{"Caddy"},
	{"Solair"},
	{"Berkley's RC Van"},
	{"Skimmer"},
	{"PCJ-600"},
	{"Faggio"},
	{"Freeway"},
	{"RC Baron"},
	{"RC Raider"},
	{"Glendale"},
	{"Oceanic"},
	{"Sanchez"},
	{"Sparrow"},
	{"Patriot"},
	{"Quad"},
	{"Coastguard"},
	{"Dinghy"},
	{"Hermes"},
	{"Sabre"},
	{"Rustler"},
	{"ZR-350"},
	{"Walton"},
	{"Regina"},
	{"Comet"},
	{"BMX"},
	{"Burrito"},
	{"Camper"},
	{"Marquis"},
	{"Baggage"},
	{"Dozer"},
	{"Maverick"},
	{"News Chopper"},
	{"Rancher"},
	{"FBI Rancher"},
	{"Virgo"},
	{"Greenwood"},
	{"Jetmax"},
	{"Hotring"},
	{"Sandking"},
	{"Blista Compact"},
	{"Police Maverick"},
	{"Boxville"},
	{"Benson"},
	{"Mesa"},
	{"RC Goblin"},
	{"Hotring Racer A"}, //hotrina
	{"Hotring Racer B"}, //hotrinb
	{"Bloodring Banger"},
	{"Rancher"},
	{"Super GT"},
	{"Elegant"},
	{"Journey"},
	{"Bike"},
	{"Mountain Bike"},
	{"Beagle"},
	{"Cropdust"},
	{"Stunt"},
	{"Tanker"}, //petro
	{"Roadtrain"},
	{"Nebula"},
	{"Majestic"},
	{"Buccaneer"},
	{"Shamal"},
	{"Hydra"},
	{"FCR-900"},
	{"NRG-500"},
	{"HPV1000"},
	{"Cement Truck"},
	{"Tow Truck"},
	{"Fortune"},
	{"Cadrona"},
	{"FBI Truck"},
	{"Willard"},
	{"Forklift"},
	{"Tractor"},
	{"Combine"},
	{"Feltzer"},
	{"Remington"},
	{"Slamvan"},
	{"Blade"},
	{"Freight"},
	{"Streak"},
	{"Vortex"},
	{"Vincent"},
	{"Bullet"},
	{"Clover"},
	{"Sadler"},
	{"Firetruck LA"}, //firela
	{"Hustler"},
	{"Intruder"},
	{"Primo"},
	{"Cargobob"},
	{"Tampa"},
	{"Sunrise"},
	{"Merit"},
	{"Utility"},
	{"Nevada"},
	{"Yosemite"},
	{"Windsor"},
	{"Monster A"}, //monstera
	{"Monster B"}, //monsterb
	{"Uranus"},
	{"Jester"},
	{"Sultan"},
	{"Stratum"},
	{"Elegy"},
	{"Raindance"},
	{"RC Tiger"},
	{"Flash"},
	{"Tahoma"},
	{"Savanna"},
	{"Bandito"},
	{"Freight Flat"}, //freiflat
	{"Streak Carriage"}, //streakc
	{"Kart"},
	{"Mower"},
	{"Duneride"},
	{"Sweeper"},
	{"Broadway"},
	{"Tornado"},
	{"AT-400"},
	{"DFT-30"},
	{"Huntley"},
	{"Stafford"},
	{"BF-400"},
	{"Newsvan"},
	{"Tug"},
	{"Trailer 3"}, //petrotr
	{"Emperor"},
	{"Wayfarer"},
	{"Euros"},
	{"Hotdog"},
	{"Club"},
	{"Freight Carriage"}, //freibox
	{"Trailer 3"}, //artict3
	{"Andromada"},
	{"Dodo"},
	{"RC Cam"},
	{"Launch"},
	{"Police Car (LSPD)"},
	{"Police Car (SFPD)"},
	{"Police Car (LVPD)"},
	{"Police Ranger"},
	{"Picador"},
	{"S.W.A.T. Van"},
	{"Alpha"},
	{"Phoenix"},
	{"Glendale"},
	{"Sadler"},
	{"Luggage Trailer A"}, //bagboxa
	{"Luggage Trailer B"}, //bagboxb
	{"Stair Trailer"}, //tugstair
	{"Boxville"},
	{"Farm Plow"}, //farmtr1
	{"Utility Trailer"} //utiltr1
};

//==============================================================================

forward SkinSelect(playerid);
forward VehicleSelect(playerid);
forward WorldSelect(playerid);
forward CameraSelect(playerid);

//==============================================================================

dcmd_debug(playerid, params[]) {
	if(strcmp(params, "help", true, 4) == 0) {
		SendClientMessage(playerid, COLOR_BLUE, "[DEBUG]: Debug Mode 0.2 - HELP");
		SendClientMessage(playerid, COLOR_CYAN, "[DEBUG]: Debug Mode 0.2 is a filterscript which allows scripters");
		SendClientMessage(playerid, COLOR_CYAN, "[DEBUG]: or people who wish to explore SA:MP 0.2\'s features to have access");
		SendClientMessage(playerid, COLOR_CYAN, "[DEBUG]: to many commands and \"menu\'s\".");
		SendClientMessage(playerid, COLOR_YELLOW, "[DEBUG]: This filterscript was designed for SA:MP version 0.2");
		SendClientMessage(playerid, COLOR_PINK, "[DEBUG]: For the command list type \"/debug commands\"");

		return true;
	}
	if(strcmp(params, "commands", true, 8) == 0) {
	    SendClientMessage(playerid, COLOR_BLUE, "[DEBUG]: Debug Mode 0.2 - COMMANDS");
	    SendClientMessage(playerid, COLOR_CYAN, "[WORLD]: /w, /weather, /t, /time, /wsel, /g, /gravity");
	    SendClientMessage(playerid, COLOR_CYAN, "[VEHICLES]: /v, /vehicle, /vsel");
	    SendClientMessage(playerid, COLOR_CYAN, "[PLAYER]: /s, /skin, /ssel, /weapon, /w2");
	    SendClientMessage(playerid, COLOR_CYAN, "[PLAYER]: /goto, /warpto, /bring, /setloc");
	    SendClientMessage(playerid, COLOR_CYAN, "[CAMERA]: /camera, /csel");

	    return true;
	}

	if(strcmp(params, "dump", true, 4) == 0) {
	    SendClientMessage(playerid, COLOR_GREEN, "[SUCCESS]: All current server data dumped to a file.");
	    new File:F_DUMP = fopen("DEBUG-DUMP.txt", io_append);
	    if(F_DUMP) {
	        new h, m, s, Y, M, D, cString[256];

			getdate(Y, M, D);
			gettime(h, m, s);

	        format(cString, 256, "// %d-%d-%d @ %d:%d:%d\r\n", D, M, Y, h, m, s);
	        fwrite(F_DUMP, cString);

	    	for(new i = 0; i < MAX_VEHICLES; i++) {
				if(curServerVehP[i][spawn] 	== true) {
				    new Float:vx, Float:vy, Float:vz, Float:va;
				    GetVehiclePos(i, vx, vy, vz);
				    GetVehicleZAngle(i, va);
					format(cString, 256, "CreateVehicle(%d, %f, %f, %f, %f, -1, -1, 5000); // Interior(%d), %s\r\n", curServerVehP[i][vmodel], vx, vy, vz, va, curServerVehP[i][vInt], aVehicleNames[curServerVehP[i][vmodel] - MIN_VEHI_ID]);
					fwrite(F_DUMP, cString);
	        	}
	    	}
	    	print("** Dumped current server information.");
	    	fclose(F_DUMP);
	    }
	    else {
			print("** Failed to create the file \"DEBUG-DUMP.txt\".\n");
	    }
	    return true;
	}
	return false;
}

#if CAME_SELECT == true

dcmd_camera(playerid, params[]) {
	new idx; new cString[128];

	cString = strtok(params, idx);

	if (!strlen(cString)) {
	    SendClientMessage(playerid, COLOR_RED, "[USAGE]: /camera [RATE/MODE] [RATE/MODEID]");

	    return true;
	}

	if (strcmp(cString, "rate", true, 4) == 0) {
	    curPlayerCamD[playerid][RATE] = floatstr(params[idx+1]);

	    return true;
	}

	if (strcmp(cString, "mode", true, 4) == 0) {
	    curPlayerCamD[playerid][CMODE] = strval(params[idx+1]);

	    return true;
	}

	return true;
}

dcmd_csel(playerid, params[]) {
	#pragma unused params

	new cString[128];

	if (gPlayerStatus[playerid] != 0) {
		format(cString, 128, "[ERROR]: You are already using \"%s\".", aSelNames[gPlayerStatus[playerid] - 1]);
		SendClientMessage(playerid, COLOR_RED, cString);

		return true;
	}

	gPlayerStatus[playerid] = CAME_SEL_STAT;

    TogglePlayerControllable(playerid, 0);

	GetPlayerPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
	GetXYInFrontOfPlayer(playerid, curPlayerCamD[playerid][CLOO_X], curPlayerCamD[playerid][CLOO_Y], 5.0);

	curPlayerCamD[playerid][CLOO_Z] = curPlayerCamD[playerid][CPOS_Z];

	gPlayerTimers[playerid] = SetTimerEx("CameraSelect", 200, 1, "i", playerid);

	return true;
}

#endif

#if WORL_SELECT == true
dcmd_g(playerid, params[]) {
	new cString[128];

	if (!strlen(params[0]))
	{
	    SendClientMessage(playerid, COLOR_RED, "[USAGE]: /g GRAVITY or /gravity GRAVITY");
	    return true;
	}

	new Float:grav = floatstr(params[0]);

	SetGravity(grav);

	format(cString, 128, "[SUCCESS]: World gravity changed to %f", grav);
	SendClientMessage(playerid, COLOR_GREEN, cString);

	return true;
}

dcmd_gravity(playerid, params[]) {
	dcmd_g(playerid, params);
	return true;
}

dcmd_w(playerid, params[]) {
	new idx, iString[128];
	iString = strtok(params, idx);

	if (!strlen(iString)) {
	    SendClientMessage(playerid, COLOR_RED, "[USAGE]: /w WEATHERID or /weather WEATHERID");
	    return true;
	}

	idx = strval(iString);

	if (idx < MIN_WEAT_ID || idx > MAX_WEAT_ID) {
	    SendClientMessage(playerid, COLOR_RED, "[ERROR]: Invalid WEATHERID");
	    return true;
	}

	gWorldStatus[1] = idx;

	SetWeather(idx);

	format(iString, 128, "[SUCCESS]: Weather has changed to WEATHERID %d", idx);
	SendClientMessage(playerid, COLOR_GREEN, iString);

	return true;
}

dcmd_weather(playerid, params[]) {
	dcmd_w(playerid, params);

	return true;
}

dcmd_t(playerid, params[]) {
	new idx, iString[128];
	iString = strtok(params, idx);

	if (!strlen(iString)) {
	    SendClientMessage(playerid, COLOR_RED, "[USAGE]: /t HOUR or /time HOUR");
	    return true;
	}

	idx = strval(iString);

	if (idx < MIN_TIME_ID || idx > MAX_TIME_ID) {
	    SendClientMessage(playerid, COLOR_RED, "[ERROR]: Invalid HOUR");
	    return true;
	}

	gWorldStatus[0] = idx;

	SetWorldTime(idx);

	format(iString, 128, "[SUCCESS]: Time has changed to HOUR %d", idx);
	SendClientMessage(playerid, COLOR_GREEN, iString);

	return true;
}

dcmd_time(playerid, params[]) {
	dcmd_t(playerid, params);

	return true;
}

dcmd_wsel(playerid, params[]) {
	#pragma unused params

	new cString[128];

	if (gPlayerStatus[playerid] != 0) {
		format(cString, 128, "[ERROR]: You are already using \"%s\".", aSelNames[gPlayerStatus[playerid] - 1]);
		SendClientMessage(playerid, COLOR_RED, cString);
		return true;
	}

	new Float:x, Float:y, Float:z;

	gPlayerStatus[playerid] = WORL_SEL_STAT;

	GetPlayerPos(playerid, x, y, z);
	SetPlayerCameraPos(playerid, x, y, z + 40.0);

	GetXYInFrontOfPlayer(playerid, x, y, 100.0);

	SetPlayerCameraLookAt(playerid, x, y, z + 5.0);

	TogglePlayerControllable(playerid, 0);

	gPlayerTimers[playerid] = SetTimerEx("WorldSelect", 200, 1, "i", playerid);

	GameTextForPlayer(playerid, "WorldSelect", 1500, 3);

	return true;
}
#endif

#if VEHI_SELECT == true

dcmd_v(playerid, params[]) {
	new idx, iString[128];
	iString = strtok(params, idx);

	if (gPlayerStatus[playerid] != 0) {
		format(iString, 128, "[ERROR]: You are already using \"%s\".", aSelNames[gPlayerStatus[playerid] - 1]);
		SendClientMessage(playerid, COLOR_RED, iString);
		return true;
	}

	if (!strlen(iString)) {
	    SendClientMessage(playerid, COLOR_RED, "[USAGE]: /v MODELID/NAME or /vehicle MODELID/NAME");
	    return true;
	}

	idx = GetVehicleModelIDFromName(params[1]);

	if(idx == -1) {
		idx = strval(iString);

		if (idx < MIN_VEHI_ID || idx > MAX_VEHI_ID) {
	    	SendClientMessage(playerid, COLOR_RED, "[ERROR]: Invalid MODELID/NAME");
	    	return true;
		}
	}

	new Float:x, Float:y, Float:z, Float:a;

	GetPlayerPos(playerid, x, y, z);
	GetXYInFrontOfPlayer(playerid, x, y, VEHI_DIS);
	GetPlayerFacingAngle(playerid, a);

	curPlayerVehM[playerid] = idx;

	curPlayerVehI[playerid] = CreateVehicle(idx, x, y, z + 2.0, a + 90.0, -1, -1, 5000);
	LinkVehicleToInterior(curPlayerVehI[playerid], GetPlayerInterior(playerid));

 	curServerVehP[curPlayerVehI[playerid]][spawn] 	= true;
	curServerVehP[curPlayerVehI[playerid]][vmodel]	= idx;
	curServerVehP[curPlayerVehI[playerid]][vInt]    = GetPlayerInterior(playerid);

	format(iString, 128, "[SUCCESS]: Spawned a \"%s\" (MODELID: %d, VEHICLEID: %d)", aVehicleNames[idx - MIN_VEHI_ID], idx, curPlayerVehI[playerid]);

	SendClientMessage(playerid, COLOR_GREEN, iString);

	return true;
}

dcmd_vehicle(playerid, params[])
{
	dcmd_v(playerid, params);

	return true;
}

dcmd_vsel(playerid, params[])
{
	// /vsel allows players to select a vehicle using playerkeys.
	#pragma unused params

	new cString[128];

	if (gPlayerStatus[playerid] != 0) {
		format(cString, 128, "[ERROR]: You are already using \"%s\".", aSelNames[gPlayerStatus[playerid] - 1]);
		SendClientMessage(playerid, COLOR_RED, cString);
		return true;
	}

	new Float:x, Float:y, Float:z, Float:a;

	gPlayerStatus[playerid] = VEHI_SEL_STAT;

	GetPlayerPos(playerid, x, y, z);
	SetPlayerCameraPos(playerid, x, y, z + 3.0);

	GetXYInFrontOfPlayer(playerid, x, y, VEHI_DIS);
	SetPlayerCameraLookAt(playerid, x, y, z);

	TogglePlayerControllable(playerid, 0);

	GetPlayerFacingAngle(playerid, a);

	curPlayerVehI[playerid] = CreateVehicle(curPlayerVehM[playerid], x, y, z + 2.0, a + 90.0, -1, -1, 5000);
	LinkVehicleToInterior(curPlayerVehI[playerid], GetPlayerInterior(playerid));

 	curServerVehP[curPlayerVehI[playerid]][spawn] 	= true;
	curServerVehP[curPlayerVehI[playerid]][vmodel]	= curPlayerVehM[playerid];
	curServerVehP[curPlayerVehI[playerid]][vInt]    = GetPlayerInterior(playerid);

	gPlayerTimers[playerid] = SetTimerEx("VehicleSelect", 200, 1, "i", playerid);

	return true;
}

#endif

#if SKIN_SELECT == true

dcmd_ssel(playerid, params[])
{
	// /ssel allows players to select a skin using playerkeys.
	#pragma unused params

	new cString[128];

	if (gPlayerStatus[playerid] != 0) {
		format(cString, 128, "[ERROR]: You are already using \"%s\".", aSelNames[gPlayerStatus[playerid] - 1]);
		SendClientMessage(playerid, COLOR_RED, cString);
		return true;
	}

	new Float:x, Float:y, Float:z;

	gPlayerStatus[playerid] = SKIN_SEL_STAT;

	GetPlayerPos(playerid, x, y, z);
	SetPlayerCameraLookAt(playerid, x, y, z);

	GetXYInFrontOfPlayer(playerid, x, y, 3.5);
	SetPlayerCameraPos(playerid, x, y, z);

	TogglePlayerControllable(playerid, 0);

	gPlayerTimers[playerid] = SetTimerEx("SkinSelect", 200, 1, "i", playerid);

	return true;
}

dcmd_s(playerid, params[])
{
    // /s SKINID allows players to directly select a skin using it's ID.
	new idx, iString[128];
	iString = strtok(params, idx);

	if (!strlen(iString)) {
	    SendClientMessage(playerid, COLOR_RED, "[USAGE]: /s SKINID");
	    return true;
	}

	idx = strval(iString);

	if (IsInvalidSkin(idx) || idx < MIN_SKIN_ID || idx > MAX_SKIN_ID) {
	    SendClientMessage(playerid, COLOR_RED, "[ERROR]: Invalid SKINID");
	    return true;
	}

	SetPlayerSkin(playerid, idx);
	curPlayerSkin[playerid] = idx;
	format(iString, 128, "[SUCCESS]: Changed skin to SKINID %d", idx);

	SendClientMessage(playerid, COLOR_GREEN, iString);

	return true;
}

dcmd_skin(playerid, params[])
{
	dcmd_s(playerid, params);

	return true;
}

#endif

#if MISCEL_CMDS == true
dcmd_goto(playerid, params[])
{
	new idx, iString[128];
	iString = strtok(params, idx);

	if (!strlen(iString)) {
	    SendClientMessage(playerid, COLOR_RED, "[USAGE]: /goto PLAYERID (X_OFFSET Y_OFFSET Z_OFFSET)");
	    return true;
	}

	new ID = strval(iString);

	if (!IsPlayerConnected(ID)) {
	    SendClientMessage(playerid, COLOR_RED, "[ERROR]: Not connected PLAYERID.");
	    return true;
	}

	new Float:X, Float:Y, Float:Z;
	new Interior = GetPlayerInterior(ID);

	GetPlayerPos(ID, X, Y, Z);

	iString = strtok(params, idx);

	if (!strlen(iString)) {
	    GetXYInFrontOfPlayer(ID, X, Y, 1.5);
	    SetPlayerInterior(playerid, Interior);
		SetPlayerPos(playerid, X, Y, Z);

		GetPlayerName(ID, iString, 128);
		format(iString, 128, "[SUCCESS]: You have warped to %s (ID: %d).", iString, ID);
		SendClientMessage(playerid, COLOR_GREEN, iString);

	    return true;
	}

	X += floatstr(iString);
	iString = strtok(params, idx);

	if (!strlen(iString)) {
	    goto fwarpto;
	}

	Y += floatstr(iString);
	iString = strtok(params, idx);

	if (!strlen(iString)) {
	    goto fwarpto;
	}

	Z += floatstr(iString);

	fwarpto:
	SetPlayerInterior(playerid, Interior);
	SetPlayerPos(playerid, X, Y, Z);

	GetPlayerName(ID, iString, 128);
	format(iString, 128, "[SUCCESS]: You have warped to %s (ID: %d).", iString, ID);
	SendClientMessage(playerid, COLOR_GREEN, iString);

	return true;
}

dcmd_warpto(playerid, params[])
{
	dcmd_goto(playerid, params);

	return true;
}

dcmd_setloc(playerid, params[])
{
	new idx, iString[128];
	iString = strtok(params, idx);

	if (!strlen(iString)) {
	    SendClientMessage(playerid, COLOR_RED, "[USAGE]: /setloc X Y Z INTERIOR");
	    return true;
	}

	new Float:X, Float:Y, Float:Z;
	new Interior;

	X = floatstr(iString);
	Y = floatstr(strtok(params,idx));
	Z = floatstr(strtok(params,idx));
	Interior = strval(strtok(params,idx));

	SetPlayerInterior(playerid, Interior);
	SetPlayerPos(playerid, X, Y, Z);

	return true;


}

dcmd_bring(playerid, params[])
{
	new idx, iString[128];
	iString = strtok(params, idx);

	if (!strlen(iString)) {
	    SendClientMessage(playerid, COLOR_RED, "[USAGE]: /bring PLAYERID (X_OFFSET Y_OFFSET Z_OFFSET)");
	    return true;
	}

	new ID = strval(iString);

	if (!IsPlayerConnected(ID)) {
	    SendClientMessage(playerid, COLOR_RED, "[ERROR]: Not connected PLAYERID.");
	    return true;
	}

	new Float:X, Float:Y, Float:Z;
	new Interior = GetPlayerInterior(playerid);

	GetPlayerPos(playerid, X, Y, Z);

	iString = strtok(params, idx);

	if (!strlen(iString)) {
	    GetXYInFrontOfPlayer(playerid, X, Y, 1.5);
	    SetPlayerInterior(ID, Interior);
		SetPlayerPos(ID, X, Y, Z);

		GetPlayerName(ID, iString, 128);
		format(iString, 128, "[SUCCESS]: You have brought %s (ID: %d) to you.", iString, ID);
		SendClientMessage(playerid, COLOR_GREEN, iString);

	    return true;
	}

	X += floatstr(iString);
	iString = strtok(params, idx);

	if (!strlen(iString)) {
	    goto fbring;
	}

	Y += floatstr(iString);
	iString = strtok(params, idx);

	if (!strlen(iString)) {
	    goto fbring;
	}

	Z += floatstr(iString);

	fbring:
	SetPlayerInterior(ID, Interior);
	SetPlayerPos(ID, X, Y, Z);

	GetPlayerName(ID, iString, 128);
	format(iString, 128, "[SUCCESS]: You have brought %s (ID: %d) to you.", iString, ID);
	SendClientMessage(playerid, COLOR_GREEN, iString);

	return true;
}

dcmd_weapon(playerid, params[])
{
	dcmd_w2(playerid, params);

	return true;
}

dcmd_w2(playerid, params[])
{
	new idx, iString[128];
	iString = strtok(params, idx);

	if (!strlen(iString)) {
	    SendClientMessage(playerid, COLOR_RED, "[USAGE]: /w2 WEAPONID/NAME (AMMO) or /weapon WEAPONID/NAME (AMMO)");
	    return true;
	}

	new weaponid = GetWeaponModelIDFromName(iString);

	if (weaponid == -1) {
		weaponid = strval(iString);
		if (weaponid < 0 || weaponid > 47) {
	    	SendClientMessage(playerid, COLOR_RED, "[ERROR]: Invalid WEAPONID/NAME");
	    	return true;
		}
	}

	if (!strlen(params[idx+1])) {
	    GivePlayerWeapon(playerid, weaponid, 500);

	    format(iString, 128, "[SUCCESS]: You were given weapon %s (ID: %d) with 500 ammo.", aWeaponNames[weaponid], weaponid);
	    SendClientMessage(playerid, COLOR_GREEN, iString);

	    return true;
	}

	idx = strval(params[idx+1]);

    GivePlayerWeapon(playerid, weaponid, idx);

    format(iString, 128, "[SUCCESS]: You were given weapon %s (ID: %d) with %d ammo.", aWeaponNames[weaponid], weaponid, idx);
    SendClientMessage(playerid, COLOR_GREEN, iString);

	return true;
}
#endif

public OnFilterScriptInit()
{
	print("\n  *********************\n  * SA:MP DEBUG 0.2   *");
	print("  * By Simon Campbell *\n  *********************");
	printf("  * Version: %s      *\n  *********************", DEBUG_VERSION);
	print("  * -- LOADED         *\n  *********************\n");

	AllowAdminTeleport(1);
}

public OnFilterScriptExit()
{
	print("\n  *********************\n  * SA:MP DEBUG 0.2   *");
	print("  * -- SHUTDOWN       *\n  *********************\n");
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	#if ADMINS_ONLY == true
	if(IsPlayerAdmin(playerid)) {
	#endif

	#if SKIN_SELECT == true
	dcmd(s, 1, cmdtext);
	dcmd(ssel, 4, cmdtext);
	dcmd(skin, 4, cmdtext);
	#endif

	#if VEHI_SELECT == true
	dcmd(v, 1, cmdtext);
	dcmd(vsel, 4, cmdtext);
	dcmd(vehicle, 7, cmdtext);
	#endif

	#if WORL_SELECT == true
	dcmd(w, 1, cmdtext);
	dcmd(t, 1, cmdtext);
	dcmd(g, 1, cmdtext);
	dcmd(wsel, 4, cmdtext);
	dcmd(time, 4, cmdtext);
	dcmd(weather, 7, cmdtext);
	dcmd(gravity, 7, cmdtext);
	#endif

	#if MISCEL_CMDS == true
	dcmd(w2, 2, cmdtext);
	dcmd(goto, 4, cmdtext);
	dcmd(bring, 5, cmdtext);
	dcmd(warpto, 6, cmdtext);
	dcmd(weapon, 6, cmdtext);
	dcmd(setloc, 6, cmdtext);
	#endif

	#if CAME_SELECT == true
	dcmd(csel, 4, cmdtext);
	dcmd(camera, 6, cmdtext);
	#endif

	dcmd(debug, 5, cmdtext);

	#if ADMINS_ONLY == true
	}
	#endif

	return 0;
}

public OnPlayerDisconnect(playerid)
{
    KillTimer(gPlayerTimers[playerid]);

	gPlayerStatus[playerid] = 0;
	gPlayerTimers[playerid] = 0;

	curPlayerSkin[playerid] = MIN_SKIN_ID; // Current Player Skin ID
	curPlayerVehM[playerid] = MIN_VEHI_ID; // Current Player Vehicle ID
	curPlayerVehI[playerid] = -1;
}

public OnPlayerConnect(playerid)
{
    curPlayerCamD[playerid][CMODE] = CMODE_A;
    curPlayerCamD[playerid][RATE]  = 2.0;

    #if ADMINS_ONLY == false
	AllowPlayerTeleport(playerid, 1);
	#endif
}

//==============================================================================

#if WORL_SELECT == true
public WorldSelect(playerid)
{   // Created by Simon
	/*
	// Make sure the player is not in world selection before continuing
	if (gPlayerStatus[playerid] != WORL_SEL_STAT) {
		KillTimer(skinTimerID[playerid]);
        return;
	}
	*/

	new keys, updown, leftright;

    GetPlayerKeys(playerid, keys, updown, leftright);

	new cString[128];

	// Right key increases World Time
	if (leftright == KEY_RIGHT) {
		if(gWorldStatus[0] == MAX_TIME_ID) {
			gWorldStatus[0] = MIN_TIME_ID;
		}
		else {
			gWorldStatus[0]++;
		}
		format(cString, 128, "World Time: %d~n~Weather ID: %d", gWorldStatus[0], gWorldStatus[1]);
    	GameTextForPlayer(playerid, cString, 1500, 3);
		SetWorldTime(gWorldStatus[0]);

	    return;
	}

	// Left key decreases World Time
	if (leftright == KEY_LEFT) {
	    if(gWorldStatus[0] == MIN_TIME_ID) {
	        gWorldStatus[0] = MAX_TIME_ID;
	    }
	    else {
	        gWorldStatus[0]--;
	    }
		format(cString, 128, "World Time: %d~n~Weather ID: %d", gWorldStatus[0], gWorldStatus[1]);
    	GameTextForPlayer(playerid, cString, 1500, 3);
		SetWorldTime(gWorldStatus[0]);

	    return;
	}

	// Up key increases Weather ID
	if(updown == KEY_UP) {
		if(gWorldStatus[1] == MAX_WEAT_ID) {
			gWorldStatus[1] = MIN_WEAT_ID;
		}
		else {
		        gWorldStatus[1]++;
		}
		format(cString, 128, "World Time: %d~n~Weather ID: %d", gWorldStatus[0], gWorldStatus[1]);
    	GameTextForPlayer(playerid, cString, 1500, 3);
		SetWeather(gWorldStatus[1]);
	}

	// Down key decreases Weather ID
	if(updown == KEY_DOWN) {
		if(gWorldStatus[1] == MIN_WEAT_ID) {
			gWorldStatus[1] = MAX_WEAT_ID;
		}
		else {
		        gWorldStatus[1]--;
		}
		format(cString, 128, "World Time: %d~n~Weather ID: %d", gWorldStatus[0], gWorldStatus[1]);
    	GameTextForPlayer(playerid, cString, 1500, 3);
		SetWeather(gWorldStatus[1]);
	}

	// Action key exits WorldSelection
	if(keys == KEY_ACTION) {
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, 1);

		format(cString, 128, "[SUCCESS]: Time changed to %d hours and weather changed to WEATHERID %d", gWorldStatus[0], gWorldStatus[1]);
		SendClientMessage(playerid, COLOR_GREEN, cString);

		new File:F_WORLD = fopen("TIME-WEATHER.txt", io_append);

		if(F_WORLD) {
		    new h, m, s, Y, M, D;

			getdate(Y, M, D);
			gettime(h, m, s);

			format(cString, 128, "// %d-%d-%d @ %d:%d:%d\r\nSetWeather(%d);\r\nSetWorldTime(%d);\r\n", D, M, Y, h, m, s);

			fwrite(F_WORLD, cString);
			fclose(F_WORLD);
			printf("\n%s\n",cString);
		}
		else {
			print("Failed to create the file \"TIME-WEATHER.txt\".\n");
		}

		gPlayerStatus[playerid] = 0;
		KillTimer(gPlayerTimers[playerid]);

		return;
	}
}

#endif

#if SKIN_SELECT == true
public SkinSelect(playerid)
{   // Created by Simon
	/*
	// Make sure the player is not in skin selection before continuing
	if (gPlayerStatus[playerid] != SKIN_SEL_STAT) {
		KillTimer(skinTimerID[playerid]);
        return;
	}
	*/

	new keys, updown, leftright;

    GetPlayerKeys(playerid, keys, updown, leftright);

	new cString[128];

	// Right key increases Skin ID
	if (leftright == KEY_RIGHT) {
		if(curPlayerSkin[playerid] == MAX_SKIN_ID) {
			curPlayerSkin[playerid] = MIN_SKIN_ID;
		}
		else {
  			curPlayerSkin[playerid]++;
	    }
		while(IsInvalidSkin(curPlayerSkin[playerid])) {
			curPlayerSkin[playerid]++;
		}

  		format(cString, 128, "Skin ID: %d", curPlayerSkin[playerid]);
    	GameTextForPlayer(playerid, cString, 1500, 3);
	    SetPlayerSkin(playerid, curPlayerSkin[playerid]);

	    return;
	}

	// Left key decreases Skin ID
	if(leftright == KEY_LEFT) {
 		if(curPlayerSkin[playerid] == MIN_SKIN_ID) {
			curPlayerSkin[playerid] = MAX_SKIN_ID;
		}
		else {
			curPlayerSkin[playerid]--;
		}
		while(IsInvalidSkin(curPlayerSkin[playerid])) {
			curPlayerSkin[playerid]--;
		}

		format(cString, 128, "Skin ID: %d", curPlayerSkin[playerid]);
  		GameTextForPlayer(playerid, cString, 1500, 3);
  		SetPlayerSkin(playerid, curPlayerSkin[playerid]);

  		return;
	}

	// Action key exits skin selection
	if(keys == KEY_ACTION)
	{
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, 1);

		format(cString, 128, "[SUCCESS]: You have changed to SKINID %d", curPlayerSkin[playerid]);
		SendClientMessage(playerid, COLOR_GREEN, cString);

		gPlayerStatus[playerid] = 0;
		KillTimer(gPlayerTimers[playerid]);

		return;
	}
}
#endif

#if CAME_SELECT == true
public CameraSelect(playerid)
{
	// CMODE_A 0	Up/Down = IncreaseZ/DecreaseZ; Left/Right = IncreaseX/DecreaseX; Num4/Num6 = IncreaseY/DecreaseY
	// CMODE_B 1	Up/Down = Rotate Up/Down; Left/Right = Rotate Left/Right; Num4/Num6 = Move Left/Right

	new keys, updown, leftright;

	GetPlayerKeys(playerid, keys, updown, leftright);

	printf("keys = %d, updown = %d, leftright = %d", keys, updown, leftright);

	new cString[128];

	if (curPlayerCamD[playerid][CMODE] == CMODE_A)
	{
	    if (leftright == KEY_RIGHT) {
	        curPlayerCamD[playerid][CPOS_X] += curPlayerCamD[playerid][RATE];
	        curPlayerCamD[playerid][CLOO_X] += curPlayerCamD[playerid][RATE];

	        SetPlayerPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);

	        SetPlayerCameraPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
	        SetPlayerCameraLookAt(playerid, curPlayerCamD[playerid][CLOO_X], curPlayerCamD[playerid][CLOO_Y], curPlayerCamD[playerid][CLOO_Z]);
	 	}

		if (leftright == KEY_LEFT) {
	        curPlayerCamD[playerid][CPOS_X] -= curPlayerCamD[playerid][RATE];
	        curPlayerCamD[playerid][CLOO_X] -= curPlayerCamD[playerid][RATE];

	        SetPlayerPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);

	        SetPlayerCameraPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
	        SetPlayerCameraLookAt(playerid, curPlayerCamD[playerid][CLOO_X], curPlayerCamD[playerid][CLOO_Y], curPlayerCamD[playerid][CLOO_Z]);
		}

		if (updown == KEY_UP) {
			curPlayerCamD[playerid][CPOS_Z] += curPlayerCamD[playerid][RATE];
	        curPlayerCamD[playerid][CLOO_Z] += curPlayerCamD[playerid][RATE];

	        SetPlayerPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);

	        SetPlayerCameraPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
	        SetPlayerCameraLookAt(playerid, curPlayerCamD[playerid][CLOO_X], curPlayerCamD[playerid][CLOO_Y], curPlayerCamD[playerid][CLOO_Z]);
		}

		if (updown == KEY_DOWN) {
  			curPlayerCamD[playerid][CPOS_Z] -= curPlayerCamD[playerid][RATE];
	        curPlayerCamD[playerid][CLOO_Z] -= curPlayerCamD[playerid][RATE];

	        SetPlayerPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);

	        SetPlayerCameraPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
	        SetPlayerCameraLookAt(playerid, curPlayerCamD[playerid][CLOO_X], curPlayerCamD[playerid][CLOO_Y], curPlayerCamD[playerid][CLOO_Z]);
		}

		if (keys == KEY_ANALOG_RIGHT) {
		    curPlayerCamD[playerid][CPOS_Y] += curPlayerCamD[playerid][RATE];
	        curPlayerCamD[playerid][CLOO_Y] += curPlayerCamD[playerid][RATE];

	        SetPlayerPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);

	        SetPlayerCameraPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
	        SetPlayerCameraLookAt(playerid, curPlayerCamD[playerid][CLOO_X], curPlayerCamD[playerid][CLOO_Y], curPlayerCamD[playerid][CLOO_Z]);
		}


		if (keys == KEY_ANALOG_LEFT) {
		    curPlayerCamD[playerid][CPOS_Y] -= curPlayerCamD[playerid][RATE];
	        curPlayerCamD[playerid][CLOO_Y] -= curPlayerCamD[playerid][RATE];

	        SetPlayerPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);

	        SetPlayerCameraPos(playerid, curPlayerCamD[playerid][CPOS_X], curPlayerCamD[playerid][CPOS_Y], curPlayerCamD[playerid][CPOS_Z]);
	        SetPlayerCameraLookAt(playerid, curPlayerCamD[playerid][CLOO_X], curPlayerCamD[playerid][CLOO_Y], curPlayerCamD[playerid][CLOO_Z]);
		}
	}


	if(curPlayerCamD[playerid][CMODE] == CMODE_B)
	{
	    if (leftright == KEY_RIGHT) {
	        // Rotate Y +
   		}

   		if (leftright == KEY_LEFT) {
   		    // Rotate Y -
   		}

   		if (updown == KEY_UP) {
   		    // Rotate X +
   		}

   		if (updown == KEY_DOWN) {
   		    // Rotate X -
   		}

   		if (keys == KEY_ANALOG_RIGHT) {
   		    // Rotate Z +
   		}

   		if (keys == KEY_ANALOG_LEFT) {
   		    // Rotate Z -
   		}
	}

	if (keys == KEY_ACTION)
	{
	    SetCameraBehindPlayer(playerid);

        new File:F_CAMERA = fopen("CAMERA.txt", io_append);

		if(F_CAMERA) {
		    new h, m, s, Y, M, D;

			getdate(Y, M, D);
			gettime(h, m, s);

			format(cString, 128, "// %d-%d-%d @ %d:%d:%d\r\nSetPlayerCameraPos(playerid, %f, %f, %f);\r\nSetPlayerCameraLookAt(playerid, %f, %f, %f);\r\n", D, M, Y, h, m, s,curPlayerCamD[playerid][CPOS_X],curPlayerCamD[playerid][CPOS_Y],curPlayerCamD[playerid][CPOS_Z],curPlayerCamD[playerid][CLOO_X],curPlayerCamD[playerid][CLOO_Y],curPlayerCamD[playerid][CLOO_Z]);

			fwrite(F_CAMERA, cString);
			fclose(F_CAMERA);
			printf("\n%s\n",cString);
		}
		else {
			print("Failed to create the file \"CAMERA.txt\".\n");
		}

		TogglePlayerControllable(playerid, 1);

		KillTimer(gPlayerTimers[playerid]);

		gPlayerStatus[playerid] = 0;

	    return;
	}
}

#endif

#if VEHI_SELECT == true
public VehicleSelect(playerid)
{
	/*
	// Make sure the player is not in skin selection before continuing
	if (gPlayerStatus[playerid] != VEHI_SEL_STAT) {
		KillTimer(skinTimerID[playerid]);
        return;
	}
	*/

	new keys, updown, leftright;

    GetPlayerKeys(playerid, keys, updown, leftright);

	new cString[128];

	// Right key increases Vehicle MODELID
	if (leftright == KEY_RIGHT) {
		if(curPlayerVehM[playerid] == MAX_VEHI_ID) {
			curPlayerVehM[playerid] = MIN_VEHI_ID;
		}
		else {
  			curPlayerVehM[playerid]++;
	    }

		format(cString, 128, "Model ID: %d~n~Vehicle Name: %s", curPlayerVehM, aVehicleNames[curPlayerVehM[playerid] - MIN_VEHI_ID]);
    	GameTextForPlayer(playerid, cString, 1500, 3);

    	new Float:x, Float:y, Float:z, Float:a;

		GetPlayerPos(playerid, x, y, z);
		GetXYInFrontOfPlayer(playerid, x, y, VEHI_DIS);
		GetPlayerFacingAngle(playerid, a);

		DestroyVehicle(curPlayerVehI[playerid]);
		curServerVehP[curPlayerVehI[playerid]][spawn] 	= false;

		curPlayerVehI[playerid] = CreateVehicle(curPlayerVehM[playerid], x, y, z + 2.0, a + 90.0, -1, -1, 5000);
        LinkVehicleToInterior(curPlayerVehI[playerid], GetPlayerInterior(playerid));

        curServerVehP[curPlayerVehI[playerid]][spawn] 	= true;
		curServerVehP[curPlayerVehI[playerid]][vmodel]	= curPlayerVehM[playerid];
		curServerVehP[curPlayerVehI[playerid]][vInt]    = GetPlayerInterior(playerid);

	    return;
	}

	// Left key decreases Vehicle MODELID
	if(leftright == KEY_LEFT) {
 		if(curPlayerVehM[playerid] == MIN_VEHI_ID) {
			curPlayerVehM[playerid] = MAX_VEHI_ID;
		}
		else {
			curPlayerVehM[playerid]--;
		}

		format(cString, 128, "Model ID: %d~n~Vehicle Name: %s", curPlayerVehM, aVehicleNames[curPlayerVehM[playerid] - MIN_VEHI_ID]);
  		GameTextForPlayer(playerid, cString, 1500, 3);

   		new Float:x, Float:y, Float:z, Float:a;

		GetPlayerPos(playerid, x, y, z);
		GetXYInFrontOfPlayer(playerid, x, y, VEHI_DIS);
		GetPlayerFacingAngle(playerid, a);

		DestroyVehicle(curPlayerVehI[playerid]);
		curServerVehP[curPlayerVehI[playerid]][spawn] 	= false;

		curPlayerVehI[playerid] = CreateVehicle(curPlayerVehM[playerid], x, y, z + 2.0, a + 90.0, -1, -1, 5000);
		LinkVehicleToInterior(curPlayerVehI[playerid], GetPlayerInterior(playerid));

 		curServerVehP[curPlayerVehI[playerid]][spawn] 	= true;
		curServerVehP[curPlayerVehI[playerid]][vmodel]	= curPlayerVehM[playerid];
		curServerVehP[curPlayerVehI[playerid]][vInt]    = GetPlayerInterior(playerid);

  		return;
	}

	// Action key exits vehicle selection
	if(keys == KEY_ACTION)
	{
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, 1);

		format(cString, 128, "[SUCCESS]: Spawned a \"%s\" (MODELID: %d, VEHICLEID: %d)", aVehicleNames[curPlayerVehM[playerid] - MIN_VEHI_ID], curPlayerVehM[playerid], curPlayerVehI[playerid]);
		SendClientMessage(playerid, COLOR_GREEN, cString);

		gPlayerStatus[playerid] = 0;
		KillTimer(gPlayerTimers[playerid]);

		return;
	}
}
#endif

IsInvalidSkin(skinid)
{   // Created by Simon

	#define	MAX_BAD_SKINS   22

	new badSkins[MAX_BAD_SKINS] = {
		3, 4, 5, 6, 8, 42, 65, 74, 86,
		119, 149, 208, 265, 266, 267,
		268, 269, 270, 271, 272, 273, 289
	};

	for (new i = 0; i < MAX_BAD_SKINS; i++) {
	    if (skinid == badSkins[i]) return true;
	}

	return false;
}

GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{	// Created by Y_Less

	new Float:a;

	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);

	if (GetPlayerVehicleID(playerid)) {
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}

	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

strtok(const string[], &index)
{   // Created by Compuphase

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

GetVehicleModelIDFromName(vname[])
{
	for(new i = 0; i < 211; i++) {
		if (strfind(aVehicleNames[i], vname, true) != -1) {
			return i + MIN_VEHI_ID;
		}
	}
	return -1;
}

GetWeaponModelIDFromName(wname[])
{
    for(new i = 0; i < 48; i++) {
        if (i == 19 || i == 20 || i == 21) continue;
		if (strfind(aWeaponNames[i], wname, true) != -1) {
			return i;
		}
	}
	return -1;
}
