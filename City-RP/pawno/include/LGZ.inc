/*<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
^		    Title: LuxurY GangZones (LGZ)                                      ^
^		    Version: 1.3.2                                                       ^
^		    Reliase: 1 beta                                                    ^
^		    Date: 11 January 2008                                               ^
^		    Developer: LuxurY                                                  ^
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>*/

#include <a_samp>
#include <dini>

#define MAX_GZ 1024
#define GZ_FILESTATS "LGZ/LGZ.ini"
#define GZ_ZONEACC "LGZ/zone_%d.ini"

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_ORANGE 0xFF9900AA

forward GZ_OnPlayerEnter(playerid,zoneid);
forward GZ_OnPlayerLeave(playerid,zoneid);
forward GZ_OnPlayerCapture(playerid,zoneid);
forward GZ_OnPlayerGetMoney(playerid,amount);

//system
forward AreaCheck();
forward GZ_Cap();
forward CashPlayer(playerid);
forward GZ_BoundRemove(playerid,zoneid);

new Float:gzmas[MAX_GZ][4], codeGZ[3], gzel[MAX_GZ][MAX_PLAYERS], gztimer[MAX_GZ], gztime[MAX_GZ];
new gzcurpl[MAX_PLAYERS], gzmget, cashtime, adebugl, boundgz[MAX_PLAYERS][MAX_GZ], btim[MAX_PLAYERS];
new noowner[] = "x";

//locked 0 - none  1 - for capturing 2 - for enter

stock GZ_LoadLGZ() {
SetTimer("AreaCheck",1000,1);
SetTimer("GZ_Cap",1000,1);
if (adebugl == 1) {
print("[LGZ] Configs and timers loaded.");
}
codeGZ[1] = dini_Int(GZ_FILESTATS,"Tryed");
codeGZ[2] = dini_Int(GZ_FILESTATS,"Captured");
for (new i=0;i<=MAX_PLAYERS;i++) {
gzcurpl[i]=-1;
}
return 1;
}

stock GZ_SetTrueGZOwner(playerid) {
for (new gz=0;gz<=MAX_GZ;gz++) {
if (GZ_IsValidGZ(gz) == 1) {
new filetmp[256],pln[24],ast[256],strp[256];
format(filetmp,sizeof(filetmp),GZ_ZONEACC,gz);
GetPlayerName(playerid,pln,sizeof(pln));
format(strp,sizeof(strp),"%s",dini_Get(filetmp,"OwnerName"));
if(!strcmp(strp,udb_encode(pln), true)) {
GZ_WriteFileInfo(gz,"Owner",playerid);
format(ast,sizeof(ast),"* Your zone - %d",gz);
SendClientMessage(playerid,COLOR_GREEN,ast);
if (adebugl == 1) {
printf("[LGZ] Setting owner. %s zone - %d",pln,gz);
}}}}
return 1;
}

stock GZ_DeleteZoneTemp(playerid) {
for (new gz=0;gz<=MAX_GZ;gz++) {
if (GZ_IsValidGZ(gz) == 1 && GZ_GetZoneOwner(gz) == playerid) {
GZ_WriteFileInfo(gz,"Invader",-1);
GZ_WriteFileInfo(gz,"Owner",-1);
}}
new pln[24]; GetPlayerName(playerid,pln,sizeof(pln));
if (adebugl == 1) {
printf("[LGZ] Zone Temp %s deleted",pln);
}
return 1;
}

