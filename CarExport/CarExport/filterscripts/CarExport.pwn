#include <a_samp>
#include <dini>
#pragma unused strtok


//General
new UseCustomVehicles = 0; //If '1' Only the vehicles which are created with AddExportVehicle will be used for this game.
						   //Else if '0' All vehicles in the server will be used.
new SaveSettingsInFile = 1;   //If you want to save the settings in a file, set it to '1', else set it to '0'
#define SaveFile "CarExportSettings.cfg"   //This is the name of the file where the settings will get saved in.

//Winner-prize
new MinCarValue = 5000;
new MaxCarValue = 15000;

//GameTime
new GameFrequency = 120;  //How many seconds after the last game has finished, the next game should start?
new RoundTime = 600;  //Players have (default) 600 seconds (10 minutes) to take the export-car to the export-place.

//Export-Location
new Float:ExportX = -1917.4036;      //
new Float:ExportY = 286.3559;        // Default Export Location:  Behind WangCars
new Float:ExportZ = 41.0469;         //
new Checkpointsize = 5;

//Colors
#define COLOR_RED 0xFF0000AA
#define COLOR_GREEN 0x00FF00AA
#define COLOR_BLUE 0x0000FFAA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_ORANGE 0xFFA500AA


new IsGameStarted;
new ExportVehicle;
new ExportVehicleValue;
new GameTimeLeft;
new RoundTimer;
new PlayerInExportVehicle;

new Max_Players;
new Float:CarX, Float:CarY, Float:CarZ, Float:CarA;

new Menu:MainMenu;
new Menu:MinValueMenu;
new Menu:MaxValueMenu;
new Menu:FrequencyMenu;
new Menu:RoundTimeMenu;
new Menu:LocationMenu;
new Menu:CheckpointsizeMenu;
new Menu:StartNewGameMenu;
new IsExportVehicle[MAX_VEHICLES];
new CanPlay = 1;
new PlayerVehicle[MAX_PLAYERS];

//In the list here below, you can add/remove vehiclemodels which can be used in this game.
new ExportableVehicles[][0] =
{
    //===============Convertibles
	480, //Comet
	533, //Feltzer
	439, //Stallion
	555, //Windsor
	//===============Industrial
	499, //Benson
	422, //Bobcat
	482, //Burrito
	498, //Boxville
	609, //Boxburg
	524, //Cement Truck
	578, //DFT-30
	455, //Flatbed
	403, //Linerunner
	414, //Mule
	582, //Newsvan
	514, //Petrol Tanker
	413, //Pony
	515, //Roadtrain
	440, //Rumpo
	543, //Sadler
	605, //Sadler Shit
	459, //Topfun
	531, //Tractor
	408, //Trashmaster
	552, //Utility Van
	478, //Walton
 	456, //Yankee
 	554, //Yosemite
    //===============Lowriders
    536, //Blade
    575, //Broadway
    534, //Remington
    567, //Savanna
    535, //Slamvan
    566, //Tahoma
    576, //Tornado
    412, //Voodoo
    //===============Off Road
    568, //Bandito
    424, //BF Injection
    573, //Dune
    579, //Huntley
    400, //Landstalker
    500, //Mesa
    444, //Monster
    556, //Monster "A"
    557, //Monster "B"
    470, //Patriot
    489, //Rancher
    505, //Rancher
    495, //Sandking
    //===============Public Service Vehicles
    416, //Ambulance
    433, //Barracks
    431, //Bus
    438, //Cabbie
    437, //Coach
    523, //Cop Bike HPV1000
    427, //Enforcer
    490, //FBI Rancher
    528, //FBI Truck
    407, //Firetruck (Without Ladder)
    544, //Firetruck (With Ladder)
    596, //Police Car (LSPD)
    597, //Police Car (SFPD)
    598, //Police Car (LVPD)
    599, //Ranger
    432, //Rhino
    601, //S.W.A.T.
    420, //Taxi
    //===============Saloons
    445, //Admiral
    504, //Bloodring Banger
    401, //Bravura
    518, //Buccaneer
    527, //Cadrona
    542, //Clover
    507, //Elegant
    562, //Elegy
    585, //Emperor
    419, //Esperanto
    526, //Fortune
    604, //Glendale Shit
    466, //Glendale
    492, //Greenwood
    474, //Hermes
	546, //Intruder
	517, //Majestic
	410, //Manana
	551, //Merit
	516, //Nebula
	467, //Oceanic
	600, //Picador
	426, //Premier
	436, //Previon
	547, //Primo
	405, //Sentinel
	580, //Stafford
	560, //Sultan
	550, //Sunrise
	549, //Tampa
	540, //Vincent
	491, //Virgo
	529, //Willard
    421, //Washington
    //===============Sport Vehicles
    602, //Alpha
    429, //Banshee
    496, //Blista Compact
    402, //Buffalo
    541, //Bullet
    415, //Cheetah
    589, //Club
    587, //Euros
    565, //Flash
    494, //Hotring Racer
    502, //Hotring Racer
    503, //Horring Racer
    411, //Infernus
    559, //Jester
    603, //Phoenix
    475, //Sabre
    506, //Super GT
	541, //Turismo
	558, //Uranus
	477, //ZR-350
	//===============Station Wagons
	418, //Moonbeam
	404, //Perenniel
	479, //Regina
	458, //Solair
	561, //Stratum
	//===============Other Vehicles
	485, //Baggage
	457, //Caddy
	483, //Camper (Volkswagon)
	508, //Camper
	434, //Hotknife
	545, //Hustler
	588, //Hotdog
	423, //Mr Whoopee
	442, //Romero
	428, //Securicar
	409, //Stretch
	525, //Towtruck
	583 //Tug
};

