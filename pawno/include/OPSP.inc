/********************************************
 * OnPlayerShootPlayer! V8.3	            *
 * Credits: wups			  				*
 * Double-O-Seven for CrossProduct system   *
 * Nero3D for GetPlayerCameraWeaponVector   *
 ********************************************/

// include
#include <a_samp>
#tryinclude <foreach>

// defines
#if defined OPSP
	#endinput
#endif
#define OPSP

#if !defined foreach
	#define foreach(%1,%2) for (new %2 = 0; %2 < MAX_PLAYERS; %2++) if (IsPlayerConnected(%2))
	#define __SSCANF_FOREACH__
#endif
#if !defined PRESSED
	#define PRESSED(%0) \
		(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#endif
#if !defined RELEASED
	#define RELEASED(%0) \
		(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#endif
// variables
static 		
		Float:RL_phealth[MAX_PLAYERS],
		Float:RL_parmour[MAX_PLAYERS],
		bool:RL_Shooting[MAX_PLAYERS],
		bool:RL_UpdatedHealth[MAX_PLAYERS],
		bool:RL_OPUP,
		bool:RL_OPSC,
		bool:RL_OPKSC,
		bool:RL_OPC,
		RL_Released[MAX_PLAYERS];
// forwards
forward OnPlayerShootPlayer(Shooter,Target,Float:HealthLost,Float:ArmourLost);


/*--------------------------------------------------------------------------------------------------
	Function:
		AdjustVector
	Params:
		& Float: vX - x Vector to adjust
		& Float: vY - y Vector to adjust
		& Float: vZ - z Vector to adjust
		Float: oX - x Offset Vector
		Float: oY - y Offset Vector
		const Float: oZ - z Offset Vector
	Return:
		-
	Notes:
		Adjust the vector with the offset
--------------------------------------------------------------------------------------------------*/

stock AdjustVector(& Float: vX, & Float: vY, & Float: vZ, Float: oX, Float: oY, const Float: oZ) { // Credits Nero_3D
	static
		Float: Angle;
	Angle = -atan2(vX, vY);
	if(45.0 < Angle) {
		oX ^= oY;
		oY ^= oX;
		oX ^= oY;
		if(90.0 < Angle) {
			oX *= -1;
			if(135.0 < Angle) {
				oX *= -1;
				oX ^= oY;
				oY ^= oX;
				oX ^= oY;
				oX *= -1;
			}
		}
	} else if(Angle < 0.0) {
		oY *= -1;
		if(Angle < -45.0) {
			oX *= -1;
			oX ^= oY;
			oY ^= oX;
			oX ^= oY;
			oX *= -1;
			if(Angle < -90.0) {
				oX *= -1;
				if(Angle < -135.0) {
					oX ^= oY;
					oY ^= oX;
					oX ^= oY;
				}
			}
		}
	}
	vX += oX,
	vY += oY;
	vZ += oZ;
	return false;
}
/*--------------------------------------------------------------------------------------------------
	Function:
		GetPlayerCameraWeaponVector
	Params:
		playerid - Player to get the weapon vector of
		& Float: vX - x Vector variable
		& Float: vY - y Vector variable
		& Float: vZ - z Vector variable
	Return:
		If the player is connected
	Notes:
		Gets the weapon vector of the player

native GetPlayerCameraWeaponVector(playerid, & Float: vX, & Float: vY, & Float: vZ);
--------------------------------------------------------------------------------------------------*/
stock GetPlayerCameraWeaponVector(playerid, & Float: vX, & Float: vY, & Float: vZ) { // Credits Nero_3D
	static
		weapon;
	if(21 < (weapon = GetPlayerWeapon(playerid)) < 39) {
		GetPlayerCameraFrontVector(playerid, vX, vY, vZ);
		switch(weapon) {
			case WEAPON_SNIPER, WEAPON_ROCKETLAUNCHER, WEAPON_HEATSEEKER: {}
			case WEAPON_RIFLE: {
				AdjustVector(vX, vY, vZ, 0.016204, 0.009899, 0.047177);
			}
			case WEAPON_AK47, WEAPON_M4: {
				AdjustVector(vX, vY, vZ, 0.026461, 0.013070, 0.069079);
			}
			default: {
				AdjustVector(vX, vY, vZ, 0.043949, 0.015922, 0.103412);
			}
		}
		return true;
	}
	else
		GetPlayerCameraFrontVector(playerid, vX, vY, vZ);
	return false;
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


public OnPlayerUpdate(playerid)
{
	static  Float:RL_HP,
			Float:RL_Armour;
	GetPlayerHealth(playerid,RL_HP);
	GetPlayerArmour(playerid,RL_Armour);
	if(RL_HP != RL_phealth[playerid] || RL_Armour != RL_parmour[playerid])
	{
		if(RL_UpdatedHealth[playerid])
			RL_UpdatedHealth[playerid]=false;
		else
		{
			new 
					Float:RL_PlayerPos[3],
					Float:RL_Distance,
					Float:RL_CameraPos[3],
					Float:RL_CameraVectors[3],
					RL_Tick
					;
			RL_Tick = (GetTickCount()-1000);
			GetPlayerPos(playerid, RL_PlayerPos[0], RL_PlayerPos[1], RL_PlayerPos[2]);
			foreach(Player,i)
			{
				if(RL_Shooting[i] || RL_Tick < RL_Released[i])
				{
					if(i != playerid)
					{
						if(IsPlayerInRangeOfPoint(i,200.0,RL_PlayerPos[0], RL_PlayerPos[1], RL_PlayerPos[2]))
						{
							GetPlayerCameraWeaponVector(i, RL_CameraVectors[0], RL_CameraVectors[1], RL_CameraVectors[2]);
							
							GetPlayerCameraPos(i, RL_CameraPos[0], RL_CameraPos[1], RL_CameraPos[2]);
							GetDistanceFromPointToLine(RL_Distance, RL_CameraVectors[0], RL_CameraVectors[1], RL_CameraVectors[2], RL_CameraPos[0], RL_CameraPos[1], RL_CameraPos[2], RL_PlayerPos[0], RL_PlayerPos[1], RL_PlayerPos[2]);
							if(RL_Distance < 2.5)
							{
									CallLocalFunction("OnPlayerShootPlayer","iiff",i,playerid,(RL_phealth[playerid]-RL_HP),(RL_parmour[playerid]-RL_Armour));
									break;
							}
						}
					}
				}
			}
		}
	}
	RL_phealth[playerid]=RL_HP;
	RL_parmour[playerid]=RL_Armour;
	return (RL_OPUP)?CallLocalFunction("RL_OnPlayerUpdate","i",playerid):1;
}
// Functions

// SetPlayerHealth
stock SetPlayerHealthEx(playerid, Float:health)
{
//	RL_phealth[playerid]=health;
	RL_UpdatedHealth[playerid]=true;
	return SetPlayerHealth(playerid, health);
}

#define SetPlayerHealth SetPlayerHealthEx

// SetPlayerArmour
stock SetPlayerArmourEx(playerid, Float:armour)
{
//	RL_parmour[playerid]=armour;
	RL_UpdatedHealth[playerid]=true;
	return SetPlayerArmour(playerid, armour);
}

#define SetPlayerArmour SetPlayerArmourEx

#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif

#define OnPlayerUpdate RL_OnPlayerUpdate
forward RL_OnPlayerUpdate(playerid);

// OnPlayerKeyStateChange
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_FIRE)) RL_Shooting[playerid]=true;
	else if(RELEASED(KEY_FIRE))
	{
		RL_Shooting[playerid]=false;
		RL_Released[playerid]=GetTickCount();
	}
	return (RL_OPKSC)?CallLocalFunction("RL_OnPlayerKeyStateChange","iii",playerid,newkeys,oldkeys):1;
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange RL_OnPlayerKeyStateChange
forward RL_OnPlayerKeyStateChange(playerid,newkeys,oldkeys);

// OnPlayerStateChange
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_WASTED)
	{
		if(RL_UpdatedHealth[playerid])
			RL_UpdatedHealth[playerid]=false;
		else
		{
			new
					Float:RL_PlayerPos[3],
					Float:RL_Distance,
					Float:RL_CameraPos[3],
					Float:RL_CameraVectors[3],
					RL_Tick,
					Float:RL_HP,
					Float:RL_Armour
					;
			GetPlayerHealth(playerid,RL_HP);
			GetPlayerArmour(playerid,RL_Armour);
			RL_Tick = (GetTickCount()-1000);
			GetPlayerPos(playerid, RL_PlayerPos[0], RL_PlayerPos[1], RL_PlayerPos[2]);
			foreach(Player,i)
			{
				if(RL_Shooting[i] || RL_Tick < RL_Released[i])
				{
					if(i != playerid)
					{
						GetPlayerCameraWeaponVector(i, RL_CameraVectors[0], RL_CameraVectors[1], RL_CameraVectors[2]);
						GetPlayerCameraPos(i, RL_CameraPos[0], RL_CameraPos[1], RL_CameraPos[2]);
						if(IsPlayerInRangeOfPoint(i,200.0,RL_PlayerPos[0], RL_PlayerPos[1], RL_PlayerPos[2]))
						{
							GetDistanceFromPointToLine(RL_Distance, RL_CameraVectors[0], RL_CameraVectors[1], RL_CameraVectors[2], RL_CameraPos[0], RL_CameraPos[1], RL_CameraPos[2], RL_PlayerPos[0], RL_PlayerPos[1], RL_PlayerPos[2]);
							if(RL_Distance < 2.5)
							{
									CallLocalFunction("OnPlayerShootPlayer","iiff",i,playerid,(RL_phealth[playerid]-RL_HP),(RL_parmour[playerid]-RL_Armour));
									break;
							}
						}
					}
				}
			}
		}
		
	}
	RL_Shooting[playerid]=false;
	RL_Released[playerid]=GetTickCount();
	return (RL_OPSC)?CallLocalFunction("RL_OnPlayerStateChange","iii",playerid,newstate,oldstate):1;
}
#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange RL_OnPlayerStateChange

