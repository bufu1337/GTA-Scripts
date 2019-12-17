/*
	gLibrary 1.1
	©2011 Gamer931215
	native GetWeaponIdByName(weaponname[])
	native GetVehicleIdByName(weaponname[])
	native SetVehicleNumberPlateEx(vehicleid,numberplate[])
	native MutePlayer(playerid)
	native UnMutePlayer(playerid)
	native JailPlayer(playerid)
	native UnJailPlayer(playerid
	native SetPlayerToReconnect(playerid)
	native SetPlayerMoney(playerid,ammount)
	native GivePlayerScore(playerid,ammount)
	native GetPlayerNameEx(playerid)
	native GetPlayerIpEx(playerid)
	native KickEx(playerid,reason[])
	native SendRconCommandEx(type[],{float,_}:...)
	native SendClientMessageEx(playerid,color,type[],{float,_}:...)
	native SendClientMessageToAllEx(color,type[],{float,_}:...)
	native GameTextForPlayerEx(playerid,time,style,type[],{Float,_}:...)
	native GameTextForAllEx(time,style,type[],{Float,_}:...)
*/

#include <a_samp>
#define gCOLOR_RED 0xFF1400FF
#define gCOLOR_GREEN 0x00FF00FF
#define gCOLOR_BLUE 0x00AFFFFF
#define gCOLOR_YELLOW 0xFFFF00FF
#define gCOLOR_GRAY 0x8C8C8CFF
#define gCOLOR_BLACK 0x000000FF
#define gCOLOR_MAGENTA 0xFF00EBFF
#define gCOLOR_DARKRED 0xC30000FF
#define gCOLOR_DARKGREEN 0x0A6F0AFF
#define gCOLOR_DARKBLUE 0x0000C5FF
public OnPlayerDisconnect(playerid,reason)
{
	if(GetPVarInt(playerid,"reconnecting") == 1)
	{
		SendRconCommandEx("ss","unbanip ",GetPlayerIpEx(playerid));
		DeletePVar(playerid,"reconnecting");
		DeletePVar(playerid,"muted");
	}
	SetPVarInt(playerid,"muted",0);
	return 1;
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect gOnPlayerDisconnect
forward gOnPlayerDisconnect(playerid,reason);

public OnPlayerText(playerid, text[])
{
	if(GetPVarInt(playerid,"muted") == 1)
	{
	    SendClientMessage(playerid,0xFF0A00FF,"You cannot speak when muted.");
	    return 0;
	}
	return 1;
}
#if defined _ALS_OnPlayerText
	#undef OnPlayerText
#else
	#define _ALS_OnPlayerText
#endif
#define OnPlayerText gOnPlayerText
forward OnPlayerText(playerid,text[]);

new gWeaponNames[][32] = { //from fsdebug
	{"Unarmed (Fist)"},
	{"Brass Knuckles"},
	{"Golf Club"},
	{"Night Stick"},
	{"Knife"},
	{"Baseball Bat"},
	{"Shovel"},
	{"Pool Cue"},
	{"Katana"},
	{"Chainsaw"},
	{"Purple Dildo"},
	{"Big White Vibrator"},
	{"Medium White Vibrator"},
	{"Small White Vibrator"},
	{"Flowers"},
	{"Cane"},
	{"Grenade"},
	{"Teargas"},
	{"Molotov"},
	{" "},
	{" "},
	{" "},
	{"Colt 45"},
	{"Colt 45 (Silenced)"},
	{"Desert Eagle"},
	{"Normal Shotgun"},
	{"Sawnoff Shotgun"},
	{"Combat Shotgun"},
	{"Micro Uzi (Mac 10)"},
	{"MP5"},
	{"AK47"},
	{"M4"},
	{"Tec9"},
	{"Country Rifle"},
	{"Sniper Rifle"},
	{"Rocket Launcher"},
	{"Heat-Seeking Rocket Launcher"},
	{"Flamethrower"},
	{"Minigun"},
	{"Satchel Charge"},
	{"Detonator"},
	{"Spray Can"},
	{"Fire Extinguisher"},
	{"Camera"},
	{"Night Vision Goggles"},
	{"Infrared Vision Goggles"},
	{"Parachute"},
	{"Fake Pistol"}
};


new gVehicleNames[212][] = {// from fsdebug, Vehicle Names - Betamaster
	{"Landstalker"},
	{"Bravura"},
	{"Buffalo"},
	{"Linerunner"},
	{"Perrenial"},
	{"Sentinel"},
	{"Dumper"},
	{"Firetruck"},
	{"Trashmaster"},
	{"Stretch"},
	{"Manana"},
	{"Infernus"},
	{"Voodoo"},
	{"Pony"},
	{"Mule"},
	{"Cheetah"},
	{"Ambulance"},
	{"Leviathan"},
	{"Moonbeam"},
	{"Esperanto"},
	{"Taxi"},
	{"Washington"},
	{"Bobcat"},
	{"Mr Whoopee"},
	{"BF Injection"},
	{"Hunter"},
	{"Premier"},
	{"Enforcer"},
	{"Securicar"},
	{"Banshee"},
	{"Predator"},
	{"Bus"},
	{"Rhino"},
	{"Barracks"},
	{"Hotknife"},
	{"Trailer 1"}, //artict1
	{"Previon"},
	{"Coach"},
	{"Cabbie"},
	{"Stallion"},
	{"Rumpo"},
	{"RC Bandit"},
	{"Romero"},
	{"Packer"},
	{"Monster"},
	{"Admiral"},
	{"Squalo"},
	{"Seasparrow"},
	{"Pizzaboy"},
	{"Tram"},
	{"Trailer 2"}, //artict2
	{"Turismo"},
	{"Speeder"},
	{"Reefer"},
	{"Tropic"},
	{"Flatbed"},
	{"Yankee"},
	{"Caddy"},
	{"Solair"},
	{"Berkley's RC Van"},
	{"Skimmer"},
	{"PCJ-600"},
	{"Faggio"},
	{"Freeway"},
	{"RC Baron"},
	{"RC Raider"},
	{"Glendale"},
	{"Oceanic"},
	{"Sanchez"},
	{"Sparrow"},
	{"Patriot"},
	{"Quad"},
	{"Coastguard"},
	{"Dinghy"},
	{"Hermes"},
	{"Sabre"},
	{"Rustler"},
	{"ZR-350"},
	{"Walton"},
	{"Regina"},
	{"Comet"},
	{"BMX"},
	{"Burrito"},
	{"Camper"},
	{"Marquis"},
	{"Baggage"},
	{"Dozer"},
	{"Maverick"},
	{"News Chopper"},
	{"Rancher"},
	{"FBI Rancher"},
	{"Virgo"},
	{"Greenwood"},
	{"Jetmax"},
	{"Hotring"},
	{"Sandking"},
	{"Blista Compact"},
	{"Police Maverick"},
	{"Boxville"},
	{"Benson"},
	{"Mesa"},
	{"RC Goblin"},
	{"Hotring Racer A"}, //hotrina
	{"Hotring Racer B"}, //hotrinb
	{"Bloodring Banger"},
	{"Rancher"},
	{"Super GT"},
	{"Elegant"},
	{"Journey"},
	{"Bike"},
	{"Mountain Bike"},
	{"Beagle"},
	{"Cropdust"},
	{"Stunt"},
	{"Tanker"}, //petro
	{"Roadtrain"},
	{"Nebula"},
	{"Majestic"},
	{"Buccaneer"},
	{"Shamal"},
	{"Hydra"},
	{"FCR-900"},
	{"NRG-500"},
	{"HPV1000"},
	{"Cement Truck"},
	{"Tow Truck"},
	{"Fortune"},
	{"Cadrona"},
	{"FBI Truck"},
	{"Willard"},
	{"Forklift"},
	{"Tractor"},
	{"Combine"},
	{"Feltzer"},
	{"Remington"},
	{"Slamvan"},
	{"Blade"},
	{"Freight"},
	{"Streak"},
	{"Vortex"},
	{"Vincent"},
	{"Bullet"},
	{"Clover"},
	{"Sadler"},
	{"Firetruck LA"}, //firela
	{"Hustler"},
	{"Intruder"},
	{"Primo"},
	{"Cargobob"},
	{"Tampa"},
	{"Sunrise"},
	{"Merit"},
	{"Utility"},
	{"Nevada"},
	{"Yosemite"},
	{"Windsor"},
	{"Monster A"}, //monstera
	{"Monster B"}, //monsterb
	{"Uranus"},
	{"Jester"},
	{"Sultan"},
	{"Stratum"},
	{"Elegy"},
	{"Raindance"},
	{"RC Tiger"},
	{"Flash"},
	{"Tahoma"},
	{"Savanna"},
	{"Bandito"},
	{"Freight Flat"}, //freiflat
	{"Streak Carriage"}, //streakc
	{"Kart"},
	{"Mower"},
	{"Duneride"},
	{"Sweeper"},
	{"Broadway"},
	{"Tornado"},
	{"AT-400"},
	{"DFT-30"},
	{"Huntley"},
	{"Stafford"},
	{"BF-400"},
	{"Newsvan"},
	{"Tug"},
	{"Trailer 3"}, //petrotr
	{"Emperor"},
	{"Wayfarer"},
	{"Euros"},
	{"Hotdog"},
	{"Club"},
	{"Freight Carriage"}, //freibox
	{"Trailer 3"}, //artict3
	{"Andromada"},
	{"Dodo"},
	{"RC Cam"},
	{"Launch"},
	{"Police Car (LSPD)"},
	{"Police Car (SFPD)"},
	{"Police Car (LVPD)"},
	{"Police Ranger"},
	{"Picador"},
	{"S.W.A.T. Van"},
	{"Alpha"},
	{"Phoenix"},
	{"Glendale"},
	{"Sadler"},
	{"Luggage Trailer A"}, //bagboxa
	{"Luggage Trailer B"}, //bagboxb
	{"Stair Trailer"}, //tugstair
	{"Boxville"},
	{"Farm Plow"}, //farmtr1
	{"Utility Trailer"} //utiltr1
};

stock GetVehicleIdByName(vehiclename[])
{
    for(new i = 0;i<sizeof(gVehicleNames);i++)
    {
        if(!strcmp(gVehicleNames[i],vehiclename,true))
        {
            return i +400;
        }
    }
    return -1;
}

stock SetVehicleNumberPlateEx(vehicleid,numberplate[])
{
	new Float:pos[6];GetVehiclePos(vehicleid,pos[0],pos[1],pos[2]);
	SetVehicleNumberPlate(vehicleid,numberplate);SetVehicleToRespawn(vehicleid);
	GetVehiclePos(vehicleid,pos[3],pos[4],pos[5]);
	if(pos[3] != pos[0] || pos[4] != pos[1])
	{
	    SetVehiclePos(vehicleid,pos[0],pos[1],pos[2]);
	}
}

stock GetWeaponIdByName(weaponname[])
{
    for(new i = 0;i<sizeof(gWeaponNames);i++)
    {
        if(!strcmp(gWeaponNames[i],weaponname,true))
        {
            return i;
        }
    }
    return -1;
}

stock MutePlayer(playerid)
{
	SetPVarInt(playerid,"muted",1);
}

stock UnMutePlayer(playerid)
{
    SetPVarInt(playerid,"muted",0);
}

stock JailPlayer(playerid)
{
	SetPlayerInterior(playerid,6);SetPlayerPos(playerid, 265.6881,76.6573,1001.0391);TogglePlayerControllable(playerid,0);
	SetPlayerCameraPos(playerid,269.5,77.5,1002);SetPlayerCameraLookAt(playerid,264.6288,77.5742,1001.0391);
}

stock UnJailPlayer(playerid)
{
    SetPlayerPos(playerid, 267.6288,77.5742,1001.0391);TogglePlayerControllable(playerid,1);SetCameraBehindPlayer(playerid);
}

stock SetPlayerToReconnect(playerid)
{
	SetPVarInt(playerid,"reconnecting",1);SendRconCommandEx("ss","banip ",GetPlayerIpEx(playerid));
}

stock SetPlayerMoney(playerid,ammount)
{
	ResetPlayerMoney(playerid);GivePlayerMoney(playerid,ammount);
}

stock GivePlayerScore(playerid,ammount)
{
	new score = GetPlayerScore(playerid);score=score+ammount;return SetPlayerScore(playerid,score);
}

stock GetPlayerNameEx(playerid)
{
	new pName[MAX_PLAYER_NAME];GetPlayerName(playerid,pName,sizeof pName);return pName;
}

stock GetPlayerIpEx(playerid)
{
	new ip[32];GetPlayerIp(playerid,ip,sizeof ip);return ip;
}

stock KickEx(playerid,reason[])
{
    SendClientMessageEx(playerid,0xA8C3E0FF,"ss","You have been kicked from this server, reason: ",reason);Kick(playerid);
}

stock SendRconCommandEx(type[],{Float,_}:...)
{
	new string[128];
	for(new i = 0;i<numargs();i++)
	{
	    switch(type[i])
	    {
	        case 's':
	        {
				new result[128];
				for(new a= 0;getarg(i +1,a) != 0;a++)
				{
				    result[a] = getarg(i +1,a);
				}
				if(!strlen(string))
				{
				    format(string,sizeof string,"%s",result);
				} else format(string,sizeof string,"%s%s",string,result);
	        }

	        case 'i':
	        {
	            new result = getarg(i +1);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%i",result);
				} else format(string,sizeof string,"%s%i",string,result);
	        }

	        case 'f':
	        {
				new Float:result = Float:getarg(i +1);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%f",result);
				} else format(string,sizeof string,"%s%f",string,result);
	        }
	    }
	}
    SendRconCommand(string);
    return 1;
}

