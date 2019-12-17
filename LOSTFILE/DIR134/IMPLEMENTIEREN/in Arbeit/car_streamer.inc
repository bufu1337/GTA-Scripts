#include <a_samp>

//THIS IS WHAT U CAN CHANGE!////
#define MAX_CARS 1500/////////// Maximum of Streamable Cars
#define CAR_RANGE 250.0///////// Range of Car Viewing
#define MAX_TUNINGS 20////////// Maximum of Tunings for one Car
#define CAR_INTERVAL 2500/////// Intreval of Refreshing in ms
///////DON'T CHANGE MORE////////


#define CAR_PARAMS 3
#define CARMODEL 0
#define CARCOLOR1 1
#define CARCOLOR2 2

#define CARX 0
#define CARY 1
#define CARZ 2
#define CARROT 3
#define CARHEALTH 4

/*
native CreateStreamCar(modelid, Float:x, Float:y, Float:z,Float:r, color1, color2);
native SetStreamCarSpawn(streamid, Float:x, Float:y,Float:z,Float:r);
native SetStreamCarPos(streamid, Float:x, Float:y, Float:z);
native SetStreamCarAngle(streamid, Float:r);
native SetStreamCarColor(streamid,color1,color2);
native SetStreamCarParamsForPlayer(streamid, playerid, doorslocked);
native CarStream_OnGameModeInit();
native CarStream_OnPlayerDisconnect(playerid);
native CarStream_OnPlayerExitVehicle(playerid,vehicleid);
native GetPlayerStreamCarID(playerid);
native GetStreamCarHealth(streamid, &Float:health);
native GetStreamCarModel(streamid);
native IsValidStreamCar(streamid);
native GetStreamCarPos(streamid, &Float:x, &Float:y, &Float:z);
native GetStreamCarAngle(streamid, &Float:angle);
native IsPlayerInStreamCar(playerid, streamid);
native SetStreamCarToRespawn(streamid);
native AddStreamCarComponent(streamid, componentid);
native RemoveStreamCarComponent(streamid, componentid);
native IsAnyPlayerNearStreamCar(streamid);
native AttachStreamTrailerToCar(streamtrailerid, streamcarid);
native GetStreamCarTrailer(streamcarid);
native DetachStreamTrailerFromCar(streamtrailerid, streamcarid);
native PutPlayerInStreamCar(playerid, streamcarid, seatid);
native GetStreamCarCurrentVehicleID(streamcarid);
native GetStreamCarWithVehicleID(vehicleid);
native IsStreamCarActive(streamcarid);
native DestroyStreamCar(streamcarid);
*/

new cars[MAX_CARS][CAR_PARAMS];
new Float:carpos[MAX_CARS][5];
new Float:lastpos[MAX_CARS][5];
new locked[MAX_CARS][MAX_PLAYERS];
new Tunings[MAX_CARS][MAX_TUNINGS];
new actual=0;
new currentid[MAX_CARS]=-1;
new IsActive[MAX_CARS]=0;
new active=0;
new models[212]=0;
forward check();
stock CreateStreamCar(modelid, Float:x, Float:y, Float:z,Float:r, color1, color2)
{
	carpos[actual][CARX]=x;
	carpos[actual][CARY]=y;
	carpos[actual][CARZ]=z;
	carpos[actual][CARROT]=r;
	lastpos[actual][CARX]=x;
	lastpos[actual][CARY]=y;
	lastpos[actual][CARZ]=z;
	lastpos[actual][CARROT]=r;
	lastpos[actual][CARHEALTH]=1000.0;
	cars[actual][CARMODEL]=modelid;
	carpos[actual][CARHEALTH]=1000.0;
	cars[actual][CARCOLOR1]=color1;
	cars[actual][CARCOLOR2]=color2;
	actual++;
	return actual-1;
}

stock SetStreamCarSpawn(streamid, Float:x, Float:y,Float:z,Float:r)
{
	carpos[streamid][CARX]=x;
	carpos[streamid][CARY]=y;
	carpos[streamid][CARZ]=z;
	carpod[streamid][CARROT]=r;
}

stock SetStreamCarPos(streamid, Float:x, Float:y, Float:z)
{
	if(IsActive[streamid]==1)
	{
		SetVehiclePos(currentid[streamid], x, y, z);
	}
	else
	{
	    lastpos[streamid][CARX]=x;
	    lastpos[streamid][CARY]=y;
	    lastpos[streamid][CARZ]=z;
	}

}

stock SetStreamCarAngle(streamid, Float:r)
{
	if(IsActive[streamid]==1)
	{
		SetVehicleAngle(currentid[streamid],r);
	}
	else lastpos[streamid][CARROT]=r;
}

stock SetStreamCarColor(streamid,color1,color2)
{
	cars[streamid][CARCOLOR1]=color1;
	cars[streamid][CARCOLOR2]=color2;
	if(IsActive[streamid]==1)	ChangeVehicleColor(currentid[streamid], color1, color2);
}

