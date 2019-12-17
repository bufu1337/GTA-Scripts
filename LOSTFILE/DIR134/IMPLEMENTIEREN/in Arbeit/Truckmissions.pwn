/*
This TruckMission FilterScript is made by =>Sandra<= on the 10th of March 2008
Do not remove any credits!
*/

#include <a_samp>
#include <dini>

#define MAX_MISSIONS 25

#define MissionFile "Truckmissions/%d.mission"
#define DefaultCheckpointSize 5
#define DefaultTruckModel 515
#define DefaultTrailerModel 435
#define DefaultPrize 1000

//Colors
#define COLOR_RED 0xFF0000AA
#define COLOR_GREEN 0x00FF00AA
#define COLOR_BLUE 0x0000FFAA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_ORANGE 0xFFA500AA
#define COLOR_MENU 0xADFF2FAA //Green/Yellow
#define COLOR_MENUHEADER 0x7CFC00AA
#define COLOR_AQUA 0x66CDAAAA

//Actions
#define CHANGE_NAME 1
#define CHANGE_PRIZE 2
#define CHANGE_MODEL 3
#define CHANGE_CPSIZE 4
#define CHANGE_TRAILER 5
#define CHANGE_COLOR1 6
#define CHANGE_COLOR2 7
#define CHANGE_TIMELIMIT 8

/*
===============Usable Truck & Trailer Models:
Truck-Models:
403 - Linerunner
514 - Petrol Tanker
515 - RoadTrain

Trailer-Models:
435 - Trailer 1
450 - Trailer 2
591 - Trailer 3
584 - PetrolTrailer
=============================================
*/

enum Minfo
{
	Ready,
	DoesExists,
	Float:StartX,
	Float:StartY,
	Float:StartZ,
	Float:StartAngle,
	Float:EndX,
	Float:EndY,
    Float:EndZ,
    CpSize,
    Prize,
    Name[50],
    TruckModel,
    TruckColor1,
    TruckColor2,
    Highscore,
    HighscoreName[MAX_PLAYER_NAME],
	IsGettingPlayed,
	TickcountBeforeStart,
	TrailerModel,
	UseTrailer,
	TimeLimit,
	Timer,
}
new MissionInfo[MAX_MISSIONS][Minfo];

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

new TruckmissionPlaying[MAX_PLAYERS];
new FileName[60];
new Question;
new Menu:SettingsMenu1;
new Menu:SettingsMenu2;
new Menu:UseTrailerMenu;
new Menu:ColorMenu;
new SpecialAction[MAX_PLAYERS];
new EditMissionID;
new Truck[MAX_MISSIONS];
new Trailer[MAX_MISSIONS];


public OnFilterScriptInit()
{
	for(new i=1; i<MAX_MISSIONS; i++)
	{
		format(MissionInfo[i][HighscoreName], MAX_PLAYER_NAME, "Nobody");
		format(FileName, sizeof(FileName), MissionFile, i);
	    if(dini_Exists(FileName))
	    {
	    	MissionInfo[i][DoesExists] = 1;
			ReadFile(i);
		}
	}
	SettingsMenu1 = CreateMenu("Settings", 1, 150, 150, 300, 40);
	AddMenuItem(SettingsMenu1, 0, "Change Name");
	AddMenuItem(SettingsMenu1, 0, "Set StartPosition");
	AddMenuItem(SettingsMenu1, 0, "Set Finishposition");
	AddMenuItem(SettingsMenu1, 0, "Change Checkpointsize");
	AddMenuItem(SettingsMenu1, 0, "Change Prize");
	AddMenuItem(SettingsMenu1, 0, "Change Truckmodel");
	AddMenuItem(SettingsMenu1, 0, "Reset Highscore");
	AddMenuItem(SettingsMenu1, 0, "View MissionInfo");
	AddMenuItem(SettingsMenu1, 0, "Reload Mission");
	AddMenuItem(SettingsMenu1, 0, "Next");
	SettingsMenu2 = CreateMenu("Settings", 1, 150, 150, 300, 40);
	AddMenuItem(SettingsMenu2, 0, "Use Trailer");
	AddMenuItem(SettingsMenu2, 0, "Change Trailermodel");
	AddMenuItem(SettingsMenu2, 0, "Change Truckcolor");
	AddMenuItem(SettingsMenu2, 0, "Set TimeLimit");
	AddMenuItem(SettingsMenu2, 0, "Back");
	UseTrailerMenu = CreateMenu(" ", 1, 150, 150, 300, 40);
	SetMenuColumnHeader(UseTrailerMenu, 0, "Do you want to use a trailer?");
	AddMenuItem(UseTrailerMenu, 0, "Yes");
	AddMenuItem(UseTrailerMenu, 0, "No");
	AddMenuItem(UseTrailerMenu, 0, "Back");
	ColorMenu = CreateMenu("Colors", 1, 150, 150, 300, 40);
	AddMenuItem(ColorMenu, 0, "Change Color 1");
	AddMenuItem(ColorMenu, 0, "Change Color 2");
	AddMenuItem(ColorMenu, 0, "Show Color ID's");
	AddMenuItem(ColorMenu, 0, "Back");
	print("==========================================");
	print("This Truckmission Filterscript is made by:");
	print("                =>Sandra<=                ");
	print("        Do not remove the credits!        ");
	print("==========================================");
	return 1;
}

