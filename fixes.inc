/*
 * ===============
 *  INTRODUCTION:
 * ===============
 *
 * fixes.inc - Community patch for buggy SA:MP functions.
 *
 * ================
 *  LIST OF FIXES:
 * ================
 *
 * FIX:      GetPlayerColor
 * PROBLEM:  Returns "0" if "SetPlayerColor" has never been called.
 * SOLUTION: Call "SetPlayerColor" in "OnPlayerConnect".
 * SEE:      "OnPlayerConnect".
 *
 * FIX:      FILTERSCRIPT
 * PROBLEM:  Despite the fact that is in every new script, many people don't
 *           define "FILTERSCRIPT" where appropriate.
 * SOLUTION: Provide an "IS_FILTERSCRIPT" variable (note the naming to match
 *           the original macro).
 * SEE:      "OnFilterScriptInit" and "OnGameModeInit".
 *
 * FIX:      SpawnPlayer
 * PROBLEM:  Kills the player if they are in a vehicle.
 * SOLUTION: Remove the from the vehicle.
 * SEE:      "FIXES_SpawnPlayer".
 *
 * FIX:      SetPlayerName
 * PROBLEM:  Using "SetPlayerName" when the new name only differs from the old
 *           name in case does not alter the name at all.
 * SOLUTION: Change their name twice - once to "_FIXES TEMP NAME" and then to
 *           the actual required name.
 * SEE:      "OnPlayerConnect" and "FIXES_SetPlayerName".
 *
 * FIX:      GetPlayerSkin
 * PROBLEM:  Returns the new skin after "SetSpawnInfo" is called but before the
 *           player actually respawns to get the new skin.
 * SOLUTION: Record the skin in "OnPlayerSpawn" and always return that one.
 * SEE:      "OnPlayerSpawn", "FIXES_GetPlayerSkin" and "FIXES_SetPlayerSkin".
 *
 * FIX:      GetWeaponName
 * PROBLEM:  Returns nothing for 18, 44, and 45.
 * SOLUTION: Return the correct names ("Molotov Cocktail", "Thermal Goggles",
 *           and "Night vision Goggles").
 * SEE:      "FIXES_GetWeaponName".
 *
 * FIX:      SetPlayerWorldBounds
 * PROBLEM:  Aiming can bypass the edge.
 * SOLUTION: Check for the player leaving the area and reset them to their last
 *           good position if they leave the area (aiming or not).
 * SEE:      "OnPlayerUpdate" and "FIXES_SetPlayerWorldBounds".
 *
 * FIX:      TogglePlayerControllable
 * PROBLEM:  Other players see you moving on the spot.
 * SOLUTION: Return 0 in OnPlayerUpdate.
 * SEE:      "FIXES_TogglePlayerControllable" and "OnPlayerUpdate".
 * POST:     http://forum.sa-mp.com/showpost.php?p=876854&postcount=1
 *
 * FIX:      HydraSniper
 * PROBLEM:  Entring military aircraft with a sniper rifle messes up vies.
 * SOLUTION: Set their armed weapon to fists.
 * SEE:      "OnPlayerStateChange".
 * POST:     http://forum.sa-mp.com/showpost.php?p=965644&postcount=48
 *
 * FIX:      IsPlayerInCheckpoint
 * PROBLEM:  Function returns an undefined value if it is called before any
 *           other checkpoint functions are called to initialise the value.
 * SOLUTION: Call "DisablePlayerCheckpoint" when they connect.
 * SEE:      "OnPlayerConnect".
 *
 * FIX:      IsPlayerInRaceCheckpoint
 * PROBLEM:  Function returns an undefined value if it is called before any
 *           other race checkpoint functions are called to initialise the value.
 * SOLUTION: Call "DisablePlayerRaceCheckpoint" when they connect.
 * SEE:      "OnPlayerConnect".
 *
 * FIX:      GetPlayerWeapon
 * PROBLEM:  Returns the old value after using "SetPlayerArmedWeapon" when they
 *           are in a vehicle.
 * SOLUTION: If "SetPlayerArmedWeapon" is called in a vehicle, store the new
 *           value and return that instead.
 * SEE:      "OnPlayerStateChange", "FIXES_SetPlayerArmedWeapon", and
 *           "FIXES_GetPlayerWeapon".
 *
 * FIX:      PutPlayerInVehicle
 * PROBLEM:  If this is used on a passenger the driver of their old vehicle
 *           doesn't see them in their new vehicle.
 * SOLUTION: Remove them from the vehicle first.
 * SEE:      "OnPlayerStateChange" and "FIXES_PutPlayerInVehicle".
 * POST:     http://forum.sa-mp.com/showpost.php?p=1265965&postcount=148
 *
 * FIX:      KEY_AIM
 * PROBLEM:  "KEY_AIM" isn't defined by default.
 * SOLUTION: Define it.
 * SEE:      N/A.
 *
 * FIX:      SetPlayerCheckpoint
 * PROBLEM:  If a checkpoint is already set it will use the size of that
 *           checkpoint instead of the new one.
 * SOLUTION: Call "DisablePlayerCheckpoint" before setting the checkpoint.
 * SEE:      "FIXES_SetPlayerCheckpoint".
 * POST:     http://forum.sa-mp.com/showpost.php?p=1482401&postcount=23
 *
 * FIX:      SetPlayerRaceCheckpoint
 * PROBLEM:  If a checkpoint is already set it will use the size of that
 *           checkpoint instead of the new one.
 * SOLUTION: Call "DisablePlayerRaceCheckpoint" before setting the checkpoint.
 * SEE:      "FIXES_SetPlayerRaceCheckpoint".
 * POST:     http://forum.sa-mp.com/showpost.php?p=1482401&postcount=23
 *
 * FIX:      <Short name>
 * PROBLEM:  <Description of problem>
 * SOLUTION: <Description of solution>
 * SEE:      <List of relevant functions>
 *
 * ==============
 *  STYLE RULES:
 * ==============
 *
 * All globals should be "static stock" whenever possible (so they can only be
 *     accessed from this one script).
 *
 * Statics must start with "FIXES_gs", and all other globals with "FIXES_g".
 *
 * All functions not overriding existing functions must start with "FIXES_".
 *
 * Macros must be upper case, use underscores, and start "FIXES_":
 *     "FIXES_LIKE_THIS".
 *
 * Functions should be upper camel case (as the original functions are)
 *     "FIXES_LikeThis".
 *
 * Globals (after the prefix) should be upper camel case, and locals lower camel
 *     case "likeThis".
 *
 * ALS should be used to hook functions and callbacks.
 *
 * The ALS prefix for chaining is also "FIXES_"
 *
 * Enums start with "E_" or "e_" depending on type, then follow rules for
 *     macros.
 *
 * Use "FIXES_gsCallbackHooks" and "E_FIXES_CALLBACK_HOOKS" for ALS chaining.
 *
 * NO libraries should be included - not even the default SA:MP ones.  Let the
 *     user do it.
 *
 * Due to the above rule, you cannot assume any third party libraries AT ALL, so
 *     do not use them.
 *
 * "Update" may be shortened to "Up" and "Checkpoint" may be shortened to "CP"
 *     when dealing with long callback names to avoid compiler truncation
 *     warnings (max symbol length is 31).
 *
 * Document all fixes at the top of the file, and highlight code.
 *
 * 4 space TABS - do not edit this file in PAWNO unless you know how to correct
 *     the indentation.
 *
 * All rules have exceptions, but they must be justifiable.  For example
 *     "IS_FILTERSCRIPT" is a global variable, but is not called
 *     "FIXES_gIsFilterscript" to better match the "FILTERSCRIPT" macro it
 *     replaces.
 *
 * Variables which need to be fully global (i.e. not "static"), but should not
 *     actually be used by other people (e.g. appear inside a macro) should be
 *     prefixed with "_FIXES" instead of "FIXES" to indicate their private use.
 *
 * No comments beyond the end of column 80 (where the line in "PAWNO" is).
 */

