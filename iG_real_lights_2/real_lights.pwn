/*************************************************
Infinite-Gaming.com Presents:
Real Vehicle Lights v.2 by Cyber_Punk

DO NOT REMOVE CREDITS
If you borrow bits of code would be nice to..
credit the original authors

NEW - Public vehicles - Police, FBI, FIRE, Medic have flashing lights with the siren button (horn)
NEWv2 - Fixed a couple bugs, reworked the blinker system PRESS Look Left or Look Right to activate blinker
If you turn the wheel in the opposite direction than the blinker it will auto shut off. Just like a real car :P

Know issues (not script bugs)
Lights still will not flash in the day time,
Rear lights do not flash......
Hope for a samp fix in 0.3b code should still work
*************************************************/
#include <a_samp>

#define BLINK_RATE  	400 // This is the rate of flash (also rate of timer in milliseconds, same for pflash)
#define PFLASH_RATE     300 // This controls the rate of flash for public vehicle lights, works for all police, fire, ambulance vehicles
#define LIGHT_KEY		KEY_SUBMISSION // Set this to whatever key you want to turn the lights on

//Put MAX PLAYERS HERE (sorry its for the timer..)
#undef MAX_PLAYERS
	#define MAX_PLAYERS 50
	
// Macro from SAMP wiki Credits to the author
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

new BlinkTime[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Infinite-Gaming.com Presents:");
	print(" Real Vehicle Lights v2 by Cyber_Punk");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	print("\n--------------------------------------");
	print(" Real Vehicle Lights UNLOADED");
	print("--------------------------------------\n");
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	KillTimer(BlinkTime[playerid]);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
		new panels, doors, lights, tires;
		new carid = GetPlayerVehicleID(playerid);
		GetVehicleDamageStatus(carid, panels, doors, lights, tires);
		lights = encode_lights(1, 1, 1, 1);
		SetPVarInt(playerid, "vMainOn", 0);
		UpdateVehicleDamageStatus(carid, panels, doors, lights, tires);
	}
	else if(newstate == PLAYER_STATE_ONFOOT)
	{
		KillTimer(BlinkTime[playerid]);
		SetPVarInt(playerid, "CopFlash", 0);
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(LIGHT_KEY))
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0)
		{
			if(GetPVarInt(playerid, "CopFlash") == 0)
			{
		 		new panels, doors, lights, tires;
		 		new carid = GetPlayerVehicleID(playerid);
				GetVehicleDamageStatus(carid, panels, doors, lights, tires);
				switch(GetPVarInt(playerid, "vMainOn"))
				{
				    case 0:{
				        lights = encode_lights(0, 0, 0, 0);
		      			SetPVarInt(playerid, "vMainOn", 1);
					}
					case 1:{
						lights = encode_lights(1, 1, 1, 1);
						SetPVarInt(playerid, "vMainOn", 0);
					}
				}
				UpdateVehicleDamageStatus(carid, panels, doors, lights, tires);
			}
		}
	}
	if(PRESSED(KEY_CROUCH))
	{
	    if(IsPublicService(GetPlayerVehicleID(playerid)) && GetPlayerVehicleSeat(playerid) == 0)
		{
			switch(GetPVarInt(playerid, "CopFlash"))
			{
				case 0:{
				    KillTimer(BlinkTime[playerid]);
					BlinkTime[playerid] = SetTimerEx("vBlinker", PFLASH_RATE, 1, "i", playerid);
					SetPVarInt(playerid, "CopFlash", 1);
				}
				case 1:{
		   			KillTimer(BlinkTime[playerid]);
   					new panels, doors, lights, tires;
   					new carid = GetPlayerVehicleID(playerid);
					GetVehicleDamageStatus(carid, panels, doors, lights, tires);
					lights = encode_lights(1, 1, 1, 1);
					UpdateVehicleDamageStatus(carid, panels, doors, lights, tires);
					SetPVarInt(playerid, "CopFlash", 0);
				}
			}
		}
	}
	if(PRESSED(KEY_LOOK_LEFT))
	{
		if(GetPlayerVehicleSeat(playerid) == 0)
		{
			if(GetPVarInt(playerid, "vBLeft") == 0)
			{
				KillTimer(BlinkTime[playerid]);
				BlinkTime[playerid] = SetTimerEx("vBlinker", BLINK_RATE, 1, "i", playerid);
	   			SetPVarInt(playerid, "vBLeft", 1);
	   			SetPVarInt(playerid, "vBRight", 0);
			}else{
			    KillTimer(BlinkTime[playerid]);
				new panels, doors, lights, tires;
				new carid = GetPlayerVehicleID(playerid);
				GetVehicleDamageStatus(carid, panels, doors, lights, tires);
			    switch(GetPVarInt(playerid, "vMainOn")){
			        case 0:{
			        	lights = encode_lights(1, 1, 1, 1);
					}
					case 1:{
	                    lights = encode_lights(0, 0, 0, 0);
					}
				}
				UpdateVehicleDamageStatus(carid, panels, doors, lights, tires);
			    SetPVarInt(playerid, "vBLeft", 0);
			}
		}
	}
	if(PRESSED(KEY_LOOK_RIGHT))
	{
		if(GetPlayerVehicleSeat(playerid) == 0)
		{
			if(GetPVarInt(playerid, "vBRight") == 0)
			{
				KillTimer(BlinkTime[playerid]);
				BlinkTime[playerid] = SetTimerEx("vBlinker", BLINK_RATE, 1, "i", playerid);
	   			SetPVarInt(playerid, "vBRight", 1);
	   			SetPVarInt(playerid, "vBLeft", 0);
			}else{
			    KillTimer(BlinkTime[playerid]);
				new panels, doors, lights, tires;
				new carid = GetPlayerVehicleID(playerid);
				GetVehicleDamageStatus(carid, panels, doors, lights, tires);
			    switch(GetPVarInt(playerid, "vMainOn")){
			        case 0:{
			        	lights = encode_lights(1, 1, 1, 1);
					}
					case 1:{
	                    lights = encode_lights(0, 0, 0, 0);
					}
				}
				UpdateVehicleDamageStatus(carid, panels, doors, lights, tires);
			    SetPVarInt(playerid, "vBRight", 0);
			}
		}
	}
	return 1;
}

