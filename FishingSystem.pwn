#define FILTERSCRIPT

#include <a_samp>
#include <dini>
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define grey 0xAFAFAFAA
enum FInfo
{
	pFishes,
	pFishName1[20],
	pFishName2[20],
	pFishName3[20],
	pFishName4[20],
	pFishName5[20],
	pFish[5],
	pFishWeight1,
	pFishWeight2,
	pFishWeight3,
	pFishWeight4,
	pFishWeight5,
	pFishBait[4],
	pFishBaitUsing,
	pFishBattle,
	Float:pPower
}
new Fishes[MAX_PLAYERS][FInfo];
new Text: BarBorderText1[MAX_PLAYERS];
new Text: BarBorderText2[MAX_PLAYERS];
new Text: LeftBorder[MAX_PLAYERS];
new Text: RightBorder[MAX_PLAYERS];
new Text: HelpText1[MAX_PLAYERS];
new Text: HelpText2[MAX_PLAYERS];
new Text: FishOMeterBar[MAX_PLAYERS];
new LineSnapped[MAX_PLAYERS] = 0;
new FishCatchTimer[MAX_PLAYERS];
new FishPowerTimer[MAX_PLAYERS];
new FishDelay[MAX_PLAYERS];

new baitshopenter;
new baitshopexit;

new FishNamesNumber = 6;
new FishNames[6][16] = {
{"Carp"},
{"Pike"},
{"Perch"},
{"Bream"},
{"Tench"},
{"Trout"}
};
forward IsATropic(playerid);
forward FishCatch(playerid);
forward FishPower(playerid);

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Fishing System by Lucky13 Loaded");
	print("--------------------------------------\n");
	baitshopenter = CreatePickup(1318,2,681.4594,-475.0681,16.5363);
	baitshopexit = CreatePickup(1318,2,-227.027999,1401.229980,27.765625);
	return 1;
}

public OnFilterScriptExit()
{
    DestroyPickup(baitshopenter);
	DestroyPickup(baitshopexit);
	return 1;
}

public IsATropic(playerid)
{
    if(IsPlayerConnected(playerid))
	{
	    new vehicleid = GetVehicleModel(GetPlayerVehicleID(playerid));
		if(vehicleid == 454)
		{
			return 1;
		}
	}
	return 0;
}
public OnPlayerConnect(playerid)
{
	new string[248];
    LineSnapped[playerid] = 0;
	FishDelay[playerid] = 0;
    Fishes[playerid][pFishes] = 0;
	Fishes[playerid][pFish][0] = 0;
	Fishes[playerid][pFish][1] = 0;
	Fishes[playerid][pFish][2] = 0;
	Fishes[playerid][pFish][3] = 0;
	Fishes[playerid][pFish][4] = 0;
	Fishes[playerid][pFishWeight1] = 0;
	Fishes[playerid][pFishWeight2] = 0;
	Fishes[playerid][pFishWeight3] = 0;
	Fishes[playerid][pFishWeight4] = 0;
	Fishes[playerid][pFishWeight5] = 0;
	Fishes[playerid][pFishBait][0] = 0;
	Fishes[playerid][pFishBait][1] = 0;
	Fishes[playerid][pFishBait][2] = 0;
	Fishes[playerid][pFishBait][3] = 0;
	Fishes[playerid][pFishBaitUsing] = 0;
	Fishes[playerid][pFishBattle] = 0;
	Fishes[playerid][pPower] = 0.0;

	format(string,sizeof(string),"None");
	strmid(Fishes[playerid][pFishName1], string, 0, strlen(string), 255);
	strmid(Fishes[playerid][pFishName2], string, 0, strlen(string), 255);
	strmid(Fishes[playerid][pFishName3], string, 0, strlen(string), 255);
	strmid(Fishes[playerid][pFishName4], string, 0, strlen(string), 255);
	strmid(Fishes[playerid][pFishName5], string, 0, strlen(string), 255);

	new formatZ[256],pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pName,sizeof(pName));
	format(formatZ,sizeof(formatZ),"/Fishes/%s.ini",pName);
	if(dini_Exists(formatZ))
	{
    	Fishes[playerid][pFishes] = dini_Int(formatZ,"Fishes");
    	Fishes[playerid][pFishBait][0] = dini_Int(formatZ,"Cheese");
    	Fishes[playerid][pFishBait][1] = dini_Int(formatZ,"Worms");
    	Fishes[playerid][pFishBait][2] = dini_Int(formatZ,"Crabs");
    	Fishes[playerid][pFishBait][3] = dini_Int(formatZ,"Octopus");
    	Fishes[playerid][pFishName1] = dini_Int(formatZ,"Fish 1 Name");
    	Fishes[playerid][pFishName2] = dini_Int(formatZ,"Fish 2 Name");
    	Fishes[playerid][pFishName3] = dini_Int(formatZ,"Fish 3 Name");
    	Fishes[playerid][pFishName4] = dini_Int(formatZ,"Fish 4 Name");
    	Fishes[playerid][pFishName5] = dini_Int(formatZ,"Fish 5 Name");
    	Fishes[playerid][pFishWeight1] = dini_Int(formatZ,"Fish Weight 1");
    	Fishes[playerid][pFishWeight2] = dini_Int(formatZ,"Fish Weight 2");
    	Fishes[playerid][pFishWeight3] = dini_Int(formatZ,"Fish Weight 3");
    	Fishes[playerid][pFishWeight4] = dini_Int(formatZ,"Fish Weight 4");
    	Fishes[playerid][pFishWeight5] = dini_Int(formatZ,"Fish Weight 5");
    	Fishes[playerid][pFish][0] = dini_Int(formatZ,"Fish 1");
    	Fishes[playerid][pFish][1] = dini_Int(formatZ,"Fish 2");
    	Fishes[playerid][pFish][2] = dini_Int(formatZ,"Fish 3");
    	Fishes[playerid][pFish][3] = dini_Int(formatZ,"Fish 4");
    	Fishes[playerid][pFish][4] = dini_Int(formatZ,"Fish 5");
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new string[248];
    new formatZ[256],pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pName,sizeof(pName));
	format(formatZ,sizeof(formatZ),"/Fishes/%s.ini",pName);
    if(dini_Exists(formatZ))
 	{
		dini_IntSet(formatZ,"Fishes",Fishes[playerid][pFishes]);
    	dini_IntSet(formatZ,"Cheese",Fishes[playerid][pFishBait][0]);
    	dini_IntSet(formatZ,"Worms",Fishes[playerid][pFishBait][1]);
    	dini_IntSet(formatZ,"Crabs",Fishes[playerid][pFishBait][2]);
    	dini_IntSet(formatZ,"Octopus",Fishes[playerid][pFishBait][3]);
     	dini_IntSet(formatZ,"Fish 1 Name",Fishes[playerid][pFishName1]);
    	dini_IntSet(formatZ,"Fish 2 Name",Fishes[playerid][pFishName2]);
    	dini_IntSet(formatZ,"Fish 3 Name",Fishes[playerid][pFishName3]);
    	dini_IntSet(formatZ,"Fish 4 Name",Fishes[playerid][pFishName4]);
    	dini_IntSet(formatZ,"Fish 5 Name",Fishes[playerid][pFishName5]);
    	dini_IntSet(formatZ,"Fish Weight 1",Fishes[playerid][pFishWeight1]);
    	dini_IntSet(formatZ,"Fish Weight 2",Fishes[playerid][pFishWeight2]);
    	dini_IntSet(formatZ,"Fish Weight 3",Fishes[playerid][pFishWeight3]);
    	dini_IntSet(formatZ,"Fish Weight 4",Fishes[playerid][pFishWeight4]);
    	dini_IntSet(formatZ,"Fish Weight 5",Fishes[playerid][pFishWeight5]);
    	dini_IntSet(formatZ,"Fish 1",Fishes[playerid][pFish][0]);
    	dini_IntSet(formatZ,"Fish 2",Fishes[playerid][pFish][1]);
    	dini_IntSet(formatZ,"Fish 3",Fishes[playerid][pFish][2]);
    	dini_IntSet(formatZ,"Fish 4",Fishes[playerid][pFish][3]);
    	dini_IntSet(formatZ,"Fish 5",Fishes[playerid][pFish][4]);
	}

	if(Fishes[playerid][pFishBattle] == 1)
	{
	    TextDrawDestroy(BarBorderText1[playerid]);
		TextDrawDestroy(BarBorderText2[playerid]);
		TextDrawDestroy(LeftBorder[playerid]);
		TextDrawDestroy(RightBorder[playerid]);
		TextDrawDestroy(HelpText1[playerid]);
		TextDrawDestroy(HelpText2[playerid]);
		TextDrawDestroy(FishOMeterBar[playerid]);
	}
	LineSnapped[playerid] = 0;
	FishDelay[playerid] = 0;
    Fishes[playerid][pFishes] = 0;
	Fishes[playerid][pFish][0] = 0;
	Fishes[playerid][pFish][1] = 0;
	Fishes[playerid][pFish][2] = 0;
	Fishes[playerid][pFish][3] = 0;
	Fishes[playerid][pFish][4] = 0;
	Fishes[playerid][pFishWeight1] = 0;
	Fishes[playerid][pFishWeight2] = 0;
	Fishes[playerid][pFishWeight3] = 0;
	Fishes[playerid][pFishWeight4] = 0;
	Fishes[playerid][pFishWeight5] = 0;
	Fishes[playerid][pFishBait][0] = 0;
	Fishes[playerid][pFishBait][1] = 0;
	Fishes[playerid][pFishBait][2] = 0;
	Fishes[playerid][pFishBait][3] = 0;
	Fishes[playerid][pFishBaitUsing] = 0;
	Fishes[playerid][pFishBattle] = 0;
	Fishes[playerid][pPower] = 0.0;

	format(string,sizeof(string),"None");
	strmid(Fishes[playerid][pFishName1], string, 0, strlen(string), 255);
	strmid(Fishes[playerid][pFishName2], string, 0, strlen(string), 255);
	strmid(Fishes[playerid][pFishName3], string, 0, strlen(string), 255);
	strmid(Fishes[playerid][pFishName4], string, 0, strlen(string), 255);
	strmid(Fishes[playerid][pFishName5], string, 0, strlen(string), 255);
	return 1;
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