public OnFilterScriptExit()
{
	SaveFiles();
	for(new i; i<MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
			for(new ID=1; ID<MAX_MISSIONS; ID++)
			{
			    if(IsPlayerInVehicle(i, Truck[ID]))
			    {
			        RemovePlayerFromVehicle(i);
				}
			}
		}
	}
	for(new ID=1; ID<MAX_MISSIONS; ID++)
	{
	   	DestroyVehicle(Truck[ID]);
	   	DestroyVehicle(Trailer[ID]);
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
    TruckmissionPlaying[playerid] = 0;
    SpecialAction[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new ID = TruckmissionPlaying[playerid];
	if(ID > 0)
	{
	    MissionInfo[ID][IsGettingPlayed] = 0;
	 	MissionInfo[ID][TickcountBeforeStart] = 0;
	 	DisablePlayerCheckpoint(playerid);
		SetVehicleToRespawn(Truck[ID]);
		KillTimer(MissionInfo[ID][Timer]);
		if(MissionInfo[ID][UseTrailer] == 1)
		{
			DestroyVehicle(Trailer[ID]);
		}
	}
	TruckmissionPlaying[playerid] = 0;
	return 1;
}


public OnVehicleDeath(vehicleid, killerid)
{
	new PTruck;
    for(new ID=1; ID<MAX_MISSIONS; ID++)
    {
        if(Truck[ID] == vehicleid)
		{
		    PTruck = ID;
			break;
		}
	}
	if(PTruck > 0)
	{
		for(new i; i<MAX_PLAYERS; i++)
		{
		    if(IsPlayerConnected(i))
		    {
				if(TruckmissionPlaying[i] == PTruck)
				{
				    GameTextForPlayer(i, "~r~Loser", 5000, 3);
					TruckmissionPlaying[i] = 0;
				    MissionInfo[PTruck][IsGettingPlayed] = 0;
				 	MissionInfo[PTruck][TickcountBeforeStart] = 0;
				 	DisablePlayerCheckpoint(i);
				 	SendClientMessage(i, COLOR_RED, "You failed the Truckmission!");
					SetVehicleToRespawn(Truck[PTruck]);
					TruckmissionPlaying[i] = 0;
					if(MissionInfo[PTruck][UseTrailer] == 1)
					{
						DestroyVehicle(Trailer[PTruck]);
					}
				}
			}
		}
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(SpecialAction[playerid] > 0)
	{
	    switch(SpecialAction[playerid])
	    {
			case CHANGE_NAME:
			{
			    new string[128];
				format(MissionInfo[EditMissionID][Name], 50, "%s", text);
				format(string, sizeof(string), "The new name of TruckMission #%d is: \"%s\".", EditMissionID, MissionInfo[EditMissionID][Name]);
				SendClientMessage(playerid, COLOR_GREEN, string);
				GameTextForPlayer(playerid, " ", 100, 3);
				ShowMenuForPlayer(SettingsMenu1, playerid);
				SpecialAction[playerid] = 0;
				return 0;
			}
			case CHANGE_PRIZE:
			{
			    if(!IsNumeric(text))
				{
					SendClientMessage(playerid, COLOR_RED, "Only numbers allowed!");
					return 0;
				}
				else
				{
					new newval = strval(text);
				    new string[128];
					MissionInfo[EditMissionID][Prize] = newval;
					format(string, sizeof(string), "The new prize of TruckMission #%d is: $%d", EditMissionID, MissionInfo[EditMissionID][Prize]);
					SendClientMessage(playerid, COLOR_GREEN, string);
					GameTextForPlayer(playerid, " ", 100, 3);
					ShowMenuForPlayer(SettingsMenu1, playerid);
					SpecialAction[playerid] = 0;
				}
				return 0;
			}
			case CHANGE_CPSIZE:
			{
				if(!IsNumeric(text))
				{
					SendClientMessage(playerid, COLOR_RED, "Only numbers allowed!");
                    return 0;
				}
				else
				{
				    new newval = strval(text);
				    new string[128];
					MissionInfo[EditMissionID][CpSize] = newval;
					format(string, sizeof(string), "The new CheckpointSize of TruckMission #%d is: %d", EditMissionID, MissionInfo[EditMissionID][CpSize]);
					SendClientMessage(playerid, COLOR_GREEN, string);
					GameTextForPlayer(playerid, " ", 100, 3);
					ShowMenuForPlayer(SettingsMenu1, playerid);
					SpecialAction[playerid] = 0;
					return 0;
				}
			}
			case CHANGE_MODEL:
			{
			    if(!IsNumeric(text))
				{
					SendClientMessage(playerid, COLOR_RED, "Only numbers allowed!");
					return 0;
				}
				if(!IsUsableTruck(strval(text)))
				{
					SendClientMessage(playerid, COLOR_RED, "Invalid Model. (Available: 403, 514, 515)");
					return 0;
				}
				else
				{
				    new newval = strval(text);
			        new string[128];
					MissionInfo[EditMissionID][TruckModel] = newval;
					format(string, sizeof(string), "The new Truckmodel of TruckMission #%d is: %d (%s)", EditMissionID, MissionInfo[EditMissionID][TruckModel], VehNames[newval-400]);
					SendClientMessage(playerid, COLOR_GREEN, string);
					GameTextForPlayer(playerid, " ", 100, 3);
					ShowMenuForPlayer(SettingsMenu1, playerid);
					SpecialAction[playerid] = 0;
					return 0;
				}
   			}
   			case CHANGE_TRAILER:
			{
			    if(!IsNumeric(text))
				{
					SendClientMessage(playerid, COLOR_RED, "Only numbers allowed!");
					return 0;
				}
				if(!IsUsableTrailer(strval(text)))
				{
					SendClientMessage(playerid, COLOR_RED, "Invalid Model. (Available: 435, 450, 584, 591)");
					return 0;
				}
				else
				{
				    new newval = strval(text);
			        new string[128];
					MissionInfo[EditMissionID][TrailerModel] = newval;
					format(string, sizeof(string), "The new TrailerModel of TruckMission #%d is: %d (%s)", EditMissionID, MissionInfo[EditMissionID][TrailerModel], VehNames[newval-400]);
					SendClientMessage(playerid, COLOR_GREEN, string);
					GameTextForPlayer(playerid, " ", 100, 3);
					ShowMenuForPlayer(SettingsMenu2, playerid);
					SpecialAction[playerid] = 0;
					return 0;
				}
   			}
   			case CHANGE_COLOR1:
			{
			    if(!IsNumeric(text))
				{
					SendClientMessage(playerid, COLOR_RED, "Only numbers allowed!");
					return 0;
				}
				else
				{
				    new newval = strval(text);
					if(newval < -1 || newval > 126)
					{
						SendClientMessage(playerid, COLOR_RED, "Pick a number between -1 and 126!");
						return 0;
					}
			        new string[128];
					MissionInfo[EditMissionID][TruckColor1] = newval;
					format(string, sizeof(string), "The new Truckcolor1 of TruckMission #%d is: %d", EditMissionID, MissionInfo[EditMissionID][TruckColor1]);
					SendClientMessage(playerid, COLOR_GREEN, string);
					GameTextForPlayer(playerid, " ", 100, 3);
					ShowMenuForPlayer(SettingsMenu2, playerid);
					SpecialAction[playerid] = 0;
					return 0;
				}
   			}
   			case CHANGE_COLOR2:
			{
			    if(!IsNumeric(text))
				{
					SendClientMessage(playerid, COLOR_RED, "Only numbers allowed!");
					return 0;
				}
				else
				{
				    new newval = strval(text);
					if(newval < -1 || newval > 126)
					{
						SendClientMessage(playerid, COLOR_RED, "Pick a number between -1 and 126!");
						return 0;
					}
			        new string[128];
					MissionInfo[EditMissionID][TruckColor2] = newval;
					format(string, sizeof(string), "The new Truckcolor2 of TruckMission #%d is: %d", EditMissionID, MissionInfo[EditMissionID][TruckColor2]);
					SendClientMessage(playerid, COLOR_GREEN, string);
					GameTextForPlayer(playerid, " ", 100, 3);
					ShowMenuForPlayer(SettingsMenu2, playerid);
					SpecialAction[playerid] = 0;
					return 0;
				}
   			}
   			case CHANGE_TIMELIMIT:
			{
			    if(!IsNumeric(text))
				{
					SendClientMessage(playerid, COLOR_RED, "Only numbers allowed!");
					return 0;
				}
				else
				{
				    new newval = strval(text);
					if(newval < 0)
					{
						SendClientMessage(playerid, COLOR_RED, "You can't set a negative number!");
						return 0;
					}
			        new string[128];
					MissionInfo[EditMissionID][TimeLimit] = newval;
					format(string, sizeof(string), "The new timelimit of TruckMission #%d is %d seconds", EditMissionID, MissionInfo[EditMissionID][TimeLimit]);
					SendClientMessage(playerid, COLOR_GREEN, string);
					GameTextForPlayer(playerid, " ", 100, 3);
					ShowMenuForPlayer(SettingsMenu2, playerid);
					SpecialAction[playerid] = 0;
					return 0;
				}
   			}
		}
	}
	return 1;
}


public OnPlayerCommandText(playerid, cmdtext[])
{
    new cmd[256], tmp[256], idx;
	cmd = strtok(cmdtext, idx);
	
	if (strcmp("/createmission", cmdtext, true) == 0)
	{
		new NewID;
		if(!IsPlayerAdmin(playerid)) return 0;
		for(new i=1; i<MAX_MISSIONS; i++)
		{
		    if(MissionInfo[i][DoesExists] == 0)
		    {
		        NewID = i;
		        new string[128];
		        format(string, sizeof(string), "The ID of this new Truckmission is: %d.  Use: \"/editmission %d\" to edit this mission.", NewID, NewID);
				SendClientMessage(playerid, COLOR_YELLOW, string);
				MissionInfo[NewID][DoesExists] = 1;
				CreateNewFile(NewID);
				break;
			}
		}
		if(NewID == 0)
		{
		    SendClientMessage(playerid, COLOR_RED, "Limit of Truckmissions reached! You can increase this limit in the .pwn file!");
		}
		return 1;
	}
	
 	if(strcmp(cmd, "/deletemission", true) == 0)
	{
	    if(!IsPlayerAdmin(playerid)) return 0;
        new string[128];
   		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid,COLOR_RED, "Use: /deletemission [MissionID]");
			return 1;
		}
		new ID = strval(tmp);
		if(MissionInfo[ID][DoesExists] == 1)
		{
		    format(FileName, sizeof(FileName), MissionFile, ID);
			dini_Remove(FileName);
			MissionInfo[ID][DoesExists] = 0;
			format(string, sizeof(string), "You deleted Truckmission #%d.", ID);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			DestroyVehicle(Truck[ID]);
			DestroyVehicle(Trailer[ID]);
		}
		else
		{
			format(string, sizeof(string), "Truckmission #%d does not exists!", ID);
			SendClientMessage(playerid, COLOR_RED, string);
		}
		return 1;
	}
	
 	if(strcmp(cmd, "/editmission", true) == 0)
	{
	    if(!IsPlayerAdmin(playerid)) return 0;
        new string[128];
   		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid,COLOR_RED, "Use: /editmission [MissionID]");
			return 1;
		}
		new ID = strval(tmp);
		if(MissionInfo[ID][DoesExists] == 1)
		{
			format(string, sizeof(string), "Settings for Truckmission #%d.", ID);
			SetMenuColumnHeader(SettingsMenu1, 0, string);
			ShowMenuForPlayer(SettingsMenu1, playerid);
			TogglePlayerControllable(playerid, 0);
			EditMissionID = ID;
		}
		else
		{
			format(string, sizeof(string), "Truckmission #%d does not exists!", ID);
			SendClientMessage(playerid, COLOR_RED, string);
		}
		return 1;
	}
	
	if(strcmp(cmd, "/missioninfo", true) == 0)
	{
	    if(!IsPlayerAdmin(playerid)) return 0;
        new string[128];
   		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid,COLOR_RED, "Use: /missioninfo [MissionID]");
			return 1;
		}
		new ID = strval(tmp);
		if(MissionInfo[ID][DoesExists] == 1)
		{
			GetMissionInfo(playerid, ID);
			return 1;
		}
		else
		{
			format(string, sizeof(string), "Truckmission #%d does not exists!", ID);
			SendClientMessage(playerid, COLOR_RED, string);
		}
		return 1;
	}

	if(strcmp(cmdtext, "/yes", true)==0)
	{
	    if(!IsPlayerAdmin(playerid)) return 0;
	    if(Question == 0)
	    {
			SendClientMessage(playerid, COLOR_RED, "There is no question for you at the moment.");
			return 1;
		}
	    if(Question == 1)
	    {
  	        if(IsPlayerInAnyVehicle(playerid))
	        {
	            GetVehiclePos(GetPlayerVehicleID(playerid), MissionInfo[EditMissionID][StartX], MissionInfo[EditMissionID][StartY], MissionInfo[EditMissionID][StartZ]);
				GetVehicleZAngle(GetPlayerVehicleID(playerid), MissionInfo[EditMissionID][StartAngle]);
			}
			else
			{
			    GetPlayerPos(playerid, MissionInfo[EditMissionID][StartX], MissionInfo[EditMissionID][StartY], MissionInfo[EditMissionID][StartZ]);
	        	GetPlayerFacingAngle(playerid, MissionInfo[EditMissionID][StartAngle]);
			}
			GameTextForPlayer(playerid, "~g~New StartPosition Saved!", 4000, 4);
			Question = 0;
			ShowMenuForPlayer(SettingsMenu1, playerid);
			return 1;
		}
		if(Question == 2)
	    {
	        GetPlayerPos(playerid, MissionInfo[EditMissionID][EndX], MissionInfo[EditMissionID][EndY], MissionInfo[EditMissionID][EndZ]);
			GameTextForPlayer(playerid, "~g~New FinishPosition Saved!", 4000, 4);
			Question = 0;
			ShowMenuForPlayer(SettingsMenu1, playerid);
			return 1;
		}
	}
	
	if(strcmp(cmdtext, "/no", true)==0)
	{
	    if(!IsPlayerAdmin(playerid)) return 0;
	    if(Question == 0)
	    {
			SendClientMessage(playerid, COLOR_RED, "There is no question for you at the moment.");
			return 1;
		}
		else
		{
			GameTextForPlayer(playerid, " ", 100, 3);
			ShowMenuForPlayer(SettingsMenu1, playerid);
		}
		return 1;
	}
	
	if(strcmp(cmd, "/startmission", true)==0)
	{
	    if(TruckmissionPlaying[playerid] > 0) return SendClientMessage(playerid, COLOR_RED, "You are already playing a Truckmission!");
		new IsInATruck;
		new ID;
		for(new i=1; i<MAX_MISSIONS; i++)
		{
			if(IsPlayerInVehicle(playerid, Truck[i]))
			{
				ID = i;
                IsInATruck = 1;
				break;
			}
		}
		if(IsInATruck == 0) return SendClientMessage(playerid, COLOR_RED, "You are not inside a Mission-Truck!");
		new string[128];
		if(!IsMissionReady(ID))
		{
		    SendClientMessage(playerid, COLOR_RED, "This mission is not ready yet!");
			return 1;
		}
	    if(MissionInfo[ID][IsGettingPlayed] == 0)
	    {
	        MissionInfo[ID][IsGettingPlayed] = 1;
	        TruckmissionPlaying[playerid] = ID;
	        if(MissionInfo[ID][UseTrailer] == 1)
	        {
				Trailer[ID] = CreateVehicle(MissionInfo[ID][TrailerModel], 0, 0, 0, 0, -1, -1, -1);
				AttachTrailerToVehicle(Trailer[ID], Truck[ID]);
			}
			if(MissionInfo[ID][TimeLimit] > 0)
			{
			    MissionInfo[ID][Timer] = SetTimerEx("MissionTimer", (MissionInfo[ID][TimeLimit]*1000), 0, "id", playerid, ID);
				format(string, sizeof(string), "Take this truck to the checkpoint within %d seconds!", MissionInfo[ID][TimeLimit]);
				SendClientMessage(playerid, COLOR_AQUA, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_AQUA, "Take this Truck to the checkpoint marked on the radar as fast as you can!");
			}
			TogglePlayerControllable(playerid, 1);
	        MissionInfo[ID][TickcountBeforeStart] = GetTickCount();
	        
	        SetPlayerCheckpoint(playerid, MissionInfo[ID][EndX], MissionInfo[ID][EndY], MissionInfo[ID][EndZ], MissionInfo[ID][CpSize]);
	    }
	    else
		{
			format(string, sizeof(string), "Sorry, someone else is already playing Truckmission #%d", ID);
			SendClientMessage(playerid, COLOR_RED, string);
		}
		return 1;
	}
	
	if(strcmp(cmd, "/stopmission", true)==0)
	{
	    if(TruckmissionPlaying[playerid] == 0) return SendClientMessage(playerid, COLOR_RED, "You are not playing a Truckmission!");
	    RemovePlayerFromVehicle(playerid);
	    new ID = TruckmissionPlaying[playerid];
	    TruckmissionPlaying[playerid] = 0;
	    MissionInfo[ID][IsGettingPlayed] = 0;
	 	MissionInfo[ID][TickcountBeforeStart] = 0;
	 	DisablePlayerCheckpoint(playerid);
	 	SendClientMessage(playerid, COLOR_AQUA, "You stopped your current Truckmission!");
		SetVehicleToRespawn(Truck[ID]);
		KillTimer(MissionInfo[ID][Timer]);
		if(MissionInfo[ID][UseTrailer] == 1)
		{
			DestroyVehicle(Trailer[ID]);
		}
		return 1;
	}
	if(strcmp(cmdtext, "/exit", true)==0)
	{
	    TogglePlayerControllable(playerid, 1);
	    RemovePlayerFromVehicle(playerid);
	    return 1;
	}
	
	if(strcmp(cmdtext, "/truckmissions", true)==0)
	{
	    new string[128];
	    new count;
	    new busy[5];
	    SendClientMessage(playerid, COLOR_MENUHEADER, "=======Available Truckmissions:=========");
	    for(new i=1; i<MAX_MISSIONS; i++)
		{
			if(MissionInfo[i][DoesExists] == 1)
			{
		        if(MissionInfo[i][IsGettingPlayed] == 1) busy = "Busy";
			    if(MissionInfo[i][IsGettingPlayed] == 0) busy = "Free";
		    	format(string, sizeof(string), "#%d = \"%s\"   %s", i, MissionInfo[i][Name], busy);
		    	SendClientMessage(playerid, COLOR_MENU, string);
		    	count++;
			}
 		}
		if(count > 9)
		{
		    SendClientMessage(playerid, COLOR_ORANGE, "Use PageUp and PageDown to scroll through te chat");
		}
		return 1;
	}
	if(strcmp(cmdtext, "/truckmodels", true)==0)
	{
	    if(!IsPlayerAdmin(playerid)) return 0;
		SendClientMessage(playerid, COLOR_MENUHEADER, "=====Available Truck- & Trailermodels:=====");
		SendClientMessage(playerid, COLOR_MENU, "Trucks: 403, 514, 515");
		SendClientMessage(playerid, COLOR_MENU, "Trailers: 435, 450, 584, 591");
		SendClientMessage(playerid, COLOR_MENUHEADER, "===========================================");
		return 1;
	}
	
	if(strcmp(cmdtext, "/truckhelp", true)==0)
	{
		SendClientMessage(playerid, COLOR_MENUHEADER, "=============Available Commands:==========");
		SendClientMessage(playerid, COLOR_MENU, "/startmission, /exit, /stopmission, /truckmissions");
		if(IsPlayerAdmin(playerid))
		{
			SendClientMessage(playerid, COLOR_MENUHEADER, "AdminCommands:");
			SendClientMessage(playerid, COLOR_MENU, "/createmission, /deletemission <id>");
			SendClientMessage(playerid, COLOR_MENU, "/editmission <id>, /missioninfo <id>");
			SendClientMessage(playerid, COLOR_MENU, "/missionteleport <id>, /truckmodels");
		}
		return 1;
	}
	
	if(strcmp(cmd, "/missionteleport", true) == 0)
	{
	    if(!IsPlayerAdmin(playerid)) return 0;
        new string[128];
   		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid,COLOR_RED, "Use: /missionteleport [MissionID]");
			return 1;
		}
		new ID = strval(tmp);
		if(MissionInfo[ID][DoesExists] == 1)
		{
			SetPlayerPos(playerid, MissionInfo[ID][StartX], MissionInfo[ID][StartY], (MissionInfo[ID][StartZ]+4));
			return 1;
		}
		else
		{
			format(string, sizeof(string), "Truckmission #%d does not exists!", ID);
			SendClientMessage(playerid, COLOR_RED, string);
		}
		return 1;
	}
	if(strcmp(cmd, "/c", true) == 0)
	{
	    if(!IsPlayerAdmin(playerid)) return 0;
	 	new Float:x,Float:y,Float:z, Float:a;
	   	tmp = strtok(cmdtext, idx);
	   	new vid = strval(tmp);
	   	if(vid < 400 || vid > 609)
	   	{
	       	SendClientMessage(playerid,COLOR_RED,"Gebruik: /car [400-609]");
	       	return 1;
	   	}
	   	else
		{
	   		GetPlayerPos(playerid, x, y, z);
	   		GetPlayerFacingAngle(playerid, a);
	   		new newcar = CreateVehicle(vid,x, y, z, a, -1, -1, 240000);
	   		PutPlayerInVehicle(playerid, newcar, 0);
		}
 		return 1;
	}
	return 0;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    new PTruck;
    for(new ID=1; ID<MAX_MISSIONS; ID++)
    {
        if(IsPlayerInVehicle(playerid, Truck[ID]))
		{
		    PTruck = ID;
			break;
		}
	}
	if(PTruck > 0)
	{
	    SendClientMessage(playerid, COLOR_RED, "You have 10 seconds to get back in your truck, or else the mission will be over!");
		SetTimerEx("ExitedTruck", 10000, 0, "id", playerid, PTruck);
	}
	    
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == 2)
	{
	    if(TruckmissionPlaying[playerid] == 0)
	    {
			new PTruck;
		    for(new ID=1; ID<MAX_MISSIONS; ID++)
		    {
		        if(IsPlayerInVehicle(playerid, Truck[ID]))
				{
				    PTruck = ID;
					break;
				}
			}
			if(PTruck > 0)
			{
			    TogglePlayerControllable(playerid, 0);
				new string[128];
				format(string, sizeof(string), "With this truck you can play Truckmission #%d", PTruck);
				SendClientMessage(playerid, COLOR_ORANGE, string);
				SendClientMessage(playerid, COLOR_ORANGE, "Typ /startmission or else /exit");
			}
		}
	}
	return 1;
}

