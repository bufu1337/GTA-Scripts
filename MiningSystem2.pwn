#define 	FILTERSCRIPT
#include 	<a_samp>
#include    <evf>			// http://forum.sa-mp.com/showthread.php?t=486060
#include    <progress2>		// http://forum.sa-mp.com/showthread.php?t=537468
#include    <streamer>		// http://forum.sa-mp.com/showthread.php?t=102865
#include    <izcmd>			// http://forum.sa-mp.com/showthread.php?t=576114

#define     MAX_ORE_TYPES   (6)
#define     MAX_VEINS       (128)
#define     MAX_ORES        (256)

#define     UPDATE_RATE     (200)		// update rate of mining in miliseconds, higher the value longer the mining time (default: 200)
#define     BAR_MAX         (15.0)		// maximum value of the progress bar, higher the value longer the mining time (default: 15.0)
#define     VEHICLE_LIMIT   (8)			// how many ores someone can store in their vehicle (default: 8)
#define     ATTACH_INDEX    (3)			// setplayerattachedobject index

#define     REGEN_TIME    	(45)        // how many minutes before respawning veins (default: 45)
#define     ORE_TIME        (5)         // how many minutes before destroying a dropped ore (default: 5)

enum    e_ores
{
	Name[16],
	Color,
	Float: Modifier,
	Amount, // how many of this ore spawns in a vein
	Value, // value of this ore
	Rate // successful mining rate
}

enum    e_veins
{
	Type,
	Amount,
	bool: BeingMined,
	VeinObject,
	Text3D: VeinLabel,
	bool: VeinExists
}

enum    e_dialogs
{
    DIALOG_ORE_INFO = 18740,
    DIALOG_ORE_TAKE
}

enum    e_droppedores
{
	Type,
	OreTimer,
	OreObject,
	Text3D: OreLabel,
	bool: OreExists
}

enum    e_droppoints
{
	Location[32],
	Float: PointX,
	Float: PointY,
	Float: PointZ,
	PointCP,
	Text3D: PointLabel
}

new
	OreData[MAX_ORE_TYPES][e_ores] = {
	// name, color, modifier, spawn amount, value, mining rate
	    {"Copper", 0xB87333FF, 0.75, 8, 350, 65},
	    {"Amethyst", 0x9B59B6FF, 0.60, 6, 450, 58},
	    {"Emerald", 0x2ECC71FF, 0.40, 4, 750, 50},
		{"Ruby", 0xD10056FF, 0.35, 3, 800, 55},
		{"Sapphire", 0x0F52BAFF, 0.30, 3, 850, 45},
        {"Gold", 0xFFD700FF, 0.25, 4, 1000, 40}
	};

new
	VeinData[MAX_VEINS][e_veins],
	DroppedOres[MAX_ORES][e_droppedores];

new
	MiningVein[MAX_PLAYERS] = {-1, ...},
	MiningTimer[MAX_PLAYERS] = {-1, ...},
	CarryingOre[MAX_PLAYERS] = {-1, ...},
	LoadingPoint[MAX_PLAYERS] = {-1, ...},
	PlayerBar: MiningBar[MAX_PLAYERS] = {INVALID_PLAYER_BAR_ID, ...};

new
	LoadedOres[MAX_VEHICLES][MAX_ORE_TYPES];

new
	DropPoints[][e_droppoints] = {
	// location, x, y, z
	    {"Las Venturas", 2489.462646, 2773.271240, 10.789896},
		{"San Fierro", -1823.034057, 2.284350, 15.117187},
		{"Los Santos", 2660.815673, -1433.876098, 30.050680}
	};

new
    PointIcons[MAX_PLAYERS][sizeof(DropPoints)];

// Vehicle Functions
Vehicle_LoadedOres(vehicleid)
{
	if(!IsValidVehicle(vehicleid)) return -1;
	new count = 0;
	for(new i; i < MAX_ORE_TYPES; i++) count += LoadedOres[vehicleid][i];
	return count;
}

Vehicle_GetOreValue(vehicleid)
{
    if(!IsValidVehicle(vehicleid)) return -1;
	new value = 0;
	for(new i; i < MAX_ORE_TYPES; i++) value += (LoadedOres[vehicleid][i] * OreData[i][Value]);
	return value;
}

