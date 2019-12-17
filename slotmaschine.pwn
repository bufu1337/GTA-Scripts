/*
	Slot Machine script by NaS (2011).

	For 0.3dRC5-3 (+)

	Change MIN_Bet for the minimum bet

	Change MAX_Bet for the maximum bet

	Change Bet_STEO for the bet steps (if it's 5 the bets can be: 5, 10, 15, 20 etc up to MAX_Bet)


	Do NOT remove this credits.
*/


#include <a_samp>

// cherry   x   25
// grapes   x  100
// 69       x  250
// bells    x  500
// bar 1    x 1000
// bar 2    x 2000

#define WIN_MULTIPLIER_GLOBAL 1.0

#define MIN_Bet 5
#define MAX_Bet 50

#define Bet_STEP 5

#define G_STATE_NOT_GAMBLING    0
#define G_STATE_READY           1
#define G_STATE_GAMBLING        2
#define G_STATE_DISPLAY         3 // Currently displaying the message
#define G_STATE_PLAY_AGAIN      4 // Not used

#define DISPLAY_TIME 750 // Time to display the messages
#define GAMBLE_TIMER 100 // Decrease this if too fast

new Text:VerText;
new Text:ReadyText;
new Text:BetText[MAX_PLAYERS];

new Text:Box;

new Text:Digit1[6];
new Text:Digit2[6];
new Text:Digit3[6];

new Slots[MAX_PLAYERS][3];
new SlotCounter[MAX_PLAYERS];
new Gambling[MAX_PLAYERS];

new SlotTimer[MAX_PLAYERS];

new Bet[MAX_PLAYERS];
new Balance[MAX_PLAYERS];

new bool:rdy=false;

Text:CreateSprite(Float:X,Float:Y,Name[],Float:Width,Float:Height)
{
	new Text:RetSprite;
	RetSprite = TextDrawCreate(X, Y, Name); // Text is txdfile:texture
	TextDrawFont(RetSprite, 4); // Font ID 4 is the sprite draw font
	TextDrawColor(RetSprite,0xFFFFFFFF);
	TextDrawTextSize(RetSprite,Width,Height); // Text size is the Width:Height
	return RetSprite;
}

Text:CreateBox(Float:X,Float:Y,Float:Width,Float:Height,color)
{
	new Text[500];
	for(new i=floatround(Y); i < floatround(Y+Height);i++)
	{
		strcat(Text,"~n~_");
	}
    new Text:RetSprite;
	RetSprite = TextDrawCreate(X, Y, Text); // Text is txdfile:texture
	TextDrawFont(RetSprite, 0); // Font ID 4 is the sprite draw font
	TextDrawColor(RetSprite,0xFFFFFFFF);
	TextDrawTextSize(RetSprite,Width+X,Height+Y); // Text size is the Width:Height
	TextDrawUseBox(RetSprite,1);
	TextDrawBoxColor(RetSprite,color);
	TextDrawLetterSize(RetSprite,0.0001,0.1158);
	return RetSprite;
}

