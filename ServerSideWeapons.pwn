#include <a_samp>

#if defined _GAC_included
	#endinput
#endif
#define _GAC_included

#if defined FILTERSCRIPT

	stock GivePlayerWeaponEx(playerid,weaponid,ammo)
	{
		return CallToRemoteFunction("GivePlayerWeaponEx","iii",playerid,weaponid,ammo);
	}

	#define GivePlayerWeapon GivePlayerWeaponEx

#endif


#define MAX_CLASS 300 // change if needed

static
	bool:PlayerWeapons[MAX_PLAYERS][47],
	bool:Spawned[MAX_PLAYERS],
	WeaponPickup[MAX_PICKUPS],
	ClassWeapons[MAX_CLASS][3],
	PlayerClass[MAX_PLAYERS];



public OnPlayerConnect(playerid)
{
      for(new i=0;i<47;i++) PlayerWeapons[playerid][i]=false; // clears the value
      Spawned[playerid]=false;
      return CallLocalFunction("GAC_OnPlayerConnect", "i", playerid);
}

forward GAC_OnPlayerConnect(playerid);

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect GAC_OnPlayerConnect



public OnPlayerSpawn(playerid)
{
	for(new i;i<3;i++) PlayerWeapons[playerid][ClassWeapons[PlayerClass[playerid]][i]]=true;
	SetTimerEx("RealSpawn",800,false,"i",playerid);
	return CallLocalFunction("GAC_OnPlayerSpawn", "i", playerid);
}

forward GAC_OnPlayerSpawn(playerid);
#if defined _ALS_OnPlayerSpawn
    #undef OnPlayerSpawn
#else
    #define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn GAC_OnPlayerSpawn


public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
		switch(GetVehicleModel(GetPlayerVehicleID(playerid)))
		{
			case 592,577,511,512,520,593,553,476,519,460,513,548,425,417,487,488,497,563,447,469: PlayerWeapons[playerid][46]=true;
			case 457: PlayerWeapons[playerid][2]=true;
			case 596,597,598,599: PlayerWeapons[playerid][25]=true;
		}
	}
	return CallLocalFunction("GAC_OnPlayerStateChange", "iii", playerid, newstate, oldstate);
}

forward GAC_OnPlayerStateChange(playerid,newstate,oldstate);
#if defined _ALS_OnPlayerStateChange
    #undef OnPlayerStateChange
#else
    #define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange GAC_OnPlayerStateChange


forward RealSpawn(playerid);
public RealSpawn(playerid) Spawned[playerid]=true;


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_FIRE)
    {
		if(Spawned[playerid])
		{
			 static weapon;
			 weapon = GetPlayerWeapon(playerid);
			 if(!PlayerWeapons[playerid][weapon] && weapon != 40 && weapon != 0) BanEx(playerid,"Weapon Cheats");

		}
    }
	return CallLocalFunction("GAC_OnPlayerKeyStateChange", "iii", playerid, newkeys, oldkeys);
}
forward GAC_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange GAC_OnPlayerKeyStateChange



forward GivePlayerWeaponEx(playerid,weaponid,ammo);

public GivePlayerWeaponEx(playerid,weaponid,ammo)
{
    PlayerWeapons[playerid][weaponid]=true; // Player Has the weapon.
    return GivePlayerWeapon(playerid,weaponid,ammo); // To realy give him the weapon.
}


#define GivePlayerWeapon GivePlayerWeaponEx

stock GetWeaponModel(weaponid) // credits Double-O-Seven
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

stock AddStaticPickupEx(model,type,Float:X,Float:Y,Float:Z,virtualworld)
{
	new id = CreatePickup(model,type,X,Y,Z,virtualworld)
	if(type==2 || type==3 || type==15 || type==22)
	{
		for(new i;i<47;i++)
		{
			if(GetWeaponModel(i)==model)
			{
				WeaponPickup[id]=i;
			}
		}
	}
	return id;
}

#define AddStaticPickup AddStaticPickupEx