forward ExitedTruck(playerid, ID);
public ExitedTruck(playerid, ID)
{
	if(!IsPlayerInVehicle(playerid, Truck[ID]))
	{
		GameTextForPlayer(playerid, "~r~Loser", 5000, 3);
		TruckmissionPlaying[playerid] = 0;
	    MissionInfo[ID][IsGettingPlayed] = 0;
	 	MissionInfo[ID][TickcountBeforeStart] = 0;
	 	DisablePlayerCheckpoint(playerid);
	 	SendClientMessage(playerid, COLOR_RED, "You failed the Truckmission!");
		SetVehicleToRespawn(Truck[ID]);
		KillTimer(MissionInfo[ID][Timer]);
		if(MissionInfo[ID][UseTrailer] == 1)
		{
			DestroyVehicle(Trailer[ID]);
		}
	}
}
		

public OnPlayerEnterCheckpoint(playerid)
{
	if(TruckmissionPlaying[playerid] > 0 && IsPlayerInVehicle(playerid, Truck[TruckmissionPlaying[playerid]]))
	{
	    new ID = TruckmissionPlaying[playerid];
	    if(MissionInfo[ID][UseTrailer] == 1)
		{
			if(!IsTrailerAttachedToVehicle(Truck[ID])) return SendClientMessage(playerid, COLOR_RED, "You lost your trailer!");
			DestroyVehicle(Trailer[ID]);
		}
		KillTimer(MissionInfo[ID][Timer]);
        RemovePlayerFromVehicle(playerid);
	    SetVehicleToRespawn(Truck[ID]);
	    new TotalTime = ((GetTickCount() - MissionInfo[ID][TickcountBeforeStart])/1000);
	    new string[128];
	    DisablePlayerCheckpoint(playerid);
	    TruckmissionPlaying[playerid] = 0;
		MissionInfo[ID][IsGettingPlayed] = 0;
		format(string, sizeof(string), "You completed Truckmission #%d!!! You won $%d!!!", ID, MissionInfo[ID][Prize]);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		GameTextForPlayer(playerid, "~g~Winner!", 8000, 3);
		PlayerPlaySound(playerid, 1185, 0, 0, 0);
		GivePlayerMoney(playerid, MissionInfo[ID][Prize]);
		SetTimerEx("StopSound", 8000, 3, "i", playerid);
		format(string, sizeof(string), "It took you %d seconds!", TotalTime);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		if(TotalTime < MissionInfo[ID][Highscore])
		{
			new Pname[MAX_PLAYER_NAME];
			GetPlayerName(playerid, Pname, sizeof(Pname));
			format(string, sizeof(string), "%s has broken the recond of Truckmission #%d! New Highscore: %d seconds", Pname, ID, TotalTime);
			SendClientMessageToAll(COLOR_YELLOW, string);
			MissionInfo[ID][Highscore] = TotalTime;
			format(MissionInfo[ID][HighscoreName], MAX_PLAYER_NAME, "%s", Pname);
		}
	}
	return 1;
}


