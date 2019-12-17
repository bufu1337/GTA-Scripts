//////////////////////////////////////////////////////////////
//////////////// DRIFT POINTS COUNTER BY LUBY ////////////////
/////////////// Edited by Threshold & Abhinav ////////////////
//////////////////////////////////////////////////////////////

#include <a_samp>
#include <foreach>
#include <zcmd>

#define CASH_PERCENT	100
#define SCORE_PERCENT   0

#define DRIFT_MINKAT 	10.0
#define DRIFT_MAXKAT 	90.0
#define DRIFT_SPEED 	30.0

#define COLOR_Label 	0xFFFFFFFF
#define COLOR_LabelOut 	0x00000040
#define COLOR_ValueOut 	0xFFFFFF40
#define COLOR_Value 	0x000000FF

new bool:DriftActive = true;

enum TimerData
{
	AngleTimer,
	FixTimer,
	StateTimer,
	CancelTimer,
	DriftTimer
};
new TimerInfo[MAX_PLAYERS][TimerData];

enum DriftData
{
	CurrentPoints,
	DriftBonus,
	bool:DriftMode,
	bool:FixMode,
	Float:CarHealth,
	Float:pPos[3]
};
new Drifting[MAX_PLAYERS][DriftData];

new Text:TDLabels[3];
new PlayerText:TDValueDrift[MAX_PLAYERS];
new PlayerText:TDValueBonus[MAX_PLAYERS];
new PlayerText:TDValueCash[MAX_PLAYERS];

forward Drift(playerid);
forward AngleUpdate(playerid);
forward DriftExit(playerid);
forward CheckPlayerState(playerid);
forward AutoFix(playerid);

public OnFilterScriptInit()
{
    TDLabels[0] = TextDrawCreate(500, 100, "Drift Points");
	TextDrawColor(TDLabels[0], COLOR_Label);
	TextDrawSetShadow(TDLabels[0], 0);
	TextDrawSetOutline(TDLabels[0], 1);
	TextDrawLetterSize(TDLabels[0], 0.5, 2);
	TextDrawBackgroundColor(TDLabels[0], COLOR_LabelOut);
	TextDrawFont(TDLabels[0], 1);

	TDLabels[1] = TextDrawCreate(500, 150, "Drift Bonus");
	TextDrawColor(TDLabels[1], COLOR_Label);
	TextDrawSetShadow(TDLabels[1], 0);
	TextDrawSetOutline(TDLabels[1], 1);
	TextDrawLetterSize(TDLabels[1], 0.5, 2);
	TextDrawBackgroundColor(TDLabels[1], COLOR_LabelOut);
	TextDrawFont(TDLabels[1], 1);

	TDLabels[2] = TextDrawCreate(500, 200, "Drift Cash");
	TextDrawColor(TDLabels[2], COLOR_Label);
	TextDrawSetShadow(TDLabels[2], 0);
	TextDrawSetOutline(TDLabels[2], 1);
	TextDrawLetterSize(TDLabels[2], 0.5, 2);
	TextDrawBackgroundColor(TDLabels[2], COLOR_LabelOut);
	TextDrawFont(TDLabels[2], 1);
	
	DriftActive = true;
	return 1;
}

public OnFilterScriptExit()
{
	TextDrawDestroy(TDLabels[0]);
	TextDrawDestroy(TDLabels[1]);
	TextDrawDestroy(TDLabels[2]);
	return 1;
}

