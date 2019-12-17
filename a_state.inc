/*

a_state - Adds more states more than OnPlayerKeyStateChange
(c), Copyright - 2013.

*/

#if defined _state_included
	#endinput
#endif	
#define _state_included

forward OnPlayerFStyleStateChange(playerid, newstyle, oldstyle);
forward OnPlayerWLStateChange(playerid, newwl, oldwl);
forward OnPlayerTimeStateChange(playerid, newtime, oldtime, newtime2, oldtime2);
forward OnPlayerMoneyStateChange(playerid, newcash, oldcash);
forward OnPlayerNameStateChange(playerid, newname[], oldname[]);
forward OnPlayerSkinStateChange(playerid, newskin, oldskin);
forward OnPlayerDLStateChange(playerid, newdl, olddl);
forward OnPlayerScoreStateChange(playerid, newscore, oldscore);
forward OnPlayerHealthStateChange(playerid, Float:newhealth, Float:oldhealth);
forward OnPlayerArmourStateChange(playerid, Float:newarmour, Float:oldarmour);
forward OnPlayerPositionStateChange(playerid, Float:newposX, Float:newposY, Float:newposZ, Float:oldposX, Float:oldposY, Float:oldposZ);

stock SetPlayerFightingStyleEx(playerid, style = 0)
{
	new fE = GetPlayerFightingStyle(playerid);
	CallRemoteFunction("OnPlayerFStyleStateChange", "iii", playerid, style, fE);
	return SetPlayerFightingStyle(playerid, style);
}

stock SetPlayerWantedLevelEx(playerid, level = 0)
{
	new wE = GetPlayerWantedLevel(playerid);
	CallRemoteFunction("OnPlayerWLStateChange", "iii", playerid, level, wE);
	return SetPlayerWantedLevel(playerid, level);
}

stock SetPlayerTimeEx(playerid, time = 12, time2 = 0)
{
	new hE, mE;
	GetPlayerTime(playerid, hE, mE);
	CallRemoteFunction("OnPlayerTimeStateChange", "iiiii", playerid, time, hE, time2, mE);
	return SetPlayerTime(playerid, time, time2);
}

stock GivePlayerMoneyEx(playerid, money = 0)
{
	new mon = GetPlayerMoney(playerid);
	CallRemoteFunction("OnPlayerMoneyStateChange", "iii", playerid, money, mon);
	return GivePlayerMoney(playerid, money);
}

stock ResetPlayerMoneyEx(playerid, money = 0)
{
	new mon = GetPlayerMoney(playerid);
	CallRemoteFunction("OnPlayerMoneyStateChange", "iii", playerid, money, mon);
	return ResetPlayerMoney(playerid);
}

stock SetPlayerPosEx(playerid, Float:x, Float:y, Float:z)
{
	new Float:ox, Float:oy, Float:oz;
	GetPlayerPos(playerid, ox, oy, oz);
	CallRemoteFunction("OnPlayerPositionStateChange", "dffffff", playerid, x, y, z, ox, oy, oz);
	return SetPlayerPos(playerid, x, y, z);
}

stock SetPlayerHealthEx(playerid, Float:health = 100.0)
{
	new Float:hp;
	GetPlayerHealth(playerid, hp);
	CallRemoteFunction("OnPlayerHealthStateChange", "iff", playerid, health, hp);
	return SetPlayerHealth(playerid, health);
}

stock SetPlayerArmourEx(playerid, Float:armour = 100.0)
{
	new Float:ar;
	GetPlayerArmour(playerid, ar);
	CallRemoteFunction("OnPlayerArmourStateChange", "iff", playerid, armour, ar); 
	return SetPlayerArmour(playerid, armour);
}

stock SetPlayerScoreEx(playerid, score = 0)
{
	new scor = GetPlayerScore(playerid);
	CallRemoteFunction("OnPlayerScoreStateChange", "iii", playerid, score, scor);
	return SetPlayerScore(playerid, score);
}

stock SetPlayerDrunkLevelEx(playerid, level = 0)
{
	new dl = GetPlayerDrunkLevel(playerid);
	CallRemoteFunction("OnPlayerDLStateChange", "iii", playerid, level, dl);
	return SetPlayerDrunkLevelEx(playerid, level);
}

stock SetPlayerSkinEx(playerid, skinid = 0)
{
	new sk = GetPlayerSkin(playerid);
	CallRemoteFunction("OnPlayerSkinStateChange", "iii", playerid, skinid, sk);
	return SetPlayerSkin(playerid, skinid);
}

stock SetPlayerNameEx(playerid, name[])
{
	new nameEx[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nameEx, sizeof(nameEx));
	CallRemoteFunction("OnPlayerNameStateChange", "iss", playerid, name, nameEx);
	return SetPlayerName(playerid, name);
}