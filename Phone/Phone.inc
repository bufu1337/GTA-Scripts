/*
-------------------------------------------------------------
|-----------GTA-IV--Cell--Phone--Script--By--Wazza----------|
|-----------Do--Not--Claim--This--As--Your--Own---------------|
|--------------------------------------Reedit by Nodward--------------|
-------------------------------------------------------------*/
#include <a_samp>

/*
native PlayerButtonMode(playerid, mode);
native SetPhoneScreenText(playerid, option, string[], null);
native ShowPhoneForPlayer(playerid);
native HidePhoneForPlayer(playerid);
native PhoneRestoreDefaults(playerid);
native AddPhoneMenu(menuid, title[]);*/


//CALLBACKS
forward OnPlayerSelectedPhoneMenuRow(playerid, rowid);
forward OnPlayerSelectedPhoneKey(playerid, key);
forward OnPhoneShown(playerid);
forward OnPhoneHidden(playerid);

new Text:PhoneBack,
Text:Textdraw1,
Text:Textdraw2,
Text:Textdraw3,
Text:Textdraw4,
Text:Textdraw5,
Text:Textdraw6,
Text:Textdraw7,
              Text:PhoneMenuOption[MAX_PLAYERS],
	Text:PhoneButtons[MAX_PLAYERS],
	PhoneInOut[MAX_PLAYERS],
	CurrentKey[MAX_PLAYERS],
	GetCurrentKeysTimer[MAX_PLAYERS],
	PhoneButtonMode[MAX_PLAYERS],//0 = Not in Phone, 1 = Menu Scrolling, 2 = Numbers
	PhoneMenuCallItemPosition[MAX_PLAYERS],//Where the player is in menu
	PhoneMenuAmount,
	PhoneMenu1[100],
	PhoneMenu2[100],
	PhoneMenu3[100],
	PhoneMenu4[100],
	PhoneMenu5[100],
	PhoneMenu6[100],
	PhoneMenu7[100],
	PhoneMenu8[100],
	PhoneMenu9[100],
	PhoneMenu10[100],
	PhoneMenuString[500];

