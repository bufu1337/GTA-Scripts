/* == [Conditions] == *\
# This Filterscript was scripted by Mike for release on the San Andreas Multiplayer forums.
# Do not remove any credits or sell this script.
# Selling this script on the SA:MP market will get your ass banned.

CREDITS:

Main Scripter ~ Mike
Vnames array ~  WeeDarr
*/

#error Please agree to the conditions.
//Remove/Comment the above line if you agree to the conditions.

#include <a_samp>

/* ===[DEFINES]=== */
#define car_names //Remove this is you dont want the car names.
#define wait_time 4 //How many minutes must a player wait to sell another car?
#define reset_time 5 //How any seconds until the players camera resets?
#define last_car_bonus 100 //Whoever sells the last car will get 100 points, you may change this
#define sell_car_bonus 10  //How many points will a player get EVERYTIME he sells a car?
#define show_export_cmd "/showexport"   //What command will be used to view the export board?
#define hide_export_cmd "/hideexport"   //What command will be used to hide the export board?
#define clear_export_cmd "/clearexport" //What command will be used to clear the export (admins)?
#define car_names_cmd "/carnames" //What command can be used to hide or show car names when a player enters a vehicle?
#define help_pickup true //Do you want the pickup to be shown next to the board for help?
#define use_icon true //Should the MapIcon be shown?
#define sell_car_sound 1137  //Choose the sound ID for when you enter the checkpoint with a vehicle and its sold
#define slamvan_price 50000  //Price of the Slamvan
#define blista_price 30000   //Price of the Blista Compact
#define stafford_price 15000 //Price of the Stafford
#define sabre_price 5000 //Price of the Sabre
#define FCR_price 30000 //Price of the FCR-600
#define cheetah_price 30000 //Price of the Cheetah
#define rancher_price 15000 //Price of the Rancher
#define stallion_price 10000 //Price of the Stallion
#define tanker_price 70000 //Price of the Tanker
#define comet_price 50000 //Price of the Comet
#define sold_for_gametext 4   //Select the Gametext style, used on the gametext that says for example: "FCR-600 sold for $50000"
#define already_sold_gametext 5 //The gametext used if a vehicle is already sold

/* ===[COLORS]=== */
#define COLOR_GREEN 0x33AA33AA  //GREEN
#define COLOR_WHITE 0xFFFFFFAA  //WHITE
#define COLOR_RED 0xFF0000AA    //RED
#define COLOR_YELLOW 0xFFFF00AA //YELLOW
#define COLOR_ORANGE 0xFF9900AA //ORANGE

/* ===[FORWARDS]=== */
forward excam(playerid); //The timer for the camera resetting after selling a car
forward exdel(playerid); //The delay between selling cars

/* ===[VARIABLES]=== */
new sold1;  //Slamvan
new sold2;  //Blista Compact
new sold3;  //Stafford
new sold4;  //Sabre
new sold5;  //FCR-600
new sold6;  //Cheetah
new sold7;  //Rancher
new sold8;  //Stallion
new sold9;  //Tanker
new sold10; //Comet

new cross1;
new cross2;
new cross3;
new cross4;
new cross5;
new cross6;
new cross7;
new cross8;
new cross9;
new cross10;

new board;   //Used for DestroyObject OnFilterScriptExit.
new writing; //Used for DestroyObject OnFilterScriptExit.

#if help_pickup == true //If "help_pickup" is defined as "true"
new exhelp; //Pickup
#endif
new sellon[MAX_PLAYERS]; //Allowed to sell a car?
new checkon[MAX_PLAYERS]; //Checkpoint visable?

new carnames[MAX_PLAYERS]; //Carnames snabled?

new Float:oldpos[200][4]; //Saves the position when someone types the command to show
// the export board and sets it then someone types the command for hiding the export board.

/* ===[ARRAYS]=== */
new vNames[][] = //Thankyou WeeDarr for giving me this array
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxvillde", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Freight", "Streak", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car", "Police Car", "Police Car",
    "Police Ranger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("Mikes Car Export Script"); //Print stuff in the console, remove if you wish
	print("--------------------------------------\n");

	board = CreateObject(3077, -1534.66, 154.03, 2.50, 0.00, 0.00, 360.00);   //Board object
	writing = CreateObject(3087, -1534.51, 154.05, 2.52, 0.00, 0.00, 180.00); //Writing object
	#if help_pickup == true //If "help_pickup" is defined as "true"
	exhelp = CreatePickup(1239,23,-1538.0724,154.1241,3.5547); //The pickup
	#endif
	for(new i=0; i < MAX_PLAYERS; i++)
	{
	    #if use_icon == true
	    SetPlayerMapIcon(i, 20, -1545.0740,128.1534,3.5547, 55, 0 ); //Set the map icon for the player
	    #endif
		if(sellon[i] == 0) //If they cant sell cars
		{
		sellon[i] = 1;   //Enable all players to sell cars
		}
		if(checkon[i] == 0) //If the checkpoint isnt visable by the player
		{
			if(IsPlayerConnected(i))
			{
			SetPlayerCheckpoint(i, -1545.0740,128.1534,3.5547, 9.0); //Set the checkpoint for all players IF they ARE connected.
			checkon[i] = 1; //Set the variable called "checkon" to 1
			}
		}
	}
	return 1;
}

