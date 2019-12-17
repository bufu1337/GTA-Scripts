//*************************************************************************//
//<=====================Stadium Tele Script v2.0=========================>//
//************************************************************************//
//************************************************************************//
//<====================Script written by B.I.G. aka Mario================>//
//<======================================================================>//
//<============Dont release this script without my permission============>//
//<=============My Server: No.1 German RPG/Race/DM/Stunt-================>//
//************************************************************************//
//<======New in this version: Admins can open or close each stadium======>//
//<======If a player enter a Stadium vehicle there´ll be shown the ======>//
//<=========================name of the vehicle==========================>//
//************************************************************************//
//<=============THIS IS THE LAST RELEASE OF THIS SCRIPT==================>//
//************************************************************************//

//Homepage: www.grpg-forum.de.tl

//Edit: Special thanks to [Cs]moe for the nitro command!!
//If you find bugs try to repair themselve because I dont working anymore on this script

//To use the new Admin Commands take sure that you are logged into rcon or it doesnt work!!


#include <a_samp>


#define COLOR_GREEN 	0x33AA33AA
#define COLOR_RED 		0xAA3333AA
#define COLOR_PINK 		0xFF66FFAA
#define COLOR_BLUE 		0x0000BBAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_ORANGE 	0xFF9900AA
#define COLOR_WHITE 	0xFFFFFFFF
#define COLOR_YELLOW 	0xFFFF00AA
#define COLOR_GREY      0xAFAFAFAA


#define MAX_INVALID_NOS_VEHICLES 29  //dont change this!!this is possible for the cars without nitro!

#define ANNOUNCE 450000              //you can change the time.this is only a rotation. 60000=1minute 120000=2minutes ...
                                     // 600000 = 10minutes , 900000 = 15minutes , 1200000= 18minutes ...


//race countdown

new Count = 5;
new CountText[5][5] ={
"~r~1",
"~y~2",
"~b~3",
"~g~4",
"~w~5"
};

//Deffinition for the interior vehicles

new turismo[11];     // 10 turismo vehicles
new bloodring[13];   // 12 bloodring banger vehicles
new sultan[14];      // 13 sultan vehicles
new sanchez[15];     // 14 sanchez vehicles

//NEW: EACH STADIUM CAN BE OPEN OR CLOSED WITH A ADMIN COMMAND!!! IsDerbyAllowed 0=false 1=true !

new IsDerbyAllowed;
new IsSultanAllowed;
new IsDirtbikeAllowed;
new IsRaceAllowed;


//These coords are only in Las Venturas but you can change it!

new Float:raus[5][3] = {
{2386.0974,989.1138,10.8203},          //you can change these coordinates like { x , y , z } coordinates
{2029.5751,1007.7642,10.8203},         //these are the coordinates when you type /exit.Its a random spawn
{2294.7498,2421.5452,10.8203},
{2017.6318,1545.4016,10.8292},
{2036.8822,1932.5518,12.1310}
};


//The Forward declarations!

forward Announce();
forward DestroyAnnounce();
forward CountDown();
forward IsPlayerInInvalidNosVehicle(playerid,vehicleid);



public OnFilterScriptInit( )
{
	print( "\n[FS] *************************" );
	print( "[FS] *Stadium TeleScript v2.0*" );
	print( "[FS] *   loaded by B.I.G.    *" );
	print( "[FS] *************************\n" );
}

public OnFilterScriptExit()
{
	print( "\n[FS] *************************" );
	print( "[FS] *Stadium TeleScript v2.0*" );
	print( "[FS] *   unloaded by B.I.G.  *" );
	print( "[FS] *************************\n" );
}

//This is the new easily Announce system:

public Announce()
{
SendClientMessageToAll(COLOR_LIGHTBLUE, "Do you like races in Stadiums?!? Then type /telehelp to get more informations and the commands ;)");
IsDerbyAllowed = 1;
IsDirtbikeAllowed = 1;
IsSultanAllowed = 1;
IsRaceAllowed = 1;
print( "*******Stadiums were automatically opened*******" );
return 1;
}

