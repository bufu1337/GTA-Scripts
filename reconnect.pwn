#include <zcmd>

#define FILTERSCRIPT
new ireconnect[MAX_PLAYERS];

public OnPlayerDisconnect(playerid, reason)
{
    if(ireconnect[playerid] == 1)
    {
            new unbanningip[16], string[128];
            GetPVarString(playerid, "reconnect", unbanningip, 16);// Get the msg string from the PVar
            format(string,sizeof(string),"unbanip %s", unbanningip);
            SendRconCommand(string);
            printf(string);
            SendRconCommand("reloadbans");
            ireconnect[playerid] = 0;
    }
    return 1;
}

//==============================================================================
// Reconnect
//==============================================================================
COMMAND:reconnect(playerid, params[])
{
    new pid;
    if(sscanf(params, "us", pid, params[2])) return SendClientMessage(playerid, 0xFF0000AA, "Command Usage: /reconnect [playerid] [reason]");
    if(level[playerid] >= 1 || viplevel[playerid] == 2)//change these to the way you got it in your admin script. this is the way I got it, so..
    {
        if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, red, "ERROR: That player is not online.");
        new adminname[MAX_PLAYER_NAME], paramname[MAX_PLAYER_NAME], string[180];
        new ip[16];
        GetPlayerIp(pid, ip, sizeof(ip));
        GetPlayerName(pid, paramname, sizeof(paramname));
        GetPlayerName(playerid, adminname, sizeof(adminname));
        format(string, sizeof(string), "Administrator %s has forced %s to reconnect. [Reason: %s]", adminname, paramname, params[2]);
        SendClientMessageToAll(red, string);
        print(string);
        format(string, sizeof(string), "banip %s", ip);
        SetPVarString(pid,"reconnect",ip);
        ireconnect[pid] = 1;
        SendRconCommand(string);
    }
    else SendClientMessage(playerid, red, "Error: You must be a higher level administrator to use that command.");
    return 1;
}