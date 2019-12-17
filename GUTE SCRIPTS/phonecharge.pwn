/*
Phone System v0.1 by NtCat
Feel free to modify, just do NOT release as your own. Don´t forget to change coordinates (lines ). Thanks.
*/
#include <a_samp>
#define FILTERSCRIPT
//---DCMD---|
#define dcmd(%1,%2,%3) if((strcmp((%3)[1],#%1,true,(%2))==0)&&((((%3)[(%2)+1]==0)&&(dcmd_%1(playerid,"")))||(((%3)[(%2)+1]==32)&&(dcmd_%1(playerid,(%3)[(%2)+2]))))) return 1
//---COLORS---|
#define COL_WHITE 		0xFFFFFFFF
#define COL_RED  		0xFF0000FF
#define COL_GREEN		0x00A000FF
#define COL_ORANGE		0xFF5A00FF
//-----------------------------------------------------------------------------|
//--- Coordinates - change before use! ---|
// Phone shop pickups
#define BUY1_X		0.0
#define BUY1_Y     	0.0
#define BUY1_Z     	0.0

#define BUY2_X		0.0
#define BUY2_Y     	0.0
#define BUY2_Z     	0.0

// Battery charging places pickups
#define CHARGE1_X		0.0
#define CHARGE1_Y    	0.0
#define CHARGE1_Z     	0.0

#define CHARGE2_X		0.0
#define CHARGE2_Y     	0.0
#define CHARGE2_Z     	0.0

// Phone types
#define NONE            0
#define CRYSTAL500		1
#define TITANIUM1000	2
#define ATOMIC8000		3

new Phone[MAX_PLAYERS];
new Float:BatteryLoad[MAX_PLAYERS];
new BatteryTimer;
new buypickup1;
// new buypickup2;
new chargepickup1;
// new chargepickup2;
new Menu:buymenu;
//-----------------------------------------------------------------------------|
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" 	  Phone System v0.1 by NtCat	   ");
	print("--------------------------------------\n");
	buypickup1 = CreatePickup(1274, 23, BUY1_X, BUY1_Y, BUY1_Z); // Phone shop pickup 1
	/* buypickup2 = CreatePickup(1274, 23, BUY2_X, BUY2_Y, BUY2_Z); // Phone shop pickup 2 - uncomment if you want to use*/
	chargepickup1 = CreatePickup(1247, 23, CHARGE1_X, CHARGE1_Y, CHARGE1_Z); // Battery charging place 1
	/* chargepickup2 = CreatePickup(1247, 23, CHARGE2_X, CHARGE2_Y, CHARGE2_Z); // Battery charging place 2 - uncomment if you want to use*/
	BatteryTimer = SetTimer("Battery", 60000, 1);
	buymenu = CreateMenu("~r~P~w~hone ~r~S~w~hop", 2, 50.0, 180.0, 200.0, 200.0);
	if (IsValidMenu(buymenu))
	{
		AddMenuItem(buymenu, 0, "Crystal 500");
		AddMenuItem(buymenu, 1, "300$");
		AddMenuItem(buymenu, 0, "Titanium 1000");
		AddMenuItem(buymenu, 1, "500$");
		AddMenuItem(buymenu, 0, "Atomic 8000");
		AddMenuItem(buymenu, 1, "1000$");
		AddMenuItem(buymenu, 0, "Quit menu");
  	}
	return 1;
}

public OnFilterScriptExit()
{
	KillTimer(BatteryTimer);
	return 1;
}

