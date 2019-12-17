/*x---------------------------------Important-------------------------------------x*/
//**INCLUDES**//
#include <a_samp>
//**DEFINES**//
#define RECOVERYLENGH   20 // seconds
#define HEALTHLOSS      2 // For the vehicle dammage function
/*x---------------------------------Defining-------------------------------------x*/
//**VARIABLES**//
new VehicleName[][] = {
   "Landstalker",
   "Bravura",
   "Buffalo",
   "Linerunner",
   "Pereniel",
   "Sentinel",
   "Dumper",
   "Firetruck",
   "Trashmaster",
   "Stretch",
   "Manana",
   "Infernus",
   "Voodoo",
   "Pony",
   "Mule",
   "Cheetah",
   "Ambulance",
   "Leviathan",
   "Moonbeam",
   "Esperanto",
   "Taxi",
   "Washington",
   "Bobcat",
   "Mr Whoopee",
   "BF Injection",
   "Hunter",
   "Premier",
   "Enforcer",
   "Securicar",
   "Banshee",
   "Predator",
   "Bus",
   "Rhino",
   "Barracks",
   "Hotknife",
   "Trailer",
   "Previon",
   "Coach",
   "Cabbie",
   "Stallion",
   "Rumpo",
   "RC Bandit",
   "Romero",
   "Packer",
   "Monster Truck",
   "Admiral",
   "Squalo",
   "Seasparrow",
   "Pizzaboy",
   "Tram",
   "Trailer",
   "Turismo",
   "Speeder",
   "Reefer",
   "Tropic",
   "Flatbed",
   "Yankee",
   "Caddy",
   "Solair",
   "Berkley's RC Van",
   "Skimmer",
   "PCJ-600",
   "Faggio",
   "Freeway",
   "RC Baron",
   "RC Raider",
   "Glendale",
   "Oceanic",
   "Sanchez",
   "Sparrow",
   "Patriot",
   "Quad",
   "Coastguard",
   "Dinghy",
   "Hermes",
   "Sabre",
   "Rustler",
   "ZR-350",
   "Walton",
   "Regina",
   "Comet",
   "BMX",
   "Burrito",
   "Camper",
   "Marquis",
   "Baggage",
   "Dozer",
   "Maverick",
   "News Chopper",
   "Rancher",
   "FBI Rancher",
   "Virgo",
   "Greenwood",
   "Jetmax",
   "Hotring",
   "Sandking",
   "Blista Compact",
   "Police Maverick",
   "Boxville",
   "Benson",
   "Mesa",
   "RC Goblin",
   "Hotring Racer",
   "Hotring Racer",
   "Bloodring Banger",
   "Rancher",
   "Super GT",
   "Elegant",
   "Journey",
   "Bike",
   "Mountain Bike",
   "Beagle",
   "Cropdust",
   "Stunt",
   "Tanker",
   "RoadTrain",
   "Nebula",
   "Majestic",
   "Buccaneer",
   "Shamal",
   "Hydra",
   "FCR-900",
   "NRG-500",
   "HPV1000",
   "Cement Truck",
   "Tow Truck",
   "Fortune",
   "Cadrona",
   "FBI Truck",
   "Willard",
   "Forklift",
   "Tractor",
   "Combine",
   "Feltzer",
   "Remington",
   "Slamvan",
   "Blade",
   "Freight",
   "Streak",
   "Vortex",
   "Vincent",
   "Bullet",
   "Clover",
   "Sadler",
   "Firetruck",
   "Hustler",
   "Intruder",
   "Primo",
   "Cargobob",
   "Tampa",
   "Sunrise",
   "Merit",
   "Utility",
   "Nevada",
   "Yosemite",
   "Windsor",
   "Monster Truck",
   "Monster Truck",
   "Uranus",
   "Jester",
   "Sultan",
   "Stratum",
   "Elegy",
   "Raindance",
   "RC Tiger",
   "Flash",
   "Tahoma",
   "Savanna",
   "Bandito",
   "Freight",
   "Trailer",
   "Kart",
   "Mower",
   "Duneride",
   "Sweeper",
   "Broadway",
   "Tornado",
   "AT-400",
   "DFT-30",
   "Huntley",
   "Stafford",
   "BF-400",
   "Newsvan",
   "Tug",
   "Trailer",
   "Emperor",
   "Wayfarer",
   "Euros",
   "Hotdog",
   "Club",
   "Trailer",
   "Trailer",
   "Andromada",
   "Dodo",
   "RC Cam",
   "Launch",
   "Police Car (LSPD)",
   "Police Car (SFPD)",
   "Police Car (LVPD)",
   "Police Ranger",
   "Picador",
   "S.W.A.T. Van",
   "Alpha",
   "Phoenix",
   "Glendale",
   "Sadler",
   "Luggage Trailer",
   "Luggage Trailer",
   "Stair Trailer",
   "Boxville",
   "Farm Plow",
   "Utility Trailer"
};
new fvh[700];
new fv[700];
new vd[700];
new ve[700];
new vs[700];
new Float:vhpd[700][3];
enum SPS
{
    Float:VEHX,
    Float:VEHY,
    Float:VEHZ
}
new PlayerPos[200][SPS];
//**FORWARDS**//
forward FrzVehHP(veh,Float:hp);
forward FrzVeh(veh,Float:VX,Float:VY,Float:VZ,Float:VA);
forward VehResprayed(veh,Float:VX,Float:VY,Float:VZ,Float:VA);
forward VehDes(veh);
forward VehDmgToPlayer(playerid, vehicleid);
forward AntiVehExp(vehicleid);
forward VehRecov(vehicleid);
forward VehStats(vehicleid);
//**NATIVES**//
/*
	native FreezeVehicleHealth(vehicleid,Float:vhp,toggle);
	native FreezeVehicle(vehicleid,toggle);
	native ResprayVehicle(vehicleid);
	native SetVehiclePosEx(vehicleid, Float:VX,Float:VY,Float:VZ,Float:VA);
	native GetVehicleName(vehicleid);
	native EraseVehicle(vehicleid);
	native AffectVehicleDamageToPlayer(playerid, vehicleid, toggle);
	native AllowVehicleExplosion(vehicleid,allow);
	native DisplayVehicleStats(vehicleid, display);
	native KillVehicle(vehicleid);
*/
/*x---------------------------------CallBacks-------------------------------------x*/
stock FreezeVehicleHealth(vehicleid,Float:vhp,toggle)
{
	SetVehicleHealth(vehicleid,vhp);
	if (toggle == 0) fvh[vehicleid] = SetTimerEx("FrzVehHP",500,1,"if",vehicleid,vhp);
	else KillTimer(fvh[vehicleid]);
}

