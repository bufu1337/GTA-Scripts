// Ballon System controls
//
////By Golf
#include <a_samp>


new
    bool:engin[MAX_PLAYERS],
    obj[MAX_PLAYERS],
    Text:Air[35],
	o[2][MAX_PLAYERS]
;



public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("     // -------- AIr BOLLON controller by ---------- //");
	print("-------------------GOLF-----------------\n");
	load();
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}


main()
{
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
    engin[playerid] = false;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    engin[playerid] = false;
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    new Float:x, Float:y, Float:z,Float:rx, Float:ry, Float:rz;
	GetObjectPos(obj[playerid], x, y, z);
	GetObjectRot(obj[playerid], rx, ry, rz);
	if(clickedid == Air[7] )
	{
	    if(engin[playerid] == false)
		{
			TextDrawSetString(Air[7], "ON");
			o[0][playerid]=CreateObject(18693, 0.27156, -0.13194, 2.71633,   0.00000, 0.00000, 0.00000);
			o[1][playerid]=CreateObject(18693, -0.32139, -0.05106, 2.69175,   0.00000, 0.00000, 0.00000);
			AttachObjectToObject(o[0][playerid],obj[playerid], 0.27156, -0.13194, 0.71633,   0.00000, 0.00000, 0.00000, 1);
			AttachObjectToObject(o[1][playerid],obj[playerid] ,  -0.32139, -0.05106, 0.71633,   0.00000, 0.00000, 0.00000, 1);
			engin[playerid] = true;
			return 1;
		}
	    if(engin[playerid] == true)
		{
			TextDrawSetString(Air[7], "OFF");
			engin[playerid] = false;
			for(new i = 0 ; i <2; i++) { DestroyObject(o[i][playerid]); }
		}
	}
	else if(clickedid == Air[8])
	{
	    if(engin[playerid] == false) return true;
		MoveObject(obj[playerid],x,y,z+0.5,3);
	}
	else if(clickedid == Air[9])
	{
	    if(engin[playerid] == false) return true;
		MoveObject(obj[playerid],x,y,z-0.5,3);
	}
	else if(clickedid == Air[20])
	{
	    if(engin[playerid] == false) return true;
		MoveObject(obj[playerid],x-0.5,y-0.5,z,3);
	}
	else if(clickedid == Air[21])
	{
	    if(engin[playerid] == false) return true;
		MoveObject(obj[playerid],x+0.5,y+0.5,z,3);
	}
	else if(clickedid == Air[22])
	{
	    if(engin[playerid] == false) return true;
		MoveObject(obj[playerid],x+0.5,y-0.5,z,3);
	}
	else if(clickedid == Air[23])
	{
	    if(engin[playerid] == false) return true;
		MoveObject(obj[playerid],x-0.5,y+0.5,z,3);
	}
	else if(clickedid == Air[24])
	{
	    if(engin[playerid] == false) return true;
		MoveObject(obj[playerid],x+0.5,y,z,3);
	}
	else if(clickedid == Air[25])
	{
	    if(engin[playerid] == false) return true;
		MoveObject(obj[playerid],x,y+0.5,z,3);
	}
	else if(clickedid == Air[26])
	{
	    if(engin[playerid] == false) return true;
		MoveObject(obj[playerid],x-0.5,y,z,3);
	}
	else if(clickedid == Air[27])
	{
	    if(engin[playerid] == false) return true;
		MoveObject(obj[playerid],x,y-0.5,z,3);
	}
	else if(clickedid == Air[10])
	{
		if(engin[playerid] == false) return true;
		MoveObject(obj[playerid],x,y,z,3,rx,ry,rz+0.5);
	}
	else if(clickedid == Air[11])
	{
	    if(engin[playerid] == false) return true;
		MoveObject(obj[playerid],x,y,z,3,rx,ry,rz-0.5);
	}

	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/drive", cmdtext, true, 5) == 0)
	{
		for(new i = 0; i <= 34; i++) {
			TextDrawShowForPlayer(playerid, Air[i]);
		}
		SelectTextDraw(playerid, 0xA3B4C5FF);
		return 1;
	}
	if (strcmp("/exit", cmdtext, true, 5) == 0)
	{
	    for(new i = 0; i <= 34; i++) { TextDrawHideForPlayer(playerid, Air[i]);}
		CancelSelectTextDraw(playerid);
		return 1;
	}
	if (strcmp("/tttt", cmdtext, true, 4) == 0)
	{
	      new Float:x, Float:y, Float:z;
	      GetPlayerPos(playerid, x, y, z);
	      obj[playerid] = CreateObject(19338, x+5,y+5,z,   0.00000, 0.00000, 0.00000); return true;
	}
	return 0;
}

