/*
	tRechner v0.2 by Theo
	with Textdraws

*/

#include <a_samp>
#include <zcmd>


new zahl[MAX_PLAYERS][10],
	azahl[MAX_PLAYERS][10],
	rrechnung[MAX_PLAYERS],
	ergeb[MAX_PLAYERS],
	rech[MAX_PLAYERS][5],
	rechi[MAX_PLAYERS][25];

new
	Text:box[MAX_PLAYERS],
	Text:Line1[MAX_PLAYERS],
	Text:Line2[MAX_PLAYERS],
	Text:Line3[MAX_PLAYERS],
	Text:Line4[MAX_PLAYERS],
	Text:tdbox[MAX_PLAYERS][11],
	Text:zahl1[MAX_PLAYERS],
	Text:zahl2[MAX_PLAYERS],
	Text:zahl3[MAX_PLAYERS],
	Text:zahl4[MAX_PLAYERS],
	Text:zahl5[MAX_PLAYERS],
	Text:zahl6[MAX_PLAYERS],
	Text:zahl7[MAX_PLAYERS],
	Text:zahl8[MAX_PLAYERS],
	Text:zahl9[MAX_PLAYERS],
	Text:plus[MAX_PLAYERS],
	Text:minus[MAX_PLAYERS],
	Text:mal[MAX_PLAYERS],
	Text:geteilt[MAX_PLAYERS],
	Text:gleich[MAX_PLAYERS],
	Text:ergebniss[MAX_PLAYERS],
	Text:rechnung[MAX_PLAYERS],
	Text:exxit[MAX_PLAYERS],
	Text:neu[MAX_PLAYERS],
	Text:Logo[MAX_PLAYERS];



