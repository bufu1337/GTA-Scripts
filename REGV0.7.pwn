/*
Scripted by: Park4Bmx
Version: mReg[V0.7.2]

UPDATE:
AutoLogin has been move becouse of causing LAGG
Some Bugs [FIXED]
Added NEW Ajustments
OnPlayerDisconnect Saving [FIXED]
Added/Removed A Few functions to prevent bugs
Added new Command [/Recconect] this is no FAKE command it Recconects _
the player just like if he will Exit & Enter.
Now You Dont Have To LogIn After Register.
Server Messages Have Been Impruved.
*/

#include <a_samp>
#include <sscanf2>
#include <YSI\y_ini>
#include <dudb>
#pragma unused ret_memcpy
#define FILTERSCRIPT
#if defined FILTERSCRIPT
#define Register 987
#define Login 988
#define WELCOME3 989
#define WELCOME2 999
#define WELCOME1 810
#define Register1 811
#define Register2 812
#define SkinSave 813
#define AutoLog 814
#define IPChange1 815
#define IPChange2 816
#define RestorPos 817
#define STATUS 818
#define PMMSG 819
#define COLOR_GREEN 0x00FF00FF
#define COLOR_RED 0xFF0000FF
#define COLOR_RED2 0xA50047FF
#define COLOR_GREEN2 0x18FF18FF
#define COLOR_BLUE 0x0000FFFF
#define COLOR_BLUE2 0x33CCFFAA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BRIGHTRED 0xFF0000AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_BRIGHTBLUE 0x0096FFFF
#define WHITE "{FFFFFF}"
#define GREEN "{00B000}"
#define BLUE "{0025E1}"
#define RED "{FF0000}"
#define ORANGE "{FF7E19}"
#define YELLOW "{FF9E00}"
#define LIGHTBLUE "{4290FE}"
#define MIN_PASS_CHAR           	   4 //The minimum password characters
#define MAX_SCORE_ALLOWED          10000 //The Maximum Score Allowed To Set With /SetScore (For admins)
#define MAX_MONEY_ALLOWED     	   50000 // The Maximum Money Allowed To Give To A Player (For admins)
#define ALLOW_ADMIN_TELE      	    true // "true" doesnt allowe lower level admins to teleport higher level admins to them|"false" allows lower level admins to teleport higher level admins to them.
#define ALLOW_ADMIN_HP       	   false // "false" doesnt allowe lower level admins to /SetHp to hiher level admins|"true" allowes lower level admins to /SetHp to higher level admins.
#define ALLOW_ADMIN_GUN      	    true // "false" doesnt allowe lower level adminst to /GiveGun to hiher level admins|"true" allowes lower level admins to /GiveGun to higher level admins.
#define ALLOW_RESPAWN       	   false // "false" Hides the respawn BOX when the players spawns | "true" Shows the respawn BOS when the plater spawns.
#define AUTO_SAVE       	       true  // "false" Will Disable the Auto Save | "true" Will Enable the Auto Save
#define AUTO_SAVE_TIMER            10000 //(10sec) This is the time the server will run a Auto Save (NOTE: the time is in milliseconds)
#define FILE_CHECK       	       true  // "true" Will Enable the File Check(it will print the results in the Consol) | "false" Will Disable the File Check |
#define SERVER_NAME   	   "MADE BY: PARK4BMX" // Put HERE your Server Name !!!
#define MIN_PM_CHARACTERS              5 // Minimum "Personal Message" Characters
new Float:RandomJail[1][3] = {
{197.83348083496,174.56066894531,1004.0968017578}
};
forward OnPlayerLogin(playerid);
forward LoadUser(playerid, name[], value[]);
forward LoadUserSettings(playerid, name[], value[]);
forward PlayerPassword(playerid, name[], value[]);
forward PlayerAdminLevel(playerid, name[], value[]);
forward LoadUserIp(playerid, name[], value[]);
forward LoadAutoLog(playerid, name[], value[]);
forward TimeOnServer(playerid);
forward LoadStatus(playerid);
forward SaveStatus(playerid);
forward RunAutoSave(playerid);
forward ResetSettings(playerid);
forward IsLoggedTimer();

