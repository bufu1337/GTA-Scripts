#include <a_samp>
#define red 0xFF0000FF
#define yellow 0xFFFF00AA
#define green 0x33FF33AA
new Para;
new SecondIsland[MAX_PLAYERS];

main()
{
	print("\n//------------------------------//");
	print("          Parkour by GTA44          ");
	print("//------------------------------//\n");
}

public OnGameModeInit()
{
	ShowPlayerMarkers(1);
	ShowNameTags(1);
	UsePlayerPedAnims();
	EnableTirePopping(0);
	AllowInteriorWeapons(1);
	EnableZoneNames(0);
	EnableStuntBonusForAll(1);
	SetWorldTime(12);
	SetWeather(10);
	SetGameModeText("Parkour");

	AddPlayerClass(299, 4379.4395, -1338.8160, 46.5095, 92.2321, 0, 0, 0, 0, 0, 0);

	CreateObject(17944, 4297.042969, -1318.828491, 26.259535, 0.0000, 0.0000, 270.0000);
	CreateObject(17944, 4136.693848, -1346.986084, 26.862648, 0.0000, 0.0000, 78.7500);
	CreateObject(17944, 4174.289063, -1449.887451, 22.815914, 0.0000, 0.0000, 191.2500);
	CreateObject(1437, 4179.455566, -1451.715454, 14.430271, 328.2008, 0.0000, 191.2500);
	CreateObject(1437, 4178.923828, -1449.004272, 11.331102, 328.2008, 0.0000, 191.2500);
	CreateObject(3663, 4196.202637, -1500.114014, 26.925531, 0.0000, 0.0000, 101.2500);
	CreateObject(3663, 4191.470703, -1505.883057, 29.821692, 50.7067, 342.8113, 95.2340);
	CreateObject(3663, 4195.508301, -1496.185425, 24.687506, 0.0000, 0.0000, 101.2500);
	CreateObject(3663, 4195.029297, -1493.353027, 23.088598, 0.0000, 0.0000, 101.2500);
	CreateObject(3663, 4153.654785, -1512.584839, 29.471697, 50.7067, 342.8113, 263.9839);
	CreateObject(3663, 4164.631348, -1568.238037, 29.461948, 50.7067, 342.8113, 185.2339);
	CreateObject(3663, 4158.786621, -1565.981934, 29.203272, 50.7067, 342.8113, 117.7338);
	CreateObject(3663, 4157.829590, -1561.429565, 28.228245, 50.7067, 342.8113, 117.7338);
	CreateObject(17901, 4148.522461, -1518.913330, 20.577833, 0.0000, 0.0000, 101.2500);
	CreateObject(17859, 4106.538574, -1522.629395, 31.026749, 0.0000, 0.0000, 101.2500);
	CreateObject(17804, 4061.825195, -1541.412598, 25.583408, 0.0000, 0.0000, 11.2500);
	CreateObject(18367, 4082.753906, -1527.618286, 28.049229, 0.0000, 0.0000, 281.2500);
	CreateObject(18367, 4259.456543, -1348.807129, 25.226387, 334.2169, 0.0000, 87.6625);
	CreateObject(18367, 4213.067383, -1342.658325, 10.460730, 334.2169, 0.0000, 79.9276);
	CreateObject(18367, 4116.915527, -1397.356812, 13.233803, 334.2169, 0.0000, 87.6625);
	CreateObject(18367, 4138.836914, -1396.049927, 12.250731, 334.2169, 0.0000, 286.1927);
	CreateObject(3663, 4139.267090, -1520.501465, 27.629364, 359.1405, 0.8594, 14.7651);
	CreateObject(2780, 4210.212402, -1349.068481, 16.078766, 0.0000, 0.0000, 0.0000);
	CreateObject(2780, 4212.779785, -1335.463257, 16.073586, 0.0000, 0.0000, 0.0000);
	CreateObject(2780, 4139.306152, -1396.096313, 12.032031, 0.0000, 0.0000, 0.0000);
	CreateObject(2780, 4149.639160, -1393.858887, 12.032030, 0.0000, 0.0000, 0.0000);
	CreateObject(2780, 4192.505371, -1504.240479, 28.575859, 0.0000, 0.0000, 0.0000);
	CreateObject(2780, 4162.151367, -1564.840454, 27.987633, 0.0000, 0.0000, 0.0000);
	CreateObject(2780, 4152.100586, -1512.333740, 28.065914, 0.0000, 0.0000, 0.0000);
	CreateObject(2780, 4120.735840, -1526.482422, 28.804396, 0.0000, 0.0000, 175.2211);
	CreateObject(2780, 4119.854980, -1521.042114, 28.804396, 0.0000, 0.0000, 0.0000);
	CreateObject(2780, 4103.582520, -1529.908203, 28.583334, 0.0000, 0.0000, 175.2211);
	CreateObject(2780, 4102.371094, -1524.641846, 28.542252, 0.0000, 0.0000, 16.3294);
	CreateObject(2780, 4070.101074, -1530.358643, 31.844431, 0.0000, 0.0000, 16.3294);
	CreateObject(4564, 4049.161133, -2284.628418, 108.964973, 0.0000, 0.0000, 0.0000);
	CreateObject(6351, 3990.205322, -2292.363770, 14.637174, 0.0000, 0.0000, 157.5000);
	CreateObject(17690, 3918.156738, -2292.574219, -6.724265, 343.6707, 0.0000, 270.0000);
	CreateObject(17067, 3851.284912, -2292.912842, 15.892159, 0.0000, 0.0000, 303.7500);
	CreateObject(10634, 3805.942871, -2318.135986, 12.523985, 0.0000, 0.0000, 191.2500);
	CreateObject(9904, 3802.340576, -2396.220215, 20.329367, 0.0000, 0.0000, 236.2501);
	CreateObject(9581, 3824.391113, -2487.455322, 34.709778, 0.0000, 0.0000, 11.2500);

	Para = CreatePickup(371,2,4073.7278,-1613.9264,26.1166);

	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerInterior(playerid,17);
	SetPlayerPos(playerid,486.0409, -9.4562, 1000.6719);
	SetPlayerFacingAngle(playerid, 137.9666);
	SetPlayerCameraPos(playerid, 483.809051, -13.435981, 1000.679687);
	SetPlayerCameraLookAt(playerid, 486.0409, -9.4562, 1000.6719);
	return 1;
}