public OnFilterScriptExit()
{
        for(new i=0; i < MAX_PLAYERS; i++)
        {
      		#if use_icon == true
      		RemovePlayerMapIcon(i,20);
  			#endif
            if(IsPlayerConnected(i) && checkon[i] == 1) //If they are online and the checkpoint is active
            {
				DisablePlayerCheckpoint(i); //Remove the checkpoint
			}
		}
        #if help_pickup == true //If "help_pickup" is defined as "true"
  		DestroyPickup(exhelp); //Destroy the pickup
  		#endif
    	if(sold1 == 1) //If its sold
		{
		DestroyObject(cross1); //Destroy the cross
		sold1 = 0; //And set the variable to "not sold"
		}
		if(sold2 == 1) //If its sold
		{
		DestroyObject(cross2); //Destroy the cross
		sold2 = 0; //And set the variable to "not sold"
		}
		if(sold3 == 1) //If its sold
		{
		DestroyObject(cross3); //Destroy the cross
		sold3 = 0; //And set the variable to "not sold"
		}
		if(sold4 == 1) //If its sold
		{
		DestroyObject(cross4); //Destroy the cross
		sold4 = 0; //And set the variable to "not sold"
		}
		if(sold5 == 1) //If its sold
		{
		DestroyObject(cross5); //Destroy the cross
		sold5 = 0; //And set the variable to "not sold"
		}
		if(sold6 == 1) //If its sold
		{
		DestroyObject(cross6); //Destroy the cross
		sold6 = 0; //And set the variable to "not sold"
		}
		if(sold7 == 1) //If its sold
		{
		DestroyObject(cross7); //Destroy the cross
		sold7 = 0; //And set the variable to "not sold"
		}
		if(sold8 == 1) //If its sold
		{
		DestroyObject(cross8); //Destroy the cross
		sold8 = 0; //And set the variable to "not sold"
		}
		if(sold9 == 1) //If its sold
		{
		DestroyObject(cross9); //Destroy the cross
		sold9 = 0; //And set the variable to "not sold"
		}
		if(sold10 == 1) //If its sold
		{
		DestroyObject(cross10); //Destroy the cross
		sold10 = 0; //And set the variable to "not sold"
		}
		DestroyObject(writing); //Destroy the writing on the board
		DestroyObject(board);   //Destroy the board
		print("\n--------------------------------------");
		print("Mikes Car Export Script - Unloaded"); //Print stuff in the console, remove if you wish
		print("--------------------------------------\n");
		return 1;
}

