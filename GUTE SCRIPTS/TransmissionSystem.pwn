/*
//////////////////////Mechanical Transmission System\\\\\\\\\\\\\\\\\\\\\\\
// Credits to Ryder` for his speedometer.           \\\\\\\\\\\\\\\\\\\\\\\
// Credits to wups for mechanical transmission      \\\\\\\\\\\\\\\\\\\\\\\
// Please don't remove the credits.                 \\\\\\\\\\\\\\\\\\\\\\\
//////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/
#include <a_samp>

#define Loop(%0,%1) \
	for(new %0; %0 != %1; %0++)
#define GEAR_KEY KEY_FIRE // You can change this to what you want.

new
	tbegiai[MAX_PLAYERS];
new
	Text: GearInfo[MAX_PLAYERS],
	Text: Speedo[MAX_PLAYERS],
	Text: General[5],
	Text: Gear[6],
	begis[MAX_VEHICLES],
	ispejimai[MAX_VEHICLES],
	gulsciukas[MAX_VEHICLES]
;


forward ShiftFunction(playerid);

public OnFilterScriptInit()
{

// speedo

	General[0] = TextDrawCreate(554.000000, 414.000000, "_");
	TextDrawBackgroundColor(General[0], 255);
	TextDrawFont(General[0], 1);
	TextDrawLetterSize(General[0], 0.500000, 2.599999);
	TextDrawColor(General[0], -1);
	TextDrawSetOutline(General[0], 0);
	TextDrawSetProportional(General[0], 1);
	TextDrawSetShadow(General[0], 1);
	TextDrawUseBox(General[0], 1);
	TextDrawBoxColor(General[0], 70);
	TextDrawTextSize(General[0], 628.000000, 0.000000);

	General[1] = TextDrawCreate(554.000000, 440.000000, "_");
	TextDrawBackgroundColor(General[1], 255);
	TextDrawFont(General[1], 1);
	TextDrawLetterSize(General[1], 0.500000, -0.300000);
	TextDrawColor(General[1], -1);
	TextDrawSetOutline(General[1], 0);
	TextDrawSetProportional(General[1], 1);
	TextDrawSetShadow(General[1], 1);
	TextDrawUseBox(General[1], 1);
	TextDrawBoxColor(General[1], 120);
	TextDrawTextSize(General[1], 628.000000, 0.000000);

	General[2] = TextDrawCreate(554.000000, 414.000000, "_");
	TextDrawBackgroundColor(General[2], 255);
	TextDrawFont(General[2], 1);
	TextDrawLetterSize(General[2], 0.500000, -0.300000);
	TextDrawColor(General[2], -1);
	TextDrawSetOutline(General[2], 0);
	TextDrawSetProportional(General[2], 1);
	TextDrawSetShadow(General[2], 1);
	TextDrawUseBox(General[2], 1);
	TextDrawBoxColor(General[2], 120);
	TextDrawTextSize(General[2], 628.000000, 0.000000);

	General[3] = TextDrawCreate(631.000000, 414.000000, "_");
	TextDrawBackgroundColor(General[3], 255);
	TextDrawFont(General[3], 1);
	TextDrawLetterSize(General[3], 0.500000, 2.599999);
	TextDrawColor(General[3], -1);
	TextDrawSetOutline(General[3], 0);
	TextDrawSetProportional(General[3], 1);
	TextDrawSetShadow(General[3], 1);
	TextDrawUseBox(General[3], 1);
	TextDrawBoxColor(General[3], 120);
	TextDrawTextSize(General[3], 629.000000, 0.000000);

	General[4] = TextDrawCreate(554.000000, 414.000000, "_");
	TextDrawBackgroundColor(General[4], 255);
	TextDrawFont(General[4], 1);
	TextDrawLetterSize(General[4], 0.500000, 2.599999);
	TextDrawColor(General[4], -1);
	TextDrawSetOutline(General[4], 0);
	TextDrawSetProportional(General[4], 1);
	TextDrawSetShadow(General[4], 1);
	TextDrawUseBox(General[4], 1);
	TextDrawBoxColor(General[4], 120);
	TextDrawTextSize(General[4], 550.000000, 0.000000);

	Gear[0] = TextDrawCreate(558.000000, 430.000000, "_");
	TextDrawBackgroundColor(Gear[0], 255);
	TextDrawFont(Gear[0], 1);
	TextDrawLetterSize(Gear[0], 0.500000, 0.399999);
	TextDrawColor(Gear[0], -1);
	TextDrawSetOutline(Gear[0], 0);
	TextDrawSetProportional(Gear[0], 1);
	TextDrawSetShadow(Gear[0], 1);
	TextDrawUseBox(Gear[0], 1);
	TextDrawBoxColor(Gear[0], -1);
	TextDrawTextSize(Gear[0], 553.000000, 0.000000);

	Gear[1] = TextDrawCreate(562.000000, 427.399993, "_");
	TextDrawBackgroundColor(Gear[1], 255);
	TextDrawFont(Gear[1], 1);
	TextDrawLetterSize(Gear[1], 0.549999, 0.699999);
	TextDrawColor(Gear[1], -1);
	TextDrawSetOutline(Gear[1], 0);
	TextDrawSetProportional(Gear[1], 1);
	TextDrawSetShadow(Gear[1], 1);
	TextDrawUseBox(Gear[1], 1);
	TextDrawBoxColor(Gear[1], -151807233);
	TextDrawTextSize(Gear[1], 557.000000, 0.000000);

	Gear[2] = TextDrawCreate(566.000000, 424.600006, "_");
	TextDrawBackgroundColor(Gear[2], 255);
	TextDrawFont(Gear[2], 1);
	TextDrawLetterSize(Gear[2], 0.549999, 1.000000);
	TextDrawColor(Gear[2], -1);
	TextDrawSetOutline(Gear[2], 0);
	TextDrawSetProportional(Gear[2], 1);
	TextDrawSetShadow(Gear[2], 1);
	TextDrawUseBox(Gear[2], 1);
	TextDrawBoxColor(Gear[2], -1823745);
	TextDrawTextSize(Gear[2], 561.000000, 0.000000);

	Gear[3] = TextDrawCreate(570.000000, 422.000000, "_");
	TextDrawBackgroundColor(Gear[3], 255);
	TextDrawFont(Gear[3], 1);
	TextDrawLetterSize(Gear[3], 0.549999, 1.300000);
	TextDrawColor(Gear[3], -1);
	TextDrawSetOutline(Gear[3], 0);
	TextDrawSetProportional(Gear[3], 1);
	TextDrawSetShadow(Gear[3], 1);
	TextDrawUseBox(Gear[3], 1);
	TextDrawBoxColor(Gear[3], -1813566465);
	TextDrawTextSize(Gear[3], 565.000000, 0.000000);

	Gear[4] = TextDrawCreate(574.000000, 419.299987, "_");
	TextDrawBackgroundColor(Gear[4], 255);
	TextDrawFont(Gear[4], 1);
	TextDrawLetterSize(Gear[4], 0.549999, 1.600000);
	TextDrawColor(Gear[4], -1);
	TextDrawSetOutline(Gear[4], 0);
	TextDrawSetProportional(Gear[4], 1);
	TextDrawSetShadow(Gear[4], 1);
	TextDrawUseBox(Gear[4], 1);
	TextDrawBoxColor(Gear[4], -1813566465);
	TextDrawTextSize(Gear[4], 569.000000, 0.000000);

	Gear[5] = TextDrawCreate(578.000000, 417.299987, "_");
	TextDrawBackgroundColor(Gear[5], 255);
	TextDrawFont(Gear[5], 1);
	TextDrawLetterSize(Gear[5], 0.549999, 1.800000);
	TextDrawColor(Gear[5], -1);
	TextDrawSetOutline(Gear[5], 0);
	TextDrawSetProportional(Gear[5], 1);
	TextDrawSetShadow(Gear[5], 1);
	TextDrawUseBox(Gear[5], 1);
	TextDrawBoxColor(Gear[5], -16776961);
	TextDrawTextSize(Gear[5], 573.000000, 0.000000);

	print("\n--------------------------------------");
	print(" Mechanical Transmission by wups");
	print("--------------------------------------\n");
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	KillTimer(tbegiai[playerid]);
	return 1;
}

public OnPlayerConnect(playerid)
{
    GearInfo[playerid] = TextDrawCreate(596.000000, 425.000000, "~w~R ~g~~h~N ~w~D");
	TextDrawBackgroundColor(GearInfo[playerid], 255);
	TextDrawFont(GearInfo[playerid], 1);
	TextDrawLetterSize(GearInfo[playerid], 0.320000, 1.299999);
	TextDrawColor(GearInfo[playerid], -1);
	TextDrawSetOutline(GearInfo[playerid], 0);
	TextDrawSetProportional(GearInfo[playerid], 1);
	TextDrawSetShadow(GearInfo[playerid], 1);

	Speedo[playerid] = TextDrawCreate(579.000000, 414.000000, "255 ~w~km/h");
	TextDrawBackgroundColor(Speedo[playerid], 0x000000FF);
	TextDrawFont(Speedo[playerid], 1);
	TextDrawLetterSize(Speedo[playerid], 0.170000, 0.799999);
	TextDrawColor(Speedo[playerid], 0xA803D0FF);
	TextDrawSetOutline(Speedo[playerid], 0);
	TextDrawSetProportional(Speedo[playerid], 1);
	TextDrawSetShadow(Speedo[playerid], 1);

    tbegiai[playerid] = SetTimerEx("ShiftFunction",150,true,"i",playerid);
	return 1;
}

stock GetSpeed(playerid)
{
	new Float:ST[3];
	GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);

	return floatround(1.61*floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 100.3);
}

public ShiftFunction(playerid)
{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new
			    Float: Speed,
			    string[128],
				veh = GetPlayerVehicleID(playerid),
				model = GetVehicleModel(veh),
				gear
			;
			if(model == 481 || model == 510 || model == 509) return 1; // bikes
			Loop(x, 5) TextDrawShowForPlayer(playerid, General[x]);
			if(!IsVehicleDrivingBackwards(veh))
			{
				Speed = GetSpeed(playerid);
				gear = begis[veh];

				format(string, sizeof(string), "%0.0f ~w~km/h", Speed), TextDrawSetString(Speedo[playerid], string), TextDrawShowForPlayer(playerid, Speedo[playerid]);

				if(Speed > 300)
				{
					TogglePlayerControllable(playerid,false);
					SetTimerEx("Atfreezint",500,false,"i",playerid);
				}
				if(gear == 6)
				{
					if(Speed > 180)
				    {
				        Loop(s, 6) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=6;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~6"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
						return 1;
					}
					else if(Speed > 165)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 5) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=5;
						ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~6"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 160)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 4) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=4;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~6"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 155)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 3) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=3;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~6"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 150)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 2) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=2;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~6"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 130)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 1) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=1;
				        ispejimai[veh]=0;
				       	TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~6"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed < 130)
				    {
				        ispejimai[veh]++;
				    	if(ispejimai[veh]==20)
				    	{
							begis[veh]--;
							ispejimai[veh]=0;
						}
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 1) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=1;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~g~~h~N ~w~6"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
				}
				else if(gear == 5)
				{
					if(Speed > 150)
				    {
				        Loop(s, 6) TextDrawShowForPlayer(playerid, Gear[s]);
				    	ispejimai[veh]++;
				    	if(ispejimai[veh]==15)
				    	{
							begis[veh]++;
							SlowenVehicle(veh, 1.5);
							ispejimai[veh]=0;
						}
						gulsciukas[veh]=6;
						TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~5"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 135)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 5) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=5;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~5"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 130)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 4) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=4;
						ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~5"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 125)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 3) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=3;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~5"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 120)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 2) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=2;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~5"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed < 120)
				    {
				        ispejimai[veh]++;
				    	if(ispejimai[veh]==20)
				    	{
							begis[veh]--;
							ispejimai[veh]=0;
						}
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 1) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=1;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~g~~h~N ~w~5"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}

				}
				else if(gear == 4)
				{
					if(Speed > 120)
				    {
				        Loop(s, 6) TextDrawShowForPlayer(playerid, Gear[s]);
				    	ispejimai[veh]++;
				    	if(ispejimai[veh]==15)
				    	{
							begis[veh]++;
							SlowenVehicle(veh, 1.5);
							ispejimai[veh]=0;
						}
						gulsciukas[veh]=6;
						TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~4"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 110)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 5) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=5;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~4"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 105)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 4) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=4;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~4"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 100)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 3) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=3;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~4"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 90)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 2) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=2;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~4"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed < 90)
				    {
				        ispejimai[veh]++;
				    	if(ispejimai[veh]==20)
				    	{
							begis[veh]--;
							ispejimai[veh]=0;
						}
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 1) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=1;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~g~~h~N ~w~4"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
				}
				else if(gear == 3)
				{
					if(Speed > 90)
				    {
				        Loop(s, 6) TextDrawShowForPlayer(playerid, Gear[s]);
				    	ispejimai[veh]++;
				    	if(ispejimai[veh]==15)
				    	{
							begis[veh]++;
							SlowenVehicle(veh, 1.5);
							ispejimai[veh]=0;
						}
						gulsciukas[veh]=6;
						TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~3"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 80)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 5) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=5;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~3"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 75)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 4) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=4;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~3"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 70)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 3) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=3;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~3"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 60)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 2) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=2;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~3"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed < 60)
				    {
				        ispejimai[veh]++;
				    	if(ispejimai[veh]==20)
				    	{
							begis[veh]--;
							ispejimai[veh]=0;
						}
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 1) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=1;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~g~~h~N ~w~3"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}

				}
				else if(gear == 2)
				{
					if(Speed > 60)
				    {
				        Loop(s, 6) TextDrawShowForPlayer(playerid, Gear[s]);
				    	ispejimai[veh]++;
				    	if(ispejimai[veh]==15)
				    	{
							begis[veh]++;
							SlowenVehicle(veh, 1.5);
							ispejimai[veh]=0;
						}
						gulsciukas[veh]=6;
						TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~2"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 50)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 5) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=5;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~2"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 45)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 4) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=4;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~2"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 40)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 3) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=3;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~2"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 30)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 2) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=2;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~2"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed < 30)
				    {
				        ispejimai[veh]++;
				    	if(ispejimai[veh]==20)
				    	{
							begis[veh]--;
							ispejimai[veh]=0;
						}
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 1) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=1;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~g~~h~N ~w~2"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
				}
				else if(gear == 1)
				{
				    if(Speed > 30)
				    {
				        Loop(s, 6) TextDrawShowForPlayer(playerid, Gear[s]);
				    	ispejimai[veh]++;
				    	if(ispejimai[veh]==15)
				    	{
							begis[veh]++;
							SlowenVehicle(veh, 1.5);
							ispejimai[veh]=0;
						}
						gulsciukas[veh]=6;
						TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~1"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 20)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 5) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=5;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~1"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 15)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 4) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=4;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~1"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 10)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 3) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=3;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~1"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 5)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 2) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=2;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~w~N ~g~~h~1"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
					else if(Speed > 0)
				    {
				        Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
				        Loop(s, 1) TextDrawShowForPlayer(playerid, Gear[s]);
				        gulsciukas[veh]=1;
				        ispejimai[veh]=0;
				        TextDrawSetString(GearInfo[playerid], "~w~R ~g~~h~N ~w~1"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
                        return 1;
					}
		   		}
			}
			else
			{
			    begis[veh]=1;
				Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
	   			TextDrawSetString(GearInfo[playerid], "~g~~h~R ~w~N D"), TextDrawShowForPlayer(playerid, GearInfo[playerid]);
	   			TextDrawSetString(Speedo[playerid], "- ~w~km/h"), TextDrawShowForPlayer(playerid, Speedo[playerid]);
                return 1;
			}
		}
		else
		{
		    Loop(x, 5) TextDrawHideForPlayer(playerid, General[x]);
		    TextDrawHideForPlayer(playerid, Speedo[playerid]);
		    TextDrawHideForPlayer(playerid, GearInfo[playerid]);
		    Loop(s, 6) TextDrawHideForPlayer(playerid, Gear[s]);
		}
		return 1;
}


stock IsVehicleDrivingBackwards(vehicleid) // By Joker
{
	new
		Float:Float[3]
	;
	if(GetVehicleVelocity(vehicleid, Float[1], Float[2], Float[0]))
	{
		GetVehicleZAngle(vehicleid, Float[0]);
		if(Float[0] < 90)
		{
			if(Float[1] > 0 && Float[2] < 0) return true;
		}
		else if(Float[0] < 180)
		{
			if(Float[1] > 0 && Float[2] > 0) return true;
		}
		else if(Float[0] < 270)
		{
			if(Float[1] < 0 && Float[2] > 0) return true;
		}
		else if(Float[1] < 0 && Float[2] < 0) return true;
	}
	return false;
}

stock SlowenVehicle(vid,Float:dalmuo)
{
    new Float:T[3];
	GetVehicleVelocity(vid, T[0], T[1], T[2]);

    return
			SetVehicleVelocity(vid,T[0] / dalmuo , T[1] / dalmuo , T[2]);
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
	    new veh = GetPlayerVehicleID(playerid);
		new gear = begis[veh];
		new stulp = gulsciukas[veh];

		if(newkeys & GEAR_KEY)
		{
		    if(gear !=6)
		    {
            	if(stulp == 4 || stulp == 5)
				{
					begis[veh]++;
					gulsciukas[veh]=1;
					ispejimai[veh]=0;
				}
            	else if(stulp == 6 || stulp == 3)
            	{
            	    begis[veh]++;
            	    ispejimai[veh]=0;
            	    gulsciukas[veh]=1;
            	    SlowenVehicle(veh,1.3);
				}
			}
		}

	}
}