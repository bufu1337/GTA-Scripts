dcmd_profile(playerid, text[])
{
	if(!ProfileAllowed){ SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Profile information is not allowed on this server."); return 1;}
	if(!strlen(text)){ SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct Usage: /profile [playerid]"); return 1;}
	if(!IsPlayerConnected(strval(text))){ SendClientMessage(playerid, COLOUR_RED, "DELTA: This player is not connected"); return 1;}
	new string[MAX_STRING], pname[MAX_PLAYER_NAME];
	GetPlayerName(strval(text), pname, sizeof(pname));
	format(string, sizeof(string), "%s's Profile:", pname);
	SendClientMessage(playerid, COLOUR_GREEN, string);
	format(string, sizeof(string), "Age: %s", Age[strval(text)]);
	SendClientMessage(playerid, COLOUR_YELLOW, string);
	format(string, sizeof(string), "Gender: %s", Gender[strval(text)]);
	SendClientMessage(playerid, COLOUR_YELLOW, string);
	format(string, sizeof(string), "State: %s", State[strval(text)]);
	SendClientMessage(playerid, COLOUR_YELLOW, string);
	format(string, sizeof(string), "Country: %s", Country[strval(text)]);
	SendClientMessage(playerid, COLOUR_YELLOW, string);
	format(string, sizeof(string), "Likes: %s", Likes[strval(text)]);
	SendClientMessage(playerid, COLOUR_YELLOW, string);
	format(string, sizeof(string), "Dislikes: %s", Dislikes[strval(text)]);
	SendClientMessage(playerid, COLOUR_YELLOW, string);
	format(string, sizeof(string), "Sport: %s", Sport[strval(text)]);
	SendClientMessage(playerid, COLOUR_YELLOW, string);
	format(string, sizeof(string), "Music: %s", Music[strval(text)]);
	SendClientMessage(playerid, COLOUR_YELLOW, string);
	format(string, sizeof(string), "More Info: %s", Moreinfo[strval(text)]);
	SendClientMessage(playerid, COLOUR_YELLOW, string);
	return 1;
}

dcmd_cprofile(playerid, text[])
{
	#pragma unused text
	if(!ProfileAllowed){ SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Profile information is not allowed on this server."); return 1;}
	SetPlayerPos(playerid,1497.803, -887.0979, 82.56055);
	TogglePlayerControllable(playerid, false);
	SetPlayerCameraPos(playerid,1497.803, -887.0979, 62.56055);
	SetPlayerCameraLookAt(playerid,1406.65, -795.7716,  82.2771);
	SendClientMessage(playerid, COLOUR_GREY, "__________________________________________________");
	SendClientMessage(playerid, COLOUR_GREY, "         Delta All-In-One profile wizard          ");
	SendClientMessage(playerid, COLOUR_GREY, "__________________________________________________");
	SendClientMessage(playerid, COLOUR_GREY, "   This wizard will help you to configure your    ");
	SendClientMessage(playerid, COLOUR_GREY, " Profile. If you dont want people to know certain ");
	SendClientMessage(playerid, COLOUR_GREY, "           information, just type N/A.            ");
	SendClientMessage(playerid, COLOUR_GREY, "__________________________________________________");
	ProfileContinue[playerid] = 2;
	GiveProfileOptions(playerid);
	return 1;
}