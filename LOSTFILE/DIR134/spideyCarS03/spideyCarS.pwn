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
#define MENU_X 5.0
#define MENU_Y 200.0
#define SPACER 17.5
#define MENU_WIDTH 205.0
#define MENU_HEIGHT 50.0
#define MAX_MENUG_ITEMS 3
#define MAX_MENU_ITEMS 4
// Menu Player Variables & Defines
#define TOTAL_COLORS 126
#define CURRENT 0
#define END_CAR 1

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
new Text:menuDraws2[MAX_PLAYERS][MAX_MENUG_ITEMS];
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
new PlayerTimer[MAX_PLAYERS][2];
new menuPlace[MAX_PLAYERS];
new itemPlace[MAX_PLAYERS][MAX_MENU_ITEMS];
new Text:menuDraws[MAX_PLAYERS][MAX_MENU_ITEMS+3];
new menuNames[MAX_PLAYERS][MAX_MENU_ITEMS][40];
new totalItems[MAX_PLAYERS][MAX_MENU_ITEMS];
new itemStart[MAX_PLAYERS][MAX_MENU_ITEMS];
new Float:PlayerPos[MAX_PLAYERS][4];
new CurrentCar[MAX_PLAYERS][MAX_PLAYER_CARS];
new playerCar[MAX_PLAYERS][2];
new bool:destroyCar[MAX_PLAYERS][2];
new bool:carSelect[MAX_PLAYERS];
//-----------------------------------------------------------------------------------------------------
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
   		medidorTanque[i] = TextDrawCreate(508.0,127.0,"Fuel:0000 L Km|h:000 KM : 000 Oil: 00");
//   	TextDrawUseBox(medidorTanque[i],1);
//		TextDrawBoxColor(medidorTanque[i],0x000000cc);
		TextDrawTextSize(medidorTanque[i],602.0,0.0);
		TextDrawAlignment(medidorTanque[i],0);
