#include "a_samp.inc"
forward OnPlayerTargetPlayer(playerid,newtarget,oldtarget);
static target[MAX_PLAYERS] = {INVALID_PLAYER_ID,...};
stock OPTP_OnPlayerUpdate(playerid)
{
	new trg = GetPlayerTargetPlayer(playerid);
	if(trg != target[playerid])
	{
		if(funcidx("OnPlayerTargetPlayer") != -1) CallLocalFunction("OnPlayerTargetPlayer","iii",playerid,trg,target[playerid]);
		target[playerid] = trg;
	}
	return 1;
}
stock OPTP_OnPlayerConnect(playerid) return target[playerid] = INVALID_PLAYER_ID;