// We can add server version compiler code here to only compile fixes that apply
// to the version of the includes for which the user is compiling.
#if !defined FIX_GetPlayerColor
	#define FIX_GetPlayerColor           (1)
#endif

#if !defined FIX_FILTERSCRIPT
	#define FIX_FILTERSCRIPT             (1)
#endif

#if !defined FIX_SpawnPlayer
	#define FIX_SpawnPlayer              (1)
#endif

#if !defined FIX_SetPlayerName
	#define FIX_SetPlayerName            (1)
#endif

#if !defined FIX_GetPlayerSkin
	#define FIX_GetPlayerSkin            (1)
#endif

#if !defined FIX_GetWeaponName
	#define FIX_GetWeaponName            (1)
#endif

#if !defined FIX_SetPlayerWorldBounds
	#define FIX_SetPlayerWorldBounds     (1)
#endif

#if !defined FIX_TogglePlayerControllable
	#define FIX_TogglePlayerControllable (1)
#endif

#if !defined FIX_HydraSniper
	#define FIX_HydraSniper              (1)
#endif

#if !defined FIX_IsPlayerInCheckpoint
	#define FIX_IsPlayerInCheckpoint     (1)
#endif

#if !defined FIX_IsPlayerInRaceCheckpoint
	#define FIX_IsPlayerInRaceCheckpoint (1)
#endif

#if !defined FIX_GetPlayerWeapon
	#define FIX_GetPlayerWeapon          (1)
#endif

#if !defined FIX_PutPlayerInVehicle
	#define FIX_PutPlayerInVehicle       (1)
#endif

#if !defined FIX_KEY_AIM
	#define FIX_KEY_AIM                  (!defined KEY_AIM)
#endif

#if !defined FIX_SetPlayerCheckpoint
	#define FIX_SetPlayerCheckpoint      (1)
#endif

#if !defined FIX_SetPlayerRaceCheckpoint
	#define FIX_SetPlayerRaceCheckpoint  (1)
#endif

/*
 * E_FIXES_CALLBACK_HOOKS_1
 * E_FIXES_CALLBACK_HOOKS_2
 *
 * Two enums to define the bits used to efficiently store wether of not the next
 * callback in the ALS chain exists.  Breaks naming convention for elements from
 * "E_FIXES_ON_GAME_MODE_INIT" to "E_FIXES_OnGameModeInit" for compatibility
 * with existing names.  Note that "Checkpoint" and "Update" have been shortened
 * to "CP" and "Up" in certain symbols to stay below the 31 character limit.
 */
