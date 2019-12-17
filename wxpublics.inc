/*
	---> WackoX's New useful publics <---
	Has been created by WackoX (wackox@live.com)
	This include has been made on 29-12-08, version 0.1p (public)
	>>> This include has been made for SA:MP 0.2X, it may not work with newer or older versions <<<
*/
new Float:iPlayerHealth[MAX_PLAYERS];
new Float:iNewPlayerHealth[MAX_PLAYERS];
new Float:iPlayerArmour[MAX_PLAYERS];
new Float:iNewPlayerArmour[MAX_PLAYERS];
new iPlayerMoney[MAX_PLAYERS];
new iNewPlayerMoney[MAX_PLAYERS];
new iPlayerAmmo[MAX_PLAYERS];
new iNewPlayerAmmo[MAX_PLAYERS];
new iPlayerVirtualWorld[MAX_PLAYERS];
new iNewPlayerVirtualWorld[MAX_PLAYERS];
new iPlayerScore[MAX_PLAYERS];
new iNewPlayerScore[MAX_PLAYERS];
new iPlayerTeam[MAX_PLAYERS];
new iNewPlayerTeam[MAX_PLAYERS];
new iPlayerSkin[MAX_PLAYERS];
new iNewPlayerSkin[MAX_PLAYERS];
new iPlayerWantedLevel[MAX_PLAYERS];
new iNewPlayerWantedLevel[MAX_PLAYERS];
new iPlayerWeapon[MAX_PLAYERS];
new iNewPlayerWeapon[MAX_PLAYERS];

forward OnPlayerHealthChange(playerid, Float:newhealth, Float:oldhealth);
forward OnPlayerArmourChange(playerid, Float:newarmour, Float:oldarmour);
forward OnPlayerMoneyChange(playerid, newmoney, oldmoney);
forward OnPlayerAmmoChange(playerid, newammo, oldammo);
forward OnPlayerVirtualWorldChange(playerid, newvirtualworld, oldvirtualworld);
forward OnPlayerScoreChange(playerid, newscore, oldscore);
forward OnPlayerTeamChange(playerid, newteam, oldteam);
forward OnPlayerSkinChange(playerid, newskin, oldskin);
forward OnPlayerWantedLevelChange(playerid, newwantedlevel, oldwantedlevel);
forward OnPlayerWeaponChange(playerid, newweapon, oldweapon);

/*
native OnPlayerHealthChange(playerid, Float:newhealth, Float:oldhealth);
native OnPlayerArmourChange(playerid, Float:newarmour, Float:oldarmour);
native OnPlayerMoneyChange(playerid, newmoney, oldmoney);
native OnPlayerAmmoChange(playerid, newammo, oldammo);
native OnPlayerVirtualWorldChange(playerid, newvirtualworld, oldvirtualworld);
native OnPlayerScoreChange(playerid, newscore, oldscore);
native OnPlayerTeamChange(playerid, newteam, oldteam);
native OnPlayerSkinChange(playerid, newskin, oldskin);
native OnPlayerWantedLevelChange(playerid, newwantedlevel, oldwantedlevel);
native OnPlayerWeaponChange(playerid, newweapon, oldweapon);
*/

