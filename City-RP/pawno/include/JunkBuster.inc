/*
+-----------------------------------------------------------------------+
¦                        JunkBuster Anti-Cheat                          ¦
¦                                  by                                   ¦
¦                           Double-O-Seven                              ¦
¦                                                                       ¦
¦ This Anti-Cheat script is made by me, Double-O-Seven. The famous      ¦
¦ Anti-Cheat system "PunkBuster" inspired me the script a new           ¦
¦ Anti-Cheat script for SA:MP. It contains many functions against       ¦
¦ normal cheats and cheats from specific cheat tools. It's against      ¦
¦ (command) spam, too. It doesn't contain codes which result many       ¦
¦ codes which would cause kicks/bans of innocent players.               ¦
¦ There is no real check for godmode and no server-based health/armour  ¦
¦ because it's just stupid. Because there are so much possibilities to  ¦
¦ get health without SetPlayerHealth. This would cause very much wrong  ¦
¦ kicks/bans. The only code which could ban innocents is the teleport   ¦
¦ code and the carjack code. It could kick extreme laggy players.       ¦
¦ If JunkBuster kicks/bans too much innocent players, disable the codes ¦
¦ which kick/ban too much innocent players. You can easily configurate  ¦
¦ JunkBuster in the file "JunkBuster.cfg" in the folder "JunkBuster"    ¦
¦ in the folder "scriptfiles". Use "/cfg" ingame if you are (rcon)admin ¦
¦ to update the configuration. Define in "BadWords.cfg" the forbidden   ¦
¦ words, define in "ForbiddenWeapons.cfg" to forbidden weapons.         ¦
¦                                                                       ¦
¦ I call this script a 'Plug & Play'-script! Why? In this version       ¦
¦ You only need to include the script and compile your gamemode.        ¦
¦ Everything important is done by the script itself. You DON'T need to  ¦
¦ change anything! (Except for some functions when they are already     ¦
¦ defined.                                                              ¦
¦                                                                       ¦
¦ This script has been made by Double-O-Seven! You are NOT allowed to:  ¦
¦ - Remove this text                                                    ¦
¦ - Rename JunkBuster                                                   ¦
¦ - Re-release this script                                              ¦
¦ - Say it's your own script                                            ¦
¦                                                                       ¦
¦ But you are allowed to add more functions and use it on your server.  ¦
+-----------------------------------------------------------------------+
*/

#if defined _JB_included
	#endinput
#endif
#define _JB_included

//==============================================================================

#include <a_samp>
#include <a_zones>
#include <Dini>

//==============================================================================

//#define WARN_PLAYERS // Comment this if players shouldn't get warned when they connect.

#define CONFIG_FILE "JunkBuster/JunkBuster.cfg"
#define BAD_WORDS_FILE "JunkBuster/BadWords.cfg"
#define FORBIDDEN_WEAPONS_FILE "JunkBuster/ForbiddenWeapons.cfg"
#define JB_LOG_FILE "JunkBuster/JunkBuster.log"
#define BLACKLIST_FILE "JunkBuster/Blacklist.txt"
#define WHITELIST_FILE "JunkBuster/Whitelist.txt"
#define IP_BAN_FILE "JunkBuster/IpBans.txt"
#define TEMP_BAN_FILE "JunkBuster/TempBans.txt"

#define MAX_VARIABLES 24
#define MAX_BAD_WORDS 100
#define MAX_FORBIDDEN_WEAPONS 20
#define MAX_PING_CHECKS 3
#define MAX_WEAPONS 47
#define MAX_CHECKS 3

#define WEAPON_HACK 0
#define MONEY_HACK 1
#define JETPACK 2
#define HEALTH_HACK 3
#define ARMOUR_HACK 4
#define DRIVE_BY 5
#define SPAM 6
#define COMMAND_SPAM 7
#define BAD_WORDS 8
#define CAR_JACK_HACK 9
#define TELEPORT_HACK 10
#define MAX_PING 11
#define SPECTATE_HACK 12
#define BLACKLIST 13
#define IP_BANS 14
#define TEMP_BANS 15
#define SPAWNKILL 16
#define CAPS_LOCK 17
#define SPEED_3D 18
#define MAX_SPEED 19
#define ADMIN_IMMUNITY 20
#define ADVERTISEMENT 21
#define FREEZE_UPDATE 22
#define SPAWN_TIME 23

#define RED 0xFF0000FF
#define GREEN 0x00FF00FF
#define GREEN_BLUE 0x00D799FF

new FALSE=false;

#define SendFormattedMessage(%0,%1,%2,%3) do{new _string[128]; format(_string,sizeof(_string),%2,%3); SendClientMessage(%0,%1,_string);} while(FALSE)
#define SendFormattedMessageToAll(%0,%1,%2) do{new _string[128]; format(_string,sizeof(_string),%1,%2); SendClientMessageToAll(%0,_string);} while(FALSE)
#define JB_LogEx(%0,%1) do{new _string[256]; format(_string,sizeof(_string),%0,%1); JB_Log(_string);} while(FALSE)
#define GetSquareDistance(%0,%1,%2,%3,%4,%5) floatround((%0-%3)*(%0-%3)+(%1-%4)*(%1-%4)+(%2-%5)*(%2-%5))
#define GetVehicleName(%0) VehicleName[GetVehicleModel(%0)-400]

//==============================================================================

new JB_Warnings[MAX_PLAYERS][MAX_VARIABLES];
new JB_Variables[MAX_VARIABLES]=
{
	true,//WeaponHack
	true,//MoneyHack
	true,//Jetpack
	true,//HealthHack
	true,//ArmourHack
	true,//DriveBy
	true,//Spam
	true,//CommandSpam
	true,//BadWords
	true,//CarJackHack
	true,//TeleportHack
	500,//MaxPing
	true,//SpectateHack
	true,//Blacklist
	true,//IpBans
	true,//TempBans
	3,//SpawnKill
	true,//CapsLock
	false,//3DSpeed
	260,//MaxSpeed
	true,//AdminImmunity
	false,//Advertisement
	false,//FreezeUpdate
	10//SpawnTime
};

new JB_VariableNames[MAX_VARIABLES][32]=
{
	"WeaponHack",
	"MoneyHack",
	"Jetpack",
	"HealthHack",
	"ArmourHack",
	"DriveBy",
	"Spam",
	"CommandSpam",
	"BadWords",
	"CarJackHack",
	"TeleportHack",
	"MaxPing",
	"SpectateHack",
	"Blacklist",
	"IpBans",// also contains IP-bans
	"TempBans",
	"SpawnKill",//Set this to the max spawnkills you want to allow
	"CapsLock",
	"3DSpeed",
	"MaxSpeed",
	"AdminImmunity",
	"Advertisement",
	"FreezeUpdate",
	"SpawnTime"
};

new WeaponForbiddenForPlayer[MAX_PLAYERS][MAX_WEAPONS];
new JB_Money[MAX_PLAYERS];
new Messages[MAX_PLAYERS];
new Commands[MAX_PLAYERS];
new Muted[MAX_PLAYERS];
new Freezed[MAX_PLAYERS];
new Ping[MAX_PLAYERS][MAX_PING_CHECKS];
new PingCheckProgress[MAX_PLAYERS];
new VehicleEntered[MAX_PLAYERS];
new SpawnKillProtected[MAX_PLAYERS];

new SpeedHacking[MAX_PLAYERS];
new Float:LastPos[MAX_PLAYERS][3];
new Speed[MAX_PLAYERS][MAX_CHECKS];
new SpeedTime[MAX_PLAYERS];
new Checks[MAX_PLAYERS];

new KickBan[MAX_PLAYERS];// Do not use this.

new Float:CurrentPos[MAX_PLAYERS][3];
new NoTeleportCheck[MAX_PLAYERS];

new BadWords[MAX_BAD_WORDS][32];
new BadWordsCount;
new ForbiddenWeapons[MAX_FORBIDDEN_WEAPONS];
new ForbiddenWeaponsCount;

new Blacklist[100][MAX_PLAYER_NAME];
new Whitelist[100][MAX_PLAYER_NAME];
new IpBans[50][4];
new IpBanned[50];
enum tbInfo
{
	tbName[MAX_PLAYER_NAME],
	tbIp[16],
	tbTime
}
new TempBanInfo[250][tbInfo];

new Planes[]=
{
    413,417,425,447,460,469,476,487,488,497,511,512,513,519,520,548,553,563,577,592,593
};

