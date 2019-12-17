#include <a_samp>
//-------------------------- DEFINES -----------------------------
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
#define MAX_PLAYER_CARS 80 // Chenge this to set cars per player
#define COLOR_WHITE 0xFFFFFFAA
#define weiss	0xFFFFFFAA
#define gelb 	0xFFFF00AA
#define rot 	0xAA3333AA
#define PRECIOLITRO 20
#define MAX_CARS 144
#define MAX_POINTS 19
#define MAX_POS 16
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
//Timer Variables & Defines
#define MENU_TIMER 500 //Sets interval for timer
// Menu Position Defines
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
#define MAX_CAR_ITEMS 182
#define MAX_TYPE_ITEMS 11
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
	Gasstation18,
};
enum SavePlayerPosEnum {
Float:LastX,
Float:LastY,
Float:LastZ
}
enum SPEEDO_PREF
{
	bool:enabled,
	bool:metric
}
enum carDefinesE {
	name[40],
	ID,
	Price,
	Fuel,
	Tank
	}
enum carTypesE {
	typeName[40],
	typeStart,
	typeEnd
}
new menuCarNames[MAX_PLAYERS][MAX_CAR_ITEMS+1][40];
new menutypeNames[MAX_PLAYERS][MAX_TYPE_ITEMS][40];
new colorpage[MAX_PLAYERS];
new Text:colordraw[MAX_PLAYERS][TOTAL_COLORS+2];
new Text:menuDraws4[MAX_PLAYERS][MAX_TYPE_ITEMS+2];
new Text:menuDraws3[MAX_PLAYERS][MAX_CAR_ITEMS+2];
new Text:menuDraws3s[MAX_PLAYERS];
new Interior[MAX_PLAYERS];
new BIZNAME[MAX_PLAYERS][256];
new str[256];
new SavePlayerPos[SLOTS][SavePlayerPosEnum];
new SpeedoInfo[MAX_PLAYERS][SPEEDO_PREF];
new Speedo[MAX_PLAYERS];
new Speedom[MAX_PLAYERS];
new carType[20][carTypesE];
new carDefines[MAX_CARS][carDefinesE];
//new objectcreated;
//new PlayerTimer2[MAX_PLAYERS];
new PlayerTimer3[MAX_PLAYERS][2];
new Text:menuDraws2[MAX_PLAYERS][MAX_MENUG_ITEMS+1];
new menuliter[MAX_PLAYERS][MAX_MENUG_ITEMS][40];
new menuPlace2[MAX_PLAYERS];
new justbought[MAX_PLAYERS];
new TankString[MAX_PLAYERS][255];
new SpeedString[MAX_PLAYERS][255];
new OilString[MAX_PLAYERS][255];
new KMString[MAX_PLAYERS][255];
new playerCheckpoint[MAX_PLAYERS];
new Text:medidorTanque[MAX_PLAYERS];
new messagesend[MAX_VEHICLES];
new messagesend2[MAX_VEHICLES];
new messagesend3[MAX_VEHICLES];
new	tank[MAX_VEHICLES];
new meters[MAX_VEHICLES];
new oilpress[MAX_VEHICLES];
new oildamage[MAX_VEHICLES];
//new enginestatus[MAX_VEHICLES];
new liters[MAX_PLAYERS];
new SinGas[MAX_PLAYERS];
new Float:Pos[MAX_PLAYERS][4];
new PlayerTimer[MAX_PLAYERS][10];
new menuPlace[MAX_PLAYERS];
new itemPlace[MAX_PLAYERS][MAX_MENU_ITEMS];
new Text:menuDraws[MAX_PLAYERS][MAX_MENU_ITEMS+1];
new menuNames[MAX_PLAYERS][MAX_MENU_ITEMS][40];

new totalItems[MAX_PLAYERS][MAX_MENU_ITEMS];
new itemStart[MAX_PLAYERS][MAX_MENU_ITEMS];
new Float:PlayerPos[MAX_PLAYERS][4];
new CurrentCar[MAX_PLAYERS][MAX_PLAYER_CARS];
new playerCar[MAX_PLAYERS][2];
new bool:destroyCar[MAX_PLAYERS][2];
new bool:carSelect[MAX_PLAYERS];
new Text:vehiclebar[12];
new playervehiclebar[MAX_PLAYERS] = 1;
//-----------------------------------------------------------------------------------------------------
forward VEHICLEHEALTH();
forward Speedometer();
forward Float:GetDistanceToPoint(playerid,Float:x2,Float:y2,Float:z2);
forward Float:checkpointGAScheck(player,Float:distOld2);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward getCheckpointType(playerID);
forward checkpointupdate();
forward CalculateSpeed(playerid);
forward justbdown(playerid);
forward public gasSelector(playerid);
forward public carSelector(playerid);
forward public colorSelector(playerid);
forward public carmSelector(playerid);
forward public carm1Selector(playerid);
forward public cartypeSelector(playerid);
forward public DestroyVehicleEx(vehicleid);
forward public IsPlayerVehicle(vehicleid, playerid);
forward Float:GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance);
forward Float:GetXYInFrontOfObject(playerid,objectid, &Float:x, &Float:y, Float:distance);
forward GetClosestObject(Float:x, Float:y, Float:z, &Object );
forward Float:GetPlayerDistanceToPoint(playerid,Float:x,Float:y,Float:z);
forward GetVehicleWithinDistance( playerid, Float:x1, Float:y1, Float:z1, Float:dist, &veh);
//-----------------------------------------------------------------------------------------------------
public CalculateSpeed(playerid)
{
	new Float:x,Float:y,Float:z;
	new Float:distance,value,value2;
	new string[255];
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		GetPlayerPos(i, x, y, z);
		distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
        value = floatround(distance * 3600);
        value2 = floatround(distance);
		Speedo[i] = (value/1000);
		Speedom[i] = value2;
		SavePlayerPos[i][LastX] = x;
		SavePlayerPos[i][LastY] = y;
		SavePlayerPos[i][LastZ] = z;
		format(string, sizeof(string),"distance: %d  value: %d  Speedo: %d Speedom: %d  POS: %d X %d Y %d Z", distance, value, Speedo[i], Speedom[i], SavePlayerPos[i][LastX], SavePlayerPos[i][LastY], SavePlayerPos[i][LastZ]);
//			SendClientMessage(i,COLOR_RED,string);
}}}
//-----------------------------------------------------------------------------------------------------
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("\n!damo!spidermans Car Select 0.3");
	print("--------------------------------------\n");
	LoadCarDefines("carDefines.def");
	LoadTotalItems();
	SetTimer("Speedometer",1000,1);
	SetTimer("checkpointupdate",1000,1);
	for (new i=0;i<MAX_PLAYERS;i++)
	    {
	    SpeedoInfo[i][enabled]=true;
	    SpeedoInfo[i][metric]=true;
		playerCar[i][END_CAR] = 0 - (MAX_PLAYER_CARS + 1);
		playerCar[i][CURRENT] = -1;
		playerCar[i][END_CAR] = 0 - (MAX_PLAYER_CARS + 1);
		playerCar[i][CURRENT] = -1;

}
	return 1;
}
//-----------------------------------------------------------------------------------------------------
public OnFilterScriptExit()
{
	print("\n----------------------------------");
	print("\n Car Select 0.3 Shutting Down");
	print("\n----------------------------------");

	return 1;
}
//-----------------------------------------------------------------------------------------------------
public OnPlayerDisconnect( playerid, reason)
{
	KillTimer(PlayerTimer[playerid][0]);
}
//-----------------------------------------------------------------------------------------------------
public OnPlayerEnterCheckpoint(playerid)
	{
        switch(getCheckpointType(playerid))
        {
 	       case Gasstation0 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)  	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
				CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
				UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation1 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)	   	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
	        	CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation2 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)	   	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
                CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
				UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation3 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)	   	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
	        	CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation4 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)	   	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
	        	CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation5 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)	   	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
	        	CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation6 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)	   	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
	        	CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation7 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)	   	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
	        	CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation8 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)	   	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
          		CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation9 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)	   	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
	        	CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation10 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)	   	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
	        	CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
				}}
	       case Gasstation11 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)	   	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
	        	CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation12 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)	   	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
	        	CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation13 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)	   	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
	        	CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation14 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)	   	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
	        	CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation15 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)	   	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
	        	CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation16 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)	   	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
	        	CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation17 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)	   	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
	        	CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
	       case Gasstation18 : {
 if 	(IsPlayerInAnyVehicle(playerid) && PlayerTimer3[playerid][1]==0)	   	{

	        	PlayerTimer3[playerid][0] = SetTimerEx("gasSelector", 500, true, "iii", playerid);
                PlayerTimer3[playerid][1] = 1;
	        	CallRemoteFunction("GasSelectMenu", "iii", playerid, 1);
	        	UpdategasMenu(playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}}
        }
 }
