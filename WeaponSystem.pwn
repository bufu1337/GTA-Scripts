/*
***************************************************
Script - Weapon System.
if you found bug report to me.
Msn: RoyKiller1@hotmail.com
Icq: 329209439
Versoin: #3
***************************************************
*/

//Includes:
#include "a_samp"
#include "dini"
#include "cpstream"
#pragma unused ret_memcpy

//Colors:
#define redc 0xFF0000AA
#define white 0xFFFFFFAA
#define lg 0x24FF0AB9
#define yellow 0xFFFF00AA

//Prices:
#define WeaponPrice1 30000 //Sawn Price
#define WeaponPrice2 25000 // MicroMSG Price
#define WeaponPrice3 6000 // Tec9 Price
#define WeaponPrice4 8000 // M4 Price
#define WeaponPrice5 10000 // MP5 Price
#define WeaponPrice6 30000 // AK47 Price
#define WeaponPrice7 1000 // Colt 45 Price
#define ArmourPrice  300000 // Armour Price
#define TickPrice    3000   // Tick Price

//Ammo Weapon:
#define WeaponAmmo1 100 // Sawn Ammo
#define WeaponAmmo2 200 // MicroMSG Ammo
#define WeaponAmmo3 200 // Tec9 Ammo
#define WeaponAmmo4 200 // M4 Ammo
#define WeaponAmmo5 100 // MP5 Ammo
#define WeaponAmmo6 50 // AK47 Ammo
#define WeaponAmmo7 300 // Colt 45 Ammo

//Armour (%).
#define ArmourSetTo 0.0 // Armour

//Error:
#if (!WeaponPrice1 || !WeaponPrice2 || !WeaponPrice3 || !WeaponPrice4 || !WeaponPrice5 || !WeaponPrice6 || !WeaponPrice7 || !TickPrice || !ArmourPrice || !WeaponAmmo1 || !WeaponAmmo2 || !WeaponAmmo3 || !WeaponAmmo4 || !WeaponAmmo5 || !WeaponAmmo6 || !WeaponAmmo7)
#error the "Weapon Price" / "Armour Float" / "Weapon Ammo" Can`t to be 0.
#endif

//Info:
enum Weapon
{
Float:Armour,
Weapon1,
Weapon2,
Weapon3,
Weapon4,
Weapon5,
Weapon6,
Weapon7,
Tick
};

//Stock (* Can To be New & Static * ).
stock WeaponInfo[200][Weapon];
stock WeaponFile[256];
stock String_Error[256];
stock FWeap[256];
stock WBS[256];
stock n[MAX_PLAYER_NAME];
stock BCP;


stock RColor[100] =
{
0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,0xEE82EEFF,0xFFD720FF,
0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,
0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,
0x275222FF,0xF09F5BFF,0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,
0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,0x4B8987FF,
0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,0x2A51E2FF,0xE3AC12FF,
0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,
0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,
0x9F945CFF,0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,0x3FE65CFF
};

//Forward`s:

public OnFilterScriptInit()
{
print("\n~~~~~~~~~~~~~~~~~~~~");
print("Fliterscript - Weapon System - By CamelJoe[S] 'JoeShk' Mr_Joe_XD_B");
print("~~~~~~~~~~~~~~~~~~~~\n");
BCP     = CPS_AddCheckpoint(290.1510,-83.7102,1001.5156,3,50);
return 1;
}

public OnPlayerConnect(playerid) return ResetWeaponsSystem(playerid);
public OnPlayerDisconnect(playerid, reason) return ResetWeaponsSystem(playerid);

public OnFilterScriptExit() return 1;


