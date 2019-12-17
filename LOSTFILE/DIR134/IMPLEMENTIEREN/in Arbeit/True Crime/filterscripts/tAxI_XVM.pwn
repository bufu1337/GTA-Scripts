//-------------This code was designed by tAxI aka Necrioss------------//
//-------------------email <::> cptnsausage@hotmail.com--------------------//
//---------If you are having problems please feel free to contact me-------//
//--------If u use this script in your gamemode you MUST give me credit------//

/*---Here it is ppl...tAxI's Xtreme Vehicle Management FilterScript...still in alpha
stage but its looking very promising!!!

Ok a few things u need to know to get started with this is that you must remove all the vehicles
in your gamemode and place their co-ords in a file "scriptfiles/tAxI_vehicles_setup.tAxI". You only
need to write in the co-ords etc like the following example:

on line one you would have: modelid,x,y,z,z_angle,color1,color2

and on line 2 you would do the same for your next car and so-on, and so-on........!

Thats it i think...Enjoy!!!---*/

#include <a_samp>
#include <dudb>
#include <time>
#include <file>
#include <float>
#pragma tabsize 0
#pragma dynamic 145000

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

#define V_FILE_LOAD "tAxI_vehicles_setup.tAxI"
#define V_FILE_SAVE "tAxI_vehicles_perm.tAxI"
#define DEFAULT_OWNER "server"
#define P_FILE "%s.tAxI"
#define V_LIMIT 701
#define DIV_AMOUNT 35
#define MAX_POINTS 22
#define GasMax 100
#define RunOutTime 30000
#define COLOR_AQUA 0x7CFC00AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x0AFF0AAA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_BRIGHTRED 0xFF0000AA
#define COLOR_INDIGO 0x4B00B0AA
#define CP_STATION1   0
#define CP_STATION2   1
#define CP_STATION3   2
#define CP_STATION4   3
#define CP_STATION5   4
#define CP_STATION6   5
#define CP_STATION7   6
#define CP_STATION8   7
#define CP_STATION9   8
#define CP_STATION10  9
#define CP_STATION11  10
#define CP_STATION12  11
#define CP_STATION13  12
#define CP_STATION14  13
#define CP_STATION15  14
#define CP_STATION16  15
#define CP_LVSTATION  16
#define CP_VMSTATION  17
#define CP_LSSTATION  18
#define CP_SFSTATION  19

new onsys[V_LIMIT];
new Text:vehiclehpbar[12];

enum ClientInfo
{
	name[256],
	vowned,
	vowner,
	vhpb,
}
	
new PlInfo[MAX_PLAYERS][ClientInfo];

enum vInfo
{
	modding,
	model,
	Float:x_spawn,
	Float:y_spawn,
	Float:z_spawn,
 	Float:za_spawn,
 	color_1,
 	color_2,
 	owner[256],
	vehiclecost,
	bought,
	secure,
	asecure,
	vused,
	buybar,
	name[256],
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
};

new VehicleInfo[V_LIMIT][vInfo];

new vehcount;

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
new tmpname[256];
new Count[MAX_PLAYERS];
new passenger[MAX_PLAYERS];
new speedo[MAX_PLAYERS];
new messaged[MAX_PLAYERS];
new aMessage[MAX_PLAYERS];
new tempid[MAX_PLAYERS];
new lockmess[V_LIMIT];
new securemess[V_LIMIT];
new carmess[999];

new Float:Pickup[20][3] = {
{2109.2126,917.5845,10.8203}, //fuelstations
{2640.1831,1103.9224,10.8203},
{611.8934,1694.7921,6.7193},
{-1327.5398,2682.9771,49.7896},
{-2413.7427,975.9317,45.0031},
{-1672.3597,414.2950,6.8866},
{-2244.1365,-2560.6294,31.6276},
{-1603.0166,-2709.3589,48.2419},
{1939.3275,-1767.6813,13.2787},
{-94.7651,-1174.8079,1.9979},
{1381.6699,462.6467,19.8540},
{657.8167,-559.6507,16.0630},
{-1478.2916,1862.8318,32.3617},
{2147.3054,2744.9377,10.5263},
{2204.9602,2480.3494,10.5278},
{1590.9493,2202.2637,10.5247},
{1561.5695,1448.6895,10.3636},
{366.4071,2535.3784,16.8363},
{1969.3317,-2303.8423,13.2547},
{-1299.7939,-26.2385,13.8556}
};

enum SavePlayerPosEnum
{
    Float:LastX,
    Float:LastY,
    Float:LastZ
}
new SavePlayerPos[MAX_PLAYERS][SavePlayerPosEnum];
new Float:ta, Float:tb, Float:tc;
new PlayerInterior[MAX_PLAYERS];
new Gas[V_LIMIT];
new tuned;
new Filling[MAX_PLAYERS];
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

forward IsPlayerNameOnline(compname[]);
forward fillcheck();
forward resetmessage();
forward FuelDown();
forward Fill();
forward resetcount();
forward announcer();
forward CheckGas();
forward BackupInfo();
forward GetDriverID(vehicleid);
forward ModVehicle(vehicleid);
forward SaveComponent(vehicleid,componentid);
forward SavePaintjob(vehicleid,paintjobid);
forward SaveColors(vehicleid,color1,color2);
forward CallVehicleToPlayer(playerid);
forward RestartVehicle(vehicleid);
forward VHPBarUpdate();




main()
{

}