public OnPlayerConnect(playerid)
{
	LoadTextDraws(playerid);
	Drifting[playerid][CurrentPoints] = 0;
	Drifting[playerid][DriftBonus] = 1;
	Drifting[playerid][DriftMode] = false;
	Drifting[playerid][FixMode] = false;
	TimerInfo[playerid][AngleTimer] = SetTimerEx("AngleUpdate", 200, true, "i", playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	PlayerTextDrawDestroy(playerid, TDValueDrift[playerid]);
	PlayerTextDrawDestroy(playerid, TDValueBonus[playerid]);
	PlayerTextDrawDestroy(playerid, TDValueCash[playerid]);
	return 1;
}

Float:GetPlayerTheoreticAngle(playerid)
{
	new Float:MindAngle = 0.0, Float:angle2 = 0.0;
	if(IsPlayerConnected(playerid))
	{
	    new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		new Float:dis = floatsqroot(floatpower(floatabs(floatsub(x, Drifting[playerid][pPos][0])), 2)+floatpower(floatabs(floatsub(y, Drifting[playerid][pPos][1])), 2));
		if(IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), angle2);
		else GetPlayerFacingAngle(playerid, angle2);
		if(Drifting[playerid][pPos][0] >= x)
		{
		    new Float:tmp = (x >= Drifting[playerid][pPos][0]) ? (x - Drifting[playerid][pPos][0]) : (Drifting[playerid][pPos][0] - x), Float:sin = asin(tmp / dis);
			if(Drifting[playerid][pPos][1] >= y) MindAngle = floatadd(floatsub(floatadd(sin, 90), floatmul(sin, 2)), 90.0);
	  		else MindAngle = floatsub(floatadd(sin, 180), 180.0);
		}
		else
		{
 			if(Drifting[playerid][pPos][1] < y)
			{
			    new Float:tmp2 = (y >= Drifting[playerid][pPos][1]) ? (y - Drifting[playerid][pPos][1]) : (Drifting[playerid][pPos][1] - y), Float:sin = acos(tmp2 / dis);
       			MindAngle = floatsub(floatadd(sin, 360), floatmul(sin, 2));
       		}
       		else
       		{
       		    new Float:tmp = (x >= Drifting[playerid][pPos][0]) ? (x - Drifting[playerid][pPos][0]) : (Drifting[playerid][pPos][0] - x), Float:sin = asin(tmp / dis);
          		MindAngle = floatadd(sin, 180);
        	}
		}
	}
	return (!MindAngle) ? (angle2) : (MindAngle);
}

public DriftExit(playerid)
{
	TimerInfo[playerid][CancelTimer] = 0;
 	new Float:h, veh = GetPlayerVehicleID(playerid);
 	GetVehicleHealth(veh, h);
  	if((70 <= Drifting[playerid][CurrentPoints] <= 10000) && h >= Drifting[playerid][CarHealth])
  	{
	  	GivePlayerMoney(playerid, (Drifting[playerid][CurrentPoints] * Drifting[playerid][DriftBonus]) * CASH_PERCENT);
	  	SetPlayerScore(playerid, GetPlayerScore(playerid) + (Drifting[playerid][CurrentPoints] * SCORE_PERCENT));
	}
	TextDrawHideForPlayer(playerid, TDLabels[0]);
    TextDrawHideForPlayer(playerid, TDLabels[1]);
    TextDrawHideForPlayer(playerid, TDLabels[2]);
    PlayerTextDrawHide(playerid, TDValueDrift[playerid]);
    PlayerTextDrawHide(playerid, TDValueBonus[playerid]);
    PlayerTextDrawHide(playerid, TDValueCash[playerid]);
    Drifting[playerid][DriftBonus] = 1;
    Drifting[playerid][FixMode] = true;
    SetVehicleHealth(veh, Drifting[playerid][CarHealth]);
	Drifting[playerid][CurrentPoints] = 0;
}

public Drift(playerid)
{
	if(!DriftActive) return 1;
	if(IsPlayerInAnyVehicle(playerid) && GetVType(GetPlayerVehicleID(playerid)))
	{
		new Float:X, Float:Y, Float:Z, Float:SpeedX, Float:Angle1, Float:Angle2, Float:BySpeed;
		GetPlayerPos(playerid, X, Y, Z);
		SpeedX = floatsqroot(floatadd(floatadd(floatpower(floatabs(floatsub(X, Drifting[playerid][pPos][0])), 2), floatpower(floatabs(floatsub(Y, Drifting[playerid][pPos][1])), 2)), floatpower(floatabs(floatsub(Z, Drifting[playerid][pPos][2])), 2)));
		if(IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), Angle1);
		else GetPlayerFacingAngle(playerid, Angle1);
    	Angle2 = GetPlayerTheoreticAngle(playerid);
    	BySpeed = floatmul(SpeedX, 12);
    	if((DRIFT_MINKAT <= floatabs(floatsub(Angle1, Angle2)) <= DRIFT_MAXKAT) && BySpeed >= DRIFT_SPEED)
		{
    		if(TimerInfo[playerid][CancelTimer]) KillTimer(TimerInfo[playerid][CancelTimer]);
    		Drifting[playerid][CurrentPoints] += floatround((floatabs(floatsub(Angle1, Angle2)) * BySpeed * 0.3) / 10);
    		TimerInfo[playerid][CancelTimer] = SetTimerEx("DriftExit", 3000, false, "d", playerid);
    	}
		switch(Drifting[playerid][CurrentPoints])
		{
			case 0 .. 499: Drifting[playerid][DriftBonus] = 1;
			case 500 .. 999: Drifting[playerid][DriftBonus] = 2;
			case 1000 .. 1699: Drifting[playerid][DriftBonus] = 3;
			case 1700 .. 2499: Drifting[playerid][DriftBonus] = 4;
			default: Drifting[playerid][DriftBonus] = 5;
		}
		TextDrawShowForPlayer(playerid, TDLabels[0]);
		TextDrawShowForPlayer(playerid, TDLabels[1]);
		TextDrawShowForPlayer(playerid, TDLabels[2]);
	    PlayerTextDrawShow(playerid, TDValueDrift[playerid]);
		PlayerTextDrawShow(playerid, TDValueBonus[playerid]);
		PlayerTextDrawShow(playerid, TDValueCash[playerid]);
	    new vstr[15];
		format(vstr, sizeof(vstr), "%d", Drifting[playerid][CurrentPoints]);
  		PlayerTextDrawSetString(playerid, TDValueDrift[playerid], vstr);
		format(vstr, sizeof(vstr), "X%d", Drifting[playerid][DriftBonus]);
  		PlayerTextDrawSetString(playerid, TDValueBonus[playerid], vstr);
  		format(vstr, sizeof(vstr), "$%d", ((Drifting[playerid][CurrentPoints] * Drifting[playerid][DriftBonus]) * CASH_PERCENT));
		PlayerTextDrawSetString(playerid, TDValueCash[playerid], vstr);
		Drifting[playerid][pPos][0] = X;
        Drifting[playerid][pPos][1] = Y;
        Drifting[playerid][pPos][2] = Z;
	}
	return 1;
}

