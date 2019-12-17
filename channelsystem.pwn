/* ===[INCLUDES]=== */
#include <a_samp>

/* ===[DEFINES]=== */
#define DEFAULT_CHANNEL 0 //The channel the player isassigned to when they join the server

/* ===[COLOR]=== */
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_RED 0xFF0000AA

/* ===[VARIABLES]=== */
new gChannel[MAX_PLAYERS];

/* ===[CALLBACKS]=== */
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("Mikes channel script - Loaded");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	print("\n--------------------------------------");
	print("Mikes channel script - Unloaded");
	print("--------------------------------------\n");
	return 1;
}

public OnPlayerConnect(playerid)
{
	SetPlayerChannel(playerid,DEFAULT_CHANNEL);
	return 1;
}

public OnPlayerText(playerid, text[])
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(gChannel[i] == gChannel[playerid])
	    {
	        SendPlayerMessageToPlayer(i,playerid,text);
	    }
	}
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new idx;
	cmd = strtok(cmdtext, idx);
	new tmp[256];
	tmp = strtok(cmdtext, idx);
	if (!strcmp(cmd, "/channel", true))
	{
		new chan = strval(tmp);
		if(!strlen(tmp)) return SendClientMessage(playerid,COLOR_RED,"/Channel [0-199]");
		if(chan > 199) return SendClientMessage(playerid,COLOR_RED,"/Channel [0-199]");
		SetPlayerChannel(playerid,chan);
		new string[128];
		new name[24];
		GetPlayerName(playerid,name,sizeof(name));
		format(string, sizeof(string), "%s (ID:%d) changed his channel to %d!",name,playerid,chan);
		SendClientMessageToAll(COLOR_WHITE,string);
		return 1;
	}
	if (strcmp("/mychannel", cmd, true) == 0)
	{
		new string[128];
		format(string, sizeof(string), "Your Current Channel: %d",GetPlayerChannel(playerid));
		SendClientMessage(playerid,COLOR_WHITE,string);
		return 1;
	}
	return 0;
}

strtok(const string[], &index)
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

stock SetPlayerChannel(playerid,channel) gChannel[playerid] = channel;

stock SetAllChannel(channel)
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		gChannel[i] = channel;
	}
}

stock SetAdminsChannel(channel)
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerAdmin(i)) return gChannel[i] = channel;
	}
}

stock SetPlayersChannel(channel)
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerAdmin(i)) return gChannel[i] = channel;
	}
}

stock GetPlayerChannel(playerid) return gChannel[playerid];

stock SetChannelsByID()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		gChannel[i] = i;
	}
}

stock SendClientMessageToChannel(channel,color,text)
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(GetPlayerChannel(i) == channel)
		{
		    SendClientMessage(i,color,text);
		}
	}
}