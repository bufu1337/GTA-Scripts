#include <a_samp>
/*------------------------------------------------------------------------*-
$$$$$$$$\ $$\    $$\  $$$$$$\  
$$  _____|$$ |   $$ |$$  __$$\ 
$$ |      $$ |   $$ |$$ /  \__|
$$$$$\    \$$\  $$  |\$$$$$$\  
$$  __|    \$$\$$  /  \____$$\ 
$$ |        \$$$  /  $$\   $$ |
$$$$$$$$\    \$  /   \$$$$$$  |
\________|    \_/     \______/ 
+---------------------------------+
| Ethan's Vehicle Streamer v1.0.2 |
+---------------------------------+

About:
	This streamer lets you have far more than 700 vehicles (sa:mp max) by only having vehicles close to players there.
	So, if your server is throughout the whole san andreas map, if all your players are in Las Venturas and theres loads of cars in
	Los Santos, those vehicles in Los Santos will be destroyed and will automatically be created again when a player geta close enough.
	You can set the spawn distance below.
	Also becuase you will have allot of vehicles, the vehicles are loaded through a file and not directly in this include.

Version:
	1.0.2

Credits:
	Created And Coded By <__Ethan__>
	split was not made by me
	loadvehicles was not made by me, but was modified by me
	
Install:
	1. Place "#include <EVS>" at the top of your gamemode
	2. Place "EVS_OnGameModeInit()" under OnGameModeInit
	3. Place "EVS_OnPlayerExitVehicle(playerid, vehicleid)" under OnPlayerExitVehicle
	4. Place "EVS_OnPlayerConnect(playerid)" under OnPlayerConnect
	5. Use the vehicle file generator provided and place the vehicles file in scriptfiles
	6. Start server!
	
Legal:
	DO NOT COPY AS YOUR OWN WORK!
-*------------------------------------------------------------------------*/
// ------------------------------------------------------+-----------------+
// I recomend you tweak the defiens to fit your gamemode |                 |
// ------------------------------------------------------+-----------------+

#define MAX_STREAM_VEHICLES 	5000	// Max vehicles allowed
#define VEHICLE_SPAWN_DISTANCE 	100		// Distance from where vehicles will be created to the closest player
#define VEHICLE_REMOVE_DELAY 	700		// Remove (respawn) delay from a player exiting their vehicle (in seconds)
#define VEHICLES_FILE 			"streamvehicles.v" // File with your AddStaticVehicle's in scriptfiles

// ---------------------------------+--------------------------------------+
// No need to edit below this point |                                      |
// ---------------------------------+--------------------------------------+

new VehCount 	= 0;
new StreamCount = 0;
new DestroyDelay[MAX_STREAM_VEHICLES];
new HasLeftVehicle[MAX_PLAYERS];

enum SvInfo {
	model1,
	Float: _X,
	Float: _Y,
	Float: _Z,
	Float: _A,
	color11,
	color22,
	sid,
	active
};

new StreamVehicleInfo[MAX_STREAM_VEHICLES][SvInfo];


EVS_OnGameModeInit()
{
	print("+-----------------------------------------+");
	print("| Ethans Vehicle Streamer (v1.0.2) Loaded |");
	print("+-----------------------------------------+");
	SetTimer("StreamVehicleChecker", 500, 1);
	SetTimer("DelayRemove", 1000, 1);
	LoadVehicles();
}

EVS_OnPlayerExitVehicle(playerid, vehicleid)
{
	DestroyDelay[vehicleid] = VEHICLE_REMOVE_DELAY;
	HasLeftVehicle[playerid] = vehicleid;
}

EVS_OnPlayerConnect(playerid)
{
	HasLeftVehicle[playerid] = -1;
}

stock IsATrailer(trid)
{
	new trailers[22] = { 435,450,591,606,607,610,569,590,584,570,608,611 };
	for(new t=0; t<22; t++) { if(GetVehicleModel(trid) == trailers[t]) return 1; }
	return 0;
}

stock IsTrailerBiengUsed(trid)
{
	for(new v=0;v<MAX_VEHICLES;v++){
		if(GetVehicleTrailer(v)==trid){
			return 1;
		}
	}
	return 0;
}

stock PlayersInVehicle(vehid)
{
	new c=0;
	for(new i=0; i<MAX_PLAYERS; i++){
		if(IsPlayerInVehicle(i,vehid)) c++;
	}
	return c;
}

