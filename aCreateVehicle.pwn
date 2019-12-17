#include <a_samp>

/*
	Script: aCreateVehicle.pwn
	Desc.:  Use /spawnmenu for vehicle spawning menu
	Ver:    1.0

	Author: Apophis
	Email:  email@ristoveeb.pri.ee
	Date:   29 October 2008

	Notes:  You're free to edit it, but leave credits please!
*/

// Some new stuff
new Vehicle[199];
new Timer[sizeof(Vehicle)];

// Forwarding stuff
forward KillVehicle(vehicleid, checkplayer);

// new Menus
new Menu:MainMenu;
new Menu:Bicycles;
new Menu:Bikes;
new Menu:Monsters;
new Menu:Boats;
new Menu:Helis;
new Menu:Planes;
new Menu:Cars;
new Menu:Lowriders;
new Menu:Streets;
new Menu:Muscles;
new Menu:SuvWagon;
new Menu:Sports;
new Menu:ReCreated;
new Menu:CivilServ;
new Menu:Govern;
new Menu:RC;
new Menu:Luxury4;
new Menu:Luxury4_2;
new Menu:TwoDoor;
new Menu:TwoDoor2;
new Menu:Heavy;
new Menu:Heavy2;
new Menu:Light;
new Menu:Light2;

public OnFilterScriptInit()
{
	print("\n-----------------------------------");
	print("|  vehicle spawn menu by Apophis  |");
	print("-----------------------------------\n");

	// Creating menus
	MainMenu = CreateMenu("Vehicles", 		1, 50.0, 180.0, 175.0, 25.0);
	Bicycles = CreateMenu("Bicycles", 		1, 50.0, 180.0, 175.0, 25.0);
	Bikes 	 = CreateMenu("Bikes", 	  		1, 50.0, 180.0, 175.0, 25.0);
	Monsters = CreateMenu("Monsters", 		1, 50.0, 180.0, 175.0, 25.0);
	Boats    = CreateMenu("Boats", 	  		1, 50.0, 180.0, 175.0, 25.0);
	Helis    = CreateMenu("Helis", 	  		1, 50.0, 180.0, 175.0, 25.0);
	Planes   = CreateMenu("Planes",	  		1, 50.0, 180.0, 175.0, 25.0);
	Cars     = CreateMenu("Cars",     		1, 50.0, 180.0, 175.0, 25.0);
	Lowriders= CreateMenu("Lowriders",		1, 50.0, 180.0, 175.0, 25.0);
	Streets	 = CreateMenu("Street Racers",	1, 50.0, 180.0, 175.0, 25.0);
	Muscles	 = CreateMenu("Muscles",  		1, 50.0, 180.0, 175.0, 25.0);
	SuvWagon = CreateMenu("Suvs Wagons",	1, 50.0, 180.0, 175.0, 25.0);
	Sports   = CreateMenu("Sport cars",     1, 50.0, 180.0, 175.0, 25.0);
	ReCreated= CreateMenu("Recreational",   1, 50.0, 180.0, 175.0, 25.0);
	CivilServ= CreateMenu("Civil Serv.",    1, 50.0, 180.0, 175.0, 25.0);
	Govern   = CreateMenu("Government",     1, 50.0, 180.0, 175.0, 25.0);
	RC       = CreateMenu("RC Vehicles",	1, 50.0, 180.0, 175.0, 25.0);
	Luxury4  = CreateMenu("4 door lux.",  	1, 50.0, 180.0, 175.0, 25.0);
	Luxury4_2= CreateMenu("4 door lux.",  	1, 50.0, 180.0, 175.0, 25.0);
	TwoDoor  = CreateMenu("2 doored cars",  1, 50.0, 180.0, 175.0, 25.0);
	TwoDoor2 = CreateMenu("2 doored cars",  1, 50.0, 180.0, 175.0, 25.0);
	Heavy    = CreateMenu("Heavy trucks",   1, 50.0, 180.0, 175.0, 25.0);
	Heavy2   = CreateMenu("Heavy trucks",   1, 50.0, 180.0, 175.0, 25.0);
	Light    = CreateMenu("Light trucks",   1, 50.0, 180.0, 175.0, 25.0);
	Light2   = CreateMenu("Light trucks",   1, 50.0, 180.0, 175.0, 25.0);
	
	// Set menu column headers
	SetMenuColumnHeader(MainMenu, 	0, "Select type");
	SetMenuColumnHeader(Cars, 		0, "Select type");
	
	/* ADD MAIN MENU ITEMS */
	AddMenuItem(MainMenu, 0, "Bicycles");
	AddMenuItem(MainMenu, 0, "Bikes");
	AddMenuItem(MainMenu, 0, "Monster trucks");
	AddMenuItem(MainMenu, 0, "Boats");
	AddMenuItem(MainMenu, 0, "Helicopters");
	AddMenuItem(MainMenu, 0, "Planes");
	AddMenuItem(MainMenu, 0, "Cars");
	AddMenuItem(MainMenu, 0, "RC vehicles");
	
	/* ADD CARS MENU ITEMS */
	AddMenuItem(Cars, 0, "Lowriders");
	AddMenuItem(Cars, 0, "Street racers");
	AddMenuItem(Cars, 0, "Muscle cars");
	AddMenuItem(Cars, 0, "Suvs & Wagons");
	AddMenuItem(Cars, 0, "Sport Cars");
	AddMenuItem(Cars, 0, "Recreational");
	AddMenuItem(Cars, 0, "Civil Servant");
	AddMenuItem(Cars, 0, "Government");
	AddMenuItem(Cars, 0, "4 door luxury");
	AddMenuItem(Cars, 0, "2 door sedans");
	AddMenuItem(Cars, 0, "Heavy trucks");
	AddMenuItem(Cars, 0, "Light trucks");
	
	/* ADD BICYCLES MENU ITEMS */
	AddMenuItem(Bicycles, 0, "Bike");           // 509
	AddMenuItem(Bicycles, 0, "BMX");            // 481
	AddMenuItem(Bicycles, 0, "Mountain bike");  // 510
	
	/* ADD BIKES MENU ITEMS */
	AddMenuItem(Bikes, 0, "NRG-500"); 		// 522
	AddMenuItem(Bikes, 0, "Faggio"); 		// 462
	AddMenuItem(Bikes, 0, "FCR-900"); 		// 521
	AddMenuItem(Bikes, 0, "PCJ-600"); 		// 461
	AddMenuItem(Bikes, 0, "Freeway"); 		// 463
	AddMenuItem(Bikes, 0, "BF-400"); 		// 581
	AddMenuItem(Bikes, 0, "Pizzaboy"); 		// 448
	AddMenuItem(Bikes, 0, "Wayfarer"); 		// 586
	AddMenuItem(Bikes, 0, "Cop Bike"); 		// 523
	AddMenuItem(Bikes, 0, "Sanchez"); 		// 468
	AddMenuItem(Bikes, 0, "Quad"); 			// 471
	
	/* ADD MONSTER TRUCKS MENU ITEMS */
	AddMenuItem(Monsters, 0, "Dumper"); 	// 406
	AddMenuItem(Monsters, 0, "Duneride"); 	// 573
	AddMenuItem(Monsters, 0, "Monster"); 	// 444
	AddMenuItem(Monsters, 0, "Monster A"); 	// 556
	AddMenuItem(Monsters, 0, "Monster B"); 	// 557
	
	/* ADD BOATS MENU ITEMS */
	AddMenuItem(Boats, 0, "Coastguard"); 	// 472
	AddMenuItem(Boats, 0, "Dinghy"); 		// 473
	AddMenuItem(Boats, 0, "Jetmax"); 		// 493
	AddMenuItem(Boats, 0, "Launch"); 		// 595
	AddMenuItem(Boats, 0, "Marquis"); 		// 484
	AddMenuItem(Boats, 0, "Predator"); 		// 430
	AddMenuItem(Boats, 0, "Reefer"); 		// 453
	AddMenuItem(Boats, 0, "Speeder"); 		// 452
	AddMenuItem(Boats, 0, "Squalo"); 		// 446
	AddMenuItem(Boats, 0, "Tropic"); 		// 454
	
	/* ADD HELICOPTERS MENU ITEMS */
	AddMenuItem(Helis, 0, "Cargobob");      // 548
	AddMenuItem(Helis, 0, "Hunter"); 	    // 425
	AddMenuItem(Helis, 0, "Leviathn");      // 417
	AddMenuItem(Helis, 0, "Maverick");      // 487
	AddMenuItem(Helis, 0, "Polmav");		// 497
	AddMenuItem(Helis, 0, "Raindanc");      // 563
	AddMenuItem(Helis, 0, "Seasparr");      // 447
	AddMenuItem(Helis, 0, "Sparrow");       // 469
	AddMenuItem(Helis, 0, "VCN Mav");       // 488
	
	/* ADD PLANES MENU ITEMS */
	AddMenuItem(Planes, 0, "Hydra");        // 520
	AddMenuItem(Planes, 0, "Rustler");      // 476
	AddMenuItem(Planes, 0, "Dodo");       	// 593
	AddMenuItem(Planes, 0, "Nevada");       // 553
	AddMenuItem(Planes, 0, "Stuntplane");   // 513
	AddMenuItem(Planes, 0, "Cropdust");     // 512
	AddMenuItem(Planes, 0, "AT-400");       // 577
	AddMenuItem(Planes, 0, "Andromeda");    // 592
	AddMenuItem(Planes, 0, "Beagle");       // 511
	AddMenuItem(Planes, 0, "Vortex");       // 539
	AddMenuItem(Planes, 0, "Skimmer");      // 460
	AddMenuItem(Planes, 0, "Shamal");       // 519
	
	/* ADD LOWRIDERS MENU ITEMS */
	AddMenuItem(Lowriders, 0, "Blade"); 	// 536
	AddMenuItem(Lowriders, 0, "Broadway"); 	// 575
	AddMenuItem(Lowriders, 0, "Remmington");// 534
	AddMenuItem(Lowriders, 0, "Savanna"); 	// 567
	AddMenuItem(Lowriders, 0, "Slamvan"); 	// 535
	AddMenuItem(Lowriders, 0, "Tornado"); 	// 576
	AddMenuItem(Lowriders, 0, "Voodoo"); 	// 412
	
	/* ADD SPORT CARS MENU ITEMS */
	AddMenuItem(Streets, 0, "Elegy"); 		// 562
	AddMenuItem(Streets, 0, "Flash"); 		// 565
	AddMenuItem(Streets, 0, "Jester"); 		// 559
	AddMenuItem(Streets, 0, "Stratum"); 	// 561
	AddMenuItem(Streets, 0, "Sultan"); 		// 560
	AddMenuItem(Streets, 0, "Uranus"); 		// 558
	
	/* ADD MUSCLE CARS MENU ITEMS */
	AddMenuItem(Muscles, 0, "Buffalo"); 	// 402
	AddMenuItem(Muscles, 0, "Clover"); 		// 542
	AddMenuItem(Muscles, 0, "Phoenix");		// 603
	AddMenuItem(Muscles, 0, "Sabre"); 		// 475
	
	/* ADD SUV & WAGON CARS MENU ITEMS */
	AddMenuItem(SuvWagon, 0, "Huntley"); 	// 579
	AddMenuItem(SuvWagon, 0, "Landstalker");// 400
	AddMenuItem(SuvWagon, 0, "Perennial"); 	// 404
	AddMenuItem(SuvWagon, 0, "Rancher"); 	// 489
	AddMenuItem(SuvWagon, 0, "Regina"); 	// 479
	AddMenuItem(SuvWagon, 0, "Romero"); 	// 442
	AddMenuItem(SuvWagon, 0, "Solair"); 	// 458
	
	/* ADD SPORT CARS MENU ITEMS */
	AddMenuItem(Sports, 0, "Banshee"); 		// 429
	AddMenuItem(Sports, 0, "Bullet"); 		// 541
	AddMenuItem(Sports, 0, "Cheetah"); 		// 415
	AddMenuItem(Sports, 0, "Comet"); 		// 480
	AddMenuItem(Sports, 0, "Hotknife"); 	// 434
	AddMenuItem(Sports, 0, "Hotring racer");// 494
	AddMenuItem(Sports, 0, "Infernus"); 	// 411
	AddMenuItem(Sports, 0, "Super GT"); 	// 506
	AddMenuItem(Sports, 0, "Turismo"); 		// 451
	AddMenuItem(Sports, 0, "Windsor"); 		// 555
	AddMenuItem(Sports, 0, "ZR-350"); 		// 477
	
	/* ADD RECREATIONAL CARS MENU ITEMS */
	AddMenuItem(ReCreated, 0, "Bandito"); 			// 568
	AddMenuItem(ReCreated, 0, "BF Injection"); 		// 424
	AddMenuItem(ReCreated, 0, "Bloodring banger"); 	// 504
	AddMenuItem(ReCreated, 0, "Caddy"); 			// 457
	AddMenuItem(ReCreated, 0, "Camper"); 			// 483
	AddMenuItem(ReCreated, 0, "Journey"); 			// 508
	AddMenuItem(ReCreated, 0, "Kart"); 				// 571
	AddMenuItem(ReCreated, 0, "Mesa"); 				// 500
	AddMenuItem(ReCreated, 0, "Sandking"); 			// 495
	AddMenuItem(ReCreated, 0, "Vortex"); 			// 539
	
	/* ADD CIVIL SERVANT TRANSPORTATION CARS MENU ITEMS */
	AddMenuItem(CivilServ, 0, "Baggage"); 		// 485
	AddMenuItem(CivilServ, 0, "Bus"); 			// 431
	AddMenuItem(CivilServ, 0, "Cabbie"); 		// 438
	AddMenuItem(CivilServ, 0, "Coach"); 		// 437
	AddMenuItem(CivilServ, 0, "Sweeper"); 		// 574
	AddMenuItem(CivilServ, 0, "Taxi"); 			// 420
	AddMenuItem(CivilServ, 0, "Towtruck"); 		// 525
	AddMenuItem(CivilServ, 0, "Trashmaster"); 	// 408
	AddMenuItem(CivilServ, 0, "Utility van"); 	// 552
	
	/* ADD COMMERCIAL GOVERNMENT CARS MENU ITEMS */
	AddMenuItem(Govern, 0, "Ambulance"); 		// 416
	AddMenuItem(Govern, 0, "Barracks"); 		// 433
	AddMenuItem(Govern, 0, "Enforcer"); 		// 427
	AddMenuItem(Govern, 0, "FBI Rancher"); 		// 490
	AddMenuItem(Govern, 0, "FBI Truck"); 		// 528
	AddMenuItem(Govern, 0, "Firetruck"); 		// 407
	AddMenuItem(Govern, 0, "Patriot"); 			// 470
	AddMenuItem(Govern, 0, "Police Car SF"); 	// 597
	AddMenuItem(Govern, 0, "Ranger"); 			// 599
	AddMenuItem(Govern, 0, "Securicar"); 		// 428
	AddMenuItem(Govern, 0, "S.W.A.T"); 			// 601
	
	/* ADD RC VEHICLES MENU ITEMS  */
	AddMenuItem(RC, 0, "RC Goblin");     		// 501
	AddMenuItem(RC, 0, "RC Raider");     		// 465
	AddMenuItem(RC, 0, "RC Barron");    		// 464
	AddMenuItem(RC, 0, "RC Bandit");    		// 441
	AddMenuItem(RC, 0, "RC Cam");	    		// 594
	AddMenuItem(RC, 0, "RC Tiger");	    		// 564
	
	/* ADD 4 DOOR LUXURY CARS MENU ITEMS - PAGE 1 */
	AddMenuItem(Luxury4, 0, "Admiral"); 		// 445
	AddMenuItem(Luxury4, 0, "Elegant"); 		// 507
	AddMenuItem(Luxury4, 0, "Emperor"); 		// 585
	AddMenuItem(Luxury4, 0, "Euros"); 			// 587
	AddMenuItem(Luxury4, 0, "Glendale"); 		// 466
	AddMenuItem(Luxury4, 0, "Greenwood"); 		// 492
	AddMenuItem(Luxury4, 0, "Intruder"); 		// 546
	AddMenuItem(Luxury4, 0, "Merit"); 			// 551
	AddMenuItem(Luxury4, 0, "Nebula"); 			// 516
	AddMenuItem(Luxury4, 0, "Oceanic");         // 467
	AddMenuItem(Luxury4, 0, "Next page"); 		// NEXT
	
	/* ADD 4 DOOR LUXURY CARS MENU ITEMS - PAGE 2 */
	AddMenuItem(Luxury4_2, 0, "Premier"); 		// 426
	AddMenuItem(Luxury4_2, 0, "Primo"); 		// 547
	AddMenuItem(Luxury4_2, 0, "Sentinel"); 		// 405
	AddMenuItem(Luxury4_2, 0, "Stretch"); 		// 409
	AddMenuItem(Luxury4_2, 0, "Sunrise"); 		// 550
	AddMenuItem(Luxury4_2, 0, "Tahoma"); 		// 566
	AddMenuItem(Luxury4_2, 0, "Vincent"); 		// 540
	AddMenuItem(Luxury4_2, 0, "Washington"); 	// 421
	AddMenuItem(Luxury4_2, 0, "Willard"); 		// 529
	AddMenuItem(Luxury4_2, 0, "Back");			// BACK
	
	/* ADD 2 DOOR SEDAN CARS MENU ITEMS - PAGE 1 */
	AddMenuItem(TwoDoor, 0, "Alpha"); 			// 602
	AddMenuItem(TwoDoor, 0, "Blista Compact"); 	// 496
	AddMenuItem(TwoDoor, 0, "Bravura"); 		// 401
	AddMenuItem(TwoDoor, 0, "Buccaneer"); 		// 518
	AddMenuItem(TwoDoor, 0, "Cadrona"); 		// 527
	AddMenuItem(TwoDoor, 0, "Club"); 			// 589
	AddMenuItem(TwoDoor, 0, "Esperanto"); 		// 419
	AddMenuItem(TwoDoor, 0, "Feltzer"); 		// 533
	AddMenuItem(TwoDoor, 0, "Fortune"); 		// 526
	AddMenuItem(TwoDoor, 0, "Next page"); 		// NEXT
	
	/* ADD 2 DOOR SEDAN CARS MENU ITEMS - PAGE 2 */
	AddMenuItem(TwoDoor2, 0, "Hermes"); 		// 474
	AddMenuItem(TwoDoor2, 0, "Hustler"); 		// 545
	AddMenuItem(TwoDoor2, 0, "Majestic"); 		// 517
	AddMenuItem(TwoDoor2, 0, "Manana"); 		// 410
	AddMenuItem(TwoDoor2, 0, "Picador"); 		// 600
	AddMenuItem(TwoDoor2, 0, "Previon"); 		// 436
	AddMenuItem(TwoDoor2, 0, "Stafford"); 		// 580
	AddMenuItem(TwoDoor2, 0, "Stallion"); 		// 439
	AddMenuItem(TwoDoor2, 0, "Tampa"); 			// 549
	AddMenuItem(TwoDoor2, 0, "Virgo"); 			// 491
	AddMenuItem(TwoDoor2, 0, "Back"); 			// BACK
	
	/* ADD HEAVY TRUCKS MENU ITEMS - PAGE 1 */
	AddMenuItem(Heavy, 0, "Benson"); 			// 499
	AddMenuItem(Heavy, 0, "Boxville"); 			// 498
	AddMenuItem(Heavy, 0, "Cement truck"); 		// 524
	AddMenuItem(Heavy, 0, "Combine Harvester"); // 532
	AddMenuItem(Heavy, 0, "DFT-30"); 			// 578
	AddMenuItem(Heavy, 0, "Dozer"); 			// 486
	AddMenuItem(Heavy, 0, "Flatbed"); 			// 455
	AddMenuItem(Heavy, 0, "Hotdog"); 			// 588
	AddMenuItem(Heavy, 0, "Next page"); 		// NEXT
	
	/* ADD HEAVY TRUCKS MENU ITEMS - PAGE 2 */
	AddMenuItem(Heavy2, 0, "Linerunner"); 		// 403
	AddMenuItem(Heavy2, 0, "Mr Whoopee"); 		// 423
	AddMenuItem(Heavy2, 0, "Mule"); 			// 414
	AddMenuItem(Heavy2, 0, "Packer"); 			// 443
	AddMenuItem(Heavy2, 0, "Roadtrain"); 		// 515
	AddMenuItem(Heavy2, 0, "Tanker"); 			// 514
	AddMenuItem(Heavy2, 0, "Tractor"); 			// 531
	AddMenuItem(Heavy2, 0, "Yankee"); 			// 456
	AddMenuItem(Heavy2, 0, "Back");				// BACK
	
	/* ADD LIGHT TRUCKS MENU ITEMS - PAGE 1 */
	AddMenuItem(Light, 0, "Berkley's RC van"); 	// 459
	AddMenuItem(Light, 0, "Bobcat"); 			// 422
	AddMenuItem(Light, 0, "Burrito"); 			// 482
	AddMenuItem(Light, 0, "Forklift"); 			// 530
	AddMenuItem(Light, 0, "Moonbeam"); 			// 418
	AddMenuItem(Light, 0, "Mower"); 			// 572
	AddMenuItem(Light, 0, "Newsvan"); 			// 582
	AddMenuItem(Light, 0, "Next page"); 		// NEXT
	
    /* ADD LIGHT TRUCKS MENU ITEMS - PAGE 2 */
    AddMenuItem(Light2, 0, "Pony"); 			// 413
    AddMenuItem(Light2, 0, "Rumpo"); 			// 440
    AddMenuItem(Light2, 0, "Sadler"); 			// 543
    AddMenuItem(Light2, 0, "Tug"); 				// 583
    AddMenuItem(Light2, 0, "Walton"); 			// 478
    AddMenuItem(Light2, 0, "Yosemite"); 		// 554
    AddMenuItem(Light2, 0, "Back"); 			// BACK


	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:CurrentMenu = GetPlayerMenu(playerid);
    
	if(CurrentMenu == Light2)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 413, 182);
	        case 1: aCreateThing(playerid, 440, 183);
	        case 2: aCreateThing(playerid, 543, 184);
	        case 3: aCreateThing(playerid, 583, 185);
	        case 4: aCreateThing(playerid, 478, 186);
	        case 5: aCreateThing(playerid, 554, 187);
	        case 6: ShowMenuForPlayer(Light, playerid);
	    }
	}
	else if(CurrentMenu == Light)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 459, 175);
	        case 1: aCreateThing(playerid, 422, 176);
	        case 2: aCreateThing(playerid, 482, 177);
	        case 3: aCreateThing(playerid, 530, 178);
	        case 4: aCreateThing(playerid, 418, 179);
	        case 5: aCreateThing(playerid, 572, 180);
	        case 6: aCreateThing(playerid, 582, 181);
	        case 7: ShowMenuForPlayer(Light2, playerid);
	    }
	}
	else if(CurrentMenu == Heavy2)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 403, 167);
	        case 1: aCreateThing(playerid, 423, 168);
	        case 2: aCreateThing(playerid, 414, 169);
	        case 3: aCreateThing(playerid, 443, 170);
	        case 4: aCreateThing(playerid, 515, 171);
	        case 5: aCreateThing(playerid, 514, 172);
	        case 6: aCreateThing(playerid, 531, 173);
	        case 7: aCreateThing(playerid, 456, 174);
	        case 8: ShowMenuForPlayer(Heavy, playerid);
	    }
	}
	else if(CurrentMenu == Heavy)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 499, 159);
	        case 1: aCreateThing(playerid, 498, 160);
	        case 2: aCreateThing(playerid, 524, 161);
	        case 3: aCreateThing(playerid, 532, 162);
	        case 4: aCreateThing(playerid, 578, 163);
	        case 5: aCreateThing(playerid, 486, 164);
	        case 6: aCreateThing(playerid, 455, 165);
	        case 7: aCreateThing(playerid, 588, 166);
	        case 8: ShowMenuForPlayer(Heavy2, playerid);
	    }
	}
	else if(CurrentMenu == TwoDoor2)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 474, 149);
	        case 1: aCreateThing(playerid, 545, 150);
	        case 2: aCreateThing(playerid, 517, 151);
	        case 3: aCreateThing(playerid, 410, 152);
	        case 4: aCreateThing(playerid, 600, 153);
	        case 5: aCreateThing(playerid, 436, 154);
	        case 6: aCreateThing(playerid, 580, 155);
	        case 7: aCreateThing(playerid, 439, 156);
	        case 8: aCreateThing(playerid, 549, 157);
	        case 9: aCreateThing(playerid, 491, 158);
	        case 10:ShowMenuForPlayer(TwoDoor, playerid);
	    }
	}
	else if(CurrentMenu == TwoDoor)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 602, 140);
	        case 1: aCreateThing(playerid, 496, 141);
	        case 2: aCreateThing(playerid, 401, 142);
	        case 3: aCreateThing(playerid, 518, 143);
	        case 4: aCreateThing(playerid, 527, 144);
	        case 5: aCreateThing(playerid, 589, 145);
	        case 6: aCreateThing(playerid, 419, 146);
	        case 7: aCreateThing(playerid, 533, 147);
	        case 8: aCreateThing(playerid, 526, 148);
	        case 9: ShowMenuForPlayer(TwoDoor2, playerid);
	    }
	}
	else if(CurrentMenu == Luxury4_2)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 426, 131);
	        case 1: aCreateThing(playerid, 547, 132);
	        case 2: aCreateThing(playerid, 405, 133);
	        case 3: aCreateThing(playerid, 409, 134);
	        case 4: aCreateThing(playerid, 550, 135);
	        case 5: aCreateThing(playerid, 566, 136);
	        case 6: aCreateThing(playerid, 540, 137);
	        case 7: aCreateThing(playerid, 421, 138);
	        case 8: aCreateThing(playerid, 529, 139);
	        case 9:ShowMenuForPlayer(Luxury4, playerid);
	    }
	}
	else if(CurrentMenu == Luxury4)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 445, 121);
	        case 1: aCreateThing(playerid, 507, 122);
	        case 2: aCreateThing(playerid, 585, 123);
	        case 3: aCreateThing(playerid, 587, 124);
	        case 4: aCreateThing(playerid, 466, 125);
	        case 5: aCreateThing(playerid, 492, 126);
	        case 6: aCreateThing(playerid, 546, 127);
	        case 7: aCreateThing(playerid, 551, 128);
	        case 8: aCreateThing(playerid, 516, 129);
	        case 9: aCreateThing(playerid, 467, 130);
	        case 10:ShowMenuForPlayer(Luxury4_2, playerid);
	    }
	}
	else if(CurrentMenu == RC)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 501, 115);
	        case 1: aCreateThing(playerid, 465, 116);
	        case 2: aCreateThing(playerid, 464, 117);
	        case 3: aCreateThing(playerid, 441, 118);
	        case 4: aCreateThing(playerid, 594, 119);
	        case 5: aCreateThing(playerid, 564, 120);
	    }
	}
	else if(CurrentMenu == Govern)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 416, 102);
	        case 1: aCreateThing(playerid, 433, 103);
	        case 2: aCreateThing(playerid, 427, 104);
	        case 3: aCreateThing(playerid, 490, 105);
	        case 4: aCreateThing(playerid, 528, 106);
	        case 5: aCreateThing(playerid, 407, 107);
	        case 6: aCreateThing(playerid, 570, 108);
	        case 7: aCreateThing(playerid, 597, 109);
	        case 8: aCreateThing(playerid, 599, 112);
	        case 9: aCreateThing(playerid, 428, 113);
	        case 10:aCreateThing(playerid, 601, 114);
	    }
	}
	else if(CurrentMenu == CivilServ)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 485, 93);
	        case 1: aCreateThing(playerid, 431, 94);
	        case 2: aCreateThing(playerid, 438, 95);
	        case 3: aCreateThing(playerid, 437, 96);
	        case 4: aCreateThing(playerid, 574, 97);
	        case 5: aCreateThing(playerid, 420, 98);
	        case 6: aCreateThing(playerid, 525, 99);
	        case 7: aCreateThing(playerid, 408, 100);
	        case 8: aCreateThing(playerid, 552, 101);
	    }
	}
	else if(CurrentMenu == ReCreated)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 568, 83);
	        case 1: aCreateThing(playerid, 424, 84);
	        case 2: aCreateThing(playerid, 504, 85);
	        case 3: aCreateThing(playerid, 457, 86);
	        case 4: aCreateThing(playerid, 483, 87);
	        case 5: aCreateThing(playerid, 508, 88);
	        case 6: aCreateThing(playerid, 571, 89);
	        case 7: aCreateThing(playerid, 500, 90);
	        case 8: aCreateThing(playerid, 495, 91);
	        case 9: aCreateThing(playerid, 539, 92);
	    }
	}
	else if(CurrentMenu == Sports)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 429, 72);
	        case 1: aCreateThing(playerid, 541, 73);
	        case 2: aCreateThing(playerid, 415, 74);
	        case 3: aCreateThing(playerid, 480, 75);
	        case 4: aCreateThing(playerid, 434, 76);
	        case 5: aCreateThing(playerid, 494, 77);
	        case 6: aCreateThing(playerid, 411, 78);
	        case 7: aCreateThing(playerid, 506, 79);
	        case 8: aCreateThing(playerid, 451, 80);
	        case 9: aCreateThing(playerid, 555, 81);
	        case 10:aCreateThing(playerid, 477, 82);
	    }
	}
   	else if(CurrentMenu == SuvWagon)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 579, 66);
	        case 1: aCreateThing(playerid, 400, 67);
	        case 2: aCreateThing(playerid, 404, 68);
	        case 3: aCreateThing(playerid, 489, 69);
	        case 4: aCreateThing(playerid, 479, 70);
	        case 5: aCreateThing(playerid, 442, 71);
	        case 6: aCreateThing(playerid, 458, 72);
		}
	}
   	else if(CurrentMenu == Muscles)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 402, 62);
	        case 1: aCreateThing(playerid, 542, 63);
	        case 2: aCreateThing(playerid, 603, 64);
	        case 3: aCreateThing(playerid, 475, 65);
		}
	}
   	else if(CurrentMenu == Streets)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 562, 56);
	        case 1: aCreateThing(playerid, 565, 57);
	        case 2: aCreateThing(playerid, 559, 58);
	        case 3: aCreateThing(playerid, 561, 59);
	        case 4: aCreateThing(playerid, 560, 60);
	        case 5: aCreateThing(playerid, 558, 61);
		}
	}
   	else if(CurrentMenu == Lowriders)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 536, 49);
	        case 1: aCreateThing(playerid, 575, 50);
	        case 2: aCreateThing(playerid, 534, 51);
	        case 3: aCreateThing(playerid, 567, 52);
	        case 4: aCreateThing(playerid, 535, 53);
	        case 5: aCreateThing(playerid, 576, 54);
	        case 6: aCreateThing(playerid, 412, 55);
		}
	}
	else if(CurrentMenu == Planes)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 520, 36);
	        case 1: aCreateThing(playerid, 476, 37);
	        case 2: aCreateThing(playerid, 593, 38);
	        case 3: aCreateThing(playerid, 553, 39);
	        case 4: aCreateThing(playerid, 513, 40);
	        case 5: aCreateThing(playerid, 512, 41);
	        case 6: aCreateThing(playerid, 577, 42);
	        case 7: aCreateThing(playerid, 592, 43);
	        case 8: aCreateThing(playerid, 511, 44);
	        case 9: aCreateThing(playerid, 539, 45);
	        case 10:aCreateThing(playerid, 460, 47);
	        case 11:aCreateThing(playerid, 519, 48);
	    }
	}
	else if(CurrentMenu == Helis)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 548, 25);
	        case 1: aCreateThing(playerid, 425, 26);
	        case 2: aCreateThing(playerid, 417, 27);
	        case 3: aCreateThing(playerid, 487, 28);
	        case 4: aCreateThing(playerid, 497, 29);
	        case 5: aCreateThing(playerid, 563, 30);
	        case 6: aCreateThing(playerid, 447, 33);
	        case 7: aCreateThing(playerid, 469, 34);
	        case 8: aCreateThing(playerid, 488, 35);
	    }
	}
	else if(CurrentMenu == Boats)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 472, 15);
	        case 1: aCreateThing(playerid, 473, 16);
	        case 2: aCreateThing(playerid, 493, 17);
	        case 3: aCreateThing(playerid, 595, 18);
	        case 4: aCreateThing(playerid, 484, 19);
	        case 5: aCreateThing(playerid, 430, 20);
	        case 6: aCreateThing(playerid, 453, 21);
	        case 7: aCreateThing(playerid, 452, 22);
	        case 8: aCreateThing(playerid, 446, 23);
	        case 9: aCreateThing(playerid, 454, 24);
	    }
	}
   	else if(CurrentMenu == Monsters)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 406, 15);
	        case 1: aCreateThing(playerid, 573, 16);
	        case 2: aCreateThing(playerid, 444, 17);
	        case 3: aCreateThing(playerid, 556, 18);
	        case 4: aCreateThing(playerid, 557, 19);
		}
	}
	else if(CurrentMenu == Bikes)
	{
	    switch(row)
	    {
	        case 0: aCreateThing(playerid, 522, 4);
	        case 1: aCreateThing(playerid, 462, 5);
	        case 2: aCreateThing(playerid, 521, 6);
	        case 3: aCreateThing(playerid, 461, 7);
	        case 4: aCreateThing(playerid, 463, 8);
	        case 5: aCreateThing(playerid, 581, 9);
	        case 6: aCreateThing(playerid, 448, 10);
	        case 7: aCreateThing(playerid, 586, 11);
	        case 8: aCreateThing(playerid, 523, 12);
	        case 9: aCreateThing(playerid, 468, 13);
	        case 10:aCreateThing(playerid, 471, 14);
	    }
	}
    else if (CurrentMenu == Bicycles)
    {
        switch(row)
        {
            case 0: aCreateThing(playerid, 509, 1);
            case 1: aCreateThing(playerid, 481, 2);
            case 2: aCreateThing(playerid, 510, 3);
        }
    }
	else if(CurrentMenu == MainMenu)
    {
        switch(row)
        {
			case 0: ShowMenuForPlayer(Bicycles, playerid);
			case 1: ShowMenuForPlayer(Bikes, playerid);
			case 2: ShowMenuForPlayer(Monsters, playerid);
   			case 3: ShowMenuForPlayer(Boats, playerid);
   			case 4: ShowMenuForPlayer(Helis, playerid);
   			case 5: ShowMenuForPlayer(Planes, playerid);
   			case 6: ShowMenuForPlayer(Cars, playerid);
   			case 7: ShowMenuForPlayer(RC, playerid);
        }
    }
	else if(CurrentMenu == Cars)
    {
        switch(row)
        {
			case 0: ShowMenuForPlayer(Lowriders, playerid);
			case 1: ShowMenuForPlayer(Streets, playerid);
        	case 2: ShowMenuForPlayer(Muscles, playerid);
        	case 3: ShowMenuForPlayer(SuvWagon, playerid);
        	case 4: ShowMenuForPlayer(Sports, playerid);
        	case 5: ShowMenuForPlayer(ReCreated, playerid);
        	case 6: ShowMenuForPlayer(CivilServ, playerid);
        	case 7: ShowMenuForPlayer(Govern, playerid);
        	case 8: ShowMenuForPlayer(Luxury4, playerid);
        	case 9: ShowMenuForPlayer(TwoDoor, playerid);
        	case 10:ShowMenuForPlayer(Heavy, playerid);
        	case 11:ShowMenuForPlayer(Light, playerid);
        }
    }
    
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	
	if (strcmp("/spawnmenu", cmdtext, true, 10) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
			ShowMenuForPlayer(MainMenu, playerid);
			TogglePlayerControllable(playerid, false);

			return 1;
		}
		else
		{
		    return SendClientMessage(playerid, 0xAFAFAFAA, "* This command is only for administrators!");
		}
	}
	
	return 0;
}

