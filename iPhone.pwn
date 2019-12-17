/******************************/
/* iMaxPhone FS © by iPLEOMAX */
/* Basic Version              */
/******************************/

#include <a_samp>
#include <zcmd>

#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BRIGHTRED 0xFF0000AA
#define COLOR_LIGHTGREEN 0x24FF0AB9
#define COLOR_LIGHTBLUE 0x33CCFFAA

new CallingAnimTimer;
new CANIMval;

/* For Next Version.
new Counter[MAX_PLAYERS];
new Text:CounterT[MAX_PLAYERS];
*/

new Text:Textdraw0;
new Text:Textdraw1;
new Text:Textdraw2;
new Text:Textdraw3;
new Text:Textdraw4;
new Text:Textdraw5;
new Text:Textdraw6;
new Text:Textdraw7;
new Text:Textdraw8;
new Text:Textdraw9;
new Text:Textdraw10;
new Text:Textdraw12;
//new Text:Textdraw13;
new Text:Textdraw14;
new Text:Textdraw15;

new Text:Textdraw11[MAX_PLAYERS];

new PhoneState[MAX_PLAYERS]; // -1 = Switched Off, 0 = Not Shown, 1 = Shown
new CallState[MAX_PLAYERS]; // 0 = Free, 1 = Calling..., 2 = Busy, 3 = ScreenBusy, 4 = Incoming..., 5 = on going call.

#define FILTERSCRIPT

