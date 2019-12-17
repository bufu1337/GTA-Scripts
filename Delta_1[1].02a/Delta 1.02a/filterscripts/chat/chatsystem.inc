new messages_str[MAX_PLAYERS];
new messages_num[MAX_PLAYERS];
new spamwarn[MAX_PLAYERS];

public DeltaSpeech(playerid, text[])
{
	new string[256];
	new pname[256];	
	GetPlayerName(playerid, pname, sizeof(pname));
	format(string, sizeof(string), "%s: %s", pname, text);
	if(talking[playerid] == 1)
	{
		for(new i = 0; i <= MAX_PLAYERS; i++)
		{
			if(convo[playerid][i]==1)
			{
				SendClientMessage(i, COLOUR_YELLOW, string);
				return 1;
			}
		}
	}
	SendClientMessageToAll(COLOUR_WHITE, string);
	return 1;
}

public SpamCheckTimer()
{
	if(AntiSpam == 1)
	{	
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && !IsPlayerAdmin(i)) SpamCheck(i);
		}
	}
}

public SpamCheck(playerid)
{
	new playername[MAX_PLAYER_NAME];
   	new string[256];
   	GetPlayerName(playerid,playername,sizeof(playername));
   	if(messages_num[playerid]==5 && spamwarn[playerid] == 0) 
	{
      		SendClientMessage(playerid,COLOUR_RED,"DELTA: You will be kicked if you don't stop spamming the server");
      		spamwarn[playerid] = 1;
   	} 
	else if(messages_num[playerid]>=10) 
	{
  		format(string,sizeof(string),"DELTA: %s has been kicked (Spam)",playername);
      		printf(string);
      		SendClientMessageToAll(COLOUR_RED,string);
		Kicked[playerid] = 1;
		SetTimer("TKick", 500, 0);
   	}
}