stock aCreateThing(playerid, thingid, orderid)
{
	new Float:X, Float:Y, Float:Z, Float:Angle;
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, Angle);

	if(thingid != 597)
	{
		Vehicle[orderid] = CreateVehicle(thingid, X, Y, Z + 3, Angle, random(126), random(126), 30);
	}
	else
	{
	    Vehicle[orderid] = CreateVehicle(thingid, X, Y, Z + 3, Angle, 0, 1, 30);
	}
	PutPlayerInVehicle(playerid, Vehicle[orderid], 0);
	TogglePlayerControllable(playerid, true);
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	for(new i = 0; i <= sizeof(Vehicle); i++)
	{
	    if(vehicleid == Vehicle[i])
		{
		    Timer[vehicleid] = SetTimerEx("KillVehicle", 3000, 0, "ii", vehicleid, 1);
		}
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	for(new i = 0; i <= sizeof(Vehicle); i++)
	{
	    if(vehicleid == Vehicle[i])
		{
		    Timer[vehicleid] = SetTimerEx("KillVehicle", 30000, 1, "ii", vehicleid, 0);
		}
	}
	
	return 1;
}

public KillVehicle(vehicleid, checkplayer)
{
	if(checkplayer == 0)
	{
    	DestroyVehicle(vehicleid);
    	KillTimer(Timer[vehicleid]);
	}
	else
	{
	    for(new i = 0; i <= MAX_PLAYERS; i++)
	    {
	    	if(!IsPlayerInVehicle(i, vehicleid))
	    	{
		    	DestroyVehicle(vehicleid);
		    	KillTimer(Timer[vehicleid]);
	    	}
		}
	}
}

