/*
             .:: Homer's Useful Functions ::.
    - Created in 2008, Last Changes 12th July
    - Coded by Homer
    - Total 13 Functions
	* All Rights Reserved *
	        * 2008 *
	If you are going to use it, don't forgot Credits please and Thanks for Download!
										 Best Regards - Homer
*/
#if defined _HFunction_included
  #endinput
#endif

#define _HFunction_included
#pragma library HFunction

forward CheckSpectating();
forward CheckPos();
forward GetHomerDistanceBetweenPlayers(p1,p2);
forward StartCountDown(amount);
forward IsValidWeapon(wepid);
forward IsValidWeather(wetid);
forward IsValidVehicle(vehid);
forward IsValidSkin(skinid);
forward SetRealTime();
forward SetPlayerMoney(playerid,amount);
forward CrashPlayer(playerid);
forward StartPlayerSpectatePlayer(playerid,specid);
forward StopPlayerSpectatePlayer(playerid);
forward StartCountDown(amount);
forward EnableTagDrawDistance(distance);
forward DisableTagDrawDistance();

/*
	native EnableTagDrawDistance(distance);
	native DisableTagDrawDistance();
	native IsValidWeapon(wepid);
	native IsValidWeather(wetid);
	native IsValidVehicle(vehid);
	native IsValidSkin(skinid);
	native SetRealTime();
	native SetPlayerMoney(playerid,amount);
	native CrashPlayer(playerid);
	native StartPlayerSpectatePlayer(playerid,specid);
	native StopPlayerSpectatePlayer(playerid);
	native StartCountDown(amount);
	native SaveToConfig(const string[])
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
						return 1;
						}else{
						ShowPlayerNameTagForPlayer(p1,p2,0);
						return 1;
					}
 			    }
 			}
 	    } //Count Down
 	    for(new i=0;i<MAX_PLAYERS;i++)
 	    {
 	        if(IsPlayerConnected(i))
			{
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
	            	}else{
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
    NameDist = 0;
    KillTimer(DisTimer);
    return 1;
}
//Usage - Command to get weapon etc. if(IsValidWeapon(***)) ...
public IsValidWeapon(wepid)
{
   if(wepid >= 1 && wepid <= 18 || wepid >= 22 && wepid <= 46)
   {
       return 1;
   }
    return 0;
}
//The same but this is weather. (Dont forgot! Weather 45 - *** is Matrix!)
public IsValidWeather(wetid)
{
   if(wetid >= 1 && wetid <= 50)
   {
       return 1;
   }
    return 0;
}
//Same, but vehicles :P
public IsValidVehicle(vehid)
{
   if(vehid >= 400 && vehid <= 611)
   {
       return 1;
   }
    return 0;
}
//Good function, because if skin isn't valid, you can crash all server players
public IsValidSkin(skinid)
{
   if((skinid == 0) || (skinid == 7) || (skinid >= 9 && skinid <= 41))
   {
       return 1;
   }
   if((skinid >= 66 && skinid <= 73) || (skinid >= 75 && skinid <= 85) || (skinid >= 87 && skinid <= 118))
   {
	   return 1;
   }
   if((skinid >= 120 && skinid <= 148) || (skinid >= 150 && skinid <= 207) || (skinid >= 209 && skinid <= 264))
   {
	   return 1;
   }
   if((skinid >= 43 && skinid <= 64) || (skinid >= 274 && skinid <= 288) || (skinid >= 290 && skinid <= 299))
   {
	   return 1;
   }
   return 0;
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
		}else{
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
                }else{
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

/* 								Stocks Here 								*/
//You can Save Anything into Config, but you need an file Config.txt
stock SaveToConfig(const string[])
{
	new File:CFile;
	if(fexist("config.txt"))
	{
		CFile = fopen("config.txt",io_append);
		fwrite(CFile,string);
		fclose(CFile);
		printf("'%s' has been saved into Config.",string);
	}
}