public OnFilterScriptInit()
{
    SetTimer("FuelDown", RunOutTime, 1);
    SetTimer("CheckGas", 500, 1);
    SetTimer("Fill", 200, 1);
    SetTimer("fillcheck", 100, 1);
    SetTimer("BackupInfo",300000,1);
    vehcount = CountVehicles(V_FILE_LOAD);
    new vehmes[256];
	format(vehmes,sizeof(vehmes),"Verifying %s (Complete) - %d Vehicle Spawns Verified!", V_FILE_LOAD, vehcount);
	printf(vehmes);
	print(">------------------------------------------------");
	printf(" ");
	print(">------------------------------------------------");
	LoadVehicles();
    print(" ");
    print(">------------------------------------------------");
    for(new c=1;c<=vehcount;c++)
	{
	 	Gas[c] = GasMax;
	 	new strings[256];
	 	format(strings,sizeof(strings),"Fuelling Up Vehicle ID: %d / Type: %s", c, VehicleName[GetVehicleModel(c)-400][0]);
		printf(strings);
 	}
 	print(">------------------------------------------------");
 	print(" ");
 	print(">------------------------------------------------");
 	for(new c=1;c<=vehcount;c++)
	{
	 	ModVehicle(c);
	 	new strings[256];
	 	format(strings,sizeof(strings),"Checking Vehicle File For saved Mods - Vehicle ID: %d / Type: %s", c, VehicleName[GetVehicleModel(c)-400][0]);
		printf(strings);
 	}
 	print(">------------------------------------------------");
 	printf("");
	print(">------------------------------------------------");
	format(tmpname,sizeof(tmpname),"     %d Vehicles Were Tuned On Server Load!     ",tuned);
  	printf("");
	print(">------------------------------------------------");
	printf(tmpname);
	print(">------------------------------------------------");
	format(tmpname,sizeof(tmpname),"    %d Vehicles Were Refuelled On Server Load!   ",vehcount);
  	printf("");
	print(">------------------------------------------------");
	printf(tmpname);
	print(">------------------------------------------------");
 	printf("");
	print(">------------------------------------------------");
	print("tAxI's XVM System Status - 100% - System Ready...");
	print(">------------------------------------------------");
	printf("");
	printf("");

    //vehicle Menu System! Trial Version!

	vehiclemain = CreateMenu("tAxI-XVM",1,440,140,150,40);
	AddMenuItem(vehiclemain,0,"Player Vehicle Menu");
	AddMenuItem(vehiclemain,0,"Vehicle Admin System");
	AddMenuItem(vehiclemain,0,"<exit>");

	playervm = CreateMenu("tAxI-XVM",1,440,140,150,40);
	AddMenuItem(playervm,0,"Refuel Vehicle");
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

    //-----------Vehicle healthbar stuff :D

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

	//---------------------------------------------------------

    for(new i = 0;i<20;i++) {
    	AddStaticPickup(1239,2,Pickup[i][0],Pickup[i][1],Pickup[i][2]);
	}
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
		if(IsPlayerInAnyVehicle(i) == 1 && PlInfo[i][vhpb] == 1){
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
    new SplitDiv[99][V_LIMIT];
	new filestring[256];
	file = fopen(V_FILE_LOAD, io_read);
	new carcost[V_LIMIT];
	for(new vehicleid=1;vehicleid<=vehcount;vehicleid++)
	{
		if (file)
		{
			fread(file, filestring);
		 	split(filestring, SplitDiv, ',');
			VehicleInfo[vehicleid][model] = strval(SplitDiv[0]);
			VehicleInfo[vehicleid][x_spawn] = floatstr(SplitDiv[1]);
			VehicleInfo[vehicleid][y_spawn] = floatstr(SplitDiv[2]);
			VehicleInfo[vehicleid][z_spawn] = floatstr(SplitDiv[3]);
			VehicleInfo[vehicleid][za_spawn] = floatstr(SplitDiv[4]);
			VehicleInfo[vehicleid][color_1] = strval(SplitDiv[5]);
			VehicleInfo[vehicleid][color_2] = strval(SplitDiv[6]);
			CreateVehicle(VehicleInfo[vehicleid][model], VehicleInfo[vehicleid][x_spawn], VehicleInfo[vehicleid][y_spawn], VehicleInfo[vehicleid][z_spawn], VehicleInfo[vehicleid][za_spawn], VehicleInfo[vehicleid][color_1], VehicleInfo[vehicleid][color_2],20000);
			onsys[vehicleid] = 1;
			carcost[vehicleid] = 50000;
    		for(new s=0; s<24; s++) {
     			if(VehicleInfo[vehicleid][model] == heavycar[s][0]) {
       				carcost[vehicleid] = 100000;
   	        	}
			}
			for(new a=0; a<11; a++) {
     			if(VehicleInfo[vehicleid][model] == boat[a][0]) {
       				carcost[vehicleid] = 50000;
   	   		     }
			}
			for(new b=0; b<11; b++) {
	     		if(VehicleInfo[vehicleid][model] == mbike[b][0]) {
   	    			carcost[vehicleid] = 40000;
	   	        }
			}
			for(new d=0; d<3; d++) {
   		  		if(VehicleInfo[vehicleid][model] == pbike[d][0]) {
       				carcost[vehicleid] = 3000;
   	   		     }
			}
			for(new e=0; e<6; e++) {
    	 		if(VehicleInfo[vehicleid][model] == splane[e][0]) {
       				carcost[vehicleid] = 500000;
   	        	}
			}
			for(new f=0; f<2; f++) {
     			if(VehicleInfo[vehicleid][model] == mplane[f][0]) {
       					carcost[vehicleid] = 1500000;
   	    	    }
			}
			for(new v=0; v<2; v++) {
     			if(VehicleInfo[vehicleid][model] == lplane[v][0]) {
       				carcost[vehicleid] = 2000000;
   	    	    }
			}
			for(new n=0; n<4; n++) {
     			if(VehicleInfo[vehicleid][model] == milair[n][0]) {
       				carcost[vehicleid] = 4000000;
   	        	}
			}
			for(new j=0; j<4; j++) {
     			if(VehicleInfo[vehicleid][model] == sheli[j][0]) {
       				carcost[vehicleid] = 750000;
   	        	}
			}
			for(new k=0; k<3; k++) {
     			if(VehicleInfo[vehicleid][model] == lheli[k][0]) {
       				carcost[vehicleid] = 1250000;
   	        	}
			}
			VehicleInfo[vehicleid][vehiclecost] = carcost[vehicleid];
			VehicleInfo[vehicleid][vused] = 0;
			VehicleInfo[vehicleid][bought] = 0;
			VehicleInfo[vehicleid][secure] = 0;
			VehicleInfo[vehicleid][asecure] = 0;
			VehicleInfo[vehicleid][buybar] = 0;
			VehicleInfo[vehicleid][mod1] = 0;
			VehicleInfo[vehicleid][mod2] = 0;
			VehicleInfo[vehicleid][mod3] = 0;
			VehicleInfo[vehicleid][mod4] = 0;
			VehicleInfo[vehicleid][mod5] = 0;
			VehicleInfo[vehicleid][mod6] = 0;
			VehicleInfo[vehicleid][mod7] = 0;
			VehicleInfo[vehicleid][mod8] = 0;
			VehicleInfo[vehicleid][mod9] = 0;
			VehicleInfo[vehicleid][mod10] = 0;
			VehicleInfo[vehicleid][mod11] = 0;
			VehicleInfo[vehicleid][mod12] = 0;
			VehicleInfo[vehicleid][mod13] = 0;
			VehicleInfo[vehicleid][mod14] = 0;
			VehicleInfo[vehicleid][mod15] = 0;
			VehicleInfo[vehicleid][mod16] = 0;
			VehicleInfo[vehicleid][mod17] = 0;
			VehicleInfo[vehicleid][paintjob] = -1;
			strmid(VehicleInfo[vehicleid][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
            strmid(VehicleInfo[vehicleid][name], VehicleName[GetVehicleModel(vehicleid)-400][0], 0, strlen(VehicleName[GetVehicleModel(vehicleid)-400][0]), 255);
			new addmess[256];
			format(addmess,sizeof(addmess),"--:: Vehicle %d (%s) successfully spawned ::--",vehicleid,VehicleInfo[vehicleid][name]);
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

public OnPlayerSpawn(playerid)
{
    SetPlayerPos(playerid,2040.0520,1319.2799,14.3779);
	GivePlayerMoney(playerid,5000000);
}

public Fill()
 {
  for(new i=0;i<MAX_PLAYERS;i++)
   {
	if(Filling[i] == 1)
	  {
        Gas[GetPlayerVehicleID(i)]++;
        GivePlayerMoney(i,-2);
      }
   }
  return 1;
 }

stock LoadVehicles()
{
	if(fexist(V_FILE_SAVE)) {
        new SplitDiv[99][V_LIMIT];
		new filestring[256];
		new File: file = fopen(V_FILE_SAVE, io_read);
		if (file) {
	    	for(new vehicleid = 1;vehicleid<=vehcount;vehicleid++)
			{
		    	fread(file, filestring);
				split(filestring, SplitDiv, ',');
				VehicleInfo[vehicleid][model] = strval(SplitDiv[0]);
				VehicleInfo[vehicleid][x_spawn] = floatstr(SplitDiv[1]);
				VehicleInfo[vehicleid][y_spawn] = floatstr(SplitDiv[2]);
				VehicleInfo[vehicleid][z_spawn] = floatstr(SplitDiv[3]);
				VehicleInfo[vehicleid][za_spawn] = floatstr(SplitDiv[4]);
				VehicleInfo[vehicleid][color_1] = strval(SplitDiv[5]);
				VehicleInfo[vehicleid][color_2] = strval(SplitDiv[6]);
				VehicleInfo[vehicleid][vehiclecost] = strval(SplitDiv[7]);
				VehicleInfo[vehicleid][bought] = strval(SplitDiv[8]);
				VehicleInfo[vehicleid][secure] = strval(SplitDiv[9]);
				VehicleInfo[vehicleid][asecure] = strval(SplitDiv[10]);
				VehicleInfo[vehicleid][vused] = 0;
				VehicleInfo[vehicleid][buybar] = strval(SplitDiv[12]);
				VehicleInfo[vehicleid][mod1] = strval(SplitDiv[13]);
				VehicleInfo[vehicleid][mod2] = strval(SplitDiv[14]);
				VehicleInfo[vehicleid][mod3] = strval(SplitDiv[15]);
				VehicleInfo[vehicleid][mod4] = strval(SplitDiv[16]);
				VehicleInfo[vehicleid][mod5] = strval(SplitDiv[17]);
				VehicleInfo[vehicleid][mod6] = strval(SplitDiv[18]);
				VehicleInfo[vehicleid][mod7] = strval(SplitDiv[19]);
				VehicleInfo[vehicleid][mod8] = strval(SplitDiv[20]);
				VehicleInfo[vehicleid][mod9] = strval(SplitDiv[21]);
				VehicleInfo[vehicleid][mod10] = strval(SplitDiv[22]);
				VehicleInfo[vehicleid][mod11] = strval(SplitDiv[23]);
				VehicleInfo[vehicleid][mod12] = strval(SplitDiv[24]);
				VehicleInfo[vehicleid][mod13] = strval(SplitDiv[25]);
				VehicleInfo[vehicleid][mod14] = strval(SplitDiv[26]);
				VehicleInfo[vehicleid][mod15] = strval(SplitDiv[27]);
				VehicleInfo[vehicleid][mod16] = strval(SplitDiv[28]);
				VehicleInfo[vehicleid][mod17] = strval(SplitDiv[29]);
				VehicleInfo[vehicleid][paintjob] = strval(SplitDiv[32]);
				strmid(VehicleInfo[vehicleid][owner], SplitDiv[30], 0, strlen(SplitDiv[30]), 255);
				strmid(VehicleInfo[vehicleid][name], SplitDiv[31], 0, strlen(SplitDiv[31]), 255);
			 	CreateVehicle(VehicleInfo[vehicleid][model], VehicleInfo[vehicleid][x_spawn], VehicleInfo[vehicleid][y_spawn], VehicleInfo[vehicleid][z_spawn], VehicleInfo[vehicleid][za_spawn], VehicleInfo[vehicleid][color_1], VehicleInfo[vehicleid][color_2],20000);
                onsys[vehicleid] = 1;
				new addmess[256];
				format(addmess,sizeof(addmess),"--:: Vehicle %d (%s) successfully Loaded and placed - owner: %s ::--",vehicleid,VehicleInfo[vehicleid][name],VehicleInfo[vehicleid][owner]);
				print(addmess);
			}
		}
		fclose(file);
	}
	else {
		SetupVehiclesFile();
	}
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

stock ModVehicle(vehicleid)
{
    new tuned2 = 0;
	if(VehicleInfo[vehicleid][mod1] != 0) {
		AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod1]);
		tuned2 = 1;
	}
	if(VehicleInfo[vehicleid][mod2] != 0) {
		AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod2]);
		tuned2 = 1;
	}
	if(VehicleInfo[vehicleid][mod3] != 0) {
		AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod3]);
		tuned2 = 1;
	}
	if(VehicleInfo[vehicleid][mod4] != 0) {
		AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod4]);
		tuned2 = 1;
	}
	if(VehicleInfo[vehicleid][mod5] != 0) {
		AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod5]);
		tuned2 = 1;
	}
	if(VehicleInfo[vehicleid][mod6] != 0) {
		AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod6]);
		tuned2 = 1;
	}
	if(VehicleInfo[vehicleid][mod7] != 0) {
		AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod7]);
		tuned2 = 1;
	}
	if(VehicleInfo[vehicleid][mod8] != 0) {
		AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod8]);
		tuned2 = 1;
 	}
	if(VehicleInfo[vehicleid][mod9] != 0) {
		AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod9]);
		tuned2 = 1;
	}
	if(VehicleInfo[vehicleid][mod10] != 0) {
		AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod10]);
		tuned2 = 1;
	}
	if(VehicleInfo[vehicleid][mod11] != 0) {
		AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod11]);
		tuned2 = 1;
	}
	if(VehicleInfo[vehicleid][mod12] != 0) {
		AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod12]);
		tuned2 = 1;
	}
	if(VehicleInfo[vehicleid][mod13] != 0) {
		AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod13]);
		tuned2 = 1;
	}
	if(VehicleInfo[vehicleid][mod14] != 0) {
		AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod14]);
		tuned2 = 1;
	}
	if(VehicleInfo[vehicleid][mod15] != 0) {
		AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod15]);
		tuned2 = 1;
	}
	if(VehicleInfo[vehicleid][mod16] != 0) {
		AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod16]);
		tuned2 = 1;
	}
	if(VehicleInfo[vehicleid][mod17] != 0) {
		AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod17]);
		tuned2 = 1;
	}
	if(VehicleInfo[vehicleid][color_1] > -1 || VehicleInfo[vehicleid][color_2] > -1) {
		ChangeVehicleColor(vehicleid,VehicleInfo[vehicleid][color_1],VehicleInfo[vehicleid][color_2]);
		tuned2 = 1;
 	}
	if(VehicleInfo[vehicleid][paintjob] > -1) {
		ChangeVehiclePaintjob(vehicleid,VehicleInfo[vehicleid][paintjob]);
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

public OnPlayerConnect(playerid)
{
    for(new i=0;i<20;i++) {
		SetPlayerMapIcon(playerid,i,Pickup[i][0],Pickup[i][1],Pickup[i][2],51,1);
	}
    speedo[playerid] = 1;
	Filling[playerid] = 0;
	PlInfo[playerid][vhpb] = 1;
	new string[256],playername[256];
	GetPlayerName(playerid, playername, sizeof(playername));
	format(string, sizeof(string), "Welcome %s, this server is using tAxI's Xtreme Vehicle Management Filterscript!!", playername);
	SendClientMessage(playerid, COLOR_ORANGE, string);
	LoadPlayer(playerid);
}

stock LoadPlayer(playerid)
{
	new fname[256],playername[256],filestring[256];
 	new SplitDiv[DIV_AMOUNT][V_LIMIT];
	new File: file;
	GetPlayerName(playerid, playername, sizeof(playername));
 	format(fname,sizeof(fname),P_FILE,udb_encode(playername));
 	if(fexist(fname)) {
 	    file = fopen(fname, io_read);
		if (file) {
 			fread(file, filestring);
			split(filestring, SplitDiv, ',');
			strmid(PlInfo[playerid][name], SplitDiv[0], 0, strlen(SplitDiv[0]), 255);
			PlInfo[playerid][vowned] = strval(SplitDiv[1]);
			PlInfo[playerid][vowner] = strval(SplitDiv[2]);
		}
 	}
	else {
	    file = fopen(fname, io_write);
	    fclose(file);
	    file = fopen(fname, io_write);
	    if(file) {
	    	format(filestring,sizeof(filestring),"%s,0,0",playername);
	    	fwrite(file,filestring);
	    	fclose(file);
		}
	    file = fopen(fname, io_read);
		if (file) {
 			fread(file, filestring);
			split(filestring, SplitDiv, ',');
			strmid(PlInfo[playerid][name], SplitDiv[0], 0, strlen(SplitDiv[0]), 255);
			PlInfo[playerid][vowned] = strval(SplitDiv[1]);
			PlInfo[playerid][vowner] = strval(SplitDiv[2]);
			fclose(file);
		}
	}
}

stock SavePlayer(playerid)
{
    new fname[256],playername[256],filestring[256];
 	new SplitDiv[DIV_AMOUNT][V_LIMIT];
	new File: file;
	GetPlayerName(playerid, playername, sizeof(playername));
 	format(fname,sizeof(fname),P_FILE,udb_encode(playername));
 	file = fopen(fname, io_write);
  	if(file) {
  		format(filestring,sizeof(filestring),"%s,%d,%d",playername,PlInfo[playerid][vowned],PlInfo[playerid][vowner]);
   		fwrite(file,filestring);
	   	fclose(file);
	}
   	file = fopen(fname, io_read);
	if (file) {
		fread(file, filestring);
		split(filestring, SplitDiv, ',');
		strmid(PlInfo[playerid][name], SplitDiv[0], 0, strlen(SplitDiv[0]), 255);
		PlInfo[playerid][vowned] = strval(SplitDiv[1]);
		PlInfo[playerid][vowner] = strval(SplitDiv[2]);
		fclose(file);
	}
}

stock ResetOfflinePlayerFile(pname[])
{
    new fname[256],intname[256];
    format(intname,sizeof(intname),"%s",pname);
    format(fname,sizeof(fname),P_FILE,udb_encode(intname));
	new filestring[256];
	new File: file = fopen(fname, io_write);
  	if(file) {
  		format(filestring,sizeof(filestring),"%s,0,0",pname);
   		fwrite(file,filestring);
	   	fclose(file);
	}
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(onsys[vehicleid] == 1) {
    	for(new d=0; d<3; d++) {
  			if(GetVehicleModel(vehicleid) == pbike[d][0]) {
 				speedo[playerid] = 2;
       		}
		}
		if(passenger[playerid] == 0) {
    	    if (strcmp(VehicleInfo[vehicleid][owner],PlInfo[playerid][name],false) == 0) {
				new string[256];
				format(string, sizeof(string), "Welcome to your %s %s, please drive carefully!", VehicleInfo[vehicleid][name], PlInfo[playerid][name]);
				SendClientMessage(playerid, COLOR_GREEN, string);

				return 1;
			}
    	    if (strcmp(VehicleInfo[vehicleid][owner],"server",false) == 0) {
                if(VehicleInfo[vehicleid][buybar] == 1) {
                	new string[256];
			        format(string,sizeof(string),"This %s has been set as non-buyable by server administration!", VehicleInfo[vehicleid][name]);
			        SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			        return 1;
			    }
			    new string[256];
    	        format(string, sizeof(string), "This %s is for sale and costs $%d, type /vmenu to see vehicle options.",VehicleInfo[vehicleid][name], VehicleInfo[vehicleid][vehiclecost]);
    	        SendClientMessage(playerid, COLOR_YELLOW, string);
    	        return 1;
			}
   			else {
    	        new string[256];
    	        format(string, sizeof(string), "This %s belongs to %s, and cannot be purchased.", VehicleInfo[vehicleid][name], VehicleInfo[vehicleid][owner]);
    	        SendClientMessage(playerid, COLOR_BRIGHTRED, string);
    	        return 1;
			}
    	}
    }
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER && onsys[GetPlayerVehicleID(playerid)] == 1) {
	    new string[256];
        if(VehicleInfo[GetPlayerVehicleID(playerid)][asecure] == 1) {
            if(IsPlayerAdmin(playerid) == 1) {
				format(carmess,sizeof(carmess),"This %s is currently set for admin use only. It will eject anyone who is not an admin.",VehicleInfo[GetPlayerVehicleID(playerid)][name]);
                SendClientMessage(playerid,COLOR_ORANGE,carmess);
 		    	return 1;
			}
     		GetPlayerPos(playerid,ta,tb,tc);
     		SetPlayerPos(playerid,ta,tb,tc+5);
     		RemovePlayerFromVehicle(playerid);
 			format(string, sizeof(string), "This %s has been set to allow admin/moderator control only and you are prohibited from using it.",VehicleInfo[GetPlayerVehicleID(playerid)][name]);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			return 1;
		}
		if(VehicleInfo[GetPlayerVehicleID(playerid)][asecure] == 2) {
		    if(IsPlayerAdmin(playerid) == 1) {
		        format(carmess,sizeof(carmess),"This %s is currently set for admin use only. It will kill anyone who is not an admin.",VehicleInfo[GetPlayerVehicleID(playerid)][name]);
                SendClientMessage(playerid,COLOR_ORANGE,carmess);
 		    	return 1;
			}
			RemovePlayerFromVehicle(playerid);
			SetPlayerHealth(playerid, -999);
 			format(string, sizeof(string), "Server administration has set this %s to kill anyone who try's to drive it...R.I.P loser!",VehicleInfo[GetPlayerVehicleID(playerid)][name]);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "%s just tried to steal an admin only %s and was killed by the security system...R.I.P loser!",PlInfo[playerid][name],VehicleInfo[GetPlayerVehicleID(playerid)][name]);
			SendClientMessageToAll(COLOR_ORANGE, string);
			return 1;
		}
		if(VehicleInfo[GetPlayerVehicleID(playerid)][secure] == 0) {
    	    if (strcmp(VehicleInfo[GetPlayerVehicleID(playerid)][owner],PlInfo[playerid][name],false) == 0) {
			SendClientMessage(playerid, COLOR_GREEN, "Your vehicle security system is currently deactivated.");
		    	return 1;
			}
		}
	 	if(VehicleInfo[GetPlayerVehicleID(playerid)][secure] == 1) {
    	    if (strcmp(VehicleInfo[GetPlayerVehicleID(playerid)][owner],PlInfo[playerid][name],false) == 0) {
			SendClientMessage(playerid, COLOR_GREEN, "Your vehicle security system is currently set to eject intruders.");
		    	return 1;
			}
			if(IsPlayerAdmin(playerid) == 1) {
			    format(string, sizeof(string), "The owner of this %s (%s), has secured this vehicle but as ADMIN you can still use it.",VehicleInfo[GetPlayerVehicleID(playerid)][name],VehicleInfo[GetPlayerVehicleID(playerid)][owner]);
				SendClientMessage(playerid, COLOR_ORANGE, string);
				return 1;
			}
     		GetPlayerPos(playerid,ta,tb,tc);
     		SetPlayerPos(playerid,ta,tb,tc+5);
     		RemovePlayerFromVehicle(playerid);
 			format(string, sizeof(string), "The owner of this %s (%s), has secured this vehicle and you are prohibited from using it.", VehicleInfo[GetPlayerVehicleID(playerid)][name],VehicleInfo[GetPlayerVehicleID(playerid)][owner]);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}
 		if(VehicleInfo[GetPlayerVehicleID(playerid)][secure] == 2) {
    	    if (strcmp(VehicleInfo[GetPlayerVehicleID(playerid)][owner],PlInfo[playerid][name],false) == 0) {
			SendClientMessage(playerid, COLOR_GREEN, "Your vehicle security system is currently set to kill intruders.");
		    	return 1;
			}
			if(IsPlayerAdmin(playerid) == 1) {
			    format(string, sizeof(string), "The owner of this %s (%s), has set the vehicle to kill intruders but as ADMIN you can still use it.", VehicleInfo[GetPlayerVehicleID(playerid)][name],VehicleInfo[GetPlayerVehicleID(playerid)][owner]);
				SendClientMessage(playerid, COLOR_ORANGE, string);
				return 1;
			}
			RemovePlayerFromVehicle(playerid);
			SetPlayerHealth(playerid, -999);
 			format(string, sizeof(string), "The owner of this %s (%s), has set this vehicle to kill anyone who try's to drive it...R.I.P loser!",VehicleInfo[GetPlayerVehicleID(playerid)][name],VehicleInfo[GetPlayerVehicleID(playerid)][owner]);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			format(string, sizeof(string), "%s just tried to steal %s's %s and was killed by the security system...R.I.P loser!",PlInfo[playerid][name],VehicleInfo[GetPlayerVehicleID(playerid)][owner],VehicleInfo[GetPlayerVehicleID(playerid)][name]);
			SendClientMessageToAll(COLOR_LIGHTBLUE, string);
			return 1;
		}
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
    Gas[vehicleid] = 100;
}

