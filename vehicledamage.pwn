/*
//DamageMe! (Damage - Explode a Vehicle without a driver being on it)
//Creator: PaNoULiS
//Issue Date: 23/11/10
//Version: 1.0
*/
#include <a_samp>
//------------------------------------------------------------------------------
new Float:OldHealth[MAX_PLAYERS];
new Float:OldArmour[MAX_PLAYERS];
new Float:OldVHealth[MAX_VEHICLES];
new Float:OldPos[MAX_VEHICLES][3];
new ShotBy[MAX_PLAYERS];
new ShotWeapon[MAX_PLAYERS];
new OnOff[MAX_PLAYERS];
new VShotBy[MAX_VEHICLES];
new VShotWeapon[MAX_VEHICLES];
new VOnOff[MAX_VEHICLES];
new VTick[MAX_VEHICLES];
new VehicleCheckTimer;
new NoDamage;
//------------------------------------------------------------------------------
forward OnPlayerShootVehicle(playerid, vehicleid, unoccupied, weaponid, Float:heathlost);
forward OnPlayerShootPlayer(playerid, victimid, weaponid, Float:heathlost, Float:armourlost);
forward VehicleCheck();
//------------------------------------------------------------------------------
IsPlayerAimingAtPlayer(playerid, aimid)
{
	new Float:X1, Float:Y1, Float:Z1, Float:X2, Float:Y2, Float:Z2;
	GetPlayerPos(playerid, X1, Y1, Z1);
	GetPlayerPos(aimid, X2, Y2, Z2);
	new Float:Distance = floatsqroot(floatpower(floatabs(X1-X2), 2) + floatpower(floatabs(Y1-Y2), 2));
	if(Distance < 100)
	{
		new Float:A;
		GetPlayerFacingAngle(playerid, A);
		X1 += (Distance * floatsin(-A, degrees));
		Y1 += (Distance * floatcos(-A, degrees));
	    Distance = floatsqroot(floatpower(floatabs(X1-X2), 2) + floatpower(floatabs(Y1-Y2), 2));
		if(Distance < 1.0)
		{
	    	return true;
		}
	}
	return false;
}
//------------------------------------------------------------------------------
IsPlayerAimingAtVehicle(playerid, aimid)
{
    new Float:X1, Float:Y1, Float:Z1, Float:X2, Float:Y2, Float:Z2;
	GetPlayerPos(playerid, X1, Y1, Z1);
    GetVehiclePos(aimid, X2, Y2, Z2);
	new Float:Distance = floatsqroot(floatpower(floatabs(X1-X2), 2) + floatpower(floatabs(Y1-Y2), 2));
	if(Distance < 100)
	{
		new Float:A;
		GetPlayerFacingAngle(playerid, A);
		X1 += (Distance * floatsin(-A, degrees));
		Y1 += (Distance * floatcos(-A, degrees));
	    Distance = floatsqroot(floatpower(floatabs(X1-X2), 2) + floatpower(floatabs(Y1-Y2), 2));
		if(Distance < 1.0)
		{
	    	return true;
		}
	}
	return false;
}
//------------------------------------------------------------------------------
stock WeaponCanFire(weaponid)
{
	if(weaponid < 22 || weaponid == 37 || weaponid > 38)
	{
	    return 0;
	}
	return 1;
}
//------------------------------------------------------------------------------
stock WeaponNeedsAimToFire(weaponid)
{
	if(weaponid == 34 || weaponid == 35 || weaponid == 36)
	{
	    return 1;
	}
	return 0;
}
//------------------------------------------------------------------------------
stock GetWeaponSlot(weaponid)
{
	if(weaponid == 0 || weaponid == 1)
	{
	    return 0;
	}
	if(weaponid > 1 && weaponid < 10)
	{
	    return 1;
	}
	if(weaponid > 9 && weaponid < 16)
	{
	    return 10;
	}
	if(weaponid > 15 && weaponid < 22)
	{
	    return 8;
	}
	if(weaponid > 18 && weaponid < 25)
	{
	    return 2;
	}
	if(weaponid > 24 && weaponid < 28)
	{
	    return 3;
	}
	if(weaponid > 27 && weaponid < 30 || weaponid == 32)
	{
	    return 4;
	}
	if(weaponid > 29 && weaponid < 32)
	{
	    return 5;
	}
	if(weaponid > 32 && weaponid < 35)
	{
	    return 6;
	}
	if(weaponid > 34 && weaponid < 39)
	{
	    return 7;
	}
	if(weaponid == 39)
	{
	    return 8;
	}
	if(weaponid == 40)
	{
	    return 12;
	}
	if(weaponid > 40 && weaponid < 44)
	{
	    return 9;
	}
	if(weaponid > 42 && weaponid < 47)
	{
	    return 11;
	}
	return 0;
}
//------------------------------------------------------------------------------
// Taken from weapon.dat (GTASAROOT/data/weapon.dat)
stock GetWeaponDamage(weaponid)
{
	switch(weaponid)
	{
	case 22: // 9MM
	    return 25;
    case 23: // Silenced 9MM
	    return 40;
	case 24: // Deagle
	    return 140;
	case 25: // Shotgun
	    return 10;
	case 26: // Sawn Off Shotgun
	    return 10;
	case 27: // Spaz 12
	    return 15;
	case 28: // Micro UZI
	    return 20;
    case 29: // MP5
	    return 30;
	case 30: // AK-47
	    return 30;
	case 31: // M4
	    return 30;
	case 32: // Tec9
	    return 20;
	case 33: // Country Rifle
	    return 75;
	case 34: // Sniper Rifle
	    return 125;
	case 35: // Rocket Launcher
	    return 75;
	case 36: // HS Rocket Launcher
	    return 75;
	case 37: // Flamethrower
	    return 25;
	case 38: // Minigun
		return 140;
	case 39: // Satchel Charge
	    return 75;
	case 41: // Spraycan
	    return 1;
	case 42: // Fire Extinguisher
	    return 1;
	}
	return 0;
}
//------------------------------------------------------------------------------
stock IsAkimboWeapon(weaponid)
{
	if(weaponid == 22 || weaponid == 26)
	{
	    return 1;
	}
	return 0;
}
//------------------------------------------------------------------------------
stock DoesVehicleExist(vehicleid)
{
	if(GetVehicleModel(vehicleid))
	{
	    return 1;
	}
	return 0;
}
//------------------------------------------------------------------------------
stock IsVehicleSynced(vehicleid)
{
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerInVehicle(i, vehicleid) && GetPlayerState(i) == PLAYER_STATE_DRIVER)
	    {
	        return 1;
	    }
	}
	return 0;
}
//------------------------------------------------------------------------------
stock CanRecieveDebugMessages(playerid)//Used Only for Debug (DON'T Disable that, just your names)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	/*if(!strcmp(name, "PaNoULiS", true))
	{
	    return 1;
	}
	if(!strcmp(name, "Dean_Hurley", true))
	{
	    return 1;
	}*/
	return 0;
}
//------------------------------------------------------------------------------
public OnFilterScriptInit()
{
	VehicleCheckTimer = SetTimer("VehicleCheck", 250, 1); //Default should be 250.
	for(new i; i < MAX_PLAYERS; i++)
	{
	    ShotBy[i] = INVALID_PLAYER_ID;
	}
	for(new i; i < MAX_VEHICLES; i++)
	{
	    VShotBy[i] = INVALID_PLAYER_ID;
	}
	return 1;
}
//------------------------------------------------------------------------------
public OnFilterScriptExit()
{
	KillTimer(VehicleCheckTimer);
	return 1;
}
//------------------------------------------------------------------------------
stock SendDebugMessage(message[])
{
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(CanRecieveDebugMessages(i))
	    {
	        SendClientMessage(i, 0xFF6347AA, message);
	    }
	}
}
//------------------------------------------------------------------------------
public OnPlayerShootVehicle(playerid, vehicleid, unoccupied, weaponid, Float:heathlost)
{
	new str[80];
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	format(str, sizeof(str), "Player %s Shot Vehicle %d (%d, %d)", name, vehicleid, unoccupied, weaponid);
    SendDebugMessage(str);
	if(!NoDamage)
    {
		return 1;
	}
	return 0;
}
//------------------------------------------------------------------------------
public OnPlayerShootPlayer(playerid, victimid, weaponid, Float:heathlost, Float:armourlost)
{
    new str[80];
	new name[MAX_PLAYER_NAME];
	new name2[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	GetPlayerName(victimid, name2, sizeof(name2));
	format(str, sizeof(str), "Player %s Shot Player %s (%d)", name, name2, weaponid);
    SendDebugMessage(str);
    if(!NoDamage)
    {
		return 1;
	}
	return 0;
}
//------------------------------------------------------------------------------
#define BLOW
public VehicleCheck()
{
    new Float:Health;
    new Float:Pos[3];
	for(new i; i < MAX_VEHICLES; i++)
	{
	    if(VTick[i] > 0)
        {
            #if defined BLOW
            if((GetTickCount() - VTick[i]) >= 16000) // 16 seconds since the vehicle got set on fire.
			#else
			if((GetTickCount() - VTick[i]) >= 60000) // 60 seconds since the vehicle got set smoking.
			#endif
			{
			    if(!IsVehicleSynced(i))
			    {
					CallLocalFunction("OnVehicleDeath", "ii", i, VShotBy[i]);
					VShotBy[i] = INVALID_PLAYER_ID;
					SetVehicleToRespawn(i);
	               	VTick[i] = 0;
               	}
			}
    	}
    	else
	    {
	        if(DoesVehicleExist(i) && VShotBy[i] != INVALID_PLAYER_ID)
            {
			    if(IsVehicleSynced(i))
			    {
					if(GetVehicleHealth(i, Health))
					{
					    if(Health < OldVHealth[i])
					    {
							if(!OnPlayerShootVehicle(VShotBy[i], i, 0, VShotWeapon[i], (OldVHealth[i] - Health)))
							{
							    SetVehicleHealth(i, OldVHealth[i]);
							}
					        VShotBy[i] = INVALID_PLAYER_ID;
					    }
						OldVHealth[i] = Health;
					}
				}
				else
				{
				    if(GetVehiclePos(i, Pos[0], Pos[1], Pos[2]))
				    {
				        if(Pos[0] != OldPos[i][0] || Pos[1] != OldPos[i][1] || Pos[2] != OldPos[i][2])
				        {
							GetVehicleHealth(i, Health);
							new Damage;
							new Float:DamageHealth;
							if(Health > 0)
							{
							    Damage = GetWeaponDamage(VShotWeapon[i]);
							    new Float:NewHealth = (Health - Damage);
							    #if defined NOWBLOW
							    if(NewHealth < 400)
							    {
							        DamageHealth = 400;
							        VTick[i] = GetTickCount();
							    }
							    else
							    #endif
							    {
							        #if defined BLOW
								    if(NewHealth < 250)
								    {
								    	if(NewHealth < 0)
								    	{
								    	    DamageHealth = 0;
										}
										else
										{
										    DamageHealth = NewHealth;
										}
										VTick[i] = GetTickCount();
									}
									else
									{
									    DamageHealth = NewHealth;
									}
									#else
									DamageHealth = NewHealth;
									#endif
								}
							}
							if(OnPlayerShootVehicle(VShotBy[i], i, 1, VShotWeapon[i], Damage))
							{
							    SetVehicleHealth(i, DamageHealth);
							}
							VShotBy[i] = INVALID_PLAYER_ID;
				        }
				        OldPos[i][0] = Pos[0];
				        OldPos[i][1] = Pos[1];
				        OldPos[i][2] = Pos[2];
				    }
				}
				if(VShotBy[i] != INVALID_PLAYER_ID && !VOnOff[i])
				{
					VShotBy[i] = INVALID_PLAYER_ID;
				}
				if(VOnOff[i])
				{
	   				VOnOff[i] = 0;
				}
			}
		}
	}
	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerDeath(playerid, killerid, reason)
{
	ShotBy[playerid] = INVALID_PLAYER_ID;
	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerUpdate(playerid)
{
    new Float:Health, Float:Armour;
	GetPlayerHealth(playerid, Health);
	GetPlayerArmour(playerid, Armour);
	if(Health < OldHealth[playerid] || Armour < OldArmour[playerid])
	{
		if(ShotBy[playerid] != INVALID_PLAYER_ID)
		{
		    new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, sizeof(name));
			if(!OnPlayerShootPlayer(ShotBy[playerid], playerid, ShotWeapon[playerid], (OldHealth[playerid] - Health), (OldArmour[playerid] - Armour)))
			{
			    SetPlayerHealth(playerid, OldHealth[playerid]);
			    SetPlayerArmour(playerid, OldArmour[playerid]);
			}
   			ShotBy[playerid] = INVALID_PLAYER_ID;
		}
	}
	if(ShotBy[playerid] != INVALID_PLAYER_ID && !OnOff[playerid])
	{
		ShotBy[playerid] = INVALID_PLAYER_ID;
	}
	if(OnOff[playerid])
	{
	    OnOff[playerid] = 0;
	}
	OldHealth[playerid] = Health;
	OldArmour[playerid] = Armour;
	new weapon = GetPlayerWeapon(playerid);
	if(WeaponCanFire(weapon))
	{
		new udAnalog;
		new lrAnalog;
		new wKeys;
		GetPlayerKeys(playerid, wKeys, udAnalog, lrAnalog);
		if(wKeys & KEY_FIRE)
		{
	        if(WeaponNeedsAimToFire(weapon) && !(wKeys & KEY_HANDBRAKE))
	        {
	            return 1;
	        }
 		    for(new i; i < MAX_PLAYERS; i++)
 			{
    			if(i != playerid && IsPlayerConnected(i) && IsPlayerAimingAtPlayer(playerid, i))
			    {
					if(CanRecieveDebugMessages(playerid))
					{
					    new str[80];
					    new name[MAX_PLAYER_NAME];
					    GetPlayerName(i, name, sizeof(name));
					    format(str, sizeof(str), "You are firing at player %s.", name);
					    SendClientMessage(playerid, 0xFF6347AA, str);
					}
			    	ShotBy[i] = playerid;
			    	ShotWeapon[i] = weapon;
			    	OnOff[i] = 1;
				}
			}
			for(new i; i < MAX_VEHICLES; i++)
			{
				if(DoesVehicleExist(i) && IsPlayerAimingAtVehicle(playerid, i))
				{
				    if(CanRecieveDebugMessages(playerid))
					{
					    new str[80];
					    format(str, sizeof(str), "You are firing at Vehicle %d.", i);
					    SendClientMessage(playerid, 0xFF6347AA, str);
					}
				    VShotBy[i] = playerid;
				    VShotWeapon[i] = weapon;
				    VOnOff[i] = 1;
				}
			}
		}
	}
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp(cmdtext, "/keys", true))
	{
        new str[80];
		new udAnalog;
		new lrAnalog;
		new wKeys;
		GetPlayerKeys(playerid, udAnalog, lrAnalog, wKeys);
		format(str, sizeof(str), "Keys(%d, %d, %d).", udAnalog, lrAnalog, wKeys);
		SendClientMessage(playerid, 0xFF6347AA, str);
		return 1;
	}
	if(!strcmp(cmdtext, "/nodamage", true))
	{
	    NoDamage = !NoDamage;
	    new str[80];
		format(str, sizeof(str), "NoDamage set to %d.", NoDamage);
		SendClientMessage(playerid, 0xFF6347AA, str);
	    return 1;
	}
	return 0;
}