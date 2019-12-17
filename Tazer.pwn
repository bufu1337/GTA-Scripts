/*
||||||||||||||||||||||||||||||||||||||||||||||||||
||0.3C Tazer System By AlexzzPro                ||
||Please do not re-release without my permission||
||Do not claim this as your own                 ||
||Enjoy!                                        ||
||||||||||||||||||||||||||||||||||||||||||||||||||
*/
#define FILTERSCRIPT
#include <a_samp>
#include <zcmd>
#define GREEN 0x21DD00FF
new tazeronbelt[MAX_PLAYERS];
new tazertimer[MAX_PLAYERS];
forward Float:GetDistanceBetweenPlayers(p1,p2); // Not created by me, Dont know who made this.
forward tazeroff(playerid);
forward usetazeragain(playerid);
#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Tazer System By AlexzzPro Loaded");
	print("--------------------------------------\n");
	return 1;
}
#endif
public OnFilterScriptExit()
{
    print("\n--------------------------------------");
	print(" Tazer System By AlexzzPro Un-Loaded");
	print("--------------------------------------\n");
	return 1;
}
public OnPlayerConnect(playerid)
{
	tazeronbelt[playerid] = 1;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	tazeronbelt[playerid] = 1;
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_FIRE)
    {
        if(tazeronbelt[playerid] == 0)
        {
            if(GetPlayerSkin(playerid) == 280 || GetPlayerSkin(playerid) == 281 || GetPlayerSkin(playerid) == 282 || GetPlayerSkin(playerid) == 283 || GetPlayerSkin(playerid) == 288 || GetPlayerSkin(playerid) == 284)
            {
                new tazervictim = GetClosestPlayer(playerid);
                new Float:health;
                if(GetPlayerSkin(tazervictim) == 280 || GetPlayerSkin(tazervictim) == 281 || GetPlayerSkin(tazervictim) == 282 || GetPlayerSkin(tazervictim) == 283 || GetPlayerSkin(tazervictim) == 288 || GetPlayerSkin(tazervictim) == 284)
				{
				    SendClientMessage(playerid, GREEN, "You cant tazer other cops");
				    return 1;
				}
				if(tazertimer[playerid] == 1)
				{
				    SendClientMessage(playerid, GREEN, "Please wait before tazing again");
				    return 1;
				}
                if(GetDistanceBetweenPlayers(playerid,tazervictim) < 2)
                {
                    ApplyAnimation(playerid,"KNIFE","knife_3",4.1,0,1,1,0,0,1);
                    TogglePlayerControllable(tazervictim, 0);
                    ApplyAnimation(tazervictim, "PED","FLOOR_hit_f", 4.0, 1, 0, 0, 0, 0);
                    GetPlayerHealth(tazervictim, health);
	                SetPlayerHealth(tazervictim, health - 2);
	                SendClientMessage(tazervictim, GREEN, "You have been tazed for 20 seconds");
	                SetTimerEx("tazeroff", 20000, false, "i", tazervictim);
	                SetTimerEx("usetazeragain", 9000, false, "i", playerid);
	                tazertimer[playerid] = 1;
				 }
			}
			return 1;
		}
	}
	return 1;
}
public usetazeragain(playerid)
{
	tazertimer[playerid] = 0;
	return 1;
}
public tazeroff(playerid)
{
    new tazervictim = GetClosestPlayer(playerid);
    TogglePlayerControllable(tazervictim, 1);
    SendClientMessage(playerid, GREEN, "You have been un-tazed");
    return 1;
}
CMD:tazer(playerid,params[])
{
    if(IsPlayerConnected(playerid))
    {
		if(GetPlayerSkin(playerid) == 280 || GetPlayerSkin(playerid) == 281 || GetPlayerSkin(playerid) == 282 || GetPlayerSkin(playerid) == 283 || GetPlayerSkin(playerid) == 288 || GetPlayerSkin(playerid) == 284)
        {
            if(tazeronbelt[playerid] == 1)
            {
				tazeronbelt[playerid] = 0;
				SetPlayerAttachedObject(playerid, 0, 18642, 6, 0.06, 0.01, 0.08, 180.0, 0.0, 0.0);
				SendClientMessage(playerid,GREEN,"Your tazer has been un-holsterd");
			}
			else if(tazeronbelt[playerid] == 0)
			{
				tazeronbelt[playerid] = 1;
                RemovePlayerAttachedObject(playerid, 0);
                SendClientMessage(playerid,GREEN, "Your tazer has been holsterd");
			}
			else
			{
				SendClientMessage(playerid, GREEN, "You are not connected");
			}
		}
		else
		{
		    SendClientMessage(playerid, GREEN, "You are not a cop");
		}
		return 1;
	}
	return 1;
}
stock GetClosestPlayer(playerid) // Not created by me, Dont know who made this.
{
    new Float:cdist, targetid = -1;
    for(new i; i<MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && playerid != i && (targetid < 0 || cdist > GetDistanceBetweenPlayers(playerid, i)))
        {
            targetid = i;
            cdist = GetDistanceBetweenPlayers(playerid, i);
        }
    }
    return targetid;
}
public Float:GetDistanceBetweenPlayers(p1,p2) // Not created by me, Dont know who made this.
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if(!IsPlayerConnected(p1) || !IsPlayerConnected(p2))
	{
		return -1.00;
	}
	GetPlayerPos(p1,x1,y1,z1);
	GetPlayerPos(p2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}