// Simple Script Callbacks (SSC) v0.1
// Copyright (C) 2010 Luka P.

#if !defined _samp_included
	#tryinclude <a_samp>
#endif
#if defined _SSC_Included
	#endinput
#endif
#define _SSC_Included

#pragma library SSC

forward OnPlayerHealthChange(playerid, Float:oldhealth, Float:newhealth);
forward OnPlayerArmourChange(playerid, Float:oldarmour, Float:newarmour);
forward OnPlayerWeaponChange(playerid, oldweapon, newweapon);
forward OnPlayerWeaponAmmoChange(playerid, oldammo, newammo);
forward OnPlayerPositionChange(playerid, Float:oldX, Float:oldY, Float:oldZ, Float:newX, Float:newY, Float:newZ);
forward OnPlayerTeamChange(playerid, oldteam, newteam);
forward OnPlayerSkinChange(playerid, oldskin, newskin);
forward OnPlayerMoneyChange(playerid, oldmoney, newmoney);
forward OnPlayerSpecialActionChange(playerid, oldaction, newaction);
forward OnPlayerPingChange(playerid, oldping, newping);
forward OnPlayerScoreChange(playerid, oldscore, newscore);
forward OnPlayerDrunkLevelChange(playerid, oldlevel, newlevel);
forward OnPlayerWantedLevelChange(playerid, oldlevel, newlevel);

enum
	SSC_PlayerInformations
	{
	    Float:LastHealth,
	    Float:LastArmour,
	    LastWeapon,
	    LastWeaponAmmo,
		Float:LastX,
		Float:LastY,
		Float:LastZ,
		LastTeam,
		LastSkin,
		LastMoney,
		LastSpecialAction,
		LastPing,
		LastScore,
		LastDrunkLevel,
		LastWantedLevel
	};
	
new
	SSC_Info[MAX_PLAYERS][SSC_PlayerInformations];

