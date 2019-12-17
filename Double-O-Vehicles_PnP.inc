#if defined _DOV_included
	#endinput
#endif
#define _DOV_included

#include <a_samp>

#define MAX_STREAM_VEHICLES 2000
#define VIEW_DISTANCE 500
#define MAX_COMPONENTS 12
#define INVALID_STREAM_ID 0
#define N_SIZE 10

#define IsPosInDistance(%0,%1,%2,%3,%4,%5,%6) \
        (((%0 - %3) * (%0 - %3)) + ((%1 - %4) * (%1 - %4)) + ((%2 - %5) * (%2 - %5)) <= %6 * %6)// BIG THX to Goldkiller

forward OnPlayerExitStreamVehicle(playerid,svehicleid);
forward OnPlayerEnterStreamVehicle(playerid,svehicleid,ispassenger);
forward OnStreamVehicleSpawn(svehicleid);
forward OnStreamVehicleDeath(svehicleid, killerid);
forward OnStreamVehiclePaintjob(playerid, svehicleid, paintjobid);
forward OnStreamVehicleRespray(playerid, svehicleid, color1, color2);
forward OnStreamVehicleMod(playerid, svehicleid, componentid);
forward OnStreamVehicleModelChange(svehicleid,old_modelid,new_modelid);
forward DOV_OnGameModeInit();

enum VEHICLE_INFO
{
	CREATED,
	VEHICLE_ID,
	MODEL,
	Float:SPAWN_POS[4],
	Float:CURRENT_POS[4],
	INTERIOR,
	WORLD,
	SPAWN_COLORS[2],
	CURRENT_COLORS[2],
	PAINTJOB,
	COMPONENTS[MAX_COMPONENTS],
	Float:HEALTH,
	RESPAWN_DELAY,
	RESPAWNING,
	NUMBERPLATE[N_SIZE],
	DESTROYABLE
}

new VehicleInfo[MAX_STREAM_VEHICLES][VEHICLE_INFO];
new VehicleStreamID[MAX_VEHICLES];
new VehicleParams[MAX_STREAM_VEHICLES][2][MAX_PLAYERS];
new VehicleCount;

forward CreateStreamVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay);
public CreateStreamVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay)
{
	for(new i=1;i<MAX_STREAM_VEHICLES;i++)
	{
	    if(!VehicleInfo[i][CREATED])
	    {
            VehicleInfo[i][CREATED]=true;
            VehicleInfo[i][VEHICLE_ID]=0;
            VehicleInfo[i][MODEL]=vehicletype;
            VehicleInfo[i][SPAWN_POS][0]=x;
            VehicleInfo[i][SPAWN_POS][1]=y;
            VehicleInfo[i][SPAWN_POS][2]=z;
            VehicleInfo[i][SPAWN_POS][3]=rotation;
            VehicleInfo[i][SPAWN_COLORS][0]=color1;
            VehicleInfo[i][SPAWN_COLORS][1]=color2;
            VehicleInfo[i][INTERIOR]=0;
            VehicleInfo[i][WORLD]=0;
            VehicleInfo[i][RESPAWN_DELAY]=respawn_delay;//in seconds.
            VehicleInfo[i][RESPAWNING]=0;
            VehicleInfo[i][HEALTH]=1000;
            VehicleInfo[i][PAINTJOB]=0;
			VehicleInfo[i][NUMBERPLATE][0]='\0';
			VehicleInfo[i][DESTROYABLE]=true;

			for(new j=0;j<4;j++)
			    VehicleInfo[i][CURRENT_POS][j]=VehicleInfo[i][SPAWN_POS][j];
		    VehicleInfo[i][CURRENT_COLORS][0]=VehicleInfo[i][SPAWN_COLORS][0];
		    VehicleInfo[i][CURRENT_COLORS][1]=VehicleInfo[i][SPAWN_COLORS][1];

            for(new j=0;j<MAX_COMPONENTS;j++)
                VehicleInfo[i][COMPONENTS][j]=0;

            for(new k=0;k<MAX_PLAYERS;k++)
			    VehicleParams[i][0][k]=VehicleParams[i][1][k]=0;
            return i;
	    }
	}
	return 0;
}