Vehicle_GetOreValueByType(vehicleid, type)
{
    if(!IsValidVehicle(vehicleid)) return -1;
	return (LoadedOres[vehicleid][type] * OreData[type][Value]);
}

Vehicle_CleanUp(vehicleid)
{
    if(!IsValidVehicle(vehicleid)) return -1;
    for(new i; i < MAX_ORE_TYPES; i++) LoadedOres[vehicleid][i] = 0;
	return 1;
}

Vehicle_IsMiningVehicle(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
	    case 414, 455, 456, 498, 499, 609: return 1;
	    default: return 0;
	}

	return 0;
}

// Player Functions
Player_Init(playerid)
{
	MiningVein[playerid] = -1;
	MiningTimer[playerid] = -1;
	CarryingOre[playerid] = -1;
	LoadingPoint[playerid] = -1;
	MiningBar[playerid] = CreatePlayerProgressBar(playerid, 498.0, 104.0, 113.0, 6.2, -1429936641, BAR_MAX, 0);
	for(new i; i < sizeof(DropPoints); i++)
	{
		TogglePlayerDynamicCP(playerid, DropPoints[i][PointCP], 0);
		PointIcons[playerid][i] = -1;
	}

	return 1;
}

Player_CleanUp(playerid, ore = 0)
{
    if(MiningVein[playerid] != -1)
	{
		VeinData[ MiningVein[playerid] ][BeingMined] = false;
        Vein_Update(MiningVein[playerid]);
        ClearAnimations(playerid);
        TogglePlayerControllable(playerid, 1);
        MiningVein[playerid] = -1;
	}

	if(MiningTimer[playerid] != -1)
	{
	    KillTimer(MiningTimer[playerid]);
		MiningTimer[playerid] = -1;
	}

	if(ore && CarryingOre[playerid] != -1)
	{
	    CarryingOre[playerid] = -1;
	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	}

	if(ore && LoadingPoint[playerid] != -1)
	{
	    DestroyDynamicCP(LoadingPoint[playerid]);
	    LoadingPoint[playerid] = -1;
	}

	if(IsPlayerAttachedObjectSlotUsed(playerid, ATTACH_INDEX)) RemovePlayerAttachedObject(playerid, ATTACH_INDEX);
	SetPlayerProgressBarValue(playerid, MiningBar[playerid], 0.0);
	HidePlayerProgressBar(playerid, MiningBar[playerid]);
	return 1;
}

Player_GetClosestVein(playerid, Float: range = 3.0)
{
	new id = -1, Float: dist = range, Float: tempdist, Float: pos[3];
	for(new i; i < MAX_VEINS; i++)
	{
	    if(!VeinData[i][VeinExists]) continue;
	    GetDynamicObjectPos(VeinData[i][VeinObject], pos[0], pos[1], pos[2]);
	    tempdist = GetPlayerDistanceFromPoint(playerid, pos[0], pos[1], pos[2]);

	    if(tempdist > range) continue;
		if(tempdist <= dist)
		{
			dist = tempdist;
			id = i;
		}
	}

	return id;
}

Player_GetClosestOre(playerid, Float: range = 3.0)
{
	new id = -1, Float: dist = range, Float: tempdist, Float: pos[3];
	for(new i; i < MAX_ORES; i++)
	{
	    if(!DroppedOres[i][OreExists]) continue;
	    GetDynamicObjectPos(DroppedOres[i][OreObject], pos[0], pos[1], pos[2]);
	    tempdist = GetPlayerDistanceFromPoint(playerid, pos[0], pos[1], pos[2]);

	    if(tempdist > range) continue;
		if(tempdist <= dist)
		{
			dist = tempdist;
			id = i;
		}
	}

	return id;
}

Player_GiveOre(playerid, type, cooldown = 0)
{
    CarryingOre[playerid] = type;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	SetPlayerAttachedObject(playerid, ATTACH_INDEX, 2936, 5, 0.105, 0.086, 0.22, -80.3, 3.3, 28.7, 0.35, 0.35, 0.35, RGBAToARGB(OreData[type][Color]));
	SetPVarInt(playerid, "LoadingCooldown", gettime() + cooldown);

	new Float: x, Float: y, Float: z;
    GetVehicleBoot(GetPVarInt(playerid, "LastVehicleID"), x, y, z);
    LoadingPoint[playerid] = CreateDynamicCP(x, y, z, 3.0, .playerid = playerid);
    SendClientMessage(playerid, 0x2ECC71FF, "MINING: {FFFFFF}You can press N to drop your ore.");
	return 1;
}

