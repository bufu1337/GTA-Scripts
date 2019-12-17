#include <a_samp>
#define maxobj 50 // Limit
new Float:ObjCoords[maxobj][3];
new object[maxobj];
new Dropped[maxobj];
new ObjectID[maxobj][2];
new GunNames[48][] = {
	"Nothink",
	"Brass Knuckles",
	"Golf Club",
	"Nitestick",
	"Knife",
	"Baseball Bat",
	"Showel",
	"Pool Cue",
	"Katana",
	"Chainsaw",
	"Purple Dildo",
	"Small White Dildo",
	"Long White Dildo",
	"Vibrator",
	"Flowers",
	"Cane",
	"Grenade",
	"Tear Gas",
	"Molotov",
	"Vehicle Missile",
	"Hydra Flare",
	"Jetpack",
	"Glock",
	"Silenced Colt",
	"Desert Eagle",
	"Shotgun",
	"Sawn Off",
	"Combat Shotgun",
	"Micro UZI",
	"MP5",
	"AK47",
	"M4",
	"Tec9",
	"Rifle",
	"Sniper Rifle",
	"Rocket Launcher",
	"HS Rocket Launcher",
	"Flamethrower",
	"Minigun",
	"Satchel Charge",
	"Detonator",
	"Spraycan",
	"Fire Extinguisher",
	"Camera",
	"Nightvision",
	"Infrared Vision",
	"Parachute",
	"Fake Pistol"
};
new GunObjects[47][0] = { // (c) gimini
	{0},// Emty
	{331},// Brass Knuckles
	{333},// Golf Club
	{334},// Nitestick
	{335},// Knife
	{336},// Baseball Bat
	{337},// Showel
	{338},// Pool Cue
	{339},// Katana
	{341},// Chainsaw
	{321},// Purple Dildo
	{322},// Small White Dildo
	{323},// Long White Dildo
	{324},// Vibrator
	{325},// Flowers
	{326},// Cane
	{342},// Grenade
	{343},// Tear Gas
	{344},// Molotov
	{0},
	{0},
	{0},
	{346},// Glock
	{347},// Silenced Colt
	{348},// Desert Eagle
	{349},// Shotgun
	{350},// Sawn Off
	{351},// Combat Shotgun
	{352},// Micro UZI
	{353},// MP5
	{355},// AK47
	{356},// M4
	{372},// Tec9
	{357},// Rifle
	{358},// Sniper Rifle
	{359},// Rocket Launcher
	{360},// HS Rocket Launcher
	{361},// Flamethrower
	{362},// Minigun
	{363},// Detonator
	{364},// Detonator Button
	{365},// Spraycan
	{366},// Fire Extinguisher
	{367},// Camera
	{368},// Nightvision
	{368},// Infrared Vision
	{371}// Parachute
};
public OnFilterScriptInit(){
	print("\n--------------------------------------");
	print("      Drop Gun [FS] By gimini (c)");
	print("      Do not remove copyright!!!");
	print("      Version 1.1");
	print("--------------------------------------\n");
	return 1;
}
public OnFilterScriptExit(){
    print("\n--------------------------------------");
    print("  Drop Gun FS 1.1 successfully unloaded!");
    print("\n--------------------------------------");
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[]){
	new cmd[256];
	new idx;
	cmd = strtok(cmdtext, idx);
	if(strcmp(cmd, "/dropgun", true) == 0 || strcmp(cmd, "/dgun", true) == 0){
		new gunID = GetPlayerWeapon(playerid);
		new gunAmmo = GetPlayerAmmo(playerid);
		if(gunID != 0 && gunAmmo != 0){
			new f = maxobj+1;
			for(new a = 0; a < sizeof(ObjCoords); a++){
				if(ObjCoords[a][0] == 0.0) f = a;
			}
			if(f == maxobj+1) return SendClientMessage(playerid, 0x33AA3300, "You can not throw weapons at the moment, try back later!!");
   			else{
   			    new gunname[100];
			    new buffer[512];
				GetWeaponNameEx(gunID, gunname, sizeof(gunname));
				format(buffer, sizeof(buffer), "You threw %s", gunname);
				SendClientMessage(playerid, 0x33AA3300, buffer);
				RemovePlayerWeapon(playerid, gunID);
				ObjectID[f][0] = gunID;
				ObjectID[f][1] = gunAmmo;
		        GetPlayerPos(playerid, ObjCoords[f][0], ObjCoords[f][1], ObjCoords[f][2]);
		        object[f] = CreateObject(GunObjects[gunID][0],ObjCoords[f][0],ObjCoords[f][1],ObjCoords[f][2]-1,93.7,120.0,120.0);
			}
			return 1;
		}
	}
	if(strcmp(cmd, "/pickupgun", true) == 0 || strcmp(cmd, "/pgun", true) == 0){
		new f = maxobj+1;
		for(new a=0;a<sizeof(ObjCoords);a++){
			if(IsPlayerInRangeOfPoint(playerid, 5.0, ObjCoords[a][0], ObjCoords[a][1], ObjCoords[a][2])){
				f = a;
			}
		}
		if(f == maxobj+1 || Dropped[f] == 1) return SendClientMessage(playerid, 0x33AA3300, "You are not near the weapon which you can pick up!");
		else{
		    new gunname[100];
		    new buffer[512];
		    ObjCoords[f][0] = 0.0;
			ObjCoords[f][1] = 0.0;
			ObjCoords[f][2] = 0.0;
			DestroyObject(object[f]);
			GivePlayerWeapon(playerid, ObjectID[f][0], ObjectID[f][1]);
			GetWeaponNameEx(ObjectID[f][0], gunname, sizeof(gunname));
			format(buffer, sizeof(buffer), "You picked up %s", gunname);
			SendClientMessage(playerid, 0x33AA3300, buffer);
		}
		return 1;
	}
	return 0;
}
stock GetWeaponNameEx(id, name[], len) return format(name,len, "%s", GunNames[id]);
stock RemovePlayerWeapon(playerid, weaponid);
public RemovePlayerWeapon(playerid, weaponid){
	new plyWeapons[12] = 0;
	new plyAmmo[12] = 0;
	for(new sslot = 0; sslot != 12; sslot++){
		new wep, ammo;
		GetPlayerWeaponData(playerid, sslot, wep, ammo);
		if(wep != weaponid && ammo != 0){
			GetPlayerWeaponData(playerid, sslot, plyWeapons[sslot], plyAmmo[sslot]);
		}
	}
	ResetPlayerWeapons(playerid);
	for(new sslot = 0; sslot != 12; sslot++){
	    if(plyAmmo[sslot] != 0){
			GivePlayerWeapon(playerid, plyWeapons[sslot], plyAmmo[sslot]);
		}
	}
	return 1;
}
strtok(const string[], &index){
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' ')){
		index++;
	}
	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1))){
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}