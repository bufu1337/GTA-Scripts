//Transfender,Wheel Arch Angels and Lowrider vehicles supported");
//	Car tuning menus v.1.0 + Tow Truck on submission key (keypad number 2)
//  Coded for Italy Mafia by Lucas_Bertone aka Rsts
// You are not allowed to use this script without giving me credits
// You are not allowed to take any part of code and/or claim that this script is yours

//----------------------------------- CHANGE LOG--------------------------------------------------------------------
// Cleaned up a bit by kaisersouse 4/11/2008
// 29.04.2008 removed pragma and defined propertly
// In next version Transfender vehicle part will be included
#include <a_samp>


#define FILTERSCRIPT

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREY 0xAFAFAFAA// INFO text messages
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA// warning messages
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_LIGHTGREEN 0x7FFF00
#define COLOR_DARKGREEN 0x006400
#define COLOR_LIGHTBLUE 0x91C8FF//Server text messages
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_GROUPTALK 0x87CEEBAA  // SKYBLUE
#define COLOR_MENU 0xFFFFFFAA		// WHITE (FFFFFF) menu's (/help)
#define COLOR_SYSTEM_PM 0x66CC00AA	// LIGHT GREEN
#define COLOR_SYSTEM_PW 0xFFFF33AA	// YELLOW




#if defined FILTERSCRIPT

//--------------------------Main Menu ----------------------------------------------------------------------------
new Menu:TuningMenu;
new Menu:TuningMenu1;
new Menu:Paintjobs;
new Menu:Colors;
new Menu:Colors1;
new Menu:Exhausts;
new Menu:Frontbumper;
new Menu:Rearbumper;
new Menu:Roof;
new Menu:Spoilers;
new Menu:Sideskirts;
new Menu:Bullbars;
new Menu:Wheels;
new Menu:Wheels1;
new Menu:Carstereo;
//--------------------------Main Menu page 2 ----------------------------------------------------------------------------
new Menu:Hydraulics;
new Menu:Nitro;

static pvehicleid[MAX_PLAYERS]; // array containing players vehicle id (loaded when player enters as driver)
static pmodelid[MAX_PLAYERS]; // array containing players vehicle MODEL id (loaded when player enters as driver)


