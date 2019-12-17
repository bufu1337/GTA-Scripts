#include <a_samp>
#include <dudb>
#include <progress>
new Text:ExpText[MAX_PLAYERS];
new Text:LevelText[MAX_PLAYERS];
new Bar:bar[MAX_PLAYERS];
new Text3D:LevelLabel[MAX_PLAYERS];
#define ExpForLevel 1000 //How much exp you need to pass a level. The Exp gets multiplied by the level. If you've got 1000 total exp then for lvl 2 it will be 2000
#define MaxLevel 99 //The maximum level a player can achieve.
#define UseProgBar // Define wheater to use the progress bar or not. Comment the line if you don't want a progress bar and leave like that if you do want a progress bar.
#define ProgBarColor 0x0000FFFF //The experience bar's color.
#define TextLabelColor 0x00FFFFFF // The textlabel's color.
#define CashForLevelUp 300 //This is the cash you get for levelling up. It gets multiplied by the level you achieved and one more time by a number you define.
#define CashMultiplier 1 //This multiplies the Cash * Level achieved by the number you want.
#define GameTextStyle 4 //This defines the GameText's style used for the GivePlayerExp function.
#define GameTextTime 3000 //This defines the time for which the GameText for the GivePlayerExp function will be visible
#define mustlogin
#define autologin
#pragma unused strtok
#pragma unused ret_memcpy
new logged_in[MAX_PLAYERS];
new Retries[MAX_PLAYERS];
stock GivePlayerExp(playerid, exp, reason[]){
	new pfile[100], pname[MAX_PLAYER_NAME], string2[126], string3[126], string4[126];
	GetPlayerName(playerid, pname, sizeof(pname));
	format(pfile, sizeof(pfile), "HAccounts/%s.ini",pname);
	dini_IntSet(pfile, "Exp", dini_Int(pfile, "Exp") +exp);
	if (dini_Int(pfile, "Exp") >= dini_Int(pfile, "TotalExp")){
	    if (dini_Int(pfile, "ExpLevel") < MaxLevel){
			while (dini_Int(pfile, "Exp") >= dini_Int(pfile, "TotalExp")){
				dini_IntSet(pfile, "Exp", dini_Int(pfile, "Exp") - dini_Int(pfile, "TotalExp"));
				dini_IntSet(pfile, "ExpLevel", dini_Int(pfile, "ExpLevel") + 1);
			    dini_IntSet(pfile, "TotalExp", dini_Int(pfile, "ExpLevel") * ExpForLevel);
			   	format(string3, sizeof(string3), "Level: %02d",dini_Int(pfile, "ExpLevel"));
				TextDrawSetString(LevelText[playerid], string3);
				GivePlayerMoney(playerid, CashForLevelUp * dini_Int(pfile, "ExpLevel") * CashMultiplier);
				format(string4, sizeof(string4), "~p~You got %d Exp for ~n~%s !~n~~g~Level up!", exp, reason);
			}
		}
		else{
			GameTextForPlayer(playerid, "~g~Max Level Reached!", GameTextTime, GameTextStyle);
			dini_IntSet(pfile, "Exp", dini_Int(pfile, "TotalExp"));
		}
	}
	else{
		format(string4, sizeof(string4), "~p~You got %d Exp for ~n~%s !", exp, reason);
	}
	format(string2, sizeof(string2), "Exp: %05d/%05d",dini_Int(pfile, "Exp"), dini_Int(pfile, "TotalExp"));
	TextDrawSetString(ExpText[playerid], string2);
	#if defined UseProgBar
	SetProgressBarValue(bar[playerid], dini_Int(pfile, "Exp"));
	SetProgressBarMaxValue(bar[playerid], dini_Int(pfile, "TotalExp"));
	UpdateProgressBar(bar[playerid], playerid);
	#endif
	GameTextForPlayer(playerid, string4, GameTextTime, GameTextStyle);
	format(string3, sizeof(string3), "Level: %02d",dini_Int(pfile, "ExpLevel"));
	Update3DTextLabelText(LevelLabel[playerid], TextLabelColor, string3);
}
stock GetPlayerExpLevel(playerid){
	new pfile[100], pname[MAX_PLAYER_NAME], Plevel;
	GetPlayerName(playerid, pname, sizeof(pname));
	format(pfile, sizeof(pfile), "HAccounts/%s.ini",pname);
	Plevel = dini_Int(pfile, "ExpLevel");
	return Plevel;
}
stock GetPlayerExp(playerid){
	new pfile[100], pname[MAX_PLAYER_NAME], PExp;
	GetPlayerName(playerid, pname, sizeof(pname));
	format(pfile, sizeof(pfile), "HAccounts/%s.ini",pname);
	PExp = dini_Int(pfile, "Exp");
	return PExp;
}
stock GetPlayerTotalExp(playerid){
	new pfile[100], pname[MAX_PLAYER_NAME], PTotalExp;
	GetPlayerName(playerid, pname, sizeof(pname));
	format(pfile, sizeof(pfile), "HAccounts/%s.ini",pname);
	PTotalExp = dini_Int(pfile, "TotalExp");
	return PTotalExp;
}
public OnPlayerConnect(playerid){
	new pname[MAX_PLAYER_NAME],string2[126], string3[126];
	Retries[playerid] = 0;
	SendDeathMessage(INVALID_PLAYER_ID, playerid, 200);
 	new pfile[100];
	GetPlayerName(playerid, pname, sizeof(pname));
	format(pfile, sizeof(pfile), "HAccounts/%s.ini",pname);
	if (!dini_Exists(pfile)){
		ShowPlayerDialog(playerid,101,DIALOG_STYLE_INPUT,"Registration","Please enter a password to register this account!","Register","Cancel");
	}
	else if (dini_Exists(pfile)) ShowPlayerDialog(playerid,100,DIALOG_STYLE_INPUT,"Login","Please enter a password to login to this account!","Login","Cancel");
	#if defined UseProgBar
	bar[playerid] = CreateProgressBar(500.00, 5.00, 137.50, 15.19, ProgBarColor, 100.0);
	#endif
	format(string2, sizeof(string2), "Exp: %05d/%05d",dini_Int(pfile, "Exp"), dini_Int(pfile, "TotalExp"));
	format(string3, sizeof(string3), "Level: %02d",dini_Int(pfile, "ExpLevel"));
	ExpText[playerid] = TextDrawCreate(500.000000,3.000000,string2);
	TextDrawAlignment(ExpText[playerid],0);
	TextDrawBackgroundColor(ExpText[playerid],0x000000ff);
	TextDrawFont(ExpText[playerid],1);
	TextDrawLetterSize(ExpText[playerid],0.399999,1.800000);
	TextDrawColor(ExpText[playerid],0xffff00ff);
	TextDrawSetOutline(ExpText[playerid],1);
	TextDrawSetProportional(ExpText[playerid],1);

	LevelText[playerid] = TextDrawCreate(546.000000,25.000000,string3);
	TextDrawAlignment(LevelText[playerid],0);
	TextDrawBackgroundColor(LevelText[playerid],0x000000ff);
	TextDrawFont(LevelText[playerid],2);
	TextDrawLetterSize(LevelText[playerid],0.299999,1.400000);
	TextDrawColor(LevelText[playerid],0x00ff0099);
	TextDrawSetOutline(LevelText[playerid],1);
	TextDrawSetProportional(LevelText[playerid],1);
	TextDrawSetShadow(LevelText[playerid],1);
	return 1;
}
public OnPlayerDisconnect(playerid, reason){
	TextDrawDestroy(ExpText[playerid]);
	TextDrawDestroy(ExpText[playerid]);
	#if defined UseProgBar
	DestroyProgressBar(bar[playerid]);
	#endif
	Delete3DTextLabel(LevelLabel[playerid]);
	Retries[playerid] = 0;
	if(logged_in[playerid] == 1){
		new pfile[100], pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, pname, sizeof(pname));
		format(pfile, sizeof(pfile), "HAccounts/%s.ini",pname);
		dini_IntSet(pfile, "Cash", GetPlayerMoney(playerid));
		dini_IntSet(pfile, "Score", GetPlayerScore(playerid));
	}
    logged_in[playerid] = 0;
	SendDeathMessage(INVALID_PLAYER_ID, playerid, 201);
	return 1;
}
public OnPlayerDeath(playerid, killerid, reason){
	if (killerid != playerid) {
	    if (GetPlayerExpLevel(playerid) < GetPlayerExpLevel(killerid)) {
    		GivePlayerExp(killerid, 100, "killing a lower level player");
	    }
	    else if (GetPlayerExpLevel(playerid) > GetPlayerExpLevel(killerid)){
	    	GivePlayerExp(killerid, 300, "killing a higher level player");
	    }
	    else{
	    	GivePlayerExp(killerid, 200, "killing a player at your own level");
	    }
	} // An example of using my exp system.
	return 1;
}
public OnPlayerRequestSpawn(playerid){
	if (logged_in[playerid] == 0){
		SendClientMessage(playerid, 0xFF00FFFF, "*You need to login to spawn.*");
		return 0;
	}
	else{
		return 1;
	}
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]){
	if(dialogid == 101){
		if(!strlen(inputtext) || !response) return ShowPlayerDialog(playerid,101,DIALOG_STYLE_INPUT,"Registration","ERROR: You did not enter a password.\nPlease enter a password to register this account!","Register","Cancel");
	    new pfile[128], pname[MAX_PLAYER_NAME], string2[64], string3[32];
		GetPlayerName(playerid, pname, sizeof(pname));
		format(pfile, sizeof(pfile), "HAccounts/%s.ini",pname);
		new playerip[20];
		GetPlayerIp(playerid, playerip, sizeof(playerip));
		dini_Create(pfile);
  		dini_IntSet(pfile, "Password", udb_hash(inputtext));
		dini_Set(pfile, "Ip", playerip);
		dini_IntSet(pfile, "Cash", 0);
		dini_IntSet(pfile, "ExpLevel", 1);
		dini_IntSet(pfile, "Exp", 0);
		dini_IntSet(pfile, "TotalExp", ExpForLevel);
		dini_IntSet(pfile, "Score", 0);
		logged_in[playerid] = 1;
		SendClientMessage(playerid, 0x00FF00FF, "*You have been registered! You have also been logged in!*");
		format(string2, sizeof(string2), "Exp: %05d/%05d",dini_Int(pfile, "Exp"), dini_Int(pfile, "TotalExp"));
		TextDrawSetString(ExpText[playerid], string2);
 		format(string3, sizeof(string3), "Level: %02d",dini_Int(pfile, "ExpLevel"));
		TextDrawSetString(LevelText[playerid], string3);
		TextDrawShowForPlayer(playerid, ExpText[playerid]);
		TextDrawShowForPlayer(playerid, LevelText[playerid]);
		#if defined UseProgBar
		ShowProgressBarForPlayer(playerid, bar[playerid]);
		SetProgressBarMaxValue(bar[playerid], dini_Int(pfile, "TotalExp"));
		SetProgressBarValue(bar[playerid], dini_Int(pfile, "Exp"));
		UpdateProgressBar(bar[playerid], playerid);
		#endif
		LevelLabel[playerid] = Create3DTextLabel(string3, TextLabelColor, 0, 0, 0, 50, 0);
		Attach3DTextLabelToPlayer(LevelLabel[playerid], playerid, 0, 0, 0.7);
	}
	if(dialogid == 100){
		if(!strlen(inputtext) || !response) return ShowPlayerDialog(playerid,100,DIALOG_STYLE_INPUT,"Login","ERROR: You did not enter a password.\nPlease enter a password to login to this account!","Login","Cancel");
		new pfile[100], pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, pname, sizeof(pname));
		format(pfile, sizeof(pfile), "HAccounts/%s.ini",pname);
		new tmp[256];
		tmp = dini_Get(pfile, "Password");
	    if(udb_hash(inputtext) == strval(tmp)){
			new playerip[20], string[32];
			GetPlayerIp(playerid, playerip, sizeof(playerip));
			dini_Set(pfile, "Ip", playerip);
			GivePlayerMoney(playerid, dini_Int(pfile, "Cash"));
			SetPlayerScore(playerid, dini_Int(pfile, "Score"));
			logged_in[playerid] = 1;
			SendClientMessage(playerid, 0x00FF00FF, "*You have been logged in!*");
			TextDrawShowForPlayer(playerid, ExpText[playerid]);
			TextDrawShowForPlayer(playerid, LevelText[playerid]);
			#if defined UseProgBar
			SetProgressBarValue(bar[playerid], dini_Int(pfile, "Exp"));
			SetProgressBarMaxValue(bar[playerid], dini_Int(pfile, "TotalExp"));
			UpdateProgressBar(bar[playerid], playerid);
			#endif
		  	format(string, sizeof(string), "Level: %02d",dini_Int(pfile, "ExpLevel"));
			LevelLabel[playerid] = Create3DTextLabel(string, TextLabelColor, 0, 0, 0, 50, 0);
			Attach3DTextLabelToPlayer(LevelLabel[playerid], playerid, 0, 0, 0.7);
		}
		else
		{
			ShowPlayerDialog(playerid,100,DIALOG_STYLE_INPUT,"Login","ERROR: Invalid Password.\nPlease enter a password to login to this account!","Login","Cancel");
			Retries[playerid]++;
			if (Retries[playerid] == 5)
			{
				SendClientMessage(playerid, 0xFF0000, "*You have been kicked for 5 incorrect password inputs.*");
				Kick(playerid);
			}
		}
	}
	return 1;
}
