#include <a_samp>
#include <xcolours>
#include <float>
#include <dini2>
#include <FcukIt++>
#include <uf>
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xFF0000FF
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_INVISIBLE 0x000000
#define COLOR_SYSGREY 0xAFAFAFAA
#define MAX_GTASAVEHICLES   212
new countvalue;
new lost[MAX_PLAYERS];
new banplayer;
new startup;
new muzzza = 0;
new seccheck;
new hourcheck;
new mincheck;
new kickplayer;
new countstop;
new countimer;
new killtimer[MAX_PLAYERS];
new firstplay;
new logon;


public OnFilterScriptInit() {
	print("\n|---------------------------------|");
	print("|  AeroTools sucessfully loaded   |");
	print("|TYPE /aerohelp for get more info |");
	print("|---------------------------------|\n");
firstplay = 0;
startup = 0;
mincheck = 0;
seccheck = 0;
hourcheck = 0;
}

public OnFilterScriptExit() {
	print("\n|---------------------------------|");
	print("|  AeroTools sucessfully unloaded |");
	print("|---------------------------------|\n");

}
public OnGameModeInit(){

}



public OnPlayerConnect(playerid)
{
    PlayerPlaySound(playerid,1062,1958.3783, 1343.1572, 15.3746);
killtimer[playerid] = 0;
 new string[256];
new onlinecount;
if(startup == 0){
string = dini_Get("AeroToolsSettings.ini", "log");

logon = strval(string);
startup = 1;
string = dini_Get("AeroToolsSettings.ini", "MinSave");
mincheck = strval(string);
string = dini_Get("AeroToolsSettings.ini", "SecSave");
seccheck = strval(string);
string = dini_Get("AeroToolsSettings.ini", "HourSave");
hourcheck = strval(string);
SetTimer("ufctimer",1000,1);
SetTimer("admincheck", 1000, true);
SetTimer("UptimeSeccheck", 1000, true);
SetTimer("UptimeSave", 10000, true);
//SetTimer("UptimeMincheck", 60*1000, true);
//SetTimer("UptimeHourcheck", 3600*1000, true);
string = dini_Get("AeroToolsSettings.ini", "OnlineRecord");
onlinecount = strval(string);
if(GTP() > onlinecount){
new oldonline;
oldonline = GTP();
format(string, sizeof(string), "New online Players Record : %d!!!!", oldonline);
SendClientMessageToAll(0x80FF00FF, string);
format(string, sizeof(string), "%d", oldonline);
dini_Set("AeroToolsSettings.ini", "OnlineRecord", string);
}
if(logon == 1){
new playname[MAX_PLAYER_NAME];
GetPlayerName(playerid,playname,sizeof(playname));
format(string, sizeof(string), "%s has joined the server", playname);
savetext(string);
}
}


new adminname[MAX_PLAYER_NAME];
GetPlayerName(playerid,adminname,sizeof(adminname));
format(string, sizeof(string), "Hello there %s - Type /aonlineadmins for get how many admins are online.", adminname);
SendClientMessage(playerid, COLOR_GREEN, string);
SendClientMessage(playerid, COLOR_GREEN, "You also can type /uptime to get how long the server is online.");
if(firstplay == 0){
firstplay = 1;

}
}



public aeroban()
{
Ban(banplayer);
	    return 0;
}

public UptimeSave()
{
 new string[256];
format(string, sizeof(string), "%d", mincheck);
dini_Set("AeroToolsSettings.ini", "MinSave", string);
format(string, sizeof(string), "%d", seccheck);
dini_Set("AeroToolsSettings.ini", "SecSave", string);
format(string, sizeof(string), "%d", hourcheck);
dini_Set("AeroToolsSettings.ini", "HourSave", string);

if(logon == 1){
format(string, sizeof(string), "%Uptime saved : %dh %dm %ds.",hourcheck, mincheck, seccheck);
savetext(string);
}

	    return 0;
}

public GTP()
{
new online;
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i)){
online = online + 1;
		}
		}
	    return online;
}

public msgadmins(text[])
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && IsPlayerAdmin(i)){
SendClientMessage(i, 0xFF0000FF, text);
		}
		}
	    return 0;
}

public admincheck()
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i)){
if (IsPlayerAdmin(i)) {
if (killtimer[i] == 0){
killtimer[i] = 1;
new string[256];
new tmp[256];
SendClientMessage(i, COLOR_LIGHTBLUE, "You has logged in - Type /aerohelp to get other info");
SendClientMessage(i, COLOR_LIGHTBLUE, "You can get info about any player - Type /eyeinfo [PlayeriID].");
tmp = dini_Get("AeroToolsSettings.ini", "msgtoadmins");
format(string, sizeof(string), "Message: %s.", tmp);
SendClientMessage(i, COLOR_LIGHTBLUE, string);
new adminname[MAX_PLAYER_NAME];
GetPlayerName(i,adminname,sizeof(adminname));
SetPlayerColor(i, 0xFF0000FF);
format(string, sizeof(string), "SERVER: %s has logged in as Admin.", adminname);
SendClientMessageToAll(0xFFFFFFAA, string);
if(logon == 1){
savetext(string);
}

}
}
}

}
	    return 0;
}
public savetext(text[]){
new File:fhandle;
new temp[256];
fhandle = fopen("AeroToolsLog.ini",io_append);
format(temp, sizeof(temp), "%s\r\n", text);
fwrite(fhandle, temp);
fclose(fhandle);
printf("AeroTools log System : %s", text);
}

