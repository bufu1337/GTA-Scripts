#include <a_samp>
#include <string>
#include <core>
#include <float>
#include <uf>

#define GREEN 0x00FF00AA // Bright Green

main()
{
	print("\n----------------------------------");
	print(" Ultimate Stealthmatch");
	print("----------------------------------\n");
}

#define TEAM_GROVE_COLOR 0x00FF00AA // Bright Green
#define TEAM_BALLA_COLOR 0xFF00FFAA// Bright Purple
#define TEAM_GROVE 1
#define TEAM_BALLA 2
// code stolen from ProtectPM

#define NUM_SPAWNS 512
#define NUM_PICKUPS 1024
#define NUM_OBJS 256

//#define PICKUP_BRASS_KNUCKLES 331
#define PICKUP_GOLFCLUB 333
#define PICKUP_NITESTICK 334
#define PICKUP_KNIFE 335
#define PICKUP_BAT 336
#define PICKUP_SHOVEL 337
#define PICKUP_POOLSTICK 338
#define PICKUP_KATANA 339
#define PICKUP_CHAINSAW 341
#define PICKUP_DILDO 321
#define PICKUP_DILDO2 322
#define PICKUP_VIBRATOR1 323
#define PICKUP_VIBRATOR2 324
#define PICKUP_FLOWER 325
#define PICKUP_CANE 326
#define PICKUP_GRENADE 342
//#define PICKUP_TEARGAS 343
//#define PICKUP_MOLTOV 344
//#define PICKUP_MISSILE 345
#define PICKUP_COLT45 346
#define PICKUP_SILENCED 347
#define PICKUP_DEAGLE 348
#define PICKUP_SHOTGUN 349
#define PICKUP_SAWEDOFF 350
#define PICKUP_SHOTGSPA 351
#define PICKUP_UZI 352
#define PICKUP_MP5 353
//#define PICKUP_HYDRAFLARE 354
#define PICKUP_AK47 355
#define PICKUP_TEC9 372
//#define PICKUP_RIFLE 357
//#define PICKUP_SNIPER 358
//#define PICKUP_ROCKETLAUNCHER 359
//#define PICKUP_HEATSEEKER 360
#define PICKUP_FLAMETHROWER 361
#define PICKUP_MINIGUN 362
//#define PICKUP_SACHEL 363
//#define PICKUP_BOMB 364  // actually the detonator
#define PICKUP_SPRAYCAN 365
#define PICKUP_FIREEXTINGUISHER 366
//#define PICKUP_CAMERA 367
//#define PICKUP_NIGHTVISION_GOGGLES 368
//#define PICKUP_THERMAL_GOGGLES 369
#define PICKUP_M4 356

new AlreadyRun = 0;

#define MAX_WEAPONS 7
new weaponNames[MAX_WEAPONS][32] = {
	"Shotgun",
	"Combat Shotgun",
	"Micro Uzi",
	"Tec9",
	"MP5",
	"AK47",
	"M4"
};
new weaponIDs[MAX_WEAPONS] = {
	25,     //Shotgun
	27,     //Combat shotgun
	28,     //Micro Uzi
	32,     //Tec9
	29,     //MP5
	30,     //AK47
	31      //M4
};
new weaponCost[MAX_WEAPONS] = {
	7000,
	15000,
	7000,
	5000,
	15000,
	25000,
	30000
};
new weaponAmmo[MAX_WEAPONS] = {
	15,
	20,
	120,
	120,
	120,
	120,
	120
};
new playerWeapons[MAX_PLAYERS][MAX_WEAPONS];
new bounty[MAX_PLAYERS];
new savePos;

forward Givecashdelaytimer(playerid);

#define GIVECASH_DELAY 5000 // Time in ms between /givecash commands.
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_ORANGE 0xFF9900AA

#define MAX_SAVE 64
new savedInfo[MAX_SAVE][4];
new savedNames[MAX_SAVE][MAX_PLAYER_NAME];
new savedWeapons[MAX_SAVE][MAX_WEAPONS];

#define PICKUP_PARACHUTE 371
#define PICKUP_ARMOR 1242
#define PICKUP_JETPACK 370

#define SOUND_PICKUP_STANDARD 1150
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
#define NUM_V_MODELIDS 212

new worldTime;
//forward GameModeExitFunc();
//Round code stolen from mike's Manhunt :P
//new gRoundTime = 1200000;                   // Round time - 1 hour
//new gWarningTimer = 900000;

public TimeUpdate() {
	worldTime++;
	worldTime%=24;
	SetWorldTime(worldTime);
	return 1;
}

/*public WarningTime()
{
GameTextForAll("Game ends in 5 minutes", 3000, 1);
}
*/

public SetPlayerToTeamColor(playerid)
{
	if(GetPlayerTeam(playerid) == TEAM_GROVE) {
		SetPlayerColor(playerid,TEAM_GROVE_COLOR);// green
	} else if(GetPlayerTeam(playerid) == TEAM_BALLA) {
	    SetPlayerColor(playerid,TEAM_BALLA_COLOR); // purple
	}
}

public OnPlayerRequestClass(playerid, classid)
{
PlayerPlaySound(playerid, 1139,0.0,0.0,0.0);
SetupPlayerForClassSelection(playerid);
	return 1;
}

public SetupPlayerForClassSelection(playerid)
{
 	SetPlayerInterior(playerid,14);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerFacingAngle(playerid, 270.0);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1004.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
}

public SetPlayerTeamFromClass(playerid,classid)
{
	if(classid == 0 || classid == 1 || classid == 2 || classid == 3) {
		SetPlayerTeam(playerid,TEAM_GROVE);
	} else if(classid == 4 || classid == 5 || classid == 6) {
	    SetPlayerTeam(playerid,TEAM_BALLA);
	}
}
public 	CarCol() {
	random(126);
	return 1;
}