new VehicleName[][] =
{
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

/*
These coordinates are taken from m0d_n0beit.
Yes, I'm always testing the newest versions. You can't create a useful
anti-cheat which detects many cheats, if you don't check out the cheat tools.
Fuck those suckers. If someone teleports there, he MUST be a cheater
and JunkBuster will ban him.
*/
new Float:CheatPositions[][3]=
{
	{403.58, 2486.33, 17.23},// Airport Garage in Verdant Meadows
	{1578.24, 1245.20, 11.57},// Airport Plane Garage in Las Venturas
	{1641.14, -1526.87, 14.30},// Commerce Region, Loading Bay Garage
	{1836.93, -1856.28, 14.13},// Eight Ball Autos near El Corona
	{2645.61, -2029.15, 14.28},// LowRider Tuning Garage in Willowfield
	{-1787.25, 1202.00, 25.84},// Michelles Pay 'n' Spray in Downtown
	{1041.26, -1036.77, 32.48},// Transfender in Temple
	{2387.55, 1035.70, 11.56},// Transfender in come-a-lot
	{-1935.77, 228.79, 34.16},// Transfender near Wang Cars in Doherty
	{2006.11, 2292.87, 11.57},// Welding Wedding Bomb-workshop in Emerald Isle
	{-2707.48, 218.65, 4.93},// Wheel Archangels in Ocean Flats
	{720.10, -470.93, 17.07},// Pay 'n' Spray in Dillimore
	{-1420.21, 2599.45, 56.43},// Pay 'n' Spray in El Quebrados
	{-100.16, 1100.79, 20.34},// Pay 'n' Spray in Fort Carson
	{2078.44, -1831.44, 14.13},// Pay 'n' Spray in Idlewood
	{-2426.89, 1036.61, 51.14},// Pay 'n' Spray in Juniper Hollow
	{1957.96, 2161.96, 11.56},// Pay 'n' Spray in Redsands East
	{488.29, -1724.85, 12.01},// Pay 'n' Spray in Santa Maria Beach
	{1025.08, -1037.28, 32.28},// Pay 'n' Spray in Temple
	{2393.70, 1472.80, 11.42},// Pay 'n' Spray near Royal Casino
	{-1904.97, 268.51, 41.04},// Pay 'n' Spray near Wang Cars in Doherty
	{-1617.58, 688.69, -4.50},// Police Garage in DownTown
	{-2105.79, 905.11, 77.07},// Player Garage: Calton Heights
	{423.69, 2545.99, 17.07},// Player Garage: Derdant Meadows
	{785.79, -513.12, 17.44},// Player Garage: Dillimore
	{-2027.34, 141.02, 29.57},// Player Garage: Doherty
	{1698.10, -2095.88, 14.29},// Player Garage: El Corona
	{-361.10, 1185.23, 20.49},// Player Garage: Fort Carson
	{-2463.27, -124.86, 26.41},// Player Garage: Hashbury
	{2505.64, -1683.72, 14.25},// Player Garage: Johnson House
	{1350.76, -615.56, 109.88},// Player Garage: Mulholland
	{2231.64, 156.93, 27.63},// Player Garage: Palomino Creek
	{-2695.51, 810.70, 50.57},// Player Garage: Paradiso
	{1293.61, 2529.54, 11.42},// Player Garage: Prickle Pine
	{1401.34, 1903.08, 11.99},// Player Garage: Redland West
	{2436.50, 698.43, 11.60},// Player Garage: Rockshore West
	{322.65, -1780.30, 5.55},// Player Garage: Santa Maria Beach
	{917.46, 2012.14, 11.65}// Player Garage: Whitewood Estates
};

//==============================================================================

forward JunkBuster();
forward ConfigJunkBuster();
forward LoadBadWords();
forward LoadForbiddenWeapons();
forward JB_Kick(playerid,reason[]);
forward JB_Ban(playerid,reason[]);
forward JB_GivePlayerMoney(playerid,amount);
forward JB_GetPlayerMoney(playerid);
forward JB_ResetPlayerMoney(playerid);
forward JB_PutPlayerInVehicle(playerid,vehicleid,seatid);
forward JB_GivePlayerWeapon(playerid,weaponid,ammo);
forward JB_SetPlayerPos(playerid,Float:x,Float:y,Float:z);
forward JB_SetVehiclePos(vehicleid,Float:x,Float:y,Float:z);
forward JB_SetPlayerHealth(playerid,Float:health);
forward JB_SetPlayerArmour(playerid,Float:armour);
forward JB_TogglePlayerControllable(playerid,toggle);
forward MutePlayer(playerid,time,reason[]);
forward LoadBlacklist();
forward UpdateBlacklist();
forward AddNameToBlacklist(name[]);
forward RemoveNameFromBlacklist(name[]);
forward AddPlayerToBlacklist(playerid);
forward LoadWhitelist();
forward UpdateWhitelist();
forward AddNameToWhitelist(name[]);
forward RemoveNameFromWhitelist(name[]);
forward AddPlayerToWhitelist(playerid);
forward TempBan(playerid,hours,reason[]);
forward DeleteTempBan(name[]);
forward LoadTempBans();
forward SaveTempBans();
forward TempBanUpdate();
forward LoadIpBans();
forward SaveIpBans();
forward BanIp(ip_string[]);
forward UnbanIp(ip_string[]);
forward SetPlayerSpawnKillProtected(playerid,set);
forward SpeedCheck();
forward GlobalUpdate();
forward SpamUpdate();

//Plug & Play:
forward PnP_OnPlayerStateChange(playerid, newstate, oldstate);
forward PnP_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
forward PnP_OnPlayerCommandText(playerid, cmdtext[]);
forward PnP_OnPlayerPrivmsg(playerid, recieverid, text[]);
forward PnP_OnPlayerText(playerid, text[]);
forward PnP_OnPlayerConnect(playerid);
forward PnP_OnPlayerDisconnect(playerid,reason);
forward PnP_OnGameModeInit();
forward PnP_OnGameModeExit();
forward PnP_OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid);
forward PnP_OnPlayerDeath(playerid,killerid,reason);
forward PnP_OnPlayerSpawn(playerid);

//==============================================================================

public JB_PutPlayerInVehicle(playerid,vehicleid,seatid)
{
	if(IsPlayerConnected(playerid) && vehicleid)
	{
	    if(PutPlayerInVehicle(playerid,vehicleid,seatid))
	    {
	        NoTeleportCheck[playerid]=3;
	    	VehicleEntered[playerid]=vehicleid;
  			return 1;
		}
	}
	return 0;
}

public JB_GivePlayerMoney(playerid,amount)
{
	if(IsPlayerConnected(playerid))
	{
	    GivePlayerMoney(playerid,amount);
	    JB_Money[playerid]+=amount;
	    return 1;
	}
	return 0;
}

public JB_ResetPlayerMoney(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    ResetPlayerMoney(playerid);
	    JB_Money[playerid]=0;
	    return 1;
	}
	return 0;
}

public JB_GetPlayerMoney(playerid)
{
	new amount;
	if(IsPlayerConnected(playerid))
	{
	    if(!JB_Variables[MONEY_HACK] || GetPlayerMoney(playerid)<JB_Money[playerid])
	        amount=GetPlayerMoney(playerid);
		else
		    amount=JB_Money[playerid];
	}
	return amount;
}

public JB_SetPlayerPos(playerid,Float:x,Float:y,Float:z)
{
	if(IsPlayerConnected(playerid))
	{
	    if(SetPlayerPos(playerid,x,y,z))
	    {
	        CurrentPos[playerid][0]=x;
	        CurrentPos[playerid][1]=y;
	        CurrentPos[playerid][2]=z;
	        NoTeleportCheck[playerid]=3;//Do not check position for 3 seconds to prevent lag kick.
	        return 1;
	    }
	}
	return 0;
}

public JB_SetVehiclePos(vehicleid,Float:x,Float:y,Float:z)
{
	if(vehicleid)
	{
	    if(SetVehiclePos(vehicleid,x,y,z))
	    {
			for(new i=0;i<MAX_PLAYERS;i++)
			{
			    if(IsPlayerConnected(i) && GetPlayerVehicleID(i)==vehicleid)
			    {
			        CurrentPos[i][0]=x;
			        CurrentPos[i][1]=y;
			        CurrentPos[i][2]=z;
			        NoTeleportCheck[i]=4;//Do not check position for 4 seconds to prevent lag kick.
			    }
			}
			return 1;
		}
	}
	return 0;
}

public JB_GivePlayerWeapon(playerid,weaponid,ammo)
{
	if(!IsForbiddenWeapon(weaponid) || !WeaponForbiddenForPlayer[playerid][weaponid])
	{
	    GivePlayerWeapon(playerid,weaponid,ammo);
	    return 1;
	}
	new weapon[32];
	GetWeaponName(weaponid,weapon,sizeof(weapon));
	JB_LogEx("Could not give %s weapon %s (%d) because it is forbidden!",ReturnPlayerName(playerid),weapon,weaponid);
	return 0;
}

public JB_SetPlayerHealth(playerid,Float:health)
{
	new Float:tmp_health=health;
	if(tmp_health<0)
	    tmp_health=0;
	else if(tmp_health>100 && JB_Variables[HEALTH_HACK])
	    tmp_health=100;
	return SetPlayerHealth(playerid,tmp_health);
}

public JB_SetPlayerArmour(playerid,Float:armour)
{
	new Float:tmp_armour=armour;
	if(tmp_armour<0)
	    tmp_armour=0;
	else if(tmp_armour>100 && JB_Variables[ARMOUR_HACK])
	    tmp_armour=100;
	return SetPlayerArmour(playerid,tmp_armour);
}