public OnPlayerCommandText(playerid, cmdtext[])
{

new cmd[256],idx,Var_Commands[256];
cmd = strtok(cmdtext, idx);


if(!strcmp(cmd,"/BuyTick",true) || !strcmp(cmd,"/BT",true))
{

if(WeaponInfo[playerid][Tick] > 0) return ErrorMessage(playerid,"there you card to use a card enter on the cp.");
if(!CPS_IsPlayerInCheckpoint(playerid,BCP)) return ErrorMessage(playerid, "your need to be in the cp.");
if(GetPlayerMoney(playerid) < TickPrice) return ErrorMessage(playerid,"no enough money"),0;
format(FWeap,256,"Weapon/%s.ini",Xname(playerid));
dini_Create(FWeap),
dini_IntSet(FWeap,"Tick",1),
dini_IntSet(FWeap,"Weapon1",0),
dini_IntSet(FWeap,"Weapon2",0),
dini_IntSet(FWeap,"Weapon3",0),
dini_IntSet(FWeap,"Weapon4",0),
dini_IntSet(FWeap,"Weapon5",0),
dini_IntSet(FWeap,"Weapon6",0),
dini_IntSet(FWeap,"Weapon7",0),
dini_IntSet(FWeap,"Armour",0),

SendClientMessage(playerid, white, "from now you can to buy weapon, to receive another info unrelaxed again on the cp"),
WeaponInfo[playerid][Tick] = 1,
GivePlayerMoney(playerid,-TickPrice);
return 1;
}

if(!strcmp(cmd,"/weaponlist",true) || !strcmp(cmd,"/WL",true))
{
if(!CPS_IsPlayerInCheckpoint(playerid,BCP)) return ErrorMessage(playerid, "!אתה חייב להיות בנקודת ציון בחנות נשקים");
if(WeaponInfo[playerid][Tick] < 1) return ErrorMessage(playerid,"your need card to wield at ammu shop");
SendClientMessage(playerid, white, "List Weapon:");
format(WBS, sizeof(WBS), "/Bw 1 Sawnoff Shotgun %d$     ||    /Bw 2 MicroSMG %d$", WeaponPrice1,WeaponPrice2),
SendClientMessage(playerid, yellow,WBS);
format(WBS, sizeof(WBS), "/Bw 3 Tec9            %d$     ||    /Bw 4 M4       %d$", WeaponPrice3,WeaponPrice4),
SendClientMessage(playerid, yellow,WBS);
format(WBS, sizeof(WBS), "/Bw 5 MP5             %d$     ||    /Bw 6 AK47     %d$", WeaponPrice5,WeaponPrice6),
SendClientMessage(playerid, yellow,WBS);
format(WBS, sizeof(WBS), "/Bw 7 Colt 46         %d$     ||    /Bw 8 Armour   %d$", WeaponPrice7,ArmourPrice),
SendClientMessage(playerid, yellow,WBS);

return 1;
}

if(!strcmp(cmd, "/Bw", true) || !strcmp(cmd, "/BuyWeapon", true))
{
if(!CPS_IsPlayerInCheckpoint(playerid,BCP)) return ErrorMessage(playerid, "your need to be in the cp.");
if(WeaponInfo[playerid][Tick] < 1) return ErrorMessage(playerid,"your need card to wield at ammu shop");
Var_Commands = strtok(cmdtext, idx);
if(!strlen(Var_Commands))
return
SendClientMessage(playerid,white, "Usage: /Bw [1-8]");

if(8 < strlen(Var_Commands) || 1 > strlen(Var_Commands)) return ErrorMessage(playerid,"Usage: [1-8]");


if(strcmp(Var_Commands,"1",true) == 0) return SetWeaponFile(playerid,"Weapon1",1,WeaponPrice1,WeaponAmmo1);
if(strcmp(Var_Commands,"2",true) == 0) return SetWeaponFile(playerid,"Weapon2",2,WeaponPrice2,WeaponAmmo2);
if(strcmp(Var_Commands,"3",true) == 0) return SetWeaponFile(playerid,"Weapon3",3,WeaponPrice3,WeaponAmmo3);
if(strcmp(Var_Commands,"4",true) == 0) return SetWeaponFile(playerid,"Weapon4",4,WeaponPrice4,WeaponAmmo4);
if(strcmp(Var_Commands,"4",true) == 0) return SetWeaponFile(playerid,"Weapon5",5,WeaponPrice5,WeaponAmmo5);
if(strcmp(Var_Commands,"5",true) == 0) return SetWeaponFile(playerid,"Weapon5",5,WeaponPrice5,WeaponAmmo5);
if(strcmp(Var_Commands,"6",true) == 0) return SetWeaponFile(playerid,"Weapon6",6,WeaponPrice6,WeaponAmmo6);
if(strcmp(Var_Commands,"7",true) == 0) return SetWeaponFile(playerid,"Weapon7",7,WeaponPrice7,WeaponAmmo7);
if(strcmp(Var_Commands,"8",true) == 0) return SetWeaponFile(playerid,"Weapon8",8,ArmourPrice,0-1);




return 1;
}

if(strcmp(cmdtext, "/ammu", true)==0) return
SetPlayerPos(playerid,285.8574,-79.9114,1001.5156),
SetPlayerInterior(playerid,4),
SendClientMessage(playerid, yellow, "=> | Welcom to ammu shop | <=");

if(!strcmp(cmd, "/DropWeapon", true) || !strcmp(cmd, "/Dw", true))
{
if(WeaponInfo[playerid][Weapon1] == 0 && WeaponInfo[playerid][Weapon2] == 0 && WeaponInfo[playerid][Weapon2] == 0 && WeaponInfo[playerid][Weapon3] == 0 && WeaponInfo[playerid][Weapon4] == 0 && WeaponInfo[playerid][Weapon5] == 0 && WeaponInfo[playerid][Weapon6] == 0 && WeaponInfo[playerid][Weapon7] == 0) return ErrorMessage(playerid,"!אין לך נשקים");
if(!CPS_IsPlayerInCheckpoint(playerid,BCP)) return ErrorMessage(playerid, "your need to be in cp ammu shop.");
Var_Commands = strtok(cmdtext, idx);
if(!strlen(Var_Commands))
return
SendClientMessage(playerid,white, "Usage: /DropWeapon (/Dw) [1-8]");

if(8 < strlen(Var_Commands) || 1 > strlen(Var_Commands)) return ErrorMessage(playerid,"Usage: [1-8]");


if(strcmp(Var_Commands,"1",true) == 0) return DestroyWeaponsFromFile(playerid,"Weapon1",1);
if(strcmp(Var_Commands,"2",true) == 0) return DestroyWeaponsFromFile(playerid,"Weapon2",2);
if(strcmp(Var_Commands,"3",true) == 0) return DestroyWeaponsFromFile(playerid,"Weapon3",3);
if(strcmp(Var_Commands,"4",true) == 0) return DestroyWeaponsFromFile(playerid,"Weapon4",4);
if(strcmp(Var_Commands,"5",true) == 0) return DestroyWeaponsFromFile(playerid,"Weapon5",5);
if(strcmp(Var_Commands,"6",true) == 0) return DestroyWeaponsFromFile(playerid,"Weapon6",6);
if(strcmp(Var_Commands,"7",true) == 0) return DestroyWeaponsFromFile(playerid,"Weapon7",7);
if(strcmp(Var_Commands,"8",true) == 0) return DestroyWeaponsFromFile(playerid,"Armour",8);

return 1;
}

if(strcmp(cmdtext, "/MyWeapons", true)==0)
{
if(WeaponInfo[playerid][Tick] < 0) return ErrorMessage(playerid,"none weapon.");
new CheackWeapon[200];
CheackWeapon[playerid] = WeaponInfo[playerid][Weapon1]+=WeaponInfo[playerid][Weapon2]+=WeaponInfo[playerid][Weapon3]+=WeaponInfo[playerid][Weapon4]+=WeaponInfo[playerid][Weapon5]+=WeaponInfo[playerid][Weapon6]+=
WeaponInfo[playerid][Weapon7];

if(CheackWeapon[playerid] < 5) return ErrorMessage(playerid,"none weapon.");

SendClientMessage(playerid, white,"--- your weapons: ---");
if(WeaponInfo[playerid][Weapon1] > 3)
{
SendClientMessage(playerid,yellow,"Sawn Off Shotgun.");
}

if(WeaponInfo[playerid][Weapon2] > 3)
{
SendClientMessage(playerid,yellow,"Tec9.");
}

if(WeaponInfo[playerid][Weapon3] > 3)
{
SendClientMessage(playerid,yellow,"Micro Uzi.");
}

if(WeaponInfo[playerid][Weapon4] > 3)
{
SendClientMessage(playerid,yellow,"M4.");
}

if(WeaponInfo[playerid][Weapon5] > 3)
{
SendClientMessage(playerid,yellow,"MP5.");
}

if(WeaponInfo[playerid][Weapon6] > 3)
{
SendClientMessage(playerid,yellow,"AK47.");
}

if(WeaponInfo[playerid][Weapon7] > 3)
{
SendClientMessage(playerid,yellow,"Colt 45.");
}
return 1;
}



return 0;
}

