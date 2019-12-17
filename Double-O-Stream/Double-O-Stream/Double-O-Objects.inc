#include <a_samp>

#define MAX_STREAM_OBJECTS 5000
#define ALL_WORLDS -1

#define IsPosInDistance(%0,%1,%2,%3,%4,%5,%6) \
        (((%0 - %3) * (%0 - %3)) + ((%1 - %4) * (%1 - %4)) + ((%2 - %5) * (%2 - %5)) <= %6 * %6)// BIG THX to Goldkiller

new ObjectModel[MAX_STREAM_OBJECTS];
new Float:ObjectPos[MAX_STREAM_OBJECTS][3];
new Float:ObjectRotation[MAX_STREAM_OBJECTS][3];
new Float:ObjectDistance[MAX_STREAM_OBJECTS];
new ObjectObjectID[MAX_PLAYERS][MAX_STREAM_OBJECTS];
new ObjectWorld[MAX_STREAM_OBJECTS];
new Created[MAX_STREAM_OBJECTS];
new ObjectCount[MAX_PLAYERS];

forward CreateStreamObject(modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, Float:distance,worldid);
forward DestroyStreamObject(objectid);
forward StreamObjects();
forward StreamPlayerObjects(playerid,Float:x,Float:y,Float:z);
forward MoveStreamObject(objectid,Float:x,Float:y,Float:z,Float:speed);
forward StopStreamObject(objectid);
forward DOO_SetPlayerPos(playerid,Float:x,Float:y,Float:z);
forward DOO_SetVehiclePos(vehicleid,Float:x,Float:y,Float:z);
forward SetStreamObjectRot(objectid, Float:rX, Float:rY, Float:rZ);
forward SetStreamObjectPos(objectid, Float:x, Float:y, Float:z);
forward SetObjectViewDistance(objectid,Float:distance);

DOO_OnGameModeInit()
{
	SetTimer("StreamObjects",1000,true);
}

DOO_OnPlayerConnect(playerid)
{
	ObjectCount[playerid]=0;
    for(new i=0;i<MAX_STREAM_OBJECTS;i++)
	    ObjectObjectID[playerid][i]=INVALID_OBJECT_ID;
}

DOO_OnPlayerDisconnect(playerid)
{
	for(new i=0;i<MAX_STREAM_OBJECTS;i++)
	    ObjectObjectID[playerid][i]=INVALID_OBJECT_ID;

	for(new i=0;i<MAX_OBJECTS;i++)
	    if(IsValidPlayerObject(playerid,i))
	        DestroyPlayerObject(playerid,i);
}

public CreateStreamObject(modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, Float:distance,worldid)
{
	for(new i=0;i<MAX_STREAM_OBJECTS;i++)
	{
	    if(!Created[i])
	    {
	        ObjectModel[i]=modelid;
	        ObjectPos[i][0]=X;
	        ObjectPos[i][1]=Y;
	        ObjectPos[i][2]=Z;
	        ObjectRotation[i][0]=rX;
	        ObjectRotation[i][1]=rY;
	        ObjectRotation[i][2]=rZ;
			ObjectDistance[i]=distance;
			ObjectWorld[i]=worldid;
			Created[i]=true;
	        return i;
	    }
	}
	return INVALID_OBJECT_ID;
}

public DestroyStreamObject(objectid)
{
	if(IsValidStreamObject(objectid))
    {
        for(new i=0;i<MAX_PLAYERS;i++)
		{
		    if(IsPlayerConnected(i) && ObjectObjectID[i][objectid]!=INVALID_OBJECT_ID)
		    {
		        DestroyPlayerObject(i,ObjectObjectID[i][objectid]);
		        ObjectObjectID[i][objectid]=INVALID_OBJECT_ID;
		        ObjectCount[i]--;
		    }
		}
		Created[objectid]=false;
		return 1;
    }
	return 0;
}

public SetObjectViewDistance(objectid,Float:distance)
{
	if(IsValidStreamObject(objectid))
	{
	    ObjectDistance[objectid]=distance;
	    return 1;
	}
	return 0;
}

public StreamObjects()
{
	new Float:x,Float:y,Float:z;
	for(new i=0;i<MAX_PLAYERS;i++)
	    if(GetPlayerPos(i,x,y,z))
	        StreamPlayerObjects(i,x,y,z);
	return 1;
}

