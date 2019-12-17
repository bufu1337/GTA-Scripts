#include <a_samp>
#include <zcmd>
new ReconnectIP[MAX_PLAYERS][32];
new bool: Reconnecting[MAX_PLAYERS];
#define MAX_IP_SIZE 32

CMD:reconnect(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    new
	        string[64];
	    new playerIP[32];
	    GetPlayerIp(playerid, playerIP, sizeof(playerIP));
	    format(ReconnectIP[playerid], MAX_IP_SIZE, "%s", playerIP);
	    format(string, sizeof(string), "banip %s", playerIP);
	    SendRconCommand(string);
	    SendClientMessage(playerid, -1, "Reconnecting...");
	    Reconnecting[playerid] = true;
	    return 1;
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(Reconnecting[playerid] == true)
	{
	    new string[64];
	    format(string, sizeof(string), "unbanip %s", ReconnectIP[playerid]);
	    SendRconCommand(string);
	    Reconnecting[playerid] = false;
	}
	return 1;
}