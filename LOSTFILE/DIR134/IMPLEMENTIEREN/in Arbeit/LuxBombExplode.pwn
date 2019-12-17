/*
================================================================================
|          Title: LuxurY Bomb Explosion (Bomb shop + Lots of bomb commands)    |
|          Version: 0.1b                                                       |
|          Date: 14 June 2007                                                  |
|          Creator: LuxurY                                                     |
|          Language: English                                                   |
|                                                                              |
| (c) LuxurY scripts 2007                                                      |
================================================================================
________________________________________________________________________________

							   888
                                 88
                                 88
                              88[ ]88
                             8888[ ]8888
                           8888888[ ]88888
                         8888888888[ ]888888   88
                    8888888888888888[ ]888888888
                   88    8888888888[ ]888888
                           8888888[ ]88888
                             8888[ ]8888
                              88[ ]88
                                88
                                88
                                 888

________________________________________________________________________________
*/
//includes
#include <a_samp>
#include <dini>
#include <dutils>
#include <dudb>

//color defines
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_ORANGE 0xFF9900AA

//filterscript configuration
new statusfs[10] = { "v.0.1b" };
new allowbomb;

//player statuses
new bombarea[MAX_PLAYERS];
new Float:Xbombb[MAX_PLAYERS];
new Float:Ybombb[MAX_PLAYERS];
new Float:Zbombb[MAX_PLAYERS];
new curvplt[MAX_PLAYERS];
new curvpld[MAX_PLAYERS];

//vehicles statuses
new bombhave[MAX_VEHICLES];
new bombt[MAX_VEHICLES];
new bombd[MAX_VEHICLES];

//timerbomb configuration
new timebomb = 11;

//forwards
forward BombCheck();
forward AreaCheck();
forward AllowBomb();

public OnFilterScriptInit()
{
	print("\n----------------------------------");
	printf("  Bomb Explosion %s by LuxurY",statusfs);
	print("----------------------------------\n");
	SetTimer("AreaCheck",1000,1);
	SetTimer("BombCheck",2000,1);
	SetTimer("AllowBomb",1000,1);
	allowbomb = 0;
	return 1;
}

stock IsPlayerInCubeArea(playerid, Float:minx, Float:maxx, Float:miny, Float:maxy, Float:minz, Float:maxz)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if (x > minx && x < maxx && y > miny && y < maxy && z > minz && z < maxz) return 1;
	return 0;
}