stock GZ_Create(name[],Float:minx,Float:miny,Float:maxx,Float:maxy,color) {
codeGZ[0] = GangZoneCount();
GangZoneCreate(Float:minx,Float:miny,Float:maxx,Float:maxy);
gzmas[codeGZ[0]][0] = Float:minx;
gzmas[codeGZ[0]][1] = Float:miny;
gzmas[codeGZ[0]][2] = Float:maxx;
gzmas[codeGZ[0]][3] = Float:maxy;
if (adebugl == 1) {
printf("[LGZ] Zone Created. ID - %d",codeGZ[0]);
}
GZ_FileNew(codeGZ[0]);
GZ_SetZoneColor(codeGZ[0],color);
GZ_SetZoneName(codeGZ[0],name);
new filetmp[256];
format(filetmp,sizeof(filetmp),GZ_ZONEACC,codeGZ[0]);
dini_FloatSet(filetmp,"minx",minx);
dini_FloatSet(filetmp,"miny",miny);
dini_FloatSet(filetmp,"maxx",maxx);
dini_FloatSet(filetmp,"maxy",maxy);
codeGZ[0]++;
if (!dini_Exists(GZ_FILESTATS)) {
dini_Create(GZ_FILESTATS);
dini_IntSet(GZ_FILESTATS,"ZoneCount",codeGZ[0]);
} else {
dini_IntSet(GZ_FILESTATS,"ZoneCount",codeGZ[0]);
}
return codeGZ[0];
}

stock GZ_Destroy(zoneid) {
if (GZ_IsValidGZ(zoneid) == 1) {
GangZoneDestroy(zoneid);
gzmas[zoneid][0] = 0;
gzmas[zoneid][1] = 0;
gzmas[zoneid][2] = 0;
gzmas[zoneid][3] = 0;
new filetmp[256]; format(filetmp,sizeof(filetmp),GZ_ZONEACC,zoneid);
dini_Remove(filetmp);
if (adebugl == 1) {
printf("[LGZ] Zone Destroyed. ID - %d",zoneid);
}
codeGZ[0]--;
if (!dini_Exists(GZ_FILESTATS)) {
dini_Create(GZ_FILESTATS);
dini_IntSet(GZ_FILESTATS,"ZoneCount",codeGZ[0]);
} else {
dini_IntSet(GZ_FILESTATS,"ZoneCount",codeGZ[0]);
}}
return zoneid;
}

stock GZ_IsValidGZ(zoneid) {
new result;
if (gzmas[zoneid][0] == 0 && gzmas[zoneid][1] == 0 && gzmas[zoneid][2] == 0 && gzmas[zoneid][3] == 0) {
result = 0;
} else {
result = 1;
}
return result;
}

stock GZ_IsPlayerInGZ(playerid,zoneid) {
new result;
if (IsPlayerInArea(playerid,gzmas[zoneid][0],gzmas[zoneid][2],gzmas[zoneid][1],gzmas[zoneid][3]) == 1 && GZ_IsValidGZ(zoneid) == 1) {
result = 1;
} else {
result = 0;
}
return result;
}

stock GZ_IsPlayerInAnyGZ(playerid) {
new result;
for (new gz=0;gz<MAX_GZ;gz++) {
if (IsPlayerInArea(playerid,gzmas[gz][0],gzmas[gz][2],gzmas[gz][1],gzmas[gz][3]) == 1  && GZ_IsValidGZ(gz) == 1) {
result = 1;
} else {
result = 0;
}}
return result;
}

stock GZ_GetPlayerGZIn(playerid) {
return gzcurpl[playerid];
}

stock GZ_GetZoneInvader(zoneid) {
return GZ_GetFileInfo(zoneid,"Invader");
}

stock GZ_GetZoneOwner(zoneid) {
return GZ_GetFileInfo(zoneid,"Owner");
}

stock GZ_Capture(playerid,zoneid,time,color) {
if (GZ_IsValidGZ(zoneid) == 1) {
new pln[24]; GetPlayerName(playerid,pln,sizeof(pln));
if (GZ_GetPlayerLockLevel(playerid,zoneid) == 0 || GZ_GetAllLockLevel(playerid) == 0) {
gztime[zoneid] = time;
GZ_WriteFileInfo(zoneid,"InCon",1);
GZ_WriteFileInfo(zoneid,"TimeCon",time);
GZ_WriteFileInfo(zoneid,"Invader",playerid);
GangZoneFlashForAll(zoneid,color);
if (adebugl == 1) {
printf("[LGZ] Zone Capture. Player: %s(%d) | Zone - %d",pln,playerid,zoneid);
}} else {
if (adebugl == 1) {
printf("[LGZ] Zone Capture. Zone Locked. Player: %s(%d) | Zone - %d",pln,playerid,zoneid);
}}}
return 1;
}