new VehNames[212][] =
{
   "Landstalker", "Bravura",   "Buffalo",   "Linerunner",   "Pereniel",   "Sentinel",   "Dumper",   "Firetruck",   "Trashmaster",   "Stretch",
   "Manana",   "Infernus",   "Voodoo",   "Pony",   "Mule",   "Cheetah",   "Ambulance",   "Leviathan",   "Moonbeam",   "Esperanto",   "Taxi",
   "Washington",   "Bobcat",   "Mr Whoopee",   "BF Injection",   "Hunter",   "Premier",   "Enforcer",   "Securicar",   "Banshee",   "Predator",
   "Bus",   "Rhino",   "Barracks",   "Hotknife",   "Trailer",   "Previon",   "Coach",   "Cabbie",   "Stallion",   "Rumpo",   "RC Bandit",  "Romero",
   "Packer",   "Monster",   "Admiral",   "Squalo",   "Seasparrow",   "Pizzaboy",   "Tram",   "Trailer",   "Turismo",   "Speeder",   "Reefer",   "Tropic",   "Flatbed",
   "Yankee",   "Caddy",   "Solair",   "Berkley's RC Van",   "Skimmer",   "PCJ-600",   "Faggio",   "Freeway",   "RC Baron",   "RC Raider",
   "Glendale",   "Oceanic",   "Sanchez",   "Sparrow",   "Patriot",   "Quad",   "Coastguard",   "Dinghy",   "Hermes",   "Sabre",   "Rustler",
   "ZR3 50",   "Walton",   "Regina",   "Comet",   "BMX",   "Burrito",   "Camper",   "Marquis",   "Baggage",   "Dozer",   "Maverick",   "News Chopper",
   "Rancher",   "FBI Rancher",   "Virgo",   "Greenwood",   "Jetmax",   "Hotring",   "Sandking",   "Blista Compact",   "Police Maverick",
   "Boxville",   "Benson",   "Mesa",   "RC Goblin",   "Hotring Racer",   "Hotring Racer",   "Bloodring Banger",   "Rancher",   "Super GT",
   "Elegant",   "Journey",   "Bike",   "Mountain Bike",   "Beagle",   "Cropdust",   "Stunt",   "Tanker",   "RoadTrain",   "Nebula",   "Majestic",
   "Buccaneer",   "Shamal",   "Hydra",   "FCR-900",   "NRG-500",   "HPV1000",   "Cement Truck",   "Tow Truck",   "Fortune",   "Cadrona",   "FBI Truck",
   "Willard",   "Forklift",   "Tractor",   "Combine",   "Feltzer",   "Remington",   "Slamvan",   "Blade",   "Freight",   "Streak",   "Vortex",   "Vincent",
   "Bullet",   "Clover",   "Sadler",   "Firetruck",   "Hustler",   "Intruder",   "Primo",   "Cargobob",   "Tampa",   "Sunrise",   "Merit",   "Utility",
   "Nevada",   "Yosemite",   "Windsor",   "Monster",   "Monster",   "Uranus",   "Jester",   "Sultan",   "Stratum",   "Elegy",   "Raindance",   "RC Tiger",
   "Flash",   "Tahoma",   "Savanna",   "Bandito",   "Freight",   "Trailer",   "Kart",   "Mower",   "Duneride",   "Sweeper",   "Broadway",
   "Tornado",   "AT-400",   "DFT-30",   "Huntley",   "Stafford",   "BF-400",   "Newsvan",   "Tug",   "Trailer",   "Emperor",   "Wayfarer",
   "Euros",   "Hotdog",   "Club",   "Trailer",   "Trailer",   "Andromada",   "Dodo",   "RC Cam",   "Launch",   "Police Car (LSPD)",   "Police Car (SFPD)",
   "Police Car (LVPD)",   "Police Ranger",   "Picador",   "S.W.A.T. Van",   "Alpha",   "Phoenix",   "Glendale",   "Sadler",   "Luggage Trailer",
   "Luggage Trailer",   "Stair Trailer",   "Boxville",   "Farm Plow",   "Utility Trailer"
};


