dcmd_dstats(playerid, text[])
{
	#pragma unused text
	new string[256];
	SendClientMessage(playerid, COLOUR_GREEN, "Delta All-In-One Server Statistics");
	format(string, sizeof(string), "Kills: %d", Kills);
	SendClientMessage(playerid, COLOUR_YELLOW, string);
	format(string, sizeof(string), "Deaths: %d", Deaths);
	SendClientMessage(playerid, COLOUR_YELLOW, string);
	format(string, sizeof(string), "Suicides: %d", Suicides);
	SendClientMessage(playerid, COLOUR_YELLOW, string);
	format(string, sizeof(string), "Player Counter: %d", Pjoined);
	SendClientMessage(playerid, COLOUR_YELLOW, string);
	format(string, sizeof(string), "Lol-O-Meter: %d Lols", Lols);
	SendClientMessage(playerid, COLOUR_YELLOW, string);
	return 1;
} 

dcmd_pstats(playerid, text[])
{
	if(!text[0])
	{
		SendClientMessage(playerid, COLOUR_WHITE, "Correct usage: /pstats [playerid]");
		return 1;
	}	
	if(!IsPlayerConnected(strval(text))) 
	{
		SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to view stats is not connected."); 
		return 1;
	}
	new string[256], pname[MAX_PLAYER_NAME];
	GetPlayerName(strval(text), pname, sizeof(pname));
	format(string, sizeof(string), "%s's Statistics");
	SendClientMessage(playerid, COLOUR_GREEN, string);
	format(string, sizeof(string), "Kills: %d", PKills[strval(text)]);
	SendClientMessage(playerid, COLOUR_YELLOW, string);
	format(string, sizeof(string), "Deaths: %d", PDeaths[strval(text)]);
	SendClientMessage(playerid, COLOUR_YELLOW, string);
	format(string, sizeof(string), "Suicides: %d", PSuicides[strval(text)]);
	SendClientMessage(playerid, COLOUR_YELLOW, string);
	format(string, sizeof(string), "Lol-O-Meter: %d Lols", PLols[strval(text)]);
	SendClientMessage(playerid, COLOUR_YELLOW, string);
	return 1;
}