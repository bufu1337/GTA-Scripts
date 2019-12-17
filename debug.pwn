#include 					<a_samp>
#include 					<zcmd>
#include                    <sscanf2>
#define USE_RCON            false // Change to true if you want RCON to use cmds only.
#define COLOR_GREEN         0x00CC00FF
#define COLOR_RED           0xFF0000FF
#define COLOR_YELLOW        0xFFFF00FF
#define COLOR_ORANGE        0xEE9911FF
enum TEXTDRAW{
	Text: E_TEXTDRAW_DEBUG_BOX 		[MAX_PLAYERS],
	Text: E_TEXTDRAW_DEBUG_POSITION	[MAX_PLAYERS],
	Text: E_TEXTDRAW_DEBUG_PLAYER	[MAX_PLAYERS],
	Text: E_TEXTDRAW_DEBUG_HIDE		[MAX_PLAYERS],
}
enum PLAYER{
	Float: E_SYNC_POS				[3], // xyz
	Float: E_SYNC_PLA				[3], // health/armour
	E_SYNC_WORLD,
	E_SYNC_INTERIOR,
	E_SYNC_SKIN,
	E_SYNC_CASH,
	E_SYNC_GUN[12],
	E_SYNC_AMMO[12],
	bool: E_SYNC_NEED,
}
enum OBJECTS{
	Text3D: E_OBJECT_INFO,
	bool:   E_OBJECT_LABELLED,
}
enum VEHICLE{
    Text3D: E_VEHICLE_INFO,
    bool:   E_VEHICLE_LABELLED,
}
new
	gVehicleData                    [MAX_VEHICLES][VEHICLE],
	gObjectData                     [MAX_OBJECTS][OBJECTS],
	gTextDrawData					[TEXTDRAW],
	gPlayerData                     [MAX_PLAYERS][PLAYER],
	bool: gDebugHudShowing			[MAX_PLAYERS char],
	Text3D: PlayerLabel				[MAX_PLAYERS char]
