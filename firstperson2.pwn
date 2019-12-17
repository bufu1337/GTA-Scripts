#include <a_samp>

#define FILTERSCRIPT

#define YELLOW 0xFFFF00FF

#if defined FILTERSCRIPT

new FPS;
new FPSTurned[MAX_PLAYERS];

stock Float:GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
    new Float:a;
    GetPlayerPos(playerid, x, y, a);
    if (IsPlayerInAnyVehicle(playerid))
        GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
    else
        GetPlayerFacingAngle(playerid, a);
    x += (distance * floatsin(-a, degrees));
    y += (distance * floatcos(-a, degrees));
    return a;
}

new Text:CrossHair1;
new Text:CrossHair2;
new Text:CrossHair3;
new Text:CrossHair4;

enum cInfo
{
	Float:camPosLookX,
	Float:camPosLookY,
	Float:camPosLookZ
}

new CameraInfo[MAX_PLAYERS][cInfo];

forward GetCameraLookAt(playerid, &Float:x, &Float:y, &Float:z);
public GetCameraLookAt(playerid, &Float:x, &Float:y, &Float:z)
{
	x = CameraInfo[playerid][camPosLookX];
	y = CameraInfo[playerid][camPosLookY];
	z = CameraInfo[playerid][camPosLookZ];
	return 1;
}

public OnFilterScriptInit()
{
    CrossHair1 = TextDrawCreate(313.000000,173.000000,"-");
	CrossHair2 = TextDrawCreate(298.000000,173.000000,"-");
	CrossHair3 = TextDrawCreate(310.000000,164.000000,"I");
	CrossHair4 = TextDrawCreate(310.000000,179.000000,"I");
	TextDrawAlignment(CrossHair1,0);
	TextDrawAlignment(CrossHair2,0);
	TextDrawAlignment(CrossHair3,0);
	TextDrawAlignment(CrossHair4,0);
	TextDrawBackgroundColor(CrossHair1,0x000000ff);
	TextDrawBackgroundColor(CrossHair2,0x000000ff);
	TextDrawBackgroundColor(CrossHair3,0x000000ff);
	TextDrawBackgroundColor(CrossHair4,0x000000ff);
	TextDrawFont(CrossHair1,1);
	TextDrawLetterSize(CrossHair1,1.000000,1.000000);
	TextDrawFont(CrossHair2,3);
	TextDrawLetterSize(CrossHair2,0.899999,1.000000);
	TextDrawFont(CrossHair3,1);
	TextDrawLetterSize(CrossHair3,0.299999,1.500000);
	TextDrawFont(CrossHair4,1);
	TextDrawLetterSize(CrossHair4,0.299999,1.600000);
	TextDrawColor(CrossHair1,0xffffffff);
	TextDrawColor(CrossHair2,0xffffffff);
	TextDrawColor(CrossHair3,0xffffffff);
	TextDrawColor(CrossHair4,0xffffffff);
	TextDrawSetOutline(CrossHair1,1);
	TextDrawSetOutline(CrossHair2,1);
	TextDrawSetOutline(CrossHair3,1);
	TextDrawSetOutline(CrossHair4,1);
	TextDrawSetProportional(CrossHair1,1);
	TextDrawSetProportional(CrossHair2,1);
	TextDrawSetProportional(CrossHair3,1);
	TextDrawSetProportional(CrossHair4,1);
	TextDrawSetShadow(CrossHair1,1);
	TextDrawSetShadow(CrossHair2,1);
	TextDrawSetShadow(CrossHair3,1);
	TextDrawSetShadow(CrossHair4,1);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print("First Person Shooter View		   ");
	print("by SpiderPork					   ");
	print("----------------------------------\n");
}

#endif

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(FPSTurned[playerid] == 1)
	{
		KillTimer(FPS);
		TextDrawHideForPlayer(playerid, CrossHair1);
		TextDrawHideForPlayer(playerid, CrossHair2);
		TextDrawHideForPlayer(playerid, CrossHair3);
		TextDrawHideForPlayer(playerid, CrossHair4);
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(FPSTurned[playerid] == 1)
	{
		KillTimer(FPS);
		TextDrawHideForPlayer(playerid, CrossHair1);
		TextDrawHideForPlayer(playerid, CrossHair2);
		TextDrawHideForPlayer(playerid, CrossHair3);
		TextDrawHideForPlayer(playerid, CrossHair4);
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/stopfps", cmdtext, true, 10) == 0)
	{
		KillTimer(FPS);
		SendClientMessage(playerid, YELLOW, "You have successfully stopped the FPS view mode.");
		FPSTurned[playerid] = 0;
		SetCameraBehindPlayer(playerid);
		TextDrawHideForPlayer(playerid, CrossHair1);
		TextDrawHideForPlayer(playerid, CrossHair2);
		TextDrawHideForPlayer(playerid, CrossHair3);
		TextDrawHideForPlayer(playerid, CrossHair4);
		return 1;
	}

	if (strcmp("/startfps", cmdtext, true, 10) == 0)
	{
	    FPS = SetTimerEx("FPSTimer", 10, true, "i", playerid);
		SendClientMessage(playerid, YELLOW, "You have successfully started the FPS view mode.");
		FPSTurned[playerid] = 1;
		TextDrawShowForPlayer(playerid, CrossHair1);
		TextDrawShowForPlayer(playerid, CrossHair2);
		TextDrawShowForPlayer(playerid, CrossHair3);
		TextDrawShowForPlayer(playerid, CrossHair4);
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

forward FPSTimer(playerid);
public FPSTimer(playerid)
{
	new Float:X, Float:Y, Float:Z, Float:X2, Float:Y2;
	GetPlayerPos(playerid, X, Y, Z);
	GetXYInFrontOfPlayer(playerid, X2, Y2, 0.4);
	SetPlayerCameraPos(playerid, X2, Y2, Z+0.9);
	GetXYInFrontOfPlayer(playerid, X2, Y2, 5.0);
	SetPlayerCameraLookAt(playerid, X2, Y2, Z);
}