public OnPlayerText(playerid, text[])
{
if(logon == 1){
new string[256];
new textname[MAX_PLAYER_NAME];
GetPlayerName(playerid,textname,sizeof(textname));
format(string, sizeof(string), "%s : %s.", textname, text);
savetext(string);
}
	if(lost[playerid] == 1) {


SetTimer("con3", 500, 0);
SetTimer("connection", 1312, 0);

	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i)){

		lost[i] = 0;
		}
return 0;
	}
	}
	return 1;
}

public OnPlayerDisconnect(playerid)
{
if(logon == 1){
new string[256];
new playname[MAX_PLAYER_NAME];
GetPlayerName(playerid,playname,sizeof(playname));
format(string, sizeof(string), "%s has left the server", playname);
savetext(string);
}	
killtimer[playerid] = 0;
}

public OnPlayerSpawn(playerid)
{
    PlayerPlaySound(playerid,1186 ,1958.3783, 1343.1572, 15.3746);
if(logon == 1){
new string[256];
new textname[MAX_PLAYER_NAME];
GetPlayerName(playerid,textname,sizeof(textname));
format(string, sizeof(string), "%s has been spawned.", textname);
savetext(string);
}
}

public UptimeSeccheck(){
if(startup == 1){
seccheck = seccheck + 1;
if(seccheck >= 60){
seccheck = 0;
mincheck = mincheck + 1;
}
if(mincheck >= 60){
mincheck = 0;
hourcheck = hourcheck + 1;
}
		new temp[256];
			format(temp, sizeof(temp), "~n~~n~~n~~n~~y~Uptime:~n~%d~r~:~y~%d %d" ,  hourcheck, mincheck,seccheck);
//SetGameModeText(temp);
//GameTextForAll(temp,1000,5);
}
}
public UptimeMincheck(){
if(startup == 1){
//mincheck = mincheck + 1;
if(mincheck >= 60){
mincheck = 0;
hourcheck = hourcheck + 1;
}
//		new temp[256];
	//			format(temp, sizeof(temp), "~n~~n~~n~~n~~y~%d~r~:~y~%d %d" ,  uptime/3600, (uptime/60) - ((uptime/3600)*60), uptime - (((uptime/60) - uptime/3600)*60));
//SetGameModeText(temp);
//GameTextForAll(temp,1000,5);
}
}
public UptimeHourcheck(){
if(startup == 1){
hourcheck = hourcheck + 1;
//		new temp[256];
	//			format(temp, sizeof(temp), "~n~~n~~n~~n~~y~%d~r~:~y~%d %d" ,  uptime/3600, (uptime/60) - ((uptime/3600)*60), uptime - (((uptime/60) - uptime/3600)*60));
//SetGameModeText(temp);
//GameTextForAll(temp,1000,5);
}
}

public OnPlayerPrivmsg(senderid, playerid, text[])
{

		new sname[256], pname[256];
		GetPlayerName(playerid, pname, sizeof(pname));
		GetPlayerName(senderid, sname, sizeof(sname));

		new temp[256];

		format(temp, sizeof(temp), "@EyE -> PrivMSg - %s to %s: %s" , sname, pname, text);
if(logon == 1){
savetext(temp);
}	
		for(new e=0; e<MAX_PLAYERS; e++)
		    if(IsPlayerConnected(e) && IsPlayerAdmin(e))
	   			SendClientMessage(e, COLOUR_MAGENTA, temp);
	
	return 1;
}


public nuuler()
{
SetTimer("null2", 50000, true);
}

public nuul2()
{
print("uptime");
}

public stopcount()
{
countstop = -- countstop;
KillTimer(countstop);
SetTimer("stopcount", 0, 10);
	    return 0;
}

public counter()
{
countvalue = -- countvalue;
SetTimer("counter2", 0 , 0);
	    return 0;
}
public counter2()
{
new string[256];

if(countvalue == 0){
GameTextForAll("~b~]]~y~Go!~b~]]~y~Go!~b~]]~y~Go!~b~]]", 3000, 5);
KillTimer(countimer);
/*KillTimer(1);
KillTimer(2);
KillTimer(3);
KillTimer(4);*/
for (new i = 0; i < MAX_PLAYERS; i++)
{
TogglePlayerControllable(i, 1);
}
	    return 1;
} else if(countvalue == 1){
GameTextForAll("~w~.~r~.~g~.~y~READY~g~.~r~.~w~.", 1000, 5);

} else {
format(string, sizeof(string), "~y~]~r~%d~y~]", countvalue);
GameTextForAll(string, 1000, 5);

}
	    return 0;
}



public aerokick()
{
Kick(kickplayer);
	    return 1;
}


