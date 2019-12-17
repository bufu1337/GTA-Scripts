/*
 *            TeamSpawn 1.1
 *       (c) Copyright 2007 by DracoBlue
 *
 * @author    : DracoBlue (http://dracoblue.com)
 * @date      : 10th Dec 2007
 * @update    : 11th Dec 2007
 *
 * This file is provided as is (no warranties).
 *
 * Feel free to use it, a little message in
 * about box is honouring thing, isn't it?
 *
 */
new TEAMSPAWN_class_interior[TEAMSPAWN_MAX_SPAWNS_PER_TEAM*MAX_TEAMS];
new TEAMSPAWN_player_class_selected[MAX_PLAYERS];
new TEAMSPAWN_class_count=0;
new TEAMSPAWN_spawn_name[MAX_TEAMS][TEAMSPAWN_MAX_SPAWNS_PER_TEAM][MAX_STRING];
new Float:TEAMSPAWN_spawn_pos[MAX_TEAMS][TEAMSPAWN_MAX_SPAWNS_PER_TEAM][4];
new TEAMSPAWN_spawn_skinid[MAX_TEAMS][TEAMSPAWN_MAX_SPAWNS_PER_TEAM];
new TEAMSPAWN_spawncount[MAX_TEAMS];
new TEAMSPAWN_teamcolor[MAX_TEAMS];

new TEAMSPAWN_team_id_used[MAX_TEAMS];

new Text:TEAMSPAWN_textdraw[MAX_TEAMS];

new TEAMSPAWN_views_teamtextdraw[MAX_PLAYERS];

/**
 * Sets the name of a team
 * @param int team_id ID of the team (should be different to 0)
 * @param string name New name of the team
 */
stock SetTeamName(team_id,name[]) {
	if (TEAMSPAWN_team_id_used[team_id]==0) {
		TEAMSPAWN_textdraw[team_id] = TextDrawCreate(635.0, 432.0, "OCRAD");
		TextDrawSetShadow(TEAMSPAWN_textdraw[team_id], 0);
		TextDrawAlignment(TEAMSPAWN_textdraw[team_id], 3);
		TextDrawSetOutline(TEAMSPAWN_textdraw[team_id], 1);
		TextDrawLetterSize(TEAMSPAWN_textdraw[team_id], 0.4, 1.4);
		TextDrawFont(TEAMSPAWN_textdraw[team_id], 2);
		TEAMSPAWN_team_id_used[team_id]=1;
	}
	TextDrawSetString(TEAMSPAWN_textdraw[team_id],name);
	TextDrawColor(TEAMSPAWN_textdraw[team_id],TEAMSPAWN_teamcolor[team_id]);
}

/**
 * Sets the color of the team
 * @param int team_id ID of the Team (should be different to 0)
 * @param int hex Color in Hex, e.g. 0xFFFF00AA 
 */
stock SetTeamColor(team_id,hex) {
	TEAMSPAWN_teamcolor[team_id]= hex;
	for (new p;p<MAX_PLAYERS;p++) if (IsPlayerConnected(p) && GetPlayerTeam(p)==team_id) SetPlayerColor(p,TEAMSPAWN_teamcolor[team_id]);
	
	if (TEAMSPAWN_team_id_used[team_id]==0) {
		TEAMSPAWN_textdraw[team_id] = TextDrawCreate(635.0, 432.0, "OCRAD");
		TextDrawSetShadow(TEAMSPAWN_textdraw[team_id], 0);
		TextDrawAlignment(TEAMSPAWN_textdraw[team_id], 3);
		TextDrawSetOutline(TEAMSPAWN_textdraw[team_id], 1);
		TextDrawLetterSize(TEAMSPAWN_textdraw[team_id], 0.4, 1.4);
		TextDrawFont(TEAMSPAWN_textdraw[team_id], 2);
		TEAMSPAWN_team_id_used[team_id]=1;
	}
	TextDrawColor(TEAMSPAWN_textdraw[team_id],TEAMSPAWN_teamcolor[team_id]);
}

/**
 * Creates a new spawn for the team
 * @param int team_id ID of the Team (should be different to 0)
 * @param int skin_id ID of the Skin to use at this spawn
 * @param string name Name of that Spawnpoint
 * @param float x Position X
 * @param float y Position Y
 * @param float z Position Z
 * @param float r Position R (Angle)
 * @param int interior Interior
 * @param int w1 Weapon #1
 * @param int w1ammo Ammo for Weapon #1
 * @param int w2 Weapon #2
 * @param int w2ammo Ammo for Weapon #2
 * @param int w3 Weapon #3
 * @param int w3ammo Ammo for Weapon #3
 */
