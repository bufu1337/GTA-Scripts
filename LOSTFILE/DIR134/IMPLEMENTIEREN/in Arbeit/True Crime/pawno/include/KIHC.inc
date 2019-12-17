#include <a_samp>
#pragma unused AddStaticHouse,LoadPly,OnPlayerEnterHousee,SavePly,SetHouseCost,GetHouseOwner

new Float:HIX1[150];
new Float:HIY1[150];
new Float:HIZ1[150];
new Float:HOX1[150];
new Float:HOY1[150];
new Float:HOZ1[150];
new HII1[250];
new HDD[256];
new PIH1[200];
new hidd = 0;
new HP1[150];
new Menu:Hmen1;
new Menu:Hexit1;
/*
native GetHouseCost(houseid);
native GetHouseOwner(houseid);
native SetHouseOwner(houseid,name[]);
native AddStaticHouse(Float:x,Float:y,Float:z,Float:ix,Float:iy,Float:iz,ii);
native SetHouseCost(houseid,cost);
native SetPlayerInHouse(playerid,houseid);
native SetPlayerOutHouse(playerid,houseid);
native IsPlayerAllowedInHouse(playerid,houseid);
native MakeTenent(playerid,houseid);
native SetHouseInfo(houseid,info[],value[]);
native GetHouseInfo(houseid,info[],value[]);
*/

forward GetHouseCost(houseid);

forward SetHouseOwner(houseid,name[]);


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

public GetHouseCost(houseid)
{
new str[256];
GetHouseInfo(houseid,"cost",str);
return strval(str);
}

