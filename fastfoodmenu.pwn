#include <a_samp>

//////////////////////////////////////
//		Tez's Fast Food Menu's		//
//////////////////////////////////////

#define FILTERSCRIPT

#define COLOR_GRAD2 0xBFC0C2FF

forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);

new Menu:CluckinBell;
new Menu:BurgerShot;
new Menu:PizzaStack;
new Float:HP;

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Enabled Tez's Fast Food Menu's ");
	print("--------------------------------------\n");

	/* ------------ Cluckin' Bell ---------------*/
	CluckinBell = CreateMenu("Cuckin' Bell Menu", 1, 50.0, 180.0, 200.0, 200.0);
	AddMenuItem(CluckinBell, 0, "Cluckin' Little Meal ($2)");
	AddMenuItem(CluckinBell, 0, "Cluckin' Big Meal ($6)");
	AddMenuItem(CluckinBell, 0, "Cluckin' Huge Meal ($12)");
	AddMenuItem(CluckinBell, 0, "Salad Meal ($12)");
	/* ------------------------------------------*/

	/* ------------- Burger Shot ----------------*/
	BurgerShot = CreateMenu("Burger Shot Menu", 1, 50.0, 180.0, 200.0, 200.0);
	AddMenuItem(BurgerShot, 0, "Moo Kids Meal ($2)");
	AddMenuItem(BurgerShot, 0, "Beef Tower ($6)");
	AddMenuItem(BurgerShot, 0, "Meat Stack ($12)");
	AddMenuItem(BurgerShot, 0, "Salad Meal ($6)");
	/* ------------------------------------------*/

	/* ------------- Pizza Stack ----------------*/
	PizzaStack = CreateMenu("Pizza Stack Menu", 1, 50.0, 180.0, 200.0, 200.0);
	AddMenuItem(PizzaStack, 0, "Buter ($2)");
	AddMenuItem(PizzaStack, 0, "Double D-Luxe ($6)");
	AddMenuItem(PizzaStack, 0, "Full Rack ($12)");
	AddMenuItem(PizzaStack, 0, "Salad Meal ($12)");
	/* ------------------------------------------*/
	return 1;
}

