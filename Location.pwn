/*==============================================================================

				Location Filterscript By LethaL
					(update)
==============================================================================*/

#include <a_samp>
#include <zones>
#include <file>

#define blue2 0x2641FEAA
#define red 0xFF0000AA
#define green 0x33FF33AA

new LocationTimer[MAX_PLAYERS];
new LocationStatus[MAX_PLAYERS];

new zoneupdates[MAX_PLAYERS];
new player_zone[MAX_PLAYERS];

new zareaupdates[MAX_PLAYERS];
new player_zarea[MAX_PLAYERS];

//Menu
new Menu:XTele, Menu:LasVenturasMenu, Menu:LosSantosMenu, Menu:SanFierroMenu,
Menu:DesertMenu, Menu:FlintMenu, Menu:MountChiliadMenu, Menu:InteriorsMenu;

// Timers
new ZoneTimer;
new AreaTimer;

// textdraw
new Text:LocationText[MAX_PLAYERS];

new VehNames[212][] = {
"Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster",
"Stretch","Manana","Infernus","Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto",
"Taxi","Washington","Bobcat","Mr Whoopee","BF Injection","Hunter","Premier","Enforcer","Securicar","Banshee",
"Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie","Stallion","Rumpo",
"RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer",
"Turismo","Speeder","Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer",
"PCJ-600","Faggio","Freeway","RC Baron","RC Raider","Glendale","Oceanic","Sanchez","Sparrow","Patriot",
"Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina","Comet","BMX",
"Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo",
"Greenwood","Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa",
"RC Goblin","Hotring Racer A","Hotring Racer B","Bloodring Banger","Rancher","Super GT","Elegant",
"Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain","Nebula","Majestic",
"Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona",
"FBI Truck","Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight",
"Streak","Vortex","Vincent","Bullet","Clover","Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob",
"Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A","Monster B","Uranus",
"Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight",
"Trailer","Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford",
"BF-400","Newsvan","Tug","Trailer A","Emperor","Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C",
"Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)","Police Car (LVPD)","Police Ranger",
"Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
"Stair Trailer","Boxville","Farm Plow","Utility Trailer" };

forward CoordinateUpdate(playerid);
forward update_zarea ();
forward update_zones();

//==============================================================================