stock OnPlayerUpdate(playerid) // Editing this public is on your own risk, it's not needed to edit because it works fine.
{
	if(IsPlayerConnected(playerid))
	{
		GetPlayerHealth(playerid, iNewPlayerHealth[playerid]);
		if(iNewPlayerHealth[playerid] != iPlayerHealth[playerid])
		{
		    OnPlayerHealthChange(playerid, iNewPlayerHealth[playerid], iPlayerHealth[playerid]);
		    iPlayerHealth[playerid] = iNewPlayerHealth[playerid];
		}

		GetPlayerArmour(playerid, iNewPlayerArmour[playerid]);
		if(iNewPlayerArmour[playerid] != iPlayerArmour[playerid])
		{
		    OnPlayerArmourChange(playerid, iNewPlayerArmour[playerid], iPlayerArmour[playerid]);
		    iPlayerArmour[playerid] = iNewPlayerArmour[playerid];
		}

		iNewPlayerMoney[playerid] = GetPlayerMoney(playerid);
		if(iNewPlayerMoney[playerid] != iPlayerMoney[playerid])
		{
		    OnPlayerMoneyChange(playerid, iNewPlayerMoney[playerid], iPlayerMoney[playerid]);
		    iPlayerMoney[playerid] = iNewPlayerMoney[playerid];
		}

		iNewPlayerAmmo[playerid] = GetPlayerAmmo(playerid);
		if(iNewPlayerAmmo[playerid] != iPlayerAmmo[playerid])
		{
		    OnPlayerAmmoChange(playerid, iNewPlayerAmmo[playerid], iPlayerAmmo[playerid]);
		    iPlayerAmmo[playerid] = iNewPlayerAmmo[playerid];
		}

		iNewPlayerVirtualWorld[playerid] = GetPlayerVirtualWorld(playerid);
		if(iNewPlayerVirtualWorld[playerid] != iPlayerVirtualWorld[playerid])
		{
		    OnPlayerVirtualWorldChange(playerid, iNewPlayerVirtualWorld[playerid], iPlayerVirtualWorld[playerid]);
		    iPlayerVirtualWorld[playerid] = iNewPlayerVirtualWorld[playerid];
		}

		iNewPlayerVirtualWorld[playerid] = GetPlayerVirtualWorld(playerid);
		if(iNewPlayerVirtualWorld[playerid] != iPlayerVirtualWorld[playerid])
		{
		    OnPlayerVirtualWorldChange(playerid, iNewPlayerVirtualWorld[playerid], iPlayerVirtualWorld[playerid]);
		    iPlayerVirtualWorld[playerid] = iNewPlayerVirtualWorld[playerid];
		}

		iNewPlayerScore[playerid] = GetPlayerScore(playerid);
		if(iNewPlayerScore[playerid] != iPlayerScore[playerid])
		{
		    OnPlayerScoreChange(playerid, iNewPlayerScore[playerid], iPlayerScore[playerid]);
		    iPlayerScore[playerid] = iNewPlayerScore[playerid];
		}

		iNewPlayerTeam[playerid] = GetPlayerTeam(playerid);
		if(iNewPlayerTeam[playerid] != iPlayerTeam[playerid])
		{
		    OnPlayerTeamChange(playerid, iNewPlayerTeam[playerid], iPlayerTeam[playerid]);
		    iPlayerTeam[playerid] = iNewPlayerTeam[playerid];
		}

		iNewPlayerSkin[playerid] = GetPlayerSkin(playerid);
		if(iNewPlayerSkin[playerid] != iPlayerSkin[playerid])
		{
		    OnPlayerSkinChange(playerid, iNewPlayerSkin[playerid], iPlayerSkin[playerid]);
		    iPlayerSkin[playerid] = iNewPlayerSkin[playerid];
		}

		iNewPlayerWantedLevel[playerid] = GetPlayerWantedLevel(playerid);
		if(iNewPlayerWantedLevel[playerid] != iPlayerWantedLevel[playerid])
		{
		    OnPlayerWantedLevelChange(playerid, iNewPlayerWantedLevel[playerid], iPlayerWantedLevel[playerid]);
		    iPlayerWantedLevel[playerid] = iNewPlayerWantedLevel[playerid];
		}

		iNewPlayerWeapon[playerid] = GetPlayerWeapon(playerid);
		if(iNewPlayerWeapon[playerid] != iPlayerWeapon[playerid])
		{
		    OnPlayerWeaponChange(playerid, iNewPlayerWeapon[playerid], iPlayerWeapon[playerid]);
		    iPlayerWeapon[playerid] = iNewPlayerWeapon[playerid];
		}
	}
	return 1;
}