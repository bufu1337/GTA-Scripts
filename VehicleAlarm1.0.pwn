#define FILTERSCRIPT
#include <a_samp>
#include <core>
#include <float>

//modify any of these to your needs
#define FLASH_TIME  500
#define SHUTDOWN  10000
//----------------------

new AlarmTime[MAX_PLAYERS];
new Stop[MAX_PLAYERS];



//SpeCial thanks to Real Vehicle Lights v.1.0 by Cyber_Punk
main()
{
	print("\n----------------------------------");
	print("Vehicle Alarm by Boelie");
	print("----------------------------------\n");
}


public OnPlayerStateChange(playerid, newstate, oldstate)
{
//Modify here if you like the timer to be set to some other type of vehicle instead of ALL vehicles
	if(newstate == PLAYER_STATE_DRIVER)
	{
	SetPVarInt(playerid, "VehON", 0);
	AlarmTime[playerid] = SetTimerEx("Alarm", FLASH_TIME, 1, "i", playerid);
	Stop[playerid] = SetTimerEx("Chill",SHUTDOWN,false,"i",playerid);
	}

	else if(newstate == PLAYER_STATE_ONFOOT)
	{
		KillTimer(AlarmTime[playerid]);
	}

	return 1;
}

forward Alarm(playerid);
public Alarm(playerid)
{
//Modify here if you like the timer to be set to some other type of vehicle instead of ALL vehicles
	if(IsPlayerInAnyVehicle(playerid))
	{
 		new panels, doors, lights, tires;
		GetVehicleDamageStatus(GetPlayerVehicleID(playerid), panels, doors, lights, tires);
		switch(GetPVarInt(playerid, "VehON"))
		{
		    case 0:
			{
		        lights = encode_lights(1, 1, 1, 1);//off
      			SetPVarInt(playerid, "VehON", 1);
      			PlayerPlaySound(playerid, 1147, 0.0,0.0,0.0);
			}
			case 1:
			{
				lights = encode_lights(0, 0, 0, 0);//on
				SetPVarInt(playerid, "VehON", 0);
				PlayerPlaySound(playerid, 1147, 0.0,0.0,0.0);
			}
		}
		UpdateVehicleDamageStatus(GetPlayerVehicleID(playerid), panels, doors, lights, tires);
	}
}

forward Chill(playerid);
public Chill(playerid)
{
	KillTimer(AlarmTime[playerid]);
	new panels, doors, lights, tires;
	GetVehicleDamageStatus(GetPlayerVehicleID(playerid), panels, doors, lights, tires);
	lights = encode_lights(0, 0, 0, 0);
	UpdateVehicleDamageStatus(GetPlayerVehicleID(playerid), panels, doors, lights, tires);
}

// Thanks to JernejL (RedShirt)
encode_lights(light1, light2, light3, light4) {
return light1 | (light2 << 1) | (light3 << 2) | (light4 << 3);
}


