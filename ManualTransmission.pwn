// This is a comment
// uncomment the line below if you want to write a filterscript

// UPDATE v1.1 Plane not have gears ( reported by Hiddos )

#define FILTERSCRIPT

#include <a_samp> // thanks to samp team

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
	
#define SpeedCheck(%0,%1,%2,%3,%4) floatround(floatsqroot(%4?(%0*%0+%1*%1+%2*%2):(%0*%0+%1*%1) ) *%3*1.6) // i dunno who made this

new GearLimit[MAX_PLAYERS];
new Gear[MAX_VEHICLES];
new Text:Geartxd[MAX_PLAYERS];

#define MAX_GEAR 4
#define VEHICLE_GEAR_SPEED 30 //use this to set the gear max speed ( speed = Gear[vehicleid] * VEHICLE_GEAR_SPEED )

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" MANUAL TRANSMISSION BY MAHAR!  LOADED  ");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	print("\n--------------------------------------");
	print(" MANUAL TRANSMISSION BY MAHAR! UNLOADED ");
	print("--------------------------------------\n");
	return 1;
}

#else

main()
{
   return 1;
}

#endif

public OnGameModeInit()
{
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
    Geartxd[playerid] = TextDrawCreate(478,413,"_"); // the gear textdraw
	TextDrawLetterSize(Geartxd[playerid],0.37,1.099999);
	TextDrawSetOutline(Geartxd[playerid],1);
    GearLimit[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    TextDrawDestroy(Geartxd[playerid]);
    GearLimit[playerid] = 0;
	return 1;
}

public OnPlayerSpawn(playerid)
{
    GearLimit[playerid] = 0;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    GearLimit[playerid] = 0;
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
    Gear[vehicleid] = 0;
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    Gear[vehicleid] = 0;
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	GearLimit[playerid] = Gear[vehicleid] * 20;
	if(GetVehicleModel(vehicleid) == 481 || GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 510)
	{
	    GearLimit[playerid] = 999;
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    GearLimit[playerid] = 0;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (PRESSED(KEY_YES)) // Gear UP
	{
		new string[128];
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 481 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 509 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 510) return GameTextForPlayer(playerid, "~n~~r~ This Vhicle Doesnt Have Engine", 1000, 2);
	    if(Gear[GetPlayerVehicleID(playerid)] <= MAX_GEAR)
	    {
	        
	        Gear[GetPlayerVehicleID(playerid)] ++;
	        format(string, sizeof(string), "~n~~w~Vehicle Gear ~r~( ~g~%d ~r~)", Gear[GetPlayerVehicleID(playerid)]);
	    	GameTextForPlayer(playerid, string, 3000, 3);
		}
		else
		{
	    	GameTextForPlayer(playerid, "~n~~r~ Max Vehicle Gear", 3000, 3);
		}
	}
	if (PRESSED(KEY_NO)) // Gear Down
	{
		new string[128];
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 481 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 509 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 510) return GameTextForPlayer(playerid, "~n~~r~ This Vhicle Doesnt Have Engine", 1000, 2);
	    if(Gear[GetPlayerVehicleID(playerid)] > -1)
	    {
	        Gear[GetPlayerVehicleID(playerid)] --;
	        format(string, sizeof(string), "~w~Vehicle Gear ~r~( ~g~%d ~r~)", Gear[GetPlayerVehicleID(playerid)]);
	        if(Gear[GetPlayerVehicleID(playerid)] == -1)
	        {
	            format(string, sizeof(string), "~w~Vehicle Gear ~r~( ~g~R ~r~)");
			}
	    	GameTextForPlayer(playerid, string, 3000, 3);
		}
	}
	return 1;
}
stock ModifyVehicleSpeed(vehicleid,mph) //Miles Per Hour
{
	new Float:Vx,Float:Vy,Float:Vz,Float:DV,Float:multiple;
	GetVehicleVelocity(vehicleid,Vx,Vy,Vz);
	DV = floatsqroot(Vx*Vx + Vy*Vy + Vz*Vz);
	if(DV > 0) //Directional velocity must be greater than 0 (display strobes if 0)
	{
		multiple = ((mph + DV * 100) / (DV * 100)); //Multiplying DV by 100 calculates speed in MPH
		return SetVehicleVelocity(vehicleid,Vx*multiple,Vy*multiple,Vz*multiple);
	}
	return 0;
}

