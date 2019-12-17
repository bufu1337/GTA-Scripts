#include <lrp>
#define FILTERSCRIPT
//

//Forward Definitions
forward LoadCar(carid);
forward SaveCar(carid);
forward AddCar(carid);
forward OnVehicleDeath(vehicleid);
forward OnVehicleSpawn(vehicleid);
forward OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
forward OnPlayerExitVehicle(playerid, vehicleid);
forward FuelFunction(playerid);
forward CurCarFunction(playerid);
forward CarNames(playerid);

//misc forwards
forward split(const strsrc[], strdest[][], delimiter);
forward strtok(const string[], &index);

//commands
forward OnPlayerCommandText(playerid, cmdtext[]);
//

//----[New Definitions]
//player specific
new CarPark[maxplayers];
new CurCar[maxplayers];
new CurCarCheck[maxplayers];

//car specific
new CurFuel[300];

//timers
new FuelTimer;

//server stats
new LastCar;

//textdraw
new Text:ExitCar;
//

//----[Enum Definitions]
//CarInfo
enum cinfo
{
	carsid,           			//Car Id Number
	carscurid,        			//Current Vehicleid
	carsmodel,        			//Car Model Id
	carstype,         			//Car Type (Ex.Copcar, Gangcar)
	carsbuyable,				//Car Buyable
	carsowner[maxplayername],	//Car Owner
	carsinsured,      			//Car Insured
	carsvalue,        			//Car Value
	carsfuel,		  			//Car fuel
	Float:carshp,     			//Car Hp
	carscolor1,       			//Car Color1
	carscolor2,       			//Car Color2
	carscolor3,       			//Car Color3
	carslocked,       			//Car Locked
	Float:carsparkx,  			//Car Park X
	Float:carsparky,  			//Car Park Y
	Float:carsparkz,  			//Car Park Z
	Float:carsparkang,			//Car Park Angle
	Float:carsx,      			//Current Car X
	Float:carsy,      			//Current Car Y
	Float:carsz,      			//Current Car Z
	Float:carsang,    			//Current Car Ang
	carsfbumper,      			//Car Front Bumper
	carsfbbars,       			//Car Front Bullbars
	carsrbumper,      			//Car Rear Bumper
	carsrbbars,       			//Car Rear Bullbars
	carswheels,       			//Car Wheels
	carslskirt,       			//Car Sideskirts
	carsrskirt,       			//Car Sideskirts
	carshydros,		  			//Car Hydros
	carsspoiler,      			//Car Spoiler
	carsroof,         			//Car Roof
	carshood,         			//Car Hood
	carsexhaust,      			//Car Exhaust
	carslights,       			//Car Lights
	carsstereo,       			//Car Stereo
	carsnitro,         			//Car Nitro
	carslhood,                  //Car Left hood vent
	carsrhood                   //Car Right hood vent
};
new CarInfo[300][cinfo];
//

//----[Callbacks]
public OnFilterScriptInit()
{
	print(" ");
	print("   ____________________________________");
	print("  |__[Lords Car System (LRP2.0)]___[x]_|");
	print("  | Script: Lords Car System           |");
	print("  | Version: 2.0                       |");
	print("  | Created by : KineticNRG            |");
	print("  |                                    |");
	print("  |      § www.lordsrp.ulmb.com §      |");
	print("  |____________________________________|");
	print(" ");
	return 1;
}
//

//
public OnFilterScriptExit()
{
	return 1;
}
//

//
public OnGameModeInit()
{
	new str[128];
	//Load Cars
	print(" ____________________");
	print("|_[Cars]_________[x]_|");
	print("|Loading Cars...     |");
	print("|                    |");
	for(new c=1; c<=300;)
	{
	    format(str, sizeof(str), "/cars/car%d.car", c);
	    if(fexist(str))
	    {
			LoadCar(c);
			AddCar(c);
			if(c < 10)
			{
				printf("|car %d loaded        |", c);
			}
			if(c >= 10 && c <100)
			{
				printf("|car %d loaded       |", c);
			}
			if(c >=100)
			{
				printf("|car %d loaded      |", c);
			}
			LastCar = c;
		}
		c++;
	}
	print("|--------------------|");
	if(LastCar < 10)
	{
		printf("|%d cars total        |", LastCar);
	}
	if(LastCar >= 10 && LastCar <100)
	{
		printf("|%d cars total       |", LastCar);
	}
	if(LastCar > 100)
	{
		printf("|%d cars total      |", LastCar);
	}
	print("|____________________|");
	print(" ");
	
	//fuel timer
	FuelTimer       = SetTimer("FuelFunction", 100000, 1);
	
	//text draw
	ExitCar = TextDrawCreate(150, 425, "type '~r~exit~w~' to exit vehicle");
	TextDrawFont(ExitCar, 2);
	TextDrawColor(ExitCar, 0xff2222ff);
	return 1;
}
//

//
public OnGameModeExit()
{
	KillTimer(FuelTimer);
	return 1;
}
//

//
public LoadCar(carid)
{
	new str[32];
	format(str, sizeof(str), "/cars/car%d.car", carid);
	if(carid == 0)
	{
	    return 1;
	}
	new File: cfile = fopen(str, io_read);
	if(fexist(str))
	{
	    new farray[39][32];
		new fstr[256];

		fread(cfile, fstr);
	    split(fstr, farray, '|');
	    CarInfo[carid][carsid]			=	strval(farray[0]);
	    CarInfo[carid][carscurid] 		=	strval(farray[1]);
	    CarInfo[carid][carsmodel] 		=	strval(farray[2]);
		CarInfo[carid][carstype] 		=	strval(farray[3]);
		CarInfo[carid][carsbuyable] 	=	strval(farray[4]);
		strmid(CarInfo[carid][carsowner], farray[5], 0, strlen(farray[5]), 255);
		CarInfo[carid][carsinsured] 	=	strval(farray[6]);
		CarInfo[carid][carsvalue] 		=	strval(farray[7]);
		CarInfo[carid][carsfuel] 		=	strval(farray[8]);
		CarInfo[carid][carshp] 			= floatstr(farray[9]);
		CarInfo[carid][carscolor1] 		=	strval(farray[10]);
		CarInfo[carid][carscolor2] 		=	strval(farray[11]);
		CarInfo[carid][carscolor3] 		=	strval(farray[12]);
		CarInfo[carid][carslocked] 		=	strval(farray[13]);
		CarInfo[carid][carsparkx] 		= floatstr(farray[14]);
		CarInfo[carid][carsparky] 		= floatstr(farray[15]);
		CarInfo[carid][carsparkz] 		= floatstr(farray[16]);
		CarInfo[carid][carsparkang] 	= floatstr(farray[17]);
		CarInfo[carid][carsx]			= floatstr(farray[18]);
        CarInfo[carid][carsy]			= floatstr(farray[19]);
        CarInfo[carid][carsz]			= floatstr(farray[20]);
        CarInfo[carid][carsang] 		= floatstr(farray[21]);
        CarInfo[carid][carsfbumper]		=	strval(farray[22]);
        CarInfo[carid][carsfbbars]      =   strval(farray[23]);
        CarInfo[carid][carsrbumper]		=	strval(farray[24]);
        CarInfo[carid][carsrbbars]      =   strval(farray[25]);
        CarInfo[carid][carswheels]		=	strval(farray[26]);
        CarInfo[carid][carslskirt]		=	strval(farray[27]);
        CarInfo[carid][carsrskirt]		=	strval(farray[28]);
        CarInfo[carid][carshydros] 		=	strval(farray[29]);
        CarInfo[carid][carsspoiler]     =	strval(farray[30]);
        CarInfo[carid][carsroof]        =   strval(farray[31]);
        CarInfo[carid][carshood]        =   strval(farray[32]);
        CarInfo[carid][carsexhaust]     =   strval(farray[33]);
        CarInfo[carid][carslights]      =   strval(farray[34]);
        CarInfo[carid][carsstereo]      =   strval(farray[35]);
        CarInfo[carid][carsnitro]       =   strval(farray[36]);
        CarInfo[carid][carslhood]       =   strval(farray[37]);
        CarInfo[carid][carsrhood]       =   strval(farray[38]);

   		fclose(cfile);
	}
	return 1;
}
//

//
public SaveCar(carid)
{
	new str[256];
	format(str, sizeof(str), "/cars/car%d.car", carid);
	if(carid == 0)
	{
	    return 1;
	}
	new File: cfile = fopen(str, io_write);
	new filestr[256];
	format(filestr, sizeof(filestr), "%d|%d|%d|%d|%d|%s|%d|%d|%d|%f|%d|%d|%d|%d|%f|%f|%f|%f|%f|%f|%f|%f|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d",
	CarInfo[carid][carsid],
    CarInfo[carid][carscurid],
	CarInfo[carid][carsmodel],
	CarInfo[carid][carstype],
	CarInfo[carid][carsbuyable],
	CarInfo[carid][carsowner],
	CarInfo[carid][carsinsured],
	CarInfo[carid][carsvalue],
	CarInfo[carid][carsfuel],
	CarInfo[carid][carshp],
	CarInfo[carid][carscolor1],
	CarInfo[carid][carscolor2],
	CarInfo[carid][carscolor3],
	CarInfo[carid][carslocked],
	CarInfo[carid][carsparkx],
	CarInfo[carid][carsparky],
	CarInfo[carid][carsparkz],
	CarInfo[carid][carsparkang],
    CarInfo[carid][carsx],
    CarInfo[carid][carsy],
	CarInfo[carid][carsz],
    CarInfo[carid][carsang],
	CarInfo[carid][carsfbumper],
	CarInfo[carid][carsfbbars],
	CarInfo[carid][carsrbumper],
	CarInfo[carid][carsrbbars],
	CarInfo[carid][carswheels],
	CarInfo[carid][carslskirt],
	CarInfo[carid][carsrskirt],
	CarInfo[carid][carshydros],
	CarInfo[carid][carsspoiler],
    CarInfo[carid][carsroof],
    CarInfo[carid][carshood],
    CarInfo[carid][carsexhaust],
    CarInfo[carid][carslights],
    CarInfo[carid][carsstereo],
    CarInfo[carid][carsnitro],
    CarInfo[carid][carslhood],
    CarInfo[carid][carsrhood]
	);
	fwrite(cfile, filestr);
	fclose(cfile);
	return 1;
}
//

//
public AddCar(carid)
{
	new str[256];
	format(str, sizeof(str), "/cars/car%d.car", carid);
	if(carid == 0)
	{
	    return 1;
	}
	CarInfo[carid][carscurid]	= carid;
	CarInfo[carid][carsid]		= carid;
	CurFuel[carid]               = CarInfo[carid][carsfuel];
	if(fexist(str))
	{
		CreateVehicle(CarInfo[carid][carsmodel], CarInfo[carid][carsparkx], CarInfo[carid][carsparky], CarInfo[carid][carsparkz], CarInfo[carid][carsparkang], CarInfo[carid][carscolor1], CarInfo[carid][carscolor2], 10000000);
		ChangeVehicleColor(carid, CarInfo[carid][carscolor1], CarInfo[carid][carscolor2]);
		if(CarInfo[carid][carsfbumper] > 0)
		{
		    AddVehicleComponent(carid, CarInfo[carid][carsfbumper]);
		}
		if(CarInfo[carid][carsfbbars] > 0)
		{
		    AddVehicleComponent(carid, CarInfo[carid][carsfbbars]);
		}
		if(CarInfo[carid][carsrbumper] > 0)
		{
		    AddVehicleComponent(carid, CarInfo[carid][carsrbumper]);
		}
		if(CarInfo[carid][carsrbbars] > 0)
		{
		    AddVehicleComponent(carid, CarInfo[carid][carsrbbars]);
		}
		if(CarInfo[carid][carswheels] > 0)
		{
		    AddVehicleComponent(carid, CarInfo[carid][carswheels]);
		}
		if(CarInfo[carid][carslskirt] > 0)
		{
		    AddVehicleComponent(carid, CarInfo[carid][carslskirt]);
		}
		if(CarInfo[carid][carslskirt] > 0)
		{
		    AddVehicleComponent(carid, CarInfo[carid][carsrskirt]);
		}
		if(CarInfo[carid][carshydros] > 0)
		{
		    AddVehicleComponent(carid, CarInfo[carid][carshydros]);
		}
		if(CarInfo[carid][carsspoiler] > 0)
		{
		    AddVehicleComponent(carid, CarInfo[carid][carsspoiler]);
		}
		if(CarInfo[carid][carsroof] > 0)
		{
		    AddVehicleComponent(carid, CarInfo[carid][carsroof]);
		}
		if(CarInfo[carid][carshood] > 0)
		{
		    AddVehicleComponent(carid, CarInfo[carid][carshood]);
		}
		if(CarInfo[carid][carsexhaust] > 0)
		{
		    AddVehicleComponent(carid, CarInfo[carid][carsexhaust]);
		}
		if(CarInfo[carid][carslights] > 0)
		{
		    AddVehicleComponent(carid, CarInfo[carid][carslights]);
		}
		if(CarInfo[carid][carsstereo] > 0)
		{
		    AddVehicleComponent(carid, CarInfo[carid][carsstereo]);
		}
		if(CarInfo[carid][carsnitro] > 0)
		{
		    AddVehicleComponent(carid, CarInfo[carid][carsnitro]);
		}
		if(CarInfo[carid][carslhood] > 0)
		{
		    AddVehicleComponent(carid, CarInfo[carid][carslhood]);
		}
		if(CarInfo[carid][carsrhood] > 0)
		{
		    AddVehicleComponent(carid, CarInfo[carid][carsrhood]);
		}
	}
	return 1;
}
//

//
public OnVehicleDeath(vehicleid)
{
	return 1;
}
//

//
public OnVehicleSpawn(vehicleid)
{
	DestroyVehicle(vehicleid);
	CarInfo[vehicleid][carscurid] = vehicleid;
	LoadCar(CarInfo[vehicleid][carsid]);
	CreateVehicle(CarInfo[vehicleid][carsmodel], CarInfo[vehicleid][carsparkx], CarInfo[vehicleid][carsparky], CarInfo[vehicleid][carsparkz], CarInfo[vehicleid][carsparkang], CarInfo[vehicleid][carscolor1], CarInfo[vehicleid][carscolor2], 10000000);
	ChangeVehicleColor(vehicleid, CarInfo[vehicleid][carscolor1], CarInfo[vehicleid][carscolor2]);
	if(CarInfo[vehicleid][carsfbumper] > 0)
	{
	    AddVehicleComponent(vehicleid, CarInfo[vehicleid][carsfbumper]);
	}
	if(CarInfo[vehicleid][carsfbbars] > 0)
	{
	    AddVehicleComponent(vehicleid, CarInfo[vehicleid][carsfbbars]);
	}
	if(CarInfo[vehicleid][carsrbumper] > 0)
	{
	    AddVehicleComponent(vehicleid, CarInfo[vehicleid][carsrbumper]);
	}
	if(CarInfo[vehicleid][carsrbbars] > 0)
	{
	    AddVehicleComponent(vehicleid, CarInfo[vehicleid][carsrbbars]);
	}
	if(CarInfo[vehicleid][carswheels] > 0)
	{
	    AddVehicleComponent(vehicleid, CarInfo[vehicleid][carswheels]);
	}
	if(CarInfo[vehicleid][carslskirt] > 0)
	{
	    AddVehicleComponent(vehicleid, CarInfo[vehicleid][carslskirt]);
	}
	if(CarInfo[vehicleid][carsrskirt] > 0)
	{
	    AddVehicleComponent(vehicleid, CarInfo[vehicleid][carsrskirt]);
	}
	if(CarInfo[vehicleid][carshydros] > 0)
	{
	    AddVehicleComponent(vehicleid, CarInfo[vehicleid][carshydros]);
	}
	if(CarInfo[vehicleid][carsspoiler] > 0)
	{
	    AddVehicleComponent(vehicleid, CarInfo[vehicleid][carsspoiler]);
	}
	if(CarInfo[vehicleid][carsroof] > 0)
	{
	    AddVehicleComponent(vehicleid, CarInfo[vehicleid][carsroof]);
	}
	if(CarInfo[vehicleid][carshood] > 0)
	{
	    AddVehicleComponent(vehicleid, CarInfo[vehicleid][carshood]);
	}
	if(CarInfo[vehicleid][carsexhaust] > 0)
	{
	    AddVehicleComponent(vehicleid, CarInfo[vehicleid][carsexhaust]);
	}
	if(CarInfo[vehicleid][carslights] > 0)
	{
	    AddVehicleComponent(vehicleid, CarInfo[vehicleid][carslights]);
	}
	if(CarInfo[vehicleid][carsstereo] > 0)
	{
	    AddVehicleComponent(vehicleid, CarInfo[vehicleid][carsstereo]);
	}
	if(CarInfo[vehicleid][carsnitro] > 0)
	{
	    AddVehicleComponent(vehicleid, CarInfo[vehicleid][carsnitro]);
	}
	if(CarInfo[vehicleid][carslhood] > 0)
	{
	    AddVehicleComponent(vehicleid, CarInfo[vehicleid][carslhood]);
	}
	if(CarInfo[vehicleid][carsrhood] > 0)
	{
	    AddVehicleComponent(vehicleid, CarInfo[vehicleid][carsrhood]);
	}
	return 1;
}
//

