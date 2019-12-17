//   	/$$$$$$$$            /$$ /$$                     /$$$$$$$$
//  	| $$_____/          |__/| $$                    |_____ $$
//  	| $$        /$$$$$$  /$$| $$  /$$$$$$   /$$$$$$      /$$/
//  	| $$$$$    |____  $$| $$| $$ /$$__  $$ /$$__  $$    /$$/
//  	| $$__/     /$$$$$$$| $$| $$| $$$$$$$$| $$  \__/   /$$/
//  	| $$       /$$__  $$| $$| $$| $$_____/| $$        /$$/
//  	| $$      |  $$$$$$$| $$| $$|  $$$$$$$| $$       /$$$$$$$$
//  	|__/       \_______/|__/|__/ \_______/|__/      |________/

/*******************************************************************************
*        		      Advance Fish System [AFS] - by FailerZ        	       *
*        				 	       Copyright ©                  		       *
*******************************************************************************/


//================================ [Includes] ==================================
#include          <a_samp>             //Credits to Kalcor/Kye
#include          <zcmd>               //Credits to Zeex
#include          <sscanf2>            //Credits to Y_Less
#include          <foreach>            //Credits to Y_Less
#include          <YSI\y_ini>          //Credits to Y_Less
#include          <streamer>           //Credits to Incognito
//================================ [Defines] ===================================
//Settings
#define          FISHERMEN_PATH       "AFS/Fishermen/%s.ini"
#define          FSHOP_PATH           "AFS/Fishshop.txt"

