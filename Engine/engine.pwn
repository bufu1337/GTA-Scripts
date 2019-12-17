#include <a_samp>

//All Credits to NINTHTJ/Terence_Jeff

#define FILTERSCRIPT
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_YELLOW 0xFFFF00AA

forward Sec();

new StartTime[MAX_PLAYERS];
new Starting[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" TJs Engine System");
	print("--------------------------------------\n");
	SetTimer("Sec",1000,1);
	return 1;
}

enum cInfo
{
	cStarted
}

new CarInfo[MAX_VEHICLES][cInfo];

public Sec()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	if(Starting[i] > 0)
	{
	StartTime[i] -= 1;
	}
	
	if(Starting[i] > 0 && StartTime[i] <= 0)
	{
	Starting[i] = 0;
	StartTime[i] = 0;
	GameTextForPlayer(i,"~g~Vehicle Started.",5000,1);
	new vehicle = GetPlayerVehicleID(i);
	CarInfo[vehicle][cStarted] = 1;
	TogglePlayerControllable(i,1);
	}
	}
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
	new vehicle = GetPlayerVehicleID(playerid);
	if(CarInfo[vehicle][cStarted] == 0)
	{
	TogglePlayerControllable(playerid,0);
	SendClientMessage(playerid,COLOR_LIGHTRED,"To start the this vehicle type: /engine on");
	}
	else if(CarInfo[vehicle][cStarted] > 0)
	{
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"This vehicle was left started!");
	}
	}
	
	if(newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER)
	{
	new vehicle = GetPlayerVehicleID(playerid);
	if(CarInfo[vehicle][cStarted] == 0)
	{
	TogglePlayerControllable(playerid,1);
	}
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp(cmdtext,"/engine on",true) == 0)
	{
	if(!IsPlayerInAnyVehicle(playerid))
	{
	SendClientMessage(playerid,COLOR_YELLOW,"You are not in a vehicle!");
	return 1;
	}
	new vehicle = GetPlayerVehicleID(playerid);
	if(CarInfo[vehicle][cStarted] > 0)
	{
	SendClientMessage(playerid,COLOR_YELLOW,"This vehicle is already started, no need to start it!");
	return 1;
	}
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
	SendClientMessage(playerid,COLOR_YELLOW,"You are not the driver of this vehicle, cant start it!");
	return 1;
	}
	else
	{
	GameTextForPlayer(playerid,"~r~Vehcile Starting...",5000,1);
	Starting[playerid] = 1;
	StartTime[playerid] = 10;//10 secs for the car to start!
	return 1;
	}
	}
	
	if(strcmp(cmdtext,"/engine off",true) == 0)
	{
	if(!IsPlayerInAnyVehicle(playerid))
	{
	SendClientMessage(playerid,COLOR_YELLOW,"You are not in a vehicle!");
	return 1;
	}
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
	SendClientMessage(playerid,COLOR_YELLOW,"You are not the driver of this vehicle, cant switch the engine off!");
	return 1;
	}
	else
	{
	new vehicle = GetPlayerVehicleID(playerid);
	GameTextForPlayer(playerid,"~r~Engine switched off",5000,1);
	TogglePlayerControllable(playerid,0);
	CarInfo[vehicle][cStarted] = 0;
	}
	}
	
	if(strcmp(cmdtext,"/leavecar",true) == 0)
	{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	RemovePlayerFromVehicle(playerid);
	TogglePlayerControllable(playerid,1);
	return 1;
	}
	}
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