forward AddStaticStreamVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2);
public AddStaticStreamVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2)
{
	for(new i=1;i<MAX_STREAM_VEHICLES;i++)
	{
	    if(!VehicleInfo[i][CREATED])
	    {
            VehicleInfo[i][CREATED]=true;
            VehicleInfo[i][VEHICLE_ID]=0;
            VehicleInfo[i][MODEL]=vehicletype;
            VehicleInfo[i][SPAWN_POS][0]=x;
            VehicleInfo[i][SPAWN_POS][1]=y;
            VehicleInfo[i][SPAWN_POS][2]=z;
            VehicleInfo[i][SPAWN_POS][3]=rotation;
            VehicleInfo[i][SPAWN_COLORS][0]=color1;
            VehicleInfo[i][SPAWN_COLORS][1]=color2;
            VehicleInfo[i][INTERIOR]=0;
            VehicleInfo[i][WORLD]=0;
            VehicleInfo[i][RESPAWN_DELAY]=120;//2 minutes
            VehicleInfo[i][RESPAWNING]=0;
            VehicleInfo[i][HEALTH]=1000;
            VehicleInfo[i][PAINTJOB]=0;
			VehicleInfo[i][NUMBERPLATE][0]='\0';
			VehicleInfo[i][DESTROYABLE]=false;

			for(new j=0;j<4;j++)
			    VehicleInfo[i][CURRENT_POS][j]=VehicleInfo[i][SPAWN_POS][j];
		    VehicleInfo[i][CURRENT_COLORS][0]=VehicleInfo[i][SPAWN_COLORS][0];
		    VehicleInfo[i][CURRENT_COLORS][1]=VehicleInfo[i][SPAWN_COLORS][1];

            for(new j=0;j<MAX_COMPONENTS;j++)
                VehicleInfo[i][COMPONENTS][j]=0;

            for(new k=0;k<MAX_PLAYERS;k++)
			    VehicleParams[i][0][k]=VehicleParams[i][1][k]=0;
            return i;
	    }
	}
	return 0;
}

forward AddStaticStreamVehicleEx(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2,respawn_delay);
public AddStaticStreamVehicleEx(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2,respawn_delay)
{
	for(new i=1;i<MAX_STREAM_VEHICLES;i++)
	{
	    if(!VehicleInfo[i][CREATED])
	    {
            VehicleInfo[i][CREATED]=true;
            VehicleInfo[i][VEHICLE_ID]=0;
            VehicleInfo[i][MODEL]=vehicletype;
            VehicleInfo[i][SPAWN_POS][0]=x;
            VehicleInfo[i][SPAWN_POS][1]=y;
            VehicleInfo[i][SPAWN_POS][2]=z;
            VehicleInfo[i][SPAWN_POS][3]=rotation;
            VehicleInfo[i][SPAWN_COLORS][0]=color1;
            VehicleInfo[i][SPAWN_COLORS][1]=color2;
            VehicleInfo[i][INTERIOR]=0;
            VehicleInfo[i][WORLD]=0;
            VehicleInfo[i][RESPAWN_DELAY]=respawn_delay;//2 minutes
            VehicleInfo[i][RESPAWNING]=0;
            VehicleInfo[i][HEALTH]=1000;
            VehicleInfo[i][PAINTJOB]=0;
			VehicleInfo[i][NUMBERPLATE][0]='\0';
			VehicleInfo[i][DESTROYABLE]=false;

			for(new j=0;j<4;j++)
			    VehicleInfo[i][CURRENT_POS][j]=VehicleInfo[i][SPAWN_POS][j];
		    VehicleInfo[i][CURRENT_COLORS][0]=VehicleInfo[i][SPAWN_COLORS][0];
		    VehicleInfo[i][CURRENT_COLORS][1]=VehicleInfo[i][SPAWN_COLORS][1];

            for(new j=0;j<MAX_COMPONENTS;j++)
                VehicleInfo[i][COMPONENTS][j]=0;

            for(new k=0;k<MAX_PLAYERS;k++)
			    VehicleParams[i][0][k]=VehicleParams[i][1][k]=0;
            return i;
	    }
	}
	return 0;
}