public OnFilterScriptInit()
{
    Max_Players = GetMaxPlayers();
	if(SaveSettingsInFile == 1)
	{
		if(!dini_Exists(SaveFile))
		{
		    dini_Create(SaveFile);
		    SaveSettings();
			printf("File \"%s\" Created!", SaveFile);
		}
		else
		{
		    MinCarValue = dini_Int(SaveFile, "MinValue");
            MaxCarValue = dini_Int(SaveFile, "MaxValue");
            GameFrequency = dini_Int(SaveFile, "GameFrequency");
            RoundTime = dini_Int(SaveFile, "RoundTime");
            ExportX = dini_Float(SaveFile, "ExportX");
            ExportY = dini_Float(SaveFile, "ExportY");
            ExportZ = dini_Float(SaveFile, "ExportZ");
            Checkpointsize = dini_Int(SaveFile, "Checkpointsize");
		}
	}
	CreateMenus();
	
	//===============Below here you can add custom export-vehicles==============================
	//Examples:
	//AddExportVehicle(534,2474.1624,-1666.4824,13.0468,182.3898,42,42);  // Exportcar in Grovestreet
	//AddExportVehicle(541,2479.0273,-1665.6949,12.9568,186.9935,22,1);  // Exportcar in Grovestreet
	//AddExportVehicle(411,2485.2815,-1665.2784,13.0669,185.9449,12,1);  // Exportcar in Grovestreet
	//=========================================================================================
	
	if(UseCustomVehicles == 1)
	{
	    SetTimer("CountExportVehicles", 1000, 0);
	}
	else
	{
	    SetTimer("CountNormalVehicles", 1000, 0);
	}
	if(CanPlay == 1)
	{
		SetTimer("StartGame",(GameFrequency*1000), 0);
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(IsGameStarted == 1)
	{
	    SetVehicleParamsForPlayer(ExportVehicle, playerid, 1, 0);
	    new string[128];
	    SendClientMessage(playerid, COLOR_YELLOW, "We are currently playing an Export-Game!");
	    format(string, sizeof(string), "The first one who delivers the %s indicated with yellow marker, wins the value of it ($%d,-)", VehNames[GetVehicleModel(ExportVehicle) - 400], ExportVehicleValue);
	    SendClientMessage(playerid, COLOR_YELLOW, string);
	}
	PlayerVehicle[playerid] = 0;
	return 1;
}

public OnPlayerSpawn(playerid)
{
    if(IsGameStarted == 1)
	{
	    SetVehicleParamsForPlayer(ExportVehicle, playerid, 1, 0);
	}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	if(vehicleid == ExportVehicle)
	{
	    new string[128];
		SendClientMessageToAll(COLOR_ORANGE, "The Export-Car is destroyed, the game is over.");
		format(string, sizeof(string), "A new game will start in %d seconds!", GameFrequency);
		SendClientMessageToAll(COLOR_ORANGE, string);
		for(new i; i<Max_Players; i++)
		{
			SetVehicleParamsForPlayer(ExportVehicle, i, 0, 0);
	    }
	    DisablePlayerCheckpoint(PlayerInExportVehicle);
	    KillTimer(RoundTimer);
   		SetVehicleToRespawn(ExportVehicle);
   		ExportVehicle = 0;
		ExportVehicleValue = 0;
		GameTimeLeft = 0;
		IsGameStarted = 0;
		SetTimer("StartGame",(GameFrequency*1000), 0);
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp("/settings", cmdtext, true, 10) == 0)
	{
	    if(!IsPlayerAdmin(playerid)) return 0;
		ShowMenuForPlayer(MainMenu, playerid);
		TogglePlayerControllable(playerid, 0);
		return 1;
	}
	return 0;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == 2)
	{
	    PlayerVehicle[playerid] = GetPlayerVehicleID(playerid);
	    if(IsPlayerInVehicle(playerid, ExportVehicle))
	    {
            SetPlayerCheckpoint(playerid, ExportX, ExportY, ExportZ, Checkpointsize);
			new string[128];
			new PlayerName[MAX_PLAYER_NAME];
			GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
			format(string, sizeof(string), "You are now in the export-vehicle! You have %d seconds left to deliver it to the red checkpoint!", GameTimeLeft);
			SendClientMessage(playerid, COLOR_YELLOW, string);
			format(string, sizeof(string), "%s has entered the export-vehicle! You have %d seconds left to steal it and deliver it to the red checkpoint!", PlayerName, GameTimeLeft);
			for(new i; i<Max_Players; i++)
			{
				if( i != playerid)
				{
					SendClientMessage(i, COLOR_ORANGE, string);
				}
			}
			PlayerInExportVehicle = playerid;
		}
	}
	if(oldstate == 2)
	{
	    if(PlayerVehicle[playerid] == ExportVehicle)
		{
		    DisablePlayerCheckpoint(playerid);
		    PlayerInExportVehicle = -1;
		}
		PlayerVehicle[playerid] = -1;
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(IsGameStarted == 1)
	{
	    if(IsPlayerInVehicle(playerid, ExportVehicle) && GetPlayerState(playerid) == 2)
		{
		    GetVehiclePos(ExportVehicle, CarX, CarY, CarZ);
			GetVehicleZAngle(ExportVehicle, CarA);
			SetTimerEx("TeleportCar", 2500, 0, "dffffi", ExportVehicle, CarX, CarY, CarZ, CarA, playerid);
		    new string[128], PlayerName[MAX_PLAYER_NAME];
		    GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
			DisablePlayerCheckpoint(playerid);
			SetVehicleToRespawn(ExportVehicle);
			format(string, sizeof(string), "%s has delivered the %s to the Export-place and won $%d", PlayerName,VehNames[GetVehicleModel(ExportVehicle) - 400], ExportVehicleValue);
			SendClientMessageToAll(COLOR_GREEN, string);
			format(string, sizeof(string), "A new Exportgame will start in %d seconds!!", GameFrequency);
			SendClientMessageToAll(COLOR_GREEN, string);
			format(string, sizeof(string), "~y~Winner!!! ~n~~n~You won: ~n~~b~$%d", ExportVehicleValue);
			GameTextForPlayer(playerid, string, 8000, 3);
			PlayerPlaySound(playerid, 1185, 0, 0, 0);
			GivePlayerMoney(playerid, ExportVehicleValue);
			SetTimerEx("StopSound", 8000, 3, "i", playerid);
			SetTimer("StartGame",(GameFrequency*1000), 0);
			for(new i; i<Max_Players; i++)
		    {
		    	SetVehicleParamsForPlayer(ExportVehicle, i, 0, 0);
			}
			KillTimer(RoundTimer);
			GameTimeLeft = 0;
			ExportVehicle = 0;
			ExportVehicleValue = 0;
			IsGameStarted = 0;
			PlayerInExportVehicle = -1;
		}
	}
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:Current = GetPlayerMenu(playerid);
    if(Current == MainMenu)
    {
        switch(row)
        {
            case 0: {ShowMenuForPlayer(MinValueMenu, playerid); }
			case 1: {ShowMenuForPlayer(MaxValueMenu, playerid); }
			case 2: {ShowMenuForPlayer(FrequencyMenu, playerid); }
			case 3: {ShowMenuForPlayer(RoundTimeMenu, playerid); }
			case 4: {ShowMenuForPlayer(LocationMenu, playerid); }
			case 5: {ShowMenuForPlayer(CheckpointsizeMenu, playerid); }
			case 6: {ShowMenuForPlayer(StartNewGameMenu, playerid); }
			case 7: { TogglePlayerControllable(playerid, 1); SaveSettings();}
		}
	}
	if(Current == MinValueMenu)
    {
        switch(row)
        {
            case 0:
			{
				MinCarValue += 5000;
				if(MinCarValue > MaxCarValue) MinCarValue = MaxCarValue;
				UpdateColumnHeader(playerid);
			}
			case 1:
			{
				MinCarValue += 1000;
				if(MinCarValue > MaxCarValue) MinCarValue = MaxCarValue;
				UpdateColumnHeader(playerid);
			}
			case 2:
			{
				MinCarValue += 100;
				if(MinCarValue > MaxCarValue) MinCarValue = MaxCarValue;
				UpdateColumnHeader(playerid);
			}
			case 3:
			{
				MinCarValue += 10;
				if(MinCarValue > MaxCarValue) MinCarValue = MaxCarValue;
				UpdateColumnHeader(playerid);
			}
			case 4:
			{
				MinCarValue -= 10;
				if(MinCarValue < 0) MinCarValue = 0;
				UpdateColumnHeader(playerid);
			}
			case 5:
			{
				MinCarValue -= 100;
				if(MinCarValue < 0) MinCarValue = 0;
				UpdateColumnHeader(playerid);
			}
			case 6:
			{
				MinCarValue -= 1000;
				if(MinCarValue < 0) MinCarValue = 0;
				UpdateColumnHeader(playerid);
			}
			case 7:
			{
				MinCarValue -= 5000;
				if(MinCarValue < 0) MinCarValue = 0;
				UpdateColumnHeader(playerid);
			}
			case 8:
			{
				ShowMenuForPlayer(MainMenu, playerid);
			}
		}
	}
	if(Current == MaxValueMenu)
    {
        switch(row)
        {
            case 0:{MaxCarValue += 5000;UpdateColumnHeader(playerid);}
			case 1:{MaxCarValue += 1000;UpdateColumnHeader(playerid);}
			case 2:{MaxCarValue += 100;UpdateColumnHeader(playerid);}
			case 3:{MaxCarValue += 10;UpdateColumnHeader(playerid);}
			case 4:
			{
				MaxCarValue -= 10;
				if(MaxCarValue < MinCarValue) MaxCarValue = MinCarValue;
				UpdateColumnHeader(playerid);
			}
			case 5:
			{
				MaxCarValue -= 100;
				if(MaxCarValue < MinCarValue) MaxCarValue = MinCarValue;
				UpdateColumnHeader(playerid);
			}
			case 6:
			{
				MaxCarValue -= 1000;
				if(MaxCarValue < MinCarValue) MaxCarValue = MinCarValue;
				UpdateColumnHeader(playerid);
			}
			case 7:
			{
				MaxCarValue -= 5000;
				if(MaxCarValue < MinCarValue) MaxCarValue = MinCarValue;
				UpdateColumnHeader(playerid);
			}
			case 8:{ShowMenuForPlayer(MainMenu, playerid);}
		}
	}
	
	if(Current == FrequencyMenu)
    {
        switch(row)
        {
            case 0:{GameFrequency += 600;UpdateColumnHeader(playerid);}
			case 1:{GameFrequency += 60;UpdateColumnHeader(playerid);}
			case 2:{GameFrequency += 10;UpdateColumnHeader(playerid);}
			case 3:
			{
				GameFrequency -= 10;
				if(GameFrequency < 1) GameFrequency = 1;
				UpdateColumnHeader(playerid);
			}
			case 4:
			{
				GameFrequency -= 60;
				if(GameFrequency < 1) GameFrequency = 1;
				UpdateColumnHeader(playerid);
			}
			case 5:
			{
				GameFrequency -= 600;
				if(GameFrequency < 1) GameFrequency = 1;
				UpdateColumnHeader(playerid);
			}
			case 6:{ShowMenuForPlayer(MainMenu, playerid);}
		}
	}
	
	if(Current == RoundTimeMenu)
    {
        switch(row)
        {
            case 0:{RoundTime += 600;UpdateColumnHeader(playerid);}
			case 1:{RoundTime += 60;UpdateColumnHeader(playerid);}
			case 2:{RoundTime += 10;UpdateColumnHeader(playerid);}
			case 3:
			{
				RoundTime -= 10;
				if(RoundTime < 1) RoundTime = 1;
				UpdateColumnHeader(playerid);
			}
			case 4:
			{
				RoundTime -= 60;
				if(RoundTime < 1) RoundTime = 1;
				UpdateColumnHeader(playerid);
			}
			case 5:
			{
				RoundTime -= 600;
				if(RoundTime < 1) RoundTime = 1;
				UpdateColumnHeader(playerid);
			}
			case 6:{ShowMenuForPlayer(MainMenu, playerid);}
		}
  	}
  	
  	if(Current == LocationMenu)
    {
        switch(row)
        {
            case 0:{ShowMenuForPlayer(MainMenu, playerid);}
			case 1:
			{
				GetPlayerPos(playerid, ExportX, ExportY, ExportZ);
				GameTextForPlayer(playerid, "~y~New Export-Location ~n~Saved Succesfully!", 4000, 4);
				ShowMenuForPlayer(MainMenu, playerid);
			}
		}
	}
	if(Current == CheckpointsizeMenu)
    {
        switch(row)
        {
            case 0:
			{
                Checkpointsize++;
                UpdateColumnHeader(playerid);
			}
			case 1:
			{
				Checkpointsize--;
				if(Checkpointsize < 1) Checkpointsize = 1;
                UpdateColumnHeader(playerid);
			}
			case 2:{ShowMenuForPlayer(MainMenu, playerid);}
		}
	}
	if(Current == StartNewGameMenu)
    {
        switch(row)
        {
            case 0:
			{
			    if(IsGameStarted == 1)
				{
				    GameTextForPlayer(playerid, "~r~A game is already started!", 4000, 4);
				    ShowMenuForPlayer(StartNewGameMenu, playerid);
				}
				else
				{
				    SendClientMessageToAll(COLOR_ORANGE, "An admin started a new export-game!");
				    StartNewGame();
				    TogglePlayerControllable(playerid, 1);
				}
			}
			case 1:
			{
			    if(IsGameStarted == 0)
				{
				    GameTextForPlayer(playerid, "~r~Ther is no game started!", 4000, 4);
				    ShowMenuForPlayer(StartNewGameMenu, playerid);
				}
				else
				{
				    SendClientMessageToAll(COLOR_ORANGE, "An admin stoped the current export-game!");
				    KillTimer(RoundTimer);
				    new string[128];
					format(string, sizeof(string), "In %d seconds (%d minutes) a new game will start!", GameFrequency, (GameFrequency/60));
			        SendClientMessageToAll(COLOR_ORANGE, string);
			        if(IsPlayerInVehicle(PlayerInExportVehicle, ExportVehicle))
			        {
			            GameTextForPlayer(PlayerInExportVehicle, "~r~Game Stopped!", 5000, 3);
			            DisablePlayerCheckpoint(PlayerInExportVehicle);
					}
			        IsGameStarted = 0;
			        SetVehicleToRespawn(ExportVehicle);
			        for(new i; i<Max_Players; i++)
			        {
			       		SetVehicleParamsForPlayer(ExportVehicle, i, 0, 0);
					}
					ExportVehicle = 0;
					ExportVehicleValue = 0;
					SetTimer("StartGame",(GameFrequency*1000), 0);
					TogglePlayerControllable(playerid, 1);
 				}
			}
		}
	}
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
    TogglePlayerControllable(playerid, 1);
    SaveSettings();
	return 1;
}

forward StartGame();
public StartGame()
{
 	if(IsGameStarted == 0)
 	{
    	StartNewGame();
	}
}

StartNewGame()
{
	if(CanPlay == 1)
	{
		new string[128];
		ExportVehicleValue = MinCarValue+(random(MaxCarValue-MinCarValue));
		SendClientMessageToAll(COLOR_YELLOW, "A new Export-Game has started!");
		ChooseExportCar();
		format(string, sizeof(string), "This time the ExportCompany wants a %s, the value of this car is: $%d,-", VehNames[GetVehicleModel(ExportVehicle) - 400], ExportVehicleValue);
		SendClientMessageToAll(COLOR_YELLOW, string);
		SendClientMessageToAll(COLOR_YELLOW, "The car is indicated with a yellow marker, the player who takes it first to the Export-place wins!");
		for(new i; i<Max_Players; i++)
		{
		    SetVehicleParamsForPlayer(ExportVehicle, i, 1, 0);
		}
		IsGameStarted = 1;
		GameTimeLeft = RoundTime;
		RoundTimer = SetTimer("StopGame", 10000, 1);
	}
}

stock IsVehicleEmpty(VehicleID)
{
	for(new i; i<Max_Players; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlayerInVehicle(i, VehicleID))
	        {
				return 0;
			}
		}
	}
	return 1;
}

