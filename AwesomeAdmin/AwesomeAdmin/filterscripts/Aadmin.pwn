/*
CREDITS:
Here are the credits
wikitmp.sa-mp.com( for teaching me xD )
kyeman's ADMIN SPECTATE FILTER SCRIPT ( the /specplayer command )
*/







#include <a_samp>
#include dini
#include time
// This is a comment
// uncomment the line below if you want to write a filterscript
#define FILTERSCRIPT
forward wepcheck(playerid);
new gPlayerLogged[MAX_PLAYERS];
new gPlayerRegged[MAX_PLAYERS];
new gSpectateID[MAX_PLAYERS];
new gSpectateType[MAX_PLAYERS];
new NotLogged[MAX_PLAYERS];

#define ADMIN_SPEC_TYPE_NONE 0
#define ADMIN_SPEC_TYPE_PLAYER 1
#define ADMIN_SPEC_TYPE_VEHICLE 2

forward AdminLevel(playerid);

new playerColors[100] = {
0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,0xEE82EEFF,0xFFD720FF,
0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,
0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,
0x275222FF,0xF09F5BFF,0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,
0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,0x4B8987FF,
0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,0x48C000FF,0x2A51E2FF,0xE3AC12FF,
0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,
0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,
0x9F945CFF,0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,
0x3FE65CFF
};


#if defined FILTERSCRIPT
#define COLOR_RED 0xAA3333AA// all the colour definitions
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_LIME 0x10F441AA
#define COLOR_MAGENTA 0xFF00FFFF
#define COLOR_NAVY 0x000080AA
#define COLOR_AQUA 0xF0F8FFAA
#define COLOR_CRIMSON 0xDC143CAA
#define COLOR_FLBLUE 0x6495EDAA
#define COLOR_BISQUE 0xFFE4C4AA
#define COLOR_BLACK 0x000000AA
#define COLOR_CHARTREUSE 0x7FFF00AA
#define COLOR_BROWN 0xA52A2AAA
#define COLOR_CORAL 0xFF7F50AA
#define COLOR_GOLD 0xB8860BAA
#define COLOR_GREENYELLOW 0xADFF2FAA
#define COLOR_INDIGO 0x4B00B0AA
#define COLOR_IVORY 0xFFFF82AA
#define COLOR_LAWNGREEN 0x7CFC00AA
#define COLOR_LIMEGREEN 0x32CD32AA
#define COLOR_MIDNIGHTBLUE 0x191970AA
#define COLOR_MAROON 0x800000AA
#define COLOR_OLIVE 0x808000AA
#define COLOR_ORANGERED 0xFF4500AA
#define COLOR_PINK 0xFFC0CBAA
#define COLOR_SPRINGGREEN 0x00FF7FAA
#define COLOR_TOMATO 0xFF6347AA
#define COLOR_YELLOWGREEN 0x9ACD32AA
#define COLOR_MEDIUMAQUA 0x83BFBFAA
#define COLOR_MEDIUMMAGENTA 0x8B008BAA
#define COLOR_BRIGHTRED 0xDC143CAA
#define COLOR_SYSTEM 0xEFEFF7AA
#define COLOR_PURPLE 0x330066AA
enum gPlayerInfo {
	Level,
	Muted,
	Kills,
	Deaths,
	Jailed,
	SeePMs,
	SeeCMDs,
	FailLog,
	Kicked,
	DisabledCMDs,
	Warned,
	God,
	GodCar
};
enum gServerInfo {
	RconLocked
};

forward jailtimer(playerid);
new ServerInfo[gServerInfo];

new PlayerInfo[MAX_PLAYERS][gPlayerInfo];
public OnFilterScriptInit()
{


	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{

return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

#endif

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("Blank Script");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
PlayerInfo[playerid][Muted] = 0;
PlayerInfo[playerid][Level] = 0;
ServerInfo[RconLocked] = 0;
gPlayerLogged[playerid] = 0;
PlayerInfo[playerid][Jailed] = 0;
PlayerInfo[playerid][SeePMs] = 0;
PlayerInfo[playerid][SeeCMDs] = 0;
PlayerInfo[playerid][FailLog] = 0;
PlayerInfo[playerid][Kicked] = 0;
PlayerInfo[playerid][DisabledCMDs] = 0;
PlayerInfo[playerid][Warned] = 0;
PlayerInfo[playerid][God] = 0;
PlayerInfo[playerid][GodCar] = 0;
TogglePlayerClock(playerid,true);
new string[128];
new user[128];

GetPlayerName(playerid, user, MAX_PLAYER_NAME);
format(user, sizeof(user), "AwesomeAdmin/Users/%s.txt", user);
if(dini_Exists(user))
{
gPlayerRegged[playerid] = 1;
gPlayerLogged[playerid] = 0;
SendClientMessage(playerid,COLOR_TOMATO,"Your account is Registered please login with /login");
PlayerInfo[playerid][Level] = dini_Int(user,"Level");
PlayerInfo[playerid][Kills] = dini_Int(user,"Kills");
PlayerInfo[playerid][Deaths] = dini_Int(user,"Deaths");
PlayerInfo[playerid][Muted] = dini_Int(user,"TimesMuted");
PlayerInfo[playerid][Jailed] = dini_Int(user,"TimesJailed");
PlayerInfo[playerid][Kicked] = dini_Int(user,"TimesKicked");
}
else
{
gPlayerRegged[playerid] = 0;
SendClientMessage(playerid,COLOR_GREEN,"Your account is not Registered please register with /register <password>");
}


new pname[MAX_PLAYER_NAME];
new ip[30];
GetPlayerName(playerid,pname,sizeof(pname));
GetPlayerIp(playerid,ip,sizeof(ip));
format(string,sizeof(string),"%s(ID: %d) (IP: %d) \r\n",pname,playerid,ip);

new File:ftw=fopen("AwesomeAdmin/logs/Connects.txt", io_append);

GetPlayerName(playerid, pname, 24);
fwrite(ftw, string);
fclose(ftw);

return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
gPlayerLogged[playerid] = 0;
gPlayerRegged[playerid] = 0;
PlayerInfo[playerid][Level] = 0;
PlayerInfo[playerid][Kills] = 0;
PlayerInfo[playerid][Deaths] = 0;
PlayerInfo[playerid][Muted] = 0;
PlayerInfo[playerid][Jailed] = 0;
PlayerInfo[playerid][Kicked] = 0;
PlayerInfo[playerid][God] = 0;
new pname[MAX_PLAYER_NAME];
new string[128];
GetPlayerName(playerid,pname,sizeof(pname));

format(string,sizeof(string),"%s(ID: %d)\r\n",pname,playerid);

new File:ftw=fopen("AwesomeAdmin/logs/Disonnects.txt", io_append);

GetPlayerName(playerid, pname, 24);
fwrite(ftw, string);
fclose(ftw);

return 1;
}

public OnPlayerSpawn(playerid)
{
if(gPlayerLogged[playerid] == 0)
{
NotLogged[playerid] = 1;
SetPlayerHealth(playerid,0.00);
SendClientMessage(playerid,COLOR_BRIGHTRED,"Please Login before you spawn!!!");
}
else
{
NotLogged[playerid] = 0;
}
new ip[16];
new pname[MAX_PLAYER_NAME];
new string[128];

GetPlayerIp(playerid,pname,sizeof(ip));
GetPlayerName(playerid,pname,sizeof(pname));
new Float:health;
GetPlayerHealth(playerid,health);
health = GetPlayerHealth(playerid,health);
new Float:armour;
GetPlayerArmour(playerid,armour);
armour = GetPlayerArmour(playerid,armour);
format(string,sizeof(string),"%s (ID: %d) has spawned. Health: %f Armour: %f, IP: %d\r\n",pname,playerid,health,armour,ip);

new File:ftw=fopen("AwesomeAdmin/logs/Spawns.txt", io_append);

GetPlayerName(playerid, pname, 24);
fwrite(ftw, string);
fclose(ftw);

return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
if(NotLogged[playerid] == 1)
{
ForceClassSelection(playerid);
}
if(PlayerInfo[playerid][Jailed] == 1)
{

SetPlayerInterior(playerid,3);
SetPlayerPos(playerid,197.6661, 173.8179, 1003.0234);
SendClientMessage(playerid,COLOR_LIMEGREEN,"You have died while jailed!, you have appeared back in jail!");
}



new string[128];
new playerfile[256];
new killerfile[256];
new playername[MAX_PLAYER_NAME];
new killername[MAX_PLAYER_NAME];
PlayerInfo[killerid][Kills]++;
PlayerInfo[playerid][Deaths]++;
GetPlayerName(playerid,playername,sizeof(playername));
GetPlayerName(killerid,killername,sizeof(killername));
format(playerfile,sizeof(playerfile),"AwesomeAdmin/Users/%s.txt",playername);
format(killerfile,sizeof(killerfile),"AwesomeAdmin/Users/%s.txt",killername);
if(dini_Exists(playerfile))
{
		dini_IntSet(playerfile,"Deaths",PlayerInfo[playerid][Deaths]);
}
if(dini_Exists(killerfile))
{
		dini_IntSet(killerfile,"Kills",PlayerInfo[playerid][Kills]);
}
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid,pname,sizeof(pname));

format(string,sizeof(string),"%s(ID: %d)\r\n",pname,playerid);

new File:ftw=fopen("AwesomeAdmin/logs/Deaths.txt", io_append);

GetPlayerName(playerid, pname, 24);
fwrite(ftw, string);
fclose(ftw);

new kname[MAX_PLAYER_NAME];

GetPlayerName(killerid,kname,sizeof(kname));
format(string,sizeof(string),"%s (ID: %d) killed %s (ID: %d)\r\n",kname,killerid,pname,playerid);

new File:ftw1=fopen("AwesomeAdmin/logs/Kills.txt", io_append);

GetPlayerName(playerid, pname, 24);
fwrite(ftw1, string);
fclose(ftw1);

return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(PlayerInfo[playerid][Muted] == 1)
	{
		SendClientMessage(playerid,COLOR_GREEN,"You are muted!, feel you shouldn't be?");
		SendClientMessage(playerid,COLOR_GREEN,"then contact an admin using /pm or");
		SendClientMessage(playerid,COLOR_GREEN,"put a * before your message...");
		return 0;
	}
 	new string[128];
 	new ip[16];
  	new name[MAX_PLAYER_NAME];
  	new pname[MAX_PLAYER_NAME];
  	GetPlayerIp(playerid,ip,sizeof(ip));
  	GetPlayerName(playerid,name,sizeof(name));
  	format(string,sizeof(string),"%s(ID: %d)(IP: %d): %s \r\n",name,playerid,ip,text);
   	new File:ftw=fopen("AwesomeAdmin/logs/chat.txt", io_append);
    GetPlayerName(playerid, pname, 24);
    fwrite(ftw, string);
    fclose(ftw);

	if(text[0] == '*')
    {

		new Data[3][256];
		GetPlayerName(playerid, Data[2], 24);
        format(string, 256, "* ReportMessage from %s (ID: %d). Message: %s \r\n", Data[2],playerid, text);

		new File:ftw1=fopen("AwesomeAdmin/logs/reports.txt", io_append);
		GetPlayerName(playerid, pname, 24);
		fwrite(ftw1, string);
		fclose(ftw1);
        SendClientMessage(playerid,COLOR_YELLOW,"Your message has been sent to the online admins.");
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && PlayerInfo[i][Level] >= 1)
            {
                SendClientMessage(i,COLOR_BRIGHTRED,string);
			}
		}
		return 0;
}







	return 1;
}

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
//=====================Admin---Read----PMS-----------------------
	new string[128];
	new name[MAX_PLAYER_NAME];
	new rname[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,sizeof(name));
	GetPlayerName(recieverid,rname,sizeof(rname));
	format(string,sizeof(string),"* PrivateMessage from %s (ID: %d) to %s(ID: %d), Message: %s \r\n\n", name,playerid,rname,recieverid, text);


	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	if(IsPlayerConnected(i) && PlayerInfo[i][Level] >= 1 && PlayerInfo[i][SeePMs] == 1)
 	{
  		SendClientMessage(i,COLOR_BRIGHTRED,string);
	}
	}
		
  //=======================Saving PMs to a log============================
	new nname[MAX_PLAYER_NAME];
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,sizeof(name));
	format(string,sizeof(string),"%s(ID: %d): %s \r\n",nname,playerid,text);
	new File:ftw=fopen("AwesomeAdmin/logs/PMs.txt", io_append);
	GetPlayerName(playerid, pname, 24);
	fwrite(ftw, string);
	fclose(ftw);
		
		
		
		
		
		
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
		    new cmd[256];
		    new idx;
		    cmd = strtok(cmdtext, idx);

			new Player[MAX_PLAYER_NAME];
			new String[128];
			GetPlayerName(playerid,Player,sizeof(Player));
			format(String,sizeof(String),"Name %s (ID: %d) Command: %s\r\n",Player,playerid,cmdtext);
			new File:ftw1=fopen("AwesomeAdmin/logs/CMDs.txt", io_append);
			GetPlayerName(playerid, Player, 24);
			fwrite(ftw1, String);
			fclose(ftw1);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
   			if(IsPlayerConnected(i) && PlayerInfo[i][Level] >= 1 && PlayerInfo[i][SeeCMDs] == 1)
   			{
      		SendClientMessage(i, COLOR_RED, String);
		    }

			}
			if(PlayerInfo[playerid][DisabledCMDs] == 1)
			{
			SendClientMessage(playerid,COLOR_WHITE,"You cannot use commands whilst Jailed!");
			return 1;
			}
			if(strcmp(cmd,"/mystats",true) == 0)
			{
			new string[128];
			format(string,sizeof(string),"Deaths: %d, Kills: %d, Cash: %d, Times Jailed: %d",PlayerInfo[playerid][Deaths],PlayerInfo[playerid][Kills],GetPlayerMoney(playerid),PlayerInfo[playerid][Jailed]);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			format(string, sizeof(string),"Times Muted: %d, AdminLevel: %d",PlayerInfo[playerid][Muted],PlayerInfo[playerid][Level]);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);

			return 1;
			}




			
			if(strcmp(cmd,"/register",true) == 0)
			{
			new file[256];
			new name[MAX_PLAYER_NAME];
			new tmp[256];
			new year,month,day;
			new ip[100];
			tmp = strtok(cmdtext, idx);


			if(gPlayerLogged[playerid] == 1)
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: Your already registered.");
			return 1;
			}
			if(gPlayerRegged[playerid] == 1)
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: Your already registered.");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /register <password>");
			return 1;
			}


			GetPlayerName(playerid,name,sizeof(name));
			format(file,sizeof(file),"AwesomeAdmin/Users/%s.txt",name);
			if(dini_Exists(file))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: Your allready registered! please \"/login\"");
			return 1;
			}
			else
			{

			dini_Create(file);
			dini_Set(file,"Password",tmp);
			dini_IntSet(file,"Level",1);
			GetPlayerIp(playerid,ip,sizeof(ip));
			dini_Set(file,"IP",ip);
			dini_IntSet(file,"Kills",PlayerInfo[playerid][Kills]);
			dini_IntSet(file,"Deaths",PlayerInfo[playerid][Deaths]);
			getdate(year,month,day);
			dini_IntSet(file,"RegistrationDay",day);
			dini_IntSet(file,"RegistrationMonth",month);
			dini_IntSet(file,"RegistrationYear",year);
			SendClientMessage(playerid,COLOR_GREEN,"You have now registered and automatically been logged in");
			gPlayerLogged[playerid] = 1;
			gPlayerRegged[playerid] = 1;
			}
			return 1;
			}

			if(strcmp(cmd,"/login",true) == 0)
			{
			new tmp[256];
			new tmp2[256];
			new file[256];
			new name[MAX_PLAYER_NAME];
			new ip[100];

			if(gPlayerRegged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: You have to \"/register\" before you \"/login\"");
			return 1;
			}
			if(gPlayerLogged[playerid] == 1)
			{
				SendClientMessage(playerid,COLOR_WHITE,"SERVER: Your already logged in!");
				return 1;
			}

			tmp = strtok(cmdtext, idx);
			GetPlayerName(playerid,name,sizeof(name));
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,COLOR_WHITE,"SERVER: /login <password>");
				return 1;
			}

			format(file,sizeof(file),"AwesomeAdmin/Users/%s.txt",name);
			if(!dini_Exists(file))
			{
				SendClientMessage(playerid,COLOR_WHITE,"SERVER: Please /register with \"/register <password>\"");
				return 1;
			}
			tmp2 = dini_Get(file,"Password");
			if(strcmp(tmp,tmp2,false) != 0)
			{
				SendClientMessage(playerid,COLOR_LIMEGREEN,"Wrong Password!");
			}
			else
			{

			dini_Set(file,"Password",tmp);
			GetPlayerIp(playerid,ip,sizeof(ip));
			dini_Set(file,"IP",ip);
			PlayerInfo[playerid][Level] = dini_Int(file,"Level");
 			PlayerInfo[playerid][Kills] = dini_Int(file,"Kills");
 			PlayerInfo[playerid][Deaths] = dini_Int(file,"Deaths");

			gPlayerLogged[playerid] = 1;

			}
			return 1;
			}

			
			
			
			
			
			
			
			
			
			
			
			
			
			
			