public OnPlayerConnect(playerid)
{
    carnames[playerid] = 1; //Enable the carnames when you enter/exit a vehicle
    sellon[playerid] = 1;   //Enable the player to sell cars
    SetPlayerCheckpoint(playerid, -1545.0740,128.1534,3.5547, 9.0);     //Set the checkpoint
    checkon[playerid] = 1; //The checkpoint Is visible to the player.
    #if use_icon == true //If "use_icon" is defined as "true"
	SetPlayerMapIcon(playerid, 20, -1545.0740,128.1534,3.5547, 55, 0 ); //Set the map icon for the player
	#endif
	return 1;
}
public OnPlayerDisconnect(playerid,reason)
{
    sellon[playerid] = 1;   //Enable the player to sell cars
    if(checkon[playerid] == 1) //If they are online and the checkpoint is active
    {
		DisablePlayerCheckpoint(playerid); //Remove the checkpoint
	}     //Remove the checkpoint
    checkon[playerid] = 0; //Set the checkpoint variable to 0
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new str1[128]; //Create "str1"
	new str2[128]; //Create "str2"
	new str3[128]; //Create "str3"
	new str4[128]; //Create "str4"
	format(str1, sizeof(str1), "%s",show_export_cmd); //Format "str1"
	format(str2, sizeof(str2), "%s",hide_export_cmd); //Format "str2"
	format(str3, sizeof(str3), "%s",clear_export_cmd);//Format "str3"
	format(str4, sizeof(str4), "%s",car_names_cmd);   //Format "str4"
	if (strcmp(str1,cmdtext,true) == 0) //If he types the command to show export
	{
 	GetPlayerPos(playerid,oldpos[playerid][0],oldpos[playerid][1],oldpos[playerid][2]); //Save his current position in the "oldpos" variable
    SetPlayerPos(playerid,-1534.6313,150.5789,1.5547); //Set his position to under the board (under the floor, cant be seen)
	SetPlayerCameraPos(playerid,-1534.6313,150.5789,3.5547);    //Set the camera infront of the board
	SetPlayerCameraLookAt(playerid,-1534.4789,153.5749,4.6031); //Face the camera at the board
	PlayerPlaySound(playerid,sell_car_sound,0.0,0.0,0.0); //Play a sound (definable)
	new str5[128]; //Define "str5"
	format(str5, sizeof(str4), "Type %s to go to your last position!",hide_export_cmd); //Format "str5"
	SendClientMessage(playerid, COLOR_GREEN,str5); //send the "str5" message
	return 1;
	}
	if (strcmp(str2,cmdtext,true) == 0) //If he types the command to hide export
	{
	SetPlayerPos(playerid,oldpos[playerid][0],oldpos[playerid][1],oldpos[playerid][2]); //Set his position that was saved in the "oldpos" variable
    SetCameraBehindPlayer(playerid); //Reset the players camera
	PlayerPlaySound(playerid,sell_car_sound,0.0,0.0,0.0); //Play a Sound
	return 1;
	}
	if (strcmp(str3, cmdtext, true) == 0) //If a player types the command to clear export
	{
		if(IsPlayerAdmin(playerid)) //If the player is admin
		{
		for(new i=0; i < MAX_PLAYERS; i++)
		{
			if(sellon[i] == 0) //If they cant sell
			{
			sellon[i] = 1;   //Enable all players to sell cars
			}
		}
		if(sold1 == 1) //If this vehicle has been sold and crossed off
		{
		DestroyObject(cross1); //Destroy the cross object
		sold1 = 0; //Enable this vehicle to be sold again
		}
		if(sold2 == 1) //If this vehicle has been sold and crossed off
		{
		DestroyObject(cross2); //Destroy the cross object
		sold2 = 0; //Enable this vehicle to be sold again
		}
		if(sold3 == 1) //If this vehicle has been sold and crossed off
		{
		DestroyObject(cross3); //Destroy the cross object
		sold3 = 0; //Enable this vehicle to be sold again
		}
		if(sold4 == 1) //If this vehicle has been sold and crossed off
		{
		DestroyObject(cross4); //Destroy the cross object
		sold4 = 0; //Enable this vehicle to be sold again
		}
		if(sold5 == 1) //If this vehicle has been sold and crossed off
		{
		DestroyObject(cross5); //Destroy the cross object
		sold5 = 0; //Enable this vehicle to be sold again
		}
		if(sold6 == 1) //If this vehicle has been sold and crossed off
		{
		DestroyObject(cross6); //Destroy the cross object
		sold6 = 0; //Enable this vehicle to be sold again
		}
		if(sold7 == 1) //If this vehicle has been sold and crossed off
		{
		DestroyObject(cross7); //Destroy the cross object
		sold7 = 0; //Enable this vehicle to be sold again
		}
		if(sold8 == 1) //If this vehicle has been sold and crossed off
		{
		DestroyObject(cross8); //Destroy the cross object
		sold8 = 0; //Enable this vehicle to be sold again
		}
		if(sold9 == 1) //If this vehicle has been sold and crossed off
		{
		DestroyObject(cross9); //Destroy the cross object
		sold9 = 0; //Enable this vehicle to be sold again
		}
		if(sold10 == 1) //If this vehicle has been sold and crossed off
		{
		DestroyObject(cross10); //Destroy the cross object
		sold10 = 0; //Enable this vehicle to be sold again
		}
		}
		else
		{
   		return SendClientMessage(playerid,0xFF0000AA,"You are not RCON."); //If the player isnt an RCON admin, it will tell him.
		}
		SendClientMessageToAll(0xDC143CAA,"Car Export Reset."); //Otherwise tell all players that export has been reset!
		return 1;
	}
	if (strcmp(str4, cmdtext, true) == 0) //If a player types the command to enable or disable the carnames
{
if(carnames[playerid] == 0) //If the players carnames are disabled
{
carnames[playerid] = 1; //Enable them
SendClientMessage(playerid, COLOR_GREEN,"Car Names Enabled."); //And tell him they are now enabled
}
else //Otherwise
{
carnames[playerid] = 0; //Disabled the car names
SendClientMessage(playerid, COLOR_RED,"Car Names Disabled."); //And tell him they are now disabled
}
return 1;
}
	if (strcmp("/exlist", cmdtext, true) == 0) //If a player types /exlist
{
SendClientMessage(playerid,COLOR_ORANGE,"You can sell...");
if(sold1 == 0) //If its not sold
{
new stringy1[128];
format(stringy1, sizeof(stringy1), "A Slamvan for $%d",slamvan_price); //Format "stringy1"
SendClientMessage(playerid,COLOR_WHITE,stringy1);
}
if(sold2 == 0) //If its not sold
{
new stringy2[128];
format(stringy2, sizeof(stringy2), "A Blista Compact for $%d",blista_price); //Format "stringy2"
SendClientMessage(playerid,COLOR_WHITE,stringy2);
}
if(sold3 == 0) //If its not sold
{
new stringy3[128];
format(stringy3, sizeof(stringy3), "A Stafford for $%d",stafford_price); //Format "stringy3"
SendClientMessage(playerid,COLOR_WHITE,stringy3);
}
if(sold4 == 0) //If its not sold
{
new stringy4[128];
format(stringy4, sizeof(stringy4), "A Sabre for $%d",sabre_price); //Format "stringy4"
SendClientMessage(playerid,COLOR_WHITE,stringy4);
}
if(sold5 == 0) //If its not sold
{
new stringy5[128];
format(stringy5, sizeof(stringy5), "An FCR-600 for $%d",FCR_price); //Format "stringy5"
SendClientMessage(playerid,COLOR_WHITE,stringy5);
}
if(sold6 == 0) //If its not sold
{
new stringy6[128];
format(stringy6, sizeof(stringy6), "A Cheetah for $%d",cheetah_price); //Format "stringy6"
SendClientMessage(playerid,COLOR_WHITE,stringy6);
}
if(sold7 == 0) //If its not sold
{
new stringy7[128];
format(stringy7, sizeof(stringy7), "A Rancher for $%d",rancher_price); //Format "stringy7"
SendClientMessage(playerid,COLOR_WHITE,stringy7);
}
if(sold8 == 0) //If its not sold
{
new stringy8[128];
format(stringy8, sizeof(stringy8), "A Stallion for $%d",stallion_price); //Format "stringy8"
SendClientMessage(playerid,COLOR_WHITE,stringy8);
}
if(sold9 == 0) //If its not sold
{
new stringy9[128];
format(stringy9, sizeof(stringy9), "A Tanker for $%d",tanker_price); //Format "stringy9"
SendClientMessage(playerid,COLOR_WHITE,stringy9);
}
if(sold10 == 0) //If its not sold
{
new stringy10[128];
format(stringy10, sizeof(stringy10), "A Comet for $%d",comet_price); //Format "stringy10"
SendClientMessage(playerid,COLOR_WHITE,stringy10);
}
return 1;
}
	return 0; //if all else fails return "SERVER: Unknown Command"!
}
		

