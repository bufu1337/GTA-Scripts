/*x---------------------------------Important-------------------------------------x*/
//**INCLUDES**//
#include <a_samp>
//**DEFINES**//
#define HEALTHLOSS      2 // For the vehicle dammage function
#define ON  1
#define OFF 0
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
enum sVEHICLEINFO
{
	Float:sviX,
	Float:sviY,
	Float:sviZ,
	Float:sviA,
	sviPlate,
	sviCol1,
	sviCol2,
	sviRespawn,
	sviPaintjob,
	sviLock,
	sviModel,
}
new sVehInfo[MAX_VEHICLES][sVEHICLEINFO];
//**FORWARDS**//
forward FrzVehHP(veh,Float:hp);
forward FrzVeh(veh,Float:VX,Float:VY,Float:VZ,Float:VA);
forward VehResprayed(veh,Float:VX,Float:VY,Float:VZ,Float:VA);
forward VehDes(veh);
forward VehDmgToPlayer(playerid, vehicleid);
forward AntiVehExp(vehicleid);
forward VehRecov(vehicleid);
forward VehStats(vehicleid);
forward ResVeh(vehicleid);
forward Seif_VehicleToPoint(playerid, Float:radi, Float:px, Float:py, Float:pz);
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
	native sCreateVehicle(modelid, Float:X, Float:Y, Float:Z, Float:Angle, Color1, Color2, Respawn_delay);
	native sGetVehiclePosA(vehicleid, &Float:X, &Float:Y, &Float:Z, &Float:Angle);
	native sSetVehiclePosA(vehicleid, Float:X, Float:Y, Float:Z, Float:Angle);
	native SetVehicleLock(vehicleid, locked, playerid);
	native RespawnVehicle(vehicleid);
	native SetVehicleColors(vehicleid, color1, color2);
	native SetVehiclePaintjob(vehicleid, paintjob);
	native GetVehicleColors(vehicleid, &color1, &color2);
	native GetVehiclePaintjob(vehicleid);
	native SetVehiclePlateNumber(vehicleid, number);
	native GetVehiclePlateNumber(vehicleid);
	native GetVehicleInfo(vehicleid, &Float:X, &Float:Y, &Float:Z, &Float:A, &respawn, &worldid, &color1, &color2, &paintjob, &lock, &plate, &modelid, &modelname[]);
	native RepairVehicle(vehicleid);
	native IsVehicleSpawned(vehicleid);
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
 	if (toggle == ON) fv[vehicleid] = SetTimerEx("FrzVeh",200,1,"iffff",vehicleid,fvX,fvY,fvZ,fvA);
	else KillTimer(fv[vehicleid]);
}

stock ResprayVehicle(vehicleid)
{
    new Float:fvX,Float:fvY,Float:fvZ,Float:fvA;
    GetVehiclePos(vehicleid,fvX,fvY,fvZ);
 	GetVehicleZAngle(vehicleid,fvA);
 	new colors = random(126);
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
	if (toggle == ON) vd[vehicleid] = SetTimerEx("VehDmgToPlayer",200,1,"ii",playerid, vehicleid);
	else if (toggle == OFF) KillTimer(vd[vehicleid]);
}

stock AllowVehicleExplosion(vehicleid,allow)
{
	if (allow == ON) ve[vehicleid] = SetTimerEx("AntiVehExp",300,1,"i",vehicleid);
	else if (allow == OFF) KillTimer(ve[vehicleid]);
}

stock DisplayVehicleStats(vehicleid, display)
{
	if (display == ON) vs[vehicleid] = SetTimerEx("VehStats",500,1,"i",vehicleid);
	else if (display == OFF) KillTimer(vs[vehicleid]);
}

stock KillVehicle(vehicleid)
{
	new Float:VX,Float:VY,Float:VZ;
	GetVehiclePos(vehicleid,VX,VY,VZ);
	SetVehicleHealth(vehicleid, 0);
	CreateExplosion(VX,VY,VZ,1,3);
}

stock sCreateVehicle(modelid, Float:X, Float:Y, Float:Z, Float:Angle, color1, color2, respawn_delay)
{
	new id = CreateVehicle(modelid,X,Y,Z,Angle,color1,color2,respawn_delay);
	sVehInfo[vehicleid][sviX] = X;
	sVehInfo[vehicleid][sviY] = Y;
	sVehInfo[vehicleid][sviZ] = Z;
	sVehInfo[vehicleid][sviA] = Angle;
	sVehInfo[vehicleid][sviCol1] = color1;
	sVehInfo[vehicleid][sviCol2] = color2;
	sVehInfo[vehicleid][sviRespawn] = respawn_delay;
	sVehInfo[vehicleid][sviModel] = modelid;
	sVehInfo[vehicleid][sviID] = id;
	return id;
}

stock sGetVehiclePosA(vehicleid, &Float:X, &Float:Y, &Float:Z, &Float:Angle)
{
	GetVehiclePos(vehicleid,X,Y,Z);
	GetVehicleZAngle(vehicleid,Angle);
}

stock sSetVehiclePosA(vehicleid, Float:X, Float:Y, Float:Z, Float:Angle)
{
	SetVehiclePos(vehicleid,X,Y,Z);
	SetVehicleZAngle(vehicleid,Angle);
}

