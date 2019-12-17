/*
	trablon's Fire Fight System for RolePlay servers..
						v0.1

*/
//====================================================================[includes]
#include <a_samp>
//=====================================================================[defines]
#define FILTERSCRIPT

#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))

#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

#define SCM SendClientMessage

#define COLOR_FLASH      0xFF000080
#define COLOR_RED 		 0xAA3333AA
#define COLOR_GREY 		 0xAFAFAFAA
#define COLOR_GREEN      0x9EC73DAA
#define COLOR_LIGHTRED   0xFF6347AA
#define COLOR_LIGHTGREEN 0x9ACD32AA
#define COLOR_GREEN2     0x36A71700
//====================================================================[forwards]
forward FireTimer();
forward DestroyFireforPlayer(playerid);
forward SetTimeforFire();
//=====================================================================[pragmas]
//=======================================================================[enums]
//========================================================================[news]
new
    firenews = -1,
    Text3D:firetimergo[10],
    firehp[10],
    fireobjects[10],
    totalfirepos,
    Iminfire[MAX_PLAYERS],
    dutyforfireman[MAX_PLAYERS],
    firemancash[MAX_PLAYERS],
    firemanonduty[MAX_PLAYERS]
	;
new Float:FirePosforIdlewood[10][3] = {
{1937.5554,-1763.3531,13.3828}, // Area 0 - Idlewood
{1945.7601,-1765.4830,13.3828},
{1945.0408,-1774.3759,13.3906},
{1945.1576,-1784.9263,13.3828},
{1937.9746,-1785.5255,13.3906},
{1932.7399,-1778.2761,13.3828},
{1925.2346,-1779.3983,17.9766},
{1929.7230,-1789.8518,13.3828},
{1941.6704,-1784.5291,13.3906},
{1951.5349,-1780.0042,13.5469}
};
// =============================================================================
#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	SetTimer("SetTimeforFire",1000,true); // If you want to import to your gamemode, just add it all to your main global timer for players.
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else
#endif

public OnPlayerSpawn(playerid)
{

	return 1;
}
public OnPlayerConnect(playerid)
{
	Iminfire[playerid] = 0; dutyforfireman[playerid] = 0; firemanonduty[playerid] = 0;
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	Iminfire[playerid] = 0; dutyforfireman[playerid] = 0; firemanonduty[playerid] = 0;
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (HOLDING(KEY_FIRE))
{
	for(new i; i < 10; i++)
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, FirePosforIdlewood[i][0],FirePosforIdlewood[i][1],FirePosforIdlewood[i][2]))
{
	Iminfire[playerid] = SetTimerEx("DestroyFireforPlayer", 3000, false, "i", playerid);
}
}
}

	if (RELEASED(KEY_FIRE) && GetPlayerWeapon(playerid) == 42 && dutyforfireman[playerid] == 1)
{
	KillTimer(Iminfire[playerid]);
}
	return 1;
}
public SetTimeforFire()
{
	if(totalfirepos == 10)
{
	for(new i; i < MAX_PLAYERS; i++)
{
	if(dutyforfireman[i] == 1)
{
	SCM(i,COLOR_LIGHTGREEN,"* Fire in the idlewood has gone for now, all fire fighters have paid due to their effort.");
	GivePlayerMoney(i,firemancash[i]);
	firemancash[i] = 0;
	dutyforfireman[i] = 0;
}
}
	totalfirepos = 0;
}
	return true;
}

public FireTimer()
{
	new str[128];
	for(new i; i < 10; i++)
{
	firehp[i] = 100;
	format(str,sizeof(str),"{FF0004}Fire Area: #%d",firehp);
	fireobjects[i] = CreateObject(18691,FirePosforIdlewood[i][0],FirePosforIdlewood[i][1],FirePosforIdlewood[i][2]-3,0.0000,0.0000,0.0000);
	firetimergo[i] = Create3DTextLabel(str,-1,FirePosforIdlewood[i][0],FirePosforIdlewood[i][1],FirePosforIdlewood[i][2],0,0);
    firenews = 0;
}
	for(new i; i < MAX_PLAYERS; i++)
{
	if(firemanonduty[i] == 1)
{
	SCM(i,COLOR_FLASH,"* There are fires in the Idlewood!");
}

}
	return 1;
}

public DestroyFireforPlayer(playerid)
{
	new str[128];
	for(new i; i < 10; i++)
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, FirePosforIdlewood[i][0],FirePosforIdlewood[i][1],FirePosforIdlewood[i][2]))
{
	if(firehp[i] == 100 || firehp[i] < 100 )
{
	firehp[i] -= 1;
	firemancash[playerid] += firehp[i];
	format(str,sizeof(str),"{FF0004}Fire Area: #%d",firehp[i]);
	Update3DTextLabelText(firetimergo[i], COLOR_RED, str);
}

	if(firehp[i] < 80)
{
	firehp[i] -= 1;
	firemancash[playerid] += firehp[i];
	format(str,sizeof(str),"{FF7700}Fire Area: #%d",firehp[i]);
	Update3DTextLabelText(firetimergo[i], COLOR_RED, str);
}

	if(firehp[i] < 60)
{
	firehp[i] -= 1;
	firemancash[playerid] += firehp[i];
	format(str,sizeof(str),"{FFB300}Fire Area: #%d",firehp[i]);
	Update3DTextLabelText(firetimergo[i], COLOR_RED, str);
}

	if(firehp[i] < 40)
{
	firehp[i] -= 1;
	firemancash[playerid] += firehp[i];
	format(str,sizeof(str),"{FFCC00}Fire Area: #%d",firehp[i]);
	Update3DTextLabelText(firetimergo[i], COLOR_RED, str);
}

	if(firehp[i] < 20)
{
	firehp[i] -= 1;
	firemancash[playerid] += firehp[i];
	format(str,sizeof(str),"{BFFF00}Fire Area: #%d",firehp[i]);
	Update3DTextLabelText(firetimergo[i], COLOR_RED, str);
}

	if(firehp[i] < 10)
{
	firehp[i] -= 1;
	firemancash[playerid] += firehp[i];
	format(str,sizeof(str),"{1EFF00}Fire Area: #%d",firehp[i]);
	Update3DTextLabelText(firetimergo[i], COLOR_RED, str);
}

	if(firehp[i] == 0)
{
	Delete3DTextLabel(firetimergo[i]);
	DestroyObject(fireobjects[i]);
	totalfirepos++;
	SCM(playerid,COLOR_GREY,"* Fire has gone.");
}

}
}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp(cmdtext, "/duty", true))
{
	if(firenews == -1) return SCM(playerid,COLOR_LIGHTRED,"* There is no fire from any area yet.");
	dutyforfireman[playerid] = 1;
	firemanonduty[playerid] = 1;
	GivePlayerWeapon(playerid,6,1);
	GivePlayerWeapon(playerid,42,9999);
	SCM(playerid,COLOR_GREEN2,"* You are on your duty.");
	return 1;
}

	if(!strcmp(cmdtext, "/startfire", true))
{
	FireTimer();
	return 1;
}
    return 0;
}
// =============================================================================
//======================================================================[stocks]
//=========================================================================[END]