/*
				     * New Generation RolePlay *
      		   * Revolution in RolePlaying is here! *
 		            * Current Version: 0.67 *
		           * (c)Copyrights NGRP Team *
  		 ************************************************
    	    We have reserved all rights on this script!
		    Copying, shareing or publishing without an
		    permission is illegal! Thanks - NGRP Team
  		 ************************************************
   		 We've used some ides from GFRP, credits to FeaR!
  		 Credits also to TomsonTom, this RP was his idea.
  		 Using DracoBlue's DCMD System, credits to him.
*/

#include <a_samp>

#define COLOR_GREY          0xAFAFAFAA
#define COLOR_WHITE         0xFFFFFFAA
#define COLOR_YELLOW        0xFFFF00AA
#define COLOR_LIGHTBLUE     0x33CCFFAA
#define COLOR_LIGHTGREEN    0x9ACD32AA
#define COLOR_BLUE          0x5A8CA5AA
#define COLOR_GREEN         0x33AA33AA
#define COLOR_PURPLE        0xC2A2DAAA
#define COLOR_OTHER         0xFF6347AA
#define COLOR_ORANGE        0xFF8C00AA
#define COLOR_DMV           0xFF0000F
#define COLOR_DMV2          0xaa3333AA

#define COLOR_CHAT1         0xB4B5B7FF
#define COLOR_CHAT2         0xBFC0C2FF
#define COLOR_CHAT3         0xCBCCCEFF
#define COLOR_CHAT4         0xD8D8D8FF
#define COLOR_CHAT5         0xE3E3E3FF

forward GetClosestPlayer(p1);
forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
forward ProxDetectorS(Float:radi, playerid, targetid);
forward split(const strsrc[], strdest[][], delimiter);
forward GetDistanceBetweenPlayers(player,player2);
forward OnPlayerRegister(playerid, password[]);
forward OnPlayerUpdate(playerid);
forward OnPlayerLogin(playerid,password[]);
forward Encrypt(string[]);
forward ini_GetKey(line[]);
forward ini_GetValue(line[]);

//Timers
forward CheckPos();
forward Other();
forward Phone();
forward PayDay();
forward UpdateAccounts();
forward FuelUpdate();
forward HealthDown();

//General Functions
forward RandNumb(minamount, maxamount);
forward DepartmentMessage(const string[]);
forward RadioMessage(const string[]);
forward FamilyMessage(mafiaid, const string[]);
forward AdminMessage(const string[]);
forward TaxiMessage(const string[]);
forward AllPlayerUpdate();
forward SetRealTime();
forward SetPlayerStuff(playerid, weapon1, ammo1, weapon2, ammo2, weapon3, ammo3, health, armour);
forward SetPos(playerid, Float:X, Float:Y, Float:Z, interior, angle);
forward SetPlayerMoney(playerid,amount);
forward SpawnPlayerToJob(playerid);
forward StartPlayerCountDown(playerid,amount);
forward ReadHouses();
forward OnHouseUpdate();
forward GameModeExitStart();
forward GetCountOfPlayers();

//Other Functions
forward ShowPlayerHelpList(playerid);
forward ShowPlayerStats(playerid);
forward IsAtGasStation(playerid);
forward GiveCar(playerid);
forward StopSmoking(playerid);
forward DeathProgress(playerid);
forward FindPlayer(playerid);
forward ReFill(playerid);
forward GateClose(playerid);

new pAdmin[MAX_PLAYERS];
new pHaveAcc[MAX_PLAYERS];

new BigEar[MAX_PLAYERS];
new Mobile[MAX_PLAYERS];
new JobOffer[MAX_PLAYERS];
new JobTime[MAX_PLAYERS];
new RegistrationUpd[MAX_PLAYERS];
new CountAmount[MAX_PLAYERS];
new TicketValue[MAX_PLAYERS];
new PlayerDied[MAX_PLAYERS];
new CellTime[MAX_PLAYERS];
new RingTime[MAX_PLAYERS];
new pSpawned[MAX_PLAYERS];
new pTime[MAX_PLAYERS];
new pWatch[MAX_PLAYERS];
new IsInZip[MAX_PLAYERS];
new Tankuje[MAX_PLAYERS];
new OldMoney[MAX_PLAYERS];
new PlayerUsingAnim[MAX_PLAYERS];
new PlayerUsingCellPhoneAnim[MAX_PLAYERS];
new PlayerSitting[MAX_PLAYERS];

new pJailTime[MAX_PLAYERS];
new pJailed[MAX_PLAYERS];
new JailPrice[MAX_PLAYERS];
new WantedLvl[MAX_PLAYERS];
new pCuffTime[MAX_PLAYERS];
new OnDuty[MAX_PLAYERS];
new pCheckPoint[MAX_PLAYERS];
new pSellingCar[MAX_PLAYERS];

new TransportDuty[MAX_PLAYERS];
new TransportValue[MAX_PLAYERS];
new TransportMoney[MAX_PLAYERS];
new ConsumingMoney[MAX_PLAYERS];
new TransportCost[MAX_PLAYERS];
new TransportDriver[MAX_PLAYERS];
new TransportTime[MAX_PLAYERS];

new pWantCar[MAX_PLAYERS];
new pCarShop[MAX_PLAYERS];
new pCarPrice[MAX_PLAYERS];
new pBought[MAX_PLAYERS];
new pCar[MAX_PLAYERS];
new pCarInfo[MAX_PLAYERS];
new pDestroyingCar[MAX_PLAYERS];

new TicketOffer[MAX_PLAYERS];
new TicketMoney[MAX_PLAYERS];

new CalledBackup[MAX_PLAYERS];
new AcceptedBackup[MAX_PLAYERS];

new pCuffed[MAX_PLAYERS];
new pTied[MAX_PLAYERS];
new pDragged[MAX_PLAYERS];
new pDragCop[MAX_PLAYERS];
new pDragging[MAX_PLAYERS];

new pCMDFind[MAX_PLAYERS];
new pDetectMan[MAX_PLAYERS];

new Locked[MAX_VEHICLES];
new Owner[MAX_VEHICLES];
new Vgas[MAX_VEHICLES];

new bool:realchat = true;

new LvlResp = 4;
new LvlCost = 150;
new MaxPing = 450;
new OOC = 1;
new MedicOffer = 0;
new DrivOffer = 0;
new PoliceOffer = 0;
new MechOffer = 0;
new BackupCaller = 0;
new DMV = 0;
new Secur = 0;
new CountAm = 999;
new RefillTimer;

new Text:Txt;
new Text:HClock1;
new Text:HClock2;

new Menu:Bazar;
new Menu:Wang;
new Menu:BCol;
new Menu:Gas;

/*
	Job 1 = Mechanic
	Job 2 = Detective
	Job 3 = Taxi Driver
	Job 4 = Medic
	Job 5 = Car Jacker
*/

enum PlayerInfo
{
    pKey[128],
    pLevel,
    pLogged,
    pCop,
    pFBI,
    pMedic,
    pDriver,
    pInstructor,
    pMafia1, //Corleone (Dexter's)
    pMafia2, //...
    pLogTries,
    pPhoneNumber,
    pBankAccount,
    pSex,
    pJob,
	pCarLic,
	pFlyLic,
	pResp,
	pKills,
	pDeaths,
	pConTime,
	pHouseKey,
	pMats,
	pMuted,
	pFreezed
};

new pInfo[MAX_PLAYERS][PlayerInfo];

enum PlayerStuff
{
	VehicleLock,
	Ciggarettes,
	Rope,
	Watch,
	PhoneBook
};

new pStuff[MAX_PLAYERS][PlayerStuff];

enum HouseInfo
{
	Float:hEntrancex,
	Float:hEntrancey,
	Float:hEntrancez,
	Float:hExitx,
	Float:hExity,
	Float:hExitz,
	hOwner[MAX_PLAYER_NAME],
	hDiscription[MAX_PLAYER_NAME],
	hValue,
	hInt,
	hOwned,
	hRooms
};

new hInfo[12][HouseInfo];

main()
{
	print("\n    ____________________________");
	print("     New Generation: Role Play");
	print("    ____________RPG_____________\n");
}

public OnGameModeInit()
{
	SetGameModeText("NGRP 0.67");
	ShowPlayerMarkers(0);
	ShowNameTags(1);
	AllowInteriorWeapons(1);
	EnableStuntBonusForAll(0);
	SetWeather(10);
	EnableTirePopping(1);
	EnableZoneNames(0);
    SetWorldTime(15);
    SetGravity(0.009);
    SetRealTime();
	SetNameTagDrawDistance(10);
	DisableInteriorEnterExits();
	SetTimer("Other",1000,1);
	SetTimer("Phone",7000,1);
	SetTimer("PayDay",10000,1);
	SetTimer("FuelUpdate",11000,1);
	//SetTimer("HealthDown",60000,1);

	//Pickups - Enters
	AddStaticPickup(1318,1,2287.0559,2431.5447,10.8203);
	AddStaticPickup(1318,1,2247.6030,2396.9460,10.8203);
	AddStaticPickup(1318,1,2447.3645,2376.1973,12.1635);
	AddStaticPickup(1318,1,2194.5393,1990.9659,12.2969);

	//Pickups - Other
	AddStaticPickup(1239,1,358.8402,178.6667,1008.3828);
	AddStaticPickup(1239,1,358.8664,182.6619,1008.3828);
	AddStaticPickup(1239,1,358.4514,169.1528,1008.3828);
	AddStaticPickup(1239,1,358.4527,166.3021,1008.3828);

	//Car Selling
	AddStaticPickup(1239,1,2172.3943,1411.0660,11.0625);
	AddStaticPickup(1239,1,-1956.9968,304.0892,35.4688);

	AddStaticPickup(1239,1,1672.3341,1842.8002,10.8203); //Closed CarShop


	//Random Gas
	new randGas = RandNumb(5,90);
	for(new v;v<MAX_VEHICLES;v++)
	{
	    Vgas[v] = randGas+random(10);
	}

	//Houses
	ReadHouses();
	for(new h=0;h<sizeof(hInfo);h++)
	{
		if(hInfo[h][hOwned] == 0)
		{
			AddStaticPickup(1273, 1, hInfo[h][hEntrancex], hInfo[h][hEntrancey], hInfo[h][hEntrancez]);
		}
		if(hInfo[h][hOwned] == 1)
		{
			AddStaticPickup(1318, 1, hInfo[h][hEntrancex], hInfo[h][hEntrancey], hInfo[h][hEntrancez]);
		}
	}

	//Skins
	AddPlayerClass(60,1674.8616,1447.9777,10.7891,270.5837,0,0,0,0,0,0); // Man
	AddPlayerClass(56,1674.8616,1447.9777,10.7891,270.5837,0,0,0,0,0,0); // Woman

	//Las Vegas Police
	AddStaticVehicleEx(598,2282.1448,2443.1875,10.5516,359.8450,0,1,600000); // LVPD
	AddStaticVehicleEx(523,2281.9343,2477.6824,10.3796,181.3029,0,0,600000); // HPV1000
	AddStaticVehicleEx(598,2273.4465,2459.4504,10.5502,180.0096,0,1,600000); // LVPD
	AddStaticVehicleEx(598,2256.0210,2442.5911,10.5499,180.7905,0,1,600000); // LVPD
	AddStaticVehicleEx(523,2277.0090,2477.9158,10.3795,177.1837,0,0,600000); // HPV1000
	AddStaticVehicleEx(598,2256.0496,2477.4463,10.5494,180.2655,0,1,600000); // LVPD
	AddStaticVehicleEx(427,2295.3645,2476.6401,10.9394,179.7407,0,1,600000); // Enforcer

	//Las Vegas FBI
	AddStaticVehicleEx(490,2264.0222,2431.3464,3.2740,0.4318,0,0,600000); // FBI Ranch
	AddStaticVehicleEx(490,2272.7686,2430.8215,3.2740,0.0163,0,0,600000); // FBI Ranch
	AddStaticVehicleEx(490,2268.4231,2431.1626,3.2740,1.6980,0,0,600000); // FBI Ranch
	AddStaticVehicleEx(490,2277.1362,2431.2585,3.2740,359.8593,0,0,600000); // FBI Ranch
	AddStaticVehicleEx(421,2239.9551,2437.4963,3.1412,269.4718,0,0,600000); // FBI Washing
	AddStaticVehicleEx(421,2240.1160,2442.3123,3.1412,270.4368,0,0,600000); // FBI Washing
	AddStaticVehicleEx(426,2240.5444,2451.8860,3.0073,270.8038,0,0,600000); // FBI Premier
	AddStaticVehicleEx(426,2240.4919,2456.7229,3.0064,270.9411,0,0,600000); // FBI Premier

	//Las Vegas Hospital
	AddStaticVehicleEx(416,1622.7760,1818.4614,11.3043,359.7005,1,3,600000); // Ambulance
	AddStaticVehicleEx(416,1626.5376,1818.4867,11.3074,1.9910,1,3,600000); // Ambulance
	AddStaticVehicleEx(416,1593.1487,1818.5947,11.3044,0.3866,1,3,600000); // Ambulance

	//Taxi
	AddStaticVehicleEx(420,1679.4016,1286.6393,10.4848,358.7007,6,1,600000); // Taxi
	AddStaticVehicleEx(420,1666.5607,1297.7522,10.4868,359.6255,6,1,600000); // Taxi
	AddStaticVehicleEx(420,1682.5453,1316.8573,10.4847,359.5870,6,1,600000); // Taxi
	AddStaticVehicleEx(420,1640.9885,1305.1698,10.4870,270.2065,6,1,600000); // Taxi
	AddStaticVehicleEx(420,1692.1260,1305.7144,10.4892,180.1172,6,1,600000); // Taxi

	//Mafia Cars
	AddStaticVehicle(409,1461.9548,2772.8042,10.5273,180.6454,0,0); // Stretch
	AddStaticVehicle(579,1461.9105,2764.4448,10.6501,179.2893,0,0); // Huntley
	AddStaticVehicle(579,1461.9434,2780.6963,10.6545,180.4745,0,0); // Huntley
	AddStaticVehicle(491,1478.0626,2878.4971,10.5586,179.3803,0,0); // Virgo
	AddStaticVehicle(491,1529.3302,2867.8123,10.5586,90.3250,0,0); // Virgo

	//Civlian
	AddStaticVehicleEx(445,2211.3254,2277.5410,10.6313,270.5275,35,35,600000); // Admiral
	AddStaticVehicleEx(458,2433.0610,2377.5757,10.6327,0.2159,113,1,600000); // Solair
	AddStaticVehicleEx(474,2478.5623,2155.4546,10.5229,88.1613,105,1,600000); // Hermes
	AddStaticVehicleEx(475,2534.5632,2014.5837,10.6364,90.3348,21,1,600000); // Sabre
	AddStaticVehicleEx(491,2282.9138,1898.8423,10.5162,90.9819,71,72,600000); // Virgo
	AddStaticVehicleEx(509,1670.2277,1440.7861,10.2897,270.5778,1,3,600000); // Bike
	AddStaticVehicleEx(509,1670.2837,1438.8722,10.2901,269.9353,1,3,600000); // Bike
	AddStaticVehicleEx(509,1670.4102,1436.9886,10.2981,270.9421,1,3,600000); // Bike
	AddStaticVehicleEx(509,1670.4069,1435.1664,10.2954,270.0735,1,3,600000); // Bike
	AddStaticVehicleEx(421,2119.9868,1994.5878,10.5397,182.2817,25,1,600000); // Washington
	AddStaticVehicleEx(426,1724.3367,1540.2136,10.4959,14.0070,7,7,600000); // Premier
	AddStaticVehicleEx(586,1602.1095,1832.3060,10.3309,358.8659,122,1,600000); // Wayfarer
	AddStaticVehicleEx(419,1613.6447,1838.5330,10.6013,142.4967,47,76,600000); // Esperanto
	AddStaticVehicleEx(526,2195.2996,2503.0249,10.5766,0.0065,9,39,600000); // Fortune
	AddStaticVehicleEx(527,2084.7861,2468.9800,10.5272,179.9891,53,1,600000); // Cadrona
	AddStaticVehicleEx(529,2052.9216,2479.8865,10.4414,148.6882,62,62,600000); // Willard
	AddStaticVehicleEx(533,1914.1969,2159.4817,10.5180,271.3603,75,1,600000); // Feltzer
	AddStaticVehicleEx(426,1711.2115,2232.0718,10.5537,359.0689,7,7,600000); // Premier
	AddStaticVehicleEx(404,1531.0537,2203.5959,10.5425,179.2818,119,50,600000); // Perrenial
	AddStaticVehicleEx(529,1522.5240,2258.2480,10.4407,1.1835,10,10,600000); // Willard
	AddStaticVehicleEx(419,1386.0787,2276.4648,10.6009,270.0329,33,75,600000); // Esperanto
	AddStaticVehicleEx(421,1743.5303,1235.1500,10.5397,180.1119,75,1,600000); // Washington
	AddStaticVehicleEx(436,2039.6030,1163.5171,10.4254,180.4623,87,1,600000); // Previon
	AddStaticVehicleEx(410,1989.0902,1070.8418,10.4636,181.2886,9,1,600000); // Manana
	AddStaticVehicleEx(418,2187.3953,920.4571,10.9023,0.8149,117,227,600000); // Moonbeam
	AddStaticVehicleEx(400,2563.0720,1144.6008,10.9072,270.3358,123,1,600000); // Landstalker
	AddStaticVehicleEx(549,2341.7388,1114.2579,10.4203,179.1462,75,39,600000); // Tampa
	AddStaticVehicleEx(565,2186.4814,2000.2400,10.4346,269.3285,53,53,600000); // Flash
	AddStaticVehicleEx(589,2012.6365,1718.9799,10.3945,89.8564,31,31,600000); // Club
	AddStaticVehicleEx(527,2104.1685,2072.6921,10.5270,90.0905,66,1,600000); // Cadrona
	AddStaticVehicleEx(566,2262.4797,2063.0386,10.5847,359.5502,30,8,600000); // Tahoma

	//Gate, Fixing some bugs + Other objects
	CreateObject(969,1534.740,2777.774,9.845,0.0,0.0,-90.000); //Mafia Gate
	CreateObject(1498,2036.520,2721.295,10.537,0.0,0.0,0.0);
	CreateObject(1215,1534.327,2768.046,10.385,0.0,0.0,0.0);
	CreateObject(1215,1534.669,2778.372,10.385,0.0,0.0,0.0);
	CreateObject(1216,1458.261,2782.295,10.512,0.0,0.0,90.000);
	CreateObject(1257,1538.040,2798.018,11.100,0.0,0.0,-180.000);
	CreateObject(1258,1538.471,2793.967,10.474,0.0,0.0,90.000);
	CreateObject(1211,1536.675,2781.779,10.431,0.0,0.0,0.0);
	CreateObject(1229,1539.031,2793.524,11.372,0.0,0.0,180.000);
	CreateObject(1233,1550.028,2762.941,11.380,0.0,0.0,0.0);
	CreateObject(1214,1534.787,2779.797,9.814,0.0,0.0,0.0);
	CreateObject(1214,1534.942,2781.915,9.814,0.0,0.0,0.0);
	CreateObject(1214,1534.376,2766.791,9.814,0.0,0.0,0.0);
	CreateObject(1214,1534.248,2764.774,9.814,0.0,0.0,0.0);

	//TextDraw - TD when connect + Watch
	Txt = TextDrawCreate(610,370, "~w~New Generation ~g~RPG");
    TextDrawLetterSize(Txt, 0.9, 1.9);
    TextDrawFont(Txt,0);
    TextDrawTextSize(Txt, 55.0, 35.0);
    TextDrawSetOutline(Txt,1);
    TextDrawAlignment(Txt, 3);
    TextDrawSetShadow(Txt, 2);

    HClock1 = TextDrawCreate(547, 36, "--:--");
    TextDrawLetterSize(HClock1, 0.5, 1.5);
    TextDrawFont(HClock1, 2);
    TextDrawSetShadow(HClock1, 2);
    TextDrawSetOutline(HClock1, 2);

    HClock2 = TextDrawCreate(607, 36, "--");
    TextDrawLetterSize(HClock2, 0.4, 1.1);
    TextDrawFont(HClock2, 2);
    TextDrawSetShadow(HClock2, 2);
    TextDrawSetOutline(HClock2, 2);

    //Menu
    Bazar = CreateMenu("~y~LV ~w~Cars:",1,50,220,200,200);
	AddMenuItem(Bazar,0,"Premier      $4550");
	AddMenuItem(Bazar,0,"Elegant      $4790");
	AddMenuItem(Bazar,0,"Landstalker  $3240");
	AddMenuItem(Bazar,0,"Willard      $2990");
	AddMenuItem(Bazar,0,"Esperanto    $5450");
	AddMenuItem(Bazar,0,"Merit        $6200");
	AddMenuItem(Bazar,0,"Perrenial    $2350");
	AddMenuItem(Bazar,0,"Tahoma       $5550");
	AddMenuItem(Bazar,0,"Exit");

	Wang = CreateMenu("~y~Wang ~w~Cars:",1,50,220,200,200);
	AddMenuItem(Wang,0,"ZR-350        $7520");
	AddMenuItem(Wang,0,"Cheetah       $12500");
	AddMenuItem(Wang,0,"Turismo       $15250");
	AddMenuItem(Wang,0,"Infernus      $22500");
	AddMenuItem(Wang,0,"Super GT      $8750");
	AddMenuItem(Wang,0,"Exit");

	BCol = CreateMenu("~y~LV ~w~Cars:",1,50,220,200,200);
	AddMenuItem(BCol,0,"White Color");
	AddMenuItem(BCol,0,"Red Color");
	AddMenuItem(BCol,0,"Blue Color");
	AddMenuItem(BCol,0,"Yellow");
	AddMenuItem(BCol,0,"Exit");

	Gas = CreateMenu("~g~Gas ~w~Station:",1,50,220,200,200);
   	AddMenuItem(Gas,0,"Natural 95");
   	AddMenuItem(Gas,0,"Normal 98");
   	AddMenuItem(Gas,0,"Super Diesel");
   	AddMenuItem(Gas,0,"Exit");
	return 1;
}

public OnGameModeExit()
{
	DestroyMenu(Bazar);
	DestroyMenu(Wang);
	DestroyMenu(BCol);
	DestroyMenu(Gas);
	TextDrawDestroy(Txt);
	TextDrawDestroy(HClock1);
	TextDrawDestroy(HClock2);
	for(new i;i<MAX_PLAYERS;i++)
	{
		UpdateAccounts();
	}
	for(new v;v<MAX_VEHICLES;v++)
	{
	    DestroyVehicle(v);
	}
	OnHouseUpdate();
	return 1;
}