#define          MAX_FISH_NC          5             //Max fishes a player can carry WITHOUT COOLER (Fish Amount) [Current: 5 fishes]
#define          MAX_FISH_C           15            //Max fishes a player can carry WITH COOLER (Fish Amount) [Current: 15 fishes]
#define          MIN_FISH             5000          //Minimum fish price on sell (Money Value) [Current: 5,000$]
#define          MAX_FISH             10000         //Maximum fish price on sell (Money Value) [Current: 10,000$]
#define          MAX_MONEYBAG         15000         //When a player catch a Moneybag (Money Value) [Current: 15,000$]
#define          AMMO                 75            //When a player catch a Weapon (Ammo Amount) [Current: 75 ammo]
#define          HP_LOST              15.0          //When a player attacked by a Bird (HP Lost) [Current: 15 HP]
#define          COOLER_PRICE         25000         //Fish Cooler price in fish shop (Money Value) [Current: 25,000$]
#define          ICE_TAX              5000          //Ice tax to pay whenever you sell your fishes to the fish shop (Money Value) [Current: 5,000$]
//Colors
#define          COL_GREY             "{8C8C8C}"
#define          COLOR_GREY           0x8C8C8CFF
#define          COL_WHITE            "{FAFAFA}"
#define          COLOR_WHITE          0xFAFAFAFF
#define          COL_ORANGE     	  "{FF6E00}"
#define          COLOR_ORANGE         0xFF6E00FF
#define          COL_RED     	      "{FF0005}"
#define          COLOR_RED            0xFF0005FF
#define          COL_BLUE             "{0087FF}"
#define          COLOR_BLUE           0x0087FFFF
#define          COL_GREEN            "{0FFF00}"
#define          COLOR_GREEN          0x0FFF00FF
#define          COL_PURPLE           "{B400FF}"
#define          COLOR_PURPLE         0xB400FFFF
#define          COL_YELLOW           "{F5FF00}"
#define          COLOR_YELLOW         0xF5FF00FF
#define          COL_BEGE             "{FFA97F}"
#define          COLOR_BEGE           0xFFA97F99
//Dialogs
#define          DIALOG_FHELP         666
#define          DIALOG_AFHELP        655
#define          DIALOG_FINV          677
//Easy Codes
#define          SCM                  SendClientMessage
#define          SCMTA                SendClientMessageToAll
#define 	     function%0(%1) 	  forward%0(%1); public%0(%1)
#define          PRESSED(%0)          (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define          TAG                  "{8C8C8C}[AFS]:{FAFAFA}"
//Others
#define          FILTERSCRIPT
//================================= [Script] ===================================
//Variables & Arrays
new FInv[MAX_PLAYERS], bool:FCooler[MAX_PLAYERS], FTimer[MAX_PLAYERS], FATimer[MAX_PLAYERS], bool:IsFishing[MAX_PLAYERS];
new Text:Progress, Text:Catch[MAX_PLAYERS];
new FishShop, bool:FCreated, Float:FPos[3];
//------------------------------------------------------------------------------
//CallBacks & Functions
public OnFilterScriptInit()
{
	print("----------------------------------------");
	print("| Advance Fish System [AFS] by FailerZ |");
	print("|                Loaded                |");
	print("----------------------------------------");

	FishShop = CreateDynamicCP(0, 0, -1000, 3.0);

	ResetVarsForAll();

	Progress = TextDrawCreate(322.000000, 355.760040, "~g~~h~Fishing ~w~In Progress");
	TextDrawLetterSize(Progress, 0.396000, 1.570133);
	TextDrawAlignment(Progress, 2);
	TextDrawColor(Progress, -1);
	TextDrawSetShadow(Progress, 0);
	TextDrawSetOutline(Progress, 1);
	TextDrawBackgroundColor(Progress, 255);
	TextDrawFont(Progress, 2);
	TextDrawSetProportional(Progress, 1);
	TextDrawSetShadow(Progress, 0);

	foreach(Player, i)
	{
		Catch[i] = TextDrawCreate(320.399993, 198.213333, "~w~Caught A ~g~~h~SomeThing");
		TextDrawLetterSize(Catch[i], 0.396000, 1.570133);
		TextDrawAlignment(Catch[i], 2);
		TextDrawColor(Catch[i], -1);
		TextDrawSetShadow(Catch[i], 0);
		TextDrawSetOutline(Catch[i], 1);
		TextDrawBackgroundColor(Catch[i], 255);
		TextDrawFont(Catch[i], 2);
		TextDrawSetProportional(Catch[i], 1);
		TextDrawSetShadow(Catch[i], 0);

		if(fexist(FisherPath(i)))
		{
			INI_ParseFile(FisherPath(i), "LoadFisher_%s", .bExtra = true, .extra = i);
		}
		else
		{
			new INI:File = INI_Open(FisherPath(i));
			INI_SetTag(File,"data");
        	INI_WriteInt(File,"FInv",0);
        	INI_WriteBool(File,"FCooler",false);
		}
	}

	new File:handle = fopen(FSHOP_PATH, io_read), line[100], Float:RPos[3];
	if(handle)
	{
		while(fread(handle, line))
		{
			if(!sscanf(line, "p<|>fff", RPos[0], RPos[1], RPos[2]))
			{
				FPos[0] = RPos[0];
				FPos[1] = RPos[1];
				FPos[2] = RPos[2];
				FCreated = true;
				FishShop = CreateDynamicCP(RPos[0], RPos[1], RPos[2], 3.0);
				printf("[File] Loaded fish shop at [%f | %f | %f].", RPos[0], RPos[1], RPos[2]);
			}
			else printf("[File] Unable to read from [%s]", FSHOP_PATH);
		}
	}
	else printf("[File] Unable to open [%s]", FSHOP_PATH);
	return 1;
}
//------------------------------------------------------------------------------
public OnFilterScriptExit()
{
	print("----------------------------------------");
	print("| Advance Fish System [AFS] by FailerZ |");
	print("|               UnLoaded               |");
	print("----------------------------------------");

	foreach(Player, i)
	{
		TextDrawDestroy(Catch[i]);

		new INI:File = INI_Open(FisherPath(i));
		INI_SetTag(File,"data");
		INI_WriteInt(File, "FInv", FInv[i]);
		INI_WriteBool(File, "FCooler", FCooler[i]);
		INI_Close(File);
	}

	ResetVarsForAll();

	TextDrawDestroy(Progress);
	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerConnect(playerid)
{
    if(fexist(FisherPath(playerid)))
	{
		INI_ParseFile(FisherPath(playerid), "LoadFisher_%s", .bExtra = true, .extra = playerid);
	}
	else
	{
		new INI:File = INI_Open(FisherPath(playerid));
		INI_SetTag(File,"data");
        INI_WriteInt(File,"FInv",0);
        INI_WriteBool(File,"FCooler",false);
	}

	Catch[playerid] = TextDrawCreate(320.399993, 198.213333, "~w~Caught A ~g~~h~SomeThing");
	TextDrawLetterSize(Catch[playerid], 0.396000, 1.570133);
	TextDrawAlignment(Catch[playerid], 2);
	TextDrawColor(Catch[playerid], -1);
	TextDrawSetShadow(Catch[playerid], 0);
	TextDrawSetOutline(Catch[playerid], 1);
	TextDrawBackgroundColor(Catch[playerid], 255);
	TextDrawFont(Catch[playerid], 2);
	TextDrawSetProportional(Catch[playerid], 1);
	TextDrawSetShadow(Catch[playerid], 0);
	return 1;
}
//------------------------------------------------------------------------------
function LoadFisher_data(playerid,name[],value[])
{
	INI_Int("FInv", FInv[playerid]);
	INI_Bool("FCooler", FCooler[playerid]);
 	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid, reason)
{
	new INI:File = INI_Open(FisherPath(playerid));
	INI_SetTag(File,"data");
	INI_WriteInt(File, "FInv", FInv[playerid]);
	INI_WriteBool(File, "FCooler", FCooler[playerid]);
	INI_Close(File);

	TextDrawDestroy(Catch[playerid]);
	FInv[playerid] = 0;
	IsFishing[playerid] = false;
	KillTimer(FTimer[playerid]);
	KillTimer(FATimer[playerid]);
	FCooler[playerid] = false;
	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerEnterVehicle(playerid, vehicleid)
{
	if(IsVehicleBoat(vehicleid))
	{
	    SCM(playerid, -1, ""TAG" You can fish from this boat. "COL_YELLOW"Type "COL_WHITE"/fishhelp | /fhelp "COL_YELLOW"for more information.");
	}
	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_LOOK_BEHIND) && IsPlayerInBoat(playerid))
	{
	    new randomtime = randomEx(4000, 8000);
	    if(IsFishing[playerid] == true) return SCM(playerid, -1, ""TAG" You are already fishing. "COL_YELLOW"Please wait before fishing again.");
	    if(FInv[playerid] >= MAX_FISH_NC && FCooler[playerid] == false) return SCM(playerid, -1, ""TAG" You cannot carry anymore fishes. "COL_YELLOW"Buy a fish cooler or sell your current fishes.");
	    if(FInv[playerid] >= MAX_FISH_C && FCooler[playerid] == true) return SCM(playerid, -1, ""TAG" You cannot carry anymore fishes. "COL_YELLOW"Sell your current fishes.");
		FTimer[playerid] = SetTimerEx("Fish", randomtime, false, "i", playerid);
		TextDrawShowForPlayer(playerid, Progress);
		IsFishing[playerid] = true;
	}
	return 1;
}
//------------------------------------------------------------------------------
function Fish(playerid)
{
	new result = random(101);
	TextDrawHideForPlayer(playerid, Progress);
	if(result >= 0 && result <= 50) //Caught A Fish (50%)
	{
		SCM(playerid, -1 , ""TAG" You have caught a fish!");
		TextDrawSetString(Catch[playerid], "~w~Caught A ~g~~h~Fish");
		TextDrawShowForPlayer(playerid, Catch[playerid]);
		FInv[playerid] ++;
	}

	if(result > 50 && result <= 75) //Caught Nothing (25%)
	{
        SCM(playerid, -1 , ""TAG" You have failed to catch anything.");
        TextDrawSetString(Catch[playerid], "~w~Caught ~r~Nothing");
		TextDrawShowForPlayer(playerid, Catch[playerid]);
	}

	if(result > 75 && result <= 80) //Caught A Moneybag (5%)
	{
	    new str[128];
	    new rm = random(MAX_MONEYBAG);
        format(str, sizeof(str), ""TAG" You have caught a moneybag and found "COL_YELLOW"%d$ "COL_WHITE"inside of it!", rm);
        SCM(playerid, -1 , str);
        TextDrawSetString(Catch[playerid], "~w~Caught A ~b~~h~Moneybag");
		TextDrawShowForPlayer(playerid, Catch[playerid]);
		GivePlayerMoney(playerid, rm);
	}

	if(result > 80 && result <= 90) //Caught A Weapon (10%)
	{
	    new rw = random(101);
	    if(rw >= 0 && rw <= 40)// (40%)
	    {
        	SCM(playerid, -1 , ""TAG" You have caught a pistol!");
        	TextDrawSetString(Catch[playerid], "~w~Caught A ~y~~h~Weapon");
			TextDrawShowForPlayer(playerid, Catch[playerid]);
			GivePlayerWeapon(playerid, 22, AMMO); //Pistol
		}

  		if(rw > 40 && rw <= 70)// (30%)
	    {
        	SCM(playerid, -1 , ""TAG" You have caught a shotgun!");
        	TextDrawSetString(Catch[playerid], "~w~Caught A ~y~~h~Weapon");
			TextDrawShowForPlayer(playerid, Catch[playerid]);
			GivePlayerWeapon(playerid, 25, AMMO); //Shotgun
		}

		if(rw > 70 && rw <= 90)// (20%)
	    {
        	SCM(playerid, -1 , ""TAG" You have caught a tec9!");
        	TextDrawSetString(Catch[playerid], "~w~Caught A ~y~~h~Weapon");
			TextDrawShowForPlayer(playerid, Catch[playerid]);
			GivePlayerWeapon(playerid, 32, AMMO); //Tec9
		}

		if(rw > 90 && rw <= 100)// (10%)
	    {
        	SCM(playerid, -1 , ""TAG" You have caught a country rifle!");
        	TextDrawSetString(Catch[playerid], "~w~Caught A ~y~~h~Weapon");
			TextDrawShowForPlayer(playerid, Catch[playerid]);
			GivePlayerWeapon(playerid, 33, AMMO); //Country Rifle
		}
	}

	if(result > 90 && result <= 100) //Bird (10%)
	{
	    if(FInv[playerid] <= 0) //Attacked by Bird
	    {
	        SCM(playerid, -1 , ""TAG" You have been attacked by a bird...");
        	TextDrawSetString(Catch[playerid], "~r~Attacked By A ~p~Bird");
			TextDrawShowForPlayer(playerid, Catch[playerid]);

			new Float:hp;
			GetPlayerHealth(playerid, hp);

			if(hp > HP_LOST)
			{
				SetPlayerHealth(playerid, hp-HP_LOST);
			}
			else
			{
			    new str[128], fName[MAX_PLAYER_NAME];
				SetPlayerHealth(playerid, 0);
				GetPlayerName(playerid, fName, sizeof(fName));
				format(str, sizeof(str), ""COL_RED"*** Fisherman %s[%d] has been attacked to death by a bird.", fName, playerid);
				SCMTA(-1, str);
			}
	    }
	    else //Fish Eaten by Bird
	    {
        	SCM(playerid, -1 , ""TAG" One of your fishes has been eaten by a bird...");
        	TextDrawSetString(Catch[playerid], "~r~Fish Eaten By A ~p~Bird");
			TextDrawShowForPlayer(playerid, Catch[playerid]);
			FInv[playerid] --;
		}
	}
	FATimer[playerid] = SetTimerEx("FishAgain", 2500, false, "i", playerid);
	return 1;
}
//------------------------------------------------------------------------------
function FishAgain(playerid)
{
	TextDrawHideForPlayer(playerid, Catch[playerid]);
	IsFishing[playerid] = false;
	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if(checkpointid == FishShop && playerid != INVALID_PLAYER_ID && !IsPlayerInAnyVehicle(playerid))
	{
		SCM(playerid, -1, ""TAG" Welcome to Fish Shop. "COL_YELLOW"Check "COL_WHITE"/fishhelp | /fhelp "COL_YELLOW"for commands.");
	}
	return 1;
}
//================================= [Commands] =================================
//Player Commands
//------------------------------------------------------------------------------
CMD:fishhelp(playerid)
{
	new string[1200];
	strcat(string, ""COL_BEGE"Type "COL_WHITE"/fish "COL_BEGE"or Press "COL_WHITE"Number 2 "COL_BEGE"-> Inside a boat to start fishing.\n");
	strcat(string, ""COL_BEGE"Type "COL_WHITE"/fishinventory | /finv "COL_BEGE"-> To open your fish inventory.\n");
	strcat(string, ""COL_BEGE"Type "COL_WHITE"/fishdrop | /fdrop "COL_BEGE"-> To drop one of your fishes.\n");
	strcat(string, ""COL_BEGE"Type "COL_WHITE"/fishdropall | /fdropall "COL_BEGE"-> To drop all of your fishes.\n");
	strcat(string, ""COL_BEGE"Type "COL_WHITE"/fishsellall | /fsellall "COL_BEGE"-> Inside a fish shop to sell all of your fishes.\n");
	strcat(string, ""COL_BEGE"Type "COL_WHITE"/buycooler "COL_BEGE"-> Inside a fish shop to buy a fish cooler.\n");
    strcat(string, ""COL_BEGE"Type "COL_WHITE"/discardcooler | /dcooler "COL_BEGE"-> To discard your cooler "COL_RED"(Warning: You will lose all of the fishes in the cooler 'if you have').\n");
	ShowPlayerDialog(playerid, DIALOG_FHELP, DIALOG_STYLE_MSGBOX, ""COL_GREY"Fish Help", string, "X", "");
	return 1;
}