//-----------------------------------------------------------------------------------------------------
public OnPlayerLeaveCheckpoint(playerid)
{
    TogglePlayerControllable(playerid,true);
	KillTimer(PlayerTimer3[playerid][0]);
	CallRemoteFunction("GasSelectMenu", "iii", playerid, 0);
	return 1;
}
//------------------------------------------------------------------------------------------------------
public OnPlayerStateChange(playerid, newstate, oldstate)
	{
 	#pragma unused oldstate
	if (newstate==PLAYER_STATE_DRIVER){
	if (SpeedoInfo[playerid][enabled]){
		medidorTanque[playerid] = TextDrawCreate(490.0,105.0,"Fuel:0000 L Km/h:000 KM : 0000 Oil: 00");
//   	TextDrawUseBox(medidorTanque[playerid],1);
//		TextDrawBoxColor(medidorTanque[playerid],0x000000cc);
		TextDrawTextSize(medidorTanque[playerid],602.0,0.0);
		TextDrawAlignment(medidorTanque[playerid],0);
//		TextDrawBackgroundColor(medidorTanque[playerid],0x000000ff);
		TextDrawFont(medidorTanque[playerid],3);
		TextDrawLetterSize(medidorTanque[playerid],0.8,0.8);
		TextDrawColor(medidorTanque[playerid],0x00ff0066);
		TextDrawSetProportional(medidorTanque[playerid],0);
		TextDrawSetShadow(medidorTanque[playerid],1);
	    TextDrawShowForPlayer(playerid,medidorTanque[playerid]);
    	new Float:x,Float:y,Float:z;
    	GetPlayerPos(playerid,x,y,z);
		SavePlayerPos[playerid][LastX] = x;
	    SavePlayerPos[playerid][LastY] = y;
	 	SavePlayerPos[playerid][LastZ] = z;}
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

		SetTimer("VEHICLEHEALTH",250,1);}
	if (newstate==PLAYER_STATE_PASSENGER && SpeedoInfo[playerid][enabled])
	    {
	    TextDrawShowForPlayer(playerid,medidorTanque[playerid]);
	    }
	if (newstate==PLAYER_STATE_ONFOOT)
	    {
	    TextDrawDestroy(medidorTanque[playerid]);
	    if  (SinGas[playerid]!=0)
	        {
	        TogglePlayerControllable(playerid,true);
	        }
	    SinGas[playerid]=0;
	    }
	}
//-----------------------------------------------------------------------------------------------------
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)	{
	#pragma unused oldkeys
	if 	((SinGas[playerid]!=0)&&(newkeys==KEY_SECONDARY_ATTACK)&&(IsPlayerInAnyVehicle(playerid))&&(IsPlayerInVehicle(playerid,SinGas[playerid])))	{
			RemovePlayerFromVehicle(playerid);
			return 1;	}
	return 1;	}
//-----------------------------------------------------------------------------------------------------
public OnPlayerExitVehicle(playerid, vehicleid){
    messagesend[playerid]=0;
    messagesend2[playerid]=0;
    messagesend3[playerid]=0;
	return 1;
}
//-----------------------------------------------------------------------------------------------------
public OnPlayerSpawn( playerid)
{
	if( carSelect[playerid] == true ){
	    carSelect[playerid] = false;
		return 0;
	}
	return 1;
}
//-----------------------------------------------------------------------------------------------------
public OnPlayerCommandText(playerid, cmdtext[])
{
	//new tmp[255]
    new cmd[255],idx;
    new tmp[255];
	cmd = strtok(cmdtext, idx);
 	if(strcmp(cmd,"/getmoney", true) == 0) {
		new betrag;
		tmp = strtok(cmdtext, idx);
		betrag = strval(tmp);
		GivePlayerMoney(playerid,betrag);
		return 1;}
	if(strcmp(cmdtext, "/vehiclehealth", true) == 0){
		if(playervehiclebar[playerid] == 0){
			playervehiclebar[playerid] = 1;}
		else if(playervehiclebar[playerid] == 1){
			playervehiclebar[playerid] = 0;}
		return 1;
	}
	if	((strcmp(cmd,"/SetPlayerGas", true)==0)||(strcmp(cmd, "/SPG", true)==0))
	  		{
			tmp = strtok(cmdtext, idx);
			if	(!strlen(tmp))
				{
				SendClientMessage(playerid, COLOR_WHITE, "USO: /SetPlayerGas [playerid] [cant]");
				return 1;
				}
            new pid=strval(tmp);
	  		tmp = strtok(cmdtext, idx);
			if	(!strlen(tmp))
				{
				SendClientMessage(playerid, COLOR_WHITE, "USO: /SetPlayerGas [playerid] [cant]");
				return 1;
				}
            new cant=strval(tmp);
			if  (!IsPlayerInAnyVehicle(pid))
			    {
			    SendClientMessage(playerid, COLOR_WHITE, "That player is on FOOT...");
			    return 1;
			    }
			new vid = GetPlayerVehicleID(pid);
			new wm = GetVehicleModel(vid);
 			for (new h=0;h<MAX_CARS;h++){
			if (carDefines[h][ID]==wm){

			if	((tank[vid]/1000000 + cant) > carDefines[h][Tank]/10)
		        {
		        cant=(carDefines[h][Tank]-tank[vid]/100000)/10;
		        }}}
	        tank[vid]=tank[vid]+cant*1000000;
			new string[255];
			new string2[255];
			format(string, sizeof(string), "An Admin have put %d litres in your vehicle", cant);
			format(string2, sizeof(string2), "You have added %d litres to a vehicle.", cant);
			SendClientMessage(pid, COLOR_YELLOW, string);
			SendClientMessage(playerid, COLOR_YELLOW, string2);
			format(string, sizeof(string), "Fuel:%d L", tank[vid]/1000000);
			TankString[pid]=string;
   			format(tmp, sizeof(tmp),"%s %s %s %s",TankString[pid],SpeedString[pid],KMString[pid], OilString[pid]);
			TextDrawSetString(medidorTanque[pid],tmp);
			TogglePlayerControllable(pid, true);
			return 1;
			}
	if	(strcmp(cmd,"/tankinfo", true)==0){
            new wid = GetPlayerVehicleID(playerid);
            new lol[255];
            format(lol, sizeof(lol),"%d",tank[wid]);
            SendClientMessage(playerid,COLOR_RED,lol);
			return 1;}
	if	(strcmp(cmd,"/speedo", true)==0){
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp)){
	 		SendClientMessage(playerid,COLOR_GREEN,"Usage: /speedo [on,off,kph,mph]");return 1;}
			if (!strcmp(tmp,"on",true,2))
			{
			SpeedoInfo[playerid][enabled] = true;
			if (IsPlayerInAnyVehicle(playerid)){TextDrawShowForPlayer(playerid,medidorTanque[playerid]);}
			SendClientMessage(playerid,COLOR_GREEN,"Speedometer: Enabled.");
			return 1;
			}

			else if (!strcmp(tmp,"off",true,3))
			{
			SpeedoInfo[playerid][enabled] = false;
			if (IsPlayerInAnyVehicle(playerid)){TextDrawHideForPlayer(playerid,medidorTanque[playerid]);}
			SendClientMessage(playerid,COLOR_GREEN,"Speedometer: Disabled.");
			return 1;
			}
			else if (!strcmp(tmp,"kph",true,3))
			{
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
	if(strcmp(cmd, "/car", true) ==0)
	{
	        if(PlayerTimer[playerid][1] != 1){ //checks whether player is in menu
	            CallRemoteFunction("CarSelectMenu", "ii", playerid, 1);
	            PlayerTimer[playerid][1] = 1;
	            PlayerPos[playerid][2] = GetXYInFrontOfPlayer(playerid,  PlayerPos[playerid][0],  PlayerPos[playerid][1], 5.0);
				GetPlayerFacingAngle(playerid, PlayerPos[playerid][3]);
				UpdateNextCar(playerid);
				UpdatespideyMenu(playerid);
				UpdateCar(playerid);
				PlayerTimer[playerid][0] = SetTimerEx("carSelector", MENU_TIMER, true, "i", playerid);
				SendClientMessage(playerid, COLOR_YELLOW, "Use Arrow-Keys to navigate and Shift-Key (Sprint-key) to select");
			}
			return 1;
	}
	if	(strcmp(cmd,"/carinfo", true)==0)	{
			new infoid, string3[255];
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp)){
	 		SendClientMessage(playerid,COLOR_GREEN,"Usage: /carinfo id");return 1;}
			infoid = strval(tmp);
			format(string3, sizeof(string3), "ID: %d   Name: %s   Fuel: %d   Tank: %d   Price: %d", carDefines[infoid][ID], carDefines[infoid][name],carDefines[infoid][Fuel],carDefines[infoid][Tank],carDefines[infoid][Price]);
			SendClientMessage(playerid, COLOR_YELLOW, string3);return 1;}

	if(!strcmp(cmdtext,"/pos",true,4))
	{
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
	return 0;
}
public justbdown(playerid){
		justbought[playerid]=0;
}
//-----------------------------------------------------------------------------------------------------
public colorSelector(playerid){
	if(IsPlayerConnected(playerid)){
	    new Keys[3];
	    GetPlayerKeys(playerid, Keys[0], Keys[1], Keys[2]);
	    if(Keys[1] == KEY_UP ){
			itemPlace[playerid][menuPlace[playerid]] = itemPlace[playerid][menuPlace[playerid]]-8;
			if(itemPlace[playerid][menuPlace[playerid]] < 0 && colorpage[playerid]==0){
            itemPlace[playerid][menuPlace[playerid]] = totalItems[playerid][menuPlace[playerid]]-9;
			DestroyMenuColor(playerid);
            UpdateColorMenu2(playerid);
			colorpage[playerid]=1;
			}
           	else if (itemPlace[playerid][menuPlace[playerid]] < 64 && colorpage[playerid]==1){
			DestroyMenuColor2(playerid);
			UpdateColorMenu(playerid);
			colorpage[playerid]=0;
			}
			ChangeVehicleColor(CurrentCar[ playerid ][ playerCar[ playerid ][ CURRENT ]], itemPlace[playerid][2],itemPlace[playerid][3]);
			UpdateColSel(playerid);
		 }
		if(Keys[1] == KEY_DOWN ){
			itemPlace[playerid][menuPlace[playerid]] = itemPlace[playerid][menuPlace[playerid]]+8;
           	if (itemPlace[playerid][menuPlace[playerid]] > totalItems[playerid][menuPlace[playerid]]-1 && colorpage[playerid]==1){
            itemPlace[playerid][menuPlace[playerid]] = itemPlace[playerid][menuPlace[playerid]]-totalItems[playerid][menuPlace[playerid]]-1;
			DestroyMenuColor2(playerid);
			UpdateColorMenu(playerid);
			colorpage[playerid]=0;
			}
			else if(itemPlace[playerid][menuPlace[playerid]] > 63 && colorpage[playerid]==0){
            DestroyMenuColor(playerid);
            UpdateColorMenu2(playerid);
			colorpage[playerid]=1;
			}
			ChangeVehicleColor(CurrentCar[ playerid ][ playerCar[ playerid ][ CURRENT ]], itemPlace[playerid][2],itemPlace[playerid][3]);
			UpdateColSel(playerid);
		 }
	    if(Keys[2] == KEY_LEFT ){
	        itemPlace[playerid][menuPlace[playerid]] = itemPlace[playerid][menuPlace[playerid]]-1;
			if(itemPlace[playerid][menuPlace[playerid]] < 0 && colorpage[playerid]==0){
            itemPlace[playerid][menuPlace[playerid]] = totalItems[playerid][menuPlace[playerid]]-1;
			DestroyMenuColor(playerid);
            UpdateColorMenu2(playerid);
			colorpage[playerid]=1;
			}
           	else if (itemPlace[playerid][menuPlace[playerid]] < 64 && colorpage[playerid]==1){
			DestroyMenuColor2(playerid);
			UpdateColorMenu(playerid);
			colorpage[playerid]=0;
			}
            ChangeVehicleColor(CurrentCar[ playerid ][ playerCar[ playerid ][ CURRENT ]], itemPlace[playerid][2],itemPlace[playerid][3]);
            UpdateColSel(playerid);
		 }
		if(Keys[2] == KEY_RIGHT ){
	        itemPlace[playerid][menuPlace[playerid]] = itemPlace[playerid][menuPlace[playerid]]+1;
           	if (itemPlace[playerid][menuPlace[playerid]] > totalItems[playerid][menuPlace[playerid]]-1 && colorpage[playerid]==1){
            itemPlace[playerid][menuPlace[playerid]] = 0;
			DestroyMenuColor2(playerid);
			UpdateColorMenu(playerid);
			colorpage[playerid]=0;
			}
			else if(itemPlace[playerid][menuPlace[playerid]] > 63 && colorpage[playerid]==0){
            DestroyMenuColor(playerid);
            UpdateColorMenu2(playerid);
			colorpage[playerid]=1;
			}
            ChangeVehicleColor(CurrentCar[ playerid ][ playerCar[ playerid ][ CURRENT ]], itemPlace[playerid][2],itemPlace[playerid][3]);
            UpdateColSel(playerid);
		 }
		if(Keys[0] == KEY_SPRINT && PlayerTimer[playerid][7] == 1){
		    KillTimer(PlayerTimer[playerid][6]);
		    PlayerTimer[playerid][7] = 0;
		    DestroyMenuColor(playerid);
		    DestroyMenuColor2(playerid);
		    CallRemoteFunction("ColorSelectMenu", "ii", playerid, 0);
   			CallRemoteFunction("CarSelectMenu", "ii", playerid, 1);
   			UpdatespideyMenu(playerid);
			PlayerTimer[playerid][1] = 1;
			PlayerTimer[playerid][0] = SetTimerEx("carSelector", MENU_TIMER, true, "i", playerid);
		 }
   	}}