public OnFilterScriptExit()
{
    print("\n--------------------------------------");
	print(" Disabled Tez's Fast Food Menu's ");
	print("--------------------------------------\n");
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    new cmd[128], idx;
	cmd = strtok(cmdtext, idx);

	if(!strcmp("/fastfood", cmdtext, true))
	{
        if(PlayerToPoint(5.0,playerid,368.8863,-6.8242,1001.8516)) // Cluckin' Bell
        {
            TogglePlayerControllable(playerid, 0);
            ShowMenuForPlayer(CluckinBell, playerid);
        }
		else if(PlayerToPoint(5.0,playerid,376.9207,-68.8062,1001.5078)) // Burger Shot
		{
		    TogglePlayerControllable(playerid, 0);
		    ShowMenuForPlayer(BurgerShot, playerid);
		}
		else if(PlayerToPoint(5.0,playerid,374.1479,-119.6262,1001.4922)) // Pizza Stack
		{
		    TogglePlayerControllable(playerid, 0);
		    ShowMenuForPlayer(PizzaStack, playerid);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GRAD2, "You are not at a fast food place!");
		}
	    return 1;
 	}
 	return 0;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:current;
    current = GetPlayerMenu(playerid);
    if(current == CluckinBell)
    {
        switch(row)
        {
            case 0:
			{
				GetPlayerHealth(playerid, HP);
               	if(HP <= 67)
				{
					SetPlayerHealth(playerid,HP+33);
				}
				else
				{
			    	SetPlayerHealth(playerid, 100);
				}
				HideMenuForPlayer(CluckinBell, playerid);
				GivePlayerMoney(playerid, -2);
				TogglePlayerControllable(playerid, 1);
				OnePlayAnim(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eating Command
			}
            case 1:
			{
				GetPlayerHealth(playerid, HP);
                if(HP <= 60)
				{
					SetPlayerHealth(playerid,HP+40);
				}
				else
				{
				    SetPlayerHealth(playerid, 100);
				}
				HideMenuForPlayer(CluckinBell, playerid);
				GivePlayerMoney(playerid, -6);
				TogglePlayerControllable(playerid, 1);
				OnePlayAnim(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eating Command
            }
            case 2:
			{
				GetPlayerHealth(playerid, HP);
                if(HP <= 20)
				{
					SetPlayerHealth(playerid,HP+80);
				}
				else
				{
				    SetPlayerHealth(playerid, 100);
				}
				HideMenuForPlayer(CluckinBell, playerid);
				GivePlayerMoney(playerid, -12);
				TogglePlayerControllable(playerid, 1);
				OnePlayAnim(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eating Command
            }
            case 3:
			{
				GetPlayerHealth(playerid, HP);
                if(HP <= 67)
				{
					SetPlayerHealth(playerid,HP+33);
				}
				else
				{
				    SetPlayerHealth(playerid, 100);
				}
				HideMenuForPlayer(CluckinBell, playerid);
				GivePlayerMoney(playerid, -12);
				TogglePlayerControllable(playerid, 1);
				OnePlayAnim(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eating Command
            }
        }
    }

    /////////////////

    if(current == BurgerShot)
    {
        switch(row)
        {
            case 0:
			{
			    GetPlayerHealth(playerid, HP);
                if(HP <= 67)
				{
					SetPlayerHealth(playerid,HP+33);
				}
				else
				{
				    SetPlayerHealth(playerid, 100);
				}
				HideMenuForPlayer(BurgerShot, playerid);
				GivePlayerMoney(playerid, -2);
				TogglePlayerControllable(playerid, 1);
				OnePlayAnim(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eating Command
            }
            case 1:
			{
				GetPlayerHealth(playerid, HP);
                if(HP <= 60)
				{
					SetPlayerHealth(playerid,HP+40);
				}
				else
				{
				    SetPlayerHealth(playerid, 100);
				}
				HideMenuForPlayer(BurgerShot, playerid);
				GivePlayerMoney(playerid, -6);
				TogglePlayerControllable(playerid, 1);
				OnePlayAnim(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eating Command
            }
            case 2:
			{
				GetPlayerHealth(playerid, HP);
                if(HP <= 20)
				{
					SetPlayerHealth(playerid,HP+80);
				}
				else
				{
				    SetPlayerHealth(playerid, 100);
				}
				HideMenuForPlayer(BurgerShot, playerid);
				GivePlayerMoney(playerid, -12);
				TogglePlayerControllable(playerid, 1);
				OnePlayAnim(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eating Command
            }
            case 3:
			{
				GetPlayerHealth(playerid, HP);
                if(HP <= 67)
				{
					SetPlayerHealth(playerid,HP+33);
				}
				else
				{
				    SetPlayerHealth(playerid, 100);
				}
				HideMenuForPlayer(BurgerShot, playerid);
				GivePlayerMoney(playerid, -12);
				TogglePlayerControllable(playerid, 1);
				OnePlayAnim(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eating Command
            }
        }
    }

    //////

    if(current == PizzaStack)
    {
        switch(row)
        {
            case 0:
			{
                GetPlayerHealth(playerid, HP);
                if(HP <= 67)
				{
					SetPlayerHealth(playerid,HP+33);
				}
				else
				{
				    SetPlayerHealth(playerid, 100);
				}
				HideMenuForPlayer(PizzaStack, playerid);
				GivePlayerMoney(playerid, -2);
				TogglePlayerControllable(playerid, 1);
				OnePlayAnim(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eating Command
            }
            case 1:
			{
				GetPlayerHealth(playerid, HP);
                if(HP <= 60)
				{
					SetPlayerHealth(playerid,HP+40);
				}
				else
				{
				    SetPlayerHealth(playerid, 100);
				}
				HideMenuForPlayer(PizzaStack, playerid);
				GivePlayerMoney(playerid, -6);
				TogglePlayerControllable(playerid, 1);
				OnePlayAnim(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eating Command
            }
            case 2:
			{
				GetPlayerHealth(playerid, HP);
                if(HP <= 20)
				{
					SetPlayerHealth(playerid,HP+80);
				}
				else
				{
				    SetPlayerHealth(playerid, 100);
				}
				HideMenuForPlayer(PizzaStack, playerid);
				GivePlayerMoney(playerid, -12);
				TogglePlayerControllable(playerid, 1);
				OnePlayAnim(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eating Command
            }
            case 3:
			{
				GetPlayerHealth(playerid, HP);
                if(HP <= 67)
				{
					SetPlayerHealth(playerid,HP+33);
				}
				else
				{
				    SetPlayerHealth(playerid, 100);
				}
				HideMenuForPlayer(PizzaStack, playerid);
				GivePlayerMoney(playerid, -12);
				TogglePlayerControllable(playerid, 1);
				OnePlayAnim(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eating Command
            }
        }
    }

	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

stock strtok(const string[], &index)
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

OnePlayAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
	ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp);
}