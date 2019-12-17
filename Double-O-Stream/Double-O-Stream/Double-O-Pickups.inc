#include <a_samp>

#define MAX_STREAM_PICKUPS 1500
#define MAX_PICKUPS 400
#define INVALID_STREAM_PICKUP_ID -1
#define INVALID_PICKUP_ID -1

//If defined, it will bugfix the pickup ID when picking up a pickup on Linux server. Not necessary on Windows.
#define LINUX

#define IsPosInDistance(%0,%1,%2,%3,%4,%5,%6) \
        (((%0 - %3) * (%0 - %3)) + ((%1 - %4) * (%1 - %4)) + ((%2 - %5) * (%2 - %5)) <= %6 * %6)// BIG THX to Goldkiller
        
forward OnPlayerPickUpStreamPickup(playerid,spickupid);

enum PICKUP_INFO
{
	CREATED,
	PICKUP_ID,
	MODEL,
	TYPE,
	Float:POS[3]
}

new PickupInfo[MAX_STREAM_PICKUPS][PICKUP_INFO];
new PickupCount;
#if !defined LINUX
	new PickupStreamID[MAX_PICKUPS];
#endif

forward CreateStreamPickup(model, type, Float:X, Float:Y, Float:Z);
public CreateStreamPickup(model, type, Float:X, Float:Y, Float:Z)
{
	for(new i=0;i<MAX_STREAM_PICKUPS;i++)
	{
	    if(!PickupInfo[i][CREATED])
	    {
	        PickupInfo[i][CREATED]=true;
	        PickupInfo[i][PICKUP_ID]=INVALID_PICKUP_ID;
	        PickupInfo[i][MODEL]=model;
	        PickupInfo[i][TYPE]=type;
	        PickupInfo[i][POS][0]=X;
	        PickupInfo[i][POS][1]=Y;
	        PickupInfo[i][POS][2]=Z;
	        return i;
	    }
	}
	return INVALID_STREAM_PICKUP_ID;
}

forward DestroyStreamPickup(spickupid);
public DestroyStreamPickup(spickupid)
{
	if(spickupid>=0 && spickupid<MAX_STREAM_PICKUPS)
	{
	    if(PickupInfo[spickupid][CREATED])
	    {
	        if(PickupInfo[spickupid][PICKUP_ID]!=INVALID_PICKUP_ID)
	        {
	            DestroyPickup(PickupInfo[spickupid][PICKUP_ID]);
	            #if !defined LINUX
				    PickupStreamID[PickupInfo[spickupid][PICKUP_ID]]=INVALID_STREAM_PICKUP_ID;
				#endif
	            PickupInfo[spickupid][PICKUP_ID]=INVALID_PICKUP_ID;
	            PickupCount--;
	        }
	        PickupInfo[spickupid][CREATED]=false;
	        return 1;
	    }
	}
	return 0;
}

stock IsAnyPlayerNearStreamPickup(spickupid,distance)
{
	new Float:x,Float:y,Float:z;
	for(new i=0;i<MAX_PLAYERS;i++)
	    if(GetPlayerPos(i,x,y,z))
	        if(IsPosInDistance(x,y,z,PickupInfo[spickupid][POS][0],PickupInfo[spickupid][POS][1],PickupInfo[spickupid][POS][2],distance))
	            return true;
	return false;
}

forward StreamPickups();
public StreamPickups()
{
	for(new i=0;i<MAX_STREAM_PICKUPS;i++)
	{
	    if(PickupInfo[i][CREATED])
	    {
	        if(IsAnyPlayerNearStreamPickup(i,100))
	        {
	            if(PickupInfo[i][PICKUP_ID]==INVALID_PICKUP_ID && PickupCount<MAX_STREAM_PICKUPS)
	            {
	                PickupInfo[i][PICKUP_ID]=CreatePickup(PickupInfo[i][MODEL],PickupInfo[i][TYPE],
	                    PickupInfo[i][POS][0],PickupInfo[i][POS][1],PickupInfo[i][POS][2]);
					#if !defined LINUX
					    PickupStreamID[PickupInfo[i][PICKUP_ID]]=i;
					#endif
					PickupCount++;
	            }
	        }
	        else
	        {
	            if(PickupInfo[i][PICKUP_ID]!=INVALID_PICKUP_ID)
	            {
					DestroyPickup(PickupInfo[i][PICKUP_ID]);
					#if !defined LINUX
					    PickupStreamID[PickupInfo[i][PICKUP_ID]]=INVALID_STREAM_PICKUP_ID;
					#endif
	                PickupInfo[i][PICKUP_ID]=INVALID_PICKUP_ID;
	                PickupCount--;
	            }
	        }
	    }
	}
	return 1;
}