//------------------------------------------------
public OnPlayerCommandText(playerid, cmdtext[])
{
    new string[248];
	new cmd[256];
	new idx;
	cmd = strtok(cmdtext, idx);
	if (strcmp(cmd,"/fish",true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
		    if(!IsATropic(playerid))
		    {
		        SendClientMessage(playerid,grey," You must drive a Tropic Boat while you type /fish.");
		        return 1;
			}
			else
			{
 				if(Fishes[playerid][pFish][0] > 0 && Fishes[playerid][pFish][1] > 0 && Fishes[playerid][pFish][2] > 0 && Fishes[playerid][pFish][3] > 0 && Fishes[playerid][pFish][4] > 0)
	  			{
    				SendClientMessage(playerid,grey," You can't load more than 5 fishes!");
      				return 1;
		  		}
    			else
		  		{
    				if(Fishes[playerid][pFishBait][0] <= 0 && Fishes[playerid][pFishBait][1] <= 0 && Fishes[playerid][pFishBait][2] <= 0 && Fishes[playerid][pFishBait][3] <= 0)
      				{
        				SendClientMessage(playerid,grey," You don't have any Fish Bait to use!");
        				return 1;
					}
					else
					{
    					if(FishDelay[playerid] > 0)
				    	{
        					SendClientMessage(playerid,grey," Your fishing time needs to reduce.");
							return 1;
						}
						else
						{
					   		format(string,sizeof(string),"\tCheese: %d\n\tWorms: %d\n\tCrabs %d\n\tOctopus: %d",Fishes[playerid][pFishBait][0],Fishes[playerid][pFishBait][1],Fishes[playerid][pFishBait][2],Fishes[playerid][pFishBait][3]);
    						ShowPlayerDialog(playerid,14,DIALOG_STYLE_LIST,"Choose what bait you would like to use:",string,"Use","Exit");
						}
					}
				}
			}
			return 1;
		}
		return 1;
	}
	if (strcmp(cmd,"/myfishes",true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
		    SendClientMessage(playerid,grey,"          _| Fishes |_");
		    format(string,sizeof(string)," 1.%s, Weight: %d Lbs",Fishes[playerid][pFishName1],Fishes[playerid][pFishWeight1]);
		    SendClientMessage(playerid,grey,string);
		    format(string,sizeof(string)," 2.%s, Weight: %d Lbs",Fishes[playerid][pFishName2],Fishes[playerid][pFishWeight2]);
		    SendClientMessage(playerid,grey,string);
	     	format(string,sizeof(string)," 3.%s, Weight: %d Lbs",Fishes[playerid][pFishName3],Fishes[playerid][pFishWeight3]);
	     	SendClientMessage(playerid,grey,string);
		    format(string,sizeof(string)," 4.%s, Weight: %d Lbs",Fishes[playerid][pFishName4],Fishes[playerid][pFishWeight4]);
		    SendClientMessage(playerid,grey,string);
		    format(string,sizeof(string)," 5.%s, Weight: %d Lbs",Fishes[playerid][pFishName5],Fishes[playerid][pFishWeight5]);
		    SendClientMessage(playerid,grey,string);
		}
		return 1;
	}
	if (strcmp(cmd,"/buy",true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(IsPlayerInRangeOfPoint(playerid,15.0,-227.027999,1401.229980,27.765625))
			{
			    new buyitems[] = "\tFish Bait";
    			ShowPlayerDialog(playerid,0,DIALOG_STYLE_LIST,"Avaiable Names",buyitems,"Buy","Exit");
			}
		}
	    return 1;
	}
	if (strcmp(cmd,"/sell",true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(IsPlayerInRangeOfPoint(playerid,15.0,-227.027999,1401.229980,27.765625))
			{
		    	new sellitems[] = "\tFish";
    			ShowPlayerDialog(playerid,7,DIALOG_STYLE_LIST,"Avaiable Names",sellitems,"Sell","Exit");
			}
		}
	    return 1;
	}
	return 0;
}
public FishCatch(playerid)
{
	new string[248];
	if(IsPlayerConnected(playerid))
	{
    	if(Fishes[playerid][pFish][0] == 0)
    	{
			BarBorderText1[playerid] = TextDrawCreate(364.000000, 148.000000, "Bar Border");
			TextDrawBackgroundColor(BarBorderText1[playerid], 255);
			TextDrawFont(BarBorderText1[playerid], 1);
			TextDrawLetterSize(BarBorderText1[playerid], 0.000000, -0.300000);
			TextDrawColor(BarBorderText1[playerid], -1);
			TextDrawSetOutline(BarBorderText1[playerid], 1);
			TextDrawSetProportional(BarBorderText1[playerid], 1);
			TextDrawUseBox(BarBorderText1[playerid], 1);
			TextDrawBoxColor(BarBorderText1[playerid], 255);
			TextDrawTextSize(BarBorderText1[playerid], 250.000000, 0.000000);

			BarBorderText2[playerid] = TextDrawCreate(364.000000, 133.000000, "Bar Border");
			TextDrawBackgroundColor(BarBorderText2[playerid], 255);
			TextDrawFont(BarBorderText2[playerid], 1);
			TextDrawLetterSize(BarBorderText2[playerid], 0.000000, -0.300000);
			TextDrawColor(BarBorderText2[playerid], -1);
			TextDrawSetOutline(BarBorderText2[playerid], 1);
			TextDrawSetProportional(BarBorderText2[playerid], 1);
			TextDrawUseBox(BarBorderText2[playerid], 1);
			TextDrawBoxColor(BarBorderText2[playerid], 255);
			TextDrawTextSize(BarBorderText2[playerid], 250.000000, 0.000000);

			RightBorder[playerid] = TextDrawCreate(364.000000, 147.000000, "Fishingend");
			TextDrawBackgroundColor(RightBorder[playerid], 255);
			TextDrawFont(RightBorder[playerid], 1);
			TextDrawLetterSize(RightBorder[playerid], 0.000000, -2.000000);
			TextDrawColor(RightBorder[playerid], -1);
			TextDrawSetOutline(RightBorder[playerid], 1);
			TextDrawSetProportional(RightBorder[playerid], 1);
			TextDrawUseBox(RightBorder[playerid], 1);
			TextDrawBoxColor(RightBorder[playerid], 255);
			TextDrawTextSize(RightBorder[playerid], 359.000000, 0.000000);

			LeftBorder[playerid] = TextDrawCreate(255.000000, 147.000000, "Fishingstart");
			TextDrawBackgroundColor(LeftBorder[playerid], 255);
			TextDrawFont(LeftBorder[playerid], 1);
			TextDrawLetterSize(LeftBorder[playerid], 0.000000, -2.000000);
			TextDrawColor(LeftBorder[playerid], -1);
			TextDrawSetOutline(LeftBorder[playerid], 1);
			TextDrawSetProportional(LeftBorder[playerid], 1);
			TextDrawUseBox(LeftBorder[playerid], 1);
			TextDrawBoxColor(LeftBorder[playerid], 255);
			TextDrawTextSize(LeftBorder[playerid], 250.000000, 0.000000);

			HelpText1[playerid] = TextDrawCreate(196.000000, 151.000000, "Press        repeatedly to fish..");
			TextDrawBackgroundColor(HelpText1[playerid], 255);
			TextDrawFont(HelpText1[playerid], 1);
			TextDrawLetterSize(HelpText1[playerid], 0.419999, 1.000000);
			TextDrawColor(HelpText1[playerid], -1);
			TextDrawSetOutline(HelpText1[playerid], 1);
			TextDrawSetProportional(HelpText1[playerid], 1);

			HelpText2[playerid] = TextDrawCreate(239.000000, 151.000000, "SPACE");
			TextDrawBackgroundColor(HelpText2[playerid], 255);
			TextDrawFont(HelpText2[playerid], 1);
			TextDrawLetterSize(HelpText2[playerid], 0.419999, 1.000000);
			TextDrawColor(HelpText2[playerid], 528820223);
			TextDrawSetOutline(HelpText2[playerid], 1);
			TextDrawSetProportional(HelpText2[playerid], 1);

			FishOMeterBar[playerid] = TextDrawCreate(271.000000, 135.000000, "~n~");
			TextDrawBackgroundColor(FishOMeterBar[playerid], 255);
			TextDrawFont(FishOMeterBar[playerid], 1);
			TextDrawLetterSize(FishOMeterBar[playerid], 0.600000, 0.599999);
			TextDrawColor(FishOMeterBar[playerid], -1);
			TextDrawSetOutline(FishOMeterBar[playerid], 0);
			TextDrawSetProportional(FishOMeterBar[playerid], 1);
			TextDrawSetShadow(FishOMeterBar[playerid], 1);
			TextDrawUseBox(FishOMeterBar[playerid], 1);
			TextDrawBoxColor(FishOMeterBar[playerid], -16776961);
			TextDrawTextSize(FishOMeterBar[playerid], 252.000000, 0.000000);

			Fishes[playerid][pFishBattle] = 1;
			Fishes[playerid][pPower] = 271.000000;
			FishPowerTimer[playerid] = SetTimerEx("FishPower",1000,true,"d",playerid);


     		SendClientMessage(playerid,grey," A fish took the bait!");
			format(string,sizeof(string)," Press fast the sprint key ( usually the ' spacebar ' key ) to catch the fish.");
			SendClientMessage(playerid,grey,string);
			TextDrawShowForPlayer(playerid,BarBorderText1[playerid]);
			TextDrawShowForPlayer(playerid,BarBorderText2[playerid]);
			TextDrawShowForPlayer(playerid,LeftBorder[playerid]);
			TextDrawShowForPlayer(playerid,RightBorder[playerid]);
			TextDrawShowForPlayer(playerid,HelpText1[playerid]);
			TextDrawShowForPlayer(playerid,HelpText2[playerid]);
			TextDrawShowForPlayer(playerid,FishOMeterBar[playerid]);
			PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
		}
		else if(Fishes[playerid][pFish][1] == 0)
   		{
   	     	BarBorderText1[playerid] = TextDrawCreate(364.000000, 148.000000, "Bar Border");
			TextDrawBackgroundColor(BarBorderText1[playerid], 255);
			TextDrawFont(BarBorderText1[playerid], 1);
			TextDrawLetterSize(BarBorderText1[playerid], 0.000000, -0.300000);
			TextDrawColor(BarBorderText1[playerid], -1);
			TextDrawSetOutline(BarBorderText1[playerid], 1);
			TextDrawSetProportional(BarBorderText1[playerid], 1);
			TextDrawUseBox(BarBorderText1[playerid], 1);
			TextDrawBoxColor(BarBorderText1[playerid], 255);
			TextDrawTextSize(BarBorderText1[playerid], 250.000000, 0.000000);

			BarBorderText2[playerid] = TextDrawCreate(364.000000, 133.000000, "Bar Border");
			TextDrawBackgroundColor(BarBorderText2[playerid], 255);
			TextDrawFont(BarBorderText2[playerid], 1);
			TextDrawLetterSize(BarBorderText2[playerid], 0.000000, -0.300000);
			TextDrawColor(BarBorderText2[playerid], -1);
			TextDrawSetOutline(BarBorderText2[playerid], 1);
			TextDrawSetProportional(BarBorderText2[playerid], 1);
			TextDrawUseBox(BarBorderText2[playerid], 1);
			TextDrawBoxColor(BarBorderText2[playerid], 255);
			TextDrawTextSize(BarBorderText2[playerid], 250.000000, 0.000000);

			RightBorder[playerid] = TextDrawCreate(364.000000, 147.000000, "Fishingend");
			TextDrawBackgroundColor(RightBorder[playerid], 255);
			TextDrawFont(RightBorder[playerid], 1);
			TextDrawLetterSize(RightBorder[playerid], 0.000000, -2.000000);
			TextDrawColor(RightBorder[playerid], -1);
			TextDrawSetOutline(RightBorder[playerid], 1);
			TextDrawSetProportional(RightBorder[playerid], 1);
			TextDrawUseBox(RightBorder[playerid], 1);
			TextDrawBoxColor(RightBorder[playerid], 255);
			TextDrawTextSize(RightBorder[playerid], 359.000000, 0.000000);

			LeftBorder[playerid] = TextDrawCreate(255.000000, 147.000000, "Fishingstart");
			TextDrawBackgroundColor(LeftBorder[playerid], 255);
			TextDrawFont(LeftBorder[playerid], 1);
			TextDrawLetterSize(LeftBorder[playerid], 0.000000, -2.000000);
			TextDrawColor(LeftBorder[playerid], -1);
			TextDrawSetOutline(LeftBorder[playerid], 1);
			TextDrawSetProportional(LeftBorder[playerid], 1);
			TextDrawUseBox(LeftBorder[playerid], 1);
			TextDrawBoxColor(LeftBorder[playerid], 255);
			TextDrawTextSize(LeftBorder[playerid], 250.000000, 0.000000);

			HelpText1[playerid] = TextDrawCreate(196.000000, 151.000000, "Press        repeatedly to fish..");
			TextDrawBackgroundColor(HelpText1[playerid], 255);
			TextDrawFont(HelpText1[playerid], 1);
			TextDrawLetterSize(HelpText1[playerid], 0.419999, 1.000000);
			TextDrawColor(HelpText1[playerid], -1);
			TextDrawSetOutline(HelpText1[playerid], 1);
			TextDrawSetProportional(HelpText1[playerid], 1);

			HelpText2[playerid] = TextDrawCreate(239.000000, 151.000000, "SPACE");
			TextDrawBackgroundColor(HelpText2[playerid], 255);
			TextDrawFont(HelpText2[playerid], 1);
			TextDrawLetterSize(HelpText2[playerid], 0.419999, 1.000000);
			TextDrawColor(HelpText2[playerid], 528820223);
			TextDrawSetOutline(HelpText2[playerid], 1);
			TextDrawSetProportional(HelpText2[playerid], 1);

			FishOMeterBar[playerid] = TextDrawCreate(271.000000, 135.000000, "~n~");
			TextDrawBackgroundColor(FishOMeterBar[playerid], 255);
			TextDrawFont(FishOMeterBar[playerid], 1);
			TextDrawLetterSize(FishOMeterBar[playerid], 0.600000, 0.599999);
			TextDrawColor(FishOMeterBar[playerid], -1);
			TextDrawSetOutline(FishOMeterBar[playerid], 0);
			TextDrawSetProportional(FishOMeterBar[playerid], 1);
			TextDrawSetShadow(FishOMeterBar[playerid], 1);
			TextDrawUseBox(FishOMeterBar[playerid], 1);
			TextDrawBoxColor(FishOMeterBar[playerid], -16776961);
			TextDrawTextSize(FishOMeterBar[playerid], 252.000000, 0.000000);

			Fishes[playerid][pFishBattle] = 1;
			Fishes[playerid][pPower] = 271.000000;
			FishPowerTimer[playerid] = SetTimerEx("FishPower",1000,true,"d",playerid);


     		SendClientMessage(playerid,grey," A fish took the bait!");
			format(string,sizeof(string)," Press fast the sprint key ( usually the ' spacebar ' key ) to catch the fish.");
			SendClientMessage(playerid,grey,string);
			TextDrawShowForPlayer(playerid,BarBorderText1[playerid]);
			TextDrawShowForPlayer(playerid,BarBorderText2[playerid]);
			TextDrawShowForPlayer(playerid,LeftBorder[playerid]);
			TextDrawShowForPlayer(playerid,RightBorder[playerid]);
			TextDrawShowForPlayer(playerid,HelpText1[playerid]);
			TextDrawShowForPlayer(playerid,HelpText2[playerid]);
			TextDrawShowForPlayer(playerid,FishOMeterBar[playerid]);
			PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
		}
		else if(Fishes[playerid][pFish][2] == 0)
    	{
        	BarBorderText1[playerid] = TextDrawCreate(364.000000, 148.000000, "Bar Border");
			TextDrawBackgroundColor(BarBorderText1[playerid], 255);
			TextDrawFont(BarBorderText1[playerid], 1);
			TextDrawLetterSize(BarBorderText1[playerid], 0.000000, -0.300000);
			TextDrawColor(BarBorderText1[playerid], -1);
			TextDrawSetOutline(BarBorderText1[playerid], 1);
			TextDrawSetProportional(BarBorderText1[playerid], 1);
			TextDrawUseBox(BarBorderText1[playerid], 1);
			TextDrawBoxColor(BarBorderText1[playerid], 255);
			TextDrawTextSize(BarBorderText1[playerid], 250.000000, 0.000000);

			BarBorderText2[playerid] = TextDrawCreate(364.000000, 133.000000, "Bar Border");
			TextDrawBackgroundColor(BarBorderText2[playerid], 255);
			TextDrawFont(BarBorderText2[playerid], 1);
			TextDrawLetterSize(BarBorderText2[playerid], 0.000000, -0.300000);
			TextDrawColor(BarBorderText2[playerid], -1);
			TextDrawSetOutline(BarBorderText2[playerid], 1);
			TextDrawSetProportional(BarBorderText2[playerid], 1);
			TextDrawUseBox(BarBorderText2[playerid], 1);
			TextDrawBoxColor(BarBorderText2[playerid], 255);
			TextDrawTextSize(BarBorderText2[playerid], 250.000000, 0.000000);

			RightBorder[playerid] = TextDrawCreate(364.000000, 147.000000, "Fishingend");
			TextDrawBackgroundColor(RightBorder[playerid], 255);
			TextDrawFont(RightBorder[playerid], 1);
			TextDrawLetterSize(RightBorder[playerid], 0.000000, -2.000000);
			TextDrawColor(RightBorder[playerid], -1);
			TextDrawSetOutline(RightBorder[playerid], 1);
			TextDrawSetProportional(RightBorder[playerid], 1);
			TextDrawUseBox(RightBorder[playerid], 1);
			TextDrawBoxColor(RightBorder[playerid], 255);
			TextDrawTextSize(RightBorder[playerid], 359.000000, 0.000000);

			LeftBorder[playerid] = TextDrawCreate(255.000000, 147.000000, "Fishingstart");
			TextDrawBackgroundColor(LeftBorder[playerid], 255);
			TextDrawFont(LeftBorder[playerid], 1);
			TextDrawLetterSize(LeftBorder[playerid], 0.000000, -2.000000);
			TextDrawColor(LeftBorder[playerid], -1);
			TextDrawSetOutline(LeftBorder[playerid], 1);
			TextDrawSetProportional(LeftBorder[playerid], 1);
			TextDrawUseBox(LeftBorder[playerid], 1);
			TextDrawBoxColor(LeftBorder[playerid], 255);
			TextDrawTextSize(LeftBorder[playerid], 250.000000, 0.000000);

			HelpText1[playerid] = TextDrawCreate(196.000000, 151.000000, "Press        repeatedly to fish..");
			TextDrawBackgroundColor(HelpText1[playerid], 255);
			TextDrawFont(HelpText1[playerid], 1);
			TextDrawLetterSize(HelpText1[playerid], 0.419999, 1.000000);
			TextDrawColor(HelpText1[playerid], -1);
			TextDrawSetOutline(HelpText1[playerid], 1);
			TextDrawSetProportional(HelpText1[playerid], 1);

			HelpText2[playerid] = TextDrawCreate(239.000000, 151.000000, "SPACE");
			TextDrawBackgroundColor(HelpText2[playerid], 255);
			TextDrawFont(HelpText2[playerid], 1);
			TextDrawLetterSize(HelpText2[playerid], 0.419999, 1.000000);
			TextDrawColor(HelpText2[playerid], 528820223);
			TextDrawSetOutline(HelpText2[playerid], 1);
			TextDrawSetProportional(HelpText2[playerid], 1);

			FishOMeterBar[playerid] = TextDrawCreate(271.000000, 135.000000, "~n~");
			TextDrawBackgroundColor(FishOMeterBar[playerid], 255);
			TextDrawFont(FishOMeterBar[playerid], 1);
			TextDrawLetterSize(FishOMeterBar[playerid], 0.600000, 0.599999);
			TextDrawColor(FishOMeterBar[playerid], -1);
			TextDrawSetOutline(FishOMeterBar[playerid], 0);
			TextDrawSetProportional(FishOMeterBar[playerid], 1);
			TextDrawSetShadow(FishOMeterBar[playerid], 1);
			TextDrawUseBox(FishOMeterBar[playerid], 1);
			TextDrawBoxColor(FishOMeterBar[playerid], -16776961);
			TextDrawTextSize(FishOMeterBar[playerid], 252.000000, 0.000000);

			Fishes[playerid][pFishBattle] = 1;
			Fishes[playerid][pPower] = 271.000000;
			FishPowerTimer[playerid] = SetTimerEx("FishPower",1000,true,"d",playerid);


     		SendClientMessage(playerid,grey," A fish took the bait!");
			format(string,sizeof(string)," Press fast the sprint key ( usually the ' spacebar ' key ) to catch the fish.");
			SendClientMessage(playerid,grey,string);
			TextDrawShowForPlayer(playerid,BarBorderText1[playerid]);
			TextDrawShowForPlayer(playerid,BarBorderText2[playerid]);
			TextDrawShowForPlayer(playerid,LeftBorder[playerid]);
			TextDrawShowForPlayer(playerid,RightBorder[playerid]);
			TextDrawShowForPlayer(playerid,HelpText1[playerid]);
			TextDrawShowForPlayer(playerid,HelpText2[playerid]);
			TextDrawShowForPlayer(playerid,FishOMeterBar[playerid]);
			PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
		}
		else if(Fishes[playerid][pFish][3] == 0)
    	{
        	BarBorderText1[playerid] = TextDrawCreate(364.000000, 148.000000, "Bar Border");
			TextDrawBackgroundColor(BarBorderText1[playerid], 255);
			TextDrawFont(BarBorderText1[playerid], 1);
			TextDrawLetterSize(BarBorderText1[playerid], 0.000000, -0.300000);
			TextDrawColor(BarBorderText1[playerid], -1);
			TextDrawSetOutline(BarBorderText1[playerid], 1);
			TextDrawSetProportional(BarBorderText1[playerid], 1);
			TextDrawUseBox(BarBorderText1[playerid], 1);
			TextDrawBoxColor(BarBorderText1[playerid], 255);
			TextDrawTextSize(BarBorderText1[playerid], 250.000000, 0.000000);

			BarBorderText2[playerid] = TextDrawCreate(364.000000, 133.000000, "Bar Border");
			TextDrawBackgroundColor(BarBorderText2[playerid], 255);
			TextDrawFont(BarBorderText2[playerid], 1);
			TextDrawLetterSize(BarBorderText2[playerid], 0.000000, -0.300000);
			TextDrawColor(BarBorderText2[playerid], -1);
			TextDrawSetOutline(BarBorderText2[playerid], 1);
			TextDrawSetProportional(BarBorderText2[playerid], 1);
			TextDrawUseBox(BarBorderText2[playerid], 1);
			TextDrawBoxColor(BarBorderText2[playerid], 255);
			TextDrawTextSize(BarBorderText2[playerid], 250.000000, 0.000000);

			RightBorder[playerid] = TextDrawCreate(364.000000, 147.000000, "Fishingend");
			TextDrawBackgroundColor(RightBorder[playerid], 255);
			TextDrawFont(RightBorder[playerid], 1);
			TextDrawLetterSize(RightBorder[playerid], 0.000000, -2.000000);
			TextDrawColor(RightBorder[playerid], -1);
			TextDrawSetOutline(RightBorder[playerid], 1);
			TextDrawSetProportional(RightBorder[playerid], 1);
			TextDrawUseBox(RightBorder[playerid], 1);
			TextDrawBoxColor(RightBorder[playerid], 255);
			TextDrawTextSize(RightBorder[playerid], 359.000000, 0.000000);

			LeftBorder[playerid] = TextDrawCreate(255.000000, 147.000000, "Fishingstart");
			TextDrawBackgroundColor(LeftBorder[playerid], 255);
			TextDrawFont(LeftBorder[playerid], 1);
			TextDrawLetterSize(LeftBorder[playerid], 0.000000, -2.000000);
			TextDrawColor(LeftBorder[playerid], -1);
			TextDrawSetOutline(LeftBorder[playerid], 1);
			TextDrawSetProportional(LeftBorder[playerid], 1);
			TextDrawUseBox(LeftBorder[playerid], 1);
			TextDrawBoxColor(LeftBorder[playerid], 255);
			TextDrawTextSize(LeftBorder[playerid], 250.000000, 0.000000);

			HelpText1[playerid] = TextDrawCreate(196.000000, 151.000000, "Press        repeatedly to fish..");
			TextDrawBackgroundColor(HelpText1[playerid], 255);
			TextDrawFont(HelpText1[playerid], 1);
			TextDrawLetterSize(HelpText1[playerid], 0.419999, 1.000000);
			TextDrawColor(HelpText1[playerid], -1);
			TextDrawSetOutline(HelpText1[playerid], 1);
			TextDrawSetProportional(HelpText1[playerid], 1);

			HelpText2[playerid] = TextDrawCreate(239.000000, 151.000000, "SPACE");
			TextDrawBackgroundColor(HelpText2[playerid], 255);
			TextDrawFont(HelpText2[playerid], 1);
			TextDrawLetterSize(HelpText2[playerid], 0.419999, 1.000000);
			TextDrawColor(HelpText2[playerid], 528820223);
			TextDrawSetOutline(HelpText2[playerid], 1);
			TextDrawSetProportional(HelpText2[playerid], 1);

			FishOMeterBar[playerid] = TextDrawCreate(271.000000, 135.000000, "~n~");
			TextDrawBackgroundColor(FishOMeterBar[playerid], 255);
			TextDrawFont(FishOMeterBar[playerid], 1);
			TextDrawLetterSize(FishOMeterBar[playerid], 0.600000, 0.599999);
			TextDrawColor(FishOMeterBar[playerid], -1);
			TextDrawSetOutline(FishOMeterBar[playerid], 0);
			TextDrawSetProportional(FishOMeterBar[playerid], 1);
			TextDrawSetShadow(FishOMeterBar[playerid], 1);
			TextDrawUseBox(FishOMeterBar[playerid], 1);
			TextDrawBoxColor(FishOMeterBar[playerid], -16776961);
			TextDrawTextSize(FishOMeterBar[playerid], 252.000000, 0.000000);

			Fishes[playerid][pFishBattle] = 1;
			Fishes[playerid][pPower] = 271.000000;
			FishPowerTimer[playerid] = SetTimerEx("FishPower",1000,true,"d",playerid);


     		SendClientMessage(playerid,grey," A fish took the bait!");
			format(string,sizeof(string)," Press fast the sprint key ( usually the ' spacebar ' key ) to catch the fish.");
			SendClientMessage(playerid,grey,string);
			TextDrawShowForPlayer(playerid,BarBorderText1[playerid]);
			TextDrawShowForPlayer(playerid,BarBorderText2[playerid]);
			TextDrawShowForPlayer(playerid,LeftBorder[playerid]);
			TextDrawShowForPlayer(playerid,RightBorder[playerid]);
			TextDrawShowForPlayer(playerid,HelpText1[playerid]);
			TextDrawShowForPlayer(playerid,HelpText2[playerid]);
			TextDrawShowForPlayer(playerid,FishOMeterBar[playerid]);
			PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
		}
		else if(Fishes[playerid][pFish][4] == 0)
	 	{
        	BarBorderText1[playerid] = TextDrawCreate(364.000000, 148.000000, "Bar Border");
			TextDrawBackgroundColor(BarBorderText1[playerid], 255);
			TextDrawFont(BarBorderText1[playerid], 1);
			TextDrawLetterSize(BarBorderText1[playerid], 0.000000, -0.300000);
			TextDrawColor(BarBorderText1[playerid], -1);
			TextDrawSetOutline(BarBorderText1[playerid], 1);
			TextDrawSetProportional(BarBorderText1[playerid], 1);
			TextDrawUseBox(BarBorderText1[playerid], 1);
			TextDrawBoxColor(BarBorderText1[playerid], 255);
			TextDrawTextSize(BarBorderText1[playerid], 250.000000, 0.000000);

			BarBorderText2[playerid] = TextDrawCreate(364.000000, 133.000000, "Bar Border");
			TextDrawBackgroundColor(BarBorderText2[playerid], 255);
			TextDrawFont(BarBorderText2[playerid], 1);
			TextDrawLetterSize(BarBorderText2[playerid], 0.000000, -0.300000);
			TextDrawColor(BarBorderText2[playerid], -1);
			TextDrawSetOutline(BarBorderText2[playerid], 1);
			TextDrawSetProportional(BarBorderText2[playerid], 1);
			TextDrawUseBox(BarBorderText2[playerid], 1);
			TextDrawBoxColor(BarBorderText2[playerid], 255);
			TextDrawTextSize(BarBorderText2[playerid], 250.000000, 0.000000);

			RightBorder[playerid] = TextDrawCreate(364.000000, 147.000000, "Fishingend");
			TextDrawBackgroundColor(RightBorder[playerid], 255);
			TextDrawFont(RightBorder[playerid], 1);
			TextDrawLetterSize(RightBorder[playerid], 0.000000, -2.000000);
			TextDrawColor(RightBorder[playerid], -1);
			TextDrawSetOutline(RightBorder[playerid], 1);
			TextDrawSetProportional(RightBorder[playerid], 1);
			TextDrawUseBox(RightBorder[playerid], 1);
			TextDrawBoxColor(RightBorder[playerid], 255);
			TextDrawTextSize(RightBorder[playerid], 359.000000, 0.000000);

			LeftBorder[playerid] = TextDrawCreate(255.000000, 147.000000, "Fishingstart");
			TextDrawBackgroundColor(LeftBorder[playerid], 255);
			TextDrawFont(LeftBorder[playerid], 1);
			TextDrawLetterSize(LeftBorder[playerid], 0.000000, -2.000000);
			TextDrawColor(LeftBorder[playerid], -1);
			TextDrawSetOutline(LeftBorder[playerid], 1);
			TextDrawSetProportional(LeftBorder[playerid], 1);
			TextDrawUseBox(LeftBorder[playerid], 1);
			TextDrawBoxColor(LeftBorder[playerid], 255);
			TextDrawTextSize(LeftBorder[playerid], 250.000000, 0.000000);

			HelpText1[playerid] = TextDrawCreate(196.000000, 151.000000, "Press        repeatedly to fish..");
			TextDrawBackgroundColor(HelpText1[playerid], 255);
			TextDrawFont(HelpText1[playerid], 1);
			TextDrawLetterSize(HelpText1[playerid], 0.419999, 1.000000);
			TextDrawColor(HelpText1[playerid], -1);
			TextDrawSetOutline(HelpText1[playerid], 1);
			TextDrawSetProportional(HelpText1[playerid], 1);

			HelpText2[playerid] = TextDrawCreate(239.000000, 151.000000, "SPACE");
			TextDrawBackgroundColor(HelpText2[playerid], 255);
			TextDrawFont(HelpText2[playerid], 1);
			TextDrawLetterSize(HelpText2[playerid], 0.419999, 1.000000);
			TextDrawColor(HelpText2[playerid], 528820223);
			TextDrawSetOutline(HelpText2[playerid], 1);
			TextDrawSetProportional(HelpText2[playerid], 1);

			FishOMeterBar[playerid] = TextDrawCreate(271.000000, 135.000000, "~n~");
			TextDrawBackgroundColor(FishOMeterBar[playerid], 255);
			TextDrawFont(FishOMeterBar[playerid], 1);
			TextDrawLetterSize(FishOMeterBar[playerid], 0.600000, 0.599999);
			TextDrawColor(FishOMeterBar[playerid], -1);
			TextDrawSetOutline(FishOMeterBar[playerid], 0);
			TextDrawSetProportional(FishOMeterBar[playerid], 1);
			TextDrawSetShadow(FishOMeterBar[playerid], 1);
			TextDrawUseBox(FishOMeterBar[playerid], 1);
			TextDrawBoxColor(FishOMeterBar[playerid], -16776961);
			TextDrawTextSize(FishOMeterBar[playerid], 252.000000, 0.000000);

			Fishes[playerid][pFishBattle] = 1;
			Fishes[playerid][pPower] = 271.000000;
			FishPowerTimer[playerid] = SetTimerEx("FishPower",1000,true,"d",playerid);

			SendClientMessage(playerid,grey," A fish took the bait!");
			format(string,sizeof(string)," Press fast the sprint key ( usually the ' spacebar ' key ) to catch the fish.");
			SendClientMessage(playerid,grey,string);
			TextDrawShowForPlayer(playerid,BarBorderText1[playerid]);
			TextDrawShowForPlayer(playerid,BarBorderText2[playerid]);
			TextDrawShowForPlayer(playerid,LeftBorder[playerid]);
			TextDrawShowForPlayer(playerid,RightBorder[playerid]);
			TextDrawShowForPlayer(playerid,HelpText1[playerid]);
			TextDrawShowForPlayer(playerid,HelpText2[playerid]);
			TextDrawShowForPlayer(playerid,FishOMeterBar[playerid]);
			PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
		}
	}
	return 1;
}