public OnFilterScriptInit()
{
    CANIMval = 0;

    CallingAnimTimer = SetTimer("CANIM", 700, true);

	print("\n--------------------------------------");
	print(" > iMaxPhone FilterScript by iPLEOMAX <");
	print("--------------------------------------\n");

	Textdraw0 = TextDrawCreate(501.000000,425.000000,"X"); //ForAll
	Textdraw1 = TextDrawCreate(494.000000,260.000000,"X"); //ForAll
	Textdraw2 = TextDrawCreate(435.000000,400.000000,"O"); //ForAll
	Textdraw3 = TextDrawCreate(437.000000,404.000000,"]"); //ForAll
	Textdraw4 = TextDrawCreate(457.000000,402.000000,"]"); //ForAll
	Textdraw5 = TextDrawCreate(393.000000,402.000000,"["); //ForAll
	Textdraw6 = TextDrawCreate(434.000000,242.000000,"-"); //ForAll
	Textdraw7 = TextDrawCreate(482.000000,241.000000,"O"); //ForAll

	Textdraw8 = TextDrawCreate(394.000000,383.000000,"Answer");
	Textdraw9 = TextDrawCreate(453.000000,383.000000,"Hangup");

	Textdraw10 = TextDrawCreate(395.000000,290.000000,"Incoming call...");
	Textdraw12 = TextDrawCreate(395.000000,290.000000,"___Calling...");
	//Textdraw13 = TextDrawCreate(395.000000,290.000000,"___/call [name]");
	Textdraw14 = TextDrawCreate(395.000000,290.000000,"__Number Busy.");
	Textdraw15 = TextDrawCreate(395.000000,290.000000,"___Active Call.");

	TextDrawUseBox(Textdraw0,1);
	TextDrawBoxColor(Textdraw0,0x000000cc);
	TextDrawTextSize(Textdraw0,383.000000,3.000000);
	TextDrawUseBox(Textdraw1,1);
	TextDrawBoxColor(Textdraw1,0xffffffff);
	TextDrawTextSize(Textdraw1,390.000000,16.000000);

	TextDrawAlignment(Textdraw0,0);
	TextDrawAlignment(Textdraw1,0);
	TextDrawAlignment(Textdraw2,0);
	TextDrawAlignment(Textdraw3,0);
	TextDrawAlignment(Textdraw4,0);
	TextDrawAlignment(Textdraw5,0);
	TextDrawAlignment(Textdraw6,0);
	TextDrawAlignment(Textdraw7,0);
	TextDrawAlignment(Textdraw8,0);
	TextDrawAlignment(Textdraw9,0);
	TextDrawAlignment(Textdraw10,0);
	TextDrawAlignment(Textdraw12,0);
	//TextDrawAlignment(Textdraw13,0);
	TextDrawAlignment(Textdraw14,0);
	TextDrawAlignment(Textdraw15,0);

	TextDrawBackgroundColor(Textdraw0,0x000000ff);
	TextDrawBackgroundColor(Textdraw1,0xffffff99);
	TextDrawBackgroundColor(Textdraw2,0x000000ff);
	TextDrawBackgroundColor(Textdraw3,0x000000ff);
	TextDrawBackgroundColor(Textdraw4,0x000000ff);
	TextDrawBackgroundColor(Textdraw5,0x000000ff);
	TextDrawBackgroundColor(Textdraw6,0x000000ff);
	TextDrawBackgroundColor(Textdraw7,0x000000ff);
	TextDrawBackgroundColor(Textdraw8,0x000000ff);
	TextDrawBackgroundColor(Textdraw9,0x000000ff);
	TextDrawBackgroundColor(Textdraw10,0x000000ff);
	TextDrawBackgroundColor(Textdraw12,0x000000ff);
	//TextDrawBackgroundColor(Textdraw13,0x000000ff);
	TextDrawBackgroundColor(Textdraw14,0x000000ff);
	TextDrawBackgroundColor(Textdraw15,0x000000ff);

	TextDrawFont(Textdraw0,3);
	TextDrawLetterSize(Textdraw0,-0.000000,-21.400001);
	TextDrawFont(Textdraw1,3);
	TextDrawLetterSize(Textdraw1,-0.000000,14.699998);
	TextDrawFont(Textdraw2,3);
	TextDrawLetterSize(Textdraw2,0.799999,1.900000);
	TextDrawFont(Textdraw3,3);
	TextDrawLetterSize(Textdraw3,1.000000,1.000000);
	TextDrawFont(Textdraw4,3);
	TextDrawLetterSize(Textdraw4,2.399999,0.999997);
	TextDrawFont(Textdraw5,3);
	TextDrawLetterSize(Textdraw5,2.299999,1.000000);
	TextDrawFont(Textdraw6,3);
	TextDrawLetterSize(Textdraw6,1.000000,1.000000);
	TextDrawFont(Textdraw7,3);
	TextDrawLetterSize(Textdraw7,0.499999,1.100000);
	TextDrawFont(Textdraw8,1);
	TextDrawLetterSize(Textdraw8,0.299999,1.100000);
	TextDrawFont(Textdraw9,1);
	TextDrawLetterSize(Textdraw9,0.299999,1.100000);
	TextDrawFont(Textdraw10,1);
	TextDrawLetterSize(Textdraw10,0.299999,1.300000);
	TextDrawFont(Textdraw12,1);
	TextDrawLetterSize(Textdraw12,0.299999,1.300000);
	//TextDrawFont(Textdraw13,1);
	//TextDrawLetterSize(Textdraw13,0.299999,1.300000);
	TextDrawFont(Textdraw14,1);
	TextDrawLetterSize(Textdraw14,0.299999,1.300000);
    TextDrawFont(Textdraw15,1);
	TextDrawLetterSize(Textdraw15,0.299999,1.300000);

	TextDrawColor(Textdraw0,0xffffffff);
	TextDrawColor(Textdraw1,0xffffffff);
	TextDrawColor(Textdraw2,0xffffffff);
	TextDrawColor(Textdraw3,0x00000066);
	TextDrawColor(Textdraw4,0xff0000cc);
	TextDrawColor(Textdraw5,0x00ff00cc);
	TextDrawColor(Textdraw6,0xffffff33);
	TextDrawColor(Textdraw7,0xffffff66);
	TextDrawColor(Textdraw8,0xffffffff);
	TextDrawColor(Textdraw9,0xffffffff);
	TextDrawColor(Textdraw10,0x00ff00cc);
	TextDrawColor(Textdraw12,0x00ff00cc);
	//TextDrawColor(Textdraw13,0x00ff00cc);
	TextDrawColor(Textdraw14,0xff0000ff);
	TextDrawColor(Textdraw15,0x00ff00cc);

	TextDrawSetOutline(Textdraw0,1);
	TextDrawSetOutline(Textdraw1,1);
	TextDrawSetOutline(Textdraw2,1);
	TextDrawSetOutline(Textdraw3,1);
	TextDrawSetOutline(Textdraw4,1);
	TextDrawSetOutline(Textdraw5,1);
	TextDrawSetOutline(Textdraw6,1);
	TextDrawSetOutline(Textdraw7,1);
	TextDrawSetOutline(Textdraw8,1);
	TextDrawSetOutline(Textdraw9,1);
	TextDrawSetOutline(Textdraw10,1);
	TextDrawSetOutline(Textdraw12,1);
	//TextDrawSetOutline(Textdraw13,1);
	TextDrawSetOutline(Textdraw14,1);
	TextDrawSetOutline(Textdraw15,1);

	TextDrawSetProportional(Textdraw1,1);
	TextDrawSetProportional(Textdraw2,1);
	TextDrawSetProportional(Textdraw3,1);
	TextDrawSetProportional(Textdraw4,1);
	TextDrawSetProportional(Textdraw5,1);
	TextDrawSetProportional(Textdraw6,1);
	TextDrawSetProportional(Textdraw7,1);
	TextDrawSetProportional(Textdraw8,1);
	TextDrawSetProportional(Textdraw9,1);
	TextDrawSetProportional(Textdraw10,1);
	TextDrawSetProportional(Textdraw12,1);
	//TextDrawSetProportional(Textdraw13,1);
	TextDrawSetProportional(Textdraw14,1);
	TextDrawSetProportional(Textdraw15,1);

	TextDrawSetShadow(Textdraw0,1);
	TextDrawSetShadow(Textdraw1,1);
	TextDrawSetShadow(Textdraw2,1);
	TextDrawSetShadow(Textdraw3,1);
	TextDrawSetShadow(Textdraw4,1);
	TextDrawSetShadow(Textdraw5,1);
	TextDrawSetShadow(Textdraw6,1);
	TextDrawSetShadow(Textdraw7,1);
	TextDrawSetShadow(Textdraw8,1);
	TextDrawSetShadow(Textdraw9,1);
	TextDrawSetShadow(Textdraw10,1);
	TextDrawSetShadow(Textdraw12,1);
	//TextDrawSetShadow(Textdraw13,1);
	TextDrawSetShadow(Textdraw14,1);
	TextDrawSetShadow(Textdraw15,1);

	return true;
}

