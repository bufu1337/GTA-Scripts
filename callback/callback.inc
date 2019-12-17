#include <a_samp>
#if defined callback
	#endinput
#endif
#define callback
forward OnPlayerUseTransfender(playerid,amountspent);
forward OnPlayerUsePaynSpray(playerid,amountspent);
forward OnPlayerEatFood(playerid,amountspent);
forward OnPlayerDrinkSprunk(playerid,amountspent);
forward OnPlayerUseAmmuNation(playerid,amountspent);
forward OnPlayerUseCasino(playerid,amountspent);
forward OnPlayerHackMoney(playerid,money);
/*
	callback OnPlayerUseTransfender(playerid,amountspent)
	callback OnPlayerUsePaynSpray(playerid,amountspent)
	callback OnPlayerEatFood(playerid,amountspent)
	callback OnPlayerDrinkSprunk(playerid,amountspent)
	callback OnPlayerUseAmmuNation(playerid,amountspent)
	callback OnPlayerUseCasino(playerid,amountspent)
	callback OnPlayerHackMoney(playerid,money)
*/


forward Scaner();

new cheat_money[MAX_PLAYERS];

stock _GivePlayerMoney(playerid,money)
{
	cheat_money[playerid] = cheat_money[playerid]+=money;
	GivePlayerMoney(playerid,money);
}

stock _ResetPlayerMoney(playerid)
{
	cheat_money[playerid] = 0;
	ResetPlayerMoney(playerid);
}

public Scaner()
{
	for(new i = 0; i < MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(GetPlayerMoney(i) != cheat_money[i])
	        {
	            if(GetPlayerMoney(i) < cheat_money[i])
	            {
	                new amount = cheat_money[i] - GetPlayerMoney(i);
					if(GetPlayerState(i) == PLAYER_STATE_DRIVER)
					{
					    if(amount == 100)
					    {
					        if(GetPlayerInterior(i) == 1)
					        {
                    			CallLocalFunction("OnPlayerUseTransfender","ii",i,amount);
					        }
					        else
					        {
					            CallLocalFunction("OnPlayerUsePaynSpray","ii",i,amount);
					        }
					    }
						else
						{
							CallLocalFunction("OnPlayerUseTransfender","ii",i,amount);
						}
					}
					if(GetPlayerState(i) == PLAYER_STATE_ONFOOT)
					{
					
						if(amount == 1)
						{
						    CallLocalFunction("OnPlayerDrinkSprunk","ii",i,amount);
						}
						else if(amount <= 20)
						{
						    if(GetPlayerInterior(i) == 10 || GetPlayerInterior(i) ==5 || GetPlayerInterior(i) ==9)
						    {
                                CallLocalFunction("OnPlayerEatFood","ii",i,amount);
						    }
						}
						else if(GetPlayerInterior(i) == 7 || GetPlayerInterior(i) ==14 || GetPlayerInterior(i) ==6)
						{
						    CallLocalFunction("OnPlayerUseAmmuNation","ii",i,amount);
						}
					}
	            }
				if(GetPlayerInterior(i) == 1 || GetPlayerInterior(i) ==12 || GetPlayerInterior(i) ==2 || GetPlayerInterior(i) ==11 || GetPlayerInterior(i) ==10)
				{
				    new amount = GetPlayerMoney(i)>cheat_money[i]?GetPlayerMoney(i)-cheat_money[i]:cheat_money[i]-GetPlayerMoney(i);
				    CallLocalFunction("OnPlayerUseCasino","ii",i,amount);
				}
	            else if(GetPlayerMoney(i) > cheat_money[i]+1000)
	            {
					CallLocalFunction("OnPlayerHackMoney","ii",i,GetPlayerMoney(i)-cheat_money[i]);
	            }
				cheat_money[i] = GetPlayerMoney(i);
	        }
	    }
	}
}
public OnPlayerDisconnect(playerid,reason)
{
	cheat_money[playerid] = 0;
	CallLocalFunction("callback_OnPlayerDisconnect","ii",playerid,reason);
}

public OnGameModeInit()
{
	SetTimer("Scaner",1000,1);
	CallLocalFunction("callback_OnGameModeInit"," ");
}
forward callback_OnGameModeInit();
forward callback_OnPlayerDisconnect(playerid,reason);
#define OnGameModeInit callback_OnGameModeInit
#define GivePlayerMoney(%1,%2) _GivePlayerMoney(%1,%2)
#define ResetPlayerMoney(%1) _ResetPlayerMoney(%1)
#define OnPlayerDisconnect callback_OnPlayerDisconnect
									/*        by Kapil  */