public JB_TogglePlayerControllable(playerid,toggle)
{
	if(toggle)
	    Freezed[playerid]=false;
	else
	    Freezed[playerid]=true;
	return TogglePlayerControllable(playerid,toggle);
}

public SetPlayerSpawnKillProtected(playerid,set)
{
	if(IsPlayerConnected(playerid))
	{
	    if(set)
	    	SpawnKillProtected[playerid]=JB_Variables[SPAWN_TIME];
		else
            SpawnKillProtected[playerid]=0;
	    return 1;
	}
	return 0;
}

//==============================================================================

public MutePlayer(playerid,time,reason[])//Time is seconds.
{
	if(IsPlayerConnected(playerid) && time)
	{
	    Muted[playerid]=time;
	    JB_LogEx("%s has been muted for %d second(s) because of %s.",ReturnPlayerName(playerid),time,reason);
	    SendFormattedMessageToAll(RED,"JunkBuster: Muting player '%s' (%d) for %d second(s). Reason: %s",ReturnPlayerName(playerid),playerid,time,reason);
	    return 1;
	}
	return 0;
}

public JB_Kick(playerid,reason[])
{
	if(IsPlayerConnected(playerid))
	{
	    new string[128];
	    format(string,sizeof(string),"~r~Kick notification:~n~%s",reason);
	    GameTextForPlayer(playerid,string,60000,4);

	    TogglePlayerControllable(playerid,false);
	    SendFormattedMessageToAll(RED,"JunkBuster: Kicking player '%s'. Reason: %s",ReturnPlayerName(playerid),reason);
	    JB_LogEx("%s (%s) has been kicked for %s.",ReturnPlayerName(playerid),ReturnPlayerIp(playerid),reason);
	    Kick(playerid);
	    return 1;
	}
	return 0;
}

public JB_Ban(playerid,reason[])
{
	if(IsPlayerConnected(playerid))
	{
	    new string[128];
	    format(string,sizeof(string),"~r~Ban notification:~n~%s",reason);
	    GameTextForPlayer(playerid,string,60000,4);

	    TogglePlayerControllable(playerid,false);
	    SendFormattedMessageToAll(RED,"JunkBuster: Banning player '%s'. Reason: %s",ReturnPlayerName(playerid),reason);
	    JB_LogEx("%s (%s) has been banned for %s.",ReturnPlayerName(playerid),ReturnPlayerIp(playerid),reason);
	    BanEx(playerid,reason);
	    return 1;
	}
	return 0;
}

stock JB_Log(log[])
{
    printf("[junkbuster] %s",log);
	new string[256];
	format(string,sizeof(string),"%s | %s | %s\r\n",ReturnDate(),ReturnTime(),log);
	new File:f=fopen(JB_LOG_FILE,io_append);
	fwrite(f,string);
	return fclose(f);
}

//==============================================================================

stock IsCheatPosition(Float:x,Float:y,Float:z)
{
	for(new i=0;i<sizeof(CheatPositions);i++)
	    if(GetSquareDistance(x,y,z,CheatPositions[i][0],CheatPositions[i][1],CheatPositions[i][2])<1.5)
	        return true;
	return false;
}

stock IsPlayerInPlane(playerid)
{
	new m=GetVehicleModel(GetPlayerVehicleID(playerid));
	for(new i=0;i<sizeof(Planes);i++)
	    if(m==Planes[i])
	        return true;
	return false;
}

stock IsPlayerInValidState(playerid)
{
	new pstate=GetPlayerState(playerid);
    if(pstate>0 && pstate<=6)
		return true;
	return false;
}

stock AdvertisementCheck(string[])
{
	if(JB_Variables[ADVERTISEMENT] && string[0])
	{
		if(!strfind(string,"www.",false) || !strfind(string,"http://",false) || !strfind(string,".com",false) || !strfind(string,".net",false)
			|| !strfind(string,".de",false) || !strfind(string,".org",false))
		    return true;

		new c=1,idx,tmp[32],ip[4];
		for(new i=0;i<strlen(string);i++)
		    if(string[i]==' ')
		        c++;

		for(new i=0;i<c;i++)
		{
		    idx=0;
		    tmp=JB_strtok(string,idx);
		    idx=0;
		    tmp=JB_strtok(tmp,idx,':');
			ip=Split(tmp);
			if(ip[0] && ip[1] && ip[2] && ip[3]) // We have found and IP :o
			    return true;
		}
	}
	return false;
}

stock BadWordsCheck(text[])
{
	/*
	    Example: The bad word is "noob". In BadWords.cfg it must be written as "nob".
	    This code will prevent this word in all form:
	    - "no.ob"
	    - "no     ob"
		- "nooooooooooooooooooob"
		- etc.
	*/
	new c,string[128];
	for(new i=0;i<strlen(text);i++)
	{
	    if((text[i]>='a' && text[i]<='z') || (text[i]>='A' && text[i]<='Z'))
		{
		    if(!c || (c && string[c-1]!=text[i]))
		    {
				string[c]=text[i];
				c++;
			}
		}
		if(c>=sizeof(string))
			break;
	}

	for(new i=0;i<BadWordsCount;i++)
	    if(strfind(string,BadWords[i],true)!=-1)
	        return true;
	return false;
}

stock CapsLockCheck(text[])
{
	new len=strlen(text);
	if(len>3)
	{
	    new c;
	    for(new i=0;i<len;i++)
	        if(text[i]>='A' && text[i]<='Z')
				c++;

		if(c)
			if(c>=len/4*3)
		    	return true;
	}
	return false;
}

stock IsForbiddenWeapon(weaponid)
{
	if(weaponid && JB_Variables[WEAPON_HACK])
	{
	    for(new i=0;i<ForbiddenWeaponsCount;i++)
	        if(ForbiddenWeapons[i]==weaponid)
	            return true;
	}
	return false;
}

stock ForbidWeaponForPlayer(playerid,weaponid,forbid)
{
	if(IsPlayerConnected(playerid))
	{
	    WeaponForbiddenForPlayer[playerid][weaponid]=forbid;
		return 1;
	}
	return 0;
}

stock ResetForbiddenWeaponsForPlayer(playerid) // Forbid like in configuration
{
	if(IsPlayerConnected(playerid))
	{
    	for(new i=0;i<MAX_WEAPONS;i++)
			ForbidWeaponForPlayer(playerid,i,false);

		for(new i=0;i<MAX_FORBIDDEN_WEAPONS;i++)
			ForbidWeaponForPlayer(playerid,ForbiddenWeapons[i],true);
		return 1;
	}
	return 0;
}

stock JunkBusterReport(playerid,report[],details[])
{
	if(IsPlayerConnected(playerid))
	{
		new string[128];
		format(string,sizeof(string),"JunkBuster: Suspected player with %s: %s (%d), %s.",report,ReturnPlayerName(playerid),playerid,details);
		for(new i=0;i<MAX_PLAYERS;i++)
		    if(IsPlayerConnected(i))
			    if(JB_IsPlayerAdmin(i) && i!=playerid)
			        SendClientMessage(i,RED,string);

		return JB_Log(string[12]);
	}
	return 0;
}

stock JB_IsPlayerAdmin(playerid)
	return (IsPlayerAdmin(playerid) || CallRemoteFunction("IsPlayerAdminCall","i",playerid));

/*
Put for example this into your gamemode (Godfather):

forward IsPlayerAdminCall(playerid);
public IsPlayerAdminCall(playerid)
	return (PlayerInfo[playerid][pAdmin] >= 1);

You can link your admin system with JunkBuster,
if you use this function.
*/

//==============================================================================

public GlobalUpdate()
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        /*
			This should prevent ban of innocents
			Example:
				Someone plays 3 hours and in this 3 hours, JunkBuster thinks 3 times (for example every hours) he
				is a speedhacker or some shit like this because for a short time he lags.
				And the innocent player will get banned. This function prevents moments like this - real cheaters
				will not use the speedhack or teleport cheats once in an hour.
				Speedhack also bans airbreakers. They will get banned soon if they airbreak.
			*/
	        if(JB_Warnings[i][TELEPORT_HACK])
	            JB_Warnings[i][TELEPORT_HACK]--;
	            
			if(JB_Warnings[i][MAX_SPEED])
			    JB_Warnings[i][MAX_SPEED]--;
	    }
	}
	return 1;
}

