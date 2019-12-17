#include <a_samp>

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid)
{
/*	new Float:Velocity[3];
	GetPlayerVelocity(playerid, Velocity[0], Velocity[1], Velocity[2]);
    new Float:health, Float:armor;
    GetPlayerHealth(playerid, health);
    GetPlayerArmour(playerid, armor);
    SetPlayerArmour(playerid, armor);
	SetPlayerHealth(playerid, health);*/
	// Testing line endings
	if(GetPVarInt(issuerid, "tookdamagefrom") == playerid)
	{
	    SetPlayerArmour(playerid, GetPVarFloat(issuerid, "tookdamagefrom2"));
		SetPlayerHealth(playerid, GetPVarFloat(issuerid, "tookdamagefrom1"));
		DeletePVar(issuerid, "tookdamagefrom");
		DeletePVar(issuerid, "tookdamagefrom1");
		DeletePVar(issuerid, "tookdamagefrom2");
	}
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid)
{
    new Float:health, Float:armor;
    GetPlayerHealth(damagedid, health);
    GetPlayerArmour(damagedid, armor);
	SetPVarFloat(playerid, "tookdamagefrom1", health);
	SetPVarFloat(playerid, "tookdamagefrom2", armor);
	if(armor >= amount)
	{
	    SetPlayerArmour(damagedid, armor-amount);
		SetPVarFloat(playerid, "tookdamagefrom2", armor-amount);
	}
	else
	{
	    SetPlayerHealth(damagedid, health-amount);
	    SetPVarFloat(playerid, "tookdamagefrom1", health-amount);
	}
	SetPVarInt(playerid, "tookdamagefrom", damagedid);
	return 1;
}