public OnPlayerDeath(playerid, killerid, reason){

if(logon == 1){
	if(killerid == INVALID_PLAYER_ID) {
	new string[256];

new textname[MAX_PLAYER_NAME];
GetPlayerName(playerid,textname,sizeof(textname));
format(string, sizeof(string), "%s died.", textname);
savetext(string);
} else {
new string[256];

new textname[MAX_PLAYER_NAME];
GetPlayerName(playerid,textname,sizeof(textname));
new textname2[MAX_PLAYER_NAME];
GetPlayerName(killerid,textname2,sizeof(textname2));
format(string, sizeof(string), "%s has been killed by %s (Weapon : %d).", textname, textname2, reason);
savetext(string);
}
}


}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
     if(newstate == PLAYER_STATE_DRIVER)
	{
	new vehicleid = GetPlayerVehicleID(playerid);
    new vehiclename[256];
    format(vehiclename,sizeof(vehiclename),"%s",GetVehicleName(vehicleid));
    SendClientMessage(playerid, COLOR_GREEN, vehiclename);
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger){
SendClientMessageToAll(COLOUR_LIGHTBLUE, GetVehicleName(vehicleid));
if(logon == 1){

	new string[256];
//	new temp[256];
new textname[MAX_PLAYER_NAME];
GetPlayerName(playerid,textname,sizeof(textname));
//temp = GetVehicleName(vehicleid);
new vehicleclass = GetVehicleClass(vehicleid);
new tmp = vehicleclass - 400;
//temp =  vehicleNames[tmp];
format(string, sizeof(string), "%s entered vehicle ID %d, Class %s.", textname, vehicleid, vehicleNames[tmp]);
SendClientMessageToAll(COLOUR_LIGHTBLUE, string);
savetext(string);

}
}

public banall(){
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i)){

Ban(i);
		}
	}
	}

public OnPlayerCommandText(playerid, cmdtext[]) {


	new giveplayername[MAX_PLAYER_NAME];

	new thisplayer[MAX_PLAYER_NAME];
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, pname, sizeof(pname));
		new temp[256];
new cmdname[256];
strmid(cmdname, cmdtext, 0, strlen(cmdtext));

		format(temp, sizeof(temp), "@EyE -> Command - %s has typed %s", pname, cmdname);
if(logon == 1){
savetext(temp);
}	
	new cmd[256];
	new idx;
	cmd = strtok(cmdtext, idx);
			for(new e=0; e<MAX_PLAYERS; e++)
		    if(IsPlayerConnected(e) && IsPlayerAdmin(e)){
		    if(e == playerid){
		    } else {
	   			SendClientMessage(e, COLOUR_MAGENTA, temp);
	   			}
	   			}
	GetPlayerName(playerid,thisplayer,sizeof(thisplayer));


	if (strcmp(cmd, "/amuza", true)==0) {
if(muzzza == 0){
    PlayerPlaySound(playerid,1062,1958.3783, 1343.1572, 15.3746);
muzzza = 1;
} else {
    PlayerPlaySound(playerid,1186 ,1958.3783, 1343.1572, 15.3746);
    muzzza = 0;
    }

	    return 1;
	}
	
	if (strcmp(cmd, "/aadminskin", true)==0 && IsPlayerAdmin(playerid)) {

SetPlayerSkin(playerid, 234);

	    return 1;
	}	


if (strcmp(cmd, "/eyeinfo", true)==0 && IsPlayerAdmin(playerid)) {

new tmp[256];

new infop;

new string[256];
tmp = strtok(cmdtext, idx);
infop = strval(tmp);
if(!IsPlayerConnected(infop)){
SendClientMessage(playerid, COLOR_YELLOW, "@EyE -> This player is not connected.");
} else if(!strlen(tmp)){
SendClientMessage(playerid, COLOR_YELLOW, "@EyE -> Invalid Player ID - Usage : /eyeinfo [PlayerID].");
} else {
new infopn[MAX_PLAYER_NAME];
GetPlayerName(infop, infopn, sizeof(infopn));
new infomoney = GetPlayerMoney(infop);
new infoscore = GetPlayerScore(infop);

new admin[256];
new Float:health;
GetPlayerHealth(infop, health);
new veh[256];

if(IsPlayerAdmin(infop)){
admin = "yes";
} else admin = "no";

if(IsPlayerInAnyVehicle(infop)){
new vehid;
vehid = GetPlayerVehicleID(infop);
format(veh, sizeof(veh), "Yes - In ID: %d", vehid);
} else veh = "no";

format(string, sizeof(string), "@EyE -> Name: %s, Money: %d, Score: %d, Admin: %s, Health: %.0f, In Vehicle: %s", infopn, infomoney, infoscore, admin, health, veh);
SendClientMessage(playerid, COLOR_YELLOW, string);
}
	    return 1;
	}	