public FishPower(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		Fishes[playerid][pPower] -= 1.0;
		TextDrawDestroy(FishOMeterBar[playerid]);
 		FishOMeterBar[playerid] = TextDrawCreate(Fishes[playerid][pPower],135.000000, "~n~");
		TextDrawBackgroundColor(FishOMeterBar[playerid], 255);
		TextDrawFont(FishOMeterBar[playerid], 1);
		TextDrawLetterSize(FishOMeterBar[playerid], 0.600000, 0.599999);
		TextDrawColor(FishOMeterBar[playerid], -1);
		TextDrawSetOutline(FishOMeterBar[playerid], 0);
		TextDrawSetProportional(FishOMeterBar[playerid], 1);
		TextDrawSetShadow(FishOMeterBar[playerid], 1);
		TextDrawUseBox(FishOMeterBar[playerid], 1);
		TextDrawBoxColor(FishOMeterBar[playerid], -16776961);
		TextDrawTextSize(FishOMeterBar[playerid], 252.000000, 0.000000);
		TextDrawShowForPlayer(playerid,FishOMeterBar[playerid]);
 		if(Fishes[playerid][pPower] == 256.000000)
  		{
  	    	Fishes[playerid][pFishBattle] = 0;
       		Fishes[playerid][pPower] = 0.0;
        	LineSnapped[playerid] = 0;
   			SendClientMessage(playerid,grey," You have lost the fish!");
     		KillTimer(FishPowerTimer[playerid]);
     		TextDrawDestroy(BarBorderText1[playerid]);
			TextDrawDestroy(BarBorderText2[playerid]);
			TextDrawDestroy(LeftBorder[playerid]);
			TextDrawDestroy(RightBorder[playerid]);
			TextDrawDestroy(HelpText1[playerid]);
			TextDrawDestroy(HelpText2[playerid]);
			TextDrawDestroy(FishOMeterBar[playerid]);
     		ApplyAnimation(playerid,"PED","KO_skid_front",4.1,0,0,0,1,1,1);SetTimerEx("GetUp",1000,false,"d",playerid);
		}
	}
	return 1;
}
forward GetUp(playerid);
public GetUp(playerid)
{
	if(IsPlayerConnected(playerid))
	{
    	ApplyAnimation(playerid,"PED","getup",4.1,0,1,1,1,1,1);
	}
    return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    if(pickupid == baitshopenter)
	{
	    SetPlayerInterior(playerid,18);
		SetPlayerPos(playerid,-227.027999+2.0,1401.229980,27.765625);
		GameTextForPlayer(playerid,"~w~Bait Shop",4000,1);
		SetPlayerFacingAngle(playerid,266.399108);
		SetCameraBehindPlayer(playerid);
		return 1;
	}
	else if(pickupid == baitshopexit)
	{
	    SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,681.0556,-476.7615,16.3359);
		GameTextForPlayer(playerid,"~w~Los Santos",4000,1);
		SetPlayerFacingAngle(playerid,173.361603);
		SetCameraBehindPlayer(playerid);
	}
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    new string[248];
	new keys, updown, leftright;
	GetPlayerKeys(playerid,keys,updown,leftright);
	if(Fishes[playerid][pFishBattle] == 1)
	{
	    if (PRESSED(KEY_SPRINT))
	    {
	        new fstring[248];
    		new rand;
    		new FishWeight;
   			rand = random(FishNamesNumber);
   		 	if(Fishes[playerid][pFishBaitUsing] == 1){ FishWeight = random(5)+1;  }
    		else if(Fishes[playerid][pFishBaitUsing] == 2){ FishWeight = random(5)+8; }
    		else if(Fishes[playerid][pFishBaitUsing] == 3){ FishWeight = random(10)+10; }
    		else if(Fishes[playerid][pFishBaitUsing] == 4){ FishWeight = random(10)+15; }
	        Fishes[playerid][pPower] += 1.0;
			TextDrawDestroy(FishOMeterBar[playerid]);
 			FishOMeterBar[playerid] = TextDrawCreate(Fishes[playerid][pPower], 135.000000, "~n~");
			TextDrawBackgroundColor(FishOMeterBar[playerid], 255);
			TextDrawFont(FishOMeterBar[playerid], 1);
			TextDrawLetterSize(FishOMeterBar[playerid], 0.600000, 0.599999);
			TextDrawColor(FishOMeterBar[playerid], -1);
			TextDrawSetOutline(FishOMeterBar[playerid], 0);
			TextDrawSetProportional(FishOMeterBar[playerid], 1);
			TextDrawSetShadow(FishOMeterBar[playerid], 1);
			TextDrawUseBox(FishOMeterBar[playerid], 1);
			TextDrawBoxColor(FishOMeterBar[playerid], -16776961);
			TextDrawTextSize(FishOMeterBar[playerid], 252.000000, 0.000000);
			TextDrawShowForPlayer(playerid,FishOMeterBar[playerid]);
	        if(Fishes[playerid][pPower] == 361.000000)
	        {
	            if(Fishes[playerid][pFish][0] == 0)
	            {
	                format(fstring, sizeof(fstring), "%s", FishNames[rand]);
					strmid(Fishes[playerid][pFishName1], fstring, 0, strlen(fstring), 255);
	            	Fishes[playerid][pFishes] += 1;
        			Fishes[playerid][pFish][0] = 1;
        			Fishes[playerid][pFishWeight1] = FishWeight;
	            	KillTimer(FishPowerTimer[playerid]);
                	Fishes[playerid][pFishBattle] = 0;
       				Fishes[playerid][pPower] = 0.0;
        			LineSnapped[playerid] = 0;
   					format(string,sizeof(string)," You have caught a %s wich weights %d Lbs!",Fishes[playerid][pFishName1],Fishes[playerid][pFishWeight1]);
   					SendClientMessage(playerid,grey,string);
     				KillTimer(FishPowerTimer[playerid]);
     				TextDrawDestroy(BarBorderText1[playerid]);
					TextDrawDestroy(BarBorderText2[playerid]);
					TextDrawDestroy(LeftBorder[playerid]);
					TextDrawDestroy(RightBorder[playerid]);
					TextDrawDestroy(HelpText1[playerid]);
					TextDrawDestroy(HelpText2[playerid]);
					TextDrawDestroy(FishOMeterBar[playerid]);
     				PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
				}
				else if(Fishes[playerid][pFish][1] == 0)
	            {
	                format(fstring, sizeof(fstring), "%s", FishNames[rand]);
					strmid(Fishes[playerid][pFishName2], fstring, 0, strlen(fstring), 255);
	            	Fishes[playerid][pFishes] += 1;
        			Fishes[playerid][pFish][1] = 1;
        			Fishes[playerid][pFishWeight2] = FishWeight;
	            	KillTimer(FishPowerTimer[playerid]);
                	Fishes[playerid][pFishBattle] = 0;
       				Fishes[playerid][pPower] = 0.0;
        			LineSnapped[playerid] = 0;
   					format(string,sizeof(string)," You have caught a %s wich weights %d Lbs!",Fishes[playerid][pFishName2],Fishes[playerid][pFishWeight2]);
   					SendClientMessage(playerid,grey,string);
     				KillTimer(FishPowerTimer[playerid]);
     				TextDrawDestroy(BarBorderText1[playerid]);
					TextDrawDestroy(BarBorderText2[playerid]);
					TextDrawDestroy(LeftBorder[playerid]);
					TextDrawDestroy(RightBorder[playerid]);
					TextDrawDestroy(HelpText1[playerid]);
					TextDrawDestroy(HelpText2[playerid]);
					TextDrawDestroy(FishOMeterBar[playerid]);
     				PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
				}
				else if(Fishes[playerid][pFish][2] == 0)
	            {
	                format(fstring, sizeof(fstring), "%s", FishNames[rand]);
					strmid(Fishes[playerid][pFishName3], fstring, 0, strlen(fstring), 255);
	            	Fishes[playerid][pFishes] += 1;
        			Fishes[playerid][pFish][2] = 1;
        			Fishes[playerid][pFishWeight3] = FishWeight;
	            	KillTimer(FishPowerTimer[playerid]);
                	Fishes[playerid][pFishBattle] = 0;
       				Fishes[playerid][pPower] = 0.0;
        			LineSnapped[playerid] = 0;
   					format(string,sizeof(string)," You have caught a %s wich weights %d Lbs!",Fishes[playerid][pFishName3],Fishes[playerid][pFishWeight3]);
   					SendClientMessage(playerid,grey,string);
     				KillTimer(FishPowerTimer[playerid]);
     				TextDrawDestroy(BarBorderText1[playerid]);
					TextDrawDestroy(BarBorderText2[playerid]);
					TextDrawDestroy(LeftBorder[playerid]);
					TextDrawDestroy(RightBorder[playerid]);
					TextDrawDestroy(HelpText1[playerid]);
					TextDrawDestroy(HelpText2[playerid]);
					TextDrawDestroy(FishOMeterBar[playerid]);
     				PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
				}
				else if(Fishes[playerid][pFish][3] == 0)
	            {
	                format(fstring, sizeof(fstring), "%s", FishNames[rand]);
					strmid(Fishes[playerid][pFishName4], fstring, 0, strlen(fstring), 255);
	            	Fishes[playerid][pFishes] += 1;
        			Fishes[playerid][pFish][3] = 1;
        			Fishes[playerid][pFishWeight4] = FishWeight;
	            	KillTimer(FishPowerTimer[playerid]);
                	Fishes[playerid][pFishBattle] = 0;
       				Fishes[playerid][pPower] = 0.0;
        			LineSnapped[playerid] = 0;
   					format(string,sizeof(string)," You have caught a %s wich weights %d Lbs!",Fishes[playerid][pFishName4],Fishes[playerid][pFishWeight4]);
   					SendClientMessage(playerid,grey,string);
     				KillTimer(FishPowerTimer[playerid]);
     				TextDrawDestroy(BarBorderText1[playerid]);
					TextDrawDestroy(BarBorderText2[playerid]);
					TextDrawDestroy(LeftBorder[playerid]);
					TextDrawDestroy(RightBorder[playerid]);
					TextDrawDestroy(HelpText1[playerid]);
					TextDrawDestroy(HelpText2[playerid]);
					TextDrawDestroy(FishOMeterBar[playerid]);
     				PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
				}
				else if(Fishes[playerid][pFish][4] == 0)
	            {
	                format(fstring, sizeof(fstring), "%s", FishNames[rand]);
					strmid(Fishes[playerid][pFishName5], fstring, 0, strlen(fstring), 255);
	            	Fishes[playerid][pFishes] += 1;
        			Fishes[playerid][pFish][4] = 1;
        			Fishes[playerid][pFishWeight5] = FishWeight;
	            	KillTimer(FishPowerTimer[playerid]);
                	Fishes[playerid][pFishBattle] = 0;
       				Fishes[playerid][pPower] = 0.0;
        			LineSnapped[playerid] = 0;
   					format(string,sizeof(string)," You have caught a %s wich weights %d Lbs!",Fishes[playerid][pFishName5],Fishes[playerid][pFishWeight5]);
   					SendClientMessage(playerid,grey,string);
     				KillTimer(FishPowerTimer[playerid]);
     				TextDrawDestroy(BarBorderText1[playerid]);
					TextDrawDestroy(BarBorderText2[playerid]);
					TextDrawDestroy(LeftBorder[playerid]);
					TextDrawDestroy(RightBorder[playerid]);
					TextDrawDestroy(HelpText1[playerid]);
					TextDrawDestroy(HelpText2[playerid]);
					TextDrawDestroy(FishOMeterBar[playerid]);
     				PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
				}
			}
		}
		return 1;
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    new string[248];
	switch(dialogid)
	{
	    case 0:
	    {
	    	if(response)
	    	{
	        	if(listitem == 0)
	        	{
	            	new fishbaits[] = "\tCheese\n\tWorms\n\tCrabs\n\tOctopus";
	    			ShowPlayerDialog(playerid,1,DIALOG_STYLE_LIST,"Fish Baits",fishbaits,"Buy","Back");
	    			return 1;
				}
			}
			else
			{

			}
		}
		case 1:
		{
	    	if(response)
	    	{
	        	if(listitem == 0)
	        	{
	            	ShowPlayerDialog(playerid,2,DIALOG_STYLE_INPUT,"Cheese"," Write below how many Cheese pieces you would like \nto buy ( 1 piece = 5$ ):","Buy","Back");
	            	return 1;
				}
				else if(listitem == 1)
	        	{
	            	ShowPlayerDialog(playerid,3,DIALOG_STYLE_INPUT,"Worms"," Write below how many Worms you would like to buy ( 1 worm = 7$ ):","Buy","Back");
	            	return 1;
				}
				else if(listitem == 2)
	        	{
	            	ShowPlayerDialog(playerid,4,DIALOG_STYLE_INPUT,"Crabs"," Write below how many Crabs you would like to buy ( 1 crab = 10$ ):","Buy","Back");
	            	return 1;
				}
				else if(listitem == 3)
	        	{
	            	ShowPlayerDialog(playerid,5,DIALOG_STYLE_INPUT,"Octopus"," Write below how many Octopus you would like to buy ( 1 octopus = 15$ ):","Buy","Back");
				}
				return 1;
			}
			else
			{
		    	new buyitems[] = "\tFish Bait";
    			ShowPlayerDialog(playerid,0,DIALOG_STYLE_LIST,"Avaiable Names",buyitems,"Buy","Exit");
			}
			return 1;
		}
		case 2:
		{
			if(response)
			{
			    new price = 5*strval(inputtext);
			    if(GetPlayerMoney(playerid) < price)
			    {
			        ShowPlayerDialog(playerid,6,DIALOG_STYLE_MSGBOX,"Cheese","You don't have enough cash to buy this!","Back","Exit");
			        return 1;
				}
				else if(GetPlayerMoney(playerid) >= price)
				{
				    if(!strlen(inputtext))
				    {
				        ShowPlayerDialog(playerid,2,DIALOG_STYLE_INPUT,"Cheese"," Write below how many Cheese pieces you would like \nto buy ( 1 piece = 5$ ):","Buy","Back");
	            		return 1;
					}
					else
					{
				    	GivePlayerMoney(playerid,-price);
						format(string,sizeof(string)," Bait Shop: You have bought %s pieces of cheese for %d$!",inputtext,price);
						SendClientMessage(playerid,grey,string);
						Fishes[playerid][pFishBait][0]+=strval(inputtext);
						PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
					}
				}
				return 1;
			}
			else
			{
		    	new buyitems[] = "\tFish Bait";
    			ShowPlayerDialog(playerid,0,DIALOG_STYLE_LIST,"Avaiable Names",buyitems,"Buy","Exit");
			}
			return 1;
		}
		case 3:
		{
			if(response)
			{
			    new price = 7*strval(inputtext);
			    if(GetPlayerMoney(playerid) < price)
			    {
			        ShowPlayerDialog(playerid,6,DIALOG_STYLE_MSGBOX,"Worms","You don't have enough cash to buy this!","Back","Exit");
			        return 1;
				}
				else if(GetPlayerMoney(playerid) >= price)
				{
				    if(!strlen(inputtext))
				    {
				        ShowPlayerDialog(playerid,3,DIALOG_STYLE_INPUT,"Worms"," Write below how many Worms you would like to buy ( 1 worm = 7$ ):","Buy","Back");
	            		return 1;
					}
					else
					{
				    	GivePlayerMoney(playerid,-price);
						format(string,sizeof(string)," Bait Shop: You have bought %s worms for %d$!",inputtext,price);
						SendClientMessage(playerid,grey,string);
						Fishes[playerid][pFishBait][1]+=strval(inputtext);
						PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
					}
				}
				return 1;
			}
			else
			{
		    	new buyitems[] = "\tFish Bait";
    			ShowPlayerDialog(playerid,0,DIALOG_STYLE_LIST,"Avaiable Names",buyitems,"Buy","Exit");
			}
			return 1;
		}
		case 4:
		{
			if(response)
			{
			    new price = 10*strval(inputtext);
			    if(GetPlayerMoney(playerid) < price)
			    {
			        ShowPlayerDialog(playerid,6,DIALOG_STYLE_MSGBOX,"Crabs","You don't have enough cash to buy this!","Back","Exit");
			        return 1;
				}
				else if(GetPlayerMoney(playerid) >= price)
				{
				    if(!strlen(inputtext))
				    {
				    	ShowPlayerDialog(playerid,4,DIALOG_STYLE_INPUT,"Crabs"," Write below how many Crabs you would like to buy ( 1 crab = 10$ ):","Buy","Back");
	            		return 1;
				    }
				    else
				    {
				    	GivePlayerMoney(playerid,-price);
						format(string,sizeof(string)," Bait Shop: You have bought %s crabs for %d$!",inputtext,price);
						SendClientMessage(playerid,grey,string);
						Fishes[playerid][pFishBait][2]+=strval(inputtext);
						PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
					}
				}
				return 1;
			}
			else
			{
		    	new buyitems[] = "\tFish Bait";
    			ShowPlayerDialog(playerid,0,DIALOG_STYLE_LIST,"Avaiable Names",buyitems,"Buy","Exit");
			}
			return 1;
		}
		case 5:
		{
			if(response)
			{
			    new price = 15*strval(inputtext);
			    if(GetPlayerMoney(playerid) < price)
			    {
			        ShowPlayerDialog(playerid,6,DIALOG_STYLE_MSGBOX,"Octopus","You don't have enough cash to buy this!","Back","Exit");
			        return 1;
				}
				else if(GetPlayerMoney(playerid) >= price)
				{
				    if(!strlen(inputtext))
				    {
				        ShowPlayerDialog(playerid,5,DIALOG_STYLE_INPUT,"Octopus"," Write below how many Octopus you would like to buy ( 1 octopus = 15$ ):","Buy","Back");
				        return 1;
				    }
				    else
				    {
				    	GivePlayerMoney(playerid,-price);
						format(string,sizeof(string)," Bait Shop: You have bought %s octopus for %d$!",inputtext,price);
						SendClientMessage(playerid,grey,string);
						Fishes[playerid][pFishBait][3]+=strval(inputtext);
						PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
					}
				}
				return 1;
			}
			else
			{
		    	new buyitems[] = "\tFish Bait";
    			ShowPlayerDialog(playerid,0,DIALOG_STYLE_LIST,"Avaiable Names",buyitems,"Buy","Exit");
			}
			return 1;
		}
		case 7:
		{
		    if(response)
		    {
		        if(listitem == 0)
		        {
		            if(Fishes[playerid][pFishWeight1] > 0 || Fishes[playerid][pFishWeight2] > 0 || Fishes[playerid][pFishWeight3] > 0 || Fishes[playerid][pFishWeight4] > 0 || Fishes[playerid][pFishWeight5] > 0)
		            {
		            	format(string,sizeof(string),"\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs",Fishes[playerid][pFishName1],Fishes[playerid][pFishWeight1],Fishes[playerid][pFishName2],Fishes[playerid][pFishWeight2],Fishes[playerid][pFishName3],Fishes[playerid][pFishWeight3],Fishes[playerid][pFishName4],Fishes[playerid][pFishWeight4],Fishes[playerid][pFishName5],Fishes[playerid][pFishWeight5]);
    					ShowPlayerDialog(playerid,8,DIALOG_STYLE_LIST,"Fishes",string,"Sell","Exit");
    					return 1;
					}
					else
					{
					    SendClientMessage(playerid,grey," Bait Shop: You don't have any fishes with you.");
					}
				}
				return 1;
			}
		}
		case 8:
		{
		    if(response)
		    {
		        if(listitem == 0)
		        {
		            if(Fishes[playerid][pFishWeight1] == 0)
		            {
		            	format(string,sizeof(string),"\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs",Fishes[playerid][pFishName1],Fishes[playerid][pFishWeight1],Fishes[playerid][pFishName2],Fishes[playerid][pFishWeight2],Fishes[playerid][pFishName3],Fishes[playerid][pFishWeight3],Fishes[playerid][pFishName4],Fishes[playerid][pFishWeight4],Fishes[playerid][pFishName5],Fishes[playerid][pFishWeight5]);
    					ShowPlayerDialog(playerid,8,DIALOG_STYLE_LIST,"Fishes",string,"Sell","Exit");
    					return 1;
					}
					else
					{
					    new fishprice = Fishes[playerid][pFishWeight1];
					    format(string,sizeof(string)," Are you sure that you want to sell you'r\n%s wich weights %dLbs for %d$?",Fishes[playerid][pFishName1],Fishes[playerid][pFishWeight1],fishprice);
                        ShowPlayerDialog(playerid,9,DIALOG_STYLE_MSGBOX,"Fish",string,"Yes","No");
					}
					return 1;
				}
				else if(listitem == 1)
				{
				    if(Fishes[playerid][pFishWeight2] == 0)
		            {
		            	format(string,sizeof(string),"\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs",Fishes[playerid][pFishName1],Fishes[playerid][pFishWeight1],Fishes[playerid][pFishName2],Fishes[playerid][pFishWeight2],Fishes[playerid][pFishName3],Fishes[playerid][pFishWeight3],Fishes[playerid][pFishName4],Fishes[playerid][pFishWeight4],Fishes[playerid][pFishName5],Fishes[playerid][pFishWeight5]);
    					ShowPlayerDialog(playerid,8,DIALOG_STYLE_LIST,"Fishes",string,"Sell","Exit");
    					return 1;
					}
					else
					{
					    new fishprice = Fishes[playerid][pFishWeight2];
					    format(string,sizeof(string)," Are you sure that you want to sell you'r\n%s wich weights %dLbs for %d$?",Fishes[playerid][pFishName2],Fishes[playerid][pFishWeight2],fishprice);
                        ShowPlayerDialog(playerid,10,DIALOG_STYLE_MSGBOX,"Fish",string,"Yes","No");
					}
					return 1;
				}
				else if(listitem == 2)
				{
				    if(Fishes[playerid][pFishWeight3] == 0)
		            {
		            	format(string,sizeof(string),"\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs",Fishes[playerid][pFishName1],Fishes[playerid][pFishWeight1],Fishes[playerid][pFishName2],Fishes[playerid][pFishWeight2],Fishes[playerid][pFishName3],Fishes[playerid][pFishWeight3],Fishes[playerid][pFishName4],Fishes[playerid][pFishWeight4],Fishes[playerid][pFishName5],Fishes[playerid][pFishWeight5]);
    					ShowPlayerDialog(playerid,8,DIALOG_STYLE_LIST,"Fishes",string,"Sell","Exit");
    					return 1;
					}
					else
					{
					    new fishprice = Fishes[playerid][pFishWeight3];
					    format(string,sizeof(string)," Are you sure that you want to sell you'r\n%s wich weights %dLbs for %d$?",Fishes[playerid][pFishName3],Fishes[playerid][pFishWeight3],fishprice);
                        ShowPlayerDialog(playerid,11,DIALOG_STYLE_MSGBOX,"Fish",string,"Yes","No");
					}
					return 1;
				}
				else if(listitem == 3)
				{
				    if(Fishes[playerid][pFishWeight4] == 0)
		            {
		            	format(string,sizeof(string),"\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs",Fishes[playerid][pFishName1],Fishes[playerid][pFishWeight1],Fishes[playerid][pFishName2],Fishes[playerid][pFishWeight2],Fishes[playerid][pFishName3],Fishes[playerid][pFishWeight3],Fishes[playerid][pFishName4],Fishes[playerid][pFishWeight4],Fishes[playerid][pFishName5],Fishes[playerid][pFishWeight5]);
    					ShowPlayerDialog(playerid,8,DIALOG_STYLE_LIST,"Fishes",string,"Sell","Exit");
    					return 1;
					}
					else
					{
					    new fishprice = Fishes[playerid][pFishWeight4];
					    format(string,sizeof(string)," Are you sure that you want to sell you'r\n%s wich weights %dLbs for %d$?",Fishes[playerid][pFishName4],Fishes[playerid][pFishWeight4],fishprice);
                        ShowPlayerDialog(playerid,12,DIALOG_STYLE_MSGBOX,"Fish",string,"Yes","No");
					}
					return 1;
				}
				else if(listitem == 4)
				{
				    if(Fishes[playerid][pFishWeight5] == 0)
		            {
		            	format(string,sizeof(string),"\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs",Fishes[playerid][pFishName1],Fishes[playerid][pFishWeight1],Fishes[playerid][pFishName2],Fishes[playerid][pFishWeight2],Fishes[playerid][pFishName3],Fishes[playerid][pFishWeight3],Fishes[playerid][pFishName4],Fishes[playerid][pFishWeight4],Fishes[playerid][pFishName5],Fishes[playerid][pFishWeight5]);
    					ShowPlayerDialog(playerid,8,DIALOG_STYLE_LIST,"Fishes",string,"Sell","Exit");
    					return 1;
					}
					else
					{
					    new fishprice = Fishes[playerid][pFishWeight5];
					    format(string,sizeof(string)," Are you sure that you want to sell you'r\n%s wich weights %d Lbs for %d$?",Fishes[playerid][pFishName5],Fishes[playerid][pFishWeight5],fishprice);
                        ShowPlayerDialog(playerid,13,DIALOG_STYLE_MSGBOX,"Fish",string,"Yes","No");
					}
				}
				return 1;
			}
		}
		case 9:
		{
		    if(response)
		    {
				GivePlayerMoney(playerid,Fishes[playerid][pFishWeight1]);
				format(string,sizeof(string)," Bait Shop: You have sold you'r %s wich weights %dLbs for %d$!",Fishes[playerid][pFishName1],Fishes[playerid][pFishWeight1],Fishes[playerid][pFishWeight1]);
				SendClientMessage(playerid,grey,string);
				PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
				format(string,sizeof(string),"None");
				strmid(Fishes[playerid][pFishName1], string, 0, strlen(string), 255);
				Fishes[playerid][pFishWeight1] = 0;
				Fishes[playerid][pFishes]-=1;
				Fishes[playerid][pFish][0] = 0;
				FishDelay[playerid] = 900;
			}
			else
			{
			    format(string,sizeof(string),"\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs",Fishes[playerid][pFishName1],Fishes[playerid][pFishWeight1],Fishes[playerid][pFishName2],Fishes[playerid][pFishWeight2],Fishes[playerid][pFishName3],Fishes[playerid][pFishWeight3],Fishes[playerid][pFishName4],Fishes[playerid][pFishWeight4],Fishes[playerid][pFishName5],Fishes[playerid][pFishWeight5]);
    			ShowPlayerDialog(playerid,8,DIALOG_STYLE_LIST,"Fishes",string,"Sell","Exit");
    			return 1;
			}
		}
		case 10:
		{
		    if(response)
		    {
				GivePlayerMoney(playerid,Fishes[playerid][pFishWeight2]);
				format(string,sizeof(string)," Bait Shop: You have sold you'r %s wich weights %dLbs for %d$!",Fishes[playerid][pFishName2],Fishes[playerid][pFishWeight2],Fishes[playerid][pFishWeight2]);
				SendClientMessage(playerid,grey,string);
				PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
				format(string,sizeof(string),"None");
				strmid(Fishes[playerid][pFishName2], string, 0, strlen(string), 255);
				Fishes[playerid][pFishWeight2] = 0;
				Fishes[playerid][pFishes]-=1;
				Fishes[playerid][pFish][1] = 0;
				FishDelay[playerid] = 900;
			}
			else
			{
			    format(string,sizeof(string),"\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs",Fishes[playerid][pFishName1],Fishes[playerid][pFishWeight1],Fishes[playerid][pFishName2],Fishes[playerid][pFishWeight2],Fishes[playerid][pFishName3],Fishes[playerid][pFishWeight3],Fishes[playerid][pFishName4],Fishes[playerid][pFishWeight4],Fishes[playerid][pFishName5],Fishes[playerid][pFishWeight5]);
    			ShowPlayerDialog(playerid,8,DIALOG_STYLE_LIST,"Fishes",string,"Sell","Exit");
    			return 1;
			}
		}
		case 11:
		{
		    if(response)
		    {
				GivePlayerMoney(playerid,Fishes[playerid][pFishWeight3]);
				format(string,sizeof(string)," Bait Shop: You have sold you'r %s wich weights %dLbs for %d$!",Fishes[playerid][pFishName3],Fishes[playerid][pFishWeight3],Fishes[playerid][pFishWeight3]);
				SendClientMessage(playerid,grey,string);
				PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
				format(string,sizeof(string),"None");
				strmid(Fishes[playerid][pFishName3], string, 0, strlen(string), 255);
				Fishes[playerid][pFishWeight3] = 0;
				Fishes[playerid][pFishes]-=1;
				Fishes[playerid][pFish][2] = 0;
				FishDelay[playerid] = 900;
			}
			else
			{
			    format(string,sizeof(string),"\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs",Fishes[playerid][pFishName1],Fishes[playerid][pFishWeight1],Fishes[playerid][pFishName2],Fishes[playerid][pFishWeight2],Fishes[playerid][pFishName3],Fishes[playerid][pFishWeight3],Fishes[playerid][pFishName4],Fishes[playerid][pFishWeight4],Fishes[playerid][pFishName5],Fishes[playerid][pFishWeight5]);
    			ShowPlayerDialog(playerid,8,DIALOG_STYLE_LIST,"Fishes",string,"Sell","Exit");
    			return 1;
			}
		}
		case 12:
		{
		    if(response)
		    {
				GivePlayerMoney(playerid,Fishes[playerid][pFishWeight4]);
				format(string,sizeof(string)," Bait Shop: You have sold you'r %s wich weights %dLbs for %d$!",Fishes[playerid][pFishName4],Fishes[playerid][pFishWeight4],Fishes[playerid][pFishWeight4]);
				SendClientMessage(playerid,grey,string);
				PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
				format(string,sizeof(string),"None");
				strmid(Fishes[playerid][pFishName4], string, 0, strlen(string), 255);
				Fishes[playerid][pFishWeight4] = 0;
				Fishes[playerid][pFishes]-=1;
				Fishes[playerid][pFish][3] = 0;
				FishDelay[playerid] = 900;
			}
			else
			{
			    format(string,sizeof(string),"\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs",Fishes[playerid][pFishName1],Fishes[playerid][pFishWeight1],Fishes[playerid][pFishName2],Fishes[playerid][pFishWeight2],Fishes[playerid][pFishName3],Fishes[playerid][pFishWeight3],Fishes[playerid][pFishName4],Fishes[playerid][pFishWeight4],Fishes[playerid][pFishName5],Fishes[playerid][pFishWeight5]);
    			ShowPlayerDialog(playerid,8,DIALOG_STYLE_LIST,"Fishes",string,"Sell","Exit");
    			return 1;
			}
		}
		case 13:
		{
		    if(response)
		    {
				GivePlayerMoney(playerid,Fishes[playerid][pFishWeight5]);
				format(string,sizeof(string)," Bait Shop: You have sold you'r %s wich weights %dLbs for %d$!",Fishes[playerid][pFishName5],Fishes[playerid][pFishWeight5],Fishes[playerid][pFishWeight5]);
				SendClientMessage(playerid,grey,string);
				PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
				format(string,sizeof(string),"None");
				strmid(Fishes[playerid][pFishName5], string, 0, strlen(string), 255);
				Fishes[playerid][pFishWeight5] = 0;
				Fishes[playerid][pFishes]-=1;
				Fishes[playerid][pFish][4] = 0;
				FishDelay[playerid] = 900;
			}
			else
			{
			    format(string,sizeof(string),"\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs\n\t%s,Weight: %dLbs",Fishes[playerid][pFishName1],Fishes[playerid][pFishWeight1],Fishes[playerid][pFishName2],Fishes[playerid][pFishWeight2],Fishes[playerid][pFishName3],Fishes[playerid][pFishWeight3],Fishes[playerid][pFishName4],Fishes[playerid][pFishWeight4],Fishes[playerid][pFishName5],Fishes[playerid][pFishWeight5]);
    			ShowPlayerDialog(playerid,8,DIALOG_STYLE_LIST,"Fishes",string,"Sell","Exit");
    			return 1;
			}
		}
		case 14:
		{
		    if(response)
		    {
		        if(listitem == 0)
		        {
		            if(Fishes[playerid][pFishBait][0] == 0)
		            {
                        format(string,sizeof(string),"\tCheese: %d\n\tWorms: %d\n\tCrabs %d\n\tOctopus: %d",Fishes[playerid][pFishBait][0],Fishes[playerid][pFishBait][1],Fishes[playerid][pFishBait][2],Fishes[playerid][pFishBait][3]);
    					ShowPlayerDialog(playerid,14,DIALOG_STYLE_LIST,"Fishing Baits",string,"Use","Exit");
					}
					else
					{
					    Fishes[playerid][pFishBaitUsing] = 1;
					    Fishes[playerid][pFishBait][0]-=1;
					    if(LineSnapped[playerid] == 0)
			        	{
			            	new time = random(10000)+10000;
							FishCatchTimer[playerid] = SetTimerEx("FishCatch",time,false,"d",playerid);
			        		SendClientMessage(playerid,grey," Line Casted!");
			        		SendClientMessage(playerid,grey," You can now get out of the Tropic Boat.");
			        		LineSnapped[playerid] = 1;
			        		return 1;
						}
						else
						{
					    	SendClientMessage(playerid,grey," You already got a line casted!");
						}
					}
				}
				else if(listitem == 1)
		        {
		            if(Fishes[playerid][pFishBait][1] == 0)
		            {
                        format(string,sizeof(string),"\tCheese: %d\n\tWorms: %d\n\tCrabs %d\n\tOctopus: %d",Fishes[playerid][pFishBait][0],Fishes[playerid][pFishBait][1],Fishes[playerid][pFishBait][2],Fishes[playerid][pFishBait][3]);
    					ShowPlayerDialog(playerid,14,DIALOG_STYLE_LIST,"Fishing Baits",string,"Use","Exit");
					}
					else
					{
					    Fishes[playerid][pFishBaitUsing] = 2;
					    Fishes[playerid][pFishBait][1]-=1;
					    if(LineSnapped[playerid] == 0)
			        	{
			            	new time = random(10000)+10000;
							FishCatchTimer[playerid] = SetTimerEx("FishCatch",time,false,"d",playerid);
			        		SendClientMessage(playerid,grey," Line Casted!");
			        		SendClientMessage(playerid,grey," You can now get out of the Tropic Boat.");
			        		LineSnapped[playerid] = 1;
			        		return 1;
						}
						else
						{
					    	SendClientMessage(playerid,grey," You already got a line casted!");
						}
					}
				}
				else if(listitem == 2)
		        {
		            if(Fishes[playerid][pFishBait][2] == 0)
		            {
                        format(string,sizeof(string),"\tCheese: %d\n\tWorms: %d\n\tCrabs %d\n\tOctopus: %d",Fishes[playerid][pFishBait][0],Fishes[playerid][pFishBait][1],Fishes[playerid][pFishBait][2],Fishes[playerid][pFishBait][3]);
    					ShowPlayerDialog(playerid,14,DIALOG_STYLE_LIST,"Fishing Baits",string,"Use","Exit");
					}
					else
					{
					    Fishes[playerid][pFishBaitUsing] = 3;
					    Fishes[playerid][pFishBait][2]-=1;
					    if(LineSnapped[playerid] == 0)
			        	{
			            	new time = random(10000)+10000;
							FishCatchTimer[playerid] = SetTimerEx("FishCatch",time,false,"d",playerid);
			        		SendClientMessage(playerid,grey," Line Casted!");
			        		SendClientMessage(playerid,grey," You can now get out of the Tropic Boat.");
			        		LineSnapped[playerid] = 1;
			        		return 1;
						}
						else
						{
					    	SendClientMessage(playerid,grey," You already got a Line Casted!");
						}
					}
				}
				else if(listitem == 3)
		        {
		            if(Fishes[playerid][pFishBait][3] == 0)
		            {
                        format(string,sizeof(string),"\tCheese: %d\n\tWorms: %d\n\tCrabs %d\n\tOctopus: %d",Fishes[playerid][pFishBait][0],Fishes[playerid][pFishBait][1],Fishes[playerid][pFishBait][2],Fishes[playerid][pFishBait][3]);
    					ShowPlayerDialog(playerid,14,DIALOG_STYLE_LIST,"Fishing Baits",string,"Use","Exit");
					}
					else
					{
					    Fishes[playerid][pFishBaitUsing] = 4;
					    Fishes[playerid][pFishBait][3]-=1;
					    if(LineSnapped[playerid] == 0)
			        	{
			            	new time = random(10000)+10000;
							FishCatchTimer[playerid] = SetTimerEx("FishCatch",time,false,"d",playerid);
			        		SendClientMessage(playerid,grey," Line Casted!");
			        		SendClientMessage(playerid,grey," You can now get out of the Tropic Boat.");
			        		LineSnapped[playerid] = 1;
			        		return 1;
						}
						else
						{
					    	SendClientMessage(playerid,grey," You already got a Line Casted!");
						}
					}
				}
				return 1;
			}
		}
	}
	return 1;
}

#endif