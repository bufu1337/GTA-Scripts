// 	Checkpoint Manager
// 	(c) João Pedro Lopes, All right's reserved
forward public OnCheckpointEnter(playerid, checkpointid);
forward StreamCheckpoint();
#include <a_samp>
#define MAX_CHECKPOINTS 200
#define GLOBAL_OWNER_ID -1
enum pInfo{
	VisibleCheckpoint,
}
enum checkpointEnum{
	chp_created,			// Is this slot of the memory populated?
	chp_id,				// The ID of the checkpoint
	chp_owner,				// The ID of the player who this checkpoint is visible too
	Float:chp_posX,		// The X position of this checkpoint
	Float:chp_posY,		// The Y position of this checkpoint
	Float:chp_posZ,		// The Z position of this checkpoint
	Float:chp_size,		// The checkpoint size
	Float:chp_viewDistance,	// The checkpoint view distance
	bool:chp_active,		// Is this checkpoint active?
	chp_interior_id,		// The interior id of this checkpoint
	chp_world_id			// The world id of this checkpoint
};
new checkpoints[MAX_CHECKPOINTS][checkpointEnum];
new totalCheckpoints;
stock CreateCheckpoint(playerid, Float:posX, Float:posY, Float:posZ, Float:size, Float:viewDistance, CHPinterior, CHPworld){
	// Max checkpoint reached?
	if(totalCheckpoints == MAX_CHECKPOINTS) return 0;
	if(!totalCheckpoints){
		for(new i; i < MAX_PLAYERS; i++) PlayerInfo[i][VisibleCheckpoint] = -1;
		for(new i; i < MAX_CHECKPOINTS; i++){
			checkpoints[i][chp_created] = false;
		}
	}
	new slot;
	for(new i = 0; i < MAX_CHECKPOINTS; i++){
		if(!checkpoints[i][chp_created]){
			slot = i;
			break;
		}
	}
	checkpoints[slot][chp_created] = true;
	checkpoints[slot][chp_id] = __chpid;
	checkpoints[slot][chp_owner] = playerid;
	checkpoints[slot][chp_posX] = posX;
	checkpoints[slot][chp_posY] = posY;
	checkpoints[slot][chp_posZ] = posZ;
	checkpoints[slot][chp_size] = size;
	checkpoints[slot][chp_viewDistance] = viewDistance;
	checkpoints[slot][chp_active] = true;
	checkpoints[slot][chp_interior_id] = CHPinterior;
	checkpoints[slot][chp_world_id] = CHPworld;
	totalCheckpoints++;
	return slot;
}
stock SetCheckpointSize(chpid, Float:size){
	if(checkpoints[chpid][chp_created]){
		checkpoints[chpid][chp_size] = size;
		return 1;
	}
	return 0;
}
stock SetCheckpointPos(chpid, Float:posX, Float:posY, Float:posZ){
	if(checkpoints[chpid][chp_created]){
		checkpoints[chpid][chp_posX] = posX;
		checkpoints[chpid][chp_posY] = posY;
		checkpoints[chpid][chp_posZ] = posZ;
		return 1;
	}
	return 0;
}
stock SetCheckpointInterior(chpid, CHPinterior){
	if(checkpoints[chpid][chp_created]){
		checkpoints[chpid][chp_interior_id] = CHPinterior;
		return 1;
	}
	return 0;
}
stock SetCheckpointVirtualWorld(chpid, CHPworld){
	if(checkpoints[chpid][chp_created]){
		checkpoints[chpid][chp_world_id] = CHPworld;
		return 1;
	}
	return 0;
}
stock ToggleCheckpointActive(chpid, bool:active){
	if(checkpoints[chpid][chp_created]){
		checkpoints[chpid][chp_active] = active;
		return 1;
	}
	return 0;
}
stock ChangeCheckpointOwner(chpid, playerid){
	if(checkpoints[chpid][chp_created]){
		checkpoints[chpid][chp_owner] = playerid;
		return 1;
	}
	return 0;
}
stock RemoveCheckpoint(chpid){
	if(checkpoints[chpid][chp_created]){
		checkpoints[chpid][chp_created] = false;
		checkpoints[chpid][chp_id] = -1;
		checkpoints[chpid][chp_owner] = -1;
		checkpoints[chpid][chp_posX] = -1;
		checkpoints[chpid][chp_posY] = -1;
		checkpoints[chpid][chp_posZ] = -1;
		checkpoints[chpid][chp_size] = -1;
		checkpoints[chpid][chp_viewDistance] = -1;
		checkpoints[chpid][chp_active] = false;
		checkpoints[chpid][chp_interior_id] = -1;
		checkpoints[chpid][chp_world_id] = -1;
		totalCheckpoints--;
		return 1;
	}
	return 0;
}
stock VerifyCheckpoint(playerid, EnterExit){
	if(PlayerInfo[playerid][VisibleCheckpoint] >= 0){
		if ( EnterExit == 1 ){
			OnCheckpointEnter(playerid, checkpoints[PlayerInfo[playerid][VisibleCheckpoint]][chp_id]);
		}
		else{
			OnCheckpointExit(playerid, checkpoints[PlayerInfo[playerid][VisibleCheckpoint]][chp_id]);
		}
		return 1;
	}
	return 0;
}
public StreamCheckpoint(){
	new Float:posX, Float:posY, Float:posZ;
	new interior;
	new virtualWorld;
	for(new i; i < MAX_PLAYERS; i++){
		if(IsPlayerConnected(i)){
			if(PlayerInfo[i][VisibleCheckpoint] > -1){
				if(!PlayerClose(i,checkpoints[PlayerInfo[i][VisibleCheckpoint]][chp_posX],checkpoints[PlayerInfo[i][VisibleCheckpoint]][chp_posY],checkpoints[PlayerInfo[i][VisibleCheckpoint]][chp_posZ],checkpoints[PlayerInfo[i][VisibleCheckpoint]][chp_viewDistance]) && !checkpoints[chpid][chp_active]){
					DisablePlayerCheckpoint(i);
					PlayerInfo[i][VisibleCheckpoint] = -1;
				}
			}
			else if(checkpoints[chpid][chp_active]){
				interior = GetPlayerInterior(i);
				virtualWorld = GetPlayerVirtualWorld(i);
				for(new j = 0; j < MAX_CHECKPOINTS; j++){
					if(!checkpoints[j][chp_created]) continue;
					if((checkpoints[j][chp_owner] != i) && (checkpoints[j][chp_owner] != -1)) continue;
					if(checkpoints[j][chp_interior_id] != interior) continue;
					if(checkpoints[j][chp_world_id] != virtualWorld) continue;
					if(PlayerClose(i,checkpoints[j][chp_posX],checkpoints[j][chp_posY],checkpoints[j][chp_posZ],checkpoints[j][chp_viewDistance])){
						SetPlayerCheckpoint(i, checkpoints[j][chp_posX], checkpoints[j][chp_posY], checkpoints[j][chp_posZ], checkpoints[j][chp_size]);
						PlayerInfo[i][VisibleCheckpoint] = j;
						break;
					}
				}
			}
		}
	}
	return 1;
}
