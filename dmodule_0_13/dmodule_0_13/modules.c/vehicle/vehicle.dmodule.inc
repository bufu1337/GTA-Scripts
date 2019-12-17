/*  SA:MP Vehicle Functions
 *
 *  (c) Copyright 2005-2006, SA:MP Team
 *
 */

#pragma library vehicles

#define INVALID_VEHICLE_ID						(0xFFFF)
#define MAX_VEHICLES							(700)

native AddStaticVehicle(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2);
native AddStaticVehicleEx(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2, respawn_delay);
native CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay);
native DestroyVehicle(vehicleid);
native GetVehiclePos(vehicleid, &Float:x, &Float:y, &Float:z);
native SetVehiclePos(vehicleid, Float:x, Float:y, Float:z);
native GetVehicleZAngle(vehicleid, &Float:z_angle);
native SetVehicleZAngle(vehicleid, Float:z_angle);
native SetVehicleParamsForPlayer(vehicleid,playerid,objective,doorslocked);
native SetVehicleToRespawn(vehicleid);
native LinkVehicleToInterior(vehicleid, interiorid);
native AddVehicleComponent(vehicleid, componentid);
native RemoveVehicleComponent(vehicleid, componentid);
native ChangeVehicleColor(vehicleid, color1, color2);
native ChangeVehiclePaintjob(vehicleid, paintjobid);
native SetVehicleHealth(vehicleid, Float:health);
native GetVehicleHealth(vehicleid, &Float:health);
native AttachTrailerToVehicle(trailerid, vehicleid);
native DetachTrailerFromVehicle(vehicleid);
native IsTrailerAttachedToVehicle(vehicleid);
native GetVehicleTrailer(vehicleid);
native SetVehicleNumberPlate(vehicleid, numberplate[]);
native GetVehicleModel(vehicleid);

// Virtual Worlds
native SetVehicleVirtualWorld(vehicleid, worldid);
native GetVehicleVirtualWorld(vehicleid);

native PutPlayerInVehicle(playerid, vehicleid, seatid);
native GetPlayerVehicleID(playerid);
native RemovePlayerFromVehicle(playerid);
native IsPlayerInVehicle(playerid, vehicleid);
native IsPlayerInAnyVehicle(playerid);

// Spectating
native PlayerSpectateVehicle(playerid, targetvehicleid, mode = SPECTATE_MODE_NORMAL);

forward OnVehicleSpawn(vehicleid);
public OnVehicleSpawn(vehicleid) _VehicleSpawn(vehicleid);
forward OnVehicleDeath(vehicleid, killerid);
public OnVehicleDeath(vehicleid, killerid) _VehicleDeath(vehicleid, killerid);
forward OnVehicleMod(vehicleid, componentid);
public OnVehicleMod(vehicleid, componentid) _VehicleMod(vehicleid, componentid);
forward OnVehiclePaintjob(vehicleid, paintjobid);
public OnVehiclePaintjob(vehicleid, paintjobid) _VehiclePaintjob(vehicleid, paintjobid);
forward OnVehicleRespray(vehicleid, color1, color2);
public OnVehicleRespray(vehicleid, color1, color2) _VehicleRespray(vehicleid, color1, color2);
forward OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) _EnterVehicle(playerid, vehicleid, ispassenger);
forward OnPlayerExitVehicle(playerid, vehicleid);
public OnPlayerExitVehicle(playerid, vehicleid) _ExitVehicle(playerid, vehicleid);
