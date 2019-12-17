#include <a_samp>

#define MAX_BEEPS 15 //How many times a vehicle beeps before the beeping stops
#define BEEP_INTERVAL 1 //How many seconds between beeps, 1 second is realistic.
#define COLOR_FAIL 0xFF0000AA
#define COLOR_SUCCESS 0x33AA33AA

#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

new alarmed[MAX_VEHICLES];
new beeps[MAX_VEHICLES];
new Float:vehX,Float:vehY,Float:vehZ;
new driverid;
new BEEP_VOLUME = 16; //Volume of the beep

forward Alarm(vehicleid,toggle);
forward beeper(veh);

public OnFilterScriptInit()
{
	//Examples
	Alarm(1,1); //Activate the alarm on vehicle 1
	Alarm(2,1); //Activate the alarm on vehicle 2
	Alarm(3,1); //Activate the alarm on vehicle 3
	Alarm(4,1); //Activate the alarm on vehicle 4
	/*Please note: These are only example, you may want to remove them!*/
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    dcmd(alarm,5,cmdtext);
    dcmd(alarmend,8,cmdtext);
	return 0;
}

dcmd_alarm(playerid,params[])
{
    if(!strlen(params)) return SendClientMessage(playerid, 0xFF0000AA, "Usage: /Alarm [VEHICLEID]");
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0xFF0000AA, "You must be an RCON Administrator to use this command!");
    new idx;
    new tmp[256];
    new str[128];
    tmp = strtok(params, idx);
    if(IsVehicleConnected(strval(tmp)))
    {
    	if(alarmed[strval(tmp)] == 1)
    	{
			alarmed[strval(tmp)] = 0;
			format(str, sizeof(str), "Vehicle %d alarm deactivated.",strval(tmp));
			SendClientMessage(playerid,COLOR_FAIL,str);
		}
 		else if(alarmed[strval(tmp)] == 0)
    	{
			alarmed[strval(tmp)] = 1;
    	    format(str, sizeof(str), "Vehicle %d alarm activated.",strval(tmp));
    	    SendClientMessage(playerid,COLOR_SUCCESS,str);
		}
	}
	else
	{
        format(str, sizeof(str), "Vehicle %d doesn't exist!",strval(tmp));
        SendClientMessage(playerid,COLOR_FAIL,str);
	}
	return 1;
}

dcmd_alarmend(playerid,params[])
{
	#pragma unused params
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0xFF0000AA, "You must be an RCON Administrator to use this command!");
    new vehid = GetPlayerVehicleID(playerid);
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, 0xFF0000AA, "You must be in a vehicle to use this command!");
    if(alarmed[vehid] == 0) return SendClientMessage(playerid, 0xFF0000AA, "This vehicle is not alarmed!");
    if(beeps[vehid] == MAX_BEEPS || beeps[vehid] == 0) return SendClientMessage(playerid, 0xFF0000AA, "This vehicle is not sounding an alarm!");
    beeps[vehid] = MAX_BEEPS-1;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new veh;
	veh = GetPlayerVehicleID(playerid);
	if(GetPlayerState(playerid) == 2)
	{
		if(alarmed[veh] == 1)
		{
			SetTimerEx("beeper",BEEP_INTERVAL*1000, false, "i", veh);
		}
	}
	return 1;
}

public Alarm(vehicleid,toggle)
{
    if(IsVehicleConnected(vehicleid))
    {
    	alarmed[vehicleid] = toggle;
	}
	return 1;
}

public beeper(veh)
{
	if(beeps[veh] < MAX_BEEPS && alarmed[veh] == 1)
	{
        GetVehiclePos(veh,vehX,vehY,vehZ);
        driverid = GetVehicleDriver(veh);
		for(new x=0; x<BEEP_VOLUME; x++)
		{
		    for(new i=0; i<MAX_PLAYERS; i++)
		    {
		    	if(i != driverid) PlayerPlaySound(i, 1147, vehX,vehY,vehZ);
		    	if(i == driverid) PlayerPlaySound(i, 1147, 0.0,0.0,0.0);
			}
		}
		beeps[veh]++;
		SetTimerEx("beeper",BEEP_INTERVAL*1000, false, "i", veh);
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	beeps[vehicleid] = 0;
	return 1;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

stock IsVehicleConnected(vehicleid)
{
new Float:x1,Float:y1,Float:z1;
GetVehiclePos(vehicleid,x1,y1,z1);
if(x1==0.0 && y1==0.0 && z1==0.0)
{
return 0;
}
return 1;
}

stock GetVehicleDriver(vehicleid)
{
    for(new i; i<MAX_PLAYERS; i++)
    {
        if (IsPlayerInVehicle(i, vehicleid))
        {
            if(GetPlayerState(i) == 2)
            {
                return i;
            }
        }
    }
    return -1;
}