forward DestroyStreamVehicle(svehicleid);
public DestroyStreamVehicle(svehicleid)
{
	if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
	{
	    if(VehicleInfo[svehicleid][CREATED] && VehicleInfo[svehicleid][DESTROYABLE])
	    {
	        if(VehicleInfo[svehicleid][VEHICLE_ID])
	        {
	            DestroyVehicle(VehicleInfo[svehicleid][VEHICLE_ID]);
	            VehicleCount--;
			}
	        VehicleInfo[svehicleid][CREATED]=false;
	        return 1;
	    }
	}
	return 0;
}

stock IsAnyPlayerNearStreamVehicle(svehicleid,distance)
{
	new Float:x,Float:y,Float:z;
	for(new i=0;i<MAX_PLAYERS;i++)
	    if(GetPlayerPos(i,x,y,z))
	        if(IsPosInDistance(x,y,z,VehicleInfo[svehicleid][CURRENT_POS][0],VehicleInfo[svehicleid][CURRENT_POS][1],VehicleInfo[svehicleid][CURRENT_POS][2],distance))
	            return true;
	return false;
}

stock IsAnyPlayerInVehicle(vehicleid)
{
	if(vehicleid)
		for(new i=0;i<MAX_PLAYERS;i++)
			if(GetPlayerVehicleID(i)==vehicleid)
				return true;
	return false;
}

forward LoadVehicle(svehicleid);
public LoadVehicle(svehicleid)
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
	{
	    if(!VehicleInfo[svehicleid][VEHICLE_ID] && VehicleCount<MAX_VEHICLES)
        {
            VehicleCount++;
        	VehicleInfo[svehicleid][VEHICLE_ID]=CreateVehicle(VehicleInfo[svehicleid][MODEL],
        	    VehicleInfo[svehicleid][CURRENT_POS][0],VehicleInfo[svehicleid][CURRENT_POS][1],VehicleInfo[svehicleid][CURRENT_POS][2],VehicleInfo[svehicleid][CURRENT_POS][3],
        	    VehicleInfo[svehicleid][CURRENT_COLORS][0],VehicleInfo[svehicleid][CURRENT_COLORS][1],-1);
			VehicleStreamID[VehicleInfo[svehicleid][VEHICLE_ID]]=svehicleid;
			SetVehicleHealth(VehicleInfo[svehicleid][VEHICLE_ID],VehicleInfo[svehicleid][HEALTH]);
			if(VehicleInfo[svehicleid][PAINTJOB])
			    ChangeVehiclePaintjob(VehicleInfo[svehicleid][VEHICLE_ID],VehicleInfo[svehicleid][PAINTJOB]);

			for(new i=0;i<MAX_COMPONENTS;i++)
			    if(VehicleInfo[svehicleid][COMPONENTS][i])
			        AddVehicleComponent(VehicleInfo[svehicleid][VEHICLE_ID],VehicleInfo[svehicleid][COMPONENTS][i]);

			SetTimerEx("SetVehicleVirtualWorldCall",500,false,"ii",VehicleInfo[svehicleid][VEHICLE_ID],VehicleInfo[svehicleid][WORLD]);
			LinkVehicleToInterior(VehicleInfo[svehicleid][VEHICLE_ID],VehicleInfo[svehicleid][INTERIOR]);

			if(strlen(VehicleInfo[svehicleid][NUMBERPLATE]))
			    SetVehicleNumberPlate(VehicleInfo[svehicleid][VEHICLE_ID],VehicleInfo[svehicleid][NUMBERPLATE]);

			for(new i=0;i<MAX_PLAYERS;i++)
			    if(IsPlayerConnected(i))
			        SetVehicleParamsForPlayer(VehicleInfo[svehicleid][VEHICLE_ID],i,
						VehicleParams[svehicleid][0][i],VehicleParams[svehicleid][1][i]);
			return VehicleInfo[svehicleid][VEHICLE_ID];
		}
	}
	return 0;
}

forward SetVehicleVirtualWorldCall(vehicleid,worldid);
public SetVehicleVirtualWorldCall(vehicleid,worldid)
	return SetVehicleVirtualWorld(vehicleid,worldid);

