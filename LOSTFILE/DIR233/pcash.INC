#if defined _pcash_included
	#endinput
#endif

#define _pcash_included
#pragma library Pcash

/*
native GivePlayerPCash(playerid, money)
native ResetPlayerPCash(playerid)
native GetPlayerPCash(playerid)
*/

new PCash[MAX_PLAYERS];

stock GivePlayerPCash(playerid, money)
{
	PCash[playerid] = PCash[playerid] + money;
	return PCash[playerid];
}

stock ResetPlayerPCash(playerid)
{
	PCash[playerid] = 0;
	return PCash[playerid];
}

stock GetPlayerPCash(playerid)
{
	return PCash[playerid];
}