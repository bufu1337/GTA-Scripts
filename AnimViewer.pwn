#include <a_samp>
/*
		,===================================,
		|         Animation Browser         |
		|            01.09.2015             |
		|              SoNik))              |
		*===================================*

		 forum.sa-mp.com/member.php?u=227921
*/

#define HeadText		"Anim Browser by SoNik))"
#define MAX_ROWS		11
#define MAX_LIB			130
#define INVALID_IDX		-1

static const AnimationInfo[131] =
{
	1, 2, 5, 17, 28, 41, 46, 53, 57, 76, 94, 103, 123, 141, 145, 163,
	169, 179, 220, 225, 234, 248, 259, 266, 287, 312, 323, 341, 354,
	360, 367, 379, 383, 393, 398, 403, 416, 423, 432, 436, 446, 454,
	472, 482, 494, 504, 508, 532, 533, 536, 569, 578, 611, 631, 638,
	639, 641, 644, 647, 671, 684, 694, 704, 714, 722, 726, 730, 745,
	761, 763, 765, 767, 806, 831, 839, 840, 881, 899, 916, 918, 947,
	958, 980, 983, 995, 1289, 1293, 1298, 1308, 1329, 1331, 1336,
	1353, 1357, 1365, 1370, 1377, 1382, 1387, 1392, 1408, 1420,
	1424, 1449, 1452, 1456, 1459, 1467, 1468, 1470, 1490, 1508,
	1531, 1538, 1545, 1555, 1561, 1618, 1622, 1626, 1643, 1648,
	1656, 1662, 1666, 1684, 1701, 1713, 1746, 1779, 1812
};

new Text:PTD[27 * 2];
new Text:LTD[42];
new save_Lib;
new save_Name;
new save_PageLib;
new save_PageName;
new save_SelectId;
new save_Menu;
new EditID;
new bool:OpenWindow;
new animlib[32], animname[32];
new Float:a_Speed;
new bool:a_Cycle;
new bool:a_LockPos;
new bool:a_Freeze;
new a_Time;
new bool:a_Forcesync;

