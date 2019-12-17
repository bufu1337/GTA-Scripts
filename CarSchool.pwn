#include <a_samp>
#include <Dini>

#define COLOR_CYAN 0x00CCCCFF
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_RADIO 0x008B8BFF
#define COLOR_RED 0xFF0000FF
#define COLOR_GREEN 0x49E20EFF
#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#pragma semicolon 0

enum PLAYER_DMV
{
	PLAYER_IN_DMV,
	PLAYER_ON_DUTY
}

new gDMVPlayerInfo[MAX_PLAYERS][PLAYER_DMV];
new driverschoolenter,driverschoolexit,DMVMenupickup;
new Bcar1,Bcar2,Bcar3,Bcar4,Acar1,Acar2;
new Menu:DMVMenu,Menu:DMVPMenu,Menu:DMVArmoury;
new ChoosingSkin[MAX_PLAYERS];
new pLicensesInfo[MAX_PLAYERS];

public OnGameModeInit()
{
	DMVMenu = CreateMenu("The DMV",1,300.0,100.0,300.0);
	AddMenuItem(DMVMenu,0,"Request a B-class DMV licensor");
	AddMenuItem(DMVMenu,0,"Request an A-class DMV licensor");
	AddMenuItem(DMVMenu,0,"Nevermind...");
	DMVPMenu = CreateMenu("DMV Locker",1,300.0,100.0,300.0);
	AddMenuItem(DMVPMenu,0,"Go on/off duty");
	AddMenuItem(DMVPMenu,0,"Change uniform");
	AddMenuItem(DMVPMenu,0,"Armoury");
	DMVArmoury = CreateMenu("Armoury",2,300.0,100.0,150.0, 150.0);
	AddMenuItem(DMVArmoury,0,"Weapons");
	AddMenuItem(DMVArmoury,0,"Armour");
	AddMenuItem(DMVArmoury,1,"$5000");
	AddMenuItem(DMVArmoury,1,"$2000");
	Bcar1 = AddStaticVehicleEx(405,342.8414,-1350.3776,14.3828,118.4376,11,11,300);
 	Bcar2 = AddStaticVehicleEx(405,329.2794,-1343.3014,14.3922,208.0797,11,11,300);
 	Bcar3 = AddStaticVehicleEx(405,337.5486,-1340.6707,14.3828,117.9454,11,11,300);
 	Bcar4 = AddStaticVehicleEx(405,340.0934,-1345.5746,14.3828,118.5098,11,11,300);
 	Acar1 = AddStaticVehicleEx(475,345.4035,-1355.3492,14.3105,118.3625,11,11,300);
 	Acar2 = AddStaticVehicleEx(475,341.7986,-1337.3308,14.3141,209.9554,11,11,300);
 	driverschoolenter = CreatePickup(1239,23,337.5643,-1370.2089,14.3267);
 	driverschoolexit = CreatePickup(1239,23,-2029.798339,-106.675910,1035.171875);
 	DMVMenupickup = CreatePickup(1239,23,-2034.7899,-115.3649,1035.1719);
 	if(dini_Exists("DMVInfo.ini")) print("DMVInfo.ini found.")
	else dini_Create("DMVInfo.ini")
	if(dini_Exists("LicenseInfo.ini")) print("LicenseInfo.ini found.")
	else dini_Create("LicenseInfo.ini")
}

public OnGameModeExit()
{
	for(new i = 0; i < GetMaxPlayers(); i++)
	{
	    if(IsPlayerConnected(i))
	    {
        	gDMVPlayerInfo[i][PLAYER_ON_DUTY] = 0;
    		SetPlayerColor(i,COLOR_WHITE);
    		new NameString[MAX_PLAYER_NAME];
    		GetPlayerName(i,NameString,sizeof(NameString));
    		dini_IntSet("DMVInfo.ini", NameString, gDMVPlayerInfo[i][PLAYER_IN_DMV]);
    		gDMVPlayerInfo[i][PLAYER_IN_DMV] = 0;
    		dini_Set("LicenseInfo.ini", NameString, pLicensesInfo[i]);
    		pLicensesInfo[i] = 0;
		}
	}
}