/*
=============================================================================
=============================================================================
==================================ADMIN COMMANDS=============================
=============================================================================
=============================================================================
*/

			if(strcmp(cmd,"/admincmds",true) == 0)
			{
			if(PlayerInfo[playerid][Level] <= 0)
			{
			SendClientMessage(playerid,COLOR_YELLOW,"You have to be an admin to view these commands!");
			}
			if(PlayerInfo[playerid][Level] >= 1)
			{
			SendClientMessage(playerid,COLOR_WHITE,"/mute /umute /slap /muteall /unmuteall /kick /weather /setmoney /explodeall");
			SendClientMessage(playerid,COLOR_WHITE,"/akill /ban /healall /armourall /goto /get /freeze /giveweapon /eject");
			SendClientMessage(playerid,COLOR_WHITE,"/lockrcon /unlockrcon /jail /sethealth /getcar /gmx /unfreeze /setarmour /ejectall");
			SendClientMessage(playerid,COLOR_WHITE,"/rain /foggy /sandstorm /bluesky /stormy /givemoney /setskin /startclock");
			SendClientMessage(playerid,COLOR_WHITE,"/warn /setwanted /explode /akillall /unloadfs /loadfs /removecash /stopclock");
			SendClientMessage(playerid,COLOR_WHITE,"/giveallweapon /setkills /setdeaths /changemode /skydiveall /skydive /stopallclock");
			SendClientMessage(playerid,COLOR_WHITE,"/jetpack /antiminigun /force /forceall /carhealth /ann /say /ssay /startallclock");
			SendClientMessage(playerid,COLOR_WHITE,"/settime /colour /spec /kickall /carcolour /god /godoff /godcar /godcaroff");
			SendClientMessage(playerid,COLOR_WHITE,"/gravity /setallhealth");
			}
			return 1;
			}


			if(strcmp(cmd,"/setlevel",true) == 0)//Logged into rcon only
			{
			new tmp[256];
			new id;
			new newlevel;
			new file[256];
			tmp = strtok(cmdtext, idx);
			if(!IsPlayerAdmin(playerid))
			{
			SendClientMessage(playerid,COLOR_RED,"You're not a high enough level to use this command");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /setlevel [id] [level]");
			return 1;
			}
			id = strval(tmp);
			if(!IsPlayerConnected(id))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: Invalid ID.");
			return 1;
			}
			if(gPlayerLogged[id] == 0)
			{
		    new string[128];
		    new name[MAX_PLAYER_NAME];
		    GetPlayerName(id,name,sizeof(name));
		    format(string,sizeof(string),"SERVER: %s is not logged.",name);
			SendClientMessage(playerid,COLOR_WHITE,string);
			return 1;
			}

			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /setlevel [id] [new level]");
			return 1;
			}
			newlevel = strval(tmp);

			PlayerInfo[id][Level] = newlevel;
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			
			new nname[MAX_PLAYER_NAME];
			
			GetPlayerName(id,nname,sizeof(nname));
			
			format(string,sizeof(string)," * You have set %s's level to %d.",nname,newlevel);
			SendClientMessage(playerid,COLOR_GREEN,string);
			
			format(string,sizeof(string)," * Admin %s set your level to %d.",name,newlevel);
			SendClientMessage(id,COLOR_LIGHTBLUE,string);
			
			format(file,sizeof(file),"AwesomeAdmin/Users/%s.txt",nname);
			dini_IntSet(file,"Level",newlevel);
			return 1;
		    }
   			if(strcmp(cmd,"/slap",true) == 0)
			{
			new tmp[256];
			new id;

			tmp = strtok(cmdtext, idx);
			if(PlayerInfo[playerid][Level] <= 2)
			{
			SendClientMessage(playerid,COLOR_RED,"You have to be Level 3 to use this command!");
			return 1;
			}
			if(PlayerInfo[playerid][Level] < PlayerInfo[id][Level])
			{
			SendClientMessage(playerid,COLOR_RED,"You CANNOT use this command on a player with a higher level then you!");
			return 1;
			}
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}



			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /akill [id]");
			return 1;
			}
			id = strval(tmp);
			if(!IsPlayerConnected(id))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: Invalid ID.");
   			return 1;
			}


			tmp = strtok(cmdtext, idx);
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));

			new nname[MAX_PLAYER_NAME];

			GetPlayerName(id,nname,sizeof(nname));

			format(string,sizeof(string)," * You have slapped %s",nname);
			SendClientMessage(playerid,COLOR_YELLOW,string);

			format(string,sizeof(string)," * you have been slapped by %s",name);
			SendClientMessage(id,COLOR_YELLOW,string);


			new Float:health;
			GetPlayerHealth(playerid, health);
			SetPlayerHealth(playerid, health-5);
			return 1;
		    }


			if(strcmp(cmd,"/seepms",true) == 0)
			{
			new string[128];
			new pname[MAX_PLAYER_NAME];
			GetPlayerName(playerid,pname,sizeof(pname));
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(PlayerInfo[playerid][Level] >= 2)
			{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
			if(IsPlayerConnected(i) && PlayerInfo[i][Level] >= 1)
			{
			format(string,sizeof(string),"%s can now see players PMs",pname);
			SendClientMessage(i,COLOR_LIMEGREEN,string);
			PlayerInfo[playerid][SeePMs] = 1;
			}
			}
			}
			else
			{
			SendClientMessage(playerid,COLOR_GREEN,"Your not a high enough level to use this command.");
			}
			return 1;
			}
			if(strcmp(cmd,"/seecmds",true) == 0)
			{
			new string[128];
			new pname[MAX_PLAYER_NAME];
			GetPlayerName(playerid,pname,sizeof(pname));
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(PlayerInfo[playerid][Level] >= 1)
			{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
			if(IsPlayerConnected(i) && PlayerInfo[i][Level] >= 1)
			{
			format(string,sizeof(string),"%s can now see players CMDs",pname);
			SendClientMessage(i,COLOR_LIMEGREEN,string);
			PlayerInfo[playerid][SeeCMDs] = 1;
			}
			}
			}
			else
			{
			SendClientMessage(playerid,COLOR_GREEN,"You have to be level 2 to use this command!");
			}
			return 1;
			}
		    
   			if(strcmp(cmd,"/akill",true) == 0)
			{
			new tmp[256];
			new id;

			tmp = strtok(cmdtext, idx);
			if(PlayerInfo[playerid][Level] <= 3)
			{
			SendClientMessage(playerid,COLOR_RED,"You have to be Level 4 to use this command!");
			return 1;
			}
			if(PlayerInfo[playerid][Level] < PlayerInfo[id][Level])
			{
			SendClientMessage(playerid,COLOR_RED,"You CANNOT use this command on a player with a higher level then you!");
			return 1;
			}
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			
			
			
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /akill [id]");
			return 1;
			}
			id = strval(tmp);
			if(!IsPlayerConnected(id))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: Invalid ID.");
   			return 1;
			}


			tmp = strtok(cmdtext, idx);
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));

			new nname[MAX_PLAYER_NAME];

			GetPlayerName(id,nname,sizeof(nname));

			format(string,sizeof(string)," * You have killed %s",nname);
			SendClientMessage(playerid,COLOR_YELLOW,string);

			format(string,sizeof(string)," * you have been killed by %s",name);
			SendClientMessage(id,COLOR_YELLOW,string);

			SetPlayerHealth(id,0.00);
			return 1;
		    }
		    
		    
		    
		    

			if(strcmp(cmd,"/mute",true) == 0)
			{
			new tmp[256];
			new mutefile[128];
			new id;

			tmp = strtok(cmdtext, idx);
			if(PlayerInfo[playerid][Level] <= 1)
			{
			SendClientMessage(playerid,COLOR_RED,"You have to be Level 2 to use this command!");
			return 1;
			}
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /mute [id]");
			return 1;
			}
			id = strval(tmp);
			if(!IsPlayerConnected(id))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: Invalid ID.");
   			return 1;
			}

			tmp = strtok(cmdtext, idx);
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));

			new nname[MAX_PLAYER_NAME];

			GetPlayerName(id,nname,sizeof(nname));

			format(string,sizeof(string)," * You have muted %s *",nname);
			SendClientMessage(playerid,COLOR_YELLOW,string);

			format(string,sizeof(string)," * you have been muted by %s. dont try to speak because you are muted!",name);
			SendClientMessage(id,COLOR_BRIGHTRED,string);
			
			PlayerInfo[id][Muted]++;
			format(mutefile,sizeof(mutefile),"AwesomeAdmin/Users/%s.txt",nname);
			if(dini_Exists(mutefile))
			{
			dini_IntSet(mutefile,"TimesMuted",PlayerInfo[id][Muted]);
			}
			PlayerInfo[id][Muted] = 1;
			return 1;
		    }

			if(strcmp(cmd,"/unmute",true) == 0)
			{
			new tmp[256];
			new id;

			tmp = strtok(cmdtext, idx);
			if(PlayerInfo[playerid][Level] <= 1)
			{
			SendClientMessage(playerid,COLOR_RED,"You have to be Level 2 to use this command!");
			return 1;
			}
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /unmute [id]");
			return 1;
			}
			id = strval(tmp);
			if(!IsPlayerConnected(id))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: Invalid ID.");
   			return 1;
			}


			tmp = strtok(cmdtext, idx);
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));

			new nname[MAX_PLAYER_NAME];

			GetPlayerName(id,nname,sizeof(nname));

			format(string,sizeof(string)," * You have unmuted %s",nname);
			SendClientMessage(playerid,COLOR_YELLOW,string);

			format(string,sizeof(string)," * you have been unmuted by %s. You can now speak!",name);
			SendClientMessage(id,COLOR_BRIGHTRED,string);

			PlayerInfo[id][Muted] = 0;
			return 1;
		    }
			if(strcmp(cmd,"/kick",true) == 0)
			{
			new tmp[256];
			tmp = strtok(cmdtext, idx);
			new id;

			tmp = strtok(cmdtext, idx);
			if(PlayerInfo[playerid][Level] <= 3)
			{
			SendClientMessage(playerid,COLOR_RED,"You have to be Level 4 to use this command!");
			return 1;
			}
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /kick [id] [reason]");
			return 1;
			}
			id = strval(tmp);
			if(IsPlayerConnected(id))
			{
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' ')) {
			idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
			result[idx - offset] = cmdtext[idx];
			idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
						SendClientMessage(playerid, COLOR_RED, "SERVER: /kick [id] [reason]");
			}
			else
			{
			tmp = strtok(cmdtext, idx);
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));

			new nname[MAX_PLAYER_NAME];

			GetPlayerName(id,nname,sizeof(nname));

			format(string,sizeof(string)," * You have kicked %s Reason: %s",nname,result);
			SendClientMessage(playerid,COLOR_YELLOW,string);

			format(string,sizeof(string)," * you have been kicked by %s Reason: %s ",name,result);
			SendClientMessage(id,COLOR_BRIGHTRED,string);

			format(string,sizeof(string)," * %s has been kicked by %s. Reason: %s *",nname,name,result);
			
			new kickfile[128];
			new pname[MAX_PLAYER_NAME];
			GetPlayerName(id,pname,sizeof(pname));
			format(string,sizeof(string),"%s (ID: %d) has been kicked! Reason: %s \r\n",pname,id,result);
			new File:ftw=fopen("AwesomeAdmin/logs/Kicks.txt", io_append);
			fwrite(ftw, string);
			fclose(ftw);
			Kick(id);
			PlayerInfo[id][Kicked]++;
			format(kickfile,sizeof(kickfile),"AwesomeAdmin/Users/%s.txt",pname);
			if(dini_Exists(kickfile))
			{
			dini_IntSet(kickfile,"TimesKicked",PlayerInfo[id][Kicked]);
			}
			SendClientMessage(id,COLOR_BRIGHTRED,"You have been kicked, if you come back to this server obey the rules!");
			}
			return 1;
		    }
		    }

			if(strcmp(cmd,"/ban",true) == 0)
			{
			new tmp[256];
			new id;

			tmp = strtok(cmdtext, idx);
			if(PlayerInfo[playerid][Level] <= 5)
			{
			SendClientMessage(playerid,COLOR_RED,"You have to be Level 6 to use this command!");
			return 1;
			}
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /ban [id] [reason]");
			return 1;
			}
			id = strval(tmp);
			if(IsPlayerConnected(id))
			{
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' ')) {
			idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
			result[idx - offset] = cmdtext[idx];
			idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
						SendClientMessage(playerid, COLOR_RED, "SERVER: /ban [id] [reason]");
			}
			else
			{
			tmp = strtok(cmdtext, idx);
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));

			new nname[MAX_PLAYER_NAME];

			GetPlayerName(id,nname,sizeof(nname));

			format(string,sizeof(string)," * You have banned %s Reason: %s",nname,result);
			SendClientMessage(playerid,COLOR_YELLOW,string);

			format(string,sizeof(string)," * you have been banned by %s Reason: %s ",name,result);
			SendClientMessage(id,COLOR_BRIGHTRED,string);

			Ban(id);
			format(string,sizeof(string)," * %s has been banned by %s. Reason: %s *",nname,name,result);
			}
					
  			return 1;
			}
			}

			if(strcmp(cmd,"/muteall",true) == 0)
			{
			new tmp[256];
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(PlayerInfo[playerid][Level] <= 2)
			{
			SendClientMessage(playerid,COLOR_RED,"You have to be Level 3 to use this command!");
			return 1;
			}
  			for(new i=0;i<MAX_PLAYERS;i++)
  			{
  			if(IsPlayerConnected(i))
  			{
			tmp = strtok(cmdtext, idx);
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string)," * You have all been muted by Admin %s",name);
			SendClientMessageToAll(COLOR_YELLOW,string);
			PlayerInfo[i][Muted] = 1;
			}
			}
			return 1;
		    }
			if(strcmp(cmd,"/unmuteall",true) == 0)
			{
			new tmp[256];
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(PlayerInfo[playerid][Level] <= 2)
			{
			SendClientMessage(playerid,COLOR_RED,"You have to be Level 3 to use this command!");
			return 1;
			}
  			for(new i=0;i<MAX_PLAYERS;i++)
  			{
  			if(IsPlayerConnected(i))
  			{
			tmp = strtok(cmdtext, idx);
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string)," * you have all been unmuted by Admin %s",name);
			SendClientMessageToAll(COLOR_YELLOW,string);
			PlayerInfo[i][Muted] = 0;
			}
			}
			return 1;
		    }

			if(strcmp(cmd,"/healall",true) == 0)
			{
			if(PlayerInfo[playerid][Level] <= 3)
			{
			SendClientMessage(playerid,COLOR_RED,"You have to be Level 4 to use this command!");
			return 1;
			}
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
  			for(new i=0;i<MAX_PLAYERS;i++)
  			{
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string)," * You have all been healed by %s",name);
			SendClientMessage(i,COLOR_YELLOW,string);
			SetPlayerHealth(i,100);
			}
			return 1;
		    }
			if(strcmp(cmd,"/armourall",true) == 0)
			{
			if(PlayerInfo[playerid][Level] <= 4)
			{
			SendClientMessage(playerid,COLOR_RED,"You have to be Level 5 to use this command!");
			return 1;
			}
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
  			for(new i=0;i<MAX_PLAYERS;i++)
  			{
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string)," * You have all been armoured by %s",name);
			SendClientMessage(i,COLOR_YELLOW,string);
			SetPlayerArmour(i,100);
			}
			return 1;
		    }
      		if(strcmp(cmd,"/goto",true) == 0)
			{
			new tmp[256];
			new string[128];
			new otherplayer;
			tmp = strtok(cmdtext, idx);
			if(PlayerInfo[playerid][Level] <= 3)
			{

			SendClientMessage(playerid,COLOR_RED,"You need to be level 4 to use this command!");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /goto [id]");
			return 1;
			}
			otherplayer = strval(tmp);
			
			if(!IsPlayerConnected(otherplayer))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: Invalid ID.");
			return 1;
			}
			if(PlayerInfo[otherplayer][Level] > PlayerInfo[playerid][Level])
			{
		    SendClientMessage(playerid,COLOR_WHITE,"SERVER: You can't do this command on higher admin level.");
		    return 1;
			}
			new Float:X;
			new Float:Y;
			new Float:Z;
			GetPlayerPos(otherplayer,X,Y,Z);
			new name[MAX_PLAYER_NAME];
			new nname[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			GetPlayerName(otherplayer,nname,sizeof(nname));
			if(IsPlayerInAnyVehicle(playerid))
			{
		    	SetVehiclePos(GetPlayerVehicleID(playerid),X+2,Y,Z);
				format(string,sizeof(string),"%s has teleported to you!",name);
				SendClientMessage(otherplayer,COLOR_LIGHTBLUE,string);
				format(string,sizeof(string)," You have teleported to %s",nname);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			}
			else
			{
		    	SetPlayerPos(playerid,X,Y,Z+2.5);
		    	SetVehiclePos(GetPlayerVehicleID(playerid),X+2,Y,Z);
				format(string,sizeof(string),"%s has teleported to you!",name);
				SendClientMessage(otherplayer,COLOR_LIGHTBLUE,string);
				format(string,sizeof(string)," You have teleported to %s",nname);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			}
			return 1;
			}
 			if(strcmp(cmd,"/get",true) == 0)
			{
			new tmp[256];
			new otherplayer;
			tmp = strtok(cmdtext, idx);
			if(PlayerInfo[playerid][Level] <= 3)
			{

				SendClientMessage(playerid,COLOR_RED,"ERROR: You are not a high enough level to use this command");
				return 1;
			}
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,COLOR_WHITE,"SERVER: /get [playerid]");
				return 1;
			}
			otherplayer = strval(tmp);
			if(!IsPlayerConnected(otherplayer))
			{
				SendClientMessage(playerid,COLOR_WHITE,"SERVER: Invalid ID.");
				return 1;
			}
			new name[MAX_PLAYER_NAME];
			new nname[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			GetPlayerName(otherplayer,nname,sizeof(nname));
			new Float:X;
			new Float:Y;
			new Float:Z;
			new string[128];
			GetPlayerPos(playerid,X,Y,Z);
			SetPlayerPos(otherplayer,X,Y,Z+2.5);
			format(string,sizeof(string),"%s has teleported you to him.",name);
			SendClientMessage(otherplayer,COLOR_LIGHTBLUE,string);
			format(string,sizeof(string)," You have teleported %s to you.",nname);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			return 1;
			}

			if(strcmp(cmd,"/gmx",true) == 0)
			{
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
		    if(PlayerInfo[playerid][Level] <= 9) return SendClientMessage(playerid,COLOR_GREEN,"You have to be level 10 to use this command!");
			new string[128];
			new pname[MAX_PLAYER_NAME];
			GetPlayerName(playerid,pname,sizeof(pname));
			format(string,sizeof(string)," %s has restarted the gamemode.",pname);
			GameModeExit();
		 	return 1;
			}


			if(strcmp(cmd, "/sethealth", true) == 0)
			{
			new tmp[256];
			tmp = strtok(cmdtext, idx);
			new otherplayer =  strval(tmp);
			tmp = strtok(cmdtext, idx);
			new health =  strval(tmp);
			new name[MAX_PLAYER_NAME];
			new nname[MAX_PLAYER_NAME];

			new string[128];
			GetPlayerName(playerid, name, sizeof(name));
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_BLUE,"USAGE: /sethealth [playerid] [health]");
			return 1;
			}
			if(health < 0 || health > 100)
			{
		    SendClientMessage(playerid,COLOR_BRIGHTRED,"SERVER: Invalid health.");
		    return 1;
			}

			if(PlayerInfo[playerid][Level] >= 2)
			{
			if(IsPlayerConnected(otherplayer))
			{
			SetPlayerHealth(otherplayer,health);
	    			
			GetPlayerName(otherplayer, nname,sizeof(nname));
			format(string,sizeof(string),"You have set %s 's health to %d",otherplayer, health);
			SendClientMessage(playerid,COLOR_RED,string);
					
			format(string,sizeof(string),"AdmCMD: Admin %s set your health to %d",name, health);
			SendClientMessage(otherplayer,COLOR_RED,string);

			}
			else
			{
			format(string, sizeof(string), "%d is not an active player.", otherplayer);
			SendClientMessage(playerid, COLOR_RED, string);
			}
			}
			else
			{
			SendClientMessage(playerid, COLOR_RED, "You have to be level 3 to use this command!");
			}


			return 1;
			}
			if(strcmp(cmd,"/warn",true) == 0)
			{
			if(AdminLevel(playerid) <= 2) return SendClientMessage(playerid,COLOR_BRIGHTRED,"You are not a high enough admin level to use this command");
			new tmp[256];
			tmp = strtok(cmdtext, idx);
			new otherplayer = strval(tmp);
			tmp = strtok(cmdtext, idx);
			new string[128];
			new nname[24];
			new name[24];
			GetPlayerName(playerid,name,24);
			GetPlayerName(otherplayer,nname,24);
			if(strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"USAGE: /warn [playerid]");
			return 1;
			}
			if(!IsPlayerConnected(otherplayer))
			{
			SendClientMessage(playerid,COLOR_LIMEGREEN,"SERVER: Invalid ID");
			return 1;
			}
			if(PlayerInfo[otherplayer][Warned] == 0)
			{

			PlayerInfo[otherplayer][Warned] = 1;
			format(string,sizeof(string),"%s (ID: %d) has been warned by %s (ID: %d) 1/3",nname,otherplayer,name,playerid);
			SendClientMessageToAll(COLOR_BRIGHTRED,string);
			return 1;
			}
			if(PlayerInfo[otherplayer][Warned] == 1)
			{
			PlayerInfo[otherplayer][Warned] = 2;
			format(string,sizeof(string),"%s (ID: %d) has been warned by %s (ID: %d) 1/2",nname,otherplayer,name,playerid);
			SendClientMessageToAll(COLOR_BRIGHTRED,string);
			return 1;
			}
			if(PlayerInfo[otherplayer][Warned] == 2)
			{
			PlayerInfo[otherplayer][Warned] = 3;
			format(string,sizeof(string),"%s (ID: %d) has been kicked by %s (ID: %d) Reason: exceeded warn limit 3/3",nname,otherplayer,name,playerid);
			SendClientMessageToAll(COLOR_BRIGHTRED,string);
			Kick(otherplayer);
			}
			return 1;
			}







			if(strcmp(cmd,"/getcar",true) == 0)
			{
			new tmp[256];
			new veh;
			new Float:X;
			new Float:Y;
			new Float:Z;
			new Float:A;
			GetPlayerPos(playerid,X,Y,Z);
			GetPlayerFacingAngle(playerid,A);
			tmp = strtok(cmdtext, idx);
			if(PlayerInfo[playerid][Level] < 4)
			{

			SendClientMessage(playerid,COLOR_RED,"You have to be level 4 to use this command!");
			return 1;
			}
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /getcar [vehicleid]");
			SendClientMessage(playerid,COLOR_WHITE,"Example: /getcar 411");
			return 1;
			}
			veh = strval(tmp);
			if(veh < 401 || veh > 611)
			{
		    SendClientMessage(playerid,COLOR_WHITE,"SERVER: Your vehicle ID has to be between 401 and 611.");
		    return 1;
			}

			new vehid;

			vehid = CreateVehicle(veh,X,Y,Z,A,-1,-1,50000);
			PutPlayerInVehicle(playerid,vehid,0);
			return 1;
			}


			if(strcmp(cmd,"/stormy",true) == 0)
			{
			if(PlayerInfo[playerid][Level] >= 1)
			{
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			for(new i=0;i<MAX_PLAYERS;i++)
			SetPlayerWeather(i,08);
			}
			else
			{
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have to be level 2 to use this command!");
			}

			return 1;
			}
			if(strcmp(cmd,"/bluesky",true) == 0)
			{
			if(PlayerInfo[playerid][Level] >= 1)
			{
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			for(new i=0;i<MAX_PLAYERS;i++)
			SetPlayerWeather(i,02);
			}
			else
			{
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have to be level 2 to use this command!");
			}

			return 1;
			}
   			if(strcmp(cmd,"/sandstorm",true) == 0)
			{
			if(PlayerInfo[playerid][Level] >= 1)
			{
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			for(new i=0;i<MAX_PLAYERS;i++)
			SetPlayerWeather(i,19);
			}
			else
			{
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have to be level 2 to use this command!");
			}

			return 1;
			}
			if(strcmp(cmd,"/foggy",true) == 0)
			{
			if(PlayerInfo[playerid][Level] >= 1)
			{
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			for(new i=0;i<MAX_PLAYERS;i++)
			SetPlayerWeather(i,19);
			}
			else
			{
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have to be level 2 to use this command!");
			}

			return 1;
			}
			if(strcmp(cmd,"/rain",true) == 0)
			{
			if(PlayerInfo[playerid][Level] >= 1)
			{
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			for(new i=0;i<MAX_PLAYERS;i++)
			SetPlayerWeather(i,16);
			}
			else
			{
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"You have to be level 2 to use this command!");
			}

			return 1;
			}

			
 

			if(strcmp(cmd, "/unjail", true) == 0)
		    {
      		new tmp[256];
          	tmp = strtok(cmdtext, idx);
          	new otherplayer = strval(tmp);

          	if(AdminLevel(playerid) <= 2)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 3 to use this command!");
          	return 1;
          	}
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
          	if(AdminLevel(playerid) < AdminLevel(otherplayer))
          	{
          	SendClientMessage(playerid,COLOR_RED,"You cannot use this command on a player with a higher level than you!");
          	return 1;
          	}
          	if(!strlen(tmp))
          	{
          	SendClientMessage(playerid,COLOR_ORANGE,"** USAGE: /unjail [playerid] **");
          	return 1;
          	}

	        if(!IsPlayerConnected(otherplayer))
        	{
            SendClientMessage(playerid, 0xFFFF00AA, "** SERVER: Invalid ID **");
        	}

			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			new nname[MAX_PLAYER_NAME];
			
			GetPlayerName(otherplayer,nname,sizeof(nname));
			format(string,sizeof(string),"You have been unjailed by %s",name);
			SendClientMessage(otherplayer,COLOR_LIGHTBLUE,string);
			
			format(string,sizeof(string),"You have jailed %s",nname);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			
			SetPlayerPos(otherplayer,1958.3783, 1343.1572, 15.3746);
			SetPlayerInterior(otherplayer,0);
			PlayerInfo[otherplayer][DisabledCMDs] = 0;
			PlayerInfo[otherplayer][Jailed] = 0;
			return 1;
			}

			




			if(strcmp(cmd, "/jail", true) == 0)
		    {
      		new tmp[256];
          	tmp = strtok(cmdtext, idx);
          	new otherplayer = strval(tmp);

          	if(AdminLevel(playerid) <= 2)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 3 to use this command!");
          	return 1;
          	}
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
          	if(AdminLevel(playerid) < AdminLevel(otherplayer))
          	{
          	SendClientMessage(playerid,COLOR_RED,"You cannot use this command on a player with a higher level than you!");
          	return 1;
          	}
          	if(!strlen(tmp))
          	{
          	SendClientMessage(playerid,COLOR_ORANGE,"** USAGE: /jail [playerid] **");
          	return 1;
          	}

	        if(!IsPlayerConnected(otherplayer))
        	{
            SendClientMessage(playerid, 0xFFFF00AA, "** SERVER: Invalid ID **");
        	}

			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			SetPlayerInterior(otherplayer,3);
			SetPlayerPos(otherplayer,197.6661, 173.8179, 1003.0234);
        	format(string,sizeof(string),"You have been jailed! By %s",name);
        	SendClientMessage(otherplayer,COLOR_ORANGE,string);
			new playerfile[256];
			new nname[MAX_PLAYER_NAME];
			GetPlayerName(otherplayer,nname,sizeof(nname));
			PlayerInfo[otherplayer][Jailed]++;
			format(playerfile,sizeof(playerfile),"AwesomeAdmin/Users/%s.txt",nname);

			if(dini_Exists(playerfile))
			{
				dini_IntSet(playerfile,"TimesJailed",PlayerInfo[otherplayer][Jailed]);
			}
			PlayerInfo[otherplayer][Jailed] = 1;
			PlayerInfo[otherplayer][DisabledCMDs] = 1;
			return 1;
    		}

    		
    		
    		
     		if(strcmp(cmd, "/colour", true) == 0)
		   	{
		   	new tmp[256];
		   	new string[128];
		   	new name[MAX_PLAYER_NAME];
		   	GetPlayerName(playerid,name,sizeof(name));
		   	tmp = strtok(cmdtext, idx);
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}

			if(!strlen(tmp))
		   	{
		   	SendClientMessage(playerid, 0xFFFFFFAA, "Syntax: /colour [0-99]");
		   	return 1;
		   	}
		   	else if (strval(tmp)>99 || strval(tmp)<0)
		   	{
		   	SendClientMessage(playerid, 0xFFFFFFAA, "Syntax: /colour [0-99]");
		   	return 1;
		   	}
		   	else
		   	{
		   	SetPlayerColor(playerid,playerColors[strval(tmp)]);
			format(string,sizeof(string)," Admin %s has changed his colour to %s ",name,playerColors[strval(tmp)]);
			   }
		   	return 1;
		   	}

			if(strcmp(cmd, "/freeze", true) == 0)
		    {
      		new tmp[256];
          	tmp = strtok(cmdtext, idx);
            if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(AdminLevel(playerid) <= 5)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 6 to use this command!");
          	return 1;
          	}
        	new otherplayer = strval(tmp);
          	if(AdminLevel(playerid) < AdminLevel(otherplayer))
          	{
          	SendClientMessage(playerid,COLOR_RED,"You cannot use this command on a player with a higher level than you!");
          	return 1;
          	}
          	if(!strlen(tmp))
          	{
          	SendClientMessage(playerid,COLOR_ORANGE,"** USAGE: /freeze [playerid] **");
          	return 1;
          	}

	        if(!IsPlayerConnected(otherplayer))
        	{
            SendClientMessage(playerid, 0xFFFF00AA, "** SERVER: Invalid ID **");
        	}
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
        	TogglePlayerControllable(otherplayer,false);
        	format(string,sizeof(string),"You have been frozen by %s!",name);
        	SendClientMessage(otherplayer,COLOR_ORANGE,string);
        	return 1;
    		}
    		
   			if(strcmp(cmd, "/unfreeze", true) == 0)
		    {
      		new tmp[256];
          	tmp = strtok(cmdtext, idx);
          	if(AdminLevel(playerid) <= 5)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 6 to use this command!");
          	return 1;
          	}
          	if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
        	new otherplayer = strval(tmp);
          	if(AdminLevel(playerid) < AdminLevel(otherplayer))
          	{
          	SendClientMessage(playerid,COLOR_RED,"You cannot use this command on a player with a higher level than you!");
          	return 1;
          	}
          	if(!strlen(tmp))
          	{
          	SendClientMessage(playerid,COLOR_ORANGE,"** USAGE: /unfreeze [playerid] **");
          	return 1;
          	}

	        if(!IsPlayerConnected(otherplayer))
        	{
            SendClientMessage(playerid, 0xFFFF00AA, "** SERVER: Invalid ID **");
        	}
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
        	TogglePlayerControllable(otherplayer,true);
        	format(string,sizeof(string),"You have been unfrozen by %s!",name);
        	SendClientMessage(otherplayer,COLOR_ORANGE,string);
        	return 1;
    		}
    		
   			if(strcmp(cmd,"/removecash",true) == 0)
			{
			new tmp[256];
			tmp = strtok(cmdtext, idx);
			new otherplayer = strval(tmp);
			tmp = strtok(cmdtext, idx);
			new cash = strval(tmp);
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}

			if(PlayerInfo[playerid][Level] <= 3)
			{

			SendClientMessage(playerid,COLOR_RED,"You need o be level 4 to use this command!");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /removecash [playerid] [money] **");
			return 1;
			}


	 		if(!IsPlayerConnected(otherplayer))
			{
		    SendClientMessage(playerid,COLOR_WHITE,"SERVER: Invalid ID");
		    return 1;
			}
			new string[256];
			new name[MAX_PLAYER_NAME];
			GivePlayerMoney(otherplayer,cash);
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string)," * %s has given you $%d.",name,cash);
			SendClientMessage(otherplayer,COLOR_YELLOW,string);

			return 1;
			}
    		
   		   	if(strcmp(cmd,"/setmoney",true) == 0)
			{
			new tmp[256];
			tmp = strtok(cmdtext, idx);
			new otherplayer = strval(tmp);
			tmp = strtok(cmdtext, idx);
			new cash = strval(tmp);
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}

			if(PlayerInfo[playerid][Level] <= 3)
			{

			SendClientMessage(playerid,COLOR_RED,"You need o be level 4 to use this command!");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /setmoney [playerid] [money] **");
			return 1;
			}


	 		if(!IsPlayerConnected(otherplayer))
			{
		    SendClientMessage(playerid,COLOR_WHITE,"SERVER: Invalid ID");
		    return 1;
			}
			new string[256];
			new name[MAX_PLAYER_NAME];
			ResetPlayerMoney(otherplayer);
			GivePlayerMoney(otherplayer,cash);
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string)," * %s has removed $%d from your pocketmoney.",name,cash);
			SendClientMessage(otherplayer,COLOR_YELLOW,string);

			return 1;
			}
   		   	if(strcmp(cmd,"/giveweapon",true) == 0)
			{
			new tmp[256];
			tmp = strtok(cmdtext, idx);
			new otherplayer = strval(tmp);
			tmp = strtok(cmdtext, idx);
			new weapon = strval(tmp);
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}

			if(PlayerInfo[playerid][Level] <= 3)
			{

			SendClientMessage(playerid,COLOR_RED,"You need o be level 4 to use this command!");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /giveweapon [playerid] [weaponid] **");
			return 1;
			}
			if(weapon > 46 && weapon < 0)
			{
			SendClientMessage(playerid,COLOR_WHITE,"You're weapon ID has to be between 46 and 0!");
			return 1;
			}
	 		if(!IsPlayerConnected(otherplayer))
			{
		    SendClientMessage(playerid,COLOR_WHITE,"SERVER: Invalid ID");
		    return 1;
			}

			GivePlayerWeapon(otherplayer,weapon,1000);



			return 1;
			}
      		if(strcmp(cmd, "/setarmour", true) == 0)
		    {
   			new tmp[256];
          	tmp = strtok(cmdtext, idx);
          	new otherplayer = strval(tmp);
			tmp = strtok(cmdtext, idx);
			new armour =  strval(tmp);

			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}


			if(AdminLevel(playerid) <= 4)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 5 to use this command!");
          	return 1;
          	}
          	if(AdminLevel(playerid) < AdminLevel(otherplayer))
          	{
          	SendClientMessage(playerid,COLOR_RED,"You cannot use this command on a player with a higher level than you!");
          	return 1;
          	}
          	if(!strlen(tmp))
          	{
          	SendClientMessage(playerid,COLOR_GREEN,"** USAGE: /setarmour [playerid] [armour] **");
          	return 1;
          	}

			if(armour > 100 && armour < 0)
			{
			SendClientMessage(playerid,COLOR_ORANGE,"Your armour has to be between 100 and 0, Duhh!");
			return 1;
			}
	        if(!IsPlayerConnected(otherplayer))
        	{
            SendClientMessage(playerid, 0xFFFF00AA, "** SERVER: Invalid ID **");
			return 1;
			}

			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			SetPlayerArmour(otherplayer,armour);
        	format(string,sizeof(string),"%s has set your armour to %d!",name,armour);
        	SendClientMessage(otherplayer,COLOR_LIGHTBLUE,string);
        	return 1;
    		}

   			
			if(strcmp(cmd, "/setskin", true) == 0)
		    {
      		new tmp[256];
          	tmp = strtok(cmdtext, idx);
          	new otherplayer = strval(tmp);
          	tmp = strtok(cmdtext, idx);
			new skin = strval(tmp);
          	tmp = strtok(cmdtext, idx);

            if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(AdminLevel(playerid) <= 3)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 4 to use this command!");
          	return 1;
          	}
			if(skin > 3 && skin < 8 || skin == 42 || skin == 65 || skin == 73 || skin == 86 || skin == 119 || skin == 149 || skin == 208 || skin == 268 || skin == 273 || skin == 289)
			{
			SendClientMessage(playerid,COLOR_ORANGE,"SERVER: Invalid skin ID");
			return 1;
			}
          	if(AdminLevel(playerid) < AdminLevel(otherplayer))
          	{
          	SendClientMessage(playerid,COLOR_RED,"You cannot use this command on a player with a higher level than you!");
          	return 1;
          	}
          	if(!strlen(tmp))
          	{
          	SendClientMessage(playerid,COLOR_ORANGE,"** USAGE: /setskin [playerid] [skinid] **");
          	return 1;
          	}

	        if(!IsPlayerConnected(otherplayer))
        	{
            SendClientMessage(playerid, 0xFFFF00AA, "** SERVER: Invalid ID **");
			return 1;
			}
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			SetPlayerSkin(otherplayer,skin);
        	format(string,sizeof(string),"You're skin has been set to ID: %d by %s!",skin,name);
        	SendClientMessage(otherplayer,COLOR_ORANGE,string);
        	return 1;
    		}

   
   			if(strcmp(cmd, "/explode", true) == 0)
		    {
      		new tmp[256];
			new Float:x,Float:y,Float:z;
  			new otherplayer = strval(tmp);
          	tmp = strtok(cmdtext, idx);
			GetPlayerPos(otherplayer,x,y,z);
			
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}

			if(AdminLevel(playerid) <= 5)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 6 to use this command!");
          	return 1;
          	}

          	if(AdminLevel(playerid) < AdminLevel(otherplayer))
          	{
          	SendClientMessage(playerid,COLOR_RED,"You cannot use this command on a player with a higher level than you!");
          	return 1;
          	}
          	if(!strlen(tmp))
          	{
          	SendClientMessage(playerid,COLOR_ORANGE,"** USAGE: /explode [playerid] **");
          	return 1;
          	}

	        if(!IsPlayerConnected(otherplayer))
        	{
            SendClientMessage(playerid, 0xFFFF00AA, "** SERVER: Invalid ID **");
			return 1;
			}
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			new nname[MAX_PLAYER_NAME];
			GetPlayerName(otherplayer,nname,sizeof(name));
			
			CreateExplosion(x,y,z,12,1000);
        	format(string,sizeof(string),"Admin %s has exploded you!",name);
        	SendClientMessage(otherplayer,COLOR_ORANGE,string);
        	format(string,sizeof(string),"You have exploded %s!",nname);
        	SendClientMessage(otherplayer,COLOR_ORANGE,string);

        	return 1;
    		}
   			if(strcmp(cmd, "/explodeall", true) == 0)
		    {
			new Float:x,Float:y,Float:z;
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}

			if(AdminLevel(playerid) <= 8)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 9 to use this command!");
          	return 1;
           	}
        	for(new i=0;i<MAX_PLAYERS;i++)
        	{
        	if(IsPlayerConnected(i))
        	{
        	if(IsPlayerInAnyVehicle(i))
        	{
        	SetVehicleHealth(GetPlayerVehicleID(i),0.000);
			GetVehiclePos(GetPlayerVehicleID(i),x,y,z);
			CreateExplosion(x,y,z,12,1000);
			}
			else
			{
			GetPlayerPos(i,x,y,z);
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			CreateExplosion(x,y,z,12,1000);
        	format(string,sizeof(string),"Admin %s has exploded everyone!",name);
        	SendClientMessage(i,COLOR_LIGHTBLUE,string);
        	}
        	}
        	return 1;
    		}
    		}
    		
    		

    		
    		
    		
    		
    		
    		
    		
    		
    		
    		
   			if(strcmp(cmd, "/setwanted", true) == 0)
		    {
      		new tmp[256];
          	tmp = strtok(cmdtext, idx);
          	new otherplayer = strval(tmp);
			tmp = strtok(cmdtext, idx);
      		new level = strval(tmp);
          	if(AdminLevel(playerid) <= 4)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 5 to use this command!");
          	return 1;
          	}
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
          	if(AdminLevel(playerid) < AdminLevel(otherplayer))
          	{
          	SendClientMessage(playerid,COLOR_RED,"You cannot use this command on a player with a higher level than you!");
          	return 1;
          	}
          	if(!strlen(tmp))
          	{
          	SendClientMessage(playerid,COLOR_ORANGE,"** USAGE: /setwanted [playerid] [wantedlevel] **");
          	return 1;
          	}

			if(level > 6 && level < 0)
			{
			SendClientMessage(playerid,COLOR_ORANGE,"SERVER: Invalid Wanted Level");
			return 1;
			}
	        if(!IsPlayerConnected(otherplayer))
        	{
            SendClientMessage(playerid, 0xFFFF00AA, "** SERVER: Invalid ID **");
			return 1;
			}

			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			SetPlayerWantedLevel(otherplayer,level);
        	format(string,sizeof(string),"%s has set your wanted level to %d!",name,level);
        	SendClientMessage(otherplayer,COLOR_ORANGE,string);
        	return 1;
    		}
   			if(strcmp(cmd, "/getIP", true) == 0)
		    {
      		new tmp[256];
			new ip[30];
          	tmp = strtok(cmdtext, idx);
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(AdminLevel(playerid) <= 1)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 2 to use this command!");
          	return 1;
          	}
          	if(!strlen(tmp))
          	{
          	SendClientMessage(playerid,COLOR_ORANGE,"** USAGE: /GetIP [playerid] **");
          	return 1;
          	}

  			new otherplayer = strval(tmp);
	        if(!IsPlayerConnected(otherplayer))
        	{
            SendClientMessage(playerid, 0xFFFF00AA, "** SERVER: Invalid ID **");
			return 1;
			}

			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(otherplayer,name,sizeof(name));
			GetPlayerIp(otherplayer,ip,sizeof(ip));
        	format(string,sizeof(string),"%s's IP is %d!",name,ip);
        	SendClientMessage(playerid,COLOR_ORANGE,string);
        	return 1;
    		}
			if(strcmp(cmd,"/ann",true) == 0)
			{
			new tmp[256];
			tmp = messages(cmdtext,idx);
			if(PlayerInfo[playerid][Level] <= 1)
			{

			SendClientMessage(playerid,COLOR_RED,"You need to be level 2 to use this command!");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /announce [message]");
			return 1;
			}
			new string[128];
			format(string,sizeof(string),"~r~%s",tmp);
			GameTextForAll(string,2000,5);
			return 1;
			}
			if(strcmp(cmd, "/akillall", true) == 0)
		    {
          	if(AdminLevel(playerid) <= 4)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 5 to use this command!");
          	return 1;
          	}
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
          	for(new i=0;i<MAX_PLAYERS;i++)
          	{
          	if(IsPlayerConnected(i))
          	{
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			SetPlayerHealth(i,0.00);
        	format(string,sizeof(string),"Admin %s has killed you all!!",name);
        	SendClientMessage(playerid,COLOR_ORANGE,string);
        	}
        	}
        	return 1;
    		}
      		if(strcmp(cmd,"/say",true) == 0)
			{
			new tmp[256];
			new name[MAX_PLAYER_NAME];
			new string[128];
			tmp = messages(cmdtext,idx);
			if(PlayerInfo[playerid][Level] <= 1)
			{

			SendClientMessage(playerid,COLOR_RED,"ERROR: you need to be level 2 to use this command!");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"USAGE: /say [message]");
			return 1;
			}
			GetPlayerName(playerid,name,sizeof(name));
			for(new i = 0; i <= MAX_PLAYERS; i++)
			{
			if(IsPlayerConnected(i))
			{
			if(PlayerInfo[i][Level] > 1)
			{
			format(string,sizeof(string)," * Admin (%s): %s",name,tmp);
			SendClientMessage(i,COLOR_LIMEGREEN,string);
			}
			else
			{
			format(string,sizeof(string)," * Admin: %s",tmp);
			SendClientMessage(i,COLOR_LIMEGREEN,string);
			}
			}
			}
			return 1;
			}
    		
    		if(strcmp(cmd,"/ssay",true) == 0)
			{
			new tmp[256];

			new string[128];
			tmp = messages(cmdtext,idx);
			if(PlayerInfo[playerid][Level] <= 1)
			{

			SendClientMessage(playerid,COLOR_RED,"ERROR: you need to be level 2 to use this command!");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"USAGE: /ssay [message]");
			return 1;
			}
			for(new i = 0; i <= MAX_PLAYERS; i++)
			{
			if(IsPlayerConnected(i))
			{
			if(PlayerInfo[i][Level] > 1)
			{
			format(string,sizeof(string)," %s",tmp);
			SendClientMessage(i,COLOR_LIMEGREEN,string);
			}
			else
			{
			format(string,sizeof(string)," %s",tmp);
			SendClientMessage(i,COLOR_LIMEGREEN,string);
			}
			}
			}
			return 1;
			}
    		
    		
    		
    		
    		
    		
    		
			
		   	if(strcmp(cmd,"/carhealth",true) == 0)
			{
			new tmp[256];
			tmp = strtok(cmdtext, idx);
			new health;
			tmp = strtok(cmdtext, idx);
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(PlayerInfo[playerid][Level] <= 3)
			{

			SendClientMessage(playerid,COLOR_RED,"You need to be level 4 to use this command!");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /carhealth [health]");
			return 1;
			}
			health = strval(tmp);
			if(health < 0 || health > 5000)
			{
		    SendClientMessage(playerid,COLOR_WHITE,"SERVER: Invalid Vehicle health.");
		    return 1;
			}
	 		if(!IsPlayerInAnyVehicle(playerid))
			{
		    SendClientMessage(playerid,COLOR_WHITE,"SERVER: You are not in vehicle.");
		    return 1;
			}
			new string[256];
			new name[MAX_PLAYER_NAME];
			SetVehicleHealth(GetPlayerVehicleID(playerid),health);
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string)," * %s has set his vehicle health to %d.",name,health);
			SendClientMessage(playerid,COLOR_YELLOW,string);

			return 1;
			}
			
			if(strcmp(cmd, "/loadfs", true) == 0)
			{
			new tmp[256];
		    tmp = strtok(cmdtext, idx);
		    if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /loadfs [filterscript]");
			return 1;
			}

			if(PlayerInfo[playerid][Level] >= 9)
			{
   			new string[128];
			format(string,sizeof(string),"loadfs %s",tmp);
			SendRconCommand(string);
			format(string,sizeof(string),"%s.amx: Loaded Succsesfully!",tmp);
			SendClientMessage(playerid,COLOR_BLUE,string);
			}
			else
			{
   			SendClientMessage(playerid, COLOR_RED, "You have to be Level 10 to use this command!");
			}

	
			return 1;
			}
			if(strcmp(cmd, "/unloadfs", true) == 0)
			{
			new tmp[256];
		    tmp = strtok(cmdtext, idx);
		    if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /unloadfs [filterscript]");
			return 1;
			}

			if(PlayerInfo[playerid][Level] >= 9)
			{
   			new string[128];
			format(string,sizeof(string),"unloadfs %s",tmp);
			SendRconCommand(string);
			format(string,sizeof(string),"%s.amx: Unloaded Succsesfully!",tmp);
			SendClientMessage(playerid,COLOR_BLUE,string);
			}
			else
			{
   			SendClientMessage(playerid, COLOR_RED, "You have to be Level 10 to use this command");
			}


			return 1;
			}

   		   	if(strcmp(cmd,"/removecash",true) == 0)
			{
			new tmp[256];
			tmp = strtok(cmdtext, idx);
			new otherplayer = strval(tmp);
			tmp = strtok(cmdtext, idx);
			new cash = strval(tmp);
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			
			if(PlayerInfo[playerid][Level] <= 3)
			{

			SendClientMessage(playerid,COLOR_RED,"You need to be level 4 to use this command!");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /removecash [playerid] [money] **");
			return 1;
			}


	 		if(!IsPlayerConnected(otherplayer))
			{
		    SendClientMessage(playerid,COLOR_WHITE,"SERVER: Invalid ID");
		    return 1;
			}
			
			new string[256];
			new name[MAX_PLAYER_NAME];
			GivePlayerMoney(otherplayer,-cash);
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string)," * %s has removed $%d from your pocketmoney.",name,cash);
			SendClientMessage(otherplayer,COLOR_YELLOW,string);

			return 1;
			}
   			if(strcmp(cmd, "/giveallweapon", true) == 0)
		    {
		    new tmp[256];
          	tmp = strtok(cmdtext, idx);
          	new weapon = strval(tmp);
			tmp = strtok(cmdtext, idx);
            if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
          	if(AdminLevel(playerid) <= 4)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 5 to use this command!");
          	return 1;
          	}
          	if(strlen(tmp))
          	{
          	SendClientMessage(playerid,COLOR_WHITE,"USAGE: /giveallweapon [weaponid]");
          	return 1;
          	}
          	if(weapon > 46 && weapon < 0)
			{
			SendClientMessage(playerid,COLOR_ORANGE,"Your weapon ID has to be between 46 and 0");
			return 1;
			}
          	for(new i=0;i<MAX_PLAYERS;i++)
          	{
          	if(IsPlayerConnected(i))
          	{
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			GivePlayerWeapon(i,weapon,1000);
        	format(string,sizeof(string),"Admin %s has given everyone a weapon",name);
        	SendClientMessage(playerid,COLOR_ORANGE,string);
        	}
        	}
        	return 1;
    		}
   			if(strcmp(cmd, "/weather", true) == 0)
		    {
		    new tmp[256];
          	tmp = strtok(cmdtext, idx);
          	new weather = strval(tmp);
			tmp = strtok(cmdtext, idx);
            if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
          	if(AdminLevel(playerid) <= 4)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 5 to use this command!");
          	return 1;
          	}
          	if(strlen(tmp))
          	{
          	SendClientMessage(playerid,COLOR_WHITE,"USAGE: /weather [weatherid]");
          	return 1;
          	}

          	for(new i=0;i<MAX_PLAYERS;i++)
          	{
          	if(IsPlayerConnected(i))
          	{
			SetPlayerWeather(i,weather);

        	}
        	}
        	return 1;
    		}
    		
    		
    		
    		
    		
    		
    		
    		
    		
			if(strcmp(cmd, "/setdeaths", true) == 0)
		    {
		    new tmp[256];
			tmp = strtok(cmdtext, idx);
			new otherplayer = strval(tmp);
			tmp = strtok(cmdtext, idx);
			new deaths = strval(tmp);
		    if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}

		    new playerfile[128];
          	if(AdminLevel(playerid) <= 7)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 8 to use this command!");
          	return 1;
          	}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_ORANGE,"USAGE: /setdeaths [playerid] [deaths]");
			return 1;
			}
			if(gPlayerLogged[otherplayer] == 0)
			{
		    new string[128];
		    new name[MAX_PLAYER_NAME];
		    GetPlayerName(otherplayer,name,sizeof(name));
		    format(string,sizeof(string),"SERVER: %s is not logged.",name);
			SendClientMessage(playerid,COLOR_WHITE,string);
			return 1;
			}

			if(!IsPlayerConnected(otherplayer))
			{
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"SERVER: Invalid ID ** ");
			return 1;
			}
			PlayerInfo[otherplayer][Deaths] = deaths;
			new string[128];
			new name[MAX_PLAYER_NAME];
			new nname[MAX_PLAYER_NAME];
			GetPlayerName(otherplayer,nname,sizeof(nname));
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string),"** %s has set your deaths to %d",name,deaths);
			SendClientMessage(otherplayer,COLOR_BRIGHTRED,string);
			format(string,sizeof(string),"** You have set %s's deaths to %d",nname,deaths);
			SendClientMessage(otherplayer,COLOR_BRIGHTRED,string);
			format(playerfile,sizeof(playerfile),"AwesomeAdmin/Users/%s.txt ",name);
			dini_IntSet(playerfile,"Deaths",PlayerInfo[otherplayer][Deaths]);

			return 1;
			}
			if(strcmp(cmd, "/setkills", true) == 0)
		    {
		    new tmp[256];
			tmp = strtok(cmdtext, idx);
			new otherplayer = strval(tmp);
			tmp = strtok(cmdtext, idx);
			new kills = strval(tmp);
			
            if(gPlayerLogged[playerid] == 0)
			{
				SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
				return 1;
			}

		    new playerfile[128];
          	if(AdminLevel(playerid) <= 7)
          	{
	          	SendClientMessage(playerid,COLOR_RED,"You have to be level 8 to use this command!");
	          	return 1;
          	}
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,COLOR_ORANGE,"USAGE: /setkills [playerid] [kills]");
				return 1;
			}
			if(gPlayerLogged[otherplayer] == 0)
			{
			    new string[128];
			    new name[MAX_PLAYER_NAME];
			    GetPlayerName(otherplayer,name,sizeof(name));
			    format(string,sizeof(string),"SERVER: %s is not logged.",name);
				SendClientMessage(playerid,COLOR_WHITE,string);
				return 1;
			}

			if(!IsPlayerConnected(otherplayer))
			{
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"SERVER: Invalid ID ** ");
				return 1;
			}
			PlayerInfo[otherplayer][Kills] = kills;
			new string[128];
			new name[MAX_PLAYER_NAME];
			new nname[MAX_PLAYER_NAME];
			GetPlayerName(otherplayer,nname,sizeof(nname));
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string),"** %s has set your kills to %d",name,kills);
			SendClientMessage(otherplayer,COLOR_BRIGHTRED,string);
			format(string,sizeof(string),"** You have set %s's deaths to %d",nname,kills);
			SendClientMessage(otherplayer,COLOR_BRIGHTRED,string);
			format(playerfile,sizeof(playerfile),"AwesomeAdmin/Users/%s.txt",name);
			dini_IntSet(playerfile,"Kills",PlayerInfo[otherplayer][Kills]);
			return 1;
			}

			if(strcmp(cmd,"/changemode",true) == 0)
			{
		    new tmp[256];
		    tmp = strtok(cmdtext, idx);
			if(PlayerInfo[playerid][Level] <= 9)
			{
			SendClientMessage(playerid,COLOR_RED,"You have to be level 10 to use this command!");
			return 1;
			}
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /changemode [gamemode name]");
			return 1;
			}
			new string[256];
			format(string,sizeof(string),"changemode %s",tmp);
			SendRconCommand(string);
			format(string,sizeof(string),"%s.amx. Succsesfully loaded",tmp);
			SendClientMessage(playerid,COLOR_WHITE,string);
			return 1;
			}

   			if(strcmp(cmd, "/skydiveall", true) == 0)
		    {
		    new tmp[256];
		    tmp = strtok(cmdtext, idx);
		    new height = strval(tmp);
		    tmp = strtok(cmdtext, idx);
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"USAGE: /skydiveall [height]");
			return 1;
			}

			if(AdminLevel(playerid) <= 6)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 7 to use this command!");
          	return 1;
          	}
			for(new i=0;i<MAX_PLAYERS;i++)
			{
			if(IsPlayerConnected(i))
			{
				new Float:X;
				new Float:Y;
				new Float:Z;
				GetPlayerPos(i,X,Y,Z);
				SetPlayerPos(i,X,Y,Z+height);
			}
			}
			return 1;
			}
			
			
			
			
			
			
			
			
			
   			if(strcmp(cmd, "/skydive", true) == 0)
		    {

			new tmp[256];
			tmp = strtok(cmdtext, idx);
			new otherplayer = strval(tmp);
			tmp = strtok(cmdtext, idx);
			new height = strval(tmp);
          	if(AdminLevel(playerid) <= 5)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 6 to use this command!");
          	return 1;
          	}
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
          	if(AdminLevel(playerid) < AdminLevel(otherplayer))
          	{
          	SendClientMessage(playerid,COLOR_RED,"You cannot use this command on a player with a higher level than you!");
          	return 1;
          	}
          	if(!strlen(tmp))
          	{
          	SendClientMessage(playerid,COLOR_ORANGE,"** USAGE: /skydive [playerid] [height] **");
          	return 1;
          	}

	        if(!IsPlayerConnected(otherplayer))
        	{
            SendClientMessage(playerid, 0xFFFF00AA, "** SERVER: Invalid ID **");
        	}
        	height = strval(tmp);
			new string[128];
			new name[MAX_PLAYER_NAME];
			new nname[MAX_PLAYER_NAME];
			GetPlayerName(otherplayer,nname,sizeof(nname));
			GetPlayerName(playerid,name,sizeof(name));
			new Float:X;
			new Float:Y;
			new Float:Z;
			GetPlayerPos(otherplayer,X,Y,Z);
			SetPlayerPos(otherplayer,X,Y,Z+height);
  			format(string,sizeof(string),"You have skydived %s at a height of %d ",nname,height);
        	SendClientMessage(otherplayer,COLOR_ORANGE,string);
        	format(string,sizeof(string),"You have been skydived at a height of %d by %s!",height,name);
        	SendClientMessage(otherplayer,COLOR_ORANGE,string);
        	return 1;
    		}
    		
    		
			if(strcmp(cmd,"/jetpack",true) == 0)
			{
			if(PlayerInfo[playerid][Level] >= 2)
 		 	{
	    		SetPlayerSpecialAction(playerid, 2);
	    	}
  			else
   			{
				SendClientMessage(playerid, COLOR_GREY, "You have to be level 3 to use this command!");
			}

        	return 1;
			}
			if(strcmp(cmd,"/antiminigun",true) == 0)
			{
			if(PlayerInfo[playerid][Level] >= 1)
 		 	{
	    		SetTimer("wepcheck",5000,true);
				SendClientMessage(playerid,COLOR_LIMEGREEN,"The anti-minigun system has been activated");
			}
  			else
   			{
				SendClientMessage(playerid, COLOR_GREY, "You have to be level 2 to use this command!");
			}

        	return 1;
			}

   			if(strcmp(cmd, "/force", true) == 0)
		    {
      		new tmp[256];
          	tmp = strtok(cmdtext, idx);
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}

			if(AdminLevel(playerid) <= 6)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 7 to use this command!");
          	return 1;
          	}
        	new otherplayer = strval(tmp);
          	if(!strlen(tmp))
          	{
          	SendClientMessage(playerid,COLOR_ORANGE,"** USAGE: /force [playerid] **");
          	return 1;
          	}

	        if(!IsPlayerConnected(otherplayer))
        	{
            SendClientMessage(playerid, 0xFFFF00AA, "** SERVER: Invalid ID **");
        	}
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			SetPlayerHealth(otherplayer,0.00);
			ForceClassSelection(playerid);
        	format(string,sizeof(string),"You have been forced to the selection screen by %s!",name);
        	SendClientMessage(otherplayer,COLOR_ORANGE,string);
        	return 1;
    		}
			if(strcmp(cmd, "/forceall", true) == 0)
		    {
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}


			if(AdminLevel(playerid) <= 6)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 7 to use this command!");
          	return 1;
          	}
			for(new i=0;i<MAX_PLAYERS;i++)
			{
			if(IsPlayerConnected(i))
			{
			SetPlayerHealth(i,0.00);
			ForceClassSelection(i);
			}
			}
			return 1;
			}
   			if(strcmp(cmd, "/ejectall", true) == 0)
		    {
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(AdminLevel(playerid) <= 4)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 5 to use this command!");
          	return 1;
          	}
			for(new i=0;i<MAX_PLAYERS;i++)
			{
			if(IsPlayerConnected(i))
			{
			RemovePlayerFromVehicle(i);
			}
			}
			return 1;
			}
			if(strcmp(cmd, "/eject", true) == 0)
		    {
      		new tmp[256];
          	tmp = strtok(cmdtext, idx);
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}

			if(AdminLevel(playerid) <= 6)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 7 to use this command!");
          	return 1;
          	}
        	new otherplayer = strval(tmp);
          	if(!strlen(tmp))
          	{
          	SendClientMessage(playerid,COLOR_ORANGE,"** USAGE: /eject [playerid] **");
          	return 1;
          	}

	        if(!IsPlayerConnected(otherplayer))
        	{
            SendClientMessage(playerid, 0xFFFF00AA, "** SERVER: Invalid ID **");
        	}
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			RemovePlayerFromVehicle(otherplayer);
        	format(string,sizeof(string),"You have been ejected from your vehicle by %s!",name);
        	SendClientMessage(otherplayer,COLOR_ORANGE,string);
        	return 1;
    		}
   			if(strcmp(cmd, "/stopclock", true) == 0)
		    {
      		new tmp[256];
          	tmp = strtok(cmdtext, idx);
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}

			if(AdminLevel(playerid) <= 3)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 4 to use this command!");
          	return 1;
          	}
        	new otherplayer = strval(tmp);
          	if(!strlen(tmp))
          	{
          	SendClientMessage(playerid,COLOR_ORANGE,"** USAGE: /stopclock [playerid] **");
          	return 1;
          	}

	        if(!IsPlayerConnected(otherplayer))
        	{
            SendClientMessage(playerid, 0xFFFF00AA, "** SERVER: Invalid ID **");
        	}
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			TogglePlayerClock(otherplayer,false);
        	format(string,sizeof(string),"Your clock has been stoped by %s!",name);
        	SendClientMessage(otherplayer,COLOR_ORANGE,string);
        	return 1;
    		}

   			if(strcmp(cmd, "/startclock", true) == 0)
		    {
      		new tmp[256];
          	tmp = strtok(cmdtext, idx);
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}

			if(AdminLevel(playerid) <= 3)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 4 to use this command!");
          	return 1;
          	}
        	new otherplayer = strval(tmp);
          	if(!strlen(tmp))
          	{
          	SendClientMessage(playerid,COLOR_ORANGE,"** USAGE: /startclock [playerid] **");
          	return 1;
          	}

	        if(!IsPlayerConnected(otherplayer))
        	{
            SendClientMessage(playerid, 0xFFFF00AA, "** SERVER: Invalid ID **");
        	}
			new string[128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			TogglePlayerClock(otherplayer,true);
        	format(string,sizeof(string),"Your clock has been started by %s!",name);
        	SendClientMessage(otherplayer,COLOR_ORANGE,string);
        	return 1;
    		}
   			if(strcmp(cmd, "/stopallclock", true) == 0)
		    {
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(AdminLevel(playerid) <= 5)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 6 to use this command!");
          	return 1;
          	}
			for(new i=0;i<MAX_PLAYERS;i++)
			{
			if(IsPlayerConnected(i))
			{
			TogglePlayerClock(i,false);
			}
			}
			return 1;
			}
			if(strcmp(cmd, "/startallclock", true) == 0)
		    {
			if(gPlayerLogged[playerid] == 0)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Please login before you use this command!");
			return 1;
			}
			if(AdminLevel(playerid) <= 5)
          	{
          	SendClientMessage(playerid,COLOR_RED,"You have to be level 6 to use this command!");
          	return 1;
          	}
			for(new i=0;i<MAX_PLAYERS;i++)
			{
			if(IsPlayerConnected(i))
			{
			TogglePlayerClock(i,true);
			}
			}
			return 1;
			}
   			if(strcmp(cmd,"/settime",true) == 0)
			{
			new tmp[256];
			new newtime;
			tmp = strtok(cmdtext, idx);
			if(PlayerInfo[playerid][Level] <= 2)
			{
			SendClientMessage(playerid,COLOR_RED,"You have to be level 3 to use this command");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /settime [time]");
			return 1;
			}
			newtime = strval(tmp);
			if(newtime > 23)
			{
			SendClientMessage(playerid,COLOR_WHITE,"Your time has to be below 23");
			return 1;
			}
			new string[256];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string)," * Admin %s set the world time to %d.",name,newtime);
			SendClientMessageToAll(COLOR_YELLOW,string);
			SetWorldTime(newtime);

			return 1;
			}
	    	if(strcmp(cmd, "/spec", true) == 0) {
		    new tmp[256];
			tmp = strtok(cmdtext, idx);
			new specplayerid;
			if(AdminLevel(playerid) <= 1)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Your not a high enough admin level!");
			return 1;
			}

			if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /spec [playerid]");
			return 1;
			}
			specplayerid = strval(tmp);

			if(!IsPlayerConnected(specplayerid))
			{
		    SendClientMessage(playerid, COLOR_RED, "SEVRER: Invalid ID");
			return 1;
			}

			TogglePlayerSpectating(playerid, 1);
			PlayerSpectatePlayer(playerid, specplayerid);
			SetPlayerInterior(playerid,GetPlayerInterior(specplayerid));
			gSpectateID[playerid] = specplayerid;
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Try \"/specoff\" to turn spectating off!");
			gSpectateType[playerid] = ADMIN_SPEC_TYPE_PLAYER;

 			return 1;
			}
	 		if(strcmp(cmd, "/specoff", true) == 0)
		 	{
			if(AdminLevel(playerid) <= 1)
			{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Your not a high enough admin level!");
			return 1;
			}
			TogglePlayerSpectating(playerid, 0);
			gSpectateID[playerid] = INVALID_PLAYER_ID;
			gSpectateType[playerid] = ADMIN_SPEC_TYPE_NONE;
			return 1;
			}
	 		if(strcmp(cmd,"/kickall",true) == 0)
			{
			if(PlayerInfo[playerid][Level] < 8)
			{
			SendClientMessage(playerid,COLOR_RED,"You are not a high enough level to use this command.");
			return 1;
			}
			new string[256];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string),"Everyone has been kicked by Admin: %s",name);
   			for(new i=0;i<MAX_PLAYERS;i++)
  			{
  			if(IsPlayerConnected(i) && i != playerid && PlayerInfo[i][Level] < 2)
  			{
       		Kick(i);
			SendClientMessage(i,COLOR_BRIGHTRED,string);
  			}
			}
			return 1;
			}
  			if(strcmp(cmd,"/carcolour",true) == 0)
			{
			new tmp[256];
			new colour1;
			new colour2;
			tmp = strtok(cmdtext, idx);
			if(PlayerInfo[playerid][Level] <= 2)
			{

			SendClientMessage(playerid,COLOR_RED,"You're not a high enough level to use this command");
			return 1;
			}
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /carcolor [colour1] [colour2]");
			return 1;
			}
			colour1 = strval(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: /carcolor [colour1] [colour2]");
			return 1;
			}
			colour2 = strval(tmp);
			if(colour1 < 0 || colour2 < 0 || colour1 > 126 || colour2 > 126)
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: Invalid colour.");
			return 1;
			}
			if(!IsPlayerInAnyVehicle(playerid))
			{
			SendClientMessage(playerid,COLOR_WHITE,"SERVER: You are not in vehicle.");
			return 1;
			}
			new string[256];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string)," * You have set your vehicle colours to %d and %d.",colour1,colour2);
			SendClientMessage(playerid,COLOR_YELLOW,string);
			ChangeVehicleColor(GetPlayerVehicleID(playerid),colour1,colour2);
			return 1;
			}
			
			
			if(strcmp(cmdtext,"/god",true) == 0)
			{
			if(PlayerInfo[playerid][Level] <= 9)
			{
			SendClientMessage(playerid,COLOR_GREEN,"You have to be level 10 to use this command!");
			return 1;
			}
			if(PlayerInfo[playerid][God] == 1)
			{
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"You're godmode is already activated!");
			return 1;
			}
			SetPlayerHealth(playerid,999999);
			SendClientMessage(playerid,COLOR_LIMEGREEN,"Godmode is now activated!");
			PlayerInfo[playerid][God] = 1;
			return 1;
			}

			
			
			if(strcmp(cmdtext,"/godoff",true) == 0)
			{
			if(PlayerInfo[playerid][Level] <= 9)
			{
			SendClientMessage(playerid,COLOR_GREEN,"You have to be level 10 to use this command!");
			return 1;
			}
			if(PlayerInfo[playerid][God] == 0)
			{
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"You're godmode is already off");
			return 1;
			}
			SetPlayerHealth(playerid,100);
			SendClientMessage(playerid,COLOR_LIMEGREEN,"Godmode is now deactivated");
			PlayerInfo[playerid][God] = 0;
			return 1;
			}
			if(strcmp(cmdtext,"/godcar",true) == 0)
			{
			if(PlayerInfo[playerid][Level] <= 9)
			{
			SendClientMessage(playerid,COLOR_GREEN,"You have to be level 10 to use this command!");
			return 1;
			}
			if(PlayerInfo[playerid][God] == 1)
			{
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"You're godcar mode is already activated!");
			return 1;
			}
			SetVehicleHealth(GetPlayerVehicleID(playerid),999999);
			SendClientMessage(playerid,COLOR_LIMEGREEN,"GodCar mode is now activated!");
			PlayerInfo[playerid][GodCar] = 1;
			return 1;
			}
   			if(strcmp(cmdtext,"/godcaroff",true) == 0)
			{
			if(PlayerInfo[playerid][Level] <= 9)
			{
			SendClientMessage(playerid,COLOR_GREEN,"You have to be level 10 to use this command!");
			return 1;
			}
			if(PlayerInfo[playerid][God] == 0)
			{
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"You're godcar mode is already off");
			return 1;
			}
			SetVehicleHealth(GetPlayerVehicleID(playerid),1000);
			SendClientMessage(playerid,COLOR_LIMEGREEN,"GodCar Mode is now deactivated!");
			PlayerInfo[playerid][GodCar] = 0;
			return 1;
			}
		   	if(strcmp(cmd,"/gravity",true) == 0)
			{
			new tmp[256];
			new Float:newgravity;
			tmp = strtok(cmdtext, idx);
			if(PlayerInfo[playerid][Level] <= 3)
			{

				SendClientMessage(playerid,COLOR_RED,"You need to be level 4 to change the gravity!");
				return 1;
			}
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,COLOR_WHITE,"SERVER: /gravity [gravity]");
				return 1;
			}
			newgravity = floatstr(tmp);
			new string[256];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string)," * Admin %s set the gravity to %.1f.",name,newgravity);
			SendClientMessageToAll(COLOR_YELLOW,string);
			SetGravity(newgravity);
			return 1;
			}
			if(strcmp(cmd,"/setskin",true) == 0)
			{
			new tmp[256];
			new otherplayer;
			new s;
			tmp = strtok(cmdtext, idx);
			if(PlayerInfo[playerid][Level] <= 4)
			{

				SendClientMessage(playerid,COLOR_RED,"You need to be level 4 to use this command!");
				return 1;
			}
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,COLOR_WHITE,"SERVER: /setskin [id] [skinid]");
				return 1;
			}

			otherplayer = strval(tmp);

			if(!IsPlayerConnected(otherplayer))
			{
				SendClientMessage(playerid,COLOR_WHITE,"SERVER: Invalid ID.");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,COLOR_WHITE,"SERVER: /setskin [id] [skinid]");
				return 1;
			}
			s = strval(tmp);
			if(s < 0 || s > 298 || s == 3 || s == 4 || s == 5 || s == 6 || s == 7 || s == 8 || s == 42 || s == 65 || s == 73 || s == 86 || s == 119 || s == 149 || s == 208 || s == 265 || s == 266 || s == 267 || s == 268 || s == 269 || s == 270 || s == 271 || s == 272 || s == 273 || s == 289)
			{
			    SendClientMessage(playerid,COLOR_WHITE,"SERVER: Invalid skin ID.");
			    return 1;
			}
			SetPlayerSkin(otherplayer,s);
			new string[256];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			new nname[MAX_PLAYER_NAME];
			GetPlayerName(otherplayer,nname,sizeof(nname));
			format(string,sizeof(string)," * You have been set %s's skin to %d.",nname,s);
			SendClientMessage(playerid,COLOR_YELLOW,string);
			format(string,sizeof(string)," * Admin %s set your skin to %d.",name,s);
			SendClientMessage(otherplayer,COLOR_YELLOW,string);
			return 1;
			}
			if(strcmp(cmd,"/setallhealth",true) == 0)
			{
		    new tmp[256];
		    tmp = strtok(cmdtext, idx);
		    new health;
			if(PlayerInfo[playerid][Level] <= 5)
			{
				SendClientMessage(playerid,COLOR_RED,"You need to be level 6 to use this command!");
				return 1;
			}
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,COLOR_WHITE,"SERVER: /setallhealth [health]");
				return 1;
			}
			health = strval(tmp);
			if(health < 0 || health > 100)
			{
			    SendClientMessage(playerid,COLOR_WHITE,"SERVER: Invalid health.");
			    return 1;
			}
			new string[256];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string)," * Admin %s set all health to %d.",name,health);
			SendClientMessageToAll(COLOR_YELLOW,string);
			for(new i=0;i<MAX_PLAYERS;i++)
			{
			    if(IsPlayerConnected(i))
			    {
			    	SetPlayerHealth(i,health);
		    	}
			}
			return 1;
			}

			return 0;
			}

