#include <a_samp>

//$ region Vehicle-Streamer defines
#define MAX_STREAM_VEHICLES 2000
#define VIEW_DISTANCE 500
#define MAX_COMPONENTS 12
#define INVALID_STREAM_ID -1
#define N_SIZE 10
#define IsPosInDistance(%0,%1,%2,%3,%4,%5,%6) \ (((%0 - %3) * (%0 - %3)) + ((%1 - %4) * (%1 - %4)) + ((%2 - %5) * (%2 - %5)) <= %6 * %6)// BIG THX to Goldkiller

//$ endregion Vehicle-Streamer defines
//$ region Vehicle-Streamer forwards
forward OnPlayerExitStreamVehicle(playerid,svehicleid);
forward OnPlayerEnterStreamVehicle(playerid,svehicleid,ispassenger);
forward OnStreamVehicleSpawn(svehicleid);
forward OnStreamVehicleDeath(svehicleid, killerid);
forward OnStreamVehiclePaintjob(playerid, svehicleid, paintjobid);
forward OnStreamVehicleRespray(playerid, svehicleid, color1, color2);
forward OnStreamVehicleMod(playerid, svehicleid, componentid);

forward CreateStreamVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay);
forward DestroyStreamVehicle(svehicleid);
forward LoadVehicle(svehicleid);
forward StreamVehicles();
forward SetStreamVehicleToRespawn(svehicleid);
forward SetStreamVehicleVirtualWorld(svehicleid,worldid);
forward SetStreamVehicleToRespawn(svehicleid);
forward GetStreamVehicleVirtualWorld(svehicleid);
forward GetStreamVehicleHealth(svehicleid, &Float:health);
forward SetStreamVehicleHealth(svehicleid,Float:health);
forward AddStreamVehicleComponent(svehicleid,componentid);
forward RemoveStreamVehicleComponent(svehicleid,componentid);
forward GetVehicleStreamID(vehicleid);
forward GetStreamVehicleModel(svehicleid);
forward GetStreamVehicleVehicleID(svehicleid);
forward GetPlayerStreamVehicleID(playerid);
forward ChangeStreamVehicleColor(svehicleid,color1,color2);
forward ChangeStreamVehiclePaintjob(svehicleid,paintjobid);
forward GetStreamVehiclePos(svehicleid, &Float:x, &Float:y, &Float:z);
forward GetStreamVehicleZAngle(svehicleid, &Float:z_angle);
forward SetStreamVehiclePos(svehicleid, Float:x, Float:y, Float:z);
forward SetStreamVehicleZAngle(svehicleid, Float:z_angle);
forward PutPlayerInStreamVehicle(playerid, svehicleid, seatid);
forward SetStreamVehicleParamsForPlayer(svehicleid,playerid,objective,doorslocked);
forward SetStreamVehicleNumberPlate(svehicleid, numberplate[]);
forward GetStreamVehicleColors(svehicleid,&color1,&color2);
forward GetStreamVehiclePaintjob(svehicleid);
//$ endregion Vehicle-Streamer forwards

new VehicleInfo[MAX_STREAM_VEHICLES][VEHICLE_INFO];
new VehicleStreamID[MAX_VEHICLES];
new VehicleParams[MAX_STREAM_VEHICLES][2][MAX_PLAYERS];
new VehicleCount;

