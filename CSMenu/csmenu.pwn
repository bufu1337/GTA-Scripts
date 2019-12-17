#include <a_samp>

#define COLOR_BLUE 0x0000FFAA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_PURPLE 0x9900FFAA
#define COLOR_BROWN 0x993300AA
#define COLOR_ORANGE 0xFF9933AA
#define COLOR_CYAN 0x99FFFFAA
#define COLOR_TAN 0xFFFFCCAA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_KHAKI 0x999900AA
#define COLOR_LIME 0x99FF00AA
#define COLOR_BLACK 0x000000AA
#define COLOR_TURQ 0x00A3C0AA
#define COLOR_SYSTEM 0xEFEFF7AA

new Menu:menu[MAX_PLAYERS];

//Car Shop by Snipe69

#define FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" CarShop Menu by Snipe69");
	print("--------------------------------------\n");
	
    AddStaticPickup( 1274, 23, 2051.2986,2211.9353,10.8203 );
    AddStaticPickup( 1274, 23, 1080.5807,-1757.7505,13.3837 );
    AddStaticPickup( 1274, 23, -1656.4481,452.7616,7.1872 );
    AddStaticPickup( 1274, 23, 1283.0946,186.5609,20.0283 );
    AddStaticPickup( 1274, 23, -534.3010,2564.7146,53.4141 );
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}


public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	return 1;
}

public OnPlayerInfoChange(playerid)
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	    return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
		menu[playerid] = CreateMenu("Vehicles",2,200,100,150,75);
		SetMenuColumnHeader(menu[playerid], 0, "Vehicle Shop Menu:");
		AddMenuItem(menu[playerid], 0, "NRG 2000$");
		AddMenuItem(menu[playerid], 0, "Mountain Bike 600$");
		AddMenuItem(menu[playerid], 0, "Banshee 6500$");
		AddMenuItem(menu[playerid], 0, "Infernus 5000$");
		AddMenuItem(menu[playerid], 0, "Patriot 8000$");
		AddMenuItem(menu[playerid], 0, "Hotknife 10000$");
		AddMenuItem(menu[playerid], 0, "Freeway 3000$");
		AddMenuItem(menu[playerid], 0, "Sanchez 3000$");
		AddMenuItem(menu[playerid], 0, "Quad 2500$");
		AddMenuItem(menu[playerid], 0, "Jeep 4250$");
		AddMenuItem(menu[playerid], 0, "Remington 5500$");
		AddMenuItem(menu[playerid], 0, "Sultan 4500$");
		TogglePlayerControllable(playerid, 0);
		ShowMenuForPlayer(menu[playerid], playerid);
	    return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
