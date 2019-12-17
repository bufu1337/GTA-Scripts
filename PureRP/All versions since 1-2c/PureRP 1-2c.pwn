/*
This is the new version of my basic rp script now using dcmd with login
register and Local and Public Chat, If you wish to modify / edited this gamemode
please leave credits when / if you release it
Thanks

Smokie / Weeds

This is the edited version. Edits by M1k3.
*/


#include <a_samp>
#include <dini>
#include <dudb>
#include <core> //#include by M1k3
#include <float>//#include by M1k3

static gTeam[MAX_PLAYERS]; // Tracks the team assignment for each player
//The following static was added by M1k3
static currentlyCuffed[MAX_PLAYERS]; //Stores the Timer ID for each player in case KillTimer is neccessary
static pPilot;//stores the ID of the current taxidriver
static Taxidrvr;//stores the ID of the current taxidriver
static Taxicust;//stores the ID of the current taxicustomer
static Servertime;

#define dcmd(%1,%2,%3) if ((strcmp(%3, "/%1", true, %2+1) == 0)&&(((%3[%2+1]==0)&&(dcmd_%1(playerid,"")))||((%3[%2+1]==32)&&(dcmd_%1(playerid,%3[%2+2]))))) return 1
#define Level(%1) dini_Get(udb_encode(%1),"Level")
#define banportal "bans.txt"
#define VTYPE_CAR 1
#define VTYPE_HEAVY 2
#define VTYPE_BIKE 3
#define VTYPE_AIR 4
#define VTYPE_SEA 5
#define VTYPE_GOV 6
#define CAM_REFRESH_RATE 200
#define CAM_ZOOM1 6
#define CAM_ZOOM2 9
#define CAM_ZOOM3 15

//The following team definitions are added by M1k3
#define TEAM_CIVS 1
#define TEAM_SENIORS 2
#define TEAM_WAITERS 3
#define TEAM_CRIMINALS 4
#define TEAM_SECURITIES 5
#define TEAM_PILOTS 6
#define TEAM_ENTERTAINERS 7
#define TEAM_MEDICS 8
#define TEAM_FIREMEN 9
#define TEAM_COPS 10

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x00FF00AA
#define COLOR_LIGHTGREEN 0x7FFFFF
#define COLOR_DARKGREEN 0x0064FF
#define COLOR_RED 0xFF0000AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define BBLUE 0x00BFFFAA
#define COLOR_LIGHTBLUE 0x1C86EEAA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BRIGHTRED 0xB22222

// forward declarations for the PAWN compiler added by M1k3
forward SetPlayerToTeamColor(playerid);
forward SetupPlayerForClassSelection(playerid);
forward CheckAutoKick();
forward CheckSOS();
forward CheckSOS2();
forward TimerUncuff();
forward TimerCheck();
forward TimerJail();
forward Payday();
forward RemoveTimer();
forward PilotWatchTimer();
forward WantedTimer();
//---------------------------------------------------------

enum Info
{
	Logged,
	Skin, //Line added by M1k3
	Admin, //Line added by M1k3
	Bank,
	Banned,
	AutoKick, //Line added by M1k3
	Spawned,
	GetSkin, //Line added by M1k3
	vehicle,
	isPassenger, //Line added by M1k3
	Boarded, //Line added by M1k3
	WatchPilot, //Line added by M1k3
	PWTimer, //Line added by M1k3
	Remove, //Line added by M1k3
	Wanted, //Line added by M1k3
	WantedLevel, //Line added by M1k3
	AddWanted, //Line added by M1k3
	Jailable, //Line added by M1k3
	Jailed, //Line added by M1k3
	OldX, //Line added by M1k3
	OldY, //Line added by M1k3
	OldZ, //Line added by M1k3
	OldA, //Line added by M1k3
	Cuffed, //Line added by M1k3
	SOS, //Line added by M1k3
    blink1, //Line added by M1k3
    Alarm,
	Mute, 
	SAPD,
	Int,
	c
}

enum Flight //added by M1k3
{
OnBlocks,
Flying,
GreenLight,
}

enum Pos
{
	Float:xL,
	Float:yL,
	Float:zL
}
enum SavePlayerPosEnum
{
    Float:LastX,
    Float:LastY,
    Float:LastZ
}

new hack;
new pFlight[Flight];
new pInfo[MAX_PLAYERS][Info];


//---------------------------------------------------------

main()
{
	print("\n----------------------------------");
	print("  San Andreas: Role Play By Weeds");
	print("  Edited to Pure RPG by M1k3"); //Line added by M1k3
	print("----------------------------------\n");
	if(!dini_Exists(banportal))
	{
	    dini_Create(banportal);
	    print("\n-------------------------------------");
	    print("Banportal not found. Banportal created.");
	    print("-------------------------------------\n");
	}
}

stock Float:GetDistanceBetweenPlayers(p1,p2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if (!IsPlayerConnected(p1) || !IsPlayerConnected(p2))
	{
		return -1.00;
	}
	GetPlayerPos(p1,x1,y1,z1);
	GetPlayerPos(p2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

stock GetClosestPlayer(playerid) {
	new x,Float:dis,Float:dis2,player;
	new pteam[MAX_PLAYERS];
	player = -1;
	dis = 99999.99;
	for (x=0;x<MAX_PLAYERS;x++) {
		if (x != playerid) {
			dis2 = GetDistanceBetweenPlayers(x,playerid);
			if (dis2 < dis && dis2 != -1.00 && pteam[x] == pteam[playerid]) {
				dis = dis2;
				player = x;
			}
		}
	}
	return player;
}

//---------------------------------------------------------
//Function added by M1k3

public AutoReminder()
{
GameTextForAll("Remember to ALWAYS ~r~/register ~w~ and ~r~/login",3333,5);
}
//---------------------------------------------------------
//Function added by M1k3

public TimerUncuff()
{
for(new a=0; a<MAX_PLAYERS; a++){
if(IsPlayerConnected(a)){
	if (pInfo[a][Cuffed] == 1){
		pInfo[a][Cuffed] = 0;
		TogglePlayerControllable(a,true);
		SendClientMessage(a,COLOR_LIGHTGREEN, "You managed to uncuff yourself and are free to move again.");
		SendClientMessage(a,COLOR_LIGHTGREEN, "As soon as you get a chance get off that car [Hold F!] and run!");
		new uncuffname[24],uncuffmsg[120];
		GetPlayerName(a,uncuffname,sizeof(uncuffname));
		format(uncuffmsg,sizeof(uncuffmsg),"Suspect %s managed to uncuff himself and is on the run.",uncuffname);
		SendClientMessageToAll(BBLUE,uncuffmsg);
		return 1;
		}
}
}
return 1;
}

//---------------------------------------------------------
//Function added by M1k3

public TimerCheck()
{
for(new b=0; b<MAX_PLAYERS; b++){
if(IsPlayerConnected(b)){

	if (pInfo[b][WantedLevel] >= 1){

	    	if (pInfo[b][Cuffed] == 1){
				pInfo[b][Jailable] = 1;
				SendClientMessage(b,BBLUE, "The cop nods his head.");
				SendClientMessage(b,COLOR_RED, "Point of no return!");
 				SendClientMessage(b,COLOR_LIGHTGREEN, "Last chance: Your are uncuffed in about 10 seconds. RUN!");
				}
    	else
		pInfo[b][Jailable] = 0;
		}
else
pInfo[b][Jailable] = 0;
}
}
SendClientMessageToAll(BBLUE, "***The cop HQ processed a wanted check as requested***");
SendClientMessageToAll(COLOR_RED, "***Cops try to /jail a cuffed person near you!***");
return 1;
}

//---------------------------------------------------------
//Function added by M1k3

public CheckAutoKick()
{
new autokickmsg[120];

for(new d=0; d<MAX_PLAYERS; d++){
if(IsPlayerConnected(d)){
	if (pInfo[d][Banned]){
	pInfo[d][Banned] = 0;
	Kick (d);
	format(autokickmsg,sizeof(autokickmsg),"ID %d auto-kicked. Reason: Banned",d);
	print(autokickmsg);
 	}
	if (pInfo[d][AutoKick]){
    pInfo[d][AutoKick] = 0;
	Kick (d);
 	format(autokickmsg,sizeof(autokickmsg),"ID %d auto-kicked. Reason: Requested",d);
	print(autokickmsg);
	}
}
}
return 1;
}

//---------------------------------------------------------
//Function added by M1k3
public CheckSOS()
{
for(new s=0; s<MAX_PLAYERS; s++){
	if(IsPlayerConnected(s)){
 		if (pInfo[s][SOS] && !pInfo[s][blink1]){
        pInfo[s][blink1] = 1;
		SetPlayerToTeamColor(s);
 		}
	}
}
return 1;
}

//---------------------------------------------------------
//Function added by M1k3
public CheckSOS2()
{
for(new s=0; s<MAX_PLAYERS; s++){
	if(IsPlayerConnected(s)){
 		if (pInfo[s][SOS] && pInfo[s][blink1]){
		pInfo[s][blink1] = 0;
        SetPlayerColor(s,COLOR_GREY);
		}
	}
}
return 1;
}



//---------------------------------------------------------
//Function added by M1k3

public TimerJail()
{
for(new e=0; e<MAX_PLAYERS; e++){
if(IsPlayerConnected(e)){
	if (pInfo[e][Jailed] == 1){
		pInfo[e][Jailed] = 0;
		pInfo[e][WantedLevel] = 0;
		TogglePlayerControllable(e,true);
		GameTextForPlayer(e,"You paid your debt to society.",3333,5);
		SetPlayerInterior(e,0);
		SetPlayerPos(e,1551.0000,-1676.0000,16.0000);
		SetPlayerFacingAngle(e,87.0);
		PlayerPlaySound(e,1069,1551.0000,-1676.0000,16.0000);
		}
}
}
return 1;
}

//---------------------------------------------------------
//Function added by M1k3
public Payday()
{
new newstr[120];
Servertime = Servertime + 1;

if (Servertime==24) Servertime=0;
	if (Servertime<10) format(newstr,sizeof(newstr),"The time is now 0%d:00h",Servertime);
	else format(newstr,sizeof(newstr),"The time is now %d:00h",Servertime);
SetWorldTime(Servertime);
dini_IntSet("Servertime","Time",Servertime);
for(new p=0; p<MAX_PLAYERS; p++){
if(IsPlayerConnected(p)){
switch (gTeam[p]){
	case TEAM_CIVS:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"Your employer grants you..");
	SendClientMessage(p,COLOR_ORANGE,"          2000$          ");
	SendClientMessage(p,COLOR_WHITE,"**************************");
	GameTextForPlayer(p,"~b~ 2000$",3999,1);
	GivePlayerMoney(p,2000);
 	}
	case TEAM_SENIORS:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"Your pension is...........");
	SendClientMessage(p,COLOR_ORANGE,"          1000$          ");
	SendClientMessage(p,COLOR_WHITE,"**************************");
	GameTextForPlayer(p,"~b~ 1000$",3999,1);
	GivePlayerMoney(p,1000);
 	}
	case TEAM_WAITERS:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"Your employer grants you..");
	SendClientMessage(p,COLOR_ORANGE,"          3000$          ");
	SendClientMessage(p,COLOR_WHITE,"**************************");
	GameTextForPlayer(p,"~b~ 3000$",3999,1);
	GivePlayerMoney(p,3000);
 	}
	case TEAM_CRIMINALS:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"Your gang leader grants...");
	SendClientMessage(p,COLOR_ORANGE,"          4000$          ");
	SendClientMessage(p,COLOR_WHITE,"**************************");
	GameTextForPlayer(p,"~b~ 4000$",3999,1);
	GivePlayerMoney(p,4000);
 	}
	case TEAM_SECURITIES:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"Your employer grants you..");
	SendClientMessage(p,COLOR_ORANGE,"          5000$          ");
	SendClientMessage(p,COLOR_WHITE,"**************************");
	GameTextForPlayer(p,"~b~ 5000$",3999,1);
	GivePlayerMoney(p,5000);
 	}
	case TEAM_PILOTS:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"The airline pays..........");
	SendClientMessage(p,COLOR_ORANGE,"          8000$          ");
	SendClientMessage(p,COLOR_WHITE,"**************************");
	GameTextForPlayer(p,"~b~ 8000$",3999,1);
	GivePlayerMoney(p,8000);
 	}
	case TEAM_ENTERTAINERS:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"Your employer grants you..");
	SendClientMessage(p,COLOR_ORANGE,"          1000$          ");
	SendClientMessage(p,COLOR_WHITE,"**************************");
	GameTextForPlayer(p,"~b~ 1000$",3999,1);
	GivePlayerMoney(p,1000);
 	}
	case TEAM_MEDICS:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"The hospital pays you.....");
	SendClientMessage(p,COLOR_ORANGE,"         10000$          ");
	SendClientMessage(p,COLOR_WHITE,"**************************");
	GameTextForPlayer(p,"~b~ 10000$",3999,1);
	GivePlayerMoney(p,10000);
 	}
	case TEAM_FIREMEN:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"The department pays you...");
	SendClientMessage(p,COLOR_ORANGE,"         10000$          ");
	SendClientMessage(p,COLOR_WHITE,"**************************");
	GameTextForPlayer(p,"~b~ 10000$",3999,1);
	GivePlayerMoney(p,10000);
 	}
	case TEAM_COPS:{
	SendClientMessage(p,COLOR_WHITE,"********* Payday *********");
	SendClientMessage(p,COLOR_WHITE,newstr);
	SendClientMessage(p,COLOR_WHITE,"**************************");
	SendClientMessage(p,COLOR_WHITE,"The department pays you...");
	SendClientMessage(p,COLOR_ORANGE,"         10000$          ");
	SendClientMessage(p,COLOR_WHITE,"**************************");
	GameTextForPlayer(p,"~b~ 10000$",3999,1);
	GivePlayerMoney(p,10000);
 	}
}
}
}
printf ("***** Payday ***** Worldtime (%s)",newstr);
return 1;
}

//---------------------------------------------------------
//Function added by M1k3

public RemoveTimer()
{
for(new r=0; r<MAX_PLAYERS; r++){
	if(IsPlayerConnected(r)){
		if (pInfo[r][Remove]){
		RemovePlayerFromVehicle(r);
		pInfo[r][Remove] = 0;
 		}
	}
}
return 1;
}

//---------------------------------------------------------
//Function added by M1k3

public PilotWatchTimer()
{
for(new pw=0; pw<MAX_PLAYERS; pw++){
	if(IsPlayerConnected(pw)){
		if (pInfo[pw][WatchPilot] == 1){
		new Float:coorX;
		new Float:coorY;
		new Float:coorZ;
		GetPlayerPos(pPilot,coorX,coorY,coorZ);
		SetPlayerInterior(pw,0);
		SetPlayerCameraPos(pw,coorX + 50, coorY + 50, coorZ + 10);
		SetPlayerCameraLookAt(pw,coorX,coorY,coorZ);
 		}
 		
		if (pInfo[pw][WatchPilot] == 0){

		    if (pInfo[pPilot][vehicle] == 14 && pInfo[pw][Boarded]){
			SetPlayerPos(pw,2.384830,33.103397,1199.849976);
			SetPlayerInterior(pw,1);
//			SetPlayerCameraPos(pw,2.384830,33.103397,1199.849976);
//			SetPlayerCameraLookAt(pw,2.384830,33.103397,1199.849976);
	    	SetCameraBehindPlayer(pw);
			}

			if (pInfo[pPilot][vehicle] == 139 && pInfo[pw][Boarded]){
			SetPlayerPos(pw,315.856170,1024.496459,1949.797363);
			SetPlayerInterior(pw,9);
//			SetPlayerCameraPos(pw,315.856170,1024.496459,1949.797363);
//			SetPlayerCameraLookAt(pw,315.856170,1024.496459,1949.797363);
	    	SetCameraBehindPlayer(pw);
			GivePlayerWeapon(pw,46,1);
			}
 		}
 		
	}
}
return 1;
}

//---------------------------------------------------------
//Function added by M1k3

public WantedTimer()
{
for(new wt=0; wt<MAX_PLAYERS; wt++){
	if(IsPlayerConnected(wt)){
		if (pInfo[wt][AddWanted]){
		pInfo[wt][AddWanted] = 0;
		pInfo[wt][WantedLevel] = pInfo[wt][WantedLevel] + 1;
 		}
	}
}
return 1;
}

//---------------------------------------------------------
//Function added by M1k3

public SetPlayerToTeamColor(playerid)
{
gTeam[playerid] = GetPlayerTeam(playerid);
switch (gTeam[playerid]) {
	case TEAM_CIVS: SetPlayerColor(playerid,COLOR_WHITE); 
	case TEAM_SENIORS: SetPlayerColor(playerid,COLOR_WHITE); 
	case TEAM_WAITERS: SetPlayerColor(playerid,COLOR_LIGHTBLUE); 
	case TEAM_CRIMINALS: SetPlayerColor(playerid,COLOR_ORANGE);
	case TEAM_SECURITIES: SetPlayerColor(playerid,COLOR_LIGHTBLUE); 
	case TEAM_PILOTS: SetPlayerColor(playerid,COLOR_YELLOW); 
	case TEAM_ENTERTAINERS: SetPlayerColor(playerid,COLOR_BRIGHTRED);
	case TEAM_MEDICS: SetPlayerColor(playerid,COLOR_PINK);
	case TEAM_FIREMEN: SetPlayerColor(playerid,COLOR_RED);
	case TEAM_COPS: SetPlayerColor(playerid,BBLUE);
	}
}
//---------------------------------------------------------
//Function added by M1k3

public SetupPlayerForClassSelection(playerid)
{
	// Set the player's orientation when they're selecting a class.
	SetPlayerPos(playerid,1685.5280,-2240.3850,13.5469);
	SetPlayerCameraPos(playerid,1685.5280,-2237.3850,13.5469);
	SetPlayerCameraLookAt(playerid,1685.5280,-2240.3850,13.5469);
	SetPlayerFacingAngle(playerid,0.0);
	PlayerPlaySound(playerid, 1062, 1685.5280,-2240.3850,13.5469);
}


//---------------------------------------------------------
//Callback added by M1k3

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
new player[24],vname[24],entermsg[120];
GetPlayerName(playerid,player,sizeof(player));

if (ispassenger!=0) return 0;

if (gTeam[playerid] != TEAM_PILOTS && vehicleid == 139){
	SendClientMessage(playerid,COLOR_RED,"(Remove) You are not licensed to control or own this vehicle. Ownership removed.");
	SendClientMessage(playerid,COLOR_YELLOW,"You need to be in the pilot role to become the charter pilot!");
	RemovePlayerFromVehicle(playerid);
	pInfo[playerid][vehicle] = 0;
	return 0;
	}

if (pInfo[playerid][vehicle]!=0 && vehicleid!=pInfo[playerid][vehicle]){
SendClientMessage(playerid,COLOR_RED, "This is not your vehicle - you are now wanted for trying car theft.");
pInfo[playerid][AddWanted] = 1;
pInfo[playerid][Remove] = 1;
SendClientMessage(playerid,COLOR_RED, "(Remove) You will be removed from the vehicle within 10 seconds.");
SendClientMessage(playerid,COLOR_YELLOW, "Type /sell before you try to aquire another vehicle.");
return 1;
}

if (ispassenger == 0){
	for (new v=0;v<MAX_PLAYERS;v++){
		if (IsPlayerConnected(v)){
	    	if (pInfo[v][vehicle] == vehicleid && pInfo[playerid][vehicle]!=vehicleid){
	    	GetPlayerName(v,vname,sizeof(vname));
	    	pInfo[playerid][Remove] = 1;
	   		format(entermsg,sizeof(entermsg),"(Remove) This vehicle belongs to %s (ID %d). Ask him to /sell before you enter as driver",vname,v);
	    	SendClientMessage(playerid,COLOR_RED,entermsg);
	    	pInfo[playerid][AddWanted] = 1;
   	    	SendClientMessage(playerid,COLOR_RED,"(Wanted) You are now a wanted criminal for trying vehicle theft.");
	    	format(entermsg,sizeof(entermsg),"~r~(Vehicle) %s (ID %d) tried to enter your vehicle. ~n~ ~w~He is now a wanted criminal for trying vehicle theft.",player,playerid);
	    	GameTextForPlayer(v,entermsg,3333,5);
	    	}
		}
	}
pInfo[playerid][vehicle] = vehicleid;
}

if (pInfo[playerid][vehicle] == vehicleid){
DisablePlayerCheckpoint(playerid);
GameTextForPlayer(playerid,"~g~This is your vehicle",3333,5);
return 1;
}
return 1;
}

