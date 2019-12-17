/*
=====================================
 Admin Commands For Delta All-In-One
=====================================
*/

// Level 1 admin commands
dcmd_admins(playerid, params[])
{
	#pragma unused params
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	SendClientMessage(playerid, COLOUR_WHITE, "Online admins:");
	new AdminsOnline;
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			if(level[i] > 1)
			{
				new string[256];	
				new aname[256];
				GetPlayerName(i, aname, sizeof(aname));
				format(string, sizeof(string), "%s : Lv %d", aname, level[i]);
				SendClientMessage(playerid, COLOUR_GREEN, string);
				AdminsOnline++;
			}
		}
	}
	if(AdminsOnline == 0){ SendClientMessage(playerid, COLOUR_RED, "Currently no admins online."); return 1;}
	return 1;
}

dcmd_report(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	if(!text[0]) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "Correct usage: /report [text]");
		return 1;
	}
	new string[256], pname[256];
	GetPlayerName(playerid, pname, sizeof(pname));
	format(string, sizeof(string), "Report from %s(%d): %s",pname, playerid, text);
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			if(level[i] > 1)
			{
				SendClientMessage(i, COLOUR_YELLOW, string);
			}
		}
	}
	SendClientMessage(playerid, COLOUR_GREEN, "A message has been sent to the online admins");
	return 1;
}
// Level 2 admin commands
dcmd_mute(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	new idx;
	new muteid[MAX_STRING],  reason[MAX_STRING];
	muteid = strtok(text,idx);
	reason = strtok(text,idx);
	if(level[playerid] < 2) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Your admin level is too low to use this command"); return 1;}
	if(!strlen(muteid) || !strlen(reason)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /mute [playerid] [reason]");
		return 1;
	}
	if(strval(muteid) == playerid) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You can't mute yourself!"); return 1;}
	if(!IsPlayerConnected(strval(muteid))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to mute is not connected."); return 1;}
	if(mute[strval(muteid)] == 1) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to mute is already muted."); return 1;}
	if(level[strval(muteid)] > level[playerid]) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You cannot mute admins of a higher level than you."); return 1;}
	new string[256];
	new aname[256];
	new mname[256];
	GetPlayerName(playerid, aname, sizeof(aname));
	GetPlayerName(strval(muteid), mname, sizeof(mname));
	if(strval(muteid) >= 9) format(string, sizeof(string), "DELTA: Admin: %s has muted %s (%s)",aname,mname,text[3]);
	else format(string, sizeof(string), "DELTA: Admin: %s has muted %s (%s)",aname,mname,text[2]);
	SendClientMessageToAll(COLOUR_RED, string);
	print(string);
	mute[strval(muteid)]=1;
	dUserSetINT(mname).("Mute",1);
	return 1;	
}
dcmd_unmute(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	new idx;
	new muteid[MAX_STRING],  reason[MAX_STRING];
	muteid = strtok(text,idx);
	reason = strtok(text,idx);
	if(level[playerid] < 2) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Your admin level is too low to use this command"); return 1;}
	if(!strlen(muteid)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /unmute [playerid] [reason]");
		return 1;
	}
	if(!strlen(reason)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /unmute [playerid] [reason]");
		return 1;
	}
	if(!IsPlayerConnected(strval(muteid))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to unmute is not connected."); return 1;}
	if(mute[strval(muteid)] == 0) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to unmute is not muted."); return 1;}
	if(level[strval(muteid)] > level[playerid]) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You cannot unmute admins of a higher level than you."); return 1;}
	new string[256];
	new aname[256];
	new mname[256];
	GetPlayerName(playerid, aname, sizeof(aname));
	GetPlayerName(strval(muteid), mname, sizeof(mname));
	if(strval(muteid) >= 9) format(string, sizeof(string), "DELTA: Admin: %s has unmuted %s (%s)",aname,mname,text[3]);
	else format(string, sizeof(string), "DELTA: Admin: %s has unmuted %s (%s)",aname,mname,text[2]);
	SendClientMessageToAll(COLOUR_RED, string);
	print(string);
	mute[strval(muteid)]=0;
	dUserSetINT(mname).("Mute",0);
	return 1;		
}
dcmd_killplayer(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	new idx;
	new killid[MAX_STRING],  reason[MAX_STRING];
	killid = strtok(text,idx);
	reason = strtok(text,idx);
	if(level[playerid] < 2) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Your admin level is too low to use this command"); return 1;}
	if(!strlen(killid)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /killplayer [playerid] [reason]");
		return 1;
	}
	if(!strlen(reason)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /killplayer [playerid] [reason]");
		return 1;
	}
	if(strval(killid) == playerid) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You can't kill yourself!"); return 1;}
	if(!IsPlayerConnected(strval(killid))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to kill is not connected."); 	return 1;}
	if(level[strval(killid)] > level[playerid]) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You cannot kill admins of a higher level than you."); return 1;}
	new string[256];
	new aname[256];
	new kname[256];
	GetPlayerName(playerid, aname, sizeof(aname));
	GetPlayerName(strval(killid), kname, sizeof(kname));
	if(strval(killid) >= 9) format(string, sizeof(string), "DELTA: Admin: %s has killed %s (%s)",aname,kname,text[3]);
	else format(string, sizeof(string), "DELTA: Admin: %s has killed %s (%s)",aname,kname,text[2]);
	SendClientMessageToAll(COLOUR_RED, string);
	print(string);
	SetPlayerHealth(strval(killid), 0.0);
	return 1;	
}
dcmd_amsg(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	if(level[playerid] < 2) { SendClientMessage(playerid, COLOUR_RED, "Your admin level is too low to use this command"); return 1;}
	if(!text[0]) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "Correct usage: /amsg [text]");
		return 1;
	}
	new string[MAX_STRING];
	format(string, sizeof(string), "ADMIN: %s", text);
	SendClientMessageToAll(COLOUR_GREY, string);
	print(string);
	return 1;
}

dcmd_achat(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	if(level[playerid] < 2) { SendClientMessage(playerid, COLOUR_RED, "Your admin level is too low to use this command"); return 1;}
	if(!text[0]) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "Correct usage: /achat [text]");
		return 1;
	}
	new string[MAX_STRING], aname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, aname, sizeof(aname));
	format(string, sizeof(string), "%s Admin chat: %s", aname,text);
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			if(level[i] > 2)
			{
				SendClientMessage(i,COLOUR_YELLOW, string);
			}
		}
	}
	print(string);
	return 1;
}