public OnGameModeInit(playerid)
{
	print("GameModeInit()");
	SetGameModeText("Ultimate Stealthmatch");
	ShowNameTags(1);
	ShowPlayerMarkers(1);
	//SetPlayerColor(playerid, 0xFFFFFF10);
	AddStaticPickup(1239,2,2458.6453,-1714.4154,13.5633); // hidden command blip
	AddStaticPickup(1239,2,2325.7837,-1677.4486,14.4219); // hidden command codes
	AddPlayerClass(105,2520.9875,-1678.7144,15.2527,78.0648,32,200,30,200,4,0); // grove big smoke
	AddPlayerClass(106,2513.5461,-1651.1879,14.0938,120.0284,32,200,30,200,4,0); // grove sweet
	AddPlayerClass(107,2513.6584,-1689.8826,13.5498,57.0711,32,200,30,200,4,0); // grove ryder
	AddPlayerClass(195,2498.8945,-1643.0519,13.7826,168.3056,32,200,30,200,4,0); // grove denise
	AddPlayerClass(104,2070.0918,-1627.9880,13.8762,268.6828,28,200,27,25,4,0); // balla 1
	AddPlayerClass(103,2068.8149,-1644.0627,13.5469,259.2828,28,200,27,25,4,0); // balla 2
	AddPlayerClass(102,2068.1218,-1655.8743,13.5469,255.1860,28,200,27,25,4,0); // balla 3
	AddStaticVehicle(541,2476.7012,-1655.1669,12.9508,89.5479,60,1); // bullet grove
	AddStaticVehicle(541,2482.4902,-1655.2317,12.9421,89.9446,60,1); // bullet 2 grove
	AddStaticVehicle(541,2489.5950,-1655.1803,12.9783,90.1191,60,1); // bullet 3 grove
	AddStaticVehicle(541,2085.5320,-1664.7617,13.0153,180.5862,60,1); // bullet balla
	AddStaticVehicle(541,2085.4714,-1658.8921,13.0154,180.5861,60,1); // bullet 2 balla
	AddStaticVehicle(541,2085.4089,-1652.7371,13.0156,180.5848,60,1); // bullet 3 balla
	AddStaticPickup(PICKUP_FLAMETHROWER,2,2440.0728,-1691.0099,13.8047); // grove flamethrower
	AddStaticPickup(PICKUP_TEC9,2,2451.9976,-1642.3373,13.7357); // grove tec9
	AddStaticPickup(PICKUP_AK47,2,2478.0325,-1639.8687,13.4363); // grove ak47
	AddStaticPickup(PICKUP_MP5,2,2536.9895,-1654.7944,14.7837); // grove mp5
	AddStaticPickup(PICKUP_M4,2,2504.6990,-1711.8151,13.5398); // m4
	AddStaticPickup(PICKUP_UZI,2,2482.2786,-1749.1731,13.5469); // uzi
	AddStaticPickup(PICKUP_SHOTGSPA,2,2403.6301,-1646.8850,13.5469); // shotgunspa
	AddStaticPickup(PICKUP_TEC9,2,2361.5479,-1674.3389,13.5456); // tec9
	AddStaticPickup(PICKUP_AK47,2,2271.1531,-1632.5820,15.3135); // ak47
	AddStaticPickup(PICKUP_MP5,2,2236.2771,-1639.3197,15.5633); // mp5
	AddStaticPickup(PICKUP_FLAMETHROWER,2,2163.3274,-1619.8458,14.1920); // flamethrower
	AddStaticPickup(PICKUP_GRENADE,2,2109.7754,-1629.8270,13.5006); // grenades
	AddStaticPickup(PICKUP_UZI,2,2091.7400,-1592.4059,13.3267); // balla uzi
	AddStaticPickup(PICKUP_TEC9,2,2070.2861,-1596.3552,13.5018); // balla tec9
	AddStaticPickup(PICKUP_SHOTGSPA,2,2060.3579,-1636.0741,13.5469); // balla shotgunspa
	AddStaticPickup(PICKUP_M4,2,2071.9595,-1669.8800,13.3906); // balla m4
	AddStaticPickup(PICKUP_MP5,2,2099.6738,-1658.2386,13.8841); // balla mp5
	AddStaticPickup(PICKUP_KNIFE,2,2066.7942,-1702.1581,14.1484); // balla knife
	AddStaticPickup(PICKUP_KNIFE,2,2494.9456,-1686.5861,13.5137); // grove knife
	AddStaticPickup(PICKUP_KATANA,2,2484.7649,-1638.1216,25.1094); // grove katana
	AddStaticPickup(PICKUP_KATANA,2,2123.1658,-1602.6578,14.0299); // balla katana
// AddStaticVehicle(520,2487.3318,-1670.8682,13.3359,9.5149,60,1); // hydra grove
	AddStaticVehicle(V_HYDRA,1967,-2637.3569,14.1309,359.9997,43,0); // hydra west
	AddStaticVehicle(V_HYDRA,1977,-2637.3569,14.1309,359.9997,43,0); // hydra east
	AddStaticVehicle2(V_STRETCH,1272.0273,-2052.5105,58.9108,268.6577,1,1); // pm limo
	AddStaticVehicle2(V_ENFORCER,1248.0804,-2041.6018,59.8980,269.1785,0,1); // pm swat van south
	AddStaticVehicle2(V_ENFORCER,1248.4545,-2029.4104,59.8854,269.3774,0,1); // pm swat van middle
	AddStaticVehicle2(V_SUPERGT,1528.4613,-811.7554,71.8663,89.1012,CarCol(),CarCol()); // posh 4
	AddStaticVehicle2(V_CHEETAH,1025.5624,-800.0936,101.8734,20.1116,CarCol(),CarCol()); // posh
	AddStaticVehicle2(V_ZR350,920.5785,-786.9205,114.3464,68.2807,CarCol(),CarCol()); // posh
	AddStaticVehicle2(V_BULLET,855.9669,-815.3113,87.7593,19.6388,CarCol(),CarCol()); // posh
	AddStaticVehicle2(V_BULLET,684.5640,-1074.3420,49.5645,60.4335,CarCol(),CarCol()); // posh
	AddStaticVehicle2(V_CHEETAH,404.5968,-1155.5228,77.6275,143.8123,CarCol(),CarCol()); // posh
	AddStaticVehicle2(V_BULLET,289.7317,-1167.9216,80.9028,220.8520,CarCol(),CarCol()); // very posh
	AddStaticVehicle2(V_BULLET,292.9161,-1162.0803,80.9022,220.1603,CarCol(),CarCol()); // very posh
	AddStaticVehicle2(V_SUPERGT,288.0584,-1327.9247,53.5295,218.3855,CarCol(),CarCol()); // posh
	AddStaticVehicle2(V_BULLET,1241.8268,-749.5003,94.2435,18.4917,CarCol(),CarCol()); //
	AddStaticVehicle2(V_CHEETAH,872.4854,-872.3334,77.2855,200.1391,CarCol(),CarCol()); // posh
	AddStaticVehicle2(V_ZR350,833.5978,-926.3884,54.9567,246.7931,CarCol(),CarCol()); // posh
	AddStaticVehicle2(V_ZR350,842.0680,-896.1290,68.4778,232.5096,CarCol(),CarCol()); // posh
	AddStaticVehicle2(V_SUPERGT,1086.8040,-637.7476,112.9547,5.5657,CarCol(),CarCol()); // posh
	AddStaticVehicle2(V_HUNTLEY,1528.2061,-800.0825,73.0617,90.4437,CarCol(),CarCol()); // posh 4b (V_RANCHER)
	AddStaticVehicle2(V_NRG500,1018.2570,-777.7994,102.6511,90.7938,CarCol(),CarCol()); // posh bike		AddStaticVehicle2(V_HUNTLEY,848.0241,-818.4172,87.0807,22.0264,CarCol(),CarCol()); // posh rancher
	AddStaticVehicle2(V_NRG500,718.9101,-1001.8113,52.4130,148.8447,CarCol(),CarCol()); // posh bike
	AddStaticVehicle2(V_NRG500,278.7959,-1257.6844,73.9157,215.0338,CarCol(),CarCol()); // posh bike
	AddStaticVehicle2(V_PCJ600,337.6167,-1308.5352,54.2161,209.8673,CarCol(),CarCol()); // sanchez
	AddStaticVehicle2(V_PCJ600,346.4070,-1300.6411,54.2168,206.8296,CarCol(),CarCol()); // sanchez
	AddStaticVehicle2(V_PATRIOT,914.0649,-665.7319,116.7606,241.1865,CarCol(),CarCol()); // patriot
	AddStaticVehicle2(V_MONSTERA,946.1701,-705.2098,121.9152,29.1216,CarCol(),CarCol()); // bandito
	AddStaticVehicle2(V_HUNTLEY,940.8948,-695.8306,121.1879,29.9158,CarCol(),CarCol()); // sand king
	AddStaticVehicle2(V_HUNTLEY,1097.4353,-642.2601,112.5732,267.1823,CarCol(),CarCol()); // huntley
	AddStaticVehicle2(V_RANCHER,1413.9097,-481.3066,42.9720,297.0425,CarCol(),CarCol()); // rancher
	AddStaticVehicle2(V_COMET,1659.2822,-1426.8878,13.3985,88.7621,CarCol(),CarCol()); // com		AddStaticVehicle2(V_BANSHEE,1590.5114,-1317.7780,17.2589,49.2585,CarCol(),CarCol()); // com
	AddStaticVehicle2(V_STALLION,1809.2898,-1430.6573,13.1695,184.9688,CarCol(),CarCol()); // com
	AddStaticVehicle2(V_WINDSOR,1725.2581,-1217.3599,19.0807,2.3763,CarCol(),CarCol()); // com
	AddStaticVehicle2(V_COMET,1531.0547,-1066.9626,24.7978,90.4579,CarCol(),CarCol()); // com
	AddStaticVehicle2(V_ZR350,1451.6792,-1146.7477,23.7968,133.4617,CarCol(),CarCol()); // com
	AddStaticVehicle2(V_STALLION,1328.1886,-1188.7338,23.3185,176.1219,CarCol(),CarCol()); // com
	AddStaticVehicle2(V_WINDSOR,1252.2759,-1430.6191,13.2775,183.7629,CarCol(),CarCol()); // com
	AddStaticVehicle2(V_COMET,1357.4553,-1570.0588,13.2831,163.9771,CarCol(),CarCol()); // com
	AddStaticVehicle2(V_BANSHEE,1677.5549,-1680.1785,13.2813,182.6165,CarCol(),CarCol()); // com
	AddStaticVehicle2(V_STALLION,1462.1278,-1356.1224,13.6903,0.6286,CarCol(),CarCol()); // com
	AddStaticVehicle2(V_SOLAIR,1012.5267,-1346.8806,13.4797,267.5486,41,41); // suv
	AddStaticVehicle2(V_REGINA,1117.3052,-1378.9901,14.4011,89.1945,41,41); // suv
	AddStaticVehicle2(V_NRG500,1132.5653,-1614.6372,13.9194,85.6389,41,41); // fast bike in shopping centre
	AddStaticVehicle2(V_WINDSOR,1160.2629,-1770.1327,16.7116,359.6430,41,41); // com
	AddStaticVehicle2(V_BANSHEE,1284.9130,-1732.6017,13.6673,0.8082,41,41); // com
	AddStaticVehicle2(V_REGINA,974.6439,-1089.6545,24.2836,177.6930,CarCol(),CarCol()); // suv
	AddStaticVehicle2(V_MERIT,649.7829,-1620.6465,15.2105,112.6496,CarCol(),CarCol()); // saloon
	AddStaticVehicle2(V_NRG500,682.0504,-1259.6924,13.7628,106.4779,CarCol(),CarCol()); // bikefast
	AddStaticVehicle2(V_WAYFARER,2175.6335,-993.5605,63.1809,169.8002,CarCol(),CarCol()); // V_WAYFARER
	AddStaticVehicle2(V_RANCHER,2453.6128,-1016.0901,59.8982,177.5543,CarCol(),CarCol()); // rancher
	AddStaticVehicle2(V_WASHING,2536.1904,-1104.8235,59.8875,180.5492,CarCol(),CarCol()); // saloon
	AddStaticVehicle2(V_BLADE,2328.6465,-1407.3834,24.1766,178.8325,CarCol(),CarCol()); // low
	AddStaticVehicle2(V_MONSTERA,2492.1194,-1663.3529,13.5302,82.4906,CarCol(),CarCol()); // monster
	AddStaticVehicle2(V_GLENSHIT,2066.3311,-1694.5254,13.7310,268.5239,CarCol(),CarCol()); // V_GLENSHIT
	AddStaticVehicle2(V_CEMENT,2054.1970,-1767.7522,13.7393,181.0835,CarCol(),CarCol()); // cement
	AddStaticVehicle2(V_FLATBED,1939.3959,-1815.7340,13.7385,77.9876,CarCol(),CarCol()); // flatbed
	AddStaticVehicle2(V_TOWTRUCK,1937.9028,-1939.7325,13.7375,89.1628,CarCol(),CarCol()); // towtruck
	AddStaticVehicle2(V_PCJ600,1941.1481,-2140.8420,13.7440,175.4044,CarCol(),CarCol()); // V_PCJ600
	AddStaticVehicle2(V_SWEEPER,2125.8816,-2165.4050,13.7341,320.7342,CarCol(),CarCol()); // sweeper
	AddStaticVehicle2(V_PATRIOT,2076.9661,-1994.8885,13.7389,41.9139,CarCol(),CarCol()); // patriot
	AddStaticVehicle2(V_GLENSHIT,1502.1649,-2212.7788,13.3136,359.6183,CarCol(),CarCol()); // saloon
	AddStaticVehicle2(V_STRATUM,1407.0730,-2261.8484,13.3164,180.3750,CarCol(),CarCol()); // suv
	AddStaticVehicle2(V_BANSHEE,1365.5696,-2365.7705,13.3159,90.6723,CarCol(),CarCol()); // com
	AddStaticVehicle2(V_BENSON,1789.8521,-2180.6389,13.3187,270.2510,CarCol(),CarCol()); // van
	AddStaticVehicle2(V_WASHING,1922.5924,-1605.3048,13.1082,269.9615,118,118); // saloon
	AddStaticVehicle2(V_WAYFARER,2070.1260,-1591.6121,13.0664,182.2131,118,118); // V_WAYFARER
	AddStaticVehicle2(V_MERIT,2705.9854,-1844.6924,9.8701,340.3920,CarCol(),CarCol()); // saloon
	AddStaticVehicle2(V_SOLAIR,2813.2185,-1671.5564,10.3166,2.8114,CarCol(),CarCol()); // suv
	AddStaticVehicle2(V_SAVANNA,2644.6707,-2023.4589,13.9219,1.6210,CarCol(),CarCol()); // low
	AddStaticVehicle2(V_CEMENT,2743.6338,-2138.0737,11.5750,94.0439,CarCol(),CarCol()); // cement
	AddStaticVehicle2(V_FLATBED,2300.8748,-2043.2729,13.9219,93.1316,CarCol(),CarCol()); // flatbed
	AddStaticVehicle2(V_ELEGY,2241.5413,-2111.0176,13.9195,134.0082,CarCol(),CarCol()); // saloon
	AddStaticVehicle2(V_NRG500,2228.4226,-1811.8547,13.8943,269.9799,CarCol(),CarCol()); // V_NRG500
	AddStaticVehicle2(V_BLADE,2505.4697,-1235.4440,37.6099,356.9889,CarCol(),CarCol()); // lowr
	AddStaticVehicle2(V_BURRITO,2587.6326,-1322.8219,40.4727,91.7934,CarCol(),CarCol()); // smallvan
	AddStaticVehicle2(V_PCJ600,2527.5496,-1465.3361,24.3251,86.3631,CarCol(),CarCol()); // slowbike
	AddStaticVehicle2(V_MERIT,2698.6609,-1191.8911,69.7986,270.9197,CarCol(),CarCol()); // saloon
	AddStaticVehicle2(V_RANCHER,2706.4719,-1274.8931,58.4590,135.3378,CarCol(),CarCol()); // rancher
	AddStaticVehicle2(V_BANSHEE,894.8080,-1518.4893,12.8387,9.3645,CarCol(),CarCol()); // com
	AddStaticVehicle2(V_RANCHER,1725.1200,-405.3828,45.0947,196.5883,CarCol(),CarCol()); // offroad
	AddStaticVehicle2(V_RANCHER,1970.6564,-813.4561,129.1876,281.6888,CarCol(),CarCol()); // rancher
	AddStaticVehicle2(V_RANCHER,2431.9832,-773.8238,113.2601,296.2740,CarCol(),CarCol()); // rancher
	AddStaticVehicle2(V_RANCHER,2662.3218,-438.5351,59.7808,318.4588,CarCol(),CarCol()); // rancher
	AddStaticVehicle(451,2040.0520,1319.2799,10.3779,183.2439,16,16);
	AddStaticVehicle(429,2040.5247,1359.2783,10.3516,177.1306,13,13);
	AddStaticVehicle(421,2110.4102,1398.3672,10.7552,359.5964,13,13);
	AddStaticVehicle(411,2074.9624,1479.2120,10.3990,359.6861,64,64);
	AddStaticVehicle(477,2075.6038,1666.9750,10.4252,359.7507,94,94);
	AddStaticVehicle(541,2119.5845,1938.5969,10.2967,181.9064,22,22);
	AddStaticVehicle(541,1843.7881,1216.0122,10.4556,270.8793,60,1);
	AddStaticVehicle(402,1944.1003,1344.7717,8.9411,0.8168,30,30);
	AddStaticVehicle(402,1679.2278,1316.6287,10.6520,180.4150,90,90);
	AddStaticVehicle(415,1685.4872,1751.9667,10.5990,268.1183,25,1);
	AddStaticVehicle(411,2034.5016,1912.5874,11.9048,0.2909,123,1);
	AddStaticVehicle(411,2172.1682,1988.8643,10.5474,89.9151,116,1);
	AddStaticVehicle(429,2245.5759,2042.4166,10.5000,270.7350,14,14);
	AddStaticVehicle(477,2361.1538,1993.9761,10.4260,178.3929,101,1);
	AddStaticVehicle(550,2221.9946,1998.7787,9.6815,92.6188,53,53);
	AddStaticVehicle(558,2243.3833,1952.4221,14.9761,359.4796,116,1);
	AddStaticVehicle(587,2276.7085,1938.7263,31.5046,359.2321,40,1);
	AddStaticVehicle(587,2602.7769,1853.0667,10.5468,91.4813,43,1);
	AddStaticVehicle(603,2610.7600,1694.2588,10.6585,89.3303,69,1);
	AddStaticVehicle(587,2635.2419,1075.7726,10.5472,89.9571,53,1);
	AddStaticVehicle(562,2577.2354,1038.8063,10.4777,181.7069,35,1);
	AddStaticVehicle(562,2394.1021,989.4888,10.4806,89.5080,17,1);
	AddStaticVehicle(562,1881.0510,957.2120,10.4789,270.4388,11,1);
	AddStaticVehicle(535,2039.1257,1545.0879,10.3481,359.6690,123,1);
	AddStaticVehicle(535,2009.8782,2411.7524,10.5828,178.9618,66,1);
	AddStaticVehicle(429,2010.0841,2489.5510,10.5003,268.7720,1,2);
	AddStaticVehicle(415,2076.4033,2468.7947,10.5923,359.9186,36,1);
	AddStaticVehicle(476,1283.6847,1386.5137,11.5300,272.1003,89,91);
	AddStaticVehicle(476,1288.0499,1403.6605,11.5295,243.5028,119,117);
	AddStaticVehicle(415,1319.1038,1279.1791,10.5931,0.9661,62,1);
	AddStaticVehicle(521,1710.5763,1805.9275,10.3911,176.5028,92,3);
	AddStaticVehicle(521,2805.1650,2027.0028,10.3920,357.5978,92,3);
	AddStaticVehicle(535,2822.3628,2240.3594,10.5812,89.7540,123,1);
	AddStaticVehicle(521,2876.8013,2326.8418,10.3914,267.8946,115,118);
	AddStaticVehicle(429,2842.0554,2637.0105,10.5000,182.2949,1,3);
	AddStaticVehicle(549,2494.4214,2813.9348,10.5172,316.9462,72,39);
	AddStaticVehicle(560,2361.8042,2210.9951,10.3848,178.7366,37,0); //
	AddStaticVehicle(560,-1993.2465,241.5329,34.8774,310.0117,41,29); //
	AddStaticVehicle(559,-1989.3235,270.1447,34.8321,88.6822,58,8); //
	AddStaticVehicle(559,-1946.2416,273.2482,35.1302,126.4200,60,1); //
	AddStaticVehicle(558,-1956.8257,271.4941,35.0984,71.7499,24,1); //
	AddStaticVehicle(562,-1952.8894,258.8604,40.7082,51.7172,17,1); //
	AddStaticVehicle(411,-1949.8689,266.5759,40.7776,216.4882,112,1); //
	AddStaticVehicle(429,-1988.0347,305.4242,34.8553,87.0725,2,1); //
	AddStaticVehicle(559,-1657.6660,1213.6195,6.9062,282.6953,13,8); //
	AddStaticPickup(342,2,2533.4529,-1677.8137,19.9302); // grenade
	AddStaticPickup(1240,2,2079.4646,-1622.4568,13.3828); // health balla
	AddStaticPickup(1242,2,2084.8374,-1622.1001,13.3806); // armor balla
	AddStaticPickup(1240,2,2466.4700,-1655.8124,13.2919); // health grove
	AddStaticPickup(1242,2,2466.8259,-1662.5996,13.2845); // armor grove
	AddStaticPickup(362,2,-347.2831,1600.8020,165.7395); // Minigun
	SetTimer("TimeUpdate",60009, 1);
	//SetTimer("GameModeExitFunc", gRoundTime, 0);
	SetTimer("Info", 1000, 1);

	return 1;
}

