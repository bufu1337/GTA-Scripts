/*This filterscript was created by jthebeast2007 aka [DDG]Hellboy!
You can use this script but please do not remove my credits from the script
or steal credit! Enjoy! Also please visit www.hellboyserver.co.nr!*/

#include <a_samp>
#include <dini>

#define sec(%1) %1*1000 //sec(number of seconds)
#define min(%1) %1*60*1000 //min(number of minutes)
#define hour(%1) %1*60*60*1000 //hour(number of hours)

new LOTTOTIME = min(5); //set this for how often to draw numbers is set for 5 minutes
new LOTTOPRICE = 100; //set this for the cost to play the lotto 0 to play for free
new LOTTOMINPRIZE = 20000; //set this for the lowest prize, used when STATICPRIZE = 0
new LOTTOMAXPRIZE = 500000; //set this for the max prize, prize amount is randomly chosen on values between this and the LOTTOMINPRIZE, used when STATICPRIZE = 0
new NUMBERRANGE = 99; //set this to the highest number the lotto will pick
new STATICPRIZE = 0; //set this to the amount you want players to win 0 if you want to use random prize amounts

new lottonums[5];
new lnums[MAX_PLAYERS][5];
new playinlotto[MAX_PLAYERS];
new prize;
new lstring[256];
new lottotimer;
new winlotto[MAX_PLAYERS];
new lottodisabled = 0;

new Menu:AMenu;
new Menu:MiP;
new Menu:MaP;
new Menu:LT;
new Menu:LC;
new Menu:SP;
new Menu:NR;

stock Updatecfg()
{
	new file[256] = "HLotto.ini";
	dini_IntSet(file,"MinPrize",LOTTOMINPRIZE);
	dini_IntSet(file,"MaxPrize",LOTTOMAXPRIZE);
	dini_IntSet(file,"StaticPrize",STATICPRIZE);
	dini_IntSet(file,"LottoTime",LOTTOTIME);
	dini_IntSet(file,"LottoPrice",LOTTOPRICE);
	dini_IntSet(file,"NumberRange",NUMBERRANGE);
}

stock Loadcfg()
{
	new file[256] = "HLotto.ini";
    if(!dini_Exists(file)) {
	dini_Create(file);
	Updatecfg();
	}
	else {
	LOTTOMINPRIZE = dini_Int(file,"MinPrize");
	LOTTOMAXPRIZE = dini_Int(file,"MaxPrize");
	STATICPRIZE = dini_Int(file,"StaticPrize");
	LOTTOTIME = dini_Int(file,"LottoTime");
	LOTTOPRICE = dini_Int(file,"LottoPrice");
	NUMBERRANGE = dini_Int(file,"NumberRange");
	}
}

stock minrand(min, max)
{
	return random(max - min) + min;
}

stock Getmatchlottonums(playerid)
{
new c = 0;
for(new i=0;i<5;i++)
if(lottonums[0] == lnums[playerid][i])
c ++;
for(new i=0;i<5;i++)
if(lottonums[1] == lnums[playerid][i])
c ++;
for(new i=0;i<5;i++)
if(lottonums[2] == lnums[playerid][i])
c ++;
for(new i=0;i<5;i++)
if(lottonums[3] == lnums[playerid][i])
c ++;
for(new i=0;i<5;i++)
if(lottonums[4] == lnums[playerid][i])
c ++;
return c;
}

forward Getlottowinners();
public Getlottowinners()
{
	for(new i=0;i<MAX_PLAYERS;i++) {
    new name[MAX_PLAYER_NAME],string[256];
	new prizediv = prize/5;
	new winprize = prizediv*Getmatchlottonums(i);
	if(playinlotto[i] == 1) {
	if(Getmatchlottonums(i) == 0 && winlotto[i] == 0) {
	SendClientMessage(i,0xFFFF00AA,"Sorry you didn't win better luck next time");
	playinlotto[i] = 0;
	}
	if(Getmatchlottonums(i) == 5 || winlotto[i] == 1) {
	GetPlayerName(i,name,sizeof(name));
	format(string,sizeof(string),"%s has hit the lottery for $%d",name,prize);
	SendClientMessageToAll(0xFFFF00AA,string);
	GivePlayerMoney(i,prize);
	playinlotto[i] = 0;
	winlotto[i] = 0;
	}
	if(Getmatchlottonums(i) > 0 && Getmatchlottonums(i) < 5) {
	format(string,sizeof(string),"You hit on %d numbers and won $%d",Getmatchlottonums(i),winprize);
	SendClientMessage(i,0xFFFF00AA,string);
	GivePlayerMoney(i,winprize);
	playinlotto[i] = 0;
	}
	}
	}
}

