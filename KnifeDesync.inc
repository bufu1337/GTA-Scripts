#include <a_samp>

#define MAX_DISTANCE_UNIT   200.0
#define BODY_PART_HEAD  1
#define BODY_PART_TORSO 2
#define BODY_PART_LEGS  3

new knifetimer;

public OnPlayerUpdate(playerid)
{
	if(GetPlayerAnimationIndex(playerid))
    {
        new animlib[32];
        new animname[32];
        GetAnimationName(GetPlayerAnimationIndex(playerid),animlib,32,animname,32);
		if(!strcmp(animlib, "KNIFE", true) && !strcmp(animname, "KILL_Knife_Player", true)) {
		    //ok so they're doing the knifing animation, but i just want to make this as accurate as possible, so, lets do a couple more checks.
		    new keys, ud, lr;
		    GetPlayerKeys(playerid, keys, ud, lr);
			if((keys & KEY_FIRE) && (keys & KEY_HANDBRAKE) && GetPlayerWeapon(playerid) == 4) {
			    //player is pressing fire and is holding a knife
			    printf("%s, %s", animlib, animname);
			    for(new i=0; i <= MAX_PLAYERS; ++i) {
			        if(IsPlayerConnected(i) && i != playerid) {
			        	if(IsPlayerAiming(playerid, i)) {
          	 				printf(" Kinfer: %s, %s", animlib, animname);
			            	if(GetPVarInt(playerid, "Knifing") == 1 && GetPVarInt(i, "BeingKnifed") == 1) return 1;
			            	//ok, so they are doing the knife player animation, holding a knife and pressing aim and fire. i think its safe to say they are knifing.
			            	if(GetPVarInt(playerid, "Knifing") != 1 && GetPVarInt(i, "BeingKnifed") != 1) knifetimer = SetTimerEx("CanKnifeAgain", 4500, 0, "dd", playerid, i);
							SetPVarInt(playerid, "Knifing", 1);
							SetPVarInt(i, "BeingKnifed", 1);
						}
					}
				}
			}
		}
    }
    return 1;
}

forward CanKnifeAgain(playerid, targetid);
public CanKnifeAgain(playerid, targetid) {
	if(GetPVarInt(targetid, "KnifeKilled") == 0) {
	    OnPlayerDesyncPlayer(playerid, targetid);
	}
	SetPVarInt(targetid, "KnifeKilled", 0);
	SetPVarInt(playerid, "KnifeKilled", 0);
	SetPVarInt(playerid, "Knifing", 0);
	SetPVarInt(targetid, "BeingKnifed", 0);
	SetPVarInt(playerid, "BeingKnifed", 0);
	SetPVarInt(targetid, "Knifing", 0);
	return 1;
}

stock OnPlayerDesyncPlayer(playerid, targetid) {
	KillTimer(knifetimer);
	SyncPlayer(targetid);
	SetPVarInt(targetid, "KnifeKilled", 0);
	SetPVarInt(playerid, "KnifeKilled", 0);
	SetPVarInt(targetid, "Desync", 0);
	SetPVarInt(playerid, "Knifing", 0);
	SetPVarInt(targetid, "BeingKnifed", 0);
	SetPVarInt(playerid, "BeingKnifed", 0);
	SetPVarInt(targetid, "Knifing", 0);
	SetPVarInt(playerid, "Desync", 0);
}

stock OnPlayerKnifePlayer(playerid, targetid) {
	KillTimer(knifetimer);
	SetPVarInt(targetid, "KnifeKilled", 0);
	SetPVarInt(playerid, "KnifeKilled", 0);
	SetPVarInt(targetid, "Desync", 0);
	SetPVarInt(playerid, "Knifing", 0);
	SetPVarInt(targetid, "BeingKnifed", 0);
	SetPVarInt(playerid, "BeingKnifed", 0);
	SetPVarInt(targetid, "Knifing", 0);
	SetPVarInt(playerid, "Desync", 0);
}