//		TextDrawBackgroundColor(medidorTanque[i],0x000000ff);
		TextDrawFont(medidorTanque[i],3);
		TextDrawLetterSize(medidorTanque[i],0.6,1.0);
		TextDrawColor(medidorTanque[i],0x00ff0066);
		TextDrawSetProportional(medidorTanque[i],0);
		TextDrawSetShadow(medidorTanque[i],1);
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
	if (newstate==PLAYER_STATE_DRIVER && SpeedoInfo[playerid][enabled])
	    {
	    TextDrawShowForPlayer(playerid,medidorTanque[playerid]);
    	new Float:x,Float:y,Float:z;
    	GetPlayerPos(playerid,x,y,z);
		SavePlayerPos[playerid][LastX] = x;
	    SavePlayerPos[playerid][LastY] = y;
	 	SavePlayerPos[playerid][LastZ] = z;
		}
	if (newstate==PLAYER_STATE_PASSENGER && SpeedoInfo[playerid][enabled])
	    {
	    TextDrawShowForPlayer(playerid,medidorTanque[playerid]);
	    }
	if (newstate==PLAYER_STATE_ONFOOT)
	    {
	    TextDrawHideForPlayer(playerid,medidorTanque[playerid]);
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
	if	((strcmp(cmd,"/text", true)==0))
	  		{
new Text:Textdraw0;
new Text:Textdraw1;
new Text:Textdraw2;
new Text:Textdraw3;
new Text:Textdraw4;
Textdraw0 = TextDrawCreate(120.000000,130.000000,"                                                                                                                                ");
Textdraw1 = TextDrawCreate(40.000000,140.000000,"  ");
Textdraw2 = TextDrawCreate(65.000000,140.000000,"  ");
Textdraw3 = TextDrawCreate(40.000000,165.000000,"  ");
Textdraw4 = TextDrawCreate(45.000000,120.000000,"Colors");
TextDrawUseBox(Textdraw0,1);
TextDrawBoxColor(Textdraw0,0x00000066);
TextDrawTextSize(Textdraw0,120.000000,160.000000);
TextDrawUseBox(Textdraw1,1);
TextDrawBoxColor(Textdraw1,0xff0000ff);
TextDrawTextSize(Textdraw1,10.000000,10.000000);
TextDrawUseBox(Textdraw2,1);
TextDrawBoxColor(Textdraw2,0x0000ffff);
TextDrawTextSize(Textdraw2,10.000000,10.000000);
TextDrawUseBox(Textdraw3,1);
TextDrawBoxColor(Textdraw3,0x00ff00ff);
TextDrawTextSize(Textdraw3,10.000000,10.000000);
TextDrawAlignment(Textdraw0,2);
TextDrawAlignment(Textdraw1,2);
TextDrawAlignment(Textdraw2,2);
TextDrawAlignment(Textdraw3,2);
TextDrawAlignment(Textdraw4,0);
TextDrawBackgroundColor(Textdraw0,0x000000ff);
TextDrawBackgroundColor(Textdraw1,0x000000ff);
TextDrawBackgroundColor(Textdraw2,0x000000ff);
TextDrawBackgroundColor(Textdraw3,0x000000ff);
TextDrawBackgroundColor(Textdraw4,0x000000ff);
TextDrawFont(Textdraw0,0);
TextDrawLetterSize(Textdraw0,1.000000,1.000000);
TextDrawFont(Textdraw1,3);
TextDrawLetterSize(Textdraw1,1.000000,1.000000);
TextDrawFont(Textdraw2,3);
TextDrawLetterSize(Textdraw2,1.000000,1.000000);
TextDrawFont(Textdraw3,3);
TextDrawLetterSize(Textdraw3,1.000000,1.000000);
TextDrawFont(Textdraw4,0);
TextDrawLetterSize(Textdraw4,1.100000,1.300000);
TextDrawColor(Textdraw0,0x0000ffcc);
TextDrawColor(Textdraw1,0xffffffff);
TextDrawColor(Textdraw2,0xffffffff);
TextDrawColor(Textdraw3,0xffffffff);
TextDrawColor(Textdraw4,0xffffffff);
TextDrawSetOutline(Textdraw1,1);
TextDrawSetOutline(Textdraw2,1);
TextDrawSetOutline(Textdraw3,1);
TextDrawSetOutline(Textdraw4,1);
TextDrawSetProportional(Textdraw1,1);
TextDrawSetProportional(Textdraw2,1);
TextDrawSetProportional(Textdraw3,1);
TextDrawSetProportional(Textdraw4,1);
TextDrawSetShadow(Textdraw0,1);
TextDrawSetShadow(Textdraw1,1);
TextDrawSetShadow(Textdraw2,1);
TextDrawSetShadow(Textdraw3,1);
TextDrawSetShadow(Textdraw4,1);
TextDrawShowForPlayer(playerid,Textdraw0);
TextDrawShowForPlayer(playerid,Textdraw1);
TextDrawShowForPlayer(playerid,Textdraw2);
TextDrawShowForPlayer(playerid,Textdraw3);
TextDrawShowForPlayer(playerid,Textdraw4);
return 1;}
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
			format(string, sizeof(string), "Fuel:%d", tank[vid]/1000000);
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
public carSelector(playerid){
	if(IsPlayerConnected(playerid)){
	    new Keys[3];
	    GetPlayerKeys(playerid, Keys[0], Keys[1], Keys[2]);
	    if(Keys[1] == KEY_UP ){
	        menuPlace[playerid] = (menuPlace[playerid] == 0) ?(MAX_MENU_ITEMS-1):menuPlace[playerid]-1;
	        
	        DestroyMenuCar(playerid);
	        UpdateCar(playerid);
	        UpdatespideyMenu(playerid);
		 }
		if(Keys[1] == KEY_DOWN ){
	        menuPlace[playerid] = (menuPlace[playerid] == MAX_MENU_ITEMS-1) ? 0:menuPlace[playerid]+1;

	        DestroyMenuCar(playerid);
	        UpdateCar(playerid);
	        UpdatespideyMenu(playerid);
		 }
	 	if(Keys[2] == KEY_RIGHT ){
	 	
	        itemPlace[playerid][menuPlace[playerid]] = (itemPlace[playerid][menuPlace[playerid]] == totalItems[playerid][menuPlace[playerid]]-1 ) ? itemStart[playerid][menuPlace[playerid]]:itemPlace[playerid][menuPlace[playerid]]+1;

			if(menuPlace[playerid] == 0){
				itemStart[playerid][1] = carType[itemPlace[playerid][menuPlace[playerid]]][typeStart];
				totalItems[playerid][1] = carType[itemPlace[playerid][menuPlace[playerid]]][typeEnd];
				itemPlace[playerid][1] = itemStart[playerid][1];
			}
	        DestroyMenuCar(playerid);
	        UpdateCar(playerid);
	        UpdatespideyMenu(playerid);
		 }
	 	if(Keys[2] == KEY_LEFT ){
	        itemPlace[playerid][menuPlace[playerid]] = (itemPlace[playerid][menuPlace[playerid]] == itemStart[playerid][menuPlace[playerid]] ) ? totalItems[playerid][menuPlace[playerid]]-1:itemPlace[playerid][menuPlace[playerid]]-1;

			if(menuPlace[playerid] == 0){
				itemStart[playerid][1] = carType[itemPlace[playerid][menuPlace[playerid]]][typeStart];
				totalItems[playerid][1] = carType[itemPlace[playerid][menuPlace[playerid]]][typeEnd];
				itemPlace[playerid][1] = itemStart[playerid][1];
			}
			
	        DestroyMenuCar(playerid);
	        UpdateCar(playerid);
	        UpdatespideyMenu(playerid);
		 }
		if(Keys[0] == KEY_JUMP ){
		    carSelect[playerid] = true;
		    KillTimer(PlayerTimer[playerid][0]);
		    PlayerTimer[playerid][1] = 0;
			DestroyMenuCar(playerid);
			TogglePlayerSpectating(playerid, 0);
			LockCarForAll( CurrentCar[ playerid ][ playerCar[ playerid ][ CURRENT ] ], false );
			PutPlayerInVehicle(playerid, CurrentCar[playerid][playerCar[playerid][CURRENT]], 0);
			destroyCar[playerid][1] = false;
			destroyCar[playerid][0] = true;
			CallRemoteFunction("CarSelectMenu", "ii", playerid, 0);
			}   	}}
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
	for(new i = 0; i < MAX_MENU_ITEMS+3; i++){
	     TextDrawDestroy(menuDraws[playerid][i]);	}}