enum pInfo
{
	PlayerAdmin,
	Deaths,
	Kills,
	ServerTime,
	Money,
	WantedLevel,
	DrunkLevel,
	FightingStyle,
	Float:posx,
    Float:posy,
    Float:posz,
    AutoLogin,
    SaveSkin,
SavePosition,
Score
}
new PlayerInfo[MAX_PLAYERS][pInfo];
new IsLogged[MAX_PLAYERS];
new pmplayerid;
new TimeTimer;
new rip[MAX_PLAYERS][16];
new Warning[MAX_PLAYERS];
new Pname[MAX_PLAYER_NAME];
new playrname[MAX_PLAYER_NAME];
new giveplayerid;
new giveplayer[MAX_PLAYER_NAME];
new Float:x, Float:y, Float:z;
new Mute[MAX_PLAYERS];
new PlayerOldPassword[MAX_PLAYERS];
new AutoSaveTimer[MAX_PLAYERS];
new PlayerReconnecting[MAX_PLAYERS];
new PlayerColors[200] = {
0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,
0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,
0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,
0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,0x3D0A4FFF,
0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,0x057F94FF,
0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,
0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,
0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,
0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,
0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,0xDCDE3DFF,
0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,
0xD8C762FF,0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,
0xF4A460FF,0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,
0x10DC29FF,0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,
0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,
0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,
0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,
0x18F71FFF,0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,
0x12D6D4FF,0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,
0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,
0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,
0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,
0xD8C762FF,0xD8C762FF
};
public OnFilterScriptInit(){
#if FILE_CHECK == true
	print("\n\n=========================================");
	print("||   mRegistration System by:Park4Bmx  ||");
	print("||             Version 0.7             ||");
	print("=========================================\n");
	print("\n====mREGv0.7=============================");
	print("||   Checking ScriptFiles....         ||");
	print("||       0/3 Complete                 ||");
	print("=========================================\n");
	if(fexist("/mRegistration/")){
		print("\n====mREGv0.7=============================");
		print("||   Checking ScriptFiles....         ||");
		print("||       1/3 Complete                 ||");
		print("=========================================\n");
	}
	else{
		print("\n====mREGv0.7=============================");
		print("||   Checking ScriptFiles.|FAILED|    ||");
		print("||  FOLDER |mRegistration| IS MISSING ||");
		print("=========================================\n");
	}
	if(fexist("/mRegistration/Settings/")){
		print("\n====mREGv0.7=============================");
		print("||   Checking ScriptFiles....         ||");
		print("||       2/3 Complete                 ||");
		print("=========================================\n");
	}
	else{
		print("\n====mREGv0.7=============================");
		print("||   Checking ScriptFiles.FAILED|     ||");
		print("||  FOLDER |Settings| IS MISSING      ||");
		print("=========================================\n");
	}
	if(fexist("/mRegistration/Users/")){
		print("\n====mREGv0.7=============================");
		print("||   Checking ScriptFiles....         ||");
		print("||       3/3 Complete                 ||");
		print("=========================================\n");
	}
	else{
		print("\n====mREGv0.7=============================");
		print("||   Checking ScriptFiles.FAILED|     ||");
		print("||  FOLDER |Users| IS MISSING         ||");
		print("=========================================\n");
	}
	return 1;
#endif
}
public OnFilterScriptExit(){
#if FILE_CHECK == true
	print("\n====mREGv0.7=============================");
	print("||            Was Unloaded            ||");
	print("=========================================\n");
#endif
}
public OnPlayerConnect(playerid){
	ResetSettings(playerid);
	SetPlayerColor(playerid, PlayerColors[playerid]);
	TogglePlayerSpectating(playerid, 1);
	IsLogged[playerid] = 0;
	new file[128], string[128],name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
	if(!fexist(file)){
		ShowPlayerDialog(playerid, WELCOME1, DIALOG_STYLE_MSGBOX, " ", ""WHITE"Welcome to "BLUE""SERVER_NAME"", "Skip", "Register");
	}
	if(fexist(file)){
		format(file,sizeof(file),"/mRegistration/Settings/%s.txt",name);
		INI_ParseFile(file, "LoadAutoLog", false, true, playerid, true, false);
		PlayerInfo[playerid][AutoLogin] = GetPVarInt(playerid,"AutoLog");
		if(PlayerInfo[playerid][AutoLogin] == 0){
			ShowPlayerDialog(playerid, WELCOME2, DIALOG_STYLE_MSGBOX, ""WHITE"Welcome to "BLUE""SERVER_NAME"", ""WHITE"Use "GREEN"/AutoLog "WHITE"so you can automatically login next time", "Skip", "Login");
		}
		else if(PlayerInfo[playerid][AutoLogin] >= 1){
	    	format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
			INI_ParseFile(file, "LoadUserIp", false, true, playerid, true, false );
			GetPlayerIp(playerid,rip[playerid],16);
	   		new IPa[80]; GetPVarString(playerid, "pIP", IPa, sizeof IPa);
	 		if(!strcmp(rip[playerid],IPa,true)){
				LoadStatus(playerid);
				TogglePlayerSpectating(playerid, 0);
	    		SetTimer("IsLoggedTimer",1500,false);
				SpawnPlayer(playerid);
				format(string, sizeof(string), ""YELLOW"[SERVER] "GREEN"%s "WHITE"Has Successfully Loged In",name );
				SendClientMessageToAll(COLOR_GREEN2, string);
				printf("%s Has Logged Into His Account", name);
			}
			else{
				format(string, sizeof string, ""WHITE"Your IP doesn't match with Username: "BLUE"%s "WHITE"\nYou can login by entering your password", name);
				ShowPlayerDialog(playerid, Login, DIALOG_STYLE_MSGBOX, ""RED"Login Failed", string, "OK", "Cancel");
			}
		}
		return 1;
	}
	return 0;
}
public OnPlayerSpawn(playerid){
   new file[128], name[MAX_PLAYER_NAME];
   GetPlayerName(playerid, name, sizeof(name));
   format(file,sizeof(file),"/mRegistration/Settings/%s.txt",name);
   if(fexist(file)){
	   #if ALLOW_RESPAWN == true
	   INI_ParseFile(file, "LoadUserSettings", false, true, playerid, true, false );
	   if(PlayerInfo[playerid][SavePosition] >= 1){
		 ShowPlayerDialog(playerid,RestorPos ,DIALOG_STYLE_MSGBOX,""BLUE"Restor Position?",""WHITE"Do you want to restore your position from last time ?","Yes","No");
	   }
	   #endif
	   if(PlayerInfo[playerid][SaveSkin] == 1){
		   format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
		   INI_ParseFile(file, "LoadUser", false, true, playerid, true, false );
		   SetPlayerSkin(playerid,GetPVarInt(playerid,"Skins"));
	   }
   }
   return 1;
}
public OnPlayerLogin(playerid){
	#if AUTO_SAVE == true
	AutoSaveTimer[playerid] = SetTimerEx("RunAutoSave", AUTO_SAVE_TIMER, true, "i", playerid);
	#endif
	return 1;
}
public LoadUser(playerid, name[], value[]){
	if(!strcmp(name, "Score"))SetPVarInt(playerid,"Score", strval(value ));
	if(!strcmp(name, "Money"))SetPVarInt(playerid,"Money", strval(value));
	if(!strcmp(name, "Deaths"))SetPVarInt(playerid,"Deaths", strval(value ));
	if(!strcmp(name, "Kills"))SetPVarInt(playerid,"Kills", strval(value ));
	if(!strcmp(name, "WantedLevel"))SetPVarInt(playerid,"WantedLevel", strval(value ));
	if(!strcmp(name, "ServerTime"))SetPVarInt(playerid,"ServerTime", strval(value ));
	if(!strcmp(name, "FightingStyle"))SetPVarInt(playerid,"FightingStyle", strval(value ));
}
public LoadUserSettings(playerid, name[], value[]){
	if(!strcmp(name, "PlayerAdmin"))SetPVarInt(playerid,"PlayerAdmin", strval(value ));
	if(!strcmp(name, "SavePosition"))SetPVarInt(playerid,"SavePosition", strval(value ));
	if(!strcmp(name, "AutoLog"))SetPVarInt(playerid,"AutoLog", strval(value ));
	if(!strcmp(name, "SaveSkin"))SetPVarInt(playerid,"SaveSkin", strval(value ));
}
public PlayerPassword(playerid, name[], value[]){
	if (!strcmp( name, "Password" ) ){
		SetPVarString(playerid, "pPass", value);
	}
}
public PlayerAdminLevel(playerid, name[], value[]){
	if(!strcmp(name, "PlayerAdmin"))SetPVarInt(playerid,"PlayerAdmin", strval(value ));
}
public LoadUserIp(playerid, name[], value[]){
if(!strcmp(name,"IP")){SetPVarString(playerid, "pIP", value);}
}
public LoadAutoLog(playerid, name[], value[]){
if(!strcmp(name, "AutoLog"))SetPVarInt(playerid,"AutoLog", strval(value ));
}
public OnPlayerDisconnect(playerid, reason){
	if(PlayerReconnecting[playerid]==1){
		new string[8+16];
	 	GetPVarString(playerid, "pIp", string, 16);
		format(string, sizeof(string), "unbanip %s", string);
		SendRconCommand(string);
	}
	SaveStatus(playerid);
	ResetSettings(playerid);
	IsLogged[playerid] = 0;
	KillTimer(TimeTimer);
	KillTimer(AutoSaveTimer[playerid]);
	return 1;
}
public OnPlayerDeath(playerid, killerid){
	new file[128], name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
	new INI:Acc = INI_Open(file);
	if(fexist(file)){
	INI_WriteInt(Acc,"Score",GetPlayerScore(playerid));
	INI_WriteInt(Acc,"Money",GetPlayerMoney(playerid));
	#if ALLOW_RESPAWN == true
	GetPlayerPos(playerid,x,y,z);
	PlayerInfo[playerid][posx] = x;
	PlayerInfo[playerid][posy] = y;
	PlayerInfo[playerid][posz] = z;
	INI_WriteInt(Acc,"posx",PlayerInfo[playerid][posx]));
	INI_WriteInt(Acc,"posy",PlayerInfo[playerid][posy]));
	INI_WriteInt(Acc,"posz",PlayerInfo[playerid][posz]));
	#endif
	}
	PlayerInfo[playerid][Deaths] ++;
	PlayerInfo[killerid][Kills] ++;
	return 1;
}
public TimeOnServer(playerid){
	PlayerInfo[playerid][ServerTime] ++;
}
public OnPlayerText(playerid,text[]){
	if(Mute[playerid] == 1){
		SendClientMessage(playerid,COLOR_RED,"You Cant Use The Chat You Have Been Muted");
		return 0;
	}
	if(PlayerInfo[playerid][PlayerAdmin] >= 1){
	    new string[128],name[MAX_PLAYER_NAME];
	    GetPlayerName(playerid,name,sizeof(name));
	    format(string,sizeof(string),"[ADMIN] %s: "WHITE"%s",name,text);
	    SendClientMessageToAll(GetPlayerColor(playerid), string);
	    return 0;
	}
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[]){
//-AdminCommands-//
new cmd[256];
new idx;
cmd = strtok(cmdtext, idx);
new tmp[256];
if(strcmp(cmd, "/admincmds", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] == 0) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	if(PlayerInfo[playerid][PlayerAdmin] == 1) ShowPlayerDialog(playerid,20 ,DIALOG_STYLE_MSGBOX,"Admin CMDS","{55B500}Level [1] Admin CMDS {FFFFEB}\n/A =Chat to admins\n/spec =Spectate Player \n/disarm = Remove player weapons \n/noon =Set the time to [12] \n/night = Set the time to [24] \n/cc =Clear The Chat","Cancel","OK");
	if(PlayerInfo[playerid][PlayerAdmin] == 2) ShowPlayerDialog(playerid,21 ,DIALOG_STYLE_MSGBOX,"Admin CMDS","{55B500}Level [2] Admin CMDS {FFFFEB}\n/A =Chat to admins\n/spec =Spectate Player \n/freeze = freeze player from moving \n/disarm = Remove player weapons\n/noon =Set the time to [12] \n/night = Set the time to [24] \n/cc =Clear The Chat \n/sethp =Set Player Health","Cancel","OK");
	if(PlayerInfo[playerid][PlayerAdmin] == 3) ShowPlayerDialog(playerid,22 ,DIALOG_STYLE_MSGBOX,"Admin CMDS","{55B500}Level [3] Admin CMDS {FFFFEB}\n/fake\n/A\n/setscore\n/spec\n/freeze\n/disarm\n/givemoney\n/noon\n/night\n/cc\n/sethp\n/ann\n/givegun","Cancel","OK");
	if(PlayerInfo[playerid][PlayerAdmin] == 4) ShowPlayerDialog(playerid,23 ,DIALOG_STYLE_MSGBOX,"Admin CMDS","{55B500}Level [4] Admin CMDS {FFFFEB}\n/Mute\n/UnMute\n/setskin\n/settime\n/eject\n/fake\n/A\n/killall\n/setscore\n/kick\n/spec\n/freeze\n/disarm\n/givemoney\n/noon \n/night\n/cc\n/sethp\n/ann\n/givegun\n/goto\n/gethere","Cancel","OK");
	if(PlayerInfo[playerid][PlayerAdmin] == 5) ShowPlayerDialog(playerid,24 ,DIALOG_STYLE_MSGBOX,"Admin CMDS","{55B500}Level [5] Admin CMDS {FFFFEB}\n/Mute\n/UnMute\n/setskin\n/settime\n/eject\n/setweather\n/jail\n/UnJail\n/fake\n/A\n/killall\n/setscore\n/kick\n/spec\n/freeze\n/disarm\n/givemoney\n/goto\n/gethere\n/ann\n/sethp\n/givegun\n/cc\n/Night\n/Noon","Cancel","OK");
	if(PlayerInfo[playerid][PlayerAdmin] == 6) ShowPlayerDialog(playerid,25 ,DIALOG_STYLE_MSGBOX,"Admin CMDS","{55B500}Level [6] Admin CMDS {FFFFEB}\n/Mute\n/UnMute\n/setskin\n/settime\n/eject\n/setweather\n/jail\n/UnJail/fake\n/A\n/killall\n/setscore\n/kick\n/spec\n/freeze\n/disarm\n/givemoney\n/makeadmin \n/goto\n/gethere\n/ann\n/sethp\n/givegun\n/cc\n/Night\n/Noon","Cancel","OK");
	if(PlayerInfo[playerid][PlayerAdmin] >= 7) ShowPlayerDialog(playerid,25 ,DIALOG_STYLE_MSGBOX,"Admin CMDS","{55B500}Level [7] Admin CMDS {FFFFEB}\n/Reconnect\n/Mute\n/UnMute\n/setskin\n/settime\n/eject\n/setweather\n/jail\n/UnJail/fake\n/A\n/killall\n/setscore\n/kick\n/spec\n/freeze\n/disarm\n/givemoney\n/makeadmin \n/goto\n/gethere\n/ann\n/sethp\n/givegun\n/cc\n/Night\n/Noon","Cancel","OK");
	return 1;
}
if(strcmp(cmd, "/mute", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] <= 4) return SendClientMessage(playerid,COLOR_RED,"You Cant Use This Command !!!");
	tmp = strtok(cmdtext, idx);
	new muteplayer = strval(tmp);
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"USAGE: "GREEN"/Mute "WHITE"[playerid]");
	if(Mute[muteplayer] == 1) return SendClientMessage(COLOR_RED,playerid, "Player Already Muted");
	Mute[muteplayer] = 1;
	new string [140 + MAX_PLAYER_NAME] ,AdminName[MAX_PLAYER_NAME],OtherName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,AdminName,sizeof(AdminName));
	GetPlayerName(muteplayer,OtherName,sizeof(OtherName));
	format(string,sizeof(string),"%s Muted %s",AdminName,OtherName);
	SendClientMessageToAll(COLOR_RED,string);
	return 1;
}
if(strcmp(cmd, "/unmute", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] <= 4) return SendClientMessage(playerid,COLOR_RED,"You Cant Use This Command !!!");
	tmp = strtok(cmdtext, idx);
	new muteplayer = strval(tmp);
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"USAGE: "GREEN"/UnMUte "WHITE"[playerid]");
	if(Mute[muteplayer] == 0) return SendClientMessage(COLOR_RED,playerid, "Player Already UnMounted");
	Mute[muteplayer] = 0;
	new string [140 + MAX_PLAYER_NAME] ,AdminName[MAX_PLAYER_NAME],OtherName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,AdminName,sizeof(AdminName));
	GetPlayerName(muteplayer,OtherName,sizeof(OtherName));
	format(string,sizeof(string),"%s UnMuted %s",AdminName,OtherName);
	SendClientMessageToAll(COLOR_YELLOW,string);
	return 1;
}
if(strcmp(cmd, "/warn", true)==0){
	cmd = strtok(cmdtext, idx);
	if(PlayerInfo[playerid][PlayerAdmin] <= 2) return SendClientMessage(playerid,COLOR_RED,"You Cant Use This Command !!!");
	tmp = strtok(cmdtext, idx);
	new otherplayer = strval(tmp);
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"USAGE: "GREEN"/Warn "WHITE"[playerid] {EB0000}[WARNINNG]");
	new length = strlen(cmdtext);
	while ((idx < length) && (cmdtext[idx] <= ' ')){
	  idx++;
	}
	new offset = idx;
	new result[80];
	new string[128];
	while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))){
	  result[idx - offset] = cmdtext[idx];
	  idx++;
	}
	result[idx - offset] = EOS;
	if(otherplayer == playerid) return SendClientMessage(playerid, COLOR_BRIGHTRED, "You can't Warn yourself !");
	if(!strlen(result)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"USAGE: "GREEN"/Warn "GREEN"[playerid] "WHITE"[WARNINNG]");
	if(!IsPlayerConnected(otherplayer)) return SendClientMessage(playerid, COLOR_WHITE, "Invalid Player ID.");
	GetPlayerName(playerid, playrname, sizeof(playrname));
	GetPlayerName(otherplayer, playrname, sizeof(playrname));
	format(string,sizeof(string),"!!WARNING!! was send to %s.",playrname);
	SendClientMessage(playerid, COLOR_GREEN, string);
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	GetPlayerName(otherplayer, playrname, sizeof(playrname));
	if(IsPlayerConnected(otherplayer)){
		format(string,sizeof(string),"!!WARNING!! from \"%s\" {014CEB}[%s]",name,playerid,result);
		SendClientMessage(otherplayer,COLOR_RED,string);
	}
	for(new i=0;i<MAX_PLAYERS;i++){
		if(IsPlayerConnected(i) && PlayerInfo[i][PlayerAdmin] >= 7){
			format(string,sizeof(string),"{EB0000}!!WARNING!! FROM: \"{014CEB}%s{EB0000}\"{014CEB}(%d){EB0000} TO: \"{014CEB}%s{EB0000}\"{014CEB}(%d){EB0000} WARNING: "WHITE"%s",name,playerid,playrname,otherplayer,result);
			SendClientMessage(i,COLOR_RED,string);
		}
	}
	return 1;
}
if(strcmp(cmd, "/setweather", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] <= 4) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	tmp = strtok(cmdtext, idx);
	new weather = strval(tmp);
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/setweather"WHITE" [Weather ID]");
	new name[MAX_PLAYER_NAME], string[138];
	GetPlayerName(playerid,name,sizeof(name));
	format(string,sizeof(string),"[ADMIN] %s Has set the time to [%d]",name,weather);
	SendClientMessageToAll(COLOR_YELLOW, string);
	SetWeather(weather);
	return 1;
}
if(strcmp(cmd, "/eject", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] < 4) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	tmp = strtok(cmdtext, idx);
	new otherplayer = ReturnUser(tmp);
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/eject "WHITE"[playerid]");
	if(!IsPlayerConnected(otherplayer)) return SendClientMessage(playerid,COLOR_WHITE, "Invalid Player ID.");
	RemovePlayerFromVehicle(otherplayer);
	new name[MAX_PLAYER_NAME], string[138];
	GetPlayerName(playerid,name,sizeof(name));
	format(string,sizeof(string),"[ADMIN] %s Ejected you from the vehicle",name);
	SendClientMessage(otherplayer, COLOR_YELLOW, string);
	return 1;
}
if(strcmp(cmd, "/settime", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] < 5) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	tmp = strtok(cmdtext, idx);
	new time;
	time = strval(tmp);
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/settime"WHITE" [0-24]");
	new name[MAX_PLAYER_NAME], string[138];
	GetPlayerName(playerid,name,sizeof(name));
	format(string,sizeof(string),"[ADMIN] %s Has set the time to [%d]",name,time);
	SendClientMessageToAll(COLOR_YELLOW, string);
	SetWorldTime(time);
	return 1;
}
if(strcmp(cmd, "/setmytime", true)==0){
	tmp = strtok(cmdtext, idx);
	new time;
	time = strval(tmp);
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/settime"WHITE" [0-24]");
	new string[138];
	format(string,sizeof(string),"You Set Your Time To [%d]",time);
	SendClientMessage(playerid,COLOR_YELLOW, string);
	SetPlayerTime(playerid,time,0);
	return 1;
}
if(strcmp(cmd, "/setskin", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] <= 3) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	new tmp2[256];
	tmp = strtok(cmdtext, idx);
	new otherplayer = strval(tmp);
	tmp2 = strtok(cmdtext, idx);
	new skin = strval(tmp2);
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/setskin {FF6200}[playerid]"WHITE" [skinid]");
	if(!strlen(tmp2)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/setskin "GREEN"[playerid]"WHITE" [skinid]");
	if(!IsPlayerConnected(otherplayer)) return SendClientMessage(playerid, COLOR_RED, "Invalid Player ID.");
	SetPlayerSkin(otherplayer, skin);
	new name[MAX_PLAYER_NAME],string[138];
	GetPlayerName(playerid,name,sizeof(name));
	format(string,sizeof(string),"[ADMIN] %s Has set your skin to [%d]",name,skin);
	SendClientMessage(otherplayer, COLOR_YELLOW, string);
	return 1;
}
if(strcmp(cmd, "/jail", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] <= 4) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	if(!strlen(cmdtext[6])){
	    SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/jail "WHITE"[playerid]");
	    return 1;
	}
	new ID = strval(cmdtext[6]);
	new string[128];
	if(IsPlayerConnected(ID)){
	    new name[MAX_PLAYER_NAME],otherplayer[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, name, sizeof(name));
	    format(string,sizeof(string),"You have been jailed by "BLUE"[ADMIN] %s",name);
	    SendClientMessage(ID,COLOR_RED, string);
	    GetPlayerName(ID, otherplayer, sizeof(otherplayer));
	    format(string,sizeof(string),""BLUE"%s "RED"has been jailed by "BLUE"[ADMIN] %s",otherplayer,name);
	    SendClientMessageToAll(COLOR_RED,string);
	    new rand = random(sizeof(RandomJail));
	    SetPlayerPos(ID, RandomJail[rand][0], RandomJail[rand][1], RandomJail[rand][2]);
	    ResetPlayerWeapons(ID);
	    SetPlayerInterior(ID, 3);
	}
	return 1;
}
if(strcmp(cmd, "/unjail", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] < 5) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	if(!strlen(cmdtext[8])){
	    SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/UnJail "WHITE"[playerid]");
	    return 1;
	}
	new ID = strval(cmdtext[8]);
	new string[128];
	if(IsPlayerConnected(ID)){
	    new name[MAX_PLAYER_NAME],otherplayer[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, name, sizeof(name));
	    format(string,sizeof(string),"You have been UnJailed by "BLUE"[ADMIN] %s",name);
	    SendClientMessage(ID,COLOR_WHITE, string);
	    GetPlayerName(ID,otherplayer, sizeof(otherplayer));
	    format(string,sizeof(string),""BLUE"%s "WHITE"has been UnJailed by "BLUE"[ADMIN] %s",otherplayer,name);
	    SendClientMessageToAll(COLOR_YELLOW,string);
	    SpawnPlayer(ID);
	    SetPlayerInterior(ID,0);
	}
	return 1;
}
if(strcmp(cmd, "/fake", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] < 3) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	tmp = strtok(cmdtext, idx);
	new otherplayer = strval(tmp);
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/fake "WHITE"[playerid] [FAKE-MSG]");
	new length = strlen(cmdtext);
	while ((idx < length) && (cmdtext[idx] <= ' ')){
		idx++;
	}
	new offset = idx;
	new result[80];
	new string[128];
	while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))){
		result[idx - offset] = cmdtext[idx];
		idx++;
	}
	result[idx - offset] = EOS;
	if(PlayerInfo[otherplayer][PlayerAdmin] > PlayerInfo[playerid][PlayerAdmin]) return SendClientMessage(playerid,COLOR_RED," You can't use this to a higher level Admin !");
	if(!strlen(result)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/fake "GREEN"[playerid] "WHITE"[FAKE-MSG]");
	if(!IsPlayerConnected(otherplayer)) return SendClientMessage(playerid, COLOR_WHITE, "Invalid Player ID.");
	if(otherplayer == playerid) return SendClientMessage(playerid, COLOR_BRIGHTRED, "You can't FAKE yourself !");
	GetPlayerName(playerid, playrname, sizeof(playrname));
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	GetPlayerName(otherplayer, playrname, sizeof(playrname));
	if(IsPlayerConnected(otherplayer)){
	format(string,sizeof(string),"%s",result);
	SendPlayerMessageToAll(otherplayer, string);
	}
	return 1;
}
if(strcmp(cmd, "/kick", true)==0){
	new string[208 + MAX_PLAYER_NAME],PlayerN[MAX_PLAYERS],OtherN[MAX_PLAYERS];
	if(PlayerInfo[playerid][PlayerAdmin] <= 4) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	tmp = strtok(cmdtext, idx);
	giveplayerid = ReturnUser(tmp);
	if(PlayerInfo[playerid][PlayerAdmin] >= 5){
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/kick {FF6200}[playerid] "WHITE"[REASON]");
		if(giveplayerid == playerid) return SendClientMessage(playerid, COLOR_BRIGHTRED, "You can't kick yourself !");
		if(PlayerInfo[playerid][PlayerAdmin] < PlayerInfo[giveplayerid][PlayerAdmin]) return SendClientMessage(playerid, COLOR_BRIGHTRED, "You can't Kick a higher level Admin !");
		if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "Invalid Player ID.");
		if(cmdtext[8] <= 6) return SendClientMessage(playerid, COLOR_RED, "Your Reason Needs To Be More Than 6 Characters");
		Kick(giveplayerid);
		GetPlayerName(playerid,PlayerN,sizeof(PlayerN));
		GetPlayerName(giveplayerid,OtherN,sizeof(OtherN));
		format(string, sizeof(string), ""BLUE"\"%s\""RED" was kicked by Admin "BLUE"\"%s\""RED" Reason: %s", OtherN, PlayerN,cmdtext[8]);
		SendClientMessageToAll(COLOR_BRIGHTRED, string);
		printf("\"%s\"Was Kicked By Admin \"%s\" Reason %s",OtherN, PlayerN,cmdtext[8]);
	}
	return 1;
}
if(strcmp(cmd, "/ban", true)==0){
	new string[308];
	if(PlayerInfo[playerid][PlayerAdmin] < 5) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	if(PlayerInfo[playerid][PlayerAdmin] >= 5){
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/ban "WHITE"[playerid] "WHITE"[REASON]");
		giveplayerid = ReturnUser(tmp);
		if(PlayerInfo[playerid][PlayerAdmin] < PlayerInfo[giveplayerid][PlayerAdmin]) return SendClientMessage(playerid, COLOR_BRIGHTRED, "You can't Ban a higher level Admin !");
		if(giveplayerid == playerid) return SendClientMessage(playerid, COLOR_BRIGHTRED, "You can't ban yourself !");
		if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "Invalid Player ID.");
		if(cmdtext[7] <= 6) return SendClientMessage(playerid, COLOR_YELLOW, "You Reason Must Be More Than 6 Characters");
		BanEx(giveplayerid, "Request" );
		new OtherN[MAX_PLAYER_NAME], PlayerN[MAX_PLAYER_NAME];
		GetPlayerName(giveplayerid, OtherN, sizeof(OtherN));
		GetPlayerName(playerid, PlayerN, sizeof(PlayerN));
		format(string, sizeof(string), ""BLUE"\"%s\""RED" Was Banned By Admin "BLUE"\"%s\" "RED"Reason: %s",PlayerN, OtherN,cmdtext[7]);
		SendClientMessageToAll(COLOR_BRIGHTRED, string);
		printf("\"%s\"Was Banned By Admin \"%s\"",PlayerN, OtherN,cmdtext[7]);
		new file2[30],file[30];
		format(file,sizeof(file),"/mRegistration/Settings/%s.txt",OtherN);
		format(file2,sizeof(file2),"/mRegistration/Users/%s.txt",OtherN);
		new INI:Acc = INI_Open(file);
		INI_RemoveEntry(Acc, file);
		INI_Close(Acc);
		new INI:Acc2 = INI_Open(file2);
		INI_RemoveEntry(Acc2, file2);
		INI_Close(Acc2);
		}
	return 1;
}
if(strcmp(cmd, "/unban", true)==0){
	new UnBanIp[60],IpAdd[88];
	if(PlayerInfo[playerid][PlayerAdmin] < 5) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	if(PlayerInfo[playerid][PlayerAdmin] >= 6){
		if(cmdtext[7] <=5) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/UnBan "WHITE"[IP: ADDRESS]");
		if(cmdtext[7] >=13) return SendClientMessage(playerid, COLOR_RED, "IP: ADDRESS IS TOO LONG");
		format(UnBanIp,sizeof(UnBanIp),"unbanip %s",cmdtext[7]);
		SendRconCommand(UnBanIp);
		format(IpAdd,sizeof(IpAdd),"You Have Unbanned IP: "BLUE"%s",cmdtext[7]);
		SendClientMessage(playerid,COLOR_GREEN,IpAdd);
		SendClientMessage(playerid,COLOR_YELLOW,"Remember IP Address is case sensitive !!!");
	}
	return 1;
}
if(strcmp(cmd, "/freeze", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] == 0) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	tmp = strtok(cmdtext, idx);
	new otherplayer = strval(tmp);
	if(PlayerInfo[giveplayerid][PlayerAdmin] > PlayerInfo[playerid][PlayerAdmin]) return SendClientMessage(playerid,COLOR_RED,"You can't Use this command on level Admin !");
	if(PlayerInfo[playerid][PlayerAdmin] >= 2){
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/freeze "WHITE"[playerid]");
		if(!IsPlayerConnected(otherplayer)) return SendClientMessage(playerid, COLOR_WHITE, "Invalid Player ID.");
		GetPlayerName(otherplayer, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, Pname, sizeof(Pname));
		TogglePlayerControllable(otherplayer, 0);
		new string[90];
		format(string, sizeof(string), "{014CEB}\"%s\""WHITE" has been Frozen by Admin {014CEB}\"%s\" .", giveplayer, Pname);
		SendClientMessageToAll(COLOR_YELLOW, string);
		}
	return 1;
}
if(strcmp(cmd, "/unfreeze", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] < 2) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	tmp = strtok(cmdtext, idx);
	new otherplayer = strval(tmp);
	if(PlayerInfo[giveplayerid][PlayerAdmin] > PlayerInfo[playerid][PlayerAdmin]) return SendClientMessage(playerid,COLOR_RED," You can't Use this command on level Admin !");
	if(PlayerInfo[playerid][PlayerAdmin] >= 2){
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/unfreeze "WHITE"[playerid]");
		if(!IsPlayerConnected(otherplayer)) return SendClientMessage(playerid, COLOR_WHITE, "Invalid Player ID.");
		GetPlayerName(otherplayer, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, Pname, sizeof(Pname));
		TogglePlayerControllable(otherplayer, 1);
		new string[90];
		format(string, sizeof(string), "{LIGHTTBLUE}\"%s\""WHITE" has been Un-Frozen by Admin {014CEB}\"%s\".", giveplayer, Pname);
		SendClientMessageToAll(COLOR_YELLOW, string);
	}
	return 1;
}
if(strcmp(cmd, "/givemoney", true)==0){
if(PlayerInfo[playerid][PlayerAdmin] < 3) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
new tmp2[256];
tmp = strtok(cmdtext, idx);
new otherplayer = strval(tmp);
tmp2 = strtok(cmdtext, idx);
new money = strval(tmp2);
new Moneytring[128];
format(Moneytring,sizeof(Moneytring),"Can't Give Any More Money Maximum Allowed %d",MAX_MONEY_ALLOWED);
if(money >= MAX_MONEY_ALLOWED) return SendClientMessage(playerid,COLOR_RED,Moneytring);
if(PlayerInfo[otherplayer][PlayerAdmin] > PlayerInfo[playerid][PlayerAdmin]) return SendClientMessage(playerid,COLOR_RED," You can't Use this command on level Admin !");
if(PlayerInfo[playerid][PlayerAdmin] >= 3){
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/givemoney "WHITE"[playerid] [ammount]");
if(!strlen(tmp2)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/givemoney "GREEN"[playerid] "WHITE"[ammount]");
if(!IsPlayerConnected(otherplayer)) return SendClientMessage(playerid, COLOR_WHITE, "Invalid Player ID.");
GivePlayerMoney(otherplayer, money);
GetPlayerName(playerid, Pname, sizeof(Pname));
new string[90];
format(string, sizeof(string), ""GREEN"Admin "BLUE"\"%s\" "GREEN"Has Just Given ou "ORANGE"$%d", Pname, money);
SendClientMessage(otherplayer, COLOR_GREEN, string);
}
return 1;
}
if(strcmp(cmd, "/setscore", true)==0){
if(PlayerInfo[playerid][PlayerAdmin] < 3) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
new tmp2[256];
tmp = strtok(cmdtext, idx);
new otherplayer = strval(tmp);
tmp2 = strtok(cmdtext, idx);
new score = strval(tmp2);
new ScoreString[128];
format(ScoreString,sizeof(ScoreString),"Maximum Score is %d",MAX_SCORE_ALLOWED);
if(score >= MAX_SCORE_ALLOWED) return SendClientMessage(playerid, COLOR_RED,ScoreString);
if(PlayerInfo[otherplayer][PlayerAdmin] > PlayerInfo[playerid][PlayerAdmin]) return SendClientMessage(playerid,COLOR_RED," You can't Use this command on level Admin !");
if(PlayerInfo[playerid][PlayerAdmin] >= 3){
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/setscore "WHITE"[playerid]"WHITE" [ammount]");
if(!strlen(tmp2)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/setscore "GREEN"[playerid]"WHITE" [ammount]");
if(!IsPlayerConnected(otherplayer)) return SendClientMessage(playerid, COLOR_WHITE, "Invalid Player ID.");
SetPlayerScore(otherplayer, score);
GetPlayerName(playerid, Pname, sizeof(Pname));
new string[128];
format(string, sizeof(string), ""GREEN"Admin "BLUE"\"%s\" "GREEN"has just given you {FF6200}%d "GREEN"Score", Pname, score);
SendClientMessage(otherplayer, COLOR_GREEN, string);
}
return 1;
}
if(strcmp(cmd, "/disarm", true)==0){
if(PlayerInfo[playerid][PlayerAdmin] < 2) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
tmp = strtok(cmdtext, idx);
new otherplayer = strval(tmp);
if(PlayerInfo[otherplayer][PlayerAdmin] > PlayerInfo[playerid][PlayerAdmin]) return SendClientMessage(playerid,COLOR_RED," You can't Use this command on level Admin !");
if(PlayerInfo[playerid][PlayerAdmin] >= 2){
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/disarm "WHITE"[playerid]");
if(!IsPlayerConnected(otherplayer)) return SendClientMessage(playerid, COLOR_WHITE, "Invalid Player ID.");
ResetPlayerWeapons(otherplayer);
new string[128];
GetPlayerName(playerid, Pname, sizeof(Pname));
format(string, sizeof(string), ""WHITE"Admin {014CEB}\"%s\""WHITE" has reset your weapons.", Pname);
SendClientMessage(otherplayer, COLOR_YELLOW, string);
}
return 1;
}
if(strcmp(cmd, "/spec", true)==0){
if(PlayerInfo[playerid][PlayerAdmin] == 0) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
if(PlayerInfo[playerid][PlayerAdmin] >= 1){
new specplayerid;
tmp = adminspec_strtok(cmdtext, idx);
if(!strlen(tmp)){
SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/spec "WHITE"[playerid]");
return 1;
}
specplayerid = strval(tmp);
if(!IsPlayerConnected(specplayerid)){
SendClientMessage(playerid, COLOR_RED, "Invalid Player ID.");
return 1;
}
if(specplayerid == playerid) return SendClientMessage(playerid, COLOR_BRIGHTRED, "You can't Spec yourself !");
TogglePlayerSpectating(playerid, 1);
PlayerSpectatePlayer(playerid, specplayerid);
SetPlayerInterior(playerid,GetPlayerInterior(specplayerid));
new string[120], name[MAX_PLAYER_NAME];
GetPlayerName(specplayerid, name, sizeof(name));
format(string,sizeof(string),"Your spactating "BLUE"%s",name);
SendClientMessage(playerid, COLOR_GREEN2, string);
}
return 1;
}
if(strcmp(cmd, "/specoff", true)==0){
if(PlayerInfo[playerid][PlayerAdmin] == 0) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
if(TogglePlayerSpectating(playerid, 0)) return SendClientMessage(playerid,COLOR_RED, "Your not spectating anyone");
if(PlayerInfo[playerid][PlayerAdmin] >= 1){
TogglePlayerSpectating(playerid, 0);
SendClientMessage(playerid, COLOR_RED, "Your STOPED spactating.");
}
return 1;
}
if(strcmp(cmd, "/night", true)==0){
if(PlayerInfo[playerid][PlayerAdmin] == 0) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
if(PlayerInfo[playerid][PlayerAdmin] >= 1){
new string[80];
new name[MAX_PLAYER_NAME];
GetPlayerName(playerid, name, sizeof(name));
format(string,sizeof(string),""WHITE"Admin {014CEB}%s "WHITE"has set the time to {FF6200}24hr",name);
SendClientMessageToAll(COLOR_YELLOW, string);
SetWorldTime(24);
}
return 1;
}
if(strcmp(cmd, "/noon", true)==0){
if(PlayerInfo[playerid][PlayerAdmin] == 0) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
if(PlayerInfo[playerid][PlayerAdmin] >= 1){
new string[80];
new name[MAX_PLAYER_NAME];
GetPlayerName(playerid, name, sizeof(name));
format(string,sizeof(string),""WHITE"Admin {014CEB}%s "WHITE"has set the time to {FF6200}12hr",name);
SendClientMessageToAll(COLOR_YELLOW, string);
SetWorldTime(12);
}
return 1;
}
if(strcmp(cmd, "/makeadmin", true)==0){
tmp = strtok(cmdtext, idx);
new player[MAX_PLAYER_NAME];
if(IsPlayerAdmin(playerid) || PlayerInfo[playerid][PlayerAdmin] >= 6){
if(!strlen(tmp)) return SendClientMessage(playerid,COLOR_RED,"{EB0000}Usage: "GREEN"/makeadmin {EB0000}[playerid] {EB0000}[AdminLevel]");
if(!IsNumeric(tmp)) return SendClientMessage(playerid,COLOR_RED,"Please enter a player ID.");
if(!IsPlayerConnected(strval(tmp))) return SendClientMessage(playerid,COLOR_RED,"ERROR: Player is not connected.");
new file[128],string[128];
giveplayerid = ReturnUser(tmp);
tmp = strtok(cmdtext, idx);
new level = strval(tmp);
if(level < 0 && PlayerInfo[playerid][PlayerAdmin] >= 6 || level < 0 && IsPlayerAdmin(playerid)) return SendClientMessage(playerid,COLOR_RED,"Lowest level admin  is 0!!!");
if(level >= 6 && PlayerInfo[playerid][PlayerAdmin] == 6) return SendClientMessage(playerid,COLOR_RED,"Highes level admin you can set is 5!!!");
if(level >= 8 && PlayerInfo[playerid][PlayerAdmin] == 7 || level >= 8 && IsPlayerAdmin(playerid)) return SendClientMessage(playerid,COLOR_RED,"Highes level admin  is 7!!!");
new name[MAX_PLAYER_NAME];
GetPlayerName(giveplayerid, name, sizeof(name));
format(file,sizeof(file),"/mRegistration/Settings/%s.txt",name);
new INI:AccA = INI_Open(file);
INI_WriteInt(AccA,"PlayerAdmin",PlayerInfo[giveplayerid][PlayerAdmin] = level);
INI_Close(AccA);
INI_ParseFile(file, "PlayerAdminLevel", false, true, playerid, true, false );
PlayerInfo[giveplayerid][PlayerAdmin] = GetPVarInt(playerid,"PlayerAdmin");
GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
GetPlayerName(playerid, player, sizeof(player));
format(string, sizeof(string), ""GREEN"Admin {014CEB}\"%s\" "GREEN"has set your Admin Level to {FF6200}%d.",player, level);
SendClientMessage(giveplayerid, COLOR_GREEN, string);
format(string, sizeof(string), ""GREEN"You have given "GREEN"\"%s\""GREEN" level {FF6200}%d"GREEN" Admin.", giveplayer, level);
SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
printf("Admin \"%s\" has set \"%s\" Admin Level to %d.",player,giveplayer,level);
}else return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
return 1;
}
if(strcmp(cmd, "/goto", true)==0){
new id;
tmp = strtok(cmdtext, idx);
if(PlayerInfo[playerid][PlayerAdmin] < 4) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
id = ReturnUser(tmp);
if(!strlen(tmp)) return SendClientMessage(playerid,COLOR_RED,""WHITE"Usage: "GREEN"/goto "WHITE"[id]");
if(!IsNumeric(tmp)) return SendClientMessage(playerid,0xF0182DFF,"Please enter a player ID.");
if(id == playerid) return SendClientMessage(playerid, COLOR_BRIGHTRED, "You can't use this command on yourself !");
if(PlayerInfo[playerid][PlayerAdmin] >= 4){
new Float:X;
new Float:Y;
new Float:Z;
new interior,world;
new string[128];
GetPlayerPos(id,X,Y,Z);
interior = GetPlayerInterior(id);
world = GetPlayerVirtualWorld(id);
if(IsPlayerInAnyVehicle(playerid)){
GetPlayerName(id, giveplayer, sizeof(id));
SetVehiclePos(GetPlayerVehicleID(playerid),X+5,Y+3,Z);
new vehicle;
vehicle = GetPlayerVehicleID(playerid);
LinkVehicleToInterior(vehicle,interior);
SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), world);
}
else{
SetPlayerPos(playerid, X+1, Y+1, Z);
SetPlayerInterior(playerid, interior);
SetPlayerVirtualWorld(playerid, world);
}
new name[MAX_PLAYER_NAME];
GetPlayerName(id, name, sizeof(name));
format(string, sizeof(string), ""WHITE"You have teleported to {014CEB}\"%s\""WHITE" position.", name);
SendClientMessage(playerid,COLOR_WHITE, string);
GetPlayerName(playerid, name, sizeof(name));
format(string, sizeof(string), "{014CEB}\"%s\""WHITE" has teleported to your position.", name);
SendClientMessage(id,COLOR_WHITE, string);
}
return 1;
}
if(strcmp(cmd, "/gethere", true)==0){
new id;
new string[128];
new interior,world;
tmp = strtok(cmdtext, idx);
if(PlayerInfo[playerid][PlayerAdmin] < 4) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
if(!strlen(tmp)) return SendClientMessage(playerid,COLOR_RED,""WHITE"Usage: "GREEN"/gethere "WHITE"[id]");
id = ReturnUser(tmp);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_WHITE, "Invalid Player ID.");
if(id == playerid) return SendClientMessage(playerid, COLOR_BRIGHTRED, "You can't use this command on yourself !");
#if ALLOW_ADMIN_TELE == true
if(PlayerInfo[id][PlayerAdmin] > PlayerInfo[playerid][PlayerAdmin]) return SendClientMessage(playerid,COLOR_RED," You can't use this to a higher level Admin !");
#endif
if(PlayerInfo[playerid][PlayerAdmin] >= 4){
GetPlayerName(id, giveplayer, sizeof(id));
new Float:X, Float:Y, Float:Z;
GetPlayerPos(playerid, X, Y, Z);
interior = GetPlayerInterior(playerid);
world = GetPlayerVirtualWorld(playerid);
if(IsPlayerInAnyVehicle(id)){
SetVehiclePos(GetPlayerVehicleID(id),X+5,Y+3,Z);
new vehicle;
vehicle = GetPlayerVehicleID(id);
LinkVehicleToInterior(vehicle,interior);
SetVehicleVirtualWorld(GetPlayerVehicleID(id), world);
}
else{
SetPlayerPos(id, X, Y+1, Z);
SetPlayerInterior(id, interior);
SetPlayerVirtualWorld(id, world);
}
new name[MAX_PLAYER_NAME];
GetPlayerName(id, giveplayer, sizeof(giveplayer));
GetPlayerName(id, name, sizeof(name));
format(string, sizeof(string), ""WHITE"You have teleported {014CEB}\"%s\""WHITE" to your position.", name);
SendClientMessage(playerid,COLOR_WHITE, string);
GetPlayerName(playerid, name, sizeof(name));
format(string, sizeof(string), ""WHITE"You have been teleported by {014CEB}\"%s\""WHITE" to his position.", name);
SendClientMessage(id, COLOR_WHITE, string);
}
return 1;
}
if(strcmp(cmd, "/getallhere", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] < 4) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	new string[128];
	if(PlayerInfo[playerid][PlayerAdmin] >= 4){
	GetPlayerName(playerid, playrname, sizeof(playrname));
	format(string, sizeof(string), ""WHITE"Admin {014CEB}\"%s\""WHITE" has teleported everyone to his location.", playrname);
	SendClientMessageToAll(COLOR_YELLOW, string);
	new Float:X,Float:Y, Float:Z;
	GetPlayerPos(playerid,X,Y,Z);
	for(new i = 0; i <= MAX_PLAYERS; i++){
	if(IsPlayerConnected(i))
	SetPlayerPos(i,X+2,Y,Z+2);
	}
	}
	return 1;
}
if(strcmp(cmd, "/killall", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] < 4) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	if(PlayerInfo[playerid][PlayerAdmin] >= 4){
		SendClientMessage(playerid,COLOR_YELLOW, "You killed all players");
		for(new i = 0; i <= MAX_PLAYERS; i++){
			if(IsPlayerConnected(i))
			SetPlayerHealth(i,0.0);
		}
	}
	return 1;
}
if(strcmp(cmd, "/reconnect", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] < 7) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	if((cmdtext[10] != ' ') || (cmdtext[11] == EOS)) return SendClientMessage(playerid, 0xFFFFFFFF, ""WHITE" Usage: "GREEN"/Reconnect "WHITE"[playerid]");
	new string[16 + 6],destid = strval(cmdtext[11]),ipstring[16];
	if(!IsPlayerConnected(destid)) return SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}» Error: {FFFFFF}Player is not connected!");
	GetPlayerIp(destid, ipstring, 16), SetPVarString(destid, "pIp", ipstring);
	format(string, sizeof(string), "banip %s",ipstring);
	SendRconCommand(string);
	PlayerReconnecting[destid]=1;
	return SendClientMessage(destid, 0xFFFFFFFF, "Reconnecting...");
}
if(strcmp(cmd, "/ann", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] < 3) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	if(PlayerInfo[playerid][PlayerAdmin] >= 3){
		GetPlayerName(playerid, Pname, sizeof(Pname));
		new length = strlen(cmdtext);
		new string[128];
		while ((idx < length) && (cmdtext[idx] <= ' ')){
		idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))){
		result[idx - offset] = cmdtext[idx];
		idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/ann "WHITE"[text]");
		format(string, sizeof(string), "~y~%s", result);
		for(new i = 0; i < MAX_PLAYERS; i++){
			if(IsPlayerConnected(i)){
			  GameTextForPlayer(i, string, 5000, 3);
			}
		}
	}
	return 1;
}
if(strcmp(cmd, "/sethp", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] < 2) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	if(PlayerInfo[playerid][PlayerAdmin] >= 2){
	new tmp2[256];
	tmp = strtok(cmdtext, idx);
	new otherplayer = ReturnUser(tmp);
	tmp2 = strtok(cmdtext, idx);
	new hp = strval(tmp2);
	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/sethp "WHITE"[playerid] "WHITE"[ammount]");
	if(!strlen(tmp2)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/sethp "GREEN"[playerid] "WHITE"[ammount]");
	if(!IsPlayerConnected(otherplayer)) return SendClientMessage(playerid, COLOR_WHITE, "Invalid Player ID.");
	#if ALLOW_ADMIN_HP == false
	if(PlayerInfo[otherplayer][PlayerAdmin] > PlayerInfo[playerid][PlayerAdmin]) return SendClientMessage(playerid,COLOR_RED," You can't use this to a higher level Admin !");
	#endif
	SetPlayerHealth(otherplayer, hp);
	}
	return 1;
}
if(strcmp(cmd, "/givegun", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] < 3) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	if(PlayerInfo[playerid][PlayerAdmin] >= 3){
		new tmp2[256], tmp3[256];
		tmp = strtok(cmdtext, idx);
		tmp2 = strtok(cmdtext, idx);
		tmp3 = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/givegun "WHITE"[playerid] "WHITE"[gun] "WHITE"[ammo]");
		if(!strlen(tmp2)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/givegun "GREEN"[playerid] "WHITE"[gun] "WHITE"[ammo]");
		if(!strlen(tmp3)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/givegun "GREEN"[playerid] "GREEN"[gun] "WHITE"[ammo]");
		new gun = strval(tmp2);
		new ammo = strval(tmp3);
		new otherplayer = ReturnUser(tmp);
		#if ALLOW_ADMIN_GUN == false
		if(PlayerInfo[otherplayer][PlayerAdmin] > PlayerInfo[playerid][PlayerAdmin]) return SendClientMessage(playerid,COLOR_RED," You can't use this to a higher level Admin !");
		#endif
		if(!IsPlayerConnected(otherplayer)) return SendClientMessage(playerid, COLOR_WHITE, "Invalid Player ID.");
		GivePlayerWeapon(otherplayer, gun, ammo);
	}
	return 1;
}
if(strcmp(cmd, "/cc", true)==0){
	if(PlayerInfo[playerid][PlayerAdmin] == 0) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
	if(PlayerInfo[playerid][PlayerAdmin] >= 1){
	for (new a = 1; a <= 60; a++){
		SendClientMessageToAll(COLOR_BLUE,"\n");
		SendClientMessageToAll(COLOR_BLUE,"\n");
		GameTextForAll("~b~Chat cleared!", 3, 1);
	}
	new Player[MAX_PLAYER_NAME];
	new string[128];
	GetPlayerName(playerid,Player,sizeof(Player));
	format(string, sizeof(string), "{000089}***Admin {014CEB}\"%s\"{000089} cleared the chat.",Player);
	SendClientMessageToAll(COLOR_BLUE,string);
	printf(string);
	}
	return 1;
}
if(strcmp(cmd, "/report", true)==0){
		tmp = strtok(cmdtext, idx);
		new otherplayer = strval(tmp);
	   	if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/report "WHITE"[playerid] "WHITE"[reason]");
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
		idx++;
		}
		new offset = idx;
		new result[64];
		new string[308];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
		result[idx - offset] = cmdtext[idx];
		idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/report "GREEN"[playerid] "WHITE"[reason]");
		if(!IsPlayerConnected(otherplayer)) return SendClientMessage(playerid, COLOR_WHITE, "Invalid Player ID.");
		if(otherplayer == playerid) return SendClientMessage(playerid, COLOR_BRIGHTRED, "You can't Report yourself !");
		GetPlayerName(playerid, playrname, sizeof(playrname));
		new othername[MAX_PLAYER_NAME];
		GetPlayerName(otherplayer, othername, sizeof(othername));
		{
	    SendClientMessage(playerid, COLOR_BRIGHTRED, "Report Message was Send to the Admins.");
		}
		format(string,sizeof(string),""BLUE"\"%s\" "BLUE"(%d) "YELLOW"Has Been Reported By "BLUE"\"%s\""YELLOW" "BLUE"(%d)"YELLOW" Reason for report:"WHITE" %s.",othername,otherplayer,playrname,playerid,result);
		for(new i=0;i<MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i) && PlayerInfo[i][PlayerAdmin] >= 1)
			{
			SendClientMessage(i,COLOR_YELLOW,string);
			}
		}
	    return 1;
	}