public SpamUpdate()
{
	new reason[64];
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(Messages[i])
			{
			    if(!Muted[i] && JB_Variables[SPAM] && (!JB_IsPlayerAdmin(i) || !JB_Variables[ADMIN_IMMUNITY]))
			    {
				    if(Messages[i]>15)
				    {
				        format(reason,sizeof(reason),"Extreme spam [%d messages/second]",Messages[i]);
				        JB_Ban(i,reason);
				        continue;
				    }
				    else if(Messages[i]>10)
				    {
				        format(reason,sizeof(reason),"Massive spam [%d messages/second]",Messages[i]);
				        JB_Kick(i,reason);
				        continue;
				    }
				    else if(Messages[i]>4)
				    {
				        format(reason,sizeof(reason),"Spam [%d messages/second]",Messages[i]);
					    MutePlayer(i,2*60,reason);
					}
				}
    			Messages[i]--;
			}
			
            if(Commands[i])
			{
			    if(JB_Variables[COMMAND_SPAM] && (!JB_IsPlayerAdmin(i) || !JB_Variables[ADMIN_IMMUNITY]))
			    {
				    if(Commands[i]>15)
				    {
				        format(reason,sizeof(reason),"Extreme command spam [%d commands/second]",Commands[i]);
				        JB_Ban(i,reason);
				        continue;
				    }
				    else if(Commands[i]>5)
				    {
				        format(reason,sizeof(reason),"Massive command spam [%d commands/second]",Commands[i]);
				        JB_Kick(i,reason);
				        continue;
				    }
			    }
			    Commands[i]--;
			}
		}
	}
	return 1;
}

//==============================================================================
						/*   MAIN FUNCTION OF ANTI-CHEAT   */

public JunkBuster()
{
	new Float:health,Float:armour,weaponid,aping,reason[64];
	new Float:x,Float:y,Float:z;
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(GetPlayerPos(i,x,y,z))
	    {
	        if(Muted[i])
	            Muted[i]--;
	            
			if(SpawnKillProtected[i])
			    SpawnKillProtected[i]--;

			if(JB_Variables[MONEY_HACK])
			    if(GetPlayerMoney(i)>JB_Money[i])
			        SetPlayerMoney(i,JB_Money[i]);

            if(SpeedHacking[i]>=3)
			{
			    TogglePlayerControllable(i,true);
			    SpeedHacking[i]=0;
			}

			if(Freezed[i] && JB_Variables[FREEZE_UPDATE])//Prevent  that cheaters unfreeze themselves.
			    TogglePlayerControllable(i,false);

			if(IsPlayerInValidState(i) && (!JB_IsPlayerAdmin(i) || !JB_Variables[ADMIN_IMMUNITY]))
			{
			    if(!NoTeleportCheck[i])
			    {
			    
			        if(z<900 && CurrentPos[i][2]<900)//Prevent kick when entering buildings.
			        {
						if(GetSquareDistance(x,y,z,CurrentPos[i][0],CurrentPos[i][1],CurrentPos[i][2])>(500*500) && GetPlayerState(i)!=PLAYER_STATE_PASSENGER)
						{
						    JB_Warnings[i][TELEPORT_HACK]++;
					        if(JB_Variables[TELEPORT_HACK] && JB_Warnings[i][TELEPORT_HACK]>=3)
					        {
								JB_Kick(i,"Using teleport cheats [Code 1]");
								continue;
							}
							else if(JB_Variables[TELEPORT_HACK] && IsCheatPosition(x,y,z))
							{
							    JB_Ban(i,"Using teleport cheats [Code 2]");
								continue;
							}
							else
							{
							    GetPlayer2DZone(i,reason,sizeof(reason));
							    JunkBusterReport(i,"teleport cheats",reason);
							}
						}
					}

					if(GetPlayerState(i)==PLAYER_STATE_DRIVER && JB_Variables[MAX_SPEED])
					{
					    weaponid=GetPlayerSpeed(i);
						if(weaponid>JB_Variables[MAX_SPEED] && !IsPlayerInPlane(i))
						{
						    SpeedHacking[i]++;
						    if(SpeedHacking[i]==3)
							{
							    JB_Warnings[i][MAX_SPEED]++;
							    TogglePlayerControllable(i,false);
							    if(JB_Warnings[i][MAX_SPEED]<3)
							    {
								    format(reason,sizeof(reason),"%d KM/H with %s",weaponid,GetVehicleName(GetPlayerVehicleID(i)));
								    JunkBusterReport(i,"speedhack",reason);
							    }
							    else
							    {
							        JB_Ban(i,"Speedhack");
							        continue;
							    }
							}
						}
						else
						    SpeedHacking[i]=0;
					}
			    }
  				else
			  		NoTeleportCheck[i]--;

			    weaponid=GetPlayerWeapon(i);
			    if(IsForbiddenWeapon(weaponid) && WeaponForbiddenForPlayer[i][weaponid])
			    {
					GetWeaponName(weaponid,reason,sizeof(reason));
			        format(reason,sizeof(reason),"Using weapon cheats (%s)",reason);
					JB_Ban(i,reason);
			        continue;
			    }

			    if(GetPlayerSpecialAction(i)==SPECIAL_ACTION_USEJETPACK && JB_Variables[JETPACK])
			    {
					JB_Ban(i,"Using jetpack");
			        continue;
			    }

				if(JB_Variables[HEALTH_HACK])
				{
				    GetPlayerHealth(i,health);
				    if(health>100)
				    {
				        JB_Ban(i,"Health hack");
				        continue;
				    }
				}

				if(JB_Variables[ARMOUR_HACK])
				{
				    GetPlayerArmour(i,armour);
				    if(armour>100)
				    {
				        JB_Ban(i,"Armour hack");
				        continue;
				    }
				}
			}

			if(GetPlayerState(i) && (!JB_IsPlayerAdmin(i) || !JB_Variables[ADMIN_IMMUNITY]))
			{
				Ping[i][PingCheckProgress[i]]=GetPlayerPing(i);
				PingCheckProgress[i]++;
				if(PingCheckProgress[i]==MAX_PING_CHECKS)
				{
				    if(JB_Variables[MAX_PING])
				    {
						aping=0;
						for(new j=0;j<MAX_PING_CHECKS;j++)
						    aping+=Ping[i][j];
						aping/=MAX_PING_CHECKS;
						if(aping>JB_Variables[MAX_PING])
						{
							format(reason,sizeof(reason),"Too high ping. [%d/%d]",aping,JB_Variables[MAX_PING]);
							JB_Kick(i,reason);
							continue;
						}
				    }
				    PingCheckProgress[i]=0;
				}
			}

			GetPlayerPos(i,CurrentPos[i][0],CurrentPos[i][1],CurrentPos[i][2]);
	    }
	}
	return 1;
}


//==============================================================================

stock Split(ip_string[])
{
	new ip[4],string[16];
	format(string,sizeof(string),ip_string);

	for(new i=0;i<strlen(string);i++)
		if(string[i]=='.')
		    string[i]=' ';

	new idx,tmp[32];
	for(new i=0;i<4;i++)
	{
	    tmp=JB_strtok(string,idx);
	    if(tmp[0]=='*')
	        ip[i]=-1;
		else
			ip[i]=strval(tmp);
	}
	return ip;
}

stock IpBanCheck(playerid)
{
	new ip[4];
	ip=Split(ReturnPlayerIp(playerid));
	for(new i=0;i<sizeof(IpBans);i++)
	    if(IpBanned[i])
			if(IsSameIpEx(IpBans[i],ip))
			    return 1;
	return 0;
}

stock IsSameIp(ip1[4],ip2[4])
{
 	for(new i=0;i<4;i++)
		if(ip1[i]!=ip2[i])
		    return 0;
	return 1;
}

stock IsSameIpEx(ip1[4],ip2[4])// Check for range-ban
{
	for(new i=0;i<4;i++)
		if(ip1[i]!=ip2[i] && ip1[i]!=-1 && ip2[i]!=-1)
		    return 0;
	return 1;
}


public BanIp(ip_string[])
{
    new ip[4];
	ip=Split(ip_string);
	for(new i=0;i<sizeof(IpBans);i++)
	{
	    if(!IpBanned[i])
	    {
			IpBanned[i]=true;
			IpBans[i]=ip;
			JB_LogEx("IP %s has been banned.",ip_string);

			for(new j=0;j<MAX_PLAYERS;j++)
			    if(IsPlayerConnected(j))
			        if(IsSameIpEx(ip,Split(ReturnPlayerIp(j))))
			            JB_Kick(j,"IP has been banned");
			return 1;
	    }
	}
	JB_LogEx("Could not ban IP %s!",ip_string);
	return 0;
}

public UnbanIp(ip_string[])
{
	new ip[4];
	ip=Split(ip_string);
	for(new i=0;i<sizeof(IpBans);i++)
	{
	    if(IsSameIp(IpBans[i],ip))
	    {
			IpBanned[i]=false;
			JB_LogEx("IP %s has been unbanned.",ip_string);
			return 1;
	    }
	}
	JB_LogEx("Could not unban IP %s!",ip_string);
	return 0;
}

public SaveIpBans()
{
 	fremove(IP_BAN_FILE);
	new File:f=fopen(IP_BAN_FILE, io_append),string[32];
	for(new i=0;i<sizeof(IpBans);i++)
	{
		if(IpBanned[i])
		{
		    string[0]=0;
			for(new j=0;j<4;j++)
			{
			    if(IpBans[i][j]==-1)
			        format(string,sizeof(string),"%s.*",string);
				else
				    format(string,sizeof(string),"%s.%d",string,IpBans[i][j]);
			}
			format(string,sizeof(string),"%s\r\n",string[1]);
			fwrite(f,string);
		}
	}
	fclose(f);
	return 1;
}

