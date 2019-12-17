/*===================================================================================================*\
||===================================================================================================||
||	              ________    ________    ___    _    ______     ______     ________                 ||
||	        \    |   _____|  |  ____  |  |   \  | |  |   _  \   |  _   \   |  ____  |    /           ||
||	======== \   |  |_____   | |____| |  | |\ \ | |  |  | |  |  | |_|  /   | |____| |   / ========   ||
||	          |  | _____  |  |  ____  |  | | \ \| |  |  | |  |  |  _  \    |  ____  |  |             ||
||	======== /    ______| |  | |    | |  | |  \ \ |  |  |_|  |  | |  \ \   | |    | |   \ ========   ||
||	        /    |________|  |_|    |_|  |_|   \__|  |______/   |_|   \_|  |_|    |_|    \           ||
||                                                                                                   ||
||===================================================================================================||
||                               Created April 28th 2008 by =>Sandra<=                              ||
||                                    Do NOT remove any credits!!                                    ||
\*===================================================================================================*/

#include <a_samp>

/*
Difficulty Modes:
1 = Checkpoint appears on location of the cashbox
2 = Only the camera of players will be looking to cashbox location. They can review using /cashboxhint
*/

//CONFIGURATION::::::::
#define CashboxModel 1210   // Briefcase-model
#define MinCashboxValue 1500
#define MaxCashboxValue 20000
#define ValuedropPerSecond 8
#define DifficultyMode 2
new UseTextdraw = 1;
//END OF CONFIGURATION

new CashboxPickup;
new CashboxOwner = INVALID_PLAYER_ID;
new CashboxValue;
new Float:CashboxX;
new Float:CashboxY;
new Float:CashboxZ;
new IsGameStarted;
new DropValueTimer;
new Text:ValueText;
new IsTextdrawCreated;
new vps = ValuedropPerSecond;
new mode = DifficultyMode;
new IsCashboxPickedUp;

new Float:DropLocation[3] =
{1677.1796,1447.8167,10.7823};

new Float:CashboxLocations[][3] =
{
	{2227.74, 1516.43, 10.82},
	{-724.44, 1402.81, 13.07},
	{-1940.61, 1086.14, 53.09},
	{-2344.37, -459.59, 80.01},
	{-1674.65, -543.03, 14.14},
	{-2415.30, -2142.08, 52.37},
	{-1527.47, -2291.62, -5.63},
	{-1111.05, -2470.04, 76.59},
	{-288.23, -2163.67, 28.63},
	{-376.27, -2583.97, 138.17},
	{378.32, -1885.70, 2.05},
	{1120.86, -2065.82, 74.42},
	{1583.25, -2286.55, 13.53},
	{2718.67, -2385.16, 13.63},
	{2744.79, -1944.55, 17.32},
	{2041.71, -1715.58, 13.54},
	{2771.79, -1354.51, 50.00},
	{1102.96, -1092.89, 28.46},
	{727.73, -1276.13, 13.64},
	{755.31, -591.31, 18.01},
	{360.91, -110.02, 1.22},
	{-557.35, -541.28, 25.52},
	{-273.04, -955.98, 38.30},
	{1242.36, 327.17, 19.75},
	{2791.64, 2225.64, 14.66},
	{-1955.01, -986.97, 35.89},
	{-2108.89, -2376.97, 30.62},
	{1853.35, 2045.54, 10.85},
	{2478.85, -1437.22, 25.49},
	{-2241.50, 2462.93, 4.98},
	{703.36, 267.78, 21.44},
	{-599.09, -1080.95, 23.66},
	{-2677.68, 1503.98, 2.07},
	{2582.18, -2115.22, 1.11},
	{-1954.97, -986.27, 35.89},
	{541.41, 830.33, -39.44},
	{-2876.66, 292.77, 6.96},
	{-2192.16, 2409.51, 4.95},
	{2615.91, -1730.39, 6.24},
	{-529.81, -991.29, 24.55},
	{-1048.33, -1306.72, 128.50},
	{1227.20, 2584.68, 10.82},
	{1016.48, 1411.63, 10.82},
	{-1593.62, 802.54, 6.82},
	{-2238.23, -2478.96, 31.19},
	{917.43, 2402.92, 10.82},
	{1312.97, -1965.60, 29.46},
	{-120.59, -1531.31, 3.07},
	{-2508.68, -53.19, 25.65},
	{-2762.04, 105.18, 6.99},
	{1367.53, 194.54, 19.55},
	{-2655.83, -102.70, 3.99},
	{2161.85, -102.76, 2.75},
	{2535.77, 1342.55, 10.82},
	{-2059.10, 890.89, 61.85},
	{1188.14, 231.38, 19.56},
	{1088.81, 1073.79, 10.83},
	{422.96, 2539.45, 16.52},
	{-227.49, 2709.91, 62.98},
	{-347.38, 1581.21, 76.30},
	{-208.08, 1127.93, 19.74},
	{33.24, 1155.21, 19.69},
	{1582.07, -2691.56, 6.12},
	{1715.25, -1912.01, 13.56},
	{286.36, -1145.15, 80.91}
};

