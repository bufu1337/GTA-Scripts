#include <a_samp>

#define COLOR_RED 0xAA3333AA

new aWeaponNames[][32] = {
	{"Fist"}, // 0
	{"Brass Knuckles"}, // 1
	{"Golf Club"}, // 2
	{"Night Stick"}, // 3
	{"Knife"}, // 4
	{"Baseball Bat"}, // 5
	{"Shovel"}, // 6
	{"Pool Cue"}, // 7
	{"Katana"}, // 8
	{"Chainsaw"}, // 9
	{"Purple Dildo"}, // 10
	{"Vibrator"}, // 11
	{"Vibrator"}, // 12
	{"Vibrator"}, // 13
	{"Flowers"}, // 14
	{"Cane"}, // 15
	{"Grenade"}, // 16
	{"Teargas"}, // 17
	{"Molotov"}, // 18
	{" "}, // 19
	{" "}, // 20
	{" "}, // 21
	{"Colt 45"}, // 22
	{"Silenced Pistol"}, // 23
	{"Deagle"}, // 24
	{"Shotgun"}, // 25
	{"Sawns"}, // 26
	{"Spas"}, // 27
	{"Uzi"}, // 28
	{"MP5"}, // 29
	{"AK47"}, // 30
	{"M4"}, // 31
	{"Tec9"}, // 32
	{"Country Rifle"}, // 33
	{"Sniper Rifle"}, // 34
	{"Rocket Launcher"}, // 35
	{"Heat-Seeking Rocket Launcher"}, // 36
	{"Flamethrower"}, // 37
	{"Minigun"}, // 38
	{"Satchel Charge"}, // 39
	{"Detonator"}, // 40
	{"Spray Can"}, // 41
	{"Fire Extinguisher"}, // 42
	{"Camera"}, // 43
	{"Night Vision Goggles"}, // 44
	{"Infrared Vision Goggles"}, // 45
	{"Parachute"}, // 46
	{"Fake Pistol"} // 47
};

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Simple & Accurate Anti-C-Bug by [___]Whitetiger.");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys & KEY_FIRE) && (newkeys & KEY_HANDBRAKE)) { //handbrake = aim
		SetTimerEx("CrouchCheck", 3000, 0, "d", playerid);
		SetPVarInt(playerid, "CheckCrouch", 1);
		new weaponid = GetPlayerWeapon(playerid);
		SetPVarInt(playerid, "WeaponId", weaponid);
	}
	else if(newkeys == KEY_FIRE) {
	    SetTimerEx("CrouchCheck", 3000, 0, "d", playerid);
		SetPVarInt(playerid, "CheckCrouch", 1);
		new weaponid = GetPlayerWeapon(playerid);
		SetPVarInt(playerid, "WeaponId", weaponid);
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
	new checkcbug = GetPVarInt(playerid, "CheckCrouch");
	if(checkcbug == 1) {
		new weaponid = GetPVarInt(playerid, "WeaponId");
		if(weaponid == 24 || weaponid == 25 || weaponid == 27 || weaponid == 29 || weaponid == 23 || weaponid == 29
		|| weaponid == 30 || weaponid == 31 || weaponid == 33 || weaponid == 34 || weaponid == 41) {
		    new Keys, ud, lr;
		    GetPlayerKeys(playerid, Keys, ud, lr);
		    if(Keys == KEY_CROUCH) {
		    	OnPlayerCBug(playerid);
		    	SetPVarInt(playerid, "CheckCrouch", 0);
		    }
		}
	}
	return 1;
}

forward OnPlayerCBug(playerid);
public OnPlayerCBug(playerid) {
	new weaponid = GetPVarInt(playerid, "WeaponId");
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, sizeof(playername));
	new str2[128];
	format(str2, sizeof(str2), "Automatic system has kicked %s for Crouch bugging with weapon (%s!)", playername, aWeaponNames[weaponid]);
	SendClientMessageToAll(COLOR_RED, str2);
	Kick(playerid);
	return 1;
}
forward CrouchCheck(playerid);
public CrouchCheck(playerid) {
	SetPVarInt(playerid, "CheckCrouch", 0);

}