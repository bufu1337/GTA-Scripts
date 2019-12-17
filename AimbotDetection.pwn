//This script is designed to help admins to detect when a player is using aimbot NOTE: also works on joypad users 
//When aimbot users are detected a message will be sent to admins to spectate that player 
//It is possible to get false positives (but rare) ex: player runs away in a straight line (LOL) and gets shot by another player that never misses 
//I do not advise using kick or ban instead of the message, you don't want to punish good players do you? 
//Use this script on 0.3z servers or any servers 0.3d or higher that have no lag shooting 
//Remember to add "bodypart" to OnPlayerGiveDamage for 0.3z servers 

#include <a_samp> 
#include <foreach> 

#define red 0xFF0000AA 
//#define TEST_MOVEMENT //uncomment this line to use debug, this will send a message to all players OnPlayerUpdate if they are "IN MOTION" or "STOPPED" (returns "STOPPED" in a vehicle) 

new ammo1, 
    ammo2, 
    ammo3, 
    ammo4, 
    ammo5, 
    ammo6, 
    ammo7, 
    ammo8, 
    ammo9, 
    ammo10, 
    ammo11, 
    weapon, 
    total1A[MAX_PLAYERS], 
    total2A[MAX_PLAYERS], 
    total1B[MAX_PLAYERS], 
    total2B[MAX_PLAYERS], 
    total1C[MAX_PLAYERS], 
    total2C[MAX_PLAYERS], 
    hitsA[MAX_PLAYERS], 
    hitsB[MAX_PLAYERS], 
    hitsC[MAX_PLAYERS]; 

public OnPlayerConnect(playerid) 
{ 
    hitsA[playerid] = 0; 
    hitsB[playerid] = 0; 
    hitsC[playerid] = 0; 
    total1A[playerid] = 0; 
    total2A[playerid] = 0; 
    total1B[playerid] = 0; 
    total2B[playerid] = 0; 
    total1C[playerid] = 0; 
    total2C[playerid] = 0; 
    return 1; 
} 

public OnPlayerDisconnect(playerid, reason) 
{ 
    hitsA[playerid] = 0; 
    hitsB[playerid] = 0; 
    hitsC[playerid] = 0; 
    total1A[playerid] = 0; 
    total2A[playerid] = 0; 
    total1B[playerid] = 0; 
    total2B[playerid] = 0; 
    total1C[playerid] = 0; 
    total2C[playerid] = 0; 
    return 1; 
} 

public OnPlayerSpawn(playerid) 
{ 
    if(!IsPlayerConnected(playerid)) return 0; 
    hitsA[playerid] = 0; 
    hitsB[playerid] = 0; 
    hitsC[playerid] = 0; 
    total1A[playerid] = 0; 
    total2A[playerid] = 0; 
    total1B[playerid] = 0; 
    total2B[playerid] = 0; 
    total1C[playerid] = 0; 
    total2C[playerid] = 0; 
    return 1; 
} 

public OnPlayerDeath(playerid, killerid, reason) 
{ 
    if(!IsPlayerConnected(playerid)) return 0; 
    hitsA[playerid] = 0; 
    hitsB[playerid] = 0; 
    hitsC[playerid] = 0; 
    total1A[playerid] = 0; 
    total2A[playerid] = 0; 
    total1B[playerid] = 0; 
    total2B[playerid] = 0; 
    total1C[playerid] = 0; 
    total2C[playerid] = 0; 
    return 1; 
} 

public OnPlayerUpdate(playerid) 
{ 
    #if defined TEST_MOVEMENT 
    IsPlayerMoving(playerid); 
    #endif 
    return 1; 
} 