stock GZ_GetGZCaptureTime(zoneid) {
return GZ_GetFileInfo(zoneid,"TimeCon");
}

stock GZ_SetGZCaptureTime(zoneid,time) {
GZ_WriteFileInfo(zoneid,"TimeCon",time);
}

stock GZ_SetAllGZCaptureTime(time) {
for (new gz=0;gz<=MAX_GZ;gz++) {
GZ_WriteFileInfo(gz,"TimeCon",time);
}}

stock GZ_SetFree(zoneid) {
GZ_FileNew(zoneid);
}

stock GZ_StopCapture(zoneid) {
if (GZ_IsGZInCapture(zoneid) == 1 && GZ_IsValidGZ(zoneid) == 1) {
GangZoneStopFlashForAll(zoneid);
GZ_WriteFileInfo(zoneid,"Invader",-1);
codeGZ[1]++;
dini_IntSet(GZ_FILESTATS,"Tryed",codeGZ[1]);
KillTimer(gzst[zoneid][GZ_TIMER]);
GZ_WriteFileInfo(zoneid,"InCon",0);
}}

stock GZ_FileNew(zoneid) {
new filetmp[256];
format(filetmp,sizeof(filetmp),GZ_ZONEACC,zoneid);
if (!dini_Exists(filetmp)) {
dini_Create(filetmp);
dini_IntSet(filetmp,"InCon",0);
dini_IntSet(filetmp,"TimeCon",0);
dini_IntSet(filetmp,"Owner",-1);
dini_IntSet(filetmp,"Invader",-1);
dini_Set(filetmp,"OwnerName",noowner);
} else {
dini_IntSet(filetmp,"InCon",0);
dini_IntSet(filetmp,"Owner",-1);
dini_IntSet(filetmp,"Invader",-1);
}}

stock GZ_GetOwnerName(zoneid) {
new strp[256];
if (GZ_IsValidGZ(zoneid) == 1) {
new filetmp[256];
format(filetmp,sizeof(filetmp),GZ_ZONEACC,zoneid);
format(strp,sizeof(strp),"%s",udb_decode(dini_Get(filetmp,"OwnerName")));
}
return strp;
}

stock GZ_IsGZInCapture(zoneid) {
return GZ_GetFileInfo(zoneid,"InCon");
}

stock GZ_GetFileInfo(zoneid,info[]) {
new filetmp[256];
format(filetmp,sizeof(filetmp),GZ_ZONEACC,zoneid);
return dini_Int(filetmp,info);
}

stock GZ_WriteFileInfo(zoneid,info[],arg) {
new filetmp[256];
format(filetmp,sizeof(filetmp),GZ_ZONEACC,zoneid);
dini_IntSet(filetmp,info,arg);
}

stock GZ_SetZoneCash(zoneid,cash) {
if (GZ_IsValidGZ(zoneid) == 1) {
GZ_WriteFileInfo(zoneid,"Cash",cash);
}}

stock GZ_SetCashTime(time) {
cashtime=time*1000;
}

stock GZ_GetCashTime() {
return cashtime/1000;
}

stock GZ_AllowMoneyGetting(allow) {
gzmget = allow;
}

stock GZ_GetZoneCash(zoneid) {
if (GZ_IsValidGZ(zoneid) == 0) return 0;
return GZ_GetFileInfo(zoneid,"Cash");
}