//-PlayerCommands-//
if(strcmp(cmd, "/reconnect", true)==0){
for (new a = 1; a <= 60; a++){
	 	SendClientMessage(playerid,COLOR_BLUE,"\n");
		SendClientMessage(playerid,COLOR_BLUE,"\n");
	}
SaveStatus(playerid);
SendClientMessage(playerid,COLOR_GREEN,"Status/Settings |SAVED|");
TogglePlayerSpectating(playerid, 1);
SendClientMessage(playerid,COLOR_BLUE,"\n");
SendClientMessage(playerid,COLOR_YELLOW,"Reconnecting... |Please Wait|");
SetTimer("RECONNECT",3000,false);
}
if(strcmp(cmd, "/a", true)==0){
if(PlayerInfo[playerid][PlayerAdmin] < 1) return SendClientMessage(playerid,COLOR_RED, "You Cant Use This Command !!!");
new length = strlen(cmdtext);
while ((idx < length) && (cmdtext[idx] <= ' ')){
idx++;
}
new offset = idx;
new result[80];
new string[128];
while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))){
result[idx - offset] = cmdtext[idx];
idx++;
}
result[idx - offset] = EOS;
if(!strlen(result)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: /A "GREEN"[MESSAGE]");
new name[MAX_PLAYER_NAME];
GetPlayerName(playerid, name, sizeof(name));
for(new i=0;i<MAX_PLAYERS;i++){
if(IsPlayerConnected(i) && PlayerInfo[i][PlayerAdmin] >= 1){
format(string,sizeof(string),"%s: %s",name,result);
SendClientMessage(i,COLOR_BRIGHTBLUE,string);
}
}
return 1;
}
if(strcmp(cmd, "/pm", true)==0){
tmp = strtok(cmdtext, idx);
new otherplayer = strval(tmp);
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/PM "WHITE"[playerid] [MESSAGE]");
new length = strlen(cmdtext);
while ((idx < length) && (cmdtext[idx] <= ' ')){
idx++;
}
new offset = idx;
new result[80];
new string[280 + MAX_PLAYER_NAME];
while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))){
result[idx - offset] = cmdtext[idx];
idx++;
}
result[idx - offset] = EOS;
if(!strlen(result)) return SendClientMessage(playerid, COLOR_WHITE, ""WHITE"Usage: "GREEN"/PM "GREEN"[playerid] "WHITE"[MESSAGE]");
if(!IsPlayerConnected(otherplayer)) return SendClientMessage(playerid, COLOR_WHITE, "Invalid Player ID.");
if(otherplayer == playerid) return SendClientMessage(playerid, COLOR_BRIGHTRED, "You can't PM yourself !");
GetPlayerName(playerid, playrname, sizeof(playrname));
GetPlayerName(otherplayer, playrname, sizeof(playrname));
format(string,sizeof(string),"PM was send to %s.",playrname);
SendClientMessage(playerid, COLOR_GREEN, string);
new name[MAX_PLAYER_NAME];
GetPlayerName(playerid, name, sizeof(name));
GetPlayerName(otherplayer, playrname, sizeof(playrname));
if(IsPlayerConnected(otherplayer)){
	format(string,sizeof(string),""YELLOW"PM from "BLUE"\"%s\" (%d)"YELLOW" MESSAGE:"WHITE" %s",name,playerid,result);
	SendClientMessage(otherplayer,COLOR_YELLOW,string);
}
return 1;
}
if(strcmp(cmd, "/admins", true)==0){
SendClientMessage(playerid, COLOR_GREEN,"||>> Online Administrators <<||");
for(new i=0; i < MAX_PLAYERS; i++){
if(IsPlayerConnected(i) && PlayerInfo[i][PlayerAdmin] >= 1){
new name[MAX_PLAYER_NAME], string[180 + MAX_PLAYER_NAME];
GetPlayerName(i, name, sizeof(name));
new level;
level = PlayerInfo[i][PlayerAdmin];
format(string, sizeof(string), ""BLUE"%s"ORANGE"(%d)"WHITE" Admin Level: "ORANGE"%d",name,i,level);
SendClientMessage(playerid, 0x1E90FFAA, string);
}
}
return 1;
}
if(strcmp(cmd, "/changeip", true)==0){
if(IsLogged[playerid] == 0) return ShowPlayerDialog(playerid, Login, DIALOG_STYLE_INPUT, ""RED"WARRNING", ""RED"You Need To login First", "login", "Cancel");
ShowPlayerDialog(playerid, IPChange1, DIALOG_STYLE_MSGBOX, "{014CEB}change IP", "Your About to change your IP address \nA password authorization will be needed to continue!!!", "OK", "Cancel");
return 1;
}
if(strcmp(cmd, "/changepass", true)==0){
if(IsLogged[playerid] == 0) return ShowPlayerDialog(playerid, Login, DIALOG_STYLE_INPUT, ""RED"WARRNING", ""RED"You Need To login First", "login", "Cancel");
ShowPlayerDialog(playerid, Register1, DIALOG_STYLE_MSGBOX, ""BLUE"Change Password ", "Your About to change your password \n\nA password authorization will be needed to continue!!!", "OK", "Cancel");
return 1;
}
if(strcmp(cmd, "/logout", true)==0){
new string[128], name[MAX_PLAYER_NAME];
if(IsLogged[playerid] == 0){
SendClientMessage(playerid,COLOR_RED,"You are already logged out");
SendClientMessage(playerid,COLOR_YELLOW,""WHITE"Use "GREEN"/login"WHITE" to log back in to your account");
}
IsLogged[playerid] = 0;
GetPlayerName(playerid, name, sizeof(name));
format(string, sizeof string, ""BLUE"%s"WHITE" Has Logged out of his account", name);
SendClientMessageToAll(COLOR_YELLOW,string);
return 1;
}
if(strcmp(cmd, "/register", true)==0){
new file[128],name[MAX_PLAYER_NAME];
GetPlayerName(playerid, name, sizeof(name));
format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
if(fexist(file)){
ShowPlayerDialog(playerid, 1235, DIALOG_STYLE_MSGBOX, ""RED"ERROR", "Your account is already registered", "OK", "Cancel");
}
if(!fexist(file)){
ShowPlayerDialog(playerid, Register, DIALOG_STYLE_INPUT, ""BLUE"Account Register", "Enter Your Password for your account", "Register", "Cancel");
}
return 1;
}
if(strcmp(cmd, "/login", true)==0){
new file[128],name[MAX_PLAYER_NAME];
GetPlayerName(playerid, name, sizeof(name));
format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
if(IsLogged[playerid] == 1) return ShowPlayerDialog(playerid, 1236, DIALOG_STYLE_MSGBOX, ""RED"ERROR", "You are already logged in", "OK", "Cancel");
if(fexist(file) && IsLogged[playerid] == 0){
ShowPlayerDialog(playerid, Login, DIALOG_STYLE_INPUT, ""BLUE"Account Login", "Enter a password to log back in", "Login", "Cancel");
}
else if(!fexist(file)){
ShowPlayerDialog(playerid, Register, DIALOG_STYLE_INPUT, ""BLUE"AccountRegister "RED"FAILED", "You Need To Register First", "Register", "Cancel");
}
return 1;
}
if(strcmp(cmd, "/autolog", true)==0){
	if(IsLogged[playerid] == 0) return ShowPlayerDialog(playerid, Login, DIALOG_STYLE_INPUT, ""BLUE"AutoLog "RED"FAILED", "You Need To login First", "login", "Cancel");
	ShowPlayerDialog(playerid, AutoLog, DIALOG_STYLE_LIST, ""BLUE"Auto Login", ""GREEN"On \n"RED"OFF", "Select", "Cancel");
	return 1;
}
if(strcmp(cmd, "/saveskin", true)==0){
	if(IsLogged[playerid] == 0) return ShowPlayerDialog(playerid, Login, DIALOG_STYLE_INPUT, ""BLUE"SaveSkin "RED"FAILED", "You Need To login First", "login", "Cancel");
	ShowPlayerDialog(playerid, SkinSave, DIALOG_STYLE_LIST, ""BLUE"Skin Saving", ""GREEN"SAVE YOUR SKIN \n"RED"UNSAVE YOUR SKIN", "Select", "Cancel");
	return 1;
}
return 0;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]){
if(dialogid == PMMSG)
{
	if(!response)
	{
	new Sender[MAX_PLAYER_NAME],Receiver[MAX_PLAYER_NAME],string[208];
	GetPlayerName(playerid, Sender, sizeof(Sender));
	GetPlayerName(pmplayerid, Receiver, sizeof(Receiver));
	if(playerid == pmplayerid)
	{
		format(string, sizeof string, ""WHITE"Message Receiver: %s\n\nEnter your message here!\n\n"RED"[YOU CANT PM YOURSELF]",Receiver);
		ShowPlayerDialog(playerid, PMMSG, DIALOG_STYLE_INPUT, ""YELLOW"Send Personal Message!"RED"[ERROR]", string, "Send", "Cancel");
	}
	format(string, sizeof string, ""WHITE"Message Receiver: %s\n\nEnter your message here!",Receiver);
	ShowPlayerDialog(playerid, PMMSG+3, DIALOG_STYLE_INPUT, ""YELLOW"Send Personal Message!", string, "Send", "Cancel");
	}
	return 1;
}
if(dialogid == PMMSG+3)
{
	if(response)
	{
	new Sender[MAX_PLAYER_NAME],Receiver[MAX_PLAYER_NAME],string[208],Reciverstring[300];
	GetPlayerName(playerid, Sender, sizeof(Sender));
	GetPlayerName(pmplayerid, Receiver, sizeof(Receiver));
	if(strlen(inputtext) <= MIN_PM_CHARACTERS)
	{
		format(string, sizeof string, ""WHITE"Message Receiver: %s\n\nEnter your message here!\n\n"RED"[YOUR TEXT NEED TO BE LONGER THAN %d CHARACTERS]",Receiver,MIN_PM_CHARACTERS);
		ShowPlayerDialog(playerid, PMMSG+3, DIALOG_STYLE_INPUT, ""YELLOW"Send Personal Message!", string, "Send", "Cancel");
	}
	format(Reciverstring, sizeof Reciverstring, ""WHITE"New "GREEN"Message"WHITE" From: %s\n"BLUE"MESSAGE\n\n"WHITE"%s",Sender,inputtext);
	ShowPlayerDialog(pmplayerid, PMMSG+4, DIALOG_STYLE_MSGBOX, ""WHITE"New "GREEN"Message", Reciverstring, "Ok", "Cancel");
	format(string, sizeof string, ""WHITE"Message Successfully Send To: %s",Receiver);
	ShowPlayerDialog(playerid, PMMSG+4, DIALOG_STYLE_MSGBOX, ""GREEN"Message Send!", string, "Ok", "Cancel");
	}
	return 1;
}
if(dialogid == RestorPos)
	{
	if(response)
	{
	new file[128],name[MAX_PLAYER_NAME];
	format(file,sizeof(file),"/mRegistration/Settings/%s.txt",name);
	INI_ParseFile(file, "LoadUser", false, true, playerid, true, false );
	PlayerInfo[playerid][posx] = GetPVarInt(playerid, "posx");
	PlayerInfo[playerid][posy] = GetPVarInt(playerid, "posy");
	PlayerInfo[playerid][posz] = GetPVarInt(playerid, "posz");
	PlayerInfo[playerid][posx] = x;
	PlayerInfo[playerid][posy] = y;
	PlayerInfo[playerid][posz] = z;
	if(x == 0.000000 && y == 0.000000 && z == 0.000000)
	{
	ShowPlayerDialog(playerid,42 ,DIALOG_STYLE_MSGBOX,""RED"Failed To Restor Position",""RED"You last Position Couldnt Be Saved!!!","Ok","");
	}
	else
	{
	SendClientMessage(playerid,COLOR_YELLOW,"Canceled");
	}
	return 1;
	}
}
if(dialogid == AutoLog && response)
	{
	  switch(listitem)
	    {
	    case 0:
	    {
	    if(PlayerInfo[playerid][AutoLogin] >= 1) return SendClientMessage(playerid, COLOR_YELLOW, "Auto Login already Enabled");
	    new file[128] ,name[MAX_PLAYER_NAME];
		GetPlayerName(playerid, name, sizeof(name));
	    format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
	    new INI:Acc = INI_Open(file);
		{
	    GetPlayerIp(playerid,rip[playerid],16);
	    INI_WriteString(Acc,"IP",rip[playerid]);
	    }
	    format(file,sizeof(file),"/mRegistration/Settings/%s.txt",name);
	    new INI:Acc2 = INI_Open(file);
	    {
	    INI_WriteInt(Acc2,"AutoLog",PlayerInfo[playerid][AutoLogin]=1);
	    SendClientMessage(playerid, COLOR_GREEN, "Auto Login Enabled");
	    }
		return 1;
	    }
	    case 1:
	    {
	    new file[128] ,name[MAX_PLAYER_NAME];
		GetPlayerName(playerid, name, sizeof(name));
	    format(file,sizeof(file),"/mRegistration/Settings/%s.txt",name);
	    new INI:Acc2 = INI_Open(file);
	    if(PlayerInfo[playerid][AutoLogin] >= 1)
		{
		INI_WriteInt(Acc2,"AutoLog",PlayerInfo[playerid][AutoLogin]=1);
	    SendClientMessage(playerid, COLOR_RED, "Auto Login Disabled");
	    }else if(PlayerInfo[playerid][AutoLogin] == 0) return SendClientMessage(playerid, COLOR_RED, "Auto Login already Disabled");
		return 1;
		}
	  }
	}
if(dialogid == SkinSave && response)
	{
	  switch(listitem)
	    {
	    case 0:
	    {
	    new file[128] ,name[MAX_PLAYER_NAME];
		GetPlayerName(playerid, name, sizeof(name));
	    format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
	    new INI:Acc = INI_Open(file);
		{
		INI_WriteInt(Acc,"Skins",GetPlayerSkin(playerid));
	    }
	    format(file,sizeof(file),"/mRegistration/Settings/%s.txt",name);
	    new INI:Acc2 = INI_Open(file);
	    {
	    INI_WriteInt(Acc2,"SaveSkin",PlayerInfo[playerid][SaveSkin]=1);
	    SendClientMessage(playerid, COLOR_GREEN, "Skin Saved!!!");
	    }
		return 1;
	    }
	    case 1:
	    {
	    new file[128] ,name[MAX_PLAYER_NAME];
		GetPlayerName(playerid, name, sizeof(name));
		if(PlayerInfo[playerid][SaveSkin] == 0) return SendClientMessage(playerid,COLOR_RED,"Skin already UnSaved!!!");
		if(PlayerInfo[playerid][SaveSkin] >= 1)
	    format(file,sizeof(file),"/mRegistration/Settings/%s.txt",name);
	    new INI:Acc2 = INI_Open(file);
		{
		INI_WriteInt(Acc2,"SaveSkin",PlayerInfo[playerid][SaveSkin]=0);
	    SendClientMessage(playerid, COLOR_RED, "Skin UnSaved");
	    }
	    return 1;
		}
	  }
	}
if(dialogid == WELCOME1)
   {
   if(response)
   {
		SendClientMessage(playerid, COLOR_WHITE, "{FFFFEB}You have Skipped the login. Use {55B500}(/Login) {FFFFEB}to login to your account");
		TogglePlayerSpectating(playerid, 0);
		IsLogged[playerid] = 0;
   }
   else
   {
		TogglePlayerSpectating(playerid, 1);
		IsLogged[playerid] = 0;
		new file[128], string[128] ,name[MAX_PLAYER_NAME];
		GetPlayerName(playerid, name, sizeof(name));
		format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
		if(!fexist(file))
		{
		format(string, sizeof string, ""WHITE"Welcome "BLUE"%s! \n"WHITE"Please Register you account!", name);
		ShowPlayerDialog(playerid, Register, DIALOG_STYLE_INPUT, ""WHITE"Account Register", string, "Register", "Cancel");
	   	}
	}
 }
if(dialogid == WELCOME2)
	{
	if(response)
	{
		SendClientMessage(playerid, COLOR_WHITE, "{FFFFEB}You have Skipped the login. Use {55B500}(/Register) {FFFFEB}To Register A New Account");
		TogglePlayerSpectating(playerid, 0);
		IsLogged[playerid] = 0;
	}
	else
	{
	TogglePlayerSpectating(playerid, 1);
	IsLogged[playerid] = 0;
	new file[128], string[128] ,name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
	if(fexist(file))
	{
	format(string, sizeof string, ""WHITE"Welcome "BLUE"%s! "WHITE"\n\nPlease Login to your account!", name);
	ShowPlayerDialog(playerid, Login, DIALOG_STYLE_INPUT, ""BLUE"Account Login", string, "Login", "Cancel");
   }
}
 }
if(dialogid == IPChange1)
	{
		if(response)
		{
			new file[128];
			if(strlen(inputtext) == 0)
			{
				ShowPlayerDialog(playerid, IPChange1, DIALOG_STYLE_INPUT, ""RED"Enter Password", "Enter your password to proceed", "Confirm", "Cancel");
				return 0;
			}
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, sizeof(name));
			format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
			if(fexist(file))
			{
			new password[20+1];
	   		INI_ParseFile(file, "PlayerPassword", false, true, playerid, true, false );
			GetPVarString(playerid, "pPass", password, sizeof password);
	   		if(!strcmp(inputtext,password,true))
			 {
			 ShowPlayerDialog(playerid, IPChange2, DIALOG_STYLE_MSGBOX, ""GREEN"Success", "Password confirmed", "NEXT", "Cancel");
			 }
			 else
			 {
			 ShowPlayerDialog(playerid, IPChange1, DIALOG_STYLE_INPUT, ""RED"[ERROR]", ""WHITE"Enter your password to proceed\n\n"RED"Incorrect password", "Confirm", "Cancel");
	         }
	       }
		}
	}