public GameModeExitStart()
{
	new string[256];
    for(new i;i<MAX_PLAYERS;i++)
	{
	    if(CountAm > 0)
     	{
	    	if(IsPlayerConnected(i))
	    	{
				CountAm --;
				format(string,256,"~w~Restarting~n~~n~~r~%d",CountAm);
				GameTextForPlayer(i,string,1100,3);
				SetPlayerInterior(i,0);
				SetPlayerPos(i,-99.9312,-5.5517,11.4277);
				SetPlayerFacingAngle(i,293.7919);
				SetPlayerCameraPos(i,-91.6335,-2.0795,7.5430);
				SetPlayerCameraLookAt(i,-99.9312,-5.5517,11.4277);
			}
		}
		else if(CountAm == 0)
		{
		    UpdateAccounts();
		    GameModeExit();
			if(TransportDuty[i] > 0)
			{
				TransportDuty[i] = 0;
				GivePlayerMoney(i, TransportMoney[i]);
				ConsumingMoney[i] = 1; TransportValue[i] = 0; TransportMoney[i] = 0;
			}
		}
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerVirtualWorld(playerid,2);
	SetPlayerInterior(playerid,0);
	SetPlayerPos(playerid,-99.9312,-5.5517,11.4277);
	SetPlayerFacingAngle(playerid,293.7919);
	SetPlayerCameraPos(playerid,-91.6335,-2.0795,7.5430);
	SetPlayerCameraLookAt(playerid,-99.9312,-5.5517,11.4277);
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(Secur == 1)
	{
	    SendClientMessage(playerid, COLOR_GREEN, "* We are sorry, but server has been protected, no-one can Log In!");
	    Kick(playerid);
	    return 1;
	}
    new plname[MAX_PLAYER_NAME];
    new string[256];
    new string2[256];
    new RPName;
	GetPlayerName(playerid, plname, sizeof(plname));
	if(strfind(plname,"_",true,1)!=-1)
	{
		RPName = 1;
	}
 	if(plname[strlen(plname)-1]=='_')
 	{
	    RPName = 0;
	}
	for(new i=0;i<strlen(plname);i++)
	{
		if((plname[i]<='9')&&(plname[i]>='0'))
		{
 			RPName = 0;
		}
	}
	if(RPName != 1)
	{
	    format(string2,256,"[OOC] %s[ID:%d] has been kicked. Reason: Non-RP Name.",plname,playerid);
		SendClientMessageToAll(COLOR_OTHER,string);
	    Kick(playerid);
	    SaveToConfig(string2);
	}
	else
	{
		format(string2,256,"* %s[ID:%d] has been connected",plname,playerid);
    	SaveToConfig(string2);
	}
	new sstring[MAX_PLAYER_NAME];
	new plname2[MAX_PLAYER_NAME];
    GetPlayerName(playerid, plname2, sizeof(plname2));
    format(sstring, sizeof(sstring), "%s.sav", plname2);
    BigEar[playerid] = 0; Mobile[playerid] = 255; RegistrationUpd[playerid] = 1;
    JobOffer[playerid] = 0; JobTime[playerid] = 0; CountAmount[playerid] = 999;
    TicketValue[playerid] = 0; pCuffTime[playerid] = 999; pTime[playerid] = 0;
    pJailed[playerid] = 0; pJailTime[playerid] = 999; WantedLvl[playerid] = 0;
    PlayerDied[playerid] = 0; OnDuty[playerid] = 0; CellTime[playerid] = 999;
    RingTime[playerid] = 999; pCuffed[playerid] = 0; pTied[playerid] = 0;
    pCMDFind[playerid] = 0; TransportDriver[playerid] = 999; TicketOffer[playerid] = 999;
    TransportTime[playerid] = 0; TransportCost[playerid] = 0; TransportDuty[playerid] = 0;
    pSpawned[playerid] = 0; pStuff[playerid][PhoneBook] = 0; pInfo[playerid][pConTime] = 0;
    pInfo[playerid][pLogged] = 0; pInfo[playerid][pCop] = 0; pStuff[playerid][Watch] = 0;
    pInfo[playerid][pMedic] = 0; pInfo[playerid][pFBI] = 0; pInfo[playerid][pMafia1] = 0;
    pInfo[playerid][pDriver] = 0; pInfo[playerid][pInstructor] = 0; pInfo[playerid][pMafia2] = 0;
	pInfo[playerid][pLogTries] = 0; pInfo[playerid][pBankAccount] = 0; pInfo[playerid][pMats] = 0;
    pInfo[playerid][pSex] = 0; pInfo[playerid][pMuted] = 0; pInfo[playerid][pFreezed] = 0;
    pInfo[playerid][pCarLic] = 0; pInfo[playerid][pFlyLic] = 0; pInfo[playerid][pLevel] = 0;
    pInfo[playerid][pResp] = 0; pInfo[playerid][pKills] = 0; pInfo[playerid][pDeaths] = 0;
    pStuff[playerid][VehicleLock] = 0; pStuff[playerid][Ciggarettes] = 0; pStuff[playerid][Rope] = 0;
    pInfo[playerid][pHouseKey] = 255; pDestroyingCar[playerid] = 0; pHaveAcc[playerid] = 0;
	pAdmin[playerid] = 0; pWantCar[playerid] = 0; pCarPrice[playerid] = 0;
	CalledBackup[playerid] = 0; AcceptedBackup[playerid] = 0; pCarInfo[playerid] = 0;
	pWatch[playerid] = 0; pDetectMan[playerid] = 0; IsInZip[playerid] = 0;
	pDragged[playerid] = 0; pDragCop[playerid] = 0; pDragging[playerid] = 0;
	OldMoney[playerid] = 0; pCarShop[playerid] = 0; pCheckPoint[playerid] = 0;
	pSellingCar[playerid] = 0; PlayerUsingAnim[playerid] = 0; PlayerUsingCellPhoneAnim[playerid] = 0;
	PlayerSitting[playerid] = 0;
    ResetPlayerMoney(playerid); ResetPlayerWeapons(playerid);
    TextDrawShowForPlayer(playerid,Txt);
    new phone = 100000 + random(899999);
    pInfo[playerid][pPhoneNumber] = phone;
    GameTextForPlayer(playerid,"Welcome Here",3500,1);
    if(fexist(sstring))
    {
        SendClientMessage(playerid, COLOR_GREEN, "SERVER: This name is already Registered!");
		SendClientMessage(playerid, COLOR_WHITE, "HINT: You can now log in, type /login [password]");
		SendClientMessage(playerid, COLOR_OTHER, ">>> Welcome on NGRP Beta-Test! If you found a bug, use /breport please! <<<");
		pHaveAcc[playerid] = 1;
		return 1;
	    }else{
		SendClientMessage(playerid, COLOR_GREEN, "SERVER: This name is not Registered! Register with: /register [password]");
		pHaveAcc[playerid] = 0;
		return 1;
   }
}

public OnPlayerDisconnect(playerid, reason)
{
	new string[256];
	new CallingWith = Mobile[playerid];
	new pName[MAX_PLAYER_NAME];
	if(CallingWith != 255 && CallingWith < 255)
	{
	    SendClientMessage(CallingWith,COLOR_GREY, "* The Phone Call has been Disconnected...");
	    Mobile[CallingWith] = 255;
	}
	if(TransportDuty[playerid] > 0)
	{
		TransportDuty[playerid] = 0;
		GivePlayerMoney(playerid, TransportMoney[playerid]);
		ConsumingMoney[playerid] = 1; TransportValue[playerid] = 0; TransportMoney[playerid] = 0;
	}
	if(TransportCost[playerid] > 0 && TransportDriver[playerid] < 999)
	{
	    if(IsPlayerConnected(TransportDriver[playerid]))
		{
		    TransportMoney[TransportDriver[playerid]] += TransportCost[playerid];
		    TransportTime[TransportDriver[playerid]] = 0;
		    TransportCost[TransportDriver[playerid]] = 0;
		    format(string, sizeof(string), "* Passenger left the Taxi, You have Earned $%d",TransportCost[playerid]);
		    SendClientMessage(TransportDriver[playerid],COLOR_YELLOW,string);
			GivePlayerMoney(playerid, -TransportCost[playerid]);
			TransportCost[playerid] = 0;
			TransportTime[playerid] = 0;
			TransportDriver[playerid] = 999;
		}
	}
	if(pBought[playerid] > 0)
	{
	    DestroyVehicle(pCar[playerid]);
	}
	if(pInfo[playerid][pLogged] == 1)
	{
		OnPlayerUpdate(playerid);
	}
	switch (reason)
   	{
      	case 0:
      	{
      		GetPlayerName(playerid, pName, sizeof(pName));
      		format(string,sizeof(string), "* %s [ID:%d] left the server (Timeout)",pName,playerid);
      		SaveToConfig(string);
      	}
		case 1:
		{
	      	GetPlayerName(playerid, pName, sizeof(pName));
	      	format(string,sizeof(string), "* %s [ID:%d] left the server (Left)",pName,playerid);
	      	SaveToConfig(string);
		}
	    case 2:
	    {
	    	GetPlayerName(playerid, pName, sizeof(pName));
			format(string,sizeof(string), "* %s [ID:%d] left the server (Kick/Ban)",pName,playerid);
	        SaveToConfig(string);
		}
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	new string[256];
	new pName[MAX_PLAYER_NAME];
	if(PlayerDied[playerid] == 1)
	{
		new TotalBill = RandNumb(150,300);
		format(string, sizeof(string), "* The Medical Bill comes to $%d, Have a nice day!",TotalBill);
		SendClientMessage(playerid,COLOR_OTHER,string);
		GivePlayerMoney(playerid,-TotalBill);
		PlayerDied[playerid] = 0;
	}
	if(pInfo[playerid][pLogged] == 0)
	{
	    GetPlayerName(playerid, pName, sizeof(pName));
	    SendClientMessage(playerid,COLOR_GREY,"SERVER: You have been kicked! Don't forgot Login before spawn!");
	    Kick(playerid);
	    format(string, sizeof(string), "[OOC] %s[ID:%d] has been kicked. Reason: Forgot login!",pName,playerid);
		SendClientMessageToAll(COLOR_OTHER,string);
	}
	SetPlayerColor(playerid,COLOR_WHITE);
	pSpawned[playerid] = 1;
	SpawnPlayerToJob(playerid);
	SetPlayerVirtualWorld(playerid,0);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    new string[256];
	new pName[MAX_PLAYER_NAME];
	new kName[MAX_PLAYER_NAME];
	SetPlayerWantedLevel(playerid,0);
	PlayerDied[playerid] = 1;

	if(IsPlayerConnected(killerid))
	{
		if(reason == 38)
		{
			GetPlayerName(playerid, pName, sizeof(pName));
			GetPlayerName(killerid, kName, sizeof(kName));
			format(string, sizeof(string), "[OOC] Player %s[ID:%d] just killed %s[ID:%d] with Minigun! He was Auto-Banned!",kName,killerid,pName,playerid);
			SendClientMessageToAll(COLOR_OTHER,string);
			Ban(killerid);
		}
		if(reason == 40)
		{
			GetPlayerName(playerid, pName, sizeof(pName));
			GetPlayerName(killerid, kName, sizeof(kName));
			format(string, sizeof(string), "[OOC] Player %s[ID:%d] just killed %s[ID:%d] with Detonator! He was Auto-Banned!",kName,killerid,pName,playerid);
			SendClientMessageToAll(COLOR_OTHER,string);
			Ban(killerid);
		}
		if(reason == 36)
		{
			GetPlayerName(playerid, pName, sizeof(pName));
			GetPlayerName(killerid, kName, sizeof(kName));
			format(string, sizeof(string), "[OOC] Player %s[ID:%d] just killed %s[ID:%d] with RPG! He was Auto-Banned!",kName,killerid,pName,playerid);
			SendClientMessageToAll(COLOR_OTHER,string);
			Ban(killerid);
		}
		if(reason == 35)
		{
			GetPlayerName(playerid, pName, sizeof(pName));
			GetPlayerName(killerid, kName, sizeof(kName));
			format(string, sizeof(string), "[OOC] Player %s[ID:%d] just killed %s[ID:%d] with Rocket Launcher! He was Auto-Banned!",kName,killerid,pName,playerid);
			SendClientMessageToAll(COLOR_OTHER,string);
			Ban(killerid);
		}
	}
    pInfo[playerid][pDeaths] += 1;
	pInfo[killerid][pKills] += 1;
	return 1;
}

public OnPlayerText(playerid, text[])
{
    if(pInfo[playerid][pMuted] == 1)
	{
	    SendClientMessage(playerid,COLOR_GREY,"* You can't Speak, you have been Muted!");
	    return 0;
	}
	new tmp[256];
	new pName[256];
	new string[256];

	if(RegistrationUpd[playerid] == 2 && RegistrationUpd[playerid] != 999)
 	{
  		new idxx;
 		tmp = strtok(text, idxx);
  		if((strcmp("Male", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Male")))
		{
			pInfo[playerid][pSex] = 1;
		    SendClientMessage(playerid, COLOR_YELLOW,"* Okay, so you are Male!");
		    SendClientMessage(playerid, COLOR_OTHER, "Thank you for filling this Question, now Let's Play!");
		    SendClientMessage(playerid, COLOR_OTHER, "If you need some help, type /help.");
			RegistrationUpd[playerid] = 999;
			SpawnPlayer(playerid);
			return 0;
		}
		else if((strcmp("Female", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Female")))
		{
		    pInfo[playerid][pSex] = 2;
		    SendClientMessage(playerid, COLOR_YELLOW,"* Okay, so you are Female!");
		    SendClientMessage(playerid, COLOR_OTHER, "Thank you for filling this Question, now Let's Play!");
		    SendClientMessage(playerid, COLOR_OTHER, "If you need some help, type /help.");
			RegistrationUpd[playerid] = 999;
			SpawnPlayer(playerid);
			return 0;
		}else{
		SendClientMessage(playerid, COLOR_YELLOW,"* Again please, Male or Female?");
		return 0;
		}
	}
	if(JobOffer[playerid] > 0)
 	{
  		new idxx;
 		tmp = strtok(text, idxx);
  		if((strcmp("Yes", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Yes")))
		{
			if(JobOffer[playerid] == 1)
			{
			    pInfo[playerid][pJob] = 1;
			}
			else if(JobOffer[playerid] == 2)
			{
                pInfo[playerid][pJob] = 2;
			}
			else if(JobOffer[playerid] == 3)
			{
				pInfo[playerid][pDriver] = 1;
			}
			else if(JobOffer[playerid] == 4)
			{
                pInfo[playerid][pMedic] = 1;
			}
			else if(JobOffer[playerid] == 5)
			{
                pInfo[playerid][pJob] = 5;
			}
			JobOffer[playerid] = 0; JobTime[playerid] = 3;
			SendClientMessage(playerid, COLOR_OTHER, "* Congratulations, you've got new Job with 3 hours contract! Use /help to see your commands!");
			return 0;
		}
		else if((strcmp("No", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("No")))
		{
		    JobOffer[playerid] = 0;
		    SendClientMessage(playerid, COLOR_GREY, "* You've cancelled your Job offer!");
			return 0;
		}else{
		SendClientMessage(playerid, COLOR_YELLOW,"* Again please, Yes or No?");
		return 0;
		}
	}
	if(realchat)
	{
		if(pInfo[playerid][pLogged] != 1)
 		{
	        return 0;
      	}
		GetPlayerName(playerid, pName, sizeof(pName));
		format(string, sizeof(string), "%s Says: %s", pName, text);
		ProxDetector(20.0, playerid, string, COLOR_CHAT1,COLOR_CHAT2,COLOR_CHAT3,COLOR_CHAT4,COLOR_CHAT5);
		format(string, sizeof(string), "[SAY] %s: %s",pName,text);
		SaveChat(string);
		return 0;
	}
	if(Mobile[playerid] != 255)
	{
		new idx;
		tmp = strtok(text, idx);
		GetPlayerName(playerid, pName, sizeof(pName));
		format(string, sizeof(string), "%s Says (cellphone): %s", pName, text);
		ProxDetector(20.0, playerid, string, COLOR_CHAT1,COLOR_CHAT2,COLOR_CHAT3,COLOR_CHAT4,COLOR_CHAT5);
		format(string, sizeof(string), "[Cellphone] %s: %s",pName,text);
		SaveChat(string);
		if(IsPlayerConnected(Mobile[playerid]))
		{
		    if(Mobile[Mobile[playerid]] == playerid)
		    {
				SendClientMessage(Mobile[playerid], COLOR_YELLOW,string);
			}
		}
		return 0;
	}
	return 1;
}

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	if(IsPlayerConnected(playerid))
	{
		SendClientMessage(playerid,COLOR_GREY,"* PM's are not allowed here!");
	}
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256],tmp[256];
	new string[256],idx;
	new pName[MAX_PLAYER_NAME];
	new gName[MAX_PLAYER_NAME];
	new gPlayer = strval(tmp);
	new moneys;
	cmd = strtok(cmdtext, idx);

	/*
	  *
		* GENERAL Commands *
   *
	*/

	if(strcmp(cmd, "/login", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        new tmppass[64];
			if(pInfo[playerid][pLogged] == 1)
			{
				SendClientMessage(playerid, COLOR_WHITE, "SERVER: You are already Logged In!");
				return 1;
			}
			if(pHaveAcc[playerid] == 0)
			{
			    SendClientMessage(playerid, COLOR_GREY, "* You don't have an account!");
			    return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GREY, "USAGE: /login [password]");
				return 1;
			}
			strmid(tmppass, tmp, 0, strlen(cmdtext), 255);
			Encrypt(tmppass);
			OnPlayerLogin(playerid,tmppass);
		}
		return 1;
	}

	if(strcmp(cmd, "/register", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(pInfo[playerid][pLogged] == 1)
			{
				SendClientMessage(playerid, COLOR_WHITE, "SERVER: You are already Logged In!");
				return 1;
			}
			if(pHaveAcc[playerid] == 1)
			{
			    SendClientMessage(playerid, COLOR_GREY, "* You already have an account!");
			    return 1;
			}
			if (strlen(tmp) > 10)
			{
			    SendClientMessage(playerid, COLOR_GREY, "* Max. 10 characters!");
			    return 1;
			}
			GetPlayerName(playerid, pName, sizeof(pName));
			format(string, sizeof(string), "%s.sav", pName);
			new File: hFile = fopen(string, io_read);
			if (hFile)
			{
				SendClientMessage(playerid, COLOR_YELLOW, "SERVER: This Name is Already Registered! Log In or change Your Name!");
				fclose(hFile);
				return 1;
			}
	        new tmppass[64];
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GREY, "USAGE: /register [password]");
				return 1;
			}
			strmid(tmppass, tmp, 0, strlen(cmdtext), 255);
			Encrypt(tmppass);
			OnPlayerRegister(playerid,tmppass);
		}
		return 1;
	}

	if(strcmp(cmd, "/help", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        ShowPlayerHelpList(playerid);
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
		   	    SendClientMessage(playerid,COLOR_GREY,"USAGE: /pay [playerid] [amount]");
			 	return 1;
       	   	}
			gPlayer = strval(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,COLOR_GREY,"USAGE: /pay [playerid] [amount]");
				return 1;
			}
			moneys = strval(tmp);
			if(moneys < 1 || moneys > 20000)
			{
				SendClientMessage(playerid,COLOR_GREY,"* Invalid Amount! [$1 - $20.000]");
				return 1;
			}
			if(gPlayer == playerid)
			{
			    SendClientMessage(playerid,COLOR_GREY,"* You can't give a money to self!");
			    return 1;
			}
			if(GetPlayerMoney(playerid) != moneys)
			{
				SendClientMessage(playerid,COLOR_GREY,"* You don't have that much Money!");
				return 1;
			}
			if (IsPlayerConnected(gPlayer))
			{
               if(GetDistanceBetweenPlayers(playerid,gPlayer)<5)
		       {
			   GetPlayerName(playerid, pName, sizeof(pName));
			   GetPlayerName(playerid, gName, sizeof(gName));
			   GivePlayerMoney(playerid,-moneys);
			   GivePlayerMoney(gPlayer,moneys);
			   format(string, sizeof(string), "* You've given $%d to %s!",moneys,gName);
			   SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			   format(string, sizeof(string), "* You've recieved $%d from %s!",moneys,pName);
			   SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			   format(string, sizeof(string), "* %s takes out some money and hands it to %s",pName,gName);
			   ProxDetector(30.0,playerid,string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			   format(string, sizeof(string), "[PAY] %s has given $%d to %s",pName,moneys,gName);
			   SavePay(string);
			   }else{
		       SendClientMessage(playerid,COLOR_GREY,"* You are too far away!");
			   }
			}else{
			SendClientMessage(playerid,COLOR_GREY,"* Player isn't Connected!");
			}
         }
	   return 1;
    }

	if(strcmp(cmd, "/me", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(pInfo[playerid][pLogged] != 1)
	        {
	            SendClientMessage(playerid,COLOR_GREY,"* You havent logged in yet!");
	            return 1;
	        }
			GetPlayerName(playerid,pName,sizeof(pName));
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
				SendClientMessage(playerid,COLOR_GREY,"USAGE: /me [action]");
				return 1;
			}
			format(string, sizeof(string), "* %s %s", pName, result);
			ProxDetector(25.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			format(string, sizeof(string), "[ACTION] %s - %s",pName,result);
			SaveAction(string);
		}
		return 1;
	}

	if(strcmp(cmd, "/whisper", true) == 0 || strcmp(cmd, "/w", true) == 0)
	{
	   	if(IsPlayerConnected(playerid))
	   	{
	       	if(pInfo[playerid][pLogged] != 1)
	       	{
	           	SendClientMessage(playerid,COLOR_GREY,"* You havent logged in yet !");
	           	return 1;
	       	}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,COLOR_GREY,"USAGE: /(w)hisper [playerid] [text]");
				return 1;
			}
			gPlayer = strval(tmp);
			if(IsPlayerConnected(gPlayer))
			{
			    if(gPlayer != INVALID_PLAYER_ID)
			    {
					GetPlayerName(playerid, pName, sizeof(pName));
					GetPlayerName(gPlayer, gName, sizeof(gName));
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
						SendClientMessage(playerid, COLOR_WHITE, "USAGE: /(w)hisper [playerid] [text]");
						return 1;
					}
					if(GetDistanceBetweenPlayers(playerid,gPlayer) < 3)
					{
					format(string, sizeof(string), "%s whispers: '%s'", pName,(result));
					SendClientMessage(gPlayer, COLOR_YELLOW, string);
					format(string, sizeof(string), "You whispers: '%s', to %s",(result),gName);
					SendClientMessage(playerid,  COLOR_YELLOW, string);
					format(string, sizeof(string), "* %s whispers something to %s.",pName,gName);
					ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);					return 1;
					}else{
	    			SendClientMessage(playerid, COLOR_GREY, "* You are too far away!");
					}
				}
			}else{
			SendClientMessage(playerid,COLOR_GREY,"* Player is not Connected!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/ooc", true) == 0 || strcmp(cmd, "/o", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(pInfo[playerid][pLogged] != 1)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "* You havent Logged in yet!");
	            return 1;
	        }
			GetPlayerName(playerid, pName, sizeof(pName));
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
				SendClientMessage(playerid, COLOR_GREY, "USAGE: /ooc [text]");
				return 1;
			}
			if(OOC == 1)
			{
				format(string, sizeof(string), "(( %s: %s ))", pName, result);
				SendClientMessageToAll(COLOR_WHITE,string);
				format(string, sizeof(string), "[OOC] %s: %s",pName,result);
				SaveOOC(string);
			}else{
			SendClientMessage(playerid,COLOR_GREY,"* The OOC channel has been disabled!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/shout", true) == 0 || strcmp(cmd, "/s", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(pInfo[playerid][pLogged] != 1)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "* You havent Logged in yet!");
	            return 1;
	        }
			GetPlayerName(playerid, pName, sizeof(pName));
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
				SendClientMessage(playerid, COLOR_GREY, "USAGE: (/s)hout [Text]");
				return 1;
			}
			format(string, sizeof(string), "%s Shouts: %s!!", pName, result);
			ProxDetector(30.0, playerid, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE);
		}
		return 1;
	}

	if(strcmp(cmd, "/b", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(pInfo[playerid][pLogged] != 1)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "* You havent logged in yet!");
	            return 1;
	        }
			GetPlayerName(playerid, pName, sizeof(pName));
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
				SendClientMessage(playerid, COLOR_GREY, "USAGE: /b [Local OOC Chat]");
				return 1;
			}
			format(string, sizeof(string), "(( %s: %s ))", pName, result);
			ProxDetector(12.0, playerid, string,COLOR_CHAT4,COLOR_CHAT4,COLOR_CHAT4,COLOR_CHAT4,COLOR_CHAT4);
			printf("%s", string);
		}
		return 1;
	}

	if(strcmp(cmd, "/advertise", true) == 0 || strcmp(cmd, "/ad", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(pInfo[playerid][pLogged] != 1)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "* You havent logged in yet!");
	            return 1;
	        }
			GetPlayerName(playerid,pName, sizeof(pName));
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
				SendClientMessage(playerid,COLOR_GREY,"USAGE: /(ad)vertise [text]");
				return 1;
			}
			new payout = idx*5;
			if(GetPlayerMoney(playerid) < payout)
	        {
	            format(string, sizeof(string), "* Advertise cost $%d, You don't have that much!", payout);
	            SendClientMessage(playerid, COLOR_GREY, string);
	            return 1;
	        }
			GivePlayerMoney(playerid, - payout);
			format(string, sizeof(string), "Advertisement: %s, Contact: %s Phone: %d",  result,pName,pInfo[playerid][pPhoneNumber]);
			SendClientMessageToAll(COLOR_GREEN,string);
			format(string, sizeof(string), "~r~Advertisment Payout ~n~~g~Cost:~w~$%d ~n~~g~Letters:~w~%d", payout, idx);
			GameTextForPlayer(playerid,string,4500,3);
			SaveToConfig(string);
		}
		return 1;
	}

	if(strcmp(cmd, "/licenses", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        new lic1[20];
	        new lic2[20];
	        if(pInfo[playerid][pCarLic]) { lic1 = "Passed"; } else { lic1 = "Not Passed"; }
	        if(pInfo[playerid][pFlyLic]) { lic2 = "Passed"; } else { lic2 = "Not Passed"; }
	        SendClientMessage(playerid, COLOR_LIGHTBLUE, "|_________|Licenses|_________|");
	        format(string, sizeof(string), "* Driving License: %s.", lic1);
			SendClientMessage(playerid, COLOR_WHITE, string);
			format(string, sizeof(string), "* Flying License: %s.", lic2);
			SendClientMessage(playerid, COLOR_WHITE, string);
		}
	    return 1;
 	}

	if(strcmp(cmd, "/stats", true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
		    if(pInfo[playerid][pLogged] == 1)
		    {
		    	ShowPlayerStats(playerid);
		    }else{
		    SendClientMessage(playerid,COLOR_GREY,"* You haven't Logged in yet!");
		    }
		}
		return 1;
	}

	if(strcmp(cmd, "/bank", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(!PlayerToPoint(playerid,362.0691,173.7491,1008.3828,10))
	        {
	            SendClientMessage(playerid,COLOR_GREY,"* You are not at the Bank!");
	            return 1;
	        }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,COLOR_GREY,"USAGE: /bank [amount]");
				return 1;
			}
			new ciastka = strval(tmp);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,COLOR_GREY,"USAGE: /bank [amount]");
				return 1;
			}
			if(ciastka > GetPlayerMoney(playerid))
			{
				SendClientMessage(playerid,COLOR_GREY,"* You don't have that much Money!");
				return 1;
			}
			if(ciastka < 1)
			{
				SendClientMessage(playerid,COLOR_GREY,"* Invalid Amount!");
				return 1;
			}
			GivePlayerMoney(playerid,-ciastka);
			pInfo[playerid][pBankAccount] = ciastka+pInfo[playerid][pBankAccount];
			SendClientMessage(playerid, COLOR_YELLOW, "|____ BANK STATMENT ____|");
			format(string, sizeof(string), "   Deposit: $%d",ciastka);
			SendClientMessage(playerid,COLOR_WHITE,string);
			format(string, sizeof(string), "   New Balance: $%d",pInfo[playerid][pBankAccount]);
			SendClientMessage(playerid,COLOR_WHITE,string);
			SendClientMessage(playerid, COLOR_YELLOW, "|_______________________|");
			return 1;
		}
		return 1;
	}

	if(strcmp(cmd, "/withdraw", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(!PlayerToPoint(playerid,362.0691,173.7491,1008.3828,10))
	        {
	            SendClientMessage(playerid,COLOR_GREY,"* You are not at the Bank!");
	            return 1;
	        }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,COLOR_GREY,"USAGE: /withdraw [amount]");
				return 1;
			}
			new ciastka = strval(tmp);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,COLOR_GREY,"USAGE: /withdraw [amount]");
				return 1;
			}
			if (ciastka > pInfo[playerid][pBankAccount])
			{
				SendClientMessage(playerid,COLOR_GREY,"* You don't have that much Money in your Bank Account!");
				return 1;
			}
			if(ciastka < 1)
			{
				SendClientMessage(playerid,COLOR_GREY,"* Invalid Amount!");
				return 1;
			}
			GivePlayerMoney(playerid,ciastka);
			pInfo[playerid][pBankAccount] = pInfo[playerid][pBankAccount]-ciastka;
			SendClientMessage(playerid, COLOR_YELLOW, "|____ BANK STATMENT ____|");
			format(string, sizeof(string), "   Withdrawn Amount: $%d",ciastka);
			SendClientMessage(playerid,COLOR_WHITE,string);
			return 1;
		}
		return 1;
 	}

	if(strcmp(cmd, "/balance", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(!PlayerToPoint(playerid,362.0691,173.7491,1008.3828,10))
	        {
	            SendClientMessage(playerid,COLOR_GREY,"* You are not in the Bank!");
	            return 1;
	        }
			SendClientMessage(playerid, COLOR_YELLOW, "|____ BANK STATMENT ____|");
			format(string, sizeof(string), "   Current Balance: $%d",pInfo[playerid][pBankAccount]);
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		return 1;
	}

	if(strcmp(cmd, "/time", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(pStuff[playerid][Watch] == 0)
	        {
	            SendClientMessage(playerid,COLOR_GREY,"* You don't have a Watch!");
	            return 1;
	        }
	        if(pWatch[playerid] == 0)
	        {
	        	SendClientMessage(playerid,COLOR_WHITE,"* You've turned on your Watch!");
	        	pWatch[playerid] = 1;
			}
			else
			{
				SendClientMessage(playerid,COLOR_WHITE,"* You've turned off your Watch!");
	        	pWatch[playerid] = 0;
	        	TextDrawHideForPlayer(playerid,HClock1);
	        	TextDrawHideForPlayer(playerid,HClock2);
			}
	    }
	    return 1;
	}

	if(strcmp(cmd, "/showlicenses", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GREY, "USAGE: /showlicenses [playerid]");
				return 1;
			}
			if(IsPlayerConnected(gPlayer))
			{
				if(gPlayer != INVALID_PLAYER_ID)
				{
				    if(GetDistanceBetweenPlayers(playerid,gPlayer) < 5)
				    {
    					if(gPlayer == playerid)
						{
							SendClientMessage(playerid, COLOR_GREY, "* You can't show Licenses to self!");
							SendClientMessage(playerid, COLOR_WHITE, "HINT: Use /licenses to see your passed licenses.");
							return 1;
						}
				    	GetPlayerName(gPlayer, gName, sizeof(gName));
						GetPlayerName(playerid, pName, sizeof(pName));
	    				new lic1[20];
	         			new lic2[20];
						if(pInfo[playerid][pCarLic]) { lic1 = "Passed"; } else { lic1 = "Not Passed"; }
	        			if(pInfo[playerid][pFlyLic]) { lic2 = "Passed"; } else { lic2 = "Not Passed"; }
				    	format(string, sizeof(string), "* Driving License: %s.", lic1);
						SendClientMessage(playerid, COLOR_WHITE, string);
						format(string, sizeof(string), "* Flying License: %s.", lic2);
						SendClientMessage(playerid, COLOR_WHITE, string);
						format(string, sizeof(string), "* %s has shown his Licenses to you.", pName);
						SendClientMessage(gPlayer, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* You have shown your Licenses to %s.", gPlayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* %s has shown his licenses to %s", pName,gPlayer);
						ProxDetector(30.0,playerid,string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					}else{
					SendClientMessage(playerid, COLOR_GREY, "* You are too far away!");
					}
				}
			}else{
   			SendClientMessage(playerid, COLOR_GREY, "* Player isn't Connected!");
	        }
		}
	    return 1;
 	}

 	if(strcmp(cmd, "/bail", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
			if(pJailed[playerid] == 1)
			{
			    if(JailPrice[playerid] > 0)
			    {
			        if(GetPlayerMoney(playerid) >= JailPrice[playerid])
			        {
			            format(string, sizeof(string), "* You have paid your bail $%d, you are now free!", JailPrice[playerid]);
						SendClientMessage(playerid, COLOR_DMV2, string);
						GivePlayerMoney(playerid,-JailPrice[playerid]);
						JailPrice[playerid] = 0;
						pJailTime[playerid] = 1;
			        }else{
           			SendClientMessage(playerid, COLOR_GREY, "* You don't have money to Pay the price!");
			        }
			    }else{
       			SendClientMessage(playerid, COLOR_GREY, "* You don't have Bail Price!");
			    }
			}else{
   			SendClientMessage(playerid, COLOR_GREY, "* You haven't been Arrested!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/gas", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
	   	    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		  	{
		  	    new MOD = GetVehicleModel(playerid);
		  	    new VID = GetPlayerVehicleID(playerid);
		  	    if(MOD == 510 || MOD == 509 || MOD == 481)
		  	    {
		  	        SendClientMessage(playerid,COLOR_GREY,"* You can't fill this Vehicle!");
		  	        return 1;
		  	    }
		  	    if(Vgas[VID] < 100)
				{
					ShowMenuForPlayer(Gas,playerid);
					}else{
					SendClientMessage(playerid,COLOR_GREY,"* Vehicle already Filled Up!");
				}
		  	}
	   	}
	   	return 1;
	}

	if(strcmp(cmd, "/breport", true) == 0)
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
				SendClientMessage(playerid,COLOR_GREY,"USAGE: /breport [text]");
				return 1;
			}
			GetPlayerName(playerid, pName, sizeof(pName));
			format(string, sizeof(string), "[REPORT] %s: %s",pName,(result));
			SaveReport(string);
			SendClientMessage(playerid,COLOR_YELLOW,"* Thank you for this Bug-Report! I hope we'll fix it soon!");
	    }
	    return 1;
	}

	/*
	  *
		* CELLPHONE Commands *
   *
	*/

	if(strcmp(cmd, "/call", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GREY, "USAGE: /call [number]");
				return 1;
			}
			GetPlayerName(playerid, pName, sizeof(pName));
			format(string, sizeof(string), "* %s takes out a cellphone.", pName);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			new number = strval(tmp);
			if(number == pInfo[playerid][pPhoneNumber])
			{
				SendClientMessage(playerid, COLOR_WHITE, "* You just get a busy tone...");
				return 1;
			}
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(pInfo[i][pPhoneNumber] == number && number != 0)
					{
						gPlayer = i;
						Mobile[playerid] = gPlayer;
						if(IsPlayerConnected(gPlayer))
						{
						    if(gPlayer != INVALID_PLAYER_ID)
						    {
								if(Mobile[gPlayer] == 255)
								{
									format(string, sizeof(string), "* Your Mobile rings. Number: %d", pInfo[gPlayer][pPhoneNumber]);
									SendClientMessage(playerid, COLOR_WHITE, "HINT: Use /pickup to pick the call up");
									SendClientMessage(gPlayer, COLOR_DMV, string);
									GetPlayerName(gPlayer, pName, sizeof(pName));
									RingTime[gPlayer] = 10;
									format(string, sizeof(string), "* %s's phone begins to ring.", pName);
									ProxDetector(15.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
									SendClientMessage(playerid, COLOR_WHITE, "HINT: You can now talk into cellphone. Type /(h)angup to Hang Up.");
									CellTime[playerid] = 1;
									return 1;
								}
							}
						}
					}
				}
			}
			SendClientMessage(playerid, COLOR_GREY, "* You just get a Busy tone...");
		}
		return 1;
	}

	if(strcmp(cmd, "/pickup", true) == 0 || strcmp(cmd, "/p", true) == 0)
	{
        if(IsPlayerConnected(playerid))
		{
			if(Mobile[playerid] != 255)
			{
				SendClientMessage(playerid, COLOR_GREY, "* You are already on Call!");
				return 1;
			}
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(Mobile[i] == playerid)
					{
						Mobile[playerid] = i;
						SendClientMessage(i,  COLOR_WHITE, "* They Picked up the call.");
						GetPlayerName(playerid, pName, sizeof(pName));
						format(string, sizeof(string), "* %s answers his cellphone.", pName);
						ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						RingTime[playerid] = 0;
					}else{
					SendClientMessage(playerid,COLOR_GREY,"* Nobody Called You!");
					}
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/hangup", true) == 0 || strcmp(cmd, "/h", true) == 0)
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
							SendClientMessage(caller,  COLOR_GREY, "* They hung up...");
							CellTime[caller] = 0;
							CellTime[playerid] = 0;
							SendClientMessage(playerid,  COLOR_GREY, "* You hung up.");
							Mobile[caller] = 255;
						}
						Mobile[playerid] = 255;
						CellTime[playerid] = 0;
						RingTime[playerid] = 0;
						GameTextForPlayer(playerid,"~y~The call cost:~n~~w~$15",3500,1);
						GivePlayerMoney(playerid,-15);
						return 1;
					}else{
					SendClientMessage(playerid,COLOR_GREY,"* The Phone is in your pocket!");
					}
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/number", true) == 0 || strcmp(cmd, "/n", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(pStuff[playerid][PhoneBook] == 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_GREY, "USAGE: /(n)umber [playerid]");
					return 1;
				}
				gPlayer = strval(tmp);
				if(IsPlayerConnected(gPlayer))
				{
				    if(gPlayer != INVALID_PLAYER_ID)
				    {
						GetPlayerName(gPlayer, pName, sizeof(pName));
						format(string, 256, "* Name: %s Phone Number: %d",pName,pInfo[gPlayer][pPhoneNumber]);
						SendClientMessage(playerid, COLOR_DMV, string);
						SendClientMessage(playerid, COLOR_WHITE, "HINT: Use /call to call him.");
					}
				}else{
				SendClientMessage(playerid, COLOR_GREY, "* Player not Connected!");
				}
			}else{
			SendClientMessage(playerid, COLOR_GREY, "* You don't have a Phone Book!");
			}
		}
		return 1;
	}

	/*
	  *
		* FACTION Commands + Tie / Untie + Heal etc. + JOB Commands *
	*
	*/

	if(strcmp(cmd, "/radio", true) == 0 || strcmp(cmd, "/r", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
  			if(pInfo[playerid][pCop] >= 1 || pInfo[playerid][pFBI] >= 1)
			{
   				if(OnDuty[playerid] == 1)
   				{
					GetPlayerName(playerid, pName, sizeof(pName));
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
						SendClientMessage(playerid, COLOR_GREY, "USAGE: (/r)adio [text]");
						return 1;
					}
					new RankText[20];
					if(pInfo[playerid][pCop] >= 1)
	    			{
	    				if(pInfo[playerid][pCop] == 1) { RankText = "Cadet"; }
	    				else if(pInfo[playerid][pCop] == 2) { RankText = "Officer"; }
	    				else if(pInfo[playerid][pCop] == 3) { RankText = "Lieutenant"; }
	    				else if(pInfo[playerid][pCop] == 4) { RankText = "Chief"; }
					}
					else if(pInfo[playerid][pFBI] >= 1)
					{
 						if(pInfo[playerid][pFBI] == 1) { RankText = "Agent"; }
	    				else if(pInfo[playerid][pFBI] == 2) { RankText = "Professional Staff"; }
	    				else if(pInfo[playerid][pFBI] == 3) { RankText = "Director"; }
	    			}
					format(string, sizeof(string), "[Radio] %s: %s,over.",RankText,(result));
					RadioMessage(string);
				}else{
				SendClientMessage(playerid,COLOR_GREY,"* You are not On Duty!");
				}
			}else{
			SendClientMessage(playerid,COLOR_GREY,"* You are not a Cop / FBI!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/department", true) == 0 || strcmp(cmd, "/d", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
  			if(pInfo[playerid][pMedic] >= 1 || pInfo[playerid][pCop] >= 1 || pInfo[playerid][pFBI] >= 1)
			{
				GetPlayerName(playerid, pName, sizeof(pName));
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
					SendClientMessage(playerid, COLOR_GREY, "USAGE: (/d)epartment [text]");
					return 1;
				}
				new RankText[20];
				if(pInfo[playerid][pCop] >= 1)
	    		{
	    			if(pInfo[playerid][pCop] == 1) { RankText = "Cadet"; }
	    			else if(pInfo[playerid][pCop] == 2) { RankText = "Officer"; }
	    			else if(pInfo[playerid][pCop] == 3) { RankText = "Lieutenant"; }
	    			else if(pInfo[playerid][pCop] == 4) { RankText = "Chief"; }
				}
				else if(pInfo[playerid][pFBI] >= 1)
				{
 					if(pInfo[playerid][pFBI] == 1) { RankText = "Agent"; }
	    			else if(pInfo[playerid][pFBI] == 2) { RankText = "Professional Staff"; }
	    			else if(pInfo[playerid][pFBI] == 3) { RankText = "Director"; }
	    		}
	    		else if(pInfo[playerid][pMedic] >= 1)
				{
					RankText = "Medic";
				}
				format(string, sizeof(string), "[Radio] %s: %s,over.",RankText,(result));
				DepartmentMessage(string);
			}else{
			SendClientMessage(playerid,COLOR_GREY,"* You are not a Medic!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/duty", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
            GetPlayerName(playerid, pName, sizeof(pName));
            if(pInfo[playerid][pCop] >= 1)
            {
                if(GetPlayerInterior(playerid) == 3)
                {
           	   		if(OnDuty[playerid] == 0)
                	{
                		OnDuty[playerid] = 1;
	            		format(string, sizeof(string), "* Officer %s took his uniform and Gun from his Locker.", pName);
			    		ProxDetector(25.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			    		SetPlayerSkin(playerid,280);
		    			GivePlayerWeapon(playerid,24,307);
			    		GivePlayerWeapon(playerid,25,50);
			    		GivePlayerWeapon(playerid,3,1);
			    		SetPlayerArmour(playerid,100);
                		}else{
                		OnDuty[playerid] = 0;
	            		format(string, sizeof(string), "* Officer %s places his uniform and his Gun back to his Locker.", pName);
			    		ProxDetector(25.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			    		ResetPlayerWeapons(playerid);
			    		if(pInfo[playerid][pSex] == 2) SetPlayerSkin(playerid,56); else SetPlayerSkin(playerid,60);
						GivePlayerWeapon(playerid,24,207);
 					}
				}else{
				SendClientMessage(playerid,COLOR_GREY,"* You are not in Locker Room!");
				}
  			}else{
  			SendClientMessage(playerid,COLOR_GREY,"* You are not a Cop / FBI!");
  			}
  			if(pInfo[playerid][pFBI] >= 1)
            {
           	   	if(OnDuty[playerid] == 0)
                {
                OnDuty[playerid] = 1;
	            format(string, sizeof(string), "* Agent %s took his uniform and Gun from his Locker.", pName);
			    ProxDetector(25.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			    SetPlayerSkin(playerid,286);
		    	GivePlayerWeapon(playerid,24,307);
			    GivePlayerWeapon(playerid,29,330);
			    SetPlayerArmour(playerid,120);
                }else{
                OnDuty[playerid] = 0;
	            format(string, sizeof(string), "* Agent %s places his uniform and his Gun back to his Locker.", pName);
			    ProxDetector(25.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			    ResetPlayerWeapons(playerid);
				if(pInfo[playerid][pSex] == 2) SetPlayerSkin(playerid,56); else SetPlayerSkin(playerid,60);
				GivePlayerWeapon(playerid,24,207);
                }
  			}else{
  			SendClientMessage(playerid,COLOR_GREY,"* You are not a Cop / FBI!");
  			}
	    }
	    return 1;
	}

	if(strcmp(cmd, "/tie", true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
		    if(pStuff[playerid][Rope] != 1)
		    {
		        SendClientMessage(playerid,COLOR_GREY,"* You don't have a Rope!");
		        return 1;
		    }
		    new suspect = GetClosestPlayer(playerid);
 			if(GetDistanceBetweenPlayers(playerid,suspect) < 5)
	  		{
	  		    if(pTied[suspect] == 1 || pCuffed[suspect] == 1)
	  		    {
	  		        SendClientMessage(playerid,COLOR_GREY,"* Player already Tied Up!");
	  		        return 1;
	  		    }
	  		    if(suspect == playerid) { return 1; }
                GetPlayerName(suspect, gName, sizeof(gName));
				GetPlayerName(playerid, pName, sizeof(pName));
				format(string, sizeof(string), "* You have been Tied Up by %s.",pName);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
				format(string, sizeof(string), "* You have Tied Up %s.",gName);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
				TogglePlayerControllable(gPlayer,0);
				pTied[gPlayer] = 1;
				pStuff[playerid][Rope] = 0;
				GameTextForPlayer(suspect,"~r~TIED",3500,3);
				format(string, sizeof(string), "* %s takes a rope and ties %s up.",pName,gName);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	  		}else{
	  		SendClientMessage(playerid,COLOR_GREY,"* No-One near you!");
	  		}
		}
		return 1;
	}

	if(strcmp(cmd, "/untie", true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
		    new suspect = GetClosestPlayer(playerid);
 			if(GetDistanceBetweenPlayers(playerid,suspect) < 5)
	  		{
	  		    if(pTied[suspect] == 0)
	  		    {
	  		        SendClientMessage(playerid,COLOR_GREY,"* Player isn't Tied Up!");
	  		        return 1;
	  		    }
	  		    if(suspect == playerid) { return 1; }
                GetPlayerName(suspect, gName, sizeof(gName));
				GetPlayerName(playerid, pName, sizeof(pName));
				format(string, sizeof(string), "* You have been UnTied by %s.",pName);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
				format(string, sizeof(string), "* You have Untied %s.",gName);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
				TogglePlayerControllable(gPlayer,1);
				pTied[gPlayer] = 0;
				pStuff[playerid][Rope] = 1;
				GameTextForPlayer(suspect,"~g~UNTIED",3500,3);
				format(string, sizeof(string), "* %s takes out his pocket knife and unties %s.",pName,gName);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	  		}else{
	  		SendClientMessage(playerid,COLOR_GREY,"* No-One near you!");
	  		}
		}
		return 1;
	}

	if(strcmp(cmd, "/cuff", true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
		    if(pInfo[playerid][pCop] >= 1 || pInfo[playerid][pFBI] >= 1)
		    {
		    	new suspect = GetClosestPlayer(playerid);
 				if(GetDistanceBetweenPlayers(playerid,suspect) < 5)
	  			{
	  		    	if(pTied[suspect] == 1 || pCuffed[suspect] == 1)
	  		    	{
	  		        	SendClientMessage(playerid,COLOR_GREY,"* Player already Tied Up!");
	  		        	return 1;
	  		    	}
	  		    	if(suspect == playerid) { return 1; }
                	GetPlayerName(suspect, gName, sizeof(gName));
					GetPlayerName(playerid, pName, sizeof(pName));
					format(string, sizeof(string), "* You have been Cuffed by %s.",pName);
					SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
					format(string, sizeof(string), "* You have Cuffed %s.",gName);
					SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
					TogglePlayerControllable(gPlayer,0);
					pCuffed[gPlayer] = 1;
					GameTextForPlayer(suspect,"~r~CUFFED",3500,3);
					format(string, sizeof(string), "* %s takes out cuffs and hands it on %s's hands.",pName,gName);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	  			}else{
	  			SendClientMessage(playerid,COLOR_GREY,"* No-One near you!");
	  			}
  			}else{
			SendClientMessage(playerid,COLOR_GREY,"* You are not a Cop / FBI!");
  			}
	    }
		return 1;
	}

	if(strcmp(cmd, "/uncuff", true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
		    if(pInfo[playerid][pCop] >= 1 || pInfo[playerid][pFBI] >= 1)
		    {
		    	new suspect = GetClosestPlayer(playerid);
 				if(GetDistanceBetweenPlayers(playerid,suspect) < 5)
	  			{
	  			    if(pCuffed[suspect] == 0)
	  			    {
	  			        SendClientMessage(playerid,COLOR_GREY,"* Player isn't Tied Up!");
	  			        return 1;
	  			    }
		  		    if(suspect == playerid) { return 1; }
	                GetPlayerName(suspect, gName, sizeof(gName));
					GetPlayerName(playerid, pName, sizeof(pName));
					format(string, sizeof(string), "* You have been Cuffed by %s.",pName);
					SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
					format(string, sizeof(string), "* You UnCuffed %s.",gName);
					SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
					TogglePlayerControllable(gPlayer,1);
					pCuffed[gPlayer] = 0;
					GameTextForPlayer(suspect,"~g~UNTIED",3500,3);
					format(string, sizeof(string), "* %s takes the key from his pocket and uncuffs %s.",pName,gName);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		  		}else{
		  		SendClientMessage(playerid,COLOR_GREY,"* No-One near you!");
		  		}
	  		}else{
			SendClientMessage(playerid,COLOR_GREY,"* You are not a Cop / FBI!");
	  		}
		}
		return 1;
	}

	if(strcmp(cmd, "/drag", true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
		    if(pInfo[playerid][pCop] >= 1 || pInfo[playerid][pFBI] >= 1)
		    {
		    	new suspect = GetClosestPlayer(playerid);
 				if(GetDistanceBetweenPlayers(playerid,suspect) < 3)
	  			{
	  		    	if(pDragged[suspect] == 1)
	  		    	{
	  		        	SendClientMessage(playerid,COLOR_GREY,"* Player already dragged by someone else!");
	  		        	return 1;
	  		    	}
	  		    	if(suspect == playerid) { return 1; }
                	GetPlayerName(suspect, gName, sizeof(gName));
					GetPlayerName(playerid, pName, sizeof(pName));
					format(string, sizeof(string), "* You have been Dragged by %s.",pName);
					SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
					format(string, sizeof(string), "* You starts Dragging %s.",gName);
					SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
					SendClientMessage(playerid,COLOR_WHITE,"HINT: Use /dragend to stop dragging.");
					TogglePlayerControllable(gPlayer,0);
					pDragged[gPlayer] = 1;
					pDragCop[gPlayer] = playerid;
					pDragging[playerid] = gPlayer;
					format(string, sizeof(string), "* %s starts dragging %s, he still Cuffed.",pName,gName);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	  			}else{
	  			SendClientMessage(playerid,COLOR_GREY,"* No-One near you!");
	  			}
  			}else{
			SendClientMessage(playerid,COLOR_GREY,"* You are not a Cop / FBI!");
  			}
	    }
		return 1;
	}

	if(strcmp(cmd, "/dragend", true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
		    if(pInfo[playerid][pCop] >= 1 || pInfo[playerid][pFBI] >= 1)
		    {
		        if(pDragging[playerid] == 0)
		        {
		            SendClientMessage(playerid,COLOR_GREY,"* You are not dragging someone!");
		            return 1;
		        }
		        if(!IsPlayerConnected(pDragging[playerid]))
		        {
		            SendClientMessage(playerid,COLOR_GREY,"* You lost your dragging man... (OOC: Disconnected)");
		            pDragging[playerid] = 0;
		            return 1;
		        }
		        GetPlayerName(pDragging[playerid], gName, sizeof(gName));
				GetPlayerName(playerid, pName, sizeof(pName));
		        pDragged[pDragging[playerid]] = 0;
		        TogglePlayerControllable(pDragging[playerid],1);
		        pDragging[playerid] = 0;
		        pDragCop[pDragging[playerid]] = 0;
		        format(string, sizeof(string), "* You've stopped dragging %s!",gName);
		        SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
		        format(string, sizeof(string), "* %s stops dragging you!",pName);
		        SendClientMessage(pDragging[playerid],COLOR_LIGHTBLUE,string);
		    }
		}
		return 1;
	}

	if(strcmp(cmd, "/paralyse", true) == 0 || strcmp(cmd, "/pa", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		    if(pInfo[playerid][pCop] >= 1 || pInfo[playerid][pFBI] >= 1)
		    {
		    	if(IsPlayerInAnyVehicle(playerid))
		    	{
		        	SendClientMessage(playerid,COLOR_GREY,"* You can't use the Paralyser in a Vehicle!");
		        	return 1;
		    	}
		    	new suspect = GetClosestPlayer(playerid);
			  	if(GetDistanceBetweenPlayers(playerid,suspect) < 5)
			  	{
 	    			if(IsPlayerInAnyVehicle(suspect))
	 				{
						SendClientMessage(playerid,COLOR_GREY,"* Suspect is in Vehicle, get him out first!");
      					return 1;
  					}
				  	if(OnDuty[playerid] != 1)
   					{
        				SendClientMessage(playerid,COLOR_GREY,"* You don't have your Paralyser, go On Duty!");
	  	        		return 1;
	  	    		}
				  	if(suspect == playerid) { return 1; }
                    new Float:health;
           			GetPlayerName(suspect, gName, sizeof(gName));
			        GetPlayerName(playerid, pName, sizeof(pName));
		            format(string, sizeof(string), "* You have been paralysed by Officer %s!", pName);
   			 		SendClientMessage(suspect, COLOR_LIGHTBLUE, string);
		            format(string, sizeof(string), "* You have paralysed %s.", gName);
	 				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	 				format(string, sizeof(string), "* Officer %s paralysed %s with his paralyse gun.", pName ,gName);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	 			    GetPlayerHealth(suspect,health);
				 	SetPlayerHealth(suspect, health -10);
				 	GameTextForPlayer(suspect,"~n~~n~~r~Paralysed...",3000,3);
				 	TogglePlayerControllable(suspect,0);
				 	ApplyAnimation(suspect, "CRACK", "crckdeth2", 4.299999, 1, 1, 1, 0, 15000);
				 	ApplyAnimation(suspect, "CRACK", "crckdeth2", 4.299999, 1, 1, 1, 0, 15000);
					pCuffTime[suspect] = 7;
					}else{
					SendClientMessage(playerid,COLOR_GREY,"* No-One near you!");
					}
				}else{
				SendClientMessage(playerid,COLOR_GREY,"* You are not a Cop / FBI!");
				}
			}
		return 1;
	}

	if(strcmp(cmd, "/megaphone", true) == 0 || strcmp(cmd, "/m", true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
		    if(pInfo[playerid][pCop] >= 1 || pInfo[playerid][pFBI] >= 1)
		    {
			GetPlayerName(playerid, pName, sizeof(pName));
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
				SendClientMessage(playerid, COLOR_GREY, "USAGE: /(m)egaphone [text]");
				return 1;
			}
			if(pInfo[playerid][pCop] >= 1)
			{
				format(string, sizeof(string), "[Officer %s: %s]", pName, result);
			}
			if(pInfo[playerid][pFBI] >= 1)
			{
				format(string, sizeof(string), "[Agent %s: %s]", pName, result);
			}
			ProxDetector(40.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			}else{
			SendClientMessage(playerid,COLOR_GREY,"* You are not a Cop / FBI!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/suspect", true) == 0 || strcmp(cmd, "/su", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
			if(pInfo[playerid][pCop] >= 1 || pInfo[playerid][pFBI] >= 1)
			{
			    tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_GREY, "USAGE: /suspect [playerid]");
					return 1;
				}
				gPlayer = strval(tmp);
	   			if(IsPlayerConnected(gPlayer))
				{
				    if(gPlayer == playerid)
				    {
				        SendClientMessage(playerid,COLOR_GREY,"* You can't make Suspect from self!");
				        return 1;
				    }
                	GetPlayerName(playerid, pName, sizeof(pName));
                	GetPlayerName(gPlayer, gName, sizeof(gName));
                	new RankText[20];
	    			if(pInfo[playerid][pCop] >= 1)
	                {
	    				if(pInfo[playerid][pCop] == 1) { RankText = "Cadet"; }
	    				else if(pInfo[playerid][pCop] == 2) { RankText = "Officer"; }
	    				else if(pInfo[playerid][pCop] == 3) { RankText = "Lieutenant"; }
	    				else if(pInfo[playerid][pCop] == 4) { RankText = "Chief"; }
					}
					else if(pInfo[playerid][pFBI] >= 1)
					{
	    				if(pInfo[playerid][pFBI] == 1) { RankText = "Agent"; }
	    				else if(pInfo[playerid][pFBI] == 2) { RankText = "Professional Staff"; }
	    				else if(pInfo[playerid][pFBI] == 3) { RankText = "Director"; }
	    			}
                	format(string, sizeof(string), "[Radio] %s %s made a suspect from %s!", RankText, pName, gName);
					RadioMessage(string);
					WantedLvl[gPlayer] += 2;
					SetPlayerWantedLevel(playerid,GetPlayerWantedLevel(playerid)+2);
				}else{
				SendClientMessage(playerid,COLOR_GREY,"* Player not Connected!");
				}
			}else{
			SendClientMessage(playerid,COLOR_GREY,"* You are not a Cop / FBI!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/arrest", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
			if(pInfo[playerid][pCop] >= 1 || pInfo[playerid][pFBI] >= 1)
			{
		        if(!PlayerToPoint(playerid,197.9962,159.0949,1003.0234,5))
				{
				    SendClientMessage(playerid, COLOR_GREY, "* You are not near the cells!");
				    return 1;
				}
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_GREY, "USAGE: /arrest [price] [time] [bail (0=no/1=yes)] [bailprice]");
					return 1;
				}
	            moneys = strval(tmp);
				if(moneys < 1 || moneys > 5000)
				{
					SendClientMessage(playerid, COLOR_GREY, "* Jail Price can't be above 1$ and below 5000$!");
					return 1;
				}
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "USAGE: /arrest [price] [time] [bail (0=no/1=yes)] [bailprice]");
					return 1;
				}
				new time = strval(tmp);
				if(time < 1 || time > 20)
				{
					SendClientMessage(playerid, COLOR_GREY, "* Jail time can't be smaller then 1 and higher then 20!");
					return 1;
				}
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "USAGE: /arrest [price] [time] [bail (0=no/1=yes)] [bailprice]");
					return 1;
				}
				new bail = strval(tmp);
				if(bail < 0 || bail > 1)
				{
	 				SendClientMessage(playerid, COLOR_GREY, "* Bail can't be below 0 or above 1 !");
			  		return 1;
			  	}
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_WHITE, "USAGE: /arrest [price] [time] [bail (0=no/1=yes)] [bailprice]");
					return 1;
				}
				new bailprice = strval(tmp);
				if(bailprice < 5000 || bailprice > 300000)
				{
					SendClientMessage(playerid, COLOR_GREY, "* Bail Price can't be below $5000 or above $300000 !");
					return 1;
			 	}
				new suspect = GetClosestPlayer(playerid);
				if(pJailed[suspect] == 1)
				{
					SendClientMessage(playerid,COLOR_GREY,"* Player already Arrested!");
					return 1;
				}
				if(IsPlayerConnected(suspect))
				{
					if(GetDistanceBetweenPlayers(playerid,suspect) < 3)
					{
					    if(OnDuty[playerid] == 1)
					    {
					    pDragged[suspect] = 0;
						GetPlayerName(suspect, gName, sizeof(gName));
						GetPlayerName(playerid, pName, sizeof(pName));
						format(string, sizeof(string), "* You have Arrested %s!", gName);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string),"* You have been Arrested by %s, for $%d, Bail Price: $%d!", pName,moneys,bailprice);
						SendClientMessage(playerid,COLOR_DMV2,string);
						new TotalTime;
						if(GetPlayerMoney(suspect) >= moneys)
						{
							GivePlayerMoney(suspect,-moneys);
						}
						else
						{
						    TotalTime = time+3;
						    format(string, sizeof(string),"* You don't have enough money to pay Jail price, your jail time have been increased to %d!", TotalTime);
							SendClientMessage(playerid,COLOR_DMV2,string);
						}
						ResetPlayerWeapons(suspect);
						SetPlayerInterior(suspect,3);
						SetPlayerPos(suspect,198.3887,161.9649,1003.0300);
						SetPlayerFacingAngle(suspect,179.2283);
						TogglePlayerControllable(playerid,0);
						pJailTime[suspect] = TotalTime*60;
						SendClientMessage(suspect,COLOR_WHITE,"HINT: Type /bail to pay your bail.");
						pJailed[suspect] = 1;
						format(string, sizeof(string), ">>> Arresting Done. %s got Arrested by Officer %s <<<", gName,pName);
						RadioMessage(string);
						SetPlayerWantedLevel(suspect,0);
						TogglePlayerControllable(suspect,1);
						}else{
						SendClientMessage(playerid, COLOR_GREY, "* You are not On Duty!");
						}
					}
				}else{
    			SendClientMessage(playerid, COLOR_GREY,"* No-One near you!");
				}
			}else{
   			SendClientMessage(playerid, COLOR_GREY, "* You are not a Cop / FBI!");
			}
		}
	    return 1;
	}

	if(strcmp(cmd, "/ticket", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(pInfo[playerid][pCop] == 0 || pInfo[playerid][pFBI] == 0)
			{
			    SendClientMessage(playerid, COLOR_GREY, "* You are not a Cop / FBI!");
			    return 1;
			}
	        if(OnDuty[playerid] == 0)
			{
			    SendClientMessage(playerid, COLOR_GREY, "* You are not On Duty!");
			    return 1;
			}
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GREY, "USAGE: /ticket [playerid] [price] [reason]");
				return 1;
			}
			gPlayer = strval(tmp);
            tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /ticket [playerid] [price] [reason]");
				return 1;
			}
	        if(playerid == gPlayer)
			{
			    SendClientMessage(playerid, COLOR_GREY, "* You can't give a Ticket to self!");
			    return 1;
			}
			moneys = strval(tmp);
			if(moneys < 20 || moneys > 2000)
			{
				SendClientMessage(playerid, COLOR_GREY, "* Ticket Price can't be below $20 or higher then $2000!");
				return 1;
			}
			if(IsPlayerConnected(gPlayer))
			{
			    if(gPlayer != INVALID_PLAYER_ID)
			    {
			        if(GetDistanceBetweenPlayers(playerid,gPlayer) < 4)
					{
					    GetPlayerName(gPlayer, gName, sizeof(gName));
						GetPlayerName(playerid, pName, sizeof(pName));
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
							SendClientMessage(playerid, COLOR_WHITE, "USAGE: /ticket [playerid] [price] [reason]");
							return 1;
						}
						format(string, sizeof(string), "* You gave %s a $%d Ticket for '%s'", gName, moneys, (result));
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* %s has given you a $%d Ticket for Reason: %s", pName, moneys, (result));
						SendClientMessage(gPlayer, COLOR_LIGHTBLUE, string);
						SendClientMessage(gPlayer, COLOR_WHITE, "HINT: Type /accept ticket, to pay the Ticket.");
						format(string, sizeof(string), "* %s writes down a ticket and hands it to %s.",pName,gName);
						ProxDetector(30.0,playerid,string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						TicketOffer[gPlayer] = playerid;
						TicketMoney[gPlayer] = moneys;
					}else{
					SendClientMessage(playerid, COLOR_GREY, "* You are too far away!");
					}
				}
			}else{
			SendClientMessage(playerid, COLOR_GREY, "* Player isn't Connected!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/backup", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	   	{
	   	    if(CalledBackup[playerid] == 0)
	   	    {
				if(pInfo[playerid][pCop] >= 1 || pInfo[playerid][pFBI] >= 1)
				{
					CalledBackup[playerid] = 1;
					BackupCaller = playerid;
					GetPlayerName(playerid, pName, sizeof(pName));
					format(string, sizeof(string), "* %s has called for a backup. (Use /accept to accept it)",pName);
					RadioMessage(string);
					SendClientMessage(playerid,COLOR_LIGHTBLUE,"* You've called for a backup.");
				}else{
				SendClientMessage(playerid, COLOR_GREY, "* You are not a Cop / FBI!");
				}
			}
			else
			{
				CalledBackup[playerid] = 0;
				BackupCaller = 0;
				GetPlayerName(playerid, pName, sizeof(pName));
				format(string, sizeof(string), "* %s has canceled his call.",pName);
				RadioMessage(string);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"* You've canceled your backup call.");
				SetPlayerColor(playerid,COLOR_WHITE);
				for(new i;i<MAX_PLAYERS;i++) ShowPlayerNameTagForPlayer(i,playerid,0);
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/frisk", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GREY, "USAGE: /frisk [playerid]");
				return 1;
			}
			gPlayer = strval(tmp);
	        if(IsPlayerConnected(gPlayer))
			{
			    if(gPlayer != INVALID_PLAYER_ID)
			    {
			        if(GetDistanceBetweenPlayers(playerid,gPlayer) < 3)
					{
					    GetPlayerName(gPlayer, gName, sizeof(gName));
						GetPlayerName(playerid, pName, sizeof(pName));
						format(string, sizeof(string), "* You have frisked %s.", gName);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* %s frisks you.", pName);
						SendClientMessage(gPlayer, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "|____|%s's Pocket|____|", pName);
						SendClientMessage(playerid,COLOR_YELLOW,string);
						if(pInfo[gPlayer][pMats] == 1)
						{
						    SendClientMessage(playerid,COLOR_CHAT3,"* Materials");
						}else{
						    SendClientMessage(playerid,COLOR_CHAT3,"* Empty Pocket");
						}
						if(GetPlayerMoney(gPlayer) > 0)
						{
						    SendClientMessage(playerid,COLOR_CHAT3,"* Some Money");
						}else{
						    SendClientMessage(playerid,COLOR_CHAT3,"* Empty Pocket");
						}
						if(GetPlayerWeapon(gPlayer) > 22)
						{
						    SendClientMessage(playerid,COLOR_CHAT3,"* Weapon");
						}else{
						    SendClientMessage(playerid,COLOR_CHAT3,"* Empty Pocket");
						}
						format(string, sizeof(string), "* %s frisked %s for any illegal items.",pName,gName);
						ProxDetector(30.0,playerid,string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    }else{
					SendClientMessage(playerid, COLOR_GREY, "* You are too far away!");
					}
				}
			}else{
			SendClientMessage(playerid, COLOR_GREY, "* Player isn't Connected!");
			}
		}
	    return 1;
	}

	if(strcmp(cmd,"/fare",true)==0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        if(pInfo[playerid][pDriver] >= 1)
			{
			    new VMODEL = GetVehicleModel(playerid);
				if(TransportDuty[playerid] > 0)
				{
				    TransportDuty[playerid] = 0;
					format(string, sizeof(string), "* You are now Off Duty and earned $%d.", TransportMoney[playerid]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					GivePlayerMoney(playerid, TransportMoney[playerid]);
					ConsumingMoney[playerid] = 1; TransportValue[playerid] = 0; TransportMoney[playerid] = 0;
					return 1;
				}
				if(VMODEL == 420)
				{
				    if(GetPlayerState(playerid) == 2)
				    {
					    tmp = strtok(cmdtext, idx);
						if(!strlen(tmp))
						{
							SendClientMessage(playerid, COLOR_WHITE, "USAGE: /fare [price]");
							return 1;
						}
						moneys = strval(tmp);
						if(moneys < 1 || moneys > 150)
						{
							SendClientMessage(playerid, COLOR_GREY, "* Fare price must be between $1 and $150!");
							return 1;
						}
					    TransportDuty[playerid] = 2; TransportValue[playerid]= moneys;
					    GetPlayerName(playerid,pName,sizeof(pName));
	    				format(string, sizeof(string), "Taxi Driver: %s is now On Duty, fare: $%d.", pName, TransportValue[playerid]);
	    				SendClientMessageToAll(COLOR_GREEN,string);
					}else{
	      			SendClientMessage(playerid, COLOR_GREY, "* You are not the Driver!");
					}
				}else{
    			SendClientMessage(playerid, COLOR_GREY, "* You are not in a Taxi!");
				}
			}else{
   			SendClientMessage(playerid,COLOR_GREY,"* You are not a Taxi Driver!");
			}
	    }
	    return 1;
 	}

 	if(strcmp(cmd, "/heal", true) == 0)
	{
		if(IsPlayerConnected(playerid))
	   	{
		   	if(pInfo[playerid][pMedic] == 1)
		   	{
     			tmp = strtok(cmdtext, idx);
		   	    if(!strlen(tmp))
		        {
                    SendClientMessage(playerid,COLOR_GREY,"USAGE: /heal [playerid]");
			        return 1;
                }
			    gPlayer = strval(tmp);
  	   			if(IsPlayerConnected(gPlayer))
			   	{
				  	if(GetDistanceBetweenPlayers(playerid,gPlayer) < 2)
				  	{
				  	    new Float:HP; GetPlayerHealth(playerid,HP);
				  	    if(HP > 90)
				  	    {
				  	    	SendClientMessage(playerid,COLOR_GREY,"* This player don't need medical help!");
				  	        return 1;
				  	    }
				  		GetPlayerName(playerid, pName, sizeof(pName));
				  		GetPlayerName(gPlayer, gName, sizeof(gName));
				  		format(string, sizeof(string), "* Medic %s opens his medical kit and heals %s.", pName,gName);
	    				ProxDetector(25.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	    				SetPlayerHealth(playerid,HP+25);
				  	}else{
				  	SendClientMessage(playerid,COLOR_GREY,"* You are too far away!");
				  	}
			    }else{
			    SendClientMessage(playerid,COLOR_GREY,"* Player not Connected!");
			    }
   			}else{
   			SendClientMessage(playerid,COLOR_GREY,"* You are not a Medic!");
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
		    	SendClientMessage(playerid,COLOR_GREY, "USAGE: /find [playerid]");
		    	return 1;
			}
			gPlayer = strval(tmp);
	        if(pInfo[playerid][pJob] != 2)
	        {
	            SendClientMessage(playerid,COLOR_GREY,"* You are not a Detective!");
	            return 1;
	        }
	        if(pCMDFind[playerid] == 1)
	        {
	            SendClientMessage(playerid,COLOR_GREY,"* You've already found someone, you must wait now 1 minute!");
	            return 1;
	        }
	        GetPlayerName(playerid, pName, sizeof(pName));
	        format(string,256,"* %s takes his laptop and starts searching...",gName);
			ProxDetector(10.0,playerid,string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			pCMDFind[playerid] = 1; pDetectMan[playerid] = gPlayer;
			SetTimerEx("FindPlayer",5000,0,"i",playerid);
			SetTimerEx("ResetDetective",60000,0,"i",playerid);
	    }
	    return 1;
	}

	if(strcmp(cmd, "/sellcar", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(pInfo[playerid][pJob] == 5)
        	{
        	    if(IsPlayerInAnyVehicle(playerid))
	        	{
	        		if(PlayerToPoint(playerid,1672.3341,1842.8002,10.8203,3))
	        		{
						new VMod = GetVehicleModel(playerid);
						if(VMod == 597 || VMod == 598 || VMod == 523 || VMod == 427 || VMod == 490)
						{
						    SendClientMessage(playerid, COLOR_GREY, "* You fool! It's Police Car! Eliminate it before Police detect it!");
						    return 1;
						}
						else if(VMod == 510 || VMod == 509 || VMod == 481)
						{
						    SendClientMessage(playerid, COLOR_GREY, "* You idiot! We are not selling bicycles!");
						    return 1;
						}
						else if(VMod == 509)
						{
						    SendClientMessage(playerid, COLOR_GREY, "* Oh shit! It's Corleone Mafia car! Eliminate it before they kill us!");
						    return 1;
						}
						else if(VMod == 416)
						{
						    SendClientMessage(playerid, COLOR_GREY, "* Are you okay? I can't export Emergency Vehicle!");
						    return 1;
						}
						else
						{
							new RandText = random(3);
							switch(RandText)
							{
								case 0: SendClientMessage(playerid,COLOR_WHITE,"* Very good job, this car is looking very nice! Go on Red Marker and drop it here!");
								case 1: SendClientMessage(playerid,COLOR_WHITE,"* What the hell? This car is beautiful, Go on Red Marker and drop it here!");
								case 2: SendClientMessage(playerid,COLOR_WHITE,"* What the fuck? This is car? It's old ham! Go on Red Marker and drop it here!");
							}
							pSellingCar[playerid] = GetPlayerVehicleID(playerid);
							pCheckPoint[playerid] = 1;
							SetPlayerCheckpoint(playerid,-907.5880,2699.8542,42.0851,5);
						}
					}else{
					SendClientMessage(playerid,COLOR_GREY,"* You are not near the Closed Car Shop!");
					}
                }else{
				SendClientMessage(playerid,COLOR_GREY,"* You don't have a vehicle!");
				}
            }else{
			SendClientMessage(playerid,COLOR_GREY,"* You are not a Car Jacker!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/quitjob", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(pInfo[playerid][pJob] == 0)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "* You don't have a Job!");
	            return 1;
	        }
			if(JobTime[playerid] > 0)
			{
			    SendClientMessage(playerid, COLOR_GREY, "* Your 3 hour contract haven't be done!");
			    return 1;
			}
			pInfo[playerid][pJob] = 0;
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* You've done your 5 Hour contract and quited the Job!");
	    }
	    return 1;
	}

 	/*
	  *
		* HOUSE Commands *
   *
	*/

	if(strcmp(cmd, "/buyhouse", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new Float:oldposx, Float:oldposy, Float:oldposz;
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername, sizeof(playername));
			GetPlayerPos(playerid, oldposx, oldposy, oldposz);
			for(new h=0; h < sizeof(hInfo); h++)
			{
				if(PlayerToPoint(playerid, hInfo[h][hEntrancex], hInfo[h][hEntrancey], hInfo[h][hEntrancez],2) && hInfo[h][hOwned] == 0)
				{
					if(pInfo[playerid][pHouseKey] != 255 && strcmp(playername, hInfo[pInfo[playerid][pHouseKey]][hOwner], true) == 0)
					{
						SendClientMessage(playerid, COLOR_GREY, "* You already own a house, type /sellhouse if you want to buy this one !");
						return 1;
					}
					if(GetPlayerMoney(playerid) > hInfo[h][hValue])
					{
						pInfo[playerid][pHouseKey] = h;
						hInfo[h][hOwned] = 1;
						GetPlayerName(playerid, pName, sizeof(pName));
						strmid(hInfo[h][hOwner], pName, 0, strlen(pName), 255);
						GivePlayerMoney(playerid,-hInfo[h][hValue]);
						SetPlayerInterior(playerid,hInfo[h][hInt]);
						SetPlayerPos(playerid,hInfo[h][hExitx],hInfo[h][hExity],hInfo[h][hExitz]);
						GameTextForPlayer(playerid, "~w~Welcome Home", 3000, 1);
						new pInt = GetPlayerInterior(playerid);
						pInt = hInfo[h][hInt];
						SendClientMessage(playerid,COLOR_DMV,"* Congratulations, you have bought a House!");
						SendClientMessage(playerid,COLOR_WHITE,"HINT: Type /sellhouse to sell your house.");
						OnPlayerUpdate(playerid);
						GetPlayerName(playerid,pName,sizeof(pName));
	    				format(string, sizeof(string), "Player %s has bought a house (Interior %d)", pName, pInt);
	    				SaveToConfig(string);
	    				OnHouseUpdate();
	    				OnPlayerUpdate(playerid);
					}else{
					SendClientMessage(playerid, COLOR_GREY, "* You don't have that much Money!");
					}
				}
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
			if(pInfo[playerid][pHouseKey] == 255)
			{
				SendClientMessage(playerid, COLOR_WHITE, "You don't own a house.");
				return 1;
			}
			if(pInfo[playerid][pHouseKey] != 255 && strcmp(playername, hInfo[pInfo[playerid][pHouseKey]][hOwner], true) == 0)
			{
				new house = pInfo[playerid][pHouseKey];
				hInfo[house][hOwned] = 0;
				GetPlayerName(playerid, pName, sizeof(pName));
				strmid(hInfo[house][hOwner], "Las Vegas", 0, strlen("Las Vegas"), 255);
				ConsumingMoney[playerid] = 1;
				GivePlayerMoney(playerid,hInfo[house][hValue]);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				format(string, sizeof(string), "~w~Congratulations~n~ You have sold your property for ~n~~g~$%d", hInfo[house][hValue]);
				GameTextForPlayer(playerid, string, 5000, 3);
				pInfo[playerid][pHouseKey] = 255;
				SetPlayerInterior(playerid,0);
				OnHouseUpdate();
				OnPlayerUpdate(playerid);
			}else{
			SendClientMessage(playerid, COLOR_GREY, "* You don't own a House!");
			}
		}
		return 1;
	}

	/*
	  *
		* ENTER / EXIT Commands *
   *
	*/

	if(strcmp(cmd, "/enter", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
		  	if(PlayerToPoint(playerid,2287.0559,2431.5447,10.8203,2))
			{
				SetPlayerPos(playerid,238.2071,140.4984,1003.0234);
				SetPlayerInterior(playerid,3);
			}
			else if(PlayerToPoint(playerid,2247.6030,2396.9460,10.8203,2))
			{
				SetPlayerPos(playerid,-26.7528,-56.9228,1003.5469);
				SetPlayerInterior(playerid,6); IsInZip[playerid] = 1;
			}
			else if(PlayerToPoint(playerid,2194.5393,1990.9659,12.2969,2))
			{
				SetPlayerPos(playerid,-26.7528,-56.9228,1003.5469);
				SetPlayerInterior(playerid,6); IsInZip[playerid] = 2;
			}
			else if(PlayerToPoint(playerid,2447.3645,2376.1973,12.1635,2))
			{
				SetPlayerInterior(playerid,3);
				SetPlayerPos(playerid,387.7978,173.8582,1008.3828);
				SetPlayerFacingAngle(playerid,92.8399);
			}
		    for(new h=0;h<sizeof(hInfo);h++)
		    {
		        if(PlayerToPoint(playerid,hInfo[h][hEntrancex],hInfo[h][hEntrancey],hInfo[h][hEntrancez],2))
		        {
		            if(pInfo[playerid][pHouseKey] == h)
		            {
	            	SetPlayerInterior(playerid,hInfo[h][hInt]);
					SetPlayerPos(playerid,hInfo[h][hExitx],hInfo[h][hExity],hInfo[h][hExitz]);
		            GameTextForPlayer(playerid,"~r~Welcome Home!",3500,3);
		            }
		        }
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/exit", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
		{
			if(PlayerToPoint(playerid,238.2071,140.4984,1003.0234,2))
			{
                SetPlayerPos(playerid,2287.0559,2431.5447,10.8203);
				SetPlayerInterior(playerid,0);
			}
			else if(PlayerToPoint(playerid,-26.7528,-56.9228,1003.5469,2))
			{
			    if(IsInZip[playerid] == 1)
			    {
					SetPlayerPos(playerid,2247.6030,2396.9460,10.8203);
					SetPlayerInterior(playerid,0); IsInZip[playerid] = 0;
				}
				else
				{
				    SetPlayerPos(playerid,2194.5393,1990.9659,12.2969);
					SetPlayerInterior(playerid,0); IsInZip[playerid] = 0;
				}
			}
			else if(PlayerToPoint(playerid,387.7978,173.8582,1008.3828,3))
	        {
	           	SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,2447.3645,2376.1973,12.1635);
	        }
		    for(new h=0;h<sizeof(hInfo);h++)
		    {
		        if(PlayerToPoint(playerid,hInfo[h][hExitx],hInfo[h][hExity],hInfo[h][hExitz],2))
		        {
		            if(pInfo[playerid][pHouseKey] == h)
		            {
	            	SetPlayerInterior(playerid,0);
					SetPlayerPos(playerid,hInfo[h][hEntrancex],hInfo[h][hEntrancey],hInfo[h][hEntrancez]);
		            }
		        }
			}
			if(IsPlayerInAnyVehicle(playerid))
		  	{
		  	    if(pCuffed[playerid] == 0 && pTied[playerid] == 0)
		  	    {
		  	        RemovePlayerFromVehicle(playerid);
		  	    }else{
		  	    SendClientMessage(playerid,COLOR_GREY,"* You have been Cuffed / Tied Up, so you can't leave the vehicle!");
		  	    }
		  	}
		}
		return 1;
	}


	/*
	  *
		* LEADER Commands *
   *
	*/

	if(strcmp(cmd, "/leadhelp", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(pInfo[playerid][pCop] == 4 || pInfo[playerid][pFBI] == 3 || pInfo[playerid][pMafia1] == 4 || pInfo[playerid][pMafia2] == 4)
			{
	        	SendClientMessage(playerid,COLOR_WHITE,"       .:: - LEADER Manual - ::.");
	        	SendClientMessage(playerid,COLOR_GREY," /invite - To invite someone to your faction.");
	        	SendClientMessage(playerid,COLOR_GREY," /fire - To fire someone from your faction.");
	        	SendClientMessage(playerid,COLOR_GREY," /setrank - To set the rank of someone.");
            }else{
			SendClientMessage(gPlayer,COLOR_GREY,"* You are not the Leader of some faction!");
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
				SendClientMessage(playerid, COLOR_GREY, "USAGE: /invite [playerid]");
				return 1;
			}
			new OrgTxt[64];
			gPlayer = strval(tmp);
			if(pInfo[playerid][pCop] == 4 || pInfo[playerid][pFBI] == 3 || pInfo[playerid][pMafia1] == 4 || pInfo[playerid][pMafia2] == 4)
			{
			    if(gPlayer == playerid)
			    {
			    	SendClientMessage(playerid,COLOR_GREY,"* You can't invite self!");
			        return 1;
			    }
			    if(!IsPlayerConnected(gPlayer))
			    {
			        SendClientMessage(playerid,COLOR_GREY,"* Player isn't Connected!");
			        return 1;
			    }
			    if(gPlayer != INVALID_PLAYER_ID)
       			{
       			    if(pInfo[gPlayer][pCop] < 1 && pInfo[gPlayer][pFBI] < 1 && pInfo[gPlayer][pMafia1] < 1 && pInfo[gPlayer][pMafia2] < 1)
       			    {
       			    	if(pInfo[playerid][pCop] == 4)
				   		{
			   				pInfo[gPlayer][pCop] = 1;
			   				SpawnPlayer(gPlayer);
			   				OrgTxt = "Police Force";
				   		}
				   		else if(pInfo[playerid][pFBI] == 3)
				   		{
			   				pInfo[gPlayer][pFBI] = 1;
			   				SpawnPlayer(gPlayer);
			   				OrgTxt = "Federal Bureau of Investigation";
				   		}
				   		else if(pInfo[playerid][pMafia1] == 4)
				   		{
			   				pInfo[gPlayer][pMafia1] = 1;
			   				SpawnPlayer(gPlayer);
			   				OrgTxt = "Corleone Mafia";
				   		}
				   		else if(pInfo[playerid][pMafia2] == 4)
				   		{
			   				pInfo[gPlayer][pMafia2] = 1;
			   				SpawnPlayer(gPlayer);
			   				OrgTxt = "*** Mafia";
				   		}
				   		GetPlayerName(playerid, pName, sizeof(pName));
				   		GetPlayerName(gPlayer, gName, sizeof(gName));
				   		format(string, sizeof(string), "* You've joined the %s by Leader %s!", OrgTxt,pName);
				   		SendClientMessage(gPlayer,COLOR_LIGHTBLUE,string);
				   		format(string, sizeof(string), "* You've invited %s to %s!", gName,OrgTxt);
				   		SendClientMessage(gPlayer,COLOR_LIGHTBLUE,string);
					}else{
					SendClientMessage(gPlayer,COLOR_GREY,"* That player is already in some faction!");
					}
				}
			}else{
			SendClientMessage(gPlayer,COLOR_GREY,"* You are not the Leader of some faction!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/fire", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GREY, "USAGE: /fire [playerid]");
				return 1;
			}
			new OrgTxt[64];
			gPlayer = strval(tmp);
			if(pInfo[playerid][pCop] == 4 || pInfo[playerid][pFBI] == 3 || pInfo[playerid][pMafia1] == 4 || pInfo[playerid][pMafia2] == 4)
			{
			    if(gPlayer == playerid)
			    {
			    	SendClientMessage(playerid,COLOR_GREY,"* You can't fire self!");
			        return 1;
			    }
			    if(!IsPlayerConnected(gPlayer))
			    {
			        SendClientMessage(playerid,COLOR_GREY,"* Player isn't Connected!");
			        return 1;
			    }
			    if(gPlayer != INVALID_PLAYER_ID)
       			{
       			    if(pInfo[gPlayer][pCop] < 1 && pInfo[gPlayer][pFBI] < 1 && pInfo[gPlayer][pMafia1] < 1 && pInfo[gPlayer][pMafia2] < 1)
       			    {
       			    	if(pInfo[playerid][pCop] == 4)
				   		{
			   				pInfo[gPlayer][pCop] = 0;
			   				SpawnPlayer(gPlayer);
			   				OrgTxt = "Police Force";
				   		}
				   		else if(pInfo[playerid][pFBI] == 3)
				   		{
			   				pInfo[gPlayer][pFBI] = 0;
			   				SpawnPlayer(gPlayer);
			   				OrgTxt = "Federal Bureau of Investigation";
				   		}
				   		else if(pInfo[playerid][pMafia1] == 4)
				   		{
			   				pInfo[gPlayer][pMafia1] = 0;
			   				SpawnPlayer(gPlayer);
			   				OrgTxt = "Corleone Mafia";
				   		}
				   		else if(pInfo[playerid][pMafia2] == 4)
				   		{
			   				pInfo[gPlayer][pMafia2] = 0;
			   				SpawnPlayer(gPlayer);
			   				OrgTxt = "*** Mafia";
				   		}
				   		GetPlayerName(playerid, pName, sizeof(pName));
				   		GetPlayerName(gPlayer, gName, sizeof(gName));
				   		format(string, sizeof(string), "* You've been fired from %s by Leader %s!", OrgTxt,pName);
				   		SendClientMessage(gPlayer,COLOR_LIGHTBLUE,string);
				   		format(string, sizeof(string), "* You've fired %s from %s!", gName,OrgTxt);
				   		SendClientMessage(gPlayer,COLOR_LIGHTBLUE,string);
					}else{
					SendClientMessage(gPlayer,COLOR_GREY,"* That player is already in some faction!");
					}
				}
			}else{
			SendClientMessage(gPlayer,COLOR_GREY,"* You are not the Leader of some faction!");
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
				SendClientMessage(playerid, COLOR_GREY, "USAGE: /setrank [playerid] [rank]");
				return 1;
			}
			new lvl;
			gPlayer = strval(tmp);
			tmp = strtok(cmdtext, idx);
			lvl = strval(tmp);
			if(pInfo[playerid][pCop] == 4 || pInfo[playerid][pFBI] == 3 || pInfo[playerid][pMafia1] == 4 || pInfo[playerid][pMafia2] == 4)
			{
			    if(gPlayer == playerid)
			    {
			    	SendClientMessage(playerid,COLOR_GREY,"* You can't set rank to self!");
			        return 1;
			    }
			    if(!IsPlayerConnected(gPlayer))
			    {
			        SendClientMessage(playerid,COLOR_GREY,"* Player isn't Connected!");
			        return 1;
			    }
			    if(gPlayer != INVALID_PLAYER_ID)
       			{
       			    if(pInfo[playerid][pCop] == 4)
       			    {
       			        if(lvl < 1 || lvl > 4) return SendClientMessage(playerid,COLOR_GREY,"* Invalid Rank number!");
       			        GetPlayerName(playerid, pName, sizeof(pName));
				   		GetPlayerName(gPlayer, gName, sizeof(gName));
				   		format(string, sizeof(string), "* You've been promoted to a rank %d by Leader %s!", lvl,pName);
				   		SendClientMessage(gPlayer,COLOR_LIGHTBLUE,string);
				   		format(string, sizeof(string), "* You've promoted %s to a rank %d!", gName,lvl);
				   		SendClientMessage(gPlayer,COLOR_LIGHTBLUE,string);
				   		pInfo[gPlayer][pCop] = lvl;
       			    }
       			    if(pInfo[playerid][pFBI] == 3)
       			    {
       			        if(lvl < 1 || lvl > 4) return SendClientMessage(playerid,COLOR_GREY,"* Invalid Rank number!");
       			        GetPlayerName(playerid, pName, sizeof(pName));
				   		GetPlayerName(gPlayer, gName, sizeof(gName));
				   		format(string, sizeof(string), "* You've been promoted to a rank %d by Leader %s!", lvl,pName);
				   		SendClientMessage(gPlayer,COLOR_LIGHTBLUE,string);
				   		format(string, sizeof(string), "* You've promoted %s to a rank %d!", gName,lvl);
				   		SendClientMessage(gPlayer,COLOR_LIGHTBLUE,string);
				   		pInfo[gPlayer][pFBI] = lvl;
       			    }
       			    if(pInfo[playerid][pMafia1] == 4)
       			    {
       			        if(lvl < 1 || lvl > 4) return SendClientMessage(playerid,COLOR_GREY,"* Invalid Rank number!");
       			        GetPlayerName(playerid, pName, sizeof(pName));
				   		GetPlayerName(gPlayer, gName, sizeof(gName));
				   		format(string, sizeof(string), "* You've been promoted to a rank %d by Leader %s!", lvl,pName);
				   		SendClientMessage(gPlayer,COLOR_LIGHTBLUE,string);
				   		format(string, sizeof(string), "* You've promoted %s to a rank %d!", gName,lvl);
				   		SendClientMessage(gPlayer,COLOR_LIGHTBLUE,string);
				   		pInfo[gPlayer][pMafia1] = lvl;
       			    }
       			    if(pInfo[playerid][pMafia2] == 4)
       			    {
       			        if(lvl < 1 || lvl > 4) return SendClientMessage(playerid,COLOR_GREY,"* Invalid Rank number!");
       			        GetPlayerName(playerid, pName, sizeof(pName));
				   		GetPlayerName(gPlayer, gName, sizeof(gName));
				   		format(string, sizeof(string), "* You've been promoted to a rank %d by Leader %s!", lvl,pName);
				   		SendClientMessage(gPlayer,COLOR_LIGHTBLUE,string);
				   		format(string, sizeof(string), "* You've promoted %s to a rank %d!", gName,lvl);
				   		SendClientMessage(gPlayer,COLOR_LIGHTBLUE,string);
				   		pInfo[gPlayer][pMafia2] = lvl;
       			    }
				}
			}else{
			SendClientMessage(gPlayer,COLOR_GREY,"* You are not the Leader of some faction!");
			}
		}
		return 1;
	}

	/*
	  *
		* FAMILY Commands *
   *
	*/

	if(strcmp(cmd, "/family", true) == 0 || strcmp(cmd, "/f", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
  			if(pInfo[playerid][pMafia1] > 0 || pInfo[playerid][pMafia2] > 0)
			{
				GetPlayerName(playerid, pName, sizeof(pName));
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
					SendClientMessage(playerid, COLOR_GREY, "USAGE: (/f)amily [text]");
					return 1;
				}
				new RankText[20];
				if(pInfo[playerid][pMafia1] > 0)
				{
					if(pInfo[playerid][pMafia1] == 1) { RankText = "Outsider"; }
					else if(pInfo[playerid][pMafia1] == 2) { RankText = "Associate"; }
					else if(pInfo[playerid][pMafia1] == 3) { RankText = "Capo"; }
					else if(pInfo[playerid][pMafia1] == 4) { RankText = "Boss"; }
					format(string, sizeof(string), "(( * %s %s: %s * ))",RankText,pName,(result));
					FamilyMessage(1,string);
				}
				if(pInfo[playerid][pMafia1] > 0)
				{
					if(pInfo[playerid][pMafia2] == 1) { RankText = "Outsider"; }
					else if(pInfo[playerid][pMafia2] == 2) { RankText = "Associate"; }
					else if(pInfo[playerid][pMafia2] == 3) { RankText = "Capo"; }
					else if(pInfo[playerid][pMafia2] == 4) { RankText = "Boss"; }
					format(string, sizeof(string), "(( * %s %s: %s * ))",RankText,pName,(result));
					FamilyMessage(2,string);
				}
			}else{
			SendClientMessage(playerid,COLOR_GREY,"* You are not in any Family!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/gate", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
  			if(pInfo[playerid][pMafia1] >= 1)
			{
			    if(PlayerToPoint(playerid,1534.740,2777.774,9.845,20))
				{
				GetPlayerName(playerid, pName, sizeof(pName));
				MoveObject(1,1534.754,2768.114,9.839,0.9);
				SendClientMessage(playerid,COLOR_YELLOW,"* The Gate is opening and will close in 13 seconds.");
				format(string, sizeof(string),"* %s takes his remote controll and opens the gate.",pName);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				SetTimer("GateClose",13000,0);
				}else{
				SendClientMessage(playerid,COLOR_GREY,"* You are not near the gate!");
			    }
			}else{
			SendClientMessage(playerid,COLOR_GREY,"* You are not in any Family!");
			}
		}
		return 1;
	}

	/*
	  *
		* DMV (Instructor) Commands *
   *
	*/

	if(strcmp(cmd, "/givelic", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(pInfo[playerid][pInstructor] == 1)
	        {
	            new tmp2[256];
	        	tmp2 = strtok(cmdtext, idx);
	        	if(!strlen(tmp2))
				{
					SendClientMessage(playerid, COLOR_GREY, "USAGE: /givelic [license] [playerid]");
					SendClientMessage(playerid, COLOR_WHITE, "Available names: Driving, Flying.");
					return 1;
				}
				if(strcmp(tmp2,"Driving",true) == 0)
				{
				    tmp = strtok(cmdtext, idx);
				    if(!strlen(tmp2))
					{
						SendClientMessage(playerid, COLOR_GREY, "USAGE: /givelic Driving [playerid]");
						return 1;
					}
					gPlayer = strval(tmp);
					if(gPlayer == playerid)
			    	{
			    		SendClientMessage(playerid,COLOR_GREY,"* You can't give a license to self!");
			        	return 1;
			        }
			    	if(!IsPlayerConnected(gPlayer))
			    	{
			        	SendClientMessage(playerid,COLOR_GREY,"* Player isn't Connected!");
			        	return 1;
			    	}
			        if(gPlayer != INVALID_PLAYER_ID)
	    			{
	    			    GetPlayerName(playerid, pName, sizeof(pName));
	    			    GetPlayerName(gPlayer, gName, sizeof(gName));
	    			    format(string, sizeof(string), "* You've given the Driving license to %s!",gName);
				        SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
				        format(string, sizeof(string), "* %s gives you the Driving license!",pName);
				        SendClientMessage(gPlayer,COLOR_LIGHTBLUE,string);
				        pInfo[gPlayer][pCarLic] = 1;
	    			}
				}
				else if(strcmp(tmp2,"Flying",true) == 0)
				{
				    tmp = strtok(cmdtext, idx);
				    if(!strlen(tmp2))
					{
						SendClientMessage(playerid, COLOR_GREY, "USAGE: /givelic Flying [playerid]");
						return 1;
					}
					gPlayer = strval(tmp);
					if(gPlayer == playerid)
			    	{
			    		SendClientMessage(playerid,COLOR_GREY,"* You can't give a license to self!");
			        	return 1;
			        }
			    	if(!IsPlayerConnected(gPlayer))
			    	{
			        	SendClientMessage(playerid,COLOR_GREY,"* Player isn't Connected!");
			        	return 1;
			    	}
			        if(gPlayer != INVALID_PLAYER_ID)
	    			{
	    			    GetPlayerName(playerid, pName, sizeof(pName));
	    			    GetPlayerName(gPlayer, gName, sizeof(gName));
	    			    format(string, sizeof(string), "* You've given the Flying license to %s!",gName);
				        SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
				        format(string, sizeof(string), "* %s gives you the Flying license!",pName);
				        SendClientMessage(gPlayer,COLOR_LIGHTBLUE,string);
				        pInfo[gPlayer][pFlyLic] = 1;
	    			}
				}else{
				SendClientMessage(playerid, COLOR_GREY, "USAGE: /givelic [license] [playerid]");
				SendClientMessage(playerid, COLOR_WHITE, "Available names: Driving, Flying.");
				}
	        }else{
			SendClientMessage(playerid,COLOR_GREY,"* You are not the DMV Instructor!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/dmv", true) == 0)
	{
        if(IsPlayerConnected(playerid))
	    {
	        	if(pInfo[playerid][pInstructor] != 1)
	        	{
	            	SendClientMessage(playerid,COLOR_GREY,"* You are not a DMV Instructor!");
	        		return 1;
	        	}
        		new tmp2[256];
	        	tmp = strtok(cmdtext,idx);
	        	if(!strlen(tmp2))
				{
			    	SendClientMessage(playerid,COLOR_GREY,"USAGE: /dmv [open/close]");
			    	return 1;
   				}
   				else if(strcmp(tmp2,"open",true) == 0)
   				{
   			    	if(DMV == 1)
   			    	{
   			        	SendClientMessage(playerid,COLOR_GREY,"* DMV is already Opened!");
   			        	return 1;
   			    	}
   			    	GetPlayerName(playerid, pName, sizeof(pName));
   			    	format(string, sizeof(string), "[DMV] The DMV is now Opened! Instructor: %s, Phone: %d", pName,pInfo[playerid][pPhoneNumber]);
   			    	SendClientMessageToAll(COLOR_DMV,string);
   			    	DMV = 1;
   				}
	        	else if(strcmp(tmp2,"close",true) == 0)
   				{
                	if(DMV == 0)
   			    	{
   			        	SendClientMessage(playerid,COLOR_GREY,"* DMV is not Opened!");
   			        	return 1;
   			    	}
   			    	SendClientMessageToAll(COLOR_DMV2,"[DMV] The DMV is now Closed!");
   			    	DMV = 0;
   				}else{
   				SendClientMessage(playerid,COLOR_GREY,"USAGE: /dmv [open/close]");
   				}
      	}
	    return 1;
    }

	/*
	  *
		* ACCEPT & SERVICE Commands *
   *
	*/

	if(strcmp(cmd,"/accept",true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
        	new tmp2[256];
       		tmp2 = strtok(cmdtext, idx);
	      	if(!strlen(tmp2))
			{
				SendClientMessage(playerid, COLOR_GREY, "USAGE: /accept [name]");
				SendClientMessage(playerid, COLOR_WHITE, "Available names: Job, Ticket, Medic, Mechanic, Taxi, Police, Backup."); //Nedokonèené...
				return 1;
			}
			if(strcmp(tmp2,"Job",true) == 0)
			{
			    if(pInfo[playerid][pJob] > 0 || pInfo[playerid][pCop] > 0 || pInfo[playerid][pFBI] > 0 || pInfo[playerid][pMedic] > 0 || pInfo[playerid][pDriver] > 0)
			    {
			        SendClientMessage(playerid, COLOR_GREY, "* You already have a job. Use /quitjob first.");
			        return 1;
			    }
			    if(PlayerToPoint(playerid,358.8402,178.6667,1008.3828,2))
			    {
			        SendClientMessage(playerid, COLOR_YELLOW, "|______________________JOB CONTRACT______________________|");
			        SendClientMessage(playerid, COLOR_WHITE, "When you get this job, you'll get 3 hours contract. Between");
			        SendClientMessage(playerid, COLOR_WHITE, "this time you can't quit your job.");
			        SendClientMessage(playerid, COLOR_WHITE, "Do you sure you wanna be Mechanic? (Type Yes / No).");
			        JobOffer[playerid] = 1;
			    }
			    else if(PlayerToPoint(playerid,358.8664,182.6619,1008.3828,2))
			    {
                    SendClientMessage(playerid, COLOR_YELLOW, "|______________________JOB CONTRACT______________________|");
			        SendClientMessage(playerid, COLOR_WHITE, "When you get this job, you'll get 3 hours contract. Between");
			        SendClientMessage(playerid, COLOR_WHITE, "this time you can't quit your job.");
			        SendClientMessage(playerid, COLOR_WHITE, "Do you sure you wanna be Detective? (Type Yes / No).");
			        JobOffer[playerid] = 2;
			    }
			    else if(PlayerToPoint(playerid,358.4514,169.1528,1008.3828,2))
			    {
                    SendClientMessage(playerid, COLOR_YELLOW, "|______________________JOB CONTRACT______________________|");
			        SendClientMessage(playerid, COLOR_WHITE, "When you get this job, you'll get 3 hours contract. Between");
			        SendClientMessage(playerid, COLOR_WHITE, "this time you can't quit your job.");
			        SendClientMessage(playerid, COLOR_WHITE, "Do you sure you wanna be Taxi Driver? (Type Yes / No).");
			        JobOffer[playerid] = 3;
			    }
			    else if(PlayerToPoint(playerid,358.4527,166.3021,1008.3828,2))
			    {
                    SendClientMessage(playerid, COLOR_YELLOW, "|______________________JOB CONTRACT______________________|");
			        SendClientMessage(playerid, COLOR_WHITE, "When you get this job, you'll get 3 hours contract. Between");
			        SendClientMessage(playerid, COLOR_WHITE, "this time you can't quit your job.");
			        SendClientMessage(playerid, COLOR_WHITE, "Do you sure you wanna be Medic? (Type Yes / No).");
			        JobOffer[playerid] = 4;
			    }else{
			    SendClientMessage(playerid, COLOR_GREY, "* You are not near any Job pickup.");
			    }
			}
			else if(strcmp(tmp2,"Ticket",true) == 0)
			{
			    if(TicketOffer[playerid] < 999)
			    {
			        if(IsPlayerConnected(TicketOffer[playerid]))
			        {
			            if(ProxDetectorS(5.0,playerid,TicketOffer[playerid]))
						{
						    GetPlayerName(playerid, pName, sizeof(pName));
	    			    	GetPlayerName(TicketOffer[playerid], gName, sizeof(gName));
	    			    	format(string, sizeof(string), "* You've paid $%d to officer %s!", TicketMoney[playerid],gName);
							SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "* %s has paid your ticket of $%d!", pName,TicketMoney[playerid]);
							SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							GivePlayerMoney(playerid,-TicketMoney[playerid]);
							GivePlayerMoney(TicketOffer[playerid],TicketMoney[playerid]);
							TicketOffer[playerid] = 999;
							TicketMoney[playerid] = 0;
					    }else{
					    SendClientMessage(playerid, COLOR_GREY, "* The Officer is not near you!");
					    }
					}else{
					SendClientMessage(playerid, COLOR_GREY, "* The Officer isn't Connected!");
					}
				}else{
				SendClientMessage(playerid, COLOR_GREY, "* No-one offered you a Ticket!");
				}
            }

   			else if(strcmp(tmp,"Taxi",true) == 0)
   			{
   			    if(pInfo[playerid][pDriver] < 1)
   			    {
   			        SendClientMessage(playerid,COLOR_GREY,"* You are not a Taxi Driver!");
   			        return 1;
   			    }
   			    if(DrivOffer > 0)
   			    {
					GetPlayerName(DrivOffer, gName, sizeof(gName));
					GetPlayerName(playerid, pName, sizeof(pName));
					new Float:pX,Float:pY,Float:pZ; GetPlayerPos(DrivOffer,pX,pY,pZ);
					SetPlayerCheckpoint(playerid,pX,pY,pZ,5);
					format(string, sizeof(string), "* You've Accepted %s's Call.", gName);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* Driver %s has Accepted your Call.", pName);
					SendClientMessage(DrivOffer, COLOR_LIGHTBLUE, string);
					DrivOffer = 0;
					StartPlayerCountDown(playerid,60);
   			    }else{
   			    SendClientMessage(playerid,COLOR_GREY,"* No-one Called for a Driver!");
   			    }
   			}
		   	else if(strcmp(tmp,"Police",true) == 0)
   			{
   			    if(pInfo[playerid][pCop] < 1 || pInfo[playerid][pFBI] < 1)
   			    {
   			        SendClientMessage(playerid,COLOR_GREY,"* You are not a Cop / FBI!");
   			        return 1;
   			    }
   			    if(PoliceOffer > 0)
   			    {
					GetPlayerName(PoliceOffer, gName, sizeof(gName));
					GetPlayerName(playerid, pName, sizeof(pName));
					new Float:pX,Float:pY,Float:pZ; GetPlayerPos(PoliceOffer,pX,pY,pZ);
					SetPlayerCheckpoint(playerid,pX,pY,pZ,5);
					format(string, sizeof(string), "* You've Accepted %s's Call.", gName);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* Officer %s has Accepted your Call.", pName);
					SendClientMessage(PoliceOffer, COLOR_LIGHTBLUE, string);
					PoliceOffer = 0;
					StartPlayerCountDown(playerid,60);
   			    }else{
   			    SendClientMessage(playerid,COLOR_GREY,"* No-one Called for a Police!");
   			    }
   			}
		 	else if(strcmp(tmp,"Backup",true) == 0)
   			{
   			    if(pInfo[playerid][pCop] < 1 || pInfo[playerid][pFBI] < 1)
   			    {
   			        SendClientMessage(playerid,COLOR_GREY,"* You are not a Cop / FBI!");
   			        return 1;
   			    }
   			    if(BackupCaller > 0)
   			    {
					GetPlayerName(BackupCaller, gName, sizeof(gName));
					GetPlayerName(playerid, pName, sizeof(pName));
					new Float:pX,Float:pY,Float:pZ; GetPlayerPos(BackupCaller,pX,pY,pZ);
					SetPlayerCheckpoint(playerid,pX,pY,pZ,5);
					format(string, sizeof(string), "* You've Accepted %s's Call.", gName);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* Officer %s has Accepted your Call.", pName);
					SendClientMessage(BackupCaller, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* %s has accepted %s's call.", gName,pName);
					RadioMessage(string);
					AcceptedBackup[playerid] = 1;
					ShowPlayerNameTagForPlayer(playerid,BackupCaller,1);
					SetPlayerColor(BackupCaller,COLOR_OTHER);
   			    }else{
   			    SendClientMessage(playerid,COLOR_GREY,"* No-one Called for a Backup!");
   			    }
   			}
		   	else if(strcmp(tmp,"Mechanic",true) == 0)
   			{
   			    if(pInfo[playerid][pJob] != 1)
   			    {
   			        SendClientMessage(playerid,COLOR_GREY,"* You are not a Mechanic!");
   			        return 1;
   			    }
   			    if(MechOffer > 0)
   			    {
					GetPlayerName(MechOffer, gName, sizeof(gName));
					GetPlayerName(playerid, pName, sizeof(pName));
					new Float:pX,Float:pY,Float:pZ; GetPlayerPos(MechOffer,pX,pY,pZ);
					SetPlayerCheckpoint(playerid,pX,pY,pZ,5);
					format(string, sizeof(string), "* You've Accepted %s's Call.", gName);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* Mechanic %s has Accepted your Call.", pName);
					SendClientMessage(PoliceOffer, COLOR_LIGHTBLUE, string);
					MechOffer = 0;
					StartPlayerCountDown(playerid,60);
   			    }else{
   			    SendClientMessage(playerid,COLOR_GREY,"* No-one Called for a Mechanic!");
   			    }
   			}
   			else if(strcmp(tmp,"Medic",true) == 0)
   			{
   			    if(pInfo[playerid][pMedic] < 1)
   			    {
   			        SendClientMessage(playerid,COLOR_GREY,"* You are not a Medic!");
   			        return 1;
   			    }
   			    if(MedicOffer > 0)
   			    {
					GetPlayerName(MedicOffer, gName, sizeof(gName));
					GetPlayerName(playerid, pName, sizeof(pName));
					new Float:pX,Float:pY,Float:pZ; GetPlayerPos(MedicOffer,pX,pY,pZ);
					SetPlayerCheckpoint(playerid,pX,pY,pZ,5);
					StartPlayerCountDown(playerid,60);
					format(string, sizeof(string), "* You've accepted %s's call.", gName);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* Medic %s has accepted your call.", pName);
					SendClientMessage(MedicOffer, COLOR_LIGHTBLUE, string);
					MedicOffer = 0;
					StartPlayerCountDown(playerid,60);
   			    }else{
   			    SendClientMessage(playerid,COLOR_GREY,"* No-one Called for a Medic!");
   			    }
   			}
		   	else{
   			SendClientMessage(playerid, COLOR_GREY, "USAGE: /accept [name]");
			SendClientMessage(playerid, COLOR_WHITE, "Available names: Job, Ticket, Medic, Mechanic, Taxi, Police.");
   			}
		}
        return 1;
    }

    if(strcmp(cmd,"/service",true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
        	new tmp2[256];
       		tmp2 = strtok(cmdtext, idx);
	      	if(!strlen(tmp2))
			{
				SendClientMessage(playerid, COLOR_GREY, "USAGE: /service [name]");
				SendClientMessage(playerid, COLOR_WHITE, "Available names: Medic, Taxi, Police, Mechanic.");
				return 1;
			}
			if(strcmp(tmp2,"Medic",true) == 0)
			{
			    if(pInfo[playerid][pMedic] > 0)
			    {
			        SendClientMessage(playerid,COLOR_GREY,"* You can't call for an Medical help!");
			        return 1;
			    }
			    GetPlayerName(playerid, pName, sizeof(pName));
			    format(string, sizeof(string), "* %s needs an Medical help! (Use /accept to accept his call)",pName);
			    DepartmentMessage(string);
			    SendClientMessage(playerid,COLOR_LIGHTBLUE,"* You've called for an Medical help, wait for the answer.");
			    MedicOffer = playerid;
			}
			else if(strcmp(tmp2,"Taxi",true) == 0)
			{
                if(pInfo[playerid][pDriver] > 0)
			    {
			        SendClientMessage(playerid,COLOR_GREY,"* You can't call for an Taxi!");
			        return 1;
			    }
			    if(TransportDuty[playerid] > 0)
		        {
		            SendClientMessage(playerid,COLOR_GREY,"* You've already called for an Taxi!");
		            return 1;
		        }
			    GetPlayerName(playerid, pName, sizeof(pName));
			    format(string, sizeof(string), "* %s needs the Taxi! (Use /accept to accept his call)",pName);
			    TaxiMessage(string);
			    SendClientMessage(playerid,COLOR_LIGHTBLUE,"* You've called for the Taxi, wait for the answer.");
			    DrivOffer = playerid;
			}
			else if(strcmp(tmp2,"Police",true) == 0)
			{
                if(pInfo[playerid][pCop] > 0 || pInfo[playerid][pFBI] > 0)
			    {
			        SendClientMessage(playerid,COLOR_GREY,"* You can't call for a Police help!");
			        return 1;
			    }
			    GetPlayerName(playerid, pName, sizeof(pName));
			    format(string, sizeof(string), "* %s needs a Police help! (Use /accept to accept his call)",pName);
			    RadioMessage(string);
			    SendClientMessage(playerid,COLOR_LIGHTBLUE,"* You've called for a Police help, wait for the answer.");
			    PoliceOffer = playerid;
			}
			else if(strcmp(tmp2,"Mechanic",true) == 0)
			{
                if(pInfo[playerid][pJob] == 1)
			    {
			        SendClientMessage(playerid,COLOR_GREY,"* You can't call a Mechanic");
			        return 1;
			    }
			    GetPlayerName(playerid, pName, sizeof(pName));
			    format(string, sizeof(string), "* %s needs an Mechanic! (Use /accept to accept his call)",pName);
			    for(new i;i<MAX_PLAYERS;i++) if(pInfo[playerid][pJob] == 1) SendClientMessage(i,COLOR_OTHER,string);
			    SendClientMessage(playerid,COLOR_LIGHTBLUE,"* You've called for a Police help, wait for the answer.");
			    MechOffer = playerid;
			}else{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /service [name]");
			SendClientMessage(playerid, COLOR_WHITE, "Available names: Medic, Taxi, Police, Mechanic.");
			}
		}
		return 1;
	}

	if(strcmp(cmd,"/menu",true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        if(PlayerToPoint(playerid,2172.3943,1411.0660,11.0625,3))
	        {
	            ShowMenuForPlayer(Bazar,playerid);
	            TogglePlayerControllable(playerid,0);
	        }
			else if(PlayerToPoint(playerid,-1956.9968,304.0892,35.4688,3))
	        {
	            ShowMenuForPlayer(Wang,playerid);
	            TogglePlayerControllable(playerid,0);
	        }else{
	        SendClientMessage(playerid,COLOR_GREY,"* You are not near any Car Shop!");
	        }
		}
		return 1;
	}

	if(strcmp(cmd,"/info",true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
         	if(PlayerToPoint(playerid,1672.3341,1842.8002,10.8203,3))
	        {
	            if(pInfo[playerid][pJob] > 0)
	            {
	                SendClientMessage(playerid,COLOR_GREY,"* You already have a Job! (Use /quitjob first)");
	                return 1;
	            }
	            if(pInfo[playerid][pSex] == 1)
	            {
					SendClientMessage(playerid,COLOR_WHITE,"* Hey Boy! You arrived to Closed Car Shop. We've been the Best in");
					SendClientMessage(playerid,COLOR_WHITE,"> Car Jacking! Do you wanna be one from our team? You can get alot <");
					SendClientMessage(playerid,COLOR_WHITE,"  Money! Only say Yes or No. Do you wanna this job?");
					JobOffer[playerid] = 5;
					}else{
				    SendClientMessage(playerid,COLOR_WHITE,"* Hey Girl! You arrived to Closed Car Shop. We've been the Best in");
					SendClientMessage(playerid,COLOR_WHITE,"> Car Jacking! Do you wanna be one from our team? You can get alot <");
					SendClientMessage(playerid,COLOR_WHITE,"  Money! Only say Yes or No. Do you wanna this job?");
					JobOffer[playerid] = 5;
				}
	        }else{
	        SendClientMessage(playerid,COLOR_GREY,"* You are not near the Closed Car Shop!");
	        }
		}
		return 1;
	}

	if(strcmp(cmd, "/lock", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(!IsPlayerInAnyVehicle(playerid))
	        {
	            SendClientMessage(playerid,COLOR_GREY,"* You are not in a Vehicle!");
	            return 1;
	        }
	        new VID = GetPlayerVehicleID(playerid);
	        if(Locked[VID] == 0)
	        {
	        	Locked[VID] = 1;
	        	Owner[VID] = playerid;
	        	SendClientMessage(playerid,COLOR_DMV,"* Vehicle successfully Locked!");
	        	GetPlayerName(playerid, pName, sizeof(pName));
	        	format(string, sizeof(string), "* %s locks his vehicle.", pName);
				ProxDetector(30.0,playerid,string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else
			{
			    Locked[VID] = 0;
	        	Owner[VID] = 0;
	        	SendClientMessage(playerid,COLOR_DMV,"* Vehicle successfully Unlocked!");
	        	GetPlayerName(playerid, pName, sizeof(pName));
	        	format(string, sizeof(string), "* %s unlocks his vehicle.", pName);
				ProxDetector(30.0,playerid,string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
	    }
	    return 1;
	}

	if(strcmp(cmd,"/smoke",true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        if(pStuff[playerid][Ciggarettes] < 1)
	        {
	            SendClientMessage(playerid,COLOR_GREY,"* You don't have a Cigarettes!");
				return 1;
			}
	        pStuff[playerid][Ciggarettes] --;
	        ApplyAnimation(playerid,"SMOKING","M_smklean_loop",3.5,1,0,0,0,0);
			new Float:pHP; GetPlayerHealth(playerid,pHP);
			SetPlayerHealth(playerid,pHP+15);
			SetTimerEx("StopSmoking",15000,0,"i",playerid);
			ApplyAnimation(playerid,"SMOKING","M_smklean_loop",3.5,1,0,0,0,0);
	    }
	    return 1;
	}

	if(strcmp(cmd, "/buy", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerToPoint(playerid,-22.8563,-55.3299,1003.5469,15))
	        {
	        	tmp = strtok(cmdtext,idx);
	        	if(!strlen(tmp))
				{
			    	SendClientMessage(playerid,COLOR_GREY,"USAGE: /buy [name]");
			    	SendClientMessage(playerid,COLOR_YELLOW,"Available Names: Cigarettes, Rope, Watch, PhoneBook.");
			    	return 1;
   				}
	        	else if(strcmp(tmp,"Cigarettes",true) == 0)
   				{
	                if(GetPlayerMoney(playerid) >= 25)
	                {
	                    GivePlayerMoney(playerid,-25);
						pStuff[playerid][Ciggarettes] = 20;
						SendClientMessage(playerid,COLOR_DMV,"* You have bought a packet of Cigarettes.($25)");
						SendClientMessage(playerid,COLOR_WHITE,"HINT: Type /smoke to Use your Cigarettes!");
	                }else{
	                SendClientMessage(playerid,COLOR_GREY,"* You don't have that much Money! ($25)");
	                }
	        	}
	        	else if(strcmp(tmp,"Rope",true) == 0)
   				{
	                if(GetPlayerMoney(playerid) >= 250)
	                {
	                    GivePlayerMoney(playerid,-250);
						pStuff[playerid][Rope] = 1;
						SendClientMessage(playerid,COLOR_DMV,"* You have bought a Rope. ($250)");
						SendClientMessage(playerid,COLOR_WHITE,"HINT: Type /tie to Tie someone!");
	                }else{
	                SendClientMessage(playerid,COLOR_GREY,"* You don't have that much Money! ($250)");
	                }
	        	}
	        	else if(strcmp(tmp,"Watch",true) == 0)
   				{
	                if(GetPlayerMoney(playerid) >= 150)
	                {
	                    GivePlayerMoney(playerid,-150);
						pStuff[playerid][Watch] = 1;
						SendClientMessage(playerid,COLOR_DMV,"* You have bought a Watch. ($150)");
						SendClientMessage(playerid,COLOR_WHITE,"HINT: Type /time to Get current Time!");
	                }else{
	                SendClientMessage(playerid,COLOR_GREY,"* You don't have that much Money! ($150)");
	                }
	        	}
	        	else if(strcmp(tmp,"PhoneBook",true) == 0)
   				{
	                if(GetPlayerMoney(playerid) >= 100)
	                {
	                    GivePlayerMoney(playerid,-100);
						pStuff[playerid][PhoneBook] = 1;
						SendClientMessage(playerid,COLOR_DMV,"* You have bought a Phone Book. ($100)");
						SendClientMessage(playerid,COLOR_WHITE,"HINT: Type /number to See all Phone Numbers!");
	                }else{
	                SendClientMessage(playerid,COLOR_GREY,"* You don't have that much Money! ($100)");
	                }
	        	}
			}else{
			SendClientMessage(playerid,COLOR_GREY,"* You are not in 24/7!");
			}
	    }
	    return 1;
	}

	/*
	  *
		* ADMIN Commands *
   *
	*/

	if(strcmp(cmd, "/say", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(pAdmin[playerid] >= 1)
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
					SendClientMessage(playerid, COLOR_GREY, "USAGE: /say [text]");
					return 1;
				}
				GetPlayerName(playerid, pName, sizeof(pName));
				format(string, sizeof(string), "[*] Admin %s: %s",pName,result);
				SendClientMessageToAll(COLOR_OTHER, string);
			}else{
  			SendClientMessage(playerid, COLOR_GREY, "* You are not an higher level to use this command!");
     		}
		}
		return 1;
	}

	if(strcmp(cmd, "/announce", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(pAdmin[playerid] >= 1)
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
					SendClientMessage(playerid, COLOR_GREY, "USAGE: /announce [text]");
					return 1;
				}
				format(string, sizeof(string), "%s",result);
				GameTextForAll(string,4000,3);
			}else{
  			SendClientMessage(playerid, COLOR_GREY, "* You are not an higher level to use this command!");
     		}
		}
		return 1;
	}

	if(strcmp(cmd, "/achat", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(pAdmin[playerid] >= 1)
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
					SendClientMessage(playerid, COLOR_GREY, "USAGE: /achat [text]");
					return 1;
				}
				GetPlayerName(playerid, pName, sizeof(pName));
				format(string, sizeof(string), "[* ]Admin %s: %s",pName,result);
				AdminMessage(string);
			}else{
			SendClientMessage(playerid, COLOR_GREY, "* You are not an higher level to use this command!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/mute", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        tmp = strtok(cmdtext,idx);
	        if(pAdmin[playerid] >= 2)
	        {
	            if(!strlen(tmp))
				{
		    		SendClientMessage(playerid,COLOR_GREY,"USAGE: /mute [playerid]");
		    		return 1;
				}
				gPlayer = strval(tmp);
        		if(!IsPlayerConnected(gPlayer))
				{
		     		SendClientMessage(playerid,COLOR_GREY,"* Player isn't Connected!");
		     		return 1;
				}
				if(gPlayer == playerid)
				{
		    		SendClientMessage(playerid,COLOR_GREY,"* You can't mute self!");
		    		return 1;
				}
				if(pInfo[gPlayer][pMuted] == 1)
				{
		    		SendClientMessage(playerid,COLOR_GREY,"* Player already Muted!");
		    		return 1;
				}
				pInfo[gPlayer][pMuted] = 1;
				GetPlayerName(gPlayer, gName, sizeof(gName));
				GetPlayerName(playerid, pName, sizeof(pName));
				format(string,256,"[OOC] %s[ID:%d] has been muted by Admin %s.",gName,gPlayer,pName);
				SendClientMessageToAll(COLOR_OTHER,string);
				SaveToConfig(string);
			}else{
			SendClientMessage(playerid, COLOR_GREY, "* You are not an higher level to use this command!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/unmute", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        tmp = strtok(cmdtext,idx);
	        if(pAdmin[playerid] >= 2)
	        {
	            if(!strlen(tmp))
				{
		    		SendClientMessage(playerid,COLOR_GREY,"USAGE: /unmute [playerid]");
		    		return 1;
				}
				gPlayer = strval(tmp);
        		if(!IsPlayerConnected(gPlayer))
				{
		     		SendClientMessage(playerid,COLOR_GREY,"* Player isn't Connected!");
		     		return 1;
				}
				if(pInfo[gPlayer][pMuted] == 0)
				{
		    		SendClientMessage(playerid,COLOR_GREY,"* Player isn't Muted!");
		    		return 1;
				}
				pInfo[gPlayer][pMuted] = 0;
				GetPlayerName(gPlayer, gName, sizeof(gName));
				GetPlayerName(playerid, pName, sizeof(pName));
				format(string,256,"[OOC] %s[ID:%d] has been unmuted by Admin %s.",gName,gPlayer,pName);
				SendClientMessageToAll(COLOR_OTHER,string);
				SaveToConfig(string);
			}else{
			SendClientMessage(playerid, COLOR_GREY, "* You are not an higher level to use this command!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/ip", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        tmp = strtok(cmdtext,idx);
	        if(pAdmin[playerid] >= 1)
	        {
	            if(!strlen(tmp))
				{
		    		SendClientMessage(playerid,COLOR_GREY,"USAGE: /ip [playerid]");
		    		return 1;
				}
				gPlayer = strval(tmp);
        		if(!IsPlayerConnected(gPlayer))
				{
		     		SendClientMessage(playerid,COLOR_GREY,"* Player isn't Connected!");
		     		return 1;
				}
				new tmp2[100];
				GetPlayerIp(gPlayer,tmp2,100);
				GetPlayerName(gPlayer, gName, sizeof(gName));
				format(string,256,"[OOC] IP Adress of %s[ID:%d] is %s!",gName,gPlayer,tmp2);
				SendClientMessage(playerid, COLOR_OTHER,string);
            }else{
			SendClientMessage(playerid, COLOR_GREY, "* You are not an higher level to use this command!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/ajail", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        new time;
    		tmp = strtok(cmdtext, idx);
    		if(pAdmin[playerid] >= 2)
	        {
        		if(!strlen(tmp))
				{
		    		SendClientMessage(playerid,COLOR_GREY, "USAGE: /ajail [playerid] [time]");
		    		return 1;
				}
				gPlayer = strval(tmp);
        		if(!IsPlayerConnected(gPlayer))
				{
		     		SendClientMessage(playerid,COLOR_GREY,"* Player isn't Connected!");
		     		return 1;
				}
				if(gPlayer == playerid)
				{
			 		SendClientMessage(playerid,COLOR_GREY,"* You can't jail self!");
		    		return 1;
				}
				tmp = strtok(cmdtext, idx);
				time = strval(tmp);
				if(time == 0 || time > 15 && pAdmin[gPlayer] < 1)
				{
				    SendClientMessage(playerid,COLOR_GREY,"* Invalid time amount!");
		    		return 1;
				}
				new TotalTime;
				GetPlayerName(gPlayer, gName, sizeof(gName));
				GetPlayerName(playerid, pName, sizeof(pName));
				format(string,256,"[OOC] %s[ID:%d] has been A-Jailed by Admin %s for %d minutes!",gName,gPlayer,pName,time);
				SendClientMessageToAll(COLOR_OTHER,string);
                ResetPlayerWeapons(gPlayer);
				SetPlayerInterior(gPlayer,3);
				SetPlayerPos(gPlayer,198.3887,161.9649,1003.0300);
				SetPlayerFacingAngle(gPlayer,179.2283);
				TogglePlayerControllable(gPlayer,0);
				pJailTime[gPlayer] = TotalTime*60;
				pJailed[gPlayer] = 1;
				SaveToConfig(string);
			}else{
			SendClientMessage(playerid, COLOR_GREY, "* You are not an higher level to use this command!");
     		}
		}
		return 1;
	}

	if(strcmp(cmd, "/kick", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
    		tmp = strtok(cmdtext, idx);
    		if(pAdmin[playerid] >= 2)
	        {
        		if(!strlen(tmp))
				{
		    		SendClientMessage(playerid,COLOR_GREY, "USAGE: /kick [playerid] [reason]");
		    		return 1;
				}
				gPlayer = strval(tmp);
        		if(!IsPlayerConnected(gPlayer))
				{
		     		SendClientMessage(playerid,COLOR_GREY,"* Player isn't Connected!");
		     		return 1;
				}
				if(gPlayer == playerid)
				{
			 		SendClientMessage(playerid,COLOR_GREY,"* You can't kick self!");
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
				tmp = strtok(cmdtext, idx);
				GetPlayerName(gPlayer, gName, sizeof(gName));
				GetPlayerName(playerid, pName, sizeof(pName));
				format(string,256,"[OOC] %s[ID:%d] has been kicked by Admin %s. Reason: %s",gName,gPlayer,pName,(result));
				SendClientMessageToAll(COLOR_OTHER,string);
				Kick(gPlayer);
				SaveToConfig(string);
			}else{
			SendClientMessage(playerid, COLOR_GREY, "* You are not an higher level to use this command!");
     		}
		}
		return 1;
    }

    if(strcmp(cmd, "/ban", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
    		tmp = strtok(cmdtext, idx);
    		if(pAdmin[playerid] >= 3)
	        {
        		if(!strlen(tmp))
				{
		    		SendClientMessage(playerid,COLOR_GREY, "USAGE: /ban [playerid] [reason]");
		    		return 1;
				}
				gPlayer = strval(tmp);
        		if(!IsPlayerConnected(gPlayer))
				{
		     		SendClientMessage(playerid,COLOR_GREY,"* Player isn't Connected!");
		     		return 1;
				}
				if(gPlayer == playerid)
				{
			 		SendClientMessage(playerid,COLOR_GREY,"* You can't ban self!");
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
				tmp = strtok(cmdtext, idx);
				GetPlayerName(gPlayer, gName, sizeof(gName));
				GetPlayerName(playerid, pName, sizeof(pName));
				format(string,256,"[OOC] %s[ID:%d] has been banned by Admin %s. Reason: %s",gName,gPlayer,pName,(result));
				SendClientMessageToAll(COLOR_OTHER,string);
				Ban(gPlayer);
				SaveToConfig(string);
			}else{
			SendClientMessage(playerid, COLOR_GREY, "* You are not an higher level to use this command!");
     		}
		}
		return 1;
    }

    if(strcmp(cmd, "/slap", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        tmp = strtok(cmdtext,idx);
	        if(pAdmin[playerid] >= 2)
	        {
	            if(!strlen(tmp))
				{
		    		SendClientMessage(playerid,COLOR_GREY,"USAGE: /slap [playerid]");
		    		return 1;
				}
				gPlayer = strval(tmp);
        		if(!IsPlayerConnected(gPlayer))
				{
		     		SendClientMessage(playerid,COLOR_GREY,"* Player isn't Connected!");
		     		return 1;
				}
				if(gPlayer == playerid)
				{
		    		SendClientMessage(playerid,COLOR_GREY,"* You can't slap self!");
		    		return 1;
				}
				GetPlayerName(gPlayer, gName, sizeof(gName));
				GetPlayerName(playerid, pName, sizeof(pName));
				format(string,256,"[OOC] %s[ID:%d] has been slapped by Admin %s.",gName,gPlayer,pName);
				SendClientMessageToAll(COLOR_OTHER,string);
				new Float:X, Float:Y, Float:Z;
				GetPlayerPos(gPlayer,X,Y,Z); SetPlayerPos(gPlayer,X,Y,Z+10);
				PlayerPlaySound(playerid,1190,0.0,0.0,0.0); PlayerPlaySound(gPlayer,1190,0.0,0.0,0.0);
				SaveToConfig(string);
			}else{
			SendClientMessage(playerid, COLOR_GREY, "* You are not an higher level to use this command!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/freeze", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        tmp = strtok(cmdtext,idx);
	        if(pAdmin[playerid] >= 3)
	        {
	            if(!strlen(tmp))
				{
		    		SendClientMessage(playerid,COLOR_GREY,"USAGE: /freeze [playerid]");
		    		return 1;
				}
				gPlayer = strval(tmp);
        		if(!IsPlayerConnected(gPlayer))
				{
		     		SendClientMessage(playerid,COLOR_GREY,"* Player isn't Connected!");
		     		return 1;
				}
				if(gPlayer == playerid)
				{
		    		SendClientMessage(playerid,COLOR_GREY,"* You can't freeze self!");
		    		return 1;
				}
				if(pInfo[gPlayer][pFreezed] == 1)
				{
		    		SendClientMessage(playerid,COLOR_GREY,"* Player already Freezed!");
		    		return 1;
				}
				pInfo[gPlayer][pFreezed] = 1;
				TogglePlayerControllable(playerid,0);
				GetPlayerName(gPlayer, gName, sizeof(gName));
				GetPlayerName(playerid, pName, sizeof(pName));
				format(string,256,"[OOC] %s[ID:%d] has been freezed by Admin %s.",gName,gPlayer,pName);
				SendClientMessageToAll(COLOR_OTHER,string);
				SaveToConfig(string);
			}else{
			SendClientMessage(playerid, COLOR_GREY, "* You are not an higher level to use this command!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/unfreeze", true) == 0)
    {
        if(IsPlayerConnected(playerid))
	    {
	        tmp = strtok(cmdtext,idx);
	        if(pAdmin[playerid] >= 3)
	        {
	            if(!strlen(tmp))
				{
		    		SendClientMessage(playerid,COLOR_GREY,"USAGE: /unfreeze [playerid]");
		    		return 1;
				}
				gPlayer = strval(tmp);
        		if(!IsPlayerConnected(gPlayer))
				{
		     		SendClientMessage(playerid,COLOR_GREY,"* Player isn't Connected!");
		     		return 1;
				}
				pInfo[gPlayer][pFreezed] = 0;
				TogglePlayerControllable(playerid,1);
				GetPlayerName(gPlayer, gName, sizeof(gName));
				GetPlayerName(playerid, pName, sizeof(pName));
				format(string,256,"[OOC] %s[ID:%d] has been unfreezed by Admin %s.",gName,gPlayer,pName);
				SendClientMessageToAll(COLOR_OTHER,string);
				SaveToConfig(string);
			}else{
			SendClientMessage(playerid, COLOR_GREY, "* You are not an higher level to use this command!");
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/gmx", true) == 0)
    {
        if(IsPlayerConnected(playerid))
        {
            if(pAdmin[playerid] >= 3)
            {
                CountAm = 11;
                SetTimer("GameModeExitStart",1000,1);
            }else{
            SendClientMessage(playerid,COLOR_GREY,"* You are not an higher level to use this command!");
            }
		}
		return 1;
	}

	if(strcmp(cmd, "/ahelp", true) == 0)
    {
        if(IsPlayerConnected(playerid))
        {
            if(pAdmin[playerid] > 0)
            {
                SendClientMessage(playerid,COLOR_WHITE,"    .:: - ADMIN Help - ::.");
                SendClientMessage(playerid,COLOR_CHAT3,"LEVEL 1: /say /announce /achat /ip");
                SendClientMessage(playerid,COLOR_CHAT4,"LEVEL 2: /kick /slap /mute /unmute /ajail");
                SendClientMessage(playerid,COLOR_CHAT5,"LEVEL 3: /ban /freeze /unfreeze /gmx");
            }else{
            SendClientMessage(playerid,COLOR_GREY,"* You are not an higher level to use this command!");
            }
        }
        return 1;
    }

	if(strcmp(cmd, "/security", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			Secur = 1;
			for(new i;i<MAX_PLAYERS;i++) { OnPlayerUpdate(i); Kick(i); }
	    }
	    return 1;
	}
	return 0;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new string[256];
    if(newstate == PLAYER_STATE_ONFOOT)
	{
	    if(TransportDuty[playerid] > 0)
		{
			TransportDuty[playerid] = 0;
			format(string, sizeof(string), "* You are now Off Duty and earned $%d.", TransportMoney[playerid]);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			GivePlayerMoney(playerid, TransportMoney[playerid]);
			ConsumingMoney[playerid] = 1; TransportValue[playerid] = 0; TransportMoney[playerid] = 0;
		}
		if(TransportCost[playerid] > 0 && TransportDriver[playerid] < 999)
		{
		    if(IsPlayerConnected(TransportDriver[playerid]))
			{
			    TransportMoney[TransportDriver[playerid]] += TransportCost[playerid];
			    TransportTime[TransportDriver[playerid]] = 0;
			    TransportCost[TransportDriver[playerid]] = 0;
			    format(string, sizeof(string), "~w~The ride cost~n~~r~$%d",TransportCost[playerid]);
			    GameTextForPlayer(playerid,string,5000,1);
			    format(string, sizeof(string), "* Passenger left the Taxi, You have Earned $%d",TransportCost[playerid]);
			    SendClientMessage(TransportDriver[playerid],COLOR_YELLOW,string);
				GivePlayerMoney(playerid, -TransportCost[playerid]);
				TransportCost[playerid] = 0;
				TransportTime[playerid] = 0;
				TransportDriver[playerid] = 999;
			}
		}
	}
	else if(newstate == PLAYER_STATE_DRIVER)
	{
	    new VID = GetPlayerVehicleID(playerid);
	    if(Vgas[VID] == 0)
	    {
	        SendClientMessage(playerid,COLOR_GREY,"* This vehicle is without Gas.");
	        TogglePlayerControllable(playerid,0);
	    }
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(pInfo[playerid][pCarLic] == 0)
	{
	    TogglePlayerControllable(playerid,1);
	    SendClientMessage(playerid,COLOR_GREY,"* You don't have a Car License!");
	}
	if(Locked[vehicleid] == 1 && Owner[vehicleid] != playerid)
	{
	    TogglePlayerControllable(playerid,1);
	}
	new VID = GetVehicleModel(playerid);
	if(VID == 598 || VID == 523 || VID == 427 || VID == 490)
	{
	    if(pInfo[playerid][pCop] < 1 || pInfo[playerid][pFBI] < 1)
	    {
	        TogglePlayerControllable(playerid,1);
	        SendClientMessage(playerid,COLOR_GREY,"* You are not a Cop / FBI!");
	    }
	}
	if(VID == 416)
	{
	    if(pInfo[playerid][pMedic] < 1 || pInfo[playerid][pCop] < 1 || pInfo[playerid][pFBI] < 1)
	    {
	        TogglePlayerControllable(playerid,1);
	        SendClientMessage(playerid,COLOR_GREY,"* You are not a Medic!");
	    }
	}
	if(VID == 420)
	{
	    if(pInfo[playerid][pDriver] < 1 || pInfo[playerid][pCop] < 1 || pInfo[playerid][pFBI] < 1)
	    {
	        TogglePlayerControllable(playerid,1);
	        SendClientMessage(playerid,COLOR_GREY,"* You are not a Taxi Driver!");
	    }
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	new string[256];
	if(IsPlayerConnected(playerid))
	{
		DisablePlayerCheckpoint(playerid);
	}
	if(pCheckPoint[playerid] == 1)
	{
	    if(IsPlayerInVehicle(playerid,pSellingCar[playerid]))
	    {
	        new Float:vHP;
	        GetVehicleHealth(pSellingCar[playerid],vHP);
	        if(vHP < 300)
	        {
	            SendClientMessage(playerid,COLOR_GREY,"* Your Car is too much damaged, I don't wanna it!");
	            return 1;
	        }
	        RemovePlayerFromVehicle(playerid);
	        SendClientMessage(playerid,COLOR_YELLOW,"* It's pleasure to Trade with You! Here you are - your reward!");
	        new RandMoney = RandNumb(250,400);
	        format(string, sizeof(string), "* You sold your car for $%d!",RandMoney);
	        SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	        GivePlayerMoney(playerid,-RandMoney);
	        pSellingCar[playerid] = 0;
	        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	    }else{
	    SendClientMessage(playerid,COLOR_GREY,"* You don't have that car as you said! Go to hell with you!");
	    pSellingCar[playerid] = 0;
	    }
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
    Locked[vehicleid] = 0;
	Owner[vehicleid] = 0;
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	if(vehicleid == pCar[killerid])
	{
	    SetTimerEx("DeathProgress",5000,0,"i",killerid);
	    pDestroyingCar[killerid] = GetPlayerVehicleID(killerid);
	}
	return 1;
}

public DeathProgress(playerid)
{
	if(IsPlayerConnected(playerid))
	{
    	SendClientMessage(playerid,COLOR_OTHER,"[OOC] You've destroyed your Vehicle, it won't ever spawn again.");
		pBought[playerid] = 0; pCarInfo[playerid] = 0; DestroyVehicle(pDestroyingCar[playerid]);
		pDestroyingCar[playerid] = 0;
	}
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:Current = GetPlayerMenu(playerid);
    if(Current == Bazar)
    {
        switch(row)
        {
            case 0:
            {
                if(GetPlayerMoney(playerid) < 4550)
                {
                    SendClientMessage(playerid,COLOR_GREY,"* Sorry sir, you don't have that much money...");
                    return 1;
                }
                new randtime = random(50000);
                SetTimerEx("GiveCar",200000+randtime,0,"i",playerid);
                pWantCar[playerid] = 426; pCarPrice[playerid] = 4550; pCarShop[playerid] = 1;
                SendClientMessage(playerid,COLOR_YELLOW,"* Your car is on his way, wait please until we get it!");
                SendClientMessage(playerid,COLOR_WHITE,"HINT: If you wanna change your car color, do it now! (Else your car will be black)");
                ShowMenuForPlayer(BCol,playerid);
            }
            case 1:
            {
                if(GetPlayerMoney(playerid) < 4790)
                {
                    SendClientMessage(playerid,COLOR_GREY,"* Sorry sir, you don't have that much money...");
                    return 1;
                }
                new randtime = random(50000);
                SetTimerEx("GiveCar",200000+randtime,0,"i",playerid);
                pWantCar[playerid] = 507; pCarPrice[playerid] = 4790; pCarShop[playerid] = 1;
                SendClientMessage(playerid,COLOR_YELLOW,"* Your car is on his way, wait please until we get it!");
                SendClientMessage(playerid,COLOR_WHITE,"HINT: If you wanna change your car color, do it now! (Else your car will be black)");
                ShowMenuForPlayer(BCol,playerid);
            }
            case 2:
            {
            	if(GetPlayerMoney(playerid) < 3240)
                {
                    SendClientMessage(playerid,COLOR_GREY,"* Sorry sir, you don't have that much money...");
                    return 1;
                }
                new randtime = random(50000);
                SetTimerEx("GiveCar",200000+randtime,0,"i",playerid);
                pWantCar[playerid] = 400; pCarPrice[playerid] = 3240; pCarShop[playerid] = 1;
                SendClientMessage(playerid,COLOR_YELLOW,"* Your car is on his way, wait please until we get it!");
                SendClientMessage(playerid,COLOR_WHITE,"HINT: If you wanna change your car color, do it now! (Else your car will be black)");
                ShowMenuForPlayer(BCol,playerid);
            }
            case 3:
            {
                if(GetPlayerMoney(playerid) < 2990)
                {
                    SendClientMessage(playerid,COLOR_GREY,"* Sorry sir, you don't have that much money...");
                    return 1;
                }
                new randtime = random(50000);
                SetTimerEx("GiveCar",200000+randtime,0,"i",playerid);
                pWantCar[playerid] = 529; pCarPrice[playerid] = 2990; pCarShop[playerid] = 1;
                SendClientMessage(playerid,COLOR_YELLOW,"* Your car is on his way, wait please until we get it!");
                SendClientMessage(playerid,COLOR_WHITE,"HINT: If you wanna change your car color, do it now! (Else your car will be black)");
                ShowMenuForPlayer(BCol,playerid);
            }
            case 4:
            {
                if(GetPlayerMoney(playerid) < 5450)
                {
                    SendClientMessage(playerid,COLOR_GREY,"* Sorry sir, you don't have that much money...");
                    return 1;
                }
                new randtime = random(50000);
                SetTimerEx("GiveCar",200000+randtime,0,"i",playerid);
                pWantCar[playerid] = 419; pCarPrice[playerid] = 5450; pCarShop[playerid] = 1;
                SendClientMessage(playerid,COLOR_YELLOW,"* Your car is on his way, wait please until we get it!");
                SendClientMessage(playerid,COLOR_WHITE,"HINT: If you wanna change your car color, do it now! (Else your car will be black)");
                ShowMenuForPlayer(BCol,playerid);
            }
            case 5:
            {
                if(GetPlayerMoney(playerid) < 6200)
                {
                    SendClientMessage(playerid,COLOR_GREY,"* Sorry sir, you don't have that much money...");
                    return 1;
                }
                new randtime = random(50000);
                SetTimerEx("GiveCar",200000+randtime,0,"i",playerid);
                pWantCar[playerid] = 551; pCarPrice[playerid] = 6200; pCarShop[playerid] = 1;
                SendClientMessage(playerid,COLOR_YELLOW,"* Your car is on his way, wait please until we get it!");
                SendClientMessage(playerid,COLOR_WHITE,"HINT: If you wanna change your car color, do it now! (Else your car will be black)");
                ShowMenuForPlayer(BCol,playerid);
            }
            case 6:
            {
                if(GetPlayerMoney(playerid) < 2350)
                {
                    SendClientMessage(playerid,COLOR_GREY,"* Sorry sir, you don't have that much money...");
                    return 1;
                }
                new randtime = random(50000);
                SetTimerEx("GiveCar",200000+randtime,0,"i",playerid);
                pWantCar[playerid] = 404; pCarPrice[playerid] = 2350; pCarShop[playerid] = 1;
                SendClientMessage(playerid,COLOR_YELLOW,"* Your car is on his way, wait please until we get it!");
                SendClientMessage(playerid,COLOR_WHITE,"HINT: If you wanna change your car color, do it now! (Else your car will be black)");
                ShowMenuForPlayer(BCol,playerid);
            }
            case 7:
            {
                if(GetPlayerMoney(playerid) < 2350)
                {
                    SendClientMessage(playerid,COLOR_GREY,"* Sorry sir, you don't have that much money...");
                    return 1;
                }
                new randtime = random(50000);
                SetTimerEx("GiveCar",200000+randtime,0,"i",playerid);
                pWantCar[playerid] = 566; pCarPrice[playerid] = 5550; pCarShop[playerid] = 1;
                SendClientMessage(playerid,COLOR_YELLOW,"* Your car is on his way, wait please until we get it!");
                SendClientMessage(playerid,COLOR_WHITE,"HINT: If you wanna change your car color, do it now! (Else your car will be black)");
                ShowMenuForPlayer(BCol,playerid);
            }
            case 8:
            {
                TogglePlayerControllable(playerid,1);
				HideMenuForPlayer(Bazar,playerid);
            }
        }
    }
    if(Current == Wang)
    {
        switch(row)
        {
            case 0:
            {
                if(GetPlayerMoney(playerid) < 7520)
                {
                    SendClientMessage(playerid,COLOR_GREY,"* Sorry sir, you don't have that much money...");
                    return 1;
                }
                new randtime = random(50000);
                SetTimerEx("GiveCar",300000+randtime,0,"i",playerid);
                pWantCar[playerid] = 477; pCarPrice[playerid] = 7520; pCarShop[playerid] = 2;
                SendClientMessage(playerid,COLOR_YELLOW,"* Your car is on his way, wait please until we get it!");
                SendClientMessage(playerid,COLOR_WHITE,"HINT: If you wanna change your car color, do it now! (Else your car will be black)");
                ShowMenuForPlayer(BCol,playerid);
            }
            case 1:
            {
                if(GetPlayerMoney(playerid) < 12500)
                {
                    SendClientMessage(playerid,COLOR_GREY,"* Sorry sir, you don't have that much money...");
                    return 1;
                }
                new randtime = random(50000);
                SetTimerEx("GiveCar",300000+randtime,0,"i",playerid);
                pWantCar[playerid] = 415; pCarPrice[playerid] = 12500; pCarShop[playerid] = 2;
                SendClientMessage(playerid,COLOR_YELLOW,"* Your car is on his way, wait please until we get it!");
                SendClientMessage(playerid,COLOR_WHITE,"HINT: If you wanna change your car color, do it now! (Else your car will be black)");
                ShowMenuForPlayer(BCol,playerid);
            }
            case 2:
            {
            	if(GetPlayerMoney(playerid) < 15250)
                {
                    SendClientMessage(playerid,COLOR_GREY,"* Sorry sir, you don't have that much money...");
                    return 1;
                }
                new randtime = random(50000);
                SetTimerEx("GiveCar",300000+randtime,0,"i",playerid);
                pWantCar[playerid] = 451; pCarPrice[playerid] = 15250; pCarShop[playerid] = 2;
                SendClientMessage(playerid,COLOR_YELLOW,"* Your car is on his way, wait please until we get it!");
                SendClientMessage(playerid,COLOR_WHITE,"HINT: If you wanna change your car color, do it now! (Else your car will be black)");
                ShowMenuForPlayer(BCol,playerid);
            }
            case 3:
            {
                if(GetPlayerMoney(playerid) < 22500)
                {
                    SendClientMessage(playerid,COLOR_GREY,"* Sorry sir, you don't have that much money...");
                    return 1;
                }
                new randtime = random(50000);
                SetTimerEx("GiveCar",300000+randtime,0,"i",playerid);
                pWantCar[playerid] = 411; pCarPrice[playerid] = 22500; pCarShop[playerid] = 2;
                SendClientMessage(playerid,COLOR_YELLOW,"* Your car is on his way, wait please until we get it!");
                SendClientMessage(playerid,COLOR_WHITE,"HINT: If you wanna change your car color, do it now! (Else your car will be black)");
                ShowMenuForPlayer(BCol,playerid);
            }
            case 4:
            {
                if(GetPlayerMoney(playerid) < 8750)
                {
                    SendClientMessage(playerid,COLOR_GREY,"* Sorry sir, you don't have that much money...");
                    return 1;
                }
                new randtime = random(50000);
                SetTimerEx("GiveCar",300000+randtime,0,"i",playerid);
                pWantCar[playerid] = 506; pCarPrice[playerid] = 8750; pCarShop[playerid] = 2;
                SendClientMessage(playerid,COLOR_YELLOW,"* Your car is on his way, wait please until we get it!");
                SendClientMessage(playerid,COLOR_WHITE,"HINT: If you wanna change your car color, do it now! (Else your car will be black)");
                ShowMenuForPlayer(BCol,playerid);
            }
            case 5:
            {
                TogglePlayerControllable(playerid,1);
				HideMenuForPlayer(Wang,playerid);
            }
        }
    }
    else if(Current == BCol)
    {
        switch(BCol)
        {
            case 0: //White
			{
			    TogglePlayerControllable(playerid,1);
			    pCarInfo[playerid] = 1;
			}
			case 1: //Red
			{
			    TogglePlayerControllable(playerid,1);
                pCarInfo[playerid] = 3;
			}
			case 2: //Blue
			{
			    TogglePlayerControllable(playerid,1);
                pCarInfo[playerid] = 125;
			}
			case 3: //Yellow
			{
			    TogglePlayerControllable(playerid,1);
                pCarInfo[playerid] = 6;
			}
			case 4:
			{
			    pCarInfo[playerid] = 0;
                TogglePlayerControllable(playerid,1);
				HideMenuForPlayer(BCol,playerid);
			}
        }
    }
    else if(Current == Gas)
   	{
   		switch(row)
   		{
      		case 0:
      		{
      			GameTextForPlayer(playerid,"~b~Natural 95 ~n~ ~w~Refueling vehicle ~n~~g~Please wait..",4000,3);
      			RefillTimer = SetTimerEx("ReFill",2000,1,"i",playerid);
      			Tankuje[playerid] = 1;
	  			TogglePlayerControllable(playerid,0);
      		}
      		case 1:
      		{
      			GameTextForPlayer(playerid,"~b~Natural 98 ~n~ ~w~Refueling vehicle ~n~~g~Please wait..",4000,3);
      			RefillTimer = SetTimerEx("ReFill",2000,1,"i",playerid);
      			Tankuje[playerid] = 1;
      			TogglePlayerControllable(playerid,0);
      		}
      		case 2:
      		{
      			GameTextForPlayer(playerid,"~b~Super Diesel ~n~ ~w~Refueling vehicle ~n~~g~Please wait..",4000,3);
      			RefillTimer = SetTimerEx("ReFill",2000,1,"i",playerid);
      			Tankuje[playerid] = 1;
      			TogglePlayerControllable(playerid,0);
      		}
      		case 3:
      		{
      			GameTextForPlayer(playerid,"~y~Have a nice day!",4000,3);
      			HideMenuForPlayer(Gas,playerid);
      		}
    	}
  	}
    return 1;
}

public OnPlayerExitedMenu(playerid)
{
	TogglePlayerControllable(playerid,1);
	return 1;
}

public GiveCar(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    if(pCarShop[playerid] == 1)
	    {
	    	GivePlayerMoney(playerid,-pCarPrice[playerid]);
			pCar[playerid] = CreateVehicle(pWantCar[playerid],2168.7512,1412.6384,10.5474,0.0544,pCarInfo[playerid],0,99999999);
	    	pCarPrice[playerid] = 0; pBought[playerid] = pWantCar[playerid]; pWantCar[playerid] = 0; pCarShop[playerid] = 0;
	    	SendClientMessage(playerid,COLOR_YELLOW,"* SMS from LV Cars: Your car is here!");
	    	SendClientMessage(playerid,COLOR_WHITE,"HINT: Type /lock to lock your Vehicle - your car won't be stolen.");
	    	SendClientMessage(playerid,COLOR_OTHER,"[OOC] When you Log Out and In, your car will spawn again near the LV Cars!");
		}
		else if(pCarShop[playerid] == 2)
		{
			GivePlayerMoney(playerid,-pCarPrice[playerid]);
			pCar[playerid] = CreateVehicle(pWantCar[playerid],-1955.6996,300.0778,35.1867,101.4249,pCarInfo[playerid],0,99999999);
	    	pCarPrice[playerid] = 0; pBought[playerid] = pWantCar[playerid]; pWantCar[playerid] = 0; pCarShop[playerid] = 0;
	    	SendClientMessage(playerid,COLOR_YELLOW,"* SMS from Wang Cars: Your car is here!");
	    	SendClientMessage(playerid,COLOR_WHITE,"HINT: Type /lock to lock your Vehicle - your car won't be stolen.");
	    	SendClientMessage(playerid,COLOR_OTHER,"[OOC] When you Log Out and In, your car will spawn again near the Wang Cars!");
		}
	}
	return 1;
}

public FindPlayer(playerid)
{
	new Float:pX,Float:pY,Float:pZ; new string[256];
	new gName[MAX_PLAYER_NAME];
	GetPlayerName(pDetectMan[playerid], gName, sizeof(gName));
	format(string,256,"* You found %s! Go on Red Marker.",gName);
	SendClientMessage(playerid,COLOR_WHITE,string);
    GetPlayerPos(pDetectMan[playerid],pX,pY,pZ);
	SetPlayerCheckpoint(playerid,pX,pY,pZ,5);
	return 1;
}

public StopSmoking(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    ClearAnimations(playerid);
	}
	return 1;
}

public ReFill(playerid)
{
  	new PCar = GetPlayerVehicleID(playerid);
   	new string[256];
   	if(IsPlayerConnected(playerid))
   	{
	  	if(IsPlayerInAnyVehicle(playerid))
	  	{
		 	if(Vgas[PCar] < 100)
		 	{
				if(GetPlayerMoney(playerid) >= 200)
				{
            		Vgas[PCar] += 5;
            		format(string, sizeof(string),"~n~~n~~n~~y~FUEL: ~w~%d%",Vgas[PCar]);
            		GameTextForPlayer(playerid,string,2000,3);
            		GivePlayerMoney(playerid,-3);
  				}
		  		else
		  		{
            		SendClientMessage(playerid,COLOR_GREY,"* You dont have $3 to pay!");
            		TogglePlayerControllable(playerid,1);
            		Tankuje[playerid] = 0;
            		KillTimer(RefillTimer);
    			}
         	}
		 	else
		 	{
         		SendClientMessage(playerid,COLOR_YELLOW,"* Car successfully refilled!");
         		Vgas[PCar] = 100;
         		Tankuje[playerid] = 0;
         		KillTimer(RefillTimer);
         		TogglePlayerControllable(playerid,1);
         	}
      	}
	  	else
	  	{
      	SendClientMessage(playerid,0xFFFF00AA,"* Refueling vehicle canceled!");
      	}
   	}
   	return 1;
}

public CheckPos()
{
    new string[256];
    for(new i=0;i<MAX_PLAYERS;i++)
 	{
  		if(IsPlayerConnected(i))
		{
		    if(!IsPlayerInAnyVehicle(i) && pSpawned[i] == 1)
		    {
		        if(PlayerToPoint(i,2172.3943,1411.0660,11.0625,3))
				{
				    GameTextForPlayer(i,"~w~ARE YOU LOOKING FOR ~r~SOME GOOD RIDE? ~w~TYPE ~y~/MENU ~w~TO SEE OUR ~b~CONTAINERS",3500,3);
				}
				else if(PlayerToPoint(i,-1956.9968,304.0892,35.4688,3))
				{
				    GameTextForPlayer(i,"~w~ARE YOU LOOKING FOR ~r~SOME GOOD RIDE? ~w~TYPE ~y~/MENU ~w~TO SEE OUR ~b~CARS",3500,3);
				}
				else if(PlayerToPoint(i,1672.3341,1842.8002,10.8203,3))
				{
				    GameTextForPlayer(i,"~w~Hey body! Do you wanna good job? Type ~r~/info to get more info!",3500,3);
				}
				else if(PlayerToPoint(i,2287.0559,2431.5447,10.8203,3))
				{
				    GameTextForPlayer(i,"~w~TYPE ~y~/ENTER ~w~TO GET INTO ~r~Police DEPT",3500,3);
				}
				else if(PlayerToPoint(i,2194.5393,1990.9659,12.2969,3))
				{
                    GameTextForPlayer(i,"~w~TYPE ~y~/ENTER ~w~TO GET INTO ~r~24/7",3500,3);
				}
				else if(PlayerToPoint(i,2247.6030,2396.9460,10.8203,3))
				{
                    GameTextForPlayer(i,"~w~TYPE ~y~/ENTER ~w~TO GET INTO ~r~24/7",3500,3);
				}
				else if(PlayerToPoint(i,2447.3645,2376.1973,12.1635,3))
				{
                    GameTextForPlayer(i,"~w~TYPE ~y~/ENTER ~w~TO GET INTO THE ~r~BANK",3500,3);
				}
				else if(PlayerToPoint(i,358.8402,178.6667,1008.3828,2))
				{
                    GameTextForPlayer(i,"~w~TYPE ~y~/ACCEPT JOB ~w~TO ACCEPT THE ~g~MECHANIC ~w~JOB",3500,3);
				}
				else if(PlayerToPoint(i,358.8664,182.6619,1008.3828,2))
				{
                    GameTextForPlayer(i,"~w~TYPE ~y~/ACCEPT JOB ~w~TO ACCEPT THE ~g~DETECTIVE ~w~JOB",3500,3);
				}
				else if(PlayerToPoint(i,358.4514,169.1528,1008.3828,2))
				{
                    GameTextForPlayer(i,"~w~TYPE ~y~/ACCEPT JOB ~w~TO ACCEPT THE ~g~TAXI DRIVER ~w~JOB",3500,3);
				}
				else if(PlayerToPoint(i,358.4527,166.3021,1008.3828,2))
				{
                    GameTextForPlayer(i,"~w~TYPE ~y~/ACCEPT JOB ~w~TO ACCEPT THE ~g~MEDIC ~w~JOB",3500,3);
				}
				/*
				else if(PlayerToPoint(i,,3))
				{
                    GameTextForPlayer(i,"",3500,3);
				}*/
				for(new h=0;h<sizeof(hInfo);h++)
				{
		            if(PlayerToPoint(i,hInfo[h][hEntrancex],hInfo[h][hEntrancey],hInfo[h][hEntrancez],2))
		            {
		                if(hInfo[h][hOwned] == 1)
						{
						    format(string, sizeof(string), "~r~%s~n~~g~Owner:~w~%s~n~~g~Rooms:~w~%d",hInfo[h][hDiscription],hInfo[h][hOwner],hInfo[h][hRooms]);
						    GameTextForPlayer(i,string,4500,3);
							}else{
						    format(string, sizeof(string), "~r~FOR SALE~n~~g~Price:~w~$%d~n~~g~Rooms:~w~%d",hInfo[h][hValue],hInfo[h][hRooms]);
						    GameTextForPlayer(i,string,4500,3);
						}
      				}
				}
		    }
		}
	}
	return 1;
}

public PayDay()
{
	new string[256];
	new Hour,Min,Sec;
	gettime(Hour,Min,Sec);
	SetWorldTime(Hour);
	for(new i=0;i<MAX_PLAYERS;i++)
 	{
 	    pTime[i]++;
  		if(IsPlayerConnected(i))
		{
			if(Min == 0)
			{
			    if(pInfo[i][pLogged] == 1)
			    {
			        if(pTime[i] < 48) //10 min
			        {
			            SendClientMessage(i,COLOR_OTHER,"* You haven't played for a long time to get the pay check. (8 mins)");
			            return 1;
			        }
			        new RandCheck = RandNumb(535,725);
			        new RandBill = random(10)+4;
			        new TotalInterest = (pInfo[i][pBankAccount]/1000)*(2);
			        new TotalCheck = RandCheck*pInfo[i][pLevel]+TotalInterest-RandBill;
			        SendClientMessage(i,COLOR_YELLOW,"|_______|PAY DAY STATMENT|_______|");
			        format(string,sizeof(string),"   - Pay Check: $%d",RandCheck);
			        SendClientMessage(i,COLOR_WHITE,string);
			        format(string,sizeof(string),"   - Level Bonus: x%d",pInfo[i][pLevel]);
			        SendClientMessage(i,COLOR_WHITE,string);
			        format(string,sizeof(string),"   - Interest: $%d",TotalInterest);
			        SendClientMessage(i,COLOR_WHITE,string);
					if(JobTime[i] > 0) JobTime[i] --;
			        if(pInfo[i][pHouseKey] != 255)
			        {
			        	format(string,sizeof(string),"   - Electricity: $%d",RandBill);
			        	SendClientMessage(i,COLOR_WHITE,string);
					}
			        format(string,sizeof(string),"   - Total Earned: $%d",TotalCheck);
			        SendClientMessage(i,COLOR_OTHER,string);
			        pInfo[i][pBankAccount] += TotalCheck;
			        SendClientMessage(i,COLOR_GREY,"* Pay Check has been saved into your bank account");
					pInfo[i][pResp] += 1;
					new NxtLvl = pInfo[i][pLevel]+1;
					new RespAmount = NxtLvl*LvlResp;
	                if(pInfo[i][pResp] == RespAmount)
	                {
	                    format(string, sizeof(string), "~g~NEXT LEVEL ~w~Congratulations you have now level ~r~%d",NxtLvl);
	                    PlayerPlaySound(i, 1052, 0.0, 0.0, 0.0);
	                    GameTextForPlayer(i,string,4500,1);
	                    pInfo[i][pLevel] += 1;
	                    pInfo[i][pResp] = 0;
	                    format(string, sizeof(string), "* Your Level has been increased to %d! Congratulations!",pInfo[i][pLevel]);
                     	SendClientMessage(i,COLOR_YELLOW,string);
	                }
					UpdateAccounts(); OnHouseUpdate();
			    }
			}
		}
	}
	return 1;
}

public Phone()
{
	new string[256];
	new pName[MAX_PLAYER_NAME];
	for(new i=0;i<MAX_PLAYERS;i++)
 	{
  		if(IsPlayerConnected(i))
		{
		    if(Mobile[Mobile[i]] == 255 && RingTime[Mobile[i]] > 0)
		    {
		        if(IsPlayerConnected(Mobile[i]))
		    	{
					GetPlayerName(Mobile[i],pName, sizeof(pName));
					format(string, sizeof(string), "* %s's phone rings.",pName);
					RingTime[Mobile[i]] =- 1;
					ProxDetector(30.0, Mobile[i], string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
		    }
		    TextDrawShowForPlayer(i,Txt);
		}
	}
	return 1;
}

public Other()
{
    new pName[MAX_PLAYER_NAME];
    new string[256];
    new string2[256];
    new Hour, Min, Sec;
    new Float:X,Float:Y,Float:Z;
    gettime(Hour, Min, Sec);
    CheckPos();
	for(new i=0;i<MAX_PLAYERS;i++)
 	{
  		if(IsPlayerConnected(i))
		{
		    if(GetPlayerMoney(i) - OldMoney[i] >= 20000 && pAdmin[i] == 0)
			{
			    GetPlayerName(i,pName, sizeof(pName));
			    OldMoney[i] = GetPlayerMoney(i);
			    format(string, sizeof(string),"[OOC] %s[ID:%d] just got about $25000 in one second, be sure on him!",pName,i);
				AdminMessage(string);
			}
			else
			{
				OldMoney[i] = GetPlayerMoney(i);
			}
		    if(pDragged[i] == 1)
		    {
				GetPlayerPos(pDragCop[i],X,Y,Z);
				SetPlayerPos(i,X+1,Y,Z);
}
		    if(AcceptedBackup[i] > 0)
			{
				GetPlayerPos(BackupCaller,X,Y,Z);
				SetPlayerCheckpoint(i,X,Y,Z,5);
		    }
            if(CountAmount[i] > 0 && CountAmount[i] != 999)
 	        {
         		new cstring[10];
          		format(cstring,sizeof(cstring),"~w~%d",CountAmount);
     			GameTextForAll(cstring,1100,3);
 				CountAmount[i] =- 1;
    		}
     		if(CountAmount[i] == 0)
      		{
   	    		GameTextForAll("~r~0",3000,4);
     	    	CountAmount[i] = 999;
     	    	DisablePlayerCheckpoint(i);
     	    	GameTextForPlayer(i,"~r~You failed",3500,3);
     	    	MedicOffer = 0; DrivOffer = 0;
       		}
       		if(pJailed[i] == 1)
       		{
       		    if(pJailTime[i] > 0 && pJailTime[i] < 999)
       		    {
       		    	new jstring[10];
          			format(jstring,sizeof(jstring),"~y~JailTime:~w~%d Seconds",pJailTime[i]);
     				GameTextForAll(jstring,1100,3);
     				pJailTime[i] =- 1;
     				SetPlayerInterior(i,3);
					SetPlayerPos(i,198.3966,162.1537,1003.0300);
					TogglePlayerControllable(i,0);
       		    }
       		    if(pJailTime[i] == 0)
       		    {
       		        pJailed[i] = 0;
       		        JailPrice[i] = 0;
					SpawnPlayer(i);
					SendClientMessage(i,COLOR_DMV,"* You have been released from the jail. Try to be a better citizen...");
					WantedLvl[i] = 0;
       		    }
       		}
       		if(pCuffTime[i] > 0 && pCuffTime[i] < 999)
       		{
       		    pCuffTime[i] =- 1;
       		}
       		else if(pCuffTime[i] == 0)
       		{
       		    pCuffTime[i] = 999;
       		    TogglePlayerControllable(i,1);
       		}
       		if(pSpawned[i] == 1)
       		{
       		    if(GetPlayerPing(i) > MaxPing)
				{
				    format(string, sizeof(string), "[OOC] %s[ID:%d] has been kicked. Reason: High Ping. (Max Allowed:%d)",pName,i,MaxPing);
				    SendClientMessage(i,COLOR_OTHER,string);
				    SaveToConfig(string);
				    Kick(i);
				}
  			}
  			if(GetPlayerSpecialAction(i) == 2)
  			{
  			    format(string, sizeof(string), "[OOC] %s[ID:%d] has been banned. Reason: Jet Pack",pName,i);
	    		SendClientMessage(i,COLOR_OTHER,string);
				SaveToConfig(string);
				Ban(i);
  			}
  			if(pWatch[i] == 1)
  			{
  				if(Min <= 9)
	        	{
					format(string,25,"%d:0%d",Hour, Min);
				}
				else
				{
   					format(string,25,"%d:%d",Hour, Min);
   				}
   				TextDrawSetString(HClock1,string);
   				if(Sec <= 9)
	    		{
   					format(string2,25,"0%d", Sec);
   				}
   				else
   				{
   					format(string2,25,"%d", Sec);
   				}
   				TextDrawSetString(HClock2,string2);
   				TextDrawShowForPlayer(i,HClock1);
   				TextDrawShowForPlayer(i,HClock2);
   			}
  			AllPlayerUpdate();
   		}
  	}
	return 1;
}

public FuelUpdate()
{
	new string[256];
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerInAnyVehicle(i))
	    {
			if(IsPlayerConnected(i))
			{
				new PCar = GetPlayerVehicleID(i);
				new PMod = GetVehicleModel(i);
			   	if(Tankuje[i] == 0)
			   	{
					if(PMod != 510 || PMod != 509 || PMod != 481)
					{
                  		if(Vgas[PCar] >= 1)
			      		{
			      			Vgas[PCar] -= 1;
			      			format(string, sizeof(string),"~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~FUEL: ~w~%d%",Vgas[PCar]);
			      			GameTextForPlayer(i,string,11500,3);
		      			}
				  		else
		  				{
			      			TogglePlayerControllable(i,0);
			      			GameTextForPlayer(i,"~n~~n~~n~~n~~b~Your car is without fuel!",2500,3);
			      			SendClientMessage(i,COLOR_GREY,"* Your vehicle is without fuel! Use '/exit' to get out from vehicle.");
  						}
  					}
     			}
			}
		}
	}
   	return 1;
}

public UpdateAccounts()
{
	for(new i;i<MAX_PLAYERS;i++)
 	{
 		if(IsPlayerConnected(i))
		{
		    if(pInfo[i][pLogged] == 1)
		    {
		        OnPlayerUpdate(i);
		    }
		}
	}
	return 1;
}

public GateClose()
{
	MoveObject(1,1534.740,2777.774,9.845,0.9);
	return 1;
}

//Because players needs to eat :P :P Question is - how, interiors are disabled.
//Answer is - That's a pitty, but I'll fix it in next version (soon) ;)
public HealthDown()
{
	for(new i;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(pAdmin[i] != 5 && pSpawned[i] == 1) //5 is special, you need to set it in scriptfiles
	        {
				new Float:HP;
				GetPlayerHealth(i,HP);
				if(HP > 45) //Player is fine
				{
				    SetPlayerHealth(i,HP-3);
				}
				else //Player injured
				{
				    SetPlayerHealth(i,HP-5);
				}
	        }
	    }
	}
	return 1;
}

/*
		* Public Functions *
*/

public ReadHouses()
{
	new arrCoords[29][64];
	new strFromFile2[256];
	new File: file = fopen("Houses.cfg", io_read);
	if(file)
	{
		new idx;
		while (idx < sizeof(hInfo))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, ',');
			hInfo[idx][hEntrancex] = floatstr(arrCoords[0]);
			hInfo[idx][hEntrancey] = floatstr(arrCoords[1]);
			hInfo[idx][hEntrancez] = floatstr(arrCoords[2]);
			hInfo[idx][hExitx] = floatstr(arrCoords[3]);
			hInfo[idx][hExity] = floatstr(arrCoords[4]);
			hInfo[idx][hExitz] = floatstr(arrCoords[5]);
			strmid(hInfo[idx][hOwner], arrCoords[12], 0, strlen(arrCoords[6]), 255);
			strmid(hInfo[idx][hDiscription], arrCoords[13], 0, strlen(arrCoords[7]), 255);
			hInfo[idx][hValue] = strval(arrCoords[8]);
			hInfo[idx][hInt] = strval(arrCoords[9]);
			hInfo[idx][hOwned] = strval(arrCoords[10]);
			hInfo[idx][hRooms] = strval(arrCoords[11]);
			idx++;
		}
		fclose(file);
	}
	return 1;
}

public OnHouseUpdate()
{
	new idx;
	new File: file2;
	while (idx < sizeof(hInfo))
	{
		new coordsstring[256];
		format(coordsstring, sizeof(coordsstring), "%f,%f,%f,%f,%f,%f,%s,%s,%d,%d,%d,%d\n",
		hInfo[idx][hEntrancex],
		hInfo[idx][hEntrancey],
		hInfo[idx][hEntrancez],
		hInfo[idx][hExitx],
		hInfo[idx][hExity],
		hInfo[idx][hExitz],
		hInfo[idx][hOwner],
		hInfo[idx][hDiscription],
		hInfo[idx][hValue],
		hInfo[idx][hInt],
		hInfo[idx][hOwned],
		hInfo[idx][hRooms]);
		if(idx == 0)
		{
			file2 = fopen("Houses.cfg", io_write);
		}
		else
		{
			file2 = fopen("Houses.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	return 1;
}

public ShowPlayerStats(playerid)
{
	if(IsPlayerConnected(playerid) && pInfo[playerid][pLogged] == 1)
	{
	    new StatsString[256];
	    new pName[MAX_PLAYER_NAME];

	    new SexText[20];
	    if(pInfo[playerid][pSex] == 1) { SexText = "Male"; }
	    else if(pInfo[playerid][pSex] == 2) { SexText = "Female"; }

	    new OrgText[20];
	    if(pInfo[playerid][pCop] >= 1) { OrgText = "Police Force"; }
	    if(pInfo[playerid][pFBI] >= 1) { OrgText = "FBI Agent"; }
	    if(pInfo[playerid][pMedic] >= 1) { OrgText = "Paramedics"; }
	    if(pInfo[playerid][pDriver] >= 1) { OrgText = "Taxi Company"; }
	    if(pInfo[playerid][pInstructor] >= 1) { OrgText = "DMV"; }
	    if(pInfo[playerid][pMafia1] >= 1) { OrgText = "Corleone Mafia"; }
	    if(pInfo[playerid][pMafia2] >= 1) { OrgText = "*** Mafia"; }
	    else{ OrgText = "None"; }

	    new RankText[20];
	    if(pInfo[playerid][pCop] >= 1)
	    {
	    	if(pInfo[playerid][pCop] == 1) { RankText = "Cadet"; }
	    	else if(pInfo[playerid][pCop] == 2) { RankText = "Officer"; }
	    	else if(pInfo[playerid][pCop] == 3) { RankText = "Lieutenant"; }
	    	else if(pInfo[playerid][pCop] == 4) { RankText = "Chief"; }
		}
		else if(pInfo[playerid][pFBI] >= 1)
		{
	    	if(pInfo[playerid][pFBI] == 1) { RankText = "Agent"; }
	    	else if(pInfo[playerid][pFBI] == 2) { RankText = "Professional Staff"; }
	    	else if(pInfo[playerid][pFBI] == 3) { RankText = "Director"; }
	    }
	    else if(pInfo[playerid][pMedic] == 1) { RankText = "Medic"; }
	    else { RankText = "None"; }

	    new LicText1[20];
	    if(pInfo[playerid][pCarLic] == 1) { LicText1 = "Passed"; } else { LicText1 = "None"; }

	    new LicText2[20];
	    if(pInfo[playerid][pFlyLic] == 1) { LicText2 = "Passed"; } else { LicText2 = "None"; }

	    new Money = GetPlayerMoney(playerid);
	    new Level = pInfo[playerid][pLevel];
	    new ALevel = pAdmin[playerid];
	    new Kills = pInfo[playerid][pKills];
	    new Deaths = pInfo[playerid][pDeaths];
	    new Respect = pInfo[playerid][pResp];
	    new NxtLvl = pInfo[playerid][pLevel]+1;
	    new NxtResp = NxtLvl*LvlResp;
	    new NxtLvlCost = NxtLvl*LvlCost;
	    new Phonee = pInfo[playerid][pPhoneNumber];
	    new Bank = pInfo[playerid][pBankAccount];
	    GetPlayerName(playerid, pName, sizeof(pName));

	    format(StatsString, sizeof(StatsString), "Name:[%s] Level:[%d] Money:[%d] Bank:[%d] Sex:[%s] Phone:[%d] AdminLvl:[%d]",pName,Level,Money,Bank,SexText,Phonee,ALevel);
	    SendClientMessage(playerid,COLOR_WHITE,StatsString);
	    format(StatsString, sizeof(StatsString), "Next Level:[$%d] Respect:[%d/%d] Connected Time:[%d] Kills:[%d] Deaths:[%d]",NxtLvlCost,Respect,NxtResp,Kills,Deaths);
	    SendClientMessage(playerid,COLOR_WHITE,StatsString);
	    format(StatsString, sizeof(StatsString), "Organisation:[%s] Rank:[%s] DrivingLicense:[%s] FlyingLicense:[%s]",OrgText,RankText,LicText1,LicText2);
	    SendClientMessage(playerid,COLOR_WHITE,StatsString);
	}
	return 1;
}

public ShowPlayerHelpList(playerid)
{
    if(IsPlayerConnected(playerid) && pInfo[playerid][pLogged] == 1)
	{
	    SendClientMessage(playerid, COLOR_CHAT1, "ACCOUNT: /register /login /help /stats /ahelp");
	    SendClientMessage(playerid, COLOR_CHAT2, "GENERAL: /pay /service /accept /time /buy /smoke /whisper /ooc /b /shout /me /menu");
	    SendClientMessage(playerid, COLOR_CHAT2, "GENERAL: /advertise /enter /exit /licenses /quitjob /lock /call /pickup /hangup /number");
	    SendClientMessage(playerid, COLOR_CHAT3, "BANK: /bank /withdraw /balance");
	    if(pInfo[playerid][pJob] == 1)
		{
	    	SendClientMessage(playerid, COLOR_CHAT4, "JOB: /repair");
		}
		else if(pInfo[playerid][pJob] == 2)
		{
	    	SendClientMessage(playerid, COLOR_CHAT4, "JOB: /find");
		}
		if(pInfo[playerid][pDriver] >= 1)
		{
	    	SendClientMessage(playerid, COLOR_CHAT4, "JOB: /fare");
		}
		if(pInfo[playerid][pMedic] >= 1)
		{
	    	SendClientMessage(playerid, COLOR_CHAT4, "JOB: /heal /department");
		}
		else if(pInfo[playerid][pJob] == 5)
		{
	    	SendClientMessage(playerid, COLOR_CHAT4, "JOB: /sellcar");
		}
		if(pInfo[playerid][pFBI] >= 1)
		{
	    	SendClientMessage(playerid, COLOR_CHAT4, "FBI: /(r)adio /(m)egaphone /cuff /uncuff /(pa)ralyse /arrest /frisk /(su)spect");
	    	SendClientMessage(playerid, COLOR_CHAT4, "FBI: /ticket /(d)epartment /duty /drag /dragend");
		}
		if(pInfo[playerid][pCop] >= 1)
		{
	    	SendClientMessage(playerid, COLOR_CHAT4, "PD: /(r)adio /(m)egaphone /cuff /uncuff /(pa)ralyse /arrest /frisk /(su)spect");
	    	SendClientMessage(playerid, COLOR_CHAT4, "PD: /ticket /(d)epartment /duty /drag /dragend");
		}
		if(pInfo[playerid][pMafia1] >= 1)
		{
		    SendClientMessage(playerid, COLOR_CHAT4, "Corleone Mafia: /gate");
		}
		SendClientMessage(playerid, COLOR_CHAT5, "OTHER: /leadhelp /bail /showlicenses");
		SendClientMessage(playerid, COLOR_WHITE, "PROPERTY: /buyhouse /sellhouse /buyprop /sellprop");
	}
	return 1;
}

public SpawnPlayerToJob(playerid)
{
	if(pInfo[playerid][pSex] == 1)
	{
		SetPlayerSkin(playerid,60);
	}
	else if(pInfo[playerid][pSex] == 2)
	{
		SetPlayerSkin(playerid,56);
	}
	if(pInfo[playerid][pFBI] >= 1)
	{
	    SetPlayerPos(playerid,2242.4685,2446.0229,10.8203);
	    SetPlayerFacingAngle(playerid,359.7383);
	    SetPlayerSkin(playerid,286);
	    if(OnDuty[playerid] == 1)
	    {
	    	SetPlayerStuff(playerid,24,307,29,330,3,1,100,100);
		}
		else
		{
			SetPlayerStuff(playerid,24,307,0,0,3,1,100,0);
		}
	}
	else if(pInfo[playerid][pCop] >= 1)
	{
	    SetPlayerPos(playerid,2242.4685,2446.0229,10.8203);
	    SetPlayerFacingAngle(playerid,359.7383);
	    SetPlayerSkin(playerid,280);
	    if(OnDuty[playerid] == 1)
	    {
	    	SetPlayerStuff(playerid,24,307,29,330,3,1,100,100);
		}
		else
		{
			SetPlayerStuff(playerid,24,307,0,0,3,1,100,0);
		}
	}
	else if(pInfo[playerid][pMedic] >= 1)
	{
	    SetPlayerPos(playerid,1613.6636,1817.4321,10.8203);
	    SetPlayerFacingAngle(playerid,0.6389);
	    SetPlayerSkin(playerid,276);
	}
	else if(pInfo[playerid][pMafia1] == 4)
	{
	    SetPlayerPos(playerid,1457.8379,2773.1426,10.8203);
	    SetPlayerFacingAngle(playerid,261.6396);
	    SetPlayerStuff(playerid,24,307,1,1,0,0,100,100);
	    SetPlayerSkin(playerid,113);
	}
	else if(pInfo[playerid][pMafia1] == 3)
	{
	    SetPlayerPos(playerid,1457.8379,2773.1426,10.8203);
	    SetPlayerFacingAngle(playerid,261.6396);
	    SetPlayerStuff(playerid,24,307,1,1,0,0,100,0);
	    SetPlayerSkin(playerid,111);
	}
	else if(pInfo[playerid][pMafia1] < 3 && pInfo[playerid][pMafia1] > 0)
	{
	    SetPlayerPos(playerid,1457.8379,2773.1426,10.8203);
	    SetPlayerFacingAngle(playerid,261.6396);
	    SetPlayerStuff(playerid,24,307,1,1,0,0,100,0);
	    SetPlayerSkin(playerid,112);
	}
	return 1;
}

public RandNumb(minamount, maxamount)
{
    new TotalAm = minamount+(maxamount/minamount)+random(maxamount-minamount);
    if(TotalAm > maxamount) TotalAm = maxamount;
    if(TotalAm < minamount) TotalAm = minamount;
	return TotalAm;
}

public GetCountOfPlayers()
{
	new pla = 0;
	for(new i;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        pla ++;
	    }
	}
	return pla;
}

public SetPos(playerid, Float:X, Float:Y, Float:Z, interior, angle)
{
	SetPlayerPos(playerid,Float:X,Float:Y,Float:Z);
	SetPlayerInterior(playerid,interior);
	return SetPlayerFacingAngle(playerid,angle);
}

public SetRealTime()
{
	new Hour,Min,Sec;
	new Year,Month,Day;
	gettime(Hour,Min,Sec);
	getdate(Year,Month,Day);
	SetWorldTime(Hour);
	return 1;
}

public SetPlayerStuff(playerid,weapon1,ammo1,weapon2,ammo2,weapon3,ammo3,health,armour)
{
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid,weapon1,ammo1); GivePlayerWeapon(playerid,weapon2,ammo2);
	GivePlayerWeapon(playerid,weapon3,ammo3); SetPlayerHealth(playerid,health);
	SetPlayerArmour(playerid,armour);
	return 1;
}

public SetPlayerMoney(playerid,amount)
{
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid,amount);
	return 1;
}

public StartPlayerCountDown(playerid,amount)
{
	if(IsPlayerConnected(playerid))
	{
		CountAmount[playerid] = amount;
	}
	return 1;
}

public RadioMessage(const string[])
{
    for(new i;i<MAX_PLAYERS;i++)
    {
        if(IsPlayerConnected(i))
        {
            if(pInfo[i][pCop] >= 1 || pInfo[i][pFBI] >= 1)
            {
                SendClientMessage(i,0x33AA33AA,string);
            }
        }
    }
    return 1;
}

public FamilyMessage(mafiaid, const string[])
{
    for(new i;i<MAX_PLAYERS;i++)
    {
        if(IsPlayerConnected(i))
        {
            if(mafiaid == 1)
            {
            	if(pInfo[i][pMafia1] >= 1)
            	{
                	SendClientMessage(i,COLOR_LIGHTGREEN,string);
            	}
			}
			else if(mafiaid == 2)
            {
            	if(pInfo[i][pMafia2] >= 1)
            	{
                	SendClientMessage(i,COLOR_LIGHTGREEN,string);
            	}
			}
        }
    }
    return 1;
}

public DepartmentMessage(const string[])
{
    for(new i;i<MAX_PLAYERS;i++)
    {
        if(IsPlayerConnected(i))
        {
            if(pInfo[i][pCop] >= 1 || pInfo[i][pFBI] >= 1 || pInfo[i][pMedic] >= 1)
            {
                SendClientMessage(i,COLOR_OTHER,string);
            }
        }
    }
    return 1;
}

public TaxiMessage(const string[])
{
    for(new i;i<MAX_PLAYERS;i++)
    {
        if(IsPlayerConnected(i))
        {
            if(pInfo[i][pDriver] >= 1)
            {
                SendClientMessage(i,COLOR_OTHER,string);
            }
        }
    }
    return 1;
}

public AdminMessage(const string[])
{
	for(new i;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(pAdmin[i] > 0)
	        {
	            SendClientMessage(i,COLOR_OTHER,string);
	        }
	    }
	}
	return 1;
}

public AllPlayerUpdate()
{
	for(new i;i<MAX_PLAYERS;i++)
 	{
 		if(IsPlayerConnected(i))
		{
			new WLvl = WantedLvl[i];
	        if(WLvl > 0 && pInfo[i][pLogged] == 1)
	        {
				SetPlayerWantedLevel(i,WLvl);
			}
			new RPLvl = pInfo[i][pLevel];
			if(pInfo[i][pLogged] == 1)
			{
				SetPlayerScore(i,RPLvl);
			}
		}
	}
	return 1;
}

public OnPlayerRegister(playerid, password[])
{
	if(IsPlayerConnected(playerid))
	{
			new string3[32];
			new playername3[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername3, sizeof(playername3));
			format(string3, sizeof(string3), "%s.sav", playername3);
			new File: hFile = fopen(string3, io_write);
			new Money = GetPlayerMoney(playerid);
			new Float:HP; GetPlayerHealth(playerid,HP);
			new Float:ARM; GetPlayerArmour(playerid,ARM);
			if(hFile)
			{
			    strmid(pInfo[playerid][pKey], password, 0, strlen(password), 255);
			    new var[32];
			    format(var, 32, "Key=%s\n", pInfo[playerid][pKey]);fwrite(hFile, var);
				format(var, 32, "Job=%d\n", pInfo[playerid][pJob]);fwrite(hFile, var);
				format(var, 32, "AdminLvl=%d\n", pAdmin[playerid]);fwrite(hFile, var);
				format(var, 32, "Sex=%d\n", pInfo[playerid][pSex]);fwrite(hFile, var);
				format(var, 32, "Level=%d\n", pInfo[playerid][pLevel]);fwrite(hFile, var);
				format(var, 32, "Respect=%d\n", pInfo[playerid][pResp]);fwrite(hFile, var);
				format(var, 32, "Money=%d\n", Money);fwrite(hFile, var);
				format(var, 32, "Bank=%d\n", pInfo[playerid][pBankAccount]);fwrite(hFile, var);
				format(var, 32, "PhoneNumber=%d\n", pInfo[playerid][pPhoneNumber]);fwrite(hFile, var);
				format(var, 32, "IsCop=%d\n", pInfo[playerid][pCop]);fwrite(hFile, var);
				format(var, 32, "IsFBI=%d\n", pInfo[playerid][pFBI]);fwrite(hFile, var);
				format(var, 32, "IsMedic=%d\n", pInfo[playerid][pMedic]);fwrite(hFile, var);
				format(var, 32, "IsMafia1=%d\n", pInfo[playerid][pMafia1]);fwrite(hFile, var);
				format(var, 32, "IsMafia2=%d\n", pInfo[playerid][pMafia2]);fwrite(hFile, var);
				format(var, 32, "IsTaxi=%d\n", pInfo[playerid][pDriver]);fwrite(hFile, var);
				format(var, 32, "IsDMV=%d\n", pInfo[playerid][pInstructor]);fwrite(hFile, var);
				format(var, 32, "DriversLic=%d\n", pInfo[playerid][pCarLic]);fwrite(hFile, var);
				format(var, 32, "FlyingLic=%d\n", pInfo[playerid][pFlyLic]);fwrite(hFile, var);
				format(var, 32, "Kills=%d\n", pInfo[playerid][pKills]);fwrite(hFile, var);
				format(var, 32, "Deaths=%d\n", pInfo[playerid][pDeaths]);fwrite(hFile, var);
				format(var, 32, "ConnectedTime=%d\n", pInfo[playerid][pConTime]);fwrite(hFile, var);
				format(var, 32, "Registered=%d\n", RegistrationUpd[playerid]);fwrite(hFile, var);
				format(var, 32, "Materials=%d\n", pInfo[playerid][pMats]);fwrite(hFile, var);
				format(var, 32, "VehicleLock=%d\n", pStuff[playerid][VehicleLock]);fwrite(hFile, var);
				format(var, 32, "Ciggarettes=%d\n", pStuff[playerid][Ciggarettes]);fwrite(hFile, var);
				format(var, 32, "Rope=%d\n", pStuff[playerid][Rope]);fwrite(hFile, var);
				format(var, 32, "Watch=%d\n", pStuff[playerid][Watch]);fwrite(hFile, var);
				format(var, 32, "PhoneBook=%d\n", pStuff[playerid][PhoneBook]);fwrite(hFile, var);
				format(var, 32, "IsJailed=%d\n", pJailed[playerid]);fwrite(hFile, var);
				format(var, 32, "JailTime=%d\n", pJailTime[playerid]);fwrite(hFile, var);
				format(var, 32, "HouseKey=%d\n", pInfo[playerid][pHouseKey]);fwrite(hFile, var);
				format(var, 32, "BoughtVehicle=%d\n", pBought[playerid]);fwrite(hFile, var);
				format(var, 32, "VehicleInfo=%d\n", pCarInfo[playerid]);fwrite(hFile, var);
				format(var, 32, "PlayerCar=%d\n", pCar[playerid]);fwrite(hFile, var);
				format(var, 32, "HP=%d\n", HP);fwrite(hFile, var);
				format(var, 32, "ARM=%d\n", ARM);fwrite(hFile, var);
				fclose(hFile);
				SendClientMessage(playerid,COLOR_YELLOW,"SERVER: Account has been Successfully Registered!");
				SendClientMessage(playerid,COLOR_WHITE,"HINT: You have automaticaly been logged in!");
				pInfo[playerid][pLogged] = 1;
				SpawnPlayer(playerid);
				pInfo[playerid][pBankAccount] = 3500;
				SetPlayerMoney(playerid,1250);
				pInfo[playerid][pLevel] = 1;
				SendClientMessage(playerid,COLOR_OTHER,"Select your Sex (Male / Female)");
				RegistrationUpd[playerid] = 2;
				TogglePlayerControllable(playerid,0);
			}
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(pInfo[playerid][pLogged] == 1)
		{
			new string3[32];
			new playername3[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername3, sizeof(playername3));
			format(string3, sizeof(string3), "%s.sav", playername3);
			new File: hFile = fopen(string3, io_write);
			new Money = GetPlayerMoney(playerid);
			new Float:HP; GetPlayerHealth(playerid,HP);
			new Float:ARM; GetPlayerArmour(playerid,ARM);
			if(hFile)
			{
				new var[32];
				format(var, 32, "Key=%s\n", pInfo[playerid][pKey]);fwrite(hFile, var);
				format(var, 32, "Job=%d\n", pInfo[playerid][pJob]);fwrite(hFile, var);
				format(var, 32, "AdminLvl=%d\n", pAdmin[playerid]);fwrite(hFile, var);
				format(var, 32, "Sex=%d\n", pInfo[playerid][pSex]);fwrite(hFile, var);
				format(var, 32, "Level=%d\n", pInfo[playerid][pLevel]);fwrite(hFile, var);
				format(var, 32, "Respect=%d\n", pInfo[playerid][pResp]);fwrite(hFile, var);
				format(var, 32, "Money=%d\n", Money);fwrite(hFile, var);
				format(var, 32, "Bank=%d\n", pInfo[playerid][pBankAccount]);fwrite(hFile, var);
				format(var, 32, "PhoneNumber=%d\n", pInfo[playerid][pPhoneNumber]);fwrite(hFile, var);
				format(var, 32, "IsCop=%d\n", pInfo[playerid][pCop]);fwrite(hFile, var);
				format(var, 32, "IsFBI=%d\n", pInfo[playerid][pFBI]);fwrite(hFile, var);
				format(var, 32, "IsMedic=%d\n", pInfo[playerid][pMedic]);fwrite(hFile, var);
				format(var, 32, "IsMafia1=%d\n", pInfo[playerid][pMafia1]);fwrite(hFile, var);
				format(var, 32, "IsMafia2=%d\n", pInfo[playerid][pMafia2]);fwrite(hFile, var);
				format(var, 32, "IsTaxi=%d\n", pInfo[playerid][pDriver]);fwrite(hFile, var);
				format(var, 32, "IsDMV=%d\n", pInfo[playerid][pInstructor]);fwrite(hFile, var);
				format(var, 32, "DriversLic=%d\n", pInfo[playerid][pCarLic]);fwrite(hFile, var);
				format(var, 32, "FlyingLic=%d\n", pInfo[playerid][pFlyLic]);fwrite(hFile, var);
				format(var, 32, "Kills=%d\n", pInfo[playerid][pKills]);fwrite(hFile, var);
				format(var, 32, "Deaths=%d\n", pInfo[playerid][pDeaths]);fwrite(hFile, var);
				format(var, 32, "ConnectedTime=%d\n", pInfo[playerid][pConTime]);fwrite(hFile, var);
				format(var, 32, "Registered=%d\n", RegistrationUpd[playerid]);fwrite(hFile, var);
				format(var, 32, "Materials=%d\n", pInfo[playerid][pMats]);fwrite(hFile, var);
				format(var, 32, "VehicleLock=%d\n", pStuff[playerid][VehicleLock]);fwrite(hFile, var);
				format(var, 32, "Ciggarettes=%d\n", pStuff[playerid][Ciggarettes]);fwrite(hFile, var);
				format(var, 32, "Rope=%d\n", pStuff[playerid][Rope]);fwrite(hFile, var);
				format(var, 32, "Watch=%d\n", pStuff[playerid][Watch]);fwrite(hFile, var);
				format(var, 32, "PhoneBook=%d\n", pStuff[playerid][PhoneBook]);fwrite(hFile, var);
				format(var, 32, "IsJailed=%d\n", pJailed[playerid]);fwrite(hFile, var);
				format(var, 32, "JailTime=%d\n", pJailTime[playerid]);fwrite(hFile, var);
				format(var, 32, "HouseKey=%d\n", pInfo[playerid][pHouseKey]);fwrite(hFile, var);
				format(var, 32, "BoughtVehicle=%d\n", pBought[playerid]);fwrite(hFile, var);
				format(var, 32, "VehicleInfo=%d\n", pCarInfo[playerid]);fwrite(hFile, var);
				format(var, 32, "PlayerCar=%d\n", pCar[playerid]);fwrite(hFile, var);
				format(var, 32, "HP=%d\n", HP);fwrite(hFile, var);
				format(var, 32, "ARM=%d\n", ARM);fwrite(hFile, var);
				fclose(hFile);
			}
		}
	}
	return 1;
}

public OnPlayerLogin(playerid,password[])
{
    new string2[64];
	new playername2[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername2, sizeof(playername2));
	format(string2, sizeof(string2), "%s.sav", playername2);
	new File:UserFile = fopen(string2, io_read);
	new Money = GetPlayerMoney(playerid);
	new Float:HP; GetPlayerHealth(playerid,HP);
	new Float:ARM; GetPlayerArmour(playerid,ARM);
	if(UserFile)
	{
	    new PassData[256];
	    new keytmp[256], valtmp[256];
	    fread( UserFile , PassData , sizeof( PassData ) );
	    keytmp = ini_GetKey( PassData );
	    if(strcmp(keytmp,"Key",true) == 0)
		{
			valtmp = ini_GetValue( PassData );
			strmid(pInfo[playerid][pKey], valtmp, 0, strlen(valtmp)-1, 255);
		}
		if(strcmp(pInfo[playerid][pKey],password, true ) == 0 )
		{
			    new key[256],val[256];
			    new Data[256];
			    while(fread(UserFile,Data,sizeof(Data)))
				{
					key = ini_GetKey( Data );
					if(strcmp(key,"Job",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pJob] = strval( val ); }
					if(strcmp(key,"AdminLvl",true) == 0 ) { val = ini_GetValue( Data ); pAdmin[playerid] = strval( val ); }
					if(strcmp(key,"Sex",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pSex] = strval( val ); }
					if(strcmp(key,"Level",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pLevel] = strval( val ); }
					if(strcmp(key,"Respect",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pResp] = strval( val ); }
					if(strcmp(key,"Money",true) == 0 ) { val = ini_GetValue( Data ); Money = strval( val ); }
					if(strcmp(key,"Bank",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pBankAccount] = strval( val ); }
					if(strcmp(key,"PhoneNumber",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pPhoneNumber] = strval( val ); }
					if(strcmp(key,"IsCop",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pCop] = strval( val ); }
					if(strcmp(key,"IsFBI",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pFBI] = strval( val ); }
					if(strcmp(key,"IsMedic",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pMedic] = strval( val ); }
					if(strcmp(key,"IsMafia1",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pMafia1] = strval( val ); }
					if(strcmp(key,"IsMafia2",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pMafia2] = strval( val ); }
					if(strcmp(key,"IsTaxi",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pDriver] = strval( val ); }
					if(strcmp(key,"IsDMV",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pInstructor] = strval( val ); }
					if(strcmp(key,"DriversLic",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pCarLic] = strval( val ); }
					if(strcmp(key,"FlyingLic",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pFlyLic] = strval( val ); }
					if(strcmp(key,"Kills",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pKills] = strval( val ); }
					if(strcmp(key,"Deaths",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pDeaths] = strval( val ); }
					if(strcmp(key,"ConnectedTime",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pConTime] = strval( val ); }
					if(strcmp(key,"Registered",true) == 0 ) { val = ini_GetValue( Data ); RegistrationUpd[playerid] = strval( val ); }
					if(strcmp(key,"Materials",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pMats] = strval( val ); }
					if(strcmp(key,"VehicleLock",true) == 0 ) { val = ini_GetValue( Data ); pStuff[playerid][VehicleLock] = strval( val ); }
					if(strcmp(key,"Ciggarettes",true) == 0 ) { val = ini_GetValue( Data ); pStuff[playerid][Ciggarettes] = strval( val ); }
					if(strcmp(key,"Rope",true) == 0 ) { val = ini_GetValue( Data ); pStuff[playerid][Rope] = strval( val ); }
					if(strcmp(key,"Watch",true) == 0 ) { val = ini_GetValue( Data ); pStuff[playerid][Watch] = strval( val ); }
					if(strcmp(key,"PhoneBook",true) == 0 ) { val = ini_GetValue( Data ); pStuff[playerid][PhoneBook] = strval( val ); }
					if(strcmp(key,"IsJailed",true) == 0 ) { val = ini_GetValue( Data ); pJailed[playerid] = strval( val ); }
					if(strcmp(key,"JailTime",true) == 0 ) { val = ini_GetValue( Data ); pJailTime[playerid] = strval( val ); }
					if(strcmp(key,"HouseKey",true) == 0 ) { val = ini_GetValue( Data ); pInfo[playerid][pHouseKey] = strval( val ); }
					if(strcmp(key,"BoughtVehicle",true) == 0 ) { val = ini_GetValue( Data ); pBought[playerid] = strval( val ); }
					if(strcmp(key,"VehicleInfo",true) == 0 ) { val = ini_GetValue( Data ); pCarInfo[playerid] = strval( val ); }
					if(strcmp(key,"PlayerCar",true) == 0 ) { val = ini_GetValue( Data ); pCar[playerid] = strval( val ); }
					if(strcmp(key,"HP",true) == 0 ) { val = ini_GetValue( Data ); HP = strval( val ); }
					if(strcmp(key,"ARM",true) == 0 ) { val = ini_GetValue( Data ); ARM = strval( val ); }
				}
				fclose(UserFile);
				SendClientMessage(playerid,COLOR_OTHER,"[OOC] You have been successfully Logged In!");
				}else{
		    if(pInfo[playerid][pLogTries] < 3)
		    {
				SendClientMessage(playerid,COLOR_WHITE, "SERVER: Password does not match your UserName!");
				pInfo[playerid][pLogTries] += 1;
        		fclose(UserFile);
		    	}else{
		        SendClientMessage(playerid,COLOR_YELLOW,"SERVER: You have been banned! [Trying to Steal an Account]");
		        Ban(playerid);
		    }
		    return 1;
		}
		pInfo[playerid][pLogged] = 1;
		GivePlayerMoney(playerid,Money);
		pInfo[playerid][pJob] = pInfo[playerid][pJob];
		SpawnPlayer(playerid);
		OnPlayerUpdate(playerid);
		SetPlayerHealth(playerid,HP);
		SetPlayerArmour(playerid,ARM);
		if(pBought[playerid] > 0)
		{
		    new RandCarSpawn = random(10);
		    switch(RandCarSpawn)
		    {
		        case 0: CreateVehicle(pBought[playerid],2176.6416,1441.2207,10.5435,359.3397,pCarInfo[playerid],0,9999999);
		        case 1: CreateVehicle(pBought[playerid],2173.0342,1441.2185,10.5396,358.2821,pCarInfo[playerid],0,9999999);
		        case 2: CreateVehicle(pBought[playerid],2169.1143,1441.1798,10.5415,357.4902,pCarInfo[playerid],0,9999999);
		        case 3: CreateVehicle(pBought[playerid],2164.8354,1441.1608,10.5474,0.5078,pCarInfo[playerid],0,9999999);
		        case 4: CreateVehicle(pBought[playerid],2160.9795,1440.9968,10.5474,1.9480,pCarInfo[playerid],0,9999999);
		        case 5: CreateVehicle(pBought[playerid],2156.4700,1441.1483,10.5435,0.9753,pCarInfo[playerid],0,9999999);
		        case 6: CreateVehicle(pBought[playerid],2133.4070,1441.1581,10.5474,0.3651,pCarInfo[playerid],0,9999999);
		        case 7: CreateVehicle(pBought[playerid],2152.5825,1441.0717,10.5396,1.0057,pCarInfo[playerid],0,9999999);
		        case 8: CreateVehicle(pBought[playerid],2141.8826,1441.1212,10.5474,0.8307,pCarInfo[playerid],0,9999999);
		        case 9: CreateVehicle(pBought[playerid],2137.4207,1441.1344,10.5474,3.9820,pCarInfo[playerid],0,9999999);
		    }
		    SendClientMessage(playerid,COLOR_OTHER,"[OOC] Your vehicle has been spawned near the LV Cars!");
		}
	}
	return 1;
}

public IsAtGasStation(playerid)
{
   	if(IsPlayerConnected(playerid))
   	{
	  if(PlayerToPoint(playerid,1595.5406, 2198.0520, 10.3863,15))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,2202.0649, 2472.6697, 10.5677,15))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,2115.1929, 919.9908, 10.5266,15))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,2640.7209, 1105.9565, 10.5274,15))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,608.5971, 1699.6238, 6.9922,15))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,618.4878, 1684.5792, 6.9922,15))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,2146.3467, 2748.2893, 10.5245,15))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,-1679.4595, 412.5129, 6.9973,15))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,-1327.5607, 2677.4316, 49.8093,15))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,-1470.0050, 1863.2375, 32.3521,15))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,-2409.2200, 976.2798, 45.2969,15))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,-2244.1396, -2560.5833, 31.9219,15))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,-1606.0544, -2714.3083, 48.5335,15))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,1937.4293, -1773.1865, 13.3828,15))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,-91.3854, -1169.9175, 2.4213,15))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,1383.4221, 462.5385, 20.1506,15))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,660.4590, -565.0394, 16.3359,15))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,1381.7206, 459.1907, 20.3452,15))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,-1605.7156, -2714.4573, 48.5335,15))
	  {
		 return 1;
	  }
      if(PlayerToPoint(playerid,-2029.4047,157.2388,28.5722,15))
	  {
		 return 1;
	  }
   	}
   	return 0;
}

