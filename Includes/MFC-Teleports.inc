/*
========================
MFC Teleports Include by
=======[MFC]Sylar=======
========================
*/

#include <a_samp>

#define COLOR_RED 0xAA3333AA

new VehicleNames[212][] = {
"Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus",
"Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Mr Whoopee","BF Injection",
"Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie",
"Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
"Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
"Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina",
"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo","Greenwood",
"Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa","RC Goblin","Hotring Racer A","Hotring Racer B",
"Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain",
"Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover",
"Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A",
"Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer",
"Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer A","Emperor",
"Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)",
"Police Car (LVPD)","Police Ranger","Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
"Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};


/*
native SetOnFootPos(playerid, Float:x, Float:y, Float:z, Float:a, interior);
native SetCarPos(playerid, Float:Vx, Float:Vy, Float:Vz, Float:Va, Float:Px, Float:Py, Float:Pz, Float:Pa, interior);
native SetXCarPos(playerid, Float:Vx, Float:Vy, Float:Vz, Float:Va, Float:Px, Float:Py, Float:Pz, Float:Pa, interior, VehicleModel);
native SetSkinPlayerCarPos(playerid, Float:Vx, Float:Vy, Float:Vz, Float:Va, Float:Px, Float:Py, Float:Pz, Float:Pa, interior, PSkin);
native SetOnFootSkinPos(playerid, Float:x, Float:y, Float:z, Float:a, interior, PSkin);
native SetCarIdPos(playerid, Float:Vx, Float:Vy, Float:Vz, Float:Va, interior, Vid);
native SetHealthPos(playerid, Float:Px, Float:Py, Float:Pz, Float:Pa, interior, toggle:TeleportCar, Float:Health);
native SetArmourPos(playerid, Float:Px, Float:Py, Float:Pz, Float:Pa, interior, toggle:TeleportCar, Float:Armour);
native SetMoneyPos(playerid, Float:Px, Float:Py, Float:Pz, Float:Pa, interior, toggle:TeleportCar, money);
native SetTeamPlayerPos(playerid, Float:Px, Float:Py, Float:Pz, Float:Pa, interior, toggle:TeleportCar, const Team[]);
native SetScorePos(playerid, Float:Px, Float:Py, Float:Pz, Float:Pa, interior, toggle:TeleportCar, playerscore);
*/

stock SetOnFootPos(playerid, Float:x, Float:y, Float:z, Float:a, interior)
{
	TogglePlayerControllable(playerid, 1);
	SetPlayerPos(playerid,x,y,z);
	SetPlayerFacingAngle(playerid,a);
	SetCameraBehindPlayer(playerid);
	SetPlayerInterior(playerid, interior);
	return 1;
}

stock SetCarPos(playerid, Float:Vx, Float:Vy, Float:Vz, Float:Va, Float:Px, Float:Py, Float:Pz, Float:Pa, interior)
{
	TogglePlayerControllable(playerid, 1);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		SetVehiclePos(GetPlayerVehicleID(playerid),Vx,Vy,Vz);
		SetVehicleZAngle(GetPlayerVehicleID(playerid),Va);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid),interior);
	}
	else
	{
		SetPlayerPos(playerid,Px,Py,Pz);
		SetPlayerFacingAngle(playerid,Pa);
	}
	SetCameraBehindPlayer(playerid);
	SetPlayerInterior(playerid, interior);
	return 1;
}
stock SetXCarPos(playerid, Float:Vx, Float:Vy, Float:Vz, Float:Va, Float:Px, Float:Py, Float:Pz, Float:Pa, interior, Vmodel)
{
	TogglePlayerControllable(playerid, 1);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetVehicleModel(GetPlayerVehicleID(playerid)) == Vmodel)
	{
		SetVehiclePos(GetPlayerVehicleID(playerid),Vx,Vy,Vz);
		SetVehicleZAngle(GetPlayerVehicleID(playerid),Va);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid),interior);
	}
	else
	{
		SetPlayerPos(playerid,Px,Py,Pz);
		SetPlayerFacingAngle(playerid,Pa);
	}
	SetCameraBehindPlayer(playerid);
	SetPlayerInterior(playerid, interior);
	return 1;
}
stock SetCarIdPos(playerid, Float:Vx, Float:Vy, Float:Vz, Float:Va, interior, Vid)
{
	new string[256];
	TogglePlayerControllable(playerid, 1);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetVehicleModel(GetPlayerVehicleID(playerid)) == Vid)
	{
		SetVehiclePos(GetPlayerVehicleID(playerid),Vx,Vy,Vz);
		SetVehicleZAngle(GetPlayerVehicleID(playerid),Va);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid),interior);
		SetCameraBehindPlayer(playerid);
		SetPlayerInterior(playerid, interior);
	}
	else
	{
                format(string, sizeof(string), "You need to be in a \"%s\" Vehicle!", VehicleNames[Vid - 400]);
                SendClientMessage(playerid, COLOR_RED, string);
	}
	return 1;
}
stock SetSkinPlayerCarPos(playerid, Float:Vx, Float:Vy, Float:Vz, Float:Va, Float:Px, Float:Py, Float:Pz, Float:Pa, interior, PSkin)
{
	TogglePlayerControllable(playerid, 1);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetPlayerSkin(playerid) == PSkin)
	{
		SetVehiclePos(GetPlayerVehicleID(playerid),Vx,Vy,Vz);
		SetVehicleZAngle(GetPlayerVehicleID(playerid),Va);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid),interior);
	}
	else if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPlayerSkin(playerid) == PSkin)
	{
		SetPlayerPos(playerid,Px,Py,Pz);
		SetPlayerFacingAngle(playerid,Pa);
	}
	else
	{
		SendClientMessage(playerid, COLOR_RED, "You need a Specific Skin to get there!");
	}
	SetCameraBehindPlayer(playerid);
	SetPlayerInterior(playerid, interior);
	return 1;
}

