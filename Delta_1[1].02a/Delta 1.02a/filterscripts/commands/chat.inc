
dcmd_convo(playerid, text[])
{
	new convoid[MAX_STRING], idx;
	convoid = strtok(text,idx);
	if(!strlen(convoid)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /convo [playerid]");
		return 1;
	}
	if(strval(convoid) == playerid) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You can't talk to yourself!"); return 1;}
	if(!IsPlayerConnected(strval(convoid))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to talk to is not connected."); return 1;}
	if(talking[strval(convoid)] == 1) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to talk to is already in a convo"); return 1;}
	SendClientMessage(playerid,COLOUR_GREY,"DELTA: You are now in the conversation. Type /endconvo to stop talking.");
	if(Ignore[strval(convoid)][playerid]==1) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to talk to has ignored you."); return 1;}
	convo[playerid][strval(convoid)] = 1;
	talking[playerid] = 1;
	new string[256], pname[256];
	GetPlayerName(strval(convoid), pname, sizeof(pname));
	format(string, sizeof(string), "You are now in a conversation with %s", pname);
	SendClientMessage(strval(convoid), COLOUR_GREEN, string);
	return 1;
}

dcmd_endconvo(playerid, text[])
{
	#pragma unused text
	new counter;
	for(new i = 0; i <= MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1 && convo[playerid][i] == 1)
		{
			new string[256];
			new pname[MAX_PLAYER_NAME];
			GetPlayerName(i, pname, sizeof(pname));
			convo[playerid][i] = 0;
			format(string, sizeof(string), "DELTA: Conversation ended with %s", pname);
			SendClientMessage(playerid, COLOUR_GREEN, string);
			talking[playerid] = 0;
			counter++;
		}
	}
	if(counter==0) SendClientMessage(playerid, COLOUR_RED, "You are not in a conversation with anyone!");
	return 1;
}

dcmd_me(playerid, text[])
{
	if(!text[0])
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /me [text]");
		return 1;
	}
	new string[256], pname[256];
	GetPlayerName(playerid, pname, sizeof(pname));
	format(string, sizeof(string), "***%s %s",pname, text);
	SendClientMessageToAll(COLOUR_LIGHTBLUE, string);
	return 1;
}

dcmd_dpm(playerid, text[])
{
	new pmid[MAX_STRING],  info[MAX_STRING], idx;
	pmid = strtok(text,idx);
	info = strtok(text,idx);
	if(!strlen(pmid) || !strlen(info)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /dpm [playerid] [text]");
		return 1;
	}
	if(strval(pmid) == playerid) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You can't pm yourself!"); return 1;}
	if(!IsPlayerConnected(strval(pmid))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to pm is not connected."); return 1;}
	if(Ignore[strval(pmid)][playerid]==1) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to pm has ignored you."); return 1;}
	new string[MAX_STRING], yname[MAX_STRING], pname[MAX_STRING];
	GetPlayerName(playerid, yname, sizeof(yname));
	GetPlayerName(strval(pmid), pname, sizeof(pname));
	if(strval(pmid) >= 9) format(string, sizeof(string), "DELTA: PM from %s: %s",yname,text[3]);
	else format(string, sizeof(string), "DELTA: PM from %s: %s",yname,text[2]);
	SendClientMessage(strval(pmid),COLOUR_LIGHTBLUE, string);
	format(string, sizeof(string), "DELTA: PM sent to %s", pname);
	SendClientMessage(strval(pmid),COLOUR_GREEN, string);
	return 1;	
}

dcmd_ignore(playerid, text[])
{
	if(!text[0])
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /ignore [playerid]");
		return 1;
	}
	if(strval(text) == playerid) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You can't ignore yourself!"); return 1;}
	if(!IsPlayerConnected(strval(text))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to ignore is not connected."); return 1;}
	if(Ignore[playerid][strval(text)]==1) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to ignore has been already ignored."); return 1;}
	Ignore[playerid][strval(text)] = 1;
	new string[256];
	format(string, sizeof(string), "DELTA: All PM's from %s will now be ignored");
	SendClientMessage(playerid, COLOUR_GREEN, string);
	return 1;
}

dcmd_unignore(playerid, text[])
{
	if(!text[0])
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /unignore [playerid]");
		return 1;
	}
	if(strval(text) == playerid) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You can't unignore yourself!"); return 1;}
	if(!IsPlayerConnected(strval(text))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to unignore is not connected."); return 1;}
	if(Ignore[playerid][strval(text)]==0) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to unignore hasn't been ignored at all."); return 1;}
	Ignore[playerid][strval(text)] = 0;
	new string[256];
	format(string, sizeof(string), "DELTA: All PM's from %s will no longer be ignored");
	SendClientMessage(playerid, COLOUR_GREEN, string);
	return 1;
}