public OnFilterScriptInit()
{


	print("\n--------------------------------------");
	print("Transfender,Wheel Arch Angels and Lowrider vehicles supported");
	print("Car tuning menu v.1.1");
	print("Coded by Lucas_Bertone aks Rsts");
	print("Cleaned up a bit by kaisersouse 4/11/2008");
	print("--------------------------------------\n");

//--------------------------Main Menu  -----------------------------------------
	TuningMenu = CreateMenu("TuningMenu",1,20,120,150,40);
    AddMenuItem(TuningMenu,0,"Paint Jobs");
    AddMenuItem(TuningMenu,0,"Colors");
    AddMenuItem(TuningMenu,0,"Exhausts");
    AddMenuItem(TuningMenu,0,"Front Bumper");
    AddMenuItem(TuningMenu,0,"Rear Bumper");
    AddMenuItem(TuningMenu,0,"Roof");
    AddMenuItem(TuningMenu,0,"Spoilers");
    AddMenuItem(TuningMenu,0,"Side Skirts");
    AddMenuItem(TuningMenu,0,"Bullbars");
    AddMenuItem(TuningMenu,0,"Wheels");
    AddMenuItem(TuningMenu,0,"Car Stereo");
    AddMenuItem(TuningMenu,0,"Next Page");
    Paintjobs = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Paintjobs,0,"PaintJobs");
	AddMenuItem(Paintjobs,0,"Paintjob 1");
	AddMenuItem(Paintjobs,0,"Paintjob 2");
	AddMenuItem(Paintjobs,0,"Paintjob 3");
	AddMenuItem(Paintjobs,0,"Paintjob 4");
	AddMenuItem(Paintjobs,0,"Paintjob 5");
	AddMenuItem(Paintjobs,0,"Main Menu");
	Colors = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Colors,0,"Colors");
	AddMenuItem(Colors,0,"Black");
	AddMenuItem(Colors,0,"White");
	AddMenuItem(Colors,0,"Red");
	AddMenuItem(Colors,0,"Blue");
	AddMenuItem(Colors,0,"Green");
	AddMenuItem(Colors,0,"Yellow");
	AddMenuItem(Colors,0,"Pink");
	AddMenuItem(Colors,0,"Brown");
	AddMenuItem(Colors,0,"Next Page");
	Colors1 = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Colors1,0,"Colors");
    AddMenuItem(Colors1,0,"Grey");
	AddMenuItem(Colors1,0,"Gold");
	AddMenuItem(Colors1,0,"Dark Blue");
	AddMenuItem(Colors1,0,"Light Blue");
	AddMenuItem(Colors1,0,"Green");
	AddMenuItem(Colors1,0,"Light Grey");
	AddMenuItem(Colors1,0,"Dark Red");
	AddMenuItem(Colors1,0,"Dark Brown");
	AddMenuItem(Colors1,0,"Main Menu");
	Exhausts = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Exhausts,0,"Exhausts");
	AddMenuItem(Exhausts,0,"Wheel Arch Alien Exhaust");
	AddMenuItem(Exhausts,0,"Wheel Arch X-Flow Exhaust");
	AddMenuItem(Exhausts,0,"Locos Low Chromer Exhaust");
	AddMenuItem(Exhausts,0,"Locos Low Slamin Exhaust");
	AddMenuItem(Exhausts,0,"Main Menu");
	Frontbumper = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Frontbumper,0,"Frontbumpers");
	AddMenuItem(Frontbumper,0,"Wheel Arch Alien bumper");
	AddMenuItem(Frontbumper,0,"Wheel Arch X-Flow bumper");
	AddMenuItem(Frontbumper,0,"Locos Low Chromer bumper");
	AddMenuItem(Frontbumper,0,"Locos Low Slamin bumper");
	AddMenuItem(Frontbumper,0,"Main Menu");
	Rearbumper = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Rearbumper,0,"Rearbumpers");
	AddMenuItem(Rearbumper,0,"Wheel Arch Alien bumper");
	AddMenuItem(Rearbumper,0,"Wheel Arch X-Flow bumper");
	AddMenuItem(Rearbumper,0,"Locos Low Chromer bumper");
	AddMenuItem(Rearbumper,0,"Locos Low Slamin bumper");
	AddMenuItem(Rearbumper,0,"Main Menu");
	Roof = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Roof,0,"Roof");
	AddMenuItem(Roof,0,"Wheel Arch Alien Roof Vent");
	AddMenuItem(Roof,0,"Wheel Arch X-Flow Roof Vent");
	AddMenuItem(Roof,0,"Locos Low Hardtop Roof");
	AddMenuItem(Roof,0,"Locos Low Softtop Roof");
	AddMenuItem(Roof,0,"Main Menu");
	Spoilers = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Spoilers,0,"Spoliers");
	AddMenuItem(Spoilers,0,"Alien Spoiler");
	AddMenuItem(Spoilers,0,"X-Flow Spoiler");
	AddMenuItem(Spoilers,0,"Main Menu");
	Sideskirts = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Sideskirts,0,"SideSkirts");
	AddMenuItem(Sideskirts,0,"Wheel Arch Alien Side Skirts");
	AddMenuItem(Sideskirts,0,"Wheel Arch X-Flow Side Skirts");
    AddMenuItem(Sideskirts,0,"Locos Low Chrome Strip");
    AddMenuItem(Sideskirts,0,"Locos Low Chrome Flames");
    AddMenuItem(Sideskirts,0,"Locos Low Chrome Arches");
    AddMenuItem(Sideskirts,0,"Locos Low Chrome Trim");
    AddMenuItem(Sideskirts,0,"Locos Low Wheelcovers");
	AddMenuItem(Sideskirts,0,"Main Menu");
	Bullbars = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Bullbars,0,"Bullbars");
	AddMenuItem(Bullbars,0,"Locos Low Chrome Grill");
	AddMenuItem(Bullbars,0,"Locos Low Chrome Bars");
	AddMenuItem(Bullbars,0,"Locos Low Chrome Lights");
	AddMenuItem(Bullbars,0,"Locos Low Chrome Bullbar");
	AddMenuItem(Bullbars,0,"Main Menu");
	Wheels = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Wheels,0,"Wheels");
	AddMenuItem(Wheels,0,"Offroad");
	AddMenuItem(Wheels,0,"Mega");
	AddMenuItem(Wheels,0,"Wires");
	AddMenuItem(Wheels,0,"Twist");
	AddMenuItem(Wheels,0,"Grove");
	AddMenuItem(Wheels,0,"Import");
	AddMenuItem(Wheels,0,"Atomic");
	AddMenuItem(Wheels,0,"Ahab");
	AddMenuItem(Wheels,0,"Virtual");
	AddMenuItem(Wheels,0,"Access");
	AddMenuItem(Wheels,0,"Next Page");
	AddMenuItem(Wheels,0,"Main Menu");
	Wheels1 = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Wheels1,0,"Wheels");
	AddMenuItem(Wheels1,0,"Trance");
	AddMenuItem(Wheels1,0,"Shadow");
	AddMenuItem(Wheels1,0,"Rimshine");
	AddMenuItem(Wheels1,0,"Classic");
	AddMenuItem(Wheels1,0,"Cutter");
	AddMenuItem(Wheels1,0,"Switch");
	AddMenuItem(Wheels1,0,"Dollar");
	AddMenuItem(Wheels1,0,"Main Menu");
	Carstereo = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Carstereo,0,"Stereo");
	AddMenuItem(Carstereo,0,"Bass Boost");
	AddMenuItem(Carstereo,0,"Main Menu");
//-------------------------Main Menu page 2 ------------------------------------

 	TuningMenu1= CreateMenu("TuningMenu",1,20,120,150,40);
    AddMenuItem(TuningMenu1,0,"Hydraulics");
    AddMenuItem(TuningMenu1,0,"Nitro");
    AddMenuItem(TuningMenu1,0,"Repair Car");
    AddMenuItem(TuningMenu1,0,"Main Menu");
	Hydraulics = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Hydraulics,0,"Hydraulics");
	AddMenuItem(Hydraulics,0,"Hydraulics");
	AddMenuItem(Hydraulics,0,"Main Menu");
	Nitro = CreateMenu("TuningMenu",1,20,120,150,40);
	SetMenuColumnHeader(Nitro,0,"Nitro");
	AddMenuItem(Nitro,0,"2x Nitrous");
	AddMenuItem(Nitro,0,"5x Nitrous");
	AddMenuItem(Nitro,0,"10x Nitrous");
	AddMenuItem(Nitro,0,"Main Menu");
	return 1;
}

public OnFilterScriptExit()
{
	DestroyMenu(TuningMenu);
	DestroyMenu(TuningMenu1);
	DestroyMenu(Paintjobs);
	DestroyMenu(Colors);
	DestroyMenu(Colors1);
	DestroyMenu(Exhausts);
	DestroyMenu(Frontbumper);
	DestroyMenu(Rearbumper);
	DestroyMenu(Roof);
	DestroyMenu(Spoilers);
	DestroyMenu(Sideskirts);
	DestroyMenu(Bullbars);
	DestroyMenu(Wheels);
	DestroyMenu(Wheels1);
	DestroyMenu(Carstereo);
	DestroyMenu(Hydraulics);
	DestroyMenu(Nitro);
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" ");
	print("----------------------------------\n");
}

#endif

