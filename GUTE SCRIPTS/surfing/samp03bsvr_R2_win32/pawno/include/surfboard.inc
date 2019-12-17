/*  surfboard.inc
 *
 *  (c) Copyright 2010, Emilio "Correlli" Lovrich
 *
 *  Credits: - Y_Less for foreach & GetXYInFrontOfPlayer functions & ZeeX for zcmd command processor.
*/

#if defined _surfboard_included
	#endinput
#endif
#define _surfboard_included

#if !defined _samp_included
	#error "You'll need to include the a_samp.inc include file before the surfboard.inc file!"
#endif

/* ----- */

#if !defined MAX_SURFBOARDS
	#define MAX_SURFBOARDS (5)
#endif

#if !defined MAX_SURFBOARD_SPEED
	#define MAX_SURFBOARD_SPEED (5.0)
#endif

#if !defined INVALID_SURFBOARD_ID
	#define INVALID_SURFBOARD_ID (-1)
#endif

/* ----- */

static
		bool:gOPF[3] = false;

/* ----- */

enum dataSurfboard
{
    modelID,
	objectID,
	Float:speed,
	Float:position[7]
}

new
        surfboardID = INVALID_SURFBOARD_ID, surfboardData[MAX_SURFBOARDS][dataSurfboard],
		Float:surfboardGoTo[MAX_SURFBOARDS][3], bool:firstSurfboard = false, sbTimer;

/* ----- */

stock CreateSurfboard(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz = 0.0)
{
	if(!firstSurfboard)
	{
	    firstSurfboard = true;
	    sbTimer = SetTimer("surfboard_Timer", 1000, true);
	}
    surfboardID++;
	if(surfboardID == MAX_SURFBOARDS)
	{
		printf("Limit of surfboards exceeded. Open the surfboard.inc and change the \"MAX_SURFBOARDS\" define to bigger value if you want to have more surfboards.\
				\nDon't forget that object limit in the current SA:MP version (0.3b) is 400, so it's a good thing to use an object-streamer if you're having many surfboards on server.");
        surfboardID--;
		return INVALID_SURFBOARD_ID;
	}
	new
			toSurfboardID = GetFreeSurfboardID();
	if(toSurfboardID == INVALID_SURFBOARD_ID)
	{
	    print("Error: There are no surfboard IDs free.");
	    surfboardID--;
		return INVALID_SURFBOARD_ID;
	}
	if(modelid < 1 || modelid > 3)
	{
		printf("Invalid model-ID at function \"CreateSurfboard\". Valid model-IDs are 1, 2 and 3.");
        surfboardID--;
		return INVALID_SURFBOARD_ID;
	}
	surfboardData[toSurfboardID][modelID] = modelid;
	surfboardData[toSurfboardID][position][0] = x;
	surfboardData[toSurfboardID][position][1] = y;
	surfboardData[toSurfboardID][position][2] = z;
	surfboardData[toSurfboardID][position][3] = rx;
	surfboardData[toSurfboardID][position][4] = ry;
	surfboardData[toSurfboardID][position][5] = rz;
	surfboardData[toSurfboardID][position][6] = rz;
	surfboardData[toSurfboardID][speed] = 0.0;
	surfboardData[toSurfboardID][objectID] = CreateObject(2403 + modelid, x, y, z, rx, ry, rz);
	return toSurfboardID;
}

stock DestroySurfboard(sbid)
{
	if(IsSurfboardCreated(sbid))
	{
	    surfboardID--;
		surfboardData[sbid][modelID] = 0;
		surfboardData[sbid][position][0] = 0.0;
		surfboardData[sbid][position][1] = 0.0;
		surfboardData[sbid][position][2] = 0.0;
		surfboardData[sbid][position][3] = 0.0;
		surfboardData[sbid][position][4] = 0.0;
		surfboardData[sbid][position][5] = 0.0;
		surfboardData[sbid][position][6] = 0.0;
		surfboardData[sbid][speed] = 0.0;
        DestroyObject(surfboardData[sbid][objectID]);
		if(surfboardID == INVALID_SURFBOARD_ID)
		{
		    firstSurfboard = false;
		    KillTimer(sbTimer);
		}
		foreach(Player, u)
		{
		    if((GetPVarInt(u, "surfboardID") - 1) == sbid)
		    {
				SetPVarInt(u, "surfboardID", 0);
				ClearAnimations(u);
				SendClientMessage(u, 0xFFFFFFFF, "Surfing stopped - surfboard was deleted by the script.");
		        break;
		    }
		}
		return true;
	}
	return false;
}

stock IsSurfboardCreated(sbid)
{
    if(surfboardData[sbid][modelID]) return true;
    return false;
}

stock GetNumberOfSurfboards() return surfboardID;