forward lotto();
public lotto()
{
	lottonums[0] = random(NUMBERRANGE);
	lottonums[1] = random(NUMBERRANGE);
	lottonums[2] = random(NUMBERRANGE);
	lottonums[3] = random(NUMBERRANGE);
	lottonums[4] = random(NUMBERRANGE);
	if(STATICPRIZE == 0) {
	prize = minrand(LOTTOMINPRIZE,LOTTOMAXPRIZE);
	}
	else {
	prize = STATICPRIZE;
	}
	new string[256];
	format(string,sizeof(string),"Todays Lotto Numbers are: %d,%d,%d,%d,%d",lottonums[0],lottonums[1],lottonums[2],lottonums[3],lottonums[4]);
	SendClientMessageToAll(0x33FF33AA,string);
	format(string,sizeof(string),"Today's lotto prize is $%d",prize);
	SendClientMessageToAll(0x33FF33AA,string);
	SetTimer("Getlottowinners",5000,false);
}

public OnFilterScriptInit()
{
	Loadcfg();
	AMenu = CreateMenu("AdminLottoMenu",1,50,150,250,150);
	AddMenuItem(AMenu,0,"Minimum prize");
	AddMenuItem(AMenu,0,"Maximum prize");
	AddMenuItem(AMenu,0,"Static Prize");
	AddMenuItem(AMenu,0,"Lotto time");
	AddMenuItem(AMenu,0,"Lotto cost");
	AddMenuItem(AMenu,0,"Number Range");
	MiP = CreateMenu("Minimum_prize",1,50,150,250,150);
	format(lstring,sizeof(lstring),"$%d",LOTTOMINPRIZE);
	SetMenuColumnHeader(MiP,0,lstring);
	AddMenuItem(MiP,0,"+10000");
	AddMenuItem(MiP,0,"+1000");
	AddMenuItem(MiP,0,"+100");
	AddMenuItem(MiP,0,"+10");
	AddMenuItem(MiP,0,"-10");
	AddMenuItem(MiP,0,"-100");
	AddMenuItem(MiP,0,"-1000");
	AddMenuItem(MiP,0,"-10000");
	AddMenuItem(MiP,0,"Back");
	MaP = CreateMenu("Maximum_prize",1,50,150,250,150);
	format(lstring,sizeof(lstring),"$%d",LOTTOMAXPRIZE);
	SetMenuColumnHeader(MaP,0,lstring);
	AddMenuItem(MaP,0,"+10000");
	AddMenuItem(MaP,0,"+1000");
	AddMenuItem(MaP,0,"+100");
	AddMenuItem(MaP,0,"+10");
	AddMenuItem(MaP,0,"-10");
	AddMenuItem(MaP,0,"-100");
	AddMenuItem(MaP,0,"-1000");
	AddMenuItem(MaP,0,"-10000");
	AddMenuItem(MaP,0,"Back");
	SP = CreateMenu("Static_Prize",1,50,150,250,150);
	format(lstring,sizeof(lstring),"$%d",STATICPRIZE);
	SetMenuColumnHeader(SP,0,lstring);
	AddMenuItem(SP,0,"+10000");
	AddMenuItem(SP,0,"+1000");
	AddMenuItem(SP,0,"+100");
	AddMenuItem(SP,0,"+10");
	AddMenuItem(SP,0,"-10");
	AddMenuItem(SP,0,"-100");
	AddMenuItem(SP,0,"-1000");
	AddMenuItem(SP,0,"-10000");
	AddMenuItem(SP,0,"Back");
	LT = CreateMenu("Lotto_Time",1,50,150,150,150);
	if(LOTTOTIME >= 0 && LOTTOTIME < 60000) {
	format(lstring,sizeof(lstring),"%d seconds",LOTTOTIME/1000);
	}
	if(LOTTOTIME > 59999 && LOTTOTIME < 3600000) {
	format(lstring,sizeof(lstring),"%d minutes",LOTTOTIME/1000/60);
	}
	if(LOTTOTIME > 3599999) {
	format(lstring,sizeof(lstring),"%d hours",LOTTOTIME/1000/60/60);
	}
	SetMenuColumnHeader(LT,0,lstring);
	AddMenuItem(LT,0,"+1");
	AddMenuItem(LT,0,"-1");
	AddMenuItem(LT,0,"Back");
	LC = CreateMenu("Lotto_Price",1,50,150,250,150);
	format(lstring,sizeof(lstring),"$%d",LOTTOPRICE);
	SetMenuColumnHeader(LC,0,lstring);
	AddMenuItem(LC,0,"+10000");
	AddMenuItem(LC,0,"+1000");
	AddMenuItem(LC,0,"+100");
	AddMenuItem(LC,0,"+10");
	AddMenuItem(LC,0,"-10");
	AddMenuItem(LC,0,"-100");
	AddMenuItem(LC,0,"-1000");
	AddMenuItem(LC,0,"-10000");
	AddMenuItem(LC,0,"Back");
	NR = CreateMenu("Number_Range",1,50,150,250,150);
	format(lstring,sizeof(lstring),"%d",NUMBERRANGE);
	SetMenuColumnHeader(NR,0,lstring);
	AddMenuItem(NR,0,"+10");
	AddMenuItem(NR,0,"+1");
	AddMenuItem(NR,0,"-1");
	AddMenuItem(NR,0,"-10");
	AddMenuItem(NR,0,"Back");
	lottotimer = SetTimer("lotto",LOTTOTIME,true);
	print("\n--------------------------------------");
	print(" Lotto Filterscript by Hellboy loaded");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	KillTimer(lottotimer);
	DestroyMenu(AMenu);
	DestroyMenu(MiP);
	DestroyMenu(MaP);
	DestroyMenu(SP);
	DestroyMenu(LT);
	DestroyMenu(LC);
	DestroyMenu(NR);
	print("\n--------------------------------------");
	print(" Lotto Filterscript by Hellboy unloaded");
	print("--------------------------------------\n");
	return 1;
}

