#include <a_samp>
#include <dudb>
#include <dini>
#include <dutils>
#include <core>
#include <file>
#include <float>
#define dcmd(%1,%2,%3) if((strcmp((%3)[1], #%1, true, (%2)) == 0)&&((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2])))))return 1

//passport password
#define PASSPORT_PASSWORD "zebra"
//colors
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_DARK_RED 0xAA3333AA
#define COLOR_RED 0xFF0000AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_BLUE 0x0000AA20
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_SYSTEM 0xEFEFF7AA
//wanted colors
#define WANTED_0 0xFFFFFFAA
#define WANTED_1 0xFFBFBFAA
#define WANTED_2 0xFF9F9FAA
#define WANTED_3 0xFF8C8CAA
#define WANTED_4 0xFF6262AA
#define WANTED_5 0xFF4242AA
#define WANTED_6 0xFF0F0FAA
//Teams
#define TEAM_POLICE_LS 1
#define TEAM_FBI 2
//#define TEAM_PILOT 3
#define TEAM_MEDIC_LS 3
#define TEAM_POLICE_LV 4
#define TEAM_POLICE_SF 5
#define TEAM_MEDIC_LV 6
#define TEAM_MEDIC_SF 7
#define TEAM_CITIZEN_LS 8
#define TEAM_CITIZEN_LV 9
#define TEAM_CITIZEN_SF 10
#define TEAM_BODYGUARD 11
#define TEAM_MECHANIC 12
//Hospitals
#define hospls1 1
#define hospls2 2
#define hospsf 3
#define hosplv 4
//Banks
#define lsb 1
#define sfb 2
#define lvb 3
//SPEED
#define SLOTS 400
enum SavePlayerPosEnum {
Float:LastX,
Float:LastY,
Float:LastZ
}

//fuel
#define TIME 45000
#define AMOUNT 100
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
#define MAX_POINTS 16

//weapons
#define Brass 1// - Brass Knuckles
#define Golf 2// - Golf Club
#define Night 3 //- Night Stick
#define Knife 4// - Knife
#define Bat 5// - Baseball Bat
#define Shovel 6// - Shovel
#define Cue 7// - Pool cue
#define Katana 8// - Katana
#define Chainsaw 9// - Chainsaw
#define Pdildo 10// - Purple Dildo
#define Wdildo 11// - White Dildo
#define lwdildo 12// - Long White Dildo
#define wdildio2 13// - White Dildo 2
#define Flowers 14// - Flowers
#define Cane 15// - Cane
#define Grenades 16// - Grenades
#define Tear 17// - Tear Gas
#define Molotovs 18// - Molotovs
#define Pistol 22// - Pistol
#define Spistol 23// - Silenced Pistol
#define Deagle 24// - Desert Eagle
#define Shotgun 25// - Shotgun
#define Sawny 26// - Sawn Off Shotgun
#define Combat 27// - Combat Shotgun
#define Mac10 28// - Micro Uzi (Mac 10)
#define MP5 29// - MP5
#define AK 30// - AK47
#define M4 31// - M4
#define Tec9 32// - Tec9
#define Rifle 33// - Rifle
#define Sniper 34// - Sniper Rifle
#define RPG 35// - RPG
#define Missile 36// - Missile Launcher
#define Flame 37// - Flame Thrower
#define Minigun 38// - Minigun
#define Sachel 39// - Sachel Charges
#define Sacheld 40// - Detonator
#define Spray 41// - Spray Paint
#define Fireex 42// - Fire Extinguisher
#define Cam 43// - Camera
#define NV 44// - Nightvision Goggles
#define TG 45// - Thermal Goggles
#define Para 46// - Parachute

//vehicles
// every vehicle in SA (including crashy ones)

#define V_ADMIRAL 445
#define V_ALPHA 602
#define V_AMBULAN 416
#define V_ANDROM 592            // air
#define V_ARTICT1 435
#define V_ARTICT2 450
#define V_ARTICT3 591
#define V_AT400 577             // air
#define V_BAGBOXA 606
#define V_BAGBOXB 607
#define V_BAGGAGE 485
#define V_BANDITO 568
#define V_BANSHEE 429
#define V_BARRACKS 433
#define V_BEAGLE 511            // air
#define V_BENSON 499
#define V_BF400 581             // bike
#define V_BFINJECT 424
#define V_BIKE 509              // bike
#define V_BLADE 536
#define V_BLISTAC 496
#define V_BLOODRA 504
#define V_BMX 481               // bike
#define V_BOBCAT 422
#define V_BOXBURG 609
#define V_BOXVILLE 498
#define V_BRAVURA 401
#define V_BROADWAY 575
#define V_BUCCANEE 518
#define V_BUFFALO 402
#define V_BULLET 541
#define V_BURRITO 482
#define V_BUS 431
#define V_CABBIE 438
#define V_CADDY 457
#define V_CADRONA 527
#define V_CAMPER 483
#define V_CARGOBOB 548          // air
#define V_CEMENT 524
#define V_CHEETAH 415
#define V_CLOVER 542
#define V_CLUB 589
#define V_COACH 437
#define V_COASTG 472            // water
#define V_COMBINE 532
#define V_COMET 480
#define V_COPBIKE 523           // bike
#define V_COPCARLA 596
#define V_COPCARRU 599
#define V_COPCARSF 597
#define V_COPCARVG 598
#define V_CROPDUST 512          // air
#define V_DFT30 578
#define V_DINGHY 473            // water
#define V_DODO 593              // air
#define V_DOZER 486
#define V_DUMPER 406
#define V_DUNERIDE 573
#define V_ELEGANT 507
#define V_ELEGY 562
#define V_EMPEROR 585
#define V_ENFORCER 427
#define V_ESPERANT 419
#define V_EUROS 587
#define V_FAGGIO 462
#define V_FARMTR1 610
#define V_FBIRANCH 490
#define V_FBITRUCK 528
#define V_FCR900 521            // bike
#define V_FELTZER 533
#define V_FIRELA 544
#define V_FIRETRUK 407
#define V_FLASH 565
#define V_FLATBED 455
#define V_FORKLIFT 530
#define V_FORTUNE 526
#define V_FREEWAY 463           // bike
#define V_FREIBOX 590
#define V_FREIFLAT 569
#define V_FREIGHT 537
#define V_GLENDALE 466
#define V_GLENSHIT 604
#define V_GREENWOO 492
#define V_HERMES 474
#define V_HOTDOG 588
#define V_HOTKNIFE 434
#define V_HOTRINA 502
#define V_HOTRINB 503
#define V_HOTRING 494
#define V_HUNTER 425            // air
#define V_HUNTLEY 579
#define V_HUSTLER 545
#define V_HYDRA 520             // air
#define V_INFERNUS 411
#define V_INTRUDER 546
#define V_JESTER 559
#define V_JETMAX 493            // water
#define V_JOURNEY 508
#define V_KART 571
#define V_LANDSTAL 400
#define V_LAUNCH 595            // water
#define V_LEVIATHN 417          // air
#define V_LINERUN 403
#define V_MAJESTIC 517
#define V_MANANA 410
#define V_MARQUIS 484           // water
#define V_MAVERICK 487          // air
#define V_MERIT 551
#define V_MESA 500
#define V_MONSTER 444
#define V_MONSTERA 556
#define V_MONSTERB 557
#define V_MOONBEAM 418
#define V_MOWER 572
#define V_MRWHOOP 423
#define V_MTBIKE 510            // bike
#define V_MULE 414
#define V_NEBULA 516
#define V_NEVADA 553            // air
#define V_NEWSVAN 582
#define V_NRG500 522            // bike
#define V_OCEANIC 467
#define V_PACKER 443
#define V_PATRIOT 470
#define V_PCJ600 461            // bike
#define V_PEREN 404
#define V_PETRO 514
#define V_PETROTR 584
#define V_PHOENIX 603
#define V_PICADOR 600
#define V_PIZZABOY 448
#define V_POLMAV 497            // air
#define V_PONY 413
#define V_PREDATOR 430          // water
#define V_PREMIER 426
#define V_PREVION 436
#define V_PRIMO 547
#define V_QUAD 471              // bike
#define V_RAINDANC 563          // air
#define V_RANCHER 489
#define V_RCBANDIT 441
#define V_RCBARON 464           // air
#define V_RCCAM 594
#define V_RCGOBLIN 501          // air
#define V_RCRAIDER 465          // air
#define V_RCTIGER 564
#define V_RDTRAIN 515
#define V_REEFER 453            // water
#define V_REGINA 479
#define V_REMINGTN 534
#define V_RHINO 432
#define V_RNCHLURE 505
#define V_ROMERO 442
#define V_RUMPO 440
#define V_RUSTLER 476           // air
#define V_SABRE 475
#define V_SADLER 543
#define V_SADLSHIT 605
#define V_SANCHEZ 468           // bike
#define V_SANDKING 495
#define V_SAVANNA 567
#define V_SEASPAR 447           // air
#define V_SECURICA 428
#define V_SENTINEL 405
#define V_SHAMAL 519            // air
#define V_SKIMMER 460           // air
#define V_SLAMVAN 535
#define V_SOLAIR 458
#define V_SPARROW 469           // air
#define V_SPEEDER 452           // water
#define V_SQUALO 446            // water
#define V_STAFFORD 580
#define V_STALLION 439
#define V_STRATUM 561
#define V_STREAK 538
#define V_STREAKC 570
#define V_STRETCH 409
#define V_STUNT 513             // air
#define V_SULTAN 560
#define V_SUNRISE 550
#define V_SUPERGT 506
#define V_SWATVAN 601
#define V_SWEEPER 574
#define V_TAHOMA 566
#define V_TAMPA 549
#define V_TAXI 420
#define V_TOPFUN 459
#define V_TORNADO 576
#define V_TOWTRUCK 525
#define V_TRACTOR 531
#define V_TRAM 449
#define V_TRASH 408
#define V_TROPIC 454
#define V_TUG 583
#define V_TUGSTAIR 608
#define V_TURISMO 451
#define V_URANUS 558
#define V_UTILITY 552
#define V_UTILTR1 611
#define V_VCNMAV 488            // air
#define V_VINCENT 540
#define V_VIRGO 491
#define V_VOODOO 412
#define V_VORTEX 539            // hovercraft
#define V_WALTON 478
#define V_WASHING 421
#define V_WAYFARER 586          // bike
#define V_WILLARD 529
#define V_WINDSOR 555
#define V_YANKEE 456
#define V_YOSEMITE 554
#define V_ZR350 477
#define MAX_CARS 700

//checkpoints
#define SIGNUP 1
#define nil 0
	
//variables
new advert;
new game_loaded;
new gTeam[MAX_PLAYERS];
new loaded[MAX_PLAYERS];
new SavePlayerPos[SLOTS][SavePlayerPosEnum];
new gCurrentCheckpoint[MAX_PLAYERS];
new gCurrentGamePhase[MAX_PLAYERS];
new SpeedMode = 0; // 0 for KPH, 1 for MPH
new UpdateSeconds = 1;
new Phone[MAX_PLAYERS];
new playerCheckpoint[MAX_PLAYERS];
new pName[MAX_PLAYERS];
new Float:Pos[MAX_PLAYERS][4];
new Passport[MAX_PLAYERS];
new AntiSpam[MAX_PLAYERS][25];
new LastCheckpoint[MAX_PLAYERS];
new PlayerBank[MAX_PLAYERS];
new gPlayerid[MAX_PLAYERS];
new boxer2[MAX_PLAYERS];
new RequestingPassport[MAX_PLAYERS];
new gOwner[700];
new gLocked[700];
new Jailed[MAX_PLAYERS];
new JailLeft[MAX_PLAYERS];
new InArea[MAX_PLAYERS];
new Bribe[MAX_PLAYERS];
new BribeTo[MAX_PLAYERS];
new BribeFrom[MAX_PLAYERS];
new Sell[MAX_PLAYERS];
new SellTo[MAX_PLAYERS];
new SellFrom[MAX_PLAYERS];
new PlayerShop[MAX_PLAYERS];
new houseid[MAX_PLAYERS];
new Blocking[MAX_PLAYERS];
new SurrenderTimer[MAX_PLAYERS];
new SurrenderTimerCheck[MAX_PLAYERS];
new SurrenderedPlayer[MAX_PLAYERS];
new ToJailTimer[MAX_PLAYERS];
new PDChecks[MAX_PLAYERS];
new Component[MAX_VEHICLES][20];
/*
Component array slots:
0: Spoilers
1: Roof
2: Hood
3: Sideskirt
4: Nitro
5: Lamps
6: Exhaust
7: Wheels
8: Stereo
9: Hydraulics
10: Bullbar
11: Rear Bullbars
12: Front Bullbars
13: Front Bumper
14: Rear Bumper
15: Vents
16: Paintjob
17: Front Sign?
18: Color1
19: Color2
*/
new ProxHospital[MAX_PLAYERS];
new Float:ls1posx = 2031.9722;
new Float:ls1posy = -1408.3275;
new Float:ls1posz = 17.1641;
new Float:ls2posx = 1175.5439;
new Float:ls2posy = -1323.7344;
new Float:ls2posz = 14.3906;
new Float:lvposx = 1582.2657;
new Float:lvposy = 1768.9355;
new Float:lvposz = 10.8203;
new Float:sfposx = -2661.2332;
new Float:sfposy = 634.1244;
new Float:sfposz = 14.4531;
new PassportShown[MAX_PLAYERS];
new Benefits[MAX_PLAYERS];
new TaxiService[MAX_PLAYERS];
new TaxiCar[MAX_PLAYERS];
new TaxiPrice[MAX_PLAYERS];
new PizzaService[MAX_PLAYERS];
new PizzaBike[MAX_PLAYERS];
new PizzaPrice[MAX_PLAYERS];

new citizenls[MAX_PLAYERS];
new citizenlv[MAX_PLAYERS];
new citizensf[MAX_PLAYERS];
new bodyduty[MAX_PLAYERS];
new bodyowner[MAX_PLAYERS];
new bodyguard[MAX_PLAYERS][MAX_PLAYERS]; //bodyguard[playerid][bodyguard] = 1/0
new repairduty[MAX_PLAYERS];

new ToBeKicked[MAX_PLAYERS];
new AdminLevel[MAX_PLAYERS];
new Hitman[MAX_PLAYERS];
new Spawned[MAX_PLAYERS];
new PLAYERLIST_authed[MAX_PLAYERS];
new ForcedSpawn[MAX_PLAYERS];
new UnforcedSpawn[MAX_PLAYERS];
new JustRegistered[MAX_PLAYERS];
new BuyingCar[MAX_PLAYERS];
new TodayGotIn[700];

new MaxPickups;
new TodayCheck;

new CashGiven[MAX_PLAYERS];
new OldCash[MAX_PLAYERS];
new CheckOk[MAX_PLAYERS];

//new Text:Gang[100];
new CarPrice[210]; // +400 for vuehicle models


new Petrol[MAX_CARS];
new Float:checkCoords[MAX_POINTS][4] = {
{2098.1316,901.7380,2137.7456,963.0146},
{2617.5967,1062.8710,2656.6526,1142.5109},
{501.7475,1626.7821,653.2095,1774.1093},
{-1351.2833,2638.8943,-1265.1661,2738.6450},
{-2450.3767,949.5080,-2400.8530,1069.8329},
{-1715.5112,349.5567,-1658.8451,458.3686},
{-2265.3027,-2586.3762,-2219.1868,-2558.2539},
{-1657.4102,-2763.3518,-1501.5303,-2666.7454},
{1903.7450,-1795.7990,1955.5667,-1759.5187},
{-135.2077,-1199.8291,-43.7008,-1134.7999},
{1336.7378,454.7961,1430.0760,483.9776},
{648.2494,-592.9003,670.9278,-540.8264},
{-1494.2593,1854.1290,-1449.4076,1885.2032},
{2097.0452,2708.1218,2172.7161,2762.7495},
{2187.6587,2462.8057,2215.5042,2495.0332},
{1577.7729,2182.5112,1616.5842,2242.3628}
};

new Float:checkpoints[MAX_POINTS][4] = {
{2109.2126,917.5845,10.8203,5.0},
{2640.1831,1103.9224,10.8203,5.0},
{611.8934,1694.7921,6.7193,5.0},
{-1327.5398,2682.9771,49.7896,5.0},
{-2413.7427,975.9317,45.0031,5.0},
{-1672.3597,414.2950,6.8866,5.0},
{-2244.1365,-2560.6294,31.6276,5.0},
{-1603.0166,-2709.3589,48.2419,5.0},
{1939.3275,-1767.6813,13.2787,5.0},
{-94.7651,-1174.8079,1.9979,5.0},
{1381.6699,462.6467,19.8540,5.0},
{657.8167,-559.6507,16.0630,5.0},
{-1478.2916,1862.8318,32.3617,5.0},
{2147.3054,2744.9377,10.5263,5.0},
{2204.9602,2480.3494,10.5278,5.0},
{1590.9493,2202.2637,10.5247,5.0}
};

new checkpointType[MAX_POINTS] = {
CP_STATION1,
CP_STATION2,
CP_STATION3,
CP_STATION4,
CP_STATION5,
CP_STATION6,
CP_STATION7,
CP_STATION8,
CP_STATION9,
CP_STATION10,
CP_STATION11,
CP_STATION12,
CP_STATION13,
CP_STATION14,
CP_STATION15,
CP_STATION16
};

main()
{
	print("\n----------------------------------");
	print("  JTG AND ZAM SAB ROLEPLAY");
	print("----------------------------------\n");
}


forward PlayerName(playerid);
forward OnPlayerSelectClass(playerid, classid);
forward SetPlayerTeamFromClass(playerid,classid);
forward CheckFuel(playerid);
forward checkpointUpdate();
forward FuelRefill(playerid);
forward isPlayerInArea(playerID, Float:data[4]);
forward getCheckpointType(playerID);
forward OnPlayerEnterCheckpoint(playerid);
forward UpdateSpeed();
forward SendClientMessageForTeam(teamid, text_color, string_text[]);
forward WantedLevel(playerid, wanted_level_string[], reason[]);
forward Float:GetDistanceBetweenPlayers(p1,p2);
forward BorderControlNSF();
forward BorderControlESF();
forward Benefit();
forward Float:GetDistanceBetweenPlayers(p1,p2);
forward LottoAnnounce();
forward LottoAnnounce2();
forward LottoAnnounce3();
forward BorderControlLV();
forward JailArea();
forward WantedColor();
forward Jail();
forward Timer_DayHeartbeat();
forward Advert();
forward KickOut();
forward IsPlayerInGangZone(playerid,zoneid);
forward GetPlayerGangZone(playerid);
forward ShowGangOwner();
forward GetGangZoneOwnerID(zoneid);
forward Unfreeze(playerid);
forward ShowPDChecks(playerid);
forward NotJailed(playerid,criminalid);
forward ModCars(vehicleid);
forward CarModsSaving();
forward CarOwnUpdate();
forward BugFix(playerid);
forward CasinoKick(playerid);
forward GivePlayerMoneyEx(playerid,money,reason[]);
forward MoneyUpdate();
forward StartCheckingMoney(playerid);

public OnGameModeInit()
{
	print("GameModeInit()");
	SetGameModeText("Compton City RPG v0.9");
	CarPrice[0] = 29000;
	CarPrice[1] = 9000;
	CarPrice[2] = 29000;
	CarPrice[3] = 24000;
	CarPrice[4] = 8000;
	CarPrice[5] = 29000;
	CarPrice[6] = 31000;
	CarPrice[8] = 23000;
	CarPrice[9] = 37000;
	CarPrice[10] = 9999;
	CarPrice[11] = 89000;
	CarPrice[12] = 14000;
	CarPrice[13] = 15000;
	CarPrice[14] = 22000;
	CarPrice[15] = 93000;
	CarPrice[17] = 170000;
	CarPrice[18] = 14000;
	CarPrice[19] = 31000;
	CarPrice[20] = 26000;
	CarPrice[21] = 37000;
	CarPrice[22] = 18000;
	CarPrice[23] = 18000;
	CarPrice[24] = 9000;
	CarPrice[26] = 30000;
	CarPrice[29] = 39000;
	CarPrice[31] = 28000;
	CarPrice[34] = 68000;
	CarPrice[36] = 11000;
	CarPrice[37] = 30000;
	CarPrice[38] = 25000;
	CarPrice[39] = 15000;
	CarPrice[40] = 35000;
	CarPrice[42] = 26000;
	CarPrice[43] = 28000;
	CarPrice[44] = 27000;
	CarPrice[46] = 100000;
	CarPrice[47] = 150000;
	CarPrice[48] = 4000;
	CarPrice[51] = 72000;
	CarPrice[52] = 150000;
	CarPrice[53] = 160000;
	CarPrice[54] = 140000;
	CarPrice[55] = 29000;
	CarPrice[56] = 21000;
	CarPrice[57] = 7000;
	CarPrice[58] = 21000;
	CarPrice[60] = 112000;
	CarPrice[61] = 5500;
	CarPrice[62] = 4000;
	CarPrice[63] = 6000;
	CarPrice[66] = 20000;
	CarPrice[67] = 19000;
	CarPrice[68] = 6000;
	CarPrice[69] = 109000;
	CarPrice[70] = 35000;
	CarPrice[71] = 8000;
	CarPrice[72] = 90000;
	CarPrice[73] = 6000;
	CarPrice[74] = 41000;
	CarPrice[75] = 16000;
	CarPrice[76] = 97000;
	CarPrice[77] = 38000;
	CarPrice[78] = 15000;
	CarPrice[79] = 17000;
	CarPrice[80] = 122000;
	CarPrice[81] = 500;
	CarPrice[82] = 16000;
	CarPrice[83] = 20000;
	CarPrice[84] = 99000;
	CarPrice[85] = 11000;
	CarPrice[86] = 32000;
	CarPrice[87] = 99000;
	CarPrice[88] = 99000;
	CarPrice[89] = 35000;
	CarPrice[91] = 27000;
	CarPrice[92] = 16000;
	CarPrice[93] = 70000;
	CarPrice[94] = 79000;
	CarPrice[95] = 30000;
	CarPrice[96] = 30000;
	CarPrice[98] = 19000;
	CarPrice[99] = 21000;
	CarPrice[100] = 19000;
	CarPrice[102] = 79000;
	CarPrice[103] = 79000;
	CarPrice[104] = 9000;
	CarPrice[105] = 35000;
	CarPrice[106] = 93000;
	CarPrice[107] = 40000;
	CarPrice[108] = 20000;
	CarPrice[109] = 400;
	CarPrice[110] = 450;
	CarPrice[111] = 180000;
	CarPrice[112] = 100000;
	CarPrice[113] = 101000;
	CarPrice[114] = 27000;
	CarPrice[115] = 39000;
	CarPrice[116] = 10000;
	CarPrice[117] = 10000;
	CarPrice[118] = 29000;
	CarPrice[119] = 300000;
	CarPrice[121] = 6000;
	CarPrice[122] = 8000;
	CarPrice[124] = 25000;
	CarPrice[125] = 29000;
	CarPrice[126] = 27000;
	CarPrice[127] = 10000;
	CarPrice[129] = 14000;
	CarPrice[130] = 27000;
	CarPrice[131] = 23000;
	CarPrice[132] = 26000;
	CarPrice[133] = 29000;
	CarPrice[134] = 24000;
	CarPrice[135] = 14000;
	CarPrice[136] = 14000;
	CarPrice[139] = 15800;
	CarPrice[140] = 22000;
	CarPrice[141] = 74000;
	CarPrice[142] = 13000;
	CarPrice[143] = 21000;
	CarPrice[145] = 22000;
	CarPrice[146] = 19000;
	CarPrice[147] = 18000;
	CarPrice[148] = 160000;
	CarPrice[149] = 14000;
	CarPrice[150] = 24000;
	CarPrice[151] = 27000;
	CarPrice[152] = 19000;
	CarPrice[153] = 120000;
	CarPrice[154] = 27000;
	CarPrice[155] = 23000;
	CarPrice[156] = 27000;
	CarPrice[157] = 27000;
	CarPrice[158] = 25000;
	CarPrice[159] = 22000;
	CarPrice[160] = 30000;
	CarPrice[161] = 20000;
	CarPrice[162] = 21000;
	CarPrice[163] = 115000;
	CarPrice[165] = 22000;
	CarPrice[166] = 29000;
	CarPrice[167] = 120000;
	CarPrice[168] = 7000;
	CarPrice[171] = 4000;
	CarPrice[172] = 9000;
	CarPrice[173] = 34000;
	CarPrice[174] = 16000;
	CarPrice[175] = 23000;
	CarPrice[176] = 21000;
	CarPrice[177] = 700000;
	CarPrice[178] = 22000;
	CarPrice[179] = 40000;
	CarPrice[180] = 29000;
	CarPrice[181] = 6000;
	CarPrice[182] = 20000;
	CarPrice[183] = 13000;
	CarPrice[185] = 21000;
	CarPrice[186] = 6000;
	CarPrice[187] = 29000;
	CarPrice[188] = 18000;
	CarPrice[189] = 24000;
	CarPrice[193] = 98000;
	CarPrice[195] = 75000;
	CarPrice[200] = 25000;
	CarPrice[202] = 32000;
	CarPrice[203] = 28000;
	CarPrice[209] = 19000;
	EnableTirePopping(1);
	AllowInteriorWeapons(1);
	UsePlayerPedAnims();
	EnableStuntBonusForAll(0);
	AllowAdminTeleport(1);
	SetTimer("BorderControlNSF", 500, 1);
	SetTimer("BorderControlESF", 500, 1);
	SetTimer("BorderControlLV", 500, 1);
	SetTimer("Benefits",1440000, 1);
	SetTimer("WantedColor", 1000, 1);
	SetTimer("CheckFuel", TIME, 1);
   	SetTimer("checkpointUpdate", 1100, 1);
	SetTimer("UpdateSpeed", UpdateSeconds*1000, 1);
	SetTimer("JailArea", 1000, 1);
	SetTimer("Jail",1000,1);
	SetTimer("Timer_DayHeartbeat", 240000, 1);
	SetTimer("Advert", 600000, 1);
	SetTimer("ShowGangOwner",1500,1);
	SetTimer("CarModsSaving",3600000,1);
	SetTimer("CarOwnUpdate",1800000,1);
	SetTimer("MoneyUpdate",2000,1);
	SetTimer("CasinoKick",1000,1);
	game_loaded = 0;
	
	//TEAM_PILOT
	//AddPlayerClass(61, 2030.7517, -4476.2856, 2771.2636,270.3088,0,0,0,0,0,0); // PILOT SUIT 3
	
	//TEAM_POLICE
	AddPlayerClass(280, 2030.7517, -4476.2856, 2771.2636, 270.3088,Deagle,300,Night,1,0,0); // POLICE LS 3
	AddPlayerClass(281, 2030.7517, -4476.2856, 2771.2636, 270.3088,Deagle,300,Night,1,0,0); // POLICE SF 4
	AddPlayerClass(282, 2030.7517, -4476.2856, 2771.2636, 270.3088,Deagle,300,Night,1,0,0); // POLICE LV 5
	
	//TEAM_MEDIC
	AddPlayerClass(274, 2030.7517, -4476.2856, 2771.2636,270.3088,0,0,0,0,0,0); // Los Santos 6
	AddPlayerClass(276, 2030.7517, -4476.2856, 2771.2636,270.3088,0,0,0,0,0,0); // sf  7
	AddPlayerClass(275, 2030.7517, -4476.2856, 2771.2636,270.3088,0,0,0,0,0,0); // Lv 8
	
	//TEAM_FBI
	/*	
	AddPlayerClass(163, 2030.7517, -4476.2856, 2771.2636,270.3088,0,0,0,0,0,0); // FBI BLACK, BLUE JACKET 9
	AddPlayerClass(164, 2030.7517, -4476.2856, 2771.2636,270.3088,0,0,0,0,0,0); // FBI WHITE, BLUE JACKET 10
	AddPlayerClass(165, 2030.7517, -4476.2856, 2771.2636,270.3088,0,0,0,0,0,0); // FBI WHITE, BLACK JACKET 11
	AddPlayerClass(166, 2030.7517, -4476.2856, 2771.2636,270.3088,0,0,0,0,0,0); // FBI BLACK, BLACK JACKET 12
	*/
	
	//CITIZENSSSSSSSSS!!!!!!!!!!!
	AddPlayerClass(1, 2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0); // CITIZEN LS 0
	AddPlayerClass(47,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(48,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(49,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(50,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(51,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(52,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(53,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(54,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(55,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(56,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(57,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(58,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(59,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(60,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(62,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(63,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(64,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(66,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(67,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(68,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(69,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(70,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(71,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(72,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(73,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(75,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(76,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(78,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(79,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(80,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(81,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(82,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(83,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(84,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(85,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(87,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(88,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(89,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(91,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(92,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(93,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(95,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(96,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(97,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(98,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0);
	AddPlayerClass(99,2030.7517, -4476.2856, 2771.2636,270.3088,Bat,1,0,0,0,0); //58
	AddPlayerClass(2, 2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0); // 59
	AddPlayerClass(100,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(101,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(109,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(111,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(112,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(113,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(128,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(129,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(131,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(133,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(134,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(135,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(136,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(137,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(138,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(139,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(140,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(141,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(142,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(143,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(144,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(145,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(146,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(147,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(148,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(150,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(151,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(152,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(153,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(154,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(155,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(156,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(157,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(158,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(159,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(160,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(161,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(162,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(167,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(168,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(169,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(170,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(171,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(172,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(176,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(177,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(178,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(179,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(180,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(181,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(182,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(183,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(184,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(185,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(186,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(187,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(188,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(189,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(190,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(191,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(192,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(193,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(194,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(195,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(196,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(197,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(198,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(199,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);
	AddPlayerClass(200,2030.7517, -4476.2856, 2771.2636,270.3088,Brass,1,0,0,0,0);//127
	AddPlayerClass(201,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(202,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(203,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(204,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(205,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(206,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(207,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(209,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(210,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(211,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(212,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(213,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(214,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(215,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(216,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(217,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(218,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(219,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(220,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(221,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(222,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(223,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(224,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(225,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(226,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(227,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(228,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(229,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(230,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(231,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(232,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(233,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(234,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(235,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(236,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(237,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(238,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(239,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(240,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(241,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(242,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(243,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(244,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(245,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(246,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(247,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(248,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(249,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(250,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(251,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(287,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(254,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0);
	AddPlayerClass(255,2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0); //185
	AddPlayerClass(7, 2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0); // 186
	AddPlayerClass(34, 2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0); // 187
	AddPlayerClass(115, 2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0); // 188
	AddPlayerClass(21, 2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0); // 189
	AddPlayerClass(122, 2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0); // 190
	AddPlayerClass(195, 2030.7517, -4476.2856, 2771.2636,270.3088,Shovel,1,0,0,0,0); // 191
	
	//president vehicles
	AddStaticVehicle(559,2033.6816,1917.2129,11.9606,359.6565,3,3); // jester
	AddStaticVehicle(409,-2724.7810,-311.7671,7.0391,132.9572,0,0); // limo
	AddStaticVehicle(409,1254.4720,-807.0923,84.1406,173.4364,0,0); // limo

//AMBULANCES
    AddStaticVehicle(416,-2628.4658,609.6610,14.4531,181.3213,6,1); // ambulance
	AddStaticVehicle(416,-2638.4553,609.6877,14.4531,180.3813,6,1); // ambulance
	AddStaticVehicle(416,-2650.1968,609.2388,14.4531,175.0546,6,1); // ambulance
	AddStaticVehicle(416,-2664.2571,609.8100,14.4545,177.8746,6,1); // ambulance
	AddStaticVehicle(416,-2676.8689,609.3666,14.4531,171.2946,6,1); // ambulance
	AddStaticVehicle(416,1190.9832,-1316.5328,13.3984,175.0780,6,1); // ambulance
	AddStaticVehicle(416,1190.8375,-1332.1410,13.3984,166.6179,6,1); // ambulance

//TAXIS
    AddStaticVehicle(420,1732.7562,-2323.0740,13.1596,269.8002,6,1); // taxi
	AddStaticVehicle(420,1682.6042,-2322.8972,13.1616,269.7996,6,1); // taxi
	AddStaticVehicle(420,1658.8635,-2322.8140,13.1617,269.7994,6,1); // taxi
	AddStaticVehicle(420,1633.4462,-2322.7246,13.1616,269.7992,6,1); // taxi
	AddStaticVehicle(420,2120.4099,1899.5658,10.4506,178.3232,6,1); // taxi
	AddStaticVehicle(420,1720.9738,1488.6548,10.5201,343.1777,6,1); // taxi
	AddStaticVehicle(420,1725.0889,1504.9924,10.5193,345.1488,6,1); // taxi
	AddStaticVehicle(420,1712.5726,1462.3970,10.5328,160.5919,6,1); // taxi
	AddStaticVehicle(420,1707.0017,1439.5874,10.4730,181.3640,6,1); // taxi
	AddStaticVehicle(420,1709.6671,1409.5887,10.3454,189.5085,6,1); // taxi
	AddStaticVehicle(420,1713.1841,1394.6287,10.3472,196.4065,6,1); // taxi
	AddStaticVehicle(420,974.6000,-1106.2140,23.4440,56.1713,-1,-1);//car taxi
	AddStaticVehicle(420,1713.9504,-2323.2983,12.9492,273.7584,-1,-1);//car taxi
	AddStaticVehicle(420,2580.5320,2267.9595,10.3917,271.2372,-1,-1);//car taxi
	AddStaticVehicle(420,661.7609,1720.9894,6.5641,19.1231,-1,-1);//car taxi
	AddStaticVehicle(420,1713.9319,1467.8354,10.5219,342.8006,-1,-1);//car taxi
	AddStaticVehicle(420,-2040.4465,1107.7076,54.4032,89.8491,-1,-1);//car taxi
	AddStaticVehicle(420,-1425.8613,-294.0004,13.5707,54.8251,-1,-1);//car taxi
	
//extras
	AddStaticVehicle(596,613.2108,-601.1264,17.2330,268.1675,-1,-1);//cop car
	AddStaticVehicle(596,612.9854,-596.7340,17.2330,268.1675,-1,-1);//cop car
	AddStaticVehicle(596,637.4579,-560.8829,16.1875,179.4933,-1,-1);//cop car
	AddStaticVehicle(416,2032.7850,-1416.2977,16.6169,310.8558,58,8); // ambulance
	//AddStaticVehicle(416,1615.8806,1821.0323,10.5555,92.0870,0,0); // ambulance
	//AddStaticVehicle(416,1605.0486,1820.6406,10.6241,92.1011,0,0); // ambulance
	//AddStaticVehicle(416,1592.1168,1818.6781,10.5753,0.0997,0,0); // ambulance
	//AddStaticVehicle(416,1622.9000,1818.3044,10.5591,180.9814,0,0); // ambulance
	
	AddStaticVehicle(560,-1936.7770,274.4093,40.7533,180.4098,0,0);//EAZY CAR 33
	AddStaticVehicle(451,-1928.3419,273.4841,40.7532,181.7336,0,0); //EAZY CAR 34
	AddStaticVehicle(562,-2033.8175,178.6203,28.5494,268.7048,0,0); //worfox car 35
	
//LS 84 vehicles
	AddStaticVehicle(567,2508.2312,-1666.4536,13.1796,11.6929,-1,-1);
 	AddStaticVehicle(534,2473.1646,-1697.4138,13.2988,1.1746,-1,-1);
	AddStaticVehicle(482,2297.2532,-1633.3859,14.4298,269.4626,-1,-1);
	AddStaticVehicle(474,2158.4851,-1808.1165,13.4877,359.4795,-1,-1);
	AddStaticVehicle(562,2119.6868,-1782.6039,13.2567,179.7940,-1,-1);
	AddStaticVehicle(411,2069.0737,-1881.9088,13.1172,269.2706,-1,-1);
	AddStaticVehicle(603,2529.3069,-2003.3335,13.0598,133.2911,-1,-1);
	AddStaticVehicle(507,2498.8933,-1953.5988,13.3193,359.7628,-1,-1);
	AddStaticVehicle(439,2728.9031,-1935.3430,13.2556,90.0094,-1,-1);
	AddStaticVehicle(560,2854.1719,-1909.5021,10.5896,179.5905,-1,-1);
	AddStaticVehicle(477,2822.0244,-1553.3268,10.6042,89.4986,-1,-1);
	AddStaticVehicle(549,2742.9841,-1463.0424,30.2372,359.1269,-1,-1);
	AddStaticVehicle(475,2791.5891,-1284.7643,42.8108,178.8319,-1,-1);
	AddStaticVehicle(522,2806.3848,-1186.9303,25.0279,307.7415,-1,-1);
	AddStaticVehicle(451,2752.6775,-1177.2931,69.2420,89.6505,-1,-1);
	AddStaticVehicle(534,2322.5037,-1159.1552,26.7191,266.7604,-1,-1);
	AddStaticVehicle(567,2506.4182,-1287.6383,34.5474,178.1351,-1,-1);
	AddStaticVehicle(558,2432.1082,-1224.7516,24.8794,356.5074,-1,-1);
	AddStaticVehicle(480,2391.1511,-1497.3237,23.6727,89.4172,-1,-1);
	AddStaticVehicle(533,2489.6265,-1558.6204,23.5562,359.5309,-1,-1);
	AddStaticVehicle(470,2473.1877,-1545.3008,23.4819,181.2033,-1,-1);
	AddStaticVehicle(404,2106.5850,-1364.1143,23.8393,0.3906,-1,-1);
	AddStaticVehicle(580,2229.1389,-1363.6033,23.8190,89.8660,-1,-1);
	AddStaticVehicle(415,2235.8062,-1262.7324,23.4519,285.3175,-1,-1);
	AddStaticVehicle(542,2148.6777,-1138.4310,25.2664,270.0773,-1,-1);
	AddStaticVehicle(487,2148.7661,-1199.0145,23.4831,89.3399,-1,-1);//maverick chopper
	AddStaticVehicle(496,2031.4387,-1141.1813,24.3093,269.8185,-1,-1);
	AddStaticVehicle(445,1803.7166,-1931.8333,13.1109,359.8419,-1,-1);
	AddStaticVehicle(555,1779.4896,-1887.1788,13.2558,268.6338,-1,-1);
	AddStaticVehicle(535,1904.1558,-2047.0872,13.2997,90.4966,-1,-1);
	AddStaticVehicle(559,2757.5005,-2388.5466,13.6266,179.3206,-1,-1);
	AddStaticVehicle(579,2763.6816,-2510.6714,13.6339,0.0716,-1,-1);
	AddStaticVehicle(587,2488.0601,-2242.5610,13.4219,358.8076,-1,-1);
	AddStaticVehicle(491,2192.6189,-2247.0283,13.2067,222.6344,-1,-1);
	AddStaticVehicle(534,1981.1094,-1985.5371,13.2902,359.5516,-1,-1);
	AddStaticVehicle(405,1924.2258,-2122.6487,13.3471,359.0740,-1,-1);
	AddStaticVehicle(487,1972.9603,-2345.6387,13.7229,49.2012,-1,-1);//maverick chopper
	AddStaticVehicle(487,1974.8606,-2312.5300,13.7203,47.3370,-1,-1);//maverick chopper
	AddStaticVehicle(593,1960.2064,-2647.5012,14.0086,0.6559,-1,-1);//dodo plane
	AddStaticVehicle(519,1468.4178,-2436.6125,13.1128,244.4017,-1,-1);//shamal plane
	AddStaticVehicle(489,2657.2908,-1691.8491,9.0838,269.6595,-1,-1);
	AddStaticVehicle(585,1731.0698,-1008.6317,23.6590,347.0643,-1,-1);
	AddStaticVehicle(565,1713.7269,-1069.0457,23.5859,179.0714,-1,-1);
	AddStaticVehicle(602,1947.5813,-1376.5216,18.0939,57.1534,-1,-1);
	AddStaticVehicle(541,1974.1716,-1448.2616,13.0208,54.7374,-1,-1);
	AddStaticVehicle(402,1623.8126,-1858.7850,13.3271,180.6303,-1,-1);
	AddStaticVehicle(482,1646.7180,-1597.9443,13.1843,269.8346,-1,-1);
	AddStaticVehicle(596,1535.9027,-1673.6801,13.1024,0.9604,-1,-1);//cop car
	AddStaticVehicle(596,1585.8513,-1667.6764,5.6129,270.8032,-1,-1);//cop car
	AddStaticVehicle(507,1460.4645,-1506.9532,13.4812,87.2633,-1,-1);
	AddStaticVehicle(562,1333.5404,-1081.1383,24.8731,269.0622,-1,-1);
	AddStaticVehicle(411,1065.3420,-1221.7240,16.5594,0.1669,-1,-1);
	AddStaticVehicle(555,1146.9253,-1313.1802,14.0365,0.3839,-1,-1);
	AddStaticVehicle(400,867.5660,-1282.5898,14.8665,0.5736,-1,-1);
	AddStaticVehicle(603,840.1666,-1391.3821,13.2792,92.0202,-1,-1);
	AddStaticVehicle(507,1450.4374,-930.1359,36.6003,173.5922,-1,-1);
	AddStaticVehicle(487,1291.1396,-787.5708,96.6350,179.5610,-1,-1);//maverick chopper
	AddStaticVehicle(439,1351.2683,-621.1136,108.9058,19.9575,-1,-1);
	AddStaticVehicle(560,1363.1368,-1354.7874,13.2996,357.4546,-1,-1);
	AddStaticVehicle(477,685.3112,-1072.3215,49.2644,60.1660,-1,-1);
	AddStaticVehicle(549,283.8333,-1161.1090,80.7880,223.3897,-1,-1);
	AddStaticVehicle(475,405.2888,-1262.5371,50.5532,22.5417,-1,-1);
	AddStaticVehicle(506,782.5436,-1633.8582,13.1803,269.1530,-1,-1);
	AddStaticVehicle(451,1357.6841,-1748.9628,13.0077,89.7186,-1,-1);
	AddStaticVehicle(480,660.3052,-1678.1238,14.1770,266.8718,-1,-1);
	AddStaticVehicle(533,1034.0940,-2042.7858,12.8263,167.7733,-1,-1);
	AddStaticVehicle(470,331.0582,-1883.9817,1.5477,134.3129,-1,-1);
	AddStaticVehicle(580,441.8103,-1303.0439,14.7358,245.0446,-1,-1);
	AddStaticVehicle(415,1246.0278,-2011.6395,59.6959,0.9539,-1,-1);
	AddStaticVehicle(542,1276.6846,-2010.6200,58.6758,178.7380,-1,-1);
	AddStaticVehicle(496,1271.2167,-2042.6799,59.0398,1.4495,-1,-1);
	AddStaticVehicle(522,545.3229,-1477.2467,14.4734,1.8863,-1,-1);
	AddStaticVehicle(555,1240.9360,-1566.8942,13.3638,87.8000,-1,-1);
	AddStaticVehicle(535,582.2130,-1885.4453,3.8559,220.5502,-1,-1);
	AddStaticVehicle(559,362.5190,-1641.1151,32.5754,83.0536,-1,-1);
	AddStaticVehicle(579,2088.4944,-2089.7324,14.1534,180.1658,-1,-1);
	AddStaticVehicle(587,166.3514,-1341.6031,69.3802,178.2354,-1,-1);
	AddStaticVehicle(491,797.0284,-843.6050,60.4141,191.0260,-1,-1);
	AddStaticVehicle(550,133.5142,-1489.0701,18.4300,58.3215,-1,-1);
	AddStaticVehicle(523,1560.7695,-1694.4358,5.6122,32.7235,-1,-1);//cop bike
	AddStaticVehicle(523,1563.5020,-1694.8240,5.4627,21.6809,-1,-1);//cop bike
	AddStaticVehicle(565,2489.3066,-2605.5688,13.3711,0.4802,-1,-1);
	AddStaticVehicle(596,1570.5022,-1710.5771,5.6091,179.8262,-1,-1);//cop car
	AddStaticVehicle(401,-2118.9319,194.8274,35.7567,2.7513,-1,-1);//new

	//LV 83 vehicles
	AddStaticVehicle(545,1470.0836,2775.8386,10.6719,179.7780,0,0);
	AddStaticVehicle(545,2076.2224,1324.8663,10.6719,190.7448,0,0);
	AddStaticVehicle(567,2040.0520,1319.2799,10.3779,183.2439,-1,-1);
	AddStaticVehicle(558,2040.5247,1359.2783,10.3516,177.1306,-1,-1);
	AddStaticVehicle(602,2110.4102,1398.3672,10.7552,359.5964,-1,-1);
	AddStaticVehicle(541,2075.6038,1666.9750,10.4252,359.7507,-1,-1);
	AddStaticVehicle(402,2119.5845,1938.5969,10.2967,181.9064,-1,-1);
	AddStaticVehicle(482,1944.1003,1344.7717,8.9411,0.8168,-1,-1);
	AddStaticVehicle(562,2172.1682,1988.8643,10.5474,89.9151,-1,-1);
	AddStaticVehicle(411,2245.5759,2042.4166,10.5000,270.7350,-1,-1);
	AddStaticVehicle(400,2361.1538,1993.9761,10.4260,178.3929,-1,-1);
	AddStaticVehicle(603,2221.9946,1998.7787,9.6815,92.6188,-1,-1);
	AddStaticVehicle(507,2602.7769,1853.0667,10.5468,91.4813,-1,-1);
	AddStaticVehicle(439,2610.7600,1694.2588,10.6585,89.3303,-1,-1);
	AddStaticVehicle(560,2635.2419,1075.7726,10.5472,89.9571,-1,-1);
	AddStaticVehicle(477,2394.1021,989.4888,10.4806,89.5080,-1,-1);
	AddStaticVehicle(411,2039.1257,1545.0879,10.3481,359.6690,-1,-1);
	AddStaticVehicle(475,2009.8782,2411.7524,10.5828,178.9618,-1,-1);
	AddStaticVehicle(506,2076.4033,2468.7947,10.5923,359.9186,-1,-1);
	AddStaticVehicle(451,1919.5863,2760.7595,10.5079,100.0753,-1,-1);
	AddStaticVehicle(415,1673.8038,2693.8044,10.5912,359.7903,-1,-1);
	AddStaticVehicle(480,1591.0482,2746.3982,10.6519,172.5125,-1,-1);
	AddStaticVehicle(533,1455.9305,2878.5288,10.5837,181.0987,-1,-1);
	AddStaticVehicle(470,1537.8425,2578.0525,10.5662,0.0650,-1,-1);
	AddStaticVehicle(404,1433.1594,2607.3762,10.3781,88.0013,-1,-1);
	AddStaticVehicle(580,2223.5898,1288.1464,10.5104,182.0297,-1,-1);
	AddStaticVehicle(415,2461.8162,1629.2268,10.4496,181.4625,-1,-1);
	AddStaticVehicle(542,2395.7554,1658.9591,10.5740,359.7374,-1,-1);
	AddStaticVehicle(496,1553.3696,1020.2884,10.5532,270.6825,-1,-1);
	AddStaticVehicle(445,1383.4630,1035.0420,10.9131,91.2515,-1,-1);
	AddStaticVehicle(555,1445.4526,974.2831,10.5534,1.6213,-1,-1);
	AddStaticVehicle(535,1658.5463,1028.5432,10.5533,359.8419,-1,-1);
	AddStaticVehicle(559,1383.6959,1042.2114,10.4121,85.7269,-1,-1);
	AddStaticVehicle(579,1064.2332,1215.4158,10.4157,177.2942,-1,-1);
	AddStaticVehicle(522,1111.4536,1788.3893,10.4158,92.4627,-1,-1);
	AddStaticVehicle(550,1439.5662,1999.9822,10.5843,0.4194,-1,-1);
	AddStaticVehicle(405,2156.3540,2188.6572,10.2414,22.6504,-1,-1);
	AddStaticVehicle(598,2256.2891,2458.5110,10.5680,358.7335,-1,-1);//cop car
	AddStaticVehicle(598,2251.6921,2477.0205,10.5671,179.5244,-1,-1);//cop car
	AddStaticVehicle(523,2290.7268,2441.3323,10.3944,16.4594,-1,-1);//cop bike
	AddStaticVehicle(523,2295.5503,2455.9656,2.8444,272.6913,-1,-1);//cop bike
	AddStaticVehicle(489,2827.4143,2345.6953,10.5768,270.0668,-1,-1);
	AddStaticVehicle(585,1670.1089,1297.8322,10.3864,359.4936,-1,-1);
	AddStaticVehicle(487,1614.7153,1548.7513,11.2749,347.1516,-1,-1);//maverick chopper
	AddStaticVehicle(593,1283.5107,1361.3171,9.5382,271.1684,-1,-1);//dodo plane
	AddStaticVehicle(593,1283.6847,1386.5137,11.5300,272.1003,-1,-1);//dodo plane
	AddStaticVehicle(565,1319.1038,1279.1791,10.5931,0.9661,-1,-1);
	AddStaticVehicle(534,2805.1650,2027.0028,10.3920,357.5978,-1,-1);
	AddStaticVehicle(567,2822.3628,2240.3594,10.5812,89.7540,-1,-1);
	AddStaticVehicle(558,2842.0554,2637.0105,10.5000,182.2949,-1,-1);
	AddStaticVehicle(602,2327.6484,2787.7327,10.5174,179.5639,-1,-1);
	AddStaticVehicle(541,2104.9446,2658.1331,10.3834,82.2700,-1,-1);
	AddStaticVehicle(402,1914.2322,2148.2590,10.3906,267.7297,-1,-1);
	AddStaticVehicle(482,1904.7527,2157.4312,10.5175,183.7728,-1,-1);
	AddStaticVehicle(507,1532.6139,2258.0173,10.5176,359.1516,-1,-1);
	AddStaticVehicle(562,1552.1292,2341.7854,10.9126,274.0815,-1,-1);
	AddStaticVehicle(411,1637.6285,2329.8774,10.5538,89.6408,-1,-1);
	AddStaticVehicle(400,1357.4165,2259.7158,10.9126,269.5567,-1,-1);
	AddStaticVehicle(603,1305.5295,2528.3076,10.3955,88.7249,-1,-1);
	AddStaticVehicle(507,993.9020,2159.4194,10.3905,88.8805,-1,-1);
	AddStaticVehicle(522,2299.5872,1469.7910,10.3815,258.4984,-1,-1);
	AddStaticVehicle(439,2404.6636,647.9255,10.7919,183.7688,-1,-1);
	AddStaticVehicle(560,2628.1047,746.8704,10.5246,352.7574,-1,-1);
	AddStaticVehicle(477,2817.6445,928.3469,10.4470,359.5235,-1,-1);
	AddStaticVehicle(549,660.0554,1719.1187,6.5642,12.7699,-1,-1);
	AddStaticVehicle(475,1031.8435,1920.3726,11.3369,89.4978,-1,-1);
	AddStaticVehicle(506,1641.6802,1299.2113,10.6869,271.4891,-1,-1);
	AddStaticVehicle(451,2135.8757,1408.4512,10.6867,180.4562,-1,-1);
	AddStaticVehicle(480,2461.7380,1345.5385,10.6975,0.9317,-1,-1);
	AddStaticVehicle(533,2804.4365,1332.5348,10.6283,271.7682,-1,-1);
	AddStaticVehicle(470,2805.1685,1361.4004,10.4548,270.2340,-1,-1);
	AddStaticVehicle(451,2119.9751,2049.3127,10.5423,180.1963,-1,-1);
	AddStaticVehicle(580,2785.0261,-1835.0374,9.6874,226.9852,-1,-1);
	AddStaticVehicle(415,2038.1359,1009.4887,10.2686,178.2425,-1,-1);
	AddStaticVehicle(542,2142.2698,1019.3512,10.4130,91.3079,-1,-1);
	AddStaticVehicle(496,2075.0247,1149.5356,10.2645,2.6380,-1,-1);
	AddStaticVehicle(445,2132.7168,1028.6659,10.4175,275.6147,-1,-1);
	AddStaticVehicle(555,2004.5626,740.4858,10.6432,183.2937,-1,-1);
	AddStaticVehicle(535,1654.2909,730.8658,10.4145,5.3444,-1,-1);
	AddStaticVehicle(519,1323.9281,1573.8071,10.3853,271.3071,-1,-1);//shamal plane
	AddStaticVehicle(549,1613.1553,2200.2664,10.5176,89.6204,89,35);
	AddStaticVehicle(400,1552.1292,2341.7854,10.9126,274.0815,101,1);
	AddStaticVehicle(404,1637.6285,2329.8774,10.5538,89.6408,101,101);
	AddStaticVehicle(400,1357.4165,2259.7158,10.9126,269.5567,62,1);
	AddStaticVehicle(411,1281.7458,2571.6719,10.5472,270.6128,106,1);
	AddStaticVehicle(522,1305.5295,2528.3076,10.3955,88.7249,3,8);
	AddStaticVehicle(521,993.9020,2159.4194,10.3905,88.8805,74,74);
	AddStaticVehicle(415,1512.7134,787.6931,10.5921,359.5796,75,1);
	AddStaticVehicle(522,2299.5872,1469.7910,10.3815,258.4984,3,8);
	AddStaticVehicle(522,2133.6428,1012.8537,10.3789,87.1290,3,8);

 //SF
 	AddStaticVehicle(449,-2006.5890,154.2374,27.5020,0.2065,12,12); // tram
	AddStaticVehicle(587,-2652.9031,-297.2605,8.0617,315.6009,-1,-1);
	AddStaticVehicle(491,-2618.9480,1376.7870,7.7322,181.1998,-1,-1);
	AddStaticVehicle(550,-2645.5964,1376.7522,7.8935,267.8349,-1,-1);
	AddStaticVehicle(405,-2126.2573,650.7344,53.2421,88.8335,-1,-1);
	AddStaticVehicle(522,-2185.4792,-209.3301,36.0807,268.0485,-1,-1);
	AddStaticVehicle(565,-2517.2996,1229.3512,38.7999,209.3221,-1,-1);
	AddStaticVehicle(534,-1654.1005,1211.9901,14.2380,315.9562,-1,-1);
	AddStaticVehicle(477,-1660.4161,1213.3704,8.0209,295.4768,-1,-1);
	AddStaticVehicle(558,-1497.4607,845.8477,7.9671,88.5197,-1,-1);
	AddStaticVehicle(602,-1699.4597,1035.9624,46.0932,91.6588,-1,-1);
	AddStaticVehicle(541,-1786.6871,1206.5266,25.7813,178.8742,-1,-1);
	AddStaticVehicle(482,-2438.0117,1340.9783,8.7316,86.7979,-1,-1);
	AddStaticVehicle(507,-2166.5498,1251.0760,28.2782,1.6030,-1,-1);
	AddStaticVehicle(562,-2636.3838,932.3286,72.5378,187.1212,-1,-1);
	AddStaticVehicle(411,-2464.8860,896.7036,63.6223,0.6326,-1,-1);
	AddStaticVehicle(400,-2459.9055,786.4501,36.2643,89.8722,-1,-1);
	AddStaticVehicle(603,-2673.5830,802.1517,51.0693,0.3607,-1,-1);
	AddStaticVehicle(507,-2970.6746,497.2838,1.3557,4.0073,-1,1);
	AddStaticVehicle(439,-2902.7820,342.5712,6.3723,138.7612,-1,-1);
	AddStaticVehicle(477,-1382.4279,455.8060,7.1838,359.9849,-1,-1);
	AddStaticVehicle(549,-1465.0304,455.6730,7.9280,358.9676,-1,-1);
	AddStaticVehicle(519,-1387.8518,-484.0513,15.6341,247.9289,-1,-1);//shamal plane
	AddStaticVehicle(519,-1317.8910,-260.4665,16.4827,288.2876,-1,-1);//shamal plane
	AddStaticVehicle(593,-1362.9397,-183.5522,16.4848,308.6994,-1,-1);//dodo plane
	AddStaticVehicle(487,-1222.7996,-10.4235,15.1594,45.5780,-1,-1);//maverick chopper
	AddStaticVehicle(475,-1872.5575,-820.7949,32.8273,90.7921,-1,-1);
	AddStaticVehicle(506,-1898.3019,-915.5814,33.3947,91.2857,-1,-1);
	AddStaticVehicle(451,-2124.4800,-929.0856,32.7397,269.1853,-1,-1);
	AddStaticVehicle(480,-2134.1428,-453.9576,36.1699,95.0875,-1,-1);
	AddStaticVehicle(533,-2035.6851,170.2529,29.4610,268.9087,-1,-1);
	AddStaticVehicle(470,-2352.0959,-126.8848,35.9374,179.5324,-1,-1);
	AddStaticVehicle(404,-2180.1277,41.8536,36.1953,269.9865,-1,-1);
	AddStaticVehicle(580,-2269.4526,69.5823,35.7279,89.6104,-1,-1);
	AddStaticVehicle(415,-2129.2864,787.6249,70.3666,87.1679,-1,-1);
	AddStaticVehicle(542,-2424.9958,740.8871,35.8205,177.6701,-1,-1);
	AddStaticVehicle(496,-2545.7666,627.5895,15.1684,89.1952,-1,-1);
	AddStaticVehicle(445,-2498.4822,357.5526,35.7969,58.0823,-1,-1);
	AddStaticVehicle(555,-2664.9673,268.9968,5.0156,357.6026,-1,-1);
	AddStaticVehicle(522,-2626.5276,-53.6779,5.1144,357.7703,-1,-1);
	AddStaticVehicle(559,-2487.5295,-125.3075,26.5715,90.9363,-1,-1);
	AddStaticVehicle(579,-2486.0298,51.5018,27.7954,177.2178,-1,-1);
	AddStaticVehicle(587,-2574.9736,146.5981,5.4279,1.8790,-1,-1);
	AddStaticVehicle(491,-1741.0009,811.0599,25.5879,270.6703,-1,-1);
	AddStaticVehicle(550,-1920.7559,875.2713,36.1113,270.0973,-1,-1);
	AddStaticVehicle(405,-1968.8488,465.6065,36.2766,89.3124,-1,-1);
	AddStaticVehicle(489,-1825.2035,-0.4858,15.8965,270.0104,-1,-1);
	AddStaticVehicle(585,-1687.9076,1003.5587,18.2656,91.3972,-1,-1);
	AddStaticVehicle(534,-2782.3508,442.1533,5.5383,57.1401,-1,-1);
	AddStaticVehicle(567,-2836.3665,865.6495,44.1470,268.7662,-1,-1);
	AddStaticVehicle(558,-2899.3823,1112.4786,27.3954,268.9744,-1,-1);
	AddStaticVehicle(602,-2618.7363,627.2617,15.6024,179.6464,-1,-1);
	AddStaticVehicle(541,-2151.4924,428.9210,35.1902,176.6156,-1,-1);
	AddStaticVehicle(482,-2641.7395,1333.0645,6.8700,356.7557,-1,-1);
	AddStaticVehicle(507,-2129.8242,288.0418,34.9864,269.9582,-1,-1);
	AddStaticVehicle(562,-2664.0950,-259.9579,6.5482,74.4868,-1,-1);
	AddStaticVehicle(597,-1594.2644,672.5858,6.9564,176.7420,-1,-1);//cop car
	AddStaticVehicle(597,-1622.6423,651.3411,6.9558,179.1608,-1,-1);//cop car
	AddStaticVehicle(597,-1584.1769,749.3150,-5.4735,1.1909,-1,-1);//cop car
	AddStaticVehicle(411,-1231.5951,48.1695,13.7616,229.8069,-1,-1);
	AddStaticVehicle(400,-2147.9944,-406.9189,35.0502,43.5458,-1,-1);
	AddStaticVehicle(415,-2899.2644,1112.4993,26.5128,270.6545,-1,-1);
	AddStaticVehicle(559,-1852.7903,569.7672,34.9839,223.2814,-1,-1);
	AddStaticVehicle(602,-1579.2169,-458.4026,5.8769,134.5858,45,45); // citizen car
	AddStaticVehicle(602,-1570.3376,-462.0815,5.8765,311.6636,45,45); // citizen car
	AddStaticVehicle(451,165.5638,1191.1415,14.4648,171.9380,61,61); // Fort Carson- Cluckin Bell
	AddStaticVehicle(401,40.2847,1217.0702,18.8835,181.3407,74,74); // Fort Carson
	AddStaticVehicle(402,-158.7215,1228.2052,19.5738,94.4737,30,30); // Fort Carson- King Ring
	AddStaticVehicle(489,-243.6429,1077.1917,19.9015,1.3117,14,123); // Fort Carson- House
	AddStaticVehicle(411,-369.3739,1126.7646,19.4865,269.9147,123,1); // Fort Carson - Second House
	AddStaticVehicle(463,-326.7578,1515.3719,74.8876,179.2780,22,22); // The Big Ear - Bike
	AddStaticVehicle(463,-336.2500,1515.6259,74.8854,178.5937,19,19); // The Big Ear - Bike
	AddStaticVehicle(510,-383.8246,1701.6615,44.5342,352.4393,46,46); // The Big Ear - Mountain Bike
	AddStaticVehicle(419,-457.4688,1959.2695,82.9075,320.9339,13,76); // The Sherman Dam
	AddStaticVehicle(445,-904.8649,2014.6755,60.7891,310.6214,39,39); // The Sherman Dam
	AddStaticVehicle(489,-1196.2446,1818.3755,41.8309,29.5351,14,123); // Tierra Robada- Cluckin Bell
	AddStaticVehicle(419,-1221.0497,1683.6237,19.6922,58.9579,2,76); // Tierra Robada - Highway
	AddStaticVehicle(421,-679.3565,965.7938,12.0153,89.5727,30,1); // Tierra Robada - Mansion
	AddStaticVehicle(496,158.4271,677.0460,5.4561,300.7426,22,22); // Bone County - Highway
	AddStaticVehicle(496,680.9387,1945.9789,5.2549,181.7994,22,22); // Bone County - The Big Spread Ranch
	AddStaticVehicle(547,498.6548,2383.3503,29.5508,336.1638,10,1); // Verdant Meadows
	AddStaticVehicle(468,506.7159,2380.2195,29.8050,143.4463,3,3); // Verdant Meadows - Bike
	AddStaticVehicle(468,-358.2963,2517.3064,36.4630,153.9640,3,3); // El Castillo Del Diablo - Bike
	AddStaticVehicle(511,410.3713,2505.2729,17.8598,92.5015,37,51); // Verdant Meadows - Plane Beagle
	AddStaticVehicle(411,-757.9583,2757.7014,45.5401,180.6100,17,1); // Valle Ocultado -
	AddStaticVehicle(V_TOWTRUCK,-1905.3263,-1680.7986,22.8878,2.6586,1,1); // Towtruck
	AddStaticVehicle(V_PIZZABOY,-1801.9487,953.9265,24.5152,359.4162,1,1); //
	AddStaticVehicle(V_PIZZABOY,1728.4747,1352.5463,6.8231,45.6820,1,1); //
	
	AddStaticVehicle(603,1558.5854,-1568.6930,13.3854,178.0281,18,1); // LS Police Department
	AddStaticVehicle(421,827.4277,-500.8017,16.9705,181.1121,114,114); // Dillimore - Red County
	AddStaticVehicle(585,667.5848,-546.3334,15.9217,91.0764,62,62); // Dillimore - Red County
	AddStaticVehicle(550,218.5421,-173.3118,1.3956,89.8816,53,53); // BlueBerry - Red County
	AddStaticVehicle(549,277.9964,-57.1107,1.2754,179.8059,75,39); // Blueberry - Red County
	AddStaticVehicle(534,318.5228,-127.7506,1.9935,273.4911,62,62); // Blueberry - Red County
	AddStaticVehicle(445,1296.3618,217.9957,19.2698,246.8326,53,1); // Montgomery - Red County
	AddStaticVehicle(522,1199.5962,245.5116,19.1165,340.8217,8,82); // Montgomery - Bike - Red County
	AddStaticVehicle(506,1300.0515,188.1168,20.1681,125.6564,7,7); // Montgomery - Red County
	AddStaticVehicle(468,1648.8656,392.8077,20.3171,268.9193,112,120); // Montgomery Intersection
	AddStaticVehicle(496,2330.4973,155.8741,26.7559,270.1944,53,56); // Palomino Creek
	AddStaticVehicle(477,2419.9438,90.2896,26.2326,89.1128,0,1); // Palomino Creek
	AddStaticVehicle(475,2515.8638,69.6039,26.8347,270.9974,17,1); // Palomino Creek
	AddStaticVehicle(419,2424.4153,-55.3407,27.0944,359.2758,78,76); // Palomino Creek
	AddStaticVehicle(445,2240.7871,-10.0855,26.9990,178.7440,41,41); // Palomino Creek
	AddStaticVehicle(439,1916.3346,27.7938,34.5091,131.0623,43,21); // Red County
	AddStaticVehicle(585,1593.5355,74.0464,37.4423,181.9373,1,2); // Red County - Highway to LV
	AddStaticVehicle(560,1655.2799,-329.9831,39.6452,178.9867,33,0); // Red County - Highway to LV
	AddStaticVehicle(419,768.3475,-137.2016,20.4465,129.0608,33,75); // Fern Ridge
	AddStaticVehicle(402,392.4656,159.2693,8.5762,127.3456,30,30); // Red County - Near Blueberry
	AddStaticVehicle(400,130.3279,106.8548,2.5186,61.0584,75,1); // Red County - Near Blueberry
	AddStaticVehicle(585,-486.2493,297.8269,2.1463,87.3752,6,16); // The Panopticon
	
	//AddStaticVehicle(489,-1925.0282,2354.9956,48.7099,109.5755,0,0); // car 1
	//AddStaticVehicle(468,-1927.8931,2361.2986,49.0033,106.5387,0,0); // car 2
	//AddStaticVehicle(579,-1939.9093,2389.5154,49.3322,112.3752,0,0); // car 3
	//AddStaticVehicle(507,-785.6783,1532.6367,26.7925,90.4633,0,0); // car
	//AddStaticVehicle(411,-803.7359,1557.6832,26.7917,358.6754,0,0); // car
	//AddStaticVehicle(580,-799.3871,1497.1202,21.3723,88.2273,0,0); // car
	//AddStaticVehicle(567,-880.6318,1521.6130,25.6685,268.6491,0,0); // car
	//AddStaticVehicle(401,-772.4121,1437.1818,13.5462,268.5297,0,0); // car
	//AddStaticVehicle(420,-305.0265,1024.1492,19.3619,83.9266,0,0); // car
	//AddStaticVehicle(555,797.9066,1684.7754,5.0397,177.1683,0,0); // car
	//AddStaticVehicle(415,1571.9480,1810.3572,10.4789,182.7943,0,0); // car
	//AddStaticVehicle(480,1572.2673,1734.2198,10.4742,181.2940,0,0); // car
//boats 4
	AddStaticVehicle(493,720.9388,-1700.4620,-0.5290,35.6348,-1,-1);
	AddStaticVehicle(493,2355.2488,-2514.3970,-0.5287,158.8268,-1,-1);
	AddStaticVehicle(493,2364.3354,517.6652,-0.4520,89.2890,-1,-1);
	AddStaticVehicle(493,-1476.2301,691.7451,-0.4462,356.6588,-1,-1);
//Trains
	AddStaticVehicle(537,-1943.3127,158.0254,27.0006,357.3614,121,1);
	AddStaticVehicle(569,-1943.3127,158.0254,27.0006,357.3614,121,1);
	AddStaticVehicle(569,-1943.3127,158.0254,27.0006,357.3614,121,1);
	AddStaticVehicle(569,-1943.3127,158.0254,27.0006,357.3614,121,1);
	
//OBJECTS
    CreateObject(18056, 2018.3837, -4472.7988, 2770.9731, 0.0, 0.0, 0.0);
    CreateObject(1280, 2023.8651, -4467.1279, 2769.5932, 0.0, 0.0, 0.0);
    CreateObject(1280, 2023.8312, -4470.1425, 2769.6245, 0.0, 0.0, 0.0);
    CreateObject(1663, 2029.1553, -4471.9125, 2769.6521, 0.0, 0.0, 0.0);
    CreateObject(1998, 2030.7973, -4468.2910, 2769.1918, 0.0, 0.0, -90.0);
    CreateObject(1806, 2030.5280, -4469.2719, 2769.2114, 0.0, 0.0, -135.0);
    CreateObject(1649, 2010.7100, -4473.4145, 2770.8576, 0.0, 0.0, 0.0);
	CreateObject(1649, 2014.6711, -4473.4199, 2770.8576, 0.0, 0.0, 0.0);
	CreateObject(1649, 2014.677, -4473.2397, 2770.8449, 0.0, 0.0, 180.0);
	CreateObject(1649, 2010.7382, -4473.2094, 2770.8442, 0.0, 0.0, 180.0);
	CreateObject(3983, 2016.8140, -4473.4218, 2774.7858, 0.0, 0.0, 180.0);
	CreateObject(11631, 2025.9044, -4468.6118, 2770.4377, 0.0, 0.0, 0.0);
	CreateObject(2205, 2028.3491, -4473.0937, 2769.184, 0.0, 0.0, 180.0);
	CreateObject(1998, 2006.6226,-4476.6318,2769.1918, 0.0, 0.0, 0.0);
	CreateObject(1998, 2019.8721,-4477.9102,2769.1918, 0.0, 0.0, 0.0);
	//Load Ownerships and Locks
    for(new r=0;r<699;r++)
		{
		new str[256];
		format(str,256,"car%d",r);
		gOwner[r] = dini_Int("car_ownerships",str);
		gLocked[r] = dini_Int("car_locks",str);
		}
//PETROL
	for(new c=0;c<MAX_CARS;c++)
		{
	 	Petrol[c] = AMOUNT;
	 	}
//Bribings ids to 999
	for(new a=0;a<MAX_PLAYERS;a++)
		{
		BribeTo[a] = 999;
		BribeFrom[a] = 999;
		SellTo[a] = 999;
		SellFrom[a] = 999;
		}
	
//Loading CarMods
	new tmpstr[256],File:carmods,tmp,tmpres[256],tmpcolor;
	carmods=fopen("carmods",io_read);
	tmpres[0]=0;
	for(new i;i<700;i++)
		{
		for(new p;p<20;p++)
			{
			format(tmpstr,256,"%d_%d",i,p);
			while (fread(carmods,tmpres)) 
				{
				StripNewLine(tmpres);
				if (equal(dini_PRIVATE_ExtractKey(tmpres),tmpstr,true)) 
					{
					tmp = strval(dini_PRIVATE_ExtractValue(tmpres));
					break;
					}
				}
			Component[i][p] = tmp;
			if(p==16 && tmp) ChangeVehiclePaintjob(i,tmp);
			else if(p==18) tmpcolor = tmp;
			else if(p==19) ChangeVehicleColor(i,tmpcolor,tmp);
			else if(tmp) AddVehicleComponent(i,tmp);
			}
		}
}

//-----------------------------------------------------------------------TEAMS-------------------------------------------------------------------
public SetPlayerTeamFromClass(playerid,classid)
{
   	if (classid == 0)
   	{
    	gTeam[playerid] = TEAM_POLICE_LS;
    	GameTextForPlayer(playerid, "~b~POLICE LS", 5000, 4);
   	}
   	//else if (classid == 7)
   	//{
    //	gTeam[playerid] = TEAM_PILOT;
   	//}
   	else if (classid == 1)
   	{
    	gTeam[playerid] = TEAM_POLICE_SF;
    	GameTextForPlayer(playerid, "~b~POLICE SF", 5000, 4);
   	}
   	else if (classid == 2)
	{
    	gTeam[playerid] = TEAM_POLICE_LV;
    	GameTextForPlayer(playerid, "~b~POLICE LV", 5000, 4);
   	}
   	else if (classid == 3)
	{
    	gTeam[playerid] = TEAM_MEDIC_LS;
    	GameTextForPlayer(playerid, "~r~MEDIC LS", 5000, 4);
   	}
   	else if (classid == 4)
	{
    	gTeam[playerid] = TEAM_MEDIC_SF;
    	GameTextForPlayer(playerid, "~r~MEDIC SF", 5000, 4);
   	}
   	else if (classid == 5)
	{
    	gTeam[playerid] = TEAM_MEDIC_LV;
    	GameTextForPlayer(playerid, "~r~MEDIC LV", 5000, 4);
   	}
   	/*else if (classid == 6 || classid == 7 || classid == 8 || classid == 9)
	{
    	gTeam[playerid] = TEAM_FBI;
    	GameTextForPlayer(playerid, "~g~FBI", 5000, 4);
   	}*/
   	else if (classid > 6 && classid < 55)
	{
    	gTeam[playerid] = TEAM_CITIZEN_LS;
    	GameTextForPlayer(playerid, "~w~CITIZEN LS", 5000, 4);
   	}
   	else if (classid > 54 && classid < 123)
	{
    	gTeam[playerid] = TEAM_CITIZEN_SF;
    	GameTextForPlayer(playerid, "~w~CITIZEN SF", 5000, 4);
   	}
   	else
   	{
   		gTeam[playerid] = TEAM_CITIZEN_LV;
   		GameTextForPlayer(playerid, "~w~CITIZEN LV", 5000, 4);
   	}
	return 1;
}


//--------------------------------------------------------PLAYER REQUEST---------------------------------------------------------------------------
public OnPlayerRequestClass(playerid, classid)
{
	UnforcedSpawn[playerid] = 1;
	SetPlayerPos(playerid, 1282.4651, -831.5480, 83.1406);
   	SetPlayerCameraPos(playerid, 1282.4651, -825.5480, 84.1406);
    SetPlayerFacingAngle(playerid, 0.6483);
   	SetPlayerCameraLookAt(playerid, 1282.4651, -831.5480, 83.1406);
   	SetPlayerTeamFromClass(playerid, classid);
	return 1;
}

public OnGameModeExit()
{
	for(new playerid=0;playerid<MAX_PLAYERS;playerid++)
		{
		if(IsPlayerConnected(playerid))
			{
			dUserSetINT(PlayerName(playerid)).("CurrentCheckpoint",gCurrentCheckpoint[playerid]);
			dUserSetINT(PlayerName(playerid)).("CurrentGamePhase",gCurrentGamePhase[playerid]);
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
			dUserSetINT(PlayerName(playerid)).("x",floatround(x,floatround_round));
			dUserSetINT(PlayerName(playerid)).("y",floatround(y,floatround_round));
			dUserSetINT(PlayerName(playerid)).("z",floatround(z,floatround_round));
			dUserSetINT(PlayerName(playerid)).("Phone",Phone[playerid]);
			new Float:health;
			GetPlayerHealth(playerid,health);
			dUserSetINT(PlayerName(playerid)).("health",floatround(health));
			new Float:armour;
			GetPlayerArmour(playerid,armour);
			dUserSetINT(PlayerName(playerid)).("armour",floatround(armour));
			dUserSetINT(PlayerName(playerid)).("money",GetPlayerMoney(playerid));
			dUserSetINT(PlayerName(playerid)).("wanted_level",GetPlayerWantedLevel(playerid));
			dUserSetINT(PlayerName(playerid)).("Benefits",Benefits[playerid]);
			dUserSetINT(PlayerName(playerid)).("PlayerBank",PlayerBank[playerid]);
			new weapon1,weapon1_ammo,weapon2,weapon2_ammo,weapon3,weapon3_ammo,weapon4,weapon4_ammo,weapon5,weapon5_ammo,weapon6,weapon6_ammo,weapon7,weapon7_ammo,weapon8,weapon8_ammo,weapon9,weapon9_ammo,weapon10,weapon10_ammo,weapon11,weapon11_ammo,weapon12,weapon12_ammo,weapon0,weapon0_ammo;
			GetPlayerWeaponData(playerid, 0, weapon0, weapon0_ammo);
			GetPlayerWeaponData(playerid, 1, weapon1, weapon1_ammo);
			GetPlayerWeaponData(playerid, 2, weapon2, weapon2_ammo);
			GetPlayerWeaponData(playerid, 3, weapon3, weapon3_ammo);
			GetPlayerWeaponData(playerid, 4, weapon4, weapon4_ammo);
			GetPlayerWeaponData(playerid, 5, weapon5, weapon5_ammo);
			GetPlayerWeaponData(playerid, 6, weapon6, weapon6_ammo);
			GetPlayerWeaponData(playerid, 7, weapon7, weapon7_ammo);
			GetPlayerWeaponData(playerid, 8, weapon8, weapon8_ammo);
			GetPlayerWeaponData(playerid, 9, weapon9, weapon9_ammo);
			GetPlayerWeaponData(playerid, 10, weapon10, weapon10_ammo);
			GetPlayerWeaponData(playerid, 11, weapon11, weapon11_ammo);
			GetPlayerWeaponData(playerid, 12, weapon12, weapon12_ammo);
			dUserSetINT(PlayerName(playerid)).("weapon1",weapon1);
			dUserSetINT(PlayerName(playerid)).("weapon1_ammo",weapon1_ammo);
			dUserSetINT(PlayerName(playerid)).("weapon2",weapon2);
			dUserSetINT(PlayerName(playerid)).("weapon2_ammo",weapon2_ammo);
			dUserSetINT(PlayerName(playerid)).("weapon3",weapon3);
			dUserSetINT(PlayerName(playerid)).("weapon3_ammo",weapon3_ammo);
			dUserSetINT(PlayerName(playerid)).("weapon4",weapon4);
			dUserSetINT(PlayerName(playerid)).("weapon4_ammo",weapon4_ammo);
			dUserSetINT(PlayerName(playerid)).("weapon5",weapon5);
			dUserSetINT(PlayerName(playerid)).("weapon5_ammo",weapon5_ammo);
			dUserSetINT(PlayerName(playerid)).("weapon6",weapon6);
			dUserSetINT(PlayerName(playerid)).("weapon6_ammo",weapon6_ammo);
			dUserSetINT(PlayerName(playerid)).("weapon7",weapon7);
			dUserSetINT(PlayerName(playerid)).("weapon7_ammo",weapon7_ammo);
			dUserSetINT(PlayerName(playerid)).("weapon8",weapon8);
			dUserSetINT(PlayerName(playerid)).("weapon8_ammo",weapon8_ammo);
			dUserSetINT(PlayerName(playerid)).("weapon9",weapon9);
			dUserSetINT(PlayerName(playerid)).("weapon9_ammo",weapon9_ammo);
			dUserSetINT(PlayerName(playerid)).("weapon10",weapon10);
			dUserSetINT(PlayerName(playerid)).("weapon10_ammo",weapon10_ammo);
			dUserSetINT(PlayerName(playerid)).("weapon11",weapon11);
			dUserSetINT(PlayerName(playerid)).("weapon11_ammo",weapon11_ammo);
			dUserSetINT(PlayerName(playerid)).("weapon12",weapon12);
			dUserSetINT(PlayerName(playerid)).("weapon12_ammo",weapon12_ammo);
			dUserSetINT(PlayerName(playerid)).("interior", GetPlayerInterior(playerid));
			dUserSetINT(PlayerName(playerid)).("Jailed", Jailed[playerid]);
			dUserSetINT(PlayerName(playerid)).("JailLeft", JailLeft[playerid]);
			dUserSetINT(PlayerName(playerid)).("logedin", 0);
			dUserSetINT(PlayerName(playerid)).("hitman",Hitman[playerid]);
			Hitman[playerid] = 0;
			}
		}
	CarModsSaving();
	print("GameModeExit()");
	return 1;
}


//--------------------------------------------------------------CONNECT-----------------------------------------------------------------------------------------
public OnPlayerConnect(playerid)
{
	PLAYERLIST_authed[playerid]=false;
	new ip[16];
	GetPlayerIp(playerid, ip, sizeof(ip));
	if (strcmp(ip, "255.255.255.255") == 0) {
		Kick(playerid);
		return 0;
	}
	if(dUserINT(PlayerName(playerid)).("hitman") > 0)
		{
		Hitman[playerid] = dUserINT(PlayerName(playerid)).("hitman");
		}
	SendClientMessage(playerid,COLOR_YELLOW,"[INFO] Welcome To Compton City RPG Server by Zamaroht and jtg91");
	SendClientMessage(playerid,COLOR_YELLOW,"[INFO] To Start Playing Please Create An Account By Typing /register");
	SendClientMessage(playerid,COLOR_YELLOW,"[INFO] Or If You Have Already Created An Account Please Type /login");
	SendClientMessage(playerid, COLOR_YELLOW, "[INFO] You must read the rules in http://www.comptoncity.ar.nu/ before playing");
	SendClientMessage(playerid,COLOR_GREEN,"[INFO] For A Complete Gameplay, Visit Forums At: http://comptoncity.ar.nu/");
	GameTextForPlayer(playerid,"/REGISTER AND /LOGIN BEFORE SPAWN!!!!!",5000,4);
	SetPlayerMapIcon(playerid, 1, ls1posx, ls1posy, ls1posz, 22, COLOR_RED); //hospital ls1
	SetPlayerMapIcon(playerid, 2, ls2posx, ls2posy, ls2posz, 22, COLOR_RED); //hospital ls2
	SetPlayerMapIcon(playerid, 3, sfposx, sfposy, sfposz, 22, COLOR_RED); //hospital sf
	SetPlayerMapIcon(playerid, 4, lvposx, lvposy, lvposz, 22, COLOR_RED); //hospital lv
	SetPlayerMapIcon(playerid, 5, 2033.6816, 1917.2129, 11.9606, 32, COLOR_RED); //lv house
	SetPlayerMapIcon(playerid, 6, -2724.7810, -311.7671, 7.0391, 32, COLOR_RED); //sf house
	SetPlayerMapIcon(playerid, 7, 1283.1844,-819.1490,84.1406, 32, COLOR_RED); //ls house
	SetPlayerMapIcon(playerid, 8, 1938.6957, 1947.5320, 7.5938, 35, COLOR_GREY); //lv gun
	SetPlayerMapIcon(playerid, 9, 2060.0322, 1992.0376, 11.6484, 35, COLOR_GREY); //lv pass
	SetPlayerMapIcon(playerid, 10, -2658.9617, -325.9793, 6.9781, 35, COLOR_GREY); //sf gun
	SetPlayerMapIcon(playerid, 11, -2667.9194, -334.9396, 6.9097, 35, COLOR_GREY); //sf pass
	SetPlayerMapIcon(playerid, 12, 1272.4540,-828.5087,83.1406, 35, COLOR_GREY); //ls gun
	SetPlayerMapIcon(playerid, 13, 1289.5892,-829.1285,83.1406, 35, COLOR_GREY); //ls pass
	SetPlayerMapIcon(playerid, 14, 1450.6534, -2286.1255, 13.5469,52, COLOR_GREEN);//bank ls
	SetPlayerMapIcon(playerid, 15, -1942.5673, 456.3720, 35.1719,52, COLOR_GREEN);//bank sf
	SetPlayerMapIcon(playerid, 16, 1930.5790, 1345.1957, 9.9688,52, COLOR_GREEN);//bank lv
	SetPlayerMapIcon(playerid, 17, 1548.7313, -1675.7290, 14.6540, 30, COLOR_BLUE);//lspd
	SetPlayerMapIcon(playerid, 18, -1622.1444, 675.4337, 7.1875, 30, COLOR_BLUE);//sfpd
	SetPlayerMapIcon(playerid, 19, 2336.7500, 2455.8149, 14.9688, 30, COLOR_BLUE);//lvpd
	if(!game_loaded)
		{
		AddStaticPickup(1239, 2, 2060.0322, 1992.0376, 11.6484);//LV pass        0
		AddStaticPickup(1239, 2, -2667.9194, -334.9396, 6.9097);// SF pass         1
		AddStaticPickup(1239, 2, 1289.5892,-829.1285,83.1406);//LS pass           2
		AddStaticPickup(1313, 2, 1938.6957, 1947.5320, 7.5938);//LV gun      3
		AddStaticPickup(1313, 2, -2658.9617, -325.9793, 6.9781);//SF gun      4
		AddStaticPickup(1313, 2, 1272.4540,-828.5087,83.1406);//LS gun        5
		//------------------------BANK--------------------------------
		AddStaticPickup(1274, 2, 2316.4199, -7.4330, 26.7422); //bank       6
		AddStaticPickup(1274, 2, 2309.1895, -8.4328, 26.7422); //bank2       7
		AddStaticPickup(1210, 2, 2308.8232, -13.9428, 26.7422); //lotto      8
		AddStaticPickup(1272, 2, 2315.6594, -0.8252, 26.7422); //doorout        9
		AddStaticPickup(1272, 2, 1450.6534, -2286.1255, 13.5469); //bankls        10
		AddStaticPickup(1272, 2, -1942.5673, 456.3720, 35.1719); // banksf       11
		AddStaticPickup(1272, 2, 1930.5790, 1345.1957, 9.9688); //banklv        12
		//---------------------LS FIGHTING CLUB--------------------------
		AddStaticPickup(1314, 2, 764.9453,10.8194,1000.7084); //ls ring 2          13
		AddStaticPickup(1212, 2, 756.5376,5.9798,1000.6995); // bet ls            14
		//---------------------SF POLICE DEPARTMENT----------------------
		AddStaticPickup(1272, 2, -1593.5801, 716.1042, -5.2422); //outside         15
		AddStaticPickup(1272, 2, 215.2667, 120.6622, 999.0156); //inside            16
		//-----------------------SHOPS------------------------------------
		AddStaticPickup(1239, 2, -26.9491,-89.4031,1003.5469); //LS 1              17
		AddStaticPickup(1239, 2, -29.7349,-28.0805,1003.5573); //LS 2              18
		MaxPickups = 18;
		//-----------------------HOUSES-----------------------------------
		for(new i=0; i<dini_Int("houses","houses"); i++)
			{
			new tmp[256], tmpx[256], tmpy[256], tmpz[256];
			format(tmp,256,"house%d_x",i);
			tmpx = tmp;
			format(tmp,256,"house%d_y",i);
			tmpy = tmp;
			format(tmp,256,"house%d_z",i);
			tmpz = tmp;
			AddStaticPickup(1273,2,dini_Int("houses",tmpx),dini_Int("houses",tmpy),dini_Int("houses",tmpz));
			}
		game_loaded = 1;
		}
	return 1;
}


//--------------------------------------------------------------DISCONNECT------------------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid)
{
	printf("Player Disconnected (id:%d)",playerid);
	dUserSetINT(PlayerName(playerid)).("hitman",Hitman[playerid]);
	Hitman[playerid] = 0;
	JustRegistered[playerid] = 0;
	CheckOk[playerid] = 0;
	if(IsPlayerInAnyVehicle(playerid))
		{
		TaxiCar[playerid] = 0;
		TaxiService[playerid] = 0;
		PizzaBike[playerid] = 0;
		PizzaService[playerid] = 0;
		}
	if(Blocking[playerid])
		{
		for(new i=0;i<MAX_PLAYERS;i++)
			{
			if(IsPlayerConnected(i))
				{
				if(GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid) && GetPlayerState(i) == PLAYER_STATE_PASSENGER && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
					{
					Blocking[playerid] = 0;
					TogglePlayerControllable(i,1);
					}
				}
			}
		}
	citizenls[playerid] = 0;
	citizenlv[playerid] = 0;
	citizensf[playerid] = 0;
	bodyduty[playerid] = 0;
	bodyowner[playerid] = 999;
	new topay;
	for(new i;i<MAX_PLAYERS;i++)
		{
		if(IsPlayerConnected(i) && bodyguard[playerid][i])
			{
			SendClientMessage(i,COLOR_RED,"[WARNING] The one who hired you disconnected, you get automatly payed.");
			SendClientMessage(i,COLOR_GREEN,"[INFO] You still on duty, do /bodyduty for go off.");
			GivePlayerMoneyEx(i,bodyduty[i],"unpayed bodyguard job on disconnect");
			topay += bodyduty[i];
			bodyduty[i] = 0;
			bodyowner[i] = 999;
			bodyguard[playerid][i] = 999;
			}
		}
	if(bodyduty[playerid])
		{
		new tmp[256];
		format(tmp,256,"[WARNING] The bodyguard %s has disconnected",PlayerName(playerid));
		SendClientMessage(bodyowner[playerid], COLOR_RED, tmp);
		bodyowner[playerid] = 999;
		bodyduty[playerid] = 0;
		bodyguard[bodyowner[playerid]][playerid] = 0;
		bodyowner[playerid] = 999;
		}
	RequestingPassport[playerid] = 0;
	//BribeTo[BribeFrom[playerid]] = 999;
	BribeTo[playerid] = 999;
	Bribe[playerid] = 0;
	BribeFrom[playerid] = 999;
	SellTo[playerid] = 999;
	Sell[playerid] = 0;
	SellFrom[playerid] = 999;
	if(Spawned[playerid])
		{
		dUserSetINT(PlayerName(playerid)).("CurrentCheckpoint",gCurrentCheckpoint[playerid]);
		dUserSetINT(PlayerName(playerid)).("CurrentGamePhase",gCurrentGamePhase[playerid]);
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		dUserSetINT(PlayerName(playerid)).("x",floatround(x,floatround_round));
		dUserSetINT(PlayerName(playerid)).("y",floatround(y,floatround_round));
		dUserSetINT(PlayerName(playerid)).("z",floatround(z,floatround_round));
		dUserSetINT(PlayerName(playerid)).("Phone",Phone[playerid]);
		/*new Float:health;
		GetPlayerHealth(playerid,health);
		dUserSetINT(PlayerName(playerid)).("health",floatround(health));
		new Float:armour;
		GetPlayerArmour(playerid,armour);
		dUserSetINT(PlayerName(playerid)).("armour",floatround(armour));*/
		dUserSetINT(PlayerName(playerid)).("money",GetPlayerMoney(playerid)-topay);
		dUserSetINT(PlayerName(playerid)).("wanted_level",GetPlayerWantedLevel(playerid));
		dUserSetINT(PlayerName(playerid)).("Benefits",Benefits[playerid]);
		dUserSetINT(PlayerName(playerid)).("PlayerBank",PlayerBank[playerid]);
		new weapon1,weapon1_ammo,weapon2,weapon2_ammo,weapon3,weapon3_ammo,weapon4,weapon4_ammo,weapon5,weapon5_ammo,weapon6,weapon6_ammo,weapon7,weapon7_ammo,weapon8,weapon8_ammo,weapon9,weapon9_ammo,weapon10,weapon10_ammo,weapon11,weapon11_ammo,weapon12,weapon12_ammo,weapon0,weapon0_ammo;
		GetPlayerWeaponData(playerid, 0, weapon0, weapon0_ammo);
		GetPlayerWeaponData(playerid, 1, weapon1, weapon1_ammo);
		GetPlayerWeaponData(playerid, 2, weapon2, weapon2_ammo);
		GetPlayerWeaponData(playerid, 3, weapon3, weapon3_ammo);
		GetPlayerWeaponData(playerid, 4, weapon4, weapon4_ammo);
		GetPlayerWeaponData(playerid, 5, weapon5, weapon5_ammo);
		GetPlayerWeaponData(playerid, 6, weapon6, weapon6_ammo);
		GetPlayerWeaponData(playerid, 7, weapon7, weapon7_ammo);
		GetPlayerWeaponData(playerid, 8, weapon8, weapon8_ammo);
		GetPlayerWeaponData(playerid, 9, weapon9, weapon9_ammo);
		GetPlayerWeaponData(playerid, 10, weapon10, weapon10_ammo);
		GetPlayerWeaponData(playerid, 11, weapon11, weapon11_ammo);
		GetPlayerWeaponData(playerid, 12, weapon12, weapon12_ammo);
		dUserSetINT(PlayerName(playerid)).("weapon1",weapon1);
		dUserSetINT(PlayerName(playerid)).("weapon1_ammo",weapon1_ammo);
		dUserSetINT(PlayerName(playerid)).("weapon2",weapon2);
		dUserSetINT(PlayerName(playerid)).("weapon2_ammo",weapon2_ammo);
		dUserSetINT(PlayerName(playerid)).("weapon3",weapon3);
		dUserSetINT(PlayerName(playerid)).("weapon3_ammo",weapon3_ammo);
		dUserSetINT(PlayerName(playerid)).("weapon4",weapon4);
		dUserSetINT(PlayerName(playerid)).("weapon4_ammo",weapon4_ammo);
		dUserSetINT(PlayerName(playerid)).("weapon5",weapon5);
		dUserSetINT(PlayerName(playerid)).("weapon5_ammo",weapon5_ammo);
		dUserSetINT(PlayerName(playerid)).("weapon6",weapon6);
		dUserSetINT(PlayerName(playerid)).("weapon6_ammo",weapon6_ammo);
		dUserSetINT(PlayerName(playerid)).("weapon7",weapon7);
		dUserSetINT(PlayerName(playerid)).("weapon7_ammo",weapon7_ammo);
		dUserSetINT(PlayerName(playerid)).("weapon8",weapon8);
		dUserSetINT(PlayerName(playerid)).("weapon8_ammo",weapon8_ammo);
		dUserSetINT(PlayerName(playerid)).("weapon9",weapon9);
		dUserSetINT(PlayerName(playerid)).("weapon9_ammo",weapon9_ammo);
		dUserSetINT(PlayerName(playerid)).("weapon10",weapon10);
		dUserSetINT(PlayerName(playerid)).("weapon10_ammo",weapon10_ammo);
		dUserSetINT(PlayerName(playerid)).("weapon11",weapon11);
		dUserSetINT(PlayerName(playerid)).("weapon11_ammo",weapon11_ammo);
		dUserSetINT(PlayerName(playerid)).("weapon12",weapon12);
		dUserSetINT(PlayerName(playerid)).("weapon12_ammo",weapon12_ammo);
		dUserSetINT(PlayerName(playerid)).("interior", GetPlayerInterior(playerid));
		dUserSetINT(PlayerName(playerid)).("Jailed", Jailed[playerid]);
		dUserSetINT(PlayerName(playerid)).("JailLeft", JailLeft[playerid]);
		dUserSetINT(PlayerName(playerid)).("logedin", 0);
		PLAYERLIST_authed[playerid]=false;
		}
	Spawned[playerid]=0;
	loaded[playerid] = 0;
	gPlayerid[playerid] = 0;
	return 1;
}

public KickOut()
{
	for(new i=0;i<MAX_PLAYERS;i++)
		{
		if(ToBeKicked[i] == 1)
			{
			Kick(i);
			ToBeKicked[i] = 0;
			}
		}
}
//-------------------------------------------------------------SPAWN-------------------------------------------------------------------------------
public OnPlayerSpawn(playerid)
{
	Spawned[playerid]=1;
	if(ForcedSpawn[playerid])
		{
		ForcedSpawn[playerid] = 0;
		UnforcedSpawn[playerid] = 0;
		SetPlayerSkin(playerid,dUserINT(PlayerName(playerid)).("Skin"));
		gTeam[playerid] = dUserINT(PlayerName(playerid)).("gTeam");
		if(((gTeam[playerid] == TEAM_POLICE_LS || gTeam[playerid] == TEAM_POLICE_SF || gTeam[playerid] == TEAM_POLICE_LV) && (dUserINT(PlayerName(playerid)).("gTeam") == TEAM_POLICE_LS || dUserINT(PlayerName(playerid)).("gTeam") == TEAM_POLICE_SF || dUserINT(PlayerName(playerid)).("gTeam") == TEAM_POLICE_LV)) || 
		((gTeam[playerid] == TEAM_CITIZEN_LS || gTeam[playerid] == TEAM_CITIZEN_SF || gTeam[playerid] == TEAM_CITIZEN_LV) && (dUserINT(PlayerName(playerid)).("gTeam") == TEAM_CITIZEN_LS || dUserINT(PlayerName(playerid)).("gTeam") == TEAM_CITIZEN_SF || dUserINT(PlayerName(playerid)).("gTeam") == TEAM_CITIZEN_LV)) || 
		((gTeam[playerid] == TEAM_MEDIC_LS || gTeam[playerid] == TEAM_MEDIC_SF || gTeam[playerid] == TEAM_MEDIC_LV) && (dUserINT(PlayerName(playerid)).("gTeam") == TEAM_MEDIC_LS || dUserINT(PlayerName(playerid)).("gTeam") == TEAM_MEDIC_SF || dUserINT(PlayerName(playerid)).("gTeam") == TEAM_MEDIC_LV)))
			{
			ResetPlayerWeapons(playerid);
			GivePlayerWeapon(playerid, dUserINT(PlayerName(playerid)).("weapon1"), dUserINT(PlayerName(playerid)).("weapon1_ammo"));
		    GivePlayerWeapon(playerid, dUserINT(PlayerName(playerid)).("weapon0"), dUserINT(PlayerName(playerid)).("weapon0_ammo"));
		    GivePlayerWeapon(playerid, dUserINT(PlayerName(playerid)).("weapon2"), dUserINT(PlayerName(playerid)).("weapon2_ammo"));
			GivePlayerWeapon(playerid, dUserINT(PlayerName(playerid)).("weapon3"), dUserINT(PlayerName(playerid)).("weapon3_ammo"));
		    GivePlayerWeapon(playerid, dUserINT(PlayerName(playerid)).("weapon4"), dUserINT(PlayerName(playerid)).("weapon4_ammo"));
			GivePlayerWeapon(playerid, dUserINT(PlayerName(playerid)).("weapon5"), dUserINT(PlayerName(playerid)).("weapon5_ammo"));
		    GivePlayerWeapon(playerid, dUserINT(PlayerName(playerid)).("weapon6"), dUserINT(PlayerName(playerid)).("weapon6_ammo"));
			GivePlayerWeapon(playerid, dUserINT(PlayerName(playerid)).("weapon7"), dUserINT(PlayerName(playerid)).("weapon7_ammo"));
			GivePlayerWeapon(playerid, dUserINT(PlayerName(playerid)).("weapon8"), dUserINT(PlayerName(playerid)).("weapon8_ammo"));
		    GivePlayerWeapon(playerid, dUserINT(PlayerName(playerid)).("weapon9"), dUserINT(PlayerName(playerid)).("weapon9_ammo"));
			GivePlayerWeapon(playerid, dUserINT(PlayerName(playerid)).("weapon10"), dUserINT(PlayerName(playerid)).("weapon10_ammo"));
		    GivePlayerWeapon(playerid, dUserINT(PlayerName(playerid)).("weapon11"), dUserINT(PlayerName(playerid)).("weapon11_ammo"));
			GivePlayerWeapon(playerid, dUserINT(PlayerName(playerid)).("weapon12"), dUserINT(PlayerName(playerid)).("weapon12_ammo"));
			}
		}
	else if(UnforcedSpawn[playerid])
		{
		ForcedSpawn[playerid] = 0;
		UnforcedSpawn[playerid] = 0;
		dUserSetINT(PlayerName(playerid)).("Skin",GetPlayerSkin(playerid));
		dUserSetINT(PlayerName(playerid)).("gTeam",gTeam[playerid]);
		}
	else
		{
		ForcedSpawn[playerid] = 0;
		UnforcedSpawn[playerid] = 0;
		SetPlayerSkin(playerid,dUserINT(PlayerName(playerid)).("Skin"));
		gTeam[playerid] = dUserINT(PlayerName(playerid)).("gTeam");
		if(gTeam[playerid] != TEAM_POLICE_LS && gTeam[playerid] != TEAM_POLICE_SF && gTeam[playerid] != TEAM_POLICE_LV)
			{
			ResetPlayerWeapons(playerid);
			}
		}
	if(dUserINT(PlayerName(playerid)).("logedin") == 0)
		{
		SendClientMessage(playerid, COLOR_RED, "[KICK] You must login before spawn");
		GameTextForPlayer(playerid, "You MUST login before spawn!!",5000,6);
		SetTimer("KickOut",2000,0);
		ToBeKicked[playerid] = 1;
		}
	else
		{
		if(loaded[playerid] == 0)
			{
			SetPlayerPos(playerid, dUserINT(PlayerName(playerid)).("x"), dUserINT(PlayerName(playerid)).("y"), dUserINT(PlayerName(playerid)).("z")+1);
		    GivePlayerMoneyEx(playerid, dUserINT(PlayerName(playerid)).("money")-GetPlayerMoney(playerid),"loading");
	    	/*SetPlayerHealth(playerid, float(dUserINT(PlayerName(playerid)).("health")));
		    SetPlayerArmour(playerid, float(dUserINT(PlayerName(playerid)).("armour")));*/
			SetPlayerWantedLevel(playerid, dUserINT(PlayerName(playerid)).("wanted_level"));
			gCurrentCheckpoint[playerid] = dUserINT(PlayerName(playerid)).("CurrentCheckpoint");
			gCurrentGamePhase[playerid] = dUserINT(PlayerName(playerid)).("CurrentGamePhase");
			pName[playerid] = dUserINT(PlayerName(playerid)).("name");
			Passport[playerid] = dUserINT(PlayerName(playerid)).("Passport");
			gPlayerid[playerid] = dUserINT(PlayerName(playerid)).("playerid");
			SetPlayerInterior(playerid,dUserINT(PlayerName(playerid)).("interior"));
			Benefits[playerid] = dUserINT(PlayerName(playerid)).("Benefits");
			PlayerBank[playerid] = dUserINT(PlayerName(playerid)).("PlayerBank");
			Jailed[playerid] = dUserINT(PlayerName(playerid)).("Jailed");
			JailLeft[playerid] = dUserINT(PlayerName(playerid)).("JailLeft");
			AdminLevel[playerid] = dUserINT(PlayerName(playerid)).("AdminLevel");
			SetTimerEx("StartCheckingMoney",3000,0,"i",playerid);
			loaded[playerid] = 1;
			}
		else
			{
			if(ProxHospital[playerid] == hospls1) SetPlayerPos(playerid, ls1posx, ls1posy, ls1posz);
			else if(ProxHospital[playerid] == hospls2) SetPlayerPos(playerid, ls2posx, ls2posy, ls2posz);
			else if(ProxHospital[playerid] == hospsf) SetPlayerPos(playerid, sfposx, sfposy, sfposz);
			else if(ProxHospital[playerid] == hosplv) SetPlayerPos(playerid, lvposx, lvposy, lvposz);
			SendClientMessage(playerid,COLOR_GREEN,"You got healed, but lost part of your in-hand money");
			}
		if (gCurrentGamePhase[playerid] == 0)
			{
			if (gTeam[playerid] == TEAM_POLICE_LS || gTeam[playerid] == TEAM_POLICE_LV || gTeam[playerid] == TEAM_POLICE_SF)
				{
				gCurrentCheckpoint[playerid] = 1;
				SendClientMessage(playerid,COLOR_YELLOW,"[INFO] Please Sign In At One of The Desks, Thank You");
				SetPlayerColor(playerid,COLOR_BLUE);
				}
			else if (gTeam[playerid] == TEAM_CITIZEN_LS || gTeam[playerid] == TEAM_CITIZEN_LV || gTeam[playerid] == TEAM_CITIZEN_SF)
				{
				gCurrentCheckpoint[playerid] = 1;
				SendClientMessage(playerid,COLOR_YELLOW,"[INFO] Please Sign In At One of The Desks, Thank You");
				SetPlayerColor(playerid,COLOR_WHITE);
				}
			else if (gTeam[playerid] == TEAM_FBI)
				{
				gCurrentCheckpoint[playerid] = 1;
				SendClientMessage(playerid,COLOR_YELLOW,"[INFO] Please Sign In At One of The Desks, Thank You");
				SetPlayerColor(playerid,COLOR_GREEN);
				}
			//else if (gTeam[playerid] == TEAM_PILOT)
			//	{
			//	gCurrentCheckpoint[playerid] = 1;
			//	SendClientMessage(playerid,COLOR_YELLOW,"Please Sign In At One of The Desks, Thank You");
			//	}
			else if (gTeam[playerid] == TEAM_MEDIC_LS || gTeam[playerid] == TEAM_MEDIC_LV || gTeam[playerid] == TEAM_MEDIC_SF)
				{
				gCurrentCheckpoint[playerid] = 1;
				SendClientMessage(playerid,COLOR_YELLOW,"[INFO] Please Sign In At One of The Desks, Thank You");
				SetPlayerColor(playerid,COLOR_GREEN);
				}
			if (gCurrentCheckpoint[playerid] == 1)
				{
				SetPlayerCheckpoint(playerid, 2027.7670,-4474.3833,2769.1919, 2.0);
				}
			}
		if (gCurrentGamePhase[playerid] == 1)
			{
				if (gTeam[playerid] == TEAM_POLICE_LS || gTeam[playerid] == TEAM_POLICE_LV || gTeam[playerid] == TEAM_POLICE_SF)
				{
				SendClientMessage(playerid,COLOR_YELLOW,"[INFO] Welcome Back");
				SetPlayerColor(playerid,COLOR_BLUE);
				SetPlayerWantedLevel(playerid,0);
				}
				else if (gTeam[playerid] == TEAM_CITIZEN_LS || gTeam[playerid] == TEAM_CITIZEN_LV || gTeam[playerid] == TEAM_CITIZEN_SF)
				{
				SendClientMessage(playerid,COLOR_YELLOW,"[INFO] Welcome Back");
				SetPlayerColor(playerid,COLOR_WHITE);
				}
				else if (gTeam[playerid] == TEAM_FBI)
				{
				SendClientMessage(playerid,COLOR_YELLOW,"[INFO] Welcome Back");
				SetPlayerColor(playerid,COLOR_GREEN);
				}
	//			else if (gTeam[playerid] == TEAM_PILOT)
		//		{
			//	SendClientMessage(playerid,COLOR_YELLOW,"Welcome Back");
				//}
				else if (gTeam[playerid] == TEAM_MEDIC_LS || gTeam[playerid] == TEAM_MEDIC_LV || gTeam[playerid] == TEAM_MEDIC_SF)
				{
				SendClientMessage(playerid,COLOR_YELLOW,"[INFO] Welcome Back");
				SetPlayerColor(playerid,COLOR_GREEN);
				}
			}
		}
	SetTimerEx("BugFix",2000,0,"i",playerid);
	return 1;
}
//--------------------------------------------------------PLAYER DEATH-----------------------------------------------------------------------------
public OnPlayerDeath(playerid, killerid, reason)
{
	CheckOk[playerid] = 0;
	Spawned[playerid] = 0;
	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx, posy, posz);
	new Float:ls1, Float:ls2, Float:lv, Float:sf;
	ls1 = floatsqroot(floatpower(posx - ls1posx, 2) + floatpower(posy - ls1posy, 2) + floatpower(posz - ls1posz, 2));
	ls2 = floatsqroot(floatpower(posx - ls2posx, 2) + floatpower(posy - ls2posy, 2) + floatpower(posz - ls2posz, 2));
	lv = floatsqroot(floatpower(posx - lvposx, 2) + floatpower(posy - lvposy, 2) + floatpower(posz - lvposz, 2));
	sf = floatsqroot(floatpower(posx - sfposx, 2) + floatpower(posy - sfposy, 2) + floatpower(posz - sfposz, 2));
	if (ls1 < ls2 && ls1 < lv && ls1 < sf)
		{
		ProxHospital[playerid] = hospls1;
		}
	else if (ls2 < ls1 && ls2 < lv && ls2 < sf)
		{
		ProxHospital[playerid] = hospls2;
		}
	else if (sf < ls2 && sf < lv && sf < ls1)
		{
		ProxHospital[playerid] = hospsf;
		}
	else if (lv < ls2 && lv < ls1 && lv < sf)
		{
		ProxHospital[playerid] = hosplv;
		}
	if(IsPlayerInAnyVehicle(playerid))
		{
		TaxiCar[playerid] = 0;
		TaxiService[playerid] = 0;
		PizzaBike[playerid] = 0;
		PizzaService[playerid] = 0;
		}
	if (boxer2[playerid] == 1)
		{
		boxer2[playerid] = 0;
		}
	if(killerid!=INVALID_PLAYER_ID && Hitman[playerid]>0)
		{
		new tmp[256];
		format(tmp,256,"[INFO] You earned a bounty of %d for killing %s",Hitman[playerid],PlayerName(playerid));
		SendClientMessage(killerid,COLOR_GREEN,tmp);
		GivePlayerMoneyEx(killerid,Hitman[playerid],"hitman kill");
		Hitman[playerid] = 0;
		}
	if(gTeam[killerid] == TEAM_POLICE_LS || gTeam[killerid] == TEAM_POLICE_SF || gTeam[killerid] == TEAM_POLICE_LV || gTeam[killerid] == TEAM_MEDIC_LS || gTeam[killerid] == TEAM_MEDIC_SF || gTeam[killerid] == TEAM_MEDIC_LV)
		{
		if(gTeam[killerid] == gTeam[playerid])
			{
			GivePlayerMoneyEx(killerid,-150,"killing cop or unwanted");
			SendClientMessage(killerid, COLOR_RED, "[WARNING] Dont kill cops or unwanted people!!! You lost $150!");
			}
	 	else if(GetPlayerWantedLevel(playerid) == 0)
			{
			GivePlayerMoneyEx(killerid,-200,"killing cop or unwanted");
			SendClientMessage(killerid, COLOR_RED, "[WARNING] Dont kill cops or unwanted people!!! You lost $200!");
			}
		else if(gTeam[playerid] != TEAM_POLICE_LS || gTeam[playerid] != TEAM_POLICE_SF || gTeam[playerid] != TEAM_POLICE_LV || gTeam[playerid] != TEAM_MEDIC_LS || gTeam[playerid] != TEAM_MEDIC_SF || gTeam[playerid] != TEAM_MEDIC_LV)		
			{
			if(GetPlayerWantedLevel(playerid) == 1)
				{
				GivePlayerMoneyEx(killerid,15,"killing wanted level 1");
				SendClientMessage(killerid, COLOR_GREEN, "[INFO] You killed a level 1 wanted person. You earned $15,");
				SendClientMessage(killerid, COLOR_GREEN, "[INFO] you earn $50 when jailing level 1 wanted persons.");
				}
			if(GetPlayerWantedLevel(playerid) == 2)
				{
				GivePlayerMoneyEx(killerid,30,"killing wanted level 2");
				SendClientMessage(killerid, COLOR_GREEN, "[INFO] You killed a level 2 wanted person. You earned $30,");
				SendClientMessage(killerid, COLOR_GREEN, "[INFO] you earn $75 when jailing level 2 wanted persons.");
				}
			if(GetPlayerWantedLevel(playerid) == 3)
				{
				GivePlayerMoneyEx(killerid,45,"killing wanted level 3");
				SendClientMessage(killerid, COLOR_GREEN, "[INFO] You killed a level 3 wanted person. You earned $45,");
				SendClientMessage(killerid, COLOR_GREEN, "[INFO] you earn $100 when jailing level 3 wanted persons.");
				}
			if(GetPlayerWantedLevel(playerid) == 4)
				{
				GivePlayerMoneyEx(killerid,70,"killing wanted level 4");
				SendClientMessage(killerid, COLOR_GREEN, "[INFO] You killed a level 4 wanted person. You earned $70,");
				SendClientMessage(killerid, COLOR_GREEN, "[INFO] you earn $125 when jailing level 4 wanted persons.");
				}
			if(GetPlayerWantedLevel(playerid) == 5)
				{
				GivePlayerMoneyEx(killerid,95,"killing wanted level 5");
				SendClientMessage(killerid, COLOR_GREEN, "[INFO] You killed a level 5 wanted person. You earned $95,");
				SendClientMessage(killerid, COLOR_GREEN, "[INFO] you earn $150 when jailing level 5 wanted persons.");
				}
			if(GetPlayerWantedLevel(playerid) == 6)
				{
				GivePlayerMoneyEx(killerid,115,"killing wanted level 6");
				SendClientMessage(killerid, COLOR_GREEN, "[INFO] You killed a level 6 wanted person. You earned $115,");
				SendClientMessage(killerid, COLOR_GREEN, "[INFO] you earn $200 when jailing level 6 wanted persons.");
		  		}
		  	}
		}
	else if (killerid != INVALID_PLAYER_ID)
		{
		if(boxer2[killerid] == 0)
			{
			if(GetPlayerMoney(playerid) > 0)
				{
				new tmp;
				tmp = GetPlayerMoney(playerid)/2;
				GivePlayerMoneyEx(killerid, tmp,"killing someone (half cash from dead)");
				}
			GivePlayerMoneyEx(playerid,-GetPlayerMoney(playerid)/2,"get killed by someone (half cash)");
			if (GetPlayerWantedLevel(killerid) > 2)
				{
				WantedLevel(killerid, "+1", "Murder");
				SetPlayerWantedLevel(playerid, 0);
				}
			else
				{
				WantedLevel(killerid, "3", "Murder");
				SetPlayerWantedLevel(playerid, 0);
				SendClientMessage(killerid, COLOR_RED, "[WARNING] You killed somebody!!! The police is behind you!");
				}
			}
		}
	else if (killerid == INVALID_PLAYER_ID)
		{
		GivePlayerMoneyEx(playerid,-GetPlayerMoney(playerid)/10,"dieing, no kill");
		}
	SetPlayerWantedLevel(playerid, 0);
	dUserSetINT(PlayerName(killerid)).("kills", (dUserINT(PlayerName(killerid)).("kills")) + 1);
	dUserSetINT(PlayerName(playerid)).("deaths", (dUserINT(PlayerName(playerid)).("deaths")) + 1);
	SendDeathMessage(killerid, playerid, reason);
	Bribe[BribeTo[playerid]] = 0;
	BribeTo[playerid] = 999;
	BribeFrom[BribeTo[playerid]] = 0;
	PlayerBank[playerid] = 0;
	Jailed[playerid] = 0;
	JailLeft[playerid] = 0;
}

public OnVehicleSpawn(vehicleid)
{
	Petrol[vehicleid] = 100;
	printf("OnVehicleSpawn(%d)", vehicleid);
	SetTimerEx("ModCars",5000,0,"i",vehicleid);
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	printf("OnVehicleDeath(%d, %d)", vehicleid, killerid);
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(RequestingPassport[playerid])
		{
		if(strcmp(text, PASSPORT_PASSWORD, true) == 0)
			{
			SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Congratulations, you got a Passport now");
			dUserSetINT(PlayerName(playerid)).("Passport",1);
			Passport[playerid] = 1;
			}
		else
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] Wrong password. For get the passport password, go to the forums in");
			SendClientMessage(playerid, COLOR_RED, "[INFO] www.comptoncity.ar.nu, and check general discussion board");
			}
		RequestingPassport[playerid] = 0;
		return 0;
		}
	else if(BuyingCar[playerid])
		{
		if(!IsPlayerInAnyVehicle(playerid))
			{
			SendClientMessage(playerid,COLOR_RED,"[INFO] You must be inside the vehicle you want to buy");
			BuyingCar[playerid] = 0;
			return 0;
			}
		else if(strcmp(text, "yes", true) == 0)
			{
			if(GetPlayerMoney(playerid) >= CarPrice[GetVehicleModel(GetPlayerVehicleID(playerid))-400])
				{
				if(dUserINT(PlayerName(playerid)).("vehicles")==0)
					{
					new strtmp[256];
					format(strtmp,256,"car%d",GetPlayerVehicleID(playerid));
					dini_IntSet("car_ownerships",strtmp,gPlayerid[playerid]);
					format(strtmp,256,"car%d_",GetPlayerVehicleID(playerid));
					dini_IntSet("car_ownerships",strtmp,0);
					dUserSetINT(PlayerName(playerid)).("vehicles",GetPlayerVehicleID(playerid));
					gOwner[GetPlayerVehicleID(playerid)] = gPlayerid[playerid];
					GivePlayerMoneyEx(playerid,-CarPrice[GetVehicleModel(GetPlayerVehicleID(playerid))-400],"buying car");
					SendClientMessage(playerid,COLOR_GREEN,"[INFO] Vehicle bought!");
					}
				else
					{
					SendClientMessage(playerid,COLOR_RED,"[INFO] You already have a car. Max cars is 1. You can sell it doing /sellcar [ID] [PRICE]");
					}
				}
			else
				{
				SendClientMessage(playerid,COLOR_RED,"[INFO] You dont have enough cash in hand");
				}
			BuyingCar[playerid] = 0;
			return 0;
			}
		else
			{
			SendClientMessage(playerid,COLOR_RED,"[INFO] Car buying cancelled");
			BuyingCar[playerid] = 0;
			return 0;
			}
		}
	return 1;
}

public OnPlayerRequestSpawn(playerid)
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
	if(pickupid > MaxPickups)
		{
		new thouseid, temp[256], tmp[256], tmp2x[256], tmp2y[256], tmp2z[256], tmp5[256];
		thouseid = pickupid-MaxPickups;
		format(temp,256,"house%d_owner",thouseid);
		format(tmp5,256,"house%d_locked",thouseid);
		if(dini_Int("houses",temp) == gPlayerid[playerid])
			{
			format(tmp,256,"house%d_int",thouseid);
			format(tmp2x,256,"house%d_xteleport",thouseid);
			format(tmp2y,256,"house%d_yteleport",thouseid);
			format(tmp2z,256,"house%d_zteleport",thouseid);
			houseid[playerid] = thouseid;
			SetPlayerInterior(playerid,dini_Int("houses",tmp));
			SetPlayerPos(playerid,dini_Int("houses",tmp2x),dini_Int("houses",tmp2y),dini_Int("houses",tmp2z));
			new tmp3x[256], tmp3y[256], tmp3z[256];
			format(tmp3x,256,"house%d_x2",thouseid);
			format(tmp3y,256,"house%d_y2",thouseid);
			format(tmp3z,256,"house%d_z2",thouseid);
			gCurrentCheckpoint[playerid] = 11;
			SetPlayerCheckpoint(playerid,dini_Int("houses",tmp3x),dini_Int("houses",tmp3y),dini_Int("houses",tmp3z),2.0);
			}
		else if(dini_Int("houses",tmp5) == 1)
			{
			new houseowner[256],idtmp[256],housetmp[256];
			format(housetmp,256,"house%d_owner",thouseid);
			format(idtmp,256,"%d",dini_Int("houses",housetmp));
			format(houseowner,256,"This isnt your house and it is locked. Owner: %s",dini_Get("players",idtmp));
			GameTextForPlayer(playerid,houseowner,3000,6);
			SendClientMessage(playerid, COLOR_RED,houseowner);
			}
		else
			{
			new houseowner[256],idtmp[256],housetmp[256];
			format(housetmp,256,"house%d_owner",thouseid);
			format(idtmp,256,"%d",dini_Int("houses",housetmp));
			format(houseowner,256,"This isnt your home!! Owner: %s",dini_Get("players",idtmp));
			SendClientMessage(playerid, COLOR_RED, houseowner);
			GameTextForPlayer(playerid,houseowner,3000,6);
			format(tmp,256,"house%d_int",thouseid);
			format(tmp2x,256,"house%d_xteleport",thouseid);
			format(tmp2y,256,"house%d_yteleport",thouseid);
			format(tmp2z,256,"house%d_zteleport",thouseid);
			houseid[playerid] = thouseid;
			SetPlayerInterior(playerid,dini_Int("houses",tmp));
			SetPlayerPos(playerid,dini_Int("houses",tmp2x),dini_Int("houses",tmp2y),dini_Int("houses",tmp2z));
			new tmp3x[256], tmp3y[256], tmp3z[256];
			format(tmp3x,256,"house%d_x2",thouseid);
			format(tmp3y,256,"house%d_y2",thouseid);
			format(tmp3z,256,"house%d_z2",thouseid);
			gCurrentCheckpoint[playerid] = 11;
			SetPlayerCheckpoint(playerid,dini_Int("houses",tmp3x),dini_Int("houses",tmp3y),dini_Int("houses",tmp3z),2.0);
			}
		}
	if(pickupid == 0 || pickupid == 1 || pickupid == 2)
		{
		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Write now the passport password (without /, just write it).");
		RequestingPassport[playerid] = 1;
		}
	if(pickupid == 6 || pickupid == 7)
		{
		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Hello, What are you looking for? You can use these cmds whenever inside bank.");
		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Bank Money ---------------- /bank [AMOUNT]");
		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Extract Money ------------- /withdraw [AMOUNT]");
		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] See Your Banked Money ----- /balance");
		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Send Money From Your Account To Someone Elses ----- /wire [ID] [AMOUNT]");
		new Float:pX, Float:pY, Float:pZ;
        GetPlayerPos(playerid,pX,pY,pZ);
        PlayerPlaySound(playerid,1056,pX,pY,pZ);
        }
   	if(pickupid == 8)
   		{
   		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Hello, are you going to play lotto? You can buy a max of 5 tickets.");
		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Buy lotto ticket ($3) ----- /lotto [number1][number2][number3]");
		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] See Jackpot --------------- /jackpot");
		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] See your numbers ---------- /mylotto");
		new Float:pX, Float:pY, Float:pZ;
        GetPlayerPos(playerid,pX,pY,pZ);
        PlayerPlaySound(playerid,1056,pX,pY,pZ);
        }
  	if(pickupid == 10)
       	{
       	PlayerBank[playerid] = lsb;
       	SetPlayerPos(playerid, 2305.7231, -16.1193, 26.7496);
       	}
   	if(pickupid == 11)
       	{
       	PlayerBank[playerid] = sfb;
       	SetPlayerPos(playerid, 2305.7231, -16.1193, 26.7496);
       	}
	if(pickupid == 17 || pickupid == 18)//LS SHOP
       	{
		SendClientMessage(playerid,COLOR_YELLOW,"[INFO] Hello, How can we help you? You may buy items from the list below.");
		SendClientMessage(playerid,COLOR_YELLOW,"[INFO] Type /bphone to buy a phone for $150");
		SendClientMessage(playerid,COLOR_YELLOW,"[INFO] Type /bflowers to buy flowers for $50");
		SendClientMessage(playerid,COLOR_YELLOW,"[INFO] Type /bgolf to buy a golf club for $85");
		PlayerShop[playerid] = 1;
       	}
	if(pickupid == 12)
	   	{
       	PlayerBank[playerid] = lvb;
       	SetPlayerPos(playerid, 2305.7231, -16.1193, 26.7496);
       	}
    if(pickupid == 14)//ring 2
	   	{
       	if (boxer2[playerid] == 0)
	   		{
	       	SetPlayerPos(playerid, 758.7404,13.1790,1001.1639);
    	   	boxer2[playerid] = 1;
       		}
       	else if (boxer2[playerid] == 1)
	       	{
	       	SetPlayerPos(playerid, 762.8611,9.0101,1001.1639);
	       	boxer2[playerid] = 2;
	       	}
        else if (boxer2[playerid] == 2)
	        {
	        SendClientMessage(playerid,COLOR_YELLOW,"[INFO] Fight Alredy In Progress, If You Wish To Make A Bet Please Go To The Cash Pickup");
	        }
        }
    if(pickupid == 15)
    	{
    	SetPlayerPos(playerid, 217.7648, 121.3172, 999.0156);
    	SetPlayerInterior(playerid,10);
    	}
    if(pickupid == 16)
    	{
    	SetPlayerPos(playerid, -1589.3926, 716.3294, -5.2422);
    	SetPlayerInterior(playerid,0);
    	}
    if(pickupid == 9)
    	{
    	if(PlayerBank[playerid] == lsb)
    		{
    		SetPlayerPos(playerid,1444.2338,-2285.6555,13.5469);
    		PlayerBank[playerid] = 0;
    		}
    	else if(PlayerBank[playerid] == sfb)
    		{
    		SetPlayerPos(playerid,-1939.7904,417.1500,35.1719);
    		PlayerBank[playerid] = 0;
    		}
    	else if(PlayerBank[playerid] == lvb)
    		{
    		SetPlayerPos(playerid,1931.2278,1332.9600,9.9688);
    		PlayerBank[playerid] = 0;
    		}
    	}
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}


//----------------------------------------------------------COMMANDS-------------------------------------------------------------------------------
public OnPlayerCommandText(playerid, cmdtext[])
{
	printf("[command]%s(id:%d)(%s)",PlayerName(playerid),playerid,cmdtext);
	new
	i,
	s[16],
	Float:f,
	c,
	d;
	sscanf("42 hello 5.7 j 11", "isfcd", i, s, f, c, d);
	if((strcmp(cmdtext, "/cmd", true) == 0) || (strcmp(cmdtext, "/cmds", true) == 0) || (strcmp(cmdtext, "/commands", true) == 0) || (strcmp(cmdtext, "/command", true) == 0))
 		{
 		SendClientMessage(playerid, COLOR_GREEN, "Command List:");
 		SendClientMessage(playerid, COLOR_GREY, "**PLAYER**: /911 /phone /medic /lock /unlock /laws /calltaxi /paytaxi /givecash /vid /say");
 		SendClientMessage(playerid, COLOR_GREY, "/mylotto /me /bribe /peat /hire /payguard /kills /deaths /jails /hitman /bounties /gasloc /ancmd");
 		SendClientMessage(playerid, COLOR_GREY, "/surrender /buycar /sellcar");
 		SendClientMessage(playerid, COLOR_GREY, "**COPS**: /disarm /jail /a /suspect /bribeacc /bribedec /dep /block /unblock /radiohelp /pullin");
 		SendClientMessage(playerid, COLOR_GREY, "**JOBS**: /heal /taxi /pizza /bodyduty");
 		SendClientMessage(playerid, COLOR_GREY, "**BUSSINESS**: /ad (go on forums for get bussiness)");
 		SendClientMessage(playerid, COLOR_GREY, "**IN-BANK**: /bank /withdraw /balance /wire /lotto /jackpot");
 		SendClientMessage(playerid, COLOR_GREY, "Do /help <command> for get help for a specific cmd. Example: /help bribe");
 		SendClientMessage(playerid, COLOR_YELLOW, "Commands and features are continuily added");
 		return 1;
 		}
 	if(strcmp(cmdtext, "/ancmd", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_GREY, "/surrender = Hands Up    /dance = Dance action   /drunk = walk like a drunk man  /bomb = planting a bomb animation");
 		SendClientMessage(playerid, COLOR_GREY, "/arrest = Police arrest with gun  /lay = Lay Down   /cover = Take cover   /kiss = Kiss someone");
 		SendClientMessage(playerid, COLOR_GREY, "/piss = start to piss   /smoke = start to smoke   /sit = Sitting down   /fu = ****   /deal = Deal like a drugs dealer");
 		SendClientMessage(playerid, COLOR_GREY, "/death = Death crawling   /slapass = Slap someone's ass   /wave = wave to somebody   /coplook = look for robbers");
 		SendClientMessage(playerid, COLOR_GREY, "/vomit = puke   /eat = eat a burger   /rob = rob the place   /laugh = laugh   /lookout = lookout for cops");
 		SendClientMessage(playerid, COLOR_GREY, "/fsmoking = smoke like a female   /slapped = get slapped on the ***   /coparrest = arrest someone");
 		SendClientMessage(playerid, COLOR_GREY, "/crack = dieing of crack    /arrested = you getting arrested   /injured = you are injured   /wankin = start wanking");
 		return 1;
 		}
 	if(strcmp(cmdtext, "/gasloc", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_GREEN, "Gas stations are located at:");
 		SendClientMessage(playerid, COLOR_GREY, "LV South, The Strip -- LV SouthEast, Come-a-lot");
 		SendClientMessage(playerid, COLOR_GREY, "LV Central, Bonecounty -- LV NorthWest, Tierra Robada");
 		SendClientMessage(playerid, COLOR_GREY, "SF NorthWest, Juniper Hollow -- SF East, Easter Basin");
 		SendClientMessage(playerid, COLOR_GREY, "LS SouthWest, Angel Pine -- LS SouthWest, Whetstone");
 		SendClientMessage(playerid, COLOR_GREY, "LS Central, Idlewood -- LS West, Flint County");
 		SendClientMessage(playerid, COLOR_GREY, "LS North, montgomery -- LS North, Dillimore");
 		SendClientMessage(playerid, COLOR_GREY, "LV NorthWest, South Tierra Robada -- LV North, Spiny Bed");
 		SendClientMessage(playerid, COLOR_GREY, "LV North, Emerald Isle......");
 		return 1;
 		}
  	if(strcmp(cmdtext, "/kills", true) == 0)
 		{
 		new temp[256];
 		new NumberKills;
 		NumberKills = dUserINT(PlayerName(playerid)).("kills");
		format(temp, sizeof(temp), "[STATS] Number of murders you have commited: %d",NumberKills);
		SendClientMessage(playerid,COLOR_GREEN,temp);
 		return 1;
 		}
	if(strcmp(cmdtext, "/deaths", true) == 0)
 		{
 		new temp[256];
 		new NumberDeaths;
		NumberDeaths = dUserINT(PlayerName(playerid)).("deaths");
		format(temp, sizeof(temp), "[STATS] Number of deaths: %d",NumberDeaths);
		SendClientMessage(playerid,COLOR_GREEN,temp);
 		return 1;
 		}
  	if(strcmp(cmdtext, "/jails", true) == 0)
 		{
 		new temp[256];
 		new NumberJails;
		NumberJails = dUserINT(PlayerName(playerid)).("jail");
		format(temp, sizeof(temp), "[STATS] Number of jailed people: %d",NumberJails);
		SendClientMessage(playerid,COLOR_GREEN,temp);
 		return 1;
 		}
//----------------------------------BODYGUARD JOB----------------------------------------------
	if(strcmp(cmdtext, "/bodyduty", true) == 0)
		{
		if (bodyduty[playerid] == 0)
			{
			if(gTeam[playerid] == TEAM_CITIZEN_LS)
				{
				gTeam[playerid] = TEAM_BODYGUARD;
				citizenls[playerid] = 1;
				bodyduty[playerid] = 0;
				new temp[256];
				new bname[256];
				GetPlayerName(playerid, bname, sizeof(bname));
				format(temp, sizeof(temp), "[INFO] %s is offering services as a body guard type /hire %d [PAY] [JOB DETAILS] to hire him",bname,playerid);
				SendClientMessageToAll(COLOR_BLUE,temp);
				}
			if(gTeam[playerid] == TEAM_CITIZEN_LV)
				{
				gTeam[playerid] = TEAM_BODYGUARD;
				citizenlv[playerid] = 1;
				bodyduty[playerid] = 0;
				new temp[256];
				new bname[256];
				GetPlayerName(playerid, bname, sizeof(bname));
				format(temp, sizeof(temp), "[INFO] %s is offering services as a body guard type /hire %d [PAY] [JOB DETAILS] to hire him",bname,playerid);
				SendClientMessageToAll(COLOR_BLUE,temp);
				}
			if(gTeam[playerid] == TEAM_CITIZEN_SF)
				{
				gTeam[playerid] = TEAM_BODYGUARD;
				citizensf[playerid] = 1;
				bodyduty[playerid] = 0;
				new temp[256];
				new bname[256];
				GetPlayerName(playerid, bname, sizeof(bname));
				format(temp, sizeof(temp), "[INFO] %s is offering services as a body guard type /hire %d [PAY] [JOB DETAILS] to hire him",bname,playerid);
				SendClientMessageToAll(COLOR_BLUE,temp);
				}
			}
		else if (bodyduty[playerid] == 1)
			{
			if (citizensf[playerid] == 1)
				{
				bodyduty[playerid] = 0;
				gTeam[playerid] = TEAM_CITIZEN_SF;
				SendClientMessage(playerid,COLOR_YELLOW,"[INFO] You have quit your job");
				}
			if (citizenls[playerid] == 1)
				{
				bodyduty[playerid] = 0;
				gTeam[playerid] = TEAM_CITIZEN_LS;
				SendClientMessage(playerid,COLOR_YELLOW,"[INFO] You have quit your job");
				}
			if (citizenlv[playerid] == 1)
				{
				bodyduty[playerid] = 0;
				gTeam[playerid] = TEAM_CITIZEN_LV;
				SendClientMessage(playerid,COLOR_YELLOW,"[INFO] You have quit your job");
				}
			}
		return 1;
		}
    if(strcmp(cmdtext, "/repairduty", true) == 0)
		{
		if (repairduty[playerid] == 0)
			{
			if(gTeam[playerid] == TEAM_CITIZEN_LS)
				{
				gTeam[playerid] = TEAM_MECHANIC;
				citizenls[playerid] = 1;
				bodyduty[playerid] = 0;
				new temp[256];
				new bname[256];
				GetPlayerName(playerid, bname, sizeof(bname));
				format(temp, sizeof(temp), "[INFO] %s is offering services for vehicle repair, phone him on /repair %d [LOCATION]",bname,playerid);
				SendClientMessageToAll(COLOR_BLUE,temp);
				}
			if(gTeam[playerid] == TEAM_CITIZEN_LV)
				{
				gTeam[playerid] = TEAM_MECHANIC;
				citizenlv[playerid] = 1;
				bodyduty[playerid] = 0;
				new temp[256];
				new bname[256];
				GetPlayerName(playerid, bname, sizeof(bname));
				format(temp, sizeof(temp), "[INFO] %s is offering services for vehicle repair, phone him on /repair %d [LOCATION]",bname,playerid);
				SendClientMessageToAll(COLOR_BLUE,temp);
				}
			if(gTeam[playerid] == TEAM_CITIZEN_SF)
				{
				gTeam[playerid] = TEAM_MECHANIC;
				citizensf[playerid] = 1;
				bodyduty[playerid] = 0;
				new temp[256];
				new bname[256];
				GetPlayerName(playerid, bname, sizeof(bname));
				format(temp, sizeof(temp), "[INFO] %s is offering services for vehicle repair, phone him on /repair %d [LOCATION]",bname,playerid);
				SendClientMessageToAll(COLOR_BLUE,temp);
				}
			}
		else if (bodyduty[playerid] == 1)
			{
			if (citizensf[playerid] == 1)
				{
				bodyduty[playerid] = 0;
				gTeam[playerid] = TEAM_CITIZEN_SF;
				SendClientMessage(playerid,COLOR_RED,"[INFO] You have quit your job");
				}
			if (citizenls[playerid] == 1)
				{
				bodyduty[playerid] = 0;
				gTeam[playerid] = TEAM_CITIZEN_LS;
				SendClientMessage(playerid,COLOR_RED,"[INFO] You have quit your job");
				}
			if (citizenlv[playerid] == 1)
				{
				bodyduty[playerid] = 0;
				gTeam[playerid] = TEAM_CITIZEN_LV;
				SendClientMessage(playerid,COLOR_RED,"[INFO] You have quit your job");
				}
			}
		return 1;
		}
	if(strcmp(cmdtext, "/ahire", true) == 0)
		{
		if(gTeam[playerid] != TEAM_BODYGUARD)
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You must be bodyguard doing /bodyduty for accept a hire");
			}
		else if(bodyduty[playerid] > 0)
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You are aldery on duty. Wait for be payed or do /resign");
			SendClientMessage(playerid, COLOR_RED, "[INFO] for finish your job without paid.");
			}
		else if(bodyduty[playerid] == 0)
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] Nobody tried to hire you yet. Remember that you can always advertise");
			SendClientMessage(playerid, COLOR_RED, "[INFO] your job to everybody playing doing /ad, it costs $500.");
			}
		else
			{
			bodyduty[playerid] = bodyduty[playerid]+(bodyduty[playerid]*-2);
			bodyguard[bodyowner[playerid]][playerid] = 1;
			SendClientMessage(playerid, COLOR_GREEN, "[INFO] Job accepted. Remember that who hired you must pay you doing");
			new tmp[256];
			format(tmp,256,"[INFO] /payguard %d.", playerid);
			SendClientMessage(playerid, COLOR_YELLOW, tmp);
			SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Do /guardhelp for a list of commands");
			SendClientMessage(bodyowner[playerid], COLOR_GREEN, "[INFO] Job accepted. Remember that you must pay him doing");
			SendClientMessage(bodyowner[playerid], COLOR_GREEN, tmp);
			}
		return 1;
		}
	if(strcmp(cmdtext, "/dhire", true) == 0)
		{
		if(gTeam[playerid] != TEAM_BODYGUARD)
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You must be bodyguard doing /bodyduty for decline a hire");
			}
		else if(bodyduty[playerid] > 0)
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You are aldery a bodyguard. Wait for be payed or do /resign");
			SendClientMessage(playerid, COLOR_RED, "[INFO] for finish your job without paid.");
			}
		else if(bodyduty[playerid] == 0)
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] Nobody tried to hire you yet. Remember that you can always advertise");
			SendClientMessage(playerid, COLOR_RED, "[INFO] your job to everybody playing doing /ad, it costs $500.");
			}
		else
			{
			bodyduty[playerid] = 0;
			SendClientMessage(playerid, COLOR_GREEN, "[INFO] Job declined. You still are a bodyguard, do /bodyduty for be no more.");
			SendClientMessage(bodyowner[playerid], COLOR_RED, "[INFO] Job declined by bodyguard.");
			bodyowner[playerid] = 999;
			}
		return 1;
		}
	if(strcmp(cmdtext, "/resign", true) == 0)
		{
		if(gTeam[playerid] != TEAM_BODYGUARD)
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You must be bodyguard doing /bodyduty for resign.");
			}
		else if(bodyduty[playerid] < 0)
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You aren't a bodyguard right now, but someone tried to hire you");
			SendClientMessage(playerid, COLOR_RED, "[INFO] before. You can accept doing /ahire or decline with /dhire.");
			}
		else if(bodyduty[playerid] == 0)
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] Nobody tried to hire you yet. Remember that you can always advertise");
			SendClientMessage(playerid, COLOR_RED, "[INFO] your job to everybody playing doing /ad, it costs $500.");
			}
		else
			{
			bodyduty[playerid] = 0;
			SendClientMessage(playerid, COLOR_RED, "[INFO] You have resigned your job.");
			new tmp[256];
			format(tmp,256,"[INFO] The bodyguard %s has resigned",PlayerName(playerid));
			SendClientMessage(bodyowner[playerid], COLOR_RED, tmp);
			bodyowner[playerid] = 999;
			bodyduty[playerid] = 0;
			bodyguard[bodyowner[playerid]][playerid] = 0;
			bodyowner[playerid] = 999;
			}
		return 1;
		}
	if(strcmp(cmdtext, "/tf", true) == 0)
		{
		if(gTeam[playerid] == TEAM_BODYGUARD)
			{
			new tmp[256];
			format(tmp, sizeof(tmp), "[RADIO] Security Guard %s : Taking fire, need asistance!!",PlayerName(playerid));
			SendClientMessageForTeam(TEAM_BODYGUARD,COLOR_BLUE,tmp);
			}
		else if (gTeam[playerid] == TEAM_POLICE_LS || gTeam[playerid] == TEAM_POLICE_SF || gTeam[playerid] == TEAM_POLICE_LV)
			{
			new tmp[256];
			format(tmp, sizeof(tmp), "[RADIO] Officer %s : Taking fire, need asistance!!",PlayerName(playerid));
			SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_BLUE,tmp);
			SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_BLUE,tmp);
			SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_BLUE,tmp);
			}
		else
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You must be bodyguard or cop for use this command.");
			}
		return 1;
		}
	if(strcmp(cmdtext, "/bk", true) == 0)
		{
		if(gTeam[playerid] == TEAM_BODYGUARD)
			{
			new tmp[256];
			format(tmp, sizeof(tmp), "[RADIO] Security Guard %s : Need backup!!",PlayerName(playerid));
			SendClientMessageForTeam(TEAM_BODYGUARD,COLOR_BLUE,tmp);
			}
		else if (gTeam[playerid] == TEAM_POLICE_LS || gTeam[playerid] == TEAM_POLICE_SF || gTeam[playerid] == TEAM_POLICE_LV)
			{
			new tmp[256];
			format(tmp, sizeof(tmp), "[RADIO] Officer %s : Need backup!!",PlayerName(playerid));
			SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_BLUE,tmp);
			SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_BLUE,tmp);
			SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_BLUE,tmp);
			}
		else
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You must be bodyguard or cop for use this command.");
			}
		return 1;
		}
	if(strcmp(cmdtext, "/pa", true) == 0)
		{
		if(gTeam[playerid] == TEAM_BODYGUARD)
			{
			new tmp[256];
			format(tmp, sizeof(tmp), "[RADIO] Security Guard %s : Need police assistance!!",PlayerName(playerid));
			SendClientMessageForTeam(TEAM_BODYGUARD,COLOR_BLUE,tmp);
			SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_BLUE,tmp);
			SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_BLUE,tmp);
			SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_BLUE,tmp);
			}
		else
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You must be bodyguard for use this command.");
			}
		return 1;
		}
	if(strcmp(cmdtext, "/rs", true) == 0)
		{
		if(gTeam[playerid] == TEAM_BODYGUARD)
			{
			new tmp[256];
			format(tmp, sizeof(tmp), "[RADIO] Security Guard %s : I'm going to backup you!",PlayerName(playerid));
			SendClientMessageForTeam(TEAM_BODYGUARD,COLOR_BLUE,tmp);
			}
		else if (gTeam[playerid] == TEAM_POLICE_LS || gTeam[playerid] == TEAM_POLICE_SF || gTeam[playerid] == TEAM_POLICE_LV)
			{
			new tmp[256];
			format(tmp, sizeof(tmp), "[RADIO] Officer %s : I'm going to backup you!",PlayerName(playerid));
			SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_BLUE,tmp);
			SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_BLUE,tmp);
			SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_BLUE,tmp);
			}
		else
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You must be bodyguard or cop for use this command.");
			}
		return 1;
		}
	if(strcmp(cmdtext, "/radiohelp", true) == 0)
		{
		if (gTeam[playerid] == TEAM_POLICE_LS || gTeam[playerid] == TEAM_POLICE_SF || gTeam[playerid] == TEAM_POLICE_LV || gTeam[playerid] == TEAM_BODYGUARD)
			{
			SendClientMessage(playerid, COLOR_GREY, "For use the radio do /radio [message]. You can also use");
			SendClientMessage(playerid, COLOR_GREY, "some short commands for emergency calls:");
			SendClientMessage(playerid, COLOR_GREY, "/tf = 'Taking fire, need asistance!!'");
			SendClientMessage(playerid, COLOR_GREY, "/bk = 'Need backup!!'");
			SendClientMessage(playerid, COLOR_GREY, "/rs = 'I'm going to backup you!'");
			SendClientMessage(playerid, COLOR_GREY, "/pa (just bodyguards) = 'Need police assistance!!'");
			}
		else
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You must be bodyguard or cop for use this command.");
			}
		return 1;
		}
//-----------------------------------------------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/bphone", true) == 0)
 		{
		if(PlayerShop[playerid] == 1)
			{
			if (GetPlayerMoney(playerid) > 149)
				{
				SendClientMessage(playerid, COLOR_GREEN, "[INFO] You have bought a phone you can now use it by doing /phone [ID] [MESSAGE]");
				GivePlayerMoneyEx(playerid,-150,"buying phone");
				Phone[playerid] = 1;
				dUserSet(PlayerName(playerid)).("Phone",Phone[playerid]);
				}
			else
				{
				SendClientMessage(playerid,COLOR_RED,"[INFO] You dont have enough money");
				}
			}
		else
			{
			SendClientMessage(playerid,COLOR_RED,"[INFO] You are not in a shop");
			}
 		return 1;
 		}
  	if(strcmp(cmdtext, "/bflowers", true) == 0)
 		{
		if(PlayerShop[playerid] == 1)
			{
			if (GetPlayerMoney(playerid) > 49)
				{
				SendClientMessage(playerid, COLOR_GREEN, "[INFO] You have bought flowers");
				GivePlayerMoneyEx(playerid,-50,"buying flowers");
				GivePlayerWeapon(playerid,14,1);
				}
			else
				{
				SendClientMessage(playerid,COLOR_RED,"[INFO] You dont have enough money");
				}
			}
		else
			{
			SendClientMessage(playerid,COLOR_RED,"[INFO] You are not in a shop");
			}
 		return 1;
 		}
	if(strcmp(cmdtext, "/bgolf", true) == 0)
 		{
		if(PlayerShop[playerid] == 1)
			{
			if (GetPlayerMoney(playerid) > 84)
				{
				SendClientMessage(playerid, COLOR_GREEN, "[INFO] You have bought a golf club");
				GivePlayerMoneyEx(playerid,-85,"buying golf stick");
				GivePlayerWeapon(playerid,2,1);
				}
			else
				{
				SendClientMessage(playerid,COLOR_RED,"[INFO] You dont have enough money");
				}
			}
		else
			{
			SendClientMessage(playerid,COLOR_RED,"[INFO] You are not in a shop");
			}
 		return 1;
 		}
 	if(strcmp(cmdtext, "/taxipay", true) == 0)
 		{
 		if (TaxiService[playerid])
 			{
 			SendClientMessage(playerid, COLOR_RED, "[INFO] You are currently the taxi driver!");
 			}
 		else
 			{
 			if(IsPlayerInAnyVehicle(playerid))
 				{
 				new p = GetPlayerVehicleID(playerid);
 				for(new z=0;z<MAX_PLAYERS;z++)
	 				{
 					if(TaxiCar[z]==p)
 						{
 						if(TaxiService[z])
 							{
 							GivePlayerMoneyEx(playerid,-TaxiPrice[z],"paying taxi");
 							GivePlayerMoneyEx(z,TaxiPrice[z],"get payed taxi");
 							SendClientMessage(playerid, COLOR_GREEN, "[INFO] You payed now");
	 						SendClientMessage(z, COLOR_GREEN, "[INFO] Your passanger payed you!");
	 						}
 						}
 					}
 				}
 			else
 				{
 				SendClientMessage(playerid, COLOR_RED, "[INFO] You must be passanger in a taxi offering services for use this command!");
 				}
 			}
 		return 1;
 		}
	if(strcmp(cmdtext, "/peat", true) == 0)
 		{
 		if (PizzaService[playerid])
 			{
 			SendClientMessage(playerid, COLOR_RED, "[INFO] You cant eat the pizzas you are delivering.");
 			}
 		else
 			{
 			for(new z=0;z<MAX_PLAYERS;z++)
 				{
				if(GetDistanceBetweenPlayers(playerid, z) < 5)
					{
 					GivePlayerMoneyEx(playerid,-PizzaPrice[z],"paying pizza");
 					GivePlayerMoneyEx(z,PizzaPrice[z],"get payed pizza");
 					
 					SetPlayerHealth(playerid,100);
 					ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.00, 0, 0, 0, 0, 0); // Eat Burger
      				SendClientMessage(playerid, COLOR_GREEN, "[INFO] You are eating your pizza");
 					SendClientMessage(playerid, COLOR_YELLOW, "[INFO] You payed now Enjoy Your Meal");
 					SendClientMessage(z, COLOR_GREEN, "[INFO] Your customer payed you");
 					}
				else
 					{
 					SendClientMessage(playerid, COLOR_RED, "[INFO] No Pizza Deliverer Around");
 					}
 				}
 			}
 		return 1;
 		}
	if(strcmp(cmdtext, "/rules", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] You must read the rules in http://www.comptoncity.ar.nu/ before playing");
 		return 1;
 		}
	if(strcmp(cmdtext, "/reload_ownerships", true) == 0)
		{
		if(IsPlayerAdmin(playerid))
			{
			for(new w=1; w<700; w++)
				{
				new ww[256];
				format(ww, 256, "car%d", w);
				gOwner[w] = dUserINT("car_ownerships").(ww);
				}
			return 1;
			}
		}
	if(strcmp(cmdtext, "/reload_game", true) == 0)
	{
		if(IsPlayerAdmin(playerid))
			{
			GameModeExit();
			return 1;
			}
	}
	if(strcmp(cmdtext, "/reload_locks", true) == 0)
	{
		if(IsPlayerAdmin(playerid))
			{
			for(new y=1; y<700; y++)
			{
			new yy[256];
			format(yy, 256, "car%d", y);
			gLocked[y] = dUserINT("car_locks").(yy);
			}
			return 1;
			}
	}
 	if(strcmp(cmdtext, "/lock", true) == 0)
 		{
 		if(IsPlayerInAnyVehicle(playerid))
 			{
 			new tmpid;
 			tmpid = GetPlayerVehicleID(playerid);
 			if(gOwner[tmpid] == gPlayerid[playerid])
 				{
 				gLocked[tmpid] = 1;
 				new tmpstr[256];
 				format(tmpstr, 256, "car%d", tmpid);
 				dini_IntSet("car_locks",tmpstr,1);
 				SendClientMessage(playerid, COLOR_GREEN, "[INFO] Vehicle locked!");
             	new Float:pX, Float:pY, Float:pZ;
            	GetPlayerPos(playerid,pX,pY,pZ);
            	PlayerPlaySound(playerid,1056,pX,pY,pZ);
            	}
            else
            	{
            	SendClientMessage(playerid, COLOR_RED, "[INFO] You cant lock it, this isnt your vehicle.");
            	}
            }
    	else
            {
            SendClientMessage(playerid, COLOR_RED, "[INFO] You must be in your vehicle for lock it.");
            }
		return 1;
     	}
    if(strcmp(cmdtext, "/unlock", true) == 0)
 		{
 		if(IsPlayerInAnyVehicle(playerid))
 			{
 			new tmpid;
 			tmpid = GetPlayerVehicleID(playerid);
 			if(gOwner[tmpid] == gPlayerid[playerid])
 				{
 				gLocked[tmpid] = 0;
 				new tmpstr[256];
 				format(tmpstr, 256, "car%d", tmpid);
 				dini_IntSet("car_locks",tmpstr,0);
 				SendClientMessage(playerid, COLOR_GREEN, "[INFO] Vehicle unlocked!");
             	new Float:pX, Float:pY, Float:pZ;
            	GetPlayerPos(playerid,pX,pY,pZ);
            	PlayerPlaySound(playerid,1056,pX,pY,pZ);
            	}
            else
            	{
            	SendClientMessage(playerid, COLOR_RED, "[INFO] You cant unlock it, this isnt your vehicle.");
            	}
            }
    	else
            {
            SendClientMessage(playerid, COLOR_RED, "[INFO] You must be in your vehicle for unlock it.");
            }
        return 1;
     	}
 	if(strcmp(cmdtext, "/vid", true) == 0)
 		{
 		new tmp,str[256];
 		tmp = GetPlayerVehicleID(playerid);
 		format(str,256,"[INFO] Vehicle id: %d",tmp);
 		SendClientMessage(playerid, COLOR_YELLOW, str);
 		return 1;
 		}
 	if(strcmp(cmdtext, "/myid", true) == 0)
 		{
 		new str[256];
 		format(str, 256, "[INFO] You are the player number %d", gPlayerid[playerid]);
 		SendClientMessage(playerid, COLOR_RED, str);
 		return 1;
 		}
 	if(strcmp(cmdtext, "/mylotto", true) == 0)
 		{
 		if (dUserINT(PlayerName(playerid)).("ticketnumber") == 0)
 			{
 			SendClientMessage(playerid, COLOR_RED, "[INFO] You dont have lotto tickets. Buy them on the bank for $3");
 			}
 		else if(dUserINT(PlayerName(playerid)).("ticketnumber") == 1)
 			{
 			new str[256];
 			format(str, 256, "[INFO] Ticket 1 = %d-%d-%d", dUserINT(PlayerName(playerid)).("1_1"), dUserINT(PlayerName(playerid)).("1_2"), dUserINT(PlayerName(playerid)).("1_3"));
 			SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Your ticket numbers are:");
 			SendClientMessage(playerid, COLOR_YELLOW, str);
 			}
 		else if(dUserINT(PlayerName(playerid)).("ticketnumber") == 2)
 			{
 			new str[256], str2[256];
 			format(str, 256, "[INFO] Ticket 1 = %d-%d-%d", dUserINT(PlayerName(playerid)).("1_1"), dUserINT(PlayerName(playerid)).("1_2"), dUserINT(PlayerName(playerid)).("1_3"));
 			format(str2, 256, "[INFO] Ticket 2 = %d-%d-%d", dUserINT(PlayerName(playerid)).("2_1"), dUserINT(PlayerName(playerid)).("2_2"), dUserINT(PlayerName(playerid)).("2_3"));
 			SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Your ticket numbers are:");
 			SendClientMessage(playerid, COLOR_YELLOW, str);
 			SendClientMessage(playerid, COLOR_YELLOW, str2);
 			}
 		else if(dUserINT(PlayerName(playerid)).("ticketnumber") == 3)
 			{
			new str[256], str2[256], str3[256];
			format(str, 256, "[INFO] Ticket 1 = %d-%d-%d", dUserINT(PlayerName(playerid)).("1_1"), dUserINT(PlayerName(playerid)).("1_2"), dUserINT(PlayerName(playerid)).("1_3"));
			format(str2, 256, "[INFO] Ticket 2 = %d-%d-%d", dUserINT(PlayerName(playerid)).("2_1"), dUserINT(PlayerName(playerid)).("2_2"), dUserINT(PlayerName(playerid)).("2_3"));
			format(str3, 256, "[INFO] Ticket 3 = %d-%d-%d", dUserINT(PlayerName(playerid)).("3_1"), dUserINT(PlayerName(playerid)).("3_2"), dUserINT(PlayerName(playerid)).("3_3"));
			SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Your ticket numbers are:");
			SendClientMessage(playerid, COLOR_YELLOW, str);
			SendClientMessage(playerid, COLOR_YELLOW, str2);
			SendClientMessage(playerid, COLOR_YELLOW, str3);
			}
		else if(dUserINT(PlayerName(playerid)).("ticketnumber") == 4)
			{
			new str[256], str2[256], str3[256], str4[256];
			format(str, 256, "[INFO] Ticket 1 = %d-%d-%d", dUserINT(PlayerName(playerid)).("1_1"), dUserINT(PlayerName(playerid)).("1_2"), dUserINT(PlayerName(playerid)).("1_3"));
			format(str2, 256, "[INFO] Ticket 2 = %d-%d-%d", dUserINT(PlayerName(playerid)).("2_1"), dUserINT(PlayerName(playerid)).("2_2"), dUserINT(PlayerName(playerid)).("2_3"));
			format(str3, 256, "[INFO] Ticket 3 = %d-%d-%d", dUserINT(PlayerName(playerid)).("3_1"), dUserINT(PlayerName(playerid)).("3_2"), dUserINT(PlayerName(playerid)).("3_3"));
			format(str4, 256, "[INFO] Ticket 4 = %d-%d-%d", dUserINT(PlayerName(playerid)).("4_1"), dUserINT(PlayerName(playerid)).("4_2"), dUserINT(PlayerName(playerid)).("4_3"));
			SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Your ticket numbers are:");
			SendClientMessage(playerid, COLOR_YELLOW, str);
			SendClientMessage(playerid, COLOR_YELLOW, str2);
			SendClientMessage(playerid, COLOR_YELLOW, str3);
			SendClientMessage(playerid, COLOR_YELLOW, str4);
			}
		else if(dUserINT(PlayerName(playerid)).("ticketnumber") == 5)
			{
			new str[256], str2[256], str3[256], str4[256], str5[256];
			format(str, 256, "[INFO] Ticket 1 = %d-%d-%d", dUserINT(PlayerName(playerid)).("1_1"), dUserINT(PlayerName(playerid)).("1_2"), dUserINT(PlayerName(playerid)).("1_3"));
			format(str2, 256, "[INFO] Ticket 2 = %d-%d-%d", dUserINT(PlayerName(playerid)).("2_1"), dUserINT(PlayerName(playerid)).("2_2"), dUserINT(PlayerName(playerid)).("2_3"));
			format(str3, 256, "[INFO] Ticket 3 = %d-%d-%d", dUserINT(PlayerName(playerid)).("3_1"), dUserINT(PlayerName(playerid)).("3_2"), dUserINT(PlayerName(playerid)).("3_3"));
			format(str4, 256, "[INFO] Ticket 4 = %d-%d-%d", dUserINT(PlayerName(playerid)).("4_1"), dUserINT(PlayerName(playerid)).("4_2"), dUserINT(PlayerName(playerid)).("4_3"));
			format(str5, 256, "[INFO] Ticket 5 = %d-%d-%d", dUserINT(PlayerName(playerid)).("5_1"), dUserINT(PlayerName(playerid)).("5_2"), dUserINT(PlayerName(playerid)).("5_3"));
			SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Your ticket numbers are:");
			SendClientMessage(playerid, COLOR_YELLOW, str);
			SendClientMessage(playerid, COLOR_YELLOW, str2);
			SendClientMessage(playerid, COLOR_YELLOW, str3);
			SendClientMessage(playerid, COLOR_YELLOW, str4);
			SendClientMessage(playerid, COLOR_YELLOW, str5);
			}
		else
			{
			SendClientMessage(playerid, COLOR_RED, "-----------------------------------------------------------");
			SendClientMessage(playerid, COLOR_RED, "An error has ocurred when retrieving information:");
			SendClientMessage(playerid, COLOR_RED, "The lotto ticket number is different of 0, 1, 2, 3, 4 or 5");
			SendClientMessage(playerid, COLOR_RED, "Please, report it at forums in http://www.comptoncity.ar.nu, thanks.");
			SendClientMessage(playerid, COLOR_RED, "-----------------------------------------------------------");
			}
		return 1;
		}
	if(strcmp(cmdtext, "/lottoannounce", true) == 0)
		{
		if(IsPlayerAdmin(playerid))
			{
			GameTextForAll("Lottery numbers will be told in 2 minutes!",5000,6);
			SendClientMessageToAll(COLOR_ORANGE, "[ADMIN ANNOUNCE] Lottery numbers will be told in 2 minutes!");
			SetTimer("LottoAnnounce", 120000, 0);
			return 1;
			}
		}
	if(strcmp(cmdtext, "/balance", true) == 0)
 		{
		if(PlayerBank[playerid] != 0)
	 		{
	 		new tmp[256];
	 		format(tmp,256,"[INFO] Your Current Cash In the Bank Is $%d",dUserINT(PlayerName(playerid)).("Bank"));
		 	SendClientMessage(playerid, COLOR_GREEN, tmp);
		 	return 1;
		 	}
 		}
	if(strcmp(cmdtext, "/jackpot", true) == 0)
		{
		if(PlayerBank[playerid] != 0)
	 		{
			new tmp[256];
	 		format(tmp,256,"[INFO] The current jackpot is $%d and growing!",dini_Int("lotto","jackpot"));
	 		SendClientMessage(playerid, COLOR_GREEN, tmp);
			return 1;
			}
 		}
 	if(strcmp(cmdtext, "/bribecancel", true) == 0)
		{
		if(BribeTo[playerid] == 999)
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You arent bribing right now");
			}
		else
			{
			SendClientMessage(BribeTo[playerid], COLOR_RED, "[INFO] The bribe has been canceled.");
			Bribe[BribeTo[playerid]] = 0;
			BribeFrom[BribeTo[playerid]] = 999;
			BribeTo[playerid] = 999;
			SendClientMessage(playerid, COLOR_RED, "[INFO] The bribe has been canceled.");
			}
		return 1;
 		}
 	if(strcmp(cmdtext, "/bribeacc", true) == 0)
		{
		if(gTeam[playerid] == TEAM_POLICE_LS || gTeam[playerid] == TEAM_POLICE_SF || gTeam[playerid] == TEAM_POLICE_LV)
			{
			if(Bribe[playerid] == 0)
				{
				SendClientMessage(playerid, COLOR_RED, "[INFO] You arent being bribed.");
				}
			else
				{
				if(GetPlayerWantedLevel(BribeFrom[playerid]))
					{
					GivePlayerMoneyEx(playerid,Bribe[playerid],"getting bribed");
					GivePlayerMoneyEx(BribeFrom[playerid], -Bribe[playerid],"bribing");
					SendClientMessage(BribeFrom[playerid], COLOR_GREEN, "[INFO] Your bribe got accepted!");
					SendClientMessage(playerid, COLOR_RED, "[INFO] Bribe accepted. Remember that a honorous cop never do this.");
					SetPlayerWantedLevel(BribeFrom[playerid], 0);
					BribeTo[BribeFrom[playerid]] = 999;
					Bribe[playerid] = 0;
					BribeFrom[playerid] = 999;
					}
				else
					{
					SendClientMessage(playerid, COLOR_RED, "[INFO] He isn't wanted any more.");
					BribeTo[BribeFrom[playerid]] = 999;
					Bribe[playerid] = 0;
					BribeFrom[playerid] = 999;
					}
				}
			}
		return 1;
 		}
 	if(strcmp(cmdtext, "/bribedec", true) == 0)
		{
		if(gTeam[playerid] == TEAM_POLICE_LS || gTeam[playerid] == TEAM_POLICE_SF || gTeam[playerid] == TEAM_POLICE_LV)
			{
			if(BribeFrom[playerid] == 999)
				{
				SendClientMessage(playerid, COLOR_RED, "[INFO] You arent being bribed.");
				}
			else
				{
				SendClientMessage(BribeFrom[playerid], COLOR_RED, "[INFO] Your bribe got declined! You got reported.");
				SendClientMessage(playerid, COLOR_GREEN, "[INFO] Bribe declined. Remember that a honorous cop always do this.");
				WantedLevel(BribeFrom[playerid], "+1", "Bribing a policeman");
				BribeTo[BribeFrom[playerid]] = 999;
				Bribe[playerid] = 0;
				BribeFrom[playerid] = 999;
				}
			}
		return 1;
 		}
 	if(strcmp(cmdtext, "/sellacc", true) == 0)
		{
		if(Sell[playerid] == 0)
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] Nobody offered you a car.");
			}
		else
			{
			if(GetPlayerMoney(playerid) >= Sell[playerid])
				{
				if(!dUserINT(PlayerName(playerid)).("vehicles"))
					{
					dUserSetINT(PlayerName(playerid)).("vehicles",dini_Int(PlayerName(SellFrom[playerid]),"vehicles"));
					gOwner[dUserINT(PlayerName(playerid)).("vehicles")] = playerid;
					new tmp[256];
					format(tmp,256,"car%d",dUserINT(PlayerName(playerid)).("vehicles"));
					dini_IntSet("car_ownerships",tmp,gPlayerid[playerid]);
					dUserSetINT(PlayerName(SellFrom[playerid])).("vehicles",0);
					GivePlayerMoneyEx(playerid,-Sell[playerid],"buying car from player");
					GivePlayerMoneyEx(SellFrom[playerid], Sell[playerid],"selling car to player");
					SendClientMessage(SellFrom[playerid], COLOR_GREEN, "[INFO] You successfuly sold your vehicle!");
					SendClientMessage(playerid, COLOR_GREEN, "[INFO] Car successfuly bought!");
					SetPlayerWantedLevel(BribeFrom[playerid], 0);
					SellTo[SellFrom[playerid]] = 999;
					Sell[playerid] = 0;
					SellFrom[playerid] = 999;
					}
				else
					{
					SendClientMessage(playerid, COLOR_RED, "[INFO] You already have a vehicle.");
					SendClientMessage(SellFrom[playerid], COLOR_RED, "[INFO] Player already had a vehicle. Selling canceled.");
					SellTo[SellFrom[playerid]] = 999;
					Sell[playerid] = 0;
					SellFrom[playerid] = 999;
					}
				}
			else
				{
				SendClientMessage(playerid, COLOR_RED, "[INFO] You dont have enough money.");
				SendClientMessage(SellFrom[playerid], COLOR_RED, "[INFO] Player doesnt have enough money. Selling Cancelled.");
				SellTo[SellFrom[playerid]] = 999;
				Sell[playerid] = 0;
				SellFrom[playerid] = 999;
				}
			}
		return 1;
 		}
 	if(strcmp(cmdtext, "/selldec", true) == 0)
		{
		if(SellFrom[playerid] == 999)
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] Nobody offered you a car.");
			}
		else
			{
			SendClientMessage(SellFrom[playerid], COLOR_RED, "[INFO] The player havent accepted your offer.");
			SendClientMessage(playerid, COLOR_GREEN, "[INFO] Offer declined.");
			SellTo[SellFrom[playerid]] = 999;
			Sell[playerid] = 0;
			SellFrom[playerid] = 999;
			}
		return 1;
 		}
 	if(strcmp(cmdtext, "/sellcancel", true) == 0)
		{
		if(SellTo[playerid] == 999)
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You arent selling a car");
			}
		else
			{
			SendClientMessage(SellTo[playerid], COLOR_RED, "[INFO] The selling got cancelled.");
			SendClientMessage(playerid, COLOR_RED, "[INFO] The selling got cancelled.");
			Sell[SellTo[playerid]] = 0;
			SellFrom[SellTo[playerid]] = 999;
			SellTo[playerid] = 999;			
			}
		return 1;
 		}
	if(strcmp(cmdtext, "/jail", true) == 0)
		{
		if(gTeam[playerid] == TEAM_POLICE_LS || gTeam[playerid] == TEAM_POLICE_SF || gTeam[playerid] == TEAM_POLICE_LV)
			{
			for(new p=0;p<MAX_PLAYERS;p++)
				{
				if(IsPlayerConnected(p) && p != playerid && gTeam[p] != TEAM_POLICE_LS && gTeam[p] != TEAM_POLICE_SF && gTeam[p] != TEAM_POLICE_LV && gTeam[p] != TEAM_MEDIC_LS && gTeam[p] != TEAM_MEDIC_SF && gTeam[p] != TEAM_MEDIC_LV)
					{
					if(GetPlayerWantedLevel(p) > 0 && (InArea[p] == 1) && (AntiSpam[playerid][22] || AntiSpam[playerid][23] || AntiSpam[playerid][24]))
						{
						TogglePlayerControllable(p,1);
						KillTimer(ToJailTimer[p]);
						new str[256], str2[256];
						format(str,256,"[INFO] You jailed %s!",PlayerName(p));
						SendClientMessage(playerid, COLOR_GREEN, str);
						dUserSetINT(PlayerName(playerid)).("jail", (dUserINT(PlayerName(playerid)).("jail")) + 1);
						format(str2,256,"[INFO] You got jailed by %s.",PlayerName(playerid));
						SendClientMessage(p, COLOR_RED, str2);
						ResetPlayerWeapons(p);
						InArea[p] = 0;
						if(GetPlayerWantedLevel(p) == 1)
							{
							GivePlayerMoneyEx(playerid,50,"jailing level 1");
							SendClientMessage(playerid, COLOR_GREEN, "[INFO] You jailed a level 1 wanted person. You earned $50!");
							JailLeft[p] = 120;
							SetPlayerWantedLevel(p,0);
							}
						else if(GetPlayerWantedLevel(p) == 2)
							{
							GivePlayerMoneyEx(playerid,75,"jailing level 2");
							SendClientMessage(playerid, COLOR_GREEN, "[INFO] You jailed a level 2 wanted person. You earned $75!");
							JailLeft[p] = 210;
							SetPlayerWantedLevel(p,0);
							}
						else if(GetPlayerWantedLevel(p) == 3)
							{
							GivePlayerMoneyEx(playerid,100,"jailing level 3");
							SendClientMessage(playerid, COLOR_GREEN, "[INFO] You jailed a level 3 wanted person. You earned $100!");
							JailLeft[p] = 370;
							SetPlayerWantedLevel(p,0);
							}
						else if(GetPlayerWantedLevel(p) == 4)
							{
							GivePlayerMoneyEx(playerid,125,"jailing level 4");
							SendClientMessage(playerid, COLOR_GREEN, "[INFO] You jailed a level 4 wanted person. You earned $125!");
							JailLeft[p] = 420;
							SetPlayerWantedLevel(p,0);
							}
						else if(GetPlayerWantedLevel(p) == 5)
							{
							GivePlayerMoneyEx(playerid,150,"jailing level 5");
							SendClientMessage(playerid, COLOR_GREEN, "[INFO] You jailed a level 5 wanted person. You earned $150!");
							JailLeft[p] = 510;
							SetPlayerWantedLevel(p,0);
							}
						else if(GetPlayerWantedLevel(p) == 6)
							{
							GivePlayerMoneyEx(playerid,200,"jailing level 6");
							SendClientMessage(playerid, COLOR_GREEN, "[INFO] You jailed a level 6 wanted person. You earned $200!");
							JailLeft[p] = 600;
							SetPlayerWantedLevel(p,0);
							}
						if(AntiSpam[p][22]) //LV
							{
							Jailed[p]=3;
							SetPlayerPos(p, 198.6950,162.1082,1003.0300);
							}
						else if(AntiSpam[p][23]) //LS
							{
							Jailed[p]=1;
							SetPlayerPos(p, 264.1069,77.2034,1001.0391);
							}
						else if(AntiSpam[p][24]) //SF
							{
							Jailed[p]=2;
							SetPlayerPos(p, 219.4647,109.9648,999.0156);
							}
						}
					}	
				}
			}
		else
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You must be a cop for use this command!");
			}
		return 1;
		}
	if (strcmp("/bounties", cmdtext, true) == 0)
	{
		for(new j=0;j<MAX_PLAYERS;j++)
			{
			if(Hitman[j]>0)
				{
				new tmp[256];
				format(tmp,256,"[BOUNTY] %s: $%d",PlayerName(j),Hitman[j]);
				SendClientMessage(playerid,COLOR_GREEN,tmp);
				}
			}
		return 1;
	}
	if (strcmp("/block", cmdtext, true) == 0)
	{
		if(gTeam[playerid]==TEAM_POLICE_LS || gTeam[playerid]==TEAM_POLICE_SF || gTeam[playerid]==TEAM_POLICE_LV)
			{
			if(IsPlayerInAnyVehicle(playerid))
				{
				for(new j=0;j<MAX_PLAYERS;j++)
					{
					if(IsPlayerConnected(j))
						{
						if(GetPlayerVehicleID(j) == GetPlayerVehicleID(playerid) && GetPlayerState(j) == PLAYER_STATE_PASSENGER && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
							{
							Blocking[playerid] = 1;
							TogglePlayerControllable(j,0);
							SendClientMessage(j,COLOR_RED,"[INFO] A cop blocked the car doors.");
							}
						}
					}
				SendClientMessage(playerid, COLOR_GREEN, "[INFO] Everyone as passanger on the car cant get out.");
				}
			else
				{
				SendClientMessage(playerid, COLOR_RED, "[INFO] You must be in a vehicle to use this command");
				}
			}
		else
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You must be cop to use this command");
			}
		return 1;
	}
	if (strcmp("/unblock", cmdtext, true) == 0)
	{
		if(gTeam[playerid]==TEAM_POLICE_LS || gTeam[playerid]==TEAM_POLICE_SF || gTeam[playerid]==TEAM_POLICE_LV)
			{
			if(IsPlayerInAnyVehicle(playerid))
				{
				for(new j=0;j<MAX_PLAYERS;j++)
					{
					if(IsPlayerConnected(j))
						{
						if(GetPlayerVehicleID(j) == GetPlayerVehicleID(playerid) && GetPlayerState(j) == PLAYER_STATE_PASSENGER && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
							{
							Blocking[playerid] = 0;
							TogglePlayerControllable(j,1);
							SendClientMessage(j,COLOR_GREEN,"[INFO] A cop unblocked the car doors.");
							}
						}
					}
				SendClientMessage(playerid, COLOR_GREEN, "[INFO] Everyone as passanger on the car can get out.");
				}
			else
				{
				SendClientMessage(playerid, COLOR_RED, "[INFO] You must be in a vehicle to use this command.");
				}
			}
		else
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You must be cop to use this command.");
			}
		return 1;
	}
	if(strcmp("/a",cmdtext,true)==0)
	{
		if(gTeam[playerid] == TEAM_POLICE_LS || gTeam[playerid] == TEAM_POLICE_SF || gTeam[playerid] == TEAM_POLICE_LV)
			{
			new Float:fPos[3], Float:fPos2[3], temp[256],done;
			GetPlayerPos(playerid, fPos[0], fPos[1], fPos[2]);
			for(new z;z<MAX_PLAYERS;z++)
				{
				if(IsPlayerConnected(z) && z!=playerid)
					{
					done = 0;
					GetPlayerPos(z, fPos2[0], fPos2[1], fPos2[2]);
					if( fPos[0] - fPos2[0] > 10 || fPos2[0] - fPos[0] > 10 )
						{
						continue;
			    		}
					if( fPos[1] - fPos2[1] > 10 || fPos2[1] - fPos[1] > 10 ) 
						{
						continue;
						}
					if( fPos[2] - fPos2[2] > 20 || fPos2[2] - fPos[2] > 20 ) 
						{
						continue;
						}
					if(GetPlayerWantedLevel(z))
						{
						done = 1;
						GameTextForPlayer(z,"Do /surrender for surrender",5000,6);
						if(IsPlayerInAnyVehicle(z)) format(temp, 256, "[COP] %s: %s, get out of the vehicle and /surrender now!!",PlayerName(playerid),PlayerName(z));
						else format(temp, 256, "[COP] %s: %s, /surrender now!!",PlayerName(playerid),PlayerName(z));
						}
					if(done) SendClientMessage(z,COLOR_YELLOW,temp);
					}
				}
			}
		else
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You must be cop to use this command!");
			}
		return 1;
	}
	if(strcmp("/surrender",cmdtext,true)==0)
	{
		if(GetPlayerWantedLevel(playerid))
			{
			new Float:fPos[3], Float:fPos2[3];
			GetPlayerPos(playerid, fPos[0], fPos[1], fPos[2]);
			for(new z;z<MAX_PLAYERS;z++)
				{
				if(IsPlayerConnected(z) && z!=playerid && (gTeam[z] == TEAM_POLICE_LS || gTeam[z] == TEAM_POLICE_SF || gTeam[z] == TEAM_POLICE_LV))
					{
					GetPlayerPos(z, fPos2[0], fPos2[1], fPos2[2]);
					if( fPos[0] - fPos2[0] > 10 || fPos2[0] - fPos[0] > 10 )
						{
						continue;
			    		}
					if( fPos[1] - fPos2[1] > 10 || fPos2[1] - fPos[1] > 10 ) 
						{
						continue;
						}
					if( fPos[2] - fPos2[2] > 20 || fPos2[2] - fPos[2] > 20 ) 
						{
						continue;
						}
					TogglePlayerControllable(playerid,0);
					SendClientMessage(playerid,COLOR_RED,"[INFO] You surrendered, the cop has 2mins to pull you inside a vehicle");
					SendClientMessage(z,COLOR_GREEN,"[INFO] The criminal surrendered, you have 2mins to /pullin him inside a vehicle");
					SurrenderTimer[playerid] = SetTimerEx("Unfreeze",120000,0,"i",playerid);
					SurrenderTimerCheck[playerid] = 1;
					}
				}
			}
		else
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You must be cop to use this command!");
			}
		return 1;
	}
	if(strcmp("/buycar",cmdtext,true)==0)
	{
		if(!IsPlayerInAnyVehicle(playerid)) 
			{
			SendClientMessage(playerid,COLOR_RED,"[INFO] You must be inside the vehicle you want to buy");
			}
		else if(gOwner[GetPlayerVehicleID(playerid)])
			{
			new str2[256], str[256], str1[256], str0[256], strtmp[256];
			format(str0, 256, "%d", gOwner[GetPlayerVehicleID(playerid)]);
			format(str2,256,"%s",dini_Get("players",str0));
			format(str,256,"[INFO] Current vehicle owner is %s. If you want it, he must sell it to you.",str2);
			SendClientMessage(playerid,COLOR_RED,str);
			SendClientMessage(playerid,COLOR_YELLOW,"[INFO] It can also become avaible to buy if 15 days passed and the owned didnt got in");
			format(strtmp,256,"car%d_",GetPlayerVehicleID(playerid));
			format(str1,256,"[INFO] The last time the owner got in was %d day/s ago",dini_Int("car_ownerships",strtmp));
			SendClientMessage(playerid,COLOR_YELLOW,str1);
			}
		else if(CarPrice[GetVehicleModel(GetPlayerVehicleID(playerid))-400])
			{
			new str[256];
			format(str,256,"[INFO] This car is avaible for purchase for $%d, write yes for buy it or no for not",CarPrice[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
			SendClientMessage(playerid,COLOR_GREEN,str);
			BuyingCar[playerid] = GetPlayerVehicleID(playerid);
			}
		else 
			{
			SendClientMessage(playerid,COLOR_RED,"Vehicle not avaible for purchase");
			}
		return 1;
	}
	dcmd(hitman,6,cmdtext);
	dcmd(phone,5,cmdtext);
	dcmd(911,3,cmdtext);
	dcmd(medic,5,cmdtext);
	dcmd(ad,2,cmdtext);
	dcmd(taxi,4,cmdtext);
	dcmd(calltaxi,8,cmdtext);
	dcmd(me,2,cmdtext);
	dcmd(givecash,8,cmdtext);
	dcmd(agivecash,9,cmdtext);
	dcmd(say,3,cmdtext);
	dcmd(radio,5,cmdtext);
	dcmd(heal,4,cmdtext);
	dcmd(bank,4,cmdtext);
	dcmd(withdraw,8,cmdtext);
	dcmd(lotto,5,cmdtext);
	dcmd(name,4,cmdtext);
	dcmd(bd,2,cmdtext);
	dcmd(location,8,cmdtext);
	dcmd(announce,8,cmdtext);
	dcmd(adminsay,8,cmdtext);
	dcmd(disarm,6,cmdtext);
	dcmd(suspect,7,cmdtext);
	dcmd(bribe,5,cmdtext);
	dcmd(wire,4,cmdtext);
	dcmd(backup,6,cmdtext);
	dcmd(dep,3,cmdtext);
	dcmd(pizza,5,cmdtext);
	dcmd(hire,4,cmdtext);
	dcmd(payguard,8,cmdtext);
	dcmd(repair,8,cmdtext);
	dcmd(goto,4,cmdtext);
	dcmd(bring,5,cmdtext);
	dcmd(weather,7,cmdtext);
	dcmd(getcash,7,cmdtext);
	dcmd(help,4,cmdtext);
	dcmd(pullin,6,cmdtext);
	dcmd(ainterior,9,cmdtext);
	dcmd(bringv,6,cmdtext);
	//dcmd(crimes,6,cmdtext);
	dcmd(login,5,cmdtext); // because login has 5 characters
  	dcmd(register,8,cmdtext); // because register has 8 characters
  	dcmd(sellcar,7,cmdtext);
  	dcmd(kick,4,cmdtext);
  	dcmd(ban,3,cmdtext);
	return 0;
}


//-----------------------------------------------------PLAYER CHANGE----------------------------------------------------------------------
public OnPlayerInfoChange(playerid)
{
	printf("OnPlayerInfoChange(%d)");
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	printf("OnPlayerStateChange(%d, %d, %d)", playerid, newstate, oldstate);
	if(newstate == PLAYER_STATE_DRIVER)
		{
		new vehmodel;
		vehmodel = GetVehicleModel(GetPlayerVehicleID(playerid));
		if(vehmodel == 497 || vehmodel == 523 || vehmodel == 596 || vehmodel == 599 || vehmodel == 597 || vehmodel == 598 || vehmodel == 416)
			{
			if(gTeam[playerid] != TEAM_POLICE_LS)
			if(gTeam[playerid] != TEAM_POLICE_SF)
			if(gTeam[playerid] != TEAM_POLICE_LV)
			if(gTeam[playerid] != TEAM_MEDIC_LS)
			if(gTeam[playerid] != TEAM_MEDIC_SF)
			if(gTeam[playerid] != TEAM_MEDIC_LV)
				{
				SendClientMessage(playerid, COLOR_RED, "[WARNING] This is a government vehicle! You get automatly wanted");
				if(GetPlayerWantedLevel(playerid) < 2)
					{
					WantedLevel(playerid, "+2", "Thiefing  a government vehicle.");
					}
				else
					{
					WantedLevel(playerid, "+1", "Thiefing  a government vehicle.");
					}
				}
			}
		else if (gOwner[GetPlayerVehicleID(playerid)] != gPlayerid[playerid])
			{
			new str[256];
			if(!gOwner[GetPlayerVehicleID(playerid)])
				{
				format(str,256,"[WARNING] This Isnt Your Vehicle! It has no owner, you can buy it doing /buycar");
				}
			else
				{
				new str2[256], str0[256];
				format(str0, 256, "%d", gOwner[GetPlayerVehicleID(playerid)]);
				format(str2,256,"%s",dini_Get("players",str0));
				format(str,256,"[WARNING] This Isnt Your Vehicle! Current Owner is: %s",str2);
				}
			SendClientMessage(playerid, COLOR_RED, str);
			}
		else
			{
			TodayGotIn[GetPlayerVehicleID(playerid)] = 1;
			}
		}
	else if(newstate == PLAYER_STATE_PASSENGER)
		{
 		for(new z=0;z<MAX_PLAYERS;z++)
	 		{
 			if(TaxiCar[z]==GetPlayerVehicleID(playerid))
 				{
 				if(TaxiService[z])
	 				{
 					new str[256];
	 				format(str,256,"[INFO] The taxi price is $%d.",TaxiPrice[z]);
 					SendClientMessage(playerid, COLOR_YELLOW, str);
 					SendClientMessage(playerid, COLOR_YELLOW, "[INFO] You must do /taxipay for pay the taxi, if not, he can report you to police.");
		 			SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Remember that you also can report doing /911 [id] [reason]");
 					SendClientMessage(z, COLOR_GREEN, "[INFO] You have a new passanger!");
 					SendClientMessage(z, COLOR_YELLOW, "[INFO] Remember that he must do /taxipay so you earn money,");
	 				SendClientMessage(z, COLOR_YELLOW, "[INFO] If he doesn't pay you, you always can do /911 [id] [reason]");
	 				Benefits[z] = 1;
	 				}
 				}
 			}
 		}
	return 1;
}

//-------------------------------------------------------------VEHICLE-------------------------------------------------------------------------
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	printf("OnPlayerEnterVehicle(%d, %d, %d)", playerid, vehicleid, ispassenger);
	new str[256];
	format(str,256,"car%d",vehicleid);
	if(dini_Int("car_locks",str)) SetVehicleParamsForPlayer(playerid,vehicleid,0,1);
	else SetVehicleParamsForPlayer(playerid,vehicleid,0,0);
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	printf("OnPlayerExitVehicle(%d, %d)", playerid, vehicleid);
	if (TaxiService[playerid] == 1)
		{
		SendClientMessage(playerid,COLOR_YELLOW,"[INFO] You Have Quitted Your Taxi Job");
		TaxiService[playerid] = 0;
		TaxiCar[playerid] = 0;
		}
	if (PizzaService[playerid] == 1)
		{
		SendClientMessage(playerid,COLOR_YELLOW,"[INFO] You Have Quitted Your Pizza Job");
		PizzaService[playerid] = 0;
		PizzaBike[playerid] = 0;
		}
	if(Blocking[playerid])
		{
		for(new i=0;i<MAX_PLAYERS;i++)
			{
			if(IsPlayerConnected(i))
				{
				if(GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid) && GetPlayerState(i) == PLAYER_STATE_PASSENGER && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
					{
					Blocking[playerid] = 0;
					TogglePlayerControllable(i,1);
					}
				}
			}
		}
	return 1;
}

//-----------------------------------------------------------------LOTTO ANNOUNCEMENT------------------------------------------------------------------------------
public LottoAnnounce()
{
	new number1, number2, number3, str[256], str2[256];
	number1 = random(24);
	number2 = random(24);
	number3 = random(24);
	number1 += 1;
	number2 += 1;
	number3 += 1;
	dini_IntSet("lotto","finished",1);
	dini_IntSet("lotto","-------------RESULTS------------- NUMBER 1", number1);
	dini_IntSet("lotto","-------------RESULTS------------- NUMBER 2", number2);
	dini_IntSet("lotto","-------------RESULTS------------- NUMBER 3", number3);
	format(str,256,"The final lotto numbers are: %d-%d-%d", number1, number2, number3);
	GameTextForAll(str, 10000, 6);
	format(str2,256,"[ADMIN ANNOUNCE] The final lotto numbers are: %d-%d-%d", number1, number2, number3);
	SendClientMessageToAll(COLOR_ORANGE, str2);
	SetTimer("LottoAnnounce2()", 10000, 6);
}

public LottoAnnounce2()
{
	GameTextForAll("If you won, you'll recieve your money in your bank", 5000, 6);
	SendClientMessageToAll(COLOR_ORANGE, "[ADMIN ANNOUNCE] If you won, you will recieve the money in your bank account");
	SendClientMessageToAll(COLOR_ORANGE, "[ADMIN ANNOUNCE] with a maximum delay of 1 day (real time).");
	SetTimer("LottoAnnounce3()", 5000, 0);
}

public LottoAnnounce3()
{
	GameTextForAll("With a maximum delay of 1 day", 5000, 6);
}

//-----------------------------------------------------------------SPEED SYSTEM------------------------------------------------------------------------------
public UpdateSpeed()
{
	new Float:x,Float:y,Float:z;
	new Float:distance,value,string[256];
	for(new i=0; i<SLOTS; i++)
		{
		if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i))
			{
			GetPlayerPos(i, x, y, z);
			distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
			value = floatround(distance * 3600);
			if(UpdateSeconds > 1)
				{
				value = floatround(value / UpdateSeconds);
				}
			if(SpeedMode)
				{
				format(string,sizeof(string),"~r~%d MPH",floatround(value/1600));
				GameTextForPlayer(i, string, 2000, 6);
				}
			else
				{
				format(string,sizeof(string),"~r~%d KPH",floatround(value/1000));
				GameTextForPlayer(i, string, 2000, 6);
				}
			SavePlayerPos[i][LastX] = x;
			SavePlayerPos[i][LastY] = y;
			SavePlayerPos[i][LastZ] = z;
			} 
		} 
}

//---------------------------------------------------------------------FUNCTIONS------------------------------------------------------------------
public getCheckpointType(playerID) 
{
	return checkpointType[playerCheckpoint[playerID]];
}

public isPlayerInArea(playerID, Float:data[4])
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerID, X, Y, Z);
	if(X >= data[0] && X <= data[2] && Y >= data[1] && Y <= data[3])
		{
		return 1;
		}
	return 0;
}

PlayerName(playerid)
{
	new name[255];
  	GetPlayerName(playerid, name, 255);
  	return name;
}

public SendClientMessageForTeam(teamid, text_color, string_text[])
{
	for(new w=0;w<MAX_PLAYERS;w++)
		{
		if(gTeam[w] == teamid)
			{
			SendClientMessage(w, text_color, string_text);
			}
		}
}


//--------------------------------------------------------------FUEL SYSTEM---------------------------------------------------------------------------
public checkpointUpdate()
{
	for(new i=0; i<MAX_PLAYERS; i++)
		{
 		if(IsPlayerConnected(i))
  			{
  			for(new j=0; j < MAX_POINTS; j++)
  				{
  				if(isPlayerInArea(i, checkCoords[j]))
   					{
   					if(playerCheckpoint[i]!=j)
    					{
    					LastCheckpoint[i] = gCurrentCheckpoint[i];
    					gCurrentCheckpoint[i] = 99999999;
    					DisablePlayerCheckpoint(i);
    					SetPlayerCheckpoint(i, checkpoints[j][0],checkpoints[j][1],checkpoints[j][2],checkpoints[j][3]);
    					playerCheckpoint[i] = j;
    					}
   					}
   				else
   					{
   					if(playerCheckpoint[i]==j)
    					{
    					DisablePlayerCheckpoint(i);
    					gCurrentCheckpoint[i] = LastCheckpoint[i];
    					playerCheckpoint[i] = 999;
    					}
   					}
  				}
  			}
		}
}

public CheckFuel(playerid)
{
	new Ptmess[32];
	for(new i=0;i<MAX_PLAYERS;i++)
 		{
  		if(IsPlayerConnected(i) == 1 && IsPlayerInAnyVehicle(i) == 1)
   			{
   			if(GetPlayerState(i) == 2)
    			{
	 			new Vi;
     			Vi = GetPlayerVehicleID(i);
     			if(GetVehicleModel(Vi) != 417 && GetVehicleModel(Vi) != 425 && GetVehicleModel(Vi) != 430 && GetVehicleModel(Vi) != 432 && GetVehicleModel(Vi) != 435
     			&& GetVehicleModel(Vi) != 441 && GetVehicleModel(Vi) != 446 && GetVehicleModel(Vi) != 447 && GetVehicleModel(Vi) != 449 && GetVehicleModel(Vi) != 450
     			&& GetVehicleModel(Vi) != 452 && GetVehicleModel(Vi) != 453 && GetVehicleModel(Vi) != 454 && GetVehicleModel(Vi) != 460 && GetVehicleModel(Vi) != 464
     			&& GetVehicleModel(Vi) != 465 && GetVehicleModel(Vi) != 469 && GetVehicleModel(Vi) != 472 && GetVehicleModel(Vi) != 473 && GetVehicleModel(Vi) != 476
     		 	&& GetVehicleModel(Vi) != 481 && GetVehicleModel(Vi) != 484 && GetVehicleModel(Vi) != 487 && GetVehicleModel(Vi) != 488 && GetVehicleModel(Vi) != 493
     		 	&& GetVehicleModel(Vi) != 497 && GetVehicleModel(Vi) != 501 && GetVehicleModel(Vi) != 509 && GetVehicleModel(Vi) != 510 && GetVehicleModel(Vi) != 511
     		 	&& GetVehicleModel(Vi) != 512 && GetVehicleModel(Vi) != 513 && GetVehicleModel(Vi) != 519 && GetVehicleModel(Vi) != 520 && GetVehicleModel(Vi) != 532
     		 	&& GetVehicleModel(Vi) != 537 && GetVehicleModel(Vi) != 538 && GetVehicleModel(Vi) != 539 && GetVehicleModel(Vi) != 548 && GetVehicleModel(Vi) != 553
     		 	&& GetVehicleModel(Vi) != 556 && GetVehicleModel(Vi) != 557 && GetVehicleModel(Vi) != 563 && GetVehicleModel(Vi) != 564 && GetVehicleModel(Vi) != 569
     		 	&& GetVehicleModel(Vi) != 570 && GetVehicleModel(Vi) != 577 && GetVehicleModel(Vi) != 584 && GetVehicleModel(Vi) != 590 && GetVehicleModel(Vi) != 591
     		 	&& GetVehicleModel(Vi) != 592 && GetVehicleModel(Vi) != 593 && GetVehicleModel(Vi) != 594 && GetVehicleModel(Vi) != 595 && GetVehicleModel(Vi) != 606
     		 	&& GetVehicleModel(Vi) != 607 && GetVehicleModel(Vi) != 608 && GetVehicleModel(Vi) != 610 && GetVehicleModel(Vi) != 611)
     		 		{
	     			Petrol[Vi]--;
	     			if(Petrol[Vi] >= 1)
	      				{
	      				format(Ptmess, sizeof(Ptmess), "~Petrol =~r~%d%", Petrol[Vi]);
	      				GameTextForPlayer(i,Ptmess, 500, 1);
	      				}
	      			else
	      				{
	      				RemovePlayerFromVehicle(i);
	      				SendClientMessage(i, COLOR_RED, "[WARNING] Your vehicle ran out of petrol");
	      				if(Petrol[Vi] < 0)
		   					{
		   					Petrol[Vi] = 0;
		   					}
	      				}
	      			if(Petrol[i] >= 51)
	       				{
	       				format(Ptmess, sizeof(Ptmess), "Petrol =%d%", Petrol[Vi]);
	       				GameTextForPlayer(i, Ptmess, 500, 1);
	       				}
	       			}
				}
    		}
 		}
}

public FuelRefill(playerid)
{
	new VID;
	VID = GetPlayerVehicleID(playerid);
	if(Petrol[VID] < AMOUNT)
 		{
 		new FillUp;
 		FillUp = AMOUNT - Petrol[VID];
 		if(GetPlayerMoney(playerid) >= FillUp)
  			{
  			Petrol[VID] +=FillUp;
  			new mess[64];
  			format(mess, sizeof(mess), "[INFO] You put %d units of petrol in your vehicle", FillUp);
  			SendClientMessage(playerid, COLOR_GREEN, mess);
  			GivePlayerMoneyEx(playerid, -FillUp,"filling fuel");
  			return 1;
  			}
  		else
  			{
  			SendClientMessage(playerid, COLOR_RED, "[INFO] You don't have enough money for petrol");
  			return 1;
  			}
 		}
 	else
 		{
 		SendClientMessage(playerid, COLOR_RED, "[INFO] Your vehicle is allready full with petrol");
		return 1;
		}
}


//-----------------------------------------------------------CHECK POINTS--------------------------------------------------------------------------------
public OnPlayerEnterCheckpoint(playerid)
{
	printf("OnPlayerEnterCheckpoint(%d)", playerid);
    if (gCurrentCheckpoint[playerid] == 1)
		{
		SendClientMessage(playerid,COLOR_YELLOW,"What's your name?, use /name [NAME] to reply");
		}
	else if (gCurrentCheckpoint[playerid] == 2)
		{
		SendClientMessage(playerid,COLOR_YELLOW,"What's your date of birth, use /bd [DD.MM.YYYY] to reply");
		}
	else if (gCurrentCheckpoint[playerid] == 3)
		{
		SendClientMessage(playerid,COLOR_YELLOW,"Where is your current location?, use /location [YourLocation] to reply");
		}
	else if (gCurrentCheckpoint[playerid] == 4)
		{
		gCurrentCheckpoint[playerid] = 0;
		SendClientMessage(playerid,COLOR_YELLOW,"Welcome to Compton City, Type /help to get some hints on what to do.");
		if (gTeam[playerid] == TEAM_POLICE_SF)
			{
			SetPlayerPos(playerid,-1622.3091,681.7858,7.1875);
			}
		if (gTeam[playerid] == TEAM_POLICE_LV)
			{
			SetPlayerPos(playerid,2295.8115,2450.8689,10.8203);
			}
		if (gTeam[playerid] == TEAM_POLICE_LS)
			{
			SetPlayerPos(playerid,1549.9796,-1675.4415,15.2044);
			}
		else if (gTeam[playerid] == TEAM_CITIZEN_LS)
			{
			SetPlayerPos(playerid,1730.5016,-2332.4734,13.5469);
			}
        else if (gTeam[playerid] == TEAM_CITIZEN_SF)
			{
			SetPlayerPos(playerid,-1563.2159,-458.8463,6.1553);
			}
        else if (gTeam[playerid] == TEAM_CITIZEN_LV)
			{
			SetPlayerPos(playerid,1675.6737,1447.8945,10.7867);
			}
		else if (gTeam[playerid] == TEAM_FBI)
			{
			SetPlayerPos(playerid,1575.8344,-1332.6107,16.4844);
			}
//		else if (gTeam[playerid] == TEAM_PILOT)
	//		{
		//	//SetPlayerPos(playerid,x,y,z);
			//}
		else if (gTeam[playerid] == TEAM_MEDIC_SF)
			{
			SetPlayerPos(playerid,sfposx, sfposy, sfposz);
			}
        else if (gTeam[playerid] == TEAM_MEDIC_LS)
			{
			SetPlayerPos(playerid,ls1posx, ls1posy, ls1posz);
			}
        else if (gTeam[playerid] == TEAM_MEDIC_LV)
			{
			SetPlayerPos(playerid,lvposx, lvposy, lvposz);
			}
		DisablePlayerCheckpoint(playerid);
		gCurrentGamePhase[playerid] = 1;
		}
//---------------------------------------------------------------NORTH SF BRIDGE---------------------------------------------------------------------
	else if (gCurrentCheckpoint[playerid] == 5 && (GetPlayerWantedLevel(playerid) >= 1))//NORTH BRIDGE SF BORDER CONTROL1
		{
		SendClientMessage(playerid,COLOR_RED,"[WARNING] You are a known criminial, reporting you to police!");
		new temp[256];
		new name[256];
		GetPlayerName(playerid, name, sizeof(name));
		format(temp, sizeof(temp), "[RADIO] %s is attempting to cross North SF Bridge.",name);
		SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_RED,temp);
		SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_RED,temp);
		SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_RED,temp);
		return 1;
		}
	else if (gCurrentCheckpoint[playerid] == 6 && (GetPlayerWantedLevel(playerid) >= 1))//NORTH BRIDGE SF BORDER CONTROL 2
		{
		SendClientMessage(playerid,COLOR_RED,"[WARNING] You are a known criminial, reporting you to police!");
		new temp[256];
		new name[256];
		GetPlayerName(playerid, name, sizeof(name));
		format(temp, sizeof(temp), "[RADIO] %s is attempting to cross North SF Bridge.",name);
		SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_RED,temp);
		SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_RED,temp);
		SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_RED,temp);
		return 1;
		}
	else if (gCurrentCheckpoint[playerid] == 5 && (Passport[playerid] == 0))//NORTH BRIDGE SF BORDER CONTROL1
		{
		SendClientMessage(playerid,COLOR_RED,"[INFO] You don't have a passport, apply for one in one of the city halls.");
		return 1;
		}
	else if (gCurrentCheckpoint[playerid] == 6 && (Passport[playerid] == 0))//NORTH BRIDGE SF BORDER CONTROL 2
		{
		SendClientMessage(playerid,COLOR_RED,"[INFO] You don't have a passport, apply for one in one of the city halls.");
		return 1;
		}
	else if (gCurrentCheckpoint[playerid] == 5 && (Passport[playerid] == 1) && (GetPlayerWantedLevel(playerid) == 0))//NORTH BRIDGE SF BORDER CONTROL 1
		{
		SendClientMessage(playerid,COLOR_GREEN,"[INFO] Everything seems legit, enjoy your trip");
		PassportShown[playerid] = 1;
		return 1;
		}
	else if (gCurrentCheckpoint[playerid] == 6 && (Passport[playerid] == 1) && (GetPlayerWantedLevel(playerid) == 0))//NORTH BRIDGE SF BORDER CONTROL 2
		{
		SendClientMessage(playerid,COLOR_GREEN,"[INFO] Everything seems legit, enjoy your trip");
		PassportShown[playerid] = 1;
		return 1;
		}
		
 //---------------------------------------------------SOUTH LV BRIDGE---------------------------------------------
	else if (gCurrentCheckpoint[playerid] == 9 && (Passport[playerid] == 1) && (GetPlayerWantedLevel(playerid) == 0))
		{
		SendClientMessage(playerid,COLOR_GREEN,"[INFO] Everything seems legit, enjoy your trip");
		PassportShown[playerid] = 1;
		return 1;
		}
	else if (gCurrentCheckpoint[playerid] == 10 && (Passport[playerid] == 1) && (GetPlayerWantedLevel(playerid) == 0))
		{
		SendClientMessage(playerid,COLOR_GREEN,"[INFO] Everything seems legit, enjoy your trip");
		PassportShown[playerid] = 1;
		return 1;
		}
	else if (gCurrentCheckpoint[playerid] == 9 && (Passport[playerid] == 0))
		{
		SendClientMessage(playerid,COLOR_RED,"[INFO] You don't have a passport, apply for one in one of the city halls.");
		return 1;
		}
	else if (gCurrentCheckpoint[playerid] == 10 && (Passport[playerid] == 0))
		{
		SendClientMessage(playerid,COLOR_RED,"[INFO] You don't have a passport, apply for one in one of the city halls.");
		return 1;
		}
	else if (gCurrentCheckpoint[playerid] == 9 && (GetPlayerWantedLevel(playerid) >= 1))
		{
		SendClientMessage(playerid,COLOR_RED,"[WARNING] You are a known criminial, reporting you to police!");
		new temp[256];
		new name[256];
		GetPlayerName(playerid, name, sizeof(name));
		format(temp, sizeof(temp), "[RADIO] %s is attempting to cross South LV Bridge.",name);
		SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_RED,temp);
		SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_RED,temp);
		SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_RED,temp);
		return 1;
		}
	else if (gCurrentCheckpoint[playerid] == 10 && (GetPlayerWantedLevel(playerid) >= 1))//NORTH BRIDGE SF BORDER CONTROL 2
		{
		SendClientMessage(playerid,COLOR_RED,"[WARNING] You are a known criminial, reporting you to police!");
		new temp[256];
		new name[256];
		GetPlayerName(playerid, name, sizeof(name));
		format(temp, sizeof(temp), "[RADIO] %s is attempting to cross South LV Bridge.",name);
		SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_RED,temp);
		SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_RED,temp);
		SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_RED,temp);
		return 1;
		}

//---------------------------------------------------------------SOUTH SF BRIDGE------------------------------------------------------------------------
	else if (gCurrentCheckpoint[playerid] == 7 && (Passport[playerid] == 1) && (GetPlayerWantedLevel(playerid) == 0))//EAST BRIDGE SF BORDER CONTROL 1
		{
		SendClientMessage(playerid,COLOR_GREEN,"[INFO] Everything seems legit, enjoy your trip");
		PassportShown[playerid] = 1;
		return 1;
		}
	else if (gCurrentCheckpoint[playerid] == 8 && (Passport[playerid] == 1) && (GetPlayerWantedLevel(playerid) == 0))//EAST BRIDGE SF BORDER CONTROL 2
		{
		SendClientMessage(playerid,COLOR_GREEN,"[INFO] Everything seems legit, enjoy your trip");
		PassportShown[playerid] = 1;
		return 1;
		}
	else if (gCurrentCheckpoint[playerid] == 7 && (Passport[playerid] == 0))//EAST BRIDGE SF BORDER CONTROL1
		{
		SendClientMessage(playerid,COLOR_RED,"[INFO] You don't have a passport, apply for one in one of the city halls.");
		return 1;
		}
	else if (gCurrentCheckpoint[playerid] == 8 && (Passport[playerid] == 0))//EAST BRIDGE SF BORDER CONTROL 2
		{
		SendClientMessage(playerid,COLOR_RED,"[INFO] You don't have a passport, apply for one in one of the city halls.");
		return 1;
		}
	else if (gCurrentCheckpoint[playerid] == 7 && (GetPlayerWantedLevel(playerid) >= 1))//NORTH BRIDGE SF BORDER CONTROL1
		{
		SendClientMessage(playerid,COLOR_RED,"[WARNING] You are a known criminial, reporting you to police!");
		new temp[256];
		new name[256];
		GetPlayerName(playerid, name, sizeof(name));
		format(temp, sizeof(temp), "[RADIO] %s is attempting to cross East SF Bridge.",name);
		SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_RED,temp);
		SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_RED,temp);
		SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_RED,temp);
		return 1;
		}
	else if (gCurrentCheckpoint[playerid] == 8 && (GetPlayerWantedLevel(playerid) >= 1))//NORTH BRIDGE SF BORDER CONTROL 2
		{
		SendClientMessage(playerid,COLOR_RED,"[WARNING] You are a known criminial, reporting you to police!");
		new temp[256];
		new name[256];
		GetPlayerName(playerid, name, sizeof(name));
		format(temp, sizeof(temp), "[RADIO] %s is attempting to cross East SF Bridge.",name);
		SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_RED,temp);
		SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_RED,temp);
		SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_RED,temp);
		return 1;
		}
	else if (gCurrentCheckpoint[playerid] == 11)
		{
		SetPlayerInterior(playerid, 0);
		new tmpx[256],tmpy[256],tmpz[256];
		format(tmpx,256,"house%d_x2teleport",houseid[playerid]);
		format(tmpy,256,"house%d_y2teleport",houseid[playerid]);
		format(tmpz,256,"house%d_z2teleport",houseid[playerid]);
		SetPlayerPos(playerid,dini_Int("houses",tmpx),dini_Int("houses",tmpy),dini_Int("houses",tmpz));
		gCurrentCheckpoint[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
		}
	else if (gCurrentCheckpoint[playerid] == 15)
		{
		gCurrentCheckpoint[playerid] = 0;
		KillTimer(PDChecks[playerid]);
		new Float:posx, Float:posy, Float:posz;
		GetPlayerPos(playerid, posx, posy, posz);
		new Float:ls, Float:sf, Float:lv;
		ls = floatsqroot(floatpower(posx - 1548.8903, 2) + floatpower(posy - -1610.0613, 2) + floatpower(posz - 13.3828, 2));
		sf = floatsqroot(floatpower(posx - -1571.6542, 2) + floatpower(posy - 705.8767, 2) + floatpower(posz - -5.2422, 2));
		lv = floatsqroot(floatpower(posx - 2314.9749, 2) + floatpower(posy - 2460.0366, 2) + floatpower(posz - 3.2734, 2));
		if (ls < sf && ls < lv)
			{
			SetPlayerPos(SurrenderedPlayer[playerid],268.5871,81.5751,1001.0391);
			SetPlayerInterior(SurrenderedPlayer[playerid],6);
			}
		else if (sf < ls && sf < lv)
			{
			SetPlayerPos(SurrenderedPlayer[playerid],219.0335,114.4317,999.0156);
			SetPlayerInterior(SurrenderedPlayer[playerid],10);
			}
		else if (lv < ls && lv < sf)
			{
			SetPlayerPos(SurrenderedPlayer[playerid],193.6839,158.1146,1003.0234);
			SetPlayerInterior(SurrenderedPlayer[playerid],3);
			}
		SendClientMessage(playerid,COLOR_GREEN,"[INFO] You have 1:30 minutes from now on to go inside the PD to the jail zone, and /jail the criminal");
		SendClientMessage(SurrenderedPlayer[playerid],COLOR_RED,"[INFO] The cop has 1:30 minutes to come here and jail you");
		TogglePlayerControllable(SurrenderedPlayer[playerid],0);
		DisablePlayerCheckpoint(playerid);
		ToJailTimer[SurrenderedPlayer[playerid]] = SetTimerEx("NotJailed",90000,0,"ii",playerid,SurrenderedPlayer[playerid]);
		}
	else if(getCheckpointType(playerid)>= 0 && getCheckpointType(playerid)<= 15)
    	{
	  	if(IsPlayerInAnyVehicle(playerid))
	   		{
       		SendClientMessage(playerid,COLOR_YELLOW,"[INFO] Stay in the checkpoint to refill your car with petrol");
       		FuelRefill(playerid);
	   		}
	   	else
	   		{
	   		SendClientMessage(playerid, COLOR_RED, "[INFO] Your not in a vehicle");
	   		}
	   	return 1;
	  	}
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	printf("OnPlayerLeaveCheckpoint(%d)", playerid);
	return 1;
}
//------------------------------------------------------------------------WANTED LEVEL SYSTEM---------------------------------------------------------
public WantedLevel(playerid, wanted_level_string[], reason[])
{
	if(gTeam[playerid] == TEAM_POLICE_LS || gTeam[playerid] == TEAM_POLICE_LV || gTeam[playerid] == TEAM_POLICE_SF || gTeam[playerid] == TEAM_MEDIC_LS || gTeam[playerid] == TEAM_MEDIC_LV || gTeam[playerid] == TEAM_MEDIC_SF)
		{
		new g[256];
		format(g,256,"Player wanted level cannot be raised for cop (id:%d)",playerid);
		print(g);
		}
	else
		{
		new wanted_level = GetPlayerWantedLevel(playerid);
		if (strcmp(wanted_level_string, "1", true)==0)
			{
			wanted_level = 1;
			}
		else if (strcmp(wanted_level_string, "2", true)==0)
			{
			wanted_level = 2;
			}
		else if (strcmp(wanted_level_string, "3", true)==0)
			{
			wanted_level = 3;
			}
		else if (strcmp(wanted_level_string, "4", true)==0)
			{
			wanted_level = 4;
			}
		else if (strcmp(wanted_level_string, "5", true)==0)
			{
			wanted_level = 5;
			}
		else if (strcmp(wanted_level_string, "6", true)==0)
			{
			wanted_level = 6;
			}
		else if (strcmp(wanted_level_string, "+1", true)==0)
			{
			wanted_level += 1;
			}
		else if (strcmp(wanted_level_string, "+2", true)==0)
			{
			wanted_level += 2;
			}
		else if (strcmp(wanted_level_string, "+3", true)==0)
			{
			wanted_level += 3;
			}
		else if (strcmp(wanted_level_string, "+4", true)==0)
			{
			wanted_level += 4;
			}
		else if (strcmp(wanted_level_string, "+5", true)==0)
			{
			wanted_level += 5;
			}
		else if (strcmp(wanted_level_string, "+6", true)==0)
			{
			wanted_level += 6;
			}
		else if (strcmp(wanted_level_string, "-1", true)==0)
			{
			wanted_level -= 1;
			}
		else if (strcmp(wanted_level_string, "-2", true)==0)
			{
			wanted_level -= 2;
			}
		else if (strcmp(wanted_level_string, "-3", true)==0)
			{
			wanted_level -= 3;
			}
		else if (strcmp(wanted_level_string, "-4", true)==0)
			{
			wanted_level -= 4;
			}
		else if (strcmp(wanted_level_string, "-5", true)==0)
			{
			wanted_level -= 5;
			}
		else if (strcmp(wanted_level_string, "-6", true)==0)
			{
			wanted_level -= 6;
			}
		if (wanted_level < 0)
			{
			wanted_level = 0;
			}
		if (wanted_level > 6)
			{
			wanted_level = 6;
			}
		SetPlayerWantedLevel(playerid, wanted_level);
		new string2[256];
		new name[255];
		if (wanted_level == 1)
        	{
			GetPlayerName(playerid, name, 24);
			format(string2, 256, "[RADIO] %s has been reported for %s (Wanted level: 1)",name,reason);
			SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_YELLOW,string2);
			SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_YELLOW,string2);
			SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_YELLOW,string2);
			}
		else if (wanted_level == 2)
			{
			GetPlayerName(playerid, name, 24);
			format(string2, 256, "[RADIO] %s has been reported for %s (Wanted level: 2)",name,reason);
			SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_YELLOW,string2);
			SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_YELLOW,string2);
			SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_YELLOW,string2);
			}
		else if (wanted_level == 3)
			{
			GetPlayerName(playerid, name, 24);
			format(string2, 256, "[RADIO] %s has been reported for %s (Wanted level: 3)",name,reason);
			SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_ORANGE,string2);
			SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_ORANGE,string2);
			SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_ORANGE,string2);
			}
		else if (wanted_level == 4)
			{
			GetPlayerName(playerid, name, 24);
			format(string2, 256, "[RADIO] %s has been reported for %s (Wanted level: 4)",name,reason);
			SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_ORANGE,string2);
			SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_ORANGE,string2);
			SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_ORANGE,string2);
			}
		else if (wanted_level == 5)
			{
			GetPlayerName(playerid, name, 24);
			format(string2, 256, "[RADIO] %s has been reported for %s (Wanted level: 5)",name,reason);
			SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_RED,string2);
			SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_RED,string2);
			SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_RED,string2);
			}
		else if (wanted_level == 6)
			{
			GetPlayerName(playerid, name, 24);
			format(string2, 256, "[RADIO] %s has been reported for %s (Wanted level: 6)",name,reason);
			SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_RED,string2);
			SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_RED,string2);
			SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_RED,string2);
			}
		}
}


//----------------------------------------------------------SSCANF------------------------------------------------------------------------------------
sscanf(string[], format[], {Float,_}:...)
{
	new
		formatPos,
		stringPos,
		paramPos = 2,
		paramCount = numargs();
	while (paramPos < paramCount && string[stringPos])
	{
		switch (format[formatPos])
		{
			case '\0': break;
			case 'i', 'd': setarg(paramPos, 0, strval(string[stringPos]));
			case 'c': setarg(paramPos, 0, string[stringPos]);
			case 'f': setarg(paramPos, 0, _:floatstr(string[stringPos]));
			case 's':
			{
				new
					end = format[formatPos + 1] == '\0' ? '\0' : ' ',
					i;
				while (string[stringPos] != end) setarg(paramPos, i++, string[stringPos++]);
				setarg(paramPos, i, '\0');
			}
			default: goto skip;
		}
		while (string[stringPos] && string[stringPos] != ' ') stringPos++;
		while (string[stringPos] == ' ') stringPos++;
		paramPos++;
		skip:
		formatPos++;
	}
	return format[formatPos] ? 0 : 1;
}

//---------------------------------------------------REGISTER-----------------------------------------------------------------
dcmd_register(playerid,params[]) {

	if (PLAYERLIST_authed[playerid]) return SystemMsg(playerid,"[INFO] You are already logined in.");
    if (udb_Exists(PlayerName(playerid))) return SystemMsg(playerid,"[INFO] Account already exists, please use '/login password'.");
    if (strlen(params)==0) return SystemMsg(playerid,"[INFO] Usage: /register [PASSWORD]");
    if (udb_Create(PlayerName(playerid),params)) 
    	{
    	dUserSetINT(PlayerName(playerid)).("money",2000);
    	dUserSetINT(PlayerName(playerid)).("x",2030);
    	dUserSetINT(PlayerName(playerid)).("y",-4475);
    	dUserSetINT(PlayerName(playerid)).("z",2771);
    	dini_IntSet("players","players",dini_Int("players","players")+1);
    	new tmp[256];
    	format(tmp,256,"%d",dini_Int("players","players"));
    	dini_Set("players",tmp,PlayerName(playerid));
    	dUserSetINT(PlayerName(playerid)).("playerid",dini_Int("players","players"));
    	dUserSetINT(PlayerName(playerid)).("CurrentCheckpoint",1);
    	dUserSetINT(PlayerName(playerid)).("health",100);
    	dUserSetINT(PlayerName(playerid)).("armour",0);
    	dUserSetINT(PlayerName(playerid)).("weapon0",0);
    	dUserSetINT(PlayerName(playerid)).("weapon0_ammo",0);
    	dUserSetINT(PlayerName(playerid)).("weapon1",0);
    	dUserSetINT(PlayerName(playerid)).("weapon1_ammo",0);
    	dUserSetINT(PlayerName(playerid)).("weapon2",0);
    	dUserSetINT(PlayerName(playerid)).("weapon2_ammo",0);
    	dUserSetINT(PlayerName(playerid)).("weapon3",0);
    	dUserSetINT(PlayerName(playerid)).("weapon3_ammo",0);
    	dUserSetINT(PlayerName(playerid)).("weapon4",0);
    	dUserSetINT(PlayerName(playerid)).("weapon4_ammo",0);
    	dUserSetINT(PlayerName(playerid)).("weapon5",0);
    	dUserSetINT(PlayerName(playerid)).("weapon5_ammo",0);
    	dUserSetINT(PlayerName(playerid)).("weapon6",0);
    	dUserSetINT(PlayerName(playerid)).("weapon6_ammo",0);
    	dUserSetINT(PlayerName(playerid)).("weapon7",0);
    	dUserSetINT(PlayerName(playerid)).("weapon7_ammo",0);
    	dUserSetINT(PlayerName(playerid)).("weapon8",0);
    	dUserSetINT(PlayerName(playerid)).("weapon8_ammo",0);
    	dUserSetINT(PlayerName(playerid)).("weapon9",0);
    	dUserSetINT(PlayerName(playerid)).("weapon9_ammo",0);
    	dUserSetINT(PlayerName(playerid)).("weapon10",0);
    	dUserSetINT(PlayerName(playerid)).("weapon10_ammo",0);
    	dUserSetINT(PlayerName(playerid)).("weapon11",0);
    	dUserSetINT(PlayerName(playerid)).("weapon11_ammo",0);
    	dUserSetINT(PlayerName(playerid)).("weapon12",0);
    	dUserSetINT(PlayerName(playerid)).("weapon12_ammo",0);
    	dUserSetINT(PlayerName(playerid)).("phone",0);
   		dUserSetINT(PlayerName(playerid)).("Passport",0);
   		dUserSetINT(PlayerName(playerid)).("interior",0);
   		dUserSetINT(PlayerName(playerid)).("PlayerBank",0);
   		dUserSetINT(PlayerName(playerid)).("Bank",0);
   		dUserSetINT(PlayerName(playerid)).("Jailed",0);
   		dUserSetINT(PlayerName(playerid)).("JailLeft",0);
   		dUserSetINT(PlayerName(playerid)).("CurrentGamePhase",0);
   		dUserSetINT(PlayerName(playerid)).("wantedlevel",0);
   		dUserSetINT(PlayerName(playerid)).("ticketnumber",0);
   		dUserSetINT(PlayerName(playerid)).("wantedlevel",0);
    	dUserSetINT(PlayerName(playerid)).("kills",0);
    	dUserSetINT(PlayerName(playerid)).("deaths",0);
    	dUserSetINT(PlayerName(playerid)).("jails",0);
    	dUserSetINT(PlayerName(playerid)).("logedin",0);
    	dUserSetINT(PlayerName(playerid)).("hitman",0);
    	dUserSetINT(PlayerName(playerid)).("gangid",0);
    	dUserSetINT(PlayerName(playerid)).("gTeam",TEAM_CITIZEN_LS);
    	dUserSetINT(PlayerName(playerid)).("Skin",43);
    	JustRegistered[playerid] = 1;
    	SystemMsg(playerid,"[INFO] Account successfully created! Login now with '/login password'");
    	}
    return 1;
 }
 
//------------------------------------------------LOGIN---------------------------------------------------------------------
dcmd_login(playerid,params[]) {

    if (PLAYERLIST_authed[playerid]) return SystemMsg(playerid,"[INFO] You are already logined in.");
    if (!udb_Exists(PlayerName(playerid))) return SystemMsg(playerid,"[WARNING] Account doesn't exist, please use '/register password'.");
    if (strlen(params)==0) return SystemMsg(playerid,"[INFO] Usage: /login [PASSWORD]");
    if (udb_CheckLogin(PlayerName(playerid),params)) {
    	if(JustRegistered[playerid])
	    	{
	       	SendClientMessage(playerid,COLOR_YELLOW,"[INFO] Select now your class. Select carefully, if you change in a future, you will lose your weapons.");
	       	}
		else
			{
			ForcedSpawn[playerid] = 1;
	       	SpawnPlayer(playerid);
	       	}
       	PLAYERLIST_authed[playerid]=true;
       	dUserSetINT(PlayerName(playerid)).("logedin",1);
       	SystemMsg(playerid,"[INFO] You are logged in!");
       	return 1;
    }
    SystemMsg(playerid,"[WARNING] Wrong password!");
    return 1;
 }
//------------------------------------------------------------PHONE/PM------------------------------------------------------------------------------
dcmd_phone(playerid, params[])
{
	new	giveplayerid2,string[256];
	if (!sscanf(params, "ds", giveplayerid2, string)) SendClientMessage(playerid, COLOR_RED, "[INFO] Usage: /phone [ID] [Message]");
	else if (IsPlayerConnected(giveplayerid2) && (Phone[playerid] == 0)) SendClientMessage(playerid, COLOR_RED, "[INFO] Player hasn't got a phone");
	else if (IsPlayerConnected(giveplayerid2) && (Phone[playerid] == 1))
		{
		new sname[256], pname[256];
		GetPlayerName(giveplayerid2, pname, sizeof(pname));
		GetPlayerName(playerid, sname, sizeof(sname));
		new temp[256];
		format(temp, sizeof(temp), "%s to %s: %s",sname, pname, string);
		for(new e=0; e<MAX_PLAYERS; e++)
		if(IsPlayerConnected(giveplayerid2) && (Phone[playerid] == 1))
		SendClientMessage(e, COLOR_YELLOW, temp);
		}
	return 1;
}

//------------------------------------------------------------SELLCAR------------------------------------------------------------------------------
dcmd_sellcar(playerid, params[])
{
	new	id,price;
	if (!sscanf(params, "dd", id, price)) SendClientMessage(playerid, COLOR_RED, "[INFO] Usage: /sellcar [ID] [PRICE]");
	else if (!dUserINT(PlayerName(playerid)).("vehicles")) SendClientMessage(playerid, COLOR_RED, "[INFO] You dont have a car to sell");
	else if (SellTo[playerid]!=999) SendClientMessage(playerid, 0xFF0000FF, "[INFO] You are aldery selling your car. Do /sellcancel for cancel.");
	else if (SellFrom[id] != 999) SendClientMessage(playerid, 0xFF0000FF, "[INFO] That player is buying a car at the moment.");
	else if(!IsPlayerConnected(id)) SendClientMessage(playerid, COLOR_RED, "[INFO] Invalid player id");
	else if(price < 1) SendClientMessage(playerid, COLOR_RED, "[INFO] Invalid price");
	else
		{
		SellTo[playerid] = id;
		SellFrom[id] = playerid;
		Sell[id] = price;
		new tmp[256];
		format(tmp,256,"[INFO] %s offered you his car for $%d. Contact him for see the car.",PlayerName(playerid),price);
		SendClientMessage(id, COLOR_YELLOW, tmp);
		SendClientMessage(id, COLOR_YELLOW, "[INFO] Do /sellacc for buy it now or /selldec for decline.");
		SendClientMessage(playerid, COLOR_GREEN, "[INFO] Selling offered. Do /sellcancel or wait for an response");
		}
	return 1;
}

//-------------------------------------------------------------ME------------------------------------------------------------
dcmd_me(playerid, params[])
{
	new string[256];
	if (!sscanf(params, "s", string)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /me [ACTION]");
	else if (IsPlayerConnected(playerid))
		{
		new mname[256];
		GetPlayerName(playerid, mname, sizeof(mname));
		new temp[256];
		format(temp, sizeof(temp), "%s %s",mname, params);
		SendClientMessageToAll(COLOR_GREEN, temp);
		}
	return 1;
}

//-------------------------------------------------GOTO--------------------------------------------------
dcmd_goto(playerid, params[])
{
	if(IsPlayerAdmin(playerid))
		{
		new id,x,y,z;
		if (!sscanf(params, "dddd", id,x,y,z)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /goto [ID] [X-offset] [Y-offset] [Z-offset]");
		else if (IsPlayerConnected(playerid))
			{
			new Float:X1,Float:Y1,Float:Z1;
			GetPlayerPos(id,X1,Y1,Z1);
			if(IsPlayerInAnyVehicle(playerid))
				{
				new vid;
				vid = GetPlayerVehicleID(playerid);
				SetVehiclePos(vid,X1+x,Y1+y,Z1+z);
				SetPlayerInterior(playerid,GetPlayerInterior(id));
				LinkVehicleToInterior(GetPlayerVehicleID(playerid),GetPlayerInterior(id));
				}
			else
				{
				SetPlayerPos(playerid,X1+x,Y1+y,Z1+z);
				SetPlayerInterior(playerid,GetPlayerInterior(id));
				}
			}
		else
			{
			SendClientMessage(playerid, 0xFF0000FF, "[INFO] Invalid ID");
			}
		}
	return 1;
}
//-------------------------------------------------BRING-------------------------------------------------
dcmd_bring(playerid, params[])
{
	if(IsPlayerAdmin(playerid))
		{
		new id,x,y,z;
		if (!sscanf(params, "dddd", id,x,y,z)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /bring [ID] [X-offset] [Y-offset] [Z-offset]");
		else if (IsPlayerConnected(playerid))
			{
			new Float:X1,Float:Y1,Float:Z1;
			GetPlayerPos(playerid,X1,Y1,Z1);
			if(IsPlayerInAnyVehicle(playerid))
				{
				new vid;
				vid = GetPlayerVehicleID(id);
				SetVehiclePos(vid,X1+x,Y1+y,Z1+z);
				SetPlayerInterior(id,GetPlayerInterior(playerid));
				LinkVehicleToInterior(vid,GetPlayerInterior(playerid));
				}
			else
				{
				SetPlayerPos(id,X1+x,Y1+y,Z1+z);
				SetPlayerInterior(id,GetPlayerInterior(playerid));
				}
			}
		else
			{
			SendClientMessage(playerid, 0xFF0000FF, "[INFO] Invalid ID");
			}
		}
	return 1;
}
//-------------------------------------------------BRINGV---------------------------------------------------
dcmd_bringv(playerid, params[])
{
	if(IsPlayerAdmin(playerid))
		{
		new id,x,y,z;
		if (!sscanf(params, "dddd", id,x,y,z)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /bring [ID] [X-offset] [Y-offset] [Z-offset]");
		else if (IsPlayerConnected(playerid))
			{
			new Float:X1,Float:Y1,Float:Z1;
			GetPlayerPos(playerid,X1,Y1,Z1);
			SetPlayerPos(id,X1+x,Y1+y,Z1+z);
			SetPlayerInterior(id,GetPlayerInterior(playerid));
			}
		else
			{
			SendClientMessage(playerid, 0xFF0000FF, "[INFO] Invalid ID");
			}
		}
	return 1;
}
//----------------------------------------------------KICK-------------------------------------------------------
dcmd_kick(playerid, params[])
{
	if(IsPlayerAdmin(playerid))
		{
		new id,reason[256];
		if (!sscanf(params, "ds", id,reason)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /kick [ID] [REASON]");
		else if (IsPlayerConnected(playerid))
			{
			new tmp[256];
			format(tmp,256,"[KICK] %s(%d) got kicked from the server: %s",PlayerName(id),id,reason);
			SendClientMessageToAll(COLOR_ORANGE,tmp);
			Kick(id);
			dini_IntSet("banlog",tmp,1);
			print(tmp);
			}
		else
			{
			SendClientMessage(playerid, 0xFF0000FF, "[INFO] Invalid ID");
			}
		}
	return 1;
}
//----------------------------------------------------BAN-------------------------------------------------------
dcmd_ban(playerid, params[])
{
	if(IsPlayerAdmin(playerid))
		{
		new id,reason[256];
		if (!sscanf(params, "ds", id,reason)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /ban [ID] [REASON]");
		else if (IsPlayerConnected(playerid))
			{
			new pip[16];
			GetPlayerIp(id, pip, sizeof(pip));
			new tmp[256],tmp2[256];
			format(tmp,256,"[BAN] %s(%d) got banned from the server by %s: %s",PlayerName(id),id,PlayerName(playerid),reason);
			format(tmp2,256,"[BAN] %s(%d)(%s) got banned from the server: %s by %s",PlayerName(id),id,pip,reason,PlayerName(playerid));
			SendClientMessageToAll(COLOR_ORANGE,tmp);
			Ban(id);
			dini_IntSet("banlog",tmp2,1);
			print(tmp2);
			}
		else
			{
			SendClientMessage(playerid, 0xFF0000FF, "[INFO] Invalid ID");
			}
		}
	return 1;
}
//-------------------------------------------------------WEATHER--------------------------------------------------
dcmd_weather(playerid, params[])
{
	if(IsPlayerAdmin(playerid))
		{
		new id;
		if (!sscanf(params, "d", id)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /weather [ID]");
		else
			{
			SetWeather(id);
			}
		}
	return 1;
}
//-------------------------------------------------------INTERIOR--------------------------------------------------
dcmd_ainterior(playerid, params[])
{
	if(IsPlayerAdmin(playerid))
		{
		new id;
		if (!sscanf(params, "d", id)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /interior [ID]");
		else
			{
			SetPlayerInterior(playerid,id);
			}
		}
	return 1;
}
//-------------------------------------------------GETCASH--------------------------------------------------
dcmd_getcash(playerid, params[])
{
	if(IsPlayerAdmin(playerid))
		{
		new id;
		if (!sscanf(params, "d", id)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /getcash [ID]");
		else if (IsPlayerConnected(id))
			{
			new tmp[256];
			format(tmp,256,"[STATS] %s: In-hand cash:%d // In-bank cash:%d",PlayerName(id),GetPlayerMoney(id),dUserINT(PlayerName(id)).("bank"));
			SendClientMessage(playerid,COLOR_GREEN,tmp);
			}
		else
			{
			SendClientMessage(playerid, 0xFF0000FF, "[INFO] Invalid ID");
			}
		}
	return 1;
}
//-------------------------------------------------HELP--------------------------------------------------
dcmd_help(playerid, params[])
{
	new string[256];
	if (!sscanf(params, "s", string))
		{
		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Welcome To Compton City");
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] This is an RPG so do what you would do in real life!");
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] for commands type /cmd");
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] To get the most out of CC, buting houses, businesses,");
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] cars, and much more, please register at");
 		SendClientMessage(playerid, COLOR_GREEN, "[INFO] www.comptoncity.ar.nu");
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Enyoy Your Stay");
 		}
 	else if(strcmp(string, "911", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /911 [ID] [Reason] = Reports crime to police");
 		}
 	else if(strcmp(string, "phone", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /phone [ID] [Message] = You must have a phone, and you can talk privately with someone");
 		}
 	else if(strcmp(string, "medic", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /medic [Location] = Calls medic for help");
 		}
 	else if(strcmp(string, "lock", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /lock = Locks your vehicle");
 		}
 	else if(strcmp(string, "unlock", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /unlock = Unlocks your vehicle");
 		}
 	else if(strcmp(string, "laws", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /rules = Lists CC Rules");
 		}
 	else if(strcmp(string, "calltaxi", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /calltaxi [LOCATION] = Sends Out message to people for pickup");
 		}
 	else if(strcmp(string, "paytaxi", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /paytaxi = Pays the taxi driver the required price");
 		}
 	else if(strcmp(string, "givecash", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /givecash [ID] [AMOUNT] = Gives player cash");
 		}
 	else if(strcmp(string, "vid", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /vid = Gets vehicle ID that you are in. For buy vehicles");
 		}
 	else if(strcmp(string, "say", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /say [MESSAGE] = Talks to the player/players near you");
 		}
 	else if(strcmp(string, "mylotto", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /mylotto = Tells you your current lotto numbers");
 		}
 	else if(strcmp(string, "me", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /me [ACTION] = Action command");
 		}
 	else if(strcmp(string, "bribe", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /bribe [ID] [AMOUNT] = Bribe the police to set you unwanted");
 		}
 	else if(strcmp(string, "peat", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /peat = Eats your ordered pizza");
 		}
 	else if(strcmp(string, "hire", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /hire [ID] [PAY] [DETAILS] = Hires a bodyguard");
 		}
 	else if(strcmp(string, "payguard", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /payguard [ID] = Pays your hired bodyguard");
 		}
 	else if(strcmp(string, "kills", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /kills = Tells you how many people you have killed");
 		}
 	else if(strcmp(string, "deaths", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /deaths = Tells you how many times you have died");
 		}
 	else if(strcmp(string, "jails", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /jails = Tells you how many people you have jailed");
 		}
 	else if(strcmp(string, "hitman", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /hitman [ID] [PRICE] = Sets a bounty on the ID");
 		}
 	else if(strcmp(string, "bounties", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /bounties = Shows current hitman bounties");
 		}
 	else if(strcmp(string, "bank", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /bank [AMOUNT] = Puts money into your bank account");
 		}
 	else if(strcmp(string, "withdraw", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /withdraw [AMOUNT] = Takes money from your account");
 		}
 	else if(strcmp(string, "balance", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /balance = Tells you how much money you have in bank");
 		}
 	else if(strcmp(string, "lotto", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /lotto [NUMBER1] [NUMBER2] [NUMBER3] = Buys a lotto ticket. Lotto is played every wednesday.");
 		}
 	else if(strcmp(string, "jackpot", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /jackpot = Tells you how much money is in the lotto jackpot");
 		}
 	else if(strcmp(string, "wire", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /wire [ID] [AMOUNT] = Puts money from your account to the ID's account");
 		}
 	else if(strcmp(string, "ad", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /ad [ADVERT] = Advertise something to all players using this command. It costs $500");
 		}
 	else if(strcmp(string, "heal", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /heal [ID] = Healths player (Medic Only)");
 		}
 	else if(strcmp(string, "taxi", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /taxi [PRICE] = Set your status as taxi and earn money");
 		}
 	else if(strcmp(string, "pizza", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /pizza [PRICE] = Set your status as pizzaboy and earn money");
 		}
 	else if(strcmp(string, "bodyduty", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /bodyduty = Turns yourself into a bodyguard to hire");
 		}
 	else if(strcmp(string, "disarm", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /disarm = disarms the criminal in your police car");
 		}
 	else if(strcmp(string, "jail", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /jail = Jails criminal (only at jails)");
 		}
 	else if(strcmp(string, "a", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /a [id] = Tells the criminal to follow your instructions and do /handsup");
 		}
 	else if(strcmp(string, "suspect", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /suspect [ID] [REASON] = Cops to make people wanted for crimes");
 		}
 	else if(strcmp(string, "bribeacc", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /bribeacc = Accepts bribe");
 		}
 	else if(strcmp(string, "bribedec", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /bribedec = Decline bribe and made the criminal even more wanted.");
 		}
 	else if(strcmp(string, "dep", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /dep [MESSAGE] = Radio to department");
 		}
 	else if(strcmp(string, "block", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /block = Locks criminal in your car");
 		}
 	else if(strcmp(string, "unblock", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /unblock = Unlocks criminal in your car");
 		}
 	else if(strcmp(string, "resign", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /resign = Quit your bodyguard job");
 		}
 	else if(strcmp(string, "radiohelp", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /radiohelp = Quick commands for bodyguards and cops");
 		}
 	else if(strcmp(string, "gasloc", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /gasloc = Tells you locations of gas stations");
 		}
 	else if(strcmp(string, "surrender", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /surrender = Surrenders to near cops");
 		}
 	else if(strcmp(string, "buycar", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /buycar = Buys the car you are currently in");
 		}
 	else if(strcmp(string, "sellcar", true) == 0)
 		{
 		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] /sellcar [ID] [PRICE] = Sells your current car to specified ID at current PRICE");
 		}
	return 1;
}
//---------------------------------------------------------BANK----------------------------------------------------------------------
dcmd_bank(playerid, params[])
{
	if (PlayerBank[playerid] != 0)
	{
	new	money;
	if (!sscanf(params, "i", money)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /bank [amount]");
	if(money > GetPlayerMoney(playerid))
		{
		SendClientMessage(playerid, COLOR_RED, "[INFO] You dont have so much!");
		}
	else if(money < 1)
		{
		SendClientMessage(playerid, COLOR_RED, "[INFO] Please, select a number higher than $0");
		}
	else
		{
		new tmp;
		tmp = dUserINT(PlayerName(playerid)).("Bank");
		tmp += money;
		dUserSetINT(PlayerName(playerid)).("Bank",tmp);
		GivePlayerMoneyEx(playerid, -money,"banking");
		new tmp2[256];
		format(tmp2,256,"[INFO] You banked $%d. Your current balance is $%d",money,dUserINT(PlayerName(playerid)).("Bank"));
		SendClientMessage(playerid, COLOR_GREEN, tmp2);
		}
		}
	return 1;
}
//////////////////////////////////
dcmd_withdraw(playerid, params[])
{
	if (PlayerBank[playerid] != 0)
	{
	new	money, tmp;
	tmp = dUserINT(PlayerName(playerid)).("Bank");
	if (!sscanf(params, "i", money)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /bank [amount]");
	if(money > tmp)
		{
		SendClientMessage(playerid, COLOR_RED, "[INFO] You dont have so much!");
		}
	else if(money < 1)
		{
		SendClientMessage(playerid, COLOR_RED, "[INFO] Please, select a number higher than $0");
		}
	else
		{
		GivePlayerMoneyEx(playerid, money,"withdrawing");
		tmp = dUserINT(PlayerName(playerid)).("Bank");
		tmp -= money;
		dUserSetINT(PlayerName(playerid)).("Bank",tmp);
		new tmp2[256];
		format(tmp2,256,"[INFO] You withdrawed $%d. Your current balance is $%d",money,dUserINT(PlayerName(playerid)).("Bank"));
		SendClientMessage(playerid, COLOR_GREEN, tmp2);
		}
 }
	return 1;
}
/////////////////////////////////
 dcmd_wire(playerid, params[])
{
	if (PlayerBank[playerid] != 0)
	{
	new	giveplayerid, money;
	if (!sscanf(params, "di",giveplayerid, money)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /wire [ID] [amount]");
	else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Invalid ID");
	else if (IsPlayerConnected(giveplayerid))
		{
		if(money > dUserINT(PlayerName(playerid)).("Bank"))
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You dont have so much!");
			}
		else if(money < 1)
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] Please, select a number higher than $0");
			}
		else
			{
			new bname[256];
			GetPlayerName(playerid, bname, sizeof(bname));
			new tmp,
			tmp1;
			tmp = dUserINT(PlayerName(playerid)).("Bank");
			tmp -= money;
			dUserSetINT(PlayerName(playerid)).("Bank",tmp);
			tmp1 = dUserINT(PlayerName(giveplayerid)).("Bank");
			tmp1 += money;
			dUserSetINT(PlayerName(giveplayerid)).("Bank",tmp1);
			new temp2[256];
			format(temp2, sizeof(temp2), "[INFO] You have sent %d to %s's bank account",money, PlayerName(giveplayerid));
			SendClientMessage(playerid,COLOR_GREEN, temp2);
			new temp[256];
			format(temp, sizeof(temp), "[INFO] %s has sent %d to your bank acount",bname, money);
			SendClientMessage(giveplayerid,COLOR_GREEN, temp);
			}
		}
	}
	return 1;
}
//---------------------------------------------------------LOTTO----------------------------------------------------------------------
dcmd_lotto(playerid, params[])
{
	if (PlayerBank[playerid] != 0)
		{
		new	ticket1, ticket2, ticket3;
		if (!sscanf(params, "iii", ticket1, ticket2, ticket3)) SendClientMessage(playerid, 0xFF0000FF, "Usage: /lotto [number1] [number2] [number3]");
		if(dini_Int("lotto","finished") == 1)
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You cant buy tickets right now, please wait for an admin to restart lotto, thanks.");
			}
		else if(dUserINT(PlayerName(playerid)).("ticketnumber") > 4)
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You aldery have 5 lotto tickets! Wait until next lotto event for buy new ones.");
			}
		else if(3 > GetPlayerMoney(playerid))
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You need $3 for buy a ticket!");
			}
		else if(ticket1 < 1 || ticket1 > 25 || ticket2 < 1 || ticket2 > 25 || ticket3 < 1 || ticket3 > 25)
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] Every number must be in a range of 1 to 25.");
			}
		else
			{
			new jackpot;
			jackpot = dini_Int("lotto","jackpot");
			jackpot += 3;
			dini_IntSet("lotto", "jackpot", jackpot);
			new tmp;
			tmp = dUserINT(PlayerName(playerid)).("ticketnumber");
			tmp += 1;
			dUserSetINT(PlayerName(playerid)).("ticketnumber",tmp);
			if(tmp == 1)
				{
				dUserSetINT(PlayerName(playerid)).("1_1",ticket1);
				dUserSetINT(PlayerName(playerid)).("1_2",ticket2);
				dUserSetINT(PlayerName(playerid)).("1_3",ticket3);
				new str[256];
				format(str, 256, "%d_1_1", gPlayerid[playerid]);
				dini_IntSet("lotto", str, ticket1);
				format(str, 256, "%d_1_2", gPlayerid[playerid]);
				dini_IntSet("lotto", str, ticket2);
				format(str, 256, "%d_1_3", gPlayerid[playerid]);
				dini_IntSet("lotto", str, ticket3);
				}
			else if(tmp == 2)
				{
				dUserSetINT(PlayerName(playerid)).("2_1",ticket1);
				dUserSetINT(PlayerName(playerid)).("2_2",ticket2);
				dUserSetINT(PlayerName(playerid)).("2_3",ticket3);
				new str[256];
				format(str, 256, "%d_2_1", gPlayerid[playerid]);
				dini_IntSet("lotto", str, ticket1);
				format(str, 256, "%d_2_2", gPlayerid[playerid]);
				dini_IntSet("lotto", str, ticket2);
				format(str, 256, "%d_2_3", gPlayerid[playerid]);
				dini_IntSet("lotto", str, ticket3);
				}
			else if(tmp == 3)
				{
				dUserSetINT(PlayerName(playerid)).("3_1",ticket1);
				dUserSetINT(PlayerName(playerid)).("3_2",ticket2);
				dUserSetINT(PlayerName(playerid)).("3_3",ticket3);
				new str[256];
				format(str, 256, "%d_3_1", gPlayerid[playerid]);
				dini_IntSet("lotto", str, ticket1);
				format(str, 256, "%d_3_2", gPlayerid[playerid]);
				dini_IntSet("lotto", str, ticket2);
				format(str, 256, "%d_3_3", gPlayerid[playerid]);
				dini_IntSet("lotto", str, ticket3);
				}
			else if(tmp == 4)
				{
				dUserSetINT(PlayerName(playerid)).("4_1",ticket1);
				dUserSetINT(PlayerName(playerid)).("4_2",ticket2);
				dUserSetINT(PlayerName(playerid)).("4_3",ticket3);
				new str[256];
				format(str, 256, "%d_4_1", gPlayerid[playerid]);
				dini_IntSet("lotto", str, ticket1);
				format(str, 256, "%d_4_2", gPlayerid[playerid]);
				dini_IntSet("lotto", str, ticket2);
				format(str, 256, "%d_4_3", gPlayerid[playerid]);
				dini_IntSet("lotto", str, ticket3);
				}
			else if(tmp == 5)
				{
				dUserSetINT(PlayerName(playerid)).("5_1",ticket1);
				dUserSetINT(PlayerName(playerid)).("5_2",ticket2);
				dUserSetINT(PlayerName(playerid)).("5_3",ticket3);
				new str[256];
				format(str, 256, "%d_5_1", gPlayerid[playerid]);
				dini_IntSet("lotto", str, ticket1);
				format(str, 256, "%d_5_2", gPlayerid[playerid]);
				dini_IntSet("lotto", str, ticket2);
				format(str, 256, "%d_5_3", gPlayerid[playerid]);
				dini_IntSet("lotto", str, ticket3);
				}
			GivePlayerMoneyEx(playerid, -3,"buying lotto ticket");
			SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Lotto ticket bought! Check out the results every wednesday at 19:00 GMT+0!");
			SendClientMessage(playerid, COLOR_YELLOW, "[INFO] If you won and wasnt online, check out at the forums!");
			}
		}
	return 1;
}
//--------------------------------------------------------------GIVECASH------------------------------------------------------------------------------
dcmd_givecash(playerid, params[])
{
	new
		giveplayerid,
		amount;
	if (!sscanf(params, "dd", giveplayerid, amount)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /givecash [playerid] [amount]");
	else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Player not found");
	else if (amount > GetPlayerMoney(playerid)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Insufficient Funds");
	else if (amount < 1) SendClientMessage(playerid, 0xFF0000FF, "[INFO] You are not giving cash");
	else
	{
		GivePlayerMoneyEx(giveplayerid, amount,"get givecashed");
		GivePlayerMoneyEx(playerid, 0 - amount,"givecash");
		new tmp[256],tmp2[256];
		format(tmp,256,"[INFO] You sent $%d to %s",amount,PlayerName(giveplayerid));
		SendClientMessage(playerid, 0x00FF00FF, tmp);
		format(tmp2,256,"[INFO] You recieved $%d from %s",amount,PlayerName(playerid));
		SendClientMessage(giveplayerid, 0x00FF00FF, tmp2);
	}
	return 1;
}
//--------------------------------------------------------------AGIVECASH------------------------------------------------------------------------------
dcmd_agivecash(playerid, params[])
{
	if(IsPlayerAdmin(playerid))
		{
		new
			giveplayerid,
			amount;
		if (!sscanf(params, "dd", giveplayerid, amount)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /agivecash [playerid] [amount]");
		else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Player not found");
		else
			{
			GivePlayerMoneyEx(giveplayerid, amount,"get admin givecashed");
			new tmp[256],tmp2[256];
			format(tmp,256,"[INFO] You sent $%d to %s",amount,PlayerName(giveplayerid));
			SendClientMessage(playerid, 0x00FF00FF, tmp);
			format(tmp2,256,"[INFO] You recieved $%d from admin",amount);
			SendClientMessage(giveplayerid, 0x00FF00FF, tmp2);
			}
		}
	return 1;
}
//--------------------------------------------------------------911/REPORT------------------------------------------------------------------------------
dcmd_911(playerid, params[])
{
	new giveplayerid,string;
	if (!sscanf(params, "ds", giveplayerid, string)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /911 [ID] [Crime]");
	else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Invalid ID");
	else if (IsPlayerConnected(giveplayerid))
		{
		new rname[256];
		new cname[256];
		GetPlayerName(playerid, rname, sizeof(rname));
		GetPlayerName(giveplayerid, cname, sizeof(rname));
		new temp[256];
		format(temp, sizeof(temp), "[RADIO] %s Reported %s, Crime: %s",rname,cname, string);
		if(IsPlayerConnected(giveplayerid))
		SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_YELLOW,temp);
		SendClientMessage(playerid,COLOR_GREEN,"[INFO] Report Sent");
		SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_YELLOW,temp);
		SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_YELLOW,temp);
		}
	return 1;
}
dcmd_backup(playerid, params[])
{
	new string;
	if (!sscanf(params, "d", string)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /backup [LOCATION]");
	else if (gTeam[playerid] == TEAM_POLICE_LS || gTeam[playerid] == TEAM_POLICE_SF || gTeam[playerid] == TEAM_POLICE_LV)
		{
		new pname[256];
		GetPlayerName(playerid, pname, sizeof(pname));
		new temp[256];
		format(temp, sizeof(temp), "[RADIO] Officer %s in need of backup at %s",pname, params);
		SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_RED,temp);
		SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_RED,temp);
		SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_RED,temp);
		}
	return 1;
}
//--------------------------------------------------------------MEDIC------------------------------------------------------------------------------
dcmd_medic(playerid, params[])
{
	if(!strlen(params))
		{
		SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /medic [YourLocation]");
		return 1;
		}
	new hname[24];
	new temp[256];
	GetPlayerName(playerid, hname, sizeof(hname));
	format(temp, sizeof(temp), "[RADIO] %s In Need Of Medical Treatment, Location: %s",hname, params);
	SendClientMessageForTeam(TEAM_MEDIC_LS,COLOR_RED,temp);
	SendClientMessageForTeam(TEAM_MEDIC_LV,COLOR_RED,temp);
	SendClientMessageForTeam(TEAM_MEDIC_SF,COLOR_RED,temp);
	return 1;
}

//--------------------------------------------------------------CALL TAXI------------------------------------------------------------------------------
dcmd_calltaxi(playerid, params[])
{
	if(!strlen(params))
		{
		SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /calltaxi [YourLocation]");
		return 1;
		}
	new hname[24];
	new temp[256];
	GetPlayerName(playerid, hname, sizeof(hname));
	format(temp, sizeof(temp), "[RADIO] %s In Need Of Taxi Pickup, Location: %s",hname, params);
	for(new i;i<MAX_PLAYERS;i++)
		{
		if(IsPlayerConnected(i))
			{
			if(TaxiService[i]) 
				{
				SendClientMessage(i,COLOR_YELLOW,temp);
				}
			}
		}
	SendClientMessage(playerid,COLOR_GREEN,"Taxi request sent to all active taxi drivers");
	return 1;
}

//-------------------------------------------------------ADVERTS----------------------------------------------------------------------
dcmd_ad(playerid, params[])
{
	if(!strlen(params))
		{
		SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /ad [ADVERT]");
		return 1;
		}
	else if(GetPlayerMoney(playerid) < 500) SendClientMessage(playerid, 0xFF0000FF, "[INFO] You need $500 to place an advert");
	else
		{
		new name[24];
		new temp[256];
		GivePlayerMoneyEx(playerid,-500,"advertising /ad");
		GetPlayerName(playerid, name, sizeof(name));
		format(temp, sizeof(temp), "Advert: %s By %s",params, name);
		SendClientMessageToAll(COLOR_BLUE,temp);
		}
	return 1;
}

//---------------------------------------------------------SIGNUP----------------------------------------------------------------------------
dcmd_name(playerid, params[])
{
	if (gCurrentCheckpoint[playerid] == 1)
	{
	if(!strlen(params))
		{
		SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /name [YourName]");
		return 1;
		}
	new name[24];
	GetPlayerName(playerid, name, sizeof(name));
	dUserSet(PlayerName(playerid)).("name",params[playerid]);
	gCurrentCheckpoint[playerid] = 2;
	dUserSet(PlayerName(playerid)).("CurrentCheckpoint",gCurrentCheckpoint[playerid]);
	SendClientMessage(playerid, COLOR_GREEN, "[INFO] Please re-enter the red ring");
	}
	return 1;
}

dcmd_bd(playerid, params[])
{
	if (gCurrentCheckpoint[playerid] == 2)
	{
	if(!strlen(params))
		{
		SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /bd [DD.MM.YYYY]");
		return 1;
		}
	new name[24];
	GetPlayerName(playerid, name, sizeof(name));
	dUserSet(PlayerName(playerid)).("BirthDate",params[playerid]);
	dUserSet(PlayerName(playerid)).("CurrentCheckpoint",gCurrentCheckpoint[playerid]);
	SendClientMessage(playerid, COLOR_GREEN, "[INFO] Please re-enter the red ring");
	gCurrentCheckpoint[playerid] = 3;
	}
	return 1;
}
dcmd_location(playerid, params[])
{
	if (gCurrentCheckpoint[playerid] == 3)
	{
	if(!strlen(params))
		{
		SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /location [YourLocation]");
		return 1;
		}
	new name[24];
	GetPlayerName(playerid, name, sizeof(name));
	dUserSet(PlayerName(playerid)).("Location",params[playerid]);
	dUserSet(PlayerName(playerid)).("CurrentCheckpoint",gCurrentCheckpoint[playerid]);
	SetPlayerCheckpoint(playerid,2020.5858,-4467.5190,2769.1919,2.0);
	SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Please make your way to the exit, enjoy your stay at Compton City!");
	gCurrentCheckpoint[playerid] = 4;
	gCurrentGamePhase[playerid] = 1;
	dUserSet(PlayerName(playerid)).("CurrentGamePhase",gCurrentGamePhase[playerid]);
	}
	return 1;
}

//-----------------------------------------------------------------GUARD JOB-----------------------------------------------------------------------------------
dcmd_hire(playerid, params[])
{
	new id, pay, details[256];
	if (!sscanf(params, "dds", id, pay, details)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /hire [ID] [PAY] [DETAILS]");
	else if (!IsPlayerConnected(id)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] ID Number isnt an active player.");
	else if (gTeam[id] != TEAM_BODYGUARD) SendClientMessage(playerid, 0xFF0000FF, "[INFO] That player isn't a bodyguard!");
	else if (pay > GetPlayerMoney(playerid)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] You dont have enough cash.");
	else if (pay < 1) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Please, select a pay higher than 0.");
	else if (bodyduty[id] > 0) SendClientMessage(playerid, 0xFF0000FF, "[INFO] That bodyguard is aldery hired.");
	else
		{
		SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Request sent, please, wait for an answer");
		new tmp[256];
		format(tmp,256,"[INFO] You have recieved a bodyguard request from %s(id:%d), pay: $%d",PlayerName(playerid),playerid,pay);
		SendClientMessage(id, COLOR_GREEN, tmp);
		format(tmp,256,"[INFO] Job Details: %s",details);
		SendClientMessage(id, COLOR_YELLOW, tmp);
		SendClientMessage(id, COLOR_YELLOW, "[INFO] Do /ahire for accept or /dhire for decline.");
		bodyduty[id] = pay-(pay*2);
		bodyowner[id] = playerid;
		}
}

dcmd_payguard(playerid, params[])
{
	new id;
	if (!sscanf(params, "d", id)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /payguard [ID]");
	else if (!bodyguard[playerid][id]) SendClientMessage(playerid, 0xFF0000FF, "[INFO] That player isn't your bodyguard. Do /bodyguards for know who are.");
	else
		{
		GivePlayerMoneyEx(id,bodyduty[id],"getting payed for bodyguard");
		GivePlayerMoneyEx(playerid,-bodyduty[playerid],"payed for bodyguard");
		SendClientMessage(playerid,COLOR_GREEN,"[INFO] Bodyguard payed. He's no more your bodyguard.");
		new tmp[256];
		format(tmp,256,"[INFO] You got payed by %s. You still as bodyguard for be hired, do /bodyduty for be no more.",PlayerName(playerid));
		SendClientMessage(id,COLOR_GREEN,tmp);
		bodyduty[id] = 0;
		bodyowner[id] = 999;
		bodyguard[playerid][id] = 999;
		}
}
dcmd_repair(playerid, params[])
{
	new giveplayerid, location;
	if (!sscanf(params, "ds", giveplayerid, location)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /repair [ID] [LOCATION]");
	else if (gTeam[giveplayerid] != TEAM_MECHANIC) SendClientMessage(playerid, 0xFF0000FF, "[INFO] That player isn't a mechanic");
	else if (repairduty[giveplayerid] > 0) SendClientMessage(playerid, 0xFF0000FF, "[INFO] That mechanic is busy");
	else
		{
		SendClientMessage(playerid, COLOR_YELLOW, "Request sent, please, wait for an answer");
		new tmp[256];
		format(tmp,256,"[INFO] You have recieved a repair request from %s(id:%d)",PlayerName(playerid),playerid);
		SendClientMessage(giveplayerid, COLOR_GREEN, tmp);
		bodyowner[giveplayerid] = playerid;
		}
}
//--------------------------------------------------------------------TIME-----------------------------------------------------------------------------------
GetRandomWeather(weather, ...) {
	new random_weather = weather, count = 0, len = numargs() - 1;
	if(len > 0) {
		do {
			random_weather = getarg(random(len*1000)/1000);
			count++;
		} while(random_weather == weather && count < 10);  // try up to 10 times to get a random weather
	}
	return random_weather;
}

GetSequencedWeather(hour) {
	static weather = 10;
	switch(weather) {  // only normal weather changes are possible, eg clouds before rain and no sandstorm after rain
		case 0 .. 7, 10: {      // blue skies/clouds
			switch(hour) {
				case 11 .. 14: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,10,11,17,18,20,27,28,29,35,36,37,38,39);
				case 17 .. 23: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,10,20);
				default: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,10,12,13,14,15,20,27,28,29);
			}
		}
		case 8: {               // stormy
			weather = GetRandomWeather(weather,8,9,16,20,21,22,30,31,32,33);
		}
		case 9: {               // cloudy and foggy
			switch(hour) {
				case 17 .. 23: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,20);
				default: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,20,27,28,29,30,31,32,33);
			}
		}
		case 11, 17, 18: {      // scorching hot/bright
			switch(hour) {
				case 11 .. 14: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,10,11,17,18,20,27,28,29,35,26,37,38,39);
				default: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,10,20);
			}
		}
		case 12 .. 15: {        // very dull, colorless, hazy
			switch(hour) {
				case 16 .. 19: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,12,13,14,15,16,20,21,22,33,35);
				default: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,12,13,14,15,16,20);
			}
		}
		case 16: {              // dull, cloudy, rainy
			weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,12,13,14,15,16,20,33,35);
		}
		case 19: {              // sandstorm
			weather = GetRandomWeather(weather,8,16);
		}
		case 20: {              // foggy/greenish
			weather = GetRandomWeather(weather,9,16,20,21,22);
		}
		case 21, 22: {          // very dark, gradiented skyline, purple/green
			weather = GetRandomWeather(weather,8,16,20,21,22);
		}
		case 23 .. 26: {        // variations of pale orange
			switch(hour) {
				case 7 .. 11, 16 .. 20: GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,12,13,14,15,20,23,24,25,26,27,28,29,35,36,37,38);
				default: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,12,13,14,15,20);
			}
		}
		case 27 .. 29: {        // variations of fresh blue
			switch(hour) {
				case 11 .. 14: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,10,11,17,18,20,27,28,29,35,36,37,38,39);
				case 17 .. 23: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,10,20);
				default: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,10,12,13,14,15,20);
			}
		}
		case 30 .. 32: {        // variations of dark, cloudy, teal
			weather = GetRandomWeather(weather,8,9,16,20,21,22);
		}
		case 33: {              // dark, cloudy, brown
			switch(hour) {
				case 17 .. 23: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,16,20);
				default: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,16,20);
			}
		}
		case 34: {              // blue/purple, regular
			weather = GetRandomWeather(weather,16,20,21,22);
		}
		case 35: {              // dull brown
			switch(hour) {
				case 11 .. 14: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,11,17,18,35,36,37,38);
				case 17 .. 23: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,23,24);
				default: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,12,13,14,15);
			}
		}
		case 36 .. 38: {        // bright, foggy, orange
			switch(hour) {
				case 11 .. 14: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,11,17,18);
				case 17 .. 23: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,23,24);
				default: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9);
			}
		}
		case 39: {              // extremely bright
			switch(hour) {
				case 11 .. 14: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,10,11,17,18,27,28,29,39);
				case 17 .. 23: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,10);
				default: weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,10);
			}
		}
		case 40 .. 42: {        // blue/purple cloudy
			weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,16,20);
		}
		case 43: {              // dark toxic clouds
			weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7);
		}
		case 44: {              // black/white sky
			weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,10,12,13,14,15);
		}
		case 45: {              // black/purple sky
			weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,10,12,13,14,15);
		}
		default: {
			weather = GetRandomWeather(weather,0,1,2,3,4,5,6,7,9,10,12,13,14,15);
		}
	}
	return weather;
}

public Timer_DayHeartbeat() {
	static hour = 0;
	SetWorldTime(hour);
	if(!(hour % 3)) SetWeather(GetSequencedWeather(hour));
	hour++, hour %= 24;
}

//-----------------------------------------------------POLICES DISARM COMMAND-------------------------------------------------------
dcmd_disarm(playerid, params[])
{
	if(gTeam[playerid] == TEAM_POLICE_LS || gTeam[playerid] == TEAM_POLICE_SF || gTeam[playerid] == TEAM_POLICE_LV)
	{
	new giveplayerid;
	if (!sscanf(params, "d", giveplayerid)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /disarm [ID]");
	else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Invalid ID");
	else if (!IsPlayerInAnyVehicle(playerid)) SendClientMessage(playerid, COLOR_RED, "[INFO] The suspect must be in your car.");
	else if (!IsPlayerInAnyVehicle(giveplayerid)) SendClientMessage(playerid, COLOR_RED, "[INFO] The suspect must be in your car.");
	else if (GetPlayerVehicleID(playerid) != GetPlayerVehicleID(giveplayerid)) SendClientMessage(playerid, COLOR_RED, "[INFO] The suspect must be in your car.");
	else if (GetPlayerWantedLevel(giveplayerid) < 1) SendClientMessage(playerid, COLOR_RED, "[INFO] He isnt wanted");
	else
		{
		ResetPlayerWeapons(giveplayerid);
		SendClientMessage(playerid, COLOR_GREEN, "[INFO] Disarm sucessful");
		SendClientMessage(giveplayerid, COLOR_RED, "[INFO] You got disarmed by a policeman!");
		}
	}
	else
	{
	SendClientMessage(playerid, COLOR_RED, "[INFO] You must be a cop for use this command!");
	}
	return 1;
}

//-----------------------------------------------------POLICES PULLIN COMMAND-------------------------------------------------------
dcmd_pullin(playerid, params[])
{
	if(gTeam[playerid] == TEAM_POLICE_LS || gTeam[playerid] == TEAM_POLICE_SF || gTeam[playerid] == TEAM_POLICE_LV)
	{
	new giveplayerid;
	if (!sscanf(params, "d", giveplayerid)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /pullin [ID]");
	else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Invalid ID");
	else if (!GetPlayerWantedLevel(giveplayerid)) SendClientMessage(playerid, COLOR_RED, "[INFO] He isnt wanted");
	else if (!SurrenderTimerCheck[giveplayerid] && GetPlayerWantedLevel(giveplayerid)) SendClientMessage(playerid, COLOR_RED, "[INFO] He isnt surrendered, tell him to do that doing /a");
	else if (!IsPlayerInAnyVehicle(playerid)) SendClientMessage(playerid, COLOR_RED, "[INFO] You must be in a vehicle to pull him in");
	else
		{
		new Float:fPos[3], Float:fPos2[3];
		GetPlayerPos(playerid, fPos[0], fPos[1], fPos[2]);
		GetPlayerPos(giveplayerid, fPos2[0], fPos2[1], fPos2[2]);
		if( fPos[0] - fPos2[0] > 10 || fPos2[0] - fPos[0] > 10 )
			{
			SendClientMessage(playerid,COLOR_RED,"[INFO] Player is too far away.");
			return 1;
			}
		if( fPos[1] - fPos2[1] > 10 || fPos2[1] - fPos[1] > 10 ) 
			{
			SendClientMessage(playerid,COLOR_RED,"[INFO] Player is too far away.");
			return 1;
			}
		if( fPos[2] - fPos2[2] > 20 || fPos2[2] - fPos[2] > 20 ) 
			{
			SendClientMessage(playerid,COLOR_RED,"[INFO] Player is too far away.");
			return 1;
			}
		PutPlayerInVehicle(giveplayerid,GetPlayerVehicleID(playerid),1);
		KillTimer(SurrenderTimer[giveplayerid]);
		TogglePlayerControllable(giveplayerid,0);
		SendClientMessage(playerid,COLOR_GREEN,"[INFO] Criminal put in the vehicle. Now, please drive to any Police Department");
		SendClientMessage(giveplayerid,COLOR_RED,"[INFO] You got pulled in the cop vehicle");
		SurrenderedPlayer[playerid] = giveplayerid;
		PDChecks[playerid] = SetTimerEx("ShowPDChecks",5000,1,"i",playerid);
		}
	}
	else
	{
	SendClientMessage(playerid, COLOR_RED, "[INFO] You must be a cop for use this command!");
	}
	return 1;
}
//-----------------------------------------------------RADIO CHAT-------------------------------------------------------
dcmd_radio(playerid, params[])
{
	if(!strlen(params))
		{
		SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /Radio [MESSAGE]");
		return 1;
		}
	new rname[24];
	GetPlayerName(playerid, rname, sizeof(rname));
	new temp[256];
	if(gTeam[playerid] == TEAM_POLICE_LS || gTeam[playerid] == TEAM_POLICE_SF || gTeam[playerid] == TEAM_POLICE_LV)
		{
		format(temp, sizeof(temp), "[RADIO] Officer %s : %s",rname,params);
		SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_BLUE,temp);
		SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_BLUE,temp);
		SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_BLUE,temp);
		}
	else if (gTeam[playerid] == TEAM_MEDIC_LS || gTeam[playerid] == TEAM_MEDIC_SF || gTeam[playerid] == TEAM_MEDIC_LV)
		{
		format(temp, sizeof(temp), "[RADIO] Medic %s : %s",rname,params);
		SendClientMessageForTeam(TEAM_MEDIC_LS,COLOR_BLUE,temp);
		SendClientMessageForTeam(TEAM_MEDIC_LV,COLOR_BLUE,temp);
		SendClientMessageForTeam(TEAM_MEDIC_SF,COLOR_BLUE,temp);
		}
	else if (gTeam[playerid] == TEAM_BODYGUARD)
		{
		format(temp, sizeof(temp), "[RADIO] Security Guard %s : %s",rname,params);
		SendClientMessageForTeam(TEAM_BODYGUARD,COLOR_BLUE,temp);
		}
	else
		{
		SendClientMessage(playerid, COLOR_RED, "[INFO] You must be in a public service to use this command!");
		}
	return 1;
}

dcmd_dep(playerid, params[])
{
	if(!strlen(params))
		{
		SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /dep [MESSAGE]");
		return 1;
		}
	new rname[24];
	GetPlayerName(playerid, rname, sizeof(rname));
	new temp[256];
	if(gTeam[playerid] == TEAM_POLICE_LS)
		{
		format(temp, sizeof(temp), "[DEP RADIO] Officer %s : %s",rname,params);
		SendClientMessageForTeam(TEAM_POLICE_LS,COLOR_BLUE,temp);
		}
    else if(gTeam[playerid] == TEAM_POLICE_SF)
		{
		format(temp, sizeof(temp), "[DEP RADIO] Officer %s : %s",rname,params);
		SendClientMessageForTeam(TEAM_POLICE_SF,COLOR_BLUE,temp);
		}
    else if(gTeam[playerid] == TEAM_POLICE_LV)
		{
		format(temp, sizeof(temp), "[DEP RADIO] Officer %s : %s",rname,params);
		SendClientMessageForTeam(TEAM_POLICE_LV,COLOR_BLUE,temp);
		}
	else if (gTeam[playerid] == TEAM_MEDIC_LS)
		{
		format(temp, sizeof(temp), "[DEP RADIO] Medic %s: %s",rname,params);
		SendClientMessageForTeam(TEAM_MEDIC_LS,COLOR_BLUE,temp);
		}
	else if (gTeam[playerid] == TEAM_MEDIC_SF)
		{
		format(temp, sizeof(temp), "[DEP RADIO] Medic %s: %s",rname,params);
		SendClientMessageForTeam(TEAM_MEDIC_SF,COLOR_BLUE,temp);
		}
	else if (gTeam[playerid] == TEAM_MEDIC_LV)
		{
		format(temp, sizeof(temp), "[DEP RADIO] Medic %s: %s",rname,params);
		SendClientMessageForTeam(TEAM_MEDIC_LV,COLOR_BLUE,temp);
		}
	else
		{
		SendClientMessage(playerid, COLOR_RED, "[INFO] You must be a cop or a medic to use this command!");
		}
	return 1;
}
//-----------------------------------------------------SUSPECT-------------------------------------------------------
dcmd_suspect(playerid, params[])
{
	if(gTeam[playerid] == TEAM_POLICE_LS || gTeam[playerid] == TEAM_POLICE_SF || gTeam[playerid] == TEAM_POLICE_LV)
	{
	new giveplayerid, string[256];
	if (!sscanf(params, "ds", giveplayerid, string)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /suspect [ID] [REASON]");
	else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Invalid ID");
	else if (GetPlayerWantedLevel(giveplayerid)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Suspect is aldery wanted.");
	else
		{
		WantedLevel(giveplayerid,"+1",string);
		new tmp[256];
		format(tmp,256,"[INFO] You got reported for %s by %s",string,PlayerName(playerid));
		SendClientMessage(giveplayerid, COLOR_RED, tmp);
		SendClientMessage(giveplayerid, COLOR_RED, "[INFO] If you think that it's wrong, please contact /911, thanks");
		}
	}
	else
	{
	SendClientMessage(playerid, COLOR_RED, "[INFO] You must be a cop for use this command!");
	}
	return 1;
}
//-------------------------------------------------------BRIBE COMMANDS-----------------------------------------------------
dcmd_bribe(playerid, params[])
{
	new ammount,
	giveplayerid;
	if (!sscanf(params, "dd", giveplayerid, ammount)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /bribe [ID] [AMMOUNT]");
	else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Invalid ID");
	else if (GetPlayerWantedLevel(playerid) == 0) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Your not wanted");
	else if (BribeTo[playerid]!=999) SendClientMessage(playerid, 0xFF0000FF, "[INFO] You are aldery bribing. Do /bribecancel for cancel.");
	else if (ammount < 1) SendClientMessage(playerid, 0xFF0000FF, "[INFO] You bribe must be bigger.");
	else if (ammount > GetPlayerMoney(playerid)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Dont have that much to bribe with.");
	else if (BribeFrom[giveplayerid] != 999) SendClientMessage(playerid, 0xFF0000FF, "[INFO] That cop is being bribed right now.");
	else
		{
		BribeTo[playerid] = giveplayerid;
		BribeFrom[giveplayerid] = playerid;
		Bribe[giveplayerid] = ammount;
		new bname[256];
		new tmp[256];
		GetPlayerName(playerid, bname, sizeof(bname));
		format(tmp,256,"[INFO] %s offered you a bribe of $%s",bname, ammount);
		SendClientMessage(giveplayerid, COLOR_YELLOW, tmp);
		SendClientMessage(giveplayerid, COLOR_YELLOW, "[INFO] Do /bribeacc for accept or /bribedec for decline and report");
		SendClientMessage(playerid, COLOR_GREEN, "[INFO] Bribe offered. Do /bribecancel or wait for an response");
		}
	return 1;
}
//------------------------------------------------------------HITMAN------------------------------------------------------------------------
dcmd_hitman(playerid, params[])
{
	new id, amount;
	if (!sscanf(params, "dd", id, amount)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /hitman [ID] [MONEY]");
	else if (amount<1) SendClientMessage(playerid, 0xFF0000FF, "[INFO] The amount must be bigger than 0.");
	else if (amount>GetPlayerMoney(playerid)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] You dont have enough money.");
	else if (IsPlayerConnected(id))
		{
		new tmp[256];
		Hitman[id]+=amount;
		format(tmp,256,"[HITMAN] %s put a hitman contract on %s's head of $%d (total: $%d)",PlayerName(playerid),PlayerName(id),amount,Hitman[id]);
		SendClientMessageToAll(COLOR_BLUE,tmp);
		GivePlayerMoneyEx(playerid,-amount,"placing hitman contract");
		}
	else
		{
		SendClientMessage(playerid, 0xFF0000FF, "[INFO] Invalid ID.");
		}
	return 1;
}
//------------------------------------------------------------SAY COMMAND------------------------------------------------------------------------
dcmd_say(playerid, params[])
{
	new string[256];
	if (!sscanf(params, "s", string)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /say [MESSAGE]");
	else if (IsPlayerConnected(playerid))
	{
	new sname[256];
	GetPlayerName(playerid, sname, sizeof(sname));
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
	if(GetDistanceBetweenPlayers(playerid, i) < 10)
	{
	new temp[256];
	format(temp, sizeof(temp), "%s Says: %s",sname, params);
	SendClientMessage(i,COLOR_YELLOW,temp);
	}
	}
	return 1;
	}
	return 1;
	}

//------------------------------------------------------------GET DISTANCE BEETWEN PLAYERS------------------------------------------------------------------------
public Float:GetDistanceBetweenPlayers(p1,p2){
new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
if (!IsPlayerConnected(p1) || !IsPlayerConnected(p2)){
return -1.00;
}
GetPlayerPos(p1,x1,y1,z1);
GetPlayerPos(p2,x2,y2,z2);
return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

//------------------------------------------------------------HEAL COMMAND------------------------------------------------------------------------
dcmd_heal(playerid, params[])
{
	if(gTeam[playerid] == TEAM_MEDIC_LS || gTeam[playerid] == TEAM_MEDIC_SF || gTeam[playerid] == TEAM_MEDIC_LV)
		{
		if(IsPlayerInAnyVehicle(playerid))
			{
			if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 416)
				{
				new giveplayerid;
				if (!sscanf(params, "d", giveplayerid)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /heal [ID]");
				else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Invalid ID");
				else if (IsPlayerConnected(giveplayerid))
					{
					new hname[256];
					GetPlayerName(playerid, hname, sizeof(hname));
					if(GetPlayerVehicleID(giveplayerid) == GetPlayerVehicleID(playerid))
						{
						new Float:health;
						GetPlayerHealth(giveplayerid, health);
						if (health < 100)
							{
							new temp[256];
							format(temp, sizeof(temp), "[INFO] %s Healed You",hname);
	 						if(IsPlayerConnected(giveplayerid))
							SendClientMessage(giveplayerid,COLOR_GREEN,temp);
							SendClientMessage(playerid,COLOR_GREEN,"[INFO] Good Job, You Earned $50");
							GivePlayerMoneyEx(playerid,50,"healing");
							SetPlayerHealth(giveplayerid,100);
							}
						else
							{
							SendClientMessage(playerid,COLOR_RED,"[INFO] He doesnt need to be healed");
							}
						}
					else
						{
						SendClientMessage(playerid, COLOR_RED, "[INFO] The pacient must be in your vehicle to be healed!");
						}
					}
    			}
			else
				{
				SendClientMessage(playerid, COLOR_RED, "[INFO] You must be in an abulance for use this command!");
				}
			}
		else
			{
			SendClientMessage(playerid, COLOR_RED, "[INFO] You must be in an abulance for use this command!");
			}
  }
	else
		{
		SendClientMessage(playerid, COLOR_RED, "[INFO] You must be a medic for use this command!");
		}
	return 1;
}

//--------------------------------------------------------------------TAXI-------------------------------------------------------------------------------------
dcmd_taxi(playerid, params[])
{
{
	new price;
	if (!sscanf(params, "d",price)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /taxi [PRICE]");
	if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
		{
		SendClientMessage(playerid,COLOR_RED,"[INFO] You must be driving the taxi");
		}
	else
		{
		if (IsPlayerConnected(playerid))
			{
			new j = GetPlayerVehicleID(playerid);
			if(GetVehicleModel(j) == 420)
				{
				new tname[256];
				GetPlayerName(playerid, tname, sizeof(tname));
				new temp[256];
				TaxiPrice[playerid] = price;
				format(temp, sizeof(temp), "[TAXI] %s is offering taxi sevices for $%d",tname, price);
				SendClientMessageToAll(COLOR_BLUE,temp);
				TaxiService[playerid] = 1;
				TaxiCar[playerid] = GetPlayerVehicleID(playerid);
				}
			else
				{
				SendClientMessage(playerid,COLOR_RED,"[INFO] You Must Be In A Taxi To Do This Job");
				}
			}
		else
			{
			SendClientMessage(playerid,COLOR_RED,"[INFO] You Must Be In A Taxi To Do This Job");
			}
		}
	}
return 1;
}

dcmd_pizza(playerid, params[])
{
{
	new price;
	if (!sscanf(params, "d",price)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /pizza [PRICE]");
	else if (price < 1) SendClientMessage(playerid, 0xFF0000FF, "[INFO] You cant sell pizzas or free!");
	if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
		{
		SendClientMessage(playerid,COLOR_RED,"[INFO] You must be driving the pizzaboy");
		}
	else
		{
		if (IsPlayerConnected(playerid))
			{
			new j = GetPlayerVehicleID(playerid);
			if(GetVehicleModel(j) == 448)
				{
				new tname[256];
				GetPlayerName(playerid, tname, sizeof(tname));
				new temp[256];
				PizzaPrice[playerid] = price;
				format(temp, sizeof(temp), "[PIZZA] %s is offering pizza at $%d each",tname, price);
				SendClientMessageToAll(COLOR_YELLOW,temp);
				PizzaService[playerid] = 1;
				PizzaBike[playerid] = GetPlayerVehicleID(playerid);
				}
			else
				{
				SendClientMessage(playerid,COLOR_RED,"[INFO] You must be on a pizzaboy to do this job");
				}
			}
		else
			{
			SendClientMessage(playerid,COLOR_RED,"[INFO] You must be on a pizzaboy to do this job");
			}
		}
	}
return 1;
}

//--------------------------------------------------------------------ADMIN ANOUNCE-------------------------------------------------------------------------------------
dcmd_announce(playerid, params[])
{
	if(IsPlayerAdmin(playerid))
		{
		new str[256];
		if (!sscanf(params, "s", str)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /announce [message]");
		else
			{
			GameTextForAll(str, 10000, 6);
			new str2[256];
			format(str2,256,"[ADMIN ANNOUNCE] %s",str);
			SendClientMessageToAll(COLOR_ORANGE, str2);
			}
		}
	return 1;
}

//--------------------------------------------------------------------ADMIN SAY-------------------------------------------------------------------------------------
dcmd_adminsay(playerid, params[])
{
	if(IsPlayerAdmin(playerid))
		{
		new str[256];
		if (!sscanf(params, "s", str)) SendClientMessage(playerid, 0xFF0000FF, "[INFO] Usage: /adminsay [message]");
		new str2[256];
		format(str2,256,"[ADMIN] %s",str);
		SendClientMessageToAll(COLOR_ORANGE, str2);
		}
	return 1;
}

//--------------------------------------------------------------------------------BORDER CROSSINGS--------------------------------------------------------------
public BorderControlNSF()
{
//NORTH SF BRIDGE
	for (new i = 0; i < MAX_PLAYERS; i++)
    	{
		if (IsPlayerConnected(i))
    		{
    		if(gTeam[i] != TEAM_POLICE_LS && gTeam[i] != TEAM_POLICE_SF && gTeam[i] != TEAM_POLICE_LV && gTeam[i] != TEAM_MEDIC_LS && gTeam[i] != TEAM_MEDIC_SF && gTeam[i] != TEAM_MEDIC_LV)
    			{
//SF END COMING UP
	            GetPlayerPos(i,Pos[i][0],Pos[i][1],Pos[i][2]);
	            if(Pos[i][0] >   -2695.0823 && Pos[i][0] <  -2655.6492	// xmin, xmax
	            && Pos[i][1] > 1202.9296 && Pos[i][1] < 1239.9252	// ymin, ymax
	            && Pos[i][2] > 55.0000 && Pos[i][2] <  56.0000	// zmin, zmax
	            && PassportShown[i] == 0)
	        	    {
		            if(AntiSpam[i][1] == 0)
	    	        	{
		    	       	SendClientMessage(i,COLOR_YELLOW, "[INFO] Please Slow Down, Border Control Coming Up");
	    	    	   	PassportShown[i] = 0;
	        	   		DisablePlayerCheckpoint(i);
		        	   	AntiSpam[i][1] = 1;
	    	    	   	}
	        	    }
	            else 
	            	{
	            	if (AntiSpam[i][1] == 1)
		            	{
		            	AntiSpam[i][1] = 0;
		            	}
		            if(PassportShown[i])
		    	    	{
		    	    	PassportShown[i] = 0;
		    	    	}
//OTHER END COMING UP
	    	        if(Pos[i][0] >   -2731.9817 && Pos[i][0] <  -2668.5037	// xmin, xmax
	        	    && Pos[i][1] > 2195.2935 && Pos[i][1] < 2268.7847	// ymin, ymax
	            	&& Pos[i][2] > 55.0000 && Pos[i][2] <  58.0000	// zmin, zmax
	            	&& PassportShown[i] == 0)
	            		{
			            if(AntiSpam[i][2] == 0)
	        		    	{
	            			SendClientMessage(i,COLOR_YELLOW, "[INFO] Please Slow Down, Border Control Coming Up");
			            	PassportShown[i] = 0;
	        		    	DisablePlayerCheckpoint(i);
	            			AntiSpam[i][2] = 1;
			            	}
	        		    }
	            	else 
	            		{
	            		if (AntiSpam[i][2] == 1)
			            	{
		    	        	AntiSpam[i][2] = 0;
		        	    	}
		        	    if(PassportShown[i])
		        	    	{
		        	    	PassportShown[i] = 0;
		        	    	}
//SF END SHOW
		    		    if(Pos[i][0] >   -2699.4275 && Pos[i][0] <  -2663.7271	// xmin, xmax
				        && Pos[i][1] > 1262.0978 && Pos[i][1] < 1287.4410	// ymin, ymax
		    		    && Pos[i][2] > 55.0000 && Pos[i][2] <  56.0000	// zmin, zmax
		    		    && PassportShown[i] == 0)
				            {
		        		    if(AntiSpam[i][3] == 0)
			            		{
		    		    		SendClientMessage(i,COLOR_GREEN, "[INFO] Border Control, Please Show Passport");
		            			SetPlayerCheckpoint(i,-2679.7639,1274.5414,55.4297,2.0);
			                	gCurrentCheckpoint[i] = 5;
		    		        	AntiSpam[i][3] = 1;
		            			}
	    					}
	        			else
	        				{
	        				if (AntiSpam[i][3] == 1)
				            	{
		        		    	AntiSpam[i][3] = 0;
		            			}
//OTHER END SHOW
				            if(Pos[i][0] >   -2700.3267 && Pos[i][0] <  -2664.0000	// xmin, xmax
	            			&& Pos[i][1] > 2136.0452 && Pos[i][1] < 2180.7039	// ymin, ymax
				            && Pos[i][2] > 55.0000 && Pos[i][2] <  56.0000	// zmin, zmax
				            && PassportShown[i] == 0)
	            				{
	            				if(AntiSpam[i][4] == 0)
	            					{
				                	SendClientMessage(i,COLOR_GREEN, "[INFO] Border Control, Please Show Passport");
	            			    	SetPlayerCheckpoint(i,-2699.5549,2147.3140,55.8125,2.0);
				                	gCurrentCheckpoint[i] = 6;
	            			    	AntiSpam[i][4] = 1;
	                				}
	            				}
	            			else 
	            				{
	            				if (AntiSpam[i][4] == 1)
		            				{
		            				AntiSpam[i][4] = 0;
		            				}
//MIDDLE OF BRIDGE
					            if(Pos[i][0] >   -2699.2554 && Pos[i][0] < -2663.5540	// xmin, xmax
					            && Pos[i][1] > 1694.6996 && Pos[i][1] < 1772.8712	// ymin, ymax
					            && Pos[i][2] > 67.0000 && Pos[i][2] <  69.0000	// zmin, zmax
					            && PassportShown[i] == 0)
	            					{
					            	if(AntiSpam[i][5] == 0)
							           	{
						    	        SendClientMessage(i,COLOR_RED, "[WARNING] We Told You To Stop!");
	        	    					if(GetPlayerWantedLevel(i) < 2)
	        	    						{
	        	    						WantedLevel(i, "+2", "crossing North SF border line without showing passport");
	        	    						}
	        	    					else
	        	    						{
	        	    						WantedLevel(i, "+1", "crossing North SF border line without showing passport");
	        	    						}
										DisablePlayerCheckpoint(i);					
										AntiSpam[i][5] = 1;
										}
	            					}
	            				else 
	            					{
	            					if (AntiSpam[i][5] == 1)
						            	{
		            					AntiSpam[i][5] = 0;
						            	}
//MIDDLE OF BRIDGE
						            if(Pos[i][0] > -2699.4260 && Pos[i][0] <  -2663.7061	// xmin, xmax
						            && Pos[i][1] > 1330.6752 && Pos[i][1] < 1345.6005	// ymin, ymax
	            					&& Pos[i][2] > 67.0000 && Pos[i][2] <  69.0000	// zmin, zmax
	            					&& PassportShown[i] == 1)
										{
										if(AntiSpam[i][6] == 0)
	            							{
											SendClientMessage(i,COLOR_GREEN, "[INFO] Have A Nice Trip");
											DisablePlayerCheckpoint(i);
											AntiSpam[i][6] = 1;
											}
	            						}
	            					else 
	            						{
	            						if (AntiSpam[i][6] == 1)
		            						{
		            						AntiSpam[i][6] = 0;
		            						}
//PASSPORT SHOWN VARIABLE BACK TO 0 SF END
							            if(Pos[i][0] >   -2695.0823 && Pos[i][0] <  -2655.6492	// xmin, xmax
	            						&& Pos[i][1] > 1202.9296 && Pos[i][1] < 1239.9252	// ymin, ymax
	            						&& Pos[i][2] > 55.0000 && Pos[i][2] <  56.0000	// zmin, zmax
	            						&& PassportShown[i] == 1)
	            							{
							            	if(AntiSpam[i][7] == 0)
							            		{
	            								PassportShown[i] = 0;
	            								DisablePlayerCheckpoint(i);
	            								AntiSpam[i][7] = 1;
	            								}
											}
										else 
											{
											if (AntiSpam[i][7] == 1)
		            							{
		            							AntiSpam[i][7] = 0;
		            							}
//OTHER END VARABLE SET BACK TO 0
	            							if(Pos[i][0] >   -2731.9817 && Pos[i][0] <  -2668.5037	// xmin, xmax
	            							&& Pos[i][1] > 2195.2935 && Pos[i][1] < 2268.7847	// ymin, ymax
	            							&& Pos[i][2] > 55.0000 && Pos[i][2] <  58.0000	// zmin, zmax
	            							&& PassportShown[i] == 1)
	            								{
	            								PassportShown[i] = 0;
	            								DisablePlayerCheckpoint(i);
	      										}
											}
										}
									}
								}
        					}
    					}
					}
				}
			}
		}
}
//=====================================================================================================================
public BorderControlESF()
{
//EAST SF BRIDGE
	for (new i = 0; i < MAX_PLAYERS; i++)
    	{
		if (IsPlayerConnected(i))
    		{
    		if(gTeam[i] != TEAM_POLICE_LS && gTeam[i] != TEAM_POLICE_SF && gTeam[i] != TEAM_POLICE_LV && gTeam[i] != TEAM_MEDIC_LS && gTeam[i] != TEAM_MEDIC_SF && gTeam[i] != TEAM_MEDIC_LV)
    			{
//SF END COMING UP
	            GetPlayerPos(i,Pos[i][0],Pos[i][1],Pos[i][2]);
	            if(Pos[i][0] >   -1742.1115 && Pos[i][0] <  -1678.1652	// xmin, xmax
	            && Pos[i][1] > 471.2118 && Pos[i][1] < 533.2728	// ymin, ymax
	            && Pos[i][2] > 38.0000 && Pos[i][2] <  39.0000	// zmin, zmax
	            && PassportShown[i] == 0)
	        	    {
		            if(AntiSpam[i][8] == 0)
	    	        	{
		    	       	SendClientMessage(i,COLOR_YELLOW, "[INFO] Please Slow Down, Border Control Coming Up");
	    	    	   	PassportShown[i] = 0;
	        	   		DisablePlayerCheckpoint(i);
		        	   	AntiSpam[i][8] = 1;
	    	    	   	}
	        	    }
	            else 
	            	{
	            	if (AntiSpam[i][8] == 1)
		            	{
		            	AntiSpam[i][8] = 0;
		            	}
		            if(PassportShown[i])
		    	    	{
		    	    	PassportShown[i] = 0;
		    	    	}
//OTHER END COMING UP
	    	        if(Pos[i][0] >   -1129.0428 && Pos[i][0] <  -1054.1276	// xmin, xmax
				    && Pos[i][1] > 1120.1366 && Pos[i][1] < 1206.6489	// ymin, ymax
			        && Pos[i][2] > 37.0000 && Pos[i][2] <  40.0000	// zmin, zmax
			        && PassportShown[i] == 0)
	            		{
			            if(AntiSpam[i][9] == 0)
	        		    	{
	            			SendClientMessage(i,COLOR_YELLOW, "[INFO] Please Slow Down, Border Control Coming Up");
			            	PassportShown[i] = 0;
	        		    	DisablePlayerCheckpoint(i);
	            			AntiSpam[i][9] = 1;
			            	}
	        		    }
	            	else 
	            		{
	            		if (AntiSpam[i][9] == 1)
			            	{
		    	        	AntiSpam[i][9] = 0;
		        	    	}
		        	    if(PassportShown[i])
		        	    	{
		        	    	PassportShown[i] = 0;
		        	    	}
//SF END SHOW
		    		    if(Pos[i][0] >   -1690.0554 && Pos[i][0] <  -1653.0029	// xmin, xmax
				        && Pos[i][1] > 521.5991 && Pos[i][1] < 558.3115	// ymin, ymax
	            		&& Pos[i][2] > 38.0000 && Pos[i][2] <  39.0000	// zmin, zmax
		    		    && PassportShown[i] == 0)
				            {
		        		    if(AntiSpam[i][10] == 0)
			            		{
		    		    		SendClientMessage(i,COLOR_GREEN, "[INFO] Border Control, Please Show Passport");
		            			SetPlayerCheckpoint(i,-1654.4446,535.9866,38.4254,2.0);
			                	gCurrentCheckpoint[i] = 5;
		    		        	AntiSpam[i][10] = 1;
		            			}
	    					}
	        			else
	        				{
	        				if (AntiSpam[i][10] == 1)
				            	{
		        		    	AntiSpam[i][10] = 0;
		            			}
//OTHER END SHOW
				            if(Pos[i][0] >   -1146.2847 && Pos[i][0] <  -1098.7437	// xmin, xmax
	            			&& Pos[i][1] > 1094.7960 && Pos[i][1] < 1138.9366	// ymin, ymax
	            			&& Pos[i][2] > 37.0000 && Pos[i][2] <  39.0000	// zmin, zmax
				            && PassportShown[i] == 0)
	            				{
	            				if(AntiSpam[i][11] == 0)
	            					{
				                	SendClientMessage(i,COLOR_GREEN, "[INFO] Border Control, Please Show Passport");
	            			    	SetPlayerCheckpoint(i,-1145.0438,1116.0393,38.3927,2.0);
				                	gCurrentCheckpoint[i] = 6;
	            			    	AntiSpam[i][11] = 1;
	                				}
	            				}
	            			else 
	            				{
	            				if (AntiSpam[i][11] == 1)
		            				{
		            				AntiSpam[i][11] = 0;
		            				}
//MIDDLE OF BRIDGE
					            if(Pos[i][0] >  -1478.7906 && Pos[i][0] < -1418.3136	// xmin, xmax
	            				&& Pos[i][1] > 744.2067 && Pos[i][1] < 805.6381	// ymin, ymax
	            				&& Pos[i][2] > 46.0000 && Pos[i][2] <  48.0000	// zmin, zmax
					            && PassportShown[i] == 0)
	            					{
					            	if(AntiSpam[i][12] == 0)
							           	{
						    	        SendClientMessage(i,COLOR_RED, "[WARNING] We Told You To Stop!");
	        	    					if(GetPlayerWantedLevel(i) < 2)
	        	    						{
	        	    						WantedLevel(i, "+2", "Crossing North SF Border Line Without Showing Passport");
	        	    						}
	        	    					else
	        	    						{
	        	    						WantedLevel(i, "+1", "Crossing North SF Border Line Without Showing Passport");
	        	    						}
										DisablePlayerCheckpoint(i);					
										AntiSpam[i][12] = 1;
										}
	            					}
	            				else 
	            					{
	            					if (AntiSpam[i][12] == 1)
						            	{
		            					AntiSpam[i][12] = 0;
						            	}
//MIDDLE OF BRIDGE
						            if(Pos[i][0] >  -1478.7906 && Pos[i][0] < -1418.3136	// xmin, xmax
	           						&& Pos[i][1] > 744.2067 && Pos[i][1] < 805.6381	// ymin, ymax
	           						&& Pos[i][2] > 46.0000 && Pos[i][2] <  48.0000	// zmin, zmax
	            					&& PassportShown[i] == 1)
										{
										if(AntiSpam[i][13] == 0)
	            							{
											SendClientMessage(i,COLOR_GREEN, "[INFO] Have A Nice Trip");
											DisablePlayerCheckpoint(i);
											AntiSpam[i][13] = 1;
											}
	            						}
	            					else 
	            						{
	            						if (AntiSpam[i][13] == 1)
		            						{
		            						AntiSpam[i][13] = 0;
		            						}
//PASSPORT SHOWN VARIABLE BACK TO 0 SF END
							            if(Pos[i][0] >   -1129.0428 && Pos[i][0] <  -1054.1276	// xmin, xmax
	           							&& Pos[i][1] > 1120.1366 && Pos[i][1] < 1206.6489	// ymin, ymax
	           							&& Pos[i][2] > 37.0000 && Pos[i][2] <  40.0000	// zmin, zmax
	            						&& PassportShown[i] == 1)
	            							{
							            	if(AntiSpam[i][14] == 0)
							            		{
	            								PassportShown[i] = 0;
	            								DisablePlayerCheckpoint(i);
	            								AntiSpam[i][14] = 1;
	            								}
											}
										else 
											{
											if (AntiSpam[i][14] == 1)
		            							{
		            							AntiSpam[i][14] = 0;
		            							}
//OTHER END VARABLE SET BACK TO 0
	            							if(Pos[i][0] >   -1742.1115 && Pos[i][0] <  -1678.1652	// xmin, xmax
	           								&& Pos[i][1] > 471.2118 && Pos[i][1] < 533.2728	// ymin, ymax
	           								&& Pos[i][2] > 38.0000 && Pos[i][2] <  39.0000	// zmin, zmax
	            							&& PassportShown[i] == 1)
	            								{
	            								PassportShown[i] = 0;
	            								DisablePlayerCheckpoint(i);
	      										}
											}
										}
									}
								}
        					}
    					}
					}
				}
			}
		}
}
//--------------------------------------------------- LV------------------------------------------------------------
public BorderControlLV()
{
//SOUTH LV BRIDGE
	for (new i = 0; i < MAX_PLAYERS; i++)
    	{
		if (IsPlayerConnected(i))
    		{
    		if(gTeam[i] != TEAM_POLICE_LS && gTeam[i] != TEAM_POLICE_SF && gTeam[i] != TEAM_POLICE_LV && gTeam[i] != TEAM_MEDIC_LS && gTeam[i] != TEAM_MEDIC_SF && gTeam[i] != TEAM_MEDIC_LV)
    			{
//LS END COMING UP
	            GetPlayerPos(i,Pos[i][0],Pos[i][1],Pos[i][2]);
	            if(Pos[i][0] >   1667.0714 && Pos[i][0] <  1706.2162	// xmin, xmax
	            && Pos[i][1] > 351.2881 && Pos[i][1] < 388.7770	// ymin, ymax
	            && Pos[i][2] > 29.0000 && Pos[i][2] <  31.0000	// zmin, zmax
	            && PassportShown[i] == 0)
	        	    {
		            if(AntiSpam[i][15] == 0)
	    	        	{
		    	       	SendClientMessage(i,COLOR_YELLOW, "[INFO] Please Slow Down, Border Control Coming Up");
	    	    	   	PassportShown[i] = 0;
	        	   		DisablePlayerCheckpoint(i);
		        	   	AntiSpam[i][15] = 1;
	    	    	   	}
	        	    }
	            else 
	            	{
	            	if (AntiSpam[i][15] == 1)
		            	{
		            	AntiSpam[i][15] = 0;
		            	}
		            if(PassportShown[i])
		    	    	{
		    	    	PassportShown[i] = 0;
		    	    	}
//OTHER END COMING UP
	    	        if(Pos[i][0] >   1777.9760 && Pos[i][0] <  1816.4822	// xmin, xmax
				    && Pos[i][1] > 789.9437 && Pos[i][1] < 822.8147	// ymin, ymax
			        && Pos[i][2] > 10.0000 && Pos[i][2] <  12.0000	// zmin, zmax
			        && PassportShown[i] == 0)
	            		{
			            if(AntiSpam[i][16] == 0)
	        		    	{
	            			SendClientMessage(i,COLOR_YELLOW, "[INFO] Please Slow Down, Border Control Coming Up");
			            	PassportShown[i] = 0;
	        		    	DisablePlayerCheckpoint(i);
	            			AntiSpam[i][16] = 1;
			            	}
	        		    }
	            	else 
	            		{
	            		if (AntiSpam[i][16] == 1)
			            	{
		    	        	AntiSpam[i][16] = 0;
		        	    	}
		        	    if(PassportShown[i])
		        	    	{
		        	    	PassportShown[i] = 0;
		        	    	}
//LS END SHOW
		    		    if(Pos[i][0] >   1677.6586 && Pos[i][0] <  1719.5447	// xmin, xmax
				        && Pos[i][1] > 391.7205 && Pos[i][1] < 422.3311	// ymin, ymax
	            		&& Pos[i][2] > 30.0000 && Pos[i][2] <  32.0000	// zmin, zmax
		    		    && PassportShown[i] == 0)
				            {
		        		    if(AntiSpam[i][17] == 0)
			            		{
		    		    		SendClientMessage(i,COLOR_GREEN, "[INFO] Border Control, Please Show Passport");
		            			SetPlayerCheckpoint(i,1738.6207,470.6362,30.1848,2.0);
			                	gCurrentCheckpoint[i] = 5;
		    		        	AntiSpam[i][17] = 1;
		            			}
	    					}
	        			else
	        				{
	        				if (AntiSpam[i][17] == 1)
				            	{
		        		    	AntiSpam[i][17] = 0;
		            			}
//OTHER END SHOW
				            if(Pos[i][0] >   1769.4504 && Pos[i][0] <  1810.6412	// xmin, xmax
	            			&& Pos[i][1] > 703.7950 && Pos[i][1] < 736.2159	// ymin, ymax
	            			&& Pos[i][2] > 13.0000 && Pos[i][2] <  15.0000	// zmin, zmax
				            && PassportShown[i] == 0)
	            				{
	            				if(AntiSpam[i][18] == 0)
	            					{
				                	SendClientMessage(i,COLOR_GREEN, "[INFO] Border Control, Please Show Passport");
	            			    	SetPlayerCheckpoint(i,1759.6997,653.1240,18.7918,2.0);
				                	gCurrentCheckpoint[i] = 6;
	            			    	AntiSpam[i][18] = 1;
	                				}
	            				}
	            			else 
	            				{
	            				if (AntiSpam[i][18] == 1)
		            				{
		            				AntiSpam[i][18] = 0;
		            				}
//MIDDLE OF BRIDGE
					            if(Pos[i][0] >  1715.7388 && Pos[i][0] < 1764.9408	// xmin, xmax
	            				&& Pos[i][1] > 501.3943 && Pos[i][1] < 556.1805	// ymin, ymax
	            				&& Pos[i][2] > 26.0000 && Pos[i][2] <  29.0000	// zmin, zmax
					            && PassportShown[i] == 0)
	            					{
					            	if(AntiSpam[i][19] == 0)
							           	{
						    	        SendClientMessage(i,COLOR_RED, "[WARNING] We Told You To Stop!");
	        	    					if(GetPlayerWantedLevel(i) < 2)
	        	    						{
	        	    						WantedLevel(i, "+2", "Crossing North SF Border Line Without Showing Passport");
	        	    						}
	        	    					else
	        	    						{
	        	    						WantedLevel(i, "+1", "Crossing North SF Border Line Without Showing Passport");
	        	    						}
										DisablePlayerCheckpoint(i);					
										AntiSpam[i][19] = 1;
										}
	            					}
	            				else 
	            					{
	            					if (AntiSpam[i][19] == 1)
						            	{
		            					AntiSpam[i][19] = 0;
						            	}
//MIDDLE OF BRIDGE
						            if(Pos[i][0] >  1715.7388 && Pos[i][0] < 1764.9408	// xmin, xmax
	            					&& Pos[i][1] > 501.3943 && Pos[i][1] < 556.1805	// ymin, ymax
	            					&& Pos[i][2] > 26.0000 && Pos[i][2] <  29.0000	// zmin, zmax
	            					&& PassportShown[i] == 1)
										{
										if(AntiSpam[i][20] == 0)
	            							{
											SendClientMessage(i,COLOR_GREEN, "[INFO] Have A Nice Trip");
											DisablePlayerCheckpoint(i);
											AntiSpam[i][20] = 1;
											}
	            						}
	            					else 
	            						{
	            						if (AntiSpam[i][20] == 1)
		            						{
		            						AntiSpam[i][20] = 0;
		            						}
//PASSPORT SHOWN VARIABLE BACK TO 0 LV END
							            if(Pos[i][0] >   1777.9760 && Pos[i][0] <  1816.4822	// xmin, xmax
				    					&& Pos[i][1] > 789.9437 && Pos[i][1] < 822.8147	// ymin, ymax
			        					&& Pos[i][2] > 10.0000 && Pos[i][2] <  12.0000	// zmin, zmax
	            						&& PassportShown[i] == 1)
	            							{
							            	if(AntiSpam[i][21] == 0)
							            		{
	            								PassportShown[i] = 0;
	            								DisablePlayerCheckpoint(i);
	            								AntiSpam[i][21] = 1;
	            								}
											}
										else 
											{
											if (AntiSpam[i][21] == 1)
		            							{
		            							AntiSpam[i][21] = 0;
		            							}
//OTHER END VARABLE SET BACK TO 0
	            							if(Pos[i][0] >   1667.0714 && Pos[i][0] <  1706.2162	// xmin, xmax
	            							&& Pos[i][1] > 351.2881 && Pos[i][1] < 388.7770	// ymin, ymax
	            							&& Pos[i][2] > 29.0000 && Pos[i][2] <  31.0000	// zmin, zmax
	            							&& PassportShown[i] == 1)
	            								{
	            								PassportShown[i] = 0;
	            								DisablePlayerCheckpoint(i);
	      										}
											}
										}
									}
	        					}
	    					}
						}
					}
				}
			}
		}
}
//-----------------------------------------------------JAIL AREAS------------------------------------------------------------------
public JailArea()
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
    //Lv JAIL
        if (IsPlayerConnected(i))
       		{
            GetPlayerPos(i,Pos[i][0],Pos[i][1],Pos[i][2]);
            if(Pos[i][0] >   188.1787 && Pos[i][0] <  199.8479	// xmin, xmax
            && Pos[i][1] > 156.5844 && Pos[i][1] < 159.8817	// ymin, ymax
            && Pos[i][2] > 1003.0000 && Pos[i][2] <  1004.0000)	// zmin, zmax
            	{
            	if (gTeam[i] == TEAM_POLICE_LS || gTeam[i] == TEAM_POLICE_SF || gTeam[i] == TEAM_POLICE_LV)
            		{
	            	if(AntiSpam[i][22] == 0)
    	        		{
        	        	SendClientMessage(i,COLOR_YELLOW, "[INFO] If you have a criminal with you type /jail to jail him");
            	    	AntiSpam[i][22] = 1;
                		}
	                }
    	   		else if (GetPlayerWantedLevel(i) > 0 && AntiSpam[i][22] == 0)
        		   	{
        			SendClientMessage(i,COLOR_RED, "[INFO] You are wanted, you can be jailed here.");
        		   	InArea[i] =1;
        	   		AntiSpam[i][22] = 1;
	        	   	}
    	        }
	        else if(AntiSpam[i][22] == 1)
    	       	{
        	   	AntiSpam[i][22] = 0;
           		}
    //LS JAIL
            if(Pos[i][0] >   266.8465 && Pos[i][0] <  270.0471	// xmin, xmax
            && Pos[i][1] > 75.8415 && Pos[i][1] < 84.3310	// ymin, ymax
            && Pos[i][2] > 1001.0000 && Pos[i][2] <  1002.0000)	// zmin, zmax
            	{
            	if (gTeam[i] == TEAM_POLICE_LS || gTeam[i] == TEAM_POLICE_SF || gTeam[i] == TEAM_POLICE_LV)
            	{
            	if(AntiSpam[i][23] == 0)
	            	{
    	            SendClientMessage(i,COLOR_YELLOW, "[INFO] If you have a criminal with you type /jail to jail him");
        	        AntiSpam[i][23] = 1;
            	    }
            	}
            	else if (GetPlayerWantedLevel(i) > 0 && AntiSpam[i][23] == 0)
        	   	{
        	   	SendClientMessage(i,COLOR_RED, "[INFO] You are wanted, you can be jailed here.");
        	   	InArea[i] =1;
        	   	AntiSpam[i][23] = 1;
        	   	}
            	}
            else if(AntiSpam[i][23] == 1)
           		{
           		AntiSpam[i][23] = 0;
           		}
     //SF JAIL
            if(Pos[i][0] >   214.1211 && Pos[i][0] <  228.8355	// xmin, xmax
            && Pos[i][1] > 113.1860 && Pos[i][1] < 116.0302	// ymin, ymax
            && Pos[i][2] > 999.0000 && Pos[i][2] <  1000.0000)	// zmin, zmax
            	{
            	if (gTeam[i] == TEAM_POLICE_LS || gTeam[i] == TEAM_POLICE_SF || gTeam[i] == TEAM_POLICE_LV)
            	{
            	if(AntiSpam[i][24] == 0)
	           		{
	    	        SendClientMessage(i,COLOR_YELLOW, "[INFO] If you have a criminal with you type /jail to jail him");
    	    	    AntiSpam[i][24] = 1;
        	    	}
        	   	}
        	   	else if (GetPlayerWantedLevel(i) > 0 && AntiSpam[i][24] == 0)
        	   	{
        	   	SendClientMessage(i,COLOR_RED, "[INFO] You are wanted, you can be jailed here.");
        	   	InArea[i] =1;
        	   	AntiSpam[i][24] = 1;
        	   	}
            	}
            else if(AntiSpam[i][24] == 1)
           		{
           		AntiSpam[i][24] = 0;
           		}
            }
        }
}

public WantedColor()
{
	for (new i = 0; i < MAX_PLAYERS; i++)
    	{
		if(!Spawned[i])
			{
			SetPlayerColor(i,COLOR_GREY);
			}
		else if(gTeam[i] == TEAM_POLICE_LS || gTeam[i] == TEAM_POLICE_LV || gTeam[i] == TEAM_POLICE_SF)
			{
			SetPlayerColor(i,COLOR_BLUE);
			}
		else if(gTeam[i] == TEAM_MEDIC_LS || gTeam[i] == TEAM_MEDIC_LV || gTeam[i] == TEAM_MEDIC_SF)
			{
			SetPlayerColor(i,COLOR_GREEN);
			}
		else if(gTeam[i] == TEAM_FBI)
			{
			SetPlayerColor(i,COLOR_GREEN);
			}
		else if(gTeam[i] == TEAM_CITIZEN_LS || gTeam[i] == TEAM_CITIZEN_LV || gTeam[i] == TEAM_CITIZEN_SF)
			{
			if(GetPlayerWantedLevel(i) == 0)
				{
				SetPlayerColor(i,COLOR_WHITE);
				}
			else if(GetPlayerWantedLevel(i) == 1)
				{
				SetPlayerColor(i,WANTED_1);
				}
			else if(GetPlayerWantedLevel(i) == 2)
				{
				SetPlayerColor(i,WANTED_2);
				}
			else if(GetPlayerWantedLevel(i) == 3)
				{
				SetPlayerColor(i,WANTED_3);
				}
			else if(GetPlayerWantedLevel(i) == 4)
				{
				SetPlayerColor(i,WANTED_4);
				}
			else if(GetPlayerWantedLevel(i) == 5)
				{
				SetPlayerColor(i,WANTED_5);
				}
			else if(GetPlayerWantedLevel(i) == 6)
				{
				SetPlayerColor(i,WANTED_6);
				}
			}
		}
}

public Benefit()
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
	if (IsPlayerConnected(i))
		{
		SendClientMessage(i,COLOR_GREEN,"[INFO] You recieved $80 benefits from the government");
		GivePlayerMoneyEx(i,80,"payday");
		}
	}
}

public Jail()
{
	for(new i=0;i<MAX_PLAYERS;i++)
		{
 		if(IsPlayerConnected(i))
 			{
 			if(JailLeft[i] == 0)
	 			{
	 			if(Jailed[i] == 2)
					{
					SetPlayerInterior(i,0);
					SetPlayerPos(i, -1587.3734, 715.8876, -5.2422);
					Jailed[i] = 0;
					SendClientMessage(i, COLOR_GREEN, "[INFO] You are free now. Please, dont do that again.");
					}
				else if (Jailed[i] == 3)
					{
					SetPlayerInterior(i,0);
					SetPlayerPos(i, 2286.6089, 2422.8867, 10.8203);
					Jailed[i] = 0;
					SendClientMessage(i, COLOR_GREEN, "[INFO] You are free now. Please, dont do that again.");
					}
				else if (Jailed[i] == 1)
					{
					SetPlayerInterior(i,0);
					SetPlayerPos(i, 1545.9517, -1675.4757, 13.5614);
					Jailed[i] = 0;
					SendClientMessage(i, COLOR_GREEN, "[INFO] You are free now. Please, dont do that again.");
					}
				}
			else if(Jailed[i] == 1 || Jailed[i] == 2 || Jailed[i] == 3)
				{
				new tmp[256], mins, sec;
				sec = JailLeft[i];
				for(new o;o<11;o++)
					{
					if(sec>59)
						{
						mins++;
						sec-=60;
						}
					}
				if(sec < 10)
					{
					format(tmp,256,"%d:0%d", mins, sec);
					}
				else
					{
					format(tmp,256,"%d:%d", mins, sec);
					}
				GameTextForPlayer(i,tmp,1500,6);
				JailLeft[i] -= 1;
				}
			}
		}
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	if(newinteriorid == 0)
		{
		PlayerShop[playerid] = 0;
		}
}

public Advert()
{
if(advert == 0)
	{
	for(new i=0;i<MAX_PLAYERS;i++)
		{
		SendClientMessage(i,COLOR_ORANGE,"[SERVER] Visit forums at www.comptoncity.ar.nu for a full RPG experience");
		advert = 1;
		}
	}
else if(advert == 1)
	{
	for(new i=0;i<MAX_PLAYERS;i++)
		{
		SendClientMessage(i,COLOR_ORANGE,"[SERVER] Thanks to SpeedyDVV for free hosting the server (server ip: 85.148.169.38)");
		advert = 0;
		}
	}
return 1;
}

public Unfreeze(playerid)
{
	SurrenderTimerCheck[playerid] = 0;
	TogglePlayerControllable(playerid,1);
}

public ShowPDChecks(playerid)
{
	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx, posy, posz);
	new Float:ls, Float:sf, Float:lv;
	ls = floatsqroot(floatpower(posx - 1548.8903, 2) + floatpower(posy - -1610.0613, 2) + floatpower(posz - 13.3828, 2));
	sf = floatsqroot(floatpower(posx - -1571.6542, 2) + floatpower(posy - 705.8767, 2) + floatpower(posz - -5.2422, 2));
	lv = floatsqroot(floatpower(posx - 2314.9749, 2) + floatpower(posy - 2460.0366, 2) + floatpower(posz - 3.2734, 2));
	if (ls < sf && ls < lv)
		{
		gCurrentCheckpoint[playerid] = 15;
		SetPlayerCheckpoint(playerid,1548.8903,-1610.0613,13.3828,5.0);
		}
	else if (sf < ls && sf < lv)
		{
		gCurrentCheckpoint[playerid] = 15;
		SetPlayerCheckpoint(playerid,-1571.6542,705.8767,-5.2422,5.0);
		}
	else if (lv < ls && lv < sf)
		{
		gCurrentCheckpoint[playerid] = 15;
		SetPlayerCheckpoint(playerid,2314.9749,2460.0366,3.2734,5.0);
		}
}

public NotJailed(playerid,criminalid)
{
	TogglePlayerControllable(criminalid,1);
	SendClientMessage(playerid,COLOR_RED,"[INFO] You was unable to jail the criminal in time, he got free.");
	SendClientMessage(criminalid,COLOR_GREEN,"[INFO] Cop wasnt able to jail you in time, you are free.");
	SurrenderedPlayer[playerid] = 999;
}

stock SystemMsg(playerid,msg[]) {
   if ((IsPlayerConnected(playerid))&&(strlen(msg)>0)) {
       SendClientMessage(playerid,COLOR_SYSTEM,msg);
   }
   return 1;
}

public ModCars(vehicleid)
{
	for(new i;i<18;i++)
		{
		if(i!= 16 && Component[vehicleid][i]) AddVehicleComponent(vehicleid,Component[vehicleid][i]);
		else if (i==16 && Component[vehicleid][i]) ChangeVehiclePaintjob(vehicleid,Component[vehicleid][i]);
		}
}

public OnVehicleMod(vehicleid, componentid)
{
	new driver;
	for (new u;u<MAX_PLAYERS;u++)
		{
		if(GetPlayerVehicleID(u)==vehicleid && GetPlayerState(u) == PLAYER_STATE_DRIVER) driver=u;
		}
	if(gOwner[vehicleid]==driver)
		{
		printf("Vehicleid: %d - Componentid: %d",vehicleid,componentid);
		if(componentid == 1000 || componentid == 1001 || componentid == 1002 || componentid == 1003 || componentid == 1014 || componentid == 1015 || componentid == 1016 ||
		componentid == 1023 || componentid == 1049 || componentid == 1050 || componentid == 1058 || componentid == 1138 || componentid == 1139 || componentid == 1146 || componentid == 1147 ||
		componentid == 1158 || componentid == 1162 || componentid == 1163 || componentid == 1164)
			{
			Component[vehicleid][0] = componentid;
			}
		else if(componentid == 1006 || componentid == 1032 || componentid == 1033 || componentid == 1035 || componentid == 1038 || componentid == 1053 || componentid == 1054 ||
		componentid == 1055 || componentid == 1061 || componentid == 1067 || componentid == 1068 || componentid == 1088 || componentid == 1091 || componentid == 1103 ||
		componentid == 1128 || componentid == 1130 || componentid == 1131)
			{
			Component[vehicleid][1] = componentid;
			}
		else if(componentid == 1004 || componentid == 1005 || componentid == 1011 || componentid == 1012)
			{
			Component[vehicleid][2] = componentid;
			}
		else if(componentid == 1007 || componentid == 1017 || componentid == 1026 || componentid == 1027 || componentid == 1030 || componentid == 1031 || componentid == 1036 ||
		componentid == 1039 || componentid == 1040 || componentid == 1041 || componentid == 1042 || componentid == 1047 || componentid == 1048 || componentid == 1051 || componentid == 1052 ||
	 	componentid == 1056 || componentid == 1057 || componentid == 1062 || componentid == 1063 || componentid == 1069 || componentid == 1070 || componentid == 1071 || componentid == 1072 ||
	 	componentid == 1090 || componentid == 1093 || componentid == 1094 || componentid == 1095 || componentid == 1099 || componentid == 1101 || componentid == 1102 || componentid == 1106 ||
	  	componentid == 1107 || componentid == 1108 || componentid == 1118 || componentid == 1119 || componentid == 1120 || componentid == 1121 || componentid == 1122 || componentid == 1124 ||
	 	componentid == 1133 || componentid == 1134 || componentid == 1137)
	 		{
	 		Component[vehicleid][3] = componentid;
	 		}
	 	else if(componentid == 1008 || componentid == 1009 || componentid == 1010)
			{
			Component[vehicleid][4] = componentid;
			}
		else if(componentid == 1013 || componentid == 1024)
			{
			Component[vehicleid][5] = componentid;
			}
		else if(componentid == 1018 || componentid == 1019 || componentid == 1020 || componentid == 1021 || componentid == 1022 || componentid == 1028 || componentid == 1029 ||
		componentid == 1034 || componentid == 1037 || componentid == 1043 || componentid == 1044 || componentid == 1045 || componentid == 1046 || componentid == 1059 || componentid == 1064 ||
		componentid == 1065 || componentid == 1066 || componentid == 1089 || componentid == 1092 || componentid == 1104 || componentid == 1105 || componentid == 1113 || componentid == 1114 ||
		componentid == 1126 || componentid == 1127 || componentid == 1129 || componentid == 1132 || componentid == 1135 || componentid == 1136)
			{
			Component[vehicleid][6] = componentid;
			}
		else if(componentid == 1025 || componentid == 1073 || componentid == 1074 || componentid == 1075 || componentid == 1076 || componentid == 1077 || componentid == 1078 ||
		componentid == 1079 || componentid == 1080 || componentid == 1081 || componentid == 1082 || componentid == 1083 || componentid == 1084 || componentid == 1085 || componentid == 1096 ||
	 	componentid == 1097 || componentid == 1098)
	 		{
	 		Component[vehicleid][7] = componentid;
	 		}
	 	else if(componentid == 1086)
	 		{
	 		Component[vehicleid][8] = componentid;
	 		}
	 	else if(componentid == 1087)
	 		{
	 		Component[vehicleid][9] = componentid;
	 		}
	 	else if(componentid == 1100 || componentid == 1123 || componentid == 1125)
	 		{
	 		Component[vehicleid][10] = componentid;
	 		}
	 	else if(componentid == 1109 || componentid == 1110)
	 		{
	 		Component[vehicleid][11] = componentid;
	 		}
	 	else if(componentid == 1115 || componentid == 1116)
	 		{
	 		Component[vehicleid][12] = componentid;
	 		}
	 	else if(componentid == 1117 || componentid == 1152 || componentid == 1153 || componentid == 1155 || componentid == 1157 || componentid == 1160 || componentid == 1165 ||
	  	componentid == 1166 || componentid == 1169 || componentid == 1170 || componentid == 1171 || componentid == 1172 || componentid == 1173 || componentid == 1174 || componentid == 1176 ||
	 	componentid == 1179 || componentid == 1181 || componentid == 1182 || componentid == 1185 || componentid == 1188 || componentid == 1189 || componentid == 1190 || componentid == 1191)
	 		{
	 		Component[vehicleid][13] = componentid;
	 		}
	 	else if(componentid == 1140 || componentid == 1141 || componentid == 1148 || componentid == 1149 || componentid == 1150 || componentid == 1151 || componentid == 1154 ||
	 	componentid == 1156 || componentid == 1159 || componentid == 1161 || componentid == 1167 || componentid == 1168 || componentid == 1175 || componentid == 1177 || componentid == 1178 ||
	 	componentid == 1180 || componentid == 1183 || componentid == 1184 || componentid == 1186 || componentid == 1187 || componentid == 1192 || componentid == 1193)
	 		{
	 		Component[vehicleid][14] = componentid;
	 		}
	 	else if(componentid == 1142 || componentid == 1143 || componentid == 1144 || componentid == 1145)
	 		{
	 		Component[vehicleid][15] = componentid;
	 		}
	 	else if(componentid == 1111 || componentid == 1112)
	 		{
	 		Component[vehicleid][17] = componentid;
	 		}
	 	}
 	return 1;
}

public OnVehiclePaintjob(vehicleid, paintjobid)
{
	new driver;
	for (new u;u<MAX_PLAYERS;u++)
		{
		if(GetPlayerVehicleID(u)==vehicleid && GetPlayerState(u) == PLAYER_STATE_DRIVER) driver=u;
		}
	if(gOwner[vehicleid]==driver)
		{
		Component[vehicleid][16] = paintjobid;
		}
	return 1;
}

public OnVehicleRespray(vehicleid, color1, color2)
{
	new driver;
	for (new u;u<MAX_PLAYERS;u++)
		{
		if(GetPlayerVehicleID(u)==vehicleid && GetPlayerState(u) == PLAYER_STATE_DRIVER) driver=u;
		}
	if(gOwner[vehicleid]==driver)
		{
		Component[vehicleid][18] = color1;
		Component[vehicleid][19] = color2;
		}
	return 1;
}

public CarModsSaving()
{
	new tmp[256], File:carmods;
	if (fexist("carmodsold")) fremove("carmodsold");
	fcopytextfile("carmods","carmodsold");
	if (fexist("carmods")) fremove("carmods");
	carmods=fopen("carmods",io_write);
	print("Doing now saving of the car modifications file, please wait...");
	for(new i;i<700;i++)
		{
		for(new p;p<20;p++)
			{
			format(tmp,256,"%d_%d=%d\r\n",i,p,Component[i][p]);
			fwrite(carmods,tmp);
			//dini_IntSet("carmods",tmp,Component[i][p]);
			}
		}
	fclose(carmods);
}

public CarOwnUpdate()
{
	new h,m,s,str[128],str2[128],str3[128];
	gettime(h,m,s);
	if(h==17 && !TodayCheck)
		{
		TodayCheck = 1;
		for(new i;i<700;i++)
			{
			format(str,128,"car%d_",i);
			if(TodayGotIn[i])
				{
				dini_IntSet("car_ownerships",str,0);
				}
			else if(gOwner[i])
				{
				dini_IntSet("car_ownerships",str,dini_Int("car_ownerships",str)+1);
				}
			if(dini_Int("car_ownerships",str)==20)
				{
				format(str2,128,"car%d",i);
				format(str3,128,"%d",dini_Int("car_carownerships",str2));
				dUserSetINT(dini_Get("players",str3)).("money",dUserINT(dini_Get("players",str3)).("money")+(CarPrice[GetVehicleModel(i)]/4*3));
				dini_IntSet("car_ownerships",str,0);
				dini_IntSet("car_ownerships",str2,0);
				}
			}
		}
	else if(h==18)
		{
		TodayCheck=0;
		}
}

public BugFix(playerid)
{
	new Float:posx,Float:posy,Float:posz;
	GetPlayerPos(playerid,posx,posy,posz);
	if(gCurrentGamePhase[playerid])	
		{
		if ((posx > 2004.8073 && posx < 2031.9639
		&& posy > -4479.4429 && posy < -4468.1470)
		|| (posx > -2.0 && posx < 2.0 && posy > -2.0 && posy < 2.0))
			{
			SetPlayerPos(playerid,2695.7629,-1704.9043,11.8438);
			SendClientMessage(playerid,COLOR_YELLOW,"[INFO] Your last saved position was wrong saved, teleporting you to city");
			}
		}
}

public CasinoKick()
{
	for(new playerid;playerid<MAX_PLAYERS;playerid++)
		{
		if(IsPlayerConnected(playerid))
			{
			GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
		    if(Pos[playerid][0] >   2003.7827 && Pos[playerid][0] <  2019.0720	// xmin, xmax
		    && Pos[playerid][1] > 1003.2322 && Pos[playerid][1] < 1029.7911	// ymin, ymax
		    && Pos[playerid][2] > 994.0000 && Pos[playerid][2] <  997.0000)	// zmin, zmax
		    	{
			    SetPlayerPos(playerid,2026.2491,1007.8365,10.8203);
			    SetPlayerInterior(playerid,0);
			    SendClientMessage(playerid,COLOR_RED,"[WARNING] Gambling is illegal in Compton City");
			    }
		    else if(Pos[playerid][0] >   2224.7336 && Pos[playerid][0] <  2247.0386	// xmin, xmax
		    && Pos[playerid][1] > 1699.9551 && Pos[playerid][1] < 1714.0481	// ymin, ymax
		    && Pos[playerid][2] > 1008.0000 && Pos[playerid][2] <  1013.0000)	// zmin, zmax
			    {
			    SetPlayerPos(playerid,2188.6997,1677.7418,11.1155);
			    SetPlayerInterior(playerid,0);
			    SendClientMessage(playerid,COLOR_RED,"[WARNING] Gambling is illegal in Compton City");
			    }
		    else if(Pos[playerid][0] >   1127.4159 && Pos[playerid][0] < 1142.5026	 // xmin, xmax
		    && Pos[playerid][1] > -11.2526 && Pos[playerid][1] < -6.6688	// ymin, ymax
		    && Pos[playerid][2] > 1000.0000 && Pos[playerid][2] <  1001.0000)	// zmin, zmax
		    	{
		    	SetPlayerPos(playerid,1659.6035,2254.3589,10.8203);
		    	SetPlayerInterior(playerid,0);
		    	SendClientMessage(playerid,COLOR_RED,"[WARNING] Gambling is illegal in Compton City");
		    	}
		    }
		}
}

public GivePlayerMoneyEx(playerid,money,reason[])
{
	GivePlayerMoney(playerid,money);
	printf("[cash] To %d for %s: $%d",playerid,reason,money);
	CashGiven[playerid]=1;
}

public MoneyUpdate()
{
	for(new i;i<MAX_PLAYERS;i++)
		{
		if(IsPlayerConnected(i) && CheckOk[i])
			{
			if(CashGiven[i]==0)
				{			
				if(OldCash[i] != GetPlayerMoney(i))
					{
					if(GetPlayerMoney(i) > OldCash[i])
						{
						if(GetPlayerMoney(i)-OldCash[i] >= 3000)
							{
							new string[256];
							format(string,256,"[WARNING] Possible money cheating, money of %s (id:%d) went from %d to %d",PlayerName(i),i,OldCash[i], GetPlayerMoney(i));
							print(string);
							for(new p;p<MAX_PLAYERS;p++) if(IsPlayerAdmin(p)) SendClientMessage(p,COLOR_RED,string);
							}
						}
					}
				}
			OldCash[i] = GetPlayerMoney(i);
			CashGiven[i] = 0;
			}
		}
}

public StartCheckingMoney(playerid)
{
	OldCash[playerid] = GetPlayerMoney(playerid);
	CheckOk[playerid] = 1;
}
