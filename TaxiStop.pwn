/*
    * ## LEASE ATENTAMENTE PARA NO CONVERTIRSE EN LAMMER!!.: :D ##
    *
    * Estè Simple FILTERSCRIPT esta hecho especialmente para www.forum.sa-mp.com
    * NO Publicar estè FILTERSCRIPT en Otros foros de SA-MP y hacerse pasar por el creador del CODE.
    *
    * Codigo Creado Por OTACON
    *
    * CREDITOS:
    *     OTACON: Realizacion y Idea de creacion del code.
    *     TÙ: Modificacion libremente respetando lo mencionado ;).
    *
    *    NOTA: Menos Creditos para los que me los critican.. JO'PUTAS! :D xD ;)
    *
    *                Prohibido TOTALMENTE el Robo de Créditos o la
    *                  Publicación de este FILTERSCRIPT sin Mi Permiso.
*/
/*
    * ## READ CAREFULLY TO AVOID BECOMING LAMMER!.: :D ##
    *
    * This simple FILTERSCRIPT is made especially for www.forum.sa-mp.com
    * DO NOT Post the FILTERSCRIPT in Other SAMP forums and impersonating the creator of the CODE.
    *
    * Code Created By OTACON
    *
    * CREDITS:
    *     OTACON: Idea Making and code creation.
    *     YOUR: Modification freely respecting the above ;).
    *
    *    NOTE: Less Credits for those who criticize me.. JO'PUTAS! :D xD ;)
    *
    *                        FULLY spaces Theft Credit or
    *                 Publication of this FILTERSCRIPT without my permission.
*/

#include <a_samp>

#define DISTANCE_TAXI          10.0
#define COLOR_A           "{FFE100}"
#define COLOR_B           "{FFFFFF}"
enum taxi{
	cTaxi,
	dDriver,
	bool:cMapa,
};
new InfoTaxista[MAX_PLAYERS][taxi];

forward c_taxi(playerid); public c_taxi(playerid)\
ApplyAnimation(playerid, "CARRY","crry_prtial",0.0,0,0,0,0,0,0),
ApplyAnimation(playerid, "CARRY","crry_prtial",0.0,0,0,0,0,0,0),
DisablePlayerCheckpoint(playerid);

stock IsVehicleTaxi(vehicleid){
	#define MODEL_TAXI             (420)
	#define MODEL_COBBIE           (438)
	switch(GetVehicleModel(vehicleid)){
	    case MODEL_TAXI, MODEL_COBBIE:
			return true;
	}return false;
}

stock PlayAudioStreamAll(playerid,Float:distance,url[]){
	new
		Float:pos[3],
		Float:dist;
	GetPlayerPos(playerid, pos[0],pos[1],pos[2]);
	StopAudioStreamForPlayer(playerid);
	PlayAudioStreamForPlayer(playerid, url);
	for(new user=0, player=GetPlayerPoolSize(); user<=player; user++){
		if(user == playerid)
			continue;
		dist = GetPlayerDistanceFromPoint(user, pos[0],pos[1],pos[2]);
		if(dist < distance){
			StopAudioStreamForPlayer(user);
			PlayAudioStreamForPlayer(user, url);
		}
	}return true;
}

stock NotDriver(vehicleid){
	for(new user=0, player=GetPlayerPoolSize(); user<=player; user++){
		if(IsPlayerInVehicle(user, vehicleid) && GetPlayerState(user)==PLAYER_STATE_DRIVER)
			return true;
		else return false;
	}return true;
}