public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid) 
{ 
    if(!IsPlayerConnected(playerid)) return 0; 
    if(IsPlayerMoving(damagedid) && hitsA[playerid] == 0 && GetPlayerWeapon(playerid) > 15 && GetPlayerWeapon(playerid) < 28 
    || IsPlayerMoving(damagedid) && hitsA[playerid] == 0 && GetPlayerWeapon(playerid) > 32 && GetPlayerWeapon(playerid) < 35) //handguns, shotguns, snipers 
    { 
        total1A[playerid] = GetPlayerTotalAmmo(playerid); 
        hitsA[playerid] ++; 
    } 
    if(IsPlayerMoving(damagedid) && hitsA[playerid] > 0 && hitsA[playerid] < 12 && GetPlayerWeapon(playerid) > 15 && GetPlayerWeapon(playerid) < 28) 
    { 
        hitsA[playerid] ++; 
    } 
    if(hitsA[playerid] == 12) 
    { 
        total2A[playerid] = GetPlayerTotalAmmo(playerid); 
        if(total1A[playerid] - total2A[playerid] < 15 && total1A[playerid] - total2A[playerid] >= 0) 
        { 
            new name[MAX_PLAYER_NAME], string[192]; 
            GetPlayerName(playerid,name,sizeof(name)); 
            hitsA[playerid] = 0; 
            format(string, sizeof string, "{FF7D7D}[ATTENTION] {FF0000}%s {FF7D7D}id{FF0000}[%d] {FF7D7D}Needs to be spectated, {FF0000}Reason: {FF7D7D}POSSIBLE AIMBOT.", name, playerid); 
            foreach (new i : Player) 
            { 
                if(IsPlayerAdmin(i)) SendClientMessage(i,red,string); //will send to rcon admins unless you edit it for your admin script 
            } 
        } 
        else 
        { 
            hitsA[playerid] = 0; 
        } 
    } 
    if(IsPlayerMoving(damagedid) && hitsB[playerid] == 0 && GetPlayerWeapon(playerid) == 28 
    || IsPlayerMoving(damagedid) && hitsB[playerid] == 0 && GetPlayerWeapon(playerid) == 32) //tec 9 and uzi 
    { 
        total1B[playerid] = GetPlayerTotalAmmo(playerid); 
        hitsB[playerid] ++; 
    } 
    if(IsPlayerMoving(damagedid) && hitsB[playerid] > 0 && hitsB[playerid] < 26 && GetPlayerWeapon(playerid) == 28 
    || IsPlayerMoving(damagedid) && hitsB[playerid] > 0 && hitsB[playerid] < 26 && GetPlayerWeapon(playerid) == 32) 
    { 
        hitsB[playerid] ++; 
    } 
    if(hitsB[playerid] == 26) 
    { 
        total2B[playerid] = GetPlayerTotalAmmo(playerid); 
        if(total1B[playerid] - total2B[playerid] < 30 && total1B[playerid] - total2B[playerid] >= 0) 
        { 
            new name[MAX_PLAYER_NAME], string[192]; 
            GetPlayerName(playerid,name,sizeof(name)); 
            hitsB[playerid] = 0; 
            format(string, sizeof string, "{FF7D7D}[ATTENTION] {FF0000}%s {FF7D7D}id{FF0000}[%d] {FF7D7D}Needs to be spectated, {FF0000}Reason: {FF7D7D}POSSIBLE AIMBOT.", name, playerid); 
            foreach (new i : Player) 
            { 
                if(IsPlayerAdmin(i)) SendClientMessage(i,red,string); //will send to rcon admins unless you edit it for your admin script 
            } 
        } 
        else 
        { 
            hitsB[playerid] = 0; 
        } 
    } 
    if(IsPlayerMoving(damagedid) && hitsC[playerid] == 0 && GetPlayerWeapon(playerid) > 28 && GetPlayerWeapon(playerid) < 32) //MP5, AK47, M4 
    { 
        total1C[playerid] = GetPlayerTotalAmmo(playerid); 
        hitsC[playerid] ++; 
    } 
    if(IsPlayerMoving(damagedid) && hitsC[playerid] > 0 && hitsC[playerid] < 20 && GetPlayerWeapon(playerid) > 28 && GetPlayerWeapon(playerid) < 32) 
    { 
        hitsC[playerid] ++; 
    } 
    if(hitsC[playerid] == 20) 
    { 
        total2C[playerid] = GetPlayerTotalAmmo(playerid); 
        if(total1C[playerid] - total2C[playerid] < 23 && total1C[playerid] - total2C[playerid] >= 0) 
        { 
            new name[MAX_PLAYER_NAME], string[192]; 
            GetPlayerName(playerid,name,sizeof(name)); 
            hitsC[playerid] = 0; 
               format(string, sizeof string, "{FF7D7D}[ATTENTION] {FF0000}%s {FF7D7D}id{FF0000}[%d] {FF7D7D}Needs to be spectated, {FF0000}Reason: {FF7D7D}POSSIBLE AIMBOT.", name, playerid); 
            foreach (new i : Player) 
            { 
                if(IsPlayerAdmin(i)) SendClientMessage(i,red,string); //will send to rcon admins unless you edit it for your admin script 
            } 
        } 
        else 
        { 
            hitsC[playerid] = 0; 
        } 
    } 
    return 1; 
} 

stock IsPlayerMoving(playerid) 
{ 
    new Float:Velocity[3]; 
    GetPlayerVelocity(playerid, Velocity[0], Velocity[1], Velocity[2]); 
    if(Velocity[0] >= 0.02 
    || Velocity[1] >= 0.02 
    || Velocity[2] >= 0.02 
    || Velocity[0] <= -0.02 
    || Velocity[1] <= -0.02 //set at 0.02 and -0.02 will detect any on foot movement faster than standing on an escalator 
    || Velocity[2] <= -0.02) //set at 0.07 and -0.07 will detect any on foot movement faster than walking or strafing (running) 
     { 
         #if defined TEST_MOVEMENT 
         SendClientMessage(playerid, -1, "IN MOTION"); 
         #endif 
         return true; 
    } 
    else 
    { 
        #if defined TEST_MOVEMENT 
        SendClientMessage(playerid, red, "STOPPED"); 
        #endif 
        return false; 
    } 
} 

stock GetPlayerTotalAmmo(playerid) //fist and melee weaps excluded 
{ 
    new totalammo; 
    GetPlayerWeaponData(playerid, 2, weapon, ammo1); 
    GetPlayerWeaponData(playerid, 3, weapon, ammo2); 
    GetPlayerWeaponData(playerid, 4, weapon, ammo3); 
    GetPlayerWeaponData(playerid, 5, weapon, ammo4); 
    GetPlayerWeaponData(playerid, 6, weapon, ammo5); 
    GetPlayerWeaponData(playerid, 7, weapon, ammo6); 
    GetPlayerWeaponData(playerid, 8, weapon, ammo7); 
    GetPlayerWeaponData(playerid, 9, weapon, ammo8); 
    GetPlayerWeaponData(playerid, 11, weapon, ammo9); 
    GetPlayerWeaponData(playerid, 12, weapon, ammo10); 
    GetPlayerWeaponData(playerid, 13, weapon, ammo11); 
    totalammo = ammo1+ammo2+ammo3+ammo4+ammo5+ammo6+ammo7+ammo8+ammo9+ammo10+ammo11; 
    return totalammo; 
}  