public OnPlayerSelectedMenuRow(playerid, row)
{
	new Menu:Current = GetPlayerMenu(playerid);
	if(Current == SettingsMenu1)
	{
		switch(row)
		{
		    case 0: {GameTextForPlayer(playerid, "~y~Typ the new name ~n~in the chat~", 999999, 3); SpecialAction[playerid] = CHANGE_NAME;}
		    case 1: {GameTextForPlayer(playerid, "~y~Are you sure you want this location as new startposition? ~n~~g~/yes ~y~or ~r~/no", 999999, 3); Question = 1;}
		    case 2: {GameTextForPlayer(playerid, "~y~Are you sure you want this location as new finishposition? ~n~~g~/yes ~y~or ~r~/no", 999999, 3); Question = 2;}
		    case 3: {GameTextForPlayer(playerid, "~y~Typ the new Checkpointsize ~n~in the chat~", 999999, 3); SpecialAction[playerid] = CHANGE_CPSIZE;}
		    case 4: {GameTextForPlayer(playerid, "~y~Typ the new Prize ~n~in the chat~", 999999, 3); SpecialAction[playerid] = CHANGE_PRIZE;}
		    case 5: {GameTextForPlayer(playerid, "~y~Typ the new model-id ~n~in the chat~", 999999, 3); SpecialAction[playerid] = CHANGE_MODEL;}
            case 6: {GameTextForPlayer(playerid, "~y~Highscores resetted!", 3000, 4); MissionInfo[EditMissionID][Highscore] = 999999; format(MissionInfo[EditMissionID][HighscoreName], 24, "Nobody"); ShowMenuForPlayer(SettingsMenu1, playerid);}
			case 7: {GetMissionInfo(playerid, EditMissionID); ShowMenuForPlayer(SettingsMenu1, playerid);}
			case 8:
			{
			    new id = EditMissionID;
			    DestroyVehicle(Truck[id]);
			    Truck[id] = CreateVehicle(MissionInfo[id][TruckModel], MissionInfo[id][StartX], MissionInfo[id][StartY], MissionInfo[id][StartZ], MissionInfo[id][StartAngle], MissionInfo[id][TruckColor1],MissionInfo[id][TruckColor2], 600000);
				ShowMenuForPlayer(SettingsMenu1, playerid);
			}
		    case 9: {ShowMenuForPlayer(SettingsMenu2, playerid);}
		}
	}
	if(Current == SettingsMenu2)
	{
		switch(row)
		{
		    case 0: {ShowMenuForPlayer(UseTrailerMenu, playerid);}
		    case 1: {GameTextForPlayer(playerid, "~y~Typ the new model-id ~n~in the chat~", 999999, 3); SpecialAction[playerid] = CHANGE_TRAILER;}
			case 2: {ShowMenuForPlayer(ColorMenu, playerid); }
			case 3: {GameTextForPlayer(playerid, "~y~Typ the new time-limit ~n~(in seconds!) ~n~in the chat~", 999999, 3); SpecialAction[playerid] = CHANGE_TIMELIMIT;}
			case 4: {ShowMenuForPlayer(SettingsMenu1, playerid);}
		}
	}
	if(Current == UseTrailerMenu)
	{
		switch(row)
		{
		    case 0: {ShowMenuForPlayer(SettingsMenu2, playerid); MissionInfo[EditMissionID][UseTrailer] = 1; SendClientMessage(playerid, COLOR_YELLOW, "Using a trailer is now enabled for this mission!");}
		    case 1: {ShowMenuForPlayer(SettingsMenu2, playerid); MissionInfo[EditMissionID][UseTrailer] = 0; SendClientMessage(playerid, COLOR_YELLOW, "Using a trailer is now disabled for this mission!");}
			case 2: {ShowMenuForPlayer(SettingsMenu2, playerid);}
		}
	}
	if(Current == ColorMenu)
	{
		switch(row)
		{
		    case 0: {GameTextForPlayer(playerid, "~y~Typ the new color-id ~n~in the chat~", 999999, 3); SpecialAction[playerid] = CHANGE_COLOR1;}
		    case 1: {GameTextForPlayer(playerid, "~y~Typ the new color-id ~n~in the chat~", 999999, 3); SpecialAction[playerid] = CHANGE_COLOR2;}
			case 2:
			{
				SendClientMessage(playerid, COLOR_MENUHEADER, "=====Common CarColors:============");
				SendClientMessage(playerid, COLOR_MENU, "Black = 0 ** White = 1 ** LightBlue = 2  ** Red = 3");
				SendClientMessage(playerid, COLOR_MENU, "Yellow = 6 ** Green = 86 ** LightGrey = 15 ** Purple = 5");
				SendClientMessage(playerid, COLOR_MENU, "DarkBlue = 79 ** DarkGrey = 13 ** LightBrown = 102");
				SendClientMessage(playerid, COLOR_MENU, "DarkBrown = 30 ** Pink = 126 ** RandomColor = -1");
				ShowMenuForPlayer(ColorMenu, playerid);
			}
			case 3: {ShowMenuForPlayer(SettingsMenu2, playerid);}
		}
	}
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
    TogglePlayerControllable(playerid, 1);
	return 1;
}