forward StreamVehicles();
public StreamVehicles()
{
	new vehicleused;
	for(new i=1;i<MAX_STREAM_VEHICLES;i++)
	{
	    if(VehicleInfo[i][CREATED])
	    {
	        vehicleused=IsAnyPlayerInVehicle(VehicleInfo[i][VEHICLE_ID]);
     		if(vehicleused || IsAnyPlayerNearStreamVehicle(i,VIEW_DISTANCE))
	        {
	            LoadVehicle(i);
	            if(VehicleInfo[i][VEHICLE_ID])
				{
	                GetVehiclePos(VehicleInfo[i][VEHICLE_ID],VehicleInfo[i][CURRENT_POS][0],VehicleInfo[i][CURRENT_POS][1],VehicleInfo[i][CURRENT_POS][2]);
					if(vehicleused)
						GetVehicleZAngle(VehicleInfo[i][VEHICLE_ID],VehicleInfo[i][CURRENT_POS][3]);
				}
			}
			else
			{
				if(VehicleInfo[i][VEHICLE_ID])
				{
        			GetVehiclePos(VehicleInfo[i][VEHICLE_ID],VehicleInfo[i][CURRENT_POS][0],VehicleInfo[i][CURRENT_POS][1],VehicleInfo[i][CURRENT_POS][2]);
				    GetVehicleHealth(VehicleInfo[i][VEHICLE_ID],VehicleInfo[i][HEALTH]);
					DestroyVehicle(VehicleInfo[i][VEHICLE_ID]);
					VehicleStreamID[VehicleInfo[i][VEHICLE_ID]]=INVALID_STREAM_ID;
				    VehicleInfo[i][VEHICLE_ID]=0;
				    VehicleCount--;
				}
			}
			
			if(vehicleused)
			    VehicleInfo[i][RESPAWNING]=VehicleInfo[i][RESPAWN_DELAY];
			else if(VehicleInfo[i][RESPAWNING])
			{
			    VehicleInfo[i][RESPAWNING]--;
			    if(!VehicleInfo[i][RESPAWNING])
			        SetStreamVehicleToRespawn(i);
			}
	    }
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid,vehicleid,ispassenger)
	return CallRemoteFunction("OnPlayerEnterStreamVehicle","iii",playerid,GetVehicleStreamID(vehicleid),ispassenger);

public OnPlayerExitVehicle(playerid,vehicleid)
{
	new svehicleid=GetVehicleStreamID(vehicleid);
	GetPlayerPos(playerid,VehicleInfo[svehicleid][CURRENT_POS][0],VehicleInfo[svehicleid][CURRENT_POS][1],VehicleInfo[svehicleid][CURRENT_POS][2]);
	return CallRemoteFunction("OnPlayerExitStreamVehicle","ii",playerid,svehicleid);
}

public OnVehicleSpawn(vehicleid)
	return SetStreamVehicleToRespawn(GetVehicleStreamID(vehicleid));

public OnVehicleDeath(vehicleid, killerid)
{
    SetTimerEx("SetStreamVehicleToRespawn",3000,0,"i",GetVehicleStreamID(vehicleid));
	return CallRemoteFunction("OnStreamVehicleDeath","ii",GetVehicleStreamID(vehicleid),killerid);
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	for(new i=0;i<MAX_COMPONENTS;i++)
	{
	    if(!VehicleInfo[GetVehicleStreamID(vehicleid)][COMPONENTS][i])
	    {
	        VehicleInfo[GetVehicleStreamID(vehicleid)][COMPONENTS][i]=componentid;
	        break;
		}
	}

	return CallRemoteFunction("OnStreamVehicleMod","iii",playerid,GetVehicleStreamID(vehicleid),componentid);
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
    VehicleInfo[GetVehicleStreamID(vehicleid)][PAINTJOB]=paintjobid;
    return CallRemoteFunction("OnStreamVehiclePaintjob","iii",playerid,GetVehicleStreamID(vehicleid),paintjobid);
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	VehicleInfo[GetVehicleStreamID(vehicleid)][CURRENT_COLORS][0]=color1;
	VehicleInfo[GetVehicleStreamID(vehicleid)][CURRENT_COLORS][1]=color2;
    return CallRemoteFunction("OnStreamVehicleRespray","iiii",playerid,GetVehicleStreamID(vehicleid),color1,color2);
}

forward SetStreamVehicleToRespawn(svehicleid);
public SetStreamVehicleToRespawn(svehicleid)
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
	{
	    if(VehicleInfo[svehicleid][CREATED])
        {
            if(VehicleInfo[svehicleid][VEHICLE_ID])
            {
                DestroyVehicle(VehicleInfo[svehicleid][VEHICLE_ID]);
			  	VehicleInfo[svehicleid][VEHICLE_ID]=0;
			  	VehicleCount--;
            }
            
            VehicleInfo[svehicleid][HEALTH]=1000;
		    VehicleInfo[svehicleid][PAINTJOB]=0;
		    VehicleInfo[svehicleid][RESPAWNING]=0;

		    for(new i=0;i<MAX_COMPONENTS;i++)
		        VehicleInfo[svehicleid][COMPONENTS][i]=0;

			for(new i=0;i<4;i++)
			    VehicleInfo[svehicleid][CURRENT_POS][i]=VehicleInfo[svehicleid][SPAWN_POS][i];
		    VehicleInfo[svehicleid][CURRENT_COLORS][0]=VehicleInfo[svehicleid][SPAWN_COLORS][0];
		    VehicleInfo[svehicleid][CURRENT_COLORS][1]=VehicleInfo[svehicleid][SPAWN_COLORS][1];
			return CallRemoteFunction("OnStreamVehicleSpawn","i",svehicleid);
        }
	}
	return 0;
}