public OnPlayerEnterCheckpoint(playerid) //When a player goes into the checkpoint
{
	if(!IsPlayerInAnyVehicle(playerid)) //If the player isnt in a vehicle
	{
	return SendClientMessage(playerid,COLOR_RED,"You must be in a vehicle!");
	}
    new gtstr[128]; //Define gtstr
   	if(sellon[playerid] == 0) //if he cant sell cars (sold one latley)
	{
	return GameTextForPlayer(playerid,"~R~Come back later!",3000,sold_for_gametext); //Tell him to return later
	}
	//Slamvan
 	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 535) //If its a Slamvan
    {
    if(sold1 == 0) //If it has not been sold
	{
	sold1 = 1; //Now its sold, so we can set the variable
	sellon[playerid] = 0; //We have sold a vehicle so we have to wait 5 minutes to sell again
	SetTimerEx("exdel",wait_time*60000, false, "i", playerid); //Set the timer to be able to sell cars again
	new string[128];
	new string2[128];
	format(string2, sizeof(string2), "CAR EXPORT: You must now wait %d minutes to sell another car!",wait_time); //Format "string2"
	SendClientMessage(playerid, COLOR_GREEN,string2); //Send "string2" as a SendClientMessage
	DestroyVehicle(GetPlayerVehicleID(playerid)); //Respawn the Slamvan
	GivePlayerMoney(playerid,slamvan_price); //Give the player that cash
	SetPlayerScore(playerid, GetPlayerScore(playerid) + sell_car_bonus );
	format(gtstr, sizeof(gtstr), "~G~slamvan sold for~N~~Y~$%i~W~!",slamvan_price); //Format "gtstr"
	GameTextForPlayer(playerid,gtstr,3000,sold_for_gametext); //Gametext
	cross1 = CreateObject(3086, -1534.65, 154.05, 2.51, 0.00, 0.00, 180.00); //The cross-out object for the blackboard
	SetPlayerCameraPos(playerid,-1534.6313,150.5789,3.5547);    //Camera
	SetPlayerCameraLookAt(playerid,-1534.4789,153.5749,4.6031); //Camera
	SetTimerEx("excam",reset_time*1000, false, "i", playerid);             //Reset the camera and the player in whatever secondsa are defined
	PlayerPlaySound(playerid,sell_car_sound,0.0,0.0,0.0); //Sound
	new name[16]; //Define "Name"
	GetPlayerName(playerid,name,16); //Get the players name and store it in the "name" variable
	format(string, sizeof(string), "\"%s\" has sold the Slamvan for $%i!",name,slamvan_price); //Format "string"
	SendClientMessageToAll(COLOR_GREEN, string); //Send "string" as a SCM
    }
    else if(sold1 == 1) //If slamvan is already sold
    {
    GameTextForPlayer(playerid,"~R~slamvan ~W~has already been sold!",3000,already_sold_gametext); //Tell them its sold
    }
	}
	//Blista Compact
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 496)
    {
    if(sold2 == 0)
	{
	sold2 = 1;
	sellon[playerid] = 0;
	SetTimerEx("exdel",wait_time*60000, false, "i", playerid); //Set the timer to be able to sell cars again
	new string[128];
	new string2[128];
	format(string2, sizeof(string2), "CAR EXPORT: You must now wait %d minutes to sell another car!",wait_time); //Format "string2"
	SendClientMessage(playerid, COLOR_GREEN,string2); //Send "string2" as a SendClientMessage
	DestroyVehicle(GetPlayerVehicleID(playerid));
	GivePlayerMoney(playerid,blista_price);
	SetPlayerScore(playerid, GetPlayerScore(playerid) + sell_car_bonus );
	format(gtstr, sizeof(gtstr), "~G~blista compact sold for~N~~Y~$%i~W~!",blista_price); //Format "string"
	GameTextForPlayer(playerid,gtstr,3000,sold_for_gametext); //Gametext
	cross2 = CreateObject(3086, -1534.45, 154.05, 2.26, 0.00, 0.00, 180.00);
	SetPlayerCameraPos(playerid,-1534.6313,150.5789,3.5547);
	SetPlayerCameraLookAt(playerid,-1534.4789,153.5749,4.6031);
	SetTimerEx("excam",reset_time*1000, false, "i", playerid);
	PlayerPlaySound(playerid,sell_car_sound,0.0,0.0,0.0);
	new name[16];
	GetPlayerName(playerid,name,16);
	format(string, sizeof(string), "\"%s\" has sold the Blista Compact for $%i!",name,blista_price);
	SendClientMessageToAll(COLOR_GREEN, string);
    }
    else if(sold2 == 1)
    {
    GameTextForPlayer(playerid,"~R~blista compact ~W~has already been sold!",3000,already_sold_gametext);
    }
	}
	//Stafford
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 580)
    {
    if(sold3 == 0)
	{
	sold3 = 1;
	sellon[playerid] = 0;
   	SetTimerEx("exdel",wait_time*60000, false, "i", playerid); //Set the timer to be able to sell cars again
	new string[128];
	new string2[128];
	format(string2, sizeof(string2), "CAR EXPORT: You must now wait %d minutes to sell another car!",wait_time); //Format "string2"
	SendClientMessage(playerid, COLOR_GREEN,string2); //Send "string2" as a SendClientMessage
	DestroyVehicle(GetPlayerVehicleID(playerid));
	GivePlayerMoney(playerid,stafford_price);
	SetPlayerScore(playerid, GetPlayerScore(playerid) + sell_car_bonus );
	format(gtstr, sizeof(gtstr), "~G~stafford sold for~N~~Y~$%i~W~!",stafford_price); //Format "string"
	GameTextForPlayer(playerid,gtstr,3000,sold_for_gametext); //Gametext
	cross3 = CreateObject(3086, -1534.62, 154.05, 1.99, 0.00, 0.00, 180.00);
	SetPlayerCameraPos(playerid,-1534.6313,150.5789,3.5547);
	SetPlayerCameraLookAt(playerid,-1534.4789,153.5749,4.6031);
	SetTimerEx("excam",reset_time*1000, false, "i", playerid);
	PlayerPlaySound(playerid,sell_car_sound,0.0,0.0,0.0);
	new name[16];
	GetPlayerName(playerid,name,16);
	format(string, sizeof(string), "\"%s\" has sold the Stafford for $%i!",name,stafford_price);
	SendClientMessageToAll(COLOR_GREEN, string);
    }
    else if(sold3 == 1)
    {
    GameTextForPlayer(playerid,"~R~stafford ~W~has already been sold!",3000,already_sold_gametext);
    }
	}
	//Sabre
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 475)
    {
    if(sold4 == 0)
	{
	sold4 = 1;
	sellon[playerid] = 0;
   	SetTimerEx("exdel",wait_time*60000, false, "i", playerid); //Set the timer to be able to sell cars again
	new string[128];
	new string2[128];
	format(string2, sizeof(string2), "CAR EXPORT: You must now wait %d minutes to sell another car!",wait_time); //Format "string2"
	SendClientMessage(playerid, COLOR_GREEN,string2); //Send "string2" as a SendClientMessage
	DestroyVehicle(GetPlayerVehicleID(playerid));
	GivePlayerMoney(playerid,sabre_price);
	SetPlayerScore(playerid, GetPlayerScore(playerid) + sell_car_bonus );
	format(gtstr, sizeof(gtstr), "~G~sabre sold for~N~~Y~$%i~W~!",sabre_price); //Format "string"
	GameTextForPlayer(playerid,gtstr,3000,sold_for_gametext); //Gametext
	cross4 = CreateObject(3086, -1534.73, 154.05, 1.73, 0.00, 0.00, 180.00);
	SetPlayerCameraPos(playerid,-1534.6313,150.5789,3.5547);
	SetPlayerCameraLookAt(playerid,-1534.4789,153.5749,4.6031);
	SetTimerEx("excam",reset_time*1000, false, "i", playerid);
	PlayerPlaySound(playerid,sell_car_sound,0.0,0.0,0.0);
	new name[16];
	GetPlayerName(playerid,name,16);
	format(string, sizeof(string), "\"%s\" has sold the Sabre for $%i!",name,sabre_price);
	SendClientMessageToAll(COLOR_GREEN, string);
    }
    else if(sold4 == 1)
    {
    GameTextForPlayer(playerid,"~R~Sabre ~W~has already been sold!",3000,already_sold_gametext);
    }
	}
	//FCR-900
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 521)
    {
    if(sold5 == 0)
	{
	sold5 = 1;
	sellon[playerid] = 0;
   	SetTimerEx("exdel",wait_time*60000, false, "i", playerid); //Set the timer to be able to sell cars again
	new string[128];
	new string2[128];
	format(string2, sizeof(string2), "CAR EXPORT: You must now wait %d minutes to sell another car!",wait_time); //Format "string2"
	SendClientMessage(playerid, COLOR_GREEN,string2); //Send "string2" as a SendClientMessage
	DestroyVehicle(GetPlayerVehicleID(playerid));
	GivePlayerMoney(playerid,FCR_price);
	SetPlayerScore(playerid, GetPlayerScore(playerid) + sell_car_bonus );
	format(gtstr, sizeof(gtstr), "~G~FCR-600 sold for~N~~Y~$%i~W~!",FCR_price); //Format "string"
	GameTextForPlayer(playerid,gtstr,3000,sold_for_gametext); //Gametext
	cross5 = CreateObject(3086, -1534.68, 154.05, 1.45, 0.00, 0.00, 180.00);
	SetPlayerCameraPos(playerid,-1534.6313,150.5789,3.5547);
	SetPlayerCameraLookAt(playerid,-1534.4789,153.5749,4.6031);
	SetTimerEx("excam",reset_time*1000, false, "i", playerid);
	PlayerPlaySound(playerid,sell_car_sound,0.0,0.0,0.0);
	new name[16];
	GetPlayerName(playerid,name,16);
	format(string, sizeof(string), "\"%s\" has sold the FCR-600 for $%i!",name,FCR_price);
	SendClientMessageToAll(COLOR_GREEN, string);
    }
    else if(sold4 == 1)
    {
    GameTextForPlayer(playerid,"~R~FCR-600 ~W~has already been sold!",3000,already_sold_gametext);
    }
	}
	//Cheetah
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 415)
    {
    if(sold6 == 0)
	{
	sold6 = 1;
	sellon[playerid] = 0;
   	SetTimerEx("exdel",wait_time*60000, false, "i", playerid); //Set the timer to be able to sell cars again
	new string[128];
	new string2[128];
	format(string2, sizeof(string2), "CAR EXPORT: You must now wait %d minutes to sell another car!",wait_time); //Format "string2"
	SendClientMessage(playerid, COLOR_GREEN,string2); //Send "string2" as a SendClientMessage
	DestroyVehicle(GetPlayerVehicleID(playerid));
	GivePlayerMoney(playerid,cheetah_price);
	SetPlayerScore(playerid, GetPlayerScore(playerid) + sell_car_bonus );
	format(gtstr, sizeof(gtstr), "~G~cheetah sold for~N~~Y~$%i~W~!",cheetah_price); //Format "string"
	GameTextForPlayer(playerid,gtstr,3000,sold_for_gametext); //Gametext
	cross6 = CreateObject(3086, -1532.76, 154.05, 2.55, 0.00, 0.00, 180.00);
	SetPlayerCameraPos(playerid,-1534.6313,150.5789,3.5547);
	SetPlayerCameraLookAt(playerid,-1534.4789,153.5749,4.6031);
	SetTimerEx("excam",reset_time*1000, false, "i", playerid);
	PlayerPlaySound(playerid,sell_car_sound,0.0,0.0,0.0);
	new name[16];
	GetPlayerName(playerid,name,16);
	format(string, sizeof(string), "\"%s\" has sold the Cheetah for $%i!",name,cheetah_price);
	SendClientMessageToAll(COLOR_GREEN, string);
    }
    else if(sold6 == 1)
    {
    GameTextForPlayer(playerid,"~R~Cheetah ~W~has already been sold!",3000,already_sold_gametext);
    }
	}
	//Rancher
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 489)
    {
    if(sold7 == 0)
	{
	sold7 = 1;
	sellon[playerid] = 0;
   	SetTimerEx("exdel",wait_time*60000, false, "i", playerid); //Set the timer to be able to sell cars again
	new string[128];
	new string2[128];
	format(string2, sizeof(string2), "CAR EXPORT: You must now wait %d minutes to sell another car!",wait_time); //Format "string2"
	SendClientMessage(playerid, COLOR_GREEN,string2); //Send "string2" as a SendClientMessage
	DestroyVehicle(GetPlayerVehicleID(playerid));
	GivePlayerMoney(playerid,rancher_price);
	SetPlayerScore(playerid, GetPlayerScore(playerid) + sell_car_bonus );
	format(gtstr, sizeof(gtstr), "~G~rancher sold for~N~~Y~$%i~W~!",rancher_price); //Format "string"
	GameTextForPlayer(playerid,gtstr,3000,sold_for_gametext); //Gametext
	cross7 = CreateObject(3086, -1532.67, 154.04, 2.27, 0.00, 0.00, 180.00);
	SetPlayerCameraPos(playerid,-1534.6313,150.5789,3.5547);
	SetPlayerCameraLookAt(playerid,-1534.4789,153.5749,4.6031);
	SetTimerEx("reset_time*1000",reset_time*1000, false, "i", playerid);
	PlayerPlaySound(playerid,sell_car_sound,0.0,0.0,0.0);
	new name[16];
	GetPlayerName(playerid,name,16);
	format(string, sizeof(string), "\"%s\" has sold the Rancher for $%i!",name,rancher_price);
	SendClientMessageToAll(COLOR_GREEN, string);
    }
    else if(sold7 == 1)
    {
    GameTextForPlayer(playerid,"~R~Rancher ~W~has already been sold!",3000,already_sold_gametext);
    }
	}
	//Stallion
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 439)
    {
    if(sold8 == 0)
	{
	sold8 = 1;
	sellon[playerid] = 0;
   	SetTimerEx("exdel",wait_time*60000, false, "i", playerid); //Set the timer to be able to sell cars again
	new string[128];
	new string2[128];
	format(string2, sizeof(string2), "CAR EXPORT: You must now wait %d minutes to sell another car!",wait_time); //Format "string2"
	SendClientMessage(playerid, COLOR_GREEN,string2); //Send "string2" as a SendClientMessage
	DestroyVehicle(GetPlayerVehicleID(playerid));
	GivePlayerMoney(playerid,stallion_price);
	SetPlayerScore(playerid, GetPlayerScore(playerid) + sell_car_bonus );
	format(gtstr, sizeof(gtstr), "~G~stallion sold for~N~~Y~$%i~W~!",stallion_price); //Format "string"
	GameTextForPlayer(playerid,gtstr,3000,sold_for_gametext); //Gametext
	cross8 = CreateObject(3086, -1532.77, 154.04, 2.03, 0.00, 0.00, 180.00 );
	SetPlayerCameraPos(playerid,-1534.6313,150.5789,3.5547);
	SetPlayerCameraLookAt(playerid,-1534.4789,153.5749,4.6031);
	SetTimerEx("excam",reset_time*1000, false, "i", playerid);
	PlayerPlaySound(playerid,sell_car_sound,0.0,0.0,0.0);
	new name[16];
	GetPlayerName(playerid,name,16);
	format(string, sizeof(string), "\"%s\" has sold the Stallion for $%i!",name,stallion_price);
	SendClientMessageToAll(COLOR_GREEN, string);
    }
    else if(sold8 == 1)
    {
    GameTextForPlayer(playerid,"~R~Stallion ~W~has already been sold!",3000,already_sold_gametext);
    }
	}
	//Tanker
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 514)
    {
 	if(sold9 == 0)
	{
	sold9 = 1;
	sellon[playerid] = 0;
   	SetTimerEx("exdel",wait_time*60000, false, "i", playerid); //Set the timer to be able to sell cars again
	new string[128];
	new string2[128];
	format(string2, sizeof(string2), "CAR EXPORT: You must now wait %d minutes to sell another car!",wait_time); //Format "string2"
	SendClientMessage(playerid, COLOR_GREEN,string2); //Send "string2" as a SendClientMessage
	DestroyVehicle(GetPlayerVehicleID(playerid));
	GivePlayerMoney(playerid,tanker_price);
	SetPlayerScore(playerid, GetPlayerScore(playerid) + sell_car_bonus );
	format(gtstr, sizeof(gtstr), "~G~tanker sold for~N~~Y~$%i~W~!",tanker_price); //Format "string"
	GameTextForPlayer(playerid,gtstr,3000,sold_for_gametext); //Gametext
	cross9 = CreateObject(3086, -1532.77, 154.02, 1.75, 0.00, 0.00, 180.00);
	SetPlayerCameraPos(playerid,-1534.6313,150.5789,3.5547);
	SetPlayerCameraLookAt(playerid,-1534.4789,153.5749,4.6031);
	SetTimerEx("excam",reset_time*1000, false, "i", playerid);
	PlayerPlaySound(playerid,sell_car_sound,0.0,0.0,0.0);
	new name[16];
	GetPlayerName(playerid,name,16);
	format(string, sizeof(string), "\"%s\" has sold the Tanker for $%i!",name,tanker_price);
	SendClientMessageToAll(COLOR_GREEN, string);
    }
    else if(sold9 == 1)
    {
    GameTextForPlayer(playerid,"~R~Tanker ~W~has already been sold!",3000,already_sold_gametext);
    }
	}
	//Comet
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 480)
    {
 	if(sold10 == 0)
	{
	sold10 = 1;
	sellon[playerid] = 0;
   	SetTimerEx("exdel",wait_time*60000, false, "i", playerid); //Set the timer to be able to sell cars again
	new string[128];
	new string2[128];
	format(string2, sizeof(string2), "CAR EXPORT: You must now wait %d minutes to sell another car!",wait_time); //Format "string2"
	SendClientMessage(playerid, COLOR_GREEN,string2); //Send "string2" as a SendClientMessage
	DestroyVehicle(GetPlayerVehicleID(playerid));
	GivePlayerMoney(playerid,comet_price);
	SetPlayerScore(playerid, GetPlayerScore(playerid) + sell_car_bonus );
	format(gtstr, sizeof(gtstr), "~G~slamvan sold for~N~~Y~$%i~W~!",comet_price); //Format "string"
	GameTextForPlayer(playerid,gtstr,3000,sold_for_gametext); //Gametext
	cross10 = CreateObject(3086, -1532.86, 154.04, 1.48, 0.00, 0.00, 180.00);
	SetPlayerCameraPos(playerid,-1534.6313,150.5789,3.5547);
	SetPlayerCameraLookAt(playerid,-1534.4789,153.5749,4.6031);
	SetTimerEx("excam",reset_time*1000, false, "i", playerid);
	PlayerPlaySound(playerid,sell_car_sound,0.0,0.0,0.0);
	new name[16];
	GetPlayerName(playerid,name,16);
	format(string, sizeof(string), "\"%s\" has sold the Comet for $%i!",name,comet_price);
	SendClientMessageToAll(COLOR_GREEN, string);
    }
    else if(sold10 == 1)
    {
    GameTextForPlayer(playerid,"~R~Comet ~W~has already been sold!",3000,already_sold_gametext);
    }
	}
	if(sold1 == 1 && sold2 == 1 && sold3 == 1 && sold4 == 1 && sold5 == 1 && sold6 == 1 && sold7 == 1 && sold8 == 1 && sold9 == 1 && sold10 == 1)
	{
	return reloadexport(playerid);
	}
	return 1;
}