new Menu:Main1 = GetPlayerMenu(playerid);
new vehicle;
new vehicle1;
new vehicle2;
new vehicle3;
new vehicle4;
new vehicle5;
new vehicle6;
new vehicle7;
new vehicle8;
new vehicle9;
new vehicle10;
new vehicle11;
if (Main1 == menu[playerid])
{
{
switch (row)
{
case 0:{
new Float:x, Float:y, Float:z, Float:a;
GetPlayerPos(playerid, x, y, z);
vehicle1= CreateVehicle(522, x, y, z, 0, -1, -1, 99999999);
PutPlayerInVehicle(playerid,vehicle1,0);
GetPlayerFacingAngle(playerid,a);
SetVehicleZAngle(vehicle1,a);
DestroyMenu(Menu:Main1);
LinkVehicleToInterior(vehicle1, GetPlayerInterior(playerid));
SetCameraBehindPlayer(playerid);
GivePlayerMoney(playerid,-2000);
SendClientMessage(playerid,COLOR_GREEN, "You Bought a Nrg500 for 2000$");
TogglePlayerControllable(playerid, 1);}
case 1:{
new Float:x, Float:y, Float:z, Float:a;
GetPlayerPos(playerid, x, y, z);
vehicle2= CreateVehicle(510, x, y, z, 0, -1, -1, 99999999);
PutPlayerInVehicle(playerid,vehicle2,0);
GetPlayerFacingAngle(playerid,a);
SetVehicleZAngle(vehicle2,a);
DestroyMenu(Menu:Main1);
LinkVehicleToInterior(vehicle2, GetPlayerInterior(playerid));
SetCameraBehindPlayer(playerid);
GivePlayerMoney(playerid,-600);
SendClientMessage(playerid,COLOR_GREEN, "You Bought a Mountain Bike for 600$");
TogglePlayerControllable(playerid, 1);}
case 2:{
new Float:x, Float:y, Float:z, Float:a;
GetPlayerPos(playerid, x, y, z);
vehicle3= CreateVehicle(429,x, y, z, 0, -1, -1, 99999999);
PutPlayerInVehicle(playerid,vehicle3,0);
GetPlayerFacingAngle(playerid,a);
SetVehicleZAngle(vehicle3,a);
DestroyMenu(Menu:Main1);
LinkVehicleToInterior(vehicle3, GetPlayerInterior(playerid));
SetCameraBehindPlayer(playerid);
GivePlayerMoney(playerid,-6500);
SendClientMessage(playerid,COLOR_GREEN, "You Bought a Banshee for 6500$");
TogglePlayerControllable(playerid, 1);}
case 3:{
new Float:x, Float:y, Float:z, Float:a;
GetPlayerPos(playerid, x, y, z);
vehicle4= CreateVehicle(411, x, y, z, 0, -1, -1, 99999999);
PutPlayerInVehicle(playerid,vehicle4,0);
GetPlayerFacingAngle(playerid,a);
SetVehicleZAngle(vehicle4,a);
DestroyMenu(Menu:Main1);
LinkVehicleToInterior(vehicle4, GetPlayerInterior(playerid));
SetCameraBehindPlayer(playerid);
GivePlayerMoney(playerid,-5000);
SendClientMessage(playerid,COLOR_GREEN, "You Bought a Infernus for 5000$");
TogglePlayerControllable(playerid, 1);}
case 4:{
new Float:x, Float:y, Float:z, Float:a;
GetPlayerPos(playerid, x, y, z);
vehicle5= CreateVehicle(470, x, y, z, 0, -1, -1, 999999);
PutPlayerInVehicle(playerid,vehicle5,0);
GetPlayerFacingAngle(playerid,a);
SetVehicleZAngle(vehicle5,a);
DestroyMenu(Menu:Main1);
LinkVehicleToInterior(vehicle5, GetPlayerInterior(playerid));
SetCameraBehindPlayer(playerid);
GivePlayerMoney(playerid,-8000);
SendClientMessage(playerid,COLOR_GREEN, "You Bought a Patriot for 8000$");
TogglePlayerControllable(playerid, 1);}
case 5:{
new Float:x, Float:y, Float:z, Float:a;
GetPlayerPos(playerid, x, y, z);
vehicle6= CreateVehicle(434, x, y, z, 0, -1, -1, 99999999);
PutPlayerInVehicle(playerid,vehicle6,0);
GetPlayerFacingAngle(playerid,a);
SetVehicleZAngle(vehicle6,a);
DestroyMenu(Menu:Main1);
LinkVehicleToInterior(vehicle6, GetPlayerInterior(playerid));
SetCameraBehindPlayer(playerid);
GivePlayerMoney(playerid,-10000);
SendClientMessage(playerid,COLOR_GREEN, "You Bought a Hotknife for 10000$");
TogglePlayerControllable(playerid, 1);}
case 6:{
new Float:x, Float:y, Float:z, Float:a;
GetPlayerPos(playerid, x, y, z);
vehicle7= CreateVehicle(463, x, y, z, 0, -1, -1, 99999999);
PutPlayerInVehicle(playerid,vehicle7,0);
GetPlayerFacingAngle(playerid,a);
SetVehicleZAngle(vehicle7,a);
DestroyMenu(Menu:Main1);
LinkVehicleToInterior(vehicle7, GetPlayerInterior(playerid));
SetCameraBehindPlayer(playerid);
GivePlayerMoney(playerid,-3000);
SendClientMessage(playerid,COLOR_GREEN, "You Bought a Freeway for 3000$");
TogglePlayerControllable(playerid, 1);}
case 7:{
new Float:x, Float:y, Float:z, Float:a;
GetPlayerPos(playerid, x, y, z);
vehicle8= CreateVehicle(468, x, y, z, 0, -1, -1, 99999999);
PutPlayerInVehicle(playerid,vehicle8,0);
GetPlayerFacingAngle(playerid,a);
SetVehicleZAngle(vehicle8,a);
DestroyMenu(Menu:Main1);
LinkVehicleToInterior(vehicle8, GetPlayerInterior(playerid));
SetCameraBehindPlayer(playerid);
GivePlayerMoney(playerid,-2000);
SendClientMessage(playerid,COLOR_GREEN, "You Bought a Sanchez for 2000$");
TogglePlayerControllable(playerid, 1);}
case 8:{
new Float:x, Float:y, Float:z, Float:a;
GetPlayerPos(playerid, x, y, z);
vehicle9= CreateVehicle(471, x, y, z, 0, -1, -1, 99999999);
PutPlayerInVehicle(playerid,vehicle9,0);
GetPlayerFacingAngle(playerid,a);
SetVehicleZAngle(vehicle9,a);
DestroyMenu(Menu:Main1);
LinkVehicleToInterior(vehicle9, GetPlayerInterior(playerid));
SetCameraBehindPlayer(playerid);
GivePlayerMoney(playerid,-2500);
SendClientMessage(playerid,COLOR_GREEN, "You Bought a Quad for 2500$");
TogglePlayerControllable(playerid, 1);}
case 9:{
new Float:x, Float:y, Float:z, Float:a;
GetPlayerPos(playerid, x, y, z);
vehicle= CreateVehicle(500, x, y, z, 0, -1, -1, 99999999);
PutPlayerInVehicle(playerid,vehicle,0);
GetPlayerFacingAngle(playerid,a);
SetVehicleZAngle(vehicle,a);
DestroyMenu(Menu:Main1);
LinkVehicleToInterior(vehicle, GetPlayerInterior(playerid));
SetCameraBehindPlayer(playerid);
GivePlayerMoney(playerid,-4250);
SendClientMessage(playerid,COLOR_GREEN, "You Bought a Jeep for 4250$");
TogglePlayerControllable(playerid, 1);}
case 10:{
new Float:x, Float:y, Float:z, Float:a;
GetPlayerPos(playerid, x, y, z);
vehicle10= CreateVehicle(534, x, y, z, 0, -1, -1, 99999999);
PutPlayerInVehicle(playerid,vehicle10,0);
GetPlayerFacingAngle(playerid,a);
SetVehicleZAngle(vehicle10,a);
DestroyMenu(Menu:Main1);
LinkVehicleToInterior(vehicle10, GetPlayerInterior(playerid));
SetCameraBehindPlayer(playerid);
GivePlayerMoney(playerid,-5500);
SendClientMessage(playerid,COLOR_GREEN, "You Bought a Remington for 5500$");
TogglePlayerControllable(playerid, 1);}
case 11:{
new Float:x, Float:y, Float:z, Float:a;
GetPlayerPos(playerid, x, y, z);
vehicle11= CreateVehicle(560, x, y, z, 0, -1, -1, 99999999);
PutPlayerInVehicle(playerid,vehicle11,0);
GetPlayerFacingAngle(playerid,a);
SetVehicleZAngle(vehicle11,a);
DestroyMenu(Menu:Main1);
LinkVehicleToInterior(vehicle11, GetPlayerInterior(playerid));
SetCameraBehindPlayer(playerid);
GivePlayerMoney(playerid,-4500);
SendClientMessage(playerid,COLOR_GREEN, "You Bought a Sultan for 4500$");
TogglePlayerControllable(playerid, 1);}}}
}
return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

