// NPC Pool stuff
// The NPC pool will provide a set of connected and ready NPCs that can 
// be used for various different roles that require a short reaction time.
// By having the NPCs already connected, there is no delay for connecting
// and spawning them. So whenever you need a NPC with a certain role, you
// pick the ID of an idle one from the pool, and teleport him to where he is
// needed

// Version 1.0, Mauzen, 2.7.2014

// Avoid including the pool twice
#if defined _rnpcpool_included
	#endinput
#endif
#define _rnpcpool_included

#tryinclude <rnpc>

// Initialize NPC pool if it doesnt exist yet
// Define size only if it isnt defined yet, so people may define it in their own script
#if !defined RNPC_POOL_MAXSIZE
	#define RNPC_POOL_MAXSIZE				50			// Maximum amount of NPCs available for the pool
#endif
#if !defined RNPC_POOL_STARTSIZE
	#define RNPC_POOL_STARTSIZE				10			// Default pool size when starting
#endif

#define RNPC_POOL_ROLE_IDLE					-1
#define RNPC_POOL_ROLE_RESET_PENDING		-2
#define RNPC_POOL_ROLE_UNUSED				-3



// Forward the callback
forward OnRNPCPoolFull(curSize, maxSize);


// Prepare pool data
enum RNPC_POOL_ENUM {
	RNPC_POOL_ID,		// ID of the NPC in the pool
	RNPC_POOL_ROLE		// The current role of the NPC
						// When creating your own roles, you must care for the ID to be unique
};
new rnpcPool[RNPC_POOL_MAXSIZE][RNPC_POOL_ENUM];

new curPoolSize = 0;			// Current size of the NPC pool

// This function returns the PLAYERID of an idle NPC from the pool,
// or INVALID_PLAYER_ID if theres no idle NPC
stock PickRNPCFromPool(fortask) {
	// Negative task IDs are used internally, not allowed for manual use
	if (fortask < 0) return INVALID_PLAYER_ID;
	
	for (new i = 0; i < RNPC_POOL_MAXSIZE; i++) {
		// Check if the NPC is idle, and marked as completely connected
		if (rnpcPool[i][RNPC_POOL_ROLE] == RNPC_POOL_ROLE_IDLE &&(rnpcPend{i} & RNPC_CONNECTED)) {
			// Idle NPC found, set his new role
			rnpcPool[i][RNPC_POOL_ROLE] = fortask;
			// And return his playerid
			return rnpcPool[i][RNPC_POOL_ID];			
		}
	}
	// Call a callback that might try to resolve the problem
	CallRemoteFunction("OnRNPCPoolFull", "ii", curPoolSize, RNPC_POOL_MAXSIZE);
	// No idle NPC found
	return INVALID_PLAYER_ID;
}

// Sets a NPC back to idle state
// This stops all playbacks, and puts the NPC far away so
// he doesnt stream in for others to reduce unneccessary traffic
// see OnRNPCPlaybackStopped for part 2
stock ReturnRNPCToPool(npcid) {
	// Get the pool ID
	new slot = RNPCPoolIDFromPlayerID(npcid);
	// Abort if the npcid isnt in the pool
	if (slot == -1) return 0;
	
	// Set the role to a "pending for reset" state,
	// so the NPC doesnt get a new role until he is fully reset
	rnpcPool[slot][RNPC_POOL_ROLE] = RNPC_POOL_ROLE_RESET_PENDING;
	
	// Stop playback
	// This doesnt stop him instantly, wait for OnRNPCPlaybackStopped
	RNPC_StopPlayback(npcid);	
	return 1;
}