CMD:fhelp(playerid)
{
	return cmd_fishhelp(playerid);
}
//------------------------------------------------------------------------------
CMD:fish(playerid)
{
	if(IsPlayerInBoat(playerid))
	{
	    new randomtime = randomEx(4000, 8000);
	    if(IsFishing[playerid] == true) return SCM(playerid, -1, ""TAG" You are already fishing. "COL_YELLOW"Please wait before fishing again.");
	    if(FInv[playerid] >= MAX_FISH_NC && FCooler[playerid] == false) return SCM(playerid, -1, ""TAG" You cannot carry anymore fishes. "COL_YELLOW"Buy a fish cooler or sell your current fishes.");
	    if(FInv[playerid] >= MAX_FISH_C && FCooler[playerid] == true) return SCM(playerid, -1, ""TAG" You cannot carry anymore fishes. "COL_YELLOW"Sell your current fishes.");
		FTimer[playerid] = SetTimerEx("Fish", randomtime, false, "i", playerid);
		TextDrawShowForPlayer(playerid, Progress);
		IsFishing[playerid] = true;
	}
	else return SCM(playerid, -1, ""TAG" You must be in a boat to fish.");
	return 1;
}
//------------------------------------------------------------------------------
CMD:fishinventory(playerid)
{
	new string[100];
	if(FCooler[playerid] == false)
	{
		format(string, sizeof(string), ""COL_BEGE"Fishes: "COL_WHITE"%d/%d\n"COL_BEGE"Fish Cooler: "COL_RED"NO", FInv[playerid], MAX_FISH_NC);
	}
	if(FCooler[playerid] == true)
	{
	    format(string, sizeof(string), ""COL_BEGE"Fishes: "COL_WHITE"%d/%d\n"COL_BEGE"Fish Cooler: "COL_GREEN"YES", FInv[playerid], MAX_FISH_C);
	}
	return ShowPlayerDialog(playerid, DIALOG_FINV, DIALOG_STYLE_MSGBOX, ""COL_GREY"Fish Inventory", string, "X", "");
}

