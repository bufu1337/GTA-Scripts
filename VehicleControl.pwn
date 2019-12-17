#include <a_samp>
#include <zcmd>

new EngineStatus[MAX_PLAYERS], LightsStatus[MAX_PLAYERS], AlarmStatus[MAX_PLAYERS], DoorsStatus[MAX_PLAYERS], BonnetStatus[MAX_PLAYERS], BootStatus[MAX_PLAYERS], ObjectiveStatus[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Vehicle Control System Loaded");
	print(" Coded by Auxxx");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	print("\n--------------------------------------");
	print(" Vehicle Control System Un-Loaded");
	print(" Coded by Auxxx");
	print("--------------------------------------\n");
	return 1;
}

public OnGameModeInit()
{
    ManualVehicleEngineAndLights();
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:veh(playerid, params[])
{
	new engine,lights,alarm,doors,bonnet,boot,objective;
    new veh = GetPlayerVehicleID(playerid);
	if(strcmp(params, "Engine", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
	 		if(veh != INVALID_VEHICLE_ID)
			{
				if(EngineStatus[playerid] == 0)
				{
					GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(veh,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
					EngineStatus[playerid] = 1;
					SendClientMessage(playerid, 0xFFFFFFAA, "You've turned the vehicle's engine {2F991A}on!");
				}
				else if(EngineStatus[playerid] == 1)
				{
					GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(veh,VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);
					EngineStatus[playerid] = 0;
					SendClientMessage(playerid, 0xFFFFFFAA, "You've turned the vehicle's engine {E31919}off!");
				}
			}
		}
		else {
		SendClientMessage(playerid, 0x00FF00FF, "{E31919}You are not in a vehicle!");
		}
	}
	else if(strcmp(params, "Lights", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
	 		if(veh != INVALID_VEHICLE_ID)
			{
				if(LightsStatus[playerid] == 0)
				{
					GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(veh,engine,VEHICLE_PARAMS_ON,alarm,doors,bonnet,boot,objective);
					LightsStatus[playerid] = 1;
					SendClientMessage(playerid, 0xFFFFFFAA, "You've turned the vehicle's lights {2F991A}on!");
				}
				else if(LightsStatus[playerid] == 1)
				{
					GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(veh,engine,VEHICLE_PARAMS_OFF,alarm,doors,bonnet,boot,objective);
					LightsStatus[playerid] = 0;
					SendClientMessage(playerid, 0xFFFFFFAA, "You've turned the vehicle's lights {E31919}off!");
				}
			}
		}
		else {
		SendClientMessage(playerid, 0x00FF00FF, "{E31919}You are not in a vehicle!");
		}
	}
	else if(strcmp(params, "Alarm", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
	 		if(veh != INVALID_VEHICLE_ID)
			{
				if(AlarmStatus[playerid] == 0)
				{
					GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(veh,engine,lights,VEHICLE_PARAMS_ON,doors,bonnet,boot,objective);
					AlarmStatus[playerid] = 1;
					SendClientMessage(playerid, 0xFFFFFFAA, "You've turned the vehicle's alarm {2F991A}on!");
				}
				else if(AlarmStatus[playerid] == 1)
				{
					GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(veh,engine,lights,VEHICLE_PARAMS_OFF,doors,bonnet,boot,objective);
					AlarmStatus[playerid] = 0;
					SendClientMessage(playerid, 0xFFFFFFAA, "You've turned the vehicle's alarm {E31919}off!");
				}
			}
		}
		else {
		SendClientMessage(playerid, 0x00FF00FF, "{E31919}You are not in a vehicle!");
		}
	}
	else if(strcmp(params, "Doors", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
	 		if(veh != INVALID_VEHICLE_ID)
			{
				if(DoorsStatus[playerid] == 0)
				{
					GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(veh,engine,lights,alarm,VEHICLE_PARAMS_ON,bonnet,boot,objective);
					DoorsStatus[playerid] = 1;
					SendClientMessage(playerid, 0xFFFFFFAA, "The vehicle's doors are now {2F991A}open!");
				}
				else if(DoorsStatus[playerid] == 1)
				{
					GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(veh,engine,lights,alarm,VEHICLE_PARAMS_OFF,bonnet,boot,objective);
					DoorsStatus[playerid] = 0;
					SendClientMessage(playerid, 0xFFFFFFAA, "The vehicle's doors are now {E31919}closed!");
				}
			}
		}
		else {
		SendClientMessage(playerid, 0x00FF00FF, "{E31919}You are not in a vehicle!");
		}
	}
	else if(strcmp(params, "Bonnet", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
	 		if(veh != INVALID_VEHICLE_ID)
			{
				if(BonnetStatus[playerid] == 0)
				{
					GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(veh,engine,lights,alarm,doors,VEHICLE_PARAMS_ON,boot,objective);
					BonnetStatus[playerid] = 1;
					SendClientMessage(playerid, 0xFFFFFFAA, "The vehicle's bonnet is now {2F991A}open!");
				}
				else if(BonnetStatus[playerid] == 1)
				{
					GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(veh,engine,lights,alarm,doors,VEHICLE_PARAMS_OFF,boot,objective);
					BonnetStatus[playerid] = 0;
					SendClientMessage(playerid, 0xFFFFFFAA, "The vehicle's bonnet is now {E31919}closed!");
				}
			}
		}
		else {
		SendClientMessage(playerid, 0x00FF00FF, "{E31919}You are not in a vehicle!");
		}
	}
	else if(strcmp(params, "Boot", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
	 		if(veh != INVALID_VEHICLE_ID)
			{
				if(BootStatus[playerid] == 0)
				{
					GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,VEHICLE_PARAMS_ON,objective);
					BootStatus[playerid] = 1;
					SendClientMessage(playerid, 0xFFFFFFAA, "The vehicle's boot is now {2F991A}open!");
				}
				else if(BootStatus[playerid] == 1)
				{
					GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,VEHICLE_PARAMS_OFF,objective);
					BootStatus[playerid] = 0;
					SendClientMessage(playerid, 0xFFFFFFAA, "The vehicle's boot is now {E31919}closed!");
				}
			}
		}
		else {
		SendClientMessage(playerid, 0x00FF00FF, "{E31919}You are not in a vehicle!");
		}
	}
	else if(strcmp(params, "Objective", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
	 		if(veh != INVALID_VEHICLE_ID)
			{
				if(ObjectiveStatus[playerid] == 0)
				{
					GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,VEHICLE_PARAMS_ON);
					ObjectiveStatus[playerid] = 1;
					SendClientMessage(playerid, 0xFFFFFFAA, "The vehicle's objective is now {2F991A}active!");
				}
				else if(ObjectiveStatus[playerid] == 1)
				{
					GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,VEHICLE_PARAMS_OFF);
					ObjectiveStatus[playerid] = 0;
					SendClientMessage(playerid, 0xFFFFFFAA, "The vehicle's objective is now {E31919}unactive!");
				}
			}
		}
		else {
		SendClientMessage(playerid, 0x00FF00FF, "{E31919}You are not in a vehicle!");
		}
	}
	else SendClientMessage(playerid, 0xFFFFFFAA, "SYNTAX: /veh [function]"),
	SendClientMessage(playerid, 0xFFFFFFAA, "Functions: Engine, Lights, Alarm, Doors, Bonnet, Boot, Objective");
	return 1;
}