public OnPlayerCommandText(playerid,cmdtext[])
{
	CallLocalFunction("opct","is",playerid,cmdtext);
	if((strcmp(cmdtext,"/build house small",true)==0) || (strcmp(cmdtext,"/bhs",true)==0))
	{
	    if(IsPlayerAdmin(playerid)){
	    new Float:x,Float:y,Float:z;
	    new string[256],interior[256];
	    new randm;
	    GetPlayerPos(playerid,x,y,z);
	    CreateObject(1272,x,y,z,0,0,0);
        randm = random(4);
		if (randm == 0){
			//Houseo = "SetPlayerInterior(playerid,1);";
			//Housep = "SetPlayerPos(playerid,223.043991,1289.259888,1082.199951);";
			//#define HOUSE_SMALL_ONE 223.043991,1289.259888,1082.199951,1
			interior = "223.043991,1289.259888,1082.199951,1";
		}
		else if (randm == 1){
			//Houseo = "SetPlayerInterior(playerid,15);";
			//Housep = "SetPlayerPos(playerid,295.138977,1474.469971,1080.519897);";
			//#define HOUSE_SMALL_TWO 295.138977,1474.469971,1080.519897,15
			interior = "295.138977,1474.469971,1080.519897,15";
		}
		else if (randm == 2){
			//Houseo = "SetPlayerInterior(playerid,15);";
			//Housep = "SetPlayerPos(playerid,328.493988,1480.589966,1084.449951);";
					//#define HOUSE_SMALL_THREE 328.493988,1480.589966,1084.449951,15
			interior = "328.493988,1480.589966,1084.449951,15";
		}
		else if (randm == 3){
			//Houseo = "SetPlayerInterior(playerid,10);";
			//Housep = "SetPlayerPos(playerid,2262.83,-1137.71,1050.63);";
			//#define HOUSE_SMALL_FOUR 2262.83,-1137.71,1050.63,10
			interior = "2262.83,-1137.71,1050.63,10";
		}
		else if (randm == 4){
			//Houseo = "SetPlayerInterior(playerid,9);";
			//Housep = "SetPlayerPos(playerid,2251.85,-1138.16,1050.63);";
			//#define HOUSE_SMALL_FIVE 2251.85,-1138.16,1050.63,9
			interior = "2251.85,-1138.16,1050.63,9";
		}
		//print("39");
		new File:Hand = fopen("houses.req",io_append);
		format(string,256,"AddStaticHouse(%f,%f,%f,%s);\r\n",x,y,z,interior);
		fwrite(Hand,string);
		fclose(Hand);
		SendClientMessage(playerid,0xFFFFFFAA,"KIHC: A small sized HOUSE was successfully BUILT.");
		}
		return 1;
	}
	if((strcmp(cmdtext,"/build house medium",true)==0) || (strcmp(cmdtext,"/bhm",true)==0))
	{
	    if(IsPlayerAdmin(playerid)){
	    new Float:x,Float:y,Float:z;
	    new string[256],interior[256];
	    new ran;
	    GetPlayerPos(playerid,x,y,z);
	    CreateObject(1272,x,y,z,0,0,0);
        ran = random(3);
		if (ran == 0)
		{
			//houseo = "SetPlayerInterior(playerid,2);";
			//housep = "SetPlayerPos(playerid,225.756989,1240.000000,1082.149902);";
			//#define HOUSE_MEDIUM_ONE 225.756989,1240.000000,1082.149902,2
			interior = "225.756989,1240.000000,1082.149902,2";

		}
		if (ran == 1)
		{
			//houseo = "SetPlayerInterior(playerid,2);";
			//housep = "SetPlayerPos(playerid,2451.77, -1699.80,1013.51);";
			//#define HOUSE_MEDIUM_TWO 2451.77, -1699.80,1013.51,2
			interior = "2451.77, -1699.80,1013.51,2";
		}
		if (ran == 2)
		{
			//houseo = "SetPlayerInterior(playerid,15);";
			//housep = "SetPlayerPos(playerid,385.803986,1471.769897,1080.209961  );";
			//#define HOUSE_MEDIUM_THREE 385.803986,1471.769897,1080.209961,15
			interior = "385.803986,1471.769897,1080.209961,15";
		}
		if (ran == 3)
		{
			//houseo = "SetPlayerInterior(playerid,10);";
			//housep = "SetPlayerPos(playerid,2260.76,-1210.45,1049.02);";
			//#define HOUSE_MEDIUM_FOUR 2260.76,-1210.45,1049.02,10
			interior = "2260.76,-1210.45,1049.02,10";
		}
		new File:Hand = fopen("houses.req",io_append);
		format(string,256,"AddStaticHouse(%f,%f,%f,%s);\r\n",x,y,z,interior);
		fwrite(Hand,string);
		fclose(Hand);
		SendClientMessage(playerid,0xFFFFFFAA,"KIHC: A medium sized HOUSE was successfully BUILT.");
		}
		return 1;
	}

	if((strcmp(cmdtext,"/build house large",true)==0) || (strcmp(cmdtext,"/bhl",true)==0))
	{
		if(IsPlayerAdmin(playerid)){
	    new Float:x,Float:y,Float:z;
	    new string[256],interior[256];
	    new ran;
	    GetPlayerPos(playerid,x,y,z);
	    CreateObject(1272,x,y,z,0,0,0);
        ran = random(3);
		if (ran == 0){
			//houseo = "SetPlayerInterior(playerid,3);";
			//housep = "SetPlayerPos(playerid,235.508994,1189.169897,1080.339966);";
			//#define HOUSE_LARGE_ONE 235.508994,1189.169897,1080.339966,3
			interior = "235.508994,1189.169897,1080.339966,3";
		}
		if (ran == 1){
			//houseo = "SetPlayerInterior(playerid,7);";
			//housep = "SetPlayerPos(playerid,225.630997,1022.479980,1084.069946);";
			//#define HOUSE_LARGE_TWO 225.630997,1022.479980,1084.069946,7
			interior = "225.630997,1022.479980,1084.069946,7";
		}
		if (ran == 2){
			//houseo = "SetPlayerInterior(playerid,8);";
			//housep = "SetPlayerPos(playerid,2807.63,-1170.15,1025.57);";
			//#define HOUSE_LARGE_THREE 2807.63,-1170.15,1025.57,8
			interior = "2807.63,-1170.15,1025.57,8";
		}
		if (ran == 3){
			//houseo = "SetPlayerInterior(playerid,1 );";
			//housep = "SetPlayerPos(playerid,-2158.72,641.29,1052.38);";
			//#define HOUSE_LARGE_FOUR -2158.72,641.29,1052.38,1
			interior = "-2158.72,641.29,1052.38,1";
		}
		new File:Hand = fopen("houses.req",io_append);
		format(string,256,"AddStaticHouse(%f,%f,%f,%s);\r\n",x,y,z,interior);
		fwrite(Hand,string);
		fclose(Hand);
		SendClientMessage(playerid,0xFFFFFFAA,"KIHC: A large sized HOUSE was successfully BUILT.");
		}
		return 1;
	}
	return 1;
}


