/*
					********************************
						SFS - Simple Friend Sys.
					********************************
Descrição:
	Lets you interact with friends from a server.
Versão:
	1.1
Developer:
	Luke "Larceny" G.
	"Lós" .
ChangeLOG:
	04/10/2011:
		Group chat.
	17/09/2011:
		First release.
Very thanks to:
	ZeeX   			- ZCMD Command Processor.
	Y_Less 			- Efficient and Powerful sscanf & foreach.
	Double-O-Seven  - DOF2 Fast INI file system.
	SA-MP Team		- For All.
*/

#define FILTERSCRIPT
#define AMIGODIALOG 9876
#define MESGEDIALOG 9877

#include <a_samp>
#include <zcmd>
#include <DOF2>
#include <sscanf2>
#include <foreach>

new Text:BackGround;
new Text:TextString[MAX_PLAYERS] = {Text:INVALID_TEXT_DRAW, ...};
new Text:ListString[MAX_PLAYERS] = {Text:INVALID_TEXT_DRAW, ...};

new StringTimer[MAX_PLAYERS];
new FriendTimer[MAX_PLAYERS];

forward HideMessageBoxForPlayer(playerid);
forward HideFriendBoxForPlayer(playerid);
forward SetMessageBoxForPlayer(playerid, string[]);
forward SetFriendBoxForPlayer(playerid, string[]);

stock GetPlayerNameEx(playerid)
{
    new string[MAX_PLAYER_NAME];
    GetPlayerName(playerid, string, MAX_PLAYER_NAME);
    return string;
}

stock GetPlayerNameIns(playerid)
{
    new string[MAX_PLAYER_NAME];
    GetPlayerName(playerid, string, MAX_PLAYER_NAME);
	new stringLength = strlen(string);
	strins(string, "~n~", stringLength);
    return string;
}

public OnFilterScriptInit()
{
	print("\n-------------------------------------------");
	print("Simple Friend System loaded successfully.");
	print("-------------------------------------------\n");
	//
	BackGround = TextDrawCreate(640.000000, 336.000000, "_");
	TextDrawBackgroundColor(BackGround, 255);
	TextDrawFont(BackGround, 1);
	TextDrawLetterSize(BackGround, 0.600000, 12.000000);
	TextDrawColor(BackGround, -1);
	TextDrawSetOutline(BackGround, 0);
	TextDrawSetProportional(BackGround, 1);
	TextDrawSetShadow(BackGround, 1);
	TextDrawUseBox(BackGround, 1);
	TextDrawBoxColor(BackGround, 119);
	TextDrawTextSize(BackGround, 480.000000, 0.000000);
	return 1;
}

public OnFilterScriptExit()
{
	DOF2_Exit();
	return 1;
}

public SetMessageBoxForPlayer(playerid, string[])
{
	KillTimer(StringTimer[playerid]);
	TextDrawSetString(TextString[playerid], string);
	TextDrawShowForPlayer(playerid, BackGround);
	TextDrawShowForPlayer(playerid, TextString[playerid]);
	return 1;
}

public SetFriendBoxForPlayer(playerid, string[])
{
	KillTimer(FriendTimer[playerid]);
	TextDrawSetString(ListString[playerid], string);
	TextDrawShowForPlayer(playerid, ListString[playerid]);
	return 1;
}

public HideFriendBoxForPlayer(playerid)
{
	KillTimer(FriendTimer[playerid]);
	TextDrawHideForPlayer(playerid, ListString[playerid]);
	return 1;
}

public HideMessageBoxForPlayer(playerid)
{
	KillTimer(StringTimer[playerid]);
	TextDrawHideForPlayer(playerid, BackGround);
	TextDrawHideForPlayer(playerid, TextString[playerid]);
	return 1;
}

