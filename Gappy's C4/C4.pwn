#include <a_samp>

new BombPrice = 1000; //Price
new ExplosionRadius = 15; //Explosion Radius

#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_GREY 0xBFC0C2FF

forward Explode(playerid);

new C4[MAX_PLAYERS];
new Bomb[MAX_PLAYERS];
new Planted[MAX_PLAYERS];
new Float:bx[MAX_PLAYERS], Float:by[MAX_PLAYERS], Float:bz[MAX_PLAYERS];
new Pspawned[MAX_PLAYERS];


PreloadAnimLib(playerid, animlib[])
{
        ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0);
}

RemovePlayerWeapon(playerid, weaponid) //Credits to whoever made this
{
	if(!IsPlayerConnected(playerid) || weaponid < 0 || weaponid > 50)
	    return;

	new
	    saveweapon[13],
	    saveammo[13];

	// Probably could be done using one loop
	for(new slot = 0; slot < 13; slot++)
	    GetPlayerWeaponData(playerid, slot, saveweapon[slot], saveammo[slot]);

	ResetPlayerWeapons(playerid);

	for(new slot; slot < 13; slot++)
	{
		if(saveweapon[slot] == weaponid || saveammo[slot] == 0)
			continue;

		GivePlayerWeapon(playerid, saveweapon[slot], saveammo[slot]);
	}

	// give them weapon ID 0 to reset the current armed weapon
	// to a fist and not the last weapon in their inventory
	GivePlayerWeapon(playerid, 0, 1);

}

public OnFilterScriptInit()
{
	print("\n ____  _  _   ");
	print("|  __|| || |  ");
	print("| |   | || |_ ");
	print("| |__ |__   _|");
	print("|____|   |_|  ");
	print("By Gappy\n");
	return 1;
}

public OnPlayerConnect(playerid)
{
	Pspawned[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    if(Planted[playerid] == 1)
	{
	    DestroyObject(C4[playerid]);
	    Bomb[playerid] = 0;
	    Planted[playerid] = 0;
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
    PreloadAnimLib(playerid, "BOMBER");
    PreloadAnimLib(playerid, "PED");
	Pspawned[playerid] = 1;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(Planted[playerid] == 1)
	{
	    DestroyObject(C4[playerid]);
	    Bomb[playerid] = 0;
	    Planted[playerid] = 0;
	}
	Pspawned[playerid] = 0;
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if (strcmp("/plantbomb", cmdtext, true, 10) == 0)
	{
	    if (Pspawned[playerid] == 1)
	    {
	        if (Bomb[playerid] == 1)
	        {
		        if (GetPlayerState(playerid) != 2)
		        {
				    GetPlayerPos(playerid, bx[playerid], by[playerid], bz[playerid]);
					C4[playerid] = CreateObject(1252, bx[playerid], by[playerid], bz[playerid]-1, -87.6624853592, 0.000000, 0.000000);
					Planted[playerid] = 1;
					ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0,0,0,0,0,1000);
					SendClientMessage(playerid,COLOR_YELLOW,"Bomb Planted, Press jump to detonate it.");
					return 1;
				} else SendClientMessage(playerid,COLOR_GREY,"You cannot plant a bomb in a car");
			} else SendClientMessage(playerid,COLOR_GREY,"You don't have a bomb");
		} else SendClientMessage(playerid,COLOR_GREY,"You must spawn before planting a bomb");
		return 1;
	}
	if (strcmp("/buybomb", cmdtext, true, 10) == 0)
	{
	    if(GetPlayerMoney(playerid) >=BombPrice)
	    {
	        if(Bomb[playerid] == 0)
	        {
		        GivePlayerMoney(playerid, -BombPrice);
		        Bomb[playerid] = 1;
		        SendClientMessage(playerid,COLOR_YELLOW,"You just bought one bomb");
			} else SendClientMessage(playerid,COLOR_GREY,"You already have a bomb, you can only have one at a time");
		} else SendClientMessage(playerid,COLOR_GREY,"You don't have enough money");
		return 1;
	}
    return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_JUMP)
    {
        if(Planted[playerid] == 1)
        {
            GivePlayerWeapon(playerid, 40, 1);
            ClearAnimations(playerid);
            ApplyAnimation(playerid,"PED","bomber",4.0,0,0,0,0,1000);
            SetTimerEx("Explode", 1200, 0, "i", playerid);
            return 1;
		}
	}
	return 1;
}

public Explode(playerid)
{
    DestroyObject(C4[playerid]);
    CreateExplosion(bx[playerid], by[playerid], bz[playerid], 6, ExplosionRadius);
    GameTextForPlayer(playerid, "~R~Bomb Detonated", 2000, 3);
    Bomb[playerid] = 0;
    Planted[playerid] = 0;
    RemovePlayerWeapon(playerid, 40);
    return 1;
}
