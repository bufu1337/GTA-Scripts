#include <a_samp>

/*
  === gh.inc ===
  Gun Holder:
  
  native SetHolderWeapon(gh_playerid, gh_weapon);
  native GetHolderWeapon(gh_playerid);
  native RemoveHolderWeapon(gh_playerid);
*/

enum gh_player_enum
{
	gh_wep,
	gh_obj
}
new gh_player[MAX_PLAYERS][gh_player_enum];
new gh_objectIds[200] = {

   -1,  331, 333, 334, 335, 336, 337, 338, 339, 341, 321, // 0 - 10
   322, 323, 324, 325, 326, 342, 343, 344, -1,  -1 , -1 , // 11 - 21
   346, 347, 348, 349, 350, 351, 352, 353, 355, 356, 372, // 22 - 32
   357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, // 33 - 43
   368, 369, -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , // 54 - 64
};

stock SetHolderWeapon(gh_playerid, gh_weapon)
{
	if (gh_GetObjectID(gh_weapon) == -1)
	{
	    return 0;
	}
	if (gh_player[gh_playerid][gh_obj] != -1)
	{
	    DestroyObject(gh_player[gh_playerid][gh_obj]);
	    gh_player[gh_playerid][gh_obj] = 255;
	}
	gh_player[gh_playerid][gh_wep] = gh_weapon;
	gh_player[gh_playerid][gh_obj] = CreateObject(gh_GetObjectID(gh_weapon), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	AttachObjectToPlayer(gh_player[gh_playerid][gh_obj], gh_playerid, 0, -0.13, 0.15, -5.0, 315.0, 0.0);
	return 1;
}

stock GetHolderWeapon(gh_playerid)
{
	return gh_player[gh_playerid][gh_wep];
}

stock RemoveHolderWeapon(gh_playerid)
{
	gh_player[gh_playerid][gh_wep] = -1;
	DestroyObject(gh_player[gh_playerid][gh_obj]);
	gh_player[gh_playerid][gh_obj] = -1;
	return 1;
}

stock gh_GetObjectID(wepID)
{
	if (wepID < 0 || wepID > 64) return -1;
	return gh_objectIds[wepID];
}