stock CreateNewFile(id)
{
	format(FileName, sizeof(FileName), MissionFile, id);
	new name[50];
	format(name, sizeof(name), "Race #%d", id);
	dini_Create(FileName);
	dini_Set(FileName, "Name", name);
	dini_FloatSet(FileName, "StartX", 0.0);
	dini_FloatSet(FileName, "StartY", 0.0);
	dini_FloatSet(FileName, "StartZ", 0.0);
	dini_FloatSet(FileName, "StartAngle", 0.0);
	dini_FloatSet(FileName, "EndX", 0.0);
	dini_FloatSet(FileName, "EndY", 0.0);
	dini_FloatSet(FileName, "EndZ", 0.0);
	dini_IntSet(FileName, "CpSize", DefaultCheckpointSize);
	dini_IntSet(FileName, "TruckModel", DefaultTruckModel);
	dini_IntSet(FileName, "TruckColor1", -1);
	dini_IntSet(FileName, "TruckColor2", -1);
	dini_IntSet(FileName, "UseTrailer", 0);
	dini_IntSet(FileName, "TrailerModel", DefaultTrailerModel);
	dini_IntSet(FileName, "Prize", DefaultPrize);
	dini_IntSet(FileName, "TimeLimit", 0);
	dini_IntSet(FileName, "Highscore", 9999999);
	dini_Set(FileName, "HighscoreName", "Nobody");
	ReadFile(id);
}

