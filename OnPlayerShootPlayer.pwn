/********************************************
 * OnPlayerShootPlayer! V5.0	            *
 * Credits: wups,			    *
 * Double-O-Seven for his HS functions      *
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
#if defined FILTERSCRIPT
	#error "OnPlayerShootPlayer ERROR: You must include it in your game mode, not in your filterscript!"
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

public OnPlayerUpdate(playerid)
{
	static  Float:RL_HP,
			Float:RL_Armour;
	GetPlayerHealth(playerid,RL_HP);
	GetPlayerArmour(playerid,RL_Armour);
	if(RL_HP < RL_phealth[playerid] || RL_Armour < RL_parmour[playerid])
	{
		if(RL_UpdatedHealth[playerid])
			RL_UpdatedHealth[playerid]=false;
		else
		{
			static
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
						GetPlayerCameraFrontVector(i, RL_CameraVectors[0], RL_CameraVectors[1], RL_CameraVectors[2]);
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
	RL_phealth[playerid]=RL_HP;
	RL_parmour[playerid]=RL_Armour;
	return (RL_OPUP)?CallLocalFunction("RL_OnPlayerUpdate","i",playerid):1;
}
// Functions
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
// SetPlayerHealth
stock SetPlayerHealthEx(playerid, Float:health)
{
	RL_phealth[playerid]=health;
	RL_UpdatedHealth[playerid]=true;
	return SetPlayerHealth(playerid, health);
}

#define SetPlayerHealth SetPlayerHealthEx

// SetPlayerArmour
stock SetPlayerArmourEx(playerid, Float:armour)
{
	RL_parmour[playerid]=armour;
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
			static
					Float:RL_PlayerPos[3],
					Float:RL_Distance,
					Float:RL_CameraPos[3],
					Float:RL_CameraVectors[3],
					RL_Tick,
					Float:RL_HP,
					Float:RL_Armour
					;
			RL_Tick = (GetTickCount()-1000);
			GetPlayerPos(playerid, RL_PlayerPos[0], RL_PlayerPos[1], RL_PlayerPos[2]);
			foreach(Player,i)
			{
				if(RL_Shooting[i] || RL_Tick < RL_Released[i])
				{
					if(i != playerid)
					{
						GetPlayerCameraFrontVector(i, RL_CameraVectors[0], RL_CameraVectors[1], RL_CameraVectors[2]);
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
// The end.