//
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	new str[64];
	if(IsPlayerAdmin(playerid))
	{
		if(CurFuel[vehicleid] == 0)
		{
			CurFuel[vehicleid] = 0;
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~                                         No Fuel", 5000, 3);
			ClearAnimations(playerid);
		}
	}
	if(CarInfo[vehicleid][carslocked] == 1)
	{
	    SetVehicleParamsForPlayer(vehicleid, playerid, 0, true);
	    if(CarInfo[vehicleid][carsbuyable] == 1)
	    {
	        format(str, sizeof(str), "This car is buyable. Type '/buycar' to check the price.");
	        SendClientMessage(playerid, color_white, str);
	    }
	}
	if(CarInfo[vehicleid][carslocked] == 0)
	{
	    SetVehicleParamsForPlayer(vehicleid, playerid, 0, false);
	}
	SetTimer("CarNames", 4000, false);
	SetTimer("CurCarFunction", 4000, false);
	return 1;
}
//

//
public OnPlayerExitVehicle(playerid, vehicleid)
{
	CurCar[playerid] = 0;
	TextDrawHideForPlayer(playerid, ExitCar);
	return 1;
}
//

//
public FuelFunction()
{
	for(new i=0; i<=GetMaxPlayers();)
	{
		if(IsPlayerInAnyVehicle(i))
		{
		    new tmpcar = GetPlayerVehicleID(i);
		    if(CurFuel[tmpcar] > 0)
		    {
				CurFuel[tmpcar] -= 1;
		    }
		}
		i++;
	}
	return 1;
}
//

//
public CurCarFunction(playerid)
{
	new tmpcar = GetPlayerVehicleID(playerid);
	CurCar[playerid] = tmpcar;
	if(tmpcar == 0)
	{
	    if(CurCarCheck[playerid] < 3)
	    {
			CurCarCheck[playerid] += 1;
	    	SetTimer("CurCarFunction", 4000, false);
	    	return 1;
		}
		return 1;
	}
	return 1;
}
//

//
public CarNames(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
	    new str[64];
		new tmpcar	= GetPlayerVehicleID(playerid);
		new model	= CarInfo[tmpcar][carsmodel];
		if(model == 400) { format(str, sizeof(str), "~w~Grand Cherokee");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 401) { format(str, sizeof(str), "~w~Bravura");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 402) { format(str, sizeof(str), "~w~Camaro");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 403) { format(str, sizeof(str), "~w~Mac");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 404) { format(str, sizeof(str), "~w~Perenniel");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 405) { format(str, sizeof(str), "~w~Sentinel");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 406) { format(str, sizeof(str), "~w~Dumptruck");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 407) { format(str, sizeof(str), "~w~Fire Truck");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 408) { format(str, sizeof(str), "~w~Trash Truck");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 409) { format(str, sizeof(str), "~w~Limo");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 410) { format(str, sizeof(str), "~w~Manana");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 411) { format(str, sizeof(str), "~w~NSX");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 412) { format(str, sizeof(str), "~w~Impala");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 413) { format(str, sizeof(str), "~w~Econovan");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 414) { format(str, sizeof(str), "~w~E350");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 415) { format(str, sizeof(str), "~w~Ferrari");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 416) { format(str, sizeof(str), "~w~Ambulance");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 417) { format(str, sizeof(str), "~w~Leviathan");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 418) { format(str, sizeof(str), "~w~WindStar");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 419) { format(str, sizeof(str), "~w~El Dorado");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 420) { format(str, sizeof(str), "~w~Taxi");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 421) { format(str, sizeof(str), "~w~Lincoln");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 422) { format(str, sizeof(str), "~w~Bobcat");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 423) { format(str, sizeof(str), "~w~Mr. Whoopee");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 424) { format(str, sizeof(str), "~w~BF Injection");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 425) { format(str, sizeof(str), "~w~Black Hawk");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 426) { format(str, sizeof(str), "~w~Crown Victoria");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 427) { format(str, sizeof(str), "~w~Enforcer");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 428) { format(str, sizeof(str), "~w~Brinks");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 429) { format(str, sizeof(str), "~w~Viper");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 430) { format(str, sizeof(str), "~w~Coast Guard");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 431) { format(str, sizeof(str), "~w~Grey Hound");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 432) { format(str, sizeof(str), "~w~Tank");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 433) { format(str, sizeof(str), "~w~Barracks");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 434) { format(str, sizeof(str), "~w~Hot Rod");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 435) { format(str, sizeof(str), "~w~Article Trailer1"); GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 436) { format(str, sizeof(str), "~w~Thunderbird");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 437) { format(str, sizeof(str), "~w~Vista");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 438) { format(str, sizeof(str), "~w~Taxi");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 439) { format(str, sizeof(str), "~w~Stallion");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 440) { format(str, sizeof(str), "~w~E250");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 441) { format(str, sizeof(str), "~w~RC Car");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 442) { format(str, sizeof(str), "~w~Hurse");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 443) { format(str, sizeof(str), "~w~Car Transporter");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 444) { format(str, sizeof(str), "~w~F250 Offroad");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 445) { format(str, sizeof(str), "~w~Mercedies");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 446) { format(str, sizeof(str), "~w~Squallo III");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 447) { format(str, sizeof(str), "~w~Sea Sparrow");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 448) { format(str, sizeof(str), "~w~Vespa");		 	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 449) { format(str, sizeof(str), "~w~Cable Car");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 450) { format(str, sizeof(str), "~w~Article Trailer2");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 451) { format(str, sizeof(str), "~w~Lamborguini");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 452) { format(str, sizeof(str), "~w~Speeder");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 453) { format(str, sizeof(str), "~w~Reefer");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 454) { format(str, sizeof(str), "~w~Tropic");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 455) { format(str, sizeof(str), "~w~Barracks");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 456) { format(str, sizeof(str), "~w~U-Haul E350");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 457) { format(str, sizeof(str), "~w~Golf Kart");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 458) { format(str, sizeof(str), "~w~Taurus");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 459) { format(str, sizeof(str), "~w~E150");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 460) { format(str, sizeof(str), "~w~Sea Plane");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 461) { format(str, sizeof(str), "~w~Ninja 650");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 462) { format(str, sizeof(str), "~w~Vespa");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 463) { format(str, sizeof(str), "~w~Harley");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 464) { format(str, sizeof(str), "~w~RC Plane");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 465) { format(str, sizeof(str), "~w~RC Helicopter V1");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 466) { format(str, sizeof(str), "~w~Glendale");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 467) { format(str, sizeof(str), "~w~Oceanic");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 468) { format(str, sizeof(str), "~w~Honda CR250");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 469) { format(str, sizeof(str), "~w~Sparrow");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 470) { format(str, sizeof(str), "~w~Hummer");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 471) { format(str, sizeof(str), "~w~Quad");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 472) { format(str, sizeof(str), "~w~Coast Guard");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 473) { format(str, sizeof(str), "~w~Raft");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 474) { format(str, sizeof(str), "~w~Hermes");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 475) { format(str, sizeof(str), "~w~Chevelle");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 476) { format(str, sizeof(str), "~w~Rustler");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 477) { format(str, sizeof(str), "~w~ZR 350");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 478) { format(str, sizeof(str), "~w~F100");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 479) { format(str, sizeof(str), "~w~Celebrity");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 480) { format(str, sizeof(str), "~w~Porche");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 481) { format(str, sizeof(str), "~w~Haro");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 482) { format(str, sizeof(str), "~w~E250");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 483) { format(str, sizeof(str), "~w~Volkswagon");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 484) { format(str, sizeof(str), "~w~Marquis");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 485) { format(str, sizeof(str), "~w~Baggage Car");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 486) { format(str, sizeof(str), "~w~Catapillar");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 487) { format(str, sizeof(str), "~w~Maverick M150");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 488) { format(str, sizeof(str), "~w~Maverick M100");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 489) { format(str, sizeof(str), "~w~Blazer");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 490) { format(str, sizeof(str), "~w~Blazer XT");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 491) { format(str, sizeof(str), "~w~Regal");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 492) { format(str, sizeof(str), "~w~Regency");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 493) { format(str, sizeof(str), "~w~Jet Max");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 494) { format(str, sizeof(str), "~w~Stock Car");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 495) { format(str, sizeof(str), "~w~Sand King");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 496) { format(str, sizeof(str), "~w~CRX");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 497) { format(str, sizeof(str), "~w~Maverick M250");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 498) { format(str, sizeof(str), "~w~Econoline");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 499) { format(str, sizeof(str), "~w~U-Haul E250");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 500) { format(str, sizeof(str), "~w~Wrangler");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 501) { format(str, sizeof(str), "~w~RC Helicopter V2");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 502) { format(str, sizeof(str), "~w~Stock Car");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 503) { format(str, sizeof(str), "~w~Stock Car");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 504) { format(str, sizeof(str), "~w~Demolition");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 505) { format(str, sizeof(str), "~w~Blazer");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 506) { format(str, sizeof(str), "~w~GT");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 507) { format(str, sizeof(str), "~w~Beemer");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 508) { format(str, sizeof(str), "~w~Warrior");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 509) { format(str, sizeof(str), "~w~Schwinn");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 510) { format(str, sizeof(str), "~w~Hardrock");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 511) { format(str, sizeof(str), "~w~Beagle");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 512) { format(str, sizeof(str), "~w~Crop Duster");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 513) { format(str, sizeof(str), "~w~Stunt Plane");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 514) { format(str, sizeof(str), "~w~Peterbuilt");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 515) { format(str, sizeof(str), "~w~Road King");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 516) { format(str, sizeof(str), "~w~Cavalier");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 517) { format(str, sizeof(str), "~w~Majestic");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 518) { format(str, sizeof(str), "~w~Nova");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 519) { format(str, sizeof(str), "~w~Learjet");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 520) { format(str, sizeof(str), "~w~Harrier");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 521) { format(str, sizeof(str), "~w~Assassin 950");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 522) { format(str, sizeof(str), "~w~Shinobi 1250");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 523) { format(str, sizeof(str), "~w~Police HPV 600");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 524) { format(str, sizeof(str), "~w~Cement Mixer");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 525) { format(str, sizeof(str), "~w~F250");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 526) { format(str, sizeof(str), "~w~Escort");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 527) { format(str, sizeof(str), "~w~Cadrona");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 528) { format(str, sizeof(str), "~w~Riot");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 529) { format(str, sizeof(str), "~w~Willard");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 530) { format(str, sizeof(str), "~w~Fork Lift");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 531) { format(str, sizeof(str), "~w~John Deere");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 532) { format(str, sizeof(str), "~w~Harvester");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 533) { format(str, sizeof(str), "~w~Feltzer");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 534) { format(str, sizeof(str), "~w~Remington");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 535) { format(str, sizeof(str), "~w~Slamvan");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 536) { format(str, sizeof(str), "~w~Blade");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 537) { format(str, sizeof(str), "~w~Freight");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 538) { format(str, sizeof(str), "~w~Brown Streak");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 539) { format(str, sizeof(str), "~w~Hovercraft");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 540) { format(str, sizeof(str), "~w~Volvo");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 541) { format(str, sizeof(str), "~w~GT40");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 542) { format(str, sizeof(str), "~w~Firebird");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 543) { format(str, sizeof(str), "~w~F150");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 544) { format(str, sizeof(str), "~w~Fire Truck");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 545) { format(str, sizeof(str), "~w~Model T");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 546) { format(str, sizeof(str), "~w~Intruder");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 547) { format(str, sizeof(str), "~w~Primo");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 548) { format(str, sizeof(str), "~w~Cargo");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 549) { format(str, sizeof(str), "~w~Mustang");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 550) { format(str, sizeof(str), "~w~Accord");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 551) { format(str, sizeof(str), "~w~Lumina");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 552) { format(str, sizeof(str), "~w~E250 Pickup");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 553) { format(str, sizeof(str), "~w~Jumbo");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 554) { format(str, sizeof(str), "~w~Silverado");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 555) { format(str, sizeof(str), "~w~Swift");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 556) { format(str, sizeof(str), "~w~RAM 3500 Offroad");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 557) { format(str, sizeof(str), "~w~Silverado Offroad");GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 558) { format(str, sizeof(str), "~w~Nissan");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 559) { format(str, sizeof(str), "~w~Acura");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 560) { format(str, sizeof(str), "~w~Subaru");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 561) { format(str, sizeof(str), "~w~Stratum");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 562) { format(str, sizeof(str), "~w~Skyline");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 563) { format(str, sizeof(str), "~w~Rescue");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 564) { format(str, sizeof(str), "~w~RC Tank");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 565) { format(str, sizeof(str), "~w~Civic Hatch");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 566) { format(str, sizeof(str), "~w~Tahoma");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 567) { format(str, sizeof(str), "~w~Savanna");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 568) { format(str, sizeof(str), "~w~Sandrail");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 569) { format(str, sizeof(str), "~w~Freight Trailer");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 570) { format(str, sizeof(str), "~w~Streak Trailer");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 571) { format(str, sizeof(str), "~w~Go-Kart");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 572) { format(str, sizeof(str), "~w~Lawn Mower");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 573) { format(str, sizeof(str), "~w~Utility");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 574) { format(str, sizeof(str), "~w~Sweeper");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 575) { format(str, sizeof(str), "~w~Broadway");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 576) { format(str, sizeof(str), "~w~Tornado");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 577) { format(str, sizeof(str), "~w~737");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 578) { format(str, sizeof(str), "~w~Mitsumi Flatbed");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 579) { format(str, sizeof(str), "~w~Pathfinder");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 580) { format(str, sizeof(str), "~w~Bentley");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 581) { format(str, sizeof(str), "~w~Samurai 950");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 582) { format(str, sizeof(str), "~w~E250");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 583) { format(str, sizeof(str), "~w~Runner");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 584) { format(str, sizeof(str), "~w~Petrol Trailer");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 585) { format(str, sizeof(str), "~w~Emperor");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 586) { format(str, sizeof(str), "~w~Easy Rider");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 587) { format(str, sizeof(str), "~w~Euros");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 588) { format(str, sizeof(str), "~w~Hot Dog");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 589) { format(str, sizeof(str), "~w~Club");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 590) { format(str, sizeof(str), "~w~Freight Trailer");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 591) { format(str, sizeof(str), "~w~Article Trailer");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 592) { format(str, sizeof(str), "~w~747");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 593) { format(str, sizeof(str), "~w~Cessna");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 594) { format(str, sizeof(str), "~w~RC Cam");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 595) { format(str, sizeof(str), "~w~Launch");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 596) { format(str, sizeof(str), "~w~LSPD Cruiser");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 597) { format(str, sizeof(str), "~w~SFPD Cruiser");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 598) { format(str, sizeof(str), "~w~LVPD Cruiser");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 599) { format(str, sizeof(str), "~w~SAPD Explorer");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 600) { format(str, sizeof(str), "~w~El Camino");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 601) { format(str, sizeof(str), "~w~S.W.A.T.");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 602) { format(str, sizeof(str), "~w~Alpha");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 603) { format(str, sizeof(str), "~w~Firebird");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 604) { format(str, sizeof(str), "~w~Glendale");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 605) { format(str, sizeof(str), "~w~F150");				GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 606) { format(str, sizeof(str), "~w~Baggage");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 607) { format(str, sizeof(str), "~w~Baggage");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 608) { format(str, sizeof(str), "~w~Stairs");			GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 609) { format(str, sizeof(str), "~w~Econoline");		GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 610) { format(str, sizeof(str), "~w~Combine Trailer");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
		if(model == 611) { format(str, sizeof(str), "~w~Utility Trailer");	GameTextForPlayer(playerid, str, 600, 1); return 1; }
	}
	return 0;
}
//