public OnPlayerInfoChange(playerid)
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	if(ServerInfo[RconLocked] == 1)
	{
		return 0;
	}
	else return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}
public AdminLevel(playerid)
{
return PlayerInfo[playerid][Level];
}
public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}
public jailtimer(playerid)
{
SetPlayerPos(playerid,1958.3783, 1343.1572, 15.3746);
SendClientMessage(playerid,COLOR_GREEN,"You have been released from jail!, dont do it again!!!");
}

public wepcheck(playerid)
{
if(GetPlayerWeapon(playerid) == 38)
{
ResetPlayerWeapons(playerid);
SendClientMessage(playerid,COLOR_BRIGHTRED,"NO Miniguns are allowed on this server!");
new name[MAX_PLAYER_NAME];
GetPlayerName(playerid,name,sizeof(name));
for(new i=0;i<MAX_PLAYERS;i++)
{
if(IsPlayerConnected(i) || PlayerInfo[i][Level] >= 1)
{
new string[128];
format(string,sizeof(string),"** %s ( ID: %d ) is using a minigun! His weapons have automatically resetted!",name,playerid);
SendClientMessage(i,COLOR_BRIGHTRED,string);
}
}
}
}
messages(const string[], index)
{
	new length = strlen(string);

	new offset = index;
	new result[256];
	while ((index < length) && ((index - offset) < (sizeof(result) - 1)) && (string[index] > '\r'))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}