public OnPlayerSpawn(playerid) return LoadWeaponAndGiveTheWeapon(playerid);


public OnPlayerEnterCheckpoint(playerid)
{

if(CPS_IsPlayerInCheckpoint(playerid,BCP))
{
SendClientMessage(playerid, white,"Weapon help:");

if(WeaponInfo[playerid][Tick] < 1)
return
SendClientMessage(playerid, yellow,"SERVER: your need card to buy weapon to buy card usage: /BuyTick (/Bt)"),
format(WBS, sizeof(WBS),"Price Tick: %d.",TickPrice),
SendClientMessage(playerid, yellow,WBS);

else return
SendClientMessage(playerid, yellow,"to see the weapon list: /WeaponList (/Wl) || to buy weapon: /BuyWeapon (/Bw) [1-8]"),
SendClientMessage(playerid, yellow,"to drop weapon: /DropWeapon [1-8] || to see your saved weapon: /MyWeapons");
}
return 1;
}


//Functions:

stock LoadWeaponAndGiveTheWeapon(playerid)
{
if(dini_Exists(GetWeaponFile(playerid)))
{

WeaponInfo[playerid][Tick]       = dini_Int(GetWeaponFile(playerid),"Tick"),
WeaponInfo[playerid][Weapon1]    = dini_Int(GetWeaponFile(playerid),"Weapon1"),
WeaponInfo[playerid][Weapon2]    = dini_Int(GetWeaponFile(playerid),"Weapon2"),
WeaponInfo[playerid][Weapon3]    = dini_Int(GetWeaponFile(playerid),"Weapon3"),
WeaponInfo[playerid][Weapon4]    = dini_Int(GetWeaponFile(playerid),"Weapon4"),
WeaponInfo[playerid][Weapon5]    = dini_Int(GetWeaponFile(playerid),"Weapon5"),
WeaponInfo[playerid][Weapon6]    = dini_Int(GetWeaponFile(playerid),"Weapon6"),
WeaponInfo[playerid][Weapon7]    = dini_Int(GetWeaponFile(playerid),"Weapon7"),
WeaponInfo[playerid][Armour]     = dini_Int(GetWeaponFile(playerid),"Armour");

if(WeaponInfo[playerid][Weapon1] > 0) GivePlayerWeapon(playerid,26,WeaponInfo[playerid][Weapon1]);
if(WeaponInfo[playerid][Weapon2] > 0) GivePlayerWeapon(playerid,28,WeaponInfo[playerid][Weapon2]);
if(WeaponInfo[playerid][Weapon3] > 0) GivePlayerWeapon(playerid,32,WeaponInfo[playerid][Weapon3]);
if(WeaponInfo[playerid][Weapon4] > 0) GivePlayerWeapon(playerid,31,WeaponInfo[playerid][Weapon4]);
if(WeaponInfo[playerid][Weapon5] > 0) GivePlayerWeapon(playerid,29,WeaponInfo[playerid][Weapon5]);
if(WeaponInfo[playerid][Weapon6] > 0) GivePlayerWeapon(playerid,30,WeaponInfo[playerid][Weapon6]);
if(WeaponInfo[playerid][Weapon7] > 0) GivePlayerWeapon(playerid,22,WeaponInfo[playerid][Weapon7]);
if(WeaponInfo[playerid][Armour] > 0)  SetPlayerArmour(playerid,ArmourSetTo);
}
return 1;
}