dcmd_goto(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	if(level[playerid] < 2) { SendClientMessage(playerid, COLOUR_RED, "Your admin level is too low to use this command"); return 1;}
	if(!text[0]) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "Correct usage: /goto [playerid]");
		return 1;
	}
	if(strval(text) == playerid) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You can't teleport to yourself!"); return 1;}
	if(!IsPlayerConnected(strval(text))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to teleport to is not connected."); 	return 1;}
	if(IsPlayerInAnyInterior(strval(text)) || !IsPlayerInAnyVehicle(playerid))
	{
		new Float:x, Float:y, Float:z, Float:a, int;
		int = GetPlayerInteriorID(playerid);
		GetPlayerPos(strval(text), x,y,z);
		GetPlayerFacingAngle(strval(text), a);
		SetPlayerInterior(playerid, int);
		SetPlayerPos(playerid, x + 1, y + 1, z);
		SetPlayerFacingAngle(playerid, a);
		return 1;		
	}
	if(IsPlayerInAnyVehicle(playerid))
	{
		new Float:x, Float:y, Float:z, Float:a, vid;
		GetPlayerPos(strval(text), x,y,z);
		GetPlayerFacingAngle(strval(text), a);
		vid = GetPlayerVehicleID(playerid);
		SetVehiclePos(vid, x + 5,y + 5,z + 5);
		SetPlayerFacingAngle(vid, a);
		return 1;
	}
	return 1;
}