public AreaCheck() {
for (new i=0; i<=OnlinePlayers(); i++) {
for (new gz=0; gz<=codeGZ[0]; gz++) {
if (gzel[gz][i] == 0) {
if (GZ_IsPlayerInGZ(i,gz) == 1 && GZ_IsValidGZ(gz) == 1) {
gzel[gz][i] = 1;
gzcurpl[i] = gz;
GZ_OnPlayerEnter(i,gz);
if (GZ_GetPlayerLockLevel(i,gz) == 2 || GZ_GetAllLockLevel(gz) == 2) {
SendClientMessage(i,COLOR_RED,"* Zone locked level 2.");
boundgz[i][gz] = 1;
btim[i] = SetTimerEx("GZ_BoundRemove",1000,1,"dd",i,gz);
new Float:minx, Float:miny, Float:maxx, Float:maxy;
GZ_GetZonePos(gz,minx,miny,maxx,maxy);
new Float:px, Float:py, Float:pz, Float:cy, Float:cx, Float:a1,Float:a2,Float:a3,Float:a4;
cx = minx + floatdiv(maxx-minx,2);
cy = miny + floatdiv(maxy-miny,2);
a1 = GetDisBtwPP(i,cx,miny);
a2 = GetDisBtwPP(i,maxx,cy);
a3 = GetDisBtwPP(i,cx,maxy);
a4 = GetDisBtwPP(i,minx,cy);
GetPlayerPos(i,px,py,pz);
if (px > minx && px < maxx && py > miny && py < cy && a1 < a2 && a1 < a4) {
SetPlayerWorldBounds(i,maxx,minx,miny,-9999);
}
else if (py > miny && py < maxy && px > cx && px < maxx && a2 < a1 && a2 < a3) {
SetPlayerWorldBounds(i,9999,maxx,maxy,miny);
}
else if (px > minx && px < maxx && py > cy && py < maxy && a3 < a2 && a3 < a4) {
SetPlayerWorldBounds(i,maxx,minx,9999,maxy);
}
else if (py > miny && py < maxy && px < cx && px > minx && a4 < a1 && a4 < a3) {
SetPlayerWorldBounds(i,minx,-9999,maxy,miny);
}}
new pln[24]; GetPlayerName(i,pln,sizeof(pln));
if (adebugl == 1) {
printf("[LGZ] Zone Enter. Player: %s(%d) | Zone - %d",pln,i,gz);
}
return 1;
}}
else if (gzel[gz][i] == 1) {
if (GZ_IsPlayerInGZ(i,gz) == 0 && GZ_IsValidGZ(gz) == 1) {
gzel[gz][i] = 0;
GZ_OnPlayerLeave(i,gz);
gzcurpl[i] = -1;
new pln[24]; GetPlayerName(i,pln,sizeof(pln));
if (adebugl == 1) {
printf("[LGZ] Zone Leave. Player: %s(%d) | Zone - %d",pln,i,gz);
}
return 1;
}}}}
return 0;
}

public GZ_Cap() {
for (new zoneid=0;zoneid<=codeGZ[0];zoneid++) {
if (GZ_GetFileInfo(zoneid,"InCon") == 1) {
new filetmp[256];
format(filetmp,sizeof(filetmp),GZ_ZONEACC,zoneid);
if (gztime[zoneid] > 0) {
gztime[zoneid]--;
}
else if (gztime[zoneid] == 0 && GZ_IsPlayerInGZ(GZ_GetFileInfo(zoneid,"Invader"),zoneid) == 1) {
GZ_WriteFileInfo(zoneid,"Owner",GZ_GetFileInfo(zoneid,"Invader"));
GZ_WriteFileInfo(zoneid,"Invader",-1);
new plid = GZ_GetFileInfo(zoneid,"Owner");
new pln[24]; GetPlayerName(plid,pln,sizeof(pln));
dini_Set(filetmp,"OwnerName",udb_encode(pln));
GangZoneStopFlashForAll(zoneid);
codeGZ[2]++;
dini_IntSet(GZ_FILESTATS,"Captured",codeGZ[2]);
GZ_WriteFileInfo(zoneid,"InCon",0);
GZ_OnPlayerCapture(plid,zoneid);
if (adebugl == 1) {
printf("[LGZ] Zone Captured. Player: %s(%d) | Zone - %d",pln,plid,zoneid);
}}
else if (gztime[zoneid] == 0 && GZ_IsPlayerInGZ(GZ_GetFileInfo(zoneid,"Invader"),zoneid) == 0) {
SendClientMessageToAll(COLOR_RED,"* Зона не захвачена");
GangZoneStopFlashForAll(zoneid);
GZ_WriteFileInfo(zoneid,"Invader",-1);
codeGZ[1]++;
dini_IntSet(GZ_FILESTATS,"Tryed",codeGZ[1]);
GZ_WriteFileInfo(zoneid,"InCon",0);
KillTimer(gztimer[zoneid]);
}}}
return true;
}