public OnPlayerConnect(playerid)
{
    SendClientMessage(playerid,COLOR_YELLOW,"                                ..::Car Tuning Menu v.1.1::..   ");
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"                      ..::Coded by Lucas Bertone aka Rsts::..  ");
	SendClientMessage(playerid,COLOR_GREY,"..::Transfender, Wheel Arch Angels and Lowrider vehicles supported::..");
    pvehicleid[playerid] = GetPlayerVehicleID(playerid);
	pvehicleid[playerid] = 0;
    pmodelid[playerid] = 0;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate) {
	if(newstate == PLAYER_STATE_DRIVER) {
	    pvehicleid[playerid] = GetPlayerVehicleID(playerid);
	    pmodelid[playerid] = GetVehicleModel(pvehicleid[playerid]);
	}
	else {
	    pvehicleid[playerid] = 0;
	    pmodelid[playerid] = 0;
	}
	return 1;
}




GetVehicleWithinDistance( playerid, Float:x1, Float:y1, Float:z1, Float:dist, &vehic){
	for(new i = 1; i < MAX_VEHICLES; i++){
		if(GetVehicleModel(i) > 0){
			if(GetPlayerVehicleID(playerid) != i ){
	        	new Float:x, Float:y, Float:z;
	        	new Float:x2, Float:y2, Float:z2;
				GetVehiclePos(i, x, y, z);
				x2 = x1 - x; y2 = y1 - y; z2 = z1 - z;
				new Float:iDist = (x2*x2+y2*y2+z2*z2);
				printf("Vehicle %d is %f", i, iDist);

				if( iDist < dist){
					vehic = i;
				}
			}
		}
	}
}
#pragma unused GetVehicleWithinDistance


public OnPlayerCommandText(playerid, cmdtext[]) {
	if(strcmp(cmdtext, "/tune", true) == 0) {
		new playerstate = GetPlayerState(playerid);
		if(playerstate == PLAYER_STATE_DRIVER) {
		    return ModCar(playerid);
		}
		else {
		   return SendClientMessage(playerid, COLOR_RED, "[ERROR] You cannot modify/tune a car unless you are the driver.");
		}
	}
	return 0;
}
//------------------------All car that are allowed to mod------------------------------------------------------------
// Put here all car's id's yo want to be modable
// NOTE: DO NOT TRY TO ALLOW OR MOD BOATS ; PLANES OR OTHER NON CARS.THAT WIL CAUSE YOUR SERVER CRASH
forward ModCar(playerid);
public ModCar(playerid) { // changed to switch method to reduce processor load on server
//	new modelid = GetVehicleModel(GetPlayerVehicleID(playerid)); // this executes a fair amt of stuff, so running it once to populate variable (modelid),THEN checking variable, makes more sense
	switch(pmodelid[playerid]) {
        case 562,565,559,561,560,575,534,567,536,535,576,411,579,602,496,518,527,589,597,419,
		533,526,474,545,517,410,600,436,580,439,549,491,445,604,507,585,587,466,492,546,551,516,
		426, 547, 405, 409, 550, 566, 540, 421,	529,431,438,437,420,525,552,416,433,427,490,528,
		407,544,470,598,596,599,601,428,499,609,524,578,486,406,573,455,588,403,514,423,
		414,443,515,456,422,482,530,418,572,413,440,543,583,478,554,402,542,603,475,568,504,457,
        483,508,429,541,415,480,434,506,451,555,477,400,404,489,479,442,458,467,558: {
		    ShowMenuForPlayer(TuningMenu, playerid);
		    TogglePlayerControllable(playerid,0);
 			return SendClientMessage(playerid, COLOR_WHITE, "[INFO] Select an item and push the SPACEBAR to approve.");
		}
		default: return SendClientMessage(playerid,COLOR_RED,"[WARNING] You are not allowed to modify/tune this vehicle");
	}
	return 1;
}