enum E_FIXES_CALLBACK_HOOKS_1 (<<= 1)
{
	E_FIXES_OnGameModeInit = 1,
	E_FIXES_OnGameModeExit,
	E_FIXES_OnFilterScriptInit,
	E_FIXES_OnFilterScriptExit,
	E_FIXES_OnPlayerConnect,
	E_FIXES_OnPlayerDisconnect,
	E_FIXES_OnPlayerSpawn,
	E_FIXES_OnPlayerDeath,
	E_FIXES_OnVehicleSpawn,
	E_FIXES_OnVehicleDeath,
	E_FIXES_OnPlayerText,
	E_FIXES_OnPlayerCommandText,
	E_FIXES_OnPlayerRequestClass,
	E_FIXES_OnPlayerEnterVehicle,
	E_FIXES_OnPlayerExitVehicle,
	E_FIXES_OnPlayerStateChange,
	E_FIXES_OnPlayerEnterCheckpoint,
	E_FIXES_OnPlayerLeaveCheckpoint,
	E_FIXES_OnPlayerEnterRaceCP,
	E_FIXES_OnPlayerLeaveRaceCP,
	E_FIXES_OnRconCommand,
	E_FIXES_OnPlayerRequestSpawn,
	E_FIXES_OnObjectMoved,
	E_FIXES_OnPlayerObjectMoved,
	E_FIXES_OnPlayerPickUpPickup,
	E_FIXES_OnVehicleMod,
	E_FIXES_OnEnterExitModShop,
	E_FIXES_OnVehiclePaintjob,
	E_FIXES_OnVehicleRespray,
	E_FIXES_OnVehicleDamageStatusUp,
	E_FIXES_OnPlayerSelectedMenuRow,
	E_FIXES_OnPlayerExitedMenu
}

enum E_FIXES_CALLBACK_HOOKS_2 (<<= 1)
{
	E_FIXES_OnPlayerInteriorChange = 1,
	E_FIXES_OnPlayerKeyStateChange,
	E_FIXES_OnRconLoginAttempt,
	E_FIXES_OnPlayerUpdate,
	E_FIXES_OnPlayerStreamIn,
	E_FIXES_OnPlayerStreamOut,
	E_FIXES_OnVehicleStreamIn,
	E_FIXES_OnVehicleStreamOut,
	E_FIXES_OnDialogResponse,
	E_FIXES_OnPlayerClickPlayer
}

/*
 * E_FIXES_WORLDBOUND_DATA
 *
 * Store data for each player on their worldbound data.
 */
enum E_FIXES_WORLDBOUND_DATA
{
	// "Previous".
	Float:E_FIXES_WORLDBOUND_DATA_PX,
	Float:E_FIXES_WORLDBOUND_DATA_PY,
	Float:E_FIXES_WORLDBOUND_DATA_PZ,
	// "Lower".
	Float:E_FIXES_WORLDBOUND_DATA_LX,
	Float:E_FIXES_WORLDBOUND_DATA_LY,
	// "Upper".
	Float:E_FIXES_WORLDBOUND_DATA_UX,
	Float:E_FIXES_WORLDBOUND_DATA_UY
}

/*
 * e_FIXES_BOOLS
 *
 * Collection of boolean values for players, designed to collect multiple checks
 * in to one variable to reduce memory consumption.
 */
enum e_FIXES_BOOLS (<<= 1)
{
	// Handy definition for nothing set.
	e_FIXES_BOOLS_NONE = 0,
	// Does this player have worldbounds enabled?
	e_FIXES_BOOLS_WORLDBOUNDS = 1,
	e_FIXES_BOOLS_UNCONTROLLABLE,
	e_FIXES_BOOLS_PUT_IN_VEHICLE
}

// These varaibles are NOT pre-processor dependent as they are stock.  It's just
// simpler than trying to figure out when or if a semi-colon is needed.
static stock
	/*
	 * bool:IS_FILTERSCRIPT
	 *
	 * Runtime equivalent of "FILTERSCRIPT" for when it is not set by the user.
	 */
	bool:IS_FILTERSCRIPT,
	/*
	 * E_FIXES_CALLBACK_HOOKS_1:FIXES_gsCallbackHooks1
	 * E_FIXES_CALLBACK_HOOKS_1:FIXES_gsCallbackHooks2
	 *
	 * Bit arrays of callbacks.  You can only have 32 callbacks per variable,
	 * and there are more than that many, so we need more than one variable.
	 * Add new callback detection to "FIXES_ScriptInit" - only actually used
	 * callbacks are currently hooked.
	 */
	E_FIXES_CALLBACK_HOOKS_1:FIXES_gsCallbackHooks1,
	E_FIXES_CALLBACK_HOOKS_2:FIXES_gsCallbackHooks2,
	/*
	 * FIXES_gsPlayerSkin[MAX_PLAYERS]
	 *
	 * The skin the player is currently using.
	 */
	FIXES_gsPlayerSkin[MAX_PLAYERS],
	/*
	 * e_FIXES_BOOLEAN_DATA:FIXES_gsBooleanData[MAX_PLAYERS]
	 *
	 * Collection of boolean values for players.
	 */
	e_FIXES_BOOLS:FIXES_gsBooleanData[MAX_PLAYERS],
	/*
	 * FIXES_gsWorldbounds[MAX_PLAYERS][E_FIXES_WORLDBOUND_DATA]
	 *
	 * All data for players on where their worldbounds are and where they last
	 * were before they went through the bounds by crouching.
	 */
	FIXES_gsWorldbounds[MAX_PLAYERS][E_FIXES_WORLDBOUND_DATA],
	/*
	 * FIXES_gsPlayerWeapon[MAX_PLAYERS]
	 *
	 * Stores the weapon set by "SetPlayerArmedWeapon" when in a vehicle.
	 */
	FIXES_gsPlayerWeapon[MAX_PLAYERS],
	/*
	 * FIXES_gsVehicleSeatData[MAX_PLAYERS]
	 *
	 * What vehicle the player is due to go in.
	 */
	FIXES_gsVehicleSeatData[MAX_PLAYERS];