public CountDown(){

if (Count > 0){
GameTextForAll( CountText[Count-1], 2500, 3);
Count--;
SetTimer("CountDown", 1000, 0);
}
else{
GameTextForAll("~g~THE~r~! ~g~RACE~r~! ~g~STARTED~r~!", 3500, 3);
Count = 5;
}
return 1;
}


public OnGameModeInit()
{
    SetTimer("Announce",ANNOUNCE,1);
    
    //=======================================================================================//
    //==============================Interior Vehicles========================================//
    //=======================================================================================//
    //turismo vehicles:
    
    print( " " );
    print( "       Interior Cars will created....CreateVehicle... " );
    print( "       CreateVehicle...[(turismo),(sultan),(sanchez),(bloodringer)]" );
    print( " " );
    
    turismo[1] = CreateVehicle(451,-1401.5464,-215.1451,1043.0021,183.3089,-1,-1,30000);
	turismo[2] = CreateVehicle(451,-1397.8833,-215.0985,1043.0076,182.0328,-1,-1,30000);
	turismo[3] = CreateVehicle(451,-1393.3899,-214.8954,1043.0139,184.7657,-1,-1,30000);
	turismo[4] = CreateVehicle(451,-1405.7230,-204.5623,1042.9879,186.0960,-1,-1,30000);
	turismo[5] = CreateVehicle(451,-1406.3073,-196.9478,1043.0173,183.1659,-1,-1,30000);
	turismo[6] = CreateVehicle(451,-1406.8540,-188.6655,1043.0986,181.9146,-1,-1,30000);
	turismo[7] = CreateVehicle(451,-1389.9061,-207.6514,1043.0013,185.0758,-1,-1,30000);
	turismo[8] = CreateVehicle(451,-1390.7802,-195.5670,1043.0385,185.5513,-1,-1,30000);
	turismo[9] = CreateVehicle(451,-1390.4967,-201.4809,1043.0107,186.5587,-1,-1,30000);
	turismo[10] = CreateVehicle(451,-1383.0416,-219.6403,1067.0706,359.8715,-1,-1,30000);
	for(new v = 0; v < 11; v++){ LinkVehicleToInterior(turismo[v],7); }

    // Bloodring Vehicles:

	bloodring[1] = CreateVehicle(504,-1510.9863,982.7150,1037.2297,278.5920,-1,-1,30000);
	bloodring[2] = CreateVehicle(504,-1512.1644,990.7131,1037.3719,275.3818,-1,-1,30000);
	bloodring[3] = CreateVehicle(504,-1512.5873,997.2510,1037.4744,266.3276,-1,-1,30000);
	bloodring[4] = CreateVehicle(504,-1511.7264,1003.0253,1037.5596,259.9673,-1,-1,30000);
	bloodring[5] = CreateVehicle(504,-1509.8207,1008.7457,1037.6584,248.9884,-1,-1,30000);
	bloodring[6] = CreateVehicle(504,-1507.5673,1014.1100,1037.7435,241.7440,-1,-1,30000);
	bloodring[7] = CreateVehicle(504,-1504.5631,1019.4545,1037.8301,232.5302,-1,-1,30000);
	bloodring[8] = CreateVehicle(504,-1501.5422,1024.1310,1037.8987,226.8194,-1,-1,30000);
	bloodring[9] = CreateVehicle(504,-1496.4176,1028.2163,1037.9596,222.5379,-1,-1,30000);
	bloodring[10] = CreateVehicle(504,-1491.8132,1032.6909,1038.0123,219.6074,-1,-1,30000);
	bloodring[11] = CreateVehicle(504,-1485.4866,1037.2031,1038.0934,207.3084,-1,-1,30000);
	bloodring[12] = CreateVehicle(504,-1479.7878,1040.9780,1038.1427,207.1107,-1,-1,30000);
	for (new v; v < 13; v++){ LinkVehicleToInterior(bloodring[v],15); }

	//Sultan Vehicles:

	sultan[1] = CreateVehicle(560,-1381.3452,1103.5311,1039.9316,164.5846,-1,-1,30000);
	sultan[2] = CreateVehicle(560,-1386.7485,1104.0878,1039.9335,172.9897,-1,-1,30000);
	sultan[3] = CreateVehicle(560,-1391.7251,1104.2129,1039.9255,174.8298,-1,-1,30000);
	sultan[4] = CreateVehicle(560,-1396.9840,1104.2659,1039.9208,178.5663,-1,-1,30000);
	sultan[5] = CreateVehicle(560,-1402.1244,1103.6111,1039.9626,185.2027,-1,-1,30000);
	sultan[6] = CreateVehicle(560,-1407.1370,1103.4095,1039.9333,177.8269,-1,-1,30000);
	sultan[7] = CreateVehicle(560,-1412.8219,1103.0903,1039.9481,181.8065,-1,-1,30000);
	sultan[8] = CreateVehicle(560,-1417.4198,1102.6405,1039.9541,181.2966,-1,-1,30000);
	sultan[9] = CreateVehicle(560,-1423.1003,1101.8015,1039.9720,186.7991,-1,-1,30000);
	sultan[10] = CreateVehicle(560,-1427.6539,1100.9862,1039.9890,188.4233,-1,-1,30000);
	sultan[11] = CreateVehicle(560,-1431.5276,1100.1443,1039.9998,186.7679,-1,-1,30000);
	sultan[12] = CreateVehicle(560,-1437.2100,1097.2540,1039.9890,197.5737,-1,-1,30000);
	sultan[13] = CreateVehicle(560,-1442.3136,1095.2731,1040.0068,201.6615,-1,-1,30000);
	for (new v; v < 14; v++){ LinkVehicleToInterior(sultan[v],15); }

	//Motocross Vehicles:

	sanchez[1] = CreateVehicle(468,-1439.3760,-579.8417,1054.5488,92.0326,-1,-1,30000);
	sanchez[2] = CreateVehicle(468,-1436.1464,-579.4741,1054.5067,93.3891,-1,-1,30000);
	sanchez[3] = CreateVehicle(468,-1433.3723,-579.3203,1054.5248,91.6818,-1,-1,30000);
	sanchez[4] = CreateVehicle(468,-1430.6102,-579.1237,1054.5538,89.6607,-1,-1,30000);
	sanchez[5] = CreateVehicle(468,-1427.9949,-578.9437,1054.6050,89.5384,-1,-1,30000);
	sanchez[6] = CreateVehicle(468,-1425.5435,-579.0422,1054.7063,84.8389,-1,-1,30000);
	sanchez[7] = CreateVehicle(468,-1423.0688,-579.4833,1054.9297,82.3631,-1,-1,30000);
	sanchez[8] = CreateVehicle(468,-1438.7104,-595.9210,1055.6971,91.5345,-1,-1,30000);
	sanchez[9] = CreateVehicle(468,-1435.7230,-595.7872,1055.6741,91.6831,-1,-1,30000);
	sanchez[10] = CreateVehicle(468,-1432.3958,-595.7717,1055.7025,88.7012,-1,-1,30000);
	sanchez[11] = CreateVehicle(468,-1430.0227,-595.6384,1055.7289,89.9184,-1,-1,30000);
	sanchez[12] = CreateVehicle(468,-1427.5167,-595.7977,1055.8252,93.2964,-1,-1,30000);
	sanchez[13] = CreateVehicle(468,-1424.5443,-595.6749,1055.9581,93.6094,-1,-1,30000);
	sanchez[14] = CreateVehicle(468,-1421.7997,-595.8247,1056.2255,91.9004,-1,-1,30000);
	for (new v; v < 15; v++){ LinkVehicleToInterior(sanchez[v],4); }
	
    print( " " );
   	print( "<======10 Turismos successfully loaded...=====>" );
   	print( "<======12 Bloodringers successfully loaded...=>" );
   	print( "<======13 Sultan successfully loaded...======>" );
   	print( "<======14 Sanchez successfully loaded...==========>" );
   	print( " " );
   	print( " " );
    print( "<======B.I.G. Stadium TeleScript with Interior Vehicles Loaded v2.0=======>" );
    print( " " );
    
    
    
	return 1;
}

