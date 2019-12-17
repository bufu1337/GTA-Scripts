/*  SA:MP Player Functions
 *
 *  (c) Copyright 2005-2006, SA:MP Team
 *
 */

#pragma library players

new PLAYER_class_for_player[MAX_PLAYERS];
new PLAYER_current_team[MAX_PLAYERS];

forward OnPlayerConnect(playerid);
public OnPlayerConnect(playerid) _Connect(playerid);
forward OnPlayerDisconnect(playerid, reason);
public OnPlayerDisconnect(playerid, reason) _Disconnect(playerid, reason);

forward OnPlayerRequestClass(playerid, classid);
public OnPlayerRequestClass(playerid, classid) {
	PLAYER_class_for_player[playerid]=classid;
	SetPlayerTeam(playerid,SAMPCORE_team_for_class[PLAYER_class_for_player[playerid]]);
	if (_RequestClass(playerid, classid)) {
		return 0;
	}
	return 1;
}
forward OnPlayerRequestSpawn(playerid);
public OnPlayerRequestSpawn(playerid) {
	if (_RequestSpawn(playerid)) {
		return 0;
	}
	return 1;
}
forward OnPlayerSpawn(playerid);
public OnPlayerSpawn(playerid) {
	SetPlayerTeam(playerid,PLAYER_current_team[playerid]);
	if (_Spawn(playerid)) {
		return 0;
	}
	return 1;
}

forward OnPlayerDeath(playerid, killerid, reason);
public OnPlayerDeath(playerid, killerid, reason) _Death(playerid, killerid, reason);

forward OnPlayerPrivmsg(playerid, recieverid, text[]);
public OnPlayerPrivmsg(playerid, recieverid, text[]) {
	if (_Privmsg(playerid, recieverid, text)) {
		return 0;
	}
	return 1;
}
forward OnPlayerText(playerid, text[]);
public OnPlayerText(playerid, text[]) {
	if (_Text(playerid, text)) {
		return 0;
	}
	return 1;
}
forward OnPlayerCommandText(playerid, cmdtext[]);
public OnPlayerCommandText(playerid, cmdtext[]) {
	if (_CommandText(playerid, cmdtext)) {
		return 1;
	}
	return 0;
}


forward OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid);
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid) _InteriorChange(playerid, newinteriorid, oldinteriorid);
forward OnPlayerInfoChange(playerid);
public OnPlayerInfoChange(playerid) _InfoChange(playerid);
forward OnPlayerStateChange(playerid, newstate, oldstate);
public OnPlayerStateChange(playerid, newstate, oldstate) _StateChange(playerid, newstate, oldstate);

// Checkpoints
forward OnPlayerEnterCheckpoint(playerid);
public OnPlayerEnterCheckpoint(playerid) _EnterCP(playerid);
forward OnPlayerLeaveCheckpoint(playerid);
public OnPlayerLeaveCheckpoint(playerid) _LeaveCP(playerid);
forward OnPlayerEnterRaceCheckpoint(playerid);
public OnPlayerEnterRaceCheckpoint(playerid) _EnterRaceCP(playerid);
forward OnPlayerLeaveRaceCheckpoint(playerid);
public OnPlayerLeaveRaceCheckpoint(playerid) _LeaveRaceCP(playerid);

forward OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) _KeysChange(playerid, newkeys, oldkeys);
forward OnPlayerTeamPrivmsg(playerid, teamid, text[]);
public OnPlayerTeamPrivmsg(playerid, teamid, text[]) _TeamPrivmsg(playerid, teamid, text);

#pragma library players

#define SPECIAL_ACTION_NONE			0
#define SPECIAL_ACTION_USEJETPACK		2
#define SPECIAL_ACTION_DANCE1			5
#define SPECIAL_ACTION_DANCE2			6
#define SPECIAL_ACTION_DANCE3			7
#define SPECIAL_ACTION_DANCE4			8
#define SPECIAL_ACTION_HANDSUP			10
#define SPECIAL_ACTION_USECELLPHONE		11
#define SPECIAL_ACTION_SITTING			12
#define SPECIAL_ACTION_STOPUSECELLPHONE 	13

native SendClientMessage(playerid, color, const message[]);
native SendPlayerMessageToPlayer(playerid, senderid, const message[]);
native SendPlayerMessageToAll(senderid, const message[]);
native SendDeathMessage(killer,killee,weapon);
native GameTextForPlayer(playerid,const string[],time,style);

// Admin
native IsPlayerAdmin(playerid);
native Kick(playerid);
native Ban(playerid);
native BanEx(playerid, const reason[]);

// Player conditionals
native IsPlayerConnected(playerid);
native IsPlayerInCheckpoint(playerid);
native IsPlayerInRaceCheckpoint(playerid);

// Player
native SAMP_SetSpawnInfo(playerid, team, skin, Float:x, Float:y, Float:z, Float:rotation, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo)=SetSpawnInfo;
stock SetSpawnInfo(playerid, team, skin, Float:x, Float:y, Float:z, Float:rotation, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo) {
	PLAYER_current_team[playerid] = team;
	SAMP_SetSpawnInfo(playerid, team, skin, x, y, z, rotation, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);
}
native SpawnPlayer(playerid);