public OnVehicleDeath(vehicleid)
{
    if(onsys[vehicleid] == 1) {
    	SetTimerEx("RestartVehicle",11000,0,"i",vehicleid);
    	return 1;
	}
    Gas[vehicleid] = 100;
    return 1;
}

public CallVehicleToPlayer(playerid)
{
	new vehicleid = PlInfo[playerid][vowned];
	new Float:x, Float:y, Float:z, Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid, a);
	x += (3 * floatsin(-a, degrees));
	y += (3 * floatcos(-a, degrees));
    DestroyVehicle(vehicleid);
    onsys[vehicleid] = 1;
	CreateVehicle(VehicleInfo[vehicleid][model],x,y,z-0.35,a+90,VehicleInfo[vehicleid][color_1],VehicleInfo[vehicleid][color_2],1000);
	ModVehicle(PlInfo[playerid][vowned]);
	format(carmess,sizeof(carmess),"Your %s has been successfully transported to your location!",VehicleInfo[vehicleid][name]);
	SendClientMessage(playerid, COLOR_GREEN, carmess);
}

public RestartVehicle(vehicleid)
{
    DestroyVehicle(vehicleid);
    onsys[vehicleid] = 1;
	CreateVehicle(VehicleInfo[vehicleid][model],VehicleInfo[vehicleid][x_spawn],VehicleInfo[vehicleid][y_spawn],VehicleInfo[vehicleid][z_spawn],VehicleInfo[vehicleid][za_spawn],VehicleInfo[vehicleid][color_1],VehicleInfo[vehicleid][color_2],1000);
	Gas[vehicleid] = 100;
	ModVehicle(vehicleid);
}