if (strcmp(cmd, "/uptime", true)==0) {
new string[256];
format(string, sizeof(string), "Uptime : %d Hours, %d Minutes and %d secounds.", hourcheck, mincheck, seccheck);
//format(string, sizeof(string), "Uptime : %d secounds.", uptime);
SendClientMessage(playerid, COLOR_YELLOW, string);
	    return 1;
	}	

	if(IsPlayerAdmin(playerid)) {

if(strcmp(cmd, "/atime", true)==0) {
	
    new tmp[256];
    new newtime;
    tmp = strtok(cmdtext, idx);
    newtime = strval(tmp);

    if(!newtime) {
        SendClientMessage(playerid, COLOR_GREEN, "Usage: /atime [hour]");
     }
     else if (newtime >24 || newtime <0) {
         SendClientMessage(playerid, COLOR_RED, "Invalid new hour!");
     }
     else {
         format(tmp, sizeof(tmp), "The time has been changed to: %d:00", newtime);
         SendClientMessageToAll(COLOR_GREEN,tmp);
         SetWorldTime(newtime);
     }
     return true;
}


if(strcmp(cmd, "/aftimeout", true)==0) {
	new string[256];	
SetPlayerColor(playerid, COLOR_INVISIBLE);
format(string, sizeof(string), "*** %s left the server. (Timeout)", thisplayer);
SendClientMessageToAll(COLOR_SYSGREY, string);
return 0;
}
if(strcmp(cmd, "/aftimeoutname", true)==0) {
new tmp[256];
	new string[256];	
tmp = strtok(cmdtext, idx);
format(string, sizeof(string), "*** %s left the server. (Timeout)", tmp);
SendClientMessageToAll(COLOR_SYSGREY, string);
return 0;
}
if(strcmp(cmd, "/afleave", true)==0) {
	new string[256];	
SetPlayerColor(playerid, COLOR_INVISIBLE);
format(string, sizeof(string), "*** %s left the server. (Leaving)", thisplayer);
SendClientMessageToAll(COLOR_SYSGREY, string);
return 0;
}
if(strcmp(cmd, "/afleavename", true)==0) {
new tmp[256];
	new string[256];	
tmp = strtok(cmdtext, idx);
format(string, sizeof(string), "*** %s left the server. (Leaving)", tmp);
SendClientMessageToAll(COLOR_SYSGREY, string);
return 0;
}
if(strcmp(cmd, "/afkick", true)==0) {
	new string[256];	
SetPlayerColor(playerid, COLOR_INVISIBLE);
format(string, sizeof(string), "*** %s left the server. (Kicked)", thisplayer);
SendClientMessageToAll(COLOR_SYSGREY, string);
return 0;
}
if(strcmp(cmd, "/afkickname", true)==0) {
new tmp[256];
	new string[256];	
tmp = strtok(cmdtext, idx);
format(string, sizeof(string), "*** %s left the server. (Kicked)", tmp);
SendClientMessageToAll(COLOR_SYSGREY, string);
return 0;
}
if(strcmp(cmd, "/afenter", true)==0) {
	new string[256];	
SetPlayerColor(playerid, COLOR_YELLOW);
format(string, sizeof(string), "*** %s joined the server.", thisplayer);
SendClientMessageToAll(COLOR_SYSGREY, string);
return 0;
}
if(strcmp(cmd, "/afentername", true)==0) {
new tmp[256];
	new string[256];	
tmp = strtok(cmdtext, idx);
format(string, sizeof(string), "*** %s joined the server.", tmp);
SendClientMessageToAll(COLOR_SYSGREY, string);
return 0;
}
if(strcmp(cmd, "/aflost", true)==0) {
SetTimer("lost2", 1345, 0);
return 1;
}

if(strcmp(cmd, "/aflostoff", true)==0) {
	new string[256];	
SetTimer("con3", 500, 0);
format(string, sizeof(string), "Connecting to 127.0.0.1:7777..");
SendClientMessageToAll(COLOR_SYSGREY, string);
SetTimer("connection", 1312, 0);

	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i)){

		lost[i] = 0;
		}
	}
return 1;
}

	if (strcmp(cmd, "/aerohelp", true)==0 && IsPlayerAdmin(playerid)) {
	    SendClientMessage(playerid, COLOUR_LIGHTBLUE, "AeroAdmin avialable commands:");
	    SendClientMessage(playerid, COLOUR_LIGHTBLUE, "/aban, /akick, /acounter, /aadmincolor, /asay, /agamesay, /atel-me-to, /acolor, /aadmincolor, /amoneyall,");
	    SendClientMessage(playerid, COLOUR_LIGHTBLUE, "/ascore, /amoney, /atel-to-me,/asethealth, /aremove, /adeparalyze, /aresetmoney, /akill, /ascoreall,");
	    SendClientMessage(playerid, COLOUR_LIGHTBLUE, "/aparalyze, /agiveweapon, /aresetweapon, /aabout, /aclearchat, /asayto, /agamesayto, /aonlineadmins. ");
	    SendClientMessage(playerid, COLOUR_LIGHTBLUE, "/uptime, /eyeinfo, /onlineadmins, /aflost, /aftimeout, /aftimeoutname, /afleave, /afleavename, /afkick, /afkickname");
	    SendClientMessage(playerid, COLOUR_LIGHTBLUE, "Thanks for using Aero Tools Script.");
	    SendClientMessage(playerid, COLOUR_LIGHTBLUE, "We wish You a good game.");
	    SendClientMessage(playerid, COLOUR_LIGHTBLUE, "                                           Grettings from Aero Group");


	    return 1;
	}
