#include <a_samp>

forward OnPlayerMakeCBug(playerid);

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_FIRE && oldkeys & KEY_CROUCH && IsCbugWeapon(playerid))
    {
        CallLocalFunction("OnPlayerMakeCBug", "i", playerid);
    }
	return 1;
}

stock IsCbugWeapon(playerid)
{
    new weaponID = GetPlayerWeapon(playerid);
    if(weaponID == 22 || weaponID == 24 || weaponID == 25 || weaponID == 27)
    {
		return 1;
    }
	return 0;
}