stock SetStreamCarParamsForPlayer(streamid, playerid, doorslocked)
{
 	locked[streamid][playerid]=doorslocked;
 	if(IsActive[streamid]==1)   SetVehicleParamsForPlayer(currentid[streamid], playerid, 0, doorslocked);
}

public check()
{
    for(new o;o<MAX_CARS;o++)
    {
    if(carpos[o][CARX]!=0.0)
	{
	    if(IsAnyPlayerNearStreamCar(o))
	    {
     		if(IsActive[o]==0)
    		{
    		    if(active<MAX_VEHICLES)
    		    {
    		    new mod;
				for(new i;i<212;i++)
				{
				    if(models[i]>0)
				    {
				        mod++;
					}
				}
				if(mod<70)
				{
        	   	new id=CreateVehicle(cars[o][CARMODEL], lastpos[o][CARX],lastpos[o][CARY],lastpos[o][CARZ], lastpos[o][CARROT], cars[o][CARCOLOR1], cars[o][CARCOLOR2],-1);
        	   	SetVehicleHealth(id, lastpos[o][CARHEALTH]);
       	       	IsActive[o]=1;
       	       	currentid[o]=id;
				active++;
 				models[cars[o][CARMODEL]-400]--;
				for (new l;l<MAX_PLAYERS;l++)
				{
				    SetVehicleParamsForPlayer(id, l, 0, locked[o][l]);
				}
				for (new t;t<MAX_TUNINGS;t++)
				{
					if(Tunings[o][t]!=0)    AddVehicleComponent(currentid[o], Tunings[o][t]);
				}
				}
				}
			}
		}
		if(IsActive[o]==1)
		{
			if(!IsAnyPlayerInVehicle(currentid[o]))
			{
				if(!IsAnyPlayerNearStreamCar(o))
				{
				   	GetVehiclePos(currentid[o], lastpos[o][CARX],lastpos[o][CARY],lastpos[o][CARZ]);
					GetVehicleZAngle(currentid[o],lastpos[o][CARROT]);
					GetVehicleHealth(currentid[o], lastpos[o][CARHEALTH]);
					DestroyVehicle(currentid[o]);
					IsActive[o]=0;
					currentid[o]=-1;
					active--;
					models[cars[o][CARMODEL]-400]--;
				}
			}
		}
	}
	}
	return 1;
}

stock CarStream_OnPlayerDisconnect(playerid)
{
	for(new i;i<MAX_CARS;i++)
 	{
		locked[i][playerid]=0;
	}
}

stock CarStream_OnGameModeInit()
{
	SetTimer("check", CAR_INTERVAL, true);
}

stock CarStream_OnPlayerExitVehicle(playerid,vehicleid)
{
	new Float:x;
	new Float:y;
	new Float:z;
	new Float:r;
	GetVehiclePos(vehicleid, x,y,z);
	GetVehicleZAngle(vehicleid,r);
	for (new i;i<MAX_CARS;i++)
	{
	    if(currentid[i]==vehicleid)
	    {
	        lastpos[i][CARX]=x;
	        lastpos[i][CARY]=y;
	        lastpos[i][CARZ]=z;
     	    lastpos[i][CARROT]=r;
     	    GetVehicleHealth(vehicleid, lastpos[i][CARHEALTH]);
		}
	}
	return playerid;
}

stock CarStream_OnVehicleDeath(vehicleid)
{
	for (new i;i<MAX_CARS;i++)
	{
	    if(currentid[i]==vehicleid)
	    {
	        lastpos[i][CARX]=carpos[i][CARX];
	        lastpos[i][CARY]=carpos[i][CARY];
	        lastpos[i][CARZ]=carpos[i][CARZ];
	        lastpos[i][CARHEALTH]=1000.0
		}
	}
}


stock GetPlayerStreamCarID(playerid)
{
	new vid=GetPlayerVehicleID(playerid);
	for(new i;i<MAX_CARS;i++)
	{
		if(currentid[i]==vid)
		{
		    return i;
		}
	}
	return -1;
 }

stock GetStreamCarHealth(streamid, &Float:health)
{
	if(IsActive[streamid]==1)	GetVehicleHealth(currentid[streamid], health);
	else health = lastpos[streamid][CARHEALTH];
}

stock GetStreamCarModel(streamid)
{
	return cars[streamid][CARMODEL];
}

stock IsValidStreamCar(streamid)
{
	if(lastpos[streamid][CARX]!=0.0)
	{
	    return true;
	}
	return false;
}

stock GetStreamCarPos(streamid, &Float:x, &Float:y, &Float:z)
{
	if(IsActive[streamid]==1)
	{
	    GetVehiclePos(currentid[streamid],x,y,z);
	}
	else
	{
	    x=lastpos[streamid][CARX];
	    y=lastpos[streamid][CARY];
	    z=lastpos[streamid][CARZ];
	}
}

stock GetStreamCarAngle(streamid, &Float:angle)
{
	if(IsActive[streamid]==1)
	{
	    GetVehicleZAngle(currentid[streamid], angle);
	}
	else angle=lastpos[streamid][CARX];
}

