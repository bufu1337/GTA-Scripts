    //--------------[Packer Script]----------------//
   //---------------[By KayLuz]-------------------//
  //------------------[V0.2]---------------------//
 //---------------------------------------------//


#include <a_samp>
#include <zcmd>
#include <sscanf2>
#pragma tabsize 0
new
	prevcar[MAX_PLAYERS],
	slots[MAX_VEHICLES][5],
	veh,
	string[125],
	useslot,
	nearest,
	Float:X, Float:Y, Float:Z, Float:A;

forward GetClosestCar(playerid);
forward GetDistanceToCar(playerid,carid);

/*new InvalidVehicles[60] = {  Work In Progress
	403, 406, 407, 408, 409, 417, 425, 430, 431, 432, 433, 435, 437, 443, 444,
	446, 447, 449, 450, 452, 453, 454, 455, 456, 457, 463, 469, 472, 473,
	476, 484, 486, 487, 488, 493, 497, 511, 512, 513, 514, 515, 519, 520,
	524, 532, 537, 538, 548, 553, 557, 589, 570, 578, 584, 590, 591, 592,
	593, 595, 601
}*/



public GetClosestCar(playerid){ //By Darkrealm
	if (!IsPlayerConnected(playerid)){
	    return -1;
	}
	new Float:prevdist = 8.000;
	for (new carid = 0; carid < MAX_VEHICLES; carid++){
	    if(!IsVehicleInUse(carid)){
	 		new Float:dist = GetDistanceToCar(playerid,carid);
		    if ((dist < prevdist)){
		         prevdist = dist;
		         prevcar[playerid] = carid;
           	}
   		}
	}
	return prevcar[playerid];
}
public GetDistanceToCar(playerid,carid){ //By Darkrealm
	new Float:dis;
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if (!IsPlayerConnected(playerid)) {
	return -1;
	}
	GetPlayerPos(playerid,x1,y1,z1);
 	if(!IsVehicleInUse(carid)){
		GetVehiclePos(carid,x2,y2,z2);
		dis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
 		return floatround(dis);
	}else{
		return 1;
	}
}
IsVehicleInUse(vehicleid){
	new temp;
	for(new i=0;i<GetMaxPlayers();i++){
		if(IsPlayerConnected(i) && IsPlayerInVehicle(i, vehicleid) && GetPlayerState(i)==PLAYER_STATE_DRIVER){temp++;}
	}
	if(temp > 0){ return true; } else return false;
}
public OnPlayerSpawn(playerid)
{
    return 1;
}
forward LoadVehicle(playerid);
public LoadVehicle(playerid)
{
	veh = GetPlayerVehicleID(playerid);
	nearest = GetClosestCar(playerid);
	PlayerPlaySound(playerid, 1056, X, Y, Z);
	if(GetVehicleModel(veh) == 443)
 	{
 	    if(nearest > 0)
 	    {
			slots[veh][useslot] = nearest;
			SetVehicleVirtualWorld(slots[veh][useslot], 19);
			SetVehiclePos(slots[veh][useslot], 1878.3353,-1380.3011,13.5722);
			SendClientMessage(playerid, 0xFF0000FF, "*Vehicle loaded on the back*");
			format(string, 125, "[Vehicle Loaded] Slot Used %d | Vehicle ID: %d",  useslot, slots[veh][useslot]);
			SendClientMessage(playerid, 0x33CCFFFF, string);
			useslot = 0;
			return 1;
		}
		else SendClientMessage(playerid, 0xFF0000FF, "There is no vehicle close enough");
	}
	else SendClientMessage(playerid, 0xFF0000FF, "*You Must Be In A Packer*");return 1;
}
public OnGameModeInit()
{
	print("______________Packer System V0.2 Loaded__________________");
    for(new v=1;v<MAX_VEHICLES;v++)
    {
		slots[v][1] = -1;
		slots[v][2] = -1;
		slots[v][3] = -1;
		slots[v][4] = -1;
	}
}
public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}
COMMAND:packer(playerid, params[])
{
		new packer;
		GetPlayerPos(playerid, X,Y,Z);
		veh = CreateVehicle(443, X+3,Y+3,Z, 0.0, 6, 6, 60000);
		slots[packer][1] = -1;
		slots[packer][2] = -1;
		slots[packer][3] = -1;
		slots[packer][4] = -1;
		return 1;
}
COMMAND:loadv(playerid, params[])
{
	veh = GetPlayerVehicleID(playerid);
	if(GetVehicleModel(veh) == 443)
 	{
		if(slots[veh][1] == -1)
		{
		    useslot = 1;
			SetTimerEx("LoadVehicle",2800,0,"i",playerid);
			SendClientMessage(playerid, 0xFF0000FF, "*Attempting To Load Vehicle....*");
			return 1;

		}
		else if(slots[veh][2] == -1)
		{
		    useslot = 2;
			SetTimerEx("LoadVehicle",2500,0,"i",playerid);
			SendClientMessage(playerid, 0xFF0000FF, "*Attempting To Load Vehicle....*");
			return 1;
		}
		else if(slots[veh][3] == -1)
		{
		    useslot = 3;
			SetTimerEx("LoadVehicle",2500,0,"i",playerid);
			SendClientMessage(playerid, 0xFF0000FF, "*Attempting To Load Vehicle....*");
			return 1;
		}
		else if(slots[veh][4] == -1)
		{
		    useslot = 4;
			SetTimerEx("LoadVehicle",2500,0,"i",playerid);
			SendClientMessage(playerid, 0xFF0000FF, "*Attempting To Load Vehicle....*");
			return 1;
		}
		else SendClientMessage(playerid, 0xFF0000FF, "*Packer Is Full*");
	}
	else SendClientMessage(playerid, 0xFF0000FF, "*You Must Be In A Packer*");return 1;
}