public OnPlayerConnect(playerid)
{
    SetPlayerMapIcon(playerid,20,337.5643,-1370.2089,14.3267,55,0);
    new NameString[MAX_PLAYER_NAME];
    GetPlayerName(playerid,NameString,sizeof(NameString));
    if(dini_Isset("LicenseInfo.ini", NameString))
    {
        new string[255];
		string = dini_Get("LicenseInfo.ini", NameString);
    	if(strcmp(string, "A", true) == 0) pLicensesInfo[playerid] = 'A'
		else if(strcmp(string, "B", true) == 0) pLicensesInfo[playerid] = 'B'
		if(strcmp(string, "A", true) != 0 && strcmp(string, "B", true) != 0) pLicensesInfo[playerid] = 0
	}
	else
	{
		dini_Set("LicenseInfo.ini", NameString, "N");
		pLicensesInfo[playerid] = 0;
	}
	if(dini_Isset("DMVInfo.ini", NameString))
	{
		new Rank = dini_Int("DMVInfo.ini", NameString);
		gDMVPlayerInfo[playerid][PLAYER_IN_DMV] = Rank;
	}
	else
	{
	    dini_IntSet("DMVInfo.ini", NameString, 0);
	    gDMVPlayerInfo[playerid][PLAYER_IN_DMV] = 0;
	}
}

public OnPlayerDisconnect(playerid)
{
    gDMVPlayerInfo[playerid][PLAYER_ON_DUTY] = 0;
    SetPlayerColor(playerid, COLOR_WHITE);
    new NameString[MAX_PLAYER_NAME];
    GetPlayerName(playerid, NameString,sizeof(NameString));
    dini_IntSet("DMVInfo.ini", NameString, gDMVPlayerInfo[playerid][PLAYER_IN_DMV]);
    gDMVPlayerInfo[playerid][PLAYER_IN_DMV] = 0;
    dini_Set("LicenseInfo.ini", NameString, pLicensesInfo[playerid]);
    pLicensesInfo[playerid] = 'N';
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if((vehicleid == Bcar1||vehicleid == Bcar2||vehicleid == Bcar3||vehicleid == Bcar4) && ispassenger == 0) SendClientMessage(playerid, COLOR_CYAN, "This is a B-license test vehicle")
	else if((vehicleid == Acar1||vehicleid == Acar2) && ispassenger == 0) SendClientMessage(playerid, COLOR_CYAN, "This is an A-license test vehicle")
	else if(ispassenger == 0 && (vehicleid != Bcar1||vehicleid != Bcar2||vehicleid != Bcar3||vehicleid != Bcar4||vehicleid != Acar1||vehicleid != Acar2))
	{
		if(pLicensesInfo[playerid] == 'A'||pLicensesInfo[playerid] == 'B') SendClientMessage(playerid, COLOR_GREEN, "Stay careful while driving!")
		else if(pLicensesInfo[playerid] == 'N') SendClientMessage(playerid, COLOR_WHITE, "You do not have a drivers license! Look out for cops!")
	}
}

