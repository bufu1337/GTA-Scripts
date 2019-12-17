#include <a_samp>

/*

	Duel Filterscript (Ripped from LW_LVDM)
	Brought to you by [NB]Sneaky

	www.99BlaZed.com
	www.sneakyhost.net

	You will need to edit line 184,185,201,202

*/

#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define SendError(%1,%2) SendClientMessage(%1,COLOR_RED,"ERROR: " %2)
#define SendUsage(%1,%2) SendClientMessage(%1,COLOR_WHITE,"USAGE: " %2)

#define COLOR_ORANGE 	0xFF8040FF
#define COLOR_YELLOW 	0xFFFF00AA
#define COLOR_RED 		0xFF0000AA
#define COLOR_WHITE  	0xFFFFFFAA


stock
	g_GotInvitedToDuel[MAX_PLAYERS],
	g_HasInvitedToDuel[MAX_PLAYERS],
	g_IsPlayerDueling[MAX_PLAYERS],
	g_DuelCountDown[MAX_PLAYERS],
	g_DuelTimer[MAX_PLAYERS],
	g_DuelInProgress,
	g_DuelingID1,
	g_DuelingID2;

public OnFilterScriptInit()
{
	print("\t============================================");
	print("\tDuel Filterscript (Ripped from LW_LVDM)");
	print("\tBy: Sneaky");
	print("\t-");
	print("\tLoaded");
	print("\t============================================");
	return 1;
}

public OnFilterScriptExit()
{
	print("\t============================================");
	print("\tDuel Filterscript (Ripped from LW_LVDM)");
	print("\tBy: Sneaky");
	print("\t-");
	print("\tLoaded");
	print("\t============================================");
	return 1;
}

public OnPlayerConnect(playerid)
{
	g_GotInvitedToDuel[playerid] = 0;
	g_HasInvitedToDuel[playerid] = 0;
	g_IsPlayerDueling[playerid]  = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(playerid == g_DuelingID1 || playerid == g_DuelingID2)
	{
	    g_DuelInProgress = 0;
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(duel,4,cmdtext);
	dcmd(cduel,5,cmdtext);
	dcmd(duelaccept,10,cmdtext);
	return 1;
}

dcmd_cduel(playerid, params[])
{
	#pragma unused params

	if(g_HasInvitedToDuel[playerid] == 0)
		return SendError(playerid, "You did not invite anyone to a duel!");

	SendClientMessage(playerid, COLOR_YELLOW, "You have reset your duel invite, you can now use /duel [playerid] again.");
	g_HasInvitedToDuel[playerid] = 0;

	return 1;
}

dcmd_duelaccept(playerid, params[])
{
	if(params[0] == '\0' || !IsNumeric(params))
	    return SendUsage(playerid, "/duelaccept [playerid]");

	if(g_DuelInProgress == 1)
		return SendError(playerid, "Another duel is in progress at the moment, wait till that duel is finished!");

    new
		DuelID = strvalEx(params),
		pName[MAX_PLAYER_NAME],
		zName[MAX_PLAYER_NAME],
		tString[128];

    if(DuelID != g_GotInvitedToDuel[playerid])
    	return SendError(playerid, "That player did not invite you to a duel!");

	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
	GetPlayerName(DuelID, zName, MAX_PLAYER_NAME);

 	format(tString, sizeof(tString), "You accepted the duel with %s (ID:%d), duel will start in 10 seconds..",zName,DuelID);
 	SendClientMessage(playerid, COLOR_YELLOW, tString);

 	format(tString, sizeof(tString), "%s (ID:%d), accepted the duel with you, duel will start in 10 seconds..",pName,playerid);
 	SendClientMessage(DuelID, COLOR_YELLOW, tString);

 	format(tString, sizeof(tString), "(News) Duel between %s and %s will start in 10 seconds",pName,zName);
 	SendClientMessageToAll(COLOR_ORANGE, tString);

 	InitializeDuel(playerid);
 	InitializeDuelEx( DuelID);

 	g_IsPlayerDueling[playerid] = 1;
 	g_IsPlayerDueling[DuelID] = 1;

  	g_DuelingID1 = playerid;
    g_DuelingID2 = DuelID;

	g_DuelInProgress = 1;

	return 1;
}

dcmd_duel(playerid, params[])
{
	if(params[0] == '\0' || !IsNumeric(params))
	    return SendUsage(playerid, "/duel [playerid]");

	if(g_HasInvitedToDuel[playerid] == 1)
		return SendError(playerid, "You already invited someone to a duel! (Type, /cduel to reset your invite)");

	new
		DuelID = strvalEx(params),
		pName[MAX_PLAYER_NAME],
		zName[MAX_PLAYER_NAME],
		tString[128];

	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
	GetPlayerName(DuelID, zName, MAX_PLAYER_NAME);

	if (!IsPlayerConnected(DuelID))
	    return SendError(playerid, "Player is not connected.");

 	if(	g_HasInvitedToDuel[DuelID] == 1)
 		return SendError(playerid, "That player is already invited to a duel!");

	if(	DuelID  == playerid)
 		return SendError(playerid, "You can not duel yourself!");

 	format(tString, sizeof(tString), "You invited %s (ID:%d) to a 1 on 1 duel, wait till %s accepts your invite.",zName, DuelID, zName);
 	SendClientMessage(playerid, COLOR_YELLOW, tString);

 	format(tString, sizeof(tString), "You got invited by %s (ID:%d) to a 1 on 1 duel, type /duelaccept [playerid] to accept and start the duel. ",pName, playerid);
 	SendClientMessage(DuelID, COLOR_YELLOW, tString);

 	g_GotInvitedToDuel[DuelID] = playerid;
	g_HasInvitedToDuel[playerid] = 1;

	return 1;
}

forward InitializeDuel(playerid);
public InitializeDuel(playerid)
{
    g_DuelTimer[playerid]  = SetTimerEx("DuelCountDown", 1000, 1, "i", playerid);

	SetPlayerHealth(playerid, 100);
	SetPlayerArmour(playerid, 100);

	//SetPlayerPos(playerid, X, Y, Z); // da1
	//SetPlayerFacingAngle(playerid, A);
    SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid, 0);
    g_DuelCountDown[playerid] = 11;

	return 1;
}

