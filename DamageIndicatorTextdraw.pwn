#include <a_samp>

#define Head   5
#define Torso  6
#define Groin  7
#define RArm   8
#define LArm   9
#define RLeg   10
#define LLeg   11

new PlayerText:DamageTD[12][MAX_PLAYERS];
new DamageTDShowing[MAX_PLAYERS];
new Indicator1[MAX_PLAYERS];
new Indicator2[MAX_PLAYERS];
new Indicator3[MAX_PLAYERS];
new Indicator4[MAX_PLAYERS];
new Indicator5[MAX_PLAYERS];
new Indicator6[MAX_PLAYERS];
new Indicator7[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("\n---------------------------------------------");
	print("Player Body Damage Indicator by Rehasher Loaded");
	print("----------------------------------------------\n");

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		CreatePlayerTextdraws(i);
	}
	return 1;
}

public OnFilterScriptExit()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		DestroyPlayerTextdraws(i);
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	CreatePlayerTextdraws(playerid);

	// RESETTING VARIABLES
	DamageTDShowing[playerid] = 0;
	Indicator1[playerid] = 0;
	Indicator2[playerid] = 0;
	Indicator3[playerid] = 0;
	Indicator4[playerid] = 0;
	Indicator5[playerid] = 0;
	Indicator6[playerid] = 0;
	Indicator7[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	DestroyPlayerTextdraws(playerid);
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
    new BODY_PART_HEAD, BODY_PART_TORSO, BODY_PART_RIGHT_ARM, BODY_PART_LEFT_ARM, BODY_PART_RIGHT_LEG, BODY_PART_LEFT_LEG, BODY_PART_GROIN;
    BODY_PART_TORSO = 3; BODY_PART_HEAD = 9; BODY_PART_GROIN = 4; BODY_PART_LEFT_ARM = 5; BODY_PART_RIGHT_ARM = 6; BODY_PART_LEFT_LEG = 7; BODY_PART_RIGHT_LEG = 8;
    printf("ID %d just attacked id %d at the bodypart id %d", issuerid, playerid, bodypart);
    if(bodypart == BODY_PART_HEAD && DamageTDShowing[playerid] == 1)
    {
    	PlayerTextDrawShow(playerid, DamageTD[Head][playerid]);
    	SetTimerEx("HideDamageIndicator", 5000, false, "i", playerid);
    	Indicator1[playerid] = 1;
    }
    if(bodypart == BODY_PART_TORSO && DamageTDShowing[playerid] == 1)
    {
    	PlayerTextDrawShow(playerid, DamageTD[Torso][playerid]);
    	SetTimerEx("HideDamageIndicator", 5000, false, "i", playerid);
    	Indicator2[playerid] = 1;
    }
    if(bodypart == BODY_PART_GROIN && DamageTDShowing[playerid] == 1)
    {
    	PlayerTextDrawShow(playerid, DamageTD[Groin][playerid]);
    	SetTimerEx("HideDamageIndicator", 5000, false, "i", playerid);
    	Indicator3[playerid] = 1;
    }
	if(bodypart == BODY_PART_RIGHT_ARM && DamageTDShowing[playerid] == 1)
    {
    	PlayerTextDrawShow(playerid, DamageTD[RArm][playerid]);
    	SetTimerEx("HideDamageIndicator", 5000, false, "i", playerid);
    	Indicator4[playerid] = 1;
    }
    if(bodypart == BODY_PART_LEFT_ARM && DamageTDShowing[playerid] == 1)
    {
    	PlayerTextDrawShow(playerid, DamageTD[LArm][playerid]);
    	SetTimerEx("HideDamageIndicator", 5000, false, "i", playerid);
    	Indicator5[playerid] = 1;
    }
    if(bodypart == BODY_PART_RIGHT_LEG && DamageTDShowing[playerid] == 1)
    {
    	PlayerTextDrawShow(playerid, DamageTD[RLeg][playerid]);
    	SetTimerEx("HideDamageIndicator", 5000, false, "i", playerid);
    	Indicator6[playerid] = 1;
    }
    if(bodypart == BODY_PART_LEFT_LEG && DamageTDShowing[playerid] == 1)
    {
    	PlayerTextDrawShow(playerid, DamageTD[LLeg][playerid]);
    	SetTimerEx("HideDamageIndicator", 5000, false, "i", playerid);
    	Indicator7[playerid] = 1;
    }
    return 1;
}