public OnPlayerSelectedMenuRow(playerid,row)
{
	if(GetPlayerMenu(playerid) == DMVMenu)
	{
	    switch(row)
	    {
	        case 0:
	        {
	            SendClientMessage(playerid, COLOR_CYAN, "You have requested a B-class DMV licensor. Please wait.");
	            for(new i = 0; i < GetMaxPlayers(); i++)
				{
					if(IsPlayerConnected(i))
					{
						if(gDMVPlayerInfo[i][PLAYER_ON_DUTY] == 1)
						{
							new requestedB[64];
							format(requestedB,sizeof(requestedB),"%d has requested a B-class DMV licensor", playerid);
							SendClientMessage(i, COLOR_CYAN, requestedB);
						}
					}
				}
			}
			case 1:
			{
			    SendClientMessage(playerid, COLOR_CYAN, "You have requested an A-class DMV licensor. Please wait.");
			    for(new i = 0; i < GetMaxPlayers(); i++)
			    {
			        if(IsPlayerConnected(i))
			        {
			            if(gDMVPlayerInfo[playerid][PLAYER_ON_DUTY] == 1)
			            {
			                new requestedA[64];
			                format(requestedA,sizeof(requestedA),"%d has requested an A-class DMV licensor", playerid);
			                SendClientMessage(i, COLOR_CYAN, requestedA);
						}
					}
				}
			}
		}
		TogglePlayerControllable(playerid, 1)
	}
	else if(GetPlayerMenu(playerid) == DMVPMenu)
	{
	    switch(row)
	    {
	        case 0:
	        {
	            switch(gDMVPlayerInfo[playerid][PLAYER_ON_DUTY])
	            {
	                case 0:
	                {
	                    gDMVPlayerInfo[playerid][PLAYER_ON_DUTY] = 1;
						SetPlayerColor(playerid, COLOR_CYAN);
						SendClientMessage(playerid, COLOR_CYAN, "You are now on duty and can give drivers licenses.");
					}
					case 1:
					{
						gDMVPlayerInfo[playerid][PLAYER_ON_DUTY] = 0;
						SetPlayerColor(playerid, COLOR_WHITE);
						SendClientMessage(playerid, COLOR_CYAN, "You are now off duty and cannot give drivers licenses.");
					}
				}
				TogglePlayerControllable(playerid, 1);
			}
			case 1:
			{
			    SendClientMessage(playerid, COLOR_CYAN, "Type next or done to choose a skin");
			    ChoosingSkin[playerid] = 1;
			}
			case 2: ShowMenuForPlayer(DMVArmoury, playerid)
		}
	}
	else if(GetPlayerMenu(playerid) == DMVArmoury)
	{
	    switch(row)
	    {
	        case 0:
	        {
	            new money;
         		money = GetPlayerMoney(playerid);
	            if(money >= 5000)
	            {
	            	GivePlayerWeapon(playerid,3,1);
					GivePlayerWeapon(playerid,24,65536);
					SendClientMessage(playerid, COLOR_CYAN, "You have recieved some protection!");
					GivePlayerMoney(playerid,-5000);
				}
				if(money < 5000) SendClientMessage(playerid, COLOR_RED, "You do not have $5000!")
			}
			case 1:
			{
			    new money;
         		money = GetPlayerMoney(playerid);
			    if(money >= 2000)
			    {
			    	SetPlayerArmour(playerid,100.0);
			    	SendClientMessage(playerid, COLOR_CYAN, "You have recieved some kevlar armour.");
			    	GivePlayerMoney(playerid,-2000);
				}
				if(money < 2000) SendClientMessage(playerid, COLOR_RED, "You do not have $2000!")
			}
		}
		TogglePlayerControllable(playerid, 1);
	}
}