public CashPlayer(playerid) {
new GZcash[MAX_PLAYERS];
if (gzmget == 1) {
for (new gz=0;gz<=MAX_GZ;gz++) {
if (GZ_GetZoneOwner(gz) == playerid) {
GZcash[playerid] += GZ_GetFileInfo(gz,"Cash");
}}}
if (GZcash[playerid] != 0) {
GivePlayerMoney(playerid,GZcash[playerid]);
GZ_OnPlayerGetMoney(playerid,GZcash[playerid]);
new pln[24]; GetPlayerName(playerid,pln,sizeof(pln));
if (adebugl == 1) {
printf("[LGZ] MoneyPay. Player: %s(%d) | Money - %d",pln,playerid,GZcash[playerid]);
}}
return 1;
}

stock IsPlayerInArea(playerid, Float:minx, Float:maxx, Float:miny, Float:maxy) {
new Float:x, Float:y, Float:z;
GetPlayerPos(playerid, x, y, z);
if (x > minx && x < maxx && y > miny && y < maxy) return 1;
return 0;
}

stock IsVehicleInArea(vehicleid, Float:minx, Float:maxx, Float:miny, Float:maxy) {
new Float:x, Float:y, Float:z;
GetVehiclePos(vehicleid, x, y, z);
if (x > minx && x < maxx && y > miny && y < maxy) return 1;
return 0;
}

stock GangZoneCount() {
new cz = GangZoneCreate(3,3,5,5);
GangZoneDestroy(cz);
return cz;
}

stock udb_encode(nickname[]) {
  new tmp[MAX_STRING];
  set(tmp,nickname);
  tmp=strreplace("_","_00",tmp);
  tmp=strreplace(";","_01",tmp);
  tmp=strreplace("!","_02",tmp);
  tmp=strreplace("/","_03",tmp);
  tmp=strreplace("\\","_04",tmp);
  tmp=strreplace("[","_05",tmp);
  tmp=strreplace("]","_06",tmp);
  tmp=strreplace("?","_07",tmp);
  tmp=strreplace(".","_08",tmp);
  tmp=strreplace("*","_09",tmp);
  tmp=strreplace("<","_10",tmp);
  tmp=strreplace(">","_11",tmp);
  tmp=strreplace("{","_12",tmp);
  tmp=strreplace("}","_13",tmp);
  tmp=strreplace(" ","_14",tmp);
  tmp=strreplace("\"","_15",tmp);
  tmp=strreplace(":","_16",tmp);
  tmp=strreplace("|","_17",tmp);
  tmp=strreplace("=","_18",tmp);
  return tmp;
}
stock udb_decode(nickname[]) {
  new tmp[MAX_STRING];
  set(tmp,nickname);
  tmp=strreplace("_01",";",tmp);
  tmp=strreplace("_02","!",tmp);
  tmp=strreplace("_03","/",tmp);
  tmp=strreplace("_04","\\",tmp);
  tmp=strreplace("_05","[",tmp);
  tmp=strreplace("_06","]",tmp);
  tmp=strreplace("_07","?",tmp);
  tmp=strreplace("_08",".",tmp);
  tmp=strreplace("_09","*",tmp);
  tmp=strreplace("_10","<",tmp);
  tmp=strreplace("_11",">",tmp);
  tmp=strreplace("_12","{",tmp);
  tmp=strreplace("_13","}",tmp);
  tmp=strreplace("_14"," ",tmp);
  tmp=strreplace("_15","\"",tmp);
  tmp=strreplace("_16",":",tmp);
  tmp=strreplace("_17","|",tmp);
  tmp=strreplace("_18","=",tmp);
  tmp=strreplace("_00","_",tmp);
  return tmp;
}