/*
AddStaticVehicle2(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2, safehouse_excluded = 0)
{
	if (vehicle_counter>MAX_VEHICLES) {
		printf("Too many vehicle spawns, ignoring vehicle %d,%f,%f,%f,%f,%d,%d!",modelid,spawn_x,spawn_y,spawn_z,z_angle,color1,color2);
		return 0;
	}
	vehicle_modelid[vehicle_counter] = modelid;
	vehicle_spawn_x[vehicle_counter] = spawn_x;
	vehicle_spawn_y[vehicle_counter] = spawn_y;
	vehicle_spawn_z[vehicle_counter] = spawn_z;
	vehicle_z_angle[vehicle_counter] = z_angle;
	vehicle_colour1[vehicle_counter] = color1;
	vehicle_colour2[vehicle_counter] = color2;
	vehicle_safehouse_excluded[vehicle_counter] = safehouse_excluded;
	AddStaticVehicle(modelid, spawn_x, spawn_y, spawn_z, z_angle, color1, color2);
	// return vehicle_counter++ doesn't work -- suspect compiler bug
	new retval = vehicle_counter++;
	return retval;
}
*/
public OnGameModeExit()
{
	print("GameModeExit()");
	return 1;
}

public TimeTillReset(playerid)
{
	AlreadyRun = 0;
	SetPlayerCheckpoint(playerid,2485.3213,-1618.4302,16.4050,4); // checkpoint rampage
	return 1;
}

