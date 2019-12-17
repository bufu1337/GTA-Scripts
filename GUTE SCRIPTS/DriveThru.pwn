#include <a_samp>

// Mod by Bert so it works in a car!

#define MAX_PICKUPS 9

new PickUps;
new BurgerPickUp[MAX_PICKUPS];
new ChickenPickUp[MAX_PICKUPS];

new Menu:BurgerShot;
new Menu:CluckinBell;

new IsMenuShowed[MAX_PLAYERS] = 0;

new Float:BurgerDriveIn[6][3] = {
	{801.5522, -1628.91, 13.3828},
	{1209.958,-896.7405, 42.9259},
	{-2341.86, 1021.184, 50.6953},
	{2485.291, 2022.611, 10.8203},
	{1859.496, 2084.797, 10.8203},
	{-2349.49, -152.182, 35.3203}
};

new Float:ChickenDriveIn[3][3] = {
	{2409.651, -1488.65, 23.8281},
	{2377.733, -1909.27, 13.3828},
	{2375.014, 2021.186, 10.8203}
};

public OnPlayerConnect(playerid)
{
    SendClientMessage(playerid, 0xFFFFFFAA, "  This server is using 'Happy Meal' - More Informations: www.SA-Script-Crew.de.tf");
    SendClientMessage(playerid, 0xAA3333AA, "_____________________________________________________________________________________");
    return 1;
}

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Happy Meal 1.0 - SA Script Crew");
	print("--------------------------------------\n");
	SetTimer("UpdateBurgerPositions", 500, 1);
	SetTimer("UpdateChickenPositions", 500, 1);
 	for(new i = 0; i < sizeof(BurgerDriveIn); i++)
	{
	    BurgerPickUp[i] = CreatePickup(1239, 23, BurgerDriveIn[i][0], BurgerDriveIn[i][1], BurgerDriveIn[i][2]);
		PickUps++;
	}
 	for(new i = 0; i < sizeof(ChickenDriveIn); i++)
	{
	    ChickenPickUp[i] = CreatePickup(1239, 23, ChickenDriveIn[i][0], ChickenDriveIn[i][1], ChickenDriveIn[i][2]);
		PickUps++;
	}
	printf("Loading %d Pickups ....                                Successful!", PickUps);
	return 1;
}

forward UpdateBurgerPositions();
public UpdateBurgerPositions()
{
	for(new i = 0; i < MAX_PLAYERS; i ++)
	{
	    if(IsMenuShowed[i] == 0)
	    {
			for(new j = 0; j < sizeof(BurgerDriveIn); j ++)
			{
			    new Float:dist;
			    dist = GetDistance(i, BurgerDriveIn[j][0], BurgerDriveIn[j][1]);
			    if(dist < 5)
			    {
			        GameTextForPlayer(i, "~n~~n~~n~~w~Welcome to the ~r~Burger King~w~, please select your meal", 2000, 3);
			        TogglePlayerControllable(i, 0);
			        SetTimerEx("ShowMenuBurger", 2000, 0, "i", i);
			    }
			}
		}
	}
}

forward ShowMenuBurger(i);
public ShowMenuBurger(i)
{
    BurgerShot = CreateMenu("Burger Shot", 2, 125, 150, 300);
	AddMenuItem(BurgerShot, 0, "Baby Burger");
	AddMenuItem(BurgerShot, 1, "$5");
	AddMenuItem(BurgerShot, 0, "Double Cheese");
	AddMenuItem(BurgerShot, 1, "$10");
	AddMenuItem(BurgerShot, 0, "Triple Whopper");
	AddMenuItem(BurgerShot, 1, "$20");
	ShowMenuForPlayer(BurgerShot, i);
	IsMenuShowed[i] = 1;
}

forward UpdateChickenPositions();
public UpdateChickenPositions()
{
    for(new i = 0; i < MAX_PLAYERS; i ++)
	{
	    if(IsMenuShowed[i] == 0)
	    {
			for(new j = 0; j < sizeof(ChickenDriveIn); j ++)
			{
			    new Float:dist;
			    dist = GetDistance(i, ChickenDriveIn[j][0], ChickenDriveIn[j][1]);
			    if(dist < 5)
			    {
			        GameTextForPlayer(i, "~n~~n~~n~~w~Welcome to the ~r~Cluckin' Bell~w~, please select your meal", 2000, 3);
			        TogglePlayerControllable(i, 0);
			        SetTimerEx("ShowMenuChicken", 2000, 0, "i", i);
				}
			}
		}
	}
}