//-----------------------------------------------------------------------------------------------------
public cartypeSelector(playerid){
	if(IsPlayerConnected(playerid)){
	    new Keys[3];
	    GetPlayerKeys(playerid, Keys[0], Keys[1], Keys[2]);

	    if(Keys[1] == KEY_UP ){
	        itemPlace[playerid][menuPlace[playerid]] = (itemPlace[playerid][menuPlace[playerid]] == itemStart[playerid][menuPlace[playerid]] ) ? totalItems[playerid][menuPlace[playerid]]-1:itemPlace[playerid][menuPlace[playerid]]-1;
	        itemStart[playerid][1] = carType[itemPlace[playerid][0]][typeStart];
			totalItems[playerid][1] = carType[itemPlace[playerid][0]][typeEnd];
			itemPlace[playerid][1] = itemStart[playerid][1];
            DestroyMenuCartype(playerid);
			UpdateCar(playerid);
	        UpdatecartypeMenu(playerid);
		 }
		if(Keys[1] == KEY_DOWN ){
	        itemPlace[playerid][menuPlace[playerid]] = (itemPlace[playerid][menuPlace[playerid]] == totalItems[playerid][menuPlace[playerid]]-1 ) ? itemStart[playerid][menuPlace[playerid]]:itemPlace[playerid][menuPlace[playerid]]+1;
			itemStart[playerid][1] = carType[itemPlace[playerid][0]][typeStart];
			totalItems[playerid][1] = carType[itemPlace[playerid][0]][typeEnd];
			itemPlace[playerid][1] = itemStart[playerid][1];
            DestroyMenuCartype(playerid);
			UpdateCar(playerid);
	        UpdatecartypeMenu(playerid);
		 }
		if(Keys[0] == KEY_SPRINT && PlayerTimer[playerid][3] == 1 ){
		    KillTimer(PlayerTimer[playerid][2]);
		    PlayerTimer[playerid][3] = 0;
		    DestroyMenuCartype(playerid);
		    CallRemoteFunction("CartypeSelectMenu", "ii", playerid, 0);
   			CallRemoteFunction("CarSelectMenu", "ii", playerid, 1);
   			UpdatespideyMenu(playerid);
			PlayerTimer[playerid][1] = 1;
			PlayerTimer[playerid][0] = SetTimerEx("carSelector", MENU_TIMER, true, "i", playerid);
		 }}
}
//-----------------------------------------------------------------------------------------------------
public carmSelector(playerid){
	if(IsPlayerConnected(playerid)){
	    new Keys[3];
        GetPlayerKeys(playerid, Keys[0], Keys[1], Keys[2]);
	    if(Keys[1] == KEY_UP ){
	        itemPlace[playerid][menuPlace[playerid]] = (itemPlace[playerid][menuPlace[playerid]] == itemStart[playerid][menuPlace[playerid]] ) ? totalItems[playerid][menuPlace[playerid]]-1:itemPlace[playerid][menuPlace[playerid]]-1;
            DestroyMenuCarm(playerid);
//			UpdateCar(playerid);
	        UpdateCarmMenu(playerid);
		 }
		if(Keys[1] == KEY_DOWN ){
		    itemPlace[playerid][menuPlace[playerid]] = (itemPlace[playerid][menuPlace[playerid]] == totalItems[playerid][menuPlace[playerid]]-1 ) ? itemStart[playerid][menuPlace[playerid]]:itemPlace[playerid][menuPlace[playerid]]+1;
            DestroyMenuCarm(playerid);
//			UpdateCar(playerid);
	        UpdateCarmMenu(playerid);
		}
		if(Keys[0] == KEY_SPRINT && PlayerTimer[playerid][5] == 1 ){
		    KillTimer(PlayerTimer[playerid][4]);
		    PlayerTimer[playerid][5] = 0;
			UpdateCar(playerid);
		    CallRemoteFunction("CarmSelectMenu", "ii", playerid, 0);
   			CallRemoteFunction("Carm1SelectMenu", "ii", playerid, 1);
			PlayerTimer[playerid][9] = 1;
			PlayerTimer[playerid][8] = SetTimerEx("carm1Selector", MENU_TIMER, true, "i", playerid);
			SendClientMessage(playerid, COLOR_YELLOW,"PLZ CONFIRM");
		 }}
}
//-----------------------------------------------------------------------------------------------------
public carm1Selector(playerid){
	if(IsPlayerConnected(playerid)){
	    new Keys[3];
	    GetPlayerKeys(playerid, Keys[0], Keys[1], Keys[2]);
		if(Keys[0] == KEY_SPRINT ){
		    KillTimer(PlayerTimer[playerid][8]);
			PlayerTimer[playerid][9] = 0;
			DestroyMenuCarm(playerid);
//			itemPlace[playerid][menuPlace[playerid]]=0;
			UpdatespideyMenu(playerid);
		    CallRemoteFunction("CarmSelectMenu", "ii", playerid, 0);
   			CallRemoteFunction("CarSelectMenu", "ii", playerid, 1);
			PlayerTimer[playerid][1] = 1;
			PlayerTimer[playerid][0] = SetTimerEx("carSelector", MENU_TIMER, true, "i", playerid);
		}}
}
//-----------------------------------------------------------------------------------------------------
public carSelector(playerid){
	if(IsPlayerConnected(playerid)){
	    new Keys[3];
	    GetPlayerKeys(playerid, Keys[0], Keys[1], Keys[2]);
	    if(Keys[1] == KEY_UP ){
	        menuPlace[playerid] = menuPlace[playerid]-1;
	        if(menuPlace[playerid] < 0){ menuPlace[playerid] = MAX_MENU_ITEMS-1;}
	        DestroyMenuCar(playerid);
	        UpdatespideyMenu(playerid);
		 }
		if(Keys[1] == KEY_DOWN ){
	        menuPlace[playerid] = menuPlace[playerid]+1;
			if(menuPlace[playerid] > MAX_MENU_ITEMS-1){ menuPlace[playerid] = 0;}
	        DestroyMenuCar(playerid);
	        UpdatespideyMenu(playerid);
		 }
		if(Keys[0] == KEY_SPRINT ){
		if (menuPlace[playerid]==0 && PlayerTimer[playerid][1] == 1){
				
				KillTimer(PlayerTimer[playerid][0]);
				PlayerTimer[playerid][1] = 0;
		    	DestroyMenuCar(playerid);
		    	carSelect[playerid] = false;
				CallRemoteFunction("CarSelectMenu", "ii", playerid, 0);
				SendClientMessage(playerid, COLOR_YELLOW,"PLZ CONFIRM1");
				CallRemoteFunction("CartypeSelectMenu", "ii", playerid, 1);
	            PlayerTimer[playerid][3] = 1;
	            SendClientMessage(playerid, COLOR_YELLOW,"PLZ CONFIRM2");
				UpdatecartypeMenu(playerid);
                SendClientMessage(playerid, COLOR_YELLOW,"PLZ CONFIRM2,5");
				PlayerTimer[playerid][2] = SetTimerEx("cartypeSelector", MENU_TIMER, true, "i", playerid);
				SendClientMessage(playerid, COLOR_YELLOW,"PLZ CONFIRM3");}
		if (menuPlace[playerid]==1 && PlayerTimer[playerid][1] == 1){
				KillTimer(PlayerTimer[playerid][0]);
		    	PlayerTimer[playerid][1] = 0;
		    	DestroyMenuCar(playerid);
		    	carSelect[playerid] = false;
				CallRemoteFunction("CarSelectMenu", "ii", playerid, 0);
				CallRemoteFunction("CarmSelectMenu", "ii", playerid, 1);
	            PlayerTimer[playerid][5] = 1;
				UpdateCarmMenu(playerid);
				PlayerTimer[playerid][4] = SetTimerEx("carmSelector", MENU_TIMER, true, "i", playerid);}
		if ((menuPlace[playerid]==2 || menuPlace[playerid]==3)&& PlayerTimer[playerid][1] == 1){
    			KillTimer(PlayerTimer[playerid][0]);
		    	PlayerTimer[playerid][1] = 0;
		    	DestroyMenuCar(playerid);
		    	carSelect[playerid] = false;
				CallRemoteFunction("CarSelectMenu", "ii", playerid, 0);
				CallRemoteFunction("ColorSelectMenu", "ii", playerid, 1);
	            PlayerTimer[playerid][7] = 1;
             	UpdateColorMenu(playerid);
				PlayerTimer[playerid][6] = SetTimerEx("colorSelector", MENU_TIMER, true, "i", playerid);}
		if (menuPlace[playerid]==4 && PlayerTimer[playerid][1] == 1){
		    carSelect[playerid] = true;
		    KillTimer(PlayerTimer[playerid][0]);
		    PlayerTimer[playerid][1] = 0;
		    menuPlace[playerid]=0;
			DestroyMenuCar(playerid);
			TogglePlayerSpectating(playerid, 0);
			LockCarForAll( CurrentCar[ playerid ][ playerCar[ playerid ][ CURRENT ] ], false );
			PutPlayerInVehicle(playerid, CurrentCar[playerid][playerCar[playerid][CURRENT]], 0);
			destroyCar[playerid][1] = false;
			destroyCar[playerid][0] = true;
			CallRemoteFunction("CarSelectMenu", "ii", playerid, 0);
			}
		if (menuPlace[playerid]==5&& PlayerTimer[playerid][1] == 1){
		    carSelect[playerid] = false;
		    KillTimer(PlayerTimer[playerid][0]);
		    PlayerTimer[playerid][1] = 0;
		    menuPlace[playerid]=0;
			DestroyMenuCar(playerid);
			TogglePlayerSpectating(playerid, 0);
			DestroyVehicle(CurrentCar[playerid][playerCar[playerid][CURRENT]]);
			destroyCar[playerid][1] = false;
			destroyCar[playerid][0] = true;
			CallRemoteFunction("CarSelectMenu", "ii", playerid, 0);
		}
		}
		if(Keys[0] == KEY_SECONDARY_ATTACK ){
		    carSelect[playerid] = false;
		    KillTimer(PlayerTimer[playerid][0]);
		    PlayerTimer[playerid][1] = 0;
		    menuPlace[playerid]=0;
			DestroyMenuCar(playerid);
			TogglePlayerSpectating(playerid, 0);
			DestroyVehicle(CurrentCar[playerid][playerCar[playerid][CURRENT]]);
			destroyCar[playerid][1] = false;
			destroyCar[playerid][0] = true;
			CallRemoteFunction("CarSelectMenu", "ii", playerid, 0);}

		   	}}