forward LinkStreamVehicleToInterior(svehicleid,interiorid);
public LinkStreamVehicleToInterior(svehicleid,interiorid)
{
	if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
	{
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        if(VehicleInfo[svehicleid][VEHICLE_ID])
	            LinkVehicleToInterior(VehicleInfo[svehicleid][VEHICLE_ID],interiorid);
	        VehicleInfo[svehicleid][INTERIOR]=interiorid;
	        return 1;
	    }
	}
	return 0;
}

forward SetStreamVehicleVirtualWorld(svehicleid,worldid);
public SetStreamVehicleVirtualWorld(svehicleid,worldid)
{
	if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
	{
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        if(VehicleInfo[svehicleid][VEHICLE_ID])
	            SetVehicleVirtualWorld(VehicleInfo[svehicleid][VEHICLE_ID],worldid);
	        VehicleInfo[svehicleid][WORLD]=worldid;
	        return 1;
	    }
	}
	return 0;
}

forward GetStreamVehicleVirtualWorld(svehicleid);
public GetStreamVehicleVirtualWorld(svehicleid)
{
	if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
	    if(VehicleInfo[svehicleid][CREATED])
			return VehicleInfo[svehicleid][WORLD];
	return 0;
}

forward GetStreamVehicleHealth(svehicleid, &Float:health);
public GetStreamVehicleHealth(svehicleid, &Float:health)
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
    {
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        if(VehicleInfo[svehicleid][VEHICLE_ID])
				GetVehicleHealth(VehicleInfo[svehicleid][VEHICLE_ID],health);
			else
			    health=VehicleInfo[svehicleid][HEALTH];
			return 1;
	    }
	}
	return 0;
}

forward SetStreamVehicleHealth(svehicleid,Float:health);
public SetStreamVehicleHealth(svehicleid,Float:health)
{
	if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
	{
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        if(VehicleInfo[svehicleid][VEHICLE_ID])
	            SetVehicleHealth(VehicleInfo[svehicleid][VEHICLE_ID],health);
	        VehicleInfo[svehicleid][HEALTH]=health;
	        return 1;
	    }
	}
	return 0;
}

