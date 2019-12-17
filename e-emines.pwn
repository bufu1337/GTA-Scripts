#include <a_samp>
#include icpm
new mine[MAX_PLAYERS][3];
public OnPlayerSpawn(playerid) return mine[playerid][0] = 5,1;
public OnPlayerUpdate(playerid) return PosChecker(playerid);
public OnPlayerConnect(playerid) return ToggleICpsForPlayer(playerid,true);
public OnPlayerDisconnect(playerid,reason) return DestroyObject(mine[playerid][2]), DestroyICp(mine[playerid][1]),1;
public OnFilterScriptInit()
{
	for( new z = 0; z < GetMaxPlayers(); z ++) if(IsPlayerConnected(z)) OnPlayerConnect(z);
	return print("|-* e-Mines v1.0 *-| loaded"),1;
}
public OnFilterScriptExit()
{
	for( new z = 0; z < GetMaxPlayers(); z ++) if(IsPlayerConnected(z)) OnPlayerDisconnect(z,1);
	return print("|-* e-Mines v1.0 *-| unloaded"),1;
}
public OnPlayerEnterInvisibleCP(playerid,icpid)
{
	if(MainVar[icpid][3] != 1.32) return 0;
	new i,estr[128], Float: q[3];
	for( i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && icpid == mine[i][1])
		{
		    new names[2][MAX_PLAYER_NAME];
		    GetPlayerName(i,names[0],MAX_PLAYER_NAME);
		    GetPlayerName(playerid,names[1],MAX_PLAYER_NAME);
			GetObjectPos(mine[i][2],q[0],q[1],q[2]);
		    CreateExplosion(q[0],q[1],q[2], 7, 8.0);
		    DestroyObject(mine[i][2]);
		    DestroyICp(mine[i][1]);
		    format(estr,128,"%s's mine killed %s!",names[0],names[1]);
		    if(i==playerid) format(estr,128,"%s killed by his own mine!",names[1]);
		    SendClientMessageToAll(0xFFFFFFAA,estr);
		    GameTextForPlayer(playerid,"~r~Your Mine Exploded!",3000,1);
			SetPlayerHealth(playerid,0.0);
			return 1;
		}
	}
	return 1;
}
public OnPlayerLeaveInvisibleCP(playerid,icpid)
{
	if(MainVar[icpid][3] == 6)
	{
        new Float: q[3];
        GetObjectPos(mine[playerid][2],q[0],q[1],q[2]);
	    DestroyICp(icpid);
	    mine[playerid][1] = CreateICp(q[0],q[1],q[2],1.32);
	    GameTextForPlayer(playerid,"~b~Mine Activated!",1000,1);
	}
 	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
    new estr[64];
	if (strcmp("/placemine", cmdtext, true) == 0)
	{
		if(!mine[playerid][0]) return SendClientMessage(playerid,0xFFFFFFAA,"You don't have any mines.");
		if(IsValidObject(mine[playerid][2])) DestroyObject(mine[playerid][2]);
		mine[playerid][0] --;
		new Float: q[3];
		GetPlayerPos(playerid,q[0],q[1],q[2]);
		mine[playerid][1] = CreateICp(q[0],q[1],q[2],6);
		mine[playerid][2] = CreateObject(1213,q[0],q[1],q[2]-0.85,0,0,0);
		return 1;
	} else if (strcmp("/mymines", cmdtext, true) == 0) return format(estr,64,"Mines in your pocket: %d",mine[playerid][0]), SendClientMessage(playerid,0x99FF00AA,estr);
	return 0;
}