//If a player enter one of the Stadium Vehicles there´ll be a gametext for the vehicles which car he had entered!

public OnPlayerEnterVehicle(playerid, vehicleid) {
	new str[256];
	switch(GetVehicleModel(vehicleid))
	{
	case 451:{format(str,255,"~y~Turismo"),GameTextForPlayer(playerid,str,5000,1); return 1;}
	case 468:{format(str,255,"~y~Sanchez"),GameTextForPlayer(playerid,str,5000,1); return 1;}
	case 504:{format(str,255,"~y~Bloodring Banger"),GameTextForPlayer(playerid,str,5000,1); return 1;}
	case 560:{format(str,255,"~y~Sultan"),GameTextForPlayer(playerid,str,5000,1); return 1;}
	}
	return 1;
}

//Perfect Nitro System!

public IsPlayerInInvalidNosVehicle(playerid,vehicleid)
{

new InvalidNosVehicles[MAX_INVALID_NOS_VEHICLES] =
{
581,523,462,521,463,522,461,448,468,586,
509,481,510,472,473,493,595,484,430,453,
452,446,454,590,569,537,538,570,449
};

vehicleid = GetPlayerVehicleID(playerid);

if(IsPlayerInVehicle(playerid,vehicleid))
{
for(new i = 0; i < MAX_INVALID_NOS_VEHICLES; i++)
{
if(GetVehicleModel(vehicleid) == InvalidNosVehicles[i])
{
return true;
}
}
}
return false;
}


