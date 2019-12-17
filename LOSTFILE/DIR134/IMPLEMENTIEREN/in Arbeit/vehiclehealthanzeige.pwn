#include <a_samp>

#define sgversion "1.0"

new Text:vehiclebar[12];
new playervehiclebar[MAX_PLAYERS] = 1;
new announce[MAX_PLAYERS];

forward VEHICLEHEALTH();
forward ANNOUNCE();
//--------------------------------------------------------------------------------------------------------------------------------

public OnFilterScriptInit()
{

	vehiclebar[0] = TextDrawCreate(549.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[0], true);
	TextDrawBoxColor(vehiclebar[0], 0x000000ff);
	TextDrawSetShadow(vehiclebar[0],0);
	TextDrawTextSize(vehiclebar[0], 604, 0);

	vehiclebar[1] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[1], true);
	TextDrawBoxColor(vehiclebar[1], 0x004400ff);
	TextDrawSetShadow(vehiclebar[1],0);
	TextDrawTextSize(vehiclebar[1], 602, 0);

	vehiclebar[2] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[2], true);
	TextDrawBoxColor(vehiclebar[2], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[2],0);
	TextDrawTextSize(vehiclebar[2], 556, 0);

	vehiclebar[3] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[3], true);
	TextDrawBoxColor(vehiclebar[3], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[3],0);
	TextDrawTextSize(vehiclebar[3], 561, 0);

	vehiclebar[4] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[4], true);
	TextDrawBoxColor(vehiclebar[4], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[4],0);
	TextDrawTextSize(vehiclebar[4], 566, 0);

	vehiclebar[5] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[5], true);
	TextDrawBoxColor(vehiclebar[5], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[5],0);
	TextDrawTextSize(vehiclebar[5], 571, 0);

	vehiclebar[6] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[6], true);
	TextDrawBoxColor(vehiclebar[6], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[6],0);
	TextDrawTextSize(vehiclebar[6], 576, 0);

	vehiclebar[7] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[7], true);
	TextDrawBoxColor(vehiclebar[7], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[7],0);
	TextDrawTextSize(vehiclebar[7], 581, 0);

	vehiclebar[8] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[8], true);
	TextDrawBoxColor(vehiclebar[8], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[8],0);
	TextDrawTextSize(vehiclebar[8], 586, 0);

	vehiclebar[9] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[9], true);
	TextDrawBoxColor(vehiclebar[9], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[9],0);
	TextDrawTextSize(vehiclebar[9], 591, 0);

	vehiclebar[10] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[10], true);
	TextDrawBoxColor(vehiclebar[10], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[10],0);
	TextDrawTextSize(vehiclebar[10], 596, 0);

	vehiclebar[11] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[11], true);
	TextDrawBoxColor(vehiclebar[11], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[11],0);
	TextDrawTextSize(vehiclebar[11], 602, 0);

	SetTimer("VEHICLEHEALTH",250,1);
	return 1;
}

//--------------------------------------------------------------------------------------------------------------------------------

public OnPlayerCommandText(playerid, cmdtext[])
{
if(strcmp(cmdtext, "/vehiclehealth", true) == 0){
if(playervehiclebar[playerid] == 0){
playervehiclebar[playerid] = 1;
}else if(playervehiclebar[playerid] == 1){
playervehiclebar[playerid] = 0;
}
return 1;
}
return 0;
}

//--------------------------------------------------------------------------------------------------------------------------------

public VEHICLEHEALTH(){
for(new i=0; i<MAX_PLAYERS; i++){
TextDrawHideForPlayer(i,vehiclebar[0]);
TextDrawHideForPlayer(i,vehiclebar[1]);
TextDrawHideForPlayer(i,vehiclebar[2]);
TextDrawHideForPlayer(i,vehiclebar[3]);
TextDrawHideForPlayer(i,vehiclebar[4]);
TextDrawHideForPlayer(i,vehiclebar[5]);
TextDrawHideForPlayer(i,vehiclebar[6]);
TextDrawHideForPlayer(i,vehiclebar[7]);
TextDrawHideForPlayer(i,vehiclebar[8]);
TextDrawHideForPlayer(i,vehiclebar[9]);
TextDrawHideForPlayer(i,vehiclebar[10]);
TextDrawHideForPlayer(i,vehiclebar[11]);
if(IsPlayerInAnyVehicle(i) == 1 && playervehiclebar[i] == 1){
TextDrawShowForPlayer(i,vehiclebar[0]);
TextDrawShowForPlayer(i,vehiclebar[1]);
new vehicleid2;
vehicleid2 = GetPlayerVehicleID(i);
new vhp;
GetVehicleHealth(vehicleid2,vhp);
if(vhp >= 0 && vhp <= 1133903872){
}else if(vhp >= 1133903873 && vhp <= 1134723072){
TextDrawShowForPlayer(i,vehiclebar[2]);
}else if(vhp >= 1134723073 && vhp <= 1137180672){
TextDrawShowForPlayer(i,vehiclebar[3]);
}else if(vhp >= 1137180673 && vhp <= 1139638272){
TextDrawShowForPlayer(i,vehiclebar[4]);
}else if(vhp >= 1139638273 && vhp <= 1141473280){
TextDrawShowForPlayer(i,vehiclebar[5]);
}else if(vhp >= 1141473281 && vhp <= 1142702080){
TextDrawShowForPlayer(i,vehiclebar[6]);
}else if(vhp >= 1142702081 && vhp <= 1143930880){
TextDrawShowForPlayer(i,vehiclebar[7]);
}else if(vhp >= 1143930880 && vhp <= 1145159680){
TextDrawShowForPlayer(i,vehiclebar[8]);
}else if(vhp >= 1145159681 && vhp <= 1146388480){
TextDrawShowForPlayer(i,vehiclebar[9]);
}else if(vhp >= 1146388481 && vhp <= 1147617280){
TextDrawShowForPlayer(i,vehiclebar[10]);
}else if(vhp >= 1147617281 && vhp <= 1148846080){
TextDrawShowForPlayer(i,vehiclebar[11]);}}}
return 1;
}