public OnGameModeInit()
{

	PhoneBack = TextDrawCreate(521.000000,268.000000,"û");
              TextDrawUseBox(PhoneBack,1);
              TextDrawBoxColor(PhoneBack,0x000000ff);
              TextDrawTextSize(PhoneBack,580.000000,0.000000);
              TextDrawAlignment(PhoneBack,0);
              TextDrawBackgroundColor(PhoneBack,0x000000ff);
              TextDrawFont(PhoneBack,0);
              TextDrawLetterSize(PhoneBack,1.000000,12.099997);
              TextDrawColor(PhoneBack,0x000000ff);
              TextDrawSetOutline(PhoneBack,1);
              TextDrawSetProportional(PhoneBack,1);
              TextDrawSetShadow(PhoneBack,1);

Textdraw1 = TextDrawCreate(521.000000,268.000000,"û");
Textdraw2 = TextDrawCreate(521.000000,268.000000,"û");
Textdraw3 = TextDrawCreate(526.000000,281.000000,"û");
Textdraw4 = TextDrawCreate(522.000000,269.000000,"Nichrome E10");
Textdraw5 = TextDrawCreate(541.000000,336.000000,"û");
Textdraw6 = TextDrawCreate(540.000000,311.000000,"+");
Textdraw7 = TextDrawCreate(520.000000,314.000000,"~g~-  ~r~-");
TextDrawUseBox(Textdraw1,1);
TextDrawBoxColor(Textdraw1,0xffffff33);
TextDrawTextSize(Textdraw1,580.000000,0.000000);
TextDrawUseBox(Textdraw2,1);
TextDrawBoxColor(Textdraw2,0xffffff33);
TextDrawTextSize(Textdraw2,580.000000,0.000000);
TextDrawUseBox(Textdraw3,1);
TextDrawBoxColor(Textdraw3,0x00ff00ff);
TextDrawTextSize(Textdraw3,576.000000,0.000000);
TextDrawUseBox(Textdraw5,1);
TextDrawBoxColor(Textdraw5,0xffffff33);
TextDrawTextSize(Textdraw5,561.000000,-3.000000);
TextDrawAlignment(Textdraw1,0);
TextDrawAlignment(Textdraw2,0);
TextDrawAlignment(Textdraw3,0);
TextDrawAlignment(Textdraw4,0);
TextDrawAlignment(Textdraw5,0);
TextDrawAlignment(Textdraw6,0);
TextDrawAlignment(Textdraw7,0);
TextDrawBackgroundColor(Textdraw1,0xffffffff);
TextDrawBackgroundColor(Textdraw2,0x000000ff);
TextDrawBackgroundColor(Textdraw3,0x000000ff);
TextDrawBackgroundColor(Textdraw4,0x00000033);
TextDrawBackgroundColor(Textdraw5,0x000000ff);
TextDrawBackgroundColor(Textdraw6,0x00000099);
TextDrawBackgroundColor(Textdraw7,0x00000033);
TextDrawFont(Textdraw1,0);
TextDrawLetterSize(Textdraw1,1.000000,12.100009);
TextDrawFont(Textdraw2,0);
TextDrawLetterSize(Textdraw2,1.000000,5.899996);
TextDrawFont(Textdraw3,0);
TextDrawLetterSize(Textdraw3,1.000000,3.499998);
TextDrawFont(Textdraw4,2);
TextDrawLetterSize(Textdraw4,0.199999,0.800000);
TextDrawFont(Textdraw5,0);
TextDrawLetterSize(Textdraw5,9.199999,-1.699999);
TextDrawFont(Textdraw6,1);
TextDrawLetterSize(Textdraw6,1.000000,2.699999);
TextDrawFont(Textdraw7,0);
TextDrawLetterSize(Textdraw7,1.200000,2.000000);
TextDrawColor(Textdraw1,0xffffff66);
TextDrawColor(Textdraw2,0xffffffff);
TextDrawColor(Textdraw3,0xffffffff);
TextDrawColor(Textdraw4,0xffffff99);
TextDrawColor(Textdraw5,0xffffffff);
TextDrawColor(Textdraw6,0xffffff99);
TextDrawColor(Textdraw7,0xffffffff);
TextDrawSetOutline(Textdraw1,1);
TextDrawSetOutline(Textdraw2,1);
TextDrawSetOutline(Textdraw3,1);
TextDrawSetOutline(Textdraw4,1);
TextDrawSetOutline(Textdraw5,1);
TextDrawSetOutline(Textdraw6,1);
TextDrawSetOutline(Textdraw7,1);
TextDrawSetProportional(Textdraw1,1);
TextDrawSetProportional(Textdraw2,1);
TextDrawSetProportional(Textdraw3,1);
TextDrawSetProportional(Textdraw4,1);
TextDrawSetProportional(Textdraw5,1);
TextDrawSetProportional(Textdraw6,1);
TextDrawSetProportional(Textdraw7,1);
TextDrawSetShadow(Textdraw1,1);
TextDrawSetShadow(Textdraw2,1);
TextDrawSetShadow(Textdraw3,1);
TextDrawSetShadow(Textdraw4,1);
TextDrawSetShadow(Textdraw6,1);
TextDrawSetShadow(Textdraw7,1);

    for(new playerid=0;playerid<MAX_PLAYERS;playerid++)
    {


		PhoneMenuOption[playerid] = TextDrawCreate(526.000000,279.000000, "Option 1~n~Option 2~n~Option 3");
                            TextDrawAlignment(PhoneMenuOption[playerid],0);
                            TextDrawBackgroundColor(PhoneMenuOption[playerid],0x000000cc);
                            TextDrawFont(PhoneMenuOption[playerid],2);
                            TextDrawLetterSize(PhoneMenuOption[playerid],0.199999,1.000000);
                            TextDrawColor(PhoneMenuOption[playerid],0x00ff0099);
                            TextDrawSetOutline(PhoneMenuOption[playerid],1);
                            TextDrawSetProportional(PhoneMenuOption[playerid],1);
                            TextDrawSetShadow(PhoneMenuOption[playerid],1);






	             PhoneButtons[playerid] = TextDrawCreate(524.000000,333.000000, "1  2 3 ~n~4 5 6 ~n~7 8 9 ~n~]_0_@");
                           TextDrawAlignment(PhoneButtons[playerid],0);
                           TextDrawBackgroundColor(PhoneButtons[playerid],0x00000033);
                           TextDrawFont(PhoneButtons[playerid],2);
                           TextDrawLetterSize(PhoneButtons[playerid],0.499999,1.100000);
                           TextDrawColor(PhoneButtons[playerid],0xffffff99);
                           TextDrawSetOutline(PhoneButtons[playerid],1);
                           TextDrawSetProportional(PhoneButtons[playerid],1);
                           TextDrawSetShadow(PhoneButtons[playerid],1);


	}
	return 1;
}


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PhoneInOut[playerid] == 1) //If Phone is out
    {
        if(newkeys == KEY_WALK)//To hide phone, ALT
        {
        	HidePhoneForPlayer(playerid);
		}
		if(newkeys == KEY_SECONDARY_ATTACK)//ENTER
		{
		    if(PhoneButtonMode[playerid] == 1)// If player is navigating menu
		    {
          		OnPlayerSelectedPhoneMenuRow(playerid, PhoneMenuCallItemPosition[playerid]);
				return 1;
			}
			else
			if(PhoneButtonMode[playerid] == 2)//If is navigating keys
		    {
				new key;
				if(CurrentKey[playerid] == 10){key = 0;}else key = CurrentKey[playerid];
				OnPlayerSelectedPhoneKey(playerid, key);
			}
		}
        return 1;
	}
	return 1;
}

