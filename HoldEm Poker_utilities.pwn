/*

		_________               .__
		\_   ___ \_____    _____|__| ____   ____
		/    \  \/\__  \  /  ___/  |/    \ /  _ \
		\     \____/ __ \_\___ \|  |   |  (  <_> )
		 \______  (____  /____  >__|___|  /\____/
		        \/     \/     \/        \/
		  ________
		 /  _____/_____    _____   ____   ______
		/   \  ___\__  \  /     \_/ __ \ /  ___/
		\    \_\  \/ __ \|  Y Y  \  ___/ \___ \
		 \______  (____  /__|_|  /\___  >____  >
		        \/     \/      \/     \/     \/

						Utilities

		  Developed By Dan 'GhoulSlayeR' Reed
			     mrdanreed@gmail.com

===========================================================
This software was written for the sole purpose to not be
destributed without written permission from the software
developer.

Changelog:

1.0.0 - Inital Release

Readme:

This is a open-source filterscript that is designed to be
used with other gcasino game modules. The purpose is to
convert whatever your gamemode's currency into 'chips'
that the modules uses.

IE. You may use this filterscript to disable any chip
payout to make the casino games simply "for fun".

It's recommended for experienced scripters to load
the content of this filterscript into their gamemode,
however you can still compile and use this filterscript
if you so desire.

PVar-
"cgChips" - The player variable that is holding the number
of chips the player is holding. You may want to save this
variable within your gamemode.

===========================================================


*/

#include <a_samp>
#include <zcmd>
#include <sscanf2>

// Colors
#define COLOR_WHITE 						0xFFFFFFAA
#define COLOR_GOLD 							0xFFCC00AA

// Dialogs
#define DIALOG_CMACHINEADMINMENU			32200
#define DIALOG_CMACHINESSELECT				32201
#define DIALOG_CMACHINESSETUP				32202
#define DIALOG_CMACHINEBUYSELLCHIPS			32203
#define DIALOG_CMACHINEBUYCHIPS				32204
#define DIALOG_CMACHINESELLCHIPS			32205

// Objects
#define OBJ_CHIP_MACHINE					962

// Chip Machine
#define MAX_CHIPMACHINES 					10
#define DRAWDISTANCE_CHIP_MACHINE			150.0
#define DRAWDISTANCE_CHIP_MACHINE_MISC		50.0

enum cmInfo
{
	cmPlaced,
	cmObjectID,
	Text3D:cmText3DID,
	Float:cmX,
	Float:cmY,
	Float:cmZ,
	Float:cmRX,
	Float:cmRY,
	Float:cmRZ,
	cmInt,
	cmVW,
};
new ChipMachine[MAX_CHIPMACHINES][cmInfo];


public OnFilterScriptInit()
{
	print("\n");
	print("========================================");
	printf("gCasino Games (Utilities)");
	print("Developed By: Dan 'GhoulSlayeR' Reed");
	print("========================================");
	print("\n");

	InitChipMachines();

	return 1;
}

//------------------------------------------------

GlobalPlaySound(soundid, Float:x, Float:y, Float:z)
{
	for(new i = 0; i < GetMaxPlayers(); i++) {
		if(IsPlayerInRangeOfPoint(i, 25.0, x, y, z)) {
			PlayerPlaySound(i, soundid, x, y, z);
		}
	}
}

forward split(const strsrc[], strdest[][], delimiter);
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

// Returns the exact amount of chips.
GetChipAmount(playerid)
{
	return GetPVarInt(playerid, "cgChips");
}

// Returns the exact amount of currency.
// You may wish to convert this to your gamemode's currency pvar.
GetCurrencyAmount(playerid)
{
	return GetPlayerMoney(playerid);

	// or IE:
	// return GetPVarInt(playerid, "pCash");
}

// Returns 0 if unable to buy chips, 1 if successful.
// Be sure to adjust to your gamemode's currency pvar.
BuyChips(playerid, amount)
{
	new currencyAmount = GetCurrencyAmount(playerid);

	if(currencyAmount >= amount) {

		SetPVarInt(playerid, "cgChips", GetChipAmount(playerid)+amount);
		GivePlayerMoney(playerid, -amount);

		// or IE:
		// currencyAmount -= amount;
		// SetPVarInt(playerid, "pCash", currencyAmount);
		// SetPVarInt(playerid, "cgChips", GetChipAmount(playerid)+amount);

		return 1;
	}
	return 0;
}