static stock const
	/*
	 * FIXES_gscPlayerColours[]
	 *
	 * This array DOES NOT use "MAX_PLAYERS", but it is the ONLY time that macro
	 * should not be used.  This is because it has 500 items of initialisation
	 * data, but the user may have adjusted "MAX_PLAYERS" to something else.
	 */
	FIXES_gscPlayerColours[] = {0};

/*
 * _FIXES_KEY_AIM
 * KEY_AIM
 *
 * Because the default SA:MP includes missed this one.
 */
#define _FIXES_KEY_AIM                   (128)
#if FIX_KEY_AIM
	#define KEY_AIM                      _FIXES_KEY_AIM
#endif

/*
 * FIXES_DETECT_CALLBACK_1(callback)
 * FIXES_DETECT_CALLBACK_2(callback)
 *
 * Macro to make detecting callbacks simpler.  The number relates to which
 * variable the callback is found it.  This explicity detects the "On" part of
 * the callback because some scripts redefine the callback names and we need to
 * always correctly detect them, and always have "FIXES_On"#%0 work without
 * using the redefined name (e.g. if a prior script uses ALS).
 */
#define FIXES_DETECT_CALLBACK_1(%0On%1) (FIXES_gsCallbackHooks1|=E_FIXES_On%1*E_FIXES_CALLBACK_HOOKS_1:(funcidx("FIXES_On"#%1)!=-1))
#define FIXES_DETECT_CALLBACK_2(%0On%1) (FIXES_gsCallbackHooks2|=E_FIXES_On%1*E_FIXES_CALLBACK_HOOKS_2:(funcidx("FIXES_On"#%1)!=-1))

/*
 * FIXES_CALL_CALLBACK_1(callback, default, format[], ...)
 * FIXES_CALL_CALLBACK_2(callback, default, format[], ...)
 *
 * Macro to make calling callbacks simpler.  This takes the name of a callback
 * to chain - if it exists then it is called, if it doesn't exist the default
 * is returned.  Note that this DOES NOT end the current function, use in
 * conjunction with "return", or store the value to call the next element in the
 * chain before some bits of processing.
 */
#define FIXES_CALL_CALLBACK_1(%0On%1,%2,%3) ((FIXES_gsCallbackHooks1&E_FIXES_On%1)?(CallLocalFunction("FIXES_On"#%1,%3)):(%2))
#define FIXES_CALL_CALLBACK_2(%0On%1,%2,%3) ((FIXES_gsCallbackHooks2&E_FIXES_On%1)?(CallLocalFunction("FIXES_On"#%1,%3)):(%2))

/*
 * FIXES_OnScriptInit()
 *
 * Do all initialisation code in here.  Is called once when the script starts,
 * regardless of HOW the script is started (FilterScript or GameMode).  Add
 * detection of new callbacks here.
 *
 * FIXES:
 */
static FIXES_OnScriptInit()
{
	FIXES_DETECT_CALLBACK_1(OnGameModeInit);
	FIXES_DETECT_CALLBACK_1(OnFilterScriptInit);
	#if FIX_SetPlayerWorldBounds || FIX_TogglePlayerControllable || FIX_SetPlayerName || FIX_GetPlayerSkin || FIX_IsPlayerInCheckpoint || FIX_IsPlayerInRaceCheckpoint || FIX_GetPlayerWeapon || FIX_PutPlayerInVehicle
		FIXES_DETECT_CALLBACK_1(OnPlayerConnect);
	#endif
	#if FIX_GetPlayerSkin || FIX_TogglePlayerControllable
		FIXES_DETECT_CALLBACK_1(OnPlayerSpawn);
	#endif
	#if FIX_SetPlayerWorldBounds || FIX_TogglePlayerControllable
		FIXES_DETECT_CALLBACK_2(OnPlayerUpdate);
	#endif
	#if FIX_HydraSniper || FIX_GetPlayerWeapon || FIX_PutPlayerInVehicle
		FIXES_DETECT_CALLBACK_1(OnPlayerStateChange);
	#endif
}

/*
 * OnFilterScriptInit()
 *
 * Set "IS_FILTERSCRIPT" to true as this callback is ONLY called if this script
 * is actually a FilterScript.  Then call "FIXES_OnScriptInit".
 *
 * FIXES:
 *     IS_FILTERSCRIPT
 */
public OnFilterScriptInit()
{
	// =====================
	//  START: FILTERSCRIPT
	// =====================
	#if FIX_FILTERSCRIPT
		IS_FILTERSCRIPT = true;
	#endif
	// =====================
	//  END:   FILTERSCRIPT
	// =====================

	FIXES_OnScriptInit();
	return FIXES_CALL_CALLBACK_1(OnFilterScriptInit, 1, "");
}
#if defined _ALS_OnFilterScriptInit
	#undef OnFilterScriptInit
#else
	#define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit FIXES_OnFilterScriptInit
forward OnFilterScriptInit();

/*
 * OnGameModeInit()
 *
 * Call "FIXES_OnScriptInit" if this is not a FilterScript.
 *
 * FIXES:
 *     IS_FILTERSCRIPT
 */