// Vein Functions
Vein_Update(id)
{
	new label[64], type = VeinData[id][Type], bool: is_red = false;
	if(VeinData[id][BeingMined] || VeinData[id][Amount] < 1) is_red = true;
	format(label, sizeof(label), "%s\n%d/%d%s\n\n/ore info - /ore mine", OreData[type][Name], VeinData[id][Amount], OreData[type][Amount], (is_red) ? ("{E74C3C}") : ("{FFFFFF}"));
	UpdateDynamic3DTextLabelText(VeinData[id][VeinLabel], OreData[type][Color], label);
	return 1;
}

Float: Vein_CalculateTime(id)
	return (BAR_MAX / OreData[ VeinData[id][Type] ][Modifier]) * UPDATE_RATE;

// Ore Functions
Ore_FindFreeID()
{
	new id = -1;
	for(new i; i < MAX_ORES; i++)
	{
	    if(!DroppedOres[i][OreExists])
	    {
	        id = i;
	        break;
	    }
	}

	return id;
}

// http://forum.sa-mp.com/showpost.php?p=3117531&postcount=5
RGBAToARGB(rgba)
    return rgba >>> 8 | rgba << 24;

// edited from evf
GetNearestVehicleEx(playerid, Float: range = 6.5)
{
 	new Float: fX, Float: fY, Float: fZ, Float: fSX, Float: fSY, Float: fSZ;

	for (new i = 1, j = GetVehiclePoolSize(); i <= j; i ++)
	{
	    if (!IsVehicleStreamedIn(i, playerid)) continue;
		GetVehiclePos(i, fX, fY, fZ);
		GetVehicleModelInfo(GetVehicleModel(i), VEHICLE_MODEL_INFO_SIZE, fSX, fSY, fSZ);
		if(IsPlayerInRangeOfPoint(playerid, range, fX, fY, fZ) && GetPlayerInterior(playerid) == GetVehicleInterior(i) && GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(i)) return i;
	}

	return INVALID_VEHICLE_ID;
}

public OnFilterScriptInit()
{
	Vein_Generate();
	SetTimer("Vein_Generate", REGEN_TIME * 60000, true);

	new label[128];
	for(new i; i < sizeof(DropPoints); i++)
	{
	    format(label, sizeof(label), "Ore Drop Point - %s\n\n{FFFFFF}Bring your ores here to get money!", DropPoints[i][Location]);
		DropPoints[i][PointLabel] = CreateDynamic3DTextLabel(label, 0xF1C40FFF, DropPoints[i][PointX], DropPoints[i][PointY], DropPoints[i][PointZ] + 0.5, 15.0, .testlos = 1);
		DropPoints[i][PointCP] = CreateDynamicCP(DropPoints[i][PointX], DropPoints[i][PointY], DropPoints[i][PointZ], 6.0);
	}

	for(new i, pool = GetPlayerPoolSize(); i <= pool; i++)
	{
	    if(!IsPlayerConnected(i)) continue;
	    Player_Init(i);
	}

	return 1;
}

public OnFilterScriptExit()
{
	for(new i, pool = GetPlayerPoolSize(); i <= pool; i++)
	{
	    if(!IsPlayerConnected(i)) continue;
	    Player_CleanUp(i, 1);
	    if(IsValidPlayerProgressBar(i, MiningBar[i])) DestroyPlayerProgressBar(i, MiningBar[i]);
	}

	return 1;
}