public OnVehicleMod(vehicleid,componentid)
{
    if(onsys[vehicleid] == 1) {
		SaveComponent(vehicleid,componentid);
	}
	return 1;
}

public OnVehiclePaintjob(vehicleid,paintjobid)
{
    if(onsys[vehicleid] == 1) {
    	SavePaintjob(vehicleid,paintjobid);
	}
	return 1;
}

public OnVehicleRespray(vehicleid,color1,color2)
{
    if(onsys[vehicleid] == 1) {
    	SaveColors(vehicleid,color1,color2);
	}
    return 1;
}

public FuelDown()
 {
  for(new i=0;i<MAX_PLAYERS;i++)
   {
    for(new d=0; d<3; d++) {
  		if(GetVehicleModel(GetPlayerVehicleID(i)) == pbike[d][0]) {
 			return 1;
       }
	}
	if(GetPlayerState(i) == PLAYER_STATE_DRIVER) {
    	Gas[GetPlayerVehicleID(i)]--;
	}
   }
  return 1;
}

public resetcount()
{
	for (new i = 0; i < MAX_PLAYERS; i ++)
	{
		if (IsPlayerConnected(i)) Count[i] = 0;
	}
}

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



public CheckGas()
 {
  new string[256];
  for(new i=0;i<MAX_PLAYERS;i++)
   {
      if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i))
       {
          if(speedo[i] == 1 && aMessage[i] == 0 && Count[i] == 0) {
            if(onsys[i] == 1) {
	        	new Float:x,Float:y,Float:z;
            	new Float:distance,value;
            	new filename[256];
            	format(filename, sizeof(filename), "%d", GetPlayerVehicleID(i));
            	GetPlayerPos(i, x, y, z);
            	distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
            	value = floatround(distance * 11000);
            	format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~Vehicle: ~g~%s~n~~b~MpH: ~g~%d ~r~/ ~b~KpH: ~g~%d ~n~~r~Fuel: ~g~%d/100",VehicleInfo[GetPlayerVehicleID(i)][name],floatround(value/2200),floatround(value/1400),Gas[GetPlayerVehicleID(i)]);
	        	GameTextForPlayer(i,string,850,3);
            	SavePlayerPos[i][LastX] = x;
            	SavePlayerPos[i][LastY] = y;
            	SavePlayerPos[i][LastZ] = z;
			}
			else {
			    new Float:x,Float:y,Float:z;
            	new Float:distance,value;
            	new filename[256];
            	format(filename, sizeof(filename), "%d", GetPlayerVehicleID(i));
            	GetPlayerPos(i, x, y, z);
            	distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
            	value = floatround(distance * 11000);
            	format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~b~MpH: ~g~%d ~r~/ ~b~KpH: ~g~%d ~n~~r~Fuel: ~g~%d/100",VehicleInfo[GetPlayerVehicleID(i)][name],floatround(value/2200),floatround(value/1400),Gas[GetPlayerVehicleID(i)]);
	        	GameTextForPlayer(i,string,850,3);
            	SavePlayerPos[i][LastX] = x;
            	SavePlayerPos[i][LastY] = y;
            	SavePlayerPos[i][LastZ] = z;
			}
		}
		if(speedo[i] == 2 && aMessage[i] == 0 && Count[i] == 0) {
		    if(onsys[i] == 1) {
	        	new Float:x,Float:y,Float:z;
            	new Float:distance,value;
            	new filename[256];
            	format(filename, sizeof(filename), "%d", GetPlayerVehicleID(i));
            	GetPlayerPos(i, x, y, z);
            	distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
            	value = floatround(distance * 11000);
            	format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~Vehicle: ~g~%s~n~MpH: ~g~%d ~r~/ ~b~KpH: ~g~%d ~n~~g~Fuel: ~r~N/A",VehicleInfo[GetPlayerVehicleID(i)][name],floatround(value/2200),floatround(value/1400));
	        	GameTextForPlayer(i,string,850,3);
            	SavePlayerPos[i][LastX] = x;
            	SavePlayerPos[i][LastY] = y;
            	SavePlayerPos[i][LastZ] = z;
			}
			else {
			    new Float:x,Float:y,Float:z;
            	new Float:distance,value;
            	new filename[256];
            	format(filename, sizeof(filename), "%d", GetPlayerVehicleID(i));
            	GetPlayerPos(i, x, y, z);
            	distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
            	value = floatround(distance * 11000);
            	format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~MpH: ~g~%d ~r~/ ~b~KpH: ~g~%d ~n~~g~Fuel: ~r~N/A",VehicleInfo[GetPlayerVehicleID(i)][name],floatround(value/2200),floatround(value/1400));
	        	GameTextForPlayer(i,string,850,3);
            	SavePlayerPos[i][LastX] = x;
            	SavePlayerPos[i][LastY] = y;
            	SavePlayerPos[i][LastZ] = z;
			}
			}
		   if(Gas[GetPlayerVehicleID(i)] == 0 && messaged[i] == 0 && Filling[i] == 0)
		   {
			 format(carmess, sizeof(carmess), "Your %s's fuel has dropped to 0% and it was towed away. Enjoy the walk!",VehicleInfo[GetPlayerVehicleID(i)][name]);
			 SendClientMessage(i,COLOR_BRIGHTRED,carmess);
			 messaged[i] = 1;
			 Gas[GetPlayerVehicleID(i)] = 100;
			 SetVehicleToRespawn(GetPlayerVehicleID(i));
			 SetTimer("resetmessage",7000,0);
			 return 1;
		   }
		   if(GetPlayerMoney(i) <= 2 && Filling[i] == 1) {
		    Filling[i] = 0;
			 SendClientMessage(i,COLOR_BRIGHTRED, "You do not have sufficient money to continue filling your vehicle!");
			 return 1;
		   }
	   }
   }
  return 1;
 }

