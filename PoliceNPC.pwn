/**
 * RNPC Police include
 * Simple AI and tutorial script
 * Mauzen, 10.7.2012, V1.0
 */
#include <RNPC>

#define RPOL_MAX_WAYPOINTS 			(12)	// Maximum number of waypoints for a policeman
#define RPOL_VISIONRANGE			(25.0)	// Attacking players in that range will be chased
#define RPOL_ATTACKRANGE			(15.0)	// Policeman starts firing when in this range to the player
#define MAX_RNPC_POLICE				(8)		// Max number of police officers
#define RPOL_UPDATE					(200)	// Interval in ms to update movements, attacks, etc

// The enum containing all data for a single policeman
enum RPol_enum {
			RPOL_NPCID,
			RPOL_TIMER,
	Float:	RPOL_WAYPOINTS_X[RPOL_MAX_WAYPOINTS],
	Float:	RPOL_WAYPOINTS_Y[RPOL_MAX_WAYPOINTS],
	Float:	RPOL_WAYPOINTS_Z[RPOL_MAX_WAYPOINTS],
			RPOL_WPINDEX,
			RPOL_NEXTWP,
			RPOL_CURTARGET,
			RPOL_SKIN
};

// Initial data
new rpol[MAX_RNPC_POLICE][RPol_enum] = {{-1, -1, 0.0, 0.0, 0.0, 0, 0, -1}, {-1, -1, 0.0, 0.0, 0.0, 0, 0, -1},
	{-1, -1, 0.0, 0.0, 0.0, 0, 0, -1}, {-1, -1, 0.0, 0.0, 0.0, 0, 0, -1}, {-1, -1, 0.0, 0.0, 0.0, 0, 0, -1},
	{-1, -1, 0.0, 0.0, 0.0, 0, 0, -1}, {-1, -1, 0.0, 0.0, 0.0, 0, 0, -1}, {-1, -1, 0.0, 0.0, 0.0, 0, 0, -1} };

// Creates a new policeman
stock CreateRNPCPolice(name[], skin)
{
	// Find a free spot in the rpol array
	new slot = -1;
	for (new i = 0; i < MAX_RNPC_POLICE; i++) {
		if (rpol[i][RPOL_NPCID] == -1) {
			slot = i;
			break;
		}
	}
	if (slot == -1) return -1;

	// Connect the NPC
	rpol[slot][RPOL_NPCID] = ConnectRNPC(name);
	rpol[slot][RPOL_SKIN] = skin;
	return slot;
}

// Adds a waypoint to the Policeman's path
stock AddRPOLWaypoint(rpolid, Float:x, Float:y, Float:z) {
	if (rpol[rpolid][RPOL_NPCID] == -1) return false;
	if (rpol[rpolid][RPOL_WPINDEX] >= RPOL_MAX_WAYPOINTS) return false;
	// Store the waypoint coordinates at the last free position
	new slot = rpol[rpolid][RPOL_WPINDEX];
	rpol[rpolid][RPOL_WAYPOINTS_X][slot] = x;
	rpol[rpolid][RPOL_WAYPOINTS_Y][slot] = y;
	rpol[rpolid][RPOL_WAYPOINTS_Z][slot] = z;

	rpol[rpolid][RPOL_WPINDEX]++;
	return true;
}

stock StartRPOLRoute(rpolid)
{
	// If valid and not already walking
	if (rpol[rpolid][RPOL_TIMER] == -1 && rpol[rpolid][RPOL_NPCID] != -1) {
		rpol[rpolid][RPOL_TIMER] = SetTimerEx("WatchTimer", RPOL_UPDATE, 1, "i", rpolid);
		// Move to the first waypoint
		MoveRNPC(rpol[rpolid][RPOL_NPCID], rpol[rpolid][RPOL_WAYPOINTS_X][0], rpol[rpolid][RPOL_WAYPOINTS_Y][0],
				rpol[rpolid][RPOL_WAYPOINTS_Z][0], RNPC_SPEED_RUN);
		return true;
	}
	return 0;
}

