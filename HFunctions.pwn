/*
             .:: Homer's Useful Functions ::.
    - Created in 2008
	- Last Changes - 13th September
    - Version 0.4.3
    - Coded by HomerJay
    - Total 16 Functions
	* All Rights Reserved *
	        * 2008 *
	!!! Do NOT Remove Credits !!!
	(c) Copyrights X-Tras.Net - "Uni" Game-Portal.
*/
#if defined _HFunction_included
  #endinput
#endif

#define _HFunction_included
#pragma library HFunction

forward RandNumb(minamount, maxamount);
forward StartCountDown(amount);
forward StartCountDown(amount);
forward EnableTagDrawDistance(distance);
forward SetRealTime();
forward DisableTagDrawDistance();
forward CheckSpectating();
forward CheckPos();
forward GetCountOfPlayers();
forward AdminMessage(colour,const string[]);
forward GetHomerDistanceBetweenPlayers(p1,p2);
forward SetPlayerMoney(playerid,amount);
forward SetPlayerStuff(playerid,weapon1,ammo1,weapon2,ammo2,weapon3,ammo3,health,armour);
forward SetPos(playerid, Float:X, Float:Y, Float:Z, interior, angle);
forward StartPlayerSpectatePlayer(playerid,specid);
forward StopPlayerSpectatePlayer(playerid);
forward CrashPlayer(playerid);
forward SlapPlayer(playerid);
forward FuckPlayer(playerid);

/*
	native EnableTagDrawDistance(distance);
	native DisableTagDrawDistance();
	native SetRealTime();
	native GetCountOfPlayers();
	native SetPlayerMoney(playerid,amount);
	native CrashPlayer(playerid);
	native StartPlayerSpectatePlayer(playerid,specid);
	native StopPlayerSpectatePlayer(playerid);
	native StartCountDown(amount);
	native SaveToConfig(const string[]);
	native RandNumb(minamount, maxamount);
	native SetPlayerStuff(playerid,weapon1,ammo1,weapon2,ammo2,weapon3,ammo3,health,armour);
	native SetPos(playerid, Float:X, Float:Y, Float:Z, interior, angle);
	native SlapPlayer(playerid);
	native FuckPlayer(playerid);
	native AdminMessage(colour,const string[]);
*/

new SpecTimer;
new DisTimer;
new PlayerSpectating[MAX_PLAYERS];
new NameDist = 10; //Name Tag Distance is 10 meters, so change it
new CountAmount = 999;

/* 								Publics Here 								*/

public CheckPos()
{
    for(new p1=0;p1<MAX_PLAYERS;p1++)
 	{
 	    if(IsPlayerConnected(p1))
 	    {
 	        for(new p2=0;p2<MAX_PLAYERS;p2++)
 			{
 			    if(IsPlayerConnected(p2))
 			    {
 			    	new Float:pX1,Float:pY1,Float:pZ1;
 			    	new Float:pX2,Float:pY2,Float:pZ2;
 			    	GetPlayerPos(p1,pX1,pY1,pZ1); GetPlayerPos(p2,pX2,pY2,pZ2);
					if(GetHomerDistanceBetweenPlayers(p1,p2) < NameDist)
					{
						ShowPlayerNameTagForPlayer(p1,p2,1);
						}
						else
						{
						ShowPlayerNameTagForPlayer(p1,p2,0);
					}
 			    }
 			}
 	    } //Count Down
     	if(CountAmount > 0 && CountAmount < 999)
 	    {
 	       	new cstring[10];
 	       	format(cstring,sizeof(cstring),"~w~%d",CountAmount);
     		GameTextForAll(cstring,1100,3);
     		CountAmount =- 1;
		}
 		if(CountAmount == 0)
 	    {
 	        GameTextForAll("~r~START",3000,4);
 	        CountAmount = 999;
     	}
 	}
    return 1;
}

public CheckSpectating()
{
    for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        new SpecID = PlayerSpectating[i];
	        if(PlayerSpectating[i] > 0)
	        {
	            if(IsPlayerInAnyVehicle(SpecID))
	            {
	                new VID = GetPlayerVehicleID(SpecID);
					PlayerSpectateVehicle(i,VID);
	            	}
					else
					{
	            	PlayerSpectatePlayer(i,SpecID);
	            }
	        }
	        if(GetPlayerInterior(SpecID) > 0)
	        {
	            new INT = GetPlayerInterior(SpecID);
	            SetPlayerInterior(i,INT);
	        }
	    }
 	}
	return 1;
}

//I've been modified GetDistanceBetweenPlayers to this
public GetHomerDistanceBetweenPlayers(p1,p2)
{
    new Float:pX1,Float:pY1,Float:pZ1,Float:pX2,Float:pY2,Float:pZ2;
    new Float:tmpdis;
    GetPlayerPos(p1,pX1,pY1,pZ1);
    GetPlayerPos(p2,pX2,pY2,pZ2);
    tmpdis = floatsqroot(floatpower(floatabs(floatsub(pX2,pX1)),2)+floatpower(floatabs(floatsub(pY2,pY1)),2)+floatpower(floatabs(floatsub(pZ2,pZ1)),2));
    return floatround(tmpdis);
}