dcmd_slap(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	if(level[playerid] < 2) { SendClientMessage(playerid, COLOUR_RED, "Your admin level is too low to use this command"); return 1;}
	if(!text[0]) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "Correct usage: /slap [playerid]");
		return 1;
	}
	if(strval(text) == playerid) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You can't slap to yourself!"); return 1;}
	if(!IsPlayerConnected(strval(text))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to slap to is not connected.");	return 1;}
	new aname[MAX_PLAYER_NAME], pname[MAX_PLAYER_NAME], string[256], Float:health;
	GetPlayerName(playerid, aname, sizeof(aname));
	GetPlayerName(strval(text), pname, sizeof(pname));
	GetPlayerHealth(strval(text), health);
	SetPlayerHealth(strval(text), health - 25);
	format(string, sizeof(string), "DELTA: Admin %s has slapped %s!",aname, pname);
	SendClientMessageToAll(COLOUR_LIGHTBLUE, string);
	return 1;
}
// Level 3 admin commands
dcmd_kick(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	new idx;
	new kickid[MAX_STRING],  reason[MAX_STRING];
	kickid = strtok(text,idx);
	reason = strtok(text,idx);
	if(level[playerid] < 2) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Your admin level is too low to use this command"); return 1;}
	if(!strlen(kickid)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /kick [playerid] [reason]");
		return 1;
	}
	if(!strlen(reason)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /kick [playerid] [reason]");
		return 1;
	}
	if(strval(kickid) == playerid) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You can't kick yourself!"); return 1;}
	if(!IsPlayerConnected(strval(kickid))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to kick is not connected."); return 1;}
	if(level[strval(kickid)] > level[playerid]) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You cannot kick admins of a higher level than you."); return 1;}
	new string[256];
	new aname[256];
	new kname[256];
	GetPlayerName(playerid, aname, sizeof(aname));
	GetPlayerName(strval(kickid), kname, sizeof(kname));
	if(strval(kickid) >= 9) format(string, sizeof(string), "DELTA: Admin: %s has kicked %s (%s)",aname,kname,text[3]);
	else format(string, sizeof(string), "DELTA: Admin: %s has kicked %s (%s)",aname,kname,text[2]);
	SendClientMessageToAll(COLOUR_RED, string);
	print(string);
	Kicked[strval(kickid)]=1;
	SetTimer("TKick", 500, 0);
	return 1;	
}
dcmd_announce(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	if(level[playerid] < 3) { SendClientMessage(playerid, COLOUR_RED, "Your admin level is too low to use this command"); return 1;}
	if(!text[0]) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "Correct usage: /announce [text]");
		return 1;
	}
	GameTextForAll(text, 5000, 5);
	new aname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, aname, sizeof(aname));
	printf("DELTA: Admin %s has announced %s on the server", aname, text);
	return 1;
}
dcmd_settime(playerid, params[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	if(level[playerid] < 3) { SendClientMessage(playerid, COLOUR_RED, "Your admin level is too low to use this command"); return 1;}
	new ntime, idx;
	if(!params[0]) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "Correct usage: /settime [hour]");
		return 1;
	}
	ntime = strval(strtok(params,idx));
	if(ntime < 24 && ntime >= 0) 
	{
		new string[256], aname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, aname, sizeof(aname));
		SetWorldTime(ntime);
		format(string, sizeof(string), "DELTA: Admin %s has changed the time (%d)", aname, ntime);
		SendClientMessageToAll(COLOUR_YELLOW, string);
		print(string);
	}
	else SendClientMessage(playerid, COLOUR_RED, "You must choose a number between 0 to 23.");
	return 1;
}

