/*
										__________________________________

										CARLITO'S ROLEPLAY, BY SCOTT DAVEY
										__________________________________
										
Credits: 13th (http://forum.sa-mp.com/index.php?action=profile;u=53066) for the pickup streamer.
Credits: Astro, for the saving system examples, and anybody else i did not mention.

Reminders:
* If any faction variable gets added, remember to update "/aresetfaction" & LoadDynamicFactions & SaveDynamicFactions.
* If any player variable gets added, remember to update "enum pInfo" & "OnPlayerRegister" & "ResetStats" & "OnPlayerLogin" & "OnPlayerDataSave" & "ShowStats"
* If new settings are added and are want to be shown ingame, edit "ShowScriptStats"

++ Faction System Completed
++ Buildings System Completed
++ House System Completed
++ Car System Completed
++ Car License System Completed
++ Fuel System Completed
++ Engine System Completed
++ Business System Completed
++ Job System Completed
++ Lock System Completed

[CUSTOM FUNCTIONS:]
GetPlayerNameEx(playerid); - removes the _ between names.
PlayerName(playerid); - shows the player's name without the need for custom formatting.
GivePlayerCash(playerid,amount); - Updated serverside money variable, which GivePlayerMoney does not do.
GetPlayerCash(playerid); - Returns the players serverside amount.
ResetPlayerCash(playerid); - Sets the players serverside variable to 0.
GetPlayerFirstName(playerid); - Returns the players first name.
GetPlayerLastName(playerid); - Returns the players last name.
PhoneAnimation(playerid); - This will take out the users phone, then put it away one second later. For TXT messages etc.
PlayerActionMessage(playerid,Float:radius,message); - User Action Message.
PlayerPlayerActionMessage(playerid,targetid,Float:radius,message; - Two user action message.

[FACTIONS:]
* Faction Type 1 = Police Department.

[CAR TYPES:]
* Car Type 1: Driving School Car


[JOBS:]
* Job 1: Arms Dealer.
* Job 2: Drugs Dealer.
* Job 3: Detective
* Job 4: Lawyer
* Job 5: Products Seller

[BUSINESS TYPES:] (Edit BUSINESS_TYPES when a new type is added)
* Business Type 1: Restaurant (Works by fastfood interiors).
* Business Type 2: Phone Sales/Network.
* Business Type 3: 24-7 Store. (Shop)
* Business Type 4: Ammunation. (Gun Store)
* Business Type 5: Advertising
* Business Type 6: Clothes Store
* Business Type 7: Bar/Club
*/

//============[SYSTEM RELATED MESSAGE DEFINES]========
#define BUSINESS_TYPES "1: Restaurant - 2: Phone - 3: 24-7 - 4: Ammunation - 5: Advertising - 6: Clothes Store - 7. Bar/Club"
#define BUSINESS_TYPES2 " "
//====================================================

#include <a_samp>
#include <core>
#include <float>
#include <time>
#include <file>
#include <Dini>

//===============================[MAIN SETTINGS]================================================
#define GAMEMODE	"Carlito's Roleplay" // This is what the gamemode text will be set to.
#define GAMEMODE_USE_VERSION	"Yes" // This shows the Server name and the version in Gamemode text, if set to "No" it will only display the gamemode name.
#define MAP_NAME	"x-serverz.com" // This is what the map name will be set to.
#define SERVER_NAME	"Edit Line 78 (HostName)" // This is what the hostname/servername will be set to.
#define WEBSITE	"sa-mp.com" // This is what the website will be set to.
#define VERSION	"V0.3" // Script Version
#define LAST_UPDATE	"23rd February 2009" // Script was last updated.
#define DEVELOPER	"Scott Davey" // Developer Name.
#define PASSWORD	"" // Server Password
#define SCRIPT_LINES	16505 // For printing the script lines amount, unfortunately it has to be updated manually.
//==============================================================================================
//===============================[OTHER SETTINGS]================================================
#define PICKUP_RANGE 50 //The range in which a player has to be to see the pickups
#define MAX_PICKUPS 10000 //Maximum amount of stream pickups
#define MAX_ZONE_NAME 28
#define MAX_SPAWN_ATTEMPTS 		4 //This is the amount of times sometime can try to spawn before finally getting kicked.
#define txtcost 15
#define PRODUCT_PRICE 10
//===============================================================================================

//=================================[DEFINES]==============================================
#define COLOR_FACTIONCHAT 0x01FCFFC8
#define COLOR_CORLEONE 0x212121AA
#define COLOR_RIGHTHAND_DONS 0xA10000AA
#define COLOR_BARZINI 0x00FF00AA
#define COLOR_PATERNO 0x800080AA
#define COLOR_TATTAGLIA 0xD3D300AA
#define COLOR_STRACCI 0x0FD9FAAA
#define COLOR_LSPD 0x0000FFAA
#define COLOR_FBI 0x191970AA
#define COLOR_NATIONALGUARD 0x556B2FAA
#define COLOR_CIVILIAN 0xFFFFFFFF
//[COLOURS]
#define COLOR_LOCALMSG 0xEC5413AA
#define COLOR_ADMINCMD 0xF97804FF
#define COLOR_ADMINDUTY 0x007E96F6
#define COLOR_NOTLOGGED 0x00000000
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define	COLOR_MONEYBAR 0x005800FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xA10000AA
#define COLOR_DARKRED 0xCD000000
#define COLOR_ANTICHEAT 0xAA3333AA
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_LIGHTGREEN 0x9ACD32AA
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_LIGHTBLUE2 0x0080FFAA
#define COLOR_LIGHTGREEN 0x9ACD32AA
#define COLOR_LIGHTORANGE 0xFF8000FF
#define COLOR_DARKBROWN 0xB36C42FF
#define COLOR_MEDIUMBLUE 0x1ED5C7FF
#define COLOR_LIGHTYELLOW 0xE0E377AA
#define COLOR_LIGHTYELLOW2 0xE0EA64AA
#define COLOR_LIGHTYELLOW3 0xFF6347AA
#define COLOR_DARKPURPLE 0x5F56F8AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_YELLOW2 0xF5DEB3AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_FADE1 0xE6E6E6E6
#define COLOR_FADE2 0xC8C8C8C8
#define COLOR_FADE3 0xAAAAAAAA
#define COLOR_FADE4 0x8C8C8C8C
#define COLOR_FADE5 0x6E6E6E6E
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_DBLUE 0x2641FEAA
#define COLOR_ALLDEPT 0xFF8282AA
#define COLOR_NEWS 0xFFA500AA
#define COLOR_OOC 0xE0FFFFAA
#define COLOR_NEWOOC 0x0080FFAA
//[OTHER DEFINES]
#define ResetMoneyBar ResetPlayerMoney
#define UpdateMoneyBar GivePlayerMoney
#define GasMax 100
//=========================================================================================
//=======================================[FORWARDS]========================================
forward SetPlayerSkinEx(playerid,skinid);
forward GameModeRestart();
forward GameModeRestartFunction();
forward UntazePlayer(playerid);
forward OnPlayerRegister(playerid, password[]);
forward UpdateScore();
forward SendFactionMessage(faction, color, string[]);
forward SendFactionTypeMessage(factiontype, color, string[]);
forward SetPlayerToFactionSkin(playerid);
forward SetPlayerToTeamColor(playerid);
forward OnPlayerLogin(playerid,password[]);
forward OnPlayerDataSave(playerid);
forward SetPlayerSpawn(playerid);
forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
forward FixHour(hour);
forward SyncTime();
forward UpdateData();
forward SaveAccounts();
forward Update();
forward PayDay();
forward UpdateMoney();
forward ResetStats(playerid);
forward SaveDynamicCars();
forward LoadDynamicCars();
forward LoadDynamicFactions();
forward SaveDynamicFactions();
forward LoadCivilianSpawn();
forward SaveCivilianSpawn();
forward LoadBuildings();
forward SaveBuildings();
forward split(const strsrc[], strdest[][], delimiter);
forward ShowStats(playerid,targetid);
forward BanPlayer(playerid,bannedby[MAX_PLAYER_NAME],reason[]);
forward BanPlayerAccount(playerid,bannedby[MAX_PLAYER_NAME],reason[]);
forward KickPlayer(playerid,kickedby[MAX_PLAYER_NAME],reason[]);
forward BanLog(string[]);
forward AccountBanLog(string[]);
forward KickLog(string[]);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward PickupGametexts();
forward FuelTimer();
forward IsAtGasStation(playerid);
forward LoadHouses();
forward SaveHouses();
forward PlayerActionMessage(playerid,Float:radius,message[]);
forward PlayerLocalMessage(playerid,Float:radius,message[]);
forward PlayerPlayerActionMessage(playerid,targetid,Float:radius,message[]);
forward IsAPlane(vehicleid);
forward IsAHelicopter(vehicleid);
forward RemoveDriverFromVehicle(playerid); //Unfreezes the player upon exit, to save any issues.
forward IsVehicleOccupied(vehicleid); //Check if a vehicle is in use.
forward SetPlayerToFactionColor(playerid); //Setting player to faction color.
forward SaveBusinesses();
forward LoadBusinesses();
forward LoadFactionMaterialsStorage();
forward SaveFactionMaterialsStorage();
forward LoadFactionDrugsStorage();
forward SaveFactionDrugsStorage();
forward LoadDrivingTestPosition();
forward SaveDrivingTestPosition();
forward LoadFlyingTestPosition();
forward SaveFlyingTestPosition();
forward LoadBankPosition();
forward SaveBankPosition();
forward LoadGunJob();
forward SaveGunJob();
forward LoadDrugJob();
forward SaveDrugJob();
forward LoadPoliceDutyPosition();
forward SavePoliceDutyPosition();
forward AddsOn();
forward LoadWeaponLicensePosition();
forward SaveWeaponLicensePosition();
forward LoadPoliceArrestPosition();
forward SavePoliceArrestPosition();
forward ProxDetectorS(Float:radi, playerid, targetid);
forward BanLog(string[]);
forward KickLog(string[]);
forward PayLog(string[]);
forward HackLog(string[]);
forward AdministratorMessage(color,const string[],level);
forward PlayerActionLog(string[]);
forward PlayerLocalLog(string[]);
forward TalkLog(string[]);
forward FactionChatLog(string[]);
forward SMSLog(string[]);
forward DonatorLog(string[]);
forward PMLog(string[]);
forward ReportLog(string[]);
forward OOCLog(string[]);
forward HangupTimer(playerid);
forward IsACopSkin(skinid);
forward JailTimer();
forward PhoneAnimation(playerid);
forward GetClosestPlayer(p1);
forward Float:GetDistanceBetweenPlayers(p1,p2);
forward SetPlayerWantedLevelEx(playerid,level);
forward GetPlayerWantedLevelEx(playerid);
forward ResetPlayerWantedLevelEx(playerid);
forward IsAtBar(playerid);
forward DrugEffect(playerid);
forward UndrugEffect(playerid);
forward LoadDetectiveJob();
forward SaveDetectiveJob();
forward ClearCheckpointsForPlayer(playerid);
forward LoadLawyerJob();
forward SaveLawyerJob();
forward LoadProductsSellerJob();
forward SaveProductsSellerJob();
forward LoadScript();
forward IsABike(vehicleid);
forward ShowScriptStats(playerid);
//===============================[PICKUP STREAMER]=========================================
forward CreateStreamPickup(model,type,Float:x,Float:y,Float:z,range);
forward StreamPickups();
forward Pickup_AnyPlayerToPoint(Float:radi, Float:x, Float:y, Float:z);
forward DestroyStreamPickup(ID);
forward CountStreamPickups();
forward ChangeStreamPickupModel(ID,newmodel);
forward ChangeStreamPickupType(ID,newtype);
forward MoveStreamPickup(ID,Float:x,Float:y,Float:z);
//=========================================================================================
new RandomStableModels[][2] = { //Total 87 Models
{400},//Landstalker
{401},//Bravura
{402},//Buffalo
{404},//Perenniel
{405},//Sentinel
{410},//Manana
{411},//Infernus
{412},//Voodoo
{413},//Pony
{415},//Cheetah
{418},//Moobream
{419},//Esperanto
{421},//Washington
{422},//Bobcat
{424},//BF Injection
{426},//Premier
{429},//Banshee
{436},//Previon
{439},//Stallion
{445},//Admiral
{451},//Turismo
{458},//Solair
{461},//PCJ-600
{462},//Faggio
{463},//Freeway
{466},//Glendale
{467},//Oceanic
{468},//Sanchez
{471},//Quad
{474},//Hermes
{475},//Sabre
{477},//ZR-350
{479},//Regina
{480},//Comet
{482},//Burrito
{483},//Camper
{491},//Virgo
{492},//Greenwood
{496},//Blista
{500},//Mesa
{506},//Super GT
{507},//Elegant
{516},//Nebula
{517},//Majestic
{518},//Buccaneer
{521},//FCR-900
{522},//NRG-500
{526},//Fortune
{527},//Cadrona
{529},//Willard
{533},//Feltzer
{534},//Remington
{535},//Slamvan
{536},//Blade
{540},//Vincent
{541},//Bullet
{542},//Clover
{543},//Sadler
{546},//Intruder
{547},//Primo
{549},//Tampa
{550},//Sunrise
{551},//Merit
{554},//Yosemite
{555},//Window
{558},//Uranus
{559},//Jester
{560},//Sultan
{561},//Stratum
{562},//Elegy
{565},//Flash
{566},//Tahoma
{567},//Savanna
{575},//Broadway
{576},//Tornado
{579},//Huntley
{580},//Stafford
{581},//BF-400
{585},//Emporer
{586},//Wayfarer
{587},//Euros
{589},//Club
{600},//Picador
{602},//Alpha
{604},//Glendale Shit
{603},//Phoenix
{605}//Sadler Shit
};
//===============================[PICKUP STREAMER]=========================================
enum pickupINFO
{
	pickupCreated,
	pickupVisible,
	pickupID,
	pickupRange,
	Float:pickupX,
	Float:pickupY,
	Float:pickupZ,
 	pickupType,
	pickupModel
}
new Pickup[MAX_PICKUPS+1][pickupINFO];
//===============================[NEW VARIABLES]===========================================
new JoinCounter; //Join statistics store in this variable.
new gPlayerLogged[MAX_PLAYERS];
new realchat = 1;
new BigEar[MAX_PLAYERS];
new ghour = 0;
new shifthour;
new timeshift = -1;
new realtime = 1;
new intrate = 1;
new levelexp = 3;
new RegistrationStep[MAX_PLAYERS];
new TakingDrivingTest[MAX_PLAYERS];
new DrivingTestStep[MAX_PLAYERS];
new SpawnAttempts[MAX_PLAYERS];
new FactionRequest[MAX_PLAYERS];//Where information will be stored regarding faction invites.
new Fuel[MAX_VEHICLES];//Fuel Information
new EngineStatus[MAX_VEHICLES];
new ShowFuel[MAX_PLAYERS];
new OutOfFuel[MAX_PLAYERS];
new Mobile[MAX_PLAYERS]; //Mobile Phone information will be stored here.
new PhoneOnline[MAX_PLAYERS];
new Muted[MAX_PLAYERS];
new StartedCall[MAX_PLAYERS];
new SpeakerPhone[MAX_PLAYERS];
new adds = 1;
new addtimer = 60000;
new OOCStatus = 0;
new AdminDuty[MAX_PLAYERS];
new PMsEnabled[MAX_PLAYERS];
new VehicleLocked[MAX_VEHICLES];
new VehicleLockedPlayer[MAX_PLAYERS];
new WantedPoints[MAX_PLAYERS];
new CarWindowStatus[MAX_VEHICLES];
new WantedLevel[MAX_PLAYERS];
new CopOnDuty[MAX_PLAYERS];
new PlayerCuffed[MAX_PLAYERS];
new PlayerTazed[MAX_PLAYERS];
new TicketOffer[MAX_PLAYERS];
new TicketMoney[MAX_PLAYERS];
new MatsHolding[MAX_PLAYERS];
new DrugsHolding[MAX_PLAYERS];
new DrugsIntake[MAX_PLAYERS];
new TrackingPlayer[MAX_PLAYERS];
new ProductsOffer[MAX_PLAYERS];
new ProductsAmount[MAX_PLAYERS];
new ProductsCost[MAX_PLAYERS];
//=========================================================================================
//=================================[ENUMS]=================================================
enum pInfo
{
	pKey[128],
	pLevel,
	pAdmin,
	pDonateRank,
	pRegistered,
	pSex,
	pAge,
	pExp,
	pCash,
	pBank,
	pSkin,
	pDrugs,
	pMaterials,
	pJob,
	pPlayingHours,
	pAllowedPayday,
	pPayCheck,
	pFaction,
	pRank,
	pHouseKey,
	pBizKey,
	pSpawnPoint,//If pSpawnPoint = 1, then the user will spawn at there normal place, if it's 0 then they will spawn at there home.
	pBanned,
	pWarnings,
	pCarLic,
	pFlyLic,
	pWepLic,
	pPhoneNumber,
	pPhoneC,//Phone Company (Business ID)
	pPhoneBook,
	pListNumber,
	pDonator,
	pJailed,
	pJailTime,
	pProducts,
	Float:pCrashX,
	Float:pCrashY,
	Float:pCrashZ,
	pCrashInt,
	pCrashW,
	pCrashed,
};
new PlayerInfo[MAX_PLAYERS][pInfo];

enum Cars
{
	CarModel,
	Float:CarX,
	Float:CarY,
	Float:CarZ,
	Float:CarAngle,
	CarColor1,
	CarColor2,
	FactionCar,
	CarType,
};
new DynamicCars[140][Cars];

enum Factions
{
	fName[50],
	Float:fX,
	Float:fY,
	Float:fZ,
	fMaterials,
	fDrugs,
	fBank,
	fRank1[35],
	fRank2[35],
	fRank3[35],
	fRank4[35],
	fRank5[35],
	fRank6[35],
	fRank7[35],
	fRank8[35],
	fRank9[35],
	fRank10[35],
	fSkin1,
	fSkin2,
	fSkin3,
	fSkin4,
	fSkin5,
	fSkin6,
	fSkin7,
	fSkin8,
	fSkin9,
	fSkin10,
	fJoinRank,
	fUseSkins,
	fType,//For Government factions etc
	fRankAmount,
	fColor[128],
	fUseColor,
};

new DynamicFactions[10][Factions];

enum CivilianSpawns
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
};
new CivilianSpawn[CivilianSpawns];

enum FactionMaterials
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
	PickupID,
};
new FactionMaterialsStorage[FactionMaterials];

enum FactionDrugs
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
	PickupID,
};
new FactionDrugsStorage[FactionDrugs];

enum DrivingTestLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
	PickupID,
};
new DrivingTestPosition[DrivingTestLocation];

enum BankLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
	PickupID,
};
new BankPosition[BankLocation];

enum ProductsSellerJobInfo
{
	Float:TakeJobX,
	Float:TakeJobY,
	Float:TakeJobZ,
	TakeJobWorld,
	TakeJobInterior,
	Float:TakeJobAngle,
	TakeJobPickupID,
 	Float:BuyProductsX,
	Float:BuyProductsY,
	Float:BuyProductsZ,
	BuyProductsWorld,
	BuyProductsInterior,
	Float:BuyProductsAngle,
	BuyProductsPickupID,
};
new ProductsSellerJob[ProductsSellerJobInfo];

enum GunJobInfo
{
	Float:TakeJobX,
	Float:TakeJobY,
	Float:TakeJobZ,
	TakeJobWorld,
	TakeJobInterior,
	Float:TakeJobAngle,
	TakeJobPickupID,
 	Float:BuyPackagesX,
	Float:BuyPackagesY,
	Float:BuyPackagesZ,
	BuyPackagesWorld,
	BuyPackagesInterior,
	Float:BuyPackagesAngle,
	BuyPackagesPickupID,
  	Float:DeliverX,
	Float:DeliverY,
	Float:DeliverZ,
	DeliverWorld,
	DeliverInterior,
	Float:DeliverAngle,
	DeliverPickupID,
};
new GunJob[GunJobInfo];

enum DrugJobInfo
{
	Float:TakeJobX,
	Float:TakeJobY,
	Float:TakeJobZ,
	TakeJobWorld,
	TakeJobInterior,
	Float:TakeJobAngle,
	TakeJobPickupID,
 	Float:BuyDrugsX,
	Float:BuyDrugsY,
	Float:BuyDrugsZ,
	BuyDrugsWorld,
	BuyDrugsInterior,
	Float:BuyDrugsAngle,
	BuyDrugsPickupID,
  	Float:DeliverX,
	Float:DeliverY,
	Float:DeliverZ,
	DeliverWorld,
	DeliverInterior,
	Float:DeliverAngle,
	DeliverPickupID,
};
new DrugJob[DrugJobInfo];

enum FlyingTestLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
	PickupID,
};
new FlyingTestPosition[FlyingTestLocation];

enum WeaponLicenseLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
	PickupID,
};
new WeaponLicensePosition[WeaponLicenseLocation];

enum PoliceArrestLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
};
new PoliceArrestPosition[PoliceArrestLocation];

enum PoliceDutyLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
};
new PoliceDutyPosition[PoliceDutyLocation];

enum DetectiveJobLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
	PickupID,
};
new DetectiveJobPosition[DetectiveJobLocation];

enum LawyerJobLocation
{
	Float:X,
	Float:Y,
	Float:Z,
	World,
	Interior,
	Float:Angle,
	PickupID,
};
new LawyerJobPosition[LawyerJobLocation];

enum BuildingSystem
{
	BuildingName[128],
	Float:EnterX,
	Float:EnterY,
	Float:EnterZ,
	EntranceFee,
	EnterWorld,
	EnterInterior,
	Float:EnterAngle,
	Float:ExitX,
	Float:ExitY,
	Float:ExitZ,
	ExitInterior,
	Float:ExitAngle,
	Locked,
	PickupID,
};
new Building[15][BuildingSystem];

enum BusinessSystem
{
	BusinessName[128],
	Owner[MAX_PLAYER_NAME],
	Float:EnterX,
	Float:EnterY,
	Float:EnterZ,
	EnterWorld,
	EnterInterior,
	Float:EnterAngle,
	Float:ExitX,
	Float:ExitY,
	Float:ExitZ,
	ExitInterior,
	Float:ExitAngle,
	Owned,
	Enterable,
	BizPrice,
	EntranceCost,
	Till,
	Locked,
	BizType,
	Products,
	PickupID,
}

new Businesses[100][BusinessSystem];

enum HouseSystem
{
	Description[128],
	Owner[MAX_PLAYER_NAME],
	Float:EnterX,
	Float:EnterY,
	Float:EnterZ,
	EnterWorld,
	EnterInterior,
	Float:EnterAngle,
	Float:ExitX,
	Float:ExitY,
	Float:ExitZ,
	ExitInterior,
	Float:ExitAngle,
	Owned,
	Rentable,
	RentCost,
	HousePrice,
	Materials,
	Drugs,
	Money,
	Locked,
	PickupID,
};
new Houses[100][HouseSystem];

enum SAZONE_MAIN {
		SAZONE_NAME[28],
		Float:SAZONE_AREA[6]
};

static const gSAZones[][SAZONE_MAIN] = {  // Majority of names and area coordinates adopted from Mabako's 'Zones Script' v0.2
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
	{"Market",                      {787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
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
	{"Prickle Pine",                {1117.40,2507.20,-89.00,1534.50,2723.20,110.90}},
	{"Prickle Pine",                {1848.40,2553.40,-89.00,1938.80,2863.20,110.90}},
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

//=========================================================================================

main()
{
	print("_________________________________________________________________________");
	printf("> %s - %s by %s loaded.", GAMEMODE,MAP_NAME,DEVELOPER);
	printf("> Server Name: %s", SERVER_NAME);
	if (!strcmp("Yes", GAMEMODE_USE_VERSION, true)) { printf("> Gamemode: %s - %s", GAMEMODE,VERSION); } else { printf("> Gamemode: %s", GAMEMODE); } // Checking the "GAMEMODE_USE_VERSION" define, if "Yes" then set the gamemode text to the gamemode name & version, else set it to just the gamemode name.
	printf("> Version: %s", VERSION);
	printf("> Map: %s", MAP_NAME);
	printf("> Website: %s", WEBSITE);
	printf("> Developer: %s", DEVELOPER);
	printf("> Last Update: %s", LAST_UPDATE);
	printf("> Current Script Lines: %d", SCRIPT_LINES);
 	printf("> Password: %s", ShowServerPassword());
	print("_________________________________________________________________________");
}


public OnGameModeInit()
{
	if(fexist("CRP_Scriptfiles/Other/JoinCounter.cfg"))
	{
	    JoinCounter = dini_Int("CRP_Scriptfiles/Other/JoinCounter.cfg", "Connections");
	    printf("file \"JoinCounter.txt\" located, variable JoinCounter loaded (%d visitors)", JoinCounter);
	}
	else
	{
	    dini_Create("CRP_Scriptfiles/Other/JoinCounter.cfg");
	    dini_IntSet("CRP_Scriptfiles/Other/JoinCounter.cfg", "Connections", 0);
	    print("file \"CRP_Scriptfiles/Other/JoinCounter.cfg\" created with JoinCounter variable (0 visitors)");
	}
	//================================[SETTING FUEL AND TURNING ENGINES OFF]==============================
	for(new c=0;c<MAX_VEHICLES;c++)
	{
		Fuel[c] = GasMax;
		EngineStatus[c] = 0;
		VehicleLocked[c] = 0;
		CarWindowStatus[c] = 1; //1 = up, 0 = down.
	}
	//=====================================================================================================
	
	//===============================[DISABLING STUFF]================================
	ShowPlayerMarkers(0);
	EnableStuntBonusForAll(0); //Disable stunt bonus.
    DisableInteriorEnterExits();//Disable Yellow Markers.
    AllowInteriorWeapons(1);//Allowing weapons inside.
	EnableTirePopping(1);
	EnableZoneNames(1);
	AllowAdminTeleport(1);
	UsePlayerPedAnims();
	new sendcmd[128];
	//================================================================================
	
	//=======================[Setting the servers stats]==============================
	if (!strcmp("Yes", GAMEMODE_USE_VERSION, true)) { format(sendcmd, sizeof(sendcmd), "%s - %s", GAMEMODE,VERSION); SetGameModeText(sendcmd); }
	else { SetGameModeText(GAMEMODE); }
	format(sendcmd, sizeof(sendcmd), "hostname %s", SERVER_NAME);
	SendRconCommand(sendcmd);
	format(sendcmd, sizeof(sendcmd), "mapname %s", MAP_NAME);
	SendRconCommand(sendcmd);
	format(sendcmd, sizeof(sendcmd), "weburl %s", WEBSITE);
	SendRconCommand(sendcmd);
	if (strlen(PASSWORD) != 0) { format(sendcmd, sizeof(sendcmd), "password %s", PASSWORD); SendRconCommand(sendcmd); }
	//================================================================================
	
	//========================================[LOAD]==========================================
	LoadScript();
	//========================================================================================

	//====================================[NON DYNAMIC PICKUPS]===========================================
	
	//====================================================================================================
	
//===================================[WORLD TIME TO SERVER TIME]====================================
	if (realtime)
	{
		new tmphour;
		new tmpminute;
		new tmpsecond;
		gettime(tmphour, tmpminute, tmpsecond);
		FixHour(tmphour);
		tmphour = shifthour;
		SetWorldTime(tmphour);
	}
//===================================[TIMERS]===============================================
	SetTimer("UpdateData", 5000, 1);//Updates scores, and syncs time of day
	SetTimer("SaveAccounts", 1800000, 1); //30 mins every account saved
	SetTimer("Update", 300000, 1);//Update every 5 minutes
	SetTimer("UpdateMoney", 1000, 1);//AntiMoney hack timer
	SetTimer("PickupGametexts", 1000, 1); //Timer that shows gametexts if the player is on a pickup/location.
	SetTimer("FuelTimer", 15000, 1); //Car Fuel System
	SetTimer("OtherTimer", 15000, 1);
	SetTimer("JailTimer", 1000, 1);
	SetTimer("StreamPickups",1000,1);//Streaming pickups
	return 1;
}

public OnGameModeExit()
{
	return 1;
}
public OnPlayerRequestClass(playerid, classid)
{
	if(gPlayerLogged[playerid])
	{
		SpawnPlayer(playerid);
		return 1;
	}
	SetPlayerCameraPos(playerid, 1033.3483,-1614.6884,37.8513);
   	SetPlayerCameraLookAt(playerid,1050.3650,-1606.5372,20.5192);
   	return 0;
}
public OnPlayerRequestSpawn(playerid)
{
	if(gPlayerLogged[playerid] == 1)
	{
		return 1;
	}
	else
	{
	    if(SpawnAttempts[playerid] >= MAX_SPAWN_ATTEMPTS)
	    {
	        KickPlayer(playerid,"System","Repeated attempts to spawn without logging in.");
			return 1;
	    }
		SendClientMessage(playerid,COLOR_RED,"[INFO:] You must login before you can spawn!");
		SpawnAttempts[playerid] ++;
		return 0;
	}
}

public OnPlayerConnect(playerid)
{
	//==================[Join Counter]=========================
	JoinCounter = JoinCounter + 1;
	dini_IntSet("CRP_Scriptfiles/Other/JoinCounter.cfg", "Connections", JoinCounter);
	//=========================================================
	
	ResetStats(playerid);//Setting variables to 0.
	ClearScreen(playerid);//Clearing the users screen from SA-MP messages.
	ShowScriptStats(playerid);//Showing the script information.
 	new first[MAX_PLAYER_NAME], last[MAX_PLAYER_NAME];
	if(RPName(PlayerName(playerid),first,last))
	{
		SendClientMessage(playerid,COLOR_YELLOW,"____________________________________________________");
		SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"                        Immigration:                           ");
		new sendername[MAX_PLAYER_NAME];
		new accstring[128];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(accstring, sizeof(accstring), "CRP_Scriptfiles/Accounts/%s.ini", sendername);
		new File: hFile = fopen(accstring, io_read);
		if (hFile)
		{
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INFO:] You are already a citizen, type your password below.");
			fclose(hFile);
		}
		else
		{
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INFO:] You are not a citizen, type your desired password to register.");
		}
		SendClientMessage(playerid,COLOR_YELLOW,"____________________________________________________");
	}
	else
	{
	    KickPlayer(playerid,"System","Invalid Name, Correct Format: Firstname_lastname.");
	}
	return 1;
}
public LoadScript()
{
	LoadDynamicFactions();
	LoadDynamicCars();
	LoadCivilianSpawn();
	LoadBuildings();
	LoadHouses();
	LoadBusinesses();
	LoadFactionMaterialsStorage();
	LoadFactionDrugsStorage();
	LoadDrivingTestPosition();
	LoadFlyingTestPosition();
	LoadBankPosition();
	LoadWeaponLicensePosition();
	LoadPoliceArrestPosition();
	LoadPoliceDutyPosition();
	LoadGunJob();
	LoadDrugJob();
	LoadDetectiveJob();
	LoadLawyerJob();
	LoadProductsSellerJob();
	return 1;
}
public ResetStats(playerid)
{
	//============[Account Related Stuff]=============
	ProductsOffer[playerid] = 999;
	ProductsCost[playerid] = 0;
	ProductsAmount[playerid] = 0;
	TrackingPlayer[playerid] = 0;
	DrugsIntake[playerid] = 0;
	DrugsHolding[playerid] = 0;
	ResetPlayerWantedLevelEx(playerid);
	VehicleLockedPlayer[playerid] = 999;
	MatsHolding[playerid] = 0;
	TicketOffer[playerid] = 999;
	TicketMoney[playerid] = 0;
	PlayerTazed[playerid] = 0;
	PlayerCuffed[playerid] = 0;
	CopOnDuty[playerid] = 0;
	WantedLevel[playerid] = 0;
	WantedPoints[playerid] = 0;
	PMsEnabled[playerid] = 1;
	AdminDuty[playerid] = 0;
	SpeakerPhone[playerid] = 0;
	StartedCall[playerid] = 0;
	Muted[playerid] = 0; //Player is not muted.
	PhoneOnline[playerid] = 0;//Phone is turned off if 1.
	ShowFuel[playerid] = 1;//Will show fuel.
	TakingDrivingTest[playerid] = 0; //Player is not taking the driving test.
	DrivingTestStep[playerid] = 0; //Player has not started the driving test.
	SetPlayerColor(playerid,COLOR_NOTLOGGED);//Set colour to not logged in.
	SpawnAttempts[playerid] = 0; //Player hasn't attempted to spawn yet.
	PlayerInfo[playerid][pFaction] = 255;
	FactionRequest[playerid] = 255; //Player hasn't been asked to join a faction.
	PlayerInfo[playerid][pRank] = 0;
	PlayerInfo[playerid][pBizKey] = 255;
	PlayerInfo[playerid][pSpawnPoint] = 0;
	PlayerInfo[playerid][pBanned] = 0;
	PlayerInfo[playerid][pWarnings] = 0;
	PlayerInfo[playerid][pHouseKey] = 255;
	gPlayerLogged[playerid] = 0;//Player is not logged in.
	RegistrationStep[playerid] = 0;
	PlayerInfo[playerid][pLevel] = 0;
	PlayerInfo[playerid][pAdmin] = 0;
	PlayerInfo[playerid][pDonateRank] = 0;
	PlayerInfo[playerid][pRegistered] = 0;
	PlayerInfo[playerid][pSex] = 0;
	PlayerInfo[playerid][pAge] = 0;
	PlayerInfo[playerid][pExp] = 0;
	PlayerInfo[playerid][pCash] = 0; //Resetting the cash variable to 0.
	PlayerInfo[playerid][pBank] = 0;
	PlayerInfo[playerid][pSkin] = 0;
	PlayerInfo[playerid][pDrugs] = 0;
	PlayerInfo[playerid][pMaterials] = 0;
	PlayerInfo[playerid][pJob] = 0;
	PlayerInfo[playerid][pPlayingHours] = 0;
	PlayerInfo[playerid][pAllowedPayday] = 0;
	PlayerInfo[playerid][pPayCheck] = 0;
	PlayerInfo[playerid][pCarLic] = 0;
	PlayerInfo[playerid][pWepLic] = 0;
	PlayerInfo[playerid][pFlyLic] = 0;
	PlayerInfo[playerid][pPhoneNumber] = 0;
	PlayerInfo[playerid][pPhoneC] = 255;
	PlayerInfo[playerid][pPhoneBook] = 0;
	PlayerInfo[playerid][pListNumber] = 1;
	Mobile[playerid] = 255;
	PlayerInfo[playerid][pDonator] = 0;
	PlayerInfo[playerid][pJailed] = 0;
	PlayerInfo[playerid][pJailTime] = 0;
	PlayerInfo[playerid][pProducts] = 0;
	PlayerInfo[playerid][pCrashX] = 0.0000;
	PlayerInfo[playerid][pCrashY] = 0.0000;
	PlayerInfo[playerid][pCrashZ] = 0.0000;
	PlayerInfo[playerid][pCrashInt] = 0;
	PlayerInfo[playerid][pCrashW] = 0;
	PlayerInfo[playerid][pCrashed] = 0;
	//================================================
	return 0;
}
public OnPlayerDisconnect(playerid, reason)
{
    if(gPlayerLogged[playerid])
	{
	    if(reason == 0)
	    {
	        new Float:x,Float:y,Float:z;
	        GetPlayerPos(playerid,x,y,z);
		    PlayerInfo[playerid][pCrashX] = x;
			PlayerInfo[playerid][pCrashY] = y;
			PlayerInfo[playerid][pCrashZ] = z;
			PlayerInfo[playerid][pCrashInt] = GetPlayerInterior(playerid);
			PlayerInfo[playerid][pCrashW] = GetPlayerVirtualWorld(playerid);
			PlayerInfo[playerid][pCrashed] = 1;
			PlayerLocalMessage(playerid,15.0,"has just crashed from the server.");
	    }
		OnPlayerDataSave(playerid);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(gPlayerLogged[playerid])
	{
		SetPlayerSpawn(playerid);
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new string[128];
	if(IsPlayerConnected(killerid))
	{
	    if(killerid != playerid)
	    {
	     	if(AdminDuty[playerid])
		    {
		        if(!AdminDuty[killerid])
		        {
					KickPlayer(killerid,"System","Killing an administrator on duty with abuse.");
					format(string, sizeof(string), "[INFO:] System has kicked %s, Reason: Killing an administrator on duty with abuse. ", PlayerName(killerid));
					KickLog(string);
				}
		    }
	    	SetPlayerWantedLevelEx(killerid,GetPlayerWantedLevelEx(playerid)+1);
	    }
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	new string[256];
	new tmp[256];
	
	if(Muted[playerid])
	{
		SendClientMessage(playerid, COLOR_RED, "[ERROR:] You can't speak, your muted.");
		return 0;
	}
	//=================================[PASSWORD]======================================
	if(gPlayerLogged[playerid] == 0)
	{
		new accstring[128];
		format(accstring, sizeof(accstring), "CRP_Scriptfiles/Accounts/%s.ini", PlayerName(playerid));
		new File: hFile = fopen(accstring, io_read);
		if (hFile)
		{
			fclose(hFile);
			OnPlayerLogin(playerid,text);
			return 0;
		}
		else
	 	{
			OnPlayerRegister(playerid,text);
			OnPlayerLogin(playerid,text);
			return 0;
		}
	}
 	new idx;
	tmp = strtok(text, idx);
 	if((strcmp("(", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("(")))
	{
	    if(text[1] != 0)
	    {
		    format(string, sizeof(string), "(( [LOCAL OOC:] %s says: %s ))", PlayerName(playerid),text[1]);
			ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			OOCLog(string);
	   		return 0;
   		}
	}
	if(RegistrationStep[playerid] == 1)
	{
		new age = strval(text);
	    if (age >= 16 && age <= 100)
	 	{
		 	new wstring[128];
		    format(wstring, sizeof(wstring), "[INFO:] You have set your age to: %d.", age);
		    SendClientMessage(playerid,COLOR_LIGHTYELLOW2, wstring);
	    	PlayerInfo[playerid][pAge] = age;
	    	RegistrationStep[playerid] = 2;
	 	    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] What's your Sex? Please type, Male or Female.");
	 	}
	 	else
	 	{
	 	    SendClientMessage(playerid,COLOR_RED,"[INFO:] Invalid age, correct ages are 16-100.");
	 	}
		return 0;
	}
 	if(RegistrationStep[playerid] == 2)
  	{
  	    new idx2;
    	tmp = strtok(text, idx2);
	    if((strcmp("male", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("male")))
		{
  			PlayerInfo[playerid][pSex] = 1;
   			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INFO:] You have set your sex to: Male.");
	    	RegistrationStep[playerid] = 0;
			TogglePlayerControllable(playerid,1);
			PlayerInfo[playerid][pRegistered] = 1;
		    return 0;
		}
		else if((strcmp("female", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("female")))
		{
  			PlayerInfo[playerid][pSex] = 2;
  			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INFO:] You have set your sex to: Female.");
			RegistrationStep[playerid] = 0;
			TogglePlayerControllable(playerid,1);
			PlayerInfo[playerid][pRegistered] = 1;
   			return 0;
		}
		else
		{
  			SendClientMessage(playerid, COLOR_RED, "[INFO:] Invalid sex, type male/female.");
	 	}
		return 0;
	}
	if(Mobile[playerid] == 911)
	{
		format(string, sizeof(string), "[911 CALL:] %s(ID:%d) says: %s",GetPlayerNameEx(playerid),playerid,text);
		SendFactionTypeMessage(1, COLOR_LSPD, string);
		SendClientMessage(playerid,COLOR_WHITE,"Operator says: Your call has been recorded, please standby.");
		Mobile[playerid] = 255;
		format(string, sizeof(string), "[Phone] %s says: %s", GetPlayerNameEx(playerid), text);
		ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		TalkLog(string);
		return 0;
	}
	if(Mobile[playerid] != 255)
	{
		format(string, sizeof(string), "[Phone] %s says: %s", GetPlayerNameEx(playerid), text);
		ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
        TalkLog(string);
        
		if(IsPlayerConnected(Mobile[playerid]))
		{
		    if(Mobile[Mobile[playerid]] == playerid)
		    {
 	    		new Float:SpeakerX,Float:SpeakerY,Float:SpeakerZ;
			    GetPlayerPos(playerid,SpeakerX,SpeakerY,SpeakerZ);
			    if(!PlayerToPoint(20.0,Mobile[playerid],SpeakerX,SpeakerY,SpeakerZ))
			    {
					SendClientMessage(Mobile[playerid], COLOR_LIGHTGREEN,string);
					SendClientMessage(playerid, COLOR_LIGHTGREEN,string);
				}
				if(SpeakerPhone[Mobile[playerid]])
				{
					format(string, sizeof(string), "[Speaker] %s says: %s", GetPlayerNameEx(playerid), text);
					ProxDetector(20.0, Mobile[playerid], string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
				}
			}
		}
  		else
		{
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2,"[ERROR:] Theres nobody on the line.");
		}
		return 0;
	}
	if (realchat)
	{
	    if(gPlayerLogged[playerid] == 0)
	    {
	        return 0;
      	}
      	if(!IsPlayerInAnyVehicle(playerid) || IsABike(GetPlayerVehicleID(playerid)))
      	{
			format(string, sizeof(string), "%s says: %s", GetPlayerNameEx(playerid), text);
			ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			TalkLog(string);
		}
		else
		{
		    if(CarWindowStatus[GetPlayerVehicleID(playerid)] == 1)
		    {
				format(string, sizeof(string), "[Windows Up] %s says: %s", GetPlayerNameEx(playerid), text);
				ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
				TalkLog(string);
			}
			else
			{
				format(string, sizeof(string), "[Windows Down] %s says: %s", GetPlayerNameEx(playerid), text);
				ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
				TalkLog(string);
			}
		}
		return 0;
	}
	return 1;
}

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	new string[128];
	if(PMsEnabled[recieverid])
	{
		format(string, sizeof(string), "[OOCPM:] PM from %s(%d): %s", GetPlayerNameEx(playerid),playerid, text);
		SendClientMessage(recieverid,COLOR_MEDIUMBLUE,string);
		format(string, sizeof(string), "[OOCPM:] PM sent to %s(%d): %s", GetPlayerNameEx(recieverid),recieverid, text);
		SendClientMessage(playerid,COLOR_MEDIUMBLUE,string);
		PMLog(string);
		return 0;
	}
	else
	{
	    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] That user has disabled PM's.");
	}
	return 0;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[256];
	new cmd[256];
	new idx;
	cmd = strtok(cmdtext, idx);
	new tmp[256];
	new giveplayerid;
	
	if(gPlayerLogged[playerid] == 1)
	{
	//==================================================[ADMINISTRATOR COMMANDS]=================================================
	if(strcmp(cmd, "/gmx", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				GameModeRestart();
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator!");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/asetleader", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /asetleader [playerid/PartOfName] [FactionID]");
				return 1;
			}
			new para1;
			new level;
			para1 = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			level = strval(tmp);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /asetleader [playerid/PartOfName] [FactionID]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
			    if(IsPlayerConnected(para1))
			    {
			        if(para1 != INVALID_PLAYER_ID)
			        {
						PlayerInfo[para1][pFaction] = level;
						PlayerInfo[para1][pRank] = 1;
						SetPlayerSpawn(para1);
						
						format(string, sizeof(string), "[INFO:] You have made %s leader of faction ID: %d (%s).", GetPlayerNameEx(para1),level,DynamicFactions[level][fName]);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						
						format(string, sizeof(string), "[INFO:] You have been made leader of %s by %s.", DynamicFactions[level][fName],GetPlayerNameEx(playerid));
						SendClientMessage(para1, COLOR_LIGHTBLUE, string);
						
						if(DynamicFactions[level][fUseSkins] == 1)
						{
							SetPlayerSkin(para1,DynamicFactions[level][fSkin1]);
						}
					}
				}//not connected
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator or you do not have the required level.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/advertise", true) == 0 || strcmp(cmd, "/ad", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(gPlayerLogged[playerid] == 0)
	        {
	            SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not logged in!");
	            return 1;
	        }
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
   			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] (/ad)vertise [advert text]");
				return 1;
			}
   	    	for(new i = 0; i < sizeof(Businesses); i++)
			{
				if (PlayerToPoint(1.0, playerid,Businesses[i][EnterX], Businesses[i][EnterY], Businesses[i][EnterZ]) || PlayerToPoint(25.0, playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
				{
					if(GetPlayerVirtualWorld(playerid) == i)
					{
			    		if(Businesses[i][BizType] == 5)
			    		{
				        	if(Businesses[i][Products] != 0)
				        	{
								if ((!adds) && (PlayerInfo[playerid][pAdmin] < 1))
								{
									format(string, sizeof(string), "[ERROR:] You must wait %d seconds before making another advertisement.",  (addtimer/1000));
									SendClientMessage(playerid, COLOR_LIGHTYELLOW2, string);
									return 1;

								}
								new payout = idx * 25;
								if(GetPlayerCash(playerid) < payout)
						        {
						            SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money.");
						            return 1;
						        }
						        GivePlayerCash(playerid, - payout);
								Businesses[i][Till] += payout;
								Businesses[i][Products] --;
								format(string, sizeof(string), "---------------------------------[Advertisement (%s)]---------------------------------",  Businesses[i][BusinessName]);
								SendClientMessageToAll(COLOR_LIGHTGREEN,string);
								format(string, sizeof(string), "[AD:] %s",  result);
								SendClientMessageToAll(COLOR_WHITE,string);
								format(string, sizeof(string), "[AD:] Advertisement By: %s - Phone Number: %d.",  GetPlayerNameEx(playerid),PlayerInfo[playerid][pPhoneNumber],Businesses[i][BusinessName]);
								SendClientMessageToAll(COLOR_WHITE,string);
								SendClientMessageToAll(COLOR_LIGHTGREEN,"-----------------------------------------------------------------------------------------------------------------------");
						        if (PlayerInfo[playerid][pAdmin] < 1){SetTimer("AddsOn", addtimer, 0);adds = 0;}
						        format(string, sizeof(string), "[INFO:] Characters Contained: %d - Cost: $%d - Thanks from %s", idx,payout,Businesses[i][BusinessName]);
								SendClientMessage(playerid,COLOR_WHITE,string);
								PlayerActionMessage(playerid,15.0,"gives the company worker some money and gets his advertisement posted in return.");
								SaveBusinesses();
								return 1;
							}
							else
							{
								SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] The business is out of products.");
							}
						}
						else
						{
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] This business is not an advertising company.");
						}
					}
	   			}
	   			else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not at/in a business.");
				}
			}
		}
		return 1;
	}
	//====================================================[DYNAMIC BUSINESS SYSTEM]==============================================
	if(strcmp(cmd, "/agotobusiness", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /agotobusiness [id]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				SetPlayerPos(playerid,Businesses[id][EnterX],Businesses[id][EnterY],Businesses[id][EnterZ]);
				SetPlayerInterior(playerid,Businesses[id][EnterInterior]);
				SetPlayerVirtualWorld(playerid,Businesses[id][EnterWorld]);
				new form[128];
				format(form, sizeof(form), "[INFO:] You teleported to business ID: %d.", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
   	if(strcmp(cmd, "/abusinessproducts", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /abusinessproducts [businessid] [amount]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 7)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /abusinessproducts [businessid] [amount]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					Businesses[id][Products] = id2;
					new form[128];
					format(form, sizeof form, "You've set Businesses ID: %d's products to %d.", id,id2);
					SendClientMessage(playerid, COLOR_ADMINCMD,form);
					SaveBusinesses();
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
  	if(strcmp(cmd, "/abusinessprice", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /abusinessprice [businessid] [price]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 7)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /abusinessprice [businessid] [price]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					Businesses[id][BizPrice] = id2;
					new form[128];
					format(form, sizeof form, "You've set Businesses ID: %d's price to %d.", id,id2);
					SendClientMessage(playerid, COLOR_ADMINCMD,form);
					SaveBusinesses();
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
   	if(strcmp(cmd, "/abusinesstype", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2,"[BUSINESS TYPES:]");
			    SendClientMessage(playerid, COLOR_ADMINCMD,BUSINESS_TYPES);
				SendClientMessage(playerid, COLOR_ADMINCMD,BUSINESS_TYPES2);
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /abusinesstype [businessid] [type]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 7)
			{
					new id;
					new form[128];
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
					    SendClientMessage(playerid, COLOR_LIGHTYELLOW2,"[BUSINESS TYPES:]");
						SendClientMessage(playerid, COLOR_ADMINCMD,BUSINESS_TYPES);
						SendClientMessage(playerid, COLOR_ADMINCMD,BUSINESS_TYPES2);
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /abusinesstype [businessid] [type]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					Businesses[id][BizType] = id2;
					format(form, sizeof form, "You've set Businesses ID: %d's type to %d.", id,id2);
					SendClientMessage(playerid, COLOR_ADMINCMD,form);
					SaveBusinesses();
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/abusinessentrance", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /abusinessentrance [bizid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 7)
			{
			    new pmodel;
				new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid, x, y, z);
				Businesses[id][EnterX] = x;
				Businesses[id][EnterY] = y;
				Businesses[id][EnterZ] = z;
				Businesses[id][EnterWorld] = GetPlayerVirtualWorld(playerid);
				Businesses[id][EnterInterior] = GetPlayerInterior(playerid);
  				new Float:angle;
				GetPlayerFacingAngle(playerid, angle);
				Businesses[id][EnterAngle] = angle;
				switch(Businesses[id][Owned])
				{
				    case 0: pmodel = 1272;
				    case 1: pmodel = 1239;
				}
				ChangeStreamPickupModel(Businesses[id][PickupID],pmodel);
    			MoveStreamPickup(Businesses[id][PickupID],Businesses[id][EnterX], Businesses[id][EnterY], Businesses[id][EnterZ]);
    			
				SaveBusinesses();
				new form[128];
				format(form, sizeof(form), "[INFO:] You have set business ID: %d's location.", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/abusinessexit", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /abusinessexit [bizid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 7)
			{
				new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid, x, y, z);
				Businesses[id][ExitX] = x;
				Businesses[id][ExitY] = y;
				Businesses[id][ExitZ] = z;
				Businesses[id][ExitInterior] = GetPlayerInterior(playerid);
  				new Float:angle;
				GetPlayerFacingAngle(playerid, angle);
				Businesses[id][ExitAngle] = angle;
				SaveBusinesses();
				new form[128];
				format(form, sizeof(form), "[INFO:] You have set business ID: %d's exit location.", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	//===================================================[DYNAMIC HOUSES SYSTEM]=================================================
 	if(strcmp(cmd, "/agotohouse", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /agotohouse [id]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				SetPlayerPos(playerid,Houses[id][EnterX],Houses[id][EnterY],Houses[id][EnterZ]);
				SetPlayerInterior(playerid,Houses[id][EnterInterior]);
				SetPlayerVirtualWorld(playerid,Houses[id][EnterWorld]);
				new form[128];
				format(form, sizeof(form), "[INFO:] You teleported to house ID: %d.", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/ahouseint", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /ahouseint [houseid] [id (1-42)]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 7)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /ahouseint [houseid] [id (1-42)]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);
					if(id2 < 1 || id2 > 42) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Interior ID's 1-42."); return 1; }
					
					if(id2 == 1)
					{
						Houses[id][ExitX] = 235.508994;
						Houses[id][ExitY] = 1189.169897;
						Houses[id][ExitZ] = 1080.339966;
						Houses[id][ExitInterior] = 3;
						format(string, sizeof string, "House ID: %d - Description: Large/2 story/3 bedrooms/clone of House 9.", id,id2);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 2)
					{
						Houses[id][ExitX] = 225.756989;
						Houses[id][ExitY] = 1240.000000;
						Houses[id][ExitZ] = 1082.149902;
						Houses[id][ExitInterior] = 2;
						format(string, sizeof string, "House ID: %d - Description: Medium/1 story/1 bedroom.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
					else if(id2 == 3)
					{
						Houses[id][ExitX] = 223.043991;
						Houses[id][ExitY] = 1289.259888;
						Houses[id][ExitZ] = 1082.199951;
						Houses[id][ExitInterior] = 1;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/1 bedroom.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 4)
					{
						Houses[id][ExitX] = 225.630997; Houses[id][ExitY] = 1022.479980; Houses[id][ExitZ] = 1084.069946;
						Houses[id][ExitInterior] = 7;
						format(string, sizeof string, "House ID: %d - Description: VERY Large/2 story/4 bedrooms.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 5)
					{
						Houses[id][ExitX] = 295.138977; Houses[id][ExitY] = 1474.469971; Houses[id][ExitZ] = 1080.519897;
						Houses[id][ExitInterior] = 15;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/2 bedrooms.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 6)
					{
						Houses[id][ExitX] = 328.493988; Houses[id][ExitY] = 1480.589966; Houses[id][ExitZ] = 1084.449951;
						Houses[id][ExitInterior] = 15;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/2 bedrooms.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 7)
					{
						Houses[id][ExitX] = 385.803986; Houses[id][ExitY] = 1471.769897; Houses[id][ExitZ] = 1080.209961;
						Houses[id][ExitInterior] = 15;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/1 bedroom/NO BATHROOM.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 8)
					{
						Houses[id][ExitX] = 375.971985; Houses[id][ExitY] = 1417.269897; Houses[id][ExitZ] = 1081.409912;
						Houses[id][ExitInterior] = 15;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/1 bedroom.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 9)
					{
						Houses[id][ExitX] = 490.810974; Houses[id][ExitY] = 1401.489990; Houses[id][ExitZ] = 1080.339966;
						Houses[id][ExitInterior] = 2;
						format(string, sizeof string, "House ID: %d - Description: Large/2 story/3 bedrooms.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     			 	else if(id2 == 10)
					{
						Houses[id][ExitX] = 447.734985; Houses[id][ExitY] = 1400.439941; Houses[id][ExitZ] = 1084.339966;
						Houses[id][ExitInterior] = 2;
						format(string, sizeof string, "House ID: %d - Description: Medium/1 story/2 bedrooms.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 11)
					{
						Houses[id][ExitX] = 227.722992; Houses[id][ExitY] = 1114.389893; Houses[id][ExitZ] = 1081.189941;
						Houses[id][ExitInterior] = 5;
						format(string, sizeof string, "House ID: %d - Description: Large/2 story/4 bedrooms.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 12)
					{
						Houses[id][ExitX] = 260.983978; Houses[id][ExitY] = 1286.549927; Houses[id][ExitZ] = 1080.299927;
						Houses[id][ExitInterior] = 4;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/1 bedroom.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 13)
					{
						Houses[id][ExitX] = 221.666992; Houses[id][ExitY] = 1143.389893; Houses[id][ExitZ] = 1082.679932;
						Houses[id][ExitInterior] = 4;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/1 bedroom/NO BATHROOM!", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 14)
					{
						Houses[id][ExitX] = 27.132700; Houses[id][ExitY] = 1341.149902; Houses[id][ExitZ] = 1084.449951;
						Houses[id][ExitInterior] = 10;
						format(string, sizeof string, "House ID: %d - Description: Medium/2 story/1 bedroom.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 15)
					{
						Houses[id][ExitX] = -262.601990; Houses[id][ExitY] = 1456.619995; Houses[id][ExitZ] = 1084.449951;
						Houses[id][ExitInterior] = 4;
						format(string, sizeof string, "House ID: %d - Description: Large/2 story/1 bedroom/NO BATHROOM!", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 16)
					{
						Houses[id][ExitX] = 22.778299; Houses[id][ExitY] = 1404.959961; Houses[id][ExitZ] = 1084.449951;
						Houses[id][ExitInterior] = 5;
						format(string, sizeof string, "House ID: %d - Description: Medium/1 story/2 bedrooms/NO BATHROOM or DOORS!", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 17)
					{
						Houses[id][ExitX] = 140.278000; Houses[id][ExitY] = 1368.979980; Houses[id][ExitZ] = 1083.969971;
						Houses[id][ExitInterior] = 5;
						format(string, sizeof string, "House ID: %d - Description: Large/2 story/4 bedrooms/NO BATHROOM!", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 18)
					{
						Houses[id][ExitX] = 234.045990; Houses[id][ExitY] = 1064.879883; Houses[id][ExitZ] = 1084.309937;
						Houses[id][ExitInterior] = 6;
						format(string, sizeof string, "House ID: %d - Description: Large/2 story/3 bedrooms.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 19)
					{
						Houses[id][ExitX] = -68.294098; Houses[id][ExitY] = 1353.469971; Houses[id][ExitZ] = 1080.279907;
						Houses[id][ExitInterior] = 6;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/NO BEDROOM!", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 20)
					{
						Houses[id][ExitX] = -285.548981; Houses[id][ExitY] = 1470.979980; Houses[id][ExitZ] = 1084.449951;
						Houses[id][ExitInterior] = 15;
						format(string, sizeof string, "House ID: %d - Description: 1 bedroom/living room/kitchen/NO BATHROOM", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 21)
					{
						Houses[id][ExitX] = -42.581997; Houses[id][ExitY] = 1408.109985; Houses[id][ExitZ] = 1084.449951;
						Houses[id][ExitInterior] = 8;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/NO BEDROOM!", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 22)
					{
						Houses[id][ExitX] = 83.345093; Houses[id][ExitY] = 1324.439941; Houses[id][ExitZ] = 1083.889893;
						Houses[id][ExitInterior] = 9;
						format(string, sizeof string, "House ID: %d - Description: Medium/2 story/2 bedrooms", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 23)
					{
						Houses[id][ExitX] = 260.941986; Houses[id][ExitY] = 1238.509888; Houses[id][ExitZ] = 1084.259888;
						Houses[id][ExitInterior] = 9;
						format(string, sizeof string, "House ID: %d - Description: Small/1 story/1 bedroom", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 24)
					{
						Houses[id][ExitX] = 244.411987; Houses[id][ExitY] = 305.032990; Houses[id][ExitZ] = 999.231995;
						Houses[id][ExitInterior] = 1;
						format(string, sizeof string, "House ID: %d - Description: Denise's Bedroom", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 25)
					{
						Houses[id][ExitX] = 271.884979; Houses[id][ExitY] = 306.631989; Houses[id][ExitZ] = 999.325989;
						Houses[id][ExitInterior] = 2;
						format(string, sizeof string, "House ID: %d - Description: Katie's Bedroom", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
      		 		else if(id2 == 26)
					{
						Houses[id][ExitX] = 291.282990; Houses[id][ExitY] = 310.031982; Houses[id][ExitZ] = 999.154968;
						Houses[id][ExitInterior] = 3;
						format(string, sizeof string, "House ID: %d - Description: Helena's Bedroom (barn) - limited movement.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 27)
					{
						Houses[id][ExitX] = 302.181000; Houses[id][ExitY] = 300.722992; Houses[id][ExitZ] = 999.231995;
						Houses[id][ExitInterior] = 4;
						format(string, sizeof string, "House ID: %d - Description: Michelle's Bedroom.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 28)
					{
						Houses[id][ExitX] = 322.197998; Houses[id][ExitY] = 302.497986; Houses[id][ExitZ] = 999.231995;
						Houses[id][ExitInterior] = 5;
						format(string, sizeof string, "House ID: %d - Description: Barbara's Bedroom.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 29)
					{
						Houses[id][ExitX] = 346.870025; Houses[id][ExitY] = 309.259033; Houses[id][ExitZ] = 999.155700;
						Houses[id][ExitInterior] = 6;
						format(string, sizeof string, "House ID: %d - Description: Millie's Bedroom.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 30)
					{
						Houses[id][ExitX] = 2496.049805; Houses[id][ExitY] = -1693.929932; Houses[id][ExitZ] = 1014.750000;
						Houses[id][ExitInterior] = 3;
						format(string, sizeof string, "House ID: %d - Description: CJ's Mom's House.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 31)
					{
						Houses[id][ExitX] = 1263.079956; Houses[id][ExitY] = -785.308960; Houses[id][ExitZ] = 1091.959961;
						Houses[id][ExitInterior] = 5;
						format(string, sizeof string, "House ID: %d - Description: Madd Dogg's Mansion (West door).", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 32)
					{
						Houses[id][ExitX] = 2464.109863; Houses[id][ExitY] = -1698.659912; Houses[id][ExitZ] = 1013.509949;
						Houses[id][ExitInterior] = 2;
						format(string, sizeof string, "House ID: %d - Description: Ryder's house.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 33)
					{
						Houses[id][ExitX] = 2526.459961; Houses[id][ExitY] = -1679.089966; Houses[id][ExitZ] = 1015.500000;
						Houses[id][ExitInterior] = 1;
						format(string, sizeof string, "House ID: %d - Description: Sweet's House (South side of house is fucked).", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 34)
					{
						Houses[id][ExitX] = 2543.659912; Houses[id][ExitY] = -1303.629883; Houses[id][ExitZ] = 1025.069946;
						Houses[id][ExitInterior] = 2;
						format(string, sizeof string, "House ID: %d - Description: Big Smoke's Crack Factory (Ground Floor).", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 35)
					{
						Houses[id][ExitX] = 744.542969; Houses[id][ExitY] = 1437.669922; Houses[id][ExitZ] = 1102.739990;
						Houses[id][ExitInterior] = 6;
						format(string, sizeof string, "House ID: %d - Description: Fanny Batter's Whore House.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 36)
					{
						Houses[id][ExitX] = 964.106995; Houses[id][ExitY] = -53.205498; Houses[id][ExitZ] = 1001.179993;
						Houses[id][ExitInterior] = 3;
						format(string, sizeof string, "House ID: %d - Description: Tiger Skin Rug Brothel.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 37)
					{
						Houses[id][ExitX] = 2350.339844; Houses[id][ExitY] = -1181.649902; Houses[id][ExitZ] = 1028.000000;
						Houses[id][ExitInterior] = 5;
						format(string, sizeof string, "House ID: %d - Description: Burning Desire Gang House.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 38)
					{
						Houses[id][ExitX] = 2807.619873; Houses[id][ExitY] = -1171.899902; Houses[id][ExitZ] = 1025.579956;
						Houses[id][ExitInterior] = 8;
						format(string, sizeof string, "House ID: %d - Description: Colonel Furhberger's House.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 39)
					{
						Houses[id][ExitX] = 318.564972; Houses[id][ExitY] = 1118.209961; Houses[id][ExitZ] = 1083.979980;
						Houses[id][ExitInterior] = 5;
						format(string, sizeof string, "House ID: %d - Description: Crack Den.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 40)
					{
						Houses[id][ExitX] = 2324.419922; Houses[id][ExitY] = -1147.539917; Houses[id][ExitZ] = 1050.719971;
						Houses[id][ExitInterior] = 12;
						format(string, sizeof string, "House ID: %d - Description: Unused Safe House.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 41)
					{
						Houses[id][ExitX] = 446.622986; Houses[id][ExitY] = 509.318970; Houses[id][ExitZ] = 1001.419983;
						Houses[id][ExitInterior] = 12;
						format(string, sizeof string, "House ID: %d - Description: Budget Inn Motel Room.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 42)
					{
						Houses[id][ExitX] = 2216.339844; Houses[id][ExitY] = -1150.509888; Houses[id][ExitZ] = 1025.799927;
						Houses[id][ExitInterior] = 15;
						format(string, sizeof string, "House ID: %d - Description: Jefferson Motel. (REALLY EXPENSIVE)", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
					SaveHouses();
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
  	if(strcmp(cmd, "/abuildingint", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "[USAGE:] /abuildingint [buildingid] [id (1-17)]");
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INTS:] 1: Sherman Dam - 2: Planning Department - 3: Ganton Gym - 4: Cobra Gym - 5: Below The Belt Gym");
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INTS:] 6: RC Battlefield - 7-9: Police Departments - 10-12: Schools - 13: 8 Track Stadium");
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INTS:] 14: Bloodbowl Stadium - 15: Dirtbike Stadium - 16: Kickstart Stadium - 17: Vice Stadium");
				return 1;
			}
   			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "[USAGE:] /abuildingint [buildingid] [id (1-33)]");
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INTS:] 1: Sherman Dam - 2: Planning Department - 3: Ganton Gym - 4: Cobra Gym - 5: Below The Belt Gym");
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INTS:] 6: RC Battlefield - 7-9: Police Departments - 10-12: Schools - 13: 8 Track Stadium");
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INTS:] 14: Bloodbowl Stadium - 15: Dirtbike Stadium - 16: Kickstart Stadium - 17: Vice Stadium");
						return 1;
					}
					new id2;
					id2 = strval(tmp);
					if(id2 < 1 || id2 > 17) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Interior ID's 1-17."); return 1; }

					if(id2 == 1)
					{
						Building[id][ExitX] = -959.873962;
						Building[id][ExitY] = 1952.000000;
						Building[id][ExitZ] = 9.044310;
						Building[id][ExitInterior] = 17;
						format(string, sizeof string, "Building ID: %d - Description: Sherman Dam.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 2)
					{
						Building[id][ExitX] = 388.871979;
						Building[id][ExitY] = 173.804993;
						Building[id][ExitZ] = 1008.389954;
						Building[id][ExitInterior] = 3;
						format(string, sizeof string, "Building ID: %d - Description: Planning Department.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 3)
					{
						Building[id][ExitX] = 772.112000;
						Building[id][ExitY] = -3.898650;
						Building[id][ExitZ] = 1000.687988;
						Building[id][ExitInterior] = 5;
						format(string, sizeof string, "Building ID: %d - Description: Ganton Gym.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 4)
					{
						Building[id][ExitX] = 774.213989;
						Building[id][ExitY] = -48.924297;
						Building[id][ExitZ] = 1000.687988;
						Building[id][ExitInterior] = 6;
						format(string, sizeof string, "Building ID: %d - Description: Cobra Gym.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 5)
					{
						Building[id][ExitX] = 773.579956;
						Building[id][ExitY] = -77.096695;
						Building[id][ExitZ] = 1000.687988;
						Building[id][ExitInterior] = 7;
						format(string, sizeof string, "Building ID: %d - Description: Below The Belt Gym.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 6)
					{
						Building[id][ExitX] = -972.4957;
						Building[id][ExitY] = 1060.983;
						Building[id][ExitZ] = 1345.669;
						Building[id][ExitInterior] = 10;
						format(string, sizeof string, "Building ID: %d - Description: RC Battlefield.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 7)
					{
						Building[id][ExitX] = 246.783997;
						Building[id][ExitY] = 63.900200;
						Building[id][ExitZ] = 1003.639954;
						Building[id][ExitInterior] = 6;
						format(string, sizeof string, "Building ID: %d - Description: LSPD.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 8)
					{
						Building[id][ExitX] = 246.375992;
						Building[id][ExitY] = 109.245995;
						Building[id][ExitZ] = 1003.279968;
						Building[id][ExitInterior] = 10;
						format(string, sizeof string, "Building ID: %d - Description: SFPD.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 9)
					{
						Building[id][ExitX] = 238.661987;
						Building[id][ExitY] = 141.051987;
						Building[id][ExitZ] = 1003.049988;
						Building[id][ExitInterior] = 3;
						format(string, sizeof string, "Building ID: %d - Description: LVPD.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 10)
					{
						Building[id][ExitX] = 1494.429932;
						Building[id][ExitY] = 1305.629883;
						Building[id][ExitZ] = 1093.289917;
						Building[id][ExitInterior] = 3;
						format(string, sizeof string, "Building ID: %d - Description: Bike School.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 11)
					{
						Building[id][ExitX] = -2029.719971;
						Building[id][ExitY] = -115.067993;
						Building[id][ExitZ] = 1035.169922;
						Building[id][ExitInterior] = 3;
						format(string, sizeof string, "Building ID: %d - Description: Driving School.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 12)
					{
						Building[id][ExitX] = 420.484985;
						Building[id][ExitY] = 2535.589844;
						Building[id][ExitZ] = 10.020289;
						Building[id][ExitInterior] = 10;
						format(string, sizeof string, "Building ID: %d - Description: School (None).", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 13)
					{
						Building[id][ExitX] = -1397.782470;
						Building[id][ExitY] = -203.723114;
						Building[id][ExitZ] = 1051.346801;
						Building[id][ExitInterior] = 7;
						format(string, sizeof string, "Building ID: %d - Description: 8 Track Stadium.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 14)
					{
						Building[id][ExitX] = -1398.103515;
						Building[id][ExitY] = 933.445434;
						Building[id][ExitZ] = 1041.531250;
						Building[id][ExitInterior] = 15;
						format(string, sizeof string, "Building ID: %d - Description: Bloodbowl Stadium.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 15)
					{
						Building[id][ExitX] = -1428.809448;
						Building[id][ExitY] = -663.595886;
						Building[id][ExitZ] = 1060.219848;
						Building[id][ExitInterior] = 4;
						format(string, sizeof string, "Building ID: %d - Description: Dirtbike Stadium.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 16)
					{
						Building[id][ExitX] = -1486.861816;
						Building[id][ExitY] = 1642.145996;
						Building[id][ExitZ] = 1060.671875;
						Building[id][ExitInterior] = 14;
						format(string, sizeof string, "Building ID: %d - Description: Kickstart Stadium.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 17)
					{
						Building[id][ExitX] = -1401.830000;
						Building[id][ExitY] = 107.051300;
						Building[id][ExitZ] = 1032.273000;
						Building[id][ExitInterior] = 1;
						format(string, sizeof string, "Building ID: %d - Description: Vice Stadium (Only center is solid).", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
					SaveBuildings();
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/abusinessint", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "[USAGE:] /abusinessint [bizid] [id (1-33)]");
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INTS:] 1: Marcos Bistro (Eat) - 2: Big Spread Ranch (Bar) - 3: Burger Shot (Eat) - 4: Cluckin Bell (EAT)");
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INTS:] 5: Well Stacked Pizza (Eat) - 6: Rusty Browns Dohnuts (Eat) - 7: Jays Diner (Eat) - 8: Pump Truck Stop Diner (Eat)");
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INTS:] 9: Alhambra (Drink) - 10: Mistys (Drink) - 11: Lil' Probe Inn (Drink) - 12: Exclusive (Clothes) - 13: Binco (Clothes)");
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INTS:] 14: ProLaps (Clothes) - 15: SubUrban (Clothes) - 16: Victim (Clothes) - 17: Zip (Clothes) - 18: Redsands Casino");
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INTS:] 19: Off Track Betting - 20: Sex Shop - 21: Zeros RC Shop - 22-25: Ammunations (Gun) - 26: Ammu Shooting Range (DONT USE)");
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INTS:] 27: Jizzys (Drink) - 27-33: 24-7's (Buy)");
				return 1;
			}
   			if (PlayerInfo[playerid][pAdmin] >= 7)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_WHITE, "[USAGE:] /abusinessint [bizid] [id (1-33)]");
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INTS:] 1: Marcos Bistro (Eat) - 2: Big Spread Ranch (Bar) - 3: Burger Shot (Eat) - 4: Cluckin Bell (EAT)");
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INTS:] 5: Well Stacked Pizza (Eat) - 6: Rusty Browns Dohnuts (Eat) - 7: Jays Diner (Eat) - 8: Pump Truck Stop Diner (Eat)");
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INTS:] 9: Alhambra (Drink) - 10: Mistys (Drink) - 11: Lil' Probe Inn (Drink) - 12: Exclusive (Clothes) - 13: Binco (Clothes)");
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INTS:] 14: ProLaps (Clothes) - 15: SubUrban (Clothes) - 16: Victim (Clothes) - 17: Zip (Clothes) - 18: Redsands Casino");
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INTS:] 19: Off Track Betting - 20: Sex Shop - 21: Zeros RC Shop - 22-25: Ammunations (Gun) - 26: Ammu Shooting Range (DONT USE)");
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INTS:] 27: Jizzys (Drink) - 27-33: 24-7's (Buy)");
						return 1;
					}
					new id2;
					id2 = strval(tmp);
					if(id2 < 1 || id2 > 33) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Interior ID's 1-33."); return 1; }

					if(id2 == 1)
					{
						Businesses[id][ExitX] = 794.8064;
						Businesses[id][ExitY] = 491.6866;
						Businesses[id][ExitZ] = 1376.195;
						Businesses[id][ExitInterior] = 1;
						format(string, sizeof string, "Business ID: %d - Description: Marcos Bistro.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
					else if(id2 == 2)
					{
						Businesses[id][ExitX] = 1212.019897;
						Businesses[id][ExitY] = -28.663099;
						Businesses[id][ExitZ] = 1001.089966;
						Businesses[id][ExitInterior] = 3;
						format(string, sizeof string, "Business ID: %d - Description: Big Spread Ranch Strip Club.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 3)
					{
						Businesses[id][ExitX] = 366.923980;
						Businesses[id][ExitY] = -72.929359;
						Businesses[id][ExitZ] = 1001.507812;
						Businesses[id][ExitInterior] = 10;
						format(string, sizeof string, "Business ID: %d - Description: Burger Shot.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 4)
					{
						Businesses[id][ExitX] = 365.672974;
						Businesses[id][ExitY] = -10.713200;
						Businesses[id][ExitZ] = 1001.869995;
						Businesses[id][ExitInterior] = 9;
						format(string, sizeof string, "Business ID: %d - Description: Cluckin Bell.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 5)
					{
						Businesses[id][ExitX] = 372.351990;
						Businesses[id][ExitY] = -131.650986;
						Businesses[id][ExitZ] = 1001.449951;
						Businesses[id][ExitInterior] = 5;
						format(string, sizeof string, "Business ID: %d - Description: Well Stacked Pizza.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 6)
					{
						Businesses[id][ExitX] = 377.098999;
						Businesses[id][ExitY] = -192.439987;
						Businesses[id][ExitZ] = 1000.643982;
						Businesses[id][ExitInterior] = 17;
						format(string, sizeof string, "Business ID: %d - Description: Rusty Brown Dohnuts.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 7)
					{
						Businesses[id][ExitX] = 460.099976;
						Businesses[id][ExitY] = -88.428497;
						Businesses[id][ExitZ] = 999.621948;
						Businesses[id][ExitInterior] = 4;
						format(string, sizeof string, "Business ID: %d - Description: Jays Diner.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 8)
					{
						Businesses[id][ExitX] = 681.474976;
						Businesses[id][ExitY] = -451.150970;
						Businesses[id][ExitZ] = -25.616798;
						Businesses[id][ExitInterior] = 1;
						format(string, sizeof string, "Business ID: %d - Description: Pump Truck Stop Diner.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 9)
					{
						Businesses[id][ExitX] = 476.068328;
						Businesses[id][ExitY] = -14.893922;
						Businesses[id][ExitZ] = 1003.695312;
						Businesses[id][ExitInterior] = 17;
						format(string, sizeof string, "Business ID: %d - Description: Alhambra.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 10)
					{
						Businesses[id][ExitX] = 501.980988;
						Businesses[id][ExitY] = -69.150200;
						Businesses[id][ExitZ] = 998.834961;
						Businesses[id][ExitInterior] = 11;
						format(string, sizeof string, "Business ID: %d - Description: Mistys.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 11)
					{
						Businesses[id][ExitX] = -227.028000;
						Businesses[id][ExitY] = 1401.229980;
						Businesses[id][ExitZ] = 27.769798;
						Businesses[id][ExitInterior] = 18;
						format(string, sizeof string, "Business ID: %d - Description: Lil' Probe Inn.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 12)
					{
						Businesses[id][ExitX] = 204.332993;
						Businesses[id][ExitY] = -166.694992;
						Businesses[id][ExitZ] = 1000.578979;
						Businesses[id][ExitInterior] = 14;
						format(string, sizeof string, "Business ID: %d - Description: EXcLusive.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 13)
					{
						Businesses[id][ExitX] = 207.737991;
						Businesses[id][ExitY] = -109.019997;
						Businesses[id][ExitZ] = 1005.269958;
						Businesses[id][ExitInterior] = 15;
						format(string, sizeof string, "Business ID: %d - Description: Binco.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 14)
					{
						Businesses[id][ExitX] = 207.054993;
						Businesses[id][ExitY] = -138.804993;
						Businesses[id][ExitZ] = 1003.519958;
						Businesses[id][ExitInterior] = 3;
						format(string, sizeof string, "Business ID: %d - Description: ProLaps.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 15)
					{
						Businesses[id][ExitX] = 203.778000;
						Businesses[id][ExitY] = -48.492397;
						Businesses[id][ExitZ] = 1001.799988;
						Businesses[id][ExitInterior] = 1;
						format(string, sizeof string, "Business ID: %d - Description: SubUrban.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 16)
					{
						Businesses[id][ExitX] = 226.293991;
						Businesses[id][ExitY] = -7.431530;
						Businesses[id][ExitZ] = 1002.259949;
						Businesses[id][ExitInterior] = 5;
						format(string, sizeof string, "Business ID: %d - Description: Victim.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 17)
					{
						Businesses[id][ExitX] = 161.391006;
						Businesses[id][ExitY] = -93.159156;
						Businesses[id][ExitZ] = 1001.804687;
						Businesses[id][ExitInterior] = 18;
						format(string, sizeof string, "Business ID: %d - Description: Zip.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 18)
					{
						Businesses[id][ExitX] = 1133.069946;
						Businesses[id][ExitY] = -9.573059;
						Businesses[id][ExitZ] = 1000.750000;
						Businesses[id][ExitInterior] = 12;
						format(string, sizeof string, "Business ID: %d - Description: Small Casino in Redsands West.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 19)
					{
						Businesses[id][ExitX] = 833.818970;
						Businesses[id][ExitY] = 7.418000;
						Businesses[id][ExitZ] = 1004.179993;
						Businesses[id][ExitInterior] = 3;
						format(string, sizeof string, "Business ID: %d - Description: Off Track Betting.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 20)
					{
						Businesses[id][ExitX] = -100.325996;
						Businesses[id][ExitY] = -22.816500;
						Businesses[id][ExitZ] = 1000.741943;
						Businesses[id][ExitInterior] = 3;
						format(string, sizeof string, "Business ID: %d - Description: Sex Shop.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 21)
					{
						Businesses[id][ExitX] = -2239.569824;
						Businesses[id][ExitY] = 130.020996;
						Businesses[id][ExitZ] = 1035.419922;
						Businesses[id][ExitInterior] = 6;
						format(string, sizeof string, "Business ID: %d - Description: Zero's RC Shop.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 22)
					{
						Businesses[id][ExitX] = 286.148987;
						Businesses[id][ExitY] = -40.644398;
						Businesses[id][ExitZ] = 1001.569946;
						Businesses[id][ExitInterior] = 1;
						format(string, sizeof string, "Business ID: %d - Description: Ammunation 1.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 23)
					{
						Businesses[id][ExitX] = 286.800995;
						Businesses[id][ExitY] = -82.547600;
						Businesses[id][ExitZ] = 1001.539978;
						Businesses[id][ExitInterior] = 4;
						format(string, sizeof string, "Business ID: %d - Description: Ammunation 2.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
	 				else if(id2 == 24)
					{
						Businesses[id][ExitX] = 296.919983;
						Businesses[id][ExitY] = -108.071999;
						Businesses[id][ExitZ] = 1001.569946;
						Businesses[id][ExitInterior] = 6;
						format(string, sizeof string, "Business ID: %d - Description: Ammunation 3.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 25)
					{
						Businesses[id][ExitX] = 316.524994;
						Businesses[id][ExitY] = -167.706985;
						Businesses[id][ExitZ] = 999.661987;
						Businesses[id][ExitInterior] = 6;
						format(string, sizeof string, "Business ID: %d - Description: Ammunation 4.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 26)
					{
						Businesses[id][ExitX] = 302.292877;
						Businesses[id][ExitY] = -143.139099;
						Businesses[id][ExitZ] = 1004.062500;
						Businesses[id][ExitInterior] = 7;
						format(string, sizeof string, "Business ID: %d - Description: Ammunation Shooting Range.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 27)
					{
						Businesses[id][ExitX] = -2637.449951;
						Businesses[id][ExitY] = 1404.629883;
						Businesses[id][ExitZ] = 906.457947;
						Businesses[id][ExitInterior] = 3;
						format(string, sizeof string, "Business ID: %d - Description: Jizzys.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 28)
					{
						Businesses[id][ExitX] = -25.884499;
						Businesses[id][ExitY] = -185.868988;
						Businesses[id][ExitZ] = 1003.549988;
						Businesses[id][ExitInterior] = 17;
						format(string, sizeof string, "Business ID: %d - Description: 24-7 1.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 29)
					{
						Businesses[id][ExitX] = 6.091180;
						Businesses[id][ExitY] = -29.271898;
						Businesses[id][ExitZ] = 1003.549988;
						Businesses[id][ExitInterior] = 10;
						format(string, sizeof string, "Business ID: %d - Description: 24-7 2.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 30)
					{
						Businesses[id][ExitX] = -30.946699;
						Businesses[id][ExitY] = -89.609596;
						Businesses[id][ExitZ] = 1003.549988;
						Businesses[id][ExitInterior] = 18;
						format(string, sizeof string, "Business ID: %d - Description: 24-7 3.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 31)
					{
						Businesses[id][ExitX] = -25.132599;
						Businesses[id][ExitY] = -139.066986;
						Businesses[id][ExitZ] = 1003.549988;
						Businesses[id][ExitInterior] = 16;
						format(string, sizeof string, "Business ID: %d - Description: 24-7 4.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
     				else if(id2 == 32)
					{
						Businesses[id][ExitX] = -27.312300;
						Businesses[id][ExitY] = -29.277599;
						Businesses[id][ExitZ] = 1003.549988;
						Businesses[id][ExitInterior] = 4;
						format(string, sizeof string, "Business ID: %d - Description: 24-7 5.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
         			else if(id2 == 33)
					{
						Businesses[id][ExitX] = -26.691599;
						Businesses[id][ExitY] = -55.714897;
						Businesses[id][ExitZ] = 1003.549988;
						Businesses[id][ExitInterior] = 6;
						format(string, sizeof string, "Business ID: %d - Description: 24-7 6.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,string);
     				}
					SaveBusinesses();
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/ahouseprice", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /ahouseprice [houseid] [price]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 7)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /ahouseprice [houseid] [price]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					Houses[id][HousePrice] = id2;
					new form[128];
					format(form, sizeof form, "You've set House ID: %d's price to %d.", id,id2);
					SendClientMessage(playerid, COLOR_ADMINCMD,form);
					SaveHouses();
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/abusinessname", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /abusinessname [bizid] [name]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 7)
			{
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[128];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /abusinessname [bizid] [name]");
					return 1;
				}
				if(strfind( result , "|" , true ) == -1)
    			{
		   			strmid(Businesses[id][BusinessName], (result), 0, strlen((result)), 128);
					format(string, sizeof(string), "[INFO:] You have set Business ID's: %d's name to %s", id,(result));
					SendClientMessage(playerid, COLOR_ADMINCMD, string);
					SaveBusinesses();
				}
				else
				{
				    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Symbol, | is not allowed!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/abusinesssell", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /abusinesssell [businessid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 7)
			{
				Businesses[id][Locked] = 1;
				Businesses[id][Owned] = 0;
				strmid(Businesses[id][Owner], "None", 0, strlen("None"), 255);
				ChangeStreamPickupModel(Businesses[id][PickupID],1272);
    			MoveStreamPickup(Businesses[id][PickupID],Businesses[id][EnterX], Businesses[id][EnterY], Businesses[id][EnterZ]);
				SaveBusinesses();
				new form[128];
				format(form, sizeof(form), "[INFO:] You have sold business ID: %d.", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/ahousesell", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /ahousesell [houseid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 7)
			{
				Houses[id][Locked] = 1;
				Houses[id][Owned] = 0;
				strmid(Houses[id][Owner], "None", 0, strlen("None"), 255);
				ChangeStreamPickupModel(Houses[id][PickupID],1273);
    			MoveStreamPickup(Houses[id][PickupID],Houses[id][EnterX], Houses[id][EnterY], Houses[id][EnterZ]);
				SaveHouses();
				new form[128];
				format(form, sizeof(form), "[INFO:] You have sold house ID: %d.", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/ahouseentrance", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /ahouseentrance [houseid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 7)
			{
			    new pmodel;
				new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid, x, y, z);
				Houses[id][EnterX] = x;
				Houses[id][EnterY] = y;
				Houses[id][EnterZ] = z;
				Houses[id][EnterWorld] = GetPlayerVirtualWorld(playerid);
				Houses[id][EnterInterior] = GetPlayerInterior(playerid);
  				new Float:angle;
				GetPlayerFacingAngle(playerid, angle);
				Houses[id][EnterAngle] = angle;

				switch(Houses[id][Owned])
				{
				    case 0: pmodel = 1273;
				    case 1: pmodel = 1239;
				}
				ChangeStreamPickupModel(Houses[id][PickupID],pmodel);
    			MoveStreamPickup(Houses[id][PickupID],Houses[id][EnterX], Houses[id][EnterY], Houses[id][EnterZ]);
				SaveHouses();
				new form[128];
				format(form, sizeof(form), "[INFO:] You have set house ID: %d's location.", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/ahouseexit", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /ahouseexit [houseid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 7)
			{
				new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid, x, y, z);
				Houses[id][ExitX] = x;
				Houses[id][ExitY] = y;
				Houses[id][ExitZ] = z;
				Houses[id][ExitInterior] = GetPlayerInterior(playerid);
  				new Float:angle;
				GetPlayerFacingAngle(playerid, angle);
				Houses[id][ExitAngle] = angle;
				SaveHouses();
				new form[128];
				format(form, sizeof(form), "[INFO:] You have set house ID: %d's exit location.", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/ahousedescription", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /ahousedescription [houseid] [discription]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 7)
			{
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[128];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /ahousedescription [houseid] [discription]");
					return 1;
				}
				if(strfind( result , "|" , true ) == -1)
    			{
		   			strmid(Houses[id][Description], (result), 0, strlen((result)), 128);
					format(string, sizeof(string), "[INFO:] You have set house ID: %d's description to %s", id,(result));
					SendClientMessage(playerid, COLOR_ADMINCMD, string);
					SaveHouses();
				}
 				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid symbol, | is not allowed!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator!");
			}
		}
		return 1;
	}
	//===========================================================================================================================
	
	//===========================================[DYNAMIC BUILDINGS SYSTEM]=====================================================
	if(strcmp(cmd, "/abuildingentrance", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /abuildingentrance [buildingid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
				new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid, x, y, z);
				Building[id][EnterX] = x;
				Building[id][EnterY] = y;
				Building[id][EnterZ] = z;
				Building[id][EnterWorld] = GetPlayerVirtualWorld(playerid);
				Building[id][EnterInterior] = GetPlayerInterior(playerid);
  				new Float:angle;
				GetPlayerFacingAngle(playerid, angle);
				Building[id][EnterAngle] = angle;
				MoveStreamPickup(Building[id][PickupID],Building[id][EnterX], Building[id][EnterY], Building[id][EnterZ]);
				SaveBuildings();
				new form[128];
				format(form, sizeof(form), "[INFO:] You have set building ID: %d's location.", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
 	if (strcmp(cmd, "/phonebook", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[giveplayerid][pPhoneBook])
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /phonebook [playerid/PartOfName]");
					return 1;
				}
				//giveplayerid = strval(tmp);
				giveplayerid = ReturnUser(tmp);
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
				        if(gPlayerLogged[giveplayerid])
						{
					        if(PlayerInfo[giveplayerid][pListNumber])
					        {
								format(string, 128, "[PHONE:] Name: %s, Phone Number: %d.",GetPlayerNameEx(giveplayerid),PlayerInfo[giveplayerid][pPhoneNumber]);
								SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
							}
							else
							{
							    SendClientMessage(playerid, COLOR_LIGHTGREEN, "[ERROR:] That user's number isn't public listed.");
							}
						}
      					else
						{
    						SendClientMessage(playerid, COLOR_LIGHTGREEN, "[ERROR:] That player isn't logged in.");
						}
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid player ID/Name.");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't even have a phonebook! You can buy one from a 24-7 store.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/agotobuilding", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /agotobuilding [buildingid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				SetPlayerPos(playerid,Building[id][EnterX],Building[id][EnterY],Building[id][EnterZ]);
				SetPlayerInterior(playerid,Building[id][EnterInterior]);
				SetPlayerVirtualWorld(playerid,Building[id][EnterWorld]);
				new form[128];
				format(form, sizeof(form), "[INFO:] You teleported to building ID: %d.", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/abuildinglock", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /abuildinglock [buildingid]");
				return 1;
			}
			new id = strval(tmp);
			new form[128];
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
			    if(Building[id][Locked] == 0)
			    {
			    	Building[id][Locked] = 1;
   					format(form, sizeof(form), "[INFO:] You have locked building ID: %d.", id);
					SendClientMessage(playerid, COLOR_ADMINCMD, form);
			    }
			    else
			    {
			    	Building[id][Locked] = 0;
   					format(form, sizeof(form), "[INFO:] You have unlocked building ID: %d.", id);
					SendClientMessage(playerid, COLOR_ADMINCMD, form);
			    }
				SaveBuildings();
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/abuildingexit", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /abuildingexit [buildingid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
				new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid, x, y, z);
				Building[id][ExitX] = x;
				Building[id][ExitY] = y;
				Building[id][ExitZ] = z;
				Building[id][ExitInterior] = GetPlayerInterior(playerid);
  				new Float:angle;
				GetPlayerFacingAngle(playerid, angle);
				Building[id][ExitAngle] = angle;
				SaveBuildings();
				new form[128];
				format(form, sizeof(form), "[INFO:] You have set building ID: %d's exit location.", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/abuildingname", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /abuildingname [buildingid] [name]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[64];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /abuildingname [buildingid] [name]");
					return 1;
				}
				if(strfind( result , "|" , true ) == -1)
    			{
		   			strmid(Building[id][BuildingName], (result), 0, strlen((result)), 128);
					format(string, sizeof(string), "[INFO:] You have set Building ID: %d's name to %s", id,(result));
					SendClientMessage(playerid, COLOR_ADMINCMD, string);
					SaveBuildings();
				}
				else
				{
				    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid symbol, | is not allowed!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/abuildingfee", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /abuildingfee [buildingid] [amount]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /abuildingfee [buildingid] [amount]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					Building[id][EntranceFee] = id2;
					new form[128];
					format(form, sizeof form, "You've set Building ID: %d's Entrance Fee to %d.", id,id2);
					SendClientMessage(playerid, COLOR_ADMINCMD,form);
					SaveBuildings();
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	//===========================================================================================================================
	if(strcmp(cmd, "/agotobank", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerPos(playerid,BankPosition[X],BankPosition[Y],BankPosition[Z]);
			SetPlayerInterior(playerid,BankPosition[Interior]);
			SetPlayerVirtualWorld(playerid,BankPosition[World]);
			SetPlayerFacingAngle(playerid,BankPosition[Angle]);
			SendClientMessage(playerid, COLOR_ADMINCMD, "[INFO:] You teleported to the Bank Position.");
		}
		else
		{
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
		}
		return 1;
	}
   	if(strcmp(cmd, "/agotodrivingtestpos", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerPos(playerid,DrivingTestPosition[X],DrivingTestPosition[Y],DrivingTestPosition[Z]);
			SetPlayerInterior(playerid,DrivingTestPosition[Interior]);
			SetPlayerVirtualWorld(playerid,DrivingTestPosition[World]);
			SetPlayerFacingAngle(playerid,DrivingTestPosition[Angle]);
			SendClientMessage(playerid, COLOR_ADMINCMD, "[INFO:] You teleported to the driving test position.");
		}
		else
		{
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
		}
		return 1;
	}
	if(strcmp(cmd, "/agotoflyingtestpos", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerPos(playerid,FlyingTestPosition[X],FlyingTestPosition[Y],FlyingTestPosition[Z]);
			SetPlayerInterior(playerid,FlyingTestPosition[Interior]);
			SetPlayerVirtualWorld(playerid,FlyingTestPosition[World]);
			SetPlayerFacingAngle(playerid,FlyingTestPosition[Angle]);
			SendClientMessage(playerid, COLOR_ADMINCMD, "[INFO:] You teleported to the flying test position.");
		}
		else
		{
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
		}
		return 1;
	}
 	if(strcmp(cmd, "/agotopolicearrestpos", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerPos(playerid,PoliceArrestPosition[X],PoliceArrestPosition[Y],PoliceArrestPosition[Z]);
			SetPlayerInterior(playerid,PoliceArrestPosition[Interior]);
			SetPlayerVirtualWorld(playerid,PoliceArrestPosition[World]);
			SetPlayerFacingAngle(playerid,PoliceArrestPosition[Angle]);
			SendClientMessage(playerid, COLOR_ADMINCMD, "[INFO:] You teleported to the police arrest position.");
		}
		else
		{
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
		}
		return 1;
	}
  	if(strcmp(cmd, "/agotopolicedutypos", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerPos(playerid,PoliceDutyPosition[X],PoliceDutyPosition[Y],PoliceDutyPosition[Z]);
			SetPlayerInterior(playerid,PoliceDutyPosition[Interior]);
			SetPlayerVirtualWorld(playerid,PoliceDutyPosition[World]);
			SetPlayerFacingAngle(playerid,PoliceDutyPosition[Angle]);
			SendClientMessage(playerid, COLOR_ADMINCMD, "[INFO:] You teleported to the police duty position.");
		}
		else
		{
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
		}
		return 1;
	}
	//===============================================[DYNAMIC FACTION MATERIALS & DRUGS STORAGE]=================================
  	if(strcmp(cmd, "/agotofmatsstorage", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerPos(playerid,FactionMaterialsStorage[X],FactionMaterialsStorage[Y],FactionMaterialsStorage[Z]);
			SetPlayerInterior(playerid,FactionMaterialsStorage[Interior]);
			SetPlayerVirtualWorld(playerid,FactionMaterialsStorage[World]);
			SetPlayerFacingAngle(playerid,FactionMaterialsStorage[Angle]);
			SendClientMessage(playerid, COLOR_ADMINCMD, "[INFO:] You teleported to the faction materials storage location.");
		}
		else
		{
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionmatsstorage", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 10)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		FactionMaterialsStorage[X] = x;
		FactionMaterialsStorage[Y] = y;
		FactionMaterialsStorage[Z] = z;
		FactionMaterialsStorage[World] = GetPlayerVirtualWorld(playerid);
		FactionMaterialsStorage[Interior] = GetPlayerInterior(playerid);
		FactionMaterialsStorage[Angle] = angle;
  		MoveStreamPickup(FactionMaterialsStorage[PickupID],FactionMaterialsStorage[X],FactionMaterialsStorage[Y],FactionMaterialsStorage[Z]);
		SaveFactionMaterialsStorage();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the Faction Materials Storage.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
 	if(strcmp(cmd, "/agotofdrugsstorage", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerPos(playerid,FactionDrugsStorage[X],FactionDrugsStorage[Y],FactionDrugsStorage[Z]);
			SetPlayerInterior(playerid,FactionDrugsStorage[Interior]);
			SetPlayerVirtualWorld(playerid,FactionDrugsStorage[World]);
			SetPlayerFacingAngle(playerid,FactionDrugsStorage[Angle]);
			SendClientMessage(playerid, COLOR_ADMINCMD, "[INFO:] You teleported to the faction drugs storage location.");
		}
		else
		{
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
		}
		return 1;
	}
 	if(strcmp(cmd, "/afactiondrugsstorage", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 10)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		FactionDrugsStorage[X] = x;
		FactionDrugsStorage[Y] = y;
		FactionDrugsStorage[Z] = z;
		FactionDrugsStorage[World] = GetPlayerVirtualWorld(playerid);
		FactionDrugsStorage[Interior] = GetPlayerInterior(playerid);
		FactionDrugsStorage[Angle] = angle;
  		MoveStreamPickup(FactionDrugsStorage[PickupID],FactionDrugsStorage[X],FactionDrugsStorage[Y],FactionDrugsStorage[Z]);
		SaveFactionDrugsStorage();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the Faction Drugs Storage.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
	//===================================================================================================================================
	
	//===================================================[BANK POSITION]=================================================================
	if(strcmp(cmd, "/abankpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 10)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		BankPosition[X] = x;
		BankPosition[Y] = y;
		BankPosition[Z] = z;
		BankPosition[World] = GetPlayerVirtualWorld(playerid);
		BankPosition[Interior] = GetPlayerInterior(playerid);
		BankPosition[Angle] = angle;
  		MoveStreamPickup(BankPosition[PickupID],BankPosition[X],BankPosition[Y],BankPosition[Z]);
		SaveBankPosition();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the Bank Position.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
 	if(strcmp(cmd, "/adetectivejobpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		DetectiveJobPosition[X] = x;
		DetectiveJobPosition[Y] = y;
		DetectiveJobPosition[Z] = z;
		DetectiveJobPosition[World] = GetPlayerVirtualWorld(playerid);
		DetectiveJobPosition[Interior] = GetPlayerInterior(playerid);
		DetectiveJobPosition[Angle] = angle;
  		MoveStreamPickup(DetectiveJobPosition[PickupID],DetectiveJobPosition[X],DetectiveJobPosition[Y],DetectiveJobPosition[Z]);
		SaveDetectiveJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the Detective Job.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
  	if(strcmp(cmd, "/alawyerjobpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		LawyerJobPosition[X] = x;
		LawyerJobPosition[Y] = y;
		LawyerJobPosition[Z] = z;
		LawyerJobPosition[World] = GetPlayerVirtualWorld(playerid);
		LawyerJobPosition[Interior] = GetPlayerInterior(playerid);
		LawyerJobPosition[Angle] = angle;
  		MoveStreamPickup(LawyerJobPosition[PickupID],LawyerJobPosition[X],LawyerJobPosition[Y],LawyerJobPosition[Z]);
		SaveLawyerJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the Lawyer Job.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
	if(strcmp(cmd, "/adrugjobpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		DrugJob[TakeJobX] = x;
		DrugJob[TakeJobY] = y;
		DrugJob[TakeJobZ] = z;
		DrugJob[TakeJobWorld] = GetPlayerVirtualWorld(playerid);
		DrugJob[TakeJobInterior] = GetPlayerInterior(playerid);
		DrugJob[TakeJobAngle] = angle;
  		MoveStreamPickup(DrugJob[TakeJobPickupID],DrugJob[TakeJobX],DrugJob[TakeJobY],DrugJob[TakeJobZ]);
		SaveDrugJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the Drug Job Position.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
   	if(strcmp(cmd, "/adrugjobpos2", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		DrugJob[BuyDrugsX] = x;
		DrugJob[BuyDrugsY] = y;
		DrugJob[BuyDrugsZ] = z;
		DrugJob[BuyDrugsWorld] = GetPlayerVirtualWorld(playerid);
		DrugJob[BuyDrugsInterior] = GetPlayerInterior(playerid);
		DrugJob[BuyDrugsAngle] = angle;
  		MoveStreamPickup(DrugJob[BuyDrugsPickupID],DrugJob[BuyDrugsX],DrugJob[BuyDrugsY],DrugJob[BuyDrugsZ]);
		SaveDrugJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the Drug Job Buy Position.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
   	if(strcmp(cmd, "/adrugjobpos3", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		DrugJob[DeliverX] = x;
		DrugJob[DeliverY] = y;
		DrugJob[DeliverZ] = z;
		DrugJob[DeliverWorld] = GetPlayerVirtualWorld(playerid);
		DrugJob[DeliverInterior] = GetPlayerInterior(playerid);
		DrugJob[DeliverAngle] = angle;
  		MoveStreamPickup(DrugJob[DeliverPickupID],DrugJob[DeliverX],DrugJob[DeliverY],DrugJob[DeliverZ]);
		SaveDrugJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the Drug Job Deliver Position.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
  	if(strcmp(cmd, "/aproductjobpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		ProductsSellerJob[TakeJobX] = x;
		ProductsSellerJob[TakeJobY] = y;
		ProductsSellerJob[TakeJobZ] = z;
		ProductsSellerJob[TakeJobWorld] = GetPlayerVirtualWorld(playerid);
		ProductsSellerJob[TakeJobInterior] = GetPlayerInterior(playerid);
		ProductsSellerJob[TakeJobAngle] = angle;
  		MoveStreamPickup(ProductsSellerJob[TakeJobPickupID],ProductsSellerJob[TakeJobX],ProductsSellerJob[TakeJobY],ProductsSellerJob[TakeJobZ]);
		SaveProductsSellerJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the products seller job.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
   	if(strcmp(cmd, "/aproductjobpos2", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		ProductsSellerJob[BuyProductsX] = x;
		ProductsSellerJob[BuyProductsY] = y;
		ProductsSellerJob[BuyProductsZ] = z;
		ProductsSellerJob[BuyProductsWorld] = GetPlayerVirtualWorld(playerid);
		ProductsSellerJob[BuyProductsInterior] = GetPlayerInterior(playerid);
		ProductsSellerJob[BuyProductsAngle] = angle;
    	MoveStreamPickup(ProductsSellerJob[BuyProductsPickupID],ProductsSellerJob[BuyProductsX],ProductsSellerJob[BuyProductsY],ProductsSellerJob[BuyProductsZ]);
		SaveProductsSellerJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the products seller job. (buy products place)");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
 	if(strcmp(cmd, "/agunjobpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		GunJob[TakeJobX] = x;
		GunJob[TakeJobY] = y;
		GunJob[TakeJobZ] = z;
		GunJob[TakeJobWorld] = GetPlayerVirtualWorld(playerid);
		GunJob[TakeJobInterior] = GetPlayerInterior(playerid);
		GunJob[TakeJobAngle] = angle;
  		MoveStreamPickup(GunJob[TakeJobPickupID],GunJob[TakeJobX],GunJob[TakeJobY],GunJob[TakeJobZ]);
		SaveGunJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the Gun Job Position.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
  	if(strcmp(cmd, "/agunjobpos2", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		GunJob[BuyPackagesX] = x;
		GunJob[BuyPackagesY] = y;
		GunJob[BuyPackagesZ] = z;
		GunJob[BuyPackagesWorld] = GetPlayerVirtualWorld(playerid);
		GunJob[BuyPackagesInterior] = GetPlayerInterior(playerid);
		GunJob[BuyPackagesAngle] = angle;
  		MoveStreamPickup(GunJob[BuyPackagesPickupID],GunJob[BuyPackagesX],GunJob[BuyPackagesY],GunJob[BuyPackagesZ]);
		SaveGunJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the Gun Job Materials Packages Buy Position.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
  	if(strcmp(cmd, "/agunjobpos3", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		GunJob[DeliverX] = x;
		GunJob[DeliverY] = y;
		GunJob[DeliverZ] = z;
		GunJob[DeliverWorld] = GetPlayerVirtualWorld(playerid);
		GunJob[DeliverInterior] = GetPlayerInterior(playerid);
		GunJob[DeliverAngle] = angle;
  		MoveStreamPickup(GunJob[DeliverPickupID],GunJob[DeliverX],GunJob[DeliverY],GunJob[DeliverZ]);
		SaveGunJob();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the Gun Job Materials Deliver Position.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
	//===============================================[FLYING & DRIVING TEST POS]==========================================================
	if(strcmp(cmd, "/agotoweaponlicpos", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerPos(playerid,WeaponLicensePosition[X],WeaponLicensePosition[Y],WeaponLicensePosition[Z]);
			SetPlayerInterior(playerid,WeaponLicensePosition[Interior]);
			SetPlayerVirtualWorld(playerid,WeaponLicensePosition[World]);
			SetPlayerFacingAngle(playerid,WeaponLicensePosition[Angle]);
			SendClientMessage(playerid, COLOR_ADMINCMD, "[INFO:] You teleported to the weapon license position.");
		}
		else
		{
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
		}
		return 1;
	}
	if(strcmp(cmd, "/aweaponlicensepos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 10)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		WeaponLicensePosition[X] = x;
		WeaponLicensePosition[Y] = y;
		WeaponLicensePosition[Z] = z;
		WeaponLicensePosition[World] = GetPlayerVirtualWorld(playerid);
		WeaponLicensePosition[Interior] = GetPlayerInterior(playerid);
		WeaponLicensePosition[Angle] = angle;
  		MoveStreamPickup(WeaponLicensePosition[PickupID],WeaponLicensePosition[X],WeaponLicensePosition[Y],WeaponLicensePosition[Z]);
		SaveWeaponLicensePosition();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the Weapon License Position.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
   	if(strcmp(cmd, "/aflyingtestpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 10)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		FlyingTestPosition[X] = x;
		FlyingTestPosition[Y] = y;
		FlyingTestPosition[Z] = z;
		FlyingTestPosition[World] = GetPlayerVirtualWorld(playerid);
		FlyingTestPosition[Interior] = GetPlayerInterior(playerid);
		FlyingTestPosition[Angle] = angle;
  		MoveStreamPickup(FlyingTestPosition[PickupID],FlyingTestPosition[X],FlyingTestPosition[Y],FlyingTestPosition[Z]);
		SaveFlyingTestPosition();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the Flying Test Position.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
  	if(strcmp(cmd, "/adrivingtestpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 10)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		DrivingTestPosition[X] = x;
		DrivingTestPosition[Y] = y;
		DrivingTestPosition[Z] = z;
		DrivingTestPosition[World] = GetPlayerVirtualWorld(playerid);
		DrivingTestPosition[Interior] = GetPlayerInterior(playerid);
		DrivingTestPosition[Angle] = angle;
		MoveStreamPickup(DrivingTestPosition[PickupID],DrivingTestPosition[X],DrivingTestPosition[Y],DrivingTestPosition[Z]);
		SaveDrivingTestPosition();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the Driving Test Position.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
 	if(strcmp(cmd, "/apolicearrestpos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 10)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		PoliceArrestPosition[X] = x;
		PoliceArrestPosition[Y] = y;
		PoliceArrestPosition[Z] = z;
		PoliceArrestPosition[World] = GetPlayerVirtualWorld(playerid);
		PoliceArrestPosition[Interior] = GetPlayerInterior(playerid);
		PoliceArrestPosition[Angle] = angle;
		SavePoliceArrestPosition();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the Police Arrest Position.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
  	if(strcmp(cmd, "/apolicedutypos", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 10)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		PoliceDutyPosition[X] = x;
		PoliceDutyPosition[Y] = y;
		PoliceDutyPosition[Z] = z;
		PoliceDutyPosition[World] = GetPlayerVirtualWorld(playerid);
		PoliceDutyPosition[Interior] = GetPlayerInterior(playerid);
		PoliceDutyPosition[Angle] = angle;
		SavePoliceDutyPosition();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the Police Duty Position.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
	//===============================================[DYNAMIC CIVILIAN SPAWN]====================================================
	if(strcmp(cmd, "/acivilianspawn", true) == 0)
	{
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
  		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		CivilianSpawn[X] = x;
		CivilianSpawn[Y] = y;
		CivilianSpawn[Z] = z;
		CivilianSpawn[World] = GetPlayerVirtualWorld(playerid);
		CivilianSpawn[Interior] = GetPlayerInterior(playerid);
		CivilianSpawn[Angle] = angle;
		SaveCivilianSpawn();
		SendClientMessage(playerid, COLOR_ADMINCMD, "You have successfully set the Civilian Spawnpoint.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
	}
	return 1;
	}
	//================================================[DYNAMIC FACTION SYSTEM]======================================================
 	if(strcmp(cmd, "/afactionspawn", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionspawn [factionid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
				new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid, x, y, z);
				DynamicFactions[id][fX] = x;
				DynamicFactions[id][fY] = y;
				DynamicFactions[id][fZ] = z;
				SaveDynamicFactions();
				format(string, sizeof(string), "[INFO:] You have set faction ID: %d's spawnpoint.", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/aresetfaction", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "USAGE: /aresetfaction [factionid]");
				return 1;
			}
			new factionid = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
				new rank;
				format(string, sizeof(string), "Faction%d",factionid);
				strmid(DynamicFactions[factionid][fName], string, 0, strlen(string), 255);
				DynamicFactions[factionid][fX] = 0.0;
				DynamicFactions[factionid][fY] = 0.0;
				DynamicFactions[factionid][fZ] = 0.0;
				DynamicFactions[factionid][fMaterials] = 0;
				DynamicFactions[factionid][fDrugs] = 0;
				DynamicFactions[factionid][fBank] = 0;
				rank = 1; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank1], string, 0, strlen(string), 255);
				rank ++; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank2], string, 0, strlen(string), 255);
				rank ++; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank3], string, 0, strlen(string), 255);
				rank ++; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank4], string, 0, strlen(string), 255);
				rank ++; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank5], string, 0, strlen(string), 255);
				rank ++; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank6], string, 0, strlen(string), 255);
				rank ++; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank7], string, 0, strlen(string), 255);
				rank ++; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank8], string, 0, strlen(string), 255);
				rank ++; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank9], string, 0, strlen(string), 255);
				rank ++; format(string, sizeof(string), "Rank%d",rank); strmid(DynamicFactions[factionid][fRank10], string, 0, strlen(string), 255);
				DynamicFactions[factionid][fSkin1] = 0;
				DynamicFactions[factionid][fSkin2] = 0;
				DynamicFactions[factionid][fSkin3] = 0;
				DynamicFactions[factionid][fSkin4] = 0;
				DynamicFactions[factionid][fSkin5] = 0;
				DynamicFactions[factionid][fSkin6] = 0;
				DynamicFactions[factionid][fSkin7] = 0;
				DynamicFactions[factionid][fSkin8] = 0;
				DynamicFactions[factionid][fSkin9] = 0;
				DynamicFactions[factionid][fSkin10] = 0;
				DynamicFactions[factionid][fJoinRank] = 0;
				DynamicFactions[factionid][fUseSkins] = 0;
				DynamicFactions[factionid][fType] = 0;
				DynamicFactions[factionid][fRankAmount] = 0;
				DynamicFactions[factionid][fUseColor] = 0;
				format(string, sizeof(string), "0xFFFFFFFF");
				strmid(DynamicFactions[factionid][fColor], string, 0, strlen(string), 255);
				format(string, sizeof(string), "[INFO:] You have reset Faction ID: %d.", factionid);
				SendClientMessage(playerid, COLOR_ADMINCMD, string);
				SaveDynamicFactions();
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator or an administrator with the required level.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/report", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /report [playerid] [reason]");
				return 1;
			}
			new id = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /report [playerid] [reason]");
				return 1;
			}
			if(IsPlayerConnected(id))
	    	{
	    		if(id != INVALID_PLAYER_ID)
			    {
					format(string, sizeof(string), "[REPORT:] %s has reported %s (ID:%d), Reason: %s",GetPlayerNameEx(playerid),GetPlayerNameEx(id),id,result);
					AdministratorMessage(COLOR_ADMINCMD, string,1);
					format(string, sizeof(string), "You have reported %s (ID:%d), Reason: %s",GetPlayerNameEx(id),id,result);
					SendClientMessage(playerid, COLOR_WHITE, string);
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[SUCCESS:] Report sent.");
					ReportLog(string);
				}
			}
			else
			{
			    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] The person you tried to report is not connected.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/admin", true) == 0 || strcmp(cmd, "/a", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] (/a)dmin [message]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				format(string, sizeof(string), "[ACHAT:] (%d) %s: %s", PlayerInfo[playerid][pAdmin], GetPlayerNameEx(playerid), result);
				AdministratorMessage(COLOR_YELLOW, string,1);
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/listenchat", true) == 0 && PlayerInfo[playerid][pAdmin] >= 2)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (!BigEar[playerid])
			{
				BigEar[playerid] = 1;
			}
			else if (BigEar[playerid])
			{
				(BigEar[playerid] = 0);
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/afactioncolor", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactioncolor [factionid] [hex]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[128];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactioncolour [factionid] [hex]");
					return 1;
				}
				if(strfind( result , "|" , true ) == -1)
    			{
		   			strmid(DynamicFactions[id][fColor], (result), 0, strlen((result)), 128);
					format(string, sizeof(string), "[INFO:] You have set faction ID: %d's colour to %s.", id,(result));
					SendClientMessage(playerid, COLOR_ADMINCMD, string);
					SaveDynamicFactions();
				}
				else
				{
				    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Symbol, | is not allowed!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionname", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionname [factionid] [name]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[128];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionname [factionid] [name]");
					return 1;
				}
				if(strfind( result , "|" , true ) == -1)
    			{
		   			strmid(DynamicFactions[id][fName], (result), 0, strlen((result)), 128);
					format(string, sizeof(string), "[INFO:] You have set faction ID: %d's name to %s", id,(result));
					SendClientMessage(playerid, COLOR_ADMINCMD, string);
					SaveDynamicFactions();
				}
				else
				{
				    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Symbol, | is not allowed!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
  	if(strcmp(cmd, "/agotofaction", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /agotofaction [id]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
				SetPlayerPos(playerid,DynamicFactions[id][fX],DynamicFactions[id][fY],DynamicFactions[id][fZ]);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
				new form[128];
				format(form, sizeof(form), "[INFO:] You teleported to faction ID: %d.", id);
				SendClientMessage(playerid, COLOR_ADMINCMD, form);
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactiontype", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactiontype [factionid] [type (Numeric)]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactiontype [factionid] [type (Numeric)]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					DynamicFactions[id][fType] = id2;
					new form[128];
					format(form, sizeof form, "You've set Faction ID: %d's Type to %d.", id,id2);
					SendClientMessage(playerid, COLOR_ADMINCMD,form);
					SaveDynamicFactions();
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionjoinrank", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionjoinrank [factionid] [2-10]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionjoinrank [factionid] [2-10]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					if(id2 >= 2 && id2 <= 10)
					{
	  					DynamicFactions[id][fJoinRank] = id2;
						new form[128];
						format(form, sizeof form, "You've set Faction ID: %d's JoinRank to %d.", id,id2);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionbank", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionbank [factionid] [amount]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionbank [factionid] [amount]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					DynamicFactions[id][fBank] = id2;
					new form[128];
					format(form, sizeof form, "You've set Faction ID: %d's Bank to %d.", id,id2);
					SendClientMessage(playerid, COLOR_ADMINCMD,form);
					SaveDynamicFactions();
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactiondrugs", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactiondrugs [factionid] [amount]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactiondrugs [factionid] [amount]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					DynamicFactions[id][fDrugs] = id2;
					new form[128];
					format(form, sizeof form, "You've set Faction ID: %d's Drugs to %d.", id,id2);
					SendClientMessage(playerid, COLOR_ADMINCMD,form);
					SaveDynamicFactions();
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionmats", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionmats [factionid] [amount]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionmats [factionid] [amount]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					DynamicFactions[id][fMaterials] = id2;
					new form[128];
					format(form, sizeof form, "You've set Faction ID: %d's Materials to %d.", id,id2);
					SendClientMessage(playerid, COLOR_ADMINCMD,form);
					SaveDynamicFactions();
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionrankamount", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionrankamount [factionid] [2-10]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionrankamount [factionid] [2-10]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					if(id2 >= 2 && id2 <= 10)
					{
	  					DynamicFactions[id][fRankAmount] = id2;
						new form[128];
						format(form, sizeof form, "You've set Faction ID: %d's RankAmount to %d.", id,id2);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionrankname", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionrankname [factionid] [Rank ID - 1-10] [Name]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionrankname [factionid] [Rank ID - 1-10] [Name]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);

					new length = strlen(cmdtext);
					while ((idx < length) && (cmdtext[idx] <= ' '))
					{
						idx++;
					}
					new offset = idx;
					new result[64];
					while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
					{
						result[idx - offset] = cmdtext[idx];
						idx++;
					}
					result[idx - offset] = EOS;
					if(!strlen(result))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionrankname [factionid] [Rank ID - 1-10] [Name]");
						return 1;
					}
  					if(strfind( result , "|" , true ) == -1)
    				{
						if(id2 == 1)
						{
				   			strmid(DynamicFactions[id][fRank1], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "[INFO:] You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
						else if(id2 == 2)
						{
				   			strmid(DynamicFactions[id][fRank2], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "[INFO:] You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
						else if(id2 == 3)
						{
				   			strmid(DynamicFactions[id][fRank3], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "[INFO:] You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
						else if(id2 == 4)
						{
				   			strmid(DynamicFactions[id][fRank4], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "[INFO:] You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
						else if(id2 == 5)
						{
				   			strmid(DynamicFactions[id][fRank5], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "[INFO:] You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
						else if(id2 == 6)
						{
				   			strmid(DynamicFactions[id][fRank6], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "[INFO:] You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
						else if(id2 == 7)
						{
				   			strmid(DynamicFactions[id][fRank7], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "[INFO:] You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
						else if(id2 == 8)
						{
				   			strmid(DynamicFactions[id][fRank8], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "[INFO:] You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
						else if(id2 == 9)
						{
				   			strmid(DynamicFactions[id][fRank9], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "[INFO:] You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
						else if(id2 == 10)
						{
				   			strmid(DynamicFactions[id][fRank10], (result), 0, strlen((result)), 128);
							format(string, sizeof(string), "[INFO:] You have set faction ID: %d's Rank: %d's name to: %s", id,id2,result);
							SendClientMessage(playerid, COLOR_ADMINCMD, string);
							SaveDynamicFactions();
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid symbol, | is not allowed!");
					}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionskin", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionskin [factionid] [Rank ID - 1-10] [Skinid]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
					new id;
					id = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionskin [factionid] [Rank ID - 1-10] [Skinid]");
						return 1;
					}
					new id2;
					id2 = strval(tmp);
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionskin [factionid] [Rank ID - 1-10] [Skinid]");
						return 1;
					}
					new id3;
					id3 = strval(tmp);
					
					if(id2 == 1)
					{
	  					DynamicFactions[id][fSkin1] = id3;
						new form[128];
						format(form, sizeof form, "You've set Faction ID: %d's Rank %d Skin to %d.", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
					else if(id2 == 2)
					{
	  					DynamicFactions[id][fSkin2] = id3;
						new form[128];
						format(form, sizeof form, "You've set Faction ID: %d's Rank %d Skin to %d.", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
					else if(id2 == 3)
					{
	  					DynamicFactions[id][fSkin3] = id3;
						new form[128];
						format(form, sizeof form, "You've set Faction ID: %d's Rank %d Skin to %d.", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
					else if(id2 == 4)
					{
	  					DynamicFactions[id][fSkin4] = id3;
						new form[128];
						format(form, sizeof form, "You've set Faction ID: %d's Rank %d Skin to %d.", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
					else if(id2 == 5)
					{
	  					DynamicFactions[id][fSkin5] = id3;
						new form[128];
						format(form, sizeof form, "You've set Faction ID: %d's Rank %d Skin to %d.", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
					else if(id2 == 6)
					{
	  					DynamicFactions[id][fSkin6] = id3;
						new form[128];
						format(form, sizeof form, "You've set Faction ID: %d's Rank %d Skin to %d.", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
					else if(id2 == 7)
					{
	  					DynamicFactions[id][fSkin7] = id3;
						new form[128];
						format(form, sizeof form, "You've set Faction ID: %d's Rank %d Skin to %d.", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
					else if(id2 == 8)
					{
	  					DynamicFactions[id][fSkin8] = id3;
						new form[128];
						format(form, sizeof form, "You've set Faction ID: %d's Rank %d Skin to %d.", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
					else if(id2 == 9)
					{
	  					DynamicFactions[id][fSkin9] = id3;
						new form[128];
						format(form, sizeof form, "You've set Faction ID: %d's Rank %d Skin to %d.", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
					else if(id2 == 10)
					{
	  					DynamicFactions[id][fSkin10] = id3;
						new form[128];
						format(form, sizeof form, "You've set Faction ID: %d's Rank %d Skin to %d.", id,id2,id3);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SaveDynamicFactions();
					}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/afactionusecolor", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionusecolor [factionid]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
					new id;
					id = strval(tmp);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionusecolor [factionid]");
						return 1;
					}
					if(DynamicFactions[id][fUseColor])
					{
	  					DynamicFactions[id][fUseColor] = 0;
						new form[128];
						format(form, sizeof form, "[INFO:] Faction ID: %d's color disabled.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
				    	SendFactionMessage(id, COLOR_FACTIONCHAT, "[FACTION:] Faction color's disabled by an administrator.");
						SaveDynamicFactions();
						
						for(new i=0;i<MAX_PLAYERS;i++)
						{
					    	if(IsPlayerConnected(i))
					       	{
								if(PlayerInfo[i][pFaction] == id)
								{
									SetPlayerColor(i,COLOR_CIVILIAN);
								}
					       	}
				       	}
					}
					else
					{
	  					DynamicFactions[id][fUseColor] = 1;
						new form[128];
						format(form, sizeof form, "[INFO:] Faction ID: %d's color enabled.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SendFactionMessage(id, COLOR_FACTIONCHAT, "[FACTION:] Faction color's enabled by an administrator.");
						SaveDynamicFactions();
						
  						for(new i=0;i<MAX_PLAYERS;i++)
						{
					    	if(IsPlayerConnected(i))
					       	{
								if(PlayerInfo[i][pFaction] == id)
								{
         							SetPlayerToFactionColor(i);
								}
					       	}
				       	}
					}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/afactionuseskins", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionuseskins [factionid]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
					new id;
					id = strval(tmp);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionuseskins [factionid]");
						return 1;
					}
					
					if(DynamicFactions[id][fUseSkins])
					{
	  					DynamicFactions[id][fUseSkins] = 0;
						new form[128];
						format(form, sizeof form, "[INFO:] Faction ID: %d's skin's disabled.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
				    	SendFactionMessage(id, COLOR_FACTIONCHAT, "[FACTION:] Faction skin's disabled by an administrator.");
						SaveDynamicFactions();

					}
					else
					{
	  					DynamicFactions[id][fUseSkins] = 1;
						new form[128];
						format(form, sizeof form, "[INFO:] Faction ID: %d's skin's enabled.", id);
						SendClientMessage(playerid, COLOR_ADMINCMD,form);
						SendFactionMessage(id, COLOR_FACTIONCHAT, "[FACTION:] Faction skin's enabled by an administrator.");
						SaveDynamicFactions();

						for(new i=0;i<MAX_PLAYERS;i++)
						{
					    	if(IsPlayerConnected(i))
					       	{
								if(PlayerInfo[i][pFaction] == id)
								{
									SetPlayerToFactionSkin(i);
								}
					       	}
				       	}
					}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	//--------------------------------------------------------------------------------------------------------------------------
	//---------------------------------------[NORMAL ADMINISTRATOR COMMANDS]-------------------------------------------
 	if(strcmp(cmd, "/banaccount", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /banaccount [playerid/partofname] [reason]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 2)
			{
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						new length = strlen(cmdtext);
						while ((idx < length) && (cmdtext[idx] <= ' '))
						{
							idx++;
						}
						new offset = idx;
						new result[128];
						while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
						{
							result[idx - offset] = cmdtext[idx];
							idx++;
						}
						result[idx - offset] = EOS;
						if(!strlen(result))
						{
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /banaccount [playerid/partofname] [reason]");
							return 1;
						}
						BanPlayerAccount(giveplayerid,GetPlayerNameEx(playerid),(result));
						return 1;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
			}
		}
		return 1;
	}
    if(strcmp(cmd, "/ban", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /ban [playerid/partofname] [reason]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 2)
			{
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						new length = strlen(cmdtext);
						while ((idx < length) && (cmdtext[idx] <= ' '))
						{
							idx++;
						}
						new offset = idx;
						new result[128];
						while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
						{
							result[idx - offset] = cmdtext[idx];
							idx++;
						}
						result[idx - offset] = EOS;
						if(!strlen(result))
						{
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /ban [playerid/partofname] [reason]");
							return 1;
						}
						BanPlayer(giveplayerid,GetPlayerNameEx(playerid),(result));
						return 1;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/afactionkick", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionkick [playerid/partofname] [reason]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 5)
			{
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						new length = strlen(cmdtext);
						while ((idx < length) && (cmdtext[idx] <= ' '))
						{
							idx++;
						}
						new offset = idx;
						new result[128];
						while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
						{
							result[idx - offset] = cmdtext[idx];
							idx++;
						}
						result[idx - offset] = EOS;
						if(!strlen(result))
						{
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /afactionkick [playerid/partofname] [reason]");
							return 1;
						}
						new form[128];
						format(form,sizeof(form),"%s has been faction-kicked by %s, Reason: %s ",GetPlayerNameEx(giveplayerid),GetPlayerNameEx(playerid),(result));
						SendClientMessageToAll(COLOR_ADMINCMD,form);
						PlayerInfo[giveplayerid][pFaction] = 255;
						SetPlayerSpawn(giveplayerid);
						return 1;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/copduty", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
				if (PlayerToPoint(5.0, playerid,PoliceDutyPosition[X],PoliceDutyPosition[Y],PoliceDutyPosition[Z]))
				{
				    if(GetPlayerVirtualWorld(playerid) == PoliceDutyPosition[World])
				    {
						if(CopOnDuty[playerid] == 0)
				        {
				            if(PlayerInfo[playerid][pSex] == 1)
				            {
								PlayerActionMessage(playerid,15.0,"clocks in as a police officer, and takes his stuff from the locker.");
							}
							else
							{
							    PlayerActionMessage(playerid,15.0,"clocks in as a police officer, and takes her stuff from the locker.");
							}
							GivePlayerWeapon(playerid, 24, 70);
							GivePlayerWeapon(playerid, 3, 0);
							GivePlayerWeapon(playerid, 41, 700);
							CopOnDuty[playerid] = 1;
							SetPlayerToFactionSkin(playerid);
							SetPlayerToFactionColor(playerid);
							format(string, sizeof(string), "[LSPD:] %s is now an on duty police officer.",GetPlayerNameEx(playerid));
		    				SendFactionTypeMessage(1, COLOR_LSPD, string);
							return 1;
						}
						else
						{
      						if(PlayerInfo[playerid][pSex] == 1)
				            {
								PlayerActionMessage(playerid,15.0,"clocks out as a police officer, and puts his stuff in the locker.");
							}
							else
							{
							    PlayerActionMessage(playerid,15.0,"clocks out as a police officer, and puts her stuff in the locker.");
							}
							ResetPlayerWeapons(playerid);
							CopOnDuty[playerid] = 0;
							SetPlayerToFactionSkin(playerid);
							SetPlayerToFactionColor(playerid);
							return 1;
						}
					}
				}
    			else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not at the duty position!");
					return 1;
				}
			}
   			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Faction/Type.");
				return 1;
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/wanted", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
			    if(CopOnDuty[playerid])
			    {
			        new count = 0;
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "-----------[Wanted Suspects]-----------");
				    for(new i=0; i < MAX_PLAYERS; i++)
					{
						if(IsPlayerConnected(i))
						{
						    if(WantedLevel[i] >= 1)
						    {
						        format(string, sizeof(string), "[WANTED:] %s (ID:%d) -  Wanted Level: %d.",GetPlayerNameEx(i),i,WantedLevel[i]);
								SendClientMessage(playerid,COLOR_WHITE,string);
								count++;
							}
						}
					}
					if(count == 0)
					{
			    		SendClientMessage(playerid,COLOR_WHITE,"[INFO:] Currently no criminals wanted.");
					}
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "------------------------------------------------");
				}
				else
				{
				    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not on duty!");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Faction.");
			}
		}//not connected
		return 1;
	}
	if(strcmp(cmd, "/cuff", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
			    tmp = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /cuff [playerid]");
					return 1;
				}
				if(CopOnDuty[playerid] == 0)
    			{
	        		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not on duty.");
	        		return 1;
    			}
				giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
					    if(PlayerCuffed[giveplayerid] == 1)
					    {
					        SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That person is already cuffed.");
					        return 1;
					    }
						if (ProxDetectorS(8.0, playerid, giveplayerid))
						{
						    if(giveplayerid == playerid) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can't cuff yourself!"); return 1; }
        					format(string, sizeof(string), "[INFO:] Cuffed by %s.", GetPlayerNameEx(playerid));
							SendClientMessage(giveplayerid, COLOR_RED, string);
							format(string, sizeof(string), "[INFO:] %s successfully cuffed.", GetPlayerNameEx(giveplayerid));
							SendClientMessage(playerid, COLOR_WHITE, string);
							PlayerPlayerActionMessage(playerid,giveplayerid,15.0,"has just handcuffed");
							TogglePlayerControllable(giveplayerid, 0);
							PlayerCuffed[giveplayerid] = 1;
						}
						else
						{
						    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That player is not near you!");
						    return 1;
						}
					}
				}
				else
				{
				    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
				    return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Faction.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/uncuff", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
			    tmp = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /uncuff [playerid]");
					return 1;
				}
				if(CopOnDuty[playerid] == 0)
    			{
	        		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not on duty.");
	        		return 1;
    			}
				giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
					    if(PlayerCuffed[giveplayerid] == 0)
					    {
					        SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That person is not cuffed.");
					        return 1;
					    }
						if (ProxDetectorS(8.0, playerid, giveplayerid))
						{
						    if(giveplayerid == playerid) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can't uncuff yourself!"); return 1; }
        					format(string, sizeof(string), "[INFO:] Uncuffed by %s.", GetPlayerNameEx(playerid));
							SendClientMessage(giveplayerid, COLOR_RED, string);
							format(string, sizeof(string), "[INFO:] %s successfully uncuffed.", GetPlayerNameEx(giveplayerid));
							SendClientMessage(playerid, COLOR_WHITE, string);
							PlayerPlayerActionMessage(playerid,giveplayerid,15.0,"has just uncuffed");
							TogglePlayerControllable(giveplayerid, 1);
							PlayerCuffed[giveplayerid] = 0;
						}
						else
						{
						    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That player is not near you!");
						    return 1;
						}
					}
				}
				else
				{
				    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
				    return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Faction.");
			}
		}
		return 1;
	}
  	if(strcmp(cmd,"/frisk",true)==0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /frisk [playerid]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if(IsPlayerConnected(giveplayerid))
			{
				if(giveplayerid != INVALID_PLAYER_ID)
				{
				    if (ProxDetectorS(8.0, playerid, giveplayerid))
					{
					    if(giveplayerid == playerid) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can't frisk yourself!"); return 1; }
					    if(CopOnDuty[playerid] == 0) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not even on duty."); return 1; }
					    new text1[128], text2[128];
					    if(PlayerInfo[giveplayerid][pDrugs] > 0) { text1 = "[FRISK:] Drugs found."; } else { text1 = "[FRISK:] No drugs found."; }
					    if(PlayerInfo[giveplayerid][pMaterials] > 0) { text2 = "[FRISK] Weapon materials found."; } else { text2 = "[FRISK:] No materials found."; }
					    format(string, sizeof(string), "-------------------[%s]-------------------", GetPlayerNameEx(giveplayerid));
				        SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
				        format(string, sizeof(string), "%s", text1);
						SendClientMessage(playerid, COLOR_WHITE, string);
						format(string, sizeof(string), "%s", text2);
						SendClientMessage(playerid, COLOR_WHITE, string);
						new Player_Weapons[13];
						new Player_Ammos[13];
						new i;

						for(i = 1;i <= 12;i++)
						{
							GetPlayerWeaponData(giveplayerid,i,Player_Weapons[i],Player_Ammos[i]);
							if(Player_Weapons[i] != 0)
							{
								new weaponName[128];
								GetWeaponName(Player_Weapons[i],weaponName,255);
								format(string,255,"[FRISK:] Weapon found: %s.",weaponName);
								SendClientMessage(playerid,COLOR_WHITE,string);
							}
						}
						PlayerPlayerActionMessage(playerid,giveplayerid,15.0,"has just frisked");
					}
					else
					{
					    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Not close enough!");
					    return 1;
					}
				}
			}
	        else
	        {
	            SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
	            return 1;
	        }
		}
	    return 1;
 	}
	if(strcmp(cmd, "/revoke", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
	        {
	            new x_nr[256];
				x_nr = strtok(cmdtext, idx);
				if(!strlen(x_nr)) {
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /revoke [item] [playerid]");
			  		SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ITEM:] driverslicense, flyinglicense, weaponlicense, drugs, materials, weapons");
					return 1;
				}
			    if(strcmp(x_nr,"driverslicense",true) == 0)
				{
				    tmp = strtok(cmdtext, idx);
					if(!strlen(tmp)) {
						SendClientMessage(playerid, COLOR_WHITE, "[USAGE:] /revoke driverslicense [playerid]");
						return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if (ProxDetectorS(8.0, playerid, giveplayerid))
							{
						        format(string, sizeof(string), "[INFO:] %s's drivers license successfully revoked.", GetPlayerNameEx(giveplayerid));
						        SendClientMessage(playerid, COLOR_WHITE, string);
						        format(string, sizeof(string), "[INFO:] %s has taken away your Drivers License.", GetPlayerNameEx(playerid));
						        SendClientMessage(giveplayerid, COLOR_RED, string);
						        PlayerInfo[giveplayerid][pCarLic] = 0;
							}
							else
							{
							    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That player is not in range.");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
					    return 1;
					}
				}
				else if(strcmp(x_nr,"flyinglicense",true) == 0)
				{
				    tmp = strtok(cmdtext, idx);
					if(!strlen(tmp)) {
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /revoke flyinglicense [playerid]");
						return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if (ProxDetectorS(8.0, playerid, giveplayerid))
							{
              					format(string, sizeof(string), "[INFO:] %s's flying license successfully revoked.", GetPlayerNameEx(giveplayerid));
						        SendClientMessage(playerid, COLOR_WHITE, string);
						        format(string, sizeof(string), "[INFO:] %s has taken away your Flying License.", GetPlayerNameEx(playerid));
						        SendClientMessage(giveplayerid, COLOR_RED, string);
						        PlayerInfo[giveplayerid][pFlyLic] = 0;
							}
							else
							{
							    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That player is not in range.");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
					    return 1;
					}
				}
				else if(strcmp(x_nr,"weaponlicense",true) == 0)
				{
				    tmp = strtok(cmdtext, idx);
					if(!strlen(tmp)) {
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /revoke weaponlicense [playerid]");
						return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if (ProxDetectorS(8.0, playerid, giveplayerid))
							{
						        format(string, sizeof(string), "[INFO:] %s's weapon license successfully revoked.", GetPlayerNameEx(giveplayerid));
						        SendClientMessage(playerid, COLOR_WHITE, string);
						        format(string, sizeof(string), "[INFO:] %s has revoked your Weapon License.", GetPlayerNameEx(playerid));
						        SendClientMessage(giveplayerid, COLOR_RED, string);
						        PlayerInfo[giveplayerid][pWepLic] = 0;
					        }
					        else
							{
							    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That player is not in range.");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
					    return 1;
					}
				}
				else if(strcmp(x_nr,"drugs",true) == 0)
				{
				    tmp = strtok(cmdtext, idx);
					if(!strlen(tmp)) {
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /revoke drugs [playerid]");
						return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if (ProxDetectorS(8.0, playerid, giveplayerid))
							{
							    format(string, sizeof(string), "[INFO:] %s's drugs successfully revoked.", GetPlayerNameEx(giveplayerid));
						        SendClientMessage(playerid, COLOR_WHITE, string);
						        format(string, sizeof(string), "[INFO:] %s has revoked your Drugs.", GetPlayerNameEx(playerid));
						        SendClientMessage(giveplayerid, COLOR_RED, string);
						        PlayerInfo[giveplayerid][pDrugs] = 0;
							}
					        else
							{
							    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That player is not in range.");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
					    return 1;
					}
				}
				else if(strcmp(x_nr,"materials",true) == 0)
				{
				    tmp = strtok(cmdtext, idx);
					if(!strlen(tmp)) {
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /revoke materials [playerid]");
						return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if (ProxDetectorS(8.0, playerid, giveplayerid))
							{
							    format(string, sizeof(string), "[INFO:] %s's materials successfully revoked.", GetPlayerNameEx(giveplayerid));
						        SendClientMessage(playerid, COLOR_WHITE, string);
						        format(string, sizeof(string), "[INFO:] %s has revoked your Materials.", GetPlayerNameEx(playerid));
						        SendClientMessage(giveplayerid, COLOR_RED, string);
						        PlayerInfo[giveplayerid][pMaterials] = 0;
							}
					        else
							{
							    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That player is not in range.");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
					    return 1;
					}
				}
				else if(strcmp(x_nr,"weapons",true) == 0)
				{
				    tmp = strtok(cmdtext, idx);
					if(!strlen(tmp)) {
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /revoke weapons [playerid]");
						return 1;
					}
					giveplayerid = ReturnUser(tmp);
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if (ProxDetectorS(8.0, playerid, giveplayerid))
							{
							    format(string, sizeof(string), "[INFO:] %s's weapons successfully revoked.", GetPlayerNameEx(giveplayerid));
						        SendClientMessage(playerid, COLOR_WHITE, string);
						        format(string, sizeof(string), "[INFO:] %s has revoked your Weapons.", GetPlayerNameEx(playerid));
						        SendClientMessage(giveplayerid, COLOR_RED, string);
						        ResetPlayerWeapons(giveplayerid);
							}
					        else
							{
							    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That player is not in range.");
							    return 1;
							}
					    }
					}
					else
					{
					    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
					    return 1;
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Name.");
					return 1;
				}
	        }
	        else
	        {
	            SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Faction.");
	            return 1;
	        }
	    }
	    return 1;
	}
	if(strcmp(cmd, "/tazer", true) ==0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
			    if(CopOnDuty[playerid] == 0)
			    {
			    	SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not even on duty!");
			        return 1;
			    }
			    if(IsPlayerInAnyVehicle(playerid))
			    {
			        SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can't use this whilst your in a car!");
			        return 1;
			    }
			    new suspect = GetClosestPlayer(playerid);
			    if(IsPlayerConnected(suspect))
				{
				    if(PlayerCuffed[suspect] == 1)
				    {
				        SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That person is cuffed!");
				        return 1;
				    }
				    if(GetDistanceBetweenPlayers(playerid,suspect) < 5)
					{
					    if(IsPlayerInAnyVehicle(suspect))
					    {
					        SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Get the suspect out of the vehicle!");
					        return 1;
					    }
						format(string, sizeof(string), "[INFO:] Tazed by %s for 7 seconds.", GetPlayerNameEx(playerid));
						SendClientMessage(suspect, COLOR_RED, string);
						format(string, sizeof(string), "[INFO:] You tazed %s 7 seconds.", GetPlayerNameEx(suspect));
						SendClientMessage(playerid, COLOR_WHITE, string);
						TogglePlayerControllable(suspect, 0);
						PlayerTazed[suspect] = 1;
						SetTimerEx("UntazePlayer", 7000, false, "i", suspect);
						PlayerPlayerActionMessage(playerid,suspect,15.0,"has just tazed");
		            }
					else
					{
					    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] No one in range.");
					    return 1;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid faction.");
			}
		}//not connected
	    return 1;
	}
	if(strcmp(cmd, "/ticket", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
		        if(CopOnDuty[playerid] == 0)
				{
				    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not even on duty!");
				    return 1;
				}
		    	tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /ticket [playerid] [cost] [reason]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
	            tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /ticket [playerid] [cost] [reason]");
					return 1;
				}
				new moneys;
				moneys = strval(tmp);
				if(moneys < 1 || moneys > 99999) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid amount."); return 1; }
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
				        if (ProxDetectorS(8.0, playerid, giveplayerid))
						{
							new length = strlen(cmdtext);
							while ((idx < length) && (cmdtext[idx] <= ' '))
							{
								idx++;
							}
							new offset = idx;
							new result[128];
							while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
							{
								result[idx - offset] = cmdtext[idx];
								idx++;
							}
							result[idx - offset] = EOS;
							if(!strlen(result))
							{
								SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /ticket [playerid] [cost] [reason]");
								return 1;
							}
							format(string, sizeof(string), "[INFO:] You have gave %s a ticket for $%d - Reason: %s.", GetPlayerNameEx(giveplayerid), moneys, (result));
							SendClientMessage(playerid, COLOR_WHITE, string);
							format(string, sizeof(string), "[INFO:] %s has gave you a ticket for $%d - Reason: %s.", GetPlayerNameEx(playerid), moneys, (result));
							SendClientMessage(giveplayerid, COLOR_RED, string);
							SendClientMessage(giveplayerid, COLOR_LIGHTYELLOW2, "[INFO:] Type /accept ticket, to pay it.");
							TicketOffer[giveplayerid] = playerid;
							TicketMoney[giveplayerid] = moneys;
							return 1;
						}
						else
						{
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not close enough!");
							return 1;
						}
					}
				}
				else
				{
				    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
				    return 1;
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Faction.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/government", true) == 0 || strcmp(cmd, "/gov", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
				if(PlayerInfo[playerid][pRank] != 1)
				{
				    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Only the leader can use this.");
				    return 1;
				}
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[64];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] [/gov]ernment [text]");
					return 1;
				}
				if(CopOnDuty[playerid])
				{
					new faction = PlayerInfo[playerid][pFaction];
					SendClientMessageToAll(COLOR_LIGHTGREEN, "-----------------[GOVERNMENT]-----------------");
					format(string, sizeof(string), "%s %s: %s", DynamicFactions[faction][fRank1],GetPlayerNameEx(playerid), result);
					SendClientMessageToAll(COLOR_LSPD, string);
					SendClientMessageToAll(COLOR_LIGHTGREEN, "-------------------------------------------------------");
				}
				else
				{
				    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not even on duty!");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Faction.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/free", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		    if(PlayerInfo[playerid][pJob] != 4)
		    {
		        SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not a lawyer!");
		        return 1;
		    }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /free [playerid]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
            if(IsPlayerConnected(giveplayerid))
            {
                if(giveplayerid != INVALID_PLAYER_ID)
                {
                    if(giveplayerid == playerid) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can't free yourself."); return 1; }
					if(PlayerInfo[giveplayerid][pJailed] == 1)
					{
							if(GetDistanceBetweenPlayers(playerid,giveplayerid) < 5)
							{
								new jailtime = PlayerInfo[giveplayerid][pJailTime] / 60;
			    				if(jailtime < 7)
								{
									PlayerInfo[giveplayerid][pJailed] = 0;
									format(string, sizeof(string), "[INFO:] You have been freed by %s.", GetPlayerNameEx(playerid));
									SendClientMessage(giveplayerid,COLOR_LIGHTYELLOW2, string);
									format(string, sizeof(string), "[INFO:] You have freed %s.", GetPlayerNameEx(giveplayerid));
									SendClientMessage(playerid,COLOR_LIGHTYELLOW2, string);
									SetPlayerVirtualWorld(giveplayerid,2);
								    SetPlayerInterior(giveplayerid, 6);
									SetPlayerPos(giveplayerid,268.0903,77.6489,1001.0391);
								}
								else
								{
									SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Players jail time must be 7 minutes or below.");
								}
							}
							else
							{
								SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not near that player.");
							}
					}
					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That player is not jailed.");
					}
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/arrest", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
				if(CopOnDuty[playerid] == 0)
				{
				    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You arn't even on duty!");
				    return 1;
				}
		        if(!PlayerToPoint(15.0, playerid, PoliceArrestPosition[X],PoliceArrestPosition[Y],PoliceArrestPosition[Z]) || GetPlayerVirtualWorld(playerid) != PoliceArrestPosition[World])
				{// Jail spot
				    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You must be at arrest location!");
				    return 1;
				}
				tmp = strtok(cmdtext, idx);
				new time = strval(tmp);
				if(time < 1 || time > 15) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INFO:] Jail time cannot be above 15 minutes!"); return 1; }
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /arrest [time]");
					return 1;
				}
				new suspect = GetClosestPlayer(playerid);
				if(IsPlayerConnected(suspect))
				{
					if(GetDistanceBetweenPlayers(playerid,suspect) < 5)
					{
						if(WantedLevel[suspect] < 1)
						{
						    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That player isn't even wanted!");
						    return 1;
						}
						format(string, sizeof(string), "[INFO:] %s successfully arrested.", GetPlayerNameEx(suspect));
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						ResetPlayerWeapons(suspect);
					    SetPlayerVirtualWorld(suspect,2); //BUILDING ID 2, MAKE SURE PD IS ID 2
					    SetPlayerInterior(suspect, 6);
						SetPlayerPos(suspect,264.5743,77.5118,1001.0391);
						PlayerInfo[suspect][pJailTime] = time * 60;
						format(string, sizeof(string), "[INFO:] Arrested! - Jail Time: %d seconds.", PlayerInfo[suspect][pJailTime]);
						SendClientMessage(suspect, COLOR_LIGHTYELLOW2, string);
						format(string, sizeof(string), "[LSPD:] %s has arrested criminal %s.",GetPlayerNameEx(playerid), GetPlayerNameEx(suspect));
		    			SendFactionTypeMessage(1, COLOR_LSPD, string);
						PlayerInfo[suspect][pJailed] = 1;
						WantedPoints[suspect] = 0;
						ResetPlayerWantedLevelEx(suspect);
						new faction = PlayerInfo[playerid][pFaction];
						DynamicFactions[faction][fBank] += PlayerInfo[suspect][pJailTime];
						SaveDynamicFactions();
					}//distance
				}//not connected
				else
				{
				    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not near a criminal!");
				    return 1;
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Faction.");
			    return 1;
			}
		}//not connected
		return 1;
	}
	if(strcmp(cmd, "/megaphone", true) == 0 || strcmp(cmd, "/m", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new tmpcar = GetPlayerVehicleID(playerid) - 1;
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "USAGE: [/m]egaphone [message]");
				return 1;
			}
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
			    if(!IsPlayerInAnyVehicle(playerid))
			    {
			    	SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not in a car.");
					return 1;
			    }
		    	if(!CopOnDuty[playerid])
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not even on cop duty!");
					return 1;
				}
				if(DynamicCars[tmpcar][FactionCar] != PlayerInfo[playerid][pFaction])
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not in a faction vehicle.");
					return 1;
				}
				new rank = PlayerInfo[playerid][pRank];
				if(rank == 1)
				{
					format(string, sizeof(string), "[MEGAPHONE:] %s %s: %s!!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank1],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
				else if(rank == 2)
				{
					format(string, sizeof(string), "[MEGAPHONE:] %s %s: %s!!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank2],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
				else if(rank == 3)
				{
					format(string, sizeof(string), "[MEGAPHONE:] %s %s: %s!!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank3],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
    			else if(rank == 4)
				{
					format(string, sizeof(string), "[MEGAPHONE:] %s %s: %s!!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank4],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
				else if(rank == 5)
				{
					format(string, sizeof(string), "[MEGAPHONE:] %s %s: %s!!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank5],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
    			else if(rank == 6)
				{
					format(string, sizeof(string), "[MEGAPHONE:] %s %s: %s!!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank6],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
    			else if(rank == 7)
				{
					format(string, sizeof(string), "[MEGAPHONE:] %s %s: %s!!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank7],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
    			else if(rank == 8)
				{
					format(string, sizeof(string), "[MEGAPHONE:] %s %s: %s!!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank8],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
    			else if(rank == 9)
				{
					format(string, sizeof(string), "[MEGAPHONE:] %s %s: %s!!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank9],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
    			else if(rank == 10)
				{
					format(string, sizeof(string), "[MEGAPHONE:] %s %s: %s!!", DynamicFactions[PlayerInfo[playerid][pFaction]][fRank10],GetPlayerNameEx(playerid), result);
					ProxDetector(60.0, playerid, string,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD,COLOR_LSPD);
					return 1;
				}
				return 1;
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Faction.");
				return 1;
			}
		}
		return 1;
	}
	//=================================================[FACTION SYSTEM COMMANDS]================================================
 	if(strcmp(cmd, "/radio", true) == 0 || strcmp(cmd, "/r", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new wstring[128];
			new faction = PlayerInfo[playerid][pFaction];
			new rank = PlayerInfo[playerid][pRank];
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] (/r)adio");
				return 1;
			}
			if(Muted[playerid])
			{
				SendClientMessage(playerid, COLOR_RED, "[ERROR:] You can't use the radio, your muted.");
				return 1;
			}
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
					if(CopOnDuty[playerid])
					{
				 		if(rank == 1)
						{
						    format(wstring, sizeof(wstring), "[RADIO:] %s %s: %s, over.",DynamicFactions[faction][fRank1],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						    PhoneAnimation(playerid);
						}
				 		else if(rank == 2)
						{
						    format(wstring, sizeof(wstring), "[RADIO:] %s %s: %s, over.",DynamicFactions[faction][fRank2],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						    PhoneAnimation(playerid);
						}
				 		else if(rank == 3)
						{
						    format(wstring, sizeof(wstring), "[RADIO:] %s %s: %s, over.",DynamicFactions[faction][fRank3],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						    PhoneAnimation(playerid);
						}
				 		else if(rank == 4)
						{
							format(wstring, sizeof(wstring), "[RADIO:] %s %s: %s, over.",DynamicFactions[faction][fRank4],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						    PhoneAnimation(playerid);
						}
				 		else if(rank == 5)
						{
						    format(wstring, sizeof(wstring), "[RADIO:] %s %s: %s, over.",DynamicFactions[faction][fRank5],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						    PhoneAnimation(playerid);
						}
				 		else if(rank == 6)
						{
						    format(wstring, sizeof(wstring), "[RADIO:] %s %s: %s, over.",DynamicFactions[faction][fRank6],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						    PhoneAnimation(playerid);
						}
				 		else if(rank == 7)
						{
						    format(wstring, sizeof(wstring), "[RADIO:] %s %s: %s, over.",DynamicFactions[faction][fRank7],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						    PhoneAnimation(playerid);
						}
				 		else if(rank == 8)
						{
						    format(wstring, sizeof(wstring), "[RADIO:] %s %s: %s, over.",DynamicFactions[faction][fRank8],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						    PhoneAnimation(playerid);
						}
				 		else if(rank == 9)
						{
						    format(wstring, sizeof(wstring), "[RADIO:] %s %s: %s, over.",DynamicFactions[faction][fRank9],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						    PhoneAnimation(playerid);
						}
				 		else if(rank == 10)
						{
						    format(wstring, sizeof(wstring), "[RADIO:] %s %s: %s, over.",DynamicFactions[faction][fRank10],GetPlayerNameEx(playerid),result);
						    SendFactionTypeMessage(1, COLOR_LSPD, wstring);
						    FactionChatLog(wstring);
						    PhoneAnimation(playerid);
						}
					}
		     		else
					{
						SendClientMessage(playerid,COLOR_LIGHTYELLOW2, "[ERROR:] Your not even on duty!");
     				}
			}
			else
			{
				SendClientMessage(playerid,COLOR_LIGHTYELLOW2, "[ERROR:] You are not a member of the required faction/type.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/faction", true) == 0 || strcmp(cmd, "/f", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new wstring[128];
			new faction = PlayerInfo[playerid][pFaction];
			new rank = PlayerInfo[playerid][pRank];
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] (/f)action");
				return 1;
			}
			if(Muted[playerid])
			{
				SendClientMessage(playerid, COLOR_RED, "[ERROR:] You can't use faction chat, your muted.");
				return 1;
			}
			if(PlayerInfo[playerid][pFaction] != 255)
			{
			 		if(rank == 1)
					{
					    format(wstring, sizeof(wstring), "(( [F-OOC:] %s %s: %s ))",DynamicFactions[faction][fRank1],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, wstring);
					    FactionChatLog(wstring);
					    PhoneAnimation(playerid);
					}
			 		else if(rank == 2)
					{
					    format(wstring, sizeof(wstring), "(( [F-OOC:] %s %s: %s ))",DynamicFactions[faction][fRank2],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, wstring);
					    FactionChatLog(wstring);
					    PhoneAnimation(playerid);
					}
			 		else if(rank == 3)
					{
					    format(wstring, sizeof(wstring), "(( [F-OOC:] %s %s: %s ))",DynamicFactions[faction][fRank3],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, wstring);
					    FactionChatLog(wstring);
					    PhoneAnimation(playerid);
					}
			 		else if(rank == 4)
					{
					    format(wstring, sizeof(wstring), "(( [F-OOC:] %s %s: %s ))",DynamicFactions[faction][fRank4],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, wstring);
					    FactionChatLog(wstring);
					    PhoneAnimation(playerid);
					}
			 		else if(rank == 5)
					{
					    format(wstring, sizeof(wstring), "(( [F-OOC:] %s %s: %s ))",DynamicFactions[faction][fRank5],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, wstring);
					    FactionChatLog(wstring);
					    PhoneAnimation(playerid);
					}
			 		else if(rank == 6)
					{
					    format(wstring, sizeof(wstring), "(( [F-OOC:] %s %s: %s ))",DynamicFactions[faction][fRank6],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, wstring);
					    FactionChatLog(wstring);
					    PhoneAnimation(playerid);
					}
			 		else if(rank == 7)
					{
					    format(wstring, sizeof(wstring), "(( [F-OOC:] %s %s: %s ))",DynamicFactions[faction][fRank7],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, wstring);
					    FactionChatLog(wstring);
					    PhoneAnimation(playerid);
					}
			 		else if(rank == 8)
					{
					    format(wstring, sizeof(wstring), "(( [F-OOC:] %s %s: %s ))",DynamicFactions[faction][fRank8],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, wstring);
					    FactionChatLog(wstring);
					    PhoneAnimation(playerid);
					}
			 		else if(rank == 9)
					{
					    format(wstring, sizeof(wstring), "(( [F-OOC:] %s %s: %s ))",DynamicFactions[faction][fRank9],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, wstring);
					    FactionChatLog(wstring);
					    PhoneAnimation(playerid);
					}
			 		else if(rank == 10)
					{
					    format(wstring, sizeof(wstring), "(( [F-OOC:] %s %s: %s ))",DynamicFactions[faction][fRank10],GetPlayerNameEx(playerid),result);
					    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, wstring);
					    FactionChatLog(wstring);
                        PhoneAnimation(playerid);
					}
			}
			else
			{
				SendClientMessage(playerid,COLOR_LIGHTYELLOW2, "[ERROR:] You are not a member of a faction!");
			}
		}
		return 1;
	}
    if(strcmp(cmd, "/invite", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /invite [playerid/partofname]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pRank] == 1 && PlayerInfo[playerid][pFaction] != 255)
			{
			    if(PlayerInfo[giveplayerid][pFaction] == 255)
			    {
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        new form[128];
					        new faction = PlayerInfo[playerid][pFaction];
							if(gPlayerLogged[giveplayerid])
							{
						        if(DynamicFactions[faction][fJoinRank] == 0)
						        {
						            SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] Please set your factions joinrank/rankamount before inviting people!");
						        }
						        else
						        {
									FactionRequest[giveplayerid] = faction;
									format(form,sizeof(form),"You have been invited to %s by %s. (Type /accept faction - to join.) ",DynamicFactions[faction][fName],GetPlayerNameEx(playerid));
									SendClientMessage(giveplayerid,COLOR_LIGHTBLUE,form);
									format(form,sizeof(form),"You have invited %s to join %s. ",GetPlayerNameEx(giveplayerid),DynamicFactions[faction][fName]);
									SendClientMessage(playerid,COLOR_LIGHTBLUE,form);
								}
								return 1;
							}
							else
							{
							    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] That person is not logged in!");
							}
						}
					}
		 			else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
					}
				}
 				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] The person you tried to invite is already in a faction.");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not a leader!");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/uninvite", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /uninvite [playerid/partofname]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pRank] == 1 && PlayerInfo[playerid][pFaction] != 255)
			{
			    if(PlayerInfo[giveplayerid][pFaction] == PlayerInfo[playerid][pFaction])
				{
					if(IsPlayerConnected(giveplayerid))
					{
     					if(gPlayerLogged[giveplayerid])
     					{
						    if(giveplayerid != INVALID_PLAYER_ID)
						    {
						        new form[128];
						        new faction = PlayerInfo[playerid][pFaction];
								format(form,sizeof(form),"You have been uninvited from %s by %s.",DynamicFactions[faction][fName],GetPlayerNameEx(playerid));
								SendClientMessage(giveplayerid,COLOR_LIGHTBLUE,form);
								format(form,sizeof(form),"You have uninvited %s from %s.",GetPlayerNameEx(giveplayerid),DynamicFactions[faction][fName]);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,form);
								PlayerInfo[giveplayerid][pFaction] = 255;
								PlayerInfo[giveplayerid][pRank] = 0;
								SetPlayerSpawn(giveplayerid);
								format(form, sizeof(form), "[FACTION:] %s has been uninvited from the faction by %s.",GetPlayerNameEx(giveplayerid),GetPlayerNameEx(playerid));
								SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, form);
								return 1;
							}
						}
	      				else
						{
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That players not logged in.");
						}
					}
		 			else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
					}
				}
 				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You tried to uninvite someone who's not in your faction.");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not a leader!");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/setrank", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /setrank [playerid/partofname] [newrank]");
				return 1;
			}
			new para1;
			new level;
			para1 = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			level = strval(tmp);
			if (PlayerInfo[playerid][pRank] == 1 && PlayerInfo[playerid][pFaction] != 255)
			{
				if (PlayerInfo[para1][pFaction] == PlayerInfo[playerid][pFaction])
				{
					new faction = PlayerInfo[playerid][pFaction];
					if (level)
					{
		   				if(level > 1 && level <= DynamicFactions[faction][fRankAmount])
					    {
		  					if(IsPlayerConnected(para1))
			    			{
								if(gPlayerLogged[para1])
								{
									if(para1 != INVALID_PLAYER_ID)
									{
										PlayerInfo[para1][pRank] = level;
										format(string, sizeof(string), "[INFO:] You rank has been changed by: %s, you are now rank: %d.", GetPlayerNameEx(playerid),level);
										SendClientMessage(para1, COLOR_LIGHTBLUE, string);
										format(string, sizeof(string), "[INFO:] You have changed %s's rank to: %d.", GetPlayerNameEx(para1),level);
										SendClientMessage(playerid, COLOR_YELLOW, string);
										SetPlayerToFactionSkin(para1);

										if(PlayerInfo[para1][pSex] == 1)
										{
											format(string, sizeof(string), "[FACTION:] %s's rank has been changed, he is now rank: %d.",GetPlayerNameEx(para1), level);
											SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, string);
										}
										else
										{
											format(string, sizeof(string), "[FACTION:] %s's rank has been changed, she is now rank: %d.",GetPlayerNameEx(para1), level);
											SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, string);
										}
									}
								}
								else
								{
									SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That players not logged in!");
								}
							}
							else
							{
								SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID/Player Not Connected.");
							}
						}
						else
						{
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Rank must be below or equal to the factions rank amount.");
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You must enter an amount!");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] The person who's rank you tried to edit is not a member of your faction.");
				}
			}
			else
   			{

				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not a leader.");
			}
		}
		return 1;
	}
	//==========================================================================================================================
    if(strcmp(cmd, "/kick", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /kick [playerid/partofname] [reason]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						new length = strlen(cmdtext);
						while ((idx < length) && (cmdtext[idx] <= ' '))
						{
							idx++;
						}
						new offset = idx;
						new result[128];
						while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
						{
							result[idx - offset] = cmdtext[idx];
							idx++;
						}
						result[idx - offset] = EOS;
						if(!strlen(result))
						{
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /kick [playerid/partofname] [reason]");
							return 1;
						}
						KickPlayer(giveplayerid,GetPlayerNameEx(playerid),(result));
						return 1;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
			}
		}
		return 1;
	}
	if(strcmp(cmdtext,"/aserverinfo",true)==0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			new form[128];
			SendClientMessage(playerid, COLOR_WHITE,"Server Statistics:");
			format(form, sizeof form, "[INFO:] Total Objects: %d.", GetObjectCount());
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2,form);
			format(form, sizeof form, "[INFO:] Total Vehicles: %d.", GetVehicleCount());
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2,form);
			format(form, sizeof form, "[INFO:] Total Pickups: %d.", CountStreamPickups());
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2,form);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED,"Your not an administrator or an administrator with the required level.");
		}
		return 1;
	}
 	if(strcmp(cmdtext,"/asuicide",true)==0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
		SetPlayerHealth(playerid,-1);
		}
		else
		{
		SendClientMessage(playerid, COLOR_RED,"Your not an administrator or an administrator with the required level.");
		}
		return 1;
	}
	if(strcmp(cmd, "/alistfaction", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /alistfaction [id]");
				return 1;
			}
			new text = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 3)
			{
			 	new wstring[128];
			    format(wstring, sizeof(wstring), "[ID:%d] Faction Name: %s - Materials: %d - Drugs: %d - Money: $%d - Join Rank: %d - Use Skins: %d - Type: %d",text, DynamicFactions[text][fName],DynamicFactions[text][fMaterials],DynamicFactions[text][fDrugs],DynamicFactions[text][fBank],DynamicFactions[text][fJoinRank],DynamicFactions[text][fUseSkins],DynamicFactions[text][fType]);
			    SendClientMessage(playerid,COLOR_ADMINCMD, wstring);
			    format(wstring, sizeof(wstring), "[ID:%d] Skins: %d|%d|%d|%d|%d|%d|%d|%d|%d|%d - Rank Amount: %d - Use Color: %d", text,DynamicFactions[text][fSkin1],DynamicFactions[text][fSkin2],DynamicFactions[text][fSkin3],DynamicFactions[text][fSkin4],DynamicFactions[text][fSkin5],DynamicFactions[text][fSkin6],DynamicFactions[text][fSkin7],DynamicFactions[text][fSkin8],DynamicFactions[text][fSkin9],DynamicFactions[text][fSkin10],DynamicFactions[text][fRankAmount],DynamicFactions[text][fUseColor]);
			    SendClientMessage(playerid,COLOR_ADMINCMD, wstring);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED,"Your not an administrator or an administrator with the required level.");
			}
		}
		return 1;
	}
	//---------------------------------------------------[DYNAMIC CAR SYSTEM]------------------------------------------------
	/*
  	if(strcmp(cmd, "/resetallbusinesses", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] < 1338)
			return SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
		new	i, pmodel,
			Float:distance = 1.5,
			Float:metres = distance;
		for(; i < sizeof(Businesses); i++, metres += distance)
		{
		    new Float:a;
			GetPlayerPos(playerid, Businesses[i][EnterX], Businesses[i][EnterY], Businesses[i][EnterZ]);
			GetPlayerFacingAngle(playerid, a);
			Businesses[i][EnterX] += (metres * floatsin(-a, degrees));
			Businesses[i][EnterY] += (metres * floatcos(-a, degrees));
			Businesses[i][EnterWorld] = 0;
			Businesses[i][EnterInterior] = 0;
			Businesses[i][EnterAngle] = a;
			Businesses[i][ExitX] = 0.0;
			Businesses[i][ExitY] = 0.0;
			Businesses[i][ExitZ] = 0.0;
			Businesses[i][ExitInterior] = 0;
			Businesses[i][ExitAngle] = 0.0;
			Businesses[i][Owned] = 0;
			Businesses[i][Enterable] = 0;
			Businesses[i][BizPrice] = 0;
			Businesses[i][Till] = 0;
			Businesses[i][Locked] = 1;
			Businesses[i][BizType] = 0;
			Businesses[i][Products] = 0;
			strmid(Businesses[i][BusinessName], "None", 0, strlen("None"), 255);
			strmid(Businesses[i][Owner], "None", 0, strlen("None"), 255);
			Businesses[i][EnterInterior] = 0;
			switch(Businesses[i][Owned])
			{
				case 0: pmodel = 1272;
				case 1: pmodel = 1239;
			}
			ChangeStreamPickupModel(Businesses[i][PickupID],pmodel);
		}
		SaveBusinesses();
		return 1;
	}
  	if(strcmp(cmd, "/resetallbuildings", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] < 1338)
			return SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
		new	i,
			Float:distance = 1.5,
			Float:metres = distance;
		for(; i < sizeof(Building); i++, metres += distance)
		{
		    new Float:a;
			GetPlayerPos(playerid, Building[i][EnterX], Building[i][EnterY], Building[i][EnterZ]);
			GetPlayerFacingAngle(playerid, a);
			strmid(Building[i][BuildingName], "None", 0, strlen("None"), 255);
			Building[i][EnterX] += (metres * floatsin(-a, degrees));
			Building[i][EnterY] += (metres * floatcos(-a, degrees));
			Building[i][EnterAngle] = a;
			Building[i][EnterWorld] = 0;
			Building[i][EnterInterior] = 0;
			Building[i][EntranceFee] = 0;
			Building[i][ExitX] = 0.0;
			Building[i][ExitY] = 0.0;
			Building[i][ExitZ] = 0.0;
			Building[i][ExitInterior] = 0;
			Building[i][ExitAngle] = 0.0;
			Building[i][Locked] = 1;
			ChangeStreamPickupModel(Building[i][PickupID],1239);
		}
		SaveBuildings();
		return 1;
	}
 	if(strcmp(cmd, "/resetallhouses", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] < 1338)
			return SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
		new	i, pmodel,
			Float:distance = 1.5,
			Float:metres = distance;
		for(; i < sizeof(Houses); i++, metres += distance)
		{
		    new Float:a;
			GetPlayerPos(playerid, Houses[i][EnterX], Houses[i][EnterY], Houses[i][EnterZ]);
			GetPlayerFacingAngle(playerid, a);
			Houses[i][EnterX] += (metres * floatsin(-a, degrees));
			Houses[i][EnterY] += (metres * floatcos(-a, degrees));
			Houses[i][EnterWorld] = 0;
			Houses[i][EnterInterior] = 0;
			Houses[i][EnterAngle] = a;
			Houses[i][ExitX] = 0.0;
			Houses[i][ExitY] = 0.0;
			Houses[i][ExitZ] = 0.0;
			Houses[i][ExitInterior] = 0;
			Houses[i][ExitAngle] = 0.0;
			Houses[i][Owned] = 0;
			Houses[i][Rentable] = 0;
			Houses[i][RentCost] = 0;
			Houses[i][HousePrice] = 0;
			Houses[i][Materials] = 0;
			Houses[i][Drugs] = 0;
			Houses[i][Money] = 0;
			Houses[i][Locked] = 1;
			
			strmid(Houses[i][Description], "None", 0, strlen("None"), 255);
			strmid(Houses[i][Owner], "None", 0, strlen("None"), 255);
			switch(Houses[i][Owned])
			{
				case 0: pmodel = 1273;
				case 1: pmodel = 1239;
			}
			ChangeStreamPickupModel(Houses[i][PickupID],pmodel);
		}
		SaveHouses();
		return 1;
	}
  	if(strcmp(cmd, "/resetallvehicles", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] < 1338)
			return SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
		new	i,
			Float:distance = 6.0,
			Float:metres = distance;
		for(; i < sizeof(DynamicCars); i++, metres += distance)
		{
			GetPlayerPos(playerid, DynamicCars[i][CarX], DynamicCars[i][CarY], DynamicCars[i][CarZ]);
			new Float:a;
			GetPlayerFacingAngle(playerid, a);
			DynamicCars[i][CarColor1] = -1;
			DynamicCars[i][CarColor2] = -1;
			DynamicCars[i][FactionCar] = 255;
			DynamicCars[i][CarType] = 0;
			DynamicCars[i][CarAngle] = a;
			DynamicCars[i][CarModel] = 400; //Jeep
			DynamicCars[i][CarX] += (metres * floatsin(-a, degrees));
			DynamicCars[i][CarY] += (metres * floatcos(-a, degrees));
			DestroyVehicle(i);
			CreateVehicle(DynamicCars[i][CarModel],DynamicCars[i][CarX],DynamicCars[i][CarY],DynamicCars[i][CarZ],DynamicCars[i][CarAngle],DynamicCars[i][CarColor1],DynamicCars[i][CarColor2], -1);
			Fuel[i] = GasMax;
			EngineStatus[i] = 0;
			VehicleLocked[i] = 0;
			CarWindowStatus[i] = 1; //1 = up, 0 = down.
		}
		SaveDynamicCars();
		return 1;
	}
 	if(strcmp(cmd, "/masscarmodelrandom", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] < 1338)
			return SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			new i;
		for(; i < sizeof(DynamicCars); i++)
		{
		    new rand = random(sizeof(RandomStableModels));
			DynamicCars[i][CarModel] = RandomStableModels[rand][0];
			DestroyVehicle(i);
			CreateVehicle(DynamicCars[i][CarModel],DynamicCars[i][CarX],DynamicCars[i][CarY],DynamicCars[i][CarZ],DynamicCars[i][CarAngle],DynamicCars[i][CarColor1],DynamicCars[i][CarColor2], -1);
			Fuel[i] = GasMax;
			EngineStatus[i] = 0;
			VehicleLocked[i] = 0;
			CarWindowStatus[i] = 1; //1 = up, 0 = down.
		}
		SaveDynamicCars();
		return 1;
	}
	if(strcmp(cmd, "/masscarmove", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] < 1338)
			return SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
		new	i,
			Float:distance = 6.0,
			Float:metres = distance;
		for(; i < sizeof(DynamicCars); i++, metres += distance)
		{
			GetPlayerPos(playerid, DynamicCars[i][CarX], DynamicCars[i][CarY], DynamicCars[i][CarZ]);
			GetPlayerFacingAngle(playerid, DynamicCars[i][CarAngle]);
			DynamicCars[i][CarX] += (metres * floatsin(-DynamicCars[i][CarAngle], degrees));
			DynamicCars[i][CarY] += (metres * floatcos(-DynamicCars[i][CarAngle], degrees));
			DestroyVehicle(i);
			CreateVehicle(DynamicCars[i][CarModel],DynamicCars[i][CarX],DynamicCars[i][CarY],DynamicCars[i][CarZ],DynamicCars[i][CarAngle],DynamicCars[i][CarColor1],DynamicCars[i][CarColor2], -1);
			Fuel[i] = GasMax;
			EngineStatus[i] = 0;
			VehicleLocked[i] = 0;
			CarWindowStatus[i] = 1; //1 = up, 0 = down.
		}
		SaveDynamicCars();
		return 1;
	}
	if(strcmp(cmd, "/masshousemove", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] < 1338)
			return SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
		new	i, pmodel,
			Float:distance = 1.5,
			Float:metres = distance;
		for(; i < sizeof(Houses); i++, metres += distance)
		{
		    new Float:a;
			GetPlayerPos(playerid, Houses[i][EnterX], Houses[i][EnterY], Houses[i][EnterZ]);
			GetPlayerFacingAngle(playerid, a);
			Houses[i][EnterX] += (metres * floatsin(-a, degrees));
			Houses[i][EnterY] += (metres * floatcos(-a, degrees));
			Houses[i][EnterWorld] = GetPlayerVirtualWorld(playerid);
			Houses[i][EnterInterior] = GetPlayerInterior(playerid);
			switch(Houses[i][Owned])
			{
				case 0: pmodel = 1273;
				case 1: pmodel = 1239;
			}
			ChangeStreamPickupModel(Houses[i][PickupID],pmodel);
		}
		SaveHouses();
		return 1;
	}
 	if(strcmp(cmd, "/massbuildingmove", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] < 1338)
			return SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
		new	i,
			Float:distance = 1.5,
			Float:metres = distance;
		for(; i < sizeof(Building); i++, metres += distance)
		{
		    new Float:a;
			GetPlayerPos(playerid, Building[i][EnterX], Building[i][EnterY], Building[i][EnterZ]);
			GetPlayerFacingAngle(playerid, a);
			Building[i][EnterX] += (metres * floatsin(-a, degrees));
			Building[i][EnterY] += (metres * floatcos(-a, degrees));
			Building[i][EnterWorld] = GetPlayerVirtualWorld(playerid);
			Building[i][EnterInterior] = GetPlayerInterior(playerid);
			ChangeStreamPickupModel(Building[i][PickupID],1239);
		}
		SaveBuildings();
		return 1;
	}
 	if(strcmp(cmd, "/massbusinessmove", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] < 1338)
			return SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
		new	i, pmodel,
			Float:distance = 1.5,
			Float:metres = distance;
		for(; i < sizeof(Businesses); i++, metres += distance)
		{
		    new Float:a;
			GetPlayerPos(playerid, Businesses[i][EnterX], Businesses[i][EnterY], Businesses[i][EnterZ]);
			GetPlayerFacingAngle(playerid, a);
			Businesses[i][EnterX] += (metres * floatsin(-a, degrees));
			Businesses[i][EnterY] += (metres * floatcos(-a, degrees));
			Businesses[i][EnterWorld] = GetPlayerVirtualWorld(playerid);
			Businesses[i][EnterInterior] = GetPlayerInterior(playerid);
			switch(Businesses[i][Owned])
			{
				case 0: pmodel = 1272;
				case 1: pmodel = 1239;
			}
			ChangeStreamPickupModel(Businesses[i][PickupID],pmodel);
		}
		SaveBusinesses();
		return 1;
	}*/
	if(strcmp(cmd, "/acarsetpos", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /acarsetpos [carid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 5)
			{
			    if(id != INVALID_VEHICLE_ID)
			    {
					new Float:x,Float:y,Float:z;
					new Float:a;
					GetPlayerPos(playerid, x, y, z);
					if(IsPlayerInAnyVehicle(playerid))
					{
						GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
					}
					else
					{
					    GetPlayerFacingAngle(playerid, a);
					}
					DynamicCars[id-1][CarX] = x;
					DynamicCars[id-1][CarY] = y;
					DynamicCars[id-1][CarZ] = z;
					DynamicCars[id-1][CarAngle] = a;
					DestroyVehicle(id);
					CreateVehicle(DynamicCars[id-1][CarModel],DynamicCars[id-1][CarX],DynamicCars[id-1][CarY],DynamicCars[id-1][CarZ],DynamicCars[id-1][CarAngle],DynamicCars[id-1][CarColor1],DynamicCars[id-1][CarColor2], -1);
					SaveDynamicCars();
					//PutPlayerInVehicle(playerid,id,0);
				 	new wstring[128];
				    format(wstring, sizeof(wstring), "You have set Vehicle ID: %d's position.", id);
				    SendClientMessage(playerid,COLOR_ADMINCMD, wstring);
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Vehicle ID.");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/respawnvehicles", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 5)
		{
			for(new i=0;i<MAX_VEHICLES;i++)
			{
			    if(IsVehicleOccupied(i) == 0)
			    {
			        SetVehicleToRespawn(i);
			    }
			}
			format(string, sizeof(string), "[INFO:] Unoccupied vehicles respawned by %s.", GetPlayerNameEx(playerid));
   			SendClientMessageToAll(COLOR_ADMINCMD, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
		}
		return 1;
	}
	if(strcmp(cmd, "/acarenter", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /acarenter [carid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 5)
			{
			    if(id != INVALID_VEHICLE_ID)
			    {
					PutPlayerInVehicle(playerid,id,0);
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Vehicle ID.");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/acarrandmodel", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 5)
			{
			    if(IsPlayerInAnyVehicle(playerid))
			    {
				    new vehicleid = GetPlayerVehicleID(playerid);
				    new car = GetPlayerVehicleID(playerid) - 1;
					new rand = random(sizeof(RandomStableModels));
					new Float:x,Float:y,Float:z,Float:a;
					GetPlayerPos(playerid,x,y,z);
					GetVehicleZAngle(vehicleid,a);
					DynamicCars[car][CarModel] = RandomStableModels[rand][0];
					DestroyVehicle(vehicleid);
					CreateVehicle(DynamicCars[car][CarModel],x,y,z,a,DynamicCars[car][CarColor1],DynamicCars[car][CarColor2], -1);
					PutPlayerInVehicle(playerid,vehicleid,0);
					SaveDynamicCars();

				 	new wstring[128];
				    format(wstring, sizeof(wstring), "You have set Vehicle ID: %d to a random model.", vehicleid);
				    SendClientMessage(playerid,COLOR_ADMINCMD, wstring);
	    		}
    			else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not in a vehicle!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/acarpark", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 5)
			{
			    if(IsPlayerInAnyVehicle(playerid))
			    {
				    new vehicleid = GetPlayerVehicleID(playerid);
				    new car = GetPlayerVehicleID(playerid) - 1;
					new Float:x,Float:y,Float:z;
					new Float:a;
					GetVehiclePos(vehicleid, x, y, z);
					GetVehicleZAngle(vehicleid, a);
					DynamicCars[car][CarX] = x;
					DynamicCars[car][CarY] = y;
					DynamicCars[car][CarZ] = z;
					DynamicCars[car][CarAngle] = a;
					DestroyVehicle(vehicleid);
					CreateVehicle(DynamicCars[car][CarModel],DynamicCars[car][CarX],DynamicCars[car][CarY],DynamicCars[car][CarZ],DynamicCars[car][CarAngle],DynamicCars[car][CarColor1],DynamicCars[car][CarColor2], -1);
					PutPlayerInVehicle(playerid,vehicleid,0);
					SaveDynamicCars();

				 	new wstring[128];
				    format(wstring, sizeof(wstring), "You have parked Vehicle ID: %d.", vehicleid);
				    SendClientMessage(playerid,COLOR_ADMINCMD, wstring);
	    		}
    			else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not in a vehicle!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/acarfaction", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "USAGE: /acarfaction [faction]");
				return 1;
			}
			new thecar = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 5)
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
 					if(thecar < 11 || 255)
 					{
						new car = GetPlayerVehicleID(playerid) - 1;
						new vehicleid = GetPlayerVehicleID(playerid);
						DynamicCars[car][FactionCar] = thecar;
			 			new wstring[128];
					    format(wstring, sizeof(wstring), "You've set Vehicle ID %d's faction to: %d.", vehicleid,thecar);
					    SendClientMessage(playerid,COLOR_ADMINCMD, wstring);
					    SaveDynamicCars();
				    }
		   			else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Incorrect Faction ID, Correct Faction ID's: 1-10.");
					}
				}
 				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not in a vehicle!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/acartype", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "USAGE: /acartype [type]");
				return 1;
			}
			new thecar = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 5)
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					new car = GetPlayerVehicleID(playerid) - 1;
					new vehicleid = GetPlayerVehicleID(playerid);
					DynamicCars[car][CarType] = thecar;
		 			new wstring[128];
				    format(wstring, sizeof(wstring), "You've set Vehicle ID %d's type to: %d.", vehicleid,thecar);
				    SendClientMessage(playerid,COLOR_ADMINCMD, wstring);
		    		SaveDynamicCars();
				}
 				else
				{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not in a vehicle!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/acarmodel", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "USAGE: /acarmodel [modelid]");
				return 1;
			}
			new thecar = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 5)
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
 					if(thecar > 399 && thecar < 612)
 					{
					new car = GetPlayerVehicleID(playerid) - 1;
					new vehicleid = GetPlayerVehicleID(playerid);
					DynamicCars[car][CarModel] = thecar;
		 			new wstring[128];
				    format(wstring, sizeof(wstring), "You've set Vehicle ID %d's model to: %d.", vehicleid,thecar);
				    SendClientMessage(playerid,COLOR_ADMINCMD, wstring);
   					new Float:cx,Float:cy,Float:cz;
   					GetVehiclePos(vehicleid,cx,cy,cz);
   					new Float:angle;
   					GetVehicleZAngle(vehicleid, angle);
					DestroyVehicle(vehicleid);
					CreateVehicle(DynamicCars[car][CarModel],DynamicCars[car][CarX],DynamicCars[car][CarY],DynamicCars[car][CarZ],DynamicCars[car][CarAngle],DynamicCars[car][CarColor1],DynamicCars[car][CarColor2], -1);
					PutPlayerInVehicle(playerid,vehicleid,0);
					SetVehiclePos(vehicleid, cx, cy, cz);
     				SetVehicleZAngle(vehicleid, angle);
				    SaveDynamicCars();
				    }
		   			else
					{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Incorrect Model ID, Correct Model ID's: 400-611.");
					}
				}
 				else
				{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not in a vehicle!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/acarcolor", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "USAGE: /acarcolor [colorid] [colorid]");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= 5)
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					new color1;
					color1 = strval(tmp);
					if(color1 < 0 || color1 > 126) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] 0-126 = Valid Colors."); return 1; }
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "USAGE: /acarcolor [colorid] [colorid]");
						return 1;
					}
					new color2;
					color2 = strval(tmp);
					if(color2 < 0 || color2 > 126) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] 0-126 = Valid Colors."); return 1; }

					new car = GetPlayerVehicleID(playerid) - 1;
					new vehicleid = GetPlayerVehicleID(playerid);
					DynamicCars[car][CarColor1] = color1;
					DynamicCars[car][CarColor2] = color2;
					new wstring[128];
		   			format(wstring, sizeof(wstring), "You've set Vehicle ID %d's colors to: %d-%d.", vehicleid,color1,color2);
				    SendClientMessage(playerid,COLOR_ADMINCMD, wstring);
   					new Float:cx,Float:cy,Float:cz;
   					GetVehiclePos(vehicleid,cx,cy,cz);
   					new Float:angle;
   					GetVehicleZAngle(vehicleid, angle);
        			DestroyVehicle(vehicleid);
					CreateVehicle(DynamicCars[car][CarModel],DynamicCars[car][CarX],DynamicCars[car][CarY],DynamicCars[car][CarZ],DynamicCars[car][CarAngle],DynamicCars[car][CarColor1],DynamicCars[car][CarColor2], -1);
					PutPlayerInVehicle(playerid,vehicleid,0);
					SetVehiclePos(vehicleid, cx, cy, cz);
     				SetVehicleZAngle(vehicleid, angle);
				    SaveDynamicCars();
				}
 				else
				{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not in a vehicle!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
//--------------------------------------------------------------------------------------------------------------------------
//=====================================================================================================================
	if(strcmp(cmd,"/toggle",true)==0)
	{
 	if(IsPlayerConnected(playerid))
 	{
		new x_info[128];
		x_info = strtok(cmdtext, idx);

		if(!strlen(x_info)) {
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGES:] fuel - pm - phone");
			return 1;
		}
		if(strcmp(x_info,"fuel",true) == 0)
		{
			if(ShowFuel[playerid] == 1)
			{
				SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] You will no longer see fuel information.");
				ShowFuel[playerid] = 0;
			}
			else
			{
			    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] You will now see fuel information.");
			    ShowFuel[playerid] = 1;
			}
		}
  		else if(strcmp(x_info,"pm",true) == 0)
		{
		    if(PlayerInfo[playerid][pDonator] || PlayerInfo[playerid][pAdmin] >= 1)
		    {
				if(PMsEnabled[playerid])
				{
				    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] You will no longer recieve PM's.");
				    PMsEnabled[playerid] = 0;
				}
				else
				{
					SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] You will now recieve PM's.");
				    PMsEnabled[playerid] = 1;
				}
			}
		}
  		else if(strcmp(x_info,"phone",true) == 0)
		{
		    if(PlayerInfo[playerid][pDonator] || PlayerInfo[playerid][pAdmin] >= 1)
		    {
				if(PhoneOnline[playerid])
				{
				    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] You have turned your phone on.");
                    PhoneOnline[playerid] = 0;
				}
				else
				{
					SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] You have turned your phone off.");
				    PhoneOnline[playerid] = 1;
				}
			}
		}
	}
	return 1;
}
	if(strcmp(cmd,"/accept",true)==0)
	{
 	if(IsPlayerConnected(playerid))
 	{
		new x_info[128];
		x_info = strtok(cmdtext, idx);
	    new wstring[128];
	    
		if(!strlen(x_info)) {
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /accept [usage]");
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGES:] faction - ticket - products");
			return 1;
		}
		if(strcmp(x_info,"faction",true) == 0)
		{
		    new faction = FactionRequest[playerid];
			if (FactionRequest[playerid] != 255)
			{
				if(PlayerInfo[playerid][pFaction] == 255)
				{
	   				format(wstring, sizeof(wstring), "[INFO:] Congratulations! Your now a member of: %s.",DynamicFactions[faction][fName]);
				    SendClientMessage(playerid,COLOR_LIGHTBLUE, wstring);
					PlayerInfo[playerid][pFaction] = FactionRequest[playerid];
					PlayerInfo[playerid][pRank] = DynamicFactions[faction][fJoinRank];
					SetPlayerSpawn(playerid);
					FactionRequest[playerid] = 255;
					format(wstring, sizeof(wstring), "[FACTION:] %s has just joined the faction.",GetPlayerNameEx(playerid));
					SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, wstring);
				}
				else
				{
					SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] Your already in a faction, leave that first!");
				}
			}
			else
			{
			    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You have not been offered to join a faction!");
			}
		}
  		else if(strcmp(x_info,"ticket",true) == 0)
				{
			    if(TicketOffer[playerid] < 999)
			    {
			        if(IsPlayerConnected(TicketOffer[playerid]))
			        {
			            if (ProxDetectorS(5.0, playerid, TicketOffer[playerid]))
						{
							if(GetPlayerCash(playerid) >= TicketMoney[playerid])
						    {
								format(string, sizeof(string), "[INFO:] Ticket Paid - Cost: $%d.", TicketMoney[playerid]);
								SendClientMessage(playerid, COLOR_WHITE, string);
								format(string, sizeof(string), "[INFO:] %s has paid your ticket - Cost: $%d.", GetPlayerNameEx(playerid), TicketMoney[playerid]);
								SendClientMessage(TicketOffer[playerid], COLOR_LIGHTYELLOW2, string);
								new faction = PlayerInfo[TicketOffer[playerid]][pFaction];
								DynamicFactions[faction][fBank] += TicketMoney[playerid];
								GivePlayerCash(playerid, - TicketMoney[playerid]);
								TicketOffer[playerid] = 999;
								TicketMoney[playerid] = 0;
								return 1;
							}
							else
							{
							    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money!");
							    return 1;
							}
						}
						else
						{
						    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You must be near the officer that gave you the ticket!");
						    return 1;
						}
			        }
				}
				else
				{
				    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have a ticket!");
				    return 1;
				}
			}
     		else if(strcmp(x_info,"products",true) == 0)
				{
			    if(ProductsOffer[playerid] < 999)
			    {
			        if(IsPlayerConnected(ProductsOffer[playerid]))
			        {
			            if (ProxDetectorS(5.0, playerid, ProductsOffer[playerid]))
						{
						    if(GetPlayerCash(playerid) >= ProductsCost[playerid])
						    {
								if(PlayerInfo[playerid][pBizKey] != 255)
								{
									format(string, sizeof(string), "[INFO:] Products Purchased - Cost: $%d.", ProductsCost[playerid]);
									SendClientMessage(playerid, COLOR_LIGHTYELLOW2, string);
									format(string, sizeof(string), "[INFO:] %s has bought products from you - Cost: $%d.", GetPlayerNameEx(playerid), ProductsCost[playerid]);
									SendClientMessage(ProductsOffer[playerid], COLOR_LIGHTYELLOW2, string);
									new bizkey = PlayerInfo[playerid][pBizKey];
									Businesses[bizkey][Products] += ProductsAmount[playerid];
									GivePlayerCash(playerid, -ProductsCost[playerid]);
									GivePlayerCash(ProductsOffer[playerid], ProductsCost[playerid]);
									PlayerInfo[ProductsOffer[playerid]][pProducts] -= ProductsAmount[playerid];
									ProductsOffer[playerid] = 999;
									ProductsCost[playerid] = 0;
									ProductsAmount[playerid] = 0;
									SaveBusinesses();
									return 1;
								}
							}
							else
							{
							    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money!");
							    return 1;
							}
						}
						else
						{
						    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You arn't near the person that offered you products!");
						    return 1;
						}
			        }
				}
				else
				{
				    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You havn't been offered products!");
				    return 1;
				}
			}
	}
	return 1;
}
//========================================[HELP & INFORMATION COMMANDS]===================================================
 	if(strcmp(cmd, "/fwithdraw", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pFaction] != 255)
	        {
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /fwithdraw [amount]");
					return 1;
				}
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "USAGE: /fwithdraw [amount]");
					return 1;
				}
				if(PlayerToPoint(5.0,playerid,BankPosition[X],BankPosition[Y],BankPosition[Z]))
				{
				    if(PlayerInfo[playerid][pRank] == 1)
				    {
						if(DynamicFactions[PlayerInfo[playerid][pFaction]][fBank] >= cashdeposit)
						{
							GivePlayerCash(playerid,cashdeposit);
							DynamicFactions[PlayerInfo[playerid][pFaction]][fBank]=DynamicFactions[PlayerInfo[playerid][pFaction]][fBank]-cashdeposit;
							format(string, sizeof(string), "[INFO:] You have withdrawn $%d from the faction bank, new balance: $%d", cashdeposit,DynamicFactions[PlayerInfo[playerid][pFaction]][fBank]);
							SendClientMessage(playerid, COLOR_WHITE, string);
		                    PlayerActionMessage(playerid,15.0,"recieves a package full of money from the bank clerk.");
 							format(string, sizeof(string), "[FACTION:] %s has just withdrawn $%d into the faction bank.",GetPlayerNameEx(playerid),cashdeposit);
							SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, string);
		                    SaveDynamicFactions();
							return 1;
						}
	 					else
						{
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have that much in your faction bank!");
						}
					}
 					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not the leader of this faction!");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not at the bank!");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Faction.");
			}
		}
		return 1;
	}
  	if(strcmp(cmd, "/businesswithdraw", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pBizKey];
			if(bouse != 255 && strcmp(playername, Businesses[bouse][Owner], true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /businesswithdraw [amount]");
					return 1;
				}
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /businesswithdraw [amount]");
					return 1;
				}
				if (PlayerToPoint(20.0, playerid,Businesses[bouse][ExitX],Businesses[bouse][ExitY],Businesses[bouse][ExitZ]))
				{
				    if(Businesses[bouse][Till] >= cashdeposit)
				    {
					    if(GetPlayerVirtualWorld(playerid) == bouse)
					    {
							GivePlayerCash(playerid,cashdeposit);
							Businesses[bouse][Till]=Businesses[bouse][Till]-cashdeposit;
							format(string, sizeof(string), "[INFO:] You have withdrawn $%d from your business till, New Total: $%d ", cashdeposit,Businesses[bouse][Till]);
							SendClientMessage(playerid, COLOR_WHITE, string);
	                    	PlayerActionMessage(playerid,15.0,"opens the till and takes out some money.");
							SaveBusinesses();
							return 1;
						}
					}
 					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have that much in your till!");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not in your business!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't even own a business!");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/businessdeposit", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	new bizkey = PlayerInfo[playerid][pBizKey];
	    	new playername[MAX_PLAYER_NAME];
	    	GetPlayerName(playerid,playername,sizeof(playername));
	        if(bizkey != 255 && strcmp(playername, Businesses[bizkey][Owner], true) == 0)
	        {
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /businessdeposit [amount]");
					return 1;
				}
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "USAGE: /businessdeposit [amount]");
					return 1;
				}
				if(PlayerToPoint(5.0,playerid,Businesses[bizkey][ExitX],Businesses[bizkey][ExitY],Businesses[bizkey][ExitZ]))
				{
						if(GetPlayerCash(playerid) >= cashdeposit)
						{
					        if(Businesses[bizkey][Till] < 500000)
					        {
					            if(cashdeposit < 500001)
					            {
									GivePlayerCash(playerid,-cashdeposit);
									Businesses[bizkey][Till]=cashdeposit+Businesses[bizkey][Till];
									format(string, sizeof(string), "[INFO:] You have put $%d into your business till, Total: $%d", cashdeposit,Businesses[bizkey][Till]);
									SendClientMessage(playerid, COLOR_WHITE, string);
				                    PlayerActionMessage(playerid,15.0,"opens the till and puts some money in it.");
				                    SaveBusinesses();
									return 1;
								}
								else
								{
									SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You may not deposit more than $500,000.");
								}
							}
							else
							{
								SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] The amount you entered exceeds the $500,000 business limit.");
							}
						}
						else
						{
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have that amount of money!");
						}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not inside your business!");
				}
   			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't even own a business!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/fdeposit", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pFaction] != 255)
	        {
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /fdeposit [amount]");
					return 1;
				}
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "USAGE: /fdeposit [amount]");
					return 1;
				}
				if(PlayerToPoint(5.0,playerid,BankPosition[X],BankPosition[Y],BankPosition[Z]))
				{
					if(GetPlayerCash(playerid) >= cashdeposit)
					{
						GivePlayerCash(playerid,-cashdeposit);
						DynamicFactions[PlayerInfo[playerid][pFaction]][fBank]=cashdeposit+DynamicFactions[PlayerInfo[playerid][pFaction]][fBank];
						format(string, sizeof(string), "[INFO:] You have deposited $%d into the faction bank, new balance: $%d", cashdeposit,DynamicFactions[PlayerInfo[playerid][pFaction]][fBank]);
						SendClientMessage(playerid, COLOR_WHITE, string);
	                    PlayerActionMessage(playerid,15.0,"takes out some money and hands it to the bank clerk.");
						format(string, sizeof(string), "[FACTION:] %s has just deposited $%d into the faction bank.",GetPlayerNameEx(playerid),cashdeposit);
						SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, string);
	                    SaveDynamicFactions();
						return 1;
					}
					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have that amount of money!");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not at the bank!");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not even in a faction!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/deposit", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerToPoint(5.0,playerid,BankPosition[X],BankPosition[Y],BankPosition[Z]))
	        {
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /deposit [amount]");
					return 1;
				}
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "USAGE: /deposit [amount]");
					return 1;
				}
				if(GetPlayerCash(playerid) >= cashdeposit)
				{
					GivePlayerCash(playerid,-cashdeposit);
					PlayerInfo[playerid][pBank]=cashdeposit+PlayerInfo[playerid][pBank];
					format(string, sizeof(string), "[INFO:] You have deposited $%d, new balance: $%d", cashdeposit,PlayerInfo[playerid][pBank]);
					SendClientMessage(playerid, COLOR_WHITE, string);
                    PlayerActionMessage(playerid,15.0,"takes out some money and hands it to the bank clerk.");
                    OnPlayerDataSave(playerid);
					return 1;
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have that amount of money!");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not at the bank!");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/withdraw", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerToPoint(5.0,playerid,BankPosition[X],BankPosition[Y],BankPosition[Z]))
	        {
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /withdraw [amount]");
					return 1;
				}
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "USAGE: /withdraw [amount]");
					return 1;
				}
				if(PlayerInfo[playerid][pBank] >= cashdeposit)
				{
					GivePlayerCash(playerid,cashdeposit);
					PlayerInfo[playerid][pBank]=PlayerInfo[playerid][pBank]-cashdeposit;
					format(string, sizeof(string), "[INFO:] You have withdrawn $%d, new balance: $%d", cashdeposit,PlayerInfo[playerid][pBank]);
					SendClientMessage(playerid, COLOR_WHITE, string);
                    PlayerActionMessage(playerid,15.0,"recieves a package full of money from the bank clerk.");
                    OnPlayerDataSave(playerid);
					return 1;
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have that much in your bank!");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not at the bank!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/wiretransfer", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /wiretransfer [playerid/PartOfName] [amount]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /wiretransfer [playerid/PartOfName] [amount]");
				return 1;
			}
   			if(PlayerToPoint(5.0,playerid,BankPosition[X],BankPosition[Y],BankPosition[Z]))
   			{
				new moneys = strval(tmp);
				if (IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						new playermoney = PlayerInfo[playerid][pBank] ;
						if (moneys > 0 && playermoney >= moneys)
						{
						    if(giveplayerid != playerid)
						    {
								PlayerInfo[playerid][pBank] -= moneys;
								PlayerInfo[giveplayerid][pBank] += moneys;
								format(string, sizeof(string), "[INFO:] You have wired $%d to %s's bank-account.", moneys, GetPlayerNameEx(giveplayerid),giveplayerid);
								SendClientMessage(playerid, COLOR_WHITE, string);
								format(string, sizeof(string), "[INFO:] You have been wired $%d from %s.", moneys, GetPlayerNameEx(playerid), playerid);
								SendClientMessage(giveplayerid, COLOR_YELLOW, string);
			                    PlayerActionMessage(playerid,15.0,"types some buttons into the bank-machine and hits enter.");
							}
							else
							{
							    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You cannot wire yourself!");
							}
						}
						else
						{
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Amount.");
						}
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not at the bank!");
			}
		}
		return 1;
	}
  	if(strcmp(cmd, "/balance", true) == 0)
	{
 		if(PlayerToPoint(5.0,playerid,BankPosition[X],BankPosition[Y],BankPosition[Z]))
		{
			format(string, sizeof(string), "[INFO:] Balance: $%d.", PlayerInfo[playerid][pBank]);
			SendClientMessage(playerid, COLOR_WHITE, string);
   			PlayerActionMessage(playerid,15.0,"recieves a mini-bank statement from the bank clerk.");
		}
		else
		{
  			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not at the bank!");
		}
		return 1;
	}
   	if(strcmp(cmd, "/fbalance", true) == 0)
	{
		if(PlayerInfo[playerid][pFaction] != 255)
	    {
	 		if(PlayerToPoint(5.0,playerid,BankPosition[X],BankPosition[Y],BankPosition[Z]))
			{
				format(string, sizeof(string), "[INFO:] Faction Balance: $%d.", DynamicFactions[PlayerInfo[playerid][pFaction]][fBank]);
				SendClientMessage(playerid, COLOR_WHITE, string);
	   			PlayerActionMessage(playerid,15.0,"recieves a mini-bank statement from the bank clerk.");
			}
			else
			{
	  			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not at the bank!");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Faction.");
		}
		return 1;
	}
	if(strcmp(cmd, "/fcheckmats", true) == 0)
	{
	    if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] != 1)
	    {
	 		if(PlayerToPoint(5.0,playerid,FactionMaterialsStorage[X],FactionMaterialsStorage[Y],FactionMaterialsStorage[Z]))
			{
				format(string, sizeof(string), "[INFO:] Materials Total: %d.", DynamicFactions[PlayerInfo[playerid][pFaction]][fMaterials]);
				SendClientMessage(playerid, COLOR_WHITE, string);
	   			PlayerActionMessage(playerid,15.0,"starts counting the weapon materials inside the boxes.");
			}
			else
			{
	  			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not at the faction materials storage!");
			}
		}
		else
		{
  			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Faction.");
		}
		return 1;
	}
 	if(strcmp(cmd, "/fcheckdrugs", true) == 0)
	{
	    if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] != 1)
	    {
	 		if(PlayerToPoint(5.0,playerid,FactionDrugsStorage[X],FactionDrugsStorage[Y],FactionDrugsStorage[Z]))
			{
				format(string, sizeof(string), "[INFO:] Drugs Total: %d.", DynamicFactions[PlayerInfo[playerid][pFaction]][fDrugs]);
				SendClientMessage(playerid, COLOR_WHITE, string);
	   			PlayerActionMessage(playerid,15.0,"starts counting the drugs inside storage.");
			}
			else
			{
	  			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not at the faction materials storage!");
			}
		}
  		else
		{
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Faction.");
		}
		return 1;
	}
 	if(strcmp(cmd, "/housewithdraw", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pHouseKey];
			if(PlayerInfo[playerid][pHouseKey] != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /housewithdraw [amount]");
					return 1;
				}
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /housewithdraw [amount]");
					return 1;
				}
				if (PlayerToPoint(20.0, playerid,Houses[bouse][ExitX],Houses[bouse][ExitY],Houses[bouse][ExitZ]))
				{
				    if(Houses[bouse][Money] >= cashdeposit)
				    {
					    if(GetPlayerVirtualWorld(playerid) == bouse)
					    {
							GivePlayerCash(playerid,cashdeposit);
							Houses[bouse][Money]=Houses[bouse][Money]-cashdeposit;
							format(string, sizeof(string), "[INFO:] You have withdrawn $%d from your safe, New Total: $%d ", cashdeposit,Houses[bouse][Money]);
							SendClientMessage(playerid, COLOR_WHITE, string);
	                    	PlayerActionMessage(playerid,15.0,"twists the combination on the safe and takes out some money.");
							SaveHouses();
							return 1;
						}
					}
 					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have that much in your safe!");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not in your house!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't even own a house!");
			}
		}
		return 1;
	}
  	if(strcmp(cmd, "/housedeposit", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pHouseKey];
			if(bouse != 255 && strcmp(playername, Houses[bouse][Owner], true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /housedeposit [amount]");
					return 1;
				}
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /housedeposit [amount]");
					return 1;
				}
				if (PlayerToPoint(20.0, playerid,Houses[bouse][ExitX],Houses[bouse][ExitY],Houses[bouse][ExitZ]))
				{
				    if(GetPlayerCash(playerid) >= cashdeposit)
				    {
					    if(GetPlayerVirtualWorld(playerid) == bouse)
					    {
					        if(Houses[bouse][Money] < 150000)
					        {
					            if(cashdeposit < 150001)
					            {
									GivePlayerCash(playerid,-cashdeposit);
									Houses[bouse][Money]=Houses[bouse][Money]+cashdeposit;
									format(string, sizeof(string), "[INFO:] You have deposited $%d into your safe, New Total: $%d ", cashdeposit,Houses[bouse][Money]);
									SendClientMessage(playerid, COLOR_WHITE, string);
			                    	PlayerActionMessage(playerid,15.0,"twists the combination on the safe and puts in some money.");
									SaveHouses();
								}
 								else
								{
	                                SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can't enter more than $150000.");
								}
							}
							else
							{
                                SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You have exceeded the maximum amount allowed to be stored in a house ($150000)");
							}
							return 1;
						}
					}
 					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have that much!");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not in your house!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't even own a house!");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/housedrugstake", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pHouseKey];
			if(PlayerInfo[playerid][pHouseKey] != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /housematstake [amount]");
					return 1;
				}
				new materialsdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /housematstake [amount]");
					return 1;
				}
				if (PlayerToPoint(100.0, playerid,Houses[bouse][ExitX],Houses[bouse][ExitY],Houses[bouse][ExitZ]))
				{
				    if(Houses[bouse][Drugs] >= materialsdeposit)
				    {
					    if(GetPlayerVirtualWorld(playerid) == bouse)
					    {
							PlayerInfo[playerid][pDrugs] += materialsdeposit;
							Houses[bouse][Drugs]=Houses[bouse][Drugs]-materialsdeposit;
							format(string, sizeof(string), "[INFO:] You have taken %d drugs from your safe, Drugs Total: %d ", materialsdeposit,Houses[bouse][Materials]);
							SendClientMessage(playerid, COLOR_WHITE, string);
	       					PlayerActionMessage(playerid,15.0,"twists the combination on the safe and takes out some drugs.");
							SaveHouses();
							return 1;
						}
					}
 					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have that much drugs in your safe!");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not in your house!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't even own a house!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/housedrugsput", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pHouseKey];
			if(PlayerInfo[playerid][pHouseKey] != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /housedrugsput [amount]");
					return 1;
				}
				new materialsdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /housedrugsput [amount]");
					return 1;
				}
				if (PlayerToPoint(100.0, playerid,Houses[bouse][ExitX],Houses[bouse][ExitY],Houses[bouse][ExitZ]))
				{
				    if(PlayerInfo[playerid][pDrugs] >= materialsdeposit)
				    {
					    if(GetPlayerVirtualWorld(playerid) == bouse)
					    {
					        if(Houses[bouse][Drugs] < 500)
					        {
					            if(materialsdeposit < 501)
					            {
									PlayerInfo[playerid][pDrugs] -= materialsdeposit;
									Houses[bouse][Drugs]=Houses[bouse][Drugs]+materialsdeposit;
									format(string, sizeof(string), "[INFO:] You have put %d drugs into your safe, Drugs Total: %d ", materialsdeposit,Houses[bouse][Materials]);
									SendClientMessage(playerid, COLOR_WHITE, string);
			                    	PlayerActionMessage(playerid,15.0,"twists the combination on the safe and puts in some drugs.");
									SaveHouses();
								}
								else
								{
	                                SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can't enter more than 500!");
								}
							}
							else
							{
                                SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You have exceeded the maximum amount of drugs allowed in a house. (500)");
							}
							return 1;
						}
					}
 					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have that much drugs!");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not in your house!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't even own a house!");
			}
		}
		return 1;
	}
   	if(strcmp(cmd, "/housematsput", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pHouseKey];
			if(PlayerInfo[playerid][pHouseKey] != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /housematsput [amount]");
					return 1;
				}
				new materialsdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /housematsput [amount]");
					return 1;
				}
				if (PlayerToPoint(100.0, playerid,Houses[bouse][ExitX],Houses[bouse][ExitY],Houses[bouse][ExitZ]))
				{
				    if(PlayerInfo[playerid][pMaterials] >= materialsdeposit)
				    {
					    if(GetPlayerVirtualWorld(playerid) == bouse)
					    {
					        if(Houses[bouse][Materials] < 2000)
					        {
					            if(materialsdeposit < 2001)
					            {
									PlayerInfo[playerid][pMaterials] -= materialsdeposit;
									Houses[bouse][Materials]=Houses[bouse][Materials]+materialsdeposit;
									format(string, sizeof(string), "[INFO:] You have put %d materials into your safe, Materials Total: %d ", materialsdeposit,Houses[bouse][Materials]);
									SendClientMessage(playerid, COLOR_WHITE, string);
			                    	PlayerActionMessage(playerid,15.0,"twists the combination on the safe and puts in some weapon materials.");
									SaveHouses();
								}
								else
								{
	                                SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can't enter more than 2000!");
								}
							}
							else
							{
                                SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You have exceeded the maximum amount of materials allowed in a house. (2000)");
							}
							return 1;
						}
					}
 					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have that much materials!");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not in your house!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't even own a house!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/housematstake", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pHouseKey];
			if(PlayerInfo[playerid][pHouseKey] != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /housematstake [amount]");
					return 1;
				}
				new materialsdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /housematstake [amount]");
					return 1;
				}
				if (PlayerToPoint(100.0, playerid,Houses[bouse][ExitX],Houses[bouse][ExitY],Houses[bouse][ExitZ]))
				{
				    if(Houses[bouse][Materials] >= materialsdeposit)
				    {
					    if(GetPlayerVirtualWorld(playerid) == bouse)
					    {
							PlayerInfo[playerid][pMaterials] += materialsdeposit;
							Houses[bouse][Materials]=Houses[bouse][Materials]-materialsdeposit;
							format(string, sizeof(string), "[INFO:] You have taken %d materials from your safe, Materials Total: %d ", materialsdeposit,Houses[bouse][Materials]);
							SendClientMessage(playerid, COLOR_WHITE, string);
	       					PlayerActionMessage(playerid,15.0,"twists the combination on the safe and takes out some weapon materials.");
							SaveHouses();
							return 1;
						}
					}
 					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have that much materials in your safe!");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not in your house!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't even own a house!");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/engine", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
		    if(EngineStatus[GetPlayerVehicleID(playerid)] == 0)
			{
				TogglePlayerControllable(playerid,1);
				EngineStatus[GetPlayerVehicleID(playerid)] = 1;
				if(PlayerInfo[playerid][pSex] == 1)
				{
	   				PlayerActionMessage(playerid,15.0,"has just started the engine of his vehicle.");
	   			}
	   			else
	   			{
					PlayerActionMessage(playerid,15.0,"has just started the engine of her vehicle.");
	   			}
			}
			else
			{
				TogglePlayerControllable(playerid,0);
				EngineStatus[GetPlayerVehicleID(playerid)] = 0;

	   			if(PlayerInfo[playerid][pSex] == 1)
				{
	   				PlayerActionMessage(playerid,15.0,"has just stopped the engine of his vehicle.");
	   			}
	   			else
	   			{
					PlayerActionMessage(playerid,15.0,"has just stopped the engine of her vehicle.");
	   			}
			}
		}
		else
		{
		    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You are not even in a car!");
		}
		return 1;
	}
 	if(strcmp(cmd, "/pay", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /pay [playerid/PartOfName] [amount]");
				return 1;
			}
			//giveplayerid = strval(tmp);
	        giveplayerid = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /pay [playerid/PartOfName] [amount]");
				return 1;
			}
			new moneys,playermoney;
			moneys = strval(tmp);
			if(PlayerInfo[playerid][pAdmin] < 1)
			{
				if(moneys > 1000 && PlayerInfo[playerid][pLevel] < 5)
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Level 5 required for transactions greater than $1000.");
					return 1;
				}
			}
			if(moneys < 1 || moneys > 99999)
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Amount.");
			    return 1;
			}
			if (IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					if (ProxDetectorS(5.0, playerid, giveplayerid))
					{
					    if(giveplayerid != playerid)
					    {
							playermoney = GetPlayerCash(playerid);
							if (moneys > 0 && playermoney >= moneys)
							{
	       						GivePlayerCash(playerid, (0 - moneys));
								GivePlayerCash(giveplayerid, moneys);
								format(string, sizeof(string), "[INFO:] $%d successfully sent to %s (ID:%d).", moneys, GetPlayerNameEx(giveplayerid),giveplayerid);
								PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
								SendClientMessage(playerid, COLOR_WHITE, string);
								format(string, sizeof(string), "[INFO:] %s (ID:%d) has just sent you $%d.",GetPlayerNameEx(playerid), playerid,moneys);
								SendClientMessage(giveplayerid, COLOR_WHITE, string);
								format(string, sizeof(string), "[INFO:] %s has paid $%d to %s.", GetPlayerNameEx(playerid), moneys, GetPlayerNameEx(giveplayerid));
								PayLog(string);
								PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
								PlayerPlayerActionMessage(playerid,giveplayerid,5.0,"takes out cash and hands it to");
							}
							else
							{
								SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid amount.");
							}
						}
      					else
						{
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can't pay yourself!");
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your too far away from that player.");
					}
				}//invalid id
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd,"/licenses",true)==0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        new text1[20];
	        new text2[20];
	        new text3[20];
	        if(PlayerInfo[playerid][pCarLic]) { text1 = "Yes"; } else { text1 = "No"; }
            if(PlayerInfo[playerid][pFlyLic]) { text2 = "Yes"; } else { text2 = "No"; }
			if(PlayerInfo[playerid][pWepLic]) { text3 = "Yes"; } else { text3= "No"; }
			
		 	SendClientMessage(playerid, COLOR_LIGHTGREEN, "----------------------[LICENSES:]----------------------");
	        format(string, sizeof(string), "** Drivers License: %s - Flying License: %s - Weapon License: %s.", text1,text2,text3);
			SendClientMessage(playerid, COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_LIGHTGREEN, "---------------------------------------------------------");
		}
	    return 1;
 	}
 	if(strcmp(cmd,"/showid",true)==0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /showid [playerid/PartOfName]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if(IsPlayerConnected(giveplayerid))
			{
				if(giveplayerid != INVALID_PLAYER_ID)
				{
				    if (ProxDetectorS(8.0, playerid, giveplayerid))
					{
					    new text1[20];
				        new text2[20];
				        new text3[20];
						if(PlayerInfo[playerid][pCarLic]) { text1 = "Yes"; } else { text1 = "No"; }
                        if(PlayerInfo[playerid][pFlyLic]) { text2 = "Yes"; } else { text2 = "No"; }
						if(PlayerInfo[playerid][pWepLic]) { text3 = "Yes"; } else { text3 = "No"; }
						SendClientMessage(giveplayerid,COLOR_LIGHTGREEN,"-----------[SAN ANDREAS ID:]---------");
				        format(string, sizeof(string), "Name: %s.", GetPlayerNameEx(playerid));
				        SendClientMessage(giveplayerid, COLOR_WHITE, string);
				        format(string, sizeof(string), "Drivers License: %s - Flying License: %s - Weapon License: %s.", text1,text2,text3);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						if(PlayerInfo[playerid][pHouseKey] != 255)
						{
						    new houselocation[MAX_ZONE_NAME];
							GetCoords2DZone(Houses[PlayerInfo[playerid][pHouseKey]][EnterX],Houses[PlayerInfo[playerid][pHouseKey]][EnterY], houselocation, MAX_ZONE_NAME);
	      					format(string, sizeof(string), "Home Address: %d %s.", PlayerInfo[playerid][pHouseKey], houselocation);
							SendClientMessage(giveplayerid, COLOR_WHITE, string);
						}
						else
						{
							SendClientMessage(giveplayerid, COLOR_WHITE, "Home Address: None.");
						}
						if(PlayerInfo[playerid][pBizKey] != 255 && strcmp(PlayerName(playerid), Businesses[PlayerInfo[playerid][pBizKey]][Owner], true) == 0)
						{
	      					format(string, sizeof(string), "Business: %s.", Businesses[PlayerInfo[playerid][pBizKey]][BusinessName]);
							SendClientMessage(giveplayerid, COLOR_WHITE, string);
						}
						else
						{
							SendClientMessage(giveplayerid, COLOR_WHITE, "Business: None.");
						}
						SendClientMessage(giveplayerid, COLOR_LIGHTGREEN, "--------------------------------------------");
						format(string, sizeof(string), "[INFO:] You have shown your indentification to: %s.", GetPlayerNameEx(giveplayerid));
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);

						if(PlayerInfo[playerid][pSex] == 1)
						{
							PlayerPlayerActionMessage(playerid,giveplayerid,10.0,"takes out his ID from his pocket and shows it to");
						}
						else
						{
						    PlayerPlayerActionMessage(playerid,giveplayerid,10.0,"takes out her ID from her pocket and shows it to");
						}
					}
					else
					{
					    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That player is not close enough!");
					    return 1;
					}
				}
			}
	        else
	        {
	            SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
	            return 1;
	        }
		}
	    return 1;
 	}
	if(strcmp(cmd, "/oocstatus", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 2)
			{
			    if(OOCStatus)
			    {
			        OOCStatus = 0;
			        format(string, sizeof(string), "[GLOBAL OOC:] Disabled by %s.", GetPlayerNameEx(playerid));
					SendClientMessageToAll(COLOR_ADMINCMD, string);
				}
				else
				{
					OOCStatus = 1;
					format(string, sizeof(string), "[GLOBAL OOC:] Enabled by %s.", GetPlayerNameEx(playerid));
					SendClientMessageToAll(COLOR_ADMINCMD, string);
				}
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/id", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /id [playerid/PartOfName]");
				return 1;
			}
			new target;
			target = ReturnUser(tmp);
			new sstring[256];
			if(IsPlayerConnected(target))
			{
			    if(target != INVALID_PLAYER_ID)
			    {
					format(sstring, sizeof(sstring), "[INFO:] Name: %s (ID: %d).",GetPlayerNameEx(target),target);
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, sstring);
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/lock", true) == 0)
	{
		new carid=GetPlayerVehicleID(playerid);
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
	        if(VehicleLocked[carid] == 0)
	  		{
   			if(PlayerInfo[playerid][pSex] == 1)
			{
				PlayerActionMessage(playerid,15.0,"has just locked his vehicle.");
			}
			else
			{
				PlayerActionMessage(playerid,15.0,"has just locked her vehicle.");
			}
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] Vehicle Locked.");
			VehicleLocked[carid] = 1;
			VehicleLockedPlayer[playerid] = carid;
			}
		}
		else if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
   			new Float:x,Float:y,Float:z;
   			if(VehicleLockedPlayer[playerid] != 999)
   			{
				GetVehiclePos(VehicleLockedPlayer[playerid], x, y, z);
			}
			if(VehicleLocked[VehicleLockedPlayer[playerid]])
			{
   				if(PlayerToPoint(5.0,playerid,x,y,z))
			    {
					if(PlayerInfo[playerid][pSex] == 1)
					{
						PlayerActionMessage(playerid,15.0,"has just unlocked his vehicle.");
					}
					else
					{
						PlayerActionMessage(playerid,15.0,"has just unlocked her vehicle.");
					}
					SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] Vehicle Unlocked.");
					VehicleLocked[VehicleLockedPlayer[playerid]] = 0;
					VehicleLockedPlayer[playerid] = 999;
				}
				else
				{
				    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] Your not at the vehicle!");
				}
			}
  		}
		return 1;
	}
	if(strcmp(cmd,"/clearanims",true)==0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        ClearAnimations(playerid);
	    }
	    return 1;
	}
 	if(strcmp(cmd, "/low", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /low [message]");
				return 1;
			}
			format(string, sizeof(string), "[LOW:] %s says: %s", GetPlayerNameEx(playerid), result);
			ProxDetector(3.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		}
		return 1;
	}
  	if(strcmp(cmd, "/local", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /local [message]");
				return 1;
			}
			format(string, sizeof(string), "%s says: %s", GetPlayerNameEx(playerid), result);
			ProxDetector(3.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		}
		return 1;
	}
   	if(strcmp(cmd, "/shout", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /shout [message]");
				return 1;
			}
			format(string, sizeof(string), "%s shouts: %s!!!", GetPlayerNameEx(playerid), result);
			ProxDetector(3.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		}
		return 1;
	}
	if(strcmp(cmd, "/whisper", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /whisper [playerid] [message]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					new length = strlen(cmdtext);
					while ((idx < length) && (cmdtext[idx] <= ' '))
					{
						idx++;
					}
					new offset = idx;
					new result[128];
					while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
					{
						result[idx - offset] = cmdtext[idx];
						idx++;
					}
					result[idx - offset] = EOS;
					if(!strlen(result))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /whisper [playerid] [message]");
						return 1;
					}
					if (ProxDetectorS(3.0, playerid, giveplayerid))
					{
						if(giveplayerid != playerid)
						{
							format(string, sizeof(string), "%s whispers: %s", GetPlayerNameEx(playerid), result);
							SendClientMessage(giveplayerid, COLOR_YELLOW, string);
							SendClientMessage(playerid, COLOR_YELLOW, string);
							PlayerActionMessage(playerid,5.0,"whispers something.");
						}
						else
						{
						SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You cant whisper yourself.");
						}

					}
					else
					{
							SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You are not close enough.");
					}
					return 1;
				}
			}
			else
			{
					format(string, sizeof(string), "[ERROR:] No player with the ID %d is connected.", strval(tmp));
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, string);
			}
		}
		return 1;
	}
  	if(strcmp(cmd, "/find", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /find [playerid]");
				return 1;
			}
			if(TrackingPlayer[playerid] == 1)
			{
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your already finding someone.");
			return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pJob] == 3)
			{
			    if(IsPlayerConnected(id))
			    {
			        if(playerid != id)
			        {
					    if(id != INVALID_PLAYER_ID)
					    {
							if(PhoneOnline[id] == 0)
							{
								SendClientMessage(id, COLOR_LIGHTYELLOW2, "[INFO:] Someone is tracking you.");
								format(string, sizeof(string), "[INFO:] Your tracking %s, checkpoint removed in 60 seconds.", GetPlayerNameEx(id));
								SendClientMessage(playerid, COLOR_LIGHTYELLOW2, string);
								new Float:x,Float:y,Float:z;
								GetPlayerPos(id,x,y,z);
								SetPlayerCheckpoint(playerid,x,y,z,10.0);
								SetTimerEx("ClearCheckpointsForPlayer", 60000, false, "i", playerid);
								TrackingPlayer[playerid] = 1;

							}
							else
							{
								SendClientMessage(id, COLOR_LIGHTYELLOW2, "[ERROR:] That players phone is not turned! You cannot track.");
							}
						}
					}
					else
					{
						SendClientMessage(id, COLOR_LIGHTYELLOW2, "[ERROR:] You can't track yourself.");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Player ID.");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not a detective!");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/adonator", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /adonator [playerid]");
				return 1;
			}
			new id = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 5)
			{
			    if(IsPlayerConnected(id))
			    {
				    if(id != INVALID_PLAYER_ID)
				    {
						if(PlayerInfo[id][pDonator] == 1)
						{
							format(string, sizeof(string), "[INFO:] Your donator status has been revoked by: %s.", GetPlayerNameEx(playerid));
							SendClientMessage(id, COLOR_ADMINCMD, string);
							DonatorLog(string);
							format(string, sizeof(string), "[INFO:] You have removed %s's donator status.", GetPlayerNameEx(id));
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, string);
							PlayerInfo[id][pDonator] = 0;
						}
						else
						{
							format(string, sizeof(string), "[INFO:] You have been made a donator by: %s.", GetPlayerNameEx(playerid));
							SendClientMessage(id, COLOR_ADMINCMD, string);
							DonatorLog(string);
							format(string, sizeof(string), "[INFO:] You have made %s a donator.", GetPlayerNameEx(id));
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, string);
							PlayerInfo[id][pDonator] = 1;
						}
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Player ID.");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/donatorcmds", true) == 0)
	{
		if(PlayerInfo[playerid][pDonator] == 1)
		{
  			SendClientMessage(playerid,COLOR_YELLOW,"____________________________________________________");
			SendClientMessage(playerid,COLOR_WHITE,"[Donator:] /toggle pm - /toggle phone - ");
			SendClientMessage(playerid,COLOR_YELLOW,"____________________________________________________");
		}
		else
		{
		    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] Your not a donator!");
		}
		return 1;
	}
 	if(strcmp(cmd, "/suspect", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /suspect [playerid] [crime]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						new length = strlen(cmdtext);
						while ((idx < length) && (cmdtext[idx] <= ' '))
						{
							idx++;
						}
						new offset = idx;
						new result[128];
						while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
						{
							result[idx - offset] = cmdtext[idx];
							idx++;
						}
						result[idx - offset] = EOS;
						if(!strlen(result))
						{
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /suspect [playerid] [crime]");
							return 1;
						}
      					if(CopOnDuty[playerid])
						{
							if(giveplayerid != playerid)
							{
								if(WantedPoints[giveplayerid] == 0) { WantedPoints[giveplayerid] = 3; }
								else { WantedPoints[giveplayerid]+= 2; }
								format(string, sizeof(string), "[INFO:] You have been suspected by %s, Reason: %s.", GetPlayerNameEx(playerid),result);
								SendClientMessage(giveplayerid, COLOR_RED, string);
								format(string, sizeof(string), "[INFO:] You have suspected %s, Reason: %s.", GetPlayerNameEx(giveplayerid),result);
								SendClientMessage(playerid, COLOR_WHITE, string);
								format(string, sizeof(string), "[LSPD:] %s has suspected %s, Reason: %s.", GetPlayerNameEx(playerid),GetPlayerNameEx(giveplayerid),result);
								SendFactionTypeMessage(1,COLOR_LSPD,string);
								new location[MAX_ZONE_NAME];
								GetPlayer2DZone(giveplayerid, location, MAX_ZONE_NAME);
								format(string, sizeof(string), "[LSPD:] All units be on the lookout for %s - Person Last Seen: %s.", GetPlayerNameEx(giveplayerid),location);
								SendFactionTypeMessage(1,COLOR_LSPD,string);
							}
							else
							{
	                            SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can't suspect yourself!");
							}
						}
      					else
						{
      						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not on cop duty!");
						}
						return 1;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not in the correct faction.");
				return 1;
			}
		}
  		else
		{
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
			return 1;
		}
		return 1;
	}
 	if(strcmp(cmd, "/carwindows", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			if(IsABike(GetPlayerVehicleID(playerid)))
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Bikes don't have windows.");
			    return 1;
			}
		    if(CarWindowStatus[GetPlayerVehicleID(playerid)] == 1)
		    {
		    	if(PlayerInfo[playerid][pSex] == 1)
				{
					PlayerActionMessage(playerid,15.0,"has just rolled the windows down in his vehicle.");
				}
				else
				{
					PlayerActionMessage(playerid,15.0,"has just rolled the windows down in her vehicle.");
				}
				CarWindowStatus[GetPlayerVehicleID(playerid)] = 0;
		    }
		    else if(CarWindowStatus[GetPlayerVehicleID(playerid)] == 0)
		    {
		    	if(PlayerInfo[playerid][pSex] == 1)
				{
					PlayerActionMessage(playerid,15.0,"has just rolled up the windows in his vehicle.");
				}
				else
				{
					PlayerActionMessage(playerid,15.0,"has just rolled up the windows in her vehicle.");
				}
				CarWindowStatus[GetPlayerVehicleID(playerid)] = 1;
		    }
		}
		else
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] Your not in a vehicle!");
		}
		return 1;
	}
	if(strcmp(cmd, "/policecmds", true) == 0)
	{
	if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
	{
		SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[LSPD:] (/f)action - /copduty - /suspect - (/r)adio - (/m)egaphone - /arrest - /wanted - /cuff - /uncuff - /frisk");
	 	SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[LSPD:] /tazer - /revoke - /ticket - (/gov)ernment");
 	}
 	else
 	{
 	    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] Invalid Faction.");
 	}
	return 1;
	}
	if(strcmp(cmd, "/takejob", true) == 0)
	{
	    if(PlayerInfo[playerid][pJob] == 0)
	    {
     		if(PlayerToPoint(1.0, playerid,GunJob[TakeJobX],GunJob[TakeJobY],GunJob[TakeJobZ]))
			{
   				if(GetPlayerVirtualWorld(playerid) == GunJob[TakeJobWorld])
			    {
					SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[SUCCESS:] Your now an arms dealer, type /jobcmds.");
					PlayerInfo[playerid][pJob] = 1; //Gun Job
				}
			}
 			else if(PlayerToPoint(1.0, playerid,DrugJob[TakeJobX],DrugJob[TakeJobY],DrugJob[TakeJobZ]))
			{
   				if(GetPlayerVirtualWorld(playerid) == DrugJob[TakeJobWorld])
			    {
					SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[SUCCESS:] Your now a drug dealer, type /jobcmds.");
					PlayerInfo[playerid][pJob] = 2; //Drug Job
				}
			}
			else if(PlayerToPoint(1.0, playerid,DetectiveJobPosition[X],DetectiveJobPosition[Y],DetectiveJobPosition[Z]))
			{
   				if(GetPlayerVirtualWorld(playerid) == DetectiveJobPosition[World])
			    {
					SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[SUCCESS:] Your now a Detective, type /jobcmds.");
					PlayerInfo[playerid][pJob] = 3; //Detective Job
				}
			}
			else if(PlayerToPoint(1.0, playerid,LawyerJobPosition[X],LawyerJobPosition[Y],LawyerJobPosition[Z]))
			{
   				if(GetPlayerVirtualWorld(playerid) == LawyerJobPosition[World])
			    {
					SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[SUCCESS:] Your now a Lawyer, type /jobcmds.");
					PlayerInfo[playerid][pJob] = 4; //Lawyer Job
				}
			}
			else if(PlayerToPoint(1.0, playerid,ProductsSellerJob[TakeJobX],ProductsSellerJob[TakeJobY],ProductsSellerJob[TakeJobZ]))
			{
   				if(GetPlayerVirtualWorld(playerid) == ProductsSellerJob[TakeJobWorld])
			    {
					SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[SUCCESS:] Your now a Products Seller, type /jobcmds.");
					PlayerInfo[playerid][pJob] = 5; //Products Seller Job
				}
			}
	    }
	    else
	    {
	    	SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You already have a job!");
	    }
		return 1;
	}
 	if(strcmp(cmd, "/quitjob", true) == 0)
	{
	    if(PlayerInfo[playerid][pJob] != 0)
	    {
     		PlayerInfo[playerid][pJob] = 0;
     		SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You have quit your job.");
	    }
	    else
	    {
	    	SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You don't even have a job!");
	    }
		return 1;
	}
 	if(strcmp(cmd, "/jobcmds", true) == 0)
	{
	    if(PlayerInfo[playerid][pJob] != 0)
	    {
	   		if (PlayerInfo[playerid][pJob] == 1)
			{
				SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[JOB:] - [ARMS DEALER] - /materials - /sellweapon");
			}
			else if(PlayerInfo[playerid][pJob] == 2)
			{
				SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[JOB:] - [DRUG DEALER] - /drugs - /selldrugs");
			}
			else if(PlayerInfo[playerid][pJob] == 3)
			{
				SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[JOB:] - [DETECTIVE] - /find");
			}
			else if(PlayerInfo[playerid][pJob] == 4)
			{
				SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[JOB:] - [LAWYER] - /free");
			}
			else if(PlayerInfo[playerid][pJob] == 5)
			{
				SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[JOB:] - [PRODUCTS SELLER] - /products");
			}
	    }
	    else
	    {
	    	SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You don't even have a job!");
	    }
		return 1;
	}
 	if(strcmp(cmd, "/selldrugs", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		    if(PlayerInfo[playerid][pJob] != 2)
		    {
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not a drugs dealer!");
				return 1;
		    }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /selldrugs [playerid] [amount]");
				return 1;
			}
			new playa;
			new needed;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) { return 1; }
			needed = strval(tmp);
			if(needed < 1 || needed > 50) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] 1-50 only."); return 1; }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) { return 1; }
			if(needed > PlayerInfo[playerid][pDrugs]) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have that much!"); return 1; }
			if(IsPlayerConnected(playa))
			{
			    if(playa != INVALID_PLAYER_ID)
			    {
					if (ProxDetectorS(8.0, playerid, playa))
					{
					    if(playa != playerid)
					    {
						    format(string, sizeof(string), "[INFO:] You have gave %s %d grams of drugs.", GetPlayerNameEx(playa), needed);
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, string);
							format(string, sizeof(string), "[INFO:] %s has just gave you %d grams of drugs.", GetPlayerNameEx(playerid), needed);
							SendClientMessage(playa, COLOR_LIGHTYELLOW2, string);
							PlayerInfo[playa][pDrugs] += needed;
							PlayerInfo[playerid][pDrugs] -= needed;
							PlayerPlayerActionMessage(playerid,playa,15.0,"has just gave some drugs to");
						}
						else
						{
						    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can't sell yourself drugs!");
						}
					}
					else
					{
					    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You arn't near that player!");
					}
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd,"/sellweapon",true)==0)
    {
        if(IsPlayerConnected(playerid))
	    {
		    if (PlayerInfo[playerid][pJob] != 1)
			{
			    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You are not an arms dealer.");
			    return 1;
			}
			new x_weapon[256],weapon[MAX_PLAYERS],ammo[MAX_PLAYERS],price[MAX_PLAYERS];
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /sellweapon [playerid] [weapon]");
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[Weapons:] knife[50] - silenced[150] - eagle[150] - mp5[200] shotgun[200] - ak47[600] m4[600] - rifle [600]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					x_weapon = strtok(cmdtext, idx);
					if(!strlen(x_weapon))
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /sellweapon [playerid] [weapon]");
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[Weapons:] knife[50] - silenced[150] - eagle[150] - mp5[200] shotgun[200] - ak47[600] m4[600] - rifle [600]");
						return 1;
					}
				}
				if(strcmp(x_weapon,"knife",true) == 0) { if(PlayerInfo[playerid][pMaterials] > 49) { weapon[playerid] = 4; price[playerid] = 50; ammo[playerid] = 1; } else { SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You don't have enough materials!"); return 1; } }
				else if(strcmp(x_weapon,"silenced",true) == 0) { if(PlayerInfo[playerid][pMaterials] > 149) { weapon[playerid] = 23; price[playerid] = 125; ammo[playerid] = 50; } else { SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You don't have enough materials!"); return 1; } }
				else if(strcmp(x_weapon,"eagle",true) == 0) { if(PlayerInfo[playerid][pMaterials] > 199) { weapon[playerid] = 24; price[playerid] = 150; ammo[playerid] = 50; } else { SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You don't have enough materials!"); return 1; } }
				else if(strcmp(x_weapon,"mp5",true) == 0) {	if(PlayerInfo[playerid][pMaterials] > 199) { weapon[playerid] = 29; price[playerid] = 200; ammo[playerid] = 200; } else { SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You don't have enough materials!"); return 1; } }
				else if(strcmp(x_weapon,"shotgun",true) == 0) {	if(PlayerInfo[playerid][pMaterials] > 199) { weapon[playerid] = 25; price[playerid] = 200; ammo[playerid] = 50; } else { SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You don't have enough materials!"); return 1; } }
				else if(strcmp(x_weapon,"ak47",true) == 0) { if(PlayerInfo[playerid][pMaterials] > 599) { weapon[playerid] = 30; price[playerid] = 600; ammo[playerid] = 250; } else { SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You don't have enough materials!"); return 1; } }
				else if(strcmp(x_weapon,"m4",true) == 0) { if(PlayerInfo[playerid][pMaterials] > 599) { weapon[playerid] = 31; price[playerid] = 600; ammo[playerid] = 250; } else { SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You don't have enough materials!"); return 1; } }
				else if(strcmp(x_weapon,"rifle",true) == 0) { if(PlayerInfo[playerid][pMaterials] > 599) { weapon[playerid] = 33; price[playerid] = 600; ammo[playerid] = 50; } else { SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You don't have enough materials!"); return 1; } }
				else { SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] Invalid weapon name."); return 1; }
				if (ProxDetectorS(5.0, playerid, giveplayerid))
				{
					format(string, sizeof(string), "[INFO:] You gave %s, a %s with %d ammo, for %d materials.", GetPlayerNameEx(giveplayerid),x_weapon, ammo[playerid], price[playerid]);
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, string);
					format(string, sizeof(string), "[INFO:] %s recieved - Ammo: %d - From %s.", x_weapon, ammo[playerid], GetPlayerNameEx(playerid));
					SendClientMessage(giveplayerid, COLOR_LIGHTYELLOW2, string);
					PlayerPlayerActionMessage(playerid,giveplayerid,15.0,"takes out a weapon and hands it to");
					GivePlayerWeapon(giveplayerid,weapon[playerid],ammo[playerid]);
					PlayerInfo[playerid][pMaterials] -= price[playerid];
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You arn't close enough!");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
			}
		}
		return 1;
	}
 	if(strcmp(cmdtext, "/usedrugs", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
			if(PlayerInfo[playerid][pDrugs] > 1)
			{
			    new Float:armour;
			    GetPlayerArmour(playerid, armour);
			    if(armour < 100.0)
			    {
                	SetPlayerArmour(playerid, armour + 15.0);
                }
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INFO:] 2 grams used.");
			    PlayerInfo[playerid][pDrugs] -= 2;
			    PlayerActionMessage(playerid,15.0,"has just took some drugs.");
			    DrugsIntake[playerid] += 2;
			    if(DrugsIntake[playerid] >= 8)
			    {
			    	SetTimerEx("DrugEffect", 1000, false, "i", playerid);
			    }
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have any drugs.");
			}
		}//not connected
		return 1;
	}
	if(strcmp(cmd,"/products",true)==0)
    {
        if(IsPlayerConnected(playerid))
	    {
		    if (PlayerInfo[playerid][pJob] != 5)
			{
			    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] Your not a products seller!");
			    return 1;
			}
			new x_nr[256];
			x_nr = strtok(cmdtext, idx);
			if(!strlen(x_nr)) {
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /products [usage]");
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGES:] buy, sell.");
				return 1;
			}
			if(strcmp(x_nr,"buy",true) == 0)
			{
			    if(PlayerToPoint(3.0,playerid,ProductsSellerJob[BuyProductsX],ProductsSellerJob[BuyProductsY],ProductsSellerJob[BuyProductsZ]))
			    {
			        if(PlayerInfo[playerid][pProducts] >= 500)
			        {
			            SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can't hold more than 500 products.");
				        return 1;
			        }
			        tmp = strtok(cmdtext, idx);
			        if(!strlen(tmp)) {
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /products [buy] [amount]");
						return 1;
					}
					new moneys;
					moneys = strval(tmp);
					if(moneys < 1 || moneys > 500) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Maximum number of products is 500."); return 1; }
					new price = moneys * PRODUCT_PRICE;
					if(GetPlayerCash(playerid) > price)
					{
					    format(string, sizeof(string), "[INFO:] You bought %d products - Cost: $%d.", moneys, price);
					    SendClientMessage(playerid, COLOR_WHITE, string);
					    SendClientMessage(playerid, COLOR_WHITE, "[INFO:] You must sell products to business owners.");
					    GivePlayerCash(playerid, - price);
					    PlayerInfo[playerid][pProducts] = moneys;
					}
					else
					{
					    format(string, sizeof(string), "[ERROR:] You don't have $%d.", price);
					    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, string);
					}
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not at the products purchase place.");
			        return 1;
			    }
			}
			else if(strcmp(x_nr,"sell",true) == 0)
			{
			    tmp = strtok(cmdtext, idx);
       			if(!strlen(tmp)) {
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /products [sell] [playerid] [amount] [cost]");
					return 1;
				}
				new id;
				id = ReturnUser(tmp);
				if(id == playerid) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can't sell yourself products!"); return 1;}
				
                tmp = strtok(cmdtext, idx);
				new amount;
				amount = strval(tmp);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /products [sell] [playerid] [amount] [cost]");
					return 1;
				}
				
				tmp = strtok(cmdtext, idx);
				new cost;
				cost = strval(tmp);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /products [sell] [playerid] [amount] [cost]");
					return 1;
				}
				if(cost < 1 || cost > 99999) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Products must be above 1 and below 99999."); return 1; }

				if(IsPlayerConnected(id))
				{
					if(id != INVALID_PLAYER_ID)
					{
						if(GetDistanceBetweenPlayers(playerid,id) < 5)
						{
							ProductsOffer[id] = playerid;
							ProductsAmount[id] = amount;
							ProductsCost[id] = cost;
							format(string, sizeof(string), "[INFO:] You have been offered %d products for $%d by %s. (/accept products)", ProductsAmount[id], ProductsCost[id], GetPlayerNameEx(playerid));
						    SendClientMessage(id, COLOR_LIGHTYELLOW2, string);
						    format(string, sizeof(string), "[INFO:] You offered %s, %d products for $%d.", GetPlayerNameEx(id), amount, cost);
						    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, string);
							return 1;
						}
						else
						{
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not near that player!");
						}
	    			}
    			}
    			else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Usage.");
			    return 1;
			}
		}
		return 1;
	}
	if(strcmp(cmd,"/drugs",true)==0)
    {
        if(IsPlayerConnected(playerid))
	    {
		    if (PlayerInfo[playerid][pJob] != 2)
			{
			    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] Your not a drug dealer!");
			    return 1;
			}
			new x_nr[256];
			x_nr = strtok(cmdtext, idx);
			if(!strlen(x_nr)) {
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /drugs [usage]");
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGES:] buy, dropoff.");
				return 1;
			}
			if(strcmp(x_nr,"buy",true) == 0)
			{
			    if(PlayerToPoint(3.0,playerid,DrugJob[BuyDrugsX],DrugJob[BuyDrugsY],DrugJob[BuyDrugsZ]))
			    {
			        if(DrugsHolding[playerid] >= 50)
			        {
			            SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can't hold any more packages.");
				        return 1;
			        }
			        tmp = strtok(cmdtext, idx);
			        if(!strlen(tmp)) {
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /drugs [buy] [amount]");
						return 1;
					}
					new moneys;
					moneys = strval(tmp);
					if(moneys < 1 || moneys > 50) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Maximum number of grams is 50."); return 1; }
					new price = moneys * 50;
					if(GetPlayerCash(playerid) > price)
					{
					    format(string, sizeof(string), "[INFO:] You got %d grams - Cost: $%d.", moneys, price);
					    SendClientMessage(playerid, COLOR_WHITE, string);
					    SendClientMessage(playerid, COLOR_WHITE, "[INFO:] You must now deliver the grams.");
					    GivePlayerCash(playerid, - price);
					    DrugsHolding[playerid] = moneys;
					}
					else
					{
					    format(string, sizeof(string), "[ERROR:] You don't have $%d.", price);
					    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, string);
					}
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not at the drugs purchase place!");
			        return 1;
			    }
			}
			else if(strcmp(x_nr,"dropoff",true) == 0)
			{
			    if(PlayerToPoint(3.0,playerid,DrugJob[DeliverX],DrugJob[DeliverY],DrugJob[DeliverZ]))
			    {
			        if(DrugsHolding[playerid] > 0)
			        {
			            new payout = DrugsHolding[playerid];
			            format(string, sizeof(string), "{INFO:] %d drugs delivered, they are now sellable.", payout);
					    SendClientMessage(playerid, COLOR_WHITE, string);
			            PlayerInfo[playerid][pDrugs] += payout;
			            DrugsHolding[playerid] = 0;
			        }
			        else
			        {
			            SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't even have any drugs!");
				        return 1;
			        }
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "{ERROR:] You are not at the drugs dropoff place.");
			        return 1;
			    }
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Usage.");
			    return 1;
			}
		}
		return 1;
	}
	if(strcmp(cmd,"/materials",true)==0)
    {
        if(IsPlayerConnected(playerid))
	    {
		    if (PlayerInfo[playerid][pJob] != 1)
			{
			    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] Your not an arms dealer!");
			    return 1;
			}
			new x_nr[256];
			x_nr = strtok(cmdtext, idx);
			if(!strlen(x_nr)) {
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /materials [usage]");
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGES:] buy, dropoff.");
				return 1;
			}
			if(strcmp(x_nr,"buy",true) == 0)
			{
			    if(PlayerToPoint(3.0,playerid,GunJob[BuyPackagesX],GunJob[BuyPackagesY],GunJob[BuyPackagesZ]))
			    {
			        if(MatsHolding[playerid] >= 10)
			        {
			            SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can't hold any more packages.");
				        return 1;
			        }
			        tmp = strtok(cmdtext, idx);
			        if(!strlen(tmp)) {
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /materials [usage]");
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGES:] buy, dropoff.");
						return 1;
					}
					new moneys;
					moneys = strval(tmp);
					if(moneys < 1 || moneys > 10) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Maximum number of packages is 10."); return 1; }
					new price = moneys * 100;
					if(GetPlayerCash(playerid) > price)
					{
					    format(string, sizeof(string), "[INFO:] You got %d materials packages - Cost: $%d.", moneys, price);
					    SendClientMessage(playerid, COLOR_WHITE, string);
					    GivePlayerCash(playerid, - price);
					    MatsHolding[playerid] = moneys;
					}
					else
					{
					    format(string, sizeof(string), "[ERROR:] You don't have $%d.", price);
					    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, string);
					}
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not at the materials package place!");
			        return 1;
			    }
			}
			else if(strcmp(x_nr,"dropoff",true) == 0)
			{
			    if(PlayerToPoint(3.0,playerid,GunJob[DeliverX],GunJob[DeliverY],GunJob[DeliverZ]))
			    {
			        if(MatsHolding[playerid] > 0)
			        {
			            new payout = (50)*(MatsHolding[playerid]);
			            format(string, sizeof(string), "{INFO:] Materials packages delivered, you got %d materials.", payout);
					    SendClientMessage(playerid, COLOR_WHITE, string);
			            PlayerInfo[playerid][pMaterials] += payout;
			            MatsHolding[playerid] = 0;
			        }
			        else
			        {
			            SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't even have any packages!");
				        return 1;
			        }
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "{ERROR:] You are not at the materials dropoff place.");
			        return 1;
			    }
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Usage.");
			    return 1;
			}
		}
		return 1;
	}
	if (strcmp(cmd, "/admins", true) == 0)
	{
        if(IsPlayerConnected(playerid))
	    {
	        new count = 0;
			SendClientMessage(playerid, COLOR_LIGHTGREEN, "----------[ADMINISTRATORS ON DUTY]----------");
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
				    if(PlayerInfo[i][pAdmin] >= 1 && AdminDuty[i] == 1)
				    {
						format(string, 256, "Administrator: %s - [Administrator Level: %d]", GetPlayerNameEx(i),PlayerInfo[i][pAdmin]);
						SendClientMessage(playerid, COLOR_WHITE, string);
						count++;
					}
				}
			}
			if(count == 0)
			{
				SendClientMessage(playerid,COLOR_WHITE,"[INFO:] Currently no administrators on duty.");
			}
			SendClientMessage(playerid, COLOR_LIGHTGREEN, "----------------------------------------------------------");
		}
		return 1;
	}
 	if(strcmp(cmd, "/changepass", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (gPlayerLogged[playerid])
			{
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[128];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /changepass [newpass]");
					return 1;
				}
				if(strfind( result , "," , true ) == -1)
    			{
		   			strmid(PlayerInfo[playerid][pKey], (result), 0, strlen((result)), 128);
					format(string, sizeof(string), "[INFO:] You have set your password to: %s.", (result));
					SendClientMessage(playerid, COLOR_ADMINCMD, string);
				}
				else
				{
				    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Symbol , is not allowed!");
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/commands", true) == 0)
	{
	    SendClientMessage(playerid,COLOR_YELLOW,"____________________________________________________");
		SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[General:] /time - /stats - /toggle - /refuel - /spawnpoint - /withdraw - /deposit - /balance - /engine - /eat");
		SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[General:] /phonecmds - /buy - /buyweapon - /advertise - /pay - /licenses - /showid - /buyclothes - /gooc - /id");
		SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[General:] /accept - /report - /eject - /lock - /clearanims - /low - /local - /shout - /whisper - /me - /attempt - /carwindows");
		SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[General:] /takejob - /quitjob - /jobcmds - /buydrink - /usedrugs - /pm - /donate - /admins - /changepass");
		SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Houses - Businesses - Buildings:] /housecmds - /businesscmds");

        if (PlayerInfo[playerid][pFaction] != 255)
		{
			if(DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
			{
			    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[POLICE:] /policecmds");
			}
			if (PlayerInfo[playerid][pRank] == 1)
			{
				SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Leader:] /leadercmds");
			}
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Faction:] /factioncmds");
		}
		SendClientMessage(playerid,COLOR_YELLOW,"____________________________________________________");
		return 1;
	}
 	if(strcmp(cmd, "/answer", true) == 0)
	{
        if(IsPlayerConnected(playerid))
		{
			if(Mobile[playerid] != 255)
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are already on a phone call! (/hangup).");
				return 1;
			}
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(Mobile[i] == playerid)
					{
						Mobile[playerid] = i;
						SendClientMessage(i,  COLOR_LIGHTBLUE, "[INFO:] The person has answered your phone call.");
						if(!IsPlayerInAnyVehicle(playerid))
						{
							SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
						}
						
						if(PlayerInfo[playerid][pSex] == 1)
						{
							PlayerActionMessage(playerid,15.0,"has just answered his mobile phone.");
						}
						else
						{
							PlayerActionMessage(playerid,15.0,"has just answered her mobile phone.");
						}
					}

				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/attempt", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "[USAGE:] /attempt [action]");
				return 1;
			}
			new succeed = 1 + random(2);
			if(succeed == 1)
			{
				format(string, sizeof(string), "[ATTEMPT:] %s attempted to %s and succeeded.", GetPlayerNameEx(playerid), result);
				ProxDetector(10.0, playerid, string, COLOR_LIGHTBLUE,COLOR_LIGHTBLUE,COLOR_LIGHTBLUE,COLOR_LIGHTBLUE,COLOR_LIGHTBLUE);
			}
			else if(succeed == 2)
			{
				format(string, sizeof(string), "[ATTEMPT:] %s attempted to %s and failed.", GetPlayerNameEx(playerid), result);
				ProxDetector(10.0, playerid, string, COLOR_LIGHTBLUE,COLOR_LIGHTBLUE,COLOR_LIGHTBLUE,COLOR_LIGHTBLUE,COLOR_LIGHTBLUE);
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/me", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /me [action]");
				return 1;
			}
			new form[128];
			format(form, sizeof(form), "%s.",result);
			PlayerActionMessage(playerid,15.0,form);
		}
		return 1;
	}
 	if(strcmp(cmd, "/txt", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /txt [phonenumber] [txt message]");
				return 1;
			}
			if(PlayerInfo[playerid][pPhoneNumber] == 0)
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:]  You don't have a mobile phone, you can buy one from a phone shop/network.");
				return 1;
			}
			if(PlayerInfo[playerid][pSex] == 1)
			{
				PlayerActionMessage(playerid,15.0,"takes out his mobile phone and starts txting.");
			}
			else
			{
				PlayerActionMessage(playerid,15.0,"takes out her mobile phone and starts txting.");
			}
			new phonenumb = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /txt [phonenumber] [txt message]");
				return 1;
			}
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(PlayerInfo[i][pPhoneNumber] == phonenumb && phonenumb != 0)
					{
						giveplayerid = i;
						if(IsPlayerConnected(giveplayerid))
						{
						    if(giveplayerid != INVALID_PLAYER_ID)
						    {
						        if(PhoneOnline[giveplayerid])
						        {
						            SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That players phone is turned off.");
						            return 1;
						        }
								format(string, sizeof(string), "[TXT:] From: %s (%d), Message: %s", GetPlayerNameEx(playerid),PlayerInfo[playerid][pPhoneNumber],result);
								SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INFO:] Text message sent.");
								SendClientMessage(giveplayerid, COLOR_LIGHTGREEN, string);
								format(string, sizeof(string), "[TXT:] Sent To: %s (%d), Message: %s", GetPlayerNameEx(giveplayerid),PlayerInfo[giveplayerid][pPhoneNumber],result);
								SendClientMessage(playerid,  COLOR_LIGHTGREEN, string);
								PhoneAnimation(playerid);
								SMSLog(string);
								GivePlayerCash(playerid,-txtcost);
								Businesses[PlayerInfo[playerid][pPhoneC]][Till] += txtcost;
								return 1;
							}
						}
					}
				}
			}
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Message not sent.");
		}
		return 1;
	}
 	if(strcmp(cmd, "/listnumber", true) == 0 )
	{
	if(PlayerInfo[playerid][pPhoneNumber] != 0)
	{
		if(PlayerInfo[playerid][pListNumber])
		{
		    SendClientMessage(playerid,  COLOR_LIGHTYELLOW2, "[PHONE:] Your number will no longer be shown publicly.");
		    PlayerInfo[playerid][pListNumber] = 0;
		}
		else
		{
			SendClientMessage(playerid,  COLOR_LIGHTYELLOW2, "[PHONE:] Your number will now be shown publicly.");
		 	PlayerInfo[playerid][pListNumber] = 1;
		}
	}
	else
	{
		SendClientMessage(playerid,  COLOR_LIGHTYELLOW2, "[ERROR:] You don't have a phone, how could you have a number?");
	}
	return 1;
	}
	if(strcmp(cmd, "/speakerphone", true) == 0 )
	{
	if(PlayerInfo[playerid][pPhoneNumber] != 0 && PlayerInfo[playerid][pPhoneC] != 255)
	{
		if(SpeakerPhone[playerid])
		{
			SendClientMessage(playerid,  COLOR_LIGHTYELLOW2, "[PHONE:] SpeakerPhone disabled.");
			SpeakerPhone[playerid] = 0;
		}
		else
		{
			SendClientMessage(playerid,  COLOR_LIGHTYELLOW2, "[PHONE:] SpeakerPhone enabled.");
			SpeakerPhone[playerid] = 1;
		}
	}
	else
	{
		SendClientMessage(playerid,  COLOR_LIGHTYELLOW2, "[ERROR:] You don't have a phone!");
	}
	return 1;
	}
 	if(strcmp(cmd, "/hangup", true) == 0 )
	{
	    if(IsPlayerConnected(playerid))
		{
			new caller = Mobile[playerid];
			if(IsPlayerConnected(caller))
			{
			    if(caller != INVALID_PLAYER_ID)
			    {
					if(caller != 255)
					{
						if(caller < 255)
						{
							SendClientMessage(caller,  COLOR_LIGHTGREEN, "[PHONE:] They hung up.");
							SendClientMessage(playerid,  COLOR_LIGHTGREEN, "[PHONE:]  You hung up.");
       						
							if(GetPlayerSpecialAction(playerid == SPECIAL_ACTION_USECELLPHONE))
							{
							    if(!IsPlayerInAnyVehicle(playerid))
       							{
									SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
								}
							}
							if(GetPlayerSpecialAction(caller == SPECIAL_ACTION_USECELLPHONE))
							{
							    if(!IsPlayerInAnyVehicle(playerid))
       							{
									SetPlayerSpecialAction(caller,SPECIAL_ACTION_STOPUSECELLPHONE);
								}
							}
							
							if(PlayerInfo[playerid][pSex] == 1)
							{
								PlayerActionMessage(playerid,15.0,"has put his phone in his pocket.");
							}
							else
							{
								PlayerActionMessage(playerid,15.0,"has put her phone in her pocket.");
							}
							if(PlayerInfo[caller][pSex] == 1)
							{
								PlayerActionMessage(playerid,15.0,"has put his phone in his pocket.");
							}
							else
							{
								PlayerActionMessage(playerid,15.0,"has put her phone in her pocket.");
							}
							Mobile[caller] = 255;
							
							if(StartedCall[playerid])
							{
								new callcost = random(100);
								GivePlayerCash(playerid,-callcost);
								Businesses[PlayerInfo[playerid][pPhoneC]][Till] += callcost;
								StartedCall[playerid] = 0;
							}
							else if(StartedCall[caller])
							{
								new callcost = random(100);
								GivePlayerCash(caller,-callcost);
								Businesses[PlayerInfo[caller][pPhoneC]][Till] += callcost;
								StartedCall[caller] = 0;
							}
						}
						Mobile[playerid] = 255;
						return 1;
					}
				}
			}
			SendClientMessage(playerid,  COLOR_LIGHTYELLOW2, "[ERROR:] You are not in a phone call!");
		}
		return 1;
	}
 	if(strcmp(cmd, "/call", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /call [phonenumber]");
				return 1;
			}
			if(PlayerInfo[playerid][pPhoneNumber] == 0)
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't even have a phone!");
				return 1;
			}
			if(PlayerInfo[playerid][pSex] == 1)
			{
				PlayerActionMessage(playerid,15.0,"takes a cell phone from his pocket and dials a number.");
			}
			else
			{
				PlayerActionMessage(playerid,15.0,"takes a cell phone from her pocket and dials a number.");
			}
			new phonenumb = strval(tmp);
			if(phonenumb == 911)
			{
				SendClientMessage(playerid, COLOR_WHITE, "Operator says: Hello, LSPD how may i be of assistance.");
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INFO:] Please keep your call vivid, and all in once sentence.");
				Mobile[playerid] = 911;
				return 1;
			}
			if(phonenumb == PlayerInfo[playerid][pPhoneNumber])
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That line is being used.");
				return 1;
			}
			if(Mobile[playerid] != 255)
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your already on a call.");
				return 1;
			}
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(PlayerInfo[i][pPhoneNumber] == phonenumb && phonenumb != 0)
					{
						giveplayerid = i;
						Mobile[playerid] = giveplayerid; //caller connecting
						if(IsPlayerConnected(giveplayerid))
						{
						    if(giveplayerid != INVALID_PLAYER_ID)
						    {
						        if(PhoneOnline[giveplayerid])
						        {
						            SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That user's phone is turned off.");
						            return 1;
						        }
								if (Mobile[giveplayerid] == 255)
								{
									format(string, sizeof(string), "[PHONE:] Ring... Ring... -  ContactID: %s (%d)", GetPlayerNameEx(playerid),PlayerInfo[playerid][pPhoneNumber]);
									SendClientMessage(giveplayerid, COLOR_LIGHTGREEN, string);
									PlayerActionMessage(giveplayerid,15.0,"'s phone starts ringing.");
                                    StartedCall[playerid] = 1;
                                    if(!IsPlayerInAnyVehicle(playerid))
                                    {
                                    	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
                                    }
                                    StartedCall[giveplayerid] = 0;
									return 1;
								}
							}
						}
						else
						{
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That person is on another phonecall.");
						}
					}
				}
			}
		}
		return 1;
	}
 	if(strcmp(cmd,"/buy",true)==0)
	{
 	if(IsPlayerConnected(playerid))
 	{
  		for(new i = 0; i < sizeof(Businesses); i++)
		{
			if (PlayerToPoint(25.0, playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
			{
				if(GetPlayerVirtualWorld(playerid) == i)
	   			{
				    if(Businesses[i][BizType] == 3) //24-7
			    	{
		        		if(Businesses[i][Products] != 0)
		        		{
							new x_info[128];
							x_info = strtok(cmdtext, idx);
						    new wstring[128];

							if(!strlen(x_info)) {
								format(wstring, sizeof(wstring), "[------------------------[%s]------------------------]", Businesses[i][BusinessName]);
								SendClientMessage(playerid, COLOR_LIGHTGREEN, wstring);
								SendClientMessage(playerid, COLOR_RED, "(Type name, no spaces. Example. baseballbat)");
								SendClientMessage(playerid, COLOR_WHITE, "* Baseball Bat - Price: $200.");
								SendClientMessage(playerid, COLOR_WHITE, "* Shovel - Price: $100.");
								SendClientMessage(playerid, COLOR_WHITE, "* Chainsaw - Price: $5000.");
								SendClientMessage(playerid, COLOR_WHITE, "* Phone Book - Price: $5000. (/phonebook)");
								SendClientMessage(playerid, COLOR_WHITE, "* Flowers - Price: $25.");
								SendClientMessage(playerid, COLOR_LIGHTGREEN, "[-------------------------------------------------------------------------------------] ");
								return 1;
							}
							if(strcmp(x_info,"baseballbat",true) == 0)
							{
								if(GetPlayerCash(playerid) >= 200)
								{
								    GivePlayerWeapon(playerid,5,1);
								    GivePlayerCash(playerid,-200);
								    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[SUCCESS:] You have successfully bought a baseball bat.");
								    Businesses[i][Products]--;
								    Businesses[i][Till]+=200;
								    SaveBusinesses();
								    PlayerActionMessage(playerid,15.0,"gives the store clerk some money and gets an item back in return.");
								    return 1;
								    
								}
								else
								{
								    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money!");
								}
							}
							else if(strcmp(x_info,"shovel",true) == 0)
							{
								if(GetPlayerCash(playerid) >= 100)
								{
								    GivePlayerWeapon(playerid,6,1);
								    GivePlayerCash(playerid,-100);
								    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[SUCCESS:] You have successfully bought a shovel.");
								    Businesses[i][Products]--;
								    Businesses[i][Till]+=100;
								    SaveBusinesses();
								    PlayerActionMessage(playerid,15.0,"gives the store clerk some money and gets an item back in return.");
								    return 1;

								}
								else
								{
								    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money!");
								}
							}
							else if(strcmp(x_info,"chainsaw",true) == 0)
							{
								if(GetPlayerCash(playerid) >= 5000)
								{
								    GivePlayerWeapon(playerid,9,1);
								    GivePlayerCash(playerid,-5000);
								    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[SUCCESS:] You have successfully bought a chainsaw.");
								    Businesses[i][Products]--;
								    Businesses[i][Till]+=5000;
								    SaveBusinesses();
								    PlayerActionMessage(playerid,15.0,"gives the store clerk some money and gets an item back in return.");
								    return 1;

								}
								else
								{
								    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money!");
								}
							}
       						else if(strcmp(x_info,"phonebook",true) == 0)
							{
								if(GetPlayerCash(playerid) >= 5000)
								{
								    GivePlayerCash(playerid,-5000);
								    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[SUCCESS:] You have successfully bought a phone book (/phonebook).");
								    Businesses[i][Products]--;
								    Businesses[i][Till]+=5000;
								    PlayerInfo[playerid][pPhoneBook] = 1;
								    SaveBusinesses();
								    PlayerActionMessage(playerid,15.0,"gives the store clerk some money and gets an item back in return.");
								    return 1;

								}
								else
								{
								    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money!");
								}
							}
							else if(strcmp(x_info,"flowers",true) == 0)
							{
								if(GetPlayerCash(playerid) >= 25)
								{
								    GivePlayerWeapon(playerid,14,1);
								    GivePlayerCash(playerid,-25);
								    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[SUCCESS:] You have successfully bought flowers.");
								    Businesses[i][Products]--;
								    Businesses[i][Till]+=25;
								    SaveBusinesses();
								    PlayerActionMessage(playerid,15.0,"gives the store clerk some money and gets an item back in return.");
                                    return 1;
								}
							}
						}
					}
				}
			}
		}
	}
	return 1;
}
 	if(strcmp(cmd,"/buyweapon",true)==0)
	{
 	if(IsPlayerConnected(playerid))
 	{
  		for(new i = 0; i < sizeof(Businesses); i++)
		{
			if (PlayerToPoint(25.0, playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
			{
				if(GetPlayerVirtualWorld(playerid) == i)
	   			{
				    if(Businesses[i][BizType] == 4) //Ammunation
			    	{
		        		if(Businesses[i][Products] != 0)
		        		{
							new x_info[128];
							x_info = strtok(cmdtext, idx);
						    new wstring[128];

							if(!strlen(x_info)) {
								format(wstring, sizeof(wstring), "[------------------------[%s]------------------------]", Businesses[i][BusinessName]);
								SendClientMessage(playerid, COLOR_LIGHTGREEN, wstring);
								SendClientMessage(playerid, COLOR_RED, "(Type name, no spaces, no capitals. Example. deagle)");
								SendClientMessage(playerid, COLOR_WHITE, "* Deagle - Price: $3500 - 200 Ammo.");
								SendClientMessage(playerid, COLOR_WHITE, "* MP5 - Price: $5000 - 500 Ammo.");
								SendClientMessage(playerid, COLOR_WHITE, "* M4 - Price: $5000 - 500 Ammo.");
								SendClientMessage(playerid, COLOR_WHITE, "* Country Rifle - Price: $8000 - 500 Ammo.");
								SendClientMessage(playerid, COLOR_WHITE, "* Sniper Rifle - Price: $12000 - 500 Ammo.");
								SendClientMessage(playerid, COLOR_WHITE, "* Silenced Pistol - Price: $3500 - 200 Ammo.");
								SendClientMessage(playerid, COLOR_WHITE, "* Shotgun - Price: $4500 - 200 Ammo.");
								SendClientMessage(playerid, COLOR_WHITE, "* Pepperspray - Price:$1000 - 500 Ammo.");
								SendClientMessage(playerid, COLOR_WHITE, "* Body Armour - Price: $1500.");
								SendClientMessage(playerid, COLOR_LIGHTGREEN, "[-------------------------------------------------------------------------------------] ");
								return 1;
							}
							if(PlayerInfo[playerid][pWepLic])
							{
								if(strcmp(x_info,"deagle",true) == 0)
								{
									if(GetPlayerCash(playerid) >= 3500)
									{
									    GivePlayerWeapon(playerid,24,200);
									    GivePlayerCash(playerid,-3500);
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[SUCCESS:] You have successfully bought a Desert Eagle.");
									    Businesses[i][Products]--;
									    Businesses[i][Till]+=3500;
									    SaveBusinesses();
									    PlayerActionMessage(playerid,15.0,"gives the store clerk some money and gets a weapon back in return.");
									    return 1;

									}
									else
									{
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money!");
									    return 1;
									}
								}
								else if(strcmp(x_info,"mp5",true) == 0)
								{
									if(GetPlayerCash(playerid) >= 5000)
									{
									    GivePlayerWeapon(playerid,29,500);
									    GivePlayerCash(playerid,-5000);
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[SUCCESS:] You have successfully bought a MP5.");
									    Businesses[i][Products]--;
									    Businesses[i][Till]+=5000;
									    SaveBusinesses();
									    PlayerActionMessage(playerid,15.0,"gives the store clerk some money and gets a weapon back in return.");
									    return 1;

									}
									else
									{
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money!");
									    return 1;
									}
								}
	       						else if(strcmp(x_info,"m4",true) == 0)
								{
									if(GetPlayerCash(playerid) >= 5000)
									{
									    GivePlayerWeapon(playerid,31,500);
									    GivePlayerCash(playerid,-5000);
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[SUCCESS:] You have successfully bought a M4.");
									    Businesses[i][Products]--;
									    Businesses[i][Till]+=5000;
									    SaveBusinesses();
									    PlayerActionMessage(playerid,15.0,"gives the store clerk some money and gets a weapon back in return.");
									    return 1;

									}
									else
									{
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money!");
									    return 1;
									}
								}
	 							else if(strcmp(x_info,"countryrifle",true) == 0)
								{
									if(GetPlayerCash(playerid) >= 8000)
									{
									    GivePlayerWeapon(playerid,33,500);
									    GivePlayerCash(playerid,-8000);
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[SUCCESS:] You have successfully bought a Country Rifle.");
									    Businesses[i][Products]--;
									    Businesses[i][Till]+=8000;
									    SaveBusinesses();
									    PlayerActionMessage(playerid,15.0,"gives the store clerk some money and gets a weapon back in return.");
									    return 1;

									}
									else
									{
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money!");
									    return 1;
									}
								}
								else if(strcmp(x_info,"sniperrifle",true) == 0)
								{
									if(GetPlayerCash(playerid) >= 12000)
									{
									    GivePlayerWeapon(playerid,34,500);
									    GivePlayerCash(playerid,-12000);
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[SUCCESS:] You have successfully bought a Sniper Rifle.");
									    Businesses[i][Products]--;
									    Businesses[i][Till]+=12000;
									    SaveBusinesses();
									    PlayerActionMessage(playerid,15.0,"gives the store clerk some money and gets a weapon back in return.");
									    return 1;

									}
									else
									{
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money!");
									    return 1;
									}
								}
								else if(strcmp(x_info,"silencedpistol",true) == 0)
								{
									if(GetPlayerCash(playerid) >= 3500)
									{
									    GivePlayerWeapon(playerid,23,200);
									    GivePlayerCash(playerid,-3500);
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[SUCCESS:] You have successfully bought a 9MM Silenced Pistol.");
									    Businesses[i][Products]--;
									    Businesses[i][Till]+=3500;
									    SaveBusinesses();
									    PlayerActionMessage(playerid,15.0,"gives the store clerk some money and gets a weapon back in return.");
									    return 1;

									}
									else
									{
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money!");
									    return 1;
									}
								}
								else if(strcmp(x_info,"shotgun",true) == 0)
								{
									if(GetPlayerCash(playerid) >= 4500)
									{
									    GivePlayerWeapon(playerid,25,200);
									    GivePlayerCash(playerid,-4500);
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[SUCCESS:] You have successfully bought a Shotgun.");
									    Businesses[i][Products]--;
									    Businesses[i][Till]+=4500;
									    SaveBusinesses();
									    PlayerActionMessage(playerid,15.0,"gives the store clerk some money and gets a weapon back in return.");
									    return 1;

									}
									else
									{
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money!");
									    return 1;
									}
								}
							}
							else
							{
								SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have a weapon license, you can only buy:");
								SendClientMessage(playerid, COLOR_RED, "(Type name, no spaces, no capitals. Example. deagle)");
								SendClientMessage(playerid, COLOR_WHITE, "* Pepperspray - Price: $1000 - 500 Ammo.");
								SendClientMessage(playerid, COLOR_WHITE, "* Body Armour - Price: $1500.");
							}
							if(strcmp(x_info,"pepperspray",true) == 0)
							{
								if(GetPlayerCash(playerid) >= 1000)
								{
								    GivePlayerWeapon(playerid,41,500);
								    GivePlayerCash(playerid,-1000);
								    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[SUCCESS:] You have successfully bought Pepperspray.");
								    Businesses[i][Products]--;
								    Businesses[i][Till]+=1000;
								    SaveBusinesses();
								    PlayerActionMessage(playerid,15.0,"gives the store clerk some money and gets a weapon back in return.");
								    return 1;

								}
								else
								{
								    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money!");
								    return 1;
								}
							}
							else if(strcmp(x_info,"bodyarmour",true) == 0)
							{
								if(GetPlayerCash(playerid) >= 1500)
								{
								    new Float:armour;
								    GetPlayerArmour(playerid,armour);
								    if(armour != 100.0)
								    {
									    GivePlayerCash(playerid,-1500);
									    SetPlayerArmour(playerid,100);
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[SUCCESS:] You have successfully bought Body Armour.");
									    Businesses[i][Products]--;
									    Businesses[i][Till]+=1500;
									    SaveBusinesses();
									    PlayerActionMessage(playerid,15.0,"gives the store clerk some money and gets body armour back in return.");
									    return 1;
								    }
								    else
								    {
								    	SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your armour's full!");
								    	return 1;
								    }
								}
							}
						}
					}
				}
			}
		}
	}
	return 1;
}
	if(strcmp(cmd, "/buyclothes", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /buyclothes [skinid]");
				return 1;
			}
			new id = strval(tmp);
		    for(new i = 0; i < sizeof(Businesses); i++)
			{
				if (PlayerToPoint(25.0, playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
				{
					if(GetPlayerVirtualWorld(playerid) == i)
		   			{
					    if(Businesses[i][BizType] == 6)
					    {
					        if(Businesses[i][Products] != 0)
					        {
					            if(GetPlayerCash(playerid) >= 100)
					            {
					                if(IsACopSkin(id) == 0)
									{
										if(IsValidSkin(id))
										{
											SetPlayerSkin(playerid,id);
											GivePlayerCash(playerid,-100);
											Businesses[i][Products]--;
											Businesses[i][Till]+=100;
											SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INFO:] Clothes purchased, $-100.");
											SaveBusinesses();
											return 1;
										}
			        				}
								}
	        				}
	    				}
	   				}
				}
	   		}
		}
		return 1;
	}
	if(strcmp(cmd, "/buyphone", true) == 0)
	{
	    for(new i = 0; i < sizeof(Businesses); i++)
		{
			if (PlayerToPoint(25.0, playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
			{
				if(GetPlayerVirtualWorld(playerid) == i)
	   			{
				    if(Businesses[i][BizType] == 2)
				    {
				        if(Businesses[i][Products] != 0)
				        {
					        if(GetPlayerCash(playerid) >= 500)
					        {
				    			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"____________________________________________________");
           						SendClientMessage(playerid,COLOR_WHITE,"[FOOD:] You have just purchased a phone! $-500");
                 				GivePlayerCash(playerid,-500);
                     			Businesses[i][Till] += 500;
                        		Businesses[i][Products]--;
                          		SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"____________________________________________________");
 								PlayerActionMessage(playerid,15.0,"has just gave the clerk $500 and gotten a phone in return.");
 								new randphone = 9999 + random(999999);//minimum 9999  max 999999
								PlayerInfo[playerid][pPhoneNumber] = randphone;
								PlayerInfo[playerid][pPhoneC] = i;
 								SaveBusinesses();
 								return 1;
							}
						}
					}
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd,"/buydrink",true)==0)
	{
	 	if(IsPlayerConnected(playerid))
	 	{
   			for(new i = 0; i < sizeof(Businesses); i++)
			{
				if (PlayerToPoint(25.0, playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
				{
					if(GetPlayerVirtualWorld(playerid) == i)
					{
			    		if(Businesses[i][BizType] == 7)
			    		{
			    			new x_info[128];
							x_info = strtok(cmdtext, idx);

							if(!strlen(x_info)) {
								SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /buydrink [item]");
								SendClientMessage(playerid, COLOR_WHITE, "[ITEM:] Beer - Price: $7.");
								SendClientMessage(playerid, COLOR_WHITE, "[ITEM:] Vodka - Price: $10.");
								SendClientMessage(playerid, COLOR_WHITE, "[ITEM:] Cola - Price: $3.");
								SendClientMessage(playerid, COLOR_WHITE, "[ITEM:] Water - Price: $3.");
								SendClientMessage(playerid, COLOR_WHITE, "[ITEM:] Whiskey - Price: $10.");
								SendClientMessage(playerid, COLOR_WHITE, "[ITEM:] Brandy - Price: $15.");
								SendClientMessage(playerid, COLOR_WHITE, "[ITEM:] Soda - Price: $3.");
								return 1;
							}
				        	if(Businesses[i][Products] != 0)
				        	{
				        	    new Float:HP;
				        	    GetPlayerHealth(playerid,HP);
								if(strcmp(x_info,"beer",true) == 0)
								{
									if(GetPlayerCash(playerid) >= 7)
									{
	           						GivePlayerCash(playerid,-7);
                     		       	Businesses[i][Till] += 7;
                        		    Businesses[i][Products]--;
                              		if(HP < 100)
                        		    {
                          		  		SetPlayerHealth(playerid,HP+15.0);
                          		  	}
							  		PlayerActionMessage(playerid,15.0,"has just bought a beer, then drinks it.");
							  		SaveBusinesses();
							  		return 1;
									}
									else
									{
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money.");
									    return 1;
									}
								}
        						if(strcmp(x_info,"vodka",true) == 0)
								{
									if(GetPlayerCash(playerid) >= 10)
									{
	           						GivePlayerCash(playerid,-10);
                     		       	Businesses[i][Till] += 10;
                        		    Businesses[i][Products]--;
                              		if(HP < 100)
                        		    {
                          		  		SetPlayerHealth(playerid,HP+20.0);
                          		  	}
							  		PlayerActionMessage(playerid,15.0,"has just bought a shot of vodka, then drinks it.");
							  		SaveBusinesses();
							  		return 1;
									}
									else
									{
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money.");
									    return 1;
									}
								}
        						if(strcmp(x_info,"cola",true) == 0)
								{
									if(GetPlayerCash(playerid) >= 3)
									{
	           						GivePlayerCash(playerid,-3);
                     		       	Businesses[i][Till] += 3;
                        		    Businesses[i][Products]--;
                              		if(HP < 100)
                        		    {
                          		  		SetPlayerHealth(playerid,HP+2.0);
                          		  	}
							  		PlayerActionMessage(playerid,15.0,"has just bought a cola, then drinks it.");
							  		SaveBusinesses();
							  		return 1;
									}
									else
									{
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money.");
									    return 1;
									}
								}
       	 						if(strcmp(x_info,"water",true) == 0)
								{
									if(GetPlayerCash(playerid) >= 1)
									{
	           						GivePlayerCash(playerid,-1);
                     		       	Businesses[i][Till] += 1;
                        		    Businesses[i][Products]--;
                              		if(HP < 100)
                        		    {
                          		  		SetPlayerHealth(playerid,HP+1.0);
                          		  	}
							  		PlayerActionMessage(playerid,15.0,"has just bought a glass of water, then drinks it.");
							  		SaveBusinesses();
							  		return 1;
									}
									else
									{
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money.");
									    return 1;
									}
								}
        						if(strcmp(x_info,"whiskey",true) == 0)
								{
									if(GetPlayerCash(playerid) >= 10)
									{
	           						GivePlayerCash(playerid,-10);
                     		       	Businesses[i][Till] += 10;
                        		    Businesses[i][Products]--;
                              		if(HP < 100)
                        		    {
                          		  		SetPlayerHealth(playerid,HP+20.0);
                          		  	}
							  		PlayerActionMessage(playerid,15.0,"has just bought a glass of whiskey, then drinks it.");
							  		SaveBusinesses();
							  		return 1;
									}
									else
									{
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money.");
									    return 1;
									}
								}
								if(strcmp(x_info,"brandy",true) == 0)
								{
									if(GetPlayerCash(playerid) >= 15)
									{
	           						GivePlayerCash(playerid,-15);
                     		       	Businesses[i][Till] += 15;
                        		    Businesses[i][Products]--;
                              		if(HP < 100)
                        		    {
                          		  		SetPlayerHealth(playerid,HP+25.0);
                          		  	}
							  		PlayerActionMessage(playerid,15.0,"has just bought a glass of brandy, then drinks it.");
							  		SaveBusinesses();
							  		return 1;
									}
									else
									{
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money.");
									    return 1;
									}
								}
        						if(strcmp(x_info,"soda",true) == 0)
								{
									if(GetPlayerCash(playerid) >= 3)
									{
	           						GivePlayerCash(playerid,-3);
                     		       	Businesses[i][Till] += 3;
                        		    Businesses[i][Products]--;
                              		if(HP < 100)
                        		    {
                          		  		SetPlayerHealth(playerid,HP+2.0);
                          		  	}
							  		PlayerActionMessage(playerid,15.0,"has just bought a soda, then drinks it.");
							  		SaveBusinesses();
							  		return 1;
									}
									else
									{
									    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money.");
									    return 1;
									}
								}
							}
						}
					}
				}
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/eat", true) == 0)
	{
	    for(new i = 0; i < sizeof(Businesses); i++)
		{
			if (PlayerToPoint(25.0, playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
			{
				if(GetPlayerVirtualWorld(playerid) == i)
	   			{
				    if(Businesses[i][BizType] == 1)
				    {
				        if(Businesses[i][Products] != 0)
				        {
					        if(GetPlayerCash(playerid) >= 15)
					        {
						        if(PlayerToPoint(25.0,playerid,377.0869,-68.1940,1001.5151))//Burger Shot
						        {
				    				SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"____________________________________________________");
           		                 	SendClientMessage(playerid,COLOR_WHITE,"[FOOD:] You have just eaten a hamburger and fries. -$15");
	           						GivePlayerCash(playerid,-15);
                     		       	Businesses[i][Till] += 15;
                        		    Businesses[i][Products]--;
                          		  	SetPlayerHealth(playerid,100);
        							SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"____________________________________________________");
							  		PlayerActionMessage(playerid,15.0,"has just eaten a hamburger and fries.");
							  		SaveBusinesses();
									return 1;
        						}
		      					else if(PlayerToPoint(25.0,playerid,369.6264,-6.5964,1001.8589))//Cluckin Bell
						        {
								    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"____________________________________________________");
		          					SendClientMessage(playerid,COLOR_WHITE,"[FOOD:] You have just eaten a chickenburger and fries. -$15");
		          					GivePlayerCash(playerid,-15);
		          					Businesses[i][Till] += 15;
		          					Businesses[i][Products]--;
		          					SetPlayerHealth(playerid,100);
		          					SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"____________________________________________________");
	   								PlayerActionMessage(playerid,15.0,"has just eaten a chickenburger and fries.");
	   								SaveBusinesses();
									return 1;
								}
	  							else if(PlayerToPoint(25.0,playerid,375.7379,-119.1621,1001.4995))//Well Stacked Pizza
						        {
								    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"____________________________________________________");
		          					SendClientMessage(playerid,COLOR_WHITE,"[FOOD:] You have just eaten a large pizza and drunk a large drink. -$15");
		          					GivePlayerCash(playerid,-15);
		          					Businesses[i][Till] += 15;
		          					Businesses[i][Products]--;
		          					SetPlayerHealth(playerid,100);
		          					SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"____________________________________________________");
	   								PlayerActionMessage(playerid,15.0,"has just eaten a large pizza and drunk a large drink.");
	   								SaveBusinesses();
									return 1;
								}
								else if(PlayerToPoint(25.0,playerid,378.7731,-186.7205,1000.6328))//Rusty Browns Dohnuts
						        {
								    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"____________________________________________________");
		          					SendClientMessage(playerid,COLOR_WHITE,"[FOOD:] You have just eaten two dohnuts and had a large drink. -$15");
		          					GivePlayerCash(playerid,-15);
		          					Businesses[i][Till] += 15;
		          					Businesses[i][Products]--;
		          					SetPlayerHealth(playerid,100);
		          					SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"____________________________________________________");
	   								PlayerActionMessage(playerid,15.0,"has just eaten two dohnuts and had a large drink.");
	   								SaveBusinesses();
									return 1;
								}
								else
								{
								    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"____________________________________________________");
		          					SendClientMessage(playerid,COLOR_WHITE,"[FOOD:] You have just eaten some food. -$15");
		          					GivePlayerCash(playerid,-15);
		          					Businesses[i][Till] += 15;
		          					Businesses[i][Products]--;
		          					SetPlayerHealth(playerid,100);
		          					SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"____________________________________________________");
	   								PlayerActionMessage(playerid,15.0,"has just eaten some food.");
	   								SaveBusinesses();
									return 1;
        						}
							}
						}
					}
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/factiondrugstake", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pFaction];
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] != 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /factiondrugstake [amount]");
					return 1;
				}
				new materialsdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /factiondrugstake [amount]");
					return 1;
				}
				if(PlayerInfo[playerid][pRank] == 1)
				{
					if (PlayerToPoint(1.0, playerid,FactionDrugsStorage[X],FactionDrugsStorage[Y],FactionDrugsStorage[Z]))
					{
					    if(DynamicFactions[bouse][fDrugs] >= materialsdeposit)
					    {
							PlayerInfo[playerid][pDrugs] += materialsdeposit;
							DynamicFactions[bouse][fDrugs]=DynamicFactions[bouse][fDrugs]-materialsdeposit;
							format(string, sizeof(string), "[INFO:] You have taken %d materials from the storage facility, Materials Total: %d ", materialsdeposit,DynamicFactions[bouse][fDrugs]);
							SendClientMessage(playerid, COLOR_WHITE, string);
   							PlayerActionMessage(playerid,15.0,"takes out drugs from storage.");
							format(string, sizeof(string), "[FACTION:] %s has just taken %d drugs from the faction storage facility.",GetPlayerNameEx(playerid),materialsdeposit);
							SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, string);
							SaveDynamicFactions();
							return 1;
						}
	 					else
						{
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] There isn't that much drugs in storage!");
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not at the faction storage facility!");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not the leader of the faction!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not in a faction!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/factiondrugsput", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pFaction];
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] != 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /factiondrugsput [amount]");
					return 1;
				}
				new materialsdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /factiondrugsput [amount]");
					return 1;
				}
				if (PlayerToPoint(1.0, playerid,FactionDrugsStorage[X],FactionDrugsStorage[Y],FactionDrugsStorage[Z]))
				{
				    if(PlayerInfo[playerid][pDrugs] >= materialsdeposit)
				    {
						PlayerInfo[playerid][pDrugs] -= materialsdeposit;
						DynamicFactions[bouse][fDrugs]=DynamicFactions[bouse][fDrugs]+materialsdeposit;
						format(string, sizeof(string), "[INFO:] You have put %d drugs into your faction storage, Materials Total: %d ", materialsdeposit,DynamicFactions[bouse][fDrugs]);
						SendClientMessage(playerid, COLOR_WHITE, string);
        				PlayerActionMessage(playerid,15.0,"puts drugs into storage.");
						format(string, sizeof(string), "[FACTION:] %s has just put %d drugs in the faction storage facility.",GetPlayerNameEx(playerid),materialsdeposit);
						SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, string);
						SaveDynamicFactions();
						return 1;
					}
 					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have that much drugs!");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not at the faction storage facility!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Faction.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/factionmatstake", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pFaction];
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] != 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /factionmatstake [amount]");
					return 1;
				}
				new materialsdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /factionmatstake [amount]");
					return 1;
				}
				if(PlayerInfo[playerid][pRank] == 1)
				{
					if (PlayerToPoint(1.0, playerid,FactionMaterialsStorage[X],FactionMaterialsStorage[Y],FactionMaterialsStorage[Z]))
					{
					    if(DynamicFactions[bouse][fMaterials] >= materialsdeposit)
					    {
							PlayerInfo[playerid][pMaterials] += materialsdeposit;
							DynamicFactions[bouse][fMaterials]=DynamicFactions[bouse][fMaterials]-materialsdeposit;
							format(string, sizeof(string), "[INFO:] You have taken %d materials from the storage facility, Materials Total: %d ", materialsdeposit,DynamicFactions[bouse][fMaterials]);
							SendClientMessage(playerid, COLOR_WHITE, string);
   							PlayerActionMessage(playerid,15.0,"takes out some weapon materials from the boxes.");
							format(string, sizeof(string), "[FACTION:] %s has just taken %d weapon materials from the faction storage facility.",GetPlayerNameEx(playerid),materialsdeposit);
							SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, string);
							SaveDynamicFactions();
							return 1;
						}
	 					else
						{
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] There isn't that much materials in storage!");
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not at the faction storage facility!");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not the leader of the faction!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not in a faction!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/factionmatsput", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			new bouse = PlayerInfo[playerid][pFaction];
			if(PlayerInfo[playerid][pFaction] != 255 && DynamicFactions[PlayerInfo[playerid][pFaction]][fType] != 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /factionmatsput [amount]");
					return 1;
				}
				new materialsdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /factionmatsput [amount]");
					return 1;
				}
				if (PlayerToPoint(1.0, playerid,FactionMaterialsStorage[X],FactionMaterialsStorage[Y],FactionMaterialsStorage[Z]))
				{
				    if(PlayerInfo[playerid][pMaterials] >= materialsdeposit)
				    {
						PlayerInfo[playerid][pMaterials] -= materialsdeposit;
						DynamicFactions[bouse][fMaterials]=DynamicFactions[bouse][fMaterials]+materialsdeposit;
						format(string, sizeof(string), "[INFO:] You have put %d materials into your faction storage, Materials Total: %d ", materialsdeposit,DynamicFactions[bouse][fMaterials]);
						SendClientMessage(playerid, COLOR_WHITE, string);
        				PlayerActionMessage(playerid,15.0,"puts weapon materials into the boxes.");
						format(string, sizeof(string), "[FACTION:] %s has just put %d weapon materials in the faction storage facility.",GetPlayerNameEx(playerid),materialsdeposit);
						SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_FACTIONCHAT, string);
						SaveDynamicFactions();
						return 1;
					}
 					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have that much materials!");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not at the faction storage facility!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Faction.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/sellhouse", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			if(PlayerInfo[playerid][pHouseKey] != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
			{
			    new house = PlayerInfo[playerid][pHouseKey];
				if(PlayerToPoint(1.0,playerid,Houses[house][EnterX],Houses[house][EnterY],Houses[house][EnterZ]))
				{
					Houses[house][Locked] = 1;
					Houses[house][Owned] = 0;
					strmid(Houses[house][Owner], "None", 0, strlen("None"), 255);
					GivePlayerCash(playerid,Houses[house][HousePrice]);
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					format(string, sizeof(string), "[INFO:] You have sold your house for $%d.", Houses[house][HousePrice]);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					ChangeStreamPickupModel(Houses[house][PickupID],1273);
					PlayerInfo[playerid][pHouseKey] = 255;
					OnPlayerDataSave(playerid);
       				PlayerActionMessage(playerid,15.0,"takes out his house key and hands it to the real estate agent.");
					SaveHouses();
					return 1;
				}
				else
				{
				    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You must be at your house entrance to sell it!");
				}
			}
			else
			{
    			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You don't even own a house!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/openhouse", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        for(new i = 0; i < sizeof(Houses); i++)
			{
				if (PlayerToPoint(3.0, playerid,Houses[i][EnterX], Houses[i][EnterY], Houses[i][EnterZ]) || PlayerToPoint(3.0, playerid,Houses[i][ExitX], Houses[i][ExitY], Houses[i][ExitZ]))
				{
					if(PlayerInfo[playerid][pHouseKey] == i)
					{
						if(Houses[i][Locked] == 1)
						{
							Houses[i][Locked] = 0;
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2,"[INFO:] Door Unlocked.");
		                    PlayerActionMessage(playerid,15.0,"puts in there key and opens the door.");
		                    SaveHouses();
							return 1;
						}
						if(Houses[i][Locked] == 0)
						{
							Houses[i][Locked] = 1;
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2,"[INFO:] Door Locked.");
		                    PlayerActionMessage(playerid,15.0,"puts in there key and locks the door.");
		                    SaveHouses();
							return 1;
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2,"[ERROR:] You don't have a key for this house!");
						return 1;
					}
				}
			}
	    }
	    return 1;
	}
 	if(strcmp(cmd, "/openbusiness", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        for(new i = 0; i < sizeof(Businesses); i++)
			{
				if (PlayerToPoint(3.0, playerid,Businesses[i][EnterX], Businesses[i][EnterY], Businesses[i][EnterZ]) || PlayerToPoint(3.0, playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
				{
					new playername[MAX_PLAYER_NAME];
					GetPlayerName(playerid,playername,sizeof(playername));
					if(PlayerInfo[playerid][pBizKey] == i && strcmp(playername, Businesses[PlayerInfo[playerid][pBizKey]][Owner], true) == 0)
					{
						if(Businesses[i][Locked] == 1)
						{
			    			if(PlayerInfo[playerid][pSex] == 1)
						    {
								Businesses[i][Locked] = 0;
								SendClientMessage(playerid, COLOR_LIGHTYELLOW2,"[INFO:] Door Unlocked.");
			                    PlayerActionMessage(playerid,15.0,"puts in his key and opens the door.");
			                    SaveBusinesses();
		                    }
		                    else
						    {
								Businesses[i][Locked] = 0;
								SendClientMessage(playerid, COLOR_LIGHTYELLOW2,"[INFO:] Door Unlocked.");
			                    PlayerActionMessage(playerid,15.0,"puts in her key and opens the door.");
			                    SaveBusinesses();
		                    }
							return 1;
						}
						if(Businesses[i][Locked] == 0)
						{
						    if(PlayerInfo[playerid][pSex] == 1)
						    {
								Businesses[i][Locked] = 1;
								SendClientMessage(playerid, COLOR_LIGHTYELLOW2,"[INFO:] Door Locked.");
			                    PlayerActionMessage(playerid,15.0,"puts in his key and locks the door.");
			                    SaveBusinesses();
		                    }
		                    else
						    {
								Businesses[i][Locked] = 1;
								SendClientMessage(playerid, COLOR_LIGHTYELLOW2,"[INFO:] Door Locked.");
			                    PlayerActionMessage(playerid,15.0,"puts in her key and locks the door.");
			                    SaveBusinesses();
		                    }
							return 1;
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2,"[ERROR:] You don't have a key for this business!");
						return 1;
					}
				}
			}
	    }
	    return 1;
	}
 	if(strcmp(cmd, "/renthouse", true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
			new Float:oldposx, Float:oldposy, Float:oldposz;
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			GetPlayerPos(playerid, oldposx, oldposy, oldposz);
			for(new h = 0; h < sizeof(Houses); h++)
			{
				if(PlayerToPoint(2.0, playerid, Houses[h][EnterX], Houses[h][EnterY], Houses[h][EnterZ]) && Houses[h][Owned] == 1 &&  Houses[h][Rentable] == 1)
				{
					if(PlayerInfo[playerid][pHouseKey] != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You already own a house!");
						return 1;
					}
					if(GetPlayerCash(playerid) >= Houses[h][RentCost])
					{
						PlayerInfo[playerid][pHouseKey] = h;
						GivePlayerCash(playerid,-Houses[h][RentCost]);
						Houses[h][Money] = Houses[h][Money]+Houses[h][RentCost];
						SetPlayerInterior(playerid,Houses[h][ExitInterior]);
						SetPlayerPos(playerid,Houses[h][ExitX],Houses[h][ExitY],Houses[h][ExitZ]);
						SetPlayerVirtualWorld(playerid,h);
						SendClientMessage(playerid, COLOR_GREEN, "[INFO:] House successfully rented, the money you paid is a one time fee.");
						OnPlayerDataSave(playerid);
						return 1;
					}
					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INFO:] You can't afford it!");
						return 1;
					}
				}
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/rentfee", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			new bouse = PlayerInfo[playerid][pHouseKey];
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			if (bouse != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /rentfee [amount]");
					return 1;
				}
				if(strval(tmp) < 1 || strval(tmp) > 99999)
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Please enter an amount between $1-99999.");
					return 1;
				}
				Houses[bouse][RentCost] = strval(tmp);
				SaveHouses();
				format(string, sizeof(string), "[INFO:] You have set the rent fee to: $%d", Houses[bouse][RentCost]);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				return 1;
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't even own a house!");
				return 1;
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/editrenting", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			if (PlayerInfo[playerid][pHouseKey] != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
			{
				if(Houses[PlayerInfo[playerid][pHouseKey]][Rentable] == 0)
				{
    				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INFO:] Renting enabled.");
				    Houses[PlayerInfo[playerid][pHouseKey]][Rentable] = 1;
				    SaveHouses();
				}
				else if(Houses[PlayerInfo[playerid][pHouseKey]][Rentable] == 1)
				{
    				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INFO:] Renting disabled.");
				    Houses[PlayerInfo[playerid][pHouseKey]][Rentable] = 0;
				    SaveHouses();
				}
				return 1;
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "   You don't own a house !");
				return 1;
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/buyhouse", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new Float:oldposx, Float:oldposy, Float:oldposz;
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			GetPlayerPos(playerid, oldposx, oldposy, oldposz);
			for(new h = 0; h < sizeof(Houses); h++)
			{
				if(PlayerToPoint(2.0, playerid, Houses[h][EnterX], Houses[h][EnterY], Houses[h][EnterZ]) && Houses[h][Owned] == 0)
				{
				    if(Houses[h][HousePrice] == 0)
				    {
				        SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] A price isn't set for this house, it's possibly not ment to be used.");
						return 1;
				    }
					if(PlayerInfo[playerid][pHouseKey] != 255 && strcmp(playername, Houses[PlayerInfo[playerid][pHouseKey]][Owner], true) == 0)
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can only own one house, please sell your original house first.");
						return 1;
					}
					if(GetPlayerCash(playerid) > Houses[h][HousePrice])
					{
      					PlayerInfo[playerid][pHouseKey] = h;
						Houses[h][Owned] = 1;
						strmid(Houses[h][Owner], playername, 0, strlen(playername), 255);
						GivePlayerCash(playerid,-Houses[h][HousePrice]);
						SetPlayerInterior(playerid,Houses[h][ExitInterior]);
						SetPlayerVirtualWorld(playerid,h);
						SetPlayerPos(playerid,Houses[h][ExitX],Houses[h][ExitY],Houses[h][ExitZ]);
						SendClientMessage(playerid, COLOR_WHITE, "[INFO:] You have successfully purchased this property!");
	       				PlayerActionMessage(playerid,15.0,"hands a package full of money to the estate agent, who then give returns with a key.");
						ChangeStreamPickupModel(Houses[h][PickupID],1239);
						SaveHouses();
						OnPlayerDataSave(playerid);
						return 1;
					}
					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money!");
						return 1;
					}
				}
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/businessfee", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			new bouse = PlayerInfo[playerid][pBizKey];
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid,playername,sizeof(playername));
			if (bouse != 255 && strcmp(playername, Businesses[PlayerInfo[playerid][pBizKey]][Owner], true) == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /businessfee [amount]");
				}
				if(strval(tmp) < 0 || strval(tmp) > 99999)
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Minimum entrance is fee $0, Maximum entrance is fee $99999.");
					return 1;
				}
				Businesses[bouse][EntranceCost] = strval(tmp);
				format(string, sizeof(string), "[INFO:] Business Entrance fee set to $%d.", Businesses[bouse][EntranceCost]);
				SendClientMessage(playerid, COLOR_WHITE, string);
				SaveBusinesses();
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't even own a business!");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/businessname", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			new bouse = PlayerInfo[playerid][pBizKey];
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid,playername,sizeof(playername));
			if (bouse != 255 && strcmp(playername, Businesses[PlayerInfo[playerid][pBizKey]][Owner], true) == 0)
			{
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[64];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /businessname [name]");
				}
				if(PlayerToPoint(1.0,playerid,Businesses[bouse][EnterX],Businesses[bouse][EnterY],Businesses[bouse][EnterZ]) || PlayerToPoint(25.0,playerid,Businesses[bouse][ExitX],Businesses[bouse][ExitY],Businesses[bouse][ExitZ]))
				{
				    if(strfind( result , "|" , true ) == -1)
				    {
						strmid(Businesses[bouse][BusinessName], result, 0, 64, 255);
						format(string, sizeof(string), "[INFO:} You have set your business name to: %s.",Businesses[bouse][BusinessName]);
						SendClientMessage(playerid, COLOR_WHITE, string);
						SaveBusinesses();
					}
					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Symbol, the symbol | is not allowed.");
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You must be at your business entrance/inside your business to change it's name!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't even own a business!");
			}
		}
		return 1;
	}
 	if (strcmp(cmd, "/businessinfo", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			new bouse = PlayerInfo[playerid][pBizKey];
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid,playername,sizeof(playername));
			if(bouse != 255 && strcmp(playername, Businesses[PlayerInfo[playerid][pBizKey]][Owner], true) == 0)
			{
 				if(PlayerToPoint(1.0,playerid,Businesses[bouse][EnterX],Businesses[bouse][EnterY],Businesses[bouse][EnterZ]) || PlayerToPoint(20.0,playerid,Businesses[bouse][ExitX],Businesses[bouse][ExitY],Businesses[bouse][ExitZ]))
				{
					format(string, sizeof(string), "[INFO:] Business Name: %s - Till: $%d - Locked: %d - Products: %d - Entrance Fee: $%d.", Businesses[bouse][BusinessName],Businesses[bouse][Till],Businesses[bouse][Locked],Businesses[bouse][Products],Businesses[bouse][EntranceCost]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					return 1;
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not in your business!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't even own a business!");
			}
		}
		return 1;
	}
  	if(strcmp(cmd, "/sellbusiness", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			if(PlayerInfo[playerid][pBizKey] != 255 && strcmp(playername, Businesses[PlayerInfo[playerid][pBizKey]][Owner], true) == 0)
			{
			    new biz = PlayerInfo[playerid][pBizKey];
				if(PlayerToPoint(1.0,playerid,Businesses[biz][EnterX],Businesses[biz][EnterY],Businesses[biz][EnterZ]))
				{
					Businesses[biz][Locked] = 1;
					Businesses[biz][Owned] = 0;
					strmid(Businesses[biz][Owner], "None", 0, strlen("None"), 255);
					GivePlayerCash(playerid,Businesses[biz][BizPrice]);
					format(string, sizeof(string), "[INFO:] You have sold your business for $%d.", Businesses[biz][BizPrice]);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					ChangeStreamPickupModel(Businesses[biz][PickupID],1272);
					PlayerInfo[playerid][pBizKey] = 255;
					OnPlayerDataSave(playerid);
  					PlayerActionMessage(playerid,15.0,"tears up the business contract, and then gives away the key.");
					SaveBusinesses();
					return 1;
				}
				else
				{
				    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You must be at your business entrance to sell it!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't even own a business!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/buybusiness", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new Float:oldposx, Float:oldposy, Float:oldposz;
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			GetPlayerPos(playerid, oldposx, oldposy, oldposz);
			for(new h = 0; h < sizeof(Businesses); h++)
			{
				if(PlayerToPoint(2.0, playerid, Businesses[h][EnterX], Businesses[h][EnterY], Businesses[h][EnterZ]) && Businesses[h][Owned] == 0)
				{
				    if(Businesses[h][BizPrice] == 0)
				    {
				        SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] A price isn't set for this business, it's possibly not ment to be used.");
						return 1;
				    }
					if(PlayerInfo[playerid][pBizKey] != 255 && strcmp(playername, Businesses[PlayerInfo[playerid][pBizKey]][Owner], true) == 0)
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can only own one business, sell your original business first!");
						return 1;
					}
					if(GetPlayerCash(playerid) > Businesses[h][BizPrice])
					{
						PlayerInfo[playerid][pBizKey] = h;
						Businesses[h][Owned] = 1;
						strmid(Businesses[h][Owner], playername, 0, strlen(playername), 255);
						GivePlayerCash(playerid,-Businesses[h][BizPrice]);
						SetPlayerInterior(playerid,Businesses[h][ExitInterior]);
						SetPlayerVirtualWorld(playerid,h);
						SetPlayerPos(playerid,Businesses[h][ExitX],Businesses[h][ExitY],Businesses[h][ExitZ]);
						SendClientMessage(playerid, COLOR_WHITE, "[INFO:] You have successfully purchased this business!");
	       				PlayerActionMessage(playerid,15.0,"takes out some money and signs a contract, then recieves a key.");
						ChangeStreamPickupModel(Businesses[h][PickupID],1239);
						SaveBusinesses();
						OnPlayerDataSave(playerid);
						return 1;
					}
					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have enough money!");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/takedrivingtest", true) == 0)
	{
		if(PlayerToPoint(1.0,playerid,DrivingTestPosition[X],DrivingTestPosition[Y],DrivingTestPosition[Z]))
		{
		    if(PlayerInfo[playerid][pCarLic] == 0)
		    {
				if(GetPlayerCash(playerid) >= 500)
				{
					GivePlayerCash(playerid,-500);
					SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] Your driving test has started, go outside and get in a car!");
					TakingDrivingTest[playerid] = 1;
				}
				else
				{
					SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You don't have enough money!");
				}
			}
			else
			{
				SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You already have a license!");
			}
		}
		else
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You are not at the driving school!");
		}
		return 1;
	}
 	if(strcmp(cmd, "/buyflyinglicense", true) == 0)
	{
		if(PlayerToPoint(1.0,playerid,FlyingTestPosition[X],FlyingTestPosition[Y],FlyingTestPosition[Z]))
		{
		    if(GetPlayerVirtualWorld(playerid) == FlyingTestPosition[World])
		    {
		        if(PlayerInfo[playerid][pFlyLic] == 0)
		        {
					if(GetPlayerCash(playerid) >= 20000)
					{
						GivePlayerCash(playerid,-20000);
						SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] You can now fly planes!");
						PlayerInfo[playerid][pFlyLic] = 1;
						OnPlayerDataSave(playerid);
					}
					else
					{
						SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You don't have enough money!");
					}
				}
				else
				{
					SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You already have a license!");
				}
			}
		}
		else
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You are not at the license location!");
		}
		return 1;
	}
  	if(strcmp(cmd, "/buyweaponlicense", true) == 0)
	{
		if(PlayerToPoint(1.0,playerid,WeaponLicensePosition[X],WeaponLicensePosition[Y],WeaponLicensePosition[Z]))
		{
		    if(GetPlayerVirtualWorld(playerid) == WeaponLicensePosition[World])
		    {
		        if(PlayerInfo[playerid][pWepLic] == 0)
		        {
					if(GetPlayerCash(playerid) >= 50000)
					{
						GivePlayerCash(playerid,-50000);
						SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] You can now use weapons legally, within reason of course.");
						PlayerInfo[playerid][pWepLic] = 1;
						OnPlayerDataSave(playerid);
					}
					else
					{
						SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You don't have enough money!");
					}
				}
				else
				{
					SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You already have a license!");
				}
			}
		}
		else
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You are not at the license location!");
		}
		return 1;
	}
	if(strcmp(cmd, "/refuel", true) == 0)
	{
		if(IsAtGasStation(playerid))
		{
			new vehicle = GetPlayerVehicleID(playerid);
			new refillprice;
			if(Fuel[vehicle] <= 30)
			{
				refillprice = random(100);
			}
			else if(Fuel[vehicle] >= 40)
			{
				refillprice = random(70);
			}
			else if(Fuel[vehicle] >= 55)
			{
				refillprice = random(40);
			}
   			if(GetPlayerCash(playerid) >= refillprice)
   			{
   			    if(Fuel[vehicle] <= 99)
   			    {
	      			new form[128];
		        	format(form, sizeof(form), "[INFO:] Your car has been refueled for $%d, have a nice day.",refillprice);
		        	SendClientMessage(playerid,COLOR_LIGHTBLUE,form);
			        GivePlayerCash(playerid,-refillprice);
			        Fuel[vehicle] = 100;
		        }
		        else
		        {
		        	SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] Your fuel is full!");
		        }
		    }
      		else
      		{
       			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You don't have enough money!");
      		}
		}
		else
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You are not at a Gas Station!");
		}
 		return 1;
	}
	if(strcmp(cmd, "/stats", true) == 0)
	{
		ShowStats(playerid,playerid);
		return 1;
	}
	if(strcmp(cmd, "/spawnpoint", true) == 0)
	{
		if(PlayerInfo[playerid][pSpawnPoint] == 1)
		{
		    PlayerInfo[playerid][pSpawnPoint] = 0;
   		 	SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INFO:] You will now spawn at your normal place.");
		}
		else
		{
			PlayerInfo[playerid][pSpawnPoint] = 1;
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[INFO:] You will now spawn at your home.");
		}
		return 1;
	}
	if(strcmp(cmd, "/afactioncmds", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 5:] - /afactionkick");
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 10:] - /afactioncolor - /afactionspawn - /afactionname - /afactionuseskins - /afactionrankamount - /afactiontype");
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 10:] - /afactionjoinrank - /afactiondrugs - /afactionbank - /afactionmats - /afactionskin");
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 10:] - /afactionrankname - /agotofaction - /afactionusecolor - /afactiondrugsstorage - /afactionmatsstorage");
		}
		else
		{
			SendClientMessage(playerid,COLOR_RED,"[ERROR:] Your not an administrator!");
		}
		return 1;
	}
 	if(strcmp(cmd, "/abusinesscmds", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 7:] - /abusinessentrance - /abusinessexit - /abusinessprice - /agotobusiness - /abusinessproducts - /abusinesssell");
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 7:] - /abusinessint");
		}
		else
		{
			SendClientMessage(playerid,COLOR_RED,"[ERROR:] Your not an administrator!");
		}
		return 1;
	}
	if(strcmp(cmd, "/abuildingcmds", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 10:] - /abuildingname - /abuildingentrance - /abuildingexit - /abuildingfee - /abuildinglock - /agotobuilding");
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 10:] - /abuildingint");
		}
		else
		{
			SendClientMessage(playerid,COLOR_RED,"[ERROR:] Your not an administrator!");
		}
		return 1;
	}
 	if(strcmp(cmd, "/ajobcmds", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 20)
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[GUN JOB:] /agunjobpos (/takejob) - /agunjobpos2 (/materials buy) - /agunjobpos3 (/materials dropoff) ");
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[DRUG JOB:] /adrugjobpos (/takejob) - /adrugjobpos2 (/drugs buy) - /agunjobpos3 (/drugs dropoff) ");
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[DETECTIVE JOB:] /adetectivejobpos (/takejob) ");
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[LAWYER JOB:] /alawyerjobpos (/takejob");
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[PRODUCTS SELLER JOB:] /aproductjobpos (/takejob) - /aproductjobpos2 (/products buy)");
		}
		else
		{
			SendClientMessage(playerid,COLOR_RED,"[ERROR:] Your not an administrator!");
		}
		return 1;
	}
 	if(strcmp(cmd, "/housecmds", true) == 0)
	{
		SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[House:] /enter - /exit - /buyhouse - /sellhouse - /editrenting - /rentfee - /renthouse - /openhouse - /housewithdraw - /housedeposit");
		SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[House:] /housematsput - /housematstake - /housedrugsput - /housedrugstake");
		return 1;
	}
	if(strcmp(cmd, "/factioncmds", true) == 0)
	{
	    if(PlayerInfo[playerid][pFaction] != 255)
	    {
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Faction:] /f(action) - /fcheckmats - /fcheckdrugs - /factionmatsput - /factionmatstake - /factiondrugsput - /factiondrugstake");
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Faction:] /fwithdraw - /fdeposit - /fbalance");
		}
		else
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] Invalid Faction.");
		}
		return 1;
	}
 	if(strcmp(cmd, "/leadercmds", true) == 0)
	{
	    if(PlayerInfo[playerid][pFaction] != 255 && PlayerInfo[playerid][pRank] == 1)
	    {
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Leader:] /invite - /uninvite - /setrank");
		}
		else
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] Your not a leader!");
		}
		return 1;
	}
	if(strcmp(cmd, "/phonecmds", true) == 0)
	{
		SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Phone:] /buyphone - /call - /answer - /hangup - /speakerphone - /txt - /phonebook");
		return 1;
	}
	if(strcmp(cmd, "/businesscmds", true) == 0)
	{
		SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Business:] /buybusiness - /sellbusiness - /businessinfo - /businessfee - /businessname - /openbusiness");
		SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Business:] /businessdeposit - /businesswithdraw");
		return 1;
	}
	if(strcmp(cmd, "/acarcmds", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 5:] - /acarpark - /acarmodel - /acarcolor - /acarfaction - /acarenter - /acartype - /acarsetpos");
		}
		else
		{
			SendClientMessage(playerid,COLOR_RED,"[ERROR:] Your not an administrator!");
		}
		return 1;
	}
 	if(strcmp(cmd, "/ahousecmds", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 7:] - /ahouseentrance - /ahouseexit - /ahousedescription - /agotohouse - /ahouseprice - /ahousesell - /ahouseint");
		}
		else
		{
			SendClientMessage(playerid,COLOR_RED,"[ERROR:] Your not an administrator!");
		}
		return 1;
	}
	if(strcmp(cmd, "/apositioncmds", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 1:] - [TELEPORTS] /agotobuilding - /agotohouse - /agotobusiness - /agotofmatsstorage - /agotofdrugsstorage");
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 1:] - [TELEPORTS] /agotodrivingtestpos - /agotoflyingtestpos - /agotobank - /agotoweaponlicpos - /agotopolicearrestpos");
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 1:] - [TELEPORTS] /agotopolicedutypos");
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 10:] - adrivingtestpos - /aflyingtestpos - /abankpos - /aweaponlicensepos - /apolicearrestpos - /apolicedutypos");
		}
		else
		{
			SendClientMessage(playerid,COLOR_RED,"[ERROR:] Your not an administrator!");
		}
		return 1;
	}
 	if(strcmp(cmd, "/gooc", true) == 0 || strcmp(cmd, "/go", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if ((OOCStatus) == 0 && PlayerInfo[playerid][pAdmin] < 1)
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Global OOC is currently disabled.");
				return 1;
			}
			if(Muted[playerid])
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can't speak, your muted!");
				return 1;
			}
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] [/go]oc [message]");
				return 1;
			}
			if(PlayerInfo[playerid][pAdmin] >= 1 && AdminDuty[playerid] == 1)
			{
				format(string, sizeof(string), "(( [G-OOC:] Admin %s: %s ))", GetPlayerNameEx(playerid), result);
				SendClientMessageToAll(COLOR_ADMINDUTY,string);
				OOCLog(string);
				return 1;
			}
			else if(PlayerInfo[playerid][pDonator] == 1)
			{
				format(string, sizeof(string), "(( [G-OOC:] Donator %s: %s ))", GetPlayerNameEx(playerid), result);
				SendClientMessageToAll(COLOR_NEWOOC,string);
				OOCLog(string);
			}
			else
			{
				format(string, sizeof(string), "(( [G-OOC:] %s: %s ))", GetPlayerNameEx(playerid), result);
				SendClientMessageToAll(COLOR_NEWOOC,string);
				OOCLog(string);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/eject", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
	        new State;
	        if(IsPlayerInAnyVehicle(playerid))
	        {
         		State=GetPlayerState(playerid);
		        if(State!=PLAYER_STATE_DRIVER)
		        {
		        	SendClientMessage(playerid,COLOR_GREY,"[ERROR:] You can only eject a user as the driver!");
		            return 1;
		        }
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /eject [playerid/PartOfName]");
					return 1;
				}
				new playa;
				playa = ReturnUser(tmp);
				new test;
				test = GetPlayerVehicleID(playerid);
				if(IsPlayerConnected(playa))
				{
				    if(playa != INVALID_PLAYER_ID)
				    {
				        if(playa == playerid) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You can't eject yourself!"); return 1; }
				        if(IsPlayerInVehicle(playa,test))
				        {
							format(string, sizeof(string), "[INFO:] You have thrown out: %s.", GetPlayerNameEx(playa));
							SendClientMessage(playerid, COLOR_WHITE, string);
							format(string, sizeof(string), "[INFO:] You have been thrown out of the car by: %s.", GetPlayerNameEx(playerid));
							SendClientMessage(playa, COLOR_WHITE, string);
							RemovePlayerFromVehicle(playa);
						}
						else
						{
						    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] That user is not even in your car!");
						    return 1;
						}
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You are not in a vehicle!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/adminduty", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			new faction = PlayerInfo[playerid][pFaction];
		    if(AdminDuty[playerid] == 1)
		    {
			    format(string, sizeof(string), "[ADMIN:] %s (ID:%d) is now off duty.", GetPlayerNameEx(playerid),playerid);
				SendClientMessageToAll(COLOR_ADMINDUTY,string);
				AdminDuty[playerid] = 0;
				SetPlayerHealth(playerid,100);
				SetPlayerArmour(playerid,0);
				
			    if(PlayerInfo[playerid][pFaction] != 255)
			    {
		    		if(DynamicFactions[faction][fUseColor])
		    		{
		    			SetPlayerToFactionColor(playerid);//Setting the players color.
		    		}
        			else
			     	{
			     	    SetPlayerColor(playerid,COLOR_CIVILIAN);
			     	}
		     	}
		     	else
		     	{
		     	    SetPlayerColor(playerid,COLOR_CIVILIAN);
		     	}
		    }
		    else
		    {
		    	format(string, sizeof(string), "[ADMIN:] %s (ID:%d) is now an on duty administrator.", GetPlayerNameEx(playerid),playerid);
				SendClientMessageToAll(COLOR_ADMINDUTY,string);
				AdminDuty[playerid] = 1;
				SetPlayerColor(playerid,COLOR_ADMINDUTY);
				SetPlayerHealth(playerid,99999);
				SetPlayerArmour(playerid,99999);
		    }
		}
		else
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] Your not an administrator.");
		}
		return 1;
	}
 	if (strcmp(cmd, "/check", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /check [playerid]");
					return 1;
				}
	            giveplayerid = ReturnUser(tmp);
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						ShowStats(playerid,giveplayerid);
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/donate", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /donate [amount]");
				return 1;
			}
			new moneys;
			moneys = strval(tmp);
			if(moneys < 0)
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid Amount.");
				return 1;
			}
			if(GetPlayerCash(playerid) < moneys)
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You don't have that much!");
				return 1;
			}
			GivePlayerCash(playerid, -moneys);
			format(string, sizeof(string), "[INFO:] %s has donated $%d.",GetPlayerNameEx(playerid), moneys);
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, string);
			PayLog(string);
		}
		return 1;
	}
 	if(strcmp(cmd, "/up", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz+2);
				return 1;
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/mute", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /mute [playerid]");
				return 1;
			}
			new playa;
			playa = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						if(Muted[playerid] == 0)
						{
							Muted[playerid] = 1;
							format(string, sizeof(string), "[INFO:] You muted %s.",GetPlayerNameEx(playa));
							SendClientMessage(playerid,COLOR_ADMINCMD,string);
							format(string, sizeof(string), "[INFO:] You have been muted by %s.",GetPlayerNameEx(playerid));
							SendClientMessage(playa,COLOR_ADMINCMD,string);
						}
						else
						{
							Muted[playerid] = 0;
							format(string, sizeof(string), "[INFO:] You unmuted %s.",GetPlayerNameEx(playa));
							SendClientMessage(playerid,COLOR_ADMINCMD,string);
							format(string, sizeof(string), "[INFO:] You have been unmuted by %s.",GetPlayerNameEx(playerid));
							SendClientMessage(playa,COLOR_ADMINCMD,string);
						}
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/warn", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /warn [playerid] [reason]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
			    if(IsPlayerConnected(giveplayerid))
			    {
			        if(giveplayerid != INVALID_PLAYER_ID)
			        {
						new length = strlen(cmdtext);
						while ((idx < length) && (cmdtext[idx] <= ' '))
						{
							idx++;
						}
						new offset = idx;
						new result[128];
						while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
						{
							result[idx - offset] = cmdtext[idx];
							idx++;
						}
						result[idx - offset] = EOS;
						if(!strlen(result))
						{
							SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /warn [playerid] [reason]");
							return 1;
						}
						PlayerInfo[giveplayerid][pWarnings] += 1;
						if(PlayerInfo[giveplayerid][pWarnings] >= 5)
						{
							format(string, sizeof(string), "[BAN:] %s has just been banned, had 5+ warnings.", GetPlayerNameEx(giveplayerid));
							BanLog(string);
							BanPlayerAccount(giveplayerid,GetPlayerNameEx(playerid),(result));
							return 1;
						}
						format(string, sizeof(string), "[INFO:] You warned %s, reason: %s.", GetPlayerNameEx(giveplayerid), (result));
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, string);
						format(string, sizeof(string), "[INFO:] You where warned by %s, reason: %s.", GetPlayerNameEx(playerid), (result));
						SendClientMessage(giveplayerid, COLOR_LIGHTYELLOW2, string);
						return 1;
					}
				}//not connected
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Invalid ID.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/goto", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /goto [playerid]");
				return 1;
			}
			new Float:plocx,Float:plocy,Float:plocz;
			new plo;
			plo = ReturnUser(tmp);
			if (IsPlayerConnected(plo))
			{
			    if(plo != INVALID_PLAYER_ID)
			    {
					if (PlayerInfo[playerid][pAdmin] >= 1)
					{
						GetPlayerPos(plo, plocx, plocy, plocz);
						new interior = GetPlayerInterior(plo);
						new world = GetPlayerVirtualWorld(plo);
						
						if (GetPlayerState(playerid) == 2)
						{
							new tmpcar = GetPlayerVehicleID(playerid);
							SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
							SetPlayerVirtualWorld(playerid,world);
							SetPlayerInterior(playerid,interior);
						}
						else
						{
							SetPlayerPos(playerid,plocx,plocy+2, plocz);
							SetPlayerVirtualWorld(playerid,world);
							SetPlayerInterior(playerid,interior);
						}
						format(string, sizeof(string), "[INFO:] You teleported to %s.", GetPlayerNameEx(plo));
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, string);
					}
					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "[ERROR:] Invalid ID.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/gotols", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(PlayerInfo[playerid][pAdmin] >= 1)
			{
				if (GetPlayerState(playerid) == 2)
				{
					new tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 1529.6,-1691.2,13.3);
				}
				else
				{
					SetPlayerPos(playerid, 1529.6,-1691.2,13.3);
				}
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/gotolv", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				if (GetPlayerState(playerid) == 2)
				{
					new tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 1699.2, 1435.1, 10.7);
				}
				else
				{
					SetPlayerPos(playerid, 1699.2,1435.1, 10.7);
				}
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/gotosf", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				if (GetPlayerState(playerid) == 2)
				{
					new tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, -1417.0,-295.8,14.1);
				}
				else
				{
					SetPlayerPos(playerid, -1417.0,-295.8,14.1);
				}
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
  	if(strcmp(cmd, "/gethere", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /gethere [playerid]");
				return 1;
			}
			new Float:plocx,Float:plocy,Float:plocz;
			new plo;
			plo = ReturnUser(tmp);
			if (IsPlayerConnected(plo))
			{
			    if(plo != INVALID_PLAYER_ID)
			    {
					if (PlayerInfo[playerid][pAdmin] >= 1)
					{
						GetPlayerPos(playerid, plocx, plocy, plocz);
						new interior = GetPlayerInterior(playerid);
						new world = GetPlayerVirtualWorld(playerid);

						if (GetPlayerState(playerid) == 2)
						{
							new tmpcar = GetPlayerVehicleID(plo);
							SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
							SetPlayerVirtualWorld(plo,world);
							SetPlayerInterior(plo,interior);
						}
						else
						{
							SetPlayerPos(plo,plocx,plocy+2, plocz);
							SetPlayerVirtualWorld(plo,world);
							SetPlayerInterior(plo,interior);
						}
						format(string, sizeof(string), "[INFO:] You teleported %s to you.", GetPlayerNameEx(plo));
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, string);
					}
					else
					{
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
					}
				}
			}
			else
			{
				format(string, sizeof(string), "   %d is not an active player.", plo);
				SendClientMessage(playerid, COLOR_GRAD1, string);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/freeze", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /freeze [playerid]");
				return 1;
			}
			new playa;
			playa = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 2)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						TogglePlayerControllable(playa, 0);
						format(string, sizeof(string), "[INFO:] You where froze by %s.",GetPlayerNameEx(playerid));
						SendClientMessage(playa,COLOR_LIGHTYELLOW2,string);
						format(string, sizeof(string), "[INFO:] You froze %s.",GetPlayerNameEx(playa));
						SendClientMessage(playerid,COLOR_LIGHTYELLOW2,string);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/unfreeze", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /unfreeze [playerid]");
				return 1;
			}
			new playa;
			playa = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						TogglePlayerControllable(playa, 1);
						format(string, sizeof(string), "[INFO:] You where unfroze by %s.",GetPlayerNameEx(playerid));
						SendClientMessage(playa,COLOR_LIGHTYELLOW2,string);
						format(string, sizeof(string), "[INFO:] You unfroze %s.",GetPlayerNameEx(playa));
						SendClientMessage(playerid,COLOR_LIGHTYELLOW2,string);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/gametext", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[64];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /gametext [textformat ~n~=Newline ~r~=Red ~g~=Green ~b~=Blue ~w~=White ~y~=Yellow]");
					return 1;
				}
				format(string, sizeof(string), "~b~%s: ~w~%s",GetPlayerNameEx(playerid),result);
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						GameTextForPlayer(i, string, 5000, 6);
					}
				}
				return 1;
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator!");
				return 1;
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/ajail", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /ajail [playerid] [minutes]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 2)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						format(string, sizeof(string), "[INFO:] You jailed %s.", GetPlayerNameEx(playa));
						SendClientMessage(playerid, COLOR_LIGHTYELLOW2, string);
						format(string, sizeof(string), "[INFO:] You where jailed by %s for %d minutes.", GetPlayerNameEx(playerid),money);
						SendClientMessage(playa, COLOR_LIGHTYELLOW2, string);
						ResetPlayerWeapons(playa);
						WantedPoints[playa] = 0;
						PlayerInfo[playa][pJailed] = 1;
						PlayerInfo[playa][pJailTime] = money*60;
						SetPlayerInterior(playa, 6);
						SetPlayerPos(playa, 264.6288,77.5742,1001.0391);
						SetPlayerVirtualWorld(playerid,2);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
 	if (strcmp(cmd, "/logoutall", true) ==0 )
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						OnPlayerDataSave(i);
						gPlayerLogged[i] = 0;
					}
				}
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[SUCCESS:] All players logged out.");
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/unknowngametext", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
				tmp = strtok(cmdtext, idx);
				new txtid;
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /unknowngametext ");
					return 1;
				}
				txtid = strval(tmp);
				if(txtid == 2)
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:]");
					return 1;
				}
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[128];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
					SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /unknowngametext <type> [cnnc textformat ~n~=Newline ~r~=Red ~g~=Green ~b~=Blue ~w~=White ~y~=Yellow]");
					return 1;
				}
				format(string, sizeof(string), "~w~%s",result);
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i) == 1)
					{
						GameTextForPlayer(i, string, 5000, txtid);
					}
				}
				return 1;
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator!");
				return 1;
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/fixveh", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pAdmin] >= 1)
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
				    SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.0);
				}
   				return 1;
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/money", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /money [playerid] [money]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 5)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						SetPlayerCash(playa, money);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/agiveproducts", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /agiveproducts [playerid] [products]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 4)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						PlayerInfo[playerid][pProducts] += money;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/asetproducts", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /asetproducts [playerid] [products]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 4)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						PlayerInfo[playerid][pProducts] = money;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/agivemats", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /agivemats [playerid] [mats]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 4)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						PlayerInfo[playerid][pMaterials] += money;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/asetmats", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /asetmats [playerid] [mats]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 4)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						PlayerInfo[playerid][pMaterials] = money;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/asetdrugs", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /asetdrugs [playerid] [drugs]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 4)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						PlayerInfo[playerid][pDrugs] = money;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/agivedrugs", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /agivedrugs [playerid] [drugs]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 4)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						PlayerInfo[playerid][pDrugs] += money;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/givemoney", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /givemoney [playerid] [money]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 5)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						GivePlayerCash(playa, money);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/weatherall", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pAdmin] < 20)
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			    return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
			    SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /weatherall [weatherid]");
			    return 1;
			}
			new weather;
			weather = strval(tmp);
			if(weather < 0||weather > 45) { SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] 0-45."); return 1; }
			SetWeather(weather);
		}
		return 1;
	}
 	if(strcmp(cmd, "/sethp", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /sethp [playerid] [health]");
				return 1;
			}
			new playa;
			new health;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			health = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 4)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						SetPlayerHealth(playa, health);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/setarmour", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /setarmour [playerid] [armour]");
				return 1;
			}
			new playa;
			new health;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			health = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 4)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						SetPlayerArmour(playa, health);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/givegun", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /givegun [playerid/PartOfName] [weaponid] [ammo]");
				return 1;
			}
			new playa;
			new gun;
			new ammo;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			gun = strval(tmp);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "USAGE: /givegun [playerid/PartOfName] [weaponid] [ammo]");
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "3(Club) 4(knife) 5(bat) 6(Shovel) 7(Cue) 8(Katana) 10-13(Dildo) 14(Flowers) 16(Grenades) 18(Molotovs) 22(Pistol) 23(SPistol)");
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "24(Eagle) 25(shotgun) 29(MP5) 30(AK47) 31(M4) 33(Rifle) 34(Sniper) 37(Flamethrower) 41(spray) 42(exting) 43(Camera) 46(Parachute)");
				return 1;
			}
			if(gun > 1||gun < 47)
			{
			tmp = strtok(cmdtext, idx);
			ammo = strval(tmp);
			if(ammo <1||ammo > 999)
			{ SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Ammo must be , 1-999."); return 1; }
			if (PlayerInfo[playerid][pAdmin] >= 5)
			{
			    if(IsPlayerConnected(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						GivePlayerWeapon(playa, gun, ammo);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
			}
		}
		}
		return 1;
	}
	if(strcmp(cmd, "/fuelcars", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pAdmin] >= 4)
	        {
	            for(new c=0;c<MAX_VEHICLES;c++)
				{
					Fuel[c] = GasMax;
				}
				SendClientMessageToAll(COLOR_ADMINCMD, "[INFO:] All cars refueled by an administrator.");
	        }
	        else
	        {
	            SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
	            return 1;
	        }
	    }
	    return 1;
	}
 	if(strcmp(cmd, "/unlockcars", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pAdmin] >= 7)
	        {
	            for(new c=0;c<MAX_VEHICLES;c++)
				{
					VehicleLocked[c] = 0;
				}
				for(new i=0;i<MAX_PLAYERS;i++)
				{
				    if(IsPlayerConnected(i))
				    {
						VehicleLockedPlayer[i] = 999;
					}
				}
				SendClientMessageToAll(COLOR_ADMINCMD, "[INFO:] All cars unlocked by an administrator.");
	        }
	        else
	        {
	            SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator.");
	            return 1;
	        }
	    }
	    return 1;
	}
 	if(strcmp(cmd, "/setadmin", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /setadmin [playerid] [adminlevel]");
				return 1;
			}
			new para1;
			new level;
			para1 = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			level = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
			    if(IsPlayerConnected(para1))
			    {
			        if(para1 != INVALID_PLAYER_ID)
			        {
						PlayerInfo[para1][pAdmin] = level;
						format(string, sizeof(string), "[INFO:] %s has just made you administrator level: %d.", GetPlayerNameEx(playerid),level);
						SendClientMessage(para1, COLOR_WHITE, string);
						format(string, sizeof(string), "[INFO:] You have made %s an administrator - Level: %d.", GetPlayerNameEx(para1),level);
						SendClientMessage(playerid, COLOR_WHITE, string);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "[ERROR:] Your not an administrator/correct level.");
			}
		}
		return 1;
	}
 	if(strcmp(cmd, "/tod", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[USAGE:] /tod [timeofday] (0-23)");
				return 1;
			}
			new hour;
			hour = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 20)
			{
	            SetWorldTime(hour);
			}
			else
			{
				SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] Your not an administrator/correct level.");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/acommands", true) == 0 || strcmp(cmd, "/acmds", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 1:] - (/a)dmin - /goto - /gethere - /warn - /mute - /check - /adminduty - /kick - /asuicide - /aserverinfo - /apositioncmds - /up");
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 1:] - /freeze - /unfreeze - /gametext - /gotolv - /gotosf - /gotols - /fixveh");
		}
		if (PlayerInfo[playerid][pAdmin] >= 2)
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 2:] /ban - /banaccount - /oocstatus - /listenchat - /ajail");
		}
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 3:] /alistfaction");
		}
		if (PlayerInfo[playerid][pAdmin] >= 4)
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 4:] /sethp - /setarmour - /fuelcars - /agivedrugs - /asetdrugs - /agivemats - /asetmats - /agiveproducts - /asetproducts");
		}
		if (PlayerInfo[playerid][pAdmin] >= 5)
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 5:] /adonator - /acarcmds - /money - /givemoney - /givegun - /respawnvehicles");
		}
		if (PlayerInfo[playerid][pAdmin] >= 6)
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 6:] ");
		}
		if (PlayerInfo[playerid][pAdmin] >= 7)
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 7:] - /ahousecmds - /abusinesscmds - /unlockcars");
		}
		if (PlayerInfo[playerid][pAdmin] >= 8)
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 8:] ");
		}
		if (PlayerInfo[playerid][pAdmin] >= 9)
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 9:] ");
		}
		if (PlayerInfo[playerid][pAdmin] >= 10)
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Level 10:] - /logoutall - /unknowngametext - /abuildingcmds - /afactioncmds - /apositioncmds");
		}
		if (PlayerInfo[playerid][pAdmin] >= 20)
		{
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[Owner:] - /gmx - /setadmin - /asetleader - /aresetfaction - /acivilianspawn - /ajobcmds - /weatherall - /tod");
		}
		return 1;
	}
//==========================================[NORMAL COMMANDS]=========================================================
	if(strcmp(cmd, "/enter", true) == 0)
	{
		for(new i = 0; i < sizeof(Houses); i++)
		{
				if (PlayerToPoint(1.0, playerid,Houses[i][EnterX], Houses[i][EnterY], Houses[i][EnterZ]))
				{
				if(GetPlayerVirtualWorld(playerid) == Houses[i][EnterWorld])
			    {
					if(PlayerInfo[playerid][pHouseKey] == i || Houses[i][Locked] == 0 || PlayerInfo[playerid][pAdmin] >= 1)
					{
						SetPlayerInterior(playerid,Houses[i][ExitInterior]);
						SetPlayerPos(playerid,Houses[i][ExitX],Houses[i][ExitY],Houses[i][ExitZ]);
						SetPlayerVirtualWorld(playerid,i);
						SetPlayerFacingAngle(playerid,Houses[i][ExitAngle]);
					}
 					else
					{
						GameTextForPlayer(playerid, "~r~Locked", 5000, 1);
					}
				}
			}
		}
		for(new i = 0; i < sizeof(Building); i++)
		{
			if (PlayerToPoint(1.0, playerid,Building[i][EnterX], Building[i][EnterY], Building[i][EnterZ]))
			{
			    if(GetPlayerVirtualWorld(playerid) == Building[i][EnterWorld])
			    {
					if(Building[i][Locked] == 0 || PlayerInfo[playerid][pAdmin] >=  1)
					{
					    if(GetPlayerCash(playerid) >= Building[i][EntranceFee])
					    {
							SetPlayerInterior(playerid,Building[i][ExitInterior]);
							SetPlayerVirtualWorld(playerid,i);
							SetPlayerPos(playerid,Building[i][ExitX],Building[i][ExitY],Building[i][ExitZ]);
							SetPlayerFacingAngle(playerid,Building[i][ExitAngle]);
							GivePlayerCash(playerid,-Building[i][EntranceFee]);
						}
						else
						{
							GameTextForPlayer(playerid, "~r~You don't have enough money!", 5000, 1);
						}
					}
					else
					{
					GameTextForPlayer(playerid, "~r~Locked", 5000, 1);
					}
				}
			}
		}
		for(new i = 0; i < sizeof(Businesses); i++)
			{
				if (PlayerToPoint(1.0, playerid,Businesses[i][EnterX], Businesses[i][EnterY], Businesses[i][EnterZ]))
				{
				 	if(GetPlayerVirtualWorld(playerid) == Businesses[i][EnterWorld])
				    {
						if(PlayerInfo[playerid][pBizKey] == i || GetPlayerCash(playerid) >= Businesses[i][EntranceCost])
						{
							if(PlayerInfo[playerid][pBizKey] != i)
							{
								if(Businesses[i][Locked] == 1 && PlayerInfo[playerid][pAdmin] == 0)
								{
									GameTextForPlayer(playerid, "~r~Business Locked.", 5000, 1);
									return 1;
								}
								if(Businesses[i][Products] == 0)
								{
									GameTextForPlayer(playerid, "~r~No Products.", 5000, 1);
									return 1;
								}
								GivePlayerCash(playerid,-Businesses[i][EntranceCost]);
								format(string, sizeof(string), "[INFO:] You where charged $%d to enter %s.", Businesses[i][EntranceCost],Businesses[i][BusinessName]);
								SendClientMessage(playerid,COLOR_LIGHTYELLOW2,string);
								Businesses[i][Till] += Businesses[i][EntranceCost];
								Businesses[i][Products]--;
								SetPlayerInterior(playerid,Businesses[i][ExitInterior]);
								SetPlayerPos(playerid,Businesses[i][ExitX],Businesses[i][ExitY],Businesses[i][ExitZ]);
								SetPlayerVirtualWorld(playerid,i);
								SetPlayerFacingAngle(playerid,Businesses[i][ExitAngle]);
								SaveBusinesses();
							}
							else
							{
								SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] Free entrance for the boss.");
								SetPlayerInterior(playerid,Businesses[i][ExitInterior]);
								SetPlayerPos(playerid,Businesses[i][ExitX],Businesses[i][ExitY],Businesses[i][ExitZ]);
								SetPlayerVirtualWorld(playerid,i);
								SetPlayerFacingAngle(playerid,Businesses[i][ExitAngle]);
							}
						}
						else
						{
							SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[ERROR:] You don't have that much money!");
						}
					}
				}
			}
		return 1;
	}
	if(strcmp(cmd, "/exit", true) == 0)
	{
 		for(new i = 0; i < sizeof(Houses); i++)
		{
			if (PlayerToPoint(3.0, playerid,Houses[i][ExitX], Houses[i][ExitY], Houses[i][ExitZ]))
			{
   				if(GetPlayerVirtualWorld(playerid) == i)
			    {
			        if(Houses[i][Locked] == 0 || PlayerInfo[playerid][pAdmin] >=  1)
					{
						SetPlayerInterior(playerid,Houses[i][EnterInterior]);
						SetPlayerPos(playerid,Houses[i][EnterX],Houses[i][EnterY],Houses[i][EnterZ]);
						SetPlayerVirtualWorld(playerid,Houses[i][EnterWorld]);
						SetPlayerFacingAngle(playerid,Houses[i][EnterAngle]);
					}
					else
					{
						GameTextForPlayer(playerid, "~r~Door Locked.", 5000, 1);
					}
				}
			}
		}
		for(new i = 0; i < sizeof(Building); i++)
		{
			if (PlayerToPoint(3, playerid,Building[i][ExitX], Building[i][ExitY], Building[i][ExitZ]))
			{
			    if(GetPlayerVirtualWorld(playerid) == i)
			    {
					if(Building[i][Locked] == 0 || PlayerInfo[playerid][pAdmin] >=  1)
					{
						SetPlayerInterior(playerid,Building[i][EnterInterior]);
						SetPlayerVirtualWorld(playerid,Building[i][EnterWorld]);
						SetPlayerPos(playerid,Building[i][EnterX],Building[i][EnterY],Building[i][EnterZ]);
						SetPlayerFacingAngle(playerid,Building[i][EnterAngle]);
					}
					else
					{
						GameTextForPlayer(playerid, "~r~Door Locked.", 5000, 1);
					}
				}
			}
		}
  		for(new i = 0; i < sizeof(Businesses); i++)
		{
			if (PlayerToPoint(3, playerid,Businesses[i][ExitX], Businesses[i][ExitY], Businesses[i][ExitZ]))
			{
			    if(GetPlayerVirtualWorld(playerid) == i)
			    {
					if(Businesses[i][Locked] == 0 || PlayerInfo[playerid][pAdmin] >=  1)
					{
						SetPlayerInterior(playerid,Businesses[i][EnterInterior]);
						SetPlayerVirtualWorld(playerid,Businesses[i][EnterWorld]);
						SetPlayerPos(playerid,Businesses[i][EnterX],Businesses[i][EnterY],Businesses[i][EnterZ]);
						SetPlayerFacingAngle(playerid,Businesses[i][EnterAngle]);
					}
					else
					{
						GameTextForPlayer(playerid, "~r~Door Locked.", 5000, 1);
					}
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/time", true) == 0)
		{
		    if(IsPlayerConnected(playerid))
			{
			    new mtext[20];
				new year, month,day;
				getdate(year, month, day);
				if(month == 1) { mtext = "January"; }
				else if(month == 2) { mtext = "February"; }
				else if(month == 3) { mtext = "March"; }
				else if(month == 4) { mtext = "April"; }
				else if(month == 5) { mtext = "May"; }
				else if(month == 6) { mtext = "June"; }
				else if(month == 7) { mtext = "July"; }
				else if(month == 8) { mtext = "August"; }
				else if(month == 9) { mtext = "September"; }
				else if(month == 10) { mtext = "October"; }
				else if(month == 11) { mtext = "November"; }
				else if(month == 12) { mtext = "December"; }
			    new hour,minuite,second;
				gettime(hour,minuite,second);
				FixHour(hour);
				hour = shifthour;

				format(string, sizeof(string), "~y~%d %s~n~~g~|~w~%d:%d:%d~g~|", day, mtext, hour, minuite,second);
				GameTextForPlayer(playerid, string, 5000, 1);
			}
			return 1;
		}
	}
	else
	{
		SendClientMessage(playerid,COLOR_RED,"[INFO:] Your not logged in, therefore you can not use any commands.");
		SendClientMessage(playerid,COLOR_RED,"[INFO:] Type your password to register/login.");
		return 1;
	}
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"[INFO:] Invalid Command, type /commands for a list.");
	return 1;
}
public OnPlayerRegister(playerid, password[])
{
	if(IsPlayerConnected(playerid))
	{
			new string3[128];
			format(string3, sizeof(string3), "CRP_Scriptfiles/Accounts/%s.ini", PlayerName(playerid));
			new File: hFile = fopen(string3, io_write);
			if (hFile)
			{
			    strmid(PlayerInfo[playerid][pKey], password, 0, strlen(password), 255);
			    new var[32];
				format(var, 32, "Key=%s\n", PlayerInfo[playerid][pKey]);fwrite(hFile, var);
				PlayerInfo[playerid][pCash] = GetPlayerCash(playerid);
				format(var, 32, "Level=%d\n",PlayerInfo[playerid][pLevel]);fwrite(hFile, var);
				format(var, 32, "AdminLevel=%d\n",PlayerInfo[playerid][pAdmin]);fwrite(hFile, var);
				format(var, 32, "DonateRank=%d\n",PlayerInfo[playerid][pDonateRank]);fwrite(hFile, var);
				format(var, 32, "Registered=%d\n",PlayerInfo[playerid][pRegistered]);fwrite(hFile, var);
				format(var, 32, "Sex=%d\n",PlayerInfo[playerid][pSex]);fwrite(hFile, var);
				format(var, 32, "Age=%d\n",PlayerInfo[playerid][pAge]);fwrite(hFile, var);
				format(var, 32, "Experience=%d\n",PlayerInfo[playerid][pExp]);fwrite(hFile, var);
				format(var, 32, "Money=%d\n",PlayerInfo[playerid][pCash]);fwrite(hFile, var);
				format(var, 32, "Bank=%d\n",PlayerInfo[playerid][pBank]);fwrite(hFile, var);
				format(var, 32, "Skin=%d\n",PlayerInfo[playerid][pSkin]);fwrite(hFile, var);
				format(var, 32, "Drugs=%d\n",PlayerInfo[playerid][pDrugs]);fwrite(hFile, var);
				format(var, 32, "Materials=%d\n",PlayerInfo[playerid][pMaterials]);fwrite(hFile, var);
				format(var, 32, "Job=%d\n",PlayerInfo[playerid][pJob]);fwrite(hFile, var);
				format(var, 32, "PlayingHours=%d\n",PlayerInfo[playerid][pPlayingHours]);fwrite(hFile, var);
				format(var, 32, "AllowedPayday=%d\n",PlayerInfo[playerid][pAllowedPayday]);fwrite(hFile, var);
				format(var, 32, "PayCheck=%d\n",PlayerInfo[playerid][pPayCheck]);fwrite(hFile, var);
				format(var, 32, "Faction=%d\n",PlayerInfo[playerid][pFaction]);fwrite(hFile, var);
				format(var, 32, "Rank=%d\n",PlayerInfo[playerid][pRank]);fwrite(hFile, var);
				format(var, 32, "HouseKey=%d\n",PlayerInfo[playerid][pHouseKey]);fwrite(hFile, var);
				format(var, 32, "BizKey=%d\n",PlayerInfo[playerid][pBizKey]);fwrite(hFile, var);
				format(var, 32, "SpawnPoint=%d\n",PlayerInfo[playerid][pSpawnPoint]);fwrite(hFile, var);
				format(var, 32, "Banned=%d\n",PlayerInfo[playerid][pBanned]);fwrite(hFile, var);
				format(var, 32, "Warnings=%d\n",PlayerInfo[playerid][pWarnings]);fwrite(hFile, var);
				format(var, 32, "CarLic=%d\n",PlayerInfo[playerid][pCarLic]);fwrite(hFile, var);
				format(var, 32, "FlyLic=%d\n",PlayerInfo[playerid][pFlyLic]);fwrite(hFile, var);
				format(var, 32, "WepLic=%d\n",PlayerInfo[playerid][pWepLic]);fwrite(hFile, var);
				format(var, 32, "PhoneNumber=%d\n",PlayerInfo[playerid][pPhoneNumber]);fwrite(hFile, var);
				format(var, 32, "PhoneC=%d\n",PlayerInfo[playerid][pPhoneC]);fwrite(hFile, var);
				format(var, 32, "PhoneBook=%d\n",PlayerInfo[playerid][pPhoneBook]);fwrite(hFile, var);
				format(var, 32, "ListNumber=%d\n",PlayerInfo[playerid][pListNumber]);fwrite(hFile, var);
				format(var, 32, "Donator=%d\n",PlayerInfo[playerid][pDonator]);fwrite(hFile, var);
				format(var, 32, "Jailed=%d\n",PlayerInfo[playerid][pJailed]);fwrite(hFile, var);
				format(var, 32, "JailTime=%d\n",PlayerInfo[playerid][pJailTime]);fwrite(hFile, var);
				format(var, 32, "Products=%d\n",PlayerInfo[playerid][pProducts]);fwrite(hFile, var);
				format(var, 32, "CrashX=%f\n",PlayerInfo[playerid][pCrashX]);fwrite(hFile, var);
				format(var, 32, "CrashY=%f\n",PlayerInfo[playerid][pCrashY]);fwrite(hFile, var);
				format(var, 32, "CrashZ=%f\n",PlayerInfo[playerid][pCrashZ]);fwrite(hFile, var);
				format(var, 32, "CrashInt=%d\n",PlayerInfo[playerid][pCrashInt]);fwrite(hFile, var);
				format(var, 32, "CrashW=%d\n",PlayerInfo[playerid][pCrashW]);fwrite(hFile, var);
				format(var, 32, "Crashed=%d\n",PlayerInfo[playerid][pCrashed]);fwrite(hFile, var);
				fclose(hFile);
				SendClientMessage(playerid, COLOR_YELLOW2, "[INFO:] Registration successful.");
			}
	}
	return 1;
}
public OnPlayerLogin(playerid,password[])
{
    new string2[128];
	format(string2, sizeof(string2), "CRP_Scriptfiles/Accounts/%s.ini", PlayerName(playerid));
	new File: UserFile = fopen(string2, io_read);
	if ( UserFile )
	{
	    new PassData[256];
	    new keytmp[256], valtmp[256];
	    fread( UserFile , PassData , sizeof( PassData ) );
	    keytmp = ini_GetKey( PassData );
	    if( strcmp( keytmp , "Key" , true ) == 0 )
		{
			valtmp = ini_GetValue( PassData );
			strmid(PlayerInfo[playerid][pKey], valtmp, 0, strlen(valtmp)-1, 255);
		}
		if(strcmp(PlayerInfo[playerid][pKey],password, true ) == 0 )
		{
			    new key[ 256 ] , val[ 256 ];
			    new Data[ 256 ];
			    while ( fread( UserFile , Data , sizeof( Data ) ) )
				{
					key = ini_GetKey( Data );
					if( strcmp( key , "Level" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pLevel] = strval( val ); }
			    	if( strcmp( key , "AdminLevel" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pAdmin] = strval( val ); }
			        if( strcmp( key , "DonateRank" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pDonateRank] = strval( val ); }
			        if( strcmp( key , "Registered" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pRegistered] = strval( val ); }
					if( strcmp( key , "Sex" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pSex] = strval( val ); }
					if( strcmp( key , "Age" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pAge] = strval( val ); }
					if( strcmp( key , "Experience" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pExp] = strval( val ); }
					if( strcmp( key , "Money" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pCash] = strval( val ); }
					if( strcmp( key , "Bank" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pBank] = strval( val ); }
					if( strcmp( key , "Skin" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pSkin] = strval( val ); }
					if( strcmp( key , "Drugs" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pDrugs] = strval( val ); }
					if( strcmp( key , "Materials" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pMaterials] = strval( val ); }
					if( strcmp( key , "Job" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pJob] = strval( val ); }
					if( strcmp( key , "PlayingHours" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pPlayingHours] = strval( val ); }
					if( strcmp( key , "AllowedPayday" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pAllowedPayday] = strval( val ); }
					if( strcmp( key , "PayCheck" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pPayCheck] = strval( val ); }
					if( strcmp( key , "Faction" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pFaction] = strval( val ); }
					if( strcmp( key , "Rank" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pRank] = strval( val ); }
					if( strcmp( key , "HouseKey" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pHouseKey] = strval( val ); }
					if( strcmp( key , "BizKey" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pBizKey] = strval( val ); }
					if( strcmp( key , "SpawnPoint" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pSpawnPoint] = strval( val ); }
					if( strcmp( key , "Banned" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pBanned] = strval( val ); }
					if( strcmp( key , "Warnings" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pWarnings] = strval( val ); }
					if( strcmp( key , "CarLic" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pCarLic] = strval( val ); }
					if( strcmp( key , "FlyLic" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pFlyLic] = strval( val ); }
					if( strcmp( key , "WepLic" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pWepLic] = strval( val ); }
					if( strcmp( key , "PhoneNumber" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pPhoneNumber] = strval( val ); }
					if( strcmp( key , "PhoneC" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pPhoneC] = strval( val ); }
					if( strcmp( key , "PhoneBook" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pPhoneBook] = strval( val ); }
					if( strcmp( key , "ListNumber" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pListNumber] = strval( val ); }
					if( strcmp( key , "Donator" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pDonator] = strval( val ); }
					if( strcmp( key , "Jailed" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pJailed] = strval( val ); }
					if( strcmp( key , "JailTime" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pJailTime] = strval( val ); }
					if( strcmp( key , "Products" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pProducts] = strval( val ); }
					if( strcmp( key , "CrashX" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pCrashX] = floatstr( val ); }
					if( strcmp( key , "CrashY" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pCrashY] = floatstr( val ); }
					if( strcmp( key , "CrashZ" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pCrashZ] = floatstr( val ); }
					if( strcmp( key , "CrashInt" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pCrashInt] = strval( val ); }
					if( strcmp( key , "CrashW" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pCrashW] = strval( val ); }
					if( strcmp( key , "Crashed" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pCrashed] = strval( val ); }
                }
                fclose(UserFile);
		}
		else
		{
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "Incorrect password!");
	        fclose(UserFile);
	        return 1;
		}
	    if(PlayerInfo[playerid][pFaction] != 255)
	    {
    		if(DynamicFactions[PlayerInfo[playerid][pFaction]][fUseColor])
    		{
    			SetPlayerToFactionColor(playerid);
    		}
     	}
     	else
     	{
			SetPlayerColor(playerid,COLOR_CIVILIAN);
		}
		if(PlayerInfo[playerid][pBanned])
		{
		    KickPlayer(playerid,"System","Account Banned.");
		}
		if(PlayerInfo[playerid][pRegistered] == 0)
		{
			PlayerInfo[playerid][pLevel] = 1;
			PlayerInfo[playerid][pCash] = 2500;
			PlayerInfo[playerid][pBank] = 7500;
			PlayerInfo[playerid][pSkin] = 200;
			SetPlayerCash(playerid,PlayerInfo[playerid][pCash]);
			TogglePlayerControllable(playerid,0);
			SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] You have not yet set your age, set it now by typing ages between 16-100.");
			RegistrationStep[playerid] = 1;
		}
		SetPlayerCash(playerid,PlayerInfo[playerid][pCash]);
		SendClientMessage(playerid, COLOR_YELLOW2, "[INFO:] Successfully logged in.");
		gPlayerLogged[playerid] = 1;
		SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin],CivilianSpawn[X],CivilianSpawn[Y],CivilianSpawn[Z],0,0,0,0,0,0,0);
		SpawnPlayer(playerid);
	}
	return 1;
}
public OnPlayerDataSave(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(gPlayerLogged[playerid])
		{
			new string3[128];
			format(string3, sizeof(string3), "CRP_Scriptfiles/Accounts/%s.ini", PlayerName(playerid));
			new File: hFile = fopen(string3, io_write);
			if (hFile)
			{
				new var[32];
				PlayerInfo[playerid][pCash] = GetPlayerCash(playerid);
				PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
				format(var, 32, "Key=%s\n", PlayerInfo[playerid][pKey]);fwrite(hFile, var);
				format(var, 32, "Level=%d\n",PlayerInfo[playerid][pLevel]);fwrite(hFile, var);
				format(var, 32, "AdminLevel=%d\n",PlayerInfo[playerid][pAdmin]);fwrite(hFile, var);
				format(var, 32, "DonateRank=%d\n",PlayerInfo[playerid][pDonateRank]);fwrite(hFile, var);
				format(var, 32, "Registered=%d\n",PlayerInfo[playerid][pRegistered]);fwrite(hFile, var);
				format(var, 32, "Sex=%d\n",PlayerInfo[playerid][pSex]);fwrite(hFile, var);
				format(var, 32, "Age=%d\n",PlayerInfo[playerid][pAge]);fwrite(hFile, var);
				format(var, 32, "Experience=%d\n",PlayerInfo[playerid][pExp]);fwrite(hFile, var);
				format(var, 32, "Money=%d\n",PlayerInfo[playerid][pCash]);fwrite(hFile, var);
				format(var, 32, "Bank=%d\n",PlayerInfo[playerid][pBank]);fwrite(hFile, var);
				format(var, 32, "Skin=%d\n",PlayerInfo[playerid][pSkin]);fwrite(hFile, var);
				format(var, 32, "Drugs=%d\n",PlayerInfo[playerid][pDrugs]);fwrite(hFile, var);
				format(var, 32, "Materials=%d\n",PlayerInfo[playerid][pMaterials]);fwrite(hFile, var);
				format(var, 32, "Job=%d\n",PlayerInfo[playerid][pJob]);fwrite(hFile, var);
				format(var, 32, "PlayingHours=%d\n",PlayerInfo[playerid][pPlayingHours]);fwrite(hFile, var);
				format(var, 32, "AllowedPayday=%d\n",PlayerInfo[playerid][pAllowedPayday]);fwrite(hFile, var);
				format(var, 32, "PayCheck=%d\n",PlayerInfo[playerid][pPayCheck]);fwrite(hFile, var);
				format(var, 32, "Faction=%d\n",PlayerInfo[playerid][pFaction]);fwrite(hFile, var);
				format(var, 32, "Rank=%d\n",PlayerInfo[playerid][pRank]);fwrite(hFile, var);
				format(var, 32, "HouseKey=%d\n",PlayerInfo[playerid][pHouseKey]);fwrite(hFile, var);
				format(var, 32, "BizKey=%d\n",PlayerInfo[playerid][pBizKey]);fwrite(hFile, var);
				format(var, 32, "SpawnPoint=%d\n",PlayerInfo[playerid][pSpawnPoint]);fwrite(hFile, var);
				format(var, 32, "Banned=%d\n",PlayerInfo[playerid][pBanned]);fwrite(hFile, var);
				format(var, 32, "Warnings=%d\n",PlayerInfo[playerid][pWarnings]);fwrite(hFile, var);
				format(var, 32, "CarLic=%d\n",PlayerInfo[playerid][pCarLic]);fwrite(hFile, var);
				format(var, 32, "FlyLic=%d\n",PlayerInfo[playerid][pFlyLic]);fwrite(hFile, var);
				format(var, 32, "WepLic=%d\n",PlayerInfo[playerid][pWepLic]);fwrite(hFile, var);
				format(var, 32, "PhoneNumber=%d\n",PlayerInfo[playerid][pPhoneNumber]);fwrite(hFile, var);
				format(var, 32, "PhoneC=%d\n",PlayerInfo[playerid][pPhoneC]);fwrite(hFile, var);
				format(var, 32, "PhoneBook=%d\n",PlayerInfo[playerid][pPhoneBook]);fwrite(hFile, var);
				format(var, 32, "ListNumber=%d\n",PlayerInfo[playerid][pListNumber]);fwrite(hFile, var);
				format(var, 32, "Donator=%d\n",PlayerInfo[playerid][pDonator]);fwrite(hFile, var);
				format(var, 32, "Jailed=%d\n",PlayerInfo[playerid][pJailed]);fwrite(hFile, var);
				format(var, 32, "JailTime=%d\n",PlayerInfo[playerid][pJailTime]);fwrite(hFile, var);
				format(var, 32, "Products=%d\n",PlayerInfo[playerid][pProducts]);fwrite(hFile, var);
				format(var, 32, "CrashX=%.1f\n",PlayerInfo[playerid][pCrashX]);fwrite(hFile, var);
				format(var, 32, "CrashY=%.1f\n",PlayerInfo[playerid][pCrashY]);fwrite(hFile, var);
				format(var, 32, "CrashZ=%.1f\n",PlayerInfo[playerid][pCrashZ]);fwrite(hFile, var);
				format(var, 32, "CrashInt=%d\n",PlayerInfo[playerid][pCrashInt]);fwrite(hFile, var);
				format(var, 32, "CrashW=%d\n",PlayerInfo[playerid][pCrashW]);fwrite(hFile, var);
				format(var, 32, "Crashed=%d\n",PlayerInfo[playerid][pCrashed]);fwrite(hFile, var);
				fclose(hFile);
			}
		}
	}
	return 1;
}
public Update()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(gPlayerLogged[i] == 1)
		    {
				if(PlayerInfo[i][pAllowedPayday] < 6)
				{
					PlayerInfo[i][pAllowedPayday] ++;
				}
			}
		}
	}
}
public PayDay()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(gPlayerLogged[i] == 1)
		    {
				if(PlayerInfo[i][pAllowedPayday] >= 5)
				{
				 		new wstring[256];
						new randcheck = 999 + random(4999);
						new interest = (PlayerInfo[i][pBank]/1000)*(intrate);
						new bonus = PlayerInfo[i][pPayCheck];
					    new newbank = PlayerInfo[i][pBank] + interest;
    					new randtax = 20 + random(50);
						SendClientMessage(i,COLOR_YELLOW,"____________________________________________________");
						SendClientMessage(i,COLOR_LIGHTYELLOW2,"                                    PayDay:                       ");
						format(wstring, sizeof(wstring), "~y~PayDay~n~~w~Paycheck: ~g~%d",randcheck + bonus);
						GameTextForPlayer(i, wstring, 5000, 1);
					    format(wstring, sizeof(wstring), "PayCheck: $%d, Bonus: $%d.", randcheck, bonus);
					    SendClientMessage(i,COLOR_LIGHTYELLOW2, wstring);
					    format(wstring, sizeof(wstring), "Balance: $%d, Interest Gained: $%d, New Balance: $%d, Interest Rate: 0.%d percent.", PlayerInfo[i][pBank], interest, newbank,intrate);
					    SendClientMessage(i,COLOR_LIGHTYELLOW2, wstring);
					    format(wstring, sizeof(wstring), "Government Taxes: $%d.", randtax);
					    SendClientMessage(i,COLOR_LIGHTYELLOW2, wstring);
					    PlayerInfo[i][pBank] += interest;
					    PlayerInfo[i][pBank] -= randtax;
					    PlayerInfo[i][pBank] += randcheck + bonus;
			    		PlayerInfo[i][pPayCheck] = 0;
						PlayerInfo[i][pAllowedPayday] = 0;
						PlayerInfo[i][pExp]++;
						PlayerInfo[i][pPlayingHours] += 1;
						SendClientMessage(i,COLOR_LIGHTYELLOW2, "[INFO:] Your money is now available to pickup at the bank.");
						SendClientMessage(i,COLOR_YELLOW,"____________________________________________________");
						
						new nxtlevel = PlayerInfo[i][pLevel]+1;
						new expamount = nxtlevel*levelexp;
						if(PlayerInfo[i][pExp] < expamount)
						{
	   						format(wstring, sizeof(wstring), "Your need %d/%d experience, you currently have %d.", expamount,expamount,PlayerInfo[i][pExp]);
						    SendClientMessage(i,COLOR_LIGHTYELLOW2, wstring);
						}
						else
						{
	   						format(wstring, sizeof(wstring), "You leveled up! - New Level: %d.", nxtlevel);
						    SendClientMessage(i,COLOR_LIGHTYELLOW2, wstring);
							PlayerInfo[i][pLevel]++;
	   						format(wstring, sizeof(wstring), "Your new target is %d/%d experience points.", expamount,expamount);
						    SendClientMessage(i,COLOR_LIGHTYELLOW2, wstring);
						    PlayerInfo[i][pExp] = 0;
						}
				}
				else
				{
					SendClientMessage(i,COLOR_LIGHTYELLOW2,"[INFO:] Payday not recieved, not played long enough.");
				}
			}
			else
			{
				SendClientMessage(i,COLOR_LIGHTYELLOW2,"[INFO:] You are not logged in, payday not recieved.");
			}
		}
	}
}
public SaveAccounts()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(gPlayerLogged[i])
		    {
				OnPlayerDataSave(i);
			}
		}
	}
}
public UpdateData()
{
	UpdateScore();
	SyncTime();
	return 1;
}
public UpdateMoney()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(gPlayerLogged[i])
		    {
			 	if(GetPlayerCash(i) != GetPlayerMoney(i))
			 	{
 	 				new hack = GetPlayerMoney(i) - GetPlayerCash(i);
			  		if(hack >= 5000)
			  		{
					  	new string[128];
					    format(string, sizeof(string), "[WARNING:] %s (ID:%d) tried to spawn $%d - This could be a money cheat.",GetPlayerNameEx(i),i, hack);
					    HackLog(string);
			  		}
			 		ResetMoneyBar(i);//Resets the money in the original moneybar, Do not remove!
					UpdateMoneyBar(i,PlayerInfo[i][pCash]);//Sets the money in the moneybar to the serverside cash, Do not remove!
				}
			}
		}
	}
	return 1;
}
public UpdateScore()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			SetPlayerScore(i, PlayerInfo[i][pLevel]);
		}
	}
	return 1;
}
stock ini_GetKey( line[] )
{
	new keyRes[256];
	keyRes[0] = 0;
    if ( strfind( line , "=" , true ) == -1 ) return keyRes;
    strmid( keyRes , line , 0 , strfind( line , "=" , true ) , sizeof( keyRes) );
    return keyRes;
}

stock ini_GetValue( line[] )
{
	new valRes[256];
	valRes[0]=0;
	if ( strfind( line , "=" , true ) == -1 ) return valRes;
	strmid( valRes , line , strfind( line , "=" , true )+1 , strlen( line ) , sizeof( valRes ) );
	return valRes;
}
public OnPlayerInfoChange(playerid)
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	new string[128];
	if(VehicleLocked[vehicleid])
	{
		new Float:playerposx, Float:playerposy, Float:playerposz;
		GetPlayerPos(playerid, playerposx, playerposy, playerposz);
		if(PlayerInfo[playerid][pAdmin] == 0)
		{
			SetPlayerPos(playerid,playerposx, playerposy, playerposz);
		}
		SendClientMessage(playerid,COLOR_WHITE,"[VEHICLE:] Vehicle Locked.");
	}
	if(DynamicCars[vehicleid-1][CarType] == 1)
	{
		if(TakingDrivingTest[playerid] != 1)
		{
			new Float:playerposx, Float:playerposy, Float:playerposz;
			GetPlayerPos(playerid, playerposx, playerposy, playerposz);
			if(PlayerInfo[playerid][pAdmin] == 0)
			{
   				SetPlayerPos(playerid,playerposx, playerposy, playerposz);
			}
			SendClientMessage(playerid,COLOR_WHITE,"[ERROR:] Your not taking your driving test!");
		}
	}
    if(DynamicCars[vehicleid-1][FactionCar] != 255)
	{
	    if(DynamicFactions[DynamicCars[vehicleid-1][FactionCar]][fType] == 1)
	    {
	        if(PlayerInfo[playerid][pFaction] != DynamicCars[vehicleid-1][FactionCar])
	        {
	            new Float:playerposx, Float:playerposy, Float:playerposz;
				GetPlayerPos(playerid, playerposx, playerposy, playerposz);
	  			if(PlayerInfo[playerid][pAdmin] == 0)
				{
					SetPlayerPos(playerid,playerposx, playerposy, playerposz);
				}
				format(string, sizeof(string), "[LSPD:] %s has been spotted attempting to steal a police vehicle.", GetPlayerNameEx(playerid));
				SendFactionTypeMessage(1,COLOR_LSPD,string);
				new location[MAX_ZONE_NAME];
				GetPlayer2DZone(playerid, location, MAX_ZONE_NAME);
				format(string, sizeof(string), "[LSPD:] All units be on the lookout for %s - Person Last Seen: %s.", GetPlayerNameEx(playerid),location);
				SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[VEHICLE:] You have been spotted attempting to steal a police vehicle!");
				SetPlayerWantedLevelEx(playerid,GetPlayerWantedLevel(playerid)+1);
	        }
	    }
		format(string, sizeof(string), "[FACTION:] This vehicle belongs to %s.",DynamicFactions[DynamicCars[vehicleid-1][FactionCar]][fName]);
		SendClientMessage(playerid,COLOR_WHITE, string);
	}
	if(IsAPlane(vehicleid) || IsAHelicopter(vehicleid))
 	{
		new Float:playerposx, Float:playerposy, Float:playerposz;
		GetPlayerPos(playerid, playerposx, playerposy, playerposz);
  		if(PlayerInfo[playerid][pFlyLic] == 0)
		{
  			SendClientMessage(playerid,COLOR_WHITE,"[ERROR:] You don't have a flying license!");
			if(PlayerInfo[playerid][pAdmin] == 0)
			{
   				SetPlayerPos(playerid,playerposx, playerposy, playerposz);
			}
		}
   	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    if(DynamicCars[GetPlayerVehicleID(playerid)-1][CarType] != 1)
		{
		    if(EngineStatus[GetPlayerVehicleID(playerid)] == 0)
			{
				SendClientMessage(playerid,COLOR_GREEN,"[STATUS:] Vehicle engine is not started (/engine).");
				TogglePlayerControllable(playerid,0);
			}
			else
			{
			    SendClientMessage(playerid,COLOR_GREEN,"[STATUS:] Vehicle engine is started, you will still lose fuel even if you are not in the vehicle.");
			}
		}
	    if(DynamicCars[GetPlayerVehicleID(playerid)-1][FactionCar] != 255)
		{
		    if(DynamicFactions[DynamicCars[GetPlayerVehicleID(playerid)-1][FactionCar]][fType] == 1)
		    {
		        if(PlayerInfo[playerid][pFaction] != DynamicCars[GetPlayerVehicleID(playerid)-1][FactionCar])
		        {
					RemoveDriverFromVehicle(playerid);
		        }
		    }
		}
	    if(PlayerInfo[playerid][pCarLic] == 0 && IsAPlane(GetPlayerVehicleID(playerid))==0 && IsAHelicopter(GetPlayerVehicleID(playerid))==0)
	    {
	    	SendClientMessage(playerid,COLOR_WHITE,"[INFO:] Your driving without a license, be aware if you are caught you will be prosecuted.");
	    }
		new updatedvehicleid = GetPlayerVehicleID(playerid) - 1;
		if(DynamicCars[updatedvehicleid][CarType] == 1)
		{
			if(TakingDrivingTest[playerid] == 1)
			{
				SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] You can complete your test by going through each checkpoint without damaging the car.");

				if(DrivingTestStep[playerid] == 0)
				{
			 		SetPlayerCheckpoint(playerid, 1328.8065,-1403.0996,13.2369, 5.0);
					DrivingTestStep[playerid] = 1;
				}
	   		}
			else
			{
				RemoveDriverFromVehicle(playerid);
			}
		}
	  	if(IsAPlane(GetPlayerVehicleID(playerid)) || IsAHelicopter(GetPlayerVehicleID(playerid)))
	 	{
	  		if(PlayerInfo[playerid][pFlyLic] == 0)
			{
				if(PlayerInfo[playerid][pAdmin] == 0)
				{
				   	RemoveDriverFromVehicle(playerid);
    			}
			}
	   	}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	//===================================================[DRIVING TEST]========================================================
	for(new h = 0; h < sizeof(DynamicCars); h++)
	{
			new updatedvehicleid = GetPlayerVehicleID(playerid) - 1;
			if(DynamicCars[updatedvehicleid][CarType] == 1)
			{
			if(TakingDrivingTest[playerid] == 1)
			{
				if(PlayerToPoint(5.0,playerid,1328.8065,-1403.0996,13.2369) && DrivingTestStep[playerid] == 1)
				{
	                DrivingTestStep[playerid] = 2;
	                SetPlayerCheckpoint(playerid, 1441.4253,-1443.6260,13.2652, 5.0);
				}
				else if(PlayerToPoint(5.0,playerid,1441.4253,-1443.6260,13.2652) && DrivingTestStep[playerid] == 2)
				{
	                DrivingTestStep[playerid] = 3;
	                SetPlayerCheckpoint(playerid, 1427.0172,-1578.5571,13.2460, 5.0);
				}
				else if(PlayerToPoint(5.0,playerid,1427.0172,-1578.5571,13.2460) && DrivingTestStep[playerid] == 3)
				{
	                DrivingTestStep[playerid] = 4;
	                SetPlayerCheckpoint(playerid, 1325.4891,-1570.3796,13.2504, 5.0);
				}
				else if(PlayerToPoint(5.0,playerid,1325.4891,-1570.3796,13.2504) && DrivingTestStep[playerid] == 4)
				{
	                DrivingTestStep[playerid] = 5;
	                SetPlayerCheckpoint(playerid, 1321.9575,-1392.0773,13.2449, 5.0);
				}
				else if(PlayerToPoint(5.0,playerid,1321.9575,-1392.0773,13.2449) && DrivingTestStep[playerid] == 5)
				{
				    new Float:health;
				    new veh;
				    veh = GetPlayerVehicleID(playerid);
				    GetVehicleHealth(veh, health);

				    if(health >= 600.0)
				    {
				    	SendClientMessage(playerid,COLOR_GREEN,"[INFO:] You managed to keep the vehicles health above 60 percent and complete the checkpoints, You've passed!");
				    	PlayerInfo[playerid][pCarLic] = 1;
				    	OnPlayerDataSave(playerid);
				    	SetVehicleToRespawn(veh);
				    	TakingDrivingTest[playerid] = 0;
			    	 	DisablePlayerCheckpoint(playerid);
				    }
				    else
				    {
						SendClientMessage(playerid,COLOR_RED,"[INFO:] You failed the test, better luck next time.");
						SetVehicleToRespawn(veh);
						TakingDrivingTest[playerid] = 0;
						DisablePlayerCheckpoint(playerid);
				    }
	                DrivingTestStep[playerid] = 0;
				}
				return 1;
			}
		}
	}
	//==================================================================================================================
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}
public SetPlayerSpawn(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pCrashed])
		{
		    SetPlayerPos(playerid,PlayerInfo[playerid][pCrashX],PlayerInfo[playerid][pCrashY],PlayerInfo[playerid][pCrashZ]);
		    SetPlayerInterior(playerid,PlayerInfo[playerid][pCrashInt]);
			SetPlayerVirtualWorld(playerid,PlayerInfo[playerid][pCrashW]);
			PlayerInfo[playerid][pCrashed] = 0;
			GameTextForPlayer(playerid, "~r~Crashed...~n~~g~Returning to previous position.", 7000, 6);
			
			if(PlayerInfo[playerid][pSex] == 1)
			{
				PlayerLocalMessage(playerid,15.0,"was set back to his previous position.");
			}
			else
			{
			    PlayerLocalMessage(playerid,15.0,"was set back to her previous position.");
			}
			return 1;
		}
	    if(AdminDuty[playerid])
	    {
	    	SetPlayerColor(playerid,COLOR_ADMINDUTY);
			SetPlayerHealth(playerid,99999);
			SetPlayerArmour(playerid,99999);
	    }
	    if(PlayerInfo[playerid][pFaction] != 255)
	    {
			SetPlayerToFactionColor(playerid);
			SetPlayerToFactionSkin(playerid);
     	}
   		if(PlayerInfo[playerid][pJailed] == 1)
		{
		    SetPlayerVirtualWorld(playerid,2); //BUILDING ID 2, MAKE SURE PD IS ID 2
		    SetPlayerInterior(playerid, 6);
			SetPlayerPos(playerid,264.5743,77.5118,1001.0391);
			SendClientMessage(playerid, COLOR_LIGHTYELLOW2, "[ERROR:] You havn't finished your jail time!");
			return 1;
		}
	    new house = PlayerInfo[playerid][pHouseKey];
   		if(house != 255)
		{
		    if(PlayerInfo[playerid][pSpawnPoint])
		    {
				SetPlayerInterior(playerid,Houses[house][ExitInterior]);
				SetPlayerPos(playerid, Houses[house][ExitX], Houses[house][ExitY],Houses[house][ExitZ]);
				SetPlayerVirtualWorld(playerid,house);
    			return 1;
			}
		}
  		if(PlayerInfo[playerid][pFaction] != 255)
		{
		    if(PlayerInfo[playerid][pSpawnPoint] == 0)
		    {
				SetPlayerPos(playerid,DynamicFactions[PlayerInfo[playerid][pFaction]][fX],DynamicFactions[PlayerInfo[playerid][pFaction]][fY],DynamicFactions[PlayerInfo[playerid][pFaction]][fZ]);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
				return 1;
			}
		}
	    else
	    {
		    //====================[Setting Civilian Position]==========================
			SetPlayerPos(playerid,CivilianSpawn[X],CivilianSpawn[Y],CivilianSpawn[Z]);
			SetPlayerVirtualWorld(playerid, CivilianSpawn[World]);
			SetPlayerInterior(playerid, CivilianSpawn[Interior]);
			SetPlayerFacingAngle(playerid,CivilianSpawn[Angle]);
			//=========================================================================
			return 1;
		}
	}
	return 1;
}
public SetPlayerToFactionSkin(playerid)
{

  		new faction = PlayerInfo[playerid][pFaction];
		new rank = PlayerInfo[playerid][pRank];
		new rankamount = DynamicFactions[faction][fRankAmount];
		if(faction != 255)
		{
			if(DynamicFactions[faction][fUseSkins])
			{
				if(rank == 1 && rankamount >= 1)
				{
	   				if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin1]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin1]);
					}
				}
				else if(rank == 2 && rankamount >= 2)
				{
	    			if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin2]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin2]);
					}
				}
				else if(rank == 3 && rankamount >= 3)
				{
	    			if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin3]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin3]);
					}
				}
				else if(rank == 4 && rankamount >= 4)
				{
					if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin4]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin4]);
					}
				}
				else if(rank == 5 && rankamount >= 5)
				{
					if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin5]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin5]);
					}
				}
				else if(rank == 6 && rankamount >= 6)
				{
					if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin6]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin6]);
					}
				}
				else if(rank == 7 && rankamount >= 7)
				{
					if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin7]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin7]);
					}
				}
				else if(rank == 8 && rankamount >= 8)
				{
					if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin8]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin8]);
					}
				}
				else if(rank == 9 && rankamount >= 9)
				{
					if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin9]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin9]);
					}
				}
				else if(rank == 10 && rankamount >= 10)
				{
					if(DynamicFactions[faction][fType] == 1)
	    		    {
	    		        if(CopOnDuty[playerid])
	    		        {
	    		            SetPlayerSkin(playerid,DynamicFactions[faction][fSkin10]);
	    		        }
					}
					else
					{
						SetPlayerSkin(playerid,DynamicFactions[faction][fSkin10]);
					}
				}
   }
		}
		return 1;
}
public SetPlayerToFactionColor(playerid)
{
	if(PlayerInfo[playerid][pFaction] != 255)
	{
		if(DynamicFactions[PlayerInfo[playerid][pFaction]][fUseColor])
		{
		    if(DynamicFactions[PlayerInfo[playerid][pFaction]][fType] == 1)
		    {
      			if(CopOnDuty[playerid] == 1)
	        	{
	        	    SetPlayerColor(playerid,HexToInt(DynamicFactions[PlayerInfo[playerid][pFaction]][fColor]));
   		        }
   		        else
   		        {
	            	SetPlayerColor(playerid,COLOR_CIVILIAN);
   		        }
			}
			else
			{
				SetPlayerColor(playerid,HexToInt(DynamicFactions[PlayerInfo[playerid][pFaction]][fColor]));
			}
		}
	}
	return 0;
}
public OnPlayerExitedMenu(playerid)
{
	return 1;
}
public ProxDetectorS(Float:radi, playerid, targetid)
{
    if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		GetPlayerPos(targetid, posx, posy, posz);
		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
		    if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid))
		    {
				return 1;
			}
		}
	}
	return 0;
}
public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(!BigEar[i])
				{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);
					//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
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
				else
				{
					SendClientMessage(i, col1, string);
				}
			}
		}
	}//not connected
	return 1;
}
strtok(string[],&idx,seperator = ' ')
{
	new ret[128], i = 0, len = strlen(string);
	while(string[idx] == seperator && idx < len) idx++;
	while(string[idx] != seperator && idx < len)
	{
	    ret[i] = string[idx];
	    i++;
		idx++;
	}
	while(string[idx] == seperator && idx < len) idx++;
	return ret;
}
//=====================================================[SERVERSIDE CASH FUNCTIONS=============================================
stock GivePlayerCash(playerid, money)
{
	PlayerInfo[playerid][pCash] += money;
	ResetMoneyBar(playerid);//Resets the money in the original moneybar, Do not remove!
	UpdateMoneyBar(playerid,PlayerInfo[playerid][pCash]);//Sets the money in the moneybar to the serverside cash, Do not remove!
	return PlayerInfo[playerid][pCash];
}
stock SetPlayerCash(playerid, money)
{
	PlayerInfo[playerid][pCash] = money;
	ResetMoneyBar(playerid);//Resets the money in the original moneybar, Do not remove!
	UpdateMoneyBar(playerid,PlayerInfo[playerid][pCash]);//Sets the money in the moneybar to the serverside cash, Do not remove!
	return PlayerInfo[playerid][pCash];
}
stock ResetPlayerCash(playerid)
{
	PlayerInfo[playerid][pCash] = 0;
	ResetMoneyBar(playerid);//Resets the money in the original moneybar, Do not remove!
	UpdateMoneyBar(playerid,PlayerInfo[playerid][pCash]);//Sets the money in the moneybar to the serverside cash, Do not remove!
	return PlayerInfo[playerid][pCash];
}
stock GetPlayerCash(playerid)
{
	return PlayerInfo[playerid][pCash];
}
//=====================================================================================================================================
public LoadProductsSellerJob()
{
	new arrCoords[14][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Jobs/productsellersjob.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		ProductsSellerJob[TakeJobX] = floatstr(arrCoords[0]);
		ProductsSellerJob[TakeJobY] = floatstr(arrCoords[1]);
		ProductsSellerJob[TakeJobZ] = floatstr(arrCoords[2]);
		ProductsSellerJob[TakeJobWorld] = strval(arrCoords[3]);
		ProductsSellerJob[TakeJobInterior] = strval(arrCoords[4]);
		ProductsSellerJob[TakeJobAngle] = floatstr(arrCoords[5]);
		ProductsSellerJob[TakeJobPickupID] = strval(arrCoords[6]);
        ProductsSellerJob[TakeJobPickupID] = CreateStreamPickup(1239,1,ProductsSellerJob[TakeJobX],ProductsSellerJob[TakeJobY],ProductsSellerJob[TakeJobZ],PICKUP_RANGE);
		ProductsSellerJob[BuyProductsX] = floatstr(arrCoords[7]);
		ProductsSellerJob[BuyProductsY] = floatstr(arrCoords[8]);
		ProductsSellerJob[BuyProductsZ] = floatstr(arrCoords[9]);
		ProductsSellerJob[BuyProductsWorld] = strval(arrCoords[10]);
		ProductsSellerJob[BuyProductsInterior] = strval(arrCoords[11]);
		ProductsSellerJob[BuyProductsAngle] = floatstr(arrCoords[12]);
		ProductsSellerJob[BuyProductsPickupID] = strval(arrCoords[13]);
        ProductsSellerJob[BuyProductsPickupID] = CreateStreamPickup(1239,1,ProductsSellerJob[BuyProductsX],ProductsSellerJob[BuyProductsY],ProductsSellerJob[BuyProductsZ],PICKUP_RANGE);
        print("[INFO:] Products seller job loaded.");
	}
	fclose(file);
	return 1;
}
public SaveProductsSellerJob()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d|%f|%f|%f|%d|%d|%f|%d\n",
	ProductsSellerJob[TakeJobX],
	ProductsSellerJob[TakeJobY],
	ProductsSellerJob[TakeJobZ],
	ProductsSellerJob[TakeJobWorld],
	ProductsSellerJob[TakeJobInterior],
	ProductsSellerJob[TakeJobAngle],
	ProductsSellerJob[TakeJobPickupID],
	ProductsSellerJob[BuyProductsX],
	ProductsSellerJob[BuyProductsY],
	ProductsSellerJob[BuyProductsZ],
	ProductsSellerJob[BuyProductsWorld],
	ProductsSellerJob[BuyProductsInterior],
	ProductsSellerJob[BuyProductsAngle],
	ProductsSellerJob[BuyProductsPickupID]);

	file2 = fopen("CRP_Scriptfiles/Jobs/productsellersjob.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}
public LoadGunJob()
{
	new arrCoords[21][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Jobs/gunjob.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		GunJob[TakeJobX] = floatstr(arrCoords[0]);
		GunJob[TakeJobY] = floatstr(arrCoords[1]);
		GunJob[TakeJobZ] = floatstr(arrCoords[2]);
		GunJob[TakeJobWorld] = strval(arrCoords[3]);
		GunJob[TakeJobInterior] = strval(arrCoords[4]);
		GunJob[TakeJobAngle] = floatstr(arrCoords[5]);
		GunJob[TakeJobPickupID] = strval(arrCoords[6]);
        GunJob[TakeJobPickupID] = CreateStreamPickup(1239,1,GunJob[TakeJobX],GunJob[TakeJobY],GunJob[TakeJobZ],PICKUP_RANGE);
		GunJob[BuyPackagesX] = floatstr(arrCoords[7]);
		GunJob[BuyPackagesY] = floatstr(arrCoords[8]);
		GunJob[BuyPackagesZ] = floatstr(arrCoords[9]);
		GunJob[BuyPackagesWorld] = strval(arrCoords[10]);
		GunJob[BuyPackagesInterior] = strval(arrCoords[11]);
		GunJob[BuyPackagesAngle] = floatstr(arrCoords[12]);
		GunJob[BuyPackagesPickupID] = strval(arrCoords[13]);
        GunJob[BuyPackagesPickupID] = CreateStreamPickup(1239,1,GunJob[BuyPackagesX],GunJob[BuyPackagesY],GunJob[BuyPackagesZ],PICKUP_RANGE);
        GunJob[DeliverX] = floatstr(arrCoords[14]);
		GunJob[DeliverY] = floatstr(arrCoords[15]);
		GunJob[DeliverZ] = floatstr(arrCoords[16]);
		GunJob[DeliverWorld] = strval(arrCoords[17]);
		GunJob[DeliverInterior] = strval(arrCoords[18]);
		GunJob[DeliverAngle] = floatstr(arrCoords[19]);
		GunJob[DeliverPickupID] = strval(arrCoords[20]);
        GunJob[DeliverPickupID] = CreateStreamPickup(1239,1,GunJob[DeliverX],GunJob[DeliverY],GunJob[DeliverZ],PICKUP_RANGE);
        print("[INFO:] Gun job loaded.");
	}
	fclose(file);
	return 1;
}
public SaveGunJob()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d|%f|%f|%f|%d|%d|%f|%d|%f|%f|%f|%d|%d|%f|%d\n",
	GunJob[TakeJobX],
	GunJob[TakeJobY],
	GunJob[TakeJobZ],
	GunJob[TakeJobWorld],
	GunJob[TakeJobInterior],
	GunJob[TakeJobAngle],
	GunJob[TakeJobPickupID],
	GunJob[BuyPackagesX],
	GunJob[BuyPackagesY],
	GunJob[BuyPackagesZ],
	GunJob[BuyPackagesWorld],
	GunJob[BuyPackagesInterior],
	GunJob[BuyPackagesAngle],
	GunJob[BuyPackagesPickupID],
	GunJob[DeliverX],
	GunJob[DeliverY],
	GunJob[DeliverZ],
	GunJob[DeliverWorld],
	GunJob[DeliverInterior],
	GunJob[DeliverAngle],
	GunJob[DeliverPickupID]);
	
	file2 = fopen("CRP_Scriptfiles/Jobs/gunjob.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}
public LoadDrugJob()
{
	new arrCoords[21][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Jobs/drugjob.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		DrugJob[TakeJobX] = floatstr(arrCoords[0]);
		DrugJob[TakeJobY] = floatstr(arrCoords[1]);
		DrugJob[TakeJobZ] = floatstr(arrCoords[2]);
		DrugJob[TakeJobWorld] = strval(arrCoords[3]);
		DrugJob[TakeJobInterior] = strval(arrCoords[4]);
		DrugJob[TakeJobAngle] = floatstr(arrCoords[5]);
		DrugJob[TakeJobPickupID] = strval(arrCoords[6]);
        DrugJob[TakeJobPickupID] = CreateStreamPickup(1239,1,DrugJob[TakeJobX],DrugJob[TakeJobY],DrugJob[TakeJobZ],PICKUP_RANGE);
		DrugJob[BuyDrugsX] = floatstr(arrCoords[7]);
		DrugJob[BuyDrugsY] = floatstr(arrCoords[8]);
		DrugJob[BuyDrugsZ] = floatstr(arrCoords[9]);
		DrugJob[BuyDrugsWorld] = strval(arrCoords[10]);
		DrugJob[BuyDrugsInterior] = strval(arrCoords[11]);
		DrugJob[BuyDrugsAngle] = floatstr(arrCoords[12]);
		DrugJob[BuyDrugsPickupID] = strval(arrCoords[13]);
        DrugJob[BuyDrugsPickupID] = CreateStreamPickup(1239,1,DrugJob[BuyDrugsX],DrugJob[BuyDrugsY],DrugJob[BuyDrugsZ],PICKUP_RANGE);
        DrugJob[DeliverX] = floatstr(arrCoords[14]);
		DrugJob[DeliverY] = floatstr(arrCoords[15]);
		DrugJob[DeliverZ] = floatstr(arrCoords[16]);
		DrugJob[DeliverWorld] = strval(arrCoords[17]);
		DrugJob[DeliverInterior] = strval(arrCoords[18]);
		DrugJob[DeliverAngle] = floatstr(arrCoords[19]);
		DrugJob[DeliverPickupID] = strval(arrCoords[20]);
        DrugJob[DeliverPickupID] = CreateStreamPickup(1239,1,DrugJob[DeliverX],DrugJob[DeliverY],DrugJob[DeliverZ],PICKUP_RANGE);
        print("[INFO:] Drug job loaded.");
	}
	fclose(file);
	return 1;
}
public SaveDrugJob()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d|%f|%f|%f|%d|%d|%f|%d|%f|%f|%f|%d|%d|%f|%d\n",
	DrugJob[TakeJobX],
	DrugJob[TakeJobY],
	DrugJob[TakeJobZ],
	DrugJob[TakeJobWorld],
	DrugJob[TakeJobInterior],
	DrugJob[TakeJobAngle],
	DrugJob[TakeJobPickupID],
	DrugJob[BuyDrugsX],
	DrugJob[BuyDrugsY],
	DrugJob[BuyDrugsZ],
	DrugJob[BuyDrugsWorld],
	DrugJob[BuyDrugsInterior],
	DrugJob[BuyDrugsAngle],
	DrugJob[BuyDrugsPickupID],
	DrugJob[DeliverX],
	DrugJob[DeliverY],
	DrugJob[DeliverZ],
	DrugJob[DeliverWorld],
	DrugJob[DeliverInterior],
	DrugJob[DeliverAngle],
	DrugJob[DeliverPickupID]);

	file2 = fopen("CRP_Scriptfiles/Jobs/drugjob.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}
//=================================================[LOADING POSITIONS]=====================================================
public LoadBankPosition()
{
	new arrCoords[7][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Locations/banklocation.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		BankPosition[X] = floatstr(arrCoords[0]);
		BankPosition[Y] = floatstr(arrCoords[1]);
		BankPosition[Z] = floatstr(arrCoords[2]);
		BankPosition[World] = strval(arrCoords[3]);
		BankPosition[Interior] = strval(arrCoords[4]);
		BankPosition[Angle] = floatstr(arrCoords[5]);
		BankPosition[PickupID] = strval(arrCoords[6]);
		//Creating Pickup
        BankPosition[PickupID] = CreateStreamPickup(1239,1,BankPosition[X],BankPosition[Y],BankPosition[Z],PICKUP_RANGE);
        print("[INFO:] Bank location loaded.");
	}
	fclose(file);
	return 1;
}
public SaveBankPosition()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d\n",
	BankPosition[X],
	BankPosition[Y],
	BankPosition[Z],
	BankPosition[World],
	BankPosition[Interior],
	BankPosition[Angle],
	BankPosition[PickupID]);
	file2 = fopen("CRP_Scriptfiles/Locations/banklocation.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}
public LoadDrivingTestPosition()
{
	new arrCoords[7][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Locations/drivingtestlocation.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		DrivingTestPosition[X] = floatstr(arrCoords[0]);
		DrivingTestPosition[Y] = floatstr(arrCoords[1]);
		DrivingTestPosition[Z] = floatstr(arrCoords[2]);
		DrivingTestPosition[World] = strval(arrCoords[3]);
		DrivingTestPosition[Interior] = strval(arrCoords[4]);
		DrivingTestPosition[Angle] = floatstr(arrCoords[5]);
		DrivingTestPosition[PickupID] = strval(arrCoords[6]);
		//Creating Pickup
        DrivingTestPosition[PickupID] = CreateStreamPickup(1239,1,DrivingTestPosition[X],DrivingTestPosition[Y],DrivingTestPosition[Z],PICKUP_RANGE);
        print("[INFO:] Driving test location loaded.");
	}
	fclose(file);
	return 1;
}
public SaveDrivingTestPosition()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d\n",
	DrivingTestPosition[X],
	DrivingTestPosition[Y],
	DrivingTestPosition[Z],
	DrivingTestPosition[World],
	DrivingTestPosition[Interior],
	DrivingTestPosition[Angle],
	DrivingTestPosition[PickupID]);
	file2 = fopen("CRP_Scriptfiles/Locations/drivingtestlocation.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}
public LoadFlyingTestPosition()
{
	new arrCoords[7][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Locations/flyingtestlocation.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		FlyingTestPosition[X] = floatstr(arrCoords[0]);
		FlyingTestPosition[Y] = floatstr(arrCoords[1]);
		FlyingTestPosition[Z] = floatstr(arrCoords[2]);
		FlyingTestPosition[World] = strval(arrCoords[3]);
		FlyingTestPosition[Interior] = strval(arrCoords[4]);
		FlyingTestPosition[Angle] = floatstr(arrCoords[5]);
		FlyingTestPosition[PickupID] = strval(arrCoords[6]);
		//Creating Pickup
        FlyingTestPosition[PickupID] = CreateStreamPickup(1239,1,FlyingTestPosition[X],FlyingTestPosition[Y],FlyingTestPosition[Z],PICKUP_RANGE);
        print("[INFO:] Flying test location loaded.");
	}
	fclose(file);
	return 1;
}
public SaveFlyingTestPosition()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d\n",
	FlyingTestPosition[X],
	FlyingTestPosition[Y],
	FlyingTestPosition[Z],
	FlyingTestPosition[World],
	FlyingTestPosition[Interior],
	FlyingTestPosition[Angle],
	FlyingTestPosition[PickupID]);
	file2 = fopen("CRP_Scriptfiles/Locations/flyingtestlocation.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}
public LoadWeaponLicensePosition()
{
	new arrCoords[7][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Locations/weaponlicenselocation.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		WeaponLicensePosition[X] = floatstr(arrCoords[0]);
		WeaponLicensePosition[Y] = floatstr(arrCoords[1]);
		WeaponLicensePosition[Z] = floatstr(arrCoords[2]);
		WeaponLicensePosition[World] = strval(arrCoords[3]);
		WeaponLicensePosition[Interior] = strval(arrCoords[4]);
		WeaponLicensePosition[Angle] = floatstr(arrCoords[5]);
		WeaponLicensePosition[PickupID] = strval(arrCoords[6]);
		//Creating Pickup
        WeaponLicensePosition[PickupID] = CreateStreamPickup(1239,1,WeaponLicensePosition[X],WeaponLicensePosition[Y],WeaponLicensePosition[Z],PICKUP_RANGE);
        print("[INFO:] Weapon License location loaded.");
	}
	fclose(file);
	return 1;
}
public SaveWeaponLicensePosition()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d\n",
	WeaponLicensePosition[X],
	WeaponLicensePosition[Y],
	WeaponLicensePosition[Z],
	WeaponLicensePosition[World],
	WeaponLicensePosition[Interior],
	WeaponLicensePosition[Angle],
	WeaponLicensePosition[PickupID]);
	file2 = fopen("CRP_Scriptfiles/Locations/weaponlicenselocation.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}
public LoadPoliceArrestPosition()
{
	new arrCoords[6][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Locations/policearrestposition.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		PoliceArrestPosition[X] = floatstr(arrCoords[0]);
		PoliceArrestPosition[Y] = floatstr(arrCoords[1]);
		PoliceArrestPosition[Z] = floatstr(arrCoords[2]);
		PoliceArrestPosition[World] = strval(arrCoords[3]);
		PoliceArrestPosition[Interior] = strval(arrCoords[4]);
		PoliceArrestPosition[Angle] = floatstr(arrCoords[5]);
        print("[INFO:] Police Arrest location loaded.");
	}
	fclose(file);
	return 1;
}
public SavePoliceArrestPosition()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f\n",
	PoliceArrestPosition[X],
	PoliceArrestPosition[Y],
	PoliceArrestPosition[Z],
	PoliceArrestPosition[World],
	PoliceArrestPosition[Interior],
	PoliceArrestPosition[Angle]);
	file2 = fopen("CRP_Scriptfiles/Locations/policearrestposition.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}
public LoadPoliceDutyPosition()
{
	new arrCoords[6][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Locations/policedutyposition.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		PoliceDutyPosition[X] = floatstr(arrCoords[0]);
		PoliceDutyPosition[Y] = floatstr(arrCoords[1]);
		PoliceDutyPosition[Z] = floatstr(arrCoords[2]);
		PoliceDutyPosition[World] = strval(arrCoords[3]);
		PoliceDutyPosition[Interior] = strval(arrCoords[4]);
		PoliceDutyPosition[Angle] = floatstr(arrCoords[5]);
        print("[INFO:] Police Duty location loaded.");
	}
	fclose(file);
	return 1;
}
public SavePoliceDutyPosition()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f\n",
	PoliceDutyPosition[X],
	PoliceDutyPosition[Y],
	PoliceDutyPosition[Z],
	PoliceDutyPosition[World],
	PoliceDutyPosition[Interior],
	PoliceDutyPosition[Angle]);
	file2 = fopen("CRP_Scriptfiles/Locations/policedutyposition.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}
public LoadDetectiveJob()
{
	new arrCoords[7][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Jobs/detectivejob.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		DetectiveJobPosition[X] = floatstr(arrCoords[0]);
		DetectiveJobPosition[Y] = floatstr(arrCoords[1]);
		DetectiveJobPosition[Z] = floatstr(arrCoords[2]);
		DetectiveJobPosition[World] = strval(arrCoords[3]);
		DetectiveJobPosition[Interior] = strval(arrCoords[4]);
		DetectiveJobPosition[Angle] = floatstr(arrCoords[5]);
		DetectiveJobPosition[PickupID] = strval(arrCoords[6]);
		DetectiveJobPosition[PickupID] = CreateStreamPickup(1239,1,DetectiveJobPosition[X],DetectiveJobPosition[Y],DetectiveJobPosition[Z],PICKUP_RANGE);
        print("[INFO:] Detective job loaded.");
	}
	fclose(file);
	return 1;
}
public SaveDetectiveJob()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d\n",
	DetectiveJobPosition[X],
	DetectiveJobPosition[Y],
	DetectiveJobPosition[Z],
	DetectiveJobPosition[World],
	DetectiveJobPosition[Interior],
	DetectiveJobPosition[Angle],
	DetectiveJobPosition[PickupID]);
	file2 = fopen("CRP_Scriptfiles/Jobs/detectivejob.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}
public LoadLawyerJob()
{
	new arrCoords[7][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Jobs/lawyerjob.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		LawyerJobPosition[X] = floatstr(arrCoords[0]);
		LawyerJobPosition[Y] = floatstr(arrCoords[1]);
		LawyerJobPosition[Z] = floatstr(arrCoords[2]);
		LawyerJobPosition[World] = strval(arrCoords[3]);
		LawyerJobPosition[Interior] = strval(arrCoords[4]);
		LawyerJobPosition[Angle] = floatstr(arrCoords[5]);
		LawyerJobPosition[PickupID] = strval(arrCoords[6]);
		LawyerJobPosition[PickupID] = CreateStreamPickup(1239,1,LawyerJobPosition[X],LawyerJobPosition[Y],LawyerJobPosition[Z],PICKUP_RANGE);
        print("[INFO:] Lawyer job loaded.");
	}
	fclose(file);
	return 1;
}
public SaveLawyerJob()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d\n",
	LawyerJobPosition[X],
	LawyerJobPosition[Y],
	LawyerJobPosition[Z],
	LawyerJobPosition[World],
	LawyerJobPosition[Interior],
	LawyerJobPosition[Angle],
	LawyerJobPosition[PickupID]);
	file2 = fopen("CRP_Scriptfiles/Jobs/lawyerjob.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}
//================================================[FACTION MATERIALS & DRUG STORAGE]===================================================
public LoadFactionMaterialsStorage()
{
	new arrCoords[7][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Locations/factionmatsstorage.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		FactionMaterialsStorage[X] = floatstr(arrCoords[0]);
		FactionMaterialsStorage[Y] = floatstr(arrCoords[1]);
		FactionMaterialsStorage[Z] = floatstr(arrCoords[2]);
		FactionMaterialsStorage[World] = strval(arrCoords[3]);
		FactionMaterialsStorage[Interior] = strval(arrCoords[4]);
		FactionMaterialsStorage[Angle] = floatstr(arrCoords[5]);
		FactionMaterialsStorage[PickupID] = strval(arrCoords[6]);
		//Creating Pickup
        FactionMaterialsStorage[PickupID] = CreateStreamPickup(1254,1,FactionMaterialsStorage[X],FactionMaterialsStorage[Y],FactionMaterialsStorage[Z],PICKUP_RANGE); // Faction Materials Storage Facility
        print("[INFO:] Faction materials storage location loaded.");
	}
	fclose(file);
	return 1;
}
public SaveFactionMaterialsStorage()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d\n",
	FactionMaterialsStorage[X],
	FactionMaterialsStorage[Y],
	FactionMaterialsStorage[Z],
	FactionMaterialsStorage[World],
	FactionMaterialsStorage[Interior],
	FactionMaterialsStorage[Angle],
	FactionMaterialsStorage[PickupID]);
	file2 = fopen("CRP_Scriptfiles/Locations/factionmatsstorage.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}
public LoadFactionDrugsStorage()
{
	new arrCoords[7][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Locations/factiondrugsstorage.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		FactionDrugsStorage[X] = floatstr(arrCoords[0]);
		FactionDrugsStorage[Y] = floatstr(arrCoords[1]);
		FactionDrugsStorage[Z] = floatstr(arrCoords[2]);
		FactionDrugsStorage[World] = strval(arrCoords[3]);
		FactionDrugsStorage[Interior] = strval(arrCoords[4]);
		FactionDrugsStorage[Angle] = floatstr(arrCoords[5]);
		FactionDrugsStorage[PickupID] = strval(arrCoords[6]);
		//Creating Pickup
        FactionDrugsStorage[PickupID] = CreateStreamPickup(1279,1,FactionDrugsStorage[X],FactionDrugsStorage[Y],FactionDrugsStorage[Z],PICKUP_RANGE); // Faction Materials Storage Facility
        print("[INFO:] Faction drugs storage location loaded.");
	}
	fclose(file);
	return 1;
}
public SaveFactionDrugsStorage()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f|%d\n",
	FactionDrugsStorage[X],
	FactionDrugsStorage[Y],
	FactionDrugsStorage[Z],
	FactionDrugsStorage[World],
	FactionDrugsStorage[Interior],
	FactionDrugsStorage[Angle],
	FactionDrugsStorage[PickupID]);
	file2 = fopen("CRP_Scriptfiles/Locations/factiondrugsstorage.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}
//===========================================================[DYNAMIC CIVILIAN SPAWN SYSTEM]===========================================
public LoadCivilianSpawn()
{
	new arrCoords[6][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Locations/civilianspawn.cfg", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, '|');
		CivilianSpawn[X] = floatstr(arrCoords[0]);
		CivilianSpawn[Y] = floatstr(arrCoords[1]);
		CivilianSpawn[Z] = floatstr(arrCoords[2]);
		CivilianSpawn[World] = strval(arrCoords[3]);
		CivilianSpawn[Interior] = strval(arrCoords[4]);
		CivilianSpawn[Angle] = floatstr(arrCoords[5]);
	}
	fclose(file);
	return 1;
}
public SaveCivilianSpawn()
{
	new File: file2;
	new coordsstring[512];
	format(coordsstring, sizeof(coordsstring), "%f|%f|%f|%d|%d|%f\n",
	CivilianSpawn[X],
	CivilianSpawn[Y],
	CivilianSpawn[Z],
	CivilianSpawn[World],
	CivilianSpawn[Interior],
	CivilianSpawn[Angle]);
	file2 = fopen("CRP_Scriptfiles/Locations/civilianspawn.cfg", io_write);
	fwrite(file2, coordsstring);
	fclose(file2);
	return 1;
}
//=============================================================[DYNAMIC BUSINESS SYSTEM]========================================
public SaveBusinesses()
{
	new idx;
	new File: file2;
	while (idx < sizeof(Businesses))
	{
		new coordsstring[256];
		format(coordsstring, sizeof(coordsstring), "%s|%s|%f|%f|%f|%d|%d|%f|%f|%f|%f|%d|%f|%d|%d|%d|%d|%d|%d|%d|%d|%d\n",
		Businesses[idx][BusinessName],
		Businesses[idx][Owner],
		Businesses[idx][EnterX],
		Businesses[idx][EnterY],
		Businesses[idx][EnterZ],
		Businesses[idx][EnterWorld],
		Businesses[idx][EnterInterior],
		Businesses[idx][EnterAngle],
		Businesses[idx][ExitX],
		Businesses[idx][ExitY],
		Businesses[idx][ExitZ],
		Businesses[idx][ExitInterior],
		Businesses[idx][ExitAngle],
		Businesses[idx][Owned],
		Businesses[idx][Enterable],
		Businesses[idx][BizPrice],
		Businesses[idx][EntranceCost],
		Businesses[idx][Till],
		Businesses[idx][Locked],
		Businesses[idx][BizType],
		Businesses[idx][Products],
		Businesses[idx][PickupID]);

		if(idx == 0)
		{
			file2 = fopen("CRP_Scriptfiles/Businesses/businesses.cfg", io_write);
		}
		else
		{
			file2 = fopen("CRP_Scriptfiles/Businesses/businesses.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	return 1;
}
public LoadBusinesses()
{
	new arrCoords[22][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Businesses/businesses.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(Businesses))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, '|');
			strmid(Businesses[idx][BusinessName], arrCoords[0], 0, strlen(arrCoords[0]), 255);
			strmid(Businesses[idx][Owner], arrCoords[1], 0, strlen(arrCoords[1]), 255);
			Businesses[idx][EnterX] = floatstr(arrCoords[2]);
			Businesses[idx][EnterY] = floatstr(arrCoords[3]);
			Businesses[idx][EnterZ] = floatstr(arrCoords[4]);
			Businesses[idx][EnterWorld] = strval(arrCoords[5]);
			Businesses[idx][EnterInterior] = strval(arrCoords[6]);
			Businesses[idx][EnterAngle] = floatstr(arrCoords[7]);
			Businesses[idx][ExitX] = floatstr(arrCoords[8]);
			Businesses[idx][ExitY] = floatstr(arrCoords[9]);
			Businesses[idx][ExitZ] = floatstr(arrCoords[10]);
			Businesses[idx][ExitInterior] = strval(arrCoords[11]);
			Businesses[idx][ExitAngle] = floatstr(arrCoords[12]);
			Businesses[idx][Owned] = strval(arrCoords[13]);
			Businesses[idx][Enterable] = strval(arrCoords[14]);
			Businesses[idx][BizPrice] = strval(arrCoords[15]);
			Businesses[idx][EntranceCost] = strval(arrCoords[16]);
			Businesses[idx][Till] = strval(arrCoords[17]);
			Businesses[idx][Locked] = strval(arrCoords[18]);
			Businesses[idx][BizType] = strval(arrCoords[19]);
			Businesses[idx][Products] = strval(arrCoords[20]);
			Businesses[idx][PickupID] = strval(arrCoords[21]);

			if(Businesses[idx][BizPrice] != 0) // Don't create the business icon if the price is 0.
			{
				if(Businesses[idx][Owned] == 0)
				{
					Businesses[idx][PickupID]=CreateStreamPickup(1272, 1, Businesses[idx][EnterX], Businesses[idx][EnterY], Businesses[idx][EnterZ],PICKUP_RANGE);
				}
				else if(Businesses[idx][Owned] == 1)
				{
				    Businesses[idx][PickupID]=CreateStreamPickup(1239, 1, Businesses[idx][EnterX], Businesses[idx][EnterY], Businesses[idx][EnterZ],PICKUP_RANGE);
				}
			}
			idx++;
		}
		fclose(file);
	}
	return 1;
}
//==============================================================================================================================

//=============================================================[DYNAMIC HOUSES SYSTEM]==========================================
public SaveHouses()
{
	new idx;
	new File: file2;
	while (idx < sizeof(Houses))
	{
		new coordsstring[256];
		format(coordsstring, sizeof(coordsstring), "%s|%s|%f|%f|%f|%d|%d|%f|%f|%f|%f|%d|%f|%d|%d|%d|%d|%d|%d|%d|%d|%d\n",
		Houses[idx][Description],
		Houses[idx][Owner],
		Houses[idx][EnterX],
		Houses[idx][EnterY],
		Houses[idx][EnterZ],
		Houses[idx][EnterWorld],
		Houses[idx][EnterInterior],
		Houses[idx][EnterAngle],
		Houses[idx][ExitX],
		Houses[idx][ExitY],
		Houses[idx][ExitZ],
		Houses[idx][ExitInterior],
		Houses[idx][ExitAngle],
		Houses[idx][Owned],
		Houses[idx][Rentable],
		Houses[idx][RentCost],
		Houses[idx][HousePrice],
		Houses[idx][Materials],
		Houses[idx][Drugs],
		Houses[idx][Money],
		Houses[idx][Locked],
		Houses[idx][PickupID]);
		
		if(idx == 0)
		{
			file2 = fopen("CRP_Scriptfiles/Houses/houses.cfg", io_write);
		}
		else
		{
			file2 = fopen("CRP_Scriptfiles/Houses/houses.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	return 1;
}
public LoadHouses()
{
	new arrCoords[22][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Houses/houses.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(Houses))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, '|');
			strmid(Houses[idx][Description], arrCoords[0], 0, strlen(arrCoords[0]), 255);
			strmid(Houses[idx][Owner], arrCoords[1], 0, strlen(arrCoords[1]), 255);
			Houses[idx][EnterX] = floatstr(arrCoords[2]);
			Houses[idx][EnterY] = floatstr(arrCoords[3]);
			Houses[idx][EnterZ] = floatstr(arrCoords[4]);
			Houses[idx][EnterWorld] = strval(arrCoords[5]);
			Houses[idx][EnterInterior] = strval(arrCoords[6]);
			Houses[idx][EnterAngle] = floatstr(arrCoords[7]);
			Houses[idx][ExitX] = floatstr(arrCoords[8]);
			Houses[idx][ExitY] = floatstr(arrCoords[9]);
			Houses[idx][ExitZ] = floatstr(arrCoords[10]);
			Houses[idx][ExitInterior] = strval(arrCoords[11]);
			Houses[idx][ExitAngle] = floatstr(arrCoords[12]);
			Houses[idx][Owned] = strval(arrCoords[13]);
			Houses[idx][Rentable] = strval(arrCoords[14]);
			Houses[idx][RentCost] = strval(arrCoords[15]);
			Houses[idx][HousePrice] = strval(arrCoords[16]);
			Houses[idx][Materials] = strval(arrCoords[17]);
			Houses[idx][Drugs] = strval(arrCoords[18]);
			Houses[idx][Money] = strval(arrCoords[19]);
			Houses[idx][Locked] = strval(arrCoords[20]);
			Houses[idx][PickupID] = strval(arrCoords[21]);

			if(Houses[idx][HousePrice] != 0) // Don't create the house icon if the price is 0.
			{
				if(Houses[idx][Owned] == 0)
				{
					Houses[idx][PickupID] = CreateStreamPickup(1273, 1, Houses[idx][EnterX], Houses[idx][EnterY], Houses[idx][EnterZ],PICKUP_RANGE);
				}
				else if(Houses[idx][Owned] == 1)
				{
					Houses[idx][PickupID] = CreateStreamPickup(1239, 1, Houses[idx][EnterX], Houses[idx][EnterY], Houses[idx][EnterZ],PICKUP_RANGE);
				}
			}
			idx++;
		}
		fclose(file);
	}
	return 1;
}
//============================================================[DYNAMIC BUILDING SYSTEM]=========================================
public LoadBuildings()
{
	new arrCoords[15][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Buildings/buildings.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(Building))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, '|');
			strmid(Building[idx][BuildingName], arrCoords[0], 0, strlen(arrCoords[0]), 255);
			Building[idx][EnterX] = floatstr(arrCoords[1]);
			Building[idx][EnterY] = floatstr(arrCoords[2]);
			Building[idx][EnterZ] = floatstr(arrCoords[3]);
			Building[idx][EntranceFee] = strval(arrCoords[4]);
			Building[idx][EnterWorld] = strval(arrCoords[5]);
			Building[idx][EnterInterior] = strval(arrCoords[6]);
			Building[idx][EnterAngle] = floatstr(arrCoords[7]);
			Building[idx][ExitX] = floatstr(arrCoords[8]);
			Building[idx][ExitY] = floatstr(arrCoords[9]);
			Building[idx][ExitZ] = floatstr(arrCoords[10]);
			Building[idx][ExitInterior] = strval(arrCoords[11]);
			Building[idx][ExitAngle] = floatstr(arrCoords[12]);
			Building[idx][Locked] = strval(arrCoords[13]);
			Building[idx][PickupID] = strval(arrCoords[14]);
			
			Building[idx][PickupID] = CreateStreamPickup(1239, 1, Building[idx][EnterX], Building[idx][EnterY], Building[idx][EnterZ],PICKUP_RANGE); //Storing the PickupID in the PickupID variable.

			printf("[Building System:] Building Name: %s - Loaded. (%d)",Building[idx][BuildingName],idx);
			idx++;
		}
		fclose(file);
	}
	return 1;
}
public SaveBuildings()
{
	new idx;
	new File: file2;
	while (idx < sizeof(Building))
	{

		new coordsstring[512];
		format(coordsstring, sizeof(coordsstring), "%s|%f|%f|%f|%d|%d|%d|%f|%f|%f|%f|%d|%f|%d|%d\n",
		Building[idx][BuildingName],
		Building[idx][EnterX],
		Building[idx][EnterY],
		Building[idx][EnterZ],
		Building[idx][EntranceFee],
		Building[idx][EnterWorld],
		Building[idx][EnterInterior],
		Building[idx][EnterAngle],
		Building[idx][ExitX],
		Building[idx][ExitY],
		Building[idx][ExitZ],
		Building[idx][ExitInterior],
		Building[idx][ExitAngle],
		Building[idx][Locked],
		Building[idx][PickupID]);

		if(idx == 0)
		{
			file2 = fopen("CRP_Scriptfiles/Buildings/buildings.cfg", io_write);
		}
		else
		{
			file2 = fopen("CRP_Scriptfiles/Buildings/buildings.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	return 1;
}
//==============================================================================================================================

//===========================================================[DYNAMIC FACTION SYSTEM]===========================================
public LoadDynamicFactions()
{
	new arrCoords[33][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Factions/factions.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(DynamicFactions))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, '|');
			strmid(DynamicFactions[idx][fName], arrCoords[0], 0, strlen(arrCoords[0]), 255);
			DynamicFactions[idx][fX] = floatstr(arrCoords[1]);
			DynamicFactions[idx][fY] = floatstr(arrCoords[2]);
			DynamicFactions[idx][fZ] = floatstr(arrCoords[3]);
			DynamicFactions[idx][fMaterials] = strval(arrCoords[4]);
			DynamicFactions[idx][fDrugs] = strval(arrCoords[5]);
			DynamicFactions[idx][fBank] = strval(arrCoords[6]);
			strmid(DynamicFactions[idx][fRank1], arrCoords[7], 0, strlen(arrCoords[7]), 255);
			strmid(DynamicFactions[idx][fRank2], arrCoords[8], 0, strlen(arrCoords[8]), 255);
            strmid(DynamicFactions[idx][fRank3], arrCoords[9], 0, strlen(arrCoords[9]), 255);
            strmid(DynamicFactions[idx][fRank4], arrCoords[10], 0, strlen(arrCoords[10]), 255);
            strmid(DynamicFactions[idx][fRank5], arrCoords[11], 0, strlen(arrCoords[11]), 255);
            strmid(DynamicFactions[idx][fRank6], arrCoords[12], 0, strlen(arrCoords[12]), 255);
            strmid(DynamicFactions[idx][fRank7], arrCoords[13], 0, strlen(arrCoords[13]), 255);
            strmid(DynamicFactions[idx][fRank8], arrCoords[14], 0, strlen(arrCoords[14]), 255);
            strmid(DynamicFactions[idx][fRank9], arrCoords[15], 0, strlen(arrCoords[15]), 255);
            strmid(DynamicFactions[idx][fRank10], arrCoords[16], 0, strlen(arrCoords[16]), 255);
			DynamicFactions[idx][fSkin1] = strval(arrCoords[17]);
			DynamicFactions[idx][fSkin2] = strval(arrCoords[18]);
			DynamicFactions[idx][fSkin3] = strval(arrCoords[19]);
			DynamicFactions[idx][fSkin4] = strval(arrCoords[20]);
			DynamicFactions[idx][fSkin5] = strval(arrCoords[21]);
			DynamicFactions[idx][fSkin6] = strval(arrCoords[22]);
			DynamicFactions[idx][fSkin7] = strval(arrCoords[23]);
			DynamicFactions[idx][fSkin8] = strval(arrCoords[24]);
			DynamicFactions[idx][fSkin9] = strval(arrCoords[25]);
			DynamicFactions[idx][fSkin10] = strval(arrCoords[26]);
			DynamicFactions[idx][fJoinRank] = strval(arrCoords[27]);
			DynamicFactions[idx][fUseSkins] = strval(arrCoords[28]);
			DynamicFactions[idx][fType] = strval(arrCoords[29]);
			DynamicFactions[idx][fRankAmount] = strval(arrCoords[30]);
			strmid(DynamicFactions[idx][fColor], arrCoords[31], 0, strlen(arrCoords[31]), 255);
			DynamicFactions[idx][fUseColor] = strval(arrCoords[32]);
			printf("[DYNAMIC FACTIONS:] Faction Name: %s, Type: %d, ID: %d",DynamicFactions[idx][fName],DynamicFactions[idx][fType],idx);
			idx++;
		}
		fclose(file);
	}
	return 1;
}
public SaveDynamicFactions()
{
	new idx;
	new File: file2;
	while (idx < sizeof(DynamicFactions))
	{

		new coordsstring[512];
		format(coordsstring, sizeof(coordsstring), "%s|%f|%f|%f|%d|%d|%d|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%s|%d\n",
		DynamicFactions[idx][fName],
		DynamicFactions[idx][fX],
		DynamicFactions[idx][fY],
		DynamicFactions[idx][fZ],
		DynamicFactions[idx][fMaterials],
		DynamicFactions[idx][fDrugs],
		DynamicFactions[idx][fBank],
		DynamicFactions[idx][fRank1],
		DynamicFactions[idx][fRank2],
		DynamicFactions[idx][fRank3],
		DynamicFactions[idx][fRank4],
		DynamicFactions[idx][fRank5],
		DynamicFactions[idx][fRank6],
		DynamicFactions[idx][fRank7],
		DynamicFactions[idx][fRank8],
		DynamicFactions[idx][fRank9],
		DynamicFactions[idx][fRank10],
		DynamicFactions[idx][fSkin1],
		DynamicFactions[idx][fSkin2],
		DynamicFactions[idx][fSkin3],
		DynamicFactions[idx][fSkin4],
		DynamicFactions[idx][fSkin5],
		DynamicFactions[idx][fSkin6],
		DynamicFactions[idx][fSkin7],
		DynamicFactions[idx][fSkin8],
		DynamicFactions[idx][fSkin9],
		DynamicFactions[idx][fSkin10],
		DynamicFactions[idx][fJoinRank],
		DynamicFactions[idx][fUseSkins],
		DynamicFactions[idx][fType],
		DynamicFactions[idx][fRankAmount],
		DynamicFactions[idx][fColor],
		DynamicFactions[idx][fUseColor]);

		if(idx == 0)
		{
			file2 = fopen("CRP_Scriptfiles/Factions/factions.cfg", io_write);
		}
		else
		{
			file2 = fopen("CRP_Scriptfiles/Factions/factions.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	return 1;
}
//=====================================================[DYNAMIC CAR SYSTEM]=====================================================
public LoadDynamicCars()
{
	new arrCoords[9][64];
	new strFromFile2[256];
	new File: file = fopen("CRP_Scriptfiles/Cars/carspawns.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(DynamicCars))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, '|');
			DynamicCars[idx][CarModel] = strval(arrCoords[0]);
			DynamicCars[idx][CarX] = floatstr(arrCoords[1]);
			DynamicCars[idx][CarY] = floatstr(arrCoords[2]);
			DynamicCars[idx][CarZ] = floatstr(arrCoords[3]);
			DynamicCars[idx][CarAngle] = floatstr(arrCoords[4]);
			DynamicCars[idx][CarColor1] = strval(arrCoords[5]);
			DynamicCars[idx][CarColor2] = strval(arrCoords[6]);
			DynamicCars[idx][FactionCar] = strval(arrCoords[7]);
			DynamicCars[idx][CarType] = strval(arrCoords[8]);
			
			new vehicleid = CreateVehicle(DynamicCars[idx][CarModel],DynamicCars[idx][CarX],DynamicCars[idx][CarY],DynamicCars[idx][CarZ],DynamicCars[idx][CarAngle],DynamicCars[idx][CarColor1],DynamicCars[idx][CarColor2], -1);

			if(DynamicCars[idx][FactionCar] != 255)
			{
				SetVehicleNumberPlate(vehicleid, DynamicFactions[DynamicCars[idx][FactionCar]][fName]);
				SetVehicleToRespawn(vehicleid);
			}
			idx++;
		}
		fclose(file);
	}
	return 1;
}
public SaveDynamicCars()
{
	new idx;
	new File: file2;
	while (idx < sizeof(DynamicCars))
	{

		new coordsstring[512];
		format(coordsstring, sizeof(coordsstring), "%d|%f|%f|%f|%f|%d|%d|%d|%d\n",
		DynamicCars[idx][CarModel],
		DynamicCars[idx][CarX],
		DynamicCars[idx][CarY],
		DynamicCars[idx][CarZ],
		DynamicCars[idx][CarAngle],
		DynamicCars[idx][CarColor1],
		DynamicCars[idx][CarColor2],
		DynamicCars[idx][FactionCar],
		DynamicCars[idx][CarType]);

		if(idx == 0)
		{
			file2 = fopen("CRP_Scriptfiles/Cars/carspawns.cfg", io_write);
		}
		else
		{
			file2 = fopen("CRP_Scriptfiles/Cars/carspawns.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	return 1;
}
//===============================================================================================================================
stock StopMusic(playerid)
{
	PlayerPlaySound(playerid, 1069, 0.0, 0.0, 0.0);
}
public SyncTime()
{
	new tmphour;
	new tmpminute;
	new tmpsecond;
	gettime(tmphour, tmpminute, tmpsecond);
	FixHour(tmphour);
	tmphour = shifthour;
	if ((tmphour > ghour) || (tmphour == 0 && ghour == 23))
	{
		ghour = tmphour;
		PayDay();
		if (realtime)
		{
			SetWorldTime(tmphour);
		}
	}
}
public ShowStats(playerid,targetid)
{
    if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		if(gPlayerLogged[targetid])
		{
			SendClientMessage(playerid,COLOR_YELLOW,"____________________________________________________");
			
			new wstring[128];
			new level = PlayerInfo[targetid][pLevel];
			new exp = PlayerInfo[targetid][pExp];
			new nxtlevel = PlayerInfo[targetid][pLevel]+1;
			new expamount = nxtlevel*levelexp;
			new drugs = PlayerInfo[targetid][pDrugs];
			new mats = PlayerInfo[targetid][pMaterials];
			new housekey = PlayerInfo[targetid][pHouseKey];
			new bizkey = PlayerInfo[targetid][pBizKey];
		    new playinghours = PlayerInfo[targetid][pPlayingHours];
		    new bank = PlayerInfo[targetid][pBank];
		    new warnings = PlayerInfo[targetid][pWarnings];
		    new Float:hp;
			GetPlayerHealth(targetid,hp);
 			new age = PlayerInfo[targetid][pAge];
 			new products = PlayerInfo[targetid][pProducts];
 			new donatortext[128];
 			new phonenumbertext[128];
			new location[MAX_ZONE_NAME];
			GetPlayer2DZone(playerid, location, MAX_ZONE_NAME);
			new phonenetwork[128];
			new jobtext[128];
			new weplicense[128];
			new flylicense[128];
			new carlicense[128];
			new ranktext[256];
			
			switch(PlayerInfo[targetid][pJob])
			{
			    case 0: jobtext = "None";
			    case 1: jobtext = "Arms Dealer";
			    case 2: jobtext = "Drug Dealer";
			    case 3: jobtext = "Detective";
			    case 4: jobtext = "Lawyer";
			    case 5: jobtext = "Products Seller";
			}
			switch(PlayerInfo[targetid][pDonator])
			{
			    case 0: donatortext = "No";
			    case 1: donatortext = "Yes";
			}
			switch(PlayerInfo[targetid][pCarLic])
			{
			    case 0: carlicense = "No";
			    case 1: carlicense = "Yes";
			}
			switch(PlayerInfo[targetid][pFlyLic])
			{
			    case 0: flylicense = "No";
			    case 1: flylicense = "Yes";
			}
			switch(PlayerInfo[targetid][pWepLic])
			{
			    case 0: weplicense = "No";
			    case 1: weplicense = "Yes";
			}
			
			if(PlayerInfo[targetid][pPhoneC] == 255) { phonenetwork = "None"; } else { format(phonenetwork, sizeof(phonenetwork), "%s",Businesses[PlayerInfo[targetid][pPhoneC]][BusinessName]); }
			if(PlayerInfo[targetid][pPhoneNumber] == 0) { phonenumbertext = "None"; } else { format(phonenumbertext, sizeof(phonenumbertext), "%d",PlayerInfo[targetid][pPhoneNumber]); }
			
   			format(wstring, sizeof(wstring), "[GENERAL:] Name: %s - Health: %.1f - Cash: $%d - Level: %d - Experience: %d/%d - Materials: %d - Drugs: %d",GetPlayerNameEx(targetid),hp,GetPlayerCash(targetid),level,exp,expamount,mats,drugs);
		    SendClientMessage(playerid,COLOR_WHITE, wstring);
   			format(wstring, sizeof(wstring), "[GENERAL:] House Key: %d - Business Key: %d - Location: %s - Bank: $%d - Warnings: %d - Age: %d - Playing Hours: %d", housekey,bizkey,location,bank,warnings,age,playinghours);
		    SendClientMessage(playerid,COLOR_WHITE, wstring);
   			format(wstring, sizeof(wstring), "[GENERAL:] Phone Number: %s - Phone Network: %s - Donator: %s - Job: %s - Products: %d", phonenumbertext,phonenetwork,donatortext,jobtext,products);
		    SendClientMessage(playerid,COLOR_WHITE, wstring);
   			format(wstring, sizeof(wstring), "[LICENSES:] Driving License: %s - Flying License: %s - Weapon License: %s", carlicense, flylicense, weplicense);
		    SendClientMessage(playerid,COLOR_WHITE, wstring);
		    
		    if(PlayerInfo[targetid][pFaction] != 255)
			{
	      		switch(PlayerInfo[targetid][pRank])
			    {
			        case 1: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank1]);
			        case 2: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank2]);
			        case 3: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank3]);
			        case 4: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank4]);
			        case 5: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank5]);
			        case 6: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank6]);
			        case 7: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank7]);
			        case 8: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank8]);
			        case 9: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank9]);
			        case 10: format(ranktext, sizeof(ranktext), "%s", DynamicFactions[PlayerInfo[targetid][pFaction]][fRank10]);
			    }
		 		format(wstring, sizeof(wstring), "[FACTION:] Faction: %s - Rank: %s",DynamicFactions[PlayerInfo[targetid][pFaction]][fName],ranktext);
  				SendClientMessage(playerid,COLOR_WHITE, wstring);
			}
			else
			{
				SendClientMessage(playerid,COLOR_WHITE, "[FACTION:] Faction: None - Rank: None");
			}
		    
			SendClientMessage(playerid,COLOR_YELLOW,"____________________________________________________");
		}
	}
}
public FixHour(hour)
{
	hour = timeshift+hour;
	if (hour < 0)
	{
		hour = hour+24;
	}
	else if (hour > 23)
	{
		hour = hour-24;
	}
	shifthour = hour;
	return 1;
}
public split(const strsrc[], strdest[][], delimiter)
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
stock IsSkinValid(SkinID) return ((SkinID >= 0 && SkinID <= 1)||(SkinID == 2)||(SkinID == 7)||(SkinID >= 9 && SkinID <= 41)||(SkinID >= 43 && SkinID <= 85)||(SkinID >=87 && SkinID <= 118)||(SkinID >= 120 && SkinID <= 148)||(SkinID >= 150 && SkinID <= 207)||(SkinID >= 209 && SkinID <= 272)||(SkinID >= 274 && SkinID <= 288)||(SkinID >= 290 && SkinID <= 299)) ? true:false;

stock ClearScreen(playerid)
{
	for(new i = 0; i < 50; i++)
	{
	    SendClientMessage(playerid, COLOR_WHITE, " ");
	}
	return 0;
}
stock GetPlayerFirstName(playerid)
{
	new namestring[2][MAX_PLAYER_NAME];
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	split(name, namestring, '_');
	return namestring[0];
}
stock GetPlayerLastName(playerid)
{
	new namestring[2][MAX_PLAYER_NAME];
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,MAX_PLAYER_NAME);
	split(name, namestring, '_');
	return namestring[1];
}
stock GetVehicleCount()
{
	new count;
	for(new v = 1; v < MAX_VEHICLES; v++)
	{
		if (IsVehicleSpawned(v)) count++;
	}
	return count;
}

stock IsVehicleSpawned(vehicleid)
{
	new Float:VX,Float:VY,Float:VZ;
	GetVehiclePos(vehicleid,VX,VY,VZ);
	if (VX == 0.0 && VY == 0.0 && VZ == 0.0) return 0;
	return 1;
}
stock GetPlayerIpAddress(playerid)
{
	new IP[16];
	GetPlayerIp(playerid, IP, sizeof(IP));
	return IP;
}
RPName(name[],ret_first[],ret_last[])
{
	new len = strlen(name),
		point = -1,
		bool:done = false;
	for(new i = 0; i < len; i++)
	{
	    if(name[i] == '_')
	    {
	        if(point != -1) return 0;
	        else {
				if(i == 0) return 0;
				point = i + 1;
			}
	    } else if(point == -1) ret_first[i] = name[i];
	    else {
			ret_last[i - point] = name[i];
			done = true;
		}
	}
	if(!done) return 0;
	return 1;
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
stock GetObjectCount()
{
	new count;
	for(new o; o < MAX_OBJECTS; o++)
	{
		if (IsValidObject(o)) count++;
	}
	return count;
}

ReturnUser(text[], playerid = INVALID_PLAYER_ID)
{
	new pos = 0;
	while (text[pos] < 0x21) // Strip out leading spaces
	{
		if (text[pos] == 0) return INVALID_PLAYER_ID; // No passed text
		pos++;
	}
	new userid = INVALID_PLAYER_ID;
	if (IsNumeric(text[pos])) // Check whole passed string
	{
		// If they have a numeric name you have a problem (although names are checked on id failure)
		userid = strval(text[pos]);
		if (userid >=0 && userid < MAX_PLAYERS)
		{
			if(!IsPlayerConnected(userid))
			{
				/*if (playerid != INVALID_PLAYER_ID)
				{
					SendClientMessage(playerid, 0xFF0000AA, "User not connected");
				}*/
				userid = INVALID_PLAYER_ID;
			}
			else
			{
				return userid; // A player was found
			}
		}
		/*else
		{
			if (playerid != INVALID_PLAYER_ID)
			{
				SendClientMessage(playerid, 0xFF0000AA, "Invalid user ID");
			}
			userid = INVALID_PLAYER_ID;
		}
		return userid;*/
		// Removed for fallthrough code
	}
	// They entered [part of] a name or the id search failed (check names just incase)
	new len = strlen(text[pos]);
	new count = 0;
	new name[MAX_PLAYER_NAME];
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, name, sizeof (name));
			if (strcmp(name, text[pos], true, len) == 0) // Check segment of name
			{
				if (len == strlen(name)) // Exact match
				{
					return i; // Return the exact player on an exact match
					// Otherwise if there are two players:
					// Me and MeYou any time you entered Me it would find both
					// And never be able to return just Me's id
				}
				else // Partial match
				{
					count++;
					userid = i;
				}
			}
		}
	}
	if (count != 1)
	{
		if (playerid != INVALID_PLAYER_ID)
		{
			if (count)
			{
				SendClientMessage(playerid, 0xFF0000AA, "Multiple users found, please narrow earch");
			}
			else
			{
				SendClientMessage(playerid, 0xFF0000AA, "No matching user found");
			}
		}
		userid = INVALID_PLAYER_ID;
	}
	return userid; // INVALID_USER_ID for bad return
}
IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}
public KickPlayer(playerid,kickedby[MAX_PLAYER_NAME],reason[])
{
	new string[128];
	format(string,sizeof(string),"%s has been kicked by %s, Reason: %s ",GetPlayerNameEx(playerid),kickedby,reason);
	SendClientMessageToAll(COLOR_ADMINCMD,string);
	KickLog(string);
	return Kick(playerid);
}
public BanPlayerAccount(playerid,bannedby[MAX_PLAYER_NAME],reason[])
{
	new string[128];
	format(string,sizeof(string),"%s has been Account-Banned by %s, Reason: %s ",GetPlayerNameEx(playerid),bannedby,reason);
	SendClientMessageToAll(COLOR_ADMINCMD,string);
	AccountBanLog(string);
	PlayerInfo[playerid][pBanned] = 1;
	OnPlayerDataSave(playerid);
	return Kick(playerid);
}
public BanPlayer(playerid,bannedby[MAX_PLAYER_NAME],reason[])
{
	new string[128];
	format(string,sizeof(string),"%s has been banned by %s, Reason: %s ",GetPlayerNameEx(playerid),bannedby,reason);
	SendClientMessageToAll(COLOR_ADMINCMD,string);
	BanLog(string);
	return Ban(playerid);
}
public ShowScriptStats(playerid)
{
	new form[128];
	format(form, sizeof form, "%s [%s] | Developed by %s | Script Lines: %d | Last Updated: %s", GAMEMODE,VERSION,DEVELOPER,SCRIPT_LINES,LAST_UPDATE);
	SendClientMessage(playerid, COLOR_WHITE,form);

 	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		format(form, sizeof form, "Website: %s | Map: %s | Server Password: %s | User Connections: %d", WEBSITE,MAP_NAME,ShowServerPassword(),JoinCounter);
		SendClientMessage(playerid, COLOR_WHITE,form);
	}
	else
	{
		format(form, sizeof form, "Website: %s | Map: %s | User Connections: %d",WEBSITE,MAP_NAME,JoinCounter);
		SendClientMessage(playerid, COLOR_WHITE,form);
	}
}
public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}
stock ShowServerPassword()
{
	new pass[128];
	if (strlen(PASSWORD) != 0)
	{
		format(pass, sizeof pass, "%s", PASSWORD);
	}
	else
	{
	    pass = "None";
	}
	return pass;
}
//===============================================[ZONE FUNCTIONS]================================================================
stock GetCoords2DZone(Float:x, Float:y, zone[], len)
{
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}
stock GetPlayer2DZone(playerid, zone[], len)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}
stock GetPlayer3DZone(playerid, zone[], len)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4] && z >= gSAZones[i][SAZONE_AREA][2] && z <= gSAZones[i][SAZONE_AREA][5])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}
stock IsPlayerInZone(playerid, zone[])
{
	new TmpZone[MAX_ZONE_NAME];
	GetPlayer3DZone(playerid, TmpZone, sizeof(TmpZone));
	for(new i = 0; i != sizeof(gSAZones); i++)
	{
		if(strfind(TmpZone, zone, true) != -1)
			return 1;
	}
	return 0;
}
//====================================================[Chat Functions]=============================================================
public SendFactionMessage(faction, color, string[])
{
for(new i = 0; i < MAX_PLAYERS; i++)
{
	if(IsPlayerConnected(i))
		{
			if(PlayerInfo[i][pFaction] != 255)
		    {
			 	if(PlayerInfo[i][pFaction] == faction)
			  	{
 	 				SendClientMessage(i, color, string);
				}
			}
		}
	}
}
public SendFactionTypeMessage(factiontype, color, string[])
{
for(new i = 0; i < MAX_PLAYERS; i++)
{
	if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pFaction] != 255)
		    {
			 	if(DynamicFactions[PlayerInfo[i][pFaction]][fType] == factiontype)
			  	{
				 	if(DynamicFactions[PlayerInfo[i][pFaction]][fType] == 1)
			  	    {
			  	        if(CopOnDuty[i])
			  	        {
			  	            SendClientMessage(i, color, string);
			  	        }
			  	    }
			  	    else
			  	    {
						SendClientMessage(i, color, string);
					}
				}
			}
		}
	}
}
//==================================================================================================================================
public PickupGametexts()
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new string[128];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			GetPlayerPos(i, oldposx, oldposy, oldposz);
			if(oldposx!=0.0 && oldposy!=0.0 && oldposz!=0.0)
			{
			    //=============================================[BUILDING GAMETEXTS]==========================================
				for(new h = 0; h < sizeof(Building); h++)
				{
					if (PlayerToPoint(1.0, i,Building[h][EnterX], Building[h][EnterY], Building[h][EnterZ]))
					{
					if(GetPlayerCash(i) >= Building[h][EntranceFee])
					{
					    if(Building[h][EntranceFee] > 1)
					    {
					    	format(string, sizeof(string), "%s~n~~w~Entrance Fee: ~g~$%d",Building[h][BuildingName],Building[h][EntranceFee]);
					    	GameTextForPlayer(i, string, 3500, 3);
						}
						else
						{
							format(string, sizeof(string), "%s",Building[h][BuildingName]);
							GameTextForPlayer(i, string, 3500, 3);
						}
					}
					else
					{
         				if(Building[h][EntranceFee] > 1)
         				{
         					format(string, sizeof(string), "%s~n~~w~Entrance Fee: ~r~$%d",Building[h][BuildingName],Building[h][EntranceFee]);
         					GameTextForPlayer(i, string, 3500, 3);
         				}
         				else
         				{
         					format(string, sizeof(string), "%s",Building[h][BuildingName]);
         					GameTextForPlayer(i, string, 3500, 3);
         				}
					}
					}
				}
				//=========================================================================================================
				//======================================[HOUSE GAMETEXTS]===================================================
				for(new n = 0; n < sizeof(Houses); n++)
				{
					if (PlayerToPoint(1.0, i,Houses[n][EnterX], Houses[n][EnterY], Houses[n][EnterZ]))
					{
					    if(Houses[n][HousePrice] != 0) //Only show the house if price is set
					    {
						    if(Houses[n][Owned] == 0)
						    {
			    				new houselocation[MAX_ZONE_NAME];
								GetCoords2DZone(Houses[n][EnterX],Houses[n][EnterY], houselocation, MAX_ZONE_NAME);
								format(string, sizeof(string), "~g~This house is for sale!~n~~w~Address: ~y~ %d %s~n~~w~Description: ~y~%s ~n~~w~Price: ~y~$%d~n~%s",n,houselocation,Houses[n][Description],Houses[n][HousePrice]);
						    	GameTextForPlayer(i, string, 3500, 3);
							}
							else
							{
							    if(Houses[n][Rentable] == 1)
							    {
		   							new houselocation[MAX_ZONE_NAME];
									GetCoords2DZone(Houses[n][EnterX],Houses[n][EnterY], houselocation, MAX_ZONE_NAME);
			    					format(string, sizeof(string), "~w~Address: ~y~%d %s~n~~w~Owner: ~y~%s ~n~~w~Description: ~y~%s~n~~w~Rent Price: ~y~$%d",n,houselocation,Houses[n][Owner],Houses[n][Description],Houses[n][RentCost]);
							    	GameTextForPlayer(i, string, 3500, 3);
							    }
							    else
							    {
		  							new houselocation[MAX_ZONE_NAME];
									GetCoords2DZone(Houses[n][EnterX],Houses[n][EnterY], houselocation, MAX_ZONE_NAME);
			    					format(string, sizeof(string), "~w~Address: ~y~%d %s~n~~w~Owner: ~y~%s ~n~~w~Description: ~y~%s",n,houselocation,Houses[n][Owner],Houses[n][Description]);
							    	GameTextForPlayer(i, string, 3500, 3);
						    	}
							}
						}
					}
				}
				//=======================================[BUSINESS GAMETEXTS]=========================================================
				for(new n = 0; n < sizeof(Businesses); n++)
				{
					if (PlayerToPoint(1.0, i,Businesses[n][EnterX], Businesses[n][EnterY], Businesses[n][EnterZ]))
					{
					    new businesstype[128];
					    if(Businesses[n][BizType] != 0)
					    {
	    					if(Businesses[n][BizType] == 1) { businesstype = "Restaurant"; }
						    else if(Businesses[n][BizType] == 2) { businesstype = "Phone Company"; }
						    else if(Businesses[n][BizType] == 3) { businesstype = "24-7 Store"; }
						    else if(Businesses[n][BizType] == 4) { businesstype = "Ammunation"; }
						    else if(Businesses[n][BizType] == 5) { businesstype = "Advertising"; }
						    else if(Businesses[n][BizType] == 6) { businesstype = "Clothes Store"; }
						    else if(Businesses[n][BizType] == 7) { businesstype = "Bar/Club"; }
					    }
					    else { businesstype = "None Set"; }
					    
					    if(Businesses[n][BizPrice] != 0) //Only show the business if price is set
					    {
						    if(Businesses[n][Owned] == 0)
						    {
								format(string, sizeof(string), "~g~This business is for sale!~n~~w~Business Name: ~y~%s ~n~~w~Business Type: ~y~%s ~n~~w~Price: ~y~$%d",Businesses[n][BusinessName],businesstype,Businesses[n][BizPrice]);
						    	GameTextForPlayer(i, string, 3500, 3);
							}
							else
							{
	  							format(string, sizeof(string), "~w~Business Name: ~y~%s ~n~~w~Business Type: ~y~%s ~n~~w~Owner: ~y~%s~n~~w~Entrance Fee: ~y~$%d",Businesses[n][BusinessName],businesstype,Businesses[n][Owner],Businesses[n][EntranceCost]);
					    		GameTextForPlayer(i, string, 3500, 3);
							}
						}
					}
				}
				//=========================================[FUEL GAMETEXT]=============================================================
    			if(ShowFuel[i] && GetPlayerState(i) == PLAYER_STATE_DRIVER)
    			{
    			    new form[128];
    				new vehicle = GetPlayerVehicleID(i);
    				if(!OutOfFuel[i])
    				{
	    				if(Fuel[vehicle] <= 25)
	    				{
	    				    if(EngineStatus[vehicle])
	    				    {
	   	    					format(form, sizeof(form), "~w~~n~~n~~n~~n~~n~~n~~y~Engine running.~n~~w~Fuel:~g~ %d%~n~~r~Low Fuel.",Fuel[vehicle]);
		    					GameTextForPlayer(i,form,1000,5);
	    				    }
	    				    else
	    				    {
	   	    					format(form, sizeof(form), "~w~~n~~n~~n~~n~~n~~n~~y~Engine not running.~n~~w~Fuel:~g~ %d%~n~~r~Low Fuel.",Fuel[vehicle]);
		    					GameTextForPlayer(i,form,1000,5);
	    				    }
	    				}
	  					else
	  					{
	  					    if(EngineStatus[vehicle])
	  					    {
		  						format(form, sizeof(form), "~w~~n~~n~~n~~n~~n~~n~~y~Engine running.~n~~w~Fuel:~g~ %d%",Fuel[vehicle]);
		  						GameTextForPlayer(i,form,1000,5);
	  						}
	  						else
	  						{
	  							format(form, sizeof(form), "~w~~n~~n~~n~~n~~n~~n~~y~Engine not running.~n~~w~Fuel:~g~ %d%",Fuel[vehicle]);
		  						GameTextForPlayer(i,form,1000,5);
	  						}
	  					}
  					}
  				}
  				//========================================================================================================================
				//======================================================================================================
				if (PlayerToPoint(1.0, i,DrivingTestPosition[X],DrivingTestPosition[Y],DrivingTestPosition[Z]))
				{
				    if(GetPlayerVirtualWorld(i) == DrivingTestPosition[World])
				    {
						GameTextForPlayer(i, "~w~Driving Test~n~Price: ~g~$500~n~~w~Type /takedrivingtest now!", 3500, 3);
					}
				}
				else if(PlayerToPoint(1.0, i,FlyingTestPosition[X],FlyingTestPosition[Y],FlyingTestPosition[Z]))
				{
    				if(GetPlayerVirtualWorld(i) == FlyingTestPosition[World])
	     			{
						GameTextForPlayer(i, "~w~Flying License~n~Price: ~g~$20000~n~~w~Type /buyflyinglicense now!", 3500, 3);
					}
				}
				else if(PlayerToPoint(1.0, i,WeaponLicensePosition[X],WeaponLicensePosition[Y],WeaponLicensePosition[Z]))
				{
    				if(GetPlayerVirtualWorld(i) == WeaponLicensePosition[World])
	     			{
						GameTextForPlayer(i, "~w~Weapon License~n~Price: ~g~$50000~n~~w~Type /buyweaponlicense now!", 3500, 3);
					}
				}
				else if(PlayerToPoint(1.0, i,BankPosition[X],BankPosition[Y],BankPosition[Z]))
				{
    				if(GetPlayerVirtualWorld(i) == BankPosition[World])
	     			{
						GameTextForPlayer(i, "~w~The Bank", 3500, 3);
					}
				}
				else if(PlayerToPoint(1.0, i,FactionMaterialsStorage[X],FactionMaterialsStorage[Y],FactionMaterialsStorage[Z]))
				{
				    if(PlayerInfo[i][pFaction] != 255 && DynamicFactions[PlayerInfo[i][pFaction]][fType] != 1)
				    {
				    	GameTextForPlayer(i, "~w~Faction Materials Storage", 3500, 3);
				    }
				    else
				    {
				    	GameTextForPlayer(i, "~r~Unknown", 3500, 3);
				    }
				}
				else if(PlayerToPoint(1.0, i,FactionDrugsStorage[X],FactionDrugsStorage[Y],FactionDrugsStorage[Z]))
				{
				    if(PlayerInfo[i][pFaction] != 255 && DynamicFactions[PlayerInfo[i][pFaction]][fType] != 1)
				    {
   						GameTextForPlayer(i, "~w~Faction Drugs Storage", 3500, 3);
				    }
				    else
				    {
				    	GameTextForPlayer(i, "~r~Unknown", 3500, 3);
				    }
				}
    			else if(PlayerToPoint(1.0, i,GunJob[TakeJobX],GunJob[TakeJobY],GunJob[TakeJobZ]))
				{
				    if(GetPlayerVirtualWorld(i) == GunJob[TakeJobWorld])
				    {
   						GameTextForPlayer(i, "~n~~r~Arms Dealer Job~n~~w~/takejob", 3500, 3);
   					}
				}
				else if(PlayerToPoint(1.0, i,GunJob[BuyPackagesX],GunJob[BuyPackagesY],GunJob[BuyPackagesZ]))
				{
				    if(GetPlayerVirtualWorld(i) == GunJob[BuyPackagesWorld])
				    {
   						GameTextForPlayer(i, "~n~~r~Arms Dealer Job~n~~w~/materials buy", 3500, 3);
   					}
				}
    			else if(PlayerToPoint(1.0, i,GunJob[DeliverX],GunJob[DeliverY],GunJob[DeliverZ]))
				{
				    if(GetPlayerVirtualWorld(i) == GunJob[DeliverWorld])
				    {
   						GameTextForPlayer(i, "~n~~r~Arms Dealer Job~n~~w~/materials dropoff", 3500, 3);
   					}
				}
 				else if(PlayerToPoint(1.0, i,DrugJob[TakeJobX],DrugJob[TakeJobY],DrugJob[TakeJobZ]))
				{
				    if(GetPlayerVirtualWorld(i) == DrugJob[TakeJobWorld])
				    {
   						GameTextForPlayer(i, "~n~~r~Drug Dealer Job~n~~w~/takejob", 3500, 3);
   					}
				}
				else if(PlayerToPoint(1.0, i,DrugJob[BuyDrugsX],DrugJob[BuyDrugsY],DrugJob[BuyDrugsZ]))
				{
				    if(GetPlayerVirtualWorld(i) == DrugJob[BuyDrugsWorld])
				    {
   						GameTextForPlayer(i, "~n~~r~Drug Dealer Job~n~~w~/drugs buy", 3500, 3);
   					}
				}
    			else if(PlayerToPoint(1.0, i,DrugJob[DeliverX],DrugJob[DeliverY],DrugJob[DeliverZ]))
				{
				    if(GetPlayerVirtualWorld(i) == DrugJob[DeliverWorld])
				    {
   						GameTextForPlayer(i, "~n~~r~Drug Dealer Job~n~~w~/drugs dropoff", 3500, 3);
   					}
				}
				else if(PlayerToPoint(1.0, i,DetectiveJobPosition[X],DetectiveJobPosition[Y],DetectiveJobPosition[Z]))
				{
				    if(GetPlayerVirtualWorld(i) == DetectiveJobPosition[World])
				    {
   						GameTextForPlayer(i, "~n~~r~Detective Job~n~~w~/takejob", 3500, 3);
   					}
				}
    			else if(PlayerToPoint(1.0, i,LawyerJobPosition[X],LawyerJobPosition[Y],LawyerJobPosition[Z]))
				{
				    if(GetPlayerVirtualWorld(i) == LawyerJobPosition[World])
				    {
   						GameTextForPlayer(i, "~n~~r~Lawyer Job~n~~w~/takejob", 3500, 3);
   					}
				}
				else if(PlayerToPoint(1.0, i,ProductsSellerJob[TakeJobX],ProductsSellerJob[TakeJobY],ProductsSellerJob[TakeJobZ]))
				{
				    if(GetPlayerVirtualWorld(i) == ProductsSellerJob[TakeJobWorld])
				    {
   						GameTextForPlayer(i, "~n~~r~Products Seller Job~n~~w~/takejob", 3500, 3);
   					}
				}
				else if(PlayerToPoint(1.0, i,ProductsSellerJob[BuyProductsX],ProductsSellerJob[BuyProductsY],ProductsSellerJob[BuyProductsZ]))
				{
				    if(GetPlayerVirtualWorld(i) == ProductsSellerJob[BuyProductsWorld])
				    {
   						GameTextForPlayer(i, "~n~~r~Products Seller Job~n~~w~/products buy", 3500, 3);
   					}
				}
				//=============================================================================================================
			}
		}
	}
	return 1;
}
public FuelTimer()
{
	//=============================================[TAKING FUEL FROM CARS WITH PLAYERS IN THEM]=================================
	for(new i=0;i<MAX_PLAYERS;i++)
	{
    	if(IsPlayerConnected(i))
       	{
       	    if(GetPlayerState(i) == PLAYER_STATE_DRIVER)
       	    {
	       		new vehicle = GetPlayerVehicleID(i);
	        	if(Fuel[vehicle] >= 1) //Fuel wont be taken unless the engine is on.
		   		{
		   		    if(EngineStatus[vehicle])
		   		    {
	              		Fuel[vehicle]--;
	              		if(IsAPlane(vehicle)) { Fuel[vehicle]++; }
	              	}
		   		}
	   			else
	           	{
					OutOfFuel[i] = 1;
		        	GameTextForPlayer(i,"~r~You have ran out of fuel!",1500,3);
		        	TogglePlayerControllable(i,0);
				}
			}
		}
     }
     //======================================================================================================================
	//===========================================[TAKING FUEL FROM UNOCCUPIED CARS WITH ENGINE ON]======================================
 	for(new c=0;c<MAX_VEHICLES;c++)
	{
	    if(EngineStatus[c])
	    {
	        if(IsVehicleOccupied(c) == 0) //Will only take fuel if the car is unoccupied.
	        {
		        if(Fuel[c] >= 1)
		        {
		        	Fuel[c]--;
		        }
	        }
	    }
	}
	//=======================================================================================================================
	return 1;
}
public IsAtGasStation(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		if(PlayerToPoint(6.0,playerid,1004.0070,-939.3102,42.1797) || PlayerToPoint(6.0,playerid,1944.3260,-1772.9254,13.3906))
		{//LS
		    return 1;
		}
		else if(PlayerToPoint(6.0,playerid,-90.5515,-1169.4578,2.4079) || PlayerToPoint(6.0,playerid,-1609.7958,-2718.2048,48.5391))
		{//LS
		    return 1;
		}
		else if(PlayerToPoint(6.0,playerid,-2029.4968,156.4366,28.9498) || PlayerToPoint(8.0,playerid,-2408.7590,976.0934,45.4175))
		{//SF
		    return 1;
		}
		else if(PlayerToPoint(5.0,playerid,-2243.9629,-2560.6477,31.8841) || PlayerToPoint(8.0,playerid,-1676.6323,414.0262,6.9484))
		{//Between LS and SF
		    return 1;
		}
		else if(PlayerToPoint(6.0,playerid,2202.2349,2474.3494,10.5258) || PlayerToPoint(10.0,playerid,614.9333,1689.7418,6.6968))
		{//LV
		    return 1;
		}
		else if(PlayerToPoint(8.0,playerid,-1328.8250,2677.2173,49.7665) || PlayerToPoint(6.0,playerid,70.3882,1218.6783,18.5165))
		{//LV
		    return 1;
		}
		else if(PlayerToPoint(8.0,playerid,2113.7390,920.1079,10.5255) || PlayerToPoint(6.0,playerid,-1327.7218,2678.8723,50.0625))
		{//LV
		    return 1;
		}
	}
	return 0;
}
public RemoveDriverFromVehicle(playerid) //This function will be used to avoid issue when removing players from vehicle and them being froze.
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		RemovePlayerFromVehicle(playerid);
		TogglePlayerControllable(playerid,1);
		return 1;
	}
	return 0;
}
//====================================================[ACTION MESSAGES]================================================
public PlayerLocalMessage(playerid,Float:radius,message[])
{
	//This is for messages like "Blah has crashed"
	new string[128];
	format(string, sizeof(string), "[LOCAL:] %s %s", GetPlayerNameEx(playerid), message);
	ProxDetector(20.0, playerid, string, COLOR_LOCALMSG,COLOR_LOCALMSG,COLOR_LOCALMSG,COLOR_LOCALMSG,COLOR_LOCALMSG);
	PlayerLocalLog(string);
	return 1;
}
public PlayerActionMessage(playerid,Float:radius,message[])
{
	//This is for messages like "Blah has opened the door".
	new string[128];
	format(string, sizeof(string), "[ACTION:] %s %s", GetPlayerNameEx(playerid), message);
	ProxDetector(20.0, playerid, string, COLOR_LIGHTBLUE,COLOR_LIGHTBLUE,COLOR_LIGHTBLUE,COLOR_LIGHTBLUE,COLOR_LIGHTBLUE);
	PlayerActionLog(string);
	return 1;
}
public PlayerPlayerActionMessage(playerid,targetid,Float:radius,message[])
{
	//This is for messages like "Blah has opened the door for Steve".
	new string[128];
	format(string, sizeof(string), "[ACTION:] %s %s %s.", GetPlayerNameEx(playerid), message,GetPlayerNameEx(targetid));
	ProxDetector(20.0, playerid, string, COLOR_LIGHTBLUE,COLOR_LIGHTBLUE,COLOR_LIGHTBLUE,COLOR_LIGHTBLUE,COLOR_LIGHTBLUE);
	PlayerActionLog(string);
	return 1;
}
//======================================================================================================================

//================================================[VEHICLE CHECK FUNCTIONS]==============================================
public IsVehicleOccupied(vehicleid)
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerInVehicle(i,vehicleid)) return 1;
	}
	return 0;
}
public IsAPlane(vehicleid)
{   new model = GetVehicleModel(vehicleid);
	if(model == 592 || model == 577 || model == 511 || model == 512 || model == 593 || model == 520 || model == 553 || model == 476 || model == 519 || model == 460 || model == 513)
	{
		return 1;
	}
	return 0;
}
public IsAHelicopter(vehicleid)
{   new model = GetVehicleModel(vehicleid);
	if(model == 548 || model == 525 || model == 417 || model == 487 || model == 488 || model == 497 || model == 563 || model == 447 || model == 469)
	{
		return 1;
	}
	return 0;
}
public IsABike(vehicleid)
{   new model = GetVehicleModel(vehicleid);
	if(model == 581 || model == 509 || model == 481 || model == 462 || model == 521 || model == 463 || model == 510 || model == 522 || model == 461 || model == 448 || model == 471 || model == 468 || model == 586)
	{
		return 1;
	}
	return 0;
}
//=======================================================================================================================

//==============================================[INT/OTHER FUNCTIONS]====================================================
stock HexToInt(string[]) {
  if (string[0]==0) return 0;
  new i;
  new cur=1;
  new res=0;
  for (i=strlen(string);i>0;i--) {
    if (string[i-1]<58) res=res+cur*(string[i-1]-48); else res=res+cur*(string[i-1]-65+10);
    cur=cur*16;
  }
  return res;
}
//========================================================================================================================
public AddsOn()
{
	adds=1;
	return 1;
}
//======================================================[LOGS]=============================================================
public PayLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("CRP_Scriptfiles/Logs/pay.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
public HackLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("CRP_Scriptfiles/Logs/hack.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
public KickLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("CRP_Scriptfiles/Logs/kick.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
public AccountBanLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("CRP_Scriptfiles/Logs/accountban.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
public BanLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("CRP_Scriptfiles/Logs/ban.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
public PlayerActionLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("CRP_Scriptfiles/Logs/playeraction.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
public PlayerLocalLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("CRP_Scriptfiles/Logs/playerlocal.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
public TalkLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("CRP_Scriptfiles/Logs/talk.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public FactionChatLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("CRP_Scriptfiles/Logs/factionchat.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
public SMSLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("CRP_Scriptfiles/Logs/sms.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
public PMLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("CRP_Scriptfiles/Logs/pm.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
public DonatorLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("CRP_Scriptfiles/Logs/donator.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
public ReportLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("CRP_Scriptfiles/Logs/report.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
public OOCLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("CRP_Scriptfiles/Logs/ooc.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
//============================================================================================================================
public AdministratorMessage(color,const string[],level)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (PlayerInfo[i][pAdmin] >= level)
			{
			    if(AdminDuty[i] == 1)
			    {
					SendClientMessage(i, color, string);
				}
			}
		}
	}
	return 1;
}
public HangupTimer(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid))
	{
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE)
		{
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
			return 1;
		}
	}
	return 0;
}
stock PlayerName(playerid) {
  new name[255];
  GetPlayerName(playerid, name, 255);
  return name;
}
public IsACopSkin(skinid)
{
	if(skinid == 280 || skinid == 281 || skinid == 282 || skinid == 283 || skinid == 288 || skinid == 284 || skinid == 285 || skinid == 286 || skinid == 287)
	{
		return 1;
	}
	return 0;
}
public JailTimer()
{
	new string[128];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(PlayerInfo[i][pJailed] == 1)
	    {
	    	if(PlayerInfo[i][pJailTime] != 0)
	    	{
				PlayerInfo[i][pJailTime]--;
				format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~w~Time Left: ~g~%d seconds.",PlayerInfo[i][pJailTime]);
   				GameTextForPlayer(i, string, 999, 3);
			}
			if(PlayerInfo[i][pJailTime] == 0)
			{
			    PlayerInfo[i][pJailed] = 0;
				SendClientMessage(i, COLOR_LIGHTYELLOW2,"[INFO:] You have served your sentence, your now free to go.");
				SetPlayerVirtualWorld(i,2);
			    SetPlayerInterior(i, 6);
				SetPlayerPos(i,268.0903,77.6489,1001.0391);
			}
		}
	}
	return 1;
}
public PhoneAnimation(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid))
	{
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
		SetTimerEx("HangupTimer", 1000, false, "i", playerid);
		return 1;
	}
	return 0;
}
public DrugEffect(playerid)
{
	SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] Your stoned!");
 	SetPlayerWeather(playerid, 500);
    ApplyAnimation(playerid,"PED","WALK_DRUNK",4.1,1,1,1,1,1);
    SetTimerEx("UndrugEffect", 8000, false, "i", playerid);
	return 1;
}
public UndrugEffect(playerid)
{
	SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] Your not stoned anymore!");
 	SetPlayerWeather(playerid, 0);
	DrugsIntake[playerid] = 0;
	return 1;
}
stock IsValidSkin(skinid)
{
    #define	MAX_BAD_SKINS 22
    new badSkins[MAX_BAD_SKINS] =
    {
        3, 4, 5, 6, 8, 42, 65, 74, 86,
        119, 149, 208, 265, 266, 267,
        268, 269, 270, 271, 272, 273, 289
    };
    if (skinid < 0 || skinid > 299) return false;
    for (new i = 0; i < MAX_BAD_SKINS; i++)
    {
        if (skinid == badSkins[i]) return false;
    }
    #undef MAX_BAD_SKINS
    return 1;
}
public GetClosestPlayer(p1)
{
	new x,Float:dis,Float:dis2,player;
	player = -1;
	dis = 99999.99;
	for (x=0;x<MAX_PLAYERS;x++)
	{
		if(IsPlayerConnected(x))
		{
			if(x != p1)
			{
				dis2 = GetDistanceBetweenPlayers(x,p1);
				if(dis2 < dis && dis2 != -1.00)
				{
					dis = dis2;
					player = x;
				}
			}
		}
	}
	return player;
}
public Float:GetDistanceBetweenPlayers(p1,p2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if(!IsPlayerConnected(p1) || !IsPlayerConnected(p2))
	{
		return -1.00;
	}
	GetPlayerPos(p1,x1,y1,z1);
	GetPlayerPos(p2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}
public ResetPlayerWantedLevelEx(playerid)
{
  	SetPlayerWantedLevel(playerid, 0);
	WantedLevel[playerid] = 0;
	return 1;
}
public SetPlayerWantedLevelEx(playerid,level)
{
  	SetPlayerWantedLevel(playerid, level);
	WantedLevel[playerid] = level;
	return 1;
}
public GetPlayerWantedLevelEx(playerid)
{
	return WantedLevel[playerid];
}
public UntazePlayer(playerid)
{
	if(PlayerTazed[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] You are now untazed.");
	    TogglePlayerControllable(playerid,1);
	    PlayerTazed[playerid] = 0;
	    PlayerActionMessage(playerid,15.0,"is now untazed.");
	}
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if (newkeys & KEY_SECONDARY_ATTACK)
		{
	        if(EngineStatus[GetPlayerVehicleID(playerid)] == 0)
			{
				RemoveDriverFromVehicle(playerid);
			}
			if(OutOfFuel[playerid])
			{
				RemoveDriverFromVehicle(playerid);
				OutOfFuel[playerid] = 0;
			}
		}
	}
	return 1;
}
public IsAtBar(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		if(PlayerToPoint(4.0,playerid,495.7801,-76.0305,998.7578) || PlayerToPoint(4.0,playerid,499.9654,-20.2515,1000.6797))
		{//In grove street bar (with girlfriend), and in Havanna
		    return 1;
		}
		else if(PlayerToPoint(4.0,playerid,1215.9480,-13.3519,1000.9219) || PlayerToPoint(10.0,playerid,-2658.9749,1407.4136,906.2734))
		{//PIG Pen
		    return 1;
		}
	}
	return 0;
}
public ClearCheckpointsForPlayer(playerid)
{
	DisablePlayerCheckpoint(playerid);
	if(PlayerInfo[playerid][pJob] == 3)
	{
		if(TrackingPlayer[playerid])
		{
		    SendClientMessage(playerid,COLOR_LIGHTYELLOW2,"[INFO:] You are no longer tracking a player.");
			TrackingPlayer[playerid] = 0;
		}
	}
	return 1;
}
//===========================================[PICKUP STREAMER]==========================================================

public CreateStreamPickup(model,type,Float:x,Float:y,Float:z,range)
{
	new FoundID = 0;
	new ID;

	for ( new i = 0; FoundID <= 0 ; i++)
	{
	    if( Pickup[i][pickupCreated] == 0 )
	    {
	        if( FoundID == 0 )
	        {
	     	   ID = i;
	     	   FoundID = 1;
	        }
	    }
	    if( i > MAX_PICKUPS )
	    {
		    FoundID = 2;
		}
	}
	if( FoundID == 2 )
	{
	    print("Pickup limit reached! Pickup not created!");
	    return -1;
	}
	Pickup[ID][pickupCreated] = 1;
	Pickup[ID][pickupVisible] = 0;
	Pickup[ID][pickupModel] = model;
	Pickup[ID][pickupType] = type;
	Pickup[ID][pickupX] = x;
	Pickup[ID][pickupY] = y;
	Pickup[ID][pickupZ] = z;
	Pickup[ID][pickupRange] = range;
	return ID;

}
public DestroyStreamPickup(ID)
{
	if(Pickup[ID][pickupCreated])
	{
		DestroyPickup(Pickup[ID][pickupID]);
		Pickup[ID][pickupCreated] = 0;
		return 1;
	}
	return 0;
}
public CountStreamPickups()
{
	new count = 0;
	for(new i = 0; i < MAX_PICKUPS; i++)
	{
	    if(Pickup[i][pickupCreated] == 1)
	    {
			count++;
	    }
	}
	return count;
}
public StreamPickups()
{
	for(new i = 0; i < MAX_PICKUPS; i++)
	{
	    if(Pickup[i][pickupCreated] == 1)
	    {
			if(Pickup_AnyPlayerToPoint(Pickup[i][pickupRange],Pickup[i][pickupX],Pickup[i][pickupY],Pickup[i][pickupZ]))
			{
			    if(Pickup[i][pickupVisible] == 0)
			    {
			        Pickup[i][pickupID] = CreatePickup(Pickup[i][pickupModel],Pickup[i][pickupType],Pickup[i][pickupX],Pickup[i][pickupY],Pickup[i][pickupZ]);
			        Pickup[i][pickupVisible] = 1;
				}
			}
			else
			{
			    if(Pickup[i][pickupVisible] == 1)
			    {
			        DestroyPickup(Pickup[i][pickupID]);
					Pickup[i][pickupVisible] = 0;
			    }
			}
	    }
	}
}
public MoveStreamPickup(ID,Float:x,Float:y,Float:z)
{
	if(Pickup[ID][pickupCreated])
	{
	    DestroyPickup(Pickup[ID][pickupID]);
	    Pickup[ID][pickupVisible] = 0;
		Pickup[ID][pickupX] = x;
		Pickup[ID][pickupY] = y;
		Pickup[ID][pickupZ] = z;
		return 1;
	}
	return 0;
}
public ChangeStreamPickupModel(ID,newmodel)
{
    if(Pickup[ID][pickupCreated])
	{
	    DestroyPickup(Pickup[ID][pickupID]);
	    Pickup[ID][pickupVisible] = 0;
		Pickup[ID][pickupModel] = newmodel;
		return 1;
	}
	return 0;
}
public ChangeStreamPickupType(ID,newtype)
{
    if(Pickup[ID][pickupCreated])
	{
	    DestroyPickup(Pickup[ID][pickupID]);
	    Pickup[ID][pickupVisible] = 0;
		Pickup[ID][pickupType] = newtype;
		return 1;
	}
	return 0;
}
public Pickup_AnyPlayerToPoint(Float:radi, Float:x, Float:y, Float:z)
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
		{
			new Float:oldposx, Float:oldposy, Float:oldposz;
			new Float:tempposx, Float:tempposy, Float:tempposz;
			GetPlayerPos(i, oldposx, oldposy, oldposz);
			tempposx = (oldposx -x);
			tempposy = (oldposy -y);
			tempposz = (oldposz -z);
			if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
			{
				return 1;
			}
		}
	}
    return 0;
}
//===================================================================================================================================================
public GameModeRestart()
{
	new string[128];
	format(string, sizeof(string), "Game Mode Restarting.");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			DisablePlayerCheckpoint(i);
			GameTextForPlayer(i, string, 4000, 5);
			SetPlayerCameraPos(i,1460.0, -1324.0, 287.2);
			SetPlayerCameraLookAt(i,1374.5, -1291.1, 239.0);
			OnPlayerDataSave(i);
			gPlayerLogged[i] = 0;
		}
	}
	SetTimer("GameModeRestartFunction", 4000, 0);
 	SaveDynamicFactions();
	SaveDynamicCars();
	SaveCivilianSpawn();
	SaveBuildings();
	SaveHouses();
	SaveBusinesses();
	SaveFactionMaterialsStorage();
	SaveFactionDrugsStorage();
	SaveDrivingTestPosition();
	SaveFlyingTestPosition();
	SaveBankPosition();
	SaveWeaponLicensePosition();
	SavePoliceArrestPosition();
	SavePoliceDutyPosition();
	SaveGunJob();
	SaveDrugJob();
	SaveDetectiveJob();
	SaveLawyerJob();
	SaveProductsSellerJob();
	return 1;
}
public GameModeRestartFunction()
{
	GameModeExit();
}