CMD:finv(playerid)
{
	return cmd_fishinventory(playerid);
}
//------------------------------------------------------------------------------
CMD:fishdrop(playerid)
{
	if(FInv[playerid] > 0)
	{
	    FInv[playerid] --;
		SCM(playerid, -1, ""TAG" You have dropped a fish into the water.");
	}
	else return SCM(playerid, -1, ""TAG" You don't own any fishes. "COL_YELLOW"Use /fish to start fishing from a boat.");
	return 1;
}

CMD:fdrop(playerid)
{
	return cmd_fishdrop(playerid);
}
//------------------------------------------------------------------------------
CMD:fishdropall(playerid)
{
	if(FInv[playerid] > 0)
	{
	    FInv[playerid] = 0;
		SCM(playerid, -1, ""TAG" You have dropped all your fishes into the water.");
	}
	else return SCM(playerid, -1, ""TAG" You don't own any fishes. "COL_YELLOW"Use /fish to start fishing from a boat.");
	return 1;
}

CMD:fdropall(playerid)
{
	return cmd_fishdropall(playerid);
}
//------------------------------------------------------------------------------
CMD:fishsellall(playerid)
{
	if(!IsPlayerInDynamicCP(playerid, FishShop)) return SCM(playerid, -1, ""TAG" You cannot sell your fishes here. "COL_YELLOW"You must be in the fish shop.");
	if(IsPlayerInAnyVehicle(playerid)) return SCM(playerid, -1, ""TAG" You must be on foot to sell your fishes.");
	if(FInv[playerid] <= 0) return SCM(playerid, -1, ""TAG" You don't have any fish to sell. "COL_YELLOW"Type /fish to start fishing from a boat.");

	new randsell = randomEx(MIN_FISH, MAX_FISH);
	GivePlayerMoney(playerid, randsell*FInv[playerid]);

	new cstr[100], sstr[128];
	new TCash = randsell*FInv[playerid];
	format(cstr, sizeof(cstr), "~w~Sold ~y~~h~%d Fishes ~w~for ~g~%d$", FInv[playerid], TCash);
	format(sstr, sizeof(sstr), ""TAG" Sold "COL_YELLOW"%d "COL_WHITE"fishes for "COL_YELLOW"%d$"COL_WHITE". The shop has paid "COL_YELLOW"%d%$ "COL_WHITE"each.", FInv[playerid], TCash, randsell);
	GameTextForPlayer(playerid, cstr, 4000, 3);
	SCM(playerid, -1, sstr);

	FInv[playerid] = 0;

	if(FCooler[playerid] == true)
	{
		GivePlayerMoney(playerid, -ICE_TAX);
		SCM(playerid, -1, ""TAG" You have paid "COL_YELLOW"5000$ "COL_WHITE"for the fish cooler ice.");
	}
	return 1;
}