forward AddStreamVehicleComponent(svehicleid,componentid);
public AddStreamVehicleComponent(svehicleid,componentid)
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
	{
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        for(new i=0;i<MAX_COMPONENTS;i++)
			{
			    if(!VehicleInfo[svehicleid][COMPONENTS][i])
			    {
			        if(VehicleInfo[svehicleid][VEHICLE_ID])
	            		AddVehicleComponent(VehicleInfo[svehicleid][VEHICLE_ID],componentid);
			        VehicleInfo[svehicleid][COMPONENTS][i]=componentid;
			        return 1;
				}
			}
	    }
	}
	return 0;
}

forward RemoveStreamVehicleComponent(svehicleid,componentid);
public RemoveStreamVehicleComponent(svehicleid,componentid)
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
	{
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        for(new i=0;i<MAX_COMPONENTS;i++)
   				if(VehicleInfo[svehicleid][COMPONENTS][i]==componentid)
			        VehicleInfo[svehicleid][COMPONENTS][i]=0;
			return RemoveVehicleComponent(VehicleInfo[svehicleid][VEHICLE_ID],componentid);
	    }
	}
	return 0;
}

forward GetStreamVehicleModel(svehicleid);
public GetStreamVehicleModel(svehicleid)
{
	if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
	    if(VehicleInfo[svehicleid][CREATED])
			return VehicleInfo[svehicleid][MODEL];
	return 0;
}

forward SetStreamVehicleModel(svehicleid,modelid);
public SetStreamVehicleModel(svehicleid,modelid)
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
    {
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        if(VehicleInfo[svehicleid][VEHICLE_ID])
	        {
	            //Prevent passenger crash for DestroyVehicle
	            new Float:x,Float:y,Float:z;
	            for(new i=0;i<MAX_PLAYERS;i++)
	                if(GetPlayerPos(i,x,y,z))
	                    if(GetPlayerVehicleID(i)==VehicleInfo[svehicleid][VEHICLE_ID])
	                        SetPlayerPos(i,x,y,z+2);
	                        
				DestroyVehicle(VehicleInfo[svehicleid][VEHICLE_ID]);
			  	VehicleInfo[svehicleid][VEHICLE_ID]=0;
			  	VehicleCount--;
			  	
				VehicleInfo[svehicleid][PAINTJOB]=0;
				for(new i=0;i<MAX_COMPONENTS;i++)
    				VehicleInfo[svehicleid][COMPONENTS][i]=0;
	        }

			CallRemoteFunction("OnStreamVehicleModelChange","");
	        VehicleInfo[svehicleid][MODEL]=modelid;
	        return 1;
	    }
	}
	return 0;
}

forward GetVehicleStreamID(vehicleid);
public GetVehicleStreamID(vehicleid)
{
	return VehicleStreamID[vehicleid];
}

forward GetStreamVehicleVehicleID(svehicleid);
public GetStreamVehicleVehicleID(svehicleid)
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
	    if(VehicleInfo[svehicleid][CREATED])
			return VehicleInfo[svehicleid][VEHICLE_ID];
	return 0;
}

forward GetPlayerStreamVehicleID(playerid);
public GetPlayerStreamVehicleID(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
		return VehicleStreamID[GetPlayerVehicleID(playerid)];
	return INVALID_STREAM_ID;
}

forward ChangeStreamVehicleColor(svehicleid,color1,color2);
public ChangeStreamVehicleColor(svehicleid,color1,color2)
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
    {
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        if(VehicleInfo[svehicleid][VEHICLE_ID])
	            ChangeVehicleColor(VehicleInfo[svehicleid][VEHICLE_ID],color1,color2);
            VehicleInfo[svehicleid][CURRENT_COLORS][0]=color1;
            VehicleInfo[svehicleid][CURRENT_COLORS][1]=color2;
            return 1;
	    }
	}
	return 0;
}

forward ChangeStreamVehiclePaintjob(svehicleid,paintjobid);
public ChangeStreamVehiclePaintjob(svehicleid,paintjobid)
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
    {
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        if(VehicleInfo[svehicleid][VEHICLE_ID])
	            ChangeVehiclePaintjob(VehicleInfo[svehicleid][VEHICLE_ID],paintjobid);
            VehicleInfo[svehicleid][PAINTJOB]=paintjobid;
            return 1;
	    }
	}
	return 0;
}