public LoadIpBans()
{
    if(dini_Exists(IP_BAN_FILE))
	{
	    for(new i=0;i<sizeof(IpBans);i++)
	        IpBanned[i]=false;

	    new File:f=fopen(IP_BAN_FILE, io_read),c,string[16];
	    while(fread(f,string,sizeof(string)) && c<sizeof(IpBans))
	    {
	        StripNewLine(string);
	        if(strlen(string))
	        {
				IpBans[c]=Split(string);
				IpBanned[c]=true;
				c++;
			}
	    }
	    fclose(f);
		JB_LogEx("%d IP-bans have been loaded.",c);
	    return 1;
	}
	JB_Log("Could not load IP-bans!");
	return 0;
}

//==============================================================================

public LoadBlacklist()
{
	if(dini_Exists(BLACKLIST_FILE))
	{
	    for(new i=0;i<sizeof(Blacklist);i++)
	        Blacklist[i][0]=0;

	    new File:f=fopen(BLACKLIST_FILE, io_read),c,string[MAX_PLAYER_NAME];
	    while(fread(f,string,sizeof(string)) && c<sizeof(Blacklist))
	    {
	        StripNewLine(string);
	        if(strlen(string))
	        {
	            Blacklist[c]=string;
	            c++;
	        }
	    }
	    fclose(f);
		JB_LogEx("%d blacklist entries have been loaded.",c);
	    return 1;
	}
	JB_Log("Could not load blacklist!");
	return 0;
}

public UpdateBlacklist()
{
	fremove(BLACKLIST_FILE);
	new string[MAX_PLAYER_NAME+2];
	new File:f=fopen(BLACKLIST_FILE,io_append);
	for(new i=0;i<sizeof(Blacklist);i++)
	{
	    if(Blacklist[i][0])
	    {
			format(string,sizeof(string),"%s\r\n",Blacklist[i]);
			fwrite(f,string);
		}
	}
	JB_Log("Blacklist has been updated.");
	return fclose(f);
}

public AddNameToBlacklist(name[])
{
	new success;
	for(new i=0;i<sizeof(Blacklist);i++)
	{
	    if(!Blacklist[i][0])
	    {
			format(Blacklist[i],MAX_PLAYER_NAME,name);
			success=true;
			break;
	    }
	}

	if(success)
	{
		if(UpdateBlacklist())
		{
			JB_LogEx("Player '%s' has successfully been added to blacklist.",name);
		    return 1;
		}
	}
	JB_LogEx("Could not add player '%s' to blacklist!",name);
	return 0;
}

public RemoveNameFromBlacklist(name[])
{
	new success;
	for(new i=0;i<sizeof(Blacklist);i++)
	{
	    if(Blacklist[i][0])
	    {
			if(!strcmp(Blacklist[i],name,false))
			{
			    Blacklist[i][0]=0;
				success=true;
				break;
			}
	    }
	}

	if(success)
	{
		if(UpdateBlacklist())
		{
			JB_LogEx("Player '%s' has successfully been removed from blacklist.",name);
		    return 1;
		}
	}
	JB_LogEx("Could not remove player '%s' from blacklist!",name);
	return 0;
}

public AddPlayerToBlacklist(playerid)
{
	if(AddNameToBlacklist(ReturnPlayerName(playerid)))
		return JB_Ban(playerid,"Blacklist");
	return 0;
}

stock IsPlayerOnBlacklist(playerid)
{
	new name[MAX_PLAYER_NAME];
	name=ReturnPlayerName(playerid);
	for(new i=0;i<sizeof(Blacklist);i++)
	{
	    if(Blacklist[i][0])
	        if(!strcmp(name,Blacklist[i],false))
	            return true;
	}
	return false;
}

//==============================================================================

public LoadWhitelist()
{
	if(dini_Exists(WHITELIST_FILE))
	{
	    for(new i=0;i<sizeof(Whitelist);i++)
	        Whitelist[i][0]=0;

	    new File:f=fopen(WHITELIST_FILE, io_read),c,string[MAX_PLAYER_NAME];
	    while(fread(f,string,sizeof(string)) && c<sizeof(Whitelist))
	    {
	        StripNewLine(string);
	        if(strlen(string))
	        {
	            Whitelist[c]=string;
	            c++;
	        }
	    }
	    fclose(f);
		JB_LogEx("%d whitelist entries have been loaded.",c);
	    return 1;
	}
	JB_Log("Could not load whitelist!");
	return 0;
}

public UpdateWhitelist()
{
	fremove(WHITELIST_FILE);
	new string[MAX_PLAYER_NAME+2];
	new File:f=fopen(WHITELIST_FILE,io_append);
	for(new i=0;i<sizeof(Whitelist);i++)
	{
	    if(Whitelist[i][0])
	    {
			format(string,sizeof(string),"%s\r\n",Whitelist[i]);
			fwrite(f,string);
		}
	}
	JB_Log("Whitelist has been updated.");
	return fclose(f);
}

public AddNameToWhitelist(name[])
{
	new success;
	for(new i=0;i<sizeof(Whitelist);i++)
	{
	    if(!Whitelist[i][0])
	    {
			format(Whitelist[i],MAX_PLAYER_NAME,name);
			success=true;
			break;
	    }
	}

	if(success)
	{
		if(UpdateWhitelist())
		{
			JB_LogEx("Player '%s' has successfully been added to whitelist.",name);
		    return 1;
		}
	}
	JB_LogEx("Could not add player '%s' to whitelist!",name);
	return 0;
}

public RemoveNameFromWhitelist(name[])
{
	new success;
	for(new i=0;i<sizeof(Whitelist);i++)
	{
	    if(Whitelist[i][0])
	    {
			if(!strcmp(Whitelist[i],name,false))
			{
			    Whitelist[i][0]=0;
				success=true;
				break;
			}
	    }
	}

	if(success)
	{
		if(UpdateWhitelist())
		{
			JB_LogEx("Player '%s' has successfully been removed from whitelist.",name);
		    return 1;
		}
	}
	JB_LogEx("Could not remove player '%s' from whitelist!",name);
	return 0;
}

public AddPlayerToWhitelist(playerid)
{
	return AddNameToWhitelist(ReturnPlayerName(playerid));
}

stock IsPlayerOnWhitelist(playerid)
{
	new name[MAX_PLAYER_NAME];
	name=ReturnPlayerName(playerid);
	for(new i=0;i<sizeof(Whitelist);i++)
	{
	    if(Whitelist[i][0])
	        if(!strcmp(name,Whitelist[i],false))
	            return true;
	}
	return false;
}

//==============================================================================

stock TemporaryBanCheck(playerid)
{
	new name[MAX_PLAYER_NAME],ip[16];
	name=ReturnPlayerName(playerid);
	ip=ReturnPlayerIp(playerid);
	for(new i=0;i<sizeof(TempBanInfo);i++)
	{
	    if(TempBanInfo[i][tbTime])
	    {
	        if(!strcmp(TempBanInfo[i][tbName],name,false))
			{
				TempBanInfo[i][tbIp]=ip;
				SendFormattedMessage(playerid,RED,"JunkBuster: You are temporary banned for %d hour(s) and now, you will be banned for one more day.",TempBanInfo[i][tbTime]);
                TempBanInfo[i][tbTime]+=24;// Banning player for one day longer because of ban evading.
                JB_LogEx("%s (%s) has been banned for Ban evading.",name,ip);
				BanEx(playerid,"Ban evading");
				return 1;
			}
	    }
	}
	return 0;
}

public TempBan(playerid,hours,reason[])
{
	if(hours)
	{
		new name[MAX_PLAYER_NAME],ip[16];
		name=ReturnPlayerName(playerid);
		ip=ReturnPlayerIp(playerid);
	    for(new i=0;i<sizeof(TempBanInfo);i++)
		{
			if(!TempBanInfo[i][tbTime])
			{
			    TempBanInfo[i][tbTime]=hours;
			    TempBanInfo[i][tbIp]=ip;
			    TempBanInfo[i][tbName]=name;
			    new string[32];
			    format(string,sizeof(string),"%s [%d hour(s)]",reason,hours);
				JB_Ban(playerid,string);
				return 1;
			}
		}
	}
	return 0;
}

public DeleteTempBan(name[])
{
	for(new i=0;i<sizeof(TempBanInfo);i++)
	{
		if(TempBanInfo[i][tbTime])
		{
		    if(!strcmp(TempBanInfo[i][tbName],name,false))
		    {
			    TempBanInfo[i][tbTime]=0;
				new string[16];
				format(string,sizeof(string),"unbanip %s",TempBanInfo[i][tbIp]);
				SendRconCommand(string);
				JB_LogEx("Player '%s' (%s) has been unbanned.",name,TempBanInfo[i][tbIp]);
				return 1;
			}
		}
	}
	return 0;
}

