/*
									     ____   ____     .__    .__       .__
									_____\   \ /   /____ |  |__ |__| ____ |  |   ____
									\____ \   Y   // __ \|  |  \|  |/ ___\|  | _/ __ \
									|  |_> >     /\  ___/|   Y  \  \  \___|  |_\  ___/
									|   __/ \___/  \___  >___|  /__|\___  >____/\___  >
									|__|               \/     \/        \/          \/
								Version 1.1                        		     By:Gamer931215

	pVehicle:

		->About:
		    In 2010 i've made an private vehicle system called "Gamer's Private Vehicle System",
		    it was a pretty good script, but unfortunately it supported only up to 1 car per player.

		    I've been inactive at the SA-MP forums now for arround 6 months, and i decided to comeback
		    with a private vehicle system. Thats why i've made this.

		->Commands:
		    /pvehicle	  				Manage your private vehicles (outside vehicle: all vehicles, inside vehicle:per vehicle.)
		    /addpvehicle [playerid]		[RCON COMMAND] Allow that player to manage personal vehicles (only if PVEHICLE_FOR_EVERYONE is defined false)
		    /delpvehicle [playerid]     [RCON COMMAND] Disable managing personal vehicles for player and removes all his/her vehicles

		->Credits:
		    Dracoblue for DCMD	(Fast Command Processing)
		    Y_Less for sscanf2	(Fast String Unformatting)
		    Y_Less for Y_INI    (Fast file writing/reading)

		    Garsino[12] for his house system, that gave me actually the inspiration to make this.
		    Hiddos for helping me testing this and finding a few bugs
		    Myself, Gamer931215 A.K.A. Gamer for making this.

		->Changelog:
			- Cleaned all clientmessages a bit up, adding pVegicle -> in front of them (i forgot to add it to some client msg's)
			- Using Y_INI for saving/reading data (MUCH MUCH FASTER!)
			- Added a heavy vehicle filter
			- Added anti-deathmatch filter (if you want to allow hydras as example, but dont want them to be used to deathmatch with)
		->Copyright:
		    Feel free to use/share this as long you leave the credits .
			Do not clame this script as your own, or mirror/re-release it somewhere else without my permision
			However if you just want to use some functions of this system, feel free to use them for yourself (but please put some credits for it to me).
			(C)2010-2011
*/
#include <a_samp>
#include <YSI\y_ini>
#include <YSI\y_stringhash>
#include <sscanf2>
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define color_orange 0xFFCC00FF
#define color_red 0xFF0A00FF
/*-------------------------------------------Settings---------------------------------------------*/
#define MAX_LOADED_VEHICLES 			50				//Maximum loaded vehicles
#define MAX_VEHICLES_PER_PLAYER 		3				//Max vehicles per player
#define ALLOW_ARMED_VEHICLES	     	true			//If its set on false, players will not be able to spawn rhino's,rustler's,Hydra's,Seasparrow's and hunters
#define KILL_PLAYER_ON_FIRE				true			//If its set on true, the player AND vehicle will get exploded (anti deathmatch)
#define PVEHICLE_FOR_EVERYONE 			false			//true = personal vehicles for everyone, false = only with permision from rcon admin (/addpvehicle [playerid])
#define USE_AIR_DROP_FOR_SPAWN      	false			//Will drop the vehicle at your position from the andromada instead of just spawning it there
#define USE_AIR_DROP_FOR_TRANSPORT  	true			//Will drop the vehicle at your position from the andromada instead of just spawning it there
#define PRINT_DEBUG_IN_CONSOLE      	true			//Will write messages when players are creating/editing and lending/returning there vehicles
#define DIALOG_RANGE 					245				//DialogID starts with 0-6 (E.X. 344-350)
//DO NOT CHANGE THESE
#define in_vehicle_menu DIALOG_RANGE
#define lend_vehicle DIALOG_RANGE +1
#define pick_color_1 DIALOG_RANGE +2
#define pick_color_2 DIALOG_RANGE +3
#define set_number_plate DIALOG_RANGE +4
#define out_vehicle_menu DIALOG_RANGE +5
#define spawn_vehicle DIALOG_RANGE +6
/*---------------------------------------All-Vehicle-Names-----------------------------------------*/
enum vehicle_names_info
{
		 Name[24],
		 Model
}
new aVehicleNames[212][vehicle_names_info] =
{
	{"Landstalker", 400},
	{"Bravura", 401},
	{"Buffalo", 402},
	{"Linerunner", 403},
	{"Perrenial", 404},
	{"Sentinel", 405},
	{"Dumper", 406},
	{"Firetruck", 407},
	{"Trashmaster", 408},
	{"Stretch", 409},
	{"Manana", 410},
	{"Infernus", 411},
	{"Voodoo", 412},
	{"Pony", 413},
	{"Mule", 414},
	{"Cheetah", 415},
	{"Ambulance", 416},
	{"Leviathan", 417},
	{"Moonbeam", 418},
	{"Esperanto", 419},
	{"Taxi", 420},
	{"Washington", 421},
	{"Bobcat", 422},
	{"Mr Whoopee", 423},
	{"BF Injection", 424},
	{"Hunter", 425},
	{"Premier", 426},
	{"Enforcer", 427},
	{"Securivehicle", 428},
	{"Banshee", 429},
	{"Predator", 430},
	{"Bus", 431},
	{"Rhino", 432},
	{"Barracks", 433},
	{"Hotknife", 434},
	{"Trailer 1", 435},
	{"Previon", 436},
	{"Coach", 437},
	{"Cabbie", 438},
	{"Stallion", 439},
	{"Rumpo", 440},
	{"RC Bandit", 441},
	{"Romero", 442},
	{"Packer", 443},
	{"Monster", 444},
	{"Admiral", 445},
	{"Squalo", 446},
	{"Seasparrow", 447},
	{"Pizzaboy", 448},
	{"Tram", 449},
	{"Trailer 2", 450},
	{"Turismo", 451},
	{"Speeder", 452},
	{"Reefer", 453},
	{"Tropic", 454},
	{"Flatbed", 455},
	{"Yankee", 456},
	{"Caddy", 457},
	{"Solair", 458},
	{"Berkley's RC Van", 459},
	{"Skimmer", 460},
	{"PCJ-600", 461},
	{"Faggio", 462},
	{"Freeway", 463},
	{"RC Baron", 464},
	{"RC Raider", 465},
	{"Glendale", 466},
	{"Oceanic", 467},
	{"Sanchez", 468},
	{"Sparrow", 469},
	{"Patriot", 470},
	{"Quad", 471},
	{"Coastguard", 472},
	{"Dinghy", 473},
	{"Hermes", 474},
	{"Sabre", 475},
	{"Rustler", 476},
	{"ZR-350", 477},
	{"Walton", 478},
	{"Regina", 479},
	{"Comet", 480},
	{"BMX", 481},
	{"Burrito", 482},
	{"Camper", 483},
	{"Marquis", 484},
	{"Baggage", 485},
	{"Dozer", 486},
	{"Maverick", 487},
	{"News Chopper", 488},
	{"Rancher", 489},
	{"FBI Rancher", 490},
	{"Virgo", 491},
	{"Greenwood", 492},
	{"Jetmax", 493},
	{"Hotring", 494},
	{"Sandking", 495},
	{"Blista Compact", 496},
	{"Police Maverick", 497},
	{"Boxville", 498},
	{"Benson", 499},
	{"Mesa", 500},
	{"RC Goblin", 501},
	{"Hotring Racer A", 502},
	{"Hotring Racer B", 503},
	{"Bloodring Banger", 504},
	{"Rancher", 505},
	{"Super GT", 506},
	{"Elegant", 507},
	{"Journey", 508},
	{"Bike", 509},
	{"Mountain Bike", 510},
	{"Beagle", 511},
	{"Cropdust", 512},
	{"Stunt", 513},
	{"Tanker", 514},
	{"Roadtrain", 515},
	{"Nebula", 516},
	{"Majestic", 517},
	{"Buccaneer", 518},
	{"Shamal", 519},
	{"Hydra", 520},
	{"FCR-900", 521},
	{"NRG-500", 522},
	{"HPV1000", 523},
	{"Cement Truck", 524},
	{"Tow Truck", 525},
	{"Fortune", 526},
	{"Cadrona", 527},
	{"FBI Truck", 528},
	{"Willard", 529},
	{"Forklift", 530},
	{"Tractor", 531},
	{"Combine", 532},
	{"Feltzer", 533},
	{"Remington", 534},
	{"Slamvan", 535},
	{"Blade", 536},
	{"Freight", 537},
	{"Streak", 538},
	{"Vortex", 539},
	{"Vincent", 540},
	{"Bullet", 541},
	{"Clover", 542},
	{"Sadler", 543},
	{"Firetruck LA", 544},
	{"Hustler", 545},
	{"Intruder", 546},
	{"Primo", 547},
	{"vehiclegobob", 548},
	{"Tampa", 549},
	{"Sunrise", 550},
	{"Merit", 551},
	{"Utility", 552},
	{"Nevada", 553},
	{"Yosemite", 554},
	{"Windsor", 555},
	{"Monster A", 556},
	{"Monster B", 557},
	{"Uranus", 558},
	{"Jester", 559},
	{"Sultan", 560},
	{"Stratum", 561},
	{"Elegy", 562},
	{"Raindance", 563},
	{"RC Tiger", 564},
	{"Flash", 565},
	{"Tahoma", 566},
	{"Savanna", 567},
	{"Bandito", 568},
	{"Freight Flat", 569},
	{"Streak vehicleriage", 570},
	{"Kart", 571},
	{"Mower", 572},
	{"Duneride", 573},
	{"Sweeper", 574},
	{"Broadway", 575},
	{"Tornado", 576},
	{"AT-400", 577},
	{"DFT-30", 578},
	{"Huntley", 579},
	{"Stafford", 580},
	{"BF-581", 581},
	{"Newsvan", 582},
	{"Tug", 583},
	{"Trailer 3", 584},
	{"Emperor", 585},
	{"Wayfarer", 586},
	{"Euros", 587},
	{"Hotdog", 588},
	{"Club", 589},
	{"Freight vehicleriage", 590},
	{"Trailer 3", 591},
	{"Andromada", 592},
	{"Dodo", 593},
	{"RC Cam", 594},
	{"Launch", 595},
	{"Police vehicle (LSPD)", 596},
	{"Police vehicle (SFPD)", 597},
	{"Police vehicle (LVPD)", 598},
	{"Police Ranger", 599},
	{"Picador", 600},
	{"S.W.A.T. Van", 601},
	{"Alpha", 602},
	{"Phoenix", 603},
	{"Glendale", 604},
	{"Sadler", 605},
	{"Luggage Trailer A", 606},
	{"Luggage Trailer B", 607},
	{"Stair Trailer", 608},
	{"Boxville", 609},
	{"Farm Plow", 610},
	{"Utility Trailer", 611}
};
/*-----------------------------------------Enums/Strings------------------------------------------*/
//DO NOT CHANGE!
enum gVehicleInfo
{
	Id,
	Model,
	Float:X,
	Float:Y,
	Float:Z,
	Float:Rot,
	Color1,
	Color2,
	Plate[32],
	Owner[MAX_PLAYER_NAME],
	Lender
}
new VehicleInfo[MAX_LOADED_VEHICLES][gVehicleInfo];
new loaded_vehicles = 1;
new transport_marker[MAX_PLAYERS] = -1;
new shipping[MAX_PLAYERS];
/*--------------------------------------------Commands----------------------------------------------*/
public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(Pvehicle,8,cmdtext);
	dcmd(addPvehicle,11,cmdtext);
	dcmd(delPvehicle,11,cmdtext);
	return 0;
}
dcmd_addPvehicle(playerid,params[])
{
    #if PVEHICLE_FOR_EVERYONE == false
		if(!IsPlayerAdmin(playerid)) return 0;
		new ID,pName[MAX_PLAYER_NAME],string[92];
		if(sscanf(params,"u",ID)) return SendClientMessage(playerid,color_orange,"pVehicle -> {FFFFFF}Please use '/addPVehicle [playerid]'");
		if(!IsPlayerConnected(ID)) return SendClientMessage(playerid,color_red,"pVehicle -> Invalid playerid");
		GetPlayerName(ID,pName,sizeof(pName));
		format(string,sizeof(string),"/PrivateVehicles/Users/%s.ini",pName);
		if(fexist(string))
		{
	        SendClientMessage(playerid,color_red,"pVehicle -> This player has already a profile.'");
		} else {
		    new File:handler = fopen(string, io_write);
			fclose(handler);
			SendClientMessage(playerid,color_orange,"pVehicle -> {FFFFFF}You have succesfully attached a profile to the player.");
			SendClientMessage(ID,color_orange,"pVehicle -> {FFFFFF}You are now allowed to have private vehicles. use /PVehicle to create them.");
			#if PRINT_DEBUG_IN_CONSOLE == true
				new pName2[MAX_PLAYER_NAME];GetPlayerName(playerid,pName2,sizeof pName2);printf("pVehicle -> <<Admin>> %s has assigned %s a pvehicle profile.",pName2,pName);
			#endif
		}
	#else
	    #pragma unused params
	    #pragma unused playerid
	#endif
	return 1;
}
dcmd_delPvehicle(playerid,params[])
{
	if(!IsPlayerAdmin(playerid)) return 0;
	new ID,pName[MAX_PLAYER_NAME],string[92];
	if(sscanf(params,"u",ID)) return SendClientMessage(playerid,color_orange,"pVehicle -> {FFFFFF}Please use '/delPVehicle [playerid]'");
	if(!IsPlayerConnected(ID)) return SendClientMessage(playerid,color_red,"pVehicle -> Invalid playerid");
	GetPlayerName(ID,pName,sizeof(pName));
	format(string,sizeof(string),"/PrivateVehicles/Users/%s.ini",pName);
	if(!fexist(string))
	{
        SendClientMessage(playerid,color_red,"pVehicle -> This player doesnt have a profile.");
	} else {
	    fremove(string);
		for(new i = 0;i<loaded_vehicles;i++)
		{
		    if(strcmp(VehicleInfo[i][Owner],pName) == 0)
		    {
		        new empty;
		        DestroyVehicle(VehicleInfo[i][Id]);
		        VehicleInfo[i][Id] = empty;VehicleInfo[i][Model] = empty;VehicleInfo[i][X] = empty;VehicleInfo[i][Id] = empty;VehicleInfo[i][Y] = empty;VehicleInfo[i][Id] = empty;VehicleInfo[i][Z] = empty;VehicleInfo[i][Rot] = empty;VehicleInfo[i][Color1] = empty;VehicleInfo[i][Color2] = empty;VehicleInfo[i][Lender] = -1;
		        format(string,sizeof string,"/PrivateVehicles/Vehicles/%i.ini",i);
		  		SendClientMessage(ID,color_red,"pVehicle -> {FFFFFF}You have no longer rights to own private vehicles.");
		        fremove(string);
		    }
		}
		SendClientMessage(playerid,color_orange,"pVehicle -> {FFFFFF}You have succesfully deleted the PVehicle profile/vehicles.");
		#if PRINT_DEBUG_IN_CONSOLE == true
			new pName2[MAX_PLAYER_NAME];GetPlayerName(playerid,pName2,sizeof pName2);printf("pVehicle -> <<Admin>> %s has removed %s a pvehicle profile.",pName2,pName);
		#endif
	}
	return 1;
}
dcmd_Pvehicle(playerid,params[])
{
	new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pName,sizeof(pName));
	#pragma unused params
	#if PVEHICLE_FOR_EVERYONE == false
		new string[96];format(string,sizeof(string),"/PrivateVehicles/Users/%s.ini",pName);
		if(!fexist(string)) return SendClientMessage(playerid,color_red,"pVehicle -> You have no access to private vehicles.");
	#endif
	if(IsPlayerInAnyVehicle(playerid))
	{
		if(!strcmp(VehicleInfo[VIDTOPID(GetPlayerVehicleID(playerid))][Owner],pName) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
		    /*
		            Colors:
		            yellow      {EBFF00}
		            orange      {FF6400}
		            red         {FF1400}
 		            lightgreen  {19FF00}
		            green		{7DFF00}
		    */
		    return ShowPlayerDialog(playerid,in_vehicle_menu,2,"{19FF00}Main {FF1400}Private Vehicle {19FF00}Menu","Change color\nAttach nitro\nFlip vehicle\nRepair vehicle\n{FF6400}Change vehicle numberplate\n{FF6400}Lend vehicle to player\n{FF6400}Save current parking spot\n{EBFF00}What is my PVehicleID?\n{FF6400}Attach transport marker {FF1400}(Mark for transport)\n{FF1400}Remove private vehicle","OK","Cancel");
		} else return SendClientMessage(playerid,color_red,"pVehicle -> Your not driving a {FFFFFF}private vehicle.{FF1400} if you want to create one, please step out and try {FFFFFF}/pvehicle");
	} else return ShowPlayerDialog(playerid,out_vehicle_menu,2,"{19FF00}Main {FF1400}Private Vehicle {19FF00}Menu","Add a vehicle\n{EBFF00}Deliver your {FF1400}MARKED{EBFF00} vehicle at your current location\n{FF6400}Return all your lended vehicles\n{FF6400}Respawn all your vehicles\n{FF1400}Remove all your vehicles","OK","Cancel");
}
/*------------------------------------------Other-Pawn-------------------------------------------*/
public OnFilterScriptInit()
{
	print("--------------------------------------------");
	print("|                                          |");
	print("|   pVehicle -> Private Vehicle System     |");
	print("|         (C)Copyright 2010-2011           |");
	print("|             By Gamer931215               |");
	print("|                                          |");
	print("--------------------------------------------");
	print("pVehicle -> Initializing...");
	LoadVehicles();
	printf("pVehicle -> pVehicle succesfully initialized. (%i vehicles loaded)",loaded_vehicles -1);
	return 1;
}
public OnFilterScriptExit()
{
	print("--------------------------------------------");
	print("|                                          |");
	print("|   pVehicle -> Private Vehicle System     |");
	print("|         (C)Copyright 2010-2011           |");
	print("|             By Gamer931215               |");
	print("|                                          |");
	print("--------------------------------------------");
    print("pVehicle -> Removing vehicles...");
	RemoveVehicles();
	print("All vehicles were succesfully removed from the map.");
	return 1;
}
public OnPlayerConnect(playerid)
{
    transport_marker[playerid] = -1;
	return 1;
}
public OnPlayerDisconnect(playerid)
{
    transport_marker[playerid] = -1;
    for(new i = 0;i<MAX_LOADED_VEHICLES;i++)
    {
        if(VehicleInfo[i][Lender] == playerid)
        {
            VehicleInfo[i][Lender] = -1;
        }
    }
	return 1;
}
#if KILL_PLAYER_ON_FIRE	== true
	public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
	{
	    new veh = GetPlayerVehicleID(playerid);
	    if(!IsVehicleArmed(veh)) return 1;
		if(IsPlayerInAnyVehicle(playerid) && IsVehiclePrivate(veh))
		{
			if (PRESSED(KEY_FIRE))
			{
			    SetVehicleHealth(veh,0);
			    SetPlayerHealth(playerid,0.0);
			    SendClientMessage(playerid,color_red,"pVehicle -> You are not allowed to deathmatch in this vehicle!");
			}
		}
		return 1;
	}