LoadPly(playerid,info[],value[]){
new filen[256],name[256];
GetPlayerName(playerid,name,255);
format(filen,256,"%s.zip",name);
new data[256];
new front;
new len;
if (fexist(filen)){}
else{
new File:open = fopen(filen,io_write);
fclose(open);
}
new File:Read = fopen(filen,io_read);
fread(Read,data);
len = strlen(data);
front = strfind(data,info,true);
if (front == -1){
return 0;
}
else{
strdel(data,0,front);
front = strfind(data,"=");
strdel(data,0,front);
front = strfind(data,";");
strdel(data,0,1);
strdel(data,front-1,len);
format(value,sizeof(data),data);
return 1;
}
}

SavePly(playerid,info[],value[]){
new sta[256];
new filen[256],name[256];
GetPlayerName(playerid,name,255);
format(filen,256,"%s.zip",name);
if (fexist(filen)){}
else{
new File:open = fopen(filen,io_write);
fclose(open);
}
format(sta,256,"%s=",info);
new data[256],fnd;
new File:Check = fopen(filen,io_read);
fread(Check,data);
fclose(Check);
fnd = strfind(data,sta);
if(fnd ==-1){
new File:Read = fopen(filen,io_append);
format(data,256,"%s=%s;",info,value);
fwrite(Read,data);
fclose(Read);
////print("meee");
}
else{
new len,str;
new string[256];
new File:Read = fopen(filen,io_read);
fread(Read,data);
////print(data);
str = strfind(data,info);
len = strfind(data,";",true,str);
strdel(data,str,len+1);
////print(data);
format(string,256,"%s=%s;",info,value);
strins(data,string,str);
////print(data);
fclose(Read);
new File:Write = fopen(filen,io_write);
fwrite(Write,data);
fclose(Write);
////print("me");
}
}
Loadpropertt(name[],info[],value[]){
new filen[256];
format(filen,256,"%s.zip",name);
new data[256];
new front;
new len;
if (fexist(filen)){}
else{
new File:open = fopen(filen,io_write);
fclose(open);
}
new File:Read = fopen(filen,io_read);
fread(Read,data);
len = strlen(data);
front = strfind(data,info,true);
if (front == -1){
////print("loop ");
return 0;
}
else{
strdel(data,0,front);
front = strfind(data,"=");
strdel(data,0,front);
front = strfind(data,";");
strdel(data,0,1);
strdel(data,front-1,len);
format(value,sizeof(data),data);
////print("loop ");
return 1;
}
}

Savepropertt(name[],info[],value[]){
new sta[256];
new filen[256];
format(filen,256,"%s.zip",name);
format(sta,256,"%s=",info);
new data[256],fnd;
if (fexist(filen)){}
else{
new File:open = fopen(filen,io_write);
fclose(open);
}
new File:Check = fopen(filen,io_read);
fread(Check,data);
fclose(Check);
fnd = strfind(data,sta);
if(fnd ==-1){
new File:Read = fopen(filen,io_append);
format(data,256,"%s=%s;",info,value);
fwrite(Read,data);
fclose(Read);
////print("meee");
}
else{
new len,str;
new string[256];
new File:Read = fopen(filen,io_read);
fread(Read,data);
////print(data);
str = strfind(data,info);
len = strfind(data,";",true,str);
strdel(data,str,len+1);
////print(data);
format(string,256,"%s=%s;",info,value);
strins(data,string,str);
////print(data);
fclose(Read);
new File:Write = fopen(filen,io_write);
fwrite(Write,data);
fclose(Write);
////print("me");
}
}

SetHouseCost(Houseid,cost){
new str[256];
valstr(str,cost);
SetHouseInfo(Houseid,"cost",str);
}