public OnPlayerConnect(playerid)
{
	printf("OnPlayerConnect(%d)", playerid);
		SendClientMessage(playerid, GREEN, "You can use stealth with the command /stealth and /nostealth.");
		SendClientMessage(playerid, GREEN, "Type /help for more help.");
		
		new playrname[MAX_PLAYER_NAME];
		
		GetPlayerName(playerid, playrname, sizeof(playrname));
	for(new i = 0; i < MAX_SAVE; i++) {

	    if(isStringSame(savedNames[i], playrname, MAX_PLAYER_NAME)) {
			bounty[playerid] = savedInfo[i][2];

			savedInfo[i][0]=savedInfo[i][1]=savedInfo[i][2]=0;
			savedNames[i][0]=0;

			for(new j = 0; j < MAX_WEAPONS; j++) {
				playerWeapons[playerid][j]=savedWeapons[i][j];
				savedWeapons[i][j]=0;
				GivePlayerWeapon(playerid,savedWeapons[i][j],200);
			}

			SendClientMessage(playerid, COLOR_GREEN, "Your stats have been restored.");
		}
	}
	return 1;
}

public OnPlayerDisconnect(playerid)
{
	printf("OnPlayerDisconnect(%d)", playerid);
	new playername[MAX_PLAYER_NAME];
 	//Save temp info for timeouts/crashes
	GetPlayerName(playerid, playername, sizeof(playername));
	format(savedNames[savePos], MAX_PLAYER_NAME, "%s",playername);

	//savedInfo[savePos][0] = GetPlayerMoney(playerid);
//	savedInfo[savePos][1] = bank[playerid];
	savedInfo[savePos][2] = bounty[playerid];
	savedInfo[savePos][3] = 0;

	for(new i = 0; i < MAX_WEAPONS; i++)
		savedWeapons[savePos][i]=playerWeapons[playerid][i];
	//
	savePos++;
	if(savePos >= MAX_SAVE)
	    savePos = 0;
	bounty[playerid] = 0;

	for(new i = 0; i < MAX_WEAPONS;i++) {
		playerWeapons[playerid][i]=0;
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	printf("OnPlayerSpawn(%d)", playerid);
	GivePlayerMoney(playerid,GetPlayerMoney(playerid)+1000);
	SetPlayerInterior(playerid,0);
	//SetPlayerWorldBounds(playerid,2938.8640,1703.6963,-1430.8320,-1921.0360); // not sure whether I will use this one yet.
    SetPlayerCheckpoint(playerid,2485.3213,-1618.4302,16.4050,4); // checkpoint rampage
	return 1;
}
/*
public OnPlayerDeath(playerid, killerid, reason)
{
	printf("OnPlayerDeath(%d, %d, %d)", playerid, killerid, reason);
	new playercash;
	SendDeathMessage(killerid,playerid,reason);
	ResetPlayerMoney(playerid);
	ResetPlayerWeapons(playerid);
	SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
	playercash = GetPlayerMoney(playerid);
			if (playercash > 0)  {
				GivePlayerMoney(killerid, playercash);
				ResetPlayerMoney(playerid);
			}
				return 1;
}
*/
public OnPlayerDeath(playerid, killerid, reason)
{
	new name[MAX_PLAYER_NAME];
	new string[256];
	new deathreason[20];
	new playercash;
    SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
    SetPlayerScore(playerid,GetPlayerScore(playerid)-1);
	GetPlayerName(playerid, name, sizeof(name));
	GetWeaponName(reason, deathreason, 20);
	if (killerid == INVALID_PLAYER_ID) {
	    switch (reason) {
			case WEAPON_DROWN:
			{
				format(string, sizeof(string), "*** %s sleeps with the fishes.", name);

			}
			case WEAPON_FLAMETHROWER:
			{
				format(string, sizeof(string), "*** %s burned like a bitch.", name);
				SendClientMessage(playerid, COLOR_WHITE,"Hidden commands code: 101025");
			}
			case 54:
			{
				format(string, sizeof(string), "*** %s smashed his brains on the pavement.", name);
			}
			case 49:
			{
				format(string, sizeof(string), "*** %s is roadkill.", name);
			}
			default:
			{
			    if (strlen(deathreason) > 0) {
					format(string, sizeof(string), "*** %s died. (%s)", name, deathreason);
				} else {
				    format(string, sizeof(string), "*** %s died.", name);
				}
			}
		}
	}
	else {
	new killer[MAX_PLAYER_NAME];
	GetPlayerName(killerid, killer, sizeof(killer));
	if (strlen(deathreason) > 0) {
		format(string, sizeof(string), "*** %s fucked %s up wit a %s. ***", killer, name, deathreason);
		} else {
				format(string, sizeof(string), "*** %s beat the shit outta %s. ***", killer, name);
			}
		}
	SendClientMessageToAll(COLOR_RED, string);
		{
		playercash = GetPlayerMoney(playerid);
		if (playercash > 0)
		{
			GivePlayerMoney(killerid, playercash);
			ResetPlayerMoney(playerid);
		}
		else
		{
		}
	}
 	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	printf("OnVehicleSpawn(%d)", vehicleid);
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	printf("OnVehicleDeath(%d, %d)", vehicleid, killerid);
	return 1;
}

public OnPlayerText(playerid)
{
	printf("OnPlayerText(%d)", playerid);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[256];
	new playermoney;
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new cmd[256];
	new giveplayerid, moneys, idx, weaponid;

	cmd = strtok(cmdtext, idx);
	
        if (strcmp(cmdtext, "/help", true)==0)
    {
		SendClientMessage(playerid, COLOR_YELLOW, "COMMANDS: /stealth /nostealth /register /login /help /buyweapon");
		SendClientMessage(playerid, COLOR_YELLOW, "/hitman /bounty /bounties /weaponlist /givecash /cls /dive /grove /balla");
		SendClientMessage(playerid, COLOR_WHITE,"Hidden commands: /godmode /health /minigun /killall");
        return 1;
    }
            if (strcmp(cmdtext, "/hidden", true)==0)
    {
		SendClientMessage(playerid, COLOR_YELLOW,"Hidden commands code: 101025");
		return 1;
    }
    	if(strcmp(cmdtext, "/dive", true) == 0) {
    	new name[MAX_PLAYER_NAME];
    	new message[256];
		GetPlayerName(playerid, name, sizeof(name));
    	format(message, sizeof(message), "%s is taking a dive.", name);
    	SendClientMessageToAll(COLOR_WHITE, message);
				if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:X;
					new Float:Y;
					new Float:Z;
     				new VehicleID;
     				GetPlayerPos(playerid, X, Y, Z);
      				VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID, X, Y, Z + 800.00);
					GivePlayerWeapon(playerid,46,1);
				} else {
					new Float:X;
					new Float:Y;
					new Float:Z;
					GetPlayerPos(playerid, X, Y, Z);
					SetPlayerPos(playerid, X, Y, Z + 800.00);
					GivePlayerWeapon(playerid,46,1);
					GameTextForPlayer(playerid, "Don't Fall!",8000,5);
  				}
			return 1;
		}
		
    if (strcmp(cmdtext, "/cls", true)==0)
    {
    	wiper(playerid);
    	return 1;
    }
	//------------------- /givecash

	if(strcmp(cmd, "/givecash", true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givecash [playerid] [amount]");
			return 1;
		}
		giveplayerid = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givecash [playerid] [amount]");
			return 1;
		}
 		moneys = strval(tmp);

		//printf("givecash_command: %d %d",giveplayerid,moneys);


		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			playermoney = GetPlayerMoney(playerid);
			if (playermoney >= moneys) {
				GivePlayerMoney(playerid, (0 - moneys));
				GivePlayerMoney(giveplayerid, moneys);
				format(string, sizeof(string), "You have sent %s (id: %d), $%d.", giveplayer,giveplayerid, moneys);
				SendClientMessage(playerid, COLOR_YELLOW, string);
				format(string, sizeof(string), "You have recieved $%d from %s (id: %d).", moneys, sendername, playerid);
				SendClientMessage(giveplayerid, COLOR_YELLOW, string);
				printf("%s(playerid:%d) has transfered %d to %s(playerid:%d)",sendername, playerid, moneys, giveplayer, giveplayerid);
			}
			if (moneys < 0) {
				GivePlayerMoney(playerid, (0 - moneys));
				GivePlayerMoney(giveplayerid, moneys);
				format(string, sizeof(string), "You have stolen %d from $%s.",moneys, giveplayer);
				SendClientMessage(playerid, COLOR_YELLOW, string);
				format(string, sizeof(string), "You have been jacked $%d by %s (id: %d).", moneys, sendername, playerid);
				SendClientMessage(giveplayerid, COLOR_YELLOW, string);
				printf("%s(playerid:%d) has transfered %d to %s(playerid:%d)",sendername, playerid, moneys, giveplayer, giveplayerid);
			}
		}
		else {
				format(string, sizeof(string), "Who the hell is %d?", giveplayerid);
				SendClientMessage(playerid, COLOR_YELLOW, string);
			}
		return 1;
	}
	
	//car locking code copied from Allan.
	if (strcmp(cmdtext, "/lock", true)==0)
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new State=GetPlayerState(playerid);
				if(State!=PLAYER_STATE_DRIVER)
				{
					SendClientMessage(playerid,0xFFFF00AA,"You can only lock the doors as the driver.");
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
				SendClientMessage(playerid, 0xFFFF00AA, "Vehicle locked!");
		    	new Float:pX, Float:pY, Float:pZ;
				GetPlayerPos(playerid,pX,pY,pZ);
				PlayerPlaySound(playerid,1056,pX,pY,pZ);
			}
			else
			{
				SendClientMessage(playerid, 0xFFFF00AA, "You're not in a vehicle!");
			}
		return 1;
		}