public OnPlayerText(playerid, text[])
{
	if(ChoosingSkin[playerid] == 1)
	{
   		if(strcmp("next", text, true, 4) == 0)
		{
			switch(GetPlayerSkin(playerid))
			{
				case 57: SetPlayerSkin(playerid, 113)
				case 113: SetPlayerSkin(playerid, 147)
				case 147: SetPlayerSkin(playerid, 227)
				case 227: SetPlayerSkin(playerid, 228)
				case 228: SetPlayerSkin(playerid, 150)
				case 150: SetPlayerSkin(playerid, 57)
				default: SetPlayerSkin(playerid, 57)
			}
			return 0;
		}
		else if(strcmp("done", text, true, 4) == 0)
		{
		    ChoosingSkin[playerid] = 0;
		    TogglePlayerControllable(playerid, 1);
		    return 0;
		}
		else
		{
			SendClientMessage(playerid, COLOR_CYAN, "Use next or done!");
  			return 0;
		}
	}
	else return 1
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(gDMVPlayerInfo[playerid][PLAYER_IN_DMV] >= 1 && gDMVPlayerInfo[playerid][PLAYER_ON_DUTY] == 1)
	{
		gDMVPlayerInfo[playerid][PLAYER_ON_DUTY] = 0;
		SetPlayerColor(playerid, COLOR_WHITE);
	}
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(invite,6,cmdtext);
	dcmd(uninvite,8,cmdtext);
	dcmd(givelicense,11,cmdtext);
	dcmd(takelicense,11,cmdtext);
	dcmd(radio,5,cmdtext);
	dcmd(r,1,cmdtext);
	dcmd(setrank,7,cmdtext);
	if(strcmp(cmdtext, "/quitfaction", true, 12) == 0)
	{
	    if(gDMVPlayerInfo[playerid][PLAYER_IN_DMV] >= 1 && gDMVPlayerInfo[playerid][PLAYER_IN_DMV] <= 6)
	    {
	        gDMVPlayerInfo[playerid][PLAYER_ON_DUTY] = 0;
	        SetPlayerColor(playerid, COLOR_WHITE);
	    	gDMVPlayerInfo[playerid][PLAYER_IN_DMV] = 0;
	    	SendClientMessage(playerid, COLOR_CYAN, "You have quit the DMV. You are now a civilian.");
		}
		if(gDMVPlayerInfo[playerid][PLAYER_IN_DMV] == 0) SendClientMessage(playerid, COLOR_WHITE, "You are not in a faction!")
	    return 1;
	}
	else if(strcmp(cmdtext, "/enter", true, 6) == 0 && GetPlayerState(playerid) == 1)
	{
		if(PlayerToPoint(5, playerid, 337.5643,-1370.2089,14.3267))
		{
		    SetPlayerInterior(playerid, 3);
		    SetPlayerFacingAngle(playerid, 180);
		    SetCameraBehindPlayer(playerid);
		    SetPlayerPos(playerid, -2029.798339,-106.675910,1035.171875);
		}
		return 1;
	}
	else if(strcmp(cmdtext, "/exit", true, 5) == 0)
	{
		if (PlayerToPoint(5, playerid, -2029.798339,-106.675910,1035.171875))
	   	{
   			SetPlayerInterior(playerid, 0);
   			SetPlayerFacingAngle(playerid, 180);
   			SetCameraBehindPlayer(playerid);
     		SetPlayerPos(playerid, 337.5643,-1370.2089,14.3267);
    	}
 		return 1;
	}
	else if(strcmp(cmdtext, "/dmv", true, 4) == 0)
	{
	    if(PlayerToPoint(5,playerid,-2034.7899,-115.3649,1035.1719))
	    {
	        TogglePlayerControllable(playerid, 0);
	        if(gDMVPlayerInfo[playerid][PLAYER_IN_DMV] >= 1) ShowMenuForPlayer(DMVPMenu, playerid)
	        if(gDMVPlayerInfo[playerid][PLAYER_IN_DMV] == 0) ShowMenuForPlayer(DMVMenu, playerid)
		}
		return 1;
	}
	else if(strcmp(cmdtext, "/licensors", true, 10) == 0)
	{
	    if(gDMVPlayerInfo[playerid][PLAYER_IN_DMV] >= 1)
	    {
	    	SendClientMessage(playerid, COLOR_GREEN, "----------------------------------------");
	        for(new i = 0;i < GetMaxPlayers(); i++)
	        {
				if(gDMVPlayerInfo[i][PLAYER_IN_DMV] >= 1)
				{
				    new Name[MAX_PLAYER_NAME], Rank[20], Licensors[64];
					GetPlayerName(i,Name,sizeof(Name));
					Rank = GetPlayerRankName(i);
					format(Licensors,sizeof(Licensors),"%s %s", Rank, Name);
					SendClientMessage(playerid,COLOR_WHITE,         Licensors);
				}
			}
			SendClientMessage(playerid, COLOR_GREEN, "----------------------------------------");
		}
		else
		{
			SendClientMessage(playerid, COLOR_WHITE, "You are not in the DMV!")
		}
		return 1;
	}
	return 0;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(pickupid == driverschoolenter && GetPlayerState(playerid) == 1) GameTextForPlayer(playerid,"~w~Type ~r~/enter ~w~to enter the DMV",6000,3)
 	else if(pickupid == driverschoolexit) GameTextForPlayer(playerid,"~w~Type ~r~/exit ~w~to exit the DMV",6000,3)
	else if(pickupid == DMVMenupickup) GameTextForPlayer(playerid,"~w~Type ~r~/dmv ~w~to see the DMV Menu",6000,3)
}

