/////////////////////////////////////////////
//                                         //
//        Parrot System by FreeGells!      //
//                                         //
/////////////////////////////////////////////

#include <a_samp>
#include <dini>

#define WHITE 0xFFFFFFFF
#define RED 0xFF0000FF
#define PARROT_COST 2000
#define PARROT_SELL_PRICE 10000

enum a
{
	bool:Parrot,
	bool:Food,
	Big,
	Timer
}

new Info[MAX_PLAYERS][a];

public OnFilterScriptInit()
{
	if(!fexist("Parrots.txt")) { dini_Create("Parrots.txt"); }
	return 1;
}

public OnFilterScriptExit()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(Info[i][Parrot]) { RemovePlayerAttachedObject(i, 0); }
	}
	return 1;
}

forward Growth(playerid);

public OnPlayerConnect(playerid)
{
	new nome[24], str[50];
	GetPlayerName(playerid, nome, 24);
	format(str, sizeof str, "%s - Parrot", nome);
	if(dini_Isset("Parrots.txt", str))
	{
		Info[playerid][Parrot] = bool:dini_Bool("Parrots.txt", str);
		format(str, sizeof str, "%s - Food", nome);
		Info[playerid][Food] = bool:dini_Bool("Parrots.txt", str);
		format(str, sizeof str, "%s - Big", nome);
		Info[playerid][Big] = dini_Int("Parrots.txt", str);
		if(Info[playerid][Parrot])
		{
			Info[playerid][Timer] = SetTimerEx("Growth", 15000, true, "i", playerid);
			SendClientMessage(playerid, 0xFFFF00FF, "Feed your parrot or she dies.");
		}
  	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
    if(Info[playerid][Parrot])
	{
        switch(Info[playerid][Big])
		{
            case 0: { SetPlayerAttachedObject( playerid, 0, 19079, 1, 0.328340, -0.019586, -0.157024, 0.000000, 0.000000, 0.000000, 0.391784, 0.423681, 0.528653 ); }
            case 1: { SetPlayerAttachedObject( playerid, 0, 19079, 1, 0.328340, -0.019586, -0.157024, 0.000000, 0.000000, 0.000000, 0.509503, 0.486798, 0.625176 ); }
            case 2: { SetPlayerAttachedObject( playerid, 0, 19079, 1, 0.328340, -0.051058, -0.147006, 0.000000, 0.000000, 0.000000, 0.584640, 0.560368, 0.655995 ); }
            case 3: { SetPlayerAttachedObject( playerid, 0, 19079, 1, 0.328340, -0.082576, -0.147006, 0.000000, 0.000000, 0.000000, 0.648338, 0.671368, 0.725697 ); }
            case 4, 5: { SetPlayerAttachedObject( playerid, 0, 19079, 1, 0.328340, -0.082576, -0.147006, 0.000000, 0.000000, 0.000000, 0.949556, 1.045981, 1.021382 ); }
        }
    }
    return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	new nome[24], str[50];
	GetPlayerName(playerid, nome, 24);
	format(str, sizeof str, "%s - Parrot", nome);
	dini_BoolSet("Parrots.txt", str, Info[playerid][Parrot]);
	format(str, sizeof str, "%s - Food", nome);
	dini_BoolSet("Parrots.txt", str, Info[playerid][Food]);
	format(str, sizeof str, "%s - Big", nome);
	dini_IntSet("Parrots.txt", str, Info[playerid][Big]);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp(cmdtext, "/buyparrot", true) == 0)
	{
		if(Info[playerid][Big] >= 5) return SendClientMessage(playerid, RED, "Your Parrot is great and ready to sell, sell to type /SellParrot!");
		if(GetPlayerMoney(playerid)<PARROT_COST)return SendClientMessage(playerid, WHITE,"You do not have $ 2000!");
		if(Info[playerid][Parrot]) return SendClientMessage(playerid, WHITE, "You already have a Parrot!");
		SendClientMessage(playerid, WHITE, "You bought a Parrot!");
		SendClientMessage(playerid, WHITE, "She will grow from five to Five Minutes");
		SendClientMessage(playerid, WHITE, "Do not forget to feed her! /Fed");
		SetPlayerAttachedObject(playerid,0, 19079, 1, 0.319503, -0.089340, -0.185576, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
		GivePlayerMoney(playerid, -PARROT_COST);
		Info[playerid][Parrot] = true;
		Info[playerid][Timer] = SetTimerEx("Growth", 15000, true, "i", playerid);
		return 1;
	}
	if(strcmp(cmdtext, "/powered", true) == 0)
	{
		if(Info[playerid][Big] >= 5) return SendClientMessage(playerid, RED, "Great and His Parrot is ready to sell, sell to type /SellParrot!");
		if(!Info[playerid][Parrot]) return SendClientMessage(playerid, RED, "You do not have a Parrot.");
		if(Info[playerid][Food]) { SendClientMessage(playerid, WHITE, "Parrot Powered: {008000}Yes"); }
		else { SendClientMessage(playerid, WHITE, "Parrot Powered: {FF0000}Not"); }
		return 1;
	}
	if(strcmp(cmdtext, "/fed", true) == 0)
	{
		if(Info[playerid][Big] >= 5) return SendClientMessage(playerid, RED, "Great and His Parrot is ready to sell, sell to type /SellParrot!");
		if(!Info[playerid][Parrot]) return SendClientMessage(playerid, RED, "You do not have a Parrot.");
		if(Info[playerid][Food]) return SendClientMessage(playerid, WHITE, "Have you fed your Parrot!");
		SendClientMessage(playerid, WHITE, "You feed your Parrot! It cost him $ 200");
		GivePlayerMoney(playerid, -200);
		Info[playerid][Food] = true;
		return 1;
	}
	if(strcmp(cmdtext, "/sellparrot", true) == 0)
	{
		if(!Info[playerid][Parrot]) return SendClientMessage(playerid, WHITE, "You did not buy any Parrot");
		if(Info[playerid][Big] < 5) return SendClientMessage(playerid, WHITE, "Your Parrot is not big!");
		Info[playerid][Big] = 0;
		Info[playerid][Parrot] = false;
		RemovePlayerAttachedObject(playerid, 0);
		GivePlayerMoney(playerid, PARROT_SELL_PRICE);
		SendClientMessage(playerid, WHITE, "You sold your Parrot and won $ 10,000!");
		return 1;
	}
	return 0;
}


public Growth(playerid)
{
	if(!Info[playerid][Parrot])
	{
		KillTimer(Info[playerid][Timer]);
		return 0;
	}
	if(!Info[playerid][Food] && Info[playerid][Big] < 5)
	{
		SendClientMessage(playerid, WHITE, "Do not feed your Parrot and she died");
		RemovePlayerAttachedObject(playerid, 0);
		Info[playerid][Parrot] = false;
		Info[playerid][Big] = 0;
		KillTimer(Info[playerid][Timer]);
		return 1;
	}
	new str[30];
 	RemovePlayerAttachedObject(playerid, 0);
    switch(Info[playerid][Big])
	{
        case 0: { SetPlayerAttachedObject( playerid, 0, 19079, 1, 0.328340, -0.019586, -0.157024, 0.000000, 0.000000, 0.000000, 0.391784, 0.423681, 0.528653 ); }
        case 1: { SetPlayerAttachedObject( playerid, 0, 19079, 1, 0.328340, -0.019586, -0.157024, 0.000000, 0.000000, 0.000000, 0.509503, 0.486798, 0.625176 ); }
        case 2: { SetPlayerAttachedObject( playerid, 0, 19079, 1, 0.328340, -0.051058, -0.147006, 0.000000, 0.000000, 0.000000, 0.584640, 0.560368, 0.655995 ); }
        case 3: { SetPlayerAttachedObject( playerid, 0, 19079, 1, 0.328340, -0.082576, -0.147006, 0.000000, 0.000000, 0.000000, 0.648338, 0.671368, 0.725697 ); }
        case 4, 5: { SetPlayerAttachedObject( playerid, 0, 19079, 1, 0.328340, -0.082576, -0.147006, 0.000000, 0.000000, 0.000000, 0.949556, 1.045981, 1.021382 ); }
    }
	Info[playerid][Big]++;
	Info[playerid][Food] = false;
	format(str, sizeof str, "Your parrot has grown! (%d/5)", Info[playerid][Big]);
	SendClientMessage(playerid, WHITE, str);
	if(Info[playerid][Big] >= 5)
	{
		SendClientMessage(playerid, WHITE, "Your Parrot's Big and Ready to sell, sell to type /SellParrot");
		KillTimer(Info[playerid][Timer]);
	}
	return 1;
}