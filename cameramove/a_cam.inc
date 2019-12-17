#include <a_samp>

// You may not claim this as your own
// Especially not if your name is "Rks" or "Rksss" or "Rks_"
// Credits to [Chronic]Chesh, and me

// Other info:
// Use "SetCameraLookAtForPlayer/All" BEFORE using SetCameraPosForPlayer/All


// Setting up variables, defines...

#define MODEL_ID 0

#define SLOW_SPEED 1
#define MEDIUM_SPEED 2
#define FAST_SPEED 3

#define INTENSE_LOW 2
#define INTENSE_MEDIUM 3
#define INTENSE_HIGH 4

// millisecond
#define SLOW_SHAKE 4000
#define MEDIUM_SHAKE 3000
#define FAST_SHAKE 500

#define FOLLOW_MODE_1 1
#define FOLLOW_MODE_2 2

enum cInfo
{
	Float:camPosX,
	Float:camPosY,
	Float:camPosZ,
	Float:camPosLookX,
	Float:camPosLookY,
	Float:camPosLookZ,
	
	camObject,
	camLookObject,
	
	Float:camMoveSpeed,
	bool:camMoving,
	
	bool:camShaking,
	
	bool:camMovePos, bool:camMoveLook,
	bool:camFollow, camFollowMode
}

new CameraInfo[MAX_PLAYERS][cInfo];

// Forwards..
forward MoveCameraPosForPlayer(playerid, Float:x, Float:y, Float:z, Float:speed);
forward MoveCameraLookAtForPlayer(playerid, Float:x, Float:y, Float:z, Float:speed);
forward SetCameraPosForPlayer(playerid, Float:x, Float:y, Float:z);
forward SetCameraLookAtForPlayer(playerid, Float:x, Float:y, Float:z);
forward ResetCameraForPlayer(playerid);
forward ShakeCameraForPlayer(playerid, time, speed, intense);
forward SetCameraFollowPlayerForPlayer(playerid, id, time);
forward SetCameraFollowVehicleForPlayer(playerid,  vehicleid, time);

// "-Get" Forwards...
forward GetCameraPos(playerid, &Float:x, &Float:y, &Float:z);
forward GetCameraLookAt(playerid, &Float:x, &Float:y, &Float:z);
forward GetCameraSpeed(playerid, &Float:speed);

// "-Is" Forwards...
forward IsPlayerCameraMoving(playerid);
forward IsCameraPosInvalid(playerid);
forward IsCameraLookAtInvalid(playerid)

// Other forwards..
forward CameraUpdate(playerid);
forward KillShake(playerid);
forward ShakeTimer(playerid, speed, intense);
forward Float:GetAngle(Float:x, Float:y, Float:ix, Float:iy);
forward KillFollow(playerid);
forward Follow(playerid, id);forward KillFollow(playerid);
forward Follow(playerid, id);

// Loopings
forward MoveCameraPosForAll(Float:x, Float:y, Float:z, speed);
forward MoveCameraLookAtForAll(Float:x, Float:y, Float:z, speed);
forward SetCameraPosForAll(Float:x, Float:y, Float:z);
forward SetCameraLookAtForAll(Float:x, Float:y, Float:z);
forward ResetCameraForAll();
forward ShakeCameraForAll(time, speed, speed_between_next_shake);
forward SetCameraFollowPlayerForAll(id, time);
forward SetCameraFollowVehicleForAll(vehicleid, time);

// IMPORTANT!


/* === Put this in OnPlayerConnect! === *
*
*      OnPlayerConnect:
*                   Camera_Join(playerid);
*/

#define Camera_Join(%1); CM_PlayerJoin(%1);