public OnPlayerConnect(playerid)
{
    Player_Init(playerid);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(Vehicle_LoadedOres(vehicleid) > 0)
	    {
	        new string[128];
	        format(string, sizeof(string), "MINING: {FFFFFF}This vehicle has {F39C12}%d {FFFFFF}ores loaded which is worth {2ECC71}$%d.", Vehicle_LoadedOres(vehicleid), Vehicle_GetOreValue(vehicleid));
			SendClientMessage(playerid, 0x2ECC71FF, string);
			SendClientMessage(playerid, 0x2ECC71FF, "MINING: {FFFFFF}You can sell your loaded ores to drop points marked by a truck icon.");
			SendClientMessage(playerid, 0x2ECC71FF, "MINING: {FFFFFF}You can use /vehicle to see more information.");
			for(new i; i < sizeof(DropPoints); i++)
			{
			    PointIcons[playerid][i] = CreateDynamicMapIcon(DropPoints[i][PointX], DropPoints[i][PointY], DropPoints[i][PointZ], 51, 0, _, _, playerid, 8000.0, MAPICON_GLOBAL);
				TogglePlayerDynamicCP(playerid, DropPoints[i][PointCP], 1);
			}
	    }

		SetPVarInt(playerid, "LastVehicleID", vehicleid);
	}

	if(oldstate == PLAYER_STATE_DRIVER)
	{
		for(new i; i < sizeof(DropPoints); i++)
		{
		    if(IsValidDynamicMapIcon(PointIcons[playerid][i]))
		    {
		        DestroyDynamicMapIcon(PointIcons[playerid][i]);
		        PointIcons[playerid][i] = -1;
		    }

			TogglePlayerDynamicCP(playerid, DropPoints[i][PointCP], 0);
		}
	}

	Player_CleanUp(playerid, 1);
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys & KEY_NO) && CarryingOre[playerid] != -1)
	{
		new id = Ore_FindFreeID();
		if(id != -1)
		{
		    if(Player_GetClosestOre(playerid, 1.5) != -1) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You can't drop your ore here.");
		    new label[48], type = CarryingOre[playerid], Float: x, Float: y, Float: z, Float: a;
		    GetPlayerPos(playerid, x, y, z);
		    GetPlayerFacingAngle(playerid, a);
		    x += (1.25 * floatsin(-a, degrees));
			y += (1.25 * floatcos(-a, degrees));

		    DroppedOres[id][Type] = type;
			DroppedOres[id][OreTimer] = SetTimerEx("Ore_Destroy", ORE_TIME * 60000, false, "i", id);
		    DroppedOres[id][OreObject] = CreateDynamicObject(3929, x, y, z - 0.65, 0.0, 0.0, random(360));
	  		SetDynamicObjectMaterial(DroppedOres[id][OreObject], 0, 2936, "kmb_rckx", "larock256", RGBAToARGB(OreData[type][Color]));
			format(label, sizeof(label), "%s Ore\n{FFFFFF}\n\n/ore take", OreData[type][Name]);
	  		DroppedOres[id][OreLabel] = CreateDynamic3DTextLabel(label, OreData[type][Color], x, y, z, 5.0, .testlos = 1);
		    DroppedOres[id][OreExists] = true;
		}

	    ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 1, 1, 0, 0, 1);
		Player_CleanUp(playerid, 1);
	}

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	Player_CleanUp(playerid, 1);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
    Vehicle_CleanUp(vehicleid);
	return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if(checkpointid == LoadingPoint[playerid])
	{
	    if(GetPVarInt(playerid, "LoadingCooldown") > gettime()) return 1;
		new vehicleid = GetPVarInt(playerid, "LastVehicleID");
		if(Vehicle_LoadedOres(vehicleid) >= VEHICLE_LIMIT) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You can't load any more ores to this vehicle.");
		LoadedOres[vehicleid][ CarryingOre[playerid] ]++;

		new string[48];
		format(string, sizeof(string), "MINING: {FFFFFF}Loaded %s.", OreData[ CarryingOre[playerid] ][Name]);
		SendClientMessage(playerid, 0x2ECC71FF, string);
		ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 1, 1, 0, 0, 1);
		Player_CleanUp(playerid, 1);
		return 1;
	}

	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		for(new i; i < sizeof(DropPoints); i++)
		{
		    if(checkpointid == DropPoints[i][PointCP])
		    {
		        new string[128], vehicleid = GetPlayerVehicleID(playerid), cash = Vehicle_GetOreValue(vehicleid);
		        format(string, sizeof(string), "MINING: {FFFFFF}Sold {F39C12}%d {FFFFFF}ores and earned {2ECC71}$%d.", Vehicle_LoadedOres(vehicleid), cash);
		        SendClientMessage(playerid, 0x2ECC71FF, string);
		        GivePlayerMoney(playerid, cash);
		        Vehicle_CleanUp(vehicleid);

		        for(new x; x < sizeof(DropPoints); x++)
				{
				    if(IsValidDynamicMapIcon(PointIcons[playerid][x]))
				    {
				        DestroyDynamicMapIcon(PointIcons[playerid][x]);
				        PointIcons[playerid][x] = -1;
				    }

					TogglePlayerDynamicCP(playerid, DropPoints[x][PointCP], 0);
				}

		        break;
		    }
		}
	}

	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
	{
		case DIALOG_ORE_TAKE:
		{
		    if(!response) return 1;
		    if(MiningVein[playerid] != -1) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're already mining.");
			if(CarryingOre[playerid] != -1) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're already carrying an ore.");
			new id = GetNearestVehicleEx(playerid);
			if(!IsValidVehicle(id)) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're not near any vehicle.");
			new Float: x, Float: y, Float: z;
			GetVehicleBoot(id, x, y, z);
			if(GetPlayerDistanceFromPoint(playerid, x, y, z) > 3.0) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're not near the vehicle's back.");
			if(LoadedOres[id][listitem] < 1) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}This vehicle doesn't have that ore loaded.");
			LoadedOres[id][listitem]--;
			Player_GiveOre(playerid, listitem, 2);
		}
	}

    return 0;
}

