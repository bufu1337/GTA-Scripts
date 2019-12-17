/*==========================================//
//     __    __         __                  //
//	  (__)  |__) _ ||  |__) _  _ |_  _      //
//    (__)  |__)(_|||  |__)(_)||||_)_) 	    //
//                                          //
//       ___  ___    _   ________   ______  //
//	   / __ )/   |  / | / / ____/  / / / /  //
//	  / __  / /| | /  |/ / / __   / / / /   //
//	 / /_/ / ___ |/ /|  / /_/ /  /_/_/_/    //
//	/_____/_/  |_/_/ |_/\____/  (_|_|_)     //
//                                          //
// 			   Version 1.20          		//
//                                          //
//				   by                       //
//	   			"Malice"       				//
//            July 30, 2007                 //
//                                          //
//			 Other Credits:                 //
//                                          //
//		  IsPlayerInCube by 50p             //
//    Explosion types by iCe[DragSta]       //
//                                          //
//=========================================*/
#include <a_samp>
// Defines
#define BOMBSHOP_ACTIVATE_KEY 2 // H or Capslock by default // Key to activate menu
#define DETONATOR_KEY_ONFOOT KEY_ACTION // Tab by default // Key to detonate onfoot
#define DETONATOR_KEY_INVEHICLE KEY_SUBMISSION // Numpad + by default // Key to detonate in a vehicle
#define TIMER_DECREASE_KEY KEY_LOOK_LEFT // Key to decrease the timer
#define TIMER_INCREASE_KEY KEY_LOOK_RIGHT // Key to increase the timer
#define EXPLOSION_TYPE_DECREASE_KEY 8192 // Key to decrease explosion type
#define EXPLOSION_TYPE_INCREASE_KEY 16384 // Key to increase explosion type
#define MENU_SHORTCUT_KEY_COMBO 5 // By default, shortcut to BombShop menu, hit CTRL + ALT

#define CARBOMB_RADIUS 10.00 // The radius of the carbombs

#define CARBOMB_PRICE 1000 // The price of the carbombs
#define BOMB_TIMER_OFFSET 67.86 // The timer offset in milliseconds, every second is about 67.86 MS inaccurate
#define DEFAULT_BOMB_TIMER 10 // Default time setting for timer
#define DEFAULT_EXPLOSION_TYPE 10 // Default explosion type when menu opens
#define ENABLE_MENU_SHORTCUT 1 // Set this to 1 if you want people to be able to see the menu by pressing CTRL+ALT
#define ENABLE_TELEPORT_COMMAND 1 // Set this to 1 if you want to allow people to teleport to the BombShop, use /8bbshop
#define MAX_TELEPORT_PER_SPAWN 1 // How many times a player can teleport to the bomb shop per spawn
#define TIMER_AUTOMATIC_START 0 // If this is set 1 the timer will start on soon as you select it on the menu

#define COLOR_RED 0xAA3333AA
// Text
static Text:DescDet; // Description detonator
static Text:DescIgn; // Description ignition
static Text:TimerNumber; // Text draw for timer
static Text:ExplNumber;
//Timer
static ExplTimer; // Timed explosion timer
// Carbomb
static Menu:BombMenu; // Bomb menu...
static bool:MenuOpen[MAX_PLAYERS] = false; // Menu check for /8bbmenu
static CarRigger[MAX_PLAYERS] = -1; // Who rigged what // Detonator
static CarTimeRigger[MAX_PLAYERS] = -1;
static bool:CarRigged[MAX_VEHICLES] = false; // On engine start
static bool:CarTimeRigged[MAX_VEHICLES] = false; // Time carbomb
static timer[MAX_VEHICLES] = DEFAULT_BOMB_TIMER; // Timer
static ExplType[MAX_PLAYERS] = DEFAULT_EXPLOSION_TYPE;
static TPPS[MAX_PLAYERS] = 0;
static version[5] = "1.20";
static ExplName[13][] = {
{"Tank Gun 1"},
{"Quiet Explosion"},
{"Tank Gun 2"},
{"Tank Gun 3"},
{"Flare 1"},
{"Flare 2"},
{"Big Bang"},
{"Bigger Bang"},
{"Fireless soot"},
{"Fireless noise"},
{"Large, small impact"},
{"Small"},
{"Tiny"}};

static timestamp = 0;

forward TimerBomb(vehicleid,playerid);