if (strcmp(cmd, "/aban", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];



new string[256];
tmp = strtok(cmdtext, idx);
banplayer = strval(tmp);
format(string, sizeof(string), "You has been banned and kicked by administrator %s", thisplayer);
SendClientMessage(banplayer, COLOR_RED, string);
SetTimer("aeroban",500,0);

	    return 1;
	}
	
if (strcmp(cmd, "/abanall", true)==0 && IsPlayerAdmin(playerid)) {
new string[256];
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i)){

format(string, sizeof(string), "You has been banned and kicked by administrator %s", thisplayer);
SendClientMessage(banplayer, COLOR_RED, string);
		}
	}
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i)){


SetTimer("banall", 500, 0);
		}
	}
	    return 1;
	}
	
if (strcmp(cmd, "/akickall", true)==0 && IsPlayerAdmin(playerid)) {
new string[256];
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i)){

format(string, sizeof(string), "You has been kicked by administrator %s", thisplayer);
SendClientMessage(banplayer, COLOR_RED, string);
		}
	}
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i)){

SetTimer("kickall", 500, 0);
		}
	}
	    return 1;
	}	
 	
if (strcmp(cmd, "/acounter", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];
//new  countvalue2;
//KillTimer(0);
tmp = strtok(cmdtext, idx);
//countvalue2 = strval(tmp);
countvalue = strval(tmp) + 1;

if(countvalue > 0){
tmp = strtok(cmdtext, idx);
new freezeval;
freezeval = strval(tmp);
if(freezeval == 1){
for (new i = 0; i < MAX_PLAYERS; i++)
{
TogglePlayerControllable(i, 0);

}
countimer = SetTimer("counter",1000, true);
} else {
countimer = SetTimer("counter",1000, true);
}

	    return 1;
} else {
SendClientMessage(playerid, COLOR_RED, "Usagee : /acounter (secounds) (freeze = 1 or 0)");
	    return 1;
}

	    return 1;
	}

else if (strcmp(cmd, "/akick", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];


new string[256];

tmp = strtok(cmdtext, idx);
kickplayer = strval(tmp);
format(string, sizeof(string), "You has been kicked by administrator %s", thisplayer);
SendClientMessage(kickplayer, COLOR_RED, string);
SetTimer("aerokick",500,0);

	    return 1;
	}

else if (strcmp(cmd, "/aadmincolor", true)==0 && IsPlayerAdmin(playerid)) {

SetPlayerColor(playerid, 0xFF0000FF);
SendClientMessage(playerid, 0xFF0000FF, "You has changed nickname color ;]");
	    return 1;
	}

else if (strcmp(cmd, "/asay", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];


new string[256];

			strmid(tmp,cmdtext,5,strlen(cmdtext));

format(string, sizeof(string), "@dmin : %s", tmp);
SendClientMessageToAll(COLOR_LIGHTBLUE, string);
	    return 1;
	}

else if (strcmp(cmd, "/agamesay", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];


new string[256];
			strmid(tmp,cmdtext,9,strlen(cmdtext));

format(string, sizeof(string), "~w~%s", tmp);
GameTextForAll(string, 5000, 5);
	    return 1;
	}
	
else if (strcmp(cmd, "/agamesayto", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];
new tmp2[256];
new sayplayer;
tmp = strtok(cmdtext, idx);
sayplayer = strval(tmp);
new string[256];
			strmid(tmp2,cmdtext,13,strlen(cmdtext));

format(string, sizeof(string), "~w~%s", tmp2);
GameTextForPlayer(sayplayer, string, 5000, 5);
	    return 1;
	}
	
else if (strcmp(cmd, "/asayto", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];
new tmp2[256];
new sayplayer;
tmp = strtok(cmdtext, idx);
sayplayer = strval(tmp);
new string[256];
			strmid(tmp2,cmdtext,8,strlen(cmdtext));

format(string, sizeof(string), ">>@dmin : %s", tmp2);
SendClientMessage(sayplayer, COLOR_LIGHTBLUE, string);
	    return 1;
	}

else if (strcmp(cmd, "/ascore", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];

new scoreplayer;
new scoreplayerscore;
new scoreplus;
new string[256];
tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_RED, ">>Invalid PlayerID");
			} else {
scoreplayer = strval(tmp);
tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
						SendClientMessage(playerid, COLOR_RED, ">>Invalid score amount");
			} else {
scoreplus = strval(tmp);
new scoreplayername[MAX_PLAYER_NAME];
GetPlayerName(scoreplayer,scoreplayername,sizeof(scoreplayername));
format(string, sizeof(string), ">>You has gived %d score to %s",scoreplus, scoreplayername);
SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
scoreplayerscore =SetPlayerScore(scoreplayer, scoreplayerscore+scoreplus);
tmp = strtok(cmdtext, idx);
}
}
	    return 1;
	}
	