public OnFilterScriptExit()
{
	KillTimer(CallingAnimTimer);
	return true;
}

forward CANIM();
public CANIM()
{
	if(CANIMval == 0) {
		TextDrawSetString(Textdraw12, "___Calling"); CANIMval = CANIMval+1;
		TextDrawColor(Textdraw10,0xccffddff);
	} else if(CANIMval == 1) {
		TextDrawSetString(Textdraw12, "___Calling."); CANIMval = CANIMval+1;
		TextDrawColor(Textdraw10,0x00ff00cc);
	} else if(CANIMval == 2) {
		TextDrawSetString(Textdraw12, "___Calling.."); CANIMval = CANIMval+1;
		TextDrawColor(Textdraw10,0xccffddff);
	} else if(CANIMval == 3) {
		TextDrawSetString(Textdraw12, "___Calling..."); CANIMval = 0;
		TextDrawColor(Textdraw10,0x00ff00cc);
	}
	return true;
}

public OnPlayerConnect(playerid)
{
	/* For Next Version.
	CounterT[playerid] = TextDrawCreate(419.000000,264.000000,"00:00");
	TextDrawAlignment(CounterT[playerid],0);
	TextDrawBackgroundColor(CounterT[playerid],0x000000ff);
	TextDrawFont(CounterT[playerid],1);
	TextDrawLetterSize(CounterT[playerid],0.399999,1.300000);
	TextDrawColor(CounterT[playerid],0xffffffff);
	TextDrawSetOutline(CounterT[playerid],1);
	TextDrawSetProportional(CounterT[playerid],1);
	TextDrawSetShadow(CounterT[playerid],1);
	*/
    Textdraw11[playerid] = TextDrawCreate(395.000000,333.000000,GetName(playerid));// MAIN
    TextDrawSetShadow(Textdraw11[playerid],1);
    TextDrawSetProportional(Textdraw11[playerid],1);
    TextDrawSetOutline(Textdraw11[playerid],1);
    TextDrawColor(Textdraw11[playerid],0xffffffff);
    TextDrawFont(Textdraw11[playerid],1);
	TextDrawLetterSize(Textdraw11[playerid],0.199999,0.899999);
	TextDrawBackgroundColor(Textdraw11[playerid],0x000000ff);
	TextDrawAlignment(Textdraw11[playerid],0);

	TextDrawHideForPlayer(playerid, Textdraw11[GetPVarInt(playerid, "Caller")]);
    TextDrawHideForPlayer(GetPVarInt(playerid, "Caller"), Textdraw11[playerid]);

	SetPVarInt(playerid, "Caller", -1);

	return true;
}