//-----------------------------------------------------------------------------------------------------
public gasSelector(playerid){
	if(IsPlayerConnected(playerid)){
		new Keys[3];
		new string2[255];
		new string[255];
		new tmp[255];
		new tmp2[255];
		new vid = GetPlayerVehicleID(playerid);
		new wm = GetVehicleModel(vid);
	    GetPlayerKeys(playerid, Keys[0], Keys[1], Keys[2]);
		for (new h=0;h<MAX_CARS;h++){
		if (carDefines[h][ID]==wm){

			if(Keys[1] == KEY_UP){
		        menuPlace2[playerid] = menuPlace2[playerid]-1;
				if(menuPlace2[playerid] < 0){ menuPlace2[playerid] = MAX_MENUG_ITEMS-1;}
                DestroyMenuGas(playerid);
				UpdategasMenu(playerid);
			 }
			if(Keys[1] == KEY_DOWN ){
		        menuPlace2[playerid] = menuPlace2[playerid]+1;
				if(menuPlace2[playerid] > MAX_MENUG_ITEMS-1){ menuPlace2[playerid] = 0;}
                DestroyMenuGas(playerid);
				UpdategasMenu(playerid);
		 	}
			if(Keys[2] == KEY_RIGHT ){
			if(menuPlace2[playerid]==1){
				liters[playerid] = liters[playerid]+1;
				if(liters[playerid] + tank[vid]/1000000 > carDefines[h][Tank]/10){
				liters[playerid]=0;
				format(tmp2, sizeof(tmp2), "Your car can only take %d Liters.", carDefines[h][Tank]/10);
				SendClientMessage(playerid, COLOR_YELLOW, tmp2);}
                DestroyMenuGas(playerid);
				UpdategasMenu(playerid);
	 		}}

			if(Keys[2] == KEY_LEFT ){
			if(menuPlace2[playerid]==1){
				liters[playerid] = liters[playerid]-1;
				if(liters[playerid] < 0){
				liters[playerid] = ((carDefines[h][Tank]-tank[vid]/100000)/10 + 1);}
                DestroyMenuGas(playerid);
				UpdategasMenu(playerid);}}
            if(Keys[0] == KEY_SPRINT ){
				if (menuPlace2[playerid]==0){
    				if (tank[vid]/100000 ==  carDefines[h][Tank])
					{
					SendClientMessage(playerid, COLOR_RED, "This car is already refuelled.");
					TogglePlayerControllable(playerid,true);
					DestroyMenuGas(playerid);
					CallRemoteFunction("GasSelectMenu", "iii", playerid, 0);
					menuPlace2[playerid]=0;
					justbought[playerid]=1;
					PlayerTimer3[playerid][1]=0;
					SetTimerEx("justbdown", 15000, 0, "y",playerid);
					KillTimer(PlayerTimer3[playerid][0]);
					return 1;
					}
					new cant = (carDefines[h][Tank]-tank[vid]/100000)/10;
					if (PRECIOLITRO*cant>GetPlayerMoney(playerid))
					{
					SendClientMessage(playerid, COLOR_RED, "You don't have enough money..");
					return 1;}
      		 		tank[vid]=tank[vid]+cant*1000000;
    				GivePlayerMoney(playerid,PRECIOLITRO*cant*-1);
					format(string2, sizeof(string2), "Your car has been refuelled with %d liters. The tank is full.", cant);
					SendClientMessage(playerid, COLOR_YELLOW, string2);
					format(string, sizeof(string), "Fuel:%d L", tank[vid]/1000000);
					TankString[playerid]=string;
					format(tmp, sizeof(tmp),"%s %s %s %s",TankString[playerid],SpeedString[playerid],KMString[playerid], OilString[playerid]);
					TextDrawSetString(medidorTanque[playerid],tmp);
					menuPlace2[playerid]=0;
					justbought[playerid]=1;
					TogglePlayerControllable(playerid,true);
					PlayerTimer3[playerid][1]=0;
					SetTimerEx("justbdown", 15000, 0, "y",playerid);
					DestroyMenuGas(playerid);
					CallRemoteFunction("GasSelectMenu", "iii", playerid, 0);
					KillTimer(PlayerTimer3[playerid][0]);}
				if (menuPlace2[playerid]==1){
					if (PRECIOLITRO*liters[playerid]>GetPlayerMoney(playerid))
	    			{
       					SendClientMessage(playerid, COLOR_RED, "You don't have enough money.");
        				//TogglePlayerControllable(playerid,true);
						return 1;
		    		}
			        tank[vid]=tank[vid]+(liters[playerid]*1000000);
			        GivePlayerMoney(playerid,PRECIOLITRO*liters[playerid]*-1);
					format(string, sizeof(string), "You bought %d liters of fuel, the tank is full", liters[playerid]);
					format(string2, sizeof(string2), "Your car has been refuelled with %d liters of fuel, the tank is full", liters[playerid]);
					SendClientMessage(playerid, COLOR_YELLOW, string2);
					liters[playerid] = 0;
					format(string, sizeof(string), "Fuel:%d L", tank[vid]/1000000);
					TankString[playerid]=string;
					format(tmp, sizeof(tmp),"%s %s %s %s",TankString[playerid],SpeedString[playerid],KMString[playerid], OilString[playerid]);
					TextDrawSetString(medidorTanque[playerid],tmp);
       		 		TogglePlayerControllable(playerid,true);
					KillTimer(PlayerTimer3[playerid][0]);
					menuPlace2[playerid]=0;
					justbought[playerid]=1;
					PlayerTimer3[playerid][1]=0;
					SetTimerEx("justbdown", 15000, 0, "y",playerid);
					DestroyMenuGas(playerid);
					CallRemoteFunction("GasSelectMenu", "iii", playerid, 0);
				}
				if (menuPlace2[playerid]==2){
					TogglePlayerControllable(playerid,true);
					KillTimer(PlayerTimer3[playerid][0]);
					menuPlace2[playerid]=0;
					justbought[playerid]=1;
					PlayerTimer3[playerid][1]=0;
					SetTimerEx("justbdown", 15000, 0, "y",playerid);
					DestroyMenuGas(playerid);
					CallRemoteFunction("GasSelectMenu", "iii", playerid, 0);
				}
			}
	}}}
	return 1;}