stock SetVehicleLock(vehicleid, locked, playerid)
{
    if (locked == 1) sVehInfo[vehicleid][sviLock] = ON;
    else sVehInfo[vehicleid][sviLock] = OFF;
    if (playerid != INVALID_PLAYER_ID)
	{
	    for(new i = 0; i < GetMaxPlayers(); i++)
	    {
	        if (i != playerid) SetVehicleParamsForPlayer(vehicleid,i,0,locked);
		}
	}
    else
	{
	    for(new i = 0; i < GetMaxPlayers(); i++)
	    {
	        SetVehicleParamsForPlayer(vehicleid,i,0,locked);
		}
	}
}

stock RespawnVehicle(vehicleid)
{
	new playerscount;
	for(new i = 0; i < GetMaxPlayers(); i++)
	{
	    if (IsPlayerInVehicle(i,vehicleid))
	    {
	        playerscount++;
	        RemovePlayerFromVehicle(playerid);
	        SetVehicleLock(vehicleid,ON,999);
	        rv[vehicleid] = SetTimerEx("ResVeh",3000,0,"d",vehicleid);
	    }
	}
	if (playerscount == 0) SetVehicleToRespawn(vehicleid);
}

stock SetVehicleColors(vehicleid, color1, color2)
{
    sVehInfo[vehicleid][sviCol1] = color1;
	sVehInfo[vehicleid][sviCol2] = color2;
	ChangeVehicleColor(vehicleid,color1,color2);
}

stock GetVehicleColors(vehicleid, &color1, &color2)
{
    &color1 = sVehInfo[vehicleid][sviCol1]
	&color2 = sVehInfo[vehicleid][sviCol2]
}

stock SetVehiclePaintjob(vehicleid, paintjob)
{
    sVehInfo[vehicleid][sviPaintjob] = paintjob;
	ChangeVehiclePaintjob(vehicleid,paintjob);
}

stock GetVehiclePaintjob(vehicleid)
{
    return sVehInfo[vehicleid][sviPaintjob];
}

stock SetVehiclePlateNumber(vehicleid, number)
{
    sVehInfo[vehicleid][sviPlate] = number;
    SetVehicleNumberPlate(vehicleid,number);
}

stock GetVehiclePlateNumber(vehicleid)
{
    return sVehInfo[vehicleid][sviPlate];
}

stock GetVehicleInfo(vehicleid, &Float:X, &Float:Y, &Float:Z, &Float:A, &respawn, &worldid, &color1, &color2, &paintjob, &lock, &plate, &modelid, const modelname[])
{
	GetVehiclePos(vehicleid,X,Y,Z);
	GetVehicleZAngle(vehicleid,A);
	respawn = sVehInfo[vehicleid][sviRespawn];
	worldid = GetVehicleVirtualWorld(vehicleid);
	color1 = sVehInfo[vehicleid][sviCol1];
	color2 = sVehInfo[vehicleid][sviCol2];
	paintjob = sVehInfo[vehicleid][sviPaintjob];
	lock = sVehInfo[vehicleid][sviLock];
	plate = sVehInfo[vehicleid][sviPlate];
	modelid = sVehInfo[vehicleid][sviModel];
	strmid(modelname,GetVehicleName(vehicleid),0,strlen(GetVehicleName(vehicleid)),128);
}

stock RepairVehicle(vehicleid)
{
    new Float:fvX,Float:fvY,Float:fvZ,Float:fvA;
    GetVehiclePos(vehicleid,fvX,fvY,fvZ);
 	GetVehicleZAngle(vehicleid,fvA);
 	new colors = random(126);
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
 			SetTimerEx("VehResprayed",3000,0,"iffff",vehicleid+999,fvX,fvY,fvZ,fvA);
 			break;
		}
		else if (GetPlayerState(playerid) != 2 && !IsPlayerInVehicle(playerid,vehicleid) && count == 0)
		{
		    SetVehicleToRespawn(vehicleid);
			SetTimerEx("VehResprayed",1000,0,"iffff",vehicleid,fvX,fvY,fvZ,fvA);
			break;
		}
	}
}

stock IsVehicleSpawned(vehicleid)
{
	new Float:VX,Float:VY,Float:VZ;
	GetVehiclePos(vehicleid,VX,VY,VZ);
	if (VX == 0 && VY == 0 && VZ == 0) return 0;
	return 1;
}

public FrzVehHP(veh,Float:hp)
{
	SetVehicleHealth(veh,hp);
}

public FrzVeh(veh,Float:VX,Float:VY,Float:VZ,Float:VA)
{
	if (!Seif_VehicleToPoint(veh,1.0,VX,VY,VZ))
	{
		SetVehiclePos(veh,VX,VY,VZ);
		SetVehicleZAngle(veh,VA);
	}
}

public VehResprayed(veh,Float:VX,Float:VY,Float:VZ,Float:VA)
{
	if (veh > 700)
	{
	    veh -= 999;
	    ChangeVehicleColor(veh,sVehInfo[veh][sviCol1],sVehInfo[veh][sviCol2]);
	}
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
	            SetVehicleHealth(vehicleid,401);
	            FreezeVehicle(vehicleid, true);
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

public ResVeh(vehicleid)
{
	SetVehicleLock(vehicleid,OFF,999);
	SetVehicleToRespawn(vehicleid);
}

public Seif_VehicleToPoint(playerid, Float:radi, Float:px, Float:py, Float:pz)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:x, Float:y, Float:z;
		new Float:ox, Float:oy, Float:oz;
		GetVehiclePos(playerid, ox, oy, oz);
		x = (ox -px);
		y = (oy -py);
		z = (oz -pz);
		if (((x < radi) && (x > -radi)) && ((y < radi) && (y > -radi)) && ((z < radi) && (z > -radi))) return 1;
	}
	return 0;
}