ChooseExportCar()
{
    new iscarfound;
	new randomvehicle;
	new model;
	for(new i=1; i<TotalVehicles(); i++)
	{
		randomvehicle = random(TotalVehicles());
		if(UseCustomVehicles == 1)
		{
		    if(IsExportVehicle[randomvehicle] == 1)
		    {
		        if(IsVehicleEmpty(randomvehicle))
		        {
 					iscarfound = 1;
 					ExportVehicle = randomvehicle;
				}
			}
		}
		else
		{
		    model = GetVehicleModel(randomvehicle);
			for(new a; a<sizeof(ExportableVehicles); a++)
			{
			    if(model == ExportableVehicles[a][0])
			    {
			        if(IsVehicleEmpty(randomvehicle))
			        {
	 					iscarfound = 1;
	 					ExportVehicle = randomvehicle;
						break;
					}
				}
			}
		}
		if(iscarfound == 1) break;
	}
}

TotalVehicles()
{
	new vid;
	vid = CreateVehicle(411, 0, 0, 0, 0, -1, -1, 10);
	DestroyVehicle(vid);
	vid--;
	return vid;
}

forward StopGame();
public StopGame()
{
	if(GameTimeLeft == 300){SendClientMessageToAll(COLOR_ORANGE, "You have 5 minutes left to deliver the ExportVehicle!");}
	if(GameTimeLeft == 60){SendClientMessageToAll(COLOR_ORANGE, "You have 1 minute left to deliver the ExportVehicle!");}
	if(GameTimeLeft == 10){SendClientMessageToAll(COLOR_ORANGE, "You have 10 seconds left to deliver the ExportVehicle!");}
	if(GameTimeLeft == 0)
	{
	    KillTimer(RoundTimer);
	    new string[128];
		SendClientMessageToAll(COLOR_RED, "You all failed to deliver the export-vehicle to the exportplace");
		format(string, sizeof(string), "In %d seconds (%d minutes) a new game will start!", GameFrequency, (GameFrequency/60));
        SendClientMessageToAll(COLOR_ORANGE, string);
        if(IsPlayerInVehicle(PlayerInExportVehicle, ExportVehicle))
        {
            GameTextForPlayer(PlayerInExportVehicle, "~r~You Failed!", 5000, 3);
            DisablePlayerCheckpoint(PlayerInExportVehicle);
		}
        IsGameStarted = 0;
        SetVehicleToRespawn(ExportVehicle);
        for(new i; i<Max_Players; i++)
        {
       		SetVehicleParamsForPlayer(ExportVehicle, i, 0, 0);
		}
		ExportVehicle = 0;
		ExportVehicleValue = 0;
		SetTimer("StartGame",(GameFrequency*1000), 0);
		
	}
	GameTimeLeft -= 10;
}

