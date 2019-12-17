/*
*	Created:			12.04.10
*	Author:				009
*	Last Modifed:       14.07.10
*	Description:		Citizens in SA:MP
*/

// --------------------------------------------------
// includes
// --------------------------------------------------
#include <a_samp>
#include <cnpc>

// --------------------------------------------------
// defines
// --------------------------------------------------
#define VERSION             "0.2"

#define ALL_SAN_ANDREAS

#define for_npcs(%1) for(new %1 = 499;%1 >= 50;%1--)

#if !defined MAX_STRING
	#define MAX_STRING 128
#endif

#define	NODE_TYPE_PED		0
#define	NODE_TYPE_VEHICLE	1

#define Z_CORRECTION        0.7
#define VEHICLES_SPEED      30.0

// --------------------------------------------------
// enums
// --------------------------------------------------
enum NPCNodeDataInfo
{
	nVehicleId,
	nNodeId,
	nPathType,
	nPointId,
	nLastPointId
};

// --------------------------------------------------
// news
// --------------------------------------------------
new badSkins[] = {3, 4, 5, 6, 8, 42, 65, 74, 86, 119, 149, 208, 273, 289},
	strtmp[MAX_STRING],
	Node:TrafficNodes[MAX_NODES],
	TrafficNodesHeader[MAX_NODES][4],
	NPCNodeData[MAX_NPCS][NPCNodeDataInfo],
	Float:floattmp[3],
	inttmp,
	ZoneToArray[MAX_NODES] = {-1,...};
#if defined ALL_SAN_ANDREAS
	new AllowedZones[64] =
	{
		0,1,2,...
	};
#elseif defined ONLY_LOS_SANTOS
    new AllowedZones[] =
	{
		5,6,7,12,13,14,15,20,21,22,23
	};
#elseif defined ONLY_SAN_FIERRO
    new AllowedZones[] =
	{
		17,24,25,26,32,33,34,40,41
	};
#elseif defined ONLY_LAS_VENTURAS
    new AllowedZones[] =
	{
		37,38,39,45,46,47,53,54,55,61,62,63
	};
#endif

