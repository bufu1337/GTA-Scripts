//Fishing System Made By Fre$hKidd
//PLEASE DO NOT STEAL THIS FILTERSCRIPT OR EDIT THE CREDITS OR EVEN EDITING IT AND SAYING IT'S YOURS!!!

#include <a_samp>
#include "../include/gl_common.inc"
new RodObject;
new FishMarketIcon;
new FRod[MAX_PLAYERS];
new Fishing[MAX_PLAYERS];
new Bait[MAX_PLAYERS];
new FLine[MAX_PLAYERS];
forward VaildFishPlace(playerid);
forward FishTimer(playerid);
forward AnimFixer(playerid);
forward LeavePosition(playerid);
#if defined FILTERSCRIPT


public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" FISHING SYSTEM Loaded.....");
	print(" Made By Fre$hKidd                      ");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print("FISHING SYSTEM unLoaded");
	print("----------------------------------\n");
}

#endif

public OnGameModeInit()
{
    Create3DTextLabel("FishMarket",0xFFFFDD,434.2810,-1894.9282,3.4078+0.75,20.0,0,1);
	FishMarketIcon = CreatePickup(1318, 2, 387.8272,-1870.7032,7.8359, -1);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/fishhelp", cmdtext, true, 10) == 0)
	{
 		SendClientMessage(playerid,0xFFFFFFFF, "Fishing {88AA18}Commands:");
   		SendClientMessage(playerid,0xDCDCDCFF, "General: /fishmarket , /stopfish , /fish");
   		SendClientMessage(playerid,0xDCDCDCFF, "FishRod: /takerod , /hiderod");
   		SendClientMessage(playerid,0xDCDCDCFF, "FishMarket: /buyrod , /buybait , /buyline");
		return 1;
	}
	if (strcmp("/takerod", cmdtext, true, 10) == 0)
	{
	    if(FRod[playerid] == 1)
		{
		    FRod[playerid] = 2;
		    RodObject = SetPlayerAttachedObject(playerid, 0,18632,6,0.079376,0.037070,0.007706,181.482910,0.000000,0.000000,1.000000,1.000000,1.000000);
		}
		else
  		{
  		SendClientMessage(playerid,0xCD0000FF, "You don't have any Fishing Rod !");
		}
		return 1;
	}
	if (strcmp("/hiderod", cmdtext, true, 10) == 0)
	{
	    if(FRod[playerid] == 2 || FRod[playerid] == 1 || Fishing[playerid] == 0)
		{
		    FRod[playerid] = 1;
		    RemovePlayerAttachedObject(playerid,0);
		    RemovePlayerAttachedObject(playerid,RodObject);
		}
		else
  		{
  		SendClientMessage(playerid,0xCD0000FF, "You don't have any Fishing Rod, or mabye you are fishing !");
		}
		return 1;
	}
	if (strcmp("/stopfish", cmdtext, true, 10) == 0)
	{
	    if(Fishing[playerid] == 1)
		{
		    Fishing[playerid] = 0;
		    TogglePlayerControllable(playerid, 1);
		    ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, 0, 0, 0, 0, 0);
		    SendClientMessage(playerid,0xDCDCDCFF,"Fishing has been Stopped");
		    GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~r~Fishing Stopped", 3000, 3);
		}
		else
  		{
  		SendClientMessage(playerid,0xCD0000FF, "You are not even fishing !");
		}
		return 1;
	}
	if (strcmp("/fishmarket", cmdtext, true, 10) == 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 2, 387.8272,-1870.7032,7.8359))
		{
		    SendClientMessage(playerid,0xFFFFFFFF, "Available {88AA88}Commands:");
		    SendClientMessage(playerid,0xDCDCDCFF, "Fishing Rod 400$ - /buyrod");
		    SendClientMessage(playerid,0xDCDCDCFF, "Mixed Baits 250$ - /buybait");
		    SendClientMessage(playerid,0xDCDCDCFF, "Fishing Line 100$ - /buyline");
		}
		else
  		{
  		SendClientMessage(playerid,0xCD0000FF, "You are not around Fish Market !");
		}
		return 1;
	}
	if (strcmp("/buyrod", cmdtext, true, 10) == 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 2, 387.8272,-1870.7032,7.8359) && GetPlayerMoney(playerid) >= 400)
		{
			if(FRod[playerid] == 0)
			{
			FRod[playerid] = 1;
		    SendClientMessage(playerid,0xFFFFFFFF, "Fishing Rod {88AA88}Bought!");
		    SendClientMessage(playerid,0xFFFFFFFF, "/TakeRod to Take it out!");
		    GivePlayerMoney(playerid,-400);
		    }
		    else
			{
   			SendClientMessage(playerid,0xCD0000FF, "You already got Fishing Rod, you may /takerod !");
   			SendClientMessage(playerid,0xCD0000FF, "Or mabye you don't have enough cash to buy it !");
			}
		    return 1;
   		}
		return SendClientMessage(playerid,0xCD0000FF, "You are not around Fish Market !");
	}
	if (strcmp("/buybait", cmdtext, true, 10) == 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 2, 387.8272,-1870.7032,7.8359) && GetPlayerMoney(playerid) >= 250)
		{
			if(Bait[playerid] == 0)
			{
			Bait[playerid] = 1;
		    SendClientMessage(playerid,0xFFFFFFFF, " Mixed Baits {88AA88}Bought!");
		    GivePlayerMoney(playerid,-250);
		    }
		    else
			{
   			SendClientMessage(playerid,0xCD0000FF, "You already got Mixed Baits left!");
   			SendClientMessage(playerid,0xCD0000FF, "Or mabye you don't have enough cash to buy it!");
			}
		    return 1;
		}
		return SendClientMessage(playerid,0xCD0000FF, "You are not around Fish Market !");
	}
	if (strcmp("/buyline", cmdtext, true, 10) == 0)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 2, 387.8272,-1870.7032,7.8359) && GetPlayerMoney(playerid) >= 400)
  		{
			if(FLine[playerid] == 0)
			{
			FLine[playerid] = 10;
		    SendClientMessage(playerid,0xFFFFFFFF, "Fishing Line {88AA88}Bought!");
		    GivePlayerMoney(playerid,-400);
			}
		    else
			{
   			SendClientMessage(playerid,0xCD0000FF, "You already got Fishing Lines !");
			}
		    return 1;
   		}
		return SendClientMessage(playerid,0xCD0000FF, "You are not around Fish Market !");
	}
	if (strcmp("/fish", cmdtext, true, 10) == 0)
	{
	    if(VaildFishPlace(playerid) && !IsPlayerInAnyVehicle(playerid))
		{
			if(Bait[playerid] > 0)
			{
			    if(FLine[playerid] > 0)
			    {
			    	if(FRod[playerid] == 2)
			    	{
			    		if(Fishing[playerid] == 0)
			    		{
						TogglePlayerControllable(playerid, 0);
			    		ApplyAnimation(playerid,"SWORD","sword_block",50.0,0,1,0,1,1);
						Fishing[playerid] = 1;
						SetTimerEx("FishTimer", 50000, false, "i", playerid);
						SetTimerEx("LeavePosition", 40000, false, "i", playerid);
						SetTimerEx("AnimFixer", 1000, false, "i", playerid);
						SendClientMessage(playerid,0xFFFFFFFF, "You have threw the bait in the sea, wait for results...");
						GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~w~reels in the sea, waiting for ~g~results....", 49000, 3);
	            		}
	            		else
	            		{
                        SendClientMessage(playerid,0xCD0000FF, "You already Fishing !");
                        }
    					return 1;
	            	}
					return SendClientMessage(playerid,0xCD0000FF, "You do not have any Fishing Rod on your hands !");
			    }
			    return SendClientMessage(playerid,0xCD0000FF, "You do not have any Fishing Lines left !");
   			}
   			return SendClientMessage(playerid,0xCD0000FF, "You do not have any Baits left !");
		}
		return SendClientMessage(playerid,0xCD0000FF, "You are not around a vaild Fishing Place !");
	}
	return 0;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    if(pickupid == FishMarketIcon)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Fish Market !");
        SendClientMessage(playerid, 0xFFFFFFFF, "Type {88AA88}/fishmarket {88AA88} for help.");
    }
    return 1;
}