//-----------------------------------------------------------------------------------------------------
UpdateCar( playerid ){
	if(( playerCar[playerid][END_CAR] > -1 ) && ( destroyCar[playerid][0] == true )){
	    FlagVehicleDestroy( CurrentCar[ playerid ][ playerCar[ playerid ][ END_CAR ] ] );
		//DestroyVehicle( CurrentCar[ playerid ][ playerCar[ playerid ][ END_CAR ] ] ); // Destroys END_CAR
		destroyCar[playerid][0] = false;
	}
	if( destroyCar[playerid][1] == true ){
		DestroyVehicle( CurrentCar[ playerid ][ playerCar[ playerid ][ CURRENT ]]); // Destroy the Car in menu and creates the next one
	}
	CurrentCar[ playerid ][ playerCar[ playerid ][ CURRENT ] ] = CreateVehicle( carDefines[itemPlace[playerid][1]][ID], PlayerPos[playerid][0], PlayerPos[playerid][1], PlayerPos[playerid][2], PlayerPos[playerid][3], itemPlace[playerid][2], itemPlace[playerid][3],-1);
	LockCarForAll( CurrentCar[ playerid ][ playerCar[ playerid ][ CURRENT ] ], true );
	TogglePlayerSpectating(playerid, 1);
	PlayerSpectateVehicle(playerid, CurrentCar[playerid][playerCar[playerid][CURRENT]], SPECTATE_MODE_NORMAL);
	destroyCar[playerid][1] = true;
}
//-----------------------------------------------------------------------------------------------------
DestroyMenuCar(playerid){
	for(new i = 0; i < MAX_MENU_ITEMS+1; i++){
	     TextDrawDestroy(menuDraws[playerid][i]);	}}
//-----------------------------------------------------------------------------------------------------
DestroyMenuGas(playerid){
	for(new i = 0; i < MAX_MENUG_ITEMS+1; i++){
	     TextDrawDestroy(menuDraws2[playerid][i]);	}}
//-----------------------------------------------------------------------------------------------------
DestroyMenuColor(playerid){
	for(new i = 0; i < 65; i++){
	     TextDrawDestroy(colordraw[playerid][i]);
		 TextDrawDestroy(colordraw[playerid][128]);
		 TextDrawDestroy(colordraw[playerid][129]);	}}
//-----------------------------------------------------------------------------------------------------
DestroyMenuColor2(playerid){
	for(new i = 65; i < TOTAL_COLORS+2; i++){
	     TextDrawDestroy(colordraw[playerid][i]);	}}
//-----------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------
DestroyMenuCartype(playerid){
	for(new i = 0; i < MAX_TYPE_ITEMS+2; i++){
	     TextDrawDestroy(menuDraws4[playerid][i]);	}}
//-----------------------------------------------------------------------------------------------------
DestroyMenuCarm(playerid){
	for(new i = itemStart[playerid][menuPlace[playerid]]; i < totalItems[playerid][menuPlace[playerid]]; i++){
         TextDrawDestroy(menuDraws3[playerid][180]);
         TextDrawDestroy(menuDraws3s[playerid]);
		 TextDrawDestroy(menuDraws3[playerid][i]);	}}
