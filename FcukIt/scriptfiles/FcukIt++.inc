/*
==============================
    FcukIt Anti-Cash-Cheat
	    Include File
      Coded By Scarface
==============================
*/

forward cCheck();
forward aBan();
forward aKick();


new aCash = 1; // 0 = Disabled || 1 = Kick || 2 = Ban

#define LOOP_TIME 10000 // Loop Interval (MilliSeconds)

#define FcukIt_INIT SetTimer("cCheck", LOOP_TIME, 1);
#define FcukIt_DISCONNECT Disconnect(playerid);

new KickTimer[MAX_PLAYERS], BanTimer[MAX_PLAYERS]; // K/B Arrays
new CashCount[MAX_PLAYERS];
new tcash;

FcukIt_GivePlayerMoney(playerid, amount)
{
	tcash = CashCount[playerid];
	CashCount[playerid] = (tcash + amount);
	GivePlayerMoney(playerid, amount);
}

FcukIt_ResetPlayerMoney(playerid)
{
	ResetPlayerMoney(playerid);
	CashCount[playerid] = 0;
}

public cCheck()
{
for(new c=0;c<MAX_PLAYERS;c++)
	{
		new rCash = GetPlayerMoney(c);
		if(IsPlayerConnected(c))
		{
			new cString[128];
			if(rCash != CashCount[c])
			{
				new stuntcash = 500;
				new tcash2;
				tcash2 = rCash-CashCount[c];
				if(tcash2 > stuntcash && CashCount[c] < rCash)
				{
					if(!IsPlayerGambling(c))
					{
						if(rCash > CashCount[c])
						{
							if(aCash == 1)
							{
 								format(cString, sizeof(cString),"<FcukIt Detected> %s Money Cheating (Kicked)", PlayerName(c));
								SendClientMessageToAll(0xFFFF00AA, cString);
								KickTimer[c] = 1;
								SetTimer("aKick",500,0);
							}
							else if(aCash == 2)
							{
		    					format(cString, sizeof(cString),"<FcukIt Detected> %s Money Cheating (Banned)", PlayerName(c));
								SendClientMessageToAll(0xFFFF00AA, cString);
								BanTimer[c] = 1;
								SetTimer("aBan",750,0);
							}
						}
						else {
						CashCount[c] = rCash;
						}
					}
					else {
					CashCount[c] = rCash;
					}
 				}
				else {
				CashCount[c] = rCash;
				}
 			}
		}
	}
}

PlayerName(playerid)
{
  new pName[32];
  GetPlayerName(playerid, pName, sizeof(pName));
  return pName;
}

Disconnect(playerid)
{
	CashCount[playerid] = 0;
	BanTimer[playerid] = 0;
	KickTimer[playerid] = 0;
}

IsPlayerGambling(playerid)
{
	new Float:bX;
	new Float:bY;
	new Float:bZ;
	GetPlayerPos(playerid, Float:bX, Float:bY, Float:bZ);

	if((Float:bX > 1925.1527 && Float:bX < 1975.8721) && (Float:bY > 968.2526 && Float:bY < 1052.2089)){
	return 1;
	}

	if((Float:bX > 2161.6980 && Float:bX < 2281.1763) && (Float:bY > 1557.5767 && Float:bY < 1630.5237)){
	return 1;
	}
	return 0;
	}

/*
===================
  Kick/Ban Timers
===================
*/

public aBan()
{
for(new k=0;k<MAX_PLAYERS;k++)
	{
		if(IsPlayerConnected(k))
		{
		    if(BanTimer[k] == 1)
		    {
		    BanTimer[k] = 0;
		    Ban(k);
		    }
		}
	}
}

public aKick()
{
for(new j=0;j<MAX_PLAYERS;j++)
	{
		if(IsPlayerConnected(j))
		{
		    if(KickTimer[j] == 1)
		    {
		    KickTimer[j] = 0;
		    Kick(j);
		    }
		}
	}
}