public fillcheck()
{
	for(new i=0;i<MAX_PLAYERS;i++) {
		if(Gas[GetPlayerVehicleID(i)] > 99 && Filling[i] == 1)
		   {
			 Filling[i] = 0;
			 format(carmess, sizeof(carmess), "Your %s's tank is now full. Have a nice day!",VehicleInfo[GetPlayerVehicleID(i)][name]);
             SendClientMessage(i,COLOR_GREEN,carmess);
		   }
		if(CloseToGas(i) == 999 && Filling[i] == 1) {
		    Filling[i] = 0;
		    SendClientMessage(i,COLOR_BRIGHTRED,"You left the refuelling area and the tank is not yet full!");
		}
	}
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	passenger[playerid] = 0;
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
   new cmd[256];
   new idx;
   cmd = strtok(cmdtext, idx);

	if(strcmp(cmd, "/vmenu", true) == 0)
	{
	    TogglePlayerControllable(playerid, false);
		ShowMenuForPlayer(vehiclemain, playerid);
		return 1;
	}
	if(strcmp(cmd, "/vcredits", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "----- tAxI's Xtreme Vehicle Management FS <::> By tAxI -----");
		SendClientMessage(playerid, COLOR_YELLOW, "Script designer and concept - tAxI aka Necrioss (email <::> cptnsausage@hotmail.com)");
		SendClientMessage(playerid, COLOR_YELLOW, "Original code for Vehicle HP bar was made by Mr-Tape - Highly modified by tAxI aka Necrioss");
		SendClientMessage(playerid, COLOR_GREEN, "If you wish to use this script or any parts of it in your own gamemode please fee free but you must GIVE CREDIT!!!");
		return 1;
	}
	if(strcmp(cmd, "/vhelp", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "----- tAxI's Xtreme Vehicle Management FS <::> By tAxI -----");
		SendClientMessage(playerid, COLOR_YELLOW, "For VEHICLE help, please type /vehiclehelp.");
		SendClientMessage(playerid, COLOR_YELLOW, "For FUEL SYSTEM info and the location of the refuelling stations, please type /fuelhelp.");
		SendClientMessage(playerid, COLOR_ORANGE, "Type /vcredits to see a list of the ppl who contributed to this script.");
		return 1;
	}
	if(strcmp(cmd, "/fuelhelp", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Fuel System Help ----------");
		SendClientMessage(playerid, COLOR_YELLOW, "Fuel station areas are located in all the fuel stations for ground vehicles!");
		SendClientMessage(playerid, COLOR_YELLOW, "For airborne and large vehicles, the refuelling areas are located in all of the airports");
		SendClientMessage(playerid, COLOR_YELLOW, "the areas will be marked on ur map by a small grey vehicle icon when u get nearer to them");
		SendClientMessage(playerid, COLOR_YELLOW, "Refuel vehicle - use the vehicle control panel - /vmenu");
		return 1;
	}
	if(strcmp(cmd, "/vehiclehelp", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Vehicle Help ----------");
		SendClientMessage(playerid, COLOR_YELLOW, "To see the vehicle control panel simply type /vmenu - vehicle admin is managed from this as well.");
		return 1;
	}
	return 0;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
 	if(pickupid < 20) {
    	GameTextForPlayer(playerid,"~g~Type ~r~/fuelhelp ~g~to see how to refill.",5000,3);
		return 1;
	}
	return 1;
}

stock CloseToGas(playerid)
{
    new Float:maxdis = 15.0;
	new Float:ppos[3];
    GetPlayerPos(playerid, ppos[0], ppos[1], ppos[2]);
    for(new i = 0;i<16;i++) {
    	if (ppos[0] >= floatsub(Pickup[i][0], maxdis) && ppos[0] <= floatadd(Pickup[i][0], maxdis)
    	&& ppos[1] >= floatsub(Pickup[i][1], maxdis) && ppos[1] <= floatadd(Pickup[i][1], maxdis)
    	&& ppos[2] >= floatsub(Pickup[i][2], maxdis) && ppos[2] <= floatadd(Pickup[i][2], maxdis))
    	{
        	return i;
    	}
	}
	maxdis = 20.0;
	for(new i = 16;i<20;i++) {
    	if (ppos[0] >= floatsub(Pickup[i][0], maxdis) && ppos[0] <= floatadd(Pickup[i][0], maxdis)
    	&& ppos[1] >= floatsub(Pickup[i][1], maxdis) && ppos[1] <= floatadd(Pickup[i][1], maxdis)
    	&& ppos[2] >= floatsub(Pickup[i][2], maxdis) && ppos[2] <= floatadd(Pickup[i][2], maxdis))
    	{
        	return i;
    	}
	}
	return 999;
}

public SaveComponent(vehicleid,componentid)
{
    new playerid = GetDriverID(vehicleid);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
    	    if (strcmp(VehicleInfo[vehicleid][owner],PlInfo[playerid][name],false) == 0) {
				for(new s=0; s<20; s++) {
     				if(componentid == spoiler[s][0]) {
       					VehicleInfo[vehicleid][mod1] = componentid;
   	        		}
				}
				for(new s=0; s<3; s++) {
     				if(componentid == nitro[s][0]) {
       					VehicleInfo[vehicleid][mod2] = componentid;
   	        		}
				}
				for(new s=0; s<23; s++) {
     				if(componentid == fbumper[s][0]) {
       					VehicleInfo[vehicleid][mod3] = componentid;
   	        		}
				}
				for(new s=0; s<22; s++) {
     				if(componentid == rbumper[s][0]) {
       					VehicleInfo[vehicleid][mod4] = componentid;
   	        		}
				}
				for(new s=0; s<28; s++) {
     				if(componentid == exhaust[s][0]) {
       					VehicleInfo[vehicleid][mod5] = componentid;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == bventr[s][0]) {
       					VehicleInfo[vehicleid][mod6] = componentid;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == bventl[s][0]) {
       					VehicleInfo[vehicleid][mod7] = componentid;
   	        		}
				}
				for(new s=0; s<4; s++) {
     				if(componentid == bscoop[s][0]) {
       					VehicleInfo[vehicleid][mod8] = componentid;
   	        		}
				}
				for(new s=0; s<13; s++) {
     				if(componentid == rscoop[s][0]) {
       					VehicleInfo[vehicleid][mod9] = componentid;
   	        		}
				}
				for(new s=0; s<21; s++) {
     				if(componentid == lskirt[s][0]) {
       					VehicleInfo[vehicleid][mod10] = componentid;
   	        		}
				}
				for(new s=0; s<21; s++) {
     				if(componentid == rskirt[s][0]) {
       					VehicleInfo[vehicleid][mod11] = componentid;
   	        		}
				}
				for(new s=0; s<1; s++) {
     				if(componentid == hydraulics[s][0]) {
       					VehicleInfo[vehicleid][mod12] = componentid;
   	        		}
				}
				for(new s=0; s<1; s++) {
     				if(componentid == base[s][0]) {
       					VehicleInfo[vehicleid][mod13] = componentid;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == rbbars[s][0]) {
       					VehicleInfo[vehicleid][mod14] = componentid;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == fbbars[s][0]) {
       					VehicleInfo[vehicleid][mod15] = componentid;
   	        		}
				}
				for(new s=0; s<17; s++) {
     				if(componentid == wheels[s][0]) {
       					VehicleInfo[vehicleid][mod16] = componentid;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == lights[s][0]) {
       					VehicleInfo[vehicleid][mod17] = componentid;
   	        		}
				}
				return 1;
			}
	}
	return 0;
}

stock SavePaintjob(vehicleid,paintjobid)
{
    new playerid = GetDriverID(vehicleid);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
    	    if (strcmp(VehicleInfo[vehicleid][owner],PlInfo[playerid][name],false) == 0) {
				VehicleInfo[vehicleid][paintjob] = paintjobid;
				return 1;
			}
	}
	return 0;
}