stock CreateSpawn(team_id,skin_id,name[],Float:x,Float:y,Float:z,Float:r,interior,w1,w1ammo,w2,w2ammo,w3,w3ammo) {
	TEAMSPAWN_class_interior[TEAMSPAWN_class_count]=interior;
	TEAMSPAWN_class_count++;
	if (team_id<0 || team_id>=MAX_TEAMS) return -1;
	if (TEAMSPAWN_team_id_used[team_id]==0) {
		TEAMSPAWN_textdraw[team_id] = TextDrawCreate(635.0, 432.0, "OCRAD");
		TextDrawSetShadow(TEAMSPAWN_textdraw[team_id], 0);
		TextDrawAlignment(TEAMSPAWN_textdraw[team_id], 3);
		TextDrawSetOutline(TEAMSPAWN_textdraw[team_id], 1);
		TextDrawLetterSize(TEAMSPAWN_textdraw[team_id], 0.4, 1.4);
		TextDrawFont(TEAMSPAWN_textdraw[team_id], 2);
		TextDrawColor(TEAMSPAWN_textdraw[team_id],TEAMSPAWN_teamcolor[team_id]);
		TEAMSPAWN_team_id_used[team_id]=1;
	}
	AddPlayerClassEx(team_id, skin_id, x, y, z, r, w1, w1ammo, w2, w2ammo, w3, w3ammo);
	format(TEAMSPAWN_spawn_name[team_id][TEAMSPAWN_spawncount[team_id]],MAX_STRING,"%s",name);
	TEAMSPAWN_spawn_pos[team_id][TEAMSPAWN_spawncount[team_id]][0]=x;
	TEAMSPAWN_spawn_pos[team_id][TEAMSPAWN_spawncount[team_id]][1]=y;
	TEAMSPAWN_spawn_pos[team_id][TEAMSPAWN_spawncount[team_id]][2]=z;
	TEAMSPAWN_spawn_pos[team_id][TEAMSPAWN_spawncount[team_id]][3]=r;
	TEAMSPAWN_spawn_skinid[team_id][TEAMSPAWN_spawncount[team_id]]=skin_id;
	TEAMSPAWN_spawncount[team_id]++;
	return (TEAMSPAWN_spawncount[team_id]-1);
}

teamspawn_GameModeInit() {
	SetTeamCount(MAX_TEAMS+1);
	for (new t;t<MAX_TEAMS;t++) {
			TEAMSPAWN_team_id_used[t]=0;
			TEAMSPAWN_teamcolor[t]=0xFFFFFF;
	}
	for (new i;i<MAX_PLAYERS;i++) TEAMSPAWN_views_teamtextdraw[i]=-1;
	
}

teamspawn_RequestClass(playerid, classid) {
#pragma unused classid
	SetVal(PlayerSpawned,playerid,0);
	TEAMSPAWN_player_class_selected[playerid]=classid;

	new players_team_id;
	players_team_id = GetPlayerTeam(playerid);
	
	if (players_team_id>-1 || players_team_id<MAX_TEAMS) {
		if (TEAMSPAWN_views_teamtextdraw[playerid]!=players_team_id) {
			if (TEAMSPAWN_views_teamtextdraw[playerid]!=-1) {
				// if we are already viewing one ... hide it!
				TextDrawHideForPlayer(playerid,TEAMSPAWN_textdraw[TEAMSPAWN_views_teamtextdraw[playerid]]);
			}
			TEAMSPAWN_views_teamtextdraw[playerid]=players_team_id;
			TextDrawShowForPlayer(playerid,TEAMSPAWN_textdraw[players_team_id]);
		}
		SetPlayerColor(playerid,TEAMSPAWN_teamcolor[players_team_id]);
	}
	SetPlayerInterior(playerid, 0); //0
	SetPlayerPos(playerid,388.3286,-2024.4844,8.8203);
	SetPlayerFacingAngle(playerid, 90.0);
	SetPlayerCameraPos(playerid,380.4250,-2020.8900,10.2500);
	SetPlayerCameraLookAt(playerid,388.3286,-2024.4844,8.8203);
	return 0;
}

teamspawn_Connect(playerid) {
	SetPlayerColor(playerid,0xFFFFFF);
	SetVal(PlayerSpawned,playerid,0);
}

teamspawn_Disconnect(playerid,reason) {
#pragma unused reason
	SetVal(PlayerSpawned,playerid,0);
	new players_team_id;
	players_team_id = GetPlayerTeam(playerid);
	if (players_team_id>-1 || players_team_id<MAX_TEAMS) {
		if (TEAMSPAWN_views_teamtextdraw[playerid]!=-1) {
			TextDrawHideForPlayer(playerid,TEAMSPAWN_textdraw[TEAMSPAWN_views_teamtextdraw[players_team_id]]);
			TEAMSPAWN_views_teamtextdraw[playerid]=-1;
		}
	}
}
teamspawn_Spawn(playerid) {
	SetVal(PlayerSpawned,playerid,1);
	SetPlayerInterior(playerid,TEAMSPAWN_class_interior[TEAMSPAWN_player_class_selected[playerid]]);
	return 0;
}

teamspawn_Death(playerid,killerid,reason) {
#pragma unused reason
#pragma unused killerid
	SetVal(PlayerSpawned,playerid,0);
	return 0;
}