// Sets the current size of the pool
// Either kicking NPCs or connecting new ones
// If noactivekick is true, it will kick only inactive NPCs, and so eventually not
// reducing the pool to the desired new size
// Else it will start kicking inactives, and then kicks the NPCs with the highest pool ID
// Returns the new pool size
stock SetRNPCPoolSize(newsize, noactivekick=1) {
	
	// Limited by the maximum pool size
	if (newsize > RNPC_POOL_MAXSIZE) newsize = RNPC_POOL_MAXSIZE;
	// And by 0
	if (newsize < 0) newsize = 0;
	
	// Increasing the pool size, connect new NPCs
	if (newsize > curPoolSize) {
		new name[MAX_PLAYER_NAME];		
		
		// Find unused NPC slots and connect them
		for (new i = 0; i < RNPC_POOL_MAXSIZE; i++) {
			if (rnpcPool[i][RNPC_POOL_ROLE] == RNPC_POOL_ROLE_UNUSED) {
				// Connect a new NPC and prepare it to be added to the pool
				format(name, sizeof(name), "Pool_RNPC_%d", i);
				rnpcPool[i][RNPC_POOL_ID] = ConnectRNPC(name);
				rnpcPool[i][RNPC_POOL_ROLE] = RNPC_POOL_ROLE_IDLE;
				// Increase pool size by 1
				curPoolSize++;
			}
			// Stop when there are enough NPCs
			if (curPoolSize == newsize) break;
		}
		return curPoolSize;
	}
	
	// Reduce the pool size
	if (newsize < curPoolSize) {		
		
		// First loop removing idle NPCs only, starting at the last index
		for (new i = RNPC_POOL_MAXSIZE-1; i >= 0; i--) {
			if (rnpcPool[i][RNPC_POOL_ROLE] == RNPC_POOL_ROLE_IDLE) {				
				Kick(i);
				rnpcPool[i][RNPC_POOL_ROLE] = RNPC_POOL_ROLE_UNUSED;
				rnpcPool[i][RNPC_POOL_ID] = INVALID_PLAYER_ID;
				curPoolSize--;
			}
			// Enough NPCs removed, return
			if (curPoolSize == newsize) return curPoolSize;
		}
		
		// Not enough idle NPCs removed, only do that if kicking actives is enabled
		if (!noactivekick) {
			for (new i = RNPC_POOL_MAXSIZE-1; i >= 0; i--) {
				Kick(i);
				rnpcPool[i][RNPC_POOL_ROLE] = RNPC_POOL_ROLE_UNUSED;
				rnpcPool[i][RNPC_POOL_ID] = INVALID_PLAYER_ID;
				curPoolSize--;
				// Enough NPCs removed, return
				if (curPoolSize == newsize) return curPoolSize;
			}
		}
	}
	
	return curPoolSize;
}


// Returns the index in the pool array from the playerid,
// or -1 if it isnt in the pool
stock RNPCPoolIDFromPlayerID(npcid) {
	for (new i = 0; i < RNPC_POOL_MAXSIZE; i++) {
		// playerid matches
		if (rnpcPool[i][RNPC_POOL_ID] == npcid) return i;
	}
	// No match found
	return -1;
}


// Returns the current role of a NPC from the pool
// or -1 if it isnt a NPC, or its not part of the pool or got no task
stock GetPoolRNPCRole(npcid) {
	new slot = RNPCPoolIDFromPlayerID(npcid);
	if (slot == -1) return -1;
	return rnpcPool[slot][RNPC_POOL_ROLE];
}


// Hook OnGameModeInit to connect the pool NPCs on start
// and prepare data
public OnGameModeInit() {

	// Set all pool slots to unused for initialisation
	for (new i = 0; i < RNPC_POOL_MAXSIZE; i++) {
		rnpcPool[i][RNPC_POOL_ID] = INVALID_PLAYER_ID;
		rnpcPool[i][RNPC_POOL_ROLE] = RNPC_POOL_ROLE_UNUSED;
	}
	
	// Set the pool to the default starting size
	SetRNPCPoolSize(RNPC_POOL_STARTSIZE);

	#if defined RNPCPOOL_OnGameModeInit
		return RNPCPOOL_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit RNPCPOOL_OnGameModeInit
forward RNPCPOOL_OnGameModeInit();

// Hook OnRNPCPlaybackStopped to set NPCs idle correctly
public OnRNPCPlaybackStopped(npcid) {
	new slot = RNPCPoolIDFromPlayerID(npcid);
	
	// Only do this for RNPCs in the pool with a pending reset
	if (slot > -1) {
		if (rnpcPool[slot][RNPC_POOL_ROLE] == RNPC_POOL_ROLE_RESET_PENDING) {
			// Reset NPC to idle role
			rnpcPool[slot][RNPC_POOL_ROLE] = RNPC_POOL_ROLE_IDLE;
			// Teleport him out of the usual range to avoid unneeded stream-ins
			SetPlayerPos(npcid, 0.0, 0.0, -300.0);
			// Reset the NPC name
			new name[MAX_PLAYER_NAME];
			format(name, sizeof(name), "Pool_RNPC_%d", slot);
			SetPlayerName(npcid, name);
		}
	}

	#if defined RNPCPOOL_OnRNPCPlaybackStopped 
		RNPCPOOL_OnRNPCPlaybackStopped(npcid);
	#else
		return;
	#endif
}
#if defined _ALS_OnRNPCPlaybackStopped 
	#undef OnRNPCPlaybackStopped 
#else
	#define _ALS_OnRNPCPlaybackStopped 
#endif
#define OnRNPCPlaybackStopped RNPCPOOL_OnRNPCPlaybackStopped 
forward RNPCPOOL_OnRNPCPlaybackStopped(npcid);