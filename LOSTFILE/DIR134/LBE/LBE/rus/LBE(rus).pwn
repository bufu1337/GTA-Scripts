/*
================================================================================
|          Название: LuxurY Bomb Explosion (Bomb shop + Lots of bomb commands) |
|          Версия: 0.1b                                                        |
|          Дата: 14 June 2007                                                  |
|          Создатель: LuxurY                                                   |
|          Язык: Русский                                                       |
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
    SendClientMessage(playerid, COLOR_YELLOW, " /killb - самоуничтожиться бомбой");
    SendClientMessage(playerid, COLOR_YELLOW, " /bt - установить на машину таймер с бомбой");
    SendClientMessage(playerid, COLOR_YELLOW, " /bd - установить на машину детонатор");
    SendClientMessage(playerid, COLOR_YELLOW, " /cb - создать бомбу на определенном месте");
    SendClientMessage(playerid, COLOR_YELLOW, " /dv - активировать детонатор на машине (взорвать)");
    SendClientMessage(playerid, COLOR_YELLOW, " /db - взорвать бомбу");
    SendClientMessage(playerid, COLOR_YELLOW, " /ccb - деак. бомбу /cct - деак. таймер /ccd - деак. детонатор");
    SendClientMessage(playerid, COLOR_YELLOW, " /bs - телепорт в Bomb Shop");
    SendClientMessage(playerid, COLOR_YELLOW, "____________________________________________________________________");
	return 1;
	}
 	if(strcmp(cmd, "/abombcmd", true) == 0) {
    SendClientMessage(playerid, COLOR_YELLOW, "=========== LuxurY Bomb Explosion Commands Admin ===========");
    SendClientMessage(playerid, COLOR_YELLOW, " /setbt [playerid] [время] [0(нет) или 1(да)] - установить таймер на машине опр. игрока");
    SendClientMessage(playerid, COLOR_YELLOW, " /setbd [playerid] [0(нет) или 1(да)] - установить детонатор на машине опр. игрока");
    SendClientMessage(playerid, COLOR_YELLOW, " /explose [playerid] - взорвать опр. игрока");
    SendClientMessage(playerid, COLOR_YELLOW, " /abomb - разрешить/запретить автоматического включения бомб у всех машин");
    SendClientMessage(playerid, COLOR_YELLOW, " /setbombv [playerid] - установить на машине опр. игрока бомбу");
    SendClientMessage(playerid, COLOR_YELLOW, "____________________________________________________________________");
	return 1;
	}
	if(strcmp(cmd, "/bt", true) == 0) {
	if (bombhave[VID] == 1) {
	new time;
	tmp = strtok(cmdtext, idx);
	if(!strlen(tmp)) {
	SendClientMessage(playerid, 0xFFFFFFAA, "* Использование: /bt [время]");
	return 1;
	}
	time = strval(tmp);
	curvplt[playerid] = VID;
 	bombt[VID] = 1;
 	timebomb = time;
 	bombhave[VID] = 0;
 	SendClientMessage(playerid, 0xFFFFFFAA, "* Таймер активирован. Для отмены напиши /cct");
 	SetTimer("BombCheck",2000,1);
 	} else {
 	SendClientMessage(playerid,COLOR_RED,"* На твоей машине не установлена бомба");
 	}
 	return 1;
 	}
 	
 	if(strcmp(cmd, "/setbt", true) == 0) {
	new time, plidd, boolt;
	tmp = strtok(cmdtext, idx);
	new pliddv = GetPlayerVehicleID(plidd);
	if(!strlen(tmp)) {
	SendClientMessage(playerid, 0xFFFFFFAA, "* Использование: /setbt [playerid] [время] [0 или 1]");
	return 1;
	}
	plidd = strval(tmp);
	tmp = strtok(cmdtext, idx);
	if(!strlen(tmp)) {
	SendClientMessage(playerid, 0xFFFFFFAA, "* Использование: /setsbt [playerid] [время] [0 или 1]");
	return 1;
	}
	time = strval(tmp);
	tmp = strtok(cmdtext, idx);
	if(!strlen(tmp)) {
	SendClientMessage(playerid, 0xFFFFFFAA, "* Использование: /setsbt [playerid] [время] [0 или 1]");
	return 1;
	}
	boolt = strval(tmp);
	if(IsPlayerAdmin(playerid)) {
 	if(IsPlayerInAnyVehicle(plidd)) {
	curvplt[playerid] = pliddv;
 	bombt[pliddv] = boolt;
 	timebomb = time;
 	} else {
 	SendClientMessage(playerid,COLOR_RED,"* Этот игрок не в машине");
 	}}
	else {
	SendClientMessage(playerid,0xFF0000AA,"* Ты не админ!");
	}
	return 1;
	}
	
	if(strcmp(cmd, "/setbd", true) == 0) {
	new boold, plidd;
	tmp = strtok(cmdtext, idx);
	new pliddv = GetPlayerVehicleID(plidd);
	if(!strlen(tmp)) {
	SendClientMessage(playerid, 0xFFFFFFAA, "* Использование: /setbd [playerid] [0 или 1]");
	return 1;
	}
	plidd = strval(tmp);
	tmp = strtok(cmdtext, idx);
	if(!strlen(tmp)) {
	SendClientMessage(playerid, 0xFFFFFFAA, "* Использование: /setsbd [playerid] [0 или 1]");
	return 1;
	}
	boold = strval(tmp);
	if(IsPlayerAdmin(playerid)) {
	if(IsPlayerInAnyVehicle(plidd)) {
	curvplt[playerid] = pliddv;
 	bombd[pliddv] = boold;
 	} else {
 	SendClientMessage(playerid,COLOR_RED,"* Этот игрок не в машине");
 	}}
	else {
	SendClientMessage(playerid,0xFF0000AA,"* Ты не админ!");
	}
	return 1;
	}
	
 	if(strcmp(cmd, "/bd", true) == 0) {
 	if (bombhave[VID] == 1) {
 	GetVehiclePos(VID,X,Y,Z);
 	bombd[VID] = 1;
 	curvpld[playerid] = VID;
	bombhave[VID] = 0;
	SendClientMessage(playerid, 0xFFFFFFAA, "* Детонатор установлен. Для отмены напиши /ccd");
 	} else {
 	SendClientMessage(playerid,COLOR_RED,"* На твоей машине не установлена бомба");
 	}
 	return 1;
 	}
 	
  	if(strcmp(cmd, "/dv", true) == 0) {
  	if(curvpld[playerid] == 999) {
  	SendClientMessage(playerid,COLOR_RED,"* Ты не устанавливал бомбу на машину");
  	} else {
  	GetVehiclePos(curvpld[playerid],X,Y,Z);
	CreateExplosion(X,Y,Z,6,2);
	CreateExplosion(X,Y,Z,7,2);
	SendClientMessage(playerid, 0xFFFFFFAA, "* Машина взорвана");
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
	SendClientMessage(playerid, 0xFFFFFFAA, "* Ты взорвался");
	}
	return 1;
	}
	
 	if(strcmp(cmd, "/cb", true) == 0) {
	GetPlayerPos(playerid,X,Y,Z);
	Xbombb[playerid] = X;
	Ybombb[playerid] = Y;
	Zbombb[playerid] = Z;
	CreateObject(1252,X,Y + 0.5,Z,0,0,0);
	SendClientMessage(playerid,COLOR_GREEN,"* Бомба установлена");
	return 1;
	}
	
	if(strcmp(cmd, "/db", true) == 0) {
	if (Xbombb[playerid] == 0 || Ybombb[playerid] == 0 || Zbombb[playerid] == 0) {
	SendClientMessage(playerid,COLOR_RED,"* Ты не установил бомбу!");
	} else {
	CreateExplosion(Xbombb[playerid],Ybombb[playerid],Zbombb[playerid],6,1);
	CreateExplosion(Xbombb[playerid],Ybombb[playerid],Zbombb[playerid],7,1);
	Xbombb[playerid] = 0;
	Ybombb[playerid] = 0;
	Zbombb[playerid] = 0;
	SendClientMessage(playerid,COLOR_GREEN,"* Вомба взорвана");
	}
	return 1;
	}
	
	if(strcmp(cmd, "/ccb", true) == 0) {
	if (Xbombb[playerid] == 0 || Ybombb[playerid] == 0 || Zbombb[playerid] == 0) {
	SendClientMessage(playerid,COLOR_YELLOW,"* Нечего деактивировать!");
	} else {
	Xbombb[playerid] = 0;
	Ybombb[playerid] = 0;
	Zbombb[playerid] = 0;
	SendClientMessage(playerid,COLOR_YELLOW,"* Бомба деактивирована");
	}
	return 1;
	}
	
	if(strcmp(cmd, "/cct", true) == 0) {
	new v = curvplt[playerid];
	if (bombt[v] == 0 || curvplt[playerid] == 999) {
	SendClientMessage(playerid,COLOR_YELLOW,"* Нечего деактивировать!");
	} else {
	bombt[v] = 0;
	curvplt[playerid] = 999;
	SendClientMessage(playerid,COLOR_YELLOW,"* Таймер на машине деактивирован");
	}
	return 1;
	}
	
	if(strcmp(cmd, "/ccd", true) == 0) {
 	new v = curvpld[playerid];
	if (bombd[v] == 0 || curvpld[playerid] == 999) {
	SendClientMessage(playerid,COLOR_YELLOW,"* Нечего деактивировать!");
	} else {
	bombd[v] = 0;
	curvpld[playerid] = 999;
	SendClientMessage(playerid,COLOR_YELLOW,"* Детонатор на машине деактивирован");
	}
	return 1;
	}
	
	if(strcmp(cmd, "/explose", true) == 0 && IsPlayerAdmin(playerid)) {
	new plid;
	tmp = strtok(cmdtext, idx);
	if(!strlen(tmp)) {
	SendClientMessage(playerid, COLOR_WHITE, "* Использование: /explose [playerid]");
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
	SendClientMessageToAll(COLOR_GREEN,"* Теперь у все машин всегда есть бомбы");
	} else {
	allowbomb = 0;
	SendClientMessageToAll(COLOR_RED, "* Бомбы нужно покупать в бомб шопе");
	}
	return 1;
	}
	
	if(strcmp(cmd, "/setbombv", true) == 0 && IsPlayerAdmin(playerid)) {
	new plid;
	tmp = strtok(cmdtext, idx);
	if(!strlen(tmp)) {
	SendClientMessage(playerid, COLOR_WHITE, "* Использование: /setbombv [playerid]");
	return 1;
	}
	plid = strval(tmp);
	GetPlayerPos(plid,X,Y,Z);
	if (IsPlayerInAnyVehicle(plid)) {
	new plidv = GetPlayerVehicleID(plid);
	bombhave[plidv] = 1;
	} else {
 	SendClientMessage(playerid,COLOR_RED,"* Этот игрок не в машине");
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
	format(string,sizeof(string)," До взрыва машины: %d",timebomb);
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
	SendClientMessage(i,COLOR_GREEN,"======== Добро пожаловать в Bomb Shop ========");
	SendClientMessage(i,COLOR_GREEN,"* Бомба успешно установлена");
	SendClientMessage(i,COLOR_GREEN,"* Для установки бомбы с таймером используй команду /bt [время]");
	SendClientMessage(i,COLOR_GREEN,"* Для установки бомбы с детонатором используй команду /bd");
	SendClientMessage(i,COLOR_GREEN,"* Прочие команды: /bombcmd");
	bombarea[i] = 0;
	bombhave[v] = 1;
	} else {
	SendClientMessage(i,COLOR_GREEN,"* Ты не в машине");
	bombarea[i] = 0;
	}} else {
	SendClientMessage(i,COLOR_GREEN,"* У тебя недостаточно денег");
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