forward RL_OnPlayerStateChange(playerid,newstate, oldstate);


// OnPlayerConnect
public OnPlayerConnect(playerid)
{
	RL_Shooting[playerid]=false;
	RL_Released[playerid]=0;
	return (RL_OPC)?CallLocalFunction("RL_OnPlayerConnect","i",playerid):1;
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect RL_OnPlayerConnect

forward RL_OnPlayerConnect(playerid);
#if !defined FILTERSCRIPT
	// OnGameModeInit
	public OnGameModeInit()
	{
		RL_OPUP = (funcidx("RL_OnPlayerUpdate") != -1);
		RL_OPSC = (funcidx("RL_OnPlayerStateChange") != -1);
		RL_OPKSC = (funcidx("RL_OnPlayerKeyStateChange") != -1);
		RL_OPC = (funcidx("RL_OnPlayerConnect") != -1);
		return (funcidx("RL_OnGameModeInit") != -1)?CallLocalFunction("RL_OnGameModeInit",""):1;
	}
	#if defined _ALS_OnGameModeInit
		#undef OnGameModeInit
	#else
		#define _ALS_OnGameModeInit
	#endif
	#define OnGameModeInit RL_OnGameModeInit
	forward RL_OnGameModeInit();
#else
	// OnFilterScriptInit
	public OnFilterScriptInit()
	{
		RL_OPUP = (funcidx("RL_OnPlayerUpdate") != -1);
		RL_OPSC = (funcidx("RL_OnPlayerStateChange") != -1);
		RL_OPKSC = (funcidx("RL_OnPlayerKeyStateChange") != -1);
		RL_OPC = (funcidx("RL_OnPlayerConnect") != -1);
		return (funcidx("RL_OnFilterScriptInit") != -1)?CallLocalFunction("RL_OnFilterScriptInit",""):1;
	}
	#if defined _ALS_OnFilterScriptInit
		#undef OnFilterScriptInit
	#else
		#define _ALS_OnFilterScriptInit
	#endif
	#define OnFilterScriptInit RL_OnFilterScriptInit. 
	forward RL_OnFilterScriptInit();
#endif


// The end.