stock CM_PlayerJoin(playerid)
{
	SetTimerEx("CameraUpdate", 50, 0, "i", playerid);
	CameraInfo[playerid][camObject] = CreatePlayerObject(playerid, MODEL_ID, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	CameraInfo[playerid][camLookObject] = CreatePlayerObject(playerid, MODEL_ID, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	CameraInfo[playerid][camPosX] = -0.0;
	CameraInfo[playerid][camPosY] = -0.0;
	CameraInfo[playerid][camPosZ] = -0.0;
	
	CameraInfo[playerid][camPosLookX] = -0.0;
	CameraInfo[playerid][camPosLookY] = -0.0;
	CameraInfo[playerid][camPosLookZ] = -0.0;
}

/* === Put this in OnPlayerDisconnect! === *
*
*      OnPlayerDisconnect:
*                   Camera_Leave(playerid);
*/

#define Camera_Leave(%1); CM_PlayerLeave(%1);

stock CM_PlayerLeave(playerid)
{
	DestroyPlayerObject(playerid, CameraInfo[playerid][camObject]);
	DestroyPlayerObject(playerid, CameraInfo[playerid][camLookObject]);
}


/* === Put this in OnPlayerObjectMoved === *
*
*	OnPlayerObjectMoved
*		Camera_ObjectMoved(playerid, objectid);
*/

#define Camera_ObjectMoved() CM_ObjectMoved(playerid, objectid);

stock CM_ObjectMoved(playerid, objectid)
{
	if(objectid == CameraInfo[playerid][camObject])
	{
		CameraInfo[playerid][camMoving] = false;
		CameraInfo[playerid][camMovePos] = false;
	}
	if(objectid == CameraInfo[playerid][camLookObject])
	{
		CameraInfo[playerid][camMoving] = false;
		CameraInfo[playerid][camMoveLook] = false;
	}
}

/* == Also don't forget CameraUpdate(playerid) in OnPlayerUpdate callback! === */
	
/* ==== Now for the functions itself ==== */

public SetCameraPosForPlayer(playerid, Float:x, Float:y, Float:z)
{
	if(!IsPlayerConnected(playerid)) return 0;
	SetPlayerCameraPos(playerid, x, y, z);	
	SetPlayerObjectPos(playerid, CameraInfo[playerid][camObject], x, y, z);
	
	CameraInfo[playerid][camPosX] = x;
	CameraInfo[playerid][camPosY] = y;
	CameraInfo[playerid][camPosZ] = z;
	
	if(CameraInfo[playerid][camPosLookX] == -0.0 &&
	CameraInfo[playerid][camPosLookY] == -0.0 &&
	CameraInfo[playerid][camPosLookZ] == -0.0)
	{
		SetPlayerCameraLookAt(playerid, x, y, z);
	}
	return 1;
}

public SetCameraLookAtForPlayer(playerid, Float:x, Float:y, Float:z)
{
	if(!IsPlayerConnected(playerid)) return 0;
	SetPlayerCameraLookAt(playerid, x, y, z);
	CameraInfo[playerid][camPosLookX] = x;
	CameraInfo[playerid][camPosLookY] = y;
	CameraInfo[playerid][camPosLookZ] = z;
	return 1;
}


public MoveCameraPosForPlayer(playerid, Float:x, Float:y, Float:z, Float:speed)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(IsCameraPosInvalid(playerid) || IsCameraLookAtInvalid(playerid))
	{
		return 0;
	}
	SetPlayerObjectPos(playerid, CameraInfo[playerid][camObject], CameraInfo[playerid][camPosX], CameraInfo[playerid][camPosY], CameraInfo[playerid][camPosZ]);
	CameraInfo[playerid][camMoving] = true;
	CameraInfo[playerid][camMoveSpeed] = speed;
	CameraInfo[playerid][camMovePos] = true;
	MovePlayerObject(playerid, CameraInfo[playerid][camObject], x, y, z, speed);
	return 1;
}

public MoveCameraLookAtForPlayer(playerid, Float:x, Float:y, Float:z, Float:speed)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(IsCameraPosInvalid(playerid) || IsCameraLookAtInvalid(playerid))
	{
		return 0;
	}
	if(CameraInfo[playerid][camMoveLook] == true) return 0;
	SetPlayerObjectPos(playerid, CameraInfo[playerid][camLookObject], CameraInfo[playerid][camPosLookX], CameraInfo[playerid][camPosLookY], CameraInfo[playerid][camPosLookZ]);
	CameraInfo[playerid][camMoving] = true;
	CameraInfo[playerid][camMoveSpeed] = speed;
	CameraInfo[playerid][camMoveLook] = true;
	MovePlayerObject(playerid, CameraInfo[playerid][camLookObject], x, y, z, speed);
	return 1;
}

