/*

» Credits «

• Script: Anti-Lead v0.1
• Author: Matz
• Forum: http://forum.sa-mp.com/member.php?u=125232
• Topic: http://forum.sa-mp.com/showthread.php?t=417368
• Please do not remove credits.

*/

#include <a_samp>

new lasthit[MAX_PLAYERS];

public OnFilterScriptInit()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    SetPlayerTeam(i, 0);
 	}
	return 1;
}

public OnFilterScriptExit()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    SetPlayerTeam(i, -1);
 	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	SetPlayerTeam(playerid, 0);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    lasthit[playerid] = -1;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(lasthit[playerid] == -1)
	{
	    SendDeathMessage(INVALID_PLAYER_ID, playerid, reason);
	    return 1;
	}
	if(lasthit[playerid] != -1)
 	{
 	    SendDeathMessage(lasthit[playerid],playerid,GetPlayerWeapon(lasthit[playerid]));
 	    return 1;
 	}
 	lasthit[playerid] = -1;
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid)
{
	if(damagedid != INVALID_PLAYER_ID)
	{
	    /*Weapon Damage Sync*/
		if(weaponid == 24 || weaponid == 25 || weaponid == 26 || weaponid == 27 || weaponid == 33 || weaponid == 34 || weaponid == 38)
  		{
   			new tmp; tmp=random(48); // 1/3 Change
			switch(tmp)
			{
 				case 0:  { ApplyAnimation(damagedid,"PED","DAM_armL_frmBK",4.0,0,0,0,1,1); }
		 		case 1:  { }
		 		case 2:  { }
		 		case 3:  { ApplyAnimation(damagedid,"PED","DAM_armR_frmBK",4.0,0,0,0,1,1); }
		 		case 4:  { }
		 		case 5:  { }
		 		case 6:  { ApplyAnimation(damagedid,"PED","DAM_LegL_frmBK",4.0,0,0,0,1,1); }
		 		case 7:  { }
		 		case 8:  { }
		 		case 9:  { ApplyAnimation(damagedid,"PED","DAM_LegR_frmBK",4.0,0,0,0,1,1); }
		 		case 10: { }
		 		case 11: { }
		 		case 12: { ApplyAnimation(damagedid,"PED","DAM_stomach_frmBK",4.0,0,0,0,1,1); }
		 		case 13: { }
		 		case 14: { }
		 		case 15: { ApplyAnimation(damagedid,"PED","DAM_stomach_frmRT",4.0,0,0,0,1,1); }
		 		case 16: { }
		 		case 17: { }
		 		case 18: { ApplyAnimation(damagedid,"PED","DAM_armL_frmFT",4.0,0,0,0,1,1); }
		 		case 19: { }
		 		case 20: { }
		 		case 21: { ApplyAnimation(damagedid,"PED","DAM_armL_frmLT",4.0,0,0,0,1,1); }
		 		case 22: { }
		 		case 23: { }
		 		case 24: { ApplyAnimation(damagedid,"PED","DAM_LegL_frmFT",4.0,0,0,0,1,1); }
		 		case 25: { }
		 		case 26: { }
		 		case 27: { ApplyAnimation(damagedid,"PED","DAM_LegR_frmFT",4.0,0,0,0,1,1); }
		 		case 28: { }
		 		case 29: { }
		 		case 30: { ApplyAnimation(damagedid,"PED","DAM_LegL_frmLT",4.0,0,0,0,1,1); }
		 		case 31: { }
		 		case 32: { }
		 		case 33: { ApplyAnimation(damagedid,"PED","DAM_LegR_frmRT",4.0,0,0,0,1,1); }
		 		case 34: { }
		 		case 35: { }
		 		case 36: { ApplyAnimation(damagedid,"PED","DAM_stomach_frmFT",4.0,0,0,0,1,1); }
		 		case 37: { }
		 		case 38: { }
		 		case 39: { ApplyAnimation(damagedid,"PED","DAM_armR_frmFT",4.0,0,0,0,1,1); }
		 		case 40: { }
		 		case 41: { }
		 		case 42: { ApplyAnimation(damagedid,"PED","DAM_armR_frmRT",4.0,0,0,0,1,1); }
		 		case 43: { }
		 		case 44: { }
		 		case 45: { ApplyAnimation(damagedid,"PED","DAM_stomach_frmLT",4.0,0,0,0,1,1); }
		 		case 46: { }
		 		case 47: { }
			}
			//return 1;
		}
		//Do not use for now (Buggy)
		/*if(weaponid == 0 || weaponid == 1 || weaponid == 2 || weaponid == 3 || weaponid == 4 || weaponid == 5 || weaponid == 6 || weaponid == 7 || weaponid == 8 || weaponid == 9 || weaponid == 10 || weaponid == 11 || weaponid == 12 || weaponid == 13 || weaponid == 14 || weaponid == 15)
  		{
			new tmp; tmp=random(10);
			switch(tmp)
			{
			    case 0: { ApplyAnimation(damagedid,"PED","HitA_1",4.0,0,0,0,1,1); }
			    case 1: { ApplyAnimation(damagedid,"PED","HitA_2",4.0,0,0,0,1,1); }
			    case 2: { ApplyAnimation(damagedid,"PED","HitA_3",4.0,0,0,0,1,1); }
			    case 3: { ApplyAnimation(damagedid,"PED","HIT_back",4.0,0,0,0,1,1); }
			    case 4: { ApplyAnimation(damagedid,"PED","HIT_behind",4.0,0,0,0,1,1); }
			    case 5: { ApplyAnimation(damagedid,"PED","HIT_front",4.0,0,0,0,1,1); }
			    case 6: { ApplyAnimation(damagedid,"PED","HIT_GUN_BUTT",4.0,0,0,0,1,1); }
			    case 7: { ApplyAnimation(damagedid,"PED","HIT_L",4.0,0,0,0,1,1); }
			    case 8: { ApplyAnimation(damagedid,"PED","HIT_R",4.0,0,0,0,1,1); }
			    case 9: { ApplyAnimation(damagedid,"PED","HIT_walk",4.0,0,0,0,1,1); }
			}
			//return 1;
		}*/
	    /*Hit Calculates*/
		new Float:armour; GetPlayerArmour(damagedid,armour);
		if(armour < 1)
		{
			new Float:health; GetPlayerHealth(damagedid, health);
			SetPlayerHealth(damagedid,health-amount);
			lasthit[damagedid] = playerid;
			return 1;
		}
		if(armour > 0)
		{
		    if(armour < amount)
		    {
		        new Float:health; GetPlayerHealth(damagedid, health);
		        new Float:value = amount-armour;
				SetPlayerArmour(damagedid,0);
				SetPlayerHealth(damagedid,health-value);
				lasthit[damagedid] = playerid;
				return 1;
			}
			if(armour > amount)
		    {
				SetPlayerArmour(damagedid,armour-amount);
				lasthit[damagedid] = playerid;
				return 1;
			}
			return 1;
		}
		return 1;
	}
	return 1;
}