public OnPlayerConnect(playerid)
{
    new pName[30], string[256];
    GetPlayerName(playerid, pName, 30);
    format(string, 256, "~g~Welcome ~n~~r~%s!", pName);
	GameTextForPlayer(playerid,string,4000,1);
	SendClientMessage(playerid,red,"Parkour");
	SendClientMessage(playerid,red,"To get help, just type /help");
	SetPlayerCheckpoint(playerid,3829.7771,-2535.9448,51.0510,3);
	SecondIsland[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerInterior(playerid,0);
	SetCameraBehindPlayer(playerid);
	SetPlayerHealth(playerid,100);
	SetPlayerArmour(playerid,0);
	if (SecondIsland[playerid] == 1){
	SetPlayerPos(playerid,4043.0613,-2301.9531,219.2495);
	GivePlayerWeapon(playerid,46,1);}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	GameTextForPlayer(playerid,"Wasted",4000,2);
	SendDeathMessage(killerid, playerid, reason);
	return 1;
}

public OnPlayerPickUpPickup(playerid,pickupid)
{
	if (pickupid == Para){
	SetPlayerPos(playerid,4043.0613,-2301.9531,219.2495);
	SendClientMessage(playerid,yellow,"Second Island Checkpoint Reached. Parachute down to the rest of the island to get to the end.");
	GameTextForPlayer(playerid,"~w~Second Island ~n~~r~Checkpoint Reached",3000,5);
	SecondIsland[playerid] = 1;}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/help", cmdtext, true, 10) == 0)
	{
	SendClientMessage(playerid,red,"Parkour");
	SendClientMessage(playerid,green,"By GTA44 (2008)");
	SendClientMessage(playerid,yellow,"Aim: Climb the buildings, jump from roof to roof, and fight to the finish in this all-new gamemode made with MTA and SA-MP!");
	return 1;
	}

	return 0;
}

public OnPlayerEnterCheckpoint(playerid)
{
    new pName[30], string[256];
    GetPlayerName(playerid, pName, 30);
	format(string, 256, "%s finished the Parkour Run!", pName);
	SendClientMessageToAll(green,string);
	SendClientMessage(playerid,yellow,"Well done, you made it to the end! You have been taken back to the start.");
	GameTextForPlayer(playerid,"~r~The End",3000,3);
	SetPlayerPos(playerid,4379.4395,-1338.8160,46.5095);
	SetPlayerHealth(playerid,100);
	SecondIsland[playerid] = 0;
	return 1;
}

