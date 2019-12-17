/*
*
*	-= LSR INCLUDE =-
*	Larceny Speed Radar
*
*	Autor: Larceny
*	Special Thanks to: Protioso ([VGS]Protioso_OC)
*	First Release: September 20, 2010 - V1.7
*
*/
#include "a_samp"

#define MAX_Radar 100
#define LSR_TIME_CHECK 1500 // Tempo em milisegundos.

/*Function List -----------------------------------------------------------------------------||

native CreateRadar(Float:x, Float:y, Float:z, speedmax, radiacao, pickup, virtualword = -1);
native DestroyRadar(lrid);
native RadarExists(lrid);
native SetRadarPos(lrid, Float:x, Float:y, Float:z);
native SetRadarVirtualWorld(lrid, virtualworld);
native GetRadarPos(lrid, &Float:x, &Float:y, &Float:z);
native GetRadarVirtualWorld(lrid);

/------------------------------------------------------------------------------------------------------------||*/

enum lrdef
{
	LSR_VW,
	LSR_OID,
	Float:LSR_X,
	Float:LSR_Y,
	Float:LSR_Z,
	LSR_speedmax,
	LSR_radiacao,
	LSR_pickup
};

static  LSR_Timer, LSR_Total, LSR_Radar[MAX_Radar][lrdef];

#define LSR_CheckTimerAd() if(!LSR_Timer) LSR_Timer = SetTimer("CheckRadar", LSR_TIME_CHECK, 1)
#define LSR_CheckTimerRe() if(!LSR_Total){KillTimer(LSR_Timer); LSR_Timer = 0;}

forward CheckRadar();
forward HideRadar(playerid);
forward PlayerInPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward OnPlayerEnterRadar(playerid, speed, radarid);
forward UseFlashRadar();
forward MoverPickup(lrid,Float:x,Float:y,Float:z);

new Text:Flash;
new UseFlash;

stock CreateRadar(Float:x, Float:y, Float:z, speedmax, radiacao, pickup, virtualword = -1)
{
	new bid = LSR_ProcurarIDLivre();
	if(bid == -1)
	{
	    printf("[LSP:] Radar limit was exceeded!(Max:%d) Increase the value or delete some...", MAX_Radar);
	    return 0;
	}
	LSR_Radar[bid][LSR_OID] = CreatePickup(pickup,1,x,y,z+2,-1);
	LSR_Radar[bid][LSR_X] = x;
	LSR_Radar[bid][LSR_Y] = y;
	LSR_Radar[bid][LSR_Z] = z;
	LSR_Radar[bid][LSR_speedmax] = speedmax;
	LSR_Radar[bid][LSR_VW] = virtualword;
	LSR_Radar[bid][LSR_radiacao] = radiacao;
	LSR_Radar[bid][LSR_pickup] = pickup;
	LSR_CheckTimerAd();
	LSR_Total++;
	return bid;
}

stock DestroyRadar(lrid)
{
	if(!LSR_Radar[lrid][LSR_OID]) return 0;
	LSR_Total--;
	DestroyPickup(LSR_Radar[lrid][LSR_pickup]);
    LSR_Radar[lrid][LSR_OID] = 0;
    LSR_CheckTimerRe()
    return 1;
}

stock RadarExists(lrid)	return (!LSR_Radar[lrid][LSR_OID]) ? 0 : 1;

stock SetRadarPos(lrid, Float:x, Float:y, Float:z)
{
	if(!LSR_Radar[lrid][LSR_OID]) return 0;
	LSR_Radar[lrid][LSR_X] = x;
	LSR_Radar[lrid][LSR_Y] = y;
	LSR_Radar[lrid][LSR_Z] = z;
	return MoverPickup(LSR_Radar[lrid][LSR_OID], x, y, z);
}

public MoverPickup(lrid,Float:x,Float:y,Float:z)
{
	if(LSR_Radar[lrid][LSR_OID])
	{
	    DestroyPickup(LSR_Radar[lrid][LSR_OID]);
		LSR_Radar[lrid][LSR_X] = x;
		LSR_Radar[lrid][LSR_Y] = y;
		LSR_Radar[lrid][LSR_Z] = z;
		CreatePickup(LSR_Radar[lrid][LSR_pickup], 1, x, y, z, -1);
		return 1;
	}
	return 0;
}