stock SetOnFootSkinPos(playerid, Float:x, Float:y, Float:z, Float:a, interior, PSkin)
{
	TogglePlayerControllable(playerid, 1);
        if(GetPlayerSkin(playerid) == PSkin)
        {
	SetPlayerPos(playerid,x,y,z);
	SetPlayerFacingAngle(playerid,a);
	SetCameraBehindPlayer(playerid);
	SetPlayerInterior(playerid, interior);
        }
        else
        {
        SendClientMessage(playerid, COLOR_RED, "You need a Specific Skin to get there!");
        }
	return 1;
}

stock SetHealthPos(playerid, Float:Px, Float:Py, Float:Pz, Float:Pa, interior, TeleportCar, Float:Health)
{
        TogglePlayerControllable(playerid, 1);
        new Float:PlayerHealth;
        GetPlayerHealth(playerid,PlayerHealth);
        if (PlayerHealth >= Float:Health)
        {
         if(TeleportCar == 1)
          {
          if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
		SetVehiclePos(GetPlayerVehicleID(playerid),Px,Py,Pz);
		SetVehicleZAngle(GetPlayerVehicleID(playerid),Pa);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid),interior);
	    }
          else
	    {
		SetPlayerPos(playerid,Px,Py,Pz);
		SetPlayerFacingAngle(playerid,Pa);
	    }
           }
         else
          {
	   SetPlayerPos(playerid,Px,Py,Pz);
	   SetPlayerFacingAngle(playerid,Pa);
          }
         SetCameraBehindPlayer(playerid);
         SetPlayerInterior(playerid, interior);
        }
        else
         {
           SendClientMessage(playerid, COLOR_RED, "Make sure your health is at 100 percent before teleporting!");
         }
        return 1;
}

