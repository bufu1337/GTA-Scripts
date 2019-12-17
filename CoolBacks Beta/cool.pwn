#include <a_samp>
#include <coolbacks>

#define COLOR_YELLOW 0xFFFF00AA

#define FILTERSCRIPT

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n------------------------------");
	print("Coolbacks Testing Filterscript");
	print("--------------------------------\n");
	SetInterval(250);
	StartSystem();
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else
main()
{
}
#endif

public OnPlayerWantedLevelChange(playerid, oldlevel, newlevel)
{
	new SSSS[256];
	format(SSSS, sizeof(SSSS), "Wanted Level change: Old lvl: %d, New lvl: %d", oldlevel, newlevel);
	SendClientMessageToAll(COLOR_YELLOW, SSSS);
}

public OnPlayerHealthChange(playerid, Float:oldhealth, Float:newhealth)
{
	new SSSS[256];
	format(SSSS, sizeof(SSSS), "Health change: Old lvl: %f, New lvl: %f", oldhealth, newhealth);
	SendClientMessageToAll(COLOR_YELLOW, SSSS);
}

public OnPlayerArmourChange(playerid, Float:oldarmour, Float:newarmour)
{
	new SSSS[256];
	format(SSSS, sizeof(SSSS), "Armour change: Old lvl: %f, New lvl: %f", oldarmour, newarmour);
	SendClientMessageToAll(COLOR_YELLOW, SSSS);
}

public OnPlayerMoneyChange(playerid, oldmoney, newmoney)
{
	new SSSS[256];
	format(SSSS, sizeof(SSSS), "Money change: Old lvl: %d, New lvl: %d", oldmoney, newmoney);
	SendClientMessageToAll(COLOR_YELLOW, SSSS);
}

public OnPlayerPosChange(playerid, Float:oldx, Float:oldy, Float:oldz, Float:newx, Float:newy, Float:newz)
{
	//new SSSS[256];
	//format(SSSS, sizeof(SSSS), "Pos change: Old: x=%.1f, y=%.1f, z=%.1f || NEW x=%.1f, y=%.1f, z=%.1f", oldx, oldy, oldz, newx, newy, newz);
	//SendClientMessageToAll(COLOR_YELLOW, SSSS);
}

public OnPlayerAmmoChange(playerid, weaponid, oldammo, newammo)
{
	new SSSS[256];
	format(SSSS, sizeof(SSSS), "Ammo Change: Weapon: %d old: %d, new: %d", weaponid, oldammo, newammo);
	SendClientMessageToAll(COLOR_YELLOW, SSSS);
}

public OnPlayerSpecialActionChange(playerid, oldaction, newaction)
{
	new SSSS[256];
	format(SSSS, sizeof(SSSS), "Action Change: old: %d, new: %d", oldaction, newaction);
	SendClientMessageToAll(COLOR_YELLOW, SSSS);
}

public OnPlayerSkinChange(playerid, oldskin, newskin)
{
	new SSSS[256];
	format(SSSS, sizeof(SSSS), "Skin Change: old: %d, new: %d", oldskin, newskin);
	SendClientMessageToAll(COLOR_YELLOW, SSSS);
}

public OnPlayerScoreChange(playerid, oldscore, newscore)
{
	new SSSS[256];
	format(SSSS, sizeof(SSSS), "Score Change: old: %d, new: %d", oldscore, newscore);
	SendClientMessageToAll(COLOR_YELLOW, SSSS);
}

public OnPlayerTeamChange(playerid, oldteam, newteam)
{
	new SSSS[256];
	format(SSSS, sizeof(SSSS), "Team Change: old: %d, new: %d", oldteam, newteam);
	SendClientMessageToAll(COLOR_YELLOW, SSSS);
}