public GetDistanceBetweenPlayers(player,player2)
{
    new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
    new Float:tmpdis;
    GetPlayerPos(player,x1,y1,z1);
    GetPlayerPos(player2,x2,y2,z2);
    tmpdis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
    return floatround(tmpdis);
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

public ProxDetectorS(Float:radi, playerid, targetid)
{
    if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		GetPlayerPos(targetid, posx, posy, posz);
		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);
		if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
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
					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, string);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, string);
					}
				}
				else
				{
					SendClientMessage(i, col1, string);
				}
			}
		}
	}
	return 1;
}

public Encrypt(string[])
{
   	for(new x=0; x < strlen(string); x++)
   	{
   	  	string[x] += (3^x) * (x % 15);
	  	if(string[x] > (0xff))
	  	{
  	 		string[x] -= 256;
	  	}
   	}
	return 1;
}

stock ini_GetKey(line[])
{
	new keyRes[256];
	keyRes[0] = 0;
    if(strfind(line, "=", true) == -1) return keyRes;
    strmid(keyRes, line, 0, strfind(line, "=", true), sizeof(keyRes));
    return keyRes;
}

stock ini_GetValue(line[])
{
	new valRes[256];
	valRes[0] = 0;
	if(strfind(line, "=", true) == -1) return valRes;
	strmid(valRes, line, strfind(line, "=", true) +1, strlen(line), sizeof(valRes));
	return valRes;
}