public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");

	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	rrechnung[playerid] = 0;

    box[playerid] = TextDrawCreate(374.941, 136.250, "box");
	TextDrawLetterSize(box[playerid], 0.000, 24.885);
	TextDrawTextSize(box[playerid], 239.287, 0.000);
	TextDrawAlignment(box[playerid], 1);
	TextDrawColor(box[playerid], 0);
	TextDrawUseBox(box[playerid], 1);
	TextDrawBoxColor(box[playerid], 188);
	TextDrawFont(box[playerid], 0);
	
	Line1[playerid] = TextDrawCreate(236.791, 367.583, "LD_NONE:tvcorn");
	TextDrawTextSize(Line1[playerid], 63.715, -126.000);
	TextDrawAlignment(Line1[playerid], 1);
	TextDrawColor(Line1[playerid], -1);
	TextDrawFont(Line1[playerid], 4);
	
	Line2[playerid] = TextDrawCreate(377.846, 368.083, "LD_NONE:tvcorn");
	TextDrawTextSize(Line2[playerid], -77.305, -129.498);
	TextDrawAlignment(Line2[playerid], 1);
	TextDrawColor(Line2[playerid], -1);
	TextDrawFont(Line2[playerid], 4);
	
	Line3[playerid] = TextDrawCreate(377.410, 129.416, "LD_NONE:tvcorn");
	TextDrawTextSize(Line3[playerid], -72.620, 113.166);
	TextDrawAlignment(Line3[playerid], 1);
	TextDrawColor(Line3[playerid], -1);
	TextDrawFont(Line3[playerid], 4);

	Line4[playerid] = TextDrawCreate(236.291, 129.082, "LD_NONE:tvcorn");
	TextDrawTextSize(Line4[playerid], 68.872, 114.333);
	TextDrawAlignment(Line4[playerid], 1);
	TextDrawColor(Line4[playerid], -1);
	TextDrawFont(Line4[playerid], 4);
	
	tdbox[playerid][0] = TextDrawCreate(359.013, 174.166, "box");
	TextDrawLetterSize(tdbox[playerid][0], 0.000, 2.404);
	TextDrawTextSize(tdbox[playerid][0], 253.343, 0.000);
	TextDrawAlignment(tdbox[playerid][0], 1);
	TextDrawColor(tdbox[playerid][0], 0);
	TextDrawUseBox(tdbox[playerid][0], 1);
	TextDrawBoxColor(tdbox[playerid][0], 659344823);
	TextDrawFont(tdbox[playerid][0], 0);

	tdbox[playerid][1] = TextDrawCreate(276.114, 206.166, "box");
	TextDrawLetterSize(tdbox[playerid][1], 0.000, 2.029);
	TextDrawTextSize(tdbox[playerid][1], 253.343, 0.000);
	TextDrawAlignment(tdbox[playerid][1], 1);
	TextDrawColor(tdbox[playerid][1], 0);
	TextDrawUseBox(tdbox[playerid][1], 1);
	TextDrawBoxColor(tdbox[playerid][1], 659344823);
	TextDrawFont(tdbox[playerid][1], 0);
	
	tdbox[playerid][2] = TextDrawCreate(296.294, 206.082, "box");
	TextDrawLetterSize(tdbox[playerid][2], 0.000, 2.029);
	TextDrawTextSize(tdbox[playerid][2], 273.022, 0.000);
	TextDrawAlignment(tdbox[playerid][2], 1);
	TextDrawColor(tdbox[playerid][2], 0);
	TextDrawUseBox(tdbox[playerid][2], 1);
	TextDrawBoxColor(tdbox[playerid][2], 659344823);
	TextDrawFont(tdbox[playerid][2], 0);
	
	tdbox[playerid][3] = TextDrawCreate(316.941, 205.998, "box");
	TextDrawLetterSize(tdbox[playerid][3], 0.000, 2.029);
	TextDrawTextSize(tdbox[playerid][3], 293.169, 0.000);
	TextDrawAlignment(tdbox[playerid][3], 1);
	TextDrawColor(tdbox[playerid][3], 0);
	TextDrawUseBox(tdbox[playerid][3], 1);
	TextDrawBoxColor(tdbox[playerid][3], 659344823);
	TextDrawFont(tdbox[playerid][3], 0);

	tdbox[playerid][4] = TextDrawCreate(296.325, 229.914, "box");
	TextDrawLetterSize(tdbox[playerid][4], 0.000, 2.029);
	TextDrawTextSize(tdbox[playerid][4], 273.022, 0.000);
	TextDrawAlignment(tdbox[playerid][4], 1);
	TextDrawColor(tdbox[playerid][4], 0);
	TextDrawUseBox(tdbox[playerid][4], 1);
	TextDrawBoxColor(tdbox[playerid][4], 659344823);
	TextDrawFont(tdbox[playerid][4], 0);

	tdbox[playerid][5] = TextDrawCreate(316.971, 230.414, "box");
	TextDrawLetterSize(tdbox[playerid][5], 0.000, 1.980);
	TextDrawTextSize(tdbox[playerid][5], 293.166, 0.000);
	TextDrawAlignment(tdbox[playerid][5], 1);
	TextDrawColor(tdbox[playerid][5], 0);
	TextDrawUseBox(tdbox[playerid][5], 1);
	TextDrawBoxColor(tdbox[playerid][5], 659344823);
	TextDrawFont(tdbox[playerid][5], 0);

	tdbox[playerid][6] = TextDrawCreate(276.239, 230.330, "box");
	TextDrawLetterSize(tdbox[playerid][6], 0.000, 1.980);
	TextDrawTextSize(tdbox[playerid][6], 253.343, 0.000);
	TextDrawAlignment(tdbox[playerid][6], 1);
	TextDrawColor(tdbox[playerid][6], 0);
	TextDrawUseBox(tdbox[playerid][6], 1);
	TextDrawBoxColor(tdbox[playerid][6], 659344823);
	TextDrawBackgroundColor(tdbox[playerid][6], 102);
	TextDrawFont(tdbox[playerid][6], 0);

	tdbox[playerid][7] = TextDrawCreate(275.802, 254.162, "box");
	TextDrawLetterSize(tdbox[playerid][7], 0.000, 1.980);
	TextDrawTextSize(tdbox[playerid][7], 253.343, 0.000);
	TextDrawAlignment(tdbox[playerid][7], 1);
	TextDrawColor(tdbox[playerid][7], 0);
	TextDrawUseBox(tdbox[playerid][7], 1);
	TextDrawBoxColor(tdbox[playerid][7], 659344823);
	TextDrawBackgroundColor(tdbox[playerid][7], 102);
	TextDrawFont(tdbox[playerid][7], 0);

	tdbox[playerid][8] = TextDrawCreate(296.449, 254.080, "box");
	TextDrawLetterSize(tdbox[playerid][8], 0.000, 2.026);
	TextDrawTextSize(tdbox[playerid][8], 272.552, 0.000);
	TextDrawAlignment(tdbox[playerid][8], 1);
	TextDrawColor(tdbox[playerid][8], 0);
	TextDrawUseBox(tdbox[playerid][8], 1);
	TextDrawBoxColor(tdbox[playerid][8], 659344823);
	TextDrawBackgroundColor(tdbox[playerid][8], 102);
	TextDrawFont(tdbox[playerid][8], 0);

	tdbox[playerid][9] = TextDrawCreate(317.095, 253.996, "box");
	TextDrawLetterSize(tdbox[playerid][9], 0.000, 2.026);
	TextDrawTextSize(tdbox[playerid][9], 293.165, 0.000);
	TextDrawAlignment(tdbox[playerid][9], 1);
	TextDrawColor(tdbox[playerid][9], 0);
	TextDrawUseBox(tdbox[playerid][9], 1);
	TextDrawBoxColor(tdbox[playerid][9], 659344823);
	TextDrawBackgroundColor(tdbox[playerid][9], 102);
	TextDrawFont(tdbox[playerid][9], 1);
	
	tdbox[playerid][10] = TextDrawCreate(318.532, 290.079, "box");
	TextDrawLetterSize(tdbox[playerid][10], 0.000, 5.585);
	TextDrawTextSize(tdbox[playerid][10], 253.341, 0.000);
	TextDrawAlignment(tdbox[playerid][10], 1);
	TextDrawColor(tdbox[playerid][10], 0);
	TextDrawUseBox(tdbox[playerid][10], 1);
	TextDrawBoxColor(tdbox[playerid][10], 659344823);
	TextDrawBackgroundColor(tdbox[playerid][10], 102);
	TextDrawFont(tdbox[playerid][10], 1);
	
	zahl1[playerid] = TextDrawCreate(259.558, 208.248, "1");
	TextDrawLetterSize(zahl1[playerid], 0.449, 1.600);
	TextDrawAlignment(zahl1[playerid], 1);
	TextDrawColor(zahl1[playerid], -1);
	TextDrawSetOutline(zahl1[playerid], 1);
	TextDrawBackgroundColor(zahl1[playerid], 51);
	TextDrawFont(zahl1[playerid], 1);
	TextDrawSetProportional(zahl1[playerid], 1);
	TextDrawSetSelectable(zahl1[playerid], true);
	TextDrawTextSize(zahl1[playerid],270,15);

	zahl2[playerid] = TextDrawCreate(279.269, 208.748, "2");
	TextDrawLetterSize(zahl2[playerid], 0.449, 1.600);
	TextDrawAlignment(zahl2[playerid], 1);
	TextDrawColor(zahl2[playerid], -1);
	TextDrawSetOutline(zahl2[playerid], 1);
	TextDrawBackgroundColor(zahl2[playerid], 51);
	TextDrawFont(zahl2[playerid], 1);
	TextDrawSetProportional(zahl2[playerid], 1);
	TextDrawSetSelectable(zahl2[playerid], true);
	TextDrawTextSize(zahl2[playerid],290,15);

	zahl3[playerid] = TextDrawCreate(299.915, 208.666, "3");
	TextDrawLetterSize(zahl3[playerid], 0.449, 1.600);
	TextDrawAlignment(zahl3[playerid], 1);
	TextDrawColor(zahl3[playerid], -1);
	TextDrawSetOutline(zahl3[playerid], 1);
	TextDrawBackgroundColor(zahl3[playerid], 51);
	TextDrawFont(zahl3[playerid], 1);
	TextDrawSetProportional(zahl3[playerid], 1);
	TextDrawSetSelectable(zahl3[playerid], true);
	TextDrawTextSize(zahl3[playerid],310,15);

	zahl4[playerid] = TextDrawCreate(259.653, 232.498, "4");
	TextDrawLetterSize(zahl4[playerid], 0.449, 1.600);
	TextDrawAlignment(zahl4[playerid], 1);
	TextDrawColor(zahl4[playerid], -1);
	TextDrawSetOutline(zahl4[playerid], 1);
	TextDrawBackgroundColor(zahl4[playerid], 51);
	TextDrawFont(zahl4[playerid], 1);
	TextDrawSetProportional(zahl4[playerid], 1);
	TextDrawSetSelectable(zahl4[playerid], true);
	TextDrawTextSize(zahl4[playerid],270,15);

	zahl5[playerid] = TextDrawCreate(280.302, 232.416, "5");
	TextDrawLetterSize(zahl5[playerid], 0.449, 1.600);
	TextDrawAlignment(zahl5[playerid], 1);
	TextDrawColor(zahl5[playerid], -1);
	TextDrawSetOutline(zahl5[playerid], 1);
	TextDrawBackgroundColor(zahl5[playerid], 51);
	TextDrawFont(zahl5[playerid], 1);
	TextDrawSetProportional(zahl5[playerid], 1);
	TextDrawSetSelectable(zahl5[playerid], true);
	TextDrawTextSize(zahl5[playerid],290,15);

	zahl6[playerid] = TextDrawCreate(300.480, 232.332, "6");
	TextDrawLetterSize(zahl6[playerid], 0.449, 1.600);
	TextDrawAlignment(zahl6[playerid], 1);
	TextDrawColor(zahl6[playerid], -1);
	TextDrawSetOutline(zahl6[playerid], 1);
	TextDrawBackgroundColor(zahl6[playerid], 51);
	TextDrawFont(zahl6[playerid], 1);
	TextDrawSetProportional(zahl6[playerid], 1);
	TextDrawSetSelectable(zahl6[playerid], true);
	TextDrawTextSize(zahl6[playerid],310,15);

	zahl7[playerid] = TextDrawCreate(259.747, 256.747, "7");
	TextDrawLetterSize(zahl7[playerid], 0.449, 1.600);
	TextDrawAlignment(zahl7[playerid], 1);
	TextDrawColor(zahl7[playerid], -1);
	TextDrawSetOutline(zahl7[playerid], 1);
	TextDrawBackgroundColor(zahl7[playerid], 51);
	TextDrawFont(zahl7[playerid], 1);
	TextDrawSetProportional(zahl7[playerid], 1);
	TextDrawSetSelectable(zahl7[playerid], true);
	TextDrawTextSize(zahl7[playerid],270,15);

	zahl8[playerid] = TextDrawCreate(279.459, 256.665, "8");
	TextDrawLetterSize(zahl8[playerid], 0.449, 1.600);
	TextDrawAlignment(zahl8[playerid], 1);
	TextDrawColor(zahl8[playerid], -1);
	TextDrawSetOutline(zahl8[playerid], 1);
	TextDrawBackgroundColor(zahl8[playerid], 51);
	TextDrawFont(zahl8[playerid], 1);
	TextDrawSetProportional(zahl8[playerid], 1);
	TextDrawSetSelectable(zahl8[playerid], true);
	TextDrawTextSize(zahl8[playerid],290,15);

	zahl9[playerid] = TextDrawCreate(300.574, 256.583, "9");
	TextDrawLetterSize(zahl9[playerid], 0.449, 1.600);
	TextDrawAlignment(zahl9[playerid], 1);
	TextDrawColor(zahl9[playerid], -1);
	TextDrawSetOutline(zahl9[playerid], 1);
	TextDrawBackgroundColor(zahl9[playerid], 51);
	TextDrawFont(zahl9[playerid], 1);
	TextDrawSetProportional(zahl9[playerid], 1);
	TextDrawSetSelectable(zahl9[playerid], true);
	TextDrawTextSize(zahl9[playerid],310,15);


	plus[playerid] = TextDrawCreate(259.842, 293.247, "+");
	TextDrawLetterSize(plus[playerid], 0.449, 1.600);
	TextDrawAlignment(plus[playerid], 1);
	TextDrawColor(plus[playerid], -1);
	TextDrawSetOutline(plus[playerid], 1);
	TextDrawBackgroundColor(plus[playerid], 51);
	TextDrawFont(plus[playerid], 1);
	TextDrawSetProportional(plus[playerid], 1);
	TextDrawSetSelectable(plus[playerid], true);
	TextDrawTextSize(plus[playerid],270,15);

	geteilt[playerid] = TextDrawCreate(302.979, 293.165, ":");
	TextDrawLetterSize(geteilt[playerid], 0.449, 1.600);
	TextDrawAlignment(geteilt[playerid], 1);
	TextDrawColor(geteilt[playerid], -1);
	TextDrawSetOutline(geteilt[playerid], 1);
	TextDrawBackgroundColor(geteilt[playerid], 51);
	TextDrawFont(geteilt[playerid], 1);
	TextDrawSetProportional(geteilt[playerid], 1);
	TextDrawSetSelectable(geteilt[playerid], true);
    TextDrawTextSize(geteilt[playerid],310,15);

	minus[playerid] = TextDrawCreate(275.368, 293.083, "-");
	TextDrawLetterSize(minus[playerid], 0.449, 1.600);
	TextDrawAlignment(minus[playerid], 1);
	TextDrawColor(minus[playerid], -1);
	TextDrawSetOutline(minus[playerid], 1);
	TextDrawBackgroundColor(minus[playerid], 51);
	TextDrawFont(minus[playerid], 1);
	TextDrawSetProportional(minus[playerid], 1);
	TextDrawSetSelectable(minus[playerid], true);
	TextDrawTextSize(minus[playerid],285,15);

	mal[playerid] = TextDrawCreate(287.113, 293.583, "x");
	TextDrawLetterSize(mal[playerid], 0.449, 1.600);
	TextDrawAlignment(mal[playerid], 1);
	TextDrawColor(mal[playerid], -1);
	TextDrawSetOutline(mal[playerid], 1);
	TextDrawBackgroundColor(mal[playerid], 51);
	TextDrawFont(mal[playerid], 1);
	TextDrawSetProportional(mal[playerid], 1);
	TextDrawSetSelectable(mal[playerid], true);
	TextDrawTextSize(mal[playerid],297,15);

	gleich[playerid] = TextDrawCreate(255.753, 321.497, "=");
	TextDrawLetterSize(gleich[playerid], 0.587, 2.328);
	TextDrawTextSize(gleich[playerid], 29.048, 37.333);
	TextDrawAlignment(gleich[playerid], 1);
	TextDrawColor(gleich[playerid], -1);
	TextDrawSetOutline(gleich[playerid], 1);
	TextDrawBackgroundColor(gleich[playerid], 51);
	TextDrawFont(gleich[playerid], 1);
	TextDrawSetProportional(gleich[playerid], 1);
	TextDrawSetSelectable(gleich[playerid], true);
	TextDrawTextSize(gleich[playerid],265,15);

	ergebniss[playerid] = TextDrawCreate(270.777, 325.497, "1234");
	TextDrawLetterSize(ergebniss[playerid], 0.379, 1.518);
	TextDrawTextSize(ergebniss[playerid], 29.048, 37.333);
	TextDrawAlignment(ergebniss[playerid], 1);
	TextDrawColor(ergebniss[playerid], -1);
	TextDrawSetOutline(ergebniss[playerid], 1);
	TextDrawBackgroundColor(ergebniss[playerid], 51);
	TextDrawFont(ergebniss[playerid], 1);
	TextDrawSetProportional(ergebniss[playerid], 1);
	TextDrawSetSelectable(ergebniss[playerid], true);

	rechnung[playerid] = TextDrawCreate(260.968, 180.164, "12+12");
	TextDrawLetterSize(rechnung[playerid], 0.379, 1.518);
	TextDrawTextSize(rechnung[playerid], 29.048, 37.333);
	TextDrawAlignment(rechnung[playerid], 1);
	TextDrawColor(rechnung[playerid], -1);
	TextDrawBackgroundColor(rechnung[playerid], 51);
	TextDrawFont(rechnung[playerid], 1);
	TextDrawSetProportional(rechnung[playerid], 1);
	TextDrawSetSelectable(rechnung[playerid], true);
	
	exxit[playerid] = TextDrawCreate(360.824, 130.500, "LD_CHAT:thumbdn");
	TextDrawTextSize(exxit[playerid], 15.461, 12.248);
	TextDrawAlignment(exxit[playerid], 1);
	TextDrawColor(exxit[playerid], -1);
	TextDrawFont(exxit[playerid], 4);
	TextDrawSetSelectable(exxit[playerid], true);
	
	neu[playerid] = TextDrawCreate(321.872, 204.750, "~>~Neu");
	TextDrawLetterSize(neu[playerid], 0.365, 1.353);
	TextDrawAlignment(neu[playerid], 1);
	TextDrawColor(neu[playerid], -1);
	TextDrawSetOutline(neu[playerid], 1);
	TextDrawBackgroundColor(neu[playerid], 51);
	TextDrawFont(neu[playerid], 2);
	TextDrawSetProportional(neu[playerid], 1);
	TextDrawSetSelectable(neu[playerid], true);
	TextDrawTextSize(neu[playerid],335, 15);

	Logo[playerid] = TextDrawCreate(264.713, 117.833, "tRechner v0.2");
	TextDrawLetterSize(Logo[playerid], 0.312, 1.220);
	TextDrawAlignment(Logo[playerid], 1);
	TextDrawColor(Logo[playerid], 933625855);
	TextDrawSetOutline(Logo[playerid], 1);
	TextDrawBackgroundColor(Logo[playerid], 51);
	TextDrawFont(Logo[playerid], 3);
	TextDrawSetProportional(Logo[playerid], 1);

	return 1;
}