stock FreezeVehicle(vehicleid,toggle)
{
	new Float:fvX,Float:fvY,Float:fvZ,Float:fvA;
	new mp = GetMaxPlayers();
	for(new all = 0; all < mp; all++)
	{
	    if (GetPlayerState(all) == 2)
	    {
	        if (GetPlayerVehicleID(all) == vehicleid)
	        {
	            TogglePlayerControllable(all,0);
				TogglePlayerControllable(all,1);
	        }
	    }
	}
	GetVehiclePos(vehicleid,fvX,fvY,fvZ);
 	GetVehicleZAngle(vehicleid,fvA);
 	if (toggle == 0) fv[vehicleid] = SetTimerEx("FrzVeh",200,1,"iffff",vehicleid,fvX,fvY,fvZ,fvA);
	else KillTimer(fv[vehicleid]);
}

stock ResprayVehicle(vehicleid)
{
    new Float:fvX,Float:fvY,Float:fvZ,Float:fvA;
    GetVehiclePos(vehicleid,fvX,fvY,fvZ);
 	GetVehicleZAngle(vehicleid,fvA);
 	new colors = random(100);
 	new count = 0;
	for(new playerid = 0; playerid < GetMaxPlayers(); playerid++)
	{
	    if (GetPlayerState(playerid) == 2 && IsPlayerInVehicle(playerid,vehicleid))
		{
		    new Float:PX,Float:PY,Float:PZ,Float:PA,Float:px,Float:py,Float:pz;
		    GetPlayerPos(playerid,PX,PY,PZ);
		    GetPlayerPos(playerid,px,py,pz);
		    GetPlayerFacingAngle(playerid,PA);
		    py -= (5 * floatcos(-PA, degrees));
		    px -= (5 * floatsin(-PA, degrees));
		    PZ += 1;
		    SetPlayerCameraPos(playerid,px,py,PZ);
		    SetPlayerCameraLookAt(playerid,PX,PY,PZ);
		    GivePlayerMoney(playerid,100);
			SetVehiclePos(vehicleid, 2067.7327,-1831.5408,13.2523);
 			SetVehicleZAngle(vehicleid, 185.7243);
 			SetTimerEx("VehResprayed",3000,0,"iffff",vehicleid,fvX,fvY,fvZ,fvA);
 			break;
		}
		else if (GetPlayerState(playerid) != 2 && !IsPlayerInVehicle(playerid,vehicleid) && count == 0)
		{
		    SetVehicleToRespawn(vehicleid);
		    ChangeVehicleColor(vehicleid,colors,colors);
			SetTimerEx("VehResprayed",1000,0,"iffff",vehicleid,fvX,fvY,fvZ,fvA);
			break;
		}
	}
}