public VaildFishPlace(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    if(IsPlayerInRangeOfPoint(playerid, 4,403.8266,-2088.7598,7.8359) || IsPlayerInRangeOfPoint(playerid, 4,398.7553,-2088.7490,7.8359))
		{
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 4,396.2197,-2088.6692,7.8359) || IsPlayerInRangeOfPoint(playerid, 4,391.1094,-2088.7976,7.8359))
		{
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 4,383.4157,-2088.7849,7.8359) || IsPlayerInRangeOfPoint(playerid, 4,374.9598,-2088.7979,7.8359))
		{
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 4,369.8107,-2088.7927,7.8359) || IsPlayerInRangeOfPoint(playerid, 4,367.3637,-2088.7925,7.8359))
		{
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 4,362.2244,-2088.7981,7.8359) || IsPlayerInRangeOfPoint(playerid, 4,354.5382,-2088.7979,7.8359))
		{
		    return 1;
		}
	}
	return 0;
}

public FishTimer(playerid)
{
	if(VaildFishPlace(playerid))
	{
	    if(Fishing[playerid] == 1)
	    {
     		new fish = random(5);
			new fishname[100];
			new string[256];
			if(fish == 1) { fishname = "Salamon"; }
			else if(fish == 2) { fishname = "Tuna"; }
			else if(fish == 3) { fishname = "Little Shark"; }
			else if(fish == 4) { fishname = "China Rare"; }
			else if(fish == 5) { fishname = "Complanton"; }
			else { fishname = "{F222FF}Nothing, {FFFFFF}Line Snapped out !"; }
			format(string, sizeof(string), "You have caughted {88AA88}%s", fishname);
			SendClientMessage(playerid,0xFFFFFFFF, string);
			if(fish == 1) { fishname = "150$"; }
			else if(fish == 2) { fishname = "200$"; }
			else if(fish == 3) { fishname = "300$"; }
			else if(fish == 4) { fishname = "500$"; }
			else if(fish == 5) { fishname = "400$"; }
			else { fishname = "{F222FF}Nothing, {FFFFFF}You better go buy new fishing line !"; }
			format(string, sizeof(string), "You have earned {88AA88}%s {FFFFFF}", fishname);
			SendClientMessage(playerid,0xFFFFFFFF, string);
			if(fish == 1) { GivePlayerMoney(playerid,150); }
			else if(fish == 2) { GivePlayerMoney(playerid,200); }
			else if(fish == 3) { GivePlayerMoney(playerid,300); }
			else if(fish == 4) { GivePlayerMoney(playerid,500); }
			else if(fish == 5) { GivePlayerMoney(playerid,400); }
			else { FLine[playerid] = 0; }
			Fishing[playerid] = 0;
	        TogglePlayerControllable(playerid, 1);
	        ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, 0, 0, 0, 0, 0);
	    }
	}
}

public AnimFixer(playerid)
{
	if(VaildFishPlace(playerid))
	{
	    if(Fishing[playerid] == 1)
	    {
	    SetCameraBehindPlayer(playerid);
   		ApplyAnimation(playerid,"SWORD","sword_block",50.0,0,1,0,1,1);
	    }
	}
}
public LeavePosition(playerid)
{
	if(!VaildFishPlace(playerid))
	{
	    if(Fishing[playerid] == 1)
	    {
	    Fishing[playerid] = 0;
	    SetCameraBehindPlayer(playerid);
   		ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, 0, 0, 0, 0, 0);
	    }
	}
}