public OnPlayerConnect(playerid)
{
	//SendClientMessage(playerid,0x33FF33AA,"This server is using Hellboy's Lotto /lottohelp");
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	playinlotto[playerid] = 0;
	winlotto[playerid] = 0;
	for(new i=0;i<5;i++) {
	lnums[playerid][i] = 0;
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[256],cmd[256],idx;
	cmd = strtok(cmdtext, idx);
	
	if(strcmp(cmd,"/lottomenu",true) == 0 && IsPlayerAdmin(playerid))
	{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,sizeof(name));
	ShowMenuForPlayer(AMenu,playerid);
	TogglePlayerControllable(playerid,false);
	KillTimer(lottotimer);
	lottodisabled = 1;
	format(string,sizeof(string),"The lotto has been disabled while Administrator: %s is updating the lotto",name);
	SendClientMessage(playerid,0xFFFF00AA,string);
	return 1;
	}
	
	if(strcmp(cmd,"/nextwinner",true) == 0 && IsPlayerAdmin(playerid))
	{
	new tmp[256];
	tmp = strtok(cmdtext, idx);
	
	if(!strlen(tmp)) {
	SendClientMessage(playerid,0xFF0000AA,"USAGE: /nextwinner [id of player you want to win]");
	return 1;
	}
	
	new giveplayerid = strval(tmp);
	if(!IsPlayerConnected(giveplayerid)) {
	SendClientMessage(playerid,0xFF0000AA,"You have entered a invalid id");
	return 1;
	}
	new name[MAX_PLAYER_NAME],givename[MAX_PLAYER_NAME];
	GetPlayerName(giveplayerid,givename,sizeof(givename));
	GetPlayerName(playerid,name,sizeof(name));
	format(string,sizeof(string),"You have selected %s to win the lotto",givename);
	SendClientMessage(playerid,0xFFFF00AA,string);
	format(string,sizeof(string),"Administrator: %s has selected you to win the lotto",name);
	SendClientMessage(giveplayerid,0xFFFF00AA,string);
	playinlotto[giveplayerid] = 1;
	winlotto[giveplayerid] = 1;
	return 1;
	}
	
	if(strcmp(cmd,"/lottohelp",true) == 0)
	{
	if(!IsPlayerAdmin(playerid)) {
	format(string,sizeof(string),"It costs $%d to play the lotto",LOTTOPRICE);
	SendClientMessage(playerid,0xFFFF00AA,string);
	SendClientMessage(playerid,0xFFFF00AA,"To play the lotto type /lotto quickpick to have the numbers picked for you");
	format(string,sizeof(string),"or type /lotto [0-%d] [0-%d] [0-%d] [0-%d] [0-%d]",NUMBERRANGE,NUMBERRANGE,NUMBERRANGE,NUMBERRANGE,NUMBERRANGE);
	SendClientMessage(playerid,0xFFFF00AA,string);
	format(string,sizeof(string),"pick 5 numbers from 0 to %d if you hit on all 5 you win the jackpot",NUMBERRANGE);
	SendClientMessage(playerid,0xFFFF00AA,string);
	SendClientMessage(playerid,0xFFFF00AA,"and if you hit for atleast 1 number you get some money,Good Luck!");
	return 1;
	}

	if(IsPlayerAdmin(playerid)) {
	format(string,sizeof(string),"It costs $%d to play the lotto",LOTTOPRICE);
	SendClientMessage(playerid,0xFFFF00AA,string);
	SendClientMessage(playerid,0xFFFF00AA,"To play the lotto type /lotto quickpick to have the numbers picked for you");
	format(string,sizeof(string),"or type /lotto [0-%d] [0-%d] [0-%d] [0-%d] [0-%d]",NUMBERRANGE,NUMBERRANGE,NUMBERRANGE,NUMBERRANGE,NUMBERRANGE);
	SendClientMessage(playerid,0xFFFF00AA,string);
	format(string,sizeof(string),"pick 5 numbers from 0 to %d if you hit on all 5 you win the jackpot",NUMBERRANGE);
	SendClientMessage(playerid,0xFFFF00AA,string);
	SendClientMessage(playerid,0xFFFF00AA,"and if you hit for atleast 1 number you get some money,Good Luck!");
	SendClientMessage(playerid,0xFFFF00AA,"/lottomenu to bring up the lotto settings menu");
	SendClientMessage(playerid,0xFFFF00AA,"/nextwinner [id] to make a player win the lottery");
	return 1;
	}
	}
	
	if(strcmp(cmd,"/lotto",true) == 0)
	{
	new tmp[256],tmp2[256],tmp3[256],tmp4[256],tmp5[256];
	tmp = strtok(cmdtext, idx);

	if(playinlotto[playerid] == 1) {
	SendClientMessage(playerid,0xFF0000AA,"You are already playing the lotto");
	return 1;
	}
	
	if(lottodisabled == 1) {
	SendClientMessage(playerid,0xFF0000AA,"The lotto is currently disabled");
	return 1;
	}
	
	if(GetPlayerMoney(playerid) < LOTTOPRICE) {
	SendClientMessage(playerid,0xFF0000AA,"You don't have enough money to play the lotto");
	return 1;
	}
	
	if(strcmp(tmp,"quickpick",true) == 0) {
	lnums[playerid][0] = random(NUMBERRANGE);
	lnums[playerid][1] = random(NUMBERRANGE);
	lnums[playerid][2] = random(NUMBERRANGE);
	lnums[playerid][3] = random(NUMBERRANGE);
	lnums[playerid][4] = random(NUMBERRANGE);
	format(string,sizeof(string),"Your quickpick numbers are: %d,%d,%d,%d,%d",lnums[playerid][0],lnums[playerid][1],lnums[playerid][2],lnums[playerid][3],lnums[playerid][4]);
	SendClientMessage(playerid,0x33FF33AA,string);
	SendClientMessage(playerid,0xFFFF00AA,"Good Luck!");
	playinlotto[playerid] = 1;
	GivePlayerMoney(playerid,-LOTTOPRICE);
	return 1;
	}

	if(!strlen(tmp) || !isNumeric(tmp) || strval(tmp) < 0 || strval(tmp) > NUMBERRANGE) {
	format(string,sizeof(string),"USAGE: /lotto [0-%d] [0-%d] [0-%d] [0-%d] [0-%d]",NUMBERRANGE,NUMBERRANGE,NUMBERRANGE,NUMBERRANGE,NUMBERRANGE);
	SendClientMessage(playerid,0xFF0000AA,string);
	SendClientMessage(playerid,0xFF0000AA,"Or /lotto quickplay");
	return 1;
	}
	lnums[playerid][0] = strval(tmp);

	tmp2 = strtok(cmdtext, idx);
	if(!strlen(tmp2) || !isNumeric(tmp2) || strval(tmp2) < 0 || strval(tmp2) > NUMBERRANGE) {
	format(string,sizeof(string),"USAGE: /lotto [0-%d] [0-%d] [0-%d] [0-%d] [0-%d]",NUMBERRANGE,NUMBERRANGE,NUMBERRANGE,NUMBERRANGE,NUMBERRANGE);
	SendClientMessage(playerid,0xFF0000AA,string);
	SendClientMessage(playerid,0xFF0000AA,"Or /lotto quickplay");
	return 1;
	}
	lnums[playerid][1] = strval(tmp2);

	tmp3 = strtok(cmdtext, idx);
	if(!strlen(tmp3) || !isNumeric(tmp3) || strval(tmp3) < 0 || strval(tmp3) > NUMBERRANGE) {
	format(string,sizeof(string),"USAGE: /lotto [0-%d] [0-%d] [0-%d] [0-%d] [0-%d]",NUMBERRANGE,NUMBERRANGE,NUMBERRANGE,NUMBERRANGE,NUMBERRANGE);
	SendClientMessage(playerid,0xFF0000AA,string);
	SendClientMessage(playerid,0xFF0000AA,"Or /lotto quickplay");
	return 1;
	}
	lnums[playerid][2] = strval(tmp3);

	tmp4 = strtok(cmdtext, idx);
	if(!strlen(tmp4) || !isNumeric(tmp4) || strval(tmp4) < 0 || strval(tmp4) > NUMBERRANGE) {
	format(string,sizeof(string),"USAGE: /lotto [0-%d] [0-%d] [0-%d] [0-%d] [0-%d]",NUMBERRANGE,NUMBERRANGE,NUMBERRANGE,NUMBERRANGE,NUMBERRANGE);
	SendClientMessage(playerid,0xFF0000AA,string);
	SendClientMessage(playerid,0xFF0000AA,"Or /lotto quickplay");
	return 1;
	}

	lnums[playerid][3] = strval(tmp4);

	tmp5 = strtok(cmdtext, idx);
	if(!strlen(tmp5) || !isNumeric(tmp5) || strval(tmp5) < 0 || strval(tmp5) > NUMBERRANGE) {
	format(string,sizeof(string),"USAGE: /lotto [0-%d] [0-%d] [0-%d] [0-%d] [0-%d]",NUMBERRANGE,NUMBERRANGE,NUMBERRANGE,NUMBERRANGE,NUMBERRANGE);
	SendClientMessage(playerid,0xFF0000AA,string);
	SendClientMessage(playerid,0xFF0000AA,"Or /lotto quickplay");
	return 1;
	}

	lnums[playerid][4] = strval(tmp5);
	format(string,sizeof(string),"Numbers picked: %d,%d,%d,%d,%d",lnums[playerid][0],lnums[playerid][1],lnums[playerid][2],lnums[playerid][3],lnums[playerid][4]);
	SendClientMessage(playerid,0x33FF33AA,string);
	SendClientMessage(playerid,0xFFFF00AA,"Good Luck!");
	playinlotto[playerid] = 1;
	return 1;
	}
	return 0;
}