PlayerToPoint(playerid,Float:x,Float:y,Float:z,radius)
{
   if(GetPlayerDistanceToPointEx(playerid,x,y,z) < radius){
   return 1;
}
   return 0;
}

GetPlayerDistanceToPointEx(playerid,Float:x,Float:y,Float:z)
{
   new Float:x1,Float:y1,Float:z1;
   new Float:tmpdis;
   GetPlayerPos(playerid,x1,y1,z1);
   tmpdis = floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2)+floatpower(floatabs(floatsub(z,z1)),2));
   return floatround(tmpdis);
}

public split(const strsrc[], strdest[][], delimiter)
{
	new i,li;
	new aNum;
	new len;
	while(i <= strlen(strsrc))
	{
 		if(strsrc[i] == delimiter || i == strlen(strsrc))
 		{
   			len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}

stock SaveToConfig(string[])
{
	new config[256];
	format(config,sizeof(config),"%s\n",string);
	new File:CFile;
	CFile = fopen("Config.txt",io_append);
	fwrite(CFile,config);
	fclose(CFile);
}

stock SaveReport(string[])
{
	new config[256];
	format(config,sizeof(config),"%s\n",string);
	new File:CFile;
	CFile = fopen("Report.txt",io_append);
	fwrite(CFile,config);
	fclose(CFile);
}

stock SavePay(string[])
{
	new config[256];
	format(config,sizeof(config),"%s\n",string);
	new File:CFile;
	CFile = fopen("Transactions.txt",io_append);
	fwrite(CFile,config);
	fclose(CFile);
}

stock SaveOOC(string[])
{
	new config[256];
	format(config,sizeof(config),"%s\n",string);
	new File:CFile;
	CFile = fopen("OOCChat.txt",io_append);
	fwrite(CFile,config);
	fclose(CFile);
}

stock SaveChat(string[])
{
	new config[256];
	format(config,sizeof(config),"%s\n",string);
	new File:CFile;
	CFile = fopen("LocalChat.txt",io_append);
	fwrite(CFile,config);
	fclose(CFile);
}

stock SaveAction(string[])
{
	new config[256];
	format(config,sizeof(config),"%s\n",string);
	new File:CFile;
	CFile = fopen("Actions.txt",io_append);
	fwrite(CFile,config);
	fclose(CFile);
}

strtok(const string[], &index)
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