public OnPlayerDisconnect(playerid, reason)
{
    if(CallState[playerid] >= 4)
    {
        SetPVarInt(playerid, "Answered", 0);
        SetPVarInt(GetPVarInt(playerid, "Caller"), "Caller", -1);
        if(CallState[playerid] == 4) SendClientMessage(GetPVarInt(playerid, "Caller"), COLOR_BRIGHTRED, "[PHONE] Sorry, the person you are trying to call is busy, Try again later.");
		TextDrawHideForPlayer(GetPVarInt(playerid, "Caller"), Textdraw12);
		TextDrawShowForPlayer(GetPVarInt(playerid, "Caller"), Textdraw14);
		SetTimerEx("ScreenReset",2000,false,"d",GetPVarInt(playerid, "Caller"));
		if(CallState[playerid] == 5) {
			SendClientMessage(GetPVarInt(playerid, "Caller"), COLOR_BRIGHTRED, "[PHONE] Call ended.");
		}
		CallState[playerid] = 0;
        CallState[GetPVarInt(playerid, "Caller")] = 0;
    }

    TextDrawHideForPlayer(playerid, Textdraw11[GetPVarInt(playerid, "Caller")]);
    TextDrawHideForPlayer(GetPVarInt(playerid, "Caller"), Textdraw11[playerid]);
    SetPVarInt(playerid, "Caller", -1);
	return true;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    if(CallState[playerid] >= 4)
    {
        TextDrawHideForPlayer(playerid, Textdraw11[GetPVarInt(playerid, "Caller")]);
    	TextDrawHideForPlayer(GetPVarInt(playerid, "Caller"), Textdraw11[playerid]);
        SetPVarInt(playerid, "Answered", 0);
        SetPVarInt(GetPVarInt(playerid, "Caller"), "Caller", -1);
        if(CallState[playerid] == 4) SendClientMessage(GetPVarInt(playerid, "Caller"), COLOR_BRIGHTRED, "[PHONE] Sorry, the person you are trying to call is busy, Try again later.");
		TextDrawHideForPlayer(GetPVarInt(playerid, "Caller"), Textdraw12);
		TextDrawShowForPlayer(GetPVarInt(playerid, "Caller"), Textdraw14);
		SetTimerEx("ScreenReset",2000,false,"d",GetPVarInt(playerid, "Caller"));
		SetTimerEx("ScreenReset",1000,false,"d",playerid);
		if(CallState[playerid] == 5) {
			SendClientMessage(GetPVarInt(playerid, "Caller"), COLOR_BRIGHTRED, "[PHONE] Call ended.");
			SendClientMessage(playerid, COLOR_BRIGHTRED, "[PHONE] Call ended.");
		} else SendClientMessage(playerid, COLOR_BRIGHTRED, "[PHONE] Call auto rejected because of death.");
		CallState[playerid] = 0;
        CallState[GetPVarInt(playerid, "Caller")] = 0;
    }
    SetPVarInt(playerid, "Caller", -1);
	return true;
}

CMD:cellphone(playerid, params[])
{
	if(PhoneState[playerid] != 1)
	{
	    PhoneState[playerid] = 1;
	    TextDrawShowForPlayer(playerid, Textdraw0);
	    TextDrawShowForPlayer(playerid, Textdraw1);
	    TextDrawShowForPlayer(playerid, Textdraw2);
		TextDrawShowForPlayer(playerid, Textdraw3);
		TextDrawShowForPlayer(playerid, Textdraw4);
		TextDrawShowForPlayer(playerid, Textdraw5);
		TextDrawShowForPlayer(playerid, Textdraw6);
	    TextDrawShowForPlayer(playerid, Textdraw7);
	    //TextDrawShowForPlayer(playerid, Textdraw13);
	    SendClientMessage(playerid, COLOR_LIGHTGREEN, "Here is your Cell Phone.");
	    SendClientMessage(playerid, COLOR_LIGHTGREEN, "You can use /call [player name] to call a person.");
	} else {
	    PhoneState[playerid] = 0;
	    TextDrawHideForPlayer(playerid, Textdraw0);
	    TextDrawHideForPlayer(playerid, Textdraw1);
	    TextDrawHideForPlayer(playerid, Textdraw2);
		TextDrawHideForPlayer(playerid, Textdraw3);
		TextDrawHideForPlayer(playerid, Textdraw4);
		TextDrawHideForPlayer(playerid, Textdraw5);
		TextDrawHideForPlayer(playerid, Textdraw6);
	    TextDrawHideForPlayer(playerid, Textdraw7);
	    TextDrawHideForPlayer(playerid, Textdraw8);
	    TextDrawHideForPlayer(playerid, Textdraw9);
	    TextDrawHideForPlayer(playerid, Textdraw10);
	    TextDrawHideForPlayer(playerid, Textdraw11[GetPVarInt(playerid, "Caller")]);
	    TextDrawHideForPlayer(playerid, Textdraw12);
	    //TextDrawHideForPlayer(playerid, Textdraw13);
	    return true;
	}
	return true;
}

