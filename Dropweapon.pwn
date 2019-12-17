#include <a_samp>
#include <streamer>
#include <zcmd>
#include <foreach>

#define MAX_DROP_ITEMS 1000
#define COLOR_ACTION 0xFFC0CBFF

new string[128], sendername[MAX_PLAYER_NAME], DropObject[MAX_DROP_ITEMS];

new GunObjectIDs[200] ={

   1575,  331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324, 325, 326, 342, 343, 344, -1,  -1 , -1 ,
   346, 347, 348, 349, 350, 351, 352, 353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367,
   368, 369, 1575
};

enum dData
{
    DropGunAmmount[2],
    Float:DropGunPosX,
    Float:DropGunPosY,
    Float:DropGunPosZ,
    DropGunVWorld,
    DropGunInterior,
};

public OnPlayerDeath(playerid, killerid, reason)
{
    new Float:X,Float:Y,Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    DropGun(playerid, GetPlayerWeapon(playerid),GetPlayerAmmo(playerid),X,Y,Z,GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    return 1;
}

COMMAND:dropgun(playerid, params[])
{
    new Float:X,Float:Y,Float:Z;
    new GunID = GetPlayerWeapon(playerid);
    new GunAmmo = GetPlayerAmmo(playerid);
    GetPlayerName(playerid, sendername, sizeof(sendername));
    GetPlayerPos(playerid, X, Y, Z);
    RemovePlayerWeapon(playerid, GunID);
    DropGun(playerid, GunID,GunAmmo,X,Y,Z,GetPlayerVirtualWorld(playerid),GetPlayerInterior(playerid));
    format(string, sizeof(string), "* %s drops his weapon to the pavement.", sendername);
    SendLocalMessage(playerid, string, 10.0, COLOR_ACTION, COLOR_ACTION);
    return 1;
}

COMMAND:pickupgun(playerid, params[])
{
    for(new i = 0; i < sizeof(DropInfo); i++)
    {
        if (IsPlayerInRangeOfPoint(playerid, 2.0,DropInfo[i][DropGunPosX],DropInfo[i][DropGunPosY],DropInfo[i][DropGunPosZ]))
        {
            if(GetPlayerVirtualWorld(playerid) == DropInfo[i][DropGunVWorld] && GetPlayerInterior(playerid) == DropInfo[i][DropGunVWorld])
            {
                GetPlayerName(playerid, sendername, sizeof(sendername));
                DestroyDynamicObject(DropObject[i]);
                DropInfo[i][DropGunPosX] = 0.0;
                DropInfo[i][DropGunPosY] = 0.0;
                DropInfo[i][DropGunPosZ] = 0.0;
                DropInfo[i][DropGunAmmount][0] = 0;
                DropInfo[i][DropGunAmmount][1] = 0;
                GivePlayerWeapon(playerid,DropInfo[i][DropGunAmmount][0],DropInfo[i][DropGunAmmount][1]);
                format(string, sizeof(string), "* %s picks up a weapon from the pavement.", sendername);
                SendLocalMessage(playerid, string, 10.0, COLOR_ACTION, COLOR_ACTION);
                return 1;
            }
        }
    }
    return 1;
}

stock SendLocalMessage(playerid, msg[], Float:MessageRange, Range1color, Range2color)
{
    new Float: PlayerX, Float: PlayerY, Float: PlayerZ;
    GetPlayerPos(playerid, PlayerX, PlayerY, PlayerZ);
    foreach (Player, i)
    {
        if(IsPlayerInRangeOfPoint(i, MessageRange, PlayerX, PlayerY,PlayerZ))
        {
            SendClientMessage(i, Range1color, msg);
        }
        else if(IsPlayerInRangeOfPoint(i, MessageRange/2.0, PlayerX, PlayerY,PlayerZ))
        {
            SendClientMessage(i, Range2color, msg);
        }
    }
}

stock GetGunObjectID(WeaponID)
{
    if (WeaponID < 0 || WeaponID > 64)
    {
        return 1575;
    }
    return GunObjectIDs[WeaponID];
}

stock DropGun(playerid, GunID, GunAmmo, Float:X, Float:Y, Float:Z, world, interior)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid,name,sizeof(name));
    if(GunID != 0 && GunAmmo != 0)
    {
        for(new i = 0; i < sizeof(DropInfo); i++)
        {
            if(DropInfo[i][DropGunPosX] == 0.0 && DropInfo[i][DropGunPosY] == 0.0 && DropInfo[i][DropGunPosZ] == 0.0)
            {
                DropInfo[i][DropGunAmmount][0] = GunID;
                DropInfo[i][DropGunAmmount][1] = GunAmmo;
                DropInfo[i][DropGunPosX] = X;
                DropInfo[i][DropGunPosY] = Y;
                DropInfo[i][DropGunPosZ] = Z;
                DropInfo[i][DropGunVWorld] = world;
                DropInfo[i][DropGunInterior] = interior;
                DropObject[i] = CreateDynamicObject(GetGunObjectID(GunID), X, Y, Z-1, 80.0, 0.0, 0.0, world);
                return 1;
            }
        }
        return 1;
    }
    return 1;
}

stock RemovePlayerWeapon(playerid, weaponid)
{
    if(!IsPlayerConnected(playerid) || weaponid < 0 || weaponid > 50)
        return;
    new saveweapon[13], saveammo[13];
    for(new slot = 0; slot < 13; slot++)
        GetPlayerWeaponData(playerid, slot, saveweapon[slot], saveammo[slot]);
    ResetPlayerWeapons(playerid);
    for(new slot; slot < 13; slot++)
    {
        if(saveweapon[slot] == weaponid || saveammo[slot] == 0)
            continue;
        GivePlayerWeapon(playerid, saveweapon[slot], saveammo[slot]);
    }

    GivePlayerWeapon(playerid, 0, 1);

}