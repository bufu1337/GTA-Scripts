/*

						===================================
									 Tear-Gas system
									 By Carlton.
						===================================

*/


new TearGas[MAX_PLAYERS], TearGasTimer[MAX_PLAYERS], TearObject[MAX_PLAYERS], TearGasObject[MAX_PLAYERS];

TearGas_OnPlayerConnect(playerid) {
	TearGas[playerid] = 0;
}

GivePlayerTearGas(playerid, amount) {
	TearGas[playerid] += amount;
}

SetPlayerTearGas(playerid, amount) {
	TearGas[playerid] = amount;
}

GetPlayerTearGas(playerid) return TearGas[playerid];

GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if (GetPlayerVehicleID(playerid))
	{
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

TearGasOnPlayerKeyStateChange(playerid, newkeys)
{
    if (newkeys & KEY_FIRE) {
        if(GetPlayerTearGas(playerid) >= 1) {
        ApplyAnimation(playerid,"GRENADE","WEAPON_throwu",4.1,0,1,1,0,0);
        new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
        GetXYInFrontOfPlayer(playerid, x, y, 10.0);
        TearObject[playerid] = CreateObject(343, x, y, z, 0, 0, 96);
        TearGasTimer[playerid] = SetTimer("TearGasEfft", 1000, 1);
        SetTimerEx("StopTheEffect", 15000, 0, "d", playerid);
        MoveObject(TearObject[playerid], x, y, z-2, 1.00);
        new Float:tx, Float:ty, Float:tz;
	GetObjectPos(TearObject[playerid], tx, ty, tz);
        TearGasObject[playerid] = CreateObject(2780, tx, ty, tz-4, 0, 0, 96);
        GivePlayerTearGas(playerid, -1);
		}
    }
}

forward TearGasEfft();
public TearGasEfft()
{
	for(new i=0; i < MAX_PLAYERS; i++)
	{
	    new Float:tx, Float:ty, Float:tz;
	    GetObjectPos(TearGasObject[i], tx, ty, tz);
	    if(IsPlayerInRangeOfPoint(i, 8.0, tx, ty, tz))
	    {
	        ApplyAnimation(i,"CRACK","crckdeth4",4.1,0,1,1,1,1);
	    }
	}
}

forward StopTheEffect(playerid);
public StopTheEffect(playerid)
{
	KillTimer(TearGasTimer[playerid]);
        DestroyObject(TearObject[playerid]);
	DestroyObject(TearGasObject[playerid]);
}