public OnGameModeInit()
{
	#if FIX_FILTERSCRIPT
	if (!IS_FILTERSCRIPT)
	#endif
	{
		FIXES_OnScriptInit();
	}
	return FIXES_CALL_CALLBACK_1(OnGameModeInit, 1, "");
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit FIXES_OnGameModeInit
forward OnGameModeInit();

/*
 * OnPlayerConnect(playerid)
 *
 * Almost every fix uses this callback for initialisation.  It is only
 * explicitly referenced for those fixes where this is all the code.
 *
 * FIXES:
 *     TogglePlayerControllable
 *     SetPlayerWorldBounds
 *     GetPlayerColor
 *     SetPlayerName
 *     GetPlayerSkin
 *     IsPlayerInCheckpoint
 *     IsPlayerInRaceCheckpoint
 *     GetPlayerWeapon
 */
#if FIX_SetPlayerWorldBounds || FIX_TogglePlayerControllable || FIX_SetPlayerName || FIX_GetPlayerSkin || FIX_IsPlayerInCheckpoint || FIX_IsPlayerInRaceCheckpoint || FIX_GetPlayerWeapon || FIX_PutPlayerInVehicle
	public OnPlayerConnect(playerid)
	{
		#if FIX_SetPlayerWorldBounds || FIX_TogglePlayerControllable || FIX_PutPlayerInVehicle
			FIXES_gsBooleanData[playerid] = e_FIXES_BOOLS_NONE;
		#endif

		// ======================
		//  START: SetPlayerName
		// ======================
		#if FIX_SetPlayerName
			new
				name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, MAX_PLAYER_NAME);
			if (strcmp(name, "FIXES TEMP NAME") == 0)
			{
				Kick(playerid);
			}
		#endif
		// ======================
		//  END:   SetPlayerName
		// ======================

		// =======================
		//  START: SetPlayerColor
		// =======================
		// =======================
		//  END:   SetPlayerColor
		// =======================

		// ======================
		//  START: GetPlayerSkin
		// ======================
		#if FIX_GetPlayerSkin
			FIXES_gsPlayerSkin[playerid] = 0;
		#endif
		// ======================
		//  END:   GetPlayerSkin
		// ======================

		// =============================
		//  START: IsPlayerInCheckpoint
		// =============================
		#if FIX_IsPlayerInCheckpoint
			DisablePlayerCheckpoint(playerid);
		#endif
		// =============================
		//  END:   IsPlayerInCheckpoint
		// =============================

		// =================================
		//  START: IsPlayerInRaceCheckpoint
		// =================================
		#if FIX_IsPlayerInRaceCheckpoint
			DisablePlayerRaceCheckpoint(playerid);
		#endif
		// =================================
		//  END:   IsPlayerInRaceCheckpoint
		// =================================

		// ========================
		//  START: GetPlayerWeapon
		// ========================
		#if FIX_GetPlayerWeapon
			FIXES_gsPlayerWeapon[playerid] = -1;
		#endif
		// ========================
		//  END:   GetPlayerWeapon
		// ========================

		return FIXES_CALL_CALLBACK_1(OnPlayerConnect, 1, "i", playerid);
	}
	#if defined _ALS_OnPlayerConnect
		#undef OnPlayerConnect
	#else
		#define _ALS_OnPlayerConnect
	#endif
	#define OnPlayerConnect FIXES_OnPlayerConnect
	forward OnPlayerConnect(playerid);
#endif

/*
 * FIXES_SpawnPlayer(playerid)
 *
 * FIXES:
 *     SpawnPlayer
 */
#if FIX_SpawnPlayer
	stock FIXES_SpawnPlayer(playerid)
	{
		RemovePlayerFromVehicle(playerid);
		return SpawnPlayer(playerid);
	}
	#if defined _ALS_SpawnPlayer
		#undef SpawnPlayer
	#else
		#define _ALS_SpawnPlayer
	#endif
	#define SpawnPlayer FIXES_SpawnPlayer
#endif

/*
 * FIXES_SetPlayerName(playerid, const name[])
 *
 * FIXES:
 *     SetPlayerName
 */
#if FIX_SetPlayerName
	stock FIXES_SetPlayerName(playerid, const name[])
	{
		if (strcmp(name, "FIXES TEMP NAME") == 0)
		{
			return 0;
		}
		SetPlayerName(playerid, "FIXES TEMP NAME");
		return SetPlayerName(playerid, name);
	}
	#if defined _ALS_SetPlayerName
		#undef SetPlayerName
	#else
		#define _ALS_SetPlayerName
	#endif
	#define SetPlayerName FIXES_SetPlayerName
#endif

/*
 * OnPlayerSpawn(playerid)
 *
 * FIXES:
 *     GetPlayerSkin
 *     TogglePlayerControllable
 */
#if FIX_GetPlayerSkin || FIX_TogglePlayerControllable
	public OnPlayerSpawn(playerid)
	{
		// ======================
		//  START: GetPlayerSkin
		// ======================
		#if FIX_GetPlayerSkin
			FIXES_gsPlayerSkin[playerid] = GetPlayerSkin(playerid);
		#endif
		// ======================
		//  END:   GetPlayerSkin
		// ======================

		// =================================
		//  START: TogglePlayerControllable
		// =================================
		#if FIX_TogglePlayerControllable
			FIXES_gsBooleanData[playerid] &= ~e_FIXES_BOOLS_UNCONTROLLABLE;
		#endif
		// =================================
		//  END:   TogglePlayerControllable
		// =================================

		return FIXES_CALL_CALLBACK_1(OnPlayerSpawn, 1, "i", playerid);
	}
	#if defined _ALS_OnPlayerSpawn
		#undef OnPlayerSpawn
	#else
		#define _ALS_OnPlayerSpawn
	#endif
	#define OnPlayerSpawn FIXES_OnPlayerSpawn
	forward OnPlayerSpawn(playerid);