public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == zahl1[playerid])
	{
	    if(rrechnung[playerid] == 0)
	    {
			strcat(zahl[playerid], "1");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "1");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
		}
		else
		{
            strcat(azahl[playerid], "1");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "1");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
		}
	}
	if(clickedid == zahl2[playerid])
	{
	    if(rrechnung[playerid] == 0)
	    {
	    	strcat(zahl[playerid], "2");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "2");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
		}
		else
		{
            strcat(azahl[playerid], "2");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid],"2");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
		}
	}
	if(clickedid == zahl3[playerid])
	{
	    if(rrechnung[playerid] == 0)
	    {
			strcat(zahl[playerid], "3");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "3");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
		}
		else
		{
            strcat(azahl[playerid], "3");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "3");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
		}
	}
	if(clickedid == zahl4[playerid])
	{
	    if(rrechnung[playerid] == 0)
	    {
			strcat(zahl[playerid], "4");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "4");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
		}
		else
		{
            strcat(azahl[playerid], "4");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "4");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);

		}
	}
	if(clickedid == zahl5[playerid])
	{
	    if(rrechnung[playerid] == 0)
	    {
			strcat(zahl[playerid], "5");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "5");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
		}
		else
		{
            strcat(azahl[playerid], "5");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "5");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
		}
	}
	if(clickedid == zahl6[playerid])
	{
	    if(rrechnung[playerid] == 0)
	    {
			strcat(zahl[playerid], "6");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "6");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
		}
		else
		{
            strcat(azahl[playerid], "6");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "6");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
		}
	}
	if(clickedid == zahl7[playerid])
	{
	    if(rrechnung[playerid] == 0)
	    {
			strcat(zahl[playerid], "7");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "7");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
			
		}
		else
		{
            strcat(azahl[playerid], "7");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "7");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
			
		}
	}
	if(clickedid == zahl8[playerid])
	{
	    if(rrechnung[playerid] == 0)
	    {
			strcat(zahl[playerid], "8");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "8");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
		}
		else
		{
            strcat(azahl[playerid], "8");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "8");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);

		}
	}
	if(clickedid == zahl9[playerid])
	{
	    if(rrechnung[playerid] == 0)
	    {
			strcat(zahl[playerid], "9");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "9");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
		}
		else
		{
            strcat(azahl[playerid], "9");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "9");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
		}
	}
	if(clickedid == plus[playerid])
	{
		if(rrechnung[playerid] == 0)
		{
			rrechnung[playerid] = 1;
			strcat(rech[playerid], "+");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "+");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
		}
	}
	if(clickedid == minus[playerid])
	{
		if(rrechnung[playerid] == 0)
		{
			rrechnung[playerid] = 2;
			strcat(rech[playerid], "-");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "-");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
		}
	}
	if(clickedid == mal[playerid])
	{
		if(rrechnung[playerid] == 0)
		{
			rrechnung[playerid] = 3;
			strcat(rech[playerid], "x");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], "x");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
			
		}
	}
	if(clickedid == geteilt[playerid])
	{
		if(rrechnung[playerid] == 0)
		{
			rrechnung[playerid] = 4;
			strcat(rech[playerid], ":");
			TextDrawShowForPlayer(playerid, rechnung[playerid]);
			strcat(rechi[playerid], ":");
			TextDrawSetString(rechnung[playerid], rechi[playerid]);
		}
	}
	if(clickedid == gleich[playerid])
	{
	    new string[128];
		if(rrechnung[playerid] >= 1)
		{
			if(rrechnung[playerid] == 1)
			{
				ergeb[playerid] = strval(zahl[playerid]) + strval(azahl[playerid]);
				TextDrawShowForPlayer(playerid, ergebniss[playerid]);
				format(string, 128, "%d", ergeb[playerid]);
				TextDrawSetString(ergebniss[playerid], string);
			}
			if(rrechnung[playerid] == 2)
			{
				ergeb[playerid] = strval(zahl[playerid]) - strval(azahl[playerid]);
				TextDrawShowForPlayer(playerid, ergebniss[playerid]);
				format(string, 128, "%d", ergeb[playerid]);
				TextDrawSetString(ergebniss[playerid], string);
			}
			if(rrechnung[playerid] == 3)
			{
				ergeb[playerid] = strval(zahl[playerid]) * strval(azahl[playerid]);
				TextDrawShowForPlayer(playerid, ergebniss[playerid]);
				format(string, 128, "%d", ergeb[playerid]);
				TextDrawSetString(ergebniss[playerid], string);
			}
			if(rrechnung[playerid] == 4)
			{
				ergeb[playerid] = strval(zahl[playerid]) / strval(azahl[playerid]);
				TextDrawShowForPlayer(playerid, ergebniss[playerid]);
				format(string, 128, "%d", ergeb[playerid]);
				TextDrawSetString(ergebniss[playerid], string);
			}

		}
	}
	if(clickedid == exxit[playerid])
	{
		HideTextDraw(playerid);
	}
	if(clickedid == neu[playerid])
	{
		TextDrawSetString(ergebniss[playerid], "");
		TextDrawSetString(rechnung[playerid], "");
		rechi[playerid] = "";
		rrechnung[playerid] = 0;
		zahl[playerid] = "";
		azahl[playerid] = "";
	}
	return 1;
}