//-----------------------------------------------------------------------------------------------------
DestroyMenuGas(playerid){
	for(new i = 0; i < MAX_MENUG_ITEMS; i++){
	     TextDrawDestroy(menuDraws2[playerid][i]);	}}
//-----------------------------------------------------------------------------------------------------
UpdategasMenu(playerid){
		format(menuliter[playerid][0], 40, "Full Tank");
		format(menuliter[playerid][1], 40, "Refuel: %d Liters", liters[playerid]);
		format(menuliter[playerid][2], 40, "Exit");
				//menuDraws2[playerid] = TextDrawCreate(150, 200, "blibla");
				//TextDrawSetString(menuDraws2[playerid],menuliter[playerid]);
				//TextDrawShowForPlayer(playerid , menuDraws2[playerid]);
		for(new i = 0; i < MAX_MENUG_ITEMS; i++){
     	menuDraws2[playerid][i] = TextDrawCreate( 20, (200 +(i * 15)), menuliter[playerid][i]);
      	TextDrawUseBox(menuDraws2[playerid][i],1);
		TextDrawBoxColor(menuDraws2[playerid][i],COLOR_BLACK);
		TextDrawTextSize(menuDraws2[playerid][i],200.0,50.0);
		TextDrawAlignment(menuDraws2[playerid][i],0);
		TextDrawBackgroundColor(menuDraws2[playerid][i],COLOR_GREEN);
		TextDrawFont(menuDraws2[playerid][i],1);
		TextDrawLetterSize(menuDraws2[playerid][i],0.8,0.8);
		TextDrawSetProportional(menuDraws2[playerid][i],0);
		TextDrawSetShadow(menuDraws2[playerid][i],1);
	    if(menuPlace2[playerid] == i){
	        //highlight item
			TextDrawColor(menuDraws2[playerid][i] , COLOR_WHITE);
			}

		else {
			TextDrawColor(menuDraws2[playerid][i], COLOR_BLUE);
		}
		TextDrawShowForPlayer(playerid , menuDraws2[playerid][i]);
	}
		}