stock RemoveRNPCPolice(rpolid)
{
	if (rpol[rpolid][RPOL_TIMER] > -1) {
		// Stop timer
		KillTimer(rpol[slot][RPOL_TIMER]);
	}
	// Kick the NPC
	Kick(rpol[rpolid][RPOL_NPCID];
	// Reset data
	rpol[rpolid] = {-1, -1, 0.0, 0.0, 0.0, 0, 0, -1};
}

// This is the timer that actually controls the policeman
// and so the actually interesting "KI" for the RNPC
forward WatchTimer(id);
public WatchTimer(id) {
	if (rpol[id][RPOL_CURTARGET] > -1) {
		new Float:x, Float:y, Float:z;
		GetPlayerPos(rpol[id][RPOL_CURTARGET], x, y ,z);
		if (!IsPlayerInRangeOfPoint(rpol[id][RPOL_NPCID], RPOL_VISIONRANGE * 2.0, x, y, z)
			|| GetPlayerState(rpol[id][RPOL_CURTARGET]) != PLAYER_STATE_ONFOOT) {
			// Target escaped or died
			// Stop shooting
			RNPC_SetKeys(0);
			// Continue route
			MoveRNPC(rpol[id][RPOL_NPCID], rpol[id][RPOL_WAYPOINTS_X][rpol[id][RPOL_NEXTWP]],
				rpol[id][RPOL_WAYPOINTS_Y][rpol[id][RPOL_NEXTWP]], rpol[id][RPOL_WAYPOINTS_Z][rpol[id][RPOL_NEXTWP]],
				RNPC_SPEED_RUN);
			rpol[id][RPOL_CURTARGET] = -1;
			return;
		} else
		if (IsPlayerInRangeOfPoint(rpol[id][RPOL_NPCID], RPOL_ATTACKRANGE, x, y, z)) {
			// Target is in attackrange
			// Stop running and start shhoting
			new Float:ox, Float:oy, Float:oz;
			GetPlayerPos(rpol[id][RPOL_NPCID], ox, oy, oz);
			// Angle to the target
			new Float:angle = atan2(ox - x, oy - y) + 180.0;
			// Stop and build, alternate slot for security
			RNPC_StopPlayback(rpol[id][RPOL_NPCID]);
			RNPC_CreateBuild(rpol[id][RPOL_NPCID], PLAYER_RECORDING_TYPE_ONFOOT, 1);
			// Set weapon
			RNPC_SetWeaponID(22);
			// Set facing angle to the target
			RNPC_SetAngleQuats(0.0, angle, 0.0);
			// Start firing
			RNPC_SetKeys(KEY_FIRE);
			// Move towards the target from the current position
			RNPC_ConcatMovement(x, y, z, RNPC_SPEED_RUN);
			// Finish build
			RNPC_FinishBuild();

			// Start playback
			RNPC_StartBuildPlayback(id, 1);

		} else {
			// Stop shooting
			RNPC_SetKeys(0);
			// Move towards the targets
			MoveRNPC(rpol[id][RPOL_NPCID], x, y, z, RNPC_SPEED_RUN);
		}
	}
}

// Hook OnNPCPlaybackFinished to determine when a NPC reached his current waypoint
public OnRNPCPlaybackFinished(npcid)
{
	// Find the array index of the npc
	new slot = -1;
	for (new i = 0; i < MAX_RNPC_POLICE; i++) {
		if (rpol[i][RPOL_NPCID] == npcid) {
			slot = i;
			break;
		}
	}
	if (slot > -1) {
		// NPC is a RNPC policeman
		if (rpol[slot][RPOL_CURTARGET] == -1) {
			// Increase current waypoint index, and set it to 0 when the last one is reached
			rpol[slot][RPOL_NEXTWP] = (rpol[slot][RPOL_NEXTWP] + 1) % rpol[slot][RPOL_WPINDEX];
			// Make him walk to the next waypoint
			MoveRNPC(rpol[slot][RPOL_NPCID], rpol[slot][RPOL_WAYPOINTS_X][rpol[slot][RPOL_NEXTWP]],
				rpol[slot][RPOL_WAYPOINTS_Y][rpol[slot][RPOL_NEXTWP]], rpol[slot][RPOL_WAYPOINTS_Z][rpol[slot][RPOL_NEXTWP]],
				RNPC_SPEED_WALK);
		}
	}
	CallLocalFunction("RNPC_OnRNPCPlaybackFinished", "i", npcid);
}
#if defined _ALS_OnRNPCPlaybackFinished
    #undef OnRNPCPlaybackFinished
#else
    #define _ALS_OnRNPCPlaybackFinished
#endif
#define OnRNPCPlaybackFinished RNPC_OnRNPCPlaybackFinished
forward RNPC_OnRNPCPlaybackFinished(npcid);

// Hook OnPlayerKeyStateChange to detect firing players
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	// Check if player started firing
	if (!(oldkeys & KEY_FIRE) && (newkeys & KEY_FIRE)) {
		// Check if player holds a gun
		if (GetPlayerWeapon(playerid) > 16 && GetPlayerWeapon(playerid) < 40) {
			new Float:px, Float:py, Float:pz;
			for (new i = 0; i < MAX_RNPC_POLICE; i++) {
				// Skip invalid and already following npcs
				if (rpol[i][RPOL_NPCID] == -1 || rpol[i][RPOL_CURTARGET] > -1) continue;
				GetPlayerPos(rpol[i][RPOL_NPCID], px, py, pz);
				// If police in in range make him chase the attacking player
				if (IsPlayerInRangeOfPoint(playerid, RPOL_VISIONRANGE, px, py, pz)) {
					rpol[i][RPOL_CURTARGET] = playerid;
				}
			}
		}
	}
	CallLocalFunction("RNPC_OnPlayerKeyStateChange", "iii", playerid, newkeys, oldkeys);
}
#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange RNPC_OnPlayerKeyStateChange
forward RNPC_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);

// Hook OnPlayerSpawn to set the NPCs skin
public OnPlayerSpawn(playerid)
{
	if (IsPlayerNPC(playerid)) {
		// Find the array index of the npc
		new slot = -1;
		for (new i = 0; i < MAX_RNPC_POLICE; i++) {
			if (rpol[i][RPOL_NPCID] == playerid) {
				slot = i;
				break;
			}
		}
		// If playerid is a policeman
		if (slot > -1) {
			SetPlayerSkin(playerid, rpol[slot][RPOL_SKIN]);
		}
	}
	CallLocalFunction("RNPC_OnPlayerSpawn", "i", playerid);
}
#if defined _ALS_OnPlayerSpawn
    #undef OnPlayerSpawn
#else
    #define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn RNPC_OnPlayerSpawn
forward RNPC_OnPlayerSpawn(playerid);