// Returns 0 if unable to sell chips, 1 if successful.
// Be sure to adjust to your gamemode's currency pvar.
SellChips(playerid, amount)
{
	if(GetPVarInt(playerid, "cgChips") >= amount) {
		SetPVarInt(playerid, "cgChips", GetPVarInt(playerid, "cgChips")-amount);
		GivePlayerMoney(playerid, amount);

		// or IE:
		// currencyAmount += amount;
		// SetPVarInt(playerid, "pCash", currencyAmount);
		// SetPVarInt(playerid, "cgChips", GetPVarInt(playerid, "cgChips")-amount);

		return 1;
	}
	return 0;
}

InitChipMachines()
{
	for(new i = 0; i < MAX_CHIPMACHINES; i++) {
		ChipMachine[i][cmPlaced] = 0;
		ChipMachine[i][cmObjectID] = 0;
		ChipMachine[i][cmX] = 0.0;
		ChipMachine[i][cmY] = 0.0;
		ChipMachine[i][cmZ] = 0.0;
		ChipMachine[i][cmRX] = 0.0;
		ChipMachine[i][cmRY] = 0.0;
		ChipMachine[i][cmRZ] = 0.0;
		ChipMachine[i][cmInt] = 0;
		ChipMachine[i][cmVW] = 0;
	}

	LoadChipMachines();
}

LoadChipMachines()
{
	new tmpArray[8][64];
	new tmpString[512];
	new File: file = fopen("chipmachines.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(ChipMachine))
		{
			fread(file, tmpString);
			split(tmpString, tmpArray, '|');

			ChipMachine[idx][cmX] = floatstr(tmpArray[0]);
			ChipMachine[idx][cmY] = floatstr(tmpArray[1]);
			ChipMachine[idx][cmZ] = floatstr(tmpArray[2]);
			ChipMachine[idx][cmRX] = floatstr(tmpArray[3]);
			ChipMachine[idx][cmRY] = floatstr(tmpArray[4]);
			ChipMachine[idx][cmRZ] = floatstr(tmpArray[5]);
			ChipMachine[idx][cmInt] = strval(tmpArray[6]);
			ChipMachine[idx][cmVW] = strval(tmpArray[7]);


			if(ChipMachine[idx][cmX] != 0.0) {
				PlaceChipMachine(idx, ChipMachine[idx][cmX], ChipMachine[idx][cmY], ChipMachine[idx][cmZ], ChipMachine[idx][cmRX], ChipMachine[idx][cmRY], ChipMachine[idx][cmRZ], ChipMachine[idx][cmVW], ChipMachine[idx][cmInt]);
			}
			idx++;
		}
		fclose(file);
	}
	return 1;
}

SaveChipMachines()
{
	new idx;
	new File: file;
	while (idx < sizeof(ChipMachine))
	{
		new tmpString[512];
		format(tmpString, sizeof(tmpString), "%f|%f|%f|%f|%f|%f|%d|%d\n",
			ChipMachine[idx][cmX],
			ChipMachine[idx][cmY],
			ChipMachine[idx][cmZ],
			ChipMachine[idx][cmRX],
			ChipMachine[idx][cmRY],
			ChipMachine[idx][cmRZ],
			ChipMachine[idx][cmInt],
			ChipMachine[idx][cmVW]
		);

		if(idx == 0) {
			file = fopen("chipmachines.cfg", io_write);
		} else {
			file = fopen("chipmachines.cfg", io_append);
		}

		fwrite(file, tmpString);
		idx++;
		fclose(file);
	}
	return 1;
}

PlaceChipMachine(machineid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, virtualworld, interior)
{
	ChipMachine[machineid][cmPlaced] = 1;
	ChipMachine[machineid][cmX] = x;
	ChipMachine[machineid][cmY] = y;
	ChipMachine[machineid][cmZ] = z;
	ChipMachine[machineid][cmRX] = rx;
	ChipMachine[machineid][cmRY] = ry;
	ChipMachine[machineid][cmRZ] = rz;
	ChipMachine[machineid][cmVW] = virtualworld;
	ChipMachine[machineid][cmInt] = interior;

	// Create Machine
	ChipMachine[machineid][cmObjectID] = CreateObject(OBJ_CHIP_MACHINE, x, y, z, rx, ry, rz, DRAWDISTANCE_CHIP_MACHINE);

	// Create 3D Text Label
	new szString[64];
	format(szString, sizeof(szString), "Chip Machine %d\n\n/chips", machineid);
	ChipMachine[machineid][cmText3DID] = Create3DTextLabel(szString, COLOR_GOLD, x, y, z+1.3, DRAWDISTANCE_CHIP_MACHINE_MISC, virtualworld, interior);

	SaveChipMachines();

	return machineid;
}