stock split1(const strsrc[], strdest[][], delimiter) // Thanks to whoever made the split1 function.
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc))
	{
		if(strsrc[i]==delimiter || i==strlen(strsrc))
		{
			len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}

stock LoadVehicles() // Thanks To whoever made this function, modified by <__Ethan__>.
{
    if(fexist(VEHICLES_FILE))
	{
	    new 
			TotalVehicles = CountVehicles(),
			Argument[7][70],
			entry[128],
			File:VehiclesFile = fopen(VEHICLES_FILE, io_read);
	    if (VehiclesFile)
		{
		    for(new id; id<TotalVehicles; id++)
			{
				fread(VehiclesFile, entry);
				strdel(entry, 0, 17);
				new end = strfind(entry, ")", true);
				strdel(entry, end, strlen(entry));
				split1(entry, Argument, ',');
				new 
					ID,
					Float: X,
					Float: Y,
					Float: Z,
					Float: A,
					CLR1,
					CLR2;
				ID=strval(Argument[0]);
				X=floatstr(Argument[1]);
				Y=floatstr(Argument[2]);
				Z=floatstr(Argument[3]);
				A=floatstr(Argument[4]);
				CLR1=strval(Argument[5]);
				CLR2=strval(Argument[6]);
				CreateStreamedVehicle(ID, X, Y, Z, A, CLR1, CLR2);
			}
			fclose(VehiclesFile);
		   	printf("[evs] %d Streamed Vehicles Loaded.", TotalVehicles);
		}
	}
	else
	{
		print("[evs] No Vehicles File Found. No Vehicles Loaded To Game.");
	}
}

stock CountVehicles()
{
    new
		entry[128],
		count,
		File: VehiclesFile = fopen(VEHICLES_FILE, io_read);
	while(fread(VehiclesFile, entry, 128)){
		count++;
  	}
  	fclose(VehiclesFile);
  	return count;
}

stock CreateStreamedVehicle(modelid, Float: X, Float: Y, Float: Z, Float: A, c1, c2)
{
	VehCount ++;
	StreamVehicleInfo[VehCount][model1] = modelid;
	StreamVehicleInfo[VehCount][_X] = X;
	StreamVehicleInfo[VehCount][_Y] = Y;
	StreamVehicleInfo[VehCount][_Z] = Z;
	StreamVehicleInfo[VehCount][_A] = A;
	StreamVehicleInfo[VehCount][color11] = c1;
	StreamVehicleInfo[VehCount][color22] = c2;
	DestroyDelay[VehCount] = 0;
	return modelid;
}

stock IsPlayerInDistanceToVeh(vehid, Float: distance)
{
	for(new i=0; i<MAX_PLAYERS; i++){
		new
			Float: X,
			Float: Y,
			Float: Z;
    	GetPlayerPos(i, X, Y, Z);
		if(X >= (StreamVehicleInfo[vehid][_X] - distance) && X <= (StreamVehicleInfo[vehid][_X] + distance)
		&& Y >= (StreamVehicleInfo[vehid][_Y] - distance) && Y <= (StreamVehicleInfo[vehid][_Y] + distance)
		&& Z >= (StreamVehicleInfo[vehid][_Z] - distance) && Z <= (StreamVehicleInfo[vehid][_Z] + distance))
		return 1;
	}
	return 0;
}

forward StreamVehicleChecker();
public StreamVehicleChecker()
{
	for(new d=1; d<VehCount; d++){
		if(StreamVehicleInfo[d][active]==0){
			if(IsPlayerInDistanceToVeh(d,VEHICLE_SPAWN_DISTANCE)==1){
				StreamVehicleInfo[d][sid] = CreateVehicle(StreamVehicleInfo[d][model1],StreamVehicleInfo[d][_X], StreamVehicleInfo[d][_Y],
				StreamVehicleInfo[d][_Z], StreamVehicleInfo[d][_A],StreamVehicleInfo[d][color11], StreamVehicleInfo[d][color22],VEHICLE_REMOVE_DELAY+10);
				StreamVehicleInfo[d][active] = 1;
				StreamCount++;
			}
		}
		else{
			if(IsPlayerInDistanceToVeh(d,VEHICLE_SPAWN_DISTANCE)==0){
				if(IsATrailer(StreamVehicleInfo[d][sid])==1){
					if(IsTrailerBiengUsed(StreamVehicleInfo[d][sid])==0){
						DestroyVehicle(StreamVehicleInfo[d][sid]);
						StreamVehicleInfo[d][active] = 0;
						StreamCount--;
					}
				}
				else{
					if(IsATrailer(StreamVehicleInfo[d][sid])==0){
						if(PlayersInVehicle(StreamVehicleInfo[d][sid])<1){
							if(DestroyDelay[StreamVehicleInfo[d][sid]]<=1){
								DestroyVehicle(StreamVehicleInfo[d][sid]);
								StreamVehicleInfo[d][active] = 0;
								StreamCount--;
							}
						}
					}
				}
			}
		}
	}
}

forward DelayRemove();
public DelayRemove()
{
	for(new i=0; i<MAX_PLAYERS; i++){
		if(HasLeftVehicle[i] != -1){
			if(DestroyDelay[HasLeftVehicle[i]]>0){
				DestroyDelay[HasLeftVehicle[i]]--;
			}
		}
	}
}