public OnGameModeInit() {
// Create the menus OnGameModeInit because otherwise they crash the server
	BombMenu = CreateMenu("~w~The ~r~Bomb Shop", 2, 50, 200, 250, 250); // Bomb menu
	if(IsValidMenu(BombMenu)) {
	SetMenuColumnHeader(BombMenu, 0, "~b~Select your bomb type");
	AddMenuItem(BombMenu, 0, "-~r~Detonator");
    AddMenuItem(BombMenu, 0, "-~r~Ignition");
    AddMenuItem(BombMenu, 0, "-~r~Timer");
	}
	return 1;
}

public OnFilterScriptInit()
{
printf("	8BB v.%s reloaded",version);
return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{// Shortcut to BombShop menu, CTRL+ALT
if(IsPlayerInAnyVehicle(playerid) && newkeys == MENU_SHORTCUT_KEY_COMBO && ENABLE_MENU_SHORTCUT && !MenuOpen[playerid]) {
	goto DispMenu;
}
// Timer selection
if(IsPlayerInAnyVehicle(playerid)) if(MenuOpen[playerid]) {
	if(newkeys & TIMER_DECREASE_KEY || newkeys & TIMER_INCREASE_KEY) {
		TextDrawHideForPlayer(playerid,Text:TimerNumber); TextDrawDestroy(Text:TimerNumber); // Reset number
		new TimedCar = GetPlayerVehicleID(playerid);
		if(newkeys & TIMER_DECREASE_KEY && timer[TimedCar] > 0) timer[TimedCar]--;
		else if(newkeys & TIMER_INCREASE_KEY) timer[TimedCar]++;
		if(timer[TimedCar] >= 0) {
		new str[255]; format(str,255,"~w~Timer: %d second(s)",timer[TimedCar]);
		TimerNumber = TextDrawCreate(165,277,str); TextDrawFont(Text:TimerNumber,2);
		TextDrawShowForPlayer(playerid,Text:TimerNumber);
		}
	}
 	if(newkeys & EXPLOSION_TYPE_DECREASE_KEY || newkeys & EXPLOSION_TYPE_INCREASE_KEY) {
		TextDrawHideForPlayer(playerid,Text:ExplNumber); TextDrawDestroy(Text:ExplNumber); // Reset text draw
		if(newkeys & EXPLOSION_TYPE_DECREASE_KEY && ExplType[playerid] > 0) ExplType[playerid]--;
		else if(newkeys & EXPLOSION_TYPE_INCREASE_KEY && ExplType[playerid] < sizeof(ExplName) - 1) ExplType[playerid]++;
		if(ExplType[playerid] >= 0) {
		new str[255]; format(str,255,"~w~Explosion type: (%d) ~b~%s",ExplType[playerid],ExplName[ExplType[playerid]]);
		ExplNumber = TextDrawCreate(105,293,str); TextDrawFont(Text:ExplNumber,2);
		TextDrawShowForPlayer(playerid,Text:ExplNumber);
		}
	}
}

// Honk to activate menu inside of the carwash
if(IsPlayerInAnyVehicle(playerid)) {
	if(newkeys & BOMBSHOP_ACTIVATE_KEY)
	{
		if(IsPlayerAtBombShop(playerid))
		{
	  		DispMenu:
			// Text draw creates
			DescDet = TextDrawCreate(165,245,"Press ~b~TAB ~w~or ~b~~k~~TOGGLE_SUBMISSIONS~ ~w~to detonate the vehicle.");
			DescIgn = TextDrawCreate(165,261,"The vehicle will explode on the next ignition.");
			TimerNumber = TextDrawCreate(165,277,"Press ~b~~k~~VEHICLE_LOOKLEFT~ ~w~or ~b~~k~~VEHICLE_LOOKRIGHT~ ~w~to make the timer go up or down.");
			ExplNumber = TextDrawCreate(165,293,"Press NUMPAD 4/6 to choose the explosion type.");
		 	TextDrawShowForPlayer(playerid,Text:DescDet); TextDrawShowForPlayer(playerid,Text:DescIgn);
		 	TextDrawShowForPlayer(playerid,Text:TimerNumber); TextDrawShowForPlayer(playerid,Text:ExplNumber);
			//
 			timer[GetPlayerVehicleID(playerid)] = DEFAULT_BOMB_TIMER;
 			ExplType[playerid] = DEFAULT_EXPLOSION_TYPE;
			ShowMenuForPlayer(BombMenu,playerid);
			TogglePlayerControllable(playerid,0);
			MenuOpen[playerid] = true;
		}
	}
}
// Press tab onfoot or numpad plus in vehicle to explode the rigged car
if(CarRigger[playerid] != -1 || CarTimeRigger[playerid] != -1) {
	if(newkeys & DETONATOR_KEY_ONFOOT || newkeys & DETONATOR_KEY_INVEHICLE)
	{
	
		if(CarTimeRigger[playerid] != -1) {
			new VictimCar = CarTimeRigger[playerid];
			new Float:diff = floatsub(floatmul(float(timer[VictimCar]),1000.000),floatmul(BOMB_TIMER_OFFSET,float(timer[VictimCar])));
			ExplTimer = SetTimerEx("TimerBomb",floatround(diff),0,"ii",VictimCar,playerid); timestamp = tickcount();
			CarTimeRigger[playerid] = -1; // So you dont press tab over and over
		}
		if(CarRigger[playerid] != -1) {
			new Float:X,Float:Y,Float:Z;
			GetVehiclePos(CarRigger[playerid],X,Y,Z);
			CreateExplosion(X,Y,Z,ExplType[playerid],CARBOMB_RADIUS);
			for(new i = 0; i < MAX_PLAYERS;i++)
			{
			if(IsPlayerConnected(i) && IsPlayerInVehicle(i,CarRigger[playerid])) SetPlayerHealth(i,0.0);
			}
			SetVehicleToRespawn(CarRigger[playerid]);
        	CarRigger[playerid] = -1;
  		}
	}
}
return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{ // Entered a rigged car?
	if(newstate == PLAYER_STATE_DRIVER)
	{
		new CarCheck = GetPlayerVehicleID(playerid);
		if(CarRigged[CarCheck])
		{
			new Float:X,Float:Y,Float:Z;
			GetVehiclePos(CarCheck,X,Y,Z);
			CreateExplosion(X,Y,Z,ExplType[playerid],CARBOMB_RADIUS);
            for(new i = 0; i < MAX_PLAYERS;i++) if(IsPlayerConnected(i) && IsPlayerInVehicle(i,CarCheck)) SetPlayerHealth(i,0);
			CarRigged[CarCheck] = false;
		}
}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{// Reset vehicle and player variables
for(new i = 0; i < MAX_PLAYERS;i++) if(IsPlayerConnected(i) && CarRigger[i] == vehicleid) {
CarRigger[i] = -1;
CarTimeRigger[i] = -1;}
CarRigged[vehicleid] = false;
CarTimeRigged[vehicleid] = false;
return 1;
}

public OnVehicleSpawn(vehicleid)
{// Reset vehicle variables // More resetting
for(new i = 0; i < MAX_PLAYERS;i++) if(IsPlayerConnected(i) && CarRigger[i] == vehicleid) {
CarRigger[i] = -1;
CarTimeRigger[i] = -1;
}
CarRigged[vehicleid] = false;
CarTimeRigged[vehicleid] = false;
return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
new Menu:CurrMenu = GetPlayerMenu(playerid);

if(CurrMenu == BombMenu) {
	// Text draw destroys
	TextDrawHideForPlayer(playerid,Text:DescDet); TextDrawDestroy(Text:DescDet);
	TextDrawHideForPlayer(playerid,Text:DescIgn); TextDrawDestroy(Text:DescIgn);
	TextDrawHideForPlayer(playerid,Text:TimerNumber); TextDrawDestroy(Text:TimerNumber);
	TextDrawHideForPlayer(playerid,Text:ExplNumber); TextDrawDestroy(Text:ExplNumber);
	//
	MenuOpen[playerid] = false;
	//ExplType[playerid] = DEFAULT_EXPLOSION_TYPE; If you really need to reset it
	//timer[GetPlayerVehicleID(playerid)] = DEFAULT_BOMB_TIMER; If you really need to reset it
	switch (row) {

			case 0:
					{// Detonator
					CarRigger[playerid] = GetPlayerVehicleID(playerid);
					SendClientMessage(playerid,COLOR_RED,"This vehicle will detonate on TAB/NUMPAD+/2.");
					GivePlayerMoney(playerid,-CARBOMB_PRICE);
					TogglePlayerControllable(playerid,1);
					}
			case 1:
					{// Next engine start
					CarRigged[GetPlayerVehicleID(playerid)] = true;
                	SendClientMessage(playerid,COLOR_RED,"This vehicle will detonate on ignition.");
                	GivePlayerMoney(playerid,-CARBOMB_PRICE);
                	TogglePlayerControllable(playerid,1);
                	}
			case 2:
					{// Timer
                    new VictimCar = GetPlayerVehicleID(playerid),str[255];
					if(TIMER_AUTOMATIC_START == 1 && !CarTimeRigged[VictimCar]) {
				 		CarTimeRigged[VictimCar] = true;
						new Float:diff = floatsub(floatmul(float(timer[VictimCar]),1000.000),floatmul(BOMB_TIMER_OFFSET,float(timer[VictimCar])));
						ExplTimer = SetTimerEx("TimerBomb",floatround(diff),0,"ii",VictimCar,playerid);
						format(str,255,"This vehicle will explode in %d second(s).",timer[VictimCar]);
						SendClientMessage(playerid,COLOR_RED,str);
						GivePlayerMoney(playerid,-CARBOMB_PRICE);
						TogglePlayerControllable(playerid,1);
							}else{
							CarTimeRigged[VictimCar] = true;
							CarTimeRigger[playerid] = VictimCar;
							format(str,255,"This car will detonate %d seconds after you press TAB/NUMPAD+/2.",timer[VictimCar]);
							SendClientMessage(playerid,COLOR_RED,str);
							GivePlayerMoney(playerid,-CARBOMB_PRICE);
							TogglePlayerControllable(playerid,1);
							}
					}
	}
}
return 1;
}

public OnPlayerExitedMenu(playerid)
{
// Text draw destroys
TextDrawHideForPlayer(playerid,Text:DescDet); TextDrawDestroy(Text:DescDet);
TextDrawHideForPlayer(playerid,Text:DescIgn); TextDrawDestroy(Text:DescIgn);
TextDrawHideForPlayer(playerid,Text:TimerNumber); TextDrawDestroy(Text:TimerNumber);
TextDrawHideForPlayer(playerid,Text:ExplNumber); TextDrawDestroy(Text:ExplNumber);
//
TogglePlayerControllable(playerid,1);
timer[GetPlayerVehicleID(playerid)] = DEFAULT_BOMB_TIMER;
ExplType[playerid] = DEFAULT_EXPLOSION_TYPE;
MenuOpen[playerid] = false;
return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
// Car bomb shop
	if((strcmp("/8bbshop", cmdtext, true, 10) == 0) && ENABLE_TELEPORT_COMMAND && TPPS[playerid] < MAX_TELEPORT_PER_SPAWN) {
	SetPlayerPos(playerid,1018.8049,-936.0677,42.1797);
	SetPlayerFacingAngle(playerid,9.00);
	SetCameraBehindPlayer(playerid);
	TPPS[playerid]++;
	}else if(ENABLE_TELEPORT_COMMAND && TPPS[playerid] >= MAX_TELEPORT_PER_SPAWN) {
	SendClientMessage(playerid,COLOR_RED,"You have exceeded you teleports per spawn.");
	}
	return 0;
}

public OnPlayerSpawn(playerid)
{
TPPS[playerid] = 0;
return 1;
}

public OnPlayerConnect(playerid)
{
MenuOpen[playerid] = false;
return 1;
}

public TimerBomb(vehicleid,playerid) // Playerid is for the person who set it
{
new str[255]; format(str,255,"This timer started %d milliseconds ago.",tickcount() - timestamp);
SendClientMessage(playerid,COLOR_RED,str);
if(!CarTimeRigged[vehicleid]) return 0; // Check to see if 10 seconds later the car is still rigged, it could have died
new Float:vX,Float:vY,Float:vZ;
GetVehiclePos(vehicleid,vX,vY,vZ);
CreateExplosion(vX,vY,vZ,ExplType[playerid],CARBOMB_RADIUS);
for(new i=0;i<MAX_PLAYERS;i++) if(IsPlayerConnected(i) && IsPlayerInVehicle(i,vehicleid)) SetPlayerHealth(i,0.00);
SetVehicleToRespawn(vehicleid);
CarTimeRigged[vehicleid] = false; // Reset vars
CarTimeRigger[playerid] = -1;
ExplTimer = KillTimer(ExplTimer); // Kill timer
return 1;
}

stock IsPlayerAtBombShop(playerid) // Add bomb shop locations here
{
if(IsPlayerInCube(playerid,1015.6362,-922.1282,0,1021.4195,-912.3547,46.6641)) return 1; // The carwash in North LS
return 0;
}

// IsPlayerInCube by 50p // http://forum.sa-mp.com/index.php?topic=638.msg46094#msg46094
stock IsPlayerInCube(playerid, Float:xmin, Float:ymin, Float:zmin, Float:xmax, Float:ymax, Float:zmax) {
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if( x > xmin && y > ymin && z > zmin && x < xmax && y < ymax && z < zmax) return 1;
	return 0;
}
