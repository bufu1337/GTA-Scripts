
/*  Cruiser dash mounted speed radar
	made by Srdjan. Today's date 31/08/2011
	All credits go to me                   */


#include <a_samp>

#define COLOR_YELLOW 0xFFFF00AA

new VehRadarID [MAX_VEHICLES];
new Text: RadarHud;
new Text: SpeedAndModel [MAX_VEHICLES];
new CheckingSpeed [MAX_VEHICLES];
new OldVehID [MAX_PLAYERS];

forward UpdateSpeed (vehid);
forward CheckValidTextDraws();


new VehicleModel[212][] ={
"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial","Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana",
"Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance","Leviathan", "Moonbeam", "Esperanto", "Taxi",
"Washington", "Bobcat","Whoopee", "BF Injection", "Hunter", "Premier","Enforcer", "Securicar", "Banshee",
"Predator", "Bus", "Rhino", "Barracks", "Hotknife","Trailer 1", "Previon", "Coach", "Cabbie", "Stallion",
"Rumpo", "RC Bandit", "Romero", "Packer","Monster", "Admiral", "Squalo","Seasparrow", "Pizzaboy", "Tram", "Trailer 2",
"Turismo", "Speeder", "Reefer", "Tropic","Flatbed", "Yankee", "Caddy", "Solair","Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio",
"Freeway", "RC Baron", "RC Raider","Glendale", "Oceanic", "Sanchez", "Sparrow","Patriot", "Quad", "Coastguard", "Dinghy", "Hermes",
"Sabre", "Rustler", "ZR-350","Walton", "Regina", "Comet", "BMX", "Burrito","Camper", "Marquis", "Baggage", "Dozer", "Maverick",
"News Chopper", "Rancher","FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring","Sandking", "Blista Compact", "Police Maverick",
"Boxvillde", "Benson","Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B","Bloodring Banger", "Rancher", "Super GT", "Elegant",
"Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster","Stunt",  "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer",
"Shamal", "Hydra","FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune","Cadrona", "FBI Truck", "Willard",
"Forklift", "Tractor", "Combine","Feltzer", "Remington", "Slamvan", "Blade", "Freight","Streak","Vortex", "Vincent", "Bullet",
"Clover", "Sadler", "Firetruck LA","Hustler", "Intruder", "Primo", "Cargobob", "Tampa","Sunrise", "Merit","Utility", "Nevada",
"Yosemite", "Windsor", "Monster A", "Monster B", "Uranus", "Jester", "Sultan","Stratum", "Elegy", "Raindance","RC Tiger",
"Flash", "Tahoma", "Savanna", "Bandito","Freight Flat", "Streak Carriage", "Kart","Mower", "Dune", "Sweeper", "Broadway",
"Tornado", "AT-400", "DFT-30", "Huntley", "Stafford","BF-400", "News Van", "Tug", "Trailer 3", "Emperor","Wayfarer", "Euros",
"Hotdog","Club", "Freight Carriage", "Trailer 4","Andromada", "Dodo", "RC Cam", "Launch", "Police Car (LSPD)","Police Car (SFPD)",
"Police Car (LVPD)", "Police Ranger", "Picador", "S.W.A.T", "Alpha","Phoenix", "Glendale", "Sadler", "Luggage Trailer A",
"Luggage Trailer B", "Stairs", "Boxville", "Tiller", "Utility Trailer" };


public OnFilterScriptInit ()
{
	printf (" \nCruiser speed radar made by Srdjan loaded.\n");

	SetTimer ("CheckValidTextDraws", 1000, 1);

	RadarHud = TextDrawCreate (495.0, 200.0, "~b~Model: ~n~~r~Speed:         kmph");
	TextDrawFont (RadarHud, 2);
	TextDrawLetterSize (RadarHud, 0.3, 1.0);

	for (new i = 1; i <= MAX_VEHICLES; i++)
	{
	    VehRadarID [i] = -1;
	    SpeedAndModel [i] = TextDrawCreate (545.0, 200.0, "~b~ ~n~~r~");
	    TextDrawFont (SpeedAndModel [i], 2);
	    TextDrawLetterSize (SpeedAndModel [i], 0.3, 1.0);
	    CheckingSpeed [i] = 0;
	}

	return 1;
}