public OnPlayerCommandText(playerid, cmdtext[])
{


new name[MAX_PLAYER_NAME+1];
new string[256];
new Text: gText2;


//This is a textdraw under the minimap.The text can be changed or remove it!

{                                                                       //this
   gText2 = TextDrawCreate(10.0, 434.5, "~w~StadiumScript ~r~v2.0");    //can
   TextDrawFont(gText2,1);                                              //be
   TextDrawTextSize(gText2, 9.0, 9.0);                                  //removed
   TextDrawShowForPlayer(playerid, gText2);                             //or you can chance the text "StadiumScript v2.0"
}                                                                       //to your own text like homepage link or so on

//---------------------------------------------------------------//
//----------------------Derby Stadium teleports------------------//
//If you try to build the Vehicles in your Gamemode here is a tip//
//--Tip: LinkVehicletoInterior(GetPlayerVehicleID(playerid),)----//
//---------------------------------------------------------------//
//---------------------------------------------------------------//

    
if (strcmp(cmdtext, "/derby", true) == 0)
{
if(IsDerbyAllowed == 1)
{
SetPlayerInterior(playerid,15);
SetPlayerPos(playerid,-1515.2732,1015.4540,1037.9817);
GetPlayerName(playerid, name, sizeof(name));
format(string, sizeof(string), "%s has entered the Derby Stadium: /derby", name);
SendClientMessageToAll(COLOR_YELLOW, string);
ResetPlayerWeapons(playerid);
SendClientMessage(playerid, COLOR_ORANGE, "To start a race Countdown type /racecount !");
SendClientMessage(playerid, COLOR_LIGHTBLUE, "To left the stadium type: /exit");
}else{
if(IsDerbyAllowed == 0)
SendClientMessage(playerid, COLOR_RED, "The Derby Stadium is closed at this time.It will be opened later.Try another Stadium under: /telehelp");
}
return 1;
}

//______________________Dirtbike Stadium__________________________//

if (strcmp(cmdtext, "/dirtbike", true) == 0)
{
if(IsDirtbikeAllowed == 1)
{
SetPlayerInterior(playerid,4);
SetPlayerPos(playerid,-1448.4916,-580.3123,1055.1643);
GetPlayerName(playerid, name, sizeof(name));
format(string, sizeof(string), "%s has entered the Dirtbike Stadium: /dirtbike", name);
SendClientMessageToAll(COLOR_YELLOW, string);
ResetPlayerWeapons(playerid);
SendClientMessage(playerid, COLOR_ORANGE, "To start a race Countdown type /racecount !");
SendClientMessage(playerid, COLOR_LIGHTBLUE, "To left the stadium type: /exit");
}else{
if(IsDirtbikeAllowed == 0)
SendClientMessage(playerid, COLOR_RED, "The Dirtbike Stadium is closed.It will be opened later.Try another Stadium under: /telehelp");
}
return 1;
}

//______________________Sultan Stadium__________________________//

if(strcmp(cmdtext, "/sultan") == 0)
{
if(IsSultanAllowed == 1)
{
GetPlayerName(playerid, name, sizeof(name));
format(string, sizeof(string), "%s has entered the Sultan Stadium: /sultan", name);
SendClientMessageToAll(COLOR_YELLOW, string);
SetPlayerPos(playerid,-1443.8629,1087.9935,1040.7969);
SetPlayerInterior(playerid,15);
ResetPlayerWeapons(playerid);
SendClientMessage(playerid, COLOR_ORANGE, "To start a race Countdown type /racecount !");
SendClientMessage(playerid, COLOR_LIGHTBLUE, "To left the stadium type: /exit");
}else{
if(IsSultanAllowed == 0)
SendClientMessage(playerid, COLOR_RED, "The Sultan Stadium is closed.It will be opened later.Try another Stadium under: /telehelp");
}
return 1;
}

//______________________Race Stadium__________________________//

if(strcmp(cmdtext, "/race") == 0)
{
if(IsRaceAllowed == 1)
{
GetPlayerName(playerid, name, sizeof(name));
format(string, sizeof(string), "%s has entered the Race Stadium: /race", name);
SendClientMessageToAll(COLOR_YELLOW, string);
SetPlayerPos(playerid,-1403.7610,-227.0062,1043.2185);
SetPlayerInterior(playerid,7);
ResetPlayerWeapons(playerid);
SendClientMessage(playerid, COLOR_ORANGE, "To start a race Countdown type /racecount !");
SendClientMessage(playerid, COLOR_LIGHTBLUE, "To left the stadium type: /exit");
}else{
if(IsRaceAllowed == 0)
SendClientMessage(playerid, COLOR_RED, "The Race Stadium is closed.It will be opened later.Try another Stadium under: /telehelp");
}
return 1;
}

//______________________Exit Stadiums__________________________//

if(strcmp(cmdtext, "/exit") == 0) {
GetPlayerName(playerid, name, sizeof(name));
format(string, sizeof(string), "%s has left a Stadium!", name);
SendClientMessageToAll(COLOR_YELLOW, string);
SetPlayerInterior(playerid,0);
new randomize=random(sizeof(raus));
SetPlayerPos(playerid, raus[randomize][0],raus[randomize][1],raus[randomize][2]);
SetPlayerHealth(playerid, 100.0);
GivePlayerWeapon(playerid, 4, 1);
return 1;
}

//______________________Repair (costs 3000$)______________________________//

if(strcmp(cmdtext, "/rep", true) == 0) {
if(GetPlayerMoney(playerid) >= 3000) {
SetVehicleHealth(GetPlayerVehicleID(playerid), 1000);
GivePlayerMoney(playerid, -3000);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "<<<=== Direct-Reparature-Service ===>>>");
SendClientMessage(playerid, COLOR_YELLOW, "You´ve repaired your car for 3000$");
}else{SendClientMessage(playerid,COLOR_RED,"Not enough money.This costs 3000$");}
return 1;
}