public OnFilterScriptInit()
{
	print("\n         Animation Browser");
	print("              v1.0");
	print("             SoNik))\n");

	LTD[0] = TextDrawCreate(627.555664, 229.129592, "_");
	TextDrawLetterSize(LTD[0], 0.000000, 22.302673);
	TextDrawTextSize(LTD[0], 474.111114, 0.000000);
	TextDrawAlignment(LTD[0], 1);
	TextDrawColor(LTD[0], 0);
	TextDrawUseBox(LTD[0], true);
	TextDrawBoxColor(LTD[0], 41);
	TextDrawSetShadow(LTD[0], 0);
	TextDrawSetOutline(LTD[0], 0);
	TextDrawFont(LTD[0], 0);

	LTD[1] = TextDrawCreate(625.222229, 231.166641, "_");
	TextDrawLetterSize(LTD[1], 0.000000, 21.747119);
	TextDrawTextSize(LTD[1], 476.888946, 0.000000);
	TextDrawAlignment(LTD[1], 1);
	TextDrawColor(LTD[1], 0);
	TextDrawUseBox(LTD[1], true);
	TextDrawBoxColor(LTD[1], -216);
	TextDrawSetShadow(LTD[1], 0);
	TextDrawSetOutline(LTD[1], 0);
	TextDrawBackgroundColor(LTD[1], 47);
	TextDrawFont(LTD[1], 0);

	LTD[2] = TextDrawCreate(569.778686, 234.833526, "_");
	TextDrawLetterSize(LTD[2], 0.000000, 0.780043);
	TextDrawTextSize(LTD[2], 480.777679, 0.000000);
	TextDrawAlignment(LTD[2], 1);
	TextDrawColor(LTD[2], 0);
	TextDrawUseBox(LTD[2], true);
	TextDrawBoxColor(LTD[2], 111);
	TextDrawSetShadow(LTD[2], 0);
	TextDrawSetOutline(LTD[2], 0);
	TextDrawFont(LTD[2], 1);
	TextDrawSetSelectable(LTD[2], true);

	LTD[3] = TextDrawCreate(486.666778, 233.851806, HeadText);
	TextDrawLetterSize(LTD[3], 0.185552, 0.853331);
	TextDrawTextSize(LTD[3], 571.665954, 11.000000);
	TextDrawAlignment(LTD[3], 1);
	TextDrawColor(LTD[3], -116);
	TextDrawUseBox(LTD[3], true);
	TextDrawBoxColor(LTD[3], 0);
	TextDrawSetShadow(LTD[3], 0);
	TextDrawSetOutline(LTD[3], 0);
	TextDrawBackgroundColor(LTD[3], 51);
	TextDrawFont(LTD[3], 1);
	TextDrawSetProportional(LTD[3], 1);

	LTD[4] = TextDrawCreate(621.333557, 234.796432, "_");
	TextDrawLetterSize(LTD[4], 0.000000, 0.780043);
	TextDrawTextSize(LTD[4], 599.666442, 0.000000);
	TextDrawAlignment(LTD[4], 1);
	TextDrawColor(LTD[4], 0);
	TextDrawUseBox(LTD[4], true);
	TextDrawBoxColor(LTD[4], 111);
	TextDrawSetShadow(LTD[4], 0);
	TextDrawSetOutline(LTD[4], 0);
	TextDrawFont(LTD[4], 1);

	LTD[5] = TextDrawCreate(601.778320, 249.796447, "_");
	TextDrawLetterSize(LTD[5], 0.000000, 17.335596);
	TextDrawTextSize(LTD[5], 480.777465, 0.000000);
	TextDrawAlignment(LTD[5], 1);
	TextDrawColor(LTD[5], 0);
	TextDrawUseBox(LTD[5], true);
	TextDrawBoxColor(LTD[5], 111);
	TextDrawSetShadow(LTD[5], 0);
	TextDrawSetOutline(LTD[5], 0);
	TextDrawFont(LTD[5], 1);

	LTD[6] = TextDrawCreate(528.555603, 415.055664, "_");
	TextDrawLetterSize(LTD[6], 0.000000, 0.835596);
	TextDrawTextSize(LTD[6], 480.777404, 0.000000);
	TextDrawAlignment(LTD[6], 1);
	TextDrawColor(LTD[6], 0);
	TextDrawUseBox(LTD[6], true);
	TextDrawBoxColor(LTD[6], -216);
	TextDrawSetShadow(LTD[6], 0);
	TextDrawSetOutline(LTD[6], 0);
	TextDrawBackgroundColor(LTD[6], 1392557987);
	TextDrawFont(LTD[6], 1);

	LTD[7] = TextDrawCreate(620.777221, 415.055664, "_");
	TextDrawLetterSize(LTD[7], 0.000000, 0.835596);
	TextDrawTextSize(LTD[7], 572.998962, 0.000000);
	TextDrawAlignment(LTD[7], 1);
	TextDrawColor(LTD[7], 0);
	TextDrawUseBox(LTD[7], true);
	TextDrawBoxColor(LTD[7], -216);
	TextDrawSetShadow(LTD[7], 0);
	TextDrawSetOutline(LTD[7], 0);
	TextDrawFont(LTD[7], 1);

	LTD[8] = TextDrawCreate(574.666809, 415.055633, "_");
	TextDrawLetterSize(LTD[8], 0.000000, 0.835596);
	TextDrawTextSize(LTD[8], 526.888549, 0.000000);
	TextDrawAlignment(LTD[8], 1);
	TextDrawColor(LTD[8], 0);
	TextDrawUseBox(LTD[8], true);
	TextDrawBoxColor(LTD[8], -216);
	TextDrawSetShadow(LTD[8], 0);
	TextDrawSetOutline(LTD[8], 0);
	TextDrawFont(LTD[8], 1);

	LTD[9] = TextDrawCreate(504.888854, 413.740692, "----");
	TextDrawLetterSize(LTD[9], 0.244442, 0.962220);
	TextDrawTextSize(LTD[9], 11.699995, 38.000000);
	TextDrawAlignment(LTD[9], 2);
	TextDrawColor(LTD[9], -116);
	TextDrawUseBox(LTD[9], true);
	TextDrawBoxColor(LTD[9], 0);
	TextDrawSetShadow(LTD[9], 0);
	TextDrawSetOutline(LTD[9], 0);
	TextDrawBackgroundColor(LTD[9], 51);
	TextDrawFont(LTD[9], 2);
	TextDrawSetProportional(LTD[9], 1);

	LTD[10] = TextDrawCreate(550.888000, 414.222167, "SETTING");
	TextDrawLetterSize(LTD[10], 0.220550, 0.925924);
	TextDrawTextSize(LTD[10], 11.699995, 38.000000);
	TextDrawAlignment(LTD[10], 2);
	TextDrawColor(LTD[10], -116);
	TextDrawUseBox(LTD[10], true);
	TextDrawBoxColor(LTD[10], 0);
	TextDrawSetShadow(LTD[10], 0);
	TextDrawSetOutline(LTD[10], 0);
	TextDrawBackgroundColor(LTD[10], 51);
	TextDrawFont(LTD[10], 2);
	TextDrawSetProportional(LTD[10], 1);
	TextDrawSetSelectable(LTD[10], true);

	LTD[11] = TextDrawCreate(597.000183, 413.703643, "----");
	TextDrawLetterSize(LTD[11], 0.244442, 0.962220);
	TextDrawTextSize(LTD[11], 11.699995, 38.000000);
	TextDrawAlignment(LTD[11], 2);
	TextDrawColor(LTD[11], -116);
	TextDrawUseBox(LTD[11], true);
	TextDrawBoxColor(LTD[11], 0);
	TextDrawSetShadow(LTD[11], 0);
	TextDrawSetOutline(LTD[11], 0);
	TextDrawBackgroundColor(LTD[11], 51);
	TextDrawFont(LTD[11], 2);
	TextDrawSetProportional(LTD[11], 1);

	LTD[12] = TextDrawCreate(611.000000, 233.814743, "_");
	TextDrawLetterSize(LTD[12], 0.185552, 0.853331);
	TextDrawTextSize(LTD[12], 11.000000, 13.481472);
	TextDrawAlignment(LTD[12], 2);
	TextDrawColor(LTD[12], -116);
	TextDrawUseBox(LTD[12], true);
	TextDrawBoxColor(LTD[12], 0);
	TextDrawSetShadow(LTD[12], 0);
	TextDrawSetOutline(LTD[12], 0);
	TextDrawBackgroundColor(LTD[12], 51);
	TextDrawFont(LTD[12], 1);
	TextDrawSetProportional(LTD[12], 1);
	TextDrawSetSelectable(LTD[12], true);

	LTD[13] = TextDrawCreate(601.776916, 234.574127, "_");
	TextDrawLetterSize(LTD[13] , 0.000000, 0.835596);
	TextDrawTextSize(LTD[13] , 567.999267, 0.000000);
	TextDrawAlignment(LTD[13] , 1);
	TextDrawColor(LTD[13] , 0);
	TextDrawUseBox(LTD[13] , true);
	TextDrawBoxColor(LTD[13] , -2147483551);
	TextDrawSetShadow(LTD[13] , 0);
	TextDrawSetOutline(LTD[13] , 0);
	TextDrawFont(LTD[13] , 2);

	LTD[14] = TextDrawCreate(585.776794, 233.740615, "EXIT");
	TextDrawLetterSize(LTD[14], 0.202772, 0.837773);
	TextDrawTextSize(LTD[14], 11.000000, 19.703670);
	TextDrawAlignment(LTD[14], 2);
	TextDrawColor(LTD[14], -116);
	TextDrawUseBox(LTD[14], true);
	TextDrawBoxColor(LTD[14], 0);
	TextDrawSetShadow(LTD[14], 0);
	TextDrawSetOutline(LTD[14], 0);
	TextDrawBackgroundColor(LTD[14], 51);
	TextDrawFont(LTD[14], 2);
	TextDrawSetProportional(LTD[14], 1);
	TextDrawSetSelectable(LTD[14], true);

	LTD[15] = TextDrawCreate(604.889038, 393.000213, "LD_BEAT:down");
	TextDrawLetterSize(LTD[15], 0.000000, 0.000000);
	TextDrawTextSize(LTD[15], 12.222229, 11.925909);
	TextDrawAlignment(LTD[15], 1);
	TextDrawColor(LTD[15], -1);
	TextDrawSetShadow(LTD[15], 0);
	TextDrawSetOutline(LTD[15], 0);
	TextDrawBackgroundColor(LTD[15], -1);
	TextDrawFont(LTD[15], 4);
	TextDrawSetSelectable(LTD[15], true);

	LTD[16] = TextDrawCreate(604.777893, 250.889038, "LD_BEAT:up");
	TextDrawLetterSize(LTD[16], 0.000000, 0.000000);
	TextDrawTextSize(LTD[16], 12.222229, 11.925909);
	TextDrawAlignment(LTD[16], 1);
	TextDrawColor(LTD[16], -1);
	TextDrawSetShadow(LTD[16], 0);
	TextDrawSetOutline(LTD[16], 0);
	TextDrawBackgroundColor(LTD[16], -1);
	TextDrawFont(LTD[16], 4);
	TextDrawSetSelectable(LTD[16], true);

	LTD[17] = TextDrawCreate(621.667114, 249.759399, "_");
	TextDrawLetterSize(LTD[17], 0.000000, 17.335596);
	TextDrawTextSize(LTD[17], 600.221862, 0.000000);
	TextDrawAlignment(LTD[17], 1);
	TextDrawColor(LTD[17], 0);
	TextDrawUseBox(LTD[17], true);
	TextDrawBoxColor(LTD[17], 111);
	TextDrawSetShadow(LTD[17], 0);
	TextDrawSetOutline(LTD[17], 0);
	TextDrawFont(LTD[17], 1);

	LTD[18] = TextDrawCreate(619.333801, 268.389068, "_");
	TextDrawLetterSize(LTD[18], 0.000000, 13.113368);
	TextDrawTextSize(LTD[18], 602.444091, 0.000000);
	TextDrawAlignment(LTD[18], 1);
	TextDrawColor(LTD[18], 0);
	TextDrawUseBox(LTD[18], true);
	TextDrawBoxColor(LTD[18], -216);
	TextDrawSetShadow(LTD[18], 0);
	TextDrawSetOutline(LTD[18], 0);
	TextDrawFont(LTD[18], 1);

	LTD[19] = TextDrawCreate(619.667358, 268.870544, "_");
	TextDrawLetterSize(LTD[19], 0.000000, -0.053295);
	TextDrawTextSize(LTD[19], 602.444091, 0.000000);
	TextDrawAlignment(LTD[19], 1);
	TextDrawColor(LTD[19], 0);
	TextDrawUseBox(LTD[19], true);
	TextDrawBoxColor(LTD[19], -186);
	TextDrawSetShadow(LTD[19], 0);
	TextDrawSetOutline(LTD[19], 0);
	TextDrawFont(LTD[19], 1);

	for(new i, Float:Y1 = 252.388946, Float:Y2 = 251.444473; i != 22; i += 2, Y1 += 14.200000, Y2 += 14.200000)
	{
		LTD[i+20] = TextDrawCreate(599.000488, Y1, "line_back");
		TextDrawLetterSize(LTD[i+20], 0.000000, 0.858236);
		TextDrawTextSize(LTD[i+20], 483.555603, 0.000000);
		TextDrawAlignment(LTD[i+20], 1);
		TextDrawColor(LTD[i+20], -1061109505);
		TextDrawUseBox(LTD[i+20], true);
		TextDrawBoxColor(LTD[i+20], -222);
		TextDrawSetShadow(LTD[i+20], 0);
		TextDrawSetOutline(LTD[i+20], 0);
		TextDrawBackgroundColor(LTD[i+20], 47);
		TextDrawFont(LTD[i+20], 1);

		LTD[i+21] = TextDrawCreate(488.777923, Y2, "line_text");
		TextDrawLetterSize(LTD[i+21], 0.185552, 0.853331);
		TextDrawTextSize(LTD[i+21], 595.555419, 11.000000);
		TextDrawAlignment(LTD[i+21], 1);
		TextDrawColor(LTD[i+21], -116);
		TextDrawUseBox(LTD[i+21], true);
		TextDrawBoxColor(LTD[i+21], 0);
		TextDrawSetShadow(LTD[i+21], 0);
		TextDrawSetOutline(LTD[i+21], 0);
		TextDrawBackgroundColor(LTD[i+21], 51);
		TextDrawFont(LTD[i+21], 1);
		TextDrawSetProportional(LTD[i+21], 1);
		TextDrawSetSelectable(LTD[i+21], true);
	}

	for(new str[4], x, i, Float:X1 = -22.000000, Float:Y1 = -22.000000; i != 27 * 2; x++, i += 2, X1 += 22.000000)
	{
		if(x % 5 == 0) Y1 += 19.000000, X1 = 0.000000;

		PTD[i] = TextDrawCreate(509.500000 + X1, 258.000000 + Y1, "back_cube");
		TextDrawLetterSize(PTD[i], 0.000000, 1.191568);
		TextDrawTextSize(PTD[i], 486.500000 + X1, 0.000000);
		TextDrawAlignment(PTD[i], 1);
		TextDrawColor(PTD[i], -1061109505);
		TextDrawUseBox(PTD[i], true);
		TextDrawBoxColor(PTD[i], -222);
		TextDrawSetShadow(PTD[i], 0);
		TextDrawSetOutline(PTD[i], 0);
		TextDrawFont(PTD[i], 1);

		valstr(str, i / 2 + 1);
		PTD[i+1] = TextDrawCreate(498.200000 + X1, 256.500000 + Y1, str);
		TextDrawLetterSize(PTD[i+1], 0.251107, 1.257773);
		TextDrawTextSize(PTD[i+1], 16.000000, 16.000000);
		TextDrawAlignment(PTD[i+1], 2);
		TextDrawColor(PTD[i+1], -116);
		TextDrawUseBox(PTD[i+1], true);
		TextDrawBoxColor(PTD[i+1], 0);
		TextDrawSetShadow(PTD[i+1], 0);
		TextDrawSetOutline(PTD[i+1], 0);
		TextDrawFont(PTD[i+1], 2);
		TextDrawSetProportional(PTD[i+1], 1);
		TextDrawSetSelectable(PTD[i+1], true);

	}

	save_SelectId = _:LTD[20];
	EditID = INVALID_PLAYER_ID;
	return true;
}

