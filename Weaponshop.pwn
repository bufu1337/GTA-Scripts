/**************************************************************
*			   		   WeaponShop FS v.1.0                    *
*			                ^^                                *
*    (o )o)                                    (o )o)         *
*  <-- | --> 	      .: By Gertin :.		  <-- | -->       *
*     / \     								     / \          *
***************************************************************/

//================================INCLUDES======================================
#include <a_samp>
#include <zcmd>
#include <dudb>
#include <sscanf2>
//================================DEFINES=======================================
#define RED 0xFF0000AA
#pragma unused ret_memcpy
//================================NEWS==========================================
new Weaps;
new bool:Shop;
//================================COMMANDS======================================
COMMAND:shop(playerid,params[])
{
    if(Shop == true)
    {
		SendClientMessage(playerid,RED,"{33FF00}You've opened the shop.");
		ShowDialog(playerid, 9954);
		return 1;
 	}
 	if(Shop == false)
  	{
		SendClientMessage(playerid,RED,"{33FF00}Shop is closed .");
		return 1;
	}
	return 0;
}
//==============================================================================
COMMAND:ashop(playerid, params[])
{
	if(!IsPlayerAdmin(playerid))return SendClientMessage(playerid,RED,"{FF0000}You need to be rcon admin !");
	ShowDialog(playerid, 9963);
	return 1;
}
//==============================PUBLICS=========================================
public OnFilterScriptInit()
{
	Shop = true;
	printf("===================================================");
	printf("Oh , you loaded me . I'm WeaponShop FilterScript ^^");
	printf("I'm Maked By Gertin !");
	printf("===================================================");
	return 1;
}
//==============================================================================
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(response)
	{
		if(dialogid == 9954)
		{
			if(listitem == 0)
			{
			    new string[256];
				format(string, sizeof(string), "~w~Thanks ~b~For ~p~Using Shop ^^");
				GameTextForPlayer(playerid, string, 7500, 3);
			}
			if(listitem == 1)
			{
				ShowDialog(playerid,9955);
			}
			if(listitem == 2)
			{
				ShowDialog(playerid,9956);
   			}
			if(listitem == 3)
			{
				ShowDialog(playerid,9957);
			}
			if(listitem == 4)
			{
				ShowDialog(playerid,9958);
			}
			if(listitem == 5)
			{
       			ShowDialog(playerid,9959);
			}
			if(listitem == 6)
			{
				ShowDialog(playerid,9960);
			}
			if(listitem == 7)
			{
				ShowDialog(playerid,9961);
			}
			if(listitem == 8)
			{
				ShowDialog(playerid,9962);
			}
		}
	}
	if(dialogid == 9963)
	{
  		new string[256];
	 	new ime[MAX_PLAYER_NAME];
	  	GetPlayerName(playerid, ime, sizeof(ime));
		if(response)
  		{
  			format(string, sizeof(string), "~r~[]Shop]~b~ is turned on by an admin:~y~ %s", ime);
    		GameTextForAll(string,5000,3);
     		Shop = true;
		}
		if(!response)
		{
 			format(string, sizeof(string), "~r~[]Shop]~b~ is turned off by an admin:~y~ %s", ime);
   			GameTextForAll(string,5000,3);
     		Shop = false;
		}
	}
	if(response)
	{
		if(dialogid == 9955)
		{
		    Weaps = strval(inputtext);
		    if(Weaps > 250) return SendClientMessage(playerid, 0x0000D9AA, "{FF0000}Max Ammo is 250 .");
			if(!isNumeric(inputtext)) return SendClientMessage(playerid, 0x0000D9AA, "Only numbers");
			if(GetPlayerMoney(playerid) <= Weaps*50) return SendClientMessage(playerid,RED,"You don´t have so much money!");
			GivePlayerMoney(playerid, -Weaps*50);
			GivePlayerWeapon(playerid, 34, Weaps);
			SendClientMessage(playerid, RED, "{33FF00}Thanks to use shop !{FF9900} You have buy Sniper Rifle !");
		}
	}
	if(response)
	{
		if(dialogid == 9956)
		{
		    Weaps = strval(inputtext);
		    if(Weaps > 250) return SendClientMessage(playerid, 0x0000D9AA, "{FF0000}Max Ammo is 250 .");
			if(!isNumeric(inputtext)) return SendClientMessage(playerid, 0x0000D9AA, "Only numbers");
			if(GetPlayerMoney(playerid) <= Weaps*10000) return SendClientMessage(playerid,RED,"You don´t have so much money!");
			GivePlayerMoney(playerid, -Weaps*10000);
			GivePlayerWeapon(playerid, 35, Weaps);
			SendClientMessage(playerid, RED, "{33FF00}Thanks to use shop !{FF9900} You have buy Rocket Launcher !");
		}
	}
	if(response)
	{
		if(dialogid == 9957)
		{
		    Weaps = strval(inputtext);
		    if(Weaps > 250) return SendClientMessage(playerid, 0x0000D9AA, "{FF0000}Max Ammo is 250 .");
			if(!isNumeric(inputtext)) return SendClientMessage(playerid, 0x0000D9AA, "Only numbers");
			if(GetPlayerMoney(playerid) <= Weaps*100) return SendClientMessage(playerid,RED,"You don´t have so much money!");
			GivePlayerMoney(playerid, -Weaps*100);
			GivePlayerWeapon(playerid, 18, Weaps);
			SendClientMessage(playerid, RED, "{33FF00}Thanks to use shop !{FF9900} You have buy Molotov Cocktail !");
		}
	}
	if(response)
	{
		if(dialogid == 9958)
		{
		    Weaps = strval(inputtext);
		    if(Weaps > 250) return SendClientMessage(playerid, 0x0000D9AA, "{FF0000}Max Ammo is 250 .");
			if(!isNumeric(inputtext)) return SendClientMessage(playerid, 0x0000D9AA, "Only numbers");
			if(GetPlayerMoney(playerid) <= Weaps*50) return SendClientMessage(playerid,RED,"You don´t have so much money!");
			GivePlayerMoney(playerid, -Weaps*50);
			GivePlayerWeapon(playerid, 27, Weaps);
			SendClientMessage(playerid, RED, "{33FF00}Thanks to use shop !{FF9900} You have buy Combat Shotgun !");
		}
	}
	if(response)
	{
		if(dialogid == 9959)
		{
		    Weaps = strval(inputtext);
		    if(Weaps > 250) return SendClientMessage(playerid, 0x0000D9AA, "{FF0000}Max Ammo is 250 .");
			if(!isNumeric(inputtext)) return SendClientMessage(playerid, 0x0000D9AA, "Only numbers");
			if(GetPlayerMoney(playerid) <= Weaps*50) return SendClientMessage(playerid,RED,"You don´t have so much money!");
			GivePlayerMoney(playerid, -Weaps*50);
			GivePlayerWeapon(playerid, 26, Weaps);
			SendClientMessage(playerid, RED, "{33FF00}Thanks to use shop !{FF9900} You have buy Sawn-Off Shotgun !");
		}
	}
	if(response)
	{
		if(dialogid == 9960)
		{
		    Weaps = strval(inputtext);
		    if(Weaps > 250) return SendClientMessage(playerid, 0x0000D9AA, "{FF0000}Max Ammo is 250 .");
			if(!isNumeric(inputtext)) return SendClientMessage(playerid, 0x0000D9AA, "Only numbers");
			if(GetPlayerMoney(playerid) <= Weaps*30) return SendClientMessage(playerid,RED,"You don´t have so much money!");
			GivePlayerMoney(playerid, - Weaps*30);
			GivePlayerWeapon(playerid, 24, Weaps);
			SendClientMessage(playerid, RED, "{33FF00}Thanks to use shop !{FF9900} You have buy Desert Eagle !");
		}
	}
	if(response)
	{
		if(dialogid == 9961)
		{
		    Weaps = strval(inputtext);
		    if(Weaps > 250) return SendClientMessage(playerid, 0x0000D9AA, "{FF0000}Max Ammo is 250 .");
			if(!isNumeric(inputtext)) return SendClientMessage(playerid, 0x0000D9AA, "Only numbers");
			if(GetPlayerMoney(playerid) <= Weaps*300) return SendClientMessage(playerid,RED,"You don´t have so much money!");
			GivePlayerMoney(playerid, -Weaps*300);
			GivePlayerWeapon(playerid, 16, Weaps);
			SendClientMessage(playerid, RED, "{33FF00}Thanks to use shop !{FF9900} You have buy Grenade !");
		}
	}
	if(response)
	{
		if(dialogid == 9962)
		{
		    Weaps = strval(inputtext);
		    if(Weaps > 250) return SendClientMessage(playerid, 0x0000D9AA, "{FF0000}Max Ammo is 250 .");
			if(!isNumeric(inputtext)) return SendClientMessage(playerid, 0x0000D9AA, "Only numbers");
			if(GetPlayerMoney(playerid) <= Weaps*10) return SendClientMessage(playerid,RED,"You don´t have so much money!");
			GivePlayerMoney(playerid, -Weaps*10);
			GivePlayerWeapon(playerid, 29, Weaps);
			SendClientMessage(playerid, RED, "{33FF00}Thanks to use shop !{FF9900} You have buy MP5 !");
		}
	}
	return 0;
}
//================================STOCKS========================================
stock IsNumeric(string[])
{
	for (new i = 0, j = strlen(string);
	i < j; i++)
	{
	if (string[i] > '9' || string[i] < '0')
	return 0;
	}
	return 1;
}
//==============================================================================
stock ShowDialog(playerid, dialog)
{
	switch(dialog)
	{
		case 9954:  ShowPlayerDialog(playerid, dialog, DIALOG_STYLE_LIST,"{003399}S{00FF66}hop", "{6600CC}|<-------Weapons------>|\nSniper Rifle  [Ammo Price: 50$ ]\nRocket Launcher  [Ammo Price: 10.000$ ]\nMolotiv Coctails  [Ammo Price: 100$ ]\nCombat Shotgun  [Ammo Price: 50$ ]\nShawn-Off Shotgun  [Ammo Price: 50$ ]\nDesert Eagle  [Ammo Price: 30$ ]\nGranade  [Ammo Price: 300$ ]\nMP5  [Ammo Price: 10$ ]","Next", "Cancel");
		case 9955:  ShowPlayerDialog(playerid, dialog, DIALOG_STYLE_INPUT,"{003399}Sniper Rifle","{00FF66}Type the ammo, what you want for sniper .\n 1 Ammo Price is 50$","Buy","Cancel");
		case 9956:  ShowPlayerDialog(playerid, dialog, DIALOG_STYLE_INPUT,"{003399}Rocket Launcher","{00FF66}Type the ammo, what you want for rocket launcher .\n 1 Ammo Price is 2000$","Buy","Cancel");
		case 9957:  ShowPlayerDialog(playerid, dialog, DIALOG_STYLE_INPUT,"{003399}Molotiv Coctails","{00FF66}Type the ammo, what you want for coctails .\n 1 Ammo Price is 100$","Buy","Cancel");
		case 9958:  ShowPlayerDialog(playerid, dialog, DIALOG_STYLE_INPUT,"{003399}Combat ShotGun","{00FF66}Type the ammo, what you want for shotgun .\n 1 Ammo Price is 50$","Buy","Cancel");
		case 9959:  ShowPlayerDialog(playerid, dialog, DIALOG_STYLE_INPUT,"{003399}Shawn-Off ShotGun","{00FF66}Type the ammo, what you want for shawn-off .\n 1 Ammo Price is 50$","Buy","Cancel");
		case 9960:  ShowPlayerDialog(playerid, dialog, DIALOG_STYLE_INPUT,"{003399}Desert Eagle","{00FF66}Type the ammo, what you want for eagle .\n 1 Ammo Price is 30$","Buy","Cancel");
		case 9961:  ShowPlayerDialog(playerid, dialog, DIALOG_STYLE_INPUT,"{003399}Granades","{00FF66}Type the ammo, what you want for granades .\n 1 Ammo Price is 300$","Buy","Cancel");
		case 9962:  ShowPlayerDialog(playerid, dialog, DIALOG_STYLE_INPUT,"{003399}MP5","{00FF66}Type the ammo, what you want for MP5 .\n 1 Ammo Price is 10$","Buy","Cancel");
		case 9963:	ShowPlayerDialog(playerid, dialog, DIALOG_STYLE_MSGBOX, "{FF0000}Shop !","{FF6600}You wan't to {6600CC}open{33CC00}/{00FFFF}close{FF6600} shop ?","Open","Close");
	}
	return 0;
}
//====================[ BEST PART OF THAT FILTERSCRIPT ]========================
//========================[ THEY CALLED IT THE END ! ]==========================