forward vBlinker(playerid);
public vBlinker(playerid)
{
	if(IsPlayerInAnyVehicle(playerid) && GetPVarInt(playerid, "CopFlash") != 1)
	{
	    new Keys, ud, lr, panels, doors, lights, tires;
	    new carid = GetPlayerVehicleID(playerid);
	    GetPlayerKeys(playerid, Keys, ud, lr);
		GetVehicleDamageStatus(carid, panels, doors, lights, tires);

		if(lr > 0)
		{
			if(GetPVarInt(playerid, "vBLeft") == 1)
			{
			    KillTimer(BlinkTime[playerid]);
			    switch(GetPVarInt(playerid, "vMainOn")){
			        case 0:{
			        	lights = encode_lights(1, 1, 1, 1);
					}
					case 1:{
	                    lights = encode_lights(0, 0, 0, 0);
					}
				}
				UpdateVehicleDamageStatus(carid, panels, doors, lights, tires);
			    SetPVarInt(playerid, "vBLeft", 0);
			    return 1;
			}
		}
		else if(lr < 0)
		{
			if(GetPVarInt(playerid, "vBRight") == 1)
			{
			    KillTimer(BlinkTime[playerid]);
			    switch(GetPVarInt(playerid, "vMainOn")){
			        case 0:{
			        	lights = encode_lights(1, 1, 1, 1);
					}
					case 1:{
	                    lights = encode_lights(0, 0, 0, 0);
					}
				}
				UpdateVehicleDamageStatus(carid, panels, doors, lights, tires);
			    SetPVarInt(playerid, "vBRight", 0);
			    return 1;
			}
		}

		if(GetPVarInt(playerid, "vBRight") == 1)
		{
			switch(GetPVarInt(playerid, "vMainOn")){
			    case 0:{
	      			switch(GetPVarInt(playerid, "vBlinkOn")){
	      			    case 0:{
			        		lights = encode_lights(1, 1, 0, 0);
	      					SetPVarInt(playerid, "vBlinkOn", 1);
	      			    }
	      			    case 1:{
							lights = encode_lights(1, 1, 1, 1);
							SetPVarInt(playerid, "vBlinkOn", 0);
	      			    }
					}
				}
				case 1:{
      				switch(GetPVarInt(playerid, "vBlinkOn")){
	      			    case 0:{
			        		lights = encode_lights(0, 0, 1, 1);
	      					SetPVarInt(playerid, "vBlinkOn", 1);
	      			    }
	      			    case 1:{
							lights = encode_lights(0, 0, 0, 0);
							SetPVarInt(playerid, "vBlinkOn", 0);
	      			    }
					}
				}
			}
		}
		
		if(GetPVarInt(playerid, "vBLeft") == 1)
		{
			switch(GetPVarInt(playerid, "vMainOn")){
			    case 0:{
	      			switch(GetPVarInt(playerid, "vBlinkOn")){
	      			    case 0:{
			        		lights = encode_lights(0, 0, 1, 1);
	      					SetPVarInt(playerid, "vBlinkOn", 1);
	      			    }
	      			    case 1:{
							lights = encode_lights(1, 1, 1, 1);
							SetPVarInt(playerid, "vBlinkOn", 0);
	      			    }
					}
				}
				case 1:{
      				switch(GetPVarInt(playerid, "vBlinkOn")){
	      			    case 0:{
			        		lights = encode_lights(1, 1, 0, 0);
	      					SetPVarInt(playerid, "vBlinkOn", 1);
	      			    }
	      			    case 1:{
							lights = encode_lights(0, 0, 0, 0);
							SetPVarInt(playerid, "vBlinkOn", 0);
	      			    }
					}
				}
			}
		}
		UpdateVehicleDamageStatus(carid, panels, doors, lights, tires);
	}
	else if(GetPVarInt(playerid, "CopFlash") == 1)
	{
	    new d[4];
	    new carid = GetPlayerVehicleID(playerid);
		GetVehicleDamageStatus(carid, d[0], d[1], d[2], d[3]);

		switch(GetPVarInt(playerid, "vBlinkOn"))
		{
		   case 0:{
				d[2] = encode_lights(1, 1, 0, 0);
				SetPVarInt(playerid, "vBlinkOn", 1);
		   }
		   case 1:{
				d[2] = encode_lights(0, 0, 1, 1);
				SetPVarInt(playerid, "vBlinkOn", 0);
		   }
		}
		UpdateVehicleDamageStatus(carid, d[0], d[1], d[2], d[3]);
		return 1;
	}
	return 1;
}
// Thanks to JernejL (RedShirt)
encode_lights(light1, light2, light3, light4) {

	return light1 | (light2 << 1) | (light3 << 2) | (light4 << 3);

}

IsPublicService(carid)
{
    new PS[11] = { 416, 427, 490, 528, 407, 544, 596, 598, 597, 599, 601 };
    for(new i = 0; i < sizeof(PS); i++)
	{
		if(GetVehicleModel(carid) == PS[i]) return 1;
	}
	return 0;
}