CMD:fsellall(playerid)
{
	return cmd_fishsellall(playerid);
}
//------------------------------------------------------------------------------
CMD:buycooler(playerid)
{
	if(!IsPlayerInDynamicCP(playerid, FishShop)) return SCM(playerid, -1, ""TAG" You cannot buy a fish cooler here. "COL_YELLOW"You must be in the fish shop.");
	if(IsPlayerInAnyVehicle(playerid)) return SCM(playerid, -1, ""TAG" You must be on foot to buy a fish cooler.");
	if(FCooler[playerid] == true) return SCM(playerid, -1, ""TAG" You already have a fish cooler.");
	if(GetPlayerMoney(playerid) < COOLER_PRICE) return SCM(playerid, -1, ""TAG" You don't have "COL_YELLOW"25000$ "COL_WHITE"to buy a fish cooler");
	GivePlayerMoney(playerid, -COOLER_PRICE);
	FCooler[playerid] = true;
	GameTextForPlayer(playerid, "~w~Bought A ~g~Fish Cooler", 4000, 3);
	SCM(playerid, -1, ""TAG" You have bought a fish cooler for "COL_YELLOW"25000$"COL_WHITE".");
	return 1;
}
//------------------------------------------------------------------------------
CMD:discardcooler(playerid)
{
	new str[128];
	if(FCooler[playerid] == false) return SCM(playerid, -1, ""TAG" You don't have a fish cooler. "COL_YELLOW"Use "COL_WHITE"/buycooler "COL_YELLOW"to buy a one.");
	if(FInv[playerid] > MAX_FISH_NC)
	{
	    new flost = FInv[playerid] -= 5;
		format(str, sizeof(str), ""TAG" You have discarded your fish cooler and lost "COL_YELLOW"%d "COL_WHITE"fishes along with it.", flost);
		FInv[playerid] = MAX_FISH_NC;
	}
	else
	{
	    format(str, sizeof(str), ""TAG" You have discarded your fish cooler.");
	}
	FCooler[playerid] = false;

	SCM(playerid, -1, str);
	return 1;
}