stock GetIDDriver(vehicleid){
	new id;
	for(new user=0, player=GetPlayerPoolSize(); user<=player; user++){
		if(IsPlayerInVehicle(user, vehicleid) && GetPlayerState(user)==PLAYER_STATE_DRIVER)
			id = user;
	}return id;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){

	if(newkeys & KEY_YES){
		if(!IsPlayerInAnyVehicle(playerid)){

			new count_id,
				count_passenger,
				vehicle_id,
				driver_id,
				Float:dist,
				Float:pos[2][3];
			GetPlayerPos(playerid, pos[0][0],pos[0][1],pos[0][2]);

			for(new veh=1, vehicle=GetVehiclePoolSize(); veh<=vehicle; veh++){
				if(IsVehicleTaxi(veh)){
					dist = GetVehicleDistanceFromPoint(veh, pos[0][0],pos[0][1],pos[0][2]);
					if(dist < DISTANCE_TAXI){
						vehicle_id = veh;
						GetVehiclePos(vehicle_id, pos[1][0],pos[1][1],pos[1][2]);
						for(new user=0, player=GetPlayerPoolSize(); user<=player; user++){
							if(user==playerid)continue;
							if(IsPlayerInVehicle(user, vehicle_id)){
								switch(GetPlayerState(user)){
								    case PLAYER_STATE_DRIVER: driver_id = user;
								    case PLAYER_STATE_PASSENGER: count_passenger++;
								}
							}
						}
						count_id++;
					}
				}
			}
			switch(count_id){
			    case 1:{
					switch(count_passenger){
					    case 0:{
						    if(NotDriver(vehicle_id)){
						    	PlayAudioStreamAll(playerid,DISTANCE_TAXI,"");
								SetVehicleVelocity(vehicle_id,0,0,0);
								ApplyAnimation(playerid, "PED","null",0.0,0,0,0,0,0,0);
								ApplyAnimation(playerid, "PED","null",0.0,0,0,0,0,0,0);
								ApplyAnimation(playerid, "PED","IDLE_taxi",4.1,0,0,0,1,1,1);
								SendClientMessage(playerid, -1,""COLOR_B"INFO: "COLOR_A"You called an unoccupied taxi, he has been arrested.,");

								SendClientMessage(playerid, -1,""COLOR_A"It has set you his position in the 'mini map'"COLOR_B"!.");
								GetVehiclePos(vehicle_id, pos[1][0],pos[1][1],pos[1][2]);
								SetPlayerCheckpoint(playerid, pos[1][0],pos[1][1],pos[1][2], 5);
								SetTimerEx("c_taxi", 5*1000, false, "i", driver_id);

								SendClientMessage(driver_id, -1,""COLOR_B"INFO: "COLOR_A"have an passenger available,");
								SendClientMessage(driver_id, -1,""COLOR_A"It has set you his position in the 'mini mapa'"COLOR_B"!.");
								SetPlayerCheckpoint(driver_id, pos[0][0],pos[0][1],pos[0][2], 2);
								SetTimerEx("c_taxi", 5*1000, false, "i", playerid);
							}else SendClientMessage(playerid, -1,""COLOR_B"INFO: "COLOR_A"the taxi driver has not detected"COLOR_B"!.");
						}
					    default:{SendClientMessage(playerid, -1,""COLOR_B"INFO: "COLOR_A"you called an busy taxi, sorry"COLOR_B"!.");}
					}
				}
			    case 0:{SendClientMessage(playerid, -1,""COLOR_B"INFO: "COLOR_A"not taxi to call in your range"COLOR_B"!.");}
			    default:{SendClientMessage(playerid, -1,""COLOR_B"INFO: "COLOR_A"there are too many taxi rank"COLOR_B"!.");}
			}
		}
	}
	return true;
}

public OnPlayerStateChange(playerid, newstate, oldstate){

	new vehicleid,
		driverid,
		Float:angle;
	vehicleid = GetPlayerVehicleID(playerid);
	driverid = GetIDDriver(vehicleid);
	GetPlayerFacingAngle(playerid, angle);

	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_PASSENGER){
		if(IsVehicleTaxi(vehicleid)){
			if(NotDriver(vehicleid)){
				DestroyPlayerObject(playerid, InfoTaxista[playerid][cTaxi]);
		        InfoTaxista[playerid][cTaxi] = CreatePlayerObject(playerid,19300, 0.0, 0.0, 3.0, 0.0, 0.0, 0.0);
		        AttachCameraToPlayerObject(playerid, InfoTaxista[playerid][cTaxi]);
				ApplyAnimation(driverid, "WAYFARER","null",0.0,0,0,0,0,0,0);
				ApplyAnimation(driverid, "WAYFARER","WF_drivebyRHS",4.1,0,0,0,1,1,1);
				SetPlayerFacingAngle(driverid, angle);
				TogglePlayerControllable(driverid,false);
				TogglePlayerControllable(playerid,false);
				SendClientMessage(playerid, -1,""COLOR_B"INFO: "COLOR_A"select your target location through the 'MAP,");
				SendClientMessage(playerid, -1,""COLOR_A"press to select your destination, 'ESC' > option 'MAP'"COLOR_B"!.");
				SendClientMessage(driverid, -1,""COLOR_B"INFO: "COLOR_A"the passenger will mark their destiny in th, waiting"COLOR_B"!.");
				InfoTaxista[playerid][cMapa] = true;
				InfoTaxista[playerid][dDriver] = driverid;
			}
		}
	}

	return true;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ){

	new driverid;
	driverid = InfoTaxista[playerid][dDriver];

	if(InfoTaxista[playerid][cMapa]){
		DestroyPlayerObject(playerid, InfoTaxista[playerid][cTaxi]);
		SetCameraBehindPlayer(driverid);
		SetCameraBehindPlayer(playerid);
		ApplyAnimation(driverid, "CARRY","crry_prtial",0.0,0,0,0,0,0,0);
		ApplyAnimation(driverid, "CARRY","crry_prtial",0.0,0,0,0,0,0,0);
		TogglePlayerControllable(driverid,true);
		TogglePlayerControllable(playerid,true);
		SendClientMessage(playerid, -1,""COLOR_B"INFO: "COLOR_A"you've marked your destination in the 'mini map' the driver correctly"COLOR_B"!.");
		SendClientMessage(driverid, -1,""COLOR_B"INFO: "COLOR_A"the passenger selected destination, has set you in the 'mini map'"COLOR_B"!.");
		SetPlayerCheckpoint(driverid, fX, fY, fZ, 5);
		InfoTaxista[playerid][cMapa] = false;
		driverid = -1;
	}

    return true;
}