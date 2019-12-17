/*
Stock Exchange 0.1 by NtCat
Feel free to edit the code, just do NOT release as your own and don´t forget to change text in client messages. Thanks.
*/
#include <a_samp>
#define FILTERSCRIPT
//---DCMD---|
#define dcmd(%1,%2,%3) if((strcmp((%3)[1],#%1,true,(%2))==0)&&((((%3)[(%2)+1]==0)&&(dcmd_%1(playerid,"")))||(((%3)[(%2)+1]==32)&&(dcmd_%1(playerid,(%3)[(%2)+2]))))) return 1
//---COLORS---|
#define COL_WHITE 		0xFFFFFFFF
#define COL_RED  		0xFF0000FF
#define COL_GREEN		0x00A000FF
//-----------------------------------------------------------------------------|
enum SE_PLAYER_INFO
{
	Gold,
	Oil
}

enum SE_GLOBAL_INFO
{
	FreeGold,
	FreeOil,
	GoldPrice,
	OilPrice,
}

new se_player[MAX_PLAYERS][SE_PLAYER_INFO];
new se_global[SE_GLOBAL_INFO];
new se_pickup;
new se_timer;
new Menu:se_main_menu;
new Menu:se_gold_menu;
new Menu:se_oil_menu;
new Menu:se_goldbuy_menu;
new Menu:se_goldsell_menu;
new Menu:se_oilbuy_menu;
new Menu:se_oilsell_menu;
// Pickup coords, do NOT forget to change!
#define	SE_COORD_X      0.0
#define	SE_COORD_Y      0.0
#define	SE_COORD_Z      0.0

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" 	 Stock Exchange 0.1b by NtCat      ");
	print("--------------------------------------\n");
	se_pickup = CreatePickup(1274, 23, SE_COORD_X, SE_COORD_Z, SE_COORD_Z);
	se_global[GoldPrice] = 15 + random(10);
	se_global[OilPrice] = 50 + random(80);
	se_global[FreeGold] = 1000 + random(3000) + random(2000);
	se_global[FreeOil] = 1000 + random(3000) + random(2000);
	se_main_menu = CreateMenu("~r~S~w~tock ~r~E~w~xchange", 2, 50.0, 180.0, 200.0, 200.0);
	if (IsValidMenu(se_main_menu))
	{
		SetMenuColumnHeader(se_main_menu, 0, "Commodity:");
		SetMenuColumnHeader(se_main_menu, 1, "Free units:");
		AddMenuItem(se_main_menu, 0, "Gold");
		AddMenuItem(se_main_menu, 1, se_global[FreeGold]);
		AddMenuItem(se_main_menu, 0, "Oil");
		AddMenuItem(se_main_menu, 1, se_global[FreeOil]);
		AddMenuItem(se_main_menu, 0, "Quit menu");
	}
	se_gold_menu = CreateMenu("~r~G~w~old", 1, 50.0, 180.0, 200.0, 200.0);
	if (IsValidMenu(se_gold_menu))
	{
		AddMenuItem(se_gold_menu, 0, "Buy");
		AddMenuItem(se_gold_menu, 0, "Sell");
	}
	se_goldbuy_menu = CreateMenu("~r~B~w~uy gold", 1, 50.0, 180.0, 200.0, 200.0);
	if (IsValidMenu(se_goldbuy_menu))
	{
		AddMenuItem(se_goldbuy_menu, 0, "1 gram");
		AddMenuItem(se_goldbuy_menu, 0, "5 grams");
		AddMenuItem(se_goldbuy_menu, 0, "10 grams");
		AddMenuItem(se_goldbuy_menu, 0, "100 grams");
	}
	se_goldsell_menu = CreateMenu("~r~S~w~ell gold", 1, 50.0, 180.0, 200.0, 200.0);
	if (IsValidMenu(se_goldsell_menu))
	{
		AddMenuItem(se_goldsell_menu, 0, "1 gram");
		AddMenuItem(se_goldsell_menu, 0, "5 grams");
		AddMenuItem(se_goldsell_menu, 0, "10 grams");
		AddMenuItem(se_goldsell_menu, 0, "100 grams");
	}
    se_oil_menu = CreateMenu("~r~O~w~il", 1, 50.0, 180.0, 200.0, 200.0);
	if (IsValidMenu(se_oil_menu))
	{
		AddMenuItem(se_oil_menu, 0, "Buy");
		AddMenuItem(se_oil_menu, 0, "Sell");
	}
	se_oilbuy_menu = CreateMenu("~r~B~w~uy oil", 1, 50.0, 180.0, 200.0, 200.0);
	if (IsValidMenu(se_oilbuy_menu))
	{
		AddMenuItem(se_oilbuy_menu, 0, "1 barrel");
		AddMenuItem(se_oilbuy_menu, 0, "5 barrels");
		AddMenuItem(se_oilbuy_menu, 0, "10 barrels");
		AddMenuItem(se_oilbuy_menu, 0, "100 barrels");
	}
	se_oilsell_menu = CreateMenu("~r~S~w~ell gold", 1, 50.0, 180.0, 200.0, 200.0);
	if (IsValidMenu(se_oilsell_menu))
	{
		AddMenuItem(se_oilsell_menu, 0, "1 barrel");
		AddMenuItem(se_oilsell_menu, 0, "5 barrels");
		AddMenuItem(se_oilsell_menu, 0, "10 barrels");
		AddMenuItem(se_oilsell_menu, 0, "100 barrels");
	}
	se_timer = SetTimer("PriceChange", 600000, 1);
	return 1;
}