stock IsPlayerInStreamCar(playerid, streamid)
{
	if(IsActive[streamid]==1)
	{
	    if(IsPlayerInVehicle(playerid, currentid[streamid]) return true;
	}
	return false;
}


stock SetStreamCarToRespawn(streamid)
{
	lastpos[streamid][CARX]=carpos[streamid][CARX];
    lastpos[streamid][CARY]=carpos[streamid][CARY];
    lastpos[streamid][CARZ]=carpos[streamid][CARZ];
	lastpos[streamid][CARHEALTH]=1000.0
}

stock AddStreamCarComponent(streamid, componentid)
{
	if(IsValidStreamCar(streamid))
	{
	    if(IsActive[streamid])   AddVehicleComponent(currentid[streamid], componentid);
	}
	for (new i;i<MAX_TUNINGS;i++)
	{
		if(Tunings[streamid][i]==componentid)   return 1;
	}
	for (new i;i<MAX_TUNINGS;i++)
	{
		if(Tunings[streamid][i]==0)
		{
		    Tunings[streamid][i]=componentid;
		    return 1;
		}
	}
	return 1;
}

stock RemoveStreamCarComponent(streamid, componentid)
{
	if(IsValidStreamCar(streamid))
	{
	    if(IsActive[streamid])  RemoveVehicleComponent(currentid[streamid], componentid);
	    for (new i;i<MAX_TUNINGS;i++)
	    {
	        if(Tunings[streamid][i]==componentid)   Tunings[streamid][i]=0;
		}
	}
}
stock PlayerToPoint(playerid, Float:x, Float:y, Float:z,Float:radi)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

stock IsAnyPlayerInVehicle(vehicleid)
{
    for (new i = 0; i != 200; i ++)
    	if (IsPlayerInVehicle(i, vehicleid)) return 1;
    return 0;
}
stock IsAnyPlayerNearStreamCar(streamid)
{
	for(new i;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
      	if(PlayerToPoint(i, lastpos[streamid][CARX],lastpos[streamid][CARY],lastpos[streamid][CARZ],CAR_RANGE))
      	{
      	    return true;
		}
		}
	}
	return false;
}

stock AttachStreamTrailerToCar(streamtrailerid, streamcarid)
{
	if(IsActive[streamcarid] && IsActive[streamtrailerid])
	{
	    AttachTrailerToVehicle(currentid[streamtrailerid], currentid[streamcarid]);
	}
}

stock GetStreamCarTrailer(streamcarid)
{
	if(IsActive[streamcarid] && IsTrailerAttachedToVehicle(currentid[streamcarid]))
	{
		new rettun = GetStreamCarWithVehicleID(GetVehicleTrailer(currentid[streamcarid]));
		if(IsActive[rettun]) return rettun;
	}
	return -1;
}

stock DetachStreamTrailerFromCar(streamtrailerid, streamcarid)
{
	if(IsActive[streamcarid] && IsActive[streamtrailerid])
	{
	    DetachTrailerFromVehicle(currentid[streamtrailerid], currentid[streamcarid]);
	}
}

stock PutPlayerInStreamCar(playerid, streamcarid, seatid)
{
	if(IsActive[streamcarid])
	{
	    PutPlayerInVehicle(playerid, currentid[streamcarid],seatid);
	}
	else
	{
	    if(IsValidStreamCar(streamcarid))
	    {
        	   	new id=CreateVehicle(cars[streamcarid][CARMODEL], lastpos[streamcarid][CARX],lastpos[streamcarid][CARY],lastpos[streamcarid][CARZ], lastpos[streamcarid][CARROT], cars[streamcarid][CARCOLOR1], cars[streamcarid][CARCOLOR2],-1);
        	   	SetVehicleHealth(id, lastpos[streamcarid][CARHEALTH]);
       	       	currentid[streamcarid]=id;
				active++;
 				models[cars[streamcarid][CARMODEL]-400]--;
				for (new l;l<MAX_PLAYERS;l++)
				{
				    SetVehicleParamsForPlayer(id, l, 0, locked[streamcarid][l]);
				}
				for (new t;t<MAX_TUNINGS;t++)
				{
					if(Tunings[streamcarid][t]!=0)    AddVehicleComponent(currentid[streamcarid], Tunings[streamcarid][t]);
				}
				PutPlayerInVehicle(playerid, currentid[streamcarid],seatid);
				IsActive[streamcarid]=1;
		}
	}
}

stock GetStreamCarCurrentVehicleID(streamcarid)
{
	if(IsActive[streamcarid])
	{
		return currentid[streamcarid];
	}
	return -1;
}

stock GetStreamCarWithVehicleID(vehicleid)
{
	for(new i;i<MAX_CARS;i++)
	{
	    if(IsActive[i]){
	    	if(vehicleid==currentid[i]) return i;
		}
	}
	return -1;
}
 
stock IsStreamCarActive(streamcarid)
{
	return IsActive[streamcarid];
 }
stock DestroyStreamCar(streamcarid)
{
	carpos[streamcarid][CARX]=0.0;
	lastpos[streamcarid][CARX]=0.0;
	if(IsStreamCarActive(streamcarid))
	{
	    DestroyVehicle(currentid[streamcarid]);
 	}
}