public LoadTempBans()
{
	if(dini_Exists(TEMP_BAN_FILE))
	{
	    new File:f=fopen(TEMP_BAN_FILE, io_read),c,string[64],idx;
	    while(fread(f,string,sizeof(string)) && c<sizeof(TempBanInfo))
	    {
	        StripNewLine(string);
	        idx=0;
			if(strlen(string))
			{
			    TempBanInfo[c][tbTime]=strval(JB_strtok(string,idx));
				if(TempBanInfo[c][tbTime])
				{
				    format(TempBanInfo[c][tbIp],16,JB_strtok(string,idx));
				    format(TempBanInfo[c][tbName],16,JB_strtok(string,idx));
				    c++;
				}
			}
	    }
	    fclose(f);
	    JB_LogEx("%d temporary bans have been loaded.",c);
	    return 1;
	}
	JB_Log("Could not load temporary bans!");
	return 0;
}

public SaveTempBans()
{
 	fremove(TEMP_BAN_FILE);
	new File:f=fopen(TEMP_BAN_FILE, io_append),string[64];
	for(new i=0;i<sizeof(TempBanInfo);i++)
	{
		if(TempBanInfo[i][tbTime])
		{
		    format(string,sizeof(string),"%d %s %s\r\n",TempBanInfo[i][tbTime],TempBanInfo[i][tbIp],TempBanInfo[i][tbName]);
		    fwrite(f,string);
		}
	}
	fclose(f);
	return 1;
}

public TempBanUpdate()
{
    new string[32];
    for(new i=0;i<sizeof(TempBanInfo);i++)
	{
		if(TempBanInfo[i][tbTime])
		{
		    TempBanInfo[i][tbTime]--;
		    if(!TempBanInfo[i][tbTime])
		    {
				format(string,sizeof(string),"unbanip %s",TempBanInfo[i][tbIp]);
				SendRconCommand(string);
				JB_LogEx("Player '%s' (%s) has been unbanned.",TempBanInfo[i][tbName],TempBanInfo[i][tbIp]);
			}
		}
	}
	return 1;
}

//==============================================================================

public LoadBadWords()
{
	if(dini_Exists(BAD_WORDS_FILE))
	{
	    new File:f=fopen(BAD_WORDS_FILE, io_read),c,string[32];
	    while(fread(f,string,sizeof(string)) && c<MAX_BAD_WORDS)
	    {
	        StripNewLine(string);
	        if(strlen(string))
	        {
	            BadWords[c]=string;
	            c++;
	        }
	    }
	    fclose(f);
	    BadWordsCount=c;
	    JB_LogEx("%d bad words have been loaded.",BadWordsCount);
	    return 1;
	}
	JB_Log("Could not load bad words!");
	return 0;
}

public LoadForbiddenWeapons()
{
	if(dini_Exists(FORBIDDEN_WEAPONS_FILE))
	{
	    new File:f=fopen(FORBIDDEN_WEAPONS_FILE, io_read),c,string[32];
	    while(fread(f,string,sizeof(string)) && c<MAX_FORBIDDEN_WEAPONS)
	    {
	        StripNewLine(string);
	        if(strlen(string))
	        {
	            ForbiddenWeapons[c]=strval(string);
	            c++;
	        }
	    }
	    fclose(f);
	    ForbiddenWeaponsCount=c;
	    JB_LogEx("%d forbidden weapons have been loaded.",ForbiddenWeaponsCount);
	    return 1;
	}
	JB_Log("Could not load forbidden weapons!");
	return 0;
}

public ConfigJunkBuster()
{
	if(!dini_Exists(CONFIG_FILE))
	    dini_Create(CONFIG_FILE);

    for(new i=0;i<MAX_VARIABLES;i++)
    {
        if(dini_Isset(CONFIG_FILE,JB_VariableNames[i]))
            JB_Variables[i]=dini_Int(CONFIG_FILE,JB_VariableNames[i]);
		else
		    dini_IntSet(CONFIG_FILE,JB_VariableNames[i],JB_Variables[i]);
	}

    print("\n");
    JB_Log("Current JunkBuster configuration:");
    for(new i=0;i<MAX_VARIABLES;i++)
        JB_LogEx("- %s = %d",JB_VariableNames[i],JB_Variables[i]);

	print("\n");

	LoadIpBans();
	LoadTempBans();
	LoadWhitelist();
	LoadBlacklist();
    LoadBadWords();
    LoadForbiddenWeapons();
    JB_Log("JunkBuster has been configurated.");
	return 1;
}

//==============================================================================

stock ReturnTime()
{
	new jb_time[16],jb_h,jb_m,jb_s;
	gettime(jb_h,jb_m,jb_s);
	format(jb_time,sizeof(jb_time),"%02d:%02d:%02d",jb_h,jb_m,jb_s);
	return jb_time;
}

stock ReturnDate()
{
	new jb_date[16],jb_day,jb_month,jb_year;
	getdate(jb_year,jb_month,jb_day);
	format(jb_date,sizeof(jb_date),"%d. %s %d",jb_day,GetMonth(jb_month),jb_year);
	return jb_date;
}

stock GetMonth(month)
{
	new string[32];
	string="Unknown month";
	switch(month)
	{
	    case 1:
	        string="January";
		case 2:
		    string="February";
        case 3:
		    string="March";
        case 4:
		    string="April";
        case 5:
		    string="May";
		case 6:
		    string="June";
		case 7:
		    string="July";
		case 8:
		    string="August";
		case 9:
		    string="Septembre";
		case 10:
		    string="Octobre";
		case 11:
		    string="Novembre";
		case 12:
		    string="Decembre";
	}
	return string;
}

stock ReturnPlayerName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,sizeof(name));
	return name;
}

stock ReturnPlayerIp(playerid)
{
	new ip[16];
	GetPlayerIp(playerid,ip,sizeof(ip));
	return ip;
}

stock JB_strtok(const string[], &index,seperator=' ')
{
	new length = strlen(string);
	new offset = index;
	new result[32];
	while ((index < length) && (string[index] != seperator) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}

	result[index - offset] = EOS;
	if ((index < length) && (string[index] == seperator))
	{
		index++;
	}
	return result;
}

//==============================================================================

public SpeedCheck()
{
	new Float:pos[3];
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(GetPlayerPos(i,pos[0],pos[1],pos[2]))
		{
			Checks[i]++;
			if(Checks[i]==MAX_CHECKS)
				Checks[i]=0;
			if(JB_Variables[SPEED_3D])
				Speed[i][Checks[i]]=floatround(floatsqroot((LastPos[i][0]-pos[0])*(LastPos[i][0]-pos[0])+(LastPos[i][1]-pos[1])*(LastPos[i][1]-pos[1])+(LastPos[i][2]-pos[2])*(LastPos[i][2]-pos[2]))/float(GetTickCount()-SpeedTime[i])*3600);
			else //It's better to use only 2D speed.
				Speed[i][Checks[i]]=floatround(floatsqroot((LastPos[i][0]-pos[0])*(LastPos[i][0]-pos[0])+(LastPos[i][1]-pos[1])*(LastPos[i][1]-pos[1]))/float(GetTickCount()-SpeedTime[i])*3600);
			SpeedTime[i]=GetTickCount();
			LastPos[i]=pos;
		}
	}
	return 1;
}

stock GetPlayerSpeed(playerid)
{
	new v;
	for(new i=0;i<MAX_CHECKS;i++)
		v+=Speed[playerid][i];
	v/=MAX_CHECKS;
	return v;
}

//==============================================================================

public OnPlayerSpawn(playerid)
{
    NoTeleportCheck[playerid]=3;
    Freezed[playerid]=false;
    return CallLocalFunction("PnP_OnPlayerSpawn","i",playerid);
}

public OnPlayerDeath(playerid,killerid,reason)
{
	if(killerid!=INVALID_PLAYER_ID)
	{
	    new Float:x1,Float:y1,Float:z1;
	    new Float:x2,Float:y2,Float:z2;
		new Float:distance=floatsqroot(GetSquareDistance(x1,y1,z1,x2,y2,z2));
	    if(JB_Variables[DRIVE_BY])
	    {
			if(distance<25.0 && GetPlayerState(killerid)==PLAYER_STATE_DRIVER && (reason==WEAPON_UZI || reason==WEAPON_MP5 || reason==WEAPON_TEC9))
			{
			    SetPlayerHealth(killerid,0.0);
			    SendClientMessage(killerid,RED,"JunkBuster: You have been killed for drive-by!");
			}
		}

		if(JB_Variables[SPAWNKILL])
		{
		    if(distance<30.0)
		    {
		        if(SpawnKillProtected[playerid])
		        {
		            JB_Warnings[killerid][SPAWNKILL]++;
		            if(JB_Warnings[killerid][SPAWNKILL]>=JB_Variables[SPAWNKILL])
						JB_Kick(killerid,"Excessive spawnkilling");
					else
						SendFormattedMessage(killerid,RED,"JunkBuster: Do not spawnkill! (Warning %d/%d)",JB_Warnings[killerid][SPAWNKILL],JB_Variables[SPAWNKILL]);
				}
			}
	 	}
 	}
	return CallLocalFunction("PnP_OnPlayerDeath","iii",playerid,killerid,reason);
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	NoTeleportCheck[playerid]=3;
	return CallLocalFunction("PnP_OnPlayerInteriorChange","iii",playerid, newinteriorid, oldinteriorid);
}