reloadexport(playerid) //This is called when all cars are sold
{
SendClientMessageToAll(COLOR_RED,"The Car Export List Has Been Completed! List Reset!");
SendClientMessage(playerid,COLOR_RED,"YOU SOLD THE LAST CAR!"); //Tells the person he sold the last car
new string[128];
format(string, sizeof(string), "Received +%d points! [REASON: Sold Last Car].",last_car_bonus); //Format "string"
SetPlayerScore(playerid, GetPlayerScore(playerid) + last_car_bonus );
SendClientMessage(playerid,COLOR_YELLOW,string); //Give him 100 points
DestroyObject(cross1);
sold1 = 0;
DestroyObject(cross2);
sold2 = 0;
DestroyObject(cross3);
sold3 = 0;
DestroyObject(cross4);
sold4 = 0;
DestroyObject(cross5);
sold5 = 0;
DestroyObject(cross6);
sold6 = 0;
DestroyObject(cross7);
sold7 = 0;
DestroyObject(cross8);
sold8 = 0;
DestroyObject(cross9);
sold9 = 0;
DestroyObject(cross10);
sold10 = 0;
return 1;
}

#if help_pickup == true
public OnPlayerPickUpPickup(playerid, pickupid)
{

	if (pickupid == exhelp) //If he picks up the help pickup
    {
        SendClientMessage(playerid,COLOR_ORANGE,"Car Export Help");
        SendClientMessage(playerid,COLOR_WHITE,"Car Export allows players to sell cars for cash and score.");
        SendClientMessage(playerid,COLOR_WHITE,"You can see what cars are available to be sold on the blackboard or by /exlist.");
        SendClientMessage(playerid,COLOR_WHITE,"When you deliver a car on the list to the red checkpoint");
        SendClientMessage(playerid,COLOR_WHITE,"it will be crossed off the list and nobody else can sell that car.");
        SendClientMessage(playerid,COLOR_WHITE,"Prices vary depending on the car");
        SendClientMessage(playerid,COLOR_WHITE,"Happy hunting!");
	}
}
#endif
public excam(playerid)
{
	SetCameraBehindPlayer(playerid);
	PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
}

public exdel(playerid)
{
	if(sellon[playerid] == 0) //If he can't sell (To aviod bugs)
	{
		SendClientMessage(playerid, COLOR_GREEN,"CAR EXPORT: You May Now Sell Another Car!"); //Send him a notification
		sellon[playerid] = 1; //The player can now sell another car
	}
}

//Car names - Thankyou WeeDarr for giving me the array

#if defined car_names
public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(carnames[playerid] == 1)
    {
    	if(GetPlayerState(playerid) ==2)
		{
        	new string[128];
			format(string, sizeof(string), "%s",vNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
        	GameTextForPlayer(playerid, string, 2000, 1);
		}
	}
	return 1;
}
#endif