dcmd_invite(playerid, params[])
{
	new id;
	if(sscanf(params, "u", id)) SendClientMessage(playerid, COLOR_WHITE, "Usage: \"/invite [playerid/part of player name]\"")
	else if(id == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED, "Error:Player not found!")
	else
	{
	    switch(gDMVPlayerInfo[playerid][PLAYER_IN_DMV])
	    {
	        case 0 .. 4: SendClientMessage(playerid, COLOR_CYAN, "You are not a DMV Rank 5+.")
			case 5,6:
			{
				switch(gDMVPlayerInfo[id][PLAYER_IN_DMV])
				{
				    case 0:
				    {
				        new invite[128], invited[32], NameString[MAX_PLAYER_NAME];
						format(invite,sizeof(invite), "You have been invited into the DMV by %d. If you do not wish to be in the DMV, type /quitfaction", playerid);
       					SendClientMessage(id, COLOR_CYAN,invite);
       					format(invited,sizeof(invited), "%d is now in the DMV",id);
			    		SendClientMessage(playerid, COLOR_CYAN, invited);
			    		dini_IntSet("DMVInfo.ini", NameString,1);
						gDMVPlayerInfo[id][PLAYER_IN_DMV] = 1;
					}
					case 1 .. 6: SendClientMessage(playerid, COLOR_WHITE, "That player is already in the DMV!")
    			}
			}
		}
	}
	return 1;
}

dcmd_setrank(playerid, params[])
{
	new id, rank;
	if(sscanf(params,"ui",id,rank)) SendClientMessage(playerid, COLOR_WHITE, "Usage: \"/setrank [playerid/part of player name] [rank(1-6)]\"")
	else if(id == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED, "Error:Player not found!")
	else if(id == playerid) SendClientMessage(playerid, COLOR_RED, "Error:You cannot set your own rank!")
	else if(rank <= 0||rank >= 7) SendClientMessage(playerid, COLOR_RED, "Error:Use rank 1-6!")
	else if(rank == 6 && gDMVPlayerInfo[playerid][PLAYER_IN_DMV] == 5) SendClientMessage(playerid, COLOR_RED, "Error:You cannot set someone's rank higher than yourself!")
	else
	{
	    switch(gDMVPlayerInfo[playerid][PLAYER_IN_DMV])
	    {
	        case 0 .. 4: SendClientMessage(playerid, COLOR_WHITE, "You are not a DMV rank 5+.")
			case 5,6:
			{
			    new GotRanked[64], NameString[MAX_PLAYER_NAME], GaveRank[64], NameString2[MAX_PLAYER_NAME];
			    GetPlayerName(playerid,NameString,sizeof(NameString));
				format(GotRanked,sizeof(GotRanked),"You have been given rank %d by %s", rank, NameString);
				SendClientMessage(id,COLOR_CYAN,GotRanked);
				GetPlayerName(id,NameString2,sizeof(NameString2));
				format(GaveRank,sizeof(GaveRank),"You have given rank %d to %s", rank, NameString2);
				SendClientMessage(playerid, COLOR_CYAN, GaveRank);
				gDMVPlayerInfo[id][PLAYER_IN_DMV] = rank;
				dini_IntSet("DMVInfo.ini",NameString2,rank);
			}
		}
	}
	return 1;
}

dcmd_uninvite(playerid, params[])
{
	new id;
	if(sscanf(params,"u",id)) SendClientMessage(playerid, COLOR_WHITE, "Usage: \"/invite [playerid/part of player name]\"")
	else if(id == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED, "Error:Player not found!")
	else if(id == playerid) SendClientMessage(playerid, COLOR_RED, "Error:You cannot uninvite yourself! Use \"/quitfaction\"")
	else
	{
		switch(gDMVPlayerInfo[playerid][PLAYER_IN_DMV])
		{
		    case 0 .. 5: SendClientMessage(playerid, COLOR_WHITE, "You are not a DMV rank 6.")
			case 6:
			{
			    new uninvite[64];
			    new NameString[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, NameString, sizeof(NameString));
			    format(uninvite,sizeof(uninvite), "You have been uninvited from the DMV by %d", NameString);
			    SendClientMessage(id, COLOR_CYAN, uninvite);
			    new uninvited[32];
			    new NameString2[MAX_PLAYER_NAME];
			    GetPlayerName(id, NameString2, sizeof(NameString2));
			    format(uninvited,sizeof(uninvited), "%d uninvited", NameString2);
			    SendClientMessage(playerid, COLOR_CYAN, uninvited);
			    gDMVPlayerInfo[id][PLAYER_IN_DMV] = 0;
			    gDMVPlayerInfo[id][PLAYER_ON_DUTY] = 0;
			    dini_IntSet("DMVInfo.ini",NameString2,0);
			}
		}
	}
	return 1;
}

