// Moneyz
//By Backwardsman97

#include <a_samp>

new PMoney[MAX_PLAYERS];
new MoneyHide[MAX_PLAYERS];
new Text:MoneyText[MAX_PLAYERS];
new Text:WMoneyText[MAX_PLAYERS];

forward HideMoneyText(playerid);

public OnFilterScriptInit()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			OnPlayerConnect(i);
		}
	}
	return 1;
}

public OnFilterScriptExit()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			TextDrawDestroy(MoneyText[i]);
			TextDrawDestroy(WMoneyText[i]);
		}
	}
	return 1;
}


public OnPlayerConnect(playerid)
{
   	MoneyText[playerid] = TextDrawCreate(608.000000,95.000000,"-1000");
	TextDrawAlignment(MoneyText[playerid],3);
	TextDrawBackgroundColor(MoneyText[playerid],0x000000ff);
	TextDrawFont(MoneyText[playerid],3);
	TextDrawLetterSize(MoneyText[playerid],0.575999,2.230000);
	TextDrawColor(MoneyText[playerid],0xff000099);
	TextDrawSetOutline(MoneyText[playerid],1);
	TextDrawSetShadow(MoneyText[playerid],10);
	
	WMoneyText[playerid] = TextDrawCreate(608.000000,122.000000,"-1000");
	TextDrawAlignment(WMoneyText[playerid],3);
	TextDrawBackgroundColor(WMoneyText[playerid],0x000000ff);
	TextDrawFont(WMoneyText[playerid],3);
	TextDrawLetterSize(WMoneyText[playerid],0.575999,2.230000);
	TextDrawColor(WMoneyText[playerid],0xff000099);
	TextDrawSetOutline(WMoneyText[playerid],1);
	TextDrawSetShadow(WMoneyText[playerid],10);
	return 1;
}

public OnPlayerDisconnect(playerid)
{
    TextDrawDestroy(MoneyText[playerid]);
    TextDrawDestroy(WMoneyText[playerid]);
	return 1;
}

public OnPlayerUpdate(playerid)
{
	new MStringy[128];
	new money = GetPlayerMoney(playerid);
	valstr(MStringy,money - PMoney[playerid]);
	if(strlen(MStringy)<=8)
	{
	    new Stringy[128];
    	new minm = money - PMoney[playerid];
    	if(minm != 0)
    	{
			if(minm < 0)
			{
				format(Stringy,sizeof(Stringy),"%d",minm);
				if(!GetPlayerWantedLevel(playerid))
				{
    				TextDrawSetString(MoneyText[playerid],Stringy);
				    TextDrawColor(MoneyText[playerid],0xff000099);
				    TextDrawShowForPlayer(playerid,MoneyText[playerid]);
				}
				else
				{
				    TextDrawSetString(WMoneyText[playerid],Stringy);
				    TextDrawColor(WMoneyText[playerid],0xff000099);
					TextDrawShowForPlayer(playerid,WMoneyText[playerid]);
				}
			}
			else
			{
				format(Stringy,sizeof(Stringy),"+%d",minm);
				if(!GetPlayerWantedLevel(playerid))
				{
    				TextDrawSetString(MoneyText[playerid],Stringy);
				    TextDrawColor(MoneyText[playerid],0x295921FF);
				    TextDrawShowForPlayer(playerid,MoneyText[playerid]);
				}
				else
				{
				    TextDrawSetString(WMoneyText[playerid],Stringy);
				    TextDrawColor(WMoneyText[playerid],0x295921FF);
					TextDrawShowForPlayer(playerid,WMoneyText[playerid]);
				}
			}
			KillTimer(MoneyHide[playerid]);
			MoneyHide[playerid]=SetTimerEx("HideMoneyText",4000,0,"i",playerid);
		}
		PMoney[playerid] = money;
	}
}

public HideMoneyText(playerid)
{
	TextDrawHideForPlayer(playerid,MoneyText[playerid]);
	TextDrawHideForPlayer(playerid,WMoneyText[playerid]);
	return 1;
}