;
forward RestoreBackFromSync(playerid);
forward VehicleObjectUpdate();
public OnFilterScriptInit(){
	new string[128];
	print( "\n * nLorDebug loaded\n" );
	CreateObject(3267,1894.813,1628.544,74.204,0.0,0.0,-90.000);
	CreateObject(3267,1961.728,1663.508,74.279,0.0,0.0,135.000);
	CreateObject(3267,1961.765,1593.764,74.154,0.0,0.0,33.750);
	CreateObject(1454,1935.195,1635.968,72.006,0.0,0.0,33.750);
	CreateObject(1457,1936.958,1637.483,72.867,0.0,0.0,47.578);
	CreateObject(1458,1937.400,1637.118,71.461,0.0,0.0,43.358);
	CreateObject(14875,1940.153,1641.579,71.951,0.0,0.0,45.000);
	AddStaticVehicle(560, 2043.628, 1342.956, 15, 0, -1, -1);
	AddStaticVehicle(560, 2043.628+random(10), 1342.956+random(10), 15+random(10), 0, -1, -1);
	AddStaticVehicle(560, 2043.628+random(10), 1342.956+random(10), 15+random(10), 0, -1, -1);
	for(new v = 0; v < MAX_VEHICLES; v++){
	    if(IsVehicleSpawned(v)){
	        new Float: vStatus, Float: vPos[3];
			GetVehiclePos(v, vPos[0], vPos[1], vPos[2]);
			GetVehicleHealth(v, vStatus);
			format(string, sizeof(string), 	"ID: %d, Model ID: %d\n \
											 X: %0.3f, Y: %0.3f, Z: %0.3f,\n \
											 Health: %0.1f",
											v, GetVehicleModel(v),
											vPos[0], vPos[1], vPos[2],
											vStatus);
			gVehicleData[v][E_VEHICLE_LABELLED] = true;
			gVehicleData[v][E_VEHICLE_INFO] = Create3DTextLabel(string, 0xFFFFFFFF, 0,0,0, 30.0, 0);
			Attach3DTextLabelToVehicle(gVehicleData[v][E_VEHICLE_INFO], v, 0.0, 0.0, 0.0);
  		}
	}
	for(new i = 0; i < MAX_OBJECTS; i++){
	    if(IsValidObject(i)){
	        new Float: oPos[3], Float: rPos[3];
		    GetObjectPos(i, oPos[0], oPos[1], oPos[2]);
		    GetObjectRot(i, rPos[0], rPos[1], rPos[2]);
		    format(string, sizeof(string), "ID: %d\n \
											X: %0.3f, Y: %0.3f, Z: %0.3f\n \
											\nrX: %0.3f, rY: %0.3f, rZ: %0.3f",
											i,
											oPos[0], oPos[1], oPos[2],
											rPos[0], rPos[1], rPos[2]);
			gObjectData[i][E_OBJECT_LABELLED] = true;
			gObjectData[i][E_OBJECT_INFO] = Create3DTextLabel(string, 0xFFFFFFFF, oPos[0], oPos[1], oPos[2], 30.0, 0);
		}
	}
	SetTimer("VehicleObjectUpdate", 750, true);
	return 1;
}
public VehicleObjectUpdate(){
	new string[128], Float: oPos[3], Float: rPos[3],
		Float: vStatus, Float: vPos[3];
	for(new v = 0; v < MAX_VEHICLES; v++){
	    if(IsVehicleSpawned(v)){
			if(gVehicleData[v][E_VEHICLE_LABELLED] == true){
				GetVehiclePos(v, vPos[0], vPos[1], vPos[2]);
				GetVehicleHealth(v, vStatus);
				format(string, sizeof(string), 	"ID: %d, Model ID: %d\n \
												 X: %0.3f, Y: %0.3f, Z: %0.3f,\n \
												 Health: %0.1f",
												v, GetVehicleModel(v),
												vPos[0], vPos[1], vPos[2],
												vStatus);
				Update3DTextLabelText(gVehicleData[v][E_VEHICLE_INFO], 0xFFFFFFFF, string);
			}
	    }
	}
	for(new i = 0; i < MAX_OBJECTS; i++){
	    if(IsValidObject(i)){
	        if(gObjectData[i][E_OBJECT_LABELLED] == true){
			    GetObjectPos(i, oPos[0], oPos[1], oPos[2]);
			    GetObjectRot(i, rPos[0], rPos[1], rPos[2]);
			    format(string, sizeof(string), "ID: %d\n \
												X: %0.3f, Y: %0.3f, Z: %0.3f\n \
												\nrX: %0.3f, rY: %0.3f, rZ: %0.3f",
												i,
												oPos[0], oPos[1], oPos[2],
												rPos[0], rPos[1], rPos[2]);
	            Update3DTextLabelText(gObjectData[i][E_OBJECT_INFO], 0xFFFFFFFF, string);
			}
		}
	}
}
public OnFilterScriptExit(){
	print( "\n * nLorDebug unloaded\n" );
	for(new i = 0; i < MAX_OBJECTS; i++){
		Delete3DTextLabel(gObjectData[i][E_OBJECT_INFO]);
		gObjectData[i][E_OBJECT_LABELLED] = false;
	}
	for(new v = 0; v < MAX_VEHICLES; v++){
		Delete3DTextLabel(gVehicleData[v][E_VEHICLE_INFO]);
		gVehicleData[v][E_VEHICLE_LABELLED] = false;
	}
	return 1;
}
public OnPlayerConnect(playerid){
	new string[MAX_PLAYER_NAME + 50];
	loadTextDraws(playerid);
	gDebugHudShowing{playerid} = true;
	format(string, sizeof(string), "%s(%d)\nPING:%d", ReturnPlayerName(playerid), playerid, GetPlayerPing(playerid));
	PlayerLabel{playerid} = Create3DTextLabel(string, 0xFFFFFFFF, 0.0, 0.0, 0.0, 30.0, 0);
    Attach3DTextLabelToPlayer(PlayerLabel{playerid}, playerid, 0.0, 0.0, 0.0);
	return 1;
}
public OnPlayerDisconnect(playerid, reason){
	Delete3DTextLabel(PlayerLabel{playerid});
	return 1;
}
public OnPlayerSpawn(playerid){
	if(gPlayerData[playerid][E_SYNC_NEED] == true) SetTimerEx("RestoreBackFromSync", 1000, false, "d", playerid);
	return 1;
}
public RestoreBackFromSync(playerid){
	SetPlayerPos(playerid, 	gPlayerData[playerid][E_SYNC_POS][0],
	                        gPlayerData[playerid][E_SYNC_POS][1],
	                        gPlayerData[playerid][E_SYNC_POS][2]);
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, gPlayerData[playerid][E_SYNC_GUN][0], gPlayerData[playerid][E_SYNC_AMMO][0]);
	GivePlayerWeapon(playerid, gPlayerData[playerid][E_SYNC_GUN][1], gPlayerData[playerid][E_SYNC_AMMO][1]);
	GivePlayerWeapon(playerid, gPlayerData[playerid][E_SYNC_GUN][2], gPlayerData[playerid][E_SYNC_AMMO][2]);
	GivePlayerWeapon(playerid, gPlayerData[playerid][E_SYNC_GUN][3], gPlayerData[playerid][E_SYNC_AMMO][3]);
	GivePlayerWeapon(playerid, gPlayerData[playerid][E_SYNC_GUN][4], gPlayerData[playerid][E_SYNC_AMMO][4]);
	GivePlayerWeapon(playerid, gPlayerData[playerid][E_SYNC_GUN][5], gPlayerData[playerid][E_SYNC_AMMO][5]);
	GivePlayerWeapon(playerid, gPlayerData[playerid][E_SYNC_GUN][6], gPlayerData[playerid][E_SYNC_AMMO][6]);
	GivePlayerWeapon(playerid, gPlayerData[playerid][E_SYNC_GUN][7], gPlayerData[playerid][E_SYNC_AMMO][7]);
	GivePlayerWeapon(playerid, gPlayerData[playerid][E_SYNC_GUN][8], gPlayerData[playerid][E_SYNC_AMMO][8]);
	GivePlayerWeapon(playerid, gPlayerData[playerid][E_SYNC_GUN][9], gPlayerData[playerid][E_SYNC_AMMO][9]);
	GivePlayerWeapon(playerid, gPlayerData[playerid][E_SYNC_GUN][10], gPlayerData[playerid][E_SYNC_AMMO][10]);
	GivePlayerWeapon(playerid, gPlayerData[playerid][E_SYNC_GUN][11], gPlayerData[playerid][E_SYNC_AMMO][11]);
	SetPlayerHealth(playerid, gPlayerData[playerid][E_SYNC_PLA][0]);
	SetPlayerArmour(playerid, gPlayerData[playerid][E_SYNC_PLA][1]);
	SetPlayerSkin(playerid, gPlayerData[playerid][E_SYNC_SKIN]);
	SetPlayerVirtualWorld(playerid, gPlayerData[playerid][E_SYNC_WORLD]);
	SetPlayerInterior(playerid, gPlayerData[playerid][E_SYNC_INTERIOR]);
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, gPlayerData[playerid][E_SYNC_CASH]);
	gPlayerData[playerid][E_SYNC_NEED] = false;
	SendClientMessage(playerid, COLOR_YELLOW, "Successfully Syncohized.");
}
public OnVehicleDeath(vehicleid, killerid){
    gVehicleData[vehicleid][E_VEHICLE_LABELLED] = false;
	Delete3DTextLabel(gVehicleData[vehicleid][E_VEHICLE_INFO]);
	return 1;
}
CMD:dhud(playerid, params[]){
    if(gDebugHudShowing{playerid} == true){
		hideDebugBox(playerid);
		gDebugHudShowing{playerid} = false;
		SendClientMessage(playerid, COLOR_YELLOW, "Type /dhud to show this hud.");
	}
	else if(gDebugHudShowing{playerid} == false){
		showDebugBox(playerid);
		SendClientMessage(playerid, COLOR_YELLOW, "Type /dhud to hide this hud.");
		gDebugHudShowing{playerid} = true;
	}
	return 1;
}
CMD:info(playerid, params[]){
	ClearChat(playerid, 50);
	if(isnull(params)) SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /info [help/cmds/credits]");
	else if(strcmp(params, "help", true, 4) == 0){
	    SendClientMessage(playerid, COLOR_GREEN, "**** LorDebug - Help ****");
	    SendClientMessage(playerid, COLOR_YELLOW, "LorDebug (Lorenc Debug) is a Debugging filterscript");
	    SendClientMessage(playerid, COLOR_YELLOW, "devoloped by Lorenc and is more advanced then fsdebug");
	    SendClientMessage(playerid, COLOR_YELLOW, "which was contained on the sa-mp package. LorDebug");
	    SendClientMessage(playerid, COLOR_YELLOW, "Contains many features inside.");
	    SendClientMessage(playerid, COLOR_GREEN, "** Commands only for RCON: "#USE_RCON" **");
	}
	else if(strcmp(params, "cmds", true, 4) == 0){
	    SendClientMessage(playerid, COLOR_GREEN, "**** LorDebug - Commands ****");
	    SendClientMessage(playerid, COLOR_YELLOW, "/dhud, /v, /deletev, /sync, /gravity, /weather, /time");
	    SendClientMessage(playerid, COLOR_YELLOW, "/skin, /goto, /bring");
	}
	else if(strcmp(params, "credits", true, 4) == 0){
	    SendClientMessage(playerid, COLOR_GREEN, "**** LorDebug - Credits ****");
	    SendClientMessage(playerid, COLOR_YELLOW, "Lorenc - Creating whole script from scratch.");
	    SendClientMessage(playerid, COLOR_YELLOW, "Simon - Borrowed few codes off him.");
	}
	return 1;
}
CMD:goto(playerid, params[]){
	new
	    pID,
		Float: pos[3],
		string[128];

    #if USE_RCON == true
	if(!IsPlayerAdmin(playerid)) return 0;
    #endif
    if(sscanf(params, "u", pID)) SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /goto [playerid]");
    else if(pID == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED, "ERROR: Invalid Player ID!");
	else
	{
	    GetPlayerPos(pID, pos[0], pos[1], pos[2]);
	    SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	    format(string, sizeof(string), "You have teleported to %s.", ReturnPlayerName(pID));
	    SendClientMessage(playerid, COLOR_YELLOW, string);
	    format(string, sizeof(string), "%s has teleported to you.", ReturnPlayerName(playerid));
	    SendClientMessage(pID, COLOR_YELLOW, string);
	}
	return 1;
}
CMD:bring(playerid, params[]){
	new
	    pID,
		Float: pos[3],
		string[128];

    #if USE_RCON == true
	if(!IsPlayerAdmin(playerid)) return 0;
    #endif
    if(sscanf(params, "u", pID)) SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /bring [playerid]");
    else if(pID == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED, "ERROR: Invalid Player ID!");
	else{
	    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	    SetPlayerPos(pID, pos[0], pos[1], pos[2]);
	    format(string, sizeof(string), "You brought %s to you.", ReturnPlayerName(pID));
	    SendClientMessage(playerid, COLOR_YELLOW, string);
	    format(string, sizeof(string), "%s has brought you here.", ReturnPlayerName(playerid));
	    SendClientMessage(pID, COLOR_YELLOW, string);
	}
	return 1;
}
CMD:skin(playerid, params[]){
	new
		sID;
 	#if USE_RCON == true
	if(!IsPlayerAdmin(playerid)) return 0;
    #endif
    if(sscanf(params, "d", sID)) SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /skin [skinid]");
	else if(sID < 0 && sID > 299) return SendClientMessage(playerid, COLOR_RED, "ERROR: Invalid Skin!");
	else
    {
		SetPlayerSkin(playerid, sID);
  		SendClientMessage(playerid, COLOR_YELLOW, "You're Skin ID has been changed.");
    }
    return 1;
}
CMD:gravity(playerid, params[]){
	new
		Float: sGravity,
		string[128];
  	#if USE_RCON == true
	if(!IsPlayerAdmin(playerid)) return 0;
    #endif
	if(strcmp(params, "default", true, 4) == 0) SetGravity(0.008);
    else if(sscanf(params, "f", sGravity)) SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /gravity [gravity level/default]");
	else if(sGravity > 0 && sGravity < 0.001) return SendClientMessage(playerid, COLOR_RED, "ERROR: Invalid Gravity Level.");
	else
	{
	    SetGravity(sGravity);
	    format(string, sizeof(string), "Gravity has been set to: %0.3f", sGravity);
	    SendClientMessageToAll(COLOR_YELLOW, string);
	}
	return 1;
}
CMD:weather(playerid, params[]){
	new
		sWeather,
		string[128];
  	#if USE_RCON == true
	if(!IsPlayerAdmin(playerid)) return 0;
    #endif
    if(sscanf(params, "d", sWeather)) SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /weather [ID]");
	else if(sWeather < 0 && sWeather > 45) return SendClientMessage(playerid, COLOR_RED, "ERROR: Invalid Weather ID.");
	else{
	    SetWeather(sWeather);
	    format(string, sizeof(string), "Weather has been set to: %d", sWeather);
	    SendClientMessageToAll(COLOR_YELLOW, string);
	}
	return 1;
}
CMD:time(playerid, params[]){
	new
		sTime,
		string[128];
  	#if USE_RCON == true
	if(!IsPlayerAdmin(playerid)) return 0;
    #endif
    if(sscanf(params, "d", sTime)) SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /Time [time]");
	else if(sTime < 0 && sTime > 23) return SendClientMessage(playerid, COLOR_RED, "ERROR: Invalid Time.");
	else{
	    SetWorldTime(sTime);
	    format(string, sizeof(string), "World Time has been set to: %d", sTime);
	    SendClientMessageToAll(COLOR_YELLOW, string);
	}
	return 1;
}
CMD:v(playerid, params[]){
	new
	    vID,
		cCar;
	#if USE_RCON == true
	if(!IsPlayerAdmin(playerid)) return 0;
    #endif
	if(sscanf(params, "d", vID)) SendClientMessage(playerid, COLOR_YELLOW, "USAGE: /v [vehicleid]");
	else if(vID < 400 || vID > 611) return SendClientMessage(playerid, COLOR_RED, "ERROR: Invalid Vehicle ID.");
	else{
 		new
			Float: pos[3],
            Float: Angle,
			pWorld;
        GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
        GetPlayerFacingAngle(playerid, Angle);
		pWorld = GetPlayerVirtualWorld(playerid);
        cCar = CreateVehicle(vID, pos[0], pos[1], pos[2], Angle, 0, 0, pWorld);
        PutPlayerInVehicle(playerid, cCar, 0);
        SendClientMessage(playerid, COLOR_YELLOW, "You have created a vehicle.");
        new string[128], Float: vStatus, Float: vPos[3];
		GetVehiclePos(cCar, vPos[0], vPos[1], vPos[2]);
		GetVehicleHealth(cCar, vStatus);
		format(string, sizeof(string), 	"ID: %d, Model ID: %d\n \
										 X: %0.3f, Y: %0.3f, Z: %0.3f,\n \
										 Health: %0.1f",
										cCar, GetVehicleModel(cCar),
										vPos[0], vPos[1], vPos[2],
										vStatus);
		gVehicleData[cCar][E_VEHICLE_LABELLED] = true;
		gVehicleData[cCar][E_VEHICLE_INFO] = Create3DTextLabel(string, 0xFFFFFFFF, 0,0,0, 30.0, 0);
		Attach3DTextLabelToVehicle(gVehicleData[cCar][E_VEHICLE_INFO], cCar, 0.0, 0.0, 0.0);
	}
	return 1;
}
CMD:deletev(playerid, params[]){
    new cv = GetPlayerVehicleID(playerid);
    #if USE_RCON == true
	if(!IsPlayerAdmin(playerid)) return 0;
    #endif
	if(!IsPlayerInVehicle(playerid, cv)) return SendClientMessage(playerid, COLOR_RED, "ERROR: You need to be in a vehicle to use this command.");
	else{
		DestroyVehicle(cv);
		SendClientMessage(playerid, COLOR_YELLOW, "Vehicle destroyed!");
	}
	return 1;
}
CMD:sync(playerid, params[]){
	if(gPlayerData[playerid][E_SYNC_NEED] == true) return SendClientMessage(playerid, COLOR_RED, "ERROR: Syncing in progress!");
	else{
		SYNC(playerid);
	}
	return 1;
}
public OnPlayerUpdate(playerid){
	new
		string[128],
		Float:pos[3],
		Float:Player[2],
		ping,
		world, interior,
		wep[24], ammo
	;
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	GetPlayerHealth(playerid, Player[0]);
	GetPlayerArmour(playerid, Player[1]);
	ping = GetPlayerPing(playerid);
	interior = GetPlayerInterior(playerid);
	world = GetPlayerVirtualWorld(playerid);
	wep = ReturnWeaponName(GetPlayerWeapon(playerid));
	ammo = GetPlayerAmmo(playerid);
	if(gDebugHudShowing{playerid} == true)	{
	    format(string, sizeof(string), "~r~Position:~w~ ~n~ X: %0.3f, Y: %0.3f, Z: %0.3f ~n~ Interior: %d, World: %d", 	pos[0], pos[1], pos[2],
		TextDrawSetString(gTextDrawData[E_TEXTDRAW_DEBUG_POSITION][playerid], string);
		format(string, sizeof(string), "~n~~r~Player~w~ ~n~ Health: %0.1f, Armour: %0.1f, ~n~ Player ID: %d, Ping: %d, ~n~ Weapon: %s, Ammo: %d", Player[0],Player[1],
		TextDrawSetString(gTextDrawData[E_TEXTDRAW_DEBUG_PLAYER][playerid], string);
        showDebugBox(playerid);
	}
	format(string, sizeof(string), "%s(%d)\nPING:%d", ReturnPlayerName(playerid), playerid, GetPlayerPing(playerid));
 	Update3DTextLabelText(PlayerLabel{playerid}, 0xFFFFFFFF, string);
	return 1;
}
stock ReturnPlayerName(playerid){
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pname, sizeof(pname));
	return pname;
}
stock bool:IsSpawned(playerid){
	new pstate = GetPlayerState(playerid);
	if((pstate >= PLAYER_STATE_ONFOOT && pstate <= PLAYER_STATE_ENTER_VEHICLE_PASSENGER) || pstate == PLAYER_STATE_SPAWNED) return true;
	return false;
}
SYNC(playerid){
	new Float:pos[3], Float:pla[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	GetPlayerHealth(playerid, pla[0]);
	GetPlayerArmour(playerid, pla[1]);
	GetPlayerWeaponData(playerid, 1, gPlayerData[playerid][E_SYNC_GUN][0], gPlayerData[playerid][E_SYNC_AMMO][0]);
	GetPlayerWeaponData(playerid, 2, gPlayerData[playerid][E_SYNC_GUN][1], gPlayerData[playerid][E_SYNC_AMMO][1]);
	GetPlayerWeaponData(playerid, 3, gPlayerData[playerid][E_SYNC_GUN][2], gPlayerData[playerid][E_SYNC_AMMO][2]);
	GetPlayerWeaponData(playerid, 4, gPlayerData[playerid][E_SYNC_GUN][3], gPlayerData[playerid][E_SYNC_AMMO][3]);
	GetPlayerWeaponData(playerid, 5, gPlayerData[playerid][E_SYNC_GUN][4], gPlayerData[playerid][E_SYNC_AMMO][4]);
	GetPlayerWeaponData(playerid, 6, gPlayerData[playerid][E_SYNC_GUN][5], gPlayerData[playerid][E_SYNC_AMMO][5]);
	GetPlayerWeaponData(playerid, 7, gPlayerData[playerid][E_SYNC_GUN][6], gPlayerData[playerid][E_SYNC_AMMO][6]);
	GetPlayerWeaponData(playerid, 8, gPlayerData[playerid][E_SYNC_GUN][7], gPlayerData[playerid][E_SYNC_AMMO][7]);
	GetPlayerWeaponData(playerid, 9, gPlayerData[playerid][E_SYNC_GUN][8], gPlayerData[playerid][E_SYNC_AMMO][8]);
	GetPlayerWeaponData(playerid, 10, gPlayerData[playerid][E_SYNC_GUN][9], gPlayerData[playerid][E_SYNC_AMMO][9]);
	GetPlayerWeaponData(playerid, 11, gPlayerData[playerid][E_SYNC_GUN][10], gPlayerData[playerid][E_SYNC_AMMO][10]);
	GetPlayerWeaponData(playerid, 12, gPlayerData[playerid][E_SYNC_GUN][11], gPlayerData[playerid][E_SYNC_AMMO][11]);
	gPlayerData[playerid][E_SYNC_POS][0] = 		pos[0];
	gPlayerData[playerid][E_SYNC_POS][1] = 		pos[1];
	gPlayerData[playerid][E_SYNC_POS][2] = 		pos[2];
	gPlayerData[playerid][E_SYNC_PLA][0] = 		pla[0];
	gPlayerData[playerid][E_SYNC_PLA][1] = 		pla[1];
	gPlayerData[playerid][E_SYNC_WORLD] = 		GetPlayerVirtualWorld(playerid);
	gPlayerData[playerid][E_SYNC_INTERIOR] = 	GetPlayerInterior(playerid);
	gPlayerData[playerid][E_SYNC_SKIN] =        GetPlayerSkin(playerid);
	gPlayerData[playerid][E_SYNC_CASH] =        GetPlayerMoney(playerid);
	gPlayerData[playerid][E_SYNC_NEED] =        true;
	SpawnPlayer(playerid);
	ClearChat(playerid, 50);
}
hideDebugBox(playerid){
    TextDrawHideForPlayer(playerid, gTextDrawData[E_TEXTDRAW_DEBUG_BOX][playerid]);
    TextDrawHideForPlayer(playerid, gTextDrawData[E_TEXTDRAW_DEBUG_POSITION][playerid]);
	TextDrawHideForPlayer(playerid, gTextDrawData[E_TEXTDRAW_DEBUG_PLAYER][playerid]);
	TextDrawHideForPlayer(playerid, gTextDrawData[E_TEXTDRAW_DEBUG_HIDE][playerid]);
}
showDebugBox(playerid){
    TextDrawShowForPlayer(playerid, gTextDrawData[E_TEXTDRAW_DEBUG_BOX][playerid]);
    TextDrawShowForPlayer(playerid, gTextDrawData[E_TEXTDRAW_DEBUG_POSITION][playerid]);
	TextDrawShowForPlayer(playerid, gTextDrawData[E_TEXTDRAW_DEBUG_PLAYER][playerid]);
	TextDrawShowForPlayer(playerid, gTextDrawData[E_TEXTDRAW_DEBUG_HIDE][playerid]);
}
loadTextDraws(playerid){
	gTextDrawData[E_TEXTDRAW_DEBUG_BOX][playerid] = TextDrawCreate(534.000000, 317.000000, "~y~Debug~n~~n~~n~~n~~n~");
	TextDrawAlignment(gTextDrawData[E_TEXTDRAW_DEBUG_BOX][playerid], 2);
	TextDrawBackgroundColor(gTextDrawData[E_TEXTDRAW_DEBUG_BOX][playerid], 255);
	TextDrawFont(gTextDrawData[E_TEXTDRAW_DEBUG_BOX][playerid], 0);
	TextDrawLetterSize(gTextDrawData[E_TEXTDRAW_DEBUG_BOX][playerid], 0.559998, 1.899999);
	TextDrawColor(gTextDrawData[E_TEXTDRAW_DEBUG_BOX][playerid], -1);
	TextDrawSetOutline(gTextDrawData[E_TEXTDRAW_DEBUG_BOX][playerid], 0);
	TextDrawSetProportional(gTextDrawData[E_TEXTDRAW_DEBUG_BOX][playerid], 1);
	TextDrawSetShadow(gTextDrawData[E_TEXTDRAW_DEBUG_BOX][playerid], 1);
	TextDrawUseBox(gTextDrawData[E_TEXTDRAW_DEBUG_BOX][playerid], 1);
	TextDrawBoxColor(gTextDrawData[E_TEXTDRAW_DEBUG_BOX][playerid], 255);
	TextDrawTextSize(gTextDrawData[E_TEXTDRAW_DEBUG_BOX][playerid], 259.000000, 161.000000);
	gTextDrawData[E_TEXTDRAW_DEBUG_POSITION][playerid] = TextDrawCreate(459.000000, 339.000000, "Position: ~n~ X: 00000000, Y: 0000000, Z: 00000000");
	TextDrawBackgroundColor(gTextDrawData[E_TEXTDRAW_DEBUG_POSITION][playerid], 255);
	TextDrawFont(gTextDrawData[E_TEXTDRAW_DEBUG_POSITION][playerid], 2);
	TextDrawLetterSize(gTextDrawData[E_TEXTDRAW_DEBUG_POSITION][playerid], 0.170000, 0.899999);
	TextDrawColor(gTextDrawData[E_TEXTDRAW_DEBUG_POSITION][playerid], -1);
	TextDrawSetOutline(gTextDrawData[E_TEXTDRAW_DEBUG_POSITION][playerid], 0);
	TextDrawSetProportional(gTextDrawData[E_TEXTDRAW_DEBUG_POSITION][playerid], 1);
	TextDrawSetShadow(gTextDrawData[E_TEXTDRAW_DEBUG_POSITION][playerid], 1);
	gTextDrawData[E_TEXTDRAW_DEBUG_PLAYER][playerid] = TextDrawCreate(459.000000, 356.000000, "Player ~n~ Health: 100.0 Armour 100.0 ~n~ Player ID: 100 Ping: 1000 FPS: 100");
	TextDrawBackgroundColor(gTextDrawData[E_TEXTDRAW_DEBUG_PLAYER][playerid], 255);
	TextDrawFont(gTextDrawData[E_TEXTDRAW_DEBUG_PLAYER][playerid], 2);
	TextDrawLetterSize(gTextDrawData[E_TEXTDRAW_DEBUG_PLAYER][playerid], 0.170000, 0.899999);
	TextDrawColor(gTextDrawData[E_TEXTDRAW_DEBUG_PLAYER][playerid], -1);
	TextDrawSetOutline(gTextDrawData[E_TEXTDRAW_DEBUG_PLAYER][playerid], 0);
	TextDrawSetProportional(gTextDrawData[E_TEXTDRAW_DEBUG_PLAYER][playerid], 1);
	TextDrawSetShadow(gTextDrawData[E_TEXTDRAW_DEBUG_PLAYER][playerid], 1);
	gTextDrawData[E_TEXTDRAW_DEBUG_HIDE][playerid] = TextDrawCreate(490.000000, 410.000000, "~g~/dhud to hide this.");
	TextDrawBackgroundColor(gTextDrawData[E_TEXTDRAW_DEBUG_HIDE][playerid], 255);
	TextDrawFont(gTextDrawData[E_TEXTDRAW_DEBUG_HIDE][playerid], 2);
	TextDrawLetterSize(gTextDrawData[E_TEXTDRAW_DEBUG_HIDE][playerid], 0.230000, 0.899999);
	TextDrawColor(gTextDrawData[E_TEXTDRAW_DEBUG_HIDE][playerid], -1);
	TextDrawSetOutline(gTextDrawData[E_TEXTDRAW_DEBUG_HIDE][playerid], 0);
	TextDrawSetProportional(gTextDrawData[E_TEXTDRAW_DEBUG_HIDE][playerid], 1);
	TextDrawSetShadow(gTextDrawData[E_TEXTDRAW_DEBUG_HIDE][playerid], 1);
}
stock ReturnWeaponName(weaponid){
	new wname[20];
	switch(weaponid){
	    case 0: wname = "Fist";
		case 18: wname = "Molotovs";
		case 40: wname = "Detonator";
		case 44: wname = "Nightvision Goggles";
		case 45: wname = "Thermal Goggles";
		default: GetWeaponName(weaponid, wname, sizeof(wname));
	}
	return wname;
}
stock ReturnMonth(Month){
    new MonthStr[15];
    switch(Month){
        case 1:  MonthStr = "January";
        case 2:  MonthStr = "February";
        case 3:  MonthStr = "March";
        case 4:  MonthStr = "April";
        case 5:  MonthStr = "May";
        case 6:  MonthStr = "June";
        case 7:  MonthStr = "July";
        case 8:  MonthStr = "August";
        case 9:  MonthStr = "September";
        case 10: MonthStr = "October";
        case 11: MonthStr = "November";
        case 12: MonthStr = "December";
    }
    return MonthStr;
}
stock AddLogLine( player[], file[], input[] ){
    new string[128];
    format(string, 128, "%s: %s\r\n", player, input);
    new File:fhandle;
    if(fexist(file)){
        printf("Creating file '%s' because theres no file created with that name.", file);
    }
    fhandle = fopen(file,io_append);
    fwrite(fhandle,string);
    fclose(fhandle);
    return 1;
}
stock ClearChat(playerid, lines){
	for(new i = 0; i < lines; i++){
	    SendClientMessage(playerid, 0x0, "");
	}
}
stock IsVehicleSpawned(vehicleid){
    new Float:VX, Float:VY, Float:VZ;
    GetVehiclePos(vehicleid, VX, VY, VZ);
    if (VX == 0.0 && VY == 0.0 && VZ == 0.0) return 0;
    return 1;
}