stock SetRadarVirtualWorld(lrid, virtualworld)
{
	if(!LSR_Radar[lrid][LSR_OID]) return 0;
	LSR_Radar[lrid][LSR_VW] = virtualworld;
	DestroyPickup(LSR_Radar[lrid][LSR_OID]);
	new x = LSR_Radar[lrid][LSR_X];
	new y = LSR_Radar[lrid][LSR_Y];
	new z = LSR_Radar[lrid][LSR_Z];
	CreatePickup(LSR_Radar[lrid][LSR_pickup], 1, x, y, z, virtualworld);
	return 1;
}

stock GetRadarPos(lrid, &Float:x, &Float:y, &Float:z)
{
	if(!LSR_Radar[lrid][LSR_OID])
	{
	    x = 0.0;
	    y = 0.0;
	    z = 0.0;
	}
	x = LSR_Radar[lrid][LSR_X];
	y = LSR_Radar[lrid][LSR_Y];
	z = LSR_Radar[lrid][LSR_Z];
}

stock GetRadarVirtualWorld(lrid)
{
	if(!LSR_Radar[lrid][LSR_OID]) return 0;
	return LSR_Radar[lrid][LSR_VW];
}

public PlayerInPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

public CheckRadar()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		for(new b = 1; b <= LSR_Total; b++)
		{
			if(LSR_Radar[b][LSR_OID])
			{
				if(LSR_Radar[b][LSR_VW] == -1 || GetPlayerVirtualWorld(i) == LSR_Radar[b][LSR_VW])
				{
					if(PlayerInPoint(LSR_Radar[b][LSR_radiacao], i, LSR_Radar[b][LSR_X], LSR_Radar[b][LSR_Y], LSR_Radar[b][LSR_Z]))
					{
						RadarForPlayer(i, LSR_Radar[b][LSR_speedmax], LSR_Radar[b][LSR_OID]);
					}	
				}
			}
		}
	}
}

stock LSR_ProcurarIDLivre()
{
	for(new b = 1; b < MAX_Radar; b++) if(!LSR_Radar[b][LSR_OID]) return b;
	return -1;
}

stock GetSpeed(playerid, bool:velo)
{
    new Float:Vx,Float:Vy,Float:Vz,Float:rtn;
    if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid),Vx,Vy,Vz); else GetPlayerVelocity(playerid,Vx,Vy,Vz);
    rtn = floatsqroot(floatabs(floatpower(Vx + Vy + Vz,2)));
    return velo?floatround(rtn * 100 * 1.61):floatround(rtn * 100);
}

stock RadarForPlayer(playerid, speedlimit, radarid)
{
	new currentspeed = GetSpeed(playerid, true);
	if(currentspeed >= speedlimit)
	{
		if(UseFlash == 1){TextDrawShowForPlayer(playerid, Flash); SetTimerEx("HideRadar", 1000, 0, "d", playerid);}
		PlayerPlaySound(playerid,1132,0.0,0.0,0.0);
		OnPlayerEnterRadar(playerid, currentspeed, radarid);
	}
    return 1;
}
public HideRadar(playerid)
{
	TextDrawHideForPlayer(playerid, Flash);
	return 1;
}

public UseFlashRadar()
{
	UseFlash = 1;
	Flash = TextDrawCreate(635.000000, 432.000000, "__");
	TextDrawBackgroundColor(Flash, 255);
	TextDrawFont(Flash, 1);
	TextDrawLetterSize(Flash, 0.500000, -45.900001);
	TextDrawColor(Flash, -256);
	TextDrawSetOutline(Flash, 0);
	TextDrawSetProportional(Flash, 1);
	TextDrawSetShadow(Flash, 1);
	TextDrawUseBox(Flash, 1);
	TextDrawBoxColor(Flash, -86);
	TextDrawTextSize(Flash, 6.000000, 35.000000);
	return 1;
}