stock RefreshMenuHeader(playerid,Menu:menu,text[])
{
	SetMenuColumnHeader(menu,0,text);
	ShowMenuForPlayer(menu,playerid);
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	new Menu:current = GetPlayerMenu(playerid);
	new lottomnprize,lottomxprize,lottot,lottocost,stprize,numrange;
	if(current == AMenu) {
	switch(row) {
	    case 0: {
	        HideMenuForPlayer(current,playerid);
	        ShowMenuForPlayer(MiP,playerid);
	        }
		case 1: {
		    HideMenuForPlayer(current,playerid);
	        ShowMenuForPlayer(MaP,playerid);
	        }
		case 2: {
		    HideMenuForPlayer(current,playerid);
	        ShowMenuForPlayer(SP,playerid);
	        }
		case 3: {
		    HideMenuForPlayer(current,playerid);
	        ShowMenuForPlayer(LT,playerid);
	        }
		case 4: {
		    HideMenuForPlayer(current,playerid);
		    ShowMenuForPlayer(LC,playerid);
		    }
		case 5: {
		    HideMenuForPlayer(current,playerid);
		    ShowMenuForPlayer(NR,playerid);
		    }
			}
			}
	if(current == MiP) {
	switch(row) {
	    case 0: {
	        lottomnprize = LOTTOMINPRIZE+10000;
	        format(lstring,sizeof(lstring),"$%d",lottomnprize);
	        RefreshMenuHeader(playerid,MiP,lstring);
	        LOTTOMINPRIZE = lottomnprize;
	        }
		case 1: {
		    lottomnprize = LOTTOMINPRIZE+1000;
		    format(lstring,sizeof(lstring),"$%d",lottomnprize);
	        RefreshMenuHeader(playerid,MiP,lstring);
	        LOTTOMINPRIZE = lottomnprize;
	        }
		case 2: {
		    lottomnprize = LOTTOMINPRIZE+100;
	        format(lstring,sizeof(lstring),"$%d",lottomnprize);
	        RefreshMenuHeader(playerid,MiP,lstring);
	        LOTTOMINPRIZE = lottomnprize;
	        }
		case 3: {
		    lottomnprize = LOTTOMINPRIZE+10;
	        format(lstring,sizeof(lstring),"$%d",lottomnprize);
	        RefreshMenuHeader(playerid,MiP,lstring);
	        LOTTOMINPRIZE = lottomnprize;
	        }
		case 4: {
		    lottomnprize = LOTTOMINPRIZE-10;
	        format(lstring,sizeof(lstring),"$%d",lottomnprize);
	        RefreshMenuHeader(playerid,MiP,lstring);
	        LOTTOMINPRIZE = lottomnprize;
	        }
		case 5: {
		    lottomnprize = LOTTOMINPRIZE-100;
	        format(lstring,sizeof(lstring),"$%d",lottomnprize);
	        RefreshMenuHeader(playerid,MiP,lstring);
	        LOTTOMINPRIZE = lottomnprize;
	        }
		case 6: {
		    lottomnprize = LOTTOMINPRIZE-1000;
	        format(lstring,sizeof(lstring),"$%d",lottomnprize);
	        RefreshMenuHeader(playerid,MiP,lstring);
	        LOTTOMINPRIZE = lottomnprize;
	        }
		case 7: {
            lottomnprize = LOTTOMINPRIZE-10000;
	        format(lstring,sizeof(lstring),"$%d",lottomnprize);
	        RefreshMenuHeader(playerid,MiP,lstring);
	        LOTTOMINPRIZE = lottomnprize;
	        }
		case 8: {
		    HideMenuForPlayer(current,playerid);
		    ShowMenuForPlayer(AMenu,playerid);
		    }
	        }
	        }
	if(current == MaP) {
	switch(row) {
	    case 0: {
	        lottomxprize = LOTTOMAXPRIZE+10000;
	        format(lstring,sizeof(lstring),"$%d",lottomxprize);
	        RefreshMenuHeader(playerid,MaP,lstring);
	        LOTTOMAXPRIZE = lottomxprize;
	        }
		case 1: {
		    lottomxprize = LOTTOMAXPRIZE+1000;
	        format(lstring,sizeof(lstring),"$%d",lottomxprize);
	        RefreshMenuHeader(playerid,MaP,lstring);
	        LOTTOMAXPRIZE = lottomxprize;
	        }
		case 2: {
		    lottomxprize = LOTTOMAXPRIZE+100;
	        format(lstring,sizeof(lstring),"$%d",lottomxprize);
	        RefreshMenuHeader(playerid,MaP,lstring);
	        LOTTOMAXPRIZE = lottomxprize;
	        }
		case 3: {
		    lottomxprize = LOTTOMAXPRIZE+10;
	        format(lstring,sizeof(lstring),"$%d",lottomxprize);
	        RefreshMenuHeader(playerid,MaP,lstring);
	        LOTTOMAXPRIZE = lottomxprize;
	        }
		case 4: {
		    lottomxprize = LOTTOMAXPRIZE-10;
	        format(lstring,sizeof(lstring),"$%d",lottomxprize);
	        RefreshMenuHeader(playerid,MaP,lstring);
	        LOTTOMAXPRIZE = lottomxprize;
	        }
		case 5: {
		    lottomxprize = LOTTOMAXPRIZE-100;
	        format(lstring,sizeof(lstring),"$%d",lottomxprize);
	        RefreshMenuHeader(playerid,MaP,lstring);
	        LOTTOMAXPRIZE = lottomxprize;
	        }
		case 6: {
		    lottomxprize = LOTTOMAXPRIZE-1000;
	        format(lstring,sizeof(lstring),"$%d",lottomxprize);
	        RefreshMenuHeader(playerid,MaP,lstring);
	        LOTTOMAXPRIZE = lottomxprize;
	        }
		case 7: {
		    lottomxprize = LOTTOMAXPRIZE-10000;
	        format(lstring,sizeof(lstring),"$%d",lottomxprize);
	        RefreshMenuHeader(playerid,MaP,lstring);
	        LOTTOMAXPRIZE = lottomxprize;
	        }
		case 8: {
		    HideMenuForPlayer(current,playerid);
		    ShowMenuForPlayer(AMenu,playerid);
		    }
		    }
		    }
	if(current == LT) {
	switch(row) {
	    case 0: {
			if(LOTTOTIME >= 0 && LOTTOTIME < 60000) {
			lottot = LOTTOTIME+1000;
			format(lstring,sizeof(lstring),"%d seconds",lottot/1000);
			RefreshMenuHeader(playerid,LT,lstring);
			LOTTOTIME = lottot;
			}
	        if(LOTTOTIME > 59999 && LOTTOTIME < 3600000) {
	        lottot = LOTTOTIME+60000;
	        format(lstring,sizeof(lstring),"%d minutes",lottot/1000/60);
	        RefreshMenuHeader(playerid,LT,lstring);
	        LOTTOTIME = lottot;
	        }
	        if(LOTTOTIME > 3599999) {
	        lottot = LOTTOTIME+3600000;
	        format(lstring,sizeof(lstring),"%d hours",lottot/1000/60/60);
	        RefreshMenuHeader(playerid,LT,lstring);
	        LOTTOTIME = lottot;
	        }
	        }
		case 1: {
		    if(LOTTOTIME > 999 && LOTTOTIME < 120000) {
			lottot = LOTTOTIME-1000;
			format(lstring,sizeof(lstring),"%d seconds",lottot/1000);
			RefreshMenuHeader(playerid,LT,lstring);
			LOTTOTIME = lottot;
			}
	        if(LOTTOTIME > 119999 && LOTTOTIME < 3600000) {
	        lottot = LOTTOTIME-60000;
	        format(lstring,sizeof(lstring),"%d minutes",lottot/1000/60);
	        RefreshMenuHeader(playerid,LT,lstring);
	        LOTTOTIME = lottot;
	        }
	        if(LOTTOTIME > 3599999) {
	        lottot = LOTTOTIME-3600000;
	        format(lstring,sizeof(lstring),"%d hours",lottot/1000/60/60);
	        RefreshMenuHeader(playerid,LT,lstring);
	        LOTTOTIME = lottot;
	        }
	        }
		case 2: {
		    HideMenuForPlayer(current,playerid);
		    ShowMenuForPlayer(AMenu,playerid);
		    }
	        }
	        }
	if(current == LC) {
	switch(row) {
	    case 0: {
	        lottocost = LOTTOPRICE+10000;
	        format(lstring,sizeof(lstring),"$%d",lottocost);
	        RefreshMenuHeader(playerid,LC,lstring);
	        LOTTOPRICE = lottocost;
	        }
		case 1: {
		    lottocost = LOTTOPRICE+1000;
	        format(lstring,sizeof(lstring),"$%d",lottocost);
	        RefreshMenuHeader(playerid,LC,lstring);
	        LOTTOPRICE = lottocost;
	        }
		case 2: {
		    lottocost = LOTTOPRICE+100;
	        format(lstring,sizeof(lstring),"$%d",lottocost);
	        RefreshMenuHeader(playerid,LC,lstring);
	        LOTTOPRICE = lottocost;
	        }
        case 3: {
            lottocost = LOTTOPRICE+10;
	        format(lstring,sizeof(lstring),"$%d",lottocost);
	        RefreshMenuHeader(playerid,LC,lstring);
	        LOTTOPRICE = lottocost;
	        }
		case 4: {
		    lottocost = LOTTOPRICE-10;
	        format(lstring,sizeof(lstring),"$%d",lottocost);
	        RefreshMenuHeader(playerid,LC,lstring);
	        LOTTOPRICE = lottocost;
	        }
		case 5: {
		    lottocost = LOTTOPRICE-100;
	        format(lstring,sizeof(lstring),"$%d",lottocost);
	        RefreshMenuHeader(playerid,LC,lstring);
	        LOTTOPRICE = lottocost;
	        }
		case 6: {
		    lottocost = LOTTOPRICE-1000;
	        format(lstring,sizeof(lstring),"$%d",lottocost);
	        RefreshMenuHeader(playerid,LC,lstring);
	        LOTTOPRICE = lottocost;
	        }
		case 7: {
		    lottocost = LOTTOPRICE-10000;
	        format(lstring,sizeof(lstring),"$%d",lottocost);
	        RefreshMenuHeader(playerid,LC,lstring);
	        LOTTOPRICE = lottocost;
	        }
		case 8: {
		    HideMenuForPlayer(current,playerid);
		    ShowMenuForPlayer(AMenu,playerid);
		    }
		    }
		    }
	if(current == SP) {
	switch(row) {
	    case 0: {
	        stprize = STATICPRIZE+10000;
	        format(lstring,sizeof(lstring),"$%d",stprize);
	        RefreshMenuHeader(playerid,SP,lstring);
	        STATICPRIZE = stprize;
	        }
		case 1: {
		    stprize = STATICPRIZE+1000;
	        format(lstring,sizeof(lstring),"$%d",stprize);
	        RefreshMenuHeader(playerid,SP,lstring);
	        STATICPRIZE = stprize;
	        }
		case 2: {
		    stprize = STATICPRIZE+100;
	        format(lstring,sizeof(lstring),"$%d",stprize);
	        RefreshMenuHeader(playerid,SP,lstring);
	        STATICPRIZE = stprize;
	        }
		case 3: {
		    stprize = STATICPRIZE+10;
	        format(lstring,sizeof(lstring),"$%d",stprize);
	        RefreshMenuHeader(playerid,SP,lstring);
	        STATICPRIZE = stprize;
	        }
		case 4: {
		    stprize = STATICPRIZE-10;
	        format(lstring,sizeof(lstring),"$%d",stprize);
	        RefreshMenuHeader(playerid,SP,lstring);
	        STATICPRIZE = stprize;
	        }
		case 5: {
		    stprize = STATICPRIZE-100;
	        format(lstring,sizeof(lstring),"$%d",stprize);
	        RefreshMenuHeader(playerid,SP,lstring);
	        STATICPRIZE = stprize;
	        }
		case 6: {
		    stprize = STATICPRIZE-1000;
	        format(lstring,sizeof(lstring),"$%d",stprize);
	        RefreshMenuHeader(playerid,SP,lstring);
	        STATICPRIZE = stprize;
	        }
		case 7: {
		    stprize = STATICPRIZE-10000;
	        format(lstring,sizeof(lstring),"$%d",stprize);
	        RefreshMenuHeader(playerid,SP,lstring);
	        STATICPRIZE = stprize;
	        }
		case 8: {
		    HideMenuForPlayer(current,playerid);
		    ShowMenuForPlayer(AMenu,playerid);
		    }
		    }
		    }
	if(current == NR) {
	switch(row) {
	    case 0: {
	        numrange = NUMBERRANGE+10;
	        format(lstring,sizeof(lstring),"%d",numrange);
	        RefreshMenuHeader(playerid,NR,lstring);
	        NUMBERRANGE = numrange;
	        }
		case 1: {
		    numrange = NUMBERRANGE+1;
	        format(lstring,sizeof(lstring),"%d",numrange);
	        RefreshMenuHeader(playerid,NR,lstring);
	        NUMBERRANGE = numrange;
	        }
		case 2: {
		    numrange = NUMBERRANGE-1;
	        format(lstring,sizeof(lstring),"%d",numrange);
	        RefreshMenuHeader(playerid,NR,lstring);
	        NUMBERRANGE = numrange;
	        }
		case 3: {
		    numrange = NUMBERRANGE-10;
	        format(lstring,sizeof(lstring),"%d",numrange);
	        RefreshMenuHeader(playerid,NR,lstring);
	        NUMBERRANGE = numrange;
	        }
		case 4: {
		    HideMenuForPlayer(current,playerid);
		    ShowMenuForPlayer(AMenu,playerid);
		    }
		    }
		    }
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	new Menu:current = GetPlayerMenu(playerid);
	if(current == AMenu || current == MiP || current == MaP || current == LT || current == LC || current == SP || current == NR) {
	TogglePlayerControllable(playerid,true);
	lottotimer = SetTimer("lotto",LOTTOTIME,true);
	lottodisabled = 0;
	SendClientMessageToAll(0xFFFF00AA,"The lotto has been reactivated");
	Updatecfg();
	}
	return 1;
}