DestroyChipMachine(machineid)
{
	ChipMachine[machineid][cmX] = 0.0;
	ChipMachine[machineid][cmY] = 0.0;
	ChipMachine[machineid][cmZ] = 0.0;
	ChipMachine[machineid][cmRX] = 0.0;
	ChipMachine[machineid][cmRY] = 0.0;
	ChipMachine[machineid][cmRZ] = 0.0;
	ChipMachine[machineid][cmInt] = 0;
	ChipMachine[machineid][cmVW] = 0;

	if(ChipMachine[machineid][cmPlaced] == 1) {
		// Delete Object
		if(IsValidObject(ChipMachine[machineid][cmObjectID])) DestroyObject(ChipMachine[machineid][cmObjectID]);

		// Delete 3D TextDraw
		Delete3DTextLabel(ChipMachine[machineid][cmText3DID]);
	}

	ChipMachine[machineid][cmPlaced] = 0;

	SaveChipMachines();

	return machineid;
}

ShowChipMachinesMenu(playerid, dialogid)
{
	switch(dialogid)
	{
		case DIALOG_CMACHINEBUYSELLCHIPS:
		{
			new szString[256];
			format(szString, sizeof(szString), "{FFFFFF}Buy Chips\t({00FF00}$%d{FFFFFF})\nSell Chips\t({00FF00}%d{FFFFFF})", GetCurrencyAmount(playerid), GetChipAmount(playerid));
			ShowPlayerDialog(playerid, DIALOG_CMACHINEBUYSELLCHIPS, DIALOG_STYLE_LIST, "Chip Machines - (Buy/Sell Chips)", szString, "Select", "Close");
		}
		case DIALOG_CMACHINEBUYCHIPS:
		{
			new szString[256];
			format(szString, sizeof(szString), "{FFFFFF}Please input an amount you wish to purchase:\n\nCurrency: {00FF00}$%d{FFFFFF}\nChips: {00FF00}%d\n\n", GetCurrencyAmount(playerid), GetChipAmount(playerid));
			ShowPlayerDialog(playerid, DIALOG_CMACHINEBUYCHIPS, DIALOG_STYLE_INPUT, "Chip Machines - (Buy Chips)", szString, "Buy Chips", "Back");
		}
		case DIALOG_CMACHINESELLCHIPS:
		{
			new szString[256];
			format(szString, sizeof(szString), "{FFFFFF}Please input an amount you wish to sell:\n\nCurrency: {00FF00}$%d{FFFFFF}\nChips: {00FF00}%d{FFFFFF}\n\n", GetCurrencyAmount(playerid), GetChipAmount(playerid));
			ShowPlayerDialog(playerid, DIALOG_CMACHINESELLCHIPS, DIALOG_STYLE_INPUT, "Chip Machines - (Sell Chips)", szString, "Sell Chips", "Back");
		}
		case DIALOG_CMACHINEADMINMENU:
		{
			return ShowPlayerDialog(playerid, DIALOG_CMACHINEADMINMENU, DIALOG_STYLE_LIST, "{FFFFFF}Chip Machines - (Admin Menu)", "{FFFFFF}Setup Chip Machine...", "Select", "Close");
		}
		case DIALOG_CMACHINESSELECT:
		{
			new szString[1024];
			new szPlaced[64];

			for(new i = 0; i < MAX_CHIPMACHINES; i++) {
				if(ChipMachine[i][cmPlaced] == 1) {	format(szPlaced, sizeof(szPlaced), "{00FF00}Active{FFFFFF}"); }
				if(ChipMachine[i][cmPlaced] == 0) { format(szPlaced, sizeof(szPlaced), "{FF0000}Deactived{FFFFFF}"); }
				format(szString, sizeof(szString), "%sChip Machine %d (%s)\n", szString, i, szPlaced);
			}
			return ShowPlayerDialog(playerid, DIALOG_CMACHINESSELECT, DIALOG_STYLE_LIST, "{FFFFFF}Chip Machines - (Select Machine)", szString, "Select", "Back");
		}
		case DIALOG_CMACHINESSETUP:
		{
			new machineid = GetPVarInt(playerid, "tmpEditChipMachineID")-1;

			if(ChipMachine[machineid][cmPlaced] == 0) {
				return ShowPlayerDialog(playerid, DIALOG_CMACHINESSETUP, DIALOG_STYLE_LIST, "{FFFFFF}Chip Machines - (Select Machine)", "{FFFFFF}Place Machine...", "Select", "Back");
			} else {
				return ShowPlayerDialog(playerid, DIALOG_CMACHINESSETUP, DIALOG_STYLE_LIST, "{FFFFFF}Chip Machines - (Select Machine)", "{FFFFFF}Edit Machine...\nDelete Machine...", "Select", "Back");
			}
		}
	}
	return 1;
}

