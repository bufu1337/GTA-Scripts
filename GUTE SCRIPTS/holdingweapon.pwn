#include <a_samp>

#define WEAPON_TYPE_NONE 	(0)
#define WEAPON_TYPE_HEAVY   (1)
#define WEAPON_TYPE_LIGHT   (2)
#define WEAPON_TYPE_MELEE   (3)//Nahkampf

new OldWeapon[MAX_PLAYERS];
new HoldingWeapon[MAX_PLAYERS];

//------------------------------------------------------------------------------------------------------

public OnFilterScriptExit()
{
	for(new i=0;i<MAX_PLAYERS;i++)
	    if(IsPlayerConnected(i))
			StopPlayerHoldingObject(i);
	return 1;
}

public OnPlayerConnect(playerid)
{
	OldWeapon[playerid]=0;
	HoldingWeapon[playerid]=0;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate==PLAYER_STATE_ONFOOT)
	{
		StopPlayerHoldingObject(playerid);
		OldWeapon[playerid]=0;
		HoldingWeapon[playerid]=0;
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
	if(GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)
	{
		new weaponid=GetPlayerWeapon(playerid),oldweapontype=GetWeaponType(OldWeapon[playerid]);
		new weapontype=GetWeaponType(weaponid);
		if(HoldingWeapon[playerid]==weaponid)
		    StopPlayerHoldingObject(playerid);

		if(OldWeapon[playerid]!=weaponid)
		{
		    new modelid=GetWeaponModel(OldWeapon[playerid]);
		    if(modelid!=0 && oldweapontype!=WEAPON_TYPE_NONE && oldweapontype!=weapontype)
		    {
		        HoldingWeapon[playerid]=OldWeapon[playerid];
		        switch(oldweapontype)
		        {
		            case WEAPON_TYPE_LIGHT:
						SetPlayerHoldingObject(playerid, modelid, 8,0.0,-0.1,0.15, -100.0, 0.0, 0.0);

					case WEAPON_TYPE_MELEE:
					    SetPlayerHoldingObject(playerid, modelid, 7,0.0,0.0,-0.18, 100.0, 45.0, 0.0);

					case WEAPON_TYPE_HEAVY:
					    SetPlayerHoldingObject(playerid, modelid, 1, 0.2,-0.125,-0.1,0.0,25.0,180.0);
		        }
		    }
		}

		if(oldweapontype!=weapontype)
			OldWeapon[playerid]=weaponid;
	}
	return 1;
}

//------------------------------------------------------------------------------------------------------

GetWeaponType(weaponid)
{
	switch(weaponid)
	{
	    case 22,23,24,26,28,32:
	        return WEAPON_TYPE_LIGHT;

		case 3,4,16,17,18,39,10,11,12,13,14,40,41:
		    return WEAPON_TYPE_MELEE;

		case 2,5,6,7,8,9,25,27,29,30,31,33,34,35,36,37,38:
		    return WEAPON_TYPE_HEAVY;
	}
	return WEAPON_TYPE_NONE;
}

stock GetWeaponModel(weaponid)
{
	switch(weaponid)
	{
	    case 1:
	        return 331;

		case 2..8:
		    return weaponid+331;

        case 9:
		    return 341;

		case 10..15:
			return weaponid+311;

		case 16..18:
		    return weaponid+326;

		case 22..29:
		    return weaponid+324;

		case 30,31:
		    return weaponid+325;

		case 32:
		    return 372;

		case 33..45:
		    return weaponid+324;

		case 46:
		    return 371;
	}
	return 0;
}