#include <a_samp>

enum GRAVESTONES_INFO{
	GraveStoneID,
	GraveStonePickID,
	GraveStoneName[MAX_PLAYER_NAME+19],
}

new P_GRAVESTONES[MAX_PLAYERS][GRAVESTONES_INFO];

public OnFilterScriptInit()
{
	print("\n##########################################");
	print("### Gravestones filterscript Loaded");
	print("### 		Author: Tr1viUm");
	print("#########################################\n");
	new i=0;
	while (i < GetMaxPlayers())
	{
    	P_GRAVESTONES[i][GraveStoneID]=-1;
    	P_GRAVESTONES[i][GraveStonePickID]=-1;
    	i++;
	}
	return true;
}

public OnFilterScriptExit()
{
	new i=0;
	while (i < GetMaxPlayers())
	{
	    if (P_GRAVESTONES[i][GraveStoneID] != -1 && IsPlayerConnected(i))
	    {
 			DestroyObject(P_GRAVESTONES[i][GraveStoneID]);
        	DestroyPickup(P_GRAVESTONES[i][GraveStonePickID]);
        }
    	i++;
	}
 	return true;
}

public OnPlayerConnect(playerid)
{
	return true;
}

public OnPlayerDisconnect(playerid, reason)
{
    if (P_GRAVESTONES[playerid][GraveStoneID] != -1)
    {
		DestroyObject(P_GRAVESTONES[playerid][GraveStoneID]);
		P_GRAVESTONES[playerid][GraveStoneID]=-1;
		DestroyPickup(P_GRAVESTONES[playerid][GraveStonePickID]);
		P_GRAVESTONES[playerid][GraveStonePickID]=-1;
	}
	return true;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    if (P_GRAVESTONES[playerid][GraveStoneID] != -1)
    {
		DestroyObject(P_GRAVESTONES[playerid][GraveStoneID]);
		DestroyPickup(P_GRAVESTONES[playerid][GraveStonePickID]);
	}
	new Float:fx,Float:fy,Float:fz,Float:fa;
	GetPlayerPos(playerid,fx,fy,fz);
	GetPlayerFacingAngle(playerid,fa);
	P_GRAVESTONES[playerid][GraveStoneID]=CreateObject(2896,fx,fy,fz-0.5,0,0,fa+90);
	P_GRAVESTONES[playerid][GraveStonePickID]=CreatePickup(1254,2,fx,fy,fz+0.3);
	format(P_GRAVESTONES[playerid][GraveStoneName],MAX_PLAYER_NAME+19,"~p~Here lays:~n~~r~%s",GetSpecName(playerid));
	return true;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	new i=0;
	while (i < GetMaxPlayers())
	{
	    if (pickupid ==	P_GRAVESTONES[i][GraveStonePickID])
	    {
	    	GameTextForPlayer(playerid,P_GRAVESTONES[i][GraveStoneName],5000,3);
	    	return true;
	    }
	    i++;
	}
	return true;
}

GetSpecName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, 255);
	return name;
}