CMD:vehicle(playerid, params[])
{
    if(isnull(params)) return SendClientMessage(playerid, 0xE88732FF, "USAGE: {FFFFFF}/vehicle [ores/take]");
    if(!strcmp(params, "ores", true)) {
        new vehicleid = GetNearestVehicleEx(playerid);
        if(!IsValidVehicle(vehicleid)) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're not near any vehicle.");
        if(!Vehicle_IsMiningVehicle(vehicleid)) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}Vehicle isn't a mining vehicle.");
        new string[196], title[32];
		format(string, sizeof(string), "Name\tAmount\tValue\n");
        for(new i; i < MAX_ORE_TYPES; i++) format(string, sizeof(string), "%s%s\t%d\t{2ECC71}$%d\n", string, OreData[i][Name], LoadedOres[vehicleid][i], Vehicle_GetOreValueByType(vehicleid, i));
		format(title, sizeof(title), "Loaded Ores {E74C3C}(%d/%d)", Vehicle_LoadedOres(vehicleid), VEHICLE_LIMIT);
		ShowPlayerDialog(playerid, DIALOG_ORE_INFO, DIALOG_STYLE_TABLIST_HEADERS, title, string, "Close", "");
    }else if(!strcmp(params, "take")) {
        if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You can't do this in a vehicle.");
		if(MiningVein[playerid] != -1) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're already mining.");
		if(CarryingOre[playerid] != -1) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're already carrying an ore.");
		new id = GetNearestVehicleEx(playerid);
		if(!IsValidVehicle(id)) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're not near any vehicle.");
        if(!Vehicle_IsMiningVehicle(id)) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}Vehicle isn't a mining vehicle.");
		new Float: x, Float: y, Float: z;
		GetVehicleBoot(id, x, y, z);
		if(GetPlayerDistanceFromPoint(playerid, x, y, z) > 3.0) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're not near the vehicle's back.");
        new string[196], title[32];
		format(string, sizeof(string), "Name\tAmount\n");
        for(new i; i < MAX_ORE_TYPES; i++) format(string, sizeof(string), "%s%s\t%d\n", string, OreData[i][Name], LoadedOres[id][i]);
		format(title, sizeof(title), "Loaded Ores {E74C3C}(%d/%d)", Vehicle_LoadedOres(id), VEHICLE_LIMIT);
		ShowPlayerDialog(playerid, DIALOG_ORE_TAKE, DIALOG_STYLE_TABLIST_HEADERS, title, string, "Take", "Close");
    }

	return 1;
}