forward InitializeDuelEx(playerid);
public InitializeDuelEx(playerid)
{
    g_DuelTimer[playerid]  = SetTimerEx("DuelCountDown", 1000, 1, "i", playerid);

	SetPlayerHealth(playerid, 100);
	SetPlayerArmour(playerid, 100);

    //SetPlayerPos(playerid, X, Y, Z);
    //SetPlayerFacingAngle(playerid, A);
    SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid, 0);
    g_DuelCountDown[playerid] = 11;

	return 1;
}

forward DuelCountDown(playerid);
public DuelCountDown(playerid)
{
	new
		tString[128] ;

	g_DuelCountDown[playerid] --;

	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);

	format(tString, sizeof(tString), "~w~%d", g_DuelCountDown[playerid]);
	GameTextForPlayer(playerid, tString, 900, 3);

    if(g_DuelCountDown[playerid] == 0)
    {
        KillTimer(g_DuelTimer[playerid]);
        TogglePlayerControllable(playerid, 1);
        GameTextForPlayer(playerid,"~g~GO GO GO", 900, 3);
        return 1;
    }

	return 1;
}

strvalEx(xxx[])
{
	if(strlen(xxx) > 9)
	return 0;
	return strval(xxx);
}

IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return false;
	}
	return true;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new
	 	sString[128],
	   	pName[MAX_PLAYER_NAME],
	   	zName[MAX_PLAYER_NAME],
	   	Float:Health,
	   	Float:Armor;

	if(g_IsPlayerDueling[playerid] == 1 && g_IsPlayerDueling[killerid] == 1)
	{
		GetPlayerHealth(killerid, Health);
	  	GetPlayerArmour(killerid, Armor);

		GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
	  	GetPlayerName(killerid, zName, MAX_PLAYER_NAME);

		if(Health > 90.0 && Armor > 90.0)
	  	{
	    	format(sString, sizeof(sString),"(News) %s has \"OWNED\" %s in the duel and has %.2f health and %.2f armor left!", zName,pName,Health,Armor);
	      	SendClientMessageToAll(COLOR_ORANGE, sString);

			g_GotInvitedToDuel[playerid] = 0;g_HasInvitedToDuel[playerid] = 0;g_IsPlayerDueling[playerid]  = 0;
	   		g_GotInvitedToDuel[killerid] = 0;g_HasInvitedToDuel[killerid] = 0;g_IsPlayerDueling[killerid]  = 0;
	      	g_DuelInProgress = 0;
			return 1;
	   	}
	   	else
	   	{
    		format(sString, sizeof(sString),"(News) %s has won the duel from %s and has %.2f health and %.2f armor left!", zName,pName,Health,Armor);
	       	SendClientMessageToAll(COLOR_ORANGE, sString);

			g_GotInvitedToDuel[playerid] = 0;g_HasInvitedToDuel[playerid] = 0;g_IsPlayerDueling[playerid]  = 0;
	   		g_GotInvitedToDuel[killerid] = 0;g_HasInvitedToDuel[killerid] = 0;g_IsPlayerDueling[killerid]  = 0;
			g_DuelInProgress = 0;
			return 1;
	   }
	}
	return 1;
}