// --------------------------------------------------
// publics
// --------------------------------------------------
public OnFilterScriptInit()
{
    // cnpc settings
	ToogleVisualDeath(0);
	// read nodes
	for(new i = 0;i < sizeof(AllowedZones);i++)
	{
	    format(strtmp,sizeof(strtmp),"Nodes/NODES%d.DAT",AllowedZones[i]);
	    if(!fexist(strtmp)) continue;
	    ZoneToArray[ AllowedZones[i] ] = i;
	    new j = AllowedZones[i];
	    TrafficNodes[j] = OpenNode(strtmp);
		GetNodeHeader(TrafficNodes[j],TrafficNodesHeader[j][0],TrafficNodesHeader[j][1],TrafficNodesHeader[j][2],TrafficNodesHeader[j][3]);
		printf("Node 'NODES%d' loaded.Data: %d,%d,%d,%d",AllowedZones[i],TrafficNodesHeader[j][0],TrafficNodesHeader[j][1],TrafficNodesHeader[j][2],TrafficNodesHeader[j][3]);
	}
	// create npcs
	for_npcs(i)
	{
	    // create npc
	    CreateNPC(i,"Citizen");
	    // randomize node
		do NPCNodeData[i][nNodeId] = AllowedZones[ random(sizeof(AllowedZones)) ];
		while(!TrafficNodes[ NPCNodeData[i][nNodeId] ]);
		// randomize type of path
		if(TrafficNodesHeader[ NPCNodeData[i][nNodeId] ][1] == 0) NPCNodeData[i][nPathType] = NODE_TYPE_PED;
		else if(TrafficNodesHeader[ NPCNodeData[i][nNodeId] ][2] == 0) NPCNodeData[i][nPathType] = NODE_TYPE_VEHICLE;
		else if(random(100) > 30) NPCNodeData[i][nPathType] = NODE_TYPE_PED;
		else NPCNodeData[i][nPathType] = NODE_TYPE_VEHICLE;
		// randomize point
		rpoint:

		switch(NPCNodeData[i][nPathType])
		{
			case NODE_TYPE_PED: NPCNodeData[i][nPointId] = TrafficNodesHeader[ NPCNodeData[i][nNodeId] ][1] + random(TrafficNodesHeader[ NPCNodeData[i][nNodeId] ][2] - 1) + 1;
			case NODE_TYPE_VEHICLE: NPCNodeData[i][nPointId] = random(TrafficNodesHeader[ NPCNodeData[i][nNodeId] ][1] - 1);
		}
		// set point and get coords
		SetNodePoint(TrafficNodes[ NPCNodeData[i][nNodeId] ],NPCNodeData[i][nPointId]);
		GetNodePointPos(TrafficNodes[ NPCNodeData[i][nNodeId] ],floattmp[0],floattmp[1],floattmp[2]);
		if(floattmp[2] > 800.0) // is coord for interior
		{
			goto rpoint;
		}
		floattmp[2] += Z_CORRECTION; // correction
	    // find valid skin
		do inttmp = random(300);
		while(!IsValidSkin(inttmp));
		// spawn on this point
		SetSpawnInfo(i,0,inttmp,floattmp[0],floattmp[1],floattmp[2],0.0,0,0,0,0,0,0);
		SpawnNPC(i);
		// vehicle
		if(NPCNodeData[i][nPathType] == NODE_TYPE_VEHICLE)
		{
		    inttmp = GetNodePointType(TrafficNodes[ NPCNodeData[i][nNodeId] ]);
			switch(inttmp)
			{
				case 1: // car
				{
					do inttmp = (random(212) + 400);
					while(!IsVehicleCar(inttmp));
					NPCNodeData[i][nVehicleId] = AddStaticVehicle(inttmp,floattmp[0],floattmp[1],floattmp[2],0.0,-1,-1);
					PutNPCInVehicle(i,NPCNodeData[i][nVehicleId],0);
				}
				case 2: // boat
				{
					do inttmp = (random(212) + 400);
					while(!IsVehicleBoat(inttmp));
					NPCNodeData[i][nVehicleId] = AddStaticVehicle(inttmp,floattmp[0],floattmp[1],floattmp[2],0.0,-1,-1);
					PutNPCInVehicle(i,NPCNodeData[i][nVehicleId],0);
				}
				default: goto rpoint;
			}
		}
		// get next point
	    new link = GetNodePointLinkId(TrafficNodes[ NPCNodeData[i][nNodeId] ]);
	    SetNodeLink(TrafficNodes[ NPCNodeData[i][nNodeId] ],link);
	    // save last point
	    NPCNodeData[i][nLastPointId] = NPCNodeData[i][nPointId];
	    // change point
	    NPCNodeData[i][nPointId] = GetNodeLinkNodeId(TrafficNodes[ NPCNodeData[i][nNodeId] ]);
		NPCNodeData[i][nNodeId] = GetNodeLinkAreaId(TrafficNodes[ NPCNodeData[i][nNodeId] ]);
		// check zone
		if(ZoneToArray[ NPCNodeData[i][nNodeId] ] == -1)
		{
		    goto rpoint;
		}
		// get coords
		SetNodePoint(TrafficNodes[ NPCNodeData[i][nNodeId] ],NPCNodeData[i][nPointId]);
		GetNodePointPos(TrafficNodes[ NPCNodeData[i][nNodeId] ],floattmp[0],floattmp[1],floattmp[2]);
		floattmp[2] += Z_CORRECTION; // correction
        // go to this point
		switch(NPCNodeData[i][nPathType])
		{
			case NODE_TYPE_PED: NPC_WalkTo(i,floattmp[0],floattmp[1],floattmp[2],0);
			case NODE_TYPE_VEHICLE: NPC_DriveTo(i,floattmp[0],floattmp[1],floattmp[2],VEHICLES_SPEED,0);
		}
	}
    print("Citizens " VERSION " by 009 loaded.");
    return 1;
}

public OnFilterScriptExit()
{
    for_npcs(i)
    {
    	if(!IsValidNPC(i)) continue;
    	DestroyNPC(i);
    }
    for(new i = 0;i < sizeof(TrafficNodes);i++)
    {
        if(ZoneToArray[i] != -1) CloseNode(TrafficNodes[i]);
    }
    print("Citizens " VERSION " by 009 unloaded.");
    return 1;
}

/*
public OnGameModeInit()
{
	print("Citizens loading...");
	
	print("Citizens loaded.");
}
*/

public OnPlayerStreamIn(playerid, forplayerid)
{
	if(!IsValidNPC(playerid)) return;
	if(GetNPCState(playerid) == NPC_STATE_DEATH) ApplyAnimation(playerid,"PED","KO_skid_front",4.1,0,1,1,1,1);
}

// -----------------------------------------------------------------------------
//                                  Plugin's callbacks
// -----------------------------------------------------------------------------
public OnNPCGetDamage(npcid,playerid,Float:health_loss,bodypart)
{
    return 1;
}

public OnNPCSpawn(npcid)
{
	SetPlayerColor(npcid,0xFFFFFF00);
    return 1;
}

public OnNPCMovingComplete(npcid)
{
	// set cuurent point for geting
	SetNodePoint(TrafficNodes[ NPCNodeData[npcid][nNodeId] ],NPCNodeData[npcid][nPointId]);
    // get next point
	new link = GetNodePointLinkId(TrafficNodes[ NPCNodeData[npcid][nNodeId] ]);
	new lc = GetNodePointLinkCount(TrafficNodes[ NPCNodeData[npcid][nNodeId] ]);
	new try_count = 0;
	// randomize link
	randomize:
	// get point
	SetNodeLink(TrafficNodes[ NPCNodeData[npcid][nNodeId] ],(link + random(lc)));
	// get tmp pid
	inttmp =  GetNodeLinkNodeId(TrafficNodes[ NPCNodeData[npcid][nNodeId] ]);
	if((inttmp == NPCNodeData[npcid][nLastPointId]) && (lc > 1))
	{
	    try_count++;
	    if(try_count < 10) goto randomize;
	}
	// check zone
	new node = GetNodeLinkAreaId(TrafficNodes[ NPCNodeData[npcid][nNodeId] ]);
	if(ZoneToArray[ node ] == -1) goto randomize;
	// save last point
	NPCNodeData[npcid][nLastPointId] = NPCNodeData[npcid][nPointId];
	// change point
	NPCNodeData[npcid][nPointId] = inttmp;
	NPCNodeData[npcid][nNodeId] = node;
	// get coords
	SetNodePoint(TrafficNodes[ NPCNodeData[npcid][nNodeId] ],NPCNodeData[npcid][nPointId]);
	GetNodePointPos(TrafficNodes[ NPCNodeData[npcid][nNodeId] ],floattmp[0],floattmp[1],floattmp[2]);
	floattmp[2] += Z_CORRECTION; // correction
    // go to this point
	switch(NPCNodeData[npcid][nPathType])
	{
		case NODE_TYPE_PED: NPC_WalkTo(npcid,floattmp[0],floattmp[1],floattmp[2],0);
		case NODE_TYPE_VEHICLE: NPC_DriveTo(npcid,floattmp[0],floattmp[1],floattmp[2],VEHICLES_SPEED,0);
	}
    return 1;
}

public OnNPCDeath(npcid,killerid,reason)
{
    ApplyAnimation(npcid,"PED","KO_skid_front",4.1,0,1,1,1,1);
    return 1;
}

// --------------------------------------------------
// stocks
// --------------------------------------------------
stock IsValidSkin(skinid)
{
  if(skinid < 0 || skinid > 299) return false;
  
  for (new i = 0; i < sizeof(badSkins); i++)
  {
      if (skinid == badSkins[i]) return false;
  }
  return true;
}

stock IsVehicleCar(model)
{
	switch(model)
	{
		case 401:return 1;
		case 402:return 1;
		case 404:return 1;
		case 405:return 1;
		case 409:return 1;
		case 410:return 1;
		case 411:return 1;
		case 412:return 1;
		case 415:return 1;
		case 419:return 1;
		case 420:return 1;
		case 421:return 1;
		case 426:return 1;
		case 429:return 1;
		case 434:return 1;
		case 436:return 1;
		case 438:return 1;
		case 439:return 1;
		case 442:return 1;
		case 445:return 1;
		case 451:return 1;
		case 458:return 1;
		case 466:return 1;
		case 467:return 1;
		case 474:return 1;
		case 475:return 1;
		case 477:return 1;
		case 479:return 1;
		case 480:return 1;
		case 491:return 1;
		case 492:return 1;
		case 496:return 1;
		case 506:return 1;
		case 507:return 1;
		case 516:return 1;
		case 517:return 1;
		case 518:return 1;
		case 526:return 1;
		case 527:return 1;
		case 529:return 1;
		case 533:return 1;
		case 534:return 1;
		case 535:return 1;
		case 536:return 1;
		case 540:return 1;
		case 541:return 1;
		case 542:return 1;
		case 545:return 1;
		case 546:return 1;
		case 547:return 1;
		case 549:return 1;
		case 550:return 1;
		case 551:return 1;
		case 555:return 1;
		case 558:return 1;
		case 559:return 1;
		case 560:return 1;
		case 561:return 1;
		case 562:return 1;
		case 565:return 1;
		case 566:return 1;
		case 567:return 1;
		case 575:return 1;
		case 576:return 1;
		case 580:return 1;
		case 585:return 1;
		case 587:return 1;
		case 589:return 1;
		case 596:return 1;
		case 597:return 1;
		case 598:return 1;
		case 600:return 1;
		case 602:return 1;
		case 603:return 1;
	}
	return 0;
}

stock IsVehicleBoat(model)
{
	switch(model)
	{
		case 430:return 1;
		case 446:return 1;
		case 452:return 1;
		case 453:return 1;
		case 454:return 1;
		case 472:return 1;
		case 473:return 1;
		case 484:return 1;
		case 493:return 1;
		case 595:return 1;
	}
	return 0;
}