forward HideDamageIndicator(playerid);
public HideDamageIndicator(playerid)
{
	if(Indicator1[playerid] == 1)
	{
		PlayerTextDrawHide(playerid, DamageTD[Head][playerid]);
		Indicator1[playerid] = 0;
	}
	if(Indicator2[playerid] == 1)
	{
		PlayerTextDrawHide(playerid, DamageTD[Torso][playerid]);
		Indicator2[playerid] = 0;
	}
	if(Indicator3[playerid] == 1)
	{
		PlayerTextDrawHide(playerid, DamageTD[Groin][playerid]);
		Indicator3[playerid] = 0;
	}
	if(Indicator4[playerid] == 1)
	{
		PlayerTextDrawHide(playerid, DamageTD[RArm][playerid]);
		Indicator4[playerid] = 0;
	}
	if(Indicator5[playerid] == 1)
	{
		PlayerTextDrawHide(playerid, DamageTD[LArm][playerid]);
		Indicator5[playerid] = 0;
	}
	if(Indicator6[playerid] == 1)
	{
		PlayerTextDrawHide(playerid, DamageTD[RLeg][playerid]);
		Indicator6[playerid] = 0;
	}
	if(Indicator7[playerid] == 1)
	{
		PlayerTextDrawHide(playerid, DamageTD[LLeg][playerid]);
		Indicator7[playerid] = 0;
	}
	return 1;
}
public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp("/damagetextdraws", cmdtext, true, 10)== 0)
	{
		if(DamageTDShowing[playerid] == 0)
		{
			ShowBaseTDs(playerid);
		}
		else if(DamageTDShowing[playerid] == 1)
		{
			HideBaseTDs(playerid);
		}
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

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	new Skin = GetPlayerSkin(playerid);
	PlayerTextDrawSetPreviewModel(playerid, DamageTD[3][playerid], Skin);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

stock ShowBaseTDs(playerid)
{
	for(new five = 0; five < 5; five++)
	{
		PlayerTextDrawShow(playerid, DamageTD[five][playerid]);
	}
	PlayerTextDrawShow(playerid, DamageTD[4][playerid]);
	DamageTDShowing[playerid] = 1;
}

stock HideBaseTDs(playerid)
{
	for(new five = 0; five < 5; five++)
	{
		PlayerTextDrawHide(playerid, DamageTD[five][playerid]);
	}
	PlayerTextDrawHide(playerid, DamageTD[4][playerid]);
	DamageTDShowing[playerid] = 0;
}

stock CreatePlayerTextdraws(playerid)
{
	DamageTD[0][playerid] = CreatePlayerTextDraw(playerid, 509.000000, 233.000000, "                            ");
	PlayerTextDrawBackgroundColor(playerid, DamageTD[0][playerid], 0);
	PlayerTextDrawFont(playerid, DamageTD[0][playerid], 1);
	PlayerTextDrawLetterSize(playerid, DamageTD[0][playerid], 0.500000, 22.500001);
	PlayerTextDrawColor(playerid, DamageTD[0][playerid], -1);
	PlayerTextDrawSetOutline(playerid, DamageTD[0][playerid], 0);
	PlayerTextDrawSetProportional(playerid, DamageTD[0][playerid], 1);
	PlayerTextDrawSetShadow(playerid, DamageTD[0][playerid], 1);
	PlayerTextDrawUseBox(playerid, DamageTD[0][playerid], 1);
	PlayerTextDrawBoxColor(playerid, DamageTD[0][playerid], 52);
	PlayerTextDrawTextSize(playerid, DamageTD[0][playerid], 632.000000, 31.000000);
	PlayerTextDrawSetSelectable(playerid, DamageTD[0][playerid], 0);

	DamageTD[1][playerid] = CreatePlayerTextDraw(playerid, 509.000000, 230.000000, "                    ");
	PlayerTextDrawBackgroundColor(playerid, DamageTD[1][playerid], 255);
	PlayerTextDrawFont(playerid, DamageTD[1][playerid], 1);
	PlayerTextDrawLetterSize(playerid, DamageTD[1][playerid], 0.500000, 0.000000);
	PlayerTextDrawColor(playerid, DamageTD[1][playerid], -1);
	PlayerTextDrawSetOutline(playerid, DamageTD[1][playerid], 0);
	PlayerTextDrawSetProportional(playerid, DamageTD[1][playerid], 1);
	PlayerTextDrawSetShadow(playerid, DamageTD[1][playerid], 1);
	PlayerTextDrawUseBox(playerid, DamageTD[1][playerid], 1);
	PlayerTextDrawBoxColor(playerid, DamageTD[1][playerid], 255);
	PlayerTextDrawTextSize(playerid, DamageTD[1][playerid], 632.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid, DamageTD[1][playerid], 0);

	DamageTD[2][playerid] = CreatePlayerTextDraw(playerid, 509.000000, 438.000000, "                    ");
	PlayerTextDrawBackgroundColor(playerid, DamageTD[2][playerid], 0);
	PlayerTextDrawFont(playerid, DamageTD[2][playerid], 1);
	PlayerTextDrawLetterSize(playerid, DamageTD[2][playerid], 0.500000, 0.000000);
	PlayerTextDrawColor(playerid, DamageTD[2][playerid], -1);
	PlayerTextDrawSetOutline(playerid, DamageTD[2][playerid], 0);
	PlayerTextDrawSetProportional(playerid, DamageTD[2][playerid], 1);
	PlayerTextDrawSetShadow(playerid, DamageTD[2][playerid], 1);
	PlayerTextDrawUseBox(playerid, DamageTD[2][playerid], 1);
	PlayerTextDrawBoxColor(playerid, DamageTD[2][playerid], 255);
	PlayerTextDrawTextSize(playerid, DamageTD[2][playerid], 632.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid, DamageTD[2][playerid], 0);

	DamageTD[3][playerid] = CreatePlayerTextDraw(playerid, 490.000000, 241.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid, DamageTD[3][playerid], 0);
	PlayerTextDrawFont(playerid, DamageTD[3][playerid], 5);
	PlayerTextDrawLetterSize(playerid, DamageTD[3][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, DamageTD[3][playerid], -1);
	PlayerTextDrawSetOutline(playerid, DamageTD[3][playerid], 0);
	PlayerTextDrawSetProportional(playerid, DamageTD[3][playerid], 1);
	PlayerTextDrawSetShadow(playerid, DamageTD[3][playerid], 1);
	PlayerTextDrawUseBox(playerid, DamageTD[3][playerid], 1);
	PlayerTextDrawBoxColor(playerid, DamageTD[3][playerid], 255);
	PlayerTextDrawTextSize(playerid, DamageTD[3][playerid], 160.000000, 191.000000);
	PlayerTextDrawSetPreviewModel(playerid, DamageTD[3][playerid], 288);
	PlayerTextDrawSetPreviewRot(playerid, DamageTD[3][playerid], 0.000000, 0.000000, 0.000000, 0.899999);
	PlayerTextDrawSetSelectable(playerid, DamageTD[3][playerid], 0);

	DamageTD[4][playerid] = CreatePlayerTextDraw(playerid, 544.000000, 234.000000, "DAMAGE");
	PlayerTextDrawBackgroundColor(playerid, DamageTD[4][playerid], 255);
	PlayerTextDrawFont(playerid, DamageTD[4][playerid], 2);
	PlayerTextDrawLetterSize(playerid, DamageTD[4][playerid], 0.340000, 1.200000);
	PlayerTextDrawColor(playerid, DamageTD[4][playerid], -1);
	PlayerTextDrawSetOutline(playerid, DamageTD[4][playerid], 1);
	PlayerTextDrawSetProportional(playerid, DamageTD[4][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, DamageTD[4][playerid], 0);

	DamageTD[5][playerid] = CreatePlayerTextDraw(playerid, 560.000000, 250.000000, "                                     "); // HEAD INDICATOR
	PlayerTextDrawBackgroundColor(playerid, DamageTD[5][playerid], 255);
	PlayerTextDrawFont(playerid, DamageTD[5][playerid], 1);
	PlayerTextDrawLetterSize(playerid, DamageTD[5][playerid], 0.490000, 0.200000);
	PlayerTextDrawColor(playerid, DamageTD[5][playerid], -239);
	PlayerTextDrawSetOutline(playerid, DamageTD[5][playerid], 0);
	PlayerTextDrawSetProportional(playerid, DamageTD[5][playerid], 1);
	PlayerTextDrawSetShadow(playerid, DamageTD[5][playerid], 1);
	PlayerTextDrawUseBox(playerid, DamageTD[5][playerid], 1);
	PlayerTextDrawBoxColor(playerid, DamageTD[5][playerid], -16777164);
	PlayerTextDrawTextSize(playerid, DamageTD[5][playerid], 581.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid, DamageTD[5][playerid], 0);

	DamageTD[6][playerid] = CreatePlayerTextDraw(playerid, 558.000000, 279.000000, "                                     "); // TORSO INDICATOR
	PlayerTextDrawBackgroundColor(playerid, DamageTD[6][playerid], 255);
	PlayerTextDrawFont(playerid, DamageTD[6][playerid], 1);
	PlayerTextDrawLetterSize(playerid, DamageTD[6][playerid], 0.490000, 0.500000);
	PlayerTextDrawColor(playerid, DamageTD[6][playerid], -239);
	PlayerTextDrawSetOutline(playerid, DamageTD[6][playerid], 0);
	PlayerTextDrawSetProportional(playerid, DamageTD[6][playerid], 1);
	PlayerTextDrawSetShadow(playerid, DamageTD[6][playerid], 1);
	PlayerTextDrawUseBox(playerid, DamageTD[6][playerid], 1);
	PlayerTextDrawBoxColor(playerid, DamageTD[6][playerid], -16777164);
	PlayerTextDrawTextSize(playerid, DamageTD[6][playerid], 585.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid, DamageTD[6][playerid], 0);

	DamageTD[7][playerid] = CreatePlayerTextDraw(playerid, 565.000000, 332.000000, "                                     "); // GROIN INDICATOR
	PlayerTextDrawBackgroundColor(playerid, DamageTD[7][playerid], 255);
	PlayerTextDrawFont(playerid, DamageTD[7][playerid], 1);
	PlayerTextDrawLetterSize(playerid, DamageTD[7][playerid], 0.490000, 0.100000);
	PlayerTextDrawColor(playerid, DamageTD[7][playerid], -239);
	PlayerTextDrawSetOutline(playerid, DamageTD[7][playerid], 0);
	PlayerTextDrawSetProportional(playerid, DamageTD[7][playerid], 1);
	PlayerTextDrawSetShadow(playerid, DamageTD[7][playerid], 1);
	PlayerTextDrawUseBox(playerid, DamageTD[7][playerid], 1);
	PlayerTextDrawBoxColor(playerid, DamageTD[7][playerid], -16777164);
	PlayerTextDrawTextSize(playerid, DamageTD[7][playerid], 578.000000, -2.000000);
	PlayerTextDrawSetSelectable(playerid, DamageTD[7][playerid], 0);

	DamageTD[8][playerid] = CreatePlayerTextDraw(playerid, 541.000000, 280.000000, "                                     "); // R ARM INDICATOR
	PlayerTextDrawBackgroundColor(playerid, DamageTD[8][playerid], 255);
	PlayerTextDrawFont(playerid, DamageTD[8][playerid], 1);
	PlayerTextDrawLetterSize(playerid, DamageTD[8][playerid], 0.390000, 0.600001);
	PlayerTextDrawColor(playerid, DamageTD[8][playerid], -239);
	PlayerTextDrawSetOutline(playerid, DamageTD[8][playerid], 0);
	PlayerTextDrawSetProportional(playerid, DamageTD[8][playerid], 1);
	PlayerTextDrawSetShadow(playerid, DamageTD[8][playerid], 1);
	PlayerTextDrawUseBox(playerid, DamageTD[8][playerid], 1);
	PlayerTextDrawBoxColor(playerid, DamageTD[8][playerid], -16777164);
	PlayerTextDrawTextSize(playerid, DamageTD[8][playerid], 555.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid, DamageTD[8][playerid], 0);

	DamageTD[9][playerid] = CreatePlayerTextDraw(playerid, 589.000000, 280.000000, "                                     "); // L ARM INDICATOR
	PlayerTextDrawBackgroundColor(playerid, DamageTD[9][playerid], 255);
	PlayerTextDrawFont(playerid, DamageTD[9][playerid], 1);
	PlayerTextDrawLetterSize(playerid, DamageTD[9][playerid], 0.390000, 0.600001);
	PlayerTextDrawColor(playerid, DamageTD[9][playerid], -239);
	PlayerTextDrawSetOutline(playerid, DamageTD[9][playerid], 0);
	PlayerTextDrawSetProportional(playerid, DamageTD[9][playerid], 1);
	PlayerTextDrawSetShadow(playerid, DamageTD[9][playerid], 1);
	PlayerTextDrawUseBox(playerid, DamageTD[9][playerid], 1);
	PlayerTextDrawBoxColor(playerid, DamageTD[9][playerid], -16777164);
	PlayerTextDrawTextSize(playerid, DamageTD[9][playerid], 601.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid, DamageTD[9][playerid], 0);

	DamageTD[10][playerid] = CreatePlayerTextDraw(playerid, 553.000000, 357.000000, "                                     "); // R LEG INDICATOR
	PlayerTextDrawBackgroundColor(playerid, DamageTD[10][playerid], 255);
	PlayerTextDrawFont(playerid, DamageTD[10][playerid], 1);
	PlayerTextDrawLetterSize(playerid, DamageTD[10][playerid], 0.390000, 0.700001);
	PlayerTextDrawColor(playerid, DamageTD[10][playerid], -239);
	PlayerTextDrawSetOutline(playerid, DamageTD[10][playerid], 0);
	PlayerTextDrawSetProportional(playerid, DamageTD[10][playerid], 1);
	PlayerTextDrawSetShadow(playerid, DamageTD[10][playerid], 1);
	PlayerTextDrawUseBox(playerid, DamageTD[10][playerid], 1);
	PlayerTextDrawBoxColor(playerid, DamageTD[10][playerid], -16777164);
	PlayerTextDrawTextSize(playerid, DamageTD[10][playerid], 570.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid, DamageTD[10][playerid], 0);

	DamageTD[11][playerid] = CreatePlayerTextDraw(playerid, 575.000000, 357.000000, "                                     "); // L LEG INDICATOR
	PlayerTextDrawBackgroundColor(playerid, DamageTD[11][playerid], 255);
	PlayerTextDrawFont(playerid, DamageTD[11][playerid], 1);
	PlayerTextDrawLetterSize(playerid, DamageTD[11][playerid], 0.320000, 1.200001);
	PlayerTextDrawColor(playerid, DamageTD[11][playerid], -239);
	PlayerTextDrawSetOutline(playerid, DamageTD[11][playerid], 0);
	PlayerTextDrawSetProportional(playerid, DamageTD[11][playerid], 1);
	PlayerTextDrawSetShadow(playerid, DamageTD[11][playerid], 1);
	PlayerTextDrawUseBox(playerid, DamageTD[11][playerid], 1);
	PlayerTextDrawBoxColor(playerid, DamageTD[11][playerid], -16777164);
	PlayerTextDrawTextSize(playerid, DamageTD[11][playerid], 596.000000, -1.000000);
	PlayerTextDrawSetSelectable(playerid, DamageTD[11][playerid], 0);
}
stock DestroyPlayerTextdraws(playerid)
{
    PlayerTextDrawDestroy(playerid, DamageTD[0][playerid]);
    PlayerTextDrawDestroy(playerid, DamageTD[1][playerid]);
    PlayerTextDrawDestroy(playerid, DamageTD[2][playerid]);
    PlayerTextDrawDestroy(playerid, DamageTD[3][playerid]);
    PlayerTextDrawDestroy(playerid, DamageTD[4][playerid]);
    PlayerTextDrawDestroy(playerid, DamageTD[5][playerid]);
    PlayerTextDrawDestroy(playerid, DamageTD[6][playerid]);
    PlayerTextDrawDestroy(playerid, DamageTD[7][playerid]);
    PlayerTextDrawDestroy(playerid, DamageTD[8][playerid]);
    PlayerTextDrawDestroy(playerid, DamageTD[9][playerid]);
    PlayerTextDrawDestroy(playerid, DamageTD[10][playerid]);
    PlayerTextDrawDestroy(playerid, DamageTD[11][playerid]);
}