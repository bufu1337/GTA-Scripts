// Houses [ mic_house ]

/*
native AddStaticHouse(Float:x,Float:y,Float:z,Float:ix,Float:iy,Float:iz,ii);
native SetHouseCost(houseid,cost);
native SetPlayerInHouse(playerid,houseid);
native SetPlayerOutHouse(playerid,houseid);
native IsPlayerAllowedInHouse(playerid,houseid);
native MakeTenent(playerid,houseid);
native SetBizInfo(bizid,info[],value[]);
native GetBizInfo(bizid,info[],value[]);
native SetHouseInfo(houseid,info[],value[]);
native GetHouseInfo(houseid,info[],value[]);
*/
#pragma unused GetHouseOwner,GetBizOwner

public SetHouseCost(houseid,cost){
new str[256];
valstr(str,cost);
SetHouseInfo(houseid,"cost",str);
}
public SetBizCost(bizid,cost){
new str[256];
valstr(str,cost);
SetBizInfo(bizid,"cost",str);
}
//---------------------
/*
native GetHouseCost(houseid);
native GetHouseOwner(houseid);
native SetHouseOwner(houseid,name[]);
*/
forward GetHouseCost(houseid);
forward GetBizCost(bizid);
forward SetHouseOwner(houseid,name[]);
forward SetBizOwner(bizid,name[]);

public SetBizOwner(bizid,name[])
{
SetBizInfo(bizid,"Owner",name);
}
public SetHouseOwner(houseid,name[])
{
SetHouseInfo(houseid,"Owner",name);
}

GetHouseOwner(houseid)
{
new str[256];
GetHouseInfo(houseid,"Owner",str);
return str;
}
GetBizOwner(bizid)
{
new str[256];
GetBizInfo(bizid,"Owner",str);
return str;
}
public GetHouseCost(houseid)
{
new str[256];
GetHouseInfo(houseid,"cost",str);
return strval(str);
}

public GetBizCost(bizid)
{
new str[256];
GetBizInfo(bizid,"cost",str);
return strval(str);
}
//---------------------------
public MakeTenent(playerid,houseid){
//print("MakeTenent");
new str1[256],str2[256],d;
new str3[100];
format(str3,100,"house%d",houseid);
d = 0;
GetPlayerName(playerid,str2,256);
LoadProperty(str3,"Tenent1",str1);
//printf("%d",d);
if (strcmp(str1,"none")==0){
d = 1;
//printf("%d",d);
SaveProperty(str3,"Tenent1",str2);
}
LoadProperty(str3,"Tenent2",str1);
if (strcmp(str1,"none")==0 && d == 0){
d = 1;//printf("%d",d);
SaveProperty(str3,"Tenent2",str2);
}
LoadProperty(str3,"Tenent3",str1);
if (strcmp(str1,"none")==0 && d == 0){
d = 1;//printf("%d",d);
SaveProperty(str3,"Tenent3",str2);
}
LoadProperty(str3,"Tenent4",str1);
if (strcmp(str1,"none")==0 && d == 0){
d = 1;//printf("%d",d);
SaveProperty(str3,"Tenent4",str2);
}
LoadProperty(str3,"Tenent5",str1);
if (strcmp(str1,"none")==0 && d == 0){
d = 1;//printf("%d",d);
SaveProperty(str3,"Tenent5",str2);
}
if (d == 0){
//printf("%d",d);
GameTextForPlayer(playerid,"~r~There are no empty rooms AVAILABLE",5000,1);
}
else{
format(str3,100,"house%d",houseid);
LoadProperty(str3,"Rent",str2);
new cost = strval(str2);
GivePlayerMoney(playerid,-cost);
GivePlayerMoney(playerid,-cost);
GameTextForPlayer(playerid,"~g~Congrats for you new HOUSE",5000,1);
}
}
public SetPlayerInHouse(playerid,houseid){
PIH[playerid] = houseid;
SetPlayerPos(playerid,HIX[houseid],HIY[houseid],HIZ[houseid]);
SetPlayerInterior(playerid,HII[houseid]);
ShowMenuForPlayer(Hexit,playerid);
CallLocalFunction("OnPlayerEnterHouse","ii",playerid,houseid);
}
public SetHouseInfo(houseid,info[],value[]){
new str[100];
format(str,100,"house%d",houseid);
SaveProperty(str,info,value);
}

public GetHouseInfo(houseid,info[],value[]){
new str[100];
new ret;
format(str,100,"house%d",houseid);
ret = LoadProperty(str,info,value);
return ret;
}
public SetPlayerOutHouse(playerid,houseid){
PIH[playerid] = 0;
SetPlayerPos(playerid,HOX[houseid],HOY[houseid],HOZ[houseid]);
SetPlayerInterior(playerid,0);
CallLocalFunction("OnPlayerLeaveHouse","ii",playerid,houseid);
}

public IsPlayerAllowedInHouse(playerid,houseid){
new str1[256],str2[256];
GetPlayerName(playerid,str2,256);
GetHouseInfo(houseid,"Owner",str1);
if (strcmp(str1,str2)==0){
return 1;
}
GetHouseInfo(houseid,"Tenent1",str1);
if (strcmp(str1,str2)==0){
return 1;
}
GetHouseInfo(houseid,"Tenent2",str1);
if (strcmp(str1,str2)==0){
return 1;
}
GetHouseInfo(houseid,"Tenent3",str1);
if (strcmp(str1,str2)==0){
return 1;
}
GetHouseInfo(houseid,"Tenent4",str1);
if (strcmp(str1,str2)==0){
return 1;
}
GetHouseInfo(houseid,"Tenent5",str1);
if (strcmp(str1,str2)==0){
return 1;
}
else{
return 0;
}}

public AddStaticHouse(Float:x,Float:y,Float:z,Float:ix,Float:iy,Float:iz,ii){
hid++;
HP[CreatePickup(1273,2,x,y,z)] = hid;
HIX[hid] = ix;
HIY[hid] = iy;
HIZ[hid] = iz;
HII[hid] = ii;
HOX[hid] = x;
HOY[hid] = y;
HOZ[hid] = z;
new str[256];
format(str,256,"house%d.zip",hid);
if (!fexist(str)){
new File:house = fopen(str,io_write);
fclose(house);
SetHouseInfo(hid,"Owner","none");
SetHouseInfo(hid,"Rent","0");
SetHouseInfo(hid,"Cost","50000");
SetHouseInfo(hid,"Tenent1","none");
SetHouseInfo(hid,"Tenent2","none");
SetHouseInfo(hid,"Tenent3","none");
SetHouseInfo(hid,"Tenent4","none");
SetHouseInfo(hid,"Tenent5","none");
}
return hid;
}

public OnPlayerEnterHousee(playerid,houseid){
ShowMenuForPlayer(Hmenu,playerid);
HID[playerid] = houseid;
}