stock CreatePickupEx(model,type,Float:X,Float:Y,Float:Z,virtualworld)
{
	new id = CreatePickup(model,type,X,Y,Z,virtualworld)
	if(type==2 || type==3 || type==15 || type==22)
	{
		for(new i;i<47;i++)
		{
			if(GetWeaponModel(i)==model)
			{
				WeaponPickup[id]=i;
			}
		}
	}
	return id;
}
#define CreatePickup CreatePickupEx
public OnPlayerPickUpPickup(playerid,pickupid)
{
	if(WeaponPickup[pickupid]) PlayerWeapons[playerid][WeaponPickup[pickupid]]=true;
	return CallLocalFunction("GAC_OnPlayerPickUpPickup", "ii", playerid, pickupid);
}
forward GAC_OnPlayerPickUpPickup(playerid,pickupid);
#if defined _ALS_OnPlayerPickUpPickup
    #undef OnPlayerPickUpPickup
#else
    #define _ALS_OnPlayerPickUpPickup
#endif
#define OnPlayerPickUpPickup GAC_OnPlayerPickUpPickup


stock GAC_AddPlayerClass(modelid,Float:spawn_x,Float:spawn_y,Float:spawn_z,Float:z_angle,weapon1,weapon1_ammo,weapon2,weapon2_ammo,weapon3,weapon3_ammo)
{
	new class = AddPlayerClass(modelid,spawn_x,spawn_y,spawn_z,z_angle,weapon1,weapon1_ammo,weapon2,weapon2_ammo,weapon3,weapon3_ammo);
	if(class<MAX_CLASS)
	{
		if(weapon1 != -1) ClassWeapons[class][0]=weapon1;
		if(weapon2 != -1) ClassWeapons[class][1]=weapon2;
		if(weapon3 != -1) ClassWeapons[class][2]=weapon3;
	}
	else printf("Please change MAX_CLASS in Weapon Anti-Cheat!! Current class: %i",class);
	return class;
}
#define AddPlayerClass GAC_AddPlayerClass
stock GAC_AddPlayerClassEx(teamid,modelid,Float:spawn_x,Float:spawn_y,Float:spawn_z,Float:z_angle,weapon1,weapon1_ammo,weapon2,weapon2_ammo,weapon3,weapon3_ammo)
{
	new class = AddPlayerClassEx(teamid,modelid,spawn_x,spawn_y,spawn_z,z_angle,weapon1,weapon1_ammo,weapon2,weapon2_ammo,weapon3,weapon3_ammo);
	if(class<MAX_CLASS)
	{
		if(weapon1 != -1) ClassWeapons[class][0]=weapon1;
		if(weapon2 != -1) ClassWeapons[class][1]=weapon2;
		if(weapon3 != -1) ClassWeapons[class][2]=weapon3;
	}
	else printf("Please change MAX_CLASS in Weapon Anti-Cheat!! Current class: %i",class);
	return class;
}
#define AddPlayerClassEx GAC_AddPlayerClassEx

stock GAC_SetSpawnInfo(playerid,team,skin,Float:x,Float:y,Float:z,rotation,weapon1,weapon1_ammo,weapon2,weapon2_ammo,weapon3,weapon3_ammo)
{
	if(weapon1 != -1) PlayerWeapons[playerid][weapon1]=true;
	if(weapon2 != -1) PlayerWeapons[playerid][weapon2]=true;
	if(weapon3 != -1) PlayerWeapons[playerid][weapon3]=true;
	return SetSpawnInfo(playerid,team,skin,x,y,z,rotation,weapon1,weapon1_ammo,weapon2,weapon2_ammo,weapon3,weapon3_ammo);
}
#define SetSpawnInfo GAC_SetSpawnInfo


public OnPlayerRequestClass(playerid, classid)
{
	PlayerClass[playerid]=classid;
	return CallLocalFunction("GAC_OnPlayerRequestClass", "ii", playerid, classid);
}
forward GAC_OnPlayerRequestClass(playerid,classid);
#if defined _ALS_OnPlayerRequestClass
    #undef OnPlayerRequestClass
#else
    #define _ALS_OnPlayerRequestClass
#endif
#define OnPlayerRequestClass GAC_OnPlayerRequestClass