#endif

/*
 * FIXES_SetPlayerSkin(playerid, skinid)
 *
 * FIXES:
 *     GetPlayerSkin
 */
#if FIX_GetPlayerSkin
	stock FIXES_SetPlayerSkin(playerid, skinid)
	{
		FIXES_gsPlayerSkin[playerid] = skinid;
		return SetPlayerSkin(playerid, skinid);
	}
	#if defined _ALS_SetPlayerSkin
		#undef SetPlayerSkin
	#else
		#define _ALS_SetPlayerSkin
	#endif
	#define SetPlayerSkin FIXES_SetPlayerSkin
#endif

/*
 * FIXES_GetPlayerSkin(playerid, skinid)
 *
 * FIXES:
 *     GetPlayerSkin
 */
#if FIX_GetPlayerSkin
	stock FIXES_GetPlayerSkin(playerid)
	{
		return FIXES_gsPlayerSkin[playerid];
	}
	#if defined _ALS_GetPlayerSkin
		#undef GetPlayerSkin
	#else
		#define _ALS_GetPlayerSkin
	#endif
	#define GetPlayerSkin FIXES_GetPlayerSkin
#endif

/*
 * FIXES_GetWeaponName(weaponid, weapon[], len)
 *
 * FIXES:
 *     GetWeaponName
 */
#if FIX_GetWeaponName
	stock FIXES_GetWeaponName(weaponid, weapon[], len)
	{
		switch (weaponid)
		{
			case 18:
			{
				weapon[0] = 0;
				strcat(weapon, "Molotov Cocktail", len);
				return 1;
			}
			case 44:
			{
				weapon[0] = 0;
				strcat(weapon, "Thermal Goggles", len);
				return 1;
			}
			case 45:
			{
				weapon[0] = 0;
				strcat(weapon, "Night vision Goggles", len);
				return 1;
			}
			default:
			{
				return GetWeaponName(weaponid, weapon, len);
			}
		}
		return 0;
	}
	#if defined _ALS_GetWeaponName
		#undef GetWeaponName
	#else
		#define _ALS_GetWeaponName
	#endif
	#define GetWeaponName FIXES_GetWeaponName
#endif

/*
 * OnPlayerUpdate(playerid)
 *
 * FIXES:
 *     SetPlayerWorldBounds
 *     TogglePlayerControllable
 */
#if FIX_SetPlayerWorldBounds || FIX_TogglePlayerControllable
	public OnPlayerUpdate(playerid)
	{
		#if FIX_SetPlayerWorldBounds || FIX_TogglePlayerControllable
		new
			ud,
			lr,
			keys;
		GetPlayerKeys(playerid, keys, ud, lr);
		#endif

		#if FIX_SetPlayerWorldBounds && !FIX_TogglePlayerControllable
			#pragma unused ud, lr
		#endif

		// =============================
		//  START: SetPlayerWorldBounds
		// =============================
		#if FIX_SetPlayerWorldBounds
			if (FIXES_gsBooleanData[playerid] & e_FIXES_BOOLS_WORLDBOUNDS && keys & _FIXES_KEY_AIM)
			{
				new
					Float:x,
					Float:y,
					Float:z;
				GetPlayerPos(playerid, x, y, z);
				if (FIXES_gsWorldbounds[playerid][E_FIXES_WORLDBOUND_DATA_LX] < x < FIXES_gsWorldbounds[playerid][E_FIXES_WORLDBOUND_DATA_UX] && FIXES_gsWorldbounds[playerid][E_FIXES_WORLDBOUND_DATA_LY] < y < FIXES_gsWorldbounds[playerid][E_FIXES_WORLDBOUND_DATA_UY])
				{
					FIXES_gsWorldbounds[playerid][E_FIXES_WORLDBOUND_DATA_PX] = x;
					FIXES_gsWorldbounds[playerid][E_FIXES_WORLDBOUND_DATA_PY] = y;
					FIXES_gsWorldbounds[playerid][E_FIXES_WORLDBOUND_DATA_PZ] = z;
				}
				else
				{
					SetPlayerPos(playerid, FIXES_gsWorldbounds[playerid][E_FIXES_WORLDBOUND_DATA_PX], FIXES_gsWorldbounds[playerid][E_FIXES_WORLDBOUND_DATA_PY], FIXES_gsWorldbounds[playerid][E_FIXES_WORLDBOUND_DATA_PZ]);
				}
			}
		#endif
		// =============================
		//  END:   SetPlayerWorldBounds
		// =============================

		// =================================
		//  START: TogglePlayerControllable
		// =================================
		#if FIX_TogglePlayerControllable
			// MUST come last.
			if (FIXES_gsBooleanData[playerid] & e_FIXES_BOOLS_UNCONTROLLABLE)
			{
				// Keys based sync blocking, modified based on a post by Slice:
				// http://forum.sa-mp.com/showpost.php?p=876854&postcount=1
				// Use "playerid" here as it's a variable that already exists,
				// but note that after this point, you CANNOT use "playerid" as
				// it has been "clobbered" (and yes, that's the technical term).
				// This is just to avoid "statement has no effect" warnings.
				// ALWAYS return 0 in this case, regardless of what other
				// callbacks return.
				playerid = FIXES_CALL_CALLBACK_2(OnPlayerUpdate, 1, "i", playerid);
				if (keys || ud || lr)
				{
					return 0;
				}
				else
				{
					return playerid;
				}
			}
			else
			{
				return FIXES_CALL_CALLBACK_2(OnPlayerUpdate, 1, "i", playerid);
			}
		#else
			return 1;
		#endif
		// =================================
		//  END:   TogglePlayerControllable
		// =================================
	}
	#if defined _ALS_OnPlayerUpdate
		#undef OnPlayerUpdate
	#else
		#define _ALS_OnPlayerUpdate
	#endif
	#define OnPlayerUpdate FIXES_OnPlayerUpdate
	forward OnPlayerUpdate(playerid);