stock PlayerButtonMode(playerid, mode)
{
	if(mode == 1)
	{
	    PhoneButtonMode[playerid] = 1;
	    PhoneMenuCallItemPosition[playerid] = 1;
	    CurrentKey[playerid] = 0;
	}
	if(mode == 2)
	{
	    PhoneButtonMode[playerid] = 2;
		CurrentKey[playerid] = 2;
	}
}

stock SetPhoneScreenText(playerid, option1[], option2[], option3[])
{
	format(PhoneMenuString,sizeof(PhoneMenuString),"~g~%s~n~%s~n~%s",option1, option2,option3);
   	TextDrawSetString(PhoneMenuOption[playerid],PhoneMenuString);
}


forward GetCurrentKeys(playerid);
public GetCurrentKeys(playerid)//Gets the keys
{
	new keys, updown, leftright;
	GetPlayerKeys(playerid, keys, updown, leftright);
	if(PhoneButtonMode[playerid] == 1)//for menu navigating
	{
	    if(updown < 0)//UP
	    {
			PhoneMenuScroll(playerid, 1);//0 for down 1 for up, this is when scrolling the menu
		}
	    if(updown > 0)//DOWN
	    {
			PhoneMenuScroll(playerid, 0);//0 for down 1 for up
		}
	}
	else if(PhoneButtonMode[playerid] == 2)//For key navigating
	{
	    //SendClientMessage(playerid, 0x00A3F6AA, "Picking up key movement and variable.");
		if(updown < 0)//UP
		{
		    if(CurrentKey[playerid] == 4)
		    {
		        CurrentKeyPass(playerid, 1);//This function sends the ey to be highlighted on phone
			}
			else
			if(CurrentKey[playerid] == 5)
		    {
		        CurrentKeyPass(playerid, 2);
			}
			else
			if(CurrentKey[playerid] == 6)
		    {
		        CurrentKeyPass(playerid, 3);
			}
			else
			if(CurrentKey[playerid] == 7)
		    {
		        CurrentKeyPass(playerid, 4);
			}
			else
			if(CurrentKey[playerid] == 8)
		    {
		        CurrentKeyPass(playerid, 5);
			}
			else
			if(CurrentKey[playerid] == 9)
		    {
		        CurrentKeyPass(playerid, 6);
			}
			else
			if(CurrentKey[playerid] == 10)
		    {
		        CurrentKeyPass(playerid, 8);
			}
		}
		if(updown > 0)
		{
		    if(CurrentKey[playerid] == 1)
		    {
		        CurrentKeyPass(playerid, 4);
			}
			else
			if(CurrentKey[playerid] == 2)
		    {
		        CurrentKeyPass(playerid, 5);
			}
			else
			if(CurrentKey[playerid] == 3)
		    {
		        CurrentKeyPass(playerid, 6);
			}
			else
			if(CurrentKey[playerid] == 4)
		    {
		        CurrentKeyPass(playerid, 7);
			}
			else
			if(CurrentKey[playerid] == 5)
		    {
		        CurrentKeyPass(playerid, 8);
			}
			else
			if(CurrentKey[playerid] == 6)
		    {
		        CurrentKeyPass(playerid, 9);
			}
			else
			if(CurrentKey[playerid] == 8)
		    {
		        CurrentKeyPass(playerid, 10);
			}

		}
		if(leftright < 0)
		{
		    if(CurrentKey[playerid] == 1)
		    {
		        CurrentKeyPass(playerid, 10);
			}
			else
			CurrentKeyPass(playerid, CurrentKey[playerid] - 1);

		}
		if(leftright > 0)
		{
		    if(CurrentKey[playerid] == 10)
		    {
		        CurrentKeyPass(playerid, 1);
			}
			else
			CurrentKeyPass(playerid, CurrentKey[playerid] + 1);
		}
	}
	return 1;
}