if(dialogid == IPChange2)
	{
		if(response)
		{
			new file[128] ,string[128] ,name[MAX_PLAYER_NAME],IP[80];
			GetPlayerName(playerid, name, sizeof(name));
			format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
			new INI:Acc = INI_Open(file);
			{
	        GetPlayerIp(playerid,rip[playerid],16);
	        INI_WriteString(Acc, "IP", rip[playerid]);
	        INI_Close(Acc);
	        GetPlayerIp(playerid, IP, sizeof(IP));
	        format(string, sizeof string, ""WHITE"New IP: "BLUE"%s \n"GREEN"Saved",IP);
			ShowPlayerDialog(playerid, 1234, DIALOG_STYLE_MSGBOX, ""GREEN"IP Saved", string, "OK", "");
	        }
		}
	}
if(dialogid == Register1)
	{
		if(response)
		{
			new file[128];
			if(strlen(inputtext) == 0)
			{
			ShowPlayerDialog(playerid, Register1, DIALOG_STYLE_INPUT, ""BLUE"Enter Password", "Enter your old password to proceed", "Confirm", "Cancel");
			return 0;
			}
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, sizeof(name));
			format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
			if(fexist(file))
			{
			new password[20+1];
	   		INI_ParseFile(file, "PlayerPassword", false, true, playerid, true, false );
			GetPVarString(playerid, "pPass", password, sizeof password);
	   		if(!strcmp(inputtext,password,true))
			 {
				PlayerOldPassword[playerid] = strlen(inputtext);
	            ShowPlayerDialog(playerid, Register2, DIALOG_STYLE_MSGBOX, ""BLUE"Change Password", "Password "GREEN"confirmed", "NEXT", "Cancel");
			 }
			 else
			 {
			    ShowPlayerDialog(playerid, Register1, DIALOG_STYLE_INPUT, ""BLUE"Enter Password "RED"Faild", "Enter your old password to proceed\n\n"RED"Error ~ Incorrect password", "Confirm", "Cancel");
	         }
	       }
		}
	}