dcmd_givelicense(playerid, params[])
{
    new id, Licensegiven;
	if(sscanf(params, "uc", id, Licensegiven)) SendClientMessage(playerid, COLOR_WHITE, "Usage: \"/givelicense [playerid/part of player name] [A/B]\"")
	else if(id == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED, "Error:Player not found!")
	else if(id == playerid) SendClientMessage(playerid, COLOR_RED, "Error:You cannot give licenses to yourself!")
	else
	{
	    switch(gDMVPlayerInfo[playerid][PLAYER_IN_DMV])
	    {
	        case 0: SendClientMessage(playerid, COLOR_WHITE, "You are not a DMV licensor!")
			case 1 .. 6:
			{
			    switch(gDMVPlayerInfo[playerid][PLAYER_ON_DUTY])
			    {
					case 0: SendClientMessage(playerid, COLOR_CYAN, "You are not on duty! Get on duty first!")
					case 1:
					{
					    new Float:Ax, Float:Ay, Float:Az;
					    GetPlayerPos(id,Ax,Ay,Az);
						if(PlayerToPoint(5.0,playerid,Ax,Ay,Az))
						{
						    switch(Licensegiven)
						    {
			    				case 'A':
			    				{
									if(pLicensesInfo[playerid] == 'B')
									{
  	    								new GaveA[64], GotA[64], RecievedA[MAX_PLAYER_NAME];
	    	    						format(GaveA,sizeof(GaveA),"You have given %d an A-class drivers license", id);
	    								SendClientMessage(playerid, COLOR_CYAN, GaveA);
		    							format(GotA,sizeof(GotA),"You have recieved an A-class drivers license from %d", playerid);
										SendClientMessage(id, COLOR_WHITE, GotA);
										GetPlayerName(id, RecievedA, sizeof(RecievedA));
										dini_Set("LicenseInfo.ini", RecievedA, "A");
										pLicensesInfo[id] = 'A';
									}
									if(pLicensesInfo[playerid] == 'A') SendClientMessage(playerid, COLOR_CYAN, "That player already has an A-license!")
									if(pLicensesInfo[playerid] == 'N') SendClientMessage(playerid, COLOR_CYAN, "That player doesn't even have a B-license yet!")
								}
								case 'B':
								{
								    if(pLicensesInfo[playerid] == 'B'||pLicensesInfo[playerid] == 'A') SendClientMessage(playerid, COLOR_CYAN, "That player already has a license!")
									if(pLicensesInfo[playerid] == 'N')
									{
										new GaveB[64], GotB[64], RecievedB[MAX_PLAYER_NAME];
					    				format(GaveB,sizeof(GaveB),"You have given %d a B-class drivers license", id);
					    				SendClientMessage(playerid, COLOR_CYAN, GaveB);
					    				format(GotB,sizeof(GotB),"You have recieved a B-class drivers license from %d", playerid);
					    				SendClientMessage(id, COLOR_WHITE, GotB);
					    				GetPlayerName(id, RecievedB, sizeof(RecievedB));
										dini_Set("LicenseInfo.ini", RecievedB, "B");
										pLicensesInfo[id] = 'B';
									}
								}
								default: SendClientMessage(playerid, COLOR_CYAN, "Invalid license type! Use A or B!")
							}
						}
						else SendClientMessage(playerid, COLOR_CYAN, "You are not near that player!")
					}
				}
			}
		}
	}
	return 1;
}