stock CurrentKeyPass(playerid, key)
{
	if(key == 1)
	{
		TextDrawSetString(PhoneButtons[playerid],"~g~1  ~w~2 3 ~n~4 5 6 ~n~7 8 9 ~n~]_0_@");
	}
	else if(key == 2)
	{
	    TextDrawSetString(PhoneButtons[playerid],"1  ~g~2 ~w~3 ~n~4 5 6 ~n~7 8 9 ~n~]_0_@");
	}
	else if(key == 3)
	{
	    TextDrawSetString(PhoneButtons[playerid],"1  2 ~g~3 ~n~~w~4 5 6 ~n~7 8 9 ~n~]_0_@");
	}
	else if(key == 4)
	{
	    TextDrawSetString(PhoneButtons[playerid],"1  2 3 ~n~~g~4 ~w~5 6 ~n~7 8 9 ~n~]_0_@");
	}
	else if(key == 5)
	{
	    TextDrawSetString(PhoneButtons[playerid],"1  2 3 ~n~4 ~g~5 ~w~6 ~n~7 8 9 ~n~]_0_@");
	}
	else if(key == 6)
	{
	    TextDrawSetString(PhoneButtons[playerid],"1  2 3 ~n~4 5 ~g~6 ~n~~w~7 8 9 ~n~]_0_@");
	}
	else if(key == 7)
	{
	    TextDrawSetString(PhoneButtons[playerid],"1  2 3 ~n~4 5 6 ~n~~g~7 ~w~8 9 ~n~]_0_@");
	}
	else if(key == 8)
	{
	    TextDrawSetString(PhoneButtons[playerid],"1  2 3 ~n~4 5 6 ~n~7 ~g~8 ~w~9 ~n~]_0_@");
	}
	else if(key == 9)
	{
	    TextDrawSetString(PhoneButtons[playerid],"1  2 3 ~n~4 5 6 ~n~7 8 ~g~9 ~n~~w~]_0_@");
	}
	else if(key == 10)
	{
	    TextDrawSetString(PhoneButtons[playerid],"1  2 3 ~n~4 5 6 ~n~7 8 9 ~n~]_~g~0~w~_@");
	}
	CurrentKey[playerid] = key;//the new key
}