public OnFilterScriptInit()
{
	SetTimer("RDYBLINK",500,1);
	print("Slots init");
	// CreateSprite(Float:X,Float:Y,Name[],Float:Width,Float:Height)

	new Float:Y = 350.0;

	Box = CreateBox(194.0,Y-20,3*64.0 + 3*20,84,0x00000077);

	// Cherries (x25)
	Digit1[0] = CreateSprite(214.0,Y,"LD_SLOT:cherry",64,64);
	Digit2[0] = CreateSprite(288.0,Y,"LD_SLOT:cherry",64,64);
	Digit3[0] = CreateSprite(362.0,Y,"LD_SLOT:cherry",64,64);

	// grapes (x100)
	Digit1[1] = CreateSprite(214.0,Y,"LD_SLOT:grapes",64,64);
	Digit2[1] = CreateSprite(288.0,Y,"LD_SLOT:grapes",64,64);
	Digit3[1] = CreateSprite(362.0,Y,"LD_SLOT:grapes",64,64);

	// 69's (x250)
	Digit1[2] = CreateSprite(214.0,Y,"LD_SLOT:r_69",64,64);
	Digit2[2] = CreateSprite(288.0,Y,"LD_SLOT:r_69",64,64);
	Digit3[2] = CreateSprite(362.0,Y,"LD_SLOT:r_69",64,64);

	// bells (x500)
	Digit1[3] = CreateSprite(214.0,Y,"LD_SLOT:bell",64,64);
	Digit2[3] = CreateSprite(288.0,Y,"LD_SLOT:bell",64,64);
	Digit3[3] = CreateSprite(362.0,Y,"LD_SLOT:bell",64,64);

	// Bars [1 bar] (x1000)
	Digit1[4] = CreateSprite(214.0,Y,"LD_SLOT:bar1_o",64,64);
	Digit2[4] = CreateSprite(288.0,Y,"LD_SLOT:bar1_o",64,64);
	Digit3[4] = CreateSprite(362.0,Y,"LD_SLOT:bar1_o",64,64);

	// Bars [2 bar] (x2000)
	Digit1[5] = CreateSprite(214.0,Y,"LD_SLOT:bar2_o",64,64);
	Digit2[5] = CreateSprite(288.0,Y,"LD_SLOT:bar2_o",64,64);
	Digit3[5] = CreateSprite(362.0,Y,"LD_SLOT:bar2_o",64,64);


	ReadyText=TextDrawCreate(320.0,Y+1.4,"~w~Ready to play.~n~~b~ ~k~~PED_SPRINT~ ~w~- ~g~gamble~n~~b~~k~~VEHICLE_ENTER_EXIT~ ~w~- ~r~exit~n~~b~~k~~PED_JUMPING~ ~w~- ~y~increase Bet");
	TextDrawUseBox(ReadyText,1);
	TextDrawFont(ReadyText,2);
	TextDrawSetShadow(ReadyText,0);
	TextDrawSetOutline(ReadyText,1);
	TextDrawLetterSize(ReadyText,0.3,1.23);
	TextDrawAlignment(ReadyText,2);
	TextDrawBoxColor(ReadyText,0x00000077);
	TextDrawTextSize(ReadyText,350,210);

	VerText=TextDrawCreate(194.0,Y-21,"~g~$$$ ~p~$lotmachine v0.5 - by NaS ~g~$$$");
	TextDrawFont(VerText,1);
	TextDrawSetShadow(VerText,0);
	TextDrawSetOutline(VerText,1);
	TextDrawLetterSize(VerText,0.16,0.65);

	for(new i; i < MAX_PLAYERS; i++)
	{
		BetText[i]=TextDrawCreate(195.0,Y+58,"~y~Bet: 5$");
		TextDrawFont(BetText[i],2);
		TextDrawLetterSize(BetText[i],0.35,0.8);
		TextDrawSetShadow(BetText[i],0);
		TextDrawSetOutline(BetText[i],1);
	}

	for(new i; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) OnPlayerConnect(i); // This will make the slotmachine usable for already connected players!
	return 1;
}

public OnFilterScriptExit()
{
	TextDrawDestroy(Digit1[0]);
	TextDrawDestroy(Digit2[0]);
	TextDrawDestroy(Digit3[0]);

	TextDrawDestroy(Digit1[1]);
	TextDrawDestroy(Digit2[1]);
	TextDrawDestroy(Digit3[1]);

	TextDrawDestroy(Digit1[2]);
	TextDrawDestroy(Digit2[2]);
	TextDrawDestroy(Digit3[2]);

	TextDrawDestroy(Digit1[3]);
	TextDrawDestroy(Digit2[3]);
	TextDrawDestroy(Digit3[3]);

	TextDrawDestroy(Digit1[4]);
	TextDrawDestroy(Digit2[4]);
	TextDrawDestroy(Digit3[4]);

	TextDrawDestroy(Digit1[5]);
	TextDrawDestroy(Digit2[5]);
	TextDrawDestroy(Digit3[5]);


	TextDrawDestroy(Box);
	TextDrawDestroy(ReadyText);
	TextDrawDestroy(VerText);

	for(new i; i < MAX_PLAYERS; i++)
	{
		TextDrawDestroy(BetText[i]);
	}
	return 1;
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
	Gambling[playerid] = G_STATE_NOT_GAMBLING;
	SlotTimer[playerid] = -1;
	//GivePlayerMoney(playerid,100000);


	//SendClientMessage(playerid,-1,"Welcome!");
	//printf("Connect: %d",playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    ExitPlayerFromSlotMachine(playerid);

    TextDrawHideForPlayer(playerid,Digit1[0]);
	TextDrawHideForPlayer(playerid,Digit2[0]);
	TextDrawHideForPlayer(playerid,Digit3[0]);

	TextDrawHideForPlayer(playerid,Digit1[1]);
	TextDrawHideForPlayer(playerid,Digit2[1]);
	TextDrawHideForPlayer(playerid,Digit3[1]);

	TextDrawHideForPlayer(playerid,Digit1[2]);
	TextDrawHideForPlayer(playerid,Digit2[2]);
	TextDrawHideForPlayer(playerid,Digit3[2]);

	TextDrawHideForPlayer(playerid,Digit1[3]);
	TextDrawHideForPlayer(playerid,Digit2[3]);
	TextDrawHideForPlayer(playerid,Digit3[3]);

	TextDrawHideForPlayer(playerid,Digit1[4]);
	TextDrawHideForPlayer(playerid,Digit2[4]);
	TextDrawHideForPlayer(playerid,Digit3[4]);

	TextDrawHideForPlayer(playerid,Digit1[5]);
	TextDrawHideForPlayer(playerid,Digit2[5]);
	TextDrawHideForPlayer(playerid,Digit3[5]);

	TextDrawHideForPlayer(playerid,Box);
	TextDrawHideForPlayer(playerid,ReadyText);

	if(SlotTimer[playerid] != -1) KillTimer(SlotTimer[playerid]);
	return 1;
}