/*forward Check(playerid, i);
public Check(playerid, i) {
	new animlib[32], animname[32];
    GetAnimationName(GetPlayerAnimationIndex(i), animlib, sizeof(animlib), animname, sizeof(animname));
    printf("Knifed: %s %s", animlib, animname);
	if(!strcmp(animlib, "KNIFE", true) || !strcmp(animlib, "PED", true) && !strcmp(animname, "FALL_LAND", true)) {
	    OnPlayerKnifePlayer(playerid, i);
		//player has been legitimetly knifed, and it has synced.
		SetPVarInt(playerid, "Knifing", 1);
		SetPVarInt(i, "BeingKnifed", 1);
		SetTimerEx("CanKnifeAgain", 3000, 0, "dd", playerid, i);
	 } else {
		OnPlayerDesyncPlayer(playerid, i);
		SetPVarInt(playerid, "Knifing", 1);
		SetPVarInt(playerid, "Desynced", 1);
		SetPVarInt(i, "BeingKnifed", 1);
		SetTimerEx("CanKnifeAgain", 3000, 0, "dd", playerid, i);
	}
	return 1;
}*/

//unused - used for detecting and resyncing BEFORE 5 or so seconds after the knife - at the end of the day, i couldn't get this to work as good as i wanted. maybe 1 day




public OnPlayerDeath(playerid,killerid,reason)
{
    if(reason == 4) OnPlayerKnifePlayer(killerid, playerid);
 	return 1;
}

Float:DistanceCameraTargetToLocation(Float:CamX, Float:CamY, Float:CamZ, Float:ObjX, Float:ObjY, Float:ObjZ, Float:FrX, Float:FrY, Float:FrZ) {

	new Float:TGTDistance;

	TGTDistance = floatsqroot((CamX - ObjX) * (CamX - ObjX) + (CamY - ObjY) * (CamY - ObjY) + (CamZ - ObjZ) * (CamZ - ObjZ));

	new Float:tmpX, Float:tmpY, Float:tmpZ;

	tmpX = FrX * TGTDistance + CamX;
	tmpY = FrY * TGTDistance + CamY;
	tmpZ = FrZ * TGTDistance + CamZ;

	return floatsqroot((tmpX - ObjX) * (tmpX - ObjX) + (tmpY - ObjY) * (tmpY - ObjY) + (tmpZ - ObjZ) * (tmpZ - ObjZ));
}

stock Float:GetPointAngleToPoint(Float:x2, Float:y2, Float:X, Float:Y) {

  	new Float:DX, Float:DY;
  	new Float:angle;

  	DX = floatabs(floatsub(x2,X));
  	DY = floatabs(floatsub(y2,Y));

  	if (DY == 0.0 || DX == 0.0) {
    	if(DY == 0 && DX > 0) angle = 0.0;
    	else if(DY == 0 && DX < 0) angle = 180.0;
    	else if(DY > 0 && DX == 0) angle = 90.0;
    	else if(DY < 0 && DX == 0) angle = 270.0;
    	else if(DY == 0 && DX == 0) angle = 0.0;
  	}
  	else {
    	angle = atan(DX/DY);

    	if(X > x2 && Y <= y2) angle += 90.0;
    	else if(X <= x2 && Y < y2) angle = floatsub(90.0, angle);
    	else if(X < x2 && Y >= y2) angle -= 90.0;
    	else if(X >= x2 && Y > y2) angle = floatsub(270.0, angle);
	}
  	return floatadd(angle, 90.0);
}

stock GetXYInFrontOfPoint(&Float:x, &Float:y, Float:angle, Float:distance) {
	x += (distance * floatsin(-angle, degrees));
	y += (distance * floatcos(-angle, degrees));
}

stock IsPlayerAimingAt(playerid, Float:x, Float:y, Float:z, Float:radius) {
  	new Float:camera_x,Float:camera_y,Float:camera_z,Float:vector_x,Float:vector_y,Float:vector_z;
  	GetPlayerCameraPos(playerid, camera_x, camera_y, camera_z);
  	GetPlayerCameraFrontVector(playerid, vector_x, vector_y, vector_z);

	new Float:vertical, Float:horizontal;

	switch (GetPlayerWeapon(playerid)) {
	  	case 34,35,36: {
	  	if (DistanceCameraTargetToLocation(camera_x, camera_y, camera_z, x, y, z, vector_x, vector_y, vector_z) < radius) return true;
	  	return false;
	}
	case 30,31: {vertical = 4.0; horizontal = -1.6;}
	case 33: {vertical = 2.7; horizontal = -1.0;}
	default: {vertical = 6.0; horizontal = -2.2;}
	}
  	new Float:angle = GetPointAngleToPoint(0, 0, floatsqroot(vector_x*vector_x+vector_y*vector_y), vector_z) - 270.0;
  	new Float:resize_x, Float:resize_y, Float:resize_z = floatsin(angle+vertical, degrees);
  	GetXYInFrontOfPoint(resize_x, resize_y, GetPointAngleToPoint(0, 0, vector_x, vector_y)+horizontal, floatcos(angle+vertical, degrees));

  	if (DistanceCameraTargetToLocation(camera_x, camera_y, camera_z, x, y, z, resize_x, resize_y, resize_z) < radius) return true;
  	return false;
}