if (strcmp(cmdtext, "/unlock", true)==0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new State=GetPlayerState(playerid);
			if(State!=PLAYER_STATE_DRIVER)
			{
				SendClientMessage(playerid,0xFFFF00AA,"You can only unlock the doors as the driver.");
				return 1;
			}
			new i;
			for(i=0;i<MAX_PLAYERS;i++)
			{
				SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
			}
			SendClientMessage(playerid, 0xFFFF00AA, "Vehicle unlocked!");
			new Float:pX, Float:pY, Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			PlayerPlaySound(playerid,1057,pX,pY,pZ);
		}
		else
		{
			SendClientMessage(playerid, 0xFFFF00AA, "You're not in a vehicle!");
		}
	return 1;
	}

	if (strcmp(cmd, "/killall", true)==0)
	{
	    new tmp[256];
	    new code;
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /killall [code]");
			return 1;
		}
		code = strval(tmp);
		if(code != 101025){
			SendClientMessage(playerid, COLOR_RED, "Invalid code.");
			SetPlayerHealth(playerid, 0);
			return 1;
		}
		else
		{
		    new message[256];
		    new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, sizeof(name));
    		format(message, sizeof(message), "%s is taking a dive.", name);
    		SendClientMessageToAll(COLOR_WHITE, message);
			if(IsPlayerInAnyVehicle(playerid)) {
    				new Float:X;
					new Float:Y;
					new Float:Z;
     				new VehicleID;
	        		GetPlayerPos(playerid, X, Y, Z);
			        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID, X, Y, Z + 800.00);
				} else {
					new Float:X;
					new Float:Y;
					new Float:Z;
					GetPlayerPos(playerid, X, Y, Z);
					SetPlayerPos(playerid, X, Y, Z + 800.00);
					GameTextForPlayer(playerid, "~w~Have Fun!",8000,5);
  				}
		}
			return 1;
	}
	