dcmd_takelicense(playerid, params[])
{
	new id, license;
	if(sscanf(params, "uc", id, license)) SendClientMessage(playerid, COLOR_WHITE, "Usage: \"/takelicense [playerid/part of player name] [A/B]\"")
	else if(id == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOR_RED, "Error:Player not found!")
	else if(id == playerid) return 1
	else
	{
		switch(gDMVPlayerInfo[playerid][PLAYER_IN_DMV]) // Add here factions you want to be able to take licenses
		{
		    case 0 .. 3: SendClientMessage(playerid, COLOR_RED, "You are not a DMV Rank 4+!")
			case 4 .. 6:
			{
				new Float:Ax, Float:Ay, Float:Az;
				GetPlayerPos(id,Ax,Ay,Az);
				if(PlayerToPoint(5.0,playerid,Ax,Ay,Az))
				{
					if(license == 'A')
    				{
						new NameString[MAX_PLAYER_NAME], NameString2[MAX_PLAYER_NAME], tookA[64], takenA[64];
						GetPlayerName(id,NameString,sizeof(NameString));
						format(tookA,sizeof(tookA),"You have taken %s's A-license! They only have a B-license now!", NameString);
						SendClientMessage(playerid, COLOR_CYAN, tookA);
						GetPlayerName(playerid,NameString2,sizeof(NameString2));
						format(takenA,sizeof(takenA),"%s has taken your A-license! You only have a B-license now!", NameString2);
						SendClientMessage(id,COLOR_CYAN,takenA);
						pLicensesInfo[playerid] = 'B';
			        	dini_Set("LicenseInfo.ini", NameString, "B");
					}
					if(license == 'B')
					{
    					new NameString[MAX_PLAYER_NAME], NameString2[MAX_PLAYER_NAME], tookB[64], takenB[64];
	   					GetPlayerName(id,NameString,sizeof(NameString));
				    	format(tookB,sizeof(tookB),"You have taken %s's B-license!", NameString);
	   					SendClientMessage(playerid,COLOR_CYAN, tookB);
	   					GetPlayerName(playerid,NameString2,sizeof(NameString2));
				    	format(takenB,sizeof(takenB),"%s has taken your B-license!", NameString2);
				    	SendClientMessage(id,COLOR_CYAN, takenB);
				    	pLicensesInfo[playerid] = 'N';
    					dini_Set("LicenseInfo.ini", NameString, "N");
					}
					else SendClientMessage(playerid, COLOR_CYAN, "Invalid license type! Use A or B!")
				}
				else SendClientMessage(playerid, COLOR_CYAN, "You are not near that player!")
			}
		}
	}
	return 1;
}

dcmd_radio(playerid, params[])
{
	new text[128];
	if(sscanf(params,"s", text)) SendClientMessage(playerid, COLOR_WHITE, "Usage: \"/r(adio) [text]\"")
	else if(gDMVPlayerInfo[playerid][PLAYER_IN_DMV] == 0) return 1
	else
	{
		for(new i; i < GetMaxPlayers(); i++)
		{
  			if(IsPlayerConnected(i))
			{
				new radiomessage[140], name[MAX_PLAYER_NAME], Rank[20];
 				Rank = GetPlayerRankName(playerid);
				GetPlayerName(playerid,name,sizeof(name));
				format(radiomessage,sizeof(radiomessage), " %s %s : %s", Rank, name, text);
     			SendClientMessage(i, COLOR_RADIO, radiomessage);
			}
		}
	}
	return 1;
}

dcmd_r(playerid, params[]) return dcmd_radio(playerid, params)

GetPlayerRankName(playerid)
{
	new Rank[19];
	if(gDMVPlayerInfo[playerid][PLAYER_IN_DMV] == 1) Rank = "Trainee Licensor"
	if(gDMVPlayerInfo[playerid][PLAYER_IN_DMV] == 2) Rank = "Licensor"
	if(gDMVPlayerInfo[playerid][PLAYER_IN_DMV] == 3) Rank = "Senior Licensor"
	if(gDMVPlayerInfo[playerid][PLAYER_IN_DMV] == 4) Rank = "Lead Licensor"
	if(gDMVPlayerInfo[playerid][PLAYER_IN_DMV] == 5) Rank = "Assistant Director"
	if(gDMVPlayerInfo[playerid][PLAYER_IN_DMV] == 6) Rank = "Head Director"
	return Rank;
}

PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	new Float:old[3], Float:tmp[3];
	GetPlayerPos(playerid, old[0], old[1], old[2]);
	tmp[0] = (old[0] -x);
	tmp[1] = (old[1] -y);
	tmp[2] = (old[2] -z);
	if (((tmp[0] < radi) && (tmp[0] > -radi)) && ((tmp[1] < radi) && (tmp[1] > -radi)) && ((tmp[2] < radi) && (tmp[2] > -radi))) return 1
	return 0;
}