public OnPlayerExitedMenu(playerid)
{
	new Menu:Current = GetPlayerMenu(playerid);
	HideMenuForPlayer(Current, playerid);
	TogglePlayerControllable(playerid, true);
	SendClientMessage(playerid,COLOR_YELLOW,"[INFO] You have, as all the kids say, 'pimped your ride'. Or something. Ryan Pietro would be proud.");
	return 1;
}
public OnPlayerSelectedMenuRow(playerid, row)
{
	new Menu:Current = GetPlayerMenu(playerid);
 	if(Current == TuningMenu) {
	    switch(row){
	        case 0:	ShowMenuForPlayer(Paintjobs, playerid);
	        case 1:	ShowMenuForPlayer(Colors, playerid);
	        case 2: ShowMenuForPlayer(Exhausts, playerid);
	        case 3:ShowMenuForPlayer(Frontbumper, playerid);
	        case 4:ShowMenuForPlayer(Rearbumper, playerid);
	        case 5:ShowMenuForPlayer(Roof, playerid);
	        case 6:ShowMenuForPlayer(Spoilers, playerid);
	        case 7:ShowMenuForPlayer(Sideskirts, playerid);
			case 8:ShowMenuForPlayer(Bullbars, playerid);
	        case 9:ShowMenuForPlayer(Wheels, playerid);
	        case 10:ShowMenuForPlayer(Carstereo, playerid);
	        case 11:ShowMenuForPlayer(TuningMenu1, playerid);
		}
	}
	if(Current == Paintjobs) {
		switch(row){
		    case 0:
		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560 ||
				pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 || // Broadway
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 535 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 558)
		        {
					new car = GetPlayerVehicleID(playerid);
					ChangeVehiclePaintjob(car,0);
					SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added paintjob to car");
					ShowMenuForPlayer(Paintjobs, playerid);
				}
				else
				{
				   SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] Paintjob is only for Wheel Arch Angrls and Loco Low Co types of cars");
			       ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 1:
			    if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560 ||
				pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 || // Broadway
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 535 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 558)
			    {
	                new car = GetPlayerVehicleID(playerid);
					ChangeVehiclePaintjob(car,1);
					SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added paintjob to car");
					ShowMenuForPlayer(Paintjobs, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] Paintjob is only for Wheel Arch Angrls and Loco Low Co types of cars");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 2:
	      		if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560 ||
				pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 || // Broadway
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 535 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 558)
			    {
	                new car = GetPlayerVehicleID(playerid);
					ChangeVehiclePaintjob(car,2);
					SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added paintjob to car");
					ShowMenuForPlayer(Paintjobs, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] Paintjob is only for Wheel Arch Angrls and Loco Low Co types of cars");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 3:
			    if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560 ||
				pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 || // Broadway
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 535 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 558)
			    {
	                new car = GetPlayerVehicleID(playerid);
					ChangeVehiclePaintjob(car,3);
					SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added paintjob to car");
					ShowMenuForPlayer(Paintjobs, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] Paintjob is only for Wheel Arch Angrls and Loco Low Co types of cars");
				    ShowMenuForPlayer(TuningMenu, playerid);
			}

			case 4:
		    if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560 ||
				pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 || // Broadway
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 535 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 558)
			    {
	                new car = GetPlayerVehicleID(playerid);
					ChangeVehiclePaintjob(car,4);
					SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added paintjob to car");
					ShowMenuForPlayer(Paintjobs, playerid);
				}
				else
				{
	            	SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] Paintjob is only for Wheel Arch Angrls and Loco Low Co types of cars");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
				case 5:
			{
		    	ShowMenuForPlayer(TuningMenu, playerid);
			}

		}
		}

	if(Current == Colors) {
		switch(row){
		    case 0:
	         if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            ChangeVehicleColor(car,0,0);
		            //GivePlayerMoney(playerid,-150);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully repainted to car");
		            ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 1:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,1,1);
			    //    GivePlayerMoney(playerid,-150);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully repainted to car");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 2:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,3,3);
			      //  GivePlayerMoney(playerid,-150);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully repainted to car");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
	      		 	SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 3:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,79,79);
			     //   GivePlayerMoney(playerid,-150);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully repainted to car");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 4:
				if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,86,86);
			     //   GivePlayerMoney(playerid,-150);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully repainted to car");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 5:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,6,6);
			      //  GivePlayerMoney(playerid,-150);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully repainted to car");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	            case 6:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,126,126);
			  //      GivePlayerMoney(playerid,-150);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully repainted to car");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 7:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,66,66);
			    //    GivePlayerMoney(playerid,-150);
	          		SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully repainted to car");
			        ShowMenuForPlayer(Colors, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 8:ShowMenuForPlayer(Colors1, playerid);
	 }
	 }

	if(Current == Colors1) {
		switch(row){
		    case 0:
	         if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            ChangeVehicleColor(car,24,24);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully repainted to car");
		            ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	         case 1:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,123,123);
	          		SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully repainted to car");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 2:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,53,53);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully repainted to car");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 3:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,93,93);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully repainted to car");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 4:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,83,83);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully repainted to car");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 5:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,60,60);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully repainted to car");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	            case 6:
	      		if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,126,126);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully repainted to car");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 7:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        ChangeVehicleColor(car,110,110);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully repainted to car");
			        ShowMenuForPlayer(Colors1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 8:ShowMenuForPlayer(TuningMenu, playerid);
	 }
	 }


	if(Current == Exhausts) {
		switch(row){



	//-------------------Alien Exausts-Wheel Arch Cars----------------------------------------------------------

		    case 0:

		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            if(pmodelid[playerid] == 562)
		            {
		            	AddVehicleComponent(car,1034);
		            	SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien Exhaust component on Elegy");
		            	ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 565)
					{
					    AddVehicleComponent(car,1046);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien Exhaust component on Flash");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 559)
					{
					    AddVehicleComponent(car,1065);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien Exhaust component on Jetser");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 561)
					{
					    AddVehicleComponent(car,1064);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien Exhaust component on Stratum");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 560)
					{
					    AddVehicleComponent(car,1028);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien Exhaust component on Sultan");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 558)
					{
					    AddVehicleComponent(car,1089);
				 	    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien Exhaust component on Uranus");
					    ShowMenuForPlayer(Exhausts, playerid);
	    			}
					}
	  			 	else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}



	//-------------------X-Flow Exausts-Wheel Arch Cars----------------------------------------------------------
			case 1:
			    if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 562)
			        {
			            AddVehicleComponent(car,1037);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow Exhaust component on Elegy");
			            ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 565)
					{
					    AddVehicleComponent(car,1045);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow Exhaust component on Flash");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 559)
					{
					    AddVehicleComponent(car,1066);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow exaust component on Jester");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 561)
					{
					    AddVehicleComponent(car,1059);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow Exhaust component on Stratum");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 560)
					{
					    AddVehicleComponent(car,1029);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow Exhaust component on Sultan");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 558)
					{
					    AddVehicleComponent(car,1092);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow Exhaust component on Uranus");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------Locos Low Chromer Exausts----------------------------------------------------------
			case 2:
			    if(pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 535)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
			            AddVehicleComponent(car,1044);
		             	SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chromer Exhaust component on Brodway");
			            ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 534)// Remington
					{
					    AddVehicleComponent(car,1126);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chromer Exhaust component on Remington");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 567)// Savanna
					{
					    AddVehicleComponent(car,1129);
	                    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chromer Exhaust component on Savanna");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponent(car,1104);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chromer Exhaust component on Blade");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 535) // Slamvan
					{
					    AddVehicleComponent(car,1113);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chromer Exhaust component on Slamvan");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponent(car,1136);
					   	SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chromer Exhaust component on Tornado");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------Locos Low Salmin Exausts----------------------------------------------------------
			case 3:
			    if(pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 535)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
			            AddVehicleComponent(car,1043);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Slamin Exhaust component on Brodway");
			            ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 534)// Remington
					{
					    AddVehicleComponent(car,1127);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Slamin Exhaust component on Remingon");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 567)// Savanna
					{
					    AddVehicleComponent(car,1132);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Slamin Exhaust component on Savanna");
					    ShowMenuForPlayer(Exhausts, playerid);
					}
					else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponent(car,1105);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Slamin Exhaust component on Blade");
					    ShowMenuForPlayer(Exhausts, playerid);
					}

					else if(pmodelid[playerid] == 535) // Slamvan
					{
					    AddVehicleComponent(car,1114);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Slamin Exhaust component on Slamvan");
					    ShowMenuForPlayer(Exhausts, playerid);
					}

					else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponent(car,1135);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Slamin Exhaust component on Tornado");
					    ShowMenuForPlayer(Exhausts, playerid);
					}

					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

			case 4:ShowMenuForPlayer(TuningMenu, playerid);
		}
		}

	if(Current == Frontbumper) {
		switch(row){


	//-------------------Alien Front Bumper-Wheel Arch Cars----------------------------------------------------------
		    case 0:
		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
				{
		            new car = GetPlayerVehicleID(playerid);
		            if(pmodelid[playerid] == 562) // Elegy
		            {
		            	AddVehicleComponent(car,1171);
	              		SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien front bumper component on Elegy");
		            	ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1153);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien front bumper component on Flash");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jester
					{
					    AddVehicleComponent(car,1160);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien front bumper component on Jester");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1155);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien front bumper component on Stratum");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1169);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien front bumper component on Sultan");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 558) // Uranus
					{
					    AddVehicleComponent(car,1166);
				 	    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien front bumper component on Uraus");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}


	//-------------------X-Flow Front Bumper-Wheel Arch Cars----------------------------------------------------------
			case 1:

				if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {

			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 562) // Elegy
			        {
			            AddVehicleComponent(car,1172);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow front bumper component on Elegy");
			            ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1152);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch  X-Flow front bumper component on Flash");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jetser
					{
					    AddVehicleComponent(car,1173);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch  X-Flow front bumper component on Jester");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1157);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch  X-Flow front bumper component on Stratum");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1170);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch  X-Flow front bumper component on Sultan");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 558)  // Uranus
					{
					    AddVehicleComponent(car,1165);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch  X-Flow front bumper component on Uranus");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------Locos Low Chromer Front Bumper----------------------------------------------------------
			case 2:

	      		if(pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 535)
				{
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
			            AddVehicleComponent(car,1174);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chromer front bumper component on Brodway");
			            ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 534)// Remington
					{
					    AddVehicleComponent(car,1179);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chromer front bumper component on Remington");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 567)// Savanna
					{
					    AddVehicleComponent(car,1189);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chromer front bumper component on Savanna");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponent(car,1182);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chromer front bumper component on Blade");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 535) // Slamvan
					{
					    AddVehicleComponent(car,1115);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chromer front bumper component on Slamvan");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponent(car,1191);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chromer front bumper component on Tornado");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}



	//-------------------Locos Low Salmin Front Bumper----------------------------------------------------------
			case 3:

			    if(pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
	            pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 576)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
			            AddVehicleComponent(car,1175);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Slamin front bumper component on Brodway");
			            ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 534)// Remington
					{
					    AddVehicleComponent(car,1185);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Slamin front bumper component on Remington");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 567)// Savanna
					{
					    AddVehicleComponent(car,1188);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Slamin front bumper component on Savanna");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponent(car,1181);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Slamin front bumper component on Blade");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}

				    else if(pmodelid[playerid] == 535) // Slamvan
					{
					    AddVehicleComponent(car,1116);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Slamin front bumper component on Slamvan");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}
					else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponent(car,1190);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Slamin front bumper component on Tornado");
					    ShowMenuForPlayer(Frontbumper, playerid);
					}

					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

			case 4:ShowMenuForPlayer(TuningMenu, playerid);
		}
		}


	if(Current == Rearbumper) {
		switch(row){


	//-------------------Alien Rear Bumper-Wheel Arch Cars----------------------------------------------------------
		    case 0:
		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {

		            new car = GetPlayerVehicleID(playerid);
		            if(pmodelid[playerid] == 562) // Elegy
		            {
		            	AddVehicleComponent(car,1149);
	              		SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien rear bumper component on Elegy");
		            	ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1150);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien rear bumper component on Flash");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jester
					{
					    AddVehicleComponent(car,1159);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien rear bumper component on Jester");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1154);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien rear bumper component on Stratum");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1141);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien rear bumper component on Sultan");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 558) // Uranus
					{
					    AddVehicleComponent(car,1168);
				 	    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien rear bumper component on Uranus");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------X-Flow Rear Bumper-Wheel Arch Cars----------------------------------------------------------
			case 1:

				if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {


			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 562) // Elegy
			        {
			            AddVehicleComponent(car,1148);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch  X-Flow rear bumper component on Elegy");
			            ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1151);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch  X-Flow rear bumper component on Flash");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jetser
					{
					    AddVehicleComponent(car,1161);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch  X-Flow rear bumper component on Jester");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1156);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch  X-Flow rear bumper component on Stratum");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1140);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch  X-Flow rear bumper component on Sultan");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 558)  // Uranus
					{
					    AddVehicleComponent(car,1167);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch  X-Flow rear bumper component on Uranus");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Chromer rear Bumper----------------------------------------------------------
			case 2:
			    if(pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 535)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
			            AddVehicleComponent(car,1176);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chromer rear bumper component on Brodway");
			            ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 534)// Remington
					{
					    AddVehicleComponent(car,1180);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chromer rear bumper component on Remington");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 567)// Savanna
					{
					    AddVehicleComponent(car,1187);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chromer rear bumper component on Savanna");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponent(car,1184);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chromer rear bumper component on Blade");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 535) // Slamvan
					{
					    AddVehicleComponent(car,1109);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chromer rear bumper component on Slamvan");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponent(car,1192);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chromer rear bumper component on Tornado");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Salmin Rear Bumper----------------------------------------------------------
			case 3:
			    if(pmodelid[playerid] == 575 ||
				pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536 ||
				pmodelid[playerid] == 576 ||
				pmodelid[playerid] == 535)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
			            AddVehicleComponent(car,1177);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Slamin rear bumper component on Brodway");
			            ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 534)// Remington
					{
					    AddVehicleComponent(car,1178);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Slamin rear bumper component on Remington");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 567)// Savanna
					{
					    AddVehicleComponent(car,1186);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Slamin rear bumper component on Savanna");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}
					else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponent(car,1183);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Slamin rear bumper component on Blade");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}

					else if(pmodelid[playerid] == 535) // Slamvan
					{
					    AddVehicleComponent(car,1110);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Slamin rear bumper component on Slamvan");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}

					else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponent(car,1193);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Slamin rear bumper component on Tornado");
					    ShowMenuForPlayer(Rearbumper, playerid);
					}

					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

			case 4:ShowMenuForPlayer(TuningMenu, playerid);
		}
		}



	if(Current == Roof) {
		switch(row){


	//-------------------Alien Roof Vent-Wheel Arch Cars----------------------------------------------------------
		    case 0:
		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {

		            new car = GetPlayerVehicleID(playerid);
		            if(pmodelid[playerid] == 562) // Elegy
		            {
		            	AddVehicleComponent(car,1035);
	              		SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien roof vent component on Elegy");
		            	ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1054);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien roof vent component on Flash");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jester
					{
					    AddVehicleComponent(car,1067);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien roof vent component on Jester");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1055);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien roof vent component on Stratum");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1032);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien roof vent component on Sultan");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 558) // Uranus
					{
					    AddVehicleComponent(car,1088);
				 	    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien roof vent component on Uranus");
					    ShowMenuForPlayer(Roof, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------X-Flow Roof Vent-Wheel Arch Cars----------------------------------------------------------
			case 1:

				if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {


			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 562) // Elegy
			        {
			            AddVehicleComponent(car,1035);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow roof vent component on Elegy");
			            ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1053);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow roof vent component on Flash");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jetser
					{
					    AddVehicleComponent(car,1068);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow roof vent component on Jester");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1061);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow roof vent component on Stratum");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1033);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow roof vent component on Sultan");
					    ShowMenuForPlayer(Roof, playerid);
					}
					else if(pmodelid[playerid] == 558)  // Uranus
					{
					    AddVehicleComponent(car,1091);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow roof vent component on Uranus");
					    ShowMenuForPlayer(Roof, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Hardtop Roof ----------------------------------------------------------
			case 2:
			    if(pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 567) // Savanna
			        {
			            AddVehicleComponent(car,1130);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Hardtop Roof component on Brodway");
			            ShowMenuForPlayer(Roof, playerid);
					}
	   				else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponent(car,1128);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Hardtop Roof component on Blade");
					    ShowMenuForPlayer(Roof, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car types Savanna and Blade");
					ShowMenuForPlayer(Roof, playerid);
					}
	//-------------------Locos Low Softtop Roof ----------------------------------------------------------
			case 3:
			    if(pmodelid[playerid] == 567 ||
				pmodelid[playerid] == 536)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 567) // Savanna
			        {
			            AddVehicleComponent(car,1131);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Softtop Roof component on Brodway");
			            ShowMenuForPlayer(Roof, playerid);
					}
	   				else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponent(car,1103);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Softtop Roof component on Blade");
					    ShowMenuForPlayer(Roof, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car types Savanna and Blade");
					ShowMenuForPlayer(Roof, playerid);
					}

			case 4:ShowMenuForPlayer(TuningMenu, playerid);
		}
		}


	if(Current == Spoilers) {
		switch(row){


	//-------------------Alien Spoilers-Wheel Arch Cars----------------------------------------------------------
		    case 0:
		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {

		            new car = GetPlayerVehicleID(playerid);
		            if(pmodelid[playerid] == 562) // Elegy
		            {
		            	AddVehicleComponent(car,1147);
	              		SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien Spoilers component on Elegy");
		            	ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1049);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien Spoilers component on Flash");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jester
					{
					    AddVehicleComponent(car,1162);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien Spoilers component on Jester");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1158);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien Spoilers component on Stratum");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1138);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien Spoilers component on Sultan");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 558) // Uranus
					{
					    AddVehicleComponent(car,1164);
				 	    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien Spoilers component on Uranus");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}


	//-------------------X-Flow Spoilers-Wheel Arch Cars----------------------------------------------------------
			case 1:

				if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {


			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 562) // Elegy
			        {
			            AddVehicleComponent(car,1146);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow Spoilers component on Elegy");
			            ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1150);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow Spoilers component on Flash");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jetser
					{
					    AddVehicleComponent(car,1158);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow Spoilers component on Jester");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1060);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow Spoilers component on Stratum");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1139);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow Spoilers component on Sultan");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					else if(pmodelid[playerid] == 558)  // Uranus
					{
					    AddVehicleComponent(car,1163);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow Spoilers component on Uranus");
					    ShowMenuForPlayer(Spoilers, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to X-Flow Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	        	case 2:
				{
	            ShowMenuForPlayer(TuningMenu, playerid);
	            }
		}
		}


	if(Current == Sideskirts) {
		switch(row){


	//-------------------Alien Sideskirts Wheel Arch Cars----------------------------------------------------------
		    case 0:
		        if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {

		            new car = GetPlayerVehicleID(playerid);
		            if(pmodelid[playerid] == 562) // Elegy
		            {
		            	AddVehicleComponent(car,1036);
		            	AddVehicleComponent(car,1040);
	              		SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien Side Skirts component on Elegy");
		            	ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1047);
					    AddVehicleComponent(car,1051);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien Sideskirts vent component on Flash");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jester
					{
					    AddVehicleComponent(car,1069);
					    AddVehicleComponent(car,1071);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien Side Skirts component on Jester");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1056);
					    AddVehicleComponent(car,1062);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien Side Skirts component on Stratum");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1026);
					    AddVehicleComponent(car,1027);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien Side Skirts bumper component on Sultan");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 558) // Uranus
					{
					    AddVehicleComponent(car,1090);
					    AddVehicleComponent(car,1094);
				 	    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch Alien Side Skirts component on Uranus");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------X-Flow Sideskirts-Wheel Arch Cars----------------------------------------------------------
			case 1:

				if(pmodelid[playerid] == 562 ||
				pmodelid[playerid] == 565 ||
				pmodelid[playerid] == 559 ||
				pmodelid[playerid] == 561 ||
				pmodelid[playerid] == 560)
		        {


			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 562) // Elegy
			        {
			            AddVehicleComponent(car,1039);
			            AddVehicleComponent(car,1041);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow Side Skirts component on Elegy");
			            ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 565) // Flash
					{
					    AddVehicleComponent(car,1048);
					    AddVehicleComponent(car,1052);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow Side Skirts component on Flash");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 559) // Jetser
					{
					    AddVehicleComponent(car,1070);
					    AddVehicleComponent(car,1072);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow Side Skirts component on Jester");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 561) // Stratum
					{
					    AddVehicleComponent(car,1057);
					    AddVehicleComponent(car,1063);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow Side Skirts component on Stratum");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 560) // Sultan
					{
					    AddVehicleComponent(car,1031);
					    AddVehicleComponent(car,1030);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow Side Skirts component on Sultan");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					else if(pmodelid[playerid] == 558)  // Uranus
					{
					    AddVehicleComponent(car,1093);
					    AddVehicleComponent(car,1095);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wheel Arch X-Flow Side Skirts component on Uranus");
					    ShowMenuForPlayer(Sideskirts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Wheel Arch Angels Car types");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------Locos Low Chrome Strip Side Skirts----------------------------------------------------------
			case 2:
			    if(pmodelid[playerid] == 575 ||
	               pmodelid[playerid] == 536 ||
	               pmodelid[playerid] == 576 ||
		 	       pmodelid[playerid] == 567)
	               {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 575) // Brodway
			        {
	       		        AddVehicleComponent(car,1042);
	       		        AddVehicleComponent(car,1099);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chrome Strip Side Skirts component on Brodway");
			            ShowMenuForPlayer(Sideskirts, playerid);
					}
	   				else if(pmodelid[playerid] == 567) // Savanna
					{
					    AddVehicleComponent(car,1102);
					    AddVehicleComponent(car,1133);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chrome Strip Side Skirts component on Savanna");
	    		        ShowMenuForPlayer(Sideskirts, playerid);
	                }
	                else if(pmodelid[playerid] == 576) // Tornado
					{
					    AddVehicleComponent(car,1134);
					    AddVehicleComponent(car,1137);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chrome Strip Side Skirts component on Tornado");
	    		        ShowMenuForPlayer(Sideskirts, playerid);
	                }
	                else if(pmodelid[playerid] == 536) // Blade
					{
					    AddVehicleComponent(car,1108);
					    AddVehicleComponent(car,1107);
					    SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chrome Strip Side Skirts component on Blade");
	                    ShowMenuForPlayer(Sideskirts, playerid);
	                }
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car types Brodway, Savanna Tornado and Blade");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Chrome Flames Side Skirts----------------------------------------------------------
			case 3:
			    if(pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 534)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 534) // Remington
			        {
			            AddVehicleComponent(car,1122);
			            AddVehicleComponent(car,1101);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chrome Flames Side Skirts component on Remington");
			            ShowMenuForPlayer(Sideskirts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car type Remington ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Chrome Arches Side Skirts----------------------------------------------------------

			case 4:
			    if(pmodelid[playerid] == 534 ||
				pmodelid[playerid] == 534)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 534) // Remington
			        {
			            AddVehicleComponent(car,1106);
			            AddVehicleComponent(car,1124);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chrome Arches Side Skirts component on Remington");
			            ShowMenuForPlayer(Sideskirts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car type Remington ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}




	//-------------------Locos Low Chrome Trim Side Skirts----------------------------------------------------------
			case 5:
			    if(pmodelid[playerid] == 535)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 535) // Slamvan
			        {
			            AddVehicleComponent(car,1118);
			            AddVehicleComponent(car,1120);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chrome Trim Side Skirts component on Slamvan");
			            ShowMenuForPlayer(Sideskirts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car type Slamvan ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

	//-------------------Locos Low Chrome Wheelcovers Side Skirts----------------------------------------------------------
	  case 6:
			    if(pmodelid[playerid] == 535)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 535) // Slamvan
			        {
			            AddVehicleComponent(car,1119);
			            AddVehicleComponent(car,1121);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chrome Wheelcovers component on Slamvan");
			            ShowMenuForPlayer(Sideskirts, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car type Slamvan ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}

			   case 7:ShowMenuForPlayer(TuningMenu, playerid);
		}
		}

	//-------------------Locos Low Chrome Grill ----------------------------------------------------------

	if(Current == Bullbars) {
		switch(row){

	        case 0:
			    if(pmodelid[playerid] == 534)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 534) // Remington
			        {
			            AddVehicleComponent(car,1100);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chrome Grill component on Remington");
			            ShowMenuForPlayer(Bullbars, playerid);
			        }
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car type Remington ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Chrome Bars ----------------------------------------------------------
			case 1:
			    if(pmodelid[playerid] == 534)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 534) // Remington
			        {
			            AddVehicleComponent(car,1123);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chrome Bars component on Remington");
			            ShowMenuForPlayer(Bullbars, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car type Remington ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}
	//-------------------Locos Low Chrome Lights ----------------------------------------------------------


			case 2:
			    if(pmodelid[playerid] == 534)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 534) // Remington
			        {
			            AddVehicleComponent(car,1125);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chrome Lights component on Remington");
			            ShowMenuForPlayer(Bullbars, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car type Remington ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}




	//-------------------Locos Low Chrome Bullbar ----------------------------------------------------------


	        case 3:
			    if(pmodelid[playerid] == 535)

			    {
			        new car = GetPlayerVehicleID(playerid);
			        if(pmodelid[playerid] == 535) // Slamvan
			        {
			            AddVehicleComponent(car,1117);
			            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Locos Low Chrome Lights component on Slamvan");
			            ShowMenuForPlayer(Bullbars, playerid);
					}
					}
					else
					{
				    SendClientMessage(playerid,COLOR_YELLOW,"[WARNING] You can only add this component to Locos Low Car type Slamvan ");
					ShowMenuForPlayer(TuningMenu, playerid);
					}








			case 4:ShowMenuForPlayer(TuningMenu, playerid);
		}
		}



	if(Current == Wheels) {
		switch(row){
		    case 0:
	         if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponent(car,1025);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Offroad Wheels ");
		            ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 1:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1074);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Mega Wheels");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 2:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
	                AddVehicleComponent(car,1076);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Wires Wheels");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 3:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1078);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Twist Wheels");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
	      		 	SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(Wheels, playerid);
				}
			case 4:
				if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1081);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Grove Wheels");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 5:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
	                AddVehicleComponent(car,1082);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Import Wheels");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	   		case 6:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1085);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Atomic Wheels");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 7:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1096);
	          		SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Ahab Wheels");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 8:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1097);
	          		SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Virtual Wheels");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	 		case 9:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1098);
	          		SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Access Wheels");
			        ShowMenuForPlayer(Wheels, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	        case 10:
				{

				    ShowMenuForPlayer(Wheels1, playerid);
				}

			case 11:
				{

				    ShowMenuForPlayer(TuningMenu, playerid);
				}

	 	}
	 }

	if(Current == Wheels1) {
		switch(row){
		    case 0:
	         if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponent(car,1084);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Trance Wheels ");
		            ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 1:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1073);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Shadow Wheels");
			        ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 2:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
	                AddVehicleComponent(car,1075);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Rimshine Wheels");
			        ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
	      	 		SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 3:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1077);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Classic Wheels");
			        ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(Wheels, playerid);
				}
			case 4:
				if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1079);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Cutter Wheels");
			        ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 5:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
	                AddVehicleComponent(car,1080);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Switch Wheels");
			        ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	   		case 6:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1083);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Dollar Wheels");
			        ShowMenuForPlayer(Wheels1, playerid);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
	        case 7:
				{

				    ShowMenuForPlayer(TuningMenu, playerid);
				}
		 }
	 }


	if(Current == Carstereo) {
		switch(row){
		    case 0:
	         if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponent(car,1086);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Stereo Bass bost system ");
		            ShowMenuForPlayer(Carstereo, playerid);
				}
				else
				{
	                SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
			    }
			case 1:

			    {
			        ShowMenuForPlayer(TuningMenu, playerid);
				}
		 }
	 }

	if(Current == Hydraulics) {
		switch(row){
		    case 0:
	            if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponent(car,1087);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added Hydraulics to car ");
		            ShowMenuForPlayer(Hydraulics, playerid);
				}
				else
				{
	                SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
			    }

			case 1:

			    {
			        ShowMenuForPlayer(TuningMenu, playerid);
				}
		 }
	 }

	if(Current == Nitro) {
		switch(row){
		    case 0:
	         if(GetPlayerMoney(playerid) >= 0)
		        {
		            new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponent(car,1008);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added 2x Nitro to car ");
		            ShowMenuForPlayer(Nitro, playerid);
				}
				else
				{
	                SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
			    }
			case 1:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
			        AddVehicleComponent(car,1009);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added 5x Nitro to car");
			        ShowMenuForPlayer(Nitro, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 2:
			    if(GetPlayerMoney(playerid) >= 0)
			    {
			        new car = GetPlayerVehicleID(playerid);
	                AddVehicleComponent(car,1010);
			        SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully added 10x Nitro to car");
			        ShowMenuForPlayer(Nitro, playerid);
				}
				else
				{
	       			SendClientMessage(playerid,COLOR_RED,"Not enough money!");
				    ShowMenuForPlayer(TuningMenu, playerid);
				}
			case 3:

			    {
			        ShowMenuForPlayer(TuningMenu, playerid);
				}
	 }
}


	//--------------------------Main Menu page 2 ----------------------------------------------------------------------------
	if(Current == TuningMenu1) {
	    switch(row){
	        case 0:
				if(IsPlayerConnected(playerid))
				{
					ShowMenuForPlayer(Hydraulics, playerid);
				}
	        case 1:
				if(IsPlayerConnected(playerid))
				{
					ShowMenuForPlayer(Nitro, playerid);
				}
	       case 2:
				{
	                new car = GetPlayerVehicleID(playerid);
					SetVehicleHealth(car,1000);
				 	SendClientMessage(playerid,COLOR_WHITE,"[INFO] You have succesfully repaired car");
					ShowMenuForPlayer(TuningMenu1, playerid);

				}

	       case 3:
				if(IsPlayerConnected(playerid))
				{
					ShowMenuForPlayer(TuningMenu, playerid);
				}


		}
	}
	return 0;

}

// Yea this is it end of script.Hope you like it enjoy 13.08.2007
// by Rsts
