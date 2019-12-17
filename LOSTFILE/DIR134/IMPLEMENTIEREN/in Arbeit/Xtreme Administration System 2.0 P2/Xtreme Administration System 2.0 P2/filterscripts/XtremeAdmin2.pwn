/********************************************
 *     Xtreme Administration Filterscript  	*
 *     Programmers: Xtreme			    	*
 *     Creation Date: 04/12/2007          	*
 *     Compatibility: SA:MP 0.2           	*
 *     Version: Pre-2.0 || Patch: 2			*
 *******************************************/

#include <a_samp>
#include <DUDB>

#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define GetStringArg(%1,%2) for(new x = 0; getarg(%1,x) != '\0'; x++) %2[x] = getarg(%1,x)

#define yellow 0xFFFF00AA
#define green 0x33FF33AA
#define red 0xFF0000AA
#define white 0xFFFFFFAA
#define pink 0xCCFF00FFAA
#define blue 0x00FFFFAA
#define grey 0xC0C0C0AA

enum PlayerData {
	Level,          					// Stores the integer value for the player's level.
	Registered, 						// Determines whether or not the player has registered.
	bool:LoggedIn, 						// Determines whether or not the player has logged in.
	Wired,                              // Determins whether or not the player has been wired.
	WiredWarnings,                      // The amount of warnings that the player currently has.
	Jailed                              // Has the player been jailed?
};
enum SpectateData {
	bool:Spectating,                    // Determine whether the player is spectating.
	SpectateID                          // Store the ID that the player is spectating.
}
enum ConfigData {
	Float:TeleportXOffset,  			// Offset X for when you use goto or gethere.
	Float:TeleportYOffset, 				// Offset Y for when you use goto or gethere.
	Float:TeleportZOffset,  			// Offset Z for when you use goto or gethere.
	MinimumPasswordLength,  			// Minimum password length for registration.
	DisplayServerMessage,  			 	// Boolean to display the server message.
	SlapDecrement,	                    // The amount to subract with the command /SLAP.
	WiredWarnings,                      // The amount of warnings a player has when they are wired.
	GodWeapons,                         // Do you get weapons when you type /GOD?
	MaxLevel,                           // The maximum admin level possible.
	DisplayCommandMessage,              // Display the notice when an admin does a command?
	DisplayConnectMessages,             // Display connect and disconnect messages?
	MaxPing,                            // The maximum ping allowed for the ping kicker.
	AdminImmunity,                      // Allow admin immunity for ping kicks?
	PingSecondUpdate                    // The amount of seconds to check pings.
};
new Variables[MAX_PLAYERS][PlayerData], Config[ConfigData], VehicleLockData[MAX_VEHICLES]=false, Spec[MAX_PLAYERS][SpectateData];
new Menu:Blank1, Menu:Blank2, Menu:Blank3, Menu:Blank4, Menu:Blank5, Menu:GiveMe,Menu:GiveCar;
forward OnPlayerLogin(playerid); forward OnPlayerRegister(playerid); forward OnPlayerLogout(playerid); forward PingKick();
//==============================================================================
public OnFilterScriptInit() {
	print("Welcome to the Xtreme Administration Filterscript v2.0");
	print("Checking / creating server configuration...");
	//Check if all configuration files are present.
	if(!dini_Exists("/xadmin/Configuration/Configuration.ini")) {
	    dini_Create("/xadmin/Configuration/Configuration.ini");
	    dini_Set("/xadmin/Configuration/Configuration.ini","ServerMessage","None");
	}
	print("Creating user file variables configuration...");
	// Create the variables to be stored in each user's file.
	CreateLevelConfig(
		"IP","Registered","Level","Cash","Kills","Deaths","Password","Wired",
		"WiredWarnings","Jailed"
	);
	// Create Level Config in pattern 'command name, level, command name, level (case is not sensitive):
	print("Creating command level configuration...");
	CreateCommandConfig(
		// Time Commands
		"morning",1,"afternoon",1,"evening",1,"midnight",1,"settime",1,
		// Miscellaneous Commands
		"goto",5,"gethere",8,"announce",3,"say",1,"flip",1,"slap",6,"wire",8,"unwire",5,"kick",6,
		"ban",9,"akill",7,"eject",6,"freeze",8,"unfreeze",6,"outside",8,"healall",5,"uconfig",1,
		"setsm",3,"givehealth",6,"sethealth",6,"skinall",9,"giveallweapon",7,"resetallweapons",10,
		"setcash",7,"givecash",7,"remcash",7,"resetcash",7,"setallcash",10,"giveallcash",10,"remallcash",
		10,"resetallcash",10,"ejectall",8,"freezeall",10,"unfreezeall",10,"giveweapon",4,"god",10,
		"resetscores",7,"setlevel",10,"setskin",7,"givearmour",5,"setarmour",5,"armourall",5,
		"setammo",5,"setscore",8,"ip",1,"ping",1,"explode",5,"setname",10,"setalltime",10,
		"force",4,"setallworld",5,"setworld",2,"setgravity",4,"setwanted",6,"setallwanted",7
	);
	CreateCommandConfigEx(
		"xlock",1,"xunlock",1,"carcolor",1,"gmx",10,"carhealth",5,"setping",5,
		"giveme",6,"givecar",7,"xspec",4,"xjail",7,"xunjail",3,"vr",0
	);
	print("Creating main configuration files...");
	UpdateConfigurationVariables();
	print("Initializing Menus...");
	Blank1 = CreateMenu(" ",1,125,150,300);
	Blank2 = CreateMenu(" ",1,125,150,300);
	Blank3 = CreateMenu(" ",1,125,150,300);
	Blank4 = CreateMenu(" ",1,125,150,300);
	Blank5 = CreateMenu(" ",1,125,150,300);
	#pragma unused Blank1
	#pragma unused Blank2
	#pragma unused Blank3
	#pragma unused Blank4
	#pragma unused Blank5
	// Giveme Menu
	GiveMe = CreateMenu("Giveme Administration",1,125,150,300);
    if(IsValidMenu(GiveMe)) {
		SetMenuColumnHeader(GiveMe, 0, "Select a car to give yourself:");
		AddMenuItem(GiveMe,0,"Infernus");
		AddMenuItem(GiveMe,0,"NRG500");
		AddMenuItem(GiveMe,0,"Monster Truck");
		AddMenuItem(GiveMe,0,"Packer");
		AddMenuItem(GiveMe,0,"RC Car");
		AddMenuItem(GiveMe,0,"Rancher");
		AddMenuItem(GiveMe,0,"Roadtrain");
		AddMenuItem(GiveMe,0,"Dumper");
		AddMenuItem(GiveMe,0,"Sultan");
		AddMenuItem(GiveMe,0,"Maverick");
		AddMenuItem(GiveMe,0,"Vortex");
		AddMenuItem(GiveMe,0,"Hydra");
	}
		
	GiveCar = CreateMenu("Givecar Administration",1,125,150,300);
	if(IsValidMenu(GiveCar)) {
		SetMenuColumnHeader(GiveCar , 0, "Select a car component to add:");
		AddMenuItem(GiveCar ,0,"Nitrous x10");
		AddMenuItem(GiveCar ,0,"Hydraulics");
		AddMenuItem(GiveCar ,0,"Offroad Wheel");
		AddMenuItem(GiveCar ,0,"Wire Wheels");
	}
	print("Complete.");
	SetTimer("PingKick",Config[PingSecondUpdate]*1000,true);
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) OnPlayerConnect(i);
}
//==============================================================================
public OnPlayerConnect(playerid) {
	new string[256],PlayerName[24],file[256]; file = GetPlayerFile(playerid);
	if(Config[DisplayServerMessage]) { format(string,sizeof(string),"Server Message: %s",dini_Get("/xadmin/Configuration/Configuration.ini","ServerMessage")); SendClientMessage(playerid,green,string); }
	GetPlayerName(playerid,PlayerName,24); if(!dini_Exists(file)) CreateUserConfigFile(playerid);
	// Set Values From Config to Variables...
	Variables[playerid][Registered] = GetPlayerFileVar(playerid,"Registered"),
	Variables[playerid][Level] = GetPlayerFileVar(playerid,"Level");
	Variables[playerid][Wired] = GetPlayerFileVar(playerid,"Wired");
	Variables[playerid][Jailed] = GetPlayerFileVar(playerid,"Jailed");
	if(Variables[playerid][Wired]) SetUserInt(playerid,"WiredWarnings",Config[WiredWarnings]);
	if(Variables[playerid][Level] > Config[MaxLevel]) { Variables[playerid][Level] = Config[MaxLevel]; SetUserInt(playerid,"Level",Config[MaxLevel]); }
	// Display Welcoming Message...
    if(!Variables[playerid][Registered]) format(string,256,"Welcome, %s. To register an account to this server, type \"/REGISTER <PASSWORD>\".",PlayerName);
	else {
		// Does player have same IP?
		new tmp[50],tmp2[256]; GetPlayerIp(playerid,tmp,50); tmp2 = dini_Get(file,"IP");
		if(!strcmp(tmp,tmp2,true)) {
		    format(string,256,"Welcome back, %s. You have automatically been logged in.",PlayerName);
		    Variables[playerid][LoggedIn] = true;
		}
	 	else {
		 	format(string,256,"Welcome back, %s. To log back into your account, type \"/LOGIN <PASSWORD>\".",PlayerName);
		 	Variables[playerid][LoggedIn] = false;
		}
	}
	SendClientMessage(playerid,yellow,string);
	for(new i = 0; i < MAX_VEHICLES; i++) if(VehicleLockData[i]) SetVehicleParamsForPlayer(i,playerid,false,true);
	if(Config[DisplayConnectMessages]) { format(string,256,"*** %s has joined the server.",PlayerName); for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && playerid != i) SendClientMessage(i,grey,string); }
	return 1;
}
//==============================================================================
public OnPlayerSpawn(playerid) {
	if(Variables[playerid][Jailed]) { SetPlayerInterior(playerid,3); SetPlayerPos(playerid,197.6661,173.8179,1003.0234); SetPlayerFacingAngle(playerid,0); }
	return 1;
}
//==============================================================================
public OnPlayerDisconnect(playerid,reason) {
	new Reason[256],string[256],name[24]; GetPlayerName(playerid,name,24);
	switch(reason) { case 0: Reason = "Timed Out"; case 1: Reason = "Leaving"; case 2: Reason = "Kick/Ban"; }
	format(string,256,"*** %s has left the server. (%s)",name,Reason);
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && i != playerid) SendClientMessage(i,grey,string);
    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && Spec[i][SpectateID] == playerid  && Spec[i][Spectating]) { TogglePlayerSpectating(i,false); Spec[i][Spectating] = false, Spec[i][SpectateID] = INVALID_PLAYER_ID; }
	return 1;
}
//==============================================================================
public OnPlayerDeath(playerid,killerid,reason) {
	#pragma unused killerid
	#pragma unused reason
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && Spec[i][SpectateID] == playerid  && Spec[i][Spectating]) { TogglePlayerSpectating(i,false); Spec[i][Spectating] = false, Spec[i][SpectateID] = INVALID_PLAYER_ID; }
}
//==============================================================================
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid) {
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && Spec[i][SpectateID] == playerid  && Spec[i][Spectating]) SetPlayerInterior(i,newinteriorid);
	return 1;
}
//==============================================================================
public OnPlayerCommandText(playerid,cmdtext[]) {
	if(!IsPlayerConnected(playerid)) return 0;
	// Registration System Commands
	dcmd(register,8,cmdtext);
	dcmd(login,5,cmdtext);
	dcmd(logout,6,cmdtext);

	// Administration System Commands
	dcmd(goto,4,cmdtext);
	dcmd(gethere,7,cmdtext);
	dcmd(announce,8,cmdtext);
	dcmd(say,3,cmdtext);
	dcmd(flip,4,cmdtext);
	dcmd(serverinfo,10,cmdtext);
	dcmd(slap,4,cmdtext);
	dcmd(wire,4,cmdtext);
	dcmd(unwire,6,cmdtext);
	dcmd(kick,4,cmdtext);
	dcmd(ban,3,cmdtext);
	dcmd(akill,5,cmdtext);
	dcmd(eject,5,cmdtext);
	dcmd(freeze,6,cmdtext);
	dcmd(unfreeze,8,cmdtext);
	dcmd(outside,7,cmdtext);
	dcmd(healall,7,cmdtext);
	dcmd(givehealth,10,cmdtext);
	dcmd(sethealth,9,cmdtext);
	dcmd(skinall,7,cmdtext);
	dcmd(giveallweapon,13,cmdtext);
	dcmd(resetallweapons,15,cmdtext);
	dcmd(ejectall,8,cmdtext);
	dcmd(freezeall,9,cmdtext);
	dcmd(unfreezeall,11,cmdtext);
	dcmd(giveweapon,10,cmdtext);
	dcmd(god,3,cmdtext);
	dcmd(resetscores,11,cmdtext);
	dcmd(setlevel,8,cmdtext);
	dcmd(setskin,7,cmdtext);

	//Time Commands
	dcmd(midnight,8,cmdtext);
	dcmd(morning,7,cmdtext);
	dcmd(noon,4,cmdtext);
    dcmd(evening,7,cmdtext);

    // Config File Commands
	dcmd(uconfig,7,cmdtext);
	dcmd(sm,2,cmdtext);
	dcmd(setsm,5,cmdtext);

	//Cash Commands
	dcmd(setcash,7,cmdtext);
	dcmd(givecash,8,cmdtext);
	dcmd(remcash,7,cmdtext);
	dcmd(resetcash,9,cmdtext);
	dcmd(setallcash,10,cmdtext);
	dcmd(giveallcash,11,cmdtext);
	dcmd(remallcash,10,cmdtext);
	dcmd(resetallcash,12,cmdtext);

	// New Commands
	dcmd(givearmour,10,cmdtext);
	dcmd(setarmour,9,cmdtext);
	dcmd(armourall,9,cmdtext);
	dcmd(setammo,7,cmdtext);
	dcmd(setscore,8,cmdtext);
	dcmd(ip,2,cmdtext);
	dcmd(ping,4,cmdtext);
	dcmd(explode,7,cmdtext);
	dcmd(settime,7,cmdtext);
	dcmd(setalltime,10,cmdtext);
	dcmd(force,5,cmdtext);
	dcmd(setwanted,9,cmdtext);
	dcmd(setallwanted,12,cmdtext);
	dcmd(setworld,8,cmdtext);
	dcmd(setallworld,11,cmdtext);
	dcmd(setgravity,10,cmdtext);
	dcmd(xlock,5,cmdtext);
	dcmd(xunlock,7,cmdtext);
	dcmd(carcolor,8,cmdtext);
	dcmd(gmx,3,cmdtext);
	dcmd(carhealth,9,cmdtext);
	dcmd(xinfo,5,cmdtext);
	dcmd(setping,7,cmdtext);
	dcmd(giveme,6,cmdtext);
	dcmd(givecar,7,cmdtext);
	dcmd(xspec,5,cmdtext);
	dcmd(xjail,5,cmdtext);
	dcmd(xunjail,7,cmdtext);
	dcmd(setname,7,cmdtext);
	dcmd(admins,6,cmdtext);
	dcmd(xcommands,9,cmdtext);
	dcmd(vr,2,cmdtext);
	return 0;
}