stock SetVehiclePosEx(vehicleid, Float:VX,Float:VY,Float:VZ,Float:VA)
{
	SetVehiclePos(vehicleid,VX,VY,VZ);
	SetVehicleZAngle(vehicleid,VA);
}

stock GetVehicleName(vehicleid)
{
	new vn[50];
	format(vn,sizeof(vn),"%s",VehicleName[GetVehicleModel(vehicleid)-400]);
	return vn;
}

stock EraseVehicle(vehicleid)
{
    for(new playerid = 0; playerid < GetMaxPlayers(); playerid++)
    {
        new Float:PX,Float:PY,Float:PZ;
        if (IsPlayerInVehicle(playerid,vehicleid))
        {
            GetPlayerPos(playerid,PX,PY,PZ);
            SetPlayerPos(playerid,PX,PY,PZ+2);
            SetVehicleToRespawn(vehicleid);
            SetVehicleParamsForPlayer(vehicleid,playerid,0,1);
            SetTimerEx("VehDes",3000,0,"d",vehicleid);
            break;
        }
        else SetTimerEx("VehDes",3000,0,"d",vehicleid),break;
    }
}

stock AffectVehicleDamageToPlayer(playerid, vehicleid, toggle) // Credit goes to Alistair for this function
{
	if (toggle == 0) vd[vehicleid] = SetTimerEx("VehDmgToPlayer",200,1,"ii",playerid, vehicleid);
	else if (toggle == 1) KillTimer(vd[vehicleid]);
}

stock AllowVehicleExplosion(vehicleid,allow)
{
	if (allow == 0) ve[vehicleid] = SetTimerEx("AntiVehExp",300,1,"i",vehicleid);
	else if (allow == 1) KillTimer(ve[vehicleid]);
}

stock DisplayVehicleStats(vehicleid, display)
{
	if (display == 0) vs[vehicleid] = SetTimerEx("VehStats",500,1,"i",vehicleid);
	else if (display == 1) KillTimer(vs[vehicleid]);
}

stock KillVehicle(vehicleid)
{
	new Float:VX,Float:VY,Float:VZ;
	GetVehiclePos(vehicleid,VX,VY,VZ);
	SetVehicleHealth(vehicleid, 0);
	CreateExplosion(VX,VY,VZ,1,3);
}

public FrzVehHP(veh,Float:hp)
{
	SetVehicleHealth(veh,hp);
}

public FrzVeh(veh,Float:VX,Float:VY,Float:VZ,Float:VA)
{
	SetVehiclePos(veh,VX,VY,VZ);
	SetVehicleZAngle(veh,VA);
}

public VehResprayed(veh,Float:VX,Float:VY,Float:VZ,Float:VA)
{
	SetVehiclePos(veh,VX,VY,VZ);
	SetVehicleZAngle(veh,VA);
	SetVehicleHealth(veh,1000.0);
	for(new playerid = 0; playerid < GetMaxPlayers(); playerid++) if (IsPlayerInVehicle(playerid,veh)) SetCameraBehindPlayer(playerid);
}

public VehDes(veh) DestroyVehicle(veh);

public VehDmgToPlayer(playerid, vehicleid)
{
    if (IsPlayerInVehicle(playerid,vehicleid))
   	{
  		GetVehicleHealth(vehicleid, vhpd[vehicleid][0]);
   		if (floatcmp(vhpd[vehicleid][0], vhpd[vehicleid][1]) == -1)
    	{
           	GetPlayerHealth(playerid, vhpd[vehicleid][2]);
           	SetPlayerHealth(playerid, floatsub(vhpd[vehicleid][2], HEALTHLOSS));
    	}
       	vhpd[vehicleid][1] = vhpd[vehicleid][0];
   	}
}

