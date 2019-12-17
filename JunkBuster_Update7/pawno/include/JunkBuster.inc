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
¦ in the folder "scriptfiles". Use "/jbcfg" ingame if you are           ¦
¦ (rcon)admin to update the configuration.                              ¦
¦ Define in "BadWords.cfg" the forbidden words, define in               ¦
¦ "ForbiddenWeapons.cfg" to forbidden weapons.                          ¦
¦                                                                       ¦
¦ I call this script a 'Plug & Play'-script! Why? In this version       ¦
¦ You only need to include the script and compile your gamemode.        ¦
¦ Everything important is done by the script itself. You DON'T need to  ¦
¦ change anything! (Except for some functions when they are already     ¦
¦ defined.                                                              ¦
¦                                                                       ¦
¦ This script has been made by Double-O-Seven! You are NOT allowed to:  ¦
¦ - Remove this text                                                    ¦
¦ - Rename the name "JunkBuster"! Never!                                ¦
¦ - Re-release this script                                              ¦
¦ - Say it's your own script                                            ¦
¦ - DO NOT remove the "JunkBuster:" tag from client messages!           ¦
¦                                                                       ¦
¦ But you are allowed to add more functions and use it on your server.  ¦
¦                                                                       ¦
¦ Thanks to DracoBlue for DUtils and ~Cueball~ for his zone include.    ¦
¦ Also Thanks to ZeeX for ZCMD and Y_Less for sscanf function.          ¦
+-----------------------------------------------------------------------+
*/

#if defined _JB_included
	#endinput
#endif
#define _JB_included

//==============================================================================

#include <a_samp>
#include <Double-O-Files>
#include <zcmd>

//==============================================================================

#define CONFIG_FILE 			"JunkBuster/JunkBuster.cfg"
#define BAD_WORDS_FILE 			"JunkBuster/BadWords.cfg"
#define FORBIDDEN_WEAPONS_FILE 	"JunkBuster/ForbiddenWeapons.cfg"
#define JB_LOG_FILE 			"JunkBuster/JunkBuster.log"
#define BLACKLIST_FILE 			"JunkBuster/Blacklist.txt"
#define WHITELIST_FILE 			"JunkBuster/Whitelist.txt"
#define IP_BAN_FILE 			"JunkBuster/IpBans.txt"
#define TEMP_BAN_FILE 			"JunkBuster/TempBans.txt"
#define BAD_RCON_LOGIN_FILE 	"JunkBuster/BadRconLogin.txt"

#define MAX_JB_VARIABLES 		(34)
#define MAX_BAD_WORDS 			(100)
#define MAX_FORBIDDEN_WEAPONS 	(20)
#define MAX_PING_CHECKS 		(3)
#define MAX_WEAPONS 			(47)
#define MAX_CHECKS 				(3)
#define MAX_JB_BANS 			(100)
#define MAX_FPS_INDEX 			(3)

#define WEAPON_HACK 			(0)
#define MONEY_HACK 				(1)
#define JETPACK 				(2)
#define HEALTH_HACK 			(3)
#define ARMOUR_HACK 			(4)
#define DRIVE_BY 				(5)
#define SPAM 					(6)
#define COMMAND_SPAM 			(7)
#define BAD_WORDS 				(8)
#define CAR_JACK_HACK 			(9)
#define TELEPORT_HACK 			(10)
#define MAX_PING 				(11)
#define SPECTATE_HACK 			(12)
#define BLACKLIST 				(13)
#define IP_BANS 				(14)
#define TEMP_BANS 				(15)
#define SPAWNKILL 				(16)
#define CAPS_LOCK 				(17)
#define SPEED_3D 				(18)
#define MAX_SPEED 				(19)
#define ADMIN_IMMUNITY 			(20)
#define ADVERTISEMENT 			(21)
#define FREEZE_UPDATE 			(22)
#define SPAWN_TIME 				(23)
#define CHECKPOINT_TELEPORT 	(24)
#define AIRBREAK 				(25)
#define TANK_MODE 				(26)
#define WARN_PLAYERS 			(27)
#define SINGLEPLAYER_CHEATS 	(28)
#define MIN_FPS 				(29)
#define DISABLE_BAD_WEAPONS 	(30)
#define CBUG 					(31)
#define ANTI_BUG_KILL           (32)
#define NO_RELOAD                (33)

#define JB_RED 					(0xFF0000FF)
#define JB_GREEN 				(0x00FF00FF)
#define JB_GREEN_BLUE 			(0x00D799FF)

#define DIALOG_CMDS 			(28353)
#define DIALOG_CFG 				(28354)
#define DIALOG_VARLIST 			(28355)
#define DIALOG_SETVAR 			(28356)

new FALSE=false;
new TRUE=true;
#pragma unused TRUE

#define JB_SendFormattedMessage(%0,%1,%2,%3) 	do{new _string[128]; format(_string,sizeof(_string),%2,%3); SendClientMessage(%0,%1,_string);} while(FALSE)
#define JB_SendFormattedMessageToAll(%0,%1,%2) 	do{new _string[128]; format(_string,sizeof(_string),%1,%2); SendClientMessageToAll(%0,_string);} while(FALSE)
#define JB_LogEx(%0,%1) 						do{new _string[256]; format(_string,sizeof(_string),%0,%1); JB_Log(_string);} while(FALSE)
#define JB_Speed(%0,%1,%2,%3,%4) 				floatround(floatsqroot(%4?(%0*%0+%1*%1+%2*%2):(%0*%0+%1*%1))*%3*1.6)

#define ForEachPlayer(%0) 		for(new index_%0=0, %0=ConnectedPlayerList[0]; index_%0<ConnectedPlayers; index_%0++, %0=ConnectedPlayerList[index_%0])
#define GetConnectedPlayers() 	(ConnectedPlayers)

#define Public:%0(%1) 	forward %0(%1); \
						public %0(%1)
						
#if !defined isnull
	#define isnull(%1) \
				((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

//==============================================================================

//For ZCMD & others
static
	bool:JB_g_HasJBOPCS = false,
	bool:JB_g_HasJBOPCE = false,
	bool:JB_g_HasJBOPU = false,
	bool:JB_g_HasJBOPT = false;

new ConnectedPlayers;
new ConnectedPlayerList[MAX_PLAYERS+1];//Loop would bug when server is full D: (Without +1)

static JB_Warnings[MAX_PLAYERS][MAX_JB_VARIABLES];
static JB_Variables[MAX_JB_VARIABLES]=
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
	230,//MaxSpeed
	true,//AdminImmunity
	false,//Advertisement
	false,//FreezeUpdate
	10,//SpawnTime
	true,//CheckpointTeleport
	true,//Airbreak
	true,//TankMode
	false,//WarnPlayers
	true,//SingleplayerCheats
	20,//MinFPS
	true,//DisableBadWeapons
	16,//CBug
	true,//AntiBugKill
	20//NoReload
};

static const JB_VariableNames[MAX_JB_VARIABLES][32]=
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
	"SpawnTime",
	"CheckpointTeleport",
	"Airbreak",
	"TankMode",
	"WarnPlayers",
	"SingleplayerCheats",
	"MinFPS",
	"DisableBadWeapons",
	"CBug",
	"AntiBugKill",
	"NoReload"
};

static const JB_VarDescription[MAX_JB_VARIABLES][512]=
{
	"If enabled JunkBuster will ban for forbidden weapons.\nSet to 0 to disable, set to 1 to enable.",//WeaponHack
	"Enable to manage to players money serverside. Cheating money will be impossible.\nBut gambling for money or stunt bonus, too.\nSet to 0 to disable, set to 1 to enable.",//MoneyHack
	"If enabled JunkBuster will ban for jetpacks.",//Jetpack
	"If enabled JunkBuster will ban players who's health value is higher than 100.\nSet to 0 to disable, set to 1 to enable.",//HealthHack
	"If enabled JunkBuster will ban players who's armour value is higher than 100.\nSet to 0 to disable, set to 1 to enable.",//ArmourHack
	"Enable to forbid forbid drive-by. JunkBuster will kill drive-byers.\nSet to 0 to disable, set to 1 to enable.",//DriveBy
	"Will mute, kick or ban for chat spam.\nSet to 0 to disable, set to 1 to enable.",//Spam
	"Will kick or ban for command spam.\nSet to 0 to disable, set to 1 to enable.",//CommandSpam
	"Enable to block bad words like 'motherfucker'.\nSet to 0 to disable, set to 1 to enable.",//BadWords
	"Enable to prevent carjacks performed with hacks.\nSet to 0 to disable, set to 1 to enable.",//CarJackHack
	"Enable to prevent teleport with cheat tools.\nSet to 0 to disable, set to 1 to enable.",//TeleportHack
	"Set max ping. JunkBuster will calculate average ping for players and kick them if their ping is higher.\n Set to 0 to disable.\nIf you want to enable it, it's recommended to set higher than 300.",//MaxPing
	"Enable to ban for illegal spectating with cheat tools.\nSet to 0 to disable, set to 1 to enable.",//SpectateHack
	"Enable the blacklist. Players with blacklisted names will get banned when connecting.\nSet to 0 to disable, set to 1 to enable.",//Blacklist
	"Alternative to the native IP ban system.\nYou can make exceptions for some players by adding them to the whitelist.\nIf their IP is banned they still can play if they are on whitelist.\nYou can rangeban players without banning every player with the banned IP.\nSet to 0 to disable, set to 1 to enable.",//IpBans
	"Enable temporary bans.\nSet to 0 to disable, set to 1 to enable.",//TempBans
	"Prevent players from spawnkilling other players.\nSet to 0 to disable.\nHigher then 0 will define how many spawnkill warnings a player will get before he will get kicked.",//SpawnKill
	"Block capslock.\nSet to 0 to disable, set to 1 to enable.",//CapsLock
	"Calculate speed with 3 dimensions (x,y,z) or only in 2 (x,y) if disabled.\nIt's recommended to disable this function.",//3DSpeed
	"Set the max speed in KM/H. It's used for anti speedhack.\nSet to 0 to disable anti speedhack.\nIt's recommended to set higher than 200.",//MaxSpeed
	"If enabled admins wont get checked for any cheats and are immune to anything. (Anti spam, max ping, ...)\nSet to 0 to disable, set to 1 to enable.\nIt's recommended to enable.",//AdminImmunity
	"Block advertisement.\nSet to 0 to disable, set to 1 to enable.",//Advertisement
	"Manage if player is freezed or not with JunkBuster.",//FreezeUpdate
	"Defines how long in seconds a player will be spawnkill protected after spawning.\nSet a value of your choice.",//SpawnTime
	"Enable anti-racecheckpointteleport. Pretty useful for racing servers.\nCan cause problems when setting checkpoint at the players position.\nSet to 0 to disable, set to 1 to enable.",//CheckpointTeleport
	"Enable to prevent airbreak.\nSet to 0 to disable, set to 1 to enable.",//Airbreak
	"Ban players for using tank mode on vehicles.\nSet to 0 to disable, set to 1 to enable.",//TankMode
	"Warn players when connecting.\nThey will recieve a message that they should not cheat.\nSet to 0 to disable, set to 1 to enable.",//WarnPlayers
	"Enable to kick players who are trying to use singleplayer cheats.\nSet to 0 to disable, set to 1 to enable.",//SingleplayerCheats
	"Kick players with a lower FPS than required!\nSet to 0 to disable the FPS check, set higher to set the minimum FPS.",//MinFPS
	"Enable to disable cameras and goggles.\nSet to 1 to disable, set to 0 to enable.",//DisableBadWeapons
	"Enable to prevent the use of the C-Bug.\nSet to 1 to enable, set to 0 to enable.",//CBug
	"Enable this to kill a player to prevent some bugs caused by lag.\nSet to 1 to enable, set to 0 to enable.",//AntiBugKill
	"Set to 0 to disable, set to 1 to only enable warnings for admins,\nset higher than 1 to enable auto-kick."//NoReload
};

enum JB_pInfo
{
	JB_pMoney,
	JB_pLastMessage[128],
	JB_pMessageRepeated,
	JB_pMessages,
	JB_pCommands,
	JB_pMuted,
	JB_pFreezed,
	JB_pPing[MAX_PING_CHECKS],
	JB_pPingCheckProgress,
	JB_pVehicleEntered,
	JB_pSpawnKillProtected,
	JB_pSpeedhacking,
	JB_pAirbreaking,
	JB_pLastCheck,
	JB_pLastDrunkLevel,
	JB_pFPS[MAX_FPS_INDEX],
	JB_pFPSIndex,
	JB_pFired,
	Float:JB_pSetPos[3],
	Float:JB_pCurrentPos[3],
	JB_pNoTeleportCheck,
	JB_pKickBan,
	JB_pFullyConnected,
	JB_pWeaponForbidden[MAX_WEAPONS],
	JB_pAntiBugKilled,
	JB_pAmmoUsed[MAX_WEAPONS],
	JB_pOldAmmo[MAX_WEAPONS],
	JB_pLastWeaponUsed[MAX_WEAPONS],
	JB_pOldWeapon
}
static JB_PlayerInfo[MAX_PLAYERS][JB_pInfo];

static const AmmoAmount[MAX_WEAPONS]=
{
	4999,//Fist 0
	4999,//Brass Knuckles 1
	4999,//Golf Club 2
	4999,//Nite Stick 3
	4999,//Knife 4
	4999,//Baseball Bat 5
	4999,//Shovel 6
	4999,//Pool Cue 7
	4999,//Katana 8
	4999,//Chainsaw 9
	4999,//Dildo 10
	4999,//Vibrator 11
	4999,//Vibrator 12
	4999,//Dildo 13
	4999,//Flowers 14
	4999,//Cane 15
	4999,//Grenade 16
	4999,//Tear Gas 17
	4999,//Molotov Cocktail 18
	0,//19
	0,//20
	0,//21
	34,//9mm 22
	17,//Silenced 9mm 23
	7,//Deagle 24
	4999,//Shotgun 25
	4,//Sawnoff 26
	7,//SPAS 12 27
	100,//Micro UZI 28
	30,//MP5 29
	30,//AK47 30
	30,//M4 31
	100,//Tec9 32
	4999,//Country Rifle 33
	4999,//Sniper Rifle 34
	4999,//Rocket Laucnher 35
	4999,//Heatseeker 36
	100,//Flamethrower 37
	500,//Minigun 38
	4999,//Satchel Charge 39
	4999,//Detonator40
	1000,//Spray Can 41
	500,//Fire Extinguisher 42
	4999,//Camera43
	4999,//Nightvision Goggles 44
	4999,//Thermal Goggles 45
	4999//Parachute 46
	
};

static BadWords[MAX_BAD_WORDS][32];
static BadWordsCount;
static ForbiddenWeapons[MAX_FORBIDDEN_WEAPONS];
static ForbiddenWeaponsCount;

static Blacklist[MAX_JB_BANS][MAX_PLAYER_NAME];
static Whitelist[MAX_JB_BANS][MAX_PLAYER_NAME];
static IpBans[MAX_JB_BANS][4];
static IpBanned[MAX_JB_BANS];
enum tbInfo
{
	tbName[MAX_PLAYER_NAME],
	tbIp[16],
	tbTime
}
static TempBanInfo[250][tbInfo];

static const JB_Planes[]=
{
    413,417,425,447,460,469,476,487,488,497,511,512,513,519,520,548,553,563,577,592,593
};

static const JB_VehicleNames[][] =
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
   "Monster Truck A",
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
   "Monster Truck B",
   "Monster Truck C",
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


/*These coordinates are taken from m0d_n00beit.
Yes, I'm always testing the newest versions. You can't create a useful
anti-cheat which detects many cheats, if you don't check out the cheat tools.
Fuck those suckers. If someone teleports there, he MUST be a cheater
and JunkBuster will ban him.
*/
static const Float:CheatPositions[][3]=
{
	{-1935.77, 228.79, 34.16},//Transfender near Wang Cars in Doherty
	{-2707.48, 218.65, 4.93},//Wheel Archangels in Ocean Flats
	{2645.61,-2029.15,14.28},//LowRider Tuning Garage in Willowfield
	{1041.26,-1036.77,32.48},//Transfender in Temple
	{2387.55,1035.70,11.56},//Transfender in come-a-lot
	{1836.93,-1856.28,14.13},//Eight Ball Autos near El Corona
	{2006.11,2292.87,11.57},//Welding Wedding Bomb-workshop in Emerald Isle
	{-1787.25,1202.00,25.84},//Michelles Pay 'n' Spray in Downtown
	{720.10,-470.93,17.07},//Pay 'n' Spray in Dillimore
	{-1420.21,2599.45,56.43},//Pay 'n' Spray in El Quebrados
	{-100.16,1100.79,20.34},//Pay 'n' Spray in Fort Carson
	{2078.44,-1831.44,14.13},//Pay 'n' Spray in Idlewood
	{-2426.89,1036.61,51.14},//Pay 'n' Spray in Juniper Hollow
	{1957.96,2161.96,11.56},//Pay 'n' Spray in Redsands East
	{488.29,-1724.85,12.01},//Pay 'n' Spray in Santa Maria Beach
	{1025.08,-1037.28,32.28},//Pay 'n' Spray in Temple
	{2393.70,1472.80,11.42},//Pay 'n' Spray near Royal Casino
	{-1904.97,268.51,41.04},//Pay 'n' Spray near Wang Cars in Doherty
	{403.58,2486.33,17.23},//Player Garage: Verdant Meadows
	{1578.24,1245.20,11.57},//Player Garage: Las Venturas Airport
	{-2105.79,905.11,77.07},//Player Garage: Calton Heights
	{423.69,2545.99,17.07},//Player Garage: Derdant Meadows
	{785.79,-513.12,17.44},//Player Garage: Dillimore
	{-2027.34,141.02,29.57},//Player Garage: Doherty
	{1698.10,-2095.88,14.29},//Player Garage: El Corona
	{-361.10,1185.23,20.49},//Player Garage: Fort Carson
	{-2463.27,-124.86,26.41},//Player Garage: Hashbury
	{2505.64,-1683.72,14.25},//Player Garage: Johnson House
	{1350.76,-615.56,109.88},//Player Garage: Mulholland
	{2231.64,156.93,27.63},//Player Garage: Palomino Creek
	{-2695.51,810.70,50.57},//Player Garage: Paradiso
	{1293.61,2529.54,11.42},//Player Garage: Prickle Pine
	{1401.34,1903.08,11.99},//Player Garage: Redland West
	{2436.50,698.43,11.60},//Player Garage: Rockshore West
	{322.65,-1780.30,5.55},//Player Garage: Santa Maria Beach
	{917.46,2012.14,11.65},//Player Garage: Whitewood Estates
	{1641.14,-1526.87,14.30},//Commerce Region Loading Bay
	{-1617.58,688.69,-4.50},//San Fierro Police Garage
	{837.05,-1101.93,23.98},//Los Santos Cemetery
	{2338.32, -1180.61, 1027.98},//Interior: Burning Desire House
	{-975.5766, 1061.1312, 1345.6719},//Interior: RC Zero's Battlefield
	{-750.80, 491.00, 1371.70},//Interior: Liberty City
	{-1400.2138, 106.8926, 1032.2779},//Interior: Unknown Stadium
	{-2015.6638, 147.2069, 29.3127},//Interior: Secret San Fierro Chunk
	{2220.26, -1148.01, 1025.80},//Interior: Jefferson Motel
	{-2660.6185, 1426.8320, 907.3626},//Interior: Jizzy's Pleasure Dome
	{-1394.20, 987.62, 1023.96},//Stadium: Bloodbowl
	{-1410.72, 1591.16, 1052.53},//Stadium: Kickstart
	{-1417.8720, -276.4260, 1051.1910},//Stadium: 8-Track Stadium
	{-25.8844, -185.8689, 1003.5499},//24/7 Store: Big - L-Shaped
	{6.0911, -29.2718, 1003.5499},//24/7 Store: Big - Oblong
	{-30.9469, -89.6095, 1003.5499},//24/7 Store: Med - Square
	{-25.1329, -139.0669, 1003.5499},//24/7 Store: Med - Square
	{-27.3123, -29.2775, 1003.5499},//24/7 Store: Sml - Long
	{-26.6915, -55.7148, 1003.5499},//24/7 Store: Sml - Square
	{-1827.1473, 7.2074, 1061.1435},//Airport: Ticket Sales
	{-1855.5687, 41.2631, 1061.1435},//Airport: Baggage Claim
	{2.3848, 33.1033, 1199.8499},//Airplane: Shamal Cabin
	{315.8561, 1024.4964, 1949.7973},//Airplane: Andromada Cargo hold
	//Positions give to me by SureShot :O
 	{-2057.8000,229.9000,35.6204}, // San Fierro
 	{-2366.0000,-1667.4000,484.1011}, // Mount Chiliad
 	{2503.7000,-1705.8000,13.5480}, // Grove Street
 	{1997.9000,1056.3000,10.8203}, // Las Venturas
 	{-2872.7000,2712.6001,275.2690}, // BaySide
 	{904.1000,608.0000,-32.3281}, // Unterwasser
 	{-236.9000,2663.8000,73.6513} // The big Cock
};

static const SingleplayerCheats[][]=
{
    "BAGUVIX", //Unbegrenzt viel Gesundheit
	"HESOYAM", //Gesundheit, Schutzweste, $250.000
	"WANRLTW", //Unbegrenzt viel Munition, kein Nachladen
	"NCSGDAG", //Bei allen Waffen im Level Hitman
	"OUIQDMW", //Während des Fahrens volle Zielfähigkeiten
	"LXGIWYL", //Waffen-Set 1 (Schurken-Werkzeuge)
	"KJKSZPJ", //Waffen-Set 2 (Professionelle Werkzeuge)
	"UZUMYMW", //Waffen-Set 3 (Nutter-Werkzeuge)
	"ROCKETMAN", //Jetpack
	"AIYPWZQP", //Fallschirm
	"OSRBLHH", //Wanted-Level um zwei Sterne erhöhen
	"ASNAEB", //Wanted-Level löschen
	"LJSPQK", //Wanted-Level auf sechs Sterne
	"AEZAKMI", //Niemals auf der Fahndungsliste
	"MUNASEF", //Adrenalin-Modus
	"KANGAROO", //Mega-Sprung
	"IAVENJQ", //Mega-Punch
	"AEDUWNV", //Niemals hungrig werden
	"CVWKXAM", //Unbegrenzt viel Sauerstoff
	//"BTCDBCB", //Dick
	//"KVGYZQK", //Dünn
	//"JYSDSOD", //Maximale Muskeln
	//"OGXSDAG", //Maximaler Respekt
	//"EHIBXQS", //Maximaler Sexappeal
	//"MROEMZH", //Gang-Mitglieder sind überall
	//"BIFBUZZ", //Gangs kontrollieren die Straße
	"AIWPRTON", //Rhino
	"CQZIJMB", //Bloodring Banger
	"JQNTDMH", //Rancher
	"PDNEJOH", //Rennwagen
	"VPJTQWV", //Rennwagen 2
	"AQTBCODX", //Romero
	"KRIJEBR", //Stretch
	"UBHYZHQ", //Trashmaster
	"RZHSUEW", //Caddy
	"JUMPJET", //Hydra
	"KGGGDKP", //Vortex Hovercraft
	"OHDUDE", //Hunter
	"AKJJYGLC", //Quad
	"AMOMHRER", //Tanker Truck
	"EEGCYXT", //Dozer
	"URKQSRK", //Stunt Plane
	"AGBDLCID", //Monster
	"CPKTNWT", //Alle Autos sprengen
	"XICWMD", //Unsichtbares Auto
	"PGGOMOY", //Perfektes Handling
	//"ZEIIVG", //Alle Ampeln grün
	//"YLTEICZ", //Aggressive Fahrer
	//"LLQPFBN", //Pink Verkehr
	//"IOWDLAC", //Schwarzer Verkehr
	"AFSNMSMW", //Boote fliegen
	//"BGKGTJH", //Verkehr mit billigen Autos
	//"GUSNHDE", //Verkehr mit schnellen Autos
	"RIPAZHA", //Autos fliegen
	"JHJOECW", //Großer Hasensprung
	"JCNRUAD", //Smash 'n' Boom
	"COXEFGU", //Alle Autos sind mit Nitro betankt
	"BSXSGGC", //Autos rutschen bei Berührung weg
	//"THGLOJ", //Wenig Verkehr
	//"FVTMNBZ", //Verkehr nur mit landwirtschaftlichen Fahrzeugen
	"VKYPQCF", //Taxis sind mit Nitro betankt
	"VQIMAHA", //Alle Autos auf maximalen Statistiken
	//"AJLOJYQY", //Fußgänger greifen sich gegenseitig an, Golf Club verfügbar
	//"BAGOWPG", //Kopfgeld ist auf dich ausgesetzt
	//"FOOOXFT", //Jeder ist bewaffnet
	"SZCMAWO", //Selbstmord
	//"BLUESUEDESHOES", // Überall erscheint Elvis
	//"BGLUAWML", //Fußgänger greifen dich an, Raketenwerfer verfügbar
	//"CIKGCGX", //Beach Party
	//"AFPHULTL", //Ninja Theme
	//"BEKKNQV", //Slut Magnet :P
	//"IOJUFZN", //Riot-Modus
	//"PRIEBJ", //Funhouse Theme
	//"SJMAHPE", //Rekrutiere jeden (9mm)
	//"BMTPWHR", //Landwitschaftsfahrzeuge und -fußgänger, Trucker-Outfit
	//"ZSOXFSQ", //Rekrutiere jeden (Raketen)
	//"AFZLLQLL", //Sonnig
	//"ICIKPYH", //Sehr sonnig
	//"ALNSFMZO", //Bewölkt
	//"AUIFRVQS", //Regnerisch
	//"CFVFGMJ", //Nebelig
	//"MGHXYRM", //Donner
	//"CWJXUOC", //Sandsturm
	"YSOHNUL", //Uhr läuft schneller
	"PPGWJHT", //Gameplay läuft schneller
	"LIYOAAY", //Gameplay läuft langsamer
	"XJVSNAJ", //Immer Mitternacht
	//"OFVIAC", //Rötlicher Himmel 21:00 Uhr
	"BOOOOORING", //Zeitlupen-Modus
	"Onspeed", //Zeitraffer-Modus
	"ASPIRINE", //Health-Cheat
	"LEAVEMEALONE", //Fahndungslevel-Cheat (löschen)
	"NUTTERTOOLS", //Waffen-Cheats(schwer)
	"PROFESSIONALTOOLS", //Waffen-Cheats(mittel)
	"Thugstool", //Waffen-Cheat(leicht)
	"YOUWONTTAKEMEALIVE", //Fahndungslevel-Cheat(erhöhen)
	"ICANTTAKEITANYMORE" //Selbstmord
};

//From Cueball's "Zones By ~Cueball~ - V 2.0" (added JB_ tag so there should no redefinitions exist when compiling)
enum JB_SAZONE_MAIN { //Betamaster
		JB_SAZONE_NAME[28],
		Float:JB_SAZONE_AREA[6]
};

static const JB_gSAZones[][JB_SAZONE_MAIN] = {  // Majority of names and area coordinates adopted from Mabako's 'Zones Script' v0.2
	//	NAME                            AREA (Xmin,Ymin,Zmin,Xmax,Ymax,Zmax)
	{"The Big Ear",	                {-410.00,1403.30,-3.00,-137.90,1681.20,200.00}},
	{"Aldea Malvada",               {-1372.10,2498.50,0.00,-1277.50,2615.30,200.00}},
	{"Angel Pine",                  {-2324.90,-2584.20,-6.10,-1964.20,-2212.10,200.00}},
	{"Arco del Oeste",              {-901.10,2221.80,0.00,-592.00,2571.90,200.00}},
	{"Avispa Country Club",         {-2646.40,-355.40,0.00,-2270.00,-222.50,200.00}},
	{"Avispa Country Club",         {-2831.80,-430.20,-6.10,-2646.40,-222.50,200.00}},
	{"Avispa Country Club",         {-2361.50,-417.10,0.00,-2270.00,-355.40,200.00}},
	{"Avispa Country Club",         {-2667.80,-302.10,-28.80,-2646.40,-262.30,71.10}},
	{"Avispa Country Club",         {-2470.00,-355.40,0.00,-2270.00,-318.40,46.10}},
	{"Avispa Country Club",         {-2550.00,-355.40,0.00,-2470.00,-318.40,39.70}},
	{"Back o Beyond",               {-1166.90,-2641.10,0.00,-321.70,-1856.00,200.00}},
	{"Battery Point",               {-2741.00,1268.40,-4.50,-2533.00,1490.40,200.00}},
	{"Bayside",                     {-2741.00,2175.10,0.00,-2353.10,2722.70,200.00}},
	{"Bayside Marina",              {-2353.10,2275.70,0.00,-2153.10,2475.70,200.00}},
	{"Beacon Hill",                 {-399.60,-1075.50,-1.40,-319.00,-977.50,198.50}},
	{"Blackfield",                  {964.30,1203.20,-89.00,1197.30,1403.20,110.90}},
	{"Blackfield",                  {964.30,1403.20,-89.00,1197.30,1726.20,110.90}},
	{"Blackfield Chapel",           {1375.60,596.30,-89.00,1558.00,823.20,110.90}},
	{"Blackfield Chapel",           {1325.60,596.30,-89.00,1375.60,795.00,110.90}},
	{"Blackfield Intersection",     {1197.30,1044.60,-89.00,1277.00,1163.30,110.90}},
	{"Blackfield Intersection",     {1166.50,795.00,-89.00,1375.60,1044.60,110.90}},
	{"Blackfield Intersection",     {1277.00,1044.60,-89.00,1315.30,1087.60,110.90}},
	{"Blackfield Intersection",     {1375.60,823.20,-89.00,1457.30,919.40,110.90}},
	{"Blueberry",                   {104.50,-220.10,2.30,349.60,152.20,200.00}},
	{"Blueberry",                   {19.60,-404.10,3.80,349.60,-220.10,200.00}},
	{"Blueberry Acres",             {-319.60,-220.10,0.00,104.50,293.30,200.00}},
	{"Caligula's Palace",           {2087.30,1543.20,-89.00,2437.30,1703.20,110.90}},
	{"Caligula's Palace",           {2137.40,1703.20,-89.00,2437.30,1783.20,110.90}},
	{"Calton Heights",              {-2274.10,744.10,-6.10,-1982.30,1358.90,200.00}},
	{"Chinatown",                   {-2274.10,578.30,-7.60,-2078.60,744.10,200.00}},
	{"City Hall",                   {-2867.80,277.40,-9.10,-2593.40,458.40,200.00}},
	{"Come-A-Lot",                  {2087.30,943.20,-89.00,2623.10,1203.20,110.90}},
	{"Commerce",                    {1323.90,-1842.20,-89.00,1701.90,-1722.20,110.90}},
	{"Commerce",                    {1323.90,-1722.20,-89.00,1440.90,-1577.50,110.90}},
	{"Commerce",                    {1370.80,-1577.50,-89.00,1463.90,-1384.90,110.90}},
	{"Commerce",                    {1463.90,-1577.50,-89.00,1667.90,-1430.80,110.90}},
	{"Commerce",                    {1583.50,-1722.20,-89.00,1758.90,-1577.50,110.90}},
	{"Commerce",                    {1667.90,-1577.50,-89.00,1812.60,-1430.80,110.90}},
	{"Conference Center",           {1046.10,-1804.20,-89.00,1323.90,-1722.20,110.90}},
	{"Conference Center",           {1073.20,-1842.20,-89.00,1323.90,-1804.20,110.90}},
	{"Cranberry Station",           {-2007.80,56.30,0.00,-1922.00,224.70,100.00}},
	{"Creek",                       {2749.90,1937.20,-89.00,2921.60,2669.70,110.90}},
	{"Dillimore",                   {580.70,-674.80,-9.50,861.00,-404.70,200.00}},
	{"Doherty",                     {-2270.00,-324.10,-0.00,-1794.90,-222.50,200.00}},
	{"Doherty",                     {-2173.00,-222.50,-0.00,-1794.90,265.20,200.00}},
	{"Downtown",                    {-1982.30,744.10,-6.10,-1871.70,1274.20,200.00}},
	{"Downtown",                    {-1871.70,1176.40,-4.50,-1620.30,1274.20,200.00}},
	{"Downtown",                    {-1700.00,744.20,-6.10,-1580.00,1176.50,200.00}},
	{"Downtown",                    {-1580.00,744.20,-6.10,-1499.80,1025.90,200.00}},
	{"Downtown",                    {-2078.60,578.30,-7.60,-1499.80,744.20,200.00}},
	{"Downtown",                    {-1993.20,265.20,-9.10,-1794.90,578.30,200.00}},
	{"Downtown Los Santos",         {1463.90,-1430.80,-89.00,1724.70,-1290.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1430.80,-89.00,1812.60,-1250.90,110.90}},
	{"Downtown Los Santos",         {1463.90,-1290.80,-89.00,1724.70,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1384.90,-89.00,1463.90,-1170.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1250.90,-89.00,1812.60,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1170.80,-89.00,1463.90,-1130.80,110.90}},
	{"Downtown Los Santos",         {1378.30,-1130.80,-89.00,1463.90,-1026.30,110.90}},
	{"Downtown Los Santos",         {1391.00,-1026.30,-89.00,1463.90,-926.90,110.90}},
	{"Downtown Los Santos",         {1507.50,-1385.20,110.90,1582.50,-1325.30,335.90}},
	{"East Beach",                  {2632.80,-1852.80,-89.00,2959.30,-1668.10,110.90}},
	{"East Beach",                  {2632.80,-1668.10,-89.00,2747.70,-1393.40,110.90}},
	{"East Beach",                  {2747.70,-1668.10,-89.00,2959.30,-1498.60,110.90}},
	{"East Beach",                  {2747.70,-1498.60,-89.00,2959.30,-1120.00,110.90}},
	{"East Los Santos",             {2421.00,-1628.50,-89.00,2632.80,-1454.30,110.90}},
	{"East Los Santos",             {2222.50,-1628.50,-89.00,2421.00,-1494.00,110.90}},
	{"East Los Santos",             {2266.20,-1494.00,-89.00,2381.60,-1372.00,110.90}},
	{"East Los Santos",             {2381.60,-1494.00,-89.00,2421.00,-1454.30,110.90}},
	{"East Los Santos",             {2281.40,-1372.00,-89.00,2381.60,-1135.00,110.90}},
	{"East Los Santos",             {2381.60,-1454.30,-89.00,2462.10,-1135.00,110.90}},
	{"East Los Santos",             {2462.10,-1454.30,-89.00,2581.70,-1135.00,110.90}},
	{"Easter Basin",                {-1794.90,249.90,-9.10,-1242.90,578.30,200.00}},
	{"Easter Basin",                {-1794.90,-50.00,-0.00,-1499.80,249.90,200.00}},
	{"Easter Bay Airport",          {-1499.80,-50.00,-0.00,-1242.90,249.90,200.00}},
	{"Easter Bay Airport",          {-1794.90,-730.10,-3.00,-1213.90,-50.00,200.00}},
	{"Easter Bay Airport",          {-1213.90,-730.10,0.00,-1132.80,-50.00,200.00}},
	{"Easter Bay Airport",          {-1242.90,-50.00,0.00,-1213.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1213.90,-50.00,-4.50,-947.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1315.40,-405.30,15.40,-1264.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1354.30,-287.30,15.40,-1315.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1490.30,-209.50,15.40,-1264.40,-148.30,25.40}},
	{"Easter Bay Chemicals",        {-1132.80,-768.00,0.00,-956.40,-578.10,200.00}},
	{"Easter Bay Chemicals",        {-1132.80,-787.30,0.00,-956.40,-768.00,200.00}},
	{"El Castillo del Diablo",      {-464.50,2217.60,0.00,-208.50,2580.30,200.00}},
	{"El Castillo del Diablo",      {-208.50,2123.00,-7.60,114.00,2337.10,200.00}},
	{"El Castillo del Diablo",      {-208.50,2337.10,0.00,8.40,2487.10,200.00}},
	{"El Corona",                   {1812.60,-2179.20,-89.00,1970.60,-1852.80,110.90}},
	{"El Corona",                   {1692.60,-2179.20,-89.00,1812.60,-1842.20,110.90}},
	{"El Quebrados",                {-1645.20,2498.50,0.00,-1372.10,2777.80,200.00}},
	{"Esplanade East",              {-1620.30,1176.50,-4.50,-1580.00,1274.20,200.00}},
	{"Esplanade East",              {-1580.00,1025.90,-6.10,-1499.80,1274.20,200.00}},
	{"Esplanade East",              {-1499.80,578.30,-79.60,-1339.80,1274.20,20.30}},
	{"Esplanade North",             {-2533.00,1358.90,-4.50,-1996.60,1501.20,200.00}},
	{"Esplanade North",             {-1996.60,1358.90,-4.50,-1524.20,1592.50,200.00}},
	{"Esplanade North",             {-1982.30,1274.20,-4.50,-1524.20,1358.90,200.00}},
	{"Fallen Tree",                 {-792.20,-698.50,-5.30,-452.40,-380.00,200.00}},
	{"Fallow Bridge",               {434.30,366.50,0.00,603.00,555.60,200.00}},
	{"Fern Ridge",                  {508.10,-139.20,0.00,1306.60,119.50,200.00}},
	{"Financial",                   {-1871.70,744.10,-6.10,-1701.30,1176.40,300.00}},
	{"Fisher's Lagoon",             {1916.90,-233.30,-100.00,2131.70,13.80,200.00}},
	{"Flint Intersection",          {-187.70,-1596.70,-89.00,17.00,-1276.60,110.90}},
	{"Flint Range",                 {-594.10,-1648.50,0.00,-187.70,-1276.60,200.00}},
	{"Fort Carson",                 {-376.20,826.30,-3.00,123.70,1220.40,200.00}},
	{"Foster Valley",               {-2270.00,-430.20,-0.00,-2178.60,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-599.80,-0.00,-1794.90,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-1115.50,0.00,-1794.90,-599.80,200.00}},
	{"Foster Valley",               {-2178.60,-1250.90,0.00,-1794.90,-1115.50,200.00}},
	{"Frederick Bridge",            {2759.20,296.50,0.00,2774.20,594.70,200.00}},
	{"Gant Bridge",                 {-2741.40,1659.60,-6.10,-2616.40,2175.10,200.00}},
	{"Gant Bridge",                 {-2741.00,1490.40,-6.10,-2616.40,1659.60,200.00}},
	{"Ganton",                      {2222.50,-1852.80,-89.00,2632.80,-1722.30,110.90}},
	{"Ganton",                      {2222.50,-1722.30,-89.00,2632.80,-1628.50,110.90}},
	{"Garcia",                      {-2411.20,-222.50,-0.00,-2173.00,265.20,200.00}},
	{"Garcia",                      {-2395.10,-222.50,-5.30,-2354.00,-204.70,200.00}},
	{"Garver Bridge",               {-1339.80,828.10,-89.00,-1213.90,1057.00,110.90}},
	{"Garver Bridge",               {-1213.90,950.00,-89.00,-1087.90,1178.90,110.90}},
	{"Garver Bridge",               {-1499.80,696.40,-179.60,-1339.80,925.30,20.30}},
	{"Glen Park",                   {1812.60,-1449.60,-89.00,1996.90,-1350.70,110.90}},
	{"Glen Park",                   {1812.60,-1100.80,-89.00,1994.30,-973.30,110.90}},
	{"Glen Park",                   {1812.60,-1350.70,-89.00,2056.80,-1100.80,110.90}},
	{"Green Palms",                 {176.50,1305.40,-3.00,338.60,1520.70,200.00}},
	{"Greenglass College",          {964.30,1044.60,-89.00,1197.30,1203.20,110.90}},
	{"Greenglass College",          {964.30,930.80,-89.00,1166.50,1044.60,110.90}},
	{"Hampton Barns",               {603.00,264.30,0.00,761.90,366.50,200.00}},
	{"Hankypanky Point",            {2576.90,62.10,0.00,2759.20,385.50,200.00}},
	{"Harry Gold Parkway",          {1777.30,863.20,-89.00,1817.30,2342.80,110.90}},
	{"Hashbury",                    {-2593.40,-222.50,-0.00,-2411.20,54.70,200.00}},
	{"Hilltop Farm",                {967.30,-450.30,-3.00,1176.70,-217.90,200.00}},
	{"Hunter Quarry",               {337.20,710.80,-115.20,860.50,1031.70,203.70}},
	{"Idlewood",                    {1812.60,-1852.80,-89.00,1971.60,-1742.30,110.90}},
	{"Idlewood",                    {1812.60,-1742.30,-89.00,1951.60,-1602.30,110.90}},
	{"Idlewood",                    {1951.60,-1742.30,-89.00,2124.60,-1602.30,110.90}},
	{"Idlewood",                    {1812.60,-1602.30,-89.00,2124.60,-1449.60,110.90}},
	{"Idlewood",                    {2124.60,-1742.30,-89.00,2222.50,-1494.00,110.90}},
	{"Idlewood",                    {1971.60,-1852.80,-89.00,2222.50,-1742.30,110.90}},
	{"Jefferson",                   {1996.90,-1449.60,-89.00,2056.80,-1350.70,110.90}},
	{"Jefferson",                   {2124.60,-1494.00,-89.00,2266.20,-1449.60,110.90}},
	{"Jefferson",                   {2056.80,-1372.00,-89.00,2281.40,-1210.70,110.90}},
	{"Jefferson",                   {2056.80,-1210.70,-89.00,2185.30,-1126.30,110.90}},
	{"Jefferson",                   {2185.30,-1210.70,-89.00,2281.40,-1154.50,110.90}},
	{"Jefferson",                   {2056.80,-1449.60,-89.00,2266.20,-1372.00,110.90}},
	{"Julius Thruway East",         {2623.10,943.20,-89.00,2749.90,1055.90,110.90}},
	{"Julius Thruway East",         {2685.10,1055.90,-89.00,2749.90,2626.50,110.90}},
	{"Julius Thruway East",         {2536.40,2442.50,-89.00,2685.10,2542.50,110.90}},
	{"Julius Thruway East",         {2625.10,2202.70,-89.00,2685.10,2442.50,110.90}},
	{"Julius Thruway North",        {2498.20,2542.50,-89.00,2685.10,2626.50,110.90}},
	{"Julius Thruway North",        {2237.40,2542.50,-89.00,2498.20,2663.10,110.90}},
	{"Julius Thruway North",        {2121.40,2508.20,-89.00,2237.40,2663.10,110.90}},
	{"Julius Thruway North",        {1938.80,2508.20,-89.00,2121.40,2624.20,110.90}},
	{"Julius Thruway North",        {1534.50,2433.20,-89.00,1848.40,2583.20,110.90}},
	{"Julius Thruway North",        {1848.40,2478.40,-89.00,1938.80,2553.40,110.90}},
	{"Julius Thruway North",        {1704.50,2342.80,-89.00,1848.40,2433.20,110.90}},
	{"Julius Thruway North",        {1377.30,2433.20,-89.00,1534.50,2507.20,110.90}},
	{"Julius Thruway South",        {1457.30,823.20,-89.00,2377.30,863.20,110.90}},
	{"Julius Thruway South",        {2377.30,788.80,-89.00,2537.30,897.90,110.90}},
	{"Julius Thruway West",         {1197.30,1163.30,-89.00,1236.60,2243.20,110.90}},
	{"Julius Thruway West",         {1236.60,2142.80,-89.00,1297.40,2243.20,110.90}},
	{"Juniper Hill",                {-2533.00,578.30,-7.60,-2274.10,968.30,200.00}},
	{"Juniper Hollow",              {-2533.00,968.30,-6.10,-2274.10,1358.90,200.00}},
	{"K.A.C.C. Military Fuels",     {2498.20,2626.50,-89.00,2749.90,2861.50,110.90}},
	{"Kincaid Bridge",              {-1339.80,599.20,-89.00,-1213.90,828.10,110.90}},
	{"Kincaid Bridge",              {-1213.90,721.10,-89.00,-1087.90,950.00,110.90}},
	{"Kincaid Bridge",              {-1087.90,855.30,-89.00,-961.90,986.20,110.90}},
	{"King's",                      {-2329.30,458.40,-7.60,-1993.20,578.30,200.00}},
	{"King's",                      {-2411.20,265.20,-9.10,-1993.20,373.50,200.00}},
	{"King's",                      {-2253.50,373.50,-9.10,-1993.20,458.40,200.00}},
	{"LVA Freight Depot",           {1457.30,863.20,-89.00,1777.40,1143.20,110.90}},
	{"LVA Freight Depot",           {1375.60,919.40,-89.00,1457.30,1203.20,110.90}},
	{"LVA Freight Depot",           {1277.00,1087.60,-89.00,1375.60,1203.20,110.90}},
	{"LVA Freight Depot",           {1315.30,1044.60,-89.00,1375.60,1087.60,110.90}},
	{"LVA Freight Depot",           {1236.60,1163.40,-89.00,1277.00,1203.20,110.90}},
	{"Las Barrancas",               {-926.10,1398.70,-3.00,-719.20,1634.60,200.00}},
	{"Las Brujas",                  {-365.10,2123.00,-3.00,-208.50,2217.60,200.00}},
	{"Las Colinas",                 {1994.30,-1100.80,-89.00,2056.80,-920.80,110.90}},
	{"Las Colinas",                 {2056.80,-1126.30,-89.00,2126.80,-920.80,110.90}},
	{"Las Colinas",                 {2185.30,-1154.50,-89.00,2281.40,-934.40,110.90}},
	{"Las Colinas",                 {2126.80,-1126.30,-89.00,2185.30,-934.40,110.90}},
	{"Las Colinas",                 {2747.70,-1120.00,-89.00,2959.30,-945.00,110.90}},
	{"Las Colinas",                 {2632.70,-1135.00,-89.00,2747.70,-945.00,110.90}},
	{"Las Colinas",                 {2281.40,-1135.00,-89.00,2632.70,-945.00,110.90}},
	{"Las Payasadas",               {-354.30,2580.30,2.00,-133.60,2816.80,200.00}},
	{"Las Venturas Airport",        {1236.60,1203.20,-89.00,1457.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1203.20,-89.00,1777.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1143.20,-89.00,1777.40,1203.20,110.90}},
	{"Las Venturas Airport",        {1515.80,1586.40,-12.50,1729.90,1714.50,87.50}},
	{"Last Dime Motel",             {1823.00,596.30,-89.00,1997.20,823.20,110.90}},
	{"Leafy Hollow",                {-1166.90,-1856.00,0.00,-815.60,-1602.00,200.00}},
	{"Liberty City",                {-1000.00,400.00,1300.00,-700.00,600.00,1400.00}},
	{"Lil' Probe Inn",              {-90.20,1286.80,-3.00,153.80,1554.10,200.00}},
	{"Linden Side",                 {2749.90,943.20,-89.00,2923.30,1198.90,110.90}},
	{"Linden Station",              {2749.90,1198.90,-89.00,2923.30,1548.90,110.90}},
	{"Linden Station",              {2811.20,1229.50,-39.50,2861.20,1407.50,60.40}},
	{"Little Mexico",               {1701.90,-1842.20,-89.00,1812.60,-1722.20,110.90}},
	{"Little Mexico",               {1758.90,-1722.20,-89.00,1812.60,-1577.50,110.90}},
	{"Los Flores",                  {2581.70,-1454.30,-89.00,2632.80,-1393.40,110.90}},
	{"Los Flores",                  {2581.70,-1393.40,-89.00,2747.70,-1135.00,110.90}},
	{"Los Santos International",    {1249.60,-2394.30,-89.00,1852.00,-2179.20,110.90}},
	{"Los Santos International",    {1852.00,-2394.30,-89.00,2089.00,-2179.20,110.90}},
	{"Los Santos International",    {1382.70,-2730.80,-89.00,2201.80,-2394.30,110.90}},
	{"Los Santos International",    {1974.60,-2394.30,-39.00,2089.00,-2256.50,60.90}},
	{"Los Santos International",    {1400.90,-2669.20,-39.00,2189.80,-2597.20,60.90}},
	{"Los Santos International",    {2051.60,-2597.20,-39.00,2152.40,-2394.30,60.90}},
	{"Marina",                      {647.70,-1804.20,-89.00,851.40,-1577.50,110.90}},
	{"Marina",                      {647.70,-1577.50,-89.00,807.90,-1416.20,110.90}},
	{"Marina",                      {807.90,-1577.50,-89.00,926.90,-1416.20,110.90}},
	{"Market",              	{787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
	{"Market",                      {952.60,-1310.20,-89.00,1072.60,-1130.80,110.90}},
	{"Market",                      {1072.60,-1416.20,-89.00,1370.80,-1130.80,110.90}},
	{"Market",                      {926.90,-1577.50,-89.00,1370.80,-1416.20,110.90}},
	{"Market Station",              {787.40,-1410.90,-34.10,866.00,-1310.20,65.80}},
	{"Martin Bridge",               {-222.10,293.30,0.00,-122.10,476.40,200.00}},
	{"Missionary Hill",             {-2994.40,-811.20,0.00,-2178.60,-430.20,200.00}},
	{"Montgomery",                  {1119.50,119.50,-3.00,1451.40,493.30,200.00}},
	{"Montgomery",                  {1451.40,347.40,-6.10,1582.40,420.80,200.00}},
	{"Montgomery Intersection",     {1546.60,208.10,0.00,1745.80,347.40,200.00}},
	{"Montgomery Intersection",     {1582.40,347.40,0.00,1664.60,401.70,200.00}},
	{"Mulholland",                  {1414.00,-768.00,-89.00,1667.60,-452.40,110.90}},
	{"Mulholland",                  {1281.10,-452.40,-89.00,1641.10,-290.90,110.90}},
	{"Mulholland",                  {1269.10,-768.00,-89.00,1414.00,-452.40,110.90}},
	{"Mulholland",                  {1357.00,-926.90,-89.00,1463.90,-768.00,110.90}},
	{"Mulholland",                  {1318.10,-910.10,-89.00,1357.00,-768.00,110.90}},
	{"Mulholland",                  {1169.10,-910.10,-89.00,1318.10,-768.00,110.90}},
	{"Mulholland",                  {768.60,-954.60,-89.00,952.60,-860.60,110.90}},
	{"Mulholland",                  {687.80,-860.60,-89.00,911.80,-768.00,110.90}},
	{"Mulholland",                  {737.50,-768.00,-89.00,1142.20,-674.80,110.90}},
	{"Mulholland",                  {1096.40,-910.10,-89.00,1169.10,-768.00,110.90}},
	{"Mulholland",                  {952.60,-937.10,-89.00,1096.40,-860.60,110.90}},
	{"Mulholland",                  {911.80,-860.60,-89.00,1096.40,-768.00,110.90}},
	{"Mulholland",                  {861.00,-674.80,-89.00,1156.50,-600.80,110.90}},
	{"Mulholland Intersection",     {1463.90,-1150.80,-89.00,1812.60,-768.00,110.90}},
	{"North Rock",                  {2285.30,-768.00,0.00,2770.50,-269.70,200.00}},
	{"Ocean Docks",                 {2373.70,-2697.00,-89.00,2809.20,-2330.40,110.90}},
	{"Ocean Docks",                 {2201.80,-2418.30,-89.00,2324.00,-2095.00,110.90}},
	{"Ocean Docks",                 {2324.00,-2302.30,-89.00,2703.50,-2145.10,110.90}},
	{"Ocean Docks",                 {2089.00,-2394.30,-89.00,2201.80,-2235.80,110.90}},
	{"Ocean Docks",                 {2201.80,-2730.80,-89.00,2324.00,-2418.30,110.90}},
	{"Ocean Docks",                 {2703.50,-2302.30,-89.00,2959.30,-2126.90,110.90}},
	{"Ocean Docks",                 {2324.00,-2145.10,-89.00,2703.50,-2059.20,110.90}},
	{"Ocean Flats",                 {-2994.40,277.40,-9.10,-2867.80,458.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-222.50,-0.00,-2593.40,277.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-430.20,-0.00,-2831.80,-222.50,200.00}},
	{"Octane Springs",              {338.60,1228.50,0.00,664.30,1655.00,200.00}},
	{"Old Venturas Strip",          {2162.30,2012.10,-89.00,2685.10,2202.70,110.90}},
	{"Palisades",                   {-2994.40,458.40,-6.10,-2741.00,1339.60,200.00}},
	{"Palomino Creek",              {2160.20,-149.00,0.00,2576.90,228.30,200.00}},
	{"Paradiso",                    {-2741.00,793.40,-6.10,-2533.00,1268.40,200.00}},
	{"Pershing Square",             {1440.90,-1722.20,-89.00,1583.50,-1577.50,110.90}},
	{"Pilgrim",                     {2437.30,1383.20,-89.00,2624.40,1783.20,110.90}},
	{"Pilgrim",                     {2624.40,1383.20,-89.00,2685.10,1783.20,110.90}},
	{"Pilson Intersection",         {1098.30,2243.20,-89.00,1377.30,2507.20,110.90}},
	{"Pirates in Men's Pants",      {1817.30,1469.20,-89.00,2027.40,1703.20,110.90}},
	{"Playa del Seville",           {2703.50,-2126.90,-89.00,2959.30,-1852.80,110.90}},
	{"Prickle Pine",                {1534.50,2583.20,-89.00,1848.40,2863.20,110.90}},
	{"Prickle Pine",          	{1117.40,2507.20,-89.00,1534.50,2723.20,110.90}},
	{"Prickle Pine",         	{1848.40,2553.40,-89.00,1938.80,2863.20,110.90}},
	{"Prickle Pine",                {1938.80,2624.20,-89.00,2121.40,2861.50,110.90}},
	{"Queens",                      {-2533.00,458.40,0.00,-2329.30,578.30,200.00}},
	{"Queens",                      {-2593.40,54.70,0.00,-2411.20,458.40,200.00}},
	{"Queens",                      {-2411.20,373.50,0.00,-2253.50,458.40,200.00}},
	{"Randolph Industrial Estate",  {1558.00,596.30,-89.00,1823.00,823.20,110.90}},
	{"Redsands East",               {1817.30,2011.80,-89.00,2106.70,2202.70,110.90}},
	{"Redsands East",               {1817.30,2202.70,-89.00,2011.90,2342.80,110.90}},
	{"Redsands East",               {1848.40,2342.80,-89.00,2011.90,2478.40,110.90}},
	{"Redsands West",               {1236.60,1883.10,-89.00,1777.30,2142.80,110.90}},
	{"Redsands West",               {1297.40,2142.80,-89.00,1777.30,2243.20,110.90}},
	{"Redsands West",               {1377.30,2243.20,-89.00,1704.50,2433.20,110.90}},
	{"Redsands West",               {1704.50,2243.20,-89.00,1777.30,2342.80,110.90}},
	{"Regular Tom",                 {-405.70,1712.80,-3.00,-276.70,1892.70,200.00}},
	{"Richman",                     {647.50,-1118.20,-89.00,787.40,-954.60,110.90}},
	{"Richman",                     {647.50,-954.60,-89.00,768.60,-860.60,110.90}},
	{"Richman",                     {225.10,-1369.60,-89.00,334.50,-1292.00,110.90}},
	{"Richman",                     {225.10,-1292.00,-89.00,466.20,-1235.00,110.90}},
	{"Richman",                     {72.60,-1404.90,-89.00,225.10,-1235.00,110.90}},
	{"Richman",                     {72.60,-1235.00,-89.00,321.30,-1008.10,110.90}},
	{"Richman",                     {321.30,-1235.00,-89.00,647.50,-1044.00,110.90}},
	{"Richman",                     {321.30,-1044.00,-89.00,647.50,-860.60,110.90}},
	{"Richman",                     {321.30,-860.60,-89.00,687.80,-768.00,110.90}},
	{"Richman",                     {321.30,-768.00,-89.00,700.70,-674.80,110.90}},
	{"Robada Intersection",         {-1119.00,1178.90,-89.00,-862.00,1351.40,110.90}},
	{"Roca Escalante",              {2237.40,2202.70,-89.00,2536.40,2542.50,110.90}},
	{"Roca Escalante",              {2536.40,2202.70,-89.00,2625.10,2442.50,110.90}},
	{"Rockshore East",              {2537.30,676.50,-89.00,2902.30,943.20,110.90}},
	{"Rockshore West",              {1997.20,596.30,-89.00,2377.30,823.20,110.90}},
	{"Rockshore West",              {2377.30,596.30,-89.00,2537.30,788.80,110.90}},
	{"Rodeo",                       {72.60,-1684.60,-89.00,225.10,-1544.10,110.90}},
	{"Rodeo",                       {72.60,-1544.10,-89.00,225.10,-1404.90,110.90}},
	{"Rodeo",                       {225.10,-1684.60,-89.00,312.80,-1501.90,110.90}},
	{"Rodeo",                       {225.10,-1501.90,-89.00,334.50,-1369.60,110.90}},
	{"Rodeo",                       {334.50,-1501.90,-89.00,422.60,-1406.00,110.90}},
	{"Rodeo",                       {312.80,-1684.60,-89.00,422.60,-1501.90,110.90}},
	{"Rodeo",                       {422.60,-1684.60,-89.00,558.00,-1570.20,110.90}},
	{"Rodeo",                       {558.00,-1684.60,-89.00,647.50,-1384.90,110.90}},
	{"Rodeo",                       {466.20,-1570.20,-89.00,558.00,-1385.00,110.90}},
	{"Rodeo",                       {422.60,-1570.20,-89.00,466.20,-1406.00,110.90}},
	{"Rodeo",                       {466.20,-1385.00,-89.00,647.50,-1235.00,110.90}},
	{"Rodeo",                       {334.50,-1406.00,-89.00,466.20,-1292.00,110.90}},
	{"Royal Casino",                {2087.30,1383.20,-89.00,2437.30,1543.20,110.90}},
	{"San Andreas Sound",           {2450.30,385.50,-100.00,2759.20,562.30,200.00}},
	{"Santa Flora",                 {-2741.00,458.40,-7.60,-2533.00,793.40,200.00}},
	{"Santa Maria Beach",           {342.60,-2173.20,-89.00,647.70,-1684.60,110.90}},
	{"Santa Maria Beach",           {72.60,-2173.20,-89.00,342.60,-1684.60,110.90}},
	{"Shady Cabin",                 {-1632.80,-2263.40,-3.00,-1601.30,-2231.70,200.00}},
	{"Shady Creeks",                {-1820.60,-2643.60,-8.00,-1226.70,-1771.60,200.00}},
	{"Shady Creeks",                {-2030.10,-2174.80,-6.10,-1820.60,-1771.60,200.00}},
	{"Sobell Rail Yards",           {2749.90,1548.90,-89.00,2923.30,1937.20,110.90}},
	{"Spinybed",                    {2121.40,2663.10,-89.00,2498.20,2861.50,110.90}},
	{"Starfish Casino",             {2437.30,1783.20,-89.00,2685.10,2012.10,110.90}},
	{"Starfish Casino",             {2437.30,1858.10,-39.00,2495.00,1970.80,60.90}},
	{"Starfish Casino",             {2162.30,1883.20,-89.00,2437.30,2012.10,110.90}},
	{"Temple",                      {1252.30,-1130.80,-89.00,1378.30,-1026.30,110.90}},
	{"Temple",                      {1252.30,-1026.30,-89.00,1391.00,-926.90,110.90}},
	{"Temple",                      {1252.30,-926.90,-89.00,1357.00,-910.10,110.90}},
	{"Temple",                      {952.60,-1130.80,-89.00,1096.40,-937.10,110.90}},
	{"Temple",                      {1096.40,-1130.80,-89.00,1252.30,-1026.30,110.90}},
	{"Temple",                      {1096.40,-1026.30,-89.00,1252.30,-910.10,110.90}},
	{"The Camel's Toe",             {2087.30,1203.20,-89.00,2640.40,1383.20,110.90}},
	{"The Clown's Pocket",          {2162.30,1783.20,-89.00,2437.30,1883.20,110.90}},
	{"The Emerald Isle",            {2011.90,2202.70,-89.00,2237.40,2508.20,110.90}},
	{"The Farm",                    {-1209.60,-1317.10,114.90,-908.10,-787.30,251.90}},
	{"The Four Dragons Casino",     {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
	{"The High Roller",             {1817.30,1283.20,-89.00,2027.30,1469.20,110.90}},
	{"The Mako Span",               {1664.60,401.70,0.00,1785.10,567.20,200.00}},
	{"The Panopticon",              {-947.90,-304.30,-1.10,-319.60,327.00,200.00}},
	{"The Pink Swan",               {1817.30,1083.20,-89.00,2027.30,1283.20,110.90}},
	{"The Sherman Dam",             {-968.70,1929.40,-3.00,-481.10,2155.20,200.00}},
	{"The Strip",                   {2027.40,863.20,-89.00,2087.30,1703.20,110.90}},
	{"The Strip",                   {2106.70,1863.20,-89.00,2162.30,2202.70,110.90}},
	{"The Strip",                   {2027.40,1783.20,-89.00,2162.30,1863.20,110.90}},
	{"The Strip",                   {2027.40,1703.20,-89.00,2137.40,1783.20,110.90}},
	{"The Visage",                  {1817.30,1863.20,-89.00,2106.70,2011.80,110.90}},
	{"The Visage",                  {1817.30,1703.20,-89.00,2027.40,1863.20,110.90}},
	{"Unity Station",               {1692.60,-1971.80,-20.40,1812.60,-1932.80,79.50}},
	{"Valle Ocultado",              {-936.60,2611.40,2.00,-715.90,2847.90,200.00}},
	{"Verdant Bluffs",              {930.20,-2488.40,-89.00,1249.60,-2006.70,110.90}},
	{"Verdant Bluffs",              {1073.20,-2006.70,-89.00,1249.60,-1842.20,110.90}},
	{"Verdant Bluffs",              {1249.60,-2179.20,-89.00,1692.60,-1842.20,110.90}},
	{"Verdant Meadows",             {37.00,2337.10,-3.00,435.90,2677.90,200.00}},
	{"Verona Beach",                {647.70,-2173.20,-89.00,930.20,-1804.20,110.90}},
	{"Verona Beach",                {930.20,-2006.70,-89.00,1073.20,-1804.20,110.90}},
	{"Verona Beach",                {851.40,-1804.20,-89.00,1046.10,-1577.50,110.90}},
	{"Verona Beach",                {1161.50,-1722.20,-89.00,1323.90,-1577.50,110.90}},
	{"Verona Beach",                {1046.10,-1722.20,-89.00,1161.50,-1577.50,110.90}},
	{"Vinewood",                    {787.40,-1310.20,-89.00,952.60,-1130.80,110.90}},
	{"Vinewood",                    {787.40,-1130.80,-89.00,952.60,-954.60,110.90}},
	{"Vinewood",                    {647.50,-1227.20,-89.00,787.40,-1118.20,110.90}},
	{"Vinewood",                    {647.70,-1416.20,-89.00,787.40,-1227.20,110.90}},
	{"Whitewood Estates",           {883.30,1726.20,-89.00,1098.30,2507.20,110.90}},
	{"Whitewood Estates",           {1098.30,1726.20,-89.00,1197.30,2243.20,110.90}},
	{"Willowfield",                 {1970.60,-2179.20,-89.00,2089.00,-1852.80,110.90}},
	{"Willowfield",                 {2089.00,-2235.80,-89.00,2201.80,-1989.90,110.90}},
	{"Willowfield",                 {2089.00,-1989.90,-89.00,2324.00,-1852.80,110.90}},
	{"Willowfield",                 {2201.80,-2095.00,-89.00,2324.00,-1989.90,110.90}},
	{"Willowfield",                 {2541.70,-1941.40,-89.00,2703.50,-1852.80,110.90}},
	{"Willowfield",                 {2324.00,-2059.20,-89.00,2541.70,-1852.80,110.90}},
	{"Willowfield",                 {2541.70,-2059.20,-89.00,2703.50,-1941.40,110.90}},
	{"Yellow Bell Station",         {1377.40,2600.40,-21.90,1492.40,2687.30,78.00}},
	// Main Zones
	{"Los Santos",                  {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
	{"Las Venturas",                {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
	{"Bone County",                 {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
	{"Tierra Robada",               {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
	{"Tierra Robada",               {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
	{"San Fierro",                  {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
	{"Red County",                  {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
	{"Flint County",                {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
	{"Whetstone",                   {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}}
};

static const MonthDays[12]=
{
	31,//Januar
	28,//Februar
	31,//Maerz
	30,//April
	31,//Mai
	30,//Juni
	31,//Juli
	31,//August
	30,//September
	31,//Oktober
	30,//November
	31//Dezember
};

static const JB_AdminCommands[][32]=
{
    "/jbcfg",
	"/jbvarlist",
	"/jbsetvar",
	"/blackadd",
	"/blackdel",
	"/whiteadd",
	"/whitedel",
	"/tban",
	"/tunban",
	"/banIP",
	"/unbanIP",
	"/myfps"
};

//==============================================================================

Public:JB_SetVehicleVelocity(vehicleid,Float:x,Float:y,Float:z)
{
	if(vehicleid!=INVALID_VEHICLE_ID)
	{
	    new tspeed=JB_Speed(x,y,z,110.0,JB_Variables[SPEED_3D]);
		if(JB_Variables[MAX_SPEED] && tspeed>=JB_Variables[MAX_SPEED])
		{
		    JB_LogEx("Could not set velocity for vehicle %d because max speed is %d KM/H. (%d KM/H blocked)",vehicleid,JB_Variables[MAX_SPEED],tspeed);
		    return 0;
		}
		return SetVehicleVelocity(vehicleid,x,y,z);
	}
	return 0;
}

Public:JB_SetPlayerSpecialAction(playerid,actionid)
{
	if(IsPlayerConnected(playerid))
	{
	    if(actionid==SPECIAL_ACTION_USEJETPACK && JB_Variables[JETPACK] && (!JB_IsPlayerAdmin(playerid) || !JB_Variables[ADMIN_IMMUNITY]))
	    {
	        JB_LogEx("Could not give '%s' a jetpack because it's forbidden.",JB_ReturnPlayerName(playerid));
	        return 0;
	    }
	    
	    return SetPlayerSpecialAction(playerid,actionid);
	}
	return 0;
}

Public:JB_PutPlayerInVehicle(playerid,vehicleid,seatid)
{
	if(IsPlayerConnected(playerid) && vehicleid!=INVALID_VEHICLE_ID)
	{
	    if(PutPlayerInVehicle(playerid,vehicleid,seatid))
	    {
	        JB_PlayerInfo[playerid][JB_pNoTeleportCheck]=3;
	    	JB_PlayerInfo[playerid][JB_pVehicleEntered]=vehicleid;
  			return 1;
		}
	}
	return 0;
}

Public:JB_GivePlayerMoney(playerid,money)
{
	if(IsPlayerConnected(playerid))
	{
	    GivePlayerMoney(playerid,money);
	    JB_PlayerInfo[playerid][JB_pMoney]+=money;
	    return 1;
	}
	return 0;
}

Public:JB_ResetPlayerMoney(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    ResetPlayerMoney(playerid);
	    JB_PlayerInfo[playerid][JB_pMoney]=0;
	    return 1;
	}
	return 0;
}

Public:JB_GetPlayerMoney(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new money=GetPlayerMoney(playerid);
	    if(!JB_Variables[MONEY_HACK] || money<JB_PlayerInfo[playerid][JB_pMoney])
	        return money;
		else
		    return JB_PlayerInfo[playerid][JB_pMoney];
	}
	return 0;
}

Public:JB_SetPlayerMoney(playerid,money)
{
	if(IsPlayerConnected(playerid))
	{
	    ResetPlayerMoney(playerid);
	    GivePlayerMoney(playerid,money);
	    JB_PlayerInfo[playerid][JB_pMoney]=money;
	    return 1;
	}
	return 0;
}

Public:JB_SetPlayerPos(playerid,Float:x,Float:y,Float:z)
{
	if(IsPlayerConnected(playerid))
	{
	    if(SetPlayerPos(playerid,x,y,z))
	    {
	        JB_PlayerInfo[playerid][JB_pCurrentPos][0]=x;
	        JB_PlayerInfo[playerid][JB_pCurrentPos][1]=y;
	        JB_PlayerInfo[playerid][JB_pCurrentPos][2]=z;
	        JB_PlayerInfo[playerid][JB_pSetPos][0]=x;
			JB_PlayerInfo[playerid][JB_pSetPos][1]=y;
			JB_PlayerInfo[playerid][JB_pSetPos][2]=z;
	        JB_PlayerInfo[playerid][JB_pNoTeleportCheck]=3;//Do not check position for 3 seconds to prevent lag kick.
	        return 1;
	    }
	}
	return 0;
}

Public:JB_SetVehiclePos(vehicleid,Float:x,Float:y,Float:z)
{
	if(vehicleid!=INVALID_VEHICLE_ID)
	{
	    if(SetVehiclePos(vehicleid,x,y,z))
	    {
			ForEachPlayer(i)
			{
			    if(GetPlayerVehicleID(i)==vehicleid)
			    {
			        JB_PlayerInfo[i][JB_pCurrentPos][0]=x;
			        JB_PlayerInfo[i][JB_pCurrentPos][1]=y;
			        JB_PlayerInfo[i][JB_pCurrentPos][2]=z;
			        JB_PlayerInfo[i][JB_pSetPos][0]=x;
					JB_PlayerInfo[i][JB_pSetPos][1]=y;
					JB_PlayerInfo[i][JB_pSetPos][2]=z;
			        JB_PlayerInfo[i][JB_pNoTeleportCheck]=4;//Do not check position for 4 seconds to prevent lag kick.
			    }
			}
			return 1;
		}
	}
	return 0;
}

Public:JB_GivePlayerWeapon(playerid,weaponid,ammo)
{
	if(!IsWeaponForbiddenForPlayer(playerid,weaponid) || (JB_IsPlayerAdmin(playerid) && JB_Variables[ADMIN_IMMUNITY]))
	{
	    GivePlayerWeapon(playerid,weaponid,ammo);
	    return 1;
	}
	new weapon[32];
	GetWeaponName(weaponid,weapon,sizeof(weapon));
	JB_LogEx("Could not give '%s' weapon %s (%d) because it is forbidden!",JB_ReturnPlayerName(playerid),weapon,weaponid);
	return 0;
}

Public:JB_SetPlayerHealth(playerid,Float:health)
{
	new Float:tmp_health=health;
	if(tmp_health<0.0)
	    tmp_health=0.0;
	else if(tmp_health>100.0 && JB_Variables[HEALTH_HACK])
	    tmp_health=100.0;
	return SetPlayerHealth(playerid,tmp_health);
}

Public:JB_SetPlayerArmour(playerid,Float:armour)
{
	new Float:tmp_armour=armour;
	if(tmp_armour<0.0)
	    tmp_armour=0.0;
	else if(tmp_armour>100.0 && JB_Variables[ARMOUR_HACK])
	    tmp_armour=100.0;
	return SetPlayerArmour(playerid,tmp_armour);
}

Public:JB_SetVehicleHealth(vehicleid,Float:health)
{
	new Float:tmp_health=health;
	if(tmp_health<0.0)
	    tmp_health=0.0;
	else if(tmp_health>1000.0 && JB_Variables[TANK_MODE])
	    tmp_health=1000.0;
	return SetVehicleHealth(vehicleid,tmp_health);
}

Public:JB_TogglePlayerControllable(playerid,toggle)
{
 	if(toggle)
	    JB_PlayerInfo[playerid][JB_pFreezed]=false;
	else
	    JB_PlayerInfo[playerid][JB_pFreezed]=true;
	return TogglePlayerControllable(playerid,toggle);
}

Public:SetPlayerSpawnKillProtected(playerid,set)
{
	if(IsPlayerConnected(playerid))
	{
	    if(set)
	    	JB_PlayerInfo[playerid][JB_pSpawnKillProtected]=JB_Variables[SPAWN_TIME];
		else
            JB_PlayerInfo[playerid][JB_pSpawnKillProtected]=0;
	    return 1;
	}
	return 0;
}

//==============================================================================

Public:AntiBugKill(playerid)
{
	if(IsPlayerConnected(playerid) && IsPlayerInValidState(playerid) && !JB_PlayerInfo[playerid][JB_pAntiBugKilled])
	{
	    new Float:x,Float:y,Float:z,Float:health,Float:armour,Float:angle,weapons[13][2],varname[32],hour,minute;
        JB_PlayerInfo[playerid][JB_pAntiBugKilled]=true;
	    GetPlayerPos(playerid,x,y,z);
	    GetPlayerFacingAngle(playerid,angle);
	    GetPlayerHealth(playerid,health);
	    GetPlayerArmour(playerid,armour);
	    for(new i=0;i<13;i++)
	    {
	        GetPlayerWeaponData(playerid,i,weapons[i][0],weapons[i][1]);
	        format(varname,sizeof(varname),"JB_ABK_Weapon%02d",i);
	        SetPVarInt(playerid,varname,weapons[i][0]);
	        format(varname,sizeof(varname),"JB_ABK_Ammo%02d",i);
	        SetPVarInt(playerid,varname,weapons[i][1]);
		}
	        
	    SetPVarFloat(playerid,"JB_ABK_PosX",x);
     	SetPVarFloat(playerid,"JB_ABK_PosY",y);
     	SetPVarFloat(playerid,"JB_ABK_PosZ",z);
     	SetPVarFloat(playerid,"JB_ABK_Angle",angle);
     	SetPVarFloat(playerid,"JB_ABK_Health",health);
     	SetPVarFloat(playerid,"JB_ABK_Armour",armour);
     	SetPVarInt(playerid,"JB_ABK_World",GetPlayerVirtualWorld(playerid));
     	SetPVarInt(playerid,"JB_ABK_Interior",GetPlayerInterior(playerid));
     	SetPVarInt(playerid,"JB_ABK_VehicleID",GetPlayerVehicleID(playerid));
     	SetPVarInt(playerid,"JB_ABK_Seat",GetPlayerVehicleSeat(playerid));
     	GetPlayerTime(playerid,hour,minute);
     	SetPVarInt(playerid,"JB_ABK_Hour",hour);
     	SetPVarInt(playerid,"JB_ABK_Minute",minute);
     	
		ResetPlayerWeapons(playerid);
        SetPlayerHealth(playerid,0.0);
        SetPlayerArmour(playerid,0.0);
        return 1;
	}
	return 0;
}

Public:MutePlayer(playerid,time,reason[])//Time is seconds.
{
	if(IsPlayerConnected(playerid) && time)
	{
	    JB_PlayerInfo[playerid][JB_pMuted]=time;
	    JB_LogEx("%s has been muted for %d second(s) because of %s.",JB_ReturnPlayerName(playerid),time,reason);
	    JB_SendFormattedMessageToAll(JB_RED,"JunkBuster: Muting player '%s' (%d) for %d second(s). Reason: %s",JB_ReturnPlayerName(playerid),playerid,time,reason);
	    return 1;
	}
	return 0;
}

Public:JB_Kick(playerid,reason[])
{
	if(IsPlayerConnected(playerid))
	{
	    new string[128];
	    format(string,sizeof(string),"~r~Kick notification:~n~%s",reason);
	    GameTextForPlayer(playerid,string,60000,4);

	    TogglePlayerControllable(playerid,false);
	    JB_SendFormattedMessageToAll(JB_RED,"JunkBuster: Kicking player '%s'. Reason: %s",JB_ReturnPlayerName(playerid),reason);
	    JB_LogEx("%s (%s) has been kicked for %s.",JB_ReturnPlayerName(playerid),JB_ReturnPlayerIp(playerid),reason);
	    Kick(playerid);
	    return 1;
	}
	return 0;
}

Public:JB_Ban(playerid,reason[])
{
	if(IsPlayerConnected(playerid))
	{
	    new string[128];
	    format(string,sizeof(string),"~r~Ban notification:~n~%s",reason);
	    GameTextForPlayer(playerid,string,60000,4);

	    TogglePlayerControllable(playerid,false);
	    JB_SendFormattedMessageToAll(JB_RED,"JunkBuster: Banning player '%s'. Reason: %s",JB_ReturnPlayerName(playerid),reason);
	    JB_LogEx("%s (%s) has been banned for %s.",JB_ReturnPlayerName(playerid),JB_ReturnPlayerIp(playerid),reason);
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

stock IsCheatPosition(playerid)
{
	for(new i=0;i<sizeof(CheatPositions);i++)
	    if(IsPlayerInRangeOfPoint(playerid,5.0,CheatPositions[i][0],CheatPositions[i][1],CheatPositions[i][2]))
	        return true;
	return false;
}

stock SingleplayerCheatCheck(string[])
{
	if(strlen(string)<6)
	    return false;

	for(new i=0;i<sizeof(SingleplayerCheats);i++)
	    if(strfind(string,SingleplayerCheats[i],true)!=-1)
	        return true;
	return false;
}

stock IsPlayerInPlane(playerid)
{
	new m=GetVehicleModel(GetPlayerVehicleID(playerid));
	for(new i=0;i<sizeof(JB_Planes);i++)
	    if(m==JB_Planes[i])
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
	if(!isnull(string))
	{
		if(!strfind(string,"www.",false) || !strfind(string,"http://",false) || !strfind(string,".com",false) || !strfind(string,".net",false)
			|| !strfind(string,".de",false) || !strfind(string,".org",false))
		    return true;

		new c=1,idx,tmp[32],ip[4],len=strlen(string);
		for(new i=0;i<len;i++)
		    if(string[i]==' ')
		        c++;

		for(new i=0;i<c;i++)
		{
		    idx=0;
		    tmp=JB_strtok(string,idx);
		    idx=0;
		    tmp=JB_strtok(tmp,idx,':');
			ip=SplitIp(tmp);
			if(ip[0]>=0 && ip[1]>=0 && ip[2]>=0 && ip[3]>=0) // We have found an IP :o
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

stock CheckText(playerid,text[])//return 1: something forbidden found, return 0: everything OK!
{
	if(JB_Variables[ADVERTISEMENT] && !JB_IsPlayerAdmin(playerid) && AdvertisementCheck(text))
	{
	    JB_Kick(playerid,"Advertisement");
	    return 1;
	}

    if(JB_Variables[CAPS_LOCK] && CapsLockCheck(text))
	{
	    SendClientMessage(playerid,JB_RED,"JunkBuster: You are not allowed to use Caps Lock! Press [Caps Lock] to disable it.");
	    return 1;
	}

	if(JB_Variables[SINGLEPLAYER_CHEATS] && SingleplayerCheatCheck(text))
	{
	    JB_Kick(playerid,"Attempting to use singleplayer cheats");
	    return 1;
	}

	if(JB_Variables[BAD_WORDS] && BadWordsCheck(text))
	{
	    SendClientMessage(playerid,JB_RED,"JunkBuster: You are not allowed to use such words!");
	    return 1;
	}
	return 0;
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

stock IsWeaponForbiddenForPlayer(playerid,weaponid)
{
	if(weaponid<0 || weaponid>=MAX_WEAPONS)
	    return true;
	    
	//Forbidden for player OR forbidden for all and player isn't allowed to use it, too.
	return (JB_PlayerInfo[playerid][JB_pWeaponForbidden][weaponid] || (IsForbiddenWeapon(weaponid) && JB_PlayerInfo[playerid][JB_pWeaponForbidden][weaponid]));
}

stock AllowWeaponForPlayer(playerid,weaponid)
{
    if(weaponid<0 || weaponid>=MAX_WEAPONS)
	    return 0;
	    
	if(IsPlayerConnected(playerid))
	{
	    JB_PlayerInfo[playerid][JB_pWeaponForbidden][weaponid]=false;
	   	return 1;
	}
	return 0;
}

stock ForbidWeaponForPlayer(playerid,weaponid)
{
    if(weaponid<0 || weaponid>=MAX_WEAPONS)
	    return 0;

	if(IsPlayerConnected(playerid))
	{
	    new tmpforbid=JB_PlayerInfo[playerid][JB_pWeaponForbidden][weaponid];
	    JB_PlayerInfo[playerid][JB_pWeaponForbidden][weaponid]=true;
	    if(!tmpforbid && JB_Variables[ANTI_BUG_KILL])//Wasn't forbidden before and is now forbidden.
	        AntiBugKill(playerid);//forbidding a minigun when leaving for example a minigun deathmatch may result in a ban when this isn't used.
		return 1;
	}
	return 0;
}

Public:ResetForbiddenWeaponsForPlayer(playerid) // Forbid like in configuration
{
	if(IsPlayerConnected(playerid))
	{
    	for(new i=0;i<MAX_WEAPONS;i++)
			AllowWeaponForPlayer(playerid,i);

		for(new i=0;i<ForbiddenWeaponsCount;i++)
			ForbidWeaponForPlayer(playerid,ForbiddenWeapons[i]);
		return 1;
	}
	return 0;
}

stock JunkBusterReport(playerid,report[],details[])
{
	if(IsPlayerConnected(playerid))
	{
		new string[128];
		format(string,sizeof(string),"JunkBuster: Suspected player with %s: %s (%d), %s.",report,JB_ReturnPlayerName(playerid),playerid,details);
		ForEachPlayer(i)
		    if(JB_IsPlayerAdmin(i) && i!=playerid)
		        SendClientMessage(i,JB_RED,string);

		return JB_Log(string[12]);
	}
	return 0;
}

stock JB_IsPlayerAdmin(playerid)
	return (IsPlayerAdmin(playerid) || CallRemoteFunction("IsPlayerAdminCall","i",playerid));

forward IsPlayerAdminCall(playerid);

/*
Put for example this into your gamemode (Godfather):

public IsPlayerAdminCall(playerid)
	return (PlayerInfo[playerid][pAdmin] >= 1);

You can link your admin system with JunkBuster,
if you create a IsPlayerAdminCall function which
fits to your script. (The example above may only work for GF!)
*/

//==============================================================================

Public:GlobalUpdate()
{
	ForEachPlayer(i)
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
		    
        if(JB_Warnings[i][AIRBREAK])
		    JB_Warnings[i][AIRBREAK]--;
		    
        if(JB_Warnings[i][CHECKPOINT_TELEPORT])
		    JB_Warnings[i][CHECKPOINT_TELEPORT]--;
		    
        if(JB_Warnings[i][MIN_FPS])
		    JB_Warnings[i][MIN_FPS]=JB_Warnings[i][MIN_FPS]/2;
		    
        JB_Warnings[i][NO_RELOAD]=0;
    }
	return 1;
}

Public:SpamUpdate()
{
	ForEachPlayer(i)
	{
		if(JB_PlayerInfo[i][JB_pMessages])
			JB_PlayerInfo[i][JB_pMessages]--;
		
        if(JB_PlayerInfo[i][JB_pCommands])
		    JB_PlayerInfo[i][JB_pCommands]--;
	}
	return 1;
}

//==============================================================================
						/*   MAIN FUNCTION OF ANTI-CHEAT   */

Public:JunkBuster()
{
	new Float:health,Float:armour,var,reason[64],var2[3];
	new Float:x,Float:y,Float:z;
	new pstate,vehicleid;
	ForEachPlayer(i)
	{
	    if(JB_PlayerInfo[i][JB_pFullyConnected] && GetPlayerPos(i,x,y,z))
	    {
	        pstate=GetPlayerState(i);
	        vehicleid=GetPlayerVehicleID(i);
	        if(JB_PlayerInfo[i][JB_pMuted])
	            JB_PlayerInfo[i][JB_pMuted]--;
	            
			if(JB_PlayerInfo[i][JB_pSpawnKillProtected])
			    JB_PlayerInfo[i][JB_pSpawnKillProtected]--;

			if(JB_Variables[MONEY_HACK])
			    if(GetPlayerMoney(i)>JB_PlayerInfo[i][JB_pMoney])
			        JB_SetPlayerMoney(i,JB_PlayerInfo[i][JB_pMoney]);

            if(JB_PlayerInfo[i][JB_pSpeedhacking]>=MAX_CHECKS)
			{
			    TogglePlayerControllable(i,true);
			    JB_PlayerInfo[i][JB_pSpeedhacking]=0;
			}
			
			if(JB_PlayerInfo[i][JB_pAirbreaking]>=MAX_CHECKS)
                JB_PlayerInfo[i][JB_pAirbreaking]=0;

			if(JB_PlayerInfo[i][JB_pFreezed] && JB_Variables[FREEZE_UPDATE])//Prevent  that cheaters unfreeze themselves.
			    TogglePlayerControllable(i,false);

			if(IsPlayerInValidState(i) && !JB_PlayerInfo[i][JB_pAntiBugKilled] && (!JB_IsPlayerAdmin(i) || !JB_Variables[ADMIN_IMMUNITY]))
			{
				if(JB_Variables[TANK_MODE] && pstate==PLAYER_STATE_DRIVER)
				{
				    GetVehicleHealth(vehicleid,health);
				    if(health>1000.0)
				    {
				        SetVehicleToRespawn(vehicleid);
				        JB_Ban(i,"Tank Mode");
				        continue;
				    }
				}
				
				if(JB_Variables[MIN_FPS])
				{
				    var=GetPlayerFPS(i);
				    if(var<JB_Variables[MIN_FPS])
				    {
				        JB_Warnings[i][MIN_FPS]++;
				        if(JB_Warnings[i][MIN_FPS]>=(MAX_CHECKS*30))//Constantly low FPS = kick
				        {
				        	format(reason,sizeof(reason),"Too low FPS (%d, min %d)",var,JB_Variables[MIN_FPS]);
							JB_Kick(i,reason);
							continue;
						}
						else if(JB_Warnings[i][MIN_FPS]==(MAX_CHECKS*5) || JB_Warnings[i][MIN_FPS]==(MAX_CHECKS*10) || JB_Warnings[i][MIN_FPS]==(MAX_CHECKS*20))
						{
						    format(reason,sizeof(reason),"JunkBuster: Please fix your framerate (FPS) or you will get kicked! (Min %d, your FPS: %d)",JB_Variables[MIN_FPS],var);
							SendClientMessage(i,JB_RED,reason);
							SendClientMessage(i,JB_RED,"JunkBuster: Pressing F7 once may help to fix it. (Removes the outlines of the letters in chat window.)");
						}
				    }
				}
			
			    if(!JB_PlayerInfo[i][JB_pNoTeleportCheck])
			    {
			        if((z<900.0)==(JB_PlayerInfo[i][JB_pCurrentPos][2]<900.0))//Prevent kick when entering buildings.
			        {
						if(pstate!=PLAYER_STATE_PASSENGER && GetPlayerSurfingVehicleID(i)==INVALID_VEHICLE_ID && !IsPlayerInRangeOfPoint(i,500.0,JB_PlayerInfo[i][JB_pCurrentPos][0],JB_PlayerInfo[i][JB_pCurrentPos][1],JB_PlayerInfo[i][JB_pCurrentPos][2]))
						{
						    if(!IsPlayerInRangeOfPoint(i,1.5,JB_PlayerInfo[i][JB_pSetPos][0],JB_PlayerInfo[i][JB_pSetPos][1],JB_PlayerInfo[i][JB_pSetPos][2]))
						    {
								JB_GetPlayer2DZone(i,reason,sizeof(reason));
							    JB_Warnings[i][TELEPORT_HACK]++;
						        if(JB_Variables[TELEPORT_HACK] && (JB_Warnings[i][TELEPORT_HACK]>=MAX_CHECKS || IsCheatPosition(i)))
						        {
						            format(reason,sizeof(reason),"Using teleport cheats: %s",reason);
									JB_Kick(i,reason);
									continue;
								}
								else
								    JunkBusterReport(i,"teleport cheats",reason);
							}
						}
					}
					
					if(JB_Variables[AIRBREAK] && (pstate==PLAYER_STATE_ONFOOT || (pstate==PLAYER_STATE_DRIVER && JB_GetPlayerSpeed(i,true)<10)))
					{
					    var=(floatround(floatsqroot(JB_GetSquareDistance(x,y,z,JB_PlayerInfo[i][JB_pCurrentPos][0],JB_PlayerInfo[i][JB_pCurrentPos][1],JB_PlayerInfo[i][JB_pCurrentPos][2]))*3600)/(GetTickCount()-JB_PlayerInfo[i][JB_pLastCheck]));
						if(var>=500 && var<=1500)
                        {
                            JB_PlayerInfo[i][JB_pAirbreaking]++;
						    if(JB_PlayerInfo[i][JB_pAirbreaking]==MAX_CHECKS)
							{
							    JB_Warnings[i][AIRBREAK]++;
							    if(JB_Warnings[i][AIRBREAK]<MAX_CHECKS)
							    {
								    format(reason,sizeof(reason),"height: %.2f, ~%d KM/H, vehicle: %s",z,var,JB_GetVehicleName(vehicleid));
								    JunkBusterReport(i,"airbreak",reason);
							    }
							    else
							    {
							        JB_Ban(i,"Airbreak");
							        continue;
							    }
							}
                        }
						else
						    JB_PlayerInfo[i][JB_pAirbreaking]=0;
					}

					if(pstate==PLAYER_STATE_DRIVER && JB_Variables[MAX_SPEED])
					{
					    var=JB_GetPlayerSpeed(i,JB_Variables[SPEED_3D]);
						if(var>JB_Variables[MAX_SPEED] && !IsPlayerInPlane(i))
						{
						    JB_PlayerInfo[i][JB_pSpeedhacking]++;
						    if(JB_PlayerInfo[i][JB_pSpeedhacking]==MAX_CHECKS)
							{
							    JB_Warnings[i][MAX_SPEED]++;
							    TogglePlayerControllable(i,false);
							    if(JB_Warnings[i][MAX_SPEED]<MAX_CHECKS)
							    {
								    format(reason,sizeof(reason),"%d KM/H with %s",var,JB_GetVehicleName(vehicleid));
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
						    JB_PlayerInfo[i][JB_pSpeedhacking]=0;
					}
			    }
  				else
			  		JB_PlayerInfo[i][JB_pNoTeleportCheck]--;

			    var=GetPlayerWeapon(i);
			    if(IsWeaponForbiddenForPlayer(i,var))
			    {
					GetWeaponName(var,reason,sizeof(reason));
			        format(reason,sizeof(reason),"Using weapon cheats (%s)",reason);
					JB_Ban(i,reason);
			        continue;
			    }
			    
			    if(JB_Variables[WEAPON_HACK])
			    {
				    var2[0]=0;
			 		var2[1]=0;
			 		for(new j=0;j<13;j++)
			 		{
			 		    GetPlayerWeaponData(i,j,var,var2[2]);
			 		    if(var2[2]==69)
							var2[0]++;
						else if(var2[2]==198)
						    var2[1]++;
			 		}

					if(var2[0]>=MAX_CHECKS || var2[1]>=MAX_CHECKS)
					{
					    ResetPlayerWeapons(i);
					    JB_Kick(i,"Ammohack");
	        			continue;
					}
				}

			    if(GetPlayerSpecialAction(i)==SPECIAL_ACTION_USEJETPACK && JB_Variables[JETPACK])
			    {
					JB_Ban(i,"Using jetpack");
			        continue;
			    }

				if(JB_Variables[HEALTH_HACK])
				{
				    GetPlayerHealth(i,health);
				    if(health>100.0)
				    {
				        JB_Ban(i,"Health hack");
				        continue;
				    }
				}

				if(JB_Variables[ARMOUR_HACK])
				{
				    GetPlayerArmour(i,armour);
				    if(armour>100.0)
				    {
				        JB_Ban(i,"Armour hack");
				        continue;
				    }
				}
			}

			if(pstate && (!JB_IsPlayerAdmin(i) || !JB_Variables[ADMIN_IMMUNITY]))
			{
				JB_PlayerInfo[i][JB_pPing][JB_PlayerInfo[i][JB_pPingCheckProgress]]=GetPlayerPing(i);
				JB_PlayerInfo[i][JB_pPingCheckProgress]++;
				if(JB_PlayerInfo[i][JB_pPingCheckProgress]==MAX_PING_CHECKS)
				{
				    if(JB_Variables[MAX_PING])
				    {
						var=0;
						for(new j=0;j<MAX_PING_CHECKS;j++)
						    var+=JB_PlayerInfo[i][JB_pPing][j];
						var/=MAX_PING_CHECKS;
						if(var>JB_Variables[MAX_PING])
						{
							format(reason,sizeof(reason),"Too high ping. [%d/%d]",var,JB_Variables[MAX_PING]);
							JB_Kick(i,reason);
							continue;
						}
				    }
				    JB_PlayerInfo[i][JB_pPingCheckProgress]=0;
				}
			}

			JB_PlayerInfo[i][JB_pCurrentPos][0]=x;
			JB_PlayerInfo[i][JB_pCurrentPos][1]=y;
			JB_PlayerInfo[i][JB_pCurrentPos][2]=z;
			JB_PlayerInfo[i][JB_pLastCheck]=GetTickCount();
	    }
	}
	return 1;
}


//==============================================================================

stock SplitIp(ip_string[])
{
	//-1 = * = Range
	//-2 = invalid
	new ip[4]={-2,-2,-2,-2},string[16],c;
	format(string,sizeof(string),ip_string);

	for(new i=0;i<strlen(string);i++)
	{
		if(string[i]=='.')
		{
		    string[i]=' ';
			c++;
		}
	}
	
	if(c==3)
	{
		new idx,tmp[32],len;
		for(new i=0;i<4;i++)
		{
		    tmp=JB_strtok(string,idx);
		    len=strlen(tmp);
		    if(tmp[0]=='*' && len==1)
		        ip[i]=-1;
			else if(len>0)
			{
			    if(JB_IsNumeric(tmp))
			    {
					ip[i]=strval(tmp);
					if(ip[i]>255 || ip[i]<0)
					    ip[i]=(-2);
				}
				else
				    ip[i]=(-2);
			}
		}
	}
	return ip;
}

stock IpBanCheck(playerid)
{
	new ip[4];
	ip=SplitIp(JB_ReturnPlayerIp(playerid));
	for(new i=0;i<sizeof(IpBans);i++)
	    if(IpBanned[i])
			if(IsSameIpEx(IpBans[i],ip))
			    return 1;
	return 0;
}

stock IsSameIp(ip1[4],ip2[4])
{
 	for(new i=0;i<4;i++)
		if(ip1[i]!=ip2[i] || ip1[i]<0)
		    return 0;
	return 1;
}

stock IsSameIpEx(ip1[4],ip2[4])// Check for range-ban
{
	for(new i=0;i<4;i++)
		if((ip1[i]!=ip2[i] || ip1[i]<(-1)) && ip1[i]!=-1 && ip2[i]!=-1)
		    return 0;
	return 1;
}


Public:BanIp(ip_string[])
{
    new ip[4];
	ip=SplitIp(ip_string);
	printf("IP: %d.%d.%d.%d",ip[0],ip[1],ip[2],ip[3]);
	for(new i=0;i<sizeof(IpBans);i++)
	{
	    if(!IpBanned[i])
	    {
			IpBanned[i]=true;
			IpBans[i]=ip;
			JB_LogEx("IP %s has been banned.",ip_string);
            SaveIpBans();
			ForEachPlayer(j)
		        if(IsSameIpEx(ip,SplitIp(JB_ReturnPlayerIp(j))))
		            JB_Kick(j,"IP has been banned");
			return 1;
	    }
	}
	JB_LogEx("Could not ban IP %s!",ip_string);
	return 0;
}

Public:UnbanIp(ip_string[])
{
	new ip[4];
	ip=SplitIp(ip_string);
	for(new i=0;i<sizeof(IpBans);i++)
	{
	    if(IsSameIp(IpBans[i],ip))
	    {
			IpBanned[i]=false;
			JB_LogEx("IP %s has been unbanned.",ip_string);
			SaveIpBans();
			return 1;
	    }
	}
	JB_LogEx("Could not unban IP %s!",ip_string);
	return 0;
}

Public:SaveIpBans()
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
	return fclose(f);
}

Public:LoadIpBans()
{
    if(DOF_FileExists(IP_BAN_FILE))
	{
	    for(new i=0;i<sizeof(IpBans);i++)
	        IpBanned[i]=false;

	    new File:f=fopen(IP_BAN_FILE, io_read),c,string[16];
	    while(fread(f,string,sizeof(string)) && c<sizeof(IpBans))
	    {
	        JB_StripNewLine(string);
	        if(strlen(string))
	        {
				IpBans[c]=SplitIp(string);
				IpBanned[c]=true;
				c++;
			}
	    }
	    fclose(f);
		JB_LogEx("%d IP-bans have been loaded.",c);
	    return 1;
	}
	else
		DOF_CreateFile(IP_BAN_FILE);
	JB_Log("Could not load IP-bans!");
	return 0;
}

//==============================================================================

Public:LoadBlacklist()
{
	if(DOF_FileExists(BLACKLIST_FILE))
	{
	    for(new i=0;i<sizeof(Blacklist);i++)
	        Blacklist[i][0]=0;

	    new File:f=fopen(BLACKLIST_FILE, io_read),c,string[MAX_PLAYER_NAME];
	    while(fread(f,string,sizeof(string)) && c<sizeof(Blacklist))
	    {
	        JB_StripNewLine(string);
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
	else
		DOF_CreateFile(BLACKLIST_FILE);
	JB_Log("Could not load blacklist!");
	return 0;
}

Public:UpdateBlacklist()
{
	fremove(BLACKLIST_FILE);
	new string[MAX_PLAYER_NAME+2];
	new File:f=fopen(BLACKLIST_FILE,io_append);
	for(new i=0;i<sizeof(Blacklist);i++)
	{
	    if(!isnull(Blacklist[i]))
	    {
			format(string,sizeof(string),"%s\r\n",Blacklist[i]);
			fwrite(f,string);
		}
	}
	JB_Log("Blacklist has been updated.");
	return fclose(f);
}

Public:AddNameToBlacklist(name[])
{
	new success;
	for(new i=0;i<sizeof(Blacklist);i++)
	{
	    if(isnull(Blacklist[i]))
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

Public:RemoveNameFromBlacklist(name[])
{
	new success;
	for(new i=0;i<sizeof(Blacklist);i++)
	{
	    if(!isnull(Blacklist[i]))
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

Public:AddPlayerToBlacklist(playerid)
{
	if(AddNameToBlacklist(JB_ReturnPlayerName(playerid)))
		return JB_Ban(playerid,"Blacklist");
	return 0;
}

stock IsPlayerOnBlacklist(playerid)
{
	new name[MAX_PLAYER_NAME];
	name=JB_ReturnPlayerName(playerid);
	for(new i=0;i<sizeof(Blacklist);i++)
	{
	    if(!isnull(Blacklist[i]))
	        if(!strcmp(name,Blacklist[i],false))
	            return true;
	}
	return false;
}

//==============================================================================

Public:LoadWhitelist()
{
	if(DOF_FileExists(WHITELIST_FILE))
	{
	    for(new i=0;i<sizeof(Whitelist);i++)
	        Whitelist[i][0]=0;

	    new File:f=fopen(WHITELIST_FILE, io_read),c,string[MAX_PLAYER_NAME];
	    while(fread(f,string,sizeof(string)) && c<sizeof(Whitelist))
	    {
	        JB_StripNewLine(string);
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
	else
		DOF_CreateFile(WHITELIST_FILE);
	JB_Log("Could not load whitelist!");
	return 0;
}

Public:UpdateWhitelist()
{
	fremove(WHITELIST_FILE);
	new string[MAX_PLAYER_NAME+2];
	new File:f=fopen(WHITELIST_FILE,io_append);
	for(new i=0;i<sizeof(Whitelist);i++)
	{
	    if(!isnull(Whitelist[i]))
	    {
			format(string,sizeof(string),"%s\r\n",Whitelist[i]);
			fwrite(f,string);
		}
	}
	JB_Log("Whitelist has been updated.");
	return fclose(f);
}

Public:AddNameToWhitelist(name[])
{
	new success;
	for(new i=0;i<sizeof(Whitelist);i++)
	{
	    if(isnull(Whitelist[i]))
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

Public:RemoveNameFromWhitelist(name[])
{
	new success;
	for(new i=0;i<sizeof(Whitelist);i++)
	{
	    if(!isnull(Whitelist[i]))
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

Public:AddPlayerToWhitelist(playerid)
{
	return AddNameToWhitelist(JB_ReturnPlayerName(playerid));
}

stock IsPlayerOnWhitelist(playerid)
{
	new name[MAX_PLAYER_NAME];
	name=JB_ReturnPlayerName(playerid);
	for(new i=0;i<sizeof(Whitelist);i++)
	{
	    if(!isnull(Whitelist[i]))
	        if(!strcmp(name,Whitelist[i],false))
	            return true;
	}
	return false;
}

//==============================================================================

stock TempBanCheck(playerid)
{
	new name[MAX_PLAYER_NAME],ip[16],ys=GetSecond();
	name=JB_ReturnPlayerName(playerid);
	ip=JB_ReturnPlayerIp(playerid);
	for(new i=0;i<sizeof(TempBanInfo);i++)
	{
	    if(TempBanInfo[i][tbTime])
	    {
	        if(!strcmp(TempBanInfo[i][tbName],name,false))
			{
			    if(TempBanInfo[i][tbTime]>ys)
			    {
			        new days,hours,minutes,seconds,string[128];
			        SecondsToDHMS(TempBanInfo[i][tbTime]-ys,days,hours,minutes,seconds);
					TempBanInfo[i][tbIp]=ip;
					format(string,sizeof(string),"JunkBuster: You are temporary for %d day(s), %d hour(s), %d minute(s) and %d second(s)!",days,hours,minutes,seconds);
					SendClientMessage(playerid,JB_RED,string);
	                JB_LogEx("%s (%s) has been banned for Ban evading.",name,ip);
					BanEx(playerid,"Ban evading");
					return 1;
				}
				else
			    	TempBanInfo[i][tbTime]=0;
			}
	    }
	}
	return 0;
}

Public:TempBan(playerid,days,reason[])
{
	if(days>0)
	{
		new name[MAX_PLAYER_NAME],ip[16];
		name=JB_ReturnPlayerName(playerid);
		ip=JB_ReturnPlayerIp(playerid);
	    for(new i=0;i<sizeof(TempBanInfo);i++)
		{
			if(!TempBanInfo[i][tbTime])
			{
			    TempBanInfo[i][tbTime]=GetSecond()+(days*24*60*60);
			    TempBanInfo[i][tbIp]=ip;
			    TempBanInfo[i][tbName]=name;
			    new string[32];
			    format(string,sizeof(string),"%s [%d day(s)]",reason,days);
				JB_Ban(playerid,string);
				SaveTempBans();
				return 1;
			}
		}
	}
	return 0;
}

Public:DeleteTempBan(name[])
{
	for(new i=0;i<sizeof(TempBanInfo);i++)
	{
		if(TempBanInfo[i][tbTime])
		{
		    if(!strcmp(TempBanInfo[i][tbName],name,false))
		    {
				new string[16];
			    TempBanInfo[i][tbTime]=0;
				format(string,sizeof(string),"unbanip %s",TempBanInfo[i][tbIp]);
				SendRconCommand(string);
				JB_LogEx("Player '%s' (%s) has been unbanned.",name,TempBanInfo[i][tbIp]);
				SaveTempBans();
				return 1;
			}
		}
	}
	return 0;
}

Public:LoadTempBans()
{
	if(DOF_FileExists(TEMP_BAN_FILE))
	{
	    new File:f=fopen(TEMP_BAN_FILE, io_read),c,string[64];
	    while(fread(f,string,sizeof(string)) && c<sizeof(TempBanInfo))
	    {
	        JB_StripNewLine(string);
			if(!isnull(string))
			    if(!JB_sscanf(string,"iss",TempBanInfo[c][tbTime],TempBanInfo[c][tbIp],TempBanInfo[c][tbName]))
			        c++;
	    }
	    fclose(f);
	    JB_LogEx("%d temporary bans have been loaded.",c);
	    return 1;
	}
	else
		DOF_CreateFile(TEMP_BAN_FILE);
	JB_Log("Could not load temporary bans!");
	return 0;
}

Public:SaveTempBans()
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
	return fclose(f);
}

Public:TempBanUpdate()
{
    new string[32],ys=GetSecond();
    for(new i=0;i<sizeof(TempBanInfo);i++)
	{
		if(TempBanInfo[i][tbTime] && TempBanInfo[i][tbTime]<ys)
		{
		    TempBanInfo[i][tbTime]=0;
		    format(string,sizeof(string),"unbanip %s",TempBanInfo[i][tbIp]);
			SendRconCommand(string);
			JB_LogEx("Player '%s' (%s) has been unbanned.",TempBanInfo[i][tbName],TempBanInfo[i][tbIp]);
		}
	}
	SaveTempBans();
	return 1;
}

//==============================================================================

Public:LoadBadWords()
{
	if(DOF_FileExists(BAD_WORDS_FILE))
	{
	    new File:f=fopen(BAD_WORDS_FILE, io_read),c,string[32];
	    while(fread(f,string,sizeof(string)) && c<MAX_BAD_WORDS)
	    {
	        JB_StripNewLine(string);
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
	else
		DOF_CreateFile(BAD_WORDS_FILE);
	JB_Log("Could not load bad words!");
	return 0;
}

Public:LoadForbiddenWeapons()
{
	if(DOF_FileExists(FORBIDDEN_WEAPONS_FILE))
	{
	    new File:f=fopen(FORBIDDEN_WEAPONS_FILE, io_read),c,string[32];
	    while(fread(f,string,sizeof(string)) && c<MAX_FORBIDDEN_WEAPONS)
	    {
	        JB_StripNewLine(string);
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
	else
		DOF_CreateFile(FORBIDDEN_WEAPONS_FILE);
	JB_Log("Could not load forbidden weapons!");
	return 0;
}

Public:ConfigJunkBuster()
{
	if(!DOF_FileExists(CONFIG_FILE))
	    DOF_CreateFile(CONFIG_FILE);

    for(new i=0;i<MAX_JB_VARIABLES;i++)
    {
        if(DOF_IsSet(CONFIG_FILE,JB_VariableNames[i]))
            JB_Variables[i]=DOF_GetInt(CONFIG_FILE,JB_VariableNames[i]);
		else
		    DOF_SetInt(CONFIG_FILE,JB_VariableNames[i],JB_Variables[i]);
	}
	DOF_SaveFile();

    print("\n");
    JB_Log("Current JunkBuster configuration:");
    for(new i=0;i<MAX_JB_VARIABLES;i++)
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

Public:SaveJunkBusterVars()
{
    if(!DOF_FileExists(CONFIG_FILE))
	    DOF_CreateFile(CONFIG_FILE);

    for(new i=0;i<MAX_JB_VARIABLES;i++)
    	DOF_SetInt(CONFIG_FILE,JB_VariableNames[i],JB_Variables[i]);
	DOF_SaveFile();
	
	JB_Log("Current JunkBuster configuration:");
    for(new i=0;i<MAX_JB_VARIABLES;i++)
        JB_LogEx("- %s = %d",JB_VariableNames[i],JB_Variables[i]);

	print("\n");
    JB_Log("JunkBuster configuration has been saved to file.");
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
	new jb_date[32],jb_day,jb_month,jb_year;
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

static stock JB_ReturnPlayerName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,sizeof(name));
	return name;
}

static stock JB_ReturnPlayerIp(playerid)
{
	new ip[16];
	GetPlayerIp(playerid,ip,sizeof(ip));
	return ip;
}

stock SecondsToDHMS(value,&days,&hours,&minutes,&seconds)
{
	days=value/(24*60*60);
	hours=(value-(days*24*60*60))/(60*60);
	minutes=(value-(days*24*60*60)-(hours*60*60))/60;
	seconds=value-(days*24*60*60)-(hours*60*60)-(minutes*60);
	return 1;
}

stock GetSecond()
{
	new
		day,
		month,
		year,
		hour,
		minute,
		second,
		value;

	getdate(year,month,day);
	gettime(hour,minute,second);

	value=60*60*24*365*(year-2010);
	value+=second;
	value+=minute*60;
	value+=hour*60*60;

	value+=(day-1)*24*60*60;
	for(new i=0;i<(month-1);i++)
	    value+=MonthDays[i]*24*60*60;
	return value;
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

stock JB_IsNumeric(string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
		if ((string[i] > '9' || string[i] < '0') || (string[i]=='-' && i!=0))
			return 0;
	return 1;
}

stock JB_StripNewLine(string[])
{
	new len = strlen(string);
	if (string[0]==0) return ;
	if ((string[len - 1] == '\n') || (string[len - 1] == '\r')) {
		string[len - 1] = 0;
		if (string[0]==0) return ;
		if ((string[len - 2] == '\n') || (string[len - 2] == '\r')) string[len - 2] = 0;
	}
}

//==============================================================================

Public:GetPlayerFPS(playerid)
{
	new fps;
	for(new i=0;i<MAX_FPS_INDEX;i++)
	    fps+=JB_PlayerInfo[playerid][JB_pFPS][i];
	return (fps/MAX_FPS_INDEX);
}

//==============================================================================

stock JB_GetPlayerSpeed(playerid,get3d)
{
	new Float:x,Float:y,Float:z;
	if(IsPlayerInAnyVehicle(playerid))
	    GetVehicleVelocity(GetPlayerVehicleID(playerid),x,y,z);
	else
	    GetPlayerVelocity(playerid,x,y,z);

	return JB_Speed(x,y,z,100.0,get3d);
}

stock JB_GetVehicleName(vehicleid)
{
	new name[32],modelid=GetVehicleModel(vehicleid)-400;
	if(modelid<0 || modelid>=sizeof(JB_VehicleNames))
	    format(name,sizeof(name),"Unknown");
	else
	    format(name,sizeof(name),JB_VehicleNames[modelid]);
	return name;
}

stock JB_GetSquareDistance(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2)
{
	x1-=x2;
	y1-=y2;
	z1-=z2;
	x1*=x1;
	y1*=y1;
	z1*=z1;
	return floatround(x1+y1+z1);
}

//==============================================================================

stock AddPlayer(playerid)
{
	if(ConnectedPlayers>=MAX_PLAYERS)
	    return 0;

	ConnectedPlayerList[ConnectedPlayers++]=playerid;
	return 1;
}

stock RemovePlayer(playerid)
{
	for(new i=0;i<ConnectedPlayers;i++)
	{
	    if(ConnectedPlayerList[i]==playerid)
	    {
	        ConnectedPlayers--;
	        ConnectedPlayerList[i]=ConnectedPlayerList[ConnectedPlayers];
	        return 1;
	    }
	}
	return 0;
}

//==============================================================================

//From Cueball's "Zones By ~Cueball~ - V 2.0" (added JB_ tag so there should no redefinitions exist when compiling)
stock JB_GetPlayer2DZone(playerid, zone[], len) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(JB_gSAZones); i++ )
 	{
		if(x >= JB_gSAZones[i][JB_SAZONE_AREA][0] && x <= JB_gSAZones[i][JB_SAZONE_AREA][3] && y >= JB_gSAZones[i][JB_SAZONE_AREA][1] && y <= JB_gSAZones[i][JB_SAZONE_AREA][4])
		{
		    format(zone, len, JB_gSAZones[i][JB_SAZONE_NAME], 0);
		    return i;

		}
	}
	return 0;
}

//==============================================================================

ShowPlayerConfigDialog(playerid)
{
	ShowPlayerDialog(playerid,DIALOG_CFG,DIALOG_STYLE_LIST,"JunkBuster","Set a variable\nLoad configuration from file\nSave configuration to file","Choose","Close");
}

ShowPlayerVarlistDialog(playerid)
{
    new string[512];
    for(new i=0;i<MAX_JB_VARIABLES;i++)
		format(string,sizeof(string),"%s%s = %d\n",string,JB_VariableNames[i],JB_Variables[i]);

    ShowPlayerDialog(playerid,DIALOG_VARLIST,DIALOG_STYLE_LIST,"JunkBuster variables",string,"Choose","Go back");
}

ShowPlayerSetvarDialog(playerid,var)
{
	new string[64];
	format(string,sizeof(string),"JunkBuster variable: %s = %d",JB_VariableNames[var],JB_Variables[var]);
	ShowPlayerDialog(playerid,DIALOG_SETVAR+var,DIALOG_STYLE_INPUT,string,JB_VarDescription[var],"Set var","Go back");
}

//==============================================================================

public OnPlayerSpawn(playerid)
{
    JB_PlayerInfo[playerid][JB_pFullyConnected]=true;
    JB_PlayerInfo[playerid][JB_pNoTeleportCheck]=3;
    JB_PlayerInfo[playerid][JB_pFreezed]=false;
    if(JB_PlayerInfo[playerid][JB_pAntiBugKilled])
    {
        new varname1[32],varname2[32],weaponid;
    	for(new i=0;i<13;i++)
	    {
	        format(varname1,sizeof(varname1),"JB_ABK_Weapon%02d",i);
	        format(varname2,sizeof(varname2),"JB_ABK_Ammo%02d",i);
	        weaponid=GetPVarInt(playerid,varname1);
	        if(!JB_PlayerInfo[playerid][JB_pWeaponForbidden][weaponid])
	        	GivePlayerWeapon(playerid,weaponid,GetPVarInt(playerid,varname2));
	        DeletePVar(playerid,varname1);
	        DeletePVar(playerid,varname2);
		}

		SetPlayerPos(playerid,GetPVarFloat(playerid,"JB_ABK_PosX"),GetPVarFloat(playerid,"JB_ABK_PosY"),GetPVarFloat(playerid,"JB_ABK_PosZ"));
     	SetPlayerFacingAngle(playerid,GetPVarFloat(playerid,"JB_ABK_Angle"));
     	SetPlayerHealth(playerid,GetPVarFloat(playerid,"JB_ABK_Health"));
     	SetPlayerArmour(playerid,GetPVarFloat(playerid,"JB_ABK_Armour"));
     	SetPlayerVirtualWorld(playerid,GetPVarInt(playerid,"JB_ABK_World"));
     	SetPlayerInterior(playerid,GetPVarInt(playerid,"JB_ABK_Interior"));
     	SetPlayerTime(playerid,GetPVarInt(playerid,"JB_ABK_Hour"),GetPVarInt(playerid,"JB_ABK_Minute"));
     	SetTimerEx("JB_PutPlayerInVehicle",500,false,"iii",playerid,GetPVarInt(playerid,"JB_ABK_VehicleID"),GetPVarInt(playerid,"JB_ABK_Seat"));
     	
		DeletePVar(playerid,"JB_ABK_PosX");
     	DeletePVar(playerid,"JB_ABK_PosY");
     	DeletePVar(playerid,"JB_ABK_PosZ");
     	DeletePVar(playerid,"JB_ABK_Angle");
     	DeletePVar(playerid,"JB_ABK_Health");
     	DeletePVar(playerid,"JB_ABK_Armour");
     	DeletePVar(playerid,"JB_ABK_World");
     	DeletePVar(playerid,"JB_ABK_Interior");
     	DeletePVar(playerid,"JB_ABK_VehicleID");
     	DeletePVar(playerid,"JB_ABK_Seat");
     	DeletePVar(playerid,"JB_ABK_Hour");
     	DeletePVar(playerid,"JB_ABK_Minute");

        JB_PlayerInfo[playerid][JB_pAntiBugKilled]=false;
        return 1;
	}

	for(new i=0;i<MAX_WEAPONS;i++)
	{
	    JB_PlayerInfo[playerid][JB_pOldAmmo][i]=0;
		JB_PlayerInfo[playerid][JB_pLastWeaponUsed][i]=GetTickCount()-5000;
		JB_PlayerInfo[playerid][JB_pOldWeapon]=0;
	}
    return CallLocalFunction("JB_OnPlayerSpawn","i",playerid);
}

public OnPlayerUpdate(playerid)
{
	new update=1;
	if(JB_g_HasJBOPU)
	    update=CallLocalFunction("JB_OnPlayerUpdate","i",playerid);//I wonder if this is really a good idea^^

	if(JB_Variables[MIN_FPS] && (!JB_IsPlayerAdmin(playerid) || !JB_Variables[ADMIN_IMMUNITY]))// Copy, Paste & Edit from JernejL's tutorial.
	{
		new drunklevel=GetPlayerDrunkLevel(playerid);
	    if(drunklevel<100)
	        SetPlayerDrunkLevel(playerid, 2000);
	    else
		{
	        if(JB_PlayerInfo[playerid][JB_pLastDrunkLevel]!=drunklevel)
			{
	            new fps=JB_PlayerInfo[playerid][JB_pLastDrunkLevel]-drunklevel;
	            if (fps>0 && fps<200)
	                JB_PlayerInfo[playerid][JB_pFPS][JB_PlayerInfo[playerid][JB_pFPSIndex]]=fps;
	            JB_PlayerInfo[playerid][JB_pLastDrunkLevel]=drunklevel;
	        }
			JB_PlayerInfo[playerid][JB_pFPSIndex]++;
			if(JB_PlayerInfo[playerid][JB_pFPSIndex]>=MAX_FPS_INDEX)
			    JB_PlayerInfo[playerid][JB_pFPSIndex]=0;
	    }
	}
	
	new weaponid=GetPlayerWeapon(playerid);
	if(JB_Variables[NO_RELOAD] || (!JB_IsPlayerAdmin(playerid) || !JB_Variables[ADMIN_IMMUNITY]))
	{
	    new t=GetTickCount(),ammo=GetPlayerAmmo(playerid);
	    if((t-JB_PlayerInfo[playerid][JB_pLastWeaponUsed][weaponid])>4000)//Player may just have changed to another weapon without reloading and he doesn't want to abuse bugs.
	        JB_PlayerInfo[playerid][JB_pAmmoUsed][weaponid]=0;
	        
		if(JB_PlayerInfo[playerid][JB_pOldWeapon]==weaponid)//same weapon.
		{
		    if(GetPlayerWeaponState(playerid)==WEAPONSTATE_RELOADING || ammo<0 || ammo>9999 || GetPlayerState(playerid)!=PLAYER_STATE_ONFOOT)
		        JB_PlayerInfo[playerid][JB_pAmmoUsed][weaponid]=0;
		    else
		    {
		        new ammoused;
		        if(!JB_PlayerInfo[playerid][JB_pOldAmmo][weaponid])
		            JB_PlayerInfo[playerid][JB_pAmmoUsed][weaponid]=0;
				else
		        {
		        	ammoused=(JB_PlayerInfo[playerid][JB_pOldAmmo][weaponid]-ammo);
		        	if(ammoused<0)
						ammoused=0;
						
					JB_PlayerInfo[playerid][JB_pAmmoUsed][weaponid]+=ammoused;
					if(JB_PlayerInfo[playerid][JB_pAmmoUsed][weaponid]<0)
					    JB_PlayerInfo[playerid][JB_pAmmoUsed][weaponid]=0;
				}
				
				if(JB_PlayerInfo[playerid][JB_pAmmoUsed][weaponid]>(AmmoAmount[weaponid]*2) && ammoused>0)//Player must have switch weapons fast or doesn't reload at all
				{
				    new reason[64];
				    JB_Warnings[playerid][NO_RELOAD]++;
				    if(JB_Variables[NO_RELOAD]==1 && (JB_Warnings[playerid][NO_RELOAD]==10 || JB_Warnings[playerid][NO_RELOAD]==20 || JB_Warnings[playerid][NO_RELOAD]==30))
					{
					    GetWeaponName(weaponid,reason,sizeof(reason));
					    JunkBusterReport(playerid,"no reload",reason);
					}
					else if(JB_Warnings[playerid][NO_RELOAD]>=JB_Variables[NO_RELOAD])
				    {
				        GetWeaponName(weaponid,reason,sizeof(reason));
						format(reason,sizeof(reason),"Not reloading (%s)",reason);
				        JB_Kick(playerid,reason);
				        return 0;
				    }
				}
			}
		}
		JB_PlayerInfo[playerid][JB_pOldAmmo][weaponid]=ammo;
		JB_PlayerInfo[playerid][JB_pLastWeaponUsed][weaponid]=t;
		JB_PlayerInfo[playerid][JB_pOldWeapon]=weaponid;
	}

	if(JB_Variables[DISABLE_BAD_WEAPONS])
	{
		if(weaponid>=43 && weaponid<=45)//Camera & goggles are bugged...
		    return 0;
	}
	return update;
}

public OnPlayerDeath(playerid,killerid,reason)
{
	if(JB_PlayerInfo[playerid][JB_pAntiBugKilled])
	    return 0;
	    
	if(killerid!=INVALID_PLAYER_ID)
	{
	    new Float:x,Float:y,Float:z;
	    GetPlayerPos(playerid,x,y,z);
	    if(IsPlayerInRangeOfPoint(killerid,50.0,x,y,z))
	    {
		    if(JB_Variables[DRIVE_BY] && GetPlayerState(killerid)==PLAYER_STATE_DRIVER && (reason==WEAPON_UZI || reason==WEAPON_MP5 || reason==WEAPON_TEC9))
			{
			    SetPlayerHealth(killerid,0.0);
			    SendClientMessage(killerid,JB_RED,"JunkBuster: You have been killed for drive-by!");
			}

			if(JB_Variables[SPAWNKILL])
			{
			    if(JB_PlayerInfo[playerid][JB_pSpawnKillProtected])
		        {
		            JB_Warnings[killerid][SPAWNKILL]++;
		            if(JB_Warnings[killerid][SPAWNKILL]>=JB_Variables[SPAWNKILL])
						JB_Kick(killerid,"Excessive spawnkilling");
					else
						JB_SendFormattedMessage(killerid,JB_RED,"JunkBuster: Do not spawnkill! (Warning %d/%d)",JB_Warnings[killerid][SPAWNKILL],JB_Variables[SPAWNKILL]);
				}
		 	}
		}
 	}
	return CallLocalFunction("JB_OnPlayerDeath","iii",playerid,killerid,reason);
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	JB_PlayerInfo[playerid][JB_pNoTeleportCheck]=3;
	return CallLocalFunction("JB_OnPlayerInteriorChange","iii",playerid, newinteriorid, oldinteriorid);
}

#if defined FILTERSCRIPT

    public OnFilterScriptInit()
	{
		//Removes a stupid warning
		new _source[4]="?";
		ret_memcpy(_source,0,1);
		#pragma unused _source

		DOF_RemoveFile(BAD_RCON_LOGIN_FILE);
		DOF_CreateFile(BAD_RCON_LOGIN_FILE);

		JB_g_HasJBOPCS = funcidx("JB_OnPlayerCommandReceived") != -1;
		JB_g_HasJBOPCE = funcidx("JB_OnPlayerCommandPerformed") != -1;
		JB_g_HasJBOPU = funcidx("JB_OnPlayerUpdate") != -1;
		JB_g_HasJBOPT = funcidx("JB_OnPlayerText") != -1;

		ConfigJunkBuster();
		SetTimer("JunkBuster",1000,true);
		SetTimer("GlobalUpdate",60*1000*4,true);// Every 4 minutes
		SetTimer("SpamUpdate",3500,true);
		SetTimer("TempBanUpdate",1000*60*15,true);// Every 15 minutes
		if(JB_Variables[WARN_PLAYERS])
		    SendRconCommand("mapname JunkBuster Anti-Cheat");
		JB_Log("JunkBuster has successfully been loaded.");
		return CallLocalFunction("JB_OnFilterScriptInit","");
	}

	public OnFilterScriptExit()
	{
		SaveIpBans();
		SaveTempBans();
		DOF_Exit();
	    return CallLocalFunction("JB_OnFilterScriptExit","");
	}
	
#else

	public OnGameModeInit()
	{
		//Removes a stupid warning
		new _source[4]="?";
		ret_memcpy(_source,0,1);
		#pragma unused _source

		DOF_RemoveFile(BAD_RCON_LOGIN_FILE);
		DOF_CreateFile(BAD_RCON_LOGIN_FILE);

		JB_g_HasJBOPCS = funcidx("JB_OnPlayerCommandReceived") != -1;
		JB_g_HasJBOPCE = funcidx("JB_OnPlayerCommandPerformed") != -1;
		JB_g_HasJBOPU = funcidx("JB_OnPlayerUpdate") != -1;
		JB_g_HasJBOPT = funcidx("JB_OnPlayerText") != -1;

		ConfigJunkBuster();
		SetTimer("JunkBuster",1000,true);
		SetTimer("GlobalUpdate",60*1000*4,true);// Every 4 minutes
		SetTimer("SpamUpdate",3500,true);
		SetTimer("TempBanUpdate",1000*60*15,true);// Every 15 minutes
		if(JB_Variables[WARN_PLAYERS])
		    SendRconCommand("mapname JunkBuster Anti-Cheat");
		JB_Log("JunkBuster has successfully been loaded.");
		return CallLocalFunction("JB_OnGameModeInit","");
	}

	public OnGameModeExit()
	{
		SaveIpBans();
		SaveTempBans();
		DOF_Exit();
	    return CallLocalFunction("JB_OnGameModeExit","");
	}

#endif

public OnPlayerConnect(playerid)
{
	JB_PlayerInfo[playerid][JB_pKickBan]=false;
	JB_PlayerInfo[playerid][JB_pFullyConnected]=false;
    JB_PlayerInfo[playerid][JB_pAntiBugKilled]=false;
    
	if(TempBanCheck(playerid) && JB_Variables[TEMP_BANS])
	{
	    JB_PlayerInfo[playerid][JB_pKickBan]=true;
	    return 0;
	}

	if(IpBanCheck(playerid) && !IsPlayerOnWhitelist(playerid) && JB_Variables[IP_BANS])
	{
	    JB_PlayerInfo[playerid][JB_pKickBan]=true;
	    SendClientMessage(playerid,JB_RED,"JunkBuster: You are banned from this server!");
	    JB_LogEx("%s (%s) has been kicked for Banned IP.",JB_ReturnPlayerName(playerid),JB_ReturnPlayerIp(playerid));
	    Kick(playerid);
	    return 0;
	}

	if(IsPlayerOnBlacklist(playerid) && JB_Variables[BLACKLIST])
	{
	    JB_PlayerInfo[playerid][JB_pKickBan]=true;
	    SendClientMessage(playerid,JB_RED,"JunkBuster: You are banned from this server!");
	    JB_LogEx("%s (%s) has been banned for Ban evading.",JB_ReturnPlayerName(playerid),JB_ReturnPlayerIp(playerid));
	    BanEx(playerid,"Ban evading");
	    return 0;
	}
	
	if(!IsPlayerNPC(playerid))
		AddPlayer(playerid);

	for(new i=0;i<MAX_JB_VARIABLES;i++)
	    JB_Warnings[playerid][i]=0;

	ResetForbiddenWeaponsForPlayer(playerid);
	JB_PlayerInfo[playerid][JB_pLastMessage][0]=0;
	JB_PlayerInfo[playerid][JB_pMessageRepeated]=0;
	JB_PlayerInfo[playerid][JB_pMessages]=0;
	JB_PlayerInfo[playerid][JB_pCommands]=0;
    JB_PlayerInfo[playerid][JB_pNoTeleportCheck]=0;
    JB_PlayerInfo[playerid][JB_pPingCheckProgress]=0;
	JB_PlayerInfo[playerid][JB_pVehicleEntered]=INVALID_VEHICLE_ID;
	JB_PlayerInfo[playerid][JB_pMuted]=0;
	JB_PlayerInfo[playerid][JB_pFreezed]=false;
	for(new i=0;i<MAX_FPS_INDEX;i++)
	    JB_PlayerInfo[playerid][JB_pFPS][i]=JB_Variables[MIN_FPS]+1;
	
	if(JB_Variables[WARN_PLAYERS])
	{
		SendClientMessage(playerid,JB_GREEN_BLUE,"> This server is running JunkBuster Anti-Cheat!");
		SendClientMessage(playerid,JB_GREEN_BLUE,"> You may not cheat otherwise you'll get kicked/banned.");
	}
	return CallLocalFunction("JB_OnPlayerConnect","i",playerid);
}

public OnPlayerDisconnect(playerid,reason)
{
    JB_PlayerInfo[playerid][JB_pFullyConnected]=false;
	if(JB_PlayerInfo[playerid][JB_pKickBan])
	    return 0;
	    
	if(JB_PlayerInfo[playerid][JB_pAntiBugKilled])
	{
	    new varname1[32],varname2[32];
    	for(new i=0;i<13;i++)
	    {
	        format(varname1,sizeof(varname1),"JB_ABK_Weapon%02d",i);
	        format(varname2,sizeof(varname2),"JB_ABK_Ammo%02d",i);
	        DeletePVar(playerid,varname1);
	        DeletePVar(playerid,varname2);
		}
		
	    DeletePVar(playerid,"JB_ABK_PosX");
     	DeletePVar(playerid,"JB_ABK_PosY");
     	DeletePVar(playerid,"JB_ABK_PosZ");
     	DeletePVar(playerid,"JB_ABK_Angle");
     	DeletePVar(playerid,"JB_ABK_Health");
     	DeletePVar(playerid,"JB_ABK_Armour");
     	DeletePVar(playerid,"JB_ABK_World");
     	DeletePVar(playerid,"JB_ABK_Interior");
     	DeletePVar(playerid,"JB_ABK_VehicleID");
     	DeletePVar(playerid,"JB_ABK_Seat");
     	DeletePVar(playerid,"JB_ABK_Hour");
     	DeletePVar(playerid,"JB_ABK_Minute");
     	JB_PlayerInfo[playerid][JB_pAntiBugKilled]=false;
	}
	    
    RemovePlayer(playerid);
	return CallLocalFunction("JB_OnPlayerDisconnect","ii",playerid,reason);
}

public OnPlayerText(playerid, text[])
{
	if(JB_PlayerInfo[playerid][JB_pMuted] && JB_Variables[SPAM])
	{
	    JB_SendFormattedMessage(playerid,JB_RED,"JunkBuster: You are not allowed to chat for %d second(s) because you have been muted!",JB_PlayerInfo[playerid][JB_pMuted]);
	    return 0;
	}

	if(!JB_IsPlayerAdmin(playerid) || !JB_Variables[ADMIN_IMMUNITY])
	{
		if(!isnull(JB_PlayerInfo[playerid][JB_pLastMessage]))
		{
		    if(!strcmp(text,JB_PlayerInfo[playerid][JB_pLastMessage],false))
		        JB_PlayerInfo[playerid][JB_pMessageRepeated]++;
			else
			    JB_PlayerInfo[playerid][JB_pMessageRepeated]=0;
		}
		else
		    JB_PlayerInfo[playerid][JB_pMessageRepeated]=0;

		format(JB_PlayerInfo[playerid][JB_pLastMessage],128,text);
	    JB_PlayerInfo[playerid][JB_pMessages]++;
	    if(!JB_PlayerInfo[playerid][JB_pMuted] && JB_Variables[SPAM])
	    {
	        if(JB_PlayerInfo[playerid][JB_pMessages]>15)
		    {
		        JB_Ban(playerid,"Extreme spam");
		        return 0;
		    }
		    else if(JB_PlayerInfo[playerid][JB_pMessages]>10)
		    {
		        JB_Kick(playerid,"Massive spam");
		        return 0;
		    }
		    else if(JB_PlayerInfo[playerid][JB_pMessages]>4 || JB_PlayerInfo[playerid][JB_pMessageRepeated]>=MAX_CHECKS)
		    {
		        JB_PlayerInfo[playerid][JB_pMessageRepeated]=0;
		        MutePlayer(playerid,2*60,"Spam");
			    return 0;
			}
		}
		
		if(CheckText(playerid,text))
		    return 0;
	}
	if(JB_g_HasJBOPT)
		return CallLocalFunction("JB_OnPlayerText","is",playerid,text);
	return 1;
}

public OnPlayerCommandReceived(playerid,cmdtext[])
{
	JB_PlayerInfo[playerid][JB_pCommands]++;
	if(JB_Variables[COMMAND_SPAM] && (!JB_IsPlayerAdmin(playerid) || !JB_Variables[ADMIN_IMMUNITY]))
    {
        if(JB_PlayerInfo[playerid][JB_pCommands]>15)
	    {
	        JB_Ban(playerid,"Extreme command spam");
	        return 0;
	    }
	    else if(JB_PlayerInfo[playerid][JB_pCommands]>5)
	    {
	        JB_Kick(playerid,"Command spam");
	        return 0;
	    }
    }
    
    if(JB_g_HasJBOPCS)
		return CallLocalFunction("JB_OnPlayerCommandReceived","is",playerid,cmdtext);
	return 1;
}

public OnPlayerCommandPerformed(playerid,cmdtext[],success)
{
	if(JB_g_HasJBOPCE)
	    return CallLocalFunction("JB_OnPlayerCommandPerformed","isi",playerid,cmdtext,success);//JunkBuster command performed.
	else if(!success)//Script hasn't ZCMD anywhere else and there was no JunkBuster command performed by ZCMD, so OnPlayerCommandText must be performed.
	    return CallLocalFunction("JB_OnPlayerCommandText","is",playerid,cmdtext);
	return 1;//JunkBuster command performed.
}

COMMAND:myfps(playerid,params[])
{
	#pragma unused params
	if(!JB_Variables[MIN_FPS])
	    return SendClientMessage(playerid,JB_RED,"This function has been disabled!");
	    
	new string[32];
	format(string,sizeof(string),"Your FPS: %d",GetPlayerFPS(playerid));
	SendClientMessage(playerid,JB_GREEN_BLUE,string);
	return 1;
}

COMMAND:abktest(playerid,params[])
{
    #pragma unused params
    if(!IsPlayerAdmin(playerid))
        return 0;

	AntiBugKill(playerid);
	return 1;
}
			    
COMMAND:jbcmds(playerid,params[])
{
    #pragma unused params
    if(!IsPlayerAdmin(playerid))
        return 0;
        
	new string[1024];
	for(new i=0;i<sizeof(JB_AdminCommands);i++)
	    format(string,sizeof(string),"%s%s\n",string,JB_AdminCommands[i]);
	    
	ShowPlayerDialog(playerid,DIALOG_CMDS,DIALOG_STYLE_LIST,"JunkBuster Commands",string,"Perform","Close");
    /*
	SendClientMessage(playerid,JB_GREEN_BLUE,"Available commands:");
    SendClientMessage(playerid,JB_GREEN," /jbcfg, /blackadd <ID/name>, /blackdel <name>, /whiteadd <name>, /whitedel <name>");
    SendClientMessage(playerid,JB_GREEN," /tban <ID> <time in hours> <reason>, /tunban <name>, /banIP <IP>, /unbanIP <IP>");
    SendClientMessage(playerid,JB_GREEN," /jbvarlist, /jbsetvar <variable name> <0/1(/max ping)>");
	*/
    return 1;
}

COMMAND:jbcfg(playerid,params[])
{
    #pragma unused params
    if(!IsPlayerAdmin(playerid))
        return 0;

    ShowPlayerConfigDialog(playerid);
	return 1;
}

COMMAND:blackadd(playerid,params[])
{
    if(!IsPlayerAdmin(playerid))
        return 0;
        
	new id;
    if(JB_sscanf(params,"u",id))
		return SendClientMessage(playerid,JB_RED,"Usage: /blackadd <ID/name>");
		
	if(!IsPlayerConnected(id))
	{
	    if(AddNameToBlacklist(params))
	        JB_SendFormattedMessage(playerid,JB_GREEN,"JunkBuster: Player '%s' has successfully been added to blacklist!",params);
		else
		    JB_SendFormattedMessage(playerid,JB_RED,"JunkBuster: Could not add player '%s' to blacklist!",params);
	}
	else
	{
	    if(id!=playerid)
	    {
		    if(AddPlayerToBlacklist(id))
		        JB_SendFormattedMessage(playerid,JB_GREEN,"JunkBuster: Player '%s' has successfully been added to blacklist!",params);
			else
			    JB_SendFormattedMessage(playerid,JB_RED,"JunkBuster: Could not add player '%s' to blacklist!",params);
		}
	}
	return 1;
}

COMMAND:blackdel(playerid,params[])
{
    if(!IsPlayerAdmin(playerid))
        return 0;
        
    if(!isnull(params))
    {
	    if(RemoveNameFromBlacklist(params))
	        JB_SendFormattedMessage(playerid,JB_GREEN,"JunkBuster: Player '%s' has successfully been removed from blacklist!",params);
		else
		    JB_SendFormattedMessage(playerid,JB_RED,"JunkBuster: Could not remove player '%s' from blacklist!",params);
		return 1;
	}
	return SendClientMessage(playerid,JB_RED,"Usage: /blackdel <name>");
}

COMMAND:whiteadd(playerid,params[])
{
    if(!IsPlayerAdmin(playerid))
        return 0;
        
	if(!isnull(params))
    {
		if(AddNameToWhitelist(params))
	        JB_SendFormattedMessage(playerid,JB_GREEN,"JunkBuster: Player '%s' has successfully been added to whitelist!",params);
		else
		    JB_SendFormattedMessage(playerid,JB_RED,"JunkBuster: Could not add player '%s' to whitelist!",params);
		return 1;
	}
	return SendClientMessage(playerid,JB_RED,"Usage: /whiteadd <name>");
}

COMMAND:whitedel(playerid,params[])
{
    if(!IsPlayerAdmin(playerid))
        return 0;

	if(!isnull(params))
    {
	    if(RemoveNameFromWhitelist(params))
	        JB_SendFormattedMessage(playerid,JB_GREEN,"JunkBuster: Player '%s' has successfully been removed from whitelist!",params);
		else
		    JB_SendFormattedMessage(playerid,JB_RED,"JunkBuster: Could not remove player '%s' from whitelist!",params);
		return 1;
	}
	return SendClientMessage(playerid,JB_RED,"Usage: /whitedel <name>");
}

COMMAND:jbvarlist(playerid,params[])
{
    #pragma unused params
    if(!IsPlayerAdmin(playerid))
        return 0;

    ShowPlayerVarlistDialog(playerid);
	return 1;
}

COMMAND:jbsetvar(playerid,params[])
{
    if(!IsPlayerAdmin(playerid))
        return 0;

	new var[32],value;
	if(JB_sscanf(params,"si",var,value))
		return SendClientMessage(playerid,JB_RED,"Usage: /jbsetvar <variable name> <0/1(/max ping)>");
	    
    if(!isnull(var))
    {
        if(value>=0)
		{
		    for(new i=0;i<MAX_JB_VARIABLES;i++)
		    {
		        if(!strcmp(var,JB_VariableNames[i],true))
		        {
		            JB_Variables[i]=value;
		            JB_SendFormattedMessage(playerid,JB_GREEN,"JunkBuster: JunkBuster variable '%s' has successfully been set to %d.",JB_VariableNames[i],JB_Variables[i]);
                    JB_LogEx("%s has set variable '%s' to %d.",JB_ReturnPlayerName(playerid),JB_VariableNames[i],JB_Variables[i]);
					break;
				}
		    }
		}
    }
	return 1;
}

COMMAND:tban(playerid,params[])
{
    if(!IsPlayerAdmin(playerid))
        return 0;

    new id,days,reason[128];
    if(JB_sscanf(params,"iiz",id,days,reason))
		return SendClientMessage(playerid,JB_RED,"Usage: /tban <ID> <days> <reason>");
    
    if(IsPlayerConnected(id) && id!=playerid && days>0 && !isnull(reason))
    {
		TempBan(id,days,reason);
		return 1;
    }
	return SendClientMessage(playerid,JB_RED,"Usage: /tban <ID> <days> <reason>");
}

COMMAND:tunban(playerid,params[])
{
    if(!IsPlayerAdmin(playerid))
        return 0;

    if(!isnull(params))
    {
        if(DeleteTempBan(params))
            JB_SendFormattedMessage(playerid,JB_GREEN,"JunkBuster: Temporary ban of player '%s' has successfully been deleted.",params);
		else
		    JB_SendFormattedMessage(playerid,JB_RED,"JunkBuster: Could not delete temporary ban of player '%s'!",params);
		return 1;
    }
    return SendClientMessage(playerid,JB_RED,"Usage: /tunban <name>");
}

COMMAND:banip(playerid,params[])
{
    if(!IsPlayerAdmin(playerid))
        return 0;

    if(!isnull(params))
    {
		new ip[4];
		ip=SplitIp(params);
        if(ip[0]!=(-2) && ip[1]!=(-2) && ip[2]!=(-2) && ip[3]!=(-2))
        {
            if(BanIp(params))
                JB_SendFormattedMessage(playerid,JB_GREEN,"JunkBuster: IP %s has successfully been banned!",params);
			else
			    JB_SendFormattedMessage(playerid,JB_RED,"JunkBuster: Could not ban IP %s!",params);
			return 1;
        }
    }
    return SendClientMessage(playerid,JB_RED,"Usage: /banIP <IP>");
}

COMMAND:unbanip(playerid,params[])
{
    if(!IsPlayerAdmin(playerid))
        return 0;

    if(!isnull(params))
    {
		new ip[4];
		ip=SplitIp(params);
        if(ip[0]!=(-2) && ip[1]!=(-2) && ip[2]!=(-2) && ip[3]!=(-2))
        {
            if(UnbanIp(params))
                JB_SendFormattedMessage(playerid,JB_GREEN,"JunkBuster: IP %s has successfully been unbanned!",params);
			else
			    JB_SendFormattedMessage(playerid,JB_RED,"JunkBuster: Could not unban IP %s!",params);
			return 1;
        }
    }
    return SendClientMessage(playerid,JB_RED,"Usage: /unbanIP <IP>");
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    new Float:x,Float:y,Float:z;
    GetVehiclePos(vehicleid,x,y,z);
    if(!IsPlayerInRangeOfPoint(playerid,350.0,x,y,z))
        JunkBusterReport(playerid,"spawning vehicles",JB_GetVehicleName(vehicleid));//Counting warnings would be non-sense.

	JB_PlayerInfo[playerid][JB_pVehicleEntered]=vehicleid;
	return CallLocalFunction("JB_OnPlayerEnterVehicle","iii",playerid, vehicleid, ispassenger);
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    JB_PlayerInfo[playerid][JB_pFullyConnected]=true;
	if(JB_Variables[SPECTATE_HACK] && newstate==PLAYER_STATE_SPECTATING && !JB_IsPlayerAdmin(playerid))
	    JB_Ban(playerid,"Spectate hack");

	new vehicleid=GetPlayerVehicleID(playerid);
	if(newstate==PLAYER_STATE_DRIVER)
	{
	    new Float:health;
	    GetVehicleHealth(vehicleid,health);
	    if(health>1000.0)//Prevent innoncent players getting banned because of vehicle used by the cheaters
		    SetVehicleHealth(vehicleid,1000.0);
	    
		if(JB_PlayerInfo[playerid][JB_pVehicleEntered]!=vehicleid && (!JB_IsPlayerAdmin(playerid) || !JB_Variables[ADMIN_IMMUNITY]))
		{
			new used;
			ForEachPlayer(i)
			{
			    if(i!=playerid)
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
				    if(JB_Warnings[playerid][CAR_JACK_HACK]>=MAX_CHECKS)
			    		JB_Kick(playerid,"Carjack hack");
				}
				else
				    JunkBusterReport(playerid,"carjack hack","no details");
			}
		}
	}

	if(oldstate==PLAYER_STATE_PASSENGER)
	    JB_PlayerInfo[playerid][JB_pNoTeleportCheck]=3;//Do not check position for 3 seconds to prevent lag kick.

	JB_PlayerInfo[playerid][JB_pVehicleEntered]=INVALID_VEHICLE_ID;
	JB_PlayerInfo[playerid][JB_pSpeedhacking]=0;
	JB_PlayerInfo[playerid][JB_pAirbreaking]=0;
	return CallLocalFunction("JB_OnPlayerStateChange","iii",playerid, newstate, oldstate);
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(JB_Variables[CBUG] && GetPlayerState(playerid)==PLAYER_STATE_ONFOOT && (!JB_IsPlayerAdmin(playerid) || !JB_Variables[ADMIN_IMMUNITY]))
	{
	    switch(GetPlayerWeapon(playerid))
		{
		    case 24,25,27,29,30,31,33,34://Deagle, Shotung, SPAS12, MP5, AK47, M4, Rifle, Sniper Rifle
		    {
				if((newkeys & KEY_FIRE) || (newkeys==KEY_FIRE))
				    JB_PlayerInfo[playerid][JB_pFired]=GetTickCount();
				else if(((oldkeys & KEY_FIRE) || (oldkeys==KEY_FIRE)) && ((newkeys & KEY_CROUCH) || (newkeys==KEY_CROUCH)) && (GetTickCount()-JB_PlayerInfo[playerid][JB_pFired])<750)
				{
				    JB_Warnings[playerid][CBUG]++;
					if(JB_Warnings[playerid][CBUG]==JB_Variables[CBUG]/4 || JB_Warnings[playerid][CBUG]==JB_Variables[CBUG]/2)
						SendClientMessage(playerid,JB_RED,"JunkBuster: Please stop performing the C-Bug or you will get kicked/banned.");
					else if(JB_Warnings[playerid][CBUG]>=JB_Variables[CBUG])
					    JB_Kick(playerid,"C-Bug");
				}
			}
		}
	}
	return CallLocalFunction("JB_OnPlayerKeyStateChange","iii",playerid, newkeys, oldkeys);
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new len=strlen(inputtext);
	for(new i=0;i<len;i++)
	    if(inputtext[i]=='%')
	        inputtext[i]='#';
	        
	if(IsPlayerAdmin(playerid))
	{
	    switch(dialogid)
		{
		    case DIALOG_CMDS:
		    {
				if(response)
				    CallLocalFunction("OnPlayerCommandText","is",playerid,JB_AdminCommands[listitem]);
		        return 1;
		    }

			case DIALOG_CFG:
			{
				if(response)
				{
				    switch(listitem)
				    {
				        case 0:
				            ShowPlayerVarlistDialog(playerid);

				        case 1:
				        {
				            ConfigJunkBuster();
				    		SendClientMessage(playerid,JB_GREEN,"JunkBuster: Configuration has been loaded from file.");
				    		ShowPlayerConfigDialog(playerid);
				        }

				        case 2:
				        {
				            SaveJunkBusterVars();
				    		SendClientMessage(playerid,JB_GREEN,"JunkBuster: Configuration has been saved to file.");
				    		ShowPlayerConfigDialog(playerid);
				        }
				    }
				}
				return 1;
			}

			case DIALOG_VARLIST:
			{
			    if(response)
			    	ShowPlayerSetvarDialog(playerid,listitem);
			    else
			        ShowPlayerConfigDialog(playerid);
				return 1;
			}

			case DIALOG_SETVAR .. (DIALOG_SETVAR+MAX_JB_VARIABLES-1):
			{
			    if(response)
			    {
			        new var=dialogid-DIALOG_SETVAR,setvar=strval(inputtext);
			        if(isnull(inputtext) || !JB_IsNumeric(inputtext) || setvar<0)
				        ShowPlayerSetvarDialog(playerid,var);
					else
					{
	                    JB_Variables[var]=setvar;
			            JB_SendFormattedMessage(playerid,JB_GREEN,"JunkBuster: JunkBuster variable '%s' has successfully been set to %d.",JB_VariableNames[var],JB_Variables[var]);
						JB_LogEx("%s has set variable '%s' to %d.",JB_ReturnPlayerName(playerid),JB_VariableNames[var],JB_Variables[var]);
						ShowPlayerVarlistDialog(playerid);
					}
			    }
			    else
				    ShowPlayerVarlistDialog(playerid);
			    return 1;
			}
		}
	}
	
	if(!len)
		return CallLocalFunction("JB_OnDialogResponse","iiiis",playerid, dialogid, response, listitem, "\1");
    return CallLocalFunction("JB_OnDialogResponse","iiiis",playerid, dialogid, response, listitem, inputtext);
}

public OnRconLoginAttempt( ip[], password[], success)
{
	if(!success)
	{
	    new attempts=DOF_GetInt(BAD_RCON_LOGIN_FILE,ip);
		attempts++;
		if(attempts>=MAX_CHECKS)
		{
		    new cmd[32];
		    format(cmd,sizeof(cmd),"banip %s",ip);
		    SendRconCommand(cmd);
		    JB_LogEx("Banning IP %s for too many failed RCON-logins.",ip);
		}
		JB_LogEx("IP %s attempted to log in as RCON-admin with password '%s'.",ip,password);
		DOF_SetInt(BAD_RCON_LOGIN_FILE,ip,attempts);
		DOF_SaveFile();
	}
	else
	    JB_LogEx("IP %s has logged in as RCON-admin",ip);
	return CallLocalFunction("JB_OnRconLoginAttempt","ssi",ip,password,success);
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(!JB_PlayerInfo[playerid][JB_pNoTeleportCheck] && (!JB_IsPlayerAdmin(playerid) || !JB_Variables[ADMIN_IMMUNITY]))
	{
	    if(JB_Variables[CHECKPOINT_TELEPORT])
	    {
            if(!JB_GetPlayerSpeed(playerid,false))
		    {
		        JB_Warnings[playerid][CHECKPOINT_TELEPORT]++;
		        if(JB_Warnings[playerid][CHECKPOINT_TELEPORT]>=MAX_CHECKS)
		            JB_Ban(playerid,"Using teleport cheats: Checkpoint teleport");
				else
				{
				    new string[128];
				    format(string,sizeof(string),"checkpoint teleport (Warning %d)",JB_Warnings[playerid][CHECKPOINT_TELEPORT]);
				    JunkBusterReport(playerid,"teleport cheats",string);
				}
		    }
	    }
	}
	return CallLocalFunction("JB_OnPlayerEnterRaceCP","i",playerid);
}

stock JB_sscanf(string[], format[], {Float,_}:...)
{
	#if defined isnull
		if (isnull(string))
	#else
		if (string[0] == 0 || (string[0] == 1 && string[1] == 0))
	#endif
		{
			return format[0];
		}
	#pragma tabsize 4
	new
		formatPos = 0,
		stringPos = 0,
		paramPos = 2,
		paramCount = numargs(),
		delim = ' ';
	while (string[stringPos] && string[stringPos] <= ' ')
	{
		stringPos++;
	}
	while (paramPos < paramCount && string[stringPos])
	{
		switch (format[formatPos++])
		{
			case '\0':
			{
				return 0;
			}
			case 'i', 'd':
			{
				new
					neg = 1,
					num = 0,
					ch = string[stringPos];
				if (ch == '-')
				{
					neg = -1;
					ch = string[++stringPos];
				}
				do
				{
					stringPos++;
					if ('0' <= ch <= '9')
					{
						num = (num * 10) + (ch - '0');
					}
					else
					{
						return -1;
					}
				}
				while ((ch = string[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num * neg);
			}
			case 'h', 'x':
			{
				new
					num = 0,
					ch = string[stringPos];
				do
				{
					stringPos++;
					switch (ch)
					{
						case 'x', 'X':
						{
							num = 0;
							continue;
						}
						case '0' .. '9':
						{
							num = (num << 4) | (ch - '0');
						}
						case 'a' .. 'f':
						{
							num = (num << 4) | (ch - ('a' - 10));
						}
						case 'A' .. 'F':
						{
							num = (num << 4) | (ch - ('A' - 10));
						}
						default:
						{
							return -1;
						}
					}
				}
				while ((ch = string[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num);
			}
			case 'c':
			{
				setarg(paramPos, 0, string[stringPos++]);
			}
			case 'f':
			{

				new changestr[16], changepos = 0, strpos = stringPos;
				while(changepos < 16 && string[strpos] && string[strpos] != delim)
				{
					changestr[changepos++] = string[strpos++];
				}
				changestr[changepos] = '\0';
				setarg(paramPos,0,_:floatstr(changestr));
			}
			case 'p':
			{
				delim = format[formatPos++];
				continue;
			}
			case '\'':
			{
				new
					end = formatPos - 1,
					ch;
				while ((ch = format[++end]) && ch != '\'') {}
				if (!ch)
				{
					return -1;
				}
				format[end] = '\0';
				if ((ch = strfind(string, format[formatPos], false, stringPos)) == -1)
				{
					if (format[end + 1])
					{
						return -1;
					}
					return 0;
				}
				format[end] = '\'';
				stringPos = ch + (end - formatPos);
				formatPos = end + 1;
			}
			case 'u':
			{
				new
					end = stringPos - 1,
					id = 0,
					bool:num = true,
					ch;
				while ((ch = string[++end]) && ch != delim)
				{
					if (num)
					{
						if ('0' <= ch <= '9')
						{
							id = (id * 10) + (ch - '0');
						}
						else
						{
							num = false;
						}
					}
				}
				if (num && IsPlayerConnected(id))
				{
					setarg(paramPos, 0, id);
				}
				else
				{
     				string[end] = '\0';
					num = false;
					id = end - stringPos;
					ForEachPlayer(playerid)
					{
						if (!strcmp(JB_ReturnPlayerName(playerid), string[stringPos], true, id))
						{
							setarg(paramPos, 0, playerid);
							num = true;
							break;
						}
					}
					if (!num)
					{
						setarg(paramPos, 0, INVALID_PLAYER_ID);
					}
					string[end] = ch;
				}
				stringPos = end;
			}
			case 's', 'z':
			{
				new
					i = 0,
					ch;
				if (format[formatPos])
				{
					while ((ch = string[stringPos++]) && ch != delim)
					{
						setarg(paramPos, i++, ch);
					}
					if (!i)
					{
						return -1;
					}
				}
				else
				{
					while ((ch = string[stringPos++]))
					{
						setarg(paramPos, i++, ch);
					}
				}
				stringPos--;
				setarg(paramPos, i, '\0');
			}
			default:
			{
				continue;
			}
		}
		while (string[stringPos] && string[stringPos] != delim && string[stringPos] > ' ')
		{
			stringPos++;
		}
		while (string[stringPos] && (string[stringPos] == delim || string[stringPos] <= ' '))
		{
			stringPos++;
		}
		paramPos++;
	}
	do
	{
		if ((delim = format[formatPos++]) > ' ')
		{
			if (delim == '\'')
			{
				while ((delim = format[formatPos++]) && delim != '\'') {}
			}
			else if (delim != 'z')
			{
				return delim;
			}
		}
	}
	while (delim > ' ');
	return 0;
}

//==============================================================================

//Plug & Play:

#define GetPlayerMoney 				JB_GetPlayerMoney
#define ResetPlayerMoney 			JB_ResetPlayerMoney
#define GivePlayerMoney 			JB_GivePlayerMoney
#define SetPlayerMoney 				JB_SetPlayerMoney
#define PutPlayerInVehicle 			JB_PutPlayerInVehicle
#define GivePlayerWeapon 			JB_GivePlayerWeapon
#define SetPlayerPos 				JB_SetPlayerPos
#define SetVehiclePos 				JB_SetVehiclePos
#define SetPlayerHealth 			JB_SetPlayerHealth
#define SetPlayerArmour 			JB_SetPlayerArmour
#define SetVehicleHealth 			JB_SetVehicleHealth
#define TogglePlayerControllable 	JB_TogglePlayerControllable
#define SetVehicleVelocity 			JB_SetVehicleVelocity
#define SetPlayerSpecialAction 		JB_SetPlayerSpecialAction

//OnPlayerStateChange
#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange JB_OnPlayerStateChange
forward JB_OnPlayerStateChange(playerid, newstate, oldstate);

//OnPlayerKeyStateChange
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange JB_OnPlayerKeyStateChange
forward JB_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);

//OnPlayerEnterVehicle
#if defined _ALS_OnPlayerEnterVehicle
	#undef OnPlayerEnterVehicle
#else
	#define _ALS_OnPlayerEnterVehicle
#endif
#define OnPlayerEnterVehicle JB_OnPlayerEnterVehicle
forward JB_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);

//OnPlayerCommandText
#if defined _ALS_OnPlayerCommandText
	#undef OnPlayerCommandText
#else
	#define _ALS_OnPlayerCommandText
#endif
#define OnPlayerCommandText JB_OnPlayerCommandText
forward JB_OnPlayerCommandText(playerid, cmdtext[]);

//OnPlayerText
#if defined _ALS_OnPlayerText
	#undef OnPlayerText
#else
	#define _ALS_OnPlayerText
#endif
#define OnPlayerText JB_OnPlayerText
forward JB_OnPlayerText(playerid, text[]);

//OnPlayerUpdate
#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate JB_OnPlayerUpdate
forward JB_OnPlayerUpdate(playerid);

//OnPlayerConnect
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect JB_OnPlayerConnect
forward JB_OnPlayerConnect(playerid);

//OnPlayerDisconnect
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect JB_OnPlayerDisconnect
forward JB_OnPlayerDisconnect(playerid,reason);

#if defined FILTERSCRIPT

    //OnFilterScriptInit
	#if defined _ALS_OnFilterScriptInit
		#undef OnFilterScriptInit
	#else
		#define _ALS_OnFilterScriptInit
	#endif
	#define OnFilterScriptInit JB_OnFilterScriptInit
	forward JB_OnFilterScriptInit();

	//OnFilterScriptExit
	#if defined _ALS_OnFilterScriptExit
		#undef OnFilterScriptExit
	#else
		#define _ALS_OnFilterScriptExit
	#endif
	#define OnFilterScriptExit JB_OnFilterScriptExit
	forward JB_OnFilterScriptExit();
	
#else

	//OnGameModeInit
	#if defined _ALS_OnGameModeInit
		#undef OnGameModeInit
	#else
		#define _ALS_OnGameModeInit
	#endif
	#define OnGameModeInit JB_OnGameModeInit
	forward JB_OnGameModeInit();

	//OnGameModeExit
	#if defined _ALS_OnGameModeExit
		#undef OnGameModeExit
	#else
		#define _ALS_OnGameModeExit
	#endif
	#define OnGameModeExit JB_OnGameModeExit
	forward JB_OnGameModeExit();
	
#endif

//OnPlayerInteriorChange
#if defined _ALS_OnPlayerInteriorChange
	#undef OnPlayerInteriorChange
#else
	#define _ALS_OnPlayerInteriorChange
#endif
#define OnPlayerInteriorChange JB_OnPlayerInteriorChange
forward JB_OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid);

//OnPlayerDeath
#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif
#define OnPlayerDeath JB_OnPlayerDeath
forward JB_OnPlayerDeath(playerid,killerid,reason);

//OnPlayerSpawn
#if defined _ALS_OnPlayerSpawn
	#undef OnPlayerSpawn
#else
	#define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn JB_OnPlayerSpawn
forward JB_OnPlayerSpawn(playerid);

//OnDialogResponse
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif
#define OnDialogResponse JB_OnDialogResponse
forward JB_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);

//OnRconLoginAttempt
#if defined _ALS_OnRconLoginAttempt
	#undef OnRconLoginAttempt
#else
	#define _ALS_OnRconLoginAttempt
#endif
#define OnRconLoginAttempt JB_OnRconLoginAttempt
forward JB_OnRconLoginAttempt( ip[], password[], success );

//OnPlayerEnterRaceCheckpoint
#if defined _ALS_OnPlayerEnterRaceCP
	#undef OnPlayerEnterRaceCheckpoint
#else
	#define _ALS_OnPlayerEnterRaceCP
#endif
#define OnPlayerEnterRaceCheckpoint JB_OnPlayerEnterRaceCP
forward JB_OnPlayerEnterRaceCP(playerid);

//zcmd:
//OnPlayerCommandReceived
#if defined _ALS_OnPlayerCommandReceived
	#undef OnPlayerCommandReceived
#else
	#define _ALS_OnPlayerCommandReceived
#endif
#define OnPlayerCommandReceived JB_OnPlayerCommandReceived
forward JB_OnPlayerCommandReceived(playerid, cmdtext[]);

#if defined _ALS_OnPlayerCommandPerformed
	#undef OnPlayerCommandPerformed
#else
	#define _ALS_OnPlayerCommandPerformed
#endif
#define OnPlayerCommandPerformed JB_OnPlayerCommandPerformed
forward JB_OnPlayerCommandPerformed(playerid, cmdtext[], success);
