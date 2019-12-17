/*____________________________
---Coolbacks Version 0.1
---Created by DragSta
---Copyright (c) DragSta 2007
  ____________________________*/


#if defined _coolbacks_included
	#endinput
#endif
#define _coolbacks_included
#pragma library coolbacks

//system Natives
/*
native StartSystem();
native SetInterval(interval);
native StopSystem();
*/

//System Defines/declarations/etc...

#define MAXPLAYERS 200
new Timerz[20];

new Check_Interval = 300;

enum NewData
{
	WantLvl,
	Float:HealthLvl,
	Float:ArmourLvl,
	Money,
	Float:X,
	Float:Y,
	Float:Z,
	Ammo,
	Action,
	Skin,
	Score,
	Team
}
new NewDatas[MAXPLAYERS][NewData];

enum OldData
{
	WantLvl,
	Float:HealthLvl,
	Float:ArmourLvl,
	Money,
	Float:X,
	Float:Y,
	Float:Z,
	Ammo,
	Action,
	Skin,
	Score,
	Team
}
new OldDatas[MAXPLAYERS][OldData];

//System Forwards
forward WantedLevelCheck();
forward PlayerHealthCheckZ();
forward PlayerArmourCheckX();
forward PlayerMoneyCheckY();
forward PlayerPosCheckT();
forward PlayerAmmoCheckR();
forward PlayerSkinCheckY();
forward PlayerSpecialActionCheck();
forward PlayerScoreCheckT();
forward PlayerTeamCheckX();
forward OnPlayerWantedLevelChange(playerid, oldlevel, newlevel);
forward OnPlayerHealthChange(playerid, Float:oldhealth, Float:newhealth);
forward OnPlayerArmourChange(playerid, Float:oldarmour, Float:newarmour);
forward OnPlayerMoneyChange(playerid, oldmoney, newmoney);
forward OnPlayerPosChange(playerid, Float:oldx, Float:oldy, Float:oldz, Float:newx, Float:newy, Float:newz);
forward OnPlayerAmmoChange(playerid, weaponid, oldammo, newammo);
forward OnPlayerSpecialActionChange(playerid, oldaction, newaction);
forward OnPlayerSkinChange(playerid, oldskin, newskin);
forward OnPlayerScoreChange(playerid, oldscore, newscore);
forward OnPlayerTeamChange(playerid, oldteam, newteam);

//System Functions
StartSystem()
{
	Timerz[0] = SetTimer("WantedLevelCheck", Check_Interval, 1);
	Timerz[1] = SetTimer("PlayerHealthCheckZ", Check_Interval+1, 1);
	Timerz[2] = SetTimer("PlayerArmourCheckX", Check_Interval+2, 1);
	Timerz[3] = SetTimer("PlayerMoneyCheckY", Check_Interval+3, 1);
	Timerz[4] = SetTimer("PlayerPosCheckT", Check_Interval+4, 1);
	Timerz[5] = SetTimer("PlayerAmmoCheckR", Check_Interval+5, 1);
	Timerz[6] = SetTimer("PlayerSpecialActionCheck", Check_Interval+6, 1);
	Timerz[7] = SetTimer("PlayerSkinCheckY", Check_Interval+7, 1);
	Timerz[8] = SetTimer("PlayerScoreCheckT", Check_Interval+8, 1);
	Timerz[9] = SetTimer("PlayerTeamCheckX", Check_Interval+9, 1);
}

#pragma unused StopSystem
StopSystem()
{
	KillTimer(Timerz[0]);
	KillTimer(Timerz[1]);
	KillTimer(Timerz[2]);
	KillTimer(Timerz[3]);
	KillTimer(Timerz[4]);
	KillTimer(Timerz[5]);
	KillTimer(Timerz[6]);
	KillTimer(Timerz[7]);
	KillTimer(Timerz[8]);
}

#pragma unused SetInterval
SetInterval(interval)
{
	Check_Interval = interval;
	return 1;
}

public WantedLevelCheck()
{
    for(new Pl; Pl < MAXPLAYERS; Pl++)
    {
  		NewDatas[Pl][WantLvl] = GetPlayerWantedLevel(Pl);
		if(OldDatas[Pl][WantLvl] != NewDatas[Pl][WantLvl])
  		{
		    OnPlayerWantedLevelChange(Pl, OldDatas[Pl][WantLvl], NewDatas[Pl][WantLvl]);
            OldDatas[Pl][WantLvl] = GetPlayerWantedLevel(Pl);
  		}
    }
}

public PlayerHealthCheckZ()
{
    for(new Pl; Pl < MAXPLAYERS; Pl++)
    {
    	GetPlayerHealth(Pl, NewDatas[Pl][HealthLvl]);
		if(OldDatas[Pl][HealthLvl] != NewDatas[Pl][HealthLvl])
		{
		    OnPlayerHealthChange(Pl, OldDatas[Pl][HealthLvl], NewDatas[Pl][HealthLvl]);
            GetPlayerHealth(Pl, NewDatas[Pl][HealthLvl]);
		}
    }
}