if(dialogid == Register2)
	{
		if(response)
		{
			new file[128] ,string[128] ,name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, sizeof(name));
			format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
	        if(strlen(inputtext) <= MIN_PASS_CHAR)
			{
			format(string, sizeof string, "Please Enter A New Password\n\n"YELLOW"The Password Must Be More Then [%d] Character",MIN_PASS_CHAR);
			ShowPlayerDialog(playerid, Register2, DIALOG_STYLE_INPUT, ""BLUE"Enter Password", string, "Change", "Cancel");
			return 1;
	        }
			if(strlen(inputtext) == PlayerOldPassword[playerid])
			{
			format(string, sizeof string, "Please Enter A New Password\n\n"RED"You Cant Use Your Old Password");
			ShowPlayerDialog(playerid, Register2, DIALOG_STYLE_INPUT, ""BLUE"Enter Password", string, "Change", "Cancel");
			return 1;
	        }
			format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
			new INI:Acc = INI_Open(file);
			{
			INI_WriteString(Acc, "Password", inputtext);
			INI_Close(Acc);
			format(string, sizeof string, ""WHITE"You have "GREEN"successfully"WHITE" changed your password \n\n"GREEN"NEW PASSWORD: "BLUE"%s",inputtext);
			ShowPlayerDialog(playerid, 1233, DIALOG_STYLE_MSGBOX, ""GREEN"Success", string, "OK", "");
	        }
		}
	}
	if(dialogid == Register){
		if(response){
			new file[80],file2[80] ,string[208],name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, sizeof(name));
	        if(strlen(inputtext) <= MIN_PASS_CHAR){
				format(string, sizeof string, "Please Enter A Password\n\n"YELLOW"The Password Must Be More Then [%d] Character",MIN_PASS_CHAR);
				ShowPlayerDialog(playerid, Register, DIALOG_STYLE_INPUT, ""BLUE"Enter Password", string, "Register", "Cancel");
				return 0;
			}
			format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
	  		new INI:Acc = INI_Open(file);
			INI_WriteString(Acc,"Password", inputtext);
			GetPlayerIp(playerid,rip[playerid],16);
	 		INI_WriteString(Acc,"IP",rip[playerid]);
	 		INI_WriteInt(Acc,"Score",GetPlayerScore(playerid));
	  		INI_WriteInt(Acc,"Money",GetPlayerMoney(playerid));
	   		INI_WriteInt(Acc,"Deaths",PlayerInfo[playerid][Deaths]);
	        INI_WriteInt(Acc,"Kills",PlayerInfo[playerid][Kills]);
	        INI_WriteInt(Acc,"ServerTime",PlayerInfo[playerid][ServerTime]);
	        INI_WriteInt(Acc,"FightStyle",GetPlayerFightingStyle(playerid));
	        INI_Close(Acc);
			format(file2,sizeof(file),"/mRegistration/Settings/%s.txt",name);
			new INI:Acc2 = INI_Open(file2);
			INI_WriteInt(Acc2,"AutoLog",PlayerInfo[playerid][AutoLogin]=1);
	        INI_WriteInt(Acc2,"SaveSkin",PlayerInfo[playerid][SaveSkin]=0);
	        INI_WriteInt(Acc2,"PlayerAdmin",PlayerInfo[playerid][PlayerAdmin]=0);
	        INI_Close(Acc2);
			if(!fexist(file)&&!fexist(file2)){
				ShowPlayerDialog(playerid, Register, DIALOG_STYLE_MSGBOX,""RED"Register Error", ""RED"[ERROR]\n\n"WHITE"REGISTER FAILURE\nERROR CODE:"RED" REG_SZ_ALL #003", "OK", "Cancel");
				print("\n====mREGv0.7=============================");
				print("||    Could Not Create File           ||");
	    		print("||    Access is Denied                ||");
				print("||  ERROR CODE: REG_SZ_ALL #003  ||");
				print("=========================================\n");
			}
			else if(!fexist(file)){
				ShowPlayerDialog(playerid, Register, DIALOG_STYLE_MSGBOX,""RED"Register Error", ""RED"[ERROR]\n\n"WHITE"REGISTER FAILURE\nERROR CODE:"RED" REG_SZ #001", "OK", "Cancel");
				print("\n====mREGv0.7=============================");
				print("||    Could Not Create File           ||");
	    		print("||    Access is Denied                ||");
				print("||  ERROR CODE: REG_SZ #001      ||");
				print("=========================================\n");
			}
			else if(!fexist(file2)){
				ShowPlayerDialog(playerid, Register, DIALOG_STYLE_MSGBOX,""RED"Register Error", ""RED"[ERROR]\n\n"WHITE"REGISTER FAILURE\nERROR CODE:"RED" REG_SZ #002", "OK", "Cancel");
				print("\n====mREGv0.7=============================");
				print("||    Could Not Create File           ||");
	    		print("||    Access is Denied                ||");
				print("||  ERROR CODE: REG_SZ #002      ||");
				print("=========================================\n");
			}
			else if(fexist(file) && fexist(file2)){
				GetPlayerName(playerid, name, sizeof(name));
				new IP[80]; GetPlayerIp(playerid, IP, sizeof(IP));
				format(string, sizeof string, ""WHITE"You account is registered!\n\n"GREEN"USERNAME: "BLUE"%s\n"GREEN"PASSWORD: "BLUE"%s\n"GREEN"IP ADDRESS: "BLUE"%s",name,inputtext,IP);
				ShowPlayerDialog(playerid, 4568, DIALOG_STYLE_MSGBOX, ""BLUE"Your Stats!", string, "Ok", "");
	            SendClientMessage(playerid, COLOR_GREEN, "||-Success-||"WHITE" You have successfully registered a new account");
				format(string, sizeof(string), ""YELLOW"[SERVER] "GREEN"%s "WHITE"Has Successfully Registered A New Account", name );
				SendClientMessageToAll(COLOR_GREEN2, string);
				LoadStatus(playerid);
				IsLogged[playerid] = 1;
				PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	   		}
		}
	}
	if(dialogid == Login){
		if(response){
			new file[128] ,string[128] ,PlayerName[24];
	        if(strlen(inputtext) <= MIN_PASS_CHAR){
				GetPlayerName(playerid, PlayerName, sizeof PlayerName);
				format(string, sizeof string, ""WHITE"Please Enter A Password To Login\n\n"YELLOW"The Password Must Be More Then [%d] Character",MIN_PASS_CHAR);
				ShowPlayerDialog(playerid, Login, DIALOG_STYLE_INPUT, ""BLUE"Login", string, "Login", "Cancel");
				return 0;
			}
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, sizeof(name));
			format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
			if(fexist(file)){
				new password[20+1];
				INI_ParseFile(file, "PlayerPassword", false, true, playerid, true, false );
				GetPVarString(playerid, "pPass", password, sizeof password);
			    if(!strcmp(inputtext,password,true)){
					IsLogged[playerid] = 1;
					LoadStatus(playerid);
					SendClientMessage(playerid, COLOR_GREEN, "||-Success-|| "WHITE"You have successfully logged Into Your Account");
					TogglePlayerSpectating(playerid, 0);
					format(string, sizeof(string), "[SERVER] %s has successfully loged In", name );
					SendClientMessageToAll(COLOR_GREEN2, string);
				}
				else{
					if(Warning[playerid]==2){
						Warning[playerid]=0;
						format(string, sizeof (string), "%s kicked || Reason: incorrect password [3/3 Tries]",name);
						SendClientMessageToAll(COLOR_RED,string);
						ShowPlayerDialog(playerid, 1231, DIALOG_STYLE_INPUT, ""RED"[ERROR]", ""RED"FAILD TO LOGIN \n\nIncorrect Password\n"BLUE"[3/3 Tries]", "Login", "Cancel");
						Kick(playerid);
					}
					if(Warning[playerid]==1){
						Warning[playerid]++;
						ShowPlayerDialog(playerid, Login, DIALOG_STYLE_INPUT, ""RED"[ERROR]", ""RED"Incorrect Password \n"BLUE"[2/3 Tries]", "Login", "Cancel");
					}
					if(Warning[playerid]==0){
						Warning[playerid]++;
						ShowPlayerDialog(playerid, Login, DIALOG_STYLE_INPUT, ""RED"[ERROR]", ""RED"Incorrect Password \n"BLUE"[1/3 Tries]", "Login", "Cancel");
					}
				}
			}
		}
	}
	return 0;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source){
	new string[308];
	new kills = PlayerInfo[clickedplayerid][Kills];
	new deaths = PlayerInfo[clickedplayerid][Deaths];
	format(string, sizeof string, ""BLUE"Account STATUS!"WHITE"\n\nUSERNAME: "BLUE"%s"WHITE"\nTimeOnServer %d\nMoney %d$ \nScore %d \nKilles %d \nDeaths %d \nWantedLevel %d \n"ORANGE"AdminLevel= %d",Pname,PlayerInfo[clickedplayerid][ServerTime],GetPlayerMoney(clickedplayerid),GetPlayerScore(clickedplayerid),kills,deaths,GetPlayerWantedLevel(clickedplayerid),PlayerInfo[clickedplayerid][PlayerAdmin]);
	ShowPlayerDialog(playerid, PMMSG, DIALOG_STYLE_MSGBOX, ""BLUE"Stats!", string, "Ok", "PM");
	pmplayerid = clickedplayerid;
	return 1;
}
public LoadStatus(playerid){
	OnPlayerLogin(playerid);
	new name[MAX_PLAYER_NAME],file[80];GetPlayerName(playerid, name, sizeof(name));
	format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
	INI_ParseFile(file, "LoadUser", false, true, playerid, true, false);
	if(fexist(file)){
		SetPlayerScore(playerid,GetPVarInt(playerid, "Score"));
		GivePlayerMoney(playerid,GetPVarInt(playerid, "Money"));
		PlayerInfo[playerid][Deaths] = GetPVarInt(playerid, "Deaths");
		PlayerInfo[playerid][Kills] = GetPVarInt(playerid, "Kills");
		SetPlayerWantedLevel(playerid,GetPVarInt(playerid, "WantedLevel"));
		PlayerInfo[playerid][ServerTime] = GetPVarInt(playerid, "ServerTime");
		SetPlayerFightingStyle(playerid,GetPVarInt(playerid, "FightingStyle"));
		TimeTimer = SetTimerEx("TimeOnServer", 1000, 1, "i", playerid);
	}
	format(file,sizeof(file),"/mRegistration/Settings/%s.txt",name);
	INI_ParseFile(file, "LoadUserSettings", false, true, playerid, true, false );
	if(fexist(file)){
		PlayerInfo[playerid][PlayerAdmin] = GetPVarInt(playerid, "PlayerAdmin");
		PlayerInfo[playerid][SavePosition] = GetPVarInt(playerid, "SavePosition");
	}
	return 1;
}
public SaveStatus(playerid){
	new name[MAX_PLAYER_NAME], file[128];
	GetPlayerName(playerid, name, sizeof(name));
	format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
	if(fexist(file)){
		new INI:Acc = INI_Open(file);
		INI_WriteInt(Acc,"Score",GetPlayerScore(playerid));
		INI_WriteInt(Acc,"Money",GetPlayerMoney(playerid));
		INI_WriteInt(Acc,"Deaths",PlayerInfo[playerid][Deaths]);
		INI_WriteInt(Acc,"Kills",PlayerInfo[playerid][Kills]);
		INI_WriteInt(Acc,"WantedLevel",GetPlayerWantedLevel(playerid));
		INI_WriteInt(Acc,"DrunkLevel",GetPlayerDrunkLevel(playerid));
		INI_WriteInt(Acc,"ServerTime",PlayerInfo[playerid][ServerTime]);
		INI_WriteInt(Acc,"FightStyle",GetPlayerFightingStyle(playerid));
		INI_Close(Acc);
	}
	format(file,sizeof(file),"/mRegistration/Settings/%s.txt",name);
	new INI:Acc2 = INI_Open(file);
	if(fexist(file)){
		INI_WriteInt(Acc2,"SavePosition",PlayerInfo[playerid][SavePosition]=1);
		INI_Close(Acc2);
	}
	return 1;
}
public RunAutoSave(playerid){
new name[MAX_PLAYER_NAME], file[128];
	if(IsLogged[playerid] == 1){
		GetPlayerName(playerid, name, sizeof(name));
		format(file,sizeof(file),"/mRegistration/Users/%s.txt",name);
		if(fexist(file)){
			new INI:Acc = INI_Open(file);
			INI_WriteInt(Acc,"Score",GetPlayerScore(playerid));
			INI_WriteInt(Acc,"Money",GetPlayerMoney(playerid));
			INI_WriteInt(Acc,"Deaths",PlayerInfo[playerid][Deaths]);
			INI_WriteInt(Acc,"Kills",PlayerInfo[playerid][Kills]);
			INI_WriteInt(Acc,"WantedLevel",GetPlayerWantedLevel(playerid));
			INI_WriteInt(Acc,"DrunkLevel",GetPlayerDrunkLevel(playerid));
			INI_WriteInt(Acc,"ServerTime",PlayerInfo[playerid][ServerTime]);
			INI_WriteInt(Acc,"FightStyle",GetPlayerFightingStyle(playerid));
			INI_Close(Acc);
		}
		format(file,sizeof(file),"/mRegistration/Settings/%s.txt",name);
		if(fexist(file)){
			new INI:Acc2 = INI_Open(file);
			INI_WriteInt(Acc2,"PlayerAdmin",PlayerInfo[playerid][PlayerAdmin]);
			INI_Close(Acc2);
		}
	}
	return 1;
}
public ResetSettings(playerid){
	PlayerInfo[playerid][PlayerAdmin] = 0;
	PlayerInfo[playerid][SavePosition] = 0;
	PlayerReconnecting[playerid] = 0;
	PlayerInfo[playerid][posx] = 0;
	PlayerInfo[playerid][posy] = 0;
	PlayerInfo[playerid][posz] = 0;
	ResetPlayerMoney(playerid);
}
public IsLoggedTimer(){
for(new i=0;i<MAX_PLAYERS;i++) IsLogged[i] = 1;
}
stock IsNumeric(string[]){
    for (new i = 0, j = strlen(string); i < j; i++){
        if (string[i] > '9' || string[i] < '0') return 0;
    }
    return 1;
}
ReturnUser(text[], playerid = INVALID_PLAYER_ID){
	new pos = 0;
	while (text[pos] < 0x21){
		if (text[pos] == 0) return INVALID_PLAYER_ID;
		pos++;
	}
	new userid = INVALID_PLAYER_ID;
	if (IsNumeric(text[pos])){
		userid = strval(text[pos]);
		if (userid >=0 && userid < MAX_PLAYERS){
			if(!IsPlayerConnected(userid)){
				userid = INVALID_PLAYER_ID;
			}
			else{
				return userid;
			}
		}
	}
    new len = strlen(text[pos]);
	new count = 0;
	new name[MAX_PLAYER_NAME];
	for (new i = 0; i < MAX_PLAYERS; i++){
		if (IsPlayerConnected(i)){
			GetPlayerName(i, name, sizeof (name));
			if (strcmp(name, text[pos], true, len) == 0){
				if (len == strlen(name)){
					return i;
				}
				else{
					count++;
					userid = i;
				}
			}
		}
	}
	if (count != 1){
		if (playerid != INVALID_PLAYER_ID){
			if (count){
				SendClientMessage(playerid, COLOR_RED, "Multiple users found, narrow earch!!!");
			}
			else{
				SendClientMessage(playerid, COLOR_RED, "No matching user found!!!");
			}
		}
		userid = INVALID_PLAYER_ID;
	}
	return userid;
}
adminspec_strtok(const string[], &index){
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' ')){
		index++;
	}
	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1))){
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
#endif