//-----------------------------------------------------------------------------------------------------
UpdateColorMenu(playerid){
colordraw[playerid][0] = TextDrawCreate(40.000000,140.000000,"  ");
colordraw[playerid][1] = TextDrawCreate(57.500000,140.000000,"  ");
colordraw[playerid][2] = TextDrawCreate(75.000000,140.000000,"  ");
colordraw[playerid][3] = TextDrawCreate(92.500000,140.000000,"  ");
colordraw[playerid][4] = TextDrawCreate(110.000000,140.000000,"  ");
colordraw[playerid][5] = TextDrawCreate(127.500000,140.000000,"  ");
colordraw[playerid][6] = TextDrawCreate(145.000000,140.000000,"  ");
colordraw[playerid][7] = TextDrawCreate(162.500000,140.000000,"  ");
colordraw[playerid][8] = TextDrawCreate(40.000000, 157.500000,"  ");
colordraw[playerid][9] = TextDrawCreate(57.500000, 157.500000,"  ");
colordraw[playerid][10] = TextDrawCreate(75.000000, 157.500000,"  ");
colordraw[playerid][11] = TextDrawCreate(92.500000, 157.500000,"  ");
colordraw[playerid][12] = TextDrawCreate(110.000000, 157.500000,"  ");
colordraw[playerid][13] = TextDrawCreate(127.500000, 157.500000,"  ");
colordraw[playerid][14] = TextDrawCreate(145.000000, 157.500000,"  ");
colordraw[playerid][15] = TextDrawCreate(162.500000, 157.500000,"  ");
colordraw[playerid][16] = TextDrawCreate(40.000000, 175.000000,"  ");
colordraw[playerid][17] = TextDrawCreate(57.500000, 175.000000,"  ");
colordraw[playerid][18] = TextDrawCreate(75.000000, 175.000000,"  ");
colordraw[playerid][19] = TextDrawCreate(92.500000, 175.000000,"  ");
colordraw[playerid][20] = TextDrawCreate(110.000000, 175.000000,"  ");
colordraw[playerid][21] = TextDrawCreate(127.500000, 175.000000,"  ");
colordraw[playerid][22] = TextDrawCreate(145.000000, 175.000000,"  ");
colordraw[playerid][23] = TextDrawCreate(162.500000, 175.000000,"  ");
colordraw[playerid][24] = TextDrawCreate(40.000000, 192.500000,"  ");
colordraw[playerid][25] = TextDrawCreate(57.500000, 192.500000,"  ");
colordraw[playerid][26] = TextDrawCreate(75.000000, 192.500000,"  ");
colordraw[playerid][27] = TextDrawCreate(92.500000, 192.500000,"  ");
colordraw[playerid][28] = TextDrawCreate(110.000000, 192.500000,"  ");
colordraw[playerid][29] = TextDrawCreate(127.500000, 192.500000,"  ");
colordraw[playerid][30] = TextDrawCreate(145.000000, 192.500000,"  ");
colordraw[playerid][31] = TextDrawCreate(162.500000, 192.500000,"  ");
colordraw[playerid][32] = TextDrawCreate(40.000000, 210.000000,"  ");
colordraw[playerid][33] = TextDrawCreate(57.500000, 210.000000,"  ");
colordraw[playerid][34] = TextDrawCreate(75.000000, 210.000000,"  ");
colordraw[playerid][35] = TextDrawCreate(92.500000, 210.000000,"  ");
colordraw[playerid][36] = TextDrawCreate(110.000000, 210.000000,"  ");
colordraw[playerid][37] = TextDrawCreate(127.500000, 210.000000,"  ");
colordraw[playerid][38] = TextDrawCreate(145.000000, 210.000000,"  ");
colordraw[playerid][39] = TextDrawCreate(162.500000, 210.000000,"  ");
colordraw[playerid][40] = TextDrawCreate(40.000000, 227.500000,"  ");
colordraw[playerid][41] = TextDrawCreate(57.500000, 227.500000,"  ");
colordraw[playerid][42] = TextDrawCreate(75.000000, 227.500000,"  ");
colordraw[playerid][43] = TextDrawCreate(92.500000, 227.500000,"  ");
colordraw[playerid][44] = TextDrawCreate(110.000000, 227.500000,"  ");
colordraw[playerid][45] = TextDrawCreate(127.500000, 227.500000,"  ");
colordraw[playerid][46] = TextDrawCreate(145.000000, 227.500000,"  ");
colordraw[playerid][47] = TextDrawCreate(162.500000, 227.500000,"  ");
colordraw[playerid][48] = TextDrawCreate(40.000000, 245.000000,"  ");
colordraw[playerid][49] = TextDrawCreate(57.500000, 245.000000,"  ");
colordraw[playerid][50] = TextDrawCreate(75.000000, 245.000000,"  ");
colordraw[playerid][51] = TextDrawCreate(92.500000, 245.000000,"  ");
colordraw[playerid][52] = TextDrawCreate(110.000000, 245.000000,"  ");
colordraw[playerid][53] = TextDrawCreate(127.500000, 245.000000,"  ");
colordraw[playerid][54] = TextDrawCreate(145.000000, 245.000000,"  ");
colordraw[playerid][55] = TextDrawCreate(162.500000, 245.000000,"  ");
colordraw[playerid][56] = TextDrawCreate(40.000000, 262.500000,"  ");
colordraw[playerid][57] = TextDrawCreate(57.500000, 262.500000,"  ");
colordraw[playerid][58] = TextDrawCreate(75.000000, 262.500000,"  ");
colordraw[playerid][59] = TextDrawCreate(92.500000, 262.500000,"  ");
colordraw[playerid][60] = TextDrawCreate(110.000000, 262.500000,"  ");
colordraw[playerid][61] = TextDrawCreate(127.500000, 262.500000,"  ");
colordraw[playerid][62] = TextDrawCreate(145.000000, 262.500000,"  ");
colordraw[playerid][63] = TextDrawCreate(162.500000, 262.500000,"  ");
colordraw[playerid][128] = TextDrawCreate(32.500000,130.000000,"                                                                                                                                                                                                                        ");
colordraw[playerid][129] = TextDrawCreate(92.500000,120.000000,"Colors Page 1");
TextDrawBackgroundColor(colordraw[playerid][128], 0x000000ff);
TextDrawBackgroundColor(colordraw[playerid][129], 0x000000ff);
TextDrawColor(colordraw[playerid][128], 0x0000ffcc);
TextDrawColor(colordraw[playerid][129], 0xffffffff);
TextDrawAlignment(colordraw[playerid][128],0);
TextDrawAlignment(colordraw[playerid][129],0);
TextDrawFont(colordraw[playerid][128], 0);
TextDrawFont(colordraw[playerid][129], 0);
TextDrawSetOutline(colordraw[playerid][129],1);
TextDrawSetProportional(colordraw[playerid][128],1);
TextDrawSetProportional(colordraw[playerid][129],1);
TextDrawLetterSize(colordraw[playerid][128], 1.000000, 1.000000);
TextDrawLetterSize(colordraw[playerid][129], 1.100000, 1.300000);
TextDrawSetShadow(colordraw[playerid][128],1);
TextDrawSetShadow(colordraw[playerid][129],1);
TextDrawTextSize(colordraw[playerid][128],172.500000,180.000000);
TextDrawUseBox(colordraw[playerid][128],1);
TextDrawUseBox(colordraw[playerid][129],0);
TextDrawBoxColor(colordraw[playerid][128], 0x00000066);
TextDrawShowForPlayer(playerid,colordraw[playerid][128]);
TextDrawShowForPlayer(playerid,colordraw[playerid][129]);
for(new g=0; g < 64; g++){
TextDrawAlignment(colordraw[playerid][g],2);
TextDrawBackgroundColor(colordraw[playerid][g], 0x000000ff);
TextDrawBoxColor(colordraw[playerid][g], CarColors[g][0]);
TextDrawColor(colordraw[playerid][g], 0xffffffff);
TextDrawFont(colordraw[playerid][g], 1);
TextDrawLetterSize(colordraw[playerid][g], 1.000000, 1.000000);
TextDrawSetOutline(colordraw[playerid][g],1);
TextDrawSetProportional(colordraw[playerid][g],1);
TextDrawSetShadow(colordraw[playerid][g],1);
TextDrawTextSize(colordraw[playerid][g],10.000000,10.000000);
TextDrawUseBox(colordraw[playerid][g],1);
TextDrawShowForPlayer(playerid,colordraw[playerid][g]);
}}
//-----------------------------------------------------------------------------------------------------
UpdateColorMenu2(playerid){
colordraw[playerid][64] = TextDrawCreate(40.000000,140.000000,"  ");
colordraw[playerid][65] = TextDrawCreate(57.500000,140.000000,"  ");
colordraw[playerid][66] = TextDrawCreate(75.000000,140.000000,"  ");
colordraw[playerid][67] = TextDrawCreate(92.500000,140.000000,"  ");
colordraw[playerid][68] = TextDrawCreate(110.000000,140.000000,"  ");
colordraw[playerid][69] = TextDrawCreate(127.500000,140.000000,"  ");
colordraw[playerid][70] = TextDrawCreate(145.000000,140.000000,"  ");
colordraw[playerid][71] = TextDrawCreate(162.500000,140.000000,"  ");
colordraw[playerid][72] = TextDrawCreate(40.000000, 157.500000,"  ");
colordraw[playerid][73] = TextDrawCreate(57.500000, 157.500000,"  ");
colordraw[playerid][74] = TextDrawCreate(75.000000, 157.500000,"  ");
colordraw[playerid][75] = TextDrawCreate(92.500000, 157.500000,"  ");
colordraw[playerid][76] = TextDrawCreate(110.000000, 157.500000,"  ");
colordraw[playerid][77] = TextDrawCreate(127.500000, 157.500000,"  ");
colordraw[playerid][78] = TextDrawCreate(145.000000, 157.500000,"  ");
colordraw[playerid][79] = TextDrawCreate(162.500000, 157.500000,"  ");
colordraw[playerid][80] = TextDrawCreate(40.000000, 175.000000,"  ");
colordraw[playerid][81] = TextDrawCreate(57.500000, 175.000000,"  ");
colordraw[playerid][82] = TextDrawCreate(75.000000, 175.000000,"  ");
colordraw[playerid][83] = TextDrawCreate(92.500000, 175.000000,"  ");
colordraw[playerid][84] = TextDrawCreate(110.000000, 175.000000,"  ");
colordraw[playerid][85] = TextDrawCreate(127.500000, 175.000000,"  ");
colordraw[playerid][86] = TextDrawCreate(145.000000, 175.000000,"  ");
colordraw[playerid][87] = TextDrawCreate(162.500000, 175.000000,"  ");
colordraw[playerid][88] = TextDrawCreate(40.000000, 192.500000,"  ");
colordraw[playerid][89] = TextDrawCreate(57.500000, 192.500000,"  ");
colordraw[playerid][90] = TextDrawCreate(75.000000, 192.500000,"  ");
colordraw[playerid][91] = TextDrawCreate(92.500000, 192.500000,"  ");
colordraw[playerid][92] = TextDrawCreate(110.000000, 192.500000,"  ");
colordraw[playerid][93] = TextDrawCreate(127.500000, 192.500000,"  ");
colordraw[playerid][94] = TextDrawCreate(145.000000, 192.500000,"  ");
colordraw[playerid][95] = TextDrawCreate(162.500000, 192.500000,"  ");
colordraw[playerid][96] = TextDrawCreate(40.000000, 210.000000,"  ");
colordraw[playerid][97] = TextDrawCreate(57.500000, 210.000000,"  ");
colordraw[playerid][98] = TextDrawCreate(75.000000, 210.000000,"  ");
colordraw[playerid][99] = TextDrawCreate(92.500000, 210.000000,"  ");
colordraw[playerid][100] = TextDrawCreate(110.000000, 210.000000,"  ");
colordraw[playerid][101] = TextDrawCreate(127.500000, 210.000000,"  ");
colordraw[playerid][102] = TextDrawCreate(145.000000, 210.000000,"  ");
colordraw[playerid][103] = TextDrawCreate(162.500000, 210.000000,"  ");
colordraw[playerid][104] = TextDrawCreate(40.000000, 227.500000,"  ");
colordraw[playerid][105] = TextDrawCreate(57.500000, 227.500000,"  ");
colordraw[playerid][106] = TextDrawCreate(75.000000, 227.500000,"  ");
colordraw[playerid][107] = TextDrawCreate(92.500000, 227.500000,"  ");
colordraw[playerid][108] = TextDrawCreate(110.000000, 227.500000,"  ");
colordraw[playerid][109] = TextDrawCreate(127.500000, 227.500000,"  ");
colordraw[playerid][110] = TextDrawCreate(145.000000, 227.500000,"  ");
colordraw[playerid][111] = TextDrawCreate(162.500000, 227.500000,"  ");
colordraw[playerid][112] = TextDrawCreate(40.000000, 245.000000,"  ");
colordraw[playerid][113] = TextDrawCreate(57.500000, 245.000000,"  ");
colordraw[playerid][114] = TextDrawCreate(75.000000, 245.000000,"  ");
colordraw[playerid][115] = TextDrawCreate(92.500000, 245.000000,"  ");
colordraw[playerid][116] = TextDrawCreate(110.000000, 245.000000,"  ");
colordraw[playerid][117] = TextDrawCreate(127.500000, 245.000000,"  ");
colordraw[playerid][118] = TextDrawCreate(145.000000, 245.000000,"  ");
colordraw[playerid][119] = TextDrawCreate(162.500000, 245.000000,"  ");
colordraw[playerid][120] = TextDrawCreate(40.000000, 262.500000,"  ");
colordraw[playerid][121] = TextDrawCreate(57.500000, 262.500000,"  ");
colordraw[playerid][122] = TextDrawCreate(75.000000, 262.500000,"  ");
colordraw[playerid][123] = TextDrawCreate(92.500000, 262.500000,"  ");
colordraw[playerid][124] = TextDrawCreate(110.000000, 262.500000,"  ");
colordraw[playerid][125] = TextDrawCreate(127.500000, 262.500000,"  ");
colordraw[playerid][126] = TextDrawCreate(145.000000, 262.500000,"  ");
colordraw[playerid][127] = TextDrawCreate(162.500000, 262.500000,"  ");
colordraw[playerid][128] = TextDrawCreate(32.500000,125.000000,"                                                                                                                                                                                                                        ");
colordraw[playerid][129] = TextDrawCreate(55.000000,120.000000,"Colors Page 2");
TextDrawBackgroundColor(colordraw[playerid][128], 0x000000ff);
TextDrawBackgroundColor(colordraw[playerid][129], 0x000000ff);
TextDrawColor(colordraw[playerid][128], 0x0000ffcc);
TextDrawColor(colordraw[playerid][129], 0xffffffff);
TextDrawAlignment(colordraw[playerid][128],0);
TextDrawAlignment(colordraw[playerid][129],0);
TextDrawFont(colordraw[playerid][128], 0);
TextDrawFont(colordraw[playerid][129], 0);
TextDrawSetOutline(colordraw[playerid][129],1);
TextDrawSetProportional(colordraw[playerid][128],1);
TextDrawSetProportional(colordraw[playerid][129],1);
TextDrawLetterSize(colordraw[playerid][128], 1.000000, 1.000000);
TextDrawLetterSize(colordraw[playerid][129], 1.100000, 1.300000);
TextDrawSetShadow(colordraw[playerid][128],1);
TextDrawSetShadow(colordraw[playerid][129],1);
TextDrawTextSize(colordraw[playerid][128],172.500000,180.000000);
TextDrawUseBox(colordraw[playerid][128],1);
TextDrawUseBox(colordraw[playerid][129],0);
TextDrawBoxColor(colordraw[playerid][128], 0x00000066);
TextDrawShowForPlayer(playerid,colordraw[playerid][128]);
TextDrawShowForPlayer(playerid,colordraw[playerid][129]);
for(new i=64; i < TOTAL_COLORS-2; i++){
TextDrawAlignment(colordraw[playerid][i],2);
TextDrawBackgroundColor(colordraw[playerid][i], 0x000000ff);
TextDrawBoxColor(colordraw[playerid][i], CarColors[i][0]);
TextDrawColor(colordraw[playerid][i], 0xffffffff);
TextDrawFont(colordraw[playerid][i], 1);
TextDrawLetterSize(colordraw[playerid][i], 1.000000, 1.000000);
TextDrawSetOutline(colordraw[playerid][i],1);
TextDrawSetProportional(colordraw[playerid][i],1);
TextDrawSetShadow(colordraw[playerid][i],1);
TextDrawTextSize(colordraw[playerid][i],10.000000,10.000000);
TextDrawUseBox(colordraw[playerid][i],1);
TextDrawShowForPlayer(playerid,colordraw[playerid][i]);
}}
//-----------------------------------------------------------------------------------------------------
UpdateColSel(playerid){
}
//-----------------------------------------------------------------------------------------------------
UpdateCarmMenu(playerid){
  		menuDraws3s[playerid] = TextDrawCreate(55.000000,107.000000,menuNames[playerid][0]);
		menuDraws3[playerid][180] = TextDrawCreate(40.00000,130.000000,"                                                                                         ");
        TextDrawAlignment(menuDraws3[playerid][180],0);
		TextDrawBackgroundColor(menuDraws3[playerid][180], 0x000000ff);
		TextDrawBoxColor(menuDraws3[playerid][180], 0x00000066);
		TextDrawColor(menuDraws3[playerid][180], 0x0000ffcc);
		TextDrawFont(menuDraws3[playerid][180], 0);
		TextDrawUseBox(menuDraws3[playerid][180],1);
		TextDrawTextSize(menuDraws3[playerid][180],205.000000,110.000000);
		TextDrawSetShadow(menuDraws3[playerid][180],1);
		TextDrawSetProportional(menuDraws3[playerid][180],1);
		TextDrawLetterSize(menuDraws3[playerid][180], 1.000000, 1.000000);
		TextDrawShowForPlayer(playerid,menuDraws3[playerid][180]);
		TextDrawAlignment(menuDraws3s[playerid],0);
		TextDrawBackgroundColor(menuDraws3s[playerid], 0x000000ff);
		TextDrawColor(menuDraws3s[playerid], 0xffffffff);
		TextDrawFont(menuDraws3s[playerid], 0);
		TextDrawUseBox(menuDraws3s[playerid],0);
		TextDrawTextSize(menuDraws3s[playerid],205.000000,110.000000);
		TextDrawSetShadow(menuDraws3s[playerid],1);
		TextDrawSetProportional(menuDraws3s[playerid],1);
		TextDrawLetterSize(menuDraws3s[playerid], 1.100000, 1.300000);
		TextDrawShowForPlayer(playerid,menuDraws3s[playerid]);
		SendClientMessage(playerid, COLOR_YELLOW,"PLZ CONFIRM4");
		for(new i = itemStart[playerid][menuPlace[playerid]]; i < totalItems[playerid][menuPlace[playerid]]; i++){
		format(menuCarNames[playerid][i], 40, "%s", carDefines[i][name]);
		SendClientMessage(playerid, COLOR_YELLOW,menuCarNames[playerid][i]);
		if (i-itemStart[playerid][menuPlace[playerid]]<=16){
     	menuDraws3[playerid][i] = TextDrawCreate( 50, (120 +((i-itemStart[playerid][menuPlace[playerid]]+1) * 12)), menuCarNames[playerid][i]);}
     	else {menuDraws3[playerid][i] = TextDrawCreate( 200, (120 +((i-itemStart[playerid][menuPlace[playerid]]-16) * 12)), menuCarNames[playerid][i]);}
      	TextDrawUseBox( menuDraws3[playerid][i] , 0);
		TextDrawAlignment(menuDraws3[playerid][i],0);
		TextDrawBackgroundColor(menuDraws3[playerid][i], 0x000000ff);
		TextDrawFont(menuDraws3[playerid][i], 3);
		TextDrawSetShadow(menuDraws3[playerid][i],1);
		TextDrawSetProportional(menuDraws3[playerid][i],1);
		TextDrawLetterSize(menuDraws3[playerid][i], 0.8, 0.7);

	    if(itemPlace[playerid][menuPlace[playerid]] == i){
	        //highlight item
			TextDrawColor( menuDraws3[playerid][i] , COLOR_WHITE);
			}

		else {
			TextDrawColor(menuDraws3[playerid][i], COLOR_LIGHTBLUE);
		}
		TextDrawTextSize( menuDraws3[playerid][i] , MENU_WIDTH, MENU_HEIGHT);
		TextDrawShowForPlayer(playerid , menuDraws3[playerid][i]);

}}
//-----------------------------------------------------------------------------------------------------
UpdatecartypeMenu(playerid){
		menuDraws4[playerid][1] = TextDrawCreate(55.000000,120.000000,"Car Types");
		menuDraws4[playerid][0] = TextDrawCreate(43.00000,125.000000,"                                                                                         ");
        TextDrawAlignment(menuDraws4[playerid][0],0);
		TextDrawBackgroundColor(menuDraws4[playerid][0], 0x000000ff);
		TextDrawBoxColor(menuDraws4[playerid][0], 0x00000066);
		TextDrawColor(menuDraws4[playerid][0], 0x0000ffcc);
		TextDrawFont(menuDraws4[playerid][0], 0);
		TextDrawUseBox(menuDraws4[playerid][0],1);
		TextDrawTextSize(menuDraws4[playerid][0],205.000000,110.000000);
		TextDrawSetShadow(menuDraws4[playerid][0],1);
		TextDrawSetProportional(menuDraws4[playerid][0],1);
		TextDrawLetterSize(menuDraws4[playerid][0], 1.000000, 1.000000);
		TextDrawShowForPlayer(playerid,menuDraws4[playerid][0]);
		TextDrawShowForPlayer(playerid,menuDraws4[playerid][1]);
  		TextDrawAlignment(menuDraws4[playerid][1],0);
		TextDrawBackgroundColor(menuDraws4[playerid][1], 0x000000ff);
		TextDrawColor(menuDraws4[playerid][1], 0xffffffff);
		TextDrawFont(menuDraws4[playerid][1], 0);
		TextDrawUseBox(menuDraws4[playerid][1],0);
		TextDrawTextSize(menuDraws4[playerid][1],205.000000,110.000000);
		TextDrawSetShadow(menuDraws4[playerid][1],1);
		TextDrawSetProportional(menuDraws4[playerid][1],1);
		TextDrawLetterSize(menuDraws4[playerid][1], 1.100000, 1.300000);
		for(new i = 2; i < MAX_TYPE_ITEMS+2; i++){
		strmid(menutypeNames[playerid][i-2], carType[i-2][typeName], 0, 40);
     	menuDraws4[playerid][i] = TextDrawCreate( 50, (130 +((i-2) * 12)), menutypeNames[playerid][i-2]);
      	TextDrawUseBox( menuDraws4[playerid][i] , 0);
		TextDrawAlignment(menuDraws4[playerid][i],0);
		TextDrawBackgroundColor(menuDraws4[playerid][i], 0x000000ff);
		TextDrawFont(menuDraws4[playerid][i], 3);
		TextDrawSetShadow(menuDraws4[playerid][i],1);
		TextDrawSetProportional(menuDraws4[playerid][i],1);
		TextDrawLetterSize(menuDraws4[playerid][i], 0.8, 0.7);

	    if(itemPlace[playerid][menuPlace[playerid]] == i-2){
	        //highlight item
			TextDrawColor( menuDraws4[playerid][i] , COLOR_WHITE);
			}

		else {
			TextDrawColor(menuDraws4[playerid][i], COLOR_LIGHTBLUE);
		}
		TextDrawTextSize( menuDraws4[playerid][i] , MENU_WIDTH, MENU_HEIGHT);
		TextDrawShowForPlayer(playerid , menuDraws4[playerid][i]);

}}
//-----------------------------------------------------------------------------------------------------
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
		TextDrawTextSize(menuDraws2[playerid][i],200.0,50.0);
		TextDrawAlignment(menuDraws2[playerid][i],1);
		TextDrawBackgroundColor(menuDraws2[playerid][i],0x000000ff);
		TextDrawFont(menuDraws2[playerid][i],1);
		TextDrawLetterSize(menuDraws2[playerid][i],0.9,0.9);
		TextDrawSetProportional(menuDraws2[playerid][i],1);
		TextDrawSetShadow(menuDraws2[playerid][i],1);
	    if(menuPlace2[playerid] == i){
	        //highlight item
			TextDrawColor(menuDraws2[playerid][i] , COLOR_WHITE);
			}

		else {
			TextDrawColor(menuDraws2[playerid][i], COLOR_LIGHTBLUE);
		}
		TextDrawShowForPlayer(playerid , menuDraws2[playerid][i]);
	}
		}