public OnFilterScriptExit()
{
	DestroyPickup(se_pickup);
	KillTimer(se_timer);
	return 1;
}

forward PriceChange();
public PriceChange()
{
	new goldchange = random(9);
	switch(goldchange)
	{
		case 0,2,4,6,8:
		{
		    goldchange = random(5);
		    se_global[GoldPrice] += goldchange;
		}
		default:
		{
		    goldchange = random(5);
		    se_global[GoldPrice] -= goldchange;
		}
	}
	new oilchange = random(9);
	switch(oilchange)
	{
		case 0,2,4,6,8:
		{
		    oilchange = random(5);
		    se_global[OilPrice] += goldchange;
		}
		default:
		{
		    oilchange = random(5);
		    se_global[OilPrice] -= goldchange;
		}
	}
	SendClientMessageToAll(COL_RED, "Prices at Stock Exchange have changed, new prices at /stockinfo.");
	return 1;
}

public OnPlayerConnect(playerid)
{
	se_player[playerid][Gold] = 0;
	se_player[playerid][Oil] = 0;
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (IsPlayerConnected(playerid))
	{
	    dcmd(stockinfo, 9, cmdtext);
	}
	return 0;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(pickupid == se_pickup) ShowMenuForPlayer(se_main_menu, playerid);
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	new Menu:C = GetPlayerMenu(playerid);
	if (C == se_main_menu)
	{
	    switch(row)
	    {
	        case 0: ShowMenuForPlayer(se_gold_menu, playerid);
	        case 1: ShowMenuForPlayer(se_oil_menu, playerid);
	        case 2: HideMenuForPlayer(C, playerid);
		}
	}
	else if (C == se_gold_menu)
	{
	    switch(row)
	    {
	        case 0: ShowMenuForPlayer(se_goldbuy_menu, playerid);
	        case 1: ShowMenuForPlayer(se_goldsell_menu, playerid);
		}
	}
	else if (C == se_goldbuy_menu)
	{
	    switch(row)
	    {
	        case 0:
	        {
	            if (GetPlayerMoney(playerid) < se_global[GoldPrice]) SendClientMessage(playerid, COL_RED, "Sorry, but you haven´t got enough money for this item.");
				else if(se_global[FreeGold] < 1) SendClientMessage(playerid, COL_RED, "Sorry, there is not any free gold in the stock exchange.");
				else
				{
				    se_global[FreeGold]--;
				    se_player[playerid][Gold]++;
				    GivePlayerMoney(playerid, -se_global[GoldPrice]);
					new string[200];
					format(string, sizeof(string), "You have successfully bought 1 gram of gold for %d $.", se_global[GoldPrice]);
					SendClientMessage(playerid, COL_GREEN, string);
				}
			}
			case 1:
	        {
	            if (GetPlayerMoney(playerid) < se_global[GoldPrice]*5) SendClientMessage(playerid, COL_RED, "Sorry, but you haven´t got enough money for this item.");
				else if(se_global[FreeGold] < 5) SendClientMessage(playerid, COL_RED, "Sorry, there is not any free gold in the stock exchange.");
				else
				{
				    se_global[FreeGold] -= 5;
				    se_player[playerid][Gold] += 5;
				    GivePlayerMoney(playerid, -se_global[GoldPrice]*5);
					new string[200];
					format(string, sizeof(string), "You have successfully bought 5 grams of gold for %d $.", se_global[GoldPrice]*5);
					SendClientMessage(playerid, COL_GREEN, string);
				}
			}
			case 2:
	        {
	            if (GetPlayerMoney(playerid) < se_global[GoldPrice]*10) SendClientMessage(playerid, COL_RED, "Sorry, but you haven´t got enough money for this item.");
				else if(se_global[FreeGold] < 10) SendClientMessage(playerid, COL_RED, "Sorry, there is not any free gold in the stock exchange.");
				else
				{
				    se_global[FreeGold] -= 10;
				    se_player[playerid][Gold] += 10;
				    GivePlayerMoney(playerid, -se_global[GoldPrice]*10);
					new string[200];
					format(string, sizeof(string), "You have successfully bought 10 grams of gold for %d $.", se_global[GoldPrice]*10);
					SendClientMessage(playerid, COL_GREEN, string);
				}
			}
			case 3:
	        {
	            if (GetPlayerMoney(playerid) < se_global[GoldPrice]*100) SendClientMessage(playerid, COL_RED, "Sorry, but you haven´t got enough money for this item.");
				else if(se_global[FreeGold] < 100) SendClientMessage(playerid, COL_RED, "Sorry, there is not any free gold in the stock exchange.");
				else
				{
				    se_global[FreeGold] -= 100;
				    se_player[playerid][Gold] += 100;
				    GivePlayerMoney(playerid, -se_global[GoldPrice]*100);
					new string[200];
					format(string, sizeof(string), "You have successfully bought 100 grams of gold for %d $.", se_global[GoldPrice]*100);
					SendClientMessage(playerid, COL_GREEN, string);
				}
			}
		}
	}
	else if (C == se_goldsell_menu)
	{
	    switch(row)
	    {
	        case 0:
	        {
				if(se_player[playerid][Gold] < 1) SendClientMessage(playerid, COL_RED, "You don´t have so much gold.");
				else
				{
				    se_global[FreeGold]++;
				    se_player[playerid][Gold]--;
				    GivePlayerMoney(playerid, se_global[GoldPrice]);
					new string[200];
					format(string, sizeof(string), "You have successfully sold 1 gram of gold for %d $.", se_global[GoldPrice]);
					SendClientMessage(playerid, COL_GREEN, string);
				}
			}
			case 1:
	        {
				if(se_player[playerid][Gold] < 5) SendClientMessage(playerid, COL_RED, "You don´t have so much gold.");
				else
				{
				    se_global[FreeGold] += 5;
				    se_player[playerid][Gold] -= 5;
				    GivePlayerMoney(playerid, se_global[GoldPrice]*5);
					new string[200];
					format(string, sizeof(string), "You have successfully sold 5 grams of gold for %d $.", se_global[GoldPrice]*5);
					SendClientMessage(playerid, COL_GREEN, string);
				}
			}
			case 2:
	        {
	            if(se_player[playerid][Gold] < 10) SendClientMessage(playerid, COL_RED, "You don´t have so much gold.");
				else
				{
				    se_global[FreeGold] += 10;
				    se_player[playerid][Gold] -= 10;
				    GivePlayerMoney(playerid, se_global[GoldPrice]*10);
					new string[200];
					format(string, sizeof(string), "You have successfully sold 10 grams of gold for %d $.", se_global[GoldPrice]*10);
					SendClientMessage(playerid, COL_GREEN, string);
				}
			}
			case 3:
	        {
	            if(se_global[FreeGold] < 100) SendClientMessage(playerid, COL_RED, "You don´t have so much gold.");
				else
				{
				    se_global[FreeGold] += 100;
				    se_player[playerid][Gold] -= 100;
				    GivePlayerMoney(playerid, se_global[GoldPrice]*100);
					new string[200];
					format(string, sizeof(string), "You have successfully sold 100 grams of gold for %d $.", se_global[GoldPrice]*100);
					SendClientMessage(playerid, COL_GREEN, string);
				}
			}
		}
	}
	else if (C == se_oil_menu)
	{
	    switch(row)
	    {
	        case 0: ShowMenuForPlayer(se_oilbuy_menu, playerid);
	        case 1: ShowMenuForPlayer(se_oilsell_menu, playerid);
		}
	}
	else if (C == se_oilbuy_menu)
	{
	    switch(row)
	    {
	        case 0:
	        {
	            if (GetPlayerMoney(playerid) < se_global[OilPrice]) SendClientMessage(playerid, COL_RED, "Sorry, but you haven´t got enough money for this item.");
				else if(se_global[FreeOil] < 1) SendClientMessage(playerid, COL_RED, "Sorry, there is not any free oil in the stock exchange.");
				else
				{
				    se_global[FreeOil]--;
				    se_player[playerid][Oil]++;
				    GivePlayerMoney(playerid, -se_global[OilPrice]);
					new string[200];
					format(string, sizeof(string), "You have successfully bought 1 barrel of oil for %d $.", se_global[OilPrice]);
					SendClientMessage(playerid, COL_GREEN, string);
				}
			}
			case 1:
	        {
	            if (GetPlayerMoney(playerid) < se_global[OilPrice]*5) SendClientMessage(playerid, COL_RED, "Sorry, but you haven´t got enough money for this item.");
				else if(se_global[FreeOil] < 5) SendClientMessage(playerid, COL_RED, "Sorry, there is not any free oil in the stock exchange.");
				else
				{
				    se_global[FreeOil] -= 5;
				    se_player[playerid][Oil] += 5;
				    GivePlayerMoney(playerid, -se_global[OilPrice]*5);
					new string[200];
					format(string, sizeof(string), "You have successfully bought 5 barrels of oil for %d $.", se_global[OilPrice]*5);
					SendClientMessage(playerid, COL_GREEN, string);
				}
			}
			case 2:
	        {
	            if (GetPlayerMoney(playerid) < se_global[OilPrice]*10) SendClientMessage(playerid, COL_RED, "Sorry, but you haven´t got enough money for this item.");
				else if(se_global[FreeOil] < 10) SendClientMessage(playerid, COL_RED, "Sorry, there is not any free oil in the stock exchange.");
				else
				{
				    se_global[FreeOil] -= 10;
				    se_player[playerid][Oil] += 10;
				    GivePlayerMoney(playerid, -se_global[OilPrice]*10);
					new string[200];
					format(string, sizeof(string), "You have successfully bought 10 barrels of oil for %d $.", se_global[OilPrice]*10);
					SendClientMessage(playerid, COL_GREEN, string);
				}
			}
			case 3:
	        {
	            if (GetPlayerMoney(playerid) < se_global[OilPrice]*100) SendClientMessage(playerid, COL_RED, "Sorry, but you haven´t got enough money for this item.");
				else if(se_global[FreeOil] < 100) SendClientMessage(playerid, COL_RED, "Sorry, there is not any free oil in the stock exchange.");
				else
				{
				    se_global[FreeOil] -= 100;
				    se_player[playerid][Oil] += 100;
				    GivePlayerMoney(playerid, -se_global[OilPrice]*100);
					new string[200];
					format(string, sizeof(string), "You have successfully bought 100 barrels of oil for %d $.", se_global[OilPrice]*100);
					SendClientMessage(playerid, COL_GREEN, string);
				}
			}
		}
	}
	else if (C == se_oilsell_menu)
	{
	    switch(row)
	    {
	        case 0:
	        {
				if(se_player[playerid][Oil] < 1) SendClientMessage(playerid, COL_RED, "You don´t have so much oil.");
				else
				{
				    se_global[FreeOil]++;
				    se_player[playerid][Oil]--;
				    GivePlayerMoney(playerid, se_global[OilPrice]);
					new string[200];
					format(string, sizeof(string), "You have successfully sold 1 barrel of oil for %d $.", se_global[OilPrice]);
					SendClientMessage(playerid, COL_GREEN, string);
				}
			}
			case 1:
	        {
				if(se_player[playerid][Oil] < 5) SendClientMessage(playerid, COL_RED, "You don´t have so much oil.");
				else
				{
				    se_global[FreeOil] += 5;
				    se_player[playerid][Oil] -= 5;
				    GivePlayerMoney(playerid, se_global[OilPrice]*5);
					new string[200];
					format(string, sizeof(string), "You have successfully sold 5 barrels of oil for %d $.", se_global[OilPrice]*5);
					SendClientMessage(playerid, COL_GREEN, string);
				}
			}
			case 2:
	        {
	            if(se_player[playerid][Oil] < 10) SendClientMessage(playerid, COL_RED, "You don´t have so much oil.");
				else
				{
				    se_global[FreeGold] += 10;
				    se_player[playerid][Oil] -= 10;
				    GivePlayerMoney(playerid, se_global[OilPrice]*10);
					new string[200];
					format(string, sizeof(string), "You have successfully sold 10 barrels of oil for %d $.", se_global[OilPrice]*10);
					SendClientMessage(playerid, COL_GREEN, string);
				}
			}
			case 3:
	        {
	            if(se_player[playerid][Oil] < 100) SendClientMessage(playerid, COL_RED, "You don´t have so much oil.");
				else
				{
				    se_global[FreeGold] += 100;
				    se_player[playerid][Oil] -= 100;
				    GivePlayerMoney(playerid, se_global[OilPrice]*100);
					new string[200];
					format(string, sizeof(string), "You have successfully sold 100 barrels of oil for %d $.", se_global[OilPrice]*100);
					SendClientMessage(playerid, COL_GREEN, string);
				}
			}
		}
	}
	return 1;
}
//-----------------------------------------------------------------------------|
dcmd_stockinfo(playerid, params[])
{
	#pragma unused params
	if (IsPlayerConnected(playerid))
	{
	    SendClientMessage(playerid, COL_RED, "Stock Exchange Info");
	    SendClientMessage(playerid, COL_WHITE, "You can find stock exchange at XYZ."); // Edit text
	    SendClientMessage(playerid, COL_RED, "Actual prices:");
	    new string[100];
	    format(string, sizeof(string), "Gold: %d USD/gram, actually free: %d grams.", se_global[GoldPrice], se_global[FreeGold]);
	    SendClientMessage(playerid, COL_WHITE, string);
	    format(string, sizeof(string), "Oil: %d USD/barrel, actually free: %d barrels.", se_global[OilPrice], se_global[FreeOil]);
	    SendClientMessage(playerid, COL_WHITE, string);
	}
	return 1;
}