public CameraUpdate(playerid)
{
	if(CameraInfo[playerid][camMoving] == true)
	{
		if(CameraInfo[playerid][camMovePos] == true)
		{
			new Float:x, Float:y, Float:z;
			GetPlayerObjectPos(playerid, CameraInfo[playerid][camObject], x, y, z);
			SetCameraLookAtForPlayer(playerid, CameraInfo[playerid][camPosLookX], CameraInfo[playerid][camPosLookY], CameraInfo[playerid][camPosLookZ]);
			SetCameraPosForPlayer(playerid, x, y, z);
			new Float:angle = GetAngle(x, y, CameraInfo[playerid][camPosLookX], CameraInfo[playerid][camPosLookY]);
			SetPlayerObjectRot(playerid, CameraInfo[playerid][camObject], 0.0, 0.0, angle);
		}
		if(CameraInfo[playerid][camMoveLook] == true)
		{
			new Float:x, Float:y, Float:z;
			GetPlayerObjectPos(playerid, CameraInfo[playerid][camLookObject], x, y, z);
			SetCameraLookAtForPlayer(playerid, x, y, z);
			SetCameraPosForPlayer(playerid,CameraInfo[playerid][camPosX], CameraInfo[playerid][camPosY], CameraInfo[playerid][camPosLookZ]);
			new Float:angle = GetAngle(CameraInfo[playerid][camPosLookX], CameraInfo[playerid][camPosLookY], x, y);
			SetPlayerObjectRot(playerid, CameraInfo[playerid][camLookObject], 0.0, 0.0, angle);
			
		}
	}
	if(CameraInfo[playerid][camShaking] == true)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerObjectPos(playerid, CameraInfo[playerid][camLookObject], x, y, z);
		SetCameraLookAtForPlayer(playerid, x, y, z);
		SetCameraPosForPlayer(playerid,CameraInfo[playerid][camPosX], CameraInfo[playerid][camPosY], CameraInfo[playerid][camPosLookZ]);
		new Float:angle = GetAngle(CameraInfo[playerid][camPosLookX], CameraInfo[playerid][camPosLookY], x, y);
		SetPlayerObjectRot(playerid, CameraInfo[playerid][camLookObject], 0.0, 0.0, angle);
	}
	SetTimerEx("CameraUpdate", 50, 0, "i", playerid);
	return 1;
}

public SetCameraFollowPlayerForPlayer(playerid, id, time)
{
	if(!IsPlayerConnected(playerid) || !IsPlayerConnected(id)) return 0;
	if(IsCameraPosInvalid(playerid) || IsCameraLookAtInvalid(playerid)) return 0;
	CameraInfo[playerid][camMoveLook] = true;
	CameraInfo[playerid][camFollow] = true;
	CameraInfo[playerid][camFollowMode] = FOLLOW_MODE_1;
	SetTimerEx("Follow", 50, 0, "ii", playerid, id);
	if(time > 0) SetTimerEx("KillFollow", time, 0, "i", playerid);
	return 1;
}

public SetCameraFollowVehicleForPlayer(playerid, vehicleid, time)
{
	if(!IsPlayerConnected(playerid) || vehicleid == INVALID_VEHICLE_ID) return 0;
	if(IsCameraPosInvalid(playerid) || IsCameraLookAtInvalid(playerid))
	{
		return 0;
	}
	CameraInfo[playerid][camMoveLook] = true;
	CameraInfo[playerid][camFollow] = true;
	CameraInfo[playerid][camFollowMode] = FOLLOW_MODE_2;
	SetTimerEx("Follow", 50, 0, "ii", playerid, vehicleid);
	if(time > 0) SetTimerEx("KillFollow", time, 0, "i", playerid);
	return 1;
}