ShowPlayerSlots(playerid,slot1,slot2,slot3)
{
    TextDrawHideForPlayer(playerid,Digit1[0]);
	TextDrawHideForPlayer(playerid,Digit2[0]);
	TextDrawHideForPlayer(playerid,Digit3[0]);

	TextDrawHideForPlayer(playerid,Digit1[1]);
	TextDrawHideForPlayer(playerid,Digit2[1]);
	TextDrawHideForPlayer(playerid,Digit3[1]);

	TextDrawHideForPlayer(playerid,Digit1[2]);
	TextDrawHideForPlayer(playerid,Digit2[2]);
	TextDrawHideForPlayer(playerid,Digit3[2]);

	TextDrawHideForPlayer(playerid,Digit1[3]);
	TextDrawHideForPlayer(playerid,Digit2[3]);
	TextDrawHideForPlayer(playerid,Digit3[3]);

	TextDrawHideForPlayer(playerid,Digit1[4]);
	TextDrawHideForPlayer(playerid,Digit2[4]);
	TextDrawHideForPlayer(playerid,Digit3[4]);

	TextDrawHideForPlayer(playerid,Digit1[5]);
	TextDrawHideForPlayer(playerid,Digit2[5]);
	TextDrawHideForPlayer(playerid,Digit3[5]);


	TextDrawShowForPlayer(playerid,Digit1[slot1]);
	TextDrawShowForPlayer(playerid,Digit2[slot2]);
	TextDrawShowForPlayer(playerid,Digit3[slot3]);

	TextDrawShowForPlayer(playerid,Box);
}

HideSlotsForPlayer(playerid)
{
    TextDrawHideForPlayer(playerid,Digit1[0]);
	TextDrawHideForPlayer(playerid,Digit2[0]);
	TextDrawHideForPlayer(playerid,Digit3[0]);

	TextDrawHideForPlayer(playerid,Digit1[1]);
	TextDrawHideForPlayer(playerid,Digit2[1]);
	TextDrawHideForPlayer(playerid,Digit3[1]);

	TextDrawHideForPlayer(playerid,Digit1[2]);
	TextDrawHideForPlayer(playerid,Digit2[2]);
	TextDrawHideForPlayer(playerid,Digit3[2]);

	TextDrawHideForPlayer(playerid,Digit1[3]);
	TextDrawHideForPlayer(playerid,Digit2[3]);
	TextDrawHideForPlayer(playerid,Digit3[3]);

	TextDrawHideForPlayer(playerid,Digit1[4]);
	TextDrawHideForPlayer(playerid,Digit2[4]);
	TextDrawHideForPlayer(playerid,Digit3[4]);

	TextDrawHideForPlayer(playerid,Digit1[5]);
	TextDrawHideForPlayer(playerid,Digit2[5]);
	TextDrawHideForPlayer(playerid,Digit3[5]);

	TextDrawHideForPlayer(playerid,Box);
}

PutPlayerInSlotMachine(playerid, firstBet=MIN_Bet,  startBalance=0)
{
	if(Gambling[playerid] != G_STATE_NOT_GAMBLING) return print("Already gambling");

	Gambling[playerid] = G_STATE_READY;
	TextDrawShowForPlayer(playerid,ReadyText);
	TextDrawShowForPlayer(playerid,BetText[playerid]);
	TextDrawShowForPlayer(playerid,VerText);

	Slots[playerid][0] = random(5);
	Slots[playerid][1] = random(5);
	Slots[playerid][2] = random(5);

	ShowPlayerSlots(playerid,Slots[playerid][0],Slots[playerid][1],Slots[playerid][2]);

	Bet[playerid] = firstBet;

	GivePlayerMoney(playerid,-startBalance);

	Balance[playerid] = startBalance;

	UpdateBetText(playerid);

	TogglePlayerControllable(playerid,0);
	return 1;
}