//---------------------------------------------------------
//Callback added by M1k3
public OnPlayerExitVehicle(playerid, vehicleid)
{
	if (playerid == pPilot && !pFlight[OnBlocks] && pFlight[Flying]){
	pPilot = -1;
	SendClientMessage(playerid,COLOR_RED,"The airline fired you because you left your plane before the flight was complete.");
	SendClientMessageToAll(BBLUE,"The charter pilot position became vacant. Get a jet and enter /charter to be the next one.");
	return 1;
	}
return 1;
}
//---------------------------------------------------------
//Callback Edited by M1k3
public OnGameModeInit()
{
	SetGameModeText("Pure RPG v.1.2c"); //Added by M1k3
	ShowNameTags(1);
	ShowPlayerMarkers(1);
	Servertime = strval(dini_Get("Servertime","Time"));
	SetWorldTime(Servertime);
	print(" \n");
	printf("***** SERVER INITIAZLIED ***** - Worldtime %d",Servertime);
	
	SetTimer("AC2",1280,1);
	SetTimer("Anticheat",900,1);
	SetTimer("CHAck",60000,1);
	SetTimer("Sec",1000,1);// 1000 ms = 1 sec
	SetTimer("CheckAutoKick",5000,1); //Added by M1k3 (5 seconds)
	SetTimer("Payday",3600000,1);//Added by M1k3 (1 hour)
	SetTimer("RemoveTimer",10000,1); //Added by M1k3 (10 seconds)
	SetTimer("WantedTimer",500,1); //Added by M1k3 (0,5 seconds)
	SetTimer("CheckSOS",1000,1);//Added by M1k3 (1 second)
	SetTimer("CheckSOS2",2000,1);//Added by M1k3 (2 seconds)
	SetTimer("PilotWatchTimer",2000,1);//Added by M1k3 (2 seconds)
	
	
//Class re-assignment including teams,co-ordinates and weapons by M1k3
	
AddPlayerClassEx(1,7,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);//Team 1 (Civilists)
AddPlayerClassEx(1,12,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 0-91
AddPlayerClassEx(1,16,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 2
AddPlayerClassEx(1,17,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 3
AddPlayerClassEx(1,18,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 4
AddPlayerClassEx(1,19,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 5
AddPlayerClassEx(1,20,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 6
AddPlayerClassEx(1,21,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 7
AddPlayerClassEx(1,23,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 8
AddPlayerClassEx(1,26,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 9
AddPlayerClassEx(1,27,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class 10
AddPlayerClassEx(1,34,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,35,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,36,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,37,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,40,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,45,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,50,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,51,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,52,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,55,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,56,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,59,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,60,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,67,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,69,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,72,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,73,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,80,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,81,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,91,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,96,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,97,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,99,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,101,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,138,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,139,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,140,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,141,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,142,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,147,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,148,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,151,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,153,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,154,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,157,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,169,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,170,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,176,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,177,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,180,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,185,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,186,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,187,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,188,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,190,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,191,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,192,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,198,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,199,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,201,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,202,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,203,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,204,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,206,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,211,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,214,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,215,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,216,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,219,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,221,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,222,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,223,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,226,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,227,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,233,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,240,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,241,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,242,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,250,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,251,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,252,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,258,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,259,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,260,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,261,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,262,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,263,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,290,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,291,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,296,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(1,297,1685.5280,-2240.3850,13.5469,179.7263,14,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,9,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);//Team 2 (Seniors)
AddPlayerClassEx(2,10,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);//Class 92 - 156
AddPlayerClassEx(2,14,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,15,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,31,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,32,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,33,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,38,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,39,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,43,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,44,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,49,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,53,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,54,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,57,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,58,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,62,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,68,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,75,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,76,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,77,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,78,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,79,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,88,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,89,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,93,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,94,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,95,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,128,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,129,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,130,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,132,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,133,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,134,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,135,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,136,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,137,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,150,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,156,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,158,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,159,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,160,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,161,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,162,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,182,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,183,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,196,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,197,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,200,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,210,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,212,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,213,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,218,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,220,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,224,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,225,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,228,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,229,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,230,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,231,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,232,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,234,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,235,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,236,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(2,239,1685.5280,-2240.3850,13.5469,179.7263,15,1,0,0,-1,-1);// Class
AddPlayerClassEx(3,11,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);//Team 3 (Waiters)
AddPlayerClassEx(3,155,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);//Class 157 - 168
AddPlayerClassEx(3,167,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class
AddPlayerClassEx(3,168,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class
AddPlayerClassEx(3,171,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class
AddPlayerClassEx(3,172,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class
AddPlayerClassEx(3,179,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class
AddPlayerClassEx(3,189,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class
AddPlayerClassEx(3,194,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class
AddPlayerClassEx(3,205,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class
AddPlayerClassEx(3,209,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class
AddPlayerClassEx(3,253,1685.5280,-2240.3850,13.5469,179.7263,7,1,0,0,-1,-1);// Class
AddPlayerClassEx(4,13,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);//Team 4 (Criminals)
AddPlayerClassEx(4,22,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);//Class 169 - 221
AddPlayerClassEx(4,28,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 171
AddPlayerClassEx(4,29,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 172
AddPlayerClassEx(4,30,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 173
AddPlayerClassEx(4,41,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 174
AddPlayerClassEx(4,46,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 175
AddPlayerClassEx(4,47,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 176
AddPlayerClassEx(4,48,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 177
AddPlayerClassEx(4,98,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 178
AddPlayerClassEx(4,100,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 179
AddPlayerClassEx(4,102,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 180
AddPlayerClassEx(4,103,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 181
AddPlayerClassEx(4,104,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 182
AddPlayerClassEx(4,105,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 183
AddPlayerClassEx(4,106,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class 184
AddPlayerClassEx(4,107,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class
AddPlayerClassEx(4,108,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class
AddPlayerClassEx(4,109,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class
AddPlayerClassEx(4,110,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class
AddPlayerClassEx(4,111,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class
AddPlayerClassEx(4,112,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class
AddPlayerClassEx(4,113,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class
AddPlayerClassEx(4,114,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class
AddPlayerClassEx(4,115,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class
AddPlayerClassEx(4,116,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class
AddPlayerClassEx(4,117,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);// Class
AddPlayerClassEx(4,118,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,120,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,121,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,122,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,123,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,126,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,127,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,143,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,144,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,145,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,146,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,173,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,174,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,175,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,181,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,184,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,195,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,247,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,248,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,249,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,254,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,292,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,293,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,294,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,298,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(4,0,1685.5280,-2240.3850,13.5469,179.7263,5,1,22,30,-1,-1);
AddPlayerClassEx(5,24,1685.5280,-2240.3850,13.5469,179.7263,3,1,23,30,-1,-1);//Team 5 (Securities)
AddPlayerClassEx(5,25,1685.5280,-2240.3850,13.5469,179.7263,3,1,23,30,-1,-1);//Class 222 - 229
AddPlayerClassEx(5,66,1685.5280,-2240.3850,13.5469,179.7263,3,1,23,30,-1,-1);
AddPlayerClassEx(5,124,1685.5280,-2240.3850,13.5469,179.7263,3,1,23,30,-1,-1);
AddPlayerClassEx(5,125,1685.5280,-2240.3850,13.5469,179.7263,3,1,23,30,-1,-1);
AddPlayerClassEx(5,163,1685.5280,-2240.3850,13.5469,179.7263,3,1,23,30,-1,-1);
AddPlayerClassEx(5,164,1685.5280,-2240.3850,13.5469,179.7263,3,1,23,30,-1,-1);
AddPlayerClassEx(5,217,1685.5280,-2240.3850,13.5469,179.7263,3,1,23,30,-1,-1);
AddPlayerClassEx(6,61,1900.1691,-2629.6445,14.4509,359.9915,46,1,39,5,40,5);//Team 6 (Pilots)
AddPlayerClassEx(6,255,1900.1691,-2629.6445,14.4509,359.9915,46,1,39,5,40,5);//Class 230 - 231
AddPlayerClassEx(7,63,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);//Team 7 (Entertainers)
AddPlayerClassEx(7,64,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);//Class 232 - 252
AddPlayerClassEx(7,82,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(7,83,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(7,84,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(7,85,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(7,87,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(7,90,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(7,92,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(7,131,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(7,152,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(7,178,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(7,207,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(7,237,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(7,238,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(7,243,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(7,244,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(7,245,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(7,256,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(7,257,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(7,264,1685.5280,-2240.3850,13.5469,179.7263,12,1,0,0,-1,-1);
AddPlayerClassEx(8,70,1173.0000,-1323.0000,15.0000,266.0000,2,1,0,0,-1,-1);//Team 8 (Medics)
AddPlayerClassEx(8,71,1173.0000,-1323.0000,15.0000,266.0000,2,1,0,0,-1,-1);//Class 253 - 258
AddPlayerClassEx(8,193,1173.0000,-1323.0000,15.0000,266.0000,2,1,0,0,-1,-1);
AddPlayerClassEx(8,274,1173.0000,-1323.0000,15.0000,266.0000,2,1,0,0,-1,-1);
AddPlayerClassEx(8,275,1173.0000,-1323.0000,15.0000,266.0000,2,1,0,0,-1,-1);
AddPlayerClassEx(8,276,1173.0000,-1323.0000,15.0000,266.0000,2,1,0,0,-1,-1);
AddPlayerClassEx(9,277,1154.0000,-1772.0000,17.500,359.7263,42,100000,0,0,-1,-1);//Team 9 (Firemen)
AddPlayerClassEx(9,278,1154.0000,-1772.0000,17.500,359.7263,42,100000,0,0,-1,-1);//Class 259 - 261
AddPlayerClassEx(9,279,1154.0000,-1772.0000,17.500,359.7263,42,100000,0,0,-1,-1);
AddPlayerClassEx(10,165,1584.4734,-1710.7793,5.6116,358.8000,24,30,3,1,-1,-1);//Team 10 (Cops)
AddPlayerClassEx(10,166,1584.4734,-1710.7793,5.6116,358.8000,24,30,3,1,-1,-1);//Class 262 - 274
AddPlayerClassEx(10,246,1584.4734,-1710.7793,5.6116,358.8000,24,30,3,1,-1,-1);
AddPlayerClassEx(10,280,1584.4734,-1710.7793,5.6116,358.8000,24,30,3,1,-1,-1);
AddPlayerClassEx(10,281,1584.4734,-1710.7793,5.6116,358.8000,24,30,3,1,-1,-1);
AddPlayerClassEx(10,282,1584.4734,-1710.7793,5.6116,358.8000,24,30,3,1,-1,-1);
AddPlayerClassEx(10,283,1584.4734,-1710.7793,5.6116,358.8000,24,30,3,1,-1,-1);
AddPlayerClassEx(10,284,1584.4734,-1710.7793,5.6116,358.8000,24,30,3,1,-1,-1);
AddPlayerClassEx(10,285,1584.4734,-1710.7793,5.6116,358.8000,24,30,3,1,-1,-1);
AddPlayerClassEx(10,286,1584.4734,-1710.7793,5.6116,358.8000,24,30,3,1,-1,-1);
AddPlayerClassEx(10,287,1584.4734,-1710.7793,5.6116,358.8000,24,30,3,1,-1,-1);
AddPlayerClassEx(10,288,1584.4734,-1710.7793,5.6116,358.8000,24,30,3,1,-1,-1);
AddPlayerClassEx(10,295,1584.4734,-1710.7793,5.6116,358.8000,24,30,3,1,-1,-1);

AddStaticPickup(361, 2, 1690.0000, -2693.0000, 14.0000); // Flamethrower at LSAP behind second hangar from the right
AddStaticPickup(371, 2, 1540.0000,-1354.0000,329.0000); // Parachute at skydive centre
AddStaticPickup(371, 2, 1542.0000,-1354.0000,329.0000); // Parachute at skydive centre
AddStaticPickup(1240, 2, 1544.0000,-1354.0000,329.0000); // Health pickup at skydive centre
AddStaticPickup(371, 2, 1546.0000,-1354.0000,329.0000); // Parachute at skydive centre
AddStaticPickup(371, 2, 1548.0000,-1354.0000,329.0000); // Parachute at skydive centre


// LS Spawns (complete new list including additons by M1k3)
// Public cars (cannot be owned by players, not wanted, locked for wrong roles)
AddStaticVehicle(416,1177.8671,-1339.0570,14.0500,272.0161,1,3); //1 PUBLIC Ambulance
AddStaticVehicle(416,1181.0000,-1309.0000,14.0500,272.0161,1,3); //2 PUBLIC Ambulance
AddStaticVehicle(596,1536.1121,-1675.1315,13.1033,359.7281,0,1); //3 PUBLIC Police
AddStaticVehicle(596,1595.4734,-1710.7783,5.6116,358.8000,0,1); //4 PUBLIC Police
AddStaticVehicle(596,1574.4998,-1710.7798,5.6088,358.9738,0,1); //5 PUBLIC Police
AddStaticVehicle(596,1545.3486,-1671.9728,5.6115,90.2820,0,1); //6 PUBLIC Police
AddStaticVehicle(420,1698.9376,-2258.4690,11.9893,89.0390,6,1); //7 PUBLIC Taxi Spawn row
AddStaticVehicle(438,1690.9376,-2258.4690,11.9893,89.0390,6,1); //8 PUBLIC Cabbie Spawn row
AddStaticVehicle(420,1674.9376,-2258.4690,11.9893,89.0390,6,1); //9 PUBLIC Taxi Spawn row
AddStaticVehicle(438,1666.9376,-2258.4690,11.9893,89.0390,6,1); //10 PUBLIC Cabbie Spawn row
AddStaticVehicle(487,1795.8918,-2422.7253,13.6982,254.0377,29,42); //11 PUBLIC Maverick
AddStaticVehicle(487,1868.4832,-2356.2820,13.6938,174.3298,12,39); //12 PUBLIC Maverick
AddStaticVehicle(487,1875.3844,-2453.8931,13.6939,38.3979,54,29); //13 PUBLIC Maverick
AddStaticVehicle(519,1823.1691,-2629.6445,14.4509,359.9915,1,1); //14 PUBLIC Shamal Jet
AddStaticVehicle(476,1982.8513,-2625.3264,14.2574,0.7603,119,117); //15 PUBLIC Rustler Warbird
AddStaticVehicle(476,2029.2488,-2625.9211,14.2494,0.0132,89,91); //16 PUBLIC Rustler Warbird
AddStaticVehicle(523,1602.2902,-1700.3253,5.4405,89.5781,0,0); //17 PUBLIC HPV1000
AddStaticVehicle(523,1545.6112,-1684.5996,5.4420,89.7391,0,0); //18 PUBLIC HPV1000
//Stealable cars (Wanted!)
AddStaticVehicle(509,2802.9829,-1254.8864,46.4637,130.9589,6,1); //19 Bicycle East Beach
AddStaticVehicle(509,2271.2920,-1647.2200,14.8925,180.2856,86,1); //20 Bicycle Ganton
AddStaticVehicle(509,1980.9343,-1993.6409,13.0650,358.7168,2,1); //21 Bicycle Willowfield
AddStaticVehicle(509,2151.1958,-1422.2174,25.0516,91.6600,20,1); //22 Bicycle Jefferson
AddStaticVehicle(542,2655.4697,-1131.2047,64.9305,89.4236,24,118); //23 Clover Los Flores
AddStaticVehicle(534,1786.6467,-1932.5216,13.0969,0.5401,42,42); //24 Remington Unity Station
AddStaticVehicle(534,2489.3230,-1953.1077,13.1727,357.6439,53,53); //25 Remington Willowfield
AddStaticVehicle(534,2792.3523,-1448.3152,27.9046,270.1395,24,24); //26 Remington East Beach Parking
AddStaticVehicle(521,1080.8081,-1772.7407,12.9032,269.6079,92,3); //27 FCR900 Conference Center
AddStaticVehicle(521,1017.0835,-1352.9435,12.9296,92.4913,6,6); //28 FCR900 Market
AddStaticVehicle(522,2800.6660,-1427.7903,19.7929,179.8456,3,8); //29 NRG500 East Peach Parking
AddStaticVehicle(567,2147.6819,-1161.6801,23.6752,269.9142,97,96); //30 Savanna Jefferson
AddStaticVehicle(547,1560.3119,-2263.4622,11.9896,89.0390,0,0); //31 Primo LSAP Parking
AddStaticVehicle(405,1560.3119,-2260.4622,11.9896,89.0390,1,1); //32 Sentinel LSAP Parking
AddStaticVehicle(534,1560.3119,-2257.4622,11.9896,89.0390,2,2); //33 Remington "
AddStaticVehicle(576,1560.3119,-2254.4622,11.9896,89.0390,3,3); //34 Tornado "
AddStaticVehicle(421,1560.3119,-2250.4622,11.9896,89.0390,4,4); //35 Washington "
AddStaticVehicle(561,1560.3119,-2247.4622,11.9896,90.0390,5,5); //36 Stratum "
AddStaticVehicle(543,1560.3119,-2241.4622,11.9896,90.0390,6,6); //37 Sadler "
AddStaticVehicle(445,1560.3119,-2237.4622,11.9896,90.0390,7,7); //38 Admiral "
AddStaticVehicle(567,1560.3119,-2234.4622,11.9896,90.0390,8,8); //39 Savanna "
AddStaticVehicle(402,1555.7167,-2213.0000,13.3813,179.4172,9,9); //40 Bufallo LSAP Parking
AddStaticVehicle(535,1552.7167,-2213.0000,13.3813,179.4172,10,10); //41 Slamvan "
AddStaticVehicle(559,1549.7167,-2213.0000,13.3813,179.4172,11,11); //42 Jester "
AddStaticVehicle(562,1546.7167,-2213.0000,13.3813,179.4172,12,12); //43 Elegy "
AddStaticVehicle(477,1542.7167,-2213.0000,13.3813,179.4172,13,13); //44 ZR350 "
AddStaticVehicle(587,1539.3000,-2213.0000,13.3813,179.4172,14,14); //45 Euros "
AddStaticVehicle(558,1535.7167,-2213.0000,13.3813,179.4172,15,15); //46 Uranus "
AddStaticVehicle(560,1532.7167,-2213.0000,13.3813,179.4172,0,0); //47 Sultan "
AddStaticVehicle(536,1530.0000,-2213.0000,13.3813,179.4172,16,16); //48 Blade "
AddStaticVehicle(445,1526.7167,-2213.0000,13.3813,179.4172,17,17); //49 Admiral "
AddStaticVehicle(522,421.9913,-1800.7980,5.1195,271.1656,3,3); //50 NRG500 Santa Maria Beach
AddStaticVehicle(576,2480.3967,-1748.0154,13.1587,359.9270,30,30); //51 Tornado Ganton
AddStaticVehicle(576,2676.2271,-1821.7797,8.9741,129.9665,53,53); //52 Tornado LS Stadium
AddStaticVehicle(522,540.3597,-1270.3364,16.8162,218.7203,51,118); //53 NRG500 Rodeo
AddStaticVehicle(405,1746.5309,-1455.8066,13.4025,273.2154,123,1); //54 Sentinel Commerce
AddStaticVehicle(522,733.9633,-1336.9241,13.1237,268.7378,36,105); //55 NRG500 Vinewood Studios
AddStaticVehicle(405,865.0643,-1468.2266,13.4884,178.4556,36,1); //56 Sentinel Marina
AddStaticVehicle(516,2757.7534,-2542.1335,13.4825,357.5735,0,0); //57 Nebula Ocean Docks
AddStaticVehicle(560,2294.8376,-1689.9841,13.2513,90.1564,1,0); //58 Sultan Ganton
AddStaticVehicle(522,1704.7474,-1068.9409,23.4666,179.2237,7,79); //59 NRG500 Mulholland Int Parking
AddStaticVehicle(560,1252.2246,-1834.7697,13.0957,0.2830,17,1); //60 Sultan Conference Center
AddStaticVehicle(522,2055.2537,-1903.8042,13.1264,180.5756,3,8); //61 NRG500 Idlewood
AddStaticVehicle(560,1001.2195,-1299.9288,13.0692,179.4557,37,0); //62 Sultan Market
AddStaticVehicle(415,1696.3761,-1508.5077,13.1471,180.2962,36,1); //63 Cheetah Commerce
AddStaticVehicle(415,1099.1349,-1757.9042,13.1239,90.1904,62,1); //64 Cheetah Conference Center
AddStaticVehicle(415,2401.3848,-1544.4290,23.7448,359.7998,92,1); //65 Cheetah East Los Santos
AddStaticVehicle(561,1051.6565,-923.1634,42.4986,5.2671,8,17); //66 Stratum Mulholland
AddStaticVehicle(451,737.0599,-1433.4712,13.2585,90.1515,3,3); //67 Tourismo Marina
AddStaticVehicle(451,1148.3650,-1297.7496,13.3752,359.7190,125,125); //68 Tourismo Market
AddStaticVehicle(535,1947.2350,-2126.8870,13.3041,269.9420,3,1); //69 Slamvan El Corona
AddStaticVehicle(451,2217.1843,-1166.1111,25.4190,90.4497,16,16); //70 Tourismo Jefferson Motel
AddStaticVehicle(445,2411.1770,-1391.1155,24.1969,83.3589,12,12); //71 Admiral East Los Santos
AddStaticVehicle(579,718.4528,-1437.0775,13.5129,270.5504,3,3); //72 Huntley Marina
AddStaticVehicle(547,1001.9851,-1105.5309,23.5983,89.6592,30,30); //73 Primo Temple
AddStaticVehicle(429,1617.1093,-2249.0054,-3.0870,271.9824,10,10); //74 Banshee LSAP Terminal
AddStaticVehicle(429,543.8020,-1503.2111,14.0175,359.8613,12,12); //75 Banshee Rodeo
AddStaticVehicle(536,2808.5691,-1428.7512,15.9977,178.2877,110,1); //76 Blade East Beach Parking Lot
AddStaticVehicle(558,1732.7289,-1751.9684,13.1406,0.6521,116,1); //77 Uranus Little Mexico
AddStaticVehicle(587,1358.2623,-1751.8116,13.1230,91.4508,53,1); //78 Euros Commerce
AddStaticVehicle(477,1278.1729,-1542.3838,13.2929,270.7140,103,103); //79 ZR350 Market
AddStaticVehicle(411,1645.1721,-1045.9775,23.4882,179.2404,112,1); //80 Infernus Mulholland Int Parking
AddStaticVehicle(562,1616.2500,-1128.2058,23.5967,269.4570,35,1); //81 Elegy Mulholland Int Parking
AddStaticVehicle(402,2767.8623,-1876.3982,9.6116,0.9914,30,30); //82 Bufallo LS Stadium
AddStaticVehicle(402,2102.3748,-1275.4111,25.3430,179.9360,110,110); //83 Bufallo Jefferson
AddStaticVehicle(541,481.8200,-1488.6698,19.6303,188.5278,58,58); //84 Bullet Rodeo
AddStaticVehicle(541,1011.8397,-1083.3861,23.4538,181.7085,51,51); //85 Bullet Temple
AddStaticVehicle(541,1011.8390,-1083.3862,23.4537,181.7100,51,51); //86 Bullet Temple
AddStaticVehicle(541,1651.6531,-1283.7155,14.4219,259.6173,91,91); //87 Bullet Downtown
AddStaticVehicle(535,2230.5579,-1351.4149,23.7544,90.1239,28,1); //88 Slamvan Jefferson
AddStaticVehicle(535,2691.8064,-1671.3386,9.2180,179.4417,55,1); //89 Slamvan LS Stadium

//House cars (can be owned (donation), else Wanted!)
AddStaticVehicle(507,1331.0000,-1083.0000,25.0000,090.0000,83,13); //90 HOUSECAR Elegant Market
AddStaticVehicle(411,1355.0000,-631.0000,108.5000,19.0000,0,0); //91 HOUSECAR M1k3
AddStaticVehicle(507,883.5899,-1669.7642,13.2013,0.1094,58,8); //92 HOUSECAR Elegant Verona Beach
AddStaticVehicle(507,1841.2375,-1871.4882,12.9610,359.6618,75,1); //93 HOUSECAR Elegant 69c Unity Station
AddStaticVehicle(507,1040.7429,-1056.3682,31.4650,359.7854,0,1); //94 HOUSECAR Elegant Temple
AddStaticVehicle(507,1532.1411,-813.4031,71.8263,89.2884,92,1); //95 HOUSECAR Elegant Vinewood
AddStaticVehicle(507,873.4642,-874.2399,77.2284,23.3582,116,1); //96 HOUSECAR Elegant Mulholland
AddStaticVehicle(507,337.2869,-1297.3354,53.9396,30.7090,40,1); //97 HOUSECAR Elegant Richman
AddStaticVehicle(507,782.0834,-1630.2767,12.9894,270.4619,123,1); //98 HOUSECAR Elegant Marina Burgershot
AddStaticVehicle(507,782.3747,-1601.8629,13.0952,271.2736,17,17); //99 HOUSECAR Elegant Marina Burgershot
AddStaticVehicle(507,1515.1705,-696.7622,94.3737,92.5942,0,0); //100 HOUSECAR Elegant Vinewood Mansion
AddStaticVehicle(507,2684.6982,-2018.3270,13.2619,0.0129,12,1); //101 HOUSECAR Elegant Willowfield
AddStaticVehicle(507,2272.9714,-1912.4291,13.2682,1.0263,26,96); //102 HOUSECAR Elegant Willowfield
AddStaticVehicle(507,269.3963,-1208.2756,74.8986,213.9394,0,0); //103 HOUSECAR Elegant Richman
AddStaticVehicle(507,288.0384,-1157.4543,80.7877,223.2188,0,0); //104 HOUSECAR Elegant Richman
AddStaticVehicle(507,2503.1392,-1026.6836,69.7630,175.0602,13,13); //105 HOUSECAR Elegant Las Colinas
AddStaticVehicle(507,1910.6825,-1115.3619,25.3438,180.1674,14,14); //106 HOUSECAR Elegant Glen Park
AddStaticVehicle(507,421.0437,-1261.2423,51.3376,19.8347,44,44); //107 HOUSECAR Elegant Richman
AddStaticVehicle(507,2319.4243,-1716.5701,13.2866,179.5366,123,1); //108 HOUSECAR Elegant Ganton
AddStaticVehicle(507,2854.5603,-1355.6855,10.9441,270.9729,77,1); //109 HOUSECAR Elegant East Beach
AddStaticVehicle(507,302.4806,-1485.4698,24.2764,235.1439,123,123); //110 HOUSECAR Elegant Rodeo Hotel Parking
AddStaticVehicle(507,1464.0165,-903.4731,54.5387,359.4811,36,36); //111 HOUSECAR Elegant Vinewood
AddStaticVehicle(507,324.4464,-1809.3879,4.2779,359.1914,102,102); //112 HOUSECAR Elegant Santa Maria Beach
AddStaticVehicle(507,2570.4861,-1032.6447,69.3530,178.2698,36,1); //113 HOUSECAR Elegant Las Colinas
AddStaticVehicle(507,2117.0000,-1783.4987,13.1025,0.3286,86,39); //114 HOUSECAR Elegant Idlewood Burgershot
AddStaticVehicle(507,2175.8586,-993.9230,62.5294,171.2821,6,25); //115 HOUSECAR Elegant Las Colinas
AddStaticVehicle(507,2118.5078,-1783.5020,13.0719,0.1573,9,39); //116 HOUSECAR Elegant Idlewood Burgershot
AddStaticVehicle(507,2819.2585,-1183.0200,25.1537,269.2969,40,1); //117 HOUSECAR Elegant East Beach
AddStaticVehicle(507,1109.6348,-732.4200,100.2505,89.0178,0,0); //118 HOUSECAR Elegant Mulholland
AddStaticVehicle(507,2426.7190,-1222.8995,25.0148,179.3221,83,83); //119 HOUSECAR Elegant The Pig Pen
AddStaticVehicle(507,1659.3398,-1693.8322,19.9913,182.4599,0,0); //120 HOUSECAR Elegant Commerce
AddStaticVehicle(507,690.5564,-1568.2490,13.8152,176.0536,3,8); //121 HOUSECAR Elegant Marina
AddStaticVehicle(507,2684.7500,-1990.1505,13.4433,178.4799,114,1); //122 HOUSECAR Elegant Willowfield
AddStaticVehicle(507,1793.5288,-2129.6299,13.4171,357.9758,3,3); //123 HOUSECAR Elegant El Corona
AddStaticVehicle(507,2052.0059,-1694.7820,13.4219,267.9055,102,114); //124 HOUSECAR Elegant Jefferson (BigSmoke's House)
AddStaticVehicle(507,833.1441,-858.7462,69.4699,202.3428,74,74); //125 HOUSECAR Elegant Mulholland
AddStaticVehicle(507,1991.1943,-1118.1989,26.3229,271.2145,87,118); //126 HOUSECAR Elegant Glen Park
AddStaticVehicle(507,2392.9241,-1675.8765,13.7110,1.8078,92,3); //127 HOUSECAR Elegant Ganton
AddStaticVehicle(507,2508.3882,-1666.5386,13.1306,11.7720,113,92); //128 HOUSECAR Elegant CJ's house
AddStaticVehicle(507,2497.9282,-2023.7712,13.2846,359.8243,119,113); //129 HOUSECAR Elegant Willowfield
AddStaticVehicle(507,1747.5554,-2097.6665,13.2889,180.7704,122,113); //130 HOUSECAR Elegant El Corona
AddStaticVehicle(507,2025.7773,-1649.0044,13.2983,89.7531,31,93); //131 HOUSECAR Elegant Idlewood
AddStaticVehicle(407,1182.0000,-1792.0000,13.0000,2.0000,3,1);//132 PUBLIC Firetruck
AddStaticVehicle(407,1173.0000,-1792.0000,13.0000,2.0000,3,1);//133 PUBLIC Firetruck
AddStaticVehicle(593,2000.2488,-2625.9211,14.2494,0.0132,89,91);//134 PUBLIC Dodo
AddStaticVehicle(511,1870.3844,-2400.8931,13.6939,38.3979,54,29); //135 PUBLIC Beagle
AddStaticVehicle(563,1088.0000,-1793.0000,14.0000,306.0000,3,1);//136 PUBLIC LSFD Raindance
AddStaticVehicle(497,1553.0000,-1610.0000,13.0000,270.0000,0,1); //137 PUBLIC Police Helicopter
AddStaticVehicle(487,1177.5000,-1350.0000,19.0000,0.0000,1,3); //138 PUBLIC Maverick
AddStaticVehicle(592,2118.0000,-2450.0000,14.0000,180.0000,0,0); //139 PUBLIC Andromeda
AddStaticVehicle(487,1615.0000,1530.0000,11.0000,16.0000,1,0); //140 PUBLIC Maverick LVAP
AddStaticVehicle(431,1604.0000,1559.0000,11.0000,8.0000,1,0); //141 PUBLIC Bus LVAP
AddStaticVehicle(487,-1364.0000,-240.0000,14.0000,333.0000,1,86); //142 PUBLIC Maverick SFAP
AddStaticVehicle(431,-1372.0000,-199.0000,14.0000,310.0000,1,86); //143 PUBLIC Bus SFAP

pPilot = -1;
Taxidrvr = -1;
Taxicust = -1;
	return 1;
}

//Callback edited by M1k3
public OnPlayerConnect(playerid)
{
new tmp[255],player[24];
GetPlayerName(playerid,player,sizeof(player));

if(dini_Exists(udb_encode(player))){
tmp = dini_Get(udb_encode(player),"Banned");
	if (strval(tmp) == 1){
	SendClientMessage(playerid,COLOR_RED,"(Kick) Your account is blocked, you are banned from this server");
	GameTextForPlayer(playerid,"~r~You are banned from this server!!!",30000,5);
	pInfo[playerid][Banned] = 1;
	return 1;
	}
}
	else
	SetPlayerColor(playerid, COLOR_DARKGREEN);
	GameTextForPlayer(playerid,"~w~Welcome to~g~ Pure RPG",3000,1);
	SendClientMessage(playerid,COLOR_LIGHTGREEN,"Script by Smokie/Weeds - Edited by M1k3");
	SendClientMessage(playerid,COLOR_YELLOW,"Please /register your nickname.");
    SendClientMessage(playerid,COLOR_YELLOW,"If you've registered, please /login.");
	SendClientMessage(playerid,COLOR_RED,"Failure to /login before spawn results in auto-kick!");
	SendClientMessage(playerid,COLOR_RED,"====================================================");
	SendClientMessage(playerid,COLOR_ORANGE,"Type /help for more information.");
	SendClientMessage(playerid,COLOR_ORANGE,"Type /commands to see the server commands.");
	SendClientMessage(playerid,COLOR_ORANGE,"Type /rules to read the server rules.");
		SendClientMessage(playerid,COLOR_RED,"More info on -------> www.pure-rpg.de.tc <-------");
	pInfo[playerid][Spawned] = 0;
	pInfo[playerid][Logged] = 0;
	pInfo[playerid][GetSkin] = 0;
	pInfo[playerid][Admin] = 0;
	pInfo[playerid][WatchPilot] = 0;
	pInfo[playerid][Cuffed] = 0;
	pInfo[playerid][Wanted] = 0;
	pInfo[playerid][AddWanted] = 0;
	pInfo[playerid][WantedLevel] = 0;
	pInfo[playerid][Jailable] = 0;
	pInfo[playerid][isPassenger] = 0;
	pInfo[playerid][Boarded] = 0;
	pInfo[playerid][Jailed] = 0; //<<< Return this Value to 0 after debug!
	pInfo[playerid][c] = 0;
    if(hack > 5)
    {
    	hack = 0;
        Ban(playerid);
    }
    return 1;
}

//Callback edited by M1k3
public OnPlayerDisconnect(playerid)
{
	new player[24];
	GetPlayerName(playerid,player,24);
	if(pInfo[playerid][c] < 3) hack++;
	if(pInfo[playerid][Logged]) {
		dini_IntSet(udb_encode(player),"Pocket",GetPlayerMoney(playerid));
	}
	pInfo[playerid][Spawned] = 0;
	pInfo[playerid][Logged] = 0;
	pInfo[playerid][Banned] = 0;
	pInfo[playerid][GetSkin] = 0;
	pInfo[playerid][Admin] = 0;
	pInfo[playerid][Cuffed] = 0;
	pInfo[playerid][Wanted] = 0;
	pInfo[playerid][AddWanted] = 0;
	pInfo[playerid][WantedLevel] = 0;
	pInfo[playerid][WatchPilot] = 0;
	pInfo[playerid][Jailable] = 0;
	pInfo[playerid][Jailed] = 0;
	pInfo[playerid][isPassenger] = 0;
	pInfo[playerid][Boarded] = 0;

if (playerid == Taxidrvr){
Taxidrvr = -1;
SendClientMessageToAll(BBLUE, "The taxi driver position just became vacant. Type /taxidriver to be the next one");
}

if (playerid == pPilot){
pPilot = -1;
SendClientMessageToAll(BBLUE, "The taxi driver position just became vacant. Type /taxidriver to be the next one");
}
	return 1;
}

//Callback added by M1k3
public OnPlayerRequestClass(playerid, classid)
{
	SetupPlayerForClassSelection(playerid);
	
gTeam[playerid] = GetPlayerTeam(playerid);
switch (gTeam[playerid]) {
	case TEAM_CIVS: GameTextForPlayer(playerid,"~g~ROLE: ~w~Civilist ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
	case TEAM_SENIORS: GameTextForPlayer(playerid,"~g~ROLE: ~w~Senior ~n~~r~OBJECTIVE: ~w~ Live peacefully",1000,5);
	case TEAM_WAITERS: GameTextForPlayer(playerid,"~g~ROLE: ~w~Waiter ~n~~r~OBJECTIVE: ~w~ Serve drinks and food",1000,5);
	case TEAM_CRIMINALS: GameTextForPlayer(playerid,"~g~ROLE: ~w~Criminal ~n~~r~OBJECTIVE: ~w~ Be criminal",1000,5);
	case TEAM_SECURITIES: GameTextForPlayer(playerid,"~g~ROLE: ~w~Security ~n~~r~OBJECTIVE: ~w~ Save lives",1000,5);
	case TEAM_PILOTS: GameTextForPlayer(playerid,"~g~ROLE: ~w~Pilot ~n~~r~OBJECTIVE: ~w~ Fly safely",1000,5);
	case TEAM_ENTERTAINERS: GameTextForPlayer(playerid,"~g~ROLE: ~w~Entertainer ~n~~r~OBJECTIVE: ~w~ Make people happy ;)",1000,5);
	case TEAM_MEDICS: GameTextForPlayer(playerid,"~g~ROLE: ~w~Medic ~n~~r~OBJECTIVE: ~w~ Heal people",1000,5);
	case TEAM_FIREMEN: GameTextForPlayer(playerid,"~g~ROLE: ~w~Firemen ~n~~r~OBJECTIVE: ~w~ Keep fires under control",1000,5);
	case TEAM_COPS: GameTextForPlayer(playerid,"~g~ROLE: ~w~Police ~n~~r~OBJECTIVE: ~w~ Prevent crime",1000,5);
	}

switch (classid){
case 0: pInfo[playerid][Skin] = 7;
case 1: pInfo[playerid][Skin] = 12;
case 2: pInfo[playerid][Skin] = 16;
case 3: pInfo[playerid][Skin] = 17;
case 4: pInfo[playerid][Skin] = 18;
case 5: pInfo[playerid][Skin] = 19;
case 6: pInfo[playerid][Skin] = 20;
case 7: pInfo[playerid][Skin] = 21;
case 8: pInfo[playerid][Skin] = 23;
case 9: pInfo[playerid][Skin] = 26;
case 10: pInfo[playerid][Skin] = 27;
case 11: pInfo[playerid][Skin] = 34;
case 12: pInfo[playerid][Skin] = 35;
case 13: pInfo[playerid][Skin] = 36;
case 14: pInfo[playerid][Skin] = 37;
case 15: pInfo[playerid][Skin] = 40;
case 16: pInfo[playerid][Skin] = 45;
case 17: pInfo[playerid][Skin] = 50;
case 18: pInfo[playerid][Skin] = 51;
case 19: pInfo[playerid][Skin] = 52;
case 20: pInfo[playerid][Skin] = 55;
case 21: pInfo[playerid][Skin] = 56;
case 22: pInfo[playerid][Skin] = 59;
case 23: pInfo[playerid][Skin] = 60;
case 24: pInfo[playerid][Skin] = 67;
case 25: pInfo[playerid][Skin] = 69;
case 26: pInfo[playerid][Skin] = 72;
case 27: pInfo[playerid][Skin] = 73;
case 28: pInfo[playerid][Skin] = 80;
case 29: pInfo[playerid][Skin] = 81;
case 30: pInfo[playerid][Skin] = 91;
case 31: pInfo[playerid][Skin] = 96;
case 32: pInfo[playerid][Skin] = 97;
case 33: pInfo[playerid][Skin] = 99;
case 34: pInfo[playerid][Skin] = 101;
case 35: pInfo[playerid][Skin] = 138;
case 36: pInfo[playerid][Skin] = 139;
case 37: pInfo[playerid][Skin] = 140;
case 38: pInfo[playerid][Skin] = 141;
case 39: pInfo[playerid][Skin] = 142;
case 40: pInfo[playerid][Skin] = 147;
case 41: pInfo[playerid][Skin] = 148;
case 42: pInfo[playerid][Skin] = 151;
case 43: pInfo[playerid][Skin] = 153;
case 44: pInfo[playerid][Skin] = 154;
case 45: pInfo[playerid][Skin] = 157;
case 46: pInfo[playerid][Skin] = 169;
case 47: pInfo[playerid][Skin] = 170;
case 48: pInfo[playerid][Skin] = 176;
case 49: pInfo[playerid][Skin] = 177;
case 50: pInfo[playerid][Skin] = 180;
case 51: pInfo[playerid][Skin] = 185;
case 52: pInfo[playerid][Skin] = 186;
case 53: pInfo[playerid][Skin] = 187;
case 54: pInfo[playerid][Skin] = 188;
case 55: pInfo[playerid][Skin] = 190;
case 56: pInfo[playerid][Skin] = 191;
case 57: pInfo[playerid][Skin] = 192;
case 58: pInfo[playerid][Skin] = 198;
case 59: pInfo[playerid][Skin] = 199;
case 60: pInfo[playerid][Skin] = 201;
case 61: pInfo[playerid][Skin] = 202;
case 62: pInfo[playerid][Skin] = 203;
case 63: pInfo[playerid][Skin] = 204;
case 64: pInfo[playerid][Skin] = 206;
case 65: pInfo[playerid][Skin] = 211;
case 66: pInfo[playerid][Skin] = 214;
case 67: pInfo[playerid][Skin] = 215;
case 68: pInfo[playerid][Skin] = 216;
case 69: pInfo[playerid][Skin] = 219;
case 70: pInfo[playerid][Skin] = 221;
case 71: pInfo[playerid][Skin] = 222;
case 72: pInfo[playerid][Skin] = 223;
case 73: pInfo[playerid][Skin] = 226;
case 74: pInfo[playerid][Skin] = 227;
case 75: pInfo[playerid][Skin] = 233;
case 76: pInfo[playerid][Skin] = 240;
case 77: pInfo[playerid][Skin] = 241;
case 78: pInfo[playerid][Skin] = 242;
case 79: pInfo[playerid][Skin] = 250;
case 80: pInfo[playerid][Skin] = 251;
case 81: pInfo[playerid][Skin] = 252;
case 82: pInfo[playerid][Skin] = 258;
case 83: pInfo[playerid][Skin] = 259;
case 84: pInfo[playerid][Skin] = 260;
case 85: pInfo[playerid][Skin] = 261;
case 86: pInfo[playerid][Skin] = 262;
case 87: pInfo[playerid][Skin] = 263;
case 88: pInfo[playerid][Skin] = 290;
case 89: pInfo[playerid][Skin] = 291;
case 90: pInfo[playerid][Skin] = 296;
case 91: pInfo[playerid][Skin] = 297;
case 92: pInfo[playerid][Skin] = 9;
case 93: pInfo[playerid][Skin] = 10;
case 94: pInfo[playerid][Skin] = 14;
case 95: pInfo[playerid][Skin] = 15;
case 96: pInfo[playerid][Skin] = 31;
case 97: pInfo[playerid][Skin] = 32;
case 98: pInfo[playerid][Skin] = 33;
case 99: pInfo[playerid][Skin] = 38;
case 100: pInfo[playerid][Skin] = 39;
case 101: pInfo[playerid][Skin] = 43;
case 102: pInfo[playerid][Skin] = 44;
case 103: pInfo[playerid][Skin] = 49;
case 104: pInfo[playerid][Skin] = 53;
case 105: pInfo[playerid][Skin] = 54;
case 106: pInfo[playerid][Skin] = 57;
case 107: pInfo[playerid][Skin] = 58;
case 108: pInfo[playerid][Skin] = 62;
case 109: pInfo[playerid][Skin] = 68;
case 110: pInfo[playerid][Skin] = 75;
case 111: pInfo[playerid][Skin] = 76;
case 112: pInfo[playerid][Skin] = 77;
case 113: pInfo[playerid][Skin] = 78;
case 114: pInfo[playerid][Skin] = 79;
case 115: pInfo[playerid][Skin] = 88;
case 116: pInfo[playerid][Skin] = 89;
case 117: pInfo[playerid][Skin] = 93;
case 118: pInfo[playerid][Skin] = 94;
case 119: pInfo[playerid][Skin] = 95;
case 120: pInfo[playerid][Skin] = 128;
case 121: pInfo[playerid][Skin] = 129;
case 122: pInfo[playerid][Skin] = 130;
case 123: pInfo[playerid][Skin] = 132;
case 124: pInfo[playerid][Skin] = 133;
case 125: pInfo[playerid][Skin] = 134;
case 126: pInfo[playerid][Skin] = 135;
case 127: pInfo[playerid][Skin] = 136;
case 128: pInfo[playerid][Skin] = 137;
case 129: pInfo[playerid][Skin] = 150;
case 130: pInfo[playerid][Skin] = 156;
case 131: pInfo[playerid][Skin] = 158;
case 132: pInfo[playerid][Skin] = 159;
case 133: pInfo[playerid][Skin] = 160;
case 134: pInfo[playerid][Skin] = 161;
case 135: pInfo[playerid][Skin] = 162;
case 136: pInfo[playerid][Skin] = 182;
case 137: pInfo[playerid][Skin] = 183;
case 138: pInfo[playerid][Skin] = 196;
case 139: pInfo[playerid][Skin] = 197;
case 140: pInfo[playerid][Skin] = 200;
case 141: pInfo[playerid][Skin] = 210;
case 142: pInfo[playerid][Skin] = 212;
case 143: pInfo[playerid][Skin] = 213;
case 144: pInfo[playerid][Skin] = 218;
case 145: pInfo[playerid][Skin] = 220;
case 146: pInfo[playerid][Skin] = 224;
case 147: pInfo[playerid][Skin] = 225;
case 148: pInfo[playerid][Skin] = 228;
case 149: pInfo[playerid][Skin] = 229;
case 150: pInfo[playerid][Skin] = 230;
case 151: pInfo[playerid][Skin] = 231;
case 152: pInfo[playerid][Skin] = 232;
case 153: pInfo[playerid][Skin] = 234;
case 154: pInfo[playerid][Skin] = 235;
case 155: pInfo[playerid][Skin] = 236;
case 156: pInfo[playerid][Skin] = 239;
case 157: pInfo[playerid][Skin] = 11;
case 158: pInfo[playerid][Skin] = 155;
case 159: pInfo[playerid][Skin] = 167;
case 160: pInfo[playerid][Skin] = 168;
case 161: pInfo[playerid][Skin] = 171;
case 162: pInfo[playerid][Skin] = 172;
case 163: pInfo[playerid][Skin] = 179;
case 164: pInfo[playerid][Skin] = 189;
case 165: pInfo[playerid][Skin] = 194;
case 166: pInfo[playerid][Skin] = 205;
case 167: pInfo[playerid][Skin] = 209;
case 168: pInfo[playerid][Skin] = 253;
case 169: pInfo[playerid][Skin] = 13;
case 170: pInfo[playerid][Skin] = 22;
case 171: pInfo[playerid][Skin] = 28;
case 172: pInfo[playerid][Skin] = 29;
case 173: pInfo[playerid][Skin] = 30;
case 174: pInfo[playerid][Skin] = 41;
case 175: pInfo[playerid][Skin] = 46;
case 176: pInfo[playerid][Skin] = 47;
case 177: pInfo[playerid][Skin] = 48;
case 178: pInfo[playerid][Skin] = 98;
case 179: pInfo[playerid][Skin] = 100;
case 180: pInfo[playerid][Skin] = 102;
case 181: pInfo[playerid][Skin] = 103;
case 182: pInfo[playerid][Skin] = 104;
case 183: pInfo[playerid][Skin] = 105;
case 184: pInfo[playerid][Skin] = 106;
case 185: pInfo[playerid][Skin] = 107;
case 186: pInfo[playerid][Skin] = 108;
case 187: pInfo[playerid][Skin] = 109;
case 188: pInfo[playerid][Skin] = 110;
case 189: pInfo[playerid][Skin] = 111;
case 190: pInfo[playerid][Skin] = 112;
case 191: pInfo[playerid][Skin] = 113;
case 192: pInfo[playerid][Skin] = 114;
case 193: pInfo[playerid][Skin] = 115;
case 194: pInfo[playerid][Skin] = 116;
case 195: pInfo[playerid][Skin] = 117;
case 196: pInfo[playerid][Skin] = 118;
case 197: pInfo[playerid][Skin] = 120;
case 198: pInfo[playerid][Skin] = 121;
case 199: pInfo[playerid][Skin] = 122;
case 200: pInfo[playerid][Skin] = 123;
case 201: pInfo[playerid][Skin] = 126;
case 202: pInfo[playerid][Skin] = 127;
case 203: pInfo[playerid][Skin] = 143;
case 204: pInfo[playerid][Skin] = 144;
case 205: pInfo[playerid][Skin] = 145;
case 206: pInfo[playerid][Skin] = 146;
case 207: pInfo[playerid][Skin] = 173;
case 208: pInfo[playerid][Skin] = 174;
case 209: pInfo[playerid][Skin] = 175;
case 210: pInfo[playerid][Skin] = 181;
case 211: pInfo[playerid][Skin] = 184;
case 212: pInfo[playerid][Skin] = 195;
case 213: pInfo[playerid][Skin] = 247;
case 214: pInfo[playerid][Skin] = 248;
case 215: pInfo[playerid][Skin] = 249;
case 216: pInfo[playerid][Skin] = 254;
case 217: pInfo[playerid][Skin] = 292;
case 218: pInfo[playerid][Skin] = 293;
case 219: pInfo[playerid][Skin] = 294;
case 220: pInfo[playerid][Skin] = 298;
case 221: pInfo[playerid][Skin] = 0;
case 222: pInfo[playerid][Skin] = 24;
case 223: pInfo[playerid][Skin] = 25;
case 224: pInfo[playerid][Skin] = 66;
case 225: pInfo[playerid][Skin] = 124;
case 226: pInfo[playerid][Skin] = 125;
case 227: pInfo[playerid][Skin] = 163;
case 228: pInfo[playerid][Skin] = 164;
case 229: pInfo[playerid][Skin] = 217;
case 230: pInfo[playerid][Skin] = 61;
case 231: pInfo[playerid][Skin] = 255;
case 232: pInfo[playerid][Skin] = 63;
case 233: pInfo[playerid][Skin] = 64;
case 234: pInfo[playerid][Skin] = 82;
case 235: pInfo[playerid][Skin] = 83;
case 236: pInfo[playerid][Skin] = 84;
case 237: pInfo[playerid][Skin] = 85;
case 238: pInfo[playerid][Skin] = 87;
case 239: pInfo[playerid][Skin] = 90;
case 240: pInfo[playerid][Skin] = 92;
case 241: pInfo[playerid][Skin] = 131;
case 242: pInfo[playerid][Skin] = 152;
case 243: pInfo[playerid][Skin] = 178;
case 244: pInfo[playerid][Skin] = 207;
case 245: pInfo[playerid][Skin] = 237;
case 246: pInfo[playerid][Skin] = 238;
case 247: pInfo[playerid][Skin] = 243;
case 248: pInfo[playerid][Skin] = 244;
case 249: pInfo[playerid][Skin] = 245;
case 250: pInfo[playerid][Skin] = 256;
case 251: pInfo[playerid][Skin] = 257;
case 252: pInfo[playerid][Skin] = 264;
case 253: pInfo[playerid][Skin] = 70;
case 254: pInfo[playerid][Skin] = 71;
case 255: pInfo[playerid][Skin] = 193;
case 256: pInfo[playerid][Skin] = 274;
case 257: pInfo[playerid][Skin] = 275;
case 258: pInfo[playerid][Skin] = 276;
case 259: pInfo[playerid][Skin] = 277;
case 260: pInfo[playerid][Skin] = 278;
case 261: pInfo[playerid][Skin] = 279;
case 262: pInfo[playerid][Skin] = 165;
case 263: pInfo[playerid][Skin] = 166;
case 264: pInfo[playerid][Skin] = 246;
case 265: pInfo[playerid][Skin] = 280;
case 266: pInfo[playerid][Skin] = 281;
case 267: pInfo[playerid][Skin] = 282;
case 268: pInfo[playerid][Skin] = 283;
case 269: pInfo[playerid][Skin] = 284;
case 270: pInfo[playerid][Skin] = 285;
case 271: pInfo[playerid][Skin] = 286;
case 272: pInfo[playerid][Skin] = 287;
case 273: pInfo[playerid][Skin] = 288;
case 274: pInfo[playerid][Skin] = 295;
}
return 1;
}

//Callback edited by M1k3
public OnPlayerSpawn(playerid)
{
new spawner[24],spawnmsg[120];
GetPlayerName(playerid,spawner,24);

if (pInfo[playerid][Logged]){
	PlayerPlaySound(playerid, 1063, 1685.5280,-2240.3850,13.5469);
	SetPlayerToSpawn(playerid);
	SetPlayerToTeamColor(playerid);
	pInfo[playerid][Spawned] = 1;
	GameTextForPlayer(playerid,"~g~www.pure-rpg.de.tc",3999,1);
	format(spawnmsg,sizeof(spawnmsg),"%s (ID %d) spawned",spawner,playerid);
	print (spawnmsg);
	}
	else{
	if (!pInfo[playerid][Logged] && dini_Exists(udb_encode(spawner))){
		PlayerPlaySound(playerid, 1063, 1685.5280,-2240.3850,13.5469);
		format(spawnmsg,sizeof(spawnmsg),"%s (ID %d) spawned without logging in! - Auto-Kick!",spawner,playerid);
		print (spawnmsg);
		SendClientMessage(playerid,COLOR_RED,"(Kicked) You tried to spawn as a REGISTRED NAME without logging in.");
		GameTextForPlayer(playerid,"~w~Always ~r~/login~w~ before you spawn~r~!!!",30000,5);
    	pInfo[playerid][AutoKick] = 1;
		}
	}

    if(!dini_Exists(udb_encode(spawner)) && !pInfo[playerid][Logged]){
    PlayerPlaySound(playerid, 1063, 1685.5280,-2240.3850,13.5469);
	SetPlayerToSpawn(playerid);
	SetPlayerToTeamColor(playerid);
	pInfo[playerid][Spawned] = 1;
	GameTextForPlayer(playerid,"Remember to ~r~/register!!",3333,5);
	SetTimer("AutoReminder",19998,0);
	}

if (pInfo[playerid][Jailed] || pInfo[playerid][Cuffed]){
	SetPlayerInterior(playerid,3);
	SetPlayerPos(playerid,198.5,162.5,1003.0);
	SetPlayerFacingAngle(playerid,180.0);
	SetCameraBehindPlayer(playerid);
	PlayerPlaySound(playerid,1069,198.5,162.5,1003.0);
	PlayerPlaySound(playerid,1068,198.5,162.5,1003.0);
	SendClientMessage(playerid,COLOR_RED,"/kill is disabled while jailed/badge loss or cuffed!");
	return 1;
}
return 1;
}

//Function added by M1k3
public SetPlayerToSpawn(playerid)
{
if (pInfo[playerid][GetSkin]==1){
new skinID,tmp1[255],tmp2[255],player[24];
new Weap1,Weap2,Weap3,Ammo1,Ammo2,Ammo3;
GetPlayerName(playerid,player,24);
tmp1=dini_Get(udb_encode(player),"Skin");
skinID=strval(tmp1);
new tmp3[255];
format(tmp3,sizeof(tmp3),"Skin ID: %d",skinID);

switch (skinID){
//Team 1
	case 7,12,16,17,18,19,20,21,23,26,27,34,35,36,37,40,45,50,51,52,55,56,59,60,67,69,72:{
	gTeam[playerid] = 1;
	SetPlayerColor(playerid,COLOR_WHITE);
	Weap1 = 14;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Team: Civilian]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
	case 73,80,81,91,96,97,99,101,138,139,140,141,142,147,148,151,153,154,157,169,170,176:{
	gTeam[playerid] = 1;
	SetPlayerColor(playerid,COLOR_WHITE);
	Weap1 = 14;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Team: Civilian]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
	case 177,180,185,186,187,188,190,191,192,198,199,201,202,203,204,206,211,214,215:{
	gTeam[playerid] = 1;
	SetPlayerColor(playerid,COLOR_WHITE);
	Weap1 = 14;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Team: Civilian]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
	case 216,219,221,222,223,226,227,233,240,241,242,250,251,252,258,259,260,261,262:{
	gTeam[playerid] = 1;
	SetPlayerColor(playerid,COLOR_WHITE);
	Weap1 = 14;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Team: Civilian]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
	case 263,290,291,296,297:{
	gTeam[playerid] = 1;
	SetPlayerColor(playerid,COLOR_WHITE);
	Weap1 = 14;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Team: Civilian]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
//Team 2
	case 1,9,10,14,15,31,32,33,38,39,43,44,49,53,54,57,58,62,68,75,76,77,78,79,88,89,93:{
	gTeam[playerid] = 2;
	SetPlayerColor(playerid,COLOR_WHITE);
	Weap1 = 15;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Senior]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
	case 94,95,128,129,130,132,133,134,135,136,137,150,156,158,159,160,161,162,182,183:{
	gTeam[playerid] = 2;
	SetPlayerColor(playerid,COLOR_WHITE);
	Weap1 = 15;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Senior]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
	case 196,197,200,210,212,213,218,220,224,225,228,229,230,231,232,234,235,236,239:{
	gTeam[playerid] = 2;
	SetPlayerColor(playerid,COLOR_WHITE);
	Weap1 = 15;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Senior]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
//Team 3
	case 11,155,167,168,171,172,179,189,194,205,209,253:{
	gTeam[playerid] = 3;
	SetPlayerColor(playerid,COLOR_LIGHTBLUE);
	Weap1 = 7;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Waiter]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
//Team 4
	case 13,22,28,29,30,41,46,47,48,98,100,102,103,104,105,106,107,108,109,110,111,112:{
	gTeam[playerid] = 4;
	SetPlayerColor(playerid,COLOR_ORANGE);
	Weap1 = 5;
	Ammo1 = 1;
	Weap2 = 22;
	Ammo2 = 30;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Criminal]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
	case 113,114,115,116,117,118,119,120,121,122,123,126,127,143,144,145,146,173:{
	gTeam[playerid] = 4;
	SetPlayerColor(playerid,COLOR_ORANGE);
	Weap1 = 5;
	Ammo1 = 1;
	Weap2 = 22;
	Ammo2 = 30;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Criminal]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
	case 0,174,175,181,184,195,247,248,249,254,292,293,294,298,299:{
	gTeam[playerid] = 4;
	SetPlayerColor(playerid,COLOR_ORANGE);
	Weap1 = 5;
	Ammo1 = 1;
	Weap2 = 22;
	Ammo2 = 30;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Criminal]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
//Team 5
	case 24,25,66,124,125,163,164,217:{
	gTeam[playerid] = 5;
	SetPlayerColor(playerid,COLOR_LIGHTBLUE);
	Weap1 = 3;
	Ammo1 = 1;
	Weap2 = 23;
	Ammo2 = 30;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Security]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
//Team 6
	case 61,255:{
	gTeam[playerid] = 6;
	SetPlayerColor(playerid,COLOR_YELLOW);
	Weap1 = 46;
	Ammo1 = 1;
	Weap2 = 39;
	Ammo2 = 5;
	Weap3 = 40;
	Ammo3 = 5;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Pilot]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
//Team 7
	case 63,64,82,83,84,85,87,90,92,131,152,178,207,237,238,243,244,245,256,257,264:{
	gTeam[playerid] = 7;
	SetPlayerColor(playerid,COLOR_BRIGHTRED);
	Weap1 = 12;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Entertainer]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
//Team 8
	case 70,71,193,274,275,276:{
	gTeam[playerid] = 8;
	SetPlayerColor(playerid,COLOR_PINK);
	Weap1 = 2;
	Ammo1 = 1;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Medic]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
//Team 9
	case 277,278,279:{
	gTeam[playerid] = 9;
	SetPlayerColor(playerid,COLOR_RED);
	Weap1 = 42;
	Ammo1 = 100000;
	Weap2 = 0;
	Ammo2 = 0;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Fireman]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
//Team 10
	case 165,166,246,280,281,282,283,284,285,286,287,288,295:{
	gTeam[playerid] = 10;
	SetPlayerColor(playerid,BBLUE);
	Weap1 = 24;
	Ammo1 = 30;
	Weap2 = 3;
	Ammo2 = 1;
	Weap3 = 0;
	Ammo3 = 0;
	format(tmp3,sizeof(tmp3),"[Saved Skin: %d, - Role: Cop]",skinID);
	SendClientMessage(playerid,COLOR_GREEN,tmp3);
	}
}

new spawnID;
tmp2 = dini_Get(udb_encode(player),"SpawnX");
spawnID = strval(tmp2);

new Float:SpawnX=floatstr(dini_Get(udb_encode(player),"SpawnX"));
new Float:SpawnY=floatstr(dini_Get(udb_encode(player),"SpawnY"));
new Float:SpawnZ=floatstr(dini_Get(udb_encode(player),"SpawnZ"));
new Float:SpawnA=floatstr(dini_Get(udb_encode(player),"SpawnA"));


if (spawnID==0){
	switch (gTeam[playerid]){
		case 1,2,3,4,5,7:{
		SpawnX = 1685.5280;
		SpawnY = -2240.3850;
		SpawnZ = 13.5469;
		SpawnA = 179.7263;
		}
		case 6:{
		SpawnX = 1900.1691;
		SpawnY = -2629.6445;
		SpawnZ = 14.4509;
		SpawnA = 359.9915;
		}
		case 8:{
		SpawnX = 1173.0000;
		SpawnY = -1323.0000;
		SpawnZ = 15.0000;
		SpawnA = 266.0000;
		}
		case 9:{
		SpawnX = 1154.0000;
		SpawnY = -1772.0000;
		SpawnZ = 17.5000;
		SpawnA = 359.7263;
		}
		case 10:{
		SpawnX = 1584.4734;
		SpawnY = -1710.7793;
		SpawnZ = 5.6116;
		SpawnA = 358.8000;
		}
	}
SetSpawnInfo(playerid,gTeam[playerid],skinID,SpawnX,SpawnY,SpawnZ,SpawnA,Weap1,Ammo1,Weap2,Ammo2,Weap3,Ammo3);
return 1;
}
if (spawnID!=0){
	SetSpawnInfo(playerid,gTeam[playerid],skinID,SpawnX,SpawnY,SpawnZ,SpawnA,Weap1,Ammo1,Weap2,Ammo2,Weap3,Ammo3);
 	return 1;
	}
}
else
return 1;
}

//Callback edited by M1k3
public OnPlayerDeath(playerid, killerid, reason)
{
if (pInfo[playerid][Jailed] || pInfo[playerid][Cuffed]){
	return 0;
	}
new health2;
new Float:health;
GetPlayerHealth(killerid,health);
health2 = floatround(health,floatround_floor);
if (health2 >=30){
	SendDeathMessage(killerid, playerid,reason);
	pInfo[killerid][AddWanted] = 1;
	SendClientMessage(killerid,COLOR_RED,"You DMed a player. Because you were not in a life endangering situation you are now wanted for murder.");
    SendClientMessage(killerid,COLOR_YELLOW,"Kill only when you are being attacked and low on health.");
	if (gTeam[killerid] == TEAM_COPS){
        pInfo[killerid][Jailed] = 1;
        SetPlayerColor(killerid,COLOR_GREY);
        SendClientMessage(killerid,BBLUE,"You lost your police badge for killing another player.");
        SendClientMessage(killerid,COLOR_YELLOW,"Use /cuff then /check on players instead of killing (kill only when you are low on health!)");
		}
	return 1;
	}

if (pInfo[playerid][isPassenger]){
pInfo[playerid][isPassenger] = 0;
return 0;
}
	
if (playerid == pPilot && pFlight[Flying]){
SendClientMessage(playerid,COLOR_RED,"You lost the charter pilot job because you died on a flight");
pPilot = -1;
SendClientMessageToAll(BBLUE,"The charter pilot died during a flight. The position is vacant and the passengers survived.");

	for (new su=0;su<MAX_PLAYERS;su++){
	    if (pInfo[su][isPassenger]){
		KillTimer(pInfo[su][PWTimer]);
		pInfo[su][WatchPilot] = 0;
		GivePlayerMoney(su,10000);
		SendClientMessage(su,COLOR_RED,"The pilot died. The plane crashed. Your family got 10000$ by the airline for their pain.");
		SetPlayerToSpawn (su);
	    }
	}
return 1;
}

if (playerid == Taxidrvr){
	SendClientMessage(playerid,COLOR_RED,"You lost the taxidriver job because you died on a transfer");
	Taxidrvr = -1;
	Taxicust = -1;
	SendClientMessageToAll(BBLUE,"The taxidriver died. The position is vacant now.");
	return 1;
	}

SendDeathMessage(killerid, playerid,reason);
return 1;
}

//Callback by Weeds
public OnPlayerPrivmsg(senderid,playerid,text[])
{
	new player[24],player2[24],str1[255],str2[255];
	GetPlayerName(playerid,player,24);
	GetPlayerName(senderid,player2,24);

	format(str1,sizeof(str1),"PM from %s(ID %d) %s",player2,senderid,text);
	format(str2,sizeof(str2),"PM sent to %s(ID %d): %s",player,playerid,text);
	for(new i=0; i<MAX_PLAYERS; i++) {
	    new p[24];
		GetPlayerName(i,p,24);
	    if(strval(Level(p)) > 1) {
	        format(str1,sizeof(str1),"PM from %s(ID %d) to %s(ID %d): %s",player2,senderid,player,playerid,text[0]);
	        SendClientMessage(i,COLOR_PINK,str1);
	    }
	}
	SendClientMessage(playerid,COLOR_YELLOW,str1);
	SendClientMessage(senderid,COLOR_YELLOW,str2);
	return 0;
}

//Callback added by M1k3
public OnPlayerText(playerid, text[])
{
new player[24];
	GetPlayerName(playerid,player,24);
	
if (pInfo[playerid][Jailed]){
	SendClientMessage(playerid,COLOR_RED,"You are not allowed to chat in public while jailed!");
 	return 0;
	}
	for (new fil=1;fil<=6;fil++){//fil <= [NUMBER OF ELEMENTS to filter]
	new strresult;
	
	switch (fil){
	case 1: strresult = strfind(text,"Hacks",true,0);
	case 2: strresult = strfind(text,"Hacker",true,0);
	case 3: strresult = strfind(text,"Hacking",true,0);
	case 4: strresult = strfind(text,"Cheats",true,0);
	case 5: strresult = strfind(text,"Cheater",true,0);
	case 6: strresult = strfind(text,"Cheating",true,0); //If you filter more words, add more cases!
	}
	
		if (strresult!=-1){
		SendClientMessage(playerid,COLOR_RED,"Do not accuse people of cheating/hacking in public and without proof!");
		SendClientMessage(playerid,COLOR_YELLOW,"Use /admins, /PM [ID] [TEXT] or /A to contact an admin in private.");
  		print ("(Word filter active - Message not transfered to public)");
		return 0;
		}
	}
return 1;
}

//Callback edited by M1k3
public OnPlayerCommandText(playerid,cmdtext[])
{
	dcmd(help,4,cmdtext);
	dcmd(rules,5,cmdtext);
	dcmd(commands,8,cmdtext);
	dcmd(flightcommands,14,cmdtext);
	dcmd(me,2,cmdtext);
	dcmd(L,1,cmdtext); //Public Chat edited to local chat by M1k3
	dcmd(A,1,cmdtext); //Admin Report added by M1k3
	dcmd(R,1,cmdtext); //Radio added by M1k3
	dcmd(ATC,3,cmdtext);//ATC Pilot chat added by M1k3
	dcmd(register,8,cmdtext);
	dcmd(login,5,cmdtext);
//Following functions added by M1k3
	dcmd(job,3,cmdtext);
	dcmd(rob,3,cmdtext);
	dcmd(pay,3,cmdtext);
	dcmd(fine,4,cmdtext);
	dcmd(deposit,7,cmdtext);
	dcmd(balance,7,cmdtext);
	dcmd(cuff,4,cmdtext);
	dcmd(heal,4,cmdtext);
	dcmd(check,5,cmdtext);
	dcmd(jail,4,cmdtext);
	dcmd(bail,4,cmdtext);
	dcmd(wanted,6,cmdtext);
	dcmd(cophelp,7,cmdtext);
	dcmd(ah,2,cmdtext);
	dcmd(sell,4,cmdtext);
	dcmd(find,4,cmdtext);
	dcmd(saveskin,8,cmdtext);
	dcmd(getskin,7,cmdtext);
	dcmd(visit,5,cmdtext);
	dcmd(back,4,cmdtext);
	dcmd(taxidriver,10,cmdtext);
	dcmd(taxi,4,cmdtext);
	dcmd(accept,6,cmdtext);
	dcmd(reject,6,cmdtext);
	dcmd(911,3,cmdtext);
	dcmd(changename,10,cmdtext);
	dcmd(changepass,10,cmdtext);
	dcmd(charter,7,cmdtext);
	dcmd(bookflight,10,cmdtext);
	dcmd(board,5,cmdtext);
	dcmd(watchpilot,10,cmdtext);
	dcmd(takeoff,7,cmdtext);
	dcmd(onblocks,8,cmdtext);
	dcmd(GL,2,cmdtext);
	dcmd(RL,2,cmdtext);
	dcmd(unboard,7,cmdtext);
//Following ADMIN functions added by M1k3
	dcmd(stats,5,cmdtext);
	dcmd(block,5,cmdtext);
	dcmd(unblock,7,cmdtext);
	dcmd(setpocket,9,cmdtext);
	dcmd(setbank,7,cmdtext);
	dcmd(savespawn,9,cmdtext);
	dcmd(setcar,6,cmdtext);


	return 1;
}

//Function p (public chat) edited by M1k3 to L (local chat)
dcmd_L(playerid,params[])
{
	new player[24],string[120];
	GetPlayerName(playerid,player,24);
	if(!strlen(params))
	{
	    SendClientMessage(playerid,COLOR_GREY,"Usage: /L [text]");
		return 1;
	}
	if (pInfo[playerid][Jailed]){
	SetPlayerInterior(playerid,3);
	SetPlayerPos(playerid,198.5,162.5,1003.0);
	PlayerPlaySound(playerid,1069,198.5,162.5,1003.0);
	PlayerPlaySound(playerid,1068,198.5,162.5,1003.0);
	SendClientMessage(playerid,COLOR_RED,"You are not allowed to chat local while jailed!");
	return 1;
	}
    format(string,sizeof(string),"(Local) %s: %s",player,params[0]);
	for(new l=0; l<MAX_PLAYERS; l++){
		if(IsPlayerConnected(l)){
			if(GetDistanceBetweenPlayers(playerid,l) <= 30 && l!=playerid){
 		    SendClientMessage(l,COLOR_DARKGREEN,string);
		    SendClientMessage(playerid,COLOR_DARKGREEN,string);
	    	}
   		}
	}
	return 1;
	}

//Function by M1k3
dcmd_A(playerid,params[])
{
	new string[120],tmp1[255],adn[24];
	if(!strlen(params))
	{
	    SendClientMessage(playerid,COLOR_GREY,"Usage: /A [text]");
		return 1;
	}
	format(string,sizeof(string),"(Report) %s",params[0]);
	print (string);

	for(new ad=0; ad<MAX_PLAYERS; ad++){
	GetPlayerName(ad,adn,sizeof(adn));
	tmp1 = dini_Get(udb_encode(adn),"Level");
		if(strval(tmp1)==5){
 	    SendClientMessage(ad,COLOR_DARKGREEN,string);
		}
	}
	SendClientMessage(playerid,BBLUE,"Your report has been logged and sent to all online admins anonymously.");
	return 1;
	}
	
//Function by M1k3
dcmd_R(playerid,params[])
{
	new string[120],ran[24];
	if(!strlen(params)){
	    SendClientMessage(playerid,COLOR_GREY,"Usage: /R[adio chat] [text]");
		return 1;
	}
	GetPlayerName(playerid,ran,sizeof(ran));
	
	switch (gTeam[playerid]){
		case TEAM_CIVS: {
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_SENIORS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_WAITERS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_CRIMINALS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_SECURITIES:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_PILOTS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_ENTERTAINERS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the cop, medic or fireman role to use the combined radio channel.");
		return 0;
		}
		case TEAM_MEDICS:{
		format(string,sizeof(string),"(Radio) Medic %s: %s,over",ran,params[0]);
			for(new ra=0; ra<MAX_PLAYERS; ra++){
				if(gTeam[ra]==TEAM_MEDICS || gTeam[ra]==TEAM_FIREMEN || gTeam[ra]==TEAM_COPS){
				SendClientMessage(ra,COLOR_WHITE,string);
				}
				if (pInfo[ra][Admin]){
				SendClientMessage(ra,COLOR_PINK,string);
				}
			}
		return 1;
		}
		case TEAM_FIREMEN:{
		format(string,sizeof(string),"(Radio) Fireguard %s: %s,over",ran,params[0]);
			for(new ra=0; ra<MAX_PLAYERS; ra++){
				if(gTeam[ra]==TEAM_MEDICS || gTeam[ra]==TEAM_FIREMEN || gTeam[ra]==TEAM_COPS){
				SendClientMessage(ra,COLOR_WHITE,string);
				}
				if (pInfo[ra][Admin]){
				SendClientMessage(ra,COLOR_PINK,string);
				}
			}
		return 1;
		}
		case TEAM_COPS:{
		format(string,sizeof(string),"(Radio) Officer %s: %s,over",ran,params[0]);
			for(new ra=0; ra<MAX_PLAYERS; ra++){
				if(gTeam[ra]==TEAM_MEDICS || gTeam[ra]==TEAM_FIREMEN || gTeam[ra]==TEAM_COPS){
				SendClientMessage(ra,COLOR_WHITE,string);
				}
				if (pInfo[ra][Admin]){
				SendClientMessage(ra,COLOR_PINK,string);
				}
			}
		return 1;
		}
	}
	return 0;
	}

//Function by M1k3
dcmd_ATC(playerid,params[])
{
	new string[120],ran[24];
	if(!strlen(params)){
	    SendClientMessage(playerid,COLOR_GREY,"Usage: /ATC [text]");
		return 1;
	}
	GetPlayerName(playerid,ran,sizeof(ran));

	switch (gTeam[playerid]){
		case TEAM_CIVS: {
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the pilot role to use the Air Traffic Control radio frequecies.");
		return 0;
		}
		case TEAM_SENIORS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the pilot role to use the Air Traffic Control radio frequecies.");
		return 0;
		}
		case TEAM_WAITERS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the pilot role to use the Air Traffic Control radio frequecies.");
		return 0;
		}
		case TEAM_CRIMINALS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the pilot role to use the Air Traffic Control radio frequecies.");
		return 0;
		}
		case TEAM_SECURITIES:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the pilot role to use the Air Traffic Control radio frequecies.");
		return 0;
		}
		case TEAM_PILOTS:{
		format(string,sizeof(string),"(ATC Radio) Captain %s: %s,over",ran,params[0]);
			for(new ra=0; ra<MAX_PLAYERS; ra++){
				if(gTeam[ra]==TEAM_PILOTS){
				SendClientMessage(ra,COLOR_WHITE,string);
				}
				if (pInfo[ra][Admin]){
				SendClientMessage(ra,COLOR_PINK,string);
				}
			}
		return 1;
		}
		case TEAM_ENTERTAINERS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "It's broken!");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the pilot role to use the Air Traffic Control radio frequecies.");
		return 0;
		}
		case TEAM_MEDICS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "You cant reach the ATC frequency because of a frequency limit.");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the pilot role to use the Air Traffic Control radio frequecies.");
		return 0;
		}
		case TEAM_FIREMEN:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "You cant reach the ATC frequency because of a frequency limit.");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the pilot role to use the Air Traffic Control radio frequecies.");
		return 0;
		}
		case TEAM_COPS:{
		SendClientMessage(playerid,BBLUE, "You get out your mobile radio to speak into it.");
		SendClientMessage(playerid,BBLUE, "You cant reach the ATC frequency because of a frequency limit.");
		SendClientMessage(playerid,COLOR_YELLOW, "You need to play the pilot role to use the Air Traffic Control radio frequecies.");
		return 0;
		}
	}
return 0;
}

//Function by Weeds
dcmd_me(playerid,params[])
{
	new player[24],string[120];
	GetPlayerName(playerid,player,24);
	if(!strlen(params))
	{
	    SendClientMessage(playerid,COLOR_GREY,"Usage: /me [action]");
		return 1;
	}
    format(string,sizeof(string),"%s %s",player,params[0]);
	for(new i=0; i<MAX_PLAYERS; i++) if(IsPlayerConnected(i)) if(GetDistanceBetweenPlayers(playerid,i) <= 30 && i!=playerid)
	{
	    SendClientMessage(i,BBLUE,string);
	    SendClientMessage(playerid,BBLUE,string);
	    return 1;
	}
	return 1;
}

//Function edited by M1k3
dcmd_register(playerid,params[])
{
	new player[24],str[86];
	GetPlayerName(playerid,player,24);
	if(!strlen(params))
	{
	    SendClientMessage(playerid,COLOR_GREY,"Usage: /register [password]");
		return 1;
	}
	if(dini_Exists(udb_encode(player)))
	{
	    SendClientMessage(playerid,COLOR_BRIGHTRED,"This nickname has been already registered.");
		return 1;
	}
	dini_Create(udb_encode(player));
	dini_Set(udb_encode(player),"Password",params);
	dini_IntSet(udb_encode(player),"Pocket",GetPlayerMoney(playerid));
	if(IsPlayerAdmin(playerid)){
		dini_IntSet(udb_encode(player),"Bank",500);
		dini_IntSet(udb_encode(player),"Level",5);
		dini_IntSet(udb_encode(player),"Banned",0);
		dini_IntSet(udb_encode(player),"Vehicle",0);
		dini_IntSet(udb_encode(player),"Skin",1);
		dini_IntSet(udb_encode(player),"SpawnX",0);
		dini_IntSet(udb_encode(player),"SpawnY",0);
		dini_IntSet(udb_encode(player),"SpawnZ",0);
		dini_IntSet(udb_encode(player),"SpawnA",0);
  	}
	else {
		dini_IntSet(udb_encode(player),"Bank",500);
		dini_IntSet(udb_encode(player),"Level",1);
		dini_IntSet(udb_encode(player),"Banned",0);
		dini_IntSet(udb_encode(player),"Vehicle",0);
 		dini_IntSet(udb_encode(player),"Skin",1);
		dini_IntSet(udb_encode(player),"SpawnX",0);
		dini_IntSet(udb_encode(player),"SpawnY",0);
		dini_IntSet(udb_encode(player),"SpawnZ",0);
		dini_IntSet(udb_encode(player),"SpawnA",0);
  	}
	pInfo[playerid][Logged] = 1;
	GivePlayerMoney(playerid,-GetPlayerMoney(playerid));
	GivePlayerMoney(playerid,5000);
	format(str,sizeof(str),"Statistics [Pocket: $%d Password: %s]",GetPlayerMoney(playerid),params);
	SendClientMessage(playerid,COLOR_GREEN,"Successfully Registered. You are now logged in.");
	SendClientMessage(playerid,COLOR_GREEN,"The server grants you 5000$ as a start. Use it wisely!");
	SendClientMessage(playerid,COLOR_GREEN,str);
	pInfo[playerid][Logged] = 1;
	SpawnPlayer(playerid);
	pInfo[playerid][Spawned] = 1;
	return 1;
}

//Function edited by M1k3 (Password control did NOT work!!!!!!111oneone
dcmd_login(playerid,params[])
{
	new player[24],str[86],tmp1[255],tmp2[255];

	GetPlayerName(playerid,player,24);
	if(!strlen(params))
	{
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /login [password]");
		return 1;
	}
	if(!dini_Exists(udb_encode(player)))
	{
	    SendClientMessage(playerid,COLOR_BRIGHTRED,"Nickname doesn't exist, you can register using /register [password].");
		return 1;
	}
	if(pInfo[playerid][Logged])
	{
	    SendClientMessage(playerid,COLOR_BRIGHTRED,"You are already logged in.");
		return 1;
	}
	tmp1 = dini_Get(udb_encode(player),"Password");
//	print (params); //This was just for debug reasons since Weed's password control
// 	print (tmp);//did not even properly work -_-
	if(strcmp(params,tmp1,true,strlen(tmp1)))
	{
	    SendClientMessage(playerid,COLOR_BRIGHTRED,"Invalid Password.");
		new pwmsg[120];
		format(pwmsg,sizeof(pwmsg),"ID %d entered a wrong password",playerid);
	    print (pwmsg);
		return 1;
	}
	tmp1 = dini_Get(udb_encode(player),"Pocket");
	tmp2 = dini_Get(udb_encode(player),"Vehicle");
 	GivePlayerMoney(playerid,-GetPlayerMoney(playerid));
	GivePlayerMoney(playerid,strval(tmp1));
    pInfo[playerid][vehicle] = strval(tmp2);

switch (strval(tmp2)){
case 0: format(tmp2,sizeof(tmp2),"None");
//Public Cars
case 1: format(tmp2,sizeof(tmp2),"Ambulance (Location: All Saints General Hospital)");
case 2: format(tmp2,sizeof(tmp2),"Ambulance (Location: All Saints General Hospital)");
case 3: format(tmp2,sizeof(tmp2),"Police Car (Location: in front of LSPD)");
case 4: format(tmp2,sizeof(tmp2),"Police Car (Location: LSPD Garage)");
case 5: format(tmp2,sizeof(tmp2),"Police Car (Location: LSPD Garage)");
case 6: format(tmp2,sizeof(tmp2),"Police Car (Location: LSPD Garage)");
case 7: format(tmp2,sizeof(tmp2),"Taxi (Location: LSAP Terminal)");
case 8: format(tmp2,sizeof(tmp2),"Taxi (Location: LSAP Terminal)");
case 9: format(tmp2,sizeof(tmp2),"Taxi (Location: LSAP Terminal)");
case 10: format(tmp2,sizeof(tmp2),"Taxi (Location: LSAP Terminal)");
case 11: format(tmp2,sizeof(tmp2),"Maverick (Location: LSAP Apron)");
case 12: format(tmp2,sizeof(tmp2),"Maverick (Location: LSAP Apron)");
case 13: format(tmp2,sizeof(tmp2),"Maverick (Location: LSAP Apron)");
case 14: format(tmp2,sizeof(tmp2),"Shamal Jet (Location: LSAP Hangar)");
case 15: format(tmp2,sizeof(tmp2),"Rustler Warbird (Location: LSAP Apron)");
case 16: format(tmp2,sizeof(tmp2),"Rustler Warbird (Location: LSAP Apron)");
case 17: format(tmp2,sizeof(tmp2),"HPV-1000 (Location: LSPD Garage)");
case 18: format(tmp2,sizeof(tmp2),"HPV-1000 (Location: LSPD Garage)");
//Stealable Cars
case 19: format(tmp2,sizeof(tmp2),"Bicycle (Location: East Beach)");
case 20: format(tmp2,sizeof(tmp2),"Bicycle (Location: Ganton)");
case 21: format(tmp2,sizeof(tmp2),"Bicycle (Location: Willowfield)");
case 22: format(tmp2,sizeof(tmp2),"Bicycle (Location: Jefferson)");
case 23: format(tmp2,sizeof(tmp2),"Clover (Location: Los Flores)");
case 24: format(tmp2,sizeof(tmp2),"Remington (Location: Unity Station)");
case 25: format(tmp2,sizeof(tmp2),"Remington (Location: Willowfield)");
case 26: format(tmp2,sizeof(tmp2),"Remington (Location: East Beach Parking Lot)");
case 27: format(tmp2,sizeof(tmp2),"FCR-900 (Location: Conference Center Parking)");
case 28: format(tmp2,sizeof(tmp2),"FCR-900 (Location: Market)");
case 29: format(tmp2,sizeof(tmp2),"NRG-500 (Location: East Beach Parking Lot)");
case 30: format(tmp2,sizeof(tmp2),"Savanna (Location: Jefferson)");
case 31: format(tmp2,sizeof(tmp2),"Primo (Location: LSAP Parking)");
case 32: format(tmp2,sizeof(tmp2),"Sentinel (Location: LSAP Parking)");
case 33: format(tmp2,sizeof(tmp2),"Remington (Location: LSAP Parking)");
case 34: format(tmp2,sizeof(tmp2),"Tornado (Location: LSAP Parking)");
case 35: format(tmp2,sizeof(tmp2),"Washington (Location: LSAP Parking)");
case 36: format(tmp2,sizeof(tmp2),"Stratum (Location: LSAP Parking)");
case 37: format(tmp2,sizeof(tmp2),"Sadler (Location: LSAP Parking)");
case 38: format(tmp2,sizeof(tmp2),"Admiral (Location: LSAP Parking)");
case 39: format(tmp2,sizeof(tmp2),"Savanna (Location: LSAP Parking)");
case 40: format(tmp2,sizeof(tmp2),"Bufallo (Location: LSAP Parking)");
case 41: format(tmp2,sizeof(tmp2),"Slamvan (Location: LSAP Parking)");
case 42: format(tmp2,sizeof(tmp2),"Jester (Location: LSAP Parking)");
case 43: format(tmp2,sizeof(tmp2),"Elegy (Location: LSAP Parking)");
case 44: format(tmp2,sizeof(tmp2),"ZR-350 (Location: LSAP Parking)");
case 45: format(tmp2,sizeof(tmp2),"Euros (Location: LSAP Parking)");
case 46: format(tmp2,sizeof(tmp2),"Uranus (Location: LSAP Parking)");
case 47: format(tmp2,sizeof(tmp2),"Sultan (Location: LSAP Parking)");
case 48: format(tmp2,sizeof(tmp2),"Blade (Location: LSAP Parking)");
case 49: format(tmp2,sizeof(tmp2),"Admiral (Location: LSAP Parking)");
case 50: format(tmp2,sizeof(tmp2),"NRG-500 (Location: Santa Maria Beach)");
case 51: format(tmp2,sizeof(tmp2),"Tornado (Location: Ganton)");
case 52: format(tmp2,sizeof(tmp2),"Tornado (Location: LS Stadium)");
case 53: format(tmp2,sizeof(tmp2),"NRG-500 (Location: Rodeo)");
case 54: format(tmp2,sizeof(tmp2),"Sentinel (Location: Commerce)");
case 55: format(tmp2,sizeof(tmp2),"NRG-500 (Location: Vinewood Studios)");
case 56: format(tmp2,sizeof(tmp2),"Sentinel (Location: Marina)");
case 57: format(tmp2,sizeof(tmp2),"Nebula (Location: Ocean Docks)");
case 58: format(tmp2,sizeof(tmp2),"Sultan (Location: Ganton)");
case 59: format(tmp2,sizeof(tmp2),"NRG-500 (Location: Mulholland Intersection Parking)");
case 60: format(tmp2,sizeof(tmp2),"Sultan (Location: Conference Center)");
case 61: format(tmp2,sizeof(tmp2),"NRG-500 (Location: Idlewood)");
case 62: format(tmp2,sizeof(tmp2),"Sultan (Location: Market)");
case 63: format(tmp2,sizeof(tmp2),"Cheetah (Location: Commerce)");
case 64: format(tmp2,sizeof(tmp2),"Cheetah (Location: Conference Center Parking)");
case 65: format(tmp2,sizeof(tmp2),"Cheetah (Location: East Los Santos)");
case 66: format(tmp2,sizeof(tmp2),"Stratum (Location: Mulholland)");
case 67: format(tmp2,sizeof(tmp2),"Tourismo (Location: Marina)");
case 68: format(tmp2,sizeof(tmp2),"Tourismo (Location: Market)");
case 69: format(tmp2,sizeof(tmp2),"Slamvan (Location: El Corona)");
case 70: format(tmp2,sizeof(tmp2),"Tourismo (Location: Jefferson Motel)");
case 71: format(tmp2,sizeof(tmp2),"Admiral (Location: East Los Santos)");
case 72: format(tmp2,sizeof(tmp2),"Huntley (Location: Marina)");
case 73: format(tmp2,sizeof(tmp2),"Primo (Location: Temple)");
case 74: format(tmp2,sizeof(tmp2),"Banshee (Location: LSAP Lower Terminal)");
case 75: format(tmp2,sizeof(tmp2),"Banshee (Location: Rodeo)");
case 76: format(tmp2,sizeof(tmp2),"Blade (Location: East Beach Parking Lot)");
case 77: format(tmp2,sizeof(tmp2),"Uranus (Location: Little Mexico)");
case 78: format(tmp2,sizeof(tmp2),"Euros (Location: Commerce)");
case 79: format(tmp2,sizeof(tmp2),"ZR-350 (Location: Market)");
case 80: format(tmp2,sizeof(tmp2),"Infernus (Location: Mulholland Intersection Parking)");
case 81: format(tmp2,sizeof(tmp2),"Elegy (Location: Mulholland Intersection Parking)");
case 82: format(tmp2,sizeof(tmp2),"Bufallo (Location: LS Stadium)");
case 83: format(tmp2,sizeof(tmp2),"Bufallo (Location: Jefferson)");
case 84: format(tmp2,sizeof(tmp2),"Bullet (Location: Rodeo)");
case 85: format(tmp2,sizeof(tmp2),"Bullet (Location: Temple)");
case 86: format(tmp2,sizeof(tmp2),"Bullet (Location: Temple)");
case 87: format(tmp2,sizeof(tmp2),"Bullet (Location: Downtown)");
case 88: format(tmp2,sizeof(tmp2),"Slamvan (Location: Jefferson)");
case 89: format(tmp2,sizeof(tmp2),"Slamvan (Location: LS Stadium)");
// House Cars
case 90: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Market)");
case 91: format(tmp2,sizeof(tmp2),"Infernus (Location: M1k3's House in Richman)");
case 92: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Verona Beach)");
case 93: format(tmp2,sizeof(tmp2),"Elegant (Location: House in 69c Unity Station)");
case 94: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Temple)");
case 95: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Vinewood)");
case 96: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Mulholland)");
case 97: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Richman)");
case 98: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Marina Burgershot)");
case 99: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Marina Burgershot)");
case 100: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Vinewood Mansion)");
case 101: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Willowfield)");
case 102: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Willowfield)");
case 103: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Richman)");
case 104: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Richman)");
case 105: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Las Colinas)");
case 106: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Glen Park)");
case 107: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Richman)");
case 108: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Ganton)");
case 109: format(tmp2,sizeof(tmp2),"Elegant (Location: House in East Beach)");
case 110: format(tmp2,sizeof(tmp2),"Elegant (Location: (House) Rodeo Hotel Parking)");
case 111: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Vinewood)");
case 112: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Santa Maria Beach)");
case 113: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Las Colinas)");
case 114: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Idlewood Burgershot)");
case 115: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Las Colinas)");
case 116: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Idlewood Burgershot)");
case 117: format(tmp2,sizeof(tmp2),"Elegant (Location: House in East Beach)");
case 118: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Mulholland)");
case 119: format(tmp2,sizeof(tmp2),"Elegant (Location: House in The Pig Pen)");
case 120: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Commerce)");
case 121: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Marina)");
case 122: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Willowfield)");
case 123: format(tmp2,sizeof(tmp2),"Elegant (Location: House in El Corona)");
case 124: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Jefferson (BigSmoke's House))");
case 125: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Mulholland)");
case 126: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Glen Park)");
case 127: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Ganton)");
case 128: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Grove Street)");
case 129: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Willowfield)");
case 130: format(tmp2,sizeof(tmp2),"Elegant (Location: House in El Corona)");
case 131: format(tmp2,sizeof(tmp2),"Elegant (Location: House in Idlewood)");
case 132: format(tmp2,sizeof(tmp2),"Firetruck (Location: LSFD)");
case 133: format(tmp2,sizeof(tmp2),"Firetruck (Location: LSFD)");
case 134: format(tmp2,sizeof(tmp2),"Dodo (Location: LSAP Apron)");
case 135: format(tmp2,sizeof(tmp2),"Beagle (Location: LSAP Apron)");
case 136: format(tmp2,sizeof(tmp2),"Raindance (Location: LSFD)");
case 137: format(tmp2,sizeof(tmp2),"Police Maverick (Location: LSPD)");
case 138: format(tmp2,sizeof(tmp2),"Ambulance Maverick (Location: All Saints General Hospital)");
case 139: format(tmp2,sizeof(tmp2),"Andromeda (Location: LSAP Big Hangar)");
case 140: format(tmp2,sizeof(tmp2),"Maverick (Location: LVAP Gates)");
case 141: format(tmp2,sizeof(tmp2),"Bus (Location: LVAP Gates)");
case 142: format(tmp2,sizeof(tmp2),"Maverick (Location: SFAP Gates)");
case 143: format(tmp2,sizeof(tmp2),"Bus (Location: SFAP Gates)");
}

	format(str,sizeof(str),"Logged in: [Pocket: $%d - Vehicle: %s]",GetPlayerMoney(playerid),tmp2);
    pInfo[playerid][Logged] = 1;
	SendClientMessage(playerid,COLOR_GREEN,str);
	tmp1 = dini_Get(udb_encode(player),"Level");
	if (strval(tmp1)>=2){
	format(str,sizeof(str),"You logged in as gamemode admin (Level %d)",strval(tmp1));
	SendClientMessage(playerid,COLOR_GREEN,str);
	pInfo[playerid][Admin] = 1;
	}
pInfo[playerid][Logged] = 1;
SpawnPlayer(playerid);
return 1;
}

//Function edited by M1k3 (additional commands)
dcmd_commands(playerid,params[])
{
	#pragma unused params
    SendClientMessage(playerid,COLOR_YELLOW,"Pure RPG Commands");
    SendClientMessage(playerid,COLOR_ORANGE,"/register [password]| /login [password]| /me [action] |/rules | /wanted");
	SendClientMessage(playerid,COLOR_ORANGE,"/job | /pay [ID] [amount] | /rob | /sell | /find | /L[ocal chat] | /saveskin");
	SendClientMessage(playerid,COLOR_ORANGE,"/getskin | /admins | /heal [ID] | /taxidriver | /atc [text] | /changename [new name]");
	SendClientMessage(playerid,COLOR_ORANGE,"/visit | /back | /A[dmin report] | /911 [c/f/m OR cops/fire/meds] [Information]");
	SendClientMessage(playerid,COLOR_ORANGE,"/taxi [information for the driver] | /R[adio chat combined for cops,meds,firemen]");
	SendClientMessage(playerid,COLOR_ORANGE,"/changepass [old password] [new password] | /bail | /deposit | /balance");
	SendClientMessage(playerid,COLOR_RED,"Other: /flightcommands | /cophelp | /ah");
    SendClientMessage(playerid,COLOR_YELLOW,"Please do not abuse any commands.");
	return 1;
}

//Function edited by M1k3 (additional commands)
dcmd_flightcommands(playerid,params[])
{
	#pragma unused params
    SendClientMessage(playerid,COLOR_YELLOW,"Pure RPG Flight System Commands");
	SendClientMessage(playerid,COLOR_ORANGE,"/charter | /bookflight [destination] | /bookflight parachute [drop-off point] | /board");
	SendClientMessage(playerid,COLOR_ORANGE,"/GL | /RL | /onblocks | /unboard | /watchpilot");
    SendClientMessage(playerid,COLOR_YELLOW,"Please do not abuse any commands.");
	return 1;
}

//Function edited by M1k3
dcmd_help(playerid,params[])
{
	#pragma unused params
    SendClientMessage(playerid,COLOR_YELLOW,"Pure RPG Help");
    SendClientMessage(playerid,COLOR_ORANGE,"Welcome to Pure RPG - [No DM - gta-host.com]");
    SendClientMessage(playerid,COLOR_ORANGE,"Please read the /rules and check the /commands.");
    SendClientMessage(playerid,COLOR_ORANGE,"/job gives you a detailed explanation of what to do");
    return 1;
}

//Function edited by M1k3
dcmd_rules(playerid,params[])
{
	#pragma unused params
    SendClientMessage(playerid,COLOR_YELLOW,"Pure RPG Rules");
    SendClientMessage(playerid,COLOR_ORANGE,"1. Always Role Play.");
    SendClientMessage(playerid,COLOR_ORANGE,"2. Do not Deathmatch.");
    SendClientMessage(playerid,COLOR_ORANGE,"3. Obey all admins.");
    SendClientMessage(playerid,COLOR_ORANGE,"4. No flaming, No spamming. English in Mainchat!");
    SendClientMessage(playerid,COLOR_ORANGE,"5. Drive on the right side of the road.");
    SendClientMessage(playerid,COLOR_ORANGE,"6. Don't even THINK of jacking other player's cars - it won't work!");
    SendClientMessage(playerid,COLOR_ORANGE,"7. If you hack, instant ban!");
    return 1;
}

//************THE FOLLOWING COMMANDS ARE ADDED BY M1k3 AND ARE NOT PART OF WEED's
//************OPEN SOURCE "SAN ANDREAS ROLE PLAY" SCRIPT*************************
//************AS SUCH THE FOLLOWING COMMANDS ARE __NOT__ OPEN-SOURCE!!!**********

//Function added by M1k3
dcmd_job(playerid,params[])
{
#pragma unused params
gTeam[playerid] = GetPlayerTeam(playerid);
switch (gTeam[playerid]) {
	case TEAM_CIVS: {
	SendClientMessage(playerid, COLOR_ORANGE, "As a civilian you do not have a clear aim.");
	SendClientMessage(playerid, COLOR_ORANGE, "You are supposed to role play in peace.");
	SendClientMessage(playerid, COLOR_ORANGE, "But you can use your money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Use /pay near a player to pay another player.");
	}
	case TEAM_SENIORS: {
	SendClientMessage(playerid, COLOR_ORANGE, "As a senior you do not have a clear aim.");
	SendClientMessage(playerid, COLOR_ORANGE, "You are supposed to role play in peace.");
	SendClientMessage(playerid, COLOR_ORANGE, "But you can use your money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Use /pay near a player to pay another player.");
	}
	case TEAM_WAITERS: {
	SendClientMessage(playerid, COLOR_ORANGE, "As a waiter your objective is to earn money.");
	SendClientMessage(playerid, COLOR_ORANGE, "Serve food and drink to people (RPG).");
	SendClientMessage(playerid, COLOR_ORANGE, "You can then use your earned money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Let other players pay your service by telling them to use /pay near you");
	}
	case TEAM_CRIMINALS: {
	SendClientMessage(playerid, COLOR_ORANGE, "As a criminal you do not have a clear aim.");
	SendClientMessage(playerid, COLOR_ORANGE, "You are supposed to role play criminally.");
	SendClientMessage(playerid, COLOR_ORANGE, "You can use your money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Cops can arrest you. Cooperate to get a lower penalty.");
	}
	case TEAM_SECURITIES: {
	SendClientMessage(playerid, COLOR_ORANGE, "As a security you must supervise larger group events or protect private persons.");
	SendClientMessage(playerid, COLOR_ORANGE, "You are supposed to prevent people being hurt.");
	SendClientMessage(playerid, COLOR_ORANGE, "Let your clients pay you by telling them to use /pay near you.");
	SendClientMessage(playerid, COLOR_ORANGE, "You can then use your money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Use /pay near a player to pay another player.");
	}
	case TEAM_PILOTS: {
	SendClientMessage(playerid, COLOR_ORANGE, "As a pilot you are the only one being allowed to fly the Andromeda.");
	SendClientMessage(playerid, COLOR_ORANGE, "Use /charter to become the official charter pilot and wait for people to book");
	SendClientMessage(playerid, COLOR_ORANGE, "When all people who booked boarded enter /takeoff and fly.");
	SendClientMessage(playerid, COLOR_ORANGE, "For a parachute drop off enter /GL when the people should jump out. End the flight with /RL and /onblocks.");
	SendClientMessage(playerid, COLOR_ORANGE, "You can then use your money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Use /pay near a player to pay another player.");
	}
	case TEAM_ENTERTAINERS: {
	SendClientMessage(playerid, COLOR_ORANGE, "As an entertainer you do not have a clear aim.");
	SendClientMessage(playerid, COLOR_ORANGE, "You are supposed to make people happy. :D");
	SendClientMessage(playerid, COLOR_ORANGE, "Let them pay you for your services ( ;) ) by telling them to use /pay near you.");
	SendClientMessage(playerid, COLOR_ORANGE, "You can then use your money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Cops can arrest you. Cooperate to get a lower penalty.");
	}
	case TEAM_MEDICS: {
	SendClientMessage(playerid, COLOR_ORANGE, "As a medic you must /heal people when they call you.");
	SendClientMessage(playerid, COLOR_ORANGE, "Let them pay your service by telling them to use /pay near you.");
	SendClientMessage(playerid, COLOR_ORANGE, "You can then use your money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Use /pay near a player to pay another player.");
	}
	case TEAM_FIREMEN: {
	SendClientMessage(playerid, COLOR_ORANGE, "As a fireman you must prevent or extinguish fires");
	SendClientMessage(playerid, COLOR_ORANGE, "Admins will pay you every full hour (no admin online = no money)");
	SendClientMessage(playerid, COLOR_ORANGE, "You can then use your money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Use /pay near a player to pay another player.");
	}
	case TEAM_COPS: {
	SendClientMessage(playerid, COLOR_ORANGE, "As a cop you must /cuff criminals and /jail them in the department");
	SendClientMessage(playerid, COLOR_ORANGE, "Admins will pay you every full hour (no admin online = no money)");
	SendClientMessage(playerid, COLOR_ORANGE, "You can then use your money to buy things");
	SendClientMessage(playerid, COLOR_ORANGE, "e.g. weapons at ammunation or food/clothes in stores.");
	SendClientMessage(playerid, COLOR_ORANGE, "Use /pay near a player to pay another player.");
	}
	
}
    return 1;
}

//Function added by M1k3
dcmd_pay(playerid,params[])
{
#pragma unused params
	new donator[24],recID,recStr[5],reciever[24],string1[120], string2[120], paylogstr[120];
	
	if(!strlen(params)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /pay [ID] [amount of $]");
		return 1;
		}
if (strlen(params)>=8){
SendClientMessage(playerid,COLOR_RED,"You are not allowed to transfer more than 99.999$ at a time");
return 1;
}
else
	strmid(recStr,params,0,2,2);
	strmid(params,params,2,10,8);
	recID = strval(recStr);
	GetPlayerName(recID,reciever,24);
    GetPlayerName(playerid,donator,24);
	new amount=strval(params);
	new aviablemoney=GetPlayerMoney(playerid);
	
		if (amount <= 0 || amount >= 100000){
		SendClientMessage(playerid,COLOR_RED,"You can pay amounts between 1$ and 99999$ only.");
		return 0;
		}

		if (recID == playerid){
 	    SendClientMessage(playerid,COLOR_RED,"No point in paying yourself.");
 	    return 1;
 	    }

 		if(amount>aviablemoney){
 	    SendClientMessage(playerid,COLOR_RED,"You do not have that much money. :P");
		return 1;
 		} 
	
   		if (!IsPlayerConnected(recID)){
        SendClientMessage(playerid,COLOR_RED,"ID not found or player not connected anymore :(");
        return 0;
   	    }
   	
	  		if(IsPlayerConnected(recID) && GetDistanceBetweenPlayers(playerid,recID) <= 5){//Set the maximum distance between donator and reciever here as low as possible
			format(paylogstr, sizeof (paylogstr), "%s used /PAY to give %d$ to %s (ID %d)",donator,amount,reciever,recID);
			print(paylogstr);
			format(string2,sizeof(string2),"You give %d$ to %s",amount,reciever);
    		format(string1,sizeof(string1),"You recieved %d$ from %s",amount,donator);
            GivePlayerMoney(playerid,-amount);
			GivePlayerMoney(recID,amount);
	    	SendClientMessage(recID,COLOR_YELLOW,string1);
	    	SendClientMessage(playerid,COLOR_YELLOW,string2);
	    		if (Taxicust == playerid){
				Taxicust = -1;
				SendClientMessage(playerid,BBLUE,"Taxi transfer completed.");
				printf ("*****Taxi tranfer completed (Driver ID %d)*********",Taxidrvr);
	    		}
	    	return 1;
			}
SendClientMessage(playerid,COLOR_RED,"You are to far away from the other player to hand him money. :(");
return 0;
}

//Function added by M1k3
dcmd_fine(playerid,params[])
{
#pragma unused params
	new teamcops1,donator[24],recID,recStr[5],reciever[24],string1[120], string2[120], paylogstr[120];

	if(!strlen(params)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /fine [ID] [amount of $]");
		return 1;
		}

	strmid(recStr,params,0,2,2);
	strmid(params,params,2,10,8);
	recID = strval(recStr);
	GetPlayerName(recID,reciever,24);
    GetPlayerName(playerid,donator,24);
	teamcops1=GetPlayerTeam(playerid);
	new amount=strval(params);

if (teamcops1==TEAM_COPS){
		if (amount <= 0 || amount > 500){
		SendClientMessage(playerid,COLOR_RED,"You can fine amounts between 1$ and 500$ only.");
		return 0;
		}

		if (pInfo[playerid][WantedLevel] > 3){
		SendClientMessage(playerid,COLOR_RED,"The person you tried to fine is too criminal to be fined.");
		SendClientMessage(playerid,COLOR_YELLOW,"Use /cuff [ID] and /check [ID] to bring him/her to jail.");
		return 0;
		}

		if (recID == playerid){
 	    SendClientMessage(playerid,COLOR_RED,"No point in fining yourself.");
 	    return 1;
 	    }

   		if (!IsPlayerConnected(recID)){
        SendClientMessage(playerid,COLOR_RED,"ID not found or player not connected anymore :(");
        return 0;
   	    }

	  		if(IsPlayerConnected(recID) && GetDistanceBetweenPlayers(playerid,recID) <= 5){//Set the maximum distance between donator and reciever here as low as possible
			format(paylogstr, sizeof (paylogstr), "%s used /FINE to get %d$ from %s (ID %d)",donator,amount,reciever,recID);
			print(paylogstr);
			format(string2,sizeof(string2),"You give a %d$ fine to %s",amount,donator);
    		format(string1,sizeof(string1),"You recieved a %d$ fine from %s",amount,reciever);
            GivePlayerMoney(recID,-amount);
			GivePlayerMoney(playerid,amount);
	    	SendClientMessage(recID,COLOR_YELLOW,string2);
	    	SendClientMessage(playerid,COLOR_YELLOW,string1);
  	    	return 1;
			}
SendClientMessage(playerid,COLOR_RED,"You are to far away from the other player to hand him money. :(");
return 0;
}
SendClientMessage(playerid,BBLUE,"A bypassing afro-american civilian says:");
SendClientMessage(playerid,COLOR_WHITE,"Yo aint a cop, foooooool! :P");
return 0;
}

//Function added by M1k3
dcmd_deposit(playerid,params[])
{
#pragma unused params
	new string[120],donator[24],balance;
	
	GetPlayerName(playerid,donator,sizeof(donator));

	if(!strlen(params)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /deposit [amount of $]");
	    SendClientMessage(playerid,COLOR_GREY,"E.g. '/deposit 100' puts 100$ form your pocket in your bank account.");
   	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /deposit -[amount of $]");
   	    SendClientMessage(playerid,COLOR_GREY,"E.g. '/deposit -100' puts 100$ from your bank account in your pocket.");
		return 0;
		}

 	new amount=strval(params);
	new aviablemoney=GetPlayerMoney(playerid);

   	if(amount>aviablemoney){
    SendClientMessage(playerid,COLOR_RED,"You do not have that much money. :P");
	return 1;
 	}

format(string, sizeof (string), "%s used /DEPOSIT to bank %d$",donator,amount);
print(string);
GivePlayerMoney(playerid,-amount);
balance = strval(dini_Get(udb_encode(donator),"Bank")) + amount;
dini_IntSet(udb_encode(donator),"Bank",balance);
format(string, sizeof (string), "You transfered %d$ to your bank account. Your new balance is %d$.",amount,balance);
SendClientMessage(playerid,COLOR_YELLOW,string);
return 1;
}

//Function added by M1k3
dcmd_balance(playerid,params[])
{
#pragma unused params
new string[120],donator[24],balance;

GetPlayerName(playerid,donator,sizeof(donator));
balance = strval(dini_Get(udb_encode(donator),"Bank"));
format(string, sizeof (string), "Your bank account balance is %d$.",balance);
SendClientMessage(playerid,COLOR_YELLOW,string);
return 1;
}

//Function added by M1k3
dcmd_cuff(playerid,params[])
{
#pragma unused params
new teamcops1,teamarrested1,copname1[24],cuffstr[120],arrested1,arrestedname1[24];
teamcops1=GetPlayerTeam(playerid);
arrested1=strval(params);
teamarrested1=GetPlayerTeam(arrested1);
GetPlayerName(playerid,copname1,sizeof(copname1));
	if(!strlen(params)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /cuff [ID]");
		return 1;
	}
	
	if (teamcops1==TEAM_COPS){
	    if(IsPlayerConnected(arrested1) && GetDistanceBetweenPlayers(playerid,arrested1) <= 5){
  		GetPlayerName(arrested1,arrestedname1,sizeof(arrestedname1));
		format(cuffstr,sizeof(cuffstr),"Officer %s (ID %d) cuffed %s (ID %d)",copname1,playerid,arrestedname1,arrested1);
		print(cuffstr);
       	pInfo[arrested1][Cuffed] = 1;
       	    if (teamarrested1==TEAM_COPS){
       	    pInfo[arrested1][Jailed] = 0;
       	    pInfo[arrested1][Jailable] = 1;
       	    SendClientMessage(playerid,BBLUE,"You catched a cop who lost his badge.");
       	    SendClientMessage(playerid,COLOR_RED,"You can /jail him immediately.");
       	    }
       	TogglePlayerControllable(arrested1,false);
       	currentlyCuffed[arrested1] = SetTimer("TimerUncuff",86658,0); // 2 minutes and 10 seconds to uncuff your hands.
       	SendClientMessage(arrested1,COLOR_RED,"A cop cuffed your hands and feet.");
       	SendClientMessage(arrested1,COLOR_LIGHTGREEN,"You try to get your hands free and uncuff yourself...");
       	SendClientMessage(arrested1,COLOR_LIGHTGREEN,"That takes a while [Around 2 minutes]. Dont let the cop see you trying!");
       	SendClientMessage(playerid,COLOR_RED,"You cuffed a criminal. Guard him for 2 minutes and /check his status.");
       	SendClientMessage(playerid,COLOR_LIGHTGREEN,"This old handcuffs are not the best quality...");
       	SendClientMessage(playerid,COLOR_LIGHTGREEN,"Why has the police budget to be so low...!?");
		}
	else
    SendClientMessage(playerid,COLOR_RED,"The person you want to cuff is offline or too far away.");
	return 1;
	}
else
SendClientMessage(playerid,BBLUE,"A bypassing afro-american civilian says:");
SendClientMessage(playerid,COLOR_WHITE,"Yo aint a cop, foooooool! :P");
return 1;
}

//Function added by M1k3
dcmd_heal(playerid,params[])
{
#pragma unused params
//gTeam[playerid]==TEAM_MEDICS
new teammed,medname[24],healstr[120],healguy,healname[24];
new Float:health,health2,health3;

teammed=GetPlayerTeam(playerid);
healguy=strval(params);
GetPlayerName(playerid,medname,sizeof(medname));
	if(!strlen(params)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /heal [ID]");
		return 1;
	}

	if (teammed==TEAM_MEDICS){
	    if(IsPlayerConnected(healguy) && GetDistanceBetweenPlayers(playerid,healguy) <= 5){
  		GetPlayerName(healguy,healname,sizeof(healname));
		format(healstr,sizeof(healstr),"Medic %s (ID %d) used /HEAL on %s (ID %d)",medname,playerid,healname,healguy);
		print(healstr);
       	GetPlayerHealth(healguy,health);
       	health2 = floatround(health,floatround_floor);
       	if (health2>=90){
       		SendClientMessage(playerid,COLOR_RED,"This guy has only a few scratches. No need to /heal");
       		return 1;
       		}
       	health3 = health2 + 10;
       	SetPlayerHealth(healguy,health3);
		format(healstr,sizeof(healstr),"You gave %s + 10 health. His current health is %d%",healname,health3);
       	SendClientMessage(playerid,COLOR_LIGHTGREEN,healstr);
       	format(healstr,sizeof(healstr),"You feel refreshed. Your health went from %d% to %d%.",health2,health3);
       	SendClientMessage(healguy,BBLUE,healstr);
       	SendClientMessage(healguy,COLOR_RED,"Don't forget to /pay the medic!!!");
       	return 1;
        }
	else
    SendClientMessage(playerid,COLOR_RED,"The person you want to heal is offline or too far away.");
	return 1;
	}
else
SendClientMessage(playerid,BBLUE,"You find out you dont have medic's equipment.");
SendClientMessage(playerid,COLOR_YELLOW,"You need to be in the medic role to /heal people");
return 1;
}

//Function added by M1k3
dcmd_check(playerid,params[])
{
#pragma unused params
new teamcops2,copname2[24],checkstr[120],HQstr[120],arrested2,arrestedname2[24];
teamcops2=GetPlayerTeam(playerid);
arrested2=strval(params);
GetPlayerName(playerid,copname2,sizeof(copname2));
	if(!strlen(params)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /check [ID]");
		return 1;
	}

	if (teamcops2==TEAM_COPS){
	    if(IsPlayerConnected(arrested2) && pInfo[arrested2][Cuffed]){
		GetPlayerName(arrested2,arrestedname2,sizeof(arrestedname2));
		format(checkstr,sizeof(checkstr),"Officer %s (ID %d) checks the status of %s (ID %d)",copname2,playerid,arrestedname2,arrested2);
		print(checkstr);
        SendClientMessage(arrested2,COLOR_RED,"The cop gets out his mobile to check your status. Hurry!");
        SendClientMessage(arrested2,COLOR_LIGHTGREEN,"Once he found out you are wanted...");
        SendClientMessage(arrested2,COLOR_LIGHTGREEN,"...you will be going straight to jail...");
        SendClientMessage(playerid,BBLUE,"You get out your mobile radio to contact HQ");
		format(HQstr,sizeof(HQstr),"(Radio) You: This is Unit %d, I need a check on the wanted status of a certain %s",playerid,arrestedname2);
		SendClientMessage(playerid,COLOR_WHITE,HQstr);
        SendClientMessage(playerid,COLOR_WHITE,"(Radio) HQ: This is HQ. We are processing your check. Standby 2 minutes...");
		SetTimer("TimerCheck",79992,0); // 2 minutes for HQ to process a check.
		return 1;
		}
	else
    SendClientMessage(playerid,COLOR_RED,"The ID you want to check is not online or not cuffed.");
	return 1;
	}
else
SendClientMessage(playerid,BBLUE,"You get your mobile radio out to call HQ");
SendClientMessage(playerid,BBLUE,"You find out you dont have such a mobile radio. You are not a cop.");
return 1;
}

//Function added by M1k3
dcmd_jail(playerid,params[])
{
#pragma unused params
new teamcops3,copname3[24],jailstr[120],HQstr[120],arrested3,arrestedname3[24],Reward;
teamcops3=GetPlayerTeam(playerid);
arrested3=strval(params);
GetPlayerName(playerid,copname3,sizeof(copname3));
GetPlayerName(arrested3,arrestedname3,sizeof(arrestedname3));
Reward = pInfo[arrested3][WantedLevel] * 1000;

	if(!strlen(params)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /jail [ID]");
		return 1;
	}
if (teamcops3==TEAM_COPS){

	if (pInfo[arrested3][Jailed]){
	SendClientMessage(playerid,COLOR_RED,"This player is already jailed or a cop who lost his badge");
	return 1;
	}
		if(IsPlayerConnected(arrested3) && pInfo[arrested3][Jailable] && GetDistanceBetweenPlayers(playerid,arrested3) <= 5){
		format(jailstr,sizeof(jailstr),"Officer %s (ID %d) has jailed criminal %s (ID %d) (Reward %d$)",copname3,playerid,arrestedname3,arrested3,Reward);
		print(jailstr);
        SendClientMessage(arrested3,BBLUE,"The cop hits you to unconsciousness.");
		pInfo[arrested3][Cuffed] = 0;
		KillTimer(currentlyCuffed[arrested3]);
		pInfo[arrested3][Jailed] = 1;
		SetPlayerInterior(arrested3,3);
  		SetPlayerPos(arrested3,198.5,162.5,1003.0);
		SetPlayerFacingAngle(arrested3,180.0);
		SetCameraBehindPlayer(arrested3);
		PlayerPlaySound(arrested3,1068,198.5,162.5,1003.0);
		SetTimer("TimerJail",180000,0); //Jailtime 3 minutes, then: Release.
		TogglePlayerControllable(arrested3,true);
		SendClientMessage(arrested3,BBLUE,"As you wake up, you find yourself in the jail");
		SendClientMessageToAll(BBLUE,jailstr);

        if (arrested3 == playerid){
 	    SendClientMessage(playerid,COLOR_RED,"You do not get paid for jailing yourself.");
 	    return 1;
 	    }

		GivePlayerMoney(playerid,Reward);
		format(HQstr,sizeof(HQstr),"(Radio) You: This is Unit %d, I jailed the wanted criminal %s",playerid,arrestedname3);
		SendClientMessage(playerid,COLOR_WHITE,HQstr);
		format(jailstr,sizeof(jailstr),"(Radio) HQ: This is HQ. Good work. We transfered a %d$ bonus to your account.",Reward);
        SendClientMessage(playerid,COLOR_WHITE,jailstr);
		return 1;
		}
	else
    SendClientMessage(playerid,COLOR_RED,"The player you want to jail is not online,not wanted, or too far away.");
	SendClientMessage(arrested3,COLOR_LIGHTGREEN,"You are now free to go.");
	if (GetDistanceBetweenPlayers(playerid,arrested3) >5){
  	SendClientMessage(playerid,COLOR_RED,"The player you want to jail is too far away.");
	return 1;
 	}
  	else
	pInfo[arrested3][Cuffed] = 0;
	KillTimer(currentlyCuffed[arrested3]);
	SendClientMessage(arrested3,BBLUE,"The cop releases your handcuffs. Lucky he did not see your escape try.");
    SendClientMessage(arrested3,COLOR_WHITE,"Cop: Sorry sir, my mistake. Take this for the lost time.");
    SendClientMessage(arrested3,BBLUE,"The cop hands you 100$ to make you forget what happened");
    SendClientMessage(arrested3,BBLUE,"Your face becomes all red.You release the handcuffs.");
    SendClientMessage(arrested3,COLOR_WHITE,"You: Sorry sir, my mistake. Take this for the lost time.");
    SendClientMessage(arrested3,BBLUE,"You hand him 100$ and ask him not to tell anyone about the mistake you did.");
    GivePlayerMoney(playerid,-100);
    GivePlayerMoney(arrested3,100);
	TogglePlayerControllable(arrested3,true);
	return 1;
 	}

else
SendClientMessage(playerid,COLOR_RED,"San Andreas is a democratic state. No Anarchy.");
SendClientMessage(playerid,COLOR_RED,"That means that NO, You cannot jail any person you want... ;) Apply to become cop to jail.");
return 1;

}


//Function added by M1k3
dcmd_bail(playerid,params[])
{
#pragma unused params
new string[255],sub[6],amount,callername[24],strresult;


if (!strlen(params)){
	SendClientMessage(playerid,COLOR_GREY,"Usage: /bail yes");
	SendClientMessage(playerid,COLOR_GREY,"The bail height depends on the wanted level you had before.");
	amount = pInfo[playerid][WantedLevel] * 1000;
	format(string,sizeof(string),"Your bail is %d$. Enter '/bail yes' to pay it and be unjailed.",amount);
	SendClientMessage(playerid,COLOR_RED,string);
	return 1;
	}
GetPlayerName(playerid,callername,sizeof(callername));

if (pInfo[playerid][WantedLevel] == 0){
	SendClientMessage(playerid,COLOR_RED,"You did not commit any crimes - no need to go to jail and pay a bail.");
	return 0;
	}

if (!pInfo[playerid][Jailed]){
	SendClientMessage(playerid,COLOR_RED,"No point in paying a bail when you are not jailed!");
	return 0;
	}

strmid(sub,params,0,5,6);
strmid(params,params,5,255,250);
strresult = strfind(sub,"yes",true,0);
if (strresult!=-1){
	amount = pInfo[playerid][WantedLevel] * 1000;
	GivePlayerMoney(playerid, -amount);
	pInfo[playerid][Jailed] = 0;
	pInfo[playerid][WantedLevel] = 0;
	TogglePlayerControllable(playerid,true);
	GameTextForPlayer(playerid,"You paid your bail and are free.",3333,5);
	SetPlayerInterior(playerid,0);
	SetPlayerPos(playerid,1551.0000,-1676.0000,16.0000);
	SetPlayerFacingAngle(playerid,87.0);
	PlayerPlaySound(playerid,1069,1551.0000,-1676.0000,16.0000);
    return 1;
	}
SendClientMessage(playerid,COLOR_GREY,"Usage: /bail yes");
SendClientMessage(playerid,COLOR_GREY,"The bail height depends on the wanted level you had before.");
amount = pInfo[playerid][WantedLevel] * 1000;
format(string,sizeof(string),"Your bail is %d$. Enter '/bail yes' to pay it and be unjailed.",amount);
SendClientMessage(playerid,COLOR_RED,string);
return 0;
}


//Function added by M1k3
dcmd_wanted(playerid,params[])
{
#pragma unused params
new wantedname[24],wantedstr[120],reqteam;
reqteam = GetPlayerTeam(playerid);
if (reqteam!=TEAM_COPS){
SendClientMessage(playerid,COLOR_ORANGE,"----WANTED LIST----");
for(new f=0; f<MAX_PLAYERS; f++){
if(IsPlayerConnected(f)){
	if (pInfo[f][WantedLevel] >= 1){
		GetPlayerName(f,wantedname,sizeof(wantedname));
		format(wantedstr,sizeof(wantedstr),"%s (ID %d) [Level %d]",wantedname,f,pInfo[f][WantedLevel]);
		SendClientMessage(playerid,COLOR_WHITE,wantedstr);
		}
}
}
SendClientMessage(playerid,COLOR_ORANGE,"----END OF LIST----");
return 1;
}
else
SendClientMessage(playerid,COLOR_RED,"Cops use /check [ID] not /wanted!");
return 1;
}

//Function added by M1k3
dcmd_cophelp(playerid,params[])
{
	#pragma unused params
    SendClientMessage(playerid,COLOR_YELLOW,"Pure RPG - Cop Role Help");
    SendClientMessage(playerid,COLOR_RED,"Do not kill people except your life is SERIOUSLY endangerered.");
    SendClientMessage(playerid,COLOR_RED,"Killing people while your own health is above 30% is considered criminal!");
    SendClientMessage(playerid,COLOR_ORANGE,"To work as cop properly and not lose your badge, do the following.");
    SendClientMessage(playerid,COLOR_WHITE,"1) Make people stop (RPG or shooting, not killing).");
    SendClientMessage(playerid,COLOR_WHITE,"2) Use /cuff [ID] near them [less than 5 metres].");
    SendClientMessage(playerid,COLOR_WHITE,"3) Use /check [ID] near a cuffed person.");
    SendClientMessage(playerid,COLOR_WHITE,"4) Use /jail [ID] near the cuffed person [less than 5 metres].");
    SendClientMessage(playerid,COLOR_ORANGE,"If the cuffed person was wanted, you get a reward - if not, you lose money.");
    SendClientMessage(playerid,COLOR_WHITE,"/fine [ID] [amount] - Force the other player to pay an amount between 1$ and 500$");
    return 1;
}

//Function added by M1k3
dcmd_ah(playerid,params[])
{
	#pragma unused params
    SendClientMessage(playerid,COLOR_YELLOW,"Pure RPG - Admin Help");
    SendClientMessage(playerid,COLOR_RED,"Dont ask to be admin. Abusing admin commands will result in DEMOTION!");
    SendClientMessage(playerid,COLOR_WHITE,"[2] /stats [ID] - gets info about a player such as amount of money.");
    SendClientMessage(playerid,COLOR_WHITE,"[5] /(un)block ([Account Name])[ID] - (un)blocks an account (CASE SENSITIVE!) so it cannot be used no more (NOT an IP ban)");
    SendClientMessage(playerid,COLOR_WHITE,"[5] /setpocket(/setbank) [ID] [amount of $$$] - sets and saves the pocket money (or bank account balance) of a player.");
    SendClientMessage(playerid,COLOR_WHITE,"[10] /savespawn [ID] - Save the position the player is currently at as his spawn location");
    SendClientMessage(playerid,COLOR_WHITE,"[10] /setcar [ID] - sets and saves the car the player currently is in as his car constantly.");
    SendClientMessage(playerid,COLOR_ORANGE,"More commands at /xcommands");
    SendClientMessage(playerid,COLOR_ORANGE,"Work responsibly as admin.");
    return 1;
}

//Function added by M1k3
dcmd_sell(playerid,params[])
{
#pragma unused params
if (pInfo[playerid][vehicle]!=0){
pInfo[playerid][vehicle] = 0;
SendClientMessage(playerid,BBLUE,"You have sold your vehicle. Anyone can aquire it now.");
SendClientMessage(playerid,COLOR_RED,"Be sure you get get money for your vehicle asking the buyer to /pay you.");
return 1;
}
SendClientMessage(playerid,COLOR_RED,"You dont own a vehicle. :( Nothing to sell.");
return 1;
}

//Function added by M1k3
dcmd_find(playerid,params[])
{
#pragma unused params
if (pInfo[playerid][vehicle]!=0){
new Float:coorX;
new Float:coorY;
new Float:coorZ;
GetVehiclePos(pInfo[playerid][vehicle],coorX,coorY,coorZ);
SetVehicleToRespawn(pInfo[playerid][vehicle]);
SetPlayerCheckpoint(playerid,coorX,coorY,coorZ,2.0);
SendClientMessage(playerid,BBLUE,"Your vehicle has been respawned and a checkpoint is on your radar.");
SendClientMessage(playerid,COLOR_RED,"Go to the red checkpoint, your vehicle will be there.");
return 1;
}
SendClientMessage(playerid,COLOR_RED,"You dont own a vehicle. :( Nothing to find.");
return 1;
}

dcmd_saveskin(playerid,params[])
{
#pragma unused params
new player[24];
GetPlayerName(playerid,player,sizeof(player));

if(!pInfo[playerid][Logged]){
	SendClientMessage(playerid,COLOR_RED,"You must be logged in to use this command!!!");
	return 0;
	}
dini_IntSet(udb_encode(player),"Skin",pInfo[playerid][Skin]);
SendClientMessage(playerid,COLOR_YELLOW, "You current skin has been saved. You can access it with /getskin.");
return 1;
}

dcmd_getskin(playerid,params[])
{
#pragma unused params
if (pInfo[playerid][GetSkin]==0){
	pInfo[playerid][GetSkin] = 1;
	SendClientMessage(playerid,COLOR_YELLOW,"Your saved skin/spawn position is loaded. Type /getskin again to deactivate.");
	SetPlayerToSpawn (playerid);
	SpawnPlayer (playerid);
	return 1;
	}
else
pInfo[playerid][GetSkin] = 0;
SendClientMessage(playerid,COLOR_YELLOW,"Your saved skin/spawn position will be ignored. Type /getskin again to activate again.");
return 1;
}

//Function added by M1k3
dcmd_visit(playerid,params[])
{
#pragma unused params

if (pInfo[playerid][WantedLevel] >= 1){
	SendClientMessage(playerid,COLOR_RED,"/visit is disabled while wanted!");
	return 0;
}

if (pInfo[playerid][Jailed] || pInfo[playerid][Cuffed]){
	SetPlayerInterior(playerid,3);
	SetPlayerPos(playerid,198.5,162.5,1003.0);
	SetPlayerFacingAngle(playerid,180.0);
	SetCameraBehindPlayer(playerid);
	PlayerPlaySound(playerid,1069,198.5,162.5,1003.0);
	PlayerPlaySound(playerid,1068,198.5,162.5,1003.0);
	SendClientMessage(playerid,COLOR_RED,"/visit is disabled while jailed/badge loss or cuffed!");
	return 1;
}

if (IsPlayerInAnyVehicle(playerid)){
RemovePlayerFromVehicle(playerid);
}
new Float:coorX;
new Float:coorY;
new Float:coorZ;
new Float:coorA;
GetPlayerPos(playerid,coorX,coorY,coorZ);
GetPlayerFacingAngle(playerid,coorA);
pInfo[playerid][OldX] = floatround(coorX);
pInfo[playerid][OldY] = floatround(coorY);
pInfo[playerid][OldZ] = floatround(coorZ);
pInfo[playerid][OldA] = floatround(coorA);
SetPlayerInterior(playerid,3);
SetPlayerFacingAngle(playerid,352.0000);
SetCameraBehindPlayer(playerid);
SetPlayerPos(playerid,198.0000,159.5000,1003.0000);
SendClientMessage(playerid,COLOR_YELLOW,"You are visiting the jail. Enter /back to get back to your old position.");
return 1;
}

//Function added by M1k3
dcmd_back(playerid,params[])
{
#pragma unused params

if (pInfo[playerid][OldX]==0){
SendClientMessage(playerid,COLOR_RED,"You did not teleport away. No need to get you back.");
return 0;
}

new Float:coorX;
new Float:coorY;
new Float:coorZ;
new Float:coorA;
coorX = pInfo[playerid][OldX];
coorY = pInfo[playerid][OldY];
coorZ = pInfo[playerid][OldZ];
coorA = pInfo[playerid][OldA];
SetPlayerInterior(playerid,0);
SetPlayerFacingAngle(playerid,coorA);
SetCameraBehindPlayer(playerid);
SetPlayerPos(playerid,coorX,coorY,coorZ);
SendClientMessage(playerid,COLOR_YELLOW,"You have been brought back to your old position.");
return 1;
}

//Function added by M1k3
dcmd_taxidriver(playerid,params[])
{
#pragma unused params
new string[120],drivername[24],taxi;
GetPlayerName(playerid,drivername,sizeof(drivername));

if (!IsPlayerInAnyVehicle(playerid)){
	format(string,sizeof(string),"%s requests a taxidriver. Grab a taxi and become one.",drivername);
	SendClientMessageToAll(BBLUE,string);
	return 1;
	}

if (Taxidrvr == playerid){
	SendClientMessage(playerid,BBLUE,"You have quit the taxidriver job. It is vacant now.");
	SendClientMessageToAll(BBLUE,"The taxidriver position just became vacant. Use /taxidriver to become the next one.");
	Taxidrvr = -1;
	return 1;
	}

if (Taxidrvr!=-1){
    GetPlayerName(Taxidrvr,drivername,sizeof(drivername));
	format(string,sizeof(string),"There already is a taxidriver (%s - ID %d)",drivername,Taxidrvr);
	SendClientMessage(playerid,COLOR_RED,string);
	return 1;
	}
	
taxi = GetPlayerVehicleID(playerid);
if (taxi<7 || taxi>10){
	SendClientMessage(playerid,COLOR_RED,"You must be driving a taxi to be the taxidriver. Taxis are at the Airport Terminal.");
	return 1;
	}
if (taxi!=pInfo[playerid][vehicle]){
	SendClientMessage(playerid,COLOR_RED,"You must posses the taxi to become the taxi driver.");
	SendClientMessage(playerid,COLOR_YELLOW,"You can /sell saved house vehicles temporary.");
	SendClientMessage(playerid,COLOR_YELLOW,"You get your housecar back /sell then get in the vehicle.");
	return 1;
	}
Taxidrvr = playerid;
format(string,sizeof(string),"%s (ID %d) is now the official taxi driver.",drivername,Taxidrvr);
print (string);
SendClientMessage(playerid,COLOR_LIGHTGREEN,"You are now the offical taxidriver!");
SendClientMessageToAll(BBLUE,string);
SendClientMessageToAll(COLOR_YELLOW,"You can order a taxi with /taxi. Write a short description for the driver from where to where you want to drive.");
return 1;
}

//Function added by M1k3
dcmd_taxi(playerid,params[])
{
#pragma unused params
new string[120],drivername[24],customername[24];

if (!strlen(params)){
	SendClientMessage(playerid,COLOR_GREY,"Usage: /taxi [info for the driver]");
	SendClientMessage(playerid,COLOR_RED,"No info - no transfer ;(");
	return 1;
	}

if (Taxidrvr == -1){
	SendClientMessage(playerid,COLOR_RED,"Unfortunately there is no taxi driver at the moment.");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /taxidriver to request someone to drive a taxi.");
	return 1;
	}
GetPlayerName(Taxidrvr,drivername,sizeof(drivername));
GetPlayerName(playerid,customername,sizeof(customername));

if (!IsPlayerInAnyVehicle(playerid)){
	format(string,sizeof(string),"(Taxi Request) %s (ID %d). Information: %s",customername,playerid,params[0]);
	SendClientMessage(Taxidrvr,COLOR_LIGHTGREEN,string);
	SendClientMessage(Taxidrvr,COLOR_YELLOW,"Type /accept [price for the ride] or /reject [reason]");
	print (string);
	format(string,sizeof(string),"You requested a taxi");
	Taxicust = playerid;
	SendClientMessage(playerid,BBLUE,string);
	format(string,sizeof(string),"Your information for the driver: %s",params[0]);
	SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
	return 1;
	}
SendClientMessage(playerid,COLOR_RED,"No point in requesting a taxi while you are already in a vehicle. >:|");
return 1;
}

//Function added by M1k3
dcmd_accept(playerid,params[])
{
#pragma unused params
new string[255],drivername[24],customername[24];

if (playerid != Taxidrvr){
	SendClientMessage(playerid,COLOR_RED,"This command is for the taxidriver only.");
	SendClientMessage(playerid,COLOR_YELLOW,"Try to become the taxi driver by getting a taxi and type /taxidriver.");
	return 1;
	}

if (!strlen(params)){
	SendClientMessage(playerid,COLOR_GREY,"Usage: /accept [price for the ride in $$]");
	return 1;
	}
if (Taxicust==-1){
   	SendClientMessage(playerid,COLOR_RED,"Unfortunately there is no customer at the moment.");
	return 1;
	}
GetPlayerName(Taxidrvr,drivername,sizeof(drivername));
GetPlayerName(Taxicust,customername,sizeof(customername));

if (IsPlayerInAnyVehicle(playerid)){
	format(string,sizeof(string),"(Accepted Taxi Transfer) Customer %s (ID %d). Price: %s$",customername,Taxicust,params[0]);
	SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
	print (string);
	format(string,sizeof(string),"Taxidriver %s accepted your transfer request and is on his way to you.",drivername);
	SendClientMessage(Taxicust,BBLUE,string);
	format(string,sizeof(string),"Price for the transfer: %s$",params[0]);
	SendClientMessage(Taxicust,COLOR_LIGHTGREEN,string);
	return 1;
	}
Taxidrvr = -1;
SendClientMessage(playerid,COLOR_RED,"You have been suspended becasue you were not in your taxi! >:(");
return 1;
}

//Function added by M1k3
dcmd_reject(playerid,params[])
{
#pragma unused params
new string[255],drivername[24],customername[24];

if (playerid != Taxidrvr){
	SendClientMessage(playerid,COLOR_RED,"This command is for the taxidriver only.");
	SendClientMessage(playerid,COLOR_YELLOW,"Try to become the taxi driver by getting a taxi and type /taxidriver.");
	return 1;
	}

if (!strlen(params)){
	SendClientMessage(playerid,COLOR_GREY,"Usage: /reject [reason]");
	return 1;
	}
if (Taxicust==-1){
   	SendClientMessage(playerid,COLOR_RED,"Unfortunately there is no customer at the moment.");
	return 1;
	}
GetPlayerName(Taxidrvr,drivername,sizeof(drivername));
GetPlayerName(Taxicust,customername,sizeof(customername));

if (IsPlayerInAnyVehicle(playerid)){
	format(string,sizeof(string),"(Rejected Taxi Transfer)Customer %s (ID %d). Reason: %s",customername,Taxicust,params[0]);
	SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
	print (string);
	format(string,sizeof(string),"Taxidriver %s rejected your transfer.",drivername);
	SendClientMessage(Taxicust,BBLUE,string);
	format(string,sizeof(string),"Reason: %s",params[0]);
	SendClientMessage(Taxicust,COLOR_LIGHTGREEN,string);
	return 1;
	}
Taxidrvr = -1;
SendClientMessage(playerid,COLOR_RED,"You have been suspended because you were not in your taxi! >:(");
return 1;
}

//Function added by M1k3
dcmd_911(playerid,params[])
{
#pragma unused params
new string[255],sub[6],callername[24],strresult,alarmteam;


if (!strlen(params)){
	SendClientMessage(playerid,COLOR_GREY,"Usage: /911 c OR /911 cops - Gets the cops to come to you and help");
	SendClientMessage(playerid,COLOR_GREY,"Usage: /911 f OR /911 fire - Gets the firemen to come to you and help");
	SendClientMessage(playerid,COLOR_GREY,"Usage: /911 m OR /911 meds - Gets the medics to come to you and help");
	SendClientMessage(playerid,COLOR_GREY,"Usage: /911 n OR /911 none - stops your SOS signal");
	SendClientMessage(playerid,COLOR_ORANGE,"It is strongly advised that u give aditional info after the signal word!");
	return 1;
	}
GetPlayerName(playerid,callername,sizeof(callername));

strmid(sub,params,0,5,6);
strmid(params,params,5,255,250);
strresult = strfind(sub,"c",true,0);
if (strresult!=-1){
	pInfo[playerid][SOS] = 1;
	alarmteam = TEAM_COPS;
	SendClientMessage(playerid,BBLUE,"The LSPD is informed.");
	SendClientMessage(playerid,COLOR_YELLOW,"You can stop your SOS signal using /911 n or /911 none.");
	}
	
strresult = strfind(sub,"f",true,0);
if (strresult!=-1){
	pInfo[playerid][SOS] = 1;
	alarmteam = TEAM_FIREMEN;
	SendClientMessage(playerid,BBLUE,"The LSFD is informed.");
	SendClientMessage(playerid,COLOR_YELLOW,"You can stop your SOS signal using /911 n or /911 none.");
	}

strresult = strfind(sub,"m",true,0);
if (strresult!=-1){
	pInfo[playerid][SOS] = 1;
	alarmteam = TEAM_MEDICS;
	SendClientMessage(playerid,BBLUE,"The LSLR is informed.");
	SendClientMessage(playerid,COLOR_YELLOW,"You can stop your SOS signal using /911 n or /911 none.");
	}

strresult = strfind(sub,"n",true,0);
if (strresult!=-1){
	if (!pInfo[playerid][SOS]){
		SendClientMessage(playerid,COLOR_RED,"You did not set a SOS signal before.");
		return 1;
		}
	pInfo[playerid][SOS] = 0;
	SendClientMessage(playerid,BBLUE,"Your SOS signal has been stopped.");
	}

for (new al=0;al<MAX_PLAYERS;al++){
	if (gTeam[al] == alarmteam){
	format(string,sizeof(string),"(HQ) Caller %s (ID %d) needs urgent help.",callername,playerid);
	SendClientMessage(al,COLOR_RED,string);
	SendClientMessage(al,COLOR_RED,"A flashing icon on your map leads the way.");
	format(string,sizeof(string),"Other information given: %s",params[0]);
	SendClientMessage(al,COLOR_RED,string);
	}
}
return 1;
}

//Function added by M1k3
dcmd_changename(playerid,params[])
{
#pragma unused params
new string[255],oldname[25],newname[25];
new Password[255],Pocket,Level,Vehicle,pSkin;
new SpawnX,SpawnY,SpawnZ,SpawnA;

GetPlayerName(playerid,oldname,sizeof(oldname));

if(!strlen(params)){
	SendClientMessage(playerid,COLOR_GREY,"USAGE: /changename [new name]");
	return 0;
	}
	
if(!pInfo[playerid][Logged]){
	SendClientMessage(playerid,COLOR_RED,"You must be logged in to use this command!!!");
	return 0;
	}

format(newname,sizeof(newname),"%s",params[0]);

if(!dini_Exists(udb_encode(newname))){
Password = dini_Get(udb_encode(oldname),"Password");
Pocket = GetPlayerMoney(playerid);
Level = strval(dini_Get(udb_encode(oldname),"Level"));
Vehicle = strval(dini_Get(udb_encode(oldname),"Vehicle"));
pSkin = strval(dini_Get(udb_encode(oldname),"Skin"));
SpawnX = strval(dini_Get(udb_encode(oldname),"SpawnX"));
SpawnY = strval(dini_Get(udb_encode(oldname),"SpawnY"));
SpawnZ = strval(dini_Get(udb_encode(oldname),"SpawnZ"));
SpawnA = strval(dini_Get(udb_encode(oldname),"SpawnA"));

dini_IntSet("DeleteAccounts",oldname,1);

dini_Create(udb_encode(newname));
dini_Set(udb_encode(newname),"Password",Password);
dini_IntSet(udb_encode(newname),"Pocket",Pocket);
dini_IntSet(udb_encode(newname),"Level",Level);
dini_IntSet(udb_encode(newname),"Vehicle",Vehicle);
dini_IntSet(udb_encode(newname),"Skin",pSkin);
dini_IntSet(udb_encode(newname),"SpawnX",SpawnX);
dini_IntSet(udb_encode(newname),"SpawnY",SpawnY);
dini_IntSet(udb_encode(newname),"SpawnZ",SpawnZ);
dini_IntSet(udb_encode(newname),"SpawnA",SpawnA);

format(string,sizeof(string),"***** %s renamed to %s *****",oldname,newname);
SendClientMessageToAll(COLOR_PINK,string);
print (string);
return 1;
}
SendClientMessage(playerid,COLOR_RED,"(Error) This username already exists!");
return 1;
}

//Function added by M1k3
dcmd_changepass(playerid,params[])
{
#pragma unused params
new string[255],player[24],start,passctrl,oldpass[255],newpass[255];

GetPlayerName(playerid,player,sizeof(player));

if(!strlen(params)){
	SendClientMessage(playerid,COLOR_GREY,"USAGE: /changepass [old password] [new password]");
	return 0;
	}

if(!pInfo[playerid][Logged]){
	SendClientMessage(playerid,COLOR_RED,"You must be logged in to use this command!!!");
	return 0;
	}

oldpass = dini_Get(udb_encode(player),"Password");

passctrl = strfind(params,oldpass,true,0);

	if (passctrl==-1){
	SendClientMessage(playerid,COLOR_RED,"Wrong password!!!");
	return 0;
	}

start = strlen(oldpass) + 1;
strmid(newpass,params,start,255,255);
dini_Set(udb_encode(player),"Password",newpass);
format(string,sizeof(string),"You changed your password from %s to %s",oldpass,newpass);
SendClientMessage(playerid,COLOR_PINK,string);
return 1;
}

//Function added by M1k3
dcmd_charter(playerid,params[])
{
#pragma unused params
new string[120],pilotname[24],jet;
GetPlayerName(playerid,pilotname,sizeof(pilotname));

if (!IsPlayerInAnyVehicle(playerid)){
	format(string,sizeof(string),"%s requests a charter pilot. Get the Shamal Jet/Andromeda and become one.",pilotname);
	SendClientMessageToAll(BBLUE,string);
	return 1;
	}

if (pPilot == playerid){
	SendClientMessage(playerid,BBLUE,"You have quit the charter pilot job. It is vacant now.");
	SendClientMessageToAll(BBLUE,"The charter pilot position just became vacant. Use /charter to become the next one.");
	pPilot = -1;
	return 1;
	}

if (pPilot != -1 && pPilot != playerid){
    GetPlayerName(pPilot,pilotname,sizeof(pilotname));
	format(string,sizeof(string),"There already is a charter pilot (%s - ID %d)",pilotname,pPilot);
	SendClientMessage(playerid,COLOR_RED,string);
	return 1;
	}

jet = GetPlayerVehicleID(playerid);

if (gTeam[playerid] != TEAM_PILOTS){
	SendClientMessage(playerid,COLOR_RED,"(Remove) You are not licensed to control or own this vehicle. Ownership removed.");
	SendClientMessage(playerid,COLOR_YELLOW,"You need to be in the pilot role to become the charter pilot!");
	RemovePlayerFromVehicle(playerid);
	pInfo[playerid][vehicle] = 0;
	return 0;
	}

if (jet != 14 && jet != 139){
	SendClientMessage(playerid,COLOR_RED,"You must be controlling the Shamal Jet/Andromeda to be the charter pilot. They are at the Airport at the (big) hangars.");
	return 1;
	}
if (jet != pInfo[playerid][vehicle]){
	SendClientMessage(playerid,COLOR_RED,"You must posses the jet to become the charter pilot.");
	SendClientMessage(playerid,COLOR_YELLOW,"You can /sell saved house vehicles temporary.");
	SendClientMessage(playerid,COLOR_YELLOW,"You get your housecar back /sell then get in the vehicle.");
	return 1;
	}
pPilot = playerid;
format(string,sizeof(string),"%s (ID %d) is now the charter pilot. Flights = 500$. Parachute Dropoff = 200$.",pilotname,pPilot);
print (string);
SendClientMessage(playerid,COLOR_LIGHTGREEN,"You are now the charter pilot!");
SendClientMessageToAll(BBLUE,string);
SendClientMessageToAll(COLOR_YELLOW,"You can order a flight with /bookflight. Please write your destination for the pilot (or 'parachute [drop off point]' for dropoff).");
return 1;
}

//Function added by M1k3
dcmd_bookflight(playerid,params[])
{
#pragma unused params
new string[120],pilotname[24],pasname[24],chute;

if (!strlen(params)){
	SendClientMessage(playerid,COLOR_GREY,"Usage: /bookflight [destination]");
	SendClientMessage(playerid,COLOR_GREY,"Price 500$");
	SendClientMessage(playerid,COLOR_GREY,"Usage: /bookflight parachute [drop-off point]");
	SendClientMessage(playerid,COLOR_GREY,"Price 200$");
	SendClientMessage(playerid,COLOR_RED,"No info no flight ;(");
	return 1;
	}

	if (pPilot == -1){
	SendClientMessage(playerid,COLOR_RED,"Unfortunately there is no charter pilot at the moment.");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /charter to request someone to fly the jet.");
	return 1;
	}
GetPlayerName(pPilot,pilotname,sizeof(pilotname));
GetPlayerName(playerid,pasname,sizeof(pasname));

chute = strfind(params,"parachut",true,0);

	if (chute == -1){
	format(string,sizeof(string),"(Flight Booked) %s (ID %d). 500$ gained. Information: %s",pasname,playerid,params[0]);
	SendClientMessage(pPilot,COLOR_LIGHTGREEN,string);
	print (string);
	GivePlayerMoney(playerid,-500);
	GivePlayerMoney(pPilot,500);
	format(string,sizeof(string),"You booked a flight for 500$. Move to the red checkpoint on your radar and use /board");

	SetPlayerCheckpoint(playerid,1820.0000,-2626.0000,14.0000,2.0);
	pInfo[playerid][isPassenger] = 1;
	SendClientMessage(playerid,BBLUE,string);
	format(string,sizeof(string),"Your destination as sent to the pilot: %s",params[0]);
	SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
	return 1;
	}

format(string,sizeof(string),"(Dropoff Booked) %s (ID %d). 200$ gained. Information: %s",pasname,playerid,params[0]);
SendClientMessage(pPilot,COLOR_LIGHTGREEN,string);
print (string);
GivePlayerMoney(playerid,-200);
GivePlayerMoney(pPilot,200);
format(string,sizeof(string),"You booked a parachute dropoff for 200$. Move to the red checkpoint on your radar and use /board");

SetPlayerCheckpoint(playerid,2118.0000,-2428.0000,14.0000,2.0);
pInfo[playerid][isPassenger] = 1;
SendClientMessage(playerid,BBLUE,string);
format(string,sizeof(string),"Your dropoff point as sent to the pilot: %s",params[0]);
SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
return 1;
}

//Function added by M1k3
dcmd_board(playerid,params[])
{
#pragma unused params
new string[120],pilotname[24],pasname[24];

if (pInfo[playerid][isPassenger] == 0){
	SendClientMessage(playerid,COLOR_RED,"You did not book a flight.");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /bookflight [your destination].");
	return 1;
	}
GetPlayerName(pPilot,pilotname,sizeof(pilotname));
GetPlayerName(playerid,pasname,sizeof(pasname));

if (IsPlayerInCheckpoint(playerid)){
DisablePlayerCheckpoint(playerid);

	if (pInfo[pPilot][vehicle] == 14){
		SetPlayerInterior(playerid,1);
		SetPlayerPos(playerid,2.384830,33.103397,1199.849976);
		SetCameraBehindPlayer(playerid);
		}
	if (pInfo[pPilot][vehicle] == 139){
		SetPlayerInterior(playerid,9);
		SetPlayerPos(playerid,315.856170,1024.496459,1949.797363);
		SetCameraBehindPlayer(playerid);
		GivePlayerWeapon(playerid,46,1);
	 	}
SendClientMessage(playerid,BBLUE,"You boarded the plane. Enjoy your flight.");
SendClientMessage(playerid,COLOR_YELLOW,"Use /watchpilot to turn your personal pilot camera on/off.");
format(string,sizeof(string),"%s (ID %d) boarded your plane",pasname,playerid);
SendClientMessage(pPilot,BBLUE,string);
pInfo[playerid][Boarded] = 1;
return 1;
}
SendClientMessage(playerid,COLOR_RED,"You need to be in the red checkpoint to board the plane");
return 0;
}

//Function added by M1k3
dcmd_watchpilot(playerid,params[])
{
#pragma unused params

	if (pPilot == -1) {
	SendClientMessage(playerid,COLOR_RED,"Unfortunately there is no pilot to watch :(");
	return 0;
	}
	
	if (pInfo[pPilot][vehicle] != 14 && pInfo[pPilot][vehicle] != 139){
	SendClientMessage(playerid,COLOR_RED,"The charter pilot is not on duty.");
	return 0;
	}
	
	if (!pInfo[playerid][Boarded]){
	SendClientMessage(playerid,COLOR_RED,"You did not board the plane yet.");
	SendClientMessage(playerid,COLOR_YELLOW,"Enter /board at the red checkpoint after u booked a flight with /bookflight");
	return 0;
	}

	if (pInfo[playerid][WatchPilot]){
	pInfo[playerid][WatchPilot] = 0;
	SendClientMessage(playerid,COLOR_YELLOW,"Pilot cam OFF");
	return 1;
	}

	if (!pInfo[playerid][WatchPilot]){
	SendClientMessage(playerid,COLOR_YELLOW,"Pilot cam ON");
	pInfo[playerid][WatchPilot] = 1;
    return 1;
	}
return 1;
}

//Function added by M1k3
dcmd_takeoff(playerid,params[])
{
#pragma unused params

if (pPilot != playerid && !IsPlayerInVehicle(playerid,14) && !IsPlayerInVehicle(playerid,139)){
	SendClientMessage(playerid,COLOR_RED,"You are not the charter pilot or not in a jet");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /charter and get in the Shamal or Andromeda.");
	return 0;
	}
	
pFlight[Flying] = 1;
pFlight[OnBlocks] = 0;
pFlight[GreenLight] = 0;
GameTextForPlayer(pPilot,"~y~ LSAP Tower ~w~:~n~ Cleared for takeoff",5000,0);
SendClientMessageToAll(BBLUE,"A charter flight is taking off at LSAP...");
return 1;
}

//Function added by M1k3
dcmd_onblocks(playerid,params[])
{
#pragma unused params

if (pPilot != playerid && !IsPlayerInVehicle(playerid,14) && !IsPlayerInVehicle(playerid,139)){
	SendClientMessage(playerid,COLOR_RED,"You are not the charter pilot or not in a jet");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /charter and get in the Shamal or Andromeda.");
	return 1;
	}

if (pFlight[Flying] == 0){
	SendClientMessage(playerid,COLOR_RED,"You did not even takeoff - No point in 'on the blocks'.");
	return 0;
	}
	
pFlight[Flying] = 0;
pFlight[OnBlocks] = 1;
pFlight[GreenLight] = 0;
GameTextForPlayer(pPilot,"~y~ Apron Control ~w~:~n~ Flight Plan cancelled. Welcome at our airport.",5000,0);
SendClientMessageToAll(BBLUE,"Charter Flight landed and on the blocks.");
SendClientMessageToAll(COLOR_YELLOW,"Type /unboard to leave the plane");
return 1;
}

//Function added by M1k3
dcmd_GL(playerid,params[])
{
#pragma unused params

if (pPilot != playerid && !IsPlayerInVehicle(playerid,14) && !IsPlayerInVehicle(playerid,139)){
	SendClientMessage(playerid,COLOR_RED,"You are not the charter pilot or not in a jet");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /charter and get in the Shamal or Andromeda.");
	return 1;
	}

if (pFlight[Flying] == 0){
	SendClientMessage(playerid,COLOR_RED,"You did not even takeoff - No point in giving green light for chuters.");
	return 0;
	}

pFlight[GreenLight] = 1;
pFlight[OnBlocks] = 0;

GameTextForAll("~g~ GREEN LIGHT! ~n~ ~n~ ~g~GREEN LIGHT! ~n~ ~n~ ~w~ GO GO GO!",5000,0);
SendClientMessageToAll(COLOR_YELLOW,"PARACHUTERS type /unboard now!!!");
SendClientMessage(pPilot,COLOR_YELLOW,"Type /rl after all chuters unboarded!");
return 1;
}

//Function added by M1k3
dcmd_RL(playerid,params[])
{
#pragma unused params

if (pPilot != playerid && !IsPlayerInVehicle(playerid,14) && !IsPlayerInVehicle(playerid,139)){
	SendClientMessage(playerid,COLOR_RED,"You are not the charter pilot or not in a jet");
	SendClientMessage(playerid,COLOR_YELLOW,"Use /charter and get in the Shamal or Andromeda.");
	return 1;
	}

if (pFlight[Flying] == 0){
	SendClientMessage(playerid,COLOR_RED,"You did not even takeoff - No point in giving green light for chuters.");
	return 0;
	}

pFlight[GreenLight] = 0;
pFlight[OnBlocks] = 0;

GameTextForAll("~r~ RED LIGHT! ~n~ ~n~ ~r~RED LIGHT! ~n~ ~n~ ~w~ DOOR LOCKED!",5000,0);
return 1;
}

//Function added by M1k3
dcmd_unboard(playerid,params[])
{
#pragma unused params
new string[120],player[24];

GetPlayerName(playerid,player,sizeof(player));

if (!pFlight[OnBlocks] && pInfo[pPilot][vehicle] == 14){
	SendClientMessage(playerid,COLOR_RED,"The exits are still blocked!");
	SendClientMessage(playerid,COLOR_YELLOW,"Wait for the pilot to enter /onblocks");
	return 1;
	}

if (!pFlight[GreenLight] && pInfo[pPilot][vehicle] == 139){
	SendClientMessage(playerid,COLOR_RED,"The exits are still blocked!");
	SendClientMessage(playerid,COLOR_YELLOW,"Wait for the pilot to enter /GL");
	return 1;
	}
	
pInfo[playerid][WatchPilot] = 0;
KillTimer(pInfo[playerid][PWTimer]);
pInfo[playerid][PWTimer] = 0;

new Float:coorX;
new Float:coorY;
new Float:coorZ;

GetPlayerPos(pPilot,coorX,coorY,coorZ);
SetPlayerInterior(playerid,0);
coorX = coorX - 5.0000;
coorY = coorY - 5.0000;
SetPlayerPos(playerid,coorX,coorY,coorZ);

pInfo[playerid][isPassenger] = 0;
format(string,sizeof(string),"%s unboarded the plane",player);
SendClientMessageToAll(COLOR_YELLOW,string);
pInfo[playerid][Boarded] = 0;
return 1;
}

//Function by Weeds
dcmd_rob(playerid,params[])
{
	new player[24],victimname[24],victim,vicmax,string[120],gain,robmax;
	GetPlayerName(playerid,player,24);
	victim = strval(params);
	GetPlayerName(victim,victimname,24);
	if(!strlen(params))
	{
	    SendClientMessage(playerid,COLOR_GREY,"Usage: /rob [ID]");
		return 1;
	}
	
	if (pInfo[playerid][Jailed]){
	SendClientMessage(playerid,COLOR_RED,"/rob is disabled in jail.");
	return 0;
	}

	vicmax = GetPlayerMoney(victim);

 	if (vicmax <= 1000) {
 	SendClientMessage(playerid,COLOR_RED,"Your victim's purse is empty. Nothing to rob.");
 	return 0;
 	}

 	robmax = vicmax / 10; // Maximum = 10% of the other player's money
 	gain = random(robmax);
 	

	if(IsPlayerConnected(victim) && GetDistanceBetweenPlayers(playerid,victim) <= 5 && victim!=playerid)
	{
	format(string,sizeof(string),"You robbed %s (ID %d) %d$ out of his purse.",victimname,victim,gain);
		if (gain >= 100){
		SendClientMessage(playerid,COLOR_RED, "The victim reported the theft to the police. You are now wanted.");
		pInfo[playerid][AddWanted] = 1;
		}
	SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
	format(string,sizeof(string),"%s (ID %d) robbed %d$ out of your purse.",player,playerid,gain);
	SendClientMessage(victim,COLOR_RED,string);
	GivePlayerMoney(playerid,gain);
	GivePlayerMoney(victim,-gain);
    return 1;
	}
	SendClientMessage(playerid,COLOR_RED, "The player you tried to rob out is too far away, offline or yourself.");
	return 0;
}

//Function added by M1k3
dcmd_stats(playerid,params[])
{
#pragma unused params
new player[24],statsID,statsname[24],tmp[255],statsstr[120];
new vehicleID,dollars,ishe[20];
statsID=strval(params);
GetPlayerName(playerid,player,sizeof(player));
GetPlayerName(statsID,statsname,sizeof(statsname));

tmp = dini_Get(udb_encode(player),"Level");

if(strval(tmp)>=2 && pInfo[playerid][Admin]) {
	if(!strlen(params)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /stats [ID]");
		return 1;
	}
	format(statsstr,sizeof(statsstr),"----Player statistics for %s----",statsname);
	SendClientMessage(playerid,COLOR_YELLOW,statsstr);

	if(dini_Exists(udb_encode(player)))
	{
	    SendClientMessage(playerid,COLOR_ORANGE,"Registred: Yes");
	}

	if(!dini_Exists(udb_encode(player)))
	{
	    SendClientMessage(playerid,COLOR_ORANGE,"Registred: No");
	}

	vehicleID = pInfo[statsID][vehicle];
	format(statsstr,sizeof(statsstr),"Vehicle ID: %d",vehicleID);
	SendClientMessage(playerid,COLOR_ORANGE,statsstr);

	dollars = strval(dini_Get(udb_encode(statsname),"Bank"));
	format(statsstr,sizeof(statsstr),"Bank Account: %d",dollars);
	SendClientMessage(playerid,COLOR_ORANGE,statsstr);

	if (pInfo[statsID][WantedLevel] >= 1) format(ishe,20,"Yes [Level %d]",pInfo[statsID][WantedLevel]);
	else format(ishe,2,"No");
	format(statsstr,sizeof(statsstr),"Wanted: %s",ishe);
	SendClientMessage(playerid,COLOR_ORANGE,statsstr);

	if (pInfo[statsID][Cuffed]) format(ishe,3,"Yes");
	else format(ishe,2,"No");
	format(statsstr,sizeof(statsstr),"Cuffed: %s",ishe);
	SendClientMessage(playerid,COLOR_ORANGE,statsstr);

	if (pInfo[statsID][Jailed]) format(ishe,3,"Yes");
	else format(ishe,2,"No");
	format(statsstr,sizeof(statsstr),"Jailed: %s",ishe);
	SendClientMessage(playerid,COLOR_ORANGE,statsstr);

	if (pInfo[playerid][Admin])format(ishe,3,"Yes");
	if (!pInfo[playerid][Admin])format(ishe,3,"No");
	format(statsstr,sizeof(statsstr),"Staff: %s",ishe);
	SendClientMessage(playerid,COLOR_ORANGE,statsstr);
	SendClientMessage(playerid,COLOR_YELLOW,"----End of list----");
	return 1;
}
else
SendClientMessage(playerid,COLOR_RED,"You are not logged in as admin  or your level is to low!");
return 1;
}

//Function added by M1k3
dcmd_block(playerid,params[])
{
#pragma unused params
new player[24],blockID,blockname[24],tmp[255],blockstr[120];

blockID=strval(params);
GetPlayerName(playerid,player,sizeof(player));
GetPlayerName(blockID,blockname,sizeof(blockname));

tmp = dini_Get(udb_encode(player),"Level");

if(strval(tmp)>=5 && pInfo[playerid][Admin]) {
	if(!strlen(params)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /block [ID]");
		return 1;
	}
	dini_IntSet(udb_encode(blockname),"Banned",1);
//  Remove these comments (//) when you want an account block ot be public
//  and immediate (THIS FUNCTION DOES NOT PLACE ANY IP BAN.
//  THE BLOCKED PERSON CAN RETURN AND PLAY WITH ANOTHER NAME)
//	format(blockstr,sizeof(blockstr),"(Ban) Your account got blocked by admin %s",player);
//	SendClientMessage(blockID,COLOR_RED,blockstr);
	format(blockstr,sizeof(blockstr),"You blocked %s's account succesfully",blockname);
	SendClientMessage(playerid,COLOR_RED,blockstr);
	format(blockstr,sizeof(blockstr),"%s's account was blocked by Admin %s",blockname,player);
	print (blockstr);
//	SendClientMessageToAll(COLOR_RED,blockstr);
// 	pInfo[blockID][Banned] = 1;
	return 1;
}
else
SendClientMessage(playerid,COLOR_RED,"You are not logged in as admin  or your level is to low!");
return 1;
}

//Function added by M1k3
dcmd_unblock(playerid,params[])
{
#pragma unused params
new player[24],tmp[255],unblockstr[120];

GetPlayerName(playerid,player,sizeof(player));

tmp = dini_Get(udb_encode(player),"Level");

if(strval(tmp)>=5 && pInfo[playerid][Admin]) {
	if(!strlen(params)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /unblock [ID]");
		return 1;
	}
	if(dini_Exists(udb_encode(params))){
	dini_IntSet(udb_encode(params),"Banned",0);
	SendClientMessage(playerid,COLOR_YELLOW,"****Account Loaded****");
	format(unblockstr,sizeof(unblockstr),"You unblocked %s's account succesfully",params);
	SendClientMessage(playerid,COLOR_RED,unblockstr);
	format(unblockstr,sizeof(unblockstr),"%s was unbanned by Admin %s",params,player);
	print (unblockstr);
	SendClientMessageToAll(COLOR_RED,unblockstr);
 }
 else
 SendClientMessage(playerid,COLOR_RED,"Account Name not found!");
 return 1;
 }
else
SendClientMessage(playerid,COLOR_RED,"You are not logged in as admin or your level is to low!");
return 1;
}

//Function added by M1k3
dcmd_setpocket(playerid,params[])
{
#pragma unused params
new player[24],recID,recStr[5],setcashname[24],tmp[255],setcashstr[120];

GetPlayerName(playerid,player,sizeof(player));
tmp = dini_Get(udb_encode(player),"Level");

strmid(recStr,params,0,2,2);
recID = strval(recStr);
strmid(params,params,2,12,10);

if(strval(tmp)>=5 && pInfo[playerid][Admin]) {
	if(!strlen(params)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /setpocket [ID] [amount of $$$]");
		return 1;
	}

   if(IsPlayerConnected(recID)){
	GetPlayerName(recID,setcashname,24);
	format(setcashstr,sizeof(setcashstr),"You set the pocket money to %d$ for %s",strval(params),setcashname);
    SendClientMessage(playerid,COLOR_YELLOW,setcashstr);
	GivePlayerMoney(recID,-GetPlayerMoney(recID));
	GivePlayerMoney(recID,strval(params));
	dini_IntSet(udb_encode(setcashname),"Pocket",strval(params));
   	format(setcashstr,sizeof(setcashstr),"Your pocket money was set to %d$ by %s",strval(params),player);
   	SendClientMessage(recID,COLOR_YELLOW,setcashstr);
   	format(setcashstr, sizeof (setcashstr), "%s used /SETPOCKET to set %d$ as pocket money for %s (ID %d)",player,strval(params),setcashname,recID);
	print(setcashstr);
	}

return 1;
}
else
SendClientMessage(playerid,COLOR_RED,"You are not logged in as admin  or your level is to low!");
return 1;
}

//Function added by M1k3
dcmd_setbank(playerid,params[])
{
#pragma unused params
new player[24],recID,recStr[5],setcashname[24],tmp[255],setcashstr[120];

GetPlayerName(playerid,player,sizeof(player));
tmp = dini_Get(udb_encode(player),"Level");

strmid(recStr,params,0,2,2);
recID = strval(recStr);
strmid(params,params,2,12,10);

if(strval(tmp)>=5 && pInfo[playerid][Admin]) {
	if(!strlen(params)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /setbank [ID] [amount of $$$]");
		return 1;
	}

   if(IsPlayerConnected(recID)){
	GetPlayerName(recID,setcashname,24);
	format(setcashstr,sizeof(setcashstr),"You set the bank account balance to %d$ for %s",strval(params),setcashname);
    SendClientMessage(playerid,COLOR_YELLOW,setcashstr);
	dini_IntSet(udb_encode(setcashname),"Bank",strval(params));
   	format(setcashstr,sizeof(setcashstr),"Your bank account balance was set to %d$ by %s",strval(params),player);
   	SendClientMessage(recID,COLOR_YELLOW,setcashstr);
   	format(setcashstr, sizeof (setcashstr), "%s used /SETBANK to set %d$ as bank account balance for %s (ID %d)",player,strval(params),setcashname,recID);
	print(setcashstr);
	}

return 1;
}
else
SendClientMessage(playerid,COLOR_RED,"You are not logged in as admin  or your level is to low!");
return 1;
}

//Function added by M1k3
dcmd_setcar(playerid,params[])
{
new carguy,carID,carname[24],carstr[120],player[24],tmp[255];
carguy = strval(params);
carID = pInfo[carguy][vehicle];
GetPlayerName(playerid,player,sizeof(player));
GetPlayerName(carguy,carname,sizeof(carname));
tmp = dini_Get(udb_encode(player),"Level");
if(strval(tmp)==10 && pInfo[playerid][Admin]) {
	if(!strlen(params)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /setcar [ID]");
		return 1;
	}
dini_IntSet(udb_encode(carname),"Vehicle",carID);
format(carstr,sizeof(carstr),"%s's car ID saved as %d",carname,carID);
SendClientMessage(playerid,COLOR_ORANGE,carstr);
format(carstr,sizeof(carstr),"Admin %s saved the car you are currently owning as your car constantly.",player);
SendClientMessage(carguy,COLOR_ORANGE,carstr);
return 1;
}
else
SendClientMessage(playerid,COLOR_RED, "You are not logged in as admin  or your level is to low!");
return 0;
}

//Function added by M1k3
dcmd_savespawn(playerid,params[])
{
new spawnguy,spawnname[24],spawnstr[120],player[24],tmp[255];
spawnguy = strval(params);
GetPlayerName(playerid,player,sizeof(player));
GetPlayerName(spawnguy,spawnname,sizeof(spawnname));
tmp = dini_Get(udb_encode(player),"Level");
if(strval(tmp)==10 && pInfo[playerid][Admin]) {
	if(!strlen(params)){
	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /savespawn [ID]");
		return 1;
	}

new Float:posX;
new Float:posY;
new Float:posZ;
new Float:posA;

GetPlayerPos(spawnguy,posX,posY,posZ);
GetPlayerFacingAngle(spawnguy,posA);

dini_IntSet(udb_encode(spawnname),"SpawnX",floatround(posX));
dini_IntSet(udb_encode(spawnname),"SpawnY",floatround(posY));
dini_IntSet(udb_encode(spawnname),"SpawnZ",floatround(posZ));
dini_IntSet(udb_encode(spawnname),"SpawnA",floatround(posA));

format(spawnstr,sizeof(spawnstr),"%s's position saved as spawnposition.",spawnname);
SendClientMessage(playerid,COLOR_ORANGE,spawnstr);
format(spawnstr,sizeof(spawnstr),"Admin %s saved your current position as your future spawn position.",player);
SendClientMessage(spawnguy,COLOR_ORANGE,spawnstr);
return 1;
}
else
SendClientMessage(playerid,COLOR_RED, "You are not logged in as admin or your level is to low!");
return 0;
}

//************THIS REST IS PART OF WEED's****************************************
//************OPEN SOURCE "SAN ANDREAS ROLE PLAY" SCRIPT*************************


public Sec()
{
    for(new i=0;i<MAX_PLAYERS;i++) if(IsPlayerConnected(i)){
        pInfo[i][c]++;
        SetPlayerScore(i, GetPlayerMoney(i)); //Added by M1k3
	}
}
public CHack()
{
        hack = 0;
}
public OnGameModeExit()
{
new pexit[24];

for (new z=0;z<MAX_PLAYERS;z++){
	GetPlayerName(z,pexit,24);
	dini_IntSet(udb_encode(pexit),"Pocket",GetPlayerMoney(z));
 	pInfo[z][Spawned] = 0;
	pInfo[z][Logged] = 0;
	pInfo[z][Admin] = 0;
	pInfo[z][Cuffed] = 0;
	pInfo[z][Wanted] = 0;
	pInfo[z][AddWanted] = 0;
	pInfo[z][WantedLevel] = 0;
	pInfo[z][Jailable] = 0;
	pInfo[z][Jailed] = 0;
}

dini_IntSet("Servertime","Time",Servertime);
SendClientMessageToAll(COLOR_RED,"****GAME MODE EXIT****");
	return 1;
}