public OnPlayerConnect(playerid)
{
	TextString[playerid] = TextDrawCreate(483.000000, 337.000000, "Welcome:");
	TextDrawBackgroundColor(TextString[playerid], 255);
	TextDrawFont(TextString[playerid], 1);
	TextDrawLetterSize(TextString[playerid], 0.210000, 1.400000);
	TextDrawColor(TextString[playerid], -1);
	TextDrawSetOutline(TextString[playerid], 0);
	TextDrawSetProportional(TextString[playerid], 1);
	TextDrawSetShadow(TextString[playerid], 1);
	TextDrawUseBox(TextString[playerid], 1);
	TextDrawBoxColor(TextString[playerid], 0xFFFFFF00);
	TextDrawTextSize(TextString[playerid], 638.000000, 0.000000);
	//
	ListString[playerid] = TextDrawCreate(156.000000, 165.000000, "Friends Online:");
	TextDrawBackgroundColor(ListString[playerid], 255);
	TextDrawFont(ListString[playerid], 1);
	TextDrawLetterSize(ListString[playerid], 0.410000, 0.799999);
	TextDrawColor(ListString[playerid], -1);
	TextDrawSetOutline(ListString[playerid], 0);
	TextDrawSetProportional(ListString[playerid], 1);
	TextDrawSetShadow(ListString[playerid], 1);
	TextDrawUseBox(ListString[playerid], 1);
	TextDrawBoxColor(ListString[playerid], 119);
	TextDrawTextSize(ListString[playerid], 390.000000, 20.000000);
	//
	new USER_FILE[64], AmigosOnline;
	format(USER_FILE, sizeof(USER_FILE), "SFSUsers/%s.ini", GetPlayerNameEx(playerid));
	if(!DOF2_FileExists(USER_FILE)) DOF2_CreateFile(USER_FILE);
	foreach(Player, i)
	{
		if(DOF2_GetInt(USER_FILE, GetPlayerNameEx(i)) == 1)
		{
			AmigosOnline++;
			new iStr[50];
			format(iStr, sizeof(iStr), "~n~~n~%s has connected.", GetPlayerNameEx(playerid));
			SetMessageBoxForPlayer(i, iStr);
			StringTimer[i] = SetTimerEx("HideMessageBoxForPlayer", 6000, false, "i", i);
		}
	}
	//
	new iStr[128];
	format(iStr, sizeof(iStr), "Welcome %s,~n~~n~Connected successfully.~n~~n~Friends Online: %i", GetPlayerNameEx(playerid), AmigosOnline);
	TextDrawSetString(TextString[playerid], iStr);
	TextDrawShowForPlayer(playerid, BackGround);
	TextDrawShowForPlayer(playerid, TextString[playerid]);
	StringTimer[playerid] = SetTimerEx("HideMessageBoxForPlayer", 6000, false, "i", playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	TextDrawDestroy(Text:TextString[playerid]);
	TextDrawDestroy(Text:ListString[playerid]);
	TextString[playerid] = Text:INVALID_TEXT_DRAW;
	ListString[playerid] = Text:INVALID_TEXT_DRAW;
	new USER_FILE[64];
	format(USER_FILE, sizeof(USER_FILE), "SFSUsers/%s.ini", GetPlayerNameEx(playerid));
	foreach(Player, i)
	{
		if(DOF2_GetInt(USER_FILE, GetPlayerNameEx(i)) == 1)
		{
			new iStr[50];
			format(iStr, sizeof(iStr), "~n~~n~%s has disconnected.", GetPlayerNameEx(playerid));
			SetMessageBoxForPlayer(i, iStr);
			StringTimer[i] = SetTimerEx("HideMessageBoxForPlayer", 6000, false, "i", i);
		}
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case AMIGODIALOG:
		{
			if(!response)
			{
				SendClientMessage(GetPVarInt(playerid, "AmigoRequest"), 0x33AA33AA, "(*) The invitation has been declined.");
				DeletePVar(playerid, "AmigoRequest");
				SendClientMessage(playerid, 0x33AA33AA, "(*) You declined the invitation.");
				return 1;
			}
			new USER_FILE[64], FRIEND_FILE[64];
			new giveplayerid = GetPVarInt(playerid, "AmigoRequest");
			format(USER_FILE, sizeof(USER_FILE), "SFSUsers/%s.ini", GetPlayerNameEx(playerid));
			DOF2_SetInt(USER_FILE, GetPlayerNameEx(giveplayerid), 1);
			format(FRIEND_FILE, sizeof(FRIEND_FILE), "SFSUsers/%s.ini", GetPlayerNameEx(giveplayerid));
			DOF2_SetInt(FRIEND_FILE, GetPlayerNameEx(playerid), 1);
			DOF2_SaveFile();
			SendClientMessage(giveplayerid, 0x33AA33AA, "(*) The invitation has been accepted.");
			SendClientMessage(playerid, 0x33AA33AA, "(*) You've accepted the invitation.");
			DeletePVar(playerid, "AmigoRequest");
		}
		case MESGEDIALOG:
		{
			if(!response) return 1;
			new command[128];
			format(command, sizeof(command), "%i %s", GetPVarInt(playerid, "ClickedPlayer"), inputtext);
			cmd_msg(playerid, command);
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	new USER_FILE[64];
	format(USER_FILE, sizeof(USER_FILE), "SFSUsers/%s.ini", GetPlayerNameEx(playerid));
	if(DOF2_GetInt(USER_FILE, GetPlayerNameEx(clickedplayerid)) == 0) return SendClientMessage(playerid, 0x33AA33AA, "(*) You are not friend of this player.");
	SetPVarInt(playerid, "ClickedPlayer", clickedplayerid);
	ShowPlayerDialog(playerid, MESGEDIALOG, DIALOG_STYLE_INPUT, "Sending message to friend.", "Write a message.", "Send", "Cancel");
	return 1;
}

CMD:friend(playerid, params[])
{
	new giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, 0x33AA33AA, "(*) /friend [playerid]");
	if(playerid == giveplayerid) return SendClientMessage(playerid, 0x33AA33AA, "(*) You cannot be friend of yourself.");
	new USER_FILE[64];
	format(USER_FILE, sizeof(USER_FILE), "SFSUsers/%s.ini", GetPlayerNameEx(playerid));
	if(DOF2_GetInt(USER_FILE, GetPlayerNameEx(giveplayerid)) == 1) return SendClientMessage(playerid, 0x33AA33AA, "(*) You already are friend of this player.");
	new iStr[70];
	format(iStr, sizeof(iStr), "(*) You sent an invitation to %s for a friendship.", GetPlayerNameEx(giveplayerid));
	SendClientMessage(playerid, 0x33AA33AA, iStr);
	format(iStr, sizeof(iStr), "%s wants to become your friend.\nDo you accept?", GetPlayerNameEx(playerid));
	ShowPlayerDialog(giveplayerid, AMIGODIALOG, DIALOG_STYLE_MSGBOX, "Want to be my friend?", iStr, "Yes", "No");
	SetPVarInt(giveplayerid, "AmigoRequest", playerid);
	return 1;
}

CMD:deletefriend(playerid, params[])
{
	new giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, 0x33AA33AA, "(*) /deletefriend [playerid]");
	if(playerid == giveplayerid) return SendClientMessage(playerid, 0x33AA33AA, "(*) You may not delete yourself.");
	new USER_FILE[64];
	format(USER_FILE, sizeof(USER_FILE), "SFSUsers/%s.ini", GetPlayerNameEx(playerid));
	if(DOF2_GetInt(USER_FILE, GetPlayerNameEx(giveplayerid)) != 1) return SendClientMessage(playerid, 0x33AA33AA, "(*) You are not friend of this player.");
	new iStr[70];
	format(iStr, sizeof(iStr), "(*) You deleted %s of your friends.", GetPlayerNameEx(giveplayerid));
	SendClientMessage(playerid, 0x33AA33AA, iStr);
	format(iStr, sizeof(iStr), "(*) %s deleted you as friend.", GetPlayerNameEx(playerid));
	SendClientMessage(giveplayerid, 0x33AA33AA, iStr);
	DOF2_SetInt(USER_FILE, GetPlayerNameEx(giveplayerid), 0);
	//
	new FRIEND_FILE[64];
	format(FRIEND_FILE, sizeof(FRIEND_FILE), "SFSUsers/%s.ini", GetPlayerNameEx(giveplayerid));
	DOF2_SetInt(FRIEND_FILE, GetPlayerNameEx(playerid), 0);
	DOF2_SaveFile();
	return 1;
}

CMD:myfriends(playerid, params[])
{
	new count = 0;
	new iStr[1024] = "Friends Online:~n~";
	foreach(Player, i)
	{
		new USER_FILE[64];
		format(USER_FILE, sizeof(USER_FILE), "SFSUsers/%s.ini", GetPlayerNameEx(playerid));
		if(DOF2_GetInt(USER_FILE, GetPlayerNameEx(i)) == 1)
		{
			strins(iStr, GetPlayerNameIns(i), strlen(iStr));
			count++;
		}

	}
	if(count == 0)
	{
		SetFriendBoxForPlayer(playerid, "Friends Online:~n~None friend online.");
		FriendTimer[playerid] = SetTimerEx("HideFriendBoxForPlayer", 6000, false, "i", playerid);
	}
	else
	{
		SetFriendBoxForPlayer(playerid, iStr);
		FriendTimer[playerid] = SetTimerEx("HideFriendBoxForPlayer", 6000, false, "i", playerid);
	}
	return 1;
}

CMD:creditsfs(playerid, params[])
{
	SendClientMessage(playerid, 0xA9C4E4FF, "Simple Friend System - Credits");
	SendClientMessage(playerid, 0xA9C4E4FF, "Delevelopers:");
	SendClientMessage(playerid, 0x33AA33AA, "Luke \"Larceny\" Godoy.");
	SendClientMessage(playerid, 0x33AA33AA, "Los.");
	return 1;
}

CMD:helpfs(playerid, params[])
{
	SendClientMessage(playerid, 0xA9C4E4FF, "Commands:");
	SendClientMessage(playerid, 0xA9C4E4FF, "/friend(invite a friend) - /deletefriend - /msg(send message[or click tab]) - /creditsfs - /helpfs - /myfriends(see friends online) - /msn - (chat with all friends online)");
	return 1;
}

CMD:msg(playerid, params[])
{
	new giveplayerid, gMsg[128];
	if(sscanf(params, "us[128]", giveplayerid, gMsg)) return SendClientMessage(playerid, 0x33AA33AA, "(*) /msg [playerid] [message]");
	if(playerid == giveplayerid) return SendClientMessage(playerid, 0x33AA33AA, "(*) You may not send message to yourself.");
	if(strcmp(gMsg,"^",true) == 0) return SendClientMessage(playerid, 0x33AA33AA, "(*) ''^'' is not a character allowed.");
	if(strcmp(gMsg,"~",true) == 0) return SendClientMessage(playerid, 0x33AA33AA, "(*) ''~'' is not a character allowed.");
	new iStr[256], gStr[164];
	format(iStr, sizeof(iStr), "%s Says: ~n~%s", GetPlayerNameEx(playerid), gMsg);
	format(gStr, sizeof(gStr), "%s Says: %s", GetPlayerNameEx(playerid), gMsg);
	SetMessageBoxForPlayer(giveplayerid, iStr);
	StringTimer[giveplayerid] = SetTimerEx("HideMessageBoxForPlayer", 6000, false, "i", giveplayerid);
	SendClientMessage(giveplayerid, -1, gStr);
	//
	format(iStr, sizeof(iStr), "To %s: ~n~%s", GetPlayerNameEx(giveplayerid), gMsg);
	format(gStr, sizeof(gStr), "To %s: %s", GetPlayerNameEx(giveplayerid), gMsg);
	SetMessageBoxForPlayer(playerid, iStr);
	SetMessageBoxForPlayer(playerid, iStr);
	StringTimer[playerid] = SetTimerEx("HideMessageBoxForPlayer", 6000, false, "i", playerid);
	SendClientMessage(playerid, -1, gStr);
	return 1;
}

CMD:msn(playerid, params[])
{
	new gMsg[128];
	if(sscanf(params, "s[128]", gMsg)) return SendClientMessage(playerid, 0x33AA33AA, "(*) /msn [message]");
	if(strcmp(gMsg,"^",true) == 0) return SendClientMessage(playerid, 0x33AA33AA, "(*) ''^'' is not a character allowed.");
	if(strcmp(gMsg,"~",true) == 0) return SendClientMessage(playerid, 0x33AA33AA, "(*) ''~'' is not a character allowed.");
	new iStr[256], gStr[164];
	format(iStr, sizeof(iStr), "[ALL] %s Says: ~n~%s", GetPlayerNameEx(playerid), gMsg);
	format(gStr, sizeof(gStr), "[ALL] %s Says: %s", GetPlayerNameEx(playerid), gMsg);
	foreach(Player, i)
	{
		new USER_FILE[64];
		format(USER_FILE, sizeof(USER_FILE), "SFSUsers/%s.ini", GetPlayerNameEx(playerid));
		if(DOF2_GetInt(USER_FILE, GetPlayerNameEx(i)) == 1 && playerid != i)
		{
			SetMessageBoxForPlayer(i, iStr);
			StringTimer[i] = SetTimerEx("HideMessageBoxForPlayer", 6000, false, "i", i);
			SendClientMessage(i, -1, gStr);
		}

	}
	//
	format(iStr, sizeof(iStr), "To All: ~n~%s", gMsg);
	format(gStr, sizeof(gStr), "To All: %s", gMsg);
	SetMessageBoxForPlayer(playerid, iStr);
	SetMessageBoxForPlayer(playerid, iStr);
	StringTimer[playerid] = SetTimerEx("HideMessageBoxForPlayer", 6000, false, "i", playerid);
	SendClientMessage(playerid, -1, gStr);
	return 1;
}