stock SaveColors(vehicleid,color1,color2)
{
    new playerid = GetDriverID(vehicleid);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
    	    if (strcmp(VehicleInfo[vehicleid][owner],PlInfo[playerid][name],false) == 0) {
				VehicleInfo[vehicleid][color_1] = color1;
    	        VehicleInfo[vehicleid][color_2] = color2;
				return 1;
			}
	}
	return 0;
}

stock GetDriverID(vehicleid)
{
    for(new i=0; i<V_LIMIT; i++) {
        if(IsPlayerConnected(i)) {
            if(IsPlayerInAnyVehicle(i)) {
                if(GetPlayerVehicleID(i) == vehicleid) {
					return i;
                }
            }
        }
    }
    return -1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:Current = GetPlayerMenu(playerid);
    if(Current == vehiclemain) {
    	switch(row){
        	case 0:ShowMenuForPlayer(playervm, playerid);
        	case 1:ShowMenuForPlayer(adminm, playerid);
        	case 2:{HideMenuForPlayer(Current, playerid);TogglePlayerControllable(playerid, true);}
		}
	}
	else if(Current == playervm) {
	switch(row){
	    case 0:{HideMenuForPlayer(Current, playerid);refuel(playerid);TogglePlayerControllable(playerid, true);}
		case 1:ShowMenuForPlayer(templock, playerid);
		case 2:ShowMenuForPlayer(healthbar, playerid);
		case 3:ShowMenuForPlayer(speedom, playerid);
		case 4:ShowMenuForPlayer(buysell, playerid);
		case 5:{callcar(playerid);HideMenuForPlayer(Current, playerid);TogglePlayerControllable(playerid, true);}
        case 6:{HideMenuForPlayer(Current, playerid);park(playerid);TogglePlayerControllable(playerid, true);}
        case 7:ShowMenuForPlayer(secure1, playerid);
        case 8:ShowMenuForPlayer(vehiclemain, playerid);
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
	    case 0:{HideMenuForPlayer(Current, playerid);dashboardon(playerid);TogglePlayerControllable(playerid, true);}
        case 1:{HideMenuForPlayer(Current, playerid);dashboardoff(playerid);TogglePlayerControllable(playerid, true);}
        case 2:ShowMenuForPlayer(playervm, playerid);
        }
	}
	else if(Current == buysell) {
	switch(row){
	    case 0:{HideMenuForPlayer(Current, playerid);buycar(playerid);TogglePlayerControllable(playerid, true);}
        case 1:{HideMenuForPlayer(Current, playerid);sellcar(playerid);TogglePlayerControllable(playerid, true);}
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
	    case 0:{HideMenuForPlayer(Current, playerid);PlInfo[playerid][vhpb] = 1;TogglePlayerControllable(playerid, true);SendClientMessage(playerid,COLOR_GREEN,"Vehicle HP Bar is now active!");}
	    case 1:{HideMenuForPlayer(Current, playerid);PlInfo[playerid][vhpb] = 0;TogglePlayerControllable(playerid, true);SendClientMessage(playerid,COLOR_BRIGHTRED,"Vehicle HP Bar is now in-active!");}
	    case 2:ShowMenuForPlayer(playervm, playerid);
	    }
	}
}

public OnPlayerExitedMenu(playerid)
{
	TogglePlayerControllable(playerid, true);
}

public OnFilterScriptExit()
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
	return 1;
}

public BackupInfo()
{
	SaveVehicles();
}

public OnPlayerDisconnect(playerid)
{
	SavePlayer(playerid);
	return 1;
}

stock buycar(playerid)
{
		new string[256];
  		if(passenger[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers' seat of this vehicle to buy it!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle in order to buy one!");
			return 1;
		}
		if(VehicleInfo[GetPlayerVehicleID(playerid)][buybar] == 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is currently set as un-buyable!");
			return 1;
		}
    	    if (strcmp(VehicleInfo[GetPlayerVehicleID(playerid)][owner],PlInfo[playerid][name],false) == 0) {
			format(string, sizeof(string), "You already own this %s, %s", VehicleInfo[GetPlayerVehicleID(playerid)][name], PlInfo[playerid][name]);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}
		if(VehicleInfo[GetPlayerVehicleID(playerid)][bought] == 1) {
			format(string, sizeof(string), "This %s is owned by %s, and is not for sale!", VehicleInfo[GetPlayerVehicleID(playerid)][name], VehicleInfo[GetPlayerVehicleID(playerid)][owner]);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}
		if(PlInfo[playerid][vowner] == 1) {
  			SendClientMessage(playerid, COLOR_BRIGHTRED, "You can only own ONE vehicle at a time! You must sell your other vehicle first!");
     		return 1;
		}
			new cash[MAX_PLAYERS];
			cash[playerid] = GetPlayerMoney(playerid);
			if(cash[playerid] >= VehicleInfo[GetPlayerVehicleID(playerid)][vehiclecost]) {
			    new stringa[256];
	   	 		strmid(VehicleInfo[GetPlayerVehicleID(playerid)][owner], PlInfo[playerid][name], 0, strlen(PlInfo[playerid][name]), 255);
                VehicleInfo[GetPlayerVehicleID(playerid)][bought] = 1;
                PlInfo[playerid][vowner] = 1;
                PlInfo[playerid][vowned] = GetPlayerVehicleID(playerid);
				GivePlayerMoney(playerid, -VehicleInfo[GetPlayerVehicleID(playerid)][vehiclecost]);
				format(stringa, sizeof(stringa), "You just bought this %s for $%d. Your %s currently has %d/100 of its fuel remaining!", VehicleInfo[GetPlayerVehicleID(playerid)][name], VehicleInfo[GetPlayerVehicleID(playerid)][vehiclecost],VehicleInfo[GetPlayerVehicleID(playerid)][name],Gas[GetPlayerVehicleID(playerid)]);
				SendClientMessage(playerid, COLOR_GREEN, stringa);
				SavePlayer(playerid);
				return 1;
			}
			if(cash[playerid] < VehicleInfo[GetPlayerVehicleID(playerid)][vehiclecost]) {
			    new string6[256];
				format(string6, sizeof(string6), "You do not have $%d and cannot afford this %s!", VehicleInfo[GetPlayerVehicleID(playerid)][vehiclecost],VehicleInfo[GetPlayerVehicleID(playerid)][name]);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string6);
				return 1;
			}
			return 1;
}