CMD:call(playerid, params[])
{
	if(CallState[playerid] == 3) return SendClientMessage(playerid, COLOR_BRIGHTRED, "[PHONE] Please wait for your Home screen to reset.");
	if(PhoneState[playerid] != 1) return SendClientMessage(playerid, COLOR_BRIGHTRED, "[PHONE] Please take out your /cellphone first.");
	if(CallState[playerid] == 0)
	{
		new id;
		id = GetIdFromName(params);
		//TextDrawHideForPlayer(playerid, Textdraw13);
		TextDrawShowForPlayer(playerid, Textdraw12);
		CallState[playerid] = 3;
		SetTimerEx("iCallPlayer",5000,false,"dd",playerid,id);
	}
	return true;
}

forward iCallPlayer(playerid, targetplayer);
public iCallPlayer(playerid, targetplayer)
{
	if(!IsPlayerConnected(targetplayer) && !IsPlayerNPC(targetplayer)) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "[PHONE] Sorry, the number you have dialled is invalid.");
		TextDrawHideForPlayer(playerid, Textdraw12);
		TextDrawShowForPlayer(playerid, Textdraw14);
		SetTimerEx("ScreenReset",2000,false,"d",playerid);
	} else if(playerid == targetplayer || CallState[targetplayer] != 0) {
		SendClientMessage(playerid, COLOR_BRIGHTRED, "[PHONE] Sorry, the person you are trying to call is busy, Try again later.");
		TextDrawHideForPlayer(playerid, Textdraw12);
		TextDrawShowForPlayer(playerid, Textdraw14);
		SetTimerEx("ScreenReset",2000,false,"d",playerid);
	} else if(CallState[targetplayer] == 0) {
	    iRecieveCall(targetplayer, playerid);
	    TextDrawShowForPlayer(playerid, Textdraw11[targetplayer]);
	    SetPVarInt(targetplayer, "Caller", playerid);
	    SetPVarInt(playerid, "Caller", targetplayer);
	    SetPVarInt(playerid, "Answered", 0);
	    SetPVarInt(targetplayer, "Answered", 0);
	    CallState[targetplayer] = 4;
	    SendClientMessage(targetplayer, COLOR_LIGHTGREEN, "You have a call, use /answer to answer it or /hangup to reject.");
	}
	return true;
}

forward iRecieveCall(playerid, fromplayer);
public iRecieveCall(playerid, fromplayer)
{
	CallState[playerid] = 2;
	PhoneState[playerid] = 1;
    //TextDrawHideForPlayer(playerid, Textdraw13);
 	TextDrawShowForPlayer(playerid, Textdraw0);
    TextDrawShowForPlayer(playerid, Textdraw1);
    TextDrawShowForPlayer(playerid, Textdraw2);
	TextDrawShowForPlayer(playerid, Textdraw3);
	TextDrawShowForPlayer(playerid, Textdraw4);
	TextDrawShowForPlayer(playerid, Textdraw5);
	TextDrawShowForPlayer(playerid, Textdraw6);
	TextDrawShowForPlayer(playerid, Textdraw7);
 	TextDrawShowForPlayer(playerid, Textdraw10);
 	TextDrawShowForPlayer(playerid, Textdraw11[fromplayer]);
 	TextDrawShowForPlayer(playerid, Textdraw8);
 	TextDrawShowForPlayer(playerid, Textdraw9);
	return true;
}

