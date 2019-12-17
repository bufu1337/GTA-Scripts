#include <a_samp>
/*
**************************
Filtsript version v1.2a **
**************************
*/


forward StatsInfromation();

new kill[MAX_PLAYERS];
new Death[MAX_PLAYERS];

new Text:PlayerStats[MAX_PLAYERS];
new Text:Textdraw1;

public OnFilterScriptInit()
{
	print("*************************************");
	print("          Player Info               ");
	print("         Kills and Death             ");
	print("          By RenisiL                ");
	print("************************************");
	
	SetTimer("StatsInfromation",300,1);
 	for(new playerid = 0; playerid < MAX_PLAYERS; playerid++)
 	{
	    PlayerStats[playerid] = TextDrawCreate(231.000000,405.000000,"-");
	    Textdraw1 = TextDrawCreate(260.000000,391.000000,"STATS");
	    TextDrawUseBox(PlayerStats[playerid],1);
	    TextDrawBoxColor(PlayerStats[playerid],0xffffff33);
	    TextDrawTextSize(PlayerStats[playerid],389.000000,119.000000);
	    TextDrawAlignment(PlayerStats[playerid],0);
	    TextDrawAlignment(Textdraw1,0);
	    TextDrawBackgroundColor(PlayerStats[playerid],0x000000ff);
	    TextDrawBackgroundColor(Textdraw1,0xff000033);
	    TextDrawFont(PlayerStats[playerid],2);
	    TextDrawLetterSize(PlayerStats[playerid],0.399999,1.200000);
	    TextDrawFont(Textdraw1,2);
	    TextDrawLetterSize(Textdraw1,0.799999,1.300000);
	    TextDrawColor(PlayerStats[playerid],0xffffffff);
	    TextDrawColor(Textdraw1,0xffffffff);
	    TextDrawSetOutline(PlayerStats[playerid],1);
	    TextDrawSetOutline(Textdraw1,1);
	    TextDrawSetProportional(PlayerStats[playerid],1);
	    TextDrawSetProportional(Textdraw1,1);
	    TextDrawSetShadow(PlayerStats[playerid],1);
	    TextDrawSetShadow(Textdraw1,1);
	}
	return 1;
}

//______________________________________________________________________________
public OnFilterScriptExit()
{
    for(new i = 0;i < MAX_PLAYERS; i++)
    {
   		TextDrawHideForPlayer(i,PlayerStats[i]);
    }
	return 1;
}
//______________________________________________________________________________
public OnPlayerConnect(playerid)
{
////////////////////////////////////////////////////////////////////////////////
	kill[playerid] = 0;
	Death[playerid] = 0;
////////////////////////////////////////////////////////////////////////////////
	StatsInfromation();
////////////////////////////////////////////////////////////////////////////////
	TextDrawShowForPlayer(playerid,PlayerStats[playerid]);
	TextDrawShowForPlayer(playerid,Textdraw1);
////////////////////////////////////////////////////////////////////////////////
	SendClientMessage(playerid, 0xFF000096,"Your server uses RenisiL Kills nd Death stats filterscript version 4.5");
	return 1;
}
//______________________________________________________________________________
public OnPlayerDeath(playerid, killerid, reason)
{
	print("Loading you stats");
	kill[playerid]++;
	Death[killerid]++;
	return 1;
}
//______________________________________________________________________________
public StatsInfromation()
{
    new str[256];
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if (IsPlayerConnected(i))
	    {
	        format(str, sizeof(str), "Kill: %d - Death: %d" , kill[0], Death[0]);
	        TextDrawSetString(PlayerStats[i],str);
    	}
	}
	return 1;
}
//______________________________________________________________________________
//                            2009/2010 (c)