CMD:dcooler(playerid)
{
	return cmd_discardcooler(playerid);
}
//------------------------------------------------------------------------------
//Admin Commands
//------------------------------------------------------------------------------
CMD:afishhelp(playerid)
{
    if(!IsPlayerAdmin(playerid)) return SCM(playerid, -1, ""TAG" Only rcon admins able to see admin fish help.");
	new string[1000];
	strcat(string, ""COL_BEGE"Type "COL_WHITE"/createfishshop | /cfshop "COL_BEGE"-> To create a fish shop.\n");
	strcat(string, ""COL_BEGE"Type "COL_WHITE"/destroyfishshop | /dfshop "COL_BEGE"-> To destroy a fish shop.\n");
	strcat(string, ""COL_BEGE"Type "COL_WHITE"/gotofishshop | /gfshop "COL_BEGE"-> To teleport to fish shop.\n");
	ShowPlayerDialog(playerid, DIALOG_AFHELP, DIALOG_STYLE_MSGBOX, ""COL_GREY"Admin Fish Help", string, "X", "");
	return 1;
}

CMD:afhelp(playerid)
{
	return cmd_afishhelp(playerid);
}
//------------------------------------------------------------------------------
CMD:createfishshop(playerid)
{
	new Float:Pos[3], str[128];
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, -1, ""TAG" Only rcon admins able to create fish shop.");
	if(IsPlayerInAnyVehicle(playerid)) return SCM(playerid, -1, ""TAG" You must be on foot to create a fish shop.");
	if(FCreated == true) return SCM(playerid, -1, ""TAG" Fish shop already created.");
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	FishShop = CreateDynamicCP(Pos[0], Pos[1], Pos[2], 3.0);
	FCreated = true;
	FPos[0] = Pos[0];
	FPos[1] = Pos[1];
	FPos[2] = Pos[2];
	format(str, sizeof(str), ""TAG" Fish shop created! "COL_YELLOW"[Location = 'scriptfiles/%s']", FSHOP_PATH);
	SCM(playerid, -1, str);

	new File:handle = fopen(FSHOP_PATH, io_write), filestr[250];
	if(handle)
	{
	    format(filestr, sizeof(filestr), "%f|%f|%f", FPos[0], FPos[1], FPos[2]);
	    fwrite(handle, filestr);
	    fclose(handle);
	}
	return 1;
}