CMD:ore(playerid, params[])
{
    if(isnull(params)) return SendClientMessage(playerid, 0xE88732FF, "USAGE: {FFFFFF}/ore [info/mine/take]");
    if(!strcmp(params, "info", true)) {
		new id = Player_GetClosestVein(playerid);
		if(id == -1) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're not near a vein.");
        new string[128], type = VeinData[id][Type];
        format(string, sizeof(string), "Name\t{%06x}%s\nValue\t{2ECC71}$%d\nVein Value\t{2ECC71}$%d\nMining Time\t%.2f seconds", OreData[type][Color] >>> 8, OreData[type][Name], OreData[type][Value], (OreData[type][Value] * VeinData[id][Amount]), Vein_CalculateTime(id) / 1000);
		ShowPlayerDialog(playerid, DIALOG_ORE_INFO, DIALOG_STYLE_TABLIST, "Ore Information", string, "Close", "");
    }else if(!strcmp(params, "mine")) {
        if(!Vehicle_IsMiningVehicle(GetPVarInt(playerid, "LastVehicleID"))) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}Your last vehicle isn't available for mining.");
		if(MiningVein[playerid] != -1) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're already mining.");
		if(CarryingOre[playerid] != -1) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're already carrying an ore.");
		new id = Player_GetClosestVein(playerid);
		if(id == -1) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're not near any veins.");
		if(VeinData[id][BeingMined]) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}The vein you want to mine is being mined by someone else.");
		if(VeinData[id][Amount] < 1) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}The vein you want to mine is empty.");
		new Float: x, Float: y, Float: z;
		GetVehicleBoot(GetPVarInt(playerid, "LastVehicleID"), x, y, z);
		if(GetPlayerDistanceFromPoint(playerid, x, y, z) > 60.0) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}Your last vehicle is too far away.");
		MiningVein[playerid] = id;

		MiningTimer[playerid] = SetTimerEx("Player_Mine", UPDATE_RATE, true, "i", playerid);
		SetPlayerProgressBarColour(playerid, MiningBar[playerid], OreData[ VeinData[id][Type] ][Color]);
		SetPlayerProgressBarValue(playerid, MiningBar[playerid], 0.0);
		ShowPlayerProgressBar(playerid, MiningBar[playerid]);
		SetPlayerAttachedObject(playerid, ATTACH_INDEX, 19631, 6, 0.048, 0.029, 0.103, -80.0, 80.0, 0.0);
		TogglePlayerControllable(playerid, 0);
		SetPlayerArmedWeapon(playerid, 0);
		ApplyAnimation(playerid, "BASEBALL", "Bat_1", 4.1, 1, 0, 0, 1, 0, 1);

		new string[64];
		format(string, sizeof(string), "~n~~y~~h~Mining %s...", OreData[ VeinData[id][Type] ][Name]);
	    GameTextForPlayer(playerid, string, floatround(Vein_CalculateTime(id)) + 1000, 3);

		VeinData[id][BeingMined] = true;
		Vein_Update(id);
    }else if(!strcmp(params, "take")) {
        if(!Vehicle_IsMiningVehicle(GetPVarInt(playerid, "LastVehicleID"))) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}Your last vehicle isn't available for mining.");
		if(MiningVein[playerid] != -1) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're already mining.");
		if(CarryingOre[playerid] != -1) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're already carrying an ore.");
		new id = Player_GetClosestOre(playerid);
		if(id == -1) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're not near any ores.");
		new Float: x, Float: y, Float: z;
		GetVehicleBoot(GetPVarInt(playerid, "LastVehicleID"), x, y, z);
		if(GetPlayerDistanceFromPoint(playerid, x, y, z) > 60.0) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}Your last vehicle is too far away.");
		Player_GiveOre(playerid, DroppedOres[id][Type]);
		Ore_Destroy(id);
    }

	return 1;
}