forward StopSound(playerid);
public StopSound(playerid)
{
	PlayerPlaySound(playerid, 1186, 0, 0, 0);
}

forward TeleportCar(carid, Float:X, Float:Y, Float:Z, Float:A, playerid);
public TeleportCar(carid, Float:X, Float:Y, Float:Z, Float:A, playerid)
{
	SetVehiclePos(carid, X, Y, Z);
	SetVehicleZAngle(carid, A);
	PutPlayerInVehicle(playerid, carid, 0);
}

CreateMenus()
{
	new string[64];
    MainMenu = CreateMenu(" ", 1, 150, 150, 300, 40);
    SetMenuColumnHeader(MainMenu,0,"Settings");
    AddMenuItem(MainMenu, 0, "Set Min. CarValue");
    AddMenuItem(MainMenu, 0, "Set Max. CarValue");
    AddMenuItem(MainMenu, 0, "Set GameFrequency");
    AddMenuItem(MainMenu, 0, "Set Roundtime");
    AddMenuItem(MainMenu, 0, "Set New Export-Location");
    AddMenuItem(MainMenu, 0, "Set Checkpointsize");
    AddMenuItem(MainMenu, 0, "Start/Stop Game");
    AddMenuItem(MainMenu, 0, "Exit");
    
    MinValueMenu = CreateMenu("Min. CarValue", 1, 150, 150, 300, 40);
    format(string, sizeof(string), "Current: %d dollar", MinCarValue);
    SetMenuColumnHeader(MinValueMenu,0, string);
    AddMenuItem(MinValueMenu, 0, "+5000");
    AddMenuItem(MinValueMenu, 0, "+1000");
    AddMenuItem(MinValueMenu, 0, "+100");
    AddMenuItem(MinValueMenu, 0, "+10");
    AddMenuItem(MinValueMenu, 0, "-10");
    AddMenuItem(MinValueMenu, 0, "-100");
    AddMenuItem(MinValueMenu, 0, "-1000");
    AddMenuItem(MinValueMenu, 0, "-5000");
    AddMenuItem(MinValueMenu, 0, "Done");
    
    MaxValueMenu = CreateMenu("Max. CarValue", 1, 150, 150, 300, 40);
    format(string, sizeof(string), "Current: %d dollar", MaxCarValue);
    SetMenuColumnHeader(MaxValueMenu,0, string);
    AddMenuItem(MaxValueMenu, 0, "+5000");
    AddMenuItem(MaxValueMenu, 0, "+1000");
    AddMenuItem(MaxValueMenu, 0, "+100");
    AddMenuItem(MaxValueMenu, 0, "+10");
    AddMenuItem(MaxValueMenu, 0, "-10");
    AddMenuItem(MaxValueMenu, 0, "-100");
    AddMenuItem(MaxValueMenu, 0, "-1000");
    AddMenuItem(MaxValueMenu, 0, "-5000");
    AddMenuItem(MaxValueMenu, 0, "Done");
    
    FrequencyMenu = CreateMenu("GameFrequency", 1, 150, 150, 300, 40);
    format(string, sizeof(string), "Current: %d seconds", GameFrequency);
    SetMenuColumnHeader(FrequencyMenu,0, string);
    AddMenuItem(FrequencyMenu, 0, "+600 seconds");
    AddMenuItem(FrequencyMenu, 0, "+60 seconds");
    AddMenuItem(FrequencyMenu, 0, "+10 seconds");
    AddMenuItem(FrequencyMenu, 0, "-10 seconds");
    AddMenuItem(FrequencyMenu, 0, "-60 seconds");
    AddMenuItem(FrequencyMenu, 0, "-600 seconds");
    AddMenuItem(FrequencyMenu, 0, "Done");
    
    RoundTimeMenu = CreateMenu("RoundTime", 1, 150, 150, 300, 40);
    format(string, sizeof(string), "Current: %d seconds", RoundTime);
    SetMenuColumnHeader(RoundTimeMenu,0, string);
    AddMenuItem(RoundTimeMenu, 0, "+600 seconds");
    AddMenuItem(RoundTimeMenu, 0, "+60 seconds");
    AddMenuItem(RoundTimeMenu, 0, "+10 seconds");
    AddMenuItem(RoundTimeMenu, 0, "-10 seconds");
    AddMenuItem(RoundTimeMenu, 0, "-60 seconds");
    AddMenuItem(RoundTimeMenu, 0, "-600 seconds");
    AddMenuItem(RoundTimeMenu, 0, "Done");
    
    LocationMenu = CreateMenu("Export-Location", 1, 150, 150, 300, 40);
    format(string, sizeof(string), "Are you sure?");
    SetMenuColumnHeader(LocationMenu,0, string);
    AddMenuItem(LocationMenu, 0, "No");
    AddMenuItem(LocationMenu, 0, "Yes");
    
    CheckpointsizeMenu = CreateMenu("Export-Location", 1, 150, 150, 300, 40);
    format(string, sizeof(string), "Current Size: %d", Checkpointsize);
    SetMenuColumnHeader(CheckpointsizeMenu,0, string);
    AddMenuItem(CheckpointsizeMenu, 0, "+1");
    AddMenuItem(CheckpointsizeMenu, 0, "-1");
    AddMenuItem(CheckpointsizeMenu, 0, "Done");
    
    StartNewGameMenu = CreateMenu("Export-Location", 1, 150, 150, 300, 40);
    format(string, sizeof(string), " ", Checkpointsize);
    SetMenuColumnHeader(StartNewGameMenu,0, string);
    AddMenuItem(StartNewGameMenu, 0, "Start New Game");
    AddMenuItem(StartNewGameMenu, 0, "Stop Current Game");
    AddMenuItem(StartNewGameMenu, 0, "Back");

    

}