enum VEHICLE_INFO{
	CREATED,
	VEHICLE_ID,
	MODEL,
	Float:SPAWN_POS[4],
	Float:CURRENT_POS[4],
	INTERIOR,
	WORLD,
	COLORS[2],
	PAINTJOB,
	COMPONENTS[MAX_COMPONENTS],
	Float:HEALTH,
	RESPAWN_DELAY,
	NUMBERPLATE[N_SIZE]
}
//$ region Vehicle-Streamer
public CreateStreamVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay){
	for(new i=0;i<MAX_STREAM_VEHICLES;i++)
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
            VehicleInfo[i][CURRENT_POS][0]=x;
            VehicleInfo[i][CURRENT_POS][1]=y;
            VehicleInfo[i][CURRENT_POS][2]=z;
            VehicleInfo[i][CURRENT_POS][3]=rotation;
            VehicleInfo[i][INTERIOR]=0;
            VehicleInfo[i][WORLD]=0;
            VehicleInfo[i][COLORS][0]=color1;
            VehicleInfo[i][COLORS][0]=color2;
            VehicleInfo[i][RESPAWN_DELAY]=respawn_delay;
            VehicleInfo[i][HEALTH]=1000;
            VehicleInfo[i][PAINTJOB]=0;
			VehicleInfo[i][NUMBERPLATE][0]='\0';

            for(new j=0;j<MAX_COMPONENTS;j++)
                VehicleInfo[i][COMPONENTS][j]=0;

            for(new k=0;k<MAX_PLAYERS;k++)
			    VehicleParams[i][0][k]=VehicleParams[i][1][k]=0;
            return i;
	    }
	}
	return 0;
}
public DestroyStreamVehicle(svehicleid){
	if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
	{
	    if(VehicleInfo[svehicleid][CREATED])
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
stock IsAnyPlayerNearStreamVehicle(svehicleid,distance){
	new Float:x,Float:y,Float:z;
	for(new i=0;i<MAX_PLAYERS;i++)
	    if(GetPlayerPos(i,x,y,z))
	        if(IsPosInDistance(x,y,z,VehicleInfo[svehicleid][CURRENT_POS][0],VehicleInfo[svehicleid][CURRENT_POS][1],VehicleInfo[svehicleid][CURRENT_POS][2],distance)
				|| (IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i)==VehicleInfo[svehicleid][VEHICLE_ID]))
	            return true;
	return false;
}
public LoadVehicle(svehicleid){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
	{
	    if(!VehicleInfo[svehicleid][VEHICLE_ID] && VehicleCount<MAX_VEHICLES)
        {
            VehicleCount++;
        	VehicleInfo[svehicleid][VEHICLE_ID]=CreateVehicle(VehicleInfo[svehicleid][MODEL],
        	    VehicleInfo[svehicleid][CURRENT_POS][0],VehicleInfo[svehicleid][CURRENT_POS][1],VehicleInfo[svehicleid][CURRENT_POS][2],VehicleInfo[svehicleid][CURRENT_POS][3],
        	    VehicleInfo[svehicleid][COLORS][0],VehicleInfo[svehicleid][COLORS][1],VehicleInfo[svehicleid][RESPAWN_DELAY]);
			VehicleStreamID[VehicleInfo[svehicleid][VEHICLE_ID]]=svehicleid;
			SetVehicleHealth(VehicleInfo[svehicleid][VEHICLE_ID],VehicleInfo[svehicleid][HEALTH]);
			if(VehicleInfo[svehicleid][PAINTJOB])
			    ChangeVehiclePaintjob(VehicleInfo[svehicleid][VEHICLE_ID],VehicleInfo[svehicleid][PAINTJOB]);

			for(new i=0;i<MAX_COMPONENTS;i++)
			    if(VehicleInfo[svehicleid][COMPONENTS][i])
			        AddVehicleComponent(VehicleInfo[svehicleid][VEHICLE_ID],VehicleInfo[svehicleid][COMPONENTS][i]);

			SetVehicleVirtualWorld(VehicleInfo[svehicleid][VEHICLE_ID],VehicleInfo[svehicleid][WORLD]);
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
public StreamVehicles(){
	for(new i=0;i<MAX_STREAM_VEHICLES;i++)
	{
	    if(VehicleInfo[i][CREATED])
	    {
	        if(IsAnyPlayerNearStreamVehicle(i,VIEW_DISTANCE))
	        {
	            LoadVehicle(i);
	            if(VehicleInfo[i][VEHICLE_ID])
				{
	                GetVehiclePos(VehicleInfo[i][VEHICLE_ID],VehicleInfo[i][CURRENT_POS][0],VehicleInfo[i][CURRENT_POS][1],VehicleInfo[i][CURRENT_POS][2]);
					GetVehicleZAngle(VehicleInfo[i][VEHICLE_ID],VehicleInfo[i][CURRENT_POS][3]);
				}
			}
			else
			{
				if(VehicleInfo[i][VEHICLE_ID])
				{
				    GetVehiclePos(VehicleInfo[i][VEHICLE_ID],VehicleInfo[i][CURRENT_POS][0],VehicleInfo[i][CURRENT_POS][1],VehicleInfo[i][CURRENT_POS][2]);
				    GetVehicleZAngle(VehicleInfo[i][VEHICLE_ID],VehicleInfo[i][CURRENT_POS][3]);
				    GetVehicleHealth(VehicleInfo[i][VEHICLE_ID],VehicleInfo[i][HEALTH]);
					DestroyVehicle(VehicleInfo[i][VEHICLE_ID]);
					VehicleStreamID[VehicleInfo[i][VEHICLE_ID]]=INVALID_STREAM_ID;
				    VehicleInfo[i][VEHICLE_ID]=0;
				    VehicleCount--;
				}
			}
	    }
	}
	return 1;
}
public SetStreamVehicleToRespawn(svehicleid){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
	{
	    if(VehicleInfo[svehicleid][VEHICLE_ID] && VehicleInfo[svehicleid][CREATED])
        {
            VehicleInfo[svehicleid][HEALTH]=1000;
		    VehicleInfo[svehicleid][PAINTJOB]=0;

		    for(new i=0;i<MAX_COMPONENTS;i++)
		        VehicleInfo[svehicleid][COMPONENTS][i]=0;

		    VehicleInfo[svehicleid][CURRENT_POS]=VehicleInfo[svehicleid][SPAWN_POS];

			//For correct respawn:
		    DestroyVehicle(VehicleInfo[svehicleid][VEHICLE_ID]);
		  	VehicleInfo[svehicleid][VEHICLE_ID]=0;
		  	VehicleCount--;
		  	return CallLocalFunction("OnStreamVehicleSpawn","i",svehicleid);
        }
	}
	return 0;
}
public LinkStreamVehicleToInterior(svehicleid,interiorid){
	if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
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
public SetStreamVehicleVirtualWorld(svehicleid,worldid){
	if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
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
public GetStreamVehicleVirtualWorld(svehicleid){
	if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
	    if(VehicleInfo[svehicleid][CREATED])
			return VehicleInfo[svehicleid][WORLD];
	return 0;
}
public GetStreamVehicleHealth(svehicleid, &Float:health){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
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
public SetStreamVehicleHealth(svehicleid,Float:health){
	if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
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
public AddStreamVehicleComponent(svehicleid,componentid){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
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
public RemoveStreamVehicleComponent(svehicleid,componentid){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
	{
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        for(new i=0;i<MAX_COMPONENTS;i++)
			{
   				if(VehicleInfo[svehicleid][COMPONENTS][i]==componentid)
			    {
			        if(VehicleInfo[svehicleid][VEHICLE_ID])
	            		RemoveVehicleComponent(VehicleInfo[svehicleid][VEHICLE_ID],componentid);
			        VehicleInfo[svehicleid][COMPONENTS][i]=0;
			        return 1;
				}
			}
	    }
	}
	return 0;
}
public GetStreamVehicleModel(svehicleid){
	if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
	    if(VehicleInfo[svehicleid][CREATED])
			return VehicleInfo[svehicleid][MODEL];
	return 0;
}
public GetVehicleStreamID(vehicleid){
	return VehicleStreamID[vehicleid];
}
public GetStreamVehicleVehicleID(svehicleid){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
	    if(VehicleInfo[svehicleid][CREATED])
			return VehicleInfo[svehicleid][VEHICLE_ID];
	return 0;
}
public GetPlayerStreamVehicleID(playerid){
	if(IsPlayerInAnyVehicle(playerid))
		return VehicleStreamID[GetPlayerVehicleID(playerid)];
	return INVALID_STREAM_ID;
}
public ChangeStreamVehicleColor(svehicleid,color1,color2){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
    {
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        if(VehicleInfo[svehicleid][VEHICLE_ID])
	            ChangeVehicleColor(VehicleInfo[svehicleid][VEHICLE_ID],color1,color2);
            VehicleInfo[svehicleid][COLORS][0]=color1;
            VehicleInfo[svehicleid][COLORS][1]=color2;
            return 1;
	    }
	}
	return 0;
}
public ChangeStreamVehiclePaintjob(svehicleid,paintjobid){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
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
public GetStreamVehiclePos(svehicleid, &Float:x, &Float:y, &Float:z){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
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
public GetStreamVehicleZAngle(svehicleid, &Float:z_angle){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
    {
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        if(VehicleInfo[svehicleid][VEHICLE_ID])
	            GetVehicleZAngle(VehicleInfo[svehicleid][VEHICLE_ID],z_angle);
			else
			    z_angle=VehicleInfo[svehicleid][CURRENT_POS][3];
            return 1;
	    }
	}
	return 0;
}
public SetStreamVehiclePos(svehicleid, Float:x, Float:y, Float:z){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
    {
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	        if(VehicleInfo[svehicleid][VEHICLE_ID])
	            SetVehiclePos(VehicleInfo[svehicleid][VEHICLE_ID],x,y,z);
			VehicleInfo[svehicleid][CURRENT_POS][0]=x;
		    VehicleInfo[svehicleid][CURRENT_POS][1]=y;
		    VehicleInfo[svehicleid][CURRENT_POS][2]=z;
            return 1;
	    }
	}
	return 0;
}
public SetStreamVehicleZAngle(svehicleid, Float:z_angle){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
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
public PutPlayerInStreamVehicle(playerid, svehicleid, seatid){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
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
public SetStreamVehicleParamsForPlayer(svehicleid,playerid,objective,doorslocked){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
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
public SetStreamVehicleNumberPlate(svehicleid, numberplate[]){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
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
public GetStreamVehicleColors(svehicleid,&color1,&color2){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
    {
	    if(VehicleInfo[svehicleid][CREATED])
	    {
	       	color1=VehicleInfo[svehicleid][COLORS][0];
	       	color2=VehicleInfo[svehicleid][COLORS][1];
			return 1;
	    }
	}
	return 0;
}
public GetStreamVehiclePaintjob(svehicleid){
    if(svehicleid>=0 && svehicleid<MAX_STREAM_VEHICLES)
	    if(VehicleInfo[svehicleid][CREATED])
		    return VehicleInfo[svehicleid][PAINTJOB];
	return 0;
}
//$ endregion Vehicle-Streamer
DOV_OnGameModeInit(){
	for(new i=0;i<700;i++)
		VehicleStreamID[i]=INVALID_STREAM_ID;
	SetTimer("StreamVehicles",3000,true);
}
public OnPlayerEnterVehicle(playerid,vehicleid,ispassenger){
	return CallLocalFunction("OnPlayerEnterStreamVehicle","iii",playerid,GetVehicleStreamID(vehicleid),ispassenger);
}
public OnPlayerExitVehicle(playerid,vehicleid){
	GetPlayerPos(playerid,VehicleInfo[GetVehicleStreamID(vehicleid)][CURRENT_POS][0],
		VehicleInfo[GetVehicleStreamID(vehicleid)][CURRENT_POS][1],VehicleInfo[GetVehicleStreamID(vehicleid)][CURRENT_POS][2]);
	return CallLocalFunction("OnPlayerExitStreamVehicle","ii",playerid,GetVehicleStreamID(vehicleid));
}
public OnVehicleSpawn(vehicleid){
	return SetStreamVehicleToRespawn(GetVehicleStreamID(vehicleid));
}
public OnVehicleDeath(vehicleid, killerid){
    SetTimerEx("SetStreamVehicleToRespawn",3000,0,"i",GetVehicleStreamID(vehicleid));
	return CallLocalFunction("OnStreamVehicleDeath","ii",GetVehicleStreamID(vehicleid),killerid);
}
public OnVehicleMod(playerid, vehicleid, componentid){
	for(new i=0;i<MAX_COMPONENTS;i++)
	{
	    if(!VehicleInfo[GetVehicleStreamID(vehicleid)][COMPONENTS][i])
	    {
	        VehicleInfo[GetVehicleStreamID(vehicleid)][COMPONENTS][i]=componentid;
	        break;
		}
	}

	return CallLocalFunction("OnStreamVehicleMod","iii",playerid,GetVehicleStreamID(vehicleid),componentid);
}
public OnVehiclePaintjob(playerid, vehicleid, paintjobid){
    VehicleInfo[GetVehicleStreamID(vehicleid)][PAINTJOB]=paintjobid;
    return CallLocalFunction("OnStreamVehiclePaintjob","iii",playerid,GetVehicleStreamID(vehicleid),paintjobid);
}
public OnVehicleRespray(playerid, vehicleid, color1, color2){
	/*
	VehicleInfo[GetVehicleStreamID(vehicleid)[COLORS][0]=color1;
	VehicleInfo[GetVehicleStreamID(vehicleid)[COLORS][1]=color2
	*/
    return CallLocalFunction("OnStreamVehicleRespray","iiii",playerid,GetVehicleStreamID(vehicleid),color1,color2);
}

#undef IsPosInDistance