public OnPlayerSpawn(playerid) {
	Xbombb[playerid] = 0;
	Ybombb[playerid] = 0;
	Zbombb[playerid] = 0;
	bombarea[playerid] = 1;
	curvplt[playerid] = 999;
	curvpld[playerid] = 999;
	return 1;
	}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new tmp[255];
	new playername[24];
	GetPlayerName(playerid,playername,sizeof(playername));
	new cmd[256], idx;
	cmd = strtok(cmdtext, idx);
	new Float:X, Float:Y, Float:Z;
	new VID = GetPlayerVehicleID(playerid);

    if(strcmp(cmd, "/bombcmd", true) == 0) {
    SendClientMessage(playerid, COLOR_YELLOW, "=========== LuxurY Bomb Explosion Commands ===========");
    SendClientMessage(playerid, COLOR_YELLOW, " /killb - kill youself with bomb");
    SendClientMessage(playerid, COLOR_YELLOW, " /bt - to create timer on vehicle");
    SendClientMessage(playerid, COLOR_YELLOW, " /bd - to create detomator on vehicle");
    SendClientMessage(playerid, COLOR_YELLOW, " /cb - to create bomb on place");
    SendClientMessage(playerid, COLOR_YELLOW, " /dv - to activate detomator on vehicle");
    SendClientMessage(playerid, COLOR_YELLOW, " /db - to explose bomb");
    SendClientMessage(playerid, COLOR_YELLOW, " To deactivate: /ccb - bomb /cct - timer /ccd - detonator");
    SendClientMessage(playerid, COLOR_YELLOW, " /bs - teleport to the Bomb Shop");
    SendClientMessage(playerid, COLOR_YELLOW, "____________________________________________________________________");
	return 1;
	}
 	if(strcmp(cmd, "/abombcmd", true) == 0) {
    SendClientMessage(playerid, COLOR_YELLOW, "=========== LuxurY Bomb Explosion Commands Admin ===========");
    SendClientMessage(playerid, COLOR_YELLOW, " /setbt [playerid] [time] [0(no) or 1(yes)] - to create timer on player's vehicle");
    SendClientMessage(playerid, COLOR_YELLOW, " /setbd [playerid] [0(no) or 1(yes)] - to create detonator on player's vehicle");
    SendClientMessage(playerid, COLOR_YELLOW, " /explose [playerid] - explose player");
    SendClientMessage(playerid, COLOR_YELLOW, " /abomb - allow/disallow automatically creating bombs on vehicles");
    SendClientMessage(playerid, COLOR_YELLOW, " /setbombv [playerid] - to create bomb on player's vehicle");
    SendClientMessage(playerid, COLOR_YELLOW, "____________________________________________________________________");
	return 1;
	}
	if(strcmp(cmd, "/bt", true) == 0) {
	if (bombhave[VID] == 1) {
	new time;
	tmp = strtok(cmdtext, idx);
	if(!strlen(tmp)) {
	SendClientMessage(playerid, 0xFFFFFFAA, "Usage: /bt [time]");
	return 1;
	}
	time = strval(tmp);
	curvplt[playerid] = VID;
 	bombt[VID] = 1;
 	timebomb = time;
 	bombhave[VID] = 0;
 	SendClientMessage(playerid, 0xFFFFFFAA, "Timer has been activated. To cancel type /cct");
 	SetTimer("BombCheck",2000,1);
 	} else {
 	SendClientMessage(playerid,COLOR_RED,"There is no bomb on you vehicle!");
 	}
 	return 1;
 	}
 	
 	if(strcmp(cmd, "/setbt", true) == 0) {
	new time, plidd, boolt;
	tmp = strtok(cmdtext, idx);
	new pliddv = GetPlayerVehicleID(plidd);
	if(!strlen(tmp)) {
	SendClientMessage(playerid, 0xFFFFFFAA, "Usage: /setbt [playerid] [time] [0 or 1]");
	return 1;
	}
	plidd = strval(tmp);
	tmp = strtok(cmdtext, idx);
	if(!strlen(tmp)) {
	SendClientMessage(playerid, 0xFFFFFFAA, "Usage: /setsbt [playerid] [time] [0 or 1]");
	return 1;
	}
	time = strval(tmp);
	tmp = strtok(cmdtext, idx);
	if(!strlen(tmp)) {
	SendClientMessage(playerid, 0xFFFFFFAA, "Usage: /setsbt [playerid] [time] [0 or 1]");
	return 1;
	}
	boolt = strval(tmp);
	if(IsPlayerAdmin(playerid)) {
 	if(IsPlayerInAnyVehicle(plidd)) {
	curvplt[playerid] = pliddv;
 	bombt[pliddv] = boolt;
 	timebomb = time;
 	} else {
 	SendClientMessage(playerid,COLOR_RED,"This player is not in vehicle!");
 	}}
	else {
	SendClientMessage(playerid,0xFF0000AA,"You are not an admin!");
	}
	return 1;
	}
	
	if(strcmp(cmd, "/setbd", true) == 0) {
	new boold, plidd;
	tmp = strtok(cmdtext, idx);
	new pliddv = GetPlayerVehicleID(plidd);
	if(!strlen(tmp)) {
	SendClientMessage(playerid, 0xFFFFFFAA, "Usage: /setbd [playerid] [0 or 1]");
	return 1;
	}
	plidd = strval(tmp);
	tmp = strtok(cmdtext, idx);
	if(!strlen(tmp)) {
	SendClientMessage(playerid, 0xFFFFFFAA, "Usage: /setsbd [playerid] [0 or 1]");
	return 1;
	}
	boold = strval(tmp);
	if(IsPlayerAdmin(playerid)) {
	if(IsPlayerInAnyVehicle(plidd)) {
	curvplt[playerid] = pliddv;
 	bombd[pliddv] = boold;
 	} else {
 	SendClientMessage(playerid,COLOR_RED,"This player is not in vehicle!");
 	}}
	else {
	SendClientMessage(playerid,0xFF0000AA,"You are not an admin!");
	}
	return 1;
	}
	
 	if(strcmp(cmd, "/bd", true) == 0) {
 	if (bombhave[VID] == 1) {
 	GetVehiclePos(VID,X,Y,Z);
 	bombd[VID] = 1;
 	curvpld[playerid] = VID;
	bombhave[VID] = 0;
	SendClientMessage(playerid, 0xFFFFFFAA, "Detomator has been activated. To cancel type /ccd");
 	} else {
 	SendClientMessage(playerid,COLOR_RED,"There is no bomb on you vehicle!");
 	}
 	return 1;
 	}
 	
  	if(strcmp(cmd, "/dv", true) == 0) {
  	if(curvpld[playerid] == 999) {
  	SendClientMessage(playerid,COLOR_RED,"You didn't create detomator on vehicle!");
  	} else {
  	GetVehiclePos(curvpld[playerid],X,Y,Z);
	CreateExplosion(X,Y,Z,6,2);
	CreateExplosion(X,Y,Z,7,2);
	SendClientMessage(playerid, 0xFFFFFFAA, "Vehicle has been explosed");
	}
	return 1;
	}
	
	if(strcmp(cmd, "/killb", true) == 0) {
	GetPlayerPos(playerid,X,Y,Z);
	if (IsPlayerInAnyVehicle(playerid)) {
	CreateExplosion(X,Y,Z,6,2);
	CreateExplosion(X,Y,Z,7,2);
	SetVehicleHealth(VID,10);
	} else {
	SetPlayerHealth(playerid,10);
	CreateExplosion(X,Y,Z,6,2);
	CreateExplosion(X,Y,Z,7,2);
	SendClientMessage(playerid, 0xFFFFFFAA, "You explosed.");
	}
	return 1;
	}
	
 	if(strcmp(cmd, "/cb", true) == 0) {
	GetPlayerPos(playerid,X,Y,Z);
	Xbombb[playerid] = X;
	Ybombb[playerid] = Y;
	Zbombb[playerid] = Z;
	CreateObject(1252,X,Y + 0.5,Z,0,0,0);
	SendClientMessage(playerid,COLOR_GREEN,"Bomb created! To explose type /db");
	return 1;
	}
	
	if(strcmp(cmd, "/db", true) == 0) {
	if (Xbombb[playerid] == 0 || Ybombb[playerid] == 0 || Zbombb[playerid] == 0) {
	SendClientMessage(playerid,COLOR_RED,"You didn't create bomb!");
	} else {
	CreateExplosion(Xbombb[playerid],Ybombb[playerid],Zbombb[playerid],6,1);
	CreateExplosion(Xbombb[playerid],Ybombb[playerid],Zbombb[playerid],7,1);
	Xbombb[playerid] = 0;
	Ybombb[playerid] = 0;
	Zbombb[playerid] = 0;
	SendClientMessage(playerid,COLOR_GREEN,"Bomb has been explosed.");
	}
	return 1;
	}
	
	if(strcmp(cmd, "/ccb", true) == 0) {
	if (Xbombb[playerid] == 0 || Ybombb[playerid] == 0 || Zbombb[playerid] == 0) {
	SendClientMessage(playerid,COLOR_YELLOW,"There is nothing to deactivate.");
	} else {
	Xbombb[playerid] = 0;
	Ybombb[playerid] = 0;
	Zbombb[playerid] = 0;
	SendClientMessage(playerid,COLOR_YELLOW,"Bomb has been deactivated.");
	}
	return 1;
	}
	
	if(strcmp(cmd, "/cct", true) == 0) {
	new v = curvplt[playerid];
	if (bombt[v] == 0 || curvplt[playerid] == 999) {
	SendClientMessage(playerid,COLOR_YELLOW,"There is nothing to deactivate.");
	} else {
	bombt[v] = 0;
	curvplt[playerid] = 999;
	SendClientMessage(playerid,COLOR_YELLOW,"Timer on vehicle has been deactivated.");
	}
	return 1;
	}
	
	if(strcmp(cmd, "/ccd", true) == 0) {
 	new v = curvpld[playerid];
	if (bombd[v] == 0 || curvpld[playerid] == 999) {
	SendClientMessage(playerid,COLOR_YELLOW,"There is nothing to deactivate.");
	} else {
	bombd[v] = 0;
	curvpld[playerid] = 999;
	SendClientMessage(playerid,COLOR_YELLOW,"Detonator on vehicle has been deactivated.");
	}
	return 1;
	}
	
	if(strcmp(cmd, "/explose", true) == 0 && IsPlayerAdmin(playerid)) {
	new plid;
	tmp = strtok(cmdtext, idx);
	if(!strlen(tmp)) {
	SendClientMessage(playerid, COLOR_WHITE, "Usage: /explose [playerid]");
	return 1;
	}
	plid = strval(tmp);
	GetPlayerPos(plid,X,Y,Z);
	if (IsPlayerInAnyVehicle(plid)) {
	new plidv = GetPlayerVehicleID(plid);
	SetVehicleHealth(plidv,10);
	CreateExplosion(X,Y,Z,6,2);
	CreateExplosion(X,Y,Z,7,2);
	} else {
	SetPlayerHealth(plid,10);
	CreateExplosion(X,Y,Z,6,2);
	CreateExplosion(X,Y,Z,7,2);
	}
	return 1;
	}
	
	if(strcmp(cmd, "/abomb", true) == 0 && IsPlayerAdmin(playerid)) {
	if (allowbomb == 0) {
	allowbomb = 1;
	SendClientMessageToAll(COLOR_GREEN,"Now all vehicles will always have bombs");
	} else {
	allowbomb = 0;
	SendClientMessageToAll(COLOR_RED, "Bomb can be bought in Bomb Shop. To teleport type /bs");
	}
	return 1;
	}
	
	if(strcmp(cmd, "/setbombv", true) == 0 && IsPlayerAdmin(playerid)) {
	new plid;
	tmp = strtok(cmdtext, idx);
	if(!strlen(tmp)) {
	SendClientMessage(playerid, COLOR_WHITE, "Usage: /setbombv [playerid]");
	return 1;
	}
	plid = strval(tmp);
	GetPlayerPos(plid,X,Y,Z);
	if (IsPlayerInAnyVehicle(plid)) {
	new plidv = GetPlayerVehicleID(plid);
	bombhave[plidv] = 1;
	} else {
 	SendClientMessage(playerid,COLOR_RED,"This player is not in vehicle!");
	}
	return 1;
	}
	
	if(strcmp(cmdtext, "/bs", true) == 0) {
	if(IsPlayerInAnyVehicle(playerid)) {
	SetVehiclePos(VID, 1842, -1852.8, 14);
	} else {
	SetPlayerPos(playerid, 1842, -1852.8, 14);
	}
	return 1;
	}
	return 0;
	}

