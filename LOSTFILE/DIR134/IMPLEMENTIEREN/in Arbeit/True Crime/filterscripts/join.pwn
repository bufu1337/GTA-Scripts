#include <a_samp>



public OnFilterScriptInit( )
{
}

public OnFilterScriptExit()
{
}

public OnPlayerConnect(playerid)
{
	new joiner[256];
	GetPlayerName(playerid,joiner,sizeof(joiner));
	format(joiner,sizeof(joiner),"*** %s (ID: %d) has joined the Server [Joining]",joiner,playerid);
    SendClientMessageToAll(0xB4B5B7AA,joiner);
    
    return 1;
}

public OnPlayerDisconnect(playerid,reason)
{
    new spieler[256];
    new string[256];

    switch(reason)
    {
        case 0:
        {
             GetPlayerName(playerid, spieler, sizeof(spieler));
             format(string, sizeof(string), "*** %s (ID: %d) has left the Server.(Timeout)", spieler,playerid);
             SendClientMessageToAll(0xB4B5B7AA, string);
        }
        case 1:
        {
             GetPlayerName(playerid, spieler, sizeof(spieler));
             format(string, sizeof(string), "*** %s (ID: %d) has left the Server.(Leaving)", spieler,playerid);
             SendClientMessageToAll(0xB4B5B7AA, string);
        }
        case 2:
        {
             GetPlayerName(playerid, spieler, sizeof(spieler));
             format(string, sizeof(string), "*** %s (ID: %d) has left the Server.(Kick/Ban)", spieler,playerid);
             SendClientMessageToAll(0xB4B5B7AA, string);
        }
	}
}
