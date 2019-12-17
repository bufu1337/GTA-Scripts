/*D4RKKNIGHT Made This Script All By HimSelf
EXEPT For The Randome Message
And The MasterFile Script*/
//==============================================================================
#include <a_samp>
#pragma tabsize 0
new Menu:Main;
new Menu:Vehicles;
new Menu:Mods;
new Menu:MotorBikes;
new Menu:Planes;
new Menu:Boats;
new Menu:Trucks;
new Menu:Bicycles;
new Menu:Helicopters;
new Menu:Cars1;
new Menu:As;
new Menu:Bs;
new Menu:Bs2;
new Menu:Cs;
new Menu:Cs2;
new Menu:Ds;
new Menu:Es;
new Menu:Fs;
new Menu:Gs;
new Menu:Hs;
new Menu:Is;
new Menu:Js;
new Menu:Cars2;
new Menu:Ks;
new Menu:Ls;
new Menu:Ms;
new Menu:Ns;
new Menu:Os;
new Menu:Ps;
new Menu:Rs;
new Menu:Ss;
new Menu:Ss2;
new Menu:Ts;
new Menu:Us;
new Menu:Vs;
new Menu:Cars3;
new Menu:Ws;
new Menu:Ys;
new Menu:Zs;
new Menu:Carmods;
new Menu:PaintJobs;
new Menu:Rims;
new Menu:Spoilers;
new Menu:Weapons;
new Menu:Hand1;
new Menu:Hand2;
new Menu:Pistols;
new Menu:SMGs;
new Menu:Shotguns;
new Menu:Rifles;
new Menu:Assault_Rifles;
new Menu:Explosives;
new Menu:Big_Guns;
new Menu:Teleports;
new Menu:Teleports2;
new Menu:Times;
new Menu:Weather;
new Menu:Money;
new Menu:HNA;
#define NAMELINES 20
#define COLOR_GREEN 0x33AA33AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_LIGHTGREEN 0x7FFF00
#define COLOR_DARKGREEN 0x006400
#define COLOR_LIGHTBLUE 0x91C8FF
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_GROUPTALK 0x87CEEBAA
#define COLOR_MENU 0xFFFFFFAA
#define COLOR_SYSTEM_PM 0x66CC00AA
#define COLOR_SYSTEM_PW 0xFFFF33AA
forward TimeUpdate();
forward SendMSG();
new fileline[50];
new filename[128];
new master[NAMELINES][50];
new Text:DKClock;
new Text:DKClock2;
new TimeTimer;
#define FILTERSCRIPT
#if defined FILTERSCRIPT
new RandomMSG[][] ={
    "No Hacking",
    "English Only As Main Text",
    "Dont Swear",
    "No Spawn Killing",
    "This Server Is Using Handy Little Menu"
};
//==============================================================================
new VNames[212][] ={
	{"Landstalker"},
	{"Bravura"},
	{"Buffalo"},
	{"Linerunner"},
	{"Perrenial"},
	{"Sentinel"},
	{"Dumper"},
	{"Firetruck"},
	{"Trashmaster"},
	{"Stretch"},
	{"Manana"},
	{"Infernus"},
	{"Voodoo"},
	{"Pony"},
	{"Mule"},
	{"Cheetah"},
	{"Ambulance"},
	{"Leviathan"},
	{"Moonbeam"},
	{"Esperanto"},
	{"Taxi"},
	{"Washington"},
	{"Bobcat"},
	{"Mr Whoopee"},
	{"BF Injection"},
	{"Hunter"},
	{"Premier"},
	{"Enforcer"},
	{"Securicar"},
	{"Banshee"},
	{"Predator"},
	{"Bus"},
	{"Rhino"},
	{"Barracks"},
	{"Hotknife"},
	{"Trailer 1"},
	{"Previon"},
	{"Coach"},
	{"Cabbie"},
	{"Stallion"},
	{"Rumpo"},
	{"RC Bandit"},
	{"Romero"},
	{"Packer"},
	{"Monster"},
	{"Admiral"},
	{"Squalo"},
	{"Seasparrow"},
	{"Pizzaboy"},
	{"Tram"},
	{"Trailer 2"},
	{"Turismo"},
	{"Speeder"},
	{"Reefer"},
	{"Tropic"},
	{"Flatbed"},
	{"Yankee"},
	{"Caddy"},
	{"Solair"},
	{"Berkley's RC Van"},
	{"Skimmer"},
	{"PCJ-600"},
	{"Faggio"},
	{"Freeway"},
	{"RC Baron"},
	{"RC Raider"},
	{"Glendale"},
	{"Oceanic"},
	{"Sanchez"},
	{"Sparrow"},
	{"Patriot"},
	{"Quad"},
	{"Coastguard"},
	{"Dinghy"},
	{"Hermes"},
	{"Sabre"},
	{"Rustler"},
	{"ZR-350"},
	{"Walton"},
	{"Regina"},
	{"Comet"},
	{"BMX"},
	{"Burrito"},
	{"Camper"},
	{"Marquis"},
	{"Baggage"},
	{"Dozer"},
	{"Maverick"},
	{"News Chopper"},
	{"Rancher"},
	{"FBI Rancher"},
	{"Virgo"},
	{"Greenwood"},
	{"Jetmax"},
	{"Hotring"},
	{"Sandking"},
	{"Blista Compact"},
	{"Police Maverick"},
	{"Boxville"},
	{"Benson"},
	{"Mesa"},
	{"RC Goblin"},
	{"Hotring Racer A"},
	{"Hotring Racer B"},
	{"Bloodring Banger"},
	{"Rancher"},
	{"Super GT"},
	{"Elegant"},
	{"Journey"},
	{"Bike"},
	{"Mountain Bike"},
	{"Beagle"},
	{"Cropdust"},
	{"Stunt"},
	{"Tanker"},
	{"Roadtrain"},
	{"Nebula"},
	{"Majestic"},
	{"Buccaneer"},
	{"Shamal"},
	{"Hydra"},
	{"FCR-900"},
	{"NRG-500"},
	{"HPV1000"},
	{"Cement Truck"},
	{"Tow Truck"},
	{"Fortune"},
	{"Cadrona"},
	{"FBI Truck"},
	{"Willard"},
	{"Forklift"},
	{"Tractor"},
	{"Combine"},
	{"Feltzer"},
	{"Remington"},
	{"Slamvan"},
	{"Blade"},
	{"Freight"},
	{"Streak"},
	{"Vortex"},
	{"Vincent"},
	{"Bullet"},
	{"Clover"},
	{"Sadler"},
	{"Firetruck LA"},
	{"Hustler"},
	{"Intruder"},
	{"Primo"},
	{"Cargobob"},
	{"Tampa"},
	{"Sunrise"},
	{"Merit"},
	{"Utility"},
	{"Nevada"},
	{"Yosemite"},
	{"Windsor"},
	{"Monster A"},
	{"Monster B"},
	{"Uranus"},
	{"Jester"},
	{"Sultan"},
	{"Stratum"},
	{"Elegy"},
	{"Raindance"},
	{"RC Tiger"},
	{"Flash"},
	{"Tahoma"},
	{"Savanna"},
	{"Bandito"},
	{"Freight Flat"},
	{"Streak Carriage"},
	{"Kart"},
	{"Mower"},
	{"Duneride"},
	{"Sweeper"},
	{"Broadway"},
	{"Tornado"},
	{"AT-400"},
	{"DFT-30"},
	{"Huntley"},
	{"Stafford"},
	{"BF-400"},
	{"Newsvan"},
	{"Tug"},
	{"Trailer 3"},
	{"Emperor"},
	{"Wayfarer"},
	{"Euros"},
	{"Hotdog"},
	{"Club"},
	{"Freight Carriage"},
	{"Trailer 3"},
	{"Andromada"},
	{"Dodo"},
	{"RC Cam"},
	{"Launch"},
	{"Police Car (LSPD)"},
	{"Police Car (SFPD)"},
	{"Police Car (LVPD)"},
	{"Police Ranger"},
	{"Picador"},
	{"S.W.A.T. Van"},
	{"Alpha"},
	{"Phoenix"},
	{"Glendale"},
	{"Sadler"},
	{"Luggage Trailer A"},
	{"Luggage Trailer B"},
	{"Stair Trailer"},
	{"Boxville"},
	{"Farm Plow"},
	{"Utility Trailer"}
};
public OnFilterScriptInit(){
print("\n=================================================================");
 	print("---------------------------Now Running----------------------------");
	print("----------------------Handy Little Menu V4.0----------------------");
	print("----------------------Created By: D4RKKNIGH7----------------------");
	print("-------------------Date Realesed: MAY 30, 2008--------------------");
	print("==================================================================");
	print("\n");
	{
	TimeTimer = SetTimer("TimeUpdate",1000,1);

	DKClock = TextDrawCreate(547, 40, "--~g~:~w~--");
    TextDrawLetterSize(DKClock, 0.5, 1.5);
    TextDrawFont(DKClock, 2);
    TextDrawSetShadow(DKClock, 2);
    TextDrawSetOutline(DKClock,2);

    DKClock2 = TextDrawCreate(607, 40, "~r~--");
    TextDrawLetterSize(DKClock2, 0.4, 1.1);
    TextDrawFont(DKClock2, 2);
    TextDrawSetShadow(DKClock2, 2);
    TextDrawSetOutline(DKClock2,2);
    }
	filename = "Handy.ini";
	new File:masterfile;
	masterfile = fopen(filename, io_read);

	for(new i; i<NAMELINES; i++)
	{
	fread(masterfile, fileline, sizeof(fileline));

	if(strlen(fileline) > 0)
	{
	strdel(fileline, strlen(fileline)-2, sizeof(fileline));
 	 master[i] = fileline;
	}
	}

	fclose(masterfile);

	return 1;
}
public OnFilterScriptExit(){
	KillTimer(TimeTimer);
	TextDrawDestroy(DKClock);
	TextDrawDestroy(DKClock2);
	return 1;
}
public TimeUpdate(){
   new Hour, Min, Sec, TimeString[256], TimeString2[256];
   gettime(Hour, Min, Sec);
   if (Min <= 9){
   format(TimeString,25,"%d:0%d",Hour, Min);
   }else{
   format(TimeString,25,"%d:%d",Hour, Min);
   }
   TextDrawSetString(DKClock,TimeString);
   TextDrawShowForAll(DKClock);
   format(TimeString2,25,"%d",Sec);
   TextDrawSetString(DKClock2,TimeString2);
   TextDrawShowForAll(DKClock2);
}
public OnGameModeInit(){
	SetTimer("SendMSG",150000,1);
	Main = CreateMenu("Main Menu", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Main, 0, "Pick A Catagory");
	AddMenuItem(Main, 0, "Vehicles");
	AddMenuItem(Main, 0, "Mods");
	AddMenuItem(Main, 0, "Weapons");
	AddMenuItem(Main, 0, "Teleports");
	AddMenuItem(Main, 0, "Time");
	AddMenuItem(Main, 0, "Weather");
	AddMenuItem(Main, 0, "Money");
	AddMenuItem(Main, 0, "Health And Armour");
	AddMenuItem(Main, 0, "Exit Menu");
    Vehicles = CreateMenu("Vehicles", 2, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Vehicles, 0, "Pick A Vehicle Type");
	AddMenuItem(Vehicles, 0, "MotorBikes");
	AddMenuItem(Vehicles, 1, "MotorBikes");
	AddMenuItem(Vehicles, 0, "Planes");
	AddMenuItem(Vehicles, 1, "Planes");
	AddMenuItem(Vehicles, 0, "Boats");
	AddMenuItem(Vehicles, 1, "Boats");
	AddMenuItem(Vehicles, 0, "Trucks");
	AddMenuItem(Vehicles, 1, "Trucks");
	AddMenuItem(Vehicles, 0, "Bicycles");
	AddMenuItem(Vehicles, 1, "Bicycles");
	AddMenuItem(Vehicles, 0, "Helicopters");
	AddMenuItem(Vehicles, 1, "Helicopters");
	AddMenuItem(Vehicles, 0, "Cars1");
	AddMenuItem(Vehicles, 1, "As To Ks");
	AddMenuItem(Vehicles, 0, "Cars2");
	AddMenuItem(Vehicles, 1, "Ls_To_Xs");
    AddMenuItem(Vehicles, 0, "Cars3");
    AddMenuItem(Vehicles, 1, "Ys_To_Zs");
	AddMenuItem(Vehicles, 0, "<Back>");
	AddMenuItem(Vehicles, 1, "Goes Back A Menu");
    Mods = CreateMenu("Mods", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Mods, 0, "Pick A Mods");
	AddMenuItem(Mods, 0, "Carmods");
	AddMenuItem(Mods, 0, "PaintJobs");
	AddMenuItem(Mods, 0, "Rims");
	AddMenuItem(Mods, 0, "Spoilers");
	AddMenuItem(Mods, 0, "<Back>");
    MotorBikes = CreateMenu("MotorBikes", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(MotorBikes, 0, "Pick A MotorBike");
	AddMenuItem(MotorBikes, 0, "FCR-900");
	AddMenuItem(MotorBikes, 0, "PCJ-600");
	AddMenuItem(MotorBikes, 0, "NRG-500");
	AddMenuItem(MotorBikes, 0, "BF-400");
	AddMenuItem(MotorBikes, 0, "CopBike");
	AddMenuItem(MotorBikes, 0, "Sanchez");
	AddMenuItem(MotorBikes, 0, "Quad");
	AddMenuItem(MotorBikes, 0, "Freeway");
	AddMenuItem(MotorBikes, 0, "<Back>");
    Planes = CreateMenu("Planes", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Planes, 0, "Pick A Plane");
	AddMenuItem(Planes, 0, "Hydra");
	AddMenuItem(Planes, 0, "Andromeda");
	AddMenuItem(Planes, 0, "Shamal");
	AddMenuItem(Planes, 0, "RC Barron");
	AddMenuItem(Planes, 0, "AT-400");
	AddMenuItem(Planes, 0, "Stuntplane");
	AddMenuItem(Planes, 0, "Rustler");
	AddMenuItem(Planes, 0, "<Back>");
    Boats = CreateMenu("Boats", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Boats, 0, "Pick A Boat");
 	AddMenuItem(Boats, 0, "Jetmax");
 	AddMenuItem(Boats, 0, "Predator");
 	AddMenuItem(Boats, 0, "Speeder");
 	AddMenuItem(Boats, 0, "Squalo");
 	AddMenuItem(Boats, 0, "CoastGuard");
 	AddMenuItem(Boats, 0, "<Back>");
    Trucks = CreateMenu("Trucks", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Trucks, 0, "Pick A Truck");
	AddMenuItem(Trucks, 0, "Dumper");
	AddMenuItem(Trucks, 0, "Duneride");
	AddMenuItem(Trucks, 0, "Monster");
	AddMenuItem(Trucks, 0, "MonsterA");
	AddMenuItem(Trucks, 0, "MonsterB");
	AddMenuItem(Trucks, 0, "<Back>");
    Bicycles = CreateMenu("Bicycles", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Bicycles, 0, "Pick A Bicycle");
	AddMenuItem(Bicycles, 0, "Bike");
	AddMenuItem(Bicycles, 0, "BMX");
	AddMenuItem(Bicycles, 0, "Mountain Bike");
	AddMenuItem(Bicycles, 0, "<Back>");
    Helicopters = CreateMenu("Helicopters", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Helicopters, 0, "Pick A Helicopter");
	AddMenuItem(Helicopters, 0, "Hunter");
	AddMenuItem(Helicopters, 0, "Sparrow");
	AddMenuItem(Helicopters, 0, "Seasparr");
	AddMenuItem(Helicopters, 0, "Rcgoblin");
	AddMenuItem(Helicopters, 0, "Maverick");
	AddMenuItem(Helicopters, 0, "Police Chopper");
	AddMenuItem(Helicopters, 0, "Cargobob");
	AddMenuItem(Helicopters, 0, "<Back>");
	Cars1 = CreateMenu("Cars1", 1, 50.0, 180.0, 200.0, 200.0);
	SetMenuColumnHeader(Cars1, 0, "Pick A Starting Letter");
	AddMenuItem(Cars1, 0, "As");
	AddMenuItem(Cars1, 0, "Bs");
	AddMenuItem(Cars1, 0, "Cs");
	AddMenuItem(Cars1, 0, "Ds");
	AddMenuItem(Cars1, 0, "Es");
	AddMenuItem(Cars1, 0, "Fs");
	AddMenuItem(Cars1, 0, "Gs");
	AddMenuItem(Cars1, 0, "Hs");
	AddMenuItem(Cars1, 0, "Is");
	AddMenuItem(Cars1, 0, "Js");
	AddMenuItem(Cars1, 0, "Ks");
	AddMenuItem(Cars1, 0, "<Back>");
    Cars2 = CreateMenu("Cars2", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Cars2, 0, "Pick A Starting Letter");
	AddMenuItem(Cars2, 0, "Ls");
	AddMenuItem(Cars2, 0, "Ms");
	AddMenuItem(Cars2, 0, "Ns");
	AddMenuItem(Cars2, 0, "Os");
	AddMenuItem(Cars2, 0, "Ps");
	AddMenuItem(Cars2, 0, "Rs");
	AddMenuItem(Cars2, 0, "Ss");
	AddMenuItem(Cars2, 0, "Ts");
	AddMenuItem(Cars2, 0, "Us");
	AddMenuItem(Cars2, 0, "Vs");
	AddMenuItem(Cars2, 0, "Ws");
	AddMenuItem(Cars2, 0, "<Back>");
	Cars3 = CreateMenu("Cars3", 1, 50.0, 180.0, 200.0, 200.0);
	SetMenuColumnHeader(Cars3, 0, "Pick A Starting Letter");
	AddMenuItem(Cars3, 0, "Ys");
	AddMenuItem(Cars3, 0, "Zs");
	AddMenuItem(Cars3, 0, "<Back>");
	As = CreateMenu("As", 1, 50.0, 180.0, 200.0, 200.0);
	SetMenuColumnHeader(As, 0, "Pick A Car");
	AddMenuItem(As, 0, "Admiral");
	AddMenuItem(As, 0, "Alpha");
	AddMenuItem(As, 0, "Ambulan");
	AddMenuItem(As, 0, "<Back>");
    Bs = CreateMenu("Bs", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Bs, 0, "Pick A Car");
	AddMenuItem(Bs, 0, "Baggage");
	AddMenuItem(Bs, 0, "Bandito");
	AddMenuItem(Bs, 0, "Banshee");
	AddMenuItem(Bs, 0, "Barracks");
	AddMenuItem(Bs, 0, "Benson");
	AddMenuItem(Bs, 0, "Bfinject");
	AddMenuItem(Bs, 0, "Blade");
	AddMenuItem(Bs, 0, "Blistac");
	AddMenuItem(Bs, 0, "Bloodra");
	AddMenuItem(Bs, 0, "Bobcat");
	AddMenuItem(Bs, 0, "<Next>");
	AddMenuItem(Bs, 0, "<Back>");
    Bs2 = CreateMenu("Bs", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Bs2, 0, "Pick A Car");
   	AddMenuItem(Bs2, 0, "Boxburg");
	AddMenuItem(Bs2, 0, "Boxville");
	AddMenuItem(Bs2, 0, "Bravura");
	AddMenuItem(Bs2, 0, "Broadway");
	AddMenuItem(Bs2, 0, "Buccanee");
	AddMenuItem(Bs2, 0, "Buffalo");
	AddMenuItem(Bs2, 0, "Bullet");
	AddMenuItem(Bs2, 0, "Burrito");
	AddMenuItem(Bs2, 0, "Bus");
	AddMenuItem(Bs2, 0, "<Back>");
    Cs = CreateMenu("Cs", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Cs, 0, "Pick A Car");
	AddMenuItem(Cs, 0, "Cabbie");
	AddMenuItem(Cs, 0, "Caddy");
	AddMenuItem(Cs, 0, "Cadrona");
	AddMenuItem(Cs, 0, "Camper");
	AddMenuItem(Cs, 0, "Cement");
	AddMenuItem(Cs, 0, "Cheetah");
	AddMenuItem(Cs, 0, "Clover");
	AddMenuItem(Cs, 0, "Club");
	AddMenuItem(Cs, 0, "Coach");
	AddMenuItem(Cs, 0, "Combine");
	AddMenuItem(Cs, 0, "Comet");
	AddMenuItem(Cs, 0, "<Next>");
	AddMenuItem(Cs, 0, "<Back>");
    Cs2 = CreateMenu("Cs", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Cs2, 0, "Pick A Car");
   	AddMenuItem(Cs2, 0, "Comet");
	AddMenuItem(Cs2, 0, "Cft30");
	AddMenuItem(Cs2, 0, "CopCarla");
	AddMenuItem(Cs2, 0, "CopCarru");
	AddMenuItem(Cs2, 0, "CopCarsf");
	AddMenuItem(Cs2, 0, "CopCarvg");
	AddMenuItem(Cs2, 0, "<Back>");
    Ds = CreateMenu("Ds", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Ds, 0, "Pick A Car");
	AddMenuItem(Ds, 0, "Dozer");
	AddMenuItem(Ds, 0, "<Back>");
	Es = CreateMenu("Es", 1, 50.0, 180.0, 200.0, 200.0);
	SetMenuColumnHeader(Es, 0, "Pick A Car");
	AddMenuItem(Es, 0, "Elegant");
	AddMenuItem(Es, 0, "Elegy");
	AddMenuItem(Es, 0, "Emperor");
	AddMenuItem(Es, 0, "Enforcer");
	AddMenuItem(Es, 0, "Esperant");
	AddMenuItem(Es, 0, "Euros");
	AddMenuItem(Es, 0, "<Back>");
    Fs = CreateMenu("Fs", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Fs, 0, "Pick A Car");
	AddMenuItem(Fs, 0, "Fbiranch");
	AddMenuItem(Fs, 0, "Fbitruck");
	AddMenuItem(Fs, 0, "Feltze");
	AddMenuItem(Fs, 0, "Firela");
	AddMenuItem(Fs, 0, "Firetruck");
	AddMenuItem(Fs, 0, "Flash");
	AddMenuItem(Fs, 0, "Flatbed");
	AddMenuItem(Fs, 0, "Forklift");
	AddMenuItem(Fs, 0, "Fortune");
	AddMenuItem(Fs, 0, "<Back>");
    Gs = CreateMenu("Gs", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Gs, 0, "Pick A Car");
	AddMenuItem(Gs, 0, "Glendale");
	AddMenuItem(Gs, 0, "Glenshit");
	AddMenuItem(Gs, 0, "Greenwoo");
	AddMenuItem(Gs, 0, "<Back>");
    Hs = CreateMenu("Hs", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Hs, 0, "Pick A Car");
	AddMenuItem(Hs, 0, "Hermes");
	AddMenuItem(Hs, 0, "Hotdog");
	AddMenuItem(Hs, 0, "Hotknife");
	AddMenuItem(Hs, 0, "Hotrina");
	AddMenuItem(Hs, 0, "Hotrinb");
	AddMenuItem(Hs, 0, "Hotring");
	AddMenuItem(Hs, 0, "Huntley");
	AddMenuItem(Hs, 0, "Hustler");
	AddMenuItem(Hs, 0, "<Back>");
    Is = CreateMenu("Is", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Is, 0, "Pick A Car");
	AddMenuItem(Is, 0, "Infernus");
	AddMenuItem(Is, 0, "Intruder");
	AddMenuItem(Is, 0, "<Back>");
    Js = CreateMenu("Js", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Js, 0, "Pick A Car");
	AddMenuItem(Js, 0, "Jester");
	AddMenuItem(Js, 0, "Journey");
	AddMenuItem(Js, 0, "<Back>");
    Ks = CreateMenu("Ks", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Ks, 0, "Pick A Car");
	AddMenuItem(Ks, 0, "Kart");
	AddMenuItem(Ks, 0, "<Back>");
    Ls = CreateMenu("Ls", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Ls, 0, "Pick A Car");
	AddMenuItem(Ls, 0, "Landstal");
	AddMenuItem(Ls, 0, "Linerun");
	AddMenuItem(Ls, 0, "<Back>");
    Ms = CreateMenu("Ms", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Ms, 0, "Pick A Car");
	AddMenuItem(Ms, 0, "Majestic");
	AddMenuItem(Ms, 0, "Manana");
	AddMenuItem(Ms, 0, "Merit");
	AddMenuItem(Ms, 0, "Mesa");
	AddMenuItem(Ms, 0, "Moonbeam");
	AddMenuItem(Ms, 0, "Mowerr");
	AddMenuItem(Ms, 0, "Mrwhoop");
	AddMenuItem(Ms, 0, "Mule");
	AddMenuItem(Ms, 0, "<Back>");
    Ns = CreateMenu("Ns", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Ns, 0, "Pick A Car");
	AddMenuItem(Ns, 0, "Nebula");
	AddMenuItem(Ns, 0, "Newsvan");
	AddMenuItem(Ns, 0, "<Back>");
    Os = CreateMenu("Os", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Os, 0, "Pick A Car");
	AddMenuItem(Os, 0, "Oceanic");
	AddMenuItem(Os, 0, "<Back>");
    Ps = CreateMenu("Ps", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Ps, 0, "Pick A Car");
	AddMenuItem(Ps, 0, "Packer");
	AddMenuItem(Ps, 0, "Patriot");
	AddMenuItem(Ps, 0, "Peren");
	AddMenuItem(Ps, 0, "Petro");
	AddMenuItem(Ps, 0, "Phoenix");
	AddMenuItem(Ps, 0, "Picador");
	AddMenuItem(Ps, 0, "Pony");
	AddMenuItem(Ps, 0, "Premier");
	AddMenuItem(Ps, 0, "Previon");
	AddMenuItem(Ps, 0, "Primo");
	AddMenuItem(Ps, 0, "<Back>");
    Rs = CreateMenu("Rs", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Rs, 0, "Pick A Car");
	AddMenuItem(Rs, 0, "Rancher");
	AddMenuItem(Rs, 0, "Rcbandit");
	AddMenuItem(Rs, 0, "Rccam");
	AddMenuItem(Rs, 0, "Rctiger");
	AddMenuItem(Rs, 0, "Rdtrain");
	AddMenuItem(Rs, 0, "Regina");
	AddMenuItem(Rs, 0, "Remingtn");
	AddMenuItem(Rs, 0, "Rhino");
	AddMenuItem(Rs, 0, "Rnchlure");
	AddMenuItem(Rs, 0, "Romero");
	AddMenuItem(Rs, 0, "Rumpo");
	AddMenuItem(Rs, 0, "<Back>");
    Ss = CreateMenu("Ss", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Ss, 0, "Pick A Car");
	AddMenuItem(Ss, 0, "Sabre");
	AddMenuItem(Ss, 0, "Sadler");
	AddMenuItem(Ss, 0, "Sadlshit");
	AddMenuItem(Ss, 0, "Sandking");
	AddMenuItem(Ss, 0, "Savanna");
	AddMenuItem(Ss, 0, "Securica");
	AddMenuItem(Ss, 0, "Sentinel");
	AddMenuItem(Ss, 0, "Slamvan");
	AddMenuItem(Ss, 0, "Stafford");
	AddMenuItem(Ss, 0, "Solair");
	AddMenuItem(Ss, 0, "<Next>");
	AddMenuItem(Ss, 0, "<Back>");
    Ss2 = CreateMenu("Ss", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Ss2, 0, "Pick A Car");
   	AddMenuItem(Ss2, 0, "Stallion");
	AddMenuItem(Ss2, 0, "Stratum");
	AddMenuItem(Ss2, 0, "Stretch");
	AddMenuItem(Ss2, 0, "Sultan");
	AddMenuItem(Ss2, 0, "Sunrise");
	AddMenuItem(Ss2, 0, "Supergt");
	AddMenuItem(Ss2, 0, "Swatvan");
	AddMenuItem(Ss2, 0, "Sweeper");
	AddMenuItem(Ss2, 0, "<Back>");
    Ts = CreateMenu("Ts", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Ts, 0, "Pick A Car");
	AddMenuItem(Ts, 0, "Tahoma");
	AddMenuItem(Ts, 0, "Tampa");
	AddMenuItem(Ts, 0, "Taxi");
	AddMenuItem(Ts, 0, "Topfun");
	AddMenuItem(Ts, 0, "Tornado");
	AddMenuItem(Ts, 0, "Towtruck");
	AddMenuItem(Ts, 0, "Tractor");
	AddMenuItem(Ts, 0, "Trash");
	AddMenuItem(Ts, 0, "Tug");
	AddMenuItem(Ts, 0, "Turismo");
	AddMenuItem(Ts, 0, "<Back>");
    Us = CreateMenu("Us", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Us, 0, "Pick A Car");
	AddMenuItem(Us, 0, "Uranus");
	AddMenuItem(Us, 0, "Utility");
	AddMenuItem(Us, 0, "<Back>");
	Vs = CreateMenu("Vs", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Vs, 0, "Pick A Car");
	AddMenuItem(Vs, 0, "Vincent");
	AddMenuItem(Vs, 0, "Virgo");
	AddMenuItem(Vs, 0, "Voodoo");
	AddMenuItem(Vs, 0, "<Back>");
    Ws = CreateMenu("Ws", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Ws, 0, "Pick A Car");
	AddMenuItem(Ws, 0, "Walton");
	AddMenuItem(Ws, 0, "Washing");
	AddMenuItem(Ws, 0, "Willard");
	AddMenuItem(Ws, 0, "Windsor");
	AddMenuItem(Ws, 0, "<Back>");
    Ys = CreateMenu("Ys", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Ys, 0, "Pick A Car");
	AddMenuItem(Ys, 0, "Yankee");
	AddMenuItem(Ys, 0, "Yosemite");
	AddMenuItem(Ys, 0, "<Back>");
//==============================================================================
    Zs = CreateMenu("Zs", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Zs, 0, "Pick A Car");
	AddMenuItem(Zs, 0, "Zr350");
	AddMenuItem(Zs, 0, "<Back>");
//==============================================================================
    Carmods = CreateMenu("Car Mods", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Carmods, 0, "Pick A Mods");
	AddMenuItem(Carmods, 0, "Nitro");
	AddMenuItem(Carmods, 0, "Hydraulics");
	AddMenuItem(Carmods, 0, "<Back>");
//==============================================================================
    PaintJobs = CreateMenu("PaintJobs", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(PaintJobs, 0, "Pick A Mods");
	AddMenuItem(PaintJobs, 0, "Pantjob 1");
	AddMenuItem(PaintJobs, 0, "Pantjob 2");
	AddMenuItem(PaintJobs, 0, "Pantjob 3");
	AddMenuItem(PaintJobs, 0, "Pantjob 4");
	AddMenuItem(PaintJobs, 0, "Pantjob 5");
	AddMenuItem(PaintJobs, 0, "<Back>");
//==============================================================================
    Rims = CreateMenu("Rims", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Rims, 0, "Pick A Mods");
	AddMenuItem(Rims, 0, "Shadow");
	AddMenuItem(Rims, 0, "Mega");
	AddMenuItem(Rims, 0, "Rimshine");
	AddMenuItem(Rims, 0, "Wires");
	AddMenuItem(Rims, 0, "Classic");
	AddMenuItem(Rims, 0, "Twist");
    AddMenuItem(Rims, 0, "Cutter");
    AddMenuItem(Rims, 0, "Switch");
    AddMenuItem(Rims, 0, "Grove");
    AddMenuItem(Rims, 0, "Import");
    AddMenuItem(Rims, 0, "Back");
    AddMenuItem(Rims, 0, "<Back>");
//==============================================================================
    Spoilers = CreateMenu("Spoilers", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Spoilers, 0, "Pick A Mods");
	AddMenuItem(Spoilers, 0, "Pro");
	AddMenuItem(Spoilers, 0, "Win");
	AddMenuItem(Spoilers, 0, "Drag");
    AddMenuItem(Spoilers, 0, "Alpha");
    AddMenuItem(Spoilers, 0, "Champ");
    AddMenuItem(Spoilers, 0, "Race");
    AddMenuItem(Spoilers, 0, "WorX");
    AddMenuItem(Spoilers, 0, "Alien");
    AddMenuItem(Spoilers, 0, "X-Flow");
    AddMenuItem(Spoilers, 0, "Back");
    AddMenuItem(Spoilers, 0, "<Back>");
//==============================================================================
    Weapons = CreateMenu("Weapons", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Weapons, 0, "Pick A Catagory");
	AddMenuItem(Weapons, 0, "Hand1");
	AddMenuItem(Weapons, 0, "Hand2");
	AddMenuItem(Weapons, 0, "Pistols");
	AddMenuItem(Weapons, 0, "SMGs");
	AddMenuItem(Weapons, 0, "Shotguns");
	AddMenuItem(Weapons, 0, "Rifles");
	AddMenuItem(Weapons, 0, "Assault_Rifles");
	AddMenuItem(Weapons, 0, "Explosives");
	AddMenuItem(Weapons, 0, "Big_Guns");
	AddMenuItem(Weapons, 0, "<Back>");
//==============================================================================
    Hand1 = CreateMenu("Hand1", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Hand1, 0, "Pick A Weapon");
	AddMenuItem(Hand1, 0, "Unarmed");
	AddMenuItem(Hand1, 0, "Brass Knuckels");
	AddMenuItem(Hand1, 0, "Golf Club");
	AddMenuItem(Hand1, 0, "Night Stick");
	AddMenuItem(Hand1, 0, "Knife");
	AddMenuItem(Hand1, 0, "Basball Bat");
	AddMenuItem(Hand1, 0, "Shovel");
	AddMenuItem(Hand1, 0, "Pool Cue");
	AddMenuItem(Hand1, 0, "Katana");
	AddMenuItem(Hand1, 0, "Chainsaw");
	AddMenuItem(Hand1, 0, "Purple Dildo");
	AddMenuItem(Hand1, 0, "White Dildo");
	AddMenuItem(Hand1, 0, "<Back>");
//==============================================================================
    Hand2 = CreateMenu("Hand2", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Hand2, 0, "Pick A Weapon");
	AddMenuItem(Hand2, 0, "Long White Dildo");
	AddMenuItem(Hand2, 0, "White Dildo 2");
	AddMenuItem(Hand2, 0, "Flowers");
	AddMenuItem(Hand2, 0, "Cane");
	AddMenuItem(Hand1, 0, "Spray Paint");
	AddMenuItem(Hand1, 0, "Fire Extinguisher");
	AddMenuItem(Hand1, 0, "Camara");
	AddMenuItem(Hand1, 0, "Nightvision Goggles");
	AddMenuItem(Hand1, 0, "Thermal Goggles");
	AddMenuItem(Hand1, 0, "Parachute");
	AddMenuItem(Hand1, 0, "<Back>");
//==============================================================================
    Pistols = CreateMenu("Pistols", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Pistols, 0, "Pick A Weapon");
	AddMenuItem(Pistols, 0, "Pistol");
	AddMenuItem(Pistols, 0, "Silenced Pistol");
	AddMenuItem(Pistols, 0, "Desert Eagle");
	AddMenuItem(Pistols, 0, "<Back>");
//==============================================================================
	SMGs = CreateMenu("SMGs", 1, 50.0, 180.0, 200.0, 200.0);
	SetMenuColumnHeader(SMGs, 0, "Pick A Weapon");
	AddMenuItem(SMGs, 0, "Mac 10");
	AddMenuItem(SMGs, 0, "Tec 9");
	AddMenuItem(SMGs, 0, "Mp5");
	AddMenuItem(SMGs, 0, "<Back>");
//==============================================================================
	Shotguns = CreateMenu("Shotguns", 1, 50.0, 180.0, 200.0, 200.0);
	SetMenuColumnHeader(Shotguns, 0, "Pick A Weapon");
	AddMenuItem(Shotguns, 0, "Shotgun");
	AddMenuItem(Shotguns, 0, "Combat Shotgun");
	AddMenuItem(Shotguns, 0, "Sawnoff Shotgun");
	AddMenuItem(Shotguns, 0, "<Back>");
//==============================================================================
    Rifles = CreateMenu("Rifles", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Rifles, 0, "Pick A Weapon");
	AddMenuItem(Rifles, 0, "Riffe");
	AddMenuItem(Rifles, 0, "Sniper Rifle");
	AddMenuItem(Rifles, 0, "<Back>");
//==============================================================================
	Assault_Rifles = CreateMenu("Assault_Rifles", 1, 50.0, 180.0, 200.0, 200.0);
	SetMenuColumnHeader(Assault_Rifles, 0, "Pick A Weapon");
	AddMenuItem(Assault_Rifles, 0, "AK 47");
	AddMenuItem(Assault_Rifles, 0, "M4");
	AddMenuItem(Assault_Rifles, 0, "<Back>");
//==============================================================================
    Explosives = CreateMenu("Explosives", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Explosives, 0, "Pick A Weapon");
	AddMenuItem(Explosives, 0, "Granades");
	AddMenuItem(Explosives, 0, "TearGas");
	AddMenuItem(Explosives, 0, "Molotoves");
	AddMenuItem(Explosives, 0, "Sachel Charges");
	AddMenuItem(Explosives, 0, "Detonater");
	AddMenuItem(Explosives, 0, "<Back>");
//==============================================================================
	Big_Guns = CreateMenu("Big_Guns", 1, 50.0, 180.0, 200.0, 200.0);
	SetMenuColumnHeader(Big_Guns, 0, "Pick A Weapon");
	AddMenuItem(Big_Guns, 0, "RPG");
	AddMenuItem(Big_Guns, 0, "Missile Lancher");
	AddMenuItem(Big_Guns, 0, "Flame Thrower");
	AddMenuItem(Big_Guns, 0, "Minigun");
	AddMenuItem(Big_Guns, 0, "<Back>");
//==============================================================================
	Teleports = CreateMenu("Teleports", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Teleports, 0, "Pick A Teleport");
	AddMenuItem(Teleports, 0, "Las Venturas");
	AddMenuItem(Teleports, 0, "San Fierro");
	AddMenuItem(Teleports, 0, "Los Santos");
	AddMenuItem(Teleports, 0, "Chilliad Top");
	AddMenuItem(Teleports, 0, "Chilliad Bottom");
	AddMenuItem(Teleports, 0, "Big Jump");
	AddMenuItem(Teleports, 0, "Area 51");
	AddMenuItem(Teleports, 0, "LV Airport");
	AddMenuItem(Teleports, 0, "LS Airport");
	AddMenuItem(Teleports, 0, "SF Airport");
	AddMenuItem(Teleports, 0, "More");
	AddMenuItem(Teleports, 0, "<Back>");
//==============================================================================
	Teleports2 = CreateMenu("Teleports", 1, 50.0, 180.0, 200.0, 200.0);
	SetMenuColumnHeader(Teleports2, 0, "Pick A Teleport");
	AddMenuItem(Teleports2, 0, "Jizzy's");
	AddMenuItem(Teleports2, 0, "The Dock's");
	AddMenuItem(Teleports2, 0, "Blueberry");
	AddMenuItem(Teleports2, 0, "Fort Carson");
	AddMenuItem(Teleports2, 0, "Grove");
	AddMenuItem(Teleports2, 0, "Drift Garage");
	AddMenuItem(Teleports2, 0, "Drift Mountain");
	AddMenuItem(Teleports2, 0, "Back");
//==============================================================================
	Times = CreateMenu("Times", 1, 50.0, 180.0, 100.0, 200.0);
	SetMenuColumnHeader(Times, 0, "Pick A Time");
	AddMenuItem(Times, 0, "2 (2AM)");
	AddMenuItem(Times, 0, "4 (4AM)");
	AddMenuItem(Times, 0, "6 (6AM)");
	AddMenuItem(Times, 0, "8 (8AM)");
	AddMenuItem(Times, 0, "10 (10AM)");
	AddMenuItem(Times, 0, "12 (12PM)");
	AddMenuItem(Times, 0, "14 (2PM)");
	AddMenuItem(Times, 0, "16 (4PM)");
	AddMenuItem(Times, 0, "18 (6PM)");
	AddMenuItem(Times, 0, "20 (8PM)");
	AddMenuItem(Times, 0, "22 (10PM)");
	AddMenuItem(Times, 0, "24 (12AM)");
	AddMenuItem(Times, 0, "<Back>");
//==============================================================================
    Weather = CreateMenu("Weather", 1, 50.0, 180.0, 200.0, 200.0);
	SetMenuColumnHeader(Weather, 0, "Pick A Mode");
	AddMenuItem(Weather, 0, "Sunny");
	AddMenuItem(Weather, 0, "Scorching Hot");
	AddMenuItem(Weather, 0, "Cloudy");
	AddMenuItem(Weather, 0, "Rainy");
	AddMenuItem(Weather, 0, "Foggy");
	AddMenuItem(Weather, 0, "Sandstorm");
	AddMenuItem(Weather, 0, "Greenish Fog");
	AddMenuItem(Weather, 0, "<Back>");
//==============================================================================
	Money = CreateMenu("Money", 1, 50.0, 180.0, 200.0, 200.0);
	SetMenuColumnHeader(Money, 0, "How Muck U Want");
	AddMenuItem(Money, 0, "$10");
	AddMenuItem(Money, 0, "$100");
	AddMenuItem(Money, 0, "$1,000");
	AddMenuItem(Money, 0, "$10,000");
	AddMenuItem(Money, 0, "$100,000");
	AddMenuItem(Money, 0, "$1,000,000");
	AddMenuItem(Money, 0, "$10,000,000");
	AddMenuItem(Money, 0, "$100,000,000");
	AddMenuItem(Money, 0, "<Back>");
//==============================================================================
	HNA = CreateMenu("Health And Armour", 1, 50.0, 180.0, 200.0, 200.0);
	SetMenuColumnHeader(HNA, 0, "Health Or Armour");
	AddMenuItem(HNA, 0, "Full Health");
	AddMenuItem(HNA, 0, "Full Armour");
	AddMenuItem(HNA, 0, "God Mode");
	AddMenuItem(HNA, 0, "<Back>");
    return 1;
}
//==============================================================================
public OnPlayerSelectedMenuRow(playerid, row){
    new Menu:current;
    current = GetPlayerMenu(playerid);
    if(current == Main)
    {
        switch(row)
        {
            case 0:
			{
				HideMenuForPlayer(Main, playerid);
                ShowMenuForPlayer(Vehicles, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 1:
			{
                HideMenuForPlayer(Main, playerid);
                ShowMenuForPlayer(Mods, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 2:
			{
                HideMenuForPlayer(Main, playerid);
                ShowMenuForPlayer(Weapons, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 3:
			{
                HideMenuForPlayer(Main, playerid);
                ShowMenuForPlayer(Teleports, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 4:
			{
                HideMenuForPlayer(Main, playerid);
                ShowMenuForPlayer(Times, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 5:
			{
                HideMenuForPlayer(Main, playerid);
                ShowMenuForPlayer(Weather, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 6:
			{
                HideMenuForPlayer(Main, playerid);
                ShowMenuForPlayer(Money, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 7:
			{
                HideMenuForPlayer(Main, playerid);
                ShowMenuForPlayer(HNA, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 8:
			{
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Main, playerid);
            }
        }
    }
//==============================================================================
    if(current == Vehicles)
    {
        switch(row)
        {
            case 0:
			{
                HideMenuForPlayer(Vehicles, playerid);
                ShowMenuForPlayer(MotorBikes, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 1:
			{
			    HideMenuForPlayer(Vehicles, playerid);
                ShowMenuForPlayer(Planes, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 2:
			{
			    HideMenuForPlayer(Vehicles, playerid);
                ShowMenuForPlayer(Boats, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 3:
			{
			    HideMenuForPlayer(Vehicles, playerid);
                ShowMenuForPlayer(Trucks, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 4:
			{
			    HideMenuForPlayer(Vehicles, playerid);
                ShowMenuForPlayer(Bicycles, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 5:
			{
			    HideMenuForPlayer(Vehicles, playerid);
                ShowMenuForPlayer(Helicopters, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 6:
			{
			    HideMenuForPlayer(Vehicles, playerid);
                ShowMenuForPlayer(Cars1, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 7:
			{
			    HideMenuForPlayer(Vehicles, playerid);
                ShowMenuForPlayer(Cars2, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 8:
			{
			    HideMenuForPlayer(Vehicles, playerid);
                ShowMenuForPlayer(Cars3, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 9:
			{
			    HideMenuForPlayer(Vehicles, playerid);
			    ShowMenuForPlayer(Main, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Cars1)
    {
        switch(row)
        {
            case 0:
			{
                HideMenuForPlayer(Cars1, playerid);
                ShowMenuForPlayer(As, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 1:
			{
			    HideMenuForPlayer(Cars1, playerid);
                ShowMenuForPlayer(Bs, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 2:
			{
			    HideMenuForPlayer(Cars1, playerid);
                ShowMenuForPlayer(Cs, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 3:
			{
			    HideMenuForPlayer(Cars1, playerid);
                ShowMenuForPlayer(Ds, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 4:
			{
			    HideMenuForPlayer(Cars1, playerid);
                ShowMenuForPlayer(Es, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 5:
			{
			    HideMenuForPlayer(Cars1, playerid);
                ShowMenuForPlayer(Fs, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 6:
			{
			    HideMenuForPlayer(Cars1, playerid);
                ShowMenuForPlayer(Gs, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 7:
			{
			    HideMenuForPlayer(Cars1, playerid);
                ShowMenuForPlayer(Hs, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 8:
			{
			    HideMenuForPlayer(Cars1, playerid);
                ShowMenuForPlayer(Is, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 9:
			{
			    HideMenuForPlayer(Cars1, playerid);
                ShowMenuForPlayer(Js, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 10:
			{
			    HideMenuForPlayer(Cars1, playerid);
                ShowMenuForPlayer(Ks, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 11:
			{
			    HideMenuForPlayer(Cars1, playerid);
			    ShowMenuForPlayer(Vehicles, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Cars2)
    {
        switch(row)
        {
            case 0:
			{
			    HideMenuForPlayer(Cars2, playerid);
                ShowMenuForPlayer(Ls, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 1:
			{
			    HideMenuForPlayer(Cars2, playerid);
                ShowMenuForPlayer(Ms, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 2:
			{
			    HideMenuForPlayer(Cars2, playerid);
                ShowMenuForPlayer(Ns, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 3:
			{
			    HideMenuForPlayer(Cars2, playerid);
                ShowMenuForPlayer(Os, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 4:
			{
			    HideMenuForPlayer(Cars2, playerid);
                ShowMenuForPlayer(Ps, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 5:
			{
			    HideMenuForPlayer(Cars2, playerid);
                ShowMenuForPlayer(Rs, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 6:
			{
			    HideMenuForPlayer(Cars2, playerid);
                ShowMenuForPlayer(Ss, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 7:
			{
			    HideMenuForPlayer(Cars2, playerid);
                ShowMenuForPlayer(Ts, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 8:
			{
			    HideMenuForPlayer(Cars2, playerid);
                ShowMenuForPlayer(Us, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 9:
			{
			    HideMenuForPlayer(Cars2, playerid);
                ShowMenuForPlayer(Vs, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 10:
			{
			    HideMenuForPlayer(Cars2, playerid);
                ShowMenuForPlayer(Ws, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 11:
			{
			    HideMenuForPlayer(Cars2, playerid);
			    ShowMenuForPlayer(Vehicles, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Cars3)
    {
        switch(row)
        {
            case 0:
			{
			    HideMenuForPlayer(Cars3, playerid);
                ShowMenuForPlayer(Ys, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 1:
			{
                HideMenuForPlayer(Cars3, playerid);
                ShowMenuForPlayer(Zs, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 2:
			{
			    HideMenuForPlayer(Cars3, playerid);
			    ShowMenuForPlayer(Vehicles, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == MotorBikes)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(521, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(MotorBikes, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(461, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(MotorBikes, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(522, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(MotorBikes, playerid);
            }
            case 3:
			{
          		new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(581, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(MotorBikes, playerid);
            }
            case 4:
			{
       			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(523, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(MotorBikes, playerid);
            }
            case 5:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(468, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(MotorBikes, playerid);
            }
            case 6:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(471, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(MotorBikes, playerid);
            }
            case 7:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(463, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(MotorBikes, playerid);
            }
            case 8:
			{
			    HideMenuForPlayer(MotorBikes, playerid);
			    ShowMenuForPlayer(Vehicles, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Planes)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(520, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Planes, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(592, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Planes, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(519, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Planes, playerid);
            }
            case 3:
			{
          		new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(464, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Planes, playerid);
            }
            case 4:
			{
       			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(577, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Planes, playerid);
            }
            case 5:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(513, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Planes, playerid);
            }
            case 6:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(476, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Planes, playerid);
            }
            case 7:
			{
			    HideMenuForPlayer(Planes, playerid);
			    ShowMenuForPlayer(Vehicles, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Boats)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(522, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Trucks, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(521, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Trucks, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(452, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Trucks, playerid);
            }
            case 3:
			{
          		new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(446, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Trucks, playerid);
            }
            case 4:
			{
       			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(472, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Trucks, playerid);
            }
            case 5:
			{
			    HideMenuForPlayer(Trucks, playerid);
			    ShowMenuForPlayer(Vehicles, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Trucks)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(406, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Trucks, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(573, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Trucks, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(444, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Trucks, playerid);
            }
            case 3:
			{
          		new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(556, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Trucks, playerid);
            }
            case 4:
			{
       			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(557, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Trucks, playerid);
            }
            case 5:
			{
			    HideMenuForPlayer(Trucks, playerid);
			    ShowMenuForPlayer(Vehicles, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Bicycles)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(509, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Bicycles, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(481, X+1,Y+3,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Bicycles, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(510, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Bicycles, playerid);
			}
            case 3:
			{
			    HideMenuForPlayer(Bicycles, playerid);
			    ShowMenuForPlayer(Vehicles, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Helicopters)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(425, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Helicopters, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(469, X+1,Y+3,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Helicopters, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(447, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Helicopters, playerid);
            }
            case 3:
			{
          		new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(501, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Helicopters, playerid);
            }
            case 4:
			{
       			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(487, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Helicopters, playerid);
			}
			case 5:
			{
       			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(497, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Helicopters, playerid);
			}
			case 6:
			{
       			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(548, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Helicopters, playerid);
			}
            case 7:
			{
			    HideMenuForPlayer(Helicopters, playerid);
			    ShowMenuForPlayer(Vehicles, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == As)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(445, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(As, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(602, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(As, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(416, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(As, playerid);
            }
            case 3:
			{
			    HideMenuForPlayer(As, playerid);
			    ShowMenuForPlayer(Cars1, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Bs)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(485, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Bs, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(568, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Bs, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(429, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Bs, playerid);
            }
            case 3:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(433, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Bs, playerid);
            }
            case 4:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(499, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Bs, playerid);
            }
            case 5:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(424, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Bs, playerid);
            }
            case 6:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(536, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Bs, playerid);
            }
            case 7:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(496, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Bs, playerid);
            }
            case 8:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(504, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Bs, playerid);
            }
            case 9:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(422, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Bs, playerid);
            }
			case 10:
			{
			HideMenuForPlayer(Bs, playerid);
   			ShowMenuForPlayer(Bs2, playerid);
   		 	TogglePlayerControllable(playerid, 0);
       		}
            case 11:
			{
			    HideMenuForPlayer(Bs, playerid);
			    ShowMenuForPlayer(Cars1, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Bs2)
    {
        switch(row)
        {
        case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(609, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Bs, playerid);
            }
        case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(498, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Bs, playerid);
            }
            case 2:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(401, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Bs2, playerid);
            }
            case 3:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(575, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Bs2, playerid);
            }
            case 4:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(518, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Bs2, playerid);
            }
            case 5:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(402, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Bs2, playerid);
            }
            case 6:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(541, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Bs2, playerid);
            }
            case 7:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(482, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Bs2, playerid);
            }
            case 8:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(431, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Bs2, playerid);
            }
            case 9:
			{
			    HideMenuForPlayer(Bs2, playerid);
			    ShowMenuForPlayer(Cars1, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Cs)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(438, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Cs, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(457, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Cs, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(527, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Cs, playerid);
            }
            case 3:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(483, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Cs, playerid);
            }
            case 4:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(524, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Cs, playerid);
            }
            case 5:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(415, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Cs, playerid);
            }
            case 6:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(542, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Cs, playerid);
            }
            case 7:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(589, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Cs, playerid);
            }
            case 8:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(437, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Cs, playerid);
            }
            case 9:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(532, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Cs, playerid);
            }
            case 10:
			{
			    HideMenuForPlayer(Cs, playerid);
			    ShowMenuForPlayer(Cs2, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 11:
			{
			    HideMenuForPlayer(Cs, playerid);
			    ShowMenuForPlayer(Cars1, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Cs2)
    {
        switch(row)
        {
        	case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(480, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Cs, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(578, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Cs, playerid);
            }
            case 2:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(596, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Cs2, playerid);
            }
            case 3:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(599, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Cs2, playerid);
            }
            case 4:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(597, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Cs2, playerid);
            }
            case 5:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(598, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Cs2, playerid);
            }
            case 6:
			{
			    HideMenuForPlayer(Cs2, playerid);
			    ShowMenuForPlayer(Cars1, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Ds)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(486, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ds, playerid);
            }
            case 1:
			{
			    HideMenuForPlayer(Ds, playerid);
			    ShowMenuForPlayer(Cars1, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Es)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(507, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Es, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(562, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Es, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(585, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Es, playerid);
            }
            case 3:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(427, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Es, playerid);
            }
            case 4:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(419, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Es, playerid);
            }
            case 5:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(587, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Es, playerid);
            }
            case 6:
			{
			    HideMenuForPlayer(Es, playerid);
			    ShowMenuForPlayer(Cars1, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Fs)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(490, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Fs, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(528, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Fs, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(533, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Fs, playerid);
            }
            case 3:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(544, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Fs, playerid);
            }
            case 4:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(407, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Fs, playerid);
            }
            case 5:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(565, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Fs, playerid);
            }
            case 6:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(455, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Fs, playerid);
            }
            case 7:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(530, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Fs, playerid);
            }
            case 8:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(526, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Fs, playerid);
            }
            case 9:
			{
			    HideMenuForPlayer(Fs, playerid);
			    ShowMenuForPlayer(Cars1, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Gs)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(466, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Gs, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(604, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Gs, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(492, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Gs, playerid);
            }
            case 3:
			{
			    HideMenuForPlayer(Gs, playerid);
			    ShowMenuForPlayer(Cars1, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Hs)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(474, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Hs, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(588, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Hs, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(434, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Hs, playerid);
            }
            case 3:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(502, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Hs, playerid);
            }
            case 4:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(503, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Hs, playerid);
            }
            case 5:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(494, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Hs, playerid);
            }
            case 6:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(579, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Hs, playerid);
            }
            case 7:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(545, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Hs, playerid);
            }
            case 8:
			{
			    HideMenuForPlayer(Hs, playerid);
			    ShowMenuForPlayer(Cars1, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Is)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(411, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Is, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(546, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Is, playerid);
            }
            case 2:
			{
			    HideMenuForPlayer(Is, playerid);
			    ShowMenuForPlayer(Cars1, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Js)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(559, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Js, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(508, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Js, playerid);
            }
            case 2:
			{
			    HideMenuForPlayer(Js, playerid);
			    ShowMenuForPlayer(Cars1, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Ks)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(571, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ks, playerid);
            }
            case 1:
			{
			    HideMenuForPlayer(Ks, playerid);
			    ShowMenuForPlayer(Cars2, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Ls)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(400, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ls, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(403, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ls, playerid);
            }
            case 2:
			{
			    HideMenuForPlayer(Ls, playerid);
			    ShowMenuForPlayer(Cars2, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Ms)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(517, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ms, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(410, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ms, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(551, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ms, playerid);
            }
            case 3:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(500, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ms, playerid);
            }
            case 4:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(418, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ms, playerid);
            }
            case 5:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(572, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ms, playerid);
            }
            case 6:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(423, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ms, playerid);
            }
            case 7:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(414, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ms, playerid);
            }
            case 8:
			{
			    HideMenuForPlayer(Ms, playerid);
			    ShowMenuForPlayer(Cars2, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Ns)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(516, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ns, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(582, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ns, playerid);
            }
            case 2:
			{
			    HideMenuForPlayer(Ns, playerid);
			    ShowMenuForPlayer(Cars2, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Os)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(467, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Os, playerid);
            }
            case 1:
			{
			    HideMenuForPlayer(Os, playerid);
			    ShowMenuForPlayer(Cars2, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Ps)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(443, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ps, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(470, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ps, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(404, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ps, playerid);
            }
            case 3:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(514, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ps, playerid);
            }
            case 4:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(603, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ps, playerid);
            }
            case 5:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(600, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ps, playerid);
            }
            case 6:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(413, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ps, playerid);
            }
            case 7:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(426, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ps, playerid);
            }
            case 8:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(436, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ps, playerid);
            }
            case 9:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(547, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ps, playerid);
            }
            case 10:
			{
			    HideMenuForPlayer(Ps, playerid);
			    ShowMenuForPlayer(Cars2, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Rs)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(489, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Rs, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(441, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Rs, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(594, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Rs, playerid);
            }
            case 3:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(564, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Rs, playerid);
            }
            case 4:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(515, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Rs, playerid);
            }
            case 5:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(479, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Rs, playerid);
            }
            case 6:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(534, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Rs, playerid);
            }
            case 7:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(432, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Rs, playerid);
            }
            case 8:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(505, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Rs, playerid);
            }
            case 9:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(442, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Rs, playerid);
            }
            case 10:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(440, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Rs, playerid);
            }
            case 11:
			{
			    HideMenuForPlayer(Rs, playerid);
			    ShowMenuForPlayer(Cars2, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Ss)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(475, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ss, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(543, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ss, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(605, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ss, playerid);
            }
            case 3:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(495, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ss, playerid);
            }
            case 4:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(567, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ss, playerid);
            }
            case 5:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(428, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ss, playerid);
            }
            case 6:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(405, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ss, playerid);
            }
            case 7:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(535, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ss, playerid);
            }
            case 8:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(458, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ss, playerid);
            }
            case 9:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(580, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ss, playerid);
            }
            case 10:
			{
			    HideMenuForPlayer(Ss, playerid);
			    ShowMenuForPlayer(Ss2, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 12:
			{
			    HideMenuForPlayer(Ss, playerid);
			    ShowMenuForPlayer(Cars2, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Ss2)
    {
        switch(row)
        {
        	case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(439, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ss, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(561, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ss, playerid);
            }
            case 2:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(409, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ss2, playerid);
            }
            case 3:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(560, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ss2, playerid);
            }
            case 4:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(550, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ss2, playerid);
            }
            case 5:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(506, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ss2, playerid);
            }
            case 6:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(601, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ss2, playerid);
            }
            case 7:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(574, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ss2, playerid);
            }
            case 8:
			{
			    HideMenuForPlayer(Ss2, playerid);
			    ShowMenuForPlayer(Cars2, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Ts)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(566, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ts, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(549, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ts, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(420, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ts, playerid);
            }
            case 3:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(459, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ts, playerid);
            }
            case 4:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(576, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ts, playerid);
            }
            case 5:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(525, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ts, playerid);
            }
            case 6:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(531, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ts, playerid);
            }
            case 7:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(408, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ts, playerid);
            }
            case 8:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(583, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ts, playerid);
            }
            case 9:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(451, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ts, playerid);
            }
            case 10:
			{
			    HideMenuForPlayer(Ts, playerid);
			    ShowMenuForPlayer(Cars2, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Us)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(558, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Us, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(552, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Us, playerid);
            }
            case 2:
			{
			    HideMenuForPlayer(Us, playerid);
			    ShowMenuForPlayer(Cars2, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Vs)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(540, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Vs, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(491, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Vs, playerid);
            }
            case 2:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(412, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Vs, playerid);
            }
            case 3:
			{
			    HideMenuForPlayer(Vs, playerid);
			    ShowMenuForPlayer(Cars2, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Ws)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(578, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ws, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(421, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ws, playerid);
            }
            case 2:
			{
 	 			new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(529, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ws, playerid);
            }
            case 3:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(555, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ws, playerid);
            }
            case 4:
			{
			    HideMenuForPlayer(Ws, playerid);
			    ShowMenuForPlayer(Cars3, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Ys)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(456, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Ys, playerid);
            }
            case 1:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(554, X,Y+2,Z+1,0.0,-1,-1,50000);
			    TogglePlayerControllable(playerid, 1);
			    HideMenuForPlayer(Ys, playerid);
            }
            case 2:
			{
			    HideMenuForPlayer(Ys, playerid);
			    ShowMenuForPlayer(Cars3, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Zs)
    {
        switch(row)
        {
            case 0:
			{
			    new Float:X,Float:Y,Float:Z;
				GetPlayerPos(playerid, X,Y,Z);
                CreateVehicle(477, X, Y+2, Z+1, 0.0, -1, -1, 50000);
                TogglePlayerControllable(playerid, 1);
                HideMenuForPlayer(Zs, playerid);
            }
            case 1:
			{
			    HideMenuForPlayer(Zs, playerid);
			    ShowMenuForPlayer(Cars3, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Mods)
   {
        switch(row)
        {
            case 0:
			{
                HideMenuForPlayer(Mods, playerid);
                ShowMenuForPlayer(Carmods, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 1:
			{
			    HideMenuForPlayer(Mods, playerid);
                ShowMenuForPlayer(PaintJobs, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 2:
			{
				HideMenuForPlayer(Mods, playerid);
                ShowMenuForPlayer(Rims, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 3:
			{
                HideMenuForPlayer(Mods, playerid);
                ShowMenuForPlayer(Spoilers, playerid);
                TogglePlayerControllable(playerid, 0);
	        }
            case 4:
			{
                HideMenuForPlayer(Mods, playerid);
                ShowMenuForPlayer(Main, playerid);
                TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Carmods)
    {
        switch(row)
        {
            case 0:
			{
			    HideMenuForPlayer(Carmods, playerid);
                AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
                TogglePlayerControllable(playerid, 1);

            }
            case 1:
			{
			    HideMenuForPlayer(Carmods, playerid);
                AddVehicleComponent(GetPlayerVehicleID(playerid), 1087);
                TogglePlayerControllable(playerid, 1);
			}
   			case 2:
   			{
   				HideMenuForPlayer(Carmods, playerid);
   			    ShowMenuForPlayer(Mods, playerid);
                TogglePlayerControllable(playerid, 0);
            }
		}
	}
//==============================================================================
	if(current == PaintJobs)
    {
        switch(row)
        {
            case 0:
			{
			    ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), 1);
                HideMenuForPlayer(PaintJobs, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 1:
			{
			    ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), 2);
                HideMenuForPlayer(PaintJobs, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 2:
			{
			    ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), 3);
                HideMenuForPlayer(PaintJobs, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 3:
			{
			    ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), 4);
                HideMenuForPlayer(PaintJobs, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 4:
			{
			    ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), 5);
                HideMenuForPlayer(PaintJobs, playerid);
                TogglePlayerControllable(playerid, 1);
                }
        	case 5:
        	{
				HideMenuForPlayer(Carmods, playerid);
   				ShowMenuForPlayer(Mods, playerid);
   				TogglePlayerControllable(playerid, 0);
            }
		}
	}
//==============================================================================
 	if(current == Rims)
    {
        switch(row)
        {
            case 0:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1073);
                HideMenuForPlayer(Rims, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 1:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1074);
                HideMenuForPlayer(Rims, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 2:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1075);
                HideMenuForPlayer(Rims, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 3:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1076);
                HideMenuForPlayer(Rims, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 4:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1077);
                HideMenuForPlayer(Rims, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 5:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1078);
                HideMenuForPlayer(Rims, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 6:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1079);
                HideMenuForPlayer(Rims, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 7:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                HideMenuForPlayer(Rims, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 8:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1081);
                HideMenuForPlayer(Rims, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 9:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1082);
                HideMenuForPlayer(Rims, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 10:
			{
                HideMenuForPlayer(Rims, playerid);
                ShowMenuForPlayer(Mods, playerid);
   				TogglePlayerControllable(playerid, 0);
            }
		}
	}
//==============================================================================
	if(current == Spoilers)
    {
        switch(row)
        {
            case 0:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1000);
                HideMenuForPlayer(Spoilers, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 1:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1001);
                HideMenuForPlayer(Spoilers, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 2:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1002);
                HideMenuForPlayer(Spoilers, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 3:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1002);
                HideMenuForPlayer(Spoilers, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 4:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1002);
                HideMenuForPlayer(Spoilers, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 5:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1014);
                HideMenuForPlayer(Spoilers, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 6:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1015);
                HideMenuForPlayer(Spoilers, playerid);
                TogglePlayerControllable(playerid, 1);
            }
			case 7:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1016);
                HideMenuForPlayer(Spoilers, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 8:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1138);
                HideMenuForPlayer(Spoilers, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 9:
			{
			    AddVehicleComponent(GetPlayerVehicleID(playerid), 1139);
                HideMenuForPlayer(Spoilers, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 10:
			{
                HideMenuForPlayer(Spoilers, playerid);
                ShowMenuForPlayer(Mods, playerid);
   				TogglePlayerControllable(playerid, 0);
           }
        }
    }
//==============================================================================
    if(current == Weapons)
    {
        switch(row)
        {
            case 0:
			{
                HideMenuForPlayer(Weapons, playerid);
                ShowMenuForPlayer(Hand1, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 1:
			{
			    HideMenuForPlayer(Weapons, playerid);
                ShowMenuForPlayer(Hand2, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 2:
			{
			    HideMenuForPlayer(Weapons, playerid);
                ShowMenuForPlayer(Pistols, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 3:
			{
			    HideMenuForPlayer(Weapons, playerid);
                ShowMenuForPlayer(SMGs, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 4:
			{
			    HideMenuForPlayer(Weapons, playerid);
                ShowMenuForPlayer(Shotguns, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 5:
			{
			    HideMenuForPlayer(Weapons, playerid);
                ShowMenuForPlayer(Rifles, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 6:
			{
			    HideMenuForPlayer(Weapons, playerid);
                ShowMenuForPlayer(Assault_Rifles, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 7:
			{
			    HideMenuForPlayer(Weapons, playerid);
                ShowMenuForPlayer(Explosives, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 8:
			{
			    HideMenuForPlayer(Weapons, playerid);
                ShowMenuForPlayer(Big_Guns, playerid);
                TogglePlayerControllable(playerid, 0);
            }
            case 9:
			{
			    HideMenuForPlayer(Weapons, playerid);
			    ShowMenuForPlayer(Mods, playerid);
   				TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Hand1)
    {
        switch(row)
        {
            case 0:
			{
                GivePlayerWeapon(playerid, 0, 1);
                TogglePlayerControllable(playerid, 1);
            }
            case 1:
			{
			    GivePlayerWeapon(playerid, 1, 1);
			    TogglePlayerControllable(playerid, 1);
            }
            case 2:
			{
			    GivePlayerWeapon(playerid, 2, 1);
			    TogglePlayerControllable(playerid, 1);
            }
            case 3:
			{
			    GivePlayerWeapon(playerid, 3, 1);
			    TogglePlayerControllable(playerid, 1);
            }
            case 4:
			{
			    GivePlayerWeapon(playerid, 4, 1);
			    TogglePlayerControllable(playerid, 1);
            }
            case 5:
			{
			    GivePlayerWeapon(playerid, 5, 1);
			    TogglePlayerControllable(playerid, 1);
            }
            case 6:
			{
			    GivePlayerWeapon(playerid, 6, 1);
			    TogglePlayerControllable(playerid, 1);
            }
            case 7:
			{
			    GivePlayerWeapon(playerid, 7, 1);
			    TogglePlayerControllable(playerid, 1);
            }
            case 8:
			{
			    GivePlayerWeapon(playerid, 8, 1);
			    TogglePlayerControllable(playerid, 1);
            }
            case 9:
			{
			    GivePlayerWeapon(playerid, 9, 1);
			    TogglePlayerControllable(playerid, 1);
            }
            case 10:
			{
			    GivePlayerWeapon(playerid, 10, 1);
			    TogglePlayerControllable(playerid, 1);
            }
            case 11:
			{
			    GivePlayerWeapon(playerid, 11, 1);
			    TogglePlayerControllable(playerid, 1);
            }
            case 12:
			{
			    HideMenuForPlayer(Hand1, playerid);
			    ShowMenuForPlayer(Weapons, playerid);
   				TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Hand2)
    {
        switch(row)
        {
            case 0:
			{
                GivePlayerWeapon(playerid, 12, 1);
                TogglePlayerControllable(playerid, 1);
            }
            case 1:
			{
			    GivePlayerWeapon(playerid, 13, 1);
			    TogglePlayerControllable(playerid, 1);
            }
            case 2:
			{
			    GivePlayerWeapon(playerid, 14, 1);
			    TogglePlayerControllable(playerid, 1);
            }
            case 3:
			{
			    GivePlayerWeapon(playerid, 15, 1);
			    TogglePlayerControllable(playerid, 1);
            }
            case 4:
			{
			    GivePlayerWeapon(playerid, 41, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 5:
			{
			    GivePlayerWeapon(playerid, 42, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 6:
			{
			    GivePlayerWeapon(playerid, 43, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 7:
			{
			    GivePlayerWeapon(playerid, 44, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 8:
			{
			    GivePlayerWeapon(playerid, 45, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 9:
			{
			    GivePlayerWeapon(playerid, 46, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 10:
			{
			    HideMenuForPlayer(Hand2, playerid);
			    ShowMenuForPlayer(Weapons, playerid);
   				TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Pistols)
    {
        switch(row)
        {
            case 0:
			{
                GivePlayerWeapon(playerid, 22, 100000000);
                TogglePlayerControllable(playerid, 1);
            }
            case 1:
			{
			    GivePlayerWeapon(playerid, 23, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 2:
			{
			    GivePlayerWeapon(playerid, 24, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 3:
			{
			    HideMenuForPlayer(Pistols, playerid);
			    ShowMenuForPlayer(Weapons, playerid);
   				TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == SMGs)
    {
        switch(row)
        {
            case 0:
			{
                GivePlayerWeapon(playerid, 28, 100000000);
                TogglePlayerControllable(playerid, 1);
            }
            case 1:
			{
			    GivePlayerWeapon(playerid, 32, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 2:
			{
			    GivePlayerWeapon(playerid, 29, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 3:
			{
			    HideMenuForPlayer(SMGs, playerid);
			    ShowMenuForPlayer(Weapons, playerid);
   				TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Shotguns)
    {
        switch(row)
        {
            case 0:
			{
                GivePlayerWeapon(playerid, 25, 100000000);
                TogglePlayerControllable(playerid, 1);
            }
            case 1:
			{
			    GivePlayerWeapon(playerid, 27, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 2:
			{
			    GivePlayerWeapon(playerid, 26, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 3:
			{
			    HideMenuForPlayer(Shotguns, playerid);
			    ShowMenuForPlayer(Weapons, playerid);
   				TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Rifles)
    {
        switch(row)
        {
            case 0:
			{
                GivePlayerWeapon(playerid, 33, 100000000);
                TogglePlayerControllable(playerid, 1);
            }
            case 1:
			{
			    GivePlayerWeapon(playerid, 34, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 2:
			{
			    HideMenuForPlayer(Rifles, playerid);
			    ShowMenuForPlayer(Weapons, playerid);
   				TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Assault_Rifles)
    {
        switch(row)
        {
            case 0:
			{
                GivePlayerWeapon(playerid, 30, 100000000);
                TogglePlayerControllable(playerid, 1);
            }
            case 1:
			{
			    GivePlayerWeapon(playerid, 31, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 2:
			{
			    HideMenuForPlayer(Assault_Rifles, playerid);
			    ShowMenuForPlayer(Weapons, playerid);
   				TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Explosives)
    {
        switch(row)
        {
            case 0:
			{
                GivePlayerWeapon(playerid, 16, 100000000);
                TogglePlayerControllable(playerid, 1);
            }
            case 1:
			{
			    GivePlayerWeapon(playerid, 17, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 2:
			{
			    GivePlayerWeapon(playerid, 18, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 3:
			{
			    GivePlayerWeapon(playerid, 39, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 4:
			{
			    GivePlayerWeapon(playerid, 40, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 5:
			{
			    HideMenuForPlayer(Explosives, playerid);
			    ShowMenuForPlayer(Weapons, playerid);
   				TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Big_Guns)
    {
        switch(row)
        {
            case 0:
			{
                GivePlayerWeapon(playerid, 36, 100000000);
                TogglePlayerControllable(playerid, 1);
            }
            case 1:
			{
			    GivePlayerWeapon(playerid, 37, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 2:
			{
			    GivePlayerWeapon(playerid, 38, 100000000);
			    TogglePlayerControllable(playerid, 1);
            }
            case 3:
			{
			    HideMenuForPlayer(Big_Guns, playerid);
			    ShowMenuForPlayer(Weapons, playerid);
   				TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Teleports)
    {
        switch(row)
        {
            case 0:
			{
			    SetPlayerPos(playerid,2025.8523,1545.7911,10.8203);
                HideMenuForPlayer(Teleports, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 1:
			{
			    SetPlayerPos(playerid,-1982.2228,137.7788,27.6875);
                HideMenuForPlayer(Teleports, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 2:
			{
			    SetPlayerPos(playerid,1480.0035,-1721.4694,13.5469);
                HideMenuForPlayer(Teleports, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 3:
			{
			    SetPlayerPos(playerid,-2296.2568,-1679.0115,483.5968);
                HideMenuForPlayer(Teleports, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 4:
			{
			    SetPlayerPos(playerid,-2374.6802,-2195.8906,33.3593);
                HideMenuForPlayer(Teleports, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 5:
			{
			    SetPlayerPos(playerid,-720.8749,2307.2117,127.7984);
                HideMenuForPlayer(Teleports, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 6:
			{
			    SetPlayerPos(playerid,200.5789,1888.0072,17.6481);
                HideMenuForPlayer(Teleports, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 7:
			{
			    SetPlayerPos(playerid,1626.9131,1564.8002,10.8203);
                HideMenuForPlayer(Teleports, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 8:
			{
			    SetPlayerPos(playerid,1474.4506,-2286.6631,42.4205);
                HideMenuForPlayer(Teleports, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 9:
			{
			    SetPlayerPos(playerid,-1360.2729,-245.2704,14.1440);
                HideMenuForPlayer(Teleports, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 10:
			{
                HideMenuForPlayer(Teleports, playerid);
                ShowMenuForPlayer(Teleports2, playerid);
                TogglePlayerControllable(playerid, 1);
			}
			case 11:
			{
				HideMenuForPlayer(Teleports, playerid);
			    ShowMenuForPlayer(Main, playerid);
   				TogglePlayerControllable(playerid, 0);
            }
		}
	}
//==============================================================================
	if(current == Teleports2)
    {
        switch(row)
        {
            case 0:
			{
			    SetPlayerPos(playerid,-2645.5679,1376.8672,7.1663);
                HideMenuForPlayer(Teleports2, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 1:
			{
			    SetPlayerPos(playerid,-2232.7322,2401.4155,2.4871);
                HideMenuForPlayer(Teleports2, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 2:
			{
			    SetPlayerPos(playerid,288.9783,-150.4326,1.5781);
                HideMenuForPlayer(Teleports2, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 3:
			{
			    SetPlayerPos(playerid,174.9130,1215.7645,22.0946);
                HideMenuForPlayer(Teleports2, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 4:
			{
			    SetPlayerPos(playerid,2496.9861,-1666.8295,13.3438);
                HideMenuForPlayer(Teleports2, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 5:
			{
			    SetPlayerPos(playerid,2327.7197,1391.6312,42.8203);
                HideMenuForPlayer(Teleports2, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 6:
			{
                SetPlayerPos(playerid,2496.9861,-1666.8295,13.3438);
                HideMenuForPlayer(Teleports2, playerid);
                TogglePlayerControllable(playerid, 1);
            }
            case 7:
			{
                HideMenuForPlayer(Teleports2, playerid);
                ShowMenuForPlayer(Teleports, playerid);
            }
	    }
 	}
//==============================================================================
 	if(current == Times)
    {
        switch(row)
        {
            case 0:
			{
			    SetWorldTime(2);
			    HideMenuForPlayer(Times, playerid);
			    TogglePlayerControllable(playerid, 1);
            }
            case 1:
			{
			    SetWorldTime(4);
			    HideMenuForPlayer(Times, playerid);
			    TogglePlayerControllable(playerid, 1);
            }
            case 2:
			{
 	 			SetWorldTime(6);
			    HideMenuForPlayer(Times, playerid);
			    TogglePlayerControllable(playerid, 1);
            }
            case 3:
			{
          		SetWorldTime(8);
			    HideMenuForPlayer(Times, playerid);
			    TogglePlayerControllable(playerid, 1);
            }
            case 4:
			{
       			SetWorldTime(10);
			    HideMenuForPlayer(Times, playerid);
			    TogglePlayerControllable(playerid, 1);
			}
            case 5:
			{
			    SetWorldTime(12);
			    HideMenuForPlayer(Times, playerid);
			    TogglePlayerControllable(playerid, 1);
            }
            case 6:
			{
			    SetWorldTime(14);
			    HideMenuForPlayer(Times, playerid);
			    TogglePlayerControllable(playerid, 1);
            }
            case 7:
			{
			    SetWorldTime(16);
			    HideMenuForPlayer(Times, playerid);
			    TogglePlayerControllable(playerid, 1);
            }
            case 8:
			{
			    SetWorldTime(18);
			    HideMenuForPlayer(Times, playerid);
			    TogglePlayerControllable(playerid, 1);
            }
            case 9:
			{
			    SetWorldTime(20);
			    HideMenuForPlayer(Times, playerid);
			    TogglePlayerControllable(playerid, 1);
            }
            case 10:
			{
			    SetWorldTime(22);
			    HideMenuForPlayer(Times, playerid);
			    TogglePlayerControllable(playerid, 1);
            }
            case 11:
			{
			    SetWorldTime(24);
			    HideMenuForPlayer(Times, playerid);
			    TogglePlayerControllable(playerid, 1);
            }
            case 12:
			{
			    HideMenuForPlayer(Times, playerid);
			    ShowMenuForPlayer(Main, playerid);
   				TogglePlayerControllable(playerid, 0);
            }
        }
    }
//==============================================================================
    if(current == Weather)
    {
        switch(row)
        {
            case 0:
			{
			    SetWeather(1);
			    HideMenuForPlayer(Weather, playerid);
			    TogglePlayerControllable(playerid, 1);
            }
            case 1:
			{
			    SetWeather(11);
			    HideMenuForPlayer(Weather, playerid);
			    TogglePlayerControllable(playerid, 1);
            }
            case 2:
			{
      			SetWeather(7);
			    HideMenuForPlayer(Weather, playerid);
			    TogglePlayerControllable(playerid, 1);
            }
            case 3:
			{
          		SetWeather(8);
			    HideMenuForPlayer(Weather, playerid);
			    TogglePlayerControllable(playerid, 1);
            }
            case 4:
			{
          		SetWeather(9);
			    HideMenuForPlayer(Weather, playerid);
			    TogglePlayerControllable(playerid, 1);
			}
            case 5:
			{
			    SetWeather(19);
			    HideMenuForPlayer(Weather, playerid);
			    TogglePlayerControllable(playerid, 1);
            }
            case 6:
			{
			    SetWeather(20);
			    HideMenuForPlayer(Weather, playerid);
			    TogglePlayerControllable(playerid, 1);
            }
            case 7:
			{
			    HideMenuForPlayer(Weather, playerid);
			    ShowMenuForPlayer(Main, playerid);
   				TogglePlayerControllable(playerid, 0);
            }

        }
    }
//==============================================================================
	if(current == Money)
    {
    switch(row)
    {
	case 0:
	{
	GivePlayerMoney(playerid,10);
	}
	case 1:
	{
	GivePlayerMoney(playerid,100);
	}
	case 2:
	{
	GivePlayerMoney(playerid,1000);
	}
	case 3:
	{
	GivePlayerMoney(playerid,10000);
	}
	case 4:
	{
	GivePlayerMoney(playerid,100000);
	}
	case 5:
	{
	GivePlayerMoney(playerid,1000000);
	}
	case 6:
	{
	GivePlayerMoney(playerid,10000000);
	}
	case 7:
	{
	GivePlayerMoney(playerid,100000000);
	}
	case 8:
	{
	HideMenuForPlayer(Money, playerid);
	ShowMenuForPlayer(Main, playerid);
	TogglePlayerControllable(playerid, 0);
 	    	}
 		}
	}
//==============================================================================
	if(current == HNA)
    {
    switch(row)
    {
    case 0:
	{
	SetPlayerHealth(playerid,100.0);
	}
	case 1:
	{
	SetPlayerArmour(playerid,100.0);
	}
	case 2:
	{
	SetPlayerArmour(playerid, 100000000000000000000000000000000000000000000000);
	SetPlayerHealth(playerid, 100000000000000000000000000000000000000000000000);
	}
	case 3:
	{
	SetPlayerHealth(playerid, 100);
	SetPlayerArmour(playerid, 100);
	}
	case 4:
	{
	HideMenuForPlayer(HNA, playerid);
	ShowMenuForPlayer(Main, playerid);
	TogglePlayerControllable(playerid, 0);
			}
 		}
	}
    return 1;
}
//==============================================================================
public SendMSG(){
	SendClientMessageToAll(0xAFAFAFAA, RandomMSG[random(sizeof(RandomMSG))]);
	return 1;
}
//==============================================================================
public OnPlayerCommandText(playerid, cmdtext[])	{
	if(strcmp(cmdtext, "/Handy", true) == 0)
	{
	if(IsPlayerMaster(playerid))
	{
	ShowMenuForPlayer(Main, playerid);
	TogglePlayerControllable(playerid, 0);
	SendClientMessage(playerid, COLOR_GREEN, "Welcome To The Main Menu");
	}
	else SendClientMessage(playerid, COLOR_RED, "You are not an Admin.");
	return 1;
	}
//==============================================================================
if(strcmp(cmdtext, "/Mods", true) == 0)
	{
	if(IsPlayerMaster(playerid))
	{
	ShowMenuForPlayer(Mods, playerid);
	TogglePlayerControllable(playerid, 0);
	SendClientMessage(playerid, COLOR_GREEN, "Welcome To The Mods Menu");
	}
	else SendClientMessage(playerid, COLOR_RED, "You are not an Admin.");
	return 1;
	}
//==============================================================================
if(strcmp(cmdtext, "/Guns", true) == 0)
	{
	if(IsPlayerMaster(playerid))
	{
	ShowMenuForPlayer(Weapons, playerid);
	TogglePlayerControllable(playerid, 0);
	SendClientMessage(playerid, COLOR_GREEN, "Welcome To The Weapons Menu");
	}
	else SendClientMessage(playerid, COLOR_RED, "You are not an Admin.");
	return 1;
	}
//==============================================================================
if(strcmp(cmdtext, "/TPS", true) == 0)
	{
	if(IsPlayerMaster(playerid))
	{
	ShowMenuForPlayer(Teleports, playerid);
	TogglePlayerControllable(playerid, 0);
	SendClientMessage(playerid, COLOR_GREEN, "Welcome To The Teleports Menu");
	}
	else SendClientMessage(playerid, COLOR_RED, "You are not an Admin.");
	return 1;
	}
//==============================================================================
if(strcmp(cmdtext, "/Time", true) == 0)
	{
	if(IsPlayerMaster(playerid))
	{
	ShowMenuForPlayer(Weapons, playerid);
	TogglePlayerControllable(playerid, 0);
	SendClientMessage(playerid, COLOR_GREEN, "Welcome To The Time Menu");
	}
	else SendClientMessage(playerid, COLOR_RED, "You are not an Admin.");
	return 1;
	}
//==============================================================================
if(strcmp(cmdtext, "/Weather", true) == 0)
	{
	if(IsPlayerMaster(playerid))
	{
	ShowMenuForPlayer(Weapons, playerid);
	TogglePlayerControllable(playerid, 0);
	SendClientMessage(playerid, COLOR_GREEN, "Welcome To The Weather Menu");
	}
	else SendClientMessage(playerid, COLOR_RED, "You are not an Admin.");
	return 1;
	}
//==============================================================================
if(strcmp(cmdtext, "/Money", true) == 0)
	{
	if(IsPlayerMaster(playerid))
	{
	ShowMenuForPlayer(Weapons, playerid);
	TogglePlayerControllable(playerid, 0);
	SendClientMessage(playerid, COLOR_GREEN, "Welcome To The Money Menu");
	}
	else SendClientMessage(playerid, COLOR_RED, "You are not an Admin.");
	return 1;
	}
//==============================================================================
if(strcmp(cmdtext, "/HA", true) == 0)
	{
	if(IsPlayerMaster(playerid))
	{
	ShowMenuForPlayer(Weapons, playerid);
	TogglePlayerControllable(playerid, 0);
	SendClientMessage(playerid, COLOR_GREEN, "Welcome To The Health & Armour Menu");
	}
	else SendClientMessage(playerid, COLOR_RED, "You are not an Admin.");
	return 1;
	}
//==============================================================================
	if(strcmp(cmdtext, "/HandyHelp", true) == 0)
	{
	if(IsPlayerMaster(playerid))
	{
	SendClientMessage(playerid, COLOR_GREEN, "/Handy   -  Main Menu");
	SendClientMessage(playerid, COLOR_GREEN, "/Mods    -  Mods Menu");
	SendClientMessage(playerid, COLOR_GREEN, "/Guns    -  Weapons Menu");
	SendClientMessage(playerid, COLOR_GREEN, "/TPS     -  Teleports Menu");
	SendClientMessage(playerid, COLOR_GREEN, "/Time    -  Times Menu");
	SendClientMessage(playerid, COLOR_GREEN, "/Weather -  Weather Menu");
	SendClientMessage(playerid, COLOR_GREEN, "/Money   -  Money Menu");
	SendClientMessage(playerid, COLOR_GREEN, "/HA      -  Health & Armour Menu");
	SendClientMessage(playerid, COLOR_GREEN, "/Banme   -  Anyone Who Types This Will Be Ip Baned");
	SendClientMessage(playerid, COLOR_GREEN, "/Credits -  Showes Credits");
	SendClientMessage(playerid, COLOR_GREEN, "/Car     -  Gives Player A Car");
	}
	else SendClientMessage(playerid, COLOR_RED, "You are not an Admin.");
	return 1;
	}
//==============================================================================
	if(strcmp(cmdtext, "/Credits", true) == 0)
	{
	SendClientMessage(playerid, COLOR_GREEN, "D4RKKNIGH7 Made This Script");
	SendClientMessage(playerid, COLOR_GREEN, "If You Have An Idea Please Email Me At nignogster@gmail.com");
	SendClientMessage(playerid, COLOR_GREEN, "Thank You for Using My Script");
	return 1;
	}
//==============================================================================
if (strcmp("/Banme", cmdtext, true, 10) == 0)
	{
 		new pname[24],reason[256];
        GetPlayerName(playerid, pname, 24);
		format(reason, sizeof (reason), "%s has banned themselfs  .",pname);
		SendClientMessageToAll(0xFFFF75FF, reason);
		BanEx(playerid, reason);
		return 1;
	}
//==============================================================================
	new cmd[200], idx;
	cmd = strtok(cmdtext, idx);

 	if(strcmp(cmd, "/Car", true, 10) == 0)
	{
		if(IsPlayerMaster(playerid) == 0) return SendClientMessage(playerid, COLOR_RED, "Handy Menu Says: You are not an admin");

		new String[200];
		new tmp[256];
		new Float:x, Float:y, Float:z;

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "Handy Menu Says: You Didnt Give Me A Vehicle Name?");

		new vehicle = ModelID(tmp);

		if(vehicle < 400 || vehicle > 611) return SendClientMessage(playerid, COLOR_WHITE, "Handy Menu Says: That Is Not A Valid Vehicle");

		new Float:a;
		GetPlayerFacingAngle(playerid, a);
		GetPlayerPos(playerid, x, y, z);

		if(IsPlayerInAnyVehicle(playerid) == 1)
		{
			XY(playerid, x, y, 10);
		}
		else
		{
		    XY(playerid, x, y, 5);
		}

		new PlayersVehicle = CreateVehicle(vehicle, x, y, z, a+90, -1, -1, -1);
		LinkVehicleToInterior(PlayersVehicle, GetPlayerInterior(playerid));

		format(String, sizeof(String), "Handy Menu Says: Enjoy Your %s", VNames[vehicle - 400]);
		SendClientMessage(playerid, COLOR_GREEN, String);
  		return 1;
	}
	return 0;
}
//==============================================================================
strtok(const string[], &index){
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
//==============================================================================
ModelID(vname[]){
	for(new i = 0; i < 211; i++)
	{
		if(strfind(VNames[i], vname, true) != -1)
		return i + 400;
	}
	return -1;
}
//==============================================================================
stock XY(playerid, &Float:x2, &Float:y2, Float:distance){
	new Float:a;

	GetPlayerPos(playerid, x2, y2, a);
	GetPlayerFacingAngle(playerid, a);

	if(GetPlayerVehicleID(playerid))
	{
		GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}

	x2 += (distance * floatsin(-a, degrees));
	y2 += (distance * floatcos(-a, degrees));
}
//==============================================================================
IsPlayerMaster(plid){
	new plname[50];
	GetPlayerName(plid, plname, sizeof(plname));

	new masterr;

	for(new i; i<NAMELINES; i++)
	{
		if(strlen(plname) > 0)
		{
			if(strcmp(plname, master[i], true) == 0)
			{
				masterr = 1;
			}
		}
	}

	return masterr;
}
#endif
//==============================================================================