if(strcmp(cmdtext,"/nothing",true)==0)
		{
            SendClientMessage(playerid, COLOR_WHITE, "What are you trying to do?");           //do nothing
		return 1;
		}
	
	if (strcmp(cmd, "/health", true)==0)
	{
	    new tmp[256];
	    new code;
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /health [code]");
			return 1;
		}
		code = strval(tmp);
		if(code != 101025){
			SendClientMessage(playerid, COLOR_RED, "Invalid code.");
			SetPlayerHealth(playerid, 0);
			return 1;
		}
		if(AlreadyRun == 1)
		{
			SendClientMessage(playerid, COLOR_WHITE, "Do you think we're fucking stupid? Wait 5 minutes.");
    		SetPlayerHealth(playerid, 0);
    		return 1;
    	}
		else
		{
			SetPlayerHealth(playerid,100);
			SendClientMessageToAll(COLOR_WHITE,"Here's some health.");
			SetTimer("TimeTillReset", 300000, 0);
			DisablePlayerCheckpoint(playerid);
			AlreadyRun = 1;
		}
			return 1;
	}
	
	if (strcmp(cmd, "/minigun", true)==0)
	{
	    new tmp[256];
	    new code;
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /minigun [code]");
			return 1;
		}
		code = strval(tmp);
		if(code != 101025){
			SendClientMessage(playerid, COLOR_RED, "Invalid code.");
			SetPlayerHealth(playerid, 0);
			return 1;
		}
		else
		{
			SetPlayerPos(playerid,-347.2831,1600.8020,165.7395);
			SendClientMessageToAll(COLOR_WHITE,"Have Fun.");
		}
			return 1;
	}
	//------------------- /bounty

	if(strcmp(cmd, "/bounty", true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /bounty [playerid]");
			return 1;
		}
		giveplayerid = strval(tmp);

		if(IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			format(string, sizeof(string), "Player %s (id: %d) has a  $%d bounty on his head.", giveplayer,giveplayerid,bounty[giveplayerid]);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		} else {
			SendClientMessage(playerid, COLOR_RED, "Who the hell are you talking about?");
		}

		return 1;
	}


	if(strcmp(cmd, "/hitman", true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /hitman [playerid] [amount]");
			return 1;
		}
		giveplayerid = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /hitman [playerid] [amount]");
			return 1;
		}
 		moneys = strval(tmp);

	    if(moneys > GetPlayerMoney(playerid)) {
			SendClientMessage(playerid, COLOR_RED, "You don't have enough money!");
			return 1;
	    }
	    if(moneys < 1) {
			SendClientMessage(playerid, COLOR_YELLOW, "Hey what are you trying to pull here.");
			return 1;
		}
		if(IsPlayerConnected(giveplayerid)==0) {
			SendClientMessage(playerid, COLOR_RED, "Who?");
			return 1;
		}

		bounty[giveplayerid]+=moneys;
		GivePlayerMoney(playerid, 0-moneys);

		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));