else if (strcmp(cmd, "/ascoreall", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];

new scoreplayerscore;
new scoreplus;
new string[256];
tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
						SendClientMessage(playerid, COLOR_RED, ">>Invalid score amount");
			} else {
scoreplus = strval(tmp);
format(string, sizeof(string), ">>You has gived %d to all",scoreplus);
SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
for (new i = 0; i < MAX_PLAYERS; i++)
{
    if (IsPlayerConnected(i)) {
scoreplayerscore = GetPlayerScore(i);
SetPlayerScore(i, scoreplayerscore+scoreplus);
}
}

tmp = strtok(cmdtext, idx);
}
	    return 1;
	}

else if (strcmp(cmd, "/amoneyall", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];

//new scoreplayerscore;
new scoreplus;
new string[256];
tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
						SendClientMessage(playerid, COLOR_RED, ">>Invalid score amount");
			} else {
scoreplus = strval(tmp);
format(string, sizeof(string), ">>You has gived %d to all",scoreplus);
SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
for (new i = 0; i < MAX_PLAYERS; i++)
{
    if (IsPlayerConnected(i)) {
//scoreplayerscore = GetPlayerScore(i);
FcukIt_GivePlayerMoney(i, scoreplus);
}
}

tmp = strtok(cmdtext, idx);
}
	    return 1;
	}



else if (strcmp(cmd, "/amoney", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];

new moneyplayer;
new moneyplus;
new string[256];
tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
						SendClientMessage(playerid, COLOR_RED, ">>Invialid PlayerID");
			} else {
moneyplayer = strval(tmp);
tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
						SendClientMessage(playerid, COLOR_RED, ">>Invalid money amount");
			} else {
moneyplus = strval(tmp);
new moneyplayername[MAX_PLAYER_NAME];
GetPlayerName(moneyplayer,moneyplayername,sizeof(moneyplayername));
format(string, sizeof(string), "You has gived %d$ to %s",moneyplus, moneyplayername);
SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
FcukIt_GivePlayerMoney(moneyplayer, moneyplus);
}
}
return 1;
}


/*if (strcmp(cmd, "/amoneyall", true)==0) {
//new tmp[256];

//new moneyplus;
//new string[256];
tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
						SendClientMessage(playerid, COLOR_RED, ">>Invalid money amount");
			} else {
moneyplus = strval(tmp);
format(string, sizeof(string), ">>You has gived %d$ to all",moneyplus);
SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
for (new i = 0; i < MAX_PLAYERS; i++)
{
    if (IsPlayerConnected(i)) {
FcukIt_GivePlayerMoney(i, moneyplus);
}
}


}
	    return 1;
	}*/

else if (strcmp(cmd, "/atel-to-me", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];
new Float:X, Float:Y, Float:Z;
new string[256];
new telplayer;
tmp = strtok(cmdtext, idx);
telplayer = strval(tmp);
new telplayername[MAX_PLAYER_NAME];
GetPlayerName(telplayer,telplayername,sizeof(telplayername));
new adminname[MAX_PLAYER_NAME];
GetPlayerName(playerid,adminname,sizeof(adminname));
GetPlayerPos(playerid, X,Y,Z);
if(IsPlayerInAnyVehicle(playerid)) {
new VehicleID;
VehicleID = GetPlayerVehicleID(telplayer);
SetVehiclePos(VehicleID,X,Y,Z);
} else {
SetPlayerPos(telplayer,X,Y,Z);
}
format(string, sizeof(string), ">>You has teleported %s to You.",telplayername);
SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
format(string, sizeof(string), ">>You has beed teleported to %s",adminname);
SendClientMessage(telplayer, COLOR_LIGHTBLUE, string);


	    return 1;
	}

else if (strcmp(cmd, "/aa", true)==0 && IsPlayerAdmin(playerid)) {
		if(IsPlayerAdmin(playerid)) {

			new tmp[256];
		    new senderName[MAX_PLAYER_NAME];
		    new string[256];



			strmid(tmp,cmdtext,3,strlen(cmdtext));

			GetPlayerName(playerid, senderName, sizeof(senderName));
			format(string, sizeof(string),">>%s: %s", senderName, tmp);
for (new i = 0; i < MAX_PLAYERS; i++)
{
    if (IsPlayerConnected(i)) {
        if (IsPlayerAdmin(i)) {
            SendClientMessage(i, COLOR_GREEN, string);
        }
    }
}
			} else {
			SendClientMessage(playerid, COLOR_RED, ">>You are not Admin!!");
   }
  }


 }