//_____________________________Nitro(costs 3000$)__________________________//Updated: credits to [Cs]moe for nitro

if(strcmp(cmdtext,"/nitro",true)==0)
{
if(IsPlayerInInvalidNosVehicle(playerid,GetPlayerVehicleID(playerid)))
{
SendClientMessage(playerid,COLOR_YELLOW,"You cannot add nos to this vehicle.");
return 1;
}

if(IsPlayerInAnyVehicle(playerid))
{
if(GetPlayerState(playerid) == 2)
{
if(GetPlayerMoney(playerid) >= 3000) {
GivePlayerMoney(playerid, -3000);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "<<< Direct-Reparature-Service >>>");
SendClientMessage(playerid, COLOR_YELLOW, "You´ve tuned up your car with nitro for 3000$");
AddVehicleComponent(GetPlayerVehicleID(playerid),1010);
return 1;
}
else
{
SendClientMessage(playerid,COLOR_YELLOW,"You must be the driver to add nos.");
return 1;
}
}
else
{
SendClientMessage(playerid,COLOR_YELLOW,"You must be in a vehicle to use this command.");
return 1;
}
}
}


//______________________________Race Countdown_______________________________//

if (strcmp(cmdtext, "/racecount", true)==0)
{
if(Count >= 5)
{
SendClientMessageToAll(COLOR_GREEN, "A race is started!!!");
CountDown();
return 1;
}
else
{
SendClientMessage(playerid, COLOR_YELLOW, "A Race is already active.Try it later!!");
return 1;
}
}