UpdateColumnHeader(playerid)
{
	new Menu:Current = GetPlayerMenu(playerid);
	new string[64];
	if(Current == MinValueMenu)
	{
	    format(string, sizeof(string), "Current: %d dollar", MinCarValue);
	    SetMenuColumnHeader(MinValueMenu,0, string);
	    ShowMenuForPlayer(MinValueMenu, playerid);
	}
	if(Current == MaxValueMenu)
	{
	    format(string, sizeof(string), "Current: %d dollar", MaxCarValue);
	    SetMenuColumnHeader(MaxValueMenu,0, string);
	    ShowMenuForPlayer(MaxValueMenu, playerid);
	}
	if(Current == FrequencyMenu)
	{
	    format(string, sizeof(string), "Current: %d seconds", GameFrequency);
	    SetMenuColumnHeader(FrequencyMenu,0, string);
	    ShowMenuForPlayer(FrequencyMenu, playerid);
	}
	if(Current == RoundTimeMenu)
	{
	    format(string, sizeof(string), "Current: %d seconds", RoundTime);
	    SetMenuColumnHeader(RoundTimeMenu,0, string);
	    ShowMenuForPlayer(RoundTimeMenu, playerid);
	}
	if(Current == CheckpointsizeMenu)
	{
	    format(string, sizeof(string), "Current Size: %d", Checkpointsize);
	    SetMenuColumnHeader(CheckpointsizeMenu,0, string);
	    ShowMenuForPlayer(CheckpointsizeMenu, playerid);
	}
}

