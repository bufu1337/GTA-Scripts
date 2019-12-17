/*
    SA-MP IRC Plugin v1.2
    Copyright © 2009 Incognito

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#if defined _irc_included
	#endinput
#endif
#define _irc_included
#pragma library irc

// Natives

native IRC_Connect(const server[], port, const nickname[], const realname[], const username[]);
native IRC_Quit(botid, const message[] = "");
native IRC_JoinChannel(botid, const channel[], const key[] = "");
native IRC_PartChannel(botid, const channel[], const message[] = "");
native IRC_ChangeNick(botid, const nick[]);
native IRC_SetMode(botid, const target[], const mode[]);
native IRC_Say(botid, const target[], const message[]);
native IRC_Notice(botid, const target[], const message[]);
native IRC_IsUserOnChannel(botid, const channel[], const user[]);
native IRC_InviteUser(botid, const channel[], const user[]);
native IRC_KickUser(botid, const channel[], const user[], const message[] = "");
native IRC_GetUserChannelMode(botid, const channel[], const user[], dest[]);
native IRC_GetChannelUserList(botid, const channel[], dest[], maxlength = sizeof dest);
native IRC_SetChannelTopic(botid, const channel[], const topic[]);
native IRC_SendRaw(botid, const message[]);
native IRC_CreateGroup();
native IRC_DestroyGroup(groupid);
native IRC_AddToGroup(groupid, botid);
native IRC_RemoveFromGroup(groupid, botid);
native IRC_GroupSay(groupid, const target[], const message[]);
native IRC_GroupNotice(groupid, const target[], const message[]);

// Callbacks

forward IRC_OnConnect(botid);
forward IRC_OnDisconnect(botid);
forward IRC_OnJoinChannel(botid, channel[]);
forward IRC_OnLeaveChannel(botid, channel[], message[]);
forward IRC_OnUserDisconnect(botid, user[], host[], message[]);
forward IRC_OnUserJoinChannel(botid, channel[], user[], host[]);
forward IRC_OnUserLeaveChannel(botid, channel[], user[], host[], message[]);
forward IRC_OnUserNickChange(botid, oldnick[], newnick[], host[]);
forward IRC_OnUserSetChannelMode(botid, channel[], user[], host[], mode[]);
forward IRC_OnUserSetChannelTopic(botid, channel[], user[], host[], topic[]);
forward IRC_OnUserSay(botid, recipient[], user[], host[], message[]);
forward IRC_OnUserNotice(botid, recipient[], user[], host[], message[]);
forward IRC_OnReceiveRaw(botid, message[]);

// Stock Functions

stock IRC_IsVoice(botid, channel[], user[])
{
	new
		mode[2];
	IRC_GetUserChannelMode(botid, channel, user, mode);
	switch (mode[0])
	{
		case '+', '%', '@', '&', '!', '*', '~', '.':
		{
			return 1;
		}
	}
	return 0;
}

stock IRC_IsHalfop(botid, channel[], user[])
{
	new
		mode[2];
	IRC_GetUserChannelMode(botid, channel, user, mode);
	switch (mode[0])
	{
		case '%', '@', '&', '!', '*', '~', '.':
		{
			return 1;
	
		}
	}
	return 0;
}

stock IRC_IsOp(botid, channel[], user[])
{
	new
		mode[2];
	IRC_GetUserChannelMode(botid, channel, user, mode);
	switch (mode[0])
	{
		case '@', '&', '!', '*', '~', '.':
		{
			return 1;
	
		}
	}
	return 0;
}

stock IRC_IsAdmin(botid, channel[], user[])
{
	new
		mode[2];
	IRC_GetUserChannelMode(botid, channel, user, mode);
	switch (mode[0])
	{
		case '&', '!', '*', '~', '.':
		{
			return 1;
	
		}
	}
	return 0;
}

stock IRC_IsOwner(botid, channel[], user[])
{
	new
		mode[2];
	IRC_GetUserChannelMode(botid, channel, user, mode);
	switch (mode[0])
	{
		case '~', '.':
		{
			return 1;
	
		}
	}
	return 0;
}

// Command system for users in IRC channels
// Slightly modified zcmd (original by ZeeX)

#define CHANNEL_PREFIX '#'
#define COMMAND_PREFIX '!'

#if !defined isnull
	#define isnull(%1) \
		((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

public IRC_OnUserSay(botid, recipient[], user[], host[], message[])
{
	CallLocalFunction("Next_OnUserSay", "dssss", botid, recipient, user, host, message);
	if (recipient[0] == CHANNEL_PREFIX && message[0] == COMMAND_PREFIX)
	{
		new
			function[32],
			pos = 0;
		while (message[pos] && message[pos] != ' ')
		{
			message[pos++] |= 0x20;
		}
		if (!message[pos])
		{
			format(function, sizeof(function), "irccmd_%s", message[1]);
		}
		else
		{
			format(function, sizeof(function), "irccmd_%.*s", pos - 1, message[1]);
			while (message[++pos] == ' ') { }
			if (message[pos])
			{
				return CallLocalFunction(function, "dssss", botid, recipient, user, host, message[pos]);
			}
		}
		return CallLocalFunction(function, "dssss", botid, recipient, user, host, "\1");
	}
	return 1;
}

#define IRC_OnUserSay Next_OnUserSay
forward Next_OnUserSay(botid, recipient[], user[], host[], message[]);
