#include <a_samp>
#undef MAX_PLAYERS
#define MAX_PLAYERS 51
GetDistanceToCar(playerid,carid){//darkrealm
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2,Float:dis;
	if (!IsPlayerConnected(playerid))return -1;
	GetPlayerPos(playerid,x1,y1,z1);GetVehiclePos(carid,x2,y2,z2);
	dis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
	return floatround(dis);
}
GetClosestCar(playerid){//darkrealm
	if (!IsPlayerConnected(playerid))return -1;new Float:prevdist = 5.000,prevcar;
	for(new carid = 0; carid < MAX_VEHICLES; carid++) {
		new Float:dist = GetDistanceToCar(playerid,carid);
		if ((dist < prevdist)) {prevdist = dist;prevcar = carid;}
	}
	return prevcar;
}
new PlayerIsSpectatingVehicle[MAX_PLAYERS],CPC[MAX_PLAYERS],gSpectateID[MAX_PLAYERS],gSpectateType[MAX_PLAYERS],ExitedSpec[MAX_PLAYERS],timer1[MAX_PLAYERS];
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
	if(newkeys & KEY_CROUCH && !IsPlayerInAnyVehicle(playerid)){
	    if(PlayerIsSpectatingVehicle[playerid] == -1){
	        for(new carid = 0; carid < MAX_VEHICLES; carid++) {
	            if(GetDistanceToCar(playerid,carid) <= 4.000){
				    CPC[playerid] = GetClosestCar(playerid);
					TogglePlayerSpectating(playerid, 1);
					PlayerSpectateVehicle(playerid, CPC[playerid]);
					gSpectateID[playerid] = CPC[playerid];
					ExitedSpec[playerid] = 0;
					gSpectateType[playerid] = 2;
					PlayerIsSpectatingVehicle[playerid] = CPC[playerid];
					timer1[playerid] = SetTimerEx("N",500,1,"d",playerid);
				}
			}
		}else{
	   		TogglePlayerSpectating(playerid, 0);
			gSpectateID[playerid] = INVALID_PLAYER_ID;
			gSpectateType[playerid] = 0;
			ExitedSpec[playerid] = 1;
			SetTimerEx("T",1000,0,"d",playerid);
		}
	}
	return 1;
}
new Text3D:PnameInCar3Dtext[MAX_PLAYERS];
forward N(p);
public N(p){
	new s[256];
	format(s,sizeof(s),"%s[%d]",PlayerName(p),p);
	new Float:x,Float:y,Float:z;
	GetVehiclePos(PlayerIsSpectatingVehicle[p],x,y,z);
	for(new i = 0; i<=GetMaxPlayers();i++){Delete3DTextLabel(PnameInCar3Dtext[p]);}
	PnameInCar3Dtext[p] = Create3DTextLabel(s,0x008080FF,x,y,z+1.5,30.0,GetPlayerVirtualWorld(p));
	return 1;
}
forward T(p);
public T(p){
	if(ExitedSpec[p] == 1){
	    ExitedSpec[p] = 0;
	    new Float:x,Float:y,Float:z;
	    GetVehiclePos(PlayerIsSpectatingVehicle[p],x,y,z);
	    PlayerIsSpectatingVehicle[p] = -1;
	    SetPlayerPos(p,x+1.5,y+1.5,z);
	    KillTimer(timer1[p]);
	    for(new i = 0; i<=GetMaxPlayers();i++){
	    	Delete3DTextLabel(PnameInCar3Dtext[i]);
	    }
	}
	return 1;
}
public OnVehicleDeath(vehicleid){
	for(new i = 0;i<= GetMaxPlayers();i++){
	    if(PlayerIsSpectatingVehicle[i] == vehicleid){
	   		TogglePlayerSpectating(i, 0);
			gSpectateID[i] = INVALID_PLAYER_ID;
			gSpectateType[i] = 0;
			new Float:x,Float:y,Float:z;
			GetPlayerPos(i,x,y,z);
			CreateExplosion(x,y,z,1,5.0);CreateExplosion(x+2,y,z,1,5.0);CreateExplosion(x,y+2,z,1,5.0);CreateExplosion(x,y,z+2,1,5.0);
			SetPlayerHealth(i,0);
			PlayerIsSpectatingVehicle[i] = -1;
		}
	}
	return 1;
}
public OnPlayerConnect(playerid){PlayerIsSpectatingVehicle[playerid] = -1;return 1;}
PlayerName(playerid){new name[MAX_PLAYER_NAME];GetPlayerName(playerid, name, sizeof(name));return name;}
public OnFilterScriptExit(){for(new i = 0;i <= GetMaxPlayers();i++){KillTimer(timer1[i]);}}