stock ErrorMessage(playerid,Message[])
return
format(String_Error, sizeof(String_Error), "%s",Message),
SendClientMessage(playerid,redc, String_Error);


stock ResetWeaponsSystem(playerid)
return
WeaponInfo[playerid][Weapon1]    = 0,
WeaponInfo[playerid][Weapon2]    = 0,
WeaponInfo[playerid][Weapon3]    = 0,
WeaponInfo[playerid][Weapon4]    = 0,
WeaponInfo[playerid][Weapon5]    = 0,
WeaponInfo[playerid][Weapon6]    = 0,
WeaponInfo[playerid][Weapon7]    = 0,
WeaponInfo[playerid][Armour]     = 0,
WeaponInfo[playerid][Tick]       = 0;

stock DestroyWeaponsFromFile(playerid,String_Line[16],WeaponNumber)
{
if(dini_Int(GetWeaponFile(playerid),String_Line) < 1) return SendClientMessage(playerid,redc,"Error: this weapon is'nt in your pocket.");
dini_IntSet(GetWeaponFile(playerid),String_Line,0);

if(WeaponNumber == 1) return WeaponInfo[playerid][Weapon1] = 0,SendClientMessage(playerid,redc,"Sawn - the weapon been drop");
if(WeaponNumber == 2) return WeaponInfo[playerid][Weapon2] = 0,SendClientMessage(playerid,redc,"MicroSMG - the weapon been drop");
if(WeaponNumber == 3) return WeaponInfo[playerid][Weapon3] = 0,SendClientMessage(playerid,redc,"Tec9 - the weapon been drop");
if(WeaponNumber == 4) return WeaponInfo[playerid][Weapon4] = 0,SendClientMessage(playerid,redc,"M4 - the weapon been drop");
if(WeaponNumber == 5) return WeaponInfo[playerid][Weapon5] = 0,SendClientMessage(playerid,redc,"MP5 - the weapon been drop");
if(WeaponNumber == 6) return WeaponInfo[playerid][Weapon6] = 0,SendClientMessage(playerid,redc,"AK47 - the weapon been drop");
if(WeaponNumber == 7) return WeaponInfo[playerid][Weapon7] = 0,SendClientMessage(playerid,redc,"Colt 45 - the weapon been drop");
if(WeaponNumber == 8) return WeaponInfo[playerid][Armour] = 0,SendClientMessage(playerid,redc,"Armour - the weapon been drop");

return 1;
}