public OnPlayerUpdate(playerid)
{
	new
		Float:health, Float:armour, Float:X, Float:Y, Float:Z;
		
	GetPlayerHealth(playerid, health);
	GetPlayerArmour(playerid, armour);
	GetPlayerPos(playerid, X, Y, Z);

    #if defined _OnPlayerHealthChange
		if(floatcmp(SSC_Info[playerid][LastHealth], health))
		{
		    CallLocalFunction("OnPlayerHealthChange", "iff", playerid, SSC_Info[playerid][LastHealth], health);
		    SSC_Info[playerid][LastHealth] = health;
		}
	#endif
	#if defined _OnPlayerArmourChange
		if(floatcmp(SSC_Info[playerid][LastArmour], armour))
		{
		    CallLocalFunction("OnPlayerArmourChange", "iff", playerid, SSC_Info[playerid][LastArmour], armour);
		    SSC_Info[playerid][LastArmour] = armour;
		}
	#endif
	#if defined _OnPlayerWeaponChange
		if(GetPlayerWeapon(playerid) != SSC_Info[playerid][LastWeapon])
		{
		    CallLocalFunction("OnPlayerWeaponChange", "iii", playerid, SSC_Info[playerid][LastWeapon], GetPlayerWeapon(playerid));
		    SSC_Info[playerid][LastWeapon] = GetPlayerWeapon(playerid);
		}
	#endif
	#if defined _OnPlayerWeaponAmmoChange
		if(GetPlayerAmmo(playerid) != SSC_Info[playerid][LastWeaponAmmo])
		{
		    CallLocalFunction("OnPlayerWeaponAmmoChange", "iii", playerid, SSC_Info[playerid][LastWeaponAmmo], GetPlayerAmmo(playerid));
		    SSC_Info[playerid][LastWeaponAmmo] = GetPlayerAmmo(playerid);
		}
	#endif
    #if defined _OnPlayerPositionChange
		if(floatcmp(SSC_Info[playerid][LastX], X) || floatcmp(SSC_Info[playerid][LastY], Y) || floatcmp(SSC_Info[playerid][LastZ], Z))
		{
		    CallLocalFunction("OnPlayerPositionChange", "iffffff", playerid, SSC_Info[playerid][LastX], SSC_Info[playerid][LastY], SSC_Info[playerid][LastZ], X, Y, Z);
		    SSC_Info[playerid][LastX] = X;
		    SSC_Info[playerid][LastY] = Y;
		    SSC_Info[playerid][LastZ] = Z;
		}
	#endif
	#if defined _OnPlayerTeamChange
		if(GetPlayerTeam(playerid) != SSC_Info[playerid][LastTeam])
		{
		    CallLocalFunction("OnPlayerTeamChange", "iii", playerid, SSC_Info[playerid][LastTeam], GetPlayerTeam(playerid));
		    SSC_Info[playerid][LastTeam] = GetPlayerTeam(playerid);
		}
	#endif
	#if defined _OnPlayerSkinChange
		if(GetPlayerSkin(playerid) != SSC_Info[playerid][LastSkin])
		{
		    CallLocalFunction("OnPlayerSkinChange", "iii", playerid, SSC_Info[playerid][LastSkin], GetPlayerSkin(playerid));
		    SSC_Info[playerid][LastSkin] = GetPlayerSkin(playerid);
		}
	#endif
	#if defined _OnPlayerMoneyChange
		if(GetPlayerMoney(playerid) != SSC_Info[playerid][LastMoney])
		{
	        CallLocalFunction("OnPlayerMoneyChange", "iii", playerid, SSC_Info[playerid][LastMoney], GetPlayerMoney(playerid));
		    SSC_Info[playerid][LastMoney] = GetPlayerMoney(playerid);
		}
	#endif
	#if defined _OnPlayerSpecialActionChange
		if(GetPlayerSpecialAction(playerid) != SSC_Info[playerid][LastSpecialAction])
		{
	 		CallLocalFunction("OnPlayerSpecialActionChange", "iii", playerid, SSC_Info[playerid][LastSpecialAction], GetPlayerSpecialAction(playerid));
		    SSC_Info[playerid][LastSpecialAction] = GetPlayerSpecialAction(playerid);
		}
	#endif
	#if defined _OnPlayerPingChange
		if(GetPlayerPing(playerid) != SSC_Info[playerid][LastPing])
		{
		    CallLocalFunction("OnPlayerPingChange", "iii", playerid, SSC_Info[playerid][LastPing], GetPlayerPing(playerid));
		    SSC_Info[playerid][LastPing] = GetPlayerPing(playerid);
		}
	#endif
    #if defined _OnPlayerScoreChange
		if(GetPlayerScore(playerid) != SSC_Info[playerid][LastScore])
		{
		    CallLocalFunction("OnPlayerScoreChange", "iii", playerid, SSC_Info[playerid][LastScore], GetPlayerScore(playerid));
		    SSC_Info[playerid][LastScore] = GetPlayerScore(playerid);
		}
	#endif
	#if defined _OnPlayerDrunkLevelChange
		if(GetPlayerDrunkLevel(playerid) != SSC_Info[playerid][LastDrunkLevel])
		{
		    CallLocalFunction("OnPlayerDrunkLevelChange", "iii", playerid, SSC_Info[playerid][LastDrunkLevel], GetPlayerDrunkLevel(playerid));
		    SSC_Info[playerid][LastDrunkLevel] = GetPlayerDrunkLevel(playerid);
		}
	#endif
	#if defined _OnPlayerWantedLevelChange
		if(GetPlayerWantedLevel(playerid) != SSC_Info[playerid][LastWantedLevel])
		{
		    CallLocalFunction("OnPlayerWantedLevelChange", "iii", playerid, SSC_Info[playerid][LastWantedLevel], GetPlayerWantedLevel(playerid));
		    SSC_Info[playerid][LastWantedLevel] = GetPlayerWantedLevel(playerid);
		}
	#endif
	
	if (funcidx("SSC_OnPlayerUpdate") != -1)
	{
		return CallLocalFunction("SSC_OnPlayerUpdate", "i", playerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate SSC_OnPlayerUpdate
forward SSC_OnPlayerUpdate(playerid);

public OnPlayerConnect(playerid)
{
	SSC_Info[playerid][LastHealth]          =   0;
	SSC_Info[playerid][LastArmour]          =   0;
	SSC_Info[playerid][LastWeapon]          =   0;
	SSC_Info[playerid][LastWeaponAmmo]      =   0;
	SSC_Info[playerid][LastX]               =   0.00;
	SSC_Info[playerid][LastY]               =   0.00;
	SSC_Info[playerid][LastZ]               =   0.00;
	SSC_Info[playerid][LastTeam]            =   0;
	SSC_Info[playerid][LastSkin]            =   0;
	SSC_Info[playerid][LastMoney]           =   0;
	SSC_Info[playerid][LastSpecialAction]   =   0;
	SSC_Info[playerid][LastPing]            =   0;
	SSC_Info[playerid][LastScore]           =   0;
	SSC_Info[playerid][LastDrunkLevel]      =   0;
	SSC_Info[playerid][LastWantedLevel]     =   0;
	
	if (funcidx("SSC_OnPlayerConnect") != -1)
	{
		return CallLocalFunction("SSC_OnPlayerConnect", "i", playerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect SSC_OnPlayerConnect
forward SSC_OnPlayerConnect(playerid);