stock ShowPhoneForPlayer(playerid)//Shows phone
{
	CurrentKeyPass(playerid, 2);
	TextDrawShowForPlayer(playerid, PhoneBack);
	TextDrawShowForPlayer(playerid, Textdraw1);
	TextDrawShowForPlayer(playerid, Textdraw2);
	TextDrawShowForPlayer(playerid, Textdraw3);
	TextDrawShowForPlayer(playerid, Textdraw4);
	TextDrawShowForPlayer(playerid, Textdraw5);
	TextDrawShowForPlayer(playerid, Textdraw6);
	TextDrawShowForPlayer(playerid, Textdraw7);
	TextDrawShowForPlayer(playerid, PhoneMenuOption[playerid]);
	TextDrawShowForPlayer(playerid, PhoneButtons[playerid]);
	TogglePlayerControllable(playerid, 1);
	format(PhoneMenuString,sizeof(PhoneMenuString),"%s~g~~n~%s~n~%s",PhoneMenu1, PhoneMenu2,PhoneMenu3);
	TextDrawSetString(PhoneMenuOption[playerid],PhoneMenuString);
	PhoneInOut[playerid] = 1;
	GetCurrentKeysTimer[playerid] = SetTimerEx("GetCurrentKeys",200,1,"d",playerid);
	PhoneButtonMode[playerid] = 1;
	SetPlayerSpecialAction(playerid,11);//Phone Out
	TogglePlayerControllable(playerid, 0);
	OnPhoneShown(playerid);
	
	return 1;
}
stock HidePhoneForPlayer(playerid)//Hides phone
{
	TextDrawHideForPlayer(playerid, PhoneBack);
	TextDrawHideForPlayer(playerid, Textdraw1);
	TextDrawHideForPlayer(playerid, Textdraw2);
	TextDrawHideForPlayer(playerid, Textdraw3);
	TextDrawHideForPlayer(playerid, Textdraw4);
	TextDrawHideForPlayer(playerid, Textdraw5);
	TextDrawHideForPlayer(playerid, Textdraw6);
	TextDrawHideForPlayer(playerid, Textdraw7);
	TextDrawHideForPlayer(playerid, PhoneMenuOption[playerid]);
	TextDrawHideForPlayer(playerid, PhoneButtons[playerid]);
	TogglePlayerControllable(playerid, 0);
	PhoneRestoreDefaults(playerid);
	PhoneButtonMode[playerid] = 2;
	PhoneInOut[playerid] = 0;
	KillTimer(GetCurrentKeysTimer[playerid]);
	CurrentKeyPass(playerid, 0);
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
	TogglePlayerControllable(playerid, 1);
	OnPhoneHidden(playerid);

	
	return 1;
}

stock UpdatePhoneForPlayer(playerid)//Updates textdraws
{
	if(PhoneInOut[playerid] == 1)
	{
	    HidePhoneForPlayer(playerid);

		ShowPhoneForPlayer(playerid);
		return 1;
	}
	else
	{
		HidePhoneForPlayer(playerid);
		return 1;
	}
}