public OnPlayerCommandText (playerid, cmdtext[])
{
	if (!strcmp (cmdtext, "/placeradar"))
	{
		if (IsPlayerInAnyVehicle (playerid))
		{
		    new vehid = GetPlayerVehicleID (playerid);
		    if (VehRadarID [vehid] > -1) return 1;

            new Float: x, Float: y, Float: z, Float: a;
		    GetVehiclePos (vehid, x, y, z);
		    GetVehicleZAngle (vehid, a);
		    SendClientMessage (playerid, COLOR_YELLOW, "Radar has been added successfully.");
		    VehRadarID [vehid] = CreateObject (367, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 300.0);
		    AttachObjectToVehicle (VehRadarID [vehid], vehid, 0.2, 0.50, 0.3, 0.0, 0.0, 90.0);

		    for (new i = 0; i < MAX_PLAYERS; i++)
		    {
		        if (IsPlayerInVehicle (i, vehid))
		        {
          			TextDrawShowForPlayer (i, RadarHud);
				}
		    }
  		}
		return 1;
	}

	if (!strcmp (cmdtext, "/removeradar"))
	{
	    if (IsPlayerInAnyVehicle (playerid))
	    {
	        new vehid = GetPlayerVehicleID (playerid);
	        if (VehRadarID [vehid] == -1) return 1;

		    DestroyObject (VehRadarID [vehid]);
	        SendClientMessage (playerid, COLOR_YELLOW, "Radar has been removed successfully.");
	        VehRadarID [vehid] = -1;
	        KillTimer (CheckingSpeed [vehid]);
         	CheckingSpeed [vehid] = -1;

	        for (new i = 0; i < MAX_PLAYERS; i++)
		    {
		        if (IsPlayerInVehicle (i, vehid))
		        {
					TextDrawHideForPlayer (i, RadarHud);
					TextDrawHideForPlayer (playerid, SpeedAndModel [vehid]);
		        }
		    }
	    }
	    return 1;
	}

	if (!strcmp (cmdtext, "/checkspeed"))
	{
	    if (IsPlayerInAnyVehicle (playerid))
	    {
	        new vehid = GetPlayerVehicleID (playerid);
	        if (VehRadarID [vehid] == -1) return 1;
	        CheckingSpeed [vehid] = SetTimerEx ("UpdateSpeed", 100, 1, "d", vehid);
  	    }
	    return 1;
	}

	if (!strcmp (cmdtext, "/stopchecking"))
	{
	    if (IsPlayerInAnyVehicle (playerid))
	    {
	        new vehid = GetPlayerVehicleID (playerid);
	        if (CheckingSpeed [vehid] > 0)
	        {
	            KillTimer (CheckingSpeed [vehid]);
	            CheckingSpeed [vehid] = -1;
	        }
	        for (new i = 0; i < MAX_PLAYERS; i++)
			{
				if (IsPlayerInVehicle (i, vehid))
	    		{
		    		TextDrawHideForPlayer (i, SpeedAndModel [vehid]);
 				}
			}
	    }
	    return 1;
	}

	if (!strcmp (cmdtext, "/issueticket"))
	{
	    if (IsPlayerInAnyVehicle (playerid))
	    {
	        new vehid = GetPlayerVehicleID (playerid);
	        if (CheckingSpeed [vehid] > -1)
	        {
	            for (new i = 0; i < MAX_PLAYERS; i++)
	            {
	                if (IsPlayerConnected (i) && i != playerid)
	                {
	                    if (IsPlayerInVehicle (i, GetVehicleInfrontID (vehid)))
	                    {
	                        if (GetPlayerVehicleSeat (i) == 0)
	                        {
	                            GivePlayerMoney (i, -1500);
	                        }
	                    }
	                }
	            }
	        }
	    }
	    return 1;
	}

	return 0;
}