ExitPlayerFromSlotMachine(playerid)
{
	if(Gambling[playerid] == G_STATE_NOT_GAMBLING) return 0;
	HideSlotsForPlayer(playerid);
	Gambling[playerid] = G_STATE_NOT_GAMBLING;

	TogglePlayerControllable(playerid,1);

	TextDrawHideForPlayer(playerid,ReadyText);
	TextDrawHideForPlayer(playerid,BetText[playerid]);
	TextDrawHideForPlayer(playerid,VerText);

	new str[128];
    if(Balance[playerid] > 0) format(str,sizeof(str),"~g~Your balance: %d$",Balance[playerid]);
    else format(str,sizeof(str),"~r~You lost your money. Stop playing.",Balance[playerid]);
    GameTextForPlayer(playerid,str,5000,4);

    GivePlayerMoney(playerid,Balance[playerid]);
    return 1;
}

/*PlayAgain(playerid)
{
	Gambling[playerid] = G_STATE_READY;

	Slots[playerid][0] = random(5);
	Slots[playerid][1] = random(5);
	Slots[playerid][2] = random(5);

	ShowPlayerSlots(playerid,Slots[playerid][0],Slots[playerid][1],Slots[playerid][2]);
}*/

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_SPRINT)
	{
	    // Randomize if in Slotmachine
	    if(Gambling[playerid] == G_STATE_READY)
	    {
	        new money = GetPlayerMoney(playerid);
	        if(Bet[playerid] > money+Balance[playerid])
	        {
	            GameTextForPlayer(playerid,"~r~You don't have enough money!",5000,4);
	            return 1;
	        }

	        if(Balance[playerid] - Bet[playerid] < 0)
	        {
	            GameTextForPlayer(playerid,"~r~Your balance is too low!",5000,4);
	            return 1;
	        }

	        SlotCounter[playerid] = 30+random(18);
            SlotTimer[playerid] = SetTimerEx("Gambler",GAMBLE_TIMER,1,"d",playerid);
            Gambling[playerid] = G_STATE_GAMBLING;

         	Balance[playerid]-=Bet[playerid];

         	new prefix[4];
	        if(Balance[playerid] == 0) strcat(prefix,"~y~");
	        if(Balance[playerid]  > 0) strcat(prefix,"~g~");
	        if(Balance[playerid]  < 0) strcat(prefix,"~r~");

			UpdateBetText(playerid);

         	TextDrawHideForPlayer(playerid,ReadyText);
	    }
	}

	if(newkeys & KEY_SECONDARY_ATTACK)
	{
	    if(Gambling[playerid] == G_STATE_READY)
	    {
	    	ExitPlayerFromSlotMachine(playerid);
	    }
	}

	if(newkeys & KEY_JUMP)
	{
	    if(Gambling[playerid] == G_STATE_READY)
	    {
	    	Bet[playerid] = GetNextValidBet(Bet[playerid]);
	    	UpdateBetText(playerid);
	    }
	}
	return 1;
}