//-----------------------------------------------------------------------------------------------------
UpdatespideyMenu(playerid){


	menuDraws[playerid][6] = TextDrawCreate(45.000000,155.000000,"                                                                                                                                                                                          ");
	TextDrawAlignment(menuDraws[playerid][6],0);
	TextDrawBoxColor(menuDraws[playerid][6], COLOR_BLACK);
	TextDrawFont(menuDraws[playerid][6], 0);
	TextDrawUseBox(menuDraws[playerid][6],1);
	TextDrawTextSize(menuDraws[playerid][6],210.000000,120.000000);
	TextDrawSetShadow(menuDraws[playerid][6],1);
	TextDrawSetProportional(menuDraws[playerid][6],1);
	TextDrawLetterSize(menuDraws[playerid][6], 1.000000, 1.000000);
	TextDrawShowForPlayer(playerid,menuDraws[playerid][6]);

	//Vehicle Type Text Update
	
	strmid(menuNames[playerid][0], carType[itemPlace[playerid][0]][typeName], 0, 40, 40);
	
	//Model Text Update
	format(menuNames[playerid][1], 40, "%s", carDefines[itemPlace[playerid][1]][name]);

	//COLORS Text Update
	format(menuNames[playerid][2], 40, "COLOR1 - %d", itemPlace[playerid][2]);
	format(menuNames[playerid][3], 40, "COLOR2 - %d", itemPlace[playerid][3]);
	format(menuNames[playerid][4], 40, "Buy It!");
	format(menuNames[playerid][5], 40, "Exit");
	for(new i = 0; i < MAX_MENU_ITEMS; i++){
	
     	menuDraws[playerid][i] = TextDrawCreate( 50, (160 +(i * 12)), menuNames[playerid][i]);
      	TextDrawUseBox( menuDraws[playerid][i] , 0);
		TextDrawAlignment(menuDraws[playerid][i],1);
		TextDrawBackgroundColor(menuDraws[playerid][i], 0x000000ff);
		TextDrawFont(menuDraws[playerid][i], 3);
		TextDrawSetShadow(menuDraws[playerid][i],1);
		TextDrawSetProportional(menuDraws[playerid][i],1);
		TextDrawLetterSize(menuDraws[playerid][i], 0.8, 0.7);

	    if(menuPlace[playerid] == i){
			TextDrawColor( menuDraws[playerid][i], COLOR_WHITE);
			}
		else {
			TextDrawColor(menuDraws[playerid][i], COLOR_LIGHTBLUE);
		}
		TextDrawTextSize( menuDraws[playerid][i] , MENU_WIDTH, MENU_HEIGHT);
		TextDrawShowForPlayer(playerid , menuDraws[playerid][i]);
	}
}
//-----------------------------------------------------------------------------------------------------
UpdateNextCar( playerid ){
	if(playerCar[playerid][CURRENT] == MAX_PLAYER_CARS -1 ){
	    playerCar[playerid][CURRENT] = 0;
	    
	}
	else{
	    playerCar[playerid][CURRENT]++;
	}
	
	if(playerCar[playerid][END_CAR] == MAX_PLAYER_CARS -1){
	    playerCar[playerid][END_CAR] = 0;
 	}
 	else{
		playerCar[playerid][END_CAR]++;
	}
}
//-----------------------------------------------------------------------------------------------------
FlagVehicleDestroy( vehicleid ){
	SetVehicleToRespawn(vehicleid);
	SetTimerEx("DestroyVehicleEx", 250, false, "i", vehicleid);
}
//-----------------------------------------------------------------------------------------------------
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
//-----------------------------------------------------------------------------------------------------
strtok(const string[], &index,seperator=' ')
{
	new length = strlen(string);
	new offset = index;
	new result[255];
	while ((index < length) && (string[index] != seperator) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}

	result[index - offset] = EOS;
	if ((index < length) && (string[index] == seperator))
	{
		index++;
	}
	return result;
}
//-----------------------------------------------------------------------------------------------------
Float:GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a ,Float:z;
	GetPlayerPos(playerid, x, y, z);
	if (IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	else GetPlayerFacingAngle(playerid, a);
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
	return z;
}
//-----------------------------------------------------------------------------------------------------
stock GetVehicleWithinDistance( playerid, Float:x1, Float:y1, Float:z1, Float:dist, &veh){
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
//-----------------------------------------------------------------------------------------------------
LoadCarDefines(fileName[255])
{
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
				    printf("CarType End %d - %d , %s", j-1, carType[j-1][typeEnd], carType[j-1][typeName]);
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
				strcat(carDefines[i][name], name2, 255);
				tmp = strtok(line, idx);
				price = strval(tmp);
				carDefines[i][Price] = price;
				tmp = strtok(line, idx);
				fuelv = strval(tmp);
				carDefines[i][Fuel] = fuelv;
				tmp = strtok(line, idx);
				tank3 = strval(tmp);
				carDefines[i][Tank] = tank3;
				printf("ID: %d   Name: %s   Price: %d   Fuel: %d   Tank: %d   \n", carDefines[i][ID], carDefines[i][name], carDefines[i][Price], carDefines[i][Fuel], carDefines[i][Tank]);
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
//-----------------------------------------------------------------------------------------------------
LoadTotalItems()
{
	for(new i = 0; i < GetMaxPlayers(); i++){
	    totalItems[i][1] = carType[0][typeEnd];
	    totalItems[i][2] = TOTAL_COLORS;
	    totalItems[i][3] = TOTAL_COLORS;
	}
}
//-----------------------------------------------------------------------------------------------------
LockCarForAll(vehicleid, bool:lock){
	for(new i = 0; i < GetMaxPlayers(); i++ ){
		SetVehicleParamsForPlayer(vehicleid, i, false, lock);
	}
}
//-----------------------------------------------------------------------------------------------------
public IsPlayerVehicle(vehicleid, playerid){
	for(new i = 0; i < GetMaxPlayers(); i++){
		for( new j = 0; j < MAX_PLAYER_CARS; j++ ){
		    if(CurrentCar[i][j] == vehicleid){
		        SendClientMessage( playerid, COLOR_RED, "Player Car - Cannot Delete" );
		        return 1;
			}
		}
	}
	FlagVehicleDestroy(vehicleid);
	SendClientMessage(playerid, COLOR_GREEN, "Vehicle Destroyed");
	return 1;}
//-----------------------------------------------------------------------------------------------------
public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;}
//-----------------------------------------------------------------------------------------------------
public checkpointupdate()
{
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
//-----------------------------------------------------------------------------------------------------
public getCheckpointType(playerID) {
        return checkpointType[playerCheckpoint[playerID]];
}
//-----------------------------------------------------------------------------------------------------
public Speedometer()
{
new tmp[255];
new string[255];
new stringi[255];
new stringj[255];
for(new i = 0; i < MAX_PLAYERS; i++){
		if(IsPlayerConnected(i))
		{
			CalculateSpeed(i); // SpeedoInfo[i][speed] wird für jeden spieler jede sekunde berechnet
			for(new j = 0; j < MAX_VEHICLES;j++){
			for (new h=0;h<MAX_CARS;h++){
			if (carDefines[h][ID]== GetVehicleModel(j)/* && enginestatus[j]==1*/){
				if (tank[j]>0){tank[j] = tank[j]-(carDefines[h][Fuel]/2);}
				if (oilpress[j]==0){ oilpress[j]=300;}
				if (oilpress[j]>300 && oildamage[j]==0){oilpress[j]=oilpress[j]-2;}
				else if (oilpress[j]>300 && oildamage[j]==1){oilpress[j]=oilpress[j]-1;}
			}}}
			if(GetPlayerState(i) == PLAYER_STATE_DRIVER)
			{
		new wid = GetPlayerVehicleID(i);
		new wm = GetVehicleModel(wid);
		for (new h=0;h<MAX_CARS;h++){
		if (carDefines[h][ID]==wm){
			if (Speedom[i]>0){
				if (tank[wid]>0){
				meters[wid] = meters[wid] + (Speedom[i]);
				tank[wid] = tank[wid]-(carDefines[h][Fuel]*Speedom[i]);	}}
			else{
				if (tank[wid]>0){
				tank[wid] = tank[wid]-(carDefines[h][Fuel]/2);
		}}}}

		switch(SpeedoInfo[i][metric]){
	case true : {
		format(tmp, sizeof(tmp), "Km/h:%d", (Speedo[i]));
		format(stringi, sizeof(stringi), "KM : %d", meters[wid]/1000);
		if (Speedo[i]>=25 && Speedo[i]<50){oilpress[wid]=oilpress[wid]+1;}
		else if (Speedo[i]>=50 && Speedo[i]<100){oilpress[wid]=oilpress[wid]+2;}
		else if (Speedo[i]>=100 && Speedo[i]<170){oilpress[wid]=oilpress[wid]+3;}
		else if (Speedo[i]>=170){oilpress[wid]=oilpress[wid]+4;}}
	case false: {
		format(tmp, sizeof(tmp), "M/h:%d", ((Speedo[i])/1.6));
		format(stringi, sizeof(stringi), "Miles : %d", meters[wid]/1600);
		if (Speedo[i]>=25/1.6 && Speedo[i]<50/1.6){oilpress[wid]=oilpress[wid]+1;}
		else if (Speedo[i]>=50/1.6 && Speedo[i]<100/1.6){oilpress[wid]=oilpress[wid]+2;}
		else if (Speedo[i]>=100/1.6 && Speedo[i]<170/1.6){oilpress[wid]=oilpress[wid]+3;}
		else if (Speedo[i]>=170/1.6){oilpress[wid]=oilpress[wid]+4;}}}


		if (tank[wid]<50000000 && messagesend2[wid]==0 && messagesend3[wid]==0) {
			SendClientMessage(i, COLOR_YELLOW, "Ur gas is running low. Drive to the next gas-station to refuel.");
			messagesend2[wid]=1;}
		else if (tank[wid]>=50000000 && messagesend2[wid]==1){messagesend2[wid]=0;}
		if (tank[wid]<1000000){
			format(string, sizeof(string), "EMPTY");
			if (messagesend3[wid]==0) {
				SendClientMessage(i, COLOR_YELLOW, "U ran out of gas. Call a mechanic to tow away ur car to the next gas-station");
				messagesend3[wid]=1;}
			SinGas[i]=wid;
			TogglePlayerControllable(i,false);
			tank[wid]=0;}
		else {
			format(string, sizeof(string), "Fuel:%d L", tank[wid]/1000000);
			messagesend3[wid]=0;}
		if (oilpress[wid]>=1000){
				oildamage[wid] = oildamage[wid]+1;
				oilpress[wid]=999;
				if (oildamage[wid]==1){
				SendClientMessage(i, COLOR_YELLOW, "U wrecked the car. The Oilpump is damage. Turn off the engine to prevent damage to the car.");
				SendClientMessage(i, COLOR_YELLOW, "The engine must cool down for 2mins. After that its recommended to drive slowly and let it repair as quickly as possible.");
				messagesend[wid]=1;
				TogglePlayerControllable(i,false);
				SinGas[i]=wid;}
			 	if (oildamage[wid]==2){
				SendClientMessage(i, COLOR_YELLOW, "U wrecked the car total. The Oilpump catched fire. U have 5sec to leave before the car explode!!!");
				TogglePlayerControllable(i,false);
				SinGas[i]=wid;}}
		if (oilpress[wid]<=880){
				if (oildamage[wid]==1 && messagesend[wid]==0){
				SendClientMessage(i, COLOR_YELLOW, "Car cooled down. Drive slowly to avoide raising the Oilpressure.");
				messagesend[wid]=1;
				TogglePlayerControllable(i,true);}}
		else {
				if (oildamage[wid]==1 && messagesend[wid]==0){
				SendClientMessage(i, COLOR_YELLOW, "The engine is still cooling down. Wait a little bit longer.");
				TogglePlayerControllable(i,false);
				SinGas[i]=wid;}}

      	KMString[i]=stringi;
		SpeedString[i]=tmp;
		format(stringj, sizeof(stringj), "Oil: %d", oilpress[wid]/10);
		OilString[i]=stringj;
		TankString[i]=string;
		format(tmp, sizeof(tmp),"%s %s %s %s",TankString[i],SpeedString[i],KMString[i], OilString[i]);
		TextDrawSetString(medidorTanque[i],tmp);
		return 1;
		}}
		Speedo[i] = 0;
		Speedom[i] = 0;
		}
return 1;
}
//--------------------------------------------------------------------------------------------------------------------------------
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
TextDrawShowForPlayer(i,vehiclebar[11]);}}}
return 1;
}