stock ReadFile(id)
{
	format(FileName, sizeof(FileName), MissionFile, id);
	format(MissionInfo[id][Name], 50, "%s", dini_Get(FileName, "Name"));
	MissionInfo[id][StartX] = dini_Float(FileName, "StartX");
	MissionInfo[id][StartY] = dini_Float(FileName, "StartY");
	MissionInfo[id][StartZ] = dini_Float(FileName, "StartZ");
	MissionInfo[id][StartAngle] = dini_Float(FileName, "StartAngle");
	MissionInfo[id][EndX] = dini_Float(FileName, "EndX");
	MissionInfo[id][EndY] = dini_Float(FileName, "EndY");
	MissionInfo[id][EndZ] = dini_Float(FileName, "EndZ");
	MissionInfo[id][CpSize] = dini_Int(FileName, "CpSize");
	MissionInfo[id][Prize] = dini_Int(FileName, "Prize");
	MissionInfo[id][TimeLimit] = dini_Int(FileName, "TimeLimit");
	MissionInfo[id][TruckModel] = dini_Int(FileName, "TruckModel");
	MissionInfo[id][TruckColor1] = dini_Int(FileName, "TruckColor1");
	MissionInfo[id][TruckColor2] = dini_Int(FileName, "TruckColor2");
	MissionInfo[id][UseTrailer] = dini_Int(FileName, "UseTrailer");
	MissionInfo[id][TrailerModel] = dini_Int(FileName, "TrailerModel");
	MissionInfo[id][Highscore] = dini_Int(FileName, "Highscore");
	format(MissionInfo[id][HighscoreName], MAX_PLAYER_NAME, "%s", dini_Get(FileName, "HighscoreName"));
	Truck[id] = CreateVehicle(MissionInfo[id][TruckModel], MissionInfo[id][StartX], MissionInfo[id][StartY], MissionInfo[id][StartZ], MissionInfo[id][StartAngle], MissionInfo[id][TruckColor1],MissionInfo[id][TruckColor2], 600000);
}