stock GetFreeSurfboardID()
{
	new
			sbid = INVALID_SURFBOARD_ID;
	for(new a = 0; a < MAX_SURFBOARDS; a++)
	{
	    if(!IsSurfboardCreated(a))
		{
			sbid = a;
			break;
		}
	}
	return sbid;
}

stock StopSurfboard(sbid)
{
    if(!IsSurfboardCreated(sbid)) return false;
	surfboardData[sbid][speed] = 0.0;
	StopObject(surfboardData[sbid][objectID]);
	return true;
}

stock RespawnSurfboard(sbid)
{
	if(!IsSurfboardCreated(sbid)) return false;
	DestroyObject(surfboardData[sbid][objectID]);
	surfboardData[sbid][position][5] = surfboardData[sbid][position][6];
	surfboardData[sbid][objectID] = CreateObject(2403 + surfboardData[sbid][modelID], surfboardData[sbid][position][0], surfboardData[sbid][position][1], surfboardData[sbid][position][2], surfboardData[sbid][position][3], surfboardData[sbid][position][4], surfboardData[sbid][position][5]);
	return true;
}

stock SetSurfboardSpeed(sbid, Float:surfspeed = MAX_SURFBOARD_SPEED)
{
	if(!IsSurfboardCreated(sbid)) return false;
	if(surfspeed > MAX_SURFBOARD_SPEED) surfboardData[sbid][speed] = MAX_SURFBOARD_SPEED;
	else surfboardData[sbid][speed] = surfspeed;
	return true;
}

stock IsPlayerAtSurfboard(playerid, sbid)
{
	new
	        Float:pos[3];
	GetObjectPos(surfboardData[sbid][objectID], pos[0], pos[1], pos[2]);
	if(IsPlayerInRangeOfPoint(playerid, 1.5, pos[0], pos[1], pos[2])) return true;
	return false;
}

stock IsPlayerAtAnySurfboard(playerid)
{
	new
			a = 0;
	for(a = 0; a < MAX_SURFBOARDS; a++)
	{
		if(IsPlayerAtSurfboard(playerid, a)) return a;
	}
	return INVALID_SURFBOARD_ID;
}

/* ----- */

stock GetXYInFrontOfPlayerOnSB(playerid, &Float:x, &Float:y, Float:distance)
{
	new
			Float:angle;
	GetPlayerPos(playerid, x, y, angle);
	GetPlayerFacingAngle(playerid, angle);
	x += (distance * floatsin(-angle + 270.0, degrees));
	y += (distance * floatcos(-angle + 270.0, degrees));
}

/* ----- */

forward surfboard_Timer();
public surfboard_Timer()
{
	foreach(Player, u)
	{
		new
				sbid = GetPVarInt(u, "surfboardID") - 1;
		if(sbid != INVALID_SURFBOARD_ID)
		{
			if(!IsPlayerAtSurfboard(u, sbid))
			{
			    StopSurfboard(sbid);
                RespawnSurfboard(sbid);
				SetPVarInt(u, "surfboardID", 0);
				ClearAnimations(u);
				SendClientMessage(u, 0xFFFFFFFF, "Surfing stopped - surfboard is re-spawned.");
			}
		}
	}
	return true;
}

/* ----- */

command(surf, playerid, params[])
{
	new
            Float:objPos[3];
	if(!GetPVarInt(playerid, "surfboardID"))
	{
	    new
	            sbid = IsPlayerAtAnySurfboard(playerid);
		if(sbid != INVALID_SURFBOARD_ID)
		{
			SetPVarInt(playerid, "surfboardID", sbid + 1);
			GetObjectPos(surfboardData[sbid][objectID], objPos[0], objPos[1], objPos[2]);
			SetPlayerPos(playerid, objPos[0], objPos[1], objPos[2] + 1.0);
			SetPlayerFacingAngle(playerid, surfboardData[sbid][position][5] + 270.0);
			ApplyAnimation(playerid, "BSKTBALL", "BBALL_def_loop", 4.0, 1, 0, 0, 0, 0);
	        SendClientMessage(playerid, 0xFFFFFFFF, "Surfing started. Use \"/surf\" command to stop with the surfing.");
		}
		else SendClientMessage(playerid, 0xFFFFFFFF, "You're not near any surfboard or you're not close enough to it.");
	}
	else
	{
	    StopSurfboard(GetPVarInt(playerid, "surfboardID") - 1);
        SetPVarInt(playerid, "surfboardID", 0);
        ClearAnimations(playerid);
        SendClientMessage(playerid, 0xFFFFFFFF, "Surfing stopped. Use \"/surf\" command to start with the surfing again.");
	}
	return true;
}

/* ----- */

