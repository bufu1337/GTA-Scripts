/*
*	Created:			09.03.10
*	Author:				009
*	Last Modifed:		29.08.10
*	Description:		нативы управления NPC
*/

#if defined _cnpc_included
	#endinput
#endif

#define _cnpc_included
#pragma library cnpc

//
//	Defines
//
#define MAX_NPCS								500
#define MAX_NODES								100

#define NPC_STATE_REQUEST_CLASS					0
#define NPC_STATE_ONFOOT						1
#define NPC_STATE_DRIVER						2
#define NPC_STATE_PASSANGER						3
#define NPC_STATE_DEATH							4
#define	NPC_STATE_PLAYBACK						5

#define PLAYER_RECORDING_TYPE_NONE				0
#define PLAYER_RECORDING_TYPE_DRIVER			1
#define PLAYER_RECORDING_TYPE_ONFOOT			2

#define	NPC_RECORD_END_REASON_END				1
#define	NPC_RECORD_END_REASON_DEATH				2
#define	NPC_RECORD_END_REASON_STOP				3
#define	NPC_RECORD_END_REASON_DESTROY			4

//
//	Natives
//

// core
native CreateNPC(npcid,npcname[]);
native IsValidNPC(npcid);
native DestroyNPC(npcid);
native KillNPC(npcid);
native SpawnNPC(npcid);
native PutNPCInVehicle(npcid,vehicleid,seat);
native StopNPC(npcid);
native SetNPCImpregnable(npcid,istate);
native IsNPCImpregnable(npcid);
native GetNPCState(npcid);
native ToogleVisualDeath(tstate);
native DisableJoinPartLogging();
native FindLastFreeSlot();
// on foot controlls
native SetNPCPos(npcid,Float:X,Float:Y,Float:Z);
native GetNPCPos(npcid,&Float:X,&Float:Y,&Float:Z);
native SetNPCFacingAngle(npcid,Float:angle);
native Float:GetNPCFacingAngle(npcid);
native SetNPCVelocity(npcid,Float:X,Float:Y,Float:Z);
native GetNPCVelocity(npcid,&Float:X,&Float:Y,&Float:Z);
native SetNPCKeys(npcid,updown,leftright,keys);
native GetNPCKeys(npcid,&updown,&leftright,&keys);
native SetNPCSkin(npcid,skin);
native GetNPCSkin(npcid);
native SetNPCInterior(npcid,interior);
native GetNPCInterior(npcid);
native SetNPCSpecialAction(npcid,action);
native GetNPCSpecialAction(npcid);
native SetNPCWeapon(npcid,weaponid);
native GetNPCWeapon(npcid);
native SetNPCWeaponSkillLevel(npcid,weapontype,level);
native GetNPCWeaponSkillLevel(npcid,weapontype);
native SetNPCHealth(npcid,Float:amount);
native Float:GetNPCHealth(npcid);
native SetNPCArmour(npcid,Float:amount);
native Float:GetNPCArmour(npcid);
native SetNPCSurfing(npcid,Float:X,Float:Y,Float:Z);
native GetNPCSurfing(npcid,&Float:X,&Float:Y,&Float:Z);
native SetNPCSurfingVehicle(npcid,vehicleid);
native GetNPCSurfingVehicle(npcid);
// aim controls
native SetNPCCameraPos(npcid,Float:X,Float:Y,Float:Z);
native GetNPCCameraPos(npcid,&Float:X,&Float:Y,&Float:Z);
native SetNPCCameraFrontVector(npcid,Float:X,Float:Y,Float:Z);
native GetNPCCameraFrontVector(npcid,&Float:X,&Float:Y,&Float:Z);
native SetNPCCameraMode(npcid,mode);
native GetNPCCameraMode(npcid);
native SetNPCWeaponState(npcid,wstate);
native GetNPCWeaponState(npcid);
// driver controls
native SetNPCVehiclePos(npcid,Float:X,Float:Y,Float:Z);
native GetNPCVehiclePos(npcid,&Float:X,&Float:Y,&Float:Z);
native SetNPCVehicleQuaternion(npcid,Float:X,Float:Y,Float:Z,Float:Scal);
native GetNPCVehicleQuaternion(npcid,&Float:X,&Float:Y,&Float:Z,&Float:Scal);
native SetNPCVehicleVelocity(npcid,Float:X,Float:Y,Float:Z);
native GetNPCVehicleVelocity(npcid,&Float:X,&Float:Y,&Float:Z);
native SetNPCVehicleKeys(npcid,updown,leftright,keys);
native GetNPCVehicleKeys(npcid,&updown,&leftright,&keys);
native SetNPCVehicleSiren(npcid,vstate);
native GetNPCVehicleSiren(npcid);
native SetNPCVehicleWeapon(npcid,weaponid);
native GetNPCVehicleWeapon(npcid);
// standart actions
native NPC_WalkTo(npcid,Float:X,Float:Y,Float:Z,is_z_map);
native NPC_RunTo(npcid,Float:X,Float:Y,Float:Z,is_z_map);
native NPC_SprintTo(npcid,Float:X,Float:Y,Float:Z,is_z_map);
native NPC_LookAt(npcid,Float:X,Float:Y,Float:Z);
native NPC_AimAt(npcid,Float:X,Float:Y,Float:Z);
native NPC_ShotAt(npcid,Float:X,Float:Y,Float:Z);
native NPC_DriveTo(npcid,Float:X,Float:Y,Float:Z,Float:speed,is_z_map);
// damage config
native SetWeaponDamageForNPC(weaponid,Float:damage);
native SetWeaponReloadTimeForNPC(weaponid,mstime);
// .rec playbacks
native StartRecordingPlayback(npcid,name[]);
native PauseRecordingPlayback(npcid);
native ContinueRecordingPlayback(npcid);
native StopRecordingPlayback(npcid);
// GTA SA paths
native Node:OpenNode(name[]);
native CloseNode(Node:nodeid);
native GetNodeHeader(Node:nodeid,&nodes,&vehicle_nodes,&ped_nodes,&navi_nodes);
native SetNodePoint(Node:nodeid,pointid);
native GetNodePoint(Node:nodeid);
native GetNodePointPos(Node:nodeid,&Float:X,&Float:Y,&Float:Z);
native GetNodePointLinkId(Node:nodeid);
native GetNodePointAreaId(Node:nodeid);
native GetNodePointWidth(Node:nodeid);
native GetNodePointLinkCount(Node:pointid);
native GetNodePointTrafficLevel(Node:nodeid);
native IsNodePointRoadBlock(Node:nodeid);
native IsNodePointBoats(Node:nodeid);
native IsNodePointEmergency(Node:nodeid);
native IsNodePointNotHighway(Node:nodeid);
native IsNodePointSpawn(Node:nodeid);
native IsNodePointRoadBlock1(Node:nodeid);
native IsNodePointParking(Node:nodeid);
native IsNodePointRoadBlock2(Node:nodeid);
native GetNodePointType(Node:nodeid);
native SetNodeLink(Node:nodeid,linkid);
native GetNodeLinkAreaId(Node:nodeid);
native GetNodeLinkNodeId(Node:nodeid);
// ZMap
native ZMap_Init(mapname[]);
native Float:ZMap_GetZForCoords(Float:X,Float:Y);
// Rolls
native Float:ConvertRollToGrad(Float:roll);
native Float:ConvertGradToRoll(Float:grad);

//
//	Callbacks
//
forward OnNPCGetDamage(npcid,playerid,Float:health_loss,bodypart);
forward OnRecordingPlaybackEnd(npcid,reason);
forward OnNPCMovingComplete(npcid);
forward OnNPCSpawn(npcid);
forward OnNPCDeath(npcid,killerid,reason);