#endif

/*
 * FIXES_SetPlayerWorldBounds(playerid, Float:x_max, Float:x_min, Float:y_max, Float:y_min)
 *
 * FIXES:
 *     SetPlayerWorldBounds
 */
#if FIX_SetPlayerWorldBounds
	stock FIXES_SetPlayerWorldBounds(playerid, Float:x_max, Float:x_min, Float:y_max, Float:y_min)
	{
		// This code could do with a way to mostly remove the checks.  Maybe
		// when setting everything to FIXES_INFINITY (with default parameters).
		FIXES_gsBooleanData[playerid] |= e_FIXES_BOOLS_WORLDBOUNDS;
		new
			Float:tmp;
		if (x_max < x_min)
		{
			tmp = x_min;
			x_min = x_max;
			x_max = tmp;
		}
		if (y_max < y_min)
		{
			tmp = y_min;
			y_min = y_max;
			y_max = tmp;
		}
		// Give a little leway so this fix isn't noticed if you're not trying to
		// break through the world bounds.  Leway removed in favour of keys.
		FIXES_gsWorldbounds[playerid][E_FIXES_WORLDBOUND_DATA_LX] = x_min;
		FIXES_gsWorldbounds[playerid][E_FIXES_WORLDBOUND_DATA_UX] = x_max;

		FIXES_gsWorldbounds[playerid][E_FIXES_WORLDBOUND_DATA_LY] = y_min;
		FIXES_gsWorldbounds[playerid][E_FIXES_WORLDBOUND_DATA_UY] = y_max;

		GetPlayerPos(playerid, tmp, tmp, tmp);
		FIXES_gsWorldbounds[playerid][E_FIXES_WORLDBOUND_DATA_PX] = (x_max - x_min) / 2 + x_min;
		FIXES_gsWorldbounds[playerid][E_FIXES_WORLDBOUND_DATA_PY] = (y_max - y_min) / 2 + y_min;
		FIXES_gsWorldbounds[playerid][E_FIXES_WORLDBOUND_DATA_PZ] = tmp;

		return SetPlayerWorldBounds(playerid, x_max, x_min, y_max, y_min);
	}
	#if defined _ALS_SetPlayerWorldBounds
		#undef SetPlayerWorldBounds
	#else
		#define _ALS_SetPlayerWorldBounds
	#endif
	#define SetPlayerWorldBounds FIXES_SetPlayerWorldBounds
#endif

/*
 * FIXES_TogglePlayerControllable(playerid, toggle)
 *
 * FIXES:
 *     TogglePlayerControllable
 */
#if FIX_TogglePlayerControllable
	stock FIXES_TogglePlayerControllable(playerid, toggle)
	{
		if (toggle)
		{
			FIXES_gsBooleanData[playerid] |= e_FIXES_BOOLS_UNCONTROLLABLE;
		}
		else
		{
			FIXES_gsBooleanData[playerid] &= ~e_FIXES_BOOLS_UNCONTROLLABLE;
		}
		return TogglePlayerControllable(playerid, toggle);
	}
	#if defined _ALS_TogglePlayerControllable
		#undef TogglePlayerControllable
	#else
		#define _ALS_TogglePlayerControllable
	#endif
	#define TogglePlayerControllable FIXES_TogglePlayerControllable
#endif

/*
 * OnPlayerStateChange(playerid, newstate, oldstate)
 *
 * FIXES:
 *     HydraSniper
 *     GetPlayerWeapon
 *     PutPlayerInVehicle
 */