if (strcmp(cmd, "/atel-me-to", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];
new Float:X, Float:Y, Float:Z;
new string[256];
new telplayer;
tmp = strtok(cmdtext, idx);
telplayer = strval(tmp);
new telplayername[MAX_PLAYER_NAME];
GetPlayerName(telplayer,telplayername,sizeof(telplayername));
new adminname[MAX_PLAYER_NAME];
GetPlayerName(playerid,adminname,sizeof(adminname));
GetPlayerPos(telplayer, X,Y,Z);
if(IsPlayerInAnyVehicle(playerid)) {
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,X,Y,Z);
} else {
SetPlayerPos(playerid,X,Y,Z);
}
format(string, sizeof(string), ">>You has been teleported to %s.",telplayername);
SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
format(string, sizeof(string), ">>%s has been teleported to You",adminname);
SendClientMessage(telplayer, COLOR_LIGHTBLUE, string);


	    return 1;
	}

		if(strcmp(cmd, "/asethealth", true) == 0 && IsPlayerAdmin(playerid)) {
		    new tmp[256];
		    new Float:health;
		    new giveplayer;
			tmp = strtok(cmdtext, idx);
			giveplayer = strval(tmp);
			GetPlayerName(strval(tmp),giveplayername,sizeof(giveplayername));
			if(!strlen(tmp)) {
					SendClientMessage(playerid,COLOR_RED, ">>Usage: /asethealth [playerID] [Health]");
			} else {
				if(!IsPlayerConnected(strval(tmp))) {
					SendClientMessage(playerid,COLOR_RED, ">>Invalid Player id.");
				} else {
					tmp = strtok(cmdtext, idx);
					health = strval(tmp);
					if(health > 100 || health < 1) {
					SendClientMessage(playerid,COLOR_RED, ">>Health must be between 1 and 100.");
					} else {
						if(!health) {
					SendClientMessage(playerid,COLOR_RED, ">>Usage: /asethealth [playerID] [Health]");
						} else {
						    SetPlayerHealth(giveplayer,health);
						    new tempstr[256];
						    format(tempstr, sizeof(tempstr), "You have set %s's health to  %.0f.",giveplayername,health);
					SendClientMessage(playerid,COLOR_LIGHTBLUE, tempstr);
						}
					}
				}
			}
			return 1;
		}

		else if(strcmp(cmd, "/akill", true) == 0 && IsPlayerAdmin(playerid)) {
		    new tmp[256];
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
					SendClientMessage(playerid,COLOR_LIGHTBLUE, ">>Usage: /akill ");
			} else {
				if(!IsPlayerConnected(strval(tmp))) {
					SendClientMessage(playerid,COLOR_LIGHTBLUE, ">>Invalid Player ID to murder.");
				} else {
				    SetPlayerHealth(strval(tmp),0);
				    new tempstr[256];
				    GetPlayerName(strval(tmp),giveplayername,sizeof(giveplayername));
				    GetPlayerName(playerid,thisplayer,sizeof(thisplayer));
					format(tempstr, sizeof(tempstr), ">>%s has been administratively murdered by %s.",giveplayername,thisplayer);
					SendClientMessageToAll(COLOR_RED,tempstr);
				}
			}
			return 1;
		}

	if (strcmp(cmd, "/aremove", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];
new remplayer;
new string[256];
new remplayername[MAX_PLAYER_NAME];
tmp = strtok(cmdtext, idx);
remplayer = strval(tmp);
RemovePlayerFromVehicle(remplayer);
GetPlayerName(remplayer,remplayername,sizeof(remplayername));
format(string, sizeof(string), ">>%s has been removed from vechicle by %s", remplayername, thisplayer);
SendClientMessageToAll(COLOR_RED, string);


	    return 1;
	}