stock OnlinePlayers() {
new ol;
for(new i=0; i < MAX_PLAYERS; i++) {
if (IsPlayerConnected(i)) {
ol++;
}}
return ol;
}


stock GZ_AllowDebug(allow) {
adebugl = allow;
return 1;
}

stock GZ_SetLockLevelForPlayer(playerid,zoneid,locklevel) {
if (GZ_IsValidGZ(zoneid) {
new pln[24]; GetPlayerName(playerid,pln,sizeof(pln));
GZ_WriteFileInfo(zoneid,pln,locklevel);
}
return 1;
}

stock GZ_GetAllLockLevel(zoneid) {
return GZ_GetFileInfo(zoneid,"lockedforall");
}

stock GZ_GetPlayerLockLevel(playerid,zoneid) {
new pln[24]; GetPlayerName(playerid,pln,sizeof(pln));
return GZ_GetFileInfo(zoneid,pln);
}

stock GZ_SetZoneName(zoneid,name[]) {
if (GZ_IsValidGZ(zoneid) == 1) {
new filetmp[256];
format(filetmp,sizeof(filetmp),GZ_ZONEACC,zoneid);
dini_Set(filetmp,"zonename",name);
}
return 1;
}

stock GZ_GetZoneName(zoneid) {
new output[256];
if (GZ_IsValidGZ(zoneid) == 1) {
new filetmp[256];
format(filetmp,sizeof(filetmp),GZ_ZONEACC,zoneid);
format(output,sizeof(output),"%s",dini_Get(filetmp,"zonename"));
} else {
output = "x";
}
return output;
}

stock GZ_SetLockLevelForAll(zoneid,locklevel) {
if (GZ_IsValidGZ(zoneid) == 1) {
GZ_WriteFileInfo(zoneid,"lockedforall",locklevel);
}
return 1;
}

stock GZ_SetZoneColor(zoneid,color) {
if (GZ_IsValidGZ(zoneid) == 1) {
new filetmp[256];
format(filetmp,sizeof(filetmp),GZ_ZONEACC,zoneid);
dini_Set(filetmp,"color",hextostring(color));
GangZoneHideForAll(zoneid);
GangZoneShowForAll(zoneid,color);
}
return 1;
}

stock GZ_GetZoneColor(zoneid) {
new filetmp[256];
format(filetmp,sizeof(filetmp),GZ_ZONEACC,zoneid);
new out = hexstr(dini_Get(filetmp,"color"));
return out;
}

stock GZ_RefreshZoneColor(zoneid) {
if (GZ_IsValidGZ(zoneid) == 1) {
new filetmp[256];
format(filetmp,sizeof(filetmp),GZ_ZONEACC,zoneid);
new out = hexstr(dini_Get(filetmp,"color"));
GangZoneHideForAll(zoneid);
GangZoneShowForAll(zoneid,out);
}
return 1;
}

stock GZ_SetZonePos(zoneid,Float:minx,Float:miny,Float:maxx,Float:maxy) {
new newzoneid;
if (GZ_IsValidGZ(zoneid) == 1) {
new filetmp[256],filetmp2[256];
format(filetmp,sizeof(filetmp),GZ_ZONEACC,zoneid);
GangZoneDestroy(zoneid);
newzoneid = GangZoneCreate(minx,miny,maxx,maxy);
format(filetmp2,sizeof(filetmp2),GZ_ZONEACC,newzoneid);
gzmas[zoneid][0] = 0;
gzmas[zoneid][1] = 0;
gzmas[zoneid][2] = 0;
gzmas[zoneid][3] = 0;
gzmas[newzoneid][0] = Float:minx;
gzmas[newzoneid][1] = Float:miny;
gzmas[newzoneid][2] = Float:maxx;
gzmas[newzoneid][3] = Float:maxy;
GangZoneShowForAll(newzoneid,GZ_GetZoneColor(zoneid));
if (zoneid != newzoneid) {
frename(filetmp,filetmp2);
}
dini_FloatSet(filetmp,"minx",minx);
dini_FloatSet(filetmp,"miny",miny);
dini_FloatSet(filetmp,"maxx",maxx);
dini_FloatSet(filetmp,"maxy",maxy);
if (adebugl == 1) {
printf("[LGZ] Zone ID:%d changed position. New zone ID:%d",zoneid,newzoneid);
}}
return newzoneid;
}

stock GZ_GetZonePos(zoneid,&Float:minx,&Float:miny,&Float:maxx,&Float:maxy) {
if (GZ_IsValidGZ(zoneid) == 1) {
new filetmp[256];
format(filetmp,sizeof(filetmp),GZ_ZONEACC,zoneid);
minx = dini_Float(filetmp,"minx");
miny = dini_Float(filetmp,"miny");
maxx = dini_Float(filetmp,"maxx");
maxy = dini_Float(filetmp,"maxy");
}}

stock GZ_IsVehicleInGZ(vehicleid,zoneid) {
new result;
if (IsVehicleInArea(vehicleid,gzmas[zoneid][0],gzmas[zoneid][2],gzmas[zoneid][1],gzmas[zoneid][3]) == 1 && GZ_IsValidGZ(zoneid) == 1) {
result = 1;
} else {
result = 0;
}
return result;
}

stock GZ_IsVehicleInAnyGZ(vehicleid) {
new result;
for (new gz=0;gz<MAX_GZ;gz++) {
if (IsVehicleInArea(vehicleid,gzmas[gz][0],gzmas[gz][2],gzmas[gz][1],gzmas[gz][3]) == 1  && GZ_IsValidGZ(gz) == 1) {
result = 1;
} else {
result = 0;
}}
return result;
}

stock GZ_IsAnyVehicleInGZ(zoneid) {
new result;
for (new v=1;v<MAX_VEHICLES;v++) {
if (IsVehicleInArea(v,gzmas[zoneid][0],gzmas[zoneid][2],gzmas[zoneid][1],gzmas[zoneid][3]) == 1  && GZ_IsValidGZ(zoneid) == 1) {
result = 1;
} else {
result = 0;
}}
return result;
}

stock GZ_IsAnyPlayerInGZ(zoneid) {
new result;
for (new i=0;i<MAX_PLAYERS;i++) {
if (IsPlayerInArea(i,gzmas[zoneid][0],gzmas[zoneid][2],gzmas[zoneid][1],gzmas[zoneid][3]) == 1  && GZ_IsValidGZ(zoneid) == 1) {
result = 1;
} else {
result = 0;
}}
return result;
}

stock hextostring(color) {
new colorhex[256]; format(colorhex,sizeof(colorhex),"%02x%06x", color >>> 24, color & 0x00FFFFFF);
return colorhex;
}

stock hexstr(string[]) {
new ret, val, i;
if (string[0] == '0' && (string[1] == 'x' || string[1] == 'X')) i = 2;
while (string[i]) {
ret <<= 4;
val = string[i++] - '0';
if (val > 0x09) val -= 0x07;
if (val > 0x0F) val -= 0x20;
if (val < 0x01) continue;
if (val < 0x10) ret += val;
}
return ret;
}

stock GetDisBtwPP(playerid,Float:x2,Float:y2) {
new Float:tmpdis,Float:x1,Float:y1,Float:z1;
GetPlayerPos(playerid,x1,y1,z1);
new Float:z2 = z1;
tmpdis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
return floatround(tmpdis);
}

public GZ_BoundRemove(playerid,zoneid) {
if (boundgz[playerid][zoneid] == 1 && GZ_IsPlayerInGZ(playerid,zoneid) == 0) {
KillTimer(btim[playerid]);
boundgz[playerid][zoneid] = 0;
SetPlayerWorldBounds(playerid,9999,-9999,9999,-9999);
}
return 1;
}