forward GetStreamVehiclePos(svehicleid, &Float:x, &Float:y, &Float:z);
public GetStreamVehiclePos(svehicleid, &Float:x, &Float:y, &Float:z)
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
    {
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        if(VehicleInfo[svehicleid][VEHICLE_ID])
	            GetVehiclePos(VehicleInfo[svehicleid][VEHICLE_ID],x,y,z);
			else
			{
			    x=VehicleInfo[svehicleid][CURRENT_POS][0];
			    y=VehicleInfo[svehicleid][CURRENT_POS][1];
			    z=VehicleInfo[svehicleid][CURRENT_POS][2];
			}
            return 1;
	    }
	}
	return 0;
}

forward GetStreamVehicleZAngle(svehicleid, &Float:z_angle);
public GetStreamVehicleZAngle(svehicleid, &Float:z_angle)
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
    {
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        z_angle=VehicleInfo[svehicleid][CURRENT_POS][3];
            return 1;
	    }
	}
	return 0;
}

forward SetStreamVehiclePos(svehicleid, Float:x, Float:y, Float:z);
public SetStreamVehiclePos(svehicleid, Float:x, Float:y, Float:z)
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
    {
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        if(VehicleInfo[svehicleid][VEHICLE_ID])
	        {
	            if(IsAnyPlayerInVehicle(VehicleInfo[svehicleid][VEHICLE_ID]))
		            SetVehiclePos(VehicleInfo[svehicleid][VEHICLE_ID],x,y,z);
				else
				{
				    GetVehicleHealth(VehicleInfo[svehicleid][VEHICLE_ID],VehicleInfo[svehicleid][HEALTH]);
					DestroyVehicle(VehicleInfo[svehicleid][VEHICLE_ID]);
					VehicleStreamID[VehicleInfo[svehicleid][VEHICLE_ID]]=INVALID_STREAM_ID;
				    VehicleInfo[svehicleid][VEHICLE_ID]=0;
				    VehicleCount--;
				}
	        }
			VehicleInfo[svehicleid][CURRENT_POS][0]=x;
		    VehicleInfo[svehicleid][CURRENT_POS][1]=y;
		    VehicleInfo[svehicleid][CURRENT_POS][2]=z;
            return 1;
	    }
	}
	return 0;
}

forward SetStreamVehicleZAngle(svehicleid, Float:z_angle);
public SetStreamVehicleZAngle(svehicleid, Float:z_angle)
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
    {
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        if(VehicleInfo[svehicleid][VEHICLE_ID])
	            SetVehicleZAngle(VehicleInfo[svehicleid][VEHICLE_ID],z_angle);
			VehicleInfo[svehicleid][CURRENT_POS][3]=z_angle;
            return 1;
	    }
	}
	return 0;
}

forward PutPlayerInStreamVehicle(playerid, svehicleid, seatid);
public PutPlayerInStreamVehicle(playerid, svehicleid, seatid)
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
    {
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        if(VehicleInfo[svehicleid][VEHICLE_ID])
	            PutPlayerInVehicle(playerid,VehicleInfo[svehicleid][VEHICLE_ID],seatid);
			else
			{
			    new vehicleid=LoadVehicle(svehicleid);
			    if(vehicleid)
				{
				    PutPlayerInVehicle(playerid,vehicleid,seatid);
				    return 1;
				}
			}
	    }
	}
	return 0;
}

forward SetStreamVehicleParamsForPlayer(svehicleid,playerid,objective,doorslocked);
public SetStreamVehicleParamsForPlayer(svehicleid,playerid,objective,doorslocked)
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
    {
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        VehicleParams[svehicleid][0][playerid]=objective;
	        VehicleParams[svehicleid][1][playerid]=doorslocked;
	        if(VehicleInfo[svehicleid][VEHICLE_ID])
	            SetVehicleParamsForPlayer(VehicleInfo[svehicleid][VEHICLE_ID],playerid,objective,doorslocked);
			return 1;
	    }
	}
	return 0;
}