load(){
	Air[0] = TextDrawCreate(16.800001, 152.319961, "LD_SPAC:white");
	TextDrawLetterSize(Air[0] , 0.000000, 0.000000);
	TextDrawTextSize(Air[0] , 183.668518, 293.113891);
	TextDrawAlignment(Air[0] , 1);
	TextDrawColor(Air[0] , -5963521);
	TextDrawSetShadow(Air[0] , 0);
	TextDrawSetOutline(Air[0] , 0);
	TextDrawFont(Air[0] , 4);
	TextDrawSetSelectable(Air[0], true);

	Air[1]  = TextDrawCreate(198.799957, 155.313339, "usebox");
	TextDrawLetterSize(Air[1] , 0.000000, 1.493706);
	TextDrawTextSize(Air[1] , 15.599999, 0.000000);
	TextDrawAlignment(Air[1] , 1);
	TextDrawColor(Air[1] , 0);
	TextDrawUseBox(Air[1] , true);
	TextDrawBoxColor(Air[1] , 102);
	TextDrawSetShadow(Air[1] , 0);
	TextDrawSetOutline(Air[1] , 0);
	TextDrawFont(Air[1] , 0);

	Air[2] = TextDrawCreate(28.000001, 156.053268, "Air balloon");
	TextDrawLetterSize(Air[2] , 0.700400, 1.278933);
	TextDrawAlignment(Air[2] , 1);
	TextDrawColor(Air[2] , -16776961);
	TextDrawSetShadow(Air[2] , 0);
	TextDrawSetOutline(Air[2] , 5);
	TextDrawBackgroundColor(Air[2] , 255);
	TextDrawFont(Air[2] , 3);
	TextDrawSetProportional(Air[2] , 1);

	Air[3] = TextDrawCreate(79.200019, 180.693206, "Engine:");
	TextDrawLetterSize(Air[3] , 0.400399, 1.084799);
	TextDrawAlignment(Air[3] , 1);
	TextDrawColor(Air[3] , -5963521);
	TextDrawSetShadow(Air[3] , 0);
	TextDrawSetOutline(Air[3] , 3);
	TextDrawBackgroundColor(Air[3] , 255);
	TextDrawFont(Air[3] , 3);
	TextDrawSetProportional(Air[3] , 1);

	Air[4] = TextDrawCreate(200.400009, 180.699920, "usebox");
	TextDrawLetterSize(Air[4] , 0.000000, 1.339630);
	TextDrawTextSize(Air[4] , 16.400001, 0.000000);
	TextDrawAlignment(Air[4] , 1);
	TextDrawColor(Air[4] , 0);
	TextDrawUseBox(Air[4] , true);
	TextDrawBoxColor(Air[4] , 102);
	TextDrawSetShadow(Air[4] , 0);
	TextDrawSetOutline(Air[4] , 0);
	TextDrawFont(Air[4] , 0);

	Air[5]  = TextDrawCreate(200.399993, 213.553329, "usebox");
	TextDrawLetterSize(Air[5] , 0.000000, 1.508518);
	TextDrawTextSize(Air[5] , 16.399999, 0.000000);
	TextDrawAlignment(Air[5] , 1);
	TextDrawColor(Air[5] , 0);
	TextDrawUseBox(Air[5] , true);
	TextDrawBoxColor(Air[5] , 102);
	TextDrawSetShadow(Air[5] , 0);
	TextDrawSetOutline(Air[5] , 0);
	TextDrawFont(Air[5] , 0);

	Air[6]  = TextDrawCreate(51.999988, 214.293273, "ALT : ROTATION :");
	TextDrawLetterSize(Air[6] , 0.353199, 1.226666);
	TextDrawAlignment(Air[6] , 1);
	TextDrawColor(Air[6] , -5963521);
	TextDrawSetShadow(Air[6] , 0);
	TextDrawSetOutline(Air[6] , 2);
	TextDrawBackgroundColor(Air[6] , 255);
	TextDrawFont(Air[6] , 3);
	TextDrawSetProportional(Air[6] , 1);

	Air[7]  = TextDrawCreate(88.800033, 197.120010, "OFF");
	TextDrawLetterSize(Air[7] , 0.237999, 1.226666);
	TextDrawAlignment(Air[7] , 1);
	TextDrawColor(Air[7] , 8388863);
	TextDrawSetShadow(Air[7] ,  0);
	TextDrawSetOutline(Air[7] , 2);
	TextDrawBackgroundColor(Air[7] , -1);
	TextDrawFont(Air[7] , 1);
	TextDrawSetProportional(Air[7] , 1);
	TextDrawSetSelectable(Air[7] , true);

	Air[8]  = TextDrawCreate(43.199924, 235.199996, "ALT +");
	TextDrawLetterSize(Air[8], 0.405200, 1.144533);
	TextDrawAlignment(Air[8], 1);
	TextDrawColor(Air[8], 8388863);
	TextDrawSetShadow(Air[8], 0);
	TextDrawSetOutline(Air[8], 2);
	TextDrawBackgroundColor(Air[8], -1);
	TextDrawFont(Air[8], 3);
	TextDrawSetProportional(Air[8], 1);
	TextDrawSetSelectable(Air[8], true);

	Air[9]	 = TextDrawCreate(141.600128, 233.706527, "ALT -");
	TextDrawLetterSize(Air[9] , 0.390800, 1.331200);
	TextDrawAlignment(Air[9]	, 1);
	TextDrawColor(Air[9]	, 8388863);
	TextDrawSetShadow(Air[9]	, 0);
	TextDrawSetOutline(Air[9]	, 2);
	TextDrawBackgroundColor(Air[9] , -1);
	TextDrawFont(Air[9] , 3);
	TextDrawSetProportional(Air[9] , 1);
	TextDrawSetSelectable(Air[9] , true);

	Air[10]  = TextDrawCreate(43.199966, 265.066802, "RO:Z +");
	TextDrawLetterSize(Air[10], 0.359600, 1.368533);
	TextDrawAlignment(Air[10], 1);
	TextDrawColor(Air[10], 8388863);
	TextDrawSetShadow(Air[10], 0);
	TextDrawSetOutline(Air[10], 2);
	TextDrawBackgroundColor(Air[10], -1);
	TextDrawFont(Air[10], 3);
	TextDrawSetProportional(Air[10], 1);
	TextDrawSetSelectable(Air[10], true);

	Air[11] = TextDrawCreate(137.599960, 265.066619, "RO:Z -");
	TextDrawLetterSize(Air[11], 0.391599, 1.413333);
	TextDrawAlignment(Air[11], 1);
	TextDrawColor(Air[11], 8388863);
	TextDrawSetShadow(Air[11], 0);
	TextDrawSetOutline(Air[11], 2);
	TextDrawBackgroundColor(Air[11], -1);
	TextDrawFont(Air[11], 3);
	TextDrawSetProportional(Air[11], 1);
	TextDrawSetSelectable(Air[11], true);

	Air[12] = TextDrawCreate(110.800010, 232.966690, "usebox");
	TextDrawLetterSize(Air[12], 0.000000, 5.490740);
	TextDrawTextSize(Air[12], 97.200012, 0.000000);
	TextDrawAlignment(Air[12], 1);
	TextDrawColor(Air[12], 0);
	TextDrawUseBox(Air[12], true);
	TextDrawBoxColor(Air[12], 102);
	TextDrawSetShadow(Air[12], 0);
	TextDrawSetOutline(Air[12], 0);
	TextDrawFont(Air[12], 0);

	Air[13] = TextDrawCreate(200.399993, 288.220001, "usebox");
	TextDrawLetterSize(Air[13], 0.000000, 1.585558);
	TextDrawTextSize(Air[13], 16.400001, 0.000000);
	TextDrawAlignment(Air[13], 1);
	TextDrawColor(Air[13], 0);
	TextDrawUseBox(Air[13], true);
	TextDrawBoxColor(Air[13], 102);
	TextDrawSetShadow(Air[13], 0);
	TextDrawSetOutline(Air[13], 0);
	TextDrawFont(Air[13], 0);

	Air[14] = TextDrawCreate(69.599990, 288.213378, "Controls:");
	TextDrawLetterSize(Air[14], 0.416399, 1.428266);
	TextDrawAlignment(Air[14], 1);
	TextDrawColor(Air[14], -5963521);
	TextDrawSetShadow(Air[14], 0);
	TextDrawSetOutline(Air[14], 2);
	TextDrawBackgroundColor(Air[14], 255);
	TextDrawFont(Air[14], 3);
	TextDrawSetProportional(Air[14], 1);

	Air[15] = TextDrawCreate(30.800006, 198.620025, "usebox");
	TextDrawLetterSize(Air[15], 0.000000, 1.019629);
	TextDrawTextSize(Air[15], 16.399999, 0.000000);
	TextDrawAlignment(Air[15], 1);
	TextDrawColor(Air[15], 0);
	TextDrawUseBox(Air[15], true);
	TextDrawBoxColor(Air[15], 102);
	TextDrawSetShadow(Air[15], 0);
	TextDrawSetOutline(Air[15], 0);
	TextDrawFont(Air[15], 0);

	Air[16] = TextDrawCreate(200.399978, 198.620010, "usebox");
	TextDrawLetterSize(Air[16], 0.000000, 1.037407);
	TextDrawTextSize(Air[16], 185.999984, 0.000000);
	TextDrawAlignment(Air[16], 1);
	TextDrawColor(Air[16], 0);
	TextDrawUseBox(Air[16], true);
	TextDrawBoxColor(Air[16], 102);
	TextDrawSetShadow(Air[16], 0);
	TextDrawSetOutline(Air[16], 0);
	TextDrawFont(Air[16], 0);

	Air[17] = TextDrawCreate(193.199966, 255.366714, "usebox");
	TextDrawLetterSize(Air[17], 0.000000, 0.347036);
	TextDrawTextSize(Air[17], 24.399997, 0.000000);
	TextDrawAlignment(Air[17], 1);
	TextDrawColor(Air[17], 0);
	TextDrawUseBox(Air[17], true);
	TextDrawBoxColor(Air[17], 102);
	TextDrawSetShadow(Air[17], 0);
	TextDrawSetOutline(Air[17], 0);
	TextDrawFont(Air[17], 0);

	Air[18] = TextDrawCreate(30.800001, 232.966674, "usebox");
	TextDrawLetterSize(Air[18], 0.000000, 5.496667);
	TextDrawTextSize(Air[18], 16.400001, 0.000000);
	TextDrawAlignment(Air[18], 1);
	TextDrawColor(Air[18], 0);
	TextDrawUseBox(Air[18], true);
	TextDrawBoxColor(Air[18], 102);
	TextDrawSetShadow(Air[18], 0);
	TextDrawSetOutline(Air[18], 0);
	TextDrawFont(Air[18], 0);

	Air[19] = TextDrawCreate(200.399993, 232.966674, "usebox");
	TextDrawLetterSize(Air[19], 0.000000, 5.505555);
	TextDrawTextSize(Air[19], 186.799987, 0.000000);
	TextDrawAlignment(Air[19], 1);
	TextDrawColor(Air[19], 0);
	TextDrawUseBox(Air[19], true);
	TextDrawBoxColor(Air[19], 102);
	TextDrawSetShadow(Air[19], 0);
	TextDrawSetOutline(Air[19], 0);
	TextDrawFont(Air[19], 0);

	Air[20] = TextDrawCreate(38.399993, 318.080108, "-X-Y");
	TextDrawLetterSize(Air[20], 0.449999, 1.600000);
	TextDrawAlignment(Air[20], 1);
	TextDrawColor(Air[20], 8388863);
	TextDrawSetShadow(Air[20], 0);
	TextDrawSetOutline(Air[20], 2);
	TextDrawBackgroundColor(Air[20], -1);
	TextDrawFont(Air[20], 1);
	TextDrawSetProportional(Air[20], 1);
	TextDrawSetSelectable(Air[20], true);

	Air[21] = TextDrawCreate(133.599990, 317.333251, "+X+Y");
	TextDrawLetterSize(Air[21], 0.449999, 1.600000);
	TextDrawAlignment(Air[21], 1);
	TextDrawColor(Air[21], 8388863);
	TextDrawSetShadow(Air[21], 0);
	TextDrawSetOutline(Air[21], 2);
	TextDrawBackgroundColor(Air[21], -1);
	TextDrawFont(Air[21], 1);
	TextDrawSetProportional(Air[21], 1);
	TextDrawSetSelectable(Air[21], true);

	Air[22] = TextDrawCreate(37.600032, 362.879882, "-X+Y");
	TextDrawLetterSize(Air[22], 0.449999, 1.600000);
	TextDrawAlignment(Air[22], 1);
	TextDrawColor(Air[22], 8388863);
	TextDrawSetShadow(Air[22], 0);
	TextDrawSetOutline(Air[22], 2);
	TextDrawBackgroundColor(Air[22], -1);
	TextDrawFont(Air[22], 1);
	TextDrawSetProportional(Air[22], 1);
	TextDrawSetSelectable(Air[22], true);

	Air[23] = TextDrawCreate(137.600006, 359.146728, "+X-Y");
	TextDrawLetterSize(Air[23], 0.438000, 1.644800);
	TextDrawAlignment(Air[23], 1);
	TextDrawColor(Air[23], 8388863);
	TextDrawSetShadow(Air[23], 0);
	TextDrawSetOutline(Air[23], 2);
	TextDrawBackgroundColor(Air[23], -1);
	TextDrawFont(Air[23], 1);
	TextDrawSetProportional(Air[23], 1);
	TextDrawSetSelectable(Air[23], true);

	Air[24] = TextDrawCreate(43.999980, 399.466827, "+X");
	TextDrawLetterSize(Air[24], 0.449999, 1.600000);
	TextDrawAlignment(Air[24], 1);
	TextDrawColor(Air[24], 8388863);
	TextDrawSetShadow(Air[24], 0);
	TextDrawSetOutline(Air[24], 1);
	TextDrawBackgroundColor(Air[24], -1);
	TextDrawFont(Air[24], 1);
	TextDrawSetProportional(Air[24], 1);
	TextDrawSetSelectable(Air[24], true);

	Air[25] = TextDrawCreate(147.200088, 394.986572, "+Y");
	TextDrawLetterSize(Air[25], 0.449999, 1.600000);
	TextDrawAlignment(Air[25], 1);
	TextDrawColor(Air[25], 8388863);
	TextDrawSetShadow(Air[25], 0);
	TextDrawSetOutline(Air[25], 1);
	TextDrawBackgroundColor(Air[25], -1);
	TextDrawFont(Air[25], 1);
	TextDrawSetProportional(Air[25], 1);
	TextDrawSetSelectable(Air[25], true);

	Air[26] = TextDrawCreate(46.400039, 427.093566, "-X");
	TextDrawLetterSize(Air[26], 0.449999, 1.600000);
	TextDrawAlignment(Air[26], 1);
	TextDrawColor(Air[26], 8388863);
	TextDrawSetShadow(Air[26], 0);
	TextDrawSetOutline(Air[26], 1);
	TextDrawBackgroundColor(Air[26], -1);
	TextDrawFont(Air[26], 1);
	TextDrawSetProportional(Air[26], 1);
	TextDrawSetSelectable(Air[26], true);

	Air[27] = TextDrawCreate(151.199966, 425.600067, "-Y");
	TextDrawLetterSize(Air[27], 0.449999, 1.600000);
	TextDrawAlignment(Air[27], 1);
	TextDrawColor(Air[27], 8388863);
	TextDrawSetShadow(Air[27], 0);
	TextDrawSetOutline(Air[27], 1);
	TextDrawBackgroundColor(Air[27], -1);
	TextDrawFont(Air[27], 1);
	TextDrawSetProportional(Air[27], 1);
	TextDrawSetSelectable(Air[27], true);

	Air[28] = TextDrawCreate(30.000003, 308.380004, "usebox");
	TextDrawLetterSize(Air[28], 0.000000, 14.782593);
	TextDrawTextSize(Air[28], 16.400003, 0.000000);
	TextDrawAlignment(Air[28], 1);
	TextDrawColor(Air[28], 0);
	TextDrawUseBox(Air[28], true);
	TextDrawBoxColor(Air[28], 102);
	TextDrawSetShadow(Air[28], 0);
	TextDrawSetOutline(Air[28], 0);
	TextDrawFont(Air[28], 0);

	Air[29] = TextDrawCreate(200.400009, 444.273345, "usebox");
	TextDrawLetterSize(Air[29], 0.000000, -0.316666);
	TextDrawTextSize(Air[29], 23.599998, 0.000000);
	TextDrawAlignment(Air[29], 1);
	TextDrawColor(Air[29], 0);
	TextDrawUseBox(Air[29], true);
	TextDrawBoxColor(Air[29], 102);
	TextDrawSetShadow(Air[29], 0);
	TextDrawSetOutline(Air[29], 0);
	TextDrawFont(Air[29], 0);

	Air[30] = TextDrawCreate(200.400009, 308.380004, "usebox");
	TextDrawLetterSize(Air[30], 0.000000, 14.456669);
	TextDrawTextSize(Air[30], 187.600006, 0.000000);
	TextDrawAlignment(Air[30], 1);
	TextDrawColor(Air[30], 0);
	TextDrawUseBox(Air[30], true);
	TextDrawBoxColor(Air[30], 102);
	TextDrawSetShadow(Air[30], 0);
	TextDrawSetOutline(Air[30], 0);
	TextDrawFont(Air[30], 0);

	Air[31] = TextDrawCreate(194.000000, 343.473327, "usebox");
	TextDrawLetterSize(Air[31], 0.000000, 0.430000);
	TextDrawTextSize(Air[31], 23.599998, 0.000000);
	TextDrawAlignment(Air[31], 1);
	TextDrawColor(Air[31], 0);
	TextDrawUseBox(Air[31], true);
	TextDrawBoxColor(Air[31], 102);
	TextDrawSetShadow(Air[31], 0);
	TextDrawSetOutline(Air[31], 0);
	TextDrawFont(Air[31], 0);

	Air[32] = TextDrawCreate(194.000000, 386.779998, "usebox");
	TextDrawLetterSize(Air[32], 0.000000, 0.512960);
	TextDrawTextSize(Air[32], 23.600002, 0.000000);
	TextDrawAlignment(Air[32], 1);
	TextDrawColor(Air[32], 0);
	TextDrawUseBox(Air[32], true);
	TextDrawBoxColor(Air[32], 102);
	TextDrawSetShadow(Air[32], 0);
	TextDrawSetOutline(Air[32], 0);
	TextDrawFont(Air[32], 0);

	Air[33] = TextDrawCreate(194.000000, 420.380004, "usebox");
	TextDrawLetterSize(Air[33], 0.000000, 0.347036);
	TextDrawTextSize(Air[33], 23.600002, 0.000000);
	TextDrawAlignment(Air[33], 1);
	TextDrawColor(Air[33], 0);
	TextDrawUseBox(Air[33], true);
	TextDrawBoxColor(Air[33], 102);
	TextDrawSetShadow(Air[33], 0);
	TextDrawSetOutline(Air[33], 0);
	TextDrawFont(Air[33], 0);

	Air[34] = TextDrawCreate(111.599990, 308.380004, "usebox");
	TextDrawLetterSize(Air[34], 0.000000, 14.450742);
	TextDrawTextSize(Air[34], 97.199996, 0.000000);
	TextDrawAlignment(Air[34], 1);
	TextDrawColor(Air[34], 0);
	TextDrawUseBox(Air[34], true);
	TextDrawBoxColor(Air[34], 102);
	TextDrawSetShadow(Air[34], 0);
	TextDrawSetOutline(Air[34], 0);
	TextDrawFont(Air[34], 0);
	return 1;
}