else if (strcmp(cmd, "/acolor", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];
new tmp2[256];
new colorplayer;
new colorplayername[MAX_PLAYER_NAME];
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) {
			SendClientMessage(playerid,COLOR_LIGHTBLUE, ">>Usage: /acolor [PlayerID] [Color]");
} else {
colorplayer = strval(tmp);
}
GetPlayerName(colorplayer,colorplayername,sizeof(colorplayername));
tmp2 = strtok(cmdtext, idx);
new color;
color = strval(tmp2);
if(color == 1){
SetPlayerColor(colorplayer, COLOR_GREY);
} else if(color == 2){
SetPlayerColor(colorplayer, COLOR_GREEN);
} else if(color == 3){
SetPlayerColor(colorplayer, COLOR_RED);
} else if(color == 4){
SetPlayerColor(colorplayer, COLOR_YELLOW);
} else if(color == 5){
SetPlayerColor(colorplayer, COLOR_WHITE);
} else if(color == 6){
SetPlayerColor(colorplayer, COLOR_BLUE);
} else if(color == 7){
SetPlayerColor(colorplayer, COLOR_ORANGE);
} else {
SendClientMessage(playerid, COLOR_RED, ">>Invalid color : to get avialable colors type /acolors");
}

	    return 1;
	}

	if (strcmp(cmd, "/acolors", true)==0 && IsPlayerAdmin(playerid)) {
SendClientMessage(playerid, COLOR_GREEN, ">>Avialable colors:");
SendClientMessage(playerid, COLOR_GREEN, ">>1 = GREY , 2 = GREEN");
SendClientMessage(playerid, COLOR_GREEN, ">>3 = RED , 4 = YELLOW");
SendClientMessage(playerid, COLOR_GREEN, ">>5 = WHITE , 6 = BLUE");
SendClientMessage(playerid, COLOR_GREEN, ">>7 = ORANGE");

	    return 1;
	}
	

	

	if (strcmp(cmd, "/aparalyze", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];

new parplayer;
new parplayername[MAX_PLAYER_NAME];
new string[256];
tmp = strtok(cmdtext, idx);
parplayer = strval(tmp);
TogglePlayerControllable(parplayer, 0);
GetPlayerName(parplayer,parplayername,sizeof(parplayername));
format(string, sizeof(string), ">>%s has been paralyzed by %s", parplayername, thisplayer);
SendClientMessageToAll(COLOR_GREEN, string);

	    return 1;
	}


	if (strcmp(cmd, "/adeparalyze", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];

new parplayer;
new parplayername[MAX_PLAYER_NAME];
new string[256];
tmp = strtok(cmdtext, idx);
parplayer = strval(tmp);
TogglePlayerControllable(parplayer, 1);
GetPlayerName(parplayer,parplayername,sizeof(parplayername));
format(string, sizeof(string), ">>%s has been deparalyzed by %s", parplayername, thisplayer);
SendClientMessageToAll(COLOR_GREEN, string);

	    return 1;
	}


	if (strcmp(cmd, "/aresetmoney", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];

new resetplayer;
tmp = strtok(cmdtext, idx);
resetplayer = strval(tmp);
ResetPlayerMoney(resetplayer);

	    return 1;
	}
	
	if (strcmp(cmd, "/aonlineadmins", true)==0) {
new string[256];
new adminsonline = 0;
for (new i = 0; i < MAX_PLAYERS; i++)
{
    if (IsPlayerConnected(i)) {
        if (IsPlayerAdmin(i)) {
            adminsonline == adminsonline ++;
        }
	}
}
if (adminsonline == 0){
SendClientMessage(playerid, COLOR_GREEN, "There is no admins.");
} else if (adminsonline == 1){
format(string, sizeof(string), "There is only one admin online.");
SendClientMessage(playerid, COLOR_GREEN, string);
} else if (adminsonline > 1){
format(string, sizeof(string), "There are %d admins online.", adminsonline);
SendClientMessage(playerid, COLOR_GREEN, string);
}
	    return 1;
	}
	

	if(strcmp(cmd, "/aclearchat", true)==0 && IsPlayerAdmin(playerid)){
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");


	    return 1;
	}
	
	if (strcmp(cmd, "/acc", true)==0 && IsPlayerAdmin(playerid)) {
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");
SendClientMessageToAll(COLOR_RED, " ");


	    return 1;
	}

	if (strcmp(cmd, "/aresetweapon", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];

new resetwplayer;
tmp = strtok(cmdtext, idx);
resetwplayer = strval(tmp);
ResetPlayerWeapons(resetwplayer);

	    return 1;
	}

	
		if (strcmp(cmd, "/agiveweapon", true)==0 && IsPlayerAdmin(playerid)) {
new tmp[256];
new weapplayer;
new ammo;
new weapon;
tmp = strtok(cmdtext, idx);
weapplayer = strval(tmp);
tmp = strtok(cmdtext, idx);
weapon = strval(tmp);
tmp = strtok(cmdtext, idx);
ammo = strval(tmp);
if(weapon > 1 || weapon < 17 || weapon > 21 || weapon < 46) {
GivePlayerWeapon(weapplayer, weapon, ammo);
} else {
SendClientMessage(playerid , COLOR_RED, ">>Invalid weapon ID");
}
	    return 1;
	}
	
		if (strcmp(cmd, "/aabout", true)==0 && IsPlayerAdmin(playerid)) {
SendClientMessage(playerid, COLOR_LIGHTBLUE, ">>This is AeroAdmin administartion script");
SendClientMessage(playerid, COLOR_LIGHTBLUE, ">>Coded by Luby");
SendClientMessage(playerid, COLOR_LIGHTBLUE, ">>Betatesters : Mysz, DeadSoul, Diablos, DmX");
SendClientMessage(playerid, COLOR_LIGHTBLUE, ">>Aero Programming Group : Luby, DeadSoul,  Mysz.");
SendClientMessage(playerid, COLOR_LIGHTBLUE, ">>Very thanks for using our AeroAdmin.");
SendClientMessage(playerid, COLOR_LIGHTBLUE, ">>The Best Regards from Luby & Aero Programming Group.");
	    return 1;
	} else if(IsPlayerAdmin(playerid)){
//	SendClientMessage(playerid, COLOUR_WHITE, "SERVER: Unknown AeroTools Command. Type /aerohelp for get avialable commands.");
}

return 0;
}
/*strtok(const string[], &index)
{
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
}*/
public con3(){
new string[256];
format(string, sizeof(string), "Connecting to 127.0.0.1:7777..");
SendClientMessageToAll(COLOR_SYSGREY, string);
}
public connection()
{
	new string[256];
	format(string, sizeof(string), "Connection success. Loading network game...");
	SendClientMessageToAll(COLOR_SYSGREY, string);
	SetTimer("con2", 3000, 0);
}

public con2()
{
	new string[256];
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i)){

			new iname[MAX_PLAYER_NAME];
			GetPlayerName(i,iname,sizeof(iname));
			format(string, sizeof(string), "*** %s joined the server.", iname);
			SendClientMessageToAll(COLOR_SYSGREY, string);
		}
	}


}
public lost2(){
new string[256];
format(string, sizeof(string), "Lost connection to the server.");
SendClientMessageToAll(COLOR_SYSGREY, string);
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i)){

lost[i]=1;
		}
	}
	}