COMMAND:unloadv(playerid, params[])
{
	new aslots;
	new tmp[256];
	aslots = strval(tmp);
	veh = GetPlayerVehicleID(playerid);
	PlayerPlaySound(playerid, 1056, X, Y, Z);
	if (sscanf(params, "i", aslots)) return SendClientMessage(playerid, 0xFF0000FF, "[ERROR] Right Usage: /unload [Slot 1-4]");
	if(slots[veh][aslots] >= 0)
	{
		format(string, 125, "[Vehicle Unloaded] Slot %d Unloaded | Vehicle ID:%d",  aslots, slots[veh][aslots]);
 		SendClientMessage(playerid, 0x33CCFFFF, string);
		GetPlayerPos(playerid, X, Y, Z);
		SetVehiclePos(slots[veh][aslots], X, Y+10, Z);
  		GetVehicleZAngle(veh, A);
		SetVehicleZAngle(slots[veh][aslots],A);
		SetVehicleVirtualWorld(slots[veh][aslots], 0);
		slots[veh][aslots] = -1;
		return 1;
	}
	else SendClientMessage(playerid, 0xFF0000FF, "* There is no vehicle in that slot | Try Another *"); return 1;
}
COMMAND:vslot(playerid, params[])
{
	new aslots;
	new tmp[256];
	aslots = strval(tmp);
	veh = GetPlayerVehicleID(playerid);
	if (sscanf(params, "i", aslots)) return SendClientMessage(playerid, 0xFF0000FF, "[ERROR] Right Usage: /vslot [Slot 1-4]");
	if(slots[veh][aslots] >= 0)
	{
		format(string, 125, "[Vehicle View]Packer Slot %d Contains Vehicle ID:%d", aslots, slots[veh][aslots]);
 		SendClientMessage(playerid, 0x33CCFFFF, string);
		return 1;
	}
	else SendClientMessage(playerid, 0xFF0000FF, "* There is no vehicle in that slot | Try Another *"); return 1;
}