SaveSettings()
{
	dini_IntSet(SaveFile, "MinValue", MinCarValue);
    dini_IntSet(SaveFile, "MaxValue", MaxCarValue);
    dini_IntSet(SaveFile, "GameFrequency", GameFrequency);
    dini_IntSet(SaveFile, "RoundTime", RoundTime);
    dini_FloatSet(SaveFile, "ExportX", ExportX);
    dini_FloatSet(SaveFile, "ExportY", ExportY);
    dini_FloatSet(SaveFile, "ExportZ", ExportZ);
    dini_IntSet(SaveFile, "Checkpointsize", Checkpointsize);
}

stock AddExportVehicle(model, Float:X, Float:Y, Float:Z, Float:Angle, color1, color2)
{
	new newvid;
	newvid = AddStaticVehicle(model, X, Y, Z, Angle, color1, color2);
	IsExportVehicle[newvid] = 1;
}

forward CountExportVehicles();
public CountExportVehicles()
{
	new count;
	for(new i=1; i<TotalVehicles(); i++)
	{
	    if(IsExportVehicle[i] == 1)
	    {
	        count++;
	        CanPlay = 1;
		}
	}
	if(count == 0)
	{
	    print("=============================================================");
	    print("Error: You did not add Export-Vehicles in this filterscript!!");
	    print("Add some, or set change the option 'UseCustomVehicles' to '0'");
	    print("=============================================================");
	    CanPlay = 0;
	}
}
forward CountNormalVehicles();
public CountNormalVehicles()
{
	if(TotalVehicles() == 0)
	{
	    print("=============================================================");
	    print("Error: No Vehicles found in your gamemode or filterscripts!!!");
	    print("        Add some if you want to play this Export-Game");
	    print("=============================================================");
	    CanPlay = 0;
	}
}