stock SetArmourPos(playerid, Float:Px, Float:Py, Float:Pz, Float:Pa, interior, TeleportCar, Float:Armour)
{
        TogglePlayerControllable(playerid, 1);
        new Float:PlayerArmour;
        GetPlayerArmour(playerid,PlayerArmour);
        if (PlayerArmour >= Armour)
        {
         if(TeleportCar == 1)
          {
          if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
		SetVehiclePos(GetPlayerVehicleID(playerid),Px,Py,Pz);
		SetVehicleZAngle(GetPlayerVehicleID(playerid),Pa);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid),interior);
	    }
          else
	    {
		SetPlayerPos(playerid,Px,Py,Pz);
		SetPlayerFacingAngle(playerid,Pa);
	    }
           }
         else
          {
	   SetPlayerPos(playerid,Px,Py,Pz);
	   SetPlayerFacingAngle(playerid,Pa);
          }
         SetCameraBehindPlayer(playerid);
         SetPlayerInterior(playerid, interior);
        }
        else
         {
           SendClientMessage(playerid, COLOR_RED, "Make sure your armor is at 100 percent before teleporting!");
         }
        return 1;
}

stock SetMoneyPos(playerid, Float:Px, Float:Py, Float:Pz, Float:Pa, interior, TeleportCar, money)
{
        new string[256];
        TogglePlayerControllable(playerid, 1);
        if (GetPlayerMoney(playerid) >= money)
        {
         if(TeleportCar == 1)
          {
          if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
		SetVehiclePos(GetPlayerVehicleID(playerid),Px,Py,Pz);
		SetVehicleZAngle(GetPlayerVehicleID(playerid),Pa);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid),interior);
	    }
          else
	    {
		SetPlayerPos(playerid,Px,Py,Pz);
		SetPlayerFacingAngle(playerid,Pa);
	    }
           }
         else
          {
	   SetPlayerPos(playerid,Px,Py,Pz);
	   SetPlayerFacingAngle(playerid,Pa);
          }
         GivePlayerMoney(playerid, -money);
         SetCameraBehindPlayer(playerid);
         SetPlayerInterior(playerid, interior);
        }
        else
         {
           format(string, sizeof(string), "You need to pay %d for this teleport!", money);
           SendClientMessage(playerid, COLOR_RED, string);
         }
        return 1;
}

stock SetTeamPlayerPos(playerid, Float:Px, Float:Py, Float:Pz, Float:Pa, interior, TeleportCar, const Team[])
{
        new string[256];
        TogglePlayerControllable(playerid, 1);
        if (GetPlayerTeam(playerid) == Team)
        {
         if(TeleportCar == 1)
          {
          if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
		SetVehiclePos(GetPlayerVehicleID(playerid),Px,Py,Pz);
		SetVehicleZAngle(GetPlayerVehicleID(playerid),Pa);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid),interior);
	    }
          else
	    {
		SetPlayerPos(playerid,Px,Py,Pz);
		SetPlayerFacingAngle(playerid,Pa);
	    }
           }
         else
          {
	   SetPlayerPos(playerid,Px,Py,Pz);
	   SetPlayerFacingAngle(playerid,Pa);
          }
         SetCameraBehindPlayer(playerid);
         SetPlayerInterior(playerid, interior);
        }
        else
         {
           format(string, sizeof(string), "You need to be in the \"%s\" Team to use this Teleport!", Team);
           SendClientMessage(playerid, COLOR_RED, string);
         }
        return 1;
}

stock SetScorePos(playerid, Float:Px, Float:Py, Float:Pz, Float:Pa, interior, TeleportCar, playerscore)
{
        new string[256];
        TogglePlayerControllable(playerid, 1);
        if (GetPlayerScore(playerid) >= playerscore)
        {
         if(TeleportCar == 1)
          {
          if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
		SetVehiclePos(GetPlayerVehicleID(playerid),Px,Py,Pz);
		SetVehicleZAngle(GetPlayerVehicleID(playerid),Pa);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid),interior);
	    }
          else
	    {
		SetPlayerPos(playerid,Px,Py,Pz);
		SetPlayerFacingAngle(playerid,Pa);
	    }
           }
         else
          {
	   SetPlayerPos(playerid,Px,Py,Pz);
	   SetPlayerFacingAngle(playerid,Pa);
          }
         SetCameraBehindPlayer(playerid);
         SetPlayerInterior(playerid, interior);
        }
        else
         {
           format(string, sizeof(string), "Not enough score. You need to have %d in your playerscore. Press TAB to know about your score!", playerscore);
           SendClientMessage(playerid, COLOR_RED, string);
         }
        return 1;
}