CMD:cfshop(playerid)
{
	return cmd_createfishshop(playerid);
}
//------------------------------------------------------------------------------
CMD:destroyfishshop(playerid)
{
    if(!IsPlayerAdmin(playerid)) return SCM(playerid, -1, ""TAG" Only rcon admins able to destroy fish shop.");
	if(!FishShop) return SCM(playerid, -1, ""TAG" Fish shop already destroyed.");
	if(FCreated == false) return SCM(playerid, -1, ""TAG" No fish shop has been created yet. "COL_YELLOW"Type "COL_WHITE"/createfishshop | /cfshop "COL_YELLOW"to create a one.");
	DestroyDynamicCP(FishShop);
	FCreated = false;
	SCM(playerid, -1, ""TAG" Fish shop destroyed!");

	new File:handle = fopen(FSHOP_PATH, io_write);
	if(handle)
	{
	    fwrite(handle, "");
	    fclose(handle);
	}
	return 1;
}

CMD:dfshop(playerid)
{
	return cmd_destroyfishshop(playerid);
}
//------------------------------------------------------------------------------
CMD:gotofishshop(playerid)
{
	new str[128];
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, -1, ""TAG" Only rcon admins able to go to fish shop.");
	if(IsPlayerInAnyVehicle(playerid)) return SCM(playerid, -1, ""TAG" You must be on foot to go to fish shop.");
	if(FCreated == false) return SCM(playerid, -1, ""TAG" No fish shop has been created yet. "COL_YELLOW"Type "COL_WHITE"/createfishshop | /cfshop "COL_YELLOW"to create a one.");
	SetPlayerPos(playerid, FPos[0], FPos[1], FPos[2]);
	format(str, sizeof(str), ""TAG" Teleported to fish shop! "COL_YELLOW"[PosX: %f | PosY:%f | PosY:%f]", FPos[0], FPos[1], FPos[2]);
	SCM(playerid, -1, str);
	return 1;
}