//========================[REGISTRATION SYSTEM v2.0]============================
dcmd_register(playerid,params[]) {
	if(!strlen(params)) { new string[256]; format(string,256,"Syntax Error: \"/REGISTER <PASSWORD>\" [Password must be %d+].",Config[MinimumPasswordLength]); return SendClientMessage(playerid,red,string); }
	new index = 0,Password[256],string[256],PlayerFile[256]; Password = strtok(params,index); PlayerFile = GetPlayerFile(playerid);
	if(!(Variables[playerid][Registered] && Variables[playerid][LoggedIn])) {
	    if(strlen(Password) >= Config[MinimumPasswordLength]) {
	        format(string,sizeof(string),"You have registered your account with the password \"%s\" and automatically been logged in.",Password);
			SetUserInt(playerid,"Password",udb_hash(Password));
            SetUserInt(playerid,"Registered",1);
            SetUserInt(playerid,"LoggedIn",1);
	        Variables[playerid][LoggedIn] = true, Variables[playerid][Registered] = true;
	        SendClientMessage(playerid,blue,string);
	        new tmp3[100]; GetPlayerIp(playerid,tmp3,100); SetUserString(playerid,"IP",tmp3);
	        OnPlayerRegister(playerid);
	    } else SendClientMessage(playerid,red,"Syntax Error: \"/REGISTER <PASSWORD>\" [Password must be 3+].");
	} else SendClientMessage(playerid,red,"Error: Make sure that you have not registered and are logged out.");
	return 1;
}
dcmd_login(playerid,params[]) {
    if(!strlen(params)) { SendClientMessage(playerid,red,"Syntax Error: \"/LOGIN <PASSWORD>\"."); return 1; }
	new index = 0;
	new Password[256], string[256]; Password = strtok(params,index);
	new PlayerFile[256]; PlayerFile = GetPlayerFile(playerid);
    if(Variables[playerid][Registered] && !Variables[playerid][LoggedIn]) {
        if(udb_hash(Password) == dini_Int(PlayerFile,"Password")) {
            switch(Variables[playerid][Level]) {
                case 0: format(string,sizeof(string),"You have logged into your account. [Status Level: Member]");
                default: format(string,sizeof(string),"You have logged into your account. [Status Level: Administrator Lv. %d]",Variables[playerid][Level]);
			}
            SendClientMessage(playerid,blue,string);
	        SetUserInt(playerid,"LoggedIn",1); Variables[playerid][LoggedIn] = true;
	        new tmp3[100]; GetPlayerIp(playerid,tmp3,100); SetUserString(playerid,"IP",tmp3);
	        OnPlayerLogin(playerid);
        } else SendClientMessage(playerid,red,"Syntax Error: \"/LOGIN <PASSWORD>\".");
	} else SendClientMessage(playerid,red,"Error: You must be registered to log in; if you have make sure you haven't already logged in.");
	return 1;
}
dcmd_logout(playerid,params[]) {
	#pragma unused params
	new PlayerFile[256]; PlayerFile = GetPlayerFile(playerid);
    if(Variables[playerid][Registered] && Variables[playerid][LoggedIn]) {
		SendClientMessage(playerid,blue,"You have logged out of your account. You may log back in later by typing \"/LOGIN <PASSWORD>\".");
	 	SetUserInt(playerid,"LoggedIn",0); Variables[playerid][LoggedIn] = false; OnPlayerLogout(playerid);
	} else SendClientMessage(playerid,red,"Error: You must be registered and logged into your account first.");
	return 1;
}
//======================[ADMINISTRATION SYSTEM v2.0]============================
dcmd_goto(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"goto")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/GOTO <NICK OR ID>\".");
        new id;
		if(!IsNumeric(params)) id = ReturnPlayerID(params);
		else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    SendCommandMessageToAdmins(playerid,"GOTO");
			new string[256],PlayerName[24],ActionName[24],Float:X,Float:Y,Float:Z; GetPlayerName(playerid,PlayerName,24); GetPlayerName(id,ActionName,24);
			new Interior = GetPlayerInterior(id); SetPlayerInterior(playerid,Interior); SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(id)); GetPlayerPos(id,X,Y,Z); if(IsPlayerInAnyVehicle(playerid)) { SetVehiclePos(GetPlayerVehicleID(playerid),X+Config[TeleportXOffset],Y+Config[TeleportYOffset],Z+Config[TeleportZOffset]); LinkVehicleToInterior(GetPlayerVehicleID(playerid),Interior); } else SetPlayerPos(playerid,X+Config[TeleportXOffset],Y+Config[TeleportYOffset],Z+Config[TeleportZOffset]);
			format(string,256,"\"%s\" has teleported to your location.",PlayerName); SendClientMessage(id,yellow,string);
			format(string,256,"You have teleported to \"%s's\" location.",ActionName); return SendClientMessage(playerid,yellow,string);
  		} else return SendClientMessage(playerid,red,"ERROR: You can not teleport to yourself or disconnected players.");
	} else return SendLevelErrorMessage(playerid,"goto");
}
dcmd_gethere(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"gethere")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/GETHERE <NICK OR ID>\".");
        new id;
		if(!IsNumeric(params)) id = ReturnPlayerID(params);
		else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
			SendCommandMessageToAdmins(playerid,"GETHERE");
			new string[256],PlayerName[24],ActionName[24],Float:X,Float:Y,Float:Z; GetPlayerName(playerid,PlayerName,24); GetPlayerName(id,ActionName,24);
			new Interior = GetPlayerInterior(playerid); SetPlayerInterior(id,Interior); SetPlayerVirtualWorld(id,GetPlayerVirtualWorld(playerid)); GetPlayerPos(playerid,X,Y,Z); if(IsPlayerInAnyVehicle(id)) { SetVehiclePos(GetPlayerVehicleID(id),X+Config[TeleportXOffset],Y+Config[TeleportYOffset],Z+Config[TeleportZOffset]); LinkVehicleToInterior(GetPlayerVehicleID(id),Interior); } else SetPlayerPos(id,X+Config[TeleportXOffset],Y+Config[TeleportYOffset],Z+Config[TeleportZOffset]);
   			format(string,256,"You have teleported \"%s\" to your location.",ActionName); SendClientMessage(playerid,yellow,string);
			format(string,256,"You have been teleported to \"%s's\" location.",PlayerName); return SendClientMessage(id,yellow,string);
  		} else return SendClientMessage(playerid,red,"ERROR: You can not teleport yourself or a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"gethere");
}
dcmd_announce(playerid,params[]) {
    if(IsPlayerCommandLevel(playerid,"announce")) {
        SendCommandMessageToAdmins(playerid,"ANNOUNCE");
    	if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/ANNOUNCE <TEXT>\".");
		return GameTextForAll(params,4000,3);
    } else return SendLevelErrorMessage(playerid,"announce");
}
dcmd_say(playerid,params[]) {
    if(IsPlayerCommandLevel(playerid,"say")) {
        SendCommandMessageToAdmins(playerid,"SAY");
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/SAY <TEXT>\".");
		new string[256],name[24]; GetPlayerName(playerid,name,24); format(string,256,"** Admin %s: %s",name,params);
		return SendClientMessageToAll(pink,string);
	} else return SendLevelErrorMessage(playerid,"say");
}
dcmd_flip(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"flip")) {
	    if(IsPlayerInAnyVehicle(playerid)) {
	        SendCommandMessageToAdmins(playerid,"FLIP");
			new Float:X,Float:Y,Float:Z,Float:Angle,string[256],name[24]; GetPlayerName(playerid,name,24); GetVehiclePos(GetPlayerVehicleID(playerid),X,Y,Z); GetVehicleZAngle(GetPlayerVehicleID(playerid),Angle);
			SetVehiclePos(GetPlayerVehicleID(playerid),X,Y,Z+2); SetVehicleZAngle(GetPlayerVehicleID(playerid),Angle);
   			format(string,256,"Admin Chat: Administrator \"%s\" has flipped their vehicle.",name); return SendMessageToAdmins(string);
		} else return SendClientMessage(playerid,red,"ERROR: You must be in a vehicle.");
	} else return SendLevelErrorMessage(playerid,"flip");
}
dcmd_morning(playerid,params[]) {
    #pragma unused params
    if(IsPlayerCommandLevel(playerid,"morning")) {
        SendCommandMessageToAdmins(playerid,"MORNING");
        SetWorldTime(7); return SendClientMessageToAll(yellow,"The world time has been changed to 7:00.");
    } else return SendLevelErrorMessage(playerid,"morning");
}
dcmd_noon(playerid,params[]) {
    #pragma unused params
    if(IsPlayerCommandLevel(playerid,"noon")) {
    	SendCommandMessageToAdmins(playerid,"NOON");
        SetWorldTime(12); return SendClientMessageToAll(yellow,"The world time has been changed to 12:00.");
    } else return SendLevelErrorMessage(playerid,"noon");
}
dcmd_evening(playerid,params[]) {
    #pragma unused params
    if(IsPlayerCommandLevel(playerid,"evening")) {
        SendCommandMessageToAdmins(playerid,"EVENING");
        SetWorldTime(18); return SendClientMessageToAll(yellow,"The world time has been changed to 18:00.");
    } else return SendLevelErrorMessage(playerid,"evening");
}
dcmd_midnight(playerid,params[]) {
	#pragma unused params
    if(IsPlayerCommandLevel(playerid,"midnight")) {
        SendCommandMessageToAdmins(playerid,"MIDNIGHT");
        SetWorldTime(0); return SendClientMessageToAll(yellow,"The world time has been changed to 0:00.");
    } else return SendLevelErrorMessage(playerid,"midnight");
}
dcmd_serverinfo(playerid,params[]) {
	#pragma unused params
	new string[256]; format(string,256,"Server Information: [Players Connected: %d || Maximum Players: %d || Ratio: %.2f]",GetConnectedPlayers(),GetMaxPlayers(),floatdiv(GetConnectedPlayers(),GetMaxPlayers()));
	return SendClientMessage(playerid,green,string);
}
dcmd_slap(playerid,params[]) {
    if(IsPlayerCommandLevel(playerid,"slap")) {
   		if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/SLAP <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    SendCommandMessageToAdmins(playerid,"SLAP");
		    new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
		    format(string,256,"Admin Chat: Administrator \"%s\" has slapped player \"%s\".",name,ActionName); SendMessageToAdmins(string);
			new Float:Health; GetPlayerHealth(id,Health); return SetPlayerHealth(id,Health-Config[SlapDecrement]);
		} else return SendClientMessage(playerid,red,"ERROR: You can not slap yourself or a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"slap");
}
dcmd_wire(playerid,params[]) {
    if(IsPlayerCommandLevel(playerid,"wire")) {
   		if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/WIRE <NICK OR ID> (<REASON>)\".");
        new tmp[256],Index; tmp = strtok(params,Index);
	   	new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    if(!Variables[id][Wired]) {
		        SendCommandMessageToAdmins(playerid,"WIRE");
			    new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
			    if(!strlen(params[strlen(tmp)+1])) format(string,256,"\"%s\" has been wired by Administrator \"%s\".",ActionName,name);
				else format(string,256,"\"%s\" has been wired by Administrator \"%s\". (Reason: %s)",ActionName,name,params[strlen(tmp)+1]);
				Variables[id][Wired] = true, Variables[id][WiredWarnings] = Config[WiredWarnings];
		    	return SendClientMessageToAll(yellow,string);
			} else return SendClientMessage(playerid,red,"ERROR: This player has already been wired.");
		} else return SendClientMessage(playerid,red,"ERROR: You can not wire yourself or a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"wire");
}
dcmd_unwire(playerid,params[]) {
    if(IsPlayerCommandLevel(playerid,"unwire")) {
   		if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/UNWIRE <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    if(Variables[id][Wired]) {
		        SendCommandMessageToAdmins(playerid,"UNWIRE");
			    new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
				Variables[id][Wired] = false, Variables[id][WiredWarnings] = Config[WiredWarnings];
			    if(id != playerid) { format(string,256,"\"%s\" has been unwired by Administrator \"%s\".",ActionName,name); return SendClientMessageToAll(yellow,string); }
			    else return SendClientMessage(playerid,yellow,"You have successfully unwired yourself.");
        	} else return SendClientMessage(playerid,red,"ERROR: This player is not wired.");
		} else return SendClientMessage(playerid,red,"ERROR: You can not unwire a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"unwire");
}
dcmd_kick(playerid,params[]) {
    if(IsPlayerCommandLevel(playerid,"kick")) {
   		if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/KICK <NICK OR ID> (<REASON>)\".");
   		new tmp[256],Index; tmp = strtok(params,Index);
	   	new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    SendCommandMessageToAdmins(playerid,"KICK");
		    new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
	    	if(!strlen(params[strlen(tmp)+1])) format(string,256,"\"%s\" has been Kicked from the game by Administrator \"%s\".",ActionName,name);
			else format(string,256,"\"%s\" has been Kicked from the game by Administrator \"%s\". (Reason: %s)",ActionName,name,params[strlen(tmp)+1]);
			SendClientMessageToAll(yellow,string); return Kick(id);
		} else return SendClientMessage(playerid,red,"ERROR: You can not kick yourself or a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"kick");
}
dcmd_ban(playerid,params[]) {
    if(IsPlayerCommandLevel(playerid,"ban")) {
   		if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/BAN <NICK OR ID> (<REASON>)\".");
   		new tmp[256],Index; tmp = strtok(params,Index);
	   	new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    SendCommandMessageToAdmins(playerid,"BAN");
		    new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
		    if(!strlen(params[strlen(tmp)+1])) format(string,256,"\"%s\" has been Banned by Administrator \"%s\".",ActionName,name);
			else format(string,256,"\"%s\" has been Banned by Administrator \"%s\". (Reason: %s)",ActionName,name,params[strlen(tmp)+1]);
			SendClientMessageToAll(yellow,string); return Ban(id);
		} else return SendClientMessage(playerid,red,"ERROR: You can not ban yourself or a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"ban");
}
dcmd_akill(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"akill")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/AKILL <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    SendCommandMessageToAdmins(playerid,"AKILL");
		    new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
		    format(string,256,"You have been killed by Administrator \"%s\".",name); SendClientMessage(id,yellow,string);
		    format(string,256,"You have killed Player \"%s\".",ActionName); SendClientMessage(playerid,yellow,string); return SetPlayerHealth(id,0.0);
		} else return SendClientMessage(playerid,red,"ERROR: You can not auto-kill yourself or a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"akill");
}
dcmd_eject(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"eject")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/EJECT <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    if(IsPlayerInAnyVehicle(id)) {
		        SendCommandMessageToAdmins(playerid,"EJECT");
			    new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24); RemovePlayerFromVehicle(id);
			    if(id != playerid) {
					format(string,256,"You have been ejected from your vehicle by Administrator \"%s\".",name); SendClientMessage(id,yellow,string);
			    	format(string,256,"You have ejected Player \"%s\".",ActionName); return SendClientMessage(playerid,yellow,string);
				} else return SendClientMessage(playerid,yellow,"You have ejected yourself from your vehicle.");
			} else return SendClientMessage(playerid,red,"ERROR: This player must be in a vehicle.");
		} else return SendClientMessage(playerid,red,"ERROR: You can not eject a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"eject");
}
dcmd_freeze(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"freeze")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/FREEZE <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    SendCommandMessageToAdmins(playerid,"FREEZE");
		    new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
		    TogglePlayerControllable(id,false); format(string,256,"Admin Chat: Admnistrator \"%s\" has frozen \"%s\".",name,ActionName); return SendMessageToAdmins(string);
		} else return SendClientMessage(playerid,red,"ERROR: You can not freeze yourself or a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"freeze");
}
dcmd_unfreeze(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"unfreeze")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/UNFREEZE <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"UNFREEZE");
		    new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
		    TogglePlayerControllable(id,true); format(string,256,"Admin Chat: Admnistrator \"%s\" has unfrozen \"%s\".",name,ActionName);
			if(id != playerid) return SendMessageToAdmins(string); else return SendClientMessage(playerid,yellow,"You have unfrozen yourself.");
		} else return SendClientMessage(playerid,red,"ERROR: You can not unfreeze a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"unfreeze");
}
dcmd_outside(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"outside")) {
	    SendCommandMessageToAdmins(playerid,"OUTSIDE");
	    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerInterior(i,0);
	    new string[256],name[24]; GetPlayerName(playerid,name,24);
	    format(string,256,"Admnistrator \"%s\" has transfered everyone outside.",name); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"outside");
}
dcmd_healall(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"healall")) {
	    SendCommandMessageToAdmins(playerid,"HEALALL");
 		for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerHealth(i,100.0);
 		new string[256],name[24]; GetPlayerName(playerid,name,24);
	    format(string,256,"Everyone has been healed by Administrator \"%s\".",name); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"healall");
}
dcmd_sm(playerid,params[]) {
	#pragma unused params
	if(Config[DisplayServerMessage]) { new string[256]; format(string,sizeof(string),"Server Message: %s",dini_Get("/xadmin/Configuration/Configuration.ini","ServerMessage")); return SendClientMessage(playerid,green,string); }
	else return SendClientMessage(playerid,red,"ERROR: The server message has been disabled.");
}
dcmd_setsm(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setsm")) {
	    SendCommandMessageToAdmins(playerid,"SETSM");
		if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETSM <TEXT>\".");
		dini_Set("/xadmin/Configuration/Configuration.ini","ServerMessage",params);
    	new string[256],name[24]; GetPlayerName(playerid,name,24); format(string,256,"Admin Chat: New Server Message: %s",params); SendMessageToAdmins(string); return 1;
	} else return SendLevelErrorMessage(playerid,"setsm");
}
dcmd_uconfig(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"uconfig")) {
		SendCommandMessageToAdmins(playerid,"UCONFIG"); UpdateConfigurationVariables();
    	new string[256],name[24]; GetPlayerName(playerid,name,24); format(string,256,"Admin Chat: Administrator \"%s\" has updated the configuration variables.",name); SendMessageToAdmins(string);
		return 1;
	} else return SendLevelErrorMessage(playerid,"uconfig");
}
dcmd_givehealth(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"givehealth")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 1 && strval(tmp2) <= 100)) return SendClientMessage(playerid,red,"Syntax Error: \"/GIVEHEALTH <NICK OR ID> <1-100>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"GIVEHEALTH");
			new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has given you %d percent health.",name,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You have given \"%s\" %d percent health.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have given yourself %d percent health.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			new Float:Health; GetPlayerHealth(id,Health); return SetPlayerHealth(id,Health+strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not give a disconnected player health.");
	} else return SendLevelErrorMessage(playerid,"givehealth");
}
dcmd_sethealth(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"sethealth")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 0 && strval(tmp2) <= 100)) return SendClientMessage(playerid,red,"Syntax Error: \"/SET <NICK OR ID> <0-100>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"SETHEALTH");
			new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has set your health to %d percent.",name,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You have set \"%s's\" health to %d percent.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You've set your health to %d percent.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			return SetPlayerHealth(id,strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's health.");
	} else return SendLevelErrorMessage(playerid,"sethealth");
}
dcmd_skinall(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"skinall")) {
	    if(!strlen(params)||!IsNumeric(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/SKINALL <SKINID>\".");
		if(IsSkinValid(strval(params))) {
		    SendCommandMessageToAdmins(playerid,"SKINALL");
			new string[256],name[24]; GetPlayerName(playerid,name,24); for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerSkin(i,strval(params));
			format(string,256,"Everyone's skin has been changed to ID %d.",strval(params)); return SendClientMessageToAll(yellow,string);
		} else return SendClientMessage(playerid,red,"ERROR: Invalid skin ID.");
	} else return SendLevelErrorMessage(playerid,"skinall");
}
dcmd_giveallweapon(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"giveallweapon")) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index); tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) <= 0 || strval(tmp2) <= 10000)) return SendClientMessage(playerid,red,"Syntax Error: \"/GIVEALLWEAPON <WEAPON NAME | ID> <1-10,000>\".");
		new id; if(!IsNumeric(tmp)) id = ReturnWeaponID(tmp); else id = strval(tmp);
		if(id == -1||id==19||id==20||id==21||id==0||id==44||id==45) return SendClientMessage(playerid,red,"ERROR: You have selected an invalid weapon ID.");
        SendCommandMessageToAdmins(playerid,"GIVEALLWEAPON");
		new string[256],name[24],WeaponName[24]; GetWeaponName(id,WeaponName,24); if(id == 18) WeaponName = "Molotov"; GetPlayerName(playerid,name,24); for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) GivePlayerWeapon(i,id,strval(tmp2));
		format(string,256,"Everyone has been given %d \'%s\' by Administrator \"%s\".",strval(tmp2),WeaponName,name); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"giveallweapon");
}
dcmd_resetallweapons(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"resetallweapons")) {
	    SendCommandMessageToAdmins(playerid,"RESETALLWEAPONS");
		new string[256],name[24]; GetPlayerName(playerid,name,24); for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) ResetPlayerWeapons(i);
		format(string,256,"Administrator \"%s\" has reseted everyone's weapons.",name); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"resetallweapons");
}
dcmd_setcash(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setcash")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 1 && strval(tmp2) <= 1000000)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETCASH <NICK OR ID> <1 - 1,000,000>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"SETCASH");
			new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has set your cash to $%d.",name,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You have set \"%s's\" cash to $%d.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have set your cash to $%d.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			ResetPlayerMoney(id); return GivePlayerMoney(id,strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's cash.");
	} else return SendLevelErrorMessage(playerid,"setcash");
}
dcmd_givecash(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"givecash")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 1 && strval(tmp2) <= 1000000)) return SendClientMessage(playerid,red,"Syntax Error: \"/GIVECASH <NICK OR ID> <1 - 1,000,000>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"GIVECASH");
			new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has given you $%d.",name,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You have given \"%s\" $%d.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have given yourself $%d.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			return GivePlayerMoney(id,strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not give a disconnected player cash.");
	} else return SendLevelErrorMessage(playerid,"givecash");
}
dcmd_remcash(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"remcash")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 1 && strval(tmp2) <= 1000000)) return SendClientMessage(playerid,red,"Syntax Error: \"/REMCASH <NICK OR ID> <1 - 1,000,000>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"REMCASH");
			new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has removed $%d from your cash.",name,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You have removed $%d from \"%s's\" cash.",strval(tmp2),ActionName); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have removed $%d from your cash.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			return GivePlayerMoney(id,-strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not remove a disconnected player's cash.");
	} else return SendLevelErrorMessage(playerid,"remcash");
}
dcmd_resetcash(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"resetcash")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/RESETCASH <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"RESETCASH");
			new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has reseted your cash.",name); SendClientMessage(id,yellow,string); format(string,256,"You have reseted \"%s's\" cash.",ActionName); SendClientMessage(playerid,yellow,string); }
			else SendClientMessage(playerid,yellow,"You have reseted your cash.");
			return ResetPlayerMoney(id);
		} return SendClientMessage(playerid,red,"ERROR: You can not reset a disconnected player's cash.");
	} else return SendLevelErrorMessage(playerid,"resetcash");
}
dcmd_setallcash(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setallcash")) {
	    if(!strlen(params)||!IsNumeric(params)||!(strval(params)>=0&&strval(params)<=1000000)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETALLCASH <1 - 1,000,000>\".");
        SendCommandMessageToAdmins(playerid,"SETALLCASH");
		for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) { ResetPlayerMoney(i); GivePlayerMoney(i,strval(params)); }
		new string[256],name[24]; GetPlayerName(playerid,name,24); format(string,256,"Administrator \"%s\" has set every player's cash to $%d.",name,strval(params)); return SendClientMessage(playerid,yellow,string);
	} else return SendLevelErrorMessage(playerid,"setallcash");
}
dcmd_giveallcash(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"giveallcash")) {
	    if(!strlen(params)||!IsNumeric(params)||!(strval(params)>=0&&strval(params)<=1000000)) return SendClientMessage(playerid,red,"Syntax Error: \"/GIVEALLCASH <1 - 1,000,000>\".");
        SendCommandMessageToAdmins(playerid,"GIVEALLCASH");
		for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) GivePlayerMoney(i,strval(params));
		new string[256],name[24]; GetPlayerName(playerid,name,24); format(string,256,"Administrator \"%s\" has given every player $%d.",name,strval(params)); return SendClientMessage(playerid,yellow,string);
	} else return SendLevelErrorMessage(playerid,"giveallcash");
}
dcmd_remallcash(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"remallcash")) {
	    if(!strlen(params)||!(strval(params)>=0&&strval(params)<=1000000)) return SendClientMessage(playerid,red,"Syntax Error: \"/REMALLCASH <1 - 1,000,000>\".");
        SendCommandMessageToAdmins(playerid,"REMALLCASH");
		for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) GivePlayerMoney(i,-strval(params));
		new string[256],name[24]; GetPlayerName(playerid,name,24); format(string,256,"Administrator \"%s\" has removed $%d from everyone's cash.",name,strval(params)); return SendClientMessage(playerid,yellow,string);
	} else return SendLevelErrorMessage(playerid,"remallcash");
}
dcmd_resetallcash(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"resetallcash")) {
	    SendCommandMessageToAdmins(playerid,"RESETALLCASH");
	    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) ResetPlayerMoney(i);
		new string[256],name[24]; GetPlayerName(playerid,name,24); format(string,256,"Administrator \"%s\" resetted everyone's cash.",name); return SendClientMessage(playerid,yellow,string);
	} else return SendLevelErrorMessage(playerid,"resetallcash");
}
dcmd_ejectall(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"ejectall")) {
	    SendCommandMessageToAdmins(playerid,"EJECTALL");
	    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i)) RemovePlayerFromVehicle(i);
		new string[256],name[24]; GetPlayerName(playerid,name,24); format(string,256,"Administrator \"%s\" reseted ejected everyone from their vehicle.",name); return SendClientMessage(playerid,yellow,string);
	} else return SendLevelErrorMessage(playerid,"ejectall");
}
dcmd_freezeall(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"freezeall")) {
	    SendCommandMessageToAdmins(playerid,"FREEZEALL");
	    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) TogglePlayerControllable(i,false);
		new string[256],name[24]; GetPlayerName(playerid,name,24); format(string,256,"Administrator \"%s\" frozen everyone.",name); return SendClientMessage(playerid,yellow,string);
	} else return SendLevelErrorMessage(playerid,"freezeall");
}
dcmd_unfreezeall(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"unfreezeall")) {
		SendCommandMessageToAdmins(playerid,"UNFREEZEALL");
	    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) TogglePlayerControllable(i,true);
		new string[256],name[24]; GetPlayerName(playerid,name,24); format(string,256,"Administrator \"%s\" unfrozen everyone.",name); return SendClientMessage(playerid,yellow,string);
	} else return SendLevelErrorMessage(playerid,"unfreezeall");
}
dcmd_giveweapon(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"giveweapon")) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index),tmp2 = strtok(params,Index),tmp3 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!strlen(tmp3)||!IsNumeric(tmp3)||!(strval(tmp3) <= 0 || strval(tmp3) <= 10000)) return SendClientMessage(playerid,red,"Syntax Error: \"/GIVEWEAPON <NICK OR ID> <WEAPON NAME | ID> <1-10,000>\".");
		new id,id2; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp); if(!IsNumeric(tmp2)) id2 = ReturnWeaponID(tmp2); else id2 = strval(tmp2);
        if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
        	if(id2==-1||id2==19||id2==20||id2==21||id2==0||id2==44||id2==45) return SendClientMessage(playerid,red,"ERROR: You have selected an invalid weapon ID.");
            SendCommandMessageToAdmins(playerid,"GIVEWEAPON");
			new string[256],name[24],ActionName[24],WeaponName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24); GetWeaponName(id2,WeaponName,24); if(id2 == 18) WeaponName = "Molotov";
            if(id != playerid) { format(string,256,"Administrator \"%s\" has given you %d %s.",name,strval(tmp3),WeaponName); SendClientMessage(id,yellow,string); format(string,256,"You have given \"%s\" %d %s.",ActionName,strval(tmp3),WeaponName); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have given yourself %d %s.",strval(tmp3),WeaponName); SendClientMessage(playerid,yellow,string); }
			return GivePlayerWeapon(id,id2,strval(tmp3));
	    } else return SendClientMessage(playerid,red,"ERROR: You can not give a disconnected player a weapon.");
	} else return SendLevelErrorMessage(playerid,"giveweapon");
}
dcmd_god(playerid,params[]) {
    #pragma unused params
	if(IsPlayerCommandLevel(playerid,"god")) {
	    SendCommandMessageToAdmins(playerid,"GOD");
		if(!Config[GodWeapons]) { SetPlayerHealth(playerid,100000); return SendClientMessage(playerid,yellow,"You have given yourself infinite health."); }
	    else { SetPlayerHealth(playerid,100000); GivePlayerWeapon(playerid,38,50000); GivePlayerWeapon(playerid,WEAPON_GRENADE,50000); return SendClientMessage(playerid,yellow,"You have given yourself infinite health, minigun,grenades."); }
    } else return SendLevelErrorMessage(playerid,"god");
}
dcmd_resetscores(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"resetscores")) {
	    SendCommandMessageToAdmins(playerid,"RESETSCORES");
	    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerScore(i,0);
		new string[256],name[24]; GetPlayerName(playerid,name,24); format(string,256,"Administrator \"%s\" resetted everyone's score.",name); return SendClientMessage(playerid,yellow,string);
	} else return SendLevelErrorMessage(playerid,"resetscores");
}
dcmd_setlevel(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setlevel")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 0 && strval(tmp2) <= Config[MaxLevel])) { new string[256]; format(string,256,"Syntax Error: \"SETLEVEL <NICK OR ID> <0 - %d>\".",Config[MaxLevel]); return SendClientMessage(playerid,red,string); }
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
  			if(Variables[id][Level] == strval(tmp2)) return SendClientMessage(playerid,red,"ERROR: That player is already that level.");
			new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
            SendCommandMessageToAdmins(playerid,"SETLEVEL");
			format(string,256,"Administrator \"%s\" has %s you to %s [%d].",name,((strval(tmp2) >= Variables[id][Level])?("promoted"):("demoted")),((strval(tmp2))?("Administrator"):("Member Status")),strval(tmp2)); SendClientMessage(id,yellow,string);
			format(string,256,"You have %s \"%s\" to %s [%d].",((strval(tmp2) >= Variables[id][Level])?("promoted"):("demoted")),ActionName,((strval(tmp2))?("Administrator"):("Member Status")),strval(tmp2)); SendClientMessage(playerid,yellow,string);
			Variables[id][Level] = strval(tmp2); return SetUserInt(id,"Level",strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not set set your or a disconnected player's level.");
	} else return SendLevelErrorMessage(playerid,"setlevel");
}
dcmd_setskin(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setskin")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETSKIN <NICK OR ID> <SKINID>\".");
		if(!IsSkinValid(strval(tmp2))) return SendClientMessage(playerid,red,"ERROR: Invalid skin ID.");
  		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
			new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
            SendCommandMessageToAdmins(playerid,"SETSKIN");
			if(id != playerid) { format(string,256,"Administrator \"%s\" has set your skin to ID %d.",name,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You have set \"%s's\" skin ID to %d.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have set your skin ID to %d.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			return SetPlayerSkin(id,strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's skin.");
	} else return SendLevelErrorMessage(playerid,"setskin");
}
dcmd_givearmour(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"givearmour")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 1 && strval(tmp2) <= 100)) return SendClientMessage(playerid,red,"Syntax Error: \"/GIVEARMOUR <NICK OR ID> <1-100>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"GIVEARMOUR");
			new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has given you %d armour.",name,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You have given \"%s\" %d armour.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have given yourself %d armour.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			new Float:Armour; GetPlayerArmour(id,Armour); return SetPlayerArmour(id,Armour+strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not give a disconnected player armour.");
	} else return SendLevelErrorMessage(playerid,"givearmour");
}
dcmd_setarmour(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setarmour")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 1 && strval(tmp2) <= 100)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETARMOUR <NICK OR ID> <1-100>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"SETARMOUR");
			new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has set your armour to %d.",name,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You set \"%s\'s\" armour to %d.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have set your armour to %d.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			return SetPlayerArmour(id,strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's armour.");
	} else return SendLevelErrorMessage(playerid,"setarmour");
}
dcmd_armourall(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"armourall")) {
	    SendCommandMessageToAdmins(playerid,"ARMOURALL");
 		for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerArmour(i,100.0);
 		new string[256],name[24]; GetPlayerName(playerid,name,24);
	    format(string,256,"Everyone's armour has been restored by Administrator \"%s\".",name); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"armourall");
}
dcmd_setammo(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setammo")) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index),tmp2 = strtok(params,Index),tmp3 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!strlen(tmp3)||!IsNumeric(tmp3)||!IsNumeric(tmp2)||!(strval(tmp3) <= 0 || strval(tmp3) <= 10000)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETAMMO <NICK OR ID> <WEAPON SLOT> <1-10,000>\".");
		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
        if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
        	if(!(strval(tmp2) >= 0 && strval(tmp) <= 12)) return SendClientMessage(playerid,red,"ERROR: Invalid weapon slot! Range: 0 - 12");
            SendCommandMessageToAdmins(playerid,"SETAMMO");
			new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
            if(id != playerid) { format(string,256,"Administrator \"%s\" has set your ammunition in slot \'%d\' to %d.",name,strval(tmp2),strval(tmp3)); SendClientMessage(id,yellow,string); format(string,256,"You have set \"%s\'s\" ammunition in slot %d to %d.",ActionName,strval(tmp2),strval(tmp3)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have set your ammunition in slot \'%d\' to %d.",strval(tmp2),strval(tmp3)); SendClientMessage(playerid,yellow,string); }
			return SetPlayerAmmo(id,strval(tmp2),strval(tmp3));
	    } else return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's ammunition.");
	} else return SendLevelErrorMessage(playerid,"setammo");
}
dcmd_setscore(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setscore")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 1 && strval(tmp2) <= 100000)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETSCORE <NICK OR ID> <1-100,000>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"SETSCORE");
			new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has set your score to %d.",name,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You set \"%s\'s\" score to %d.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have set your score to %d.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			return SetPlayerScore(id,strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's score.");
	} else return SendLevelErrorMessage(playerid,"setscore");
}
dcmd_ip(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"ip")) {
	    SendCommandMessageToAdmins(playerid,"IP");
	    if(!strlen(params)) { new IP[256],string[256]; GetPlayerIp(playerid,IP,256); format(string,256,"Your IP: \'%s\'",IP); return SendClientMessage(playerid,yellow,string); }
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    new string[256],ActionName[24],IP[256]; GetPlayerName(id,ActionName,24); GetPlayerIp(id,IP,256);
		    format(string,256,"\"%s\'s\" IP: \'%s\'",ActionName,IP); return SendClientMessage(playerid,yellow,string);
		} else return SendClientMessage(playerid,red,"ERROR: You can not get the ip of a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"ip");
}
dcmd_ping(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"ping")) {
    	SendCommandMessageToAdmins(playerid,"PING");
	    if(!strlen(params)) { new string[256]; format(string,256,"Your Ping: \'%d\'",GetPlayerPing(playerid)); return SendClientMessage(playerid,yellow,string); }
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    new string[256],ActionName[24],IP[256]; GetPlayerName(id,ActionName,24); GetPlayerIp(id,IP,256);
		    format(string,256,"\"%s\'s\" Ping: \'%d\'",ActionName,GetPlayerPing(id)); return SendClientMessage(playerid,yellow,string);
		} else return SendClientMessage(playerid,red,"ERROR: You can not get the ping of a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"ping");
}
dcmd_explode(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"explode")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/EXPLODE <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"EXPLODE");
  			new string[256],name[24],ActionName[24],Float:X,Float:Y,Float:Z; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
			if(!IsPlayerInAnyVehicle(id)) GetPlayerPos(id,X,Y,Z); else GetVehiclePos(GetPlayerVehicleID(id),X,Y,Z); for(new i = 1; i <= 5; i++) CreateExplosion(X,Y,Z,10,0);
		    if(id != playerid) {
				format(string,256,"You have been exploded by Administrator \"%s\".",name); SendClientMessage(id,yellow,string);
		    	format(string,256,"You have exploded Player \"%s\".",ActionName); return SendClientMessage(playerid,yellow,string);
			} else return SendClientMessage(playerid,yellow,"You have exploded yourself.");
		} else return SendClientMessage(playerid,red,"ERROR: You can not explode a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"explode");
}
dcmd_settime(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"settime")) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index),tmp2 = strtok(params,Index),tmp3 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!strlen(tmp3)||!IsNumeric(tmp2)||!IsNumeric(tmp3)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETTIME <NICK OR ID> <HOUR> <MINUTE>\".");
		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
        if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
            SendCommandMessageToAdmins(playerid,"SETTIME");
            new name[24],string[256],Hour[5],Minute[5],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
        	format(Hour,5,"%s%d",((strval(tmp2)<10)?("0"):("")),strval(tmp2)); format(Minute,5,"%s%d",((strval(tmp3)<10)?("0"):("")),strval(tmp3));
            if(id != playerid) { format(string,256,"Administrator \"%s\" has set your time to \'%s:%s\'.",name,Hour,Minute); SendClientMessage(id,yellow,string); format(string,256,"You have set \"%s's\" time to \'%s:%s\'.",ActionName,Hour,Minute); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have set your time to \'%s:%s\'.",Hour,Minute); SendClientMessage(playerid,yellow,string); }
			return SetPlayerTime(id,strval(tmp2),strval(tmp3));
	    } else return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's time.");
	} else return SendLevelErrorMessage(playerid,"settime");
}
dcmd_setalltime(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setalltime")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp)||!IsNumeric(tmp2)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETALLTIME <HOUR> <MINUTE>\".");
		SendCommandMessageToAdmins(playerid,"SETALLTIME");
		new name[24],string[256],Hour[5],Minute[5]; GetPlayerName(playerid,name,24);
        format(Hour,5,"%s%d",((strval(tmp)<10)?("0"):("")),strval(tmp)); format(Minute,5,"%s%d",((strval(tmp2)<10)?("0"):("")),strval(tmp2));
        format(string,256,"Administrator \"%s\" has set everyone's time to \'%s:%s\'.",name,Hour,Minute);
		for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerTime(i,strval(tmp),strval(tmp2)); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"setalltime");
}
dcmd_force(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"force")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/FORCE <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    SendCommandMessageToAdmins(playerid,"FORCE");
		    new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
		    ForceClassSelection(id); SetPlayerHealth(id,0); format(string,256,"Admnistrator \"%s\" has forced you to the spawn selection screen.",name); SendClientMessage(id,yellow,string);
            format(string,256,"You have forced Player \"%s\" to the spawn selection screen.",ActionName); return SendClientMessage(playerid,yellow,string);
		} else return SendClientMessage(playerid,red,"ERROR: You can not force yourself or a disconnected player to the spawn selection screen.");
	} else return SendLevelErrorMessage(playerid,"force");
}
dcmd_setwanted(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setwanted")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 0 && strval(tmp2) <= 6)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETWANTED <NICK OR ID> <0-6>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"SETWANTED");
			new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has set your wanted level to %d.",name,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You set \"%s\'s\" wanted level to %d.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have set your wanted level to %d.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			return SetPlayerWantedLevel(id,strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's wanted level.");
	} else return SendLevelErrorMessage(playerid,"setwanted");
}
dcmd_setallwanted(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setallwanted")) {
	    if(!strlen(params)||!IsNumeric(params)||!(strval(params) >= 0 && strval(params) <= 6)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETALLWANTED <0-6>\".");
		new name[24],string[256]; GetPlayerName(playerid,name,24);
		SendCommandMessageToAdmins(playerid,"SETALLWANTED");
        format(string,256,"Administrator \"%s\" has set everyone's wanted level to %d.",name,strval(params));
		for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerWantedLevel(i,strval(params)); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"setallwanted");
}
dcmd_setworld(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setworld")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 0 && strval(tmp2) <= 255)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETWORLD <NICK OR ID> <VIRT. WORLD ID>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    SendCommandMessageToAdmins(playerid,"SETWORLD");
			new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has set your virtual world to %d.",name,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You set \"%s\'s\" virtual world to %d.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You have set your virtual world to %d.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			return SetPlayerVirtualWorld(id,strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's virtual world.");
	} else return SendLevelErrorMessage(playerid,"setworld");
}
dcmd_setallworld(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setallworld")) {
	    if(!strlen(params)||!IsNumeric(params)||!(strval(params) >= 0 && strval(params) <= 255)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETALLWORLD <VIRT. WORLD ID>\".");
		new name[24],string[256]; GetPlayerName(playerid,name,24);
		SendCommandMessageToAdmins(playerid,"SETALLWORLD");
        format(string,256,"Administrator \"%s\" has set everyone's virtual world to %d.",name,strval(params));
		for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerVirtualWorld(i,strval(params)); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"setallworld");
}
dcmd_setgravity(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setgravity")) {
	    if(!strlen(params)||!(strval(params)<=50&&strval(params)>=-50)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETGRAVITY <-50.0 - 50.0>\".");
        SendCommandMessageToAdmins(playerid,"SETGRAVITY");
		new string[256],name[24]; GetPlayerName(playerid,name,24); new Float:Gravity = floatstr(params);format(string,256,"Admnistrator \"%s\" has set the gravity to: \'%f\'.",name,Gravity);
		SetGravity(Gravity); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"setgravity");
}
dcmd_xlock(playerid,params[]) {
	#pragma unused params
    if(IsPlayerCommandLevel(playerid,"xlock")) {
		if(IsPlayerInAnyVehicle(playerid)) {
		    SendCommandMessageToAdmins(playerid,"XLOCK");
		    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i,false,true);
			new string[256],name[24]; VehicleLockData[GetPlayerVehicleID(playerid)] = true; GetPlayerName(playerid,name,24); format(string,256,"Administrator \"%s\" has locked their vehicle.",name); return SendClientMessageToAll(yellow,string);
		} else return SendClientMessage(playerid,red,"ERROR: You must be in a vehicle to lock.");
	} else return SendLevelErrorMessage(playerid,"xlock");
}
dcmd_xunlock(playerid,params[]) {
	#pragma unused params
    if(IsPlayerCommandLevel(playerid,"xunlock")) {
		if(IsPlayerInAnyVehicle(playerid)) {
		    SendCommandMessageToAdmins(playerid,"XUNLOCK");
		    for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i,false,false);
			new string[256],name[24]; VehicleLockData[GetPlayerVehicleID(playerid)] = false; GetPlayerName(playerid,name,24); format(string,256,"Administrator \"%s\" has unlocked their vehicle.",name); return SendClientMessageToAll(yellow,string);
		} else return SendClientMessage(playerid,red,"ERROR: You must be in a vehicle to unlock.");
	} else return SendLevelErrorMessage(playerid,"xunlock");
}
dcmd_carcolor(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"carcolor")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!(strval(tmp) >= 0 && strval(tmp) <= 126)||!IsNumeric(tmp)||!IsNumeric(tmp2)) return SendClientMessage(playerid,red,"Syntax Error: \"/CARCOLOR <COLOR 1> (<COLOR 2>)\".");
		if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,red,"ERROR: You must be in a vehicle.");
        SendCommandMessageToAdmins(playerid,"CARCOLOR");
		if(!strlen(tmp2)) tmp2 = tmp;
		new string[256],name[24]; GetPlayerName(playerid,name,24);
		format(string,256,"You have set your color data to: [Color 1: %d || Color 2: %d]",strval(tmp),strval(tmp2));
		return ChangeVehicleColor(GetPlayerVehicleID(playerid),strval(tmp),strval(tmp2));
	} else return SendLevelErrorMessage(playerid,"carcolor");
}
dcmd_gmx(playerid,params[]) {
    #pragma unused params
    if(IsPlayerCommandLevel(playerid,"gmx")) {
        SendCommandMessageToAdmins(playerid,"GMX");
        new string[256],name[24]; GetPlayerName(playerid,name,24); format(string,256,"Administrator \"%s\" has restarted the game mode.",name); SendClientMessageToAll(yellow,string); return GameModeExit();
    } else return SendLevelErrorMessage(playerid,"gmx");
}
dcmd_carhealth(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"carhealth")) {
	    new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(!strlen(tmp)||!strlen(tmp2)||!IsNumeric(tmp2)||!(strval(tmp2) >= 0 && strval(tmp2) <= 1000)) return SendClientMessage(playerid,red,"Syntax Error: \"/CARHEALTH <NICK OR ID> <0-1000>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
		    if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid,red,"ERROR: This player must be in a vehicle.");
            SendCommandMessageToAdmins(playerid,"CARHEALTH");
			new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has set your car's health to %d percent.",name,strval(tmp2)); SendClientMessage(id,yellow,string); format(string,256,"You have set \"%s's\" car's health to %d percent.",ActionName,strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You've set your car's health to %d percent.",strval(tmp2)); SendClientMessage(playerid,yellow,string); }
			return SetVehicleHealth(GetPlayerVehicleID(id),strval(tmp2));
		} return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's car health.");
	} else return SendLevelErrorMessage(playerid,"carhealth");
}
dcmd_xinfo(playerid,params[]) {
	#pragma unused params
	return SendClientMessage(playerid,green,"X-Treme Administration Info: [Creator: Xtreme || Version: 2.0 || Patch: 2 || Rel. Date: June 22, 2007]");
}
dcmd_setping(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"setping")) {
	    if(!strlen(params)||!(strval(params) >= 0 && strval(params) <= 10000)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETPING <[0 / OFF] - 10,000>\".");
   		if(!IsNumeric(params)) {
   		    if(!strcmp(params,"off",true)) { Config[MaxPing] = 0; SetConfigInt("MaxPing",0); }
   		    else return SendClientMessage(playerid,red,"Syntax Error: \"/SETPING <[0 / OFF] - 10,000>\".");
   	    }
        Config[MaxPing] = strval(params); SetConfigInt("MaxPing",strval(params));
    	SendCommandMessageToAdmins(playerid,"SETPING");
		new string[256],name[24],Fo[30]; GetPlayerName(playerid,name,24); format(Fo,30,"to %d",Config[MaxPing]); if(!Config[MaxPing]) Fo = "off";
		format(string,256,"Administrator \"%s\" has set the Maximum Ping %s.",name,Fo); return SendClientMessageToAll(yellow,string);
	} else return SendLevelErrorMessage(playerid,"setping");
}
dcmd_giveme(playerid,params[]) {
    #pragma unused params
    if(IsPlayerCommandLevel(playerid,"giveme")) {
        if(Spec[playerid][Spectating]) return SendClientMessage(playerid,red,"ERROR: You must not be spectating.");
        if(!IsPlayerInAnyVehicle(playerid)) {
        	TogglePlayerControllable(playerid,false);
        	SetCameraBehindPlayer(playerid);
        	return ShowMenuForPlayer(GiveMe,playerid);
        } else return SendClientMessage(playerid,red,"ERROR: You can not be in a vehicle.");
    } else return SendLevelErrorMessage(playerid,"giveme");
}
dcmd_givecar(playerid,params[]) {
    #pragma unused params
    if(IsPlayerCommandLevel(playerid,"givecar")) {
        if(Spec[playerid][Spectating]) return SendClientMessage(playerid,red,"ERROR: You must not be spectating.");
        if(IsPlayerInAnyVehicle(playerid)) {
            new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
            switch(Model) { case 448,461,462,463,468,471,509,510,521,522,523,581,586: return SendClientMessage(playerid,red,"ERROR: You can not add components to bikes!"); }
        	TogglePlayerControllable(playerid,false);
        	SetCameraBehindPlayer(playerid);
        	return ShowMenuForPlayer(GiveCar,playerid);
        } else return SendClientMessage(playerid,red,"ERROR: You must be in a vehicle.");
    } else return SendLevelErrorMessage(playerid,"givecar");
}
dcmd_xspec(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"xspec")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/XSPEC <NICK OR ID | OFF>\".");
        new id;
		if(!IsNumeric(params)) {
		    if(!strcmp(params,"off",true)) {
		        if(!Spec[playerid][Spectating]) return SendClientMessage(playerid,red,"ERROR: You must be spectating.");
		        SendCommandMessageToAdmins(playerid,"SPEC");
		        TogglePlayerSpectating(playerid,false);
		        Spec[playerid][Spectating] = false;
		        return SendClientMessage(playerid,yellow,"You have turned your spectator mode off.");
		    }
		  	id = ReturnPlayerID(params);
		}
		else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    SendCommandMessageToAdmins(playerid,"SPEC");
		    new string[256],name[24]; GetPlayerName(id,name,24);
		    if(Spec[id][Spectating]) return SendClientMessage(playerid,red,"Error: You can not spectate a player already spectating.");
	        if(Spec[playerid][Spectating] && Spec[playerid][SpectateID] == id) return SendClientMessage(playerid,red,"ERROR: You are already spectating this player.");
			Spec[playerid][Spectating] = true, Spec[playerid][SpectateID] = id;
	        SetPlayerInterior(playerid,GetPlayerInterior(id));
	        TogglePlayerSpectating(playerid,true);
			if(!IsPlayerInAnyVehicle(id)) PlayerSpectatePlayer(playerid,id);
			else PlayerSpectateVehicle(playerid,GetPlayerVehicleID(id));
	    	format(string,256,"You are now spectating player \"%s\".",name); return SendClientMessage(playerid,yellow,string);
		} else return SendClientMessage(playerid,red,"ERROR: You can not spectate yourself or a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"spec");
}
dcmd_xjail(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"xjail")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/XJAIL <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
		    if(Variables[id][Jailed]) return SendClientMessage(playerid,red,"ERROR: This player has already been jailed.");
		    SendCommandMessageToAdmins(playerid,"XJAIL");
			new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
			format(string,256,"Administrator \"%s\" has jailed you.",name); SendClientMessage(id,yellow,string); format(string,256,"You have jailed \"%s\".",ActionName); SendClientMessage(playerid,yellow,string);
			SetUserInt(id,"Jailed",1); Variables[id][Jailed] = true; SetPlayerInterior(id,3); SetPlayerPos(id,197.6661,173.8179,1003.0234); return SetPlayerFacingAngle(id,0);
		} return SendClientMessage(playerid,red,"ERROR: You can not jail yourself or a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"xjail");
}
dcmd_xunjail(playerid,params[]) {
	if(IsPlayerCommandLevel(playerid,"xunjail")) {
	    if(!strlen(params)) return SendClientMessage(playerid,red,"Syntax Error: \"/XUNJAIL <NICK OR ID>\".");
   		new id; if(!IsNumeric(params)) id = ReturnPlayerID(params); else id = strval(params);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID && id != playerid) {
            if(!Variables[id][Jailed]) return SendClientMessage(playerid,red,"ERROR: This player has already been unjailed.");
			SendCommandMessageToAdmins(playerid,"XUNJAIL");
			new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has unjailed you.",name); SendClientMessage(id,yellow,string); format(string,256,"You have unjailed \"%s\".",ActionName); SendClientMessage(playerid,yellow,string); }
			else SendClientMessage(playerid,yellow,"You have unjailed yourself.");
			SetUserInt(id,"Jailed",0); Variables[id][Jailed] = false; return SpawnPlayer(id);
		} return SendClientMessage(playerid,red,"ERROR: You can not unjail a disconnected player.");
	} else return SendLevelErrorMessage(playerid,"xunjail");
}
dcmd_setname(playerid,params[]) {
    if(IsPlayerCommandLevel(playerid,"setname")) {
    	new tmp[256],tmp2[256],Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
   	 	if(!strlen(tmp)||!strlen(tmp2)) return SendClientMessage(playerid,red,"Syntax Error: \"/SETNAME <NICK OR ID> <NEW NAME>\".");
   		new id; if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
		if(IsPlayerConnected(id) && id != INVALID_PLAYER_ID) {
            SendCommandMessageToAdmins(playerid,"SETNAME");
			new string[256],name[24],ActionName[24]; GetPlayerName(playerid,name,24); GetPlayerName(id,ActionName,24);
			if(id != playerid) { format(string,256,"Administrator \"%s\" has set your name to %s.",name,tmp2); SendClientMessage(id,yellow,string); format(string,256,"You have set \"%s's\" name to %s.",ActionName,tmp2); SendClientMessage(playerid,yellow,string); }
			else { format(string,256,"You've set your name to %s.",tmp2); SendClientMessage(playerid,yellow,string); }
			OnPlayerConnect(id); return SetPlayerName(id,tmp2);
		} return SendClientMessage(playerid,red,"ERROR: You can not set a disconnected player's name.");
	} else return SendLevelErrorMessage(playerid,"setname");
}
dcmd_admins(playerid,params[]) {
	#pragma unused params
	new Count,i,name[24],string[256];
	for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IsPlayerXAdmin(i)) Count++;
	if(!Count) return SendClientMessage(playerid,green,"Admins Online: None");
	if(Count == 1) {
	    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IsPlayerXAdmin(i)) break;
	    GetPlayerName(i,name,24); format(string,256,"Admins Online: %s (%d)",name,Variables[i][Level]);
	    return SendClientMessage(playerid,green,string);
	}
	if(Count >= 1) {
	    new bool:First = false;
	    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IsPlayerXAdmin(i)) {
     		GetPlayerName(i,name,24);
			if(!First) { format(string,256,"Admins Online: %s (%d),",name,Variables[i][Level]); First = true; }
	        else format(string,256,"%s %s (%d)",string,name,Variables[i][Level]);
	    }
	    return SendClientMessage(playerid,green,string);
	}
	return 1;
}
dcmd_xcommands(playerid,params[]) {
    #pragma unused params
	if(!IsPlayerXAdmin(playerid)) return SendClientMessage(playerid,red,"ERROR: You must be an administrator to view these commands.");
	SendClientMessage(playerid,yellow,"morning,afternoon,evening,midnight,settime,goto,gethere,announce,say,flip,slap,(un)wire,kick,ban");
	SendClientMessage(playerid,yellow,"akill,eject(all),(un)freeze(all),outside,healall,uconfig,setsm,givehealth,sethealth,skinall,armourall");
	SendClientMessage(playerid,yellow,"resetallweapons,set/give/rem/reset(all)cash,god,resetscores,setlevel,setskin,givearmour,setarmour");
	SendClientMessage(playerid,yellow,"setammo,setscore,ip,ping,explode,setname,setalltime,force,set(all)world,setgravity,set(all)wanted");
	return SendClientMessage(playerid,yellow,"carcolor,give(all)weapon,x(unlock),gmx,carhealth,setping,giveme,givecar,spec,xcommands");
}
dcmd_vr(playerid,params[]) {
	#pragma unused params
	if(IsPlayerCommandLevel(playerid,"vr")) {
    	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,red,"ERROR: You must be in a vehicle to repair.");
		SetVehicleHealth(GetPlayerVehicleID(playerid),1000.0);
		return SendClientMessage(playerid,yellow,"You have successfully repaired your vehicle!");
	} else return SendLevelErrorMessage(playerid,"vr");
}
//=====================[DYNAMIC CONFIGURATION SYSTEM]===========================
CreateLevelConfig({Float,_}:...) {
	new tmp[256],file[256]; file = "/xadmin/Configuration/Variables.ini";
	if(dini_Exists(file)) dini_Remove(file); dini_Create(file); dini_IntSet(file,"Count",0);
	new Count = dini_Int(file,"Count"), string[256];
	for(new i = 0; i < numargs(); i++) { ClearString(256,string); GetStringArg(i,string); valstr(tmp,Count); dini_Set(file,tmp,string); Count++; dini_IntSet(file,"Count",Count); }
}
CreateCommandConfig({Float,_}:...) {
	new i = 0,key[256],value,file[256]; file = "/xadmin/Configuration/Commands.ini";
	if(!dini_Exists(file)) dini_Create(file);
	while(i < numargs()) { ClearString(256,key); GetStringArg(i,key); value = getarg(i+1,0); if(!dini_Isset(file,key)) dini_IntSet(file,key,value); i += 2; }
}
CreateCommandConfigEx({Float,_}:...) {
	new i = 0,key[256],value,file[256]; file = "/xadmin/Configuration/Commands.ini";
	while(i < numargs()) { ClearString(256,key); GetStringArg(i,key); value = getarg(i+1,0); if(!dini_Isset(file,key)) dini_IntSet(file,key,value); i += 2; }
}
CreateUserConfigFile(playerid) {
	new file[256],name[24],config[256],tmp[256],tmp2[256]; config = "/xadmin/Configuration/Variables.ini"; GetPlayerName(playerid,name,24); format(file,256,"/xadmin/Users/%s.ini",udb_encode(name));
	if(!dini_Exists(file)) dini_Create(file); if(!dini_Exists(config)) dini_Create(config);
	for(new i = 0; i < dini_Int(config,"Count"); i++) { valstr(tmp,i); tmp2 = dini_Get(config,tmp); if(!dini_Isset(file,tmp2)) dini_IntSet(file,tmp2,0); }
}
GetPlayerFileVar(playerid,var[]) {
	new file[256]; file = GetPlayerFile(playerid);
	return (!dini_Exists(file)) ? 0 : dini_Int(file,var);
}
SetUserString(playerid,var[],value[]) { new file[256]; file = GetPlayerFile(playerid); if(!dini_Exists(file)) dini_Create(file); dini_Set(file,var,value); }
SetUserInt(playerid,var[],value) { new file[256]; file = GetPlayerFile(playerid); if(!dini_Exists(file)) dini_Create(file); dini_IntSet(file,var,value); return 1; }
SetConfigInt(var[],value) {
	new file[256]; file = "/xadmin/Configuration/Variables.ini";
	if(!dini_Isset(file,var)) return 0;
	dini_IntSet(file,var,value);
	return 1;
}
UpdateConfigurationVariables() {
	new ConfigFile[256]; ConfigFile = "/xadmin/Configuration/Configuration.ini";
	if(!dini_Exists(ConfigFile)) dini_Create(ConfigFile);
	// Make sure required variables exist.
	if(!dini_Isset(ConfigFile,"ServerMessage")) dini_Set(ConfigFile,"ServerMessage","Welcome to Xtreme Admin 2.0!");
	if(!dini_Isset(ConfigFile,"Teleport_X_Offset")) dini_FloatSet(ConfigFile,"Teleport_X_Offset",0.0);
    if(!dini_Isset(ConfigFile,"Teleport_Y_Offset")) dini_FloatSet(ConfigFile,"Teleport_Y_Offset",-5.0);
    if(!dini_Isset(ConfigFile,"Teleport_Z_Offset")) dini_FloatSet(ConfigFile,"Teleport_Z_Offset",0.0);
    if(!dini_Isset(ConfigFile,"MinimumPasswordLength")) dini_IntSet(ConfigFile,"MinimumPasswordLength",3);
    if(!dini_Isset(ConfigFile,"DisplayServerMessage")) dini_IntSet(ConfigFile,"DisplayServerMessage",1);
    if(!dini_Isset(ConfigFile,"SlapDecrement")) dini_IntSet(ConfigFile,"SlapDecrement",20);
    if(!dini_Isset(ConfigFile,"WiredWarnings")) dini_IntSet(ConfigFile,"WiredWarnings",3);
    if(!dini_Isset(ConfigFile,"GodWeapons")) dini_IntSet(ConfigFile,"GodWeapons",1);
    if(!dini_Isset(ConfigFile,"MaxLevel")) dini_IntSet(ConfigFile,"MaxLevel",10);
    if(!dini_Isset(ConfigFile,"DisplayCommandMessage")) dini_IntSet(ConfigFile,"DisplayCommandMessage",1);
    if(!dini_Isset(ConfigFile,"DisplayConnectMessages")) dini_IntSet(ConfigFile,"DisplayConnectMessages",1);
    if(!dini_Isset(ConfigFile,"MaxPing")) dini_IntSet(ConfigFile,"MaxPing",500);
    if(!dini_Isset(ConfigFile,"AdminImmunity")) dini_IntSet(ConfigFile,"AdminImmunity",1);
    if(!dini_Isset(ConfigFile,"PingSecondUpdate")) dini_IntSet(ConfigFile,"PingSecondUpdate",10);
	// Update to array.
	Config[TeleportXOffset] = dini_Float(ConfigFile,"Teleport_X_Offset");
    Config[TeleportYOffset] = dini_Float(ConfigFile,"Teleport_Y_Offset");
    Config[TeleportZOffset] = dini_Float(ConfigFile,"Teleport_Z_Offset");
    Config[MinimumPasswordLength] = dini_Int(ConfigFile,"MinimumPasswordLength");
    Config[DisplayServerMessage] = dini_Bool(ConfigFile,"DisplayServerMessage");
    Config[SlapDecrement] = dini_Bool(ConfigFile,"SlapDecrement");
    Config[WiredWarnings] = dini_Int(ConfigFile,"WiredWarnings");
    Config[GodWeapons] = dini_Int(ConfigFile,"GodWeapons");
    Config[MaxLevel] = dini_Int(ConfigFile,"MaxLevel");
    Config[DisplayCommandMessage] = dini_Int(ConfigFile,"DisplayCommandMessage");
    Config[DisplayConnectMessages] = dini_Int(ConfigFile,"DisplayConnectMessages");
    Config[MaxPing] = dini_Int(ConfigFile,"MaxPing");
    Config[AdminImmunity] = dini_Int(ConfigFile,"AdminImmunity");
    Config[PingSecondUpdate] = dini_Int(ConfigFile,"PingSecondUpdate");
}
//==========================[CUSTOM FUNCTIONS]==================================
ClearString(MaxLength,string[]) for(new i = 0; i < MaxLength; i++) format(string[i],1,"");
IsPlayerCommandLevel(playerid,command[]) {
	if(!dini_Isset("/xadmin/Configuration/Commands.ini",command)) return false;
	return (IsPlayerConnected(playerid) && Variables[playerid][LoggedIn] && (Variables[playerid][Level] >= dini_Int("/xadmin/Configuration/Commands.ini",command) || dini_Int("/xadmin/Configuration/Commands.ini",command) == 0)) ? true : false;
}
GetPlayerFile(playerid) { new string[256], PlayerName[24]; GetPlayerName(playerid,PlayerName,24); format(string,256,"/xadmin/Users/%s.ini",udb_encode(PlayerName)); return string; }
SendLevelErrorMessage(playerid,command[]) { new string[256]; format(string,256,"ERROR: You must be administrator level %d to use this command.",dini_Int("/xadmin/Configuration/Commands.ini",command)); return SendClientMessage(playerid,red,string); }
ReturnPlayerID(PlayerName[]) {
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) { new name[24]; GetPlayerName(i,name,24); if(strfind(name,PlayerName,true)!=-1) return i; }
	return INVALID_PLAYER_ID;
}
ReturnWeaponID(WeaponName[]) {
	if(strfind("molotov",WeaponName,true)!=-1) return 18;
	for(new i = 0; i <= 46; i++) {
		switch(i) {
			case 0,19,20,21,44,45: continue;
			default: { new name[24]; GetWeaponName(i,name,24); if(strfind(name,WeaponName,true)!=-1) return i; }
		}
	}
	return -1;
}
SendMessageToAdmins(text[]) { for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IsPlayerXAdmin(i)) SendClientMessage(i,blue,text); return 1; }
SendCommandMessageToAdmins(playerid,command[]) { if(!Config[DisplayCommandMessage]) return 1; new string[256],name[24]; GetPlayerName(playerid,name,24); format(string,256,"Admin Chat: %s has used the command \'/%s\'.",name,command); return SendMessageToAdmins(string); }
GetConnectedPlayers() { new Players; for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) Players++; return Players; }
IsPlayerXAdmin(playerid) return (Variables[playerid][LoggedIn] && Variables[playerid][Level]) ? true:false;
IsSkinValid(SkinID) return ((SkinID == 0)||(SkinID == 7)||(SkinID >= 9 && SkinID <= 41)||(SkinID >= 43 && SkinID <= 64)||(SkinID >= 66 && SkinID <= 73)||(SkinID >= 75 && SkinID <= 85)||(SkinID >= 87 && SkinID <= 118)||(SkinID >= 120 && SkinID <= 148)||(SkinID >= 150 && SkinID <= 207)||(SkinID >= 209 && SkinID <= 264)||(SkinID >= 274 && SkinID <= 288)||(SkinID >= 290 && SkinID <= 299)) ? true:false;
IsNumeric(string[]) { for (new i = 0, j = strlen(string); i < j; i++) if (string[i] > '9' || string[i] < '0') return 0; return 1; }
//========================[WIRE Text Event]=====================================
public OnPlayerText(playerid,text[]) {
	if(text[0] == '#' && IsPlayerXAdmin(playerid)) {
	    new string[256],name[24]; GetPlayerName(playerid,name,24); format(string,256,"Admin %s: %s",name,text[1]); SendMessageToAdmins(string);
	    return 0;
	}
	if(Variables[playerid][Wired]) {
	    Variables[playerid][WiredWarnings]--;
	    new string[256],Name[24];
	    if(Variables[playerid][WiredWarnings]) {
	        format(string,256,"You have been wired thus preventing you from talking. [Warnings: %d/%d]",Variables[playerid][WiredWarnings],Config[WiredWarnings]);
			SendClientMessage(playerid,white,string); return 0;
		}
		else {
		    GetPlayerName(playerid,Name,24); format(string,256,"%s has been kicked from the server. [REASON: Wired]",Name);
		    SendClientMessageToAll(yellow,string); SetUserInt(playerid,"Wired",0);
		    Kick(playerid); return 0;
		}
	}
	return 1;
}
//==============================================================================
public OnPlayerExitVehicle(playerid, vehicleid) {
	if(VehicleLockData[vehicleid]) { VehicleLockData[vehicleid] = false; for(new i = 0; i < MAX_PLAYERS; i++) SetVehicleParamsForPlayer(vehicleid,i,false,false); }
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && Spec[i][SpectateID] == playerid  && Spec[i][Spectating]) { TogglePlayerSpectating(i,false); SetPlayerInterior(i,GetPlayerInterior(playerid)); TogglePlayerSpectating(i,true); PlayerSpectatePlayer(i,playerid); }
	return 1;
}
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger){
	#pragma unused ispassenger
    for(new i = 0; i < MAX_PLAYERS; i++) if(Spec[i][SpectateID] == playerid && Spec[i][Spectating]) { TogglePlayerSpectating(i,false); SetPlayerInterior(i,GetPlayerInterior(playerid)); TogglePlayerSpectating(i,true); PlayerSpectateVehicle(i,vehicleid); }
	return 1;
}