CMD:chipmachines(playerid, params[])
{
	if(IsPlayerAdmin(playerid)) {
		ShowChipMachinesMenu(playerid, DIALOG_CMACHINEADMINMENU);
	} else {
		SendClientMessage(playerid, COLOR_WHITE, "You are not a rcon admin, you cannot use this command!");
	}
	return 1;
}

CMD:chips(playerid, params[])
{
	for(new i = 0; i < MAX_CHIPMACHINES; i++) {
		if(IsPlayerInRangeOfPoint(playerid, 5.0, ChipMachine[i][cmX], ChipMachine[i][cmY], ChipMachine[i][cmZ])) {
			GlobalPlaySound(6400, ChipMachine[i][cmX], ChipMachine[i][cmY], ChipMachine[i][cmZ]);

			ShowChipMachinesMenu(playerid, DIALOG_CMACHINEBUYSELLCHIPS);
			return 1;
		}
	}
	return SendClientMessage(playerid, COLOR_WHITE, "You are not near a Chip Machine!");
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	if(GetPVarType(playerid, "tmpPlaceChipMachine"))
	{
		new keys, updown, leftright;
		GetPlayerKeys(playerid, keys, updown, leftright);

		if(keys == KEY_SPRINT) {
			DeletePVar(playerid, "tmpPlaceChipMachine");

			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);
			new int = GetPlayerInterior(playerid);
			new vw = GetPlayerVirtualWorld(playerid);

			new machineid = PlaceChipMachine(GetPVarInt(playerid, "tmpEditChipMachineID")-1, x, y, z+2.0, 0.0, 0.0, 0.0, vw, int);

			SetPVarFloat(playerid, "tmpCmX", ChipMachine[machineid][cmX]);
			SetPVarFloat(playerid, "tmpCmY", ChipMachine[machineid][cmY]);
			SetPVarFloat(playerid, "tmpCmZ", ChipMachine[machineid][cmZ]);
			SetPVarFloat(playerid, "tmpCmRX", ChipMachine[machineid][cmRX]);
			SetPVarFloat(playerid, "tmpCmRY", ChipMachine[machineid][cmRY]);
			SetPVarFloat(playerid, "tmpCmRZ", ChipMachine[machineid][cmRZ]);

			EditObject(playerid, ChipMachine[machineid][cmObjectID]);

			new szString[128];
			format(szString, sizeof(szString), "You have placed Chip Machine %d, You may now customize it's position/rotation.", machineid);
			SendClientMessage(playerid, COLOR_WHITE, szString);
		}
	}
	return 1;
}

public OnPlayerSelectObject(playerid, type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
	if(type == SELECT_OBJECT_GLOBAL_OBJECT)
    {
        EditObject(playerid, objectid);
    }
    return 1;
}