CMD:gfshop(playerid)
{
	return cmd_gotofishshop(playerid);
}
//------------------------------------------------------------------------------
/*CMD:givemefish(playerid) //>> Test Command <<
{
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, -1, ""TAG" Only rcon admins able to give a fish.");
	SCM(playerid, -1, ""TAG" FISH FTW");
	FInv[playerid] ++;
	return 1;
}*/
//================================= [Stocks] ===================================
stock IsPlayerInBoat(playerid)
{
	if(IsPlayerConnected(playerid) && IsPlayerInAnyVehicle(playerid))
	{
		new vID = GetPlayerVehicleID(playerid);
		new vModel = GetVehicleModel(vID);
		if(vModel == 472 || vModel == 473 || vModel == 493 || vModel == 595 || vModel == 484 || vModel == 430 || vModel == 453 || vModel == 452 || vModel == 446 || vModel == 454)
		{
			return 1;
		}
	}
	return 0;
}
//------------------------------------------------------------------------------
stock IsVehicleBoat(vehicleid)
{
    new vModel = GetVehicleModel(vehicleid);
	if(vModel == 472 || vModel == 473 || vModel == 493 || vModel == 595 || vModel == 484 || vModel == 430 || vModel == 453 || vModel == 452 || vModel == 446 || vModel == 454)
	{
		return 1;
	}
	return 0;
}
//------------------------------------------------------------------------------
stock ResetVarsForAll()
{
	foreach(Player, i)
	{
		FInv[i] = 0;
		IsFishing[i] = false;
		KillTimer(FTimer[i]);
		KillTimer(FATimer[i]);
		TextDrawHideForPlayer(i, Catch[i]);
		FCooler[i] = false;
	}
	FCreated = false;
	FPos[0] = 0.0;
	FPos[1] = 0.0;
	FPos[2] = 0.0;
	TextDrawHideForAll(Progress);
	return 1;
}
//------------------------------------------------------------------------------
/* ** Credits to Y_Less ** */
stock randomEx(min, max)
{
    new rand = random(max-min)+min;
    return rand;
}
//------------------------------------------------------------------------------
stock FisherPath(playerid)
{
	new string[128],playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid,playername,sizeof(playername));
	format(string,sizeof(string),FISHERMEN_PATH,playername);
	return string;
}