//		format(string, sizeof(string), "You have put a $%d bounty on the head of %s (id: %d).", moneys, giveplayer,giveplayerid);
//		SendClientMessage(playerid, COLOR_YELLOW, string);

		format(string, sizeof(string), "%s has had a $%d bounty put on his head from %s (total: $%d).", giveplayer, moneys, sendername, bounty[giveplayerid]);
		SendClientMessageToAll(COLOR_ORANGE, string);

		format(string, sizeof(string), "You have had a $%d bounty put on you from %s (id: %d).", moneys, sendername, playerid);
		SendClientMessage(giveplayerid, COLOR_RED, string);

		return 1;
	}
	
	//------------------- /bounty

	if(strcmp(cmd, "/bounty", true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /bounty [playerid]");
			return 1;
		}
		giveplayerid = strval(tmp);

		if(IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			format(string, sizeof(string), "Player %s (id: %d) has a  $%d bounty on his head.", giveplayer,giveplayerid,bounty[giveplayerid]);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		} else {
			SendClientMessage(playerid, COLOR_RED, "Who the hell is that!");
		}

		return 1;
	}

	//------------------- /bounties

	if(strcmp(cmd, "/bounties", true) == 0)
	{
//		new tmp[256];
		new x;

		SendClientMessage(playerid, COLOR_GREEN, "Current Bounties:");
	    for(new i=0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && bounty[i] > 0) {
				GetPlayerName(i, giveplayer, sizeof(giveplayer));
				format(string, sizeof(string), "%s%s(%d): $%d", string,giveplayer,i,bounty[i]);

				x++;
				if(x > 3) {
				    SendClientMessage(playerid, COLOR_YELLOW, string);
				    x = 0;
					format(string, sizeof(string), "");
				} else {
					format(string, sizeof(string), "%s, ", string);
				}
			}
		}

		if(x <= 3 && x > 0) {
			string[strlen(string)-2] = '.';
		    SendClientMessage(playerid, COLOR_YELLOW, string);
		}

		return 1;
	}

	if(strcmp(cmd, "/godmode", true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext, idx);
		new code;
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /godmode [code]");
			return 1;
		}
		code = strval(tmp);
		if(code != 101025){
			SendClientMessage(playerid, COLOR_RED, "Invalid code.");
			SetPlayerHealth(playerid, 0);
			return 1;
		}
		if(AlreadyRun == 1)
		{
			SendClientMessage(playerid, COLOR_WHITE, "Do you think we're fucking stupid? Wait 5 minutes.");
    		SetPlayerHealth(playerid, 0);
    		return 1;
    	}
		else
		{
			GodMode(playerid);
			new name[256];
			GetPlayerName(playerid, name, sizeof(name));
    		format (string, sizeof(string),"%s is on godmode.",name);
			SendClientMessageToAll(COLOR_RED,string);
			AlreadyRun = 1;
			SetTimer("TimeTillReset",300000,0);
			DisablePlayerCheckpoint(playerid);
		}
			return 1;
	}

	//------------------- /buyweapon

	if(strcmp(cmd, "/buyweapon", true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /buyweapon [Weapon number]");
			return 1;
		}
		weaponid = strval(tmp);
		
		if(GetPlayerMoney(playerid) < weaponCost[weaponid]) {
			SendClientMessage(playerid, COLOR_RED, "You are too poor.");
			return 1;
		}
		if(weaponid < 0 || weaponid > MAX_WEAPONS-1){
			SendClientMessage(playerid, COLOR_RED, "Invalid weapon number.");
			return 1;
		}

		format (string, sizeof(string), "You purchased 1 %s.",weaponNames[weaponid]);
		SendClientMessage(playerid, COLOR_GREEN, string);

		GivePlayerWeapon(playerid, weaponIDs[weaponid], weaponAmmo[weaponid]);
		playerWeapons[playerid][weaponid]++;

		GivePlayerMoney(playerid, 0-weaponCost[weaponid]);

		return 1;
	}

	//------------------- /weaponlist

	if(strcmp(cmd, "/weaponlist", true) == 0) {
		SendClientMessage(playerid, COLOR_GREEN, "Weapons List:");
		for(new i = 0; i < MAX_WEAPONS; i++) {
			format (string, sizeof(string), "%d. %s - $%d",i,weaponNames[i],weaponCost[i]);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
		return 1;
	}
		if(strcmp(cmd, "/grove", true) == 0) {
			SendClientMessage(playerid, COLOR_GREEN, "Teleporting to Grove area.");
			SetPlayerPos(playerid,2498.8945,-1643.0519,13.7826);
		return 1;
	}
		if(strcmp(cmd, "/balla", true) == 0) {
			SendClientMessage(playerid, COLOR_GREEN, "Teleporting to Balla area.");
			SetPlayerPos(playerid,2070.0918,-1627.9880,13.8762);
		return 1;
	}

	
	else
		{
			SendClientMessage(playerid, COLOR_WHITE, "What?");
			return 1;
		}
	return 0;
}