//
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
//

//
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
//

//
public OnPlayerCommandText(playerid, cmdtext[])
{
	//--[Setup]
	new idx;
	new str[256];
	new cmd[256];
	new tmp[256];
	new playerid2;
	new name[maxplayername];
	new name2[maxplayername];
	GetPlayerName(playerid, name, sizeof(name));
	cmd = strtok(cmdtext, idx);
	//
	
	//
	if(strcmp(cmd, "/park", true) ==0)
	{
		if(IsPlayerConnected(playerid))
		{
			new car = GetPlayerVehicleID(playerid);
			new cid = CarInfo[car][carsid];
			new Float:carhp = GetVehicleHealth(car, carhp);
			new Float:carx, Float:cary, Float:carz, Float:carang;
		    if(IsPlayerAdmin(playerid))
		    {
    	        GetVehiclePos(car, carx, cary, carz);
    	        GetVehicleZAngle(car, carang);
				CarInfo[car][carsparkx] = carx;
				CarInfo[car][carsparky] = cary;
				CarInfo[car][carsparkz] = carz;
				CarInfo[car][carsparkang] = carang;
				format(str, sizeof(str), "[X:%f|Y:%f|Z:%f|Ang:%f] - Car %d(car%d.car) admin parked by %s.", carx, cary, carz, carang, car, cid, name);
				SendClientMessage(playerid, color_green, str);
				SaveCar(cid);
				return 1;
		    }
		    //if(PlayerInfo[playerid][carowned] > 0)
		    //{
		    if(IsPlayerInVehicle(playerid, car))
		    {
		        //if(car == PlayerInfo[playerid][carowned]|| car == PlayerInfo[playerid][carkey])
		        //{
					if(carhp < 300)
					{
		            	if(CarPark[playerid] >=3)
		            	{
    	       				GetVehiclePos(car, carx, cary, carz);
    	       				GetVehicleZAngle(car, carang);
							CarInfo[car][carsparkx] = carx;
							CarInfo[car][carsparky] = cary;
							CarInfo[car][carsparkz] = carz;
							CarInfo[car][carsparkang] = carang;
							CarPark[playerid] += 1;
							SaveCar(cid);
							return 1;
						}
						else
						{
						    SendClientMessage(playerid, color_lred, "You cannot park anymore until next paycheck.");
						    return 1;
						}
					}
					else
					{
					    SendClientMessage(playerid, color_lred, "Your car is too damaged to park. Repair and try again.");
					    return 1;
					}
				//}
				//else
				//{
				//    SendClientMessage(playerid, color_lred, "You must own the car or have a car key to park it.");
				//    return 1;
				//}
			}
			else
			{
			    SendClientMessage(playerid, color_lred, "You must be in a vehicle to park it.");
			    return 1;
			}
			//}
			//else
			//{
			//    SendClientMessage(playerid, color_lred, "You must own a car or have a car key to park it.");
			//    return 1;
			//}
		}
	    return 1;
	}
	//
	
	//
	if(strcmp(cmd, "/createcar", true) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
		    tmp = strtok(cmdtext, idx);
		    if(!strlen(tmp))
			{
			    SendClientMessage(playerid, color_dgreen, "Server_CommandCheck: /createcar [carmodel]");
			    return 1;
			}
			new tmpcar;
			new tmpmodel;
			new ownerstr[maxplayername];
			tmpmodel = strval(tmp);
			if(tmpmodel > 399 && tmpmodel < 612)
			{
				for(tmpcar= 1; tmpcar<= 300;)
				{
					format(str, sizeof(str), "/cars/car%d.car",tmpcar);
					if(!fexist(str))
					{
					    new Float:x, Float:y, Float:z, Float:ang;
					    new Float:carx, Float:cary, Float:carz, Float:carang;
					    GetPlayerPos(playerid, x, y, z);
					    GetPlayerFacingAngle(playerid, ang);
					    if(ang >0 && ang <=90)
					    {
					        carang = 45;
					        carx = x;
					        cary = y + 2.5;
					        carz = z;
					    }
					    if(ang >91 && ang <=180)
					    {
							carang = 135;
					        carx = x - 2.5;
					        cary = y;
					        carz = z;
					    }
					    if(ang >181 && ang <=270)
					    {
					        carang = 225;
					        carx = x;
					        cary = y - 2.5;
					        carz = z;
						}
					    if(ang >271 && ang <=360)
					    {
					        carang = 315;
					        carx = x + 2.5;
					        cary = y;
					        carz = z;
						}
						CarInfo[tmpcar][carsid]			= tmpcar;
						CarInfo[tmpcar][carscurid]      = tmpcar;
						CarInfo[tmpcar][carsmodel]		= tmpmodel;
						CarInfo[tmpcar][carstype]		= 0;
						CarInfo[tmpcar][carsbuyable]	= 0;
						format(ownerstr, sizeof(ownerstr), "none");
						CarInfo[tmpcar][carsowner]		= ownerstr;
						CarInfo[tmpcar][carsinsured]	= 0;
						CarInfo[tmpcar][carsvalue]		= 0;
						CarInfo[tmpcar][carsfuel]		= 100;
						CarInfo[tmpcar][carshp]         = 1000;
						CarInfo[tmpcar][carscolor1]		= 1;
						CarInfo[tmpcar][carscolor2]		= 1;
						CarInfo[tmpcar][carscolor3]		= 3;
						CarInfo[tmpcar][carslocked]		= 0;
						CarInfo[tmpcar][carsparkx]		= carx;
						CarInfo[tmpcar][carsparky]		= cary;
						CarInfo[tmpcar][carsparkz]		= carz;
						CarInfo[tmpcar][carsparkang]	= carang;
						CarInfo[tmpcar][carsfbumper]	= 0;
						CarInfo[tmpcar][carsfbbars]     = 0;
						CarInfo[tmpcar][carsrbumper]	= 0;
						CarInfo[tmpcar][carsrbbars]     = 0;
						CarInfo[tmpcar][carswheels]		= 0;
						CarInfo[tmpcar][carslskirt]		= 0;
						CarInfo[tmpcar][carsrskirt]     = 0;
						CarInfo[tmpcar][carshydros]		= 0;
				        CarInfo[tmpcar][carsroof]       = 0;
        				CarInfo[tmpcar][carshood]       = 0;
       		 			CarInfo[tmpcar][carsexhaust]    = 0;
        				CarInfo[tmpcar][carslights]     = 0;
        				CarInfo[tmpcar][carsstereo]     = 0;
        				CarInfo[tmpcar][carsnitro]      = 0;
        				CurFuel[tmpcar]                 = CarInfo[tmpcar][carsfuel];

						CreateVehicle(CarInfo[tmpcar][carsmodel], CarInfo[tmpcar][carsparkx], CarInfo[tmpcar][carsparky], CarInfo[tmpcar][carsparkz], CarInfo[tmpcar][carsparkang], CarInfo[tmpcar][carscolor1], CarInfo[tmpcar][carscolor2], 600000);

						format(str, sizeof(str), "car %d created by %s.",tmpcar, name);
						print(str);
						SaveCar(tmpcar);
						PutPlayerInVehicle(playerid, tmpcar, 0);
						return 1;
					}
				    tmpcar++;
				}
			}
			else
			{
			   	SendClientMessage(playerid, color_lred, "Server_Error: values 411~611 only.");
			   	return 1;
			}
		}
		else
		{
			SendClientMessage(playerid, color_lred, "Server_Status: admin check failed");
			return 1;
		}
	    return 1;
	}
	//

	//
	if(strcmp(cmd, "/deletecar", true) ==0)
	{
		if(IsPlayerAdmin(playerid))
		{
		    tmp = strtok(cmdtext, idx);
		    if(!strlen(tmp))
			{
			    SendClientMessage(playerid, color_dgreen, "Server_CommandCheck: /deletecar [carid]");
			    return 1;
			}
			new tmpcar;
			tmpcar = strval(tmp);
			if(tmpcar < 1 || tmpcar >300)
			{
			    SendClientMessage(playerid, color_lred, "Server_Error: values 1~300 only.");
			    return 1;
			}
			format(str, sizeof(str), "/cars/car%d.car",tmpcar);
			if(fexist(str))
			{
			    fremove(str);
			    format(str, sizeof(str), "car%d.car deleted by %s.",tmpcar, name);
			    DestroyVehicle(tmpcar);
			    SendClientMessage(playerid, color_purple, str);
			    print(str);
			    return 1;
			}
			else
			{
			    format(str, sizeof(str), "Server_Error: car%d.car not found.",tmpcar);
			    SendClientMessage(playerid, color_lred, str);
			    return 1;
			}
		}
		else
		{
			SendClientMessage(playerid, color_lred, "Server_Status: admin check failed");
			return 1;
		}
	}
	//

	//
	if(strcmp(cmd, "/drivecar", true) == 0)
	{
	    if(IsPlayerAdmin(playerid))
	    {
	        new tmpcar;
	        tmp = strtok(cmdtext, idx);
	        if(!strlen(tmp))
	        {
			    SendClientMessage(playerid, color_dgreen, "Server_CommandCheck: /drivecar [carid]");
			    return 1;
	        }
	        tmpcar = strval(tmp);
			if(tmpcar >= 1 && tmpcar <= 300)
			{
			    format(str, sizeof(str), "You are now the driver of car %d.", tmpcar);
			    SendClientMessage(playerid, color_green, str);
			    PutPlayerInVehicle(playerid, tmpcar, 0);
			    return 1;
			}
	    }
		else
		{
			SendClientMessage(playerid, color_lred, "Server_Status: admin check failed");
			return 1;
		}
	}
	//

	//
	if(strcmp(cmd, "/passenger", true) == 0)
	{
	    if(IsPlayerAdmin(playerid))
	    {
	        tmp = strtok(cmdtext, idx);
	        if(!strlen(tmp))
	        {
			    SendClientMessage(playerid, color_dgreen, "Server_CommandCheck: /passenger [playerid] [carid] [seat]");
			    return 1;
	        }
	        playerid2 = ReturnUser(tmp);
	        GetPlayerName(playerid2, name2, sizeof(name2));
			if(IsPlayerConnected(playerid2))
			{
			    new tmpcar;
			    tmp = strtok(cmdtext, idx);
			    if(!strlen(tmp))
			    {
			        format(str, sizeof(str), "Server_CommandCheck: /passenger [%d] [carid] [seat]", playerid2);
				    SendClientMessage(playerid, color_dgreen, str);
				    return 1;
			    }
			    tmpcar = strval(tmp);
			    if(tmpcar >= 1 && tmpcar <=300)
			    {
			    	new tmpseat;
			    	tmp = strtok(cmdtext, idx);
			    	if(!strlen(tmp))
			    	{
				        format(str, sizeof(str), "Server_CommandCheck: /passenger [%d] [%d] [seat]", playerid2, tmpcar);
					    SendClientMessage(playerid, color_dgreen, str);
			    	    return 1;
			    	}
			    	tmpseat = strval(tmp);
			    	if(tmpseat >= 0)
			    	{
			    		format(str, sizeof(str), "You have placed %s in car %d (Seat:%d).", name2, tmpcar, tmpseat);
			    		SendClientMessage(playerid, color_green, str);
			    		format(str, sizeof(str), "You have been placed in car %d (Seat:%d) by admin %s.", tmpcar, tmpseat, name);
			    		SendClientMessage(playerid2, color_green, str);
			    		SendClientMessage(playerid2, color_green, "Important: if you cannot see yourself in the vehicle, do not exit vehicle, allow admin to remove you.");
			    		PutPlayerInVehicle(playerid2, tmpcar, tmpseat);
			    		return 1;
					}
				}
				else
				{
				    SendClientMessage(playerid, color_lred, "Server_Error: values 1~300 only.");
				    return 1;
				}
			}
			else
			{
			    SendClientMessage(playerid, color_lred, "Server_Error: player does not exist.");
			    return 1;
			}
	    }
		else
		{
			SendClientMessage(playerid, color_lred, "Server_Status: admin check failed");
			return 1;
		}
	}
	//

	//
	if(strcmp(cmd, "/editcar", true) == 0)
	{
	    if(IsPlayerAdmin(playerid))
	    {
		    new tmpcar;
		    if(IsPlayerInAnyVehicle(playerid))
			{
				tmpcar = GetPlayerVehicleID(playerid);
			}
		    if(!IsPlayerInAnyVehicle(playerid))
			{
				tmp = strtok(cmdtext, idx);
				tmpcar = strval(tmp);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, color_green,  "____________________________________________________________________________________________");
		        	SendClientMessage(playerid, color_dgreen, "Server_CommandCheck:/editcar [carid] [part]");
					SendClientMessage(playerid, color_lorange,"Server_Options: carbuyable, carhp, curhp, carfuel, curfuel, carvalue, carowner, model, wheels, fbumper, fbullbars, rbumper,");
					SendClientMessage(playerid, color_lorange,"Server_Options: rbullbars, skirts, spoiler, hydros, roof, hoodscoop, hoodvents, exhaust, stereo, lights, nitro, color1, color2, paint, fullcar");
					return 1;
				}
				if(tmpcar < 1 || tmpcar >300 )
				{
				    SendClientMessage(playerid, color_lred, "Server_Error: values 1~300 only.");
				    return 1;
				}
			}
	        new tmpcmd[24];
	       	tmpcmd = strtok(cmdtext, idx);
	       	if(!strlen(tmpcmd))
	       	{
				SendClientMessage(playerid, color_green,  "____________________________________________________________________________________________");
				format(str, sizeof(str), "Server_CommandCheck:/editcar [%d] [part]", tmpcar);
	        	SendClientMessage(playerid, color_dgreen, str);
				SendClientMessage(playerid, color_lorange,"Server_Options: carbuyable, carhp, curhp, carfuel, curfuel, carvalue, carowner, model, wheels, fbumper, fbullbars, rbumper,");
				SendClientMessage(playerid, color_lorange,"Server_Options: rbullbars, skirts, spoiler, hydros, roof, hoodscoop, hoodvents, exhaust, stereo, lights, nitro, color1, color2, paint, fullcar");
	       	    return 1;
	       	}
	        //

			//
	        if(strcmp(tmpcmd, "carbuyable", true) == 0)
	        {
	            new tmppart;
	            tmp = strtok(cmdtext, idx);
	            if(!strlen(tmp))
	            {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [carbuyable] [0-1]");
				    SendClientMessage(playerid, color_lorange, str);
			        return 1;
	            }
				tmppart = strval(tmp);
				if(tmppart >=0 && tmppart <= 1)
				{
				    CarInfo[tmpcar][carsbuyable] = tmppart;
				    SaveCar(tmpcar);
				    if(CarInfo[tmppart][carsbuyable] == 0)
				    {
				        SendClientMessage(playerid, color_green, "Car set to not buyable");
				        return 1;
					}
				    if(CarInfo[tmppart][carsbuyable] == 1)
				    {
				        SendClientMessage(playerid, color_green, "Car set to buyable");
				        return 1;
					}
				}

	        }
	        if(strcmp(tmpcmd, "carhp", true) == 0)
	        {
			    new tmppart;
			    tmp = strtok(cmdtext, idx);
   			    if(!strlen(tmp))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [carhp] [hp]");
				    SendClientMessage(playerid, color_lorange, str);
			        return 1;
			    }
			    tmppart = strval(tmp);
			    if(tmppart >= 1000 && tmppart <= 5000)
			    {
			        CarInfo[tmpcar][carshp] = tmppart;
			        SetVehicleHealth(tmpcar, tmppart);
			        format(str, sizeof(str), "Car %d's hp limit set to %d.", tmpcar, tmppart);
			        SendClientMessage(playerid, color_green, str);
			        return 1;
			    }
			    else
			    {
					SendClientMessage(playerid, color_lred, "Server_Error: values 1000~5000 only.");
			        return 1;
			    }
	        }
	        if(strcmp(tmpcmd, "curhp", true) == 0)
	        {
			    new tmppart;
			    tmp = strtok(cmdtext, idx);
   			    if(!strlen(tmp))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [curhp] [hp]");
				    SendClientMessage(playerid, color_lorange, str);
			        return 1;
			    }
			    tmppart = strval(tmp);
			    if(tmppart >= 0 && tmppart <= 5000)
			    {
			        SetVehicleHealth(tmpcar, tmppart);
			        format(str, sizeof(str), "Car %d's hp set to %d.", tmpcar, tmppart);
			        SendClientMessage(playerid, color_green, str);
			        return 1;
			    }
			    else
			    {
					SendClientMessage(playerid, color_lred, "Server_Error: values 0~5000 only.");
			        return 1;
			    }
	        }
	        if(strcmp(tmpcmd, "carfuel", true) == 0)
	        {
			    new tmppart;
			    tmp = strtok(cmdtext, idx);
   			    if(!strlen(tmp))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [carfuel] [fuel]");
				    SendClientMessage(playerid, color_lorange, str);
			        return 1;
			    }
			    tmppart = strval(tmp);
			    if(tmppart >= 100 && tmppart <= 300)
			    {
			        CarInfo[tmpcar][carsfuel] = tmppart;
			        CurFuel[tmpcar] = tmppart;
			        format(str, sizeof(str), "Car %d's fuel limit set to %d.", tmpcar, tmppart);
			        SendClientMessage(playerid, color_green, str);
			        return 1;
			    }
			    else
			    {
					SendClientMessage(playerid, color_lred, "Server_Error: values 10~300 only.");
			        return 1;
			    }
	        }
	        if(strcmp(tmpcmd, "curfuel", true) == 0)
	        {
			    new tmppart;
			    tmp = strtok(cmdtext, idx);
   			    if(!strlen(tmp))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [curfuel] [current fuel]");
				    SendClientMessage(playerid, color_lorange, str);
			        return 1;
			    }
			    tmppart = strval(tmp);
			    if(tmppart >= 1 && tmppart <= 300)
			    {
			        CarInfo[tmpcar][carsfuel] = tmppart;
			        CurFuel[tmpcar] = tmppart;
			        format(str, sizeof(str), "Car %d's current fuel set to %d.", tmpcar, tmppart);
			        SendClientMessage(playerid, color_green, str);
			        return 1;
			    }
			    else
			    {
					SendClientMessage(playerid, color_lred, "Server_Error: values 1~300 only.");
			        return 1;
			    }
	        }
	        if(strcmp(tmpcmd, "carvalue", true) == 0)
	        {
			    new tmppart;
			    tmp = strtok(cmdtext, idx);
   			    if(!strlen(tmp))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [carvalue] [value]");
				    SendClientMessage(playerid, color_lorange, str);
			        return 1;
			    }
			    tmppart = strval(tmp);
			    if(tmppart >= 10000 && tmppart <= 100000)
			    {
			        CarInfo[tmpcar][carsvalue] = tmppart;
			        CurFuel[tmpcar] = tmppart;
			        format(str, sizeof(str), "Car %d's value set to $%d.", tmpcar, tmppart);
			        SendClientMessage(playerid, color_green, str);
			        return 1;
			    }
			    else
			    {
					SendClientMessage(playerid, color_lred, "Server_Error: values 10k~100k only.");
			        return 1;
			    }
	        }
	        if(strcmp(tmpcmd, "carowner", true) == 0)
	        {
	            return 1;
	        }
            if(strcmp(tmpcmd, "model", true) == 0)
			{
			    new tmppart;
			    tmp = strtok(cmdtext, idx);
			    if(!strlen(tmp))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [model] [400~611]");
				    SendClientMessage(playerid, color_lorange, str);
			        return 1;
			    }
			    tmppart = strval(tmp);
			    if(tmppart > 399 && tmppart < 612)
			    {
			        return 1;
			    }
			    else
			    {
			        SendClientMessage(playerid, color_lred, "Server_Error: values 400~611 only.");
			        return 1;
			    }
			}
			//

			//
			if(strcmp(tmpcmd, "wheels", true) ==0)
			{
				new tmppart[64];
				tmppart = strtok(cmdtext,idx);
				if(!strlen(tmppart))
				{
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [wheels] [variable]");
				    SendClientMessage(playerid, color_lorange, str);
				    SendClientMessage(playerid, color_lorange, "Server_Options: offroad, shadow, mega, rimshine, classic, twist, cutter, switch, grove");
				    SendClientMessage(playerid, color_lorange, "Server_Options: import, dollar, trance, atomic, ahab, virtual, access, remove");
				    return 1;
				}
				else
				{
					if(CarInfo[tmpcar][carsmodel] == 448||CarInfo[tmpcar][carsmodel] == 461||CarInfo[tmpcar][carsmodel] == 462||CarInfo[tmpcar][carsmodel] == 463||
					CarInfo[tmpcar][carsmodel] == 468||CarInfo[tmpcar][carsmodel] == 481||CarInfo[tmpcar][carsmodel] == 509||CarInfo[tmpcar][carsmodel] == 510||
					CarInfo[tmpcar][carsmodel] == 521||CarInfo[tmpcar][carsmodel] == 522||CarInfo[tmpcar][carsmodel] == 523||CarInfo[tmpcar][carsmodel] == 581||
					CarInfo[tmpcar][carsmodel] == 586)//Two Wheeled
					{
					    SendClientMessage(playerid, color_lred, "Server_Variable: You cannot modify two wheeled vehicle wheels.");
					    return 1;
					}
					if(CarInfo[tmpcar][carsmodel] >= 400 && CarInfo[tmpcar][carsmodel] < 612)
					{
						if(strcmp(tmppart, "offroad", true) ==0)
						{
						    AddVehicleComponent(tmpcar, wheels_offroad);
						    CarInfo[tmpcar][carswheels] = wheels_offroad;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(strcmp(tmppart, "shadow", true) ==0)
						{
						    AddVehicleComponent(tmpcar, wheels_shadow);
						    CarInfo[tmpcar][carswheels] = wheels_shadow;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(strcmp(tmppart, "mega", true) ==0)
						{
						    AddVehicleComponent(tmpcar, wheels_mega);
						    CarInfo[tmpcar][carswheels] = wheels_mega;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(strcmp(tmppart, "rimshine", true) ==0)
						{
						    AddVehicleComponent(tmpcar, wheels_rimshine);
						    CarInfo[tmpcar][carswheels] = wheels_rimshine;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(strcmp(tmppart, "classic", true) ==0)
						{
						    AddVehicleComponent(tmpcar, wheels_classic);
						    CarInfo[tmpcar][carswheels] = wheels_classic;
						    SaveCar(tmpcar);
						}
						if(strcmp(tmppart, "twist", true) ==0)
						{
						    AddVehicleComponent(tmpcar, wheels_twist);
						    CarInfo[tmpcar][carswheels] = wheels_twist;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(strcmp(tmppart, "cutter", true) ==0)
						{
						    AddVehicleComponent(tmpcar, wheels_cutter);
						    CarInfo[tmpcar][carswheels] = wheels_cutter;
						    SaveCar(tmpcar);
							return 1;
						}
						if(strcmp(tmppart, "switch", true) ==0)
						{
						    AddVehicleComponent(tmpcar, wheels_switch);
						    CarInfo[tmpcar][carswheels] = wheels_switch;
						    SaveCar(tmpcar);
							return 1;
						}
						if(strcmp(tmppart, "grove", true) ==0)
						{
						    AddVehicleComponent(tmpcar, wheels_grove);
						    CarInfo[tmpcar][carswheels] = wheels_grove;
						    SaveCar(tmpcar);
							return 1;
						}
						if(strcmp(tmppart, "import", true) ==0)
						{
						    AddVehicleComponent(tmpcar, wheels_import);
						    CarInfo[tmpcar][carswheels] = wheels_import;
						    SaveCar(tmpcar);
							return 1;
						}
						if(strcmp(tmppart, "dollar", true) ==0)
						{
						    AddVehicleComponent(tmpcar, wheels_dollar);
						    CarInfo[tmpcar][carswheels] = wheels_dollar;
						    SaveCar(tmpcar);
							return 1;
						}
						if(strcmp(tmppart, "trance", true) ==0)
						{
						    AddVehicleComponent(tmpcar, wheels_trance);
						    CarInfo[tmpcar][carswheels] = wheels_trance;
						    SaveCar(tmpcar);
							return 1;
						}
						if(strcmp(tmppart, "atomic", true) ==0)
						{
						    AddVehicleComponent(tmpcar, wheels_atomic);
						    CarInfo[tmpcar][carswheels] = wheels_atomic;
						    SaveCar(tmpcar);
							return 1;
						}
						if(strcmp(tmppart, "ahab", true) ==0)
						{
						    AddVehicleComponent(tmpcar, wheels_ahab);
						    CarInfo[tmpcar][carswheels] = wheels_ahab;
						    SaveCar(tmpcar);
							return 1;
						}
						if(strcmp(tmppart, "virtual", true) ==0)
						{
						    AddVehicleComponent(tmpcar, wheels_virtual);
						    CarInfo[tmpcar][carswheels] = wheels_virtual;
						    SaveCar(tmpcar);
							return 1;
						}
						if(strcmp(tmppart, "access", true) ==0)
						{
						    AddVehicleComponent(tmpcar, wheels_access);
						    CarInfo[tmpcar][carswheels] = wheels_access;
						    SaveCar(tmpcar);
							return 1;
						}
						if(strcmp(tmppart, "remove", true) ==0)
						{
						    CarInfo[tmpcar][carswheels] = 0;
						    SaveCar(tmpcar);
							return 1;
						}
						if(strcmp(tmppart, "", true) == 0)
						{
						    SendClientMessage(playerid, color_lred, "Server_Error: invalid part name.");
						    return 1;
						}
					}
				}
			}
			//

			//
			if(strcmp(tmpcmd, "fbumper", true) ==0)
			{
			    new tmppart[24];
				tmppart = strtok(cmdtext, idx);
			    if(!strlen(tmppart))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [fbumper] [variable]");
				    SendClientMessage(playerid, color_lorange, str);
				    SendClientMessage(playerid, color_lorange, "Server_Options: alien, xflow, chromer, slammin, remove");
			        return 1;
			    }
			    else
			    {
				    if(strcmp(tmppart, "alien", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 558) //Uranus
						{
						    AddVehicleComponent(tmpcar, fbumper_alien_uranus);
						    CarInfo[tmpcar][carsfbumper] = fbumper_alien_uranus;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 559) //Jester
						{
						    AddVehicleComponent(tmpcar, fbumper_alien_jester);
						    CarInfo[tmpcar][carsfbumper] = fbumper_alien_jester;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 560) //Sultan
						{
						    AddVehicleComponent(tmpcar, fbumper_alien_sultan);
						    CarInfo[tmpcar][carsfbumper] = fbumper_alien_sultan;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 561) //Stratum
						{
						    AddVehicleComponent(tmpcar, fbumper_alien_stratum);
						    CarInfo[tmpcar][carsfbumper] = fbumper_alien_stratum;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 562) //Elegy
						{
						    AddVehicleComponent(tmpcar, fbumper_alien_elegy);
						    CarInfo[tmpcar][carsfbumper] = fbumper_alien_elegy;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 565) //Flash
						{
						    AddVehicleComponent(tmpcar, fbumper_alien_flash);
						    CarInfo[tmpcar][carsfbumper] = fbumper_alien_flash;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "xflow", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 558) //Uranus
						{
						    AddVehicleComponent(tmpcar, fbumper_xflow_uranus);
						    CarInfo[tmpcar][carsfbumper] = fbumper_xflow_uranus;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 559) //Jester
						{
						    AddVehicleComponent(tmpcar, fbumper_xflow_jester);
						    CarInfo[tmpcar][carsfbumper] = fbumper_xflow_jester;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 560) //Sultan
						{
						    AddVehicleComponent(tmpcar, fbumper_xflow_sultan);
						    CarInfo[tmpcar][carsfbumper] = fbumper_xflow_sultan;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 561) //Stratum
						{
						    AddVehicleComponent(tmpcar, fbumper_xflow_stratum);
						    CarInfo[tmpcar][carsfbumper] = fbumper_xflow_stratum;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 562) //Elegy
						{
						    AddVehicleComponent(tmpcar, fbumper_xflow_elegy);
						    CarInfo[tmpcar][carsfbumper] = fbumper_xflow_elegy;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 565) //Flash
						{
						    AddVehicleComponent(tmpcar, fbumper_xflow_flash);
						    CarInfo[tmpcar][carsfbumper] = fbumper_xflow_flash;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "chromer", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 534) //Remington
						{
						    AddVehicleComponent(tmpcar, fbumper_chromer_remington);
						    CarInfo[tmpcar][carsfbumper] = fbumper_chromer_remington;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 535) //Slamvan
						{
						    AddVehicleComponent(tmpcar, fbumper_chromer_slamvan);
						    CarInfo[tmpcar][carsfbumper] = fbumper_chromer_slamvan;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 536) //Blade
						{
						    AddVehicleComponent(tmpcar, fbumper_chromer_blade);
	     					CarInfo[tmpcar][carsfbumper] = fbumper_chromer_blade;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 567) //Savanna
						{
						    AddVehicleComponent(tmpcar, fbumper_chromer_savanna);
						    CarInfo[tmpcar][carsfbumper] = fbumper_chromer_savanna;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 575) //Broadway
						{
						    AddVehicleComponent(tmpcar, fbumper_chromer_broadway);
						    CarInfo[tmpcar][carsfbumper] = fbumper_chromer_broadway;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 576) //Tornado
						{
						    AddVehicleComponent(tmpcar, fbumper_chromer_tornado);
						    CarInfo[tmpcar][carsfbumper] = fbumper_chromer_tornado;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "slamin", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 534) //Remington
						{
						    AddVehicleComponent(tmpcar, fbumper_slamin_remington);
						    CarInfo[tmpcar][carsfbumper] = fbumper_slamin_remington;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 536) //Blade
						{
						    AddVehicleComponent(tmpcar, fbumper_slamin_blade);
	     					CarInfo[tmpcar][carsfbumper] = fbumper_slamin_blade;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 567) //Savanna
						{
						    AddVehicleComponent(tmpcar, fbumper_slamin_savanna);
						    CarInfo[tmpcar][carsfbumper] = fbumper_slamin_savanna;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 575) //Broadway
						{
						    AddVehicleComponent(tmpcar, fbumper_slamin_broadway);
						    CarInfo[tmpcar][carsfbumper] = fbumper_slamin_broadway;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 576) //Tornado
						{
						    AddVehicleComponent(tmpcar, fbumper_slamin_tornado);
						    CarInfo[tmpcar][carsfbumper] = fbumper_slamin_tornado;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
					if(strcmp(tmppart, "remove", true) ==0)
					{
					    CarInfo[tmpcar][carsfbumper] = 0;
					    SaveCar(tmpcar);
					    return 1;
					}
					if(strcmp(tmppart, "", true) == 0)
					{
					    SendClientMessage(playerid, color_lred, "Server_Error: invalid part name.");
					    return 1;
					}
				}
			}
			//

			//
			if(strcmp(tmpcmd, "fbullbars", true) ==0)
			{
			    new tmppart[24];
				tmppart = strtok(cmdtext, idx);
			    if(!strlen(tmppart))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [fbullbars] [variable]");
				    SendClientMessage(playerid, color_lorange, str);
				    SendClientMessage(playerid, color_lorange, "Server_Options: chromer, slamin, remove");
			        return 1;
			    }
			    else
			    {
				    if(strcmp(tmppart, "chromer", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 534) //Remington
						{
						    AddVehicleComponent(tmpcar, fbullbar_chromer_remington);
						    CarInfo[tmpcar][carsfbbars] = fbullbar_chromer_remington;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 535) //Slamvan
						{
						    AddVehicleComponent(tmpcar, fbullbar_chromer_slamvan);
						    CarInfo[tmpcar][carsfbbars] = fbullbar_chromer_slamvan;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "slamin", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 535) //Slamvan
						{
						    AddVehicleComponent(tmpcar, fbullbar_slamin_slamvan);
						    CarInfo[tmpcar][carsfbbars] = fbullbar_slamin_slamvan;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 576) //Tornado
						{
						    AddVehicleComponent(tmpcar, fbumper_slamin_tornado);
						    CarInfo[tmpcar][carsfbbars] = fbumper_slamin_tornado;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
					if(strcmp(tmppart, "remove", true) ==0)
					{
					    CarInfo[tmpcar][carsfbbars] = 0;
					    SaveCar(tmpcar);
					    return 1;
					}
					if(strcmp(tmppart, "", true) == 0)
					{
					    SendClientMessage(playerid, color_lred, "Server_Error: invalid part name.");
					    return 1;
					}
				}
			}
			//

			//
			if(strcmp(tmpcmd, "rbumper", true) ==0)
			{
			    new tmppart[24];
				tmppart = strtok(cmdtext, idx);
			    if(!strlen(tmppart))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [rbumper] [variable]");
				    SendClientMessage(playerid, color_lorange, str);
				    SendClientMessage(playerid, color_lorange, "Server_Options: alien, xflow, chromer, slamin, remove");
			        return 1;
			    }
			    else
			    {
				    if(strcmp(tmppart, "alien", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 558) //Uranus
						{
						    AddVehicleComponent(tmpcar, rbumper_alien_uranus);
						    CarInfo[tmpcar][carsrbumper] = rbumper_alien_uranus;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 559) //Jester
						{
						    AddVehicleComponent(tmpcar, rbumper_alien_jester);
						    CarInfo[tmpcar][carsrbumper] = rbumper_alien_jester;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 560) //Sultan
						{
						    AddVehicleComponent(tmpcar, rbumper_alien_sultan);
						    CarInfo[tmpcar][carsrbumper] = rbumper_alien_sultan;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 561) //Stratum
						{
						    AddVehicleComponent(tmpcar, rbumper_alien_stratum);
						    CarInfo[tmpcar][carsrbumper] = rbumper_alien_stratum;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 562) //Elegy
						{
						    AddVehicleComponent(tmpcar, rbumper_alien_elegy);
						    CarInfo[tmpcar][carsrbumper] = rbumper_alien_elegy;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 565) //Flash
						{
						    AddVehicleComponent(tmpcar, rbumper_alien_flash);
						    CarInfo[tmpcar][carsrbumper] = rbumper_alien_flash;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "xflow", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 558) //Uranus
						{
						    AddVehicleComponent(tmpcar, rbumper_xflow_uranus);
						    CarInfo[tmpcar][carsrbumper] = rbumper_xflow_uranus;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 559) //Jester
						{
						    AddVehicleComponent(tmpcar, rbumper_xflow_jester);
						    CarInfo[tmpcar][carsrbumper] = rbumper_xflow_jester;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 560) //Sultan
						{
						    AddVehicleComponent(tmpcar, rbumper_xflow_sultan);
						    CarInfo[tmpcar][carsrbumper] = rbumper_xflow_sultan;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 561) //Stratum
						{
						    AddVehicleComponent(tmpcar, rbumper_xflow_stratum);
						    CarInfo[tmpcar][carsrbumper] = rbumper_xflow_stratum;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 562) //Elegy
						{
						    AddVehicleComponent(tmpcar, rbumper_xflow_elegy);
						    CarInfo[tmpcar][carsrbumper] = rbumper_xflow_elegy;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 565) //Flash
						{
						    AddVehicleComponent(tmpcar, rbumper_xflow_flash);
						    CarInfo[tmpcar][carsrbumper] = rbumper_xflow_flash;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "chromer", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 534) //Remington
						{
						    AddVehicleComponent(tmpcar, rbumper_chromer_remington);
						    CarInfo[tmpcar][carsrbumper] = rbumper_chromer_remington;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 536) //Blade
						{
						    AddVehicleComponent(tmpcar, rbumper_chromer_blade);
	     					CarInfo[tmpcar][carsrbumper] = rbumper_chromer_blade;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 567) //Savanna
						{
						    AddVehicleComponent(tmpcar, rbumper_chromer_savanna);
						    CarInfo[tmpcar][carsrbumper] = rbumper_chromer_savanna;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 575) //Broadway
						{
						    AddVehicleComponent(tmpcar, rbumper_chromer_broadway);
						    CarInfo[tmpcar][carsrbumper] = rbumper_chromer_broadway;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 576) //Tornado
						{
						    AddVehicleComponent(tmpcar, rbumper_chromer_tornado);
						    CarInfo[tmpcar][carsrbumper] = rbumper_chromer_tornado;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "slamin", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 534) //Remington
						{
						    AddVehicleComponent(tmpcar, rbumper_slamin_remington);
						    CarInfo[tmpcar][carsrbumper] = rbumper_slamin_remington;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 536) //Blade
						{
						    AddVehicleComponent(tmpcar, rbumper_slamin_blade);
	     					CarInfo[tmpcar][carsrbumper] = rbumper_slamin_blade;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 567) //Savanna
						{
						    AddVehicleComponent(tmpcar, rbumper_slamin_savanna);
						    CarInfo[tmpcar][carsrbumper] = rbumper_slamin_savanna;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 575) //Broadway
						{
						    AddVehicleComponent(tmpcar, rbumper_slamin_broadway);
						    CarInfo[tmpcar][carsrbumper] = rbumper_slamin_broadway;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 576) //Tornado
						{
						    AddVehicleComponent(tmpcar, rbumper_slamin_tornado);
						    CarInfo[tmpcar][carsrbumper] = rbumper_slamin_tornado;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
					if(strcmp(tmppart, "remove", true) ==0)
					{
					    CarInfo[tmpcar][carsrbumper] = 0;
					    SaveCar(tmpcar);
					    return 1;
					}
					if(strcmp(tmppart, "", true) == 0)
					{
					    SendClientMessage(playerid, color_lred, "Server_Error: invalid part name.");
					    return 1;
					}
				}
			}
			//

			//
			if(strcmp(tmpcmd, "rbullbars", true) ==0)
			{
			    new tmppart[24];
                tmppart = strtok(cmdtext, idx);
			    if(!strlen(tmppart))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [rbullbars] [variable]");
				    SendClientMessage(playerid, color_lorange, str);
				    SendClientMessage(playerid, color_lorange, "Server_Options: chromer, slamin, remove");
			        return 1;
			    }
			    else
			    {
				    if(strcmp(tmppart, "chromer", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 535) //Slamvan
						{
						    AddVehicleComponent(tmpcar, rbullbar_chromer_slamvan);
						    CarInfo[tmpcar][carsrbbars] = rbullbar_chromer_slamvan;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "slammin", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 535) //Slamvan
						{
						    AddVehicleComponent(tmpcar, rbullbar_slamin_slamvan);
						    CarInfo[tmpcar][carsrbbars] = rbullbar_slamin_slamvan;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
					if(strcmp(tmppart, "remove", true) ==0)
					{
					    CarInfo[tmpcar][carsrbbars] = 0;
					    SaveCar(tmpcar);
					    return 1;
					}
					if(strcmp(tmppart, "", true) == 0)
					{
					    SendClientMessage(playerid, color_lred, "Server_Error: invalid part name.");
					    return 1;
					}
				}
			}
			//

			//
			if(strcmp(tmpcmd, "skirts", true) ==0)
			{
			    new tmppart[24];
			    tmppart = strtok(cmdtext, idx);
			    if(!strlen(tmppart))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [skirts] [variable]");
				    SendClientMessage(playerid, color_lorange, str);
				    SendClientMessage(playerid, color_lorange, "Server_Options: alien, xflow, chromer, slammin, transfender, remove");
			        return 1;
			    }
			    else
			    {
				    if(strcmp(tmppart, "alien", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 558) //Uranus
						{
						    AddVehicleComponent(tmpcar, lskirt_alien_uranus);
						    AddVehicleComponent(tmpcar, rskirt_alien_uranus);
							CarInfo[tmpcar][carslskirt] = lskirt_alien_uranus;
							CarInfo[tmpcar][carsrskirt] = rskirt_alien_uranus;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 559) //Jester
						{
						    AddVehicleComponent(tmpcar, lskirt_alien_jester);
						    AddVehicleComponent(tmpcar, rskirt_alien_jester);
							CarInfo[tmpcar][carslskirt] = lskirt_alien_jester;
							CarInfo[tmpcar][carsrskirt] = rskirt_alien_jester;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 560) //Sultan
						{
						    AddVehicleComponent(tmpcar, lskirt_alien_sultan);
						    AddVehicleComponent(tmpcar, rskirt_alien_sultan);
							CarInfo[tmpcar][carslskirt] = lskirt_alien_sultan;
							CarInfo[tmpcar][carsrskirt] = rskirt_alien_sultan;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 561) //Stratum
						{
						    AddVehicleComponent(tmpcar, lskirt_alien_stratum);
						    AddVehicleComponent(tmpcar, rskirt_alien_stratum);
							CarInfo[tmpcar][carslskirt] = lskirt_alien_stratum;
							CarInfo[tmpcar][carsrskirt] = rskirt_alien_stratum;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 562) //Elegy
						{
						    AddVehicleComponent(tmpcar, lskirt_alien_elegy);
						    AddVehicleComponent(tmpcar, rskirt_alien_elegy);
							CarInfo[tmpcar][carslskirt] = lskirt_alien_elegy;
							CarInfo[tmpcar][carsrskirt] = rskirt_alien_elegy;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 565) //Flash
						{
						    AddVehicleComponent(tmpcar, lskirt_alien_flash);
						    AddVehicleComponent(tmpcar, rskirt_alien_flash);
							CarInfo[tmpcar][carslskirt] = lskirt_alien_flash;
							CarInfo[tmpcar][carsrskirt] = rskirt_alien_flash;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "xflow", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 558) //Uranus
						{
						    AddVehicleComponent(tmpcar, lskirt_xflow_uranus);
						    AddVehicleComponent(tmpcar, rskirt_xflow_uranus);
							CarInfo[tmpcar][carslskirt] = lskirt_xflow_uranus;
							CarInfo[tmpcar][carsrskirt] = rskirt_xflow_uranus;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 559) //Jester
						{
						    AddVehicleComponent(tmpcar, lskirt_xflow_jester);
						    AddVehicleComponent(tmpcar, rskirt_xflow_jester);
							CarInfo[tmpcar][carslskirt] = lskirt_xflow_jester;
							CarInfo[tmpcar][carsrskirt] = rskirt_xflow_jester;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 560) //Sultan
						{
						    AddVehicleComponent(tmpcar, lskirt_xflow_sultan);
						    AddVehicleComponent(tmpcar, rskirt_xflow_sultan);
							CarInfo[tmpcar][carslskirt] = lskirt_xflow_sultan;
							CarInfo[tmpcar][carsrskirt] = rskirt_xflow_sultan;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 561) //Stratum
						{
						    AddVehicleComponent(tmpcar, lskirt_xflow_stratum);
						    AddVehicleComponent(tmpcar, rskirt_xflow_stratum);
							CarInfo[tmpcar][carslskirt] = lskirt_xflow_stratum;
							CarInfo[tmpcar][carsrskirt] = rskirt_xflow_stratum;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 562) //Elegy
						{
						    AddVehicleComponent(tmpcar, lskirt_xflow_elegy);
						    AddVehicleComponent(tmpcar, rskirt_xflow_elegy);
							CarInfo[tmpcar][carslskirt] = lskirt_xflow_elegy;
							CarInfo[tmpcar][carsrskirt] = rskirt_xflow_elegy;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 565) //Flash
						{
						    AddVehicleComponent(tmpcar, lskirt_xflow_flash);
						    AddVehicleComponent(tmpcar, rskirt_xflow_flash);
							CarInfo[tmpcar][carslskirt] = lskirt_xflow_flash;
							CarInfo[tmpcar][carsrskirt] = rskirt_xflow_flash;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "chromer", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 534) //Remington
						{
						    AddVehicleComponent(tmpcar, lskirt_chromer_remington);
						    AddVehicleComponent(tmpcar, rskirt_chromer_remington);
							CarInfo[tmpcar][carslskirt] = lskirt_chromer_remington;
							CarInfo[tmpcar][carsrskirt] = rskirt_chromer_remington;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 535) //Slamvan
						{
						    AddVehicleComponent(tmpcar, lskirt_chromer_slamvan);
						    AddVehicleComponent(tmpcar, rskirt_chromer_slamvan);
							CarInfo[tmpcar][carslskirt] = lskirt_chromer_slamvan;
							CarInfo[tmpcar][carsrskirt] = rskirt_chromer_slamvan;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 536) //Blade
						{
						    AddVehicleComponent(tmpcar, lskirt_chromer_blade);
						    AddVehicleComponent(tmpcar, rskirt_chromer_blade);
							CarInfo[tmpcar][carslskirt] = lskirt_chromer_blade;
							CarInfo[tmpcar][carsrskirt] = rskirt_chromer_blade;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 567) //Savanna
						{
						    AddVehicleComponent(tmpcar, lskirt_chromer_savanna);
						    AddVehicleComponent(tmpcar, rskirt_chromer_savanna);
							CarInfo[tmpcar][carslskirt] = lskirt_chromer_savanna;
							CarInfo[tmpcar][carsrskirt] = rskirt_chromer_savanna;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 575) //Broadway
						{
						    AddVehicleComponent(tmpcar, lskirt_chromer_broadway);
						    AddVehicleComponent(tmpcar, rskirt_chromer_broadway);
							CarInfo[tmpcar][carslskirt] = lskirt_chromer_broadway;
							CarInfo[tmpcar][carsrskirt] = rskirt_chromer_broadway;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 576) //Tornado
						{
						    AddVehicleComponent(tmpcar, lskirt_chromer_tornado);
						    AddVehicleComponent(tmpcar, rskirt_chromer_tornado);
							CarInfo[tmpcar][carslskirt] = lskirt_chromer_tornado;
							CarInfo[tmpcar][carsrskirt] = rskirt_chromer_tornado;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "slamin", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 534) //Remington
						{
	   						AddVehicleComponent(tmpcar, lskirt_slamin_remington);
						    AddVehicleComponent(tmpcar, rskirt_slamin_remington);
							CarInfo[tmpcar][carslskirt] = lskirt_slamin_remington;
							CarInfo[tmpcar][carsrskirt] = rskirt_slamin_remington;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 535) //Slamvan
						{
						    AddVehicleComponent(tmpcar, lskirt_slamin_slamvan);
						    AddVehicleComponent(tmpcar, rskirt_slamin_slamvan);
							CarInfo[tmpcar][carslskirt] = lskirt_slamin_slamvan;
							CarInfo[tmpcar][carsrskirt] = rskirt_slamin_slamvan;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "transfender", true) == 0)
				    {
						AddVehicleComponent(tmpcar, lskirt_transfender);
						AddVehicleComponent(tmpcar, rskirt_transfender);
						CarInfo[tmpcar][carslskirt] = lskirt_transfender;
						CarInfo[tmpcar][carsrskirt] = rskirt_transfender;
						SaveCar(tmpcar);
						return 1;
				    }
					if(strcmp(tmppart, "remove", true) ==0)
					{
					    CarInfo[tmpcar][carslskirt] = 0;
					    CarInfo[tmpcar][carsrskirt] = 0;
					    SaveCar(tmpcar);
					    return 1;
					}
					if(strcmp(tmppart, "", true) == 0)
					{
					    SendClientMessage(playerid, color_lred, "Server_Error: invalid part name.");
					    return 1;
					}
				}
			}
			//

			//
			if(strcmp(tmpcmd, "spoiler", true) ==0)
			{
			    new tmppart[24];
			    tmppart = strtok(cmdtext, idx);
			    if(!strlen(tmppart))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [spoiler] [variable]");
				    SendClientMessage(playerid, color_lorange, str);
				    SendClientMessage(playerid, color_lorange, "Server_Options: alien, xflow, pro, win, drag, alpha, champ, race, worx, fury, remove");
			        return 1;
			    }
			    else
			    {
				    if(strcmp(tmppart, "alien", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 558) //Uranus
						{
						    AddVehicleComponent(tmpcar, spoiler_alien_uranus);
						    CarInfo[tmpcar][carsspoiler] = spoiler_alien_uranus;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 559) //Jester
						{
						    AddVehicleComponent(tmpcar, spoiler_alien_jester);
						    CarInfo[tmpcar][carsspoiler] = spoiler_alien_jester;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 560) //Sultan
						{
						    AddVehicleComponent(tmpcar, spoiler_alien_sultan);
						    CarInfo[tmpcar][carsspoiler] = spoiler_alien_sultan;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 561) //Stratum
						{
						    AddVehicleComponent(tmpcar, spoiler_alien_stratum);
						    CarInfo[tmpcar][carsspoiler] = spoiler_alien_stratum;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 562) //Elegy
						{
						    AddVehicleComponent(tmpcar, spoiler_alien_elegy);
						    CarInfo[tmpcar][carsspoiler] = spoiler_alien_elegy;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 565) //Flash
						{
						    AddVehicleComponent(tmpcar, spoiler_alien_flash);
						    CarInfo[tmpcar][carsspoiler] = spoiler_alien_flash;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "xflow", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 558) //Uranus
						{
						    AddVehicleComponent(tmpcar, spoiler_xflow_uranus);
						    CarInfo[tmpcar][carsspoiler] = spoiler_xflow_uranus;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 559) //Jester
						{
						    AddVehicleComponent(tmpcar, spoiler_xflow_jester);
						    CarInfo[tmpcar][carsspoiler] = spoiler_xflow_jester;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 560) //Sultan
						{
						    AddVehicleComponent(tmpcar, spoiler_xflow_sultan);
						    CarInfo[tmpcar][carsspoiler] = spoiler_xflow_sultan;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 561) //Stratum
						{
						    AddVehicleComponent(tmpcar, spoiler_xflow_stratum);
						    CarInfo[tmpcar][carsspoiler] = spoiler_xflow_stratum;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 562) //Elegy
						{
						    AddVehicleComponent(tmpcar, spoiler_xflow_elegy);
						    CarInfo[tmpcar][carsspoiler] = spoiler_xflow_elegy;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 565) //Flash
						{
						    AddVehicleComponent(tmpcar, spoiler_xflow_flash);
						    CarInfo[tmpcar][carsspoiler] = spoiler_xflow_flash;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "pro", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, spoiler_pro);
					    CarInfo[tmpcar][carsspoiler] = spoiler_pro;
					    SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "drag", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, spoiler_drag);
					    CarInfo[tmpcar][carsspoiler] = spoiler_drag;
					    SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "win", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, spoiler_win);
					    CarInfo[tmpcar][carsspoiler] = spoiler_win;
					    SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "alpha", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, spoiler_alpha);
					    CarInfo[tmpcar][carsspoiler] = spoiler_alpha;
					    SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "champ", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, spoiler_champ);
					    CarInfo[tmpcar][carsspoiler] = spoiler_champ;
					    SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "race", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, spoiler_race);
					    CarInfo[tmpcar][carsspoiler] = spoiler_race;
					    SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "worx", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, spoiler_worx);
					    CarInfo[tmpcar][carsspoiler] = spoiler_worx;
					    SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "fury", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, spoiler_fury);
					    CarInfo[tmpcar][carsspoiler] = spoiler_fury;
					    SaveCar(tmpcar);
					    return 1;
				    }
					if(strcmp(tmppart, "remove", true) ==0)
					{
					    CarInfo[tmpcar][carsspoiler] = 0;
					    SaveCar(tmpcar);
					    return 1;
					}
					if(strcmp(tmppart, "", true) == 0)
					{
					    SendClientMessage(playerid, color_lred, "Server_Error: invalid part name.");
					    return 1;
					}
				}
			}
			//

			//
			if(strcmp(tmpcmd, "hydros", true) ==0)
			{
			    new tmppart[24];
			    tmppart = strtok(cmdtext, idx);
			    if(!strlen(tmppart))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [hydros] [variable]");
				    SendClientMessage(playerid, color_lorange, str);
				    SendClientMessage(playerid, color_lorange, "Server_Options: install, uninstall");
			        return 1;
			    }
			    else
			    {
				    if(strcmp(tmppart, "install", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, hydralics);
					    CarInfo[tmpcar][carshydros] = hydralics;
					    SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "uninstall", true) == 0)
				    {
					    CarInfo[tmpcar][carshydros] = 0;
					    SaveCar(tmpcar);
					    return 1;
				    }
					if(strcmp(tmppart, "", true) == 0)
					{
					    SendClientMessage(playerid, color_lred, "Server_Error: invalid part name.");
					    return 1;
					}
				}
			}
			//

			//
			if(strcmp(tmpcmd, "roof", true) ==0)
			{
			    new tmppart[24];
			    tmppart = strtok(cmdtext, idx);
			    if(!strlen(tmppart))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [roof] [variable]");
				    SendClientMessage(playerid, color_lorange, str);
				    SendClientMessage(playerid, color_lorange, "Server_Options: alien, xflow, softtop, hardtop, transfender, remove");
			        return 1;
			    }
			    else
			    {
				    if(strcmp(tmppart, "alien", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 558) //Uranus
						{
						    AddVehicleComponent(tmpcar, roof_alien_uranus);
						    CarInfo[tmpcar][carsroof] = roof_alien_uranus;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 559) //Jester
						{
						    AddVehicleComponent(tmpcar, roof_alien_jester);
						    CarInfo[tmpcar][carsroof] = roof_alien_jester;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 560) //Sultan
						{
						    AddVehicleComponent(tmpcar, roof_alien_sultan);
						    CarInfo[tmpcar][carsroof] = roof_alien_sultan;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 561) //Stratum
						{
						    AddVehicleComponent(tmpcar, roof_alien_stratum);
						    CarInfo[tmpcar][carsroof] = roof_alien_stratum;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 562) //Elegy
						{
						    AddVehicleComponent(tmpcar, roof_alien_elegy);
						    CarInfo[tmpcar][carsroof] = roof_alien_elegy;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 565) //Flash
						{
						    AddVehicleComponent(tmpcar, roof_alien_flash);
						    CarInfo[tmpcar][carsroof] = roof_alien_flash;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "xflow", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 558) //Uranus
						{
						    AddVehicleComponent(tmpcar, roof_xflow_uranus);
						    CarInfo[tmpcar][carsroof] = roof_xflow_uranus;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 559) //Jester
						{
						    AddVehicleComponent(tmpcar, roof_xflow_jester);
						    CarInfo[tmpcar][carsroof] = roof_xflow_jester;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 560) //Sultan
						{
						    AddVehicleComponent(tmpcar, roof_xflow_sultan);
						    CarInfo[tmpcar][carsroof] = roof_xflow_sultan;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 561) //Stratum
						{
						    AddVehicleComponent(tmpcar, roof_xflow_stratum);
						    CarInfo[tmpcar][carsroof] = roof_xflow_stratum;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 562) //Elegy
						{
						    AddVehicleComponent(tmpcar, roof_xflow_elegy);
						    CarInfo[tmpcar][carsroof] = roof_xflow_elegy;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 565) //Flash
						{
						    AddVehicleComponent(tmpcar, roof_xflow_flash);
						    CarInfo[tmpcar][carsroof] = roof_xflow_flash;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "softtop", true) == 0)
				    {
				        if(CarInfo[tmpcar][carsmodel] == 536) //Blade
				        {
						    AddVehicleComponent(tmpcar, roof_softtop_blade);
						    CarInfo[tmpcar][carsroof] = roof_softtop_blade;
						    SaveCar(tmpcar);
						    return 1;
						}
				        if(CarInfo[tmpcar][carsmodel] == 567) //Savanna
				        {
						    AddVehicleComponent(tmpcar, roof_softtop_savanna);
						    CarInfo[tmpcar][carsroof] = roof_softtop_savanna;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "hardtop", true) == 0)
				    {
				        if(CarInfo[tmpcar][carsmodel] == 536) //Blade
				        {
						    AddVehicleComponent(tmpcar, roof_hardtop_blade);
						    CarInfo[tmpcar][carsroof] = roof_hardtop_blade;
						    SaveCar(tmpcar);
						    return 1;
						}
				        if(CarInfo[tmpcar][carsmodel] == 567) //Savanna
				        {
						    AddVehicleComponent(tmpcar, roof_hardtop_savanna);
						    CarInfo[tmpcar][carsroof] = roof_hardtop_savanna;
						    SaveCar(tmpcar);
						    return 1;
						}
					    return 1;
				    }
				    if(strcmp(tmppart, "transfender", true) == 0)
			        {
					    AddVehicleComponent(tmpcar, roof_transfender);
					    CarInfo[tmpcar][carsroof] = roof_transfender;
					    SaveCar(tmpcar);
					    return 1;
				    }
					if(strcmp(tmppart, "remove", true) ==0)
					{
					    CarInfo[tmpcar][carsroof] = 0;
					    SaveCar(tmpcar);
					    return 1;
					}
					if(strcmp(tmppart, "", true) == 0)
					{
					    SendClientMessage(playerid, color_lred, "Server_Error: invalid part name.");
					    return 1;
					}
				}
			}
			//

			//
			if(strcmp(tmpcmd, "hoodscoop", true) ==0)
			{
			    new tmppart[24];
			    tmppart = strtok(cmdtext, idx);
			    if(!strlen(tmppart))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [hoodscoop] [variable]");
				    SendClientMessage(playerid, color_lorange, str);
				    SendClientMessage(playerid, color_lorange, "Server_Options: champ, fury, race, worx, remove");
			        return 1;
			    }
			    else
				{
				    if(strcmp(tmppart, "champ", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, hood_champ);
					    CarInfo[tmpcar][carshood] = hood_champ;
					    SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "fury", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, hood_fury);
					    CarInfo[tmpcar][carshood] = hood_fury;
					    SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "race", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, hood_race);
					    CarInfo[tmpcar][carshood] = hood_race;
					    SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "worx", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, hood_worx);
					    CarInfo[tmpcar][carshood] = hood_worx;
					    SaveCar(tmpcar);
					    return 1;
				    }
					if(strcmp(tmppart, "remove", true) ==0)
					{
					    CarInfo[tmpcar][carshood] = 0;
					    SaveCar(tmpcar);
					    return 1;
					}
					if(strcmp(tmppart, "", true) == 0)
					{
					    SendClientMessage(playerid, color_lred, "Server_Error: invalid part name.");
					    return 1;
					}
				}
			}
			//

			//
			if(strcmp(tmpcmd, "hoodvents", true) ==0)
			{
			    new tmppart[24];
			    tmppart = strtok(cmdtext, idx);
			    if(!strlen(tmppart))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [hoodvents] [variable]");
				    SendClientMessage(playerid, color_lorange, str);
				    SendClientMessage(playerid, color_lorange, "Server_Options: oval, square, remove");
			        return 1;
			    }
			    else
				{
				    if(strcmp(tmppart, "oval", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, lhood_oval);
					    AddVehicleComponent(tmpcar, rhood_oval);
					    CarInfo[tmpcar][carshood] = lhood_oval;
					    CarInfo[tmpcar][carshood] = rhood_oval;
					    SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "square", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, lhood_square);
					    AddVehicleComponent(tmpcar, rhood_square);
					    CarInfo[tmpcar][carshood] = lhood_square;
					    CarInfo[tmpcar][carshood] = rhood_square;
					    SaveCar(tmpcar);
					    return 1;
				    }
					if(strcmp(tmppart, "remove", true) ==0)
					{
					    CarInfo[tmpcar][carshood] = 0;
					    CarInfo[tmpcar][carshood] = 0;
					    SaveCar(tmpcar);
					    return 1;
					}
					if(strcmp(tmppart, "", true) == 0)
					{
					    SendClientMessage(playerid, color_lred, "Server_Error: invalid part name.");
					    return 1;
					}
				}
			}
			//

			//
			if(strcmp(tmpcmd, "exhaust", true) ==0)
			{
			    new tmppart[24];
			    tmppart = strtok(cmdtext, idx);
			    if(!strlen(tmppart))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [exhaust] [variable]");
				    SendClientMessage(playerid, color_lorange, str);
				    SendClientMessage(playerid, color_lorange, "Server_Options: alien, xflow, chromer, slamin, upsweep, twin, small, medium, large, remove");
			        return 1;
			    }
			    else
			    {
				    if(strcmp(tmppart, "alien", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 558) //Uranus
						{
						    AddVehicleComponent(tmpcar, exhaust_alien_uranus);
						    CarInfo[tmpcar][carsexhaust] = exhaust_alien_uranus;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 559) //Jester
						{
						    AddVehicleComponent(tmpcar, exhaust_alien_jester);
						    CarInfo[tmpcar][carsexhaust] = exhaust_alien_jester;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 560) //Sultan
						{
						    AddVehicleComponent(tmpcar, exhaust_alien_sultan);
						    CarInfo[tmpcar][carsexhaust] = exhaust_alien_sultan;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 561) //Stratum
						{
						    AddVehicleComponent(tmpcar, exhaust_alien_stratum);
						    CarInfo[tmpcar][carsexhaust] = exhaust_alien_stratum;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 562) //Elegy
						{
						    AddVehicleComponent(tmpcar, exhaust_alien_elegy);
						    CarInfo[tmpcar][carsexhaust] = exhaust_alien_elegy;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 565) //Flash
						{
						    AddVehicleComponent(tmpcar, exhaust_alien_flash);
						    CarInfo[tmpcar][carsexhaust] = exhaust_alien_flash;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "xflow", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 558) //Uranus
						{
						    AddVehicleComponent(tmpcar, exhaust_xflow_uranus);
						    CarInfo[tmpcar][carsexhaust] = exhaust_xflow_uranus;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 559) //Jester
						{
						    AddVehicleComponent(tmpcar, exhaust_xflow_jester);
						    CarInfo[tmpcar][carsexhaust] = exhaust_xflow_jester;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 560) //Sultan
						{
						    AddVehicleComponent(tmpcar, exhaust_xflow_sultan);
						    CarInfo[tmpcar][carsexhaust] = exhaust_xflow_sultan;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 561) //Stratum
						{
						    AddVehicleComponent(tmpcar, exhaust_xflow_stratum);
						    CarInfo[tmpcar][carsexhaust] = exhaust_xflow_stratum;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 562) //Elegy
						{
						    AddVehicleComponent(tmpcar, exhaust_xflow_elegy);
						    CarInfo[tmpcar][carsexhaust] = exhaust_xflow_elegy;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 565) //Flash
						{
						    AddVehicleComponent(tmpcar, exhaust_xflow_flash);
						    CarInfo[tmpcar][carsexhaust] = exhaust_xflow_flash;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "chromer", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 534) //Remington
						{
						    AddVehicleComponent(tmpcar, exhaust_chromer_remington);
						    CarInfo[tmpcar][carsexhaust] = exhaust_chromer_remington;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 535) //Slamvan
						{
						    AddVehicleComponent(tmpcar, exhaust_chromer_slamvan);
						    CarInfo[tmpcar][carsexhaust] = exhaust_chromer_slamvan;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 536) //Blade
						{
						    AddVehicleComponent(tmpcar, exhaust_chromer_blade);
						    CarInfo[tmpcar][carsexhaust] = exhaust_chromer_blade;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 567) //Savanna
						{
						    AddVehicleComponent(tmpcar, exhaust_chromer_savanna);
						    CarInfo[tmpcar][carsexhaust] = exhaust_chromer_savanna;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 575) //Broadway
						{
						    AddVehicleComponent(tmpcar, exhaust_chromer_broadway);
						    CarInfo[tmpcar][carsexhaust] = exhaust_chromer_broadway;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 576) //Tornado
						{
						    AddVehicleComponent(tmpcar, exhaust_chromer_tornado);
						    CarInfo[tmpcar][carsexhaust] = exhaust_chromer_tornado;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "slamin", true) == 0)
				    {
						if(CarInfo[tmpcar][carsmodel] == 534) //Remington
						{
						    AddVehicleComponent(tmpcar, exhaust_slamin_remington);
						    CarInfo[tmpcar][carsexhaust] = exhaust_slamin_remington;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 535) //Slamvan
						{
						    AddVehicleComponent(tmpcar, exhaust_slamin_slamvan);
						    CarInfo[tmpcar][carsexhaust] = exhaust_slamin_slamvan;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 536) //Blade
						{
						    AddVehicleComponent(tmpcar, exhaust_slamin_blade);
						    CarInfo[tmpcar][carsexhaust] = exhaust_slamin_blade;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 567) //Savanna
						{
						    AddVehicleComponent(tmpcar, exhaust_slamin_savanna);
						    CarInfo[tmpcar][carsexhaust] = exhaust_slamin_savanna;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 575) //Broadway
						{
						    AddVehicleComponent(tmpcar, exhaust_slamin_broadway);
						    CarInfo[tmpcar][carsexhaust] = exhaust_slamin_broadway;
						    SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 576) //Tornado
						{
						    AddVehicleComponent(tmpcar, exhaust_slamin_tornado);
						    CarInfo[tmpcar][carsexhaust] = exhaust_slamin_tornado;
						    SaveCar(tmpcar);
						    return 1;
						}
				    }
				    if(strcmp(tmppart, "upsweep", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, exhaust_upsweep);
					    CarInfo[tmpcar][carsexhaust] = exhaust_upsweep;
					    SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "twin", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, exhaust_twin);
					    CarInfo[tmpcar][carsexhaust] = exhaust_twin;
					    SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "small", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, exhaust_small);
					    CarInfo[tmpcar][carsexhaust] = exhaust_small;
					    SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "medium", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, exhaust_medium);
					    CarInfo[tmpcar][carsexhaust] = exhaust_medium;
					    SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "large", true) == 0)
				    {
					    AddVehicleComponent(tmpcar, exhaust_large);
					    CarInfo[tmpcar][carsexhaust] = exhaust_large;
					    SaveCar(tmpcar);
					    return 1;
				    }
					if(strcmp(tmppart, "remove", true) ==0)
					{
					    CarInfo[tmpcar][carsexhaust] = 0;
					    SaveCar(tmpcar);
					    return 1;
					}
					if(strcmp(tmppart, "", true) == 0)
					{
					    SendClientMessage(playerid, color_lred, "Server_Error: invalid part name.");
					    return 1;
					}
				}
			}
			//

			//
			if(strcmp(tmpcmd, "stereo", true) ==0)
			{
			    new tmppart[24];
			    tmppart = strtok(cmdtext, idx);
			    if(!strlen(tmppart))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [stereo] [variable]");
				    SendClientMessage(playerid, color_lorange, str);
				    SendClientMessage(playerid, color_lorange, "Server_Options: install, uninstall");
			        return 1;
			    }
			    else
			    {
				    if(strcmp(tmppart, "install", true) == 0)
				    {
						AddVehicleComponent(tmpcar, stereo_bassboost);
						CarInfo[tmpcar][carsstereo] = stereo_bassboost;
						SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "uninstall", true) == 0)
				    {
						CarInfo[tmpcar][carsstereo] = 0;
						SaveCar(tmpcar);
					    return 1;
				    }
					if(strcmp(tmppart, "", true) == 0)
					{
					    SendClientMessage(playerid, color_lred, "Server_Error: invalid part name.");
					    return 1;
					}
				}
			}
			//

			//
			if(strcmp(tmpcmd, "lights", true) ==0)
			{
			    new tmppart[24];
			    tmppart = strtok(cmdtext, idx);
			    if(!strlen(tmppart))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [lights] [variable]");
				    SendClientMessage(playerid, color_lorange, str);
				    SendClientMessage(playerid, color_lorange, "Server_Options: square, round, remove");
			        return 1;
			    }
			    else
			    {
				    if(strcmp(tmppart, "square", true) == 0)
				    {
	  					AddVehicleComponent(tmpcar, lights_square);
						CarInfo[tmpcar][carslights] = lights_square;
						SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "round", true) == 0)
				    {
	  					AddVehicleComponent(tmpcar, lights_round);
						CarInfo[tmpcar][carslights] = lights_round;
						SaveCar(tmpcar);
					    return 1;
				    }
					if(strcmp(tmppart, "remove", true) ==0)
					{
					    CarInfo[tmpcar][carslights] = 0;
					    SaveCar(tmpcar);
					    return 1;
					}
					if(strcmp(tmppart, "", true) == 0)
					{
					    SendClientMessage(playerid, color_lred, "Server_Error: invalid part name.");
					    return 1;
					}
				}
			}
			//

			//
			if(strcmp(tmpcmd, "nitro", true) ==0)
			{
			    new tmppart[24];
			    tmppart = strtok(cmdtext, idx);
			    if(!strlen(tmppart))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [nitro] [variable]");
				    SendClientMessage(playerid, color_lorange, str);
				    SendClientMessage(playerid, color_lorange, "Server_Options: 2x, 5x, 10x, remove");
			        return 1;
			    }
			    else
			    {
				    if(strcmp(tmppart, "2x", true) == 0)
				    {
	  					AddVehicleComponent(tmpcar, nitro_2);
						CarInfo[tmpcar][carsnitro] = nitro_2;
						SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "5x", true) == 0)
				    {
	  					AddVehicleComponent(tmpcar, nitro_5);
						CarInfo[tmpcar][carsnitro] = nitro_5;
						SaveCar(tmpcar);
					    return 1;
				    }
				    if(strcmp(tmppart, "10x", true) == 0)
				    {
	  					AddVehicleComponent(tmpcar, nitro_10);
						CarInfo[tmpcar][carsnitro] = nitro_10;
						SaveCar(tmpcar);
					    return 1;
				    }
					if(strcmp(tmppart, "remove", true) ==0)
					{
					    CarInfo[tmpcar][carsnitro] = 0;
					    SaveCar(tmpcar);
					    return 1;
					}
					if(strcmp(tmppart, "", true) == 0)
					{
					    SendClientMessage(playerid, color_lred, "Server_Error: invalid part name.");
					    return 1;
					}
				}
			}
			//

			//
			if(strcmp(tmpcmd, "color1", true) ==0)
			{
			    new tmppart;
			    tmp = strtok(cmdtext, idx);
			    if(!strlen(tmp))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [color1] [0~126]");
				    SendClientMessage(playerid, color_lorange, str);
			        return 1;
			    }
			    tmppart = strval(tmp);
			    if(tmppart > -1 && tmppart < 127)
			    {
			        CarInfo[tmpcar][carscolor1] = tmppart;
			        ChangeVehicleColor(tmpcar, CarInfo[tmpcar][carscolor1], CarInfo[tmpcar][carscolor2]);
			        SaveCar(tmpcar);
			        return 1;
			    }
			    else
			    {
			        SendClientMessage(playerid, color_lred, "Server_Error: values 0~126 only.");
			        return 1;
			    }
			}
			//

			//
			if(strcmp(tmpcmd, "color2", true) ==0)
			{
			    new tmppart;
			    tmp = strtok(cmdtext, idx);
			    if(!strlen(tmp))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [color2] [0~126]");
				    SendClientMessage(playerid, color_lorange, str);
			        return 1;
			    }
			    tmppart = strval(tmp);
			    if(tmppart > -1 && tmppart < 127)
			    {
			        CarInfo[tmpcar][carscolor2] = tmppart;
			        ChangeVehicleColor(tmpcar, CarInfo[tmpcar][carscolor1], CarInfo[tmpcar][carscolor2]);
			        SaveCar(tmpcar);
			        return 1;
			    }
			    else
			    {
			        SendClientMessage(playerid, color_lred, "Server_Error: values 0~126 only.");
			        return 1;
			    }
			}
			//

			//
			if(strcmp(tmpcmd, "paint", true) ==0)
			{
			    new tmppart;
			    tmp = strtok(cmdtext, idx);
			    if(!strlen(tmp))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [paint] [0~8]");
				    SendClientMessage(playerid, color_lorange, str);
			        return 1;
			    }
			    tmppart = strval(tmp);
			    if(tmppart > -1 && tmppart < 9)
			    {
			        CarInfo[tmpcar][carscolor3] = tmppart;
					ChangeVehiclePaintjob(tmpcar, CarInfo[tmpcar][carscolor3]);
			        SaveCar(tmpcar);
			        return 1;
			    }
				else
				{
			        SendClientMessage(playerid, color_lred, "Server_Error: values 0~8 only.");
			        return 1;
			    }
			}
			if(strcmp(tmpcmd, "fullcar", true) ==0)
			{
			    new tmppart[24];
				tmppart = strtok(cmdtext, idx);
			    if(!strlen(tmppart))
			    {
				    SendClientMessage(playerid, color_green,   "____________________________________________________________________________________________");
					format(str, sizeof(str),                   "Server_CommandCheck:/editcar [%d] [fullcar] [variable]");
				    SendClientMessage(playerid, color_lorange, str);
				    SendClientMessage(playerid, color_lorange, "Server_Options: alien, xflow, rally, remove");
			        return 1;
			    }
			    else
			    {
			        if(strcmp(tmppart, "alien", true) ==0)
			        {
						if(CarInfo[tmpcar][carsmodel] == 558) //Uranus
						{
							CarInfo[tmpcar][carsfbumper]    =fbumper_alien_uranus;
							CarInfo[tmpcar][carsrbumper]    =rbumper_alien_uranus;
							CarInfo[tmpcar][carslskirt]     =lskirt_alien_uranus;
							CarInfo[tmpcar][carsrskirt]     =rskirt_alien_uranus;
							CarInfo[tmpcar][carsspoiler]    =spoiler_alien_uranus;
							CarInfo[tmpcar][carsroof]       =roof_alien_uranus;
							CarInfo[tmpcar][carsexhaust]    =exhaust_alien_uranus;
							CarInfo[tmpcar][carswheels]     =wheels_cutter;
							AddVehicleComponent(tmpcar, fbumper_alien_uranus);
							AddVehicleComponent(tmpcar, rbumper_alien_uranus);
							AddVehicleComponent(tmpcar, lskirt_alien_uranus);
							AddVehicleComponent(tmpcar, rskirt_alien_uranus);
							AddVehicleComponent(tmpcar, spoiler_alien_uranus);
							AddVehicleComponent(tmpcar, roof_alien_uranus);
							AddVehicleComponent(tmpcar, exhaust_alien_uranus);
							AddVehicleComponent(tmpcar, wheels_cutter);
							SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 559) //Jester
						{
							CarInfo[tmpcar][carsfbumper]    =fbumper_alien_jester;
							CarInfo[tmpcar][carsrbumper]    =rbumper_alien_jester;
							CarInfo[tmpcar][carslskirt]     =lskirt_alien_jester;
							CarInfo[tmpcar][carsrskirt]     =rskirt_alien_jester;
							CarInfo[tmpcar][carsspoiler]    =spoiler_alien_jester;
							CarInfo[tmpcar][carsroof]       =roof_alien_jester;
							CarInfo[tmpcar][carsexhaust]    =exhaust_alien_jester;
							CarInfo[tmpcar][carswheels]     =wheels_cutter;
							AddVehicleComponent(tmpcar, fbumper_alien_jester);
							AddVehicleComponent(tmpcar, rbumper_alien_jester);
							AddVehicleComponent(tmpcar, lskirt_alien_jester);
							AddVehicleComponent(tmpcar, rskirt_alien_jester);
							AddVehicleComponent(tmpcar, spoiler_alien_jester);
							AddVehicleComponent(tmpcar, roof_alien_jester);
							AddVehicleComponent(tmpcar, exhaust_alien_jester);
							AddVehicleComponent(tmpcar, wheels_cutter);
							SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 560) //Sultan
						{
							CarInfo[tmpcar][carsfbumper]    =fbumper_alien_sultan;
							CarInfo[tmpcar][carsrbumper]    =rbumper_alien_sultan;
							CarInfo[tmpcar][carslskirt]     =lskirt_alien_sultan;
							CarInfo[tmpcar][carsrskirt]     =rskirt_alien_sultan;
							CarInfo[tmpcar][carsspoiler]    =spoiler_alien_sultan;
							CarInfo[tmpcar][carsroof]       =roof_alien_sultan;
							CarInfo[tmpcar][carsexhaust]    =exhaust_alien_sultan;
							CarInfo[tmpcar][carswheels]     =wheels_cutter;
							AddVehicleComponent(tmpcar, fbumper_alien_sultan);
							AddVehicleComponent(tmpcar, rbumper_alien_sultan);
							AddVehicleComponent(tmpcar, lskirt_alien_sultan);
							AddVehicleComponent(tmpcar, rskirt_alien_sultan);
							AddVehicleComponent(tmpcar, spoiler_alien_sultan);
							AddVehicleComponent(tmpcar, roof_alien_sultan);
							AddVehicleComponent(tmpcar, exhaust_alien_sultan);
							AddVehicleComponent(tmpcar, wheels_cutter);
							SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 561) //Stratum
						{
							CarInfo[tmpcar][carsfbumper]    =fbumper_alien_stratum;
							CarInfo[tmpcar][carsrbumper]    =rbumper_alien_stratum;
							CarInfo[tmpcar][carslskirt]     =lskirt_alien_stratum;
							CarInfo[tmpcar][carsrskirt]     =rskirt_alien_stratum;
							CarInfo[tmpcar][carsspoiler]    =spoiler_alien_stratum;
							CarInfo[tmpcar][carsroof]       =roof_alien_stratum;
							CarInfo[tmpcar][carsexhaust]    =exhaust_alien_stratum;
							CarInfo[tmpcar][carswheels]     =wheels_cutter;
							AddVehicleComponent(tmpcar, fbumper_alien_stratum);
							AddVehicleComponent(tmpcar, rbumper_alien_stratum);
							AddVehicleComponent(tmpcar, lskirt_alien_stratum);
							AddVehicleComponent(tmpcar, rskirt_alien_stratum);
							AddVehicleComponent(tmpcar, spoiler_alien_stratum);
							AddVehicleComponent(tmpcar, roof_alien_stratum);
							AddVehicleComponent(tmpcar, exhaust_alien_stratum);
							AddVehicleComponent(tmpcar, wheels_cutter);
							SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 562) //Elegy
						{
							CarInfo[tmpcar][carsfbumper]    =fbumper_alien_elegy;
							CarInfo[tmpcar][carsrbumper]    =rbumper_alien_elegy;
							CarInfo[tmpcar][carslskirt]     =lskirt_alien_elegy;
							CarInfo[tmpcar][carsrskirt]     =rskirt_alien_elegy;
							CarInfo[tmpcar][carsspoiler]    =spoiler_alien_elegy;
							CarInfo[tmpcar][carsroof]       =roof_alien_elegy;
							CarInfo[tmpcar][carsexhaust]    =exhaust_alien_elegy;
							CarInfo[tmpcar][carswheels]     =wheels_cutter;
							AddVehicleComponent(tmpcar, fbumper_alien_elegy);
							AddVehicleComponent(tmpcar, rbumper_alien_elegy);
							AddVehicleComponent(tmpcar, lskirt_alien_elegy);
							AddVehicleComponent(tmpcar, rskirt_alien_elegy);
							AddVehicleComponent(tmpcar, spoiler_alien_elegy);
							AddVehicleComponent(tmpcar, roof_alien_elegy);
							AddVehicleComponent(tmpcar, exhaust_alien_elegy);
							AddVehicleComponent(tmpcar, wheels_cutter);
							SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 565) //Flash
						{
							CarInfo[tmpcar][carsfbumper]    =fbumper_alien_flash;
							CarInfo[tmpcar][carsrbumper]    =rbumper_alien_flash;
							CarInfo[tmpcar][carslskirt]     =lskirt_alien_flash;
							CarInfo[tmpcar][carsrskirt]     =rskirt_alien_flash;
							CarInfo[tmpcar][carsspoiler]    =spoiler_alien_flash;
							CarInfo[tmpcar][carsroof]       =roof_alien_flash;
							CarInfo[tmpcar][carsexhaust]    =exhaust_alien_flash;
							CarInfo[tmpcar][carswheels]     =wheels_cutter;
							AddVehicleComponent(tmpcar, fbumper_alien_flash);
							AddVehicleComponent(tmpcar, rbumper_alien_flash);
							AddVehicleComponent(tmpcar, lskirt_alien_flash);
							AddVehicleComponent(tmpcar, rskirt_alien_flash);
							AddVehicleComponent(tmpcar, spoiler_alien_flash);
							AddVehicleComponent(tmpcar, roof_alien_flash);
							AddVehicleComponent(tmpcar, exhaust_alien_flash);
							AddVehicleComponent(tmpcar, wheels_cutter);
							SaveCar(tmpcar);
						    return 1;
						}
			        }
			        if(strcmp(tmppart, "xflow", true) ==0)
			        {
						if(CarInfo[tmpcar][carsmodel] == 558) //Uranus
						{
							CarInfo[tmpcar][carsfbumper]    =fbumper_xflow_uranus;
							CarInfo[tmpcar][carsrbumper]    =rbumper_xflow_uranus;
							CarInfo[tmpcar][carslskirt]     =lskirt_xflow_uranus;
							CarInfo[tmpcar][carsrskirt]     =rskirt_xflow_uranus;
							CarInfo[tmpcar][carsspoiler]    =spoiler_xflow_uranus;
							CarInfo[tmpcar][carsroof]       =roof_xflow_uranus;
							CarInfo[tmpcar][carsexhaust]    =exhaust_xflow_uranus;
							CarInfo[tmpcar][carswheels]     =wheels_cutter;
							AddVehicleComponent(tmpcar, fbumper_xflow_uranus);
							AddVehicleComponent(tmpcar, rbumper_xflow_uranus);
							AddVehicleComponent(tmpcar, lskirt_xflow_uranus);
							AddVehicleComponent(tmpcar, rskirt_xflow_uranus);
							AddVehicleComponent(tmpcar, spoiler_xflow_uranus);
							AddVehicleComponent(tmpcar, roof_xflow_uranus);
							AddVehicleComponent(tmpcar, exhaust_xflow_uranus);
							AddVehicleComponent(tmpcar, wheels_cutter);
							SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 559) //Jester
						{
							CarInfo[tmpcar][carsfbumper]    =fbumper_xflow_jester;
							CarInfo[tmpcar][carsrbumper]    =rbumper_xflow_jester;
							CarInfo[tmpcar][carslskirt]     =lskirt_xflow_jester;
							CarInfo[tmpcar][carsrskirt]     =rskirt_xflow_jester;
							CarInfo[tmpcar][carsspoiler]    =spoiler_xflow_jester;
							CarInfo[tmpcar][carsroof]       =roof_xflow_jester;
							CarInfo[tmpcar][carsexhaust]    =exhaust_xflow_jester;
							CarInfo[tmpcar][carswheels]     =wheels_cutter;
							AddVehicleComponent(tmpcar, fbumper_xflow_jester);
							AddVehicleComponent(tmpcar, rbumper_xflow_jester);
							AddVehicleComponent(tmpcar, lskirt_xflow_jester);
							AddVehicleComponent(tmpcar, rskirt_xflow_jester);
							AddVehicleComponent(tmpcar, spoiler_xflow_jester);
							AddVehicleComponent(tmpcar, roof_xflow_jester);
							AddVehicleComponent(tmpcar, exhaust_xflow_jester);
							AddVehicleComponent(tmpcar, wheels_cutter);
							SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 560) //Sultan
						{
							CarInfo[tmpcar][carsfbumper]    =fbumper_xflow_sultan;
							CarInfo[tmpcar][carsrbumper]    =rbumper_xflow_sultan;
							CarInfo[tmpcar][carslskirt]     =lskirt_xflow_sultan;
							CarInfo[tmpcar][carsrskirt]     =rskirt_xflow_sultan;
							CarInfo[tmpcar][carsspoiler]    =spoiler_xflow_sultan;
							CarInfo[tmpcar][carsroof]       =roof_xflow_sultan;
							CarInfo[tmpcar][carsexhaust]    =exhaust_xflow_sultan;
							CarInfo[tmpcar][carswheels]     =wheels_cutter;
							AddVehicleComponent(tmpcar, fbumper_xflow_sultan);
							AddVehicleComponent(tmpcar, rbumper_xflow_sultan);
							AddVehicleComponent(tmpcar, lskirt_xflow_sultan);
							AddVehicleComponent(tmpcar, rskirt_xflow_sultan);
							AddVehicleComponent(tmpcar, spoiler_xflow_sultan);
							AddVehicleComponent(tmpcar, roof_xflow_sultan);
							AddVehicleComponent(tmpcar, exhaust_xflow_sultan);
							AddVehicleComponent(tmpcar, wheels_cutter);
							SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 561) //Stratum
						{
							CarInfo[tmpcar][carsfbumper]    =fbumper_xflow_stratum;
							CarInfo[tmpcar][carsrbumper]    =rbumper_xflow_stratum;
							CarInfo[tmpcar][carslskirt]     =lskirt_xflow_stratum;
							CarInfo[tmpcar][carsrskirt]     =rskirt_xflow_stratum;
							CarInfo[tmpcar][carsspoiler]    =spoiler_xflow_stratum;
							CarInfo[tmpcar][carsroof]       =roof_xflow_stratum;
							CarInfo[tmpcar][carsexhaust]    =exhaust_xflow_stratum;
							CarInfo[tmpcar][carswheels]     =wheels_cutter;
							AddVehicleComponent(tmpcar, fbumper_xflow_stratum);
							AddVehicleComponent(tmpcar, rbumper_xflow_stratum);
							AddVehicleComponent(tmpcar, lskirt_xflow_stratum);
							AddVehicleComponent(tmpcar, rskirt_xflow_stratum);
							AddVehicleComponent(tmpcar, spoiler_xflow_stratum);
							AddVehicleComponent(tmpcar, roof_xflow_stratum);
							AddVehicleComponent(tmpcar, exhaust_xflow_stratum);
							AddVehicleComponent(tmpcar, wheels_cutter);
							SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 562) //Elegy
						{
							CarInfo[tmpcar][carsfbumper]    =fbumper_xflow_elegy;
							CarInfo[tmpcar][carsrbumper]    =rbumper_xflow_elegy;
							CarInfo[tmpcar][carslskirt]     =lskirt_xflow_elegy;
							CarInfo[tmpcar][carsrskirt]     =rskirt_xflow_elegy;
							CarInfo[tmpcar][carsspoiler]    =spoiler_xflow_elegy;
							CarInfo[tmpcar][carsroof]       =roof_xflow_elegy;
							CarInfo[tmpcar][carsexhaust]    =exhaust_xflow_elegy;
							CarInfo[tmpcar][carswheels]     =wheels_cutter;
							AddVehicleComponent(tmpcar, fbumper_xflow_elegy);
							AddVehicleComponent(tmpcar, rbumper_xflow_elegy);
							AddVehicleComponent(tmpcar, lskirt_xflow_elegy);
							AddVehicleComponent(tmpcar, rskirt_xflow_elegy);
							AddVehicleComponent(tmpcar, spoiler_xflow_elegy);
							AddVehicleComponent(tmpcar, roof_xflow_elegy);
							AddVehicleComponent(tmpcar, exhaust_xflow_elegy);
							AddVehicleComponent(tmpcar, wheels_cutter);
							SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 565) //Flash
						{
							CarInfo[tmpcar][carsfbumper]    =fbumper_xflow_flash;
							CarInfo[tmpcar][carsrbumper]    =rbumper_xflow_flash;
							CarInfo[tmpcar][carslskirt]     =lskirt_xflow_flash;
							CarInfo[tmpcar][carsrskirt]     =rskirt_xflow_flash;
							CarInfo[tmpcar][carsspoiler]    =spoiler_xflow_flash;
							CarInfo[tmpcar][carsroof]       =roof_xflow_flash;
							CarInfo[tmpcar][carsexhaust]    =exhaust_xflow_flash;
							CarInfo[tmpcar][carswheels]     =wheels_cutter;
							AddVehicleComponent(tmpcar, fbumper_xflow_flash);
							AddVehicleComponent(tmpcar, rbumper_xflow_flash);
							AddVehicleComponent(tmpcar, lskirt_xflow_flash);
							AddVehicleComponent(tmpcar, rskirt_xflow_flash);
							AddVehicleComponent(tmpcar, spoiler_xflow_flash);
							AddVehicleComponent(tmpcar, roof_xflow_flash);
							AddVehicleComponent(tmpcar, exhaust_xflow_flash);
							AddVehicleComponent(tmpcar, wheels_cutter);
							SaveCar(tmpcar);
						    return 1;
						}
					}
			        if(strcmp(tmppart, "rally", true) ==0)
			        {
						if(CarInfo[tmpcar][carsmodel] == 558) //Uranus
						{
							CarInfo[tmpcar][carsfbumper]    =fbumper_alien_uranus;
							CarInfo[tmpcar][carsrbumper]    =rbumper_xflow_uranus;
							CarInfo[tmpcar][carslskirt]     =lskirt_xflow_uranus;
							CarInfo[tmpcar][carsrskirt]     =rskirt_xflow_uranus;
							CarInfo[tmpcar][carsspoiler]    =spoiler_xflow_uranus;
							CarInfo[tmpcar][carsroof]       =roof_xflow_uranus;
							CarInfo[tmpcar][carsexhaust]    =exhaust_xflow_uranus;
							CarInfo[tmpcar][carswheels]     =wheels_offroad;
							CarInfo[tmpcar][carshydros]     =hydralics;
							AddVehicleComponent(tmpcar, fbumper_alien_uranus);
							AddVehicleComponent(tmpcar, rbumper_alien_uranus);
							AddVehicleComponent(tmpcar, lskirt_alien_uranus);
							AddVehicleComponent(tmpcar, rskirt_alien_uranus);
							AddVehicleComponent(tmpcar, spoiler_alien_uranus);
							AddVehicleComponent(tmpcar, roof_alien_uranus);
							AddVehicleComponent(tmpcar, exhaust_alien_uranus);
							AddVehicleComponent(tmpcar, wheels_offroad);
							AddVehicleComponent(tmpcar, hydralics);
							SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 559) //Jester
						{
							CarInfo[tmpcar][carsfbumper]    =fbumper_alien_jester;
							CarInfo[tmpcar][carsrbumper]    =rbumper_xflow_jester;
							CarInfo[tmpcar][carslskirt]     =lskirt_xflow_jester;
							CarInfo[tmpcar][carsrskirt]     =rskirt_xflow_jester;
							CarInfo[tmpcar][carsspoiler]    =spoiler_xflow_jester;
							CarInfo[tmpcar][carsroof]       =roof_xflow_jester;
							CarInfo[tmpcar][carsexhaust]    =exhaust_xflow_jester;
							CarInfo[tmpcar][carswheels]     =wheels_offroad;
							CarInfo[tmpcar][carshydros]     =hydralics;
							AddVehicleComponent(tmpcar, fbumper_alien_jester);
							AddVehicleComponent(tmpcar, rbumper_xflow_jester);
							AddVehicleComponent(tmpcar, lskirt_xflow_jester);
							AddVehicleComponent(tmpcar, rskirt_xflow_jester);
							AddVehicleComponent(tmpcar, spoiler_xflow_jester);
							AddVehicleComponent(tmpcar, roof_xflow_jester);
							AddVehicleComponent(tmpcar, exhaust_xflow_jester);
							AddVehicleComponent(tmpcar, wheels_offroad);
							AddVehicleComponent(tmpcar, hydralics);
							SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 560) //Sultan
						{
							CarInfo[tmpcar][carsfbumper]    =fbumper_alien_sultan;
							CarInfo[tmpcar][carsrbumper]    =rbumper_xflow_sultan;
							CarInfo[tmpcar][carslskirt]     =lskirt_xflow_sultan;
							CarInfo[tmpcar][carsrskirt]     =rskirt_xflow_sultan;
							CarInfo[tmpcar][carsspoiler]    =spoiler_xflow_sultan;
							CarInfo[tmpcar][carsroof]       =roof_xflow_sultan;
							CarInfo[tmpcar][carsexhaust]    =exhaust_xflow_sultan;
							CarInfo[tmpcar][carswheels]     =wheels_offroad;
							CarInfo[tmpcar][carshydros]     =hydralics;
							AddVehicleComponent(tmpcar, fbumper_alien_sultan);
							AddVehicleComponent(tmpcar, rbumper_xflow_sultan);
							AddVehicleComponent(tmpcar, lskirt_xflow_sultan);
							AddVehicleComponent(tmpcar, rskirt_xflow_sultan);
							AddVehicleComponent(tmpcar, spoiler_xflow_sultan);
							AddVehicleComponent(tmpcar, roof_xflow_sultan);
							AddVehicleComponent(tmpcar, exhaust_xflow_sultan);
							AddVehicleComponent(tmpcar, wheels_offroad);
							AddVehicleComponent(tmpcar, hydralics);
							SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 561) //Stratum
						{
							CarInfo[tmpcar][carsfbumper]    =fbumper_alien_stratum;
							CarInfo[tmpcar][carsrbumper]    =rbumper_xflow_stratum;
							CarInfo[tmpcar][carslskirt]     =lskirt_xflow_stratum;
							CarInfo[tmpcar][carsrskirt]     =rskirt_xflow_stratum;
							CarInfo[tmpcar][carsspoiler]    =spoiler_xflow_stratum;
							CarInfo[tmpcar][carsroof]       =roof_xflow_stratum;
							CarInfo[tmpcar][carsexhaust]    =exhaust_xflow_stratum;
							CarInfo[tmpcar][carswheels]     =wheels_offroad;
							CarInfo[tmpcar][carshydros]     =hydralics;
							AddVehicleComponent(tmpcar, fbumper_alien_stratum);
							AddVehicleComponent(tmpcar, rbumper_xflow_stratum);
							AddVehicleComponent(tmpcar, lskirt_xflow_stratum);
							AddVehicleComponent(tmpcar, rskirt_xflow_stratum);
							AddVehicleComponent(tmpcar, spoiler_xflow_stratum);
							AddVehicleComponent(tmpcar, roof_xflow_stratum);
							AddVehicleComponent(tmpcar, exhaust_xflow_stratum);
							AddVehicleComponent(tmpcar, wheels_offroad);
							AddVehicleComponent(tmpcar, hydralics);
							SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 562) //Elegy
						{
							CarInfo[tmpcar][carsfbumper]    =fbumper_alien_elegy;
							CarInfo[tmpcar][carsrbumper]    =rbumper_xflow_elegy;
							CarInfo[tmpcar][carslskirt]     =lskirt_xflow_elegy;
							CarInfo[tmpcar][carsrskirt]     =rskirt_xflow_elegy;
							CarInfo[tmpcar][carsspoiler]    =spoiler_xflow_elegy;
							CarInfo[tmpcar][carsroof]       =roof_xflow_elegy;
							CarInfo[tmpcar][carsexhaust]    =exhaust_xflow_elegy;
							CarInfo[tmpcar][carswheels]     =wheels_offroad;
							CarInfo[tmpcar][carshydros]     =hydralics;
							AddVehicleComponent(tmpcar, fbumper_alien_elegy);
							AddVehicleComponent(tmpcar, rbumper_xflow_elegy);
							AddVehicleComponent(tmpcar, lskirt_xflow_elegy);
							AddVehicleComponent(tmpcar, rskirt_xflow_elegy);
							AddVehicleComponent(tmpcar, spoiler_xflow_elegy);
							AddVehicleComponent(tmpcar, roof_xflow_elegy);
							AddVehicleComponent(tmpcar, exhaust_xflow_elegy);
							AddVehicleComponent(tmpcar, wheels_offroad);
							AddVehicleComponent(tmpcar, hydralics);
							SaveCar(tmpcar);
						    return 1;
						}
						if(CarInfo[tmpcar][carsmodel] == 565) //Flash
						{
							CarInfo[tmpcar][carsfbumper]    =fbumper_alien_flash;
							CarInfo[tmpcar][carsrbumper]    =rbumper_xflow_flash;
							CarInfo[tmpcar][carslskirt]     =lskirt_xflow_flash;
							CarInfo[tmpcar][carsrskirt]     =rskirt_xflow_flash;
							CarInfo[tmpcar][carsspoiler]    =spoiler_xflow_flash;
							CarInfo[tmpcar][carsroof]       =roof_xflow_flash;
							CarInfo[tmpcar][carsexhaust]    =exhaust_xflow_flash;
							CarInfo[tmpcar][carswheels]     =wheels_offroad;
							CarInfo[tmpcar][carshydros]     =hydralics;
							AddVehicleComponent(tmpcar, fbumper_alien_flash);
							AddVehicleComponent(tmpcar, rbumper_xflow_flash);
							AddVehicleComponent(tmpcar, lskirt_xflow_flash);
							AddVehicleComponent(tmpcar, rskirt_xflow_flash);
							AddVehicleComponent(tmpcar, spoiler_xflow_flash);
							AddVehicleComponent(tmpcar, roof_xflow_flash);
							AddVehicleComponent(tmpcar, exhaust_xflow_flash);
							AddVehicleComponent(tmpcar, wheels_offroad);
							AddVehicleComponent(tmpcar, hydralics);
							SaveCar(tmpcar);
						    return 1;
						}
			        }
			        if(strcmp(tmppart, "remove", true) ==0)
			        {
						CarInfo[tmpcar][carsfbumper]    = 0;
						CarInfo[tmpcar][carsrbumper]    = 0;
						CarInfo[tmpcar][carslskirt]     = 0;
						CarInfo[tmpcar][carsrskirt]     = 0;
						CarInfo[tmpcar][carsspoiler]    = 0;
						CarInfo[tmpcar][carsroof]       = 0;
						CarInfo[tmpcar][carsexhaust]    = 0;
						CarInfo[tmpcar][carswheels]     = 0;
						CarInfo[tmpcar][carshydros]     = 0;
						SaveCar(tmpcar);
						return 1;
					}
					else
					{
					    SendClientMessage(playerid, color_lred, "Server_Error: invalid part name.");
					    return 1;
					}
			    }
			}
			if(strcmp(tmpcmd, "", true) == 0)
			{
			    SendClientMessage(playerid, color_lred, "Server_Error: invalid part type.");
			    return 1;
			}
        }
        else
        {
		    SendClientMessage(playerid, color_lred, "Server_Status: admin check failed");
		    return 1;
        }
        return 1;
	}
	return 0;
}
