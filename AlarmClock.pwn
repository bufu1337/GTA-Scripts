#include <a_samp>
//Snoozing: If your alarm went of, you can snooze it, that means it will be quite for about 7 minutes and than beeps again.
#define DefaultSnoozeTime 420   // 420 seconds = 7 minutes
#define MP MAX_PLAYERS
new IsAlarmTurnedOn[MP];
new AlarmSetHour[MP];
new AlarmSetMinute[MP];
new AlarmMessage[MP][128];
new Menu:AlarmMainMenu[MP];
new Menu:TurnOnMenu[MP];
new Menu:SetHourMenu[MP];
new Menu:SetMinuteMenu[MP];
new Menu:RingingMenu[MP];
new IsAlarmGoingOff[MP];
new MenuType[MP];
new HasToTypeMessage[MP];
new AlarmTimer[MP];
new AlarmStatus[MP];
new IsSnoozing[MP];
new Hour;
new Minute;
new Second;
public OnFilterScriptInit(){
	for(new i; i<MAX_PLAYERS; i++)	{
	    if(IsPlayerConnected(i))	    {
	        CreateMenusForPlayer(i);  //Costum Function: Creates the menu's for online players
		}
	}
	SetTimer("UpdateTime", 1000, 1);  //Starting timer that will check every second the server time and compare that time with alarmsettings of all players
	return 1;
}
public OnFilterScriptExit(){
	for(new i; i<MAX_PLAYERS; i++)	{
        DestroyMenusForPlayer(i); //Calling Costum Function that destroys all menu's.
	}
	return 1;
}
public OnPlayerConnect(playerid){
    IsAlarmTurnedOn[playerid] = 0;
	AlarmSetHour[playerid] = 0;
	AlarmSetMinute[playerid] = 0;
	format(AlarmMessage[playerid], 128, " ");
	IsAlarmGoingOff[playerid] = 0;
	MenuType[playerid] = 0;
	HasToTypeMessage[playerid] = 0;
	AlarmTimer[playerid] = -1;
	IsSnoozing[playerid] = 0;
	AlarmStatus[playerid] = 0;
	CreateMenusForPlayer(playerid);
	return 1;
}
public OnPlayerDisconnect(playerid, reason){
    #if defined ShowClock
	TextDrawDestroy(ClockText[playerid]);
	#endif
	//Destroy all menus for this player
	DestroyMenusForPlayer(playerid);

	return 1;
}
public OnPlayerText(playerid, text[]){
	if(HasToTypeMessage[playerid] == 1) //If the player wants to set a new alarm-messages, he/she will have to do that in the chat:
	{
	    if(strlen(text) > 80) return GameTextForPlayer(playerid, "~y~Typ new alarm-message ~n~~r~Max 80 characters!", 999999, 3);
	    format(AlarmMessage[playerid], 128, "%s", text);
	    new str[128];
	    format(str, 128, "New AlarmMessage: \"%s\"", AlarmMessage[playerid]);
	    SendClientMessage(playerid, 0x00FFFFAA, str);
		GameTextForPlayer(playerid, " ", 100, 3);
	    HasToTypeMessage[playerid] = 0;
	    TogglePlayerControllable(playerid, 1);
	    return 0;  //Returning 0 to prevent this message will be shown in the public chat
	}
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[]){
	if (strcmp("/alarm", cmdtext, true) == 0)  //With this command you can open the Alarm-menu
	{
	    TogglePlayerControllable(playerid, 0);
	    MenuType[playerid] = 4;
	    ChangeMenuHeader(playerid);  //Costum function that will change the menu-header. (in this case it will show the current time.
		ShowMenuForPlayer(AlarmMainMenu[playerid], playerid);
		return 1;
	}

	if (strcmp("/time", cmdtext, true) == 0)  //Command to show current ServerTime
	{
	    new string[128];
	    format(string, 128, "Current Time: %d:%02d:%02d", Hour, Minute, Second);
	    SendClientMessage(playerid, 0x00FFFFAA, string);
		return 1;
	}
	return 0;
}
public OnPlayerSelectedMenuRow(playerid, row){
	new Menu:Current = GetPlayerMenu(playerid);
	if(Current == AlarmMainMenu[playerid])
	{
	    switch(row)
	    {
			case 0:{ShowMenuForPlayer(TurnOnMenu[playerid], playerid); }
			case 1:{MenuType[playerid] = 2;	ChangeMenuHeader(playerid); }
			case 2:{MenuType[playerid] = 3;	ChangeMenuHeader(playerid); }
			case 3:{GameTextForPlayer(playerid, "~y~Typ new alarm-message", 999999, 3); HasToTypeMessage[playerid] = 1;}
			case 4:{TogglePlayerControllable(playerid, 1); }
		}
	}

	if(Current == TurnOnMenu[playerid])	{
	    switch(row)
	    {
			case 0:{IsAlarmTurnedOn[playerid] = 1; MenuType[playerid] = 1; ChangeMenuHeader(playerid); SendClientMessage(playerid, 0x00FF00AA, "AlarmClock is now turned on.");}
			case 1:{IsAlarmTurnedOn[playerid] = 0; MenuType[playerid] = 1; ChangeMenuHeader(playerid); SendClientMessage(playerid, 0xFF0000AA, "AlarmClock is now turned off.");}
			case 2:
			{
                MenuType[playerid] = 4;
				ChangeMenuHeader(playerid);
				ShowMenuForPlayer(AlarmMainMenu[playerid], playerid);
			}
 		}
	}
	if(Current == SetHourMenu[playerid])	{
	    switch(row)
	    {
			case 0:
			{
				AlarmSetHour[playerid]++;
				if(AlarmSetHour[playerid] == 24)
				{
                    AlarmSetHour[playerid] = 0;
				}
				MenuType[playerid] = 2;
				ChangeMenuHeader(playerid);
			}
			case 1:
			{
				AlarmSetHour[playerid]--;
				if(AlarmSetHour[playerid] == -1)
				{
                    AlarmSetHour[playerid] = 23;
				}
				MenuType[playerid] = 2;
				ChangeMenuHeader(playerid);
			}
			case 2:
			{
                MenuType[playerid] = 4;
				ChangeMenuHeader(playerid);
				ShowMenuForPlayer(AlarmMainMenu[playerid], playerid);
			}
 		}
	}
	if(Current == SetMinuteMenu[playerid])	{
	    switch(row)
	    {
	        case 0:
			{
				AlarmSetMinute[playerid]+=10;
				if(AlarmSetMinute[playerid] > 59)
				{
				    AlarmSetMinute[playerid] = 60;
				}
				MenuType[playerid] = 3;
				ChangeMenuHeader(playerid);
			}
			case 1:
			{
				AlarmSetMinute[playerid]+=1;
				if(AlarmSetMinute[playerid] > 59)
				{
				    AlarmSetMinute[playerid] = 0;
				}
				MenuType[playerid] = 3;
				ChangeMenuHeader(playerid);
			}
			case 2:
			{
				AlarmSetMinute[playerid]-=1;
				if(AlarmSetMinute[playerid] < 0)
				{
				    AlarmSetMinute[playerid] = 59;
				}
				MenuType[playerid] = 3;
				ChangeMenuHeader(playerid);
			}
			case 3:
			{
				AlarmSetMinute[playerid]-=10;
				if(AlarmSetMinute[playerid] < 0)
				{
				    AlarmSetMinute[playerid] += 60;
				}
				MenuType[playerid] = 3;
				ChangeMenuHeader(playerid);
			}
			case 4:{
                MenuType[playerid] = 4;
				ChangeMenuHeader(playerid);
				ShowMenuForPlayer(AlarmMainMenu[playerid], playerid);
			}
 		}
	}
	if(Current == RingingMenu[playerid])	{
	    switch(row)
	    {
			case 0:
			{
				TogglePlayerControllable(playerid, 1);
				GameTextForPlayer(playerid, " ", 100, 3);
				KillTimer(AlarmTimer[playerid]);
				SetTimerEx("SnoozeEnd", (DefaultSnoozeTime*1000), 0, "i", playerid);
				AlarmStatus[playerid] = 0;
				IsAlarmGoingOff[playerid] = 0;
				IsSnoozing[playerid] = 1;
			}
			case 1:
			{
				TogglePlayerControllable(playerid, 1);
				GameTextForPlayer(playerid, " ", 100, 3);
				KillTimer(AlarmTimer[playerid]);
				AlarmStatus[playerid] = 0;
				IsAlarmGoingOff[playerid] = 0;
				IsAlarmTurnedOn[playerid] = 0;
			}
 		}
	}
	return 1;
}
public OnPlayerExitedMenu(playerid){
	TogglePlayerControllable(playerid, 1);
	return 1;
}
stock ChangeMenuHeader(playerid){
	new str[128];
    switch(MenuType[playerid])
    {
	    case 1:
	    {
	        if(IsAlarmTurnedOn[playerid] == 1)
        	{
	    		format(str, 128, "Current: On");
			}
			else if(IsAlarmTurnedOn[playerid] == 0)
        	{
	    		format(str, 128, "Current: Off");
			}
			SetMenuColumnHeader(TurnOnMenu[playerid], 0, str);
			ShowMenuForPlayer(TurnOnMenu[playerid], playerid);
		}
		case 2:
		{
		    format(str, 128, "Current: %02d:%02d", AlarmSetHour[playerid], AlarmSetMinute[playerid]);
		    SetMenuColumnHeader(SetHourMenu[playerid], 0, str);
		    ShowMenuForPlayer(SetHourMenu[playerid], playerid);
		}
		case 3:
		{
			format(str, 128, "Current: %02d:%02d", AlarmSetHour[playerid], AlarmSetMinute[playerid]);
			SetMenuColumnHeader(SetMinuteMenu[playerid], 0, str);
			ShowMenuForPlayer(SetMinuteMenu[playerid], playerid);
		}
		case 4:
		{
			format(str, 128, "Current Server Time: %02d:%02d:%02d", Hour, Minute, Second);
			SetMenuColumnHeader(AlarmMainMenu[playerid], 0, str);
			ShowMenuForPlayer(AlarmMainMenu[playerid], playerid);
		}
	}
}
CreateMenusForPlayer(playerid){
    AlarmMainMenu[playerid] = CreateMenu("AlarmClock", 1, 170, 160, 300, 0);
	AddMenuItem(AlarmMainMenu[playerid], 0, "Turn On/Off");
	AddMenuItem(AlarmMainMenu[playerid], 0, "Set Hour");
	AddMenuItem(AlarmMainMenu[playerid], 0, "Set Minute");
	AddMenuItem(AlarmMainMenu[playerid], 0, "Set Message");
	AddMenuItem(AlarmMainMenu[playerid], 0, "Exit");

	TurnOnMenu[playerid] = CreateMenu("Turn Alarm On/Off", 1, 170, 160, 300, 0);
	SetMenuColumnHeader(TurnOnMenu[playerid], 0, "Current: Off");
	AddMenuItem(TurnOnMenu[playerid], 0, "Turn On");
	AddMenuItem(TurnOnMenu[playerid], 0, "Turn Off");
	AddMenuItem(TurnOnMenu[playerid], 0, "Back");

	SetHourMenu[playerid] = CreateMenu("Hour:", 1, 170, 160, 300, 0);
	SetMenuColumnHeader(SetHourMenu[playerid], 0, "Current: 00:00");
	AddMenuItem(SetHourMenu[playerid], 0, "+1");
	AddMenuItem(SetHourMenu[playerid], 0, "-1");
	AddMenuItem(SetHourMenu[playerid], 0, "Back");

	SetMinuteMenu[playerid] = CreateMenu("Minute:", 1, 170, 160, 300, 0);
	SetMenuColumnHeader(SetMinuteMenu[playerid], 0, "Current: 00:00");
	AddMenuItem(SetMinuteMenu[playerid], 0, "+10");
	AddMenuItem(SetMinuteMenu[playerid], 0, "+1");
	AddMenuItem(SetMinuteMenu[playerid], 0, "-1");
	AddMenuItem(SetMinuteMenu[playerid], 0, "-10");
	AddMenuItem(SetMinuteMenu[playerid], 0, "Back");

	RingingMenu[playerid] = CreateMenu(" ", 1, 220, 160, 200, 0);
	AddMenuItem(RingingMenu[playerid], 0, "Snooze");
	AddMenuItem(RingingMenu[playerid], 0, "Turn Off");
}
DestroyMenusForPlayer(playerid){
    DestroyMenu(AlarmMainMenu[playerid]);
	DestroyMenu(TurnOnMenu[playerid]);
	DestroyMenu(SetHourMenu[playerid]);
	DestroyMenu(SetMinuteMenu[playerid]);
	DestroyMenu(RingingMenu[playerid]);
}
forward UpdateTime();
public UpdateTime(){
    gettime(Hour, Minute, Second);
    for(new i; i<MP; i++)
    {
		if(IsPlayerConnected(i))
		{
        	if(IsAlarmTurnedOn[i] == 1)
        	{
				if(AlarmSetHour[i] == Hour && AlarmSetMinute[i] == Minute)
				{
				    if(IsAlarmGoingOff[i] == 0 && IsSnoozing[i] == 0)
				    {
					    TogglePlayerControllable(i, 0);
					    IsAlarmGoingOff[i] = 1;
					    AlarmStatus[i] = 1;
					    ShowMenuForPlayer(RingingMenu[i], i);
	  				 	AlarmTimer[i] = SetTimerEx("AlarmPlayer", 800, 1, "i", i);
					}
				}
			}
		}
	}
}
forward SnoozeEnd(playerid);
public SnoozeEnd(playerid){
    IsSnoozing[playerid] = 0;
    TogglePlayerControllable(playerid, 0);
    IsAlarmGoingOff[playerid] = 1;
	AlarmStatus[playerid] = 1;
	ShowMenuForPlayer(RingingMenu[playerid], playerid);
  	AlarmTimer[playerid] = SetTimerEx("AlarmPlayer", 800, 1, "i", playerid);
}
forward AlarmPlayer(playerid);
public AlarmPlayer(playerid){
    PlayerPlaySound(playerid, 1052, 0, 0, 0);
    if(AlarmStatus[playerid] == 1)
    {
  		new str[128];
		format(str, 128, "~n~~n~~n~~n~~n~~n~~r~%s ~n~~n~~r~Alarm", AlarmMessage[playerid]);
		GameTextForPlayer(playerid, str, 999999, 3);
		AlarmStatus[playerid] = 2;
	}
	else if(AlarmStatus[playerid] == 2)
    {
		new str[128];
		format(str, 128, "~n~~n~~n~~n~~n~~n~~w~%s ~n~~n~~w~Alarm", AlarmMessage[playerid]);
		GameTextForPlayer(playerid, str, 999999, 3);
		AlarmStatus[playerid] = 1;
	}
}