stock SendClientMessageEx(playerid,color,type[],{Float,_}:...)
{
	new string[128];
	for(new i = 0;i<numargs() -2;i++)
	{
	    switch(type[i])
	    {
	        case 's':
	        {
				new result[128];
				for(new a= 0;getarg(i +3,a) != 0;a++)
				{
				    result[a] = getarg(i +3,a);
				}
				if(!strlen(string))
				{
				    format(string,sizeof string,"%s",result);
				} else format(string,sizeof string,"%s%s",string,result);
	        }

	        case 'i':
	        {
	            new result = getarg(i +3);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%i",result);
				} else format(string,sizeof string,"%s%i",string,result);
	        }

	        case 'f':
	        {
				new Float:result = Float:getarg(i +3);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%f",result);
				} else format(string,sizeof string,"%s%f",string,result);
	        }
	    }
	}
    SendClientMessage(playerid,color,string);
    return 1;
}

stock SendClientMessageToAllEx(color,type[],{Float,_}:...)
{
	new string[128];
	for(new i = 0;i<numargs() -1;i++)
	{
	    switch(type[i])
	    {
	        case 's':
	        {
				new result[128];
				for(new a= 0;getarg(i +2,a) != 0;a++)
				{
				    result[a] = getarg(i +2,a);
				}
				if(!strlen(string))
				{
				    format(string,sizeof string,"%s",result);
				} else format(string,sizeof string,"%s%s",string,result);
	        }

	        case 'i':
	        {
	            new result = getarg(i +2);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%i",result);
				} else format(string,sizeof string,"%s%i",string,result);
	        }

	        case 'f':
	        {
				new Float:result = Float:getarg(i +2);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%f",result);
				} else format(string,sizeof string,"%s%f",string,result);
	        }
	    }
	}
    SendClientMessageToAll(color,string);
    return 1;
}