stock PhoneMenuScroll(playerid, updown) // 0 for down, 1 for up
{//Function is for scrolling menu
	if(updown == 0)
	{
	    PhoneMenuCallItemPosition[playerid] += 1;
	    if(PhoneMenuCallItemPosition[playerid] > PhoneMenuAmount)
	    {
	        PhoneMenuCallItemPosition[playerid] = 1;
		}
	}
	else if(updown == 1)
	{
	    PhoneMenuCallItemPosition[playerid] -= 1;
	    if(PhoneMenuCallItemPosition[playerid] < 1)
	    {
	        PhoneMenuCallItemPosition[playerid] = PhoneMenuAmount;
	    }
	}
	if(PhoneMenuCallItemPosition[playerid] == 1)
	{
	     format(PhoneMenuString,sizeof(PhoneMenuString),"%s~g~~n~%s~n~%s",PhoneMenu1, PhoneMenu2,PhoneMenu3);
	}
	else if(PhoneMenuCallItemPosition[playerid] == 2)
	{
	     format(PhoneMenuString,sizeof(PhoneMenuString),"%s~g~~n~%s~n~%s",PhoneMenu2, PhoneMenu3,PhoneMenu4);
	}
	else if(PhoneMenuCallItemPosition[playerid] == 3)
	{
                  format(PhoneMenuString,sizeof(PhoneMenuString),"%s~g~~n~%s~n~%s",PhoneMenu3, PhoneMenu4,PhoneMenu5);
	}
 	else if(PhoneMenuCallItemPosition[playerid] == 4)
	{
	    format(PhoneMenuString,sizeof(PhoneMenuString),"%s~g~~n~%s~n~%s",PhoneMenu4, PhoneMenu5,PhoneMenu6);
	}
	else if(PhoneMenuCallItemPosition[playerid] == 5)
	{
	    format(PhoneMenuString,sizeof(PhoneMenuString),"%s~g~~n~%s~n~%s",PhoneMenu5, PhoneMenu6,PhoneMenu7);
	}
	else if(PhoneMenuCallItemPosition[playerid] == 6)
	{
	    format(PhoneMenuString,sizeof(PhoneMenuString),"%s~g~~n~%s~n~%s",PhoneMenu6, PhoneMenu7,PhoneMenu8);
	}
	else if(PhoneMenuCallItemPosition[playerid] == 7)
	{
	    format(PhoneMenuString,sizeof(PhoneMenuString),"%s~g~~n~%s~n~%s",PhoneMenu7, PhoneMenu8,PhoneMenu9);
	}
	else if(PhoneMenuCallItemPosition[playerid] == 8)
	{
	    format(PhoneMenuString,sizeof(PhoneMenuString),"%s~g~~n~%s~n~%s",PhoneMenu8, PhoneMenu9,PhoneMenu10);
	}
	else if(PhoneMenuCallItemPosition[playerid] == 9)
	{
	    format(PhoneMenuString,sizeof(PhoneMenuString),"%s~g~~n~%s~n~%s",PhoneMenu9, PhoneMenu10,PhoneMenu1);
	}
	else if(PhoneMenuCallItemPosition[playerid] == 10)
	{
	   format(PhoneMenuString,sizeof(PhoneMenuString),"%s~g~~n~%s~n~%s",PhoneMenu10, PhoneMenu1,PhoneMenu2);
	}
	TextDrawSetString(PhoneMenuOption[playerid],PhoneMenuString);
}

stock PhoneRestoreDefaults(playerid)//Turn textdraws to normal
{

	CurrentKey[playerid] = 0;
	PlayerButtonMode(playerid, 1);//1 = Menu Scrolling, 2 = Numbers
	PhoneMenuCallItemPosition[playerid] = 1;
}

stock IsPhoneOut(playerid)
{
	if(PhoneInOut[playerid] == 1)
	{
	    return 1;
	}
 	else return 0;
}

stock AddPhoneMenu(title[])
{
	PhoneMenuAmount ++;
	if(PhoneMenuAmount == 1)
	{
		format(PhoneMenu1,sizeof(PhoneMenu1), "%s", title);
	}
	if(PhoneMenuAmount == 2)
	{
		format(PhoneMenu2,sizeof(PhoneMenu2), "%s", title);
	}
	if(PhoneMenuAmount == 3)
	{
		format(PhoneMenu3,sizeof(PhoneMenu3), "%s", title);
	}
	if(PhoneMenuAmount == 4)
	{
		format(PhoneMenu4,sizeof(PhoneMenu4), "%s", title);
	}
	if(PhoneMenuAmount == 5)
	{
		format(PhoneMenu5,sizeof(PhoneMenu5), "%s", title);
	}
	if(PhoneMenuAmount == 6)
	{
		format(PhoneMenu6,sizeof(PhoneMenu6), "%s", title);
	}
	if(PhoneMenuAmount == 7)
	{
		format(PhoneMenu7,sizeof(PhoneMenu7), "%s", title);
	}
	if(PhoneMenuAmount == 8)
	{
		format(PhoneMenu8,sizeof(PhoneMenu8), "%s", title);
	}
	if(PhoneMenuAmount == 9)
	{
		format(PhoneMenu9,sizeof(PhoneMenu9), "%s", title);
	}
	if(PhoneMenuAmount == 10)
	{
		format(PhoneMenu10,sizeof(PhoneMenu10), "%s", title);
	}
	
	return PhoneMenuAmount;
}