CMD:draw(playerid,params[])
{
	OnPlayerConnect(playerid);
	return 1;
}

CMD:trechner(playerid,params[])
{
	TogglePlayerControllable(playerid, 0);
	CancelSelectTextDraw(playerid);
	SelectTextDraw(playerid,0x8C8C8CFF);
	TextDrawShowForPlayer(playerid, box[playerid]);
	TextDrawShowForPlayer(playerid, Line1[playerid]);
	TextDrawShowForPlayer(playerid, Line2[playerid]);
	TextDrawShowForPlayer(playerid, Line3[playerid]);
	TextDrawShowForPlayer(playerid, Line4[playerid]);
	TextDrawShowForPlayer(playerid, zahl1[playerid]);
	TextDrawShowForPlayer(playerid, zahl2[playerid]);
	TextDrawShowForPlayer(playerid, zahl3[playerid]);
	TextDrawShowForPlayer(playerid, zahl4[playerid]);
	TextDrawShowForPlayer(playerid, zahl5[playerid]);
	TextDrawShowForPlayer(playerid, zahl6[playerid]);
	TextDrawShowForPlayer(playerid, zahl7[playerid]);
	TextDrawShowForPlayer(playerid, zahl8[playerid]);
	TextDrawShowForPlayer(playerid, zahl9[playerid]);
	TextDrawShowForPlayer(playerid, plus[playerid]);
	TextDrawShowForPlayer(playerid, minus[playerid]);
	TextDrawShowForPlayer(playerid, mal[playerid]);
	TextDrawShowForPlayer(playerid, geteilt[playerid]);
	TextDrawShowForPlayer(playerid, gleich[playerid]);
	TextDrawShowForPlayer(playerid, exxit[playerid]);
	TextDrawShowForPlayer(playerid, neu[playerid]);
	TextDrawShowForPlayer(playerid, Logo[playerid]);
	for(new i = 0; i< sizeof(tdbox);i++)
	{
		TextDrawShowForPlayer(playerid, tdbox[playerid][i]);
	}
	return 1;
}