forward Gambler(playerid);
public Gambler(playerid)
{
	if(Gambling[playerid] != G_STATE_GAMBLING)
	{
	    print("Strange error @ gambler");
	    KillTimer(SlotTimer[playerid]);
	    SlotTimer[playerid] = -1;
	    Gambling[playerid] = G_STATE_NOT_GAMBLING;
	    return 0;
	}
	SlotCounter[playerid] -= 1;

	new slot = SlotCounter[playerid];

	if(slot < 10)
	{
	    Slots[playerid][2]+=random(3)+1;
	}
	else if(slot < 20)
	{
	    Slots[playerid][1]+=random(3)+1;
	    Slots[playerid][2]+=random(3)+1;
	}
	else
	{
	    Slots[playerid][0]+=random(3)+1;
	    Slots[playerid][1]+=random(3)+1;
	    Slots[playerid][2]+=random(3)+1;
	}
	if(Slots[playerid][0] >= 6) Slots[playerid][0] = 0;
	if(Slots[playerid][1] >= 6) Slots[playerid][1] = 0;
	if(Slots[playerid][2] >= 6) Slots[playerid][2] = 0;

	ShowPlayerSlots(playerid,Slots[playerid][0],Slots[playerid][1],Slots[playerid][2]);

	if(SlotCounter[playerid] == 0)
	{
	    KillTimer(SlotTimer[playerid]);
	    SlotTimer[playerid] = -1;
		Gambling[playerid] = G_STATE_DISPLAY;

	    if(Slots[playerid][0] == Slots[playerid][1] && Slots[playerid][0] == Slots[playerid][2])
	    {
	        //printf("player %d won with %d",playerid,Slots[playerid][0]); // Uncomment this line for seeing all wins

	        new Multiplier=1;

	        switch(Slots[playerid][0])
	        {
	            case 0: Multiplier = 25;    // Cherries
	            case 1: Multiplier = 100;   // Grapes
	            case 2: Multiplier = 250;   // 69's
	            case 3: Multiplier = 500;   // Bells
	            case 4: Multiplier = 1000;  // Bar
	            case 5: Multiplier = 2000;  // Double Bars
	        }

	        new money = floatround(Bet[playerid] * Multiplier * WIN_MULTIPLIER_GLOBAL);
	        new str[128];
	        format(str,sizeof(str),"~w~Winner: ~g~%d$~w~!",money);
	        GameTextForPlayer(playerid,str,5000,4);

	        Balance[playerid] += money;

	        UpdateBetText(playerid);

	        Slots[playerid][0] = random(5); // Randomize the slots again
			Slots[playerid][1] = random(5);
			Slots[playerid][2] = random(5);
	    }
	    else
	    {
	        if(Slots[playerid][0] == Slots[playerid][1] || Slots[playerid][1] == Slots[playerid][2] || Slots[playerid][0] == Slots[playerid][2]) GameTextForPlayer(playerid,"Almost!",3000,4);
	        else GameTextForPlayer(playerid,"Bad luck!",3000,4);
	    }

	    SetTimerEx("PlayAgainTimer",DISPLAY_TIME,0,"d",playerid);
	    return 1;
	}
	//printf("Counter: %d",SlotCounter[playerid]);
	return 0;
}

forward PlayAgainTimer(playerid);
public PlayAgainTimer(playerid)
{
	Gambling[playerid] = G_STATE_READY;
	TextDrawShowForPlayer(playerid,ReadyText);

	// Remove the following 3 lines to disable the ability to hold down SPRINT
	new keys,lr,ud;
	GetPlayerKeys(playerid,keys,ud,lr);
	if(keys & KEY_SPRINT) OnPlayerKeyStateChange(playerid,KEY_SPRINT,0);
}

GetNextValidBet(value)
{
	if(value + Bet_STEP > MAX_Bet) return MIN_Bet;
	return value + Bet_STEP;
}

UpdateBetText(playerid)
{
    new str[128];
    new prefix[4];
    if(Balance[playerid] == 0) strcat(prefix,"~r~");
    if(Balance[playerid]  > 0) strcat(prefix,"~g~");

    format(str,sizeof(str),"~w~Bet: ~g~%d$_____~w~Balance: %s%d$",Bet[playerid],prefix,Balance[playerid]);
	TextDrawSetString(BetText[playerid],str);
}

forward RDYBLINK();
public RDYBLINK()
{
	// This will make the "Place your bet" text blinking. Comment out the Timer at OnFilterScriptInit for disabling it.
	rdy=!rdy;
	if(rdy)
	{
	    TextDrawSetString(ReadyText,"~w~Place your ~y~bet~w~!~n~~b~ ~k~~PED_SPRINT~ ~w~- ~g~gamble~n~~b~~k~~VEHICLE_ENTER_EXIT~ ~w~- ~r~exit~n~~b~~k~~PED_JUMPING~ ~w~- ~y~increase Bet");
	}
	else
	{
	    TextDrawSetString(ReadyText,"_~n~~b~ ~k~~PED_SPRINT~ ~w~- ~g~gamble~n~~b~~k~~VEHICLE_ENTER_EXIT~ ~w~- ~r~exit~n~~b~~k~~PED_JUMPING~ ~w~- ~y~increase Bet");
	}
}

stock strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[128]; // modified to 128
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[128],idx;

	cmd = strtok(cmdtext,idx);

	if (strcmp(cmd, "/gamble", true) == 0)
	{
	    cmd = strtok(cmdtext,idx);

		if(!strlen(cmd)) return SendClientMessage(playerid,-1,"Use /gamble [money] to put money into the Slot Machine!");

	    new money = strval(cmd);

	    if(money < MIN_Bet) return SendClientMessage(playerid,-1,"You have to put more money into the Slot Machine!");

	    if(money > GetPlayerMoney(playerid)) return SendClientMessage(playerid,-1,"You don't have enough money!");

	    if(money < 0) return SendClientMessage(playerid,-1,"Invalid amount!");

		PutPlayerInSlotMachine(playerid,_,money);
		return 1;
	}
	return 0;
}
