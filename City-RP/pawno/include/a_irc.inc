#if defined _irc_included
	#endinput
#endif
#define _irc_included

new sztmp[256];

native ircConnect(server[], port, user[]);
native ircDisconnect(conn);
native ircSay(conn, channel[], message[]);
native ircJoinChan(conn, channel[]);
native ircPartChan(conn, channel[]);
native ircSetMode(conn, channel[], modes[], nicks[]);
native ircGetUserLevel(conn, channel[], user[], dest[]);
native ircGetUserList(conn, channel[], dest[], size);
native ircSendRawData(conn, rawdata[]);
native ircPollEvents();
forward ircOnConnect(conn);
forward ircOnUserSay(conn, channel[], user[], message[]);
forward ircOnUserPart(conn, channel[], user[]);
forward ircOnUserJoin(conn, channel[], user[]);

// irccmd - a slightly modified version of dcmd (original work by dracoblue)
#define irccmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (irccmd_%1(conn,channel,user,"")))||(((%3)[(%2) + 1] == 32) && (irccmd_%1(conn,channel,user,(%3)[(%2) + 2]))))) return 1
#define printinfo format(sztmp,sizeof(sztmp),"%i [%s] %s:%s", conn, channel, user, params); printf(sztmp);