forward SetStreamVehicleNumberPlate(svehicleid, numberplate[]);
public SetStreamVehicleNumberPlate(svehicleid, numberplate[])
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
    {
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        format(VehicleInfo[svehicleid][NUMBERPLATE],N_SIZE,numberplate);
	        if(VehicleInfo[svehicleid][VEHICLE_ID] && strlen(numberplate))
	            SetVehicleNumberPlate(VehicleInfo[svehicleid][VEHICLE_ID],VehicleInfo[svehicleid][NUMBERPLATE]);
			return 1;
	    }
	}
	return 0;
}

forward GetStreamVehicleNumberPlate(svehicleid,numberplate[],size);
public GetStreamVehicleNumberPlate(svehicleid,numberplate[],size)
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
	    if(VehicleInfo[svehicleid][CREATED])
	       	return format(numberplate,size,VehicleInfo[svehicleid][NUMBERPLATE]);
	return 0;
}

forward GetStreamVehicleColors(svehicleid,&color1,&color2);
public GetStreamVehicleColors(svehicleid,&color1,&color2)
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
    {
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	       	color1=VehicleInfo[svehicleid][CURRENT_COLORS][0];
	       	color2=VehicleInfo[svehicleid][CURRENT_COLORS][1];
			return 1;
	    }
	}
	return 0;
}

forward GetStreamVehiclePaintjob(svehicleid);
public GetStreamVehiclePaintjob(svehicleid)
{
    if(svehicleid>0 && svehicleid<MAX_STREAM_VEHICLES)
	    if(VehicleInfo[svehicleid][CREATED])
		    return VehicleInfo[svehicleid][PAINTJOB];
	return 0;
}

public OnGameModeInit()
{
	for(new i=0;i<MAX_VEHICLES;i++)
		VehicleStreamID[i]=INVALID_STREAM_ID;
	SetTimer("StreamVehicles",1000,true);
	return CallRemoteFunction("DOV_OnGameModeInit","");
}

#define vehicleid svehicleid

//Plug & Play
#define OnGameModeInit DOV_OnGameModeInit

#define CreateVehicle CreateStreamVehicle
#define AddStaticVehicle AddStaticStreamVehicle
#define AddStaticVehicleEx AddStaticStreamVehicleEx
#define DestroyVehicle DestroyStreamVehicle
#define OnPlayerEnterVehicle OnPlayerEnterStreamVehicle
#define OnPlayerExitVehicle OnPlayerExitStreamVehicle
#define OnVehicleDeathOnStreamVehicleDeath
#define OnVehicleModOnStreamVehicleMod
#define OnVehiclePaintjob OnStreamVehiclePaintjob
#define OnVehicleRespray OnStreamVehicleRespray
#define OnVehicleSpawn OnStreamVehicleSpawn
#define LinkVehicleToInterior LinkStreamVehicleToInterior
#define SetVehicleVirtualWorld SetStreamVehicleVirtualWorld
#define GetVehicleVirtualWorld GetStreamVehicleVirtualWorld
#define GetVehicleHealth GetStreamVehicleHealth
#define SetVehicleHealth SetStreamVehicleHealth
#define AddVehicleComponent AddStreamVehicleComponent
#define RemoveVehicleComponent RemoveVehicleComponent
#define GetVehicleModel GetStreamVehicleModel
#define SetVehicleModel SetStreamVehicleModel
#define GetPlayerVehicleID GetPlayerStreamVehicleID
#define ChangeVehicleColor ChangeStreamVehicleColor
#define ChangeVehiclePaintjob ChangeStreamVehiclePaintjob
#define GetVehiclePos GetStreamVehiclePos
#define GetVehicleZAngle GetStreamVehicleZAngle
#define SetVehiclePos SetStreamVehiclePos
#define SetVehicleZAngle SetStreamVehicleZAngle
#define PutPlayerInVehicle PutPlayerInStreamVehicle
#define SetVehicleParamsForPlayer SetStreamVehicleParamsForPlayer
#define SetVehicleNumberPlate SetStreamVehicleNumberPlate
#define GetVehicleNumberPlate GetStreamVehicleNumberPlate
#define GetVehicleColors GetStreamVehicleColors
#define GetVehiclePaintjob GetStreamVehiclePaintjob
#define OnVehicleModelChange OnStreamVehicleModelChange

#undef IsPosInDistance