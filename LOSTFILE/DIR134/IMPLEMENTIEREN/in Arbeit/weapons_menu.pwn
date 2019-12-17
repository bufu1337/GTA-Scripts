/*------------------------------------------------------------------------------

			---------------------------------------------------
			-                                      			  -
			-	     Weapons Menu 0.1 By Jasen [JA53N]        -
			-                                      			  -
			---------------------------------------------------


- Copyright © 2007 JA53N


- Type - Filterscript


- Version 0.2


- Contact at jasen52@gmail.com

------------------------------------------------------------------------------*/

#include <a_samp>
#include <float>

#define red 0xFF0000AA
#define yellow 0xFFFF00AA

new Menu:Weapons;
new Menu:Pistols;
new Menu:Micro_SMGs;
new Menu:Shotguns;
new Menu:Armour;
new Menu:SMG;
new Menu:Rifles;
new Menu:Assault;
new Float:health;

public OnFilterScriptInit()
{
    print("\n--------------------------------------");
	print("    [FS] Weapon's Menu by JA53N");
	print("--------------------------------------\n");
	Weapons = CreateMenu("Weapons",1,20,120,150,40);
    AddMenuItem(Weapons,0,"Pistols");
    AddMenuItem(Weapons,0,"Micro SMGs");
    AddMenuItem(Weapons,0,"Shotguns");
    AddMenuItem(Weapons,0,"Armour");
    AddMenuItem(Weapons,0,"SMG");
    AddMenuItem(Weapons,0,"Rifles");
    AddMenuItem(Weapons,0,"Assault");
	Pistols = CreateMenu("Weapons",1,20,120,150,40);
	SetMenuColumnHeader(Pistols,0,"Weapons     Cost");
	AddMenuItem(Pistols,0,"9mm				   $200");
	AddMenuItem(Pistols,0,"Silenced 9mm		   $600");
	AddMenuItem(Pistols,0,"Desert Eagle		   $1200");
	AddMenuItem(Pistols,0,"<back>");
	Micro_SMGs = CreateMenu("Weapons",1,20,120,150,40);
	SetMenuColumnHeader(Micro_SMGs,0,"Weapons     Cost");
	AddMenuItem(Micro_SMGs,0,"Tec9        		  $300");
	AddMenuItem(Micro_SMGs,0,"Micro SMG        	  $500");
	AddMenuItem(Micro_SMGs,0,"<back>");
	Shotguns = CreateMenu("Weapons",1,20,120,150,40);
	SetMenuColumnHeader(Shotguns,0,"Weapons     Cost");
	AddMenuItem(Shotguns,0,"Shotgun  			$600");
	AddMenuItem(Shotguns,0,"Sawnoff Shotgun  	$800");
	AddMenuItem(Shotguns,0,"<back>");
	Armour = CreateMenu("Weapons",1,20,120,150,40);
	SetMenuColumnHeader(Armour,0,"Weapons     Cost");
	AddMenuItem(Armour,0,"Body Armour  	      $200");
	AddMenuItem(Armour,0,"<back>");
	SMG = CreateMenu("Weapons",1,20,120,150,40);
	SetMenuColumnHeader(SMG,0,"Weapons     Cost");
	AddMenuItem(SMG,0,"SMG  			   $2000");
	AddMenuItem(SMG,0,"<back>");
	Rifles = CreateMenu("Weapons",1,20,120,150,40);
	SetMenuColumnHeader(Rifles,0,"Weapons     Cost");
	AddMenuItem(Rifles,0,"Rifle  			  $1000");
	AddMenuItem(Rifles,0,"Sniper Rifle  	  $5000");
	AddMenuItem(Rifles,0,"<back>");
	Assault = CreateMenu("Weapons",1,20,120,150,40);
	SetMenuColumnHeader(Rifles,0,"Weapons     Cost");
	AddMenuItem(Assault,0,"AK47  			  $3500");
	AddMenuItem(Assault,0,"M4			  	  $4500");
	AddMenuItem(Assault,0,"<back>");
	return 1;
}

public OnPlayerCommandText(playerid,cmdtext[])
{
    new cmd[256];
	new idx;
    cmd = strtok(cmdtext, idx);

	if(strcmp(cmd, "/weaponsmenu", true) == 0)
	{
			GetPlayerHealth(playerid, health);
			GetPlayerHealth(playerid, Float:health);
			TogglePlayerControllable(playerid, false);
			SetPlayerHealth(playerid, 100000);
			ShowMenuForPlayer(Weapons, playerid);
			return 1;
	}
	return 0;
}