public OnFilterScriptInit()
{
	XTele = CreateMenu("Teleports", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(XTele, 0, "Teleport to where?");
	AddMenuItem(XTele, 0, "Las Venturas");//0
	AddMenuItem(XTele, 0, "Los Santos");//1
	AddMenuItem(XTele, 0, "San Fierro");//2
	AddMenuItem(XTele, 0, "The Desert");//3
	AddMenuItem(XTele, 0, "Flint Country");//4
	AddMenuItem(XTele, 0, "Mount Chiliad");//5
	AddMenuItem(XTele, 0, "Interiors");//6
	AddMenuItem(XTele, 0, "Exit");//8

	LasVenturasMenu = CreateMenu("Las Venturas", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(LasVenturasMenu, 0, "Teleport to where?");
	AddMenuItem(LasVenturasMenu, 0, "The Strip");//0
	AddMenuItem(LasVenturasMenu, 0, "Come-A-Lot");//1
	AddMenuItem(LasVenturasMenu, 0, "LV Airport");//2
	AddMenuItem(LasVenturasMenu, 0, "KACC Military Fuels");//3
	AddMenuItem(LasVenturasMenu, 0, "Yellow Bell Golf Club");//4
	AddMenuItem(LasVenturasMenu, 0, "Baseball Pitch");//5
	AddMenuItem(LasVenturasMenu, 0, "Return");//6

	LosSantosMenu = CreateMenu("Los Santos", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(LosSantosMenu, 0, "Teleport to where?");
	AddMenuItem(LosSantosMenu, 0, "Ganton");//0
	AddMenuItem(LosSantosMenu, 0, "LS Airport");//1
	AddMenuItem(LosSantosMenu, 0, "Ocean Docks");//2
	AddMenuItem(LosSantosMenu, 0, "Pershing Square");//3
	AddMenuItem(LosSantosMenu, 0, "Verdant Bluffs");//4
	AddMenuItem(LosSantosMenu, 0, "Santa Maria Beach");//5
	AddMenuItem(LosSantosMenu, 0, "Mulholland");//6
	AddMenuItem(LosSantosMenu, 0, "Richman");//7
	AddMenuItem(LosSantosMenu, 0, "Return");//8

	SanFierroMenu = CreateMenu("San Fierro", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(SanFierroMenu, 0, "Teleport to where?");
	AddMenuItem(SanFierroMenu, 0, "SF Station");//0
	AddMenuItem(SanFierroMenu, 0, "SF Airport");//1
	AddMenuItem(SanFierroMenu, 0, "Ocean Flats");//2
	AddMenuItem(SanFierroMenu, 0, "Avispa Country Club");//3
	AddMenuItem(SanFierroMenu, 0, "Easter Basin (docks)");//4
	AddMenuItem(SanFierroMenu, 0, "Esplanade North");//5
	AddMenuItem(SanFierroMenu, 0, "Battery Point");//6
	AddMenuItem(SanFierroMenu, 0, "Return");//7

	DesertMenu = CreateMenu("The Desert", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(DesertMenu, 0, "Teleport to where?");
	AddMenuItem(DesertMenu, 0, "Aircraft Graveyard");//0
	AddMenuItem(DesertMenu, 0, "Area 51");//1
	AddMenuItem(DesertMenu, 0, "The Big Ear");//2
	AddMenuItem(DesertMenu, 0, "The Sherman Dam");//3
	AddMenuItem(DesertMenu, 0, "Las Barrancas");//4
	AddMenuItem(DesertMenu, 0, "El Quebrados");//5
	AddMenuItem(DesertMenu, 0, "Octane Springs");//6
	AddMenuItem(DesertMenu, 0, "Return");//7

	FlintMenu = CreateMenu("Flint Country", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(FlintMenu, 0, "Teleport to where?");
	AddMenuItem(FlintMenu, 0, "The Lake");//0
	AddMenuItem(FlintMenu, 0, "Leafy Hollow");//1
	AddMenuItem(FlintMenu, 0, "The Farm");//2
	AddMenuItem(FlintMenu, 0, "Shady Cabin");//3
	AddMenuItem(FlintMenu, 0, "Flint Range");//4
	AddMenuItem(FlintMenu, 0, "Becon Hill");//5
	AddMenuItem(FlintMenu, 0, "Fallen Tree");//6
	AddMenuItem(FlintMenu, 0, "Return");//7

	MountChiliadMenu = CreateMenu("Mount Chiliad", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(MountChiliadMenu, 0, "Teleport to where?");
	AddMenuItem(MountChiliadMenu, 0, "Chiliad Jump");//0
	AddMenuItem(MountChiliadMenu, 0, "Bottom Of Chiliad");//1
	AddMenuItem(MountChiliadMenu, 0, "Highest Point");//2
	AddMenuItem(MountChiliadMenu, 0, "Chiliad Path");//3
	AddMenuItem(MountChiliadMenu, 0, "Return");//7

	InteriorsMenu = CreateMenu("Interiors", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(InteriorsMenu, 0, "Teleport to where?");
	AddMenuItem(InteriorsMenu, 0, "Planning Department");//0
	AddMenuItem(InteriorsMenu, 0, "LV PD");//1
	AddMenuItem(InteriorsMenu, 0, "Pizza Stack");//2
	AddMenuItem(InteriorsMenu, 0, "RC Battlefield");//3
	AddMenuItem(InteriorsMenu, 0, "Caligula's Casino");//4
	AddMenuItem(InteriorsMenu, 0, "Big Smoke's Crack Palace");//5
	AddMenuItem(InteriorsMenu, 0, "Madd Dogg's Mansion");//6
	AddMenuItem(InteriorsMenu, 0, "Dirtbike Stadium");//7
	AddMenuItem(InteriorsMenu, 0, "Vice Stadium (duel)");//8
	AddMenuItem(InteriorsMenu, 0, "Ammu-nation");//9
	AddMenuItem(InteriorsMenu, 0, "Atrium");//7
	AddMenuItem(InteriorsMenu, 0, "Return");//8

	ZoneTimer = SetTimer("update_zones",1000,true);
	AreaTimer = SetTimer("update_zarea",1000,true);
	
	for( new i; i<MAX_PLAYERS; i++ ) if(IsPlayerConnected(i)) LocationStatus[i] = 0;
	
	if(!fexist("savedpositions.txt"))
	{
		new File:SavePosFile, string[256];		SavePosFile = fopen("savedpositions.txt",io_append);
		format(string,sizeof(string),"		Saved Positions\r\n");
		fwrite(SavePosFile,string);
		format(string,sizeof(string),"   X        Y      Z      Angle   Interior   World\r\n");
		fwrite(SavePosFile,string);
		fclose(SavePosFile);
	    print("===================================================");
	    print("The File Saved Positions Was Successfully Created");
	    print("===================================================");
	}

	print("\n\nLocation / Coordinate Filterscript Loaded\n__________________________________________________\n                                        By LethaL\n" );
}

public OnFilterScriptExit()
{
	for( new i; i<MAX_PLAYERS; i++ ) if(LocationTimer[i]) KillTimer(LocationTimer[i]);
	for( new i; i<MAX_PLAYERS; i++ ) if(LocationStatus[i] == 1) TextDrawHideForPlayer(i, LocationText[i]);
	
	KillTimer(ZoneTimer);
	KillTimer(AreaTimer);
	
	DestroyMenu(XTele);
	DestroyMenu(LasVenturasMenu);
	DestroyMenu(LosSantosMenu);
	DestroyMenu(SanFierroMenu);
	DestroyMenu(DesertMenu);
	DestroyMenu(FlintMenu);
	DestroyMenu(MountChiliadMenu);
	DestroyMenu(InteriorsMenu);
	print("\n\nLocation / Coordinate Filterscript Unloaded\n__________________________________________________\n                                        By LethaL\n" );

}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256], string[256], idx;
	cmd = strtok(cmdtext, idx);

	if(!strcmp(cmdtext, "/locationhelp", true))
	return SendClientMessage(playerid, blue2, "/location (type again to disable), /telemenu, /savepos, /saveVpos");

	if(strcmp(cmd,"/location",true) == 0)
	{
	    if(IsPlayerAdmin(playerid))
		{
			new tmp[256];
			tmp = strtok(cmdtext, idx);
			
		    if(!strlen(tmp))
		    {
  			    if(LocationStatus[playerid] == 0)
			    {
			       	format(string, sizeof(string), "Starting");
					LocationText[playerid] = TextDrawCreate(2.000000,430.000000,string);
					TextDrawBackgroundColor(LocationText[playerid],0x000000ff);
					TextDrawColor(LocationText[playerid],0xff0000cc);
					TextDrawTextSize(LocationText[playerid],642.000000,45.000000);
					TextDrawUseBox(LocationText[playerid],1);
					TextDrawBoxColor(LocationText[playerid],0x00000066);
					TextDrawSetOutline(LocationText[playerid],1);
					TextDrawSetShadow(LocationText[playerid],1);
					TextDrawShowForPlayer(playerid, LocationText[playerid]);
			    	LocationTimer[playerid] = SetTimerEx("CoordinateUpdate", 250, 1, "i", playerid);
			    	LocationStatus[playerid] = 1;
			    	SendClientMessage(playerid, green, "Location Text Started");
				}
				else
				{
			    	KillTimer(LocationTimer[playerid]);
					LocationStatus[playerid] = 0;
					TextDrawHideForPlayer(playerid, LocationText[playerid]);
					TextDrawDestroy(LocationText[playerid]);
			    	SendClientMessage(playerid, red, "Location Text Stopped");
				}
			}
			else
			{
				new player1, playername[MAX_PLAYER_NAME], current_zone, current_area, Float:LPos[MAX_PLAYERS][3];

				player1 = strval(tmp);
				if(!IsPlayerConnected(player1) || player1 == INVALID_PLAYER_ID)
				return SendClientMessage(playerid,red,"ERROR: Player is not connected");
				tmp = strtok(cmdtext, idx);

			    current_zone = player_zone[player1];	current_area = player_zarea[player1];

		    	if(current_zone != -1 && current_area != -1)
				{
				    GetPlayerName(player1, playername,sizeof(playername) ); GetPlayerPos(player1, LPos[player1][0], LPos[player1][1], LPos[player1][2] );
				    format(string,sizeof(string),"%s's Position: %s, %s  [%0.2f | %0.2f | %0.2f | Int:%d | VW:%d]",playername,zones[current_zone][zone_name],zarea[current_area][zarea_name],LPos[player1][0],LPos[player1][1],LPos[player1][2], GetPlayerInterior(player1), GetPlayerVirtualWorld(player1) );
				    SendClientMessage(playerid,blue2,string);
				}
				else
				{
				    SendClientMessage(playerid,red,"Player hasnt spawned yet");
				}
			}
		}
		else
		{
		    SendClientMessage(playerid, red, "This commands is for administrators only");
		}
		return 1;
	}
	

	if(!strcmp(cmdtext, "/telemenu", true))
	{
		if(IsPlayerAdmin(playerid))
		{
			if(IsPlayerInAnyVehicle(playerid)) {
			TogglePlayerControllable(playerid,false);
			return ShowMenuForPlayer(XTele,playerid);
			}
			else return ShowMenuForPlayer(XTele,playerid);
		}
		else return SendClientMessage(playerid, red, "This commands is for administrators only");
	}
	

	if(strcmp(cmd, "/savepos", true) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
			new Float:PosA[4];
			if(IsPlayerInAnyVehicle(playerid))
			{
			    GetVehiclePos( GetPlayerVehicleID(playerid), PosA[0],PosA[1],PosA[2]);
			    GetVehicleZAngle( GetPlayerVehicleID(playerid), PosA[3]);
			}
			else
			{
				GetPlayerPos(playerid,PosA[0],PosA[1],PosA[2]);
				GetPlayerFacingAngle(playerid,PosA[3]);
			}
			new File:SavePosFile;
			SavePosFile = fopen("savedpositions.txt",io_append);
			format(string,sizeof(string),"%0.2f, %0.2f, %0.2f,  %0.2f  (int:%d, world:%d)   //%s\r\n",Float:PosA[0],Float:PosA[1],Float:PosA[2], Float:PosA[3], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), cmdtext[8]);
			fwrite(SavePosFile,string);
			fclose(SavePosFile);

			GameTextForPlayer(playerid,"Saved",1000,6);
			PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		}
		else
		{
			SendClientMessage(playerid,red,"This commands is for administrators only");
		}
		return 1;
	}

	if(strcmp(cmd, "/savevpos", true) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
			new Float:PosA[4];
			if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,red,"You must be in a vehicle to save its position");

		    GetVehiclePos( GetPlayerVehicleID(playerid), PosA[0],PosA[1],PosA[2]);
		    GetVehicleZAngle( GetPlayerVehicleID(playerid), PosA[3]);

			format(string,sizeof(string),"CreateVehicle(%d, %0.2f, %0.2f, %0.2f, %0.2f, -1, -1, 60000); // (int:%d, world:%d) %s - %s\r\n",GetPlayerVehicleID(playerid),
			Float:PosA[0], Float:PosA[1], Float:PosA[2], Float:PosA[3], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), VehNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400], cmdtext[9]);

			new File:SavePosFile;
			SavePosFile = fopen("savedvehiclepositions.txt",io_append);
			fwrite(SavePosFile,string);
			fclose(SavePosFile);

			GameTextForPlayer(playerid,"Saved",1000,6);
			return PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		}
		else return SendClientMessage(playerid,red,"This commands is for administrators only");
	}


	return 0;
}