forward Vein_Generate();
public Vein_Generate()
{
    new Float: spawn_coords[][3] = {
        {670.500732, 926.557067, -41.475772},
		{678.838012, 925.259582, -41.473415},
		{673.852478, 922.303161, -41.548767},
		{679.489379, 917.357727, -41.276176},
		{673.862670, 914.984008, -41.207321},
		{666.973205, 921.626342, -41.613155},
		{686.447021, 913.041320, -40.560043},
		{679.475769, 910.190124, -41.048439},
		{689.223510, 906.631835, -40.269996},
		{683.865295, 905.557067, -40.672229},
		{685.984741, 899.446899, -40.296852},
		{694.975097, 902.076049, -39.668643},
		{692.622558, 896.177978, -39.817611},
		{697.621154, 891.354370, -39.355659},
		{687.311584, 891.855468, -40.107055},
		{692.106262, 887.992187, -39.684555},
		{690.451110, 879.733947, -40.143363},
		{696.097167, 882.666015, -39.491031},
		{694.623901, 872.130493, -41.227066},
		{693.549255, 862.414123, -43.129112},
		{688.462280, 868.132019, -42.136383},
		{688.172607, 857.167358, -43.610939},
		{667.181762, 819.235046, -43.610939},
		{663.166503, 811.138061, -43.610939},
		{654.977294, 812.527770, -43.610939},
		{651.793762, 805.835571, -43.610939},
		{660.028137, 820.449340, -43.610939},
		{646.762756, 814.375671, -43.610939},
		{643.352294, 808.098266, -43.610939},
		{637.106994, 812.568725, -43.610939},
		{630.459289, 810.016418, -43.610939},
		{624.303833, 813.422485, -43.610939},
		{615.880615, 812.158264, -43.610939},
		{610.537963, 815.100646, -43.603439},
		{603.759033, 817.793640, -43.646705},
		{597.451904, 822.874328, -43.579505},
		{605.012512, 823.405212, -43.728958},
		{618.658691, 818.265625, -43.603439},
		{580.120239, 931.571899, -43.610939},
		{569.243530, 928.569763, -43.610939},
		{560.821105, 926.251770, -43.610939},
		{576.770385, 923.246215, -43.610939},
		{567.994628, 919.691223, -43.610939},
		{575.571472, 916.415344, -43.664150},
		{569.872924, 912.386962, -43.610939},
		{587.315368, 913.924743, -43.796096},
		{582.004028, 910.695190, -43.892337},
		{560.253540, 909.118286, -43.610939},
		{560.626708, 917.773559, -43.610939},
		{530.954040, 909.995849, -43.610939},
		{611.991699, 933.569702, -40.581710},
		{609.077209, 922.338073, -42.479446},
		{608.724792, 927.748413, -41.762489},
		{649.643249, 928.250976, -39.830272},
		{653.457092, 922.054199, -41.079425},
		{644.637756, 922.242431, -41.463893},
		{647.455993, 914.794494, -42.107845},
		{657.229248, 914.974731, -41.061988},
		{590.929870, 838.788818, -43.386558},
		{600.051147, 841.034545, -44.017189},
		{590.187194, 846.630859, -43.336963},
		{582.725158, 843.719238, -43.011596},
		{576.576538, 849.726928, -43.056209},
		{573.548828, 844.638610, -42.740356},
		{566.613159, 843.542358, -42.616565},
		{559.421691, 840.400390, -42.141761},
		{552.358398, 837.908569, -41.532897},
		{562.215698, 848.450744, -42.990608},
		{553.209289, 843.931945, -42.226833},
		{545.759094, 836.563537, -41.645462},
		{546.358886, 844.129211, -42.148715},
		{553.752990, 849.901916, -42.900249},
		{539.853637, 845.818481, -42.563919},
		{528.839843, 843.820007, -43.529937},
		{533.157653, 848.349853, -43.296516},
		{520.944458, 846.692749, -43.610939},
		{526.440917, 850.654602, -43.610939},
		{536.822448, 852.424804, -43.107326},
		{546.298095, 850.573242, -42.897747},
		{551.512939, 879.981933, -43.265190},
		{559.212646, 886.721923, -43.916355},
		{566.831054, 885.784973, -44.073543},
		{574.826660, 883.917602, -44.008312},
		{573.601867, 877.364135, -44.474807},
		{573.405334, 865.376098, -43.900402},
		{566.972229, 867.566162, -44.025466},
		{566.110717, 875.090148, -44.276050},
		{559.155700, 867.633850, -43.972709},
		{552.657165, 871.074157, -43.586654},
		{590.525634, 884.257019, -44.786952},
		{581.356384, 885.243469, -44.612636},
		{595.025329, 891.404907, -45.047763},
		{601.949951, 893.569396, -45.066448},
		{599.344055, 887.141723, -44.512237},
		{597.956787, 880.352294, -43.925403},
		{597.799316, 872.847290, -43.639019},
		{603.701110, 881.868469, -43.749420},
		{609.776245, 877.436706, -43.610939},
		{609.780212, 888.589721, -44.169811},
		{609.496215, 894.040039, -44.493488},
		{615.364379, 883.519409, -43.610939},
		{616.436218, 866.841308, -43.610939},
		{624.843017, 869.950256, -43.603439},
		{620.875671, 875.108886, -43.603439},
		{631.959045, 874.122375, -43.603439},
		{626.006774, 879.856384, -43.610939},
		{638.100219, 880.400573, -43.610939},
		{634.172485, 885.813476, -43.610939},
		{635.576660, 893.294067, -43.603439},
		{641.967956, 898.003051, -43.558959},
		{648.679199, 897.242004, -42.743541},
		{654.830322, 895.541931, -42.002933},
		{662.546447, 893.076171, -41.048439},
		{652.472778, 889.743713, -42.355361},
		{644.680358, 887.102661, -43.205955},
		{638.895996, 888.600891, -43.603439},
		{643.382629, 892.997375, -43.376350},
		{681.386230, 863.475097, -42.681892},
		{646.588012, 860.239013, -43.376369},
		{648.004821, 851.773437, -43.610939},
		{654.417053, 855.355895, -43.610939},
		{660.318481, 849.473388, -43.610939},
		{661.591796, 861.592041, -43.277667},
		{660.899780, 867.371459, -42.788570}
	};

	for(new i, pool = GetPlayerPoolSize(); i <= pool; i++)
	{
	    if(!IsPlayerConnected(i)) continue;
        Player_CleanUp(i);
	}

	// Destroy Old Veins
	for(new i; i < MAX_VEINS; i++)
	{
		if(!VeinData[i][VeinExists]) continue;
		DestroyDynamicObject(VeinData[i][VeinObject]);
		DestroyDynamic3DTextLabel(VeinData[i][VeinLabel]);
		VeinData[i][VeinExists] = false;
	}

	// Respawn
    new type;
	for(new i; i < sizeof(spawn_coords); i++)
	{
	    if(i >= MAX_VEINS) break;
	    type = random(MAX_ORE_TYPES);

	    VeinData[i][Type] = type;
	    VeinData[i][Amount] = OreData[type][Amount];
	    VeinData[i][VeinObject] = CreateDynamicObject(867, spawn_coords[i][0], spawn_coords[i][1], spawn_coords[i][2], 0.0, 0.0, random(360));
  		SetDynamicObjectMaterial(VeinData[i][VeinObject], 0, 2936, "kmb_rckx", "larock256", RGBAToARGB(OreData[type][Color]));
  		VeinData[i][VeinLabel] = CreateDynamic3DTextLabel("Label", OreData[type][Color], spawn_coords[i][0], spawn_coords[i][1], spawn_coords[i][2] + 0.5, 5.0, .testlos = 1);
	    VeinData[i][VeinExists] = true;
	    Vein_Update(i);
	}

	return 1;
}