//==============================================================================
public OnPlayerSelectedMenuRow(playerid, row) {
  	new Menu:Current = GetPlayerMenu(playerid);
  	if(Current == GiveMe) {
		new car[20],Float:X,Float:Y,Float:Z,Float:Angle,id,carid;
		GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
	    switch(row) {
	      case 0: car = "Infernus", id = 411;
	      case 1: car = "NRG500", id = 522;
	      case 2: car = "Monster Truck", id = 444;
	      case 3: car = "Packer", id = 443;
	      case 4: car = "RC Car", id = 441;
	      case 5: car = "Rancher", id = 489;
	      case 6: car = "Roadtrain", id = 515;
	      case 7: car = "Dumper", id = 406;
	      case 8: car = "Sultan", id = 560;
	      case 9: car = "Maverick", id = 487;
	      case 10: car = "Vortex", id = 539;
	      case 11: car = "Hydra", id = 520;
	    }
	    SendCommandMessageToAdmins(playerid,"GIVEME");
	    new string[256]; format(string,sizeof(string),"You have selected \'%s\'.",car); SendClientMessage(playerid,yellow,string);
		carid = CreateVehicle(id,X,Y,Z,Angle,-1,-1,50000);
		PutPlayerInVehicle(playerid,carid,0);
		TogglePlayerControllable(playerid,true);
		if(GetPlayerInterior(playerid)) LinkVehicleToInterior(carid,GetPlayerInterior(playerid));
		SetVehicleVirtualWorld(carid,GetPlayerVirtualWorld(playerid));
	}
	if(Current == GiveCar) {
		new Component[20],id,carid;
	    switch(row) {
	      case 0: Component = "Nitrous x10", id = 1010;
	      case 1: Component = "Hydraulics", id = 1087;
	      case 2: Component = "Offroad Wheels", id = 1025;
	      case 3: Component = "Wire Wheels", id = 1081;
	    }
	    SendCommandMessageToAdmins(playerid,"GIVECAR");
	    new string[256]; format(string,sizeof(string),"You have selected \'%s\'.",Component); SendClientMessage(playerid,yellow,string);
        TogglePlayerControllable(playerid,true);
		carid = GetPlayerVehicleID(playerid); AddVehicleComponent(carid,id);
	}
	return 1;
}
//==============================================================================
public OnPlayerExitedMenu(playerid) {
    new Menu:Current = GetPlayerMenu(playerid);
    HideMenuForPlayer(Current,playerid);
    return TogglePlayerControllable(playerid,true);
}
//==============================================================================
public PingKick() {
	if(Config[MaxPing]) {
	    for(new i = 0,string[256],name[24]; i < MAX_PLAYERS; i++)
	    if(IsPlayerConnected(i) && (GetPlayerPing(i) > Config[MaxPing])) {
	        if(!IsPlayerXAdmin(i) || (IsPlayerXAdmin(i) && !Config[AdminImmunity])) {
	        	GetPlayerName(i,name,24); format(string,256,"\"%s\" has been kicked from the server. (Reason: High Ping || Max Allowed: %d)",name,Config[MaxPing]);
	        	SendClientMessageToAll(yellow,string); Kick(i);
	        }
	    }
	}
}
//==========================[Custom Callbacks]==================================
public OnPlayerRegister(playerid) {

	return 1;
}
public OnPlayerLogin(playerid) {

	return 1;
}
public OnPlayerLogout(playerid) {

	return 1;
}