//________________________________Open/Close Stadium Command______________________________//

//_____________Open/Close All______________//

if(strcmp(cmdtext, "/allopen") == 0)
{
if(IsPlayerAdmin(playerid))
{
IsDerbyAllowed = 1;
IsDirtbikeAllowed = 1;
IsSultanAllowed = 1;
IsRaceAllowed = 1;
SendClientMessage(playerid, COLOR_RED, "You´ve opened all Stadiums");
GameTextForAll("~r~All stadiums ~b~are now open",3000,6);
}
return 1;
}

if(strcmp(cmdtext, "/allclose") == 0)
{
if(IsPlayerAdmin(playerid))
{
IsDerbyAllowed = 0;
IsDirtbikeAllowed = 0;
IsSultanAllowed = 0;
IsRaceAllowed = 0;
SendClientMessage(playerid, COLOR_RED, "You´ve closed all Stadiums");
GameTextForAll("~r~All stadiums ~b~are now closed",3000,6);
}
return 1;
}

//_____________Open/Close Derby____________//

if(strcmp(cmdtext, "/derbyopen") == 0)
{
if(IsPlayerAdmin(playerid))
{
IsDerbyAllowed = 1;
SendClientMessage(playerid, COLOR_ORANGE, "You´ve opened the Derby Stadium");
GameTextForAll("~r~/derby ~b~is now open",3000,6);
}
return 1;
}


if(strcmp(cmdtext, "/derbyclose") == 0)
{
if(IsPlayerAdmin(playerid))
{
IsDerbyAllowed = 0;
SendClientMessage(playerid, COLOR_RED, "You´ve closed the Derby Stadium");
GameTextForAll("~r~/derby ~b~is closed",3000,6);
}
return 1;
}

//_____________Open/Close Sultan____________//

if(strcmp(cmdtext, "/sultanopen") == 0)
{
if(IsPlayerAdmin(playerid))
{
IsSultanAllowed = 1;
SendClientMessage(playerid, COLOR_WHITE, "You´ve opened the Sultan Stadium ( /sultan )");
GameTextForAll("~r~/sultan ~b~is now open",3000,6);
}
return 1;
}


if(strcmp(cmdtext, "/sultanclose") == 0)
{
if(IsPlayerAdmin(playerid))
{
IsSultanAllowed = 0;
SendClientMessage(playerid, COLOR_WHITE, "You´ve closed the Sultan Stadium ( /sultan )");
GameTextForAll("~r~/sultan ~b~is closed",3000,6);
}
return 1;
}

//_____________Open/Close Dirtbike____________//