public OnFilterScriptExit()
{
    DestroyMenu(Menu:Weapons);
	DestroyMenu(Menu:Pistols);
	DestroyMenu(Menu:Micro_SMGs);
	DestroyMenu(Menu:Shotguns);
	DestroyMenu(Menu:Armour);
	DestroyMenu(Menu:SMG);
	DestroyMenu(Menu:Rifles);
	DestroyMenu(Menu:Assault);
	return 1;
}

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

public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:Current = GetPlayerMenu(playerid);
    if(Current == Weapons) {
    switch(row){
        case 0:
			if(IsPlayerConnected(playerid))
			{
				ShowMenuForPlayer(Pistols, playerid);
			}
        case 1:
			if(IsPlayerConnected(playerid))
			{
				ShowMenuForPlayer(Micro_SMGs, playerid);
			}
        case 2:
			if(IsPlayerConnected(playerid))
			{
				ShowMenuForPlayer(Shotguns, playerid);
			}
        case 3:
			if(IsPlayerConnected(playerid))
			{
				ShowMenuForPlayer(Armour, playerid);
			}
        case 4:
			if(IsPlayerConnected(playerid))
			{
				ShowMenuForPlayer(SMG, playerid);
			}
        case 5:
			if(IsPlayerConnected(playerid))
			{
				ShowMenuForPlayer(Rifles, playerid);
			}
        case 6:
			if(IsPlayerConnected(playerid))
			{
				ShowMenuForPlayer(Assault, playerid);
			}
	}
	}
	if(Current == Pistols) {
	switch(row){
	    case 0:
	        if(GetPlayerMoney(playerid) >= 200)
	        {
				GivePlayerWeapon(playerid, 22, 30);
				GivePlayerMoney(playerid,-200);
				SendClientMessage(playerid,yellow,"9mm Purchase Succsesful!");
				GetPlayerWeapon(playerid);
				ShowMenuForPlayer(Weapons, playerid);
			}
			else
			{
			    SendClientMessage(playerid,red,"Not enough money!");
			    ShowMenuForPlayer(Weapons, playerid);
			}
		case 1:
		    if(GetPlayerMoney(playerid) >= 600)
		    {
				GivePlayerWeapon(playerid, 23, 30);
				GivePlayerMoney(playerid,-600);
				SendClientMessage(playerid,yellow,"Silenced 9mm Purchase Succsesful!");
				ShowMenuForPlayer(Weapons, playerid);
			}
			else
			{
			    SendClientMessage(playerid,red,"Not enough money!");
			    ShowMenuForPlayer(Weapons, playerid);
			}
		case 2:
		    if(GetPlayerMoney(playerid) >= 1200)
		    {
				GivePlayerWeapon(playerid, 24, 15);
				GivePlayerMoney(playerid,-1200);
				SendClientMessage(playerid,yellow,"Desert Eagle Purchase Succsesful!");
				ShowMenuForPlayer(Weapons, playerid);
			}
			else
			{
			    SendClientMessage(playerid,red,"Not enough money!");
			    ShowMenuForPlayer(Weapons, playerid);
			}
		case 3:ShowMenuForPlayer(Weapons, playerid);
	}
	}
	if(Current == Micro_SMGs) {
	switch(row){
	    case 0:
	        if(GetPlayerMoney(playerid) >= 300)
	        {
  				GivePlayerWeapon(playerid, 32, 60);
	            GivePlayerMoney(playerid,-300);
	            SendClientMessage(playerid,yellow,"Tec9 Purchase Succsesful!");
	            ShowMenuForPlayer(Weapons, playerid);
			}
			else
			{
			    SendClientMessage(playerid,red,"Not enough money!");
			    ShowMenuForPlayer(Weapons, playerid);
			}
		case 1:
		    if(GetPlayerMoney(playerid) >= 500)
		    {
				GivePlayerWeapon(playerid, 28, 60);
		        GivePlayerMoney(playerid,-500);
		        SendClientMessage(playerid,yellow,"Micro SMG Purchase Succsesful!");
		        ShowMenuForPlayer(Weapons, playerid);
			}
			else
			{
			    SendClientMessage(playerid,red,"Not enough money!");
			    ShowMenuForPlayer(Weapons, playerid);
			}
		case 2:ShowMenuForPlayer(Weapons, playerid);
	}
	}
	if(Current == Shotguns) {
	switch(row){
	    case 0:
	        if(GetPlayerMoney(playerid) >= 600)
	        {
					GivePlayerWeapon(playerid, 25, 15);
	            	GivePlayerMoney(playerid,-600);
	            	SendClientMessage(playerid,yellow,"Shotgun Purchase Succsesful!");
	            	ShowMenuForPlayer(Weapons, playerid);
			}
			else
			{
			    SendClientMessage(playerid,red,"Not enough money!");
			    ShowMenuForPlayer(Weapons, playerid);
			}
		case 1:
		    if(GetPlayerMoney(playerid) >= 800)
		    {
					GivePlayerWeapon(playerid, 26, 12);
					GivePlayerMoney(playerid,-800);
		            SendClientMessage(playerid,yellow,"Sawnoff Shotgun Purchase Succsesful!");
		            ShowMenuForPlayer(Weapons, playerid);
			}
			else
			{
			    SendClientMessage(playerid,red,"Not enough money!");
			    ShowMenuForPlayer(Weapons, playerid);
			}
		case 2:ShowMenuForPlayer(Weapons, playerid);
	}
	}
    if(Current == Armour) {
    switch(row){
        case 0:
            if(GetPlayerMoney(playerid) >= 200)
            {
					SetPlayerArmour(playerid, 100);
					GivePlayerMoney(playerid,-200);
                    SendClientMessage(playerid,yellow,"Body Armour Purchase Succsesful!");
                    ShowMenuForPlayer(Weapons, playerid);
			}
			else
			{
			    SendClientMessage(playerid,red,"Not enough money!");
			    ShowMenuForPlayer(Weapons, playerid);
			}
		case 1:ShowMenuForPlayer(Weapons, playerid);
	}
	}
	if(Current == SMG) {
	switch(row){
	    case 0:
	        if(GetPlayerMoney(playerid) >= 2000)
	        {
					GivePlayerWeapon(playerid, 29, 90);
					GivePlayerMoney(playerid,-2000);
				    SendClientMessage(playerid,yellow,"SMG Purchase Succsesful!");
				    ShowMenuForPlayer(Weapons, playerid);
			}
			else
			{
			    SendClientMessage(playerid,red,"Not enough money!");
			    ShowMenuForPlayer(Weapons, playerid);
			}
		case 1:ShowMenuForPlayer(Weapons, playerid);
	}
	}
	if(Current == Rifles) {
	switch(row){
	    case 0:
	        if(GetPlayerMoney(playerid) >= 1000)
	        {
					GivePlayerWeapon(playerid, 33, 20);
					GivePlayerMoney(playerid,-1000);
	                SendClientMessage(playerid,yellow,"Rifle Purchase Succsesful!");
	                ShowMenuForPlayer(Weapons, playerid);
			}
			else
			{
			    SendClientMessage(playerid,red,"Not enough money!");
			    ShowMenuForPlayer(Weapons, playerid);
			}
		case 1:
		    if(GetPlayerMoney(playerid) >= 5000)
		    {
					GivePlayerWeapon(playerid, 34, 10);
		            GivePlayerMoney(playerid,-5000);
		            SendClientMessage(playerid,yellow,"Sniper Rifle Purchase Succsesful!");
		            ShowMenuForPlayer(Weapons, playerid);
			}
			else
			{
			    SendClientMessage(playerid,red,"Not enough money!");
			    ShowMenuForPlayer(Weapons, playerid);
			}
		case 2:ShowMenuForPlayer(Weapons, playerid);
	}
	}
	if(Current == Assault) {
	switch(row){
	    case 0:
	        if(GetPlayerMoney(playerid) >= 3500)
	        {
				GivePlayerWeapon(playerid, 30, 120);
				GivePlayerMoney(playerid,-3500);
				SendClientMessage(playerid,yellow,"AK47 Purchase Succsesful!");
				ShowMenuForPlayer(Weapons, playerid);
			}
			else
			{
			    SendClientMessage(playerid,red,"Not enough money!");
			    ShowMenuForPlayer(Weapons, playerid);
			}
		case 1:
		    if(GetPlayerMoney(playerid) >= 4500)
		    {
				GivePlayerWeapon(playerid, 31, 150);
				GivePlayerMoney(playerid,-4500);
				SendClientMessage(playerid,yellow,"M4 Purchase Succsesful!");
				ShowMenuForPlayer(Weapons, playerid);
			}
			else
			{
			    SendClientMessage(playerid,red,"Not enough money!");
			    ShowMenuForPlayer(Weapons, playerid);
			}
		case 2:ShowMenuForPlayer(Weapons, playerid);
	}
	}
}

public OnPlayerExitedMenu(playerid)
{
	TogglePlayerControllable(playerid, true);
	(SetPlayerHealth(playerid, Float:health));
}

public OnPlayerSpawn(playerid) {
	GivePlayerWeapon(playerid, 20, 500);
	}