SaveFiles()
{
	for(new id=1; id<MAX_MISSIONS; id++)
	{
	    if(MissionInfo[id][DoesExists] == 1)
	    {
		    format(FileName, sizeof(FileName), MissionFile, id);
			dini_Set(FileName, "Name", MissionInfo[id][Name]);
			dini_FloatSet(FileName, "StartX", MissionInfo[id][StartX]);
			dini_FloatSet(FileName, "StartY", MissionInfo[id][StartY]);
			dini_FloatSet(FileName, "StartZ", MissionInfo[id][StartZ]);
			dini_FloatSet(FileName, "StartAngle", MissionInfo[id][StartAngle]);
			dini_FloatSet(FileName, "EndX", MissionInfo[id][EndX]);
			dini_FloatSet(FileName, "EndY", MissionInfo[id][EndY]);
			dini_FloatSet(FileName, "EndZ", MissionInfo[id][EndZ]);
			dini_IntSet(FileName, "CpSize", MissionInfo[id][CpSize]);
			dini_IntSet(FileName, "TruckModel", MissionInfo[id][TruckModel]);
			dini_IntSet(FileName, "TruckColor1", MissionInfo[id][TruckColor1]);
			dini_IntSet(FileName, "TruckColor2", MissionInfo[id][TruckColor2]);
			dini_IntSet(FileName, "UseTrailer", MissionInfo[id][UseTrailer]);
			dini_IntSet(FileName, "TrailerModel", MissionInfo[id][TrailerModel]);
  			dini_IntSet(FileName, "Prize", MissionInfo[id][Prize]);
  			dini_IntSet(FileName, "TimeLimit", MissionInfo[id][TimeLimit]);
  			dini_IntSet(FileName, "Highscore", MissionInfo[id][Highscore]);
  			dini_Set(FileName, "HighscoreName", MissionInfo[id][HighscoreName]);
		}
	}
}