stock IsPlayerAiming(playerid, aimid) {
	//aimid = player aiming at
	//playerid = player aiming
	new Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2, Float:x3, Float:y3, Float:z3, Float:x4, Float:y4, Float:z4;
 	GetPlayerPos(aimid, x, y, z);
 	GetPlayerCameraFrontVector(playerid, x2, y2, z2);
 	GetPlayerCameraPos(playerid, x3, y3, z3);
 	GetPlayerPos(aimid, x4, y4, z4);
 	new Float:distance = 9999.0;
 	GetDistanceFromPointToLine(distance, x2, y2, z2, x3, y3, z3, x4, y4, z4);
 	if(distance < 5.0) { return true; }
 	if (IsPlayerAimingAt(playerid, x, y, z-0.75, 0.25)) return true;
 	if (IsPlayerAimingAt(playerid, x, y, z-0.25, 0.25)) return true;
 	if (IsPlayerAimingAt(playerid, x, y, z+0.25, 0.25)) return true;
 	if (IsPlayerAimingAt(playerid, x, y, z+0.75, 0.25)) return true;
 	if (IsPlayerAimingAt(playerid, x, y, z+0.75, 0.25)) return true;
 	if (IsPlayerAimingAt(playerid, x, y, z+0.75, 0.25)) return true;
 	if (IsPlayerAimingAt(playerid, x, y, z+0.75, 0.25)) return true;
 	if(IsPlayerAimingBodyPart(playerid, 1) == 1) return true;
 	if(IsPlayerAimingBodyPart(playerid, 2) == 1) return true;
 	if(IsPlayerAimingBodyPart(playerid, 3) == 1) return true;
 	//using a lot of functions to check aiming for the BEST accurate detection.
 	return false;
}

stock IsPlayerAimingBodyPart(playerid, bodypart)
{
	// Get the camera's positions
	new Float:x, Float:y, Float:z;
	new Float:vx, Float:vy, Float:vz;
	new Float:cx, Float:cy, Float:cz;
	GetPlayerCameraFrontVector(playerid, vx, vy, vz);
	GetPlayerCameraPos(playerid, cx, cy, cz);

	// Check if the player is aiming in a certain distance
	for(new Float:d; d < MAX_DISTANCE_UNIT; d += 0.5)
	{
	    x = vx*d+cx;
	    y = vy*d+cy;
	    z = vz*d+cz;
	    new Float:distoff;

	    new Float:dist = floatsqroot((x-cx)*(x-cx)+(y-cy)*(y-cy));
		new Float:offset;
		new Float:radius;
		switch (GetPlayerWeapon(playerid))
		{
		    case 24, 29, 22, 23, 25, 26, 27, 28, 32: offset = 0.1122047500310059125919013005129;
		    case 30, 31: offset = 0.07867820613690007867820613690008;
		    case 33, 34: offset = 0.0;
		}
		new Float:height;
		if (z > cz) height = z-cz;
		else height = cz-z;
		offset *= dist;
		height /= dist;
		distoff = dist*0.03;
		if (x > 0.0) x += distoff;
	    else x -= distoff;
	    if (y > 0.0) y += distoff;
	    else y -= distoff;
		new Float:part;
		if (bodypart == BODY_PART_HEAD)
		{
			part = -0.4;
			radius = 0.25;
		}
		else if (bodypart == BODY_PART_TORSO)
		{
			part = 0.4;
			radius = 0.7;
		}
		else if (bodypart == BODY_PART_LEGS)
		{
			part = 1.0;
			radius = 0.5;
		}
		z = z+offset-height+part;
		if (dist <= 5.0)
		{
		    switch (bodypart)
		    {
		        case BODY_PART_HEAD: z += 0.35;
		        case BODY_PART_TORSO: z += 0.8;
		        case BODY_PART_LEGS: z += 1.2;
		    }
		}
		else if (dist <= 2.0)
		{
		    switch (bodypart)
		    {
		        case BODY_PART_HEAD: z += 0.35;
		        case BODY_PART_TORSO: z += 1.2;
		        case BODY_PART_LEGS: z += 1.7;
		    }
		}
	    for(new i, m = GetMaxPlayers(); i < m; i++)
	    {
			if (!IsPlayerConnected(i)) continue;
			if (playerid == i) continue;
			if (GetPlayerSpecialAction(i) == SPECIAL_ACTION_DUCK)
			{
				if (IsPlayerInRangeOfPoint(i, radius, x, y, (z+1.2)-0.5))
				{
					return i;
				}
			}
			else if (IsPlayerInRangeOfPoint(i, radius, x, y, z-0.5))
			{
				return i;
			}
		}
	}
	return 0;
}