public StreamPlayerObjects(playerid,Float:x,Float:y,Float:z)
{
	new worldid=GetPlayerVirtualWorld(playerid);
	for(new i=0;i<MAX_STREAM_OBJECTS;i++)
	{
	    if(Created[i])
	    {
		    if(IsPosInDistance(x,y,z,ObjectPos[i][0],ObjectPos[i][1],ObjectPos[i][2],ObjectDistance[i]) && (ObjectWorld[i]==ALL_WORLDS || ObjectWorld[i]==worldid))
		    {
				if(ObjectObjectID[playerid][i]==INVALID_OBJECT_ID && ObjectCount[playerid]<MAX_OBJECTS)
				{
				    ObjectObjectID[playerid][i]=CreatePlayerObject(playerid,ObjectModel[i],ObjectPos[i][0],ObjectPos[i][1],ObjectPos[i][2],ObjectRotation[i][0],ObjectRotation[i][1],ObjectRotation[i][2]);
				    ObjectCount[playerid]++;
				}
		    }
		    else
		    {
		        if(ObjectObjectID[playerid][i]!=INVALID_OBJECT_ID)
		        {
		            DestroyPlayerObject(playerid,ObjectObjectID[playerid][i]);
		            ObjectObjectID[playerid][i]=INVALID_OBJECT_ID;
		            ObjectCount[playerid]--;
		        }
		    }
	    }
	}
	return 1;
}

stock IsValidStreamObject(objectid)
{
	if(objectid>=0 && objectid<MAX_STREAM_OBJECTS)
	    if(Created[objectid])
	        return true;
	return false;
}

public MoveStreamObject(objectid,Float:x,Float:y,Float:z,Float:speed)
{
    if(IsValidStreamObject(objectid))
    {
        for(new i=0;i<MAX_PLAYERS;i++)
		    if(IsPlayerConnected(i) && ObjectObjectID[i][objectid]!=INVALID_OBJECT_ID)
		        MovePlayerObject(i,ObjectObjectID[i][objectid],x,y,z,speed);
		ObjectPos[objectid][0]=x;
		ObjectPos[objectid][1]=y;
		ObjectPos[objectid][2]=z;
		return 1;
    }
	return 0;
}

public StopStreamObject(objectid)
{
	if(IsValidStreamObject(objectid))
    {
        for(new i=0;i<MAX_PLAYERS;i++)
		    if(IsPlayerConnected(i) && ObjectObjectID[i][objectid]!=INVALID_OBJECT_ID)
		        StopPlayerObject(i,ObjectObjectID[i][objectid]);
		return 1;
    }
	return 0;
}

public SetStreamObjectRot(objectid, Float:rX, Float:rY, Float:rZ)//SetPlayerObjectRot futsch => Funktioniert nicht!
{
	if(IsValidStreamObject(objectid))
    {
        for(new i=0;i<MAX_PLAYERS;i++)
		    if(IsPlayerConnected(i) && ObjectObjectID[i][objectid]!=INVALID_OBJECT_ID)
		        SetPlayerObjectRot(i, ObjectObjectID[i][objectid], rX, rY, rZ);
        ObjectRotation[objectid][0]=rX;
		ObjectRotation[objectid][1]=rY;
		ObjectRotation[objectid][2]=rZ;
		return 1;
    }
	return 0;
}

public SetStreamObjectPos(objectid, Float:x, Float:y, Float:z)
{
    if(IsValidStreamObject(objectid))
    {
        for(new i=0;i<MAX_PLAYERS;i++)
		    if(IsPlayerConnected(i) && ObjectObjectID[i][objectid]!=INVALID_OBJECT_ID)
		        SetPlayerObjectPos(i, ObjectObjectID[i][objectid], x, y, z);
        ObjectPos[objectid][0]=x;
		ObjectPos[objectid][1]=y;
		ObjectPos[objectid][2]=z;
		return 1;
    }
    return 0;
}

public DOO_SetPlayerPos(playerid,Float:x,Float:y,Float:z)
{
	StreamPlayerObjects(playerid,x,y,z);
	return SetPlayerPos(playerid,x,y,z);
}

public DOO_SetVehiclePos(vehicleid,Float:x,Float:y,Float:z)
{
	for(new i=0;i<MAX_PLAYERS;i++)
	    if(IsPlayerConnected(i) && GetPlayerVehicleID(i)==vehicleid)
	        StreamPlayerObjects(i,x,y,z);
	return SetVehiclePos(vehicleid,x,y,z);
}

#undef IsPosInDistance