stock IsVehicleDrivingBackwards(vehicleid) // By Joker
{
	new
		Float:Float[3]
	;
	if(GetVehicleVelocity(vehicleid, Float[1], Float[2], Float[0]))
	{
		GetVehicleZAngle(vehicleid, Float[0]);
		if(Float[0] < 90)
		{
			if(Float[1] > 0 && Float[2] < 0) return true;
		}
		else if(Float[0] < 180)
		{
			if(Float[1] > 0 && Float[2] > 0) return true;
		}
		else if(Float[0] < 270)
		{
			if(Float[1] < 0 && Float[2] > 0) return true;
		}
		else if(Float[1] < 0 && Float[2] < 0) return true;
	}
	return false;
}

stock GetVehicleSpeed(vehicleid, get3d)
{
	new Float:x, Float:y, Float:z;
	GetVehicleVelocity(vehicleid, x, y, z);
	return SpeedCheck(x, y, z, 100.0, get3d);
}

IsAPlane(carid)
{
	switch(GetVehicleModel(carid)) {
		case 592, 577, 511, 512, 593, 520, 553, 476, 519, 460, 513, 548, 425, 417, 487, 488, 497, 563, 447, 469: return 1;
	}
	return 0;
}

public OnPlayerUpdate(playerid)
{
	new string[128];
    GearLimit[playerid] = Gear[GetPlayerVehicleID(playerid)] * VEHICLE_GEAR_SPEED;
    if(Gear[GetPlayerVehicleID(playerid)] == -1)
	{
	    GearLimit[playerid] = 0;
	}
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
 		new a, b, c;
		GetPlayerKeys(playerid, a, b ,c);
		if(IsVehicleDrivingBackwards(GetPlayerVehicleID(playerid)))
		{
			if(Gear[GetPlayerVehicleID(playerid)] == -1)
			{
			    return 1;
			}
			else
			{
	    		ModifyVehicleSpeed(GetPlayerVehicleID(playerid), - GetVehicleSpeed(GetPlayerVehicleID(playerid), 0));
			}
		}
   		if(a == 8 && GetVehicleSpeed(GetPlayerVehicleID(playerid), 0) > GearLimit[playerid])
   		{
   		    if(IsVehicleDrivingBackwards(GetPlayerVehicleID(playerid)))
			{
				if(Gear[GetPlayerVehicleID(playerid)] != -1) return ModifyVehicleSpeed(GetPlayerVehicleID(playerid), - GetVehicleSpeed(GetPlayerVehicleID(playerid), 0));
			}
			if(!IsVehicleDrivingBackwards(GetPlayerVehicleID(playerid)))
			{
				if(Gear[GetPlayerVehicleID(playerid)] == -1) return ModifyVehicleSpeed(GetPlayerVehicleID(playerid), - GetVehicleSpeed(GetPlayerVehicleID(playerid), 0));
			}
      		new newspeed = GetVehicleSpeed(GetPlayerVehicleID(playerid), 0) - GearLimit[playerid];
	    	ModifyVehicleSpeed(GetPlayerVehicleID(playerid), -newspeed);
   		}
   		if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 481 || GetVehicleModel(GetPlayerVehicleID(playerid)) != 509 || GetVehicleModel(GetPlayerVehicleID(playerid)) != 510 || !IsAPlane(GetPlayerVehicleID(playerid)))
		{
  			if(IsPlayerConnected(playerid) && IsPlayerInAnyVehicle(playerid))
			{
				TextDrawShowForPlayer(playerid,Geartxd[playerid]);
				format(string,sizeof(string),"Gear: %d",Gear[GetPlayerVehicleID(playerid)]);
				if(Gear[GetPlayerVehicleID(playerid)] == -1)
				{
				    format(string,sizeof(string),"Gear: R");
				}
				TextDrawSetString(Geartxd[playerid],string);
			}
		}
		else if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 481 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 509 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 510 || !IsAPlane(GetPlayerVehicleID(playerid)))
		{
		    GearLimit[playerid] = 999;
 		}
 		return 1;
 	}
	if(!IsPlayerInAnyVehicle(playerid))
	{
		TextDrawHideForPlayer(playerid,Geartxd[playerid]);
	}
	return 1;
}