public OnPlayerConnect(playerid)
{
	LocationStatus[playerid] = 0;

	zareaupdates[playerid] = 0;
	player_zarea[playerid] = -1;
	zoneupdates[playerid] = 0;
	player_zone[playerid] = -1;
}

public OnPlayerSpawn(playerid)
{
	zareaupdates[playerid] = 1;
	zoneupdates[playerid] = 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	zareaupdates[playerid] = 0;
	zoneupdates[playerid] = 0;
}

public OnPlayerSelectedMenuRow(playerid, row) {
  	new Menu:Current = GetPlayerMenu(playerid);
    if(Current == XTele)
	{
        switch(row)
		{
			case 0: ChangeMenu(playerid,Current,LasVenturasMenu);
			case 1: ChangeMenu(playerid,Current,LosSantosMenu);
			case 2: ChangeMenu(playerid,Current,SanFierroMenu);
			case 3: ChangeMenu(playerid,Current,DesertMenu);
			case 4: ChangeMenu(playerid,Current,FlintMenu);
			case 5: ChangeMenu(playerid,Current,MountChiliadMenu);
			case 6: ChangeMenu(playerid,Current,InteriorsMenu);
			case 7: return HideMenuForPlayer(XTele, playerid);
		}
		return 1;
	}
    if(Current == LasVenturasMenu)
	{
        switch(row)
		{
			case 0: { SetPlayerPos(playerid,2037.0,1343.0,12.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// strip
			case 1: { SetPlayerPos(playerid,2163.0,1121.0,23); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// come a lot
			case 2: { SetPlayerPos(playerid,1688.0,1615.0,12.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// lv airport
			case 3: { SetPlayerPos(playerid,2503.0,2764.0,10.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// military fuel
			case 4: { SetPlayerPos(playerid,1418.0,2733.0,10.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// golf lv
			case 5: { SetPlayerPos(playerid,1377.0,2196.0,9.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// pitch match
			case 6: return ChangeMenu(playerid,Current,XTele);
		}
		return 1;
	}
    if(Current == LosSantosMenu)
	{
        switch(row)
		{
			case 0: { SetPlayerPos(playerid,2495.0,-1688.0,13.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// ganton
			case 1: { SetPlayerPos(playerid,1979.0,-2241.0,13.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// ls airport
			case 2: { SetPlayerPos(playerid,2744.0,-2435.0,15.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// docks
			case 3: { SetPlayerPos(playerid,1481.0,-1656.0,14.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// square
			case 4: { SetPlayerPos(playerid,1150.0,-2037.0,69.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// veradant bluffs
			case 5: { SetPlayerPos(playerid,425.0,-1815.0,6.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// santa beach
			case 6: { SetPlayerPos(playerid,1240.0,-744.0,95.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// mullholland
			case 7: { SetPlayerPos(playerid,679.0,-1070.0,49.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// richman
			case 8: return ChangeMenu(playerid,Current,XTele);
		}
		return 1;
	}
    if(Current == SanFierroMenu)
	{
        switch(row)
		{
			case 0: { SetPlayerPos(playerid,-1990.0,137.0,27.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); } // sf station
			case 1: { SetPlayerPos(playerid,-1528.0,-206.0,14.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// sf airport
			case 2: { SetPlayerPos(playerid,-2709.0,198.0,4.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// ocean flats
			case 3: { SetPlayerPos(playerid,-2738.0,-295.0,6.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// avispa country club
			case 4: { SetPlayerPos(playerid,-1457.0,465.0,7.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// easter basic docks
			case 5: { SetPlayerPos(playerid,-1853.0,1404.0,7.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// esplanadae north
			case 6: { SetPlayerPos(playerid,-2620.0,1373.0,7.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// battery point
			case 7: return ChangeMenu(playerid,Current,XTele);
		}
		return 1;
	}
    if(Current == DesertMenu)
	{
        switch(row)
		{
			case 0: { SetPlayerPos(playerid,416.0,2516.0,16.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); } // plane graveyard
			case 1: { SetPlayerPos(playerid,81.0,1920.0,17.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// area51
			case 2: { SetPlayerPos(playerid,-324.0,1516.0,75.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// big ear
			case 3: { SetPlayerPos(playerid,-640.0,2051.0,60.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// dam
			case 4: { SetPlayerPos(playerid,-766.0,1545.0,27.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// las barrancas
			case 5: { SetPlayerPos(playerid,-1514.0,2597.0,55.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// el qyebrados
			case 6: { SetPlayerPos(playerid,442.0,1427.0,9.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// actane springs
			case 7: return ChangeMenu(playerid,Current,XTele);
		}
		return 1;
	}
    if(Current == FlintMenu)
	{
        switch(row)
		{
			case 0: { SetPlayerPos(playerid,-849.0,-1940.0,13.0);  TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// lake
			case 1: { SetPlayerPos(playerid,-1107.0,-1619.0,76.0);  TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// leafy hollow
			case 2: { SetPlayerPos(playerid,-1049.0,-1199.0,128.0);  TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// the farm
			case 3: { SetPlayerPos(playerid,-1655.0,-2219.0,32.0);  TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// shady cabin
			case 4: { SetPlayerPos(playerid,-375.0,-1441.0,25.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// flint range
			case 5: { SetPlayerPos(playerid,-367.0,-1049.0,59.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// beacon hill
			case 6: { SetPlayerPos(playerid,-494.0,-555.0,25.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// fallen tree
			case 7: return ChangeMenu(playerid,Current,XTele);
		}
		return 1;
	}
    if(Current == MountChiliadMenu)
	{
        switch(row)
		{
			case 0: { SetPlayerPos(playerid,-2308.0,-1657.0,483.0);  TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// chiliad jump
			case 1: { SetPlayerPos(playerid,-2331.0,-2180.0,35.0); TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// bottom chiliad
			case 2: { SetPlayerPos(playerid,-2431.0,-1620.0,526.0);  TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// highest point
			case 3: { SetPlayerPos(playerid,-2136.0,-1775.0,208.0);  TogglePlayerControllable(playerid,true); SetPlayerInterior(playerid,0); }// chiliad path
			case 4: return ChangeMenu(playerid,Current,XTele);
		}
		return 1;
	}
    if(Current == InteriorsMenu)
	{
        switch(row)
		{
			case 0: { SetPlayerPos(playerid,386.5259, 173.6381, 1008.3828);	SetPlayerInterior(playerid,3); TogglePlayerControllable(playerid,true);   }
			case 1: { SetPlayerPos(playerid,288.4723, 170.0647, 1007.1794);	SetPlayerInterior(playerid,3); TogglePlayerControllable(playerid,true);   }
			case 2: { SetPlayerPos(playerid,372.5565, -131.3607, 1001.4922); SetPlayerInterior(playerid,5); TogglePlayerControllable(playerid,true);   }
			case 3: { SetPlayerPos(playerid,-1129.8909, 1057.5424, 1346.4141); SetPlayerInterior(playerid,10); TogglePlayerControllable(playerid,true);   }
			case 4: { SetPlayerPos(playerid,2233.9363, 1711.8038, 1011.6312); SetPlayerInterior(playerid,1); TogglePlayerControllable(playerid,true);   }
			case 5: { SetPlayerPos(playerid,2536.5322, -1294.8425, 1044.125); SetPlayerInterior(playerid,2); TogglePlayerControllable(playerid,true);   }
			case 6: { SetPlayerPos(playerid,1267.8407, -776.9587, 1091.9063); SetPlayerInterior(playerid,5); TogglePlayerControllable(playerid,true);   }
  			case 7: { SetPlayerPos(playerid,-1421.5618, -663.8262, 1059.5569); SetPlayerInterior(playerid,4); TogglePlayerControllable(playerid,true);   }
   			case 8: { SetPlayerPos(playerid,-1401.067, 1265.3706, 1039.8672); SetPlayerInterior(playerid,16); TogglePlayerControllable(playerid,true);   }
   			case 9: { SetPlayerPos(playerid,285.8361, -39.0166, 1001.5156);	SetPlayerInterior(playerid,1); TogglePlayerControllable(playerid,true);   }
    		case 10: { SetPlayerPos(playerid,1727.2853, -1642.9451, 20.2254); SetPlayerInterior(playerid,18); TogglePlayerControllable(playerid,true);   }
			case 11: return ChangeMenu(playerid,Current,XTele);
		}
		return 1;
	}
	
	
	return 1;
}


public OnPlayerExitedMenu(playerid)
{
    new Menu:Current = GetPlayerMenu(playerid);
    HideMenuForPlayer(Current,playerid);
    return TogglePlayerControllable(playerid,true);
}

ChangeMenu(playerid,Menu:oldmenu,Menu:newmenu)
{
	if(IsValidMenu(oldmenu))
	HideMenuForPlayer(oldmenu,playerid);
	ShowMenuForPlayer(newmenu,playerid);
	return 1;
}

//==============================================================================

public CoordinateUpdate(playerid)
{
    new Float:X, Float:Y, Float:Z, Float:Angle;
	new str[256];
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, Angle);

	if(IsPlayerInAnyVehicle(playerid))
	{
		new Float:vZAngle, Float:vHealth;
		GetVehicleZAngle(GetPlayerVehicleID(playerid), vZAngle);
		GetVehicleHealth(GetPlayerVehicleID(playerid), vHealth);

	   	format(str, sizeof(str), " %s, Model:%d, ID:%d, Health:%d, X:%0.2f, Y:%0.2f, Z:%0.2f",VehNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400], GetVehicleModel(GetPlayerVehicleID(playerid)),GetPlayerVehicleID(playerid), floatround(vHealth), X, Y, Z);
		TextDrawSetString(LocationText[playerid], str);
	}
	else
	{
	   	format(str, sizeof(str), " Interior:%i, X:%0.2f, Y:%0.2f, Z:%0.2f, Angle:%0.1f, World:%d",GetPlayerInterior(playerid), X, Y, Z, Angle, GetPlayerVirtualWorld(playerid) );
		TextDrawSetString(LocationText[playerid], str);
	}
}

//==============================================================================
public update_zones()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && zoneupdates[i] == 1)
		{
   			if(IsPlayerInZone(i,player_zone[i]))
  			{
		  	}
			else
		   	{
    			new player_zone_before;
    			player_zone_before = player_zone[i];
    			player_zone[i] = -1;

    			for(new j=0; j<sizeof(zones);j++)
				{
     				if(IsPlayerInZone(i,j) && player_zone[i] == -1)
			 		{
      					player_zone[i] = j;
     				}
    			}
    			if(player_zone[i] == -1) player_zone[i] = player_zone_before;
   			}
  		}
 	}
}

//==============================================================================
IsPlayerInZone(playerid, zoneid)
{
	if(zoneid == -1) return 0;
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid,x,y,z);
	if(x >= zones[zoneid][zone_minx] && x < zones[zoneid][zone_maxx]
	&& y >= zones[zoneid][zone_miny] && y < zones[zoneid][zone_maxy]
	&& z >= zones[zoneid][zone_minz] && z < zones[zoneid][zone_maxz]
	&& z < 900.0) return 1;
	return 0;
}

//==============================================================================
public update_zarea()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && zareaupdates[i] == 1)
		{
			if(IsPlayerInzarea(i,player_zarea[i]))
			{
		    }
		    else
			{
	    		new player_zarea_before;
			    player_zarea_before = player_zarea[i];
			    player_zarea[i] = -1;


		    	for(new j=0; j<sizeof(zarea);j++)
		    	{
				    if(IsPlayerInzarea(i,j) && player_zarea[i] == -1)
					{
				    player_zarea[i] = j;
					}
    			}
			    if(player_zarea[i] == -1) player_zarea[i] = player_zarea_before;
			}
		}
	}
}

//==============================================================================
IsPlayerInzarea(playerid, zareaid)
{
	if(zareaid == -1) return 0;
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid,x,y,z);
	if(x >= zarea[zareaid][zarea_minx] && x < zarea[zareaid][zarea_maxx]
	&& y >= zarea[zareaid][zarea_miny] && y < zarea[zareaid][zarea_maxy]
	&& z >= zarea[zareaid][zarea_minz] && z < zarea[zareaid][zarea_maxz]
	&& z < 900.0) return 1;
	return 0;
}
//==============================================================================

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
//==============================================================================
//                      		EOF                                           //
