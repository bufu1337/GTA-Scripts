#include <a_samp>
#define COLOR_RED 0xCC0000AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_GREEN 0x33FF00AA
#define COLOR_CYAN 0x33FFFFAA
#define COLOR_BLUE 0x0000FFAA
#define COLOR_ORANGE 0xFFCC00AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BLACK 0x000000AA
#define COLOR_GREY 0xCCCCCCAA
new engineOn[MAX_VEHICLES];
new vehicleEntered[MAX_PLAYERS][MAX_VEHICLES];
forward Startup(playerid, vehicleid);
public OnPlayerStateChange(playerid, newstate, oldstate){
	new pveh = GetVehicleModel(GetPlayerVehicleID(playerid));
	new vehicle = GetPlayerVehicleID(playerid);
	if(newstate == PLAYER_STATE_DRIVER && (pveh == 522 || pveh == 581 || pveh == 462 || pveh == 521 || pveh == 463 || pveh == 461 || pveh == 448 || pveh == 471 || pveh == 468 || pveh == 586) && (pveh != 509 && pveh != 481 && pveh != 510))
	{
		SetTimerEx("Startup", 1, false, "ii", playerid, vehicle);
	}
	else if(newstate == PLAYER_STATE_DRIVER)
	{
		SetTimerEx("Startup", 1, false, "ii", playerid, vehicle);
	}
	return true;
}
public OnPlayerCommandText(playerid, cmdtext[]){
	new cmd[256], idx;
	cmd = strtok(cmdtext, idx);
	if(!strcmp(cmd, "/startup", true))	{
		if(engineOn[GetPlayerVehicleID(playerid)]) return SendClientMessage(playerid, COLOR_RED, "Engine already started!");
		if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED, "Do you think that you can start an engine which you don't have?");
		if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return SendClientMessage(playerid, COLOR_RED, "Only the driver can do this!");

		engineOn[GetPlayerVehicleID(playerid)] = true;
		TogglePlayerControllable(playerid, true);
		new playerveh = GetPlayerVehicleID(playerid);
		PutPlayerInVehicle(playerid, playerveh, 0);
		SendClientMessage(playerid, COLOR_GREEN, "Engine started!");
		return true;
	}
	if(!strcmp(cmd, "/turnoff", true))	{
		if(!engineOn[GetPlayerVehicleID(playerid)]) return SendClientMessage(playerid, COLOR_RED, "Engine not started!");
		if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED, "Do you think that you can start an engine which you don't have?");
		if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return SendClientMessage(playerid, COLOR_RED, "Only the driver can do this!");

		engineOn[GetPlayerVehicleID(playerid)] = false;
		RemovePlayerFromVehicle(playerid);
		SendClientMessage(playerid, COLOR_GREEN, "Engine stopped!");
		return true;
	}
	return false;
}
public Startup(playerid, vehicleid){
	if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER || engineOn[vehicleid])
	{
		//I do nothing!
	}
	else if(!engineOn[vehicleid] && !vehicleEntered[playerid][vehicleid] && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "You have to do /startup to start your engine!");
		TogglePlayerControllable(playerid, false);
		vehicleEntered[playerid][vehicleid] = true;
	}
	else if(!engineOn[vehicleid] && vehicleEntered[playerid][vehicleid] && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "You have to do /startup to start your engine!");
		TogglePlayerControllable(playerid, false);
	}
}
strtok(const string[], &index, const seperator[] = " "){
	new index2, result[30];
	index2 =  strfind(string, seperator, false, index);

	if(index2 == -1)
	{
		if(strlen(string) > index)
		{
			strmid(result, string, index, strlen(string), 30);
			index = strlen(string);
		}
		return result; // This string is empty, probably, if index came to an end
	}
	if(index2 > (index + 29))
	{
		index2 = index + 29;
		strmid(result, string, index, index2, 30);
		index = index2;
		return result;
	}
	strmid(result, string, index, index2, 30);
	index = index2 + 1;
	return result;
}