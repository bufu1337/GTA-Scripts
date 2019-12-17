//+--------------------------+
//¦   DOUBLE-O-CHECKPOINTS   ¦
//¦    by Double-O-Seven     ¦
//+--------------------------+
/*
You are not allowed to edit and release this include without my permission.
You are only allowed to edit for yourself. ...and don't remove my credits.
*/

#include <a_samp>

#define MAX_CPS 500
#define INVALID_CP -1

new CPActive[MAX_CPS];
new Float:CPCoords[MAX_CPS][3];
new Float:CPInfo[MAX_CPS][2];
new CPInterior[MAX_CPS];
new CPShowForAll[MAX_CPS];
new CPShowForPlayer[MAX_CPS][MAX_PLAYERS];
new PlayerCP[MAX_PLAYERS];

//Create and destroy:
forward CreateCheckpoint(Float:x,Float:y,Float:z,interior,Float:size,Float:distance,showforall);//Set showforall to "false", if you want to show the checkpoint to players only in special moments.
public CreateCheckpoint(Float:x,Float:y,Float:z,interior,Float:size,Float:distance,showforall)//Set interior to -1 to show it in all interiors.
{
	for(new i=0;i<MAX_CPS;i++)
	{
	    if(!CPActive[i])
	    {
	        CPActive[i]=true;
	        CPCoords[i][0]=x;
	        CPCoords[i][1]=y;
	        CPCoords[i][2]=z;
	        CPInterior[i]=interior;
	        CPInfo[i][0]=size;
	        CPInfo[i][1]=distance;
			ShowCheckpointForAll(i,showforall);
			return i;
	    }
	}
	return printf("[error] Could not create checkpoint");
}

forward DestroyCheckpoint(cpid);
public DestroyCheckpoint(cpid)
{
	if(CPActive[cpid])
	{
		CPActive[cpid]=false;
		CPCoords[cpid][0]=0;
		CPCoords[cpid][1]=0;
		CPCoords[cpid][2]=0;
		CPInterior[cpid]=0;
		CPInfo[cpid][0]=0;
		CPInfo[cpid][1]=0;
		ShowCheckpointForAll(cpid,false);
		return cpid;
	}
	return printf("[error] Could not destroy checkpoint");
}

//Show or hide; use "true" to show, "false" to hide.
forward ShowCheckpointForAll(cpid,show);
public ShowCheckpointForAll(cpid,show)
{
	CPShowForAll[cpid]=show;
	for(new j=0;j<MAX_PLAYERS;j++)
	    ShowCheckpointForPlayer(j,cpid,show);
	return show;
}

forward ShowCheckpointForPlayer(playerid,cpid,show);
public ShowCheckpointForPlayer(playerid,cpid,show)
{
	CPShowForPlayer[cpid][playerid]=show;
	if(PlayerCP[playerid]==cpid && !show)
	{
		PlayerCP[playerid]=INVALID_CP;
  		DisablePlayerCheckpoint(playerid);
	}
	return show;
}

//Callbacks:
DOCP_OnPlayerDisconnect(playerid)//Put this under OnPlayerDisconnect() in your script.
{
	PlayerCP[playerid]=INVALID_CP;
	for(new i=0;i<MAX_CPS;i++)
	    ShowCheckpointForPlayer(playerid,i,CPShowForAll[i]);
	return 1;
}

DOCP_OnGameModeInit()//Put this under OnGameModeInit() in your script.
{
	return SetTimer("CheckpointStreamer",1000,1);
}

//Streamer:
forward CheckpointStreamer();
public CheckpointStreamer()
{
	new cpid;
	new Float:tmpdis;
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        cpid=GetClosestCheckpoint(i);
	        if(IsValidCheckpoint(cpid))
	        {
	            GetDistanceToPoint(i,CPCoords[cpid][0],CPCoords[cpid][1],CPCoords[cpid][2],tmpdis);
	            if(tmpdis<=CPInfo[cpid][1] && (GetPlayerInterior(i)==CPInterior[cpid] || CPInterior[cpid]==-1) && CPShowForPlayer[cpid][i])
	            {
					if(PlayerCP[i]!=cpid)
					{
	                    PlayerCP[i]=cpid;
	                    DisablePlayerCheckpoint(i);
	                    SetPlayerCheckpoint(i,CPCoords[cpid][0],CPCoords[cpid][1],CPCoords[cpid][2],CPInfo[cpid][0]);
	            	}
		    	}
	            else if(PlayerCP[i]!=INVALID_CP)
	            {
	                PlayerCP[i]=INVALID_CP;
	                DisablePlayerCheckpoint(i);
	            }
	        }
	        //else are no checkpoints created...
	    }
	}
	return 1;
}

//Necessary functions:
stock GetDistanceToPoint(playerid,Float:x,Float:y,Float:z,&Float:dis)
{
	new Float:x1,Float:y1,Float:z1;
	GetPlayerPos(playerid,x1,y1,z1);
	dis=floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2)+floatpower(floatabs(floatsub(z,z1)),2));
	return 1;
}

stock GetClosestCheckpoint(playerid)
{
	new Float:dis=100000.0;
	new Float:tmpdis;
	new cpid=INVALID_CP;
	for(new i=0;i<MAX_CPS;i++)
	{
	    if(IsValidCheckpoint(i))
	    {
	        GetDistanceToPoint(playerid,CPCoords[i][0],CPCoords[i][1],CPCoords[i][2],tmpdis);
	        if(tmpdis<dis && CPShowForPlayer[i][playerid])
	        {
	            dis=tmpdis;
	            cpid=i;
	        }
		}
	}
	return cpid;
}

stock GetPlayerCheckpoint(playerid)
{
	if(IsPlayerInCheckpoint(playerid) && PlayerCP[playerid]!=INVALID_CP)
		return PlayerCP[playerid];
	return INVALID_CP;
}

stock IsValidCheckpoint(cpid)
{
	if(cpid==INVALID_CP) return false;
	if(cpid<0 || cpid>=MAX_CPS) return false;
	if(!CPActive[cpid]) return false;
	return true;
}