public AntiVehExp(vehicleid)
{
	for(new playerid = 0; playerid < GetMaxPlayers(); playerid++)
	{
	    if (IsPlayerInVehicle(playerid, vehicleid))
	    {
	        new Float:vhp;
	        GetVehicleHealth(vehicleid, vhp);
	        if (vhp <= 400)
	        {
	            KillTimer(ve[vehicleid]);
	            SetVehicleHealth(vehicleid,401);
	            TogglePlayerControllable(playerid,0);
	            GameTextForPlayer(playerid, "~g~~h~Recovering...", RECOVERYLENGH+1*1000, 6);
	            SetTimerEx("VehRecov",RECOVERYLENGH*1000,false,"i",vehicleid);
	            break;
	        }
	    }
	}
}

public VehRecov(vehicleid)
{
    for(new playerid = 0; playerid < GetMaxPlayers(); playerid++)
	{
	    new Float:hp;
	    GetPlayerHealth(playerid,hp);
	    if (IsPlayerInVehicle(playerid, vehicleid))
	    {
	        if (hp > 15)
	        {
	            SetVehicleHealth(vehicleid,600);
	            SetPlayerHealth(playerid,15);
	            TogglePlayerControllable(playerid,1);
	            ve[vehicleid] = SetTimerEx("AntiVehExp",300,1,"i",vehicleid);
	            break;
	        }
	        else
	        {
	            SetVehicleHealth(vehicleid,600);
	            TogglePlayerControllable(playerid,1);
	            ve[vehicleid] = SetTimerEx("AntiVehExp",300,1,"i",vehicleid);
	            break;
	        }
	    }
	}
}

public VehStats(vehicleid) // Credit goes to Sacky for MPH and KPH
{
	for(new playerid = 0; playerid < GetMaxPlayers(); playerid++)
	{
		if (IsPlayerInVehicle(playerid, vehicleid))
		{
    		new Float:vhp,string[128],Float:value,Float:distance,Float:vehx,Float:vehy,Float:vehz;
			GetPlayerPos(playerid, vehx, vehy, vehz);
 			distance = floatsqroot(floatpower(floatabs(floatsub(vehx,PlayerPos[playerid][VEHX])),2)+floatpower(floatabs(floatsub(vehy,PlayerPos[playerid][VEHY])),2)+floatpower(floatabs(floatsub(vehz,PlayerPos[playerid][VEHZ])),2));
  			value = floatround(distance * 11000);
			GetVehicleHealth(vehicleid,vhp);
			if (vhp >= 900 && vhp <= 1000)
			{
				format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~w~Vehicle: ~b~%s~n~~w~Health: ~g~~h~Fine(%.0f)~n~~w~MPH: ~b~%d ~b~~h~~h~/ ~w~KPH: ~b~%d",VehicleName[GetVehicleModel(vehicleid)-400],vhp,floatround(value/2200),floatround(value/1400));
				GameTextForPlayer(playerid,string,850,3);
			}
			else if (vhp >= 600 && vhp < 900)
			{
				format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~w~Vehicle: ~b~%s~n~~w~Health: ~y~Good(%.0f)~n~~w~MPH: ~b~%d ~b~~h~~h~/ ~w~KPH: ~b~%d",VehicleName[GetVehicleModel(vehicleid)-400],vhp,floatround(value/2200),floatround(value/1400));
				GameTextForPlayer(playerid,string,850,3);
			}
			else if (vhp >= 301 && vhp < 600)
			{
				format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~w~Vehicle: ~b~%s~n~~w~Health: ~r~~h~~h~Bad(%.0f)~n~~w~MPH: ~b~%d ~b~~h~~h~/ ~w~KPH: ~b~%d",VehicleName[GetVehicleModel(vehicleid)-400],vhp,floatround(value/2200),floatround(value/1400));
				GameTextForPlayer(playerid,string,850,3);
			}
			else if (vhp >= 0 && vhp < 301)
			{
				format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~w~Vehicle: ~b~%s~n~~w~Health: ~r~~h~boom~n~~w~MPH: ~b~%d ~b~~h~~h~/ ~w~KPH: ~b~%d",VehicleName[GetVehicleModel(vehicleid)-400],floatround(value/2200),floatround(value/1400));
				GameTextForPlayer(playerid,string,850,3);
			}
			PlayerPos[playerid][VEHX] = vehx;
 			PlayerPos[playerid][VEHY] = vehy;
 			PlayerPos[playerid][VEHZ] = vehz;
		}
	}
}