forward Battery();
public Battery()
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
	    if (IsPlayerConnected(i))
		{
		    switch(Phone[i])
		    {
		        case CRYSTAL500:
		        {
		            if (BatteryLoad[i] == 1)	SendClientMessage(i, COL_RED, "[ 0 ] Your phone battery has run out of power.");
		            BatteryLoad[i]--;
				}
				case TITANIUM1000:
		        {
		            if (BatteryLoad[i] == 0.5)	SendClientMessage(i, COL_RED, "[ 0 ] Your phone battery has run out of power.");
		            BatteryLoad[i] -= 0.5;
				}
				case ATOMIC8000:
		        {
		            if (BatteryLoad[i] == 0.1)	SendClientMessage(i, COL_RED, "[ 0 ] Your phone battery has run out of power.");
		            BatteryLoad[i] -= 0.1;
				}
			}
		}
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	Phone[playerid] = false;
	BatteryLoad[playerid] = 0;
	return 1;
}

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	if (Phone[playerid] == 0) return SendClientMessage(playerid, COL_RED, "You don´t have a mobile phone.");
	else if (BatteryLoad[playerid] == 0.0) return SendClientMessage(playerid, COL_RED, "Your phone battery has run out of power.");
	else if (Phone[recieverid] == 0) return SendClientMessage(playerid, COL_RED, "Sorry, that player doesn´t have a mobile phone.");
	else if (BatteryLoad[recieverid] == 0.0) return SendClientMessage(playerid, COL_RED, "Sorry, that player´s phone battery has run out of power.");
	new string[300];
	format(string, sizeof(string), "[PM to ID %d] %s", recieverid, text);
	SendClientMessage(playerid, COL_ORANGE, string);
	format(string, sizeof(string), "[PM from ID %d] %s", playerid, text);
	SendClientMessage(recieverid, COL_ORANGE, string);
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(phone, 5, cmdtext);
	return 0;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if (pickupid == buypickup1 /* || pickupid == buypickup2 */) ShowMenuForPlayer(buymenu, playerid);
	else if (pickupid == chargepickup1 /* || pickupid == chargepickup2 */)
	{
	    if (Phone[playerid] != NONE)
		{
			BatteryLoad[playerid] = 100;
			SendClientMessage(playerid, COL_GREEN, "[100] Phone battery charged successfuly.");
		}
	}
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	new Menu:C = GetPlayerMenu(playerid);
	if (C == buymenu)
	{
	    switch(row)
	    {
	    case 0:
	    {
	        if (GetPlayerMoney(playerid) < 300) SendClientMessage(playerid, COL_RED, "Sorry, you do not have so much money (300$).");
	        else
	        {
	            Phone[playerid] = CRYSTAL500;
	            BatteryLoad[playerid] = 100;
	            SendClientMessage(playerid, COL_GREEN, "You have successfully bought mobile phone type Crystal 500 for 300$.");
			}
		}
		case 1:
	    {
	        if (GetPlayerMoney(playerid) < 500) SendClientMessage(playerid, COL_RED, "Sorry, you do not have so much money (500$).");
	        else
	        {
	            Phone[playerid] = TITANIUM1000;
	            BatteryLoad[playerid] = 100;
	            SendClientMessage(playerid, COL_GREEN, "You have successfully bought mobile phone type Titanium 1000 for 500$.");
			}
		}
		case 2:
	    {
	        if (GetPlayerMoney(playerid) < 1000) SendClientMessage(playerid, COL_RED, "Sorry, you do not have so much money (1000$).");
	        else
	        {
	            Phone[playerid] = ATOMIC8000;
	            BatteryLoad[playerid] = 100;
	            SendClientMessage(playerid, COL_GREEN, "You have successfully bought mobile phone type Atomic 8000 for 1000$.");
			}
		}
		default: HideMenuForPlayer(C, playerid);
		}
	}
	return 1;
}

dcmd_phone(playerid, params[])
{
	#pragma unused params
	if (IsPlayerConnected(playerid))
	{
	    if (Phone[playerid] == NONE) SendClientMessage(playerid, COL_RED, "You don´t have any mobile phone.");
		else
		{
		    new string[200];
		    switch(Phone[playerid])
		    {
		        case CRYSTAL500:
		        {
					format(string, sizeof(string), "Your mobile phone type: Crystal 500, battery load: %1.f/100.", BatteryLoad[playerid]);
					SendClientMessage(playerid, COL_WHITE, string);
				}
				case TITANIUM1000:
		        {
					format(string, sizeof(string), "Your mobile phone type: Titanium 1000, battery load: %1.f/100.", BatteryLoad[playerid]);
					SendClientMessage(playerid, COL_WHITE, string);
				}
				case ATOMIC8000:
		        {
					format(string, sizeof(string), "Your mobile phone type: Atomic 8000, battery load: %1.f/100.", BatteryLoad[playerid]);
					SendClientMessage(playerid, COL_WHITE, string);
				}
			}
		}
	}
	return 1;
}