#endif
public OnPlayerStateChange(playerid,newstate,oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    new veh = GetPlayerVehicleID(playerid);
	    if(IsVehiclePrivate(veh))
	    {
			new pName[MAX_PLAYER_NAME];GetPlayerName(playerid,pName,sizeof(pName));
			if(strcmp(pName,VehicleInfo[VIDTOPID(veh)][Owner],true) && VehicleInfo[VIDTOPID(veh)][Lender] != playerid)
			{
			    new engine, lights, alarm, doors, bonnet, boot, objective;
			    GetVehicleParamsEx(veh, engine, lights, alarm, doors, bonnet, boot, objective);
			    SetVehicleParamsEx(veh, engine, lights, true, doors, bonnet, boot, objective);

				SetTimerEx("Disable_Vehicle_Alarm",10000,false,"i",veh);
	            RemovePlayerFromVehicle(playerid);
	            new string[128];
	            format(string,sizeof string,"You have no access to this vehicle, this vehicle is private and belongs to %s.", VehicleInfo[VIDTOPID(veh)][Owner]);
				SendClientMessage(playerid,color_orange,string);
			}
	    }
	}
	return 0;
}
//disable alarm
forward Disable_Vehicle_Alarm(vehicleid);
public Disable_Vehicle_Alarm(vehicleid)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, lights, false, doors, bonnet, boot, objective);
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == out_vehicle_menu) //out vehicle menu
	{
	    if(response)
	    {
	        switch(listitem)
	        {
	            case 0:
	            {
	                ShowPlayerDialog(playerid,spawn_vehicle,1,"Create private vehicle","Please enter a vehiclename to spawn","Spawn","Cancel");
	            }
	            case 1:
	            {
	                if(shipping[playerid] == 1 || transport_marker[playerid] < 0) return SendClientMessage(playerid,color_red,"pVehicle -> You cant transport your vehicle. Please check if you have currently no active transports, and if you have marked your vehicle.");
					shipping[playerid] = 1;
					SendClientMessage(playerid,color_orange,"pVehicle -> {FFFFFF}Your vehicle is on its way.");
					#if USE_AIR_DROP_FOR_TRANSPORT == true
						Transport_Vehicle(playerid,transport_marker[playerid]);
					#else
					    new Float:x,Float:y,Float:z;
					    GetPlayerPos(playerid,x,y,z);
						SetVehiclePos(transport_marker[playerid],x+3,y+3,z);
					#endif
					new pName[MAX_PLAYER_NAME];GetPlayerName(playerid,pName,sizeof pName);
					#if PRINT_DEBUG_IN_CONSOLE == true
						printf("pVehicle -> %s has transported a private vehicle.",pName);
					#endif
	            }
	            case 2:
	            {
	                Return_All_Lended_Vehicles(playerid);
	            }
	            case 3:
	            {
				    new pName[MAX_PLAYER_NAME];GetPlayerName(playerid,pName,sizeof pName);
					for(new i = 0;i<MAX_LOADED_VEHICLES;i++)
					{
					    if(!strcmp(VehicleInfo[i][Owner],pName))
					    {
					        DestroyVehicle(VehicleInfo[i][Id]);
                            VehicleInfo[i][Id] = AddStaticVehicle(VehicleInfo[i][Model],VehicleInfo[i][X],VehicleInfo[i][Y],VehicleInfo[i][Z],VehicleInfo[i][Rot],VehicleInfo[i][Color1],VehicleInfo[i][Color2]);
					    }
					}
					SendClientMessage(playerid,color_orange,"pVehicle -> {FFFFFF}All your vehicles have succesfully been respawned.");
					#if PRINT_DEBUG_IN_CONSOLE == true
						printf("pVehicle -> %s has respawned his/her vehicles.",pName);
					#endif
	            }
				case 4:
				{
				    new string[96],pName[MAX_PLAYER_NAME];GetPlayerName(playerid,pName,sizeof pName);
					for(new i = 0;i<MAX_LOADED_VEHICLES;i++)
					{
					    if(strcmp(VehicleInfo[i][Owner],pName) == 0)
					    {
							if(transport_marker[playerid] == VehicleInfo[i][Id]) { transport_marker[playerid] = -1; }
					        new empty;
					        DestroyVehicle(VehicleInfo[i][Id]);
					        format(VehicleInfo[i][Owner],MAX_PLAYER_NAME,"%s",empty);
					        VehicleInfo[i][Id] = empty;
							VehicleInfo[i][Model] = empty;
							VehicleInfo[i][Lender] = -1;
					        format(string,sizeof string,"/PrivateVehicles/Vehicles/%i.ini",i);
					        loaded_vehicles--;
					        fremove(string);
					    }
					}
					SendClientMessage(playerid,color_orange,"pVehicle -> {FFFFFF}All your vehicles have succesfully been removed.");
					#if PRINT_DEBUG_IN_CONSOLE == true
						printf("pVehicle -> %s has removed all his/her private vehicles.",pName);
					#endif
				}
	        }
	    }
	}

	if(dialogid == spawn_vehicle) //out vehicle menu -> spawn vehicle
	{
	    if(response)
	    {
	        if(CountPlayerVehicles(playerid) +1 > MAX_VEHICLES_PER_PLAYER) return SendClientMessage(playerid,color_red,"pVehicle -> You've reached the max ammount of private vehicles.");
	        if(!strlen(inputtext)) return SendClientMessage(playerid,color_red,"pVehicle -> No vehicle name entered.");
	        new model = 0;
			for(new i = 0; i<sizeof(aVehicleNames); i++)
			{
				if (!strcmp(inputtext, aVehicleNames[i][Name],true))
				{
					model = aVehicleNames[i][Model];
				}
		  	}
			if(model == 0) return SendClientMessage(playerid,color_red,"pVehicle -> No vehicle found with that specefic name.");
		 	#if ALLOW_ARMED_VEHICLES == false
		 	    if(IsVehicleArmed(model)) return SendClientMessage(playerid,color_red,"pVehicle -> Armed vehicles are not allowed to spawn!");
		 	#endif
			#if USE_AIR_DROP_FOR_SPAWN == true
			    if(shipping[playerid] == 1) return SendClientMessage(playerid,color_red,"pVehicle -> You cant transport your vehicle. Please check if you have currently no active transports, and if you have marked your vehicle.");
			#endif
			new Float:x,Float:y,Float:z;GetPlayerPos(playerid,x,y,z);
			AddVehicle(playerid,model,x,y,z,0,0,0);
			#if USE_AIR_DROP_FOR_SPAWN == false
				SendClientMessage(playerid,color_orange,"pVehicle -> {FFFFFF}Your vehicle has succesfully been spawned.");
			#else
			    SendClientMessage(playerid,color_orange,"pVehicle -> {FFFFFF}Your vehicle is on its way.");
			#endif
	    }
	}

	if(dialogid == in_vehicle_menu)//in vehicle menu
	{
	    if(response)
	    {
	        switch(listitem)
	        {
			    case 0:
			    {
			        ShowPlayerDialog(playerid,pick_color_1,1,"Please pick a color (Color 1)","Please fill in a valid colorID","Change","Cancel");
			    }
			    case 1:
			    {
			    	AddVehicleComponent(GetPlayerVehicleID(playerid),1010);
			        SendClientMessage(playerid,color_orange,"pVehicle -> {FFFFFF}Nitro added.");
			    }
			    case 2:
			    {
			        new Float:rot,veh=GetPlayerVehicleID(playerid);GetVehicleZAngle(veh,rot);
			        SetVehicleZAngle(veh,rot);
			        SendClientMessage(playerid,color_orange,"pVehicle -> {FFFFFF}Vehicle flipped.");
			    }
			    case 3:
			    {
			        RepairVehicle(GetPlayerVehicleID(playerid));
			        SendClientMessage(playerid,color_orange,"pVehicle -> {FFFFFF}Your vehicle has been repaired.");
			    }
			    case 4:
			    {
			        ShowPlayerDialog(playerid,set_number_plate,1,"Enter a new numberplate","Please enter here your new vehicle numberplate","Set","Cancel");
			    }
			    case 5:
			    {
			        ShowPlayerDialog(playerid,lend_vehicle,1,"Lend vehicle to player","Please enter a valid playerID to lend this vehicle to.","Lend","Cancel");
			    }
				case 6:
				{
				    new veh = GetPlayerVehicleID(playerid);
					new Float:x,Float:y,Float:z,Float:rot;
					GetVehiclePos(veh,x,y,z);
					GetVehicleZAngle(veh,rot);

					veh = VIDTOPID(veh);
					VehicleInfo[veh][X]= x;
					VehicleInfo[veh][Y]= y;
					VehicleInfo[veh][Z]= z;
					VehicleInfo[veh][Rot]= rot;

					SaveVehicle(veh);
					SendClientMessage(playerid,color_orange,"pVehicle -> {FFFFFF}Your vehicle position has been updated.");
					#if PRINT_DEBUG_IN_CONSOLE == true
						new pName[MAX_PLAYER_NAME];GetPlayerName(playerid,pName,sizeof pName);printf("pVehicle -> %s has updated the position of his/her private vehicle.",pName);
					#endif
				}
				case 7:
				{
				    new vid = VIDTOPID(GetPlayerVehicleID(playerid));
					new str[64];format(str,sizeof(str),"Your current PVehicle ID is: %i.",vid);
					SendClientMessage(playerid,color_orange,str);
				}
				case 8:
				{
				    new veh = GetPlayerVehicleID(playerid);
					if(!IsVehiclePrivate(veh)) return SendClientMessage(playerid,color_red,"pVehicle -> You are not in a private vehicle.");
				    transport_marker[playerid] = GetPlayerVehicleID(playerid);
				    SendClientMessage(playerid,color_orange,"pVehicle -> {FFFFFF}Your vehicle is now ready for transport.");
				}
				case 9:
				{
					new string[92],veh = GetPlayerVehicleID(playerid),empty;
					if(transport_marker[playerid] == VehicleInfo[VIDTOPID(veh)][Id]) {format(transport_marker[playerid],32,"%i","-1"); }
					format(string,sizeof string,"/PrivateVehicles/Vehicles/%i.ini",VIDTOPID(veh));
					if(!fexist(string)) return SendClientMessage(playerid,color_red,"pVehicle -> This vehicle is not private or not owned by you.");
					fremove(string);
					DestroyVehicle(veh);

					veh = VIDTOPID(veh);
					format(VehicleInfo[veh][Owner],MAX_PLAYER_NAME,"%s",empty);
     				VehicleInfo[veh][Id] = empty;
					VehicleInfo[veh][Model] = empty;
					VehicleInfo[veh][Lender] = -1;
					loaded_vehicles = loaded_vehicles -1;
					SendClientMessage(playerid,color_orange,"pVehicle -> {FFFFFF}Your vehicle has succesfully been removed.");
					#if PRINT_DEBUG_IN_CONSOLE == true
						new pName[MAX_PLAYER_NAME];GetPlayerName(playerid,pName,sizeof pName);printf("pVehicle -> %s has removed a private vehicle.",pName);
					#endif
				}
			}
		}
	}

	if(dialogid == lend_vehicle)
	{
	    if(response)
	    {
	        if(!strlen(inputtext)) return SendClientMessage(playerid,color_red,"pVehicle -> Lending aborted");
	        new id = strval(inputtext);if(id == playerid) return SendClientMessage(playerid,color_red,"pVehicle -> You cannot lend to yourself.");
	        new str[MAX_PLAYER_NAME];format(str,sizeof str,"%i",strval(inputtext));
			if(!IsPlayerConnected(id))return SendClientMessage(playerid,color_red,"pVehicle -> Invalid playerid");
			new string[96],lender[MAX_PLAYER_NAME],owner[MAX_PLAYER_NAME];
			GetPlayerName(id,lender,sizeof lender);GetPlayerName(playerid,owner,sizeof owner);

			Lend_Vehicle(VIDTOPID(GetPlayerVehicleID(playerid)),id);

			format(string,sizeof string,"You have succesfully lent %s your vehicle.",lender);
			SendClientMessage(playerid,color_orange,string);

			format(string,sizeof string,"%s has lent you his/her private vehicle.",owner);
			SendClientMessage(id,color_orange,string);
	    }
	}
	if(dialogid == set_number_plate)
	{
	    if(!strlen(inputtext)) return SendClientMessage(playerid,color_red,"pVehicle -> Changing numberplate aborted.");
	    new veh = GetPlayerVehicleID(playerid);format(VehicleInfo[VIDTOPID(veh)][Plate],32,"%s",inputtext);
	    new Float:x,Float:y,Float:z,Float:rotation;GetVehicleZAngle(veh,rotation);GetVehiclePos(veh,x,y,z);

	    SetVehicleNumberPlate(veh,VehicleInfo[VIDTOPID(veh)][Plate]);

	    SetVehicleToRespawn(veh);

		ChangeVehicleColor(veh,VehicleInfo[VIDTOPID(veh)][Color1],VehicleInfo[VIDTOPID(veh)][Color2]);
	    SetVehicleZAngle(veh,rotation);
	    SetVehiclePos(veh,x,y,z);
	    PutPlayerInVehicle(playerid,veh,0);


	    SaveVehicle(VIDTOPID(veh));
	    SendClientMessage(playerid,color_orange,"pVehicle -> {FFFFFF}Your license plate has succesfully updated.");
	}
	if(dialogid == pick_color_1) //in vehicle menu -> pick color 1
	{
	    if(!strlen(inputtext)) return SendClientMessage(playerid,color_red,"pVehicle -> Color change aborted");
	    VehicleInfo[VIDTOPID(GetPlayerVehicleID(playerid))][Color1] = strval(inputtext);
	    ShowPlayerDialog(playerid,pick_color_2,1,"Please pick a color (Color 2)","Please fill in a valid colorID","Change","Cancel");
	} else

	if(dialogid == pick_color_2) //in vehicle menu -> pick color 1 -> pick color 2
	{
		new veh = VIDTOPID(GetPlayerVehicleID(playerid));
	    VehicleInfo[veh][Color2] = strval(inputtext);
		ChangeVehicleColor(GetPlayerVehicleID(playerid),VehicleInfo[veh][Color1],VehicleInfo[veh][Color2]);
		SaveVehicle(veh);
		SendClientMessage(playerid,color_orange,"pVehicle -> {FFFFFF}Colors succesfully saved.");
		#if PRINT_DEBUG_IN_CONSOLE == true
			new pName[MAX_PLAYER_NAME];GetPlayerName(playerid,pName,sizeof pName);printf("pVehicle -> %s has changed the color of his/her private vehicle.",pName);
		#endif
	}
	return 0;
}
/*------------------------------------------Main-functions-----------------------------------------*/
stock AddVehicle(playerid,model,Float:x,Float:y,Float:z,Float:rot,color1,color2)
{
	new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pName,sizeof pName);

	new i = GenerateID();
	if(i == -1) return SendClientMessage(playerid,color_red,"pVehicle -> Couldnt generate an ID. The private vehicle system has possibly reached its vehicle_load limit.");

	new file[96];format(file,sizeof file,"/PrivateVehicles/Vehicles/%i.ini",i);

	VehicleInfo[i][Model] = model;
	VehicleInfo[i][X] = x +3;
	VehicleInfo[i][Y] = y +3;
	VehicleInfo[i][Z] = z;
	VehicleInfo[i][Rot] = rot;
	VehicleInfo[i][Color1] = color1;
	VehicleInfo[i][Color2] = color2;
	format(VehicleInfo[i][Plate],32,"%s","pVehicle");
	format(VehicleInfo[i][Owner],MAX_PLAYER_NAME,"%s",pName);


	VehicleInfo[i][Id] = AddStaticVehicle(VehicleInfo[i][Model],VehicleInfo[i][X],VehicleInfo[i][Y],VehicleInfo[i][Z],VehicleInfo[i][Rot],VehicleInfo[i][Color1],VehicleInfo[i][Color2]);

	SetVehicleNumberPlate(VehicleInfo[i][Id],VehicleInfo[i][Plate]);
	SetVehicleToRespawn(VehicleInfo[i][Id]);
	SaveVehicle(i);

	#if USE_AIR_DROP_FOR_SPAWN == true
	    Transport_Vehicle(playerid,VehicleInfo[i][Id]);
	#endif
	loaded_vehicles++;
	return 1;
}
stock SaveVehicle(id)
{
    new file[96];format(file,sizeof file,"/PrivateVehicles/Vehicles/%i.ini",id);
    new INI:handler = INI_Open(file);

    INI_WriteInt(handler,"Model",VehicleInfo[id][Model]);
    INI_WriteFloat(handler,"X",VehicleInfo[id][X]);
    INI_WriteFloat(handler,"Y",VehicleInfo[id][Y]);
	INI_WriteFloat(handler,"Z",VehicleInfo[id][Z]);
	INI_WriteFloat(handler,"Rot",VehicleInfo[id][Rot]);
	INI_WriteInt(handler,"Color1",VehicleInfo[id][Color1]);
	INI_WriteInt(handler,"Color2",VehicleInfo[id][Color2]);
	INI_WriteString(handler,"Plate",VehicleInfo[id][Plate]);
	INI_WriteString(handler,"Owner",VehicleInfo[id][Owner]);

	INI_Close(handler);
	return 1;
}
stock LoadVehicles()
{
    new file[96];
    for (new i = 0;i<MAX_LOADED_VEHICLES;i++)
    {
        format(file,sizeof file,"/PrivateVehicles/Vehicles/%i.ini",i);
        if(!fexist(file))continue;

        INI_ParseFile(file, "VehicleLoad", .bExtra = true, .extra = i);

		VehicleInfo[i][Lender]= -1;
        VehicleInfo[i][Id] = AddStaticVehicle(VehicleInfo[i][Model], VehicleInfo[i][X], VehicleInfo[i][Y], VehicleInfo[i][Z], VehicleInfo[i][Rot], VehicleInfo[i][Color1], VehicleInfo[i][Color2]);
        SetVehicleNumberPlate(VehicleInfo[i][Id], VehicleInfo[i][Plate]);
        SetVehicleToRespawn(VehicleInfo[i][Id]);
        ++loaded_vehicles;
    }
    return 1;
}
forward VehicleLoad(vid, name[], value[]);
public VehicleLoad(vid, name[], value[])
{
	if(!strcmp(name,"Model")) { VehicleInfo[vid][Model] = strval(value); }
	if(!strcmp(name,"X")) { VehicleInfo[vid][X] = floatstr(value); }
	if(!strcmp(name,"Y")) { VehicleInfo[vid][Y] = floatstr(value); }
	if(!strcmp(name,"Z")) { VehicleInfo[vid][Z] = floatstr(value); }
	if(!strcmp(name,"Rot")) { VehicleInfo[vid][Rot] = floatstr(value); }
	if(!strcmp(name,"Color1")) { VehicleInfo[vid][Color1] = strval(value); }
	if(!strcmp(name,"Color2")) { VehicleInfo[vid][Color2] = strval(value); }
	if(!strcmp(name,"Plate")) { format(VehicleInfo[vid][Plate], 32,"%s", value); }
	if(!strcmp(name,"Owner")) { format(VehicleInfo[vid][Owner], MAX_PLAYER_NAME,"%s",value); }
    return 0; // This is now required.
}
stock Lend_Vehicle(id,playerid)
{
	VehicleInfo[id][Lender]= playerid;
	return 1;
}
stock Return_All_Lended_Vehicles(playerid)
{
	new string[96],pName[MAX_PLAYER_NAME];GetPlayerName(playerid,pName,sizeof pName);
	for(new i = 0;i<MAX_LOADED_VEHICLES;i++)
	{
	    if(!strcmp(pName,VehicleInfo[i][Owner]) && VehicleInfo[i][Model] >= 400 && VehicleInfo[i][Lender] != -1)
	    {
			format(string,sizeof string,"%s has returned his vehicle.",pName);
			SendClientMessage(VehicleInfo[i][Lender],color_red,string);
			if(GetPlayerVehicleID(VehicleInfo[i][Lender]) == VehicleInfo[i][Id]) { RemovePlayerFromVehicle(VehicleInfo[i][Lender]); }
	        VehicleInfo[i][Lender]= -1;
	    }
	}
	SendClientMessage(playerid,color_orange,"pVehicle -> {FFFFFF}You have succesfully returned all your lended vehicles.");
	return 1;
}
stock RemoveVehicles()
{
	for(new i = 0;i<MAX_LOADED_VEHICLES;i++)
	{
	    DestroyVehicle(VehicleInfo[i][Id]);
	}
	return 1;
}
stock CountPlayerVehicles(playerid) //counts how much private vehicles the player has
{
	new Match = 0;
	new pName[MAX_PLAYER_NAME];GetPlayerName(playerid,pName,sizeof pName);
	for(new i = 0;i<MAX_LOADED_VEHICLES;i++)
	{
	    if(strcmp(VehicleInfo[i][Owner],pName) == 0 && VehicleInfo[i][Model] >= 400)
	    {
	        Match++;
	    }
	}
	return Match;
}
stock IsVehiclePrivate(vehicleid) //checking if a vehicle is private
{
	for(new i = 0;i<MAX_LOADED_VEHICLES;i++)
	{
	    if(VehicleInfo[i][Id] == vehicleid) return 1;
	}
	return 0;
}
stock IsVehicleArmed(model)
{
	switch(model)
	{
	    case 432,520,425,476,447:
		{
			return true;
		}
	}
	return false;
}
stock GenerateID() //generating new ID (lowest as possible)
{
	new string[96];
	for(new i = 0;i<MAX_LOADED_VEHICLES;i++)
	{
		format(string,sizeof(string),"/PrivateVehicles/Vehicles/%i.ini",i);
		if(!fexist(string))
		{
		    return i;
		}
	}
	print("Error. no vehicle ID's available");
	return -1;
}
stock VIDTOPID(vehicleid) //converting vehicleID to PVehicle ID
{
	for(new i = 0;i<MAX_LOADED_VEHICLES;i++)
	{
		if(VehicleInfo[i][Id] == vehicleid) return i;
	}
	return -1;
}
/*--------------------------------------------Transport----------------------------------------------*/
new androID[MAX_PLAYERS];
new paraID[MAX_PLAYERS] = -1;
forward create_andro(playerid);
forward remove_andro(vehicleid,playerid);
forward create_vehicle(playerid,ID,Float:x,Float:y,Float:z);
stock Transport_Vehicle(playerid,ID)
{
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	SetVehiclePos(ID,0,0,-30);
	androID[playerid] = CreateObject(14553,x,y+200,z+60,12.25,0,0);
	MoveObject(androID[playerid],x,y-250,z+180,15);
	shipping[playerid] = 1;
	SetTimerEx("create_vehicle",12500,false,"iifff",playerid,ID,x,y+13,z+60);
	SetTimerEx("remove_andro",16000,false,"ii",androID[playerid],playerid);
	return 1;
}
public create_vehicle(playerid,ID,Float:x,Float:y,Float:z)
{
	new ID2 = VIDTOPID(ID);

	DestroyVehicle(ID);
	VehicleInfo[ID2][Id] = AddStaticVehicle(VehicleInfo[ID2][Model],x,y,z,180,VehicleInfo[ID2][Color1],VehicleInfo[ID2][Color2]);
	if(paraID[playerid] != -1){ DestroyObject(paraID[playerid]); }
	paraID[playerid] = CreateObject(2903,x,y,z,0,0,0);
	AttachObjectToVehicle(paraID[playerid],ID,0,0,7.3,0,0,90);
	SaveVehicle(ID2);
	return 1;
}
public remove_andro(vehicleid,playerid)
{
	DestroyObject(vehicleid);
	DestroyObject(paraID[playerid]);
	paraID[playerid] = -1;
	shipping[playerid] = 0;
	return 1;
}