/********************************************************/
/*  Script By Gamer_Z                                   */
/*  Credits go to:                                      */
/*  Luby(for IsVehicleInUse)                            */
/*  Darkrealm (for GetClosestCar and GetDistanceToCar)  */
/********************************************************/
#include <a_samp>
new
TimerATTACH[MAX_PLAYERS],
prevcar[MAX_PLAYERS],
playerveh[MAX_PLAYERS],
atached[MAX_PLAYERS],
tempcar[MAX_PLAYERS];
forward GetDistanceToCar(playerid,carid);
forward AtachVehicleToVehicle(playerid,veh,pveh);
forward GetClosestCar(playerid);
forward SyncVehiclesOnSpawn(playerid);
public OnPlayerCommandText(playerid, cmdtext[]){
	if(strcmp(cmdtext, "/attachveh", true) == 0) {//By Gamer_Z{
		if(atached[playerid] == 0){
			if(IsPlayerInAnyVehicle(playerid)){
			atached[playerid] = 1;
			playerveh[playerid] = GetPlayerVehicleID(playerid);
			tempcar[playerid] = GetPlayerVehicleID(playerid);
			GetClosestCar(playerid);
			TimerATTACH[playerid] = SetTimerEx("AttachVehicleToVehicle",314,1,"iii",playerid,prevcar[playerid],playerveh[playerid]);
			SendClientMessage(playerid, 0xFF0000FF, "* Vehicle attached!");
			}
		}
		else if(atached[playerid] == 1){
			atached[playerid] = 0;
			PutPlayerInVehicle(playerid,prevcar[playerid],0);// for syncing
			PutPlayerInVehicle(playerid,tempcar[playerid],0);// for syncing
			KillTimer(TimerATACH[playerid]);
			SendClientMessage(playerid, 0xFF0000FF, "* Vehicle de-attached!");
		}
		return 1;
	}
	return 0;
}
public OnPlayerDisconnect(playerid){
	if(atached[playerid] == 1){
		atached[playerid] = 0;KillTimer(TimerATACH[playerid]);
	}
	return 1;
}
public OnPlayerExitVehicle(playerid, vehicleid){
    if(atached[playerid] == 1){
		atached[playerid] = 0;
		KillTimer(TimerATACH[playerid]);
		SendClientMessage(playerid, 0xFF0000FF, "* Vehicle de-attached!");
	}
    return 1;
}
public OnPlayerSpawn(playerid){
	SetTimerEx("SyncVehiclesOnSpawn",1914,0,"i",playerid);
	return 1;
}
public SyncVehiclesOnSpawn(playerid){
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	for (new carid = 0; carid < MAX_VEHICLES; carid++){
	    if(!IsVehicleInUse(carid)){
			PutPlayerInVehicle(playerid,carid,0);
		}
	}
	SetPlayerPos(playerid,x,y,z);
}
public GetClosestCar(playerid){ //By Darkrealm (Edited by Gamer_Z for AtachVehToVeh)
	if (!IsPlayerConnected(playerid)){
	    return -1;
	}
	new Float:prevdist = 7.000;
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
public GetDistanceToCar(playerid,carid){ //By Darkrealm (Edited by Gamer_Z for AtachVehToVeh)
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
	}
	else{
		return 1;
	}
}
public AttachVehicleToVehicle(playerid,veh,pveh){//By Gamer_Z
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetVehicleZAngle(pveh,a);
	SetVehiclePos(veh,x,y,z-3);
	SetVehicleZAngle(veh,a);
	PutPlayerInVehicle(playerid,prevcar[playerid],0);// for syncing
	PutPlayerInVehicle(playerid,tempcar[playerid],0);// for syncing
	return 1;
}
IsVehicleInUse(vehicleid){//By Luby ..IsVehicleInUseDF xD
	new temp;
	for(new i=0;i<MAX_PLAYERS;i++){
		if(IsPlayerConnected(i) && IsPlayerInVehicle(i, vehicleid) && ){ //GetPlayerState(i)==PLAYER_STATE_DRIVER
			temp++;
		}
	}
	if(temp > 0){
		return true;
	}
	else {
		return false;
	}
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
	if (newkeys == KEY_ACTION){
		if(IsPlayerInAnyVehicle(playerid) && atached[playerid] == 1){
			atached[playerid] = 0;
			PutPlayerInVehicle(playerid,prevcar[playerid],0);// for syncing
			PutPlayerInVehicle(playerid,tempcar[playerid],0);// for syncing
			KillTimer(TimerATACH[playerid]);
			SendClientMessage(playerid, 0xFF0000FF, "* Vehicle de-attached!");
		}
		else if(IsPlayerInAnyVehicle(playerid) && atached[playerid] == 0){
			atached[playerid] = 1;
			playerveh[playerid] = GetPlayerVehicleID(playerid);
			tempcar[playerid] = GetPlayerVehicleID(playerid);
			GetClosestCar(playerid);
			TimerATACH[playerid] = SetTimerEx("AttachVehicleToVehicle",314,1,"iii",playerid,prevcar[playerid],playerveh[playerid]);
			SendClientMessage(playerid, 0xFF0000FF, "* Vehicle attached!");
		}
	}
	return 1;
}