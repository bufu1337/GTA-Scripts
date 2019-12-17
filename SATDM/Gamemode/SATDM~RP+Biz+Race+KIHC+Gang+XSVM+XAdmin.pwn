//-----------------------------Credits go to:
//Some of the SF Classes by Cam
//Selection Screen Sounds by CodeMaster
//DM Messages by Yellowblood
//Xtreme Vehicle Management + Streamer by tAxI
//Multi Language Code by Yom
//Race Script by Yagu
//Kapils Instant House Constructions by Kapil
//Gang script taken from Jax's LVDM ~MoneyGrub(+LandGrab)
//Admin System by Xtreme - Incorporated by [SP]JESTER and jthebeast2007
//[CBK]MoNeYPiMp Made this
/*------------------------MULTI LANGUAGE FORMAT EXAMPLE!!!----------------------
    if((strcmp(cmdtext,"/help",true) == 0)||
	(strcmp(cmdtext,"/aide",true) == 0))
   	{
        switch (Language[playerid])
        {
            case 0:
            {
                SendClientMessage(playerid,0xFFD400AA,"HELP:");
                SendClientMessage(playerid,0xFFD400AA,"Type /lock to close your vehicle.");
                SendClientMessage(playerid,0xFFD400AA,"Type /unlock to open your vehicle.");
            }
            case 1:
            {
                SendClientMessage(playerid,0xFFD400AA,"AIDE:");
                SendClientMessage(playerid,0xFFD400AA,"Tape /lock pour fermer ton vehicule.");
                SendClientMessage(playerid,0xFFD400AA,"Tape /unlock pour ouvrir ton vehicule.");
            }
        }
        return 1;
    }
*/
//===============================Include Files==================================
#include <a_samp>
#include <dudb>
#include "xadmin/XtremeAdmin.inc"
#pragma tabsize 4
#pragma dynamic 568000
#pragma unused AddStaticHouse,LoadPly,OnPlayerEnterHousee,SavePly,SetHouseCost,GetHouseOwner

#define V_FILE_LOAD "SYS_SETUP/vehicles_stream_setup.PiMp"
#define B_FILE_LOAD "SYS_SETUP/businesses_stream_setup.PiMp"
#define V_FILE_SAVE "SYS_SAVE/vehicles_stream_perm.PiMp"
#define B_FILE_SAVE "SYS_SAVE/businesses_stream_perm.PiMp"
#define P_FILE "xadmin/Users/%s.ini"
#define B_ICON 1272
#define B_ICON_TYPE 2
#define PD_TIMER 1800000
#define CALL_UNIT_COST 1
#define DEFAULT_OWNER "[null]"
#define B_LIMIT 2000
#define RunOutTime 30000

#define COLOR_AQUA 0x7CFC00AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_INDIGO 0x4B00B0AA
#define yellow 0xFFFF00AA
#define green 0x33FF33AA
#define red 0xFF0000AA
#define white 0xFFFFFFAA
#define pink 0xCCFF00FFAA
#define blue 0x00FFFFAA
#define grey 0xC0C0C0AA
//===============================Class Defines==================================
#define TEAM_WORKER 0
#define TEAM_PIMP 1
#define TEAM_GOLFER 2
#define TEAM_TRIAD 3
#define TEAM_ARMY 4
#define TEAM_VALET 5
#define TEAM_MEDIC 6
#define TEAM_FBI 7
#define TEAM_CHICKEN 8
#define TEAM_RICH 9
#define TEAM_PILOT 10
#define TEAM_DANANG 11

#define TEAM_LVBALLA 12
#define TEAM_LVGROVE 13
#define TEAM_LVVAGO 14
#define TEAM_LVAZTEC 15
#define TEAM_LVTRIAD 16
#define TEAM_LVMEDIC 17
#define TEAM_LVFIRE 18
#define TEAM_LVCOP 19
#define TEAM_LVARMY 20
#define TEAM_LVCIV 21

#define TEAM_LSCOP 22
#define TEAM_LSCOP2 23
#define TEAM_LSGROVE 24
#define TEAM_LSGROVE2 25
#define TEAM_LSVAGO 26
#define TEAM_LSVAGO2 27
#define TEAM_LSAZTECA 28
#define TEAM_LSAZTECA2 29
#define TEAM_LSBALLA 30
#define TEAM_LSBALLA2 31
#define TEAM_LSPIZZABOY 32
//==============Experimental Streamer System Tokens and Symbols=================
#define MAX_MODEL_NUMBER 620
#define MAX_STREAM_VEHICLES 2500
#define MAX_ACTIVE_VEHICLES 695
#define MAX_ACTIVE_PICKUPS 250
#define MAX_ACTIVE_MODELS 68
#define MAX_ACTIVE_MM_ICONS 32
#define DEFAULT_SPAWN_DIST 200
#define PICKUP_TYPE_BIZ 2
#define PICKUP_TYPE_BANK 3
//=====================Xadmin===================================================
static Menu:GiveCar, Menu:Weather,ServerWeather = 0; forward PingKick();
//==============================================================================
new Vstreamcount = 0;
new vehused[MAX_ACTIVE_VEHICLES];
new MMstreamcount[MAX_PLAYERS];
new MIactive[MAX_PLAYERS][B_LIMIT];
new MIidnum[MAX_PLAYERS][B_LIMIT];
new PUstreamcount = 0;
new streamidn[MAX_PLAYERS];
new vstreamid[MAX_PLAYERS];
new avstream [MAX_ACTIVE_VEHICLES];

enum mmapinfo
{
	mmodel,
	Float:mx_spawn,
	Float:my_spawn,
	Float:mz_spawn,
	Float:mspawndist,
	mvalid,
};
new MapIconInfo[B_LIMIT][mmapinfo];

enum PInfo
{
	model,
	Float:x_spawn,
	Float:y_spawn,
	Float:z_spawn,
	spawned,
	idnum,
	valid,
	type,
};
new PickupInfo[B_LIMIT][PInfo];
//================================Text Draws====================================
new Text:vehiclehpbar[12];
new Text:stxt[MAX_PLAYERS];
new sstring[256];
//===============================Gang Defines===================================
#define MAX_GANGS 			32
#define MAX_GANG_MEMBERS	6
#define MAX_GANG_NAME       16
new gangMembers[MAX_GANGS][MAX_GANG_MEMBERS];
new gangNames[MAX_GANGS][MAX_GANG_NAME];
new gangInfo[MAX_GANGS][3]; //0-created,1-members,2-color
new gangBank[MAX_GANGS];
new playerGang[MAX_PLAYERS];
new gangInvite[MAX_PLAYERS];
forward PlayerLeaveGang(playerid);
//===========================Race Defines/Forwards==============================
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

#define MAX_RACECHECKPOINTS 64 // Change if you want more room for checkpoints than this
#define MAX_BUILDERS 4 // Change if you want more builderslots than this
#define RACEFILE_VERSION 2 // !!! DO NOT CHANGE !!!
#define MENUSYSTEM // Enable menus, comment to disable.

new MajorityDelay = 120; // Default delay to wait for other racers once half are ready (can be changed ingame via Admin menu)
new RRotation = -1;      // Is automatic Race Rotation enabled by defaul? (can be changed ingame via Admin menu) (-1 = disabled, 0+ = enabled)
new RRotationDelay = 300000; // How often will we poll for new race start if RRotation is enabled? (Default: 5 minutes, can't be changed IG)
new BuildAdmin = 1; //Require admin privileges for building races? 1)  yes, 0) no. (Can be changed ingame in Admin menu)
new RaceAdmin = 1;  //Require admin privileges for starting races? 1)  yes, 0) no. (Can be changed ingame in Admin menu)
new PrizeMode=0;        //Mode for winnings: 0 - Fixed, 1 - Dynamic, 2 - Entry fee, 3 - EF+F, 4 EF+D [Admin menu ingame]
new Prize=30000;        //Fixed prize sum (15,000$ for winner, 12,5000$ for 2nd and 10,000$ for 3rd) [Admin menu ingame]
new DynaMP=1;           //Dynamic prize multiplier. (Default: 1$/m) [Admin menu ingame]
new JoinFee=1000;       //Amount of $ it costs to /join a race      [Admin menu ingame]

#if defined MENUSYSTEM
forward RefreshMenuHeader(playerid,Menu:menu,text[]);
new Menu:MAdmin, Menu:MPMode, Menu:MPrize, Menu:MDyna, Menu:MBuild, Menu:MLaps;
new Menu:MRace, Menu:MRacemode, Menu:MFee, Menu:MCPsize, Menu:MDelay;
#endif

#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA

forward RaceRotation();
forward LockRacers();
forward UnlockRacers();
forward SaveScores();   				// After race, if new best times have been made, saves them.
forward GetRaceTick(playerid);			// Gets amount of ticks the player was racing
forward GetLapTick(playerid); 		 	// Gets amount of ticks the player spend on the lap
forward ReadyRefresh();      	  		// Check the /ready status of players and start the race when ready
forward RaceSound(playerid,sound);      // Plays <sound> for <playerid>
forward BActiveCP(playerid,sele);       // Gives the player selected checkpoint
forward endrace();                      // Ends the race, whether it ended normally or by /endrace. Cleans the variables.
forward countdown();                    // Handles the countdown
forward mscountdown();                  //Majority Start countdown handler
forward rstrtok(const string[],&index);
forward SetNextCheckpoint(playerid);    // Gives the next checkpoint for the player during race
forward CheckBestLap(playerid, laptime);	// Check if <laptime> is better than any of the ones in highscore list, and update.
forward CheckBestRace(playerid,racetime);   // Check if <racetime> is better than any of the ones in highscore list, and update.
forward ChangeLap(playerid);            // Change player's lap, print out time and stuff.
forward SetRaceCheckpoint(playerid,target,next);    // Race-mode checkpoint setter
forward SetBRaceCheckpoint(playerid,target,next);   // Builder-mode checkpoint  setter
forward LoadTimes(playerid,timemode,tmp[]);     // bestlap and bestrace-parameter race loader
forward IsNotAdmin(playerid);          // Is the player admin, if no, return 1 with an error message.
forward GetBuilderSlot(playerid);   // Get next free builderslot, return 0 if none available
forward b(playerid); 		       // Quick and dirty fix for the BuilderSlots
forward Float:Distance(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2);
forward clearrace(playerid);
forward startrace();
forward LoadRace(tmp[]);
forward CreateRaceMenus();
// General variables
new RotationTimer;
new ystring[128];    // ystring
new CBuilder[MAX_PLAYER_NAME], CFile[64], CRaceName[128];        //Creator of the race and the filename, for score changing purposes.
// Racing-related variables
new Pot=0;              //Join fees go here
new Ranking;            //Finishing order for prizes
new PrizeMP;            //Prize multiplier
new Countdown;          //Countdown timer
new cd;                 //Countdown time
new MajStart=0;         //Status of the Majority Start timer
new MajStartTimer;      //Majority Start timer
new mscd;               //Majority Start time
new RaceActive;         //Is a race active?
new RaceStart;          //Has race started?
new Float:RaceCheckpoints[MAX_RACECHECKPOINTS][3];  //Current race CP array
new LCurrentCheckpoint;                             //Current race array pointer
new CurrentCheckpoint[MAX_PLAYERS];                 //Current race array pointer array :V
new CurrentLap[MAX_PLAYERS];                        //Current lap array
new RaceParticipant[MAX_PLAYERS];                   //Has the player /joined the race
  // \_values: 0 - not in race, 1 - joined, 2 - arrived to start CP, 3 - /ready, 4 - racing, 5 - Last CP
new Participants;                                   //Amount of participants
new PlayerVehicles[MAX_PLAYERS];                    //For slapping the player back in their vehicle.
new ORacelaps, ORacemode;   //Saves the laps/mode from file in case they aren't changed
new OAirrace, Float:OCPsize;
new Racelaps, Racemode;		//If mode/laps has been changed, the new scores won't be saved.
new ScoreChange;            //Flag for new best times, so they are saved.
new RaceTick;               //Startime of the race
new LastLapTick[MAX_PLAYERS];       //Array that stores the times when players started the lap
new TopRacers[6][MAX_PLAYER_NAME]; // Stores 5 top scores, 6th isn't
new TopRacerTimes[6];              // saved to file, used to simplify
new TopLappers[6][MAX_PLAYER_NAME];// for() loops on CheckBestLap and
new TopLapTimes[6];                // CheckBestRace.
new Float:CPsize;                        // Checkpoint size for the race
new Airrace;                       // Is the race airrace?
new Float:RLenght, Float:LLenght; //Lap lenght and race lenght
// Building-related variables
new BCurrentCheckpoints[MAX_BUILDERS];               //Buildrace array pointers
new BSelectedCheckpoint[MAX_BUILDERS];               //Selected checkpoint during building
new RaceBuilders[MAX_PLAYERS];                       //Who is building a race?
new BuilderSlots[MAX_BUILDERS];                      //Stores the racebuilder pids
new Float:BRaceCheckpoints[MAX_BUILDERS][MAX_RACECHECKPOINTS][3]; //Buildrace CP array
new Bracemode[MAX_BUILDERS];
new Blaps[MAX_BUILDERS];
new Float:BCPsize[MAX_BUILDERS];
new BAirrace[MAX_BUILDERS];
//======================KIHC Statements/Forwards/Defines========================
new Float:HIX1[150];
new Float:HIY1[150];
new Float:HIZ1[150];
new Float:HOX1[150];
new Float:HOY1[150];
new Float:HOZ1[150];
new HII1[250];
new HDD[256];
new PIH1[200];
new hidd = 0;
new HP1[150];
new Menu:Hmen1;
new Menu:Hexit1;

forward GetHouseCost(houseid);
forward SetHouseOwner(houseid,hpname[]);

forward opem(playerid);
forward ogmi();
forward opct(playerid,cmdtext[]);
forward opsm(playerid,row);
forward oppp(playerid,pickupid);
#if defined MIC_INCLUDED
#endinput
#else
#endif
//==================================Forwards====================================
forward IsPlayerNameOnline(compname[]);
forward ParkVehicle(vehicleid);
forward resetmessage();
forward resetcount();
forward announcer();
forward CheckSpeedo();
forward BackupInfo();
forward GetDriverID(vehicleid);
forward SaveComponent(streamid,componentid);
forward SavePaintjob(streamid,paintjobid);
forward SaveColors(streamid,color1,color2);
forward PhoneCut();
forward KickTimer(playerid);
forward CallVehicleToPlayer(playerid);
forward ctimer();
forward ResetText(playerid);
forward PayDay();
forward VHPBarUpdate();
forward vehiclestreamer();
forward pickupstreamer();
forward minimapstreamer();
forward DeathProcess(vehicleid);
forward ModVehicle(streamid);
forward isPlayerInArea(playerID, Float:data[4]);
forward SystemMsg(playerid,msg[]);
forward GameModeExitFunc();
forward GetPlayers();
forward SetPlayerRandomSpawn(playerid);
//=================================Info stuff===================================
enum bInfo
{
	name[256],
	owner[256],
	bought,
	cost,
	profit,
	cashbox,
 	Float:xpos,
    Float:ypos,
    Float:zpos,
}

new BizInfo[B_LIMIT][bInfo];

enum pInfo
{
	name[256],
	vowned,
	vowner,
	bowner,
	bowned,
	pass,
	pcash,
	bank,
	logged,
	admin,
	team,
	frozen,
	jailed,
	vhpb,
}

new PlayerInfo[MAX_PLAYERS][pInfo];

enum vInfo
{
	limbo,
	fspawn,
	reset,
	model,
	Float:x_spawn,
	Float:y_spawn,
	Float:z_spawn,
 	Float:za_spawn,
 	color_1,
 	color_2,
 	owner[256],
	vehiclecost,
	vused,
	bought,
	secure,
	asecure,
	buybar,
	name[256],
	spawned,
	idnum,
	Float:spawndist,
 	valid,
	mod1,
	mod2,
	mod3,
	mod4,
	mod5,
	mod6,
	mod7,
	mod8,
	mod9,
	mod10,
	mod11,
	mod12,
	mod13,
	mod14,
	mod15,
	mod16,
	mod17,
	paintjob,
 	modding,
};

new bizmsg[MAX_PLAYERS];
new VehicleInfo[MAX_STREAM_VEHICLES][vInfo];
new bizcount = 0;
new vehcount = 0;
//============================Gang Zone Teams defines===========================
new Worker;
new Pimp;
new Golfer;
new Triad;
new Army;
new Valet;
new Medic;
new FBI;
new Chicken;
new Rich;
new Pilot;
new Pilot1;
new Pilot2;
new DaNang;
//============================Kill Timer Defines================================
new checktimer;
new backtimer;
new phonetimer;
new counttimer;
new paytimer;
new vstimer;
new mmstimer;
new pstimer;
//==============================Menu Defines====================================
new Menu:vehiclemain;
new Menu:playervm;
new Menu:buysell;
new Menu:secure1;
new Menu:secure2;
new Menu:templock;
new Menu:adminm;
new Menu:asecure1;
new Menu:asecure2;
new Menu:speedom;
new Menu:buyable;
new Menu:healthbar;
//================================Vehicle Defines===============================
new VehicleName[212][0] = {
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
   "Trailer", //artict1
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
   "Trailer", //artict2
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
   "Hotring Racer", //hotrina
   "Hotring Racer", //hotrinb
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
   "Tanker", //petro
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
   "Firetruck", //firela
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
   "Monster Truck", //monstera
   "Monster Truck", //monsterb
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
   "Freight", //freiflat
   "Trailer", //streakc
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
   "Trailer", //petrotr
   "Emperor",
   "Wayfarer",
   "Euros",
   "Hotdog",
   "Club",
   "Trailer", //freibox
   "Trailer", //artict3
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
   "Luggage Trailer", //bagboxa
   "Luggage Trailer", //bagboxb
   "Stair Trailer", //tugstair
   "Boxville",
   "Farm Plow", //farmtr1
   "Utility Trailer" //utiltr1
};

new	heavycar[24][0] = {
	{406},
	{444},
	{556},
	{557},
	{573},
	{601},
	{407},
	{427},
	{433},
	{434},
	{499},
	{498},
	{482},
	{431},
	{524},
	{578},
	{455},
	{403},
	{414},
	{443},
	{515},
	{428},
	{408},
	{456}
};
new	boat[11][0] = {
	{472},
	{473},
	{493},
	{595},
	{484},
	{430},
	{453},
	{452},
	{446},
	{454},
	{539}
};
new	mbike[11][0] = {
	{581},
	{521},
	{462},
	{463},
	{468},
	{471},
	{586},
	{522},
	{523},
	{461},
	{448}
};
new	pbike[3][0] = {
	{481},
	{509},
	{510}
};
new	splane[6][0] = {
	{593},
	{512},
	{513},
	{460},
	{464},
	{465}
};
new	mplane[2][0] = {
	{519},
	{511}
};
new	lplane[2][0] = {
	{553},
	{592}
};
new milair[4][0] = {
	{520},
	{476},
	{447},
	{425}
};
new sheli[4][0] = {
	{487},
	{488},
	{469},
	{497}
};
new lheli[3][0] = {
	{417},
	{548},
	{563}
};
//==============================Important vehicle defines=======================
new gPlayerClass[MAX_PLAYERS];
new tmpname[256];
new cCount[MAX_PLAYERS];
new passenger[MAX_PLAYERS];
new speedo[MAX_PLAYERS];
new aMessage[MAX_PLAYERS];
new tempid[MAX_PLAYERS];
new lockmess[MAX_STREAM_VEHICLES];
new securemess[MAX_STREAM_VEHICLES];
new carmess[999];

enum SavePlayerPosEnum
{
    Float:LastX,
    Float:LastY,
    Float:LastZ
}
new SavePlayerPos[MAX_PLAYERS][SavePlayerPosEnum];
//===============================Tuning Stuff===================================
new Float:ta, Float:tb, Float:tc;
new PlayerInterior[MAX_PLAYERS];
new tuned;
new cseconds,cstring[256];
new spoiler[20][0] = {
	{1000},
	{1001},
	{1002},
	{1003},
	{1014},
	{1015},
	{1016},
	{1023},
	{1058},
	{1060},
	{1049},
	{1050},
	{1138},
	{1139},
	{1146},
	{1147},
	{1158},
	{1162},
	{1163},
	{1164}
};

new nitro[3][0] = {
    {1008},
    {1009},
    {1010}
};

new fbumper[23][0] = {
    {1117},
    {1152},
    {1153},
    {1155},
    {1157},
    {1160},
    {1165},
    {1167},
    {1169},
    {1170},
    {1171},
    {1172},
    {1173},
    {1174},
    {1175},
    {1179},
    {1181},
    {1182},
    {1185},
    {1188},
    {1189},
    {1192},
    {1193}
};

new rbumper[22][0] = {
    {1140},
    {1141},
    {1148},
    {1149},
    {1150},
    {1151},
    {1154},
    {1156},
    {1159},
    {1161},
    {1166},
    {1168},
    {1176},
    {1177},
    {1178},
    {1180},
    {1183},
    {1184},
    {1186},
    {1187},
    {1190},
    {1191}
};

new exhaust[28][0] = {
    {1018},
    {1019},
    {1020},
    {1021},
    {1022},
    {1028},
    {1029},
    {1037},
    {1043},
    {1044},
    {1045},
    {1046},
    {1059},
    {1064},
    {1065},
    {1066},
    {1089},
    {1092},
    {1104},
    {1105},
    {1113},
    {1114},
    {1126},
    {1127},
    {1129},
    {1132},
    {1135},
    {1136}
};

new bventr[2][0] = {
    {1042},
    {1044}
};

new bventl[2][0] = {
    {1043},
    {1045}
};

new bscoop[4][0] = {
	{1004},
	{1005},
	{1011},
	{1012}
};

new rscoop[13][0] = {
    {1006},
    {1032},
    {1033},
    {1035},
    {1038},
    {1053},
    {1054},
    {1055},
    {1061},
    {1067},
    {1068},
    {1088},
    {1091}
};

new lskirt[21][0] = {
    {1007},
    {1026},
    {1031},
    {1036},
    {1039},
    {1042},
    {1047},
    {1048},
    {1056},
    {1057},
    {1069},
    {1070},
    {1090},
    {1093},
    {1106},
    {1108},
    {1118},
    {1119},
    {1133},
    {1122},
    {1134}
};

new rskirt[21][0] = {
    {1017},
    {1027},
    {1030},
    {1040},
    {1041},
    {1051},
    {1052},
    {1062},
    {1063},
    {1071},
    {1072},
    {1094},
    {1095},
    {1099},
    {1101},
    {1102},
    {1107},
    {1120},
    {1121},
    {1124},
    {1137}
};

new hydraulics[1][0] = {
    {1087}
};

new base[1][0] = {
    {1086}
};

new rbbars[2][0] = {
    {1109},
    {1110}
};

new fbbars[2][0] = {
    {1115},
    {1116}
};

new wheels[17][0] = {
    {1025},
    {1073},
    {1074},
    {1075},
    {1076},
    {1077},
    {1078},
    {1079},
    {1080},
    {1081},
    {1082},
    {1083},
    {1084},
    {1085},
    {1096},
    {1097},
    {1098}
};

new lights[2][0] = {
	{1013},
	{1024}
};
//===============================Phone Stuff====================================
new Calling[MAX_PLAYERS];
new Answered[MAX_PLAYERS];
new Callerid[MAX_PLAYERS];

new Float:Pickup[3][3] = {
{-22.2549,-55.6575,1003.5469},//banks
{-23.0664,-90.0882,1003.5469},
{-33.9593,-29.0792,1003.5573}
};
//===============================Random LV Spawns===============================
new iSpawnSet[MAX_PLAYERS];
new Float:gRandomPlayerSpawns[23][3] = {
{1958.3783,1343.1572,15.3746},
{2199.6531,1393.3678,10.8203},
{2483.5977,1222.0825,10.8203},
{2637.2712,1129.2743,11.1797},
{2000.0106,1521.1111,17.0625},
{2024.8190,1917.9425,12.3386},
{2261.9048,2035.9547,10.8203},
{2262.0986,2398.6572,10.8203},
{2244.2566,2523.7280,10.8203},
{2335.3228,2786.4478,10.8203},
{2150.0186,2734.2297,11.1763},
{2158.0811,2797.5488,10.8203},
{1969.8301,2722.8564,10.8203},
{1652.0555,2709.4072,10.8265},
{1564.0052,2756.9463,10.8203},
{1271.5452,2554.0227,10.8203},
{1441.5894,2567.9099,10.8203},
{1480.6473,2213.5718,11.0234},
{1400.5906,2225.6960,11.0234},
{1598.8419,2221.5676,11.0625},
{1318.7759,1251.3580,10.8203},
{1558.0731,1007.8292,10.8125},
//{-857.0551,1536.6832,22.5870},   Out of Town Spawns
//{817.3494,856.5039,12.7891},
//{116.9315,1110.1823,13.6094},
//{-18.8529,1176.0159,19.5634},
//{-315.0575,1774.0636,43.6406},
{1705.2347,1025.6808,10.8203}
};

new Float:gCopPlayerSpawns[2][3] = {
{2297.1064,2452.0115,10.8203},
{2297.0452,2468.6743,10.8203}
};
//===========================Character Selection Music==========================
#define SOUND_MUSIC1							1062
#define SOUND_MUSIC2							1068
#define SOUND_MUSIC3							1076
#define SOUND_OFF                    			1184
//=================================Team Colors==================================
#define COLOR_DARKGREEN 0x009600DD//NEW army Color
#define COLOR_GREEN 0x33AA33AA //SF Grove color
#define COLOR_RED 0xAA3333AA //SF Pimp color
#define COLOR_PINK 0xFF66FFAA //SF Triad color
#define COLOR_BLUE 0x0000BBAA //SF Mechanic color
#define COLOR_LIGHTBLUE 0x33CCFFAA //SF Pilot color
#define COLOR_ORANGE 0xFF9900AA //SF Swat color
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_PURPLE 0x330066AA
#define COLOR_GREY 0xCCCCCAA
#define COLOR_SKIN 0xFFCC99AA
#define COLOR_DARKGREY 0x333333AA
#define COLOR_DARKRED 0x990000AA
#define RED 0xFF0000AA
#define COLOR_INDIGO 0x4B00B0AA
#define COLOR_BRIGHTRED 0xDC143CAA
#define COLOR_AQUA 0x7CFC00AA
#define COLOR_DARKBLUE 0x0000BBFF
#define COLOR_BROWN 0x8B4513AA
#define COLOR_SYSTEM 0xEFEFF7AA
new playerColors[32] = {
COLOR_GREEN,COLOR_RED,COLOR_YELLOW,COLOR_PINK,COLOR_DARKGREEN,COLOR_LIGHTBLUE,COLOR_PURPLE,COLOR_ORANGE,
COLOR_GREY,COLOR_SKIN,COLOR_DARKGREY,COLOR_DARKRED,COLOR_DARKGREEN,COLOR_LIGHTBLUE,COLOR_BLUE,COLOR_YELLOW,
COLOR_RED,COLOR_ORANGE,COLOR_DARKBLUE,COLOR_BROWN,COLOR_WHITE,COLOR_BLUE,COLOR_BLUE,COLOR_GREEN,COLOR_GREEN,
COLOR_YELLOW,COLOR_YELLOW,COLOR_LIGHTBLUE,COLOR_LIGHTBLUE,COLOR_PURPLE,COLOR_PURPLE,COLOR_ORANGE
};
//==================================Defines=====================================
new KillerID[MAX_PLAYERS] = INVALID_PLAYER_ID;
new Menu:TK;
new Float:Pos[MAX_PLAYERS][4];
new Language[MAX_PLAYERS] = 0; //Initialyse with the Default Language = English
//================================Main Info=====================================
main()
{
	print(" ");
	print(">-----------------------------------------------------------------------<");
	print("| SATDM ~ Role-Play, Biz, Race, KIHC, Gang, XSVM and XAdmin by MoNeYPiMp|");
	print(">-----------------------------------------------------------------------<\n");
}
//==================================Exitded menu================================
public OnPlayerExitedMenu(playerid)
{
	TogglePlayerControllable(playerid, true);
	if(!IsValidMenu(GetPlayerMenu(playerid))) return 1;
	ShowMenuForPlayer(GetPlayerMenu(playerid), playerid);
	CallLocalFunction("opem","i",playerid);
	//print("onplayerexitmenu");
	new Menu:current = GetPlayerMenu(playerid);
	HideMenuForPlayer(current,playerid);
	if (current == Hexit1){
		ShowMenuForPlayer(Hexit1,playerid);
		TogglePlayerControllable(playerid,1);
	}
	return 1;
}
//=================================Phone stuff==================================
public PhoneCut()
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			if (Calling[i] > -1 && Answered[i] == 1 && Callerid[i] == 1)
			{
				if (GetPlayerMoney(i) >= CALL_UNIT_COST)
				{
					GivePlayerMoney(i, -CALL_UNIT_COST);
				}
				if (GetPlayerMoney(i) < CALL_UNIT_COST)
				{
					SendClientMessage(i, COLOR_BRIGHTRED, "CUT OFF: You don't have enough cash to continue this call");
					SendClientMessage(Calling[i], COLOR_BRIGHTRED, "CUT OFF: Your recipient's phone has been cut off due to lack of credit");
					Calling[Calling[i]] = -1;
					Answered[Calling[i]] = 0;
					Calling[i] = -1;
					Answered[i] = 0;
					Callerid[i] = 0;
				}
			}
		}
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(text[0] == '#' && IsPlayerXAdmin(playerid)) {
	    new string[256],xname[24]; GetPlayerName(playerid,xname,24); format(string,256,"Admin %s: %s",xname,text[1]); SendMessageToAdmins(string);
	    return 0;
	}
	if(Variables[playerid][Wired]) {
	    Variables[playerid][WiredWarnings]--;
	    new string[256],Name[24];
	    if(Variables[playerid][WiredWarnings]) {
	        format(string,256,"You have been wired thus preventing you from talking or PMing. [Warnings: %d/%d]",Variables[playerid][WiredWarnings],Config[WiredWarnings]);
			SendClientMessage(playerid,white,string); return 0;
		}
		else {
		    GetPlayerName(playerid,Name,24); format(string,256,"%s has been kicked from the server. [REASON: Wired]",Name);
		    SendClientMessageToAll(yellow,string); SetUserInt(playerid,"Wired",0);
		    Kick(playerid); return 0;
		}
	}
	if (Calling[playerid] > -1 && Answered[playerid] == 1)
	{
    	new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s: %s", sendername, text);
		SendClientMessage(Calling[playerid], COLOR_YELLOW, string);
		format(string, sizeof(string), "%s: %s", sendername, text);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "%s: %s", sendername, text);
		print(string);
		format(string, sizeof(string), "%s: %s", sendername, text);
		print(string);
		return 0;
	}
	if(text[0] == '!') {
		if(playerGang[playerid] > 0) {
		    new gangChat[256];
		    new senderName[MAX_PLAYER_NAME];
		    new string[256];

//		    for(new i = 1; i < strlen(text)+1; i++)
//				gangChat[i]=text[i];

			strmid(gangChat,text,1,strlen(text));

			GetPlayerName(playerid, senderName, sizeof(senderName));
			format(string, sizeof(string),"%s: %s", senderName, gangChat);

			for(new i = 0; i < gangInfo[playerGang[playerid]][1]; i++) {
				SendClientMessage(gangMembers[playerGang[playerid]][i], COLOR_LIGHTBLUE, string);
			}
		}
		return 0;
	}
	return 1;
}

public OnPlayerPrivmsg(playerid, recieverid, text[]) {
	if(!IsPlayerConnected(playerid)||!IsPlayerConnected(recieverid)) return 1;
	new string[256], ToName[24], Name[24]; GetPlayerName(playerid,Name,24);
	if(Config[ExposePMS]) {
	    GetPlayerName(recieverid,ToName,24);
	    format(string,256,"PM: %s [%d] -> %s [%d]: %s",Name,playerid,ToName,recieverid,text);
	    SendMessageToAdmins(string);
	}
    if(Config[WireWithPM] && Variables[playerid][Wired]) {
	    Variables[playerid][WiredWarnings]--;
	    if(Variables[playerid][WiredWarnings]) {
	        format(string,256,"You have been wired thus preventing you from talking and PMing. [Warnings: %d/%d]",Variables[playerid][WiredWarnings],Config[WiredWarnings]);
			SendClientMessage(playerid,white,string); return 0;
		}
		else {
  			format(string,256,"%s has been kicked from the server. [REASON: Wired]",Name);
		    SendClientMessageToAll(yellow,string); SetUserInt(playerid,"Wired",0);
		    Kick(playerid); return 0;
		}
	}
	return 1;
}
//==============================Streamer Statements=============================
public vehiclestreamer()
{
    for(new i = 1;i<vehcount;i++) {
		if(VehicleInfo[i][limbo] == 0) {
			if(VehicleInfo[i][spawned] == 0 && PlayersInRangeV(i,VehicleInfo[i][spawndist]) == 1) {
			    if(Vstreamcount < MAX_ACTIVE_VEHICLES) {
			        if(IsModelActive(VehicleInfo[i][model]) == 0) {
			            if(CountModels(vehcount) < MAX_ACTIVE_MODELS) {
							VehicleInfo[i][idnum] = CreateVehicle(VehicleInfo[i][model], VehicleInfo[i][x_spawn], VehicleInfo[i][y_spawn], VehicleInfo[i][z_spawn], VehicleInfo[i][za_spawn], VehicleInfo[i][color_1], VehicleInfo[i][color_2],20000);
							avstream[VehicleInfo[i][idnum]] = i;
							SetTimerEx("ModVehicle",100,0,"i",i);
							VehicleInfo[i][spawned] = 1;
							Vstreamcount++;
						}
					}
					else if(IsModelActive(VehicleInfo[i][model]) == 1) {
					    VehicleInfo[i][idnum] = CreateVehicle(VehicleInfo[i][model], VehicleInfo[i][x_spawn], VehicleInfo[i][y_spawn], VehicleInfo[i][z_spawn], VehicleInfo[i][za_spawn], VehicleInfo[i][color_1], VehicleInfo[i][color_2],20000);
						avstream[VehicleInfo[i][idnum]] = i;
						SetTimerEx("ModVehicle",100,0,"i",i);
						VehicleInfo[i][spawned] = 1;
						Vstreamcount++;
					}
				}
			}
			else if(VehicleInfo[i][spawned] == 1 && PlayersInRangeV(i,VehicleInfo[i][spawndist]) == 0 && vehused[VehicleInfo[i][idnum]] == 0) {
     			DestroyVehicle(VehicleInfo[i][idnum]);
				VehicleInfo[i][spawned] = 0;
				vehused[VehicleInfo[i][idnum]] = 0;
				Vstreamcount--;
				VehicleInfo[i][idnum] = 0;
			}
		}
	}
}

public pickupstreamer()
{
	new pickupcount = bizcount+3;
    for(new i = 0;i<pickupcount;i++) {
		if(PickupInfo[i][spawned] == 0 && PickupInfo[i][valid] == 1) {
			if(PlayersInRangePU(i,DEFAULT_SPAWN_DIST) == 1) {
			    if(PUstreamcount < MAX_ACTIVE_PICKUPS) {
						PickupInfo[i][idnum] = CreatePickup(PickupInfo[i][model],2, PickupInfo[i][x_spawn], PickupInfo[i][y_spawn], PickupInfo[i][z_spawn]);
						PickupInfo[i][spawned] = 1;
						PUstreamcount++;
				}
			}
		}
		else if(PlayersInRangePU(i,DEFAULT_SPAWN_DIST) == 0) {
		    DestroyPickup(PickupInfo[i][idnum]);
			PickupInfo[i][spawned] = 0;
			PUstreamcount--;
			PickupInfo[i][idnum] = -1;
		}
	}
}

public minimapstreamer()
{
	for(new j = 0;j<MAX_PLAYERS;j++) {
 		if(IsPlayerConnected(j)) {
			for(new K = 1;K<B_LIMIT;K++) {
			    if(MapIconInfo[K][mvalid] == 1) {
					if(MIactive[j][K] == 0) {
					   	if(MMstreamcount[j] < MAX_ACTIVE_MM_ICONS) {
							if(IsPlayerClose(j,MapIconInfo[K][mx_spawn],MapIconInfo[K][my_spawn],MapIconInfo[K][mz_spawn],MapIconInfo[K][mspawndist]) == 1) {
								SetPlayerMapIcon(j,MIidnum[j][K],MapIconInfo[K][mx_spawn],MapIconInfo[K][my_spawn],MapIconInfo[K][mz_spawn],MapIconInfo[K][mmodel],1);
								MMstreamcount[j]++;
								MIactive[j][K] = 1;
							}
						}
					}
					else if(IsPlayerClose(j,MapIconInfo[K][mx_spawn],MapIconInfo[K][my_spawn],MapIconInfo[K][mz_spawn],MapIconInfo[K][mspawndist]) == 0) {
						RemovePlayerMapIcon(j,MIidnum[j][K]);
						MIactive[j][K] = 0;
						MMstreamcount[j]--;
					}
				}
			}
		}
	}
}
//===================================Pay day====================================
public PayDay()
{
    SendClientMessageToAll(COLOR_LIGHTBLUE,"PAYDAY: All business earnings have been updated and all players have recieved a rebate of $10000");
	for (new i = 0; i < MAX_PLAYERS; i++) {
	    if(IsPlayerConnected(i)) {
	    	GivePlayerMoney(i,10000);
	    	if(PlayerInfo[i][bowner] == 1) {
	    		SendClientMessage(i,COLOR_LIGHTBLUE,"To collect you business' earnings return to your business and type '/cashbox'");
			}
		}
	}
	for (new i = 0; i < bizcount; i++) {
	    if(BizInfo[i][bought] == 1) {
	    	new cbmon = BizInfo[i][cashbox], pmon = BizInfo[i][profit];
	    	BizInfo[i][cashbox] = cbmon+pmon;
		}
	}
}
//====================================KIHC======================================
public SetHouseOwner(houseid,hpname[])
{
	SetHouseInfo(houseid,"Owner",hpname);
}

GetHouseOwner(houseid)
{
	new str[256];
	GetHouseInfo(houseid,"Owner",str);
	return str;
}

public GetHouseCost(houseid)
{
	new str[256];
	GetHouseInfo(houseid,"cost",str);
	return strval(str);
}
//=================================Leave Gang===================================
public PlayerLeaveGang(playerid) {
	new string[256];
	new playername[MAX_PLAYER_NAME];
	new gangnum = playerGang[playerid];

    if(gangnum > 0) {
		for(new i = 0; i < gangInfo[gangnum][1]; i++) {
			if(gangMembers[gangnum][i]==playerid) {

			    //One less gang member
			    gangInfo[gangnum][1]--;

      		    for(new j = i; j < gangInfo[gangnum][1]; j++) {
				    //Shift gang members
				    gangMembers[gangnum][j]=gangMembers[gangnum][j+1];
	    		}

			    //Disband gang if no more members
			    if(gangInfo[gangnum][1]<1) {
			        gangInfo[gangnum][0]=0;
			        gangInfo[gangnum][1]=0;
			        gangBank[gangnum]=0;
       			}

				//Notify other members
				for(new j = 0; j < gangInfo[gangnum][1]; j++) {
				    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
					format(string, sizeof(string),"%s has quit your gang.", playername);
					SendClientMessage(gangMembers[gangnum][j], COLOR_ORANGE, string);
				}

				format(string, sizeof(string),"You have quit the gang '%s' (id: %d)", gangNames[gangnum], gangnum);
				SendClientMessage(playerid, COLOR_ORANGE, string);

				playerGang[playerid]=0;

				SetPlayerColor(playerid,playerColors[playerid]);

				return;
			}
		}
	} else {
		SendClientMessage(playerid, COLOR_RED, "You are not in a gang.");
	}
}
//===============================Gamemode Start=================================
public OnGameModeInit()
{
	print("\n \nLoading Gamemode(SATDM~RP+Biz+Race+KIHC+Gang+XSVM+XAdmin)");
	SetGameModeText("SATDM~RP+Biz+Race+KIHC+Gang+XSVM+XAdmin");
	printf(" ");
 	printf(" ");
    print(">------------------------------------------------");
	print("tAxI's Vehicle System Is Initialising, Please Wait...");
	printf(">------------------------------------------------");
	printf(" ");
	ShowNameTags(1);
	ShowPlayerMarkers(1);
	SetWorldTime(12);
//----------------------------------Xadmin--------------------------------------
	print("Welcome to the Xtreme Administration Filterscript v2.1");
	print("Checking / creating server configuration...");
	//Check if all configuration files are present.
	if(!dini_Exists("/xadmin/Configuration/Configuration.ini")) {
	    dini_Create("/xadmin/Configuration/Configuration.ini");
	    dini_Set("/xadmin/Configuration/Configuration.ini","ServerMessage","None");
	}
	print("Creating user file variables configuration...");
	// Create the variables to be stored in each user's file.
	CreateLevelConfig(
		"IP","Registered","Level","Cash","Kills","Deaths","Password","Wired",
		"WiredWarnings","Jailed"
	);
	// Create Level Config in pattern 'command name, level, command name, level (case is not sensitive):
	print("Creating command level configuration...");
	CreateCommandConfig(
		// Time Commands
		"morning",1,"afternoon",1,"evening",1,"midnight",1,"settime",1,
		// Miscellaneous Commands
		"goto",5,"gethere",8,"announce",3,"say",1,"flip",1,"slap",6,"wire",8,"unwire",5,"kick",6,
		"ban",9,"akill",7,"eject",6,"freeze",6,"unfreeze",6,"outside",8,"healall",5,"uconfig",10,
		"setsm",10,"givehealth",6,"sethealth",6,"skinall",9,"giveallweapon",7,"resetallweapons",10,
		"setcash",7,"givecash",5,"remcash",7,"resetcash",7,"setallcash",10,"giveallcash",10,"remallcash",
		10,"resetallcash",10,"ejectall",8,"freezeall",10,"unfreezeall",10,"giveweapon",4,"god",10,
		"resetscores",7,"setlevel",10,"setskin",7,"givearmour",5,"setarmour",5,"armourall",5,
		"setammo",5,"setscore",8,"ip",1,"ping",1,"explode",5,"setname",10,"setalltime",10,
		"force",4,"setallworld",5,"setworld",2,"setgravity",7,"setwanted",6,"setallwanted",7
	);
	CreateCommandConfigEx(
		"xlock",1,"xunlock",1,"carcolor",1,"gmx",10,"carhealth",5,"setping",5,
		"givecar",7,"xspec",4,"xjail",7,"xunjail",3,"vr",0,"weather",5
	);
	print("Creating Forbidden Names...");
	// Add the names to prevent from connecting to your server in the following format:
	CreateForbiddenNames("shit","fuck","crap","hax","hacker"
	);
	print("Creating main configuration files...");
	UpdateConfigurationVariables();
	print("Initializing Menus...");

	GiveCar = CreateMenu("~b~Givecar ~w~Administration",1,125,150,300);
	if(IsValidMenu(GiveCar)) {
		SetMenuColumnHeader(GiveCar , 0, "Select a car component to add:");
		AddMenuItem(GiveCar ,0,"Nitrous x10");
		AddMenuItem(GiveCar ,0,"Hydraulics");
		AddMenuItem(GiveCar ,0,"Offroad Wheel");
		AddMenuItem(GiveCar ,0,"Wire Wheels");
	}

	Weather = CreateMenu("~r~Weather ~w~Administration",1,125,150,300);
	if(IsValidMenu(GiveCar)) {
		SetMenuColumnHeader(GiveCar , 0, "Select a car component to add:");
		AddMenuItem(Weather,0,"Sunny");
		AddMenuItem(Weather,0,"Cloudy");
		AddMenuItem(Weather,0,"Thunderstorm");
		AddMenuItem(Weather,0,"Foggy");
		AddMenuItem(Weather,0,"Scorching Hot");
		AddMenuItem(Weather,0,"Sandstorm");
		AddMenuItem(Weather,0,"Polluted");
	}
	print("Complete.");
	SetTimer("PingKick",Config[PingSecondUpdate]*1000,true);
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) OnPlayerConnect(i);
//----------------------------------Gang Zones----------------------------------
	Worker = GangZoneCreate(-2157.1663,96.6665,-1932.0258,330.8631);
	Pimp = GangZoneCreate(-2716.4243,1292.3812,-2607.6306,1446.0879);
	Golfer = GangZoneCreate(-2797.4963,-420.4095,-2629.8730,-221.8892);
	Triad = GangZoneCreate(-2250.9419,574.2153,-2129.4670,724.6283);
	Army = GangZoneCreate(-1616.7291,294.5811,-1231.8075,503.3318);
	Valet = GangZoneCreate(-1781.3525,932.7036,-1695.9397,1041.9789);
	Medic = GangZoneCreate(-2719.5605,557.5917,-2536.2844,697.6593);
	FBI = GangZoneCreate(-1706.4167,614.7883,-1567.8694,754.1960);
	Chicken = GangZoneCreate(-1898.2987,605.0880,-1777.2820,729.1407);
	Rich = GangZoneCreate(-2685.4111,896.8892,-2655.2393,966.9269);
	Pilot = GangZoneCreate(-1748.1112,-630.1697,-1266.5975,78.1196);
	Pilot1 = GangZoneCreate(-1278.367, 199.5653, -1027.292, 381.0337);
	Pilot2 = GangZoneCreate(-1197.25, 325.8042, -1007.979, 534.8873);
	DaNang = GangZoneCreate(-1499.7189,1445.5778,-1333.4880,1514.5814);
//-------------------------------Load Race Script-------------------------------
	print("\n+--------------------------+");
	print("| Yagu's Race Script v0.4a |");
	print("+-----------LOADED---------+\n");
	RaceActive=0;
	Ranking=1;
	LCurrentCheckpoint=0;
	Participants=0;
	for(new i;i<MAX_BUILDERS;i++)
	{
	    BuilderSlots[i]=MAX_PLAYERS+1;
	}
	if(RRotation != -1) SetTimer("RaceRotation",RRotationDelay,1);
	#if defined MENUSYSTEM
	CreateRaceMenus();
	#endif
//-----------------------------------KIHC Script--------------------------------
	CallLocalFunction("ogmi"," ");
	Hmen1 = CreateMenu("house",1,50,150,50,150);
	AddMenuItem(Hmen1,0,"Info");
	AddMenuItem(Hmen1,0,"Enter");
	AddMenuItem(Hmen1,0,"Rent");
	AddMenuItem(Hmen1,0,"Buy");
	Hexit1 = CreateMenu(" ",1,500,380,50,30);
	AddMenuItem(Hexit1,0,"EXIT");
	#include <../../scriptfiles/houses.req >
//------------------------------Cool Vehicle Stuff------------------------------
	print(">--------------------------------------------------------------------------");
    vehcount = CountVehicles(V_FILE_LOAD);
    bizcount = CountBusinesses(B_FILE_LOAD);
    new vehmes[256];
	format(vehmes,sizeof(vehmes),"Verifying %s (Complete) - %d Vehicle Spawns Verified!", V_FILE_LOAD, vehcount);
	printf(vehmes);
	print(">--------------------------------------------------------------------------");
	printf(" ");
	print(">--------------------------------------------------------------------------");
	LoadVehicles();
	print(">--------------------------------------------------------------------------");
	print(" ");
	print(" ");
	print(">--------------------------------------------------------------------------");
	print(" ");
	new vehmess[256];
	format(vehmess,sizeof(vehmes),"	-Streaming Complete - %d Vehicles Streamed!", vehcount);
	printf(vehmess);
 	for(new c=1;c<=vehcount;c++)
/*	{
	 	new strings[256];
	 	format(strings,sizeof(strings),"Checking Vehicle File For saved Mods - Vehicle ID: %d / Type: %s", c, VehicleName[VehicleInfo[c][model]-400][0]);
		printf(strings);
 	}*/
	format(tmpname,sizeof(tmpname),"	-%d Vehicles Were Tuned On Server Load!     ",tuned);
	printf(tmpname);
	print("	-tAxI's Vehicle System Status - 100% - System Ready...");
	print(">--------------------------------------------------------------------------");
	print(" ");
	print(" ");
	print(">--------------------------------------------------------------------------");
	print("Loading Businesses...Please Wait...");
	print(" ");
	LoadBusinesses();
	for(new i=0;i<bizcount;i++) {
		CreateStreamPickup(B_ICON,BizInfo[i][xpos],BizInfo[i][ypos],BizInfo[i][zpos],PICKUP_TYPE_BIZ);
	}
	for(new i=0;i<bizcount;i++) {
        if(BizInfo[i][bought] == 0) {
            CreateStreamMapIcon(31,BizInfo[i][xpos],BizInfo[i][ypos],BizInfo[i][zpos],DEFAULT_SPAWN_DIST);
		}
		else {
		    CreateStreamMapIcon(32,BizInfo[i][xpos],BizInfo[i][ypos],BizInfo[i][zpos],DEFAULT_SPAWN_DIST);
		}
	}
	for(new i=0;i<3;i++) {
		CreateStreamMapIcon(55,Pickup[i][0],Pickup[i][1],Pickup[i][2],DEFAULT_SPAWN_DIST);
	}
	print(">--------------------------------------------------------------------------");
 	new bizmess[256];
 	format(bizmess,256,"%d Businesses Successfully loaded and created",bizcount);
 	printf(bizmess);
	print(">--------------------------------------------------------------------------");
 	printf("");
	print(">--------------------------------------------------------------------------");
	print("tAxI's Business System Status - 100% - System Ready...");
	print(">--------------------------------------------------------------------------");
//---------------------------------Vehicle Menus--------------------------------
	vehiclemain = CreateMenu("tAxI-XVM",1,440,140,150,40);
	AddMenuItem(vehiclemain,0,"Player Vehicle Menu");
	AddMenuItem(vehiclemain,0,"Vehicle Admin System");
	AddMenuItem(vehiclemain,0,"<exit>");

	playervm = CreateMenu("tAxI-XVM",1,440,140,150,40);
	AddMenuItem(playervm,0,"Temp Lock");
	AddMenuItem(playervm,0,"Vehicle Health Bar");
	AddMenuItem(playervm,0,"Dash Board Settings");
	AddMenuItem(playervm,0,"Vehicle Ownership");
	AddMenuItem(playervm,0,"Call Your Vehicle");
	AddMenuItem(playervm,0,"Park Your Vehicle");
	AddMenuItem(playervm,0,"Vehicle Security");
	AddMenuItem(playervm,0,"<back>");

	adminm = CreateMenu("tAxI-XVM",1,440,140,150,40);
	AddMenuItem(adminm,0,"Sell Current Vehicle");
	AddMenuItem(adminm,0,"Set Purchase Status");
	AddMenuItem(adminm,0,"Set Admin Protection");
	AddMenuItem(adminm,0,"<back>");

	buysell = CreateMenu("tAxI-XVM",1,440,140,150,40);
	AddMenuItem(buysell,0,"Buy This Vehicle");
	AddMenuItem(buysell,0,"Sell This Vehicle");
	AddMenuItem(buysell,0,"<back>");

	secure1 = CreateMenu("tAxI-XVM",1,440,140,150,40);
	AddMenuItem(secure1,0,"Switch On Alarm");
	AddMenuItem(secure1,0,"Switch Off Alarm");
	AddMenuItem(secure1,0,"<back>");

	secure2 = CreateMenu("tAxI-XVM",1,440,140,150,40);
	AddMenuItem(secure2,0,"Lethal Mode");
	AddMenuItem(secure2,0,"Non-Lethal Mode");
	AddMenuItem(secure2,0,"<back>");

	asecure1 = CreateMenu("tAxI-XVM",1,440,140,150,40);
	AddMenuItem(asecure1,0,"Switch On Admin Security");
	AddMenuItem(asecure1,0,"Switch Off Admin Security");
	AddMenuItem(asecure1,0,"<back>");

	asecure2 = CreateMenu("tAxI-XVM",1,440,140,150,40);
	AddMenuItem(asecure2,0,"Lethal Mode");
	AddMenuItem(asecure2,0,"Non-Lethal Mode");
	AddMenuItem(asecure2,0,"<back>");

	templock = CreateMenu("tAxI-XVM",1,440,140,150,40);
	AddMenuItem(templock,0,"Lock Vehicle");
	AddMenuItem(templock,0,"Unlock Vehicle");
	AddMenuItem(templock,0,"<back>");

	speedom = CreateMenu("tAxI-XVM",1,440,140,150,40);
	AddMenuItem(speedom,0,"Switch On Dashboard");
	AddMenuItem(speedom,0,"Switch Off Dashboard");
	AddMenuItem(speedom,0,"<back>");

	buyable = CreateMenu("tAxI-XVM",1,440,140,150,40);
	AddMenuItem(buyable,0,"Set To Buyable");
	AddMenuItem(buyable,0,"Set To Unbuyable");
	AddMenuItem(buyable,0,"<back>");

	healthbar = CreateMenu("tAxI-XVM",1,440,140,150,40);
	AddMenuItem(healthbar,0,"Switch On");
	AddMenuItem(healthbar,0,"Switch Off");
	AddMenuItem(healthbar,0,"<back>");

	EnableTirePopping(1);
//--------------------------------Team Kill Menu--------------------------------
	TK = CreateMenu("TeamKill", 3, 160.0, 150.0, 250.0, 50.0);
	if (IsValidMenu(TK))
	{
		SetMenuColumnHeader(TK, 0, "TeamKill Punishment");
		AddMenuItem(TK, 0, "Kill");
		AddMenuItem(TK, 0, "Explode");
		AddMenuItem(TK, 0, "-2500");
		AddMenuItem(TK, 0, "Reset Weapons");
	 	AddMenuItem(TK, 0, "Forgive");
	}
//--------------------------------ALL GAME TEAMS--------------------------------
	//Classes Note: Some of the Classes are Cams so give Credit to him too
	AddPlayerClass(260,-2062.5583,237.4662,36.2890,268.8936,23,170,25,60,30,360); //SF Worker
	AddPlayerClass(296,-2653.6443,1388.2767,8.0739,212.8453,26,100,29,360,15,1); //SF Pimp
	AddPlayerClass(259,-2642.2583,-274.9985,8.3506,135.0036,25,80,32,300,2,1); //SF Golfer
	AddPlayerClass(294,-2188.8037,609.8431,36.2624,82.8703,32,300,30,390,4,1); //SF Triad
	AddPlayerClass(287,-1377.4271,466.0897,8.9393,1.0348,26,80,31,300,23,170); //SF ARMY
	AddPlayerClass(253,-1754.9976,958.5851,25.8386,163.2550,28,300,24,100,4,1); //SF Valet
	AddPlayerClass(274,-2665.4282,635.6348,16.0054,179.8403,26,100,23,170,9,1); //SF Medic
	AddPlayerClass(286,-1635.0077,665.8105,8.4054,264.2244,29,360,27,100,3,1); //SF FBI
	AddPlayerClass(167,-1830.9324,638.9214,31.3054,180.9218,26,200,29,390,9,1); //SF Chicken
	AddPlayerClass(295,-2664.8037,938.6110,80.7618,180.7716,27,100,24,100,28,400);//SF Rich
	AddPlayerClass(61,-1358.6774,-243.8737,15.6769,315.6869,22,170,25,60,14,1); //SF pilot
	AddPlayerClass(122,-1430.1825,1492.3381,8.0482,91.3221,24,70,27,77,28,300); //SF Da Nang
	
	AddPlayerClass(102,832.2958,-1080.4476,24.2969,107.7328,0,0,0,0,0,0); //LV Balla
    AddPlayerClass(103,832.2958,-1080.4476,24.2969,107.7328,0,0,0,0,0,0); //LV Balla
    AddPlayerClass(104,832.2958,-1080.4476,24.2969,107.7328,0,0,0,0,0,0); //LV Balla
    AddPlayerClass(105,2495.2207,-1687.3169,13.5152,107.7328,0,0,0,0,0,0); //LV Grove
    AddPlayerClass(106,2495.2207,-1687.3169,13.5152,107.7328,0,0,0,0,0,0); //LV Grove
    AddPlayerClass(107,2495.2207,-1687.3169,13.5152,107.7328,0,0,0,0,0,0); //LV Grove
    AddPlayerClass(108,2459.0442,-949.4450,80.0800,107.7328,0,0,0,0,0,0); //LV Vago
    AddPlayerClass(110,2459.0442,-949.4450,80.0800,107.7328,0,0,0,0,0,0); //LV Vago
    AddPlayerClass(114,1761.7893,-1892.7225,13.5551,107.7328,0,0,0,0,0,0); //LV Azteca
    AddPlayerClass(115,1761.7893,-1892.7225,13.5551,107.7328,0,0,0,0,0,0); //LV Azteca
    AddPlayerClass(116,1761.7893,-1892.7225,13.5551,107.7328,0,0,0,0,0,0); //LV Azteca
    AddPlayerClass(122,1499.2067,-937.3587,37.4407,107.7328,0,0,0,0,0,0); //LV Triad
    AddPlayerClass(123,1499.2067,-937.3587,37.4407,107.7328,0,0,0,0,0,0); //LV Triad
    AddPlayerClass(274,1499.2067,-937.3587,37.4407,107.7328,0,0,0,0,0,0); //LV Medic
    AddPlayerClass(275,1499.2067,-937.3587,37.4407,107.7328,0,0,0,0,0,0); //LV Medic
    AddPlayerClass(277,1499.2067,-937.3587,37.4407,107.7328,0,0,0,0,0,0); //LV Fireman
    AddPlayerClass(280,1552.5618,-1675.3375,16.1953,107.7328,0,0,0,0,0,0); //LV Cop
    AddPlayerClass(281,1552.5618,-1675.3375,16.1953,107.7328,0,0,0,0,0,0); //LV Cop
    AddPlayerClass(283,1552.5618,-1675.3375,16.1953,107.7328,0,0,0,0,0,0); //LV Cop
    AddPlayerClass(287,1552.5618,-1675.3375,16.1953,112.5582,0,0,0,0,0,0); //LV Army
    AddPlayerClass(286,1552.5618,-1675.3375,16.1953,112.5582,0,0,0,0,0,0); //LV Swat
	AddPlayerClass(214,1552.5618,-1675.3375,16.1953,269.1425,0,0,24,300,-1,-1);//LV Civillian
	AddPlayerClass(215,1552.5618,-1675.3375,16.1953,269.1425,0,0,24,300,-1,-1);//LV Civillian
	AddPlayerClass(216,1552.5618,-1675.3375,16.1953,269.1425,0,0,24,300,-1,-1);//LV Civillian
	AddPlayerClass(251,1552.5618,-1675.3375,16.1953,269.1425,0,0,24,300,-1,-1);//LV Civillian
	AddPlayerClass(253,1552.5618,-1675.3375,16.1953,269.1425,0,0,24,300,-1,-1);//LV Civillian
	AddPlayerClass(254,1552.5618,-1675.3375,16.1953,269.1425,0,0,24,300,-1,-1);//LV Civillian
	AddPlayerClass(255,1552.5618,-1675.3375,16.1953,269.1425,0,0,24,300,-1,-1);//LV Civillian
	
    AddPlayerClass(280,1552.4381,-1675.6388,16.1953,91.0541,29,300,22,170,3,1); //LS Cop
    AddPlayerClass(284,1527.4740,-1676.5242,5.8906,221.3641,24,70,31,250,4,1); //LS Cop
    AddPlayerClass(106,2516.3032,-1674.7357,13.9314,62.4839,22,272,30,300,9,1); //LS Grove
	AddPlayerClass(107,2486.7520,-1646.4600,14.0703,183.2633,22,272,30,300,9,1); //LS Grove
    AddPlayerClass(108,2627.3525,-1457.3615,31.0251,5.0687,4,0,22,125,30,300); //LS Vago
    AddPlayerClass(109,2633.3894,-1435.1416,30.4864,232.3824,24,150,25,50,29,200); //LS Vago
    AddPlayerClass(115,1733.9663,-2098.1926,14.0366,171.6405,5,0,23,150,31,200); //LS Aazteca
    AddPlayerClass(116,1804.0708,-2124.1572,13.9424,0.7752,9,0,22,150,26,100); //LS Azteca
    AddPlayerClass(104,768.6387,-1696.5547,5.1554,96.1184,5,0,24,150,30,250); //LS Balla
    AddPlayerClass(103,767.3694,-1655.5189,5.6094,100.1684,4,0,22,200,31,250); //LS Balla
    AddPlayerClass(155,2101.5129,-1806.4567,13.5547,87.8965,4,0,26,150,30,200); //LS PizzaBoy
    //-------------------------51 Classes in total
//---------------------------Vehicle healthbar stuff----------------------------

 	vehiclehpbar[0] = TextDrawCreate(549.0, 50.0, "KABOOM!");
	TextDrawUseBox(vehiclehpbar[0], true);
	TextDrawBoxColor(vehiclehpbar[0], COLOR_BRIGHTRED);
	TextDrawSetShadow(vehiclehpbar[0],0);
	TextDrawTextSize(vehiclehpbar[0], 625, 0);

	vehiclehpbar[1] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclehpbar[1], true);
	TextDrawBoxColor(vehiclehpbar[1], COLOR_BRIGHTRED);
	TextDrawSetShadow(vehiclehpbar[1],0);
	TextDrawTextSize(vehiclehpbar[1], 551, 0);

	vehiclehpbar[2] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclehpbar[2], true);
	TextDrawBoxColor(vehiclehpbar[2], COLOR_BRIGHTRED);
	TextDrawSetShadow(vehiclehpbar[2],0);
	TextDrawTextSize(vehiclehpbar[2], 556, 0);

	vehiclehpbar[3] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclehpbar[3], true);
	TextDrawBoxColor(vehiclehpbar[3], COLOR_BRIGHTRED);
	TextDrawSetShadow(vehiclehpbar[3],0);
	TextDrawTextSize(vehiclehpbar[3], 561, 0);

	vehiclehpbar[4] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclehpbar[4], true);
	TextDrawBoxColor(vehiclehpbar[4], COLOR_YELLOW);
	TextDrawSetShadow(vehiclehpbar[4],0);
	TextDrawTextSize(vehiclehpbar[4], 566, 0);

	vehiclehpbar[5] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclehpbar[5], true);
	TextDrawBoxColor(vehiclehpbar[5], COLOR_YELLOW);
	TextDrawSetShadow(vehiclehpbar[5],0);
	TextDrawTextSize(vehiclehpbar[5], 571, 0);

	vehiclehpbar[6] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclehpbar[6], true);
	TextDrawBoxColor(vehiclehpbar[6], COLOR_YELLOW);
	TextDrawSetShadow(vehiclehpbar[6],0);
	TextDrawTextSize(vehiclehpbar[6], 576, 0);

	vehiclehpbar[7] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclehpbar[7], true);
	TextDrawBoxColor(vehiclehpbar[7], COLOR_YELLOW);
	TextDrawSetShadow(vehiclehpbar[7],0);
	TextDrawTextSize(vehiclehpbar[7], 581, 0);

	vehiclehpbar[8] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclehpbar[8], true);
	TextDrawBoxColor(vehiclehpbar[8], COLOR_GREEN);
	TextDrawSetShadow(vehiclehpbar[8],0);
	TextDrawTextSize(vehiclehpbar[8], 586, 0);

	vehiclehpbar[9] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclehpbar[9], true);
	TextDrawBoxColor(vehiclehpbar[9], COLOR_GREEN);
	TextDrawSetShadow(vehiclehpbar[9],0);
	TextDrawTextSize(vehiclehpbar[9], 591, 0);

	vehiclehpbar[10] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclehpbar[10], true);
	TextDrawBoxColor(vehiclehpbar[10], COLOR_GREEN);
	TextDrawSetShadow(vehiclehpbar[10],0);
	TextDrawTextSize(vehiclehpbar[10], 596, 0);

	vehiclehpbar[11] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(vehiclehpbar[11], true);
	TextDrawBoxColor(vehiclehpbar[11], COLOR_GREEN);
	TextDrawSetShadow(vehiclehpbar[11],0);
	TextDrawTextSize(vehiclehpbar[11], 602, 0);

	SetTimer("VHPBarUpdate",250,1);
	
	for(new i = 0;i<3;i++) {
    	CreateStreamPickup(1274,Pickup[i][0],Pickup[i][1],Pickup[i][2],PICKUP_TYPE_BANK);
	}
//-----------------------------------Pickups------------------------------------
	AddStaticPickup(1242, 15, 1198.6222,-2036.7010,69.0078); //Armor WHITE HOSE
	AddStaticPickup(1242, 15, 2037.5424,1955.0793,12.0647); //Armor hotel2
	AddStaticPickup(1242, 15, -1666.2980,1204.7188,7.2546); //Armor car dealer2
	AddStaticPickup(1242, 15, 2216.9341,-1179.4139,25.8906); //Armor motel
	AddStaticPickup(1242, 15, 1582.2346,-2433.3376,13.5547); //Armor airport2
	AddStaticPickup(1242, 15, 915.7377,-1235.0343,17.2109); //Armor MOVIE
	AddStaticPickup(1242, 15, -1111.8021,-1672.5598,76.3672); //Armor HIPPY
	AddStaticPickup(1242, 15, 1296.5054,-786.7410,88.3125); //Armor ADMIN
	AddStaticPickup(1242, 15, -534.7692,-178.1900,78.4047); //armor FOREST
	AddStaticPickup(1242, 15, -2771.5168,-251.6141,7.1875); //armor hotel
	AddStaticPickup(1242, 15, -1321.9531,2504.2705,89.5703); //armor hobo
	AddStaticPickup(1242, 15, -2241.2661,2321.9829,7.5454); //armor secret
	AddStaticPickup(1242, 15, -2720.7385,231.9487,4.3418); //armor at trans
	AddStaticPickup(1242, 15, 2238.8762,2449.3284,11.0372); //armor at security cop
	AddStaticPickup(1242, 15, -1844.8163,-1708.9067,41.1060); //armor at Rock Quarry
	AddStaticPickup(1242, 15, -2230.1113,-1743.3027,480.8695); //armor at chilliad
	AddStaticPickup(1242, 15, 2184.7224,-1203.6058,1049.8330); //armor at lombardi str
	AddStaticPickup(1242, 15, -1954.3491,303.5424,35.4688); //armor at car dealer
	AddStaticPickup(1242, 15, 2537.5513,-1663.5591,15.1492); //armor at grove str back right behind spwn
	AddStaticPickup(1242, 15, 1331.1685,1257.4764,14.2731); //armor at airort
	AddStaticPickup(1242, 15, 2293.2725,1435.4340,38.4735); //armor at driuft
	AddStaticPickup(1242, 15, 2582.8208,-1717.3884,8.0025); //aromr rbed
	AddStaticPickup(1242, 15, 1654.0404,-1658.1034,22.5156); //armor 3towers
	AddStaticPickup(1242, 15, 2332.5977,-1064.6901,1049.0234); //armor pimp
	AddStaticPickup(1242, 15, 688.0721,841.4696,-39.0077); //armor quarry1
	AddStaticPickup(1242, 15, 538.1361,839.2096,-34.6727); //armor quar 2
	AddStaticPickup(1242, 15, 545.5967,919.9224,-34.7484); //armor quar 3
	AddStaticPickup(1242, 15, 623.2344,894.4736,-35.4231); //armor quar 4
	AddStaticPickup(1242, 15, 2746.5503,-2453.7292,13.8623); //Armor military
	AddStaticPickup(370, 15, -2291.5791,2318.0688,15.2117); //SECRET JETPACK
	AddStaticPickup(371, 15, -2240.2351,-1747.3890,480.8622); //chilliad parachute
	AddStaticPickup(657, 2, -2649.4902, 1383.0055, 7.1826); //Kool Spinning tree
	AddStaticPickup(354, 2, -2649.4902, 1383.0055, 7.1826);//Flare in tree
	AddStaticPickup(354, 2, -2649.4902, 1383.0055, 10.5802);//Flare in tree
	AddStaticPickup(354, 2, -2649.4902, 1383.0055, 14.9802);//Flare in tree
	AddStaticPickup(354, 2, -2649.4902, 1383.0055, 13.9802);//Flare in tree
	//-----------------LV Airport to Army Base Bridge By: [CBK]MoNeYPiMp)
	CreateObject(18449, -1233.426270, 408.714081, 19.839516, 0.0000, 4.2972, 312.4217);
	CreateObject(1634, -1254.233154, 437.918274, 23.900005, 359.1406, 356.5623, 42.4217);
	CreateObject(18449, -1287.145386, 470.368927, 20.625740, 1.7189, 351.4056, 308.9840);
	CreateObject(18449, -1346.924561, 470.706299, 3.755691, 348.8273, 331.6386, 13.4417);
	CreateObject(1634, -1267.565796, 441.659546, 16.474197, 239.6790, 177.7990, 222.7994);
	CreateObject(1634, -1273.401123, 447.661041, 12.705763, 219.9119, 179.5179, 223.6588);
	CreateObject(18449, -1179.892578, 349.856659, 13.299114, 0.0000, 5.1566, 312.4217);
	//---------------Stunt Park By: [LSIB]X_Cutter
	CreateObject(971, -2029.763062, -124.249550, 37.757751, 0, 0, 0);
	CreateObject(971, -2034.172485, -119.812218, 37.760315, 0, 0, 269.7591);
	CreateObject(971, -2025.529541, -119.856903, 37.748856, 0, 0, 272.3375);
	CreateObject(969, -2034.059082, -120.240891, 37.994469, 0, 0, 0);
	CreateObject(969, -2034.200195, -123.931404, 41.288780, 269.7592, 0, 359.1406);
	CreateObject(13648, -2091.278564, -124.417061, 34.266281, 0, 0, 0);
	CreateObject(13648, -2090.648193, -124.404160, 34.266281, 0, 0, 0);
	CreateObject(13647, -2091.029541, -171.607254, 34.316284, 0, 0, 269.7591);
	CreateObject(13641, -2017.510498, -140.976227, 35.459076, 0, 0, 267.1808);
	CreateObject(13641, -2017.711914, -166.224121, 35.339516, 0, 0, 87.5587);
	CreateObject(13638, -2027.937134, -271.354767, 36.417580, 0, 0, 0);
	CreateObject(969, -2034.719727, -280.712860, 40.729832, 0, 0, 0);
	CreateObject(971, -2033.512817, -275.963165, 37.890167, 0, 0, 268.8997);
	CreateObject(971, -2033.345337, -267.078613, 37.890167, 0, 0, 268.8997);
	CreateObject(13666, -2017.970581, -257.768890, 39.150566, 0, 0, 6.0161);
	CreateObject(13666, -2021.652832, -257.602570, 39.150566, 0, 0, 6.0161);
	CreateObject(13666, -2025.379028, -257.444092, 39.149769, 0, 0, 6.0161);
	CreateObject(13666, -2029.010864, -257.287903, 39.140961, 0, 0, 6.0161);
	CreateObject(13592, -2048.899902, -207.144394, 44.065914, 0, 0, 94.4342);
	CreateObject(1503, -2030.108276, -264.293335, 42.100739, 0, 0, 0);
	CreateObject(969, -2018.697144, -245.763580, 43.856308, 269.7591, 0, 267.1808);
	CreateObject(969, -2011.873779, -252.873688, 40.754837, 0, 0, 269.7591);
	CreateObject(969, -2011.930908, -261.741760, 40.779839, 0, 0, 269.7591);
	CreateObject(1245, -2012.014526, -255.663452, 35.807884, 0, 0, 274.0563);
	CreateObject(969, -2011.853149, -252.607895, 40.729836, 0, 0, 90.2408);
	CreateObject(971, -2020.831543, -243.861923, 43.847054, 90.2409, 0, 300.6988);
	CreateObject(971, -2025.311768, -236.276016, 43.844215, 90.2409, 0, 300.6988);
	CreateObject(1632, -2027.354370, -233.358002, 45.331715, 9.4538, 0, 30.0803);
	CreateObject(971, -2035.179932, -220.646255, 51.655159, 270.6186, 359.1406, 304.1366);
	CreateObject(971, -2039.637939, -214.375885, 53.344780, 118.6022, 2.5783, 32.6586);
	CreateObject(969, -2043.155273, -213.700226, 55.292805, 91.1003, 0.8594, 124.6184);
	CreateObject(3279, -2045.254150, -205.034012, 55.192551, 0, 0, 339.3735);
	CreateObject(1633, -2047.360840, -212.829315, 71.570908, 341.0924, 0, 160.6106);
	CreateObject(1633, -2049.487305, -218.707428, 71.234428, 341.0924, 0, 160.6106);
	CreateObject(1634, -2051.833252, -225.535767, 72.295769, 0, 0, 159.7512);
	CreateObject(18262, -2042.169312, -220.294876, 72.434242, 358.2811, 5.1566, 81.6464);
	CreateObject(18367, -2038.766357, -219.659607, 71.949776, 0, 0, 0);
	CreateObject(18367, -2039.419922, -249.538071, 75.039330, 359.1406, 0, 268.0403);
	CreateObject(18367, -2069.020020, -248.742126, 78.449776, 0, 0, 181.2369);
	CreateObject(18367, -2069.920898, -218.865128, 81.433090, 0, 359.1406, 88.418);
	CreateObject(18367, -2040.428467, -220.067886, 84.449341, 0, 0, 0);
	CreateObject(18262, -2046.262573, -249.699524, 88.739952, 0, 0, 83.3653);
	CreateObject(3279, -2048.043701, -246.104614, 88.021889, 0, 0, 0);
	CreateObject(1218, -2048.145508, -246.172028, 104.591705, 0, 0, 0);
	CreateObject(969, -2042.782227, -202.841507, 72.112595, 270.6186, 0, 69.6144);
	CreateObject(18367, -2041.389160, -194.902969, 72.127640, 37.8152, 5.1566, 159.8555);
	CreateObject(18262, -2036.823853, -171.200912, 56.720722, 0, 0, 75.6304);
	CreateObject(3270, -2033.162964, -159.527084, 33.662197, 0, 0, 0);
	CreateObject(3269, -2056.233154, -160.401627, 33.193459, 0, 0, 304.9961);
	CreateObject(3363, -2048.090576, -142.612473, 34.155655, 0, 0, 0);
	CreateObject(3364, -2057.784424, -107.956017, 34.476334, 0, 0, 0);
	CreateObject(12956, -2058.442383, -246.159454, 35.873535, 0, 0, 0);
	CreateObject(13590, -2020.764038, -230.338760, 34.946125, 0, 0, 0);
	CreateObject(13604, -2079.216553, -219.619797, 35.778316, 0, 0, 0);
	CreateObject(13636, -2068.714600, -191.194214, 36.150677, 0, 0, 0);
	CreateObject(3279, -2049.909668, -106.821388, 34.091446, 0, 0, 0);
	CreateObject(3279, -2091.546875, -275.471954, 34.120911, 0, 0, 0);
	CreateObject(971, -2095.781738, -216.648987, 44.307823, 0, 0, 90.2409);
	CreateObject(971, -2011.837402, -239.783264, 44.057869, 0, 0, 270.6186);
	CreateObject(971, -2015.887329, -257.513550, 46.054466, 0, 0, 258.5865);
	CreateObject(971, -2091.330078, -280.941498, 44.232819, 0, 0, 0);
	CreateObject(971, -2091.324707, -280.938171, 51.393135, 0, 0, 0);
	CreateObject(971, -2095.792480, -276.559265, 44.207863, 0, 0, 270.6186);
	CreateObject(971, -2095.785400, -276.518860, 51.358208, 0, 0, 270.6186);
	CreateObject(971, -2095.842529, -267.747314, 44.307823, 0, 0, 269.7591);
	CreateObject(971, -2082.695557, -280.883087, 44.312592, 0, 0, 0);
	CreateObject(971, -2095.829590, -174.308350, 44.328720, 0, 0, 271.478);
	CreateObject(971, -2096.033203, -165.487137, 44.332825, 0, 0, 271.478);
	CreateObject(971, -2096.304443, -156.670258, 44.332886, 0, 0, 271.478);
	CreateObject(971, -2095.623779, -137.767456, 44.307899, 0, 0, 269.7591);
	CreateObject(971, -2095.562012, -128.925003, 44.332855, 0, 0, 269.7591);
	CreateObject(971, -2095.552979, -120.086128, 44.357857, 0, 0, 269.7591);
	CreateObject(971, -2095.778076, -111.679253, 44.307884, 0, 0, 270.6186);
	CreateObject(971, -2095.861328, -102.843391, 44.307854, 0, 0, 270.6186);
	CreateObject(971, -2091.427979, -103.389999, 44.316978, 0, 0, 179.5181);
	CreateObject(971, -2082.551025, -103.364998, 44.251526, 0, 0, 179.5181);
	CreateObject(971, -2073.788086, -103.431046, 44.280823, 0, 0, 0);
	CreateObject(971, -2065.115967, -103.389908, 44.358833, 0, 0, 0);
	CreateObject(971, -2052.744141, -102.656273, 41.456863, 0, 0, 0);
	CreateObject(971, -2052.687744, -102.647896, 48.660263, 0, 0, 0);
	CreateObject(971, -2045.562500, -102.590111, 41.476204, 0, 0, 0.8594);
	CreateObject(971, -2059.413330, -103.415001, 44.337914, 0, 0, 0);
	CreateObject(971, -2045.552368, -102.562973, 48.579254, 0, 0, 0.8594);
	CreateObject(971, -2011.691772, -147.416718, 44.332825, 0, 0, 270.6186);
	CreateObject(971, -2011.752686, -159.865814, 44.307831, 0, 0, 89.3814);
	CreateObject(616, -2053.137207, -114.562286, 34.284336, 0, 0, 0);
	CreateObject(618, -2048.662354, -115.591202, 34.585541, 0, 0, 0);
	CreateObject(617, -2086.480957, -275.459412, 34.314148, 0, 0, 0);
	CreateObject(616, -2090.233887, -269.792480, 34.314148, 0, 0, 0);
	CreateObject(1634,-2034.887,-99.086,35.461,0.0,0.0,-180.000);
	CreateObject(1634,-2030.837,-99.060,35.461,0.0,0.0,-180.000);
	CreateObject(1634,-2026.701,-99.048,35.461,0.0,0.0,-180.000);
	CreateObject(1634,-2022.597,-99.024,35.461,0.0,0.0,-180.000);
	//----------------Chilliad Arena By: ISCV [BRA]
	CreateObject(971,-2270.527343,-1645.016723,478.164978,0.000000,0.000000,0.000000);
    CreateObject(750,-2275.597167,-1639.763916,478.156280,0.000000,0.000000,0.000000);
    CreateObject(971,-2257.711425,-1645.354125,478.159576,0.000000,0.000000,0.000000);
    CreateObject(9833,-2264.194335,-1644.980590,478.154724,0.000000,0.000000,792.000000);
    CreateObject(973,-2253.426025,-1639.964599,478.167938,0.000000,0.000000,5844.000000);
    CreateObject(973,-2252.997314,-1630.495483,478.249755,0.000000,0.000000,7288.000000);
    CreateObject(1634,-2248.282226,-1625.055908,478.282806,0.000000,0.000000,1332.000000);
    CreateObject(1634,-2244.210693,-1626.322998,481.407196,1464.000000,0.000000,3132.000000);
    CreateObject(973,-2252.701171,-1616.333129,478.352142,0.000000,0.000000,13408.000000);
    CreateObject(4650,-2189.161865,-1616.323364,478.525512,368.000000,0.000000,1348.000000);
    CreateObject(1634,-2121.138916,-1616.903930,489.427307,1456.000000,0.000000,1708.000000);
    CreateObject(1634,-2116.833496,-1617.007690,493.588989,2188.000000,0.000000,2068.000000);
    CreateObject(5009,-2032.651489,-1615.157958,497.910034,0.000000,0.000000,0.000000);
    CreateObject(1632,-2236.333007,-1609.791625,473.148315,724.000000,360.000000,448.000000);
    CreateObject(1632,-2240.892578,-1609.632568,476.068756,20.000000,0.000000,448.000000);
    CreateObject(1634,-2238.559082,-1615.410400,473.550109,384.000000,0.000000,1892.000000);
    CreateObject(1633,-2237.075195,-1615.318481,473.495483,368.000000,0.000000,92.000000);
    CreateObject(3524,-2219.694580,-1609.049804,477.158203,0.000000,0.000000,0.000000);
    CreateObject(3524,-2218.145996,-1620.882324,477.158203,0.000000,0.000000,1624.000000);
    CreateObject(3524,-2209.556152,-1609.270019,477.158203,0.000000,0.000000,0.000000);
    CreateObject(3524,-2208.931884,-1621.436523,477.158203,0.000000,0.000000,192.000000);
    CreateObject(971,-2116.598876,-1623.888183,488.772003,0.000000,0.000000,444.000000);
    CreateObject(971,-2120.634277,-1608.590454,488.346282,0.000000,0.000000,0.000000);
    CreateObject(971,-2116.105957,-1612.948486,489.083770,0.000000,0.000000,452.000000);
    CreateObject(971,-2121.046875,-1628.679443,488.677764,0.000000,0.000000,0.000000);
    CreateObject(4638,-2120.725830,-1627.362915,489.073455,0.000000,0.000000,0.000000);
    CreateObject(982,-2111.551757,-1614.860717,496.136596,0.000000,0.000000,0.000000);
    CreateObject(984,-2111.480712,-1634.130615,496.136596,0.000000,0.000000,0.000000);
    CreateObject(984,-2111.482910,-1646.892822,496.136596,0.000000,0.000000,0.000000);
    CreateObject(982,-2111.460937,-1666.236694,496.136596,0.000000,0.000000,0.000000);
    CreateObject(982,-2111.444091,-1691.887207,496.136596,0.000000,0.000000,0.000000);
    CreateObject(982,-2111.538330,-1588.964111,496.136596,0.000000,0.000000,0.000000);
    CreateObject(982,-2111.547607,-1563.219482,496.136596,0.000000,0.000000,0.000000);
    CreateObject(981,-2111.629394,-1538.864257,496.136596,0.000000,0.000000,1528.000000);
    CreateObject(1427,-2109.999511,-1535.344360,496.136596,0.000000,0.000000,272.000000);
    CreateObject(972,-2097.108886,-1707.758666,496.136596,0.000000,0.000000,92.000000);
    CreateObject(972,-2072.137939,-1706.837890,496.136596,0.000000,0.000000,812.000000);
    CreateObject(972,-2047.145996,-1705.820800,496.136596,0.000000,0.000000,452.000000);
    CreateObject(972,-2022.515258,-1706.104370,496.136596,0.000000,0.000000,88.000000);
    CreateObject(972,-1997.491943,-1706.033691,496.136596,0.000000,0.000000,2252.000000);
    CreateObject(972,-1972.407592,-1704.695800,496.136596,0.000000,0.000000,92.000000);
    CreateObject(14781,-2267.243164,-1594.381713,478.816650,0.000000,0.000000,1444.000000);
    CreateObject(971,-2266.658447,-1597.302978,478.582031,0.000000,0.000000,0.000000);
    CreateObject(971,-2267.059814,-1590.094116,478.738525,0.000000,0.000000,4500.000000);
    CreateObject(986,-2288.669921,-1586.208740,478.636779,0.000000,0.000000,1624.000000);
    CreateObject(986,-2280.687988,-1585.955444,478.746948,0.000000,0.000000,0.000000);
    CreateObject(985,-2272.568603,-1585.542724,478.814483,0.000000,0.000000,19804.000000);
    CreateObject(1245,-2252.056884,-1611.428222,478.462677,0.000000,0.000000,2340.000000);
    CreateObject(1245,-2252.010253,-1608.348632,478.447570,0.000000,0.000000,5224.000000);
    CreateObject(4165,-1937.273803,-1668.089843,496.136596,0.000000,0.000000,0.000000);
    CreateObject(4168,-1799.352172,-1668.042968,496.136596,0.000000,0.000000,0.000000);
    CreateObject(1696,-2005.802124,-1680.744750,496.136596,0.000000,0.000000,0.000000);
    CreateObject(1655,-1724.958496,-1662.484619,497.211120,0.000000,0.000000,268.000000);
    CreateObject(1655,-1725.340698,-1673.870483,497.050628,0.000000,0.000000,4224.000000);
    CreateObject(1632,-1726.351196,-1667.717163,497.050628,1084.000000,3600.000000,2788.000000);
    CreateObject(1634,-1720.912231,-1667.889404,500.267852,736.000000,0.000000,7828.000000);
    CreateObject(1633,-1718.319824,-1667.965209,503.413818,32.000000,0.000000,268.000000);
    CreateObject(16778,-1806.542724,-1660.203613,497.042846,0.000000,0.000000,0.000000);
    CreateObject(1227,-1806.147094,-1660.276245,497.207916,0.000000,0.000000,0.000000);
    CreateObject(13801,-1834.301513,-1659.138427,497.058471,0.000000,0.000000,0.000000);
    CreateObject(1358,-1860.409790,-1660.175903,497.215881,0.000000,0.000000,420.000000);
    CreateObject(1634,1559.260864,-1313.433959,333.467376,0.000000,0.000000,352.000000);
    CreateObject(1634,1562.375488,-1314.327270,333.453186,0.000000,0.000000,1412.000000);
    CreateObject(1655,1562.151977,-1310.548461,335.780273,392.000000,0.000000,344.000000);
    CreateObject(11417,-2193.707763,-1623.126708,482.531555,0.000000,0.000000,616.000000);
    CreateObject(3374,-2112.139160,-1617.322753,498.396026,0.000000,0.000000,0.000000);
	return 1;
}

public VHPBarUpdate()
{
	for(new i=0; i<MAX_PLAYERS; i++){
		TextDrawHideForPlayer(i,vehiclehpbar[0]);
		TextDrawHideForPlayer(i,vehiclehpbar[1]);
		TextDrawHideForPlayer(i,vehiclehpbar[2]);
		TextDrawHideForPlayer(i,vehiclehpbar[3]);
		TextDrawHideForPlayer(i,vehiclehpbar[4]);
		TextDrawHideForPlayer(i,vehiclehpbar[5]);
		TextDrawHideForPlayer(i,vehiclehpbar[6]);
		TextDrawHideForPlayer(i,vehiclehpbar[7]);
		TextDrawHideForPlayer(i,vehiclehpbar[8]);
		TextDrawHideForPlayer(i,vehiclehpbar[9]);
		TextDrawHideForPlayer(i,vehiclehpbar[10]);
		TextDrawHideForPlayer(i,vehiclehpbar[11]);
		if(IsPlayerInAnyVehicle(i) == 1 && PlayerInfo[i][vhpb] == 1){
			new vehicleid;
			vehicleid = GetPlayerVehicleID(i);
			new Float:vhp;
			GetVehicleHealth(vehicleid,vhp);
			if(vhp >= 0 && vhp <= 249){
			    TextDrawShowForPlayer(i,vehiclehpbar[0]);
			}
			if(vhp >= 250 && vhp <= 317){
			    TextDrawShowForPlayer(i,vehiclehpbar[1]);
			}
			else if(vhp >= 318 && vhp <= 385){
				TextDrawShowForPlayer(i,vehiclehpbar[2]);
			}
			else if(vhp >= 386 && vhp <= 453){
				TextDrawShowForPlayer(i,vehiclehpbar[3]);
			}
			else if(vhp >= 454 && vhp <= 521){
				TextDrawShowForPlayer(i,vehiclehpbar[4]);
			}
			else if(vhp >= 522 && vhp <= 589){
				TextDrawShowForPlayer(i,vehiclehpbar[5]);
			}
			else if(vhp >= 590 && vhp <= 657){
				TextDrawShowForPlayer(i,vehiclehpbar[6]);
			}
			else if(vhp >= 658 && vhp <= 725){
				TextDrawShowForPlayer(i,vehiclehpbar[7]);
			}
			else if(vhp >= 726 && vhp <= 793){
				TextDrawShowForPlayer(i,vehiclehpbar[8]);
			}
			else if(vhp >= 794 && vhp <= 861){
				TextDrawShowForPlayer(i,vehiclehpbar[9]);
			}
			else if(vhp >= 862 && vhp <= 929){
				TextDrawShowForPlayer(i,vehiclehpbar[10]);
			}
			else if(vhp >= 930 && vhp <= 1000){
				TextDrawShowForPlayer(i,vehiclehpbar[11]);
			}
		}
	}
	return 1;
}

public ctimer()
{
    if (cseconds)
    {
        format(cstring,6,"~w~%d", cseconds-1);
        GameTextForAll(cstring,1100,4);
        SoundForAll(1056);
        cseconds --;
        if (!cseconds)
        {
            GameTextForAll("~r~GO GO GO!!!",2000,4);
            SoundForAll(1057);
            for (new i = 0; i < MAX_PLAYERS; i ++)
    		{
        		if (IsPlayerConnected(i)) SetTimer("resetcount",2000,0);
   			}
        }
    }
}

stock SoundForAll(sound)
{
    for (new i = 0; i <= MAX_PLAYERS; i ++)
    {
        if (IsPlayerConnected(i) == 1) {
			PlayerPlaySound(i,sound,0.0,0.0,0.0);
		}
    }
}
//==========================Selection Screen Stuff==============================
public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerClass(playerid, classid);
	gPlayerClass[playerid] = classid;
//--------------------------Selection Screen Colors-----------------------------
	switch (classid)
	{
	    //-------------------------------SF Worker
	    case 0:
		{
			GameTextForPlayer(playerid, "~r~SF WORKER", 2000, 5);
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid, -2109.7576,184.2289,35.1503);
			SetPlayerFacingAngle(playerid,160.3343);
			SetPlayerCameraPos(playerid, -2108.96,175.01,36.31);
			SetPlayerCameraLookAt(playerid, -2109.7576,184.2289,35.1503);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-2109.7576,184.2289,35.1503);
		}
		//-------------------------------SF Pimp
		case 1:
		{
			GameTextForPlayer(playerid, "~r~SF PIMP", 2000, 5);
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid, -2718.6787,1369.0715,7.1875);
			SetPlayerFacingAngle(playerid,150.9731);
			SetPlayerCameraPos(playerid, -2722.37,1362.35,9.08);
			SetPlayerCameraLookAt(playerid, -2718.6787,1369.0715,7.1875);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-2718.6787,1369.0715,7.1875);
		}
		//-------------------------------SF Golfer
		case 2:
		{
			GameTextForPlayer(playerid, "~r~SF GOLFER", 2000, 5);
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid, -2457.8726,-259.3923,39.6499);
			SetPlayerFacingAngle(playerid,91.5298);
			SetPlayerCameraPos(playerid, -2463.7385,-260.9094,39.5841);
			SetPlayerCameraLookAt(playerid, -2457.8726,-259.3923,39.6499);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-2457.8726,-259.3923,39.6499);
		}
		//-------------------------------SF Triad
		case 3:
		{
			GameTextForPlayer(playerid, "~r~SF TRIAD", 2000, 5);
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid, -2193.5981,641.5383,49.4429);
			SetPlayerFacingAngle(playerid,354.6778);
			SetPlayerCameraPos(playerid, -2194.3101,645.1630,49.4375);
			SetPlayerCameraLookAt(playerid, -2193.5981,641.5383,49.4429);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-2193.5981,641.5383,49.4429);
		}
		//-------------------------------SF Army
	 	case 4:
	 	{
			GameTextForPlayer(playerid, "~r~SF ARMY", 2000, 5);
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid, -1314.7040,445.2622,7.1875);
			SetPlayerFacingAngle(playerid,217.3818);
			SetPlayerCameraPos(playerid, -1314.56,435.76,8.94);
			SetPlayerCameraLookAt(playerid, -1314.7040,445.2622,7.1875);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1314.7040,445.2622,7.1875);
		}
		//-------------------------------SF Valet
		case 5:
		{
			GameTextForPlayer(playerid, "~r~SF VALET", 2000, 5);
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid, -1731.0652,956.3801,24.8828);
			SetPlayerFacingAngle(playerid,358.6085);
			SetPlayerCameraPos(playerid, -1731.92,960.97,26.35);
			SetPlayerCameraLookAt(playerid, -1731.0652,956.3801,24.8828);
			PlayerPlaySound(playerid,SOUND_MUSIC1, -1731.0652,956.3801,24.8828);
		}
		//-------------------------------SF Medic
	 	case 6:
		{
			GameTextForPlayer(playerid, "~r~SF MEDIC", 2000, 5);
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid, -2593.1321,608.7902,14.4531);
			SetPlayerFacingAngle(playerid,270.5395);
			SetPlayerCameraPos(playerid, -2590.15,608.88,14.89);
			SetPlayerCameraLookAt(playerid, -2593.1321,608.7902,14.4531);
			PlayerPlaySound(playerid,SOUND_MUSIC1, -2593.1321,608.7902,14.4531);
		}
		//-------------------------------SF FBI
		case 7:
		{
			GameTextForPlayer(playerid, "~r~SF FBI", 2000, 5);
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid, -1622.7039,673.5800,-4.9063);
			SetPlayerFacingAngle(playerid,150.9650);
			SetPlayerCameraPos(playerid, -1623.80,670.28,-3.78);
			SetPlayerCameraLookAt(playerid, -1622.7039,673.5800,-4.9063);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1622.7039,673.5800,-4.9063);
		}
		//-------------------------------SF Chicken
		case 8:
		{
			GameTextForPlayer(playerid, "~r~SF CHICKEN", 2000, 5);
			SetPlayerInterior(playerid,9);
			SetPlayerPos(playerid, 369.7185,-4.4895,1001.8147);
			SetPlayerFacingAngle(playerid,180.9218);
			SetPlayerCameraPos(playerid, 369.53,-7.95,1001.86);
			SetPlayerCameraLookAt(playerid, 369.72,-4.49,1001.86);
			PlayerPlaySound(playerid,SOUND_MUSIC1,369.7185,-4.4895,1001.8147);
		}
		//-------------------------------SF Rich
		case 9:
		{
			GameTextForPlayer(playerid, "~r~SF RICH", 2000, 5);
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid, -2680.6270,936.2209,79.7031);
			SetPlayerFacingAngle(playerid,2.7078);
			SetPlayerCameraPos(playerid, -2680.65,938.96,80.53);
			SetPlayerCameraLookAt(playerid, -2680.6270,936.2209,79.7031);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-2680.6270,936.2209,79.7031);
		}
		//-------------------------------SF Pilot
		case 10:
		{
			GameTextForPlayer(playerid, "~r~SF PILOT", 2000, 5);
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid, -1339.0934,-299.9974,14.1484);
			SetPlayerFacingAngle(playerid,173.2872);
			SetPlayerCameraPos(playerid, -1337.09,-306.75,15.64);
			SetPlayerCameraLookAt(playerid, -1339.0934,-299.9974,14.1484);
			PlayerPlaySound(playerid,SOUND_MUSIC1, -1339.0934,-299.9974,14.1484);
		}
		//-------------------------------SF Da Nang
	  	case 11:
		{
			GameTextForPlayer(playerid, "~r~SF DA NANG", 2000, 5);
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid, -1421.1034,1488.5735,11.8084);
			SetPlayerFacingAngle(playerid,267.8500);
			SetPlayerCameraPos(playerid, -1417.55,1488.98,11.74);
			SetPlayerCameraLookAt(playerid, -1421.1034,1488.5735,11.8084);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
		}
		//-------------------------------LV Balla
		case 12:
		{
		    GameTextForPlayer(playerid,"~p~LV Balla",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
		}
		//-------------------------------LV Balla
	    case 13:
		{
		    GameTextForPlayer(playerid,"~p~LV Balla",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
		}
		//-------------------------------LV Balla
	    case 14:
		{
		    GameTextForPlayer(playerid,"~p~LV Balla",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
		}
		//-------------------------------LV Grove
	    case 15:
		{
		    GameTextForPlayer(playerid,"~g~LV Grove",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
		}
		//-------------------------------LV Grove
	    case 16:
		{
		    GameTextForPlayer(playerid,"~g~LV Grove",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
		}
		//-------------------------------LV Grove
	    case 17:
		{
		    GameTextForPlayer(playerid,"~g~LV Grove",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
		}
		//-------------------------------LV Vago
	    case 18:
		{
		    GameTextForPlayer(playerid,"~y~LV Vago",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
		}
		//-------------------------------LV Vago
	    case 19:
		{
		    GameTextForPlayer(playerid,"~y~LV Vago",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Azteca
	    case 20:
		{
		    GameTextForPlayer(playerid,"~h~~b~LV Azteca",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Azteca
	    case 21:
		{
		    GameTextForPlayer(playerid,"~h~~b~LV Azteca",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Azteca
	    case 22:
		{
		    GameTextForPlayer(playerid,"~h~~b~LV Azteca",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Traid
	    case 23:
		{
		    GameTextForPlayer(playerid,"~r~LV Triad",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Traid
	    case 24:
		{
		    GameTextForPlayer(playerid,"~r~LV Triad",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Medic
	    case 25:
		{
		    GameTextForPlayer(playerid,"~b~LV Medic",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Medic
	    case 26:
		{
		    GameTextForPlayer(playerid,"~b~LV Medic",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Fireman
	    case 27:
		{
		    GameTextForPlayer(playerid,"~r~LV Fireman",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Cop
	    case 28:
		{
		    GameTextForPlayer(playerid,"~b~LV Cop",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Cop
	    case 29:
		{
		    GameTextForPlayer(playerid,"~b~LV Cop",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Cop
	    case 30:
		{
		    GameTextForPlayer(playerid,"~b~LV Cop",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Army
	    case 31:
		{
		    GameTextForPlayer(playerid,"~g~LV Army",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LVSwat
	    case 32:
		{
		    GameTextForPlayer(playerid,"~b~LV Swat",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Civillian
	    case 33:
		{
		    GameTextForPlayer(playerid,"~w~LV Civilian",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Civillian
	    case 34:
		{
		    GameTextForPlayer(playerid,"~w~LV Civilian",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Civillian
	    case 35:
		{
		    GameTextForPlayer(playerid,"~w~LV Civilian",700,6);
		    SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Civillian
	    case 36:
		{
	    	GameTextForPlayer(playerid,"~w~LV Civilian",700,6);
	    	SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Civillian
	    case 37:
		{
	    	GameTextForPlayer(playerid,"~w~LV Civilian",700,6);
	    	SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Civillian
	    case 38:
		{
	    	GameTextForPlayer(playerid,"~w~LV Civilian",700,6);
	    	SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
		//-------------------------------LV Civillian
	    case 39:
		{
	    	GameTextForPlayer(playerid,"~w~LV Civilian",700,6);
	    	SetPlayerPos(playerid, 2182.2908,1285.7317,42.9620);
			SetPlayerFacingAngle(playerid, 89.8567);
			SetPlayerCameraPos(playerid, 2177.5269,1285.3782,44.0867);
			SetPlayerCameraLookAt(playerid, 2182.2908,1285.7317,42.9620);
			PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	    }
	    //-------------------------------LS Cop
	    case 40:
	    {
	    	GameTextForPlayer(playerid, "~g~Cop", 500, 3);
	    	SetPlayerInterior(playerid,14);
			SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
			SetPlayerFacingAngle(playerid, 90.0);
			SetPlayerCameraPos(playerid,256.0815,-43.0475,1003.0234);
			SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
			PlayerPlaySound(playerid,SOUND_MUSIC1,258.4893,-41.4008,1002.0234);
		}
	    //-------------------------------LS Cop
	    case 41:
	    {
	        GameTextForPlayer(playerid, "~g~Cop", 500, 3);
	    	SetPlayerInterior(playerid,14);
			SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
			SetPlayerFacingAngle(playerid, 90.0);
			SetPlayerCameraPos(playerid,256.0815,-43.0475,1003.0234);
			SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
			PlayerPlaySound(playerid,SOUND_MUSIC1,258.4893,-41.4008,1002.0234);
		}
	    //-------------------------------LS Grove
	    case 42:
	    {
	    	GameTextForPlayer(playerid, "~g~Grove", 500, 3);
	    	SetPlayerInterior(playerid,14);
			SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
			SetPlayerFacingAngle(playerid, 90.0);
			SetPlayerCameraPos(playerid,256.0815,-43.0475,1003.0234);
			SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
			PlayerPlaySound(playerid,SOUND_MUSIC1,258.4893,-41.4008,1002.0234);
		}
	    //-------------------------------LS Grove
	    case 43:
	    {
	    	GameTextForPlayer(playerid, "~g~Grove", 500, 3);
	    	SetPlayerInterior(playerid,14);
			SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
			SetPlayerFacingAngle(playerid, 90.0);
			SetPlayerCameraPos(playerid,256.0815,-43.0475,1003.0234);
			SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
			PlayerPlaySound(playerid,SOUND_MUSIC1,258.4893,-41.4008,1002.0234);
		}
	    //-------------------------------LS Vagos
	    case 44:
	    {
	    	GameTextForPlayer(playerid, "~g~Vagos", 500, 3);
	    	SetPlayerInterior(playerid,14);
			SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
			SetPlayerFacingAngle(playerid, 90.0);
			SetPlayerCameraPos(playerid,256.0815,-43.0475,1003.0234);
			SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
			PlayerPlaySound(playerid,SOUND_MUSIC1,258.4893,-41.4008,1002.0234);
		}
	    //-------------------------------LS Vagos
	    case 45:
	    {
	    	GameTextForPlayer(playerid, "~g~Vagos", 500, 3);
	    	SetPlayerInterior(playerid,14);
			SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
			SetPlayerFacingAngle(playerid, 90.0);
			SetPlayerCameraPos(playerid,256.0815,-43.0475,1003.0234);
			SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
			PlayerPlaySound(playerid,SOUND_MUSIC1,258.4893,-41.4008,1002.0234);
		}
	    //-------------------------------LS Aztecas
	    case 46:
	    {
	        GameTextForPlayer(playerid, "~g~Aztecas", 500, 3);
	    	SetPlayerInterior(playerid,14);
			SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
			SetPlayerFacingAngle(playerid, 90.0);
			SetPlayerCameraPos(playerid,256.0815,-43.0475,1003.0234);
			SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
			PlayerPlaySound(playerid,SOUND_MUSIC1,258.4893,-41.4008,1002.0234);
		}
	    //-------------------------------LS Aztecas
	    case 47:
	    {
	        GameTextForPlayer(playerid, "~g~Aztecas", 500, 3);
	    	SetPlayerInterior(playerid,14);
			SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
			SetPlayerFacingAngle(playerid, 90.0);
			SetPlayerCameraPos(playerid,256.0815,-43.0475,1003.0234);
			SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
			PlayerPlaySound(playerid,SOUND_MUSIC1,258.4893,-41.4008,1002.0234);
		}
	    //-------------------------------LS Ballas
	    case 48:
	    {
	    	GameTextForPlayer(playerid, "~g~Ballas", 500, 3);
	    	SetPlayerInterior(playerid,14);
			SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
			SetPlayerFacingAngle(playerid, 90.0);
			SetPlayerCameraPos(playerid,256.0815,-43.0475,1003.0234);
			SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
			PlayerPlaySound(playerid,SOUND_MUSIC1,258.4893,-41.4008,1002.0234);
		}
	    //-------------------------------LS Ballas
	    case 49:
	    {
	    	GameTextForPlayer(playerid, "~g~Ballas", 500, 3);
	    	SetPlayerInterior(playerid,14);
			SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
			SetPlayerFacingAngle(playerid, 90.0);
			SetPlayerCameraPos(playerid,256.0815,-43.0475,1003.0234);
			SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
			PlayerPlaySound(playerid,SOUND_MUSIC1,258.4893,-41.4008,1002.0234);
		}
			    //-------------------------------LS PizzaBoy
	    case 50:
	    {
	    	GameTextForPlayer(playerid, "~g~PizzaBoy", 500, 3);
	    	SetPlayerInterior(playerid,14);
			SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
			SetPlayerFacingAngle(playerid, 90.0);
			SetPlayerCameraPos(playerid,256.0815,-43.0475,1003.0234);
			SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
			PlayerPlaySound(playerid,SOUND_MUSIC1,258.4893,-41.4008,1002.0234);
		}
	}
	return 1;
}

SetPlayerClass(playerid, classid)
{
	switch(classid) {
	    case 0:
		{
	    	PlayerInfo[playerid][team] = TEAM_WORKER;
		}
	    case 1: {
	    	PlayerInfo[playerid][team] = TEAM_PIMP;
		}
		case 2: {
	    	PlayerInfo[playerid][team] = TEAM_GOLFER;
		}
		case 3: {
	    	PlayerInfo[playerid][team] = TEAM_TRIAD;
		}
		case 4: {
	    	PlayerInfo[playerid][team] = TEAM_ARMY;
		}
		case 5: {
	    	PlayerInfo[playerid][team] = TEAM_VALET;
		}
	    case 6: {
	    	PlayerInfo[playerid][team] = TEAM_MEDIC;
		}
		case 7: {
	    	PlayerInfo[playerid][team] = TEAM_FBI;
		}
		case 8: {
	    	PlayerInfo[playerid][team] = TEAM_CHICKEN;
		}
		case 9: {
	    	PlayerInfo[playerid][team] = TEAM_RICH;
		}
		case 10: {
	    	PlayerInfo[playerid][team] = TEAM_PILOT;
		}
	    case 11: {
	    	PlayerInfo[playerid][team] = TEAM_DANANG;
		}
	    case 12: {
	    	PlayerInfo[playerid][team] = TEAM_LVBALLA;
		}
	    case 13: {
	    	PlayerInfo[playerid][team] = TEAM_LVBALLA;
		}
	    case 14: {
		    PlayerInfo[playerid][team] = TEAM_LVBALLA;
		}
	    case 15: {
		    PlayerInfo[playerid][team] = TEAM_LVGROVE;
		}
	    case 16: {
		 	PlayerInfo[playerid][team] = TEAM_LVGROVE;
		}
	    case 17: {
	 		PlayerInfo[playerid][team] = TEAM_LVGROVE;
		}
	    case 18: {
	  	 	PlayerInfo[playerid][team] = TEAM_LVVAGO;
		}
	    case 19: {
	   		PlayerInfo[playerid][team] = TEAM_LVVAGO;
	    }
	    case 20: {
	   		PlayerInfo[playerid][team] = TEAM_LVAZTEC;
	    }
	    case 21: {
	    	PlayerInfo[playerid][team] = TEAM_LVAZTEC;
	    }
	    case 22: {
	    	PlayerInfo[playerid][team] = TEAM_LVAZTEC;
	    }
	    case 23: {
	    	PlayerInfo[playerid][team] = TEAM_LVTRIAD;
	    }
	    case 24: {
	    	PlayerInfo[playerid][team] = TEAM_LVTRIAD;
	    }
	    case 25: {
	    	PlayerInfo[playerid][team] = TEAM_LVMEDIC;
	    }
	    case 26: {
	    	PlayerInfo[playerid][team] = TEAM_LVMEDIC;
	    }
	    case 27: {
	    	PlayerInfo[playerid][team] = TEAM_LVFIRE;
	    }
	    case 28: {
	    	PlayerInfo[playerid][team] = TEAM_LVCOP;
    	}
    	case 29: {
    		PlayerInfo[playerid][team] = TEAM_LVCOP;
    	}
    	case 30: {
    		PlayerInfo[playerid][team] = TEAM_LVCOP;
    	}
    	case 31: {
    		PlayerInfo[playerid][team] = TEAM_LVARMY;
    	}
    	case 32: {
    		PlayerInfo[playerid][team] = TEAM_LVCOP;
    	}
    	case 33: {
    		PlayerInfo[playerid][team] = TEAM_LVCIV;
    	}
	    case 34: {
    		PlayerInfo[playerid][team] = TEAM_LVCIV;
    	}
    	case 35: {
    		PlayerInfo[playerid][team] = TEAM_LVCIV;
    	}
    	case 36: {
    		PlayerInfo[playerid][team] = TEAM_LVCIV;
    	}
    	case 37: {
    		PlayerInfo[playerid][team] = TEAM_LVCIV;
    	}
    	case 38: {
    		PlayerInfo[playerid][team] = TEAM_LVCIV;
    	}
    	case 39: {
    		PlayerInfo[playerid][team] = TEAM_LVCIV;
		}
    	case 40: {
    		PlayerInfo[playerid][team] = TEAM_LSCOP;
		}
    	case 41: {
    		PlayerInfo[playerid][team] = TEAM_LSCOP2;
		}
    	case 42: {
    		PlayerInfo[playerid][team] = TEAM_LSGROVE;
		}
    	case 43: {
    		PlayerInfo[playerid][team] = TEAM_LSGROVE2;
		}
    	case 44: {
    		PlayerInfo[playerid][team] = TEAM_LSVAGO;
		}
    	case 45: {
    		PlayerInfo[playerid][team] = TEAM_LSVAGO2;
		}
    	case 46: {
    		PlayerInfo[playerid][team] = TEAM_LSAZTECA;
		}
    	case 47: {
    		PlayerInfo[playerid][team] = TEAM_LSAZTECA2;
		}
    	case 48: {
    		PlayerInfo[playerid][team] = TEAM_LSBALLA;
		}
    	case 49: {
    		PlayerInfo[playerid][team] = TEAM_LSBALLA2;
		}
    	case 50: {
    		PlayerInfo[playerid][team] = TEAM_LSPIZZABOY;
		}
	}
}
//================================Random Functions==============================
public SystemMsg(playerid,msg[])
{
	if ((IsPlayerConnected(playerid))&&(strlen(msg)>0))
	{
		SendClientMessage(playerid,COLOR_SYSTEM,msg);
	}
	return 1;
}
//===============================Kick timer=====================================
public KickTimer(playerid)
{
	if(PlayerInfo[playerid][logged] == 0) {
	    SendClientMessage(playerid,COLOR_BRIGHTRED, "You have been kicked from the server for Login Timeout!");
	    Kick(playerid);
	    new kickmess[256];
	    format(kickmess,sizeof(kickmess),"%s was kicked from the server. Reason: Login Timeout!",PlayerInfo[playerid][name]);
        SendClientMessage(playerid,COLOR_BRIGHTRED,kickmess);
	}
}
//==============================On Player Connect===============================
public OnPlayerConnect(playerid)
{
	playerGang[playerid]=0;
	gangInvite[playerid]=0;
	format(sstring, sizeof(sstring), ".");
	stxt[playerid] = TextDrawCreate(200,350,sstring);
	TextDrawHideForPlayer(playerid, stxt[playerid]);
	TextDrawColor(stxt[playerid], 0xFF0000AA);
	TextDrawSetShadow(stxt[playerid], 2);
	new file[256],playername[256],string[256]; file = GetPlayerFile(playerid);
	GetPlayerName(playerid, playername, sizeof(playername));
	if(Config[DisplayServerMessage]) { format(string,sizeof(string),"Server Message: %s",dini_Get("/xadmin/Configuration/Configuration.ini","ServerMessage")); SendClientMessage(playerid,green,string); }
	format(string, sizeof(string), "^^^ %s has joined the server.(Connect) ^^^", playername);
	SendClientMessageToAll(COLOR_GREY, string);
	if(!dini_Exists(file)) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "-----------------------------------------------------------------------------------------------------------------------");
		format(string, sizeof(string), "Welcome %s, to the new SATDM ~ Role-Play, Biz, Race, KIHC, Gang, XSVM and Xadmin by [CBK]MoNeYPiMp", playername);
		SendClientMessage(playerid, COLOR_ORANGE, string);
		SendClientMessage(playerid, COLOR_BRIGHTRED, "-----------------------------------------------------------------------------------------------------------------------");
		SendClientMessage(playerid,COLOR_YELLOW, "You have been given $25000 starting money since you have no saved money as of yet!");
 		SendClientMessage(playerid,COLOR_YELLOW, "You can register your current player name with '/register [password]'");
       	SendClientMessage(playerid,COLOR_ORANGE, "You must register and login to gain access to money, bank and vehicle saving options!");
       	SendClientMessage(playerid, COLOR_LIGHTBLUE, "Type /help to get started and type /credits for a list of ppl who contributed.");
       	SendClientMessage(playerid, COLOR_BRIGHTRED, "-----------------------------------------------------------------------------------------------------------------------");
       	Variables[playerid][LoggedIn] = false;
       	Variables[playerid][Registered] = false;
       	Variables[playerid][Level] = 0;
		GivePlayerMoney(playerid,25000);
	}
    if(dini_Exists(file)) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "-----------------------------------------------------------------------------------------------------------------------");
		format(string, sizeof(string), "Welcome %s, to the new SATDM ~ Role-Play, Biz, Race, KIHC, Gang, XSVM and Xadmin by [CBK]MoNeYPiMp", playername);
		SendClientMessage(playerid, COLOR_ORANGE, string);
		SendClientMessage(playerid, COLOR_BRIGHTRED, "-----------------------------------------------------------------------------------------------------------------------");
		new tmp[50],tmp2[256]; GetPlayerIp(playerid,tmp,50); tmp2 = dini_Get(file,"IP");
		if(!strcmp(tmp,tmp2,true)) {
	  		format(string,256,"Welcome back, %s. You have automatically been logged in.",playername);
	  		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	  		SendClientMessage(playerid, COLOR_BRIGHTRED, "-----------------------------------------------------------------------------------------------------------------------");
	  		PlayerInfo[playerid][logged] = 1;
	    	Variables[playerid][LoggedIn] = true;
	    	Variables[playerid][Registered] = GetPlayerFileVar(playerid,"Registered");
			Variables[playerid][Level] = GetPlayerFileVar(playerid,"Level");
			Variables[playerid][Wired] = GetPlayerFileVar(playerid,"Wired");
			Variables[playerid][Jailed] = GetPlayerFileVar(playerid,"Jailed");
			if(Variables[playerid][Wired]) SetUserInt(playerid,"WiredWarnings",Config[WiredWarnings]);
			if(Variables[playerid][Level] > Config[MaxLevel]) { Variables[playerid][Level] = Config[MaxLevel]; SetUserInt(playerid,"Level",Config[MaxLevel]); }
	    	LoadPlayer(playerid);
	   	 	ResetPlayerMoney(playerid);
	      	GivePlayerMoney(playerid,PlayerInfo[playerid][pcash]);
		}
	 	else {
			format(string,sizeof(string),"The name %s, is already registered on this server. Please login or you will be disconnected in 60 seconds!",playername);
	 		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	       	SendClientMessage(playerid, COLOR_BRIGHTRED, "-----------------------------------------------------------------------------------------------------------------------");
	       	PlayerInfo[playerid][logged] = 0;
	       	Variables[playerid][LoggedIn] = false;
	       	Variables[playerid][Registered] = GetPlayerFileVar(playerid,"Registered");
			SetTimerEx("KickTimer",60000,0,"i",playerid);
		}
	}
    speedo[playerid] = 1;
	PlayerInfo[playerid][vhpb] = 1;
	Calling[playerid] = -1;
	Answered[playerid] = 0;
	Callerid[playerid] = 0;
	
	checktimer = SetTimerEx("CheckSpeedo", 500, 1,"i",playerid);
	backtimer = SetTimerEx("BackupInfo",120000,1,"i",playerid);
	phonetimer = SetTimerEx("PhoneCut",1000,1,"i",playerid);
	counttimer = SetTimerEx("ctimer",1000,1,"i",playerid);
	paytimer = SetTimerEx("PayDay",PD_TIMER,1,"i",playerid);
	vstimer = SetTimerEx("vehiclestreamer",300,1,"i",playerid);
	mmstimer = SetTimerEx("minimapstreamer",300,1,"i",playerid);
	pstimer = SetTimerEx("pickupstreamer",300,1,"i",playerid);
	//SendClientMessage(playerid,0xC0C0C0FF,"Please choose a language : /en (default is EN)");
}
//===========================Player and Vehicle Stuff===========================
stock LoadPlayer(playerid)
{
    new playername[256];
	new file[256]; file = GetPlayerFile(playerid);
	GetPlayerName(playerid, playername, sizeof(playername));
 	if(dini_Exists(file)) {
 	        PlayerInfo[playerid][name] = playername;
 	        PlayerInfo[playerid][admin] = Variables[playerid][Level];
			PlayerInfo[playerid][vowned] = GetPlayerFileVar(playerid,"Vehicle");
			PlayerInfo[playerid][vowner] = GetPlayerFileVar(playerid,"Vowner");
			PlayerInfo[playerid][pcash] = GetPlayerFileVar(playerid,"Money");
			PlayerInfo[playerid][bank] = GetPlayerFileVar(playerid,"Bank");
			PlayerInfo[playerid][bowner] = GetPlayerFileVar(playerid,"Bowner");
			PlayerInfo[playerid][bowned] = GetPlayerFileVar(playerid,"Bowned");
	}
}

stock SavePlayer(playerid)
{
    new imoney,playername[256]; imoney = GetPlayerMoney(playerid);
	new file[256]; file = GetPlayerFile(playerid);
	GetPlayerName(playerid, playername, sizeof(playername));
 	if(!dini_Exists(file)) {}
 	else {
	    SetUserInt(playerid,"Money",imoney);
	    SetUserInt(playerid,"Vehicle",PlayerInfo[playerid][vowned]);
	    SetUserInt(playerid,"Vowner",PlayerInfo[playerid][vowner]);
	    SetUserInt(playerid,"Bank",PlayerInfo[playerid][bank]);
	    SetUserInt(playerid,"Bowner",PlayerInfo[playerid][bowner]);
	    SetUserInt(playerid,"Bowned",PlayerInfo[playerid][bowned]);
	    }
}

stock ResetOfflinePlayerFileV(pname[])
{
    new fname[256],intname[256];
    format(intname,sizeof(intname),"%s",pname);
    format(fname,sizeof(fname),"/xadmin/Users/%s.ini",udb_encode(intname));
    if(dini_Exists(fname)) {
        dini_IntSet(fname,"Vehicle",0);
        dini_IntSet(fname,"Vowner",0);
	}
}

stock ResetOfflinePlayerFileB(pname[])
{
    new fname[256],intname[256];
    format(intname,sizeof(intname),"%s",pname);
    format(fname,sizeof(fname),"/xadmin/Users/%s.ini",udb_encode(intname));
    if(dini_Exists(fname)) {
        dini_IntSet(fname,"Bowned",0);
        dini_IntSet(fname,"Bowner",0);
    }
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    for(new i = 0; i < MAX_PLAYERS; i++) if(Spec[i][SpectateID] == playerid && Spec[i][Spectating]) { TogglePlayerSpectating(i,false); SetPlayerInterior(i,GetPlayerInterior(playerid)); TogglePlayerSpectating(i,true); PlayerSpectateVehicle(i,vehicleid); }
    passenger[playerid] = ispassenger;
    /*passenger[playerid] = ispassenger;
	if(passenger[playerid] == 0) {
	        if(PlayerInfo[playerid][logged] == 1) {
	            new playername[256];
			    GetPlayerName(playerid,playername,sizeof(playername));
    	   		 if (strcmp(VehicleInfo[streamid][owner],playername,false) == 0) {
					new string[256];
					format(string, sizeof(string), "Welcome to your %s %s, please drive carefully!", VehicleInfo[streamid][name], PlayerInfo[playerid][name]);
					SendClientMessage(playerid, COLOR_GREEN, string);
					return 1;
				}
    	    	if (strcmp(VehicleInfo[streamid][owner],DEFAULT_OWNER,false) == 0) {
               		 if(VehicleInfo[streamid][buybar] == 1) {
                		new string[256];
			        	format(string,sizeof(string),"This %s has been set as non-buyable by server administration!", VehicleInfo[streamid][name]);
			        	SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			        	return 1;
			    	}
			    	new string[256];
    	        	format(string, sizeof(string), "This %s is for sale and costs $%d, type /vmenu to see vehicle options.",VehicleInfo[streamid][name], VehicleInfo[streamid][vehiclecost]);
    	        	SendClientMessage(playerid, COLOR_YELLOW, string);
    	        	return 1;
				}
   				else {
    	        	new string[256];
    	        	format(string, sizeof(string), "This %s belongs to %s, and cannot be purchased.", VehicleInfo[streamid][name], VehicleInfo[streamid][owner]);
    	        	SendClientMessage(playerid, COLOR_BRIGHTRED, string);
    	        	return 1;
				}
			}
			else {
			    new playername[256];
			    GetPlayerName(playerid,playername,sizeof(playername));
			    if (strcmp(VehicleInfo[streamid][owner],playername,false) == 0) {
					new string[256];
					format(string, sizeof(string), "Welcome to your %s %s, please drive carefully! Remember, you must be logged in to acces vehicle controls.", VehicleInfo[streamid][name], playername);
					SendClientMessage(playerid, COLOR_GREEN, string);
					return 1;
				}
    	    	if (strcmp(VehicleInfo[streamid][owner],DEFAULT_OWNER,false) == 0) {
               		 if(VehicleInfo[streamid][buybar] == 1) {
                		new string[256];
			        	format(string,sizeof(string),"This %s has been set as non-buyable by server administration!", VehicleInfo[streamid][name]);
			        	SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			        	return 1;
			    	}
			    	new string[256];
    	        	format(string, sizeof(string), "This %s is for sale and costs $%d, You must be logged in to purchase a vehicle.",VehicleInfo[streamid][name], VehicleInfo[streamid][vehiclecost]);
    	        	SendClientMessage(playerid, COLOR_YELLOW, string);
    	        	return 1;
				}
   				else {
    	        	new string[256];
    	        	format(string, sizeof(string), "This %s belongs to %s, and cannot be purchased.", VehicleInfo[streamid][name], VehicleInfo[streamid][owner]);
    	        	SendClientMessage(playerid, COLOR_BRIGHTRED, string);
    	        	return 1;
				}
			}
    }
	return 1;*/
}

stock SendVWelcome(playerid)
{
	TextDrawHideForPlayer(playerid, stxt[playerid]);
	TextDrawShowForPlayer(playerid, stxt[playerid]);
	new streamid = GetPlayerVehicleStreamID(playerid);
	SetVehicleUsed(GetPlayerVehicleID(playerid),true);
	for(new d=0; d<3; d++) {
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == pbike[d][0]) {
			speedo[playerid] = 2;
		}
	}
	if(passenger[playerid] == 0)
	{
		if(PlayerInfo[playerid][logged] == 1)
		{
			new playername[256];
		    GetPlayerName(playerid,playername,sizeof(playername));
			if (strcmp(VehicleInfo[streamid][owner],playername,false) == 0) {
				new string[256];
				format(string, sizeof(string), "Welcome to your %s %s, please drive carefully!", VehicleInfo[streamid][name], PlayerInfo[playerid][name]);
				SendClientMessage(playerid, COLOR_GREEN, string);
				return 1;
			}
    	   	if (strcmp(VehicleInfo[streamid][owner],DEFAULT_OWNER,false) == 0) {
				if(VehicleInfo[streamid][buybar] == 1) {
					new string[256];
			       	format(string,sizeof(string),"This %s has been set as non-buyable by server administration!", VehicleInfo[streamid][name]);
			       	SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			       	return 1;
  				}
			   	new string[256];
    	       	format(string, sizeof(string), "This %s is for sale and costs $%d, type /vmenu to see vehicle options.",VehicleInfo[streamid][name], VehicleInfo[streamid][vehiclecost]);
    	       	SendClientMessage(playerid, COLOR_YELLOW, string);
    	       	return 1;
			}
   			else {
    	       	new string[256];
    	       	format(string, sizeof(string), "This %s belongs to %s, and cannot be purchased.", VehicleInfo[streamid][name], VehicleInfo[streamid][owner]);
    	       	SendClientMessage(playerid, COLOR_BRIGHTRED, string);
    	       	return 1;
			}
		}
		else {
		    new playername[256];
		    GetPlayerName(playerid,playername,sizeof(playername));
		    if (strcmp(VehicleInfo[streamid][owner],playername,false) == 0) {
				new string[256];
				format(string, sizeof(string), "Welcome to your %s %s, please drive carefully! Remember, you must be logged in to acces vehicle controls.", VehicleInfo[streamid][name], playername);
				SendClientMessage(playerid, COLOR_GREEN, string);
				return 1;
			}
   	    	if (strcmp(VehicleInfo[streamid][owner],DEFAULT_OWNER,false) == 0) {
				if(VehicleInfo[streamid][buybar] == 1) {
               		new string[256];
			       	format(string,sizeof(string),"This %s has been set as non-buyable by server administration!", VehicleInfo[streamid][name]);
			       	SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			       	return 1;
			   	}
			   	new string[256];
    	       	format(string, sizeof(string), "This %s is for sale and costs $%d, You must be logged in to purchase a vehicle.",VehicleInfo[streamid][name], VehicleInfo[streamid][vehiclecost]);
    	       	SendClientMessage(playerid, COLOR_YELLOW, string);
    	       	return 1;
			}
   			else {
    	       	new string[256];
    	       	format(string, sizeof(string), "This %s belongs to %s, and cannot be purchased.", VehicleInfo[streamid][name], VehicleInfo[streamid][owner]);
    	       	SendClientMessage(playerid, COLOR_BRIGHTRED, string);
    	       	return 1;
			}
		}
    }
    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER) {
	    SendVWelcome(playerid);
	    new streamid = GetPlayerVehicleStreamID(playerid);
	    new string[256];
        if(VehicleInfo[streamid][asecure] == 1) {
            if(PlayerInfo[playerid][admin] > 4) {
				format(carmess,sizeof(carmess),"This %s is currently set for admin use only. It will eject anyone who is not an admin.",VehicleInfo[streamid][name]);
                SendClientMessage(playerid,COLOR_ORANGE,carmess);
 		    	return 1;
			}
     		GetPlayerPos(playerid,ta,tb,tc);
     		SetPlayerPos(playerid,ta,tb,tc+5);
 			format(string, sizeof(string), "This %s has been set to allow admin/moderator control only and you are prohibited from using it.",VehicleInfo[streamid][name]);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			return 1;
		}
		if(VehicleInfo[streamid][asecure] == 2) {
		    if(PlayerInfo[playerid][admin] > 4) {
		        format(carmess,sizeof(carmess),"This %s is currently set for admin use only. It will kill anyone who is not an admin.",VehicleInfo[streamid][name]);
                SendClientMessage(playerid,COLOR_ORANGE,carmess);
 		    	return 1;
			}
			new Float:pos[3];
			GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
			CreateExplosion(pos[0],pos[1],pos[2],4,6);
 			format(string, sizeof(string), "Server administration has set this %s to kill anyone who try's to drive it...R.I.P loser!",VehicleInfo[streamid][name]);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "%s just tried to steal an admin only %s and was killed by the car bomb...R.I.P loser!",PlayerInfo[playerid][name],VehicleInfo[streamid][name]);
			SendClientMessageToAll(COLOR_ORANGE, string);
			return 1;
		}
		if(VehicleInfo[streamid][secure] == 0) {
    	    if (strcmp(VehicleInfo[streamid][owner],PlayerInfo[playerid][name],false) == 0) {
				SendClientMessage(playerid, COLOR_GREEN, "Your vehicle security system is currently deactivated.");
		    	return 1;
			}
		}
	 	if(VehicleInfo[streamid][secure] == 1) {
    	    if (strcmp(VehicleInfo[streamid][owner],PlayerInfo[playerid][name],false) == 0) {
				SendClientMessage(playerid, COLOR_GREEN, "Your vehicle security system is currently set to eject intruders.");
		    	return 1;
			}
			if(PlayerInfo[playerid][admin] > 4) {
			    format(string, sizeof(string), "The owner of this %s (%s), has secured this vehicle but as ADMIN you can still use it.",VehicleInfo[streamid][name],VehicleInfo[streamid][owner]);
				SendClientMessage(playerid, COLOR_ORANGE, string);
				return 1;
			}
     		GetPlayerPos(playerid,ta,tb,tc);
     		SetPlayerPos(playerid,ta,tb,tc+5);
 			format(string, sizeof(string), "The owner of this %s (%s), has secured this vehicle and you are prohibited from using it.", VehicleInfo[streamid][name],VehicleInfo[streamid][owner]);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}
 		if(VehicleInfo[streamid][secure] == 2) {
    	    if (strcmp(VehicleInfo[streamid][owner],PlayerInfo[playerid][name],false) == 0) {
				SendClientMessage(playerid, COLOR_GREEN, "Your vehicle security system is currently set to kill intruders.");
		    	return 1;
			}
			if(PlayerInfo[playerid][admin] > 4) {
			    format(string, sizeof(string), "The owner of this %s (%s), has set the vehicle to kill intruders but as ADMIN you can still use it.", VehicleInfo[streamid][name],VehicleInfo[streamid][owner]);
				SendClientMessage(playerid, COLOR_ORANGE, string);
				return 1;
			}
			new Float:pos[3];
			GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
			CreateExplosion(pos[0],pos[1],pos[2],4,6);
 			format(string, sizeof(string), "The owner of this %s (%s), has set this vehicle to kill anyone who try's to drive it...R.I.P loser!",VehicleInfo[streamid][name],VehicleInfo[streamid][owner]);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			format(string, sizeof(string), "%s just tried to steal %s's %s and was killed by the car bomb...R.I.P loser!",PlayerInfo[playerid][name],VehicleInfo[streamid][owner],VehicleInfo[streamid][name]);
			SendClientMessageToAll(COLOR_LIGHTBLUE, string);
			return 1;
		}
	}
	return 1;
}
public OnVehicleDeath(vehicleid)
{
	SetTimerEx("DeathProcess",10000,0,"x",vehicleid);
	VehicleInfo[GetVehicleStreamID(vehicleid)][limbo] = 1;
	return 1;
}

public DeathProcess(vehicleid)
{
	new i = GetVehicleStreamID(vehicleid);
	DestroyVehicle(vehicleid);
	VehicleInfo[i][idnum] = CreateVehicle(VehicleInfo[i][model], VehicleInfo[i][x_spawn], VehicleInfo[i][y_spawn], VehicleInfo[i][z_spawn], VehicleInfo[i][za_spawn], VehicleInfo[i][color_1], VehicleInfo[i][color_2],20000);
    avstream[VehicleInfo[i][idnum]] = i;
 	SetTimerEx("ModVehicle",100,0,"i",i);
	VehicleInfo[i][fspawn] = 0;
	vehused[vehicleid] = 0;
	VehicleInfo[i][limbo] = 0;
}

public OnVehicleMod(vehicleid,componentid)
{
	new streamid = GetVehicleStreamID(vehicleid);
	SaveComponent(streamid,componentid);
	return 1;
}

public OnVehiclePaintjob(vehicleid,paintjobid)
{
    new streamid = GetVehicleStreamID(vehicleid);
    SavePaintjob(streamid,paintjobid);
    return 1;
}

public OnVehicleRespray(vehicleid,color1,color2)
{
    new streamid = GetVehicleStreamID(vehicleid);
   	SaveColors(streamid,color1,color2);
    return 1;
}

public CallVehicleToPlayer(playerid)
{
    new streamid = PlayerInfo[playerid][vowned];
    if(VehicleInfo[streamid][spawned] == 0) {
    	if(Vstreamcount < MAX_ACTIVE_VEHICLES) {
			if(CountModels(vehcount) < MAX_ACTIVE_MODELS) {
			    new Float:x, Float:y, Float:z, Float:a;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid, a);
				x += (3 * floatsin(-a, degrees));
				y += (3 * floatcos(-a, degrees));
				VehicleInfo[streamid][idnum] = CreateVehicle(VehicleInfo[streamid][model],x,y,z-0.35,a+90,VehicleInfo[streamid][color_1],VehicleInfo[streamid][color_2],20000);
                avstream[VehicleInfo[streamid][idnum]] = streamid;
				SetTimerEx("ModVehicle",100,0,"i",streamid);
                SetVehicleUsed(VehicleInfo[streamid][idnum],true);
				format(carmess,sizeof(carmess),"Your %s has been successfully transported to your location!",VehicleInfo[streamid][name]);
                VehicleInfo[streamid][fspawn] = 1;
				SendClientMessage(playerid, COLOR_GREEN, carmess);
				VehicleInfo[streamid][spawned] = 1;
				Vstreamcount++;
			}
			else {
			    SendClientMessage(playerid, COLOR_BRIGHTRED, "Your vehicle cannot be called to you as this server has reached maximum capacity for vehicles at this time.");
			}
		}
		else {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Your vehicle cannot be called to you as this server has reached maximum capacity for vehicles at this time.");
		}
	}
	else {
	    new Float:x, Float:y, Float:z, Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid, a);
		x += (3 * floatsin(-a, degrees));
		y += (3 * floatcos(-a, degrees));
		DestroyVehicle(VehicleInfo[streamid][idnum]);
		VehicleInfo[streamid][idnum] = CreateVehicle(VehicleInfo[streamid][model],x,y,z-0.35,a+90,VehicleInfo[streamid][color_1],VehicleInfo[streamid][color_2],20000);
        avstream[VehicleInfo[streamid][idnum]] = streamid;
		SetTimerEx("ModVehicle",100,0,"i",streamid);
 		SetVehicleUsed(VehicleInfo[streamid][idnum],true);
		format(carmess,sizeof(carmess),"Your %s has been successfully transported to your location!",VehicleInfo[streamid][name]);
        VehicleInfo[streamid][fspawn] = 1;
		SendClientMessage(playerid, COLOR_GREEN, carmess);
	}
	return 1;
}
//================================Reset Count===================================
public resetcount()
{
	for (new i = 0; i < MAX_PLAYERS; i ++)
	{
		if (IsPlayerConnected(i)) cCount[i] = 0;
	}
}
//=================================Announcer====================================
public announcer()
{
	for(new i=0;i<MAX_PLAYERS;i++) {
		if(IsPlayerConnected(i) && aMessage[i] == 1) {
		    aMessage[i] = 0;
		    return 1;
		}
	}
	return 1;
}
//============================On Player Exit Vehicle============================
public OnPlayerExitVehicle(playerid, vehicleid)
{
    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && Spec[i][SpectateID] == playerid  && Spec[i][Spectating]) { TogglePlayerSpectating(i,false); SetPlayerInterior(i,GetPlayerInterior(playerid)); TogglePlayerSpectating(i,true); PlayerSpectatePlayer(i,playerid); }
	TextDrawHideForPlayer(playerid, stxt[playerid]);
	passenger[playerid] = 0;
	return 1;
}
//=============================On Player Spawn==================================
public OnPlayerSpawn(playerid)
{
    if(Variables[playerid][Jailed]) { SetPlayerInterior(playerid,3); SetPlayerPos(playerid,197.6661,173.8179,1003.0234); SetPlayerFacingAngle(playerid,0); }
	if(PlayerInfo[playerid][logged] == 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "-----------------------------------------------------------------------------------------------------------------------");
		SendClientMessage(playerid,COLOR_YELLOW, "You have not logged in yet!");
		SendClientMessage(playerid,COLOR_YELLOW, "Please register your current player name with '/register [password]' and login with '/login [password]'");
		SendClientMessage(playerid, COLOR_BRIGHTRED, "-----------------------------------------------------------------------------------------------------------------------");
	}
	SetPlayerColor(playerid,COLOR_GREY);
	switch(PlayerInfo[playerid][team]) {
		case TEAM_WORKER: {
			GivePlayerWeapon(playerid,23,170);
			GivePlayerWeapon(playerid,25,60);
			GivePlayerWeapon(playerid,30,360);
			SetPlayerColor(playerid,COLOR_GREEN);
			if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
				return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
				SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
    		}
		}
		case TEAM_PIMP: {
			GivePlayerWeapon(playerid,26,100);
			GivePlayerWeapon(playerid,29,360);
			GivePlayerWeapon(playerid,15,1);
			SetPlayerColor(playerid,COLOR_RED);
			if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
				return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
				SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
    		}
		}
		case TEAM_GOLFER: {
			GivePlayerWeapon(playerid,25,80);
			GivePlayerWeapon(playerid,32,300);
			GivePlayerWeapon(playerid,2,1);
			SetPlayerColor(playerid,COLOR_YELLOW);
			if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
				SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
	   		if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
    		}
		}
		case TEAM_TRIAD: {
			GivePlayerWeapon(playerid,32,300);
			GivePlayerWeapon(playerid,30,390);
			GivePlayerWeapon(playerid,4,1);
			SetPlayerColor(playerid,COLOR_PINK);
			if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
				SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
	   		if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
    		}
		}
		case TEAM_ARMY: {
			GivePlayerWeapon(playerid,26,80);
			GivePlayerWeapon(playerid,31,300);
			GivePlayerWeapon(playerid,23,170);
			SetPlayerColor(playerid,COLOR_DARKGREEN);
			if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
				SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
	   		if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
    		}
		}
		case TEAM_VALET: {
			GivePlayerWeapon(playerid,28,300);
			GivePlayerWeapon(playerid,24,100);
			GivePlayerWeapon(playerid,4,1);
			SetPlayerColor(playerid,COLOR_LIGHTBLUE);
			if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
				SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
	   		if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
    		}
		}
		case TEAM_MEDIC: {
			GivePlayerWeapon(playerid,26,100);
			GivePlayerWeapon(playerid,23,170);
			GivePlayerWeapon(playerid,9,1);
			SetPlayerColor(playerid,COLOR_PURPLE);
			if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
				SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
	   		if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
    		}
		}
		case TEAM_FBI: {
			GivePlayerWeapon(playerid,29,360);
			GivePlayerWeapon(playerid,27,100);
			GivePlayerWeapon(playerid,3,1);
			SetPlayerColor(playerid,COLOR_ORANGE);
			if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
				SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
	   		if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
    		}
		}
		case TEAM_CHICKEN: {
			GivePlayerWeapon(playerid,26,200);
			GivePlayerWeapon(playerid,29,390);
			GivePlayerWeapon(playerid,9,1);
			SetPlayerColor(playerid,COLOR_GREY);
			if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
				SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
	   		if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
    		}
	  	}
		case TEAM_RICH: {
	   		GivePlayerWeapon(playerid,27,100);
			GivePlayerWeapon(playerid,24,100);
			GivePlayerWeapon(playerid,28,400);
			SetPlayerColor(playerid,COLOR_SKIN);
			if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
				SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
	   		if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
    		}
		}
		case TEAM_PILOT: {
	   		GivePlayerWeapon(playerid,22,170);
			GivePlayerWeapon(playerid,25,60);
			GivePlayerWeapon(playerid,14,1);
			SetPlayerColor(playerid,COLOR_DARKGREY);
			if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
				SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
	   		if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
    		}
		}
		case TEAM_DANANG: {
	   		GivePlayerWeapon(playerid,24,70);
			GivePlayerWeapon(playerid,27,77);
			GivePlayerWeapon(playerid,28,300);
			SetPlayerColor(playerid,COLOR_DARKRED);
			if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
				SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
	   		if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
    		}
		}
		case TEAM_LVBALLA: {
			GivePlayerWeapon(playerid,32,100);
			GivePlayerWeapon(playerid,25,100);
			GivePlayerWeapon(playerid,4,1);
			SetPlayerColor(playerid,COLOR_BRIGHTRED);
        	if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
				SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
	   		if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
    		}
	   		SetPlayerRandomSpawn(playerid);
		}
		case TEAM_LVGROVE: {
			GivePlayerWeapon(playerid,28,200);
		   	GivePlayerWeapon(playerid,30,200);
		  	GivePlayerWeapon(playerid,4,1);
		   	SetPlayerColor(playerid,COLOR_DARKGREEN);
        	if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
	    		SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
				return 1;
			}
	   		if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
			}
			SetPlayerRandomSpawn(playerid);
		}
		case TEAM_LVVAGO: {
			GivePlayerWeapon(playerid,31,200);
			GivePlayerWeapon(playerid,32,100);
			GivePlayerWeapon(playerid,4,1);
			SetPlayerColor(playerid,COLOR_LIGHTBLUE);
			if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
				SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
				SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
	    	}
	   		SetPlayerRandomSpawn(playerid);
		}
		case TEAM_LVAZTEC: {
			GivePlayerWeapon(playerid,27,100);
			GivePlayerWeapon(playerid,30,200);
			GivePlayerWeapon(playerid,4,1);
			SetPlayerColor(playerid,COLOR_BLUE);
			if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
				SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
				SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
			}
			SetPlayerRandomSpawn(playerid);
		}
		case TEAM_LVTRIAD: {
			GivePlayerWeapon(playerid,27,100);
			GivePlayerWeapon(playerid,30,200);
			GivePlayerWeapon(playerid,4,1);
			SetPlayerColor(playerid,COLOR_YELLOW);
        	if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
	    		SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
	    	}
			SetPlayerRandomSpawn(playerid);
		}
		case TEAM_LVMEDIC: {
			GivePlayerWeapon(playerid,27,100);
			GivePlayerWeapon(playerid,28,200);
			GivePlayerWeapon(playerid,4,1);
			SetPlayerColor(playerid,COLOR_RED);
			if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
	    		SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
			}
			SetPlayerRandomSpawn(playerid);
		}
		case TEAM_LVFIRE: {
			GivePlayerWeapon(playerid,27,100);
			GivePlayerWeapon(playerid,28,200);
			GivePlayerWeapon(playerid,4,1);
			SetPlayerColor(playerid,COLOR_ORANGE);
			if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
	    		SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
			}
			SetPlayerRandomSpawn(playerid);
		}
		case TEAM_LVCOP: {
			GivePlayerWeapon(playerid,24,100);
			GivePlayerWeapon(playerid,31,200);
			GivePlayerWeapon(playerid,4,1);
			SetPlayerColor(playerid,COLOR_DARKBLUE);
			if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
	    		SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
			}
			SetPlayerRandomSpawn(playerid);
		}
		case TEAM_LVARMY: {
			GivePlayerWeapon(playerid,24,100);
			GivePlayerWeapon(playerid,31,200);
			GivePlayerWeapon(playerid,4,1);
			SetPlayerColor(playerid,COLOR_BROWN);
			if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
	    		SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
			}
			SetPlayerRandomSpawn(playerid);
		}
		case TEAM_LVCIV: {
		   	GivePlayerWeapon(playerid,28,200);
		   	GivePlayerWeapon(playerid,30,200);
		   	GivePlayerWeapon(playerid,4,1);
		   	SetPlayerColor(playerid,COLOR_WHITE);
	        if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
	    		SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
			}
			SetPlayerRandomSpawn(playerid);
		}
		case TEAM_LSCOP: {
			SetPlayerColor(playerid,COLOR_BLUE); //BLUE
	        if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
	    		SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
			}
		}
		case TEAM_LSCOP2: {
			SetPlayerColor(playerid,COLOR_BLUE); //BLUE
	        if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
	    		SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
			}
		}
		case TEAM_LSGROVE: {
			SetPlayerColor(playerid,COLOR_GREEN); //GREEN
	        if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
	    		SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
			}
		}
		case TEAM_LSGROVE2: {
			SetPlayerColor(playerid,COLOR_GREEN); //GREEN
	        if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
	    		SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
			}
		}
		case TEAM_LSVAGO: {
			SetPlayerColor(playerid,COLOR_YELLOW); //YELLOW
	        if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
	    		SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
			}
		}
		case TEAM_LSVAGO2: {
			SetPlayerColor(playerid,COLOR_YELLOW); //YELLOW
	        if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
	    		SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
			}
		}
		case TEAM_LSAZTECA: {
			SetPlayerColor(playerid,COLOR_LIGHTBLUE); //LIGHT BLUE
	        if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
	    		SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
			}
		}
		case TEAM_LSAZTECA2: {
			SetPlayerColor(playerid,COLOR_LIGHTBLUE); //LIGHT BLUE
	        if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
	    		SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
			}
		}
		case TEAM_LSBALLA: {
			SetPlayerColor(playerid,COLOR_PURPLE); //Dark Red
	        if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
	    		SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
			}
		}
		case TEAM_LSBALLA2: {
			SetPlayerColor(playerid,COLOR_PURPLE); //Dark Red
	        if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
	    		SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
			}
		}
		case TEAM_LSPIZZABOY: {
			SetPlayerColor(playerid,COLOR_ORANGE); //ORANGE
	        if(PlayerInfo[playerid][frozen] == 1) {
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,2031.2622,1343.2483,10.8203);
		        SetPlayerFacingAngle(playerid,270.1700);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...re-frozen!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][jailed] == 1) {
	    		SetPlayerInterior(playerid,6);
				TogglePlayerControllable(playerid,0);
				SetPlayerPos(playerid,265.1273,77.6823,1001.0391);
				SetPlayerFacingAngle(playerid,271.3259);
				SendClientMessage(playerid,COLOR_BRIGHTRED,"You cannot escape your punishment...Welcome back to jail!!!");
	    		return 1;
			}
			if(PlayerInfo[playerid][logged] == 1 && PlayerInfo[playerid][bowner] == 1) {
	   			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
	    		SendClientMessage(playerid,COLOR_GREEN,"You have been spawned at the entrance to your business");
	    		return 1;
			}
		}
	}
	SetPlayerInterior(playerid, 0);
	GameTextForPlayer(playerid,"~y~PwN Them All!!!", 3000, 5);
	PlayerPlaySound(playerid,SOUND_OFF,-1421.1034,1488.5735,11.8084);
	GangZoneShowForAll(Worker, COLOR_GREEN);
	GangZoneShowForAll(Pimp, COLOR_RED);
	GangZoneShowForAll(Golfer, COLOR_YELLOW);
	GangZoneShowForAll(Triad, COLOR_PINK);
	GangZoneShowForAll(Army, COLOR_DARKGREEN);
	GangZoneShowForAll(Valet, COLOR_LIGHTBLUE);
	GangZoneShowForAll(Medic, COLOR_PURPLE);
	GangZoneShowForAll(FBI, COLOR_ORANGE);
	GangZoneShowForAll(Chicken, COLOR_GREY);
	GangZoneShowForAll(Rich, COLOR_SKIN);
	GangZoneShowForAll(Pilot, COLOR_DARKGREY);
	GangZoneShowForAll(Pilot1, COLOR_DARKGREY);
	GangZoneShowForAll(Pilot2, COLOR_DARKGREY);
	GangZoneShowForAll(DaNang, COLOR_DARKRED);
    return 1;
}
//====================================LV Random Spawns==========================
public SetPlayerRandomSpawn(playerid)
{
	if (iSpawnSet[playerid] == 1)
	{
		new rand = random(sizeof(gCopPlayerSpawns));
		SetPlayerPos(playerid, gCopPlayerSpawns[rand][0], gCopPlayerSpawns[rand][1], gCopPlayerSpawns[rand][2]); // Warp the player
		SetPlayerFacingAngle(playerid, 270.0);
    }
    else if (iSpawnSet[playerid] == 0)
    {
		new rand = random(sizeof(gRandomPlayerSpawns));
		SetPlayerPos(playerid, gRandomPlayerSpawns[rand][0], gRandomPlayerSpawns[rand][1], gRandomPlayerSpawns[rand][2]); // Warp the player
	}
	return 1;
}
//==========================Xadmin Spectate=====================================
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid) {
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && Spec[i][SpectateID] == playerid  && Spec[i][Spectating]) SetPlayerInterior(i,newinteriorid);
	return 1;
}
//============================Anti-Team kill Script=============================
public OnPlayerDeath(playerid, killerid, reason)
{
	new pname[MAX_PLAYER_NAME];
	new string[256];
	new deathreason[20];
	GameTextForPlayer(playerid,"~r~OWNED",10000,1);
	GetPlayerName(playerid, pname, sizeof(pname));
	GetWeaponName(reason, deathreason, 20);
    new pstring[256]; //player message
    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && Spec[i][SpectateID] == playerid  && Spec[i][Spectating]) { TogglePlayerSpectating(i,false); Spec[i][Spectating] = false, Spec[i][SpectateID] = INVALID_PLAYER_ID; }
	if (killerid == INVALID_PLAYER_ID)
	{
		if (reason == WEAPON_DROWN)
		{
			format(string, sizeof(string), "*** %s SANK LIKE A BRICK.", pname);
		}
		else
		{
			if (strlen(deathreason) > 0)
			{
				format(string, sizeof(string), "*** %s GOT OWNED. (%s)", pname, deathreason);
			}
			else
			{
				format(string, sizeof(string), "*** %s GOT OWNED.", pname);
			}
  }
		//SendClientMessageToAll(COLOR_RED, string);
	}
	else
	{
		new killer[MAX_PLAYER_NAME];
		GetPlayerName(killerid, killer, sizeof(killer));
		if (strlen(deathreason) > 0)
		{
			format(string, sizeof(string), "*** %s owned %s. (%s)", killer, pname, deathreason);
		}
		else
		{
			format(string, sizeof(string), "*** %s owned %s.", killer, pname);
		}
        if(killerid != INVALID_PLAYER_ID && gPlayerClass[playerid] == gPlayerClass[killerid])
		{
			KillerID[playerid] = killerid;
			new warning[256];
			format(warning, sizeof(warning), "Be careful! You You may Be punished for Team Killing!");
			SendClientMessage(killerid, 0xFFFF00AA, warning);
	        ShowMenuForPlayer(TK,playerid);
		}
		else
		{
			SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
            new kstring[256]; //killer message
			//new pname[MAX_PLAYER_NAME];   //player name
			GetPlayerName(playerid, pname, sizeof(pname));
			format(kstring, sizeof(kstring), "~b~Haha Ya 0wned %s",pname);
			GameTextForPlayer(killerid, kstring, 4000, 3);
			new kname[MAX_PLAYER_NAME];   //killername
			GetPlayerName(killerid, kname, sizeof(kname));
			format(pstring, sizeof(pstring), "~r~:( you got 0wned by %s",kname);
			GameTextForPlayer(playerid, pstring, 4000, 3);
			return 1;
		}
	}
	SendDeathMessage(killerid,playerid,reason);
	SendClientMessageToAll(COLOR_RED, string);
    new moneytemp;
	moneytemp = GetPlayerMoney(playerid);
    GivePlayerMoney(killerid,moneytemp/2);
	return 1;
}

//==============================Player Disconnect===============================
public OnPlayerDisconnect(playerid,reason)
{
    new playername[MAX_PLAYER_NAME], string[256];
    switch(reason)
    {
        case 0:
        {
             GetPlayerName(playerid, playername, sizeof(playername));
             format(string, sizeof(string), "^^^ %s has left the server.(Timeout) ^^^", playername);
             SendClientMessageToAll(COLOR_GREY, string);
        }
        case 1:
        {
             GetPlayerName(playerid, playername, sizeof(playername));
             format(string, sizeof(string), "^^^ %s has left the server.(Leaving) ^^^", playername);
             SendClientMessageToAll(COLOR_GREY, string);
        }
        case 2:
        {
             GetPlayerName(playerid, playername, sizeof(playername));
             format(string, sizeof(string), "^^^ %s has left the server.(Kicked) ^^^", playername);
             SendClientMessageToAll(COLOR_GREY, string);
        }
    }
	if(RaceParticipant[playerid]>=1)
	{
		if(Participants==1) //Last participant leaving, ending race.
		{
			endrace();
		}
		if(RaceParticipant[playerid] < 3 && RaceStart == 0 && !(RaceParticipant[playerid]==3 && RaceStart == 1))
		{ //Doing readycheck since someone left, but not if they disconnected during countdown.
		    ReadyRefresh();
		}
	    Participants--;
	    RaceParticipant[playerid]=0;
	    DisablePlayerRaceCheckpoint(playerid);
	}
	if(RaceBuilders[playerid] != 0)
	{
   	    DisablePlayerRaceCheckpoint(playerid);
	    for(new i;i<BCurrentCheckpoints[b(playerid)];i++)
	    {
	        BRaceCheckpoints[b(playerid)][i][0]=0.0;
   	        BRaceCheckpoints[b(playerid)][i][1]=0.0;
	        BRaceCheckpoints[b(playerid)][i][2]=0.0;
		}
		BuilderSlots[b(playerid)] = MAX_PLAYERS+1;
		RaceBuilders[playerid] = 0;
	}
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && Spec[i][SpectateID] == playerid  && Spec[i][Spectating]) { TogglePlayerSpectating(i,false); Spec[i][Spectating] = false, Spec[i][SpectateID] = INVALID_PLAYER_ID; }
	KillTimer(checktimer);
	KillTimer(backtimer);
	KillTimer(phonetimer);
	KillTimer(counttimer);
	KillTimer(paytimer);
	KillTimer(vstimer);
	KillTimer(mmstimer);
	KillTimer(pstimer);
	PlayerLeaveGang(playerid);
    return 1;
}
//===============================Race Statements================================
rstrtok(const string[], &index)
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

public LockRacers()
{
	for(new i;i<MAX_PLAYERS;i++)
	{
		if(RaceParticipant[i] != 0)
		{
			TogglePlayerControllable(i,0);
			if(IsPlayerInAnyVehicle(i)) PlayerVehicles[i]=GetPlayerVehicleID(i);
			else PlayerVehicles[i]=0;
		}
	}
}

public UnlockRacers()
{
	for(new i;i<MAX_PLAYERS;i++)
	{
		if(RaceParticipant[i]>0)
		{
			TogglePlayerControllable(i,1);
			if(PlayerVehicles[i] != 0)
			{
				PutPlayerInVehicle(i,PlayerVehicles[i],0);
				PlayerVehicles[i]=0;
			}
		}
	}
}

public countdown() {
	if(RaceStart == 0)  // Locking players, setting the reward and
	{
		RaceStart=1;
		LockRacers();
		new tmpprize, OPot;
		OPot=Pot;
		if(PrizeMode == 1 || PrizeMode == 4)
		{
			if(Racemode == 0 || Racemode == 3) tmpprize = floatround(RLenght);
			else if(Racemode == 1) tmpprize = floatround(LLenght * Racelaps);
			else if(Racemode == 2) tmpprize = floatround(RLenght * 2 * Racelaps);
		}
		tmpprize *= DynaMP;
		if(PrizeMode == 0 || PrizeMode == 3) Pot += Prize;
		else if(PrizeMode == 1 || PrizeMode == 4) Pot += tmpprize;
		if(Participants == 1) Pot=OPot; // Only 1 racer, force reward to entrance fees.
	}
	if(cd>0)
	{
		format(ystring, sizeof(ystring), "%d...",cd);
		for(new i=0;i<MAX_PLAYERS;i++)
		{
			if(RaceParticipant[i]>1)
			{
				RaceSound(i,1056);
			    GameTextForPlayer(i,ystring,1000,3);
		    }
	    }
	}
	else if(cd == 0)
	{
		format(ystring, sizeof(ystring), "~g~GO!",cd);
	    KillTimer(Countdown);
		for(new i=0;i<MAX_PLAYERS;i++)
		{
			if(RaceParticipant[i]>1)
			{
				RaceSound(i,1057);
			    GameTextForPlayer(i,ystring,3000,3);
				RaceParticipant[i]=4;
				CurrentLap[i]=1;
				if(Racemode == 3) SetRaceCheckpoint(i,LCurrentCheckpoint,LCurrentCheckpoint-1);
				else SetRaceCheckpoint(i,0,1);
		    }
	    }
		UnlockRacers();
		RaceTick=tickcount();
	}
	cd--;
}

public SetNextCheckpoint(playerid)
{
	if(Racemode == 0) // Default Mode
	{
		CurrentCheckpoint[playerid]++;
		if(CurrentCheckpoint[playerid] == LCurrentCheckpoint)
		{
			SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],-1);
			RaceParticipant[playerid]=6;
		}
		else SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],CurrentCheckpoint[playerid]+1);
	}
	else if(Racemode == 1) // Ring Mode
	{
		CurrentCheckpoint[playerid]++;
		if(CurrentCheckpoint[playerid] == LCurrentCheckpoint+1 && CurrentLap[playerid] == Racelaps)
		{
			SetRaceCheckpoint(playerid,0,-1);
			RaceParticipant[playerid]=6;
		}
		else if (CurrentCheckpoint[playerid] == LCurrentCheckpoint+1 && CurrentLap[playerid] != Racelaps)
		{
			CurrentCheckpoint[playerid]=0;
			SetRaceCheckpoint(playerid,0,1);
			RaceParticipant[playerid]=5;
		}
		else if(CurrentCheckpoint[playerid] == 1 && RaceParticipant[playerid]==5)
		{
			ChangeLap(playerid);
			if(LCurrentCheckpoint==1)
			{
				SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],0);
			}
			else
			{
				SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],2);
            }
  		    RaceParticipant[playerid]=4;
		}
		else
		{
			if(LCurrentCheckpoint==1 || CurrentCheckpoint[playerid] == LCurrentCheckpoint) SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],0);
			else SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],CurrentCheckpoint[playerid]+1);
		}
	}
	else if(Racemode == 2) // Yoyo-mode
	{
		if(RaceParticipant[playerid]==4)
		{
			if(CurrentCheckpoint[playerid] == LCurrentCheckpoint) // @ Last CP, trigger last-1
			{
			    RaceParticipant[playerid]=5;
				CurrentCheckpoint[playerid]=LCurrentCheckpoint-1;
				SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],CurrentCheckpoint[playerid]-1);
			}
			else if(CurrentCheckpoint[playerid] == LCurrentCheckpoint-1) // Second last CP, set next accordingly
			{
				CurrentCheckpoint[playerid]++;
				SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],CurrentCheckpoint[playerid]-1);
			}
			else
			{
				CurrentCheckpoint[playerid]++;
				SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],CurrentCheckpoint[playerid]+1);
			}
		}
		else if(RaceParticipant[playerid]==5)
		{
			if(CurrentCheckpoint[playerid] == 1 && CurrentLap[playerid] == Racelaps) //Set the finish line
			{
				SetRaceCheckpoint(playerid,0,-1);
				RaceParticipant[playerid]=6;
			}
			else if(CurrentCheckpoint[playerid] == 0) //At finish line, change lap.
			{
				ChangeLap(playerid);
				if(LCurrentCheckpoint==1)
				{
					SetRaceCheckpoint(playerid,1,0);
				}
				else
				{
					SetRaceCheckpoint(playerid,1,2);
	            }
	  		    RaceParticipant[playerid]=4;
			}
			else if(CurrentCheckpoint[playerid] == 1)
			{
				CurrentCheckpoint[playerid]--;
				SetRaceCheckpoint(playerid,0,1);
			}
			else
			{
				CurrentCheckpoint[playerid]--;
				SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],CurrentCheckpoint[playerid]-1);
			}
		}
	}
	else if(Racemode == 3) // Mirror Mode
	{
		CurrentCheckpoint[playerid]--;
		if(CurrentCheckpoint[playerid] == 0)
		{
			SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],-1);
			RaceParticipant[playerid]=6;
		}
		else
		{
			 SetRaceCheckpoint(playerid,CurrentCheckpoint[playerid],CurrentCheckpoint[playerid]-1);
	    }
	}
}

public SetRaceCheckpoint(playerid,target,next)
{
	if(next == -1 && Airrace == 0) SetPlayerRaceCheckpoint(playerid,1,RaceCheckpoints[target][0],RaceCheckpoints[target][1],RaceCheckpoints[target][2],0.0,0.0,0.0,CPsize);
	else if(next == -1 && Airrace == 1) SetPlayerRaceCheckpoint(playerid,4,RaceCheckpoints[target][0],RaceCheckpoints[target][1],RaceCheckpoints[target][2],0.0,0.0,0.0,CPsize);
	else if(Airrace == 1) SetPlayerRaceCheckpoint(playerid,3,RaceCheckpoints[target][0],RaceCheckpoints[target][1],RaceCheckpoints[target][2],RaceCheckpoints[next][0],
							RaceCheckpoints[next][1],RaceCheckpoints[next][2],CPsize);
	else SetPlayerRaceCheckpoint(playerid,0,RaceCheckpoints[target][0],RaceCheckpoints[target][1],RaceCheckpoints[target][2],RaceCheckpoints[next][0],RaceCheckpoints[next][1],
							RaceCheckpoints[next][2],CPsize);
}
public SetBRaceCheckpoint(playerid,target,next)
{
	new ar = BAirrace[b(playerid)];
	if(next == -1 && ar == 0) SetPlayerRaceCheckpoint(playerid,1,BRaceCheckpoints[b(playerid)][target][0],BRaceCheckpoints[b(playerid)][target][1],
								BRaceCheckpoints[b(playerid)][target][2],0.0,0.0,0.0,BCPsize[b(playerid)]);
	else if(next == -1 && ar == 1) SetPlayerRaceCheckpoint(playerid,4,BRaceCheckpoints[b(playerid)][target][0],
				BRaceCheckpoints[b(playerid)][target][1],BRaceCheckpoints[b(playerid)][target][2],0.0,0.0,0.0,
				BCPsize[b(playerid)]);
	else if(ar == 1) SetPlayerRaceCheckpoint(playerid,3,BRaceCheckpoints[b(playerid)][target][0],BRaceCheckpoints[b(playerid)][target][1],BRaceCheckpoints[b(playerid)][target][2],
						BRaceCheckpoints[b(playerid)][next][0],BRaceCheckpoints[b(playerid)][next][1],BRaceCheckpoints[b(playerid)][next][2],BCPsize[b(playerid)]);
	else SetPlayerRaceCheckpoint(playerid,0,BRaceCheckpoints[b(playerid)][target][0],BRaceCheckpoints[b(playerid)][target][1],BRaceCheckpoints[b(playerid)][target][2],
			BRaceCheckpoints[b(playerid)][next][0],BRaceCheckpoints[b(playerid)][next][1],BRaceCheckpoints[b(playerid)][next][2],BCPsize[b(playerid)]);
}

public GetLapTick(playerid)
{
	new tick, lap;
	tick=tickcount();
	if(CurrentLap[playerid]==1)
	{
		lap=tick-RaceTick;
		LastLapTick[playerid]=tick;
	}
	else
	{
		lap=tick-LastLapTick[playerid];
		LastLapTick[playerid]=tick;
	}
	return lap;
}

public GetRaceTick(playerid)
{
	new tick, race;
	tick=tickcount();
	race=tick-RaceTick;
	return race;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(RaceParticipant[playerid]>=1) // See if the player is participating in a race, allows race builders to do their stuff in peace.
	{
		if(RaceParticipant[playerid] == 6) // Player reaches the checkered flag.
	    {
			new rname[MAX_PLAYER_NAME], LapTime, RaceTime;
			LapTime=GetLapTick(playerid);
			RaceTime=GetRaceTick(playerid);
			GetPlayerName(playerid, rname, MAX_PLAYER_NAME);
			RaceParticipant[playerid]=0;
			RaceSound(playerid,1139);
			format(ystring,sizeof(ystring),"%s has finished the race, position: %d",rname,Ranking);
			if (Ranking < 4) SendClientMessageToAll(COLOR_GREEN,ystring);
			else SendClientMessage(playerid,COLOR_GREEN,ystring);
			if(Racemode == ORacemode && ORacelaps == Racelaps)
			{
				new	LapString[10],RaceString[10], laprank, racerank;
				LapString=BeHuman(LapTime);
				RaceString=BeHuman(RaceTime);
				format(ystring,sizeof(ystring),"~w~Racetime: %s",RaceString);
				if(ORacemode!=0) format(ystring,sizeof(ystring),"%s~n~Laptime: %s",ystring,LapString);
				laprank=CheckBestLap(playerid,LapTime);
				if(laprank == 1)
				{
				    format(ystring,sizeof(ystring),"%s~n~~y~LAP RECORD!",ystring);
				}
				racerank=CheckBestRace(playerid,RaceTime);
				if(racerank == 1)
				{
				    format(ystring,sizeof(ystring),"%s~n~~y~TRACK RECORD!",ystring);
				}
			    GameTextForPlayer(playerid,ystring,13000,3);
		    }
			if(Ranking<4)
			{
				new winrar;
				if(Ranking == 1 && Participants == 1) winrar=Pot; // If the player was only participant, give the whole pot.
				else if(Ranking == 1 && Participants == 2) winrar=Pot/6*4; // If only 2 participants, give 4/6ths of the pot.
				else winrar=Pot/6*PrizeMP;  // Otherwise 3/6ths, 2/6ths and 1/6th.
				GivePlayerMoney(playerid,winrar);
				format(ystring,sizeof(ystring),"You have earned $%d from the race!",winrar);
				PrizeMP--;
				SendClientMessage(playerid,COLOR_GREEN,ystring);
			}
			Ranking++;
			Participants--;
	        DisablePlayerRaceCheckpoint(playerid);
	        if(Participants == 0)
	        {
	            endrace();
	        }
	    }
	    else if (RaceStart == 0 && RaceParticipant[playerid]==1) // Player arrives to the start CP for 1st time
	    {
			SendClientMessage(playerid,COLOR_YELLOW,"Type /ready when you are ready to start.");
			SendClientMessage(playerid,COLOR_YELLOW,"NOTE: Your controls will be locked once the countdown starts.");
			RaceParticipant[playerid]=2;
	    }
	    else if (RaceStart==1) // Otherwise switch to the next race CP.
	    {
			RaceSound(playerid,1138);
			SetNextCheckpoint(playerid);
	    }
	}
	return 1;
}

public endrace()
{
    SaveScores(); //If the race had already started, and mode & laps are as originally, save the lapscores and racescores.
	for(new i=0;i<LCurrentCheckpoint;i++)
	{
	    RaceCheckpoints[i][0]=0.0;
	    RaceCheckpoints[i][1]=0.0;
	    RaceCheckpoints[i][2]=0.0;
	}
	LCurrentCheckpoint=0;
    for(new i=0;i<MAX_PLAYERS;i++)
    {
		LastLapTick[i]=0;
        DisablePlayerRaceCheckpoint(i);
		if(RaceParticipant[i]==3) //Player was still /ready-locked, unlocking.
		{
				TogglePlayerControllable(i,1);
		        if(PlayerVehicles[i] != 0)
		        {
		            PutPlayerInVehicle(i,PlayerVehicles[i],0);
		            PlayerVehicles[i]=0;
		        }
		}
        RaceParticipant[i]=0;
    }
	RaceActive=0;
	RaceStart=0;
	Participants=0;
	Pot = 0;
	PrizeMP = 3;
    SendClientMessageToAll(COLOR_YELLOW, "The current race has been finished.");
}

public BActiveCP(playerid,sele)
{
	if(BCurrentCheckpoints[b(playerid)]-1 == sele) SetBRaceCheckpoint(playerid,sele,-1);
	else SetBRaceCheckpoint(playerid,sele,sele+1);
}

public RaceSound(playerid,sound)
{
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	PlayerPlaySound(playerid,sound,x,y,z);
}

public ReadyRefresh()
{
	if(RaceActive==1) //No countdown if no race is active (could occur with /leave)
	{
		new Waiting=0, Ready=0;
		for(new i=0;i<MAX_PLAYERS;i++)
		{
			if(RaceParticipant[i] == 1 || RaceParticipant[i] == 2) Waiting++;
			else if(RaceParticipant[i] == 3) Ready++;
		}
		if(Waiting==0)
		{
			SendClientMessageToAll(COLOR_GREEN,"Everyone is ready, the race begins!");
			cd=5;
			Countdown = SetTimer("countdown",1000,1);
		}
		else if(Ready >= Waiting && MajorityDelay > 0 && MajStart == 0)
		{
			MajStart=1;
			format(ystring,sizeof(ystring),"Half of the racers are ready, race starts in %d seconds!", MajorityDelay);
			SendClientMessageToAll(COLOR_GREEN,ystring);
			MajStartTimer = SetTimer("mscountdown",10000,1);
			mscd= MajorityDelay;
		}
	}
}

public mscountdown()
{
	if(RaceStart == 1 || MajStart == 0)
	{
		MajStart=0;
		KillTimer(MajStartTimer);
	}
	else
	{
		mscd-=10;
		if(mscd <= 0)
		{
			for(new i;i<MAX_PLAYERS;i++)
			{
				if(RaceParticipant[i] != 3 && RaceParticipant[i] != 0)
				{
					GameTextForPlayer(i,"~r~You didn't make it in time!",6000,3);
					DisablePlayerRaceCheckpoint(i);
					RaceParticipant[i]=0;
					Participants--;
				}
				else if (RaceParticipant[i]!=0) SendClientMessage(i,COLOR_GREEN,"Pre-race countdown done, the race beings!");
			}
			KillTimer(MajStartTimer);
			cd=5;
			Countdown = SetTimer("countdown",1000,1);
		}
		else
		{

			new hurry_string[64];
			format(ystring,sizeof(ystring),"~y~Race starting in ~w~%d~y~ seconds!",mscd);
			format(hurry_string,sizeof(hurry_string),"%s~n~~r~HURRY UP AND /READY",ystring);
			for(new i;i<MAX_PLAYERS;i++)
			{
				if(RaceParticipant[i] < 3 && mscd < 31) GameTextForPlayer(i,hurry_string,6000,3);
				else if(RaceParticipant[i] > 0) GameTextForPlayer(i,ystring,6000,3);
			}
		}
	}
}

public CheckBestLap(playerid,laptime)
{
	if(TopLapTimes[4]<laptime && TopLapTimes[4] != 0 || Racemode == 0)
	{
		return 0;  // If the laptime is more than the previous 5th on the top list, skip to end
	}              // Or the race is gamemode 0 where laps don't really apply
	for(new i;i<5;i++)
	{
	    if(TopLapTimes[i] == 0)
	    {
			new playername[MAX_PLAYER_NAME];
	        GetPlayerName(playerid,playername,MAX_PLAYER_NAME);
	        TopLappers[i]=playername;
	        TopLapTimes[i]=laptime;
			ScoreChange=1;
			return i+1;
	    }
		else if(TopLapTimes[i] > laptime)
		{
		    for(new j=4;j>=i;j--)
		    {
		        TopLapTimes[j+1]=TopLapTimes[j];
		        TopLappers[j+1]=TopLappers[j];
		    }
			new playername[MAX_PLAYER_NAME];
	        GetPlayerName(playerid,playername,MAX_PLAYER_NAME);
		    TopLapTimes[i]=laptime;
			TopLappers[i]=playername;
			ScoreChange=1;
			return i+1;
		}
	}
	return -1; //Shouldn't get here.
}

public CheckBestRace(playerid,racetime)
{
	if(TopRacerTimes[4]<racetime && TopRacerTimes[4] != 0) return 0;
	for(new i;i<5;i++)
	{
	    if(TopRacerTimes[i] == 0)
	    {
			new playername[MAX_PLAYER_NAME];
	        GetPlayerName(playerid,playername,MAX_PLAYER_NAME);
	        TopRacers[i]=playername;
	        TopRacerTimes[i]=racetime;
			ScoreChange=1;
			return i+1;
	    }
		else if(TopRacerTimes[i] > racetime)
		{
		    for(new j=4;j>=i;j--)
		    {
		        TopRacerTimes[j+1]=TopRacerTimes[j];
		        TopRacers[j+1]=TopRacers[j];
		    }
			new playername[MAX_PLAYER_NAME];
	        GetPlayerName(playerid,playername,MAX_PLAYER_NAME);
		    TopRacerTimes[i]=racetime;
			TopRacers[i]=playername;
			ScoreChange=1;
			return i+1;
		}
	}
	return -1; //Shouldn't get here.
}

public SaveScores()
{
	if(ScoreChange == 1)
	{
		fremove(CFile);
		new File:f,Float:x,Float:y,Float:z, templine[512];
		f = fopen(CFile,io_write);
		format(templine,sizeof(templine),"YRACE %d %s %d %d %d %f\n", RACEFILE_VERSION, CBuilder, ORacemode, ORacelaps, OAirrace, OCPsize);
		fwrite(f,templine);
		format(templine,sizeof(templine),"%s %d %s %d %s %d %s %d %s %d\n",
				TopRacers[0],TopRacerTimes[0],TopRacers[1], TopRacerTimes[1], TopRacers[2],TopRacerTimes[2],
	 			TopRacers[3],TopRacerTimes[3],TopRacers[4], TopRacerTimes[4]);
		fwrite(f,templine);
		format(templine,sizeof(templine),"%s %d %s %d %s %d %s %d %s %d\n",
				TopLappers[0],TopLapTimes[0],TopLappers[1], TopLapTimes[1], TopLappers[2],TopLapTimes[2],
	 			TopLappers[3],TopLapTimes[3],TopLappers[4], TopLapTimes[4]);
		fwrite(f,templine);
		for(new i = 0; i < LCurrentCheckpoint+1;i++)
		{
			x=RaceCheckpoints[i][0];
			y=RaceCheckpoints[i][1];
			z=RaceCheckpoints[i][2];
			format(templine,sizeof(templine),"%f %f %f\n",x,y,z);
			fwrite(f,templine);
		}
		fclose(f);
	}
	ScoreChange=0;
}
public ChangeLap(playerid)
{
	new LapTime, TimeString[10], checklap;
	LapTime=GetLapTick(playerid);
	TimeString=BeHuman(LapTime);
	format(ystring,sizeof(ystring),"~w~Lap %d/%d - time: %s", CurrentLap[playerid], Racelaps, TimeString);
	if(Racemode == ORacemode && ORacelaps == Racelaps)
	{
		checklap=CheckBestLap(playerid,LapTime);
		if(checklap==1) format(ystring,sizeof(ystring),"%s~n~~y~LAP RECORD!",ystring);
	}
	CurrentLap[playerid]++;
	if(CurrentLap[playerid] == Racelaps) format(ystring,sizeof(ystring),"%s~n~~g~Final lap!",ystring);
	GameTextForPlayer(playerid,ystring,6000,3);
}

BeHuman(ticks)
{
	new HumanTime[10], minutes, seconds, secstring[2], msecstring[3];
	minutes=ticks/60000;
	ticks=ticks-(minutes*60000);
	seconds=ticks/1000;
	ticks=ticks-(seconds*1000);
	if(seconds <10) format(secstring,sizeof(secstring),"0%d",seconds);
	else format(secstring,sizeof(secstring),"%d",seconds);
	format(HumanTime,sizeof(HumanTime),"%d:%s",minutes,secstring);
	if(ticks < 10) format(msecstring,sizeof(msecstring),"00%d", ticks);
	else if(ticks < 100) format(msecstring,sizeof(msecstring),"0%d",ticks);
	else format(msecstring,sizeof(msecstring),"%d",ticks);
	format(HumanTime,sizeof(HumanTime),"%s.%s",HumanTime,msecstring);
	return HumanTime;
}

public LoadTimes(playerid,timemode,tmp[])
{
	new temprace[67], idx;
	format(temprace,sizeof(temprace),"%s.yr",tmp);
    if(strlen(tmp))
    {
		if(!fexist(temprace))
		{
			format(ystring,sizeof(ystring),"Race \'%s\' doesn't exist!",tmp);
			SendClientMessage(playerid,COLOR_YELLOW,ystring);
			return 1;
		}
		else
		{
			new File:f, templine[256], TBuilder[MAX_PLAYER_NAME], TempLapper[MAX_PLAYER_NAME], TempLap;
			idx=0;
			f = fopen(temprace, io_read);
			fread(f,templine,sizeof(templine)); // Read header-line
			if(templine[0] == 'Y') //Checking if the racefile is v0.2+
			{
				new fileversion;
			    rstrtok(templine,idx); // read off YRACE
				fileversion = strval(rstrtok(templine,idx)); // read off the file version
				if(fileversion > RACEFILE_VERSION) // Check if the race is made with a newer version of the racefile format
				{
				    format(ystring,sizeof(ystring),"Race \'%s\' is created with a newer version of YRACE, unable to load.",tmp);
				    SendClientMessage(playerid,COLOR_RED,ystring);
				    return 1;
				}
				TBuilder=rstrtok(templine,idx); // read off RACEBUILDER
				fread(f,templine,sizeof(templine)); // read off best race times
				if(timemode ==1) fread(f,templine,sizeof(templine)); // read off best lap times
				idx=0;
				if(timemode == 0) format(ystring,sizeof(ystring),"%s by %s - Best race times:",tmp,TBuilder);
				else if(timemode == 1) format(ystring,sizeof(ystring),"%s by %s - Best laps:",tmp,TBuilder);
				else return 1;
				SendClientMessage(playerid,COLOR_GREEN,ystring);
				for(new i=0;i<5;i++)
				{
				    TempLapper=rstrtok(templine,idx);
				    TempLap=strval(rstrtok(templine,idx));
					if(TempLap == 0)
					{
					    format(ystring,sizeof(ystring),"%d. None yet",i+1);
						i=6;
					}
					else format(ystring,sizeof(ystring),"%d. %s - %s",i+1,BeHuman(TempLap),TempLapper);
					SendClientMessage(playerid,COLOR_GREEN,ystring);
				}
				return 1;
			}
			else
			{
				format(ystring,sizeof(ystring),"Race \'%s\' doesn't contain any time data.",tmp);
				SendClientMessage(playerid,COLOR_GREEN,ystring);
				return 1;
			}
		}
    }
	return 0;
}

public IsNotAdmin(playerid)
{
    if (!IsPlayerAdmin(playerid))
	{
	    SendClientMessage(playerid, COLOR_RED, "You need to be an admin to use this command!");
	    return 1;
    }
    return 0;
}

public GetBuilderSlot(playerid)
{
	for(new i;i < MAX_BUILDERS; i++)
	{
	    if(!(BuilderSlots[i] < MAX_PLAYERS+1))
	    {
	        BuilderSlots[i] = playerid;
	        RaceBuilders[playerid] = i+1;
			return i+1;
	    }
	}
	return 0;
}

public b(playerid) return RaceBuilders[playerid]-1;

public Float:Distance(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2)
{
	new Float:temp=floatsqroot((x1-x2) * (x1-x2) + (y1-y2) * (y1-y2) + (z1-z2) * (z1-z2));
	if(temp < 0) temp=temp*(-1);
	return temp;
}

public clearrace(playerid)
{
	for(new i=0;i<BCurrentCheckpoints[b(playerid)];i++)
	{
		BRaceCheckpoints[b(playerid)][i][0]=0.0;
		BRaceCheckpoints[b(playerid)][i][1]=0.0;
		BRaceCheckpoints[b(playerid)][i][2]=0.0;
	}
	BCurrentCheckpoints[b(playerid)]=0;
	DisablePlayerRaceCheckpoint(playerid);
	SendClientMessage(playerid, COLOR_GREEN, "Your race has been cleared! Use /buildrace to start a new one.");
	BuilderSlots[b(playerid)] = MAX_PLAYERS+1;
	RaceBuilders[playerid]=0;
}

public startrace()
{
	format(ystring,128,"Race \'%s\' is about to start, type /join to join!",CRaceName);
	SendClientMessageToAll(COLOR_GREEN,ystring);
	if(Racemode == 0) format(ystring,sizeof(ystring),"default");
	else if(Racemode == 1) format(ystring,sizeof(ystring),"ring");
	else if(Racemode == 2) format(ystring,sizeof(ystring),"yoyo");
	else if(Racemode == 3) format(ystring,sizeof(ystring),"mirror");
	format(ystring,sizeof(ystring),"Racemode: %s Laps: %d",ystring,Racelaps);
	if(PrizeMode >= 2) format(ystring,sizeof(ystring),"%s Join fee: %d",ystring,JoinFee);
	if(Airrace == 1) format(ystring,sizeof(ystring),"%s AIR RACE",ystring);
	if(Racemode == 0 || Racemode == 3) format(ystring,sizeof(ystring),"%s Track lenght: %0.2fkm", ystring, RLenght/1000);
	else if(Racemode == 1) format(ystring,sizeof(ystring),"%s Lap lenght: %.2fkm, Total: %.2fkm", ystring, LLenght/1000, LLenght * Racelaps / 1000);
	SendClientMessageToAll(COLOR_GREEN,ystring);
	RaceStart=0;
	RaceActive=1;
	ScoreChange=0;
	Ranking=1;
	PrizeMP=3;
}

ReturnModeName(mode)
{
	new modename[8];
	if(mode == 0) modename="Default";
	else if(mode == 1) modename="Ring";
	else if(mode == 2) modename="Yoyo";
	else if(mode == 3) modename="Mirror";
	return modename;
}

public LoadRace(tmp[])
{
	new race_name[32],templine[512];
	format(CRaceName,sizeof(CRaceName), "%s",tmp);
	format(race_name,sizeof(race_name), "%s.yr",tmp);
	if(!fexist(race_name)) return -1; // File doesn't exist
	CFile=race_name;
    LCurrentCheckpoint=-1; RLenght=0; RLenght=0;
	new File:f, i;
	f = fopen(race_name, io_read);
	fread(f,templine,sizeof(templine));
	if(templine[0] == 'Y') //Checking if the racefile is v0.2+
	{
		new fileversion;
	    rstrtok(templine,i); // read off YRACE
		fileversion = strval(rstrtok(templine,i)); // read off the file version
		if(fileversion > RACEFILE_VERSION) return -2; // Check if the race is made with a newer version of the racefile format
		CBuilder=rstrtok(templine,i); // read off RACEBUILDER
		ORacemode = strval(rstrtok(templine,i)); // read off racemode
		ORacelaps = strval(rstrtok(templine,i)); // read off amount of laps
		if(fileversion > 1)
		{
			Airrace = strval(rstrtok(templine,i));   // read off airrace
			CPsize = floatstr(rstrtok(templine,i));    // read off CP size
		}
		else // v1 file format, set to default
		{
			Airrace = 0;
			CPsize = 8.0;
		}
		OAirrace = Airrace;
		OCPsize = CPsize;
		Racemode=ORacemode; Racelaps=ORacelaps; //Allows changing the modes, but disables highscores if they've been changed.
		fread(f,templine,sizeof(templine)); // read off best race times
		i=0;
		for(new j=0;j<5;j++)
		{
		    TopRacers[j]=rstrtok(templine,i);
		    TopRacerTimes[j]=strval(rstrtok(templine,i));
		}
		fread(f,templine,sizeof(templine)); // read off best lap times
		i=0;
		for(new j=0;j<5;j++)
		{
		    TopLappers[j]=rstrtok(templine,i);
		    TopLapTimes[j]=strval(rstrtok(templine,i));
		}
	}
	else //Otherwise add the lines as checkpoints, the file is made with v0.1 (or older) version of the script.
	{
		LCurrentCheckpoint++;
		RaceCheckpoints[LCurrentCheckpoint][0] = floatstr(rstrtok(templine,i));
		RaceCheckpoints[LCurrentCheckpoint][1] = floatstr(rstrtok(templine,i));
		RaceCheckpoints[LCurrentCheckpoint][2] = floatstr(rstrtok(templine,i));
		Racemode=0; ORacemode=0; Racelaps=0; ORacelaps=0;   //Enables converting old files to new versions
		CPsize = 8.0; Airrace = 0;  			// v2 additions
		OCPsize = CPsize; OAirrace = Airrace;   // v2 additions
		CBuilder="UNKNOWN";
		for(new j;j<5;j++)
		{
		    TopLappers[j]="A"; TopLapTimes[j]=0; TopRacers[j]="A"; TopRacerTimes[j]=0;
		}
	}
	while(fread(f,templine,sizeof(templine),false))
	{
		LCurrentCheckpoint++;
		i=0;
		RaceCheckpoints[LCurrentCheckpoint][0] = floatstr(rstrtok(templine,i));
		RaceCheckpoints[LCurrentCheckpoint][1] = floatstr(rstrtok(templine,i));
		RaceCheckpoints[LCurrentCheckpoint][2] = floatstr(rstrtok(templine,i));
		if(LCurrentCheckpoint >= 1)
		{
		    RLenght+=Distance(RaceCheckpoints[LCurrentCheckpoint][0],RaceCheckpoints[LCurrentCheckpoint][1],
								RaceCheckpoints[LCurrentCheckpoint][2],RaceCheckpoints[LCurrentCheckpoint-1][0],
								RaceCheckpoints[LCurrentCheckpoint-1][1],RaceCheckpoints[LCurrentCheckpoint-1][2]);
		}
	}
	LLenght = RLenght + Distance(RaceCheckpoints[LCurrentCheckpoint][0],RaceCheckpoints[LCurrentCheckpoint][1],
								RaceCheckpoints[LCurrentCheckpoint][2],RaceCheckpoints[0][0],RaceCheckpoints[0][1],
								RaceCheckpoints[0][2]);
	fclose(f);
	return 1;
}

public RaceRotation()
{
	if(!fexist("yrace.rr"))
	{
	    printf("ERROR in  YRACE's Race Rotation (yrace.rr): yrace.rr doesn't exist!");
	    return -1;
	}

	if(RRotation == -1)
	{
		KillTimer(RotationTimer);
		return -1; // RRotation has been disabled
	}
	if(Participants > 0) return 1; // A race is still active.

	new File:f, templine[32], rotfile[]="yrace.rr", rraces=-1, rracenames[32][32], idx, fback;
	f = fopen(rotfile, io_read);
	while(fread(f,templine,sizeof(templine),false))
	{
		idx = 0;
		rraces++;
		rracenames[rraces]=rstrtok(templine,idx);
	}
	fclose(f);
	RRotation++;
	if(RRotation > rraces) RRotation = 0;
	fback = LoadRace(rracenames[RRotation]);
	if(fback == -1) printf("ERROR in YRACE's Race Rotation (yrace.rr): Race \'%s\' doesn't exist!",rracenames[RRotation]);
	else if (fback == -2) printf("ERROR in YRACE's Race Rotation (yrace.rr): Race \'%s\' is created with a newer version of YRACE",rracenames[RRotation]);
	else startrace();
	return 1;
}

#if defined MENUSYSTEM
public RefreshMenuHeader(playerid,Menu:menu,text[])
{
	SetMenuColumnHeader(menu,0,text);
	ShowMenuForPlayer(menu,playerid);
}

public CreateRaceMenus()
{
	//Admin menu
	MAdmin = CreateMenu("Admin menu", 1, 25, 170, 220, 25);
	AddMenuItem(MAdmin,0,"Set prizemode...");
	AddMenuItem(MAdmin,0,"Set fixed prize...");
	AddMenuItem(MAdmin,0,"Set dynamic prize...");
	AddMenuItem(MAdmin,0,"Set entry fees...");
	AddMenuItem(MAdmin,0,"Majority delay...");
	AddMenuItem(MAdmin,0,"End current race");
	AddMenuItem(MAdmin,0,"Toggle Race Admin [RA]");
	AddMenuItem(MAdmin,0,"Toggle Build Admin [BA]");
	AddMenuItem(MAdmin,0,"Toggle Race Rotation [RR]");
	AddMenuItem(MAdmin,0,"Leave");
	if(RaceAdmin == 1) format(ystring,sizeof(ystring),"RA: ON");
	else format(ystring,sizeof(ystring),"RA: off");
	if(BuildAdmin == 1) format(ystring,sizeof(ystring),"%s BA: ON",ystring);
	else format(ystring,sizeof(ystring),"%s BA: off",ystring);
	if(RRotation >= 0) format(ystring,sizeof(ystring),"%s RR: ON",ystring);
	else format(ystring,sizeof(ystring),"%s RR: off",ystring);
	SetMenuColumnHeader(MAdmin,0,ystring);
	//Prizemode menu [Admin submenu]
	MPMode = CreateMenu("Set prizemode:", 1, 25, 170, 220, 25);
	AddMenuItem(MPMode,0,"Fixed");
	AddMenuItem(MPMode,0,"Dynamic");
	AddMenuItem(MPMode,0,"Entry Fee");
	AddMenuItem(MPMode,0,"Entry Fee + Fixed");
	AddMenuItem(MPMode,0,"Entry Fee + Dynamic");
	AddMenuItem(MPMode,0,"Back");
	SetMenuColumnHeader(MPMode,0,"Mode: Fixed");
	//Fixed prize menu
	MPrize = CreateMenu("Fixed prize:", 1, 25, 170, 220, 25);
	AddMenuItem(MPrize,0,"+100$");
	AddMenuItem(MPrize,0,"+1000$");
	AddMenuItem(MPrize,0,"+10000$");
	AddMenuItem(MPrize,0,"-100$");
	AddMenuItem(MPrize,0,"-1000$");
	AddMenuItem(MPrize,0,"-10000$");
	AddMenuItem(MPrize,0,"Back");
	format(ystring,sizeof(ystring),"Amount: %d",Prize);
	SetMenuColumnHeader(MPrize,0,ystring);
	//Dynamic prize menu
	MDyna = CreateMenu("Dynamic Prize:", 1, 25, 170, 220, 25);
	AddMenuItem(MDyna,0,"+1x");
	AddMenuItem(MDyna,0,"+5x");
	AddMenuItem(MDyna,0,"-1x");
	AddMenuItem(MDyna,0,"-5x");
	AddMenuItem(MDyna,0,"Leave");
	format(ystring,sizeof(ystring),"Multiplier: %dx",DynaMP);
	SetMenuColumnHeader(MDyna,0,ystring);
	//Build Menu
	MBuild = CreateMenu("Build Menu", 1, 25, 170, 220, 25);
	AddMenuItem(MBuild,0,"Set laps...");
	AddMenuItem(MBuild,0,"Set racemode...");
	AddMenuItem(MBuild,0,"Checkpoint size...");
	AddMenuItem(MBuild,0,"Toggle air race");
	AddMenuItem(MBuild,0,"Clear the race and exit");
	AddMenuItem(MBuild,0,"Leave");
	SetMenuColumnHeader(MBuild,0,"Air race: off");
	//Laps menu
	MLaps = CreateMenu("Set laps", 1, 25, 170, 220, 25);
	AddMenuItem(MLaps,0,"+1");
	AddMenuItem(MLaps,0,"+5");
	AddMenuItem(MLaps,0,"+10");
	AddMenuItem(MLaps,0,"-1");
	AddMenuItem(MLaps,0,"-5");
	AddMenuItem(MLaps,0,"-10");
	AddMenuItem(MLaps,0,"Back");
	//Racemode menu
	MRacemode = CreateMenu("Racemode", 1, 25, 170, 220, 25);
	AddMenuItem(MRacemode,0,"Default");
	AddMenuItem(MRacemode,0,"Ring");
	AddMenuItem(MRacemode,0,"Yoyo");
	AddMenuItem(MRacemode,0,"Mirror");
	AddMenuItem(MRacemode,0,"Back");
	//Race menu
	MRace = CreateMenu("Race Menu", 1, 25, 170, 220, 25);
	AddMenuItem(MRace,0,"Set laps...");
	AddMenuItem(MRace,0,"Set racemode...");
	AddMenuItem(MRace,0,"Set checkpoint size...");
	AddMenuItem(MRace,0,"Toggle air race");
	AddMenuItem(MRace,0,"Start race");
	AddMenuItem(MRace,0,"Abort new race");
	//Entry fee menu
	MFee = CreateMenu("Entry fees", 1, 25, 170, 220, 25);
	AddMenuItem(MFee,0,"+100");
	AddMenuItem(MFee,0,"+1000");
	AddMenuItem(MFee,0,"+10000");
	AddMenuItem(MFee,0,"-100");
	AddMenuItem(MFee,0,"-1000");
	AddMenuItem(MFee,0,"-10000");
	AddMenuItem(MFee,0,"Back");
	format(ystring,sizeof(ystring),"Fee: %d$",JoinFee);
	SetMenuColumnHeader(MFee,0,ystring);
	//CP size menu
	MCPsize = CreateMenu("CP size", 1, 25, 170, 220, 25);
	AddMenuItem(MCPsize,0,"+0.1");
	AddMenuItem(MCPsize,0,"+1");
	AddMenuItem(MCPsize,0,"+10");
	AddMenuItem(MCPsize,0,"-0.1");
	AddMenuItem(MCPsize,0,"-1");
	AddMenuItem(MCPsize,0,"-10");
	AddMenuItem(MCPsize,0,"Back");
	//Majority Delay menu
	MDelay = CreateMenu("Majority Delay", 1, 25, 170, 220, 25);
	AddMenuItem(MDelay,0,"+10s");
	AddMenuItem(MDelay,0,"+60s");
	AddMenuItem(MDelay,0,"-10s");
	AddMenuItem(MDelay,0,"-60s");
	AddMenuItem(MDelay,0,"Back");
	if(MajorityDelay == 0) format(ystring,sizeof(ystring),"Delay: disabled");
	else format(ystring,sizeof(ystring),"Delay: %ds",MajorityDelay);
	SetMenuColumnHeader(MDelay,0,ystring);
}
#endif
//====================================Speedo====================================
public CheckSpeedo()
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		vstreamid[i] = GetPlayerVehicleStreamID(i);
		if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i))
		{
			if(speedo[i] == 0) {
				TextDrawHideForPlayer(i, stxt[i]);
            }
          	if(speedo[i] == 1)
	        {
		        new Float:x,Float:y,Float:z;
	            new Float:distance,value;
	            GetPlayerPos(i, x, y, z);
	            distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
	            value = floatround(distance * 11000);
	            format(sstring, sizeof(sstring), "Vehicle: %s / MpH: %d / Km/h:%d",VehicleInfo[vstreamid[i]][name],floatround(value/2200),floatround(value/1400));
	            TextDrawSetString(stxt[i],sstring);
	            SavePlayerPos[i][LastX] = x;
	            SavePlayerPos[i][LastY] = y;
	            SavePlayerPos[i][LastZ] = z;
			}
			if(speedo[i] == 2)
	        {
		        new Float:x,Float:y,Float:z;
	            new Float:distance,value;
	            GetPlayerPos(i, x, y, z);
	            distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
	            value = floatround(distance * 11000);
	            format(sstring, sizeof(sstring), "Vehicle: %s / MpH: %d / Km/h: %d",VehicleInfo[vstreamid[i]][name],floatround(value/2200),floatround(value/1400));
				TextDrawSetString(stxt[i],sstring);
				//TextDrawShowForPlayer(i, stxt[i]);
	            SavePlayerPos[i][LastX] = x;
	            SavePlayerPos[i][LastY] = y;
	            SavePlayerPos[i][LastZ] = z;
			}
		}
	}
	return 1;
}
//===================================Commands===================================
public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new idx;
	new string[256];
	cmd = strtok(cmdtext, idx);
	new tmp[256];
	new moneys[MAX_PLAYERS];
	new giveplayer[256];
	new giveplayerid;
	new sendername[256];
	new playermoney[MAX_PLAYERS];
	if(!IsPlayerConnected(playerid)) return 0;
	if(Variables[playerid][Jailed] && Config[DisableJailCommands]) return SendClientMessage(playerid,red,"You can NOT use any commands whilst you are jailed.");
//-----------------------------Xadmin commands(DCMD)----------------------------
	dcmd(register,8,cmdtext);
	dcmd(login,5,cmdtext);
	dcmd(logout,6,cmdtext);
	dcmd(goto,4,cmdtext);
	dcmd(gethere,7,cmdtext);
	dcmd(announce,8,cmdtext);
	dcmd(say,3,cmdtext);
	dcmd(flip,4,cmdtext);
	dcmd(serverinfo,10,cmdtext);
	dcmd(slap,4,cmdtext);
	dcmd(wire,4,cmdtext);
	dcmd(unwire,6,cmdtext);
	dcmd(kick,4,cmdtext);
	dcmd(ban,3,cmdtext);
	dcmd(akill,5,cmdtext);
	dcmd(eject,5,cmdtext);
	dcmd(freeze,6,cmdtext);
	dcmd(unfreeze,8,cmdtext);
	dcmd(outside,7,cmdtext);
	dcmd(healall,7,cmdtext);
	dcmd(givehealth,10,cmdtext);
	dcmd(sethealth,9,cmdtext);
	dcmd(skinall,7,cmdtext);
	dcmd(giveallweapon,13,cmdtext);
	dcmd(resetallweapons,15,cmdtext);
	dcmd(ejectall,8,cmdtext);
	dcmd(freezeall,9,cmdtext);
	dcmd(unfreezeall,11,cmdtext);
	dcmd(giveweapon,10,cmdtext);
	dcmd(god,3,cmdtext);
	dcmd(resetscores,11,cmdtext);
	dcmd(setlevel,8,cmdtext);
	dcmd(setskin,7,cmdtext);
	dcmd(midnight,8,cmdtext);
	dcmd(morning,7,cmdtext);
	dcmd(noon,4,cmdtext);
    dcmd(evening,7,cmdtext);
	dcmd(uconfig,7,cmdtext);
	dcmd(sm,2,cmdtext);
	dcmd(setsm,5,cmdtext);
	dcmd(setcash,7,cmdtext);
	dcmd(givecash,9,cmdtext);
	dcmd(remcash,7,cmdtext);
	dcmd(resetcash,9,cmdtext);
	dcmd(setallcash,10,cmdtext);
	dcmd(giveallcash,11,cmdtext);
	dcmd(remallcash,10,cmdtext);
	dcmd(resetallcash,12,cmdtext);
	dcmd(givearmour,10,cmdtext);
	dcmd(setarmour,9,cmdtext);
	dcmd(armourall,9,cmdtext);
	dcmd(setammo,7,cmdtext);
	dcmd(setscore,8,cmdtext);
	dcmd(ip,2,cmdtext);
	dcmd(ping,4,cmdtext);
	dcmd(explode,7,cmdtext);
	dcmd(settime,7,cmdtext);
	dcmd(setalltime,10,cmdtext);
	dcmd(force,5,cmdtext);
	dcmd(setwanted,9,cmdtext);
	dcmd(setallwanted,12,cmdtext);
	dcmd(setworld,8,cmdtext);
	dcmd(setallworld,11,cmdtext);
	dcmd(setgravity,10,cmdtext);
	dcmd(carcolor,8,cmdtext);
	dcmd(gmx,3,cmdtext);
	dcmd(carhealth,9,cmdtext);
	dcmd(xinfo,5,cmdtext);
	dcmd(setping,7,cmdtext);
	dcmd(givecar,7,cmdtext);
	dcmd(xspec,5,cmdtext);
	dcmd(xjail,5,cmdtext);
	dcmd(xunjail,7,cmdtext);
	dcmd(setname,7,cmdtext);
	dcmd(admins,6,cmdtext);
	dcmd(xcommands,9,cmdtext);
	dcmd(vr,2,cmdtext);
	dcmd(weather,7,cmdtext);
	dcmd(giveadmin,9,cmdtext);
//-----------------------------Race commands (DCMD)-----------------------------
	dcmd(racehelp,8,cmdtext);	// Racehelp - there's a lot of commands!
	dcmd(buildhelp,9,cmdtext);	// Buildhelp - there's a lot of commands!
	dcmd(buildrace,9,cmdtext);	// Buildrace - Start building a new race (suprising!)
	dcmd(cp,2,cmdtext);		  	// cp - Add a checkpoint
	dcmd(scp,3,cmdtext);		// scp - Select a checkpoint
	dcmd(rcp,3,cmdtext);		// rcp - Replace the current checkpoint with a new one
	dcmd(mcp,3,cmdtext);		// mcp - Move the selected checkpoint
	dcmd(dcp,3,cmdtext);       	// dcp - Delete the selected waypoint
	dcmd(clearrace,9,cmdtext);	// clearrace - Clear the current (new) race.
	dcmd(editrace,8,cmdtext);	// editrace - Load an existing race into the builder
	dcmd(saverace,8,cmdtext);	// saverace - Save the current checkpoints to a file
	dcmd(setlaps,7,cmdtext);	// setlaps - Set amount of laps to drive
	dcmd(racemode,8,cmdtext);	// racemode - Set the current racemode
	dcmd(loadrace,8,cmdtext);	// loadrace - Load a race from file and start it
	dcmd(startrace,9,cmdtext);  // starts the loaded race
	dcmd(join,4,cmdtext);		// join - Join the announced race.
	dcmd(leave,5,cmdtext);		// leave - leave the current race.
	dcmd(endrace,7,cmdtext);	// endrace - Complete the current race, clear tables & variables, stop the timer.
	dcmd(ready,5,cmdtext);		// ready - Player is ready to start, lock the controls, prepare for CD.
	dcmd(bestlap,7,cmdtext);	// bestlap - Display the best lap times for the current race
	dcmd(bestrace,8,cmdtext);	// bestrace - Display the best race times for the current race
	dcmd(deleterace,10,cmdtext);// deleterace - Remove the race from disk
	dcmd(airrace,7,cmdtext);    // airrace - Changes the checkpoints to air CPs and back
	dcmd(cpsize,6,cmdtext);     // cpsize - changes the checkpoint size
	dcmd(prizemode,9,cmdtext);
	dcmd(setprize,8,cmdtext);
	#if defined MENUSYSTEM
	dcmd(raceadmin,9,cmdtext);
	dcmd(buildmenu,9,cmdtext);
	#endif
//---------------------------------KIHC Commands--------------------------------
	CallLocalFunction("opct","is",playerid,cmdtext);
	if((strcmp(cmdtext,"/build house small",true)==0) || (strcmp(cmdtext,"/bhs",true)==0))
	{
	    if(IsPlayerAdmin(playerid)){
		    new Float:x,Float:y,Float:z;
		    new hstring[256],interior[256];
		    new randm;
		    GetPlayerPos(playerid,x,y,z);
		    CreateObject(1272,x,y,z,0,0,0);
	        randm = random(4);
			if (randm == 0){
				//Houseo = "SetPlayerInterior(playerid,1);";
				//Housep = "SetPlayerPos(playerid,223.043991,1289.259888,1082.199951);";
				//#define HOUSE_SMALL_ONE 223.043991,1289.259888,1082.199951,1
				interior = "223.043991,1289.259888,1082.199951,1";
			}
			else if (randm == 1){
				//Houseo = "SetPlayerInterior(playerid,15);";
				//Housep = "SetPlayerPos(playerid,295.138977,1474.469971,1080.519897);";
				//#define HOUSE_SMALL_TWO 295.138977,1474.469971,1080.519897,15
				interior = "295.138977,1474.469971,1080.519897,15";
			}
			else if (randm == 2){
				//Houseo = "SetPlayerInterior(playerid,15);";
				//Housep = "SetPlayerPos(playerid,328.493988,1480.589966,1084.449951);";
						//#define HOUSE_SMALL_THREE 328.493988,1480.589966,1084.449951,15
				interior = "328.493988,1480.589966,1084.449951,15";
			}
			else if (randm == 3){
				//Houseo = "SetPlayerInterior(playerid,10);";
				//Housep = "SetPlayerPos(playerid,2262.83,-1137.71,1050.63);";
				//#define HOUSE_SMALL_FOUR 2262.83,-1137.71,1050.63,10
				interior = "2262.83,-1137.71,1050.63,10";
			}
			else if (randm == 4){
				//Houseo = "SetPlayerInterior(playerid,9);";
				//Housep = "SetPlayerPos(playerid,2251.85,-1138.16,1050.63);";
				//#define HOUSE_SMALL_FIVE 2251.85,-1138.16,1050.63,9
				interior = "2251.85,-1138.16,1050.63,9";
			}
			//print("39");
			new File:Hand = fopen("houses.req",io_append);
			format(hstring,256,"AddStaticHouse(%f,%f,%f,%s);\r\n",x,y,z,interior);
			fwrite(Hand,hstring);
			fclose(Hand);
			SendClientMessage(playerid,0xFFFFFFAA,"KIHC: A small sized HOUSE was successfully BUILT.");
			SendClientMessage(playerid,0xFFFFFFAA,"KIHC: Recompile the gamemode and restart the server to see your house!");
		}
		return 1;
	}
	if((strcmp(cmdtext,"/build house medium",true)==0) || (strcmp(cmdtext,"/bhm",true)==0))
	{
	    if(IsPlayerAdmin(playerid)){
		    new Float:x,Float:y,Float:z;
		    new hstring[256],interior[256];
		    new ran;
		    GetPlayerPos(playerid,x,y,z);
		    CreateObject(1272,x,y,z,0,0,0);
	        ran = random(3);
			if (ran == 0)
			{
				//houseo = "SetPlayerInterior(playerid,2);";
				//housep = "SetPlayerPos(playerid,225.756989,1240.000000,1082.149902);";
				//#define HOUSE_MEDIUM_ONE 225.756989,1240.000000,1082.149902,2
				interior = "225.756989,1240.000000,1082.149902,2";

			}
			if (ran == 1)
			{
				//houseo = "SetPlayerInterior(playerid,2);";
				//housep = "SetPlayerPos(playerid,2451.77, -1699.80,1013.51);";
				//#define HOUSE_MEDIUM_TWO 2451.77, -1699.80,1013.51,2
				interior = "2451.77, -1699.80,1013.51,2";
			}
			if (ran == 2)
			{
				//houseo = "SetPlayerInterior(playerid,15);";
				//housep = "SetPlayerPos(playerid,385.803986,1471.769897,1080.209961  );";
				//#define HOUSE_MEDIUM_THREE 385.803986,1471.769897,1080.209961,15
				interior = "385.803986,1471.769897,1080.209961,15";
			}
			if (ran == 3)
			{
				//houseo = "SetPlayerInterior(playerid,10);";
				//housep = "SetPlayerPos(playerid,2260.76,-1210.45,1049.02);";
				//#define HOUSE_MEDIUM_FOUR 2260.76,-1210.45,1049.02,10
				interior = "2260.76,-1210.45,1049.02,10";
			}
			new File:Hand = fopen("houses.req",io_append);
			format(hstring,256,"AddStaticHouse(%f,%f,%f,%s);\r\n",x,y,z,interior);
			fwrite(Hand,hstring);
			fclose(Hand);
			SendClientMessage(playerid,0xFFFFFFAA,"KIHC: A medium sized HOUSE was successfully BUILT.");
			SendClientMessage(playerid,0xFFFFFFAA,"KIHC: Recompile the gamemode and restart the server to see your house!");
		}
		return 1;
	}

	if((strcmp(cmdtext,"/build house large",true)==0) || (strcmp(cmdtext,"/bhl",true)==0))
	{
		if(IsPlayerAdmin(playerid)){
		    new Float:x,Float:y,Float:z;
		    new hstring[256],interior[256];
		    new ran;
		    GetPlayerPos(playerid,x,y,z);
		    CreateObject(1272,x,y,z,0,0,0);
	        ran = random(3);
			if (ran == 0){
				//houseo = "SetPlayerInterior(playerid,3);";
				//housep = "SetPlayerPos(playerid,235.508994,1189.169897,1080.339966);";
				//#define HOUSE_LARGE_ONE 235.508994,1189.169897,1080.339966,3
				interior = "235.508994,1189.169897,1080.339966,3";
			}
			if (ran == 1){
				//houseo = "SetPlayerInterior(playerid,7);";
				//housep = "SetPlayerPos(playerid,225.630997,1022.479980,1084.069946);";
				//#define HOUSE_LARGE_TWO 225.630997,1022.479980,1084.069946,7
				interior = "225.630997,1022.479980,1084.069946,7";
			}
			if (ran == 2){
				//houseo = "SetPlayerInterior(playerid,8);";
				//housep = "SetPlayerPos(playerid,2807.63,-1170.15,1025.57);";
				//#define HOUSE_LARGE_THREE 2807.63,-1170.15,1025.57,8
				interior = "2807.63,-1170.15,1025.57,8";
			}
			if (ran == 3){
				//houseo = "SetPlayerInterior(playerid,1 );";
				//housep = "SetPlayerPos(playerid,-2158.72,641.29,1052.38);";
				//#define HOUSE_LARGE_FOUR -2158.72,641.29,1052.38,1
				interior = "-2158.72,641.29,1052.38,1";
			}
			new File:Hand = fopen("houses.req",io_append);
			format(hstring,256,"AddStaticHouse(%f,%f,%f,%s);\r\n",x,y,z,interior);
			fwrite(Hand,hstring);
			fclose(Hand);
			SendClientMessage(playerid,0xFFFFFFAA,"KIHC: A large sized HOUSE was successfully BUILT.");
			SendClientMessage(playerid,0xFFFFFFAA,"KIHC: Recompile the gamemode and restart the server to see your house!");
		}
		return 1;
	}
//-------------------------------language Choice--------------------------------
	if(strcmp(cmdtext,"/en",true) == 0)
    {
        Language[playerid] = 0;
        SendClientMessage(playerid,0xC0C0C0FF,"You choose the english language.");
        return 1;
    }
//------------------------------------Kill--------------------------------------
	if (strcmp("/kill",cmdtext,true)==0){
	    SetPlayerScore(playerid,GetPlayerScore(playerid)-1);
    	SetPlayerHealth(playerid,0);
		//new pname [MAX_PLAYER_NAME];
	    //new killstring[256];
	    //GetPlayerName(playerid, pname, sizeof(pname));
		//format(killstring, sizeof(killstring), "%s Comit Suicide",pname);
  		//SendClientMessageToAll(COLOR_RED, killstring);
    }
//-------------------------------Vehicle Menu-----------------------------------
	if(strcmp(cmd, "/vmenu", true) == 0)
	{
	    TogglePlayerControllable(playerid, false);
		ShowMenuForPlayer(vehiclemain, playerid);
		return 1;
	}
//---------------------------------Bank System----------------------------------
	if(strcmp(cmd, "/deposit", true) == 0 || strcmp(cmd, "/gdeposit", true) == 0) {
		new gang;
	    if(strcmp(cmd, "/gdeposit", true) == 0)
		gang = 1;
	    if(PlayerInfo[playerid][logged] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command");
		    return 1;
		}
		if(PlayerInfo[playerid][jailed] == 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You are in jail and cannot use this command");
		    return 1;
		}
	    if(CloseToBank(playerid) == 999) {
	        SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a 24/7 in order to use banking!");
			return 1;
	    }
	    if(gang && playerGang[playerid]==0) {
			SendClientMessage(playerid, COLOR_RED, "You are not in a gang!");
			return 1;
		}
		new tmp8[256];
	    tmp8 = strtok(cmdtext, idx);

	    if(!strlen(tmp8)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /(g)deposit [amount]");
			return 1;
	    }
	    moneys[playerid] = strval(tmp8);
	    if(moneys[playerid] < 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must enter an amount greater than 0!");
			return 1;
		}

		if(GetPlayerMoney(playerid) < moneys[playerid]) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You don't have the money for that!");
			return 1;
		}
		GivePlayerMoney(playerid, 0-moneys[playerid]);
        if(gang)
       	gangBank[playerGang[playerid]] = gangBank[playerGang[playerid]]+moneys[playerid];
		else
		PlayerInfo[playerid][bank] = PlayerInfo[playerid][bank]+moneys[playerid];
		if(gang)
		format(string, sizeof(string), "You have deposited $%d, your gang's balance is $%d.", moneys[playerid], gangBank[playerGang[playerid]]);
		else
		format(string, sizeof(string), "You have deposited $%d, your current balance is $%d.", moneys[playerid], PlayerInfo[playerid][bank]);
  		SendClientMessage(playerid, COLOR_GREEN, string);
		SavePlayer(playerid);
		return 1;
	}
//------------------------------Withdraw from Bank------------------------------
	if(strcmp(cmd, "/withdraw", true) == 0 || strcmp(cmd, "/gwithdraw", true) == 0) {
	    new gang;
	    if(PlayerInfo[playerid][logged] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command");
		    return 1;
		}
		if(PlayerInfo[playerid][jailed] == 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You are in jail and cannot use this command");
		    return 1;
		}
	    if(CloseToBank(playerid) == 999) {
	        SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a 24/7 in order to use banking!");
			return 1;
	    }
	    if(strcmp(cmd, "/gwithdraw", true) == 0)
	 	gang = 1;
	 	if(gang && playerGang[playerid]==0) {
			SendClientMessage(playerid, COLOR_RED, "You are not in a gang!");
			return 1;
		}
	    new tmp9[256];
	    tmp9 = strtok(cmdtext, idx);
	    if(!strlen(tmp9)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /(g)withdraw [amount]");
			return 1;
	    }
	    moneys[playerid] = strval(tmp9);
	    if(moneys[playerid] < 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must enter an amount greater than 0!");
			return 1;
		}
  		if(moneys[playerid] > PlayerInfo[playerid][bank]) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "You don't have the money for that!");
			return 1;
     	}
		if(gang)
       	gangBank[playerGang[playerid]] = gangBank[playerGang[playerid]]-moneys[playerid];
		else
		PlayerInfo[playerid][bank] = PlayerInfo[playerid][bank]-moneys[playerid];
		if(gang)
		format(string, sizeof(string), "You have withdrawn $%d, your gang's balance is $%d.", moneys[playerid], gangBank[playerGang[playerid]]);
		else
		format(string, sizeof(string), "You have withdrawn $%d, your current balance is $%d.", moneys[playerid], PlayerInfo[playerid][bank]);
		SendClientMessage(playerid, COLOR_GREEN, string);
		SavePlayer(playerid);
		return 1;
   	}
//-----------------------------------Balance------------------------------------
	if(strcmp(cmd, "/balance", true) == 0 || strcmp(cmd, "/gbalance", true) == 0) {
		new gang;
		if(strcmp(cmd, "/gbalance", true) == 0)
			gang = 1;
	    if(PlayerInfo[playerid][logged] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command");
		    return 1;
		}
		if(PlayerInfo[playerid][jailed] == 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You are in jail and cannot use this command");
		    return 1;
		}
		if(CloseToBank(playerid) == 999) {
	        SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a 24/7 in order to use banking!");
			return 1;
	    }
 		if(gang && playerGang[playerid]==0) {
			SendClientMessage(playerid, COLOR_RED, "You are not in a gang!");
			return 1;
		}
		if(gang)
		format(string, sizeof(string), "Your gang has $%d in the bank.", gangBank[playerGang[playerid]]);
		else
		format(string, sizeof(string), "You have $%d in the bank.", PlayerInfo[playerid][bank]);
		SendClientMessage(playerid, COLOR_GREEN, string);
		return 1;
	}
//----------------------------------Give Cash-----------------------------------
	if(strcmp(cmd, "/givemoney", true) == 0) {
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /givemoney [playerid] [amount]");
			return 1;
		}
		giveplayerid = strval(tmp);
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "USAGE: /givemoney [playerid] [amount]");
			return 1;
		}
		moneys[playerid] = strval(tmp);
		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			playermoney[playerid] = GetPlayerMoney(playerid);
			if (moneys[playerid] > 0 && playermoney[playerid] >= moneys[playerid]) {
	            GivePlayerMoney(playerid, (0 - moneys[playerid]));
	            GivePlayerMoney(giveplayerid, moneys[playerid]);
	            format(string, sizeof(string), "You have sent %s (id: %d), $%d.", giveplayer,giveplayerid, moneys[playerid]);
	            SendClientMessage(playerid, COLOR_GREEN, string);
	            format(string, sizeof(string), "You have recieved $%d from %s (id: %d).", moneys[playerid], sendername, playerid);
	            SendClientMessage(giveplayerid, COLOR_GREEN, string);
	            printf("%s(playerid:%d) has transfered %d to %s(playerid:%d)",sendername, playerid, moneys[playerid], giveplayer, giveplayerid);
			}
			else {
				SendClientMessage(playerid, COLOR_BRIGHTRED, "Invalid transaction amount.");
			}
		}
		else {
			format(string, sizeof(string), "ID:%d is not an active player.", giveplayerid);
            SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}
		return 1;
	}
//-----------------------------------Count Down---------------------------------
	if(strcmp(cmd, "/count", true) == 0) {
	    new seconds;
		tmp = strtok(cmdtext, idx);
		seconds = strval(tmp);
		if(PlayerInfo[playerid][jailed] == 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You are in jail and cannot use this command");
		    return 1;
		}
		if (!seconds)
        	SendClientMessage(playerid, COLOR_BRIGHTRED, "You must enter a duration in seconds.");
  		if (seconds > 20) {
  			SendClientMessage(giveplayerid, COLOR_BRIGHTRED, "You must enter a duration between 1 and 20 seconds");
  			return 1;
  		}

    	else if (cseconds)
        	SendClientMessage(playerid, COLOR_BRIGHTRED, "A countdown is already running.");

    	else
    	{
        	format(cstring,40,"You started a countdown of %d seconds.",seconds);
        	SendClientMessage(playerid,COLOR_LIGHTBLUE, cstring);
        	cseconds = seconds+1;
        	cCount[playerid] = 1;
    	}
    	return 1;
	}
//------------------------------Teleport to Bank--------------------------------
	if(strcmp(cmdtext, "/telebank", true) == 0)
	{
     	if(IsPlayerInAnyVehicle(playerid))
		{
			TextDrawHideForPlayer(playerid, stxt[playerid]);
			SetPlayerInterior(playerid,6);
			SetPlayerPos(playerid,-22.2549,-55.6575,1003.5469);
			GameTextForPlayer(playerid,"The Bank!",2500,3);
			GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]); // save x,y and z for this player.
			GetPlayerFacingAngle(playerid,Pos[playerid][3]); // save the facing angle for this player.
			GetPlayerInterior(playerid);
		}
		else{
			SetPlayerInterior(playerid,6);
			SetPlayerPos(playerid,-22.2549,-55.6575,1003.5469);
			GameTextForPlayer(playerid,"The Bank!",2500,3);
			GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]); // save x,y and z for this player.
			GetPlayerFacingAngle(playerid,Pos[playerid][3]); // save the facing angle for this player.
			GetPlayerInterior(playerid);
		}
		return 1;
	}
	if(strcmp(cmdtext, "/exitbank", true) == 0)
	{
		if(CloseToBank(playerid) == 999) {
	        SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a 24/7 in order to exit the bank!");
			return 1;
	    }
		new interiorid;
		SetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]); // set his saved position x,y and z.
		SetPlayerFacingAngle(playerid,Pos[playerid][3]); // set his saved facing angle.
		SetCameraBehindPlayer(playerid); // set the camera..behind the player (looks better).
		SetPlayerInterior(playerid,interiorid);
		return 1;
	}
//-------------------------------Teleport home----------------------------------
	if (strcmp(cmdtext, "/home", true) == 0)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
	    new Team = PlayerInfo[playerid][team];
		if (Team == TEAM_WORKER)
		{
		    if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),-2062.5583,237.4662,36.2890);
				GameTextForPlayer(playerid,"Worker Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,-2062.5583,237.4662,36.2890);
				GameTextForPlayer(playerid,"Worker Spawn!",2500,3);
			}
		}
	   	else if (Team == TEAM_PIMP)
		{
			if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),-2653.6443,1388.2767,8.0739);
				GameTextForPlayer(playerid,"Pimp Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,-2653.6443,1388.2767,8.0739);
				GameTextForPlayer(playerid,"Pimp Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_GOLFER)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),-2642.2583,-274.9985,8.3506);
				GameTextForPlayer(playerid,"Golfer Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,-2642.2583,-274.9985,8.3506);
				GameTextForPlayer(playerid,"Golfer Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_TRIAD)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),-2188.8037,609.8431,36.2624);
				GameTextForPlayer(playerid,"Triad Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,-2188.8037,609.8431,36.2624);
				GameTextForPlayer(playerid,"Triad Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_ARMY)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),-1377.4271,466.0897,8.9393);
				GameTextForPlayer(playerid,"Army Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,-1377.4271,466.0897,8.9393);
				GameTextForPlayer(playerid,"Army Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_VALET)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),-1754.9976,958.5851,25.8386);
				GameTextForPlayer(playerid,"Valet Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,-1754.9976,958.5851,25.8386);
				GameTextForPlayer(playerid,"Valet Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_MEDIC)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),-2665.4282,635.6348,16.0054);
				GameTextForPlayer(playerid,"Medic Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,-2665.4282,635.6348,16.0054);
				GameTextForPlayer(playerid,"Medic Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_FBI)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),-1635.0077,665.8105,8.4054);
				GameTextForPlayer(playerid,"FBI Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,-1635.0077,665.8105,8.4054);
				GameTextForPlayer(playerid,"FBI Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_CHICKEN)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),-1830.9324,638.9214,31.3054);
				GameTextForPlayer(playerid,"Chicken Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,-1830.9324,638.9214,31.3054);
				GameTextForPlayer(playerid,"Chicken Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_RICH)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),-2664.8037,938.6110,80.7618);
				GameTextForPlayer(playerid,"Rich Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,-2664.8037,938.6110,80.7618);
				GameTextForPlayer(playerid,"Rich Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_PILOT)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),-1358.6774,-243.8737,15.6769);
				GameTextForPlayer(playerid,"Pilot Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,-1358.6774,-243.8737,15.6769);
				GameTextForPlayer(playerid,"Pilot Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_DANANG)
		{
			if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),-1430.1825,1492.3381,8.0482);
				GameTextForPlayer(playerid,"Da Nang Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,-1430.1825,1492.3381,8.0482);
				GameTextForPlayer(playerid,"Da Nang Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LVBALLA)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),832.2958,-1080.4476,24.2969);
				GameTextForPlayer(playerid,"LV Balla Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,832.2958,-1080.4476,24.2969);
				GameTextForPlayer(playerid,"LV Balla Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LVGROVE)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),2495.2207,-1687.3169,13.5152);
				GameTextForPlayer(playerid,"LV Grove Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,2495.2207,-1687.3169,13.5152);
				GameTextForPlayer(playerid,"LV Grove Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LVVAGO)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),2459.0442,-949.4450,80.0800);
				GameTextForPlayer(playerid,"LV Vago Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,2459.0442,-949.4450,80.0800);
				GameTextForPlayer(playerid,"LV Vago Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LVAZTEC)
		{
     		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),1761.7893,-1892.7225,13.5551);
				GameTextForPlayer(playerid,"LV Azteca Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,1761.7893,-1892.7225,13.5551);
				GameTextForPlayer(playerid,"LV Azteca Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LVTRIAD)
		{
	 		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),1499.2067,-937.3587,37.4407);
				GameTextForPlayer(playerid,"LV Triad Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,1499.2067,-937.3587,37.4407);
				GameTextForPlayer(playerid,"LV Triad Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LVMEDIC)
		{
			if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),1499.2067,-937.3587,37.4407);
				GameTextForPlayer(playerid,"LV Medic Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,1499.2067,-937.3587,37.4407);
				GameTextForPlayer(playerid,"LV Medic Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LVFIRE)
		{
    		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),1499.2067,-937.3587,37.4407);
				GameTextForPlayer(playerid,"LV Fire Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,1499.2067,-937.3587,37.4407);
				GameTextForPlayer(playerid,"LV Fire Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LVCOP)
		{
     		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),1552.5618,-1675.3375,16.1953);
				GameTextForPlayer(playerid,"LV Cop Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,1552.5618,-1675.3375,16.1953);
				GameTextForPlayer(playerid,"LV Cop Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LVARMY)
		{
			if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),1552.5618,-1675.3375,16.1953);
				GameTextForPlayer(playerid,"LV Army Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,1552.5618,-1675.3375,16.1953);
				GameTextForPlayer(playerid,"LV Army Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LVCIV)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),1552.5618,-1675.3375,16.1953);
				GameTextForPlayer(playerid,"LV Civ Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,1552.5618,-1675.3375,16.1953);
				GameTextForPlayer(playerid,"LV Civ Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LSCOP)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),1527.4740,-1676.5242,5.8906);
				GameTextForPlayer(playerid,"LS Cop Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,1527.4740,-1676.5242,5.8906);
				GameTextForPlayer(playerid,"LS Cop Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LSCOP2)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),1527.4740,-1676.5242,5.8906);
				GameTextForPlayer(playerid,"LS Cop 2 Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,1527.4740,-1676.5242,5.8906);
				GameTextForPlayer(playerid,"LS Cop 2 Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LSGROVE)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),2516.3032,-1674.7357,13.9314);
				GameTextForPlayer(playerid,"LS Grove Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,2516.3032,-1674.7357,13.9314);
				GameTextForPlayer(playerid,"LS Grove Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LSGROVE2)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),2486.7520,-1646.4600,14.0703);
				GameTextForPlayer(playerid,"LS Grove 2 Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,2486.7520,-1646.4600,14.0703);
				GameTextForPlayer(playerid,"LS Grove 2 Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LSVAGO)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),2627.3525,-1457.3615,31.0251);
				GameTextForPlayer(playerid,"LS Vago Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,2627.3525,-1457.3615,31.0251);
				GameTextForPlayer(playerid,"LS Vago Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LSVAGO2)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),2633.3894,-1435.1416,30.4864);
				GameTextForPlayer(playerid,"LS Vago 2 Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,2633.3894,-1435.1416,30.4864);
				GameTextForPlayer(playerid,"LS Vago 2 Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LSAZTECA)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),1733.9663,-2098.1926,14.0366);
				GameTextForPlayer(playerid,"LS Azteca Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,1733.9663,-2098.1926,14.0366);
				GameTextForPlayer(playerid,"LS Azteca Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LSAZTECA2)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),1804.0708,-2124.1572,13.9424);
				GameTextForPlayer(playerid,"LS Azteca 2 Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,1804.0708,-2124.1572,13.9424);
				GameTextForPlayer(playerid,"LS Azteca 2 Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LSBALLA)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),768.6387,-1696.5547,5.1554);
				GameTextForPlayer(playerid,"LS Balla Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,768.6387,-1696.5547,5.1554);
				GameTextForPlayer(playerid,"LS Balla Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LSBALLA2)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),767.3694,-1655.5189,5.6094);
				GameTextForPlayer(playerid,"LS Balla 2 Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,767.3694,-1655.5189,5.6094);
				GameTextForPlayer(playerid,"LS Balla 2 Spawn!",2500,3);
			}
		}
		else if (Team == TEAM_LSPIZZABOY)
		{
      		if(GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_DRIVER || GetPlayerState(GetDriverID(vehicleid)) == PLAYER_STATE_PASSENGER)
		    {
				SetVehiclePos(GetPlayerVehicleID(playerid),2101.5129,-1806.4567,13.5547);
				GameTextForPlayer(playerid,"LS Pizza Boy Spawn!",2500,3);
			}
			else{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,2101.5129,-1806.4567,13.5547);
				GameTextForPlayer(playerid,"LS Pizza Boy Spawn!",2500,3);
			}
		}
/*		else if (Team == TEAM_YAKUSA)
		{
   			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid,-1951.9547,706.1971,46.9492);
			GameTextForPlayer(playerid,"Yakusa Spawn!",2500,3);
		}*/
		return 1;
	}
//------------------------------------Credits-----------------------------------
	if(strcmp(cmd, "/credits", true) == 0) {
        switch (Language[playerid])
        {
            case 0:
            {
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "San Andreas Team Death Match ~ Role Play + Biz + Race + KIHC + Gangs + XSVM + XAdmin Script by -=[CBK]MoNeYPiMp=-");
				SendClientMessage(playerid, COLOR_YELLOW, "Original Script designer and concept - [CBK]MoNeYPiMp (email <::> moneypimp2@hotmail.com)");
				SendClientMessage(playerid, COLOR_YELLOW, "Extreme Vehicle Management + Streamer Script - By -=tAxI=-");
				SendClientMessage(playerid, COLOR_YELLOW, "XtremeAdmin administrator script by Xtreme embedded by Hellboy!");
				SendClientMessage(playerid, COLOR_YELLOW, "Original code for Vehicle HP bar was made by Mr-Tape - Highly modified by tAxI aka Necrioss");
				SendClientMessage(playerid, COLOR_YELLOW, "Cellphone system code designed and made by [eLg]Beckzyboi (www.elg.uk.tt)");
				SendClientMessage(playerid, COLOR_YELLOW, "Selection Screen Sounds made by CodeMaster");
				SendClientMessage(playerid, COLOR_YELLOW, "Multi Language Code made by Yom");
				SendClientMessage(playerid, COLOR_YELLOW, "Race Script by Yagu, Gang script taken from Jax's LVDM ~MoneyGrub(+LandGrab)");
				SendClientMessage(playerid, COLOR_YELLOW, "Kapils Instant House Constructions by Kapil");
				SendClientMessage(playerid, COLOR_GREEN, "If you wish to use this script or any parts of it in your own gamemode please feel free but you must GIVE CREDIT!!!");
			}
		}
		return 1;
	}
//-------------------------------------Help-------------------------------------
	if(strcmp(cmd, "/help", true) == 0)
	{
        switch (Language[playerid])
        {
            case 0:
            {
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "San Andreas Team Death Match + Role Play + Biz + Streamer + XVM Script by -=[CBK]MoNeYPiMp=-");
				SendClientMessage(playerid, COLOR_YELLOW, "For GENERAL commands, please type /commands, For ADMIN commands, please type /xcommands.");
				SendClientMessage(playerid, COLOR_YELLOW, "For BANK commands please type /bankhelp, For GANG commands, please type /ganghelp.");
				SendClientMessage(playerid, COLOR_YELLOW, "For XVM(vehicle) SYSTEM info, please type /vehiclehelp.");
				SendClientMessage(playerid, COLOR_YELLOW, "For BUSINESS help please type /bizhelp.");
				SendClientMessage(playerid, COLOR_YELLOW, "For CELLPHONE help please type /cellhelp.");
				SendClientMessage(playerid, COLOR_YELLOW, "For TELEPORT commands, please type /telehelp.");
				SendClientMessage(playerid, COLOR_YELLOW, "For RACE commands, please type /racehelp.");
				SendClientMessage(playerid, COLOR_ORANGE, "All your stats are saved permanently, including your own car and any mods you make to it!");
				SendClientMessage(playerid, COLOR_ORANGE, "Type /credits to see a list of the ppl who contributed to this script.");
			}
		}
		return 1;
	}
//---------------------------------Business Help--------------------------------
	if(strcmp(cmd, "/bizhelp", true) == 0) {
		switch (Language[playerid])
        {
            case 0:
            {
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Business System Help ----------");
				SendClientMessage(playerid, COLOR_YELLOW, "Businesses are indicated on the map by the yellow circle icons and in the gameworld by a spinning blue house pickup.");
				SendClientMessage(playerid, COLOR_YELLOW, "Type /buybiz to purchase the business. Must be within 7-8m of business icon.");
				SendClientMessage(playerid, COLOR_YELLOW, "Type /sellbiz to sell your business. Must be within 7-8m of business icon.");
				SendClientMessage(playerid, COLOR_YELLOW, "Type /cashbox to transfer you business' earnings to your personal bank account. Must be within 7-8m of business icon.");
				//SendClientMessage(playerid, COLOR_YELLOW, "Type /gotobiz to teleport to your biz");
			}
		}
		return 1;
	}
//-----------------------------------Phone Help---------------------------------
	if(strcmp(cmd, "/cellhelp", true) == 0) {
        switch (Language[playerid])
        {
            case 0:
            {
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Cellphone System Help ----------");
				SendClientMessage(playerid, COLOR_YELLOW, "Every person has their own cellphone - calls cost $1/second.");
				SendClientMessage(playerid, COLOR_YELLOW, "To make a call - /call [player id].");
				SendClientMessage(playerid, COLOR_YELLOW, "To answer a call - /answer.");
				SendClientMessage(playerid, COLOR_YELLOW, "To end a call - /hangup.");
			}
		}
		return 1;
	}
//-----------------------------------Bank Help----------------------------------
	if(strcmp(cmd, "/bankhelp", true) == 0) {
        switch (Language[playerid])
        {
            case 0:
            {
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Bank Help ----------");
				SendClientMessage(playerid, COLOR_YELLOW, "Teleport to the Bank - /telebank");
				SendClientMessage(playerid, COLOR_YELLOW, "Exit the Bank - /exitbank");
				SendClientMessage(playerid, COLOR_YELLOW, "You must be in an ATM area (located in the 24/7 shops):");
				SendClientMessage(playerid, COLOR_YELLOW, "Deposit Amount - /deposit [amount]");
				SendClientMessage(playerid, COLOR_YELLOW, "Withdraw Amount - /withdraw [amount]");
				SendClientMessage(playerid, COLOR_YELLOW, "Check Balance - /balance");
				SendClientMessage(playerid, COLOR_YELLOW, "Give Cash - /givemoney [recipient id] [amount] - sends a specified amount of money to the specified player id");
				SendClientMessage(playerid, COLOR_ORANGE, "Bank will not be reset when you die or reconnect.");
			}
		}
		return 1;
	}
//---------------------------------Vehicle Help---------------------------------
	if(strcmp(cmd, "/vehiclehelp", true) == 0) {
        switch (Language[playerid])
        {
            case 0:
            {
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Vehicle Help ----------");
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "In order to gain access to your vehicles controls please type /vmenu - can be used in or outside your owned vehicle.");
			}
		}
		return 1;
	}
//--------------------------------Commands list---------------------------------
	if(strcmp(cmd, "/commands", true) == 0) {
        switch (Language[playerid])
        {
            case 0:
            {
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- General Commands ----------");
				SendClientMessage(playerid, COLOR_RED, "To See the server rules type /rules");
				//SendClientMessage(playerid,	COLOR_RED, "Type /CBK if you wanna join the [CBK] Clan!");
				SendClientMessage(playerid, COLOR_YELLOW, "You can use the /register and /login and /logout.");
				SendClientMessage(playerid, COLOR_YELLOW, "To see what admins are online type /admins");
				SendClientMessage(playerid, COLOR_YELLOW, "To start a countdown type /count [time]");
				SendClientMessage(playerid, COLOR_YELLOW, "To slap another player type /slap [player id] [object]");
				SendClientMessage(playerid, COLOR_YELLOW, "To clear Chat Type /clear");
				SendClientMessage(playerid, COLOR_YELLOW, "To commit suicide Type /kill");
			}
		}
		return 1;
	}
//---------------------------------Admin Sell Biz-------------------------------
	if(strcmp(cmd, "/asellbiz", true) == 0) {
	    if(PlayerInfo[playerid][logged] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command");
		    return 1;
		}
		if(PlayerInfo[playerid][jailed] == 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You are in jail and cannot use this command");
		    return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be on foot in order to sell a business!");
			return 1;
		}
		if(ClosestBiz(playerid) == 99) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not close enough to any of the current business icons to use this command");
			return 1;
		}
   	    if (PlayerInfo[playerid][admin] > 0) {
    	    if (strcmp(BizInfo[ClosestBiz(playerid)][owner],DEFAULT_OWNER,false) == 0) {
				format(string,sizeof(string),"This Business (%d) does not have an owner yet!",BizInfo[ClosestBiz(playerid)][name]);
 				SendClientMessage(playerid,COLOR_BRIGHTRED,string);
				return 1;
			}
			new file[256];
			format(file,sizeof(file),P_FILE,udb_encode(BizInfo[ClosestBiz(playerid)][owner]));
			if(fexist(file)) {
			    tempid[playerid] = IsPlayerNameOnline(BizInfo[ClosestBiz(playerid)][owner]);
			    if(tempid[playerid] >= 0 && tempid[playerid] <= MAX_PLAYERS) {
                    BizInfo[ClosestBiz(playerid)][bought] = 0;
					strmid(BizInfo[ClosestBiz(playerid)][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
                    new cbmon = BizInfo[ClosestBiz(playerid)][cashbox],bmon = PlayerInfo[playerid][bank];
					PlayerInfo[tempid[playerid]][bank] = cbmon+bmon;
					BizInfo[ClosestBiz(playerid)][cashbox] = 0;
					PlayerInfo[tempid[playerid]][bowned] = 0;
					PlayerInfo[tempid[playerid]][bowner] = 0;
					format(string, sizeof(string), "You just sold %s's Business (%s).", PlayerInfo[tempid[playerid]][name], BizInfo[ClosestBiz(playerid)][name]);
					SendClientMessage(playerid, COLOR_ORANGE, string);
					format(string, sizeof(string), "Admin (%s) has just sold your Business (%s)! Your cashbox money was sent to your personal bank account", PlayerInfo[playerid][name],BizInfo[ClosestBiz(playerid)][name]);
                    SendClientMessage(tempid[playerid], COLOR_ORANGE, string);
                    new iconid = ClosestBiz(playerid)+1;
					ChangeMapIconModel(iconid,31);
					return 1;
				}
				else {
				    ResetOfflinePlayerFileB(BizInfo[ClosestBiz(playerid)][owner]);
					format(string, sizeof(string), "You just sold %s's Business (%s).", BizInfo[ClosestBiz(playerid)][owner], BizInfo[ClosestBiz(playerid)][name]);
					SendClientMessage(playerid, COLOR_ORANGE, string);
                    BizInfo[ClosestBiz(playerid)][bought] = 0;
                    BizInfo[ClosestBiz(playerid)][cashbox] = 0;
					strmid(BizInfo[ClosestBiz(playerid)][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
                    new iconid = ClosestBiz(playerid)+1;
					ChangeMapIconModel(iconid,31);
					return 1;
				}
			}
			if(!fexist(file)) {
				format(string, sizeof(string), "You just sold %s's Business (%s). The player file was not found and cannot be altered.", PlayerInfo[tempid[playerid]][name], BizInfo[ClosestBiz(playerid)][name]);
				SendClientMessage(playerid, COLOR_GREEN, string);
				BizInfo[ClosestBiz(playerid)][bought] = 0;
				BizInfo[ClosestBiz(playerid)][cashbox] = 0;
				strmid(BizInfo[ClosestBiz(playerid)][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
                new iconid = ClosestBiz(playerid)+1;
				ChangeMapIconModel(iconid,31);
				return 1;
			}
		}
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not a server administrator and cannot use this command!");
		return 1;
	}
//--------------------------------Gang Commands List
	if(strcmp(cmd, "/ganghelp", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN,"Gang commands:");
		SendClientMessage(playerid, COLOR_YELLOW,"/gang create [name]");
		SendClientMessage(playerid, COLOR_YELLOW,"/gang join");
		SendClientMessage(playerid, COLOR_YELLOW,"/gang invite [playerID]");
		SendClientMessage(playerid, COLOR_YELLOW,"/gang quit");
		SendClientMessage(playerid, COLOR_YELLOW,"/ganginfo [number] (no number given shows your gang's info)");
		SendClientMessage(playerid, COLOR_YELLOW,"/gdeposit [money] /gwithdraw [money] /gbalance");
		SendClientMessage(playerid, COLOR_YELLOW,"! (prefix text for gang-chat)");
		return 1;
	}
//------------------------------House admin Help--------------------------------
	if(strcmp(cmd, "houseadmin", true) == 0) {
		switch (Language[playerid]){
			case 0:{
            	if(IsPlayerAdmin(playerid) == 0) {
		   	        SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged on to the server RCON to use this command!");
		   	        SendClientMessage(playerid, COLOR_BRIGHTRED, "Type /rcon login [rcon password] to login to the server rcon!");
		  			return 1;
				}
	   	    	if(IsPlayerAdmin(playerid) == 1 && PlayerInfo[playerid][logged] == 1) {
	   	    	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Admin House Help ----------");
            	    SendClientMessage(playerid, COLOR_YELLOW, "Go to the door of any house and type:");
            	    SendClientMessage(playerid, COLOR_YELLOW, "/build house small or /bhs for a small house.");
            	    SendClientMessage(playerid, COLOR_YELLOW, "/build house medium or /bhm for a medium house.");
            	    SendClientMessage(playerid, COLOR_YELLOW, "/build house large or /bhl for a large house.");
                    SendClientMessage(playerid, COLOR_BRIGHTRED, "For the changes to apply you must simply recompile the script and restart the server!");
                    return 1;
				}
			}
		}
		return 1;
	}
//--------------------------------Teleport Help---------------------------------
	if (strcmp(cmdtext, "/telehelp", true)==0){
        switch (Language[playerid])
        {
            case 0:
            {
			    SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Teleport Help ----------");
				SendClientMessage(playerid,COLOR_SYSTEM,"/home will teleport you home");
				SendClientMessage(playerid,COLOR_SYSTEM,"/sp will save your position");
				SendClientMessage(playerid,COLOR_SYSTEM,"/lp will teleport you to the position you saved");
				SendClientMessage(playerid,COLOR_SYSTEM,"/telebank will teleport you to the bank");
				SendClientMessage(playerid,COLOR_SYSTEM,"/exitbank will teleport you to your location before teleporting to the bank");
			}
		}
		return 1;
	}
//-----------------------------------Save pos-----------------------------------
	if (strcmp(cmdtext, "/sp", true)==0){
        switch (Language[playerid])
        {
            case 0:
            {
				GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]); // save x,y and z for this player.
				GetPlayerFacingAngle(playerid,Pos[playerid][3]); // save the facing angle for this player.
				SendClientMessage(playerid,RED,"Position saved!"); // send him a red message.
			}
		}
		return 1;
	}
//-----------------------------------Load pos-----------------------------------
	else if (strcmp(cmdtext, "/lp", true)==0){
        switch (Language[playerid])
        {
            case 0:
            {
				SetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]); // set his saved position x,y and z.
				SetPlayerFacingAngle(playerid,Pos[playerid][3]); // set his saved facing angle.
				SetCameraBehindPlayer(playerid); // set the camera..behind the player (looks better).
				SendClientMessage(playerid,RED,"You teleported!"); // send him a red message.
			}
		}
	   	return 1;
	}
//-------------------------------------Rules------------------------------------
	if (strcmp(cmdtext, "/rules", true)== 0){
        switch (Language[playerid])
        {
            case 0:
            {
				SendClientMessage(playerid, 0x33AA33AA, ".:[SFTDM Reloaded™].:.[Rules and Regulations]:.");
				SendClientMessage(playerid, COLOR_RED, "NO CHEATING OR USING HACKS!! Or You will GET BANNED");
				SendClientMessage(playerid, COLOR_RED, "No Flaming or Abuse!!!");
				SendClientMessage(playerid, COLOR_RED, "No Spawn Killing or Team killing!!");
				SendClientMessage(playerid, COLOR_RED, "No Car Jacking!! Respect other peoples rides, Get your Own!!");
			}
		}
		return 1;
	}
//--------------------------Recrutment for [CBK] Clan---------------------------
	if (strcmp(cmdtext, "/CBK", true)==0){
        switch (Language[playerid])
        {
            case 0:
            {
				SendClientMessage(playerid, 0x99FF00AA, "-=[CBK] Rectuitment Info=-");
				SendClientMessage(playerid, 0x99FF00AA, "1.Read server Rules first (/rules)");
				SendClientMessage(playerid, 0x99FF00AA, "2.Dont cheat");
				SendClientMessage(playerid, 0x99FF00AA, "3.Go to http://cbk.110mb.com and go to forum then recruitment :D");
				SendClientMessage(playerid, 0x99FF00AA, "4.Put an Application Forward");
				SendClientMessage(playerid, 0x99FF00AA, "5.Wait to be contacted by admin, if your ok you will be told to go on tryouts");
				SendClientMessage(playerid, 0x99FF00AA, "6.Good Luck!");
			}
		}
		return 1;
	}
//-------------------------------Admin Clear Chat-------------------------------
	if (strcmp(cmdtext, "/clearall", true)==0) {
		if (PlayerInfo[playerid][admin] > 0){
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			return 1;
		}
	}
//-------------------------------Player Clear Chat------------------------------
	if (strcmp(cmdtext, "/clear", true)==0) {
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		return 1;
	}
//-------------------------------------Slap-------------------------------------
	if(strcmp(cmd, "/slap", true) == 0)
	{
 		if(PlayerInfo[playerid][jailed] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You are in jail and cannot use this command");
		    return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Usage: /slap [playerid] [object]");
			return 1;
		}
		giveplayerid = strval(tmp);
		tmp = strtok(cmdtext, idx, strlen(cmdtext));
		if (!strlen(tmp)){
  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Usage: /slap [playerid] [object]");
       		return 1;
    	}
		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
		 	format(string, sizeof(string), "%s bitch slaps %s across the face with a %s", sendername, giveplayer, tmp);
			SendClientMessageToAll(COLOR_INDIGO, string);
			for(new i=0; i < MAX_PLAYERS; i++) {
   				new Float:fx, Float:fy, Float:fz;
				GetPlayerPos(i, fx,fy,fz);
				PlayerPlaySound(i, 1190, fx,fy,fz);
    		}
    		return 1;
		}
		else
		{
		 	format(string, sizeof(string), "ID:%d is not an active player ID number.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}
		return 1;
	}
//-----------------------------------Buy Biz------------------------------------
	if(strcmp(cmd, "/buybiz", true) == 0) {
	    if(PlayerInfo[playerid][logged] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command");
		    return 1;
		}
		if(PlayerInfo[playerid][jailed] == 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You are in jail and cannot use this command");
		    return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be on foot in order to purchase a business!");
			return 1;
		}
		if(ClosestBiz(playerid) == 99) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not close enough to any of the current business icons to use this command");
            return 1;
		}
		if (strcmp(BizInfo[ClosestBiz(playerid)][owner],PlayerInfo[playerid][name],false) == 0) {
			format(string, sizeof(string), "You already own this Business (%s)", BizInfo[ClosestBiz(playerid)][name]);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}
		if(BizInfo[ClosestBiz(playerid)][bought] == 1) {
			format(string, sizeof(string), "This Business (%s) is owned by %s, and is not for sale!", BizInfo[ClosestBiz(playerid)][name], BizInfo[ClosestBiz(playerid)][owner]);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}
		if(PlayerInfo[playerid][bowner] == 1) {
  			SendClientMessage(playerid, COLOR_BRIGHTRED, "You can only own ONE Business at a time! You must sell your other Business first!");
     		return 1;
		}
		new cash[MAX_PLAYERS];
		cash[playerid] = GetPlayerMoney(playerid);
		if(cash[playerid] >= BizInfo[ClosestBiz(playerid)][cost]) {
		    new stringa[256];
   	 		strmid(BizInfo[ClosestBiz(playerid)][owner], PlayerInfo[playerid][name], 0, strlen(PlayerInfo[playerid][name]), 255);
            BizInfo[ClosestBiz(playerid)][bought] = 1;
            PlayerInfo[playerid][bowner] = 1;
            PlayerInfo[playerid][bowned] = ClosestBiz(playerid);
			GivePlayerMoney(playerid, -BizInfo[ClosestBiz(playerid)][cost]);
			format(stringa, sizeof(stringa), "You just bought this Business (%s) for $%d. Your Business will earn you $%d/hour", BizInfo[ClosestBiz(playerid)][name], BizInfo[ClosestBiz(playerid)][cost],BizInfo[ClosestBiz(playerid)][profit]*2);
			SendClientMessage(playerid, COLOR_GREEN, stringa);
			SavePlayer(playerid);
			SaveBusinesses();
			new iconid = ClosestBiz(playerid)+1;
    		ChangeMapIconModel(iconid,32);
			return 1;
		}
		if(cash[playerid] < BizInfo[ClosestBiz(playerid)][cost]) {
		    new string6[256];
			format(string6, sizeof(string6), "You do not have $%d and cannot afford this Business (%s)!", BizInfo[ClosestBiz(playerid)][cost],BizInfo[ClosestBiz(playerid)][name]);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string6);
		}
		return 1;
	}
//-------------------------------------Sell Biz---------------------------------
	if(strcmp(cmd, "/sellbiz", true) == 0) {
	    if(PlayerInfo[playerid][logged] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command");
		    return 1;
		}
		if(PlayerInfo[playerid][jailed] == 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You are in jail and cannot use this command");
		    return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be on foot in order to sell a business!");
			return 1;
		}
		if(ClosestBiz(playerid) == 99) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not close enough to any of the current business icons to use this command");
			return 1;
		}
		if(PlayerInfo[playerid][bowner] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not currently own any business!");
			return 1;
		}
  		if (strcmp(BizInfo[ClosestBiz(playerid)][owner],PlayerInfo[playerid][name],false) == 0) {
    		PlayerInfo[playerid][bowned] = 0;
			PlayerInfo[playerid][bowner] = 0;
			strmid(BizInfo[ClosestBiz(playerid)][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
			BizInfo[ClosestBiz(playerid)][bought] = 0;
			new cbmon = BizInfo[ClosestBiz(playerid)][cashbox],bmon = PlayerInfo[playerid][bank];
			BizInfo[ClosestBiz(playerid)][cashbox] = 0;
			PlayerInfo[playerid][bank] = cbmon+bmon;
			GivePlayerMoney(playerid, BizInfo[ClosestBiz(playerid)][cost]);
			format(string, sizeof(string), "You just sold your Business (%s) for $%d, the money that was in the cashbox ($%d) has been sent to your bank!!!", BizInfo[ClosestBiz(playerid)][name], BizInfo[ClosestBiz(playerid)][cost],cbmon);
			SendClientMessage(playerid, COLOR_GREEN, string);
			SavePlayer(playerid);
			SaveBusinesses();
			new iconid = ClosestBiz(playerid)+1;
			ChangeMapIconModel(iconid,31);
			return 1;
  		}
  		else {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "What are you trying to pull here, you don't own this Business!!!");
			return 1;
		}
	}
//---------------------------------Get Biz Profit-------------------------------
	if(strcmp(cmd, "/cashbox", true) == 0) {
	    if(PlayerInfo[playerid][logged] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command");
		    return 1;
		}
		if(PlayerInfo[playerid][jailed] == 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You are in jail and cannot use this command");
		    return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be on foot in order to collect a business' earnings!");
			return 1;
		}
		if(ClosestBiz(playerid) == 99) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not close enough to any of the current business icons to use this command");
			return 1;
		}
		if(PlayerInfo[playerid][bowner] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not currently own any business!");
			return 1;
		}
  		if (strcmp(BizInfo[ClosestBiz(playerid)][owner],PlayerInfo[playerid][name],false) == 0) {
			new cbmon = BizInfo[ClosestBiz(playerid)][cashbox],bmon = PlayerInfo[playerid][bank];
			PlayerInfo[playerid][bank] = cbmon+bmon;
			format(string, sizeof(string), "The earnings for your Business (%s - $%d), have been wired to your personal bank account!!!", BizInfo[ClosestBiz(playerid)][name], BizInfo[ClosestBiz(playerid)][cashbox]);
			SendClientMessage(playerid, COLOR_GREEN, string);
			BizInfo[ClosestBiz(playerid)][cashbox] = 0;
			SavePlayer(playerid);
			return 1;
  		}
  		else {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "What are you trying to pull here, you don't own this Business!!!");
			return 1;
		}
	}
//------------------------------------GOTO Biz----------------------------------
/*	if(strcmp(cmd, "/gotobiz", true) == 0)
	(
		if(PlayerInfo[playerid][bowner] == 1) {
			SetPlayerPos(playerid,BizInfo[PlayerInfo[playerid][bowned]][xpos],BizInfo[PlayerInfo[playerid][bowned]][ypos],BizInfo[PlayerInfo[playerid][bowned]][zpos]);
			SendClientMessage(playerid,COLOR_GREEN,"Welcome to your business");
			return 1;
		}
	}*/
//------------------------------Tempoerily Remove Car---------------------------
	if(strcmp(cmd, "/tempRemCar", true) == 0)
	{
		if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,COLOR_LIGHTBLUE, "Must be an rcon admin to use this command.");
	    cmd = strtok(cmdtext,idx);
		if(strlen(!cmd)) return SendClientMessage(playerid,COLOR_LIGHTBLUE, "USAGE: /tempRemCar [vehicleid]");
		if(strval(cmd) > 400 || strval(cmd) < 0) return SendClientMessage(playerid,COLOR_LIGHTBLUE, "Please enter a valid vehicleid to be used.");
		SetVehicleVirtualWorld(strval(cmd), 911);
		format(string,sizeof(string),"Vehicle [%d] has been temporarily removed from server. To unremove, /tempAddCar [vehicleid]",strval(cmd));
		SendClientMessage(playerid,COLOR_GREEN,string);
		return 1;
	}
//------------------------------Tempoerily Add Car------------------------------
	if(strcmp(cmd, "/tempAddCar", true) == 0)
	{
		if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,COLOR_LIGHTBLUE, "Must be an rcon admin to use this command.");
	    cmd = strtok(cmdtext,idx);
		if(strlen(!cmd)) return SendClientMessage(playerid,COLOR_LIGHTBLUE, "USAGE: /tempAddCar [vehicleid]");
		if(strval(cmd) > 400 || strval(cmd) < 0) return SendClientMessage(playerid,COLOR_LIGHTBLUE, "Please enter a valid vehicleid to be used.");
		SetVehicleVirtualWorld(strval(cmd), 0);
		format(string,sizeof(string),"Vehicle [%d] has been returned to the server",strval(cmd));
		SendClientMessage(playerid,COLOR_GREEN,string);
		return 1;
	}
//---------------------------------Gang Commands--------------------------------
	if(strcmp(cmd, "/gang", true) == 0) {
	    //new tmp[256];
	    new gangcmd, gangnum;
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /gang [create/join/invite/quit] [name/number]");
			return 1;
		}
		giveplayerid = strval(tmp);

		if(strcmp(tmp, "create", true)==0)
		    gangcmd = 1;
		else if(strcmp(tmp, "invite", true)==0)
		    gangcmd = 2;
		else if(strcmp(tmp, "join", true)==0)
		    gangcmd = 3;
		else if(strcmp(tmp, "quit", true)==0)
		    gangcmd = 4;

		tmp = strtok(cmdtext, idx);
		if(gangcmd < 3 && !strlen(tmp)) {
		    if(gangcmd==0)
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /gang [create/join/invite/quit] [name/number]");
			else if(gangcmd==1)
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /gang [create] [name]");
			else if(gangcmd==2)
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /gang [invite] [playerID]");
			return 1;
		}

		//Create Gang//
		if(gangcmd==1) {
		    if(playerGang[playerid]>0) {
				SendClientMessage(playerid, COLOR_RED, "You are already in a gang!");
				return 1;
		    }

			for(new i = 1; i < MAX_GANGS; i++) {
				if(gangInfo[i][0]==0) {
				    //name gang
					format(gangNames[i], MAX_GANG_NAME, "%s", tmp);
					//Gang exists
					gangInfo[i][0]=1;
					//There is one member
					gangInfo[i][1]=1;
					//Gang color is player's color
					gangInfo[i][2]=playerColors[playerid];

					//Player is the first gang member
					gangMembers[i][0] = playerid;
					format(string, sizeof(string),"You have created the gang '%s' (id: %d)", gangNames[i], i);
					SendClientMessage(playerid, COLOR_GREEN, string);

					playerGang[playerid]=i;

					return 1;
				}
			}

			return 1;

		//Join Gang//
		} else if (gangcmd==3) {
	 		gangnum = gangInvite[playerid];

		    if(playerGang[playerid]>0) {
				SendClientMessage(playerid, COLOR_RED, "You are already in a gang!");
				return 1;
		    }
	 		if(gangInvite[playerid]==0) {
				SendClientMessage(playerid, COLOR_RED, "You have not been invited to a gang.");
				return 1;
			}
			if(gangInfo[gangnum][0]==0) {
				SendClientMessage(playerid, COLOR_RED, "That gang does not exist!");
				return 1;
			}

			if(gangInfo[gangnum][1] < MAX_GANG_MEMBERS) {
			    new i = gangInfo[gangnum][1];

				gangInvite[playerid]=0;

				gangMembers[gangnum][i] = playerid;

			    GetPlayerName(playerid, sendername, MAX_PLAYER_NAME);
				for(new j = 0; j < gangInfo[gangnum][1]; j++) {
					format(string, sizeof(string),"%s has joined your gang.", sendername);
					SendClientMessage(gangMembers[gangnum][j], COLOR_ORANGE, string);
				}

				gangInfo[gangnum][1]++;
				playerGang[playerid] = gangnum;

				SetPlayerColor(playerid,gangInfo[gangnum][2]);

				format(string, sizeof(string),"You have joined the gang '%s' (id: %d)", gangNames[gangnum], gangnum);
				SendClientMessage(playerid, COLOR_GREEN, string);

				return 1;
			}

			SendClientMessage(playerid, COLOR_RED, "That gang is full.");
			return 1;

		//Invite to Gang//
		} else if (gangcmd==2) {
	 		giveplayerid = strval(tmp);

			if(playerGang[playerid]==0) {
				SendClientMessage(playerid, COLOR_RED, "You are not in a gang!");
				return 1;
			}
//			if(gangMembers[playerGang[playerid]][0]!=playerid) {
//				SendClientMessage(playerid, COLOR_RED, "You need to be the gang leader to send an invite.");
//				return 1;
//			}

			if(IsPlayerConnected(giveplayerid)) {
				GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));

				format(string, sizeof(string),"You have sent a gang invite to %s.", giveplayer);
				SendClientMessage(playerid, COLOR_GREEN, string);
				format(string, sizeof(string),"You have recieved a gang invite from %s to '%s' (id: %d)", sendername, gangNames[playerGang[playerid]],playerGang[playerid]);
				SendClientMessage(giveplayerid, COLOR_GREEN, string);

				gangInvite[giveplayerid]=playerGang[playerid];

			} else
				SendClientMessage(playerid, COLOR_RED, "No such player exists!");

		//Leave Gang//
		} else if (gangcmd==4) {
		    PlayerLeaveGang(playerid);
		}

		return 1;
	}

	//------------------- /ganginfo

	if(strcmp(cmd, "/ganginfo", true) == 0) {
	    //new tmp[256];
	    new gangnum;
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp) && playerGang[playerid]==0) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /ganginfo [number]");
			return 1;
		} else if (!strlen(tmp))
			gangnum = playerGang[playerid];
		else
			gangnum = strval(tmp);

		if(gangInfo[gangnum][0]==0) {
			SendClientMessage(playerid, COLOR_RED, "No such gang exists!");
			return 1;
		}

		format(string, sizeof(string),"'%s' Gang Members (id: %d)", gangNames[gangnum], gangnum);
		SendClientMessage(playerid, COLOR_GREEN, string);

		for(new i = 0; i < gangInfo[gangnum][1]; i++) {
			GetPlayerName(gangMembers[gangnum][i], giveplayer, sizeof(giveplayer));
			format(string, sizeof(string),"%s (%d)", giveplayer, gangMembers[gangnum][i]);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}

		return 1;
	}

	//------------------- /gangs

	if(strcmp(cmd, "/gangs", true) == 0)
	{
		new x;

		SendClientMessage(playerid, COLOR_GREEN, "Current Gangs:");
	    for(new i=0; i < MAX_GANGS; i++) {
			if(gangInfo[i][0]==1) {
				format(string, sizeof(string), "%s%s(%d) - %d members", string,gangNames[i],i,gangInfo[i][1]);

				x++;
				if(x > 2) {
				    SendClientMessage(playerid, COLOR_YELLOW, string);
				    x = 0;
					format(string, sizeof(string), "");
				} else {
					format(string, sizeof(string), "%s, ", string);
				}
			}
		}

		if(x <= 2 && x > 0) {
			string[strlen(string)-2] = '.';
		    SendClientMessage(playerid, COLOR_YELLOW, string);
		}

		return 1;
	}
//---------------------------------Call on Phone--------------------------------
	if(strcmp(cmd, "/call", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Usage: /call [playerid]");
			return 1;
		}
		giveplayerid = strval(tmp);
		if (PlayerInfo[playerid][logged] != 1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to make a phone call!");
			return 1;
		}
		if (GetPlayerMoney(playerid) < CALL_UNIT_COST)
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have enough money to make a phone call!");
			return 1;
		}
		if (giveplayerid == playerid)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You cannot call yourself!");
		    return 1;
		}
		if (!(IsPlayerConnected(giveplayerid)))
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Inactive player id!");
		    return 1;
		}
		if (Calling[playerid] > -1)
		{
			GetPlayerName(Calling[playerid], giveplayer, sizeof(giveplayer));
			format(string, sizeof(string), "You are already on the phone to %s!", giveplayer);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}
		if (Calling[giveplayerid] > -1)
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			format(string, sizeof(string), "%s is already on the phone, try again later", giveplayer);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			return 1;
		}
		else
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s is ringing you, type /answer to answer the call or /hangup to ignore it", sendername);
		SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "You are ringing %s", giveplayer);
		SendClientMessage(playerid, COLOR_GREEN, string);
		Calling[playerid] = giveplayerid;
		Calling[giveplayerid] = playerid;
		Callerid[playerid] = 1;
		return 1;
	}
//---------------------------------Answer Phone---------------------------------
	if(strcmp(cmd, "/answer", true) == 0)
		{
		if (PlayerInfo[playerid][logged] != 1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to answer a phone call!");
			return 1;
		}
		if (Calling[playerid] == -1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Nobody is calling you!");
		    return 1;
		}
		if (Answered[playerid] == 1)
		{
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "You are already on the phone!");
		    return 1;
		}
		else
		GetPlayerName(Calling[playerid], giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s has answered your call, talk away", sendername);
		SendClientMessage(Calling[playerid], COLOR_GREEN, string);
		format(string, sizeof(string), "You have answered %s's call, talk away", giveplayer);
		SendClientMessage(playerid, COLOR_GREEN, string);
   		Answered[playerid] = 1;
   		Answered[Calling[playerid]] = 1;
		Callerid[Calling[playerid]] = 1;
	    return 1;
	}
//---------------------------------HangUp Phone---------------------------------
	if(strcmp(cmd, "/hangup", true) == 0)
	{
		if (PlayerInfo[playerid][logged] != 1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to hang up a phone call!");
			return 1;
		}
		if (Calling[playerid] == -1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not on the phone!");
		    return 1;
		}
		else
		{
			GetPlayerName(Calling[playerid], giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "%s has hung up the phone on you", sendername);
			SendClientMessage(Calling[playerid], COLOR_LIGHTBLUE, string);
			format(string, sizeof(string), "You have hung up on %s", giveplayer);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
   			new bCalling = Calling[playerid];
   			Calling[playerid] = -1;
   			Answered[playerid] = 0;
			Callerid[playerid] = 0;
   			Calling[bCalling] = -1;
   			Answered[bCalling] = 0;
			Callerid[bCalling] = 0;
		}
		return 1;
	}
	return 0;
}
//================================Xadmin Commands===============================
//-----------------------------[REGISTRATION SYSTEM]----------------------------
dcmd_register(playerid,params[]) {
	if(!strlen(params)) { new string[256]; format(string,256,"Syntax Error: \"/REGISTER <PASSWORD>\" [Password must be %d+].",Config[MinimumPasswordLength]); return SendClientMessage(playerid,red,string); }
	new index = 0,Password[256],string[256],PlayerFile[256]; Password = strtok(params,index); PlayerFile = GetPlayerFile(playerid);
	if(!Variables[playerid][Registered] && !Variables[playerid][LoggedIn]) {
	    if(strlen(Password) >= Config[MinimumPasswordLength]) {
	        format(string,sizeof(string),"You have registered your account with the password \"%s\" and automatically been logged in.",Password);
	        CreateUserConfigFile(playerid);
			SetUserInt(playerid,"Password",udb_hash(Password));
            SetUserInt(playerid,"Registered",1);
            SetUserInt(playerid,"LoggedIn",1);
            SavePlayer(playerid);
	        Variables[playerid][LoggedIn] = true, Variables[playerid][Registered] = true;
	        PlayerInfo[playerid][logged] = 1;
	        LoadPlayer(playerid);
	        SendClientMessage(playerid,blue,string);
	        new tmp3[100]; GetPlayerIp(playerid,tmp3,100); SetUserString(playerid,"IP",tmp3); OnPlayerRegister(playerid);
	    } else SendClientMessage(playerid,red,"Syntax Error: \"/REGISTER <PASSWORD>\" [Password must be 3+].");
	} else SendClientMessage(playerid,red,"Error: Make sure that you have not registered and are logged out.");
	return 1;
}
dcmd_login(playerid,params[]) {
    if(!strlen(params)) { SendClientMessage(playerid,red,"Syntax Error: \"/LOGIN <PASSWORD>\"."); return 1; }
	new index = 0;
	new Password[256], string[256]; Password = strtok(params,index);
	new PlayerFile[256]; PlayerFile = GetPlayerFile(playerid);
    if(Variables[playerid][Registered] && !Variables[playerid][LoggedIn]) {
        if(udb_hash(Password) == dini_Int(PlayerFile,"Password")) {
            switch(Variables[playerid][Level]) {
                case 0: format(string,sizeof(string),"You have logged into your account. [Status Level: Member]");
                default: format(string,sizeof(string),"You have logged into your account. [Status Level: Administrator Lv. %d]",Variables[playerid][Level]);
			}
            SendClientMessage(playerid,blue,string);
	        SetUserInt(playerid,"LoggedIn",1); Variables[playerid][LoggedIn] = true;
	        PlayerInfo[playerid][logged] = 1;
	        LoadPlayer(playerid);
	        ResetPlayerMoney(playerid);
      		GivePlayerMoney(playerid,PlayerInfo[playerid][pcash]);
	        new tmp3[100]; GetPlayerIp(playerid,tmp3,100); SetUserString(playerid,"IP",tmp3);
	        OnPlayerLogin(playerid,true);
        } else { OnPlayerLogin(playerid,false); SendClientMessage(playerid,red,"Syntax Error: \"/LOGIN <PASSWORD>\"."); }
	} else SendClientMessage(playerid,red,"Error: You must be registered to log in; if you have make sure you haven't already logged in.");
	return 1;
}
dcmd_logout(playerid,params[]) {
	#pragma unused params
	new PlayerFile[256]; PlayerFile = GetPlayerFile(playerid);
    if(Variables[playerid][Registered] && Variables[playerid][LoggedIn]) {
		SendClientMessage(playerid,blue,"You have logged out of your account. You may log back in later by typing \"/LOGIN <PASSWORD>\".");
	 	SetUserInt(playerid,"LoggedIn",0); Variables[playerid][LoggedIn] = false; OnPlayerLogout(playerid);
	 	PlayerInfo[playerid][logged] = 0;
	} else SendClientMessage(playerid,red,"Error: You must be registered and logged into your account first.");
	return 1;
}
//----------------------------[ADMINISTRATION SYSTEM]---------------------------
dcmd_goto(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"goto")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/GOTO <NICK OR ID>\".");
        new id;
		if(!IsNumeric(params)) id = ReturnPlayerID(params);
		else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    SendCommandMessageToAdmins(playerid,"GOTO");
			new string[256],PlayerName[24],ActionName[24],Float:X,Float:Y,Float:Z; GetPlayerName(playerid,PlayerName,24); GetPlayerName(id,ActionName,24);
			new Interior = GetPlayerInterior(id); SetPlayerInterior(playerid,Interior); SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(id)); GetPlayerPos(id,X,Y,Z); if(IsPlayerInAnyVehicle(playerid)) { SetVehiclePos(GetPlayerVehicleID(playerid),X+Config[TeleportXOffset],Y+Config[TeleportYOffset],Z+Config[TeleportZOffset]); LinkVehicleToInterior(GetPlayerVehicleID(playerid),Interior); } else SetPlayerPos(playerid,X+Config[TeleportXOffset],Y+Config[TeleportYOffset],Z+Config[TeleportZOffset]);
			format(string,256,"\"%s\" has teleported to your location.",PlayerName); SendClientMessage(id,yellow,string);
			format(string,256,"You have teleported to \"%s's\" location.",ActionName); return SendClientMessage(playerid,yellow,string);
  		} else return SendClientMessage(playerid,red,"ERROR: You can not teleport to yourself or disconnected players.");
	} else return SendLevelErrorMessage(playerid,"goto");
}
dcmd_gethere(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"gethere")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/GETHERE <NICK OR ID>\".");
        new id;
		if(!IsNumeric(params)) id = ReturnPlayerID(params);
		else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
			SendCommandMessageToAdmins(playerid,"GETHERE");
			new string[256],PlayerName[24],ActionName[24],Float:X,Float:Y,Float:Z; GetPlayerName(playerid,PlayerName,24); GetPlayerName(id,ActionName,24);
			new Interior = GetPlayerInterior(playerid); SetPlayerInterior(id,Interior); SetPlayerVirtualWorld(id,GetPlayerVirtualWorld(playerid)); GetPlayerPos(playerid,X,Y,Z); if(IsPlayerInAnyVehicle(id)) { SetVehiclePos(GetPlayerVehicleID(id),X+Config[TeleportXOffset],Y+Config[TeleportYOffset],Z+Config[TeleportZOffset]); LinkVehicleToInterior(GetPlayerVehicleID(id),Interior); } else SetPlayerPos(id,X+Config[TeleportXOffset],Y+Config[TeleportYOffset],Z+Config[TeleportZOffset]);
   			format(string,256,"You have teleported \"%s\" to your location.",ActionName); SendClientMessage(playerid,yellow,string);
			format(string,256,"You have been teleported to \"%s's\" location.",PlayerName); return SendClientMessage(id,yellow,string);
  		} else return SendClientMessage(playerid,red,"ERROR: You can not teleport yourself or a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"gethere");
}
dcmd_announce(playerid,params[]) {
    if(IsPlayerCommandLevel(playerid,"announce")) {
        SendCommandMessageToAdmins(playerid,"ANNOUNCE");
    	if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/ANNOUNCE <TEXT>\".");
		return GameTextForAll(params,4000,3);
    } else return SendLevelErrorMessage(playerid,"announce");
}
dcmd_say(playerid,params[]) {
    if(IsPlayerCommandLevel(playerid,"say")) {
        SendCommandMessageToAdmins(playerid,"SAY");
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/SAY <TEXT>\".");
		new string[256],xname[24];GetPlayerName(playerid,xname,24); format(string,256,"** Admin %s: %s",xname,params);
		return SendClientMessageToAll(pink,string);
	} else return SendLevelErrorMessage(playerid,"say");
}
dcmd_flip(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"flip")) {
	    if(IsPlayerInAnyVehicle(playerid)) {
	        SendCommandMessageToAdmins(playerid,"FLIP");
			new Float:X,Float:Y,Float:Z,Float:Angle,string[256],xname[24]; GetPlayerName(playerid,xname,24); GetVehiclePos(GetPlayerVehicleID(playerid),X,Y,Z); GetVehicleZAngle(GetPlayerVehicleID(playerid),Angle);
			SetVehiclePos(GetPlayerVehicleID(playerid),X,Y,Z+2); SetVehicleZAngle(GetPlayerVehicleID(playerid),Angle);
   			format(string,256,"Admin Chat: Administrator \"%s\" has flipped their vehicle.",xname); return SendMessageToAdmins(string);
		} else return SendClientMessage(playerid,red,"ERROR: You must be in a vehicle.");
	} else return SendLevelErrorMessage(playerid,"flip");
}
dcmd_morning(playerid,params[]) {
    #pragma unused params
    if(IsPlayerCommandLevel(playerid,"morning")) {
        SendCommandMessageToAdmins(playerid,"MORNING");
        for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerTime(playerid,7,0); return SendClientMessageToAll(yellow,"The world time has been changed to 7:00.");
    } else return SendLevelErrorMessage(playerid,"morning");
}
dcmd_noon(playerid,params[]) {
    #pragma unused params
    if(IsPlayerCommandLevel(playerid,"noon")) {
    	SendCommandMessageToAdmins(playerid,"NOON");
        for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerTime(playerid,12,0); return SendClientMessageToAll(yellow,"The world time has been changed to 12:00.");
    } else return SendLevelErrorMessage(playerid,"noon");
}
dcmd_evening(playerid,params[]) {
    #pragma unused params
    if(IsPlayerCommandLevel(playerid,"evening")) {
        SendCommandMessageToAdmins(playerid,"EVENING");
        for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerTime(playerid,18,0); return SendClientMessageToAll(yellow,"The world time has been changed to 18:00.");
    } else return SendLevelErrorMessage(playerid,"evening");
}
dcmd_midnight(playerid,params[]) {
	#pragma unused params
    if(IsPlayerCommandLevel(playerid,"midnight")) {
        SendCommandMessageToAdmins(playerid,"MIDNIGHT");
        for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerTime(playerid,0,0); return SendClientMessageToAll(yellow,"The world time has been changed to 0:00.");
    } else return SendLevelErrorMessage(playerid,"midnight");
}
dcmd_serverinfo(playerid,params[]) {
	#pragma unused params
	new string[256]; format(string,256,"Server Information: [Players Connected: %d || Maximum Players: %d || Ratio: %.2f]",GetConnectedPlayers(),GetMaxPlayers(),floatdiv(GetConnectedPlayers(),GetMaxPlayers()));
	return SendClientMessage(playerid,green,string);
}
dcmd_slap(playerid,params[]) {
    if(IsPlayerCommandLevel(playerid,"slap")) {
   		if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/SLAP <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    SendCommandMessageToAdmins(playerid,"SLAP");
		    new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
		    format(string,256,"Administrator \"%s\" has bitch-slapped \"%s\".",xname,ActionName); SendClientMessageToAll(yellow,string);
			new Float:Health; GetPlayerHealth(id,Health); return SetPlayerHealth(id,Health-Config[SlapDecrement]);
		} else return SendClientMessage(playerid,red,"ERROR: You can not slap yourself or a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"slap");
}
dcmd_wire(playerid,params[]) {
    if(IsPlayerCommandLevel(playerid,"wire")) {
   		if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/WIRE <NICK OR ID> (<REASON>)\".");
        new tmp[256],Index; tmp = strtok(params,Index);
	   	new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    if(!Variables[id][Wired]) {
		        SendCommandMessageToAdmins(playerid,"WIRE");
			    new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
			    if(!strlen(params[strlen(tmp)+1])) format(string,256,"\"%s\" has been wired by Administrator \"%s\".",ActionName,xname);
				else format(string,256,"\"%s\" has been wired by Administrator \"%s\". (Reason: %s)",ActionName,xname,params[strlen(tmp)+1]);
				Variables[id][Wired] = true, Variables[id][WiredWarnings] = Config[WiredWarnings];
		    	return SendClientMessageToAll(yellow,string);
			} else return SendClientMessage(playerid,red,"ERROR: This player has already been wired.");
		} else return SendClientMessage(playerid,red,"ERROR: You can not wire yourself or a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"wire");
}
dcmd_unwire(playerid,params[]) {
    if(IsPlayerCommandLevel(playerid,"unwire")) {
   		if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/UNWIRE <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    if(Variables[id][Wired]) {
		        SendCommandMessageToAdmins(playerid,"UNWIRE");
			    new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
				Variables[id][Wired] = false, Variables[id][WiredWarnings] = Config[WiredWarnings];
			    if(id != playerid) { format(string,256,"\"%s\" has been unwired by Administrator \"%s\".",ActionName,xname); return SendClientMessageToAll(yellow,string); }
			    else return SendClientMessage(playerid,yellow,"You have successfully unwired yourself.");
        	} else return SendClientMessage(playerid,red,"ERROR: This player is not wired.");
		} else return SendClientMessage(playerid,red,"ERROR: You can not unwire a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"unwire");
}
dcmd_kick(playerid,params[]) {
    if(IsPlayerCommandLevel(playerid,"kick")) {
   		if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/KICK <NICK OR ID> (<REASON>)\".");
   		new tmp[256],Index; tmp = strtok(params,Index);
	   	new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    SendCommandMessageToAdmins(playerid,"KICK");
		    new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
	    	if(!strlen(params[strlen(tmp)+1])) format(string,256,"\"%s\" has been Kicked from the game by Administrator \"%s\".",ActionName,xname);
			else format(string,256,"\"%s\" has been Kicked from the game by Administrator \"%s\". (Reason: %s)",ActionName,xname,params[strlen(tmp)+1]);
			SendClientMessageToAll(yellow,string); return Kick(id);
		} else return SendClientMessage(playerid,red,"ERROR: You can not kick yourself or a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"kick");
}
dcmd_ban(playerid,params[]) {
    if(IsPlayerCommandLevel(playerid,"ban")) {
   		if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/BAN <NICK OR ID> (<REASON>)\".");
   		new tmp[256],Index; tmp = strtok(params,Index);
	   	new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    SendCommandMessageToAdmins(playerid,"BAN");
		    new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
		    if(!strlen(params[strlen(tmp)+1])) format(string,256,"\"%s\" has been Banned by Administrator \"%s\".",ActionName,xname);
			else format(string,256,"\"%s\" has been Banned by Administrator \"%s\". (Reason: %s)",ActionName,xname,params[strlen(tmp)+1]);
			SendClientMessageToAll(yellow,string); return Ban(id);
		} else return SendClientMessage(playerid,red,"ERROR: You can not ban yourself or a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"ban");
}
dcmd_akill(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"akill")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/AKILL <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    SendCommandMessageToAdmins(playerid,"AKILL");
		    new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
		    format(string,256,"You have been killed by Administrator \"%s\".",xname); SendClientMessage(id,yellow,string);
		    format(string,256,"You have killed Player \"%s\".",ActionName); SendClientMessage(playerid,yellow,string); return SetPlayerHealth(id,0.0);
		} else return SendClientMessage(playerid,red,"ERROR: You can not auto-kill yourself or a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"akill");
}
dcmd_eject(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"eject")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/EJECT <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    if(IsPlayerInAnyVehicle(id)) {
		        SendCommandMessageToAdmins(playerid,"EJECT");
			    new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24); RemovePlayerFromVehicle(id);
			    if(id != playerid) {
					format(string,256,"You have been ejected from your vehicle by Administrator \"%s\".",xname); SendClientMessage(id,yellow,string);
			    	format(string,256,"You have ejected Player \"%s\".",ActionName); return SendClientMessage(playerid,yellow,string);
				} else return SendClientMessage(playerid,yellow,"You have ejected yourself from your vehicle.");
			} else return SendClientMessage(playerid,red,"ERROR: This player must be in a vehicle.");
		} else return SendClientMessage(playerid,red,"ERROR: You can not eject a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"eject");
}
dcmd_freeze(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"freeze")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/FREEZE <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    SendCommandMessageToAdmins(playerid,"FREEZE");
		    new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
		    TogglePlayerControllable(id,false); format(string,256,"Admin Chat: Admnistrator \"%s\" has frozen \"%s\".",xname,ActionName); return SendMessageToAdmins(string);
		} else return SendClientMessage(playerid,red,"ERROR: You can not freeze yourself or a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"freeze");
}
dcmd_unfreeze(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"unfreeze")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/UNFREEZE <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"UNFREEZE");
		    new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
		    TogglePlayerControllable(id,true); format(string,256,"Admin Chat: Admnistrator \"%s\" has unfrozen \"%s\".",xname,ActionName);
			if(id != playerid) return SendMessageToAdmins(string); else return SendClientMessage(playerid,yellow,"You have unfrozen yourself.");
		} else return SendClientMessage(playerid,red,"ERROR: You can not unfreeze a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"unfreeze");
}
dcmd_outside(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"outside")) {
	    SendCommandMessageToAdmins(playerid,"OUTSIDE");
	    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerInterior(i,0);
	    new string[256],xname[24]; GetPlayerName(playerid,xname,24);
	    format(string,256,"Admnistrator \"%s\" has transfered everyone outside.",xname); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"outside");
}
dcmd_healall(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"healall")) {
	    SendCommandMessageToAdmins(playerid,"HEALALL");
 		for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerHealth(i,100.0);
 		new string[256],xname[24]; GetPlayerName(playerid,xname,24);
	    format(string,256,"Everyone has been healed by Administrator \"%s\".",xname); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"healall");
}
dcmd_sm(playerid,params[]) {
	#pragma unused params
	if(Config[DisplayServerMessage]) { new string[256]; format(string,sizeof(string),"Server Message: %s",dini_Get("/xadmin/Configuration/Configuration.ini","ServerMessage")); return SendClientMessage(playerid,green,string); }
	else return SendClientMessage(playerid,red,"ERROR: The server message has been disabled.");
}
dcmd_setsm(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setsm")) {
	    SendCommandMessageToAdmins(playerid,"SETSM");
		if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETSM <TEXT>\".");
		dini_Set("/xadmin/Configuration/Configuration.ini","ServerMessage",params);
    	new string[256],xname[24]; GetPlayerName(playerid,xname,24); format(string,256,"Admin Chat: New Server Message: %s",params); SendMessageToAdmins(string); return 1;
	} else return SendLevelErrorMessage(playerid,"setsm");
}
dcmd_uconfig(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"uconfig")) {
		SendCommandMessageToAdmins(playerid,"UCONFIG"); UpdateConfigurationVariables();
    	new string[256],xname[24]; GetPlayerName(playerid,xname,24); format(string,256,"Admin Chat: Administrator \"%s\" has updated the configuration variables.",xname); SendMessageToAdmins(string);
		return 1;
	} else return SendLevelErrorMessage(playerid,"uconfig");
}
dcmd_givehealth(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"givehealth")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 1 && strval(tmp2) <= 100)) return SendClientMessage(playerid,red,"Syntax Error: \"/GIVEHEALTH <NICK OR ID> <1-100>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"GIVEHEALTH");
			new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has given you %d percent health.",xname,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You have given \"%s\" %d percent health.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have given yourself %d percent health.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			new Float:Health; GetPlayerHealth(id,Health); return SetPlayerHealth(id,Health+strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not give a disconnected player health.");
	} else return SendLevelErrorMessage(playerid,"givehealth");
}
dcmd_sethealth(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"sethealth")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 0 && strval(tmp2) <= 100)) return SendClientMessage(playerid,red,"Syntax Error: \"/SET <NICK OR ID> <0-100>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"SETHEALTH");
			new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has set your health to %d percent.",xname,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You have set \"%s's\" health to %d percent.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You've set your health to %d percent.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			return SetPlayerHealth(id,strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's health.");
	} else return SendLevelErrorMessage(playerid,"sethealth");
}
dcmd_skinall(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"skinall")) {
	    if(!strlen(params)||!IsNumeric(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/SKINALL <SKINID>\".");
		if(IsSkinValid(strval(params))) {
		    SendCommandMessageToAdmins(playerid,"SKINALL");
			new string[256],xname[24]; GetPlayerName(playerid,xname,24); for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerSkin(i,strval(params));
			format(string,256,"Everyone's skin has been changed to ID %d.",strval(params)); return SendClientMessageToAll(yellow,string);
		} else return SendClientMessage(playerid,red,"ERROR: Invalid skin ID.");
	} else return SendLevelErrorMessage(playerid,"skinall");
}
dcmd_giveallweapon(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"giveallweapon")) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index); tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) <= 0 || strval(tmp2) <= 10000)) return SendClientMessage(playerid,red,"Syntax Error: \"/GIVEALLWEAPON <WEAPON NAME | ID> <1-10,000>\".");
		new id; if(!IsNumeric(tmp)) id = ReturnWeaponID(tmp); else id = strval(tmp);
		if(id == -1||id==19||id==20||id==21||id==0||id==44||id==45) return SendClientMessage(playerid,red,"ERROR: You have selected an invalid weapon ID.");
        SendCommandMessageToAdmins(playerid,"GIVEALLWEAPON");
		new string[256],xname[24],WeaponName[24]; GetWeaponName(id,WeaponName,24); if(id == 18) WeaponName = "Molotov"; GetPlayerName(playerid,xname,24); for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) GivePlayerWeapon(i,id,strval(tmp2));
		format(string,256,"Everyone has been given %d \'%s\' by Administrator \"%s\".",strval(tmp2),WeaponName,xname); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"giveallweapon");
}
dcmd_resetallweapons(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"resetallweapons")) {
	    SendCommandMessageToAdmins(playerid,"RESETALLWEAPONS");
		new string[256],xname[24]; GetPlayerName(playerid,xname,24); for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) ResetPlayerWeapons(i);
		format(string,256,"Administrator \"%s\" has reseted everyone's weapons.",xname); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"resetallweapons");
}
dcmd_setcash(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setcash")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 1 && strval(tmp2) <= 1000000)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETCASH <NICK OR ID> <1 - 1,000,000>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"SETCASH");
			new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has set your cash to $%d.",xname,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You have set \"%s's\" cash to $%d.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have set your cash to $%d.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			ResetPlayerMoney(id); return GivePlayerMoney(id,strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's cash.");
	} else return SendLevelErrorMessage(playerid,"setcash");
}
dcmd_givecash(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"givecash")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 1 && strval(tmp2) <= 1000000)) return SendClientMessage(playerid,red,"Syntax Error: \"/GIVECASH <NICK OR ID> <1 - 1,000,000>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"GIVECASH");
			new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has given you $%d.",xname,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You have given \"%s\" $%d.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have given yourself $%d.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			return GivePlayerMoney(id,strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not give a disconnected player cash.");
	} else return SendLevelErrorMessage(playerid,"givecash");
}
dcmd_remcash(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"remcash")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 1 && strval(tmp2) <= 1000000)) return SendClientMessage(playerid,red,"Syntax Error: \"/REMCASH <NICK OR ID> <1 - 1,000,000>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"REMCASH");
			new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has removed $%d from your cash.",xname,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You have removed $%d from \"%s's\" cash.",strval(tmp2),ActionName); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have removed $%d from your cash.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			return GivePlayerMoney(id,-strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not remove a disconnected player's cash.");
	} else return SendLevelErrorMessage(playerid,"remcash");
}
dcmd_resetcash(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"resetcash")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/RESETCASH <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"RESETCASH");
			new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has reseted your cash.",xname); SendClientMessage(id,yellow,string); format(string,256,"You have reseted \"%s's\" cash.",ActionName); SendClientMessage(playerid,yellow,string); }
			else SendClientMessage(playerid,yellow,"You have reseted your cash.");
			return ResetPlayerMoney(id);
		} return SendClientMessage(playerid,red,"ERROR: You can not reset a disconnected player's cash.");
	} else return SendLevelErrorMessage(playerid,"resetcash");
}
dcmd_setallcash(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setallcash")) {
	    if(!strlen(params)||!IsNumeric(params)||!(strval(params)>=0&&strval(params)<=1000000)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETALLCASH <1 - 1,000,000>\".");
        SendCommandMessageToAdmins(playerid,"SETALLCASH");
		for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) { ResetPlayerMoney(i); GivePlayerMoney(i,strval(params)); }
		new string[256],xname[24]; GetPlayerName(playerid,xname,24); format(string,256,"Administrator \"%s\" has set every player's cash to $%d.",xname,strval(params)); return SendClientMessage(playerid,yellow,string);
	} else return SendLevelErrorMessage(playerid,"setallcash");
}
dcmd_giveallcash(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"giveallcash")) {
	    if(!strlen(params)||!IsNumeric(params)||!(strval(params)>=0&&strval(params)<=1000000)) return SendClientMessage(playerid,red,"Syntax Error: \"/GIVEALLCASH <1 - 1,000,000>\".");
        SendCommandMessageToAdmins(playerid,"GIVEALLCASH");
		for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) GivePlayerMoney(i,strval(params));
		new string[256],xname[24]; GetPlayerName(playerid,xname,24); format(string,256,"Administrator \"%s\" has given every player $%d.",xname,strval(params)); return SendClientMessage(playerid,yellow,string);
	} else return SendLevelErrorMessage(playerid,"giveallcash");
}
dcmd_remallcash(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"remallcash")) {
	    if(!strlen(params)||!(strval(params)>=0&&strval(params)<=1000000)) return SendClientMessage(playerid,red,"Syntax Error: \"/REMALLCASH <1 - 1,000,000>\".");
        SendCommandMessageToAdmins(playerid,"REMALLCASH");
		for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) GivePlayerMoney(i,-strval(params));
		new string[256],xname[24]; GetPlayerName(playerid,xname,24); format(string,256,"Administrator \"%s\" has removed $%d from everyone's cash.",xname,strval(params)); return SendClientMessage(playerid,yellow,string);
	} else return SendLevelErrorMessage(playerid,"remallcash");
}
dcmd_resetallcash(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"resetallcash")) {
	    SendCommandMessageToAdmins(playerid,"RESETALLCASH");
	    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) ResetPlayerMoney(i);
		new string[256],xname[24]; GetPlayerName(playerid,xname,24); format(string,256,"Administrator \"%s\" resetted everyone's cash.",xname); return SendClientMessage(playerid,yellow,string);
	} else return SendLevelErrorMessage(playerid,"resetallcash");
}
dcmd_ejectall(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"ejectall")) {
	    SendCommandMessageToAdmins(playerid,"EJECTALL");
	    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i)) RemovePlayerFromVehicle(i);
		new string[256],xname[24]; GetPlayerName(playerid,xname,24); format(string,256,"Administrator \"%s\" reseted ejected everyone from their vehicle.",xname); return SendClientMessage(playerid,yellow,string);
	} else return SendLevelErrorMessage(playerid,"ejectall");
}
dcmd_freezeall(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"freezeall")) {
	    SendCommandMessageToAdmins(playerid,"FREEZEALL");
	    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) TogglePlayerControllable(i,false);
		new string[256],xname[24]; GetPlayerName(playerid,xname,24); format(string,256,"Administrator \"%s\" frozen everyone.",xname); return SendClientMessage(playerid,yellow,string);
	} else return SendLevelErrorMessage(playerid,"freezeall");
}
dcmd_unfreezeall(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"unfreezeall")) {
		SendCommandMessageToAdmins(playerid,"UNFREEZEALL");
	    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) TogglePlayerControllable(i,true);
		new string[256],xname[24]; GetPlayerName(playerid,xname,24); format(string,256,"Administrator \"%s\" unfrozen everyone.",xname); return SendClientMessage(playerid,yellow,string);
	} else return SendLevelErrorMessage(playerid,"unfreezeall");
}
dcmd_giveweapon(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"giveweapon")) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index),tmp2 = strtok(params,Index),tmp3 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!strlen(tmp3)||!IsNumeric(tmp3)||!(strval(tmp3) <= 0 || strval(tmp3) <= 10000)) return SendClientMessage(playerid,red,"Syntax Error: \"/GIVEWEAPON <NICK OR ID> <WEAPON NAME | ID> <1-10,000>\".");
		new id,id2; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp); if(!IsNumeric(tmp2)) id2 = ReturnWeaponID(tmp2); else id2 = strval(tmp2);
        if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
        	if(id2==-1||id2==19||id2==20||id2==21||id2==0||id2==44||id2==45) return SendClientMessage(playerid,red,"ERROR: You have selected an invalid weapon ID.");
            SendCommandMessageToAdmins(playerid,"GIVEWEAPON");
			new string[256],xname[24],ActionName[24],WeaponName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24); GetWeaponName(id2,WeaponName,24); if(id2 == 18) WeaponName = "Molotov";
            if(id != playerid) { format(string,256,"Administrator \"%s\" has given you %d %s.",xname,strval(tmp3),WeaponName); SendClientMessage(id,yellow,string); format(string,256,"You have given \"%s\" %d %s.",ActionName,strval(tmp3),WeaponName); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have given yourself %d %s.",strval(tmp3),WeaponName); SendClientMessage(playerid,yellow,string); }
			return GivePlayerWeapon(id,id2,strval(tmp3));
	    } else return SendClientMessage(playerid,red,"ERROR: You can not give a disconnected player a weapon.");
	} else return SendLevelErrorMessage(playerid,"giveweapon");
}
dcmd_god(playerid,params[]) {
    #pragma unused params
	if(IsPlayerCommandLevel(playerid,"god")) {
	    SendCommandMessageToAdmins(playerid,"GOD");
		if(!Config[GodWeapons]) { SetPlayerHealth(playerid,100000); return SendClientMessage(playerid,yellow,"You have given yourself infinite health."); }
	    else { SetPlayerHealth(playerid,100000); GivePlayerWeapon(playerid,38,50000); GivePlayerWeapon(playerid,WEAPON_GRENADE,50000); return SendClientMessage(playerid,yellow,"You have given yourself infinite health, minigun,grenades."); }
    } else return SendLevelErrorMessage(playerid,"god");
}
dcmd_resetscores(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"resetscores")) {
	    SendCommandMessageToAdmins(playerid,"RESETSCORES");
	    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerScore(i,0);
		new string[256],xname[24]; GetPlayerName(playerid,xname,24); format(string,256,"Administrator \"%s\" resetted everyone's score.",xname); return SendClientMessage(playerid,yellow,string);
	} else return SendLevelErrorMessage(playerid,"resetscores");
}
dcmd_setlevel(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setlevel")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 0 && strval(tmp2) <= Config[MaxLevel])) { new string[256]; format(string,256,"Syntax Error: \"SETLEVEL <NICK OR ID> <0 - %d>\".",Config[MaxLevel]); return SendClientMessage(playerid,red,string); }
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
  			if(Variables[id][Level] == strval(tmp2)) return SendClientMessage(playerid,red,"ERROR: That player is already that level.");
			new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
            SendCommandMessageToAdmins(playerid,"SETLEVEL");
			format(string,256,"Administrator \"%s\" has %s you to %s [%d].",xname,((strval(tmp2) >= Variables[id][Level])?("promoted"):("demoted")),((strval(tmp2))?("Administrator"):("Member Status")),strval(tmp2)); SendClientMessage(id,yellow,string);
			format(string,256,"You have %s \"%s\" to %s [%d].",((strval(tmp2) >= Variables[id][Level])?("promoted"):("demoted")),ActionName,((strval(tmp2))?("Administrator"):("Member Status")),strval(tmp2)); SendClientMessage(playerid,yellow,string);
			Variables[id][Level] = strval(tmp2); PlayerInfo[playerid][admin] = strval(tmp2); return SetUserInt(id,"Level",strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not set set your or a disconnected player's level.");
	} else return SendLevelErrorMessage(playerid,"setlevel");
}
dcmd_setskin(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setskin")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETSKIN <NICK OR ID> <SKINID>\".");
		if(!IsSkinValid(strval(tmp2))) return SendClientMessage(playerid,red,"ERROR: Invalid skin ID.");
  		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
			new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
            SendCommandMessageToAdmins(playerid,"SETSKIN");
			if(id != playerid) { format(string,256,"Administrator \"%s\" has set your skin to ID %d.",xname,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You have set \"%s's\" skin ID to %d.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have set your skin ID to %d.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			return SetPlayerSkin(id,strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's skin.");
	} else return SendLevelErrorMessage(playerid,"setskin");
}
dcmd_givearmour(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"givearmour")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 1 && strval(tmp2) <= 100)) return SendClientMessage(playerid,red,"Syntax Error: \"/GIVEARMOUR <NICK OR ID> <1-100>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"GIVEARMOUR");
			new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has given you %d armour.",xname,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You have given \"%s\" %d armour.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have given yourself %d armour.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			new Float:Armour; GetPlayerArmour(id,Armour); return SetPlayerArmour(id,Armour+strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not give a disconnected player armour.");
	} else return SendLevelErrorMessage(playerid,"givearmour");
}
dcmd_setarmour(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setarmour")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 1 && strval(tmp2) <= 100)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETARMOUR <NICK OR ID> <1-100>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"SETARMOUR");
			new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has set your armour to %d.",xname,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You set \"%s\'s\" armour to %d.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have set your armour to %d.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			return SetPlayerArmour(id,strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's armour.");
	} else return SendLevelErrorMessage(playerid,"setarmour");
}
dcmd_armourall(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"armourall")) {
	    SendCommandMessageToAdmins(playerid,"ARMOURALL");
 		for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerArmour(i,100.0);
 		new string[256],xname[24]; GetPlayerName(playerid,xname,24);
	    format(string,256,"Everyone's armour has been restored by Administrator \"%s\".",xname); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"armourall");
}
dcmd_setammo(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setammo")) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index),tmp2 = strtok(params,Index),tmp3 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!strlen(tmp3)||!IsNumeric(tmp3)||!IsNumeric(tmp2)||!(strval(tmp3) <= 0 || strval(tmp3) <= 10000)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETAMMO <NICK OR ID> <WEAPON SLOT> <1-10,000>\".");
		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
        if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
        	if(!(strval(tmp2) >= 0 && strval(tmp) <= 12)) return SendClientMessage(playerid,red,"ERROR: Invalid weapon slot! Range: 0 - 12");
            SendCommandMessageToAdmins(playerid,"SETAMMO");
			new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
            if(id != playerid) { format(string,256,"Administrator \"%s\" has set your ammunition in slot \'%d\' to %d.",xname,strval(tmp2),strval(tmp3)); SendClientMessage(id,yellow,string); format(string,256,"You have set \"%s\'s\" ammunition in slot %d to %d.",ActionName,strval(tmp2),strval(tmp3)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have set your ammunition in slot \'%d\' to %d.",strval(tmp2),strval(tmp3)); SendClientMessage(playerid,yellow,string); }
			return SetPlayerAmmo(id,strval(tmp2),strval(tmp3));
	    } else return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's ammunition.");
	} else return SendLevelErrorMessage(playerid,"setammo");
}
dcmd_setscore(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setscore")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 1 && strval(tmp2) <= 100000)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETSCORE <NICK OR ID> <1-100,000>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"SETSCORE");
			new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has set your score to %d.",xname,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You set \"%s\'s\" score to %d.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have set your score to %d.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			return SetPlayerScore(id,strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's score.");
	} else return SendLevelErrorMessage(playerid,"setscore");
}
dcmd_ip(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"ip")) {
	    SendCommandMessageToAdmins(playerid,"IP");
	    if(!strlen(params)) { new IP[256],string[256]; GetPlayerIp(playerid,IP,256); format(string,256,"Your IP: \'%s\'",IP); return SendClientMessage(playerid,yellow,string); }
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    new string[256],ActionName[24],IP[256]; GetPlayerName(id,ActionName,24); GetPlayerIp(id,IP,256);
		    format(string,256,"\"%s\'s\" IP: \'%s\'",ActionName,IP); return SendClientMessage(playerid,yellow,string);
		} else return SendClientMessage(playerid,red,"ERROR: You can not get the ip of a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"ip");
}
dcmd_ping(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"ping")) {
    	SendCommandMessageToAdmins(playerid,"PING");
	    if(!strlen(params)) { new string[256]; format(string,256,"Your Ping: \'%d\'",GetPlayerPing(playerid)); return SendClientMessage(playerid,yellow,string); }
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    new string[256],ActionName[24],IP[256]; GetPlayerName(id,ActionName,24); GetPlayerIp(id,IP,256);
		    format(string,256,"\"%s\'s\" Ping: \'%d\'",ActionName,GetPlayerPing(id)); return SendClientMessage(playerid,yellow,string);
		} else return SendClientMessage(playerid,red,"ERROR: You can not get the ping of a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"ping");
}
dcmd_explode(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"explode")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/EXPLODE <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"EXPLODE");
  			new string[256],xname[24],ActionName[24],Float:X,Float:Y,Float:Z; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
			if(!IsPlayerInAnyVehicle(id)) GetPlayerPos(id,X,Y,Z); else GetVehiclePos(GetPlayerVehicleID(id),X,Y,Z); for(new i = 1; i <= 5; i++) CreateExplosion(X,Y,Z,10,0);
		    if(id != playerid) {
				format(string,256,"You have been exploded by Administrator \"%s\".",xname); SendClientMessage(id,yellow,string);
		    	format(string,256,"You have exploded Player \"%s\".",ActionName); return SendClientMessage(playerid,yellow,string);
			} else return SendClientMessage(playerid,yellow,"You have exploded yourself.");
		} else return SendClientMessage(playerid,red,"ERROR: You can not explode a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"explode");
}
dcmd_settime(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"settime")) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index),tmp2 = strtok(params,Index),tmp3 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!strlen(tmp3)||!IsNumeric(tmp2)||!IsNumeric(tmp3)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETTIME <NICK OR ID> <HOUR> <MINUTE>\".");
		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
        if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
            SendCommandMessageToAdmins(playerid,"SETTIME");
            new xname[24],string[256],Hour[5],Minute[5],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
        	format(Hour,5,"%s%d",((strval(tmp2)<10)?("0"):("")),strval(tmp2)); format(Minute,5,"%s%d",((strval(tmp3)<10)?("0"):("")),strval(tmp3));
            if(id != playerid) { format(string,256,"Administrator \"%s\" has set your time to \'%s:%s\'.",xname,Hour,Minute); SendClientMessage(id,yellow,string); format(string,256,"You have set \"%s's\" time to \'%s:%s\'.",ActionName,Hour,Minute); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have set your time to \'%s:%s\'.",Hour,Minute); SendClientMessage(playerid,yellow,string); }
			return SetPlayerTime(id,strval(tmp2),strval(tmp3));
	    } else return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's time.");
	} else return SendLevelErrorMessage(playerid,"settime");
}
dcmd_setalltime(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setalltime")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp)||!IsNumeric(tmp2)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETALLTIME <HOUR> <MINUTE>\".");
		SendCommandMessageToAdmins(playerid,"SETALLTIME");
		new xname[24],string[256],Hour[5],Minute[5]; GetPlayerName(playerid,xname,24);
        format(Hour,5,"%s%d",((strval(tmp)<10)?("0"):("")),strval(tmp)); format(Minute,5,"%s%d",((strval(tmp2)<10)?("0"):("")),strval(tmp2));
        format(string,256,"Administrator \"%s\" has set everyone's time to \'%s:%s\'.",xname,Hour,Minute);
		for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerTime(i,strval(tmp),strval(tmp2)); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"setalltime");
}
dcmd_force(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"force")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/FORCE <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    SendCommandMessageToAdmins(playerid,"FORCE");
		    new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
		    ForceClassSelection(id); SetPlayerHealth(id,0); format(string,256,"Admnistrator \"%s\" has forced you to the spawn selection screen.",xname); SendClientMessage(id,yellow,string);
            format(string,256,"You have forced Player \"%s\" to the spawn selection screen.",ActionName); return SendClientMessage(playerid,yellow,string);
		} else return SendClientMessage(playerid,red,"ERROR: You can not force yourself or a disconnected player to the spawn selection screen.");
	} else return SendLevelErrorMessage(playerid,"force");
}
dcmd_setwanted(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setwanted")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 0 && strval(tmp2) <= 6)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETWANTED <NICK OR ID> <0-6>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"SETWANTED");
			new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has set your wanted level to %d.",xname,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You set \"%s\'s\" wanted level to %d.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have set your wanted level to %d.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			return SetPlayerWantedLevel(id,strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's wanted level.");
	} else return SendLevelErrorMessage(playerid,"setwanted");
}
dcmd_setallwanted(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setallwanted")) {
	    if(!strlen(params)||!IsNumeric(params)||!(strval(params) >= 0 && strval(params) <= 6)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETALLWANTED <0-6>\".");
		new xname[24],string[256]; GetPlayerName(playerid,xname,24);
		SendCommandMessageToAdmins(playerid,"SETALLWANTED");
        format(string,256,"Administrator \"%s\" has set everyone's wanted level to %d.",xname,strval(params));
		for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerWantedLevel(i,strval(params)); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"setallwanted");
}
dcmd_setworld(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setworld")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 0 && strval(tmp2) <= 255)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETWORLD <NICK OR ID> <VIRT. WORLD ID>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"SETWORLD");
			new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has set your virtual world to %d.",xname,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You set \"%s\'s\" virtual world to %d.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have set your virtual world to %d.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			return SetPlayerVirtualWorld(id,strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's virtual world.");
	} else return SendLevelErrorMessage(playerid,"setworld");
}
dcmd_setallworld(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setallworld")) {
	    if(!strlen(params)||!IsNumeric(params)||!(strval(params) >= 0 && strval(params) <= 255)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETALLWORLD <VIRT. WORLD ID>\".");
		new xname[24],string[256]; GetPlayerName(playerid,xname,24);
		SendCommandMessageToAdmins(playerid,"SETALLWORLD");
        format(string,256,"Administrator \"%s\" has set everyone's virtual world to %d.",xname,strval(params));
		for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerVirtualWorld(i,strval(params)); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"setallworld");
}
dcmd_setgravity(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setgravity")) {
	    if(!strlen(params)||!(strval(params)<=50&&strval(params)>=-50)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETGRAVITY <-50.0 - 50.0>\".");
        SendCommandMessageToAdmins(playerid,"SETGRAVITY");
		new string[256],xname[24]; GetPlayerName(playerid,xname,24); new Float:Gravity = floatstr(params);format(string,256,"Admnistrator \"%s\" has set the gravity to: \'%f\'.",xname,Gravity);
		SetGravity(Gravity); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"setgravity");
}
dcmd_carcolor(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"carcolor")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!(strval(tmp) >= 0 && strval(tmp) <= 126)||!IsNumeric(tmp)||!IsNumeric(tmp2)) return SendClientMessage(playerid,red,"Syntax Error: \"/CARCOLOR <COLOR 1> (<COLOR 2>)\".");
		if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,red,"ERROR: You must be in a vehicle.");
        SendCommandMessageToAdmins(playerid,"CARCOLOR");
		if(!strlen(tmp2)) tmp2 = tmp;
		new string[256],xname[24]; GetPlayerName(playerid,xname,24);
		format(string,256,"You have set your color data to: [Color 1: %d || Color 2: %d]",strval(tmp),strval(tmp2));
		return ChangeVehicleColor(GetPlayerVehicleID(playerid),strval(tmp),strval(tmp2));
	} else return SendLevelErrorMessage(playerid,"carcolor");
}
dcmd_gmx(playerid,params[]) {
    #pragma unused params
    if(IsPlayerCommandLevel(playerid,"gmx")) {
        SendCommandMessageToAdmins(playerid,"GMX");
        new string[256],xname[24]; GetPlayerName(playerid,xname,24); format(string,256,"Administrator \"%s\" has restarted the game mode.",xname); SendClientMessageToAll(yellow,string); return GameModeExit();
    } else return SendLevelErrorMessage(playerid,"gmx");
}
dcmd_carhealth(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"carhealth")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 0 && strval(tmp2) <= 1000)) return SendClientMessage(playerid,red,"Syntax Error: \"/CARHEALTH <NICK OR ID> <0-1000>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid,red,"ERROR: This player must be in a vehicle.");
            SendCommandMessageToAdmins(playerid,"CARHEALTH");
			new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has set your car's health to %.f percent.",xname,floatdiv(strval(tmp2),10)); SendClientMessage(id,yellow,string); format(string,256,"You have set \"%s's\" car's health to %d percent.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You've set your car's health to %.f percent.",floatdiv(strval(tmp2),10)); SendClientMessage(playerid,yellow,string); }
			return SetVehicleHealth(GetPlayerVehicleID(id),strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's car health.");
	} else return SendLevelErrorMessage(playerid,"carhealth");
}
dcmd_xinfo(playerid,params[]) {
	#pragma unused params
	return SendClientMessage(playerid,green,"X-Treme Administration Info: [Creator: Xtreme || Version: 2.2 || Release: 1 || Rel. Date: Sept. 13, 2007]");
}
dcmd_setping(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setping")) {
	    if(!strlen(params)||!(strval(params) >= 0 && strval(params) <= 10000)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETPING <[0 / OFF] - 10,000>\".");
   		if(!IsNumeric(params)) {
   		    if(!strcmp(params,"off",true)) { Config[MaxPing] = 0; SetConfigInt("MaxPing",0); }
   		    else return SendClientMessage(playerid,red,"Syntax Error: \"/SETPING <[0 / OFF] - 10,000>\".");
   	    }
        Config[MaxPing] = strval(params); SetConfigInt("MaxPing",strval(params));
    	SendCommandMessageToAdmins(playerid,"SETPING");
		new string[256],xname[24],Fo[30]; GetPlayerName(playerid,xname,24); format(Fo,30,"to %d",Config[MaxPing]); if(!Config[MaxPing]) Fo = "off";
		format(string,256,"Administrator \"%s\" has set the Maximum Ping %s.",xname,Fo); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"setping");
}
dcmd_givecar(playerid,params[]) {
    #pragma unused params
    if(IsPlayerCommandLevel(playerid,"givecar")) {
        if(Spec[playerid][Spectating]) return SendClientMessage(playerid,red,"ERROR: You must not be spectating.");
        if(IsPlayerInAnyVehicle(playerid)) {
            new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
            switch(Model) { case 448,461,462,463,468,471,509,510,521,522,523,581,586: return SendClientMessage(playerid,red,"ERROR: You can not add components to bikes!"); }
        	TogglePlayerControllable(playerid,false);
        	SetCameraBehindPlayer(playerid);
        	return ShowMenuForPlayer(GiveCar,playerid);
        } else return SendClientMessage(playerid,red,"ERROR: You must be in a vehicle.");
    } else return SendLevelErrorMessage(playerid,"givecar");
}
dcmd_xspec(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"xspec")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/XSPEC <NICK OR ID | OFF>\".");
        new id;
		if(!IsNumeric(params)) {
		    if(!strcmp(params,"off",true)) {
		        if(!Spec[playerid][Spectating]) return SendClientMessage(playerid,red,"ERROR: You must be spectating.");
		        SendCommandMessageToAdmins(playerid,"XSPEC");
		        TogglePlayerSpectating(playerid,false);
		        Spec[playerid][Spectating] = false;
		        return SendClientMessage(playerid,yellow,"You have turned your spectator mode off.");
		    }
		  	id = ReturnPlayerID(params);
		}
		else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    SendCommandMessageToAdmins(playerid,"SPEC");
		    new string[256],xname[24]; GetPlayerName(id,xname,24);
		    if(Spec[id][Spectating]) return SendClientMessage(playerid,red,"Error: You can not spectate a player already spectating.");
	        if(Spec[playerid][Spectating] && Spec[playerid][SpectateID] == id) return SendClientMessage(playerid,red,"ERROR: You are already spectating this player.");
			Spec[playerid][Spectating] = true, Spec[playerid][SpectateID] = id;
	        SetPlayerInterior(playerid,GetPlayerInterior(id));
	        TogglePlayerSpectating(playerid,true);
			if(!IsPlayerInAnyVehicle(id)) PlayerSpectatePlayer(playerid,id);
			else PlayerSpectateVehicle(playerid,GetPlayerVehicleID(id));
	    	format(string,256,"You are now spectating player \"%s\".",xname); return SendClientMessage(playerid,yellow,string);
		} else return SendClientMessage(playerid,red,"ERROR: You can not spectate yourself or a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"spec");
}
dcmd_xjail(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"xjail")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/XJAIL <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    if(Variables[id][Jailed]) return SendClientMessage(playerid,red,"ERROR: This player has already been jailed.");
		    SendCommandMessageToAdmins(playerid,"XJAIL");
			new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
			format(string,256,"Administrator \"%s\" has jailed you.",xname); SendClientMessage(id,yellow,string); format(string,256,"You have jailed \"%s\".",ActionName); SendClientMessage(playerid,yellow,string);
			SetUserInt(id,"Jailed",1); Variables[id][Jailed] = true; SetPlayerInterior(id,3); SetPlayerPos(id,197.6661,173.8179,1003.0234); return SetPlayerFacingAngle(id,0);
		} return SendClientMessage(playerid,red,"ERROR: You can not jail yourself or a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"xjail");
}
dcmd_xunjail(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"xunjail")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/XUNJAIL <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
            if(!Variables[id][Jailed]) return SendClientMessage(playerid,red,"ERROR: This player has already been unjailed.");
			SendCommandMessageToAdmins(playerid,"XUNJAIL");
			new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has unjailed you.",xname); SendClientMessage(id,yellow,string); format(string,256,"You have unjailed \"%s\".",ActionName); SendClientMessage(playerid,yellow,string); }
			else SendClientMessage(playerid,yellow,"You have unjailed yourself.");
			SetUserInt(id,"Jailed",0); Variables[id][Jailed] = false; return SpawnPlayer(id);
		} return SendClientMessage(playerid,red,"ERROR: You can not unjail a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"xunjail");
}
dcmd_setname(playerid,params[]) {
    if(IsPlayerCommandLevel(playerid,"setname")) {
    	new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
   	 	if(!strlen(tmp)||!strlen(tmp2)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETNAME <NICK OR ID> <NEW NAME>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
            SendCommandMessageToAdmins(playerid,"SETNAME");
			new string[256],xname[24],ActionName[24]; GetPlayerName(playerid,xname,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has set your name to %s.",xname,tmp2); SendClientMessage(id,yellow,string); format(string,256,"You have set \"%s's\" name to %s.",ActionName,tmp2); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You've set your name to %s.",tmp2); SendClientMessage(playerid,yellow,string); }
			OnPlayerConnect(id); return SetPlayerName(id,tmp2);
		} return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's name.");
	} else return SendLevelErrorMessage(playerid,"setname");
}
dcmd_admins(playerid,params[]) {
	#pragma unused params
	new ACount,i,xname[24],string[256];
	for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IsPlayerXAdmin(i)) ACount++;
	if(!ACount) return SendClientMessage(playerid,green,"Admins Online: None");
	if(ACount == 1) {
	    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IsPlayerXAdmin(i)) break;
	    GetPlayerName(i,xname,24); format(string,256,"Admins Online: %s (%d)",xname,Variables[i][Level]);
	    return SendClientMessage(playerid,green,string);
	}
	if(ACount >= 1) {
	    new bool:First = false;
	    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IsPlayerXAdmin(i)) {
     		GetPlayerName(i,xname,24);
			if(!First) { format(string,256,"Admins Online: %s (%d),",xname,Variables[i][Level]); First = true; }
	        else format(string,256,"%s %s (%d)",string,xname,Variables[i][Level]);
	    }
	    return SendClientMessage(playerid,green,string);
	}
	return 1;
}
dcmd_xcommands(playerid,params[]) {
    #pragma unused params
	if(!IsPlayerXAdmin(playerid)) return SendClientMessage(playerid,red,"ERROR: You must be an administrator to view these commands.");
    SendClientMessage(playerid,COLOR_LIGHTBLUE,"-=Xtreme's Administration Commands=-");
	SendClientMessage(playerid,yellow,"Environment: /weather - /morning - /afternoon - /evening - /midnight - /set(all)time - /say - /set(all)world - /setgravity");
	SendClientMessage(playerid,yellow,"Player: /goto - /gethere - /slap - /(un)wire - /kick - /ban - /akill - /(un)freeze(all) - /healall - /give(all)weapon - /force");
	SendClientMessage(playerid,yellow,"        /givehealth - /sethealth - /skinall- /armourall - /outside - /resetallweapons - /set/give/rem/reset(all)cash - /ip");
	SendClientMessage(playerid,yellow,"        /setskin - /givearmour - /setarmour - /setammo - /setscore - /ping - /explode - /setname - /set(all)wanted");
	SendClientMessage(playerid,yellow,"Vehicle: /flip - /eject(all) - /givecar - /carcolor - /carhealth - /x(un)lock");
	return SendClientMessage(playerid,yellow,"Console: /resetscores - /announce - /setsm - /setlevel - /god - /uconfig - /setping - /gmx - /xspec");
}
dcmd_vr(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"vr")) {
    	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,red,"ERROR: You must be in a vehicle to repair.");
		SetVehicleHealth(GetPlayerVehicleID(playerid),1000.0);
		return SendClientMessage(playerid,yellow,"You have successfully repaired your vehicle!");
	} else return SendLevelErrorMessage(playerid,"vr");
}
dcmd_weather(playerid,params[]) {
    #pragma unused params
    if(IsPlayerCommandLevel(playerid,"weather")) {
   		TogglePlayerControllable(playerid,false);
    	SetCameraBehindPlayer(playerid);
    	return ShowMenuForPlayer(Weather,playerid);
    } else return SendLevelErrorMessage(playerid,"weather");
}
dcmd_giveadmin(playerid,params[]) {
	#pragma unused params
	if(IsPlayerAdmin(playerid)) {
	    SetUserInt(playerid,"Level",10);
	    Variables[playerid][Level] = 10;
	    PlayerInfo[playerid][admin] = 10;
	    return SendClientMessage(playerid,yellow,"You have set yourself as a level 10 admin!");
	} else return SendClientMessage(playerid,red,"You must be a rcon admin to use this!");
}
//================================Race Commands=================================
dcmd_racehelp(playerid, params[])
{
    #pragma unused params
	SendClientMessage(playerid, COLOR_GREEN, "Yagu's race script racing help:");
	SendClientMessage(playerid, COLOR_WHITE, "/loadrace [name] to load a track and start it.");
	SendClientMessage(playerid, COLOR_WHITE, "/join to join a race");
	SendClientMessage(playerid, COLOR_WHITE, "/ready to begin the race once others are also ready");
	SendClientMessage(playerid, COLOR_WHITE, "/leave to leave the race");
	SendClientMessage(playerid, COLOR_WHITE, "/endrace to abort the race");
	SendClientMessage(playerid, COLOR_WHITE, "/bestlap and /bestrace to display record times for races, or specify a race to see the times for it");
	SendClientMessage(playerid, COLOR_WHITE, "/buildhelp for info on builing race");
	SendClientMessage(playerid, COLOR_WHITE, "/raceadmin for admin settings");
	return 1;
}

dcmd_buildhelp(playerid, params[])
{
    #pragma unused params
	SendClientMessage(playerid, COLOR_GREEN, "Yagu's race script building help:");
	SendClientMessage(playerid, COLOR_WHITE, "/buildrace to start building a race");
	SendClientMessage(playerid, COLOR_WHITE, "/cp for a new checkpoint - /scp to select an old checkpoint");
	SendClientMessage(playerid, COLOR_WHITE, "/dcp to delete a checkpoint - /mcp to move a checkpoint");
	SendClientMessage(playerid, COLOR_WHITE, "/rcp to replace checkpoint with a new one");
	SendClientMessage(playerid, COLOR_WHITE, "/editrace to load a race in the editor");
	SendClientMessage(playerid, COLOR_WHITE, "/saverace [name] to save the race");
	SendClientMessage(playerid, COLOR_WHITE, "/buildmenu to set racemode/laps/etc");
	SendClientMessage(playerid, COLOR_WHITE, "/racehelp for info on racing itself");
	SendClientMessage(playerid, COLOR_WHITE, "/raceadmin for admin settings");
	return 1;
}

dcmd_buildrace(playerid, params[])
{
    #pragma unused params
	if(BuildAdmin == 1 && IsNotAdmin(playerid)) return 1;
	if(RaceBuilders[playerid] != 0)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "You are already building a race.");
	}
	else if(RaceParticipant[playerid]>0)
	{
	    SendClientMessage(playerid, COLOR_YELLOW, "You are participating in a race, can't build a race.");
	}
	else
	{
		new slot;
		slot=GetBuilderSlot(playerid);
		if(slot == 0)
		{
			SendClientMessage(playerid, COLOR_YELLOW, "No builderslots available!");
			return 1;
		}
		format(ystring,sizeof(ystring),"You are now building a race (Slot: %d)",slot);
		SendClientMessage(playerid, COLOR_GREEN, ystring);
		RaceBuilders[playerid]=slot;
		BCurrentCheckpoints[b(playerid)]=0;
		Bracemode[b(playerid)]=0;
		Blaps[b(playerid)]=0;
		BAirrace[b(playerid)] = 0;
		BCPsize[b(playerid)] = 8.0;
	}
	return 1;
}

dcmd_cp(playerid, params[])
{
	#pragma unused params
	if(RaceBuilders[playerid] != 0 && BCurrentCheckpoints[b(playerid)] < MAX_RACECHECKPOINTS)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid,x,y,z);
		format(ystring,sizeof(ystring),"Checkpoint %d created: %f,%f,%f.",BCurrentCheckpoints[b(playerid)],x,y,z);
		SendClientMessage(playerid, COLOR_GREEN, ystring);
		BRaceCheckpoints[b(playerid)][BCurrentCheckpoints[b(playerid)]][0]=x;
		BRaceCheckpoints[b(playerid)][BCurrentCheckpoints[b(playerid)]][1]=y;
		BRaceCheckpoints[b(playerid)][BCurrentCheckpoints[b(playerid)]][2]=z;
		BSelectedCheckpoint[b(playerid)]=BCurrentCheckpoints[b(playerid)];
		SetBRaceCheckpoint(playerid,BCurrentCheckpoints[b(playerid)],-1);
		BCurrentCheckpoints[b(playerid)]++;
	}
	else if(RaceBuilders[playerid] != 0 && BCurrentCheckpoints[b(playerid)] == MAX_RACECHECKPOINTS)
	{
		format(ystring,sizeof(ystring),"Sorry, maximum amount of checkpoints reached (%d).",MAX_RACECHECKPOINTS);
		SendClientMessage(playerid, COLOR_YELLOW, ystring);
	}
	else
	{
		SendClientMessage(playerid, COLOR_RED, "You are not building a race!");
	}
	return 1;
}

dcmd_scp(playerid, params[])
{
	new sele, tmp[256], idx;
    tmp = rstrtok(params, idx);
    if(!strlen(tmp)) {
		SendClientMessage(playerid, COLOR_WHITE, "USAGE: /scp [checkpoint]");
		return 1;
    }
    sele = strval(tmp);
	if(RaceBuilders[playerid] != 0)
	{
		if(sele>BCurrentCheckpoints[b(playerid)]-1 || BCurrentCheckpoints[b(playerid)] < 1 || sele < 0)
		{
			SendClientMessage(playerid, COLOR_YELLOW, "Invalid checkpoint!");
			return 1;
		}
		format(ystring,sizeof(ystring),"Selected checkpoint %d.",sele);
		SendClientMessage(playerid, COLOR_GREEN, ystring);
		BActiveCP(playerid,sele);
		BSelectedCheckpoint[b(playerid)]=sele;
	}
	else
	{
		SendClientMessage(playerid, COLOR_RED, "You are not building a race!");
	}
	return 1;
}

dcmd_rcp(playerid, params[])
{
	#pragma unused params
	if(RaceBuilders[playerid] == 0)
	{
		SendClientMessage(playerid, COLOR_RED, "You are not building a race!");
		return 1;
	}
	else if(BCurrentCheckpoints[b(playerid)] < 1)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "No checkpoint to replace!");
		return 1;
	}
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	format(ystring,sizeof(ystring),"Checkpoint %d replaced: %f,%f,%f.",BSelectedCheckpoint[b(playerid)],x,y,z);
	SendClientMessage(playerid, COLOR_GREEN, ystring);
	BRaceCheckpoints[b(playerid)][BSelectedCheckpoint[b(playerid)]][0]=x;
	BRaceCheckpoints[b(playerid)][BSelectedCheckpoint[b(playerid)]][1]=y;
	BRaceCheckpoints[b(playerid)][BSelectedCheckpoint[b(playerid)]][2]=z;
	BActiveCP(playerid,BSelectedCheckpoint[b(playerid)]);
    return 1;
}

dcmd_mcp(playerid, params[])
{
	if(RaceBuilders[playerid] == 0)
	{
		SendClientMessage(playerid, COLOR_RED, "You are not building a race!");
		return 1;
	}
	else if(BCurrentCheckpoints[b(playerid)] < 1)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "No checkpoint to move!");
		return 1;
	}
	new idx, direction, dir[32];
	dir=rstrtok(params, idx);
	new Float:amount=floatstr(rstrtok(params,idx));
	if(amount == 0.0 || (dir[0] != 'x' && dir[0]!='y' && dir[0]!='z'))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USAGE: /mcp [x,y or z] [amount]");
		return 1;
	}
    if(dir[0] == 'x') direction=0;
    else if (dir[0] == 'y') direction=1;
    else if (dir[0] == 'z') direction=2;
    BRaceCheckpoints[b(playerid)][BSelectedCheckpoint[b(playerid)]][direction]=BRaceCheckpoints[b(playerid)][BSelectedCheckpoint[b(playerid)]][direction]+amount;
	BActiveCP(playerid,BSelectedCheckpoint[b(playerid)]);
	return 1;
}

dcmd_dcp(playerid, params[])
{
	#pragma unused params
	if(RaceBuilders[playerid] == 0)
	{
		SendClientMessage(playerid, COLOR_RED, "You are not building a race!");
		return 1;
	}
	else if(BCurrentCheckpoints[b(playerid)] < 1)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "No checkpoint to delete!");
		return 1;
	}
	for(new i=BSelectedCheckpoint[b(playerid)];i<BCurrentCheckpoints[b(playerid)];i++)
	{
		BRaceCheckpoints[b(playerid)][i][0]=BRaceCheckpoints[b(playerid)][i+1][0];
		BRaceCheckpoints[b(playerid)][i][1]=BRaceCheckpoints[b(playerid)][i+1][1];
		BRaceCheckpoints[b(playerid)][i][2]=BRaceCheckpoints[b(playerid)][i+1][2];
	}
	BCurrentCheckpoints[b(playerid)]--;
	BSelectedCheckpoint[b(playerid)]--;
	if(BCurrentCheckpoints[b(playerid)] < 1)
	{
	    DisablePlayerRaceCheckpoint(playerid);
	    BSelectedCheckpoint[b(playerid)]=0;
		return 1;
	}
	else if(BSelectedCheckpoint[b(playerid)] < 0)
	{
	    BSelectedCheckpoint[b(playerid)]=0;
	}
	BActiveCP(playerid,BSelectedCheckpoint[b(playerid)]);
	SendClientMessage(playerid,COLOR_GREEN,"Checkpoint deleted!");
	return 1;
}

dcmd_clearrace(playerid,params[])
{
	#pragma unused params
	if(RaceBuilders[playerid] != 0) clearrace(playerid);
	else SendClientMessage(playerid, COLOR_RED, "You are not building a race!");
	return 1;
}

dcmd_editrace(playerid,params[])
{
	if(RaceBuilders[playerid] == 0)
	{
		SendClientMessage(playerid, COLOR_RED, "You are not building a race!");
		return 1;
	}
	if(BCurrentCheckpoints[b(playerid)]>0) //Clear the old race if there is such.
	{
		for(new i=0;i<BCurrentCheckpoints[b(playerid)];i++)
		{
			BRaceCheckpoints[b(playerid)][i][0]=0.0;
			BRaceCheckpoints[b(playerid)][i][1]=0.0;
			BRaceCheckpoints[b(playerid)][i][2]=0.0;
		}
		BCurrentCheckpoints[b(playerid)]=0;
	}
	new tmp[256],idx;
    tmp = rstrtok(params, idx);
    if(!strlen(tmp))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USAGE: /editrace [name]");
		return 1;
    }
	new race_name[32],templine[42];
	format(race_name,sizeof(race_name), "%s.yr",tmp);
	if(!fexist(race_name))
	{
		format(ystring,sizeof(ystring), "The race \"%s\" doesn't exist.",tmp);
		SendClientMessage(playerid, COLOR_RED, ystring);
		return 1;
	}
    BCurrentCheckpoints[b(playerid)]=-1;
	new File:f, i;
	f = fopen(race_name, io_read);
	fread(f,templine,sizeof(templine));
	if(templine[0] == 'Y') //Checking if the racefile is v0.2+
	{
		new fileversion;
	    rstrtok(templine,i); // read off YRACE
		fileversion = strval(rstrtok(templine,i)); // read off the file version
		if(fileversion > RACEFILE_VERSION) // Check if the race is made with a newer version of the racefile format
		{
		    format(ystring,128,"Race \'%s\' is created with a newer version of YRACE, unable to load.",tmp);
		    SendClientMessage(playerid,COLOR_RED,ystring);
		    return 1;
		}
		rstrtok(templine,i); // read off RACEBUILDER
		Bracemode[b(playerid)] = strval(rstrtok(templine,i)); // read off racemode
		Blaps[b(playerid)] = strval(rstrtok(templine,i)); // read off amount of laps
		if(fileversion >= 2)
		{
		    BAirrace[b(playerid)] = strval(rstrtok(templine,i));
		    BCPsize[b(playerid)] = floatstr(rstrtok(templine,i));
		}
		else
		{
			BAirrace[b(playerid)] = 0;
			BCPsize[b(playerid)] = 8.0;
		}
		fread(f,templine,sizeof(templine)); // read off best race times, not saved due to editing the track
		fread(f,templine,sizeof(templine)); // read off best lap times,          -||-
	}
	else //Otherwise add the lines as checkpoints, the file is made with v0.1 (or older) version of the script.
	{
		BCurrentCheckpoints[b(playerid)]++;
		BRaceCheckpoints[b(playerid)][BCurrentCheckpoints[b(playerid)]][0] = floatstr(rstrtok(templine,i));
		BRaceCheckpoints[b(playerid)][BCurrentCheckpoints[b(playerid)]][1] = floatstr(rstrtok(templine,i));
		BRaceCheckpoints[b(playerid)][BCurrentCheckpoints[b(playerid)]][2] = floatstr(rstrtok(templine,i));
	}
	while(fread(f,templine,sizeof(templine),false))
	{
		BCurrentCheckpoints[b(playerid)]++;
		i=0;
		BRaceCheckpoints[b(playerid)][BCurrentCheckpoints[b(playerid)]][0] = floatstr(rstrtok(templine,i));
		BRaceCheckpoints[b(playerid)][BCurrentCheckpoints[b(playerid)]][1] = floatstr(rstrtok(templine,i));
		BRaceCheckpoints[b(playerid)][BCurrentCheckpoints[b(playerid)]][2] = floatstr(rstrtok(templine,i));
	}
	fclose(f);
	BCurrentCheckpoints[b(playerid)]++; // # of next CP to be created
	format(ystring,sizeof(ystring),"Race \"%s\" has been loaded for editing. (%d checkpoints)",tmp,BCurrentCheckpoints[b(playerid)]);
	SendClientMessage(playerid, COLOR_GREEN,ystring);
    return 1;
}

dcmd_saverace(playerid, params[])
{
	if(RaceBuilders[playerid] != 0)
	{
		new tmp[256], idx;
	    tmp = rstrtok(params, idx);
	    if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /saverace [name]");
			return 1;
	    }
	    if(BCurrentCheckpoints[b(playerid)] < 2)
	    {
	        SendClientMessage(playerid, COLOR_YELLOW, "You need atleast 2 checkpoints to save!");
	        return 1;
	    }
		new race_name[32],templine[42];
		format(race_name, 32, "%s.yr",tmp);
		if(fexist(race_name))
		{
			format(ystring,sizeof(ystring), "Race \"%s\" already exists.",tmp);
			SendClientMessage(playerid, COLOR_RED, ystring);
			return 1;
		}
		new File:f,Float:x,Float:y,Float:z, Bcreator[MAX_PLAYER_NAME];
		GetPlayerName(playerid, Bcreator, MAX_PLAYER_NAME);
		f = fopen(race_name,io_write);
		format(templine,sizeof(templine),"YRACE %d %s %d %d %d %f\n", RACEFILE_VERSION, Bcreator, Bracemode[b(playerid)], Blaps[b(playerid)], BAirrace[b(playerid)], BCPsize[b(playerid)]);
		fwrite(f,templine);
		format(templine,sizeof(templine),"A 0 A 0 A 0 A 0 A 0\n"); //Best complete race times
		fwrite(f,templine);
		format(templine,sizeof(templine),"A 0 A 0 A 0 A 0 A 0\n"); //Best lap times
		fwrite(f,templine);
		for(new i = 0; i < BCurrentCheckpoints[b(playerid)];i++)
		{
			x=BRaceCheckpoints[b(playerid)][i][0];
			y=BRaceCheckpoints[b(playerid)][i][1];
			z=BRaceCheckpoints[b(playerid)][i][2];
			format(templine,sizeof(templine),"%f %f %f\n",x,y,z);
			fwrite(f,templine);
		}
		fclose(f);
		format(ystring,sizeof(ystring),"Your race \"%s\" has been saved.",tmp);
   		SendClientMessage(playerid, COLOR_GREEN, ystring);
	}
	else
	{
		SendClientMessage(playerid, COLOR_RED, "You are not building a race!");
	}
	return 1;
}

dcmd_setlaps(playerid,params[])
{
	new tmp[256], idx;
    tmp = rstrtok(params, idx);
    if(!strlen(tmp) || strval(tmp) <= 0)
	{
		SendClientMessage(playerid, COLOR_WHITE, "USAGE: /setlaps [amount of laps (min: 1)]");
		return 1;
   	}
	if(RaceBuilders[playerid] != 0)
    {
		Blaps[b(playerid)] = strval(tmp);
		format(tmp,sizeof(tmp),"Amount of laps set to %d.", Blaps[b(playerid)]);
		SendClientMessage(playerid, COLOR_GREEN, tmp);
        return 1;
    }
	if(RaceAdmin == 1 && IsNotAdmin(playerid)) return 1;
	if(RaceActive == 1 || RaceStart == 1) SendClientMessage(playerid, COLOR_RED, "Race already in progress!");
	else if(LCurrentCheckpoint == 0) SendClientMessage(playerid, COLOR_YELLOW, "No race loaded.");
	else
	{
	    Racelaps=strval(tmp);
		format(tmp,sizeof(tmp),"Amount of laps set to %d for current race.", Racelaps);
		SendClientMessage(playerid, COLOR_GREEN, tmp);
	}
	return 1;
}

dcmd_racemode(playerid,params[])
{
	new tmp[256], idx, tempmode;
    tmp = rstrtok(params, idx);
    if(!strlen(tmp))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USAGE: /racemode [0/1/2/3]");
		return 1;
   	}
	if(tmp[0] == 'd') tempmode=0;
	else if(tmp[0] == 'r') tempmode=1;
	else if(tmp[0] == 'y') tempmode=2;
	else if(tmp[0] == 'm') tempmode=3;
	else tempmode=strval(tmp);

	if (0 > tempmode || tempmode > 3)
   	{
   	    SendClientMessage(playerid, COLOR_YELLOW, "Invalid racemode!");
		return 1;
   	}
	if(RaceBuilders[playerid] != 0)
    {
		if(tempmode == 2 && BCurrentCheckpoints[b(playerid)] < 3)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, "Can't set racemode 2 on races with only 2 CPs. Changing to mode 1 instead.");
		    Bracemode[b(playerid)] = 1;
		    return 1;
		}
		Bracemode[b(playerid)] = tempmode;
		format(tmp,sizeof(tmp),"Racemode set to %d.", Bracemode[b(playerid)]);
		SendClientMessage(playerid, COLOR_GREEN, tmp);
        return 1;
    }
	if(RaceAdmin == 1 && IsNotAdmin(playerid)) return 1;
	if(RaceActive == 1 || RaceStart == 1) SendClientMessage(playerid, COLOR_RED, "Race already in progress!");
	else if(LCurrentCheckpoint == 0) SendClientMessage(playerid, COLOR_YELLOW, "No race loaded.");
	else
	{
		if(tempmode == 2 && LCurrentCheckpoint < 2)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, "Can't set racemode 2 on races with only 2 CPs. Changing to mode 1 instead.");
		    Racemode = 1;
		    return 1;
		}
	    Racemode=tempmode;
		format(tmp,sizeof(tmp),"Racemode set to %d.", Racemode);
		SendClientMessage(playerid, COLOR_GREEN, tmp);
	}
	return 1;
}

dcmd_loadrace(playerid, params[])
{
	if(RaceAdmin == 1 && IsNotAdmin(playerid)) return 1;
	Racemode = 0; Racelaps = 1;
	new tmp[128], idx, fback;
    tmp = rstrtok(params, idx);
    if(!strlen(tmp))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USAGE: /loadrace [name]");
		return 1;
    }
    if(RaceActive == 1)
    {
		SendClientMessage(playerid, COLOR_RED, "A race is already active!");
		return 1;
    }
	fback=LoadRace(tmp);
	if(fback == -1) format(ystring,sizeof(ystring),"Race \'%s\' doesn't exist!",tmp);
	else if (fback == -2) format(ystring,sizeof(ystring),"Race \'%s\' is created with a newer version of YRACE, cannot load.",tmp);
	if(fback < 0)
	{
	    SendClientMessage(playerid,COLOR_RED,ystring);
	    return 1;
	}
	format(ystring,sizeof(ystring),"Race \'%s\' loaded, /startrace to start it. You can change laps and mode before that.",CRaceName);
	SendClientMessage(playerid,COLOR_GREEN,ystring);
	if(LCurrentCheckpoint<2 && Racemode == 2)
	{
	    Racemode = 1; // Racemode 2 doesn't work well with only 2CPs, and mode 1 is just the same when playing with 2 CPs.
	}                 // Setting racemode 2 is prevented from racebuilder so this shouldn't happen anyways.
#if defined MENUSYSTEM
	if(!IsValidMenu(MRace)) CreateRaceMenus();
	if(Airrace == 0) SetMenuColumnHeader(MRace,0,"Air race: off");
	else SetMenuColumnHeader(MRace,0,"Air race: ON");
	TogglePlayerControllable(playerid,0);
	ShowMenuForPlayer(MRace,playerid);
#endif
	return 1;
}

dcmd_startrace(playerid, params[])
{
	#pragma unused params
    if(RaceAdmin == 1 && IsNotAdmin(playerid)) return 1;
	if(LCurrentCheckpoint == 0) SendClientMessage(playerid,COLOR_YELLOW,"No race loaded!");
	else if (RaceActive == 1) SendClientMessage(playerid,COLOR_YELLOW,"Race is already active!");
	else startrace();
	return 1;
}


dcmd_deleterace(playerid, params[])
{
	if((RaceAdmin == 1 || BuildAdmin == 1) && IsNotAdmin(playerid)) return 1;
	new filename[128], idx;
	filename = rstrtok(params,idx);
	if(!(strlen(filename)))
	{
	    SendClientMessage(playerid, COLOR_WHITE, "USAGE: /deleterace [race]");
	    return 1;
	}
	format(filename,sizeof(filename),"%s.yr",filename);
	if(!fexist(filename))
	{
		format(ystring,sizeof(ystring), "The race \"%s\" doesn't exist.",filename);
		SendClientMessage(playerid, COLOR_RED, ystring);
		return 1;
	}
	fremove(filename);
	format(ystring,sizeof(ystring), "The race \"%s\" has been deleted.",filename);
	SendClientMessage(playerid, COLOR_GREEN, ystring);
	return 1;
}

dcmd_join(playerid,params[])
{
	#pragma unused params
	if(RaceBuilders[playerid] != 0)
	{
	    SendClientMessage(playerid, COLOR_YELLOW, "You are currently building a race, can't join. Use /clearrace to exit build mode.");
	    return 1;
	}
	if(RaceParticipant[playerid]>0)
	{
	    SendClientMessage(playerid, COLOR_YELLOW, "You've already joined the race!");
	}
	else if(RaceActive==1 && RaceStart==0)
	{
		if(PrizeMode >= 2 && GetPlayerMoney(playerid) < JoinFee)
		{
			format(ystring,sizeof(ystring),"You don't have enough money to join the race! (Join fee: %d$)",JoinFee);
			SendClientMessage(playerid, COLOR_YELLOW, ystring);
			return 1;
		}
		else if (PrizeMode >= 2)
		{
			new tempval;
			tempval=(-1)*JoinFee;
		    GivePlayerMoney(playerid,tempval);
		    Pot+=JoinFee;
		}
		CurrentCheckpoint[playerid]=0;
		if(Racemode == 3)
		{
			SetRaceCheckpoint(playerid,LCurrentCheckpoint,LCurrentCheckpoint-1);
			CurrentCheckpoint[playerid]=LCurrentCheckpoint;
		}
		else SetRaceCheckpoint(playerid,0,1);
		RaceParticipant[playerid]=1;
		CurrentLap[playerid]=0;
		SendClientMessage(playerid, COLOR_GREEN, "You have joined the race, go to the start!");
		Participants++;
	}
	else if(RaceActive==1 && RaceStart==1)
	{
	    SendClientMessage(playerid, COLOR_YELLOW, "The race has already started, can't join.");
	}
	else
	{
	    SendClientMessage(playerid, COLOR_YELLOW, "There is no race you can join.");
	}
	return 1;
}

dcmd_leave(playerid,params[])
{
	#pragma unused params
	if(RaceParticipant[playerid] > 0)
	{
       	if(RaceParticipant[playerid]==3 && RaceStart == 1) //Countdown in progress, no leaving during it.
		{
			SendClientMessage(playerid,COLOR_RED,"Unable to leave at this time: Countdown in progress.");
			return 1;
		}
		DisablePlayerRaceCheckpoint(playerid);
		RaceParticipant[playerid]=0;
		Participants--;
		SendClientMessage(playerid,COLOR_YELLOW,"You have left the race.");
		if(PrizeMode >= 2 && RaceStart == 0)
		{
		    GivePlayerMoney(playerid,JoinFee/2);
		    Pot-=JoinFee/2;
		}
        if(Participants == 0) endrace();
		else if(RaceStart == 0)ReadyRefresh();
	}
	else SendClientMessage(playerid, COLOR_YELLOW, "You aren't in a race.");
    return 1;
}

dcmd_endrace(playerid, params[])
{
	#pragma unused params
	if(RaceAdmin == 1 && IsNotAdmin(playerid)) return 1;
    if(RaceActive==0)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "There is no race active.");
		return 1;
    }
    endrace();
	return 1;
}

dcmd_ready(playerid, params[])
{
	#pragma unused params
	new PState=GetPlayerState(playerid);
	if(RaceParticipant[playerid]==2 && PState != PLAYER_STATE_PASSENGER)
	{
		SendClientMessage(playerid,COLOR_GREEN,"You are now ready. Type /ready again to cancel.");
		RaceParticipant[playerid]=3;
		ReadyRefresh();
	}
	else if (RaceParticipant[playerid]==3 && RaceStart==0)
	{
	    SendClientMessage(playerid,COLOR_YELLOW,"You are now not ready. Type /ready when you are.");
	    RaceParticipant[playerid]=2;
	}
	else if (PState == PLAYER_STATE_PASSENGER) SendClientMessage(playerid,COLOR_YELLOW,"You need to be driving for yourself!");
	else if(RaceParticipant[playerid] == 1) SendClientMessage(playerid,COLOR_YELLOW,"You must have visited the starting CP to /ready.");
	else SendClientMessage(playerid,COLOR_YELLOW,"You have not participated in a race.");
    return 1;
}

dcmd_bestlap(playerid,params[])
{
	new tmp[64], idx;
    tmp = rstrtok(params, idx);
	if(LoadTimes(playerid,1,tmp)) return 1;
	if(TopLapTimes[0] == 0)
	{
	    SendClientMessage(playerid,COLOR_YELLOW,"No scores available.");
		return 1;
	}
	else if(ORacemode == 0)
	{
	    SendClientMessage(playerid,COLOR_YELLOW,"This race doesn't have any laps.");
		return 1;
	}
	format(ystring,sizeof(ystring),"%s by %s - Best Laps:",CRaceName,CBuilder);
	SendClientMessage(playerid,COLOR_GREEN,ystring);
	for(new i;i<5;i++)
	{
		if(TopLapTimes[i] == 0)
		{
		    format(ystring,sizeof(ystring),"%d. None yet",i+1);
			i=6;
		}
		else
		{
	 	   format(ystring,sizeof(ystring),"%d. %s - %s",i+1,BeHuman(TopLapTimes[i]),TopLappers[i]);
	    }
	    SendClientMessage(playerid,COLOR_GREEN,ystring);
	}
    return 1;
}

dcmd_bestrace(playerid,params[])
{
	new tmp[64], idx;
    tmp = rstrtok(params, idx);
	if(LoadTimes(playerid,0,tmp)) return 1;
	if(TopRacerTimes[0] == 0)
	{
	    SendClientMessage(playerid,COLOR_YELLOW,"No scores available.");
		return 1;
	}
	format(ystring,sizeof(ystring),"%s by %s - Best Race times:",CRaceName,CBuilder);
	SendClientMessage(playerid,COLOR_GREEN,ystring);
	for(new i;i<5;i++)
	{
		if(TopRacerTimes[i] == 0)
		{
		    format(ystring,sizeof(ystring),"%d. None yet",i+1);
			i=6;
		}
		else
		{
	 	   format(ystring,sizeof(ystring),"%d. %s - %s",i+1,BeHuman(TopRacerTimes[i]),TopRacers[i]);
	    }
	    SendClientMessage(playerid,COLOR_GREEN,ystring);
	}
    return 1;
}

dcmd_airrace(playerid,params[])
{
	#pragma unused params
	if(RaceBuilders[playerid] != 0)
	{
	    if(BAirrace[b(playerid)] == 0)
	    {
	        SendClientMessage(playerid,COLOR_GREEN,"Air race enabled.");
			BAirrace[b(playerid)]=1;
	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_GREEN,"Air race disabled.");
			BAirrace[b(playerid)]=0;
	    }
		return 1;
	}
	if(RaceAdmin == 1 && IsNotAdmin(playerid)) return 1;
	if(RaceActive == 1 || RaceStart == 1) SendClientMessage(playerid, COLOR_YELLOW, "Race is already in progress!");
	else if(LCurrentCheckpoint == 0) SendClientMessage(playerid, COLOR_YELLOW, "No race loaded!");
	else if(Airrace == 0)
    {
        SendClientMessage(playerid,COLOR_GREEN,"Air race enabled.");
		Airrace = 1;
    }
    else if(Airrace == 1)
    {
        SendClientMessage(playerid,COLOR_GREEN,"Air race disabled.");
		Airrace = 0;
    }
    else printf("Error in /airrace detected. RaceActive: %d, RaceStart: %d LCurrentCheckpoint: %d, Airrace: %d", RaceActive,RaceStart,LCurrentCheckpoint,Airrace);
	return 1;
}

dcmd_cpsize(playerid,params[])
{
	new idx, tmp[32];
	tmp = rstrtok(params,idx);
	if(!(strlen(tmp)) || floatstr(tmp) <= 0.0)
	{
	    SendClientMessage(playerid,COLOR_WHITE,"USAGE: /cpsize [size]");
	    return 1;
	}
	if(RaceBuilders[playerid] != 0)
	{
	    BCPsize[b(playerid)] = floatstr(tmp);
	    format(ystring,sizeof(ystring),"Checkpoint size set to %f",floatstr(tmp));
		SendClientMessage(playerid,COLOR_GREEN,ystring);
	    return 1;
	}
	if(RaceAdmin == 1 && IsNotAdmin(playerid)) return 1;
	if(RaceActive == 1) SendClientMessage(playerid, COLOR_YELLOW, "Race has already been activated!");
	else if(LCurrentCheckpoint == 0) SendClientMessage(playerid, COLOR_YELLOW, "No race loaded!");
	else
	{
	    CPsize = floatstr(tmp);
	    format(ystring,sizeof(ystring),"Checkpoint size set to %f",floatstr(tmp));
		SendClientMessage(playerid,COLOR_GREEN,ystring);
	}
	return 1;
}

dcmd_prizemode(playerid,params[])
{
	if(IsNotAdmin(playerid)) return 1;
	new idx, tmp;
	tmp=strval(rstrtok(params,idx));
    if(tmp < 0 || tmp > 4) SendClientMessage(playerid,COLOR_WHITE,"USAGE: /prizemode [0-4]");
	else if(RaceActive == 1) SendClientMessage(playerid,COLOR_YELLOW,"Race is already active!");
    else
    {
        PrizeMode = tmp;
        format(ystring,sizeof(ystring),"Prizemode set to %d",PrizeMode);
		SendClientMessage(playerid,COLOR_GREEN,ystring);
    }
	return 1;
}

dcmd_setprize(playerid,params[])
{
	if(IsNotAdmin(playerid)) return 1;
	new idx, tmp;
    tmp = strval(rstrtok(params, idx));
    if(0 >= tmp) SendClientMessage(playerid,COLOR_WHITE,"USAGE: /setprize [amount]");
	else if(RaceActive == 1) SendClientMessage(playerid,COLOR_YELLOW,"Race is already active!");
    else
    {
        Prize = tmp;
        format(ystring,sizeof(ystring),"Prize set to %d",Prize);
		SendClientMessage(playerid,COLOR_GREEN,ystring);
    }
	return 1;
}

#if defined MENUSYSTEM
dcmd_raceadmin(playerid,params[])
{
	#pragma unused params
	if(IsNotAdmin(playerid)) return 1;
	if(!IsValidMenu(MAdmin)) CreateRaceMenus();
	TogglePlayerControllable(playerid,0);
	ShowMenuForPlayer(MAdmin,playerid);
	return 1;
}

dcmd_buildmenu(playerid,params[])
{
	#pragma unused params
	if(BuildAdmin == 1 && IsNotAdmin(playerid)) return 1;
	if(RaceBuilders[playerid] == 0)
	{
		SendClientMessage(playerid,COLOR_YELLOW,"You are not building a race!");
		return 1;
	}
	if(BAirrace[b(playerid)] == 0) SetMenuColumnHeader(MBuild,0,"Air race: off");
	else SetMenuColumnHeader(MBuild,0,"Air race: on");
	if(!IsValidMenu(MBuild)) CreateRaceMenus();
	TogglePlayerControllable(playerid,0);
	ShowMenuForPlayer(MBuild,playerid);
	return 1;
}
#endif
//=================================KIHC Stuff===================================
LoadPly(playerid,info[],value[]){
	new filen[256],hpname[256];
	GetPlayerName(playerid,hpname,255);
	format(filen,256,"%s.zip",hpname);
	new data[256];
	new front;
	new len;
	if (fexist(filen)){}
	else{
		new File:open = fopen(filen,io_write);
		fclose(open);
	}
	new File:Read = fopen(filen,io_read);
	fread(Read,data);
	len = strlen(data);
	front = strfind(data,info,true);
	if (front == -1){
		return 0;
	}
	else{
		strdel(data,0,front);
		front = strfind(data,"=");
		strdel(data,0,front);
		front = strfind(data,";");
		strdel(data,0,1);
		strdel(data,front-1,len);
		format(value,sizeof(data),data);
		return 1;
	}
}

SavePly(playerid,info[],value[]){
	new sta[256];
	new filen[256],hpname[256];
	GetPlayerName(playerid,hpname,255);
	format(filen,256,"%s.zip",hpname);
	if (fexist(filen)){}
	else{
		new File:open = fopen(filen,io_write);
		fclose(open);
	}
	format(sta,256,"%s=",info);
	new data[256],fnd;
	new File:Check = fopen(filen,io_read);
	fread(Check,data);
	fclose(Check);
	fnd = strfind(data,sta);
	if(fnd ==-1){
		new File:Read = fopen(filen,io_append);
		format(data,256,"%s=%s;",info,value);
		fwrite(Read,data);
		fclose(Read);
		////print("meee");
	}
	else{
		new len,str;
		new hstring[256];
		new File:Read = fopen(filen,io_read);
		fread(Read,data);
		////print(data);
		str = strfind(data,info);
		len = strfind(data,";",true,str);
		strdel(data,str,len+1);
		////print(data);
		format(hstring,256,"%s=%s;",info,value);
		strins(data,hstring,str);
		////print(data);
		fclose(Read);
		new File:Write = fopen(filen,io_write);
		fwrite(Write,data);
		fclose(Write);
		////print("me");
	}
}

Loadpropertt(hpname[],info[],value[]){
	new filen[256];
	format(filen,256,"%s.zip",hpname);
	new data[256];
	new front;
	new len;
	if (fexist(filen)){}
	else{
		new File:open = fopen(filen,io_write);
		fclose(open);
	}
	new File:Read = fopen(filen,io_read);
	fread(Read,data);
	len = strlen(data);
	front = strfind(data,info,true);
	if (front == -1){
		////print("loop ");
		return 0;
	}
	else{
		strdel(data,0,front);
		front = strfind(data,"=");
		strdel(data,0,front);
		front = strfind(data,";");
		strdel(data,0,1);
		strdel(data,front-1,len);
		format(value,sizeof(data),data);
		////print("loop ");
		return 1;
	}
}

Savepropertt(hpname[],info[],value[]){
	new sta[256];
	new filen[256];
	format(filen,256,"%s.zip",hpname);
	format(sta,256,"%s=",info);
	new data[256],fnd;
	if (fexist(filen)){}
	else{
		new File:open = fopen(filen,io_write);
		fclose(open);
	}
	new File:Check = fopen(filen,io_read);
	fread(Check,data);
	fclose(Check);
	fnd = strfind(data,sta);
	if(fnd ==-1){
		new File:Read = fopen(filen,io_append);
		format(data,256,"%s=%s;",info,value);
		fwrite(Read,data);
		fclose(Read);
		////print("meee");
	}
	else{
		new len,str;
		new hstring[256];
		new File:Read = fopen(filen,io_read);
		fread(Read,data);
		////print(data);
		str = strfind(data,info);
		len = strfind(data,";",true,str);
		strdel(data,str,len+1);
		////print(data);
		format(hstring,256,"%s=%s;",info,value);
		strins(data,hstring,str);
		////print(data);
		fclose(Read);
		new File:Write = fopen(filen,io_write);
		fwrite(Write,data);
		fclose(Write);
		////print("me");
	}
}

SetHouseCost(Houseid,hcost){
	new str[256];
	valstr(str,hcost);
	SetHouseInfo(Houseid,"cost",str);
}

MakeTenent1(playerid,Houseid){
	////print("MakeTenent1");
	new str1[256],str2[256],d;
	new str3[100];
	format(str3,100,"house%d",Houseid);
	d = 0;
	GetPlayerName(playerid,str2,256);
	Loadpropertt(str3,"Tenent1",str1);
	////printf("%d",d);
	if (strcmp(str1,"none")==0){
		d = 1;
		////printf("%d",d);
		Savepropertt(str3,"Tenent1",str2);
	}
	Loadpropertt(str3,"Tenent2",str1);
	if (strcmp(str1,"none")==0 && d == 0){
		d = 1;////printf("%d",d);
		Savepropertt(str3,"Tenent2",str2);
	}
	Loadpropertt(str3,"Tenent3",str1);
	if (strcmp(str1,"none")==0 && d == 0){
		d = 1;////printf("%d",d);
		Savepropertt(str3,"Tenent3",str2);
	}
	Loadpropertt(str3,"Tenent4",str1);
	if (strcmp(str1,"none")==0 && d == 0){
		d = 1;////printf("%d",d);
		Savepropertt(str3,"Tenent4",str2);
	}
	Loadpropertt(str3,"Tenent5",str1);
	if (strcmp(str1,"none")==0 && d == 0){
		d = 1;////printf("%d",d);
		Savepropertt(str3,"Tenent5",str2);
	}
	if (d == 0){
		////printf("%d",d);
		GameTextForPlayer(playerid,"~r~There are no empty rooms AVAILABLE",5000,1);
	}
	else{
		format(str3,100,"house%d",Houseid);
		Loadpropertt(str3,"Rent",str2);
		new hcost = strval(str2);
		GivePlayerMoney(playerid,-hcost);
		GivePlayerMoney(playerid,-hcost);
		GameTextForPlayer(playerid,"~g~Congrats for you new house.",5000,1);
	}
}
SetPlayerInHouse(playerid,Houseid){
	PIH1[playerid] = Houseid;
	SetPlayerPos(playerid,HIX1[Houseid],HIY1[Houseid],HIZ1[Houseid]);
	SetPlayerInterior(playerid,HII1[Houseid]);
	ShowMenuForPlayer(Hexit1,playerid);
}

SetHouseInfo(Houseid,info[],value[]){
	new str[100];
	format(str,100,"house%d",Houseid);
	Savepropertt(str,info,value);
}

GetHouseInfo(Houseid,info[],value[]){
	new str[100];
	new ret;
	format(str,100,"house%d",Houseid);
	ret = Loadpropertt(str,info,value);
	return ret;
}

SetPlayerOutHouse(playerid,Houseid){
	PIH1[playerid] = 0;
	SetPlayerPos(playerid,HOX1[Houseid],HOY1[Houseid],HOZ1[Houseid]);
	SetPlayerInterior(playerid,0);
}

IsPlayerAllowedInHouse(playerid,Houseid){
	new str1[256],str2[256];
	GetPlayerName(playerid,str2,256);
	GetHouseInfo(Houseid,"Owner",str1);
	if (strcmp(str1,str2)==0){
		return 1;
	}
	GetHouseInfo(Houseid,"Tenent1",str1);
	if (strcmp(str1,str2)==0){
		return 1;
	}
	GetHouseInfo(Houseid,"Tenent2",str1);
	if (strcmp(str1,str2)==0){
		return 1;
	}
	GetHouseInfo(Houseid,"Tenent3",str1);
	if (strcmp(str1,str2)==0){
		return 1;
	}
	GetHouseInfo(Houseid,"Tenent4",str1);
	if (strcmp(str1,str2)==0){
		return 1;
	}
	GetHouseInfo(Houseid,"Tenent5",str1);
	if (strcmp(str1,str2)==0){
		return 1;
	}
	else{
		return 0;
	}
}

AddStaticHouse(Float:x,Float:y,Float:z,Float:ix,Float:iy,Float:iz,ii){
	//print("addstaticHouse");
	hidd++;
	HP1[CreatePickup(1273,2,x,y,z)] = hidd;
	HIX1[hidd] = ix;
	HIY1[hidd] = iy;
	HIZ1[hidd] = iz;
	HII1[hidd] = ii;
	HOX1[hidd] = x;
	HOY1[hidd] = y;
	HOZ1[hidd] = z;
	new str[256];
	format(str,256,"house%d.zip",hidd);
	if (!fexist(str)){
		new File:House = fopen(str,io_write);
		fclose(House);
		SetHouseInfo(hidd,"Owner","none");
		SetHouseInfo(hidd,"Rent","0");
		SetHouseInfo(hidd,"Cost","50000");
		SetHouseInfo(hidd,"Tenent1","none");
		SetHouseInfo(hidd,"Tenent2","none");
		SetHouseInfo(hidd,"Tenent3","none");
		SetHouseInfo(hidd,"Tenent4","none");
		SetHouseInfo(hidd,"Tenent5","none");
	}
	return hidd;
}

OnPlayerEnterHousee(playerid,Houseid)
{
	ShowMenuForPlayer(Hmen1,playerid);
	HDD[playerid] = Houseid;
}
//=================================Save Stuff===================================
public SaveComponent(streamid,componentid)
{
	new playerid = GetDriverID(VehicleInfo[streamid][idnum]);
	if (strcmp(VehicleInfo[streamid][owner],PlayerInfo[playerid][name],false) == 0) {
		for(new s=0; s<20; s++) {
   			if(componentid == spoiler[s][0]) {
      			VehicleInfo[streamid][mod1] = componentid;
          	}
		}
		for(new s=0; s<3; s++) {
     		if(componentid == nitro[s][0]) {
       			VehicleInfo[streamid][mod2] = componentid;
   	     	}
		}
		for(new s=0; s<23; s++) {
    		if(componentid == fbumper[s][0]) {
       			VehicleInfo[streamid][mod3] = componentid;
    		}
		}
		for(new s=0; s<22; s++) {
     		if(componentid == rbumper[s][0]) {
       			VehicleInfo[streamid][mod4] = componentid;
   	    	}
		}
		for(new s=0; s<28; s++) {
     		if(componentid == exhaust[s][0]) {
       			VehicleInfo[streamid][mod5] = componentid;
     		}
		}
		for(new s=0; s<2; s++) {
     		if(componentid == bventr[s][0]) {
       			VehicleInfo[streamid][mod6] = componentid;
     		}
		}
		for(new s=0; s<2; s++) {
     		if(componentid == bventl[s][0]) {
   				VehicleInfo[streamid][mod7] = componentid;
     		}
		}
		for(new s=0; s<4; s++) {
			if(componentid == bscoop[s][0]) {
       			VehicleInfo[streamid][mod8] = componentid;
 			}
		}
		for(new s=0; s<13; s++) {
     		if(componentid == rscoop[s][0]) {
       			VehicleInfo[streamid][mod9] = componentid;
     		}
		}
		for(new s=0; s<21; s++) {
			if(componentid == lskirt[s][0]) {
       			VehicleInfo[streamid][mod10] = componentid;
 			}
		}
		for(new s=0; s<21; s++) {
     		if(componentid == rskirt[s][0]) {
       			VehicleInfo[streamid][mod11] = componentid;
	       	}
		}
		for(new s=0; s<1; s++) {
     		if(componentid == hydraulics[s][0]) {
       			VehicleInfo[streamid][mod12] = componentid;
     		}
		}
		for(new s=0; s<1; s++) {
     		if(componentid == base[s][0]) {
       			VehicleInfo[streamid][mod13] = componentid;
   	       	}
		}
		for(new s=0; s<2; s++) {
     		if(componentid == rbbars[s][0]) {
       			VehicleInfo[streamid][mod14] = componentid;
     		}
		}
		for(new s=0; s<2; s++) {
     		if(componentid == fbbars[s][0]) {
       			VehicleInfo[streamid][mod15] = componentid;
     		}
		}
		for(new s=0; s<17; s++) {
		if(componentid == wheels[s][0]) {
       			VehicleInfo[streamid][mod16] = componentid;
   	       	}
		}
		for(new s=0; s<2; s++) {
			if(componentid == lights[s][0]) {
       			VehicleInfo[streamid][mod17] = componentid;
 			}
		}
		SaveVehicles();
		return 1;
	}
	return 0;
}

stock SavePaintjob(streamid,paintjobid)
{
    new playerid = GetDriverID(VehicleInfo[streamid][idnum]);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
		if (strcmp(VehicleInfo[streamid][owner],PlayerInfo[playerid][name],false) == 0) {
			VehicleInfo[streamid][paintjob] = paintjobid;
			return 1;
		}
	}
	SaveVehicles();
	return 0;
}

stock SaveColors(streamid,color1,color2)
{
    new playerid = GetDriverID(VehicleInfo[streamid][idnum]);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
		if (strcmp(VehicleInfo[streamid][owner],PlayerInfo[playerid][name],false) == 0) {
			VehicleInfo[streamid][color_1] = color1;
   			VehicleInfo[streamid][color_2] = color2;
			return 1;
		}
	}
	return 0;
}
//================================Get Driver Id=================================
stock GetDriverID(vehicleid)
{
    for(new i=0; i<MAX_PLAYERS; i++) {
        if(IsPlayerConnected(i)) {
            if(IsPlayerInAnyVehicle(i)) {
                if(GetPlayerVehicleID(i) == vehicleid && GetPlayerState(i) == PLAYER_STATE_DRIVER) {
					return i;
                }
            }
        }
    }
    return -1;
}
//==============================Is Player in Area===============================
public isPlayerInArea(playerID, Float:data[4])
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerID, X, Y, Z);
	if(X >= data[0] && X <= data[2] && Y >= data[1] && Y <= data[3]) {
		return 1;
	}
	return 0;
}
//=============================Gamemode Exit Stuff==============================
public GameModeExitFunc()
{
	GameModeExit();
	return 1;
}
//=================================Team Chat====================================
public GetPlayers() //By rapidZ
{
	new i;
	new player;
	player = 0;
	for (i=0;i<MAX_PLAYERS;i++){
		if(IsPlayerConnected(i)){
			player++;
		}
	}
	return player;
}
//=========================Tram/RC Entering by !damo!===========================
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == KEY_SECONDARY_ATTACK ){
		if(!IsPlayerInAnyVehicle(playerid)){
			new Float:x, Float:y, Float:z, vehicle;
			GetPlayerPos(playerid, x, y, z );
			GetVehicleWithinDistance(playerid, x, y, z, 20.0, vehicle);
			if(IsVehicleRcTram(vehicle)){
			    PutPlayerInVehicle(playerid, vehicle, 0);
			}
		}

		else {
			new vehicleID = GetPlayerVehicleID(playerid);
			if(IsVehicleRcTram(vehicleID) || GetVehicleModel(vehicleID) == 594){
			    if(GetVehicleModel(vehicleID) != 449){
			    	new Float:x, Float:y, Float:z;
			   	 	GetPlayerPos(playerid, x, y, z);
		    		SetPlayerPos(playerid, x+0.5, y, z+1.0);
				}
			}
		}
	}
}

GetVehicleWithinDistance( playerid, Float:x1, Float:y1, Float:z1, Float:dist, &veh){
	for(new i = 1; i < MAX_VEHICLES; i++){
		if(GetVehicleModel(i) > 0){
			if(GetPlayerVehicleID(playerid) != i ){
	        	new Float:x, Float:y, Float:z;
	        	new Float:x2, Float:y2, Float:z2;
				GetVehiclePos(i, x, y, z);
				x2 = x1 - x; y2 = y1 - y; z2 = z1 - z;
				new Float:vDist = (x2*x2+y2*y2+z2*z2);
				if( vDist < dist){
					veh = i;
					dist = vDist;
				}
			}
		}
	}
}

IsVehicleRcTram( vehicleid )
{
   	switch(GetVehicleModel(vehicleid))
	{
		case 449, 501, 464, 441, 465, 564: return 1;
		default: return 0;
	}
	return 0;
}
//==================================Menu Selection==============================
public OnPlayerSelectedMenuRow(playerid, row)
{
	new Menu:Current = GetPlayerMenu(playerid);
	if(Current == MAdmin)
	{
		if(row <=4 && RaceActive == 1)
		{
		    SendClientMessage(playerid,COLOR_RED,"Race active, cannot change this setting!");
			ShowMenuForPlayer(MAdmin,playerid);
		    return 1;
		}
		if(row == 0) ShowMenuForPlayer(MPMode,playerid);
		else if (row == 1) ShowMenuForPlayer(MPrize,playerid);
		else if (row == 2) ShowMenuForPlayer(MDyna,playerid);
		else if (row == 3) ShowMenuForPlayer(MFee,playerid);
		else if (row == 4) ShowMenuForPlayer(MDelay,playerid);
		else if (row == 5)
		{
		    if(RaceActive == 1) endrace();
		    else SendClientMessage(playerid,COLOR_YELLOW,"No race active!");
		    ShowMenuForPlayer(MAdmin,playerid);
		}
		else if (row == 9)
		{
			TogglePlayerControllable(playerid,1);
			HideMenuForPlayer(MAdmin,playerid);
		}
		else
		{
			if(row == 6 && RaceAdmin == 1) RaceAdmin=0;
			else if(row == 6 && RaceAdmin == 0) RaceAdmin=1;
			else if(row == 7 && BuildAdmin == 1) BuildAdmin=0;
			else if(row == 7 && BuildAdmin == 0) BuildAdmin=1;
			else if(row == 8 && RRotation >= 0) RRotation = -1;
			else RRotation = 0;
			if(RaceAdmin == 1) format(ystring,sizeof(ystring),"RA: ON");
			else format(ystring,sizeof(ystring),"RA: off");
			if(BuildAdmin == 1) format(ystring,sizeof(ystring),"%s BA: ON",ystring);
			else format(ystring,sizeof(ystring),"%s BA: off",ystring);
			if(RRotation >= 0) format(ystring,sizeof(ystring),"%s RR: ON",ystring);
			else format(ystring,sizeof(ystring),"%s RR: off",ystring);
			if(RRotation >= 0 && row == 8)  RotationTimer = SetTimer("RaceRotation",RRotationDelay,1);
			else if(RRotation -1 && row == 8) KillTimer(RotationTimer);
			RefreshMenuHeader(playerid,MAdmin,ystring);
		}
	}
	else if(Current == MPMode)
	{
		if(row == 5)
		{
			 ShowMenuForPlayer(MAdmin,playerid);
			 return 1;
		}
		PrizeMode = row;
		if     (PrizeMode == 0) ystring = "Fixed";
		else if(PrizeMode == 1) ystring = "Dynamic";
		else if(PrizeMode == 2) ystring = "Join Fee";
		else if(PrizeMode == 3) ystring = "Join Fee + Fixed";
		else if(PrizeMode == 4) ystring = "Join Fee + Dynamic";
		format(ystring,sizeof(ystring),"Mode: %s",ystring);
		RefreshMenuHeader(playerid,MPMode,ystring);
	}
	else if(Current == MPrize)
	{
	    if(row == 6)
	    {
	        ShowMenuForPlayer(MAdmin,playerid);
	        return 1;
	    }
	    if     (row == 0) Prize += 100;
	    else if(row == 1) Prize += 1000;
	    else if(row == 2) Prize += 10000;
	    else if(row == 3) Prize -= 100;
	    else if(row == 4) Prize -= 1000;
	    else if(row == 5) Prize -= 10000;
	    if(Prize < 0) Prize = 0;
		format(ystring,sizeof(ystring),"Amount: %d",Prize);
		RefreshMenuHeader(playerid,MPrize,ystring);
	}
	else if(Current == MDyna)
	{
		if(row == 4)
		{
		    ShowMenuForPlayer(MAdmin,playerid);
		    return 1;
		}
		if     (row == 0) DynaMP++;
		else if(row == 1) DynaMP+=5;
		else if(row == 2) DynaMP--;
		else if(row == 3) DynaMP-=5;
		else if(DynaMP < 1) DynaMP = 1;
		format(ystring,sizeof(ystring),"Multiplier: %dx",DynaMP);
		RefreshMenuHeader(playerid,MDyna,ystring);
	}
	else if(Current == MBuild)
	{

	    if (row == 0)
		{
			format(ystring,sizeof(ystring),"Laps: %d",Blaps[b(playerid)]);
			SetMenuColumnHeader(MLaps,0,ystring);
			ShowMenuForPlayer(MLaps,playerid);
		}
	    else if (row == 1)
		{
			format(ystring,sizeof(ystring),"Mode: %s",ReturnModeName(Bracemode[b(playerid)]));
			SetMenuColumnHeader(MRacemode,0,ystring);
			ShowMenuForPlayer(MRacemode,playerid);
		}
		else if (row == 2)
		{
		    format(ystring,sizeof(ystring),"Size: %0.2f",BCPsize[b(playerid)]);
		    SetMenuColumnHeader(MCPsize,0,ystring);
		    ShowMenuForPlayer(MCPsize,playerid);
		}
	    else if (row == 3)
	    {
	        if(BAirrace[b(playerid)] == 0)
			{
				BAirrace[b(playerid)] = 1;
				format(ystring,sizeof(ystring),"Air race: ON");
			}
   	        else if(BAirrace[b(playerid)] == 1)
			{
				BAirrace[b(playerid)] = 0;
				format(ystring,sizeof(ystring),"Air race: off");
			}
   	        RefreshMenuHeader(playerid,MBuild,ystring);
	    }
	    else if(row == 4)
	    {
	        clearrace(playerid);
	        HideMenuForPlayer(MBuild,playerid);
	        TogglePlayerControllable(playerid,1);
			return 1;
	    }
	    else if(row == 5)
	    {
	        HideMenuForPlayer(MBuild,playerid);
			TogglePlayerControllable(playerid,1);
	    }
	}
	else if(Current == MLaps)
	{

	    if(row == 6)
	    {
	        if(RaceBuilders[playerid] != 0) ShowMenuForPlayer(MBuild,playerid);
	        else ShowMenuForPlayer(MRace,playerid);
	        return 1;
		}
		new change=0;
	    if     (row == 0) change++;
		else if(row == 1) change+=5;
		else if(row == 2) change+=10;
		else if(row == 3) change--;
		else if(row == 4) change-=5;
		else if(row == 5) change-=10;
		if(RaceBuilders[playerid] != 0)
		{
		    Blaps[b(playerid)] += change;
			if(Blaps[b(playerid)] < 1) Blaps[b(playerid)] = 1;
			format(ystring,sizeof(ystring),"Laps: %d",Blaps[b(playerid)]);
			RefreshMenuHeader(playerid,MLaps,ystring);
		}
		else
		{
			Racelaps += change;
			if(Racelaps < 1) Racelaps = 1;
			format(ystring,sizeof(ystring),"Laps: %d",Racelaps);
			RefreshMenuHeader(playerid,MLaps,ystring);
		}

	}
	else if(Current == MRacemode)
	{
		if(row == 4)
		{
		    if(RaceBuilders[playerid] != 0) ShowMenuForPlayer(MBuild,playerid);
		    else ShowMenuForPlayer(MRace,playerid);
		    return 1;
		}
		if(RaceBuilders[playerid] != 0)
		{
		    Bracemode[b(playerid)]=row;
			if(Bracemode[b(playerid)] == 2 && BCurrentCheckpoints[b(playerid)] < 3)
			{
				SendClientMessage(playerid,COLOR_YELLOW,"Cannot set racemode 2 with only 2 CPs!");
				Bracemode[b(playerid)] = 1;
			}
			format(ystring,sizeof(ystring),"Mode: %s",ReturnModeName(Bracemode[b(playerid)]));
			RefreshMenuHeader(playerid,MRacemode,ystring);
			return 1;
		}
		else
		{
		    Racemode = row;
			if(Racemode == 2 && LCurrentCheckpoint < 2)
			{
				SendClientMessage(playerid,COLOR_YELLOW,"Cannot set racemode 2 with only 2 CPs!");
				Racemode = 1;
			}
			format(ystring,sizeof(ystring),"Mode: %s",ReturnModeName(Racemode));
			RefreshMenuHeader(playerid,MRacemode,ystring);
			return 1;
		}
	}
	else if(Current == MRace)
	{
	    if(row == 0)
		{
			format(ystring,sizeof(ystring),"Laps: %d",Racelaps);
			SetMenuColumnHeader(MLaps,0,ystring);
			ShowMenuForPlayer(MLaps,playerid);
		}
	    else if(row == 1)
		{
			format(ystring,sizeof(ystring),"Mode: %s",ReturnModeName(Racemode));
			SetMenuColumnHeader(MRacemode,0,ystring);
            ShowMenuForPlayer(MRacemode,playerid);
		}
		else if(row == 2)
		{
		    format(ystring,sizeof(ystring),"Size: %0.2f",CPsize);
		    SetMenuColumnHeader(MCPsize,0,ystring);
		    ShowMenuForPlayer(MCPsize,playerid);
		}
	    else if(row == 3)
	    {
	        if(Airrace == 0)
			{
				Airrace = 1;
				format(ystring,sizeof(ystring),"Air race: ON");
			}
			else if(Airrace == 1)
			{
				Airrace = 0;
				format(ystring,sizeof(ystring),"Air race: off");
			}
			RefreshMenuHeader(playerid,MRace,ystring);
	    }
		else if(row == 4)
		{
			if(RaceActive == 0)
			{
				startrace();
		        HideMenuForPlayer(MRace,playerid);
				TogglePlayerControllable(playerid,1);
			}
			else
			{
			    SendClientMessage(playerid,COLOR_YELLOW,"Race is already active!");

			}
		}
		else if(row == 5)
		{
	        HideMenuForPlayer(MRace,playerid);
			TogglePlayerControllable(playerid,1);
		}
	}
	else if(Current == MFee)
	{
	    if(row == 6)
	    {
	        ShowMenuForPlayer(MAdmin,playerid);
	        return 1;
	    }
	    if(row == 0) JoinFee +=100;
	    if(row == 1) JoinFee +=1000;
	    if(row == 2) JoinFee +=10000;
	    if(row == 3) JoinFee -=100;
	    if(row == 4) JoinFee -=1000;
	    if(row == 5) JoinFee -=10000;
	    if(JoinFee < 0) JoinFee = 0;
		format(ystring,sizeof(ystring),"Fee: %d$",JoinFee);
	    RefreshMenuHeader(playerid,MFee,ystring);
	}
	else if(Current == MCPsize)
	{
	    if(row == 6)
	    {
			if(RaceBuilders[playerid] != 0) ShowMenuForPlayer(MBuild,playerid);
			else ShowMenuForPlayer(MRace,playerid);
	        return 1;
	    }
		new Float:change;
	    if(row == 0) change +=0.1;
	    if(row == 1) change +=1.0;
	    if(row == 2) change +=10.0;
		if(row == 3) change -=0.1;
		if(row == 4) change -=1.0;
		if(row == 5) change -=10.0;
		if(RaceBuilders[playerid] != 0)
		{
		    BCPsize[b(playerid)] += change;
			if(BCPsize[b(playerid)] < 1.0) BCPsize[b(playerid)] = 1.0;
			if(BCPsize[b(playerid)] > 32.0) BCPsize[b(playerid)] = 32.0;
			format(ystring,sizeof(ystring),"Size %0.2f",BCPsize[b(playerid)]);
			RefreshMenuHeader(playerid,MCPsize,ystring);
		}
		else
		{
		    CPsize += change;
		    if(CPsize < 1.0) CPsize = 1.0;
		    if(CPsize > 32.0) CPsize = 32.0;
		    format(ystring,sizeof(ystring),"Size %0.2f",CPsize);
		    RefreshMenuHeader(playerid,MCPsize,ystring);
		}
	}
	else if(Current == MDelay)
	{
	    if(row == 4)
	    {
	        ShowMenuForPlayer(MAdmin,playerid);
	        return 1;
	    }
		if      (row == 0) MajorityDelay+=10;
		else if (row == 1) MajorityDelay+=60;
		else if (row == 2) MajorityDelay-=10;
		else if (row == 3) MajorityDelay-=60;
		if(MajorityDelay <= 0)
		{
			MajorityDelay=0;
			format(ystring,sizeof(ystring),"Delay: disabled");
		}
		else format(ystring,sizeof(ystring),"Delay: %ds",MajorityDelay);
		RefreshMenuHeader(playerid,MDelay,ystring);
	}
	if(GetPlayerMenu(playerid) == TK)
	{
	 	switch(row)
		{
		  	case 0:
			{
				SendClientMessage(playerid, COLOR_YELLOW, "You Have Killed your TeamKiller!");
				SendClientMessage(KillerID[playerid], COLOR_YELLOW, "You have Been Killed By The person you TeamKilled!");
			 	SetPlayerHealth(KillerID[playerid],0);
			    KillerID[playerid] = INVALID_PLAYER_ID;
			}
		  	case 1:
			{
				SendClientMessage(playerid, COLOR_YELLOW, "You Have Exploded Your TeamKiller!");
			    SendClientMessage(KillerID[playerid], COLOR_YELLOW, "You have Been Exploded By The person you TeamKilled!");
				new Float:KX,Float:KY,Float:KZ;
				GetPlayerPos(KillerID[playerid], KX, KY, KZ);
				CreateExplosion(KX, KY, KZ, 1, 1);
			    KillerID[playerid] = INVALID_PLAYER_ID;
			}
			case 2:
			{
				SendClientMessage(playerid, COLOR_YELLOW, "You have Taken $2500 From your TeamKiller!");
			    SendClientMessage(KillerID[playerid], COLOR_YELLOW, "You have had $2500 Stolen By The person you TeamKilled!");
				GivePlayerMoney(KillerID[playerid], GetPlayerMoney(KillerID[playerid]) -2500);
			    GivePlayerMoney(playerid, GetPlayerMoney(playerid) +2500);
				KillerID[playerid] = INVALID_PLAYER_ID;
			}
			case 3:
			{
				SendClientMessage(playerid, COLOR_YELLOW, "You have Reseted Your TeamKillers weapons!");
			    SendClientMessage(KillerID[playerid], COLOR_YELLOW, "You have Had Your Weapons Reseted By The person you TeamKilled!");
				ResetPlayerWeapons(KillerID[playerid]);
				KillerID[playerid] = INVALID_PLAYER_ID;
			}
			case 4:
			{
				SendClientMessage(playerid, COLOR_YELLOW, "You have Forgiven your TeamKiller (You Softy :D)!");
			    SendClientMessage(KillerID[playerid], COLOR_YELLOW, "You have Been Forgiven By The person you TeamKilled!");
				KillerID[playerid] = INVALID_PLAYER_ID;
			}
		}
	}
	else if(Current == vehiclemain) {
    	switch(row){
        	case 0:ShowMenuForPlayer(playervm, playerid);
        	case 1:ShowMenuForPlayer(adminm, playerid);
        	case 2:{HideMenuForPlayer(Current, playerid);TogglePlayerControllable(playerid, true);}
		}
	}
	else if(Current == playervm) {
		switch(row){
			case 0:ShowMenuForPlayer(templock, playerid);
			case 1:ShowMenuForPlayer(healthbar, playerid);
			case 2:ShowMenuForPlayer(speedom, playerid);
			case 3:ShowMenuForPlayer(buysell, playerid);
			case 4:{callcar(playerid);HideMenuForPlayer(Current, playerid);TogglePlayerControllable(playerid, true);}
	        case 5:{HideMenuForPlayer(Current, playerid);park(playerid);TogglePlayerControllable(playerid, true);}
	        case 6:ShowMenuForPlayer(secure1, playerid);
	        case 7:ShowMenuForPlayer(vehiclemain, playerid);
		}
	}
	else if(Current == adminm) {
		switch(row){
		    case 0:{HideMenuForPlayer(Current, playerid);asellcar(playerid);TogglePlayerControllable(playerid, true);}
			case 1:ShowMenuForPlayer(buyable, playerid);
			case 2:ShowMenuForPlayer(asecure1, playerid);
			case 3:ShowMenuForPlayer(vehiclemain, playerid);
		}
	}
	else if(Current == templock) {
		switch(row){
		    case 0:{HideMenuForPlayer(Current, playerid);lock(playerid);TogglePlayerControllable(playerid, true);}
			case 1:{HideMenuForPlayer(Current, playerid);unlock(playerid);TogglePlayerControllable(playerid, true);}
	        case 2:ShowMenuForPlayer(playervm, playerid);
		}
	}
	else if(Current == speedom) {
	switch(row){
		    case 0:{ShowMenuForPlayer(Current, playerid);dashboardon(playerid);}
	        case 1:{ShowMenuForPlayer(Current, playerid);dashboardoff(playerid);}
	        case 2:ShowMenuForPlayer(playervm, playerid);
      	}
	}
	else if(Current == buysell) {
		switch(row){
	    	case 0:{ShowMenuForPlayer(Current, playerid);buycar(playerid);}
	        case 1:{ShowMenuForPlayer(Current, playerid);sellcar(playerid);}
	        case 2:ShowMenuForPlayer(playervm, playerid);
		}
	}
	else if(Current == secure1) {
		switch(row){
		    case 0:ShowMenuForPlayer(secure2, playerid);
		    case 1:{HideMenuForPlayer(Current, playerid);unsecure(playerid);TogglePlayerControllable(playerid, true);}
		    case 2:ShowMenuForPlayer(playervm, playerid);
	    }
	}
	else if(Current == secure2) {
		switch(row){
		    case 0:{HideMenuForPlayer(Current, playerid);securekill(playerid);TogglePlayerControllable(playerid, true);}
		    case 1:{HideMenuForPlayer(Current, playerid);securekick(playerid);TogglePlayerControllable(playerid, true);}
		    case 2:ShowMenuForPlayer(secure1, playerid);
		}
	}
	else if(Current == buyable) {
		switch(row){
		    case 0:{HideMenuForPlayer(Current, playerid);setbuy(playerid);TogglePlayerControllable(playerid, true);}
			case 1:{HideMenuForPlayer(Current, playerid);setunbuy(playerid);TogglePlayerControllable(playerid, true);}
		    case 2:ShowMenuForPlayer(adminm, playerid);
	    }
	}
	else if(Current == asecure1) {
		switch(row){
		    case 0:ShowMenuForPlayer(asecure2, playerid);
		    case 1:{HideMenuForPlayer(Current, playerid);aunsecure(playerid);TogglePlayerControllable(playerid, true);}
		    case 2:ShowMenuForPlayer(adminm, playerid);
	    }
	}
	else if(Current == asecure2) {
		switch(row){
		    case 0:{HideMenuForPlayer(Current, playerid);asecurekill(playerid);TogglePlayerControllable(playerid, true);}
		    case 1:{HideMenuForPlayer(Current, playerid);asecurekick(playerid);TogglePlayerControllable(playerid, true);}
		    case 2:ShowMenuForPlayer(asecure1, playerid);
	    }
	}
	else if(Current == healthbar) {
		switch(row){
		    case 0:{ShowMenuForPlayer(Current, playerid);PlayerInfo[playerid][vhpb] = 1;SendClientMessage(playerid,COLOR_GREEN,"Vehicle HP Bar is now active!");}
		    case 1:{ShowMenuForPlayer(Current, playerid);PlayerInfo[playerid][vhpb] = 0;SendClientMessage(playerid,COLOR_BRIGHTRED,"Vehicle HP Bar is now in-active!");}
		    case 2:ShowMenuForPlayer(playervm, playerid);
		}
	}
	//print("onplayerselectedmenu");
	CallLocalFunction("opsm","ii",playerid,row);
	new Menu:Cur = GetPlayerMenu(playerid);
	if (Cur == Hmen1){
		////print("Hmen1 Select");
		switch(row){
			case 0:{
				//print("House Menu Case 0");
				new str1[150],str2[150],str3[150],hstring[150];
				GetHouseInfo(HDD[playerid],"Owner",str1);
				GetHouseInfo(HDD[playerid],"Rent",str2);
				GetHouseInfo(HDD[playerid],"Cost",str3);
				format(hstring,255,"Owner: %s~n~Rent: %s~n~Cost: %s",str1,str2,str3);
				GameTextForPlayer(playerid,hstring,5000,5);
			}
			case 1:{
				new str1[256];
				//print("House Menu Case 1");
				GetHouseInfo(HDD[playerid],"Lock",str1);
				if (strcmp(str1,"no")==0){
					SetPlayerInHouse(playerid,HDD[playerid]);
				}
				else if (IsPlayerAllowedInHouse(playerid,HDD[playerid])==1){
					SetPlayerInHouse(playerid,HDD[playerid]);
				}
				else {
					GameTextForPlayer(playerid,"~r~house is LOCKED",5000,1);
				}
			}
			case 2:{
				new str2[256];
				GetHouseInfo(HDD[playerid],"Rent",str2);
				new hcost = strval(str2);
				new str1[256];
				GetHouseInfo(HDD[playerid],"Owner",str1);
				if (strcmp(str1,"none")==0){
					GameTextForPlayer(playerid,"~r~house has no OWNER",5000,1);
				}
				else {
					if (GetPlayerMoney(playerid) >= hcost){
						CallLocalFunction("OnPlayerRentHouse","ii",playerid,HDD[playerid]);
						MakeTenent1(playerid,HDD[playerid]);
					}
					else{
						GameTextForPlayer(playerid,"~r~You dont have enough MONEY",5000,1);
					}
				}
			}
			case 3:{
				new str1[256];
				new str2[256];
				new str3[100];
				format(str3,100,"house%d",HDD[playerid]);
				new hname[256];
				Loadpropertt(str3,"Cost",str2);
				new hcost = strval(str2);
				GetPlayerName(playerid,hname,255);
				Loadpropertt(str3,"Owner",str1);
				if (strcmp(str1,"none")==0){
					if (GetPlayerMoney(playerid) >= hcost){
						GivePlayerMoney(playerid,-hcost);
						Savepropertt(str3,"Owner",hname);
						GameTextForPlayer(playerid,"~g~Congrats for your new house.",5000,5);
					}
					else{
						GameTextForPlayer(playerid,"~r~You dont have enough MONEY",5000,5);
					}
				}
				else{
					GameTextForPlayer(playerid,"~r~This house is not FOR SALE",5000,5);
				}
			}
		}
	}
	else if (Cur == Hexit1){
		SetPlayerOutHouse(playerid,PIH1[playerid]);
	}
	if(Current == GiveCar) {
		new Component[20],id,carid;
	    switch(row) {
	      case 0: Component = "Nitrous x10", id = 1010;
	      case 1: Component = "Hydraulics", id = 1087;
	      case 2: Component = "Offroad Wheels", id = 1025;
	      case 3: Component = "Wire Wheels", id = 1081;
	    }
	    SendCommandMessageToAdmins(playerid,"GIVECAR");
	    new string[256]; format(string,sizeof(string),"You have selected \'%s\'.",Component); SendClientMessage(playerid,yellow,string);
        TogglePlayerControllable(playerid,true);
		carid = GetPlayerVehicleID(playerid); AddVehicleComponent(carid,id);
	}
	if(Current == Weather) {
	    new id, Part[20];
	    switch(row) {
	      case 0: Part = "Sunny", id = 15;
	      case 1: Part = "Cloudy", id = 7;
	      case 2: Part = "Thunderstorm", id = 16;
	      case 3: Part = "Foggy", id = 9;
	      case 4: Part = "Scorching Hot", id = 17;
	      case 5: Part = "Sandstorm", id = 19;
	      case 6: Part = "Polluted", id = 35;
	    }
	    if(id == ServerWeather) return SendClientMessage(playerid,red,"ERROR: The server weather is already the one you have selected.");
	    SendCommandMessageToAdmins(playerid,"WEATHER");
	    new string[256],xname[24]; GetPlayerName(playerid,xname,24); format(string,256,"Administrator \"%s\" has changed the weather to \'%s\'.",xname,Part); SendClientMessageToAll(yellow,string);
        TogglePlayerControllable(playerid,true); ServerWeather = id, SetWeather(id);
	}
	return 1;
}
//==============================Gamemode exit stuff=============================
public OnGameModeExit()
{
    DestroyMenu(vehiclemain);
    DestroyMenu(playervm);
    DestroyMenu(buysell);
    DestroyMenu(secure1);
    DestroyMenu(secure2);
    DestroyMenu(templock);
    DestroyMenu(adminm);
    DestroyMenu(asecure1);
    DestroyMenu(asecure2);
    DestroyMenu(speedom);
    DestroyMenu(buyable);
    DestroyMenu(GiveCar);
    DestroyMenu(Weather);
//-----------------------------Unload Race Scrpt--------------------------------
	print("\n+--------------------------+");
	print("| Yagu's Race script v0.4a |");
	print("+---------UNLOADED---------+\n");
	#if defined MENUSYSTEM
	DestroyMenu(MAdmin);
	DestroyMenu(MPMode);
	DestroyMenu(MPrize);
	DestroyMenu(MDyna);
	DestroyMenu(MBuild);
	DestroyMenu(MLaps);
	DestroyMenu(MRace);
	DestroyMenu(MRacemode);
	DestroyMenu(MFee);
	DestroyMenu(MCPsize);
	DestroyMenu(MDelay);
	#endif
	return 1;
}
//=================================Backup Info==================================
public BackupInfo()
{
	SaveVehicles();
	SaveBusinesses();
	for(new i=0;i<MAX_PLAYERS;i++) {
	if(PlayerInfo[i][logged] == 1) {
	SavePlayer(i);
	}
	}
}
//===============================Vehicle Stocks=================================
stock buycar(playerid)
{
	new string[256];
	new streamid = GetPlayerVehicleStreamID(playerid);
	if(PlayerInfo[playerid][logged] == 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this feature");
		return 1;
	}
	if(PlayerInfo[playerid][jailed] == 1) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You are in jail and cannot use this feature");
		return 1;
	}
  	if(passenger[playerid] == 1) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers' seat of this vehicle to buy it!");
		return 1;
	}
	if(IsPlayerInAnyVehicle(playerid) == 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle in order to buy one!");
		return 1;
	}
	if(VehicleInfo[streamid][buybar] == 1) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is currently set as un-buyable!");
		return 1;
	}
	if (strcmp(VehicleInfo[streamid][owner],PlayerInfo[playerid][name],false) == 0) {
		format(string, sizeof(string), "You already own this %s, %s", VehicleInfo[streamid][name], PlayerInfo[playerid][name]);
		SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		return 1;
	}
	if(VehicleInfo[streamid][bought] == 1) {
		format(string, sizeof(string), "This %s is owned by %s, and is not for sale!", VehicleInfo[streamid][name], VehicleInfo[streamid][owner]);
		SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		return 1;
	}
	if(PlayerInfo[playerid][vowner] == 1) {
  		SendClientMessage(playerid, COLOR_BRIGHTRED, "You can only own ONE vehicle at a time! You must sell your other vehicle first!");
	 	return 1;
	}
	new cash[MAX_PLAYERS];
	cash[playerid] = GetPlayerMoney(playerid);
	if(cash[playerid] >= VehicleInfo[streamid][vehiclecost]) {
		new stringa[256];
		strmid(VehicleInfo[streamid][owner], PlayerInfo[playerid][name], 0, strlen(PlayerInfo[playerid][name]), 255);
		VehicleInfo[streamid][bought] = 1;
		PlayerInfo[playerid][vowner] = 1;
		PlayerInfo[playerid][vowned] = streamid;
		GivePlayerMoney(playerid, -VehicleInfo[streamid][vehiclecost]);
		format(stringa, sizeof(stringa), "You just bought this %s for $%d.", VehicleInfo[streamid][name], VehicleInfo[streamid][vehiclecost],VehicleInfo[streamid][name]);
		SendClientMessage(playerid, COLOR_GREEN, stringa);
		SaveVehicles();
		SavePlayer(playerid);
		return 1;
	}
	if(cash[playerid] < VehicleInfo[streamid][vehiclecost]) {
		new string6[256];
		format(string6, sizeof(string6), "You do not have $%d and cannot afford this %s!", VehicleInfo[streamid][vehiclecost],VehicleInfo[streamid][name]);
		SendClientMessage(playerid, COLOR_BRIGHTRED, string6);
		return 1;
	}
	return 1;
}

stock sellcar(playerid)
{
	new string[256];
	if(PlayerInfo[playerid][logged] == 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this feature");
		return 1;
	}
	if(PlayerInfo[playerid][jailed] == 1) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You are in jail and cannot use this feature");
		return 1;
	}
	if(passenger[playerid] == 1) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers' seat of your vehicle to sell it!");
		return 1;
	}
	if(IsPlayerInAnyVehicle(playerid) == 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be inside your vehicle in order to sell it");
		return 1;
	}
  	new streamid = GetPlayerVehicleStreamID(playerid);
  	if (strcmp(VehicleInfo[streamid][owner],PlayerInfo[playerid][name],false) == 0) {
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	 	SetVehicleUsed(GetPlayerVehicleID(playerid),false);
		PlayerInfo[playerid][vowned] = 0;
		PlayerInfo[playerid][vowner] = 0;
		strmid(VehicleInfo[streamid][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
		VehicleInfo[streamid][bought] = 0;
		VehicleInfo[streamid][secure] = 0;
		GivePlayerMoney(playerid, VehicleInfo[streamid][vehiclecost]);
		format(string, sizeof(string), "You just sold your %s for $%d, enjoy the walk!!", VehicleInfo[streamid][name], VehicleInfo[streamid][vehiclecost]);
		SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		SavePlayer(playerid);
		SaveVehicles();
		return 1;
  	}
  	else {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "What are you trying to pull here, you don't own the vehicle!!!");
		return 1;
	}
}

stock asellcar(playerid)
{
	new string[256];
	new streamid = GetPlayerVehicleStreamID(playerid);
    if(PlayerInfo[playerid][logged] == 0) {
	    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this feature");
	    return 1;
	}
	if(passenger[playerid] == 1) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers seat to use this feature");
		return 1;
	}
	if(IsPlayerInAnyVehicle(playerid) == 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle in order to use this feature");
		return 1;
	}
	if (PlayerInfo[playerid][admin] > 4) {
		if (strcmp(VehicleInfo[streamid][owner],DEFAULT_OWNER,false) == 0) {
			format(string,sizeof(string),"This %d does not have an owner yet!",VehicleInfo[streamid][name]);
 			SendClientMessage(playerid,COLOR_ORANGE,string);
			return 1;
		}
		new file[256];
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	 	SetVehicleUsed(GetPlayerVehicleID(playerid),false);
		format(file,sizeof(file),P_FILE,udb_encode(VehicleInfo[streamid][owner]));
		if(fexist(file)) {
			tempid[playerid] = IsPlayerNameOnline(VehicleInfo[streamid][owner]);
			if(tempid[playerid] >= 0 && tempid[playerid] <= MAX_PLAYERS) {
		        strmid(VehicleInfo[streamid][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
				PlayerInfo[tempid[playerid]][vowned] = 0;
				PlayerInfo[tempid[playerid]][vowner] = 0;
				VehicleInfo[streamid][bought] = 0;
				VehicleInfo[streamid][secure] = 0;
				VehicleInfo[streamid][asecure] = 0;
				format(string, sizeof(string), "You just sold %s's %s.", PlayerInfo[tempid[playerid]][name], VehicleInfo[streamid][name]);
				SendClientMessage(playerid, COLOR_ORANGE, string);
				format(string, sizeof(string), "Admin (%s) has just sold your %s!", PlayerInfo[playerid][name], VehicleInfo[streamid][name]);
                SendClientMessage(tempid[playerid], COLOR_ORANGE, string);
				return 1;
			}
			else {
			    ResetOfflinePlayerFileV(VehicleInfo[streamid][owner]);
				format(string, sizeof(string), "You just sold %s's %s.", VehicleInfo[streamid][owner], VehicleInfo[streamid][name]);
				SendClientMessage(playerid, COLOR_ORANGE, string);
                VehicleInfo[streamid][bought] = 0;
                VehicleInfo[streamid][secure] = 0;
				VehicleInfo[streamid][asecure] = 0;
				strmid(VehicleInfo[streamid][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
				return 1;
			}
		}
		if(!fexist(file)) {
			format(string, sizeof(string), "You just sold %s's %s. The player file was not found and cannot be altered.", VehicleInfo[streamid][owner], VehicleInfo[streamid][name]);
			SendClientMessage(playerid, COLOR_GREEN, string);
            VehicleInfo[streamid][bought] = 0;
			strmid(VehicleInfo[streamid][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
			return 1;
		}
	}
	SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not a server administrator and cannot use this feature!");
	return 1;
}

stock setbuy(playerid)
{
	new string[256];
	if(PlayerInfo[playerid][logged] == 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this feature");
		return 1;
	}
	if(passenger[playerid] == 1) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers seat to use this feature");
		return 1;
	}
	if(IsPlayerInAnyVehicle(playerid) == 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle in order to use this feature");
		return 1;
	}
	if(VehicleInfo[GetPlayerVehicleStreamID(playerid)][buybar] == 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is already set as buyable!");
		return 1;
	}
   	if (PlayerInfo[playerid][admin] > 4) {
   		if(VehicleInfo[GetPlayerVehicleStreamID(playerid)][buybar] == 1) {
   			format(string,sizeof(string),"You have set this %s to buyable!", VehicleInfo[GetPlayerVehicleStreamID(playerid)][name]);
   			SendClientMessage(playerid,COLOR_ORANGE,string);
			VehicleInfo[GetPlayerVehicleStreamID(playerid)][buybar] = 0;
			return 1;
		}
	}
	SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not a server administrator and cannot use this feature!");
	return 1;
}

stock setunbuy(playerid)
{
	new string[256];
	new streamid = GetPlayerVehicleStreamID(playerid);
	if(PlayerInfo[playerid][logged] == 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this feature");
		return 1;
	}
	if(passenger[playerid] == 1) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers seat to use this feature");
		return 1;
	}
	if(IsPlayerInAnyVehicle(playerid) == 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle in order to use this feature");
		return 1;
	}
	if(VehicleInfo[streamid][buybar] == 1) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is already set as un-buyable!");
		return 1;
	}
   	if (PlayerInfo[playerid][admin] > 4) {
   		VehicleInfo[streamid][bought] = 0;
		VehicleInfo[streamid][secure] = 0;
		VehicleInfo[streamid][buybar] = 1;
		if (strcmp(VehicleInfo[streamid][owner],DEFAULT_OWNER,false) == 0) {
			strmid(VehicleInfo[streamid][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
			format(string,sizeof(string),"You have set this %s to non-buyable!",VehicleInfo[streamid][name]);
 			SendClientMessage(playerid,COLOR_ORANGE,string);
			return 1;
		}
		new file[256];
		format(file,sizeof(file),P_FILE,VehicleInfo[streamid][owner]);
		if(fexist(file)) {
			tempid[playerid] = IsPlayerNameOnline(VehicleInfo[streamid][owner]);
			if(tempid[playerid] >= 0 || tempid[playerid] <= MAX_PLAYERS) {
				strmid(VehicleInfo[streamid][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
				PlayerInfo[tempid[playerid]][vowned] = 0;
				PlayerInfo[tempid[playerid]][vowner] = 0;
				format(string, sizeof(string), "You just sold %s's %s and set it to non-buyable.", PlayerInfo[tempid[playerid]][name], VehicleInfo[streamid][name]);
				SendClientMessage(playerid, COLOR_ORANGE, string);
				format(string, sizeof(string), "Admin (%s) has just sold your %s and set it to non-buyable!", PlayerInfo[playerid][name], VehicleInfo[streamid][name]);
				SendClientMessage(tempid[playerid], COLOR_ORANGE, string);
				return 1;
			}
			else {
				ResetOfflinePlayerFileV(VehicleInfo[streamid][owner]);
				format(string, sizeof(string), "You just sold %s's %s and set it to non-buyable.", VehicleInfo[streamid][owner], VehicleInfo[streamid][name]);
				SendClientMessage(playerid, COLOR_ORANGE, string);
				strmid(VehicleInfo[streamid][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
				return 1;
			}
		}
		if(!fexist(file)) {
			format(string, sizeof(string), "You just sold %s's %s and set it to non-buyable. The player file was not found and cannot be altered.", VehicleInfo[streamid][owner], VehicleInfo[streamid][name]);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			strmid(VehicleInfo[streamid][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
			return 1;
		}
	}
	SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not a server administrator and cannot use this feature!");
	return 1;
}

stock lock(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new State=GetPlayerState(playerid);
		if(State!=PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid,COLOR_YELLOW,"You need to be in the drivers seat.");
			return 1;
		}
		new i;
		for(i=0;i<MAX_PLAYERS;i++)
		{
			if(i != playerid)
			{
				SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 1);
			}
		}
		format(lockmess,sizeof(lockmess),"Your %s is now locked.",VehicleInfo[GetPlayerVehicleStreamID(playerid)][name]);
		SendClientMessage(playerid,COLOR_GREEN, lockmess);
		new Float:pX, Float:pY, Float:pZ;
		GetPlayerPos(playerid,pX,pY,pZ);
		PlayerPlaySound(playerid,1056,pX,pY,pZ);
	}
	else
	{
		SendClientMessage(playerid, COLOR_YELLOW, "You are not in a vehicle.");
	}
	return 1;
}


stock unlock(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new State=GetPlayerState(playerid);
		if(State!=PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid,COLOR_YELLOW, "You need to be in the drivers seat.");
			return 1;
		}
		new i;
		for(i=0;i<MAX_PLAYERS;i++)
		{
			SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
		}
		format(lockmess,sizeof(lockmess),"Your %s is now unlocked.",VehicleInfo[GetPlayerVehicleStreamID(playerid)][name]);
		SendClientMessage(playerid,COLOR_GREEN, lockmess);
		new Float:pX, Float:pY, Float:pZ;
		GetPlayerPos(playerid,pX,pY,pZ);
		PlayerPlaySound(playerid,1057,pX,pY,pZ);
	}
	else
	{
		SendClientMessage(playerid, COLOR_YELLOW, "You are not in a vehicle.");
	}
	return 1;
}

stock securekick(playerid)
{
	if(PlayerInfo[playerid][logged] == 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this feature");
		return 1;
	}
	if(PlayerInfo[playerid][jailed] == 1) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You are in jail and cannot use this feature");
		return 1;
	}
  	if(VehicleInfo[GetPlayerVehicleStreamID(playerid)][buybar] == 1) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is un-buyable and these features will not work!");
		return 1;
	}
	if(PlayerInfo[playerid][vowner] == 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must first own a vehicle before you can use this feature!");
		return 1;
	}
	if(IsPlayerInAnyVehicle(playerid)) {
		if (strcmp(VehicleInfo[GetPlayerVehicleStreamID(playerid)][owner],PlayerInfo[playerid][name],false) == 0) {
			VehicleInfo[GetPlayerVehicleStreamID(playerid)][secure] = 1;
			format(securemess,sizeof(securemess),"You have set your %s as secure, no other player will be able to use it even when you are offline.", VehicleInfo[GetPlayerVehicleStreamID(playerid)][name]);
			SendClientMessage(playerid, COLOR_GREEN, securemess);
			return 1;
		}
		else {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not own this vehicle and cannot secure it!");
			return 1;
		}
	}
	else {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle to use this feature");
		return 1;
	}
}

stock asecurekick(playerid)
{

	if(PlayerInfo[playerid][logged] == 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this feature");
		return 1;
	}
	if (PlayerInfo[playerid][admin] > 4) {
		if(IsPlayerInAnyVehicle(playerid)) {
		VehicleInfo[GetPlayerVehicleStreamID(playerid)][asecure] = 1;
		format(securemess,sizeof(securemess),"You have set this %s as admin only.", VehicleInfo[GetPlayerVehicleStreamID(playerid)][name]);
		SendClientMessage(playerid, COLOR_GREEN, securemess);
		return 1;
	}
		else {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle to use this feature");
			return 1;
		}
	}
	else {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use this feature!");
		return 1;
	}
}

stock asecurekill(playerid)
{
	if(PlayerInfo[playerid][logged] == 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this feature");
		return 1;
	}
	if(IsPlayerInAnyVehicle(playerid)) {
		if (PlayerInfo[playerid][admin] > 4) {
			VehicleInfo[GetPlayerVehicleStreamID(playerid)][asecure] = 2;
			format(securemess,sizeof(securemess),"You have set this %s as admin only with lethal protection.", VehicleInfo[GetPlayerVehicleStreamID(playerid)][name]);
			SendClientMessage(playerid, COLOR_GREEN, securemess);
			return 1;
		}
		else {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use this feature!");
			return 1;
		}
	}
	else {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle to use this feature");
		return 1;
	}
}

stock aunsecure(playerid)
{
	if(PlayerInfo[playerid][logged] == 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this feature");
		return 1;
	}
	if(IsPlayerInAnyVehicle(playerid)) {
		if (PlayerInfo[playerid][admin] > 4) {
			VehicleInfo[GetPlayerVehicleStreamID(playerid)][asecure] = 0;
			format(securemess,sizeof(securemess),"You have set this %s as accessable to everyone.", VehicleInfo[GetPlayerVehicleStreamID(playerid)][name]);
			SendClientMessage(playerid, COLOR_GREEN, securemess);
			return 1;
		}
		else {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not have permission to use this feature!");
			return 1;
		}
	}
	else {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle to use this feature");
		return 1;
	}
}

stock unsecure(playerid)
{
	if(PlayerInfo[playerid][logged] == 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this feature");
		return 1;
	}
	if(PlayerInfo[playerid][jailed] == 1) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You are in jail and cannot use this feature");
		return 1;
	}
  	if(VehicleInfo[GetPlayerVehicleStreamID(playerid)][buybar] == 1) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is un-buyable and these features will not work!");
		return 1;
		}
	if(PlayerInfo[playerid][vowner] == 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must first own a vehicle before you can use this feature!");
		return 1;
	}
	if(IsPlayerInAnyVehicle(playerid)) {
		if (strcmp(VehicleInfo[GetPlayerVehicleStreamID(playerid)][owner],PlayerInfo[playerid][name],false) == 0) {
			VehicleInfo[GetPlayerVehicleStreamID(playerid)][secure] = 0;
			format(securemess,sizeof(securemess),"You have set your %s as accessable to everyone.", VehicleInfo[GetPlayerVehicleStreamID(playerid)][name]);
			SendClientMessage(playerid, COLOR_GREEN, securemess);
			return 1;
		}
		else {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not own this vehicle and cannot secure it!");
			return 1;
		}
	}
	else {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle to use this feature");
		return 1;
	}
}

stock securekill(playerid)
{
    if(PlayerInfo[playerid][logged] == 0) {
	    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this feature");
	    return 1;
	}
	if(PlayerInfo[playerid][jailed] == 1) {
	    SendClientMessage(playerid, COLOR_BRIGHTRED, "You are in jail and cannot use this feature");
	    return 1;
	}
  	if(VehicleInfo[GetPlayerVehicleStreamID(playerid)][buybar] == 1) {
   		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is un-buyable and these features will not work!");
		return 1;
   	}
	if(PlayerInfo[playerid][vowner] == 0) {
     	SendClientMessage(playerid, COLOR_BRIGHTRED, "You must first own a vehicle before you can use this feature!");
		return 1;
	}
	if(IsPlayerInAnyVehicle(playerid)) {
   	    if (strcmp(VehicleInfo[GetPlayerVehicleStreamID(playerid)][owner],PlayerInfo[playerid][name],false) == 0) {
			VehicleInfo[GetPlayerVehicleStreamID(playerid)][secure] = 2;
			format(securemess,sizeof(securemess),"You have set your %s as secure with lethal protection, no other player will be able to use it even when you are offline.", VehicleInfo[GetPlayerVehicleStreamID(playerid)][name]);
			SendClientMessage(playerid, COLOR_GREEN, securemess);
			return 1;
		}
		else {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not own this vehicle and cannot secure it!");
			return 1;
		}
	}
	else {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle to use this feature");
		return 1;
	}
}

stock callcar(playerid)
{
    if(PlayerInfo[playerid][logged] == 0) {
	    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this feature");
	    return 1;
	}
	if(PlayerInfo[playerid][jailed] == 1) {
	    SendClientMessage(playerid, COLOR_BRIGHTRED, "You are in jail and cannot use this feature");
	    return 1;
	}
	if(PlayerInterior[playerid] > 0) {
	    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must outside to call a vehicle to you!");
		return 1;
	}
	if(PlayerInfo[playerid][vowner] == 0) {
        SendClientMessage(playerid, COLOR_BRIGHTRED, "You must first own a vehicle before you can use this feature!");
		return 1;
	}
	if(IsPlayerInAnyVehicle(playerid) == 1) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You can't call a vehicle to you if you are in one!");
		return 1;
	}
	if(VehicleInfo[PlayerInfo[playerid][vowned]][modding] == 1) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "Vehicle currently Busy, try again in a few seconds!");
		return 1;
	}
	if(VehicleInfo[PlayerInfo[playerid][vowned]][limbo] == 1) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "Your vehicle cannot be called to you at the moment, please wait and try again later.");
		return 1;
	}
	for(new i=0; i < MAX_PLAYERS; i++) {
		if (IsPlayerConnected(i) == 1) {
			if (IsPlayerInAnyVehicle(i) == 1) {
				if (GetPlayerVehicleStreamID(i) == PlayerInfo[playerid][vowned]) {
				    if(GetPlayerInterior(i) == 1) {
				        SendClientMessage(playerid, COLOR_BRIGHTRED, "Vehicle currently Busy, try again in a few seconds!");
						return 1;
				    }
					SendClientMessage(i, COLOR_BRIGHTRED, "This vehicle has been recalled by its owner, enjoy the walk!");
				}
			}
		}
	}
	if(VehicleInfo[PlayerInfo[playerid][vowned]][spawned] == 1) {
		SetVehicleToRespawn(VehicleInfo[PlayerInfo[playerid][vowned]][idnum]);
		SetVehicleVirtualWorld(VehicleInfo[PlayerInfo[playerid][vowned]][idnum],10);
		SetVehicleUsed(VehicleInfo[PlayerInfo[playerid][vowned]][idnum],true);
	}
	SendClientMessage(playerid, COLOR_ORANGE, "Your vehicle is on its way, It will take 8 seconds to arrive at your location...");
	SetTimerEx("CallVehicleToPlayer",8000,0,"i",playerid);
	return 1;
}

stock park(playerid)
{
	new streamid = GetPlayerVehicleStreamID(playerid);
    if(PlayerInfo[playerid][logged] == 0) {
	    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this feature");
	    return 1;
	}
	if(PlayerInfo[playerid][jailed] == 1) {
	    SendClientMessage(playerid, COLOR_BRIGHTRED, "You are in jail and cannot use this feature");
	    return 1;
	}
  	if(VehicleInfo[streamid][buybar] == 1) {
   		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is un-buyable and these features will not work!");
		return 1;
   	}
	if(PlayerInfo[playerid][vowner] == 0) {
    	SendClientMessage(playerid, COLOR_BRIGHTRED, "You must first own a vehicle before you can use this feature!");
		return 1;
	}
	if(IsPlayerInAnyVehicle(playerid)) {
   	    if (strcmp(VehicleInfo[streamid][owner],PlayerInfo[playerid][name],false) == 0) {
			new Float:spx,Float:spy,Float:spz;
       		new Float:spa;
			GetVehiclePos(GetPlayerVehicleID(playerid),spx,spy,spz);
        	GetVehicleZAngle(GetPlayerVehicleID(playerid),spa);
         	VehicleInfo[streamid][x_spawn] = spx;
			VehicleInfo[streamid][y_spawn] = spy;
			VehicleInfo[streamid][z_spawn] = spz;
			VehicleInfo[streamid][za_spawn] = spa;
			format(securemess,sizeof(securemess),"You have just parked your %s at your current location...it will respawn here in future!", VehicleInfo[streamid][name]);
			SaveVehicles();
			SendClientMessage(playerid, COLOR_GREEN, securemess);
			return 1;
		}
		else {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not own this vehicle and cannot park it!");
			return 1;
		}
	}
	else {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle to use this feature");
		return 1;
	}
}

stock dashboardon(playerid)
{
	speedo[playerid] = 1;
	if(IsPlayerInAnyVehicle(playerid)) {
		for(new d=0; d<3; d++) {
			if(GetVehicleModel(GetPlayerVehicleID(playerid)) == pbike[d][0]) {
				speedo[playerid] = 2;
			}
		}
	}
	TextDrawShowForPlayer(playerid, stxt[playerid]);
	SendClientMessage(playerid,COLOR_GREEN,"Your dashboard display is now switched ON!");
	return 1;
}

stock dashboardoff(playerid)
{
	speedo[playerid] = 0;
	SendClientMessage(playerid,COLOR_BRIGHTRED,"Your dashboard display is now switched OFF!");
	if(IsPlayerInAnyVehicle(playerid)) {
	    TextDrawHideForPlayer(playerid, stxt[playerid]);
	}
	return 1;
}
//=============================Stream Stuff=====================================
stock CountVehicles(filename[]) {
    new File:VehicleFile;
    new blank[256];
    new count = 0;
    if (fexist(V_FILE_SAVE)) {
        VehicleFile = fopen(V_FILE_SAVE);
        while(fread(VehicleFile, blank, sizeof blank)) {
            count++;
        }
        fclose(VehicleFile);
    }
    else {
        VehicleFile = fopen(filename);
        while(fread(VehicleFile, blank, sizeof blank)) {
            count++;
        }
        fclose(VehicleFile);
    }

    return count;
}

stock CountBusinesses(filename[]) {
    new File:BusinessFile;
    new blank[256];
    new count = 0;
    if (fexist(B_FILE_SAVE)) {
        BusinessFile = fopen(B_FILE_SAVE);
        while(fread(BusinessFile, blank, sizeof blank)) {
            count++;
        }
        fclose(BusinessFile);
    }
    else {
        BusinessFile = fopen(filename);
        while(fread(BusinessFile, blank, sizeof blank)) {
            count++;
        }
        fclose(BusinessFile);
    }

    return count;
}

stock split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;

	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}

stock SetupVehiclesFile()
{
    new File: file;
    file = fopen(V_FILE_SAVE, io_write);
    new SplitDiv[99][55];
	new filestring[256];
	file = fopen(V_FILE_LOAD, io_read);
	new carcost[MAX_STREAM_VEHICLES];
	for(new streamid=1;streamid<=vehcount;streamid++)
	{
		if (file)
		{
			fread(file, filestring);
		 	split(filestring, SplitDiv, ',');
			VehicleInfo[streamid][model] = strval(SplitDiv[0]);
			VehicleInfo[streamid][x_spawn] = floatstr(SplitDiv[1]);
			VehicleInfo[streamid][y_spawn] = floatstr(SplitDiv[2]);
			VehicleInfo[streamid][z_spawn] = floatstr(SplitDiv[3]);
			VehicleInfo[streamid][za_spawn] = floatstr(SplitDiv[4]);
			VehicleInfo[streamid][color_1] = strval(SplitDiv[5]);
			VehicleInfo[streamid][color_2] = strval(SplitDiv[6]);
            CreateStreamVehicle(VehicleInfo[streamid][model], VehicleInfo[streamid][x_spawn], VehicleInfo[streamid][y_spawn], VehicleInfo[streamid][z_spawn], VehicleInfo[streamid][za_spawn], VehicleInfo[streamid][color_1], VehicleInfo[streamid][color_2],DEFAULT_SPAWN_DIST);
			carcost[streamid] = 50000;
    		for(new s=0; s<24; s++) {
     			if(VehicleInfo[streamid][model] == heavycar[s][0]) {
       				carcost[streamid] = 100000;
   	        	}
			}
			for(new a=0; a<11; a++) {
     			if(VehicleInfo[streamid][model] == boat[a][0]) {
       				carcost[streamid] = 50000;
   	   		     }
			}
			for(new c=0; c<11; c++) {
	     		if(VehicleInfo[streamid][model] == mbike[c][0]) {
   	    			carcost[streamid] = 40000;
	   	        }
			}
			for(new d=0; d<3; d++) {
   		  		if(VehicleInfo[streamid][model] == pbike[d][0]) {
       				carcost[streamid] = 3000;
   	   		     }
			}
			for(new e=0; e<6; e++) {
    	 		if(VehicleInfo[streamid][model] == splane[e][0]) {
       				carcost[streamid] = 500000;
   	        	}
			}
			for(new f=0; f<2; f++) {
     			if(VehicleInfo[streamid][model] == mplane[f][0]) {
       					carcost[streamid] = 1500000;
   	    	    }
			}
			for(new v=0; v<2; v++) {
     			if(VehicleInfo[streamid][model] == lplane[v][0]) {
       				carcost[streamid] = 2000000;
   	    	    }
			}
			for(new n=0; n<4; n++) {
     			if(VehicleInfo[streamid][model] == milair[n][0]) {
       				carcost[streamid] = 4000000;
   	        	}
			}
			for(new j=0; j<4; j++) {
     			if(VehicleInfo[streamid][model] == sheli[j][0]) {
       				carcost[streamid] = 750000;
   	        	}
			}
			for(new k=0; k<3; k++) {
     			if(VehicleInfo[streamid][model] == lheli[k][0]) {
       				carcost[streamid] = 1250000;
   	        	}
			}
			VehicleInfo[streamid][vehiclecost] = carcost[streamid];
			VehicleInfo[streamid][vused] = 0;
			VehicleInfo[streamid][bought] = 0;
			VehicleInfo[streamid][secure] = 0;
			VehicleInfo[streamid][asecure] = 0;
			VehicleInfo[streamid][buybar] = 0;
			VehicleInfo[streamid][mod1] = 0;
			VehicleInfo[streamid][mod2] = 0;
			VehicleInfo[streamid][mod3] = 0;
			VehicleInfo[streamid][mod4] = 0;
			VehicleInfo[streamid][mod5] = 0;
			VehicleInfo[streamid][mod6] = 0;
			VehicleInfo[streamid][mod7] = 0;
			VehicleInfo[streamid][mod8] = 0;
			VehicleInfo[streamid][mod9] = 0;
			VehicleInfo[streamid][mod10] = 0;
			VehicleInfo[streamid][mod11] = 0;
			VehicleInfo[streamid][mod12] = 0;
			VehicleInfo[streamid][mod13] = 0;
			VehicleInfo[streamid][mod14] = 0;
			VehicleInfo[streamid][mod15] = 0;
			VehicleInfo[streamid][mod16] = 0;
			VehicleInfo[streamid][mod17] = 0;
			VehicleInfo[streamid][paintjob] = -1;
			strmid(VehicleInfo[streamid][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
            strmid(VehicleInfo[streamid][name], VehicleName[VehicleInfo[streamid][model]-400][0], 0, strlen(VehicleName[VehicleInfo[streamid][model]-400][0]), 255);
			new addmess[256];
			format(addmess,sizeof(addmess),"--:: Streaming vehicle %d (%s) successfully setup ::--",streamid,VehicleInfo[streamid][name]);
			print(addmess);
		}
	}
	fclose(file);
	print(">------------------------------------------------");
	print(" ");
	print(">------------------------------------------------");
	print("Initialising Vehicle File System - Please Wait For Confirmation...");
	print(" ");
	SaveVehicles();
	print(" ");
	print("Vehicle File System 100% Initialised...");
	print(">------------------------------------------------");
	printf(" ");
}

stock LoadVehicles()
{
	if(fexist(V_FILE_SAVE)) {
        new SplitDiv[99][55];
		new filestring[256];
		new File: file = fopen(V_FILE_SAVE, io_read);
		if (file) {
	    	for(new streamid = 1;streamid<=vehcount;streamid++)
			{
		    	fread(file, filestring);
				split(filestring, SplitDiv, ',');
				VehicleInfo[streamid][model] = strval(SplitDiv[0]);
				VehicleInfo[streamid][x_spawn] = floatstr(SplitDiv[1]);
				VehicleInfo[streamid][y_spawn] = floatstr(SplitDiv[2]);
				VehicleInfo[streamid][z_spawn] = floatstr(SplitDiv[3]);
				VehicleInfo[streamid][za_spawn] = floatstr(SplitDiv[4]);
				VehicleInfo[streamid][color_1] = strval(SplitDiv[5]);
				VehicleInfo[streamid][color_2] = strval(SplitDiv[6]);
				VehicleInfo[streamid][vehiclecost] = strval(SplitDiv[7]);
				VehicleInfo[streamid][bought] = strval(SplitDiv[8]);
				VehicleInfo[streamid][secure] = strval(SplitDiv[9]);
				VehicleInfo[streamid][asecure] = strval(SplitDiv[10]);
				VehicleInfo[streamid][vused] = 0;
				VehicleInfo[streamid][buybar] = strval(SplitDiv[12]);
				VehicleInfo[streamid][mod1] = strval(SplitDiv[13]);
				VehicleInfo[streamid][mod2] = strval(SplitDiv[14]);
				VehicleInfo[streamid][mod3] = strval(SplitDiv[15]);
				VehicleInfo[streamid][mod4] = strval(SplitDiv[16]);
				VehicleInfo[streamid][mod5] = strval(SplitDiv[17]);
				VehicleInfo[streamid][mod6] = strval(SplitDiv[18]);
				VehicleInfo[streamid][mod7] = strval(SplitDiv[19]);
				VehicleInfo[streamid][mod8] = strval(SplitDiv[20]);
				VehicleInfo[streamid][mod9] = strval(SplitDiv[21]);
				VehicleInfo[streamid][mod10] = strval(SplitDiv[22]);
				VehicleInfo[streamid][mod11] = strval(SplitDiv[23]);
				VehicleInfo[streamid][mod12] = strval(SplitDiv[24]);
				VehicleInfo[streamid][mod13] = strval(SplitDiv[25]);
				VehicleInfo[streamid][mod14] = strval(SplitDiv[26]);
				VehicleInfo[streamid][mod15] = strval(SplitDiv[27]);
				VehicleInfo[streamid][mod16] = strval(SplitDiv[28]);
				VehicleInfo[streamid][mod17] = strval(SplitDiv[29]);
				VehicleInfo[streamid][paintjob] = strval(SplitDiv[32]);
				strmid(VehicleInfo[streamid][owner], SplitDiv[30], 0, strlen(SplitDiv[30]), 255);
				strmid(VehicleInfo[streamid][name], SplitDiv[31], 0, strlen(SplitDiv[31]), 255);
			 	CreateStreamVehicle(VehicleInfo[streamid][model], VehicleInfo[streamid][x_spawn], VehicleInfo[streamid][y_spawn], VehicleInfo[streamid][z_spawn], VehicleInfo[streamid][za_spawn], VehicleInfo[streamid][color_1], VehicleInfo[streamid][color_2],DEFAULT_SPAWN_DIST);
				new addmess[256];
				format(addmess,sizeof(addmess),"--:: Streaming vehicle %d (%s) successfully setup - owner: %s ::--",streamid,VehicleInfo[streamid][name],VehicleInfo[streamid][owner]);
				print(addmess);
			}
		}
		fclose(file);
	}
	else {
		SetupVehiclesFile();
	}
}

stock LoadBusinesses()
{
	if(fexist(B_FILE_SAVE)) {
        new SplitDiv[99][B_LIMIT];
		new filestring[256];
		new File: file = fopen(B_FILE_SAVE, io_read);
		if (file) {
	    	for(new bizid = 0;bizid<bizcount;bizid++)
			{
		    	fread(file, filestring);
				split(filestring, SplitDiv, ',');
				BizInfo[bizid][xpos] = floatstr(SplitDiv[0]);
				BizInfo[bizid][ypos] = floatstr(SplitDiv[1]);
				BizInfo[bizid][zpos] = floatstr(SplitDiv[2]);
				strmid(BizInfo[bizid][owner], SplitDiv[3], 0, strlen(SplitDiv[3]), 255);
				strmid(BizInfo[bizid][name], SplitDiv[4], 0, strlen(SplitDiv[4]), 255);
				BizInfo[bizid][bought] = strval(SplitDiv[5]);
				BizInfo[bizid][cost] = strval(SplitDiv[6]);
				BizInfo[bizid][profit] = strval(SplitDiv[7]);
				BizInfo[bizid][cashbox] = strval(SplitDiv[8]);
			 	AddStaticPickup(B_ICON,B_ICON_TYPE, BizInfo[bizid][xpos], BizInfo[bizid][ypos], BizInfo[bizid][zpos]);
				new addmess[256];
				format(addmess,sizeof(addmess),"--:: Business %d (%s) successfully spawned - owner: %s ::--",bizid,BizInfo[bizid][name],BizInfo[bizid][owner]);
				print(addmess);
			}
		}
		fclose(file);
	}
	else {
		SetupBizFile();
	}
}

stock SaveBusinesses()
{
	new filestring[256];
	new File: bfile = fopen(B_FILE_SAVE, io_write);
	for(new bizid = 0;bizid<bizcount;bizid++)
   	{
		format(filestring, sizeof(filestring), "%f,%f,%f,%s,%s,%d,%d,%d,%d\n",
		BizInfo[bizid][xpos],
		BizInfo[bizid][ypos],
		BizInfo[bizid][zpos],
		BizInfo[bizid][owner],
		BizInfo[bizid][name],
		BizInfo[bizid][bought],
		BizInfo[bizid][cost],
		BizInfo[bizid][profit],
		BizInfo[bizid][cashbox]
		);
		fwrite(bfile, filestring);
	}
	fclose(bfile);
}

stock SetupBizFile()
{
    new File: file;
    new SplitDiv[99][B_LIMIT];
	new filestring[256];
	file = fopen(B_FILE_LOAD, io_read);
	for(new bizid=0;bizid<bizcount;bizid++)
	{
		if (file)
		{
			fread(file, filestring);
		 	split(filestring, SplitDiv, ',');
			BizInfo[bizid][xpos] = floatstr(SplitDiv[0]);
			BizInfo[bizid][ypos] = floatstr(SplitDiv[1]);
			BizInfo[bizid][zpos] = floatstr(SplitDiv[2]);
			strmid(BizInfo[bizid][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
			strmid(BizInfo[bizid][name], SplitDiv[3], 0, strlen(SplitDiv[3]), 255);
			BizInfo[bizid][bought] = 0;
			BizInfo[bizid][cost] = strval(SplitDiv[4]);
			BizInfo[bizid][profit] = strval(SplitDiv[5]);
			BizInfo[bizid][cashbox] = 0;
            AddStaticPickup(B_ICON,B_ICON_TYPE, BizInfo[bizid][xpos], BizInfo[bizid][ypos], BizInfo[bizid][zpos]);
			new addmess[256];
			format(addmess,sizeof(addmess),"--:: Business %d (%s) successfully spawned ::--",bizid,BizInfo[bizid][name]);
			print(addmess);
		}
	}
	fclose(file);
	print(">------------------------------------------------");
	print(" ");
	print(">------------------------------------------------");
	print("Initialising Business File System - Please Wait For Confirmation...");
	print(" ");
	SaveBusinesses();
	print(" ");
	print("Business File System 100% Initialised...");
	print(">------------------------------------------------");
	printf(" ");
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	streamidn[playerid] = GetPickupStreamID(pickupid);
 	if(PickupInfo[streamidn[playerid]][type] == PICKUP_TYPE_BIZ) {
		new bizowner[25];
		format(bizowner,256,"%s",BizInfo[streamidn[playerid]][owner]);
		if(strcmp(BizInfo[streamidn[playerid]][owner],DEFAULT_OWNER,false) == 0) {
	    	format(bizowner,256,"Not Owned");
		}
		new bizmes[256];
		format(bizmes,256,"~n~~n~~r~Business: ~g~%s~n~~r~Price: ~g~$%d ~r~~n~~r~Profit: ~g~$%d/hr ~n~~r~Owner: ~g~%s",BizInfo[streamidn[playerid]][name],BizInfo[streamidn[playerid]][cost],BizInfo[streamidn[playerid]][profit]*2,bizowner);
    	GameTextForPlayer(playerid,bizmes,5000,3);
		bizmsg[playerid] = 1;
		SetTimerEx("ResetText",5000,0,"i",playerid);
		return 1;
	}
 	if(PickupInfo[streamidn[playerid]][type] == PICKUP_TYPE_BANK) {
    	GameTextForPlayer(playerid,"~b~Type ~y~/bankhelp ~b~to see how to use the bank.",5000,3);
		bizmsg[playerid] = 1;
		SetTimerEx("ResetText",5000,0,"i",playerid);
		return 1;
	}
	if(HP1[pickupid] != 0)
	{
		OnPlayerEnterHousee(playerid,HP1[pickupid]);
	}
	return 1;
}

public ResetText(playerid)
{
	bizmsg[playerid] = 0;
}

stock CloseToBank(playerid)
{
    new Float:maxdis = 20.0;
	new Float:ppos[3];
    GetPlayerPos(playerid, ppos[0], ppos[1], ppos[2]);
	for(new i = 0;i<3;i++) {
    	if (ppos[0] >= floatsub(Pickup[i][0], maxdis) && ppos[0] <= floatadd(Pickup[i][0], maxdis)
    	&& ppos[1] >= floatsub(Pickup[i][1], maxdis) && ppos[1] <= floatadd(Pickup[i][1], maxdis)
    	&& ppos[2] >= floatsub(Pickup[i][2], maxdis) && ppos[2] <= floatadd(Pickup[i][2], maxdis))
    	{
        	return i;
    	}
	}
	return 999;
}

stock ClosestBiz(playerid)
{
    new Float:ppos[3];
    new Float:maxdis = 7.0;
    GetPlayerPos(playerid, ppos[0], ppos[1], ppos[2]);
    for(new i = 0;i<bizcount;i++) {
    	if (ppos[0] >= floatsub(BizInfo[i][xpos], maxdis) && ppos[0] <= floatadd(BizInfo[i][xpos], maxdis)
    	&& ppos[1] >= floatsub(BizInfo[i][ypos], maxdis) && ppos[1] <= floatadd(BizInfo[i][ypos], maxdis)
    	&& ppos[2] >= floatsub(BizInfo[i][zpos], maxdis) && ppos[2] <= floatadd(BizInfo[i][zpos], maxdis))
    	{
        	return i;
    	}
	}
	return 99;
}

stock IsModelActive(vmodel)
{
    for(new i = 1;i<=vehcount;i++) {
        if(VehicleInfo[i][spawned] == 1) {
            if(VehicleInfo[i][model] == vmodel) {
                return 1;
            }
        }
    }
    return 0;
}

stock CountModels(maxstream)
{
	new modelcount = 0;
	new modelcounted[MAX_MODEL_NUMBER];
    for(new i = 1;i<=maxstream;i++) {
        if(VehicleInfo[i][spawned] == 1) {
            if(modelcounted[VehicleInfo[i][model]] == 0) {
                modelcount++;
                modelcounted[VehicleInfo[i][model]] = 1;
            }
        }
    }
    return modelcount;
}

stock SaveVehicles()
{
	new filestring[256];
	new File: vfile = fopen(V_FILE_SAVE, io_write);
	for(new vehicleid = 1;vehicleid<=vehcount;vehicleid++)
   	{
		format(filestring, sizeof(filestring), "%d,%f,%f,%f,%f,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%s,%s,%d\n",
		VehicleInfo[vehicleid][model],
		VehicleInfo[vehicleid][x_spawn],
		VehicleInfo[vehicleid][y_spawn],
		VehicleInfo[vehicleid][z_spawn],
		VehicleInfo[vehicleid][za_spawn],
		VehicleInfo[vehicleid][color_1],
		VehicleInfo[vehicleid][color_2],
		VehicleInfo[vehicleid][vehiclecost],
		VehicleInfo[vehicleid][bought],
		VehicleInfo[vehicleid][secure],
		VehicleInfo[vehicleid][asecure],
		VehicleInfo[vehicleid][vused],
		VehicleInfo[vehicleid][buybar],
		VehicleInfo[vehicleid][mod1],
		VehicleInfo[vehicleid][mod2],
		VehicleInfo[vehicleid][mod3],
		VehicleInfo[vehicleid][mod4],
		VehicleInfo[vehicleid][mod5],
		VehicleInfo[vehicleid][mod6],
		VehicleInfo[vehicleid][mod7],
		VehicleInfo[vehicleid][mod8],
		VehicleInfo[vehicleid][mod9],
		VehicleInfo[vehicleid][mod10],
		VehicleInfo[vehicleid][mod11],
		VehicleInfo[vehicleid][mod12],
		VehicleInfo[vehicleid][mod13],
		VehicleInfo[vehicleid][mod14],
		VehicleInfo[vehicleid][mod15],
		VehicleInfo[vehicleid][mod16],
		VehicleInfo[vehicleid][mod17],
		VehicleInfo[vehicleid][owner],
		VehicleInfo[vehicleid][name],
		VehicleInfo[vehicleid][paintjob]
		);
		fwrite(vfile, filestring);
	}
	fclose(vfile);
}

public ModVehicle(streamid)
{
    new tuned2 = 0;
	if(VehicleInfo[streamid][mod1] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod1]);}
		tuned2 = 1;
	}
	if(VehicleInfo[streamid][mod2] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod2]);}
		tuned2 = 1;
	}
	if(VehicleInfo[streamid][mod3] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod3]);}
		tuned2 = 1;
	}
	if(VehicleInfo[streamid][mod4] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod4]);}
		tuned2 = 1;
	}
	if(VehicleInfo[streamid][mod5] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod5]);}
		tuned2 = 1;
	}
	if(VehicleInfo[streamid][mod6] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod6]);}
		tuned2 = 1;
	}
	if(VehicleInfo[streamid][mod7] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod7]);}
		tuned2 = 1;
	}
	if(VehicleInfo[streamid][mod8] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod8]);}
		tuned2 = 1;
 	}
	if(VehicleInfo[streamid][mod9] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod9]);}
		tuned2 = 1;
	}
	if(VehicleInfo[streamid][mod10] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod10]);}
		tuned2 = 1;
	}
	if(VehicleInfo[streamid][mod11] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod11]);}
		tuned2 = 1;
	}
	if(VehicleInfo[streamid][mod12] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod12]);}
		tuned2 = 1;
	}
	if(VehicleInfo[streamid][mod13] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod13]);}
		tuned2 = 1;
	}
	if(VehicleInfo[streamid][mod14] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod14]);}
		tuned2 = 1;
	}
	if(VehicleInfo[streamid][mod15] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod15]);}
		tuned2 = 1;
	}
	if(VehicleInfo[streamid][mod16] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod16]);}
		tuned2 = 1;
	}
	if(VehicleInfo[streamid][mod17] != 0) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {AddVehicleComponent(VehicleInfo[streamid][idnum],VehicleInfo[streamid][mod17]);}
		tuned2 = 1;
	}
	if(VehicleInfo[streamid][color_1] > -1 || VehicleInfo[streamid][color_2] > -1) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {ChangeVehicleColor(VehicleInfo[streamid][idnum],VehicleInfo[streamid][color_1],VehicleInfo[streamid][color_2]);}
		tuned2 = 1;
 	}
	if(VehicleInfo[streamid][paintjob] > -1) {
		if(VehicleInfo[streamid][spawned] == 1 && VehicleInfo[streamid][reset] == 0) {ChangeVehiclePaintjob(VehicleInfo[streamid][idnum],VehicleInfo[streamid][paintjob]);}
		tuned2 = 1;
 	}
	if(tuned2 == 1) {
	    tuned++;
	}
}

stock IsPlayerNameOnline(compname[])
{
	new playername[MAX_PLAYER_NAME];
    for(new i=0;i<=MAX_PLAYERS;i++) {
        if(IsPlayerConnected(i)) {
            GetPlayerName(i, playername, sizeof(playername));
            if(strcmp(playername,compname,false) == 0) {
                return i;
			}
		}
	}
	return 1000;
}

stock PlayersInRangeV(streamid,Float:MAX)
{
	for(new i = 0;i<MAX_PLAYERS;i++) {
   	    if(IsPlayerConnected(i)) {
   	        new Float:PPos[3];
  			GetPlayerPos(i, PPos[0], PPos[1], PPos[2]);
			if (PPos[0] >= floatsub(VehicleInfo[streamid][x_spawn], MAX) && PPos[0] <= floatadd(VehicleInfo[streamid][x_spawn], MAX)
			&& PPos[1] >= floatsub(VehicleInfo[streamid][y_spawn], MAX) && PPos[1] <= floatadd(VehicleInfo[streamid][y_spawn], MAX)
			&& PPos[2] >= floatsub(VehicleInfo[streamid][z_spawn], MAX) && PPos[2] <= floatadd(VehicleInfo[streamid][z_spawn], MAX))
			{
				return 1;
			}
		}
	}
	return 0;
}

stock PlayersInRangePU(streamid,Float:MAX)
{
	for(new i = 0;i<MAX_PLAYERS;i++) {
   	    if(IsPlayerConnected(i)) {
   	        new Float:PPos[3];
  			GetPlayerPos(i, PPos[0], PPos[1], PPos[2]);
			if (PPos[0] >= floatsub(PickupInfo[streamid][x_spawn], MAX) && PPos[0] <= floatadd(PickupInfo[streamid][x_spawn], MAX)
			&& PPos[1] >= floatsub(PickupInfo[streamid][y_spawn], MAX) && PPos[1] <= floatadd(PickupInfo[streamid][y_spawn], MAX)
			&& PPos[2] >= floatsub(PickupInfo[streamid][z_spawn], MAX) && PPos[2] <= floatadd(PickupInfo[streamid][z_spawn], MAX))
			{
				return 1;
			}
		}
	}
	return 0;
}

stock CreateStreamVehicle(modelid,Float:x,Float:y,Float:z,Float:a,col1,col2,Float:spawn_distance)
{
	for(new i = 1;i<MAX_STREAM_VEHICLES;i++) {
	    if(VehicleInfo[i][valid] == 0) {
			VehicleInfo[i][model] = modelid;
			VehicleInfo[i][x_spawn] = x;
			VehicleInfo[i][y_spawn] = y;
			VehicleInfo[i][z_spawn] = z;
			VehicleInfo[i][za_spawn] = a;
			VehicleInfo[i][color_1] = col1;
			VehicleInfo[i][color_2] = col2;
			VehicleInfo[i][spawndist] = spawn_distance;
			VehicleInfo[i][valid] = 1;
			VehicleInfo[i][idnum] = 0;
			VehicleInfo[i][paintjob] = -1;
			return i;
		}
	}
	return 0;
}

stock CreateStreamPickup(modelid,Float:x,Float:y,Float:z,ptype)
{
	for(new i = 0;i<B_LIMIT;i++) {
	    if(PickupInfo[i][valid] == 0) {
			PickupInfo[i][model] = modelid;
			PickupInfo[i][x_spawn] = x;
			PickupInfo[i][y_spawn] = y;
   			PickupInfo[i][z_spawn] = z;
			PickupInfo[i][type] = ptype;
			PickupInfo[i][idnum] = -1;
			PickupInfo[i][valid] = 1;
			return i;
		}
	}
	return 0;
}

stock GetPickupStreamID(pickupid)
{
	for(new i = 0;i<B_LIMIT;i++) {
		if(pickupid == PickupInfo[i][idnum]) {
   			return i;
		}
	}
	return -1;
}

stock GetPlayerVehicleStreamID(playerid)
{
	return avstream[GetPlayerVehicleID(playerid)];
}

stock GetVehicleStreamID(vehicleid)
{
	return avstream[vehicleid];
}

stock SetVehicleUsed(vehicleid,bool:toggle)
{
	vehused[vehicleid] = toggle;
	return 1;
}

stock IsPlayerClose(playerid,Float:x,Float:y,Float:z,Float:MAX)
{
	new Float:PPos[3];
	GetPlayerPos(playerid, PPos[0], PPos[1], PPos[2]);
	if (PPos[0] >= floatsub(x, MAX) && PPos[0] <= floatadd(x, MAX)
	&& PPos[1] >= floatsub(y, MAX) && PPos[1] <= floatadd(y, MAX)
	&& PPos[2] >= floatsub(z, MAX) && PPos[2] <= floatadd(z, MAX))
	{
		return 1;
	}
	return 0;
}

stock CreateStreamMapIcon(markermodel,Float:x,Float:y,Float:z,Float:spawn_distance)
{
	for(new i = 1;i<B_LIMIT;i++) {
		if(MapIconInfo[i][mvalid] == 0) {
			MapIconInfo[i][mmodel] = markermodel;
			for(new j=0;j<MAX_PLAYERS;j++) {
				MIidnum[j][i] = i;
			}
			MapIconInfo[i][mx_spawn] = x;
			MapIconInfo[i][my_spawn] = y;
			MapIconInfo[i][mz_spawn] = z;
			MapIconInfo[i][mspawndist] = spawn_distance;
			MapIconInfo[i][mvalid] = 1;
			return i;
		}
	}
	return 0;
}

stock ChangeMapIconModel(streamid,newmodel)
{
	for(new i = 0;i<MAX_PLAYERS;i++) {
	    if(IsPlayerConnected(i)) {
			new iconid = MIidnum[i][streamid];
    		MapIconInfo[streamid][mmodel] = newmodel;
    		if(MIactive[i][streamid] == 1) {
        		RemovePlayerMapIcon(i,iconid);
				SetPlayerMapIcon(i,iconid,MapIconInfo[streamid][mx_spawn],MapIconInfo[streamid][my_spawn],MapIconInfo[streamid][mz_spawn],MapIconInfo[streamid][mmodel],1);
			}
		}
	}
}
//==============================================================================
public PingKick() {
	if(Config[MaxPing]) {
	    for(new i = 0,string[256],xname[24]; i < MAX_PLAYERS; i++)
	    if(IsPlayerConnected(i) && (GetPlayerPing(i) > Config[MaxPing])) {
	        if(!IsPlayerXAdmin(i) || (IsPlayerXAdmin(i) && !Config[AdminImmunity])) {
	        	GetPlayerName(i,xname,24); format(string,256,"\"%s\" has been kicked from the server. (Reason: High Ping || Max Allowed: %d)",xname,Config[MaxPing]);
	        	SendClientMessageToAll(yellow,string); Kick(i);
	        }
	    }
	}
}
