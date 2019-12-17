/*
This code was designed to allow users to have a larger number of vehicle spawns in their script than
sa-mp will normally allow. The script will allow you to have in theory up to 9999 vehicle
spawns in your gamemode but only 700 of these can be active at any one point simultaneously...basically the script
will only create vehicles if there is somebody around to see them.

The default distance it will spawn a car for u is set at 100 meters but you can change that very simply by changing
SPAWN_DISTANCE

In order to add streaming vehicle spawns u must add your vehicle spawns into this fs under OnFilterscriptInit using:

AddStreamingVehicle(modelid,x,y,z,angle,color1,color2);

rather than addstaticvehicle.

This script and all code contained within was designed by <tAxI> and is released to the public as freeware.
Any attempts to claim this code as your own will not be taken lightly so don't even try it :-P

HOPE U ALL LIKE IT...ENJOY!!!!

<tAxI>

*/

#include <a_samp>

#define SPAWN_DISTANCE 150
#define MAX_ACTIVE_VEHICLES 675
#define MODEL_LIMIT 212
#define MAX_ACTIVE_MODELS 65

forward proxcheck();

new modelcount[MODEL_LIMIT];
new vehcount = 0;
new streamcount = 0;
new vehused[MAX_ACTIVE_VEHICLES];

enum vInfo
{
	model,
	Float:x_spawn,
	Float:y_spawn,
	Float:z_spawn,
 	Float:za_spawn,
 	color_1,
 	color_2,
	spawned,
	idnum,
};
new VehicleInfo[9999][vInfo];

public OnFilterScriptInit()
{
	SetTimer("proxcheck",1000,1);
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
		SetTimerEx("DeactivateStreamedVehicle",6000,0,"x",vehicleid);
		return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	vehused[vehicleid] = 1;
	return 1;
}

public proxcheck()
{
	for(new i = 1;i<vehcount;i++) {
		if(VehicleInfo[i][spawned] == 0) {
			if(IsPlayerClose(i,SPAWN_DISTANCE) == 1) {
			    if(streamcount <= MAX_ACTIVE_VEHICLES) {
			        if(modelcount[VehicleInfo[i][model]] < MAX_ACTIVE_MODELS) {
						VehicleInfo[i][idnum] = CreateVehicle(VehicleInfo[i][model], VehicleInfo[i][x_spawn], VehicleInfo[i][y_spawn], VehicleInfo[i][z_spawn], VehicleInfo[i][za_spawn], VehicleInfo[i][color_1], VehicleInfo[i][color_2],11000);
                    	VehicleInfo[i][spawned] = 1;
                    	modelcount[VehicleInfo[i][model]]++;
						streamcount++;
					}
				}
			}
		}
		else {
			if(vehused[VehicleInfo[i][idnum]] == 0) {
	    		if(IsPlayerClose(i,SPAWN_DISTANCE) == 0) {
            		DestroyVehicle(VehicleInfo[i][idnum]);
            		VehicleInfo[i][spawned] = 0;
                    modelcount[VehicleInfo[i][model]]--;
					streamcount--;
				}
			}
		}
	}
}

stock AddStreamingVehicle(modelid,Float:x,Float:y,Float:z,Float:a,col1,col2)
{
	vehcount++;
	VehicleInfo[vehcount][model] = modelid;
	VehicleInfo[vehcount][x_spawn] = x;
	VehicleInfo[vehcount][y_spawn] = y;
	VehicleInfo[vehcount][z_spawn] = z;
	VehicleInfo[vehcount][za_spawn] = a;
	VehicleInfo[vehcount][color_1] = col1;
	VehicleInfo[vehcount][color_2] = col2;
	return 1;
}

stock DeactivateStreamedVehicle(vehicleid)
{
    vehused[vehicleid] = 0;
	return 1;
}

stock IsPlayerClose(streamid, Float:MAX)
{
    for(new i = 0;i<MAX_PLAYERS;i++) {
		new Float:PPos[3];
    	GetPlayerPos(i, PPos[0], PPos[1], PPos[2]);
		if (PPos[0] >= floatsub(VehicleInfo[streamid][x_spawn], MAX) && PPos[0] <= floatadd(VehicleInfo[streamid][x_spawn], MAX)
		&& PPos[1] >= floatsub(VehicleInfo[streamid][y_spawn], MAX) && PPos[1] <= floatadd(VehicleInfo[streamid][y_spawn], MAX)
		&& PPos[2] >= floatsub(VehicleInfo[streamid][z_spawn], MAX) && PPos[2] <= floatadd(VehicleInfo[streamid][z_spawn], MAX))
		{
			return 1;
		}
	}
	return 0;
}