public OnPlayerPickUpPickup(playerid,pickupid)
{
	new spickupid=INVALID_STREAM_PICKUP_ID;
	#if defined LINUX
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
	    for(new i=0;i<MAX_STREAM_PICKUPS;i++)
	    {
	        if(PickupInfo[i][CREATED] && PickupInfo[i][PICKUP_ID]!=INVALID_PICKUP_ID)
	        {
	            if(IsPosInDistance(x,y,z,PickupInfo[i][POS][0],PickupInfo[i][POS][1],PickupInfo[i][POS][2],1.5))
	            {
					spickupid=i;
					break;
	            }
			}
		}
	#else
	    spickupid=PickupStreamID[pickupid];
	#endif
	if(spickupid!=INVALID_STREAM_PICKUP_ID)
	    return CallLocalFunction("OnPlayerPickUpStreamPickup","ii",playerid,spickupid);
	return 0;
}

forward GetStreamPickupPos(spickupid,&Float:x,&Float:y,&Float:z);
public GetStreamPickupPos(spickupid,&Float:x,&Float:y,&Float:z)
{
    if(spickupid>=0 && spickupid<MAX_STREAM_PICKUPS)
	{
	    if(PickupInfo[spickupid][CREATED])
	    {
	        x=PickupInfo[spickupid][POS][0];
	        y=PickupInfo[spickupid][POS][1];
	        z=PickupInfo[spickupid][POS][2];
	        return 1;
	    }
	}
	return 0;
}

forward GetStreamPickupType(spickupid);
public GetStreamPickupType(spickupid)
{
    if(spickupid>=0 && spickupid<MAX_STREAM_PICKUPS)
	    if(PickupInfo[spickupid][CREATED])
	        return PickupInfo[spickupid][TYPE];
	return 0;
}

forward GetStreamPickupModel(spickupid);
public GetStreamPickupModel(spickupid)
{
    if(spickupid>=0 && spickupid<MAX_STREAM_PICKUPS)
	    if(PickupInfo[spickupid][CREATED])
	        return PickupInfo[spickupid][MODEL];
	return 0;
}

forward SetStreamPickupPos(spickupid,Float:x,Float:y,Float:z);
public SetStreamPickupPos(spickupid,Float:x,Float:y,Float:z)
{
    if(spickupid>=0 && spickupid<MAX_STREAM_PICKUPS)
	{
	    if(PickupInfo[spickupid][CREATED])
	    {
	        PickupInfo[spickupid][POS][0]=x;
	        PickupInfo[spickupid][POS][1]=y;
	        PickupInfo[spickupid][POS][2]=z;
			if(PickupInfo[spickupid][PICKUP_ID]!=INVALID_PICKUP_ID)
			{
			    DestroyPickup(PickupInfo[spickupid][PICKUP_ID]);
			    PickupInfo[spickupid][PICKUP_ID]=INVALID_PICKUP_ID;
			}
	        return 1;
	    }
	}
	return 0;
}

forward SetStreamPickupModel(spickupid,model);
public SetStreamPickupModel(spickupid,model)
{
    if(spickupid>=0 && spickupid<MAX_STREAM_PICKUPS)
	{
	    if(PickupInfo[spickupid][CREATED])
	    {
	        PickupInfo[spickupid][MODEL]=model;
			if(PickupInfo[spickupid][PICKUP_ID]!=INVALID_PICKUP_ID)
			{
			    DestroyPickup(PickupInfo[spickupid][PICKUP_ID]);
			    PickupInfo[spickupid][PICKUP_ID]=INVALID_PICKUP_ID;
			}
	        return 1;
	    }
	}
	return 0;
}

forward SetStreamPickupType(spickupid,type);
public SetStreamPickupType(spickupid,type)
{
    if(spickupid>=0 && spickupid<MAX_STREAM_PICKUPS)
	{
	    if(PickupInfo[spickupid][CREATED])
	    {
	        PickupInfo[spickupid][TYPE]=type;
			if(PickupInfo[spickupid][PICKUP_ID]!=INVALID_PICKUP_ID)
			{
			    DestroyPickup(PickupInfo[spickupid][PICKUP_ID]);
			    PickupInfo[spickupid][PICKUP_ID]=INVALID_PICKUP_ID;
			}
	        return 1;
	    }
	}
	return 0;
}

DOP_OnGameModeInit()
{
	#if !defined LINUX
		for(new i=0;i<MAX_PICKUPS;i++)
	        PickupStreamID[i]=INVALID_STREAM_PICKUP_ID;
	#endif
	SetTimer("StreamPickups",2300,true);
}

#undef IsPosInDistance