public OnFilterScriptInit()
{
	print("--------------------------------------");
	print("  Cashbox Filterscript by =>Sandra<=  ");
	print("--------------------------------------");
	if(mode == 1 || mode == 2)
	{
		SetTimer("StartNewCashboxGame", 30000, 0);
	}
	else
	{
        print("============================");
		print("          Error:            ");
		print("  Can't start CashboxGame   ");
		print(" Reason: Invalid Difficulty ");
		print("============================");
	}
	return 1;
}

public OnFilterScriptExit()
{
    if(IsGameStarted == 1)
	{
	    for(new i; i<MAX_PLAYERS; i++)
	    {
	        if(mode == 1)
	        {
	    		DisablePlayerCheckpoint(i);
			}
		}
	}
	DestroyPickup(CashboxPickup);
	if(IsTextdrawCreated == 1)
	{
		TextDrawHideForAll(ValueText);
		TextDrawDestroy(ValueText);
		IsTextdrawCreated = 0;
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(IsGameStarted == 1)
	{
		if(CashboxOwner == INVALID_PLAYER_ID)
		{
		    if(mode == 1)
      		{
		        SetPlayerCheckpoint(playerid, CashboxX, CashboxY, CashboxZ, 1);
			}
		}
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(playerid == CashboxOwner)
	{
	    new str[128], pName[MAX_PLAYER_NAME];
	    GetPlayerPos(playerid, CashboxX, CashboxY, CashboxZ);
	    GetPlayerName(playerid, pName, sizeof(pName));
	    format(str, 128, "Cashbox-Owner %s (ID: %d) has left the server and droped the cashbox!", pName, playerid);
	    SendClientMessageToAll(0xFFD700AA, str);
		CashboxPickup = CreatePickup(1210, 3, CashboxX, CashboxY, CashboxZ);
		CashboxOwner = INVALID_PLAYER_ID;
		if(mode == 1)
		{
	        for(new i; i<MAX_PLAYERS; i++)
			{
			    if(IsPlayerConnected(i))
			    {
			    	SetPlayerCheckpoint(i, CashboxX, CashboxY, CashboxZ, 1);
				}
			}
		}
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(playerid == CashboxOwner)
	{
	    new str[128], pName[MAX_PLAYER_NAME];
	    GetPlayerPos(playerid, CashboxX, CashboxY, CashboxZ);
	    GetPlayerName(playerid, pName, sizeof(pName));
	    format(str, 128, "Cashbox-Owner %s (ID: %d) has died and droped the cashbox!", pName, playerid);
	    SendClientMessageToAll(0xFFD700AA, str);
		CashboxPickup = CreatePickup(1210, 3, CashboxX, CashboxY, CashboxZ);
		
		CashboxOwner = INVALID_PLAYER_ID;
		if(mode == 1)
		{
	        for(new i; i<MAX_PLAYERS; i++)
			{
			    if(IsPlayerConnected(i))
			    {
			    	SetPlayerCheckpoint(i, CashboxX, CashboxY, CashboxZ, 1);
				}
			}
		}
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp(cmdtext, "/cashboxhint", true)==0)
	{
	    if(mode == 2)
	    {
	        if(IsCashboxPickedUp == 1)
	        {
	            new str[128];
	            new pName[MAX_PLAYER_NAME];
	            GetPlayerName(CashboxOwner, pName, 24);
	            format(str, 128, "%s (ID: %d) has already picked up the cashbox!", pName, CashboxOwner);
	            SendClientMessage(playerid, 0xFF0000AA, str);
			}
			else
			{
		        new randX = -100+random(200);
				new randY = -100+random(200);
				SetPlayerCameraPos(playerid, CashboxX+randX, CashboxY+randY, (CashboxZ+60));
				SetPlayerCameraLookAt(playerid, CashboxX, CashboxY, CashboxZ);
		        TogglePlayerControllable(playerid, 0);
		        SetTimerEx("ResetCam", 10000, 0, "i", playerid);
			}
		}
		return 1;
	}
    if(strcmp(cmdtext, "/goto", true)==0)
	{
	    SetPlayerPos(playerid, 2227.74, 1516.43, 10.82);
		return 1;
	}
	return 0;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(playerid == CashboxOwner)
	{
	    PlayerPlaySound(playerid, 1054, 0, 0, 0);
	    KillTimer(DropValueTimer);
	    new str[128], pName[MAX_PLAYER_NAME];
		if(mode == 1)
		{
	    	DisablePlayerCheckpoint(playerid);
		}
	    CashboxOwner = INVALID_PLAYER_ID;
		GetPlayerName(playerid, pName, sizeof(pName));
		format(str, 128, "%s (ID: %d) has delivered the cashbox! He/she won $%d", pName, playerid, CashboxValue);
		SendClientMessageToAll(0xFFD700AA, str);
		GivePlayerMoney(playerid, CashboxValue);
        format(str, 128, "~y~Congratulations! ~n~ You won ~n~~g~$%d", CashboxValue);
		GameTextForPlayer(playerid, str, 4000, 3);
		SendClientMessageToAll(0xFFD700AA, "A new game will start in 3 minutes!");
		SetTimer("StartNewCashboxGame", 180000, 0);
		IsGameStarted = 0;
		if(IsTextdrawCreated == 1)
		{
			TextDrawDestroy(ValueText);
			IsTextdrawCreated = 0;
		}
	}
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(pickupid == CashboxPickup)
	{
	    PlayerPlaySound(playerid, 1150, 0, 0, 0);
	    new str[128], pName[MAX_PLAYER_NAME];
	    DestroyPickup(CashboxPickup);
	    IsCashboxPickedUp = 1;
		CashboxOwner = playerid;
		GetPlayerName(playerid, pName, sizeof(pName));
		format(str, 128, "%s (ID: %d) has picked up the cashbox! Kill him before he reaches the droplocation!", pName, playerid);
		SendClientMessageToAll(0xFFD700AA, str);
		if(mode == 1)
		{
		    for(new i; i<MAX_PLAYERS; i++)
		    {
		        DisablePlayerCheckpoint(i);
			}
		}
		SetPlayerCheckpoint(playerid, DropLocation[0], DropLocation[1], DropLocation[2], 3);
	}
	return 1;
}


forward StartNewCashboxGame();
public StartNewCashboxGame()
{
    IsGameStarted = 1;
	new str[128];
	new rand = random(sizeof(CashboxLocations));
	CashboxValue = MinCashboxValue+random(MaxCashboxValue-MinCashboxValue);
    CashboxPickup = CreatePickup(1210, 3, CashboxLocations[rand][0], CashboxLocations[rand][1], CashboxLocations[rand][2]);
    CashboxX = CashboxLocations[rand][0];
    CashboxY = CashboxLocations[rand][1];
    CashboxZ = CashboxLocations[rand][2];
    format(str, 128, "A new cashbox, filled with %d dollar, is spotted somewhere in San Andreas!", CashboxValue);
    SendClientMessageToAll(0xFFD700AA, str);
    if(vps > 0)
    {
	    format(str, 128, "The value of this cashbox will drop $%d per second!", ValuedropPerSecond);
	    SendClientMessageToAll(0xFFD700AA, str);
	}
    SendClientMessageToAll(0xFFD700AA, "Objective: Get the briefcase first before someone else gets it and take it to the drop location!");
	for(new i; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(mode == 1)
			{
			    SetPlayerCheckpoint(i, CashboxLocations[rand][0], CashboxLocations[rand][1], CashboxLocations[rand][2], 1);
			}
			else if(mode == 2)
			{
			    new randX = -100+random(200);
			    new randY = -100+random(200);
				SetPlayerCameraPos(i, CashboxX+randX, CashboxY+randY, (CashboxZ+60));
				SetPlayerCameraLookAt(i, CashboxX, CashboxY, CashboxZ);
			    TogglePlayerControllable(i, 0);
			    SetTimerEx("ResetCam", 8000, 0, "i", i);
			    SendClientMessage(i, 0x0E68CAA, "You can see this location again using /CashboxHint");
			    GameTextForPlayer(i, "~y~Hint:", 8000, 4);
			}
		}
	}
	DropValueTimer = SetTimer("DropCashboxValue", 1000, 1);
}

forward DropCashboxValue();
public DropCashboxValue()
{
	if(IsTextdrawCreated == 1)
	{
		TextDrawDestroy(ValueText);
		IsTextdrawCreated = 0;
	}
	new TextString[40];
	if(CashboxValue > 0)
	{
	    CashboxValue -= ValuedropPerSecond;
	    format(TextString, 40, "~y~CashboxValue: ~n~~y~$%d", CashboxValue);
	}
	if(CashboxValue <= 0)
	{
		CashboxValue = 0;
	    SendClientMessageToAll(0xFFD700AA, "The cashbox has no value anymore!");
	    format(TextString, 40, "~y~CashboxValue: ~n~~r~$%d", CashboxValue);
	    KillTimer(DropValueTimer);
	}
	if(UseTextdraw == 1)
	{
		ValueText = TextDrawCreate(540, 410, TextString);
		IsTextdrawCreated = 1;
		TextDrawLetterSize(ValueText, 0.4, 1.2);
		TextDrawSetShadow(ValueText, 0);
		TextDrawUseBox(ValueText, 1);
		TextDrawBoxColor(ValueText, 0x000000AA);
		TextDrawShowForAll(ValueText);
	}
}

forward ResetCam(playerid);
public ResetCam(playerid)
{
	SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid, 1);
	TogglePlayerSpectating(playerid, 0);
}