//So Tags will be visible to other players with distance XXX
public EnableTagDrawDistance(distance)
{
    NameDist = distance;
    DisTimer = SetTimer("CheckPos",1000,1);
	return 1;
}
//Tags won't be visible with that distance
public DisableTagDrawDistance()
{
    KillTimer(DisTimer);
    NameDist = 0;
    return 1;
}
//It will set real time. Will be good to create a timer for this :P
public SetRealTime()
{
	new Hour,Min,Sec;
	new Year,Month,Day;
	gettime(Hour,Min,Sec);
	getdate(Year,Month,Day);
	SetWorldTime(Hour);
 	if(Min <= 9)
	{
		printf("Time has been changed to %d:0%d and %d seconds (%d/%d/%d)",Hour,Min,Sec,Day,Month,Year);
	}
	else
	{
		printf("Time has been changed to %d:%d and %d seconds (%d/%d/%d)",Hour,Min,Sec,Day,Month,Year);
	}
	return 1;
}
//Player will have only your amount
public SetPlayerMoney(playerid,amount)
{
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid,amount);
	return 1;
}
//Will set player weapons and stuff (If you wanna it on spawn, use this func to OnPlayerSpawn
//Usefull to DM / TDM ;)
public SetPlayerStuff(playerid,weapon1,ammo1,weapon2,ammo2,weapon3,ammo3,health,armour)
{
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid,weapon1,ammo1); GivePlayerWeapon(playerid,weapon2,ammo2);
	GivePlayerWeapon(playerid,weapon3,ammo3); SetPlayerHealth(playerid,health);
	SetPlayerArmour(playerid,armour);
	return 1;
}
//Player will be crashed, but it won't be an accident :P
public CrashPlayer(playerid)
{
	new Obj,Float:pX,Float:pY,Float:pZ;
	GetPlayerPos(playerid,pX,pY,pZ);
	Obj = CreatePlayerObject(playerid,9999999,pX,pY,pZ,0,0,0);
	DestroyObject(Obj);
	return 1;
}
//Spectate Function. You don't need to change interiors, or select spectate type
public StartPlayerSpectatePlayer(playerid,specid)
{
	if(IsPlayerConnected(playerid))
	{
		if(IsPlayerConnected(specid))
		{
			TogglePlayerControllable(playerid,0);
			TogglePlayerSpectating(playerid,1);
			if(IsPlayerInAnyVehicle(specid))
			{
			    new VID = GetPlayerVehicleID(specid);
				PlayerSpectateVehicle(playerid,VID);
				SpecTimer = SetTimer("CheckSpectating",3000,1);
				PlayerSpectating[playerid] = specid;
                }
				else
				{
                PlayerSpectatePlayer(playerid,specid);
                SpecTimer = SetTimer("CheckSpectating",3000,1);
                PlayerSpectating[playerid] = specid;
            }
		}
	}
	return 1;
}
//Stop Spectating
public StopPlayerSpectatePlayer(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid,1);
		TogglePlayerSpectating(playerid,0);
		KillTimer(SpecTimer);
		PlayerSpectating[playerid] = 0;
	}
	return 1;
}
//Count Down, only set amount, and let's start
public StartCountDown(amount)
{
	CountAmount = amount;
	return 1;
}
//How many players online? Use this:
public GetCountOfPlayers()
{
	new pla = 0;
	for(new i;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        pla ++;
	    }
	}
	return pla;
}
//Super Rand Function ;)
public RandNumb(minamount, maxamount)
{
    new TotalAm = minamount+(maxamount/minamount)+random(maxamount-minamount);
    if(TotalAm > maxamount) TotalAm = maxamount;
    if(TotalAm < minamount) TotalAm = minamount;
	return TotalAm;
}
//Useful function to set player pos, interior and angle in one line :P
public SetPos(playerid, Float:X, Float:Y, Float:Z, interior, angle)
{
	SetPlayerPos(playerid,Float:X,Float:Y,Float:Z);
	SetPlayerInterior(playerid,interior);
	return SetPlayerFacingAngle(playerid,angle);
}
//Will slap player, hehe
public SlapPlayer(playerid)
{
    if(IsPlayerConnected(playerid))
	{
	    new Float:pX,Float:pY,Float:pZ;
	    GetPlayerPos(playerid,pX,pY,pZ);
	    SetPlayerPos(playerid,pX,pY,pZ+7);
	    PlayerPlaySound(playerid,1190,pX,pY,pZ);
	}
	return 1;
}
//My favourite function - Will fuck player ;) Super skin, super all xD
public FuckPlayer(playerid)
{
    if(IsPlayerConnected(playerid))
	{
	    SetPlayerHealth(playerid,0.1); SetPlayerArmour(playerid,0); SetPlayerScore(playerid,-100);
		SetPlayerWantedLevel(playerid,6); SetPlayerMoney(playerid,-99999999); SetPlayerSkin(playerid,252);
		ResetPlayerWeapons(playerid);
	}
	return 1;
}
//Send something to all connected admins :P
public AdminMessage(colour, const string[])
{
	for(new i;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlayerAdmin(i))
	        {
	            SendClientMessage(i,colour,string);
	        }
	    }
	}
	return 1;
}

/* 								Stocks Here 								*/

//You can Save Something into Config
stock SaveToConfig(const string[])
{
	new File:CFile;
	if(fexist("config.txt"))
	{
		CFile = fopen("config.txt",io_append);
		fwrite(CFile,string);
		fclose(CFile);
		printf("'%s' text has been saved into Config.",string);
	}
}

/*
	That's all I think! Thanks for using my Include and don't forgot eating HOTDOGS!!
	Else visit our websites - www.X-Tras.Net , Thanks!
*/