forward ShowMenuChicken(i);
public ShowMenuChicken(i)
{
    CluckinBell = CreateMenu("Cluckin' Bell", 2, 125, 150, 300);
	AddMenuItem(CluckinBell, 0, "Chicken Nuggets");
	AddMenuItem(CluckinBell, 1, "$5");
	AddMenuItem(CluckinBell, 0, "Chicken Wing");
	AddMenuItem(CluckinBell, 1, "$10");
	AddMenuItem(CluckinBell, 0, "Crisp Chicken");
	AddMenuItem(CluckinBell, 1, "$20");
	ShowMenuForPlayer(CluckinBell, i);
	IsMenuShowed[i] = 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:Current = GetPlayerMenu(playerid);
    new Float:PlayerHealth;
    new Health = GetPlayerHealth(playerid, PlayerHealth);
	if(Current == BurgerShot)
	{
	 	switch(row)
	 	{
	  		case 0:
	  		{
	  			GivePlayerMoney(playerid, -5);
	  			if(Health <= 74.9)
	  			{
	  				SetPlayerHealth(playerid, PlayerHealth+25);
				}
				else
				{
				    SetPlayerHealth(playerid, 100.0);
				}
	  			SendClientMessage(playerid, 0xFFC801C8, "Burger Shot: Thank you for buying the Baby Burger, have a nice meal and good afternoon!");
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				TogglePlayerControllable(playerid, 1);
				SetTimerEx("CanDriveThruAgain", 7000, 0, "i", playerid);
				return 1;
			}
			case 1:
	  		{
	  			GivePlayerMoney(playerid, -10);
	  			if(Health <= 49.9)
	  			{
	  				SetPlayerHealth(playerid, PlayerHealth+50);
				}
				else
				{
				    SetPlayerHealth(playerid, 100.0);
				}
	  			SendClientMessage(playerid, 0xFFC801C8, "Burger Shot: Thank you for buying the Double Cheese, have a Cheesy meal and good afternoon!");
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				TogglePlayerControllable(playerid, 1);
				SetTimerEx("CanDriveThruAgain", 7000, 0, "i", playerid);
				return 1;
			}
			case 2:
	  		{
	  			GivePlayerMoney(playerid, -20);
	  			SetPlayerHealth(playerid, PlayerHealth+100);
	  			SendClientMessage(playerid, 0xFFC801C8, "Burger Shot: Thank you for buying the Tripple Whopper, have a nice feast and good afternoon!");
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				TogglePlayerControllable(playerid, 1);
				SetTimerEx("CanDriveThruAgain", 7000, 0, "i", playerid);
				return 1;
			}
		}
	}
	if(Current == CluckinBell)
	{
	 	switch(row)
	 	{
	  		case 0:
	  		{
	  			GivePlayerMoney(playerid, -5);
	  			if(Health <= 74.9)
	  			{
	  				SetPlayerHealth(playerid, PlayerHealth+25);
				}
				else
				{
				    SetPlayerHealth(playerid, 100.0);
				}
	  			SendClientMessage(playerid, 0xFFC801C8, "Cluckin' Bell: Thank you for your interest in our food, good afternoon!");
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				TogglePlayerControllable(playerid, 1);
				SetTimerEx("CanDriveThruAgain", 7000, 0, "i", playerid);
				return 1;
			}
			case 1:
	  		{
	  			GivePlayerMoney(playerid, -10);
	  			if(Health <= 49.9)
	  			{
	  				SetPlayerHealth(playerid, PlayerHealth+50);
				}
				else
				{
				    SetPlayerHealth(playerid, 100.0);
				}
	  			SendClientMessage(playerid, 0xFFC801C8, "Cluckin' Bell: we thank you and hope you enjoy your Chicken Wing, have a good day!");
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				TogglePlayerControllable(playerid, 1);
				SetTimerEx("CanDriveThruAgain", 7000, 0, "i", playerid);
				return 1;
			}
			case 2:
	  		{
	  			GivePlayerMoney(playerid, -20);
	  			SetPlayerHealth(playerid, PlayerHealth+100);
	  			SendClientMessage(playerid, 0xFFC801C8, "Cluckin' Bell: We hope you eat it all, have a nice day!");
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				TogglePlayerControllable(playerid, 1);
				SetTimerEx("CanDriveThruAgain", 7000, 0, "i", playerid);
				return 1;
			}
		}
	}
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	TogglePlayerControllable(playerid, 1);
	SetTimerEx("CanDriveThruAgain", 7000, 0, "i", playerid);
	return 1;
}

forward CanDriveThruAgain(playerid);
public CanDriveThruAgain(playerid)
{
	IsMenuShowed[playerid] = 0;
}

forward Float:GetDistance(playerid, Float:x, Float:y);
public Float:GetDistance(playerid, Float:x, Float:y)
{
	new Float:x2, Float:y2, Float:z2;
	GetPlayerPos(playerid, x2, y2, z2);
	x = x - x2;
	y = y - y2;
	return floatsqroot(x*x+y*y);
}

forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
	return 0;
}