// ------------Areas include by Backwardsman97---------------//

/*
native CreateArea(x1, y1, x2, y2)
native DestroyArea(areaid)
native IsPlayerInArea(playerid, areaid)
native ReturnPlayerArea(playerid)
native Areas_OnPlayerConnect(playerid)
native Areas_OnPlayerDisconnect(playerid)
native Areas_OnGameModeInit()
*/

#include <a_samp>

#define MAX_AREAS 200

enum AreaInfo
{
	Float:ax,
	Float:ay,
	Float:ax2,
	Float:ay2
}

new Areas =-1;
new AreaVar[MAX_AREAS][AreaInfo];
new PArea[MAX_PLAYERS];

forward OnPlayerEnterArea(playerid,areaid);
forward OnPlayerExitArea(playerid,areaid);
forward CheckArea();

public CheckArea()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		new Temp = ReturnPlayerArea(i);
		if(PArea[i] == -1)
		{
			if(Temp != -1)
			{
				PArea[i] = Temp;
				OnPlayerEnterArea(i, Temp);
			}
		}
		else
		{
			if(Temp == -1)
			{
				OnPlayerExitArea(i, PArea[i]);
				PArea[i] = -1;
			}
		}
	}
	return 1;
}

stock CreateArea(Float:x1, Float:y1, Float:x2, Float:y2)
{
	if(Areas == MAX_AREAS)
	{
		return -1;
	}
	Areas++;
	AreaVar[Areas][ax] = x1;
	AreaVar[Areas][ay] = y1;
	AreaVar[Areas][ax2] = x2;
	AreaVar[Areas][ay2] = y2;
	printf("Area created - X1:%f X2:%f Y1:%f Y2:%f   Areaid:%d",AreaVar[Areas][ax],AreaVar[Areas][ay],AreaVar[Areas][ax2],AreaVar[Areas][ay2],Areas);
	return Areas;
}

stock DestroyArea(areaid)
{
	AreaVar[areaid][ax] = 0;
	AreaVar[areaid][ay] = 0;
	AreaVar[areaid][ax2] = 0;
	AreaVar[areaid][ay2] = 0;
	Areas--;
	return 1;
}

stock IsPlayerInArea(playerid, areaid)
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	if((X < AreaVar[areaid][ax] && X > AreaVar[areaid][ax2]) && (Y < AreaVar[areaid][ay] && Y >   AreaVar[areaid][ay2])) 
	{			
		return 1;
	}
	return 0;
}

stock ReturnPlayerArea(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		for(new i=0; i<MAX_AREAS; i++)
	  	{
			if(IsPlayerInArea(playerid,i))
			{
				return i;
			}
		}
	}
	return -1;
}

stock Areas_OnPlayerConnect(playerid)
{
	PArea[playerid] = -1;
	return 1;
}

stock Areas_OnPlayerDisconnect(playerid)
{
	PArea[playerid] = -1;
	return 1;
}

stock Areas_OnGameModeInit()
{
	SetTimer("CheckArea",250,1);
	return 1;
}