stock sellcar(playerid)
{
        new string[256];
		if(passenger[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers' seat of your vehicle to sell it!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be inside your vehicle in order to sell it");
			return 1;
		}
  		new vehicleID = GetPlayerVehicleID(playerid);
  		if (strcmp(VehicleInfo[vehicleID][owner],PlInfo[playerid][name],false) == 0) {
			SetVehicleToRespawn(vehicleID);
			SetVehicleVirtualWorld(vehicleID,10);
			SetTimerEx("RestartVehicle",5000,0,"i",vehicleID);
    		PlInfo[playerid][vowned] = 0;
			PlInfo[playerid][vowner] = 0;
			strmid(VehicleInfo[vehicleID][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
			VehicleInfo[vehicleID][bought] = 0;
			VehicleInfo[vehicleID][secure] = 0;
			GivePlayerMoney(playerid, VehicleInfo[vehicleID][vehiclecost]);
			format(string, sizeof(string), "You just sold your %s for $%d, enjoy the walk!!", VehicleInfo[vehicleID][name], VehicleInfo[vehicleID][vehiclecost]);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			SavePlayer(playerid);
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
		if(passenger[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers seat to use this feature");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle in order to use this feature");
			return 1;
		}
   	    if (IsPlayerAdmin(playerid) == 1) {
    	    if (strcmp(VehicleInfo[GetPlayerVehicleID(playerid)][owner],DEFAULT_OWNER,false) == 0) {
				format(string,sizeof(string),"This %d does not have an owner yet!",VehicleInfo[GetPlayerVehicleID(playerid)][name]);
 				SendClientMessage(playerid,COLOR_ORANGE,string);
				return 1;
			}
			new file[256];
			new vehicleID = GetPlayerVehicleID(playerid);
			SetVehicleToRespawn(vehicleID);
			SetVehicleVirtualWorld(vehicleID,10);
			SetTimerEx("RestartVehicle",5000,0,"i",vehicleID);
			format(file,sizeof(file),P_FILE,udb_encode(VehicleInfo[vehicleID][owner]));
			if(fexist(file)) {
			    tempid[playerid] = IsPlayerNameOnline(VehicleInfo[vehicleID][owner]);
			    if(tempid[playerid] >= 0 && tempid[playerid] <= MAX_PLAYERS) {
			        strmid(VehicleInfo[vehicleID][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
					PlInfo[tempid[playerid]][vowned] = 0;
					PlInfo[tempid[playerid]][vowner] = 0;
					VehicleInfo[vehicleID][bought] = 0;
					format(string, sizeof(string), "You just sold %s's %s.", PlInfo[tempid[playerid]][name], VehicleInfo[vehicleID][name]);
					SendClientMessage(playerid, COLOR_ORANGE, string);
					format(string, sizeof(string), "Admin (%s) has just sold your %s!", PlInfo[playerid][name], VehicleInfo[vehicleID][name]);
                    SendClientMessage(tempid[playerid], COLOR_ORANGE, string);
					return 1;
				}
				else {
				    ResetOfflinePlayerFile(VehicleInfo[vehicleID][owner]);
					format(string, sizeof(string), "You just sold %s's %s.", VehicleInfo[vehicleID][owner], VehicleInfo[vehicleID][name]);
					SendClientMessage(playerid, COLOR_ORANGE, string);
                    VehicleInfo[vehicleID][bought] = 0;
					strmid(VehicleInfo[vehicleID][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
					return 1;
				}
			}
			if(!fexist(file)) {
				format(string, sizeof(string), "You just sold %s's %s. The player file was not found and cannot be altered.", VehicleInfo[vehicleID][owner], VehicleInfo[vehicleID][name]);
				SendClientMessage(playerid, COLOR_GREEN, string);
                VehicleInfo[vehicleID][bought] = 0;
				strmid(VehicleInfo[vehicleID][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
				return 1;
			}
		}
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not a server administrator and cannot use this feature!");
		return 1;
}

stock setbuy(playerid)
{
        new string[256];
		if(passenger[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers seat to use this feature");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle in order to use this feature");
			return 1;
		}
		if(VehicleInfo[GetPlayerVehicleID(playerid)][buybar] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is already set as buyable!");
			return 1;
		}
   	    if (IsPlayerAdmin(playerid) == 1) {
   	        if(VehicleInfo[GetPlayerVehicleID(playerid)][buybar] == 1) {
   	        	format(string,sizeof(string),"You have set this %s to buyable!", VehicleInfo[GetPlayerVehicleID(playerid)][name]);
   	        	SendClientMessage(playerid,COLOR_ORANGE,string);
				VehicleInfo[GetPlayerVehicleID(playerid)][buybar] = 0;
				return 1;
			}
		}
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not a server administrator and cannot use this feature!");
		return 1;
}

stock setunbuy(playerid)
{
		new string[256];
		if(passenger[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers seat to use this feature");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle in order to use this feature");
			return 1;
		}
		if(VehicleInfo[GetPlayerVehicleID(playerid)][buybar] == 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is already set as un-buyable!");
			return 1;
		}
   	    if (IsPlayerAdmin(playerid) == 1) {
   	    	VehicleInfo[GetPlayerVehicleID(playerid)][bought] = 0;
			VehicleInfo[GetPlayerVehicleID(playerid)][secure] = 0;
			VehicleInfo[GetPlayerVehicleID(playerid)][buybar] = 1;
    	    if (strcmp(VehicleInfo[GetPlayerVehicleID(playerid)][owner],DEFAULT_OWNER,false) == 0) {
                strmid(VehicleInfo[GetPlayerVehicleID(playerid)][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
				format(string,sizeof(string),"You have set this %s to non-buyable!",VehicleInfo[GetPlayerVehicleID(playerid)][name]);
 				SendClientMessage(playerid,COLOR_ORANGE,string);
				return 1;
			}
			new file[256];
			format(file,sizeof(file),P_FILE,VehicleInfo[GetPlayerVehicleID(playerid)][owner]);
			if(fexist(file)) {
			    tempid[playerid] = IsPlayerNameOnline(VehicleInfo[GetPlayerVehicleID(playerid)][owner]);
			    if(tempid[playerid] >= 0 || tempid[playerid] <= MAX_PLAYERS) {
			        strmid(VehicleInfo[GetPlayerVehicleID(playerid)][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
					PlInfo[tempid[playerid]][vowned] = 0;
					PlInfo[tempid[playerid]][vowner] = 0;
					format(string, sizeof(string), "You just sold %s's %s and set it to non-buyable.", PlInfo[tempid[playerid]][name], VehicleInfo[GetPlayerVehicleID(playerid)][name]);
					SendClientMessage(playerid, COLOR_ORANGE, string);
					format(string, sizeof(string), "Admin (%s) has just sold your %s and set it to non-buyable!", PlInfo[playerid][name], VehicleInfo[GetPlayerVehicleID(playerid)][name]);
                    SendClientMessage(tempid[playerid], COLOR_ORANGE, string);
					return 1;
				}
				else {
				    ResetOfflinePlayerFile(VehicleInfo[GetPlayerVehicleID(playerid)][owner]);
					format(string, sizeof(string), "You just sold %s's %s and set it to non-buyable.", VehicleInfo[GetPlayerVehicleID(playerid)][owner], VehicleInfo[GetPlayerVehicleID(playerid)][name]);
					SendClientMessage(playerid, COLOR_ORANGE, string);
					strmid(VehicleInfo[GetPlayerVehicleID(playerid)][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
					return 1;
				}
			}
			if(!fexist(file)) {
				format(string, sizeof(string), "You just sold %s's %s and set it to non-buyable. The player file was not found and cannot be altered.", VehicleInfo[GetPlayerVehicleID(playerid)][owner], VehicleInfo[GetPlayerVehicleID(playerid)][name]);
				SendClientMessage(playerid, COLOR_ORANGE, string);
				strmid(VehicleInfo[GetPlayerVehicleID(playerid)][owner], DEFAULT_OWNER, 0, strlen(DEFAULT_OWNER), 255);
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
		    new filename[256];
			format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));

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
			format(lockmess,sizeof(lockmess),"Your %s is now locked.",VehicleInfo[GetPlayerVehicleID(playerid)][name]);
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
		    new filename[256];
			format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));

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
			format(lockmess,sizeof(lockmess),"Your %s is now unlocked.",VehicleInfo[GetPlayerVehicleID(playerid)][name]);
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
  		if(VehicleInfo[GetPlayerVehicleID(playerid)][buybar] == 1) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is un-buyable and these features will not work!");
			return 1;
    	}
		if(PlInfo[playerid][vowner] == 0) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "You must first own a vehicle before you can use this feature!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid)) {
    	    if (strcmp(VehicleInfo[GetPlayerVehicleID(playerid)][owner],PlInfo[playerid][name],false) == 0) {
				VehicleInfo[GetPlayerVehicleID(playerid)][secure] = 1;
				format(securemess,sizeof(securemess),"You have set your %s as secure, no other player will be able to use it even when you are offline.", VehicleInfo[GetPlayerVehicleID(playerid)][name]);
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
		if (IsPlayerAdmin(playerid) == 1) {
			if(IsPlayerInAnyVehicle(playerid)) {
				VehicleInfo[GetPlayerVehicleID(playerid)][asecure] = 1;
				format(securemess,sizeof(securemess),"You have set this %s as admin only.", VehicleInfo[GetPlayerVehicleID(playerid)][name]);
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
		if(IsPlayerInAnyVehicle(playerid)) {
            if (IsPlayerAdmin(playerid) == 1) {
				VehicleInfo[GetPlayerVehicleID(playerid)][asecure] = 2;
				format(securemess,sizeof(securemess),"You have set this %s as admin only with lethal protection.", VehicleInfo[GetPlayerVehicleID(playerid)][name]);
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
		if(IsPlayerInAnyVehicle(playerid)) {
            if (IsPlayerAdmin(playerid) == 1) {
                VehicleInfo[GetPlayerVehicleID(playerid)][asecure] = 0;
				format(securemess,sizeof(securemess),"You have set this %s as accessable to everyone.", VehicleInfo[GetPlayerVehicleID(playerid)][name]);
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
  		if(VehicleInfo[GetPlayerVehicleID(playerid)][buybar] == 1) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is un-buyable and these features will not work!");
			return 1;
    	}
		if(PlInfo[playerid][vowner] == 0) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "You must first own a vehicle before you can use this feature!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid)) {
    	    if (strcmp(VehicleInfo[GetPlayerVehicleID(playerid)][owner],PlInfo[playerid][name],false) == 0) {
				VehicleInfo[GetPlayerVehicleID(playerid)][secure] = 0;
				format(securemess,sizeof(securemess),"You have set your %s as accessable to everyone.", VehicleInfo[GetPlayerVehicleID(playerid)][name]);
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
  		if(VehicleInfo[GetPlayerVehicleID(playerid)][buybar] == 1) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is un-buyable and these features will not work!");
			return 1;
    	}
		if(PlInfo[playerid][vowner] == 0) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "You must first own a vehicle before you can use this feature!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid)) {
    	    if (strcmp(VehicleInfo[GetPlayerVehicleID(playerid)][owner],PlInfo[playerid][name],false) == 0) {
				VehicleInfo[GetPlayerVehicleID(playerid)][secure] = 2;
				format(securemess,sizeof(securemess),"You have set your %s as secure with lethal protection, no other player will be able to use it even when you are offline.", VehicleInfo[GetPlayerVehicleID(playerid)][name]);
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
		if(PlayerInterior[playerid] > 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must outside to call a vehicle to you!");
			return 1;
		}
		if(PlInfo[playerid][vowner] == 0) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "You must first own a vehicle before you can use this feature!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "You can't call a vehicle to you if you are in one!");
			return 1;
		}
		if(VehicleInfo[PlInfo[playerid][vowned]][modding] == 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vehicle currently Busy, try again in a few seconds!");
			return 1;
		}
   		for(new i=0; i < MAX_PLAYERS; i++) {
			if (IsPlayerConnected(i) == 1) {
				if (IsPlayerInAnyVehicle(i) == 1) {
					if (GetPlayerVehicleID(i) == PlInfo[playerid][vowned]) {
					    if(GetPlayerInterior(i) == 1) {
					        SendClientMessage(playerid, COLOR_BRIGHTRED, "Vehicle currently Busy, try again in a few seconds!");
							return 1;
					    }
						SendClientMessage(i, COLOR_BRIGHTRED, "This vehicle has been recalled by its owner, enjoy the walk!");
					}
				}
			}
		}
		SendClientMessage(playerid, COLOR_ORANGE, "Your vehicle is on its way, It will take about 5 seconds to get to you...");
		SetVehicleToRespawn(PlInfo[playerid][vowned]);
		SetVehicleVirtualWorld(PlInfo[playerid][vowned],10);
		SetTimerEx("CallVehicleToPlayer",5000,0,"i",playerid);
		return 1;
}

stock park(playerid)
{
  		if(VehicleInfo[GetPlayerVehicleID(playerid)][buybar] == 1) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is un-buyable and these features will not work!");
			return 1;
    	}
		if(PlInfo[playerid][vowner] == 0) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "You must first own a vehicle before you can use this feature!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid)) {
    	    if (strcmp(VehicleInfo[GetPlayerVehicleID(playerid)][owner],PlInfo[playerid][name],false) == 0) {
				new Float:spx,Float:spy,Float:spz;
                new Float:spa;
                GetVehiclePos(GetPlayerVehicleID(playerid),spx,spy,spz);
                GetVehicleZAngle(GetPlayerVehicleID(playerid),spa);
                VehicleInfo[GetPlayerVehicleID(playerid)][x_spawn] = spx;
				VehicleInfo[GetPlayerVehicleID(playerid)][y_spawn] = spy;
				VehicleInfo[GetPlayerVehicleID(playerid)][z_spawn] = spz;
				VehicleInfo[GetPlayerVehicleID(playerid)][za_spawn] = spa;
				format(securemess,sizeof(securemess),"You have just parked your %s at your current location...it will respawn here in future!", VehicleInfo[GetPlayerVehicleID(playerid)][name]);
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

stock refuel(playerid)
{
       if(CloseToGas(playerid) != 999 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	   {
	   	   if(GetPlayerMoney(playerid) >= 20)
	   	   {
             SendClientMessage(playerid,COLOR_YELLOW,"Your vehicle is being refuelled. Please wait for confirmation that your tank is full...");
			 Filling[playerid] = 1;
			 return 1;
		   }
		   if(GetPlayerMoney(playerid) <= 2) {
		    SendClientMessage(playerid,COLOR_BRIGHTRED,"You do not have enough money to use this fuel refill point!");
		    Filling[playerid] = 0;
		    return 1;
		   }

	   }
	   else {
	        SendClientMessage(playerid,COLOR_BRIGHTRED,"You must be driving a vehicle and also near to a refuelling icon to use this feature!");
            SendClientMessage(playerid,COLOR_BRIGHTRED,"These can be found in all Gas Stations or within any airport in San Andreas.");
            SendClientMessage(playerid,COLOR_BRIGHTRED,"Fuel Stations locations are given by the grey vehicle icons on your minimap radar.");
	   }
      return 1;
}

stock dashboardon(playerid)
{
	speedo[playerid] = 1;
	for(new d=0; d<3; d++) {
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == pbike[d][0]) {
			speedo[playerid] = 2;
		}
	}
	SendClientMessage(playerid,COLOR_GREEN,"Your dashboard display is now switched ON!");
	return 1;
}

stock dashboardoff(playerid)
{
	speedo[playerid] = 1;
	SendClientMessage(playerid,COLOR_BRIGHTRED,"Your dashboard display is now switched OFF!");
	return 1;
}