public OnFilterScriptExit()
{
	for(new i; i != sizeof LTD; i++) TextDrawDestroy(LTD[i]);
	for(new i; i != sizeof PTD; i++) TextDrawDestroy(PTD[i]);
	return true;
}
public OnPlayerDisconnect(playerid, reason)
{
	if(EditID == playerid) EditID = INVALID_PLAYER_ID;
	return true;
}
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == LTD[9])
	{
		switch(save_Menu)
		{
			case 1:
			{
				GetAnimationName(AnimationInfo[save_Lib], animlib, 32, animname, 32);
				if(!GetPVarInt(playerid, animlib))
				{
					SetPVarInt(playerid, animlib, 1);
					ApplyAnimation(playerid, animlib, "null", 4.1, 0, 0, 0, 0, 0, 1);
				}
				save_PageName = 0;
				UpdateLine(2);
				SelectTD(LTD[9], false, "----");
				TextDrawSetString(LTD[14], "BACK");
			}
			case 2:
			{
				GetAnimationName(save_Name, animlib, 32, animname, 32);
				ApplyAnimation(EditID, animlib, animname, a_Speed, a_Cycle, a_LockPos, a_LockPos, a_Freeze, a_Time, a_Forcesync);
			}
		}
	}
	else if(clickedid == LTD[14])
	{
		switch(save_Menu)
		{
			case 1:
			{
				SelectTD(LTD[9], false, "----");
				SelectTD(LTD[11], false, "----");
				for(new i; i != sizeof LTD; i++) TextDrawHideForPlayer(EditID, LTD[i]);
				ClearAnimations(EditID, a_Forcesync);
				OpenWindow = false;
				save_PageName = 0;
				save_PageLib = 0;
				save_Name = INVALID_IDX;
				save_Lib = INVALID_IDX;
				EditID = INVALID_PLAYER_ID;
				CancelSelectTextDraw(playerid);
			}
			case 2:
			{
				save_Lib = INVALID_IDX;
				save_Name = INVALID_IDX;
				UpdateLine(1);
				TextDrawSetString(LTD[14], "EXIT");
				SelectTD(LTD[9], false, "----");
				TextDrawSetString(LTD[3], HeadText);
			}
			case 3,4:
			{
				for(new i; i != 27 * 2; i += 2)
				{
					TextDrawHideForPlayer(playerid, PTD[i]);
					TextDrawHideForPlayer(playerid, PTD[i+1]);
				}
				save_Name = INVALID_IDX;
				UpdateLine(save_Menu - 2);
				SelectTD(LTD[12], true);
				SelectTD(LTD[9], false, "----");
				if(save_Menu == 1)
					TextDrawSetString(LTD[14], "EXIT"),
					TextDrawSetString(LTD[3], HeadText);
				else
					TextDrawSetString(LTD[14], "BACK");
			}
		}
	}
	else if(clickedid == LTD[12])
	{
		SelectTD(LTD[12], false, "_?_");
		SelectTD(LTD[9], false, "----");
		SelectTD(LTD[11], false, "----");
		save_Name = INVALID_IDX;
		TextDrawSetString(LTD[14], "BACK");
		TextDrawSetString(LTD[3], "Select the page");
		for(new i = 0; i != MAX_ROWS * 2; i += 2)
		{
			TextDrawHideForPlayer(EditID, LTD[i+20]);
			TextDrawHideForPlayer(EditID, LTD[i+21]);
		}
		new i, l = save_Menu == 1 ? 12 : GetMaxPage();
		save_Menu += 2;
		while(i != l * 2)
		{
			TextDrawShowForPlayer(playerid, PTD[i++]);
			TextDrawShowForPlayer(playerid, PTD[i++]);
		}
		TextDrawHideForPlayer(EditID, LTD[19]);
	}
	else if(clickedid == LTD[10])
	{
		ShowSettingDialog();
	}
	else if(clickedid == LTD[15])
	{
		switch(save_Menu)
		{
			case 1: if(save_PageLib < 11)
			{
				save_PageLib++;
				UpdateLine(1);
			}
			case 2: if(save_PageName < GetMaxPage() - 1)
			{
				save_PageName++;
				UpdateLine(2);
			}
		}
		SelectTD(LTD[9], false, "----");
	}
	else if(clickedid == LTD[16])
	{
		switch(save_Menu)
		{
			case 1: if(save_PageLib > 0)
			{
				save_PageLib--;
				UpdateLine(1);
			}
			case 2: if(save_PageName > 0)
			{
				save_PageName--;
				UpdateLine(2);
			}
		}
		SelectTD(LTD[9], false, "----");
	}
	else if(clickedid == LTD[11])
	{
		ShowPlayerDialog(EditID, 19111, DIALOG_STYLE_INPUT, "Save Animation", " {c4c4c4}Memorable comment... (optional)", "Next", "Close");
	}
	else
	{
		for(new i; i != 22; i += 2) if(clickedid == LTD[i+21])
		{
			if(save_Menu == 1)
			{
				save_Lib = (save_PageLib * MAX_ROWS) + (i / 2);
				SelectTD(LTD[9], true, "NEXT");
			}
			else
			{
				save_Name = AnimationInfo[save_Lib] + (save_PageName * MAX_ROWS) + (i / 2);
				SelectTD(LTD[9], true, "PLAY");
				SelectTD(LTD[11], true, "SAVE");
			}
			static tick;
			if(save_SelectId == INVALID_TEXT_DRAW)
			{
				BACK:
				tick = GetTickCount();
				OverLine(LTD[i+20]);
			}
			else if(save_SelectId == _:LTD[i+20] && GetTickCount() - tick < 400)
			{
				tick = 0;
				OnPlayerClickTextDraw(EditID, LTD[9]);
			}
			else goto BACK;
			return true;
		}
		for(new i; i != 27 * 2; i += 2) if(clickedid == PTD[i+1])
		{
			for(new l; l != 27 * 2; l += 2)
			{
				TextDrawHideForPlayer(playerid, PTD[l]);
				TextDrawHideForPlayer(playerid, PTD[l+1]);
			}
			switch(save_Menu)
			{
				case 3: save_PageLib  = i / 2;
				case 4: save_PageName = i / 2;
			}
			UpdateLine(save_Menu - 2);
			SelectTD(LTD[9], false);
			SelectTD(LTD[12], true);
			if(save_Menu == 1)
				TextDrawSetString(LTD[14], "EXIT"),
				TextDrawSetString(LTD[3], HeadText);
			else
				TextDrawSetString(LTD[14], "BACK");
			return true;
		}
	}
	return true;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case 19111: if(response)
		{
			new string[120];
			GetAnimationName(save_Name, animlib, 32, animname, 32);
			format(string, 120, "\r\nApplyAnimation(playerid, \"%s\", \"%s\", %.1f, %s, %s, %s, %i, %s);",
								animlib,
								animname,
								a_Speed,
								a_Cycle ? ("true") : ("false"),
								a_LockPos ? ("true, true") : ("false, false"),
								a_Freeze ? ("true") : ("false"),
								a_Time,
								a_Forcesync ? ("true") : ("false"));
			new File:File = fopen("AnimationSaved.txt", io_append);
			fwrite(File, string);
			if(inputtext[0])
			{
				fwrite(File, " // ");
				fwrite(File, inputtext);
			}
			fclose(File);
			format(string, 120, "Browser {ffffff}Saved:  %s", animname);
			SendClientMessage(EditID, 0x00f2aaFF, string);
			return false;
		}
		case 19112: if(response)
		{
			switch(listitem)
			{
				case 0: ShowPlayerDialog(EditID, 19113, DIALOG_STYLE_INPUT, "Speed", "{c4c4c4}Specify speed. Default: 4.1", "Next", "Back");
				case 1: a_Cycle = a_Cycle ? false : true, ShowSettingDialog();
				case 2: a_LockPos = a_LockPos ? false : true, ShowSettingDialog();
				case 3: a_Freeze = a_Freeze ? false : true, ShowSettingDialog();
				case 4: ShowPlayerDialog(EditID, 19114, DIALOG_STYLE_INPUT, "Time", "{c4c4c4}Specify time. Default: 0", "Next", "Back");
				case 5: a_Forcesync = a_Forcesync ? false : true, ShowSettingDialog();
			}
			ClearAnimations(EditID, a_Forcesync);
		}
		case 19113:
		{
			if(response)
			{
				new Float:speed = floatstr(inputtext);
				if(speed < 0.1000 || speed > 4.10000) return ShowPlayerDialog(EditID, 19113, DIALOG_STYLE_INPUT, "Speed", "{ff0000}Error value!     {c4c4c4}0.1 — 4.1\nSpecify speed. Default: 4.1", "Next", "Back");
				a_Speed = speed + 0.001;
			}
			ShowSettingDialog();
		}
		case 19114:
		{
			if(response)
			{
				new time = strval(inputtext);
				if(time < 0 || time > 255) return ShowPlayerDialog(EditID, 19114, DIALOG_STYLE_INPUT, "Time", "{ff0000}Error value!\n{c4c4c4}Specify time. Default: 0", "Next", "Back");
				a_Time = time;
			}
			ShowSettingDialog();
		}
	}
	return true;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp("/anim", cmdtext, true, 5)) return cmd_anim(playerid);
	return false;
}
forward cmd_anim(playerid); public cmd_anim(playerid) // Other command processor
{
	new string[16];
	GetPlayerIp(playerid, string, 16);
	if(EditID == INVALID_PLAYER_ID && !strcmp(string, "127.0.0.1", false))
	{
		EditID = playerid;
		a_Speed = 4.101;
		a_Cycle = false;
		a_LockPos = false;
		a_Freeze = false;
		a_Time = 0;
		a_Forcesync = false;
		save_PageName = 0;
		save_PageLib = 0;
		save_Name = INVALID_IDX;
		save_Lib = INVALID_IDX;
		for(new i; i != 20; i++) TextDrawShowForPlayer(EditID, LTD[i]);
		UpdateLine(1);
		OpenWindow = true;
		SelectTextDraw(EditID, 0xE07E45FF);
	}
	else if(EditID == playerid && !OpenWindow)
	{
		for(new i; i != 20; i++) TextDrawShowForPlayer(EditID, LTD[i]);
		UpdateLine(save_Menu);
		OpenWindow = true;
		SelectTextDraw(EditID, 0xE07E45FF);
	}
	else if(EditID == playerid) SelectTextDraw(EditID, 0xE07E45FF);
	return true;
}
stock GetMaxPage()
{
	new var = AnimationInfo[save_Lib + 1] - AnimationInfo[save_Lib];
	return var >= MAX_ROWS && var % MAX_ROWS == 0 ? var / MAX_ROWS : var / MAX_ROWS + 1;
}
stock UpdateLine(menuid)
{
	save_Menu = menuid;
	OverLine();
	SelectTD(LTD[11], false, "----");
	switch(menuid)
	{
		case 1:
		{
			UpdateScroll(save_PageLib, 12);
			format(animlib, 32, "%i/12", save_PageLib + 1);
			TextDrawSetString(LTD[12], animlib);
			for(new idx = save_PageLib * MAX_ROWS, i = 0; i != MAX_ROWS * 2; i += 2, idx++)
			{
				if(idx < MAX_LIB)
				{
					GetAnimationName(AnimationInfo[idx], animlib, 32, animname, 32);
					TextDrawSetString(LTD[i+21], animlib);
					TextDrawShowForPlayer(EditID, LTD[i+20]);
					TextDrawShowForPlayer(EditID, LTD[i+21]);
					continue;
				}
				TextDrawHideForPlayer(EditID, LTD[i+20]);
				TextDrawHideForPlayer(EditID, LTD[i+21]);
			}
		}
		case 2:
		{
			UpdateScroll(save_PageName, GetMaxPage());
			format(animlib, 32, "%i/%i", save_PageName + 1, GetMaxPage());
			TextDrawSetString(LTD[12], animlib);
			UpdateHeader(save_Lib);
			for(new idx = AnimationInfo[save_Lib] + (save_PageName * MAX_ROWS), i = 0; i != MAX_ROWS * 2; i += 2, idx++)
			{
				if(idx < AnimationInfo[save_Lib + 1])
				{
					GetAnimationName(idx, animlib, 32, animname, 32);
					TextDrawSetString(LTD[i+21], animname);
					TextDrawShowForPlayer(EditID, LTD[i+20]);
					TextDrawShowForPlayer(EditID, LTD[i+21]);
					continue;
				}
				TextDrawHideForPlayer(EditID, LTD[i+20]);
				TextDrawHideForPlayer(EditID, LTD[i+21]);
			}
		}
	}
}
stock UpdateScroll(pages, maxpages)
{
	TextDrawDestroy(LTD[19]);

	new Float:whiles = 117.666809 / maxpages;
	LTD[19] = TextDrawCreate(619.000000, 268.870544 + whiles * pages, "_");
	TextDrawLetterSize(LTD[19], 0.000000, whiles / 9.000000);
	TextDrawTextSize(LTD[19], 603.000000, 0.000000);
	TextDrawAlignment(LTD[19], 1);
	TextDrawColor(LTD[19], 0);
	TextDrawUseBox(LTD[19], true);
	TextDrawBoxColor(LTD[19], -186);
	TextDrawSetShadow(LTD[19], 0);
	TextDrawSetOutline(LTD[19], 0);
	TextDrawFont(LTD[19], 1);
	TextDrawShowForPlayer(EditID, LTD[19]);
}
stock SelectTD(Text:textid, bool:enable, text[] = ".")
{
	TextDrawSetSelectable(textid, enable);
	TextDrawShowForPlayer(EditID, textid);
	if(text[1]) TextDrawSetString(textid, text);
}
stock OverLine(Text:textid = Text:INVALID_TEXT_DRAW)
{
	if(save_SelectId != _:textid && save_SelectId != INVALID_TEXT_DRAW)
	{
		TextDrawBoxColor(Text:save_SelectId, -222);
		TextDrawShowForPlayer(EditID, Text:save_SelectId);
	}
	if(textid != Text:INVALID_TEXT_DRAW)
	{
		TextDrawBoxColor(textid, -190);
		TextDrawShowForPlayer(EditID, textid);
		save_SelectId = _:textid;
	}
	else save_SelectId = INVALID_TEXT_DRAW;
}
stock UpdateHeader(idx)
{
	new string[44];
	GetAnimationName(AnimationInfo[idx], animlib, 32, animname, 32);
	format(string, 44, "Library  ~>~  %s", animlib);
	TextDrawSetString(LTD[3], string);
}
stock ShowSettingDialog()
{
	new string[260];
	format(string, 260,"{c4c4c4}Speed\t\t{bf8e13}| {ffce63}%.1f\n\
						{c4c4c4}Cycle\t\t{bf8e13}| %s\n\
						{c4c4c4}LockPos\t{bf8e13}| %s\n\
						{c4c4c4}Freeze\t\t{bf8e13}| %s\n\
						{c4c4c4}Time\t\t{bf8e13}| {ffce63}%i\n\
						{c4c4c4}Forcesync\t{bf8e13}| %s\n",
						a_Speed,
						a_Cycle ? ("{73df73}true") : ("{de3063}false"),
						a_LockPos ? ("{73df73}true") : ("{de3063}false"),
						a_Freeze ? ("{73df73}true") : ("{de3063}false"),
						a_Time,
						a_Forcesync ? ("{73df73}true") : ("{de3063}false"));
	ShowPlayerDialog(EditID, 19112, DIALOG_STYLE_LIST, "Setting", string, "Select", "Close");
}