GetVehicleInfrontID (vehid)
{
    new Float: temp = 7.0;
	new j = 0;
	for (new i = 1; i <= MAX_VEHICLES; i++)
	{
	    new Float: a, Float: x1, Float: y1, Float: z1, Float: x2, Float: y2, Float: z2;
    	GetVehiclePos (vehid, x1, y1, z1);
    	GetVehicleZAngle (vehid, a);
 		if (i != vehid)
 		{
	 		if (GetVehiclePos (i, x2, y2, z2))
			{
				new Float: distance = floatsqroot (floatpower ((x1 - x2), 2) + floatpower ((y1 - y2), 2) + floatpower ((z1 - z2), 2));
				GetVehicleZAngle (vehid, a);

				if (distance < 300.0)
				{
    				x1 = x1 + (distance * floatsin(-a, degrees));
					y1 = y1 + (distance * floatcos(-a, degrees));

					distance = floatsqroot ((floatpower ((x1 - x2), 2)) + (floatpower ((y1 - y2), 2)));

					if (temp > distance)
					{
						temp = distance;
						j = i;
					}
				}
			}
		}
	}
	if (temp < 7.0) return j;
	return -1;
}

public UpdateSpeed (vehid)
{
    new id = GetVehicleInfrontID (vehid);
	if (id < 0)
	{
   		TextDrawSetString (SpeedAndModel [vehid], "~b~N/A ~n~~r~N/A");
	}
	else
	{
		new str[32], Float: velocityX, Float: velocityY, Float: velocityZ;
	   	GetVehicleVelocity (id, velocityX, velocityY, velocityZ);
       	new speed = floatround (floatsqroot (floatpower (velocityX, 2) + floatpower (velocityY, 2) + floatpower (velocityZ, 2)) * 136.666667, floatround_round);
		format (str, sizeof (str), "~b~%s ~n~~r~%d", VehicleModel [GetVehicleModel (id) - 400], speed);
		TextDrawSetString (SpeedAndModel [vehid], str);
	}

 	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerInVehicle (i, vehid))
	    {
		    TextDrawShowForPlayer (i, SpeedAndModel [vehid]);
 		}
	}
	return 1;
}

public CheckValidTextDraws()
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
	    if (IsPlayerConnected (i))
	    {
			if (IsPlayerInAnyVehicle (i))
			{
			    new vehid = GetPlayerVehicleID (i);
			    if (VehRadarID [vehid] > -1)
			    {
			        TextDrawShowForPlayer (i, RadarHud);
			        if (CheckingSpeed [vehid] > 0)
			        {
			            TextDrawShowForPlayer (i, SpeedAndModel [vehid]);
			        }
			        else
			        {
			            TextDrawHideForPlayer (i, SpeedAndModel [vehid]);
			        }
			    }
			    else
			    {
			        TextDrawHideForPlayer (i, RadarHud);
			    }
			}

			else
			{
			    TextDrawHideForPlayer (i, RadarHud);
			    TextDrawHideForPlayer (i, SpeedAndModel [OldVehID[i]]);
			    OldVehID [i] = 0;
			}
	    }
	}
	return 1;
}

public OnPlayerStateChange (playerid, newstate, oldstate)
{
	if ((oldstate == PLAYER_STATE_ONFOOT) && (newstate == PLAYER_STATE_PASSENGER || newstate == PLAYER_STATE_DRIVER))
	{
	     OldVehID [playerid] = GetPlayerVehicleID (playerid);
	}
	return 1;
}

public OnVehicleDeath (vehicleid)
{
    DestroyObject (VehRadarID [vehicleid]);
    VehRadarID [vehicleid] = -1;
    KillTimer (CheckingSpeed [vehicleid]);
  	CheckingSpeed [vehicleid] = -1;
 	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerInVehicle (i, vehicleid))
 		{
			TextDrawHideForPlayer (i, RadarHud);
			TextDrawHideForPlayer (i, SpeedAndModel [vehicleid]);
		}
	}
}