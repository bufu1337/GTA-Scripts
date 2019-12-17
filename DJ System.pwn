#include <a_samp>
#include <dini>
#include <zcmd>
#include <sscanf2>
#include <foreach>
#define FILE1 "DJ/%s.ini"
#define COLOR_YELLOW 0xFFFF00FF
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_ORANGE 0xFF9900FF
#define COLOR_RED 0xFF0000FF


new DJ[MAX_PLAYERS];

public OnFilterScriptInit()
{
        print("\n==========================");
        print(" DJ SYSTEM BY JUBAER");
        print("============================/n");
        return 1;
}

public OnFilterScriptExit()
{
        return 1;
}
main()
{
}
public OnPlayerConnect(playerid)
{
    new file[MAX_PLAYERS];
    format(file, sizeof(file), FILE1, IsPlayerName(playerid));
    if(!fexist(file))
    {
    dini_Create(file);
    dini_IntSet(file, "DJ", 0);
    DJ[playerid] = dini_Int(file, "DJ");
    } else {
    DJ[playerid] = dini_Int(file, "DJ");
    }
    return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
    new file[MAX_PLAYERS];
    format(file, sizeof(file), FILE1, IsPlayerName(playerid));
    dini_IntSet(file, "DJ", DJ[playerid]);
    DJ[playerid] = 0;
    return 1;
}
stock IsPlayerName(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
}
CMD:dcmds(playerid, params[])
{
    new playername[25];
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	if(DJ[playerid] == 1) return SendClientMessage(playerid, COLOR_RED, "Error: You aren't DJ.");
    SendClientMessage(playerid, COLOR_YELLOW, "DJ Commands");
    SendClientMessage(playerid, COLOR_WHITE, "/playsong, /stopsong, /dc, /addsong, /delsong");
    return 1;
}

CMD:stopsong(playerid, params[])
{
    new playername[25];
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	if(DJ[playerid] == 1) return SendClientMessage(playerid, COLOR_RED, "Error: You aren't DJ.");
    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
    for(new i = 0; i < MAX_PLAYERS; i++)
    StopAudioStreamForPlayer(i);
    SendClientMessageToAll(playerid, "{FFFF00}[DJ]: A DJ has stoped an song.");
    return 1;
}

CMD:stopmusic(playerid, params[])
{
	SendClientMessage(playerid, COLOR_WHITE, "Music stopped.");
    StopAudioStreamForPlayer(playerid);
    return 1;
}

CMD:dc(playerid, params[])
{
    new Nam[MAX_PLAYERS], message[128], str[256], playername[25];
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	if(DJ[playerid] == 1) return SendClientMessage(playerid, COLOR_RED, "Error: You aren't DJ.");
    if(sscanf(params,"s",message)) return SendClientMessage(playerid,COLOR_WHITE,"USAGE: /dc [Text]");
    GetPlayerName(playerid,Nam,sizeof(Nam));
    format(str,sizeof(str),"DJ Chat [%s] %s",Nam,message);
    for (new a=0;a<MAX_PLAYERS;a++)
    {
            if (IsPlayerConnected(a))
        {
            if(DJ[playerid] == 1)
            {
                             SendClientMessage(a, COLOR_ORANGE, str);
            }
        }
    }
    return 1;
}

CMD:playsong(playerid, params[])
{
    new playername[25];
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	if(DJ[playerid] == 1) return SendClientMessage(playerid, COLOR_RED, "Error: You aren't DJ.");
	if(sscanf(params, "s[200]", params)) return SendClientMessage(playerid, -1, "Usage: /playsong [link]");
	SendClientMessageToAll(playerid, "{FFFF00}[DJ]: A DJ has played an song. /stopmusic to stop it");
	foreach(Player, i)
	{
	PlayAudioStreamForPlayer(i, params);
	}
	return 1;
}
CMD:dj(playerid, params[])
{
        if(IsPlayerAdmin(playerid))
        {
                new string[MAX_PLAYERS], targetid, license;
                if(sscanf(params, "ud", targetid, license)) return SendClientMessage(playerid, -1, "{FF9900}Usage: /dj [playerid] [1 - enable 0 - disable]");
                if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, -1, "{FF9900}Error: That player is not connected!");
                if(license == 1)
                {
                DJ[targetid] = 1;
                format(string, sizeof(string), "{FFFF00}You have set %s as DJ.", IsPlayerName(targetid));
                SendClientMessage(playerid, -1, string);
                format(string, sizeof(string), "{FFFF00}An Admin has set you DJ.");
                SendClientMessage(targetid, -1, string);
                } else {
                DJ[targetid] = 0;
                format(string, sizeof(string), "{FFFF00}You have remove %s from DJ.", IsPlayerName(targetid));
                SendClientMessage(playerid, -1, string);
                format(string, sizeof(string), "{FFFF00}An Admin has remove you from DJ.");
                SendClientMessage(targetid, -1, string);
                }

        }
        return 1;
}