stock HideTextDraw(playerid)
{
    TogglePlayerControllable(playerid, 1);
	CancelSelectTextDraw(playerid);
	TextDrawHideForPlayer(playerid, box[playerid]);
	TextDrawHideForPlayer(playerid, Line1[playerid]);
	TextDrawHideForPlayer(playerid, Line2[playerid]);
	TextDrawHideForPlayer(playerid, Line3[playerid]);
	TextDrawHideForPlayer(playerid, Line4[playerid]);
	TextDrawHideForPlayer(playerid, zahl1[playerid]);
	TextDrawHideForPlayer(playerid, zahl2[playerid]);
	TextDrawHideForPlayer(playerid, zahl3[playerid]);
	TextDrawHideForPlayer(playerid, zahl4[playerid]);
	TextDrawHideForPlayer(playerid, zahl5[playerid]);
	TextDrawHideForPlayer(playerid, zahl6[playerid]);
	TextDrawHideForPlayer(playerid, zahl7[playerid]);
	TextDrawHideForPlayer(playerid, zahl8[playerid]);
	TextDrawHideForPlayer(playerid, zahl9[playerid]);
	TextDrawHideForPlayer(playerid, plus[playerid]);
	TextDrawHideForPlayer(playerid, minus[playerid]);
	TextDrawHideForPlayer(playerid, mal[playerid]);
	TextDrawHideForPlayer(playerid, geteilt[playerid]);
	TextDrawHideForPlayer(playerid, gleich[playerid]);
	TextDrawHideForPlayer(playerid, rechnung[playerid]);
	TextDrawHideForPlayer(playerid, ergebniss[playerid]);
	TextDrawHideForPlayer(playerid, neu[playerid]);
	TextDrawHideForPlayer(playerid, exxit[playerid]);
	TextDrawHideForPlayer(playerid, Logo[playerid]);
	for(new i = 0; i< sizeof(tdbox);i++)
	{
		TextDrawHideForPlayer(playerid, tdbox[playerid][i]);
	}
}