// Player info
native SetPlayerPos(playerid, Float:x, Float:y, Float:z);
native SetPlayerPosFindZ(playerid, Float:x, Float:y, Float:z);
native GetPlayerPos(playerid, &Float:x, &Float:y, &Float:z);
native SetPlayerFacingAngle(playerid,Float:ang);
native GetPlayerFacingAngle(playerid,&Float:ang);
native SetPlayerInterior(playerid,interiorid);
native GetPlayerInterior(playerid);
native SAMP_SetPlayerHealth(playerid, Float:health)=SetPlayerHealth;
stock SetPlayerHealth(playerid,Float:health) {
	SetVal(PlayerHealth,playerid,floatround(health));
}
native SAMP_GetPlayerHealth(playerid, &Float:health)=GetPlayerHealth;
stock GetPlayerHealth(playerid, &Float:health) {
	SAMP_GetPlayerHealth(playerid,health);
}

player_ReadPlayerHealth(playerid) {
	new Float:health;
	SAMP_GetPlayerHealth(playerid,health);
	A_PlayerHealth[playerid]=floatround(health);
	return 1;
}

player_WritePlayerHealth(playerid,newval) {
	SAMP_SetPlayerHealth(playerid,float(newval));
	return 0;
}

native SetPlayerArmour(playerid, Float:armour);
native GetPlayerArmour(playerid, &Float:armour);
native SetPlayerAmmo(playerid, weaponslot, ammo);
native GetPlayerAmmo(playerid);

native SAMP_SetPlayerTeam(playerid, teamid)=SetPlayerTeam;
stock SetPlayerTeam(playerid, teamid) {
	PLAYER_current_team[playerid]=teamid;
	for (new p;p<MAX_PLAYERS;p++) if (IsPlayerConnected(p)) {
		SAMP_SetPlayerTeam(p,PLAYER_current_team[p]);
	}
}
native GetPlayerTeam(playerid);

native SetPlayerScore(playerid,score);
native GetPlayerScore(playerid);
native SetPlayerColor(playerid,color);
native GetPlayerColor(playerid);
native SetPlayerSkin(playerid, skinid);
native GetPlayerSkin(playerid);
native GivePlayerWeapon(playerid, weaponid, ammo);
native ResetPlayerWeapons(playerid);
native GetPlayerWeaponData(playerid, slot, &weapons, &ammo);
native GivePlayerMoney(playerid,money);
native ResetPlayerMoney(playerid);
native SetPlayerName(playerid, const name[]);
native GetPlayerMoney(playerid);
native GetPlayerState(playerid);
native GetPlayerIp(playerid, name[], len);
native GetPlayerPing(playerid);
native GetPlayerWeapon(playerid);
native GetPlayerKeys(playerid, &keys, &updown, &leftright);
native GetPlayerName(playerid, const name[], len);
native SetPlayerTime(playerid, hour, minute);
native GetPlayerTime(playerid, &hour, &minute);
native TogglePlayerClock(playerid, toggle);
native SetPlayerWeather(playerid, weather);
native SetPlayerDisabledWeapons(playerid, ...);
native ForceClassSelection(playerid);
native SetPlayerWantedLevel(playerid, level);
native GetPlayerWantedLevel(playerid);

// Player controls
native TogglePlayerControllable(playerid, toggle);
native PlayerPlaySound(playerid, soundid, Float:x, Float:y, Float:z);
native ApplyAnimation(playerid, animlib[], animname[], Float:fS, opt1, opt2, opt3, opt4, opt5);
native ClearAnimations(playerid);
native GetPlayerSpecialAction(playerid);
native SetPlayerSpecialAction(playerid,actionid);

// Player map commands
native SetPlayerCheckpoint(playerid, Float:x, Float:y, Float:z, Float:size);
native DisablePlayerCheckpoint(playerid);
native SetPlayerRaceCheckpoint(playerid, type, Float:x, Float:y, Float:z, Float:nextx, Float:nexty, Float:nextz, Float:size);
native DisablePlayerRaceCheckpoint(playerid);
native SetPlayerWorldBounds(playerid,Float:x_max,Float:x_min,Float:y_max,Float:y_min);
native SetPlayerMarkerForPlayer(playerid, showplayerid, color);
native ShowPlayerNameTagForPlayer(playerid, showplayerid, show);
native SetPlayerMapIcon(playerid, iconid, Float:x, Float:y, Float:z, markertype, color);
native RemovePlayerMapIcon(playerid, iconid);
native SetPlayerCameraPos(playerid,Float:x, Float:y, Float:z);
native SetPlayerCameraLookAt(playerid, Float:x, Float:y, Float:z);
native SetCameraBehindPlayer(playerid);
native AllowPlayerTeleport(playerid, allow);

// Virtual Worlds
native SetPlayerVirtualWorld(playerid, worldid);
native GetPlayerVirtualWorld(playerid);

// Insane Stunts
native EnableStuntBonusForPlayer(playerid, enable);

// Spectating
native TogglePlayerSpectating(playerid, toggle);
native PlayerSpectatePlayer(playerid, targetplayerid, mode = SPECTATE_MODE_NORMAL);