dcmd_freeze(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	new idx;
	new freezeid[MAX_STRING],  reason[MAX_STRING];
	freezeid = strtok(text,idx);
	reason = strtok(text,idx);
	if(level[playerid] < 3) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Your admin level is too low to use this command"); return 1;}
	if(!strlen(freezeid) || !strlen(reason)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /freeze [playerid] [reason]");
		return 1;
	}
	if(strval(freezeid) == playerid) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You can't freeze yourself!"); return 1;}
	if(!IsPlayerConnected(strval(freezeid))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to freeze is not connected."); return 1;}
	if(level[strval(freezeid)] > level[playerid]) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You cannot freeze admins of a higher level than you."); return 1;}
	new string[MAX_STRING], aname[MAX_STRING], fname[MAX_STRING];
	GetPlayerName(playerid, aname, sizeof(aname));
	GetPlayerName(strval(freezeid), fname, sizeof(fname));
	if(strval(freezeid) >= 9) format(string, sizeof(string), "DELTA: Admin: %s has frozen %s (%s)",aname,fname,text[3]);
	else format(string, sizeof(string), "DELTA: Admin: %s has frozen %s (%s)",aname,fname,text[2]);
	SendClientMessageToAll(COLOUR_RED, string);
	print(string);
	TogglePlayerControllable(strval(freezeid), 0);
	return 1;	
}

dcmd_unfreeze(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	new idx;
	new freezeid[MAX_STRING],  reason[MAX_STRING];
	freezeid = strtok(text,idx);
	reason = strtok(text,idx);
	if(level[playerid] < 3) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Your admin level is too low to use this command"); return 1;}
	if(!strlen(freezeid) || !strlen(reason)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /unfreeze [playerid] [reason]");
		return 1;
	}
	if(!IsPlayerConnected(strval(freezeid))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to unfreeze is not connected."); return 1;}
	if(level[strval(freezeid)] > level[playerid]) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You cannot unfreeze admins of a higher level than you."); return 1;}
	new string[MAX_STRING], aname[MAX_STRING], fname[MAX_STRING];
	GetPlayerName(playerid, aname, sizeof(aname));
	GetPlayerName(strval(freezeid), fname, sizeof(fname));
	if(strval(freezeid) >= 9) format(string, sizeof(string), "DELTA: Admin: %s has unfrozen %s (%s)",aname,fname,text[3]);
	else format(string, sizeof(string), "DELTA: Admin: %s has unfrozen %s (%s)",aname,fname,text[2]);
	SendClientMessageToAll(COLOUR_RED, string);
	print(string);
	TogglePlayerControllable(strval(freezeid), 1);
	return 1;	
}

dcmd_jail(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	new idx;
	new jailid[MAX_STRING],  reason[MAX_STRING];
	jailid = strtok(text,idx);
	reason = strtok(text,idx);
	if(level[playerid] < 3) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Your admin level is too low to use this command"); return 1;}
	if(!strlen(jailid) || !strlen(reason)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /jail [playerid] [reason]");
		return 1;
	}
	if(strval(jailid) == playerid) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You can't jail yourself!"); return 1;}
	if(!IsPlayerConnected(strval(jailid))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to jail is not connected."); return 1;}
	if(level[strval(jailid)] > level[playerid]) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You cannot jail admins of a higher level than you."); return 1;}
	new string[MAX_STRING], aname[MAX_STRING], jname[MAX_STRING];
	GetPlayerName(playerid, aname, sizeof(aname));
	GetPlayerName(strval(jailid), jname, sizeof(jname));
	if(strval(jailid) >= 9) format(string, sizeof(string), "DELTA: Admin: %s has jailed %s (%s)",aname,jname,text[3]);
	else format(string, sizeof(string), "DELTA: Admin: %s has jailed %s (%s)",aname,jname,text[2]);
	SendClientMessageToAll(COLOUR_RED, string);
	print(string);
	SetPlayerInterior(strval(jailid),3);
	SetPlayerPos(strval(jailid),198.3797,160.8905,1003.0300);
	SetPlayerFacingAngle(strval(jailid),177.0350);
	SetCameraBehindPlayer(strval(jailid));
	jail[strval(jailid)]=1;
	dUserSetINT(jname).("Jail",1);
	return 1;	
}

dcmd_unjail(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	new idx;
	new jailid[MAX_STRING],  reason[MAX_STRING];
	jailid = strtok(text,idx);
	reason = strtok(text,idx);
	if(level[playerid] < 3) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Your admin level is too low to use this command"); return 1;}
	if(!strlen(jailid) || !strlen(reason)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /unjail [playerid] [reason]");
		return 1;
	}
	if(!IsPlayerConnected(strval(jailid))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to unjail is not connected."); return 1;}
	if(level[strval(jailid)] > level[playerid]) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You cannot unjail admins of a higher level than you."); return 1;}
	new string[MAX_STRING], aname[MAX_STRING], jname[MAX_STRING];
	GetPlayerName(playerid, aname, sizeof(aname));
	GetPlayerName(strval(jailid), jname, sizeof(jname));
	if(strval(jailid) >= 9) format(string, sizeof(string), "DELTA: Admin: %s has unjailed %s (%s)",aname,jname,text[3]);
	else format(string, sizeof(string), "DELTA: Admin: %s has unjailed %s (%s)",aname,jname,text[2]);
	SendClientMessageToAll(COLOUR_RED, string);
	print(string);
	SetPlayerHealth(strval(jailid), 0.0);
	jail[strval(jailid)]=0;
	dUserSetINT(jname).("Jail",0);
	return 1;
}

// Level 4 admin commands
dcmd_ban(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	new idx;
	new banid[MAX_STRING],  reason[MAX_STRING];
	banid = strtok(text,idx);
	reason = strtok(text,idx);
	if(level[playerid] < 4) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Your admin level is too low to use this command"); return 1;}
	if(!strlen(banid)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /ban [playerid] [reason]");
		return 1;
	}
	if(!strlen(reason)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /ban [playerid] [reason]");
		return 1;
	}
	if(strval(banid) == playerid) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You can't ban yourself!"); return 1;}
	if(!IsPlayerConnected(strval(banid))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to ban is not connected."); return 1;}
	if(level[strval(banid)] > level[playerid]) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You cannot ban admins of a higher level than you."); return 1;}
	new string[256];
	new aname[256];
	new bname[256];
	GetPlayerName(playerid, aname, sizeof(aname));
	GetPlayerName(strval(banid), bname, sizeof(bname));
	if(strval(banid) >= 9) format(string, sizeof(string), "DELTA: Admin: %s has banned %s (%s)",aname,bname,text[3]);
	else format(string, sizeof(string), "DELTA: Admin: %s has banned %s (%s)",aname,bname,text[2]);
	SendClientMessageToAll(COLOUR_RED, string);
	print(string);
	if(dini_Exists(PLAYERBAN_FILE))
	{
		new temp[256], playername[MAX_PLAYER_NAME];
		GetPlayerName(strval(banid), playername, sizeof(playername));
		new File:fhandle;
		fhandle = fopen(PLAYERBAN_FILE,io_append);
		format(temp,sizeof(temp),"%s",playername);
		fwrite(fhandle,temp);
		fclose(fhandle);
	}
	Banned[strval(banid)]=1;
	SetTimer("TBan", 500, 0);
	return 1;	
}

dcmd_givecash(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	new idx;
	new cashid[MAX_STRING],  amount[MAX_STRING];
	cashid = strtok(text,idx);
	amount = strtok(text,idx);
	if(level[playerid] < 4) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Your admin level is too low to use this command"); return 1;}
	if(!strlen(cashid) || !strlen(amount)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /givecash [playerid] [amount]");
		return 1;
	}	
	if(!IsPlayerConnected(strval(cashid))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to give cash is not connected."); return 1;}
	new string[256];
	new aname[256];
	new cname[256];
	GetPlayerName(playerid, aname, sizeof(aname));
	GetPlayerName(strval(cashid), cname, sizeof(cname));
	format(string, sizeof(string), "DELTA: Admin: %s has given %s cash (%s)",aname,cname,amount);
	SendClientMessageToAll(COLOUR_RED, string);
	print(string);
	GivePlayerMoney(strval(cashid), strval(amount));
	return 1;	
}

dcmd_heal(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	new hpid[MAX_STRING], idx;
	hpid = strtok(text,idx);
	if(level[playerid] < 4) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Your admin level is too low to use this command"); return 1;}
	if(!strlen(hpid)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /heal [playerid]");
		return 1;
	}	
	if(!IsPlayerConnected(strval(hpid))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to heal is not connected."); return 1;}
	new string[256],aname[256],hname[256];
	GetPlayerName(playerid, aname, sizeof(aname));
	GetPlayerName(strval(hpid), hname, sizeof(hname));
	format(string, sizeof(string), "DELTA: Admin: %s has healed %s.",aname,hname);
	SendClientMessageToAll(COLOUR_RED, string);
	print(string);
	SetPlayerHealth(strval(hpid), 100.0);
	return 1;
}

dcmd_sethp(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	new hpid[MAX_STRING], amount[MAX_STRING],idx;
	hpid = strtok(text,idx);
	amount = strtok(text,idx);
	if(level[playerid] < 4) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Your admin level is too low to use this command"); return 1;}
	if(!strlen(hpid) || !strlen(amount)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /sethp [playerid] [hp]");
		return 1;
	}	
	if(!IsPlayerConnected(strval(hpid))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to sethp is not connected."); return 1;}
	if(level[strval(hpid)] > level[playerid]) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You cannot sethp an admin of a higher level than you."); return 1;}
	if(strval(amount) >= 0 && strval(amount) <= 100)SetPlayerHealth(strval(hpid), strval(amount));
	else { SendClientMessage(playerid,COLOUR_RED,"DELTA: You can't set a players hp below 0 or over 100."); return 1;}
	new string[256],aname[256],hname[256];
	GetPlayerName(playerid, aname, sizeof(aname));
	GetPlayerName(strval(hpid), hname, sizeof(hname));
	format(string, sizeof(string), "DELTA: Admin: %s has changed %s hp (%d hp).",aname,hname,strval(amount));
	SendClientMessageToAll(COLOUR_RED, string);
	print(string);
	return 1;
}

dcmd_giveweapon(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	new idx;
	new player[MAX_STRING], weaponid [MAX_STRING],ammo[MAX_STRING];
	player = strtok(text,idx);
	weaponid = strtok(text,idx);
	ammo = strtok(text,idx);
	if(level[playerid] < 4) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Your admin level is too low to use this command"); return 1;}
	if(!strlen(player) || !strlen(weaponid) || !strlen(ammo)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /giveweapon [playerid] [weaponid] [ammo]");
		return 1;
	}	
	if(!IsPlayerConnected(strval(player))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to give a weapon to is not connected."); return 1;}
	new string[256];
	new aname[256];
	new wname[256];
	new weapon[256];
	GetPlayerName(playerid, aname, sizeof(aname));
	GetPlayerName(strval(player), wname, sizeof(wname));
	GetWeaponName(strval(weaponid), weapon, sizeof(weapon));
	format(string, sizeof(string), "DELTA: Admin: %s has given %s a weapon (%s, AMMO: %d)",aname,wname,weapon,strval(ammo));
	SendClientMessageToAll(COLOUR_RED, string);
	print(string);
	GivePlayerWeapon(strval(player), strval(weaponid), strval(ammo));
	return 1;	
}

dcmd_slapall(playerid, text[])
{
	#pragma unused text
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	if(level[playerid] < 4) { SendClientMessage(playerid, COLOUR_RED, "Your admin level is too low to use this command"); return 1;}
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			new Float:health;
			GetPlayerHealth(i, health);
			SetPlayerHealth(i, health - 25);
		}
	}
	new aname[MAX_PLAYER_NAME], string[256];
	GetPlayerName(playerid, aname, sizeof(aname));
	format(string, sizeof(string), "DELTA: Admin %s has slapped everyone on the server!",aname);
	SendClientMessageToAll(COLOUR_LIGHTBLUE, string);
	return 1;
}

// Level 5 admin commands
dcmd_setlevel(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	new idx;
	new levelid[MAX_STRING], amount;
	levelid = strtok(text,idx);
	amount = strval(strtok(text,idx));
	if(level[playerid] < 5) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Your admin level is too low to use this command"); return 1;}
	if(!strlen(levelid) || !amount) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /setlevel [playerid] [amount]");
		return 1;
	}
	if(strval(levelid) == playerid) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You can't set your own level!"); return 1;}
	if(!IsPlayerConnected(strval(levelid))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to change level is not connected."); return 1;}
	new aname[MAX_STRING], lname[MAX_STRING], string[MAX_STRING];
	GetPlayerName(playerid, aname, sizeof(aname));
	GetPlayerName(strval(levelid), lname, sizeof(lname));
	format(string, sizeof(string), "DELTA: Admin %s has changed %s's level (Lv %d)", aname, lname, amount);
	SendClientMessageToAll(COLOUR_GREEN, string);
	print(string);
	dUserSetINT(lname).("Level", amount);
	level[strval(levelid)] = amount;
	return 1;
}

dcmd_changepass(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	new idx;
	new passid[MAX_STRING], newpass[MAX_STRING];
	passid = strtok(text,idx);
	newpass = strtok(text,idx);
	if(level[playerid] < 5) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Your admin level is too low to use this command"); return 1;}
	if(!strlen(passid) || !strlen(newpass)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /changepass [playerid] [newpass]");
		return 1;
	}
	if(!IsPlayerConnected(strval(passid))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to change password for is not connected.");return 1;}
	new pname[MAX_STRING],aname[MAX_STRING], string[MAX_STRING], string2[MAX_STRING];
	GetPlayerName(strval(passid), pname, sizeof(pname));
	GetPlayerName(playerid, aname, sizeof(aname));
	format(string, sizeof(string), "DELTA: %s's password has been successfully changed!", pname);
	SendClientMessage(playerid, COLOUR_GREEN, string);
	format(string2, sizeof(string2), "DELTA: Admin %s has changed your password to %s.", aname, newpass);
	SendClientMessage(strval(passid), COLOUR_YELLOW, string2);
	dUserSetINT(pname).("password_hash",udb_hash(newpass));
	return 1;
}

dcmd_spawnhp(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	new idx;
	new hpid[MAX_STRING],  amount;
	hpid = strtok(text,idx);
	amount = strval(strtok(text,idx));
	if(level[playerid] < 5) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Your admin level is too low to use this command"); return 1;}
	if(!strlen(hpid) || !amount) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /spawnhp [playerid] [amount]");
		return 1;
	}	
	if(amount >= 101 || amount <= 0) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Please specify a number between 0 and 100"); return 1;}
	if(!IsPlayerConnected(strval(hpid))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to set spawn health is not connected."); return 1;}
	new string[256];
	new aname[256];
	new hname[256];
	GetPlayerName(playerid, aname, sizeof(aname));
	GetPlayerName(strval(hpid), hname, sizeof(hname));
	format(string, sizeof(string), "DELTA: Admin: %s has set %s spawn health (%d)",aname,hname,amount);
	SendClientMessageToAll(COLOUR_RED, string);
	print(string);
	hp[strval(hpid)] = amount;
	dUserSetFLOAT(hname).("Health",amount);
	return 1;
}

dcmd_spoofpwn(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	new idx;
	new spoofid[MAX_STRING];
	spoofid = strtok(text,idx);
	if(level[playerid] < 5) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Your admin level is too low to use this command"); return 1;}
	if(!strlen(spoofid)) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "DELTA: Correct usage: /spoofpwn [playerid]");
			if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}return 1;
	}
	if(strval(spoofid) == playerid) { SendClientMessage(playerid,COLOUR_RED,"DELTA: You can't pwn yourself!"); return 1;}
	if(!IsPlayerConnected(strval(spoofid))) { SendClientMessage(playerid,COLOUR_RED,"DELTA: The player you are trying to pwn is not connected."); return 1;}
	SendDeathMessage(strval(spoofid), playerid, 0);
	SendDeathMessage(strval(spoofid), playerid, 8);
	SendDeathMessage(strval(spoofid), playerid, 24);
	SendDeathMessage(strval(spoofid), playerid, 26);
	SendDeathMessage(strval(spoofid), playerid, 38);
	return 1;
}

dcmd_smsg(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	if(level[playerid] < 5) { SendClientMessage(playerid, COLOUR_RED, "Your admin level is too low to use this command"); return 1;}
	if(!text[0]) 
	{
		SendClientMessage(playerid, COLOUR_WHITE, "Correct usage: /smsg [text]");
		return 1;
	}
	new string[MAX_STRING];
	format(string, sizeof(string), "SERVER: %s", text);
	SendClientMessageToAll(COLOUR_GREY, string);
	print(string);
	return 1;
}

dcmd_endmode(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	#pragma unused text
	if(level[playerid] < 5) { SendClientMessage(playerid, COLOUR_RED, "Your admin level is too low to use this command"); return 1;}
	new string[MAX_STRING], aname[MAX_STRING];
	GetPlayerName(playerid, aname, sizeof(aname));
	format(string, sizeof(string), "DELTA: Admin %s has ended the gamemode!", aname);
	SendClientMessageToAll(COLOUR_YELLOW, string);
	print(string);
	GameModeExit();
	return 1;
}

dcmd_kickall(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	if(!text[0])
	{
		SendClientMessage(playerid,COLOUR_WHITE,"USAGE: /kickall [reason]");
		return 1;
	}
	#pragma unused text
	if(level[playerid] < 5) { SendClientMessage(playerid, COLOUR_RED, "Your admin level is too low to use this command"); return 1;}
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			Kicked[i] = 1;
		}
	}
	new string[MAX_STRING], aname[MAX_STRING];
	GetPlayerName(playerid, aname, sizeof(aname));
	format(string, sizeof(string), "DELTA: Admin %s has kicked everyone on the server (%s)", aname, text);
	SendClientMessageToAll(COLOUR_RED, string);
	print(string);
	SetTimer("TKick", 500, 0);
	return 1;
}

dcmd_banall(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	if(!text[0])
	{
		SendClientMessage(playerid,COLOUR_WHITE,"USAGE: /banall [reason]");
		return 1;
	}
	#pragma unused text
	if(level[playerid] < 5) { SendClientMessage(playerid, COLOUR_RED, "Your admin level is too low to use this command"); return 1;}
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			Banned[i] = 1;
			if(dini_Exists(PLAYERBAN_FILE))
			{
				new temp[256], playername[MAX_PLAYER_NAME];
				GetPlayerName(i, playername, sizeof(playername));
				new File:fhandle;
				fhandle = fopen(PLAYERBAN_FILE,io_append);
				format(temp,sizeof(temp),"%s",playername);
				fwrite(fhandle,temp);
				fclose(fhandle);
			}
		}
	}
	new string[MAX_STRING], aname[MAX_STRING];
	GetPlayerName(playerid, aname, sizeof(aname));
	format(string, sizeof(string), "DELTA: Admin %s has banned everyone on the server (%s)", aname, text);
	SendClientMessageToAll(COLOUR_RED, string);
	print(string);
	SetTimer("TBan", 500, 0);
	return 1;
}

dcmd_togchat(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	if(level[playerid] < 5) { SendClientMessage(playerid, COLOUR_RED, "Your admin level is too low to use this command"); return 1;}
	if(!text[0]) { SendClientMessage(playerid, COLOUR_RED, "DELTA: Correct Usage: /togchat [reason]"); return 1;}
	new string[MAX_STRING], aname[MAX_STRING];
	GetPlayerName(playerid, aname, sizeof(aname));
	switch(chat)
	{
		case 0:
		{
			format(string, sizeof(string), "DELTA: Admin %s has turned chat on (%s)", aname, text); 
			chat = 1;
		}
		case 1:
		{
			format(string, sizeof(string), "DELTA: Admin %s has turned chat off (%s)", aname, text); 
			chat = 0;
		}
	}
	SendClientMessageToAll(COLOUR_RED, string);
	print(string);
	return 1;
}

dcmd_banclan(playerid, text[])
{
	if(authenticated[playerid]==0) 
	{ 
		SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature."); 
		return 1;
	}
	if(level[playerid] < 5) { SendClientMessage(playerid, COLOUR_RED, "Your admin level is too low to use this command"); return 1;}
	if(!text[0])
	{
		SendClientMessage(playerid,COLOUR_WHITE,"USAGE: /banclan [clan]");
		return 1;
	}
	if(dini_Exists(CLANBAN_FILE))
	{
		new File:fhandle;
		new string[256], aname[MAX_PLAYER_NAME], temp[256];
		fhandle = fopen(CLANBAN_FILE,io_append);
		format(temp,sizeof(temp),"%s",text);
		fwrite(fhandle,temp);
		fclose(fhandle);
		format(string,sizeof(string),"DELTA: You just banned the clan %s",text);
		SendClientMessage(playerid,COLOUR_RED,string);
		printf("%s has banned the clan %s", aname, text);
	}
	return 1;
}