public OnPlayerConnect(playerid)
{
	ApplyAnimation(playerid, "BSKTBALL", "null", 0.0, 0, 0, 0, 0, 0);

	if(gOPF[0]) CallLocalFunction("surfboard_OnPlayerConnect", "i", playerid);
	return true;
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect surfboard_OnPlayerConnect

forward surfboard_OnPlayerConnect(playerid);



public OnPlayerDisconnect(playerid, reason)
{
	new
			sbid = GetPVarInt(playerid, "surfboardID") - 1;
	if(sbid != INVALID_SURFBOARD_ID)
	{
		StopSurfboard(sbid);
        RespawnSurfboard(sbid);
	}

	if(gOPF[1]) CallLocalFunction("surfboard_OnPlayerDisconnect", "ii", playerid, reason);
	return true;
}

#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect surfboard_OnPlayerDisconnect

forward surfboard_OnPlayerDisconnect(playerid, reason);



public OnPlayerUpdate(playerid)
{
	new
	        sbid = GetPVarInt(playerid, "surfboardID") - 1;
	if(sbid != INVALID_SURFBOARD_ID)
	{
	    new
				keys[3], Float:floatVal[4];
		GetPlayerPos(playerid, floatVal[0], floatVal[1], floatVal[2]);
		floatVal[3] = surfboardData[sbid][speed];
	    GetPlayerKeys(playerid, keys[0], keys[1], keys[2]);
		GetXYInFrontOfPlayerOnSB(playerid, floatVal[0], floatVal[1], 50.0);
		surfboardGoTo[sbid][0] = floatVal[0];
		surfboardGoTo[sbid][1] = floatVal[1];
		surfboardGoTo[sbid][2] = surfboardData[sbid][position][2];
		if(keys[1] == KEY_UP)
		{
			if(floatVal[3] >= 0.0 && floatVal[3] < MAX_SURFBOARD_SPEED) surfboardData[sbid][speed] += 0.05;
			if(floatVal[3] >= MAX_SURFBOARD_SPEED) surfboardData[sbid][speed] = MAX_SURFBOARD_SPEED;
		}
		else if(keys[1] == KEY_DOWN)
		{
			if(floatVal[3] >= 0.0 && floatVal[3] < MAX_SURFBOARD_SPEED) surfboardData[sbid][speed] -= 0.05;
			if(floatVal[3] >= MAX_SURFBOARD_SPEED) surfboardData[sbid][speed] = MAX_SURFBOARD_SPEED;
		}
		if(keys[2] == KEY_LEFT)
		{
		    surfboardData[sbid][speed] -= 0.01;
			surfboardData[sbid][position][5] += 1.5;
			SetObjectRot(surfboardData[sbid][objectID], surfboardData[sbid][position][3], surfboardData[sbid][position][4], surfboardData[sbid][position][5]);
			SetPlayerFacingAngle(playerid, surfboardData[sbid][position][5] + 270.0);
			surfboardGoTo[sbid][0] = floatVal[0];
			surfboardGoTo[sbid][1] = floatVal[1];
			surfboardGoTo[sbid][2] = surfboardData[sbid][position][2];
		}
		else if(keys[2] == KEY_RIGHT)
		{
		    surfboardData[sbid][speed] -= 0.01;
			surfboardData[sbid][position][5] -= 1.5;
			SetObjectRot(surfboardData[sbid][objectID], surfboardData[sbid][position][3], surfboardData[sbid][position][4], surfboardData[sbid][position][5]);
			SetPlayerFacingAngle(playerid, surfboardData[sbid][position][5] + 270.0);
			surfboardGoTo[sbid][0] = floatVal[0];
			surfboardGoTo[sbid][1] = floatVal[1];
			surfboardGoTo[sbid][2] = surfboardData[sbid][position][2];
		}
	    if(surfboardData[sbid][speed] > 0.005)
		{
			surfboardData[sbid][speed] -= 0.005;
			MoveObject(surfboardData[sbid][objectID], surfboardGoTo[sbid][0], surfboardGoTo[sbid][1], surfboardGoTo[sbid][2], surfboardData[sbid][speed]);
		}
	    else StopSurfboard(sbid);
		new
				string[72];
		format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~Speed: ~w~%0.1f ~r~/ ~w~%0.1f", surfboardData[sbid][speed], MAX_SURFBOARD_SPEED);
		GameTextForPlayer(playerid, string, 1000, 3);
	}

	if(gOPF[2]) CallLocalFunction("surfboard_OnPlayerUpdate", "i", playerid);
	return true;
}

#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate surfboard_OnPlayerUpdate

forward surfboard_OnPlayerUpdate(playerid);



public OnGameModeInit()
{
	gOPF[0] = (funcidx("surfboard_OnPlayerConnect") != -1);
	gOPF[1] = (funcidx("surfboard_OnPlayerDisconnect") != -1);
	gOPF[2] = (funcidx("surfboard_OnPlayerUpdate") != -1);
	CallLocalFunction("surfboard_OnGameModeInit", "");
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit surfboard_OnGameModeInit

forward surfboard_OnGameModeInit();
