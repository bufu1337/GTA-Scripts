/*
+-----------------------------------------------------------------------+
¦                        JunkBuster Anti-Cheat                          ¦
¦                                  by                                   ¦
¦                           Double-O-Seven                              ¦
¦                                                                       ¦
¦ You should use JunkBuster in your gamemode! If you want to use it in  ¦
¦ a filterscript, too, include JunkBusterFS  (#include <JunkBusterFS>). ¦
+-----------------------------------------------------------------------+
*/

#if defined _JB_included
	#endinput
#endif
#define _JB_included

#include <a_samp>

forward FS_PutPlayerInVehicle(playerid,vehicleid,seatid);
forward FS_GivePlayerMoney(playerid,amount);
forward FS_ResetPlayerMoney(playerid);
forward FS_GetPlayerMoney(playerid);
forward FS_SetPlayerPos(playerid,Float:x,Float:y,Float:z);
forward FS_SetVehiclePos(vehicleid,Float:x,Float:y,Float:z);
forward FS_GivePlayerWeapon(playerid,weaponid,ammo);
forward FS_SetPlayerHealth(playerid,Float:health);
forward FS_SetPlayerArmour(playerid,Float:armour);
forward FS_TogglePlayerControllable(playerid,toggle);

public FS_PutPlayerInVehicle(playerid,vehicleid,seatid)
	return CallRemoteFunction("JB_PutPlayerInVehicle","iii",playerid,vehicleid,seatid);
	
public FS_GivePlayerMoney(playerid,amount)
	return CallRemoteFunction("JB_GivePlayerMoney","ii",playerid,amount);
	
public FS_ResetPlayerMoney(playerid)
	return CallRemoteFunction("JB_ResetPlayerMoney","i",playerid);

public FS_GetPlayerMoney(playerid)
	return CallRemoteFunction("JB_GetPlayerMoney","i",playerid);
	
public FS_SetPlayerPos(playerid,Float:x,Float:y,Float:z)
	return CallRemoteFunction("JB_SetPlayerPos","ifff",playerid,x,y,z);

public FS_SetVehiclePos(vehicleid,Float:x,Float:y,Float:z)
	return CallRemoteFunction("JB_SetVehiclePos","ifff",vehicleid,x,y,z);
	
public FS_GivePlayerWeapon(playerid,weaponid,ammo)
	return CallRemoteFunction("JB_GivePlayerWeapon","iii",playerid,weaponid,ammo);
	
public FS_SetPlayerHealth(playerid,Float:health)
	return CallRemoteFunction("JB_SetPlayerHealth","if",playerid,health);
	
public FS_SetPlayerArmour(playerid,Float:armour)
	return CallRemoteFunction("JB_SetPlayerArmour","if",playerid,armour);
	
public FS_TogglePlayerControllable(playerid,toggle)
	return CallRemoteFunction("JB_TogglePlayerControllable","ii",playerid,toggle);
	
#define PutPlayerInVehicle FS_PutPlayerInVehicle
#define GivePlayerMoney FS_GivePlayerMoney
#define ResetPlayerMoney FS_ResetPlayerMoney
#define GetPlayerMoney FS_GetPlayerMoney
#define SetPlayerPos FS_SetPlayerPos
#define SetVehiclePos FS_SetVehiclePos
#define GivePlayerWeapon FS_GivePlayerWeapon
#define SetPlayerHealth FS_SetPlayerHealth
#define SetPlayerArmour FS_SetPlayerArmour
#define TogglePlayerControllable FS_TogglePlayerControllable