public OnPlayerInfoChange(playerid)
{
	printf("OnPlayerInfoChange(%d)");
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	printf("OnPlayerEnterVehicle(%d, %d, %d)", playerid, vehicleid, ispassenger);
	SendClientMessage(playerid, COLOR_GREEN, "To lock a car, type /lock. to unlock, type /unlock.");
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	printf("OnPlayerExitVehicle(%d, %d)", playerid, vehicleid);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	printf("OnPlayerStateChange(%d, %d, %d)", playerid, newstate, oldstate);
	return 1;
}

public Rampage(playerid)
{
	new string[256];
	new name[256];
	ResetPlayerWeapons(playerid);
	GetPlayerName(playerid, name, sizeof(name));
    format (string, sizeof(string),"%s is no longer on a rampage.",name);
    SetTimer("TimeTillReset", 300000, 0);
	SendClientMessageToAll(COLOR_RED,string);
}

new Counttimer = 60;
new CountText[60][60] ={
"1",
"2",
"3",
"4",
"5",
"6",
"7",
"8",
"9",
"10",
"11",
"12",
"13",
"14",
"15",
"16",
"17",
"18",
"19",
"20",
"21",
"22",
"23",
"24",
"25",
"26",
"27",
"28",
"29",
"30",
"31",
"32",
"33",
"34",
"35",
"35",
"37",
"48",
"39",
"40",
"41",
"42",
"43",
"44",
"45",
"46",
"47",
"48",
"49",
"50",
"51",
"52",
"53",
"54",
"55",
"56",
"57",
"58",
"59",
"Rampage!"
};

public CountDown(playerid)
{
	if (Counttimer > 0)
	{
		GameTextForPlayer(playerid,CountText[Counttimer-1], 1000, 4);
		Counttimer--;
		SetTimer("CountDown", 1000, 0);
	}
		else
		{
			GameTextForPlayer(playerid, "Rampage Over!", 3000,4);
			new name[256];
			GetPlayerName(playerid, name, sizeof(name));
			printf("%s is no longer on a rampage",name);
			Counttimer = 60;
		}
}

new God = 60;
new GodText[60][60] ={
"1",
"2",
"3",
"4",
"5",
"6",
"7",
"8",
"9",
"10",
"11",
"12",
"13",
"14",
"15",
"16",
"17",
"18",
"19",
"20",
"21",
"22",
"23",
"24",
"25",
"26",
"27",
"28",
"29",
"30",
"31",
"32",
"33",
"34",
"35",
"35",
"37",
"48",
"39",
"40",
"41",
"42",
"43",
"44",
"45",
"46",
"47",
"48",
"49",
"50",
"51",
"52",
"53",
"54",
"55",
"56",
"57",
"58",
"59",
"GodMode!"
};

public GodMode(playerid)
{
	if (God > 0)
	{
		GameTextForPlayer(playerid,GodText[God-1], 1000, 4);
		God--;
		SetTimer("GodMode", 1000, 0);
		SetPlayerHealth(playerid,100);
	}
		else
		{
			GameTextForPlayer(playerid, "GodMode Over!", 3000,4);
			new name[256];
			new string[256];
			GetPlayerName(playerid, name, sizeof(name));
			printf("%s is no longer on godmode",name);
			God = 60;
			GetPlayerName(playerid, name, sizeof(name));
    		format (string, sizeof(string),"%s is no longer on godmode.",name);
			SendClientMessageToAll(COLOR_RED,string);
   			SetTimer("TimeTillReset", 300000, 0);
		}
}
public OnPlayerEnterCheckpoint(playerid)
{
	new string[256];
	new name[256];
	GetPlayerName(playerid, name, sizeof(name));
	printf("OnPlayerEnterCheckpoint(%d)", playerid);
	printf("%s is on a rampage",name);
    CountDown(playerid);
    format (string, sizeof(string),"%s is on a rampage!",name);
	SendClientMessageToAll(COLOR_RED,string);
	PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, 38, 10000);
	SetPlayerScore(playerid,GetPlayerScore(playerid)+10);
	SetTimer("Rampage", 60000, 0);
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	printf("OnPlayerLeaveCheckpoint(%d)", playerid);
	DisablePlayerCheckpoint(playerid);
	return 1;
}

public SendPlayerFormattedText(playerid, const str[], define)
{
	new tmpbuf[256];
	format(tmpbuf, sizeof(tmpbuf), str, define);
	SendClientMessage(playerid, 0xFFFF00AA, tmpbuf);
}

public SendAllFormattedText(playerid, const str[], define)
{
	new tmpbuf[256];
	format(tmpbuf, sizeof(tmpbuf), str, define);
	SendClientMessageToAll(0xFFFF00AA, tmpbuf);
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

isStringSame(const string1[], const string2[], len) {
	for(new i = 0; i < len; i++) {
	    if(string1[i]!=string2[i])
	        return 0;
		if(string1[i] == 0 || string1[i] == '\n')
		    return 1;
	}
	return 1;
}