public OnGameModeInit()
{
	if(!CallLocalFunction("PnP_OnGameModeInit",""))
	{
	    JB_Log("JunkBuster is not used in gamemode or OnGameModeInit returns 0.");
	    JB_Log("Make sure you use JunkBuster.inc in your gamemode. If you want to");
        JB_Log("use JunkBuster in filterscripts, too, include  JunkBusterFS.inc in");
        JB_Log("your filterscript. (JunkBuster.inc MUST be included in gamemode)");
	    JB_Log("=> CLOSING SERVER!");
	    SendRconCommand("exit");
	    return 0;
	}
	
	#if defined WARN_PLAYERS
	    SendRconCommand("mapname JunkBuster Anti-Cheat");
	#endif
	ConfigJunkBuster();
	SetTimer("JunkBuster",1000,true);
	SetTimer("SpeedCheck",240,true);
	SetTimer("GlobalUpdate",60*1000*4,true);// Every 4 minutes
	SetTimer("SpamUpdate",3500,true);
	SetTimer("TempBanUpdate",1000*60*60,true);// Every hour
	JB_Log("JunkBuster has successfully been loaded.");
	return 1;
}

public OnGameModeExit()
{
	SaveIpBans();
	SaveTempBans();
    return CallLocalFunction("PnP_OnGameModeExit","");
}

public OnPlayerConnect(playerid)
{
	KickBan[playerid]=false;

	if(TemporaryBanCheck(playerid) && JB_Variables[TEMP_BANS])
	{
	    KickBan[playerid]=true;
	    return 0;
	}

	if(IpBanCheck(playerid) && !IsPlayerOnWhitelist(playerid) && JB_Variables[IP_BANS])
	{
	    KickBan[playerid]=true;
	    SendClientMessage(playerid,RED,"JunkBuster: You are banned from this server!");
	    JB_LogEx("%s (%s) has been kicked for Banned IP.",ReturnPlayerName(playerid),ReturnPlayerIp(playerid));
	    Kick(playerid);
	    return 0;
	}

	if(IsPlayerOnBlacklist(playerid) && JB_Variables[BLACKLIST])
	{
	    KickBan[playerid]=true;
	    SendClientMessage(playerid,RED,"JunkBuster: You are banned from this server!");
	    JB_LogEx("%s (%s) has been banned for Ban evading.",ReturnPlayerName(playerid),ReturnPlayerIp(playerid));
	    BanEx(playerid,"Ban evading");
	    return 0;
	}

	for(new i=0;i<MAX_VARIABLES;i++)
	    JB_Warnings[playerid][i]=0;

	ResetForbiddenWeaponsForPlayer(playerid);
	Messages[playerid]=0;
	Commands[playerid]=0;
    NoTeleportCheck[playerid]=0;
    PingCheckProgress[playerid]=0;
	VehicleEntered[playerid]=0;
	Muted[playerid]=0;
	Freezed[playerid]=false;
	#if defined WARN_PLAYERS
		SendClientMessage(playerid,GREEN_BLUE,"> This server is running JunkBuster Anti-Cheat!");
		SendClientMessage(playerid,GREEN_BLUE,"> You may not cheat otherwise you'll get kicked/banned.");
	#endif
	return CallLocalFunction("PnP_OnPlayerConnect","i",playerid);
}

public OnPlayerDisconnect(playerid,reason)
{
	if(KickBan[playerid])
	    return 0;
	return CallLocalFunction("PnP_OnPlayerDisconnect","ii",playerid,reason);
}