public AngleUpdate(playerid)
{
	if(!DriftActive) return 1;
	if(IsPlayerInAnyVehicle(playerid)) GetVehiclePos(GetPlayerVehicleID(playerid), Drifting[playerid][pPos][0], Drifting[playerid][pPos][1], Drifting[playerid][pPos][2]);
	else GetPlayerPos(playerid, Drifting[playerid][pPos][0], Drifting[playerid][pPos][1], Drifting[playerid][pPos][2]);
	return 1;
}

LoadTextDraws(playerid)
{
	TDValueDrift[playerid] = CreatePlayerTextDraw(playerid, 500, 120, "0");
	PlayerTextDrawColor(playerid, TDValueDrift[playerid], COLOR_Value);
	PlayerTextDrawSetShadow(playerid, TDValueDrift[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TDValueDrift[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TDValueDrift[playerid], 0.5, 2);
	PlayerTextDrawBackgroundColor(playerid, TDValueDrift[playerid], COLOR_ValueOut);
	PlayerTextDrawFont(playerid, TDValueDrift[playerid], 3);

	TDValueBonus[playerid] = CreatePlayerTextDraw(playerid, 500, 170, "X1");
	PlayerTextDrawColor(playerid, TDValueBonus[playerid], COLOR_Value);
	PlayerTextDrawSetShadow(playerid, TDValueBonus[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TDValueBonus[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TDValueBonus[playerid], 0.5, 2);
	PlayerTextDrawBackgroundColor(playerid, TDValueBonus[playerid], COLOR_ValueOut);
	PlayerTextDrawFont(playerid, TDValueBonus[playerid], 3);

	TDValueCash[playerid] = CreatePlayerTextDraw(playerid, 500, 220, "$0");
	PlayerTextDrawColor(playerid, TDValueCash[playerid], COLOR_Value);
	PlayerTextDrawSetShadow(playerid, TDValueCash[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TDValueCash[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TDValueCash[playerid], 0.5, 2);
	PlayerTextDrawBackgroundColor(playerid, TDValueCash[playerid], COLOR_ValueOut);
	PlayerTextDrawFont(playerid, TDValueCash[playerid], 3);
	return 1;
}

public CheckPlayerState(playerid)
{
	if(Drifting[playerid][DriftMode])
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(Drifting[playerid][CurrentPoints] > 70)
			{
				new Float:h;
				GetVehicleHealth(GetPlayerVehicleID(playerid), h);
				if(h < Drifting[playerid][CarHealth])
				{
					KillTimer(TimerInfo[playerid][DriftTimer]);
					DriftExit(playerid);
					GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~r~Boom", 800, 5);
					Drifting[playerid][DriftMode] = false;
				}
			}
		}
		else
		{
		    KillTimer(TimerInfo[playerid][DriftTimer]);
		    Drifting[playerid][DriftMode] = false;
		    Drifting[playerid][FixMode] = true;
		}
	}
	else if(!Drifting[playerid][DriftMode])
	{
	    new veh = GetPlayerVehicleID(playerid);
 		if((GetVType(veh)) && (GetPlayerState(playerid) == PLAYER_STATE_DRIVER))
		{
			Drifting[playerid][DriftMode] = true;
			GetVehicleHealth(veh, Drifting[playerid][CarHealth]);
			Drifting[playerid][FixMode] = false;
			TimerInfo[playerid][DriftTimer] = SetTimerEx("Drift", 200, true, "i", playerid);
		}
	}
	return 1;
}

public AutoFix(playerid)
{
	if(Drifting[playerid][FixMode] && IsPlayerInAnyVehicle(playerid)) SetVehicleHealth(GetPlayerVehicleID(playerid), Drifting[playerid][CarHealth]);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
		if(DriftActive)
		{
		    new Float:h;
		    GetVehicleHealth(GetPlayerVehicleID(playerid), h);
			Drifting[playerid][CarHealth] = h;
		    Drifting[playerid][FixMode] = true;
		    TimerInfo[playerid][FixTimer] = SetTimerEx("AutoFix", 1000, true, "i", playerid);
		    TimerInfo[playerid][StateTimer] = SetTimerEx("CheckPlayerState", 100, true, "i", playerid);
		}
	}
	else if(newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER)
	{
	    KillTimer(TimerInfo[playerid][FixTimer]);
	    KillTimer(TimerInfo[playerid][StateTimer]);
		TextDrawHideForPlayer(playerid, TDLabels[0]);
	    TextDrawHideForPlayer(playerid, TDLabels[1]);
	    TextDrawHideForPlayer(playerid, TDLabels[2]);
    	PlayerTextDrawHide(playerid, TDValueDrift[playerid]);
    	PlayerTextDrawHide(playerid, TDValueBonus[playerid]);
    	PlayerTextDrawHide(playerid, TDValueCash[playerid]);
		Drifting[playerid][CurrentPoints] = 0;
		Drifting[playerid][DriftBonus] = 1;
	}
	return 1;
}

GetVType(vid)
{
	switch(GetVehicleModel(vid))
	{
		case 	480, 533, 439, 555, //Convertibles
				403, 408, 413, 414, 422, 440, 443, 455, 456, 459, 478, 482, 498, 499, 514, 515, 524, 531, 543, 552, 554, 578, 582, 605, 609, //Industrial Vehicles
				412, 534 .. 536, 566, 567, 575, 576, //Lowriders
				470, 489, 500, 505, 556, 557, 568, 573, 579, 595, //Offroad Vehicles
				407, 416, 420, 427, 431 .. 433, 437, 438, 490, 523, 528, 544, 596 .. 599, 601, //Service Vehicles
				401, 405, 410, 419, 421, 426, 436, 445, 466, 467, 474, 491, 492, 504, 507, 516 .. 518, 526, 527, 529, 540, 542, 546, 547, 549, 550, 551, 560, 562, 580, 585, 600, 604, //Saloon Vehicles
				402, 411, 415, 429, 451, 475, 477, 494, 496, 502, 503, 506, 541, 558, 559, 565, 587, 589, 602, 603, //Sports Vehicles
				404, 418, 458, 479, 561: return 1; //Wagons
	}
	return 0;
}

CMD:driftoff(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1, "You must be an RCON admin to use this command.");
	SendClientMessageToAll(-1, "Drift has been disabled.");
	TextDrawHideForAll(TDLabels[0]);
	TextDrawHideForAll(TDLabels[1]);
	TextDrawHideForAll(TDLabels[2]);
	foreach(new i : Player)
	{
	    if(!IsPlayerConnected(i)) continue;
	    PlayerTextDrawHide(i, TDValueDrift[i]);
	    PlayerTextDrawHide(i, TDValueBonus[i]);
	    PlayerTextDrawHide(i, TDValueCash[i]);
		KillTimer(TimerInfo[i][FixTimer]);
		KillTimer(TimerInfo[i][StateTimer]);
	}
	DriftActive = false;
	return 1;
}

CMD:drifton(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1, "You must be an RCON admin to use this command.");
	SendClientMessageToAll(-1, "Drift has been activated.");
	foreach(new i : Player)
	{
	    if(GetPlayerState(i) != PLAYER_STATE_DRIVER) continue;
	    TimerInfo[i][FixTimer] = SetTimerEx("AutoFix", 1000, true, "i", i);
		TimerInfo[i][StateTimer] = SetTimerEx("CheckPlayerState", 100, true, "i", i);
	}
	DriftActive = true;
	return 1;
}