forward SyncPlayer(playerid);
public SyncPlayer(playerid)
{
	new PlayerWeapons[2][13];
	for(new i = 0; i < 13; i++)
	{
	    if(i == 0 || i == 1) {
	   		GetPlayerWeaponData(playerid,i,PlayerWeapons[0][i],PlayerWeapons[1][i]);
	   		if(PlayerWeapons[1][i] > 1) { PlayerWeapons[1][i] = 1; }
	    }	else {
	   		GetPlayerWeaponData(playerid,i,PlayerWeapons[0][i],PlayerWeapons[1][i]);
		}
	}

	ClearAnimations(playerid);

	new Float:PlayerPos[3];
	GetPlayerPos(playerid,PlayerPos[0],PlayerPos[1],PlayerPos[2]);
	new Float:health = 0;
	new Float:armour = 0;
	GetPlayerHealth(playerid,health);
	GetPlayerArmour(playerid,armour);
	new TheInterior, VirtualWorld;
	new Float:Angle;
	GetPlayerFacingAngle(playerid, Angle);
	TheInterior = GetPlayerInterior(playerid);
	VirtualWorld = GetPlayerVirtualWorld(playerid);

	SetPlayerWorldBounds(playerid,9999.9,-9999.9,9999.9,-9999.9);

	SpawnPlayer(playerid);

	SetPlayerArmour(playerid,armour);
	SetPlayerHealth(playerid,health);
	SetPlayerInterior(playerid,TheInterior);
	SetPlayerVirtualWorld(playerid,VirtualWorld);
	SetPlayerPos(playerid,PlayerPos[0],PlayerPos[1],PlayerPos[2]);

	for(new i = 0; i < 13; i++)
	{
	    if(PlayerWeapons[0][i] > 0){
		    GivePlayerWeapon(playerid,PlayerWeapons[0][i],PlayerWeapons[1][i]);
		}
	}
	return 1;
}

stock crossp(Float:v1x, Float:v1y, Float:v1z, Float:v2x, Float:v2y, Float:v2z, &Float:output)
{
	new
		Float:c1 = (v1y * v2z) - (v1z * v2y),
        Float:c2 = (v1z * v2x) - (v1x * v2z),
        Float:c3 = (v1x * v2y) - (v1y * v2x);
    output = floatsqroot ((c1 * c1) + (c2 * c2) + (c3 * c3));
    return 0;
}

stock GetDistanceFromPointToLine(&Float:distance, Float:line_vector_x, Float:line_vector_y, Float:line_vector_z, Float:line_x, Float:line_y, Float:line_z, Float:point_x, Float:point_y, Float:point_z)
{
    //A line is defined by a point (which is on the line (line_x/y/z)) and a vector which defines the direction (line_vector_x/y/z).
    static Float:output;
    crossp(line_vector_x, line_vector_y, line_vector_z, point_x - line_x, point_y - line_y, point_z - line_z, output);//Cross product of 2 vectors.
    distance = output / floatsqroot ((line_vector_x * line_vector_x) + (line_vector_y * line_vector_y) + (line_vector_z * line_vector_z));
    return 0;
}