sscanf(string[], format[], {Float,_}:...)
{
	#if defined isnull
	if (isnull(string))
	#else
	if (string[0] == 0 || (string[0] == 1 && string[1] == 0))
	#endif
	{
		return format[0];
	}
	new formatPos = 0, stringPos = 0, paramPos = 2, paramCount = numargs(), delim = ' ';
	while (string[stringPos] && string[stringPos] <= ' ')
	{
		stringPos++;
	}
	while (paramPos < paramCount && string[stringPos])
	{
		switch (format[formatPos++])
		{
			case '\0':
			{
				return 0;
			}
			case 'i', 'd':
			{
				new neg = 1, num = 0, ch = string[stringPos];
				if (ch == '-')
				{
					neg = -1;
					ch = string[++stringPos];
				}
				do
				{
					stringPos++;
					if ('0' <= ch <= '9')
					{
						num = (num * 10) + (ch - '0');
					}
					else
					{
						return -1;
					}
				}
				while ((ch = string[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num * neg);
			}
			case 'h', 'x':
			{
				new num = 0, ch = string[stringPos];
				do
				{
					stringPos++;
					switch (ch)
					{
						case 'x', 'X':
						{
							num = 0;
							continue;
						}
						case '0' .. '9':
						{
							num = (num << 4) | (ch - '0');
						}
							case 'a' .. 'f':
						{
							num = (num << 4) | (ch - ('a' - 10));
						}
						case 'A' .. 'F':
						{
							num = (num << 4) | (ch - ('A' - 10));
						}
						default:
						{
							return -1;
						}
					}
				}
				while ((ch = string[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num);
			}
			case 'c':
			{
				setarg(paramPos, 0, string[stringPos++]);
			}
			case 'f':
			{
				setarg(paramPos, 0, _:floatstr(string[stringPos]));
			}
			case 'p':
			{
				delim = format[formatPos++];
				continue;
			}
			case '\'':
			{
				new end = formatPos - 1, ch;
				while ((ch = format[++end]) && ch != '\'') {}
				if (!ch)
				{
					return -1;
				}
				format[end] = '\0';
				if ((ch = strfind(string, format[formatPos], false, stringPos)) == -1)
				{
					if (format[end + 1])
					{
						return -1;
					}
					return 0;
				}
				format[end] = '\'';
				stringPos = ch + (end - formatPos);
				formatPos = end + 1;
			}
			case 'u':
			{
				new end = stringPos - 1, id = 0, bool:num = true, ch;
				while ((ch = string[++end]) && ch != delim)
				{
					if (num)
					{
						if ('0' <= ch <= '9')
						{
							id = (id * 10) + (ch - '0');
						}
						else
						{
							num = false;
						}
					}
				}
				if (num && IsPlayerConnected(id))
				{
					setarg(paramPos, 0, id);
				}
				else
				{
					#if !defined foreach
						#define foreach(%1,%2) for (new %2 = 0; %2 < MAX_PLAYERS; %2++) if (IsPlayerConnected(%2))
						#define __SSCANF_FOREACH__
					#endif
					string[end] = '\0';
					num = false;
					new name[MAX_PLAYER_NAME]; id = end - stringPos;
					foreach (Player, playerid)
					{
						GetPlayerName(playerid, name, sizeof (name));
						if (!strcmp(name, string[stringPos], true, id))
						{
							setarg(paramPos, 0, playerid);
							num = true;
							break;
						}
					}
					if (!num)
					{
						setarg(paramPos, 0, INVALID_PLAYER_ID);
					}
					string[end] = ch;
					#if defined __SSCANF_FOREACH__
						#undef foreach
						#undef __SSCANF_FOREACH__
					#endif
				}
				stringPos = end;
			}
			case 's', 'z':
			{
				new i = 0, ch;
				if (format[formatPos])
				{
					while ((ch = string[stringPos++]) && ch != delim)
					{
						setarg(paramPos, i++, ch);
					}
					if (!i)
					{
						return -1;
					}
				}
				else
				{
					while ((ch = string[stringPos++]))
					{
						setarg(paramPos, i++, ch);
					}
				}
				stringPos--;
				setarg(paramPos, i, '\0');
			}
			default:
			{
				continue;
			}
		}
		while (string[stringPos] && string[stringPos] != delim && string[stringPos] > ' ')
		{
			stringPos++;
		}
		while (string[stringPos] && (string[stringPos] == delim || string[stringPos] <= ' '))
		{
			stringPos++;
		}
		paramPos++;
	}
	do
	{
		if ((delim = format[formatPos++]) > ' ')
		{
			if (delim == '\'')
			{
				while ((delim = format[formatPos++]) && delim != '\'') {}
			}
			else if (delim != 'z')
			{
				return delim;
			}
		}
	}
	while (delim > ' ');
	return 0;
}