stock SetWeaponFile(playerid,String_Line[16],WeaponNumber,Price,Ammo)
{
if(GetPlayerMoney(playerid) < Price) return ErrorMessage(playerid,"not enough money.");
new rand = random(sizeof(RColor));
GivePlayerMoney(playerid,-Price);

if(WeaponNumber == 1) return format(WBS, sizeof(WBS), "Sawnoff Shotgun Ammo: %d.",Ammo),SendClientMessage(playerid, RColor[rand],WBS),WeaponInfo[playerid][Weapon1] += WeaponAmmo1,dini_IntSet(GetWeaponFile(playerid),String_Line,WeaponInfo[playerid][Weapon1]),LoadWeaponAndGiveTheWeapon(playerid);
if(WeaponNumber == 2) return format(WBS, sizeof(WBS), "MicroMSG Ammo: %d.",Ammo),SendClientMessage(playerid, RColor[rand],WBS),WeaponInfo[playerid][Weapon2] += WeaponAmmo2,dini_IntSet(GetWeaponFile(playerid),String_Line,WeaponInfo[playerid][Weapon2]),LoadWeaponAndGiveTheWeapon(playerid);
if(WeaponNumber == 3) return format(WBS, sizeof(WBS), "Tec9 Ammo: %d.",Ammo),SendClientMessage(playerid, RColor[rand],WBS),WeaponInfo[playerid][Weapon3] += WeaponAmmo3,dini_IntSet(GetWeaponFile(playerid),String_Line,WeaponInfo[playerid][Weapon3]),LoadWeaponAndGiveTheWeapon(playerid);
if(WeaponNumber == 4) return format(WBS, sizeof(WBS), "M4 Ammo: %d.",Ammo),SendClientMessage(playerid, RColor[rand],WBS),WeaponInfo[playerid][Weapon4] += WeaponAmmo4,dini_IntSet(GetWeaponFile(playerid),String_Line,WeaponInfo[playerid][Weapon4]),LoadWeaponAndGiveTheWeapon(playerid);
if(WeaponNumber == 5) return format(WBS, sizeof(WBS), "MP5 Ammo: %d.",Ammo),SendClientMessage(playerid, RColor[rand],WBS),WeaponInfo[playerid][Weapon5] += WeaponAmmo5,dini_IntSet(GetWeaponFile(playerid),String_Line,WeaponInfo[playerid][Weapon5]),LoadWeaponAndGiveTheWeapon(playerid);
if(WeaponNumber == 6) return format(WBS, sizeof(WBS), "AK47 Ammo: %d.",Ammo),SendClientMessage(playerid, RColor[rand],WBS),WeaponInfo[playerid][Weapon6] += WeaponAmmo6,dini_IntSet(GetWeaponFile(playerid),String_Line,WeaponInfo[playerid][Weapon6]),LoadWeaponAndGiveTheWeapon(playerid);
if(WeaponNumber == 7) return format(WBS, sizeof(WBS), "Colt 45 Ammo: %d.",Ammo),SendClientMessage(playerid, RColor[rand],WBS),WeaponInfo[playerid][Weapon7] += WeaponAmmo7,dini_IntSet(GetWeaponFile(playerid),String_Line,WeaponInfo[playerid][Weapon7]),LoadWeaponAndGiveTheWeapon(playerid);
if(WeaponNumber == 8) return format(WBS, sizeof(WBS), "Armour Float: %.1f .", ArmourSetTo),SendClientMessage(playerid, RColor[rand],WBS),WeaponInfo[playerid][Armour] = ArmourSetTo,dini_FloatSet(GetWeaponFile(playerid),"Armour",WeaponInfo[playerid][Armour]),LoadWeaponAndGiveTheWeapon(playerid);
return 1;
}

stock GetWeaponFile(playerid)
return
format(WeaponFile,sizeof(WeaponFile),"Weapon/%s.ini",Xname(playerid)),WeaponFile;

stock Xname(playerid)
return
GetPlayerName(playerid,n,sizeof(n)),n;
