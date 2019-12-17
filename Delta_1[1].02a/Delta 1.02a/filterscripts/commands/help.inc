/*
=====================================
 Help For Delta All-In-One
=====================================
*/
dcmd_dhelp(playerid, params[])
{
	#pragma unused params
	SendClientMessage(playerid, COLOUR_GREEN, "Welcome to Delta All-In-One Help");
	SendClientMessage(playerid, COLOUR_WHITE, "For a list of administration commands type /dahelp");
	SendClientMessage(playerid, COLOUR_WHITE, "For help on utilising the Delta All-In-One chat system use /dchelp");
	SendClientMessage(playerid, COLOUR_WHITE, "For help on creating or viewing a profile use /dphelp");
	SendClientMessage(playerid, COLOUR_WHITE, "For help on the installation of this script use /dihelp");
	SendClientMessage(playerid, COLOUR_WHITE, "For a list of credits use /dcredits");
	return 1;
}

dcmd_dahelp(playerid, params[])
{
	#pragma unused params
	if(!authenticated[playerid]){SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature!"); return 0;}
	SendClientMessage(playerid, COLOUR_GREEN, "Welcome to Delta All-In-One Administration Help");
	if(level[playerid] >= 1) SendClientMessage(playerid, COLOUR_WHITE, "Level 1: /admins, /report");
	if(level[playerid] >= 2) SendClientMessage(playerid, COLOUR_WHITE, "Level 2: /mute, /unmute, /killplayer, /amsg, /goto");
	if(level[playerid] >= 3) SendClientMessage(playerid, COLOUR_WHITE, "Level 3: /kick, /announce, /settime, /freeze, /unfreeze, /jail, /unjail");
	if(level[playerid] >= 4) SendClientMessage(playerid, COLOUR_WHITE, "Level 4: /ban, /givecash, /heal, /sethp, /giveweapon");
	if(level[playerid] >= 5) SendClientMessage(playerid, COLOUR_WHITE, "Level 5: /setlevel, /changepass, /spawnhp, /spoofpwn, /smsg, /endmode, /kickall, /banall");
	if(level[playerid] >= 5) SendClientMessage(playerid, COLOUR_WHITE, "               /togchat, /banclan");
	return 1;
}

dcmd_dchelp(playerid, params[])
{
	#pragma unused params
	if(!authenticated[playerid]){SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature!"); return 0;}
	SendClientMessage(playerid, COLOUR_GREEN, "Welcome to Delta All-In-One Chatsystem Help");
	SendClientMessage(playerid, COLOUR_WHITE, "To have a conversation with a player use /convo");
	SendClientMessage(playerid, COLOUR_WHITE, "To end a conversation with a player use /endconvo");
	SendClientMessage(playerid, COLOUR_WHITE, "To send a message to everyone to justify an action use /me");
	SendClientMessage(playerid, COLOUR_WHITE, "To send a private message use /dpm");
	return 1;
}

dcmd_dphelp(playerid, params[])
{
	#pragma unused params
	if(!authenticated[playerid]){SendClientMessage(playerid, COLOUR_RED, "You need to be logged in to use this feature!"); return 0;}
	SendClientMessage(playerid, COLOUR_GREEN, "Welcome to Delta All-In-One Profile Help");
	SendClientMessage(playerid, COLOUR_GREY, "Delta All-In-One saves a players information so others can read it e.g. MySpace");
	SendClientMessage(playerid, COLOUR_WHITE, "To view a player's profile use /profile");
	SendClientMessage(playerid, COLOUR_WHITE, "To edit your profile use /cprofile");
	return 1;
}

dcmd_dihelp(playerid, params[])
{
	#pragma unused params
	SendClientMessage(playerid, COLOUR_GREEN, "Welcome to Delta All-In-One Installation Help");
	SendClientMessage(playerid, COLOUR_GREY, "Delta All-In-One uses an ingame Installer to get configured");
	SendClientMessage(playerid, COLOUR_GREY, "In order to install / re-install the Delta All-In-One do the following:");
	SendClientMessage(playerid, COLOUR_GREY, "1. Edit the Delta CFG.cfg so Install equals 1.");
	SendClientMessage(playerid, COLOUR_GREY, "2. Log into RCON Ingame");
	SendClientMessage(playerid, COLOUR_GREY, "3. Type /install when the message it displayed.");
	return 1;
}

dcmd_dcredits(playerid, params[])
{
	#pragma unused params
	SendClientMessage(playerid, COLOUR_GREEN, "Cheaterwatch for hacker libraries and useful functions");
	SendClientMessage(playerid, COLOUR_GREEN, "Dracoblue for Dutils, Dini and Dudb");
	SendClientMessage(playerid, COLOUR_GREEN, "Sacky for SInterior, Playerban and Clanban stuff");
	SendClientMessage(playerid, COLOUR_GREEN, "SHAC for AntiSpam and AntiHealth Hack protection");
	SendClientMessage(playerid, COLOUR_GREEN, "Scarface for anti-driveby abuse");
	return 1;
}