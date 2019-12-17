/*
+---------------------------------------------------------------------------+
¦                        JunkBuster Anti-Cheat                              ¦
¦                                  by                                       ¦
¦                           Double-O-Seven                                  ¦
¦                                                                           ¦
¦ You should use JunkBuster.inc in your gamemode! If you want to use it in  ¦
¦ a filterscript, too, include JunkBuster_Client.inc (this include here)!        ¦
¦ (#include <JunkBuster_Client>) 												¦
+---------------------------------------------------------------------------+
*/

#if defined _JB_included
	#endinput
#endif
#define _JB_included

#define Public:%0(%1) 	forward %0(%1); \
						public %0(%1)

#include <a_samp>

Public:JBC_PutPlayerInVehicle(playerid,vehicleid,seatid)
	return CallRemoteFunction("JB_PutPlayerInVehicle","iii",playerid,vehicleid,seatid);
	
Public:JBC_GivePlayerMoney(playerid,amount)
	return CallRemoteFunction("JB_GivePlayerMoney","ii",playerid,amount);
	
Public:JBC_ResetPlayerMoney(playerid)
	return CallRemoteFunction("JB_ResetPlayerMoney","i",playerid);

Public:JBC_GetPlayerMoney(playerid)
	return CallRemoteFunction("JB_GetPlayerMoney","i",playerid);
	
Public:JBC_SetPlayerPos(playerid,Float:x,Float:y,Float:z)
	return CallRemoteFunction("JB_SetPlayerPos","ifff",playerid,x,y,z);

Public:JBC_SetVehiclePos(vehicleid,Float:x,Float:y,Float:z)
	return CallRemoteFunction("JB_SetVehiclePos","ifff",vehicleid,x,y,z);
	
Public:JBC_SetVehicleVelocity(vehicleid,Float:x,Float:y,Float:z)
	return CallRemoteFunction("JB_SetVehicleVelocity","ifff",vehicleid,x,y,z);
	
Public:JBC_GivePlayerWeapon(playerid,weaponid,ammo)
	return CallRemoteFunction("JB_GivePlayerWeapon","iii",playerid,weaponid,ammo);
	
Public:JBC_SetPlayerHealth(playerid,Float:health)
	return CallRemoteFunction("JB_SetPlayerHealth","if",playerid,health);
	
Public:JBC_SetPlayerArmour(playerid,Float:armour)
	return CallRemoteFunction("JB_SetPlayerArmour","if",playerid,armour);
	
Public:JBC_SetVehicleHealth(vehicleid,Float:health)
	return CallRemoteFunction("JB_SetVehicleHealth","if",vehicleid,health);
	
Public:JBC_TogglePlayerControllable(playerid,toggle)
	return CallRemoteFunction("JB_TogglePlayerControllable","ii",playerid,toggle);
	
Public:JBC_SetPlayerSpecialAction(playerid,actionid)
	return CallRemoteFunction("JB_SetPlayerSpecialAction","ii",playerid,actionid);
	
Public:JBC_GetPlayerFPS(playerid)
	return CallRemoteFunction("GetPlayerFPS","i",playerid);
	
#define PutPlayerInVehicle 			JBC_PutPlayerInVehicle
#define GivePlayerMoney 			JBC_GivePlayerMoney
#define ResetPlayerMoney 			JBC_ResetPlayerMoney
#define GetPlayerMoney 				JBC_GetPlayerMoney
#define SetPlayerPos 				JBC_SetPlayerPos
#define SetVehiclePos 				JBC_SetVehiclePos
#define GivePlayerWeapon 			JBC_GivePlayerWeapon
#define SetPlayerHealth 			JBC_SetPlayerHealth
#define SetPlayerArmour 			JBC_SetPlayerArmour
#define SetVehicleHealth 			JBC_SetVehicleHealth
#define GetPlayerFPS                JBC_GetPlayerFPS
#define TogglePlayerControllable 	JBC_TogglePlayerControllable
#define SetVehicleVelocity 			JBC_SetVehicleVelocity
#define SetPlayerSpecialAction 		JBC_SetPlayerSpecialAction