public OnPlayerText(playerid, text[])
{
	if(Muted[playerid] && JB_Variables[SPAM])
	{
	    SendFormattedMessage(playerid,RED,"JunkBuster: You are not allowed to chat for %d second(s) because you have been muted!",Muted[playerid]);
	    return 0;
	}

    Messages[playerid]++;
    if(CapsLockCheck(text) && JB_Variables[CAPS_LOCK])
	{
	    SendClientMessage(playerid,RED,"JunkBuster: You are not allowed to use Caps Lock! Press [Caps Lock] to disable it.");
	    return 0;
	}

	if(AdvertisementCheck(text) && !JB_IsPlayerAdmin(playerid))
	{
	    JB_Kick(playerid,"Advertisement");
	    return 0;
	}

	if(BadWordsCheck(text) && JB_Variables[BAD_WORDS])
	{
	    SendClientMessage(playerid,RED,"JunkBuster: You are not allowed to use such words!");
	    return 0;
	}
	return CallLocalFunction("PnP_OnPlayerText","is",playerid,text);
}

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
    #pragma unused recieverid
	if(Muted[playerid] && JB_Variables[SPAM])
	{
	    SendFormattedMessage(playerid,RED,"JunkBuster: You are not allowed to chat for %d second(s) because you have been muted!",Muted[playerid]);
	    return 0;
	}

    Messages[playerid]++;
    if(CapsLockCheck(text) && JB_Variables[CAPS_LOCK])
	{
	    SendClientMessage(playerid,RED,"JunkBuster: You are not allowed to use Caps Lock! Press [Caps Lock] to disable it.");
	    return 0;
	}

	if(BadWordsCheck(text) && JB_Variables[BAD_WORDS])
	{
	    SendClientMessage(playerid,RED,"JunkBuster: You are not allowed to use such words!");
	    return 0;
	}
	return CallLocalFunction("PnP_OnPlayerPrivmsg","iis",playerid, recieverid, text);
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	Commands[playerid]++;
	new cmd[32],tmp[32],idx,pid;
	cmd=JB_strtok(cmdtext,idx);

	if(JB_IsPlayerAdmin(playerid))
	{
	    if(!strcmp("/jbcmds",cmd,true))
	    {
	        SendClientMessage(playerid,GREEN_BLUE,"Available commands:");
	        SendClientMessage(playerid,GREEN," /cfg, /blackadd <ID/name>, /blackdel <name>, /whiteadd <name>, /whitedel <name>");
	        SendClientMessage(playerid,GREEN," /tban <ID> <time in hours> <reason>, /tunban <name>, /banIP <IP>, /unbanIP <IP>");
	        SendClientMessage(playerid,GREEN," /jbvarlist, /jbsetvar <variable name> <0/1(/max ping)>");
	        return 1;
	    }

		if(!strcmp("/cfg",cmd,true))
		{
		    ConfigJunkBuster();
		    SendClientMessage(playerid,GREEN,"JunkBuster: Configuration has been updated.");
			return 1;
		}

		if(!strcmp("/blackadd",cmd,true))
		{
		    tmp=JB_strtok(cmdtext,idx);
		    if(strlen(tmp))
		    {
				if(!isNumeric(tmp))
				{
				    if(AddNameToBlacklist(tmp))
				        SendFormattedMessage(playerid,GREEN,"JunkBuster: Player '%s' has successfully been added to blacklist!",tmp);
					else
					    SendFormattedMessage(playerid,RED,"JunkBuster: Could not add player '%s' to blacklist!",tmp);
					return 1;
				}
				else
				{
				    pid=strval(tmp);
				    if(pid!=playerid)
				    {
					    if(AddPlayerToBlacklist(pid))
					        SendFormattedMessage(playerid,GREEN,"JunkBuster: Player '%s' has successfully been added to blacklist!",tmp);
						else
						    SendFormattedMessage(playerid,RED,"JunkBuster: Could not add player '%s' to blacklist!",tmp);
						return 1;
					}
				}
			}
			SendClientMessage(playerid,RED,"Usage: /blackadd <ID/name>");
			return 1;
		}

		if(!strcmp("/blackdel",cmd,true))
		{
		    tmp=JB_strtok(cmdtext,idx);
		    if(strlen(tmp))
		    {
			    if(RemoveNameFromBlacklist(tmp))
			        SendFormattedMessage(playerid,GREEN,"JunkBuster: Player '%s' has successfully been removed from blacklist!",tmp);
				else
				    SendFormattedMessage(playerid,RED,"JunkBuster: Could not remove player '%s' from blacklist!",tmp);
				return 1;
			}
			SendClientMessage(playerid,RED,"Usage: /blackdel <name>");
			return 1;
		}

		if(!strcmp("/whiteadd",cmd,true))
		{
		    tmp=JB_strtok(cmdtext,idx);
      		if(strlen(tmp))
		    {
       			if(AddNameToWhitelist(tmp))
			        SendFormattedMessage(playerid,GREEN,"JunkBuster: Player '%s' has successfully been added to whitelist!",tmp);
				else
				    SendFormattedMessage(playerid,RED,"JunkBuster: Could not add player '%s' to whitelist!",tmp);
				return 1;
			}
			SendClientMessage(playerid,RED,"Usage: /whiteadd <name>");
			return 1;
		}

		if(!strcmp("/whitedel",cmd,true))
		{
		    tmp=JB_strtok(cmdtext,idx);
		    if(strlen(tmp))
		    {
			    if(RemoveNameFromWhitelist(tmp))
			        SendFormattedMessage(playerid,GREEN,"JunkBuster: Player '%s' has successfully been removed from whitelist!",tmp);
				else
				    SendFormattedMessage(playerid,RED,"JunkBuster: Could not remove player '%s' from whitelist!",tmp);
				return 1;
			}
			SendClientMessage(playerid,RED,"Usage: /whitedel <name>");
			return 1;
		}

		if(!strcmp("/jbvarlist",cmd,true))
		{
		    new string[128];
		    SendClientMessage(playerid,GREEN_BLUE,"JunkBuster variables:");
		    for(new i=0;i<MAX_VARIABLES;i++)
		    {
			    if(pid<3)
			    {
					format(string,sizeof(string),"%s, %s = %d",string,JB_VariableNames[i],JB_Variables[i]);
					pid++;
			    }
			    else
			    {
			        format(string,sizeof(string)," %s, %s = %d",string[1],JB_VariableNames[i],JB_Variables[i]);
			        SendClientMessage(playerid,GREEN,string);
			        string[0]=0;
			        pid=0;
				}
			}

			if(pid)
			{
			    format(string,sizeof(string)," %s",string[1]);
		        SendClientMessage(playerid,GREEN,string);
		        format(string,sizeof(string),"\0");
			}
			return 1;
		}

		if(!strcmp("/jbsetvar",cmd,true))
		{

		    tmp=JB_strtok(cmdtext,idx);
		    if(strlen(tmp))
		    {
		        new var[32];
		    	var=tmp;
		    	tmp=JB_strtok(cmdtext,idx);
		    	if(strlen(tmp) && isNumeric(tmp))
		    	{
		    		pid=strval(tmp);
		    		if(pid>=0)
		    		{
		    		    for(new i=0;i<MAX_VARIABLES;i++)
		    		    {
		    		        if(!strcmp(var,JB_VariableNames[i],true))
		    		        {
		    		            JB_Variables[i]=pid;
		    		            SendFormattedMessage(playerid,GREEN,"JunkBuster: JunkBuster variable '%s' has successfully been set to %d.",JB_VariableNames[i],JB_Variables[i]);
								return 1;
							}
		    		    }
		    		}
				}
		    }
		    SendClientMessage(playerid,RED,"Usage: /jbsetvar <variable name> <0/1(/max ping)>");
			return 1;
		}

		if(!strcmp("/tban",cmd,true))
		{
		    new time,idx2=strlen(cmd)+2;
		    tmp=JB_strtok(cmdtext,idx);
		    idx2+=strlen(tmp);
		    if(strlen(tmp))
		    {
		        if(isNumeric(tmp))
		        {
		            pid=strval(tmp);
		            if(IsPlayerConnected(pid))
		            {
						tmp=JB_strtok(cmdtext,idx);
						idx2+=strlen(tmp);
						if(strlen(tmp))
						{
							if(isNumeric(tmp))
							{
							    time=strval(tmp);
							    if(strlen(cmdtext[idx2]) && time)
								{
							        TempBan(pid,time,cmdtext[idx2]);
							        return 1;
							    }
							}
						}
		            }
		        }
		    }
		    SendClientMessage(playerid,RED,"Usage: /tban <ID> <time in hours> <reason>");
			return 1;
		}

		if(!strcmp("/tunban",cmd,true))
		{
		    tmp=JB_strtok(cmdtext,idx);
		    if(strlen(tmp))
		    {
		        if(DeleteTempBan(tmp))
		            SendFormattedMessage(playerid,GREEN,"JunkBuster: Temporary ban of player '%s' has successfully been deleted.",tmp);
				else
				    SendFormattedMessage(playerid,RED,"JunkBuster: Could not delete temporary ban of player '%s'!",tmp);
				return 1;
		    }
		    SendClientMessage(playerid,RED,"Usage: /tunban <name>");
			return 1;
		}

		if(!strcmp("/banip",cmd,true))
		{
		    tmp=JB_strtok(cmdtext,idx);
		    if(strlen(tmp))
		    {
				new ip[4];
				ip=Split(tmp);
		        if(ip[0])
		        {
		            if(BanIp(tmp))
		                SendFormattedMessage(playerid,GREEN,"JunkBuster: IP %s has successfully been banned!",tmp);
					else
					    SendFormattedMessage(playerid,RED,"Could not ban IP %s!",tmp);
					return 1;
		        }
		    }
		    SendClientMessage(playerid,RED,"Usage: /banIP <IP>");
			return 1;
		}

		if(!strcmp("/unbanip",cmd,true))
		{
		    tmp=JB_strtok(cmdtext,idx);
		    if(strlen(tmp))
		    {
				new ip[4];
				ip=Split(tmp);
		        if(ip[0])
		        {
		            if(UnbanIp(tmp))
		                SendFormattedMessage(playerid,GREEN,"JunkBuster: IP %s has successfully been unbanned!",tmp);
					else
					    SendFormattedMessage(playerid,RED,"Could not unban IP %s!",tmp);
					return 1;
		        }
		    }
		    SendClientMessage(playerid,RED,"Usage: /unbanIP <IP>");
			return 1;
		}
	}
	return CallLocalFunction("PnP_OnPlayerCommandText","is",playerid,cmdtext);
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    new Float:x,Float:y,Float:z;
    new Float:vx,Float:vy,Float:vz;
    GetPlayerPos(playerid,x,y,z);
    GetVehiclePos(vehicleid,vx,vy,vz);
    if(GetSquareDistance(x,y,z,vx,vy,vz)>(350*350))
        JunkBusterReport(playerid,"spawning vehicles",GetVehicleName(vehicleid));//Counting warnings would be non-sense.

	VehicleEntered[playerid]=vehicleid;
	return CallLocalFunction("PnP_OnPlayerEnterVehicle","iii",playerid, vehicleid, ispassenger);
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(JB_Variables[SPECTATE_HACK] && newstate==PLAYER_STATE_SPECTATING && !JB_IsPlayerAdmin(playerid))
	    JB_Ban(playerid,"Spectate hack");

	new vehicleid=GetPlayerVehicleID(playerid);
	if(newstate==PLAYER_STATE_DRIVER && VehicleEntered[playerid]!=vehicleid && (!JB_IsPlayerAdmin(playerid) || !JB_Variables[ADMIN_IMMUNITY]))
	{
		new used;
		for(new i=0;i<MAX_PLAYERS;i++)
		{
		    if(IsPlayerConnected(i) && i!=playerid)
		    {
		        if(GetPlayerState(i)==PLAYER_STATE_DRIVER)
		        {
		            if(GetPlayerVehicleID(i)==vehicleid)
		            {
		                used=true;
		                break;
		            }
		        }
			}
		}
		
		if(used)
		{
			JB_Warnings[playerid][CAR_JACK_HACK]++;
			if(JB_Variables[CAR_JACK_HACK])
			{
			    if(JB_Warnings[playerid][CAR_JACK_HACK]>=3)
		    		JB_Kick(playerid,"Carjack hack");
			}
			else
			    JunkBusterReport(playerid,"carjack hack","no details");
		}
	}

	if(oldstate==PLAYER_STATE_PASSENGER)
	    NoTeleportCheck[playerid]=3;//Do not check position for 3 seconds to prevent lag kick.

	VehicleEntered[playerid]=0;
	return CallLocalFunction("PnP_OnPlayerStateChange","iii",playerid, newstate, oldstate);
}

#define GetPlayerMoney JB_GetPlayerMoney
#define ResetPlayerMoney JB_ResetPlayerMoney
#define GivePlayerMoney JB_GivePlayerMoney
#define PutPlayerInVehicle JB_PutPlayerInVehicle
#define GivePlayerWeapon JB_GivePlayerWeapon
#define SetPlayerPos JB_SetPlayerPos
#define SetVehiclePos JB_SetVehiclePos
#define SetPlayerHealth JB_SetPlayerHealth
#define SetPlayerArmour JB_SetPlayerArmour
#define TogglePlayerControllable JB_TogglePlayerControllable

//Plug & Play:
#define OnPlayerStateChange PnP_OnPlayerStateChange
#define OnPlayerEnterVehicle PnP_OnPlayerEnterVehicle
#define OnPlayerCommandText PnP_OnPlayerCommandText
#define OnPlayerPrivmsg PnP_OnPlayerPrivmsg
#define OnPlayerText PnP_OnPlayerText
#define OnPlayerConnect PnP_OnPlayerConnect
#define OnPlayerDisconnect PnP_OnPlayerDisconnect
#define OnGameModeInit PnP_OnGameModeInit
#define OnGameModeExit PnP_OnGameModeExit
#define OnPlayerInteriorChange PnP_OnPlayerInteriorChange
#define OnPlayerDeath PnP_OnPlayerDeath
#define OnPlayerSpawn PnP_OnPlayerSpawn