CMD:answer(playerid, params[])
{
    if(CallState[playerid] == 5) return SendClientMessage(playerid, COLOR_BRIGHTRED, "[PHONE] You already have a call going on.");
	if(CallState[playerid] == 4)
	{
	    TextDrawShowForPlayer(playerid, Textdraw15);
	    TextDrawShowForPlayer(GetPVarInt(playerid, "Caller"), Textdraw15);
	    TextDrawHideForPlayer(playerid, Textdraw10);
	    TextDrawHideForPlayer(GetPVarInt(playerid, "Caller"), Textdraw12);
	    CallState[playerid] = 5;
	    CallState[GetPVarInt(playerid, "Caller")] = 5;
	    TextDrawHideForPlayer(playerid, Textdraw12);
	    //TextDrawHideForPlayer(playerid, Textdraw13);
	    //TextDrawHideForPlayer(GetPVarInt(playerid, "Caller"), Textdraw13);
	    SetPVarInt(playerid, "Answered", 1);
	    SetPVarInt(GetPVarInt(playerid, "Caller"),"Answered", 1);
	    SendClientMessage(GetPVarInt(playerid, "Caller"), COLOR_LIGHTGREEN, "[PHONE] Call Accepted.");
	    SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PHONE] You answered, now you can talk to each other in main chat privately.");
	} else SendClientMessage(playerid, COLOR_BRIGHTRED, "[PHONE] You don't have any call to answer.");
	return true;
}

CMD:hangup(playerid, params[])
{
    if(CallState[playerid] >= 4)
    {
        TextDrawHideForPlayer(playerid, Textdraw11[GetPVarInt(playerid, "Caller")]);
    	TextDrawHideForPlayer(GetPVarInt(playerid, "Caller"), Textdraw11[playerid]);
        SetPVarInt(playerid, "Answered", 0);
        SetPVarInt(GetPVarInt(playerid, "Caller"), "Caller", -1);
        if(CallState[playerid] == 4) SendClientMessage(GetPVarInt(playerid, "Caller"), COLOR_BRIGHTRED, "[PHONE] Sorry, the person you are trying to call is busy, Try again later.");
		TextDrawHideForPlayer(GetPVarInt(playerid, "Caller"), Textdraw12);
		TextDrawHideForPlayer(GetPVarInt(playerid, "Caller"), Textdraw15);
		TextDrawShowForPlayer(GetPVarInt(playerid, "Caller"), Textdraw14);
		SetTimerEx("ScreenReset",2000,false,"d",GetPVarInt(playerid, "Caller"));
		SetTimerEx("ScreenReset",1000,false,"d",playerid);
		if(CallState[playerid] == 5) {
			SendClientMessage(GetPVarInt(playerid, "Caller"), COLOR_BRIGHTRED, "[PHONE] Call ended.");
			SendClientMessage(playerid, COLOR_BRIGHTRED, "[PHONE] Call ended.");
		} else SendClientMessage(playerid, COLOR_BRIGHTRED, "[PHONE] You rejected the call.");
		CallState[playerid] = 0;
        CallState[GetPVarInt(playerid, "Caller")] = 0;
    } else SendClientMessage(playerid, COLOR_BRIGHTRED, "[PHONE] You don't have any active call.");
    SetPVarInt(playerid, "Caller", -1);
	return true;
}

public OnPlayerText(playerid, text[])
{
	if(GetPVarInt(playerid, "Caller") >= 0 && GetPVarInt(playerid, "Answered") == 1)
	{
	    new msg[256];
	    format(msg,sizeof(msg),"{33CCFF}[PHONE TALK][%i]%s:{FFFFFF} %s",playerid,GetName(playerid),text);
	    SendClientMessage(GetPVarInt(playerid, "Caller"),COLOR_WHITE,msg);
	    SendClientMessage(playerid,COLOR_WHITE,msg);
	    return false;
	}
	return true;
}

forward ScreenReset(playerid);
public ScreenReset(playerid)
{
    CallState[playerid] = 0;
    TextDrawHideForPlayer(playerid, Textdraw8);
    TextDrawHideForPlayer(playerid, Textdraw9);
    TextDrawHideForPlayer(playerid, Textdraw10);
    TextDrawHideForPlayer(playerid, Textdraw12);
    //TextDrawShowForPlayer(playerid, Textdraw13);
    TextDrawHideForPlayer(playerid, Textdraw14);
    TextDrawHideForPlayer(playerid, Textdraw15);
	return true;
}

stock GetIdFromName(playername[]) // © by iPLEOMAX
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && !IsPlayerNPC(i))
	    {
	        new pname[MAX_PLAYER_NAME];
	        GetPlayerName(i,pname,MAX_PLAYER_NAME);
	        if(strfind(pname,playername,true) != -1 && strlen(playername) != 0)
			{
				return i;
			}
	    }
	}
	if(strfind(playername, "0",true) != -1 && strlen(playername) <= 1) return 0;
 	if(strval(playername) > 0 && strval(playername) <= MAX_PLAYERS) return strval(playername);
	return -1;
}

stock GetName(playerid)
{
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
	return pname;
}