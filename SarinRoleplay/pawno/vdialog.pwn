#include <a_samp>

//#define IGNORE_WARP_INTO_VEHICLE
//#define IGNORE_VIRTUAL_WORLDS
//#define IGNORE_SPAWN_MESSAGES
//#define IGNORE_VEHICLE_ACTIVATION
//#define IGNORE_VEHICLE_DELETION

#define DEFAULT_RESPAWN_TIME        600 /* ten minutes */

#if !defined IGNORE_VEHICLE_DELETION
	new
	    bool:gDialogCreated[ MAX_VEHICLES ] = { false, ... };
#endif

CreatePlayerVehicle( playerid, modelid )
{
	new
	    vehicle,
		Float:x,
		Float:y,
		Float:z,
		Float:angle;

	if ( GetPlayerState( playerid ) == PLAYER_STATE_DRIVER )
	{
	    vehicle = GetPlayerVehicleID( playerid );
	    GetVehiclePos( vehicle, x, y, z );
	    GetVehicleZAngle( vehicle, angle );
	    DestroyVehicle( vehicle );
	}
	else
	{
		GetPlayerPos( playerid, x, y, z );
		GetPlayerFacingAngle( playerid, angle );
	}
	vehicle = CreateVehicle( modelid, x, y, ( z + 1 ), angle, -1, -1, DEFAULT_RESPAWN_TIME );
	LinkVehicleToInterior( vehicle, GetPlayerInterior( playerid ) );
	#if !defined IGNORE_VIRTUAL_WORLDS
		SetVehicleVirtualWorld( vehicle, GetPlayerVirtualWorld( playerid ) );
	#endif
	#if !defined IGNORE_WARP_INTO_VEHICLE
		PutPlayerInVehicle( playerid, vehicle, 0 );
	#endif
	#if !defined IGNORE_VEHICLE_DELETION
		gDialogCreated[ vehicle ] = true;
	#endif
	return 1;
}

ShowPlayerDefaultDialog( playerid )
{
	ShowPlayerDialog( playerid, 3434, DIALOG_STYLE_LIST, "Vehicle Types", "Airplanes\nHelicopters\nBikes\nConvertibles\nIndustrial\nLowriders\nOff Road\nPublic Service Vehicles\nSaloons\nSport Vehicles\nStation Wagons\nBoats\nTrailers\nUnique Vehicles\nRC Vehicles", "Select", "Cancel" );
	return 1;
}

public OnFilterScriptInit()
{
	printf( "   * vDialog version 0.2a loaded *		" );
	return 1;
}

public OnFilterScriptExit()
{
	printf( "   * vDialog version 0.2a unloaded *		" );
	return 1;
}

public OnPlayerSpawn( playerid )
{
	#if !defined IGNORE_SPAWN_MESSAGES
		SendClientMessage( playerid, 0xFFFFFFFF, "[vDialog]: Use the command '/vdialog' to activate the vehicle dialog" );
	#endif

	return 1;
}

public OnPlayerCommandText( playerid, cmdtext[] )
{
	if ( strcmp( cmdtext, "/vdialog", true, 8 ) == 0 )
	{
	    if ( GetPlayerState( playerid ) == PLAYER_STATE_DRIVER )
	    {
			#if !defined IGNORE_VEHICLE_ACTIVATION
	    		ShowPlayerDefaultDialog( playerid );
	    		return 1;
			#endif
		}

		if ( GetPlayerState( playerid ) != PLAYER_STATE_PASSENGER ) ShowPlayerDefaultDialog( playerid );
	    return 1;
	}
	return 0;
}

public OnVehicleSpawn( vehicleid )
{
	#if !defined IGNORE_VEHICLE_DELETION
    	if ( gDialogCreated[ vehicleid ] )
	    {
    	    DestroyVehicle( vehicleid );
        	gDialogCreated[ vehicleid ] = false;
	    }
	#endif
	return 1;
}

public OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] )
{
	if ( response )
	{
		switch ( dialogid )
		{
			case 3434 :
			{
		    	switch ( listitem )
				{
					case 0 : ShowPlayerDialog( playerid, 3435, DIALOG_STYLE_LIST, "Airplanes", "Andromada\nAT-400\nBeagle\nCropduster\nDodo\nHydra\nNevada\nRustler\nShamal\nSkimmer\nStuntplane\nBack", "Select", "Cancel" );
					case 1 : ShowPlayerDialog( playerid, 3436, DIALOG_STYLE_LIST, "Helicopters", "Cargobob\nHunter\nLeviathan\nMaverick\nNews Maverick\nPolice Maverick\nRaindance\nSeasparrow\nSparrow\nBack", "Select", "Cancel" );
					case 2 : ShowPlayerDialog( playerid, 3437, DIALOG_STYLE_LIST, "Bikes", "BF-400\nBike\nBMX\nFaggio\nFCR-900\nFreeway\nMountain Bike\nNRG-500\nPCJ-600\nPizzaboy\nQuad\nSanchez\nWayfarer\nBack", "Select", "Cancel" );
					case 3 : ShowPlayerDialog( playerid, 3438, DIALOG_STYLE_LIST, "Convertibles", "Comet\nFeltzer\nStallion\nWindsor\nBack", "Select", "Cancel" );
					case 4 : ShowPlayerDialog( playerid, 3439, DIALOG_STYLE_LIST, "Industrial", "Benson\nBobcat\nBurrito\nBoxville\nBoxburg\nCement Truck\nDFT-30\nFlatbed\nLinerunner\nMule\nNewsvan\nPacker\nPetrol Tanker\nPony\nRoadtrain\nRumpo\nSadler\nSadler Shit\nTopfun\nTractor\nTrashmaster\nUtility Van\nWalton\nYankee\nYosemite\nBack", "Select", "Cancel" );
					case 5 : ShowPlayerDialog( playerid, 3440, DIALOG_STYLE_LIST, "Lowriders", "Blade\nBroadway\nRemington\nSavanna\nSlamvan\nTahoma\nTornado\nVoodoo\nBack", "Select", "Cancel" );
					case 6 : ShowPlayerDialog( playerid, 3441, DIALOG_STYLE_LIST, "Off Road", "Bandito\nBF Injection\nDune\nHuntley\nLandstalker\nMesa\nMonster\nMonster A\nMonster B\nPatriot\nRancher A\nRancher B\nSandking\nBack", "Select", "Cancel" );
					case 7 : ShowPlayerDialog( playerid, 3442, DIALOG_STYLE_LIST, "Public Service Vehicles", "Ambulance\nBarracks\nBus\nCabbie\nCoach\nCop Bike (HPV-1000)\nEnforcer\nFBI Rancher\nFBI Truck\nFiretruck\nFiretruck LA\nPolice Car (LSPD)\nPolice Car (LVPD)\nPolice Car (SFPD)\nRanger\nRhino\nS.W.A.T\nTaxi\nBack", "Select", "Cancel" );
					case 8 : ShowPlayerDialog( playerid, 3443, DIALOG_STYLE_LIST, "Saloons", "Admiral\nBloodring Banger\nBravura\nBuccaneer\nCadrona\nClover\nElegant\nElegy\nEmperor\nEsperanto\nFortune\nGlendale Shit\nGlendale\nGreenwood\nHermes\nIntruder\nMajestic\nManana\nMerit\nNebula\nOceanic\nPicador\nPremier\nPrevion\nPrimo\nSentinel\nStafford\nSultan\nSunrise\nTampa\nVincent\nVirgo\nWillard\nWashington\nBack", "Select", "Cancel" );
					case 9 : ShowPlayerDialog( playerid, 3444, DIALOG_STYLE_LIST, "Sport Vehicles", "Alpha\nBanshee\nBlista Compact\nBuffalo\nBullet\nCheetah\nClub\nEuros\nFlash\nHotring Racer\nHotring Racer A\nHotring Racer B\nInfernus\nJester\nPhoenix\nSabre\nSuper GT\nTurismo\nUranus\nZR-350\nBack", "Select", "Cancel" );
					case 10 : ShowPlayerDialog( playerid, 3445, DIALOG_STYLE_LIST, "Station Wagons", "Moonbeam\nPerenniel\nRegina\nSolair\nStratum\nBack", "Select", "Cancel" );
					case 11 : ShowPlayerDialog( playerid, 3446, DIALOG_STYLE_LIST, "Boats", "Coastguard\nDinghy\nJetmax\nLaunch\nMarquis\nPredator\nReefer\nSpeeder\nSquallo\nTropic\nBack", "Select", "Cancel" );
					case 12 : ShowPlayerDialog( playerid, 3447, DIALOG_STYLE_LIST, "Trailers", "Article Trailer\nArticle Trailer 2\nArticle Trailer 3\nBaggage Trailer A\nBaggage Trailer B\nFarm Trailer\nFreight Flat Trailer (Train)\nFreight Box Trailer (Train)\nPetrol Trailer\nStreak Trailer (Train)\nStairs Trailer\nUtility Trailer\nBack", "Select", "Cancel" );
					case 13 : ShowPlayerDialog( playerid, 3448, DIALOG_STYLE_LIST, "Unique Vehicles", "Baggage\nBrownstreak (Train)\nCaddy\nCamper\nCamper A\nCombine Harvester\nDozer\nDumper\nForklift\nFreight (Train)\nHotknife\nHustler\nHotdog\nKart\nMower\nMr Whoopee\nRomero\nSecuricar\nStretch\nSweeper\nTram\nTowtruck\nTug\nVortex\nBack", "Select", "Cancel" );
					case 14 : ShowPlayerDialog( playerid, 3449, DIALOG_STYLE_LIST, "RC Vehicles", "RC Bandit\nRC Baron\nRC Raider\nRC Goblin\nRC Tiger\nRC Cam\nBack", "Select", "Cancel" );
				}
			}
			case 3435 :
			{
				if ( listitem > 10 ) return ShowPlayerDefaultDialog( playerid );
			
   				new
      				model_array[] = { 592, 577, 511, 512, 593, 520, 553, 476, 519, 460, 513 };
		            
				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3436 :
			{
				if ( listitem > 8 ) return ShowPlayerDefaultDialog( playerid );

		        new
	    	        model_array[] = { 548, 425, 417, 487, 488, 497, 563, 447, 469 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3437 :
			{
				if ( listitem > 12 ) return ShowPlayerDefaultDialog( playerid );

				new
   					model_array[] = { 581, 509, 481, 462, 521, 463, 510, 522, 461, 448, 471, 468, 586 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3438 :
			{
				if ( listitem > 3 ) return ShowPlayerDefaultDialog( playerid );
			
   				new
					model_array[] = { 480, 533, 439, 555 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3439 :
			{
				if ( listitem > 24 ) return ShowPlayerDefaultDialog( playerid );

				new
			        model_array[] = { 499, 422, 482, 498, 609, 524, 578, 455, 403, 414, 582, 443, 514, 413, 515, 440, 543, 605, 459, 531, 408, 552, 478, 456, 554 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3440 :
			{
				if ( listitem > 7 ) return ShowPlayerDefaultDialog( playerid );

		        new
		            model_array[] = { 536, 575, 534, 567, 535, 566, 576, 412 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3441 :
			{
				if ( listitem > 12 ) return ShowPlayerDefaultDialog( playerid );
				
    			new
		    	    model_array[] = { 568, 424, 573, 579, 400, 500, 444, 556, 557, 470, 489, 505, 495 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3442 :
			{
				if ( listitem > 17 ) return ShowPlayerDefaultDialog( playerid );

				new
			        model_array[] = { 416, 433, 431, 438, 437, 523, 427, 490, 528, 407, 544, 596, 598, 597, 599, 432, 601, 420 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3443 :
			{
				if ( listitem > 33 ) return ShowPlayerDefaultDialog( playerid );
			
			    new
	        	    model_array[] = { 445, 504, 401, 518, 527, 542, 507, 562, 585, 419, 526, 604, 466, 492, 474, 546, 517, 410, 551, 516, 467, 600, 426, 436, 547, 405, 580, 560, 550, 549, 540, 491, 529, 421 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3444 :
			{
				if ( listitem > 19 ) return ShowPlayerDefaultDialog( playerid );
				
    			new
	        	    model_array[] = { 602, 429, 496, 402, 541, 415, 589, 587, 565, 494, 502, 503, 411, 559, 603, 475, 506, 451, 558, 477 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3445 :
			{
				if ( listitem > 4 ) return ShowPlayerDefaultDialog( playerid );

				new
			        model_array[] = { 418, 404, 479, 458, 561 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3446 :
			{
				if ( listitem > 9 ) return ShowPlayerDefaultDialog( playerid );
				
	    	    new
	        	    model_array[] = { 472, 473, 493, 595, 484, 430, 453, 452, 446, 454 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3447 :
			{
				if ( listitem > 11 ) return ShowPlayerDefaultDialog( playerid );

		        new
		            model_array[] = { 435, 450, 591, 606, 607, 610, 569, 590, 584, 570, 608, 611 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3448 :
			{
				if ( listitem > 23 ) return ShowPlayerDefaultDialog( playerid );
				
	    	    new
	        	    model_array[] = { 485, 537, 457, 483, 508, 532, 486, 406, 530, 538, 434, 545, 588, 571, 572, 423, 442, 428, 409, 574, 449, 525, 583, 539 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
			case 3449 :
			{
				if ( listitem > 5 ) return ShowPlayerDefaultDialog( playerid );
			
	    	    new
	        	    model_array[] = { 441, 464, 465, 501, 564, 594 };

				return CreatePlayerVehicle( playerid, model_array[ listitem ] );
			}
		}
	}
	return 0;
}
