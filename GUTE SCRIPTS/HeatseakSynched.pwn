#include <a_samp>
#define speed 100

new Float:gtpos[10],Float:gtpos2[20];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Synched HS Missiles v1 by Trooper[Y]");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	for(new destiny=0;destiny<=GetMaxPlayers();destiny++)
	{
	    DestroyObject(GetPVarInt(destiny,"miss_obj"));
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	SetPVarInt(playerid,"flared",0);
	return 1;
}


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & 4)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 520 && GetPVarInt(playerid,"cooldown2") == 0)
			{
			    SetPVarInt(playerid,"cooldown2",1);
				SetPVarInt(playerid,"flared",1);
				SetTimerEx("unflare",4000,0,"i",playerid);
				SetTimerEx("cooldown_func2",7000,0,"i",playerid);
			}
		}
	}
	if((((newkeys & 4) && (newkeys & 128)) || (newkeys & 4) && (oldkeys & 128)) && GetPlayerWeapon(playerid) == 36 && GetPlayerAmmo(playerid) >= 1)
	{
		if(GetPVarInt(playerid,"cooldown3") == 0)
		{
	        SetPVarInt(playerid,"cooldown3",1);
	        SetTimerEx("cooldown_func3",4000,0,"i",playerid);
	        GetPlayerCameraPos(playerid,gtpos[0],gtpos[1],gtpos[2]);
	        GetPlayerCameraFrontVector(playerid,gtpos[3],gtpos[4],gtpos[5]);
	        GetPlayerPos(playerid,gtpos2[0],gtpos2[1],gtpos2[2]);

			for(new every=0;every<=GetMaxPlayers();every++)
				{
				    if(IsPlayerConnected(every) && every != playerid)
				    {
				        if(GetPlayerState(every) == 2)
						{
						    if(IsPlayerInRangeOfPoint(every,200,gtpos2[0],gtpos2[1],gtpos2[2]))
						    {
						        GetPlayerPos(every,gtpos2[10],gtpos2[11],gtpos2[12]);
						        gtpos2[13] = floatsqroot(floatpower(floatabs(floatsub(gtpos2[10],gtpos2[0])),2)+floatpower(floatabs(floatsub(gtpos2[11],gtpos2[1])),2)+floatpower(floatabs(floatsub(gtpos2[12],gtpos2[2])),2));
                                gtpos2[14] = gtpos[3] * gtpos2[13] + gtpos[0] , gtpos2[15] = gtpos[4] * gtpos2[13] + gtpos[1] , gtpos2[16] = gtpos[5] * gtpos2[13] + gtpos[2];
								if(IsPlayerInRangeOfPoint(every,30,gtpos2[14],gtpos2[15],gtpos2[16]))
								{
								    TogglePlayerControllable(playerid,0);
									TogglePlayerControllable(playerid,1);
									SetPVarInt(every,"flared",0);
								    SetPVarInt(playerid,"miss_obj",CreateObject(354,gtpos2[0],gtpos2[1],gtpos2[2],0,0,0));
								    MoveObject(GetPVarInt(playerid,"miss_obj"),gtpos2[10],gtpos2[11],gtpos2[12],speed);
								    SetMissile(playerid,every);
								    return 0;
								}
							}
						}
				    }
				}
	    }
	}
	if((newkeys & 1) && (newkeys & 128))
	{
		if(IsPlayerInAnyVehicle(playerid) && GetVehicleModel(GetPlayerVehicleID(playerid)) == 520)
		{
		    TogglePlayerControllable(playerid,0);
		    TogglePlayerControllable(playerid,1);
		    if(GetPVarInt(playerid,"cooldown") == 0 && GetPlayerState(playerid) == 2)
		    {
				GetVehiclePos(GetPlayerVehicleID(playerid),gtpos[0],gtpos[1],gtpos[2]);
				GetVehicleZAngle(GetPlayerVehicleID(playerid),gtpos[3]);
				SetPVarInt(playerid,"cooldown",1);
				SetTimerEx("cooldown_func",4000,0,"i",playerid);
				for(new every=0;every<=GetMaxPlayers();every++)
				{
				    if(IsPlayerConnected(every) && every != playerid)
				    {
				        if(GetPlayerState(every) == 2)
						{
			                if(IsPlayerInRangeOfPoint(every,300,gtpos[0],gtpos[1],gtpos[2]))
			                {
			                    GetPlayerPos(every,gtpos[4],gtpos[5],gtpos[6]);
			                    gtpos[7] = floatsqroot(floatpower(floatabs(floatsub(gtpos[4],gtpos[0])),2)+floatpower(floatabs(floatsub(gtpos[5],gtpos[1])),2)+floatpower(floatabs(floatsub(gtpos[6],gtpos[2])),2));
			                    gtpos[8] = gtpos[0]+(gtpos[7] * floatsin(-gtpos[3], degrees));
								gtpos[9] = gtpos[1]+(gtpos[7] * floatcos(-gtpos[3], degrees));
								if(IsPlayerInRangeOfPoint(every,50,gtpos[8],gtpos[9],gtpos[6]))
								{
								    SetPVarInt(every,"flared",0);
								    SetPVarInt(playerid,"miss_obj",CreateObject(354,gtpos[0],gtpos[1],gtpos[2],0,0,0));
								    MoveObject(GetPVarInt(playerid,"miss_obj"),gtpos[4],gtpos[5],gtpos[6],speed);
								    SetMissile(playerid,every);
								    return 0;
								}
			                }
						}
				    }
				}
		    }
		}
	}
	return 1;
}

forward cooldown_func(playerid);
public cooldown_func(playerid)
{
	SetPVarInt(playerid,"cooldown",0);
	return 1;
}

forward cooldown_func2(playerid);
public cooldown_func2(playerid)
{
	SetPVarInt(playerid,"cooldown2",0);
	return 1;
}

forward cooldown_func3(playerid);
public cooldown_func3(playerid)
{
	SetPVarInt(playerid,"cooldown3",0);
	return 1;
}

forward unflare(playerid);
public unflare(playerid)
{
	SetPVarInt(playerid,"flared",0);
	return 1;
}

forward SetMissile(playerid,aimid);
public SetMissile(playerid,aimid)
{
    GetObjectPos(GetPVarInt(playerid,"miss_obj"),gtpos2[0],gtpos2[1],gtpos2[2]);
	if(GetPVarInt(aimid,"flared") == 1 || !IsPlayerInAnyVehicle(aimid))
	{
	    DestroyObject(GetPVarInt(playerid,"miss_obj"));
	    return 1;
	}

	if(IsPlayerInRangeOfPoint(aimid,5,gtpos2[0],gtpos2[1],gtpos2[2]))
	{
	    DestroyObject(GetPVarInt(playerid,"miss_obj"));
	    CreateExplosion(gtpos2[0],gtpos2[1],gtpos2[2],6,10);
	    return 1;
	}
	SetTimerEx("SetMissile",250,0,"ii",playerid,aimid);
	GetVehiclePos(GetPlayerVehicleID(aimid),gtpos2[3],gtpos2[4],gtpos2[5]);
	MoveObject(GetPVarInt(playerid,"miss_obj"),gtpos2[3],gtpos2[4],gtpos2[5],speed);

	return 1;
}