if(strcmp(cmdtext, "/dirtbikeopen") == 0)
{
if(IsPlayerAdmin(playerid))
{
IsDirtbikeAllowed = 1;
SendClientMessage(playerid, COLOR_WHITE, "You´ve opened the Dirtbike Stadium ( /dirtbike )");
GameTextForAll("~r~/dirtbike ~b~is now open",3000,6);
}
return 1;
}


if(strcmp(cmdtext, "/dirtbikeclose") == 0)
{
if(IsPlayerAdmin(playerid))
{
IsDirtbikeAllowed = 0;
SendClientMessage(playerid, COLOR_WHITE, "You´ve closed the Dirtbike Stadium ( /dirtbike )");
GameTextForAll("~r~/dirtbike ~b~is closed",3000,6);
}
return 1;
}

//_____________Open/Close Race____________//

if(strcmp(cmdtext, "/raceopen") == 0)
{
if(IsPlayerAdmin(playerid))
{
IsRaceAllowed = 1;
SendClientMessage(playerid, COLOR_WHITE, "You´ve opened the Race Stadium ( /race )");
GameTextForAll("~r~/race ~b~is now open",3000,6);
}
return 1;
}


if(strcmp(cmdtext, "/raceclose") == 0)
{
if(IsPlayerAdmin(playerid))
{
IsRaceAllowed = 0;
SendClientMessage(playerid, COLOR_WHITE, "You´ve closed the Race Stadium ( /race )");
GameTextForAll("~r~/race ~b~is closed",3000,6);
}
return 1;
}

//___________________________Admin Commands________________________//

if (strcmp(cmdtext, "/astadium", true) == 0) {
SendClientMessage(playerid, COLOR_LIGHTBLUE, "<==================Admin Stadium Commands==================>");
SendClientMessage(playerid, COLOR_RED, "***POSSIBLE*** Before you can use the following commands you must be logged into Rcon!!!");
SendClientMessage(playerid, COLOR_ORANGE, "To Open/Close all Stadiums: /allopen /allclose");
SendClientMessage(playerid, COLOR_ORANGE, "To Open/Close the /derby Stadium: /derbyopen /derbyclose");
SendClientMessage(playerid, COLOR_ORANGE, "To Open/Close the /race Stadium: /raceopen /raceclose");
SendClientMessage(playerid, COLOR_ORANGE, "To Open/Close the /sultan Stadium: /sultanopen /sultanclose");
SendClientMessage(playerid, COLOR_ORANGE, "To Open/Close the /dirtbike Stadium: /dirtbikeopen /dirtbikeclose");
SendClientMessage(playerid, COLOR_GREY, "On each Open/Close Command there´ll be an announce to all!!");
return 1;
}

//__________________________Help Command___________________________//

if (strcmp(cmdtext, "/telehelp", true) == 0) {
SendClientMessage(playerid, COLOR_LIGHTBLUE, "----------------Stadium Help by B.I.G. v2.0---------------");
SendClientMessage(playerid, COLOR_ORANGE, " /dirtbike to enter the Dirtbike Stadium!");
SendClientMessage(playerid, COLOR_ORANGE, " /derby to enter the Derby Stadium!");
SendClientMessage(playerid, COLOR_ORANGE, " /sultan to enter the Sultan Stadium!");
SendClientMessage(playerid, COLOR_ORANGE, " /race to enter the Race Stadium!");
SendClientMessage(playerid, COLOR_ORANGE, " /exit to left a Stadium!");
SendClientMessage(playerid, COLOR_ORANGE, " In Car Commands: /nitro (to get nitro) /rep (to repair your car directly) ");
SendClientMessage(playerid, COLOR_ORANGE, " /racecount (to start a race countdown) !!!");
SendClientMessage(playerid, COLOR_ORANGE, " NEW: Admins can open or close each Stadium.More Informations: /astadium !");
SendClientMessage(playerid, COLOR_RED, " Don´t kill persons in the Stadium or you´ll get banned.This is only a race stadium!!!!");
return 1;
}
return 0;
}