public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	SetObjectPos(objectid, fX, fY, fZ);
	SetObjectRot(objectid, fRotX, fRotY, fRotZ);

	if(response == EDIT_RESPONSE_FINAL)
	{
		if(GetPVarType(playerid, "tmpEditChipMachineID")) {
			new machineid = GetPVarInt(playerid, "tmpEditChipMachineID")-1;
			DeletePVar(playerid, "tmpEditChipMachineID");

			DeletePVar(playerid, "tmpCmX");
			DeletePVar(playerid, "tmpCmY");
			DeletePVar(playerid, "tmpCmZ");
			DeletePVar(playerid, "tmpCmRX");
			DeletePVar(playerid, "tmpCmRY");
			DeletePVar(playerid, "tmpCmRZ");

			DestroyChipMachine(machineid);
			PlaceChipMachine(machineid, fX, fY, fZ, fRotX, fRotY, fRotZ, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

			ShowChipMachinesMenu(playerid, DIALOG_CMACHINESSELECT);
		}
	}

	if(response == EDIT_RESPONSE_CANCEL)
	{
		if(GetPVarType(playerid, "tmpEditChipMachineID")) {
			new machineid = GetPVarInt(playerid, "tmpEditChipMachineID")-1;
			DeletePVar(playerid, "tmpEditChipMachineID");

			DestroyChipMachine(machineid);
			PlaceChipMachine(machineid, GetPVarFloat(playerid, "tmpCmX"), GetPVarFloat(playerid, "tmpCmY"), GetPVarFloat(playerid, "tmpCmZ"), GetPVarFloat(playerid, "tmpCmRX"), GetPVarFloat(playerid, "tmpCmRY"), GetPVarFloat(playerid, "tmpCmRZ"), GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

			DeletePVar(playerid, "tmpCmX");
			DeletePVar(playerid, "tmpCmY");
			DeletePVar(playerid, "tmpCmZ");
			DeletePVar(playerid, "tmpCmRX");
			DeletePVar(playerid, "tmpCmRY");
			DeletePVar(playerid, "tmpCmRZ");

			ShowChipMachinesMenu(playerid, DIALOG_CMACHINESSELECT);
		}
	}
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_CMACHINEBUYSELLCHIPS)
	{
		if(response) {
			switch(listitem)
			{
				case 0: // Buy
				{
					ShowChipMachinesMenu(playerid, DIALOG_CMACHINEBUYCHIPS);
				}
				case 1: // Sell
				{
					ShowChipMachinesMenu(playerid, DIALOG_CMACHINESELLCHIPS);
				}
			}
		}
	}
	if(dialogid == DIALOG_CMACHINEBUYCHIPS)
	{
		if(response) {
			if(strval(inputtext) > 0 && strval(inputtext) < 10000000) {
				BuyChips(playerid, strval(inputtext));
			}
			ShowChipMachinesMenu(playerid, DIALOG_CMACHINEBUYCHIPS);
		} else {
			ShowChipMachinesMenu(playerid, DIALOG_CMACHINEBUYSELLCHIPS);
		}
	}
	if(dialogid == DIALOG_CMACHINESELLCHIPS)
	{
		if(response) {
			if(strval(inputtext) > 0 && strval(inputtext) < 10000000) {
				SellChips(playerid, strval(inputtext));
			}
			ShowChipMachinesMenu(playerid, DIALOG_CMACHINESELLCHIPS);
		} else {
			ShowChipMachinesMenu(playerid, DIALOG_CMACHINEBUYSELLCHIPS);
		}
	}
	if(dialogid == DIALOG_CMACHINEADMINMENU)
	{
		if(response) {
			switch(listitem)
			{
				case 0:
				{
					ShowChipMachinesMenu(playerid, DIALOG_CMACHINESSELECT);
				}
			}
		}
	}
	if(dialogid == DIALOG_CMACHINESSELECT)
	{
		if(response) {
			SetPVarInt(playerid, "tmpEditChipMachineID", listitem+1);
			ShowChipMachinesMenu(playerid, DIALOG_CMACHINESSETUP);
		} else {
			ShowChipMachinesMenu(playerid, DIALOG_CMACHINEADMINMENU);
		}
	}
	if(dialogid == DIALOG_CMACHINESSETUP)
	{
		if(response) {
			new machineid = GetPVarInt(playerid, "tmpEditChipMachineID")-1;

			if(ChipMachine[machineid][cmPlaced] == 0) {
				switch(listitem)
				{
					case 0:
					{
						new szString[128];
						format(szString, sizeof(szString), "Press '{3399FF}~k~~PED_SPRINT~{FFFFFF}' to place chip machine.");
						SendClientMessage(playerid, COLOR_WHITE, szString);

						SetPVarInt(playerid, "tmpPlaceChipMachine", 1);
					}
				}
			} else {
				switch(listitem)
				{
					case 0: // Edit Machine
					{
						SetPVarFloat(playerid, "tmpCmX", ChipMachine[machineid][cmX]);
						SetPVarFloat(playerid, "tmpCmY", ChipMachine[machineid][cmY]);
						SetPVarFloat(playerid, "tmpCmZ", ChipMachine[machineid][cmZ]);
						SetPVarFloat(playerid, "tmpCmRX", ChipMachine[machineid][cmRX]);
						SetPVarFloat(playerid, "tmpCmRY", ChipMachine[machineid][cmRY]);
						SetPVarFloat(playerid, "tmpCmRZ", ChipMachine[machineid][cmRZ]);

						EditObject(playerid, ChipMachine[machineid][cmObjectID]);

						new szString[128];
						format(szString, sizeof(szString), "You have selected Chip Machine %d, You may now customize it's position/rotation.", machineid);
						SendClientMessage(playerid, COLOR_WHITE, szString);
					}
					case 1: // Delete Machine
					{
						DestroyChipMachine(machineid);

						new szString[64];
						format(szString, sizeof(szString), "You have deleted Chip Machine %d.", machineid);
						SendClientMessage(playerid, COLOR_WHITE, szString);

						ShowChipMachinesMenu(playerid, DIALOG_CMACHINESSELECT);
					}
				}
			}
		}
	}
	return 0;
}