public KillFollow(playerid)
{
	CameraInfo[playerid][camFollow] = false;
	CameraInfo[playerid][camFollowMode] = 0;
}


public Follow(playerid, id)
{
	if(CameraInfo[playerid][camFollow] != true) return 0;
	if(CameraInfo[playerid][camFollowMode] == FOLLOW_MODE_1) //playerid
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(id, x, y, z);
		SetCameraPosForPlayer(playerid, CameraInfo[playerid][camPosX], CameraInfo[playerid][camPosY], CameraInfo[playerid][camPosZ]);
		SetCameraLookAtForPlayer(playerid, x, y, z);
		SetTimerEx("Follow", 50, 0, "ii", playerid, id);
		return 1;
	}
	if(CameraInfo[playerid][camFollowMode] == FOLLOW_MODE_2) //vehicleid
	{
		new Float:x, Float:y, Float:z;
		GetVehiclePos(id, x, y, z);
		SetCameraPosForPlayer(playerid, CameraInfo[playerid][camPosX], CameraInfo[playerid][camPosY], CameraInfo[playerid][camPosZ]);
		SetCameraLookAtForPlayer(playerid, x, y, z);
		SetTimerEx("Follow", 50, 0, "ii", playerid, id);
		return 1;
	}
	return 1;
}

public ShakeCameraForPlayer(playerid, time, speed, intense)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(IsCameraPosInvalid(playerid) || IsCameraLookAtInvalid(playerid))
	{
		return 0;
	}
	if(CameraInfo[playerid][camShaking] == true) return 0;
	CameraInfo[playerid][camShaking] = true;
	SetPlayerObjectPos(playerid, CameraInfo[playerid][camLookObject], CameraInfo[playerid][camPosLookX], CameraInfo[playerid][camPosLookY], CameraInfo[playerid][camPosLookZ]);
	SetTimerEx("ShakeTimer", speed, 0, "iii", playerid, speed, intense);
	if(time > 0) SetTimerEx("KillShake", time, 0, "i", playerid);
	return 1;
}

public KillShake(playerid)
{
	CameraInfo[playerid][camShaking] = false;
	SetPlayerObjectPos(playerid, CameraInfo[playerid][camLookObject], CameraInfo[playerid][camPosLookX], CameraInfo[playerid][camPosLookY], CameraInfo[playerid][camPosLookZ]);
	SetCameraLookAtForPlayer(playerid, CameraInfo[playerid][camPosLookX], CameraInfo[playerid][camPosLookY], CameraInfo[playerid][camPosLookZ]);
	return 1;
}

public ShakeTimer(playerid, speed, intense)
{
	SetCameraLookAtForPlayer(playerid, CameraInfo[playerid][camPosLookX], CameraInfo[playerid][camPosLookY], CameraInfo[playerid][camPosLookZ]);
	if(CameraInfo[playerid][camShaking] == true)
	{
		new Float:x, Float:y, Float:z;
		x = CameraInfo[playerid][camPosLookX];
		y = CameraInfo[playerid][camPosLookY];
		z = CameraInfo[playerid][camPosLookZ];
		x = x + rand(-intense, intense);
		y = y + rand(-intense, intense);
		z = z + rand(-intense, intense);
		SetCameraLookAtForPlayer(playerid, x, y, z);
		SetTimerEx("ShakeTimer", speed, 0, "iii", playerid, speed, intense);
	}
}

/* ===== "-Get" Extension ==== */

public GetCameraPos(playerid, &Float:x, &Float:y, &Float:z)
{
	x = CameraInfo[playerid][camPosX];
	y = CameraInfo[playerid][camPosY];
	z = CameraInfo[playerid][camPosZ];
	return 1;
}

