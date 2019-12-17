#include <a_samp>

/*Natives:

Starting of the whole streamer,MUST have under OnGameModeInit/OnFilterScriptInit :

native STO_Start();

Ending,MUST have under OnGameModeExit/OnFilterScriptExit:

native STO_End();

Checkpoints:

native CreateCheckpointToStream(Float:x,Float:y,Float:z,Float:size,Float:viewdistance);
native DestroyStreamedCheckpoint(checkpointid);
native IsValidStreamedCheckpoint(checkpointid);
native IsPlayerInCheckpoint(playerid,checkpointid);
native SetStreamedCheckpointPos(checkpointid, Float:x,Float:y,Float:z);
native GetClosestCheckpoint(playerid);

Race Checkpoints:

native CreateRaceCheckpointToStream(type,Float:x,Float:y,Float:z,Float:NextX,Float:NextY,Float:NextZ,Float:size,Float:viewdistance);
native DestroyStreamedRaceCheckpoint(checkpointid);
native IsValidStreamedRaceCheckpoint(checkpointid);
native SetStreamedRaceCheckpointPos(checkpointid, Float:x,Float:y,Float:z);
native GetClosestRaceCheckpoint(playerid);

Map Icons:

native CreateMapIconToStream(iconid,Float:x,Float:y,Float:z,markertype,color,Float:distance);
native RemoveStreamedMapIcon(iconid);
native IsPlayerInStreamedMapIcon(playerid,iconid);
native SetStreamedMapIconColor(iconid,color);
native SetStreamedMapIconPos(iconid,Float:x,Float:y,Float:z);
native SetStreamedMapIconMarker(iconid,markertype,color);

Objects:

native CreateObjectToStream(modelid,Float:x,Float:y,Float:z,Float:xrot,Float:yrot:Float:zrot,Float:viewdistance);
native DestroyStreamedObject(objectid);
native GetStreamedObjectPos(objectid, &Float:x, &Float:y, &Float:z);
native GetStreamedObjectRot(objectid, &Float:rotx, &Float:roty, &Float:rotz);
native SetStreamedObjectPos(objectid, Float:x, Float:y, Float:z);
native SetStreamedObjectRot(objectid, Float:rotx,Float:roty,Float:rotz);
native AttachStreamedObjectToPlayer(playerid,objectid,Float:offsetX,Float:offsetY,Float:offsetZ,Float:rotx,Float:roty,Float:rotz);
native MoveStreamedObject(objectid,Float:x,Float:y,Float:z,Float:speed);
native CreateUnMoveableObject(modelid,Float:x,Float:y,Float:z,Float:xrot,Float:yrot,Float:zrot,Float:viewdistance);
native DestroyAllStreamedObjects();

Auto object:
native CreateAutoObjectToStream(modelid,Float:closedx,Float:closedy,Float:closedz,Float:closedrotX,Float:closedrotY,Float:closedrotZ,Float:openedx,Float:openedy,Float:openedz,Float:distance,Float:speed);

*/
#define MAX_STREAMED_CHECKPOINTS 550
#define MAX_STREAMED_RACE_CHECKPOINTS 500
#define MAX_STREAMED_MAP_ICONS 600
#define MAX_STREAMED_OBJECTS 3100
#define MAX_AUTO_OBJECTS 500
#define MAX_M_SLOTS 100
enum cInfo2{
	Float:C_X,
	Float:C_Y,
	Float:C_Z,
	Float:C_SIZE,
	Float:C_VIEWDISTANCE,
	bool:Exist
}
enum rInfo2{
	type,
	Float:RC_X,
	Float:RC_Y,
	Float:RC_Z,
	Float:RC_X2,
	Float:RC_Y2,
	Float:RC_Z2,
	Float:RC_SIZE,
	Float:RC_VIEWD,
	bool:rExist
}
enum mInfo2{
	Float:M_X,
	Float:M_Y,
	Float:M_Z,
	mcolor,
	model,
	Float:view,
	bool:mExist,
	mi
}
enum oInfo2{
	bool:IsMoving,
	objectID,
	modelID,
	Float:O_X,
	Float:O_Y,
	Float:O_Z,
	Float:O_XR,
	Float:O_YR,
	Float:O_ZR,
	Float:O_VD,
	O_A,
	Float:O_Ox,
	Float:O_Oy,
	Float:O_Oz,
	Float:O_Mx,
	Float:O_My,
	Float:O_Mz,
	Float:O_MSp,
	O_T,
	bool:oExist,
	umtimer,
	bool:IsUnM
}
enum pInfo2{
	bool:O_S[MAX_STREAMED_OBJECTS],
	P_O[MAX_STREAMED_OBJECTS],
	P_S
}
enum aInfo2{
	bool:aExist,
	model,
	Float:closedx,
	Float:closedy,
	Float:closedz,
	Float:closedrotx,
	Float:closedroty,
	Float:closedrotz,
	Float:openedx,
	Float:openedy,
	Float:openedz,
	Float:distance3,
	Float:ospeed,
	gID
}
new cInfo[MAX_STREAMED_CHECKPOINTS][cInfo2]; //Variable of the checkpoint info enumeration,same with rInfo.
new cp = -1; // Checkpoint count,I want the checkpoint ID's to start from 0,that's why we have placed here '-1',same with rcp.
new cpshowen[MAX_PLAYERS]; //Checkpoint that shown for a certain player,same with rcpshowen.
new rInfo[MAX_STREAMED_RACE_CHECKPOINTS][rInfo2];
new rcp = -1;
new rcpshowen[MAX_PLAYERS];
new mInfo[MAX_STREAMED_MAP_ICONS][mInfo2];
new oInfo[MAX_STREAMED_OBJECTS][oInfo2];
new O_Exist;
new pInfo[MAX_PLAYERS][pInfo2];
new aInfo[MAX_AUTO_OBJECTS][aInfo2];
new gCount = -1;
new gTimer = -1;
new bool:isAr[MAX_AUTO_OBJECTS];
forward STO_AddAutoMO(modelid,Float:closedX,Float:closedY,Float:closedZ,Float:closedrotX,Float:closedrotY,Float:closedrotZ,Float:openedX,Float:openedY,Float:openedZ,Float:distance,Float:speed);
forward STO_SetCheckpoint(Float:x,Float:y,Float:z,Float:size,Float:viewdistance);
forward STO_SetRaceCheckpoint(type2,Float:x,Float:y,Float:z,Float:nextx,Float:nexty,Float:nextz,Float:size,Float:viewdistance);
forward STO_DestroyCheckpoint(checkpointid);
forward STO_DestroyRaceCheckpoint(checkpointid);
forward STO_Run();
forward CheckPos();
forward CheckPos2();
forward STO_IsValidStreamedCheckpoint(checkpointid);
forward STO_IsValidStreamedRCheckpoint(checkpointid);
forward STO_SetStreamedCheckpointPos(checkpointid,Float:x,Float:y,Float:z);
forward STO_SetStreamedRCheckpointPos(checkpointid,Float:x,Float:y,Float:z);
forward STO_IsPlayerInStreamedCpoint(playerid,checkpointid);
forward CheckpointToPlayerPoint(playerid,checkpointid);
forward RaceCheckpointToPlayerPoint(playerid,checkpointid);
forward STO_GetClosestCheckpoint(playerid); // GetClosestCheckpoint
forward STO_GetClosestRaceCheckpoint(playerid);
forward STO_SetStreamedMapIconMarker(iconid,markertype,color);
forward OnPlayerEnterStreamCheckpoint(playerid,checkpointid);
forward OnPlayerLeaveStreamCheckpoint(playerid,checkpointid);
forward OnPlayerEnterStreamRCheckpoint(playerid,checkpointid);
forward OnPlayerLeaveStreamRCheckpoint(playerid,checkpointid);
forward STO_AddMapIcon(iconid,Float:x,Float:y,Float:z,markertype,color,Float:distance);
forward STO_RemMapIcon(iconid);
forward STO_IsInMapIcon(playerid,iconid);
forward STO_SetColOfMapIcon(iconid,color);
forward STO_SetPosOfMi(iconid,Float:x,Float:y,Float:z);
forward CheckPos3();
forward STO_CreateObjectToStream(modelid,Float:x,Float:y,Float:z,Float:xrot,Float:yrot,Float:zrot,Float:viewdis);
forward STO_DestroyStreamedObject(objectid);
forward STO_GetObjPos(objectid, &Float:x, &Float:y, &Float:z);
forward STO_GetObjRot(objectid, &Float:rx, &Float:ry, &Float:rz);
forward STO_SetObjPos(objectid, Float:x,Float:y,Float:z);
forward STO_SetObjRot(objectid, Float:rotx,Float:roty,Float:rotz);
forward O_AttachStreamedObjectToPlayer(playerid,objectid,Float:offsetX,Float:offsetY,Float:offsetZ,Float:rotx,Float:roty,Float:rotz);
forward STO_ObjectMove(objectid,Float:newx,Float:newy,Float:newz,Float:speed);
forward Mtimer(objectid,xplus,yplus,zplus,bool:isx,bool:isy,bool:isz);
forward CheckPos4();
forward CheckPos5();
forward CreateUnMoveableObject(modelid,Float:x,Float:y,Float:z,Float:xrot,Float:yrot,Float:zrot,Float:viewdistance);
forward UNMOVE(objectid,Float:x,Float:y,Float:z,Float:xrot,Float:yrot,Float:zrot);
public STO_AddAutoMO(modelid,Float:closedX,Float:closedY,Float:closedZ,Float:closedrotX,Float:closedrotY,Float:closedrotZ,Float:openedX,Float:openedY,Float:openedZ,Float:distance,Float:speed){
	gCount++;
	new g = gCount;
	aInfo[g][aExist] = true;
	aInfo[g][model] = modelid;
	aInfo[g][closedx] = closedX;
	aInfo[g][closedy] = closedY;
	aInfo[g][closedz] = closedZ;
	aInfo[g][closedrotx] = closedrotX;
	aInfo[g][closedroty] = closedrotY;
	aInfo[g][closedrotz] = closedrotZ;
	aInfo[g][openedx] = openedX;
	aInfo[g][openedy] = openedY;
	aInfo[g][openedz] = openedZ;
	aInfo[g][distance3] = distance;
	aInfo[g][ospeed] = speed;
	aInfo[g][gID] = CreateObjectToStream(modelid,closedX,closedY,closedZ,closedrotX,closedrotY,closedrotZ,500.0);
	if(gTimer == -1) gTimer = SetTimer("CheckPos5",300,true);
	return 1;
}
stock CreateAutoObjectToStream(modelid,Float:closedX,Float:closedY,Float:closedZ,Float:closedrotX,Float:closedrotY,Float:closedrotZ,Float:openedX,Float:openedY,Float:openedZ,Float:distance,Float:speed){
	return CallLocalFunction("STO_AddAutoMO","dfffffffffff",modelid,closedX,closedY,closedZ,closedrotX,closedrotY,closedrotZ,openedX,openedY,openedZ,distance,speed);
}
public STO_SetCheckpoint(Float:x,Float:y,Float:z,Float:size,Float:viewdistance){
	cp++;
	cInfo[cp][C_X] = x;
	cInfo[cp][C_Y] = y;
	cInfo[cp][C_Z] = z;
	cInfo[cp][C_SIZE] = size;
	cInfo[cp][C_VIEWDISTANCE] = viewdistance;
	cInfo[cp][Exist] = true;
	return cp;
}
public STO_SetRaceCheckpoint(type2,Float:x,Float:y,Float:z,Float:nextx,Float:nexty,Float:nextz,Float:size,Float:viewdistance){
	rcp++;
	rInfo[rcp][type] = type2;
	rInfo[rcp][RC_X] = x;
	rInfo[rcp][RC_Y] = y;
	rInfo[rcp][RC_Z] = z;
	rInfo[rcp][RC_X2] = nextx;
	rInfo[rcp][RC_Y2] = nexty;
	rInfo[rcp][RC_Z2] = nextz;
	rInfo[rcp][RC_SIZE] = size;
	rInfo[rcp][RC_VIEWD] = viewdistance;
	rInfo[rcp][rExist] = true;
	return rcp;
}
public STO_DestroyCheckpoint(checkpointid){
	cp--;
	cInfo[checkpointid][C_X] = 0.0;
	cInfo[checkpointid][C_Y] = 0.0;
	cInfo[checkpointid][C_Z] = 0.0;
	cInfo[checkpointid][C_SIZE] = 0;
	cInfo[checkpointid][C_VIEWDISTANCE] = 0;
	cInfo[checkpointid][Exist] = false;
	return checkpointid;
}
public STO_DestroyRaceCheckpoint(checkpointid){
	rcp--;
	rInfo[checkpointid][type] = -1;
	rInfo[checkpointid][RC_X] = 0.0;
	rInfo[checkpointid][RC_Y] = 0.0;
	rInfo[checkpointid][RC_Z] = 0.0;
	rInfo[checkpointid][RC_X2] = 0.0;
	rInfo[checkpointid][RC_Y2] = 0.0;
	rInfo[checkpointid][RC_Z2] = 0.0;
	rInfo[checkpointid][RC_SIZE] = 0;
	rInfo[checkpointid][RC_VIEWD] = 0;
	rInfo[checkpointid][rExist] = false;
	return checkpointid;
}
public STO_Run(){
	CheckPos();
	CheckPos2();
	CheckPos3();
	CheckPos4();
	return 1;
}
stock STO_Start(){
	SetTimer("STO_Run",300,true);
	return 1;
}
stock STO_End(){
	for(new i = 0; i < MAX_PLAYERS; i++){
	    for(new j = 0; j <= O_Exist; j++){
	        if(pInfo[i][O_S][j] == true){
				DestroyPlayerObject(i,pInfo[i][P_O][j]);
			}
		}
	}
	return 1;
}
public CheckPos(){
	for(new i = 0; i < MAX_PLAYERS; i++){
	    if(IsPlayerConnected(i)){
	        for(new j = 0; j < MAX_STREAMED_CHECKPOINTS; j++){
	            if(IsPlayerInRangeOfPoint(i,cInfo[j][C_VIEWDISTANCE],cInfo[j][C_X],cInfo[j][C_Y],cInfo[j][C_Z])){
	                if(cInfo[j][Exist] == true && cpshowen[i] != j){
                		SetPlayerCheckpoint(i,cInfo[j][C_X],cInfo[j][C_Y],cInfo[j][C_Z],cInfo[j][C_SIZE]);
                		cpshowen[i] = j;
					}
				}
				else{
					if(cpshowen[i] == j){
						DisablePlayerCheckpoint(i);
						cpshowen[i] = -1;
					}
				}
			}
		}
	}
	return 1;
}
public CheckPos2(){
	for(new i = 0; i < MAX_PLAYERS; i++){
	    if(IsPlayerConnected(i)){
	        for(new j = 0; j < MAX_STREAMED_RACE_CHECKPOINTS; j++){
				if(IsPlayerInRangeOfPoint(i,rInfo[j][RC_VIEWD],rInfo[j][RC_X],rInfo[j][RC_Y],rInfo[j][RC_Z])){
				    if(rInfo[j][rExist] == true && rcpshowen[i] != j){
				        SetPlayerRaceCheckpoint(i,rInfo[j][type],rInfo[j][RC_X],rInfo[j][RC_Y],rInfo[j][RC_Z],rInfo[j][RC_X2],rInfo[j][RC_Y2],rInfo[j][RC_Z2],rInfo[j][RC_SIZE]);
				        rcpshowen[i] = j;
					}
				}
				else{
				    if(rcpshowen[i] == j){
				        DisablePlayerRaceCheckpoint(i);
						rcpshowen[i] = -1;
					}
				}
			}
		}
	}
	return 1;
}
public STO_IsValidStreamedCheckpoint(checkpointid){
	new bool:result;
	if(cInfo[checkpointid][C_X] != 0.0 && cInfo[checkpointid][C_Y] != 0.0 && cInfo[checkpointid][C_Z] != 0.0 && cInfo[checkpointid][C_SIZE] > 0 && cInfo[checkpointid][C_VIEWDISTANCE] > 0){
	    result = true;
	}
	else if(cInfo[checkpointid][Exist] == true){
	    result = true;
	}
	else{
	    result = false;
	}
	return result;
}
public STO_IsValidStreamedRCheckpoint(checkpointid){
	new bool:result;
	if(rInfo[checkpointid][RC_X] != 0.0 && rInfo[checkpointid][RC_Y] != 0.0 && rInfo[checkpointid][RC_Z] != 0.0 && rInfo[checkpointid][RC_SIZE] > 0 && rInfo[checkpointid][RC_VIEWD] > 0){
		result = true;
	}
	else if(rInfo[checkpointid][rExist] == true){
	    result = true;
	}
	else if(rInfo[checkpointid][type] >= 0 && rInfo[checkpointid][type] <= 4){
	    result = true;
	}
	else{
	    result = false;
	}
	return result;
}
public STO_SetStreamedCheckpointPos(checkpointid,Float:x,Float:y,Float:z){
	cInfo[checkpointid][C_X] = x;
	cInfo[checkpointid][C_Y] = y;
	cInfo[checkpointid][C_Z] = z;
}
public STO_SetStreamedRCheckpointPos(checkpointid,Float:x,Float:y,Float:z){
	rInfo[checkpointid][RC_X] = x;
	rInfo[checkpointid][RC_Y] = y;
	rInfo[checkpointid][RC_Z] = z;
}
public STO_IsPlayerInStreamedCpoint(playerid,checkpointid){
	new bool:result[MAX_PLAYERS];
 	if(IsPlayerInRangeOfPoint(playerid,cInfo[checkpointid][C_SIZE],cInfo[checkpointid][C_X],cInfo[checkpointid][C_Y],cInfo[checkpointid][C_Z]) && STO_IsValidStreamedCheckpoint(checkpointid)){
   		result[playerid] = true;
	}
	else{
 		result[playerid] = false;
	}
	return result[playerid];
}
public CheckpointToPlayerPoint(playerid,checkpointid){
	new Float:distance,Float:px,Float:py,Float:pz;
	GetPlayerPos(playerid,px,py,pz);
	distance = floatsqroot(floatpower(floatabs(floatsub(cInfo[checkpointid][C_X],px)),2) + floatpower(floatabs(floatsub(cInfo[checkpointid][C_Y],py)),2) + floatpower(floatabs(floatsub(cInfo[checkpointid][C_Z],pz)),2));
	return floatround(distance);
}
public RaceCheckpointToPlayerPoint(playerid,checkpointid){
	new Float:distance,Float:px,Float:py,Float:pz;
	GetPlayerPos(playerid,px,py,pz);
	distance = floatsqroot(floatpower(floatabs(floatsub(rInfo[checkpointid][RC_X],px)),2) + floatpower(floatabs(floatsub(rInfo[checkpointid][RC_Y],py)),2) + floatpower(floatabs(floatsub(rInfo[checkpointid][RC_Z],pz)),2));
	return floatround(distance);
}
public STO_GetClosestCheckpoint(playerid){
	new Float:distance = 99999.000+1,Float:distance2,closest = -1;
	for(new i = 0; i < cp; i++){
	    distance2 = CheckpointToPlayerPoint(playerid, i);
	    if(distance2 < distance){
	        distance = distance2;
	        closest = i;
		}
	}
	return closest;
}
public STO_GetClosestRaceCheckpoint(playerid){
	new Float:distance = 99999.000+1,Float:distance2,closest = -1;
	for(new i = 0; i < rcp; i++){
	    distance2 = RaceCheckpointToPlayerPoint(playerid, i);
	    if(distance2 < distance){
	        distance = distance2;
	        closest = i;
		}
	}
	return closest;
}
public OnPlayerEnterCheckpoint(playerid){
	if(cpshowen[playerid] != -1) return OnPlayerEnterStreamCheckpoint(playerid,cpshowen[playerid]);
	return 1;
}
public OnPlayerLeaveCheckpoint(playerid){
	if(cpshowen[playerid] != -1) return OnPlayerLeaveStreamCheckpoint(playerid,cpshowen[playerid]);
	return 1;
}
public OnPlayerEnterRaceCheckpoint(playerid){
	if(rcpshowen[playerid] != -1) return OnPlayerEnterStreamRCheckpoint(playerid,rcpshowen[playerid]);
	return 1;
}
public OnPlayerLeaveRaceCheckpoint(playerid){
	if(rcpshowen[playerid] != -1) return OnPlayerLeaveStreamRCheckpoint(playerid,rcpshowen[playerid]);
	return 1;
}
public STO_SetStreamedMapIconMarker(iconid,markertype,color){
	mInfo[iconid][model] = markertype;
   	mInfo[iconid][mcolor] = color;
    return true;
}
stock CreateCheckpointToStream(Float:x,Float:y,Float:z,Float:size,Float:viewdistance){
	return CallLocalFunction("STO_SetCheckpoint","fffff",x,y,z,size,viewdistance);
}
stock DestroyStreamedCheckpoint(checkpointid){
	return CallLocalFunction("STO_DestroyCheckpoint","d",checkpointid);
}
stock CreateRaceCheckpointToStream(ctype,Float:x,Float:y,Float:z,Float:nextx,Float:nexty,Float:nextz,Float:size,Float:viewdistance){
	return CallLocalFunction("STO_SetRaceCheckpoint","dffffffff",ctype,x,y,z,nextx,nexty,nextz,size,viewdistance);
}
stock DestroyStreamedRaceCheckpoint(checkpointid){
	return CallLocalFunction("STO_DestroyRaceCheckpoint","d",checkpointid);
}
stock IsValidStreamedCheckpoint(checkpointid){
	return CallLocalFunction("STO_IsValidStreamedCheckpoint","d",checkpointid);
}
stock IsValidStreamedRaceCheckpoint(checkpointid){
	return CallLocalFunction("STO_IsValidStreamedRCheckpoint","d",checkpointid);
}
stock SetStreamedCheckpointPos(checkpointid,Float:x,Float:y,Float:z){
	return CallLocalFunction("STO_SetStreamedCheckpointPos","dfff",checkpointid,x,y,z);
}
stock SetStreamedMapIconMarker(iconid,markertype,color){
	return CallLocalFunction("STO_SetStreamedMapIconMarker","ddx",iconid,markertype,color);
}
stock SetStreamedRaceCheckpointPos(checkpointid,Float:x,Float:y,Float:z){
	return CallLocalFunction("STO_SetStreamedRCheckpointPos","dfff",checkpointid,x,y,z);
}
stock IsPlayerInStreamedCheckpoint(playerid,checkpointid){
	return CallLocalFunction("STO_IsPlayerInStreamedCpoint","id",playerid,checkpointid);
}
stock GetClosestCheckpoint(playerid){
	return CallLocalFunction("STO_GetClosestCheckpoint","i",playerid);
}
stock GetClosestRaceCheckpoint(playerid){
	return CallLocalFunction("STO_GetClosestRaceCheckpoint","i",playerid);
}
public STO_AddMapIcon(iconid,Float:x,Float:y,Float:z,markertype,color,Float:distance){
	mInfo[iconid][mi] = iconid;
	mInfo[iconid][M_X] = x;
	mInfo[iconid][M_Y] = y;
	mInfo[iconid][M_Z] = z;
	mInfo[iconid][model] = markertype;
	mInfo[iconid][mcolor] = color;
	mInfo[iconid][view] = distance;
	mInfo[iconid][mExist] = true;
}
public STO_RemMapIcon(iconid){
	mInfo[iconid][mExist] = false;
	for(new i = 0; i < MAX_PLAYERS; i++){
		RemovePlayerMapIcon(i,mInfo[iconid][mi]);
	}
}
Float:GetDistanceEx(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2){
	return Float:floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2) + floatpower(floatabs(floatsub(y2,y1)),2) + floatpower(floatabs(floatsub(z2,z1)),2));
}
public STO_IsInMapIcon(playerid,iconid){
	new Float:px,Float:py,Float:pz,res;
	GetPlayerPos(playerid,px,py,pz);
	if(px == mInfo[iconid][M_X] && py == mInfo[iconid][M_Y] && pz == mInfo[iconid][M_Z]){
	    res = 1;
	}
	else{
	    res = 0;
	}
	return res;
}
public STO_SetColOfMapIcon(iconid,color){
	return mInfo[iconid][mcolor] = color;
}
public STO_SetPosOfMi(iconid,Float:x,Float:y,Float:z){
	mInfo[iconid][M_X] = x;
	mInfo[iconid][M_Y] = y;
	mInfo[iconid][M_Z] = z;
	return 1;
}
stock CreateMapIconToStream(iconid,Float:x,Float:y,Float:z,markertype,color,Float:distance){
	return CallLocalFunction("STO_AddMapIcon","ifffddf",iconid,x,y,z,markertype,color,distance);
}
stock RemoveStreamedMapIcon(iconid){
	return CallLocalFunction("STO_RemMapIcon","d",iconid);
}
stock IsPlayerInStreamedMapIcon(playerid,iconid){
	return CallLocalFunction("STO_IsInMapIcon","id",playerid,iconid);
}
stock SetStreamedMapIconColor(iconid,color){
	return CallLocalFunction("STO_SetColOfMapIcon","dx",iconid,color);
}
stock SetStreamedMapIconPos(iconid,Float:x,Float:y,Float:z){
	return CallLocalFunction("STO_SetPosOfMi","dfff",iconid,x,y,z);
}
public CheckPos3(){
	for(new i = 0; i < MAX_PLAYERS; i++){
	    if(IsPlayerConnected(i)){
	        for(new j = 0; j < MAX_STREAMED_MAP_ICONS; j++){
	            if(IsPlayerInRangeOfPoint(i,mInfo[j][view],mInfo[j][M_X],mInfo[j][M_Y],mInfo[j][M_Z]) && mInfo[j][mExist] == true){
	                SetPlayerMapIcon(i,mInfo[j][mi],mInfo[j][M_X],mInfo[j][M_Y],mInfo[j][M_Z],mInfo[j][model],mInfo[j][mcolor]);
				}
				else {
					RemovePlayerMapIcon(i,mInfo[j][mi]);
				}
			}
		}
	}
	return 1;
}
stock CreateObjectToStream(modelid,Float:x,Float:y,Float:z,Float:xrot,Float:yrot,Float:zrot,Float:viewdis){
	return CallLocalFunction("STO_CreateObjectToStream","dfffffff",modelid,x,y,z,xrot,yrot,zrot,viewdis);
}
stock DestroyStreamedObject(objectid){
	return CallLocalFunction("STO_DestroyStreamedObject","d",objectid);
}
stock GetStreamedObjectPos(objectid, &Float:x, &Float:y, &Float:z){
	return CallLocalFunction("STO_GetObjPos","dfff",objectid,x,y,z);
}
stock GetStreamedObjectRot(objectid, &Float:rotx, &Float:roty, &Float:rotz){
	return CallLocalFunction("STO_GetObjRot","dfff",objectid,rotx,roty,rotz);
}
stock SetStreamedObjectPos(objectid, Float:x,Float:y,Float:z){
	return CallLocalFunction("STO_SetObjPos","dfff",objectid,x,y,z);
}
stock SetStreamedObjectRot(objectid, Float:rotx,Float:roty,Float:rotz){
	return CallLocalFunction("STO_SetObjRot","dfff",objectid,rotx,roty,rotz);
}
stock AttachStreamedObjectToPlayer(playerid,objectid,Float:offsetX,Float:offsetY,Float:offsetZ,Float:rotx,Float:roty,Float:rotz){
	return CallLocalFunction("O_AttachStreamedObjectToPlayer","idffffff",playerid,objectid,offsetX,offsetY,offsetZ,rotx,roty,rotz);
}
stock MoveStreamedObject(objectid,Float:x,Float:y,Float:z,Float:speed){
	return CallLocalFunction("STO_ObjectMove","dffff",objectid,x,y,z,speed);
}
public STO_CreateObjectToStream(modelid,Float:x,Float:y,Float:z,Float:xrot,Float:yrot,Float:zrot,Float:viewdis){
	new j;
	for( j = 0; j < MAX_STREAMED_OBJECTS; j++){
		if(oInfo[j][modelID] == 0){
		    oInfo[j][modelID] = modelid;
		    oInfo[j][O_X] = x;
		    oInfo[j][O_Y] = y;
		    oInfo[j][O_Z] = z;
		    oInfo[j][O_XR] = xrot;
		    oInfo[j][O_YR] = yrot;
		    oInfo[j][O_ZR] = zrot;
		    oInfo[j][O_VD] = viewdis;
		    oInfo[j][O_A] = -1;
		    oInfo[j][objectID] = j;
		    oInfo[j][IsMoving] = false;
		    oInfo[j][oExist] = true;
		    if(O_Exist < j){
				O_Exist = j;
			}
			else break;
		}
	}
	return j;
}
public STO_DestroyStreamedObject(objectid){
	oInfo[objectid][modelID] = -1;
	if(oInfo[objectid][IsMoving] == true){
	    KillTimer(oInfo[objectid][O_T]);
		oInfo[objectid][IsMoving] = false;
	}
	for(new i = 0; i < MAX_PLAYERS; i++){
	    if(IsPlayerConnected(i) && pInfo[i][O_S][objectid] == true){
			pInfo[i][O_S][objectid] = false;
			pInfo[i][P_S] -= 1;
			DestroyPlayerObject(i,pInfo[i][P_O][objectid]);
			oInfo[pInfo[i][P_O][objectid]][oExist] = false;
		}
	}
}
public STO_GetObjPos(objectid, &Float:x, &Float:y, &Float:z){
	x = oInfo[objectid][O_X];
	y = oInfo[objectid][O_Y];
	z = oInfo[objectid][O_Z];
	return 1;
}
public STO_GetObjRot(objectid, &Float:rx, &Float:ry, &Float:rz){
	rx = oInfo[objectid][O_XR];
	ry = oInfo[objectid][O_YR];
	rz = oInfo[objectid][O_ZR];
	return 1;
}
public STO_SetObjPos(objectid, Float:x,Float:y,Float:z){
	oInfo[objectid][O_X] = x;
	oInfo[objectid][O_Y] = y;
	oInfo[objectid][O_Z] = z;
	for(new i = 0; i < MAX_PLAYERS; i++){
	    if(IsPlayerConnected(i) && pInfo[i][O_S][objectid] == true){
	        SetPlayerObjectPos(i,pInfo[i][P_O][objectid],x,y,z);
		}
	}
}
public STO_SetObjRot(objectid, Float:rotx,Float:roty,Float:rotz){
	oInfo[objectid][O_XR] = rotx;
	oInfo[objectid][O_YR] = roty;
	oInfo[objectid][O_ZR] = rotz;
	for(new i = 0; i < MAX_PLAYERS; i++){
	    if(IsPlayerConnected(i) && pInfo[i][O_S][objectid] == true){
	        SetPlayerObjectRot(i,pInfo[i][P_O][objectid],rotx,roty,rotz);
		}
	}
}
public O_AttachStreamedObjectToPlayer(playerid,objectid,Float:offsetX,Float:offsetY,Float:offsetZ,Float:rotx,Float:roty,Float:rotz){
	oInfo[objectid][O_A] = playerid;
	oInfo[objectid][O_Ox] = offsetX;
	oInfo[objectid][O_Oy] = offsetY;
	oInfo[objectid][O_Oz] = offsetZ;
	oInfo[objectid][O_XR] = rotx;
	oInfo[objectid][O_YR] = roty;
	oInfo[objectid][O_ZR] = rotz;
	for(new i = 0; i < MAX_PLAYERS; i++){
	    if(IsPlayerConnected(i) && pInfo[i][O_S][objectid] == true){
	        AttachPlayerObjectToPlayer(i,pInfo[i][P_O][objectid],playerid,offsetX,offsetY,offsetZ,rotx,roty,rotz);
		}
	}
}
public STO_ObjectMove(objectid,Float:newx,Float:newy,Float:newz,Float:speed){
	oInfo[objectid][O_Mx] = newx;
	oInfo[objectid][O_My] = newy;
	oInfo[objectid][O_Mz] = newz;
	oInfo[objectid][O_MSp] = speed;
	oInfo[objectid][IsMoving] = true;
	for(new i = 0; i < MAX_PLAYERS; i++){
	    if(IsPlayerConnected(i) && pInfo[i][O_S][objectid] == true){
	        MovePlayerObject(i,pInfo[i][P_O][objectid],newx,newy,newz,speed);
		}
	}
	new Float:t;
	t = (GetDistanceEx(oInfo[objectid][O_X],oInfo[objectid][O_Y],oInfo[objectid][O_Z],newx,newy,newz)/speed)/1.21;
	new bool:isx = (newx >= oInfo[objectid][O_X]) ? true : false;
	new bool:isy = (newy >= oInfo[objectid][O_Y]) ? true : false;
	new bool:isz = (newz >= oInfo[objectid][O_Z]) ? true : false;
	new xplus = (t == 0.0) ? 0 : (isx) ? floatround(((newx - oInfo[objectid][O_X])/t),floatround_ceil) : floatround(((newx - oInfo[objectid][O_X])/t),floatround_floor);
	new yplus = (t == 0.0) ? 0 : (isy) ? floatround(((newy - oInfo[objectid][O_Y])/t),floatround_ceil) : floatround(((newy - oInfo[objectid][O_Y])/t),floatround_floor);
	new zplus = (t == 0.0) ? 0 : (isz) ? floatround(((newz - oInfo[objectid][O_Z])/t),floatround_ceil) : floatround(((newz - oInfo[objectid][O_Z])/t),floatround_floor);
	KillTimer(oInfo[objectid][O_T]);
	oInfo[objectid][O_T] = SetTimerEx("Mtimer",1*1000,true,"diiibbb",objectid,xplus,yplus,zplus,isx,isy,isz);
}
public Mtimer(objectid,xplus,yplus,zplus,bool:isx,bool:isy,bool:isz){
	new bool: ist = false;
	if(oInfo[objectid][IsUnM] == true) return 0;
	ist = isx ? ((oInfo[objectid][O_X] >= oInfo[objectid][O_Mx]) ? true : false) : ((oInfo[objectid][O_X] <= oInfo[objectid][O_Mx]) ? true : false);
	if(ist){
	    ist = isy ? ((oInfo[objectid][O_Y] >= oInfo[objectid][O_My]) ? true : false) : ((oInfo[objectid][O_Y] <= oInfo[objectid][O_My]) ? true : false);
	    if(ist){
	        ist = isz ? ((oInfo[objectid][O_Z] >= oInfo[objectid][O_Mz]) ? true : false) : ((oInfo[objectid][O_Z] <= oInfo[objectid][O_Mz]) ? true : false);
		}
	}
	if(ist){
	    oInfo[objectid][IsMoving] = false;
	    for(new i = 0; i < MAX_PLAYERS; i++){
	        if(IsPlayerConnected(i) && pInfo[i][O_S][objectid] == true && oInfo[objectid][IsMoving] == true){
	            MovePlayerObject(i,pInfo[i][P_O][objectid],oInfo[objectid][O_Mx],oInfo[objectid][O_My],oInfo[objectid][O_Mz],oInfo[objectid][O_MSp]);
			}
		}
		oInfo[objectid][O_X] = oInfo[objectid][O_Mx];
		oInfo[objectid][O_Y] = oInfo[objectid][O_My];
		oInfo[objectid][O_Z] = oInfo[objectid][O_Mz];
		KillTimer(oInfo[objectid][O_T]);
	}
	else{
	    new bool:isf = false;
	    for(new i = 0; i < MAX_PLAYERS; i++){
	        if(IsPlayerConnected(i) && pInfo[i][O_S][objectid] == true){
	            GetPlayerObjectPos(i,pInfo[i][O_S][objectid],oInfo[objectid][O_X],oInfo[objectid][O_Y],oInfo[objectid][O_Z]);
	            isf = true;
	            break;
			}
		}
		if(!isf){
		    oInfo[objectid][O_X] = oInfo[objectid][O_X] + xplus;
		    oInfo[objectid][O_Y] = oInfo[objectid][O_Y] + yplus;
		    oInfo[objectid][O_Z] = oInfo[objectid][O_Z] + zplus;
		}
	}
	return 1;
}
PosToPos(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2, Float:rad){
	x1 -= x2;
	y1 -= y2;
	z1 -= z2;
	return ((x1 * x1) + (y1 * y1) + (z1 * z1) <= rad * rad);
}
public CheckPos4(){
	new Float:posS[3],Float:posS2[3];
	for(new i = 0; i < MAX_PLAYERS; i++){
	    if(IsPlayerConnected(i)){
		    GetPlayerPos(i,posS[0],posS[1],posS[2]);
		    for(new j = 0; j <= O_Exist; j++){
		        if(oInfo[j][modelID] > 0){
					if(oInfo[j][O_A] != -1){
					    GetPlayerPos(oInfo[j][O_A],posS2[0],posS2[1],posS2[2]);
					    oInfo[j][O_X] = posS2[0]+oInfo[j][O_Ox]; oInfo[j][O_Y] = posS2[1]+oInfo[j][O_Oy]; oInfo[j][O_Z] = posS2[2]+oInfo[j][O_Oz];
					}
					if(PosToPos(posS[0],posS[1],posS[2],oInfo[j][O_X],oInfo[j][O_Y],oInfo[j][O_Z],oInfo[j][O_VD])){
					    if(pInfo[i][O_S][j] == false && pInfo[i][P_S] <= 400){
					        pInfo[i][P_O][j] = CreatePlayerObject(i,oInfo[j][modelID],oInfo[j][O_X],oInfo[j][O_Y],oInfo[j][O_Z],oInfo[j][O_XR],oInfo[j][O_YR],oInfo[j][O_ZR]);
					        if(oInfo[j][O_A] != -1)				        {
					            AttachPlayerObjectToPlayer(i,pInfo[i][P_O][j],oInfo[j][O_A],oInfo[j][O_Ox],oInfo[j][O_Oy],oInfo[j][O_Oz],oInfo[j][O_XR],oInfo[j][O_YR],oInfo[j][O_ZR]);
							}
							else if(oInfo[j][IsMoving] == true){
								MovePlayerObject(i,pInfo[i][P_O][j],oInfo[j][O_Mx],oInfo[j][O_My],oInfo[j][O_Mz],oInfo[j][O_MSp]);
							}
							pInfo[i][O_S][j] = true;
							pInfo[i][P_S] += 1;
						}
					}
					else if(pInfo[i][O_S][j] == true){
					    DestroyPlayerObject(i,pInfo[i][P_O][j]);
					    pInfo[i][O_S][j] = false;
					    pInfo[i][P_S] -= 1;
					}
				}
			}
		}
	}
}
public CheckPos5(){
	for(new j = 0; j < MAX_AUTO_OBJECTS; j++){
	    if(aInfo[j][aExist] == true){
	        for(new i = 0; i < MAX_PLAYERS; i++){
	            if(IsPlayerConnected(i)){
				    if(IsPlayerInRangeOfPoint(i,aInfo[j][distance3],aInfo[j][closedx],aInfo[j][closedy],aInfo[j][closedz])){
				        isAr[j] = true;
					}
					else{
					    if(isAr[j] == false){
					        MoveStreamedObject(aInfo[j][gID],aInfo[j][closedx],aInfo[j][closedy],aInfo[j][closedz],aInfo[j][ospeed]);
						}
					}
				}
			}
			if(isAr[j] == true){
			    MoveStreamedObject(aInfo[j][gID],aInfo[j][openedx],aInfo[j][openedy],aInfo[j][openedz],aInfo[j][ospeed]);
			}
			isAr[j] = false;
		}
	}
	return 1;
}
stock DestroyAllStreamedObjects(){
	for(new i = 0; i < MAX_STREAMED_OBJECTS; i++){
		if(oInfo[i][oExist] == true){
		    DestroyStreamedObject(i);
		    oInfo[i][oExist] = false;
		}
	}
}
public CreateUnMoveableObject(modelid,Float:x,Float:y,Float:z,Float:xrot,Float:yrot,Float:zrot,Float:viewdistance){
	new Object;
	Object++;
	Object = CreateObjectToStream(modelid,x,y,z,xrot,yrot,zrot,viewdistance);
	oInfo[Object][O_X] = x;
	oInfo[Object][O_Y] = y;
	oInfo[Object][O_Z] = z;
	oInfo[Object][O_XR] = xrot;
	oInfo[Object][O_XR] = yrot;
	oInfo[Object][O_XR] = zrot;
	oInfo[Object][O_VD] = viewdistance;
	oInfo[Object][oExist] = true;
	oInfo[Object][umtimer] = SetTimerEx("UNMOVE",1500,true,"dffffff",Object,x,y,z,xrot,yrot,zrot);
}
public UNMOVE(objectid,Float:x,Float:y,Float:z,Float:xrot,Float:yrot,Float:zrot){
	SetStreamedObjectPos(objectid,x,y,z);
	SetStreamedObjectRot(objectid,xrot,yrot,zrot);
}