GetMissionInfo(playerid, ID)
{
	new string[128];
    format(string, sizeof(string), "Truckmission #%d:  \"%s\"", ID, MissionInfo[ID][Name]);
	SendClientMessage(playerid, COLOR_MENUHEADER, string);
	format(string, sizeof(string), "StartPosition: X:%.2f, Y:%.2f, Z:%.2f  Angle:%.2f ", MissionInfo[ID][StartX], MissionInfo[ID][StartY], MissionInfo[ID][StartZ], MissionInfo[ID][StartAngle]);
	SendClientMessage(playerid, COLOR_MENU, string);
	format(string, sizeof(string), "FinishPosition: X:%.2f, Y:%.2f, Z:%.2f", MissionInfo[ID][EndX], MissionInfo[ID][EndY], MissionInfo[ID][EndZ]);
	SendClientMessage(playerid, COLOR_MENU, string);
	format(string, sizeof(string), "CheckpointSize: %d,  Prize: $%d", MissionInfo[ID][CpSize], MissionInfo[ID][Prize]);
	SendClientMessage(playerid, COLOR_MENU, string);
	format(string, sizeof(string), "TruckModel: %d  (%s), TruckColor1: %d, TruckColor2: %d", MissionInfo[ID][TruckModel], VehNames[(MissionInfo[ID][TruckModel]-400)], MissionInfo[ID][TruckColor1], MissionInfo[ID][TruckColor2]);
	SendClientMessage(playerid, COLOR_MENU, string);
	format(string, sizeof(string), "Use Trailer: %d,  TrailerModel: %d,  TimeLimit: %d seconds", MissionInfo[ID][UseTrailer], MissionInfo[ID][TrailerModel], MissionInfo[ID][TimeLimit]);
	SendClientMessage(playerid, COLOR_MENU, string);
	format(string, sizeof(string), "Highscore: %d seconds,  Highscore by: \"%s\"", MissionInfo[ID][Highscore], MissionInfo[ID][HighscoreName]);
	SendClientMessage(playerid, COLOR_MENU, string);
}

IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}


forward StopSound(playerid);
public StopSound(playerid)
{
	PlayerPlaySound(playerid, 1186, 0, 0, 0);
}

IsUsableTruck(model)
{
	switch(model)
	{
	    case 403, 514, 515: { return 1; }
	}
	return 0;
}

IsUsableTrailer(model)
{
	switch(model)
	{
	    case 435, 450, 591, 584: { return 1; }
	}
	return 0;
}

stock IsMissionReady(ID)
{
	if(MissionInfo[ID][StartX] == 0.0 && MissionInfo[ID][StartY] == 0 && MissionInfo[ID][StartZ] == 0)
	{
	    return 0;
	}
	if(MissionInfo[ID][EndX] == 0.0 && MissionInfo[ID][EndY] == 0.0 && MissionInfo[ID][EndZ] == 0.0)
	{
	    return 0;
	}
	if(MissionInfo[ID][TruckModel] == 0 || (MissionInfo[ID][UseTrailer] == 1 && MissionInfo[ID][TrailerModel] == 0) || MissionInfo[ID][CpSize] == 0)
	{
	    return 0;
	}
	return 1;
}

forward MissionTimer(playerid, MissionID);
public MissionTimer(playerid, MissionID)
{
    GameTextForPlayer(playerid, "~r~Time is up", 5000, 3);
	TruckmissionPlaying[playerid] = 0;
	MissionInfo[MissionID][IsGettingPlayed] = 0;
 	MissionInfo[MissionID][TickcountBeforeStart] = 0;
	DisablePlayerCheckpoint(playerid);
 	SendClientMessage(playerid, COLOR_RED, "You failed the Truckmission!");
	SetVehicleToRespawn(Truck[MissionID]);
	if(MissionInfo[MissionID][UseTrailer] == 1)
	{
		DestroyVehicle(Trailer[MissionID]);
	}
}
