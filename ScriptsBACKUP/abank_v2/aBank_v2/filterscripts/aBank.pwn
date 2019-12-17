/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Advanced Bank - Grim_

*A script for all your banking needs
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

CREDITS:
Grim_ - Scripting/Coding
[RP]Victor - Using files for locations instead of array
Draco Blue - Dini (Just b/c I was to lazy to work with ini)
??? - Strtok function
---------------------------------------------*/
#include <a_samp>
#include <dini>

#define BANK_LOCATIONS  3

#define USE_3D_TEXT 1

#define BANK_FILE   "aBank/Accounts/%s.cfg"
#define LOC_FILE    "aBank/Locations.txt"
#define LOG_FILE    "aBank/Log.txt"

#define COLOR_GREEN 0x0FBF15FF
#define COLOR_RED   0xFF303EFF

#define BANK        0
#define WITHDRAW    1
#define DEPOSITE    2
#define TRANSFER_1  3
#define TRANSFER_2  4
#define BALANCE     5

public OnFilterScriptInit()
{
	print("------------------------------------");
	print("\n - [ Advanced Bank by Grim_ ] - \n");
	print("------------------------------------");
	#if USE_3D_TEXT == 1
	Load3DText();
	#endif
	if(!dini_Exists(LOG_FILE)) dini_Create(LOG_FILE);
	if(!dini_Exists(LOC_FILE))
	{
	    printf("FATAL ERROR: aBank/Locations.txt file could not be loaded.");
		SendRconCommand("exit");
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp(cmdtext, "/bank", true) == 0)
	{
		if(IsPlayerAtValidBankLocation(playerid))
		{
		    ShowPlayerBankDialog(playerid);
		    return 1;
		}
		SendClientMessage(playerid, COLOR_RED, "Not at a valid banking location!");
		return 1;
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new file[50], name[MAX_PLAYER_NAME], string[128];
	GetPlayerName(playerid, name, sizeof(name));
	format(file, sizeof(file), BANK_FILE, name);

	if(!response) return SendClientMessage(playerid, COLOR_RED, "Error: You have cancelled.");
	if(dialogid == BANK)
	{
	    switch(listitem)
	    {
	        case 0: // Create Account
	        {
				if(dini_Exists(file)) return SendClientMessage(playerid, COLOR_RED, "Error: You already have a bank account!");
				dini_Create(file);
				dini_IntSet(file, "Balance", 0);
				SendClientMessage(playerid, COLOR_GREEN, "Success: Your bank account was created!");
				ShowPlayerBankDialog(playerid);
				format(string, sizeof(string), "%s has created a bank account.", name);
				WriteToFile(LOG_FILE, string);
			}
			case 1: // Delete Account
			{
			    if(!dini_Exists(file)) return SendClientMessage(playerid, COLOR_RED, "Error: You don't have a bank account file to delete!");
			    dini_Remove(file);
			    SendClientMessage(playerid, COLOR_GREEN, "Success: Your bank account was deleted!");
			    ShowPlayerBankDialog(playerid);
			    format(string, sizeof(string), "%s has delete a bank account.", name);
			    WriteToFile(LOG_FILE, string);
			}
			case 2: // Withdraw
			{
			    if(!dini_Exists(file)) return SendClientMessage(playerid, COLOR_RED, "Error: You don't have a bank account.");
				format(string, sizeof(string), "Insert the amount of cash you would like to take from your account.\n Current Balance:%d", dini_Int(file, "Balance"));
				ShowPlayerDialog(playerid, WITHDRAW, DIALOG_STYLE_INPUT, "Advanced Bank - Withdraw", string, "Submit", "Cancel");
			}
			case 3: // Deposite
			{
			    if(!dini_Exists(file)) return SendClientMessage(playerid, COLOR_RED, "Error: You don't have a bank account.");
			    format(string, sizeof(string), "Insert the amount of cash you would like to deposite into your account.\n You currently are holding:%d", GetPlayerMoney(playerid));
			    ShowPlayerDialog(playerid, DEPOSITE, DIALOG_STYLE_INPUT, "Advanced Bank - Deposite", string, "Submit", "Cancel");
			}
			case 4: // Transfer
			{
			    if(!dini_Exists(file)) return SendClientMessage(playerid, COLOR_RED, "Error: You don't have a bank account.");
				ShowPlayerDialog(playerid, TRANSFER_1, DIALOG_STYLE_INPUT, "Advanced Bank - Transfer (Step 1)", "Please insert the name of the player you would like to transfer money to.", "Submit", "Cancel");
			}
			case 5: // Balance
			{
			    if(!dini_Exists(file)) return SendClientMessage(playerid, COLOR_RED, "Error: You don't have a bank account.");
			    format(string, sizeof(string), "Your current bank balance: %d\nYour current held money amount: %d", dini_Int(file, "Balance"), GetPlayerMoney(playerid));
			    ShowPlayerDialog(playerid, BALANCE, DIALOG_STYLE_MSGBOX, "Advanced Bank - Balance", string, "Okay", "Cancel");
			}
		}
	}
	if(dialogid == WITHDRAW)
	{
		if(!strlen(inputtext)) return SendClientMessage(playerid, COLOR_RED, "Error: You didn't enter an amount to withdraw.");
		if(strval(inputtext) > dini_Int(file, "Balance"))
		{
		    SendClientMessage(playerid, COLOR_RED, "Error: You're trying to withdraw more than you have in your account!");
			ShowPlayerBankDialog(playerid);
			return 1;
		}
		dini_IntSet(file, "Balance", dini_Int(file, "Balance")-strval(inputtext));
		GivePlayerMoney(playerid, strval(inputtext));
		format(string, sizeof(string), "Success: You have withdrawn $%d from your bank account.", strval(inputtext));
		SendClientMessage(playerid, COLOR_GREEN, string);
		ShowPlayerBankDialog(playerid);
		format(string, sizeof(string), "%s has withdrawn $%d from their bank account.", name, strval(inputtext));
		WriteToFile(LOG_FILE, string);
	}
	if(dialogid == DEPOSITE)
	{
	    if(!strlen(inputtext)) return SendClientMessage(playerid, COLOR_RED, "Error: You didn't enter an amount to deposite.");
	    if(strval(inputtext) > GetPlayerMoney(playerid))
	    {
	        SendClientMessage(playerid, COLOR_RED, "Error: You're trying to deposte more than you have!");
	        ShowPlayerBankDialog(playerid);
	        return 1;
		}
		dini_IntSet(file, "Balance", dini_Int(file, "Balance")+strval(inputtext));
		GivePlayerMoney(playerid, -strval(inputtext));
		format(string, sizeof(string), "Success: You have deposited $%d into your bank account.", strval(inputtext));
		SendClientMessage(playerid, COLOR_GREEN, string);
		ShowPlayerBankDialog(playerid);
		format(string, sizeof(string), "%s has deposited $%d to their bank account.", name, strval(inputtext));
		WriteToFile(LOG_FILE, string);
	}
	if(dialogid == TRANSFER_1)
	{
	    if(!strlen(inputtext)) return SendClientMessage(playerid, COLOR_RED, "Error: You didn't enter a player name to transfer money to!");
		new file2[50];
		format(file2, sizeof(file2), BANK_FILE, inputtext);
		if(!dini_Exists(file2)) return SendClientMessage(playerid, COLOR_RED, "Error: Invalid name; or the player does not have a bank account.");
		SetPVarString(playerid, "transfer_name", inputtext);
		ShowPlayerDialog(playerid, TRANSFER_2, DIALOG_STYLE_INPUT, "Advanced Bank - Transfer (Step 2)", "Insert the amount of money you would like to transfer:", "Submit", "Cancel");
	}
	if(dialogid == TRANSFER_2)
	{
	    if(!strlen(inputtext))
	    {
	        SendClientMessage(playerid, COLOR_RED, "Error: You didn't enter an amount to send to the player.");
	        SetPVarString(playerid, "transfer_name", " ");
	        ShowPlayerBankDialog(playerid);
	        return 1;
		}
		if(strval(inputtext) > dini_Int(file, "Balance"))
		{
		    SendClientMessage(playerid, COLOR_RED, "Error: You're trying to transfer more money than you have!");
		    SetPVarString(playerid, "transfer_name", " ");
		    ShowPlayerBankDialog(playerid);
		    ShowPlayerBankDialog(playerid);
		    return 1;
		}
		new file2[50], string2[MAX_PLAYER_NAME];
		GetPVarString(playerid, "transfer_name", string2, sizeof(string2));
		format(file2, sizeof(file2), BANK_FILE, string2);
		dini_IntSet(file, "Balance", dini_Int(file, "Balance")-strval(inputtext));
		dini_IntSet(file2, "Balance", dini_Int(file2, "Balance")+strval(inputtext));
		format(string, sizeof(string), "Success: You have transfered $%d to %s's account.", strval(inputtext), string2);
		SendClientMessage(playerid, COLOR_GREEN, string);
		SetPVarString(playerid, "transfer_name", " ");
		ShowPlayerBankDialog(playerid);
		format(string, sizeof(string), "%s has transfered $%d to %s's account.", name, strval(inputtext), string2);
		WriteToFile(LOG_FILE, string);
	}
	if(dialogid == BALANCE)
	{
		ShowPlayerBankDialog(playerid);
	}
	return 1;
}

IsPlayerAtValidBankLocation(playerid)
{
	new tmp[30], Float:Pos[3];
	for(new i = 0; i < BANK_LOCATIONS; i++)
	{
	    format(tmp, sizeof(tmp), "LocationX%d", i);
	    Pos[0] = dini_Float(LOC_FILE, tmp);
	    format(tmp, sizeof(tmp), "LocationY%d", i);
	    Pos[1] = dini_Float(LOC_FILE, tmp);
	    format(tmp, sizeof(tmp), "LocationZ%d", i);
	    Pos[2] = dini_Float(LOC_FILE, tmp);
	    if(IsPlayerInRangeOfPoint(playerid, 10, Pos[0], Pos[1], Pos[2]))
	    {
	        return 1;
		}
	}
	return 0;
}

stock Load3DText()
{
	new tmp[30], Float:Pos[3];
	for(new i = 0; i < BANK_LOCATIONS; i++)
	{
	    format(tmp, sizeof(tmp), "LocationX%d", i);
	    Pos[0] = dini_Float(LOC_FILE, tmp);
	    format(tmp, sizeof(tmp), "LocationY%d", i);
	    Pos[1] = dini_Float(LOC_FILE, tmp);
	    format(tmp, sizeof(tmp), "LocationZ%d", i);
	    Pos[2] = dini_Float(LOC_FILE, tmp);
	    Create3DTextLabel("/bank", COLOR_GREEN, Pos[0], Pos[1], Pos[2], 20, 0, 1);
	}
	return 1;
}

WriteToFile(file[], string[])
{
	new entry[128];
	format(entry, sizeof(entry), "%s\r\n", string);
	new File:hFile = fopen(file, io_append);
	if(hFile)
	{
		fwrite(hFile, entry);
		fclose(hFile);
	}
}

ShowPlayerBankDialog(playerid) ShowPlayerDialog(playerid, BANK, DIALOG_STYLE_LIST, "Advanced Bank - Main Menu", "Create Account\nDelete Account\nWithdraw\nDeposite\nTransfer\nBalance", "Submit", "Cancel");