//-----------------------------------------------------------------------------------------------------
UpdatespideyMenu(playerid){

	//Screen Info - Instructions
	menuDraws[playerid][5] = TextDrawCreate( 0, MENU_Y - 25, " Spideys Car Select 0.2");
	TextDrawUseBox( menuDraws[playerid][5] , true);
	TextDrawBoxColor( menuDraws[playerid][5] , 0x000000FF);
	TextDrawTextSize( menuDraws[playerid][5] , 210, 50);
	TextDrawFont(menuDraws[playerid][5], 3);
	TextDrawShowForPlayer(playerid , menuDraws[playerid][5]);
	
	menuDraws[playerid][6] = TextDrawCreate( 0, MENU_Y +(SPACER * MAX_MENU_ITEMS + 5.0), "Use Arrow Keys to Navigate and Shift_Key(jump_key) to Select");
	TextDrawUseBox( menuDraws[playerid][6] , true);
	TextDrawBoxColor( menuDraws[playerid][6] , 0x000000FF);
	TextDrawTextSize( menuDraws[playerid][6] , 210, 50);
	TextDrawFont(menuDraws[playerid][6], 1);
	TextDrawSetProportional(menuDraws[playerid][6], true);
	TextDrawShowForPlayer(playerid , menuDraws[playerid][6]);
	
	menuDraws[playerid][4] = TextDrawCreate( 0, MENU_Y - 10, "                                           ");
	TextDrawUseBox( menuDraws[playerid][4] , true);
	TextDrawBoxColor( menuDraws[playerid][4] , 0xFFFFFFFF);
	TextDrawTextSize( menuDraws[playerid][4] , 210, 50);
	
	TextDrawAlignment(menuDraws[playerid][4], 1);
	TextDrawLetterSize(menuDraws[playerid][4], 1.0, 1.0);
	TextDrawSetProportional(menuDraws[playerid][4], true);
	TextDrawShowForPlayer(playerid , menuDraws[playerid][4]);

	//Vehicle Type Text Update
	
	strmid( menuNames[playerid][0], carType[itemPlace[playerid][0]][typeName], 0, 40);
	
	//Model Text Update
	format(menuNames[playerid][1], 40, "%s-%d", carDefines[itemPlace[playerid][1]][name],  carDefines[itemPlace[playerid][1]][ID]);

	//COLORS Text Update
	format(menuNames[playerid][2], 40, "COLOR1 - %d", itemPlace[playerid][2]);
	format(menuNames[playerid][3], 40, "COLOR2 - %d", itemPlace[playerid][3]);
	
	for(new i = 0; i < MAX_MENU_ITEMS; i++){
	
     	menuDraws[playerid][i] = TextDrawCreate( MENU_X, (MENU_Y +(i * SPACER)), menuNames[playerid][i]);
      	TextDrawUseBox( menuDraws[playerid][i] , true);
      	
	    if(menuPlace[playerid] == i){
	        //highlight item
			TextDrawBoxColor( menuDraws[playerid][i] , 0x000000FF);
			}
		
		else {
			TextDrawBoxColor(menuDraws[playerid][i], COLOR_BLACK);
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
				    printf("CarType End %d - %d", j-1, carType[j-1][typeEnd]);
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
public gasSelector(playerid){
	if(IsPlayerConnected(playerid)){
		new Keys[3];
		new string2[255];
		new string[255];
		new tmp[255];
		new vid = GetPlayerVehicleID(playerid);
		new wm = GetVehicleModel(vid);
	    GetPlayerKeys(playerid, Keys[0], Keys[1], Keys[2]);
		for (new h=0;h<MAX_CARS;h++){
		if (carDefines[h][ID]==wm){
			
			if(Keys[1] == KEY_UP){
		        menuPlace2[playerid] = menuPlace2[playerid]-1;
				if(menuPlace2[playerid] < 0){ menuPlace2[playerid] = 2;}
                DestroyMenuGas(playerid);
				UpdategasMenu(playerid);
			 }
			if(Keys[1] == KEY_DOWN ){
		        menuPlace2[playerid] = menuPlace2[playerid]+1;
				if(menuPlace2[playerid] > 2){ menuPlace2[playerid] = 0;}
                DestroyMenuGas(playerid);
				UpdategasMenu(playerid);
		 	}
			if(Keys[2] == KEY_RIGHT ){
			if((liters[playerid] - tank[vid]/1000000 < carDefines[h][Tank]/10) && menuPlace2[playerid]==1){
				liters[playerid] = liters[playerid]+1;
                DestroyMenuGas(playerid);
				UpdategasMenu(playerid);
	 		}}

			if(Keys[2] == KEY_LEFT ){
			if(liters[playerid] > 0 && menuPlace2[playerid]==1){
				liters[playerid] = liters[playerid]-1;
                DestroyMenuGas(playerid);
				UpdategasMenu(playerid);}}
            if(Keys[0] == KEY_JUMP ){
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
					format(string, sizeof(string), "Fuel:%d", tank[vid]/1000000);
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
					format(string, sizeof(string), "Fuel:%d", tank[vid]/1000000);
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
		format(tmp, sizeof(tmp), "Km|h:%d", (Speedo[i]));
		format(stringi, sizeof(stringi), "KM : %d", meters[wid]/1000);
		if (Speedo[i]>=25 && Speedo[i]<50){oilpress[wid]=oilpress[wid]+1;}
		else if (Speedo[i]>=50 && Speedo[i]<100){oilpress[wid]=oilpress[wid]+2;}
		else if (Speedo[i]>=100 && Speedo[i]<170){oilpress[wid]=oilpress[wid]+3;}
		else if (Speedo[i]>=170){oilpress[wid]=oilpress[wid]+4;}}
	case false: {
		format(tmp, sizeof(tmp), "M|h:%d", ((Speedo[i])/1.6));
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
			format(string, sizeof(string), "Fuel:%d", tank[wid]/1000000);
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
