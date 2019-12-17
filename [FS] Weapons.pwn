#include <a_samp>
#include <dini> //	Programmed with Dini.inc version 1.5.1

/*
	Weapons Saving System by Phyro - 2009
	Searching some technical SA-MP Tools ? visit : www.phyro.co.nr
	Email : mottiokla@gmail.com
*/

#define PATH "Weapons"  //  Folder where players data saved

new bool:AlreadyGiveWeapons[MAX_PLAYERS];

public OnFilterScriptInit()
{
	printf("|------------------------------------------------|");
	printf("|-------- Weapons Saving System By Phyro --------|");
	printf("|----------- All rights reserved 2009 -----------|");
	printf("|------------------------------------------------|");
	return 1;
}

public OnFilterScriptExit()
{
    printf("|------------------------------------------------|");
    printf("|--------- Unload Weapons Saving System ---------|");
    printf("|------------------------------------------------|");
	return 1;
}

public OnPlayerConnect(playerid)
{
    AlreadyGiveWeapons[playerid] = false;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	SaveWeaponsToFile(playerid);
	return 1;
}

SaveWeaponsToFile(playerid)
{
	new i, path[50], string[128], weaponid, ammo;
    path = GetPlayerFormattedName(playerid);
    if (!dini_Exists(path)) dini_Create(path);
	for (i=0; i<13; i++)
	{
	    GetPlayerWeaponData(playerid,i,weaponid,ammo);
	    format(string,sizeof(string),"Weapon - %d",i);
	    dini_IntSet(path,string,weaponid);
	    format(string,sizeof(string),"AmmoID - %d",i);
	    dini_IntSet(path,string,ammo == 65535 ? 0 : ammo);
	}
}

forward LoadWeaponsToFile(playerid);
public LoadWeaponsToFile(playerid)
{
	new i, path[50], string[128], weaponid, ammo;
    path = GetPlayerFormattedName(playerid);
    ResetPlayerWeapons(playerid);
	for (i=0; i<13; i++)
	{
	    format(string,sizeof(string),"Weapon - %d",i);
	    weaponid = dini_Int(path,string);
	    format(string,sizeof(string),"AmmoID - %d",i);
	    ammo = dini_Int(path,string);
	    GivePlayerWeapon(playerid,weaponid,ammo);
	}
	AlreadyGiveWeapons[playerid] = true;
}

GetPlayerFormattedName(playerid)
{
	new name[24], full[50];
 	GetPlayerName(playerid,name,sizeof(name));
 	format(full,sizeof(full),"%s/%s.txt",PATH,name);
 	return full;
}

public OnPlayerSpawn(playerid)
{
	if (!AlreadyGiveWeapons[playerid]) SetTimerEx("LoadWeaponsToFile",250,false,"i",playerid);
	return 1;
}