stock GameTextForPlayerEx(playerid,time,style,type[],{Float,_}:...)
{
	new string[128];
	for(new i = 0;i<numargs() -3;i++)
	{
	    switch(type[i])
	    {
	        case 's':
	        {
				new result[128];
				for(new a= 0;getarg(i +4,a) != 0;a++)
				{
				    result[a] = getarg(i +4,a);
				}
				if(!strlen(string))
				{
				    format(string,sizeof string,"%s",result);
				} else format(string,sizeof string,"%s%s",string,result);
	        }

	        case 'i':
	        {
	            new result = getarg(i +4);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%i",result);
				} else format(string,sizeof string,"%s%i",string,result);
	        }

	        case 'f':
	        {
				new Float:result = Float:getarg(i +4);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%f",result);
				} else format(string,sizeof string,"%s%f",string,result);
	        }
	    }
	}
    GameTextForPlayer(playerid,string,time,style);
    return 1;
}

stock GameTextForAllEx(time,style,type[],{Float,_}:...)
{
	new string[128];
	for(new i = 0;i<numargs() -2;i++)
	{
	    switch(type[i])
	    {
	        case 's':
	        {
				new result[128];
				for(new a= 0;getarg(i +3,a) != 0;a++)
				{
				    result[a] = getarg(i +3,a);
				}
				if(!strlen(string))
				{
				    format(string,sizeof string,"%s",result);
				} else format(string,sizeof string,"%s%s",string,result);
	        }

	        case 'i':
	        {
	            new result = getarg(i +3);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%i",result);
				} else format(string,sizeof string,"%s%i",string,result);
	        }

	        case 'f':
	        {
				new Float:result = Float:getarg(i +3);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%f",result);
				} else format(string,sizeof string,"%s%f",string,result);
	        }
	    }
	}
    GameTextForAll(string,time,style);
    return 1;
}