#if FIX_HydraSniper || FIX_GetPlayerWeapon || FIX_PutPlayerInVehicle
	public OnPlayerStateChange(playerid, newstate, oldstate)
	{
		// ====================
		//  BEGIN: HydraSniper
		// ====================
		#if FIX_HydraSniper
			if (newstate == PLAYER_STATE_DRIVER)
			{
				new
					model = GetVehicleModel(GetPlayerVehicleID(playerid));
				if (model == 520 || model == 425)
				{
					SetPlayerArmedWeapon(playerid, 0);
					#if FIX_GetPlayerWeapon
						// This is the first cross-dependednt fix.
						FIXES_gsPlayerWeapon[playerid] = 0;
					#endif
				}
			}
		#endif
		// ====================
		//  END:   HydraSniper
		// ====================

		#if FIX_GetPlayerWeapon || FIX_PutPlayerInVehicle
			if (oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
			{
				// ========================
				//  BEGIN: GetPlayerWeapon
				// ========================
				#if FIX_GetPlayerWeapon
					FIXES_gsPlayerWeapon[playerid] = -1;
				#endif
				// ========================
				//  END:   GetPlayerWeapon
				// ========================

				// ===========================
				//  START: PutPlayerInVehicle
				// ===========================
				#if FIX_PutPlayerInVehicle
					// Update their vehicle once we KNOW the client has done
					// the removeal from the vehicle.
					if (FIXES_gsBooleanData[playerid] & e_FIXES_BOOLS_PUT_IN_VEHICLE)
					{
						// Limited to "only" 16777216 vehicles and 256 seats.
						PutPlayerInVehicle(playerid, FIXES_gsVehicleSeatData[playerid] & 0x00FFFFFF, FIXES_gsVehicleSeatData[playerid] >>> 24);
						FIXES_gsBooleanData[playerid] &= ~e_FIXES_BOOLS_PUT_IN_VEHICLE;
					}
				#endif
				// ===========================
				//  END:   PutPlayerInVehicle
				// ===========================
			}
		#endif

		return FIXES_CALL_CALLBACK_1(OnPlayerStateChange, 1, "iii", playerid, newstate, oldstate);
	}
	#if defined _ALS_OnPlayerStateChange
		#undef OnPlayerStateChange
	#else
		#define _ALS_OnPlayerStateChange
	#endif
	#define OnPlayerStateChange FIXES_OnPlayerStateChange
	forward OnPlayerStateChange(playerid, newstate, oldstate);
#endif

/*
 * FIXES_SetPlayerArmedWeapon(playerid, weaponid)
 *
 * FIXES:
 *     GetPlayerWeapon
 */
#if FIX_GetPlayerWeapon
	stock FIXES_SetPlayerArmedWeapon(playerid, weaponid)
	{
		if (IsPlayerInAnyVehicle(playerid))
		{
			FIXES_gsPlayerWeapon[playerid] = weaponid;
		}
		return SetPlayerArmedWeapon(playerid, weaponid);
	}
	#if defined _ALS_SetPlayerArmedWeapon
		#undef SetPlayerArmedWeapon
	#else
		#define _ALS_SetPlayerArmedWeapon
	#endif
	#define SetPlayerArmedWeapon FIXES_SetPlayerArmedWeapon
#endif

/*
 * FIXES_GetPlayerWeapon(playerid)
 *
 * FIXES:
 *     GetPlayerWeapon
 */
#if FIX_GetPlayerWeapon
	stock FIXES_GetPlayerWeapon(playerid)
	{
		if (FIXES_gsPlayerWeapon[playerid] == -1)
		{
			return GetPlayerWeapon(playerid);
		}
		return FIXES_gsPlayerWeapon[playerid];
	}
	#if defined _ALS_GetPlayerWeapon
		#undef GetPlayerWeapon
	#else
		#define _ALS_GetPlayerWeapon
	#endif
	#define GetPlayerWeapon FIXES_GetPlayerWeapon
#endif

/*
 * FIXES_PutPlayerInVehicle(playerid, vehicleid, seatid)
 *
 * FIXES:
 *     PutPlayerInVehicle
 */
#if FIX_PutPlayerInVehicle
	stock FIXES_PutPlayerInVehicle(playerid, vehicleid, seatid)
	{
		new
			vid = GetPlayerVehicleID(playerid);
		if (vid)
		{
			new
				Float:x,
				Float:y,
				Float:z;
			// Remove them without the animation.
			GetVehiclePos(vid, x, y, z);
			SetPlayerPos(playerid, x, y, z);
			FIXES_gsVehicleSeatData[playerid] = seatid << 24 || vehicleid;
			FIXES_gsBooleanData[playerid] |= e_FIXES_BOOLS_PUT_IN_VEHICLE;
			return 1;
		}
		return PutPlayerInVehicle(playerid, vehicleid, seatid);
	}
	#if defined _ALS_PutPlayerInVehicle
		#undef PutPlayerInVehicle
	#else
		#define _ALS_PutPlayerInVehicle
	#endif
	#define PutPlayerInVehicle FIXES_PutPlayerInVehicle
#endif

/*
 * FIXES_SetPlayerCheckpoint(playerid, Float:x, Float:y, Float:z, Float:size)
 *
 * FIXES:
 *     SetPlayerCheckpoint
 */
#if FIX_SetPlayerCheckpoint
        stock FIXES_SetPlayerCheckpoint(playerid, Float:x, Float:y, Float:z, Float:size)
        {
                DisablePlayerCheckpoint(playerid);
                return SetPlayerCheckpoint(playerid, x, y, z, size);
        }
        #if defined _ALS_SetPlayerCheckpoint
                #undef SetPlayerCheckpoint
        #else
                #define _ALS_SetPlayerCheckpoint
        #endif
        #define SetPlayerCheckpoint FIXES_SetPlayerCheckpoint
#endif

/*
 * FIXES_SetPlayerRaceCheckpoint(playerid, type, Float:x, Float:y, Float:z, Float:nextx, Float:nexty, Float:nextz, Float:size)
 *
 * FIXES:
 *     SetPlayerRaceCheckpoint
 */
#if FIX_SetPlayerRaceCheckpoint
        stock FIXES_SetPlayerRaceCheckpoint(playerid, type, Float:x, Float:y, Float:z, Float:nextx, Float:nexty, Float:nextz, Float:size)
        {
                DisablePlayerRaceCheckpoint(playerid);
                return SetPlayerRaceCheckpoint(playerid, type, x, y, z, nextx, nexty, nextz, size);
        }
        #if defined _ALS_SetPlayerRaceCheckpoint
                #undef SetPlayerRaceCheckpoint
        #else
                #define _ALS_SetPlayerRaceCheckpoint
        #endif
        #define SetPlayerRaceCheckpoint FIXES_SetPlayerRaceCheckpoint
#endif