public OnVehicleSpawn(vehicleid)
{
	for(new i = 0; i <= sizeof(Vehicle); i++)
	{
	    if(vehicleid == Vehicle[i])
		{
		    DestroyVehicle(vehicleid);
		}
	}
}

public OnFilterScriptExit()
{
	for(new i = 0; i <= sizeof(Vehicle); i++)
	{
	    DestroyVehicle(Vehicle[i]);
	}
	
	DestroyMenu(MainMenu);
	DestroyMenu(Bicycles);
	DestroyMenu(Bikes);
	DestroyMenu(Monsters);
	DestroyMenu(Boats);
	DestroyMenu(Helis);
	DestroyMenu(Planes);
	DestroyMenu(Cars);
	DestroyMenu(Lowriders);
	DestroyMenu(Streets);
	DestroyMenu(Muscles);
	DestroyMenu(SuvWagon);
	DestroyMenu(Sports);
	DestroyMenu(ReCreated);
	DestroyMenu(Govern);
	DestroyMenu(RC);
	DestroyMenu(Luxury4);
	DestroyMenu(Luxury4_2);
	DestroyMenu(TwoDoor);
	DestroyMenu(TwoDoor2);
	DestroyMenu(Heavy);
	DestroyMenu(Heavy2);
	DestroyMenu(Light);
	DestroyMenu(Light2);
	
	return 1;
}