public BombCheck() {
	for (new i = 0; i < MAX_PLAYERS; i++) {
	new iname[24];
	GetPlayerName(i,iname,sizeof(iname));
	new bv = curvplt[i];
	//new bv = dini_Int("bombt.ini",iname);
	if (curvplt[i] == 999) {
	return 1;
	} else {
	if (bombt[bv] == 1) {
	if (timebomb > 0) {
	timebomb--;
	new string[255];
	format(string,sizeof(string),"Explosion: %d",timebomb);
	SendClientMessageToAll(COLOR_RED,string);
	if (timebomb == 1) {
	new Float:X, Float:Y, Float:Z;
	GetVehiclePos(bv,X,Y,Z);
	CreateExplosion(X,Y,Z,6,1);
	CreateExplosion(X,Y,Z,7,1);
	} else {
	new kt = SetTimer("BombCheck",2000,1);
	KillTimer(kt);
	}
	}
	}
	}
	}
	return 1;
	}
	
public AreaCheck() {
	for (new i=0; i < MAX_PLAYERS; i++) {
	new v = GetPlayerVehicleID(i);
	if (IsPlayerInCubeArea(i,1843,1857,-1860,-1852.8,13,17.5)) {
	if (bombarea[i] == 1) {
	if (GetPlayerMoney(i) > 499) {
	if (IsPlayerInAnyVehicle(i)) {
	SendClientMessage(i,COLOR_GREEN,"======== Wellcome to the Bomb Shop ========");
	SendClientMessage(i,COLOR_GREEN,"* Bomb has been installed.");
	SendClientMessage(i,COLOR_GREEN,"* To create timet type /bt [time]");
	SendClientMessage(i,COLOR_GREEN,"* To create detomator type /bd");
	SendClientMessage(i,COLOR_GREEN,"* Other commands: /bombcmd");
	bombarea[i] = 0;
	bombhave[v] = 1;
	} else {
	SendClientMessage(i,COLOR_GREEN,"You are not in vehicle!");
	bombarea[i] = 0;
	}} else {
	SendClientMessage(i,COLOR_GREEN,"Not enough money!");
	bombarea[i] = 0;
 	}}} else {
	bombarea[i] = 1;
	}}
	return 1;
	}
	
public AllowBomb() {
	for (new i=0; i < MAX_PLAYERS; i++) {
	if(allowbomb == 1) {
	new av = GetPlayerVehicleID(i);
	bombhave[av] = 1;
	}
	}
	return 1;
	}
