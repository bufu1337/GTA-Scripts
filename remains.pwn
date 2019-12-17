/*  remains.pwn
 *
 *  (c) Copyright 2015, Emilijo "Correlli" Lovrich
 *
 *  Credits: - Incognito for streamer plugin,
 *			 - Y_Less for foreach/iterator.
*/

#include "a_samp"
#include "foreach"
#include "streamer"

/* ----- */

#define MAX_REMAINS																(25)
#define TYPE_REMAINS_PERSON														(1)
#define TYPE_REMAINS_CAR														(2)
#define INVALID_SCRIPT_ID														(-1)

/* ----- */

new
		Iterator:Remains<MAX_REMAINS>;

enum DataRemains
{
	Type,
	Model,
	Time,
	Text3D:Information
}

new
		RemainsData[MAX_REMAINS][DataRemains], timer;

/* ----- */

forward Global_Timer();
public Global_Timer()
{
	new
			iter_next;
	foreach(Remains, a)
	{
		if(RemainsData[a][Time] > 0)
			RemainsData[a][Time]--;
		else
		{
			DestroyRemains(a, true);
			Iter_SafeRemove(Remains, a, iter_next);
			a = iter_next;
		}
	}
	return true;
}

stock IsVehicleRemainsType(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
		case
			400..402, 404, 405, 409..413, 415, 418..422, 424, 426, 429, 434, 436,
			438..440, 442, 445, 451, 457..459, 466, 467, 470, 474, 475, 477..480,
			482, 483, 485, 489..492, 494..496, 500, 502..507, 516..518, 525..531,
			533..536, 540..543, 545..547, 549..552, 554, 555, 558..562, 565..568,
			572..576, 578..580, 582, 583, 585, 587, 589, 596..605:
				return true;
	}
	return false;
}

stock CreateRemains(type, model, time, Float:pos_x, Float:pos_y, Float:pos_z, Float:angle, world, interior, Float:distance = 150.0)
{
	new
			r_id = Iter_Free(Remains);
	if(r_id == INVALID_SCRIPT_ID)
		return INVALID_SCRIPT_ID;
	Iter_Add(Remains, r_id);
	// Type of the remains.
	RemainsData[r_id][Type]				=					   type;
	// Model of the remains.
	switch(type)
	{
		case TYPE_REMAINS_PERSON:
		{
			// Actor for the remains.
			RemainsData[r_id][Model]	=				CreateActor(
				model,
				pos_x,
				pos_y,
				pos_z,
				angle
			);
			SetActorVirtualWorld(RemainsData[r_id][Model],	world);
			SetActorHealth(RemainsData[r_id][Model],		  0.0);
			pos_z = (pos_z - 0.5);
		}
		case TYPE_REMAINS_CAR:
		{
			// Object for the remains.
			RemainsData[r_id][Model]	=		CreateDynamicObject(
				12957,
				pos_x,
				pos_y,
				pos_z,
				0.0,
				0.0,
				(angle + 180.0),
				world,
				interior,
				INVALID_SCRIPT_ID,
				distance
			);
			pos_z = (pos_z + 1.0);
		}
	}
	// Time before the remains are destroyed.
	RemainsData[r_id][Time]				=					   time;
	// 3d label for the remains.
	RemainsData[r_id][Information]		=  CreateDynamic3DTextLabel(
		Remains_Label(type),
		0x00E1FFFF,
		pos_x,
		pos_y,
		pos_z,
		10.0,
		INVALID_PLAYER_ID,
		INVALID_VEHICLE_ID,
		1,
		world,
		interior,
		INVALID_SCRIPT_ID,
		10.0
	);
	return r_id;
}

stock DestroyRemains(r_id, bool:iter = false)
{
	if(!Iter_Contains(Remains, r_id))
		return false;
	if(!iter)
		Iter_Remove(Remains, r_id);
	// Model of the remains.
	switch(RemainsData[r_id][Type])
	{
		case TYPE_REMAINS_PERSON:
		{
			if(IsValidActor(RemainsData[r_id][Model]))
				DestroyActor(RemainsData[r_id][Model]);
		}
		case TYPE_REMAINS_CAR:
		{
			if(IsValidDynamicObject(RemainsData[r_id][Model]))
				DestroyDynamicObject(RemainsData[r_id][Model]);
		}
	}
	RemainsData[r_id][Model]			=					 0xFFFF;
	// Type of the remains.
	RemainsData[r_id][Type]				=						  0;
	// Remains time.
	RemainsData[r_id][Time]				=						  0;
	// 3d label for the remains.
	if(IsValidDynamic3DTextLabel(RemainsData[r_id][Information]))
	{
		DestroyDynamic3DTextLabel(RemainsData[r_id][Information]);
		RemainsData[r_id][Information] = Text3D:INVALID_3DTEXT_ID;
	}
	return true;
}

stock Remains_Label(type)
{
	new
			string[57];
	switch(type)
	{
		case TYPE_REMAINS_PERSON:	format(string, 54, "같같같같같같같같같같\nDead body\n같같같같같같같같같같");
		case TYPE_REMAINS_CAR:		format(string, 57, "같같같같같같같같같같\nCar wreckage\n같같같같같같같같같같");
	}
	return string;
}

/* ----- */

public OnFilterScriptInit()
{
	timer = SetTimer("Global_Timer", 1000, true);
	return true;
}

public OnFilterScriptExit()
{
	KillTimer(timer);

	new
			iter_next;
	foreach(Remains, a)
	{
		DestroyRemains(a, true);
		Iter_SafeRemove(Remains, a, iter_next);
		a = iter_next;
	}
	return true;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new
			Float:pos[4];
	GetPlayerPos(playerid,			pos[0], pos[1], pos[2]);
	GetPlayerFacingAngle(playerid,	pos[3]);
	CreateRemains(
		TYPE_REMAINS_PERSON,
		GetPlayerSkin(playerid),
		120, // 2 minutes.
		pos[0],
		pos[1],
		pos[2],
		pos[3],
		GetPlayerVirtualWorld(playerid),
		GetPlayerInterior(playerid)
	);
	return true;
}

public OnVehicleDeath(vehicleid, killerid)
{
	if(IsVehicleRemainsType(vehicleid))
	{
		new
				Float:pos[4];
		GetVehiclePos(vehicleid,	pos[0], pos[1], pos[2]);
		GetVehicleZAngle(vehicleid, pos[3]);
		CreateRemains(
			TYPE_REMAINS_CAR,
			INVALID_SCRIPT_ID,
			120, // 2 minutes.
			pos[0],
			pos[1],
			pos[2],
			pos[3],
			GetVehicleVirtualWorld(vehicleid),
			INVALID_SCRIPT_ID
		);
	}
	return true;
}