MakeTenent1(playerid,Houseid){
////print("MakeTenent1");
new str1[256],str2[256],d;
new str3[100];
format(str3,100,"house%d",Houseid);
d = 0;
GetPlayerName(playerid,str2,256);
Loadpropertt(str3,"Tenent1",str1);
////printf("%d",d);
if (strcmp(str1,"none")==0){
d = 1;
////printf("%d",d);
Savepropertt(str3,"Tenent1",str2);
}
Loadpropertt(str3,"Tenent2",str1);
if (strcmp(str1,"none")==0 && d == 0){
d = 1;////printf("%d",d);
Savepropertt(str3,"Tenent2",str2);
}
Loadpropertt(str3,"Tenent3",str1);
if (strcmp(str1,"none")==0 && d == 0){
d = 1;////printf("%d",d);
Savepropertt(str3,"Tenent3",str2);
}
Loadpropertt(str3,"Tenent4",str1);
if (strcmp(str1,"none")==0 && d == 0){
d = 1;////printf("%d",d);
Savepropertt(str3,"Tenent4",str2);
}
Loadpropertt(str3,"Tenent5",str1);
if (strcmp(str1,"none")==0 && d == 0){
d = 1;////printf("%d",d);
Savepropertt(str3,"Tenent5",str2);
}
if (d == 0){
////printf("%d",d);
GameTextForPlayer(playerid,"~r~There are no empty rooms AVAILABLE",5000,1);
}
else{
format(str3,100,"house%d",Houseid);
Loadpropertt(str3,"Rent",str2);
new cost = strval(str2);
GivePlayerMoney(playerid,-cost);
GivePlayerMoney(playerid,-cost);
GameTextForPlayer(playerid,"~g~Congrats for you new house.",5000,1);
}
}
SetPlayerInHouse(playerid,Houseid){
PIH1[playerid] = Houseid;
SetPlayerPos(playerid,HIX1[Houseid],HIY1[Houseid],HIZ1[Houseid]);
SetPlayerInterior(playerid,HII1[Houseid]);
ShowMenuForPlayer(Hexit1,playerid);
}
SetHouseInfo(Houseid,info[],value[]){
new str[100];
format(str,100,"house%d",Houseid);
Savepropertt(str,info,value);
}

GetHouseInfo(Houseid,info[],value[]){
new str[100];
new ret;
format(str,100,"house%d",Houseid);
ret = Loadpropertt(str,info,value);
return ret;
}
SetPlayerOutHouse(playerid,Houseid){
PIH1[playerid] = 0;
SetPlayerPos(playerid,HOX1[Houseid],HOY1[Houseid],HOZ1[Houseid]);
SetPlayerInterior(playerid,0);

}

IsPlayerAllowedInHouse(playerid,Houseid){
new str1[256],str2[256];
GetPlayerName(playerid,str2,256);
GetHouseInfo(Houseid,"Owner",str1);
if (strcmp(str1,str2)==0){
return 1;
}
GetHouseInfo(Houseid,"Tenent1",str1);
if (strcmp(str1,str2)==0){
return 1;
}
GetHouseInfo(Houseid,"Tenent2",str1);
if (strcmp(str1,str2)==0){
return 1;
}
GetHouseInfo(Houseid,"Tenent3",str1);
if (strcmp(str1,str2)==0){
return 1;
}
GetHouseInfo(Houseid,"Tenent4",str1);
if (strcmp(str1,str2)==0){
return 1;
}
GetHouseInfo(Houseid,"Tenent5",str1);
if (strcmp(str1,str2)==0){
return 1;
}
else{
return 0;
}}

AddStaticHouse(Float:x,Float:y,Float:z,Float:ix,Float:iy,Float:iz,ii){
//print("addstaticHouse");
hidd++;
HP1[CreatePickup(1273,2,x,y,z)] = hidd;
HIX1[hidd] = ix;
HIY1[hidd] = iy;
HIZ1[hidd] = iz;
HII1[hidd] = ii;
HOX1[hidd] = x;
HOY1[hidd] = y;
HOZ1[hidd] = z;
new str[256];
format(str,256,"house%d.zip",hidd);
if (!fexist(str)){
new File:House = fopen(str,io_write);
fclose(House);
SetHouseInfo(hidd,"Owner","none");
SetHouseInfo(hidd,"Rent","0");
SetHouseInfo(hidd,"Cost","50000");
SetHouseInfo(hidd,"Tenent1","none");
SetHouseInfo(hidd,"Tenent2","none");
SetHouseInfo(hidd,"Tenent3","none");
SetHouseInfo(hidd,"Tenent4","none");
SetHouseInfo(hidd,"Tenent5","none");
}
return hidd;
}

OnPlayerEnterHousee(playerid,Houseid)
{
ShowMenuForPlayer(Hmen1,playerid);
HDD[playerid] = Houseid;
}

public OnPlayerPickUpPickup(playerid,pickupid)
{
	if(HP1[pickupid] != 0)
	{
		OnPlayerEnterHousee(playerid,HP1[pickupid]);
	}
}
public OnPlayerSelectedMenuRow(playerid,row){
//print("onplayerselectedmenu");
CallLocalFunction("opsm","ii",playerid,row);
new Menu:Cur = GetPlayerMenu(playerid);
if (Cur == Hmen1){
////print("Hmen1 Select");
switch(row){
case 0:{
////print("House Menu Case 0");
new str1[150],str2[150],str3[150],string[150];
GetHouseInfo(HDD[playerid],"Owner",str1);
GetHouseInfo(HDD[playerid],"Rent",str2);
GetHouseInfo(HDD[playerid],"Cost",str3);
format(string,255,"Owner: %s~n~Rent: %s~n~Cost: %s",str1,str2,str3);
GameTextForPlayer(playerid,string,5000,5);
}
case 1:{
new str1[256];
////print("House Menu Case 1");
GetHouseInfo(HDD[playerid],"Lock",str1);
if (strcmp(str1,"no")==0){
SetPlayerInHouse(playerid,HDD[playerid]);
}
else if (IsPlayerAllowedInHouse(playerid,HDD[playerid])==1){
SetPlayerInHouse(playerid,HDD[playerid]);
}
else {
GameTextForPlayer(playerid,"~r~house is LOCKED",5000,1);
}
}
case 2:{
new str2[256];
GetHouseInfo(HDD[playerid],"Rent",str2);
new cost = strval(str2);
new str1[256];
GetHouseInfo(HDD[playerid],"Owner",str1);
if (strcmp(str1,"none")==0){
GameTextForPlayer(playerid,"~r~house has no OWNER",5000,1);
}
else {
if (GetPlayerMoney(playerid) >= cost){
CallLocalFunction("OnPlayerRentHouse","ii",playerid,HDD[playerid]);
MakeTenent1(playerid,HDD[playerid]);
}
else{
GameTextForPlayer(playerid,"~r~You dont have enough MONEY",5000,1);
}
}
}
case 3:{
new str1[256];
new str2[256];
new str3[100];
format(str3,100,"house%d",HDD[playerid]);
new name[256];
Loadpropertt(str3,"Cost",str2);
new cost = strval(str2);
GetPlayerName(playerid,name,255);
Loadpropertt(str3,"Owner",str1);
if (strcmp(str1,"none")==0){
if (GetPlayerMoney(playerid) >= cost){
GivePlayerMoney(playerid,-cost);
Savepropertt(str3,"Owner",name);
GameTextForPlayer(playerid,"~g~Congrats for your new house.",5000,5);
}
else{
GameTextForPlayer(playerid,"~r~You dont have enough MONEY",5000,5);
}
}
else{
GameTextForPlayer(playerid,"~r~This house is not FOR SALE",5000,5);
}
}
}}
else if (Cur == Hexit1){
SetPlayerOutHouse(playerid,PIH1[playerid]);
}
return 1;
}

public OnPlayerExitedMenu(playerid){
CallLocalFunction("opem","i",playerid);
//print("onplayerexitmenu");
new Menu:current = GetPlayerMenu(playerid);
if (current == Hexit1){
ShowMenuForPlayer(Hexit1,playerid);
TogglePlayerControllable(playerid,1);
}
return 1;
}
public OnGameModeInit(){
CallLocalFunction("ogmi"," ");
Hmen1 = CreateMenu("house",1,50,150,50,150);
AddMenuItem(Hmen1,0,"Info");
AddMenuItem(Hmen1,0,"Enter");
AddMenuItem(Hmen1,0,"Rent");
AddMenuItem(Hmen1,0,"Buy");
Hexit1 = CreateMenu(" ",1,500,380,50,30);
AddMenuItem(Hexit1,0,"EXIT");
#include <../../scriptfiles/houses.req>
return 1;
}

forward opem(playerid);
forward ogmi();
forward opct(playerid,cmdtext[]);
forward opsm(playerid,row);
forward oppp(playerid,pickupid);
#if defined MIC_INCLUDED
	#endinput
#else
	#define OnPlayerExitedMenu opem
	#define OnGameModeInit ogmi
	#define OnPlayerCommandText opct
	#define OnPlayerSelectedMenuRow opsm
	#define OnPlayerPickupPickup oppp
#endif
