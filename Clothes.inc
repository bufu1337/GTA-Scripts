/*
Clothes for CJ / Version 1.0x

headgear: 75
glasses: 120
bandanna: 10
masks: 5

by Kane_Phoenix
www.german-roleplay.net
*/

#include <a_samp>
#include "../include/gl_common.inc"

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("Clothes by Kane_Phoenix 1.0x");
	print("www.german-roleplay.net");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new idx;
	cmd = strtok(cmdtext, idx);
	if(strcmp(cmd, "/buyclothes", true) == 0)
	{
	    if(GetPlayerSkin(playerid) == 0)
	    {
    		new listitems[] = "{FFFFFF}1\t{55EE55}headgear\n{FFFFFF}2\t{55EE55}glasses\n{FFFFFF}3\t{55EE55}bandanna\n{FFFFFF}4\t{55EE55}masks\n{FFFFFF}5\t{55EE55}-\n{FFFFFF}6\t{55EE55}remove clothes";
    		ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix:",listitems,"wear","cancel");
    		return 1;
    	}
    	else
    	{
     		GameTextForPlayer(playerid,"~r~~h~Only with CJ Skin!",3000,3);
       		return 1;
		}
	}
	if(strcmp(cmd, "/CJ", true) == 0)
	{
	    SetPlayerSkin(playerid,0);
	    return 1;
 	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 200)
	{
	    if(response)
	    {
			if(listitem ==  0)//headgear
			{
	    		new listitems[] = "{FFFFFF}1\t{55EE55}Motorcross Helm\n{FFFFFF}2\t{55EE55}Motorradhelm\n{FFFFFF}3\t{55EE55}Motorradhelm\n{FFFFFF}4\t{55EE55}Motorradhelm\n{FFFFFF}5\t{55EE55}Motorradhelm\n{FFFFFF}6\t{55EE55}Boater 1\n{FFFFFF}7\t{55EE55}Boater 2\n{FFFFFF}8\t{55EE55}Boater 3\n{FFFFFF}9\t{55EE55}Bowler 1\n{FFFFFF}10\t{55EE55}Bowler 2\n{FFFFFF}11\t{55EE55}Bowler 3\n{FFFFFF}12\t{55EE55}Bowler 4\n{FFFFFF}13\t{55EE55}Bowler 5\n{55EE55}>>weiter<<";
	    		ShowPlayerDialog(playerid,201,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix>headgear 1/6:",listitems,"wear","back");
			}
			if(listitem ==  1)//glasses
			{
 				new listitems[] = "{FFFFFF}1\t{55EE55}Brille 1\n{FFFFFF}2\t{55EE55}Brille 2\n{FFFFFF}3\t{55EE55}Brille 3\n{FFFFFF}4\t{55EE55}Brille 4\n{FFFFFF}5\t{55EE55}Brille 5\n{FFFFFF}6\t{55EE55}Brille 6\n{FFFFFF}7\t{55EE55}Brille 7\n{FFFFFF}8\t{55EE55}Brille 8\n{FFFFFF}9\t{55EE55}Brille 9\n{FFFFFF}10\t{55EE55}Brille 10\n{55EE55}>>weiter<<";
	    		ShowPlayerDialog(playerid,202,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix>glasses 1/3:",listitems,"wear","back");
			}
			if(listitem ==  2)//Haltuch
			{
	    		new listitems[] = "{FFFFFF}1\t{55EE55}bandanna 1\n{FFFFFF}2\t{55EE55}bandanna 2\n{FFFFFF}3\t{55EE55}bandanna 3\n{FFFFFF}4\t{55EE55}bandanna 4\n{FFFFFF}5\t{55EE55}bandanna 5\n{FFFFFF}6\t{55EE55}bandanna 6\n{FFFFFF}7\t{55EE55}bandanna 7\n{FFFFFF}8\t{55EE55}bandanna 8\n{FFFFFF}9\t{55EE55}bandanna 9\n{FFFFFF}10\t{55EE55}bandanna 10";
	    		ShowPlayerDialog(playerid,205,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix>bandanna:",listitems,"wear","back");
			}
			if(listitem ==  3)//masks
			{
	    		new listitems[] = "{FFFFFF}1\t{55EE55}Hockeymask1\n{FFFFFF}2\t{55EE55}Hockeymask2\n{FFFFFF}3\t{55EE55}Hockeymask3\n{FFFFFF}4\t{55EE55}Zorromask\n{FFFFFF}5\t{55EE55}Boxing";
	    		ShowPlayerDialog(playerid,211,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix>masks:",listitems,"wear","back");
			}
			if(listitem ==  4)//-
			{
	    		new listitems[] = "{FFFFFF}1\t{55EE55}deleted\n{FFFFFF}2\t{55EE55}deleted\n{FFFFFF}3\t{55EE55}deleted\n{FFFFFF}4\t{55EE55}deleted\n{FFFFFF}5\t{55EE55}deleted";
	    		ShowPlayerDialog(playerid,213,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix>deleted:",listitems,"wear","back");
			}
			if(listitem ==  5)//remove clothes
			{
				new zz=0;
				while(zz!=MAX_PLAYER_ATTACHED_OBJECTS)
				{
			    	if(IsPlayerAttachedObjectSlotUsed(playerid, zz))
					{
			        	RemovePlayerAttachedObject(playerid, zz);
					}
					zz++;
				}
			}
		}
		return 1;
	}
	if(dialogid == 201)
	{
	    if(response)
	    {
			if(listitem ==  0)//MotorcrossHelmet
			{
                SetPlayerAttachedObject(playerid, 1, 18976, 2, 0.09, 0.03, 0, 88, 75, 0);
			}
			if(listitem ==  1)//MotorcycleHelmet1
			{
			    SetPlayerAttachedObject(playerid, 1, 18645, 2, 0.07, 0, 0, 88, 75, 0);
			}
			if(listitem ==  2)//MotorcycleHelmet2
			{
                SetPlayerAttachedObject(playerid, 1, 18977, 2, 0.07, 0, 0, 88, 75, 0);
			}
			if(listitem ==  3)//MotorcycleHelmet3
			{
                SetPlayerAttachedObject(playerid, 1, 18978, 2, 0.07, 0, 0, 88, 75, 0);
			}
			if(listitem ==  4)//MotorcycleHelmet4
			{
                SetPlayerAttachedObject(playerid, 1, 18979, 2, 0.07, 0, 0, 88, 75, 0);
			}
			if(listitem ==  5)//HatBoater1
			{
                SetPlayerAttachedObject(playerid, 1, 18944, 2, 0.15, 0.0, 0, 180, 0, 10);
			}
			if(listitem ==  6)//HatBoater2
			{
                SetPlayerAttachedObject(playerid, 1, 18945, 2, 0.15, 0.0, 0, 180, 0, 10);
			}
			if(listitem ==  7)//HatBoater3
			{
                SetPlayerAttachedObject(playerid, 1, 18946, 2, 0.15, 0.0, 0, 180, 0, 10);
			}
			if(listitem ==  8)//Bowler1
			{
                SetPlayerAttachedObject(playerid, 1, 18947, 2, 0.15, 0.0, 0, 180, 0, 10);
			}
			if(listitem ==  9)//Bowler2
			{
                SetPlayerAttachedObject(playerid, 1, 18948, 2, 0.15, 0.0, 0, 180, 0, 10);
			}
			if(listitem ==  10)//Bowler3
			{
                SetPlayerAttachedObject(playerid, 1, 18949, 2, 0.15, 0.0, 0, 180, 0, 10);
			}
			if(listitem ==  11)//Bowler4
			{
                SetPlayerAttachedObject(playerid, 1, 18950, 2, 0.15, 0.0, 0, 180, 0, 10);
			}
			if(listitem ==  12)//Bowler5
			{
                SetPlayerAttachedObject(playerid, 1, 18951, 2, 0.15, 0.0, 0, 180, 0, 10);
			}
			if(listitem ==  13)//weiter
			{
	    		new listitems[] = "{FFFFFF}14\t{55EE55}Barret 1\n{FFFFFF}15\t{55EE55}Barret 2\n{FFFFFF}16\t{55EE55}Barret 3\n{FFFFFF}17\t{55EE55}Barret 4\n{FFFFFF}18\t{55EE55}Barret 5\n{FFFFFF}19\t{55EE55}CapBack 1\n{FFFFFF}20\t{55EE55}CapBack 2\n{FFFFFF}21\t{55EE55}CapBack 3\n{FFFFFF}22\t{55EE55}CapBack 4\n{FFFFFF}23\t{55EE55}CapBack 5\n{FFFFFF}24\t{55EE55}CapKnit 1\n{FFFFFF}25\t{55EE55}CapKnit 2\n{FFFFFF}26\t{55EE55}CapRimUp\n{55EE55}>>weiter<<";
	    		ShowPlayerDialog(playerid,207,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix>headgear 2/6:",listitems,"wear","back");
			}
		}
		else
		{
	    	new listitems[] = "{FFFFFF}1\t{55EE55}headgear\n{FFFFFF}2\t{55EE55}glasses\n{FFFFFF}3\t{55EE55}bandanna\n{FFFFFF}4\t{55EE55}masks\n{FFFFFF}5\t{55EE55}deleted\n{FFFFFF}6\t{55EE55}remove clothes";
	    	ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix:",listitems,"wear","cancel");
		}
		return 1;
	}
	if(dialogid == 207)
	{
	    if(response)
	    {
			if(listitem ==  0)//Beret 1
			{
                SetPlayerAttachedObject(playerid, 1, 18921, 2, 0.15, -0.03, 0.01, 180, 0, 30);
			}
			if(listitem ==  1)//Beret 2
			{
			    SetPlayerAttachedObject(playerid, 1, 18922, 2, 0.15, -0.03, 0.01, 180, 0, 30);
			}
			if(listitem ==  2)//Beret 3
			{
                SetPlayerAttachedObject(playerid, 1, 18923, 2, 0.15, -0.03, 0.01, 180, 0, 30);
			}
			if(listitem ==  3)//Beret 4
			{
                SetPlayerAttachedObject(playerid, 1, 18924, 2, 0.15, -0.03, 0.01, 180, 0, 30);
			}
			if(listitem ==  4)//Beret 5
			{
                SetPlayerAttachedObject(playerid, 1, 18925, 2, 0.15, -0.03, 0.01, 180, 0, 30);
			}
			if(listitem ==  5)//CapBack1
			{
                SetPlayerAttachedObject(playerid, 1, 18939, 2, 0.17, -0.03, 0.01, 180, 0, 30);
			}
			if(listitem ==  6)//CapBack2
			{
                SetPlayerAttachedObject(playerid, 1, 18940, 2, 0.17, -0.03, 0.01, 180, 0, 30);
			}
			if(listitem ==  7)//CapBack3
			{
                SetPlayerAttachedObject(playerid, 1, 18941, 2, 0.17, -0.03, 0.01, 180, 0, 30);
			}
			if(listitem ==  8)//CapBack4
			{
                SetPlayerAttachedObject(playerid, 1, 18942, 2, 0.17, -0.03, 0.01, 180, 0, 30);
			}
			if(listitem ==  9)//CapBack5
			{
                SetPlayerAttachedObject(playerid, 1, 18943, 2, 0.17, -0.03, 0.01, 180, 0, 30);
			}
			if(listitem ==  10)//CapKnit 1
			{
                SetPlayerAttachedObject(playerid, 1, 18953, 2, 0.13, -0.03, 0.00, 180, 0, 30);
			}
			if(listitem ==  11)//CapKnit 2
			{
                SetPlayerAttachedObject(playerid, 1, 18954, 2, 0.13, -0.03, 0.00, 180, 0, 30);
			}
			if(listitem ==  12)//CapRimUp
			{
                SetPlayerAttachedObject(playerid, 1, 18960, 2, 0.13, 0, 0, 88, 75, 0);
			}
			if(listitem ==  13)//weiter
			{
	    		new listitems[] = "{FFFFFF}27\t{55EE55}CapTrucker1\n{FFFFFF}28\t{55EE55}CowboyHat1\n{FFFFFF}29\t{55EE55}SkullyCap1\n{FFFFFF}30\t{55EE55}SkullyCap2\n{FFFFFF}31\t{55EE55}SkullyCap3\n{FFFFFF}32\t{55EE55}HatMan1\n{FFFFFF}33\t{55EE55}HatMan2\n{FFFFFF}34\t{55EE55}HatMan3\n{FFFFFF}35\t{55EE55}HatTiger\n{FFFFFF}36\t{55EE55}HatCool1\n{FFFFFF}37\t{55EE55}HatCool2\n{FFFFFF}38\t{55EE55}HatCool3\n{55EE55}>>weiter<<";
	    		ShowPlayerDialog(playerid,208,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix>headgear 3/6:",listitems,"wear","back");
			}
		}
		else
		{
	    	new listitems[] = "{FFFFFF}1\t{55EE55}headgear\n{FFFFFF}2\t{55EE55}glasses\n{FFFFFF}3\t{55EE55}bandanna\n{FFFFFF}4\t{55EE55}masks\n{FFFFFF}5\t{55EE55}deleted\n{FFFFFF}6\t{55EE55}remove clothes";
	    	ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix:",listitems,"wear","cancel");
		}
		return 1;
	}
	if(dialogid == 208)
	{
	    if(response)
	    {
			if(listitem ==  0)//CapTrucker1
			{
                SetPlayerAttachedObject(playerid, 1, 18961, 2, 0.14, 0, 0, 88, 75, 0);
			}
			if(listitem ==  1)//CowboyHat1
			{
                SetPlayerAttachedObject(playerid, 1, 18962, 2, 0.14, 0, 0, 88, 75, 0);
			}
			if(listitem ==  2)//SkullyCap1
			{
                SetPlayerAttachedObject(playerid, 1, 18964, 2, 0.125, 0.015, 0, 90, 100, 0);
			}
			if(listitem ==  3)//SkullyCap2
			{
                SetPlayerAttachedObject(playerid, 1, 18965, 2, 0.125, 0.015, 0, 90, 100, 0);
			}
			if(listitem ==  4)//SkullyCap3
			{
                SetPlayerAttachedObject(playerid, 1, 18966, 2, 0.125, 0.015, 0, 90, 100, 0);
			}
			if(listitem ==  5)//HatMan1
			{
                SetPlayerAttachedObject(playerid, 1, 18967, 2, 0.125, 0.015, 0, 90, 80, 0);
			}
			if(listitem ==  6)//HatMan2
			{
                SetPlayerAttachedObject(playerid, 1, 18968, 2, 0.125, 0.015, 0, 90, 80, 0);
			}
			if(listitem ==  7)//HatMan2
			{
                SetPlayerAttachedObject(playerid, 1, 18969, 2, 0.125, 0.015, 0, 90, 80, 0);
			}
			if(listitem ==  8)//HatTiger
			{
                SetPlayerAttachedObject(playerid, 1, 18970, 2, 0.125, 0.015, 0, 90, 80, 0);
			}
			if(listitem ==  9)//HatCool1
			{
                SetPlayerAttachedObject(playerid, 1, 18971, 2, 0.125, 0.015, 0, 90, 80, 0);
			}
			if(listitem ==  10)//HatCool2
			{
                SetPlayerAttachedObject(playerid, 1, 18972, 2, 0.125, 0.015, 0, 90, 80, 0);
			}
			if(listitem ==  11)//HatCool3
			{
                SetPlayerAttachedObject(playerid, 1, 18973, 2, 0.125, 0.015, 0, 90, 80, 0);
			}
			if(listitem ==  12)//weiter
			{
	    		new listitems[] = "{FFFFFF}39\t{55EE55}CapOverEye1\n{FFFFFF}40\t{55EE55}CapOverEye2\n{FFFFFF}41\t{55EE55}CapOverEye3\n{FFFFFF}42\t{55EE55}CapOverEye4\n{FFFFFF}43\t{55EE55}CapOverEye5\n{FFFFFF}44\t{55EE55}Helmet1\n{FFFFFF}45\t{55EE55}Helmet2\n{FFFFFF}46\t{55EE55}Helmet3\n{FFFFFF}47\t{55EE55}Cap1\n{FFFFFF}48\t{55EE55}Cap2\n{FFFFFF}49\t{55EE55}Cap3\n{FFFFFF}50\t{55EE55}Cap4\n{FFFFFF}51\t{55EE55}Cap5\n{55EE55}>>weiter<<";
	    		ShowPlayerDialog(playerid,209,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix>headgear 4/6:",listitems,"wear","back");
			}
		}
		else
		{
	    	new listitems[] = "{FFFFFF}1\t{55EE55}headgear\n{FFFFFF}2\t{55EE55}glasses\n{FFFFFF}3\t{55EE55}bandanna\n{FFFFFF}4\t{55EE55}masks\n{FFFFFF}5\t{55EE55}deleted\n{FFFFFF}6\t{55EE55}remove clothes";
	    	ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix:",listitems,"wear","cancel");
		}
		return 1;
	}
	if(dialogid == 209)
	{
	    if(response)
	    {
			if(listitem ==  0)//CapOverEye1
			{
                SetPlayerAttachedObject(playerid, 1, 18955, 2, 0.11, 0.02, 0, 88, 75, 0);
			}
			if(listitem ==  1)//CapOverEye2
			{
                SetPlayerAttachedObject(playerid, 1, 18956, 2, 0.11, 0.02, 0, 88, 75, 0);
			}
			if(listitem ==  2)//CapOverEye3
			{
                SetPlayerAttachedObject(playerid, 1, 18957, 2, 0.11, 0.02, 0, 88, 75, 0);
			}
			if(listitem ==  3)//CapOverEye4
			{
                SetPlayerAttachedObject(playerid, 1, 18958, 2, 0.11, 0.02, 0, 88, 75, 0);
			}
			if(listitem ==  4)//CapOverEye5
			{
                SetPlayerAttachedObject(playerid, 1, 18959, 2, 0.11, 0.02, 0, 88, 75, 0);
			}
			if(listitem ==  5)//Helmet1
			{
                SetPlayerAttachedObject(playerid, 1, 18936, 2, 0.105, 0.02, 0, 0, 0, 0);
			}
			if(listitem ==  6)//Helmet2
			{
                SetPlayerAttachedObject(playerid, 1, 18937, 2, 0.105, 0.02, 0, 0, 0, 0);
			}
			if(listitem ==  7)//Helmet3
			{
                SetPlayerAttachedObject(playerid, 1, 18938, 2, 0.105, 0.02, 0, 0, 0, 0);
			}
			if(listitem ==  8)//Cap1
			{
                SetPlayerAttachedObject(playerid, 1, 18926, 2, 0.17, 0, -0.01, 0, 0, 0);
			}
			if(listitem ==  9)//Cap2
			{
                SetPlayerAttachedObject(playerid, 1, 18927, 2, 0.17, 0, -0.01, 0, 0, 0);
			}
			if(listitem ==  10)//Cap3
			{
                SetPlayerAttachedObject(playerid, 1, 18928, 2, 0.17, 0, -0.01, 0, 0, 0);
			}
			if(listitem ==  11)//Cap4
			{
                SetPlayerAttachedObject(playerid, 1, 18929, 2, 0.17, 0, -0.01, 0, 0, 0);
			}
			if(listitem ==  12)//Cap5
			{
                SetPlayerAttachedObject(playerid, 1, 18930, 2, 0.17, 0, -0.01, 0, 0, 0);
			}
			if(listitem == 13)//weiter
			{
	    		new listitems[] = "{FFFFFF}52\t{55EE55}Cap6\n{FFFFFF}53\t{55EE55}Cap7\n{FFFFFF}54\t{55EE55}Cap8\n{FFFFFF}55\t{55EE55}Cap9\n{FFFFFF}56\t{55EE55}Cap10\n{FFFFFF}57\t{55EE55}Kopftuch1\n{FFFFFF}58\t{55EE55}Kopftuch2\n{FFFFFF}59\t{55EE55}Kopftuch3\n{FFFFFF}60\t{55EE55}Kopftuch4\n{FFFFFF}61\t{55EE55}Kopftuch5\n{FFFFFF}62\t{55EE55}Kopftuch6\n{FFFFFF}63\t{55EE55}Kopftuch7\n{FFFFFF}64\t{55EE55}Kopftuch8\n{55EE55}>>weiter<<";
	    		ShowPlayerDialog(playerid,210,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix>headgear 5/6:",listitems,"wear","back");
			}
		}
		else
		{
	    	new listitems[] = "{FFFFFF}1\t{55EE55}headgear\n{FFFFFF}2\t{55EE55}glasses\n{FFFFFF}3\t{55EE55}bandanna\n{FFFFFF}4\t{55EE55}masks\n{FFFFFF}5\t{55EE55}deleted\n{FFFFFF}6\t{55EE55}remove clothes";
	    	ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix:",listitems,"wear","cancel");
		}
		return 1;
	}
	if(dialogid == 210)
	{
	    if(response)
	    {
			if(listitem ==  0)//Cap6
			{
                SetPlayerAttachedObject(playerid, 1, 18931, 2, 0.17, 0, -0.01, 0, 0, 0);
			}
			if(listitem ==  1)//Cap7
			{
                SetPlayerAttachedObject(playerid, 1, 18932, 2, 0.17, 0, -0.01, 0, 0, 0);
			}
			if(listitem ==  2)//Cap8
			{
                SetPlayerAttachedObject(playerid, 1, 18933, 2, 0.17, 0, -0.01, 0, 0, 0);
			}
			if(listitem ==  3)//Cap9
			{
                SetPlayerAttachedObject(playerid, 1, 18934, 2, 0.17, 0, -0.01, 0, 0, 0);
			}
			if(listitem ==  4)//Cap10
			{
                SetPlayerAttachedObject(playerid, 1, 18935, 2, 0.17, 0, -0.01, 0, 0, 0);
			}
			if(listitem ==  5)//Kopftuch1
			{
                SetPlayerAttachedObject(playerid, 1, 18891, 2, 0.15, -0.013, 0.001, 90, -30, -90);
			}
			if(listitem ==  6)//Kopftuch2
			{
                SetPlayerAttachedObject(playerid, 1, 18892, 2, 0.15, -0.013, 0.001, 90, -30, -90);
			}
			if(listitem ==  7)//Kopftuch3
			{
                SetPlayerAttachedObject(playerid, 1, 18893, 2, 0.15, -0.013, 0.001, 90, -30, -90);
			}
			if(listitem ==  8)//Kopftuch4
			{
                SetPlayerAttachedObject(playerid, 1, 18894, 2, 0.15, -0.013, 0.001, 90, -30, -90);
			}
			if(listitem ==  9)//Kopftuch5
			{
                SetPlayerAttachedObject(playerid, 1, 18895, 2, 0.15, -0.013, 0.001, 90, -30, -90);
			}
			if(listitem ==  10)//Kopftuch6
			{
                SetPlayerAttachedObject(playerid, 1, 18896, 2, 0.15, -0.013, 0.001, 90, -30, -90);
			}
			if(listitem ==  11)//Kopftuch7
			{
                SetPlayerAttachedObject(playerid, 1, 18897, 2, 0.15, -0.013, 0.001, 90, -30, -90);
			}
			if(listitem ==  12)//Kopftuch8
			{
                SetPlayerAttachedObject(playerid, 1, 18898, 2, 0.15, -0.013, 0.001, 90, -30, -90);
			}
			if(listitem ==  13)//weiter
			{
	    		new listitems[] = "{FFFFFF}65\t{55EE55}Kopftuch9\n{FFFFFF}66\t{55EE55}Kopftuch10\n{FFFFFF}67\t{55EE55}Kopftuch11\n{FFFFFF}68\t{55EE55}Kopftuch12\n{FFFFFF}69\t{55EE55}Kopftuch13\n{FFFFFF}70\t{55EE55}Kopftuch14\n{FFFFFF}71\t{55EE55}Kopftuch15\n{FFFFFF}72\t{55EE55}Kopftuch16\n{FFFFFF}73\t{55EE55}Kopftuch17\n{FFFFFF}74\t{55EE55}Kopftuch18\n{FFFFFF}75\t{55EE55}Kopftuch19\n{FFFFFF}76\t{55EE55}Kopftuch20\n";
	    		ShowPlayerDialog(playerid,212,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix>headgear 6/6:",listitems,"wear","back");
			}
		}
		else
		{
	    	new listitems[] = "{FFFFFF}1\t{55EE55}headgear\n{FFFFFF}2\t{55EE55}glasses\n{FFFFFF}3\t{55EE55}bandanna\n{FFFFFF}4\t{55EE55}masks\n{FFFFFF}5\t{55EE55}deleted\n{FFFFFF}6\t{55EE55}remove clothes";
	    	ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix:",listitems,"wear","cancel");
		}
		return 1;
	}
	if(dialogid == 212)
	{
	    if(response)
	    {
			if(listitem ==  0)//Kopftuch9
			{
                SetPlayerAttachedObject(playerid, 1, 18899, 2, 0.15, -0.013, 0.001, 90, -30, -90);
			}
			if(listitem ==  1)//Kopftuch10
			{
                SetPlayerAttachedObject(playerid, 1, 18900, 2, 0.15, -0.013, 0.001, 90, -30, -90);
			}
			if(listitem ==  2)//Kopftuch11
			{
                SetPlayerAttachedObject(playerid, 1, 18901, 2, 0.15, -0.013, 0.001, 90, -30, -90);
			}
			if(listitem ==  3)//Kopftuch12
			{
                SetPlayerAttachedObject(playerid, 1, 18902, 2, 0.15, -0.013, 0.001, 90, -30, -90);
			}
			if(listitem ==  4)//Kopftuch13
			{
                SetPlayerAttachedObject(playerid, 1, 18903, 2, 0.15, -0.013, 0.001, 90, -30, -90);
			}
			if(listitem ==  5)//Kopftuch14
			{
                SetPlayerAttachedObject(playerid, 1, 18904, 2, 0.15, -0.013, 0.001, 90, -30, -90);
			}
			if(listitem ==  6)//Kopftuch15
			{
                SetPlayerAttachedObject(playerid, 1, 18905, 2, 0.15, -0.013, 0.001, 90, -30, -90);
			}
			if(listitem ==  7)//Kopftuch16
   			{
                SetPlayerAttachedObject(playerid, 1, 18906, 2, 0.12, -0.02, 0.001, 90, -60, -90);
			}
			if(listitem ==  8)//Kopftuch17
			{
                SetPlayerAttachedObject(playerid, 1, 18907, 2, 0.12, -0.02, 0.001, 90, -60, -90);
			}
			if(listitem ==  9)//Kopftuch18
			{
                SetPlayerAttachedObject(playerid, 1, 18908, 2, 0.12, -0.02, 0.001, 90, -60, -90);
			}
			if(listitem ==  10)//Kopftuch19
			{
                SetPlayerAttachedObject(playerid, 1, 18909, 2, 0.12, -0.02, 0.001, 90, -60, -90);
			}
			if(listitem ==  11)//Kopftuch20
			{
                SetPlayerAttachedObject(playerid, 1, 18910, 2, 0.12, -0.02, 0.001, 90, -60, -90);
			}
		}
		else
		{
	    	new listitems[] = "{FFFFFF}1\t{55EE55}headgear\n{FFFFFF}2\t{55EE55}glasses\n{FFFFFF}3\t{55EE55}bandanna\n{FFFFFF}4\t{55EE55}masks\n{FFFFFF}5\t{55EE55}deleted\n{FFFFFF}6\t{55EE55}remove clothes";
	    	ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix:",listitems,"wear","cancel");
		}
		return 1;
	}
	if(dialogid == 202)
	{
	    if(response)
	    {
			if(listitem ==  0)//GlassesType1
			{
                SetPlayerAttachedObject(playerid, 2, 19006, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  1)//GlassesType2
			{
                SetPlayerAttachedObject(playerid, 2, 19007, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  2)//GlassesType3
			{
                SetPlayerAttachedObject(playerid, 2, 19008, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  3)//GlassesType4
			{
                SetPlayerAttachedObject(playerid, 2, 19009, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  4)//GlassesType5
			{
                SetPlayerAttachedObject(playerid, 2, 19010, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  5)//GlassesType6
			{
                SetPlayerAttachedObject(playerid, 2, 19011, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  6)//GlassesType7
			{
                SetPlayerAttachedObject(playerid, 2, 19012, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  7)//GlassesType8
			{
                SetPlayerAttachedObject(playerid, 2, 19013, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  8)//GlassesType9
			{
                SetPlayerAttachedObject(playerid, 2, 19014, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  9)//GlassesType10
			{
                SetPlayerAttachedObject(playerid, 2, 19015, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem == 10)//weiter
			{
 				new listitems[] = "{FFFFFF}11\t{55EE55}Brille 11\n{FFFFFF}12\t{55EE55}Brille 12\n{FFFFFF}13\t{55EE55}Brille 13\n{FFFFFF}14\t{55EE55}Brille 14\n{FFFFFF}15\t{55EE55}Brille 15\n{FFFFFF}16\t{55EE55}Brille 16\n{FFFFFF}17\t{55EE55}Brille 17\n{FFFFFF}18\t{55EE55}Brille 18\n{FFFFFF}19\t{55EE55}Brille 19\n{FFFFFF}20\t{55EE55}Brille 20\n{55EE55}>>weiter<<";
	    		ShowPlayerDialog(playerid,203,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix>glasses 2/3:",listitems,"wear","back");
			}
		}
		else
		{
	    	new listitems[] = "{FFFFFF}1\t{55EE55}headgear\n{FFFFFF}2\t{55EE55}glasses\n{FFFFFF}3\t{55EE55}bandanna\n{FFFFFF}4\t{55EE55}masks\n{FFFFFF}5\t{55EE55}deleted\n{FFFFFF}6\t{55EE55}remove clothes";
	    	ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix:",listitems,"wear","cancel");
		}
		return 1;
	}
	if(dialogid == 203)
	{
	    if(response)
	    {
			if(listitem ==  0)//GlassesType11
			{
                SetPlayerAttachedObject(playerid, 2, 19016, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  1)//GlassesType12
			{
                SetPlayerAttachedObject(playerid, 2, 19017, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  2)//GlassesType13
			{
                SetPlayerAttachedObject(playerid, 2, 19018, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  3)//GlassesType14
			{
                SetPlayerAttachedObject(playerid, 2, 19019, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  4)//GlassesType15
			{
                SetPlayerAttachedObject(playerid, 2, 19020, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  5)//GlassesType16
			{
                SetPlayerAttachedObject(playerid, 2, 19021, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  6)//GlassesType17
			{
                SetPlayerAttachedObject(playerid, 2, 19022, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  7)//GlassesType18
			{
                SetPlayerAttachedObject(playerid, 2, 19023, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  8)//GlassesType19
			{
                SetPlayerAttachedObject(playerid, 2, 19024, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  9)//GlassesType20
			{
                SetPlayerAttachedObject(playerid, 2, 19025, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem == 10)//weiter
			{
 				new listitems[] = "{FFFFFF}21\t{55EE55}Brille 21\n{FFFFFF}22\t{55EE55}Brille 22\n{FFFFFF}23\t{55EE55}Brille 23\n{FFFFFF}24\t{55EE55}Brille 24\n{FFFFFF}25\t{55EE55}Brille 25\n{FFFFFF}26\t{55EE55}Brille 26\n{FFFFFF}27\t{55EE55}Brille 27\n{FFFFFF}28\t{55EE55}Brille 28\n{FFFFFF}29\t{55EE55}Brille 29\n{FFFFFF}30\t{55EE55}Brille 30";
	    		ShowPlayerDialog(playerid,204,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix>glasses 3/3:",listitems,"wear","back");
			}
		}
		else
		{
	    	new listitems[] = "{FFFFFF}1\t{55EE55}headgear\n{FFFFFF}2\t{55EE55}glasses\n{FFFFFF}3\t{55EE55}bandanna\n{FFFFFF}4\t{55EE55}masks\n{FFFFFF}5\t{55EE55}deleted\n{FFFFFF}6\t{55EE55}remove clothes";
	    	ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix:",listitems,"wear","cancel");
		}
		return 1;
	}
	if(dialogid == 204)
	{
	    if(response)
	    {
			if(listitem ==  0)//GlassesType21
			{
                SetPlayerAttachedObject(playerid, 2, 19026, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  1)//GlassesType22
			{
                SetPlayerAttachedObject(playerid, 2, 19027, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  2)//GlassesType23
			{
                SetPlayerAttachedObject(playerid, 2, 19028, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  3)//GlassesType24
			{
                SetPlayerAttachedObject(playerid, 2, 19029, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  4)//GlassesType25
			{
                SetPlayerAttachedObject(playerid, 2, 19030, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  5)//GlassesType26
			{
                SetPlayerAttachedObject(playerid, 2, 19031, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  6)//GlassesType27
			{
                SetPlayerAttachedObject(playerid, 2, 19032, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  7)//GlassesType28
			{
                SetPlayerAttachedObject(playerid, 2, 19033, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  8)//GlassesType29
			{
                SetPlayerAttachedObject(playerid, 2, 19034, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
			if(listitem ==  9)//GlassesType30
			{
                SetPlayerAttachedObject(playerid, 2, 19035, 2, 0.09, 0.04, 0, 88, 75, 0);
			}
		}
		else
		{
	    	new listitems[] = "{FFFFFF}1\t{55EE55}headgear\n{FFFFFF}2\t{55EE55}glasses\n{FFFFFF}3\t{55EE55}bandanna\n{FFFFFF}4\t{55EE55}masks\n{FFFFFF}5\t{55EE55}deleted\n{FFFFFF}6\t{55EE55}remove clothes";
	    	ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix:",listitems,"wear","cancel");
		}
		return 1;
	}
	if(dialogid == 205)
	{
	    if(response)
	    {
			if(listitem ==  0)//bandanna1
			{
                SetPlayerAttachedObject(playerid, 3, 18911, 2, -0.08, 0.03, 0.0, 90, -180, -90);
			}
			if(listitem ==  1)//bandanna2
			{
                SetPlayerAttachedObject(playerid, 3, 18912, 2, -0.08, 0.03, 0.0, 90, -180, -90);
			}
			if(listitem ==  2)//bandanna3
			{
                SetPlayerAttachedObject(playerid, 3, 18913, 2, -0.08, 0.03, 0.0, 90, -180, -90);
			}
			if(listitem ==  3)//bandanna4
			{
                SetPlayerAttachedObject(playerid, 3, 18914, 2, -0.08, 0.03, 0.0, 90, -180, -90);
			}
			if(listitem ==  4)//bandanna5
			{
                SetPlayerAttachedObject(playerid, 3, 18915, 2, -0.08, 0.03, 0.0, 90, -180, -90);
			}
			if(listitem ==  5)//bandanna6
			{
                SetPlayerAttachedObject(playerid, 3, 18916, 2, -0.08, 0.03, 0.0, 90, -180, -90);
			}
			if(listitem ==  6)//bandanna7
			{
                SetPlayerAttachedObject(playerid, 3, 18917, 2, -0.08, 0.03, 0.0, 90, -180, -90);
			}
			if(listitem ==  7)//bandanna8
			{
                SetPlayerAttachedObject(playerid, 3, 18918, 2, -0.08, 0.03, 0.0, 90, -180, -90);
			}
			if(listitem ==  8)//bandanna9
			{
                SetPlayerAttachedObject(playerid, 3, 18919, 2, -0.08, 0.03, 0.0, 90, -180, -90);
			}
			if(listitem ==  9)//bandanna10
			{
                SetPlayerAttachedObject(playerid, 3, 18920, 2, -0.08, 0.03, 0.0, 90, -180, -90);
			}
		}
		else
		{
	    	new listitems[] = "{FFFFFF}1\t{55EE55}headgear\n{FFFFFF}2\t{55EE55}glasses\n{FFFFFF}3\t{55EE55}bandanna\n{FFFFFF}4\t{55EE55}masks\n{FFFFFF}5\t{55EE55}deleted\n{FFFFFF}6\t{55EE55}remove clothes";
	    	ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix:",listitems,"wear","cancel");
		}
		return 1;
	}
	if(dialogid == 211)
	{
	    if(response)
	    {
			if(listitem ==  0)//Hockeymask1
			{
                SetPlayerAttachedObject(playerid, 1, 19036, 2, 0.107, 0.020, 0.0, 90, 90, 0);
			}
			if(listitem ==  1)//Hockeymask2
			{
                SetPlayerAttachedObject(playerid, 1, 19037, 2, 0.107, 0.020, 0.0, 90, 90, 0);
			}
			if(listitem ==  2)//Hockeymask3
			{
                SetPlayerAttachedObject(playerid, 1, 19038, 2, 0.107, 0.020, 0.0, 90, 90, 0);
			}
			if(listitem ==  3)//Zorromask
			{
                SetPlayerAttachedObject(playerid, 1, 18974, 2, 0.098, 0.0258, 0.0, 90, 90, 0);
			}
			if(listitem ==  4)//Boxing
			{
                SetPlayerAttachedObject(playerid, 1, 18952, 2, 0.105, 0.01, 0.0, 0, 0, 0);
			}
		}
		else
		{
	    	new listitems[] = "{FFFFFF}1\t{55EE55}headgear\n{FFFFFF}2\t{55EE55}glasses\n{FFFFFF}3\t{55EE55}bandanna\n{FFFFFF}4\t{55EE55}masks\n{FFFFFF}5\t{55EE55}deleted\n{FFFFFF}6\t{55EE55}remove clothes";
	    	ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{448844}Clothes by Kane_Phoenix:",listitems,"wear","cancel");
		}
		return 1;
	}
	return 1;
}

/*
Dont REMOVE any CREDITS!!!
*/