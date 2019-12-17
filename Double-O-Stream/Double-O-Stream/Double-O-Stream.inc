/*
+-----------------------+
¦  >>Double-O-Stream<<  ¦
¦  The Streamerpack by  ¦
¦    Double-O-Seven     ¦
+-----------------------+

Double-O-Stream is a collection of streamers which have been made by me!
The following streamers are included:
* Double-O-Checkpoints - A checkpoint streamer
* Double-O-Icons 2 & Double-O-Icons Lite - 2 mapicon streamers, which have been made, because Double-O-Icons 1 was not fast enough.
	Double-O-Icons Lite streams only one icon per players, Double-O-Icons 2 up to 32.
* Double-O-Objects - An object streamer. The advantage on this streamer is, that when you use SetPlayerPos, it will stream the
	objects near the position where the player has been set. This is useful for stunt servers with
	many jumps.
* Double-O-Vehicles - A vehicle streamer which allows you the increase the limit of vehicles. You can use
	all vehicle functions for the stream vehicles.
* Double-O-Pickups - A simple pickup streamer which allows you to increase the limit of 400 pickups
	and which removes the bug of DestroyPickUp on Linux.

You are NOT allowed the sell this includes and you are not allowed to re-release them without my permission!
You may release this toghether with your gamemode when necessary.
Have fun with it!

Greets, Double-O-Seven!
*/

//#define DOI_Lite

#if !defined DOI_Lite
	#include <Double-O-Icons2>
#else
	#include <Double-O-Icons_Lite>
#endif
#include <Double-O-Checkpoints>
#include <Double-O-Objects>
#include <Double-O-Vehicles>
#include <Double-O-Pickups>

DOS_OnGameModeInit()
{
	DOV_OnGameModeInit();
	DOCP_OnGameModeInit();
	DOO_OnGameModeInit();
	DOP_OnGameModeInit();
	InitMapIconStreaming();
}

DOS_OnPlayerConnect(playerid)
{
	DOO_OnPlayerConnect(playerid);
	ResetMapIconVariables(playerid);	
}

DOS_OnPlayerDisconnect(playerid)
{
	DOCP_OnPlayerDisconnect(playerid);
	DOO_OnPlayerDisconnect(playerid);
}

/*
--------------------------------------
==> Functions of Double-O-Checkpoints:
--------------------------------------
native CreateCheckpoint(Float:x,Float:y,Float:z,interior,Float:size,Float:distance,showforall);
native DestroyCheckpoint(cpid);
native ShowCheckpointForAll(cpid,show);
native ShowCheckpointForPlayer(playerid,cpid,show);
native DOCP_OnPlayerDisconnect(playerid);
native DOCP_OnGameModeInit();
native CheckpointStreamer(); //Do not use this!
native GetDistanceToPoint(playerid,Float:x,Float:y,Float:z,&Float:dis);
native GetClosestCheckpoint(playerid);
native GetPlayerCheckpoint(playerid);
native IsValidCheckpoint(cpid);

---------------------------------------
==> Functions of Double-O-Icons 2/Lite:
---------------------------------------
native InitMapIconStreaming(); //Do not use this!
native CreateMapIcon(modelid,color,Float:x,Float:y,Float:z);
native DestroyMapIcon(id);
native MapIconUpdate(); //Do not use this!
native ResetMapIconVariables(playerid); //Do not use this!
native GetFreeSlot(playerid); //Do not use this!

----------------------------------
==> Functions of Double-O-Objects:
----------------------------------
native CreateStreamObject(modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, Float:distance,worldid);
native DestroyStreamObject(objectid);
native StreamObjects(); //Do not use this!
native StreamPlayerObjects(playerid,Float:x,Float:y,Float:z);
native MoveStreamObject(objectid,Float:x,Float:y,Float:z,Float:speed);
native StopStreamObject(objectid);
native DOO_SetPlayerPos(playerid,Float:x,Float:y,Float:z);
native DOO_SetVehiclePos(svehicleid,Float:x,Float:y,Float:z);
native SetStreamObjectRot(objectid, Float:rX, Float:rY, Float:rZ);
native SetStreamObjectPos(objectid, Float:x, Float:y, Float:z);
native SetObjectViewDistance(objectid,Float:distance);
native DOO_OnGameModeInit();
native DOO_OnPlayerConnect(playerid);
native DOO_OnPlayerDisconnect(playerid);
native IsValidStreamObject(objectid);

-----------------------------------
==> Functions of Double-O-Vehicles:
-----------------------------------
native DOS_OnGameModeInit(); //Do not use this!
native CreateStreamVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay);
native DestroyStreamVehicle(svehicleid);
native GetStreamVehiclePos(svehicleid, &Float:x, &Float:y, &Float:z);
native SetStreamVehiclePos(svehicleid, Float:x, Float:y, Float:z);
native GetStreamVehicleZAngle(svehicleid, &Float:z_angle);
native SetStreamVehicleZAngle(svehicleid, Float:z_angle);
native SetStreamVehicleParamsForPlayer(svehicleid,playerid,objective,doorslocked);
native SetStreamVehicleToRespawn(svehicleid);
native LinkStreamVehicleToInterior(svehicleid, interiorid);
native AddStreamVehicleComponent(svehicleid, componentid);
native RemoveStreamVehicleComponent(svehicleid, componentid);
native ChangeStreamVehicleColor(svehicleid, color1, color2);
native ChangeStreamVehiclePaintjob(svehicleid, paintjobid);
native SetStreamVehicleHealth(svehicleid, Float:health);
native GetStreamVehicleHealth(svehicleid, &Float:health);
native SetStreamVehicleNumberPlate(svehicleid, numberplate[]);
native GetStreamVehicleModel(svehicleid);
native SetStreamVehicleVirtualWorld(svehicleid, worldid);
native GetStreamVehicleVirtualWorld(svehicleid);
native GetStreamVehiclePaintjob(svehicleid);
native GetStreamVehicleColors(svehicleid,&color1,&color2);
native GetVehicleStreamID(svehicleid);
native PutPlayerInStreamVehicle(playerid, vehicleid, seatid);
native GetPlayerStreamVehicleID(playerid);
//Put the following callbacks into your script:
native OnPlayerExitStreamVehicle(playerid,svehicleid);
native OnPlayerEnterStreamVehicle(playerid,svehicleid);
native OnStreamVehicleSpawn(svehicleid);
native OnStreamVehicleDeath(svehicleid, killerid);
native OnStreamVehiclePaintjob(playerid, svehicleid, paintjobid);
native OnStreamVehicleRespray(playerid, svehicleid, color1, color2);
native OnStreamVehicleMod(playerid, svehicleid, componentid);

-----------------------------------
==> Functions of Double-O-Pickups:
-----------------------------------
native DOP_OnGameModeInit(); // Do not use this!
native OnPlayerPickUpStreamPickUp(playerid,spickupid);
native CreateStreamPickup(model, type, Float:X, Float:Y, Float:Z);
native DestroyStreamPickup(spickupid);
native StreamPickups(); // Do not use this!
native GetStreamPickupPos(spickupid,&Float:x,&Float:y,&Float:z);
native GetStreamPickupType(spickupid);
native GetStreamPickupModel(spickupid);
native SetStreamPickupPos(spickupid,Float:x,Float:y,Float:z);
native SetStreamPickupModel(spickupid,model);
native SetStreamPickupType(spickupid,type);
*/