public GetCameraLookAt(playerid, &Float:x, &Float:y, &Float:z)
{
	x = CameraInfo[playerid][camPosLookX];
	y = CameraInfo[playerid][camPosLookY];
	z = CameraInfo[playerid][camPosLookZ];
	return 1;
}

public GetCameraSpeed(playerid, &Float:speed)
{
	speed = CameraInfo[playerid][camMoveSpeed];
	return 1;
}
/* ===== Reset ===== */

public ResetCameraForPlayer(playerid)
{
	CameraInfo[playerid][camPosX] = -0.0;
	CameraInfo[playerid][camPosY] = -0.0;
	CameraInfo[playerid][camPosZ] = -0.0;
	
	CameraInfo[playerid][camPosLookX] = -0.0;
	CameraInfo[playerid][camPosLookY] = -0.0;
	CameraInfo[playerid][camPosLookZ] = -0.0;
	CameraInfo[playerid][camMoving] = false;
	CameraInfo[playerid][camMovePos] = false;
	CameraInfo[playerid][camMoveLook] = false;
	SetCameraBehindPlayer(playerid);
	return 1;
}

/* ===== Is ===== */
public IsCameraPosInvalid(playerid)
{
	if(CameraInfo[playerid][camPosX] == -0.0 ||
	CameraInfo[playerid][camPosY] == -0.0 ||
	CameraInfo[playerid][camPosZ] == -0.0) return 1;
	return 0;
}

public IsCameraLookAtInvalid(playerid)
{
	if(CameraInfo[playerid][camPosLookX] == -0.0 ||
	CameraInfo[playerid][camPosLookY] == -0.0 ||
	CameraInfo[playerid][camPosLookZ] == -0.0) return 1;
	return 0;
}

public IsPlayerCameraMoving(playerid)
{
	if(CameraInfo[playerid][camMoving] == true) return 1;
	return 0;
}	

/* ===== ForAll Loops ===== */

public MoveCameraPosForAll(Float:x, Float:y, Float:z, speed)
{
	for(new i = 0; i < GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i))
		{
			MoveCameraPosForPlayer(i, x, y, z, speed);
		}
	}
}

public MoveCameraLookAtForAll(Float:x, Float:y, Float:z, speed)
{
	for(new i = 0; i < GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i))
		{
			MoveCameraLookAtForPlayer(i, x, y, z, speed);
		}
	}
}

public SetCameraPosForAll(Float:x, Float:y, Float:z)
{
	for(new i = 0; i < GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i))
		{
			SetCameraPosForPlayer(i, x, y, z);
		}
	}
}

public SetCameraLookAtForAll(Float:x, Float:y, Float:z)
{
	for(new i = 0; i < GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i))
		{
			SetCameraLookAtForPlayer(i, x, y, z);
		}
	}
}

public ResetCameraForAll()
{
	for(new i = 0; i < GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i))
		{
			ResetCameraForPlayer(i);
		}
	}
}

public ShakeCameraForAll(time, speed, speed_between_next_shake)
{
	for(new i = 0; i < GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i))
		{
			ShakeCameraForPlayer(i, time, speed_between_next_shake, speed);
		}
	}
}

public SetCameraFollowVehicleForAll(vehicleid, time)
{
	for(new i = 0; i < GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i))
		{
			SetCameraFollowVehicleForPlayer(i, vehicleid, time);
		}
	}
}

public SetCameraFollowPlayerForAll(id, time)
{
	for(new i = 0; i < GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i))
		{
			SetCameraFollowPlayerForPlayer(i, id, time);
		}
	}
}

// Other shit...

public Float:GetAngle(Float:x, Float:y, Float:ix, Float:iy)
{
	new Float:absoluteangle;
	new Float:tmpangle;
	new Float:misc = 5.0;
	tmpangle = 180.0-atan2(x-ix,y-iy);
	tmpangle += misc;
	misc *= -1;
	absoluteangle = tmpangle+misc;
	return absoluteangle;
}

rand(minnum = cellmin,maxnum = cellmax) return random(maxnum - minnum + 1) + minnum;