public PlayerArmourCheckX()
{
    for(new Pl; Pl < MAXPLAYERS; Pl++)
    {
    	GetPlayerArmour(Pl, NewDatas[Pl][ArmourLvl]);
		if(OldDatas[Pl][ArmourLvl] != NewDatas[Pl][ArmourLvl])
		{
		    OnPlayerArmourChange(Pl, OldDatas[Pl][ArmourLvl], NewDatas[Pl][ArmourLvl]);
            GetPlayerArmour(Pl, OldDatas[Pl][ArmourLvl]);
		}
    }
}

public PlayerMoneyCheckY()
{
    for(new Pl; Pl < MAXPLAYERS; Pl++)
    {
    	NewDatas[Pl][Money] = GetPlayerMoney(Pl);
		if(OldDatas[Pl][Money] != NewDatas[Pl][Money])
		{
		    OnPlayerMoneyChange(Pl, OldDatas[Pl][Money], NewDatas[Pl][Money]);
	 		OldDatas[Pl][Money] = GetPlayerMoney(Pl);
		}
    }
}

public PlayerPosCheckT()
{
    for(new Pl; Pl < MAXPLAYERS; Pl++)
    {
    	GetPlayerPos(Pl, NewDatas[Pl][X], NewDatas[Pl][Y], NewDatas[Pl][Z]);
		if(OldDatas[Pl][X] != NewDatas[Pl][X] || OldDatas[Pl][Y] != NewDatas[Pl][Y] || OldDatas[Pl][Z] != NewDatas[Pl][Z])
		{
		    OnPlayerPosChange(Pl, OldDatas[Pl][X], OldDatas[Pl][Y], OldDatas[Pl][Z], NewDatas[Pl][X], NewDatas[Pl][Y], NewDatas[Pl][Z]);
		    GetPlayerPos(Pl, OldDatas[Pl][X], OldDatas[Pl][Y], OldDatas[Pl][Z]);
		}
    }
}

public PlayerAmmoCheckR()
{
    for(new Pl; Pl < MAXPLAYERS; Pl++)
    {
    	NewDatas[Pl][Ammo] = GetPlayerAmmo(Pl);
		if(OldDatas[Pl][Ammo] != NewDatas[Pl][Ammo])
		{
		    OnPlayerAmmoChange(Pl, GetPlayerWeapon(Pl), OldDatas[Pl][Ammo], NewDatas[Pl][Ammo]);
		    OldDatas[Pl][Ammo] = GetPlayerAmmo(Pl);
		}
    }
}

public PlayerSpecialActionCheck()
{
    for(new Pl; Pl < MAXPLAYERS; Pl++)
    {
    	NewDatas[Pl][Action] = GetPlayerSpecialAction(Pl);
		if(OldDatas[Pl][Action] != NewDatas[Pl][Action])
		{
		    OnPlayerSpecialActionChange(Pl, OldDatas[Pl][Action], NewDatas[Pl][Action]);
		    OldDatas[Pl][Action] = GetPlayerSpecialAction(Pl);
		}
    }
}

public PlayerSkinCheckY()
{
    for(new Pl; Pl < MAXPLAYERS; Pl++)
    {
    	NewDatas[Pl][Skin] = GetPlayerSkin(Pl);
		if(OldDatas[Pl][Skin] != NewDatas[Pl][Skin])
		{
		    OnPlayerSkinChange(Pl, OldDatas[Pl][Skin], NewDatas[Pl][Skin]);
		    OldDatas[Pl][Skin] = GetPlayerSkin(Pl);
		}
    }
}

public PlayerScoreCheckT()
{
    for(new Pl; Pl < MAXPLAYERS; Pl++)
    {
    	NewDatas[Pl][Score] = GetPlayerScore(Pl);
		if(OldDatas[Pl][Score] != NewDatas[Pl][Score])
		{
		    OnPlayerScoreChange(Pl, OldDatas[Pl][Score], NewDatas[Pl][Score]);
		    OldDatas[Pl][Score] = GetPlayerScore(Pl);
		}
    }
}

public PlayerTeamCheckX()
{
    for(new playerid; playerid < MAXPLAYERS; playerid++)
    {
    	NewDatas[playerid][Team] = GetPlayerTeam(playerid);
		if(OldDatas[playerid][Team] != NewDatas[playerid][Team])
		{
		    OnPlayerTeamChange(playerid, OldDatas[playerid][Team], NewDatas[playerid][Team]);
		    OldDatas[playerid][Team] = GetPlayerTeam(playerid);
		}
    }
}
