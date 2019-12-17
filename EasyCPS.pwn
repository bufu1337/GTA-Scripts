//[HiC]TheKillers CheckPoint script =]
#pragma tabsize 0
#include <a_samp>
#define MAX_CPS 500
forward Float:DistanceBetweenPoints(Float:x11, Float:y11, Float:z11, Float:x22, Float:y22, Float:z22);

enum CPinfo
{
	Float:Xpos,
	Float:Ypos,
	Float:Zpos,
	Active,
	Float:Size,
	Float:ViewDis,
	VWorld,
	Inter
};

new CP[MAX_CPS][CPinfo];
new PlayerCP[MAX_PLAYERS] = -1;
new Visible[MAX_PLAYERS][MAX_CPS];
new CPID = -1;
new DisableCPS[MAX_PLAYERS];
forward OnPlayerEnterStreamedCheckpoint(playerid, cpid);
forward OnPlayerExitStreamedCheckpoint(playerid, cpid);

stock CreateCheckpoint(playerid, Float:cpX, Float:cpY, Float:cpZ, Float:cpSize, Float:viewdist = 35.0)
{
	CPID ++;
	CP[CPID][Xpos] = cpX;
	CP[CPID][Ypos] = cpY;
	CP[CPID][Zpos] = cpZ;
	CP[CPID][Size] = cpSize;
	CP[CPID][ViewDis] = viewdist;
	CP[CPID][Active] = 1;
	if(playerid != -1)
    	{
        	Visible[playerid][CPID] ++;
    	}
    	if(playerid == -1)
    	{
        	for(new i; i<MAX_PLAYERS; i++)
        	{
         	   Visible[i][CPID] ++;
        	}
    	}
	return CPID;
}


stock StartUpCP()
{
	SetTimer("Stream", 350, true);
}


forward Stream();
public Stream()
{
	for(new i; i < MAX_PLAYERS; i ++) 
	{
	    if(IsPlayerConnected(i) && DisableCPS[i] == 0)
	    {
		
	        PlayerCP[i] = -1;
	        new Count = -1, CPInRange[MAX_CPS];
     		for(new j; j < CPID + 1; j ++) 
		{
   			if(CP[j][Active] == 1)
   			{
       				if(IsPlayerInRangeOfPoint(i, CP[j][ViewDis], CP[j][Xpos], CP[j][Ypos], CP[j][Zpos]) && CP[j][Active] == 1 && CP[j][VWorld] == GetPlayerVirtualWorld(i) && CP[j][Inter] == GetPlayerInterior(i)) //Is the player in range of a CP
           			{
           			    Count++;
           			    CPInRange[Count] = j;
                     		}
			}
		}
		if(CPInRange[0] != 0)
		{
			new Result;
			for(new K; K <= Count; K ++)
			{
				        new Float:Pos[3];
				        GetPlayerPos(i, Pos[0], Pos[1], Pos[2]);
				        if(DistanceBetweenPoints(CP[CPInRange[K]][Xpos], CP[CPInRange[K]][Ypos], CP[CPInRange[K]][Zpos], Pos[0], Pos[1], Pos[2]) < DistanceBetweenPoints(Pos[0], Pos[1], Pos[2], CP[Result][Xpos], CP[Result][Ypos], CP[Result][Zpos])) Result = CPInRange[K];			
			}
			SetPlayerCheckpoint(i, CP[Result][Xpos], CP[Result][Ypos], CP[Result][Zpos], CP[Result][Size]);//Sets the player checkpoint
     			PlayerCP[i] = Result;
     			continue;
		}
		if(PlayerCP[i] == -1)
		{
   			PlayerCP[i] = -1; 
      			DisablePlayerCheckpoint(i);
        		continue;
            	}
	}
    }
    return 1;
}


Float:DistanceBetweenPoints(Float:x11, Float:y11, Float:z11, Float:x22, Float:y22, Float:z22)
	return floatsqroot(floatpower(floatabs(floatsub(x22,x11)),2)+floatpower(floatabs(floatsub(y22,y11)),2)+floatpower(floatabs(floatsub(z22,z11)),2));

stock CPEnterCheck(playerid)
{
    if(PlayerCP[playerid] != -1) return OnPlayerEnterStreamedCheckpoint(playerid, PlayerCP[playerid]);
    return 1;
}

stock CPLeaveCheck(playerid)
{
    if(PlayerCP[playerid] != -1) return OnPlayerExitStreamedCheckpoint(playerid, PlayerCP[playerid]);
    return 1;
}

stock SetCheckPointWorld(cPiD, world)
{
    CP[cPiD][VWorld] = world;
}

stock SetCheckPointInterior(cPiD, Int)
{
	CP[cPiD][Inter] = Int;
}

stock DisableCP(cPiD)
{
	CP[cPiD][Active] = 0;
}

stock EnableCP(cPiD)
{
	CP[cPiD][Active] = 1;
}

stock ShowCPForPlayer(cPiD, playerid)
{
    Visible[playerid][cPiD] = 1;
}

stock HideCPForPlayer(cPiD, playerid)
{
    Visible[playerid][cPiD] = 0;
}

stock GetCPClosestToPlayer(playerid)
{
	new Result;
        for(new j; j < CPID + 1; j ++)
	{
 	    new Float:Pos[3];
   	    GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
     	    if(DistanceBetweenPoints(CP[j][Xpos], CP[j][Ypos], CP[j][Zpos], Pos[0], Pos[1], Pos[2]) < DistanceBetweenPoints(Pos[0], Pos[1], Pos[2], CP[Result][Xpos], CP[Result][Ypos], CP[Result][Zpos])) Result = j;
	}
	return Result;
}

stock GetPlayerCheckpoint(playerid)
{
	return PlayerCP[playerid];
}

stock EnableCPSForPlayer(playerid)
{
	DisableCPS[playerid] = 0;
}

stock DisableCPSForPlayer(playerid)
{
	DisableCPS[playerid] = 1;
}

stock IsPlayerInCP(playerid)
{
	if(PlayerCP[playerid] != -1) return 1;
	return 0;
}

stock GotoCP(playerid, CpId)
{
	SetPlayerPos(playerid, CP[CpId][Xpos], CP[CpId][Ypos], CP[CpId][Zpos]);
}

stock ReturnCPLocation(CpId, &Float:X, &Float:Y, &Float:Z)
{
	X = CP[CpId][Xpos];
	Y = CP[CpId][Ypos];
	Z = CP[CpId][Zpos];
}

stock GetCPSize(CpId)
{
	return CP[CpId][Size];
}

stock GetCPViewDistance(CpId)
{
	return CP[CpId][ViewDis];
}


stock IsCPActive(CpId)
{
	return CP[CpId][Active];
}

stock SetCPLocation(CpId, Float:X, Float:Y, Float:Z)
{
	CP[CpId][Xpos] = X;
	CP[CpId][Ypos] = Y;
	CP[CpId][Zpos] = Z;
}


stock SetCPSize(CpId, Float:Sizee)
{
	CP[CpId][Size] = Sizee;
}

stock SetCPViewDistance(CpId, Float:Dista)
{
	CP[CpId][ViewDis] = Dista;
}