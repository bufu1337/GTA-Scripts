// City Role Play Made from scratch and coded by Shady91(Marcus) 
// I don't bother with sa-mp no more and I decided to quit it as it's quite boring now.
// my email adress Shady91@freeworld-rp.com
// if you would like anything added or the website you could add my msn, the website/ucp will cost you £10
// Please don't hate about my work, use it enjoy it no bitching please.
// Please keep my credits for this script this is around 70 hours of coding/testing
// the last update made to this code was 05/06/10 SA-MP 0.3a

/*teams:
1 = fireman
2 = cops
3 = medic
4 = civilian
5 = bin man*/

#include <a_samp>
#include <zcmd>
#include <a_sampmysql>
#include "../include/gl_common.inc"
#include <streamer>

//defines
#define MYSQL_HOST "localhost"
#define MYSQL_USER "shady91_server21"
#define MYSQL_PASS "shady9125!!"
#define MYSQL_DB   "shady91_server21"
#define function%0(%1) forward%0(%1); public%0(%1)
#define MAX_STRING 255
#define ResetMoneyBar ResetPlayerMoney
#define UpdateMoneyBar GivePlayerMoney
#define green 0x5AAE51FF
#define red 0xff0000ff
#define yellow 0xF4FB04FF
#define grey 0xABA8B3FF
#define lightred 0xFF330FFF
#define purple 0xC300FFFF
#define darkblue 0x0000FFFF
#define lightblue 0x0DF2B4FF
#define blue 0x3A79C5FF
#define lightgreen 0x4DE718FF
#define orange 0xFF9900FF
#define white 0xFFFFFFAA
#define INVALID_SQL_ID 0
#define MAX_HOUSES 250
#define MAX_BUILDING 250
#define MAX_GANGS 250
#define MAX_LAND 250
#define foreach(%1,%2) for (new %2 = 0; %2 < MAX_PLAYERS; %2++) if (IsPlayerConnected(%2))
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

// team define's
#define fireman 1
#define cop 2
#define med 3
#define civ 4
#define binman 5

// my textdraw varibles
new
Text:FuelText1[2],
Text:NewsText,
Text:Window[2],
Text:NpcTalk,
Text:TimeText,
Text:TimeText1,
Text3D:CrushCarText,
Text3D:LockVehText,
Text:RegBox[5];

// my varibles
new
PickUps[10],
CheckPoints[15],
Vgas[MAX_VEHICLES],
engineOn[MAX_VEHICLES],
SeatTaken[4][MAX_VEHICLES],
totalveh,
FireObject[3],
fireat[2],
squirts,
timer[2],
incoptest,
Reg,
newssent,
injobmeeting,
jcd,
drivingtest,
worldhour,
timeleft,
TargetObject,
Float:space[3],
inguntest,
CrushCar,
glassob,
ooc,
drugs,
jobcenter,
busdriver,
train,
plane,
drugsman,
medic;


enum td
{
	Text:TDSpeedClock[11]
}

new TextDraws[td];

new Text:TextDrawsd[MAX_PLAYERS][5];

enum cInfo
{
	cModel,
	Float:cLocationx,
	Float:cLocationy,
	Float:cLocationz,
	Float:cAngle,
	cColorOne,
	cColorTwo,
	cLocked,
	cOwner[26],
	cValue,
	cOwned,
	cCantSell,
	cModop,
	cVehid,
	cName[15],
	cFuel,
	cMiles,
	cLock,
	cInsurance,
	cJunk,
	cPanel,
	cDoor,
	cLight,
	cTire,
	Float:cHealth,
	cBlown,
	cSQLId,
};
new vehinfo[MAX_VEHICLES][cInfo];

enum hInfo
{
	hSQLId,
	hOwner[MAX_PLAYER_NAME],
	Float:hEntrancex,
	Float:hEntrancey,
	Float:hEntrancez,
	Float:hExitx,
	Float:hExity,
	Float:hExitz,
	hOwned,
	hBuyPrice,
	hInteriorId,
	hLocked,
	hRooms,
	hRenters,
	hRent,
	hRentable,
	hTax,
	hFunds,
	hVirtualWorld,
	hOwnerId,
    hDescription[40],
};

new HouseInfo[MAX_HOUSES][hInfo];

enum gInfo
{
	gSQLId,
	gLeader[MAX_PLAYER_NAME],
    gName[50],
	gMembers,
	gRank,
	gKills,
	gGuns1,
	gGuns2,
	gGuns3,
	gGuns4,
	gGuns5,
	gGuns6,
};

new GangInfo[MAX_GANGS][gInfo];

enum lInfo
{
	lSQLId,
	Float:lx,
	Float:ly,
	Float:lz,
    Float:ldist
};

new LandInfo[MAX_LAND][lInfo];

enum nInfo
{
	nSQLId,
	AllowName[30]
};

new AllowedNames[MAX_LAND][nInfo];

enum bInfo
{
	bSQLId,
	bOwner[MAX_PLAYER_NAME],
	bDescription[50],
	Float:bEntrancex,
	Float:bEntrancey,
	Float:bEntrancez,
	Float:bExitx,
	Float:bExity,
	Float:bExitz,
	bOwned,
	bBuyPrice,
	bInteriorId,
	bLocked,
	bTax,
	bVirtualWorld,
	bOwnerId,
	bShares,
	bRenters,
	bFunds,
};

new BuildingInfo[MAX_BUILDING][bInfo];

new VehicleNames[][] = { "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier",
	"Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy",
	"Solair", "Berkley's RC Van", "Skimmer", "Pcj-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet","BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick",
	"News Chopper", "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick", "Boxvillde", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster",
	"Stunt", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "Nrg-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent", "Bullet", "Clover",
	"Sadler", "Firetruck", "Hustler", "Intruder", "Primo", "CargoBob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma","Savanna", "Bandito", "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune",
	"Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club", "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car", "PoliceCar", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha", "Phoenix",
    "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville", "Tiller", "Utility Trailer"
};

new Skins[303][1] = {
	{1},
	{2},
	{7},
	{9},
	{10},
	{11},
	{12},
	{13},
	{14},
	{15},
	{16},
	{17},
	{18},
	{19},
	{20},
	{21},
	{22},
	{23},
	{24},
	{25},
	{26},
	{27},
	{28},
	{29},
	{30},
	{31},
	{32},
	{33},
	{34},
	{35},
	{36},
	{37},
	{38},
	{39},
	{40},
	{41},
	{42},
	{43},
	{44},
	{45},
	{46},
	{47},
	{48},
	{49},
	{50},
	{51},
	{52},
	{53},
	{54},
	{55},
	{56},
	{57},
	{58},
	{59},
	{60},
	{61},
	{62},
	{63},
	{64},
	{65},
	{66},
	{67},
	{68},
	{69},
	{70},
	{71},
	{72},
	{73},
	{74},
	{75},
	{76},
	{77},
	{78},
	{79},
	{80},
	{81},
	{82},
	{83},
	{84},
	{85},
	{87},// -1
	{88},
	{90},
	{91},//-1
	{92},
	{93},
	{94},
	{95},
	{96},
	{97},
	{98},
	{99},
	{100},
	{101},
	{102},
	{103},
	{104},
	{105},
	{106},
	{107},
	{108},
	{109},
	{110},
	{111},
	{112},
	{113},
	{114},
	{115},
	{116},
	{117},
	{118},//-2
	{119},
	{120},
	{121},
	{122},
	{123},
	{124},
	{125},
	{126},
	{127},
	{128},
	{129},
	{130},
	{131},
	{132},
	{133},
	{134},
	{135},
	{136},
	{137},
	{138},
	{139},
	{140},
	{141},
	{142},
	{143},
	{144},
	{145},
	{146},
	{147},
	{148},
	{149},
	{150},	
	{151},
	{152},
	{153},
	{154},
	{155},
	{156},
	{157},
	{158},
	{159},
	{160},
	{161},
	{162},
	{163},
	{164},
	{165},
	{166},
	{167},
	{168},
	{169},
	{170},
	{171},
	{172},
	{173},
	{174},
	{175},
	{176},
	{177},
	{178},
	{179},
	{180},
	{181},	
	{182},
	{183},
	{184},
	{185},
	{186},
	{187},
	{188},
	{189},
	{190},
	{191},
	{192},
	{193},
	{194},
	{195},
	{196},
	{197},
	{198},
	{199},
	{200},
	{201},
	{202},
	{203},
	{204},
	{205},
	{206},
	{207},//-1
	{209},
	{210},
	{211},
	{212},
	{213},
	{214},
	{215},
	{216},
	{217},
	{218},
	{219},
	{220},
	{221},
	{222},
	{223},
	{224},
	{225},
	{226},
	{227},
	{228},
	{229},
	{230},
	{231},
	{232},
	{233},
	{234},
	{235},
	{236},
	{237},
	{238},
	{239},
	{240},
	{241},
	{242},
	{209},
	{210},
	{211},
	{212},
	{213},
	{214},
	{215},
	{216},
	{217},
	{218},
	{219},
	{220},
	{221},
	{222},
	{223},
	{224},
	{225},
	{226},
	{227},
	{228},
	{229},
	{230},
	{231},
	{232},
	{233},
	{234},
	{235},
	{236},
	{237},
	{238},
	{239},
	{240},
	{241},
	{242},
	{243},
	{244},
	{245},
	{246},
	{247},
	{248},
	{249},
	{250},
	{251},
	{252},
	{253},
	{254},
	{256},
	{257},
	{258},
	{259},
	{260},
	{261},
	{262},
	{263},//-4
	{268},
	{269},
	{270},
	{271},
	{272},// -15
	{290},
	{291},
	{292},
	{293},
	{294},
	{295},
	{296},
	{297},
	{298},
	{299}
};

new Float:FireSticks[15][6] = {
	{2449.0471191406, -1639.1333007813, 14.41983795166, 89.990020751953, 0.0, 0.0},
	{2454.4111328125, -1639.1062011719, 14.365441322327, 89.989013671875, 0.0, 0.0},
	{2453.9240722656, -1639.0361328125, 15.058841705322, 89.989013671875, 0.0, 0.0},
	{2390.8957519531, -1644.0184326172, 13.75511932373, 89.325012207031, 0.0, 0.0},
	{2398.5163574219, -1643.9084472656, 13.871890068054, 89.324340820313, 0.0, 0.0},
	{2393.0783691406, -1644.9519042969, 16.506265640259, 89.324340820313, 0.0, 0.0},
	{2326.1303710938, -1684.4464111328, 15.102566719055, 89.324340820313, 0.0, 93.745056152344},
	{2326.0961914063, -1687.1953125, 15.182246208191, 89.31884765625, 0.0, 93.740844726563},
	{2324.8005371094, -1682.1484375, 14.479714393616, 89.31884765625, 0.0, 93.740844726563},
	{2311.447265625, -1712.376953125, 15.319143295288, 89.31884765625, 0.0, 358.10095214844},
	{2306.0783691406, -1712.2794189453, 15.325761795044, 89.313354492188, 0.0, 358.09936523438},
	{2308.8156738281, -1712.3265380859, 14.305559158325, 89.313354492188, 0.0, 358.09936523438},
	{2449.0471191406, -1639.1333007813, 14.41983795166, 89.990020751953, 0.0, 0.0},
	{2454.4111328125, -1639.1062011719, 14.365441322327, 89.989013671875, 0.0, 0.0},
	{2453.9240722656, -1639.0361328125, 15.058841705322, 89.989013671875, 0.0, 0.0}
};

new Float:Atms[][3] =
{
	{2479.2846679688, -1687.9583740234, 13.150712013245},
	{2308.4829101563, -1634.2012939453, 14.419947624207},
	{2235.9541015625, -1665.1667480469, 15.034516334534},
	{2423.3850097656, -1891.2802734375, 13.127923965454},
	{2071.9953613281, -1826.3737792969, 13.132801055908},
	{1918.5152587891, -1765.8701171875, 13.189774513245},
	{1498.2911376953, -1749.9183349609, 15.070302963257},
	{1465.7177734375, -1749.9239501953, 15.088212013245},
	{1363.7320556641, -1749.8880615234, 13.171062469482},
	{1367.2965087891, -1290.365234375, 13.182500839233},
	{1011.2633666992, -929.07550048828, 41.929733276367},
	{1011.2633666992, -929.07550048828, 41.929733276367}
};

new Float:SpawnPos[3][4] = {
	{1226.1093,-1815.9108,16.5938,229.9989},
	{1225.8440,-1813.1666,16.5938,268.2259},
	{1223.8932,-1815.4894,16.5938,180.1784}
};

new Float:JailPos[3][3] = {
	{193.3494,175.2234,1003.0234},
	{197.3316,175.5257,1003.0234},
	{199.0002,161.9911,1003.0234}
};

new Float:Trash[20][6] =
{
	{2478.1447753906, -1716.0021972656, 13.204755783081, 0.0, 0.0, 85.824493408203},
	{2466.4770507813, -1771.8061523438, 13.220532417297, 0.0, 0.0, 356.49523925781},
	{2341.8188476563, -1280.7366943359, 27.638534545898, 0.0, 0.0, 1.4598388671875},
	{2027.0908203125, -1271.4063720703, 20.646347045898, 0.0, 0.0, 1.4556884765625},
	{1890.9501953125, -1058.4448242188, 23.947910308838, 0.0, 0.0, 179.96569824219},
	{1288.0140380859, -1253.9145507813, 13.246864318848, 0.0, 0.0, 179.96154785156},
	{1144.9709472656, -1324.5, 13.250319480896, 0.0, 0.0, 273.73107910156},
	{1196.4604492188, -1652.1695556641, 13.596891403198, 0.0, 0.0, 1.0692138671875},
	{1355.4938964844, -1631.1173095703, 13.279160499573, 0.0, 0.0, 181.60595703125},
	{1527.4626464844, -1825.0112304688, 13.208847999573, 0.0, 0.0, 0.1590576171875},
	{1626.4167480469, -1554.0297851563, 13.330368995667, 0.0, 0.0, 182.57055664063},
	{1417.1062011719, -1499.3586425781, 20.096973419189, 0.0, 0.0, 166.68542480469},
	{1267.7600097656, -1541.0059814453, 13.22239780426, 0.0, 0.0, 91.029663085938},
	{987.96990966797, -1430.9063720703, 13.208847999573, 0.0, 0.0, 1.2972412109375},
	{1021.535949707, -774.46319580078, 102.60097503662, 0.0, 0.0, 1.29638671875},
	{1007.1124267578, -640.89526367188, 120.8729095459, 0.0, 0.0, 205.83666992188},
	{1358.8594970703, -631.53137207031, 108.79212188721, 0.0, 0.0, 114.29968261719},
	{789.51208496094, -827.93811035156, 69.93962097168, 0.0, 0.0, 191.98107910156},
	{205.71070861816, -1769.4418945313, 3.9767751693726, 0.0, 0.0, 2.595703125},
	{496.65069580078, -1756.2596435547, 13.816527366638, 0.0, 0.0, 2.5927734375}
};

main()
{
	print("\n----------------------------------");
	print("  New City Role Play\n");
	print("----------------------------------\n");
	MySQLConnect(MYSQL_HOST,MYSQL_USER,MYSQL_PASS,MYSQL_DB);
}

function OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
   // printf("_%d_",newkeys);
    if(newkeys == KEY_WALK && GetPVarInt(playerid, "ToDo") != 0) TextDrawDestroy(Text:GetPVarInt(playerid, "ToDo")), SetPVarInt(playerid, "ToDo", 0), TextDrawDestroy(Text:GetPVarInt(playerid, "ToDo1")), SetPVarInt(playerid, "ToDo1", 0);
    else if(newkeys == KEY_SUBMISSION)
    {
    if(GetPVarInt(playerid, "MessageView") == 0) SetPVarInt(playerid, "MessageView", 1), TextDrawHideForPlayer(playerid, Text:GetPVarInt(playerid, "MessageDraw"));
    else if(GetPVarInt(playerid, "MessageView") == 1) SetPVarInt(playerid, "MessageView", 0), TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid, "MessageDraw"));
	}
	else if(newkeys == KEY_SECONDARY_ATTACK && GetPlayerState(playerid) == 1) CheckEntrance(playerid);
    else if(newkeys == KEY_WALK && GetPlayerState(playerid) == 1 && GetPVarInt(playerid, "BuyingBuilding") != 0) OpenBuy(playerid);
    else if(newkeys == KEY_WALK && GetPlayerState(playerid) == 1 && GetPVarInt(playerid, "WantToRent") != 0) OpenRent(playerid);
	else if(newkeys == KEY_JUMP && GetPVarInt(playerid, "BinObject") != 0 || newkeys == KEY_SPRINT && GetPVarInt(playerid, "BinObject") != 0 || newkeys == KEY_FIRE && GetPVarInt(playerid, "BinObject") != 0) ApplyAnimation(playerid,"PED","WALK_player",4.1,1,1,1,1,500);
    //if(newkeys == KEY_LOOK_BEHIND && IsPlayerInAnyVehicle(playerid)) CheckTow(playerid);
	else if(HOLDING(4) && IsPlayerInAnyVehicle(playerid))
	{
	if(GasStation(playerid) || AirStation(playerid))
    {
	new veh = GetPlayerVehicleID(playerid);
	if(Vgas[veh] == 100) return SendMessage(playerid,"Your vehicle is at it's maximum amount of fuel.");
	if(GetPlayerCash(playerid) < 1) return SendMessage(playerid, "You need $1 to refill 1%%");
	Vgas[veh] += 1;
	GameTextForPlayer(playerid, "~w~Vehicle Fuel went up 1%.", 500, 3);
    GivePlayerCash(playerid, -1);
    }
	}
    return 1;
}

function StartCrushCar()
{
if(CrushCar != 0) DestroyDynamic3DTextLabel(Text3D:CrushCarText);
for(new Car=0;Car<totalveh+9;Car++)
{
if(IsPlayerInInvalidleadedVehicle(Car) || IsPlayerInInvalidDieselVehicle(Car) || IsPlayerInInvalidMotoVehicle(Car)) CrushCar = random(Car);
}
if(CopCar(CrushCar)== 1 || FireCar(CrushCar)== 1 || vehinfo[CrushCar][cOwned] == 1 || vehinfo[CrushCar][cSQLId] == 0 || IsPlayerInInvalidPetroVehicle(CrushCar)
|| IsPlayerInInvalidMotoVehicle(CrushCar) || GetVehicleModel(CrushCar) == 510 || GetVehicleModel(CrushCar) == 408 || GetVehicleModel(CrushCar) == 416) return StartCrushCar();
CrushCarText = Text3D:CreateDynamic3DTextLabel("This Car Is Wanted\nFor The Junk Yard", 0x01FEFEFF, 0.0, 0.0, 0.0, 40, INVALID_PLAYER_ID, CrushCar, 0);
return 1;
}

function OpenRent(playerid)
{
new id = GetPVarInt(playerid, "WantToRent"), tmp[128];
if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[id][hEntrancex], HouseInfo[id][hEntrancey], HouseInfo[id][hEntrancez]) && HouseInfo[id][hOwned] == 1 && HouseInfo[id][hRentable] == 1 && HouseInfo[id][hSQLId] != GetPVarInt(playerid, "RentId") && HouseInfo[id][hRenters] != HouseInfo[id][hRooms])
{
format(tmp, sizeof(tmp), "House Name: %s\n\nHouse Rent Price: $%d\n\nRooms Avaible For Rent = %d/%d",HouseInfo[id][hDescription],HouseInfo[id][hRent],HouseInfo[id][hRooms] - HouseInfo[id][hRenters],HouseInfo[id][hRooms]);
ShowPlayerDialog(playerid,67,DIALOG_STYLE_MSGBOX,"House Rent Info",tmp,"Rent","Close");
}
if(IsPlayerInRangeOfPoint(playerid, 3.0, BuildingInfo[id][bEntrancex], BuildingInfo[id][bEntrancey], BuildingInfo[id][bEntrancez]) && BuildingInfo[id][bOwned] == 1 && BuildingInfo[id][bSQLId] != GetPVarInt(playerid, "ShareId") && BuildingInfo[id][bRenters] != BuildingInfo[id][bShares])
{
format(tmp, sizeof(tmp), "Building Name: %s\n\nBuilding Share Price: $%d\n\nShare's Avaible For Rent = %d/%d",BuildingInfo[id][bDescription],BuildingInfo[id][bBuyPrice]/BuildingInfo[id][bShares]/2,BuildingInfo[id][bShares] - BuildingInfo[id][bRenters],BuildingInfo[id][bShares]);
ShowPlayerDialog(playerid,72,DIALOG_STYLE_MSGBOX,"Building Share's Info",tmp,"Rent","Close");
}
return 1;
}

function OpenBuy(playerid)
{
new id = GetPVarInt(playerid, "BuyingBuilding"), tmp[128];
if(IsPlayerInRangeOfPoint(playerid, 3.0, BuildingInfo[id][bEntrancex], BuildingInfo[id][bEntrancey], BuildingInfo[id][bEntrancez]) && BuildingInfo[id][bOwned] == 0)
{
format(tmp, sizeof(tmp), "Building Name: %s\n\nBuilding Price: $%d\n\nBuilding Tax: %d%%\n\nEstimate Profit Per Hour: $%d",BuildingInfo[id][bDescription],BuildingInfo[id][bBuyPrice],BuildingInfo[id][bTax],BuildingInfo[id][bBuyPrice]/500*BuildingInfo[id][bTax]);
ShowPlayerDialog(playerid,58,DIALOG_STYLE_MSGBOX,"Business Info",tmp,"Buy","Close");
}
if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[id][hEntrancex], HouseInfo[id][hEntrancey], HouseInfo[id][hEntrancez]) && HouseInfo[id][hOwned] == 0)
{
format(tmp, sizeof(tmp), "House Name: %s\n\nHouse Price: $%d\n\nHouse Tax: %d%%\n\nEstimate Tax Pay Per Hour: $%d",HouseInfo[id][hDescription],HouseInfo[id][hBuyPrice],HouseInfo[id][hTax],HouseInfo[id][hBuyPrice]/500*HouseInfo[id][hTax]);
ShowPlayerDialog(playerid,62,DIALOG_STYLE_MSGBOX,"House Info",tmp,"Buy","Close");
}
return 1;
}

function CheckEntrance(playerid)
{
    ClearTextDraws(playerid);
    if(IsPlayerInRangeOfPoint(playerid, 2.0, BuildingInfo[GetPVarInt(playerid, "BuildingIn")][bExitx], BuildingInfo[GetPVarInt(playerid, "BuildingIn")][bExity], BuildingInfo[GetPVarInt(playerid, "BuildingIn")][bExitz]))
	{
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid, BuildingInfo[GetPVarInt(playerid, "BuildingIn")][bEntrancex], BuildingInfo[GetPVarInt(playerid, "BuildingIn")][bEntrancey], BuildingInfo[GetPVarInt(playerid, "BuildingIn")][bEntrancez]);
    SetPVarInt(playerid, "BuildingIn", 0);
	StartFade(playerid);
	}else
    for(new b = 0; b < sizeof(BuildingInfo); b++)
	{
	if(IsPlayerInRangeOfPoint(playerid, 2.0, BuildingInfo[b][bEntrancex], BuildingInfo[b][bEntrancey], BuildingInfo[b][bEntrancez]))
	{
	SetPlayerVirtualWorld(playerid, BuildingInfo[b][bVirtualWorld]);
	SetPlayerInterior(playerid, BuildingInfo[b][bInteriorId]);
	SetPlayerPos(playerid, BuildingInfo[b][bExitx], BuildingInfo[b][bExity], BuildingInfo[b][bExitz]);
	SetPVarInt(playerid, "BuildingIn", b);
	StartFade(playerid);
	if(GetPVarInt(playerid, "BuildingIn") == 8) Streamer_Update(playerid), TogglePlayerControllable(playerid, 0),SetTimerEx("donespawn", 1500, 0, "i", playerid);
	}
	}
	if(IsPlayerInRangeOfPoint(playerid, 2, HouseInfo[GetPVarInt(playerid, "HouseIn")][hExitx], HouseInfo[GetPVarInt(playerid, "HouseIn")][hExity], HouseInfo[GetPVarInt(playerid, "HouseIn")][hExitz]))
	{
    SetPlayerInterior(playerid,0);
    SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid,HouseInfo[GetPVarInt(playerid, "HouseIn")][hEntrancex],HouseInfo[GetPVarInt(playerid, "HouseIn")][hEntrancey],HouseInfo[GetPVarInt(playerid, "HouseIn")][hEntrancez]);
    TogglePlayerControllable(playerid, 1);
	SetPVarInt(playerid, "Interior", 0);
	SetPVarInt(playerid, "VirtualWorld", 0);
    SetCameraBehindPlayer(playerid);
    SetPVarInt(playerid, "HouseIn", 0);
	StartFade(playerid);
	}else
	for(new i = 0; i < sizeof(HouseInfo); i++)
	{
    if(IsPlayerInRangeOfPoint(playerid, 2, HouseInfo[i][hEntrancex], HouseInfo[i][hEntrancey], HouseInfo[i][hEntrancez]))
	{
    SetPlayerPos(playerid,HouseInfo[i][hExitx],HouseInfo[i][hExity],HouseInfo[i][hExitz]);
    SetPlayerInterior(playerid,HouseInfo[i][hInteriorId]);
	SetPVarInt(playerid, "HouseIn", i);
    SetPlayerVirtualWorld(playerid,HouseInfo[i][hVirtualWorld]);StartFade(playerid);
	}
	}// end
	return 1;
}

function OnGameModeExit()
{
return 1;
}

function StartGunTrain(playerid)
{
if(TargetObject != 0) return 1;

if(GetPVarInt(playerid, "ShootingVar") == 0) SetPVarInt(playerid, "ShootingVar", SetTimerEx("ShootingCheck", 500, 1, "i", playerid));
new pick = random(2), pos = random(2);
if(pick == 0)TargetObject = CreateDynamicObject(2051, 283.54360961914, -9.9804744720459, 1002.3126831055,  0, 0, 0,-1, -1, -1);
if(pick == 1)TargetObject = CreateDynamicObject(2051, 300.73095703125, -17.896602630615, 1001.8324584961, 0, 0, 0,-1, -1, -1);
if(pick == 0 && pos == 0) MoveDynamicObject(TargetObject, 286.35388183594, -10.028178215027, 1002.3405151367, 1.0), space[0] = 0.5, space[1] = -1.2, space[2] = 1;
if(pick == 0 && pos == 1) MoveDynamicObject(TargetObject, 291.95822143555, -10.16796207428, 1002.3361816406, 1.0), space[0] = 0.5, space[1] = -1.2, space[2] = 2;
if(pick == 1 && pos == 0) MoveDynamicObject(TargetObject, 298.63711547852, -17.926261901855, 1001.8919677734, 1.0), space[0] = 0.5, space[1] = 0.2, space[2] = 1;
if(pick == 1 && pos == 1) MoveDynamicObject(TargetObject, 294.79470825195, -17.730730056763, 1001.8419189453, 1.0), space[0] = 0.5, space[1] = 0.2, space[2] = 1;
Streamer_UpdateEx(playerid, 294.79470825195, -17.730730056763, 1001.8419189453);
inguntest = 1;
if(GetPVarInt(playerid, "GunLicense") == 0 && pick == 0) space[0] = 0.75;
if(GetPVarInt(playerid, "GunLicense") == 1) space[0] = 0.95;
if(GetPVarInt(playerid, "GunLicense") == 4 && pick == 0) space[2] = 1.5;
if(GetPVarInt(playerid, "GunLicense") == 3 && pick == 0) space[2] = 1;
return 1;
}

function ShootingCheck(playerid)
{
if(GetPVarInt(playerid, "ShootingTextDraw") == 0){
SetPVarInt(playerid, "CopTest", _:TextDrawCreate(481.000000,141.000000,"You have: 30 Second's Left"));
TextDrawUseBox(Text:GetPVarInt(playerid,"CopTest"),1);
TextDrawBoxColor(Text:GetPVarInt(playerid,"CopTest"),0x00000099);
TextDrawTextSize(Text:GetPVarInt(playerid,"CopTest"),620.000000,-12.000000);
TextDrawAlignment(Text:GetPVarInt(playerid,"CopTest"),0);
TextDrawBackgroundColor(Text:GetPVarInt(playerid,"CopTest"),0x0000ffff);
TextDrawFont(Text:GetPVarInt(playerid,"CopTest"),1);
TextDrawLetterSize(Text:GetPVarInt(playerid,"CopTest"),0.299999,0.899999);
TextDrawColor(Text:GetPVarInt(playerid,"CopTest"),0xffffffff);
TextDrawSetProportional(Text:GetPVarInt(playerid,"CopTest"),1);
TextDrawSetShadow(Text:GetPVarInt(playerid,"CopTest"),1);
SetPVarInt(playerid, "ShootingTextDraw", 1);
TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid,"CopTest"));}

new Float:x, Float:y, Float:z;
new Keys,shoot, dw;
GetPlayerKeys(playerid,Keys,shoot, dw);
if(Keys & KEY_FIRE && GetPlayerWeapon(playerid) >= 1 && GetPlayerWeaponState(playerid) != WEAPONSTATE_RELOADING)
{
GetDynamicObjectPos(TargetObject, x, y, z);
if(IsPlayerAimingAt(playerid, x, y+space[1], z-space[2], space[0]) && GetPVarInt(playerid, "GunLicense") < 4
|| IsPlayerAimingAt(playerid, x, y+space[1], z+space[2], space[0]) && GetPVarInt(playerid, "GunLicense") >= 4)
DestroyDynamicObject(TargetObject),
TargetObject = 0,
SetPVarInt(playerid, "Shot", GetPVarInt(playerid, "Shot") +1),
StartGunTrain(playerid),
SendMessage(playerid, "One target down.");
}

if(GetPVarInt(playerid, "Shot") == GetPVarInt(playerid, "Target")) return StopShootingTest(playerid), GameTextForPlayer(playerid, "~g~You passed the shooting test", 500, 1), SetPVarInt(playerid, "GunLicense", GetPVarInt(playerid, "GunLicense") +1);
if(GetPVarInt(playerid, "ShootingTime") == 0) return StopShootingTest(playerid), GameTextForPlayer(playerid, "~R~You failed the shooting test", 500, 1);

if(GetPVarInt(playerid, "ShootingTimer") < 2) return SetPVarInt(playerid, "ShootingTimer", GetPVarInt(playerid, "ShootingTimer")+1);

new tmp[100];
SetPVarInt(playerid, "ShootingTime", GetPVarInt(playerid, "ShootingTime") -1);
format(tmp, sizeof(tmp), "You have: %d Second's Left~n~ ~n~%d/%d Left", GetPVarInt(playerid, "ShootingTime"), GetPVarInt(playerid, "Shot"), GetPVarInt(playerid, "Target"));
if(GetPVarInt(playerid, "ShootingTimer") == 2) return
TextDrawSetString(Text:GetPVarInt(playerid,"CopTest"), tmp),
TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid,"CopTest")),
SetPVarInt(playerid, "ShootingTimer", 0);
return 1;
}

function StopShootingTest(playerid)
{
ResetPlayerWeapons(playerid);
GiveGuns(playerid);
KillTimer(GetPVarInt(playerid,"ShootingVar"));
TextDrawDestroy(Text:GetPVarInt(playerid,"CopTest"));
SetPVarInt(playerid, "ShootingVar", 0);
SetPVarInt(playerid, "ShootingTimer", 0);
SetPVarInt(playerid, "ShootingTime", 0);
Streamer_UpdateEx(playerid, 312.5899,-140.4549,1004.0625);
SetPlayerPos(playerid, 312.5899,-140.4549,1004.0625);
SetPlayerInterior(playerid, 7);
SetPlayerVirtualWorld(playerid, 7441);
SetPVarInt(playerid, "BuildingIn", 24);
SetPVarInt(playerid, "ShootingTextDraw", 0);
SetPVarInt(playerid, "Shot", 0);
TextDrawHideForPlayer(playerid, Window[0]);
TextDrawHideForPlayer(playerid, Window[1]);
inguntest = 0;
if(GetPVarInt(playerid, "GunLicense") >= 4) SendMessage(playerid, "You have a full shooting license.");
if(TargetObject != 0) DestroyDynamicObject(TargetObject), TargetObject = 0;
if(GetPVarInt(playerid, "Watch") == 1) TextDrawShowForPlayer(playerid,TimeText1), TextDrawShowForPlayer(playerid,TimeText);
return 1;
}

function StartMissions()
{
StartCrushCar();
StartFireMission();
return 1;
}

function StartFireMission()
{
if(FireObject[0] != 0 && FireObject[1] != 0 && FireObject[2] != 0) return 1;
PickFireMission();
foreach(player, i)
{
if(GetPVarInt(i,"Team") == fireman)
SendMessage(i, "A fire has started and you have the red marker set on your map."),
SendMessage(i, "You must be in a fire vehicle to be able to extinguish the flames.");
}
return 1;
}

function PickFireMission()
{
    new randf = random(5);
    timer[1] = SetTimer("FireScan", 1000, 1);
	foreach(player, i)
	{
    if(GetPVarInt(i,"Team") == fireman){
    if(randf == 0)  fireat[1] = SetPlayerCheckpoint(i, FireSticks[0][0], FireSticks[0][1], FireSticks[0][2], 10),fireat[0] = CreateDynamicSphere(FireSticks[0][0], FireSticks[0][1], FireSticks[0][2] ,18), squirts = 3, SetPVarInt(i, "TestTime", 140);
    else if(randf == 1)  fireat[1] = SetPlayerCheckpoint(i, FireSticks[3][0], FireSticks[3][1], FireSticks[3][2], 10),fireat[0] = CreateDynamicSphere(FireSticks[3][0], FireSticks[3][1], FireSticks[3][2] ,18), squirts = 3, SetPVarInt(i, "TestTime", 140);
    else if(randf == 2)  fireat[1] = SetPlayerCheckpoint(i, FireSticks[6][0], FireSticks[6][1], FireSticks[6][2], 10),fireat[0] = CreateDynamicSphere(FireSticks[6][0], FireSticks[6][1], FireSticks[6][2] ,18), squirts = 3, SetPVarInt(i, "TestTime", 140);
    else if(randf == 3)  fireat[1] = SetPlayerCheckpoint(i, FireSticks[9][0], FireSticks[9][1], FireSticks[9][2], 10),fireat[0] = CreateDynamicSphere(FireSticks[9][0], FireSticks[9][1], FireSticks[9][2] ,18), squirts = 3, SetPVarInt(i, "TestTime", 140);
    else if(randf == 4)  fireat[1] = SetPlayerCheckpoint(i, FireSticks[12][0], FireSticks[12][1], FireSticks[12][2], 10),fireat[0] = CreateDynamicSphere(FireSticks[12][0], FireSticks[12][1], FireSticks[12][2] ,18), squirts = 3, SetPVarInt(i, "TestTime", 140);
	}}
	if(randf == 0) return
	FireObject[0] = CreateDynamicObject(3461, FireSticks[0][0], FireSticks[0][1], FireSticks[0][2], FireSticks[0][3], FireSticks[0][4], FireSticks[0][5],-1, -1, -1),
    FireObject[1] = CreateDynamicObject(3461, FireSticks[1][0], FireSticks[1][1], FireSticks[1][2], FireSticks[1][3], FireSticks[1][4], FireSticks[1][5], -1, -1, -1),
    FireObject[2] = CreateDynamicObject(3461, FireSticks[2][0], FireSticks[2][1], FireSticks[2][2], FireSticks[2][3], FireSticks[2][4], FireSticks[2][5], -1, -1, -1),
    timer[0] = SetTimer("EndFireMission", 120000, 0),
    printf("%d", randf);

	else if(randf == 1) return
	FireObject[0] = CreateDynamicObject(3461, FireSticks[3][0], FireSticks[3][1], FireSticks[3][2], FireSticks[3][3], FireSticks[3][4], FireSticks[3][5],-1, -1, -1),
    FireObject[1] = CreateDynamicObject(3461, FireSticks[4][0], FireSticks[4][1], FireSticks[4][2], FireSticks[4][3], FireSticks[4][4], FireSticks[4][5], -1, -1, -1),
    FireObject[2] = CreateDynamicObject(3461, FireSticks[5][0], FireSticks[5][1], FireSticks[5][2], FireSticks[5][3], FireSticks[5][4], FireSticks[5][5], -1, -1, -1),
    timer[0] = SetTimer("EndFireMission", 120000, 0),
    printf("%d", randf);

	else if(randf == 2) return
	FireObject[0] = CreateDynamicObject(3461, FireSticks[6][0], FireSticks[6][1], FireSticks[6][2], FireSticks[6][3], FireSticks[6][4], FireSticks[6][5],-1, -1, -1),
    FireObject[1] = CreateDynamicObject(3461, FireSticks[7][0], FireSticks[7][1], FireSticks[7][2], FireSticks[7][3], FireSticks[7][4], FireSticks[7][5], -1, -1, -1),
    FireObject[2] = CreateDynamicObject(3461, FireSticks[8][0], FireSticks[8][1], FireSticks[8][2], FireSticks[8][3], FireSticks[8][4], FireSticks[8][5], -1, -1, -1),
    timer[0] = SetTimer("EndFireMission", 120000, 0),
    printf("%d", randf);

	else if(randf == 3) return
    FireObject[0] = CreateDynamicObject(3461, FireSticks[9][0], FireSticks[9][1], FireSticks[9][2], FireSticks[9][3], FireSticks[9][4], FireSticks[9][5],-1, -1, -1),
    FireObject[1] = CreateDynamicObject(3461, FireSticks[10][0], FireSticks[10][1], FireSticks[10][2], FireSticks[10][3], FireSticks[10][4], FireSticks[10][5], -1, -1, -1),
    FireObject[2] = CreateDynamicObject(3461, FireSticks[11][0], FireSticks[11][1], FireSticks[11][2], FireSticks[11][3], FireSticks[11][4], FireSticks[11][5], -1, -1, -1),
    timer[0] = SetTimer("EndFireMission", 120000, 0),
    printf("%d", randf);

	else if(randf == 4) return
    FireObject[0] = CreateDynamicObject(3461, FireSticks[12][0], FireSticks[12][1], FireSticks[12][2], FireSticks[12][3], FireSticks[12][4], FireSticks[12][5],-1, -1, -1),
    FireObject[1] = CreateDynamicObject(3461, FireSticks[13][0], FireSticks[13][1], FireSticks[13][2], FireSticks[13][3], FireSticks[13][4], FireSticks[13][5], -1, -1, -1),
    FireObject[2] = CreateDynamicObject(3461, FireSticks[14][0], FireSticks[14][1], FireSticks[14][2], FireSticks[14][3], FireSticks[14][4], FireSticks[14][5], -1, -1, -1),
    timer[0] = SetTimer("EndFireMission", 120000, 0),
    printf("%d", randf);

	return 1;
}

function KillfireMission()
{
if(timer[0] != 0) KillTimer(timer[0]), timer[0] = 0;
KillTimer(timer[1]);
FireObject[0] = 0;
FireObject[1] = 0;
FireObject[2] = 0;
fireat[0] = 0;
foreach(player, i)
{
if(GetPVarInt(i,"Team") == fireman)
TextDrawDestroy(Text:GetPVarInt(i,"CopTest")),
SetPVarInt(i, "FireTextDraw", 0),
SetPVarInt(i, "TestTime", 0);
}
return 1;
}

function FireScan()
{
foreach(player, i)
{
if(GetPVarInt(i,"Team") == fireman)
{
new tmp[100];
SetPVarInt(i, "TestTime", GetPVarInt(i, "TestTime") -1);
//if(GetPVarInt(i, "TestTime") == 0) return EndFireMission();
SetPVarInt(i, "fire4", GetPVarInt(i, "fire4") +1);
format(tmp, sizeof(tmp), "You have: %d Second's Left", GetPVarInt(i, "TestTime"));
if(GetPVarInt(i, "FireTextDraw") == 1)
{
TextDrawSetString(Text:GetPVarInt(i,"CopTest"), tmp);
TextDrawShowForPlayer(i, Text:GetPVarInt(i,"CopTest"));
}
if(GetPVarInt(i, "FireTextDraw") == 0) return
SetPVarInt(i, "CopTest", _:TextDrawCreate(481.000000,141.000000,tmp)),
TextDrawUseBox(Text:GetPVarInt(i,"CopTest"),1),
TextDrawBoxColor(Text:GetPVarInt(i,"CopTest"),0x00000099),
TextDrawTextSize(Text:GetPVarInt(i,"CopTest"),620.000000,-12.000000),
TextDrawAlignment(Text:GetPVarInt(i,"CopTest"),0),
TextDrawBackgroundColor(Text:GetPVarInt(i,"CopTest"),0x0000ffff),
TextDrawFont(Text:GetPVarInt(i,"CopTest"),1),
TextDrawLetterSize(Text:GetPVarInt(i,"CopTest"),0.299999,0.899999),
TextDrawColor(Text:GetPVarInt(i,"CopTest"),0xffffffff),
TextDrawSetProportional(Text:GetPVarInt(i,"CopTest"),1),
TextDrawSetShadow(Text:GetPVarInt(i,"CopTest"),1),
SetPVarInt(i, "FireTextDraw", 1);

if(GetPVarInt(i, "fire4") == 5)
{
SetPVarInt(i, "fire4", 0);
if(IsPlayerInDynamicArea(i, fireat[0]))
{
new veh = GetPlayerVehicleID(i);
new playerstate = GetPlayerState(i);
if(GetVehicleModel(veh) ==  407 && playerstate == PLAYER_STATE_DRIVER)
{
new Keys,hose, dw;
GetPlayerKeys(i,Keys,hose, dw);
if(Keys & KEY_ACTION || Keys & KEY_FIRE)
{
for(new f = 0; f < sizeof(FireSticks); f++)
{
if(IsPlayerAimingAt(i, FireSticks[f][0], FireSticks[f][1], FireSticks[f][2], 4.0) && squirts == 3) return
DestroyDynamicObject(FireObject[0]),
SendMessage(i,"Fire is slowly dying"),
UpExp(i),
squirts--;

if(IsPlayerAimingAt(i, FireSticks[f][0], FireSticks[f][1], FireSticks[f][2], 4.0) && squirts == 2) return
DestroyDynamicObject(FireObject[1]),
SendMessage(i,"Fire is nearly out"),
UpExp(i),
squirts--;

if(IsPlayerAimingAt(i, FireSticks[f][0], FireSticks[f][1], FireSticks[f][2], 4.0) && squirts == 1) return
DestroyDynamicObject(FireObject[2]),
SendMessage(i,"Fire is out keep wetting it until fire is confirmed out"),
UpExp(i),
squirts--;
}
if(squirts == 0) return
SendMessage(i,"The fire has been confirmed that it is out."),
SendMessage(i,"Mission accomplished."),
KillfireMission();
}
}
}
}
}
}
return 1;
}

function EndFireMission()
{
if(FireObject[0] != 0 && FireObject[1] != 0 && FireObject[2] != 0)
{
if(FireObject[0] != 0)
{
DestroyDynamicObject(FireObject[0]);
}
if(FireObject[1] != 0)
{
DestroyDynamicObject(FireObject[1]);
}
if(FireObject[2] != 0)
{
DestroyDynamicObject(FireObject[2]);
}
timer[0] = 0;
FireObject[0] = 0;
FireObject[1] = 0;
FireObject[2] = 0;
fireat[0] = 0;
foreach(player, i)
{
if(GetPVarInt(i,"Team") == fireman)
SendMessage(i, "You and your team failed to put out the fire.");
}
KillfireMission();
}
return 1;
}

function UpExp(playerid)
{
GameTextForPlayer(playerid, "~w~Your Exp went up 1.", 1000, 3);
SetPVarInt(playerid,"Exp", GetPVarInt(playerid,"Exp") +1);
new xp = GetPVarInt(playerid,"Exp");
new team = GetPVarInt(playerid,"Team");
if(team == fireman)
{
if(xp == 30) return
SendMessage(playerid, "Your fire man skill is rising, You now are a Trained fire man."),
SendMessage(playerid, "The more skill you have the higher the rank you get."),
SetPVarString(playerid,"Rank", "Trained fire man");

else if(xp == 60) return
SendMessage(playerid, "Your fire man skill is rising, You now are a Highly trained fire man."),
SendMessage(playerid, "The more skill you have the higher the rank you get."),
SetPVarString(playerid,"Rank", "Highly trained fire man");

else if(xp == 90) return
SendMessage(playerid, "Your fire man skill is rising, You now are a Fast Response fire man."),
SendMessage(playerid, "The more skill you have the higher the rank you get."),
SetPVarString(playerid,"Rank", "Fast Response fire man");

else if(xp == 120) return
SendMessage(playerid, "Your fire man skill is rising, You now are a High Class fire man."),
SendMessage(playerid, "The more skill you have the higher the rank you get."),
SetPVarString(playerid,"Rank", "High Class fire man");

else if(xp == 150) return
SendMessage(playerid, "Your fire man skill is rising, You now are a Fire Man leader."),
SendMessage(playerid, "The more skill you have the higher the rank you get."),
SetPVarString(playerid,"Rank", "Fire Man leader");
}

if(team == civ)
{
if(xp == 20) return
SendMessage(playerid, "Your hood reputation has increased, You now are Street wise."),
SetPVarString(playerid,"Rank", "Street wise");

else if(xp == 40) return
SendMessage(playerid, "Your hood reputation has increased, You now are a Big Bala."),
SetPVarString(playerid,"Rank", "Big Bala");

else if(xp == 60) return
SendMessage(playerid, "Your hood reputation has increased, You now are a King Pin."),
SetPVarString(playerid,"Rank", "King Pin");

else if(xp == 100) return
SendMessage(playerid, "Your hood reputation has increased, You now are a God Father ."),
SetPVarString(playerid,"Rank", "God Father");
}

return 1;
}

/*function VehicleUpdater(playerid ,veh)
{
        if(GetPVarInt(playerid, "SpeedoTimer") != 0  && GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return KillTimer(GetPVarInt(playerid, "SpeedoTimer")), SetPVarInt(playerid, "SpeedoTimer", 0);

        return 1;
}*/

function GetCarSpeed(playerid)
{
SetPVarInt(playerid, "SpeedGunWatch", GetPVarInt(playerid, "SpeedGunWatch") +1);
new Car, string[140];
new Keys,aim, dw;
GetPlayerKeys(playerid,Keys,aim, dw);
if(GetPVarInt(playerid, "SpeedGunWatch") == 20) return KillTimer(GetPVarInt(playerid, "SpeedGunTimer")), SetPVarInt(playerid, "SpeedGunStat", 0), TextDrawDestroy(Text:GetPVarInt(playerid, "SpeedoDraw")), SendMessage(playerid, "Your speed gun was turned off as it was not being used.");
if(Keys & KEY_HANDBRAKE)
{
if(GetPlayerWeapon(playerid) == 43)
{
new Float:x,Float:y,Float:z;

for(Car=1;Car<totalveh+9;Car++)
{
if(IsVehicleStreamedIn(Car, playerid))
{
if(SeatTaken[0][Car] == 1)
{
GetVehiclePos(Car,x,y,z);
if(IsPlayerAimingAt(playerid, x, y, z, 3.0))
{
new
Float:fPos[3],
Float:vSpeed,
Gears;

GetVehicleVelocity(Car, fPos[0], fPos[1], fPos[2]);

vSpeed = floatsqroot(floatpower(fPos[0], 2) + floatpower(fPos[1], 2) +
floatpower(fPos[2], 2)) * 200;

new Float:alpha = 320 - vSpeed;
if(alpha < 60)alpha = 60;
if(vSpeed >= 1.0 ) Gears = 1;
if(vSpeed >= 40.0) Gears = 2;
if(vSpeed >= 80.0) Gears = 3;
if(vSpeed >= 120.0) Gears = 4; // 80 mph
if(vSpeed >= 160.0) Gears = 5; // 100 mph
if(vSpeed >= 200.0) Gears = 6; // 120 mph

format(string,sizeof(string),"Vehicle Speed: ~R~%.0f ~W~mph~n~Vehicle's Gear: ~G~%d~N~~W~Vehicle Registerd To: ~y~%s~N~~W~Vehicle Make: ~P~%s",vSpeed/1.88, Gears, vehinfo[Car][cOwner], vehinfo[Car][cName]);

if(GetPVarInt(playerid, "SpeedGunStat") == 1) return TextDrawSetString(Text:GetPVarInt(playerid, "SpeedoDraw"), string), TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid, "SpeedoDraw")), SetPVarInt(playerid, "SpeedGunWatch", 0);
}
}
}
}
}
}
return 1;
}

function Hourup()
{
new time[50];
timeleft = 24-worldhour;
format(time, sizeof(time), " ~N~ ~N~ %d Hours~N~ of the day~N~ left", timeleft);
TextDrawSetString(TimeText, time);

new time2[40], hour;
format(time2, sizeof(time2), "%d Am", worldhour);
if(worldhour == 12) format(time2, sizeof(time2), "%d PM", worldhour);
else if(worldhour >= 13) hour = worldhour-12, format(time2, sizeof(time2), "%d PM", hour);
else if(worldhour == 24) hour = worldhour-12, format(time2, sizeof(time2), "%d AM", hour);

TextDrawSetString(TimeText1, time2);

foreach(Player, i)
{
if(GetPVarInt(i, "Watch") == 1) TextDrawShowForPlayer(i,TimeText1), TextDrawShowForPlayer(i,TimeText);
}
worldhour++;
if(worldhour == 1) SetWeather(11), SetWorldTime(2);
else if(worldhour == 2) SetWeather(11), SetWorldTime(3);
else if(worldhour == 3) SetWeather(11), SetWorldTime(4);
else if(worldhour == 4) SetWeather(11), SetWorldTime(5);
else if(worldhour == 5) SetWeather(11), SetWorldTime(6);
else if(worldhour == 6) SetWeather(11), SetWorldTime(7);
else if(worldhour == 7) SetWeather(11), SetWorldTime(8);
else if(worldhour == 8) SetWeather(11), SetWorldTime(9);
else if(worldhour == 9) SetWeather(11), SetWorldTime(10);
else if(worldhour == 10) SetWeather(11), SetWorldTime(11);
else if(worldhour == 11) SetWeather(11), SetWorldTime(12);
else if(worldhour == 12) SetWeather(11), SetWorldTime(13);
else if(worldhour == 13) SetWeather(11), SetWorldTime(14);
else if(worldhour == 14) SetWeather(11), SetWorldTime(15);
else if(worldhour == 15) SetWeather(11), SetWorldTime(16);
else if(worldhour == 16) SetWeather(11), SetWorldTime(17);
else if(worldhour == 17) SetWeather(11), SetWorldTime(18);
else if(worldhour == 18) SetWeather(11), SetWorldTime(19);
else if(worldhour == 19) SetWeather(11), SetWorldTime(20);
else if(worldhour == 20) SetWeather(11), SetWorldTime(21);
else if(worldhour == 21) SetWeather(11), SetWorldTime(22);
else if(worldhour == 22) SetWeather(11), SetWorldTime(23);
else if(worldhour == 23) SetWeather(11), SetWorldTime(24);
else if(worldhour == 24) SetWeather(11), SetWorldTime(0);
else if(worldhour == 25) worldhour = 1, SetWeather(11), SetWorldTime(1);
return 1;
}

function TaxPay(playerid)
{
new string[128];
for(new b = 0; b < sizeof(BuildingInfo); b++)
{
if(MyBusiness(playerid, b)) format(string, sizeof(string), "You paid $%d for your Building %s's Building Tax", BuildingInfo[b][bBuyPrice]/500*BuildingInfo[b][bTax],BuildingInfo[b][bDescription]),SendMessage(playerid, string), GivePlayerCash(playerid, - BuildingInfo[b][bBuyPrice]/500*BuildingInfo[b][bTax]);
}
for(new h = 0; h < sizeof(HouseInfo); h++)
{
if(MyHouse(playerid, h)) format(string, sizeof(string), "You paid $%d for your House %s's  House Tax", HouseInfo[h][hBuyPrice]/500*HouseInfo[h][hTax],HouseInfo[h][hDescription]),SendMessage(playerid, string), GivePlayerCash(playerid, - HouseInfo[h][hBuyPrice]/500*HouseInfo[h][hTax]);
}
return 1;
}

function DoNpc(playerid)
{
busdriver = GetPlayerID("busdriver");
jobcenter = GetPlayerID("JobCentre");
train = GetPlayerID("traindriver");
plane = GetPlayerID("planedriver");
drugsman = GetPlayerID("DrugSeller");
medic = GetPlayerID("ambulancedriver");
return 1;
}

function GetPlayerID(playername[]) //By Alex "Y_Less" Cole (Edited by Sacky)
{
new playername2[MAX_PLAYER_NAME];
foreach(Player, i)
{
GetPlayerName(i,playername2,sizeof(playername2));
if(strcmp(playername,playername2,true)==0){
return i;
}
}
return  INVALID_PLAYER_ID;
}

function OnGameModeInit()
{
	// anti DeAMX
    AntiDeAMX();
	// Game Setting's
	SetGameModeText("CRP© Version 1");
	ShowPlayerMarkers(0);
	ShowNameTags(0);
	UsePlayerPedAnims();
	DisableInteriorEnterExits();
	AllowInteriorWeapons(1);
	EnableStuntBonusForAll(0);
	// timers  Server Updater
	SetTimer("UpdateServer", 1000, 1);
	// Small timer's to start a mission
	SetTimer("StartMissions", 6*60000, 1);
	SetTimer("DoNpc", 10000, 0);
	SetDeathDropAmount(100);
	worldhour = 6;
    SetTimer("Hourup", 1000, 0), SetTimer("Hourup", 30*60000, 1);

	AddStaticVehicle(437,1319.9338,-2547.1736,13.6462,267.7887,0,1); // NPC's coach
	strmid(vehinfo[1][cOwner], "Los Santos Coach Firm", 0, 50, 128);
	strmid(vehinfo[1][cName], "Coach", 0, 50, 128);
	AddStaticVehicle(538,1739.2050,-1953.7651,14.8756,269.9382,1,1); // NPC's train
	strmid(vehinfo[2][cOwner], "Los Santos Train Firm", 0, 50, 128);
	strmid(vehinfo[2][cName], "Train", 0, 50, 128);
	AddStaticVehicle(577,1319.9338,-2547.1736+8,13.6462,268.5895,1,3); // NPC's plane
	strmid(vehinfo[6][cOwner], "Los Santos Plane Firm", 0, 50, 128);
	strmid(vehinfo[6][cName], "Plane", 0, 50, 128);
	AddStaticVehicle(416,1319.9338,-2547.1736+8,13.6462,268.5895,1,3); // NPC's ambulance
	strmid(vehinfo[7][cOwner], "Los Santos Hospital", 0, 50, 128);
	strmid(vehinfo[7][cName], "Ambulance", 0, 50, 128);
	AddStaticVehicle(522,1319.9338,-2547.1736,13.6462,267.7887,0,1); // NPC's hidden bike
	SetVehicleVirtualWorld(8, 55);

	new connection=MySQLConnect(MYSQL_HOST,MYSQL_USER,MYSQL_PASS,MYSQL_DB);
	if(connection==1)
	{
		print("Connection succeeded.");
		LoadVehicles();
		LoadHouses();
		LoadLand();
		LoadBuildings();
		LoadGangs();
        LoadNames();
	}
	else
	{
		print("Connection failed.");
	}
    for(new i = 0; i <= sizeof(Skins)-1; i++)
	{
		AddPlayerClass(Skins[i][0],1958.3783,1343.1572,1100.3746,269.1425,-1,-1,-1,-1,-1,-1);
	}
	new Car;
	for(Car=0;Car<totalveh+9;Car++)
	{
		Vgas[Car] = 32+random(100-32);
		engineOn[Car] = false;
	    if(vehinfo[Car][cCantSell] == 0) Vgas[Car] = vehinfo[Car][cFuel];
	    if(CopCar(Car) == 1) Vgas[Car] = 98;
	    if(FireCar(Car) == 1) Vgas[Car] = 98;

	}
	// Text Draw's
    TextDrawCreate(491.000000-300,393.000000,"_");// spare
	TextDraws[TDSpeedClock][0] = TextDrawCreate(491.000000-300,393.000000,"20");
 	TextDraws[TDSpeedClock][1] = TextDrawCreate(487.000000-300,372.000000,"40");
 	TextDraws[TDSpeedClock][2] = TextDrawCreate(491.000000-300,351.000000,"60");
 	TextDraws[TDSpeedClock][3] = TextDrawCreate(218.000000+8,341.000000,"80");
 	TextDraws[TDSpeedClock][4] = TextDrawCreate(564.000000-300,341.000000,"100");
 	TextDraws[TDSpeedClock][5] = TextDrawCreate(594.000000-300,360.500000,"120");
 	TextDraws[TDSpeedClock][6] = TextDrawCreate(591.000000-300,383.000000,"140");
    TextDraws[TDSpeedClock][7] = TextDrawCreate(282.000000,411.000000,"160");
 	TextDraws[TDSpeedClock][8] = TextDrawCreate(269.000000,409.000000,"\\");
 	TextDraws[TDSpeedClock][9] = TextDrawCreate(548.000000-300,401.000000,"~r~|");
 	TextDraws[TDSpeedClock][10] = TextDrawCreate(208.000000,416.000000,"0");
 	TextDrawLetterSize(TextDraws[TDSpeedClock][8], 1.059999, 2.100000);
	TextDrawLetterSize(TextDraws[TDSpeedClock][9], 0.73, -2.60);

    TextDrawAlignment(TextDraws[TDSpeedClock][8],0);
	TextDrawBackgroundColor(TextDraws[TDSpeedClock][8],0x000000ff);
	TextDrawFont(TextDraws[TDSpeedClock][8],3);
	TextDrawLetterSize(TextDraws[TDSpeedClock][8],1.000000,1.299999);
	TextDrawColor(TextDraws[TDSpeedClock][8],0x00ffff66);
	TextDrawSetOutline(TextDraws[TDSpeedClock][8],1);
	TextDrawSetProportional(TextDraws[TDSpeedClock][8],1);
	TextDrawSetShadow(TextDraws[TDSpeedClock][8],1);

	TextDrawAlignment(TextDraws[TDSpeedClock][0],0);
	TextDrawBackgroundColor(TextDraws[TDSpeedClock][0],0x000000ff);
	TextDrawFont(TextDraws[TDSpeedClock][0],0);
	TextDrawLetterSize(TextDraws[TDSpeedClock][0],0.599999,1.000000);
	TextDrawColor(TextDraws[TDSpeedClock][0],0x00ffff66);
	TextDrawSetOutline(TextDraws[TDSpeedClock][0],1);
	TextDrawSetShadow(TextDraws[TDSpeedClock][0],1);

	TextDrawAlignment(TextDraws[TDSpeedClock][1],0);
	TextDrawBackgroundColor(TextDraws[TDSpeedClock][1],0x000000ff);
	TextDrawFont(TextDraws[TDSpeedClock][1],0);
	TextDrawLetterSize(TextDraws[TDSpeedClock][1],0.599999,1.000000);
	TextDrawColor(TextDraws[TDSpeedClock][1],0x00ffff66);
	TextDrawSetOutline(TextDraws[TDSpeedClock][1],1);
	TextDrawSetShadow(TextDraws[TDSpeedClock][1],1);

	TextDrawAlignment(TextDraws[TDSpeedClock][2],0);
	TextDrawBackgroundColor(TextDraws[TDSpeedClock][2],0x000000ff);
	TextDrawFont(TextDraws[TDSpeedClock][2],0);
	TextDrawLetterSize(TextDraws[TDSpeedClock][2],0.599999,1.000000);
	TextDrawColor(TextDraws[TDSpeedClock][2],0x00ffff66);
	TextDrawSetOutline(TextDraws[TDSpeedClock][2],1);
	TextDrawSetShadow(TextDraws[TDSpeedClock][2],1);

	TextDrawAlignment(TextDraws[TDSpeedClock][3],0);
	TextDrawBackgroundColor(TextDraws[TDSpeedClock][3],0x000000ff);
	TextDrawFont(TextDraws[TDSpeedClock][3],0);
	TextDrawLetterSize(TextDraws[TDSpeedClock][3],0.599999,1.000000);
	TextDrawColor(TextDraws[TDSpeedClock][3],0x00ffff66);
	TextDrawSetOutline(TextDraws[TDSpeedClock][3],1);
	TextDrawSetShadow(TextDraws[TDSpeedClock][3],1);

	TextDrawAlignment(TextDraws[TDSpeedClock][4],0);
	TextDrawBackgroundColor(TextDraws[TDSpeedClock][4],0x000000ff);
	TextDrawFont(TextDraws[TDSpeedClock][4],0);
	TextDrawLetterSize(TextDraws[TDSpeedClock][4],0.599999,1.000000);
	TextDrawColor(TextDraws[TDSpeedClock][4],0x00ffff66);
	TextDrawSetOutline(TextDraws[TDSpeedClock][4],1);
	TextDrawSetShadow(TextDraws[TDSpeedClock][4],1);

	TextDrawAlignment(TextDraws[TDSpeedClock][5],0);
	TextDrawBackgroundColor(TextDraws[TDSpeedClock][5],0x000000ff);
	TextDrawFont(TextDraws[TDSpeedClock][5],0);
	TextDrawLetterSize(TextDraws[TDSpeedClock][5],0.599999,1.000000);
	TextDrawColor(TextDraws[TDSpeedClock][5],0x00ffff66);
	TextDrawSetOutline(TextDraws[TDSpeedClock][5],1);
	TextDrawSetShadow(TextDraws[TDSpeedClock][5],1);

	TextDrawAlignment(TextDraws[TDSpeedClock][6],0);
	TextDrawBackgroundColor(TextDraws[TDSpeedClock][6],0x000000ff);
	TextDrawFont(TextDraws[TDSpeedClock][6],0);
	TextDrawLetterSize(TextDraws[TDSpeedClock][6],0.599999,1.000000);
	TextDrawColor(TextDraws[TDSpeedClock][6],0x00ffff66);
	TextDrawSetOutline(TextDraws[TDSpeedClock][6],1);
	TextDrawSetShadow(TextDraws[TDSpeedClock][6],1);

	TextDrawAlignment(TextDraws[TDSpeedClock][7],0);
	TextDrawBackgroundColor(TextDraws[TDSpeedClock][7],0x000000ff);
	TextDrawFont(TextDraws[TDSpeedClock][7],0);
	TextDrawLetterSize(TextDraws[TDSpeedClock][7],0.599999,1.000000);
	TextDrawColor(TextDraws[TDSpeedClock][7],0x00ffff66);
	TextDrawSetOutline(TextDraws[TDSpeedClock][7],1);
	TextDrawSetShadow(TextDraws[TDSpeedClock][7],1);

	TextDrawAlignment(TextDraws[TDSpeedClock][10],0);
	TextDrawBackgroundColor(TextDraws[TDSpeedClock][10],0x000000ff);
	TextDrawFont(TextDraws[TDSpeedClock][10],0);
	TextDrawLetterSize(TextDraws[TDSpeedClock][10],0.900000,0.799999);
	TextDrawColor(TextDraws[TDSpeedClock][10],0x00ffff66);
	TextDrawSetOutline(TextDraws[TDSpeedClock][10],1);
	TextDrawSetShadow(TextDraws[TDSpeedClock][10],1);

	for(new i; i < 11; i++)
 	{
 		TextDrawSetShadow(TextDraws[TDSpeedClock][i], 1);
 		TextDrawSetOutline(TextDraws[TDSpeedClock][i], 0);
 		TextDrawColor(TextDraws[TDSpeedClock][i],0x3C7AE0DF);
 	}

	FuelText1[0] = TextDrawCreate(145.000000,327.000000, "_");
	TextDrawUseBox(FuelText1[0],1);
	TextDrawBoxColor(FuelText1[0],0xffffff66);
	TextDrawTextSize(FuelText1[0],30.000000,0.000000);
	TextDrawAlignment(FuelText1[0],0);
	TextDrawBackgroundColor(FuelText1[0],0x000000ff);
	TextDrawFont(FuelText1[0],3);
	TextDrawLetterSize(FuelText1[0],1.000000,1.000000);
	TextDrawColor(FuelText1[0],0xffffffff);
	TextDrawSetOutline(FuelText1[0],1);
	TextDrawSetProportional(FuelText1[0],1);
	TextDrawSetShadow(FuelText1[0],1);

	FuelText1[1] = TextDrawCreate(34.000000,326.000000,"~R~E                 ~G~F");
	TextDrawAlignment(FuelText1[1],0);
	TextDrawBackgroundColor(FuelText1[1],0x000000ff);
	TextDrawFont(FuelText1[1],2);
	TextDrawLetterSize(FuelText1[1],0.399999,1.000000);
	TextDrawColor(FuelText1[1],0xffffffff);
	TextDrawSetOutline(FuelText1[1],1);
	TextDrawSetProportional(FuelText1[1],1);
	TextDrawSetShadow(FuelText1[1],1);

	Window[0] = TextDrawCreate(1.000000,1.000000,"_");
	TextDrawUseBox(Window[0],1);
	TextDrawBoxColor(Window[0],0x000000ff);
	TextDrawTextSize(Window[0],647.000000,-13.000000);
	TextDrawAlignment(Window[0],0);
	TextDrawBackgroundColor(Window[0],0x000000ff);
	TextDrawFont(Window[0],3);
	TextDrawLetterSize(Window[0],1.000000,11.100004);
	TextDrawColor(Window[0],0xffffffff);
	TextDrawSetOutline(Window[0],1);
	TextDrawSetProportional(Window[0],1);
	TextDrawSetShadow(Window[0],1);


	Window[1] = TextDrawCreate(1.000000,337.000000,"_");
	TextDrawSetShadow(Window[1],1);
	TextDrawSetProportional(Window[1],1);
	TextDrawSetOutline(Window[1],1);
	TextDrawColor(Window[1],0xffffffff);
	TextDrawLetterSize(Window[1],1.000000,14.000000);
	TextDrawFont(Window[1],3);
	TextDrawBackgroundColor(Window[1],0x000000ff);
	TextDrawAlignment(Window[1],0);
	TextDrawTextSize(Window[1],649.000000,-10.000000);
	TextDrawBoxColor(Window[1],0x000000ff);
	TextDrawUseBox(Window[1],1);

	new time[50];
	timeleft = 24-worldhour;
	format(time, sizeof(time), " ~N~ ~N~ %d Hours~N~ of the day~N~ left", timeleft);
	TimeText = TextDrawCreate(549.000000,20.000000,time);
	TextDrawUseBox(TimeText,1);
	TextDrawBoxColor(TimeText,0xffff0066);
	TextDrawTextSize(TimeText,611.000000,-15.000000);
	TextDrawAlignment(TimeText,0);
	TextDrawBackgroundColor(TimeText,0x00ff0066);
	TextDrawFont(TimeText,1);
	TextDrawLetterSize(TimeText,0.299999,0.899999);
	TextDrawColor(TimeText,0x000000ff);
	TextDrawSetProportional(TimeText,1);
	TextDrawSetShadow(TimeText,1);

	new time2[40], hour;
    format(time2, sizeof(time2), "%d Am", worldhour);
    if(worldhour == 12) format(time2, sizeof(time2), "%d PM", worldhour);
    else if(worldhour >= 13) hour = worldhour-12, format(time2, sizeof(time2), "%d PM", hour);
    else if(worldhour == 24) hour = worldhour-12, format(time2, sizeof(time2), "%d AM", hour);
	TimeText1 = TextDrawCreate(552.000000,22.000000,time2);
	TextDrawBackgroundColor(TimeText1,0x00ffff66);
	TextDrawFont(TimeText1,2);
	TextDrawAlignment(TimeText1,0);
	TextDrawLetterSize(TimeText1,0.499999,1.200000);
	TextDrawColor(TimeText1,0x000000ff);
	TextDrawSetProportional(TimeText1,1);
	TextDrawSetShadow(TimeText1,1);
	
	RegBox[0] = TextDrawCreate(401.000000,161.000000,"_");
	TextDrawUseBox(RegBox[0],1);
	TextDrawBoxColor(RegBox[0],0x000000ff);
    TextDrawTextSize(RegBox[0],580.000000,-8.000000);
    TextDrawAlignment(RegBox[0],0);
    TextDrawBackgroundColor(RegBox[0],0x000000ff);
    TextDrawFont(RegBox[0],3);
    TextDrawLetterSize(RegBox[0],1.000000,21.000000);
    TextDrawColor(RegBox[0],0xffffffff);
    TextDrawSetOutline(RegBox[0],1);
    TextDrawSetProportional(RegBox[0],1);
    TextDrawSetShadow(RegBox[0],1);
    
    RegBox[1] = TextDrawCreate(410.000000,266.000000,"Welcome to City Role Play~N~Here you can enjoy many~N~Unique features such as~N~ ~N~1. Job System~N~2. Shooting system~N~3. cop/fireman/medic system.");
    TextDrawAlignment(RegBox[1],0);
    TextDrawBackgroundColor(RegBox[1],0x000000ff);
    TextDrawFont(RegBox[1],1);
    TextDrawLetterSize(RegBox[1],0.299999,0.999999);
    TextDrawColor(RegBox[1],0xff0000cc);
    TextDrawSetOutline(RegBox[1],1);
    TextDrawSetProportional(RegBox[1],1);
    TextDrawSetShadow(RegBox[1],1);
    
    RegBox[2] = TextDrawCreate(411.000000,205.000000,"Gender:");
    TextDrawAlignment(RegBox[2],0);
    TextDrawBackgroundColor(RegBox[2],0x000000ff);
    TextDrawFont(RegBox[2],1);
    TextDrawLetterSize(RegBox[2],0.399999,1.200000);
    TextDrawColor(RegBox[2],0xffffffff);
    TextDrawSetOutline(RegBox[2],1);
    TextDrawSetProportional(RegBox[2],1);
    TextDrawSetShadow(RegBox[2],1);
    
    RegBox[3] = TextDrawCreate(411.000000,221.000000,"Age:");
    TextDrawAlignment(RegBox[3],0);
    TextDrawBackgroundColor(RegBox[3],0x000000ff);
    TextDrawFont(RegBox[3],1);
    TextDrawLetterSize(RegBox[3],0.399999,1.400000);
    TextDrawColor(RegBox[3],0xffffffff);
    TextDrawSetOutline(RegBox[3],1);
    TextDrawSetProportional(RegBox[3],1);
    TextDrawSetShadow(RegBox[3],1);
    
    RegBox[4] = TextDrawCreate(410.000000,241.000000,"Arrived On:");
    TextDrawAlignment(RegBox[4],0);
    TextDrawBackgroundColor(RegBox[4],0x000000ff);
    TextDrawFont(RegBox[4],1);
    TextDrawLetterSize(RegBox[4],0.399999,1.400000);
    TextDrawColor(RegBox[4],0xffffffff);
    TextDrawSetOutline(RegBox[4],1);
    TextDrawSetProportional(RegBox[4],1);
    TextDrawSetShadow(RegBox[4],1);
    

    

	jcd = CreateDynamicObject(1538, 379.4423828125, 172.638671875, 1007.3322753906, 0, 0, 93.680419921875);

	LoadStuff();
    return 1;
}

function LoadStuff()
{
    // Pick  up's
    CreateDynamicPickup(1318, 1, 2192.5781,-2077.2251,19.2743+0.5, -1,-1);
	PickUps[0] = CreateDynamicPickup(3096, 14, 1911.1316,-1776.7859,13.4193);
    PickUps[1] = CreateDynamicPickup(3096, 14, 2454.2214,-1460.9941,24.4074);
    PickUps[2] = CreateDynamicPickup(3096, 14, 1017.9522,-918.2471,43.2576);
    // Check Points
    CheckPoints[0] = CreateDynamicCP(214.3943,-98.7560,1005.2578 -1,3.0,-1, -1,-1,8.0);
    CheckPoints[1] = CreateDynamicCP(1226.1508,-1783.9065,16.0798 -1,2.0,-1, -1,-1,8.0); // blue light driving test pos spot
    CheckPoints[2] = CreateDynamicCP(-23.5236,-55.6267,1003.5469 -1,2.0,-1, -1,-1,8.0);
    CheckPoints[3] = CreateDynamicCP(380.9613,173.4053,1008.3828 -1,2.0,-1, -1,-1,8.0);// job centre
    CheckPoints[4] = CreateDynamicCP(1236.1350,-1793.9935,16.9220 -1,2.0,-1, -1,-1,8.0); // driving test
    CheckPoints[5] = CreateDynamicCP(2316.2783,-7.2265,26.7422 -1,2.0,-1, -1,-1,8.0); // Bank 1
	CheckPoints[6] = CreateDynamicCP(2315.6890,-14.7683,26.7422 -1,2.0,-1, -1,-1,8.0); // Bank 2
	CheckPoints[7] = CreateDynamicCP(2310.4409,-8.2926,26.7422 -1,2.0,-1, -1,-1,8.0); // Bank account create
	CheckPoints[8] = CreateDynamicCP(201.6670,168.5451,1003.0234 -1,2.0,-1, -1,-1,8.0); // main cell office
	CheckPoints[9] = CreateDynamicCP(2188.0686,-1983.9359,13.2307 -1,8.0,-1, -1,-1,20.0); // Junk Yard
	CheckPoints[10] = CreateDynamicCP(1226.5358,-1794.2263,16.0723 -1,2.0,-1, -1,-1,8.0); // dmv veh check
	CheckPoints[11] = CreateDynamicCP(306.3360,-141.7456,1004.0547 -1,2.0,-1, -1,-1,8.0); // gun test position
	CheckPoints[12] = CreateDynamicCP(313.7703,-133.7134,999.6016 -1,2.0,-1, -1,-1,8.0); // gun buying position
	CheckPoints[13] = CreateDynamicCP(-70.7916,-1575.9993,2.6172 -1,2.0,-1, -1,-1,8.0); // drug selling CP
	CreateDynamicPickup(1239, 1, 1226.5358,-1794.2263,16.0723);//dmv car menu
	CreateDynamicPickup(1314, 1, 1236.1350,-1793.9935,16.9220);// driving test pos spot
	CreateDynamicPickup(1314, 1, 1226.1508,-1783.9065,16.0798);// blue light driving test pos spot
    new string[115];
    for(new h = 0; h < sizeof(HouseInfo); h++)
	{
	CreateDynamicPickup(1318, 1, HouseInfo[h][hExitx], HouseInfo[h][hExity], HouseInfo[h][hExitz]+0.5, HouseInfo[h][hVirtualWorld], HouseInfo[h][hInteriorId]);
    if(HouseInfo[h][hOwned] == 0)
	{
		CreateDynamicCP(HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez] -1,3.0,-1, -1,-1,6.0);
		format(string, sizeof(string), "For Sale Cost\n\n$%d\nTax is %d%%", HouseInfo[h][hBuyPrice], HouseInfo[h][hTax]);
		CreateDynamic3DTextLabel(string ,0x01FEFEFF,HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez],40.0);
	}
	if(HouseInfo[h][hOwned] == 1)
	{
		CreateDynamicCP(HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez] -1,3.0,-1, -1,-1,6.0);
        format(string, sizeof(string), "This House Is Owned\n\nOwner Is %s",HouseInfo[h][hOwner]);
		CreateDynamic3DTextLabel(string,0x01FEFEFF,HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez],40.0);
	}
	}
    for(new b = 0; b < sizeof(BuildingInfo); b++)
	{
	CreateDynamicPickup(1318, 1, BuildingInfo[b][bExitx], BuildingInfo[b][bExity], BuildingInfo[b][bExitz]+0.5, BuildingInfo[b][bVirtualWorld], BuildingInfo[b][bInteriorId]);
    if(BuildingInfo[b][bOwned] == 1)
	{
	CreateDynamicCP(BuildingInfo[b][bEntrancex], BuildingInfo[b][bEntrancey], BuildingInfo[b][bEntrancez] -1,3.0,-1, -1,-1,6.0);
    format(string, sizeof(string), "%s\nOwned by %s",BuildingInfo[b][bDescription], BuildingInfo[b][bOwner]);
	CreateDynamic3DTextLabel(string,0x01FEFEFF,BuildingInfo[b][bEntrancex], BuildingInfo[b][bEntrancey], BuildingInfo[b][bEntrancez],40.0);
	}
	if(BuildingInfo[b][bOwned] == 0)
	{
	CreateDynamicCP(BuildingInfo[b][bEntrancex], BuildingInfo[b][bEntrancey], BuildingInfo[b][bEntrancez] -1,3.0,-1, -1,-1,6.0);
    format(string, sizeof(string), "%s\nAvailable to buy for $%d\nBuilding Tax is %d%%",BuildingInfo[b][bDescription],BuildingInfo[b][bBuyPrice],BuildingInfo[b][bTax]);
	CreateDynamic3DTextLabel(string,0x01FEFEFF,BuildingInfo[b][bEntrancex], BuildingInfo[b][bEntrancey], BuildingInfo[b][bEntrancez],40.0);
	}
	}
	for(new a = 0; a <= sizeof(Atms); a++)
	{
	CreateDynamicCP(Atms[a][0], Atms[a][1], Atms[a][2] -1,3.0,-1, -1,-1,6.0);
	}
	if(CrushCar != 0) CrushCarText = Text3D:CreateDynamic3DTextLabel("This Car Is Wanted\nFor The Junk Yard", 0x01FEFEFF, 0.0, 0.0, 0.0, 40, INVALID_PLAYER_ID, CrushCar, 0);
    return 1;
}

function OnPlayerEnterCheckpoint(playerid)
{
	new Float:x, Float:y, Float:z, Float:zz, string[80];
    switch (GetPVarInt(playerid, "CPID"))
	{
    case 0:
    SetTimerEx("PickUpBin", 1200, 0, "i", playerid),
    DisablePlayerCheckpoint(playerid),
    SetPVarInt(playerid, "CPID", -1),
    GetVehiclePos(GetPVarInt(playerid,"TrashVeh"),x,y,z),
    GetXYInFrontOfVehicle(GetPVarInt(playerid,"TrashVeh"), x, y, -5),
    SetPlayerCheckpoint(playerid, x,y,z, 2.0),
    SetPVarInt(playerid, "CPID", 1),
	SendMessage(playerid, "Now take the bin to the truck."),
	ApplyAnimation(playerid,"PED","WALK_player",4.1,1,1,1,1,500);
	case 1:
	ClearAnimations(playerid),
	DestroyObject(GetPVarInt(playerid, "BinObject")),
	SetPVarInt(playerid, "CPID", -1),
	GetVehicleZAngle(GetPVarInt(playerid,"TrashVeh"),zz),
	SetPlayerFacingAngle(playerid, zz),
	ApplyAnimation(playerid,"RYDER","Van_Throw",2.1,0,0,0,0,2000),
	GetXYInFrontOfPlayer(playerid, x, y, 1.5),
	SetPVarInt(playerid,"BinObject", CreateObject(1339, x, y, z, 0,0,zz)),
	SetTimerEx("ObjectBack", 2000, 0, "i", playerid),
	SetPlayerCheckpoint(playerid, GetPVarFloat(playerid,"Binx"),GetPVarFloat(playerid,"Biny"),GetPVarFloat(playerid,"Binz"), 1.5),
    SetPVarInt(playerid, "CPID", 2);
	case 2:
	SetTimerEx("PickUpBin", 1200, 0, "i", playerid),
	ApplyAnimation(playerid,"RYDER","Van_Throw",2.1,0,0,0,0,1000),
	DisablePlayerCheckpoint(playerid),
	SetTimerEx("KillBin", 4000, 0, "i", playerid),
	SetPVarInt(playerid, "WorkDone", GetPVarInt(playerid, "WorkDone") +1),
	SendMessage(playerid, "-----------------------------------------------------------------"),
	format(string, sizeof(string),"You have done %d/30 bin's",GetPVarInt(playerid, "WorkDone")),
	SendMessage(playerid, string),
	format(string, sizeof(string),"You are %d bin's away from your next pay check",30-GetPVarInt(playerid, "WorkDone")),
	SendMessage(playerid, string),
	SendMessage(playerid, "-----------------------------------------------------------------"),
	TogglePlayerAllDynamicCPs(playerid, 1);// 0 = off
	case 3: TogglePlayerAllDynamicCPs(playerid, 1), SetPVarInt(playerid, "CPID", -1), SendMessage(playerid, "you have reached your destination");
    case 4: if(GetPlayerState(playerid) == 1) SortJob(playerid);
    case 5: DisablePlayerCheckpoint(playerid), SetPVarInt(playerid, "WorkDone", 0),SetPVarInt(playerid, "Checks", GetPVarInt(playerid, "Checks") +1),SendMessage(playerid, "You just emptied your vehicle, your earned 1 pay check you can cash it at the bank");
	}
    return 1;
}

function PickUpBin(playerid)
{
if(GetPVarInt(playerid, "Binstat") == 1) return DestroyObject(GetPVarInt(playerid, "BinObject")), SetPVarInt(playerid,"BinObject", CreateObject(1339, GetPVarFloat(playerid,"Binx"),GetPVarFloat(playerid,"Biny"),GetPVarFloat(playerid,"Binz")+0.8,0,0,0)), SetPVarInt(playerid, "Binstat", 0);
AttachObjectToPlayer(GetPVarInt(playerid, "BinObject"), playerid, 0, 0.8, -0.3, 0.8, 0, -0.5); SetPVarInt(playerid, "Binstat", 1);
return 1;
}

function SortJob(playerid)
{
if(GetPVarInt(playerid, "WantsJob") == 1) SetPVarInt(playerid, "CPID", -1), SetPVarString(playerid,"Rank", "Nothing"), SetPVarInt(playerid, "Exp", 0), SetPVarInt(playerid, "WorkTime", 60), SetPVarInt(playerid, "Team", binman), DisablePlayerCheckpoint(playerid), TogglePlayerAllDynamicCPs(playerid, 1), GameTextForPlayer(playerid, "~P~You got the job as a bin man.", 2000, 1), SendMessage(playerid, "You can now start working by entering a trash master vehicle.");
else if(GetPVarInt(playerid, "WantsJob") == 2) SetPVarInt(playerid, "CPID", -1), SetPVarString(playerid,"Rank", "Nothing"), SetPVarInt(playerid, "Exp", 0), SetPVarInt(playerid, "WorkTime", 60), SetPVarInt(playerid, "Team", fireman), DisablePlayerCheckpoint(playerid), TogglePlayerAllDynamicCPs(playerid, 1), GameTextForPlayer(playerid, "~P~You got the job as a fire man.", 2000, 1), SendMessage(playerid, "You can now start working by entering a Fire Truck.");
else if(GetPVarInt(playerid, "WantsJob") == 3) SetPVarInt(playerid, "CPID", -1), SetPVarString(playerid,"Rank", "Nothing"), SetPVarInt(playerid, "Exp", 0), SetPVarInt(playerid, "WorkTime", 60), SetPVarInt(playerid, "Team", cop), DisablePlayerCheckpoint(playerid), TogglePlayerAllDynamicCPs(playerid, 1), GameTextForPlayer(playerid, "~P~You got the job as a police officer.", 2000, 1), SendMessage(playerid, "You can now start working.");
else if(GetPVarInt(playerid, "WantsJob") == 4) SetPVarInt(playerid, "CPID", -1), SetPVarInt(playerid, "WorkTime", 60), SetPVarInt(playerid, "Team", civ), SetPVarInt(playerid, "Checks", GetPVarInt(playerid, "Checks") +1), TogglePlayerAllDynamicCPs(playerid, 1), SendMessage(playerid, "You now must sign on every 1 hour for $60.");
return 1;
}

function KillBin(playerid)
{
DestroyObject(GetPVarInt(playerid, "BinObject")),
SetPVarInt(playerid, "BinObject", 0);
return 1;
}

function ObjectBack(playerid)
{
SendMessage(playerid, "Now take the bin back.");
AttachObjectToPlayer(GetPVarInt(playerid, "BinObject"), playerid, 0, 0.8, -0.3, 0.8, 0, -0.5);
ApplyAnimation(playerid,"PED","WALK_player",4.1,1,1,1,1,500);
return 1;
}

function followcop(playerid)
{
new Float:x,Float:y,Float:z;
new int1, int2, world;
int1 = GetPlayerInterior(playerid);
int2 = GetPlayerInterior(GetPVarInt(playerid, "Stopping"));
world = GetPlayerVirtualWorld(GetPVarInt(playerid, "Stopping"));
GetPlayerPos(GetPVarInt(playerid, "Stopping"), x,y,z);
GetXYInFrontOfPlayer(GetPVarInt(playerid, "Stopping"), x, y, 1.5);
if(IsPlayerInRangeOfPoint(playerid, 3, x,y,z) && GetPVarInt(playerid,"WalkingTo") == 1 && GetPVarInt(playerid, "InCar") == 0) return SetPVarInt(playerid, "WalkingTo", 0), ClearAnimations(playerid);
if(!IsPlayerInRangeOfPoint(playerid, 4.5, x,y,z))
if(IsPlayerInAnyVehicle(playerid) && !IsPlayerInAnyVehicle(GetPVarInt(playerid, "Stopping"))) RemovePlayerFromVehicle(playerid);
if(GetPVarInt(playerid, "InCar") == 0)
SetPlayerToFacePlayer(playerid, GetPVarInt(playerid, "Stopping")),
SetPVarInt(playerid, "WalkingTo", 1),
ApplyAnimation(playerid,"PED","WALK_player",4.1,1,1,1,1,0);
new car = GetPlayerVehicleID(GetPVarInt(playerid, "Stopping"));
if(IsPlayerInAnyVehicle(GetPVarInt(playerid, "Stopping")) && GetPVarInt(playerid, "InCar") == 0)
ClearAnimations(playerid), SetPVarInt(playerid, "InCar", 1), SendToVeh(playerid, car);
if(int1 != int2) SetPlayerInterior(playerid, int2), SetPlayerVirtualWorld(playerid, world), SetPlayerPos(playerid, x,y+2,z);
return 1;
}

function SendToVeh(playerid, vehicleid)
{
new seat;
if(SeatTaken[1][vehicleid] == 0) seat = 1;
else if(SeatTaken[1][vehicleid] == 1) seat = 2;
if(SeatTaken[2][vehicleid] == 1 && seat == 1) seat = 3;
else if(SeatTaken[3][vehicleid] == 1) seat = 4;
if(seat == 2 || seat == 3 || seat == 1) PutPlayerInVehicle(playerid, vehicleid, seat);
if(seat == 4) GameTextForPlayer(playerid, "~W~Waiting for a seat..", 1000, 1);
return 1;
}
function OnPlayerEnterDynamicArea(playerid, areaid)
{
if(areaid == fireat[0])
{
if(GetPVarInt(playerid,"Team") == fireman)
SendMessage(playerid, "You arrived at the buring building."),
DisablePlayerCheckpoint(playerid),
GameTextForPlayer(playerid, "~w~Aim your hose at the windows and shoot water at the flames.", 3000, 3);
}
return 1;
}

function OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
new carid = GetPlayerVehicleID(playerid), Float:health;
GetVehicleHealth(carid, health);
if(pickupid == PickUps[0] || PickUps[1] || PickUps[2])
{
if(IsPlayerInAnyVehicle(playerid))
{
if(health > 999)return SendMessage(playerid, "Your Vehicle doesn't need repairing.");
SendMessage(playerid, "You have paid $50 for a vehicle repair.");
RepairVehicle(carid);UpdateVehicles(carid);
GivePlayerCash(playerid, -50), PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
return 1;
}
}
return 1;
}

stock CopCar(vehicleid)
{
	if(GetVehicleModel(vehicleid) == 596 || GetVehicleModel(vehicleid) == 427 || GetVehicleModel(vehicleid) == 428 || GetVehicleModel(vehicleid) == 490 || GetVehicleModel(vehicleid) == 523
	|| GetVehicleModel(vehicleid) == 597 || GetVehicleModel(vehicleid) == 598 || GetVehicleModel(vehicleid) == 599 || GetVehicleModel(vehicleid) == 432 || GetVehicleModel(vehicleid) == 601
	|| GetVehicleModel(vehicleid) == 497 || GetVehicleModel(vehicleid) == 563 || GetVehicleModel(vehicleid) == 472 || GetVehicleModel(vehicleid) == 433 || GetVehicleModel(vehicleid) == 470
    || GetVehicleModel(vehicleid) == 432 || GetVehicleModel(vehicleid) == 425 || GetVehicleModel(vehicleid) == 520 || GetVehicleModel(vehicleid) == 407)
	{
	return 1;
	}
	return 0;
}

stock FireCar(vehicleid)
{
	if(GetVehicleModel(vehicleid) == 407 || GetVehicleModel(vehicleid) == 544)return 1;
/*	vehicleid = vehinfo[vehicleid][cVehid];
	if(vehicleid == 25 || vehicleid == 26)return 1;*/
	return 0;
}

function StartCrush(playerid, vehicleid)
{
if(CrushCar != 0) DestroyDynamic3DTextLabel(Text3D:CrushCarText);
if(SeatTaken[0][vehicleid] == 1)SeatTaken[0][vehicleid] = 0;
new string[80], Float:Health, vehsplit, ammount;
GetVehicleHealth(vehicleid, Health);
if(Health < 300) vehsplit = 7;
else if(Health > 300) vehsplit = 7;
else if(Health > 400) vehsplit = 6;
else if(Health > 500) vehsplit = 5;
else if(Health > 600) vehsplit = 4;
else if(Health > 700) vehsplit = 3;
else if(Health > 800) vehsplit = 2;
else if(Health > 900) vehsplit = 1;
else if(Health >= 999) vehsplit = 0;
UpdateVehicleDamageStatus(vehicleid, 36831250, 131587, 3, 4);
SetVehicleHealth(vehicleid,400);
glassob = CreateDynamicObject(4206, 2196.4106445313, -1989.4514160156, 21.171939849854, 0, 0, 0);
Streamer_UpdateEx(playerid, 2196.1318,-1991.4177,22.4649);
SetVehiclePos(vehicleid, 2196.1318,-1991.4177,22.4649);
SetVehicleZAngle(vehicleid, 177.3551);
SetTimer("delglass", 4000, 0);
SetTimerEx("DoneCrushCar", 6000, 0, "i", vehicleid);
if(vehinfo[vehicleid][cValue] == 0) ammount = random(1500)+500;
if(vehinfo[vehicleid][cValue] > 0) ammount = vehinfo[vehicleid][cValue];
if(vehsplit > 0) SendMessage(playerid, "If you bring the vehicle to us not damaged we won't divided the vehicle's value.");
if(vehsplit > 0) format(string, sizeof(string), "The value of the %s was divided by %d", vehinfo[vehicleid][cName], vehsplit), SendMessage(playerid, string);
else if(vehsplit > 0) format(string, sizeof(string), "You earned $%d for bringing us the vehicle %s",ammount/vehsplit, vehinfo[vehicleid][cName]), SendMessage(playerid, string);
else if(vehsplit == 0) format(string, sizeof(string), "You earned $%d for bringing us the vehicle %s",ammount, vehinfo[vehicleid][cName]), SendMessage(playerid, string);
if(vehsplit > 0)GivePlayerCash(playerid, ammount/vehsplit);
else if(vehsplit == 0) GivePlayerCash(playerid, ammount);
CrushCar = 0;
return 1;
}

function DoneCrushCar(vehicleid)
{
SetVehicleToRespawn(vehicleid);
return 1;
}

function delglass()
{
DestroyDynamicObject(glassob);
return 1;
}

function OnPlayerEnterDynamicCP(playerid, checkpointid)
{
new tmp[150];
if(checkpointid == CheckPoints[9] && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(playerid) == CrushCar) SetPlayerPos(playerid, 2185.9004,-1977.4478,13.5526), StartCrush(playerid, CrushCar);
if(checkpointid == CheckPoints[9] && CrushCar != 0 && GetPlayerVehicleID(playerid) != CrushCar)
{
format(tmp, sizeof(tmp), "we want a %s~N~ ~N~The vehicle has been marked", vehinfo[CrushCar][cName]);
SetPVarInt(playerid, "BuildingName", _:TextDrawCreate(21.000000,109.000000, tmp));
TextDrawUseBox(Text:GetPVarInt(playerid, "BuildingName"),1);
TextDrawBoxColor(Text:GetPVarInt(playerid, "BuildingName"),0x00000066);
TextDrawTextSize(Text:GetPVarInt(playerid, "BuildingName"),291.000000,-5.000000);
TextDrawAlignment(Text:GetPVarInt(playerid, "BuildingName"),0);
TextDrawBackgroundColor(Text:GetPVarInt(playerid, "BuildingName"),0xff000066);
TextDrawFont(Text:GetPVarInt(playerid, "BuildingName"),2);
TextDrawLetterSize(Text:GetPVarInt(playerid, "BuildingName"),0.399999,1.500000);
TextDrawColor(Text:GetPVarInt(playerid, "BuildingName"),0xffffffff);
TextDrawSetProportional(Text:GetPVarInt(playerid, "BuildingName"),1);
TextDrawSetShadow(Text:GetPVarInt(playerid, "BuildingName"),1);
TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid, "BuildingName"));
SetPVarInt(playerid, "LookingBuildingName", 1);
}
if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 0;
ClearTextDraws(playerid);
for(new b = 0; b < sizeof(BuildingInfo); b++)
{
if(IsPlayerInRangeOfPoint(playerid, 3.0, BuildingInfo[b][bEntrancex], BuildingInfo[b][bEntrancey], BuildingInfo[b][bEntrancez]) && GetPVarInt(playerid, "LoggedIn") == 1)
{
if(BuildingInfo[b][bOwned] == 1 && GetPVarInt(playerid, "ShareId") != b)format(tmp, sizeof(tmp), "This is the %s ~N~ ~N~Hit ALT Key to buy Shares~N~ ~N~Hit Enter key to Enter", BuildingInfo[b][bDescription]), SetPVarInt(playerid, "WantToRent", b);
else if(BuildingInfo[b][bOwned] == 1 && GetPVarInt(playerid, "ShareId") == b)format(tmp, sizeof(tmp), "This is the %s ~N~ ~N~You own Shares of this building~N~ ~N~Hit Enter key to Enter", BuildingInfo[b][bDescription]);
else if(BuildingInfo[b][bOwned] == 0)format(tmp, sizeof(tmp), "This is the %s ~N~ ~N~Hit Enter key to Enter~N~ ~N~Hit ALT key to buy building", BuildingInfo[b][bDescription]), SetPVarInt(playerid, "BuyingBuilding", b);


SetPVarInt(playerid, "BuildingName", _:TextDrawCreate(21.000000,109.000000, tmp));
TextDrawUseBox(Text:GetPVarInt(playerid, "BuildingName"),1);
TextDrawBoxColor(Text:GetPVarInt(playerid, "BuildingName"),0x00000066);
TextDrawTextSize(Text:GetPVarInt(playerid, "BuildingName"),291.000000,-5.000000);
TextDrawAlignment(Text:GetPVarInt(playerid, "BuildingName"),0);
TextDrawBackgroundColor(Text:GetPVarInt(playerid, "BuildingName"),0xff000066);
TextDrawFont(Text:GetPVarInt(playerid, "BuildingName"),2);
TextDrawLetterSize(Text:GetPVarInt(playerid, "BuildingName"),0.399999,1.500000);
TextDrawColor(Text:GetPVarInt(playerid, "BuildingName"),0xffffffff);
TextDrawSetProportional(Text:GetPVarInt(playerid, "BuildingName"),1);
TextDrawSetShadow(Text:GetPVarInt(playerid, "BuildingName"),1);
TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid, "BuildingName"));
SetPVarInt(playerid, "LookingBuildingName", 1);
}
}
for(new h = 0; h < sizeof(HouseInfo); h++)
{
if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez]) && GetPVarInt(playerid, "LoggedIn") == 1)
{
if(HouseInfo[h][hOwned] == 1 && GetPVarInt(playerid, "RentId") != h && HouseInfo[h][hRentable] == 0)format(tmp, sizeof(tmp), "This is %s House ~N~ ~N~Its Not For Rent~N~ ~N~Hit Enter key to Enter", HouseInfo[h][hOwner]);
else if(HouseInfo[h][hOwned] == 1 && GetPVarInt(playerid, "RentId") != h && HouseInfo[h][hRentable] == 1)format(tmp, sizeof(tmp), "This is %s House ~N~ ~N~Hit ALT To rent A room~N~ ~N~Hit Enter key to Enter", HouseInfo[h][hOwner], SetPVarInt(playerid, "WantToRent", h));
else if(HouseInfo[h][hOwned] == 1 && GetPVarInt(playerid, "RentId") == h && HouseInfo[h][hRentable] == 1)format(tmp, sizeof(tmp), "This is %s House ~N~ ~N~You Rent A Room Here~N~ ~N~Hit Enter key to Enter", HouseInfo[h][hOwner]);
else if(HouseInfo[h][hOwned] == 0)format(tmp, sizeof(tmp), "%s %d Rooms ~N~ ~N~Hit Enter key to Enter~N~ ~N~Hit ALT key to buy house", HouseInfo[h][hDescription], HouseInfo[h][hRooms]), SetPVarInt(playerid, "BuyingBuilding", h);


SetPVarInt(playerid, "BuildingName", _:TextDrawCreate(21.000000,109.000000, tmp));
TextDrawUseBox(Text:GetPVarInt(playerid, "BuildingName"),1);
TextDrawBoxColor(Text:GetPVarInt(playerid, "BuildingName"),0x00000066);
TextDrawTextSize(Text:GetPVarInt(playerid, "BuildingName"),291.000000,-5.000000);
TextDrawAlignment(Text:GetPVarInt(playerid, "BuildingName"),0);
TextDrawBackgroundColor(Text:GetPVarInt(playerid, "BuildingName"),0xff000066);
TextDrawFont(Text:GetPVarInt(playerid, "BuildingName"),2);
TextDrawLetterSize(Text:GetPVarInt(playerid, "BuildingName"),0.399999,1.500000);
TextDrawColor(Text:GetPVarInt(playerid, "BuildingName"),0xffffffff);
TextDrawSetProportional(Text:GetPVarInt(playerid, "BuildingName"),1);
TextDrawSetShadow(Text:GetPVarInt(playerid, "BuildingName"),1);
TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid, "BuildingName"));
SetPVarInt(playerid, "LookingBuildingName", 1);
}
}
if(checkpointid == CheckPoints[0])
{
if(GetPlayerCash(playerid) < 1000) return SendMessage(playerid, "You need $1000 to buy new clothes.");
ShowPlayerDialog(playerid,8,DIALOG_STYLE_MSGBOX,"Wardrobe","Do you want to buy new clothes?","Yes","No");
}

if(checkpointid == CheckPoints[1])
{
format(tmp, sizeof(tmp), "Blue Light Driving Test Level %d",GetPVarInt(playerid, "TestStep")+1);
ShowPlayerDialog(playerid, 28, DIALOG_STYLE_MSGBOX,"Police Training",tmp,"Select","Close");
if(GetPVarInt(playerid, "TestStep") > 4) ShowPlayerDialog(playerid, 28, DIALOG_STYLE_MSGBOX,"Police Training","You have done all of the driving test\n\nSo this is just practice","Select","Close");
}
if(checkpointid == CheckPoints[2])ShowPlayerDialog(playerid, 30, DIALOG_STYLE_LIST,"Shop List","Mobile Phone $100\nCalling Credit $10\nWatch $25\nPick Lock $75\nScrew Driver$ 75\nSkeleton Key $30,000","Select","Go Back");
if(checkpointid == CheckPoints[3])
{
if(injobmeeting == 1) return SendMessage(playerid, "Please wait someone is already in a meeting.");
if(GetPVarInt(playerid, "Team") != civ)  SendMessage(playerid, "NOTICE: You already have a job once you change job you will lose all your Exp for your current job.");
ShowPlayerDialog(playerid, 44, DIALOG_STYLE_LIST, "Job Centre Job Selection", "Bin Man $145 Per Pay Check\nFire Man $150 Per Pay Check\nPolice Officer $155 Per Pay Check\nSign On (Welfare) $60 Per Pay Check", "Select", "Close");
}
if(checkpointid == CheckPoints[4])
{
format(tmp, sizeof(tmp), "Do you want to take your driving test? you are %d/4 complete", GetPVarInt(playerid, "DT"));
ShowPlayerDialog(playerid,46,DIALOG_STYLE_MSGBOX,"Driving Test", tmp,"Yes","No");
}
if(checkpointid == CheckPoints[5] || checkpointid == CheckPoints[6])
{
if(GetPVarInt(playerid, "BankCode") == 0) return SendMessage(playerid, "You need to open a bank account first.");
ShowPlayerDialog(playerid,52,DIALOG_STYLE_INPUT,"Confirm Your Bank Code","Please enter your 4 digit bank code","Enter","Close");
}
if(checkpointid == CheckPoints[7])
{
if(GetPVarInt(playerid, "BankCode") != 0) return SendMessage(playerid, "You already have a bank account.");
ShowPlayerDialog(playerid,50,DIALOG_STYLE_INPUT,"Open A Bank Account","Please enter a 4 digit code","Create","Close");
}
if(checkpointid == CheckPoints[8])
{
if(GetPVarInt(playerid, "Team") != cop) return 1;
if(GetPVarInt(playerid, "Holding") == 0) return SendMessage(playerid, "You must have someone cuff to put them in the cell's.");
ShowPlayerDialog(playerid, 53, DIALOG_STYLE_LIST, "Jail Process", "Search Suspect\nRemove a License\nArrest Suspect", "Select", "Close");
}
if(checkpointid == CheckPoints[10])
{
SetPVarInt(playerid, "InDMV", 1);
CheckVeh(playerid);
}
if(checkpointid == CheckPoints[11]) ShowPlayerDialog(playerid, 56, DIALOG_STYLE_LIST, "Weapon Training", "Pistol Training\nShotgun Training\nUzi Training\nAk47 Training\nRifle Training (Not Required Still Under Work)", "Select", "Back");
if(checkpointid == CheckPoints[12]) ShowPlayerDialog(playerid, 83, DIALOG_STYLE_LIST, "Weapon Store Menu", "Pistol (25 bullets) $90\nShotgun (25 bullets) $130\nUzi (50 bullets) £200\nAk47 (50 bullets) $250\nRifle (10 bullets) $270", "Select", "Back");
if(checkpointid == CheckPoints[13]) ShowPlayerDialog(playerid,84,DIALOG_STYLE_MSGBOX,"Buying Seeds?","Drug Dealer Says: Do you want to buy a seed from me for $50?\n\nDrug Dealer Says: Hurry I don't have all day.","Yes","No");
for(new i = 0; i <= sizeof(Atms); i++)
{
if(IsPlayerInRangeOfPoint(playerid, 3, Atms[i][0], Atms[i][1], Atms[i][2]) && GetPlayerState(playerid) == 1)
{
if(GetPVarInt(playerid, "BankCode") == 0) return SendMessage(playerid, "You need to open a bank account first.");
ShowPlayerDialog(playerid,52,DIALOG_STYLE_INPUT,"Confirm Your Bank Code","Please enter your 4 digit bank code","Enter","Close");
SetPVarInt(playerid, "ATMS", 1);
}
}
return 1;
}

function OnPlayerLeaveDynamicCP(playerid, checkpointid)
{
if(checkpointid == CheckPoints[9] && CrushCar != 0 && GetPlayerVehicleID(playerid) != CrushCar) ClearTextDraws(playerid);
if(GetPVarInt(playerid, "BuyingBuilding") != 0) SetPVarInt(playerid, "BuyingBuilding", 0);
if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 0;
ClearTextDraws(playerid);
return 1;
}

function ClearTextDraws(playerid)
{
if(GetPVarInt(playerid, "LookingBuildingName") == 1)
TextDrawDestroy(Text:GetPVarInt(playerid, "BuildingName")),
SetPVarInt(playerid, "LookingBuildingName", 0);

if(GetPVarInt(playerid, "FadeOn") == 1)
TextDrawDestroy(Text:GetPVarInt(playerid, "Fade")),
SetPVarInt(playerid, "FadeOn", 0);

if(GetPVarInt(playerid, "ClassText") != 0)
TextDrawDestroy(Text:GetPVarInt(playerid, "ClassText")),
SetPVarInt(playerid, "ClassText", 0);

if(GetPVarInt(playerid, "LookingTextDraw0") == 1)
TextDrawHideForPlayer(playerid, Text:GetPVarInt(playerid, "FuelText")),
TextDrawHideForPlayer(playerid, Text:FuelText1[0]),
TextDrawHideForPlayer(playerid, Text:FuelText1[1]),
SetPVarInt(playerid, "LookingTextDraw0", 0);

if(GetPVarInt(playerid, "LookingTextDraw1") == 1)
TextDrawDestroy(Text:GetPVarInt(playerid, "CarBuy")),
SetPVarInt(playerid, "LookingTextDraw1", 0);

if(GetPVarInt(playerid, "VehicleTextDraw") == 1 && GetPVarInt(playerid, "JustDied") == 1){
SetPVarInt(playerid, "VehicleTextDraw", 0);
SetPVarInt(playerid, "JustDied", 0);
for(new i; i < 4; i++)TextDrawHideForPlayer(playerid, TextDrawsd[playerid][i]);
for(new i; i < 11; i++)TextDrawHideForPlayer(playerid, TextDraws[TDSpeedClock][i]);
if(GetPVarInt(playerid, "LookingTextDraw3") == 1)
SetPVarInt(playerid, "LookingTextDraw3", 0),
TextDrawHideForPlayer(playerid, TextDrawsd[playerid][4]);
}
return 1;
}

function donespawn(playerid)
{
TogglePlayerControllable(playerid, 1);
if(GetPVarInt(playerid, "WalkOut") != 0)ApplyAnimation(playerid,"CRACK","crckidle4",4.1,0,1,1,0,9000);
return 1;
}

function OnPlayerEnterRaceCheckpoint(playerid)
{
// cop driving test.
if(GetPVarInt(playerid, "CopTrain1")) SetPVarInt(playerid, "CopTrain2",  SetPlayerRaceCheckpoint(playerid,0,1275.6063,217.9165,19.1099, 1329.9219,232.3244,19.1093,4)),SetPVarInt(playerid, "CopTrain1", 0);
else if(GetPVarInt(playerid, "CopTrain2")) SetPVarInt(playerid, "CopTrain3",  SetPlayerRaceCheckpoint(playerid,0,1329.9219,232.3244,19.1093, 1352.4492,269.7896,19.1115,4)),SetPVarInt(playerid, "CopTrain2", 0);
else if(GetPVarInt(playerid, "CopTrain3")) SetPVarInt(playerid, "CopTrain4",  SetPlayerRaceCheckpoint(playerid,0,1352.4492,269.7896,19.1115, 1325.8640,312.9008,19.1018,4)),SetPVarInt(playerid, "CopTrain3", 0);
else if(GetPVarInt(playerid, "CopTrain4")) SetPVarInt(playerid, "CopTrain5",  SetPlayerRaceCheckpoint(playerid,0,1325.8640,312.9008,19.1018, 1314.5371,369.2138,19.1121,4)),SetPVarInt(playerid, "CopTrain4", 0);
else if(GetPVarInt(playerid, "CopTrain5")) SetPVarInt(playerid, "CopTrain6",  SetPlayerRaceCheckpoint(playerid,0,1314.5371,369.2138,19.1121, 1273.6572,339.8333,19.1113,4)),SetPVarInt(playerid, "CopTrain5", 0);
else if(GetPVarInt(playerid, "CopTrain6")) SetPVarInt(playerid, "CopTrain7",  SetPlayerRaceCheckpoint(playerid,0,1273.6572,339.8333,19.1113, 1236.7424,348.0139,19.1116,4)),SetPVarInt(playerid, "CopTrain6", 0);
else if(GetPVarInt(playerid, "CopTrain7")) SetPVarInt(playerid, "CopTrain8",  SetPlayerRaceCheckpoint(playerid,0,1236.7424,348.0139,19.1116, 1205.3705,299.9421,19.1109,4)),SetPVarInt(playerid, "CopTrain7", 0);
else if(GetPVarInt(playerid, "CopTrain8")) SetPVarInt(playerid, "CopTrain9",  SetPlayerRaceCheckpoint(playerid,0,1205.3705,299.9421,19.1109, 1239.7429,271.5751,19.1097,4)),SetPVarInt(playerid, "CopTrain8", 0);
else if(GetPVarInt(playerid, "CopTrain9")) SetPVarInt(playerid, "CopTrain10",  SetPlayerRaceCheckpoint(playerid,0,1239.7429,271.5751,19.1097, 1223.5779,224.5069,19.1100,4)),SetPVarInt(playerid, "CopTrain9", 0);
else if(GetPVarInt(playerid, "CopTrain10")) SetPVarInt(playerid, "CopTrain11",  SetPlayerRaceCheckpoint(playerid,0,1223.5779,224.5069,19.1100, 1240.1515,192.8205,19.1143,4)),SetPVarInt(playerid, "CopTrain10", 0);
else if(GetPVarInt(playerid, "CopTrain11")) SetPVarInt(playerid, "CopTrain12",  SetPlayerRaceCheckpoint(playerid,1,1240.1515,192.8205,19.1143, 0.0,0.0,0.0,4)),SetPVarInt(playerid, "CopTrain11", 0);
else if(GetPVarInt(playerid, "CopTrain12")) SetPVarInt(playerid, "CopTrain12", 0), TestDone(playerid);
// Player's driving test
if(GetPVarInt(playerid, "Step1")) SetPVarInt(playerid, "Step2",  SetPlayerRaceCheckpoint(playerid,0,1065.0127,-1849.8923,13.2732, 1035.3231,-1800.2351,13.5477, 4)),SetPVarInt(playerid, "Step1", 0);
else if(GetPVarInt(playerid, "Step2")) SetPVarInt(playerid, "Step3",  SetPlayerRaceCheckpoint(playerid,0,1035.3231,-1800.2351,13.5477, 1039.7151,-1576.8107,13.2595,4)),SetPVarInt(playerid, "Step2", 0);
else if(GetPVarInt(playerid, "Step3")) SetPVarInt(playerid, "Step4",  SetPlayerRaceCheckpoint(playerid,0,1039.7151,-1576.8107,13.2595, 1197.8837,-1574.7455,13.2578,4)),SetPVarInt(playerid, "Step3", 0);
else if(GetPVarInt(playerid, "Step4")) SetPVarInt(playerid, "Step5",  SetPlayerRaceCheckpoint(playerid,0,1197.9285,-1406.9086,13.1228, 1392.4169,-1407.1395,13.2577,4)),SetPVarInt(playerid, "Step4", 0);
else if(GetPVarInt(playerid, "Step5")) SetPVarInt(playerid, "Step6",  SetPlayerRaceCheckpoint(playerid,0,1392.4169,-1407.1395,13.2577, 1451.9023,-1446.1791,13.2585,4)),SetPVarInt(playerid, "Step5", 0);
else if(GetPVarInt(playerid, "Step6")) SetPVarInt(playerid, "Step7",  SetPlayerRaceCheckpoint(playerid,0,1451.9023,-1446.1791,13.2585, 1426.2758,-1588.4100,13.2616,4)),SetPVarInt(playerid, "Step6", 0);
else if(GetPVarInt(playerid, "Step7")) SetPVarInt(playerid, "Step8",  SetPlayerRaceCheckpoint(playerid,0,1426.2758,-1588.4100,13.2616, 1525.9324,-1594.9265,13.2636,4)),SetPVarInt(playerid, "Step7", 0);
else if(GetPVarInt(playerid, "Step8")) SetPVarInt(playerid, "Step9",  SetPlayerRaceCheckpoint(playerid,0,1525.9324,-1594.9265,13.2636, 1525.8640,-1730.4182,13.2613,4)),SetPVarInt(playerid, "Step8", 0);
else if(GetPVarInt(playerid, "Step9")) SetPVarInt(playerid, "Step10",  SetPlayerRaceCheckpoint(playerid,0,1525.8640,-1730.4182,13.2613, 1389.1265,-1732.3602,13.2617,4)),SetPVarInt(playerid, "Step9", 0);
else if(GetPVarInt(playerid, "Step10")) SetPVarInt(playerid, "Step11",  SetPlayerRaceCheckpoint(playerid,0,1389.1265,-1732.3602,13.2617, 1385.1390,-1869.2615,13.2638,4)),SetPVarInt(playerid, "Step10", 0);
else if(GetPVarInt(playerid, "Step11")) SetPVarInt(playerid, "Step12",  SetPlayerRaceCheckpoint(playerid,0,1385.1390,-1869.2615,13.2638, 1216.0088,-1850.1407,13.2576,4)),SetPVarInt(playerid, "Step11", 0);
else if(GetPVarInt(playerid, "Step12")) SetPVarInt(playerid, "Step13",  SetPlayerRaceCheckpoint(playerid,0,1216.0088,-1850.1407,13.2576, 1212.6187,-1828.1941,13.2833,4)),SetPVarInt(playerid, "Step12", 0);
else if(GetPVarInt(playerid, "Step13")) SetPVarInt(playerid, "Step14",  SetPlayerRaceCheckpoint(playerid,1,1212.6187,-1828.1941,13.2833, 0.0,0.0,0.0,4)),SetPVarInt(playerid, "Step13", 0);
else if(GetPVarInt(playerid, "Step14")) SetPVarInt(playerid, "Step14", 0), DTestDone(playerid);
return 1;
}

function StartDrivingTest(playerid)
{
SetPlayerVirtualWorld(playerid, 0);
SetPlayerInterior(playerid, 0);
SetPVarInt(playerid, "Step1", SetPlayerRaceCheckpoint(playerid,0,1215.0952,-1849.1439,13.2577, 1065.0127,-1849.8923,13.2732, 4));
SetPVarInt(playerid, "DrivingTestVar", SetTimerEx("DrivingTesta", 1000, 1, "i", playerid));
if(GetPVarInt(playerid, "DT") == 0) SetPVarInt(playerid, "TestTime", 300);
else if(GetPVarInt(playerid, "DT") == 1) SetPVarInt(playerid, "TestTime", 250);
else if(GetPVarInt(playerid, "DT") == 2) SetPVarInt(playerid, "TestTime", 200);
else if(GetPVarInt(playerid, "DT") == 3) SetPVarInt(playerid, "TestTime", 150);
else if(GetPVarInt(playerid, "DT") == 4) SetPVarInt(playerid, "TestTime", 120);
PutPlayerInVehicle(playerid, 61, 0);
SetVehiclePos(61 ,1215.2887,-1828.5789,13.2900);
SetVehicleZAngle(61, 179.4574);
engineOn[61] = true;
Vgas[61] = 97;
GameTextForPlayer(playerid, "~r~Don't damage the car", 2000, 3);
return 1;
}

function DTestDone(playerid)
{
new Float: hp;
GetVehicleHealth(61, hp);
if(hp < 970) return
ClearDrivingTest(playerid),
SendMessage(playerid, "Sorry this vehicle is to damaged you must retake your test."),
RemovePlayerFromVehicle(playerid),
SetVehicleToRespawn(61),
SetPVarInt(playerid, "TestTime", 0);// split
UpExp(playerid);
ClearDrivingTest(playerid);
SendMessage(playerid, "Your Exp ++");
new tmp[80];
format(tmp, sizeof(tmp), "~g~Driving Test Level %d Passed", GetPVarInt(playerid, "DT")+1);
GameTextForPlayer(playerid, tmp, 2000, 1);
format(tmp, sizeof(tmp), "You have Passed %d/4 Test", GetPVarInt(playerid, "DT")+1);
SendMessage(playerid, tmp);
SetPVarInt(playerid, "DT", GetPVarInt(playerid, "DT") +1);
if(GetPVarInt(playerid, "DT") == 4)
SetPVarInt(playerid, "License", 1),
SendMessage(playerid, "You Just Earned Your Driving License.");
RemovePlayerFromVehicle(playerid);
SetVehicleToRespawn(61);
SetPVarInt(playerid, "TestTime", 0);
return 1;
}

function DrivingTesta(playerid)
{
if(GetPVarInt(playerid, "TestTime") == 0) return
ClearDrivingTest(playerid),
GameTextForPlayer(playerid, "~r~Driving Test Failed", 2000, 1),
RemovePlayerFromVehicle(playerid),
SetVehicleToRespawn(61),
SetPVarInt(playerid, "TestTime", 0);

new tmp[100];
SetPVarInt(playerid, "TestTime", GetPVarInt(playerid, "TestTime") -1);
format(tmp, sizeof(tmp), "You have: %d Second's Left", GetPVarInt(playerid, "TestTime"));
if(GetPVarInt(playerid, "CopTextDraw") == 1) return
TextDrawSetString(Text:GetPVarInt(playerid,"CopTest"), tmp),
TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid,"CopTest"));

SetPVarInt(playerid, "CopTest", _:TextDrawCreate(481.000000,141.000000,tmp));
TextDrawUseBox(Text:GetPVarInt(playerid,"CopTest"),1);
TextDrawBoxColor(Text:GetPVarInt(playerid,"CopTest"),0x00000099);
TextDrawTextSize(Text:GetPVarInt(playerid,"CopTest"),620.000000,-12.000000);
TextDrawAlignment(Text:GetPVarInt(playerid,"CopTest"),0);
TextDrawBackgroundColor(Text:GetPVarInt(playerid,"CopTest"),0x0000ffff);
TextDrawFont(Text:GetPVarInt(playerid,"CopTest"),1);
TextDrawLetterSize(Text:GetPVarInt(playerid,"CopTest"),0.299999,0.899999);
TextDrawColor(Text:GetPVarInt(playerid,"CopTest"),0xffffffff);
TextDrawSetProportional(Text:GetPVarInt(playerid,"CopTest"),1);
TextDrawSetShadow(Text:GetPVarInt(playerid,"CopTest"),1);
SetPVarInt(playerid, "CopTextDraw", 1);
return 1;
}

function ClearDrivingTest(playerid)
{
DeletePVar(playerid,"Step1");
DeletePVar(playerid,"Step2");
DeletePVar(playerid,"Step3");
DeletePVar(playerid,"Step4");
DeletePVar(playerid,"Step5");
DeletePVar(playerid,"Step6");
DeletePVar(playerid,"Step7");
DeletePVar(playerid,"Step8");
DeletePVar(playerid,"Step9");
DeletePVar(playerid,"Step10");
DeletePVar(playerid,"Step11");
DeletePVar(playerid,"Step12");
DeletePVar(playerid,"Step13");
DeletePVar(playerid,"Step14");
TextDrawDestroy(Text:GetPVarInt(playerid,"CopTest"));
KillTimer(GetPVarInt(playerid, "DrivingTestVar"));
SetPVarInt(playerid, "DrivingTestVar", 0);
DisablePlayerRaceCheckpoint(playerid);
SetPVarInt(playerid, "CopTextDraw", 0);
drivingtest = 0;
SetPlayerPos(playerid, 1215.2887,-1828.5789,13.2900);
SetPlayerInterior(playerid, 0);
SetPlayerVirtualWorld(playerid, 0);
return 1;
}

function TestDone(playerid)
{
UpExp(playerid);
ClearCopTest(playerid);
SendMessage(playerid, "Your Exp ++");
new tmp[80];
format(tmp, sizeof(tmp), "~g~Driving Test Level %d Passed", GetPVarInt(playerid, "TestStep")+1);
GameTextForPlayer(playerid, tmp, 2000, 1);
SetPVarInt(playerid, "TestStep", GetPVarInt(playerid, "TestStep") +1);
if(GetPVarInt(playerid, "TestStep") == 5)
SetPVarInt(playerid, "License", 2),
SendMessage(playerid, "You Just Earned Your Blue Light License.");

RemovePlayerFromVehicle(playerid);
SetVehicleToRespawn(24);
SetPVarInt(playerid, "TestTime", 0);
return 1;
}

function CopTesta(playerid)
{
if(GetPVarInt(playerid, "TestTime") == 0) return
ClearCopTest(playerid),
GameTextForPlayer(playerid, "~r~Driving Test Failed", 2000, 1),
RemovePlayerFromVehicle(playerid),
SetVehicleToRespawn(24),
SetPVarInt(playerid, "TestTime", 0);

new tmp[100];
SetPVarInt(playerid, "TestTime", GetPVarInt(playerid, "TestTime") -1);
format(tmp, sizeof(tmp), "You have: %d Second's Left", GetPVarInt(playerid, "TestTime"));
if(GetPVarInt(playerid, "CopTextDraw") == 1) return
TextDrawSetString(Text:GetPVarInt(playerid,"CopTest"), tmp),
TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid,"CopTest"));

SetPVarInt(playerid, "CopTest", _:TextDrawCreate(481.000000,141.000000,tmp));
TextDrawUseBox(Text:GetPVarInt(playerid,"CopTest"),1);
TextDrawBoxColor(Text:GetPVarInt(playerid,"CopTest"),0x00000099);
TextDrawTextSize(Text:GetPVarInt(playerid,"CopTest"),620.000000,-12.000000);
TextDrawAlignment(Text:GetPVarInt(playerid,"CopTest"),0);
TextDrawBackgroundColor(Text:GetPVarInt(playerid,"CopTest"),0x0000ffff);
TextDrawFont(Text:GetPVarInt(playerid,"CopTest"),1);
TextDrawLetterSize(Text:GetPVarInt(playerid,"CopTest"),0.299999,0.899999);
TextDrawColor(Text:GetPVarInt(playerid,"CopTest"),0xffffffff);
TextDrawSetProportional(Text:GetPVarInt(playerid,"CopTest"),1);
TextDrawSetShadow(Text:GetPVarInt(playerid,"CopTest"),1);
SetPVarInt(playerid, "CopTextDraw", 1);
return 1;
}

function StartCopTest(playerid)
{
SetPlayerVirtualWorld(playerid, 0);
SetPlayerInterior(playerid, 0);
SetPVarInt(playerid, "CopTrain1", SetPlayerRaceCheckpoint(playerid,0,1264.4801,182.8885,19.1089,1275.6063,217.9165,19.1099, 4));
SetPVarInt(playerid, "CopTestVar", SetTimerEx("CopTesta", 1000, 1, "i", playerid));
if(GetPVarInt(playerid, "TestStep") == 0) SetPVarInt(playerid, "TestTime", 70);
else if(GetPVarInt(playerid, "TestStep") == 1) SetPVarInt(playerid, "TestTime", 60);
else if(GetPVarInt(playerid, "TestStep") == 2) SetPVarInt(playerid, "TestTime", 50);
else if(GetPVarInt(playerid, "TestStep") == 3) SetPVarInt(playerid, "TestTime", 40);
else if(GetPVarInt(playerid, "TestStep") == 4) SetPVarInt(playerid, "TestTime", 30);
else if(GetPVarInt(playerid, "TestStep") >= 5) SetPVarInt(playerid, "TestTime", 25);
Streamer_UpdateEx(playerid, 1278.9578,176.0194,19.7783);
PutPlayerInVehicle(playerid, 24, 0);
engineOn[24] = true;
CopTesta(playerid);
Vgas[24] = 97;
GameTextForPlayer(playerid, "~w~Go Go Go", 1000, 3);
return 1;
}

function ClearCopTest(playerid)
{
DeletePVar(playerid,"CopTrain1");
DeletePVar(playerid,"CopTrain2");
DeletePVar(playerid,"CopTrain3");
DeletePVar(playerid,"CopTrain4");
DeletePVar(playerid,"CopTrain5");
DeletePVar(playerid,"CopTrain6");
DeletePVar(playerid,"CopTrain7");
DeletePVar(playerid,"CopTrain8");
DeletePVar(playerid,"CopTrain9");
DeletePVar(playerid,"CopTrain10");
DeletePVar(playerid,"CopTrain11");
DeletePVar(playerid,"CopTrain12");
TextDrawDestroy(Text:GetPVarInt(playerid,"CopTest"));
KillTimer(GetPVarInt(playerid, "CopTestVar"));
SetPVarInt(playerid, "CopTestVar", 0);
DisablePlayerRaceCheckpoint(playerid);
SetPVarInt(playerid, "CopTextDraw", 0);
SetTimer("ClearTheCopTest", 4000, 0);
SetPlayerPos(playerid, 1230.0609,-1784.0688,16.0798);
SetPlayerInterior(playerid, 0);
SetPlayerVirtualWorld(playerid, 7155);
SetPVarInt(playerid, "BuildingIn", 9);
TogglePlayerControllable(playerid, 0);
SetTimerEx("donespawn", 1000, 0, "i", playerid);
return 1;
}

function ClearTheCopTest()
{
incoptest = 0;
return 1;
}

function AddArrest(id,text[],playerid)
{
	new query[250];
	MySQLCheckConnection();
	printf("Adding Arrest by '%s', reason %s",GetPlayerNameEx(playerid), text);
	format(query, sizeof(query), "INSERT INTO arrest (id, who,reason,cop) VALUES (null, '%s', '%s', '%s')", GetPlayerNameEx(id),text,GetPlayerNameEx(playerid));
	samp_mysql_query(query);
	return 1;
}

function LoadGangs()
{
	new resultline[1024];
	new gang[12][64];
	new query[256];

	ConnectToDatabase();

	printf("Loading Gang's....");
	format(query, sizeof(query), "SELECT gangid, leader, name, members, rank, kills, gun1, gun2, gun3, gun4, gun5, gun6 FROM  gangs");
	printf(" SQL: %s",query);
	samp_mysql_query(query);
	samp_mysql_store_result();

	new gangid;
	//Load Houses
	while(samp_mysql_fetch_row(resultline)==1)
	{
		printf("%s", resultline);
		split(resultline, gang, '|');
		gangid = strval(gang[0]);
		if(gangid >= MAX_GANGS) { printf("Max gang's Reached."); break; }
		GangInfo[gangid][gSQLId] = gangid;
		strmid(GangInfo[gangid][gLeader], gang[1], 0, strlen(gang[1]), 24);
		strmid(GangInfo[gangid][gName], gang[2], 0, strlen(gang[2]), 50);
		GangInfo[gangid][gMembers] = strval(gang[3]);
		GangInfo[gangid][gRank] = strval(gang[4]);
		GangInfo[gangid][gKills] = strval(gang[5]);
		GangInfo[gangid][gGuns1] = strval(gang[6]);
		GangInfo[gangid][gGuns2] = strval(gang[7]);
		GangInfo[gangid][gGuns3] = strval(gang[8]);
		GangInfo[gangid][gGuns4] = strval(gang[9]);
		GangInfo[gangid][gGuns5] = strval(gang[10]);
		GangInfo[gangid][gGuns6] = strval(gang[11]);
	}
	return 1;
}

function AddGang(leader[], name[], members, rank, kills)
{
	new query[350];
	MySQLCheckConnection();
	printf("Adding Gang....");
	format(query, sizeof(query), "INSERT INTO  gangs ( gangid, leader, name, members, rank, kills) VALUES (null, '%s', '%s', %d, %d, %d)",
	leader,name, members, rank, kills);
	print("add gang query...");
	printf(" SQL: %s",query);
	samp_mysql_query(query);

	samp_mysql_query("SELECT MAX(gangid) FROM gangs");
	samp_mysql_store_result();
	new SQLId[12];
	samp_mysql_fetch_row(SQLId);
	printf("Gang Added as %s....",SQLId);
	new gangid = strval(SQLId);
	new Owner[MAX_PLAYER_NAME];
    Owner = "No-One";

	if(gangid >= MAX_GANGS) { printf("Max gang's Reached."); return INVALID_SQL_ID; }

	GangInfo[gangid][gSQLId] = gangid;
	strmid(GangInfo[gangid][gLeader], leader, 0, strlen(leader), 24);
	strmid(GangInfo[gangid][gName], name, 0, strlen(name), 60);
	GangInfo[gangid][gMembers] = 0;
	GangInfo[gangid][gRank] = 0;
	GangInfo[gangid][gKills] = 0;

	return gangid;
}

function UpdateGang(SQLId)
{
	new query[256];

	ConnectToDatabase();

	printf("Updating  gangs %d....", SQLId);
	format(query, sizeof(query), "UPDATE  gangs SET leader='%s', name='%s', members='%d', rank='%d', kills='%d', gun1='%d', gun2='%d', gun3='%d', gun4='%d', gun5='%d', gun6='%d' WHERE gangid=%d",GangInfo[SQLId][gLeader],GangInfo[SQLId][gName],GangInfo[SQLId][gMembers],
	GangInfo[SQLId][gRank],GangInfo[SQLId][gKills], GangInfo[SQLId][gGuns1], GangInfo[SQLId][gGuns2], GangInfo[SQLId][gGuns3], GangInfo[SQLId][gGuns4], GangInfo[SQLId][gGuns5], GangInfo[SQLId][gGuns6], SQLId);
	printf(" SQL: %s",query);
	samp_mysql_query(query);
	return 1;
}

function LoadBuildings()
{
	new resultline[1024];
	new building[19][64];
	new query[256];

	ConnectToDatabase();

	printf("Loading Buildings....");
	format(query, sizeof(query), "SELECT buildingid, owner, description, entrancex, entrancey, entrancez, exitx, exity, exitz, owned, price, interiorid, locked, tax, world, ownerid, shares, renters, funds FROM  buildings");
	printf(" SQL: %s",query);
	samp_mysql_query(query);
	samp_mysql_store_result();

	new buildingid;
	//Load Houses
	while(samp_mysql_fetch_row(resultline)==1)
	{
		printf("%s", resultline);
		split(resultline, building, '|');
		buildingid = strval(building[0]);
		if(buildingid >= MAX_BUILDING) { printf("Max Building's Reached."); break; }
		BuildingInfo[buildingid][bSQLId] = buildingid;
		strmid(BuildingInfo[buildingid][bOwner], building[1], 0, strlen(building[1]), 24);
		strmid(BuildingInfo[buildingid][bDescription], building[2], 0, strlen(building[2]), 50);
		BuildingInfo[buildingid][bEntrancex] = floatstr(building[3]);
		BuildingInfo[buildingid][bEntrancey] = floatstr(building[4]);
		BuildingInfo[buildingid][bEntrancez] = floatstr(building[5]);
		BuildingInfo[buildingid][bExitx] = floatstr(building[6]);
		BuildingInfo[buildingid][bExity] = floatstr(building[7]);
		BuildingInfo[buildingid][bExitz] = floatstr(building[8]);
		BuildingInfo[buildingid][bOwned] = strval(building[9]);
		BuildingInfo[buildingid][bBuyPrice] = strval(building[10]);
		BuildingInfo[buildingid][bInteriorId] = strval(building[11]);
		BuildingInfo[buildingid][bLocked] = strval(building[12]);
		BuildingInfo[buildingid][bTax] = strval(building[13]);
		BuildingInfo[buildingid][bVirtualWorld] = strval(building[14]);
		BuildingInfo[buildingid][bOwnerId] = strval(building[15]);
		BuildingInfo[buildingid][bShares] = strval(building[16]);
		BuildingInfo[buildingid][bRenters] = strval(building[17]);
		BuildingInfo[buildingid][bFunds] = strval(building[18]);
	}
	return 1;
}

function AddBuilding(owner[24], description[50], Float:x, Float:y, Float:z, Float:ex, Float:ey, Float:ez, owned, price, interiorid, locked, tax, world, shares)
{
	new query[400];new string[115];
	MySQLCheckConnection();
	printf("Adding Building....");
	format(query, sizeof(query), "INSERT INTO  buildings ( buildingid, owner, description, entrancex, entrancey, entrancez, exitx, exity, exitz, owned, price, interiorid, locked, tax, world, ownerid, shares) VALUES (null, '%s', '%s', %f, %f, %f, %f, %f, %f, %d, %d, %d, 0, %d, %d, %d, %d)",
	owner,description,x,y,z, ex,ey,ez, 0, price, interiorid, tax, world, 0, shares);
	print("add building query...");
	printf(" SQL: %s",query);
	samp_mysql_query(query);

	samp_mysql_query("SELECT MAX(buildingid) FROM buildings");
	samp_mysql_store_result();
	new SQLId[12];
	samp_mysql_fetch_row(SQLId);
	printf("Building Added as %s....",SQLId);
	new buildingid = strval(SQLId);
	new Owner[MAX_PLAYER_NAME];
    Owner = "No-One";

	if(buildingid >= MAX_BUILDING) { printf("Max building's Reached."); return INVALID_SQL_ID; }

	BuildingInfo[buildingid][bSQLId] = buildingid;
	BuildingInfo[buildingid][bOwner] = Owner;
	BuildingInfo[buildingid][bDescription] = description;
	BuildingInfo[buildingid][bEntrancex] = x;
	BuildingInfo[buildingid][bEntrancey] = y;
	BuildingInfo[buildingid][bEntrancez] = z;
	BuildingInfo[buildingid][bExitx] = 2324.651611;
	BuildingInfo[buildingid][bExity] = -1148.913330;
	BuildingInfo[buildingid][bExitz] = 1050.710083;
	BuildingInfo[buildingid][bOwned] = 0;
	BuildingInfo[buildingid][bBuyPrice] = price;
	BuildingInfo[buildingid][bInteriorId] = 12;
	BuildingInfo[buildingid][bLocked] = 0;
	BuildingInfo[buildingid][bTax] = tax;
	BuildingInfo[buildingid][bVirtualWorld] = world;
	BuildingInfo[buildingid][bOwnerId] = 0;
	BuildingInfo[buildingid][bShares] = shares;
	BuildingInfo[buildingid][bRenters] = 0;
	BuildingInfo[buildingid][bFunds] = 0;

    CreateDynamicCP(BuildingInfo[buildingid][bEntrancex], BuildingInfo[buildingid][bEntrancey], BuildingInfo[buildingid][bEntrancez] -1,3.0,-1, -1,-1,6.0);
    format(string, sizeof(string), "%s\nAvailable to buy for $%d\nBuilding Tax is %d%%",BuildingInfo[buildingid][bDescription],BuildingInfo[buildingid][bBuyPrice],BuildingInfo[buildingid][bTax]);
	CreateDynamic3DTextLabel(string,0x01FEFEFF,BuildingInfo[buildingid][bEntrancex], BuildingInfo[buildingid][bEntrancey], BuildingInfo[buildingid][bEntrancez],40.0);
    format(string, sizeof(string), "Server Message: A building has been added to our data base as id %d",buildingid);
	SendClientMessageToAll(lightblue, string);

	return buildingid;
}

function UpdateBuilding(SQLId)
{
	new query[360];

	ConnectToDatabase();

	printf("Updating  buildings %d....", SQLId);
	format(query, sizeof(query), "UPDATE  buildings SET owner='%s', entrancex='%f', entrancey='%f', entrancez='%f', exitx='%f', exity='%f', exitz='%f', owned='%d', interiorid='%d', tax='%d', world='%d', ownerid='%d', shares='%d', renters='%d', funds='%d' WHERE buildingid=%d",BuildingInfo[SQLId][bOwner],BuildingInfo[SQLId][bEntrancex],BuildingInfo[SQLId][bEntrancey],BuildingInfo[SQLId][bEntrancez],
	BuildingInfo[SQLId][bExitx],BuildingInfo[SQLId][bExity],BuildingInfo[SQLId][bExitz], BuildingInfo[SQLId][bOwned], BuildingInfo[SQLId][bInteriorId], BuildingInfo[SQLId][bTax], BuildingInfo[SQLId][bVirtualWorld], BuildingInfo[SQLId][bOwnerId], BuildingInfo[SQLId][bShares], BuildingInfo[SQLId][bRenters], BuildingInfo[SQLId][bFunds], SQLId);
	printf(" SQL: %s",query);
	samp_mysql_query(query);
	return 1;
}

function UpdateVehicles(SQLId)
{
	new query[320];
	GetVehicleDamageStatus(SQLId,vehinfo[SQLId][cPanel],vehinfo[SQLId][cDoor],vehinfo[SQLId][cLight],vehinfo[SQLId][cTire]);
	GetVehicleHealth(SQLId, vehinfo[SQLId][cHealth]);

	ConnectToDatabase();

	printf("Updating  Vehicles %d....", SQLId);
	format(query, sizeof(query), "UPDATE  vehicles SET color1='%d', color2='%d', locked='%d', owner='%s', owned='%d', Modop='%d', fuel='%d', miles='%d', vlock='%d', insurance='%d', junk='%d', panel='%d', door='%d', light='%d', tire='%d', health='%f', blown='%d' WHERE carid=%d",vehinfo[SQLId][cColorOne],vehinfo[SQLId][cColorTwo],vehinfo[SQLId][cLocked],vehinfo[SQLId][cOwner],
	vehinfo[SQLId][cOwned], vehinfo[SQLId][cModop],vehinfo[SQLId][cFuel],vehinfo[SQLId][cMiles],vehinfo[SQLId][cLock],vehinfo[SQLId][cInsurance],  vehinfo[SQLId][cJunk],vehinfo[SQLId][cPanel],vehinfo[SQLId][cDoor],vehinfo[SQLId][cLight],vehinfo[SQLId][cTire],vehinfo[SQLId][cHealth],vehinfo[SQLId][cBlown], vehinfo[SQLId][cSQLId]);
	printf(" SQL: %s",query);
	samp_mysql_query(query);
	return 1;
}

function UpdateAllVehicleInfo(SQLId)
{
	new query[340];
	GetVehiclePos(SQLId,vehinfo[SQLId][cLocationx],vehinfo[SQLId][cLocationy],vehinfo[SQLId][cLocationz]);
	GetVehicleZAngle(SQLId,vehinfo[SQLId][cAngle]);
	GetVehicleDamageStatus(SQLId,vehinfo[SQLId][cPanel],vehinfo[SQLId][cDoor],vehinfo[SQLId][cLight],vehinfo[SQLId][cTire]);
	GetVehicleHealth(SQLId, vehinfo[SQLId][cHealth]);

	ConnectToDatabase();

	printf("Updating  Vehicles %d....", SQLId);
	format(query, sizeof(query), "UPDATE  vehicles SET x='%f', y='%f', z='%f', a='%f', color1='%d', color2='%d', locked='%d', owner='%s', owned='%d', Modop='%d', fuel='%d', miles='%d', vlock='%d', insurance='%d', junk='%d', panel='%d', door='%d', light='%d', tire='%d', health='%f', blown='%d' WHERE carid=%d",vehinfo[SQLId][cLocationx],vehinfo[SQLId][cLocationy],vehinfo[SQLId][cLocationz],vehinfo[SQLId][cAngle]
	,vehinfo[SQLId][cColorOne],vehinfo[SQLId][cColorTwo],vehinfo[SQLId][cLocked],vehinfo[SQLId][cOwner],vehinfo[SQLId][cOwned], vehinfo[SQLId][cModop],vehinfo[SQLId][cFuel],vehinfo[SQLId][cMiles],vehinfo[SQLId][cLock],vehinfo[SQLId][cInsurance], vehinfo[SQLId][cJunk],vehinfo[SQLId][cPanel],vehinfo[SQLId][cDoor],vehinfo[SQLId][cLight],vehinfo[SQLId][cTire],vehinfo[SQLId][cHealth], vehinfo[SQLId][cBlown], vehinfo[SQLId][cSQLId]);
	printf(" SQL: %s",query);
	samp_mysql_query(query);
	return 1;
}

function UpdateHouse(SQLId)
{
	new query[360];

	ConnectToDatabase();

	printf("Updating  house's %d....", SQLId);
	format(query, sizeof(query), "UPDATE   houses SET owner='%s', entrancex='%f', entrancey='%f', entrancez='%f', exitx='%f', exity='%f', exitz='%f', owned='%d', interiorid='%d', locked='%d', rooms='%d', renters='%d', rentable='%d,  tax='%d', funds='%d', world='%d', ownerid='%d' WHERE houseid=%d",HouseInfo[SQLId][hOwner],HouseInfo[SQLId][hEntrancex],HouseInfo[SQLId][hEntrancey],HouseInfo[SQLId][hEntrancez],
	HouseInfo[SQLId][hExitx],HouseInfo[SQLId][hExity],HouseInfo[SQLId][hExitz],HouseInfo[SQLId][hOwned], HouseInfo[SQLId][hInteriorId], HouseInfo[SQLId][hLocked], HouseInfo[SQLId][hRooms], HouseInfo[SQLId][hRenters], HouseInfo[SQLId][hRentable],  HouseInfo[SQLId][hTax], HouseInfo[SQLId][hFunds], HouseInfo[SQLId][hVirtualWorld], HouseInfo[SQLId][hOwnerId], SQLId);
	printf(" SQL: %s",query);
	samp_mysql_query(query);
	return 1;
}

function LoadNames()
{
	new resultline[1024];
	new cname[2][64];
	new query[200];

	ConnectToDatabase();

	printf("Loading Allowed Names....");
	format(query, sizeof(query), "SELECT id, name FROM names");
	printf(" SQL: %s",query);
	samp_mysql_query(query);
	samp_mysql_store_result();

	new nameid;
	//Load Houses
	while(samp_mysql_fetch_row(resultline)==1)
	{
		printf("%s", resultline);
		split(resultline, cname, '|');
		nameid = strval(cname[0]);
		AllowedNames[nameid][nSQLId] = nameid;
        strmid(AllowedNames[nameid][AllowName], cname[1], 0, strlen(cname[1]), 30);
	}
	return 1;
}

function AddName(name[])
{
	new query[150];
	MySQLCheckConnection();
	printf("Adding New Name '%s'",name);
	format(query, sizeof(query), "INSERT INTO names (id, name) VALUES (null, '%s')", name);
	samp_mysql_query(query);

	samp_mysql_query("SELECT MAX(id) FROM names");
	samp_mysql_store_result();
	new SQLId[12];
	samp_mysql_fetch_row(SQLId);
	printf("name Added as %s....",SQLId);
	new nameid = strval(SQLId);

	AllowedNames[nameid][nSQLId] = nameid;
	strmid(AllowedNames[nameid][AllowName], name, 0, strlen(name), 30);
	return nameid;
}

function LoadLand()
{
	new resultline[1024];
	new land[6][64];
	new query[256];

	ConnectToDatabase();

	printf("Loading Land....");
	format(query, sizeof(query), "SELECT landid, x, y, z, dist FROM land");
	printf(" SQL: %s",query);
	samp_mysql_query(query);
	samp_mysql_store_result();

	new landid;
	//Load Houses
	while(samp_mysql_fetch_row(resultline)==1)
	{
		printf("%s", resultline);
		split(resultline, land, '|');
		landid = strval(land[0]);
		if(landid >= MAX_LAND) { printf("Max Land Reached."); break; }
		LandInfo[landid][lSQLId] = landid;
		LandInfo[landid][lx] = floatstr(land[1]);
		LandInfo[landid][ly] = floatstr(land[2]);
		LandInfo[landid][lz] = floatstr(land[3]);
		LandInfo[landid][ldist] = floatstr(land[4]);
	}
	return 1;
}

function AddLand(Float:x, Float:y, Float:z, Float:dist)
{
	new query[150];
	MySQLCheckConnection();
	printf("Adding Land....");
	format(query, sizeof(query), "INSERT INTO land (landid, x, y, z, dist) VALUES (null, %f, %f, %f, %f)", x,y,z, dist);
	print("Add Land query...");
	printf(" SQL: %s",query);
	samp_mysql_query(query);

	samp_mysql_query("SELECT MAX(landid) FROM land");
	samp_mysql_store_result();
	new SQLId[12];
	samp_mysql_fetch_row(SQLId);
	printf("Land Added as %s....",SQLId);
	new landid = strval(SQLId);

	if(landid >= MAX_LAND) { printf("Max Land Reached."); return INVALID_SQL_ID; }

	LandInfo[landid][lSQLId] = landid;
	LandInfo[landid][lx] = x;
	LandInfo[landid][ly] = y;
	LandInfo[landid][lz] = z;
    LandInfo[landid][ldist] = dist;

	return landid;
}

function LoadHouses()
{
	new resultline[1024];
	new house[20][64];
	new query[256];

	ConnectToDatabase();

	printf("Loading Houses....");
	format(query, sizeof(query), "SELECT houseid, owner, entrancex, entrancey, entrancez, exitx, exity, exitz, owned, price, interiorid, locked, rooms, renters, rentable, tax, funds, world, ownerid, description FROM houses");
	printf(" SQL: %s",query);
	samp_mysql_query(query);
	samp_mysql_store_result();

	new houseid;
	//Load Houses
	while(samp_mysql_fetch_row(resultline)==1)
	{
		printf("%s", resultline);
		split(resultline, house, '|');
		houseid = strval(house[0]);
		if(houseid >= MAX_HOUSES) { printf("Max Houses Reached."); break; }
		HouseInfo[houseid][hSQLId] = houseid;
		strmid(HouseInfo[houseid][hOwner], house[1], 0, strlen(house[1]), 24);
		HouseInfo[houseid][hEntrancex] = floatstr(house[2]);
		HouseInfo[houseid][hEntrancey] = floatstr(house[3]);
		HouseInfo[houseid][hEntrancez] = floatstr(house[4]);
		HouseInfo[houseid][hExitx] = floatstr(house[5]);
		HouseInfo[houseid][hExity] = floatstr(house[6]);
		HouseInfo[houseid][hExitz] = floatstr(house[7]);
		HouseInfo[houseid][hOwned] = strval(house[8]);
		HouseInfo[houseid][hBuyPrice] = strval(house[9]);
		HouseInfo[houseid][hInteriorId] = strval(house[10]);
		HouseInfo[houseid][hLocked] = strval(house[11]);
		HouseInfo[houseid][hRooms] = strval(house[12]);
		HouseInfo[houseid][hRenters] = strval(house[13]);
		HouseInfo[houseid][hRentable] = strval(house[14]);
		HouseInfo[houseid][hTax] = strval(house[15]);
		HouseInfo[houseid][hFunds] = strval(house[16]);
		HouseInfo[houseid][hVirtualWorld] = strval(house[17]);
		HouseInfo[houseid][hOwnerId] = strval(house[18]);
		strmid(HouseInfo[houseid][hDescription], house[19], 0, strlen(house[19]), 40);
		HouseInfo[houseid][hRent] = HouseInfo[houseid][hBuyPrice]/40;
	}
	return 1;
}

function AddHouse(owner[24], Float:x, Float:y, Float:z, price, rooms, tax, house, description[40])
{
	new query[400], string[80];
	MySQLCheckConnection();
	printf("Adding House....");
	format(query, sizeof(query), "INSERT INTO houses (houseid, owner, entrancex, entrancey, entrancez, exitx, exity, exitz, owned, price, interiorid, locked, rooms, renters, rentable,tax,funds,world,ownerid, description) VALUES (null, '%s', %f, %f, %f, %f, %f, %f, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, '%s')",
	owner,x,y,z, 2324.651611, -1148.913330, 1050.710083, 0, price, 12, 0, rooms, 0, 0,  tax, 0, house, 0, description);
	print("addhouse query...");
	printf(" SQL: %s",query);
	samp_mysql_query(query);

	samp_mysql_query("SELECT MAX(houseid) FROM houses");
	samp_mysql_store_result();
	new SQLId[12];
	samp_mysql_fetch_row(SQLId);
	printf("House Added as %s....",SQLId);
	new houseid = strval(SQLId);
	new Owner[MAX_PLAYER_NAME];
    Owner = "No-One";

	if(houseid >= MAX_HOUSES) { printf("Max Houses Reached."); return INVALID_SQL_ID; }

	HouseInfo[houseid][hSQLId] = houseid;
	HouseInfo[houseid][hOwner] = Owner;
	HouseInfo[houseid][hEntrancex] = x;
	HouseInfo[houseid][hEntrancey] = y;
	HouseInfo[houseid][hEntrancez] = z;
	HouseInfo[houseid][hExitx] = 2324.651611;
	HouseInfo[houseid][hExity] = -1148.913330;
	HouseInfo[houseid][hExitz] = 1050.710083;
	HouseInfo[houseid][hOwned] = 0;
	HouseInfo[houseid][hBuyPrice] = price;
	HouseInfo[houseid][hInteriorId] = 12;
	HouseInfo[houseid][hLocked] = 0;
	HouseInfo[houseid][hRooms] = rooms;
	HouseInfo[houseid][hRenters] = 0;
	HouseInfo[houseid][hTax] = tax;
	HouseInfo[houseid][hFunds] = 0;
	HouseInfo[houseid][hVirtualWorld] = house;
	HouseInfo[houseid][hOwnerId] = 0;
    strmid(HouseInfo[houseid][hDescription], description, 0, strlen(description), 40);

	CreateDynamicCP(HouseInfo[houseid][hEntrancex], HouseInfo[houseid][hEntrancey], HouseInfo[houseid][hEntrancez] -1,3.0,-1, -1,-1,6.0);
	format(string, sizeof(string), "For Sale Cost\n\n$%d\nTax is %d%%", HouseInfo[houseid][hBuyPrice], HouseInfo[houseid][hTax]);
    CreateDynamic3DTextLabel(string ,0x01FEFEFF,HouseInfo[houseid][hEntrancex], HouseInfo[houseid][hEntrancey], HouseInfo[houseid][hEntrancez],40.0);
    format(string, sizeof(string), "Server Message: A house has been added to our data base as id %d",houseid);
	SendClientMessageToAll(lightblue, string);

	return houseid;
}

function hotwired1(playerid)
{
	new string[128];
	engineOn[GetPlayerVehicleID(playerid)] = true;
	TogglePlayerControllable(playerid, true);
	SendMessage(playerid, " You successfully hotwired this car you gained +1 Hotwire skill Point");
	format(string, sizeof(string), "%s successfully hotwired their vehicle", GetPlayerNameEx(playerid));
	ProxDetector(30.0, playerid, string, purple,red,blue,green,white);
	SetPVarInt(playerid, "HotWireSkill", GetPVarInt(playerid, "HotWireSkill") +1);
	SetPVarInt(playerid, "InHotWire", 0);
	return 1;
}

function hotwireda(playerid)
{
    if(!IsPlayerInAnyVehicle(playerid)) return 1;
	new randt = random(3);
	new string[128];
	new car = GetPlayerVehicleID(playerid);
	if(randt == 0 || randt == 1) return

		engineOn[car] = true,
		TogglePlayerControllable(playerid, true),
		SendMessage(playerid, " You successfully hotwired this car you gained +1 Hotwire skill Point"),
		format(string, sizeof(string), "%s successfully hotwired their vehicle", GetPlayerNameEx(playerid)),
		ProxDetector(30.0, playerid, string, purple,red,blue,green,white),
		SetPVarInt(playerid, "HotWireSkill", GetPVarInt(playerid, "HotWireSkill") +1),
		SetPVarInt(playerid, "InHotWire", 0);

	if(randt == 2) return

		SendMessage(playerid, "You are not that good at hotwiring, You failed to hotwire this vehicle"),
		format(string, sizeof(string), "%s Failed to hotwire their vehicle", GetPlayerNameEx(playerid)),
		ProxDetector(30.0, playerid, string, purple,red,blue,green,white),
		SetPVarInt(playerid, "InHotWire", 0),
		ShowVehInfo(playerid);

	return 1;
}

function ShowVehInfo1(playerid)
{
TogglePlayerControllable(playerid, 0);
new newcar = GetPlayerVehicleID(playerid);
new s[380];
new text[4],text1[4],text2[4],text3[4];
if(vehinfo[newcar][cOwned] == 0)text = "No";
else if(vehinfo[newcar][cOwned] == 1)text = "Yes";
if(vehinfo[newcar][cLock] == 0)text1 = "No";
else if(vehinfo[newcar][cLock] == 1)text1 = "Yes";
if(vehinfo[newcar][cInsurance] == 0)text2 = "No";
else if(vehinfo[newcar][cInsurance] > 0)text2 = "Yes";
if(vehinfo[newcar][cModop] == 0)text3 = "No";
else if(vehinfo[newcar][cModop] == 1)text3 = "Yes";
format(s,sizeof(s),"Do one of the following %s!\n to start your engine! \n\n\n\nVehicle Infomation.\n\nVehicle Owner: %s\nModel: %s\nMile's Done: %d\nVehicle Owned: %s\nAmount Of Fuel: %d %%\nHas A Lock: %s\nVehicle Insurance: %s\nVehicle Modifications: %s",GetPlayerNameEx(playerid),vehinfo[newcar][cOwner],vehinfo[newcar][cName],vehinfo[newcar][cMiles],text,Vgas[newcar],text1,text2,text3);
ShowPlayerDialog(playerid,4,DIALOG_STYLE_MSGBOX,"Engine Menu",s,"Start","Leave");
SendMessage(playerid, "Type /Stop To Stop Your Engine");
return 1;
}

function ShowVehInfo(playerid)
{
new car = GetPlayerVehicleID(playerid);
new s[380];
new text[4],text1[4],text2[4],text3[4];
if(vehinfo[car][cOwned] == 0)text = "No";
else if(vehinfo[car][cOwned] == 1)text = "Yes";
if(vehinfo[car][cLock] == 0)text1 = "No";
else if(vehinfo[car][cLock] == 1)text1 = "Yes";
if(vehinfo[car][cInsurance] == 0)text2 = "No";
else if(vehinfo[car][cInsurance] == 1)text2 = "Yes";
if(vehinfo[car][cModop] == 0)text3 = "No";
else if(vehinfo[car][cModop] == 1)text3 = "Yes";
format(s,sizeof(s),"Ok now %s!\n\nDo You Want To HotWire The Vehicle Or Leave It? \n\n\n\nVehicle Infomation.\n\nVehicle Owner: %s\nModel: %s\nMile's Done: %d\nVehicle Owned: %s\nAmount Of Fuel: %d %%\nHas A Lock: %s\nVehicle Insurance: %s\nVehicle Modifications: %s",GetPlayerNameEx(playerid),vehinfo[car][cOwner],vehinfo[car][cName],vehinfo[car][cMiles],text,Vgas[car],text1,text2,text3),
ShowPlayerDialog(playerid,3,DIALOG_STYLE_MSGBOX,"HotWire Menu",s,"Hotwire","Leave");
return 1;
}

function hotwired(playerid)
{
    if(!IsPlayerInAnyVehicle(playerid)) return 1;
	new randt = random(2);
	new string[128];
	new car = GetPlayerVehicleID(playerid);

	if(randt == 0) return

		engineOn[car] = true,
		TogglePlayerControllable(playerid, true),
		SendMessage(playerid, " You successfully hotwired this car you gained +1 Hotwire skill Point"),
		format(string, sizeof(string), "%s successfully hotwired their vehicle", GetPlayerNameEx(playerid)),
		ProxDetector(30.0, playerid, string, purple,red,blue,green,white),
		SetPVarInt(playerid, "HotWireSkill", GetPVarInt(playerid, "HotWireSkill") +1),
		SetPVarInt(playerid, "InHotWire", 0);

	else if(randt == 1) return

		SendMessage(playerid, "You are not that good at hotwiring, You failed to hotwire this vehicle"),
		format(string, sizeof(string), "%s Failed to hotwire their vehicle", GetPlayerNameEx(playerid)),
		ProxDetector(30.0, playerid, string, purple,red,blue,green,white),
		SetPVarInt(playerid, "InHotWire", 0),
		ShowVehInfo(playerid);

	return 1;
}

function SaveAccounts()
{
    foreach(player, i)
    {
    if(IsPlayerNPC(i)){}else
	OnUpdatePlayer(i);
	}
	SortGangRank();
	return 1;
}

function LoadUpShit()
{
DestroyAllDynamicCPs();
DestroyAllDynamic3DTextLabels();
foreach(player, i) addtags(i);
LoadStuff();
return 1;
}

addtags(playerid)
{
SetPVarInt(playerid, "IDLogo", 0);
new str[20];
if(IsPlayerNPC(playerid))
format(str, sizeof(str), "NPC ID: %d",playerid),
SetPVarInt(playerid,"IDLogo", _:CreateDynamic3DTextLabel(str, 0xFF6C00FF, 0.0, 0.0,0.0+0.5,60,playerid));
if(GetPVarInt(playerid, "LoggedIn") == 1 && !IsPlayerNPC(playerid))
format(str, sizeof(str), "ID: %d",playerid),
SetPVarInt(playerid,"IDLogo", _:CreateDynamic3DTextLabel(str, 0xFF6C00FF, 0.0, 0.0,0.0+0.5,60,playerid));
return 1;
}

function OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
if(!success)return SendClientMessage(playerid, lightblue, "This is an invalid command type /cpanel then click 'Commands' or 'Help Centre'");
return 1;
}

function CheckLand(playerid)
{
for(new i = 0; i < sizeof(LandInfo); i++){
if(IsPlayerInRangeOfPoint(playerid,LandInfo[i][ldist], LandInfo[i][lx], LandInfo[i][ly], LandInfo[i][lz]))return 1;}
return 0;
}


function WeedTimer(playerid)
{
    new str[80];
	SendMessage(playerid, "Your plant has grown, go to where you planted it and type /harvest.");
	DestroyDynamic3DTextLabel(Text3D:GetPVarInt(playerid,"WeedLogo"));
    format(str, sizeof(str), "Weed Plant\nOwner: %s\n Ready For Harvest",GetPlayerNameEx(playerid));
    SetPVarInt(playerid,"WeedLogo",_:CreateDynamic3DTextLabel(str, 0x96FFFF, GetPVarFloat(playerid,"Weedx"), GetPVarFloat(playerid,"Weedy"),GetPVarFloat(playerid,"Weedz")+2,40));
	SetPVarInt(playerid,"WeedReady", 1);
	SetPVarInt(playerid,"WeedTimer", 0);
	KillTimer(GetPVarInt(playerid,"WeedGrown"));
    SetPVarInt(playerid, "WeedGrown", 0);
	return 1;
}

function WeedGrow(playerid)
{
new str[80];
SetPVarInt(playerid,"WeedTimeLeft", GetPVarInt(playerid, "WeedTimeLeft") -1);
DestroyDynamic3DTextLabel(Text3D:GetPVarInt(playerid,"WeedLogo"));
format(str, sizeof(str), "Weed Plant\nOwner: %s\n Time till grown: %d Minutes",GetPlayerNameEx(playerid),GetPVarInt(playerid,"WeedTimeLeft"));
SetPVarInt(playerid,"WeedLogo",_:CreateDynamic3DTextLabel(str, 0x96FFFF, GetPVarFloat(playerid,"Weedx"), GetPVarFloat(playerid,"Weedy"),GetPVarFloat(playerid,"Weedz")+2,40));
new Float:x,Float:y,Float:z;
GetDynamicObjectPos(GetPVarInt(playerid,"WeedObject"), x, y, z);
SetDynamicObjectPos(GetPVarInt(playerid,"WeedObject"), x, y,z+0.028);
if(GetPVarInt(playerid, "WeedTimeLeft") == 0){
DestroyDynamic3DTextLabel(Text3D:GetPVarInt(playerid,"WeedLogo"));
format(str, sizeof(str), "Weed Plant\nOwner: %s\n Plant Finalizing",GetPlayerNameEx(playerid));
SetPVarInt(playerid,"WeedLogo",_:CreateDynamic3DTextLabel(str, 0x96FFFF, GetPVarFloat(playerid,"Weedx"), GetPVarFloat(playerid,"Weedy"),GetPVarFloat(playerid,"Weedz")+2,40));}
Streamer_Update(playerid);
return 1;
}

function OnPlayerCommandReceived(playerid, cmdtext[])
{
if(GetPVarInt(playerid,"CmdSpam")>GetTickCount() && GetPVarInt(playerid, "Admin") < 1)
{
SendClientMessage(playerid,red,"You must wait 2 second's between using commands");
return 0;
}
if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
{
SendClientMessage(playerid, lightblue, "You must be spawned before trying any commands.");
return 0;
}
if(GetPVarInt(playerid, "Hospital") != 0 || GetPVarInt(playerid, "JCT1") != 0)
{
SendClientMessage(playerid, lightblue, "Please wait until the auto animation has stopped.");
return 0;
}
if(GetPVarInt(playerid, "LoggedIn") == 0)
{
SendClientMessage(playerid,red,"Wait until your logged in to type");
return 0;
}
SetPVarInt(playerid,"CmdSpam",GetTickCount()+2000);
return 1;
}

function OnPlayerText(playerid, text[])
{
   if(strlen(text) > 150) return 0;
   if(GetPVarInt(playerid, "LoggedIn") == 0)
   {
   SendClientMessage(playerid,red,"Wait until your logged in to type");
   return 0;
   }
   new string[170];
   if(GetPVarInt(playerid, "LoggedIn") == 1)
   {
   if(GetPVarInt(playerid, "Chat") == 0)format(string, sizeof(string), "%s Says: %s", GetPlayerNameEx(playerid), text), ProxDetector(15.0, playerid, string, white,white,white,white,white);
   if(GetPVarInt(playerid, "Chat") == 1)format(string, sizeof(string), "%s Shouts: %s!", GetPlayerNameEx(playerid), text), ProxDetector(30.0, playerid, string, white,white,white,white,white);
   if(GetPVarInt(playerid, "Chat") == 2)format(string, sizeof(string), "%s Whispers: %s", GetPlayerNameEx(playerid), text), ProxDetector(5.0, playerid, string, white,white,white,white,white);
   if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)return 0;
   ApplyAnimation(playerid,"PED", "IDLE_CHAT",4.1,1,0,0,0,1000);
   return 0;
   }
   return 1;
}

function LoadVehicles()
{
	new resultline[1024];
	new car[27][64];
	new query[300];
	printf("Loading Cars....");
	samp_mysql_real_escape_string("SELECT carid, modelid, x, y, z, a, color1, color2, locked, owner, value, owned, cantsell, Modop, vehid, model, fuel, miles, vlock, insurance, junk, panel, door, light, tire, health, blown FROM vehicles ORDER BY carid ASC", query);
	printf(" SQL: %s",query);
	samp_mysql_query(query);
	samp_mysql_store_result();
    for(new h = 0; h < sizeof(vehinfo); h++)
	{
	while(samp_mysql_fetch_row(resultline)==1)
	{
		printf("%s", resultline);
		split(resultline, car, '|');
        h = AddStaticVehicleEx(strval(car[1]), floatstr(car[2]), floatstr(car[3]), floatstr(car[4]), floatstr(car[5]), strval(car[6]), strval(car[7]), -1);
		vehinfo[h][cSQLId] = strval(car[0]);
		vehinfo[h][cModel] = strval(car[1]);
		vehinfo[h][cLocationx] = floatstr(car[2]);
		vehinfo[h][cLocationy] = floatstr(car[3]);
		vehinfo[h][cLocationz] = floatstr(car[4]);
		vehinfo[h][cAngle] = floatstr(car[5]);
		vehinfo[h][cColorOne] = strval(car[6]);
		vehinfo[h][cColorTwo] = strval(car[7]);
		vehinfo[h][cLocked] = strval(car[8]);
		strmid(vehinfo[h][cOwner], car[9], 0, strlen(car[9]), 255);
		vehinfo[h][cValue] = strval(car[10]);
		vehinfo[h][cOwned] = strval(car[11]);
		vehinfo[h][cCantSell] = strval(car[12]);
		vehinfo[h][cModop] = strval(car[13]);
		vehinfo[h][cVehid] = strval(car[14]);
		strmid(vehinfo[h][cName], car[15], 0, strlen(car[15]), 20);
		vehinfo[h][cFuel] = strval(car[16]);
		vehinfo[h][cMiles] = strval(car[17]);
		vehinfo[h][cLock] = strval(car[18]);
		vehinfo[h][cInsurance] = strval(car[19]);
		vehinfo[h][cJunk] = strval(car[20]);
		vehinfo[h][cPanel] = strval(car[21]);
		vehinfo[h][cDoor] = strval(car[22]);
		vehinfo[h][cLight] = strval(car[23]);
		vehinfo[h][cTire] = strval(car[24]);
        vehinfo[h][cHealth] = floatstr(car[25]);
        vehinfo[h][cBlown] = strval(car[26]);

		h++;
		totalveh++;
		}
    }
}

function SaveCarInfo(modelid,Float:x,Float:y,Float:z, Float:a, color1, color2, locked, owner[MAX_PLAYER_NAME], value, owned, cantsell, Modop, vehid, model[15], fuel, miles, vlock, insurance, junk)
{
	printf("Saved Car Model(%d) to DB....", modelid);
	new query[300];
	format(query, sizeof(query), "INSERT INTO vehicles (modelid, x, y, z, a, color1, color2, locked, owner, value, owned, cantsell, Modop, vehid, model, fuel, miles, vlock, insurance, junk) VALUES (%d, %f, %f, %f, %f, %d, %d, %d, '%s', %d, %d, %d, %d, %d, '%s', %d, %d, %d, %d, %d)",
	modelid, x, y, z, a, color1, color2, locked, owner, value, owned, cantsell, Modop, vehid, model, fuel, miles, vlock, insurance, junk);
	printf(" SQL: %s",query);
	samp_mysql_query(query);

	samp_mysql_query("SELECT MAX(carid) FROM vehicles");
	samp_mysql_store_result();
	new SQLId[12];
	samp_mysql_fetch_row(SQLId);
	printf("Car SQLId: %s",SQLId);
	return strval(SQLId);
}

DeleteVehicle(vehicleid)
{
	printf("Running Destroy Vehicle...");
	RemovePlayersFromVehicleEx(vehicleid); //to prevent crashes
	DeleteCar(vehinfo[vehicleid][cSQLId]);
	ZeroVehicle(vehicleid); //cleanup server vehicle info
	DestroyVehicle(vehicleid);
	printf("Destroy Vehicle Done...");
	return 1;
}

function ZeroVehicle(vehicleid)
{
	vehinfo[vehicleid][cSQLId] = INVALID_SQL_ID;
	vehinfo[vehicleid][cModel] = 0;
	vehinfo[vehicleid][cLocationx] = 0;
	vehinfo[vehicleid][cLocationy] = 0;
	vehinfo[vehicleid][cLocationz] = 0;
	vehinfo[vehicleid][cAngle] = 0;
	vehinfo[vehicleid][cColorOne] = 0;
	vehinfo[vehicleid][cColorTwo] = 0;
	vehinfo[vehicleid][cLocked] = 0;
	vehinfo[vehicleid][cOwner] = 0;
	vehinfo[vehicleid][cValue] = 0;
	vehinfo[vehicleid][cOwned] = 0;
	vehinfo[vehicleid][cCantSell] = 0;
	vehinfo[vehicleid][cModop] = 0;
	vehinfo[vehicleid][cVehid] = 0;
	vehinfo[vehicleid][cName] = 0;
	vehinfo[vehicleid][cFuel] = 0;
	vehinfo[vehicleid][cMiles] = 0;
	vehinfo[vehicleid][cLock] = 0;
	vehinfo[vehicleid][cInsurance] = 0;
	vehinfo[vehicleid][cJunk] = 0;
	vehinfo[vehicleid][cPanel] = 0;
	vehinfo[vehicleid][cDoor] = 0;
	vehinfo[vehicleid][cLight] = 0;
	vehinfo[vehicleid][cTire] = 0;
	vehinfo[vehicleid][cHealth] = 0;
	vehinfo[vehicleid][cBlown] = 0;
	return 1;
}

function RemovePlayersFromVehicleEx(vehid)
{
	    new playerstate;
	    foreach(player, i)
	    {
			playerstate = GetPlayerState(i);
			if(playerstate == PLAYER_STATE_DRIVER || playerstate == PLAYER_STATE_PASSENGER)
			{
				if(IsPlayerInVehicle(i,vehid))
				{
					new Float:x,Float:y,Float:z;
					GetPlayerPos(i,x,y,z);
					SetPlayerPos(i,x,y,z+2);
				}
			}
		}
        return 1;
}

function DeleteCar(SQLId)
{
	printf("Deleting Car %d from DB....", SQLId);
	new query[300];
	format(query, sizeof(query), "DELETE FROM vehicles WHERE carid=%d",SQLId);
	printf(" SQL: %s",query);
	samp_mysql_query(query);
	return 1;
}

function OnPlayerDisconnect(playerid, reason)
{
OnUpdatePlayer(playerid);
ClearTextDraws(playerid);
if(GetPVarInt(playerid, "IDLogo") != 0) DestroyDynamic3DTextLabel(Text3D:GetPVarInt(playerid,"IDLogo"));
if(GetPVarInt(playerid, "SpeedGunStat") != 0) KillTimer(GetPVarInt(playerid, "SpeedGunTimer")), TextDrawDestroy(Text:GetPVarInt(playerid, "SpeedoDraw"));
if(GetPVarInt(playerid,"WeedObject") != 0) DestroyDynamicObject(GetPVarInt(playerid,"WeedObject"));
if(GetPVarInt(playerid,"WeedTimer") != 0) KillTimer(GetPVarInt(playerid,"WeedTimer"));
if(GetPVarInt(playerid,"WeedLogo") != 0) DestroyDynamic3DTextLabel(Text3D:GetPVarInt(playerid,"WeedLogo"));
if(GetPVarInt(playerid,"WeedGrown") != 0) KillTimer(GetPVarInt(playerid,"WeedGrow"));
if(GetPVarInt(playerid, "JCT") != 0) KillTimer(GetPVarInt(playerid, "JCT")), injobmeeting = 0;
if(GetPVarInt(playerid, "JCT1") != 0) KillTimer(GetPVarInt(playerid, "JCT1")), DeletePVar(playerid,"JCT1"), injobmeeting = 0;
if(GetPVarInt(playerid, "CuffTimer") != 0) KillTimer(GetPVarInt(playerid, "CuffTimer")), SetPVarInt(GetPVarInt(playerid, "Stopping"), "Holding", 0);
if(GetPVarInt(playerid, "Holding") != 0) KillTimer(GetPVarInt(GetPVarInt(playerid,"Holding"), "CuffTimer")), SetPVarInt(GetPVarInt(playerid, "Holding"), "Stopping", 0);
SendLeaveMessage(playerid, reason);
if(GetPVarInt(playerid, "IntroTimer") != 0) KillTimer(GetPVarInt(playerid, "IntroTimer"));
if(GetPVarInt(playerid, "BinObject") != 0) DestroyObject(GetPVarInt(playerid, "BinObject")), DisablePlayerCheckpoint(playerid), SetPVarInt(playerid, "CPID", -1);
if(GetPVarInt(playerid, "JailTimer") != 0) KillTimer(GetPVarInt(playerid, "JailTimer"));
if(GetPVarInt(playerid, "ShootingVar") != 0) KillTimer(GetPVarInt(playerid,"ShootingVar")), StopShootingTest(playerid);
if(GetPVarInt(playerid, "SQLID") != 0) Online(GetPVarInt(playerid, "SQLID"), 0);
//if(GetPVarInt(playerid, "SpeedoTimer") != 0) KillTimer(GetPVarInt(playerid, "SpeedoTimer")), SetPVarInt(playerid, "SpeedoTimer", 0);
if(GetPVarInt(playerid, "ToDo") != 0) TextDrawDestroy(Text:GetPVarInt(playerid, "ToDo")), SetPVarInt(playerid, "ToDo", 0), TextDrawDestroy(Text:GetPVarInt(playerid, "ToDo1")), SetPVarInt(playerid, "ToDo1", 0);
if(GetPVarInt(playerid, "Sleeping") != 0) KillTimer(GetPVarInt(playerid, "Sleeping"));
if(GetPVarInt(playerid, "DrugEffectTimer") != 0) KillTimer(GetPVarInt(playerid, "DrugEffectTimer"));
return 1;
}

stock SendLeaveMessage(playerid, reason)
{
	new string[128];
	switch(reason)
	{
		case 0:
		{
            SetPVarInt(playerid, "Crashed", 1);
			format(string,sizeof(string),"~R~News: ~W~%s ~R~Left ~y~City Role Play ~W~(Crashed)",GetPlayerNameEx(playerid));
			NewsMessage(string);
		}
		case 1:
		{
			format(string,sizeof(string),"~R~News: ~W~%s ~R~Left ~y~City Role Play ~W~(Quiting)",GetPlayerNameEx(playerid));
			NewsMessage(string);
		}
	}
}

function OnPlayerUpdate(playerid)
{
	    if(IsPlayerInAnyVehicle(playerid) && !IsPlayerNPC(playerid))
		{
        new
	    Float:fPos[3],
	    Float:Pos[4][2],
	    Float:vSpeed,
		Gears,
		tmp[20],
		veh = GetPlayerVehicleID(playerid);

    	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
	    if(IsPlayerInInvalidleadedVehicle (veh)|| IsPlayerInInvalidDieselVehicle(veh)
	    || IsPlayerInInvalidPetroVehicle(veh) || IsPlayerInInvalidMotoVehicle(veh))
	    {
        GetVehicleVelocity(veh, fPos[0], fPos[1], fPos[2]);

		vSpeed = floatsqroot(floatpower(fPos[0], 2) + floatpower(fPos[1], 2) +
		floatpower(fPos[2], 2)) * 200;
		if(vSpeed > 0.9)
		{
		//printf("doing speed %.0f ",vSpeed);
        new Float:alpha = 320 - vSpeed;
        if(alpha < 60)alpha = 60;
		if(vSpeed >= 1.0 ) Gears = 1;
		if(vSpeed >= 40.0) Gears = 2;
		if(vSpeed >= 80.0) Gears = 3;
		if(vSpeed >= 120.0) Gears = 4;
		if(vSpeed >= 160.0) Gears = 5; // 80 mph
		if(vSpeed >= 200.0) Gears = 6;

		for(new i; i < 4; i++)
		TextDrawDestroy(TextDrawsd[playerid][i]),
	  	GetDotXY(548-300, 401, Pos[i][0], Pos[i][1], alpha, (i + 1) * 8),
    	TextDrawsd[playerid][i] = TextDrawCreate(Pos[i][0], Pos[i][1], "~r~|"),
  		TextDrawLetterSize(TextDrawsd[playerid][i], 0.73, -2.60),
		TextDrawSetOutline(TextDrawsd[playerid][i], 0),
		TextDrawSetShadow(TextDrawsd[playerid][i], 1),
        TextDrawShowForPlayer(playerid, TextDrawsd[playerid][i]),
        SetPVarInt(playerid, "VehicleTextDraw", 1);
		}
        if(GetPVarInt(playerid, "InGear") != Gears)
		{
		if(GetPVarInt(playerid, "LookingTextDraw3") == 1)
        TextDrawDestroy(TextDrawsd[playerid][4]),
        SetPVarInt(playerid, "LookingTextDraw3", 0);

	    format(tmp, sizeof(tmp), "  GEAR~N~    ~Y~%d", Gears);
	    if(DrivingBack(veh) == true) format(tmp, sizeof(tmp), "  GEAR~N~    ~r~R"), Gears = -1;
	    if(vSpeed == 0.0) format(tmp, sizeof(tmp), "  GEAR~N~    ~w~N");
		TextDrawsd[playerid][4] = TextDrawCreate(233.000000,356.000000,tmp);
		TextDrawUseBox(TextDrawsd[playerid][4],1);
        TextDrawBoxColor(TextDrawsd[playerid][4],0x00000066);
        TextDrawTextSize(TextDrawsd[playerid][4],279.000000,-24.000000);
        TextDrawAlignment(TextDrawsd[playerid][4],0);
        TextDrawBackgroundColor(TextDrawsd[playerid][4],0x000000cc);
	    TextDrawFont(TextDrawsd[playerid][4],1);
		TextDrawLetterSize(TextDrawsd[playerid][4],0.299999,1.199999);
		TextDrawColor(TextDrawsd[playerid][4],0xffff0099);
		TextDrawSetProportional(TextDrawsd[playerid][4],1);
		TextDrawSetShadow(TextDrawsd[playerid][4],1);
		TextDrawShowForPlayer(playerid, TextDrawsd[playerid][4]);
		SetPVarInt(playerid, "LookingTextDraw3", 1);
		SetPVarInt(playerid, "InGear", Gears);
		//printf("Gear %d",Gears);
		}
		if(IsPlayerInInvalidPetroVehicle(veh))
        TextDrawDestroy(TextDrawsd[playerid][4]),
        SetPVarInt(playerid, "LookingTextDraw3", 0);
		}
        }
        }
        return 1;
}

function OnPlayerStateChange(playerid, newstate, oldstate)
{
    new newcar = GetPlayerVehicleID(playerid);
	new string[128];
//	printf("Vehicle %d was enterd",newcar);
	if(newstate == PLAYER_STATE_DRIVER)
	{
        if(SeatTaken[0][newcar] == 0) SeatTaken[0][newcar] = 1;
        if(GetPVarInt(playerid, "DoCar") == 1) return SendClientMessage(playerid, lightgreen, "Your able to enter any vehicle");
        //set textdraws to show and timer start
       // SetPVarInt(playerid, "SpeedoTimer", SetTimerEx("VehicleUpdater", 800, 1, "ii", playerid, newcar));
        if(IsPlayerInInvalidleadedVehicle(newcar)|| IsPlayerInInvalidDieselVehicle(newcar)
        || IsPlayerInInvalidPetroVehicle(newcar) || IsPlayerInInvalidMotoVehicle(newcar))
		{
        for(new i; i < 11; i++)TextDrawShowForPlayer(playerid, TextDraws[TDSpeedClock][i]);
        for(new i; i < 4; i++)TextDrawsd[playerid][i] = TextDrawCreate(555.0-300, 402.0, "~r~|");
        //vehicle dilog pop ups
		if(FireCar(newcar) == 1 && GetPVarInt(playerid, "Team") == fireman && engineOn[newcar] == 0)return ShowVehInfo1(playerid); else if(engineOn[newcar] == 0) ShowVehInfo(playerid);
        if(CopCar(newcar) == 1 && GetPVarInt(playerid, "Team") == cop && engineOn[newcar] == 0)return ShowVehInfo1(playerid); else if(engineOn[newcar] == 0) ShowVehInfo(playerid);
        if(GetVehicleModel(newcar) ==  408 && GetPVarInt(playerid, "Team") == binman && engineOn[newcar] == 0)return ShowVehInfo1(playerid); else if(engineOn[newcar] == 0) ShowVehInfo(playerid);
        if(GetVehicleModel(newcar) ==  416 && GetPVarInt(playerid, "Team") == med && engineOn[newcar] == 0)return ShowVehInfo1(playerid); else if(engineOn[newcar] == 0) ShowVehInfo(playerid);
		if(MyVehicle(playerid, newcar) && engineOn[newcar] == 0)return ShowVehInfo1(playerid); else if(engineOn[newcar] == 0)ShowVehInfo(playerid);
		// end of em
        }
        //end textdraw show plus timer setting
        if(newcar == CrushCar) SendMessage(playerid, "You found the junk yard vehicle, take it to the junk yard to earn some money.");
		if(GetVehicleModel(newcar) ==  408 && engineOn[newcar] == 1 && GetPVarInt(playerid, "BinObject") == 0) ShowPlayerDialog(playerid,45,DIALOG_STYLE_MSGBOX,"Do You Want To Work???","Do You Want To Work?","Yes","No");
		if(VehicleOwnAble(newcar))
	    {
		if(vehinfo[newcar][cOwned]== 0 && vehinfo[newcar][cCantSell] == 0 && CrushCar != newcar)
		{
			TogglePlayerControllable(playerid, 0);
			format(string,sizeof(string),"Vehicle: %s~N~ ~N~Price:$%d~N~ ~N~Pick To Buy Or Leave This Vehicle",VehicleNames[GetVehicleModel(newcar)-400],vehinfo[newcar][cValue]);

			SetPVarInt(playerid, "CarBuy", _:TextDrawCreate(153.000000,373.000000,string));
			TextDrawUseBox(Text:GetPVarInt(playerid, "CarBuy"),1);
			TextDrawBoxColor(Text:GetPVarInt(playerid, "CarBuy"),0x00000066);
			TextDrawTextSize(Text:GetPVarInt(playerid, "CarBuy"),460.000000,0.000000);
			TextDrawAlignment(Text:GetPVarInt(playerid, "CarBuy"),0);
			TextDrawBackgroundColor(Text:GetPVarInt(playerid, "CarBuy"),0x0000ffff);
			TextDrawFont(Text:GetPVarInt(playerid, "CarBuy"),1);
			TextDrawLetterSize(Text:GetPVarInt(playerid, "CarBuy"),0.499999,1.000000);
			TextDrawColor(Text:GetPVarInt(playerid, "CarBuy"),0xffffffff);
			TextDrawSetProportional(Text:GetPVarInt(playerid, "CarBuy"),1);
			TextDrawSetShadow(Text:GetPVarInt(playerid, "CarBuy"),1);
			SetPVarInt(playerid, "LookingTextDraw1", 1);
			TextDrawShowForPlayer(playerid,Text:GetPVarInt(playerid, "CarBuy"));

			new s[128];
			format(s,sizeof(s),"Car Dealer Says: %s!\n\nDo You Want To Buy This Vehicle Or Leave Please Pick",GetPlayerNameEx(playerid));
			ShowPlayerDialog(playerid,7,DIALOG_STYLE_MSGBOX,"Vehicle Buying Menu",s,"Buy","Leave");
			return 1;
			}
		}
	}
	else if(newstate == PLAYER_STATE_PASSENGER)
	{
	if(SeatTaken[1][newcar] == 0) SeatTaken[1][newcar] = 1;
	if(GetPlayerVehicleSeat(playerid) ==  2) SeatTaken[2][newcar] = 1;
	if(GetPlayerVehicleSeat(playerid) ==  3) SeatTaken[3][newcar] = 1;
	}
	else if(newstate == PLAYER_STATE_ONFOOT)
	{
        if(GetPVarInt(playerid, "DrivingTestVar") != 0) ClearDrivingTest(playerid),	GameTextForPlayer(playerid, "~r~Driving Test Failed", 2000, 1),
        SetVehicleToRespawn(61),SetPVarInt(playerid, "TestTime", 0);
		if(GetPVarInt(playerid, "CopTestVar") != 0) ClearCopTest(playerid),GameTextForPlayer(playerid, "~r~Driving Test Failed", 2000, 1),
		SetVehicleToRespawn(24),SetPVarInt(playerid, "TestTime", 0);
		if(GetPVarInt(playerid, "InCar") == 1) SetPVarInt(playerid, "InCar", 0);
		if(GetPVarInt(playerid, "LookingTextDraw0") == 1)
	    {
		TextDrawHideForPlayer(playerid, Text:GetPVarInt(playerid, "FuelText"));
		TextDrawHideForPlayer(playerid, Text:FuelText1[0]);
		TextDrawHideForPlayer(playerid, Text:FuelText1[1]);
		SetPVarInt(playerid, "LookingTextDraw0", 0);
	    }
	    if(GetPVarInt(playerid, "VehicleTextDraw") == 1){
	    SetPVarInt(playerid, "VehicleTextDraw", 0);
	    for(new i; i < 4; i++){TextDrawHideForPlayer(playerid, TextDrawsd[playerid][i]);}
		for(new i; i < 11; i++){TextDrawHideForPlayer(playerid, TextDraws[TDSpeedClock][i]);}
		if(GetPVarInt(playerid, "LookingTextDraw3") == 1)
		{
		SetPVarInt(playerid, "LookingTextDraw3", 0);
		TextDrawHideForPlayer(playerid, TextDrawsd[playerid][4]);
		}
		}
	}
	return 1;
}

function OnPlayerExitVehicle(playerid, vehicleid)
{
if(SeatTaken[0][vehicleid] == 1)SeatTaken[0][vehicleid] = 0;
return 1;
}

function OnVehicleDeath(vehicleid)
{
if(vehinfo[vehicleid][cInsurance] == 0 && vehinfo[vehicleid][cCantSell] == 0 && vehinfo[vehicleid][cOwned] == 1)
vehinfo[vehicleid][cLocked] = 0,
vehinfo[vehicleid][cModop] = 0,
vehinfo[vehicleid][cMiles] = 0,
vehinfo[vehicleid][cLock] = 0,
vehinfo[vehicleid][cInsurance] = 0,
vehinfo[vehicleid][cOwned] = 0,
vehinfo[vehicleid][cHealth] = 1000,
vehinfo[vehicleid][cBlown] = 0,
vehinfo[vehicleid][cInsurance] = 0,
strmid(vehinfo[vehicleid][cOwner], "No-One", 0, strlen("No-One"), 128),
CheckOwner(vehinfo[vehicleid][cVehid]);
SetTimerEx("FixTheVeh", 11000, 0, "i", vehicleid);
vehinfo[vehicleid][cBlown] ++;
if(vehinfo[vehicleid][cInsurance] > 0) vehinfo[vehicleid][cInsurance] --;
RepairVehicle(vehicleid);
UpdateVehicles(vehicleid);
return 1;
}

function CheckOwner(vehicleid)
{
foreach(player, i)
{
if(GetPVarInt(i, "Vehicle0") == vehicleid)return SetPVarInt(i, "Vehicle0", 0), SortKeys(i), OnUpdatePlayer(i);
else if(GetPVarInt(i, "Vehicle1") == vehicleid)return SetPVarInt(i, "Vehicle1", 0), SortKeys(i), OnUpdatePlayer(i);
else if(GetPVarInt(i, "Vehicle2") == vehicleid)return SetPVarInt(i, "Vehicle2", 0), SortKeys(i), OnUpdatePlayer(i);
else if(GetPVarInt(i, "Vehicle3") == vehicleid)return SetPVarInt(i, "Vehicle3", 0), SortKeys(i), OnUpdatePlayer(i);
else if(GetPVarInt(i, "Vehicle4") == vehicleid)return SetPVarInt(i, "Vehicle4", 0), SortKeys(i), OnUpdatePlayer(i);
else if(GetPVarInt(i, "Vehicle5") == vehicleid)return SetPVarInt(i, "Vehicle5", 0), SortKeys(i), OnUpdatePlayer(i);
}
return 1;
}

function OnVehicleSpawn(vehicleid)
{
    engineOn[vehicleid] = false;
	SetTimerEx("sortangle", 1000, 0, "i", vehicleid);
	return 1;
}

function sortangle(vehicleid)
{
SetVehiclePos(vehicleid, vehinfo[vehicleid][cLocationx],vehinfo[vehicleid][cLocationy],vehinfo[vehicleid][cLocationz]);
SetVehicleZAngle(vehicleid,vehinfo[vehicleid][cAngle]);
return 1;
}

function SetShotingSkill(playerid)
{
if(GetPVarInt(playerid, "GunLicense") < 1) SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 0), SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 0), SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 0);
else if(GetPVarInt(playerid, "GunLicense") < 2) SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 0), SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 0), SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 0);
else if(GetPVarInt(playerid, "GunLicense") < 3) SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 0), SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 0), SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 0);
else if(GetPVarInt(playerid, "GunLicense") < 4) SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 0), SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 0), SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 0);
SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 0);
return 1;
}

function LoadAnimations(playerid)
{
ApplyAnimation(playerid,"PED","WALK_player",4.1,1,1,1,1,0);
ApplyAnimation(playerid,"RYDER","Van_Throw",2.1,0,0,0,0,0);
ApplyAnimation(playerid,"PED", "IDLE_CHAT",4.1,1,0,0,0,0);
ApplyAnimation(playerid,"PED","handsup",2.1,0,0,0,0,0);
ApplyAnimation(playerid,"POLICE","plc_drgbst_02",2.1,0,0,0,0,0);
ApplyAnimation(playerid,"CAR","Tap_hand",4.1,0,0,0,0,0);
ApplyAnimation(playerid,"SWEET","Sweet_injuredloop",4,1,1,1,1,0);
ApplyAnimation(playerid,"CRACK","crckidle4",4.1,0,1,1,1,0);
ClearAnimations(playerid);
return 1;
}

function OnPlayerConnect(playerid)
{
    new str[15];
	if(IsPlayerNPC(playerid)) return
    format(str, sizeof(str), "NPC ID: %d",playerid), SetPVarInt(playerid,"IDLogo", _:CreateDynamic3DTextLabel(str, 0xFF6C00FF, 0.0, 0.0,0.0+0.5,60,playerid)), SetPVarInt(playerid, "LoggedIn", 1), SpawnPlayer(playerid);

	// Reset Player Var's that need to be lower then 0
	SetPlayerColor(playerid,grey);
	LoadAnimations(playerid);
	SetPlayerSkin(playerid, 293);
	SetTimerEx("kickable1", 5000, 0, "i", playerid);
	SetPVarInt(playerid, "CPID", -1);
	// MySQL Load Player Status
    MySQLCheckConnection();
	printf("Player Connecting as (%d)", playerid);
    new playerip[16], mess[80];
	GetPlayerIp(playerid, playerip, sizeof(playerip));
	new playeripbancheck = MySQLCheckIPBanned(playerip);
	new playernamebancheck = MySQLCheckNameBanned(GetPlayerNameSave(playerid));
	if (playeripbancheck != 0 || playernamebancheck != 0) return
	SendClientMessage(playerid, orange, "You were kicked due to your ip/name is banned please contact an admin if this message is an error."),
	SendClientMessage(playerid, yellow, "To try to resolve your ban you can go to www.city-rp.com."),
	Kick(playerid);

	format(mess,sizeof(mess),"~R~News: ~W~%s Has Joined ~y~City Role Play",GetPlayerNameEx(playerid));
	NewsMessage(mess);
	SetPVarString(playerid, "Message1", "_");
	SetPVarString(playerid, "Message2", "_");
	SetPVarString(playerid, "Message3", "_");
	SetPVarString(playerid, "Message4", "_");
	SetPVarString(playerid, "LastMessage", "_");
	return 1;
}

function kickem(playerid)
{
if(GetPVarInt(playerid, "LoggedIn") == 0)Kick(playerid);
return 1;
}

function IfRegisterd(playerid)
{
		if(GetPVarInt(playerid, "LoggedIn") == 0)
		{
	    new sqlaccountstatus = MySQLCheckAccount(GetPlayerNameSave(playerid));
	    if(sqlaccountstatus != 0)
    	SetPVarInt(playerid, "SQLID", sqlaccountstatus),
    	SendMessage(playerid, "Please wait While We Load Your Account");

		new s[90];
        if(GetPVarInt(playerid, "SQLID") != 0)

        StartFade(playerid),
		format(s,sizeof(s),"Account Name %s Has Already Been Created\n\nHint:Type your password to login.",GetPlayerNameEx(playerid)),
		ShowPlayerDialog(playerid,1,DIALOG_STYLE_INPUT,"User Account",s,"Logon","Back");

        if(GetPVarInt(playerid, "SQLID") == 0)

		format(s,sizeof(s),"Account Name %s Hasn't Been Created\n\nHint:Type a password to create it.",GetPlayerNameEx(playerid)),
		ShowPlayerDialog(playerid,2,DIALOG_STYLE_INPUT,"New User Account",s,"Create","Back");
		}
	    return 1;
}

function OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
if(GetPVarInt(playerid, "Admin") == 0)return 1;
SetPVarInt(playerid, "AdminOn", clickedplayerid);
ShowPlayerDialog(playerid, 75, DIALOG_STYLE_LIST, "Admin Control Panel", "(Un)Freeze Player\nKill Player\nGet Player\nGo To Player\nSet Health\nReset The Weapons\nKick Player\nBan Player", "Select", "Close");
return 1;
}

function OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    new s1[100];
	if(dialogid == 1 )
	{
		if(response == 1)
		{
				new tmp[128];
				new idx;
				tmp = strtok(inputtext, idx);
				if(!strlen(tmp))
				{
					SendMessage(playerid, " You Must Enter A Password First!");
					format(s1,sizeof(s1),"Account Name %s Has Already Been Created\n\nHint:Type your password to login.",GetPlayerNameEx(playerid)),
		            ShowPlayerDialog(playerid,1,DIALOG_STYLE_INPUT,"User Account",s1,"Logon","Back");
					return 1;
				}
				OnPlayerLogin(playerid,inputtext);
				return 1;
		}
		if(response == 0)
		{
			ChoseName(playerid);
			return 1;
		}
	}
	if(dialogid == 2 )
	{
		if(response == 1)
		{
				new tmp[128];
				new idx;
				tmp = strtok(inputtext, idx);
				if(!strlen(tmp))
				{
					SendMessage(playerid, " You Must Enter A Password First!");
					format(s1,sizeof(s1),"Account Name %s Hasn't Been Created\n\nHint:Type a password to create it.",GetPlayerNameEx(playerid)),
	            	ShowPlayerDialog(playerid,2,DIALOG_STYLE_INPUT,"New User Account",s1,"Create","Back");
					return 1;
				}
				OnPlayerRegister(playerid,inputtext);
				OnPlayerLogin(playerid,inputtext);
				SendMessage(playerid, "You were auto logged in.");
				return 1;
		}
		if(response == 0)
		{
			ChoseName(playerid);
			return 1;
		}
	}
	if(dialogid == 3)
	{
		if(response == 1)
		{
        ShowPlayerDialog(playerid, 29, DIALOG_STYLE_LIST, "HotWire", "Pick Lock 30% Chance\nScrew Driver 60% Chance\nSkeleton Key 100%", "Select", "Go Back");
		}
		if(response == 0)
		{
        if(IsPlayerInAnyVehicle(playerid))
			{
				TogglePlayerControllable(playerid, 1);
				RemovePlayerFromVehicle(playerid);
			}
			else
			{
				SendMessage(playerid, "You Aint In Any Vehicle!");
				return 1;
			}
		}
	}
	if(dialogid == 4)
	{
		if(response == 1)
		{
			    new vehicle1 = GetPlayerVehicleID(playerid);
				if(engineOn[vehicle1] == 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
				{
					engineOn[vehicle1] = true;
					TogglePlayerControllable(playerid, true);
					SendMessage(playerid, " You Started Your Vehicle Engine!");
				}
				else SendMessage(playerid, "Your Engine's Already Started!");
			    return 1;
		}
		if(response == 0)
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				TogglePlayerControllable(playerid, 1);
				RemovePlayerFromVehicle(playerid);
				engineOn[GetPlayerVehicleID(playerid)] = false;
			}
			else
			{
				SendMessage(playerid, "You Aint In Any Vehicle!");
				return 1;
			}
		}
	}
	if(dialogid ==5)
    {
    if(response != 0)
    {
    new world = random(74732)+1, Float:x, Float:y,Float:z,Float:a;
    switch(listitem)
    {
    case 0:
	{
	SetPVarInt(playerid,"VehicleOn", GetPVarInt(playerid, "Vehicle0"));
	if(GetPVarInt(playerid, "InDMV") == 0) return ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	GetVehiclePos(GetPVarInt(playerid, "VehicleOn"), x,y,z);
    GetVehicleZAngle(GetPVarInt(playerid, "VehicleOn"), a);
    SetPVarFloat(playerid, "VehA",a);
    SetPVarFloat(playerid, "VehX",x);
	SetPVarFloat(playerid, "VehY",y);
	SetPVarFloat(playerid, "VehZ",z);
	Streamer_UpdateEx(playerid, 1233.3409,-1790.6753,14.1980);
	ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
    SetVehiclePos(GetPVarInt(playerid, "VehicleOn"), 1229.1342,-1789.0165,15.8565);
    SetVehicleZAngle(GetPVarInt(playerid, "VehicleOn"), 226.7672);
    SetPlayerCameraPos(playerid,1225.2678,-1794.7113,14.9488+1);
    SetPlayerCameraLookAt(playerid,1230.7152,-1784.3668,16.0798);
    SetPlayerVirtualWorld(playerid, world);
    SetVehicleVirtualWorld(GetPVarInt(playerid, "VehicleOn"), world);
    SetPlayerPos(playerid, 1228.9115,-1794.8713,16.0723);
    TogglePlayerControllable(playerid, 0);
	}
	case 1:
	{
	SetPVarInt(playerid,"VehicleOn", GetPVarInt(playerid, "Vehicle1"));
	if(GetPVarInt(playerid, "InDMV") == 0) return ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	GetVehiclePos(GetPVarInt(playerid, "VehicleOn"), x,y,z);
    GetVehicleZAngle(GetPVarInt(playerid, "VehicleOn"), a);
    SetPVarFloat(playerid, "VehA",a);
    SetPVarFloat(playerid, "VehX",x);
	SetPVarFloat(playerid, "VehY",y);
	SetPVarFloat(playerid, "VehZ",z);
	Streamer_UpdateEx(playerid, 1233.3409,-1790.6753,14.1980);
	ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
    SetVehiclePos(GetPVarInt(playerid, "VehicleOn"), 1229.1342,-1789.0165,15.8565);
    SetVehicleZAngle(GetPVarInt(playerid, "VehicleOn"), 226.7672);
    SetPlayerCameraPos(playerid,1225.2678,-1794.7113,14.9488+1);
    SetPlayerCameraLookAt(playerid,1230.7152,-1784.3668,16.0798);
    SetPlayerVirtualWorld(playerid, world);
    SetVehicleVirtualWorld(GetPVarInt(playerid, "VehicleOn"), world);
    SetPlayerPos(playerid, 1228.9115,-1794.8713,16.0723);
    TogglePlayerControllable(playerid, 0);
	}
	case 2:
	{
	SetPVarInt(playerid,"VehicleOn", GetPVarInt(playerid, "Vehicle2"));
	if(GetPVarInt(playerid, "InDMV") == 0) return ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	GetVehiclePos(GetPVarInt(playerid, "VehicleOn"), x,y,z);
    GetVehicleZAngle(GetPVarInt(playerid, "VehicleOn"), a);
    SetPVarFloat(playerid, "VehA",a);
    SetPVarFloat(playerid, "VehX",x);
	SetPVarFloat(playerid, "VehY",y);
	SetPVarFloat(playerid, "VehZ",z);
	Streamer_UpdateEx(playerid, 1233.3409,-1790.6753,14.1980);
	ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
    SetVehiclePos(GetPVarInt(playerid, "VehicleOn"), 1229.1342,-1789.0165,15.8565);
    SetVehicleZAngle(GetPVarInt(playerid, "VehicleOn"), 226.7672);
    SetPlayerCameraPos(playerid,1225.2678,-1794.7113,14.9488+1);
    SetPlayerCameraLookAt(playerid,1230.7152,-1784.3668,16.0798);
    SetPlayerVirtualWorld(playerid, world);
    SetVehicleVirtualWorld(GetPVarInt(playerid, "VehicleOn"), world);
    SetPlayerPos(playerid, 1228.9115,-1794.8713,16.0723);
    TogglePlayerControllable(playerid, 0);
	}
	case 3:
	{
	SetPVarInt(playerid,"VehicleOn", GetPVarInt(playerid, "Vehicle3"));
	if(GetPVarInt(playerid, "InDMV") == 0) return ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	GetVehiclePos(GetPVarInt(playerid, "VehicleOn"), x,y,z);
    GetVehicleZAngle(GetPVarInt(playerid, "VehicleOn"), a);
    SetPVarFloat(playerid, "VehA",a);
    SetPVarFloat(playerid, "VehX",x);
	SetPVarFloat(playerid, "VehY",y);
	SetPVarFloat(playerid, "VehZ",z);
	Streamer_UpdateEx(playerid, 1233.3409,-1790.6753,14.1980);
	ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
    SetVehiclePos(GetPVarInt(playerid, "VehicleOn"), 1229.1342,-1789.0165,15.8565);
    SetVehicleZAngle(GetPVarInt(playerid, "VehicleOn"), 226.7672);
    SetPlayerCameraPos(playerid,1225.2678,-1794.7113,14.9488+1);
    SetPlayerCameraLookAt(playerid,1230.7152,-1784.3668,16.0798);
    SetPlayerVirtualWorld(playerid, world);
    SetVehicleVirtualWorld(GetPVarInt(playerid, "VehicleOn"), world);
    SetPlayerPos(playerid, 1228.9115,-1794.8713,16.0723);
    TogglePlayerControllable(playerid, 0);
	}
	case 4:
	{
	SetPVarInt(playerid,"VehicleOn", GetPVarInt(playerid, "Vehicle4"));
	if(GetPVarInt(playerid, "InDMV") == 0) return ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	GetVehiclePos(GetPVarInt(playerid, "VehicleOn"), x,y,z);
    GetVehicleZAngle(GetPVarInt(playerid, "VehicleOn"), a);
    SetPVarFloat(playerid, "VehA",a);
    SetPVarFloat(playerid, "VehX",x);
	SetPVarFloat(playerid, "VehY",y);
	SetPVarFloat(playerid, "VehZ",z);
	Streamer_UpdateEx(playerid, 1233.3409,-1790.6753,14.1980);
	ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
    SetVehiclePos(GetPVarInt(playerid, "VehicleOn"), 1229.1342,-1789.0165,15.8565);
    SetVehicleZAngle(GetPVarInt(playerid, "VehicleOn"), 226.7672);
    SetPlayerCameraPos(playerid,1225.2678,-1794.7113,14.9488+1);
    SetPlayerCameraLookAt(playerid,1230.7152,-1784.3668,16.0798);
    SetPlayerVirtualWorld(playerid, world);
    SetVehicleVirtualWorld(GetPVarInt(playerid, "VehicleOn"), world);
    SetPlayerPos(playerid, 1228.9115,-1794.8713,16.0723);
    TogglePlayerControllable(playerid, 0);
	}
	case 5:
	{
	SetPVarInt(playerid,"VehicleOn", GetPVarInt(playerid, "Vehicle5"));
	if(GetPVarInt(playerid, "InDMV") == 0) return ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	GetVehiclePos(GetPVarInt(playerid, "VehicleOn"), x,y,z);
    GetVehicleZAngle(GetPVarInt(playerid, "VehicleOn"), a);
    SetPVarFloat(playerid, "VehA",a);
    SetPVarFloat(playerid, "VehX",x);
	SetPVarFloat(playerid, "VehY",y);
	SetPVarFloat(playerid, "VehZ",z);
	Streamer_UpdateEx(playerid, 1233.3409,-1790.6753,14.1980);
	ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
    SetVehiclePos(GetPVarInt(playerid, "VehicleOn"), 1229.1342,-1789.0165,15.8565);
    SetVehicleZAngle(GetPVarInt(playerid, "VehicleOn"), 226.7672);
    SetPlayerCameraPos(playerid,1225.2678,-1794.7113,14.9488+1);
    SetPlayerCameraLookAt(playerid,1230.7152,-1784.3668,16.0798);
    SetPlayerVirtualWorld(playerid, world);
    SetVehicleVirtualWorld(GetPVarInt(playerid, "VehicleOn"), world);
    SetPlayerPos(playerid, 1228.9115,-1794.8713,16.0723);
    TogglePlayerControllable(playerid, 0);
	}
    }// close's switch here
    }// close's response here
    if(response != 1)
    {
    if(GetPVarInt(playerid, "InDMV") == 1)
	SetPVarInt(playerid, "InDMV", 0),
    SetPlayerVirtualWorld(playerid, 7155),
    SetPlayerInterior(playerid, 0),
    SetPVarInt(playerid, "BuildingIn", 9),
    SetCameraBehindPlayer(playerid),
    TogglePlayerControllable(playerid, 1);
    else if(GetPVarInt(playerid, "InDMV") == 0)ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "User Control Panel", "Account Details\nGame Rules\nGame Commands\nMy Stats\nHelp Centre\nReport Someone\nVehicle's\nGang's Information\nProperties", "Select", "Close");
	}
    }// close's dialogid 5
    if(dialogid ==6)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:
	{
	if(GetPVarInt(playerid, "InDMV") == 1) return SendMessage(playerid, "You can't bring your vehicle to your position when in DMV garage."), ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	if(SeatTaken[0][GetPVarInt(playerid, "VehicleOn")] == 1)return SendMessage(playerid, "Error: someone is driving that vehicle."), ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	if(GetPVarInt(playerid, "Donator") == 0)return SendMessage(playerid, "This is for donator's only to be one vist www.city-rp.com"), ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	new Float:x,Float:y,Float:z;GetPlayerPos(playerid, x, y, z);
	SetVehiclePos(GetPVarInt(playerid, "VehicleOn") ,x,y+4, z);
	ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	}
    case 1:
	{
	if(GetPVarInt(playerid, "InDMV") == 1) return SendMessage(playerid, "You can't try to park your vehicle when in the DMV garage."), ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	if(!IsPlayerInVehicle(playerid,GetPVarInt(playerid, "VehicleOn"))) return SendMessage(playerid, "Your not in the vehicle your selecting!"), ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	UpdateAllVehicleInfo(GetPVarInt(playerid, "VehicleOn"));
	GameTextForPlayer(playerid, "~w~your vehicle will now be saved here", 2000, 1);
	OnUpdatePlayer(playerid);
	ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	return 1;
	}
	case 2:
	{
	new carsellprice = vehinfo[GetPVarInt(playerid, "VehicleOn")][cValue] / 4 * 2;
    new Float:x,Float:y,Float:z;
    new Float:a;
    new string[170];
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cOwned] = 0;
	strmid(vehinfo[GetPVarInt(playerid, "VehicleOn")][cOwner], "No-One", 0, strlen("No-One"), 128);
	GivePlayerCash(playerid,carsellprice);
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	format(string, sizeof(string), "~w~You have sold your car for: ~n~~g~$%d ~N~ ~R~ as You Sold Your Car Back You Only~N~ get half of what you paid for it back", carsellprice);
	GameTextForPlayer(playerid, string, 10000, 3);
	new str[128];
	format(str, sizeof(str), "~R~News: ~W~%s Sold His ~B~%s ~W~For ~G~$ ~W~%d",GetPlayerNameEx(playerid),VehicleNames[GetVehicleModel(GetPVarInt(playerid, "VehicleOn"))-400],carsellprice);
	NewsMessage(str);
	GetVehiclePos(GetPVarInt(playerid, "VehicleOn"), x, y, z);
	GetVehicleZAngle(GetPVarInt(playerid, "VehicleOn"), a);
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cLocked] = 0;
	foreach(Player, i) SetVehicleParamsForPlayer(GetPVarInt(playerid, "VehicleOn"), i, 0, vehinfo[GetPVarInt(playerid, "VehicleOn")][cLocked]);
    if(GetPVarInt(playerid, "InDMV") == 0)
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cLocationx] = x,
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cLocationy] = y,
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cLocationz] = z,
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cAngle] = a;
	if(GetPVarInt(playerid, "InDMV") == 1)
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cLocationx] = GetPVarFloat(playerid, "VehX"),
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cLocationy] = GetPVarFloat(playerid, "VehY"),
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cLocationz] = GetPVarFloat(playerid, "VehZ"),
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cAngle] = GetPVarFloat(playerid, "VehA");
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cLocked] = 0;
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cModop] = 0;
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cMiles] = 0;
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cLock] = 0;
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cInsurance] = 0;
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cOwned] = 0;
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cBlown] = 0;
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cInsurance] = 0;
	if(GetPVarInt(playerid, "VehicleOn") == GetPVarInt(playerid, "Vehicle0")) SetPVarInt(playerid, "Vehicle0", 0);
	else if(GetPVarInt(playerid, "VehicleOn") == GetPVarInt(playerid, "Vehicle1")) SetPVarInt(playerid, "Vehicle1", 0);
	else if(GetPVarInt(playerid, "VehicleOn") == GetPVarInt(playerid, "Vehicle2")) SetPVarInt(playerid, "Vehicle2", 0);
	else if(GetPVarInt(playerid, "VehicleOn") == GetPVarInt(playerid, "Vehicle3")) SetPVarInt(playerid, "Vehicle3", 0);
	else if(GetPVarInt(playerid, "VehicleOn") == GetPVarInt(playerid, "Vehicle4")) SetPVarInt(playerid, "Vehicle4", 0);
	else if(GetPVarInt(playerid, "VehicleOn") == GetPVarInt(playerid, "Vehicle5")) SetPVarInt(playerid, "Vehicle5", 0);
	UpdateAllVehicleInfo(GetPVarInt(playerid, "VehicleOn"));
	SortKeys(playerid);
	OnUpdatePlayer(playerid);
	CheckVeh(playerid);
    return 1;
	}
	case 3:
	{
	if(GetPVarInt(playerid, "InDMV") == 0) return SendMessage(playerid, "You need to be in the DMV garage to use this."), ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	if(vehinfo[GetPVarInt(playerid, "VehicleOn")][cLock] == 1) return SendMessage(playerid, "This vehicle already has a vehicle lock"), ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	if(GetPlayerCash(playerid) < 500) return SendMessage(playerid, "You need $500 to buy a vehicle lock."), ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	GivePlayerCash(playerid, -500);vehinfo[GetPVarInt(playerid, "VehicleOn")][cLock] = 1;UpdateVehicles(GetPVarInt(playerid, "VehicleOn"));
	SendMessage(playerid, "Congratulations you bought a vehicle lock."), PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0), UpdateVehicles(GetPVarInt(playerid, "VehicleOn"));
	ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	}
	case 4:
	{
	if(GetPVarInt(playerid, "InDMV") == 0) return SendMessage(playerid, "You need to be in the DMV garage to use this."), ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	ShowInsurance(playerid);
    }
	case 5:
	{
	if(GetPVarInt(playerid, "InDMV") == 0) return SendMessage(playerid, "You need to be in the DMV garage to use this."), ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	if(vehinfo[GetPVarInt(playerid, "VehicleOn")][cModop] == 1) return SendMessage(playerid,"This vehicle already has vehicle modifications"), ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	if(GetPlayerCash(playerid) <= 7000) return SendMessage(playerid,"You need $7000 to buy vehicle modifications."), ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	GivePlayerCash(playerid, -7000);vehinfo[GetPVarInt(playerid, "VehicleOn")][cModop] = 1;UpdateVehicles(GetPVarInt(playerid, "VehicleOn"));
	SendMessage(playerid,"Congratulations you bought automatic vehicle modifications."), PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0), UpdateVehicles(GetPVarInt(playerid, "VehicleOn"));
	ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	}
	case 6:
	{
	if(GetPVarInt(playerid, "InDMV") == 0) return SendMessage(playerid, "You need to be in the DMV garage to use this."), ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	if(vehinfo[GetPVarInt(playerid, "VehicleOn")][cLock] == 0) return SendMessage(playerid, "Buy a lock first."), ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	if(vehinfo[GetPVarInt(playerid, "VehicleOn")][cLocked] == 0) PlayerPlaySound(playerid, 1147, 0.0, 0.0, 0.0), vehinfo[GetPVarInt(playerid, "VehicleOn")][cLocked] = 1, SendMessage(playerid, "You locked your vehicle"), LockVehText = Text3D:CreateDynamic3DTextLabel("This Vehicle Is Locked", 0xF74B00ED, 0.0, 0.0, 0.0, 40, INVALID_PLAYER_ID, GetPVarInt(playerid, "VehicleOn"), 0), UpdateVehicles(GetPVarInt(playerid, "VehicleOn")),
	ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
    else if(vehinfo[GetPVarInt(playerid, "VehicleOn")][cLocked] == 1) PlayerPlaySound(playerid, 1147, 0.0, 0.0, 0.0), vehinfo[GetPVarInt(playerid, "VehicleOn")][cLocked] = 0, SendMessage(playerid, "You unlocked your vehicle"), DestroyDynamic3DTextLabel(Text3D:LockVehText), UpdateVehicles(GetPVarInt(playerid, "VehicleOn")),
	ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
    foreach(Player, i) SetVehicleParamsForPlayer(GetPVarInt(playerid, "VehicleOn"), i, 0, vehinfo[GetPVarInt(playerid, "VehicleOn")][cLocked]);
	}
	}//closes switch
    }// close response of 6
    if(response != 1)
    {
    if(GetPVarInt(playerid, "InDMV") == 1)
    SetVehiclePos(GetPVarInt(playerid, "VehicleOn"), GetPVarFloat(playerid, "VehX"),GetPVarFloat(playerid, "VehY"), GetPVarFloat(playerid, "VehZ")),
    SetVehicleZAngle(GetPVarInt(playerid, "VehicleOn"), GetPVarInt(playerid, "VehA")),
    SetVehicleVirtualWorld(GetPVarInt(playerid, "VehicleOn"), 0);
    CheckVeh(playerid);
    }
    }
    if(dialogid == 7)
	{
		if(response == 1)
		{
			new idcar = GetPlayerVehicleID(playerid);
			new car = vehinfo[idcar][cVehid];
			new str[125];
			if(VehicleOwnAble(idcar))
			{
					if(GetPVarInt(playerid, "Vehicle0") == 0) { }
					else if(GetPVarInt(playerid, "Vehicle1") == 0) { }
					else if(GetPVarInt(playerid, "Vehicle2") == 0) { }
					else if(GetPVarInt(playerid, "Vehicle3") == 0) { }
					else if(GetPVarInt(playerid, "Vehicle4") == 0) { }
					else if(GetPVarInt(playerid, "Vehicle5") == 0) { }
					else {
					TogglePlayerControllable(playerid, 1);
					RemovePlayerFromVehicle(playerid);
					engineOn[idcar] = false;
					TextDrawDestroy(Text:GetPVarInt(playerid, "CarBuy"));
					SetPVarInt(playerid, "LookingTextDraw1", 0);
				    SendMessage(playerid, "You Reached Your Max Allowed Vehicle To Get More Be A Donator To Be Able To Own 6 Vehciles!"); return 1; }
				    if(vehinfo[idcar][cOwned]==1)
				    {
					SendMessage(playerid, "Someone already owns this car");
					TogglePlayerControllable(playerid, 1);
					RemovePlayerFromVehicle(playerid);
					engineOn[GetPlayerVehicleID(playerid)] = false;
					TextDrawDestroy(Text:GetPVarInt(playerid, "CarBuy"));
					SetPVarInt(playerid, "LookingTextDraw1", 0);
					return 1;
				    }
				    if(GetPlayerCash(playerid) >= vehinfo[idcar][cValue])
				    {
					if(GetPVarInt(playerid, "Vehicle0") == 0) SetPVarInt(playerid, "Vehicle0", car);
					else if(GetPVarInt(playerid, "Vehicle1") == 0) SetPVarInt(playerid, "Vehicle1", car);
					else if(GetPVarInt(playerid, "Vehicle2") == 0) SetPVarInt(playerid, "Vehicle2", car);
					else if(GetPVarInt(playerid, "Vehicle3") == 0 && GetPVarInt(playerid,"Donator") > 0) SetPVarInt(playerid, "Vehicle3", car);
					else if(GetPVarInt(playerid, "Vehicle4") == 0 && GetPVarInt(playerid,"Donator") > 0) SetPVarInt(playerid, "Vehicle4", car);
                    else if(GetPVarInt(playerid, "Vehicle5") == 0 && GetPVarInt(playerid,"Donator") > 0) SetPVarInt(playerid, "Vehicle5", car);
					else {
					TogglePlayerControllable(playerid, 1);
					RemovePlayerFromVehicle(playerid);
					engineOn[idcar] = false;
					TextDrawDestroy(Text:GetPVarInt(playerid, "CarBuy"));
					SetPVarInt(playerid, "LookingTextDraw1", 0);
					SendMessage(playerid, "You Reached Your Max Allowed Vehicle or Be A Donator To Unlock 6 Vehicles"); return 1; }
					vehinfo[idcar][cOwned] = 1;
					strmid(vehinfo[idcar][cOwner], GetPlayerNameSave(playerid), 0, strlen(GetPlayerNameSave(playerid)), 128);
					GivePlayerCash(playerid,-vehinfo[idcar][cValue]);
					format(str,sizeof(str),"~r~News: ~w~%s Bought a ~b~%s ~W~for ~g~$ ~w~%d",GetPlayerNameEx(playerid),VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400],vehinfo[idcar][cValue]);
					NewsMessage(str);
					SortKeys(playerid);
					OnUpdatePlayer(playerid);
					TextDrawDestroy(Text:GetPVarInt(playerid, "CarBuy"));
					SetPVarInt(playerid, "LookingTextDraw1", 0);
					GameTextForPlayer(playerid, "~R~use /veh for vehicle list.", 3000, 3);
					SetCameraBehindPlayer(playerid);
                    TogglePlayerControllable(playerid, 1);
                    Vgas[idcar] = 98;
                    if(vehinfo[idcar][cJunk] == 0) RepairVehicle(idcar);
                    SetVehicleHealth(idcar,1000);
                    engineOn[idcar] = 1;
                    UpdateVehicles(idcar);
					return 1;
				    }
				    else
				    {
					SendMessage(playerid, "  You don't have enough cash with you ! ");
					TogglePlayerControllable(playerid, 1);
					RemovePlayerFromVehicle(playerid);
					engineOn[GetPlayerVehicleID(playerid)] = false;
					TextDrawDestroy(Text:GetPVarInt(playerid, "CarBuy"));
					SetPVarInt(playerid, "LookingTextDraw1", 0);
					return 1;
				    }
			  }
		}
		if(response == 0)
		{
			TogglePlayerControllable(playerid, 1);
			RemovePlayerFromVehicle(playerid);
			engineOn[GetPlayerVehicleID(playerid)] = false;
			if(GetPVarInt(playerid, "LookingTextDraw1") == 1)
			{
				TextDrawDestroy(Text:GetPVarInt(playerid, "CarBuy"));
				SetPVarInt(playerid, "LookingTextDraw1", 0);
			}
		}
		return 1;
	}
	if(dialogid == 8)
	{
	if(response == 1)
	{
	ForceClassSelection(playerid);SetPVarInt(playerid, "Class2", 1);SetPlayerHealth(playerid,0);
	}
	if(response == 0)
	{
	SetPlayerPos(playerid, 207.7722,-101.8833,1005.2578);
	SetPlayerInterior(playerid, 15);
	}
	}
	if(dialogid == 9)
	{
	if(response == 1)
	{
	SetPVarInt(playerid, "Gender", 1);
	SetPVarInt(playerid, "Step", 1);
    SetPlayerSkin(playerid, 293);
    TextDrawSetString(Text:GetPVarInt(playerid,"RegGender"), "Male");
    MainSpawn(playerid);
	return 1;
	}
	if(response == 0)
	{
	SetPVarInt(playerid, "Gender", 2);
	SetPVarInt(playerid, "Step", 1);
	SetPlayerSkin(playerid, 216);
	TextDrawSetString(Text:GetPVarInt(playerid,"RegGender"), "Female");
	MainSpawn(playerid);
	return 1;
	}
	}
	if(dialogid == 10)
	{
	if(response == 1)
	{
	new tmp[50];
	new idx;
	tmp = strtok(inputtext, idx);
	if(!strlen(tmp))
	{
	SendMessage(playerid, " You Must Enter A Number First!");
	ShowPlayerDialog(playerid,10,DIALOG_STYLE_INPUT,"Age selection","Please enter your age","enter","Back");
	return 1;
	}
	new age1 = strval(inputtext),st[5];
	if (age1 >= 16 && age1 <= 70)
	{
	SetPVarInt(playerid, "Age", age1);
	SetPVarInt(playerid, "Step", 2);
	format(st, sizeof(st), "%d",age1);
	TextDrawSetString(Text:GetPVarInt(playerid,"RegAge"), st);
	MainSpawn(playerid);
	}
	else
	{
    ShowPlayerDialog(playerid,10,DIALOG_STYLE_INPUT,"Age selection","Please enter your age\nAge's are between 16 - 70","enter","Back");
	}
	return 1;
	}
	if(response == 0)
	{
	SendMessage(playerid, "You went back a step.");
	ShowPlayerDialog(playerid,9,DIALOG_STYLE_MSGBOX,"Gender Pick","Are you male or female?","Male","Female");
	TextDrawSetString(Text:GetPVarInt(playerid,"RegGender"), "_");
	return 1;
	}
	}
    if(dialogid == 11)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:
	{
	SetPVarInt(playerid, "HereOn0", 1);SetPVarInt(playerid, "Step", 3),MainSpawn(playerid), TextDrawSetString(Text:GetPVarInt(playerid,"RegArrive"), "Coach");
	}// coach
    case 1:
	{
	SetPVarInt(playerid, "HereOn0", 2);SetPVarInt(playerid, "Step", 3),MainSpawn(playerid), TextDrawSetString(Text:GetPVarInt(playerid,"RegArrive"), "Train");
	}// train
    case 2:
	{
	SetPVarInt(playerid, "HereOn0", 3);SetPVarInt(playerid, "Step", 3),MainSpawn(playerid), TextDrawSetString(Text:GetPVarInt(playerid,"RegArrive"), "Plane");
	}// plane
    }
    }
    if(response != 1)
    {
    SendMessage(playerid, "You went back a step.");
    ShowPlayerDialog(playerid,10,DIALOG_STYLE_INPUT,"Age selection","Please enter your age","enter","Back");
    TextDrawSetString(Text:GetPVarInt(playerid,"RegAge"), "_");
	}
    }
    if(dialogid == 12)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:
	{
    ShowPlayerDialog(playerid, 13, DIALOG_STYLE_LIST, "Account Details", "Change My PassWord\nReset My Players Account\nChange Bank Code", "Select", "Back");
	}
	case 1:
	{
	new s[750];
    format(s,sizeof(s), "%s%s", "You are not allowed to do the following:\n\nDeath matching\nCar parking\nSpamming of any sort\nDisrespecting other players\nHacking or cheating in any way or form\nMixing OOC chat in RP\nMeta Gaming\n\nIf you stick",
    "to these simple rules you won't get a ban or kicked from the server.");
    ShowPlayerDialog(playerid, 17, DIALOG_STYLE_MSGBOX, "City Role Play Rules", s, "Close", "Back");
	}
	case 2:
	{
	new s[750], tt[128];
	if(GetPVarInt(playerid, "Team") == civ) tt = "Your a civilian, your not in a team";
	if(GetPVarInt(playerid, "Team") == med) tt = "MEDIC: Nothing yet";
	if(GetPVarInt(playerid, "Team") == cop) tt = "POLICE: /cuff /uncuff /ticket /speedgun /case /stoptrace";
	if(GetPVarInt(playerid, "Team") == fireman) tt = "FIRE MAN: No commands, you will be notified when there's a fire";
    format(s,sizeof(s), "%s%s%s", "General Command: /talk (Pick your talk style)  /Sleep (Must be in your house)  /pm [Playerid] [Message]  /cpanel /map /logout /Join (When invited to a gang) \n\nVehicle Commands: /start /stop or /engine to do both. /leave or /exitcar \n\nDrug Commands: /Plant /Harvest /usedrug /selldrug\n\nChat Commands: /ooc or /o /talk /me\n\nPhone Commands: /phone /hangup /p [Text] ",
    "\n\nTeam Commands: ",tt,
	"");
    ShowPlayerDialog(playerid, 17, DIALOG_STYLE_MSGBOX, "Game Commands", s, "Close", "Back");
    }
    case 3:
	{
	new s[750], tt[10], t[15], team[20], job[20], pick[4][20];
	if(GetPVarInt(playerid, "Donator") == 0) tt = "No";
	if(GetPVarInt(playerid, "Donator") == 1) tt = "Yes";
	if(GetPVarInt(playerid, "Gender") == 1) t = "Male";
	if(GetPVarInt(playerid, "Donator") == 0) t = "Female";
	team = "Civilian";
	if(GetPVarInt(playerid, "Team") == cop) team = "Police Force", job = "Police Man";
	if(GetPVarInt(playerid, "Team") == fireman) team = "Fire Man", job = "Fire Man";
	if(GetPVarInt(playerid, "Team") == civ) team = "Civilian", job = "Sign On";
	if(GetPVarInt(playerid, "Team") == med) team = "Medic", job = "Medic";
	pick[0] = "Dont Own", pick[1] = "Dont Own", pick[2] = "Dont Own", pick[3] = "Dont Own";
	if(GetPVarInt(playerid, "HotWireKey") > 0) pick[0] = "Own One";
	if(GetPVarInt(playerid, "HotWireKey") > 1) pick[1] = "Own One";
	if(GetPVarInt(playerid, "HotWireKey") > 2) pick[2] = "Own One";
	if(GetPVarInt(playerid, "Number") != 0) pick[3] = "Own One";
    format(s,sizeof(s), "General Information:\n      User Name: %s    Age: %d    Gender: %s    Donator: %s    Time Spent Online: %d Hours, %d Minutes and %d Seconds\n\nMoney Information:\n      Wallet: $%d    Bank: $%d    Money Spent: $%d    Money Earned: $%d\n\nPlayer Status:\n      Team: %s    Experience Points: %d    Rank: %s    Phone Number: %d    Job: %s\n\nItems Information:\n      Pick Lock: %s    Screw Driver: %s    Skeleton Key: %s    Mobile Phone: %s",
	GetPlayerNameEx(playerid), GetPVarInt(playerid, "Age"), t, tt, GetPVarInt(playerid, "Hours"), GetPVarInt(playerid, "Minutes"), GetPVarInt(playerid, "Seconds"), GetPlayerCash(playerid), GetPVarInt(playerid, "Bank"), GetPVarInt(playerid, "Spent"), GetPVarInt(playerid, "Earned"), team, GetPVarInt(playerid, "Exp"), GetString(playerid, "Rank"), GetPVarInt(playerid, "Number"), job, pick[0], pick[1], pick[2], pick[3]);
	ShowPlayerDialog(playerid, 17, DIALOG_STYLE_MSGBOX, "Stats", s, "Close", "Back");
	}
	case 4:
	{
	ShowPlayerDialog(playerid, 18, DIALOG_STYLE_LIST, "Help Centre", "How to find a job\nHow to fuel a vehicle\nHow to fix a vehicle\nHow to change your clothes\nWere to buy vehicle\nWere to get a gun license\nWere to get a driving license\nWere to get a blue light license", "Select", "Back");
	}
	case 5:
	{
	ShowPlayerDialog(playerid,20,DIALOG_STYLE_INPUT,"Report Step 1","Please enter the players id number.","Enter","Back");
	}
	case 6:
	{
	CheckVeh(playerid);
	}
	case 7:
	{
	ShowPlayerDialog(playerid, 23, DIALOG_STYLE_LIST, "Gang Information", "Create A Gang\nMy Gang Information", "Select", "Back");
	}
	case 8:ShowPlayerDialog(playerid, 59, DIALOG_STYLE_LIST, "Properties Information", "House's\nBuilding's\nRenting Appartment\nBuilding Share's", "Select", "Back");
	}//switch
    }//response
    }// dialog 12
    if(dialogid == 13)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:
	{
	ShowPlayerDialog(playerid,16,DIALOG_STYLE_INPUT,"Change My Password","Please enter your current password to continue.","Enter","Back");
    }
	case 1:
	{
	ShowPlayerDialog(playerid,15,DIALOG_STYLE_INPUT,"Restore My Account","Please enter your current password to continue.","Enter","Back");
	}
	case 2:
	{
	ShowPlayerDialog(playerid,51,DIALOG_STYLE_INPUT,"Change My Bank Code","Please enter your current password to continue.","Enter","Back");
	}
	}//switch
    }//response
    if(response != 1)
    {
    ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "User Control Panel", "Account Details\nGame Rules\nGame Commands\nMy Stats\nHelp Centre\nReport Someone\nVehicle's\nGang's Information\nProperties", "Select", "Close");
    }
    }// dialog 13
    if(dialogid == 14)
    {
    if(response == 1)
    {
    new string[128];
    if(!strlen(inputtext))
	{
	SendMessage(playerid, " You Must Enter A Password First!");
	ShowPlayerDialog(playerid,14,DIALOG_STYLE_INPUT,"Change your password","Error: Enter a password!\n\nPlease enter the password you would like","Change","Back");
	return 1;
	}
	SetPVarString(playerid, "Password", inputtext);
	format(string, sizeof(string), "You have successfully changed your password to : %s ", inputtext);
	SendMessage(playerid, string);
	SendMessage(playerid, "Please Don't forget your password, if you do you can vist www.city-rp.com to resolve the situation");
	OnUpdatePlayer(playerid);
	}//response
    if(response == 0)
    {
    ShowPlayerDialog(playerid, 13, DIALOG_STYLE_LIST, "Account Details", "Change My PassWord\nReset My Players Account\nChange Bank Code", "Select", "Back");
    }
    }// dialog 14
    if(dialogid == 15)
    {
    if(response == 1)
    {
    if(!strlen(inputtext))
	{
	SendMessage(playerid, "Enter your password");
	ShowPlayerDialog(playerid,15,DIALOG_STYLE_INPUT,"Restore My Account","Please enter your current password to continue.","Enter","Back");
	return 1;
	}
    if(strcmp(GetString(playerid, "Password"), inputtext, true)== 0)
	{
	RestoreAccount(playerid);
	SendMessage(playerid,"Your account was restored successfully");
	}
	else
	{
	ShowPlayerDialog(playerid,15,DIALOG_STYLE_INPUT,"Restore My Account","ERROR: Password Wrong!\n\nPlease enter your current password to continue.","Enter","Back");
	}
	}// response
	if(response == 0)
    {
    ShowPlayerDialog(playerid, 13, DIALOG_STYLE_LIST, "Account Details", "Change My PassWord\nReset My Players Account\nChange Bank Code", "Select", "Back");
    }
	}// close dialog 15
    if(dialogid == 16)
    {
    if(response == 1)
    {
    if(!strlen(inputtext))
	{
	SendMessage(playerid, "Enter your password");
	ShowPlayerDialog(playerid,16,DIALOG_STYLE_INPUT,"Change My Password","Please enter your current password to continue.","Enter","Back");
	return 1;
	}
    if(strcmp(GetString(playerid, "Password"), inputtext, true)== 0)
	{
	ShowPlayerDialog(playerid,14,DIALOG_STYLE_INPUT,"Change My Password","Please enter the password you would like","Change","Back");
    }
	else
	{
	ShowPlayerDialog(playerid,16,DIALOG_STYLE_INPUT,"Change My Password","ERROR: Password Wrong!\n\nPlease enter your current password to continue.","Enter","Back");
	}
	}// response
	if(response == 0)
    {
    ShowPlayerDialog(playerid, 13, DIALOG_STYLE_LIST, "Account Details", "Change My PassWord\nReset My Players Account\nChange Bank Code", "Select", "Back");
    }
	}// close dialog 16
	if(dialogid == 17)
    {
    if(response != 0)
    {}
    if(response != 1)
    {
    ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "User Control Panel", "Account Details\nGame Rules\nGame Commands\nMy Stats\nHelp Centre\nReport Someone\nVehicle's\nGang's Information", "Select", "Close");
    }
    }
    if(dialogid == 18)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:ShowPlayerDialog(playerid, 19, DIALOG_STYLE_MSGBOX, "How to find a job", "If your looking for a job and can't find one then please type /map then click building locations\n\nthen click on 'Job Centre' go to the building and walk inside\n\nthen walk into the red checkpoint inside.", "Close", "Back");
	case 1:ShowPlayerDialog(playerid, 19, DIALOG_STYLE_MSGBOX, "How to fuel a vehicle", "Go to any gas station in the city that you see, pull up into the gas station a hit the ALT on your keyboard\n\nIt cost $1 Per 1% of fuel.", "Close", "Back");
	case 2:ShowPlayerDialog(playerid, 19, DIALOG_STYLE_MSGBOX, "How to fix a vehicle", "Go to any gas station in the city that you see, drive your vehicle into the spanner icon\n\nIf you have insurance on your vehicle it's free to fix, if you don't it's a $50 fee to repair it.\n\nYou can buy vehicle insurance using /veh in your vehicle list.", "Close", "Back");
    case 3:ShowPlayerDialog(playerid, 19, DIALOG_STYLE_MSGBOX, "How to change your clothes", "Go to any clothes shop you see around the city.\n\nOnce your at one walk into the store and enter the checkpoint.", "Close", "Back");
    case 4:ShowPlayerDialog(playerid, 19, DIALOG_STYLE_MSGBOX, "Were to buy vehicle", "You can type /map and click on 'Auto Bahn' go to the red marker and pick the vehicle you want.", "Close", "Back");
    case 5:ShowPlayerDialog(playerid, 19, DIALOG_STYLE_MSGBOX, "Were to get a gun license", "You can type /map and click on 'Gun Store' go to the red marker,\n\nThen enter the building go up stairs and walk towards the door leading to the gun training area.", "Close", "Back");
    case 6:ShowPlayerDialog(playerid, 19, DIALOG_STYLE_MSGBOX, "Were to get a driving license", "You can type /map and click on 'DMV Centre' go to the red marker,\n\nThen enter the building and in front of you, you will see a red icon walk into it", "Close", "Back");
    case 7:ShowPlayerDialog(playerid, 19, DIALOG_STYLE_MSGBOX, "Were to get a blue light license", "You can type /map and click on 'DMV Centre' go to the red marker,\n\nThen enter the building and to the right you will see a red icon walk into it", "Close", "Back");
	}// close switch
	}// close response
	if(response != 1)
    {
    ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "User Control Panel", "Account Details\nGame Rules\nGame Commands\nMy Stats\nHelp Centre\nReport Someone\nVehicle's\nGang's Information\nProperties", "Select", "Close");
    }
	}// close dialog 18
	if(dialogid == 19)
    {
    if(response != 0)
    {}
    if(response != 1)
    {
    ShowPlayerDialog(playerid, 18, DIALOG_STYLE_LIST, "Help Centre", "How to find a job\nHow to fuel a vehicle\nHow to fix a vehicle\nHow to change your clothes\nWere to buy vehicle", "Select", "Back");
	}
    }
    if(dialogid == 20)
    {
    if(response == 1)
    {
    if(strlen(inputtext) > 2)
	{
    ShowPlayerDialog(playerid,20,DIALOG_STYLE_INPUT,"Report Step 1","ERROR: You forgot to enter the players id\n\nPlease enter the players id number.","Enter","Back");
    return 1;
    }
    new id;
    if(sscanf(inputtext, "i", id))
    {
	ShowPlayerDialog(playerid,20,DIALOG_STYLE_INPUT,"Report Step 1","ERROR: You forgot to enter the players id\n\nPlease enter the players id number.","Enter","Back");
	return 1;
	}
	if(!IsPlayerConnected(id))
	{
	ShowPlayerDialog(playerid,20,DIALOG_STYLE_INPUT,"Report Step 1","ERROR: That playerid isn't connected\n\nPlease enter the players id number.","Enter","Back");
	return 1;
	}
	SetPVarInt(playerid, "ReportId", id);
	ShowPlayerDialog(playerid,21,DIALOG_STYLE_INPUT,"Report Step 2","Now enter the description of the report","Enter","Back");
	}
	if(response == 0)
    {
    ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "User Control Panel", "Account Details\nGame Rules\nGame Commands\nMy Stats\nHelp Centre\nReport Someone\nVehicle's\nGang's Information\nProperties", "Select", "Close");
    }
	}
	if(dialogid == 21)
    {
    if(response == 1)
    {
    if(sscanf(inputtext, "s", inputtext))
    {
	ShowPlayerDialog(playerid,21,DIALOG_STYLE_INPUT,"Report Step 2","ERROR: You forgot to enter the description\n\nNow enter the description of the report","Enter","Back");
	return 1;
	}
	AdminReportMessage(inputtext, GetPVarInt(playerid, "ReportId"), playerid);
	}
	if(response == 0)
    {
    ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "User Control Panel", "Account Details\nGame Rules\nGame Commands\nMy Stats\nHelp Centre\nReport Someone\nVehicle's\nGang's Information\nProperties", "Select", "Close");
    }
    }
   	if(dialogid == 22)
    {
    if(response == 1)
    {
    if(sscanf(inputtext, "s", inputtext))
    {
	ShowPlayerDialog(playerid, 22, DIALOG_STYLE_INPUT, "Create A Gang Step 1", "ERROR: You forgot to enter the name\n\nPlease Enter The Name Of Your Gang", "Select", "Back");
    return 1;
	}
	if(strlen(inputtext) >= 59)
	{
    ShowPlayerDialog(playerid, 22, DIALOG_STYLE_INPUT, "Create A Gang Step 1", "ERROR: The name you want it to long.\n\nPlease Enter The Name Of Your Gang", "Select", "Back");
    return 1;
	}
	if(InvalidSymbol(playerid, inputtext) == 1)return ShowPlayerDialog(playerid, 22, DIALOG_STYLE_INPUT, "Create A Gang Step 1", "ERROR: Inavlid symbol.\n\nPlease Enter The Name Of Your Gang", "Select", "Back");
	if(CheckGang(inputtext) != 0) return SendMessage(playerid, "This gang name is already taken.");
	AddGang(GetPlayerNameEx(playerid), inputtext, 0, 0, 0);
 	SetPVarString(playerid,"Gang", inputtext);
    SetPVarInt(playerid, "GangId", CheckGang(GetString(playerid,"Gang")));
	}
	}
	if(dialogid == 23)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:
	{
    if(CheckGangOwn(GetPlayerNameEx(playerid)) != 0) return SendMessage(playerid, "You are already a leader of a gang"),ShowPlayerDialog(playerid, 23, DIALOG_STYLE_LIST, "Gang Information", "Create A Gang\nMy Gang Information", "Select", "Back");
    ShowPlayerDialog(playerid, 22, DIALOG_STYLE_INPUT, "Create A Gang Step 1", "Please Enter The Name Of Your Gang", "Select", "Back");
	}
	case 1:
	{
    if(CheckGangOwn(GetPlayerNameEx(playerid)) == 0) return SendMessage(playerid, "You don't own a gang."),ShowPlayerDialog(playerid, 23, DIALOG_STYLE_LIST, "Gang Information", "Create A Gang\nMy Gang Information", "Select", "Back");
    ShowPlayerDialog(playerid, 24, DIALOG_STYLE_LIST, "My Gang Information", "Gang Gun's\nGang information\nInvite Players\nDelete Gang", "Select", "Go Back");
	}
	}
	}
	if(response != 1)
    {
    ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "User Control Panel", "Account Details\nGame Rules\nGame Commands\nMy Stats\nHelp Centre\nReport Someone\nVehicle's\nGang's Information\nProperties", "Select", "Close");
    }
    }
   	if(dialogid == 24)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:
	{
	ShowPlayerDialog(playerid, 26, DIALOG_STYLE_LIST, "My Gang's Gun's", "Buy Silenced pistol $60,000\nBuy Shotgun $75,000\nBuy Micro Uzi (Mac 10) $100,000\nBuy Ak47 $140,000\nBuy Molotov cocktail $50,000\nBuy Grenades $90,000", "Select", "Go Back");
	}
	case 1:
	{
	new string[100];
	new id = GetPVarInt(playerid, "GangId");
    format(string, sizeof(string), "Gang Name: %s\n\n     Member: %d     Kills: %d     Gang Rank: %d",GetString(playerid, "Gang"), GangInfo[id][gMembers], GangInfo[id][gKills], GangInfo[id][gRank]);
    ShowPlayerDialog(playerid, 25, DIALOG_STYLE_MSGBOX, "Gang Information", string, "Close", "Go Back");
	}
	case 2:
	{
	ShowPlayerDialog(playerid,55,DIALOG_STYLE_INPUT,"Gang Invite","Please enter the ID of the player you wish to ask to join your gang","Enter","Back");
	}
	case 3:
	{
	ShowPlayerDialog(playerid,27,DIALOG_STYLE_INPUT,"Delete My Gang","Please enter your current password to continue.","Enter","Back");
	}
	}
	}
	if(response != 1)
    {
    ShowPlayerDialog(playerid, 23, DIALOG_STYLE_LIST, "Gang Information", "Create A Gang\nMy Gang Information", "Select", "Back");
	}
    }
    if(dialogid == 25)
    {
    if(response != 0)
    {}
    if(response != 1)
    {
    ShowPlayerDialog(playerid, 24, DIALOG_STYLE_LIST, "My Gang Information", "Gang Gun's\nGang information\nInvite Players\nDelete Gang", "Select", "Go Back");
	}
    }
   	if(dialogid == 26)
    {
    new id = GetPVarInt(playerid, "GangId");
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:
	{
	if(GangInfo[id][gGuns1] != 0){SendMessage(playerid, "You already have a Silenced pistol for your gang.");ShowPlayerDialog(playerid, 26, DIALOG_STYLE_LIST, "My Gang's Gun's", "Buy Silenced pistol $60,000\nBuy Shotgun $75,000\nBuy Micro Uzi (Mac 10) $100,000\nBuy Ak47 $140,000\nBuy Molotov cocktail $50,000\nBuy Grenades $90,000", "Select", "Go Back");return 1;}
	if(GetPlayerCash(playerid) < 60000){SendMessage(playerid, "You need $60,000 for the Silenced pistol upgrade.");ShowPlayerDialog(playerid, 26, DIALOG_STYLE_LIST, "My Gang's Gun's", "Buy Silenced pistol $60,000\nBuy Shotgun $75,000\nBuy Micro Uzi (Mac 10) $100,000\nBuy Ak47 $140,000\nBuy Molotov cocktail $50,000\nBuy Grenades $90,000", "Select", "Go Back");return 1;}
	GangInfo[id][gGuns1] = 23;
	SendMessage(playerid, "You bought the Silenced pistol upgrade for $60,000.");
	SendMessage(playerid, "You and your gang member's will now spawn with a Silenced pistol with 50 ammo.");
	UpdateGang(id);
	}
	case 1:
	{
	if(GangInfo[id][gGuns2] != 0){SendMessage(playerid, "You already have a Shotgun for your gang.");ShowPlayerDialog(playerid, 26, DIALOG_STYLE_LIST, "My Gang's Gun's", "Buy Silenced pistol $60,000\nBuy Shotgun $75,000\nBuy Micro Uzi (Mac 10) $100,000\nBuy Ak47 $140,000\nBuy Molotov cocktail $50,000\nBuy Grenades $90,000", "Select", "Go Back");return 1;}
	if(GetPlayerCash(playerid) < 75000){SendMessage(playerid, "You need $75,000 for the Shotgun upgrade.");ShowPlayerDialog(playerid, 26, DIALOG_STYLE_LIST, "My Gang's Gun's", "Buy Silenced pistol $60,000\nBuy Shotgun $75,000\nBuy Micro Uzi (Mac 10) $100,000\nBuy Ak47 $140,000\nBuy Molotov cocktail $50,000\nBuy Grenades $90,000", "Select", "Go Back");return 1;}
	GangInfo[id][gGuns2] = 25;
	SendMessage(playerid, "You bought the Shotgun upgrade for $75,000.");
	SendMessage(playerid, "You and your gang member's will now spawn with a Shotgun with 50 ammo.");
	UpdateGang(id);
	}
	case 2:
	{
	if(GangInfo[id][gGuns3] != 0){SendMessage(playerid, "You already have a Micro Uzi (Mac 10) for your gang.");ShowPlayerDialog(playerid, 26, DIALOG_STYLE_LIST, "My Gang's Gun's", "Buy Silenced pistol $60,000\nBuy Shotgun $75,000\nBuy Micro Uzi (Mac 10) $100,000\nBuy Ak47 $140,000\nBuy Molotov cocktail $50,000\nBuy Grenades $90,000", "Select", "Go Back");return 1;}
	if(GetPlayerCash(playerid) < 100000){SendMessage(playerid, "You need $100,000 for the Micro Uzi (Mac 10) upgrade.");ShowPlayerDialog(playerid, 26, DIALOG_STYLE_LIST, "My Gang's Gun's", "Buy Silenced pistol $60,000\nBuy Shotgun $75,000\nBuy Micro Uzi (Mac 10) $100,000\nBuy Ak47 $140,000\nBuy Molotov cocktail $50,000\nBuy Grenades $90,000", "Select", "Go Back");return 1;}
	GangInfo[id][gGuns3] = 28;
	SendMessage(playerid, "You bought the Micro Uzi (Mac 10) upgrade for $100,000.");
	SendMessage(playerid, "You and your gang member's will now spawn with a Micro Uzi (Mac 10) with 50 ammo.");
	UpdateGang(id);
	}
	case 3:
	{
	if(GangInfo[id][gGuns4] != 0){SendMessage(playerid, "You already have a Ak47 for your gang.");ShowPlayerDialog(playerid, 26, DIALOG_STYLE_LIST, "My Gang's Gun's", "Buy Silenced pistol $60,000\nBuy Shotgun $75,000\nBuy Micro Uzi (Mac 10) $100,000\nBuy Ak47 $140,000\nBuy Molotov cocktail $50,000\nBuy Grenades $90,000", "Select", "Go Back");return 1;}
	if(GetPlayerCash(playerid) < 140000){SendMessage(playerid, "You need $140,000 for the Ak47 upgrade.");ShowPlayerDialog(playerid, 26, DIALOG_STYLE_LIST, "My Gang's Gun's", "Buy Silenced pistol $60,000\nBuy Shotgun $75,000\nBuy Micro Uzi (Mac 10) $100,000\nBuy Ak47 $140,000\nBuy Molotov cocktail $50,000\nBuy Grenades $90,000", "Select", "Go Back");return 1;}
	GangInfo[id][gGuns4] = 30;
	SendMessage(playerid, "You bought the Ak47 upgrade for $140,000.");
	SendMessage(playerid, "You and your gang member's will now spawn with a Ak47 with 50 ammo.");
	UpdateGang(id);
	}
	case 4:
	{
	if(GetPlayerCash(playerid) < 50000){SendMessage(playerid, "You need $50,000 for Molotov cocktail upgrade.");ShowPlayerDialog(playerid, 26, DIALOG_STYLE_LIST, "My Gang's Gun's", "Buy Silenced pistol $60,000\nBuy Shotgun $75,000\nBuy Micro Uzi (Mac 10) $100,000\nBuy Ak47 $140,000\nBuy Molotov cocktail $50,000\nBuy Grenades $90,000", "Select", "Go Back");return 1;}
	GangInfo[id][gGuns6] = 18;
	SendMessage(playerid, "You bought the Molotov cocktail upgrade for $50,000.");
	SendMessage(playerid, "You and your gang member's will now spawn with a Molotov cocktail with 10 ammo.");
	UpdateGang(id);
	}
	case 5:
	{
	if(GetPlayerCash(playerid) < 90000){SendMessage(playerid, "You need $90,000 for Grenades upgrade.");ShowPlayerDialog(playerid, 26, DIALOG_STYLE_LIST, "My Gang's Gun's", "Buy Silenced pistol $60,000\nBuy Shotgun $75,000\nBuy Micro Uzi (Mac 10) $100,000\nBuy Ak47 $140,000\nBuy Molotov cocktail $50,000\nBuy Grenades $90,000", "Select", "Go Back");return 1;}
	GangInfo[id][gGuns6] = 16;
	SendMessage(playerid, "You bought the Grenades upgrade for $90,000.");
	SendMessage(playerid, "You and your gang member's will now spawn with a Grenades with 10 ammo.");
	UpdateGang(id);
	}
	}
	}
	if(response != 1)
    {
    ShowPlayerDialog(playerid, 24, DIALOG_STYLE_LIST, "My Gang Information", "Gang Gun's\nGang information\nInvite Players\nDelete Gang", "Select", "Go Back");
	}
	}
	if(dialogid == 27)
    {
    if(response == 1)
    {
    if(!strlen(inputtext))
	{
	SendMessage(playerid, "Enter your password");
	ShowPlayerDialog(playerid,27,DIALOG_STYLE_INPUT,"Delete My Gang","Please enter your current password to continue.","Enter","Back");
	return 1;
	}
    if(strcmp(GetString(playerid, "Password"), inputtext, true)== 0)
	{
	DeleteGang(playerid);
	SendMessage(playerid, "You just deleted your gang.");
	}
	else
	{
	ShowPlayerDialog(playerid,27,DIALOG_STYLE_INPUT,"Delete My Gang","ERROR: Wrong password.\n\nPlease enter your current password to continue.","Enter","Back");
	}
	}// response
	if(response == 0)
    {
    ShowPlayerDialog(playerid, 24, DIALOG_STYLE_LIST, "My Gang Information", "Gang Gun's\nGang information\nInvite Players\nDelete Gang", "Select", "Go Back");
    }
	}
	if(dialogid == 28)
    {
    if(response == 1)
    {
    if(incoptest == 1) return SendMessage(playerid, "Someone is already training please wait..");
    if(GetPVarInt(playerid, "License") < 1) return SendMessage(playerid, "You need to take your driving test first.");
    StartCopTest(playerid);
    incoptest = 1;
    }
    }
   	if(dialogid == 29)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:
    {
    if(GetPVarInt(playerid, "HotWireKey") < 1) return SendMessage(playerid,"You don't own a Pick Lock"), ShowPlayerDialog(playerid, 29, DIALOG_STYLE_LIST, "HotWire", "Pick Lock 30% Chance\nScrew Driver 60% Chance\nSkeleton Key 100%", "Select", "Go Back");
    SetPVarInt(playerid, "PickedHorWire", 1);
	RunHotWire(playerid);
    TogglePlayerControllable(playerid, 0);
    }
    case 1:
    {
    if(GetPVarInt(playerid, "HotWireKey") < 2) return SendMessage(playerid,"You don't own a Screw Driver"), ShowPlayerDialog(playerid, 29, DIALOG_STYLE_LIST, "HotWire", "Pick Lock 30% Chance\nScrew Driver 60% Chance\nSkeleton Key 100%", "Select", "Go Back");
    SetPVarInt(playerid, "PickedHorWire", 2);
	RunHotWire(playerid);
    TogglePlayerControllable(playerid, 0);
    }
    case 2:
    {
    if(GetPVarInt(playerid, "HotWireKey") < 3) return SendMessage(playerid,"You don't own a Skeleton Key"), ShowPlayerDialog(playerid, 29, DIALOG_STYLE_LIST, "HotWire", "Pick Lock 30% Chance\nScrew Driver 60% Chance\nSkeleton Key 100%", "Select", "Go Back");
    hotwired1(playerid);
    }
    }
	}
    if(response != 1)
    {
	SetPVarInt(playerid, "InHotWire", 0);
	ShowVehInfo(playerid);
	}
    }
    if(dialogid == 30)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:
    {
    if(GetPVarInt(playerid, "Number") != 0) return SendMessage(playerid, "You already own a mobile phone.");
    if(GetPlayerCash(playerid) < 100) return SendMessage(playerid,"You need $100 to buy a mobile phone."),ShowPlayerDialog(playerid, 30, DIALOG_STYLE_LIST,"Shop List","Mobile Phone $100\nCalling Credit $10\nWatch $25\nPick Lock $50\nScrew Driver$ 75\nSkeleton Key $30,000","Select","Go Back");
    new number = 100000 + random(89999999);
	SetPVarInt(playerid, "Number", number);
	GivePlayerCash(playerid, -100);
	SendMessage(playerid,"You bought a mobile phone for $100.");
    }
    case 1:
    {
    }
    case 2:
    {
    if(GetPVarInt(playerid, "Watch") == 1) return SendMessage(playerid, "You already own a watch.");
    if(GetPlayerCash(playerid) < 25) return SendMessage(playerid,"You need $25 to buy a watch."),ShowPlayerDialog(playerid, 30, DIALOG_STYLE_LIST,"Shop List","Mobile Phone $100\nCalling Credit $10\nWatch $25\nPick Lock $50\nScrew Driver$ 75\nSkeleton Key $30,000","Select","Go Back");
	SetPVarInt(playerid, "Watch", 1);
	GivePlayerCash(playerid, -25);
	SendMessage(playerid,"You bought a watch for $25.");
	}
    case 3:
    {
    if(GetPVarInt(playerid, "HotWireKey") == 1) return SendMessage(playerid, "You already own a pick lock.");
    if(GetPlayerCash(playerid) < 50) return SendMessage(playerid,"You need $50 to buy a pick lock."),ShowPlayerDialog(playerid, 30, DIALOG_STYLE_LIST,"Shop List","Mobile Phone $100\nCalling Credit $10\nWatch $25\nPick Lock $50\nScrew Driver$ 75\nSkeleton Key $30,000","Select","Go Back");
    SetPVarInt(playerid, "HotWireKey", 1);
    SendMessage(playerid,"You bought a pick lock for $50.");
    GivePlayerCash(playerid, -75);
    }
    case 4:
    {
    if(GetPVarInt(playerid, "HotWireKey") < 1) return SendMessage(playerid, "You must buy the pick lock first.");
    if(GetPVarInt(playerid, "HotWireKey") == 2) return SendMessage(playerid, "You already own a Screw Driver.");
    if(GetPlayerCash(playerid) < 75) return SendMessage(playerid,"You need $75 to buy a Screw Driver."),ShowPlayerDialog(playerid, 30, DIALOG_STYLE_LIST,"Shop List","Mobile Phone $100\nCalling Credit $10\nWatch $25\nPick Lock $50\nScrew Driver$ 75\nSkeleton Key $30,000","Select","Go Back");
    SetPVarInt(playerid, "HotWireKey", 2);
    SendMessage(playerid,"You bought a screw driver for $75.");
    GivePlayerCash(playerid, -150);
    }
    case 5:
    {
    if(GetPVarInt(playerid, "HotWireKey") < 2) return SendMessage(playerid, "You must buy the Screw Driver first.");
    if(GetPVarInt(playerid, "HotWireKey") == 3) return SendMessage(playerid, "You already own a Skeleton Key.");
    if(GetPlayerCash(playerid) < 30000) return SendMessage(playerid,"You need $30,000 to buy a Skeleton Key."),ShowPlayerDialog(playerid, 30, DIALOG_STYLE_LIST,"Shop List","Mobile Phone $100\nCalling Credit $10\nWatch $25\nPick Lock $50\nScrew Driver$ 75\nSkeleton Key $30,000","Select","Go Back");
    SetPVarInt(playerid, "HotWireKey", 3);
    SendMessage(playerid,"You bought a Skeleton Key for $30,000.");
    GivePlayerCash(playerid, -30000);
    }
    }
    }
    }
    if(dialogid == 31)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:
    {
    ShowPlayerDialog(playerid,32,DIALOG_STYLE_INPUT,"Dial A Number","Please enter the number you wish to dial.","Call","Back");
    }
    case 1:
    {
    new x = 0;
    foreach(player, i)
    {
    if(GetPVarInt(i,"Team") == cop) x++;
	}
    if(x == 0) return SendMessage(playerid, "I'm sorry but there isn't any officer's online.");
    if(x > 0) return ShowPlayerDialog(playerid,33,DIALOG_STYLE_INPUT,"Your Problem","Please enter the message you would like the officer to see\n\nNote: The officer who deal's with your case will ring your mobile phone back.","enter","Back");
    }
    case 2:
    {

    }
    case 3:
    {
    ShowPlayerDialog(playerid,38,DIALOG_STYLE_INPUT,"Send A Text","Please enter the number you wish to Text.","Enter","Back");
    }
    case 4:
    {
    new sms[130];
    format(sms, sizeof(sms), "Your Last Mesage Received:\n\n     %s",GetString(playerid,"TextMessage"));
    if(CheckNumberText(playerid, GetPVarInt(playerid, "Texter")) != 0) return ShowPlayerDialog(playerid,41,DIALOG_STYLE_MSGBOX,"Read My Last Text Message", sms ,"Back","Back");
    ShowPlayerDialog(playerid,40,DIALOG_STYLE_MSGBOX,"Read My Last Text Message", sms ,"Reply","Back");
    }
    case 5:
    {
    if(GetPVarInt(playerid, "PickedUp") == 0) return SendMessage(playerid, "You don't have anyone calling you.");
    SetPVarInt(playerid, "PickedUp", GetPVarInt(playerid, "Caller"));
    SendMessage(GetPVarInt(playerid, "Caller"), "Your call was answered, you can now use /p [chat] to phone chat.");
    SendMessage(playerid, "You Picked up, you can now use /p [chat] to phone chat.");
    SetPVarInt(GetPVarInt(playerid, "Caller"), "CanTalk", 1);
    SetPVarInt(playerid, "CanTalk", 1);
    }
    }
    }
    }
    if(dialogid == 32)
    {
    if(response == 1)
    {
    new number, string[100];
    if(sscanf(inputtext, "i", number)) return SendMessage(playerid, "You must enter a number only."), ShowPlayerDialog(playerid,32,DIALOG_STYLE_INPUT,"Dial A Number","Please enter the number you wish to dial.","Call","Back");
    if(number == GetPVarInt(playerid, "Number")) return SendMessage(playerid, "You can't dial your own number.");
	if(CheckNumber(playerid, number) == 0) return SendMessage(playerid, "That phone number is not online."),ShowPlayerDialog(playerid,32,DIALOG_STYLE_INPUT,"Dial A Number","Please enter the number you wish to dial.","Call","Back");
	format(string, sizeof(string), "You have a caller on the line, caller name: %s",GetPlayerNameEx(playerid));
    SendMessage(GetPVarInt(playerid, "Calling"), string);
    format(string, sizeof(string), "%s, has been notified that your trying to call them, please wait for them to pick up.",GetPlayerNameEx(GetPVarInt(playerid, "Calling")));
    SendMessage(playerid, string);
    }
    if(response == 0)
    {
	if(GetPVarInt(playerid, "PickedUp") == 0)
    ShowPlayerDialog(playerid, 31, DIALOG_STYLE_LIST, "Mobile Phone", "Dial A Number\nCall Police\nCall Medic\nSend A Text\nRead Last Message", "Select", "Close");
    if(GetPVarInt(playerid, "PickedUp") != 0)
    ShowPlayerDialog(playerid, 31, DIALOG_STYLE_LIST, "Mobile Phone", "Dial A Number\nCall Police\nCall Medic\nSend A Text\nRead Last Message\nAnswer Your Phone", "Select", "Close");
    }
    }
    if(dialogid == 33)
    {
    if(response == 1)
    {
    if(isnull(inputtext)) return SendMessage(playerid, "Please enter your message."), ShowPlayerDialog(playerid,33,DIALOG_STYLE_INPUT,"Your Problem","Please enter the message you would like the officer to see\n\nNote: The officer who deal's with your case will ring your mobile phone back.","enter","Back");
    if(strlen(inputtext) > 100) return SendMessage(playerid, "Please shorten your message."), ShowPlayerDialog(playerid,33,DIALOG_STYLE_INPUT,"Your Problem","Please enter the message you would like the officer to see\n\nNote: The officer who deal's with your case will ring your mobile phone back.","enter","Back");
    CopReportMessage(2, inputtext, playerid, GetPlayerNameEx(playerid));
    }
    if(response == 0)
    {
    if(GetPVarInt(playerid, "PickedUp") == 0)
    ShowPlayerDialog(playerid, 31, DIALOG_STYLE_LIST, "Mobile Phone", "Dial A Number\nCall Police\nCall Medic\nSend A Text\nRead Last Message", "Select", "Close");
    if(GetPVarInt(playerid, "PickedUp") != 0)
    ShowPlayerDialog(playerid, 31, DIALOG_STYLE_LIST, "Mobile Phone", "Dial A Number\nCall Police\nCall Medic\nSend A Text\nRead Last Message\nAnswer Your Phone", "Select", "Close");
    }
    }
    if(dialogid == 34)
    {
    if(response == 1)
    {
    new pcase, scase[30];
    if(sscanf(inputtext, "i", pcase)) return SendMessage(playerid, "You must enter a number only."), ShowPlayerDialog(playerid,34,DIALOG_STYLE_INPUT,"Enter Case Number","Please enter the case number you wish to follow up.","take","Back");
    if(CheckCase(playerid, pcase) == 0) return SendMessage(playerid, "That is not a valid case number."),ShowPlayerDialog(playerid,34,DIALOG_STYLE_INPUT,"Enter Case Number","Please enter the case number you wish to follow up.","take","Back");
    format(scase, sizeof(scase), "Case ID: %d",GetPVarInt(playerid, "CaseIdOn"));
	ShowPlayerDialog(playerid, 35, DIALOG_STYLE_LIST, scase, "Reporter's Information\nTrace Reporter\nCall Reporter\nSolved Case", "Select", "Close");
	}
    }
    if(dialogid == 35)
    {
    if(response != 0)
    {
    new scase[40], info[160];
    switch(listitem)
    {
    case 0:
    {
    format(scase, sizeof(scase), "Reporter's Information Case ID: %d",GetPVarInt(playerid, "CaseIdOn"));
    format(info, sizeof(info), "    Reporter's Name:    %s\n\n    Reported Text:    %s",GetPlayerNameEx(GetPVarInt(playerid, "CaseReporter")), GetString(GetPVarInt(playerid, "CaseReporter"), "ReportText"));
    ShowPlayerDialog(playerid, 36, DIALOG_STYLE_MSGBOX, scase, info, "Close", "Back");
    }
    case 1:
    {
    SetPVarInt(playerid, "TraceTimer", SetTimerEx("Tracing", 2000, 1, "i", playerid));
    SendMessage(playerid, "You marker will be updated every two seconds to the victem position type /stoptrace to stop tracing.");
    }
    case 2:
    {
    if(CheckNumber(playerid, GetPVarInt(GetPVarInt(playerid, "CaseReporter"), "Number")) == 0) return SendMessage(playerid, "There's a problem in the line and we can't connect you."),format(scase, sizeof(scase), "Case ID: %d",GetPVarInt(playerid, "CaseIdOn")), ShowPlayerDialog(playerid, 35, DIALOG_STYLE_LIST, scase, "Reporter's Information\nTrace Reporter\nCall Reporter\nSolved Case", "Select", "Close");
	format(info, sizeof(info), "Officer %s is waiting for you to answer your phone as he is dealing with case: %d Which is linked to your name",GetPlayerNameEx(playerid), GetPVarInt(playerid, "CaseIdOn"));
    SendMessage(GetPVarInt(playerid, "CaseReporter"), info);
    format(info, sizeof(info), "%s, has been notified that your trying to call them, please wait for them to pick up.",GetPlayerNameEx(GetPVarInt(playerid, "CaseReporter")));
    SendMessage(playerid, info);
    }
    case 3:
    {
    SendMessage(playerid, "We have sent a request asking the victem if the case was solved.");
    SendMessage(playerid, "If the victem say's you solved there case you will gain more Exp for your rank.");

    format(scase, sizeof(scase), "Your Case ID: %d",GetPVarInt(playerid, "CaseIdOn"));
    format(info, sizeof(info), "    Officer:    %s\n\n    Want's you to confirm that he has solved the case\n\n    Can you Please click yes if this is true or no if this is false    ",GetPlayerNameEx(playerid));
    ShowPlayerDialog(GetPVarInt(playerid, "CaseReporter"), 37, DIALOG_STYLE_MSGBOX, scase, info, "Yes", "No");
    }
    }
    }
    }
    if(dialogid == 36)
    {
    if(response == 1)
    {}
    if(response == 0)
    {
    new scase[30];
    format(scase, sizeof(scase), "Case ID: %d",GetPVarInt(playerid, "CaseIdOn"));
    ShowPlayerDialog(playerid, 35, DIALOG_STYLE_LIST, scase, "Reporter's Information\nTrace Reporter\nCall Reporter\nSolved Case", "Select", "Close");
	}
    }
    if(dialogid == 37)
    {
    if(response == 1)
    {
    SendMessage(GetPVarInt(playerid, "DealingCaseId"), " Your case was confirmed that it was solved.");
    SendMessage(GetPVarInt(playerid, "DealingCaseId"), " Great Work, Your exp went up.");
    UpExp(GetPVarInt(playerid, "DealingCaseId"));
    CloseCase(GetPVarInt(playerid, "DealingCaseId")), CloseCase(playerid);

	}
	if(response == 0)
    {
    SendMessage(GetPVarInt(playerid, "DealingCaseId"), " Your case was not confirmed as solved.");
    SendMessage(GetPVarInt(playerid, "DealingCaseId"), " You can contact the victem or close the case.");
    }
	}
	if(dialogid == 38)
    {
    if(response == 1)
    {
    new number;
    if(sscanf(inputtext, "i", number)) return SendMessage(playerid, "You must enter a number only."), ShowPlayerDialog(playerid,38,DIALOG_STYLE_INPUT,"Send A Text","Please enter the number you wish to Text.","Enter","Back");
    if(CheckNumberText(playerid, number) == 0) return SendMessage(playerid, "That number is not valid."), ShowPlayerDialog(playerid,38,DIALOG_STYLE_INPUT,"Send A Text","Please enter the number you wish to Text.","Enter","Back");
    ShowPlayerDialog(playerid,39,DIALOG_STYLE_INPUT,"Send A Text","Please enter your message you wish to send","Send","Back");
    }
    if(response == 0)
    {
    if(GetPVarInt(playerid, "PickedUp") == 0)
    ShowPlayerDialog(playerid, 31, DIALOG_STYLE_LIST, "Mobile Phone", "Dial A Number\nCall Police\nCall Medic\nSend A Text\nRead Last Message", "Select", "Close");
    if(GetPVarInt(playerid, "PickedUp") != 0)
    ShowPlayerDialog(playerid, 31, DIALOG_STYLE_LIST, "Mobile Phone", "Dial A Number\nCall Police\nCall Medic\nSend A Text\nRead Last Message\nAnswer Your Phone", "Select", "Close");
    }
    }
    if(dialogid == 39)
    {
    if(response == 1)
    {
    if(strlen(inputtext) > 100) return SendMessage(playerid, "Please shorten your message."),ShowPlayerDialog(playerid,39,DIALOG_STYLE_INPUT,"Send A Text","Please enter your message you wish to send","Send","Back");
    SetPVarString(GetPVarInt(playerid, "Texting"), "TextMessage",inputtext);
	SendMessage(GetPVarInt(playerid, "Texting"), "You just received a text message type /phone and select read message to read it.");
    }
    if(response == 0)
    {
    ShowPlayerDialog(playerid,38,DIALOG_STYLE_INPUT,"Send A Text","Please enter the number you wish to Text.","Enter","Back");
    }
    }
    if(dialogid == 40)
    {
    if(response == 1)
    {
    ShowPlayerDialog(playerid,39,DIALOG_STYLE_INPUT,"Send A Text","Please enter your message you wish to send","Send","Back");
    }
    if(response == 0)
    {
    if(GetPVarInt(playerid, "PickedUp") == 0)
    ShowPlayerDialog(playerid, 31, DIALOG_STYLE_LIST, "Mobile Phone", "Dial A Number\nCall Police\nCall Medic\nSend A Text\nRead Last Message", "Select", "Close");
    if(GetPVarInt(playerid, "PickedUp") != 0)
    ShowPlayerDialog(playerid, 31, DIALOG_STYLE_LIST, "Mobile Phone", "Dial A Number\nCall Police\nCall Medic\nSend A Text\nRead Last Message\nAnswer Your Phone", "Select", "Close");
    }
    }
    if(dialogid == 41)
    {
    if(response == 1)
    {
    if(GetPVarInt(playerid, "PickedUp") == 0)
    ShowPlayerDialog(playerid, 31, DIALOG_STYLE_LIST, "Mobile Phone", "Dial A Number\nCall Police\nCall Medic\nSend A Text\nRead Last Message", "Select", "Close");
    if(GetPVarInt(playerid, "PickedUp") != 0)
    ShowPlayerDialog(playerid, 31, DIALOG_STYLE_LIST, "Mobile Phone", "Dial A Number\nCall Police\nCall Medic\nSend A Text\nRead Last Message\nAnswer Your Phone", "Select", "Close");
    }
    if(response == 0)
    {
    if(GetPVarInt(playerid, "PickedUp") == 0)
    ShowPlayerDialog(playerid, 31, DIALOG_STYLE_LIST, "Mobile Phone", "Dial A Number\nCall Police\nCall Medic\nSend A Text\nRead Last Message", "Select", "Close");
    if(GetPVarInt(playerid, "PickedUp") != 0)
    ShowPlayerDialog(playerid, 31, DIALOG_STYLE_LIST, "Mobile Phone", "Dial A Number\nCall Police\nCall Medic\nSend A Text\nRead Last Message\nAnswer Your Phone", "Select", "Close");
    }
    }
    if(dialogid == 42)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0: SetPVarInt(playerid, "CPID", 3), TogglePlayerAllDynamicCPs(playerid, 0), SetPlayerCheckpoint(playerid, BuildingInfo[9][bEntrancex], BuildingInfo[9][bEntrancey], BuildingInfo[9][bEntrancez], 2.0), SendMessage(playerid, "You have a red marker set on your map to the selected location.");
    case 1: SetPVarInt(playerid, "CPID", 3), TogglePlayerAllDynamicCPs(playerid, 0), SetPlayerCheckpoint(playerid, BuildingInfo[1][bEntrancex], BuildingInfo[1][bEntrancey], BuildingInfo[1][bEntrancez], 2.0), SendMessage(playerid, "You have a red marker set on your map to the selected location.");
    case 2: SetPVarInt(playerid, "CPID", 3), TogglePlayerAllDynamicCPs(playerid, 0), SetPlayerCheckpoint(playerid, BuildingInfo[8][bEntrancex], BuildingInfo[8][bEntrancey], BuildingInfo[8][bEntrancez], 2.0), SendMessage(playerid, "You have a red marker set on your map to the selected location.");
    case 3: SetPVarInt(playerid, "CPID", 3), TogglePlayerAllDynamicCPs(playerid, 0), SetPlayerCheckpoint(playerid, BuildingInfo[7][bEntrancex], BuildingInfo[7][bEntrancey], BuildingInfo[7][bEntrancez], 2.0), SendMessage(playerid, "You have a red marker set on your map to the selected location.");
    case 4: SetPVarInt(playerid, "CPID", 3), TogglePlayerAllDynamicCPs(playerid, 0), SetPlayerCheckpoint(playerid, BuildingInfo[6][bEntrancex], BuildingInfo[6][bEntrancey], BuildingInfo[6][bEntrancez], 2.0), SendMessage(playerid, "You have a red marker set on your map to the selected location.");
    case 5: SetPVarInt(playerid, "CPID", 3), TogglePlayerAllDynamicCPs(playerid, 0), SetPlayerCheckpoint(playerid, BuildingInfo[2][bEntrancex], BuildingInfo[2][bEntrancey], BuildingInfo[2][bEntrancez], 2.0), SendMessage(playerid, "You have a red marker set on your map to the selected location.");
    case 6: SetPVarInt(playerid, "CPID", 3), TogglePlayerAllDynamicCPs(playerid, 0), SetPlayerCheckpoint(playerid, BuildingInfo[5][bEntrancex], BuildingInfo[5][bEntrancey], BuildingInfo[5][bEntrancez], 2.0), SendMessage(playerid, "You have a red marker set on your map to the selected location.");
    case 7: SetPVarInt(playerid, "CPID", 3), TogglePlayerAllDynamicCPs(playerid, 0), SetPlayerCheckpoint(playerid, BuildingInfo[4][bEntrancex], BuildingInfo[4][bEntrancey], BuildingInfo[4][bEntrancez], 2.0), SendMessage(playerid, "You have a red marker set on your map to the selected location.");
    case 8: SetPVarInt(playerid, "CPID", 3), TogglePlayerAllDynamicCPs(playerid, 0), SetPlayerCheckpoint(playerid, BuildingInfo[11][bEntrancex], BuildingInfo[11][bEntrancey], BuildingInfo[11][bEntrancez], 2.0), SendMessage(playerid, "You have a red marker set on your map to the selected location.");
    case 9: SetPVarInt(playerid, "CPID", 3), TogglePlayerAllDynamicCPs(playerid, 0), SetPlayerCheckpoint(playerid, BuildingInfo[12][bEntrancex], BuildingInfo[12][bEntrancey], BuildingInfo[12][bEntrancez], 2.0), SendMessage(playerid, "You have a red marker set on your map to the selected location.");
    case 10: SetPVarInt(playerid, "CPID", 3), TogglePlayerAllDynamicCPs(playerid, 0), SetPlayerCheckpoint(playerid, BuildingInfo[14][bEntrancex], BuildingInfo[14][bEntrancey], BuildingInfo[14][bEntrancez], 2.0), SendMessage(playerid, "You have a red marker set on your map to the selected location.");
	}
    }
    if(response != 1) ShowPlayerDialog(playerid, 43, DIALOG_STYLE_LIST, "City Role Play Map", "Building Locations\nOther Locations", "Select", "Close");
    }
    if(dialogid == 43)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:ShowPlayerDialog(playerid, 42, DIALOG_STYLE_LIST, "City Role Play Building Locations", "Driving Test Centre\nPolice Station\nHospital\nFire Department\nCar Show Room\n24/7 Shop\nClothes Store\nGym\nAirport Building\nJob Centre\nBank", "Select", "Back");
    case 1:ShowPlayerDialog(playerid, 85, DIALOG_STYLE_LIST, "City Role Play Other Locations", "Junk Yard\nBuying Seed Location ( To Grown Weed )", "Select", "Back");

	}
	}
	}
	if(dialogid == 44)
    {
    if(response != 0)
    {
    if(injobmeeting == 1) return SendMessage(playerid, "Please wait someone is already in a meeting.");
    new string[100];
    switch(listitem)
    {
    case 0:
    {
    if(GetPVarInt(playerid, "WorkTime") > 0) return format(string, sizeof(string), "You took an occupation in the last hour you need to play another %d minutes before you can take another job", GetPVarInt(playerid, "WorkTime")), SendMessage(playerid, string);
	if(GetPVarInt(playerid, "License") == 0) return SendMessage(playerid,"You need a driving license for this job."),ShowPlayerDialog(playerid, 44, DIALOG_STYLE_LIST, "Job Centre Job Selection", "Bin Man $145 Per Pay Check\nFire Man $150 Per Pay Check\nPolice Officer $155 Per Pay Check\nSign On (Welfare) $60 Per Pay Check", "Select", "Close");
    if(GetPVarInt(playerid, "Team") == binman) return SendMessage(playerid,"You are already a Bin Man"),ShowPlayerDialog(playerid, 44, DIALOG_STYLE_LIST, "Job Centre Job Selection", "Bin Man $145 Per Pay Check\nFire Man $150 Per Pay Check\nPolice Officer $155 Per Pay Check\nSign On (Welfare) $60 Per Pay Check", "Select", "Close");
    WalkInJC(playerid);
	SetPVarInt(playerid, "WantsJob", 1);
	injobmeeting = 1;
    }
    case 1:
    {
    if(GetPVarInt(playerid, "WorkTime") > 0) return format(string, sizeof(string), "You took an occupation in the last hour you need to play another %d minutes before you can take another job", GetPVarInt(playerid, "WorkTime")), SendMessage(playerid, string);
    if(GetPVarInt(playerid, "License") == 0) return SendMessage(playerid,"You need a driving license for this job."),ShowPlayerDialog(playerid, 44, DIALOG_STYLE_LIST, "Job Centre Job Selection", "Bin Man $145 Per Pay Check\nFire Man $150 Per Pay Check\nPolice Officer $155 Per Pay Check\nSign On (Welfare) $60 Per Pay Check", "Select", "Close");
    if(GetPVarInt(playerid, "License") == 1) return SendMessage(playerid,"You need a Blue Light driving license for this job."),ShowPlayerDialog(playerid, 44, DIALOG_STYLE_LIST, "Job Centre Job Selection", "Bin Man $145 Per Pay Check\nFire Man $150 Per Pay Check\nPolice Officer $155 Per Pay Check\nSign On (Welfare) $60 Per Pay Check", "Select", "Close");
	if(GetPVarInt(playerid, "Hours") < 1 && GetPVarInt(playerid, "Minutes") < 30) return SendMessage(playerid, "You need to play at least 1 Hour's and 30 Minutes to become a fire man"), format(string, sizeof(string), "You have played %d Hours, %d Minutes and %d Seconds", GetPVarInt(playerid, "Hours"),GetPVarInt(playerid, "Minutes"), GetPVarInt(playerid, "Seconds")), SendMessage(playerid, string);
    if(GetPVarInt(playerid, "Team") == fireman) return SendMessage(playerid,"You are already a Fire Man"),ShowPlayerDialog(playerid, 44, DIALOG_STYLE_LIST, "Job Centre Job Selection", "Bin Man $145 Per Pay Check\nFire Man $150 Per Pay Check\nPolice Officer $155 Per Pay Check\nSign On (Welfare) $60 Per Pay Check", "Select", "Close");
	WalkInJC(playerid);
	SetPVarInt(playerid, "WantsJob", 2);
	injobmeeting = 1;
    }
    case 2:
    {
    if(GetPVarInt(playerid, "WorkTime") > 0) return format(string, sizeof(string), "You took an occupation in the last hour you need to play another %d minutes before you can take another job", GetPVarInt(playerid, "WorkTime")), SendMessage(playerid, string);
    if(GetPVarInt(playerid, "License") == 0) return SendMessage(playerid,"You need a driving license for this job."),ShowPlayerDialog(playerid, 44, DIALOG_STYLE_LIST, "Job Centre Job Selection", "Bin Man $145 Per Pay Check\nFire Man $150 Per Pay Check\nPolice Officer $155 Per Pay Check\nSign On (Welfare) $60 Per Pay Check", "Select", "Close");
    if(GetPVarInt(playerid, "License") == 1) return SendMessage(playerid,"You need a Blue Light driving license for this job."),ShowPlayerDialog(playerid, 44, DIALOG_STYLE_LIST, "Job Centre Job Selection", "Bin Man $145 Per Pay Check\nFire Man $150 Per Pay Check\nPolice Officer $155 Per Pay Check\nSign On (Welfare) $60 Per Pay Check", "Select", "Close");
	if(GetPVarInt(playerid, "GunLicense") < 4) return SendMessage(playerid,"You need to pass the weapon test for this job."),ShowPlayerDialog(playerid, 44, DIALOG_STYLE_LIST, "Job Centre Job Selection", "Bin Man $145 Per Pay Check\nFire Man $150 Per Pay Check\nPolice Officer $155 Per Pay Check\nSign On (Welfare) $60 Per Pay Check", "Select", "Close");
	if(GetPVarInt(playerid, "Hours") < 2 && GetPVarInt(playerid, "Minutes") < 30) return SendMessage(playerid, "You need to play at least 2 Hour's and 30 Minutes to become a police officer"), format(string, sizeof(string), "You have played %d Hours, %d Minutes and %d Seconds", GetPVarInt(playerid, "Hours"),GetPVarInt(playerid, "Minutes"), GetPVarInt(playerid, "Seconds")), SendMessage(playerid, string);
    if(GetPVarInt(playerid, "Team") == cop) return SendMessage(playerid,"You are already a Police Officer"),ShowPlayerDialog(playerid, 44, DIALOG_STYLE_LIST, "Job Centre Job Selection", "Bin Man $145 Per Pay Check\nFire Man $150 Per Pay Check\nPolice Officer $155 Per Pay Check\nSign On (Welfare) $60 Per Pay Check", "Select", "Close");
	WalkInJC(playerid);
	SetPVarInt(playerid, "WantsJob", 3);
	injobmeeting = 1;
    }
    case 3:
    {
    if(GetPVarInt(playerid, "WorkTime") > 0) return format(string, sizeof(string), "You have to wait every hour to sign on, you got %d minutes to wait.", GetPVarInt(playerid, "WorkTime")), SendMessage(playerid, string);
    WalkInJC(playerid);
	SetPVarInt(playerid, "WantsJob", 4);
	injobmeeting = 1;
    }
	}
    }
    if(response != 1)
    {
    SendMessage(playerid,"Please come back if you want a job."),injobmeeting = 0;
    }
    }
    if(dialogid == 45)
    {
    if(response == 1)
    {
    if(GetPVarInt(playerid, "WorkDone") == 30) return SetPlayerCheckpoint(playerid, 2194.6648,-2078.4456,13.8046, 4.0), SetPVarInt(playerid, "CPID", 5), SendMessage(playerid, "You have emptied 30 bin's you must go back to the skip yard and empty your truck.");
    new veh = GetPlayerVehicleID(playerid), rand;
    if(GetPVarInt(playerid, "Team") == binman)
    if(GetVehicleModel(veh) !=  408) return SendMessage(playerid, "You must be in a Trash Master Vehicle.");
    if(GetVehicleModel(veh) ==  408)
    rand = random(sizeof(Trash)),
    SetPlayerCheckpoint(playerid, Trash[rand][0], Trash[rand][1], Trash[rand][2], 1.5),
    SetPVarInt(playerid, "CPID", 0),
    TogglePlayerAllDynamicCPs(playerid, 0),// 0 = off
    SetPVarInt(playerid,"BinObject", CreateObject(1339, Trash[rand][0], Trash[rand][1], Trash[rand][2],Trash[rand][3],Trash[rand][4],Trash[rand][5])),
    SetPVarFloat(playerid,"Binx",Trash[rand][0]),
    SetPVarFloat(playerid,"Biny",Trash[rand][1]),
    SetPVarFloat(playerid,"Binz",Trash[rand][2]-0.8),
    SetPVarInt(playerid, "TrashVeh", veh);
    }
    }
    if(dialogid == 46)
    {
    if(response == 1)
    {
    if(drivingtest == 1) return SendMessage(playerid, "Please wait someone is already in a test.");
    if(GetPVarInt(playerid, "License") > 0) return SendMessage(playerid, "You already have your license.");
    StartDrivingTest(playerid);
    drivingtest = 1;
    }
    }
    if(dialogid == 47)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:
    {
    new string[80];
    format(string, sizeof(string), "You have $%d in your bank.",GetPVarInt(playerid, "Bank"));
    ShowPlayerDialog(playerid,66,DIALOG_STYLE_MSGBOX,"Bank Balance",string,"Back","Back");
    }
    case 1:
    {
    ShowPlayerDialog(playerid,48,DIALOG_STYLE_INPUT,"Withdraw Cash","Please enter the amount you wish to take out","Withdraw","Back");
    }
    case 2:
    {
    ShowPlayerDialog(playerid,49,DIALOG_STYLE_INPUT,"Deposit Cash","Please enter the amount you wish to deposit","Deposit","Back");
    }
    case 3:
    {
    new amount, string[80];
    if(GetPVarInt(playerid, "Checks") == 0) return SendMessage(playerid, "You don't have any pay checks to cash."),ShowPlayerDialog(playerid, 47, DIALOG_STYLE_LIST, "Banking Options", "Withdraw Cash\nDeposit Cash\nCash Pay Checks", "Select", "Close");
    if(GetPVarInt(playerid, "Team") == fireman) amount = 150;
    if(GetPVarInt(playerid, "Team") == cop) amount = 155;
    if(GetPVarInt(playerid, "Team") == med) amount = 145;
    if(GetPVarInt(playerid, "Team") == civ) amount = 60;
    if(GetPVarInt(playerid, "Team") == binman) amount = 145;
    amount = amount*GetPVarInt(playerid, "Checks");
    format(string, sizeof(string), "You cashed %d pay check and got $%d", GetPVarInt(playerid, "Checks"),amount);
    if(GetPVarInt(playerid, "Checks") > 1) format(string, sizeof(string), "You cashed %d pay check's and got $%d", GetPVarInt(playerid, "Checks"),amount);
    SendMessage(playerid, string);
    SetPVarInt(playerid, "Checks", 0);
    GivePlayerCash(playerid, amount);
	}
    }
    }
    if(response != 1)
    {
    if(GetPVarInt(playerid, "ATMS") == 1) SetPVarInt(playerid, "ATMS", 0);
    }
    }
    if(dialogid == 48)
    {
    if(response == 1)
    {
    new cash, string[80];
    if(sscanf(inputtext, "i", cash)) return SendMessage(playerid, "You must enter numbers only."), ErrorBank(playerid);
    if(cash > GetPVarInt(playerid, "Bank")) return SendMessage(playerid, "Sorry but your trying to withdraw more then you have."), ErrorBank(playerid);
    if(cash <= 0) return SendMessage(playerid, "Sorry but your trying to withdraw less then $1.");
	GivePlayerCash(playerid, cash);
	SetPVarInt(playerid, "Bank", GetPVarInt(playerid, "Bank") -cash);
	format(string, sizeof(string), "You withdrew $%d from your bank account.", cash);
	SendMessage(playerid, string);
	}
    if(response == 0)
    {
    ErrorBank(playerid);
	}
    }
    if(dialogid == 49)
    {
    if(response == 1)
    {
    new cash, string[80];
    if(sscanf(inputtext, "i", cash)) return SendMessage(playerid, "You must enter numbers only."), ErrorBank(playerid);
    if(cash > GetPVarInt(playerid, "Cash")) return SendMessage(playerid, "Sorry but your trying to deposit more then you have."), ErrorBank(playerid);
    if(cash <= 0) return SendMessage(playerid, "Sorry but your trying to deposit less then $1.");
	GivePlayerCash(playerid, -cash);
	SetPVarInt(playerid, "Bank", GetPVarInt(playerid, "Bank") +cash);
	format(string, sizeof(string), "You deposited $%d into your bank account.", cash);
	SendMessage(playerid, string);
	}
    if(response == 0)
    {
    ErrorBank(playerid);
	}
    }
    if(dialogid == 50)
    {
    if(response == 1)
    {
    new code, string[20];
    if(sscanf(inputtext, "i", code)) return SendMessage(playerid, "You must enter numbers only."), ShowPlayerDialog(playerid,50,DIALOG_STYLE_INPUT,"Open A Bank Account","Please enter a 4 digit code","Create","Close");
    if(strlen(inputtext) != 4) return SendMessage(playerid, "Your bank code must be 4 digits."), ShowPlayerDialog(playerid,50,DIALOG_STYLE_INPUT,"Open A Bank Account","Please enter a 4 digit code","Create","Close");
    format(string, sizeof(string), "Your Code: %d",code);
    SendMessage(playerid, "Please don't forget your bank code, if you do you can reset it with your control panel /cpanel.");
    SendMessage(playerid, string);
    SetPVarInt(playerid, "BankCode", code);
    OnUpdatePlayer(playerid);
    }
    }
    if(dialogid == 51)
    {
    if(response == 1)
    {
    if(!strlen(inputtext))
	{
	SendMessage(playerid, "Enter your password");
	ShowPlayerDialog(playerid,51,DIALOG_STYLE_INPUT,"Change Bank Code","Please enter your current password to continue.","Enter","Back");
	return 1;
	}
    if(strcmp(GetString(playerid, "Password"), inputtext, true)== 0)
	{
	ShowPlayerDialog(playerid,50,DIALOG_STYLE_INPUT,"Change Bank Code","Please enter a 4 digit code","Change","Close");
	}
	else
	{
	ShowPlayerDialog(playerid,51,DIALOG_STYLE_INPUT,"Change Bank Code","ERROR: Password Wrong!\n\nPlease enter your current password to continue.","Enter","Back");
	}
	}// response
	if(response == 0)
    {
    ShowPlayerDialog(playerid, 13, DIALOG_STYLE_LIST, "Account Details", "Change My PassWord\nReset My Players Account\nChange Bank Code", "Select", "Back");
    }
	}// close dialog 51
	if(dialogid == 52)
    {
    if(response == 1)
    {
    new code;
    if(sscanf(inputtext, "i", code)) return SendMessage(playerid, "You must enter numbers only."), ShowPlayerDialog(playerid,52,DIALOG_STYLE_INPUT,"Confirm Your Bank Code","Please enter your 4 digit bank code","Enter","Close");
	if(code == GetPVarInt(playerid, "BankCode"))
	{
	ErrorBank(playerid);
	}
	else
	{
	ShowPlayerDialog(playerid,52,DIALOG_STYLE_INPUT,"Confirm Your Bank Code","ERROR: Bank code incorrect\n\nPlease enter your 4 digit bank code","Enter","Close");
    }
    }
    if(response == 0)
    {
	if(GetPVarInt(playerid, "ATMS") == 1) SetPVarInt(playerid, "ATMS", 0);
    }
    }
    if(dialogid == 53)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:
    {
    new Float:x,Float:y,Float:z, Float:a;
    GetPlayerPos(playerid, x,y,z);
    GetXYInFrontOfPlayer(playerid, x, y, 1);
    GetPlayerFacingAngle(playerid, a);
    SetPlayerPos(GetPVarInt(playerid, "Holding"), x,y,z);
    SetPlayerFacingAngle(GetPVarInt(playerid, "Holding"), a);
    ApplyAnimation(GetPVarInt(playerid, "Holding"),"PED","handsup",2.1,0,0,0,0,0);
    ApplyAnimation(playerid,"POLICE","plc_drgbst_02",2.1,0,0,0,0,0);
    SetTimerEx("SearchResult", 6000, 0, "i", playerid);
    }
    case 1:ShowPlayerDialog(playerid, 54, DIALOG_STYLE_LIST, "Remove A License", "Driving License\nPlane/Helicopter License\nWeapon License", "Select", "Back");
	case 2:ShowPlayerDialog(playerid,80,DIALOG_STYLE_INPUT,"Arrest Reason","Please enter the reason why they were arrested","Enter","Close");
	}
    }
	}
	if(dialogid == 54)
    {
    if(response != 0)
    {
    new string[60];
    switch(listitem)
    {
    case 0:
    {
    if(GetPVarInt(GetPVarInt(playerid, "Holding"), "License") == 0) return SendMessage(playerid, "System Error: This person does not have a driving license.");
    SetPVarInt(GetPVarInt(playerid, "Holding"), "License", 0);
    format(string, sizeof(string), "Your driving license was removed by officer %s.", GetPlayerNameEx(playerid));
	SendMessage(GetPVarInt(playerid, "Holding"), string);
    }
    case 1:
    {
    if(GetPVarInt(GetPVarInt(playerid, "Holding"), "FlyLicense") == 0) return SendMessage(playerid, "System Error: This person does not have a flying license.");
    SetPVarInt(GetPVarInt(playerid, "Holding"), "FlyLicense", 0);
    format(string, sizeof(string), "Your flying license was removed by officer %s.", GetPlayerNameEx(playerid));
	SendMessage(GetPVarInt(playerid, "Holding"), string);
    }
    case 2:
    {
    if(GetPVarInt(GetPVarInt(playerid, "Holding"), "GunLicense") == 0) return SendMessage(playerid, "System Error: This person does not have a weapon license.");
    SetPVarInt(GetPVarInt(playerid, "Holding"), "GunLicense", 0);
    format(string, sizeof(string), "Your weapon license was removed by officer %s.", GetPlayerNameEx(playerid));
	SendMessage(GetPVarInt(playerid, "Holding"), string);
    }
    }
    }
    if(response != 0)
    {
    ShowPlayerDialog(playerid, 53, DIALOG_STYLE_LIST, "Jail Process", "Search Suspect\nRemove a License\nArrest Suspect", "Select", "Close");
    }
    }
    if(dialogid == 55)
    {
    if(response == 1)
    {
    new id, string[80];
    if(sscanf(inputtext, "i", id)) return SendMessage(playerid, "Please enter there ID number only."),ShowPlayerDialog(playerid,55,DIALOG_STYLE_INPUT,"Gang Invite","Please enter the ID of the player you wish to ask to join your gang","Enter","Back");
	if(!IsPlayerConnected(id)) return SendMessage(playerid, "That player is not online."),ShowPlayerDialog(playerid,55,DIALOG_STYLE_INPUT,"Gang Invite","Please enter the ID of the player you wish to ask to join your gang","Enter","Back");
    if(CheckGangOwn(GetPlayerNameEx(id)) != 0) return SendMessage(playerid, "That person own's there own gang."),ShowPlayerDialog(playerid,55,DIALOG_STYLE_INPUT,"Gang Invite","Please enter the ID of the player you wish to ask to join your gang","Enter","Back");
	format(string, sizeof(string), "You invited %s to join your gang.",GetPlayerNameEx(id));
	SendMessage(playerid, string);
	format(string, sizeof(string), "%s want's you to join the %s Gang Type /join to accept.",GetPlayerNameEx(playerid), GangInfo[GetPVarInt(playerid, "GangId")][gName]);
	SendMessage(id, string);
	SetPVarInt(id, "Asking", playerid);
	}
    if(response == 0)
    {
    ShowPlayerDialog(playerid, 24, DIALOG_STYLE_LIST, "My Gang Information", "Gang Gun's\nGang information\nInvite Players\nDelete Gang", "Select", "Go Back");
    }
    }
   	if(dialogid == 56)
    {
    if(response != 0)
    {
    if(inguntest == 1) return SendMessage(playerid, "Someone is training please wait...");
    switch(listitem)
    {
    case 0:
    {
    if(GetPVarInt(playerid, "GunLicense") > 0) return SendMessage(playerid, "You have already done the pistol test.");
    CDPart(playerid);
	GivePlayerWeapon(playerid, 22, 9999);
	ClearChatbox(playerid, 10);
	GameTextForPlayer(playerid, "~W~Shoot 20 targets before your time is over", 5000, 1);
	SetPVarInt(playerid, "ShootingTime", 40);
	SetPVarInt(playerid, "Target", 20);
    }
    case 1:
    {
    if(GetPVarInt(playerid, "GunLicense") < 1) return SendMessage(playerid, "You must do the pistol test first.");
    if(GetPVarInt(playerid, "GunLicense") > 1) return SendMessage(playerid, "You have already done the shotgun test.");
    CDPart(playerid);
	GivePlayerWeapon(playerid, 25, 9999);
	ClearChatbox(playerid, 10);
	GameTextForPlayer(playerid, "~W~Shoot 15 targets before your time is over", 5000, 1);
	SetPVarInt(playerid, "ShootingTime", 40);
	SetPVarInt(playerid, "Target", 15);
    }
    case 2:
    {
    if(GetPVarInt(playerid, "GunLicense") < 2) return SendMessage(playerid, "You must do the shotgun test first.");
    if(GetPVarInt(playerid, "GunLicense") > 2) return SendMessage(playerid, "You have already done the Uzi test.");
    CDPart(playerid);
	GivePlayerWeapon(playerid, 28, 9999);
	ClearChatbox(playerid, 10);
	GameTextForPlayer(playerid, "~W~Shoot 25 targets before your time is over", 5000, 1);
	SetPVarInt(playerid, "ShootingTime", 45);
	SetPVarInt(playerid, "Target", 25);
    }
    case 3:
    {
    if(GetPVarInt(playerid, "GunLicense") < 3) return SendMessage(playerid, "You must do the uzi test first.");
    if(GetPVarInt(playerid, "GunLicense") > 3) return SendMessage(playerid, "You have already done the ak47 test.");
    CDPart(playerid);
	GivePlayerWeapon(playerid, 30, 9999);
	ClearChatbox(playerid, 10);
	GameTextForPlayer(playerid, "~W~Shoot 25 targets before your time is over", 5000, 1);
	SetPVarInt(playerid, "ShootingTime", 45);
	SetPVarInt(playerid, "Target", 25);
    }
    case 4:
    {
    if(GetPVarInt(playerid, "GunLicense") < 4) return SendMessage(playerid, "You must do the ak47 test first.");
    if(GetPVarInt(playerid, "GunLicense") > 4) return SendMessage(playerid, "You have already done the rifle test.");
    CDPart(playerid);
	GivePlayerWeapon(playerid, 33, 9999);
	ClearChatbox(playerid, 10);
	GameTextForPlayer(playerid, "~W~Shoot 15 targets before your time is over", 5000, 1);
	SetPVarInt(playerid, "ShootingTime", 45);
	SetPVarInt(playerid, "Target", 15);
    }
    }
    }
    }
    if(dialogid == 57)
    {
    if(response == 1)
    {
    new name, nameformat = strfind(inputtext, "_", true);
    if(sscanf(inputtext, "s", name)) return ShowPlayerDialog(playerid,57,DIALOG_STYLE_INPUT,"Account Name Selection","ERROR: User name must start with a letter.\n\nPlease enter the name you wish to play with","Enter","Quit");
	if(CheckName(inputtext) != 0) return ShowPlayerDialog(playerid,57,DIALOG_STYLE_INPUT,"Account Name Selection","ERROR: That user name is in use.\n\nPlease enter the name you wish to play with","Enter","Quit");
	if(nameformat == -1 && CheckNameAllow(playerid, inputtext)) return ShowPlayerDialog(playerid,57,DIALOG_STYLE_INPUT,"Account Name Selection","ERROR: Name format should be like 'First_Last'.\n\nPlease enter the name you wish to play with","Enter","Quit");
    if(InvalidSymbol(playerid, inputtext) == 1) return ShowPlayerDialog(playerid,57,DIALOG_STYLE_INPUT,"Account Name Selection","ERROR: Name's Can't have Symbols.\n\nPlease enter the name you wish to play with","Enter","Quit");
	SetPlayerName(playerid, inputtext);
    IfRegisterd(playerid);
	}
	if(response == 0)
    {
    SendMessage(playerid, "You asked to leave the game, Goodbye.");
	Kick(playerid);
	}
    }
    if(dialogid == 58)
    {
    if(response == 1)
    {
    new id = GetPVarInt(playerid, "BuyingBuilding"), tmp[90];
    if(GetPlayerCash(playerid) < BuildingInfo[id][bBuyPrice]) return format(tmp, sizeof(tmp), "You only have $%d, you need another $%d to buy this building.", GetPlayerCash(playerid), BuildingInfo[id][bBuyPrice] - GetPlayerCash(playerid)), SendMessage(playerid, tmp);
	if(BuildingInfo[id][bOwned] != 0) return SendMessage(playerid, "This building is already owned.");
	strmid(BuildingInfo[id][bOwner], GetPlayerNameSave(playerid), 0, strlen(GetPlayerNameSave(playerid)), 40);
	BuildingInfo[id][bOwned] = 1;
	BuildingInfo[id][bOwnerId] = GetPVarInt(playerid, "SQLID");
	UpdateBuilding(id);
	GivePlayerCash(playerid, - BuildingInfo[id][bBuyPrice]);
	format(tmp, sizeof(tmp), "Congratulations, you bought the %s for $%d",BuildingInfo[id][bDescription], BuildingInfo[id][bBuyPrice]);
	SendMessage(playerid, tmp);
	OnUpdatePlayer(playerid);
	}
    }
    if(dialogid == 59)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0: CheckHouse(playerid);
    case 1: CheckBuilding(playerid);
    case 2: RentAppartment(playerid);
    case 3: RentBuilding(playerid);
    }
    }
    if(response != 1)
    {
    ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "User Control Panel", "Account Details\nGame Rules\nGame Commands\nMy Stats\nHelp Centre\nReport Someone\nVehicle's\nGang's Information\nProperties", "Select", "Close");
	}
    }
    if(dialogid == 60)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:ShowPlayerDialog(playerid, 61, DIALOG_STYLE_LIST, "Building Control", "Sell Building\nLock Building\nBuy Share Slots\nCollect Building Shares Profit", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "Building1"));
    case 1:ShowPlayerDialog(playerid, 61, DIALOG_STYLE_LIST, "Building Control", "Sell Building\nLock Building\nBuy Share Slots\nCollect Building Shares Profit", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "Building2"));
    case 2:ShowPlayerDialog(playerid, 61, DIALOG_STYLE_LIST, "Building Control", "Sell Building\nLock Building\nBuy Share Slots\nCollect Building Shares Profit", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "Building3"));
    case 3:ShowPlayerDialog(playerid, 61, DIALOG_STYLE_LIST, "Building Control", "Sell Building\nLock Building\nBuy Share Slots\nCollect Building Shares Profit", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "Building4"));
    case 4:ShowPlayerDialog(playerid, 61, DIALOG_STYLE_LIST, "Building Control", "Sell Building\nLock Building\nBuy Share Slots\nCollect Building Shares Profit", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "Building5"));
    case 5:ShowPlayerDialog(playerid, 61, DIALOG_STYLE_LIST, "Building Control", "Sell Building\nLock Building\nBuy Share Slots\nCollect Building Shares Profit", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "Building6"));
    case 6:ShowPlayerDialog(playerid, 61, DIALOG_STYLE_LIST, "Building Control", "Sell Building\nLock Building\nBuy Share Slots\nCollect Building Shares Profit", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "Building7"));
    case 7:ShowPlayerDialog(playerid, 61, DIALOG_STYLE_LIST, "Building Control", "Sell Building\nLock Building\nBuy Share Slots\nCollect Building Shares Profit", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "Building8"));
    case 8:ShowPlayerDialog(playerid, 61, DIALOG_STYLE_LIST, "Building Control", "Sell Building\nLock Building\nBuy Share Slots\nCollect Building Shares Profit", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "Building9"));
    case 9:ShowPlayerDialog(playerid, 61, DIALOG_STYLE_LIST, "Building Control", "Sell Building\nLock Building\nBuy Share Slots\nCollect Building Shares Profit", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "Building10"));
    case 10:ShowPlayerDialog(playerid, 61, DIALOG_STYLE_LIST, "Building Control", "Sell Building\nLock Building\nBuy Share Slots\nCollect Building Shares Profit", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "Building11"));
    case 11:ShowPlayerDialog(playerid, 61, DIALOG_STYLE_LIST, "Building Control", "Sell Building\nLock Building\nBuy Share Slots\nCollect Building Shares Profit", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "Building12"));
    case 12:ShowPlayerDialog(playerid, 61, DIALOG_STYLE_LIST, "Building Control", "Sell Building\nLock Building\nBuy Share Slots\nCollect Building Shares Profit", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "Building13"));
    case 13:ShowPlayerDialog(playerid, 61, DIALOG_STYLE_LIST, "Building Control", "Sell Building\nLock Building\nBuy Share Slots\nCollect Building Shares Profit", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "Building14"));
    }
    }
    if(response != 1)
    {
    ShowPlayerDialog(playerid, 59, DIALOG_STYLE_LIST, "Properties Information", "House's\nBuilding's\nRenting Appartment\nBuilding Share's", "Select", "Back");
    }
    }
    if(dialogid == 61)
    {
    new string[90], id = GetPVarInt(playerid, "OnBuilding");
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:
    {
    strmid(BuildingInfo[id][bOwner], "No-One", 0, 8, 40);
	BuildingInfo[id][bOwned] = 0;
	BuildingInfo[id][bOwnerId] = 0;
	UpdateBuilding(id);
	GivePlayerCash(playerid, BuildingInfo[id][bBuyPrice]);
    format(string, sizeof(string), "You sold the %s for $%d", BuildingInfo[id][bDescription], BuildingInfo[id][bBuyPrice]);
    SendMessage(playerid, string);
    CheckBuilding(playerid);
    OnUpdatePlayer(playerid);
    }
    case 1:
    {
    if(BuildingInfo[id][bLocked] == 0)
    BuildingInfo[id][bLocked] = 1,
	UpdateBuilding(id),
    format(string, sizeof(string), "You locked the %s", BuildingInfo[id][bDescription]),
    SendMessage(playerid, string), CheckBuilding(playerid);
    else if(BuildingInfo[id][bLocked] == 1)
    BuildingInfo[id][bLocked] = 0,
	UpdateBuilding(id),
    format(string, sizeof(string), "You unlocked the %s", BuildingInfo[id][bDescription]),
    SendMessage(playerid, string), CheckBuilding(playerid);
    }
    case 2:
    {
    format(string, sizeof(string), "It cost $%d for 1 extra share slot, Please enter the amount of share's you want.",BuildingInfo[id][bBuyPrice]/15);
    ShowPlayerDialog(playerid,70,DIALOG_STYLE_INPUT,"Buy Building Share's Slot's",string,"Buy","Back");
    }
    case 3:
    {
    if(BuildingInfo[id][bFunds] == 0) return SendMessage(playerid, "You building funds are empty.");
    format(string, sizeof(string), "You received $%d from your Building %s (This is money from your Building's share's profit)",BuildingInfo[id][bFunds],BuildingInfo[id][bDescription]);
    SendMessage(playerid, string);
    GivePlayerCash(playerid, BuildingInfo[id][bFunds]);
    BuildingInfo[id][bFunds] = 0;
    UpdateBuilding(id);
    }
    }
    }
    if(response != 1)
    {
    CheckBuilding(playerid);
    }
    }
    if(dialogid == 62)
    {
    if(response == 1)
    {
    new id = GetPVarInt(playerid, "BuyingBuilding"), tmp[90];
    if(GetPlayerCash(playerid) < HouseInfo[id][hBuyPrice]) return format(tmp, sizeof(tmp), "You only have $%d, you need another $%d to buy this house.", GetPlayerCash(playerid), HouseInfo[id][hBuyPrice] - GetPlayerCash(playerid)), SendMessage(playerid, tmp);
	if(HouseInfo[id][hOwned] != 0) return SendMessage(playerid, "This house is already owned.");
	strmid(HouseInfo[id][hOwner], GetPlayerNameSave(playerid), 0, strlen(GetPlayerNameSave(playerid)), 40);
	HouseInfo[id][hOwned] = 1;
	HouseInfo[id][hOwnerId] = GetPVarInt(playerid, "SQLID");
	UpdateHouse(id);
	format(tmp, sizeof(tmp), "Congratulations, you bought %s for $%d",HouseInfo[id][hDescription], HouseInfo[id][hBuyPrice]);
	SendMessage(playerid, tmp);
	GivePlayerCash(playerid, - HouseInfo[id][hBuyPrice]);
	OnUpdatePlayer(playerid);
	}
    }
    if(dialogid == 63)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:ShowPlayerDialog(playerid, 64, DIALOG_STYLE_LIST, "House Control", "Sell House\nLock House\nBuy More Rooms\nCollect Rent Profit\nChange Rentable Status\nGet Marker To House", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "House1"));
    case 1:ShowPlayerDialog(playerid, 64, DIALOG_STYLE_LIST, "House Control", "Sell House\nLock House\nBuy More Rooms\nCollect Rent Profit\nChange Rentable Status\nGet Marker To House", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "House2"));
    case 2:ShowPlayerDialog(playerid, 64, DIALOG_STYLE_LIST, "House Control", "Sell House\nLock House\nBuy More Rooms\nCollect Rent Profit\nChange Rentable Status\nGet Marker To House", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "House3"));
    case 3:ShowPlayerDialog(playerid, 64, DIALOG_STYLE_LIST, "House Control", "Sell House\nLock House\nBuy More Rooms\nCollect Rent Profit\nChange Rentable Status\nGet Marker To House", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "House4"));
    case 4:ShowPlayerDialog(playerid, 64, DIALOG_STYLE_LIST, "House Control", "Sell House\nLock House\nBuy More Rooms\nCollect Rent Profit\nChange Rentable Status\nGet Marker To House", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "House5"));
    case 5:ShowPlayerDialog(playerid, 64, DIALOG_STYLE_LIST, "House Control", "Sell House\nLock House\nBuy More Rooms\nCollect Rent Profit\nChange Rentable Status\nGet Marker To House", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "House6"));
    case 6:ShowPlayerDialog(playerid, 64, DIALOG_STYLE_LIST, "House Control", "Sell House\nLock House\nBuy More Rooms\nCollect Rent Profit\nChange Rentable Status\nGet Marker To House", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "House7"));
    case 7:ShowPlayerDialog(playerid, 64, DIALOG_STYLE_LIST, "House Control", "Sell House\nLock House\nBuy More Rooms\nCollect Rent Profit\nChange Rentable Status\nGet Marker To House", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "House8"));
    case 8:ShowPlayerDialog(playerid, 64, DIALOG_STYLE_LIST, "House Control", "Sell House\nLock House\nBuy More Rooms\nCollect Rent Profit\nChange Rentable Status\nGet Marker To House", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "House9"));
    case 9:ShowPlayerDialog(playerid, 64, DIALOG_STYLE_LIST, "House Control", "Sell House\nLock House\nBuy More Rooms\nCollect Rent Profit\nChange Rentable Status\nGet Marker To House", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "House10"));
    case 10:ShowPlayerDialog(playerid, 64, DIALOG_STYLE_LIST, "House Control", "Sell House\nLock House\nBuy More Rooms\nCollect Rent Profit\nChange Rentable Status\nGet Marker To House", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "House11"));
    case 11:ShowPlayerDialog(playerid, 64, DIALOG_STYLE_LIST, "House Control", "Sell House\nLock House\nBuy More Rooms\nCollect Rent Profit\nChange Rentable Status\nGet Marker To House", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "House12"));
    case 12:ShowPlayerDialog(playerid, 64, DIALOG_STYLE_LIST, "House Control", "Sell House\nLock House\nBuy More Rooms\nCollect Rent Profit\nChange Rentable Status\nGet Marker To House", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "House13"));
    case 13:ShowPlayerDialog(playerid, 64, DIALOG_STYLE_LIST, "House Control", "Sell House\nLock House\nBuy More Rooms\nCollect Rent Profit\nChange Rentable Status\nGet Marker To House", "Select", "Back"), SetPVarInt(playerid, "OnBuilding", GetPVarInt(playerid, "House14"));
    }
    }
    if(response != 1)
    {
    ShowPlayerDialog(playerid, 59, DIALOG_STYLE_LIST, "Properties Information", "House's\nBuilding's\nRenting Appartment\nBuilding Share's", "Select", "Back");
    }
    }
    if(dialogid == 64)
    {
    new string[100], id = GetPVarInt(playerid, "OnBuilding");
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:
    {
    strmid(HouseInfo[id][hOwner], "No-One", 0, 8, 40);
	HouseInfo[id][hOwned] = 0;
	HouseInfo[id][hOwnerId] = 0;
	UpdateHouse(id);
	GivePlayerCash(playerid, HouseInfo[id][hBuyPrice]);
    format(string, sizeof(string), "You sold %s for $%d", HouseInfo[id][hDescription], HouseInfo[id][hBuyPrice]);
    SendMessage(playerid, string);
    CheckBuilding(playerid);
    CheckHouse(playerid);
    }
    case 1:
    {
    if(HouseInfo[id][hLocked] == 0)
    HouseInfo[id][hLocked] = 1,
	UpdateHouse(id),
    format(string, sizeof(string), "You locked %s", HouseInfo[id][hDescription]),
    SendMessage(playerid, string), CheckHouse(playerid);
    else if(HouseInfo[id][hLocked] == 1)
    HouseInfo[id][hLocked] = 0,
	UpdateHouse(id),
    format(string, sizeof(string), "You unlocked %s", HouseInfo[id][hDescription]),
    SendMessage(playerid, string), CheckHouse(playerid);
    }
    case 2:
    {
    format(string, sizeof(string), "It cost $%d for 1 extra room, Please enter the amount of room's you want.",HouseInfo[id][hBuyPrice]/15);
    ShowPlayerDialog(playerid,71,DIALOG_STYLE_INPUT,"Buy House Room's",string,"Buy","Back");
    }
    case 3:
    {
    if(HouseInfo[id][hFunds] == 0) return SendMessage(playerid, "Your house funds are empty.");
    format(string, sizeof(string), "You received $%d from your house %s (This is money from your house's rent)",HouseInfo[id][hFunds],HouseInfo[id][hDescription]);
    SendMessage(playerid, string);
    GivePlayerCash(playerid, HouseInfo[id][hFunds]);
    HouseInfo[id][hFunds] = 0;
    UpdateHouse(id);
    }
    case 4:
    {
    if(HouseInfo[id][hRentable] == 0) return HouseInfo[id][hRentable] = 1, format(string, sizeof(string), "You set your house %s to not be available for renting.",HouseInfo[id][hDescription]), SendMessage(playerid, string);
    if(HouseInfo[id][hRentable] == 1) return HouseInfo[id][hRentable] = 0, format(string, sizeof(string), "You set your house %s to be available for renting.",HouseInfo[id][hDescription]), SendMessage(playerid, string);
	}
	case 5: SetPVarInt(playerid, "CPID", 3), TogglePlayerAllDynamicCPs(playerid, 0), SetPlayerCheckpoint(playerid, HouseInfo[id][hEntrancex], HouseInfo[id][hEntrancey], HouseInfo[id][hEntrancez], 2.0), SendMessage(playerid, "You have a red marker set on your map to the selected location.");
    }
    }
    if(response != 1)
    {
    CheckHouse(playerid);
	}
    }
    if(dialogid == 65)
    {
    if(response != 0 || response != 1)
    {
    ShowPlayerDialog(playerid, 59, DIALOG_STYLE_LIST, "Properties Information", "House's\nBuilding's\nRenting Appartment\nBuilding Share's", "Select", "Back");
    }
    }
    if(dialogid == 66)
    {
    if(response != 0 || response != 1)
    {
    ErrorBank(playerid);
    }
    }
    if(dialogid == 67)
    {
    if(response == 1)
    {
    new string[128], id = GetPVarInt(playerid, "WantToRent");
    if(MyHouse(playerid, id)) return SendMessage(playerid, "You can't rent your own house.");
    SetPVarInt(playerid, "RentId", id);
    format(string, sizeof(string), "You now rent a room at %s, You will have to pay $%d for every 1 hour you live here.",HouseInfo[id][hDescription], HouseInfo[id][hRent]);
    SendMessage(playerid, string);
    OnUpdatePlayer(playerid);
    HouseInfo[id][hRenters] ++;
	UpdateHouse(id);
	SetPVarInt(playerid, "WantToRent", 0);
	}
    }
    if(dialogid == 68)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:ShowPlayerDialog(playerid, 69, DIALOG_STYLE_LIST, "Rent Information Options", "Un-Rent Appartment\nGet Directions", "Select", "Back");
    }
    }
    if(response != 1)
    {
    ShowPlayerDialog(playerid, 59, DIALOG_STYLE_LIST, "Properties Information", "House's\nBuilding's\nRenting Appartment\nBuilding Share's", "Select", "Back");
    }
    }
    if(dialogid == 69)
    {
    new id = GetPVarInt(playerid, "RentId"), string[90];
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:
    {
    format(string, sizeof(string), "You are no longer renting %s.",HouseInfo[id][hDescription]);
    SendMessage(playerid, string);
    SetPVarInt(playerid, "RentId", 0);
    OnUpdatePlayer(playerid);
    HouseInfo[id][hRenters] --;
    UpdateHouse(id);
    }
    case 1:SetPVarInt(playerid, "CPID", 3), TogglePlayerAllDynamicCPs(playerid, 0), SetPlayerCheckpoint(playerid, HouseInfo[id][hEntrancex], HouseInfo[id][hEntrancey], HouseInfo[id][hEntrancez], 2.0), SendMessage(playerid, "You have a red marker set on your map to the selected location.");
    }
    }
    if(response != 1)
    {
    RentAppartment(playerid);
    }
    }
    if(dialogid == 70)
    {
    if(response == 1)
    {
    new amount, string[100], price, id = GetPVarInt(playerid, "OnBuilding");
    if(sscanf(inputtext, "i", amount)) return SendMessage(playerid, "Please enter number's only"), CheckBuilding(playerid);
    if(amount > 100) return SendMessage(playerid, "you can't buy more then 100 share slots at a time."), CheckBuilding(playerid);
    price = BuildingInfo[id][bBuyPrice]/15 * amount;
    if(GetPlayerCash(playerid) < price) return format(string, sizeof(string), "You only have $%d, you need another $%d for %d share slots",GetPlayerCash(playerid), price - GetPlayerCash(playerid), amount), SendMessage(playerid, string);
	GivePlayerCash(playerid, - price);
	BuildingInfo[id][bShares] += amount;
	BuildingInfo[id][bBuyPrice] += price;
	format(string, sizeof(string), "You bought %d share slots for $%d, your building value went up $%d it's now worth $%d",amount,price,price,BuildingInfo[id][bBuyPrice]);
	SendMessage(playerid, string);
	format(string, sizeof(string), "Your building %s now has a max of %d share slots",BuildingInfo[id][bDescription], BuildingInfo[id][bShares]);
	SendMessage(playerid, string);
	UpdateBuilding(id);
	OnUpdatePlayer(playerid);
	}
    if(response == 0)
    {
    CheckBuilding(playerid);
    }
    }
    if(dialogid == 71)
    {
    if(response == 1)
    {
    new amount, string[100], price, id = GetPVarInt(playerid, "OnBuilding");
    if(sscanf(inputtext, "i", amount)) return SendMessage(playerid, "Please enter number's only"), CheckHouse(playerid);
    if(amount > 100) return SendMessage(playerid, "you can't buy more then 100 room's at a time."), CheckHouse(playerid);
    price = HouseInfo[id][hBuyPrice]/15 * amount;
    if(GetPlayerCash(playerid) < price) return format(string, sizeof(string), "You only have $%d, you need another $%d for %d extra rooms",GetPlayerCash(playerid), price - GetPlayerCash(playerid), amount), SendMessage(playerid, string);
	GivePlayerCash(playerid, - price);
	HouseInfo[id][hRooms] += amount;
	HouseInfo[id][hBuyPrice] += price;
	format(string, sizeof(string), "You bought %d room's for $%d, your house value went up $%d it's now worth $%d",amount,price,price,HouseInfo[id][hBuyPrice]);
	SendMessage(playerid, string);
	format(string, sizeof(string), "Your house %s now has a max of %d rooms",HouseInfo[id][hDescription], HouseInfo[id][hRooms]);
	SendMessage(playerid, string);
	UpdateHouse(id);
	OnUpdatePlayer(playerid);
	}
    if(response == 0)
    {
    CheckHouse(playerid);
    }
    }
    if(dialogid == 72)
    {
    if(response == 1)
    {
    new string[158], id = GetPVarInt(playerid, "WantToRent");
	if(GetPlayerCash(playerid) < BuildingInfo[id][bBuyPrice]/BuildingInfo[id][bShares]/2) return SendMessage(playerid, "Not enough money.");
    if(MyBusiness(playerid, id)) return SendMessage(playerid, "You can't rent your own building.");
    SetPVarInt(playerid, "ShareId", id);
    format(string, sizeof(string), "You now own share's at %s, You will earn $%d for every 1 hour you own share's here.",BuildingInfo[id][bDescription], BuildingInfo[id][bBuyPrice]/BuildingInfo[id][bShares]/4);
    SendMessage(playerid, string);
    GivePlayerCash(playerid, - BuildingInfo[id][bBuyPrice]/BuildingInfo[id][bShares]/2);
    OnUpdatePlayer(playerid);
    BuildingInfo[id][bRenters] ++;
	UpdateBuilding(id);
	SetPVarInt(playerid, "WantToRent", 0);
	}
    }
    if(dialogid == 73)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:ShowPlayerDialog(playerid, 74, DIALOG_STYLE_LIST, "Share's Information Options", "Sell Shares\nGet Directions", "Select", "Back");
    }
    }
    if(response != 1)
    {
    ShowPlayerDialog(playerid, 59, DIALOG_STYLE_LIST, "Properties Information", "House's\nBuilding's\nRenting Appartment\nBuilding Share's", "Select", "Back");
    }
    }
    if(dialogid == 74)
    {
    new id = GetPVarInt(playerid, "ShareId"), string[90];
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:
    {
    format(string, sizeof(string), "You no longer have share's in %s.",BuildingInfo[id][bDescription]);
    SendMessage(playerid, string);
    SetPVarInt(playerid, "ShareId", 0);
    GivePlayerMoney(playerid, BuildingInfo[id][bBuyPrice]/BuildingInfo[id][bShares]/2);
    OnUpdatePlayer(playerid);
    BuildingInfo[id][bRenters] --;
    UpdateBuilding(id);
    }
    case 1:SetPVarInt(playerid, "CPID", 3), TogglePlayerAllDynamicCPs(playerid, 0), SetPlayerCheckpoint(playerid, HouseInfo[id][hEntrancex], HouseInfo[id][hEntrancey], HouseInfo[id][hEntrancez], 2.0), SendMessage(playerid, "You have a red marker set on your map to the selected location.");
    }
    }
    if(response != 1)
    {
    RentBuilding(playerid);
    }
    }
    if(dialogid == 75)
    {
    new id = GetPVarInt(playerid, "AdminOn"), string[90], Float:x,Float:y,Float:z;
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:
    {
    if(GetPVarInt(id, "Froze") == 0) SetPVarInt(id, "Froze", 1), TogglePlayerControllable(id, 0), format(string, sizeof(string), "Admin %s has frozen you please wait for his/her response.",GetPlayerNameEx(playerid)), SendMessage(id, string),
	format(string, sizeof(string), "You froze %s he/her is waiting for your response.",GetPlayerNameEx(id)), SendMessage(playerid, string);
    else if(GetPVarInt(id, "Froze") == 1) SetPVarInt(id, "Froze", 0), TogglePlayerControllable(id, 1), format(string, sizeof(string), "Admin %s has unfrozen you.",GetPlayerNameEx(playerid)),SendMessage(id, string),
	format(string, sizeof(string), "You unfroze %s.",GetPlayerNameEx(id)), SendMessage(playerid, string);
	}
	case 1:
	{
	SetPlayerHealth(id, 0);
	format(string, sizeof(string), "Admin %s killed you",GetPlayerNameEx(playerid)); SendMessage(id, string); SendMessage(id, "Note: if you didn't ask to be killed and was, you can report the admin on the forums.");
	format(string, sizeof(string), "You Killed %s",GetPlayerNameEx(id)); SendMessage(playerid, string);
	}
	case 2:
	{
	GetPlayerPos(playerid, x,y,z);
	SetPlayerPos(id, x,y,z);
	SetPlayerInterior(id, GetPlayerInterior(playerid));
	SetPlayerVirtualWorld(id, GetPlayerVirtualWorld(playerid));
	format(string, sizeof(string), "You were teleported to %s", GetPlayerNameEx(playerid)); SendMessage(id, string);
	format(string, sizeof(string), "You teleported %s to you", GetPlayerNameEx(id)); SendMessage(playerid, string);
	}
	case 3:
	{
	GetPlayerPos(id, x,y,z);
	SetPlayerPos(playerid, x,y,z);
	SetPlayerInterior(playerid, GetPlayerInterior(id));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
	format(string, sizeof(string), "Admin %s teleported to you", GetPlayerNameEx(playerid)); SendMessage(id, string);
	format(string, sizeof(string), "You teleported to %s", GetPlayerNameEx(id)); SendMessage(playerid, string);
	}
	case 4: ShowPlayerDialog(playerid,76,DIALOG_STYLE_INPUT,"Set Player's Health","Please enter the amount of health to set from 0-100","Set","Back");
	case 5:
	{
	ResetPlayerWeapons(id);
	ResetGuns(id);
	format(string, sizeof(string), "Admin %s reset your weapons.",GetPlayerNameEx(playerid)); SendMessage(id, string);
    format(string, sizeof(string), "You reset %s weapons.",GetPlayerNameEx(id)); SendMessage(playerid, string);
	}
	case 6:ShowPlayerDialog(playerid,77,DIALOG_STYLE_INPUT,"Kick a Player","Please enter the reason for kicking them","Kick","Back");
	case 7:ShowPlayerDialog(playerid,78,DIALOG_STYLE_INPUT,"Ban a Player","Please enter the reason for banning them","Ban","Back");
	}
    }
    }
    if(dialogid == 76)
    {
    if(response == 1)
    {
    new amount, id = GetPVarInt(playerid, "AdminOn"), string[90];
    if(sscanf(inputtext, "i", amount)) return ShowPlayerDialog(playerid,76,DIALOG_STYLE_INPUT,"ERROR: Numbers only\n\nSet Player's Health","Please enter the amount of health to set from 0-100","Set","Back");
	if(amount <= 0 || amount > 100) return ShowPlayerDialog(playerid,76,DIALOG_STYLE_INPUT,"Set Player's Health","ERROR: amount from 0-100\n\nPlease enter the amount of health to set from 0-100","Set","Back");
	SetPlayerHealth(id, amount);
	format(string, sizeof(string), "Admin %s set your health to %d",GetPlayerNameEx(playerid), amount); SendMessage(id, string);
    format(string, sizeof(string), "You set %s health to %d",GetPlayerNameEx(id), amount); SendMessage(playerid, string);
	}
	if(response == 0)
    {
    ShowPlayerDialog(playerid, 75, DIALOG_STYLE_LIST, "Admin Control Panel", "(Un)Freeze Player\nKill Player\nGet Player\nGo To Player\nSet Health\nReset The Weapons\nKick Player\nBan Player", "Select", "Close");
    }
    }
    if(dialogid == 77)
    {
    if(response == 1)
    {
    new text[60], id = GetPVarInt(playerid, "AdminOn"), string[120];
    if(sscanf(inputtext, "s", text)) return ShowPlayerDialog(playerid,77,DIALOG_STYLE_INPUT,"Kick a Player","ERROR: Message only\n\nPlease enter the reason for kicking them","Kick","Back");
    if(strlen(text) > 50) return ShowPlayerDialog(playerid,77,DIALOG_STYLE_INPUT,"Kick a Player","ERROR: Reason to long\n\nPlease enter the reason for kicking them","Kick","Back");
    new year, month,day;getdate(year, month, day);
    format(string, sizeof(string), "~R~News: ~W~%s was kicked by %s, reason:~N~~P~%s", GetPlayerNameEx(id), GetPlayerNameEx(playerid), inputtext);
    NewsMessage(string);
	Kick(id);
	}
	if(response == 0)
    {
    ShowPlayerDialog(playerid, 75, DIALOG_STYLE_LIST, "Admin Control Panel", "(Un)Freeze Player\nKill Player\nGet Player\nGo To Player\nSet Health\nReset The Weapons\nKick Player\nBan Player", "Select", "Close");
    }
    }
    if(dialogid == 78)
    {
    if(response == 1)
    {
    new text[60], id = GetPVarInt(playerid, "AdminOn"), string[120];
    if(sscanf(inputtext, "s", text)) return ShowPlayerDialog(playerid,78,DIALOG_STYLE_INPUT,"Bank a Player","ERROR: Message only\n\nPlease enter the reason for banning them","Ban","Back");
    if(strlen(text) > 50) return ShowPlayerDialog(playerid,78,DIALOG_STYLE_INPUT,"Ban a Player","ERROR: Reason to long\n\nPlease enter the reason for banning them","Ban","Back");
    new hour, minute, second, year, month, day, AdminIP[16], IP[16], query[256];
    GetPlayerIp(playerid,AdminIP,sizeof(AdminIP));
    GetPlayerIp(id, IP, sizeof(IP));
    gettime(hour, minute, second);
    getdate(year, month, day);
    format(query, sizeof(query), "INSERT INTO `bans` (banned, bannedip, banner, bannerip, reason, time, date) VALUES(\"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%d:%d:%d\", \"%d.%d.%d\")", GetPlayerNameSave(id), IP, GetPlayerNameSave(playerid), AdminIP, text, hour, minute, second, year, month, day);
    samp_mysql_query(query);
    format(string, sizeof(string), "~R~News: ~W~%s was ~R~banned ~W~by %s, reason:~N~~P~%s",GetPlayerNameSave(id), GetPlayerNameSave(playerid), inputtext);
    NewsMessage(string);
	}
	if(response == 0)
    {
    ShowPlayerDialog(playerid, 75, DIALOG_STYLE_LIST, "Admin Control Panel", "(Un)Freeze Player\nKill Player\nGet Player\nGo To Player\nSet Health\nReset The Weapons\nKick Player\nBan Player", "Select", "Close");
    }
    }
    if(dialogid == 79)
    {
    if(response == 1)
    {
    new amount,price, string[100];
    if(sscanf(inputtext, "i", amount)) return SendMessage(playerid, "Please enter a number only"),ShowInsurance(playerid);
    if(amount <= 0 || amount > 100) return SendMessage(playerid, "You can't go lower then 1 or over 100 at 1 time"), ShowInsurance(playerid);
    price = 250*amount;
	if(vehinfo[GetPVarInt(playerid, "VehicleOn")][cBlown] > 0) price = 250*vehinfo[GetPVarInt(playerid, "VehicleOn")][cBlown]*amount;
    if(GetPlayerCash(playerid) < price) return format(string, sizeof(string), "You only have $%d, you need another $%d for %d insurance slots.",GetPlayerCash(playerid), price - GetPlayerCash(playerid), amount), SendMessage(playerid, string), ShowInsurance(playerid);
	GivePlayerCash(playerid, -price);
	vehinfo[GetPVarInt(playerid, "VehicleOn")][cInsurance] += amount;
	UpdateVehicles(GetPVarInt(playerid, "VehicleOn"));
	OnUpdatePlayer(playerid);
	format(string, sizeof(string), "You bought %d insurance slots for $%d", amount, price);
	SendMessage(playerid, string);
	ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
	}
	if(response == 0)
    {
    ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Vehicle System", "Get Vehicle\nPark Vehicle (Must be in it)\nSell Vehicle\nBuy Vehicle Lock ($1000)\nBuy Vehicle Insurance\nVehicle Modifications ($7000)\nLock Vehicle", "Select", "Back");
    }
    }
    if(dialogid == 80)
    {
    if(response == 1)
    {
    new text[150];
    if(sscanf(inputtext, "s", text)) return ShowPlayerDialog(playerid,80,DIALOG_STYLE_INPUT,"Arrest Reason","ERROR:Text only please\n\nPlease enter the reason why they were arrested","Enter","Close");
    if(strlen(text) > 150) return ShowPlayerDialog(playerid,80,DIALOG_STYLE_INPUT,"Arrest Reason","ERROR:Text is to long please make it shorter.\n\nPlease enter the reason why they were arrested","Enter","Close");
    AddArrest(GetPVarInt(playerid, "Holding"),text,playerid);
	new rand = random(sizeof(JailPos)), time = random(3), string[50];
	SetPlayerPos(GetPVarInt(playerid, "Holding"), JailPos[rand][0], JailPos[rand][1], JailPos[rand][2]);
	format(string, sizeof(string), "You was jailed for %d minutes witch is %d seconds",time,time*60);
	SendMessage(GetPVarInt(playerid, "Holding"), string);
	SetPVarInt(GetPVarInt(playerid, "Holding"), "JailTime", time*60+2);
	SetPVarInt(GetPVarInt(playerid, "Holding"), "JailTimer", SetTimerEx("Jail", 1000, 1, "i", GetPVarInt(playerid, "Holding")));
	SetPlayerVirtualWorld(GetPVarInt(playerid, "Holding"), 6890);
	SetPlayerInterior(GetPVarInt(playerid, "Holding"), 3);
	ResetPlayerWeapons(GetPVarInt(playerid, "Holding"));
	if(GetPVarInt(GetPVarInt(playerid, "Holding"), "CuffTimer") != 0) ClearAnimations(GetPVarInt(playerid, "Holding")), KillTimer(GetPVarInt(GetPVarInt(playerid, "Holding"), "CuffTimer")), SetPVarInt(GetPVarInt(playerid, "Holding"), "Stopping", 0), SetPVarInt(playerid, "Holding", 0);
	}
	if(response == 0)
    {
    ShowPlayerDialog(playerid, 53, DIALOG_STYLE_LIST, "Jail Process", "Search Suspect\nRemove a License\nArrest Suspect", "Select", "Close");
    }
    }
    if(dialogid == 81)
    {
    if(response == 1)
    {
    new at = strfind(inputtext, "@", true), dot = strfind(inputtext, ".", true);
    if(at == -1 || dot == -1) return ShowPlayerDialog(playerid,81,DIALOG_STYLE_INPUT,"Please enter your email adress","ERROR: That is an invalid email adress\n\nPlease enter your email adress \n\n'Example Name@hotmail.com'","Enter","Back");
    SetPVarString(playerid, "Email", inputtext);
    SetPVarInt(playerid, "Step", 4);
    MainSpawn(playerid);
    }
    if(response == 0)
    {
    SendMessage(playerid, "You went back a step.");
    TextDrawSetString(Text:GetPVarInt(playerid,"RegArrive"), "_");
    ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "How did you get here", "Coach\nTrain\nPlane", "Select", "Back");
    }
    }
    if(dialogid == 82)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0: SetPVarInt(playerid, "Chat", 0), SendMessage(playerid, "You will now always talk normal.");
    case 1: SetPVarInt(playerid, "Chat", 1), SendMessage(playerid, "You will now always talk shouting.");
    case 2: SetPVarInt(playerid, "Chat", 2), SendMessage(playerid, "You will now always talk Whispering.");
    }
    }
    }
    if(dialogid == 83)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0:
    {
    if(GetPVarInt(playerid, "GunLicense") < 1) return SendMessage(playerid, "You must do the pistol test first before you can buy one.");
    if(GetPlayerCash(playerid) < 90) return SendMessage(playerid, "You need $90 for a pistol."), ShowPlayerDialog(playerid, 83, DIALOG_STYLE_LIST, "Weapon Store Menu", "Pistol (25 bullets) $90\nShotgun (25 bullets) $130\nUzi (50 bullets) £200\nAk47 (50 bullets) $250\nRifle (10 bullets) $270", "Select", "Back");
	GivePlayerWeapon(playerid, 23, 50);
	GivePlayerCash(playerid, -90);
	SendMessage(playerid, "You bought a Pistol for $90 with 50 ammo.");
	ShowPlayerDialog(playerid, 83, DIALOG_STYLE_LIST, "Weapon Store Menu", "Pistol (25 bullets) $90\nShotgun (25 bullets) $130\nUzi (50 bullets) £200\nAk47 (50 bullets) $250\nRifle (10 bullets) $270", "Select", "Back");
	}
	case 1:
    {
    if(GetPVarInt(playerid, "GunLicense") < 2) return SendMessage(playerid, "You must do the shotgun test first before you can buy one.");
    if(GetPlayerCash(playerid) < 130) return SendMessage(playerid, "You need $130 for a Shotgun."), ShowPlayerDialog(playerid, 83, DIALOG_STYLE_LIST, "Weapon Store Menu", "Pistol (25 bullets) $90\nShotgun (25 bullets) $130\nUzi (50 bullets) £200\nAk47 (50 bullets) $250\nRifle (10 bullets) $270", "Select", "Back");
	GivePlayerWeapon(playerid, 25, 50);
	GivePlayerCash(playerid, -130);
	SendMessage(playerid, "You bought a Shotgun for $130 with 50 ammo.");
	ShowPlayerDialog(playerid, 83, DIALOG_STYLE_LIST, "Weapon Store Menu", "Pistol (25 bullets) $90\nShotgun (25 bullets) $130\nUzi (50 bullets) £200\nAk47 (50 bullets) $250\nRifle (10 bullets) $270", "Select", "Back");
	}
	case 2:
    {
    if(GetPVarInt(playerid, "GunLicense") < 3) return SendMessage(playerid, "You must do the uzi test first first before you can buy one.");
    if(GetPlayerCash(playerid) < 200) return SendMessage(playerid, "You need $200 for a Uzi."), ShowPlayerDialog(playerid, 83, DIALOG_STYLE_LIST, "Weapon Store Menu", "Pistol (25 bullets) $90\nShotgun (25 bullets) $130\nUzi (50 bullets) £200\nAk47 (50 bullets) $250\nRifle (10 bullets) $270", "Select", "Back");
	GivePlayerWeapon(playerid, 28, 50);
	GivePlayerCash(playerid, -200);
	SendMessage(playerid, "You bought a Uzi for $200 with 50 ammo.");
	ShowPlayerDialog(playerid, 83, DIALOG_STYLE_LIST, "Weapon Store Menu", "Pistol (25 bullets) $90\nShotgun (25 bullets) $130\nUzi (50 bullets) £200\nAk47 (50 bullets) $250\nRifle (10 bullets) $270", "Select", "Back");
	}
	case 3:
    {
    if(GetPVarInt(playerid, "GunLicense") < 4) return SendMessage(playerid, "You must do the ak47 test first before you can buy one.");
    if(GetPlayerCash(playerid) < 250) return SendMessage(playerid, "You need $250 for a Ak47."), ShowPlayerDialog(playerid, 83, DIALOG_STYLE_LIST, "Weapon Store Menu", "Pistol (25 bullets) $90\nShotgun (25 bullets) $130\nUzi (50 bullets) £200\nAk47 (50 bullets) $250\nRifle (10 bullets) $270", "Select", "Back");
	GivePlayerWeapon(playerid, 30, 50);
	GivePlayerCash(playerid, -250);
	SendMessage(playerid, "You bought a Ak47 for $250 with 50 ammo.");
	ShowPlayerDialog(playerid, 83, DIALOG_STYLE_LIST, "Weapon Store Menu", "Pistol (25 bullets) $90\nShotgun (25 bullets) $130\nUzi (50 bullets) £200\nAk47 (50 bullets) $250\nRifle (10 bullets) $270", "Select", "Back");
	}
	case 4:
    {
    if(GetPlayerCash(playerid) < 270) return SendMessage(playerid, "You need $270 for a Rifle."), ShowPlayerDialog(playerid, 83, DIALOG_STYLE_LIST, "Weapon Store Menu", "Pistol (25 bullets) $90\nShotgun (25 bullets) $130\nUzi (50 bullets) £200\nAk47 (50 bullets) $250\nRifle (10 bullets) $270", "Select", "Back");
	GivePlayerWeapon(playerid, 33, 10);
	GivePlayerCash(playerid, -270);
	SendMessage(playerid, "You bought a Rifle for $270 with 10 ammo.");
	ShowPlayerDialog(playerid, 83, DIALOG_STYLE_LIST, "Weapon Store Menu", "Pistol (25 bullets) $90\nShotgun (25 bullets) $130\nUzi (50 bullets) £200\nAk47 (50 bullets) $250\nRifle (10 bullets) $270", "Select", "Back");
	}
    }
    }
    }
    if(dialogid == 84)
    {
    if(response == 1)
    {
    if(drugs == 1) return SendMessage(playerid, "Drug Dealer Says: I can only deal with one person at a time.. Please wait.");
	if(GetPlayerCash(playerid) < 50) return SendMessage(playerid, "Drug Dealer Says: You need $50 for a seed, come back when you got the money."),ApplyAnimation(drugsman,"PED", "IDLE_CHAT",4.1,1,0,0,0,1000);
	ApplyAnimation(drugsman,"PED", "IDLE_CHAT",4.1,1,0,0,0,0);
    ApplyAnimation(playerid,"PED", "IDLE_CHAT",4.1,1,0,0,0,0);
    SetPlayerPos(playerid, -70.6328,-1576.0699,2.6172);
    SetPlayerFacingAngle(playerid, 9.3868);
    SetPlayerCameraPos(playerid,-70.4932,-1577.1709,4.1307);
    SetPlayerCameraLookAt(playerid,-70.6715,-1574.2494,2.6172);
    drugs = 1;
    SetTimerEx("StopDrugs", 5000, 0, "i", playerid);
    TextDrawShowForPlayer(playerid, Window[0]);
    TextDrawShowForPlayer(playerid, Window[1]);
    new string[180];
    format(string, sizeof(string), "Drug Dealer Says: Here take this seed, if you get caught by the cops don't~N~ ~N~bring them to me.~N~ ~N~ ~N~%s Says: No problem..",GetPlayerNameEx(playerid));
    SetPVarInt(playerid, "DrugsDraw", _:TextDrawCreate(61.000000,357.000000, string));
    TextDrawAlignment(Text:GetPVarInt(playerid, "DrugsDraw"),0);
    TextDrawBackgroundColor(Text:GetPVarInt(playerid, "DrugsDraw"),0x000000ff);
    TextDrawFont(Text:GetPVarInt(playerid, "DrugsDraw"),3);
    TextDrawLetterSize(Text:GetPVarInt(playerid, "DrugsDraw"),0.399999,0.899999);
    TextDrawColor(Text:GetPVarInt(playerid, "DrugsDraw"),0xffffffff);
    TextDrawSetProportional(Text:GetPVarInt(playerid, "DrugsDraw"),1);
    TextDrawSetShadow(Text:GetPVarInt(playerid, "DrugsDraw"),1);
    TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid, "DrugsDraw"));
    }
    }
    if(dialogid == 85)
    {
    if(response != 0)
    {
    switch(listitem)
    {
    case 0: SetPVarInt(playerid, "CPID", 3), TogglePlayerAllDynamicCPs(playerid, 0), SetPlayerCheckpoint(playerid, 2188.0686,-1983.9359,13.2307, 4.0), SendMessage(playerid, "You have a red marker set on your map to the selected location.");
    case 1: SetPVarInt(playerid, "CPID", 3), TogglePlayerAllDynamicCPs(playerid, 0), SetPlayerCheckpoint(playerid, -70.7916,-1575.9993,2.6172, 2.0), SendMessage(playerid, "You have a red marker set on your map to the selected location.");
   	}
    }
    if(response != 1)ShowPlayerDialog(playerid, 43, DIALOG_STYLE_LIST, "City Role Play Map", "Building Locations\nOther Locations", "Select", "Close");
    }
	return 0;
}

function StopDrugs(playerid)
{
TextDrawHideForPlayer(playerid, Window[0]);
TextDrawHideForPlayer(playerid, Window[1]);
TextDrawDestroy(Text:GetPVarInt(playerid, "DrugsDraw"));
StartFade(playerid);
drugs = 0;
GivePlayerCash(playerid, -50);
SetPVarInt(playerid, "HasSeed", GetPVarInt(playerid, "HasSeed") +1);
ClearAnimations(drugsman);
ClearAnimations(playerid);
SetCameraBehindPlayer(playerid);
return 1;
}

function CheckNameAllow(playerid, text[])
{
for(new n = 0; n < sizeof(AllowedNames); n++)
{
new namea[30];
strmid(namea, AllowedNames[n][AllowName], 0, 50, 128);
if(strcmp(namea, text, false)== 1) return 0;
}
return 1;
}

function ShowInsurance(playerid)
{
new string[100];
ShowPlayerDialog(playerid, 79, DIALOG_STYLE_INPUT, "Buying Vehicle Insurance", "It cost $250 for 1 insurance slot\n\nEnter the amount of slots you want to buy", "Select", "Back");
if(vehinfo[GetPVarInt(playerid, "VehicleOn")][cBlown] > 0) format(string, sizeof(string), "It cost $%d for 1 insurance slot\n\nEnter the amount of slots you want to buy",250*vehinfo[GetPVarInt(playerid, "VehicleOn")][cBlown]), ShowPlayerDialog(playerid, 79, DIALOG_STYLE_INPUT, "Buying Vehicle Insurance", string, "Select", "Back");
return 1;
}

function SortGangRank()
{
for(new g = 0; g < sizeof(GangInfo); g++)
{
if(GangInfo[g][gSQLId] != 0){

if(GangInfo[g][gKills] == 0 && GangInfo[g][gKills] == 0) GangInfo[g][gRank] = 7;
if(GangInfo[g][gKills] > 0 && GangInfo[g][gMembers] > 0) GangInfo[g][gRank] = 6;
if(GangInfo[g][gKills] > 10 && GangInfo[g][gMembers] > 5) GangInfo[g][gRank] = 5;
if(GangInfo[g][gKills] > 20 && GangInfo[g][gMembers] > 10) GangInfo[g][gRank] = 4;
if(GangInfo[g][gKills] > 30 && GangInfo[g][gMembers] > 20) GangInfo[g][gRank] = 3;
if(GangInfo[g][gKills] > 50 && GangInfo[g][gMembers] > 50) GangInfo[g][gRank] = 2;
if(GangInfo[g][gKills] > 100 && GangInfo[g][gMembers] > 50) GangInfo[g][gRank] = 1;
UpdateGang(g);
}
}
return 1;
}

function RentAppartment(playerid)
{
new string[300], id = GetPVarInt(playerid, "RentId");

format(string, sizeof(string), "1. Your Renting %s", HouseInfo[id][hDescription]);
ShowPlayerDialog(playerid, 68, DIALOG_STYLE_LIST, "Renting Appartment Information", string, "Select", "Back");
if(id == 0) ShowPlayerDialog(playerid, 65, DIALOG_STYLE_LIST, "Renting Appartment Information", "You don't rent any house's", "Back", "Back");
return 1;
}

function RentBuilding(playerid)
{
new string[300], id = GetPVarInt(playerid, "ShareId");
if(id == 0) return ShowPlayerDialog(playerid, 65, DIALOG_STYLE_LIST, "Share's Information", "You don't have any share's", "Back", "Back");
format(string, sizeof(string), "1. You have shares with the %s building, earning $%d every hour",BuildingInfo[id][bDescription], BuildingInfo[id][bBuyPrice]/BuildingInfo[id][bShares]/4);
ShowPlayerDialog(playerid, 73, DIALOG_STYLE_LIST, "Share's Information", string, "Select", "Back");
return 1;
}

function CheckBuilding(playerid)
{
new string[300], x = 0,var[30];
for(new b = 0; b < sizeof(BuildingInfo); b++)
{
if(MyBusiness(playerid, b))
{
x++;
format(string, sizeof(string), "%s%d.%s\n",string,x,BuildingInfo[b][bDescription]);
if(BuildingInfo[b][bOwnerId] == 0)
{
format(string, sizeof(string), "");
x--;
}

format(var, sizeof(var), "Building%d",x);
SetPVarInt(playerid, var, b);
if(x > 0) ShowPlayerDialog(playerid, 60, DIALOG_STYLE_LIST, "Building's", string, "Select", "Back");
}
if(x == 0) ShowPlayerDialog(playerid, 65, DIALOG_STYLE_LIST, "Building's", "You don't own any building's", "Back", "Back");
}
return 1;
}

function MyBusiness(playerid, bizid)
{
	if(BuildingInfo[bizid][bOwnerId] == GetPVarInt(playerid, "SQLID")) return 1;
	return 0;
}

function CheckHouse(playerid)
{
new string[300], x = 0,var[30];
for(new h = 0; h < sizeof(HouseInfo); h++)
{
if(MyHouse(playerid, h))
{
x++;
format(string, sizeof(string), "%s%d.%s\n",string,x,HouseInfo[h][hDescription]);

format(var, sizeof(var), "House%d",x);
SetPVarInt(playerid, var, h);
if(x > 0) ShowPlayerDialog(playerid, 63, DIALOG_STYLE_LIST, "House's", string, "Select", "Back");
}
if(x == 0) ShowPlayerDialog(playerid, 65, DIALOG_STYLE_LIST, "House's", "You don't own any house's", "Back", "Back");
}
return 1;
}

function MyHouse(playerid, houseid)
{
	if(HouseInfo[houseid][hOwnerId] == GetPVarInt(playerid, "SQLID")) return 1;
	return 0;
}

function Count(playerid)
{
if(GetPVarInt(playerid, "CountNo") == 0) SetPVarInt(playerid, "CountNo", 1), GameTextForPlayer(playerid, "~p~3", 5000, 3),SetTimerEx("Count", 1000, 0, "i", playerid), PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
else if(GetPVarInt(playerid, "CountNo") == 1) SetPVarInt(playerid, "CountNo", 2), GameTextForPlayer(playerid, "~p~2", 5000, 3),SetTimerEx("Count", 1000, 0, "i", playerid), PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
else if(GetPVarInt(playerid, "CountNo") == 2) SetPVarInt(playerid, "CountNo", 3), GameTextForPlayer(playerid, "~p~1", 5000, 3),SetTimerEx("Count", 1000, 0, "i", playerid), PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
else if(GetPVarInt(playerid, "CountNo") == 3) SetPVarInt(playerid, "CountNo", 0), GameTextForPlayer(playerid, "~W~Go", 5000, 3), StartGunTrain(playerid), TogglePlayerControllable(playerid, 1), PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
return 1;
}

function CDPart(playerid)
{
OnUpdatePlayer(playerid);
ResetPlayerWeapons(playerid);
SetPlayerInterior(playerid, 1);
SetCameraBehindPlayer(playerid);
SetPlayerPos(playerid, 292.3133,-24.6635,1001.5156);
SetPlayerFacingAngle(playerid, 359.0700);
TextDrawShowForPlayer(playerid, Window[0]);
TextDrawShowForPlayer(playerid, Window[1]);
TogglePlayerControllable(playerid, 0);
SetTimerEx("Count", 5000, 0, "i", playerid);
if(GetPVarInt(playerid, "Watch") == 1) TextDrawHideForPlayer(playerid,TimeText1), TextDrawHideForPlayer(playerid,TimeText);
return 1;
}

function CheckName(name[])
{
foreach(Player, i)
{
if(strcmp(name, GetPlayerNameEx(i), true)== 0) return 1;
}
return 0;
}

function FreeThem(playerid)
{
SetPlayerPos(playerid, 202.5416,175.5320,1003.0234);
SetPlayerVirtualWorld(playerid, 6890);
SetPlayerInterior(playerid, 3);
OnUpdatePlayer(playerid);
TextDrawDestroy(Text:GetPVarInt(playerid,"CopTest"));
KillTimer(GetPVarInt(playerid, "JailTimer"));
SendMessage(playerid, "You are now free to go.");
if(GetPVarInt(playerid, "GunLicense") >= 4) GiveGuns(playerid), SendMessage(playerid, "You have a full weapon license, so you was returned what weapons you had before you went to jail.");
return 1;
}

function Jail(playerid)
{
if(GetPVarInt(playerid, "JailTime") == 0) return FreeThem(playerid);

new tmp[100];
SetPVarInt(playerid, "JailTime", GetPVarInt(playerid, "JailTime") -1);
format(tmp, sizeof(tmp), "You have: %d Second's Left~N~Same as %d Minute's Left", GetPVarInt(playerid, "JailTime"), GetPVarInt(playerid, "JailTime")/60);

if(GetPVarInt(playerid, "JailTextDraw") == 1) return
TextDrawSetString(Text:GetPVarInt(playerid,"CopTest"), tmp),
TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid,"CopTest"));

SetPVarInt(playerid, "CopTest", _:TextDrawCreate(481.000000,141.000000,tmp));
TextDrawUseBox(Text:GetPVarInt(playerid,"CopTest"),1);
TextDrawBoxColor(Text:GetPVarInt(playerid,"CopTest"),0x00000099);
TextDrawTextSize(Text:GetPVarInt(playerid,"CopTest"),620.000000,-12.000000);
TextDrawAlignment(Text:GetPVarInt(playerid,"CopTest"),0);
TextDrawBackgroundColor(Text:GetPVarInt(playerid,"CopTest"),0x0000ffff);
TextDrawFont(Text:GetPVarInt(playerid,"CopTest"),1);
TextDrawLetterSize(Text:GetPVarInt(playerid,"CopTest"),0.299999,0.899999);
TextDrawColor(Text:GetPVarInt(playerid,"CopTest"),0xffffffff);
TextDrawSetProportional(Text:GetPVarInt(playerid,"CopTest"),1);
TextDrawSetShadow(Text:GetPVarInt(playerid,"CopTest"),1);
SetPVarInt(playerid, "JailTextDraw", 1);
return 1;
}

function SearchResult(playerid)
{
ClearAnimations(GetPVarInt(playerid, "Holding"));
ClearAnimations(playerid);
new weapons[13][2], string[50], gun[20];
for (new i = 0; i < 13; i++)
{
    GetPlayerWeaponData(GetPVarInt(playerid, "Holding"), i, weapons[i][0], weapons[i][1]);
}
SendMessage(playerid, "---------------------------------------------------------------------------------------");
if(weapons[0][0] == 0 && weapons[1][0] == 0 && weapons[3][0] == 0 && weapons[4][0] == 0 && weapons[5][0] == 0 && weapons[6][0] == 0
|| weapons[7][0] == 0 && weapons[8][0] == 0 && weapons[9][0] == 0 && weapons[10][0] == 0 && weapons[11][0] == 0 && weapons[12][0] == 0) return SendMessage(playerid, "This person has no weapons."), CheckItems(playerid);
SendMessage(playerid, "There Holding:");
if(weapons[0][0] != 0) GetWeaponName(weapons[0][0],gun,sizeof(gun)), format(string, sizeof(string),"A %s With %d Ammo",gun, weapons[0][1]),SendMessage(playerid, string);
if(weapons[1][0] != 0) GetWeaponName(weapons[1][0],gun,sizeof(gun)), format(string, sizeof(string),"A %s With %d Ammo",gun, weapons[1][1]),SendMessage(playerid, string);
if(weapons[2][0] != 0) GetWeaponName(weapons[2][0],gun,sizeof(gun)), format(string, sizeof(string),"A %s With %d Ammo",gun, weapons[2][1]),SendMessage(playerid, string);
if(weapons[3][0] != 0) GetWeaponName(weapons[3][0],gun,sizeof(gun)), format(string, sizeof(string),"A %s With %d Ammo",gun, weapons[3][1]),SendMessage(playerid, string);
if(weapons[4][0] != 0) GetWeaponName(weapons[4][0],gun,sizeof(gun)), format(string, sizeof(string),"A %s With %d Ammo",gun, weapons[4][1]),SendMessage(playerid, string);
if(weapons[5][0] != 0) GetWeaponName(weapons[5][0],gun,sizeof(gun)), format(string, sizeof(string),"A %s With %d Ammo",gun, weapons[5][1]),SendMessage(playerid, string);
if(weapons[6][0] != 0) GetWeaponName(weapons[6][0],gun,sizeof(gun)), format(string, sizeof(string),"A %s With %d Ammo",gun, weapons[6][1]),SendMessage(playerid, string);
if(weapons[7][0] != 0) GetWeaponName(weapons[7][0],gun,sizeof(gun)), format(string, sizeof(string),"A %s With %d Ammo",gun, weapons[7][1]),SendMessage(playerid, string);
if(weapons[8][0] != 0) GetWeaponName(weapons[8][0],gun,sizeof(gun)), format(string, sizeof(string),"A %s With %d Ammo",gun, weapons[8][1]),SendMessage(playerid, string);
if(weapons[9][0] != 0) GetWeaponName(weapons[9][0],gun,sizeof(gun)), format(string, sizeof(string),"A %s With %d Ammo",gun, weapons[9][1]),SendMessage(playerid, string);
if(weapons[10][0] != 0) GetWeaponName(weapons[10][0],gun,sizeof(gun)), format(string, sizeof(string),"A %s With %d Ammo",gun, weapons[10][1]),SendMessage(playerid, string);
if(weapons[11][0] != 0) GetWeaponName(weapons[11][0],gun,sizeof(gun)), format(string, sizeof(string),"A %s With %d Ammo",gun, weapons[11][1]),SendMessage(playerid, string);
if(weapons[12][0] != 0) GetWeaponName(weapons[12][0],gun,sizeof(gun)), format(string, sizeof(string),"A %s With %d Ammo",gun, weapons[12][1]),SendMessage(playerid, string);
CheckItems(GetPVarInt(playerid, "Holding"));
if(GetPVarInt(GetPVarInt(playerid, "Holding"), "GunLicense") < 4) ResetGuns(GetPVarInt(playerid, "Holding"));
return 1;
}

function CheckItems(playerid)
{
if(GetPVarInt(playerid, "GunLicense") >= 4) SendMessage(playerid, "This person has a full weapon license.");
if(GetPVarInt(playerid, "License") == 0) SendMessage(playerid, "This person doesn't have a driving license.");
if(GetPVarInt(playerid, "License") == 1) SendMessage(playerid, "This person has a driving license.");
if(GetPVarInt(playerid, "License") == 2) SendMessage(playerid, "This person has a driving license and a blue light license.");
if(GetPVarInt(playerid, "Watch") == 1) SendMessage(playerid, "This person has a Watch on.");
if(GetPVarInt(playerid, "Number") != 0) SendMessage(playerid, "This person has a mobile phone.");
SendMessage(playerid, "---------------------------------------------------------------------------------------");
return 1;
}

function ErrorBank(playerid)
{
ShowPlayerDialog(playerid, 47, DIALOG_STYLE_LIST, "Banking Options", "Balance\nWithdraw Cash\nDeposit Cash\nCash Pay Checks", "Select", "Close");
if(GetPVarInt(playerid, "ATMS") == 1) ShowPlayerDialog(playerid, 47, DIALOG_STYLE_LIST, "ATM Options", "Balance\nWithdraw Cash\nDeposit Cash", "Select", "Close");
return 1;
}

function WalkInJC(playerid)
{
SetPVarInt(playerid, "JCT1", 1);
DestroyDynamicObject(jcd);
SetTimer("CloseJCD", 2000, 0);
SetPlayerPos(playerid, 381.2526,173.4627,1008.3828);
SetPlayerFacingAngle(playerid, 89.1582);
ApplyAnimation(playerid,"PED","WALK_player",4.1,1,1,1,1,0);
SetPVarInt(playerid, "JCT", SetTimerEx("CJCT", 1000, 1, "i", playerid));
TextDrawShowForPlayer(playerid, Window[0]);
TextDrawShowForPlayer(playerid, Window[1]);
return 1;
}

function CloseJCD()
{
jcd = CreateDynamicObject(1538, 379.4423828125, 172.638671875, 1007.3322753906, 0, 0, 93.680419921875);
return 1;
}

function CJCT(playerid)
{
if(IsPlayerInRangeOfPoint(playerid, 1, 361.9722,173.4894,1008.3828))
KillTimer(GetPVarInt(playerid, "JCT")),
DeletePVar(playerid,"JCT"),
ClearAnimations(playerid),
SetPlayerPos(playerid, 362.2211,173.4014,1008.3893),
SetPlayerFacingAngle(playerid, 88.5316),
SetPlayerCameraPos(playerid,356.9543,182.1398,1011.7283),
SetPlayerCameraLookAt(playerid,361.8299,173.2053,1008.3828),
NpcText(playerid),
ApplyAnimation(playerid,"PED", "IDLE_CHAT",4.1,0,0,0,0,0),
ApplyAnimation(playerid,"PED", "IDLE_CHAT",4.1,0,0,0,0,0),
ApplyAnimation(jobcenter,"PED", "IDLE_CHAT",4.1,0,0,0,0,8000),
ApplyAnimation(jobcenter,"PED", "IDLE_CHAT",4.1,0,0,0,0,8000),
SetTimerEx("JCTA", 7000, 0, "i", playerid);
return 1;
}

function NpcText(playerid)
{
new tmp[180], job[70];
if(GetPVarInt(playerid, "WantsJob") == 1) job = "Bin Man job.. Please go to the scrap yard..";
if(GetPVarInt(playerid, "WantsJob") == 2) job = "Fire Man job.. Please go to the Fire Department..";
if(GetPVarInt(playerid, "WantsJob") == 3) job = "Police Officer job.. Please go to the Police Department..";

format(tmp, sizeof(tmp), "Okay, so you want %s ~N~ ~N~Hint: Go to the red marker set on your mini map to get this job", job);
if(GetPVarInt(playerid, "WantsJob") == 4) SortJob(playerid), format(tmp, sizeof(tmp), "Hello %s, You successfully signed on~N~ ~N~Hint: Go to the bank to cash your pay check", GetPlayerNameEx(playerid));
if(GetPVarInt(playerid, "WantsJob") == 4 && GetPVarInt(playerid, "Team") != civ) SetPVarString(playerid,"Rank", "Nothing"), SetPVarInt(playerid, "Exp", 0);

NpcTalk = TextDrawCreate(61.000000,357.000000, tmp);
TextDrawAlignment(NpcTalk,0);
TextDrawBackgroundColor(NpcTalk,0x000000ff);
TextDrawFont(NpcTalk,3);
TextDrawLetterSize(NpcTalk,0.399999,0.899999);
TextDrawColor(NpcTalk,0xffffffff);
TextDrawSetProportional(NpcTalk,1);
TextDrawSetShadow(NpcTalk,1);
TextDrawShowForPlayer(playerid, NpcTalk);
return 1;
}

function JCTA(playerid)
{
ClearAnimations(playerid);
ClearAnimations(jobcenter);
TextDrawDestroy(NpcTalk);
SetPlayerPos(playerid, 362.2211,173.4014,1008.3893);
SetPlayerFacingAngle(playerid, 269.7524);
SetCameraBehindPlayer(playerid);
ApplyAnimation(playerid,"PED","WALK_player",4.1,1,1,1,1,0);
SetPVarInt(playerid, "JCT1", SetTimerEx("JCWB", 1000, 1, "i", playerid));
return 1;
}

function JCWB(playerid)
{
if(IsPlayerInRangeOfPoint(playerid, 1, 377.9739,173.5581,1008.3828))
KillTimer(GetPVarInt(playerid, "JCT1")),
DeletePVar(playerid,"JCT1"),
SetCameraBehindPlayer(playerid),
TextDrawHideForPlayer(playerid, Window[0]),
TextDrawHideForPlayer(playerid, Window[1]),
injobmeeting = 0,
SetPlayerPos(playerid, 384.8225,173.4911,1008.3828),
ClearAnimations(playerid),
SetJobDir(playerid);
return 1;
}

function SetJobDir(playerid)
{
if(GetPVarInt(playerid, "WantsJob") == 1) TogglePlayerAllDynamicCPs(playerid, 0), SetPVarInt(playerid, "CPID", 4), SetPlayerCheckpoint(playerid, 2196.9097,-1970.3496,13.7841, 2);
if(GetPVarInt(playerid, "WantsJob") == 2) TogglePlayerAllDynamicCPs(playerid, 0), SetPVarInt(playerid, "CPID", 4), SetPlayerCheckpoint(playerid, 1793.7665,-1296.5293,13.4391, 2);
if(GetPVarInt(playerid, "WantsJob") == 3) TogglePlayerAllDynamicCPs(playerid, 0), SetPVarInt(playerid, "CPID", 4), SetPlayerCheckpoint(playerid, 2310.4409,-8.2926,26.7422, 2);
if(GetPVarInt(playerid, "WantsJob") == 4) TogglePlayerAllDynamicCPs(playerid, 1);
return 1;
}

function HangUp(playerid)
{
SetPVarInt(GetPVarInt(playerid, "Caller"), "Caller", 0),
SetPVarInt(GetPVarInt(playerid, "Caller"), "Calling", 0),
SetPVarInt(GetPVarInt(playerid, "Caller"), "PickedUp", 0),
SetPVarInt(GetPVarInt(playerid, "Caller"), "CanTalk", 1),
SetPVarInt(playerid, "Caller", 0),
SetPVarInt(playerid, "Calling", 0),
SetPVarInt(playerid, "PickedUp", 0),
SetPVarInt(playerid, "CanTalk", 0);
return 1;
}

function CloseCase(playerid)
{
if(GetPVarInt(playerid, "TraceTimer") != 0) KillTimer(GetPVarInt(playerid, "TraceTimer")), DisablePlayerCheckpoint(playerid);
SetPVarInt(playerid, "CaseIdOn", 0);
SetPVarInt(playerid, "DealingCaseId", 0);
SetPVarInt(playerid, "CaseReporter", 0);
return 1;
}

function Tracing(playerid)
{
new Float:x,Float:y,Float:z;
GetPlayerPos(GetPVarInt(playerid, "CaseReporter"),x,y,z);
DisablePlayerCheckpoint(playerid);
SetPlayerCheckpoint(playerid, x, y, z, 3);
return 1;
}

function CheckCase(playerid, caseid)
{
foreach(player, i)
{
if(GetPVarInt(i, "Case") == caseid) return SetPVarInt(playerid, "DealingCaseId", i), SetPVarInt(i, "DealingCaseId", playerid), SetPVarInt(playerid, "CaseReporter", i), SetPVarInt(playerid, "CaseIdOn", caseid);
}
return 0;
}

function CheckNumberText(playerid, number)
{
foreach(player, i)
{
if(GetPVarInt(i, "Number") == number) return SetPVarInt(playerid, "Texting", i), SetPVarInt(i, "Texting", playerid), SetPVarInt(i, "Texter", playerid), SetPVarInt(playerid, "Texter", i);
}
return 0;
}

function CheckNumber(playerid, number)
{
foreach(player, i)
{
if(GetPVarInt(i, "Number") == number) return SetPVarInt(playerid, "Calling", i), SetPVarInt(i, "Calling", i), SetPVarInt(i, "Caller", playerid), SetPVarInt(playerid, "Caller", playerid), SetPVarInt(i, "PickedUp", playerid);
}
return 0;
}

function RespawnVehicles()
{
new Car;
for(Car=0;Car<totalveh+9;Car++)
{
if(SeatTaken[0][Car] == 0 &&  SeatTaken[1][Car] == 0 && SeatTaken[2][Car] == 0 && SeatTaken[3][Car] == 0) SetVehicleToRespawn(Car);
}
return 1;
}

function RunHotWire(playerid)
{
            new vehicle = GetPlayerVehicleID(playerid);
			new string[128];
			if(GetPVarInt(playerid, "InHotWire") == 1)
			{
				return 1;
			}
			if(engineOn[vehicle] == 1)
			{
				return 1;
			}
			if(VehicleOwnAble(vehicle) && vehinfo[vehicle][cOwned] == 0 && vehinfo[vehicle][cCantSell] == 0)
			{
				return 1;
			}
			if(GetPVarInt(playerid, "HotWireSkill") >= 0 && GetPVarInt(playerid, "HotWireSkill") < 15)
			{
				SendMessage(playerid, "your attempting to hotwire this vehicle");
				SendMessage(playerid, "Hint: The More You Hotwire The Better You Get");
				format(string, sizeof(string), "%s attempts to hotwire the vehicle he is in.", GetPlayerNameEx(playerid));
				ProxDetector(30.0, playerid, string, purple,purple,purple,purple,purple);
				SetPVarInt(playerid, "InHotWire", 1);
				if(GetPVarInt(playerid, "PickedHorWire") == 1) return SetTimerEx("hotwired", 7000, 0, "i", playerid), SetPVarInt(playerid, "PickedHorWire", 0);
				if(GetPVarInt(playerid, "PickedHorWire") == 2) return SetTimerEx("hotwireda", 7000, 0, "i", playerid), SetPVarInt(playerid, "PickedHorWire", 0);
				ApplyAnimation(playerid,"CAR","Tap_hand",4.1,0,0,0,0,7000);
				return 1;
			}
			else if(GetPVarInt(playerid, "HotWireSkill") >= 15 && GetPVarInt(playerid, "HotWireSkill") <= 30)
			{
				SendMessage(playerid, "your attempting to hotwire this vehicle");
				SendMessage(playerid, "Hint: The More You Hotwire The Better You Get");
				SendMessage(playerid, "Hint: Your hotwire Skill is Better This Will Take Aprox: 6 Seconds");
				format(string, sizeof(string), "%s attempts to hotwire the vehicle he is in.", GetPlayerNameEx(playerid));
				ProxDetector(30.0, playerid, string, purple,purple,purple,purple,purple);
				SetPVarInt(playerid, "InHotWire", 1);
				if(GetPVarInt(playerid, "PickedHorWire") == 1) return SetTimerEx("hotwired", 6000, 0, "i", playerid), SetPVarInt(playerid, "PickedHorWire", 0);
				if(GetPVarInt(playerid, "PickedHorWire") == 2) return SetTimerEx("hotwireda", 6000, 0, "i", playerid), SetPVarInt(playerid, "PickedHorWire", 0);
				ApplyAnimation(playerid,"CAR","Tap_hand",4.1,0,0,0,0,6000);
				return 1;
			}
			else if(GetPVarInt(playerid, "HotWireSkill") >= 30 && GetPVarInt(playerid, "HotWireSkill") <= 50)
			{
				SendMessage(playerid, "your attempting to hotwire this vehicle");
				SendMessage(playerid, "Hint: The More You Hotwire The Better You Get");
				SendMessage(playerid, "Hint: Your hotwire Skill is Good This Will Take Aprox: 5 Seconds");
				format(string, sizeof(string), "%s attempts to hotwire the vehicle he is in.", GetPlayerNameEx(playerid));
				ProxDetector(30.0, playerid, string, purple,purple,purple,purple,purple);
				SetPVarInt(playerid, "InHotWire", 1);
				if(GetPVarInt(playerid, "PickedHorWire") == 1) return SetTimerEx("hotwired", 5000, 0, "i", playerid), SetPVarInt(playerid, "PickedHorWire", 0);
				if(GetPVarInt(playerid, "PickedHorWire") == 2) return SetTimerEx("hotwireda", 5000, 0, "i", playerid), SetPVarInt(playerid, "PickedHorWire", 0);
				ApplyAnimation(playerid,"CAR","Tap_hand",4.1,0,0,0,0,5000);
				return 1;
			}
			else if(GetPVarInt(playerid, "HotWireSkill") > 50 && GetPVarInt(playerid, "HotWireSkill") <= 75)
			{
				SendMessage(playerid, "your attempting to hotwire this vehicle");
				SendMessage(playerid, "Hint: The More You Hotwire The Better You Get");
				SendMessage(playerid, "Hint: Your hotwire Skill is Great This Will Take Aprox: 4 Seconds");
				format(string, sizeof(string), "%s attempts to hotwire the vehicle he is in.", GetPlayerNameEx(playerid));
				ProxDetector(30.0, playerid, string, purple,purple,purple,purple,purple);
				SetPVarInt(playerid, "InHotWire", 1);
				if(GetPVarInt(playerid, "PickedHorWire") == 1) return SetTimerEx("hotwired", 4000, 0, "i", playerid), SetPVarInt(playerid, "PickedHorWire", 0);
				if(GetPVarInt(playerid, "PickedHorWire") == 2) return SetTimerEx("hotwireda", 4000, 0, "i", playerid), SetPVarInt(playerid, "PickedHorWire", 0);
				ApplyAnimation(playerid,"CAR","Tap_hand",4.1,0,0,0,0,4000);
				return 1;
			}
			else if(GetPVarInt(playerid, "HotWireSkill") > 75 && GetPVarInt(playerid, "HotWireSkill") <= 100)
			{
				SendMessage(playerid, "your attempting to hotwire this vehicle");
				SendMessage(playerid, "Hint: The More You Hotwire The Better You Get");
				SendMessage(playerid, "Hint: Your hotwire Skill is Brilliant This Will Take Aprox: 3.5 Seconds");
				format(string, sizeof(string), "%s attempts to hotwire the vehicle he is in.", GetPlayerNameEx(playerid));
				ProxDetector(30.0, playerid, string, purple,purple,purple,purple,purple);
				SetPVarInt(playerid, "InHotWire", 1);
				if(GetPVarInt(playerid, "PickedHorWire") == 1) return SetTimerEx("hotwired", 3500, 0, "i", playerid), SetPVarInt(playerid, "PickedHorWire", 0);
				if(GetPVarInt(playerid, "PickedHorWire") == 2) return SetTimerEx("hotwireda", 3500, 0, "i", playerid), SetPVarInt(playerid, "PickedHorWire", 0);
				ApplyAnimation(playerid,"CAR","Tap_hand",4.1,0,0,0,0,5000);
				return 1;
			}
			else if(GetPVarInt(playerid, "HotWireSkill") > 100 && GetPVarInt(playerid, "HotWireSkill") <= 150)
			{
				SendMessage(playerid, "your attempting to hotwire this vehicle");
				SendMessage(playerid, "Hint: The More You Hotwire The Better You Get");
				SendMessage(playerid, "Hint: Your hotwire Skill is Awesome This Will Take Aprox: 3 Seconds");
				format(string, sizeof(string), "%s attempts to hotwire the vehicle he is in.", GetPlayerNameEx(playerid));
				ProxDetector(30.0, playerid, string, purple,purple,purple,purple,purple);
				SetPVarInt(playerid, "InHotWire", 1);
				if(GetPVarInt(playerid, "PickedHorWire") == 1) return SetTimerEx("hotwired", 3000, 0, "i", playerid), SetPVarInt(playerid, "PickedHorWire", 0);
				if(GetPVarInt(playerid, "PickedHorWire") == 2) return SetTimerEx("hotwireda", 3000, 0, "i", playerid), SetPVarInt(playerid, "PickedHorWire", 0);
				ApplyAnimation(playerid,"CAR","Tap_hand",4.1,0,0,0,0,4000);
				return 1;
			}
			else if(GetPVarInt(playerid, "HotWireSkill") > 150 && GetPVarInt(playerid, "HotWireSkill") <= 400)
			{
				SendMessage(playerid, "your attempting to hotwire this vehicle");
				SendMessage(playerid, "Hint: The More You Hotwire The Better You Get");
				SendMessage(playerid, "Hint: Your hotwire Skill is Amazing This Will Take Aprox: 2 Seconds");
				format(string, sizeof(string), "%s attempts to hotwire the vehicle he is in.", GetPlayerNameEx(playerid));
				ProxDetector(30.0, playerid, string, purple,purple,purple,purple,purple);
				SetPVarInt(playerid, "InHotWire", 1);
				if(GetPVarInt(playerid, "PickedHorWire") == 1) return SetTimerEx("hotwired", 2000, 0, "i", playerid), SetPVarInt(playerid, "PickedHorWire", 0);
				if(GetPVarInt(playerid, "PickedHorWire") == 2) return SetTimerEx("hotwireda", 2000, 0, "i", playerid), SetPVarInt(playerid, "PickedHorWire", 0);
				ApplyAnimation(playerid,"CAR","Tap_hand",4.1,0,0,0,0,3000);
				return 1;
			}
			else if(GetPVarInt(playerid, "HotWireSkill") > 400)
			{
				SendMessage(playerid, "You're The Master At Hotwiring This Vehcile Started it in no time!");
				hotwired1(playerid);
				return 1;
			}
            return 1;
}

function InvalidSymbol(playerid, text[])
{
new str[128];
strmid(str,text,0,strlen(text),128);
for(new i = 0; i < sizeof(str); i++)
{
if(str[i] == '{' || str[i] == '}' || str[i] == '#' || str[i] == ''' || str[i] == '>' || str[i] == '<' || str[i] == '.'
|| str[i] == ',' || str[i] == '?' || str[i] == '~' || str[i] == ';' || str[i] == ':' || str[i] == '/'
|| str[i] == '!' || str[i] == '|') return 1;
}
return 0;
}

function DeleteGang(playerid)
{
new query[300];
new id = GetPVarInt(playerid, "GangId");
format(query, sizeof(query), "DELETE FROM gangs WHERE gangid=%d",id);
printf(" SQL: %s",query);
samp_mysql_query(query);
GangInfo[id][gSQLId] = 0;
GangInfo[id][gLeader] = 0;
GangInfo[id][gName] = 0;
GangInfo[id][gMembers] = 0;
GangInfo[id][gRank] = 0;
GangInfo[id][gKills] = 0;
GangInfo[id][gGuns1] = 0;
GangInfo[id][gGuns2] = 0;
GangInfo[id][gGuns3] = 0;
GangInfo[id][gGuns4] = 0;
GangInfo[id][gGuns5] = 0;
GangInfo[id][gGuns6] = 0;
SetPVarInt(playerid, "GangId", 0);
SetPVarString(playerid, "Gang", "Nothing");
return 1;
}

function AdminReportMessage(text[], id, from)
{
foreach(player, i)
{
if(GetPVarInt(i, "Admin") > 0)
{
new string[128];
format(string, sizeof(string), "Reporter ID: %d | Reporter Name: %s",from, GetPlayerNameEx(from));
SendMessage(i, string);
format(string, sizeof(string), "Reported Playerid: %d | Reported Name: %s",id, GetPlayerNameEx(id));
SendMessage(i, string);
format(string, sizeof(string), "Reported Description: %s",text);
SendMessage(i, string);
}
}
return 1;
}

function CopReportMessage(team, text[], from, name[])
{
foreach(player, i)
{
if(GetPVarInt(i, "Team") == team)
{
new string[128];
new pcase = 10000 + random(99999);
SetPVarString(from, "ReportText", text);
SetPVarInt(from, "Case", pcase);
format(string, sizeof(string), "Reporter ID: %d",from);
SendMessage(i, string);
format(string, sizeof(string), "Reporter Name: %s",name);
SendMessage(i, string);
format(string, sizeof(string), "Reported Description: %s",text);
SendMessage(i, string);
format(string, sizeof(string), "Case Number: %d",pcase);
SendMessage(i, string);
SendMessage(i, "To take this case type /case ");
}
}
return 1;
}

function RestoreAccount(playerid)
{
SetPVarInt(playerid, "Cash", 2500);
SetPVarInt(playerid, "Spent", 0);
SetPVarInt(playerid, "Earned",0);
SetPVarInt(playerid, "HotWireSkill", 0);
SetPVarInt(playerid, "Step", 0);
SetPVarInt(playerid, "Team", civ);
SetPVarInt(playerid, "Exp", 0);
SetPVarString(playerid,"Rank", "Nothing");
OnUpdatePlayer(playerid);
MainSpawn(playerid);
return 1;
}

function SortKeys(playerid)
{
new key[6];
key[0] = GetPVarInt(playerid, "Vehicle0");
key[1] = GetPVarInt(playerid, "Vehicle1");
key[2] = GetPVarInt(playerid, "Vehicle2");
key[3] = GetPVarInt(playerid, "Vehicle3");
key[4] = GetPVarInt(playerid, "Vehicle4");
key[5] = GetPVarInt(playerid, "Vehicle5");


if(GetPVarInt(playerid, "Vehicle0") == 0 && GetPVarInt(playerid, "Vehicle1") != 0)
SetPVarInt(playerid, "Vehicle0",key[1]), SetPVarInt(playerid, "Vehicle1",0);


if(GetPVarInt(playerid, "Vehicle1") == 0 && GetPVarInt(playerid, "Vehicle2") != 0)
SetPVarInt(playerid, "Vehicle1", key[2]), SetPVarInt(playerid, "Vehicle2", 0);


if(GetPVarInt(playerid, "Vehicle2") == 0 && GetPVarInt(playerid, "Vehicle3") != 0)
SetPVarInt(playerid, "Vehicle2", key[3]), SetPVarInt(playerid, "Vehicle3", 0);


if(GetPVarInt(playerid, "Vehicle3") == 0 && GetPVarInt(playerid, "Vehicle4") != 0)
SetPVarInt(playerid, "Vehicle3", key[4]), SetPVarInt(playerid, "Vehicle4", 0);


if(GetPVarInt(playerid, "Vehicle4") == 0 && GetPVarInt(playerid, "Vehicle5") != 0)
SetPVarInt(playerid, "Vehicle4", key[5]), SetPVarInt(playerid, "Vehicle5", 0);

key[0] = GetPVarInt(playerid, "Vehicle0");
key[1] = GetPVarInt(playerid, "Vehicle1");
key[2] = GetPVarInt(playerid, "Vehicle2");
key[3] = GetPVarInt(playerid, "Vehicle3");
key[4] = GetPVarInt(playerid, "Vehicle4");
key[5] = GetPVarInt(playerid, "Vehicle5");

if(key[5] < key[4] && key[5] != 0 && key[4] != 0) SetPVarInt(playerid, "Vehicle5", key[4]), SetPVarInt(playerid, "Vehicle4", key[5]);
if(key[4] < key[3] && key[4] != 0 && key[3] != 0) SetPVarInt(playerid, "Vehicle4", key[3]), SetPVarInt(playerid, "Vehicle3", key[4]);
if(key[3] < key[2] && key[3] != 0 && key[2] != 0) SetPVarInt(playerid, "Vehicle3", key[2]), SetPVarInt(playerid, "Vehicle2", key[3]);
if(key[2] < key[1] && key[2] != 0 && key[1] != 0) SetPVarInt(playerid, "Vehicle2", key[1]), SetPVarInt(playerid, "Vehicle1", key[2]);
if(key[1] < key[0] && key[1] != 0 && key[0] != 0) SetPVarInt(playerid, "Vehicle1", key[0]), SetPVarInt(playerid, "Vehicle0", key[1]);
return 1;
}

function CheckVeh(playerid)
{
SortKeys(playerid);
new string[400];
new x = 0;
new Car;
for(Car=0;Car<totalveh+9;Car++)
{
if(MyVehicle(playerid, Car))
{
x++;
format(string, sizeof(string), "%sYou Have A: %s - Vehicle ID: %d - In Slot: %d\n",string,vehinfo[Car][cName],vehinfo[Car][cVehid],x);
if(vehinfo[Car][cSQLId] == 0)format(string, sizeof(string), ""), x--;
if(x > 0) ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "Vehicles", string, "Select", "Close");

if(x == 0) ShowPlayerDialog(playerid, 200, DIALOG_STYLE_LIST, "Vehicles", "you have no vehicles", "Back", "Back");

}
}
return 1;
}

function OnPlayerLogin(playerid,password[])
{
	MySQLCheckConnection();
	new playernamesplit[3][MAX_PLAYER_NAME], pass[160];
	pass = GetString(playerid, "Password");
	split(GetPlayerNameEx(playerid), playernamesplit, '_');
	MySQLFetchAcctSingle(GetPVarInt(playerid, "SQLID"), "password", pass);
	if(strcmp(pass, password, true)== 0)
	{
		new Data[1024];
		new Field[64];
		new Line = 1;
		MySQLFetchAcctRecord(GetPVarInt(playerid, "SQLID"), Data);
		samp_mysql_strtok(Field, "|", Data);
		while (samp_mysql_strtok(Field, "|", "")==1)
		{
			if (Line == 3) SetPVarInt(playerid, "Admin",strval(Field));
			if (Line == 4) SetPVarInt(playerid, "Cash",strval(Field));
			if (Line == 5) SetPVarInt(playerid, "FlyLicense",strval(Field));
			if (Line == 6) SetPVarInt(playerid, "Spent",strval(Field));
			if (Line == 7) SetPVarInt(playerid, "Earned",strval(Field));
			if (Line == 8) SetPVarInt(playerid, "Hours",strval(Field));
			if (Line == 9) SetPVarInt(playerid, "Minutes",strval(Field));
			if (Line == 10) SetPVarInt(playerid, "Seconds",strval(Field));
			if (Line == 11) SetPVarFloat(playerid, "fX",strval(Field));
			if (Line == 12) SetPVarFloat(playerid, "fY",strval(Field));
			if (Line == 13) SetPVarFloat(playerid, "fZ",strval(Field));
			if (Line == 14) SetPVarInt(playerid, "Interior",strval(Field));
			if (Line == 15) SetPVarInt(playerid, "VirtualWorld",strval(Field));
			if (Line == 16) SetPVarInt(playerid, "HouseIn",strval(Field));
			if (Line == 17) SetPVarInt(playerid, "Crashed",strval(Field));
			if (Line == 18) SetPVarInt(playerid, "Vehicle0",strval(Field));
			if (Line == 19) SetPVarInt(playerid, "Vehicle1",strval(Field));
			if (Line == 20) SetPVarInt(playerid, "Vehicle2",strval(Field));
			if (Line == 21) SetPVarInt(playerid, "Vehicle3",strval(Field));
			if (Line == 22) SetPVarInt(playerid, "Vehicle4",strval(Field));
			if (Line == 23) SetPVarInt(playerid, "Vehicle5",strval(Field));
			if (Line == 24) SetPVarInt(playerid, "HotWireSkill",strval(Field));
			if (Line == 25) SetPVarInt(playerid, "Skin",strval(Field));
			if (Line == 26) SetPVarInt(playerid, "Donator",strval(Field));
			if (Line == 27) SetPVarInt(playerid, "BuildingIn",strval(Field));
			if (Line == 28) SetPVarInt(playerid, "Step",strval(Field));
			if (Line == 29) SetPVarInt(playerid, "Gender",strval(Field));
			if (Line == 30) SetPVarInt(playerid, "Age",strval(Field));
			if (Line == 31) SetPVarInt(playerid, "Team",strval(Field));
			if (Line == 32) SetPVarInt(playerid, "BeenInGame",strval(Field));
			if (Line == 33) SetPVarInt(playerid, "Exp",strval(Field));
			if (Line == 34) SetPVarString(playerid,"Rank",Field);
			if (Line == 35) SetPVarString(playerid,"Gang",Field);
			if (Line == 36) SetPVarInt(playerid,"GangId", strval(Field));
			if (Line == 37) SetPVarInt(playerid,"TestStep", strval(Field));
			if (Line == 38) SetPVarInt(playerid,"License", strval(Field));
			if (Line == 39) SetPVarInt(playerid,"HotWireKey", strval(Field));
			if (Line == 40) SetPVarInt(playerid,"Number", strval(Field));
			if (Line == 41) SetPVarInt(playerid,"DT", strval(Field));
			if (Line == 42) SetPVarInt(playerid,"WorkDone", strval(Field));
			if (Line == 43) SetPVarInt(playerid,"Checks", strval(Field));
			if (Line == 44) SetPVarInt(playerid,"WorkTime", strval(Field));
			if (Line == 45) SetPVarInt(playerid,"Bank", strval(Field));
			if (Line == 46) SetPVarInt(playerid,"BankCode", strval(Field));
			if (Line == 47) SetPVarInt(playerid,"Watch", strval(Field));
			if (Line == 48) SetPVarInt(playerid,"JailTime", strval(Field));
			if (Line == 49) SetPVarInt(playerid,"GunLicense", strval(Field));
			if (Line == 50) SetPVarInt(playerid,"Gun1", strval(Field));
			if (Line == 51) SetPVarInt(playerid,"Gun2", strval(Field));
			if (Line == 52) SetPVarInt(playerid,"Gun3", strval(Field));
			if (Line == 53) SetPVarInt(playerid,"Gun4", strval(Field));
			if (Line == 54) SetPVarInt(playerid,"Gun5", strval(Field));
			if (Line == 55) SetPVarInt(playerid,"Gun6", strval(Field));
			if (Line == 56) SetPVarInt(playerid,"Ammo1", strval(Field));
			if (Line == 57) SetPVarInt(playerid,"Ammo2", strval(Field));
			if (Line == 58) SetPVarInt(playerid,"Ammo3", strval(Field));
			if (Line == 59) SetPVarInt(playerid,"Ammo4", strval(Field));
			if (Line == 60) SetPVarInt(playerid,"Ammo5", strval(Field));
			if (Line == 61) SetPVarInt(playerid,"Ammo6", strval(Field));
			if (Line == 62) SetPVarInt(playerid,"RentId", strval(Field));
			if (Line == 63) SetPVarInt(playerid,"ShareId", strval(Field));
			if (Line == 64) SetPVarString(playerid,"Email",Field);
			if (Line == 65) SetPVarInt(playerid,"HasSeed", strval(Field));
			if (Line == 66) SetPVarInt(playerid,"Drugs", strval(Field));
			Line++;
		}
	}
	else
	{
		SendMessage(playerid, "SYSTEM: That Password Is Incorrect, Please Enter The Correct Password.");
		SetPVarInt(playerid, "LoginTrys", GetPVarInt(playerid, "LoginTrys") +1);
		new s[90];
		format(s,sizeof(s),"WRONG PASSWORD! for user name: %s\n\nPlease Try again %d/4 Try's Used",GetPlayerNameEx(playerid),GetPVarInt(playerid, "LoginTrys"));
		ShowPlayerDialog(playerid,1,DIALOG_STYLE_INPUT,"Logon to your account",s,"Logon","Back");
        if(GetPVarInt(playerid, "LoginTrys") == 5) Kick(playerid);
		return 1;
	}
	if(GetPVarInt(playerid, "Step") < 7)SetPVarInt(playerid, "Step", 0);
	if(CheckGang(GetString(playerid, "Gang")) == 0 && strcmp(GetString(playerid, "Gang"),"Nothing",true))
	{
	SetPVarInt(playerid, "GangId", 0);
	SetPVarString(playerid, "Gang", "Nothing");
	SendMessage(playerid, "You was removed from your gang as the gang leader deleted their gang.");
	}
	SetPlayerCash(playerid, GetPVarInt(playerid, "Cash"));
	new ipaddress[16];
	GetPlayerIp(playerid,ipaddress,sizeof(ipaddress));
	MySQLAddLoginRecord(GetPVarInt(playerid, "SQLID"), ipaddress);
	SpawnPlayer(playerid);
	SetPVarInt(playerid, "LoggedIn", 1);
	SetPlayerDrunkLevel(playerid, 0);
	SetPVarString(playerid, "Password", pass);
	if(GetPVarFloat(playerid,"fX") == 0.000000 && GetPVarFloat(playerid,"fY") == 0.000000 && GetPVarFloat(playerid,"fZ") == 0.000000)
	{
    SetPVarFloat(playerid,"fX", 12);
    SetPVarFloat(playerid,"fY", 12);
    SetPVarFloat(playerid,"fZ", 12);
    SetPVarInt(playerid, "Interior", 0);
    SetPVarInt(playerid, "VirtualWorld", 0);
    }
    if(GetPVarInt(playerid, "BeenInGame") == 0)
    {
    SetPVarInt(playerid, "BeenInGame", 1);
    SetPlayerCash(playerid, 200);
    SendMessage(playerid, "This is your first time on this server you were given $200 to start you off.");
    SetPVarString(playerid,"Rank", "Nothing");
    SetPVarString(playerid,"Gang", "Nothing");
    SetPVarInt(playerid, "Team", civ);
    }
    SetPVarString(playerid, "TextMessage", "You don't have any last received message");
    if(GetPVarInt(playerid,"ScreenTimer") != 0) KillTimer(GetPVarInt(playerid, "ScreenTimer")), SetPVarInt(playerid, "Turned", 0), SetPVarInt(playerid, "InScreen", 0);
    new str[10];
    format(str, sizeof(str), "ID: %d",playerid);
    SetPVarInt(playerid,"IDLogo", _:CreateDynamic3DTextLabel(str, 0xFF6C00FF, 0.0, 0.0,0.0+0.5,60,playerid));
    SetPlayerTime(playerid, worldhour, 0);
    Online(GetPVarInt(playerid, "SQLID"), 1);
	GiveRentMoney(playerid);
	if(GetPVarInt(playerid, "Step") == 7) ShowToDoList(playerid);
	SetShotingSkill(playerid);
	new playernamebancheck = MySQLCheckNameBanned(GetPlayerNameSave(playerid));
	if(playernamebancheck != 0) return
	SendMessage(playerid, "You were kicked due to your name is banned please contact an admin if this message is an error."),
	SendMessage(playerid, "To try to resolve your ban you can go to www.city-rp.com."),
	Kick(playerid);
	return 1;
}

function OnPlayerRegister(playerid, password[])
{
	if(IsPlayerConnected(playerid))
	{
		MySQLCheckConnection();
		new newaccountsqlid = MySQLCreateAccount(GetPlayerNameSave(playerid), password);
		if (newaccountsqlid != 0)
		{
			SetPVarInt(playerid, "SQLID", newaccountsqlid);
			SetPVarString(playerid, "Password",password);
			OnUpdatePlayer(playerid);
			SendMessage(playerid, "Your account was made successfully");
			return 1;
		}
		else
		{
			SendMessage(playerid, "There was an error creating your account. You will be disconnected now.");
			Kick(playerid);
			return 0;
		}
	}
	return 0;
}

function OnUpdatePlayer(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	if(GetPVarInt(playerid,"LoggedIn") == 1)
	{
			MySQLCheckConnection();
			new query[MAX_STRING];
			new int, world;
			int = GetPlayerInterior(playerid);
			world = GetPlayerVirtualWorld(playerid);
			new Float:x,Float:y,Float:z;
            GetPlayerPos(playerid, x, y, z);
			format(query, MAX_STRING, "UPDATE players SET ");
			MySQLUpdatePlayerStr(query, GetPVarInt(playerid, "SQLID"), "password", GetString(playerid, "Password"));
			SetPVarInt(playerid, "Cash", GetPlayerCash(playerid));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "admin", GetPVarInt(playerid, "Admin"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "wallet", GetPVarInt(playerid, "Cash"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "flylicense", GetPVarInt(playerid, "FlyLicense"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "spent", GetPVarInt(playerid, "Spent"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "earned", GetPVarInt(playerid, "Earned"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "hours", GetPVarInt(playerid, "Hours"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "minutes", GetPVarInt(playerid, "Minutes"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "seconds", GetPVarInt(playerid, "Seconds"));
			MySQLUpdatePlayerFlo(query, GetPVarInt(playerid, "SQLID"), "X", x);
			MySQLUpdatePlayerFlo(query, GetPVarInt(playerid, "SQLID"), "Y", y);
			MySQLUpdatePlayerFlo(query, GetPVarInt(playerid, "SQLID"), "Z", z);
            SetPVarInt(playerid, "Interior", int);
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "interior", GetPVarInt(playerid, "Interior"));
            SetPVarInt(playerid, "VirtualWorld", world);
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "virtualworld", GetPVarInt(playerid, "VirtualWorld"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "housein", GetPVarInt(playerid, "HouseIn"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "crashed", GetPVarInt(playerid, "Crashed"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "vehicle1", GetPVarInt(playerid, "Vehicle0"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "vehicle2", GetPVarInt(playerid, "Vehicle1"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "vehicle3", GetPVarInt(playerid, "Vehicle2"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "vehicle4", GetPVarInt(playerid, "Vehicle3"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "vehicle5", GetPVarInt(playerid, "Vehicle4"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "vehicle6", GetPVarInt(playerid, "Vehicle5"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "hotwireskill", GetPVarInt(playerid, "HotWireSkill"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "skin", GetPVarInt(playerid, "Skin"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "donator", GetPVarInt(playerid, "Donator"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "Buildingin", GetPVarInt(playerid, "BuildingIn"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "step", GetPVarInt(playerid, "Step"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "gender", GetPVarInt(playerid, "Gender"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "age", GetPVarInt(playerid, "Age"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "team", GetPVarInt(playerid, "Team"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "beeningame", GetPVarInt(playerid, "BeenInGame"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "exp", GetPVarInt(playerid, "Exp"));
			MySQLUpdatePlayerStr(query, GetPVarInt(playerid, "SQLID"), "rank", GetString(playerid, "Rank"));
			MySQLUpdatePlayerStr(query, GetPVarInt(playerid, "SQLID"), "gang", GetString(playerid, "Gang"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "gangid", GetPVarInt(playerid, "GangId"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "teststep", GetPVarInt(playerid, "TestStep"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "license", GetPVarInt(playerid, "License"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "hotwirekey", GetPVarInt(playerid, "HotWireKey"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "number", GetPVarInt(playerid, "Number"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "drivingtest", GetPVarInt(playerid, "DT"));
			MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "workdone", GetPVarInt(playerid, "WorkDone"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "checks", GetPVarInt(playerid, "Checks"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "worktime", GetPVarInt(playerid, "WorkTime"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "bank", GetPVarInt(playerid, "Bank"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "bankcode", GetPVarInt(playerid, "BankCode"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "watch", GetPVarInt(playerid, "Watch"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "jailtime", GetPVarInt(playerid, "JailTime"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "gunlicense", GetPVarInt(playerid, "GunLicense"));
            SaveGuns(playerid);
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "gun1", GetPVarInt(playerid, "Gun1"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "gun2", GetPVarInt(playerid, "Gun2"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "gun3", GetPVarInt(playerid, "Gun3"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "gun4", GetPVarInt(playerid, "Gun4"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "gun5", GetPVarInt(playerid, "Gun5"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "gun6", GetPVarInt(playerid, "Gun6"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "ammo1", GetPVarInt(playerid, "Ammo1"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "ammo2", GetPVarInt(playerid, "Ammo2"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "ammo3", GetPVarInt(playerid, "Ammo3"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "ammo4", GetPVarInt(playerid, "Ammo4"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "ammo5", GetPVarInt(playerid, "Ammo5"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "ammo6", GetPVarInt(playerid, "Ammo6"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "rentid", GetPVarInt(playerid, "RentId"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "shareid", GetPVarInt(playerid, "ShareId"));
            MySQLUpdatePlayerStr(query, GetPVarInt(playerid, "SQLID"), "emailaddress", GetString(playerid, "Email"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "hasseed", GetPVarInt(playerid, "HasSeed"));
            MySQLUpdatePlayerInt(query, GetPVarInt(playerid, "SQLID"), "drugs", GetPVarInt(playerid, "Drugs"));
			MySQLUpdateFinish(query, GetPVarInt(playerid, "SQLID"));
			}
	}
	return 1;
}

function SaveGuns(playerid)
{
new were[15], weapon,ammo;
for(new i = 1;i<7;i++)
{
format(were,sizeof were,"Gun%i",i);
GetPlayerWeaponData(playerid,i,weapon,ammo);
if(ammo < 0) ammo = 2;
//printf(were);
SetPVarInt(playerid,were,weapon);
format(were,sizeof were,"Ammo%i",i);
SetPVarInt(playerid,were,ammo);
//printf(were);
}
return 1;
}

function ShowTextDrawSkin(playerid)
{
PlayerPlaySound(playerid, 1062, 0.0, 0.0, 0.0);
if(GetPVarInt(playerid,"ClassText") == 0)
{
SetPVarInt(playerid, "ClassText", _:TextDrawCreate(21.000000,109.000000, "~N~Each Skin Cost $30 To Buy.~N~ ~N~"));
TextDrawUseBox(Text:GetPVarInt(playerid, "ClassText"),1);
TextDrawBoxColor(Text:GetPVarInt(playerid, "ClassText"),0x00000066);
TextDrawTextSize(Text:GetPVarInt(playerid, "ClassText"),291.000000,-5.000000);
TextDrawAlignment(Text:GetPVarInt(playerid, "ClassText"),0);
TextDrawBackgroundColor(Text:GetPVarInt(playerid, "ClassText"),0xff000066);
TextDrawFont(Text:GetPVarInt(playerid, "ClassText"),2);
TextDrawLetterSize(Text:GetPVarInt(playerid, "ClassText"),0.399999,1.500000);
TextDrawColor(Text:GetPVarInt(playerid, "ClassText"),0xffffffff);
TextDrawSetProportional(Text:GetPVarInt(playerid, "ClassText"),1);
TextDrawSetShadow(Text:GetPVarInt(playerid, "ClassText"),1);
TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid, "ClassText"));
}
return 1;
}


function OnPlayerRequestClass(playerid, classid)
{
	if(GetPVarInt(playerid, "LoggedIn") == 0)
	{
	SetTimerEx("spawn", 40, 0, "i", playerid);
	OnPlayerSpawn(playerid);
	return 1;
	}
	if(GetPVarInt(playerid, "Class2") == 0 && GetPVarInt(playerid, "Step") == 7)return SetTimerEx("spawn", 40, 0, "i", playerid), OnPlayerSpawn(playerid);
	if(GetPVarInt(playerid, "Class0") != 0)KillTimer(GetPVarInt(playerid, "Class0")), SetPVarInt(playerid, "Class0", 0);
	ClearTextDraws(playerid);
	SetPlayerInterior(playerid, 15);
	SetPlayerPos(playerid,217.4461,-97.7477,1005.2578);
	SetPlayerFacingAngle(playerid, 168.1032);
	SetPlayerCameraPos(playerid,213.8216,-103.1896,1005.6731+1);
	SetPlayerCameraLookAt(playerid,217.6219,-101.0985,1005.2578+1);
	SetPVarInt(playerid, "Class0", SetTimerEx("stopanim", 1200, false, "i", playerid));
	TogglePlayerControllable(playerid, 1);
	StartFade(playerid);
	ApplyAnimation(playerid,"PED","WALK_player",4.1,1,1,1,1,3000);
	ShowTextDrawSkin(playerid);
	return 1;
}

function OnPlayerSpawn(playerid)
{
    if(IsPlayerNPC(playerid)){return 1;}
    if(GetPVarInt(playerid, "LoggingOut") == 1)
    {
    SetPVarInt(playerid, "LoggedIn", 0);
    SetPVarInt(playerid, "LoggingOut", 0);
    SetPVarInt(playerid, "changeok", 1);
    SetTimerEx("ShowScreen", 200, 0, "i", playerid);
	SetPVarInt(playerid, "RQC", 1);
	SetPlayerInterior(playerid,0);
	Streamer_UpdateEx(playerid, 2293.5728,2159.0708,10.8203);
	SetPVarInt(playerid, "WereSpecing", 0);
    return 1;
    }
    if(GetPVarInt(playerid, "Step") == 7 && GetPVarInt(playerid, "Class2") == 0) SetPlayerSkin(playerid, GetPVarInt(playerid, "Skin"));

    if(GetPVarInt(playerid, "Step") == 6 && GetPVarInt(playerid, "HereOn1") == 1)
	{
    StartFade(playerid);
    if(GetPVarInt(playerid, "IntroTimer") != 0) KillTimer(GetPVarInt(playerid, "IntroTimer"));
    new seat = 1 + random(60);
    PutPlayerInVehicle(playerid, 1, seat);
    RemovePlayerFromVehicle(playerid);
    SetPVarInt(playerid, "Step", 7);
    SetPVarInt(playerid, "HereOn1", 0);
    TogglePlayerControllable(playerid, 1);
    ClearChatbox(playerid, 10);
    new skin1 = GetPlayerSkin(playerid);
    SetPVarInt(playerid,"Skin", skin1);
    SendMessage(playerid,"You arrived at Los Santos bus station");
    OnUpdatePlayer(playerid);
    TextDrawHideForPlayer(playerid, Window[0]);
	TextDrawHideForPlayer(playerid, Window[1]);
	ShowToDoList(playerid);
    return 1;
    }
    if(GetPVarInt(playerid, "Step") == 6 && GetPVarInt(playerid, "HereOn1") == 2 && GetPVarInt(playerid, "TS") == 2)
	{
    StartFade(playerid);
    if(GetPVarInt(playerid, "IntroTimer") != 0) KillTimer(GetPVarInt(playerid, "IntroTimer"));
    TogglePlayerControllable(playerid, 1);
    SetPlayerPos(playerid, 1713.1414,-1949.3832,14.1172);
    SetPlayerFacingAngle(playerid, 352.5446);
    SetPVarInt(playerid, "Step", 7);
    SetPVarInt(playerid, "HereOn1", 0);
    new skin1 = GetPlayerSkin(playerid);
    SetPVarInt(playerid,"Skin", skin1);
    ClearChatbox(playerid, 10);
    SendMessage(playerid,"Your train arrived at Unity station.");
    SetCameraBehindPlayer(playerid);
    OnUpdatePlayer(playerid);
    TextDrawHideForPlayer(playerid, Window[0]);
	TextDrawHideForPlayer(playerid, Window[1]);
	ShowToDoList(playerid);
    return 1;
    }
    if(GetPVarInt(playerid, "Step") == 6 && GetPVarInt(playerid, "HereOn1") == 2 && GetPVarInt(playerid, "TS") == 1)
	{
    StartFade(playerid);
    if(GetPVarInt(playerid, "IntroTimer") != 0) KillTimer(GetPVarInt(playerid, "IntroTimer"));
    TogglePlayerControllable(playerid, 1);
    SetPlayerPos(playerid, 822.5925,-1362.2693,-0.5078);
    SetPlayerFacingAngle(playerid, 316.8243);
    SetPVarInt(playerid, "Step", 7);
    SetPVarInt(playerid, "HereOn1", 0);
    ClearChatbox(playerid, 10);
    new skin1 = GetPlayerSkin(playerid);
    SetPVarInt(playerid,"Skin", skin1);
    SendMessage(playerid,"Your train arrived at Market station.");
    SetCameraBehindPlayer(playerid);
    OnUpdatePlayer(playerid);
    TextDrawHideForPlayer(playerid, Window[0]);
	TextDrawHideForPlayer(playerid, Window[1]);
	ShowToDoList(playerid);
    return 1;
    }
    if(GetPVarInt(playerid, "Step") == 6 && GetPVarInt(playerid, "HereOn1") == 3)
	{
    StartFade(playerid);
    if(GetPVarInt(playerid, "IntroTimer") != 0) KillTimer(GetPVarInt(playerid, "IntroTimer"));
    TogglePlayerControllable(playerid, 1);
    SetPlayerPos(playerid, 1981.6273,-2468.9521,13.5469);
    SetPlayerFacingAngle(playerid, 2.5278);
    SetPVarInt(playerid, "Step", 7);
    SetPVarInt(playerid, "HereOn1", 0);
    ClearChatbox(playerid, 10);
    new skin1 = GetPlayerSkin(playerid);
    SetPVarInt(playerid,"Skin", skin1);
    SendMessage(playerid,"Your Plane arrived at Los Santos airport.");
    SetCameraBehindPlayer(playerid);
    OnUpdatePlayer(playerid);
    TextDrawHideForPlayer(playerid, Window[0]);
	TextDrawHideForPlayer(playerid, Window[1]);
	ShowToDoList(playerid);
    return 1;
    }
    if(GetPVarInt(playerid,"Class2") == 1)
	{
	PlayerPlaySound(playerid, 1069, 0.0, 0.0, 0.0);
	ClearTextDraws(playerid);
	SetPVarInt(playerid,"Class2", 0);
	SetPlayerInterior(playerid,15);
	SetPlayerPos(playerid, 207.7722,-101.8833,1005.2578);
	SetPVarInt(playerid,"Skin", GetPlayerSkin(playerid));
	GivePlayerCash(playerid, -30);
	SetPVarInt(playerid, "WereSpecing", 0);
	return 1;
	}
	if(GetPVarInt(playerid, "LoggedIn") == 0 && GetPVarInt(playerid, "RQC") == 0)
	{
	SetTimerEx("ShowScreen", 200, 0, "i", playerid);
	SetPVarInt(playerid, "RQC", 1);
	SetPlayerInterior(playerid,0);
	Streamer_UpdateEx(playerid, 2293.5728,2159.0708,10.8203);
	return 1;
	}
	if(GetPVarInt(playerid, "RQC") == 1 && GetPVarInt(playerid, "LoggedIn") == 0) return 1;
	if(GetPVarInt(playerid, "Crashed") == 1)
	{
	SetPlayerVirtualWorld(playerid,GetPVarInt(playerid, "VirtualWorld"));
    SetPlayerInterior(playerid,GetPVarInt(playerid, "Interior"));
	SetPlayerPos(playerid, GetPVarFloat(playerid,"fX"), GetPVarFloat(playerid,"fY"), GetPVarFloat(playerid,"fZ"));
	SetPVarInt(playerid, "Crashed", 0);
	OnUpdatePlayer(playerid);
	return 1;
	}
    if(GetPVarInt(playerid, "JailTime") != 0)
    {
    new rand = random(sizeof(JailPos)), string[60];
	SetPlayerPos(playerid, JailPos[rand][0], JailPos[rand][1], JailPos[rand][2]);
	format(string, sizeof(string), "You still have %d minutes to serve witch is %d seconds",GetPVarInt(playerid, "JailTime")/60,GetPVarInt(playerid, "JailTime"));
	SendMessage(playerid, string);
    if(GetPVarInt(playerid, "JailTimer") == 0)SetPVarInt(playerid, "JailTimer", SetTimerEx("Jail", 1000, 1, "i", playerid));
	SetPlayerVirtualWorld(playerid, 6890);
	SetPlayerInterior(playerid, 3);
	SetPVarInt(playerid, "BuildingIn", 1);
	SetPVarInt(playerid, "WereSpecing", 0);
    return 1;
    }
	if(GetPVarInt(playerid, "WereSpecing") == 1)
	{
	ClearAnimations(playerid);
	TogglePlayerSpectating(playerid, 1);
	SetPlayerVirtualWorld(playerid, 0);
    SetPlayerInterior(playerid, 0);
	PlayerSpectateVehicle(playerid, 7);
	SetPlayerDrunkLevel(playerid, 10000);
    TextDrawShowForPlayer(playerid, Window[0]);
	TextDrawShowForPlayer(playerid, Window[1]);
	SetPlayerHealth(playerid, 100);
	SetPVarInt(playerid, "WereSpecing", 2);
	if(GetPVarInt(playerid, "Watch") == 1) TextDrawHideForPlayer(playerid,TimeText1), TextDrawHideForPlayer(playerid,TimeText);
	return 1;
	}
	if(GetPVarInt(playerid, "Dead") == 1) return SetPVarInt(playerid, "Dead", 0);
	MainSpawn(playerid);
	return 1;
}

function MainSpawn(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	if(GetPVarInt(playerid, "TestTime") > 0 && GetPVarInt(playerid, "CopTestVar") != 0)
	{
    SetPVarInt(playerid, "TestTime", 0);
    ClearCopTest(playerid);
	return 1;
	}
	if(GetPVarInt(playerid, "TestTime") > 0 && GetPVarInt(playerid, "DrivingTestVar") != 0)
	{
    SetPVarInt(playerid, "TestTime", 0);
    ClearDrivingTest(playerid);
	return 1;
	}
	if(GetPVarInt(playerid, "Step") == 0)
	{
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid,825.9380,-1355.3527,13.5410);
	SetPlayerFacingAngle(playerid, 46.2702);
	SetPlayerCameraPos(playerid,824.0208,-1353.2679,14.7809);
	SetPlayerCameraLookAt(playerid,825.9380,-1355.3527,13.5410);
	ClearChatbox(playerid, 10);
	StartFade(playerid);
	TogglePlayerControllable(playerid, 0);
	ShowPlayerDialog(playerid,9,DIALOG_STYLE_MSGBOX,"Gender Pick","Are you male or female?","Male","Female");

	SetPVarInt(playerid, "RegLogo", _:TextDrawCreate(427.000000,159.000000,"City RP"));
	TextDrawAlignment(Text:GetPVarInt(playerid,"RegLogo"),0);
	TextDrawBackgroundColor(Text:GetPVarInt(playerid,"RegLogo"),0xff0000cc);
	TextDrawFont(Text:GetPVarInt(playerid,"RegLogo"),3);
	TextDrawLetterSize(Text:GetPVarInt(playerid,"RegLogo"),1.000000,3.800002);
	TextDrawColor(Text:GetPVarInt(playerid,"RegLogo"),0xffff0099);
	TextDrawSetProportional(Text:GetPVarInt(playerid,"RegLogo"),1);
    TextDrawSetShadow(Text:GetPVarInt(playerid,"RegLogo"),2);

	SetPVarInt(playerid, "RegGender", _:TextDrawCreate(481.000000,206.000000,"_"));
	TextDrawAlignment(Text:GetPVarInt(playerid,"RegGender"),0);
	TextDrawBackgroundColor(Text:GetPVarInt(playerid,"RegGender"),0x000000ff);
	TextDrawFont(Text:GetPVarInt(playerid,"RegGender"),1);
	TextDrawLetterSize(Text:GetPVarInt(playerid,"RegGender"),0.499999,1.000000);
	TextDrawColor(Text:GetPVarInt(playerid,"RegGender"),0xffffffff);
	TextDrawSetOutline(Text:GetPVarInt(playerid,"RegGender"),1);
	TextDrawSetProportional(Text:GetPVarInt(playerid,"RegGender"),1);
	TextDrawSetShadow(Text:GetPVarInt(playerid,"RegGender"),1);
	
	
	SetPVarInt(playerid, "RegAge", _:TextDrawCreate(451.000000,223.000000,"_"));
	TextDrawAlignment(Text:GetPVarInt(playerid,"RegAge"),0);
	TextDrawBackgroundColor(Text:GetPVarInt(playerid,"RegAge"),0x000000ff);
	TextDrawFont(Text:GetPVarInt(playerid,"RegAge"),1);
	TextDrawLetterSize(Text:GetPVarInt(playerid,"RegAge"),0.399999,1.200000);
	TextDrawColor(Text:GetPVarInt(playerid,"RegAge"),0xffffffff);
	TextDrawSetOutline(Text:GetPVarInt(playerid,"RegAge"),1);
	TextDrawSetProportional(Text:GetPVarInt(playerid,"RegAge"),1);
	TextDrawSetShadow(Text:GetPVarInt(playerid,"RegAge"),1);
	
	
	SetPVarInt(playerid, "RegArrive", _:TextDrawCreate(495.000000,242.000000,"_"));
	TextDrawAlignment(Text:GetPVarInt(playerid,"RegArrive"),0);
    TextDrawBackgroundColor(Text:GetPVarInt(playerid,"RegArrive"),0x000000ff);
    TextDrawFont(Text:GetPVarInt(playerid,"RegArrive"),1);
    TextDrawLetterSize(Text:GetPVarInt(playerid,"RegArrive"),0.499999,1.300000);
    TextDrawColor(Text:GetPVarInt(playerid,"RegArrive"),0xffffffff);
    TextDrawSetOutline(Text:GetPVarInt(playerid,"RegArrive"),1);
    TextDrawSetProportional(Text:GetPVarInt(playerid,"RegArrive"),1);
    TextDrawSetShadow(Text:GetPVarInt(playerid,"RegArrive"),1);
    
    TextDrawShowForPlayer(playerid, RegBox[0]);
    TextDrawShowForPlayer(playerid, RegBox[1]);
    TextDrawShowForPlayer(playerid, RegBox[2]);
    TextDrawShowForPlayer(playerid, RegBox[3]);
    TextDrawShowForPlayer(playerid, RegBox[4]);
    TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid,"RegLogo"));
    TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid,"RegGender"));
    TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid,"RegAge"));
    TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid,"RegArrive"));
	return 1;
	}
	if(GetPVarInt(playerid, "Step") == 1)
	{
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid,825.9380,-1355.3527,13.5410);
	SetPlayerFacingAngle(playerid, 46.2702);
	SetPlayerCameraPos(playerid,824.0208,-1353.2679,14.7809);
	SetPlayerCameraLookAt(playerid,825.9380,-1355.3527,13.5410);
	StartFade(playerid);
	ShowPlayerDialog(playerid,10,DIALOG_STYLE_INPUT,"Age selection","Please enter your age","Enter","Back");
	return 1;
	}
	if(GetPVarInt(playerid, "Step") == 2)
	{
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid,825.9380,-1355.3527,13.5410);
	SetPlayerFacingAngle(playerid, 46.2702);
	SetPlayerCameraPos(playerid,824.0208,-1353.2679,14.7809);
	SetPlayerCameraLookAt(playerid,825.9380,-1355.3527,13.5410);
	StartFade(playerid);
	ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "How did you get here", "Coach\nTrain\nPlane", "Select", "Back");
	return 1;
	}
	if(GetPVarInt(playerid, "Step") == 3)
	{
	ShowPlayerDialog(playerid,81,DIALOG_STYLE_INPUT,"Please enter your email adress","Please enter your email adress \n\n'Example Name@hotmail.com'","Enter","Back");
	return 1;
	}
	if(GetPVarInt(playerid, "Step") == 4)
	{
	SetPVarInt(playerid, "Step", 5);
	SetPlayerPos(playerid, 826.5002,-1355.4175,11.4910);
	SendMessage(playerid, "Now Pick Your Clothes.");
	SendMessage(playerid, " ");
	SendMessage(playerid, "Your first set of clothes are free.");
	ForceClassSelection(playerid);
	SetPlayerHealth(playerid,0);
	return 1;
	}
	if(GetPVarInt(playerid, "Step") == 5)
	{
	TextDrawHideForPlayer(playerid, RegBox[0]);
    TextDrawHideForPlayer(playerid, RegBox[1]);
	TextDrawHideForPlayer(playerid, RegBox[2]);
	TextDrawHideForPlayer(playerid, RegBox[3]);
	TextDrawHideForPlayer(playerid, RegBox[4]);
	TextDrawDestroy(Text:GetPVarInt(playerid, "RegLogo"));
	TextDrawDestroy(Text:GetPVarInt(playerid, "RegGender"));
	TextDrawDestroy(Text:GetPVarInt(playerid, "RegAge"));
	TextDrawDestroy(Text:GetPVarInt(playerid, "RegArrive"));
	if(GetPVarInt(playerid, "HereOn0") == 1)
	{
	SetPVarInt(playerid, "Step", 6);
	OnUpdatePlayer(playerid);
	SetPlayerVirtualWorld(playerid, 0);
    SetPlayerInterior(playerid, 0);
    ClearTextDraws(playerid);
	StartFade(playerid);
	SetPVarInt(playerid, "HereOn1", 1);
	TogglePlayerSpectating(playerid, 1);
	PlayerSpectateVehicle(playerid, 1);
	GameTextForPlayer(playerid, "~w~You are now arriving by Coach.", 3000, 3);
	PlayerPlaySound(playerid, 1069, 0.0, 0.0, 0.0);
	TextDrawShowForPlayer(playerid, Window[0]);
	TextDrawShowForPlayer(playerid, Window[1]);
	SetPVarInt(playerid, "IntroTimer", SetTimerEx("NPCControl", 1000, 1, "ii", playerid));
	}
	if(GetPVarInt(playerid, "HereOn0") == 2)
	{
	SetPVarInt(playerid, "Step", 6);
	OnUpdatePlayer(playerid);
	SetPlayerVirtualWorld(playerid, 0);
    SetPlayerInterior(playerid, 0);
    ClearTextDraws(playerid);
	StartFade(playerid);
	TogglePlayerSpectating(playerid, 1);
	PlayerSpectateVehicle(playerid, 2);
	SetPVarInt(playerid, "HereOn1", 2);
	GameTextForPlayer(playerid, "~w~You are now arriving by Train.", 3000, 3);
	PlayerPlaySound(playerid, 1069, 0.0, 0.0, 0.0);
	TextDrawShowForPlayer(playerid, Window[0]);
	TextDrawShowForPlayer(playerid, Window[1]);
	SetPVarInt(playerid, "IntroTimer", SetTimerEx("NPCControl", 1000, 1, "ii", playerid));
	}
	if(GetPVarInt(playerid, "HereOn0") == 3)
	{
	SetPVarInt(playerid, "Step", 6);
	OnUpdatePlayer(playerid);
	SetPlayerVirtualWorld(playerid, 0);
    SetPlayerInterior(playerid, 0);
    ClearTextDraws(playerid);
	StartFade(playerid);
	TogglePlayerSpectating(playerid, 1);
	PlayerSpectateVehicle(playerid, 6);
	SetPVarInt(playerid, "HereOn1", 3);
	GameTextForPlayer(playerid, "~w~You are now arriving by Plane.", 3000, 3);
	PlayerPlaySound(playerid, 1069, 0.0, 0.0, 0.0);
	TextDrawShowForPlayer(playerid, Window[0]);
	TextDrawShowForPlayer(playerid, Window[1]);
	SetPVarInt(playerid, "IntroTimer", SetTimerEx("NPCControl", 1000, 1, "ii", playerid));
	}
	return 1;
	}
    TogglePlayerControllable(playerid, 1);
    SetPlayerInterior(playerid,0);
  	SetPlayerVirtualWorld(playerid, 0);
    SetPlayerDrunkLevel(playerid, 0);
	new rand = random(sizeof(SpawnPos));
	SetPlayerPos(playerid, SpawnPos[rand][0], SpawnPos[rand][1], SpawnPos[rand][2]);
	SetPlayerFacingAngle(playerid, SpawnPos[rand][3]);
	if(GetPVarInt(playerid, "Watch") == 1) TextDrawShowForPlayer(playerid, TimeText1), TextDrawShowForPlayer(playerid, TimeText);
    GiveGuns(playerid);
    if(GetPVarInt(playerid, "GangId") > 0)
    {
    new id = GetPVarInt(playerid, "GangId");
    if(GangInfo[id][gGuns1] != 0 && GetPVarInt(playerid, "Gun1") == 0) GivePlayerWeapon(playerid, GangInfo[id][gGuns1], 50);
    if(GangInfo[id][gGuns2] != 0 && GetPVarInt(playerid, "Gun2") == 0) GivePlayerWeapon(playerid, GangInfo[id][gGuns2], 50);
    if(GangInfo[id][gGuns3] != 0 && GetPVarInt(playerid, "Gun3") == 0) GivePlayerWeapon(playerid, GangInfo[id][gGuns3], 50);
    if(GangInfo[id][gGuns4] != 0 && GetPVarInt(playerid, "Gun4") == 0) GivePlayerWeapon(playerid, GangInfo[id][gGuns4], 50);
    if(GangInfo[id][gGuns5] != 0 && GetPVarInt(playerid, "Gun5") == 0) GivePlayerWeapon(playerid, GangInfo[id][gGuns5], 10);
    if(GangInfo[id][gGuns6] != 0 && GetPVarInt(playerid, "Gun6") == 0) GivePlayerWeapon(playerid, GangInfo[id][gGuns6], 10);

    }
    SendMessage(playerid, "Type /cpanel to access your user control panel.");
    return 1;
}

function ShowToDoList(playerid)
{
if(GetPVarInt(playerid, "Hours") < 1)
{
SetPVarInt(playerid, "ToDo", _:TextDrawCreate(21.000000,85.000000, "            To Do List:~N~ ~N~~W~1. Get your driving license~N~2. Get your weapons license~N~3. Open your bank account~N~4. Get a job~N~5. Buy a vehicle~N~6. Create a gang?~N~ ~N~ ~N~ ~N~ "));
TextDrawUseBox(Text:GetPVarInt(playerid, "ToDo"),1);
TextDrawBoxColor(Text:GetPVarInt(playerid, "ToDo"),0x00000066);
TextDrawTextSize(Text:GetPVarInt(playerid, "ToDo"),215.000000,-5.000000);
TextDrawAlignment(Text:GetPVarInt(playerid, "ToDo"),0);
TextDrawBackgroundColor(Text:GetPVarInt(playerid, "ToDo"),0x0000ffff);
TextDrawFont(Text:GetPVarInt(playerid, "ToDo"),1);
TextDrawLetterSize(Text:GetPVarInt(playerid, "ToDo"),0.299999,1.200000);
TextDrawColor(Text:GetPVarInt(playerid, "ToDo"),0xffffffff);
TextDrawSetProportional(Text:GetPVarInt(playerid, "ToDo"),1);
TextDrawSetShadow(Text:GetPVarInt(playerid, "ToDo"),1);
TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid, "ToDo"));


SetPVarInt(playerid, "ToDo1", _:TextDrawCreate(21.000000,190.000000,"                Hints:~N~ ~N~~W~1. Want to earn cash? buy share's in a building.~N~ ~N~2. Get your driving license and become a bin man.~N~ ~N~3. Do all your blue light test and shooting test to become a cop.~N~ ~N~4. Get your driving license and blue light license to become a Fire Man~N~ ~N~Hit the ALT key to close this."));
TextDrawUseBox(Text:GetPVarInt(playerid, "ToDo1"),1);
TextDrawBoxColor(Text:GetPVarInt(playerid, "ToDo1"),0x00000066);
TextDrawTextSize(Text:GetPVarInt(playerid, "ToDo1"),215.000000,134.000000);
TextDrawAlignment(Text:GetPVarInt(playerid, "ToDo1"),0);
TextDrawBackgroundColor(Text:GetPVarInt(playerid, "ToDo1"),0x00ffff99);
TextDrawFont(Text:GetPVarInt(playerid, "ToDo1"),1);
TextDrawLetterSize(Text:GetPVarInt(playerid, "ToDo1"),0.299999,1.200000);
TextDrawColor(Text:GetPVarInt(playerid, "ToDo1"),0xffffffff);
TextDrawSetProportional(Text:GetPVarInt(playerid, "ToDo1"),1);
TextDrawSetShadow(Text:GetPVarInt(playerid, "ToDo1"),1);
TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid, "ToDo1"));
}
return 1;
}

function GiveGuns(playerid)
{
GivePlayerWeapon(playerid, GetPVarInt(playerid, "Gun1"), GetPVarInt(playerid, "Ammo1"));
GivePlayerWeapon(playerid, GetPVarInt(playerid, "Gun2"), GetPVarInt(playerid, "Ammo2"));
GivePlayerWeapon(playerid, GetPVarInt(playerid, "Gun3"), GetPVarInt(playerid, "Ammo3"));
GivePlayerWeapon(playerid, GetPVarInt(playerid, "Gun4"), GetPVarInt(playerid, "Ammo4"));
GivePlayerWeapon(playerid, GetPVarInt(playerid, "Gun5"), GetPVarInt(playerid, "Ammo5"));
GivePlayerWeapon(playerid, GetPVarInt(playerid, "Gun6"), GetPVarInt(playerid, "Ammo6"));
return 1;
}

function ResetGuns(playerid)
{
SetPVarInt(playerid, "Gun1", 0);
SetPVarInt(playerid, "Gun2", 0);
SetPVarInt(playerid, "Gun3", 0);
SetPVarInt(playerid, "Gun4", 0);
SetPVarInt(playerid, "Gun5", 0);
SetPVarInt(playerid, "Gun6", 0);
SetPVarInt(playerid, "Ammo1", 0);
SetPVarInt(playerid, "Ammo2", 0);
SetPVarInt(playerid, "Ammo3", 0);
SetPVarInt(playerid, "Ammo4", 0);
SetPVarInt(playerid, "Ammo5", 0);
SetPVarInt(playerid, "Ammo6", 0);
return 1;
}

function ClearChatbox(playerid, lines)
{
	if (IsPlayerConnected(playerid))
	{
		for(new i=0; i<lines; i++)
		{
			SendMessage(playerid, " ");
		}
	}
	return 1;
}

function ShowScreen(playerid)
{
    if(GetPVarInt(playerid, "LoggedIn") == 0)
	{
	new world = 1 + random(60);
	SetPlayerInterior(playerid,0);
  	SetPlayerVirtualWorld(playerid, world);
	SetPlayerWeather(playerid, 1);
	SetWorldTime(worldhour);
    SetPlayerPos(playerid,2332.3706,-1724.1222,13.5408);
    SetPlayerFacingAngle(playerid, 89.5571);
    TogglePlayerControllable(playerid, 1);
    ApplyAnimation(playerid,"PED","WALK_player",4.1,1,1,1,1,0);
    SetPVarInt(playerid, "InScreen", 1);
    PlayerSpectatePlayer(playerid, playerid);
	SetPVarInt(playerid, "ScreenTimer", SetTimerEx("CheckPos", 5000, 1, "i", playerid));
    ChoseName(playerid);
    }
    return 1;
}

function CheckPos(playerid)
{
     if(GetPVarInt(playerid, "InScreen") == 1)
     {
     if(IsPlayerInRangeOfPoint(playerid, 3.0, 2297.4209,-1723.8558,13.5013) && GetPVarInt(playerid, "Turned") == 0)
     SetPlayerFacingAngle(playerid, 269.4121), SetPVarInt(playerid, "Turned", 1);

     if(IsPlayerInRangeOfPoint(playerid, 3.0, 2332.3706,-1724.1222,13.5408) && GetPVarInt(playerid, "Turned") == 1)
     SetPlayerFacingAngle(playerid, 89.5571),
      SetPVarInt(playerid, "Turned", 2),
     SendMessage(playerid,"You got 5 Seconds to login"),
     SetTimerEx("kickem", 5000, 0, "i", playerid);
	 }
	 return 1;
}

function ChoseName(playerid)
{
new name[26];
format(name, sizeof(name),"Chose_Name%d",playerid);
SetPlayerName(playerid, name);
if(GetPVarInt(playerid, "changeok") == 1) Online(GetPVarInt(playerid, "SQLID"), 0), SetPVarInt(playerid, "changeok", 0);
SetPVarInt(playerid, "SQLID", 0);
RestoreAll(playerid);
ShowPlayerDialog(playerid,57,DIALOG_STYLE_INPUT,"Account Name Selection","Please enter the name you wish to play with","Enter","Quit");
return 1;
}

function RestoreAll(playerid)
{
SetPVarInt(playerid, "Admin", 0);
SetPVarInt(playerid, "Cash", 0);
SetPVarInt(playerid, "FlyLicense", 0);
SetPVarInt(playerid, "Spent", 0);
SetPVarInt(playerid, "Earned", 0);
SetPVarInt(playerid, "Hours", 0);
SetPVarInt(playerid, "Minutes", 0);
SetPVarInt(playerid, "Seconds", 0);
SetPVarFloat(playerid, "fX", 0);
SetPVarFloat(playerid, "fY", 0);
SetPVarFloat(playerid, "fZ", 0);
SetPVarInt(playerid, "Interior", 0);
SetPVarInt(playerid, "VirtualWorld", 0);
SetPVarInt(playerid, "HouseIn", 0);
SetPVarInt(playerid, "Crashed", 0);
SetPVarInt(playerid, "Vehicle0", 0);
SetPVarInt(playerid, "Vehicle1", 0);
SetPVarInt(playerid, "Vehicle2", 0);
SetPVarInt(playerid, "Vehicle3", 0);
SetPVarInt(playerid, "Vehicle4", 0);
SetPVarInt(playerid, "Vehicle5", 0);
SetPVarInt(playerid, "HotWireSkill", 0);
SetPVarInt(playerid, "Skin", 0);
SetPVarInt(playerid, "Donator", 0);
SetPVarInt(playerid, "BuildingIn", 0);
SetPVarInt(playerid, "Step", 0);
SetPVarInt(playerid, "Gender", 0);
SetPVarInt(playerid, "Age", 0);
SetPVarInt(playerid, "Team", 0);
SetPVarInt(playerid, "BeenInGame", 0);
SetPVarInt(playerid, "Exp", 0);
SetPVarInt(playerid,"GangId", 0);
SetPVarInt(playerid,"TestStep",  0);
SetPVarInt(playerid,"License",  0);
SetPVarInt(playerid,"HotWireKey",  0);
SetPVarInt(playerid,"Number",  0);
SetPVarInt(playerid,"DT",  0);
SetPVarInt(playerid,"WorkDone",  0);
SetPVarInt(playerid,"Checks",  0);
SetPVarInt(playerid,"WorkTime",  0);
SetPVarInt(playerid,"Bank",  0);
SetPVarInt(playerid,"BankCode",  0);
SetPVarInt(playerid,"Watch",  0);
SetPVarInt(playerid,"JailTime",  0);
SetPVarInt(playerid,"GunLicense",  0);
SetPVarInt(playerid,"Gun1",  0);
SetPVarInt(playerid,"Gun2",  0);
SetPVarInt(playerid,"Gun3",  0);
SetPVarInt(playerid,"Gun4",  0);
SetPVarInt(playerid,"Gun5",  0);
SetPVarInt(playerid,"Gun6",  0);
SetPVarInt(playerid,"Ammo1",  0);
SetPVarInt(playerid,"Ammo2",  0);
SetPVarInt(playerid,"Ammo3",  0);
SetPVarInt(playerid,"Ammo4",  0);
SetPVarInt(playerid,"Ammo5",  0);
SetPVarInt(playerid,"Ammo6",  0);
SetPVarInt(playerid,"RentId",  0);
SetPVarInt(playerid,"ShareId",  0);
return 1;
}

function spawn(playerid)
{
SpawnPlayer(playerid);
}

function SendMessage(playerid, Message[])
{
if(GetPVarInt(playerid, "LoggedIn") == 1 && GetPVarInt(playerid, "Step") < 7) return TextDrawHideForPlayer(playerid, Text:GetPVarInt(playerid, "MessageDraw"));
if(strcmp(GetString(playerid, "LastMessage"), Message, true)== 0)return 1;
SetPVarString(playerid, "LastMessage", Message);
new string[400];
if(GetPVarInt(playerid, "MessageOn") == 7) format(string, sizeof(string), "%s~N~ ~N~%s~N~ ~N~%s~N~ ~N~%s~N~ ~N~Push KEY_SUBMISSION to close/open",Message,GetString(playerid, "Message3"), GetString(playerid, "Message2"), GetString(playerid, "Message1")), SetPVarString(playerid, "Message4", Message), SetPVarInt(playerid, "MessageOn", 4);
else if(GetPVarInt(playerid, "MessageOn") == 6) format(string, sizeof(string), "%s~N~ ~N~%s~N~ ~N~%s~N~ ~N~%s~N~ ~N~Push KEY_SUBMISSION to close/open",Message,GetString(playerid, "Message2"), GetString(playerid, "Message1"), GetString(playerid, "Message4")), SetPVarString(playerid, "Message3", Message), SetPVarInt(playerid, "MessageOn", 7);
else if(GetPVarInt(playerid, "MessageOn") == 5) format(string, sizeof(string), "%s~N~ ~N~%s~N~ ~N~%s~N~ ~N~%s~N~ ~N~Push KEY_SUBMISSION close/open",Message,GetString(playerid, "Message1"), GetString(playerid, "Message4"), GetString(playerid, "Message3")), SetPVarString(playerid, "Message2", Message), SetPVarInt(playerid, "MessageOn", 6);
else if(GetPVarInt(playerid, "MessageOn") == 4) format(string, sizeof(string), "%s~N~ ~N~%s~N~ ~N~%s~N~ ~N~%s~N~ ~N~Push KEY_SUBMISSION to close/open",Message, GetString(playerid, "Message4"), GetString(playerid, "Message3"), GetString(playerid, "Message2")), SetPVarString(playerid, "Message1", Message), SetPVarInt(playerid, "MessageOn", 5);
else if(GetPVarInt(playerid, "MessageOn") == 3) format(string, sizeof(string), "%s~N~ ~N~%s~N~ ~N~%s~N~ ~N~%s~N~ ~N~Push KEY_SUBMISSION to close/open",Message,GetString(playerid, "Message3"), GetString(playerid, "Message2"), GetString(playerid, "Message1")), SetPVarString(playerid, "Message4", Message), SetPVarInt(playerid, "MessageOn", 4);
else if(GetPVarInt(playerid, "MessageOn") == 2) format(string, sizeof(string), "%s~N~ ~N~%s~N~ ~N~%s~N~ ~N~%s~N~ ~N~Push KEY_SUBMISSION to close/open",Message,GetString(playerid, "Message2"), GetString(playerid, "Message1"), GetString(playerid, "Message4")), SetPVarString(playerid, "Message3", Message), SetPVarInt(playerid, "MessageOn", 3);
else if(GetPVarInt(playerid, "MessageOn") == 1) format(string, sizeof(string), "%s~N~ ~N~%s~N~ ~N~%s~N~ ~N~%s~N~ ~N~Push KEY_SUBMISSION to close/open",Message,GetString(playerid, "Message1"), GetString(playerid, "Message3"), GetString(playerid, "Message4")), SetPVarString(playerid, "Message2", Message), SetPVarInt(playerid, "MessageOn", 2);
else if(GetPVarInt(playerid, "MessageOn") == 0) format(string, sizeof(string), "%s~N~%s~N~%s~N~%s",Message, GetString(playerid, "Message2"), GetString(playerid, "Message3"), GetString(playerid, "Message4")), SetPVarString(playerid, "Message1", Message), SetPVarInt(playerid, "MessageOn", 1);

if(GetPVarInt(playerid, "MessageDraw") != 0) return TextDrawSetString(Text:GetPVarInt(playerid,"MessageDraw"), string),TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid, "MessageDraw"));

SetPVarInt(playerid, "MessageDraw", _:TextDrawCreate(421.000000,105.000000,string));
TextDrawUseBox(Text:GetPVarInt(playerid, "MessageDraw"),1);
TextDrawBoxColor(Text:GetPVarInt(playerid, "MessageDraw"),0x00000099);
TextDrawTextSize(Text:GetPVarInt(playerid, "MessageDraw"),607.000000,-13.000000);
TextDrawAlignment(Text:GetPVarInt(playerid, "MessageDraw"),0);
TextDrawBackgroundColor(Text:GetPVarInt(playerid, "MessageDraw"),0x0000ff99);
TextDrawFont(Text:GetPVarInt(playerid, "MessageDraw"),1);
TextDrawLetterSize(Text:GetPVarInt(playerid, "MessageDraw"),0.199999,0.999999);
TextDrawColor(Text:GetPVarInt(playerid, "MessageDraw"),0xffffffcc);
TextDrawSetProportional(Text:GetPVarInt(playerid, "MessageDraw"),1);
TextDrawSetShadow(Text:GetPVarInt(playerid, "MessageDraw"),1);
TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid, "MessageDraw"));
return 1;
}

function OnPlayerDeath(playerid, killerid, reason)
{
    if(GetPVarInt(playerid, "Step") < 7) {SetPlayerHealth(playerid, 100); return 0;}
    if(GetPVarInt(playerid, "TestTime") > 0)
    {
    GameTextForPlayer(playerid, "~r~Driving Test Failed", 2000, 1);
    SetPlayerHealth(playerid, 100);
    return 1;
    }
    if(GetPVarInt(playerid, "SpeedGunStat") != 0) KillTimer(GetPVarInt(playerid, "SpeedGunTimer")), SetPVarInt(playerid, "SpeedGunStat", 0), TextDrawDestroy(Text:GetPVarInt(playerid, "SpeedoDraw"));
    if(GetPVarInt(playerid, "TraceTimer") != 0) KillTimer(GetPVarInt(playerid, "TraceTimer")), DisablePlayerCheckpoint(playerid);
	if(GetPVarInt(playerid, "BinObject") != 0) DestroyObject(GetPVarInt(playerid, "BinObject")), DisablePlayerCheckpoint(playerid), SetPVarInt(playerid, "CPID", -1), SetPVarInt(playerid, "BinObject", 0);
	if(GetPVarInt(playerid, "JCT") != 0) KillTimer(GetPVarInt(playerid, "JCT")), injobmeeting = 0;
    if(GetPVarInt(playerid, "JCT1") != 0) KillTimer(GetPVarInt(playerid, "JCT1")), DeletePVar(playerid,"JCT1"), injobmeeting = 0;
    if(GetPVarInt(playerid, "CuffTimer") != 0) KillTimer(GetPVarInt(playerid, "CuffTimer")), SetPVarInt(GetPVarInt(playerid, "Stopping"), "Holding", 0);
    if(GetPVarInt(playerid, "Holding") != 0) KillTimer(GetPVarInt(GetPVarInt(playerid,"Holding"), "CuffTimer")), SetPVarInt(GetPVarInt(playerid, "Holding"), "Stopping", 0);
    if(GetPVarInt(playerid, "ShootingVar") != 0) KillTimer(GetPVarInt(playerid,"ShootingVar")), StopShootingTest(playerid);
    //if(GetPVarInt(playerid, "SpeedoTimer") != 0) KillTimer(GetPVarInt(playerid, "SpeedoTimer")), SetPVarInt(playerid, "SpeedoTimer", 0);
    if(GetPVarInt(playerid, "ToDo") != 0) TextDrawDestroy(Text:GetPVarInt(playerid, "ToDo")), SetPVarInt(playerid, "ToDo", 0), TextDrawDestroy(Text:GetPVarInt(playerid, "ToDo1")), SetPVarInt(playerid, "ToDo1", 0);
	if(GetPVarInt(playerid, "Sleeping") != 0) KillTimer(GetPVarInt(playerid, "Sleeping")), SetPVarInt(playerid, "Sleeping", 0);
    if(GetPVarInt(playerid, "DrugEffectTimer") != 0) KillTimer(GetPVarInt(playerid, "DrugEffectTimer")), SetPVarInt(playerid, "DrugEffectTimer", 0);
    SetPVarInt(playerid, "Hurt", 0);
	SetPVarInt(playerid, "JustDied", 1);
	ClearTextDraws(playerid);
    ClearAnimations(playerid);
	SetPVarInt(playerid, "WereSpecing", 1);
	TogglePlayerAllDynamicCPs(playerid, 1);
	DisablePlayerCheckpoint(playerid);
	SetPlayerHealth(playerid, 100);
	ResetGuns(playerid);
    if(killerid != 255)
    {
    if(CheckGang(GetString(playerid, "Gang")) == 1)
	{
	GangInfo[GetPVarInt(playerid, "GangId")][gKills] ++;
	UpdateGang(GetPVarInt(playerid, "GangId"));
    }
    }
 	return 1;
}



function OnVehicleStreamIn(vehicleid, forplayerid)
{
    SetVehicleParamsForPlayer(vehicleid, forplayerid, 0, vehinfo[vehicleid][cLocked]);
	if(vehicleid == 36) SetVehicleParamsForPlayer(vehicleid, forplayerid, 0, 1);
	if(vehinfo[vehicleid][cJunk] == 1)
	{
	if(vehinfo[vehicleid][cHealth] <= 316.00) vehinfo[vehicleid][cHealth] = 400.00;
    UpdateVehicleDamageStatus(vehicleid, 36831250, 131587, 1, 0);
    SetVehicleHealth(vehicleid,vehinfo[vehicleid][cHealth]);
	return 1;
	}
    if(vehinfo[vehicleid][cOwned] == 1 && vehinfo[vehicleid][cModop] == 1)
    {
	if(GetVehicleModel(vehicleid) == 444)// monster
	{
		AddVehicleComponent(vehicleid,1010);
		AddVehicleComponent(vehicleid,1079);
	}
//-------------- Wheels Arch Angels (ALL ALIEN STUFF)-------------------------
	if(GetVehicleModel(vehicleid) == 560)// SULTAN
	{
		AddVehicleComponent(vehicleid,1026);//lsideskirt
		AddVehicleComponent(vehicleid,1027);//rsideskirt
		AddVehicleComponent(vehicleid,1028);//exhaust
		AddVehicleComponent(vehicleid,1032);//roof vent
		AddVehicleComponent(vehicleid,1138);//spoiler
		AddVehicleComponent(vehicleid,1141);//rbumper
		AddVehicleComponent(vehicleid,1141);//fbumper
		AddVehicleComponent(vehicleid,1010);//nitro x10
	}
	if(GetVehicleModel(vehicleid) == 562)// ELEGY
	{
		AddVehicleComponent(vehicleid,1036);//lsideskirt
		AddVehicleComponent(vehicleid,1040);//rsideskirt
		AddVehicleComponent(vehicleid,1034);//exhaust
		AddVehicleComponent(vehicleid,1038);//roof vent
		AddVehicleComponent(vehicleid,1147);//spoiler
		AddVehicleComponent(vehicleid,1149);//rbumper
		AddVehicleComponent(vehicleid,1171);//fbumper
		AddVehicleComponent(vehicleid,1010);//nitro x10
		ChangeVehiclePaintjob(vehicleid,0);
	}
	if(GetVehicleModel(vehicleid) == 565)// FLASH
	{
		AddVehicleComponent(vehicleid,1047);//lsideskirt
		AddVehicleComponent(vehicleid,1051);//rsideskirt
		AddVehicleComponent(vehicleid,1046);//exhaust
		AddVehicleComponent(vehicleid,1054);//roof vent
		AddVehicleComponent(vehicleid,1049);//spoiler
		AddVehicleComponent(vehicleid,1150);//rbumper
		AddVehicleComponent(vehicleid,1153);//fbumper
		AddVehicleComponent(vehicleid,1010);//nitro x10
		ChangeVehiclePaintjob(vehicleid,0);
	}
	if(GetVehicleModel(vehicleid) == 561)// STRATUM
	{
		AddVehicleComponent(vehicleid,1056);//lsideskirt
		AddVehicleComponent(vehicleid,1062);//rsideskirt
		AddVehicleComponent(vehicleid,1064);//exhaust
		AddVehicleComponent(vehicleid,1055);//roof vent
		AddVehicleComponent(vehicleid,1058);//spoiler
		AddVehicleComponent(vehicleid,1154);//rbumper
		AddVehicleComponent(vehicleid,1155);//fbumper
		AddVehicleComponent(vehicleid,1010);//nitro x10
		ChangeVehiclePaintjob(vehicleid,0);
	}
	if(GetVehicleModel(vehicleid) == 559)// JESTER
	{
		AddVehicleComponent(vehicleid,1069);//lsideskirt
		AddVehicleComponent(vehicleid,1071);//rsideskirt
		AddVehicleComponent(vehicleid,1065);//exhaust
		AddVehicleComponent(vehicleid,1067);//roof vent
		AddVehicleComponent(vehicleid,1162);//spoiler
		AddVehicleComponent(vehicleid,1159);//rbumper
		AddVehicleComponent(vehicleid,1160);//fbumper
		AddVehicleComponent(vehicleid,1010);//nitro x10
		ChangeVehiclePaintjob(vehicleid,0);
	}
	if(GetVehicleModel(vehicleid) == 558)// URANUS
	{
		AddVehicleComponent(vehicleid,1090);//lsideskirt
		AddVehicleComponent(vehicleid,1094);//rsideskirt
		AddVehicleComponent(vehicleid,1092);//exhaust
		AddVehicleComponent(vehicleid,1088);//roof vent
		AddVehicleComponent(vehicleid,1164);//spoiler
		AddVehicleComponent(vehicleid,1168);//rbumper
		AddVehicleComponent(vehicleid,1166);//fbumper
		AddVehicleComponent(vehicleid,1010);//nitro x10
		ChangeVehiclePaintjob(vehicleid,0);
	}
//-------- Loco Low-Co---------------------------------------------
	if(GetVehicleModel(vehicleid) == 575)// BROADWAY
	{
		AddVehicleComponent(vehicleid,1042);//lsideskirt
		AddVehicleComponent(vehicleid,1099);//rsideskirt
		AddVehicleComponent(vehicleid,1044);//exhaust chromer
		AddVehicleComponent(vehicleid,1176);//rbumper chromer
		AddVehicleComponent(vehicleid,1174);//fbumperchromer
		AddVehicleComponent(vehicleid,1087);//hydrolics
		AddVehicleComponent(vehicleid,1086);//nitro x10
		ChangeVehiclePaintjob(vehicleid,0);
	}
	if(GetVehicleModel(vehicleid) == 534)// REMINGTON
	{
		AddVehicleComponent(vehicleid,1122);//lsideskirt flame
		AddVehicleComponent(vehicleid,1101);//rsideskirt flame
		AddVehicleComponent(vehicleid,1126);//exhaust chromer
		AddVehicleComponent(vehicleid,1123);//bullbar chrome bars
		AddVehicleComponent(vehicleid,1180);//rbumper
		AddVehicleComponent(vehicleid,1179);//fbumper
		AddVehicleComponent(vehicleid,1087);//hydrolics
		AddVehicleComponent(vehicleid,1086);//nitro x10
		ChangeVehiclePaintjob(vehicleid,0);
	}
	if(GetVehicleModel(vehicleid) == 567)// SAVANNA
	{
		AddVehicleComponent(vehicleid,1133);//lsideskirt chromestrip
		AddVehicleComponent(vehicleid,1102);//rsideskirt chromestrip
		AddVehicleComponent(vehicleid,1129);//exhaust chromer
		AddVehicleComponent(vehicleid,1130);//roof hardtop
		AddVehicleComponent(vehicleid,1187);//rbumper chromer
		AddVehicleComponent(vehicleid,1189);//fbumper chromer
		AddVehicleComponent(vehicleid,1087);//hydrolics
		AddVehicleComponent(vehicleid,1086);//nitro x10
		ChangeVehiclePaintjob(vehicleid,0);
	}
	if(GetVehicleModel(vehicleid) == 536)// BLADE
	{
		AddVehicleComponent(vehicleid,1108);//lsideskirt chromestrip
		AddVehicleComponent(vehicleid,1107);//rsideskirt chromestrip
		AddVehicleComponent(vehicleid,1104);//exhaust chromer
		AddVehicleComponent(vehicleid,1128);//roof vinyl hardtop
		AddVehicleComponent(vehicleid,1184);//rbumper chromer
		AddVehicleComponent(vehicleid,1182);//fbumper chromer
		AddVehicleComponent(vehicleid,1087);//hydrolics
		AddVehicleComponent(vehicleid,1086);//nitro x10
		ChangeVehiclePaintjob(vehicleid,0);
	}
	if(GetVehicleModel(vehicleid) == 576)// TORNADO
	{
		AddVehicleComponent(vehicleid,1134);//lsideskirt chromestrip
		AddVehicleComponent(vehicleid,1137);//rsideskirt chromestrip
		AddVehicleComponent(vehicleid,1136);//exhaust chromer
		AddVehicleComponent(vehicleid,1190);//rbumper chromer
		AddVehicleComponent(vehicleid,1191);//fbumper chromer
		AddVehicleComponent(vehicleid,1087);//hydrolics
		AddVehicleComponent(vehicleid,1086);//nitro x10
		ChangeVehiclePaintjob(vehicleid,0);
	}
	if(GetVehicleModel(vehicleid) == 596 || GetVehicleModel(vehicleid) == 599)
	{
		AddVehicleComponent(vehicleid,1010);
		AddVehicleComponent(vehicleid,1079);
	}
	}
	if(vehinfo[vehicleid][cCantSell] == 0)
    {
    if(vehinfo[vehicleid][cHealth] <= 316) vehinfo[vehicleid][cHealth] = 400;
    UpdateVehicleDamageStatus(vehicleid, vehinfo[vehicleid][cPanel], vehinfo[vehicleid][cDoor], vehinfo[vehicleid][cLight], vehinfo[vehicleid][cTire]);
    SetVehicleHealth(vehicleid,vehinfo[vehicleid][cHealth]);
	}
	return 1;
}

function OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

function NPCControl(playerid)
{
//print("timer on");
if(IsPlayerInRangeOfPoint(busdriver, 15.0, 1184.0010,-1756.2838,13.6088) && GetPVarInt(playerid, "Step") == 6 && GetPVarInt(playerid, "HereOn1") == 1)return  TogglePlayerSpectating(playerid, 0);
else if(IsPlayerInRangeOfPoint(train, 15.0, 1690.2064,-1955.6138,13.5469) && GetPVarInt(playerid, "Step") == 6 && GetPVarInt(playerid, "HereOn1") == 2)return TogglePlayerSpectating(playerid, 0), SetPVarInt(playerid,"TS", 2);
else if(IsPlayerInRangeOfPoint(train, 15.0, 780.1542,-1338.1558,-1.5505) && GetPVarInt(playerid, "Step") == 6 && GetPVarInt(playerid, "HereOn1") == 2)return TogglePlayerSpectating(playerid, 0), SetPVarInt(playerid,"TS", 1);
else if(IsPlayerInRangeOfPoint(plane, 15.0, 1963.8408,-2493.8347,13.4393)&& GetPVarInt(playerid, "Step") == 6 && GetPVarInt(playerid, "HereOn1") == 3)return TogglePlayerSpectating(playerid, 0);
return 1;
}

function UpdateServer()
{
	foreach(player, i)
	{
		new ping = GetPlayerPing(i);
		if(ping > 500 && GetPVarInt(i, "Kickable") == 1 && GetPVarInt(i, "Admin") < 3)
		{
			new str[128];
			format(str, sizeof(str), "~R~News: ~W~%s was kicked for max ping (500) his ping was %d",GetPlayerNameEx(i),ping);
			NewsMessage(str);
			Kick(i);
		}
		if(!IsPlayerNPC(i))
		{
		//printf("Timer on for %d",i);
		new Float:health, string[60];
		GetPlayerHealth(i, health);
		if(health >= 3 && health < 25 && GetPVarInt(i, "Hurt") == 0)
		SetPVarInt(i, "Hurt", SetTimerEx("Hurting", 1000, 1, "i", i)),
		ApplyAnimation(i,"SWEET","Sweet_injuredloop",4,1,1,1,1,0),
		SetCameraBehindPlayer(i),
		SetPlayerDrunkLevel(i, 10000),
		format(string, sizeof(string), "[%s] is to weak and calapsed!", GetPlayerNameEx(i)),
		ProxDetector(30.0, i, string, lightblue,red,green,grey,yellow),
		TextDrawShowForPlayer(i, Window[0]),
        TextDrawShowForPlayer(i, Window[1]);
            
		if(GetPlayerCash(i) != GetPlayerMoney(i))
		{
			ResetMoneyBar(i);
			UpdateMoneyBar(i,GetPVarInt(i,"Cash"));
	    }
	    if(GetPVarInt(i, "LoggedIn") == 1)
		{
		SetPVarInt(i,"Seconds", GetPVarInt(i,"Seconds") +1);

		if(GetPVarInt(i,"Seconds") == 60) SetPVarInt(i,"Seconds", 0),SetPVarInt(i,"Minutes", GetPVarInt(i,"Minutes") +1), CheckWork(i);

		if(GetPVarInt(i,"Minutes") == 60) SetPVarInt(i,"Minutes", 0), SetPVarInt(i,"Hours", GetPVarInt(i,"Hours") +1), CheckRent(i), TaxPay(i);

		SetPVarInt(i, "Hunger", GetPVarInt(i, "Hunger") +1);
		if(GetPVarInt(i, "Hunger") == 60) SetPVarInt(i, "Hunger", 0), SetPlayerHealth(i, health - 1);
		}//close NPC lock

		new vehicleid = GetPlayerVehicleID(i);
        if(IsPlayerInAnyVehicle(i) && GetPlayerState(i) == PLAYER_STATE_DRIVER && engineOn[vehicleid] == 1)
		{
			if(IsPlayerInInvalidleadedVehicle (vehicleid)|| IsPlayerInInvalidDieselVehicle(vehicleid)
			|| IsPlayerInInvalidPetroVehicle(vehicleid) || IsPlayerInInvalidMotoVehicle(vehicleid))
			{
			            if(GetPVarInt(i,"FuelTime") == 60 && Vgas[vehicleid] > 0)
					    {
					    Vgas[vehicleid] -= 1;
				    	vehinfo[vehicleid][cFuel] -= 1;
					    vehinfo[vehicleid][cMiles] += 1;
					    if(vehinfo[vehicleid][cCantSell] == 0)UpdateVehicles(vehicleid);
					    SetPVarInt(i,"FuelTime", 0);
					    }
						if(Vgas[vehicleid] >= 1)
						{
                            SetPVarInt(i,"FuelTime", GetPVarInt(i,"FuelTime") +1);
							if(GetPVarInt(i,"Drawer4") == 1)
							{
							TextDrawTextSize(Text:GetPVarInt(i, "FuelText"), (34.000000 + (Vgas[vehicleid] / 0.93)), 0.000000);
							if(Vgas[vehicleid] <= 20)TextDrawBoxColor(Text:GetPVarInt(i, "FuelText"),0xff000066);
							if(Vgas[vehicleid] >= 21 && Vgas[vehicleid] <= 80)TextDrawBoxColor(Text:GetPVarInt(i, "FuelText"),0xFF93007A);
							if(Vgas[vehicleid] >= 81)TextDrawBoxColor(Text:GetPVarInt(i, "FuelText"),0x00ff0066);
							TextDrawShowForPlayer(i, Text:GetPVarInt(i, "FuelText"));
                            TextDrawShowForPlayer(i, FuelText1[0]);
							TextDrawShowForPlayer(i, FuelText1[1]);
							SetPVarInt(i, "LookingTextDraw0", 1);
							}
                            if(GetPVarInt(i,"Drawer4") == 0)
							{
							SetPVarInt(i, "FuelText", _:TextDrawCreate(34.000000,327.000000,"_"));
							TextDrawUseBox(Text:GetPVarInt(i, "FuelText"),1);
							TextDrawBoxColor(Text:GetPVarInt(i, "FuelText"),0x00ffff99);
							TextDrawTextSize(Text:GetPVarInt(i, "FuelText"),141.000000,0.000000);
							TextDrawAlignment(Text:GetPVarInt(i, "FuelText"),0);
							TextDrawBackgroundColor(Text:GetPVarInt(i, "FuelText"),0x000000ff);
							TextDrawFont(Text:GetPVarInt(i, "FuelText"),3);
							TextDrawLetterSize(Text:GetPVarInt(i, "FuelText"),1.000000,1.000000);
							TextDrawColor(Text:GetPVarInt(i, "FuelText"),0xffffffff);
							TextDrawSetOutline(Text:GetPVarInt(i, "FuelText"),1);
							TextDrawSetProportional(Text:GetPVarInt(i, "FuelText"),1);
							TextDrawSetShadow(Text:GetPVarInt(i, "FuelText"),1);
							TextDrawShowForPlayer(i, Text:GetPVarInt(i, "FuelText"));
							TextDrawShowForPlayer(i, FuelText1[0]);
							TextDrawShowForPlayer(i, FuelText1[1]);
                            SetPVarInt(i,"Drawer4", 1);
							SetPVarInt(i, "LookingTextDraw0", 1);
							}
						}
						if(Vgas[vehicleid] <= 0)
						{
							TextDrawHideForPlayer(i, Text:GetPVarInt(i, "FuelText"));
							TogglePlayerControllable(i,0);
							engineOn[vehicleid] = 0;
							GameTextForPlayer(i,"~n~~n~~n~~n~~b~No ~R~FUEL!",2500,3);
						    SendMessage(i, " You Have No More Fuel Type /Leave To Exit This Vehicle");
						    }
					  }
			   }
		}// close's after logged
		if(IsPlayerInRangeOfPoint(medic, 5.0, 2001.6255,-1414.0553,17.1387))
		{
		if(GetPVarInt(i, "WereSpecing") == 2) TogglePlayerSpectating(i, 0), SendThemIn(i), SetPVarInt(i, "Dead", 1);
		}
    }// close loop
    return 1;
}

function Hurting(playerid)
{
new Float:health;
GetPlayerHealth(playerid, health);
if(IsPlayerInAnyVehicle(playerid)) RemovePlayerFromVehicle(playerid);
SetPlayerHealth(playerid, health + 1);
ApplyAnimation(playerid,"SWEET","Sweet_injuredloop",4,1,1,1,1,0);

if(GetPVarInt(playerid, "Hurt") != 0 && health >=25 && health <=101)
KillTimer(GetPVarInt(playerid, "Hurt")),
SetPlayerHealth(playerid, 26),
SendMessage(playerid, " You Gained Enough Health To Walk Again"),
SendMessage(playerid,"Hint: Go eat or sleep to gain back your health."),
ClearAnimations(playerid),
TextDrawHideForPlayer(playerid, Window[0]),
TextDrawHideForPlayer(playerid, Window[1]),
SetPlayerDrunkLevel(playerid, 0),
SetPVarInt(playerid, "Hurt", 0);
return 1;
}

function Sleep(playerid)
{
if(GetPVarInt(playerid, "Sleeping") == 2)
ClearAnimations(playerid),
SetCameraBehindPlayer(playerid),
TextDrawHideForPlayer(playerid, Window[0]),
TextDrawHideForPlayer(playerid, Window[1]),
SetPVarInt(playerid, "Sleeping", 0 );
new Float:health;
GetPlayerHealth(playerid, health);
if(health >= 1 && health < 100) SetPlayerHealth(playerid, health + 1);
else if(health >=100)
SendMessage(playerid," You woke up and now have full health"),
ClearAnimations(playerid),
SetCameraBehindPlayer(playerid),
TextDrawHideForPlayer(playerid, Window[0]),
TextDrawHideForPlayer(playerid, Window[1]),
KillTimer(GetPVarInt(playerid, "Sleeping")),
SetPVarInt(playerid, "Sleeping", 0 );
return 1;
}

function GiveRentMoney(playerid)
{
new mes[128];
for(new b = 0; b < sizeof(BuildingInfo); b++)
{
if(MyBusiness(playerid, b))
{
if(BuildingInfo[b][bFunds] > 0)
format(mes, sizeof(mes), "You received $%d from your Building %s (This is money from your Building's share's profit)",BuildingInfo[b][bFunds],BuildingInfo[b][bDescription]),
SendMessage(playerid, mes),
GivePlayerCash(playerid, BuildingInfo[b][bFunds]),
BuildingInfo[b][bFunds] = 0,
UpdateBuilding(b);
}
}
for(new h = 0; h < sizeof(HouseInfo); h++)
{
if(MyHouse(playerid, h))
{
if(HouseInfo[h][hFunds] > 0)
format(mes, sizeof(mes), "You received $%d from your house %s (This is money from your house's rent)",HouseInfo[h][hFunds],HouseInfo[h][hDescription]),
SendMessage(playerid, mes),
GivePlayerCash(playerid, HouseInfo[h][hFunds]),
HouseInfo[h][hFunds] = 0,
UpdateHouse(h);
}
}
return 1;
}

function CheckRent(playerid)
{
new id = GetPVarInt(playerid, "RentId"), id1 = GetPVarInt(playerid, "ShareId");
if(id != 0)
{
new string[70];
format(string, sizeof(string), "You paid $%d rent to %s as you have now lived there another hour.",HouseInfo[id][hRent], HouseInfo[id][hOwner]);
SendMessage(playerid, string);
GivePlayerCash(playerid, - HouseInfo[id][hRent]);
HouseInfo[id][hFunds] += HouseInfo[id][hRent];
}
if(id1 != 0)
{
new string[70];
format(string, sizeof(string), "You got paid $%d for owning share's at %s.",BuildingInfo[id1][bBuyPrice]/BuildingInfo[id1][bShares]/4, BuildingInfo[id1][bDescription]);
SendMessage(playerid, string);
GivePlayerCash(playerid, BuildingInfo[id1][bBuyPrice]/BuildingInfo[id1][bShares]/4);
BuildingInfo[id1][bFunds] += BuildingInfo[id1][bBuyPrice]/BuildingInfo[id1][bShares]/2;
}
return 1;
}

function CheckWork(playerid)
{
if(GetPVarInt(playerid, "WorkTime") > 0) SetPVarInt(playerid, "WorkTime", GetPVarInt(playerid, "WorkTime") -1);
return 1;
}

function SendThemIn(playerid)
{
if(GetPVarInt(playerid, "WereSpecing") == 2)
{
if(GetPVarInt(playerid, "Watch") == 1 && GetPVarInt(playerid, "WereSpecing") == 2) TextDrawHideForPlayer(playerid,TimeText1), TextDrawHideForPlayer(playerid,TimeText);
SetPVarInt(playerid, "WereSpecing", 0);
SetPlayerPos(playerid, 1153.7894,-1323.1322,1387.1202);
SetPlayerFacingAngle(playerid, 266.6578);
new world = random(1243)+2;
SetPlayerInterior(playerid, 5);
SetPlayerVirtualWorld(playerid, world);
GameTextForPlayer(playerid, "~W~Please wait..~N~~R~You are reviving", 5000, 3);
Streamer_Update(playerid);
TogglePlayerControllable(playerid, 0);
SetTimerEx("donespawn", 1000, 0, "i", playerid);
SetPVarInt(playerid, "WalkOut", SetTimerEx("StartWalking", 6000, 0, "i", playerid));
}
return 1;
}

function StartWalking(playerid)
{
if(GetPVarInt(playerid, "Hospital") == 0)
SetPVarInt(playerid, "WalkOut", SetTimerEx("StartWalking", 1000, 1, "i", playerid)),
ClearAnimations(playerid),
SetPlayerPos(playerid, 1153.8286,-1325.9714,1386.4264),
SetPlayerFacingAngle(playerid, 265.6852),
ApplyAnimation(playerid,"PED","WALK_player",4.1,1,1,1,1,0),
SetPlayerDrunkLevel(playerid, 0),
StartFade(playerid),
SetPVarInt(playerid, "Hospital", 1);

if(GetPVarInt(playerid, "Hospital") == 1 && IsPlayerInRangeOfPoint(playerid, 2, 1166.5419,-1327.2732,1386.4264))
SetPlayerFacingAngle(playerid, 179.2606), SetPVarInt(playerid, "Hospital", 2);

if(GetPVarInt(playerid, "Hospital") == 2 && IsPlayerInRangeOfPoint(playerid, 1.5, 1165.4719,-1333.8276,1386.4193))
SetPlayerFacingAngle(playerid, 84.1649), SetPVarInt(playerid, "Hospital", 0), SetTimerEx("SendThemOut", 1000, 0, "i", playerid), KillTimer(GetPVarInt(playerid, "WalkOut")), SetPVarInt(playerid, "WalkOut", 0);

return 1;
}

function SendThemOut(playerid)
{
StartFade(playerid);
SetPlayerInterior(playerid, 0);
SetPlayerVirtualWorld(playerid, 0);
SetPlayerCameraPos(playerid, 2005.4163,-1430.3998,20.4637), SetPlayerCameraLookAt(playerid, 2034.1703,-1401.9425,17.2948), SetPlayerPos(playerid, 2044.8481,-1405.7732,18.4533),
TogglePlayerControllable(playerid, 0), SetTimerEx("LeaveHospital", 3000, 0, "i", playerid);
return 1;
}

function LeaveHospital(playerid)
{
TogglePlayerControllable(playerid, 1);
SetPlayerPos(playerid, 2034.1703,-1401.9425,17.2948);
SetPlayerFacingAngle(playerid, 173.4551);
ApplyAnimation(playerid,"PED","WALK_player",4.1,1,1,1,1,5000);
SetTimerEx("LeaveHospital1", 4000, 0, "i", playerid);
return 1;
}

function LeaveHospital1(playerid)
{
new string[100];
TextDrawHideForPlayer(playerid, Window[0]);
TextDrawHideForPlayer(playerid, Window[1]);
SetCameraBehindPlayer(playerid);
ClearAnimations(playerid);
SetPlayerHealth(playerid, 100);
if(GetPVarInt(playerid, "Watch") == 1) TextDrawShowForPlayer(playerid,TimeText1), TextDrawShowForPlayer(playerid,TimeText);
ShowToDoList(playerid);
StartFade(playerid);
if(GetPlayerCash(playerid) > 0) format(string, sizeof(string), "You lost $%d when you died, if you banked it you would still have it.",GetPlayerCash(playerid)),SendMessage(playerid, string), ResetPlayerCash(playerid);
return 1;
}

function VehicleOwnAble(vehicleid)
{
	if(vehicleid >= 1 )
	{
		return 1;
	}
	return 0;
}

function GasStation(playerid)
{
new veh = GetPlayerVehicleID(playerid);
if(IsPlayerInRangeOfPoint(playerid, 12.0, 2598.5520,-2211.8750,13.739) || IsPlayerInRangeOfPoint(playerid, 12.0, 1939.1832,-1772.8082,13.0182)
|| IsPlayerInRangeOfPoint(playerid, 12.0, 1004.8453,-934.1225,42.3704) || IsPlayerInRangeOfPoint(playerid, 12.0, -92.2936,-1170.2572,2.5985)
|| IsPlayerInRangeOfPoint(playerid, 12.0, 21.3702,-2648.5874,40.6598) || IsPlayerInRangeOfPoint(playerid, 12.0, -1606.4777,-2714.2261,48.7249)
|| IsPlayerInRangeOfPoint(playerid, 12.0, -2248.4661,-2556.8704,32.0888) || IsPlayerInRangeOfPoint(playerid, 12.0, -2023.9392,155.7517,29.0224)
|| IsPlayerInRangeOfPoint(playerid, 12.0, -2413.5146,975.1546,45.4891) || IsPlayerInRangeOfPoint(playerid, 12.0, -1673.7776,412.4036,7.3677)
|| IsPlayerInRangeOfPoint(playerid, 12.0, -1330.4001,2672.5837,49.6246) || IsPlayerInRangeOfPoint(playerid, 12.0, -3157.7686,-815.9407,4.5356)
|| IsPlayerInRangeOfPoint(playerid, 12.0, -736.8313,2746.0913,46.7860) || IsPlayerInRangeOfPoint(playerid, 12.0, -1327.7854,2682.9517,49.6079)
|| IsPlayerInRangeOfPoint(playerid, 12.0, 69.8630,1219.1498,18.5318) || IsPlayerInRangeOfPoint(playerid, 12.0, 2322.4463,612.7385,10.5698)
|| IsPlayerInRangeOfPoint(playerid, 12.0, 2202.3093,2475.9895,10.5372) || IsPlayerInRangeOfPoint(playerid, 12.0, 2147.9719,2748.4475,10.5393)
|| IsPlayerInRangeOfPoint(playerid, 12.0, 2114.2292,920.6147,10.5412) || IsPlayerInRangeOfPoint(playerid, 12.0, -3095.2527,-2166.6189,9.4343))
{
if(IsPlayerInInvalidPetroVehicle(veh))return 0;
return 1;
}
return 0;
}

function AirStation(playerid)
{
return 0;
}

function kickable1(playerid)
{
	SetPVarInt(playerid, "Kickable", 1);
	return 1;
}

function NewsMessage(string[])
{
	if(newssent == 1)
	{
        TextDrawSetString(NewsText, string);
        TextDrawShowForAll(NewsText);
		SetTimer("HideNews", 2000, 0);
    	return 1;
	}
	NewsText = TextDrawCreate(271.000000,325.000000,string);
	TextDrawAlignment(NewsText,0);
	TextDrawBackgroundColor(NewsText,0x000000ff);
	TextDrawFont(NewsText,1);
	TextDrawLetterSize(NewsText,0.299999,1.200000);
	TextDrawColor(NewsText,0xffffffff);
	TextDrawSetProportional(NewsText,1);
	TextDrawSetShadow(NewsText,1);
	TextDrawShowForAll(NewsText);
	newssent = 1;
	SetTimer("HideNews", 2000, 0);
	return 1;
}

function HideNews()
{
TextDrawHideForAll(NewsText);
return 1;
}


function DrugEffect(playerid)
{
if(GetPVarInt(playerid, "DrugEffectTimer") == 0) KillTimer(GetPVarInt(playerid, "DrugCheckTimer")), SetPVarInt(playerid, "DrugCheckTimer", 0);
if(!IsPlayerInAnyVehicle(playerid) && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_EXIT_VEHICLE && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_SMOKE_CIGGY && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_ENTER_VEHICLE) SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);
if(GetPVarInt(playerid, "DoneDrugs") > 2000 && !IsPlayerInAnyVehicle(playerid) && GetPVarInt(playerid, "Walked") == 5 && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_ENTER_VEHICLE && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_EXIT_VEHICLE) ApplyAnimation(playerid,"PED","WALK_DRUNK",4.1,1,1,1,1,1000), SetPVarInt(playerid, "Walked", 0);
else if(GetPVarInt(playerid, "DoneDrugs") > 2000 && !IsPlayerInAnyVehicle(playerid)) SetPVarInt(playerid, "Walked", GetPVarInt(playerid, "Walked") +1);
if(GetPVarInt(playerid, "DoneDrugs") > 12000 && GetPVarInt(playerid, "OD") == 0) ApplyAnimation(playerid,"CRACK","crckidle4",4.1,0,1,1,0,2000), SetTimerEx("OD", 2000, 0, "i", playerid), SetPVarInt(playerid, "OD", 1);
return 1;
}

function OD(playerid)
{
SetPVarInt(playerid, "DoneDrugs", 0);
SetPVarInt(playerid, "OD", 0);
ClearAnimations(playerid);
SetPlayerHealth(playerid, 0);
SendMessage(playerid, "You overdosed and died.");
return 1;
}

function DrugEffectGone(playerid)
{
if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_SMOKE_CIGGY) SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
SetPVarInt(playerid, "DoneDrugs", 0);
SetPlayerDrunkLevel(playerid, 0);
SetPVarInt(playerid, "DrugEffectTimer", 0);
SendMessage(playerid, "You have sobered up and you don't feel high no more.");
return 1;
}

// Command's

cmd(car, playerid, params[])
{
if(GetPVarInt(playerid, "Admin") <= 3) return SendMessage(playerid, "Your Not Able To Use This Command");

new model, color1, color2, Price, sellable, Modop,junk;
if(sscanf(params, "iiiiiii", model, color1, color2, Price, sellable, Modop, junk)) return SendMessage(playerid,"To create a vehicle type: /car [model id] [color1] [color2] [price] [sellable] [modop] [junk car]");

if(model < 400 || model > 611) return SendMessage(playerid, "   Vehicle Number can't be below 400 or above 611 !");
if(color1 < 0 || color1 > 126) return SendMessage(playerid, "   Color Number can't be below 0 or above 126 !");
if(color2 < 0 || color2 > 126) return SendMessage(playerid, "   Color Number can't be below 0 or above 126 !");
if(sellable < 0 || sellable > 1) return SendMessage(playerid, "ERROR 0 to be sellable 1 to be non-sellable");
if(Modop < 0 || Modop > 1) return SendMessage(playerid, "ERROR 0 to be auto modded or  1 to be non-modable");
if(junk < 0 || junk > 1) return SendMessage(playerid, "ERROR 1 to be a junk vehicle or 0 not to be a junk vehicle");

new Float:X,Float:Y,Float:Z,Float:Facing;
GetPlayerPos(playerid,X,Y,Z);
GetPlayerFacingAngle(playerid, Facing);

new Owner[MAX_PLAYER_NAME];
Owner = "No-One";

new carid = CreateVehicle(model, X,Y,Z, Facing, color1, color2, -1);
new Name[15];
strmid(Name, VehicleNames[GetVehicleModel(carid)-400], 0, 128);
new SQLId = SaveCarInfo(model, X,Y,Z, Facing, color1, color2, 0, Owner, Price, 0, sellable, Modop, carid, Name, 100, 0, 0, 0, junk);
new string[75];
vehinfo[carid][cSQLId] = SQLId;
vehinfo[carid][cModel] = model;
vehinfo[carid][cLocationx] = X;
vehinfo[carid][cLocationy] = Y;
vehinfo[carid][cLocationz] = Z;
vehinfo[carid][cAngle] = Facing;
vehinfo[carid][cColorOne] = color1;
vehinfo[carid][cColorTwo] = color2;
vehinfo[carid][cLocked] = 0;
strmid(vehinfo[carid][cOwner], Owner, 0, strlen(Owner), 999);
vehinfo[carid][cValue] = Price;
vehinfo[carid][cOwned] = 0;
vehinfo[carid][cCantSell] = sellable;
vehinfo[carid][cModop] = Modop;
vehinfo[carid][cVehid] = carid;
vehinfo[carid][cName] = Name;
vehinfo[carid][cFuel] = 100;
vehinfo[carid][cMiles] = 0;
vehinfo[carid][cLock] = 0;
vehinfo[carid][cInsurance] = 0;
vehinfo[carid][cJunk] = junk;
vehinfo[carid][cPanel] = 0;
vehinfo[carid][cDoor] = 0;
vehinfo[carid][cLight] = 0;
vehinfo[carid][cTire] = 0;
vehinfo[carid][cHealth] = 1000;
vehinfo[carid][cBlown] = 0;
Vgas[carid] = 100;
engineOn[carid] = 0;
totalveh++;
TogglePlayerControllable(playerid, true);
format(string, sizeof(string), "   Vehicle %d spawned.", carid);
SendMessage(playerid, string);
return 1;
}

cmd(adel, playerid, params[])
{
if(!IsPlayerInAnyVehicle(playerid))return SendMessage(playerid,"Your not in a vehicle");
if (GetPVarInt(playerid, "Admin") >= 3){new vehicleid = GetPlayerVehicleID(playerid);totalveh--;DeleteVehicle(vehicleid);}	else
{SendMessage(playerid, "You are not authorized to use this command!");}
return 1;
}

cmd(apark, playerid, params[])
{
if(!IsPlayerInAnyVehicle(playerid))return SendMessage(playerid,"Your not in a vehicle");
if (GetPVarInt(playerid, "Admin") >= 2){new vehicleid = GetPlayerVehicleID(playerid);UpdateAllVehicleInfo(vehicleid);SendMessage(playerid,"New position saved.");
}else{SendMessage(playerid, "You are not authorized to use this command!");}
return 1;
}

cmd(weather, playerid, params[])
{
if(GetPVarInt(playerid, "Admin") < 2)return SendMessage(playerid, "You can't use this command!");
new weather, str[50];
if(sscanf(params, "i", weather))return SendMessage(playerid, "USAGE: /weatherall [weatherid]");
SetWeather(weather);
format(str, sizeof(str), "Weather Set To",weather);
SendMessage(playerid, str);
return 1;
}

cmd(makehouse, playerid, params[])
{
if(GetPVarInt(playerid, "Admin") < 2)return SendMessage(playerid, "You can't use this command!");
new buyprice, tax, des[40], rooms;
if(sscanf(params, "iiis", buyprice, tax, rooms, des))
{
SendMessage(playerid, "USAGE: /makehouse [buy price] [tax percentage] [Rooms] [Description]");
return 1;
}
new Float:X,Float:Y,Float:Z;
new Owner[24];
Owner = "No-One";
new vw = 10 + random(8999);
GetPlayerPos(playerid, X,Y,Z);
AddHouse(Owner, X, Y, Z, buyprice, rooms, tax, vw, des);
SendMessage(playerid, "House Made ");
return 1;
}

cmd(makebuilding, playerid, params[])
{
if(GetPVarInt(playerid, "Admin") < 2)return SendMessage(playerid, "You can't use this command!");
new buyprice, tax, description[50], slots;
if(sscanf(params, "iiis", buyprice, tax, slots, description))
{
SendMessage(playerid, "USAGE: /makehouse [buy price] [tax percentage] [Shares Slots] [description]");
return 1;
}
new Float:X,Float:Y,Float:Z;
new Owner[24];
Owner = "No-One";
new vw = 10 + random(8999);
GetPlayerPos(playerid, X,Y,Z);
AddBuilding(Owner, description, X, Y, Z, 2324.651611, -1148.913330, 1050.710083, 0, buyprice, 12, 0, tax, vw, slots);
SendMessage(playerid, "Building Made ");
return 1;
}

cmd(buildingint, playerid, parmas[])
{
if(GetPVarInt(playerid, "Admin") < 2)return SendMessage(playerid, "You can't use this command!");
new proplev;
if(sscanf(parmas, "i", proplev)){SendMessage(playerid, "System: /buildingint [buildingid] - Were you are now is were the building int is made.");return 1;}
if(proplev > sizeof(BuildingInfo) || proplev < 0){SendClientMessage(playerid,white,"Building ID must be above 0 and below 250");return 1;}
else{
new Float:X,Float:Y,Float:Z;GetPlayerPos(playerid,X,Y,Z);
BuildingInfo[proplev][bExitx] = X;BuildingInfo[proplev][bExity] = Y;BuildingInfo[proplev][bExitz] = Z;BuildingInfo[proplev][bInteriorId] = GetPlayerInterior(playerid);
UpdateBuilding(proplev);}
return 1;
}

cmd(movebuilding, playerid, parmas[])
{
if(GetPVarInt(playerid, "Admin") < 2)return SendMessage(playerid, "You can't use this command!");
new proplev;
if(sscanf(parmas, "i", proplev)){SendMessage(playerid, "System: /movebuilding [buildingid] - Were you are now is were the building will be made.");return 1;}
if(proplev > sizeof(BuildingInfo) || proplev < 0){SendClientMessage(playerid,white,"Building ID must be above 0 and below 250");return 1;}
else{
new Float:X,Float:Y,Float:Z;GetPlayerPos(playerid,X,Y,Z);
BuildingInfo[proplev][bEntrancex] = X;BuildingInfo[proplev][bEntrancey] = Y;BuildingInfo[proplev][bEntrancez] = Z;
UpdateBuilding(proplev);SendMessage(playerid, "Building Moved ");}
return 1;
}

cmd(movehouse, playerid, parmas[])
{
if(GetPVarInt(playerid, "Admin") < 2)return SendMessage(playerid, "You can't use this command!");
new proplev;
if(sscanf(parmas, "i", proplev)){SendMessage(playerid, "System: /movehouse [houseid] - Were you are now is were the house will be made.");return 1;}
if(proplev > sizeof(HouseInfo) || proplev < 0){SendClientMessage(playerid,white,"House ID must be above 0 and below 250");return 1;}
else{
new Float:X,Float:Y,Float:Z;GetPlayerPos(playerid,X,Y,Z);
HouseInfo[proplev][hEntrancex] = X;HouseInfo[proplev][hEntrancey] = Y;HouseInfo[proplev][hEntrancez] = Z;
UpdateHouse(proplev);SendMessage(playerid, "House Moved ");}
return 1;
}

cmd(houseint, playerid, parmas[])
{
if(GetPVarInt(playerid, "Admin") < 2)return SendMessage(playerid, "You can't use this command!");
new proplev;
if(sscanf(parmas, "i", proplev)){SendMessage(playerid, "System: /houseint [houseid] - Were you are now is were the house int is made.");return 1;}
if(proplev > sizeof(HouseInfo) || proplev < 0){SendClientMessage(playerid,white,"House ID must be above 0 and below 250");return 1;}
else{
new Float:X,Float:Y,Float:Z;GetPlayerPos(playerid,X,Y,Z);
HouseInfo[proplev][hExitx] = X;HouseInfo[proplev][hExity] = Y;HouseInfo[proplev][hExitz] = Z;HouseInfo[proplev][hInteriorId] = GetPlayerInterior(playerid);
UpdateHouse(proplev);}
return 1;
}

cmd(test, playerid, params[])
{
if(sscanf(params, "s", params)) return SendMessage(playerid, "/test [text]");
SendMessage(playerid, params);
return 1;
}

cmd(coolmode, playerid, params[])
{
if(GetPVarInt(playerid,"CoolMode") == 0)
{
SetPVarInt(playerid, "CoolMode", 1);
SendMessage(playerid,"Coolmode is enabled.");
}else{
SetPVarInt(playerid, "CoolMode", 0);
SetCameraBehindPlayer(playerid);
SendMessage(playerid,"Coolmode is disabled.");
}
/*
if(GetPVarInt(i, "CoolMode") == 1)
{
new Float:x,Float:y,Float:z;
new Float:x1,Float:y1,Float:z1;
GetPlayerPos(i, x1, y1, z1);
GetPlayerCameraPos(i, x, y, z);
if(!IsPlayerInRangeOfPoint(i, 6.0, x, y, z))
{
SetPlayerCameraPos(i, x1+2, y1+5, z1+6);
SetPlayerCameraLookAt(i, x1, y1, z1);
}
}*/
return 1;
}


cmd(vehid, playerid, parmas[])
{
new string[100];new carid = GetPlayerVehicleID(playerid);if(IsPlayerConnected(playerid)){if(IsPlayerInAnyVehicle(playerid)){
format(string, sizeof(string), "* Vehicle ID: %d.", carid);SendMessage(playerid, string);
format(string, sizeof(string), "* Vehicle ID of vehinfo: %d.", vehinfo[carid][cVehid]);SendMessage(playerid, string);return 1;}}
return 1;
}

function stopanim(playerid)
{
ClearAnimations(playerid);
ClearAnimations(playerid);
SetPlayerFacingAngle(playerid, 137.5702);
return 1;
}

cmd(sleep, playerid, parmas[])
{
new Float:health;GetPlayerHealth(playerid, health);
if(health > 99)return SendMessage(playerid, " You don't need to sleep your health is full");
if(GetPVarInt(playerid, "Sleeping") != 0) return KillTimer(GetPVarInt(playerid, "Sleeping")), SetPVarInt(playerid, "Sleeping", 2), SendMessage(playerid, "You woke your self up."), SetTimerEx("Sleep", 1000, 0, "i", playerid);
if(!MyHouse(playerid, GetPVarInt(playerid, "HouseIn")))return SendMessage(playerid, " Go to your house or your rented house!");
if(GetPVarInt(playerid, "HouseIn") != GetPVarInt(playerid, "RentId") && !MyHouse(playerid, GetPVarInt(playerid, "HouseIn"))) return SendMessage(playerid, " Go to your house or your rented house!");
if(health >= 1 && health <= 99)
ApplyAnimation(playerid,"CRACK","crckidle4",4.1,0,1,1,1,0),
TextDrawShowForPlayer(playerid, Window[0]),
TextDrawShowForPlayer(playerid, Window[1]),
SetPVarInt(playerid, "Sleeping", SetTimerEx("Sleep", 1000, 1, "i", playerid));
return 1;
}

cmd(update, playerid, parmas[])
{
if (GetPVarInt(playerid, "Admin") >= 1)
{
SaveAccounts();
SendMessage(playerid, "All player accounts updated successfully.");
SetTimer("LoadUpShit", 1000, 0);
}
return 1;
}

cmd(getcar, playerid, parmas[])
{
new plo;
if(sscanf(parmas, "i", plo))return SendMessage(playerid, "/getcar [carid]");
new Float:plocx,Float:plocy,Float:plocz;
if(GetPVarInt(playerid, "Admin") < 3) return 1;
GetPlayerPos(playerid, plocx, plocy, plocz);
SetVehiclePos(plo,plocx,plocy+4, plocz);
return 1;
}

cmd(gotoc, playerid, params[])
{
if(GetPVarInt(playerid, "Admin") > 2){
new Float:x, Float:y, Float:z, intt;
if(sscanf(params, "fffi", x, y, z, intt))return SendMessage(playerid, "/gotoc [float1] [float2] [float3] [int]");
SetPlayerPos(playerid, x, y, z);
SetPlayerInterior(playerid, intt);}
return 1;
}

cmd(stop, playerid, parmas[])
{
new vehicle = GetPlayerVehicleID(playerid), string[70];
if(engineOn[vehicle] == 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER){SendMessage(playerid, " Your Engine Is Not On!");return 1;}
ClearTextDraws(playerid);
TogglePlayerControllable(playerid, 0);engineOn[GetPlayerVehicleID(playerid)] = false;
SendMessage(playerid, "You Turned Your Engine Off! use /leave to exit the car");SendMessage(playerid, "Hint: Type /start to bring up engine menu");
format(string, sizeof(string), " %s Turn's off his engine!", GetPlayerNameEx(playerid));ProxDetector(30.0, playerid, string, purple,purple,purple,purple,purple);
return 1;
}

cmd(start, playerid, parmas[])
{
new playerstate = GetPlayerState(playerid);
if(IsPlayerInAnyVehicle(playerid) && playerstate == PLAYER_STATE_DRIVER){
new newcar = GetPlayerVehicleID(playerid);
if(engineOn[newcar] == 1){
SendMessage(playerid, " Your Engine Is Already On!");return 1;}
ShowVehInfo1(playerid);
}
return 1;
}

cmd(engine, playerid, parmas[])
{
new playerstate = GetPlayerState(playerid), newcar = GetPlayerVehicleID(playerid), string[70];
if(IsPlayerInAnyVehicle(playerid) && playerstate == PLAYER_STATE_DRIVER)
{
if(engineOn[newcar] == 1)
{
ClearTextDraws(playerid);
TogglePlayerControllable(playerid, 0);
engineOn[GetPlayerVehicleID(playerid)] = false;
SendMessage(playerid, "You Turned Your Engine Off! use /leave to exit the car");
SendMessage(playerid, "Hint: Type /start to bring up engine menu");
format(string, sizeof(string), " %s Turn's off his engine!", GetPlayerNameEx(playerid));
ProxDetector(30.0, playerid, string, purple,purple,purple,purple,purple);
}
else if(engineOn[newcar] == 0) ShowVehInfo1(playerid);
}
return 1;
}

cmd(pm, playerid, parmas[])
{
new id, Message[256], gMessage[256];
if(sscanf(parmas, "us", id, gMessage))return SendMessage(playerid,"Usage: /pm (id) (message)");
if(!IsPlayerConnected(id)) return SendMessage(playerid, "/pm : Bad player ID");
if(playerid != id) {
format(Message,sizeof(Message)," [%s](%d): %s",GetPlayerNameEx(id),id,gMessage);SendClientMessage(playerid,yellow,Message);
format(Message,sizeof(Message),"%s(%d): %s",GetPlayerNameEx(playerid),playerid,gMessage);SendClientMessage(id,green,Message);
PlayerPlaySound(id,1085,0.0,0.0,0.0);printf("PM: %s",Message);}else {SendClientMessage(playerid,red,"You cannot PM yourself");}
return 1;
}

cmd(leave, playerid, parmas[])
{
if(IsPlayerInAnyVehicle(playerid)){TogglePlayerControllable(playerid, 1);RemovePlayerFromVehicle(playerid);}else{SendMessage(playerid, "You Aint In Any Vehicle!");}
return 1;
}

cmd(entercar, playerid, parmas[])
{
if(GetPVarInt(playerid, "Admin") < 3) return 1;
new testcar;
if(sscanf(parmas, "i", testcar))return SendMessage(playerid, "USAGE: /entercar [carid]");
PutPlayerInVehicle(playerid, testcar, 1);
return 1;
}

cmd(entercar1, playerid, parmas[])
{
if(GetPVarInt(playerid, "Admin") < 3) return 1;
new testcar, seat;
if(sscanf(parmas, "ii", testcar, seat))return SendMessage(playerid, "USAGE: /entercar [carid] [seat]");
PutPlayerInVehicle(playerid, testcar, seat);
return 1;
}

cmd(plant, playerid, parmas[])
{
if(CheckLand(playerid) == 0){SendMessage(playerid, "You are not in a area that can be planted in, you can ask a admin to add land.");return 1;}
if(GetPVarInt(playerid, "Team") < civ){SendMessage(playerid, "You Aint a Civilian!");return 1;}
if(IsPlayerInAnyVehicle(playerid)){SendMessage(playerid, "You Cant Plant While Driving!!");return 1;}
if(GetPVarInt(playerid, "HasSeed") == 0){SendMessage(playerid, "You don't have any seed's");return 1;}
if(GetPVarInt(playerid, "Planted") == 1){SendMessage(playerid, "You have already planted a plant wait until its grown");return 1;}
new Float:x,Float:y,Float:z, str[80];
GetPlayerPos(playerid, x, y, z);
GetXYInFrontOfPlayer(playerid, x, y, 0.7);
SetPVarFloat(playerid,"Weedx",x);
SetPVarFloat(playerid,"Weedy",y);
SetPVarFloat(playerid,"Weedz",z);
SendMessage(playerid, " You Just Planted Your Plant Please Wait 30 Minutes Before It's Grown");
ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0,0,0,0,0,0);
SetPVarInt(playerid,"WeedObject", CreateDynamicObject(3409, GetPVarFloat(playerid,"Weedx"), GetPVarFloat(playerid,"Weedy"),GetPVarFloat(playerid,"Weedz") -2.1,0,0,0));
SetPVarInt(playerid,"WeedTimer",SetTimerEx("WeedTimer",1800000,0, "i", playerid));
SetPVarInt(playerid, "Planted", 1);
SetPVarInt(playerid, "HasSeed", GetPVarInt(playerid, "HasSeed") -1);
SetPVarInt(playerid,"WeedReady", 0);
SetPVarInt(playerid,"WeedTimeLeft", 30);
format(str, sizeof(str), "Weed Plant\nOwner: %s\n Time till grown: %d Minutes",GetPlayerNameEx(playerid),GetPVarInt(playerid,"WeedTimeLeft"));
SetPVarInt(playerid,"WeedLogo",_:CreateDynamic3DTextLabel(str, 0x96FFFF, x, y, z+2,40));
SetPVarInt(playerid,"WeedGrown", SetTimerEx("WeedGrow",60000,1, "i", playerid));
return 1;
}

cmd(harvest, playerid, parmas[])
{
new string[110];
if(!IsPlayerInRangeOfPoint(playerid, 3, GetPVarFloat(playerid,"Weedx"), GetPVarFloat(playerid,"Weedy"),GetPVarFloat(playerid,"Weedz"))){SendMessage(playerid, "Your not at the plant you planted.");return 1;}
if(GetPVarInt(playerid,"WeedReady") == 0){format(string, sizeof(string), "Your plant isn't ready yet still another %d minutes left, you will be notified when it is done.",GetPVarInt(playerid,"WeedTimeLeft"));SendMessage(playerid, string);return 1;}
DestroyDynamicObject(GetPVarInt(playerid,"WeedObject"));SetPVarInt(playerid, "Planted", 0);
new drugamount = 4+random(30-4);
format(string, sizeof(string), "You got %d gram's of marijuana from this plant",drugamount);
SendMessage(playerid, string);
DestroyDynamic3DTextLabel(Text3D:GetPVarInt(playerid,"WeedLogo"));
SetPVarInt(playerid,"WeedLogo", 0);
SetPVarInt(playerid, "WeedObject", 0);
UpExp(playerid);
SetPVarInt(playerid, "Drugs", GetPVarInt(playerid, "Drugs") +drugamount);
return 1;
}

cmd(smoke, playerid, parmas[])
{
if(GetPVarInt(playerid, "Drugs") == 0) return SendMessage(playerid, "You need drugs before you can use them.");
if(!IsPlayerInAnyVehicle(playerid)) SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);
if(GetPVarInt(playerid, "DrugEffectTimer") != 0) KillTimer(GetPVarInt(playerid, "DrugEffectTimer"));
if(GetPVarInt(playerid, "DrugCheckTimer") != 0) KillTimer(GetPVarInt(playerid, "DrugCheckTimer"));
SetPVarInt(playerid, "DrugEffectTimer", SetTimerEx("DrugEffectGone", 180000, 0, "i", playerid));
SetPVarInt(playerid, "DoneDrugs", GetPVarInt(playerid, "DoneDrugs") +1000);
SetPlayerDrunkLevel(playerid, GetPVarInt(playerid, "DoneDrugs")*2);
SendMessage(playerid, "You used 1 gram of marijuana to roll a blunt.");
SetPVarInt(playerid, "DrugCheckTimer", SetTimerEx("DrugEffect", 3000, 1, "i", playerid));
return 1;
}

cmd(addland, playerid, parmas[])
{
if(GetPVarInt(playerid, "Admin") < 2)return 1;
new Float:flo, Float:x, Float:y, Float:z;
if(sscanf(parmas, "f", flo))return SendMessage(playerid, "/addland [Land Size/ Enter In Float]");
GetPlayerPos(playerid, x, y, z);
AddLand(x, y, z, flo);
SendMessage(playerid, "Land added");
return 1;
}

cmd(cpanel, playerid, params[])
{
ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "User Control Panel", "Account Details\nGame Rules\nGame Commands\nMy Stats\nHelp Centre\nReport Someone\nVehicle's\nGang's Information\nProperties", "Select", "Close");
return 1;
}

cmd(areg, playerid, params[])
{
if(GetPVarInt(playerid, "Admin") < 3)return 1;
if(Reg == 0)return Reg = 1, SendMessage(playerid, "User's must now register from the website (( www.city-rp.com ))");
if(Reg == 1)return Reg = 0, SendMessage(playerid, "User's can now register ingame.");
return 1;
}

cmd(phone, playerid, params[])
{
if(GetPVarInt(playerid, "Calling") != 0) return SendMessage(playerid, "Your already waiting on a call type /hangup to end your current call.");
if(GetPVarInt(playerid, "Number") == 0) return SendMessage(playerid, "You need to buy a phone from a store before you can make any call/text.");
if(GetPVarInt(playerid, "PickedUp") == 0)
ShowPlayerDialog(playerid, 31, DIALOG_STYLE_LIST, "Mobile Phone", "Dial A Number\nCall Police\nCall Medic\nSend A Text\nRead Last Message", "Select", "Close");
if(GetPVarInt(playerid, "PickedUp") != 0)
ShowPlayerDialog(playerid, 31, DIALOG_STYLE_LIST, "Mobile Phone", "Dial A Number\nCall Police\nCall Medic\nSend A Text\nRead Last Message\nAnswer Your Phone", "Select", "Close");
return 1;
}

cmd(p, playerid, params[])
{
new string[128];
if(GetPVarInt(playerid, "CanTalk") == 0) return SendMessage(playerid,"Your not on the phone.");
if(isnull(params)) return SendMessage(playerid, "use /p [your text here] to talk over the phone.");
if(GetPVarInt(playerid, "PickedUp") != 0) return format(string, sizeof(string), "Caller %s Says: %s", GetPlayerNameEx(GetPVarInt(playerid, "Calling")), params), SendClientMessage(GetPVarInt(playerid, "Caller"), lightgreen, string),
format(string, sizeof(string), "You Said: %s", params), SendClientMessage(GetPVarInt(playerid, "Calling"), yellow, string);

format(string, sizeof(string), "Caller %s Says: %s", GetPlayerNameEx(GetPVarInt(playerid, "Caller")), params);
SendClientMessage(GetPVarInt(playerid, "Calling"), lightgreen, string);

format(string, sizeof(string), "You Said: %s",  params);
SendClientMessage(GetPVarInt(playerid, "Caller"), yellow, string);
return 1;
}

cmd(hangup, playerid, params[])
{
if(GetPVarInt(playerid, "Caller") != 0) SendMessage(GetPVarInt(playerid, "Caller"), "The line hung up.");
if(GetPVarInt(playerid, "Calling") != 0) SendMessage(GetPVarInt(playerid, "Calling"), "The line hung up.");
HangUp(playerid);
return 1;
}

cmd(stoptrace, playerid, parmas[])
{
if(GetPVarInt(playerid, "TraceTimer") == 0) return SendMessage(playerid, "Your not tracing anyone.");
if(GetPVarInt(playerid, "TraceTimer") != 0) KillTimer(GetPVarInt(playerid, "TraceTimer")), SendMessage(playerid, "You stopped tracing your victem."), DisablePlayerCheckpoint(playerid);
return 1;
}

cmd(case, playerid, parmas[])
{
new scase[30];
if(GetPVarInt(playerid, "CaseIdOn") != 0) return format(scase, sizeof(scase), "Case ID: %d",GetPVarInt(playerid, "CaseIdOn")), ShowPlayerDialog(playerid, 35, DIALOG_STYLE_LIST, scase, "Reporter's Information\nTrace Reporter\nCall Reporter\nSolved Case", "Select", "Close");
ShowPlayerDialog(playerid,34,DIALOG_STYLE_INPUT,"Enter Case Number","Please enter the case number you wish to follow up.","take","Back");
return 1;
}

cmd(rv, playerid, parmas[])
{
if(GetPVarInt(playerid, "Admin") < 1) return 1;
SetTimer("RespawnVehicles", 10000, 0);
SendClientMessageToAll(orange,"------------------------------------------------------------------");
SendClientMessageToAll(lightgreen,"  All Empty Vehicles Will Respawn In 10 Seconds  ");
SendClientMessageToAll(orange,"------------------------------------------------------------------");
return 1;
}

cmd(cuff, playerid, parmas[])
{
if(GetPVarInt(playerid, "Team") != cop) return 1;
new suspect ,Float:x,Float:y,Float:z,string[128];
if(sscanf(parmas, "i", suspect)) return SendMessage(playerid, "/cuff [players id here].");
if(!IsPlayerConnected(suspect)) return SendMessage(playerid, "That person isn't online");
if(suspect == playerid) return SendMessage(playerid, "You can't cuff your self!");
if(GetPVarInt(playerid, "Holding") != 0) return SendMessage(playerid, "You can only cuff one person at a time.");
GetPlayerPos(suspect, x,y,z);
if(!IsPlayerInRangeOfPoint(playerid, 2, x,y,z)) return SendMessage(playerid, "You must be within 2 metre's to cuff your suspect.");
SetPVarInt(playerid, "Holding", suspect);
SetPVarInt(suspect, "Stopping", playerid);
SetPVarInt(suspect, "CuffTimer", SetTimerEx("followcop", 1000, 1, "i", suspect));
format(string, sizeof(string), "You cuffed %s, He will now automaticlly follow you around even into vehicle's.",  GetPlayerNameEx(suspect));
SendMessage(playerid, string);
return 1;
}

cmd(uncuff, playerid, parmas[])
{
if(GetPVarInt(playerid, "Team") != cop) return 1;
new suspect, string[90];
if(sscanf(parmas, "i", suspect)) return SendMessage(playerid, "/uncuff [players id here].");
if(!IsPlayerConnected(suspect)) return SendMessage(playerid, "That person isn't online");
if(GetPVarInt(playerid,"Holding") != suspect) return SendMessage(playerid, "You can only uncuff the person you cuffed.");
KillTimer(GetPVarInt(GetPVarInt(playerid, "Holding"), "CuffTimer"));
format(string, sizeof(string), "You uncuffed %s",GetPlayerNameEx(GetPVarInt(playerid, "Holding")));
SendMessage(playerid, string);
format(string, sizeof(string), "You was uncuffed by %s",GetPlayerNameEx(playerid));
SendMessage(GetPVarInt(playerid, "Holding"), string);
SetPVarInt(GetPVarInt(playerid, "Holding"), "Stopping", 0);
ClearAnimations(GetPVarInt(playerid, "Holding"));
SetPVarInt(playerid, "Holding", 0);
return 1;
}

cmd(map, playerid, parmas[])
{
ShowPlayerDialog(playerid, 43, DIALOG_STYLE_LIST, "City Role Play Map", "Building Locations\nOther Locations", "Select", "Close");
return 1;
}

cmd(docar, playerid, parmas[])
{
if(GetPVarInt(playerid, "Admin") < 2) return 1;
if(GetPVarInt(playerid, "DoCar") == 0) return SetPVarInt(playerid, "DoCar", 1), SendMessage(playerid,"You now can enter any vehicle");
if(GetPVarInt(playerid, "DoCar") == 1) return SetPVarInt(playerid, "DoCar", 0), SendMessage(playerid,"Your vehicle status is back to normal");
return 1;
}

cmd(speedgun, playerid, parmas[])
{
if(GetPVarInt(playerid, "Team" ) != cop) return SendMessage(playerid, "You need to be a cop to use this.");
if(GetPVarInt(playerid, "SpeedGunStat") == 1) return KillTimer(GetPVarInt(playerid, "SpeedGunTimer")), SetPVarInt(playerid, "SpeedGunStat", 0), TextDrawDestroy(Text:GetPVarInt(playerid, "SpeedoDraw")), SendMessage(playerid, "You turned your speedo gun off");
SetPVarInt(playerid, "SpeedGunTimer", SetTimerEx("GetCarSpeed", 1000, 1, "i", playerid)); GivePlayerWeapon(playerid, 43, 1); SendMessage(playerid, "You turned on your speed gun.");
SetPVarInt(playerid, "SpeedoDraw", _:TextDrawCreate(21.000000,110.000000, "Not Aming On Any Vehicle Yet."));
TextDrawUseBox(Text:GetPVarInt(playerid, "SpeedoDraw"),1);
TextDrawBoxColor(Text:GetPVarInt(playerid, "SpeedoDraw"),0x00000033);
TextDrawTextSize(Text:GetPVarInt(playerid, "SpeedoDraw"),286.000000,-3.000000);
TextDrawAlignment(Text:GetPVarInt(playerid, "SpeedoDraw"),0);
TextDrawBackgroundColor(Text:GetPVarInt(playerid, "SpeedoDraw"),0x000000ff);
TextDrawFont(Text:GetPVarInt(playerid, "SpeedoDraw"),1);
TextDrawLetterSize(Text:GetPVarInt(playerid, "SpeedoDraw"),0.399999,1.300000);
TextDrawColor(Text:GetPVarInt(playerid, "SpeedoDraw"),0xffffffff);
TextDrawSetProportional(Text:GetPVarInt(playerid, "SpeedoDraw"),1);
TextDrawSetShadow(Text:GetPVarInt(playerid, "SpeedoDraw"),1);
SetPVarInt(playerid, "SpeedGunStat", 1);
TextDrawShowForPlayer(playerid, Text:GetPVarInt(playerid, "SpeedoDraw"));
return 1;
}

cmd(join, playerid, parmas[])
{
if(GetPVarInt(playerid, "Asking") == 0) return SendMessage(playerid, "No one is inviting you to join there gang.");
new id = GetPVarInt(GetPVarInt(playerid, "Asking"), "GangId"), string[70];
format(string, sizeof(string), "%s Has accepted your invitation and is now apart of %s.",GetPlayerNameEx(playerid), GangInfo[GetPVarInt(id, "GangId")][gName]);
SendMessage(id, string);
format(string, sizeof(string), "You have now joined %s",GangInfo[GetPVarInt(id, "GangId")][gName]);
SendMessage(playerid, string);
GangInfo[id][gMembers] ++;
UpdateGang(id);
return 1;
}

cmd(logout, playerid, parmas[])
{
if(GetPVarInt(playerid, "LoggingOut") == 0) SetPVarInt(playerid, "LoggingOut", 1), SendMessage(playerid, "You will now logout after your next death.");
else if(GetPVarInt(playerid, "LoggingOut") == 1) SetPVarInt(playerid, "LoggingOut", 0), SendMessage(playerid, "You cancelled logging out after your next death.");
return 1;
}

cmd(makeadmin, playerid, parmas[])
{
if(GetPVarInt(playerid, "Admin") < 3) return 1;
new id, level, string[70];
if(sscanf(parmas, "ii", id,level)) return SendMessage(playerid, "Make admin is like /makeadmin [id] [level]");
format(string, sizeof(string),"You was made admin level %d by %s", level, GetPlayerNameEx(playerid));SendClientMessage(id, lightgreen, string);
format(string, sizeof(string),"You was made %s admin with level %d", GetPlayerNameEx(id), level);SendMessage(playerid, string);
SetPVarInt(id, "Admin", level);
OnUpdatePlayer(id);
return 1;
}

cmd(addname, playerid, parmas[])
{
if(GetPVarInt(playerid, "Admin") < 3) return 1;
new name[30], string[60];
if(sscanf(parmas, "s", name)) return SendMessage(playerid, "Format must be /addname [NAME HERE] only.");
if(CheckAllowName(name) == 1) return SendMessage(playerid, "That name already exist.");
AddName(name);
format(string, sizeof(string), "Name added as %s", name);
return 1;
}

cmd(me, playerid, parmas[])
{
new string[80];
if(sscanf(parmas, "s", parmas)) return SendMessage(playerid, "/me | Action Here | ");
if(strlen(parmas) > 50) return SendMessage(playerid, "Error: message to long.");
SetPlayerChatBubble(playerid, parmas, purple, 20.0, 5000);
format(string, sizeof(string), "%s %s",GetPlayerNameEx(playerid), parmas);
ProxDetector(30.0, playerid, string, purple,purple,purple,purple,purple);
return 1;
}

cmd(ooc, playerid, params[])
{
if(sscanf(params, "s", params)) return SendMessage(playerid, "/ooc | Text Here | ");
if(strlen(params) > 120) return SendMessage(playerid,"Please Shorten Your Message!");
if(ooc == 1) return SendMessage(playerid, "OOC has been turned off.");
new Text[MAX_PLAYER_NAME+10], Name[MAX_PLAYER_NAME+5];
GetPlayerName(playerid,Name,sizeof(Name));
format(Text,sizeof(Text),"[OOC]%s[%d]",Name,playerid);
SetPlayerName(playerid,Text);
SendPlayerMessageToAll(playerid,params);
SetPlayerName(playerid,Name);
return 1;
}

cmd(o, playerid, params[])
{
return cmd_ooc(playerid, params);
}

cmd(exitcar, playerid, params[])
{
return cmd_leave(playerid, params);
}

cmd(noooc, playerid, params[])
{
if(GetPVarInt(playerid, "Admin") < 1) return 1;
if(ooc == 1) ooc = 0, SendMessage(playerid, "OOC Enabled.");
else if(ooc == 0) ooc = 1, SendMessage(playerid, "OOC Disabled.");
return 1;
}

cmd(talk, playerid, params[])
{
ShowPlayerDialog(playerid, 82, DIALOG_STYLE_LIST, "Talking Mode", "Normal\nShout\nWhispers", "Select", "Close");
return 1;
}

stock GetString(playerid, var[])
{
new string[160];
GetPVarString(playerid, var, string, sizeof(string));
return string;
}

function MyVehicle(playerid, vehicleid)
{
vehicleid = vehinfo[vehicleid][cVehid];
if(GetPVarInt(playerid, "Vehicle0") == vehicleid)return 1;
if(GetPVarInt(playerid, "Vehicle1") == vehicleid)return 1;
if(GetPVarInt(playerid, "Vehicle2") == vehicleid)return 1;
if(GetPVarInt(playerid, "Vehicle3") == vehicleid)return 1;
if(GetPVarInt(playerid, "Vehicle4") == vehicleid)return 1;
if(GetPVarInt(playerid, "Vehicle5") == vehicleid)return 1;
return 0;
}

// MySQL Setting's

function MySQLConnect(sqlhost[], sqluser[], sqlpass[], sqldb[])
{
	print("MYSQL: Attempting to connect to server...");
	samp_mysql_connect(sqlhost, sqluser, sqlpass);
	samp_mysql_select_db(sqldb);
	if(samp_mysql_ping()==0)
	{
		print("MYSQL: Database connection established.");
		return 1;
	}
	else
	{
		print("MYSQL: Connection error, retrying...");
		samp_mysql_connect(sqlhost, sqluser, sqlpass);
		samp_mysql_select_db(sqldb);
		if(samp_mysql_ping()==0)
		{
			print("MYSQL: Reconnection successful. We can continue as normal.");
			return 1;
		}
		else
		{
			print("MYSQL: Could not reconnect to server, terminating server...");
			SendRconCommand("exit");
			return 0;
		}
	}
}

function MySQLDisconnect()
{
	samp_mysql_close();
	return 1;
}

function MySQLCheckConnection()
{
	if(samp_mysql_ping()==0)
	{
		return 1;
	}
	else
	{
		print("MYSQL: Connection seems dead, retrying...");
		MySQLDisconnect();
		MySQLConnect(MYSQL_HOST,MYSQL_USER,MYSQL_PASS,MYSQL_DB);
		if(samp_mysql_ping()==0)
		{
			print("MYSQL: Reconnection successful. We can continue as normal.");
			return 1;
		}
		else
		{
			print("MYSQL: Could not reconnect to server, terminating server...");
			SendRconCommand("exit");
			return 0;
		}
	}
}

function MySQLUpdateBuild(query[], sqlplayerid)
{
	new querylen = strlen(query);
	new querymax = MAX_STRING;
	if (querylen < 1) format(query, querymax, "UPDATE players SET ");
	else if (querymax-querylen < 50)
	{
		new whereclause[32];
		format(whereclause, sizeof(whereclause), " WHERE id=%d", sqlplayerid);
		strcat(query, whereclause, querymax);
		samp_mysql_query(query);
		format(query, querymax, "UPDATE players SET ");
	}
	else if (strfind(query, "=", true) != -1) strcat(query, ",", MAX_STRING);
	return 1;
}

function MySQLUpdateFinish(query[], sqlplayerid)
{
	if (strcmp(query, "WHERE id=", false) == 0) samp_mysql_query(query);
	else
	{
		new whereclause[32];
		format(whereclause, sizeof(whereclause), " WHERE id=%d", sqlplayerid);
		strcat(query, whereclause, MAX_STRING);
		samp_mysql_query(query);
		format(query, MAX_STRING, "UPDATE players SET ");
	}
	return 1;
}

function MySQLUpdatePlayerInt(query[], sqlplayerid, sqlvalname[], sqlupdateint)
{
	MySQLUpdateBuild(query, sqlplayerid);
	new updval[64];
	format(updval, sizeof(updval), "%s=%d", sqlvalname, sqlupdateint);
	strcat(query, updval, MAX_STRING);
	return 1;
}

function MySQLUpdatePlayerFlo(query[], sqlplayerid, sqlvalname[], Float:sqlupdateflo)
{
	new flotostr[32];
	format(flotostr, sizeof(flotostr), "%f", sqlupdateflo);
	MySQLUpdatePlayerStr(query, sqlplayerid, sqlvalname, flotostr);
	return 1;
}

function MySQLUpdatePlayerStr(query[], sqlplayerid, sqlvalname[], sqlupdatestr[])
{
	MySQLUpdateBuild(query, sqlplayerid);
	new escstr[128];
	new updval[128];
	samp_mysql_real_escape_string(sqlupdatestr, escstr);
	format(updval, sizeof(updval), "%s='%s'", sqlvalname, escstr);
	strcat(query, updval, MAX_STRING);
	return 1;
}

function MySQLUpdatePlayerIntSingle(sqlplayerid, sqlvalname[], sqlupdateint)
{
	new query[128];
	format(query, sizeof(query), "UPDATE players SET %s=%d WHERE id=%d", sqlvalname, sqlupdateint, sqlplayerid);
	samp_mysql_query(query);
	return 1;
}

function MySQLCheckAccount(sqlplayersname[])
{
	new query[128];
	new escstr[MAX_PLAYER_NAME+6];
	samp_mysql_real_escape_string(sqlplayersname, escstr);
	format(query, sizeof(query), "SELECT id FROM players WHERE LOWER(username) = LOWER('%s') LIMIT 1", escstr);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if (samp_mysql_num_rows()==0)
	{
		return 0;
	}
	else
	{
		new strid[32];
		new intid;
		samp_mysql_fetch_row(strid);
		intid = strval(strid);
		return intid;
	}
}

function CheckAllowName(sqlplayersname[])
{
	new query[128];
	new escstr[60];
	samp_mysql_real_escape_string(sqlplayersname, escstr);
	format(query, sizeof(query), "SELECT id FROM names WHERE name='%s' LIMIT 1", escstr);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if (samp_mysql_num_rows()==0)
	{
		return 0;
	}
	else
	{
		new strid[32];
		new intid;
		samp_mysql_fetch_row(strid);
		intid = strval(strid);
		return intid;
	}
}

function CheckGangOwn(sqlplayersname[])
{
	new query[128];
	new escstr[60];
	samp_mysql_real_escape_string(sqlplayersname, escstr);
	format(query, sizeof(query), "SELECT gangid FROM gangs WHERE LOWER(leader) = LOWER('%s') LIMIT 1", escstr);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if (samp_mysql_num_rows()==0)
	{
		return 0;
	}
	else
	{
		new strid[32];
		new intid;
		samp_mysql_fetch_row(strid);
		intid = strval(strid);
		return intid;
	}
}

function CheckGang(sqlplayersname[])
{
	new query[128];
	new escstr[60];
	samp_mysql_real_escape_string(sqlplayersname, escstr);
	format(query, sizeof(query), "SELECT gangid FROM gangs WHERE LOWER(name) = LOWER('%s') LIMIT 1", escstr);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if (samp_mysql_num_rows()==0)
	{
		return 0;
	}
	else
	{
		new strid[32];
		new intid;
		samp_mysql_fetch_row(strid);
		intid = strval(strid);
		return intid;
	}
}

function MySQLCheckNameBanned(name[])
{
	new query[170];
	format(query, sizeof(query), "SELECT banid FROM bans WHERE banned = '%s' ORDER BY banid DESC LIMIT 1", name);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if (samp_mysql_num_rows() != 0)
	{
		new bantypestr[4];
		new bantypeint;
		samp_mysql_fetch_row(bantypestr);
		bantypeint = strval(bantypestr);
		samp_mysql_free_result();
		return bantypeint;
	}
	return 0;
}

function MySQLCheckIPBanned(ip[])
{
	new query[170];
	format(query, sizeof(query), "SELECT banid FROM bans WHERE bannedip = '%s' ORDER BY banid DESC LIMIT 1", ip);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if (samp_mysql_num_rows() != 0)
	{
		new bantypestr[4];
		new bantypeint;
		samp_mysql_fetch_row(bantypestr);
		bantypeint = strval(bantypestr);
		samp_mysql_free_result();
		return bantypeint;
	}
	return 0;
}

function MySQLFetchAcctSingle(sqlplayerid, sqlvalname[], sqlresult[])
{
	new query[128];
	format(query, sizeof(query), "SELECT %s FROM players WHERE id = %d LIMIT 1", sqlvalname, sqlplayerid);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if(samp_mysql_fetch_row(sqlresult)==1)
	{
		return 1;
	}
	return 0;
}

function MySQLFetchAcctRecord(sqlplayerid, sqlresult[])
{
	new query[64];
	format(query, sizeof(query), "SELECT * FROM players WHERE id = %d LIMIT 1", sqlplayerid);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if(samp_mysql_fetch_row(sqlresult)==1)
	{
		return 1;
	}
	return 0;
}

function MySQLCreateAccount(newplayersname[], newpassword[])
{
	new query[128];
	new sqlplyname[64];
	new sqlpassword[64];
	samp_mysql_real_escape_string(newplayersname, sqlplyname);
	samp_mysql_real_escape_string(newpassword, sqlpassword);
	format(query, sizeof(query), "INSERT INTO players (username, password) VALUES ('%s', '%s')", sqlplyname, sqlpassword);
	samp_mysql_query(query);
	new newplayersid = MySQLCheckAccount(newplayersname);
	if (newplayersid != 0)
	{
		return newplayersid;
	}
	return 0;
}

function Online(id, vale)
{
	new query[128];
	format(query, sizeof(query), "INSERT INTO online (userid, value) VALUES ('%d', '%d')", id, vale);
	new check = CheckOnline(id);
	if (check == 0)
	{
		return samp_mysql_query(query), printf(query);
	}
	else
	format(query, sizeof(query), "UPDATE online SET userid='%d', value='%d' WHERE userid=%d", id, vale, id);
	return 	samp_mysql_query(query), printf(query);
}

function CheckOnline(onlineid)
{
	new query[128];
	format(query, sizeof(query), "SELECT userid FROM online WHERE userid=%d", onlineid);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if (samp_mysql_num_rows()==0)
	{
		return 0;
	}
	else
	{
		new strid[32];
		new intid;
		samp_mysql_fetch_row(strid);
		intid = strval(strid);
		return intid;
	}
}


function MySQLAddLoginRecord(sqlplayerid, ipaddr[])
{
	new query[128];
	new escip[16];
	samp_mysql_real_escape_string(ipaddr, escip);
	format(query, sizeof(query), "INSERT INTO logins (time,ip,userid) VALUES (CURRENT_TIMESTAMP(),'%s',%d)", escip, sqlplayerid);
	samp_mysql_query(query);
	return 1;
}

forward BanAdd(sqlplayerid, ip[], result);
function BanAdd(sqlplayerid, ip[], result)
{
	new query[128];
	format(query, sizeof(query), "INSERT INTO bans (id,ip,time,amount) VALUES ('%d,'%s',UNIX_TIMESTAMP(),%d)",sqlplayerid,ip,result);
	samp_mysql_query(query);
	return 1;
}

function ConnectToDatabase()
{
	if(samp_mysql_ping()==0)
	{
		printf("Using existing connection!");
	}
	else
	{
		MySQLConnect(MYSQL_HOST,MYSQL_USER,MYSQL_PASS,MYSQL_DB);
	}
	return 1;
}

function StartFade(playerid)
{
SetPVarInt(playerid, "Fade", _:TextDrawCreate(1.000000,1.000000,"t"));
TextDrawUseBox(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawBoxColor(Text:GetPVarInt(playerid, "Fade"),0x000000ff);
TextDrawTextSize(Text:GetPVarInt(playerid, "Fade"),638.000000,0.000000);
TextDrawAlignment(Text:GetPVarInt(playerid, "Fade"),0);
TextDrawBackgroundColor(Text:GetPVarInt(playerid, "Fade"),0x000000ff);
TextDrawFont(Text:GetPVarInt(playerid, "Fade"),3);
TextDrawLetterSize(Text:GetPVarInt(playerid, "Fade"),0.000000,49.599990);
TextDrawColor(Text:GetPVarInt(playerid, "Fade"),0xffffffff);
TextDrawSetOutline(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawSetProportional(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawSetShadow(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawShowForPlayer(playerid,Text:GetPVarInt(playerid, "Fade"));
SetTimerEx("fade11", 100, 0, "i", playerid);
SetPVarInt(playerid, "FadeOn", 1);
return 1;
}

function fade11(playerid)
{
if(GetPVarInt(playerid, "FadeOn") == 1)
{
TextDrawDestroy(Text:GetPVarInt(playerid, "Fade"));
SetPVarInt(playerid, "FadeOn", 0);
}
SetPVarInt(playerid, "Fade", _:TextDrawCreate(1.000000,1.000000,"t"));
TextDrawUseBox(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawBoxColor(Text:GetPVarInt(playerid, "Fade"),0x000000cc);
TextDrawTextSize(Text:GetPVarInt(playerid, "Fade"),638.000000,0.000000);
TextDrawAlignment(Text:GetPVarInt(playerid, "Fade"),0);
TextDrawBackgroundColor(Text:GetPVarInt(playerid, "Fade"),0x000000ff);
TextDrawFont(Text:GetPVarInt(playerid, "Fade"),3);
TextDrawLetterSize(Text:GetPVarInt(playerid, "Fade"),0.000000,49.599990);
TextDrawColor(Text:GetPVarInt(playerid, "Fade"),0xffffffff);
TextDrawSetOutline(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawSetProportional(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawSetShadow(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawShowForPlayer(playerid,Text:GetPVarInt(playerid, "Fade"));
SetTimerEx("fade21", 50, 0, "i", playerid);
SetPVarInt(playerid, "FadeOn", 1);
return 1;
}

function fade21(playerid)
{
if(GetPVarInt(playerid, "FadeOn") == 1)
{
TextDrawDestroy(Text:GetPVarInt(playerid, "Fade"));
SetPVarInt(playerid, "FadeOn", 0);
}
SetPVarInt(playerid, "Fade", _:TextDrawCreate(1.000000,1.000000,"t"));
TextDrawUseBox(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawBoxColor(Text:GetPVarInt(playerid, "Fade"),0x00000099);
TextDrawTextSize(Text:GetPVarInt(playerid, "Fade"),638.000000,0.000000);
TextDrawAlignment(Text:GetPVarInt(playerid, "Fade"),0);
TextDrawBackgroundColor(Text:GetPVarInt(playerid, "Fade"),0x000000ff);
TextDrawFont(Text:GetPVarInt(playerid, "Fade"),3);
TextDrawLetterSize(Text:GetPVarInt(playerid, "Fade"),0.000000,49.599990);
TextDrawColor(Text:GetPVarInt(playerid, "Fade"),0xffffffff);
TextDrawSetOutline(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawSetProportional(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawSetShadow(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawShowForPlayer(playerid,Text:GetPVarInt(playerid, "Fade"));
SetTimerEx("fade31", 50, 0, "i", playerid);
SetPVarInt(playerid, "FadeOn", 1);
return 1;
}

function fade31(playerid)
{
if(GetPVarInt(playerid, "FadeOn") == 1)
{
TextDrawDestroy(Text:GetPVarInt(playerid, "Fade"));
SetPVarInt(playerid, "FadeOn", 0);
}
SetPVarInt(playerid, "Fade", _:TextDrawCreate(1.000000,1.000000,"t"));
TextDrawUseBox(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawBoxColor(Text:GetPVarInt(playerid, "Fade"),0x00000066);
TextDrawTextSize(Text:GetPVarInt(playerid, "Fade"),638.000000,0.000000);
TextDrawAlignment(Text:GetPVarInt(playerid, "Fade"),0);
TextDrawBackgroundColor(Text:GetPVarInt(playerid, "Fade"),0x000000ff);
TextDrawFont(Text:GetPVarInt(playerid, "Fade"),3);
TextDrawLetterSize(Text:GetPVarInt(playerid, "Fade"),0.000000,49.599990);
TextDrawColor(Text:GetPVarInt(playerid, "Fade"),0xffffffff);
TextDrawSetOutline(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawSetProportional(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawSetShadow(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawShowForPlayer(playerid,Text:GetPVarInt(playerid, "Fade"));
SetTimerEx("fade41", 50, 0, "i", playerid);
SetPVarInt(playerid, "FadeOn", 1);
return 1;
}

function fade41(playerid)
{
if(GetPVarInt(playerid, "FadeOn") == 1)
{
TextDrawDestroy(Text:GetPVarInt(playerid, "Fade"));
SetPVarInt(playerid, "FadeOn", 0);
}
SetPVarInt(playerid, "Fade", _:TextDrawCreate(1.000000,1.000000,"t"));
TextDrawUseBox(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawBoxColor(Text:GetPVarInt(playerid, "Fade"),0x00000033);
TextDrawTextSize(Text:GetPVarInt(playerid, "Fade"),638.000000,0.000000);
TextDrawAlignment(Text:GetPVarInt(playerid, "Fade"),0);
TextDrawBackgroundColor(Text:GetPVarInt(playerid, "Fade"),0x000000ff);
TextDrawFont(Text:GetPVarInt(playerid, "Fade"),3);
TextDrawLetterSize(Text:GetPVarInt(playerid, "Fade"),0.000000,49.599990);
TextDrawColor(Text:GetPVarInt(playerid, "Fade"),0xffffffff);
TextDrawSetOutline(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawSetProportional(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawSetShadow(Text:GetPVarInt(playerid, "Fade"),1);
TextDrawShowForPlayer(playerid,Text:GetPVarInt(playerid, "Fade"));
SetTimerEx("fade", 50, 0, "i", playerid);
SetPVarInt(playerid, "FadeOn", 1);
return 1;
}


function fade(playerid)
{
if(GetPVarInt(playerid, "FadeOn") == 1)
{
TextDrawDestroy(Text:GetPVarInt(playerid, "Fade"));
SetPVarInt(playerid, "FadeOn", 0);
}
return 1;
}

IsPlayerInInvalidleadedVehicle(vehicleid)
{
	new InvalidleadedVehicles[108] =
	{
		523, 586, 463, 461, 581, 448, 462,
		468, 471, 445, 602, 485, 568, 499,
		536, 496, 504, 422, 498, 401, 575,
		518, 482, 438, 527, 542, 480, 596,
		598, 599, 597, 507, 585, 419, 490,
		533, 565, 526, 466, 604, 492, 474,
		545, 546, 559, 508, 400, 517, 410,
		551, 500, 418, 572, 516, 582, 467,
		404, 600, 413, 426, 436, 547, 489,
		479, 534, 505, 442, 543, 605, 495,
		567, 405, 458, 439, 561, 409, 560,
		550, 566, 549, 420, 459, 576, 558,
		552, 540, 491, 412, 578, 421, 529,
		554, 477, 562, 555, 429, 541, 415,
		411, 603, 580, 506, 451, 587,

	};

	for(new i = 0; i < 108; i++)
	{
	if(GetVehicleModel(vehicleid) == InvalidleadedVehicles[i])return true;
	}
	return false;
}

IsPlayerInInvalidDieselVehicle(vehicleid)
{
    new InvalidDieselVehicles[53] =
	{
		416, 556, 444, 406, 573, 433, 424,
		609, 431, 457, 483, 524, 589, 437,
		532, 578, 486, 427, 528, 544, 407,
		455, 530, 588, 579, 571, 403, 423,
		414, 443, 470, 514, 515, 432, 440,
		428, 601, 574, 525, 531, 408, 583,
		456, 402, 487, 434, 502, 503, 494,
		475, 535,
	};

	for(new i = 0; i < 53; i++)
	{
	if(GetVehicleModel(vehicleid) == InvalidDieselVehicles[i]) return true;
	}
	return false;
}

IsPlayerInInvalidPetroVehicle(vehicleid)
{
	new InvalidPetroVehicles[23] =
	{
		520, 592, 577, 511, 548, 512, 593, 425, 417, 487,
		553, 488, 497, 563, 476, 447, 519, 460, 469, 513,
	};

	for(new i = 0; i < 23; i++)
	{
	if(GetVehicleModel(vehicleid) == InvalidPetroVehicles[i])return true;
	}
	return false;
}

IsPlayerInInvalidMotoVehicle(vehicleid)
{
	new InvalidMotoVehicles[12] =
	{
		581, 562, 521, 463, 522, 461, 448, 468, 586,
	};

	for(new i = 0; i < 12; i++)
	{
	if(GetVehicleModel(vehicleid) == InvalidMotoVehicles[i])return true;
	}
	return false;
}


split(const strsrc[], strdest[][], delimiter)
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

function strcount(const string[], delimiter)
{
	new i, count;
	while(i <= strlen(string)){
		if(string[i]==delimiter || i==strlen(string)){
			count++;
		}
		i++;
	}
	return count;
}

stock GivePlayerCash(playerid, money)
{
	new old = GetPVarInt(playerid, "Cash");
	SetPVarInt(playerid, "Cash", GetPVarInt(playerid, "Cash") + money);
	ResetMoneyBar(playerid);
	UpdateMoneyBar(playerid, GetPVarInt(playerid, "Cash"));

	if(GetPVarInt(playerid, "Cash") >= old) SetPVarInt(playerid, "Earned", GetPVarInt(playerid, "Earned") + money);

	if(GetPVarInt(playerid, "Cash") <= old) SetPVarInt(playerid, "Spent", GetPVarInt(playerid, "Spent") + money);

	return GetPVarInt(playerid, "Cash");
}

stock SetPlayerCash(playerid, money)
{
	SetPVarInt(playerid, "Cash", money);
	ResetMoneyBar(playerid);
	UpdateMoneyBar(playerid,GetPVarInt(playerid, "Cash"));
	return GetPVarInt(playerid, "Cash");
}
stock ResetPlayerCash(playerid)
{
	SetPVarInt(playerid, "Cash", 0);
	ResetMoneyBar(playerid);
	UpdateMoneyBar(playerid, GetPVarInt(playerid, "Cash"));
	return GetPVarInt(playerid, "Cash");
}
stock GetPlayerCash(playerid)
{
	return GetPVarInt(playerid, "Cash");
}

stock sscanf(str[], format[], {Float,_}:...)
{
	#if defined isnull
		if (isnull(str))
	#else
		if (str[0] == 0 || (str[0] == 1 && str[1] == 0))
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
	while (str[stringPos] && str[stringPos] <= ' ')
	{
		stringPos++;
	}
	while (paramPos < paramCount && str[stringPos])
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
					ch = str[stringPos];
				if (ch == '-')
				{
					neg = -1;
					ch = str[++stringPos];
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
				while ((ch = str[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num * neg);
			}
			case 'h', 'x':
			{
				new
					num = 0,
					ch = str[stringPos];
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
				while ((ch = str[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num);
			}
			case 'c':
			{
				setarg(paramPos, 0, str[stringPos++]);
			}
			case 'f':
			{
				setarg(paramPos, 0, _:floatstr(str[stringPos]));
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
				if ((ch = strfind(str, format[formatPos], false, stringPos)) == -1)
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
				while ((ch = str[++end]) && ch != delim)
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
					#if !defined foreach
						#define foreach(%1,%2) for (new %2 = 0; %2 < MAX_PLAYERS; %2++) if (IsPlayerConnected(%2))
						#define __SSCANF_FOREACH__
					#endif
					str[end] = '\0';
					num = false;
					id = end - stringPos;
					new
						name[MAX_PLAYER_NAME];
					foreach (Player, playerid)
					{
					    GetPlayerName(playerid,name,sizeof(name));
						if(!strcmp(name,str[stringPos],true,id))
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
					str[end] = ch;
					#if defined __SSCANF_FOREACH__
						#undef foreach
						#undef __SSCANF_FOREACH__
					#endif
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
					while ((ch = str[stringPos++]) && ch != delim)
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
					while ((ch = str[stringPos++]))
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
		while (str[stringPos] && str[stringPos] != delim && str[stringPos] > ' ')
		{
			stringPos++;
		}
		while (str[stringPos] && (str[stringPos] == delim || str[stringPos] <= ' '))
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

GetXYInFrontOfVehicle(vehid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;

	GetVehiclePos(vehid, x, y, a);
	GetVehicleZAngle(vehid, a);

	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;

	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);

	if (GetPlayerVehicleID(playerid))
	{
		GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}

	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

stock GetDotXY(Float:StartPosX, Float:StartPosY, &Float:NewX, &Float:NewY, Float:alpha, Float:dist)
{
	 NewX = StartPosX + (dist * floatsin(alpha, degrees));
	 NewY = StartPosY + (dist * floatcos(alpha, degrees));
}

function ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	    if(IsPlayerConnected(playerid))
	    {
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;

		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		foreach(player, i)
		{
				GetPlayerPos(i, posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				tempposz = (oldposz -posz);
				if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
     			{
	    			if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
	    			{
						SendClientMessage(i, col1, string);
					}
				}
				else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
				{
     				if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
     				{
						SendClientMessage(i, col2, string);
					}
				}
				else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
				{
	    			if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
	    			{
						SendClientMessage(i, col3, string);
					}
				}
				else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
				{
	    			if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
	    			{
						SendClientMessage(i, col4, string);
					}
				}
				else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
				{
     				if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
     				{
						SendClientMessage(i, col5, string);
     				}
				}
			}
		}
	    return 1;
}

function bool:DrivingBack(vehicleid)
{
new Float:Float[3];
if(GetVehicleVelocity(vehicleid, Float[1], Float[2], Float[0])) {
GetVehicleZAngle(vehicleid, Float[0]);
if(Float[0] < 90) {
if(Float[1] > 0 && Float[2] < 0)	return true;
} else if(Float[0] < 180) {
if(Float[1] > 0 && Float[2] > 0)	return true;
} else if(Float[0] < 270) {
if(Float[1] < 0 && Float[2] > 0)	return true;
} else if(Float[1] < 0 && Float[2] < 0)	return true;
}
return false;
}

Float:DistanceCameraTargetToLocation(Float:CamX, Float:CamY, Float:CamZ,   Float:ObjX, Float:ObjY, Float:ObjZ,   Float:FrX, Float:FrY, Float:FrZ) {

	new Float:TGTDistance;

	// get distance from camera to target
	TGTDistance = floatsqroot((CamX - ObjX) * (CamX - ObjX) + (CamY - ObjY) * (CamY - ObjY) + (CamZ - ObjZ) * (CamZ - ObjZ));

	new Float:tmpX, Float:tmpY, Float:tmpZ;

	tmpX = FrX * TGTDistance + CamX;
	tmpY = FrY * TGTDistance + CamY;
	tmpZ = FrZ * TGTDistance + CamZ;

	return floatsqroot((tmpX - ObjX) * (tmpX - ObjX) + (tmpY - ObjY) * (tmpY - ObjY) + (tmpZ - ObjZ) * (tmpZ - ObjZ));
}

stock GetPlayerNameEx(playerid)
{
    new string[24];
    GetPlayerName(playerid,string,24);
    new str[24];
    strmid(str,string,0,strlen(string),24);
    for(new i = 0; i < MAX_PLAYER_NAME; i++)
    {
        if (str[i] == '_') str[i] = ' ';
    }
    return str;
}

stock GetPlayerNameSave(playerid)
{
    new string[24];
    GetPlayerName(playerid,string,24);
    new str[24];
    strmid(str,string,0,strlen(string),24);
    return str;
}

stock IsPlayerAimingAt(playerid, Float:x, Float:y, Float:z, Float:radius)
{
        new Float:cx,Float:cy,Float:cz,Float:fx,Float:fy,Float:fz;
        GetPlayerCameraPos(playerid, cx, cy, cz);
        GetPlayerCameraFrontVector(playerid, fx, fy, fz);
        return (radius >= DistanceCameraTargetToLocation(cx, cy, cz, x, y, z, fx, fy, fz));
}

stock IsPlayerBehindPlayer(playerid, targetid, Float:dOffset)
{

	new
	    Float:pa,
	    Float:ta;

	if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)) return 0;

	GetPlayerFacingAngle(playerid, pa);
	GetPlayerFacingAngle(targetid, ta);

	if(AngleInRangeOfAngle(pa, ta, dOffset) && IsPlayerFacingPlayer(playerid, targetid, dOffset)) return true;

	return false;

}

stock SetPlayerToFacePlayer(playerid, targetid)
{

	new
		Float:pX,
		Float:pY,
		Float:pZ,
		Float:X,
		Float:Y,
		Float:Z,
		Float:ang;

	if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)) return 0;

	GetPlayerPos(targetid, X, Y, Z);
	GetPlayerPos(playerid, pX, pY, pZ);

	if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

	if(X > pX) ang = (floatabs(floatabs(ang) + 180.0));
	else ang = (floatabs(ang) - 180.0);

	SetPlayerFacingAngle(playerid, ang);

 	return 0;

}

stock IsPlayerFacingPlayer(playerid, targetid, Float:dOffset)
{

	new
		Float:pX,
		Float:pY,
		Float:pZ,
		Float:pA,
		Float:X,
		Float:Y,
		Float:Z,
		Float:ang;

	if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)) return 0;

	GetPlayerPos(targetid, pX, pY, pZ);
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, pA);

	if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

	if(AngleInRangeOfAngle(-ang, pA, dOffset)) return true;

	return false;

}

stock AngleInRangeOfAngle(Float:a1, Float:a2, Float:range)
{

	a1 -= a2;
	if((a1 < range) && (a1 > -range)) return true;

	return false;

}

AntiDeAMX()
{
new a[][] =
{
"Unarmed (Fist)",
"Brass K"
};
#pragma unused a
}