forward Player_Mine(playerid);
public Player_Mine(playerid)
{
    if(MiningVein[playerid] != -1)
	{
	    new vein_id = MiningVein[playerid], Float: value = GetPlayerProgressBarValue(playerid, MiningBar[playerid]) + OreData[ VeinData[vein_id][Type] ][Modifier];
		if(value >= BAR_MAX) {
		    Player_CleanUp(playerid);

		    if(random(100) < OreData[ VeinData[vein_id][Type] ][Rate]) {
		    	VeinData[vein_id][Amount]--;
				Player_GiveOre(playerid, VeinData[vein_id][Type]);
                Vein_Update(vein_id);

		    	new string[64];
		    	format(string, sizeof(string), "~n~~g~~h~Mined %s", OreData[ VeinData[vein_id][Type] ][Name]);
		    	GameTextForPlayer(playerid, string, 2000, 3);
			}else{
			    GameTextForPlayer(playerid, "~n~~r~~h~Mining Failed", 2000, 3);
			}
		}else{
		    SetPlayerProgressBarValue(playerid, MiningBar[playerid], value);
		}
	}

	return 1;
}

forward Ore_Destroy(id);
public Ore_Destroy(id)
{
	KillTimer(DroppedOres[id][OreTimer]);
	DestroyDynamicObject(DroppedOres[id][OreObject]);
	DestroyDynamic3DTextLabel(DroppedOres[id][OreLabel]);
	DroppedOres[id][OreExists] = false;
	return 1;
}