/********************************************
*       Programmer: Xtreme                  *
*       Include: XtremeAdmin.inc            *
*       Purpose: Xtreme Admin Functions     *
********************************************/

#if defined _XtremeAdmin_included
  #endinput
#endif
#define _XtremeAdmin_included
#pragma library XtremeAdmin

#include "xadmin/DFiles.inc"
#include "xadmin/XRegistration.inc"
#include <a_samp>
#define GetStringArg(%1,%2) for(new x = 0; getarg(%1,x) != '\0'; x++) %2[x] = getarg(%1,x)
#define blue 0x00FFFFAA
#define red 0xFF0000AA

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
	PingSecondUpdate,                   // The amount of seconds to check pings.
	ForbidData,                         // What action to commit if a player joins with a forbidden name (0 = Nothing, 1 = Kick, 2 = Ban)
    DisableJailCommands,                // Disable player commands whilst they are jailed?
    WireWithPM,                         // Wire the player if they are wired if they send a PM?
    ExposePMS                           // Send the PMs with sender and reciever on a PM send?
};
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
stock Variables[MAX_PLAYERS][PlayerData], Config[ConfigData], Spec[MAX_PLAYERS][SpectateData], ForbidNames[100][256];
//=====================[DYNAMIC CONFIGURATION SYSTEM]===========================
stock CreateLevelConfig({Float,_}:...) {
	new tmp[256],file[256]; file = "/xadmin/Configuration/Variables.ini";
	if(dini_Exists(file)) dini_Remove(file); dini_Create(file); dini_IntSet(file,"Count",0);
	new Count = dini_Int(file,"Count"), string[256];
	for(new i = 0; i < numargs(); i++) { ClearString(256,string); GetStringArg(i,string); valstr(tmp,Count); dini_Set(file,tmp,string); Count++; dini_IntSet(file,"Count",Count); }
}
stock CreateCommandConfig({Float,_}:...) {
	new i = 0,key[256],value,file[256]; file = "/xadmin/Configuration/Commands.ini";
	if(!dini_Exists(file)) dini_Create(file);
	while(i < numargs()) { ClearString(256,key); GetStringArg(i,key); value = getarg(i+1,0); if(!dini_Isset(file,key)) dini_IntSet(file,key,value); i += 2; }
}
stock CreateCommandConfigEx({Float,_}:...) {
	new i = 0,key[256],value,file[256]; file = "/xadmin/Configuration/Commands.ini";
	while(i < numargs()) { ClearString(256,key); GetStringArg(i,key); value = getarg(i+1,0); if(!dini_Isset(file,key)) dini_IntSet(file,key,value); i += 2; }
}
stock CreateUserConfigFile(playerid) {
	new file[256],name[24],config[256],tmp[256],tmp2[256]; config = "/xadmin/Configuration/Variables.ini"; GetPlayerName(playerid,name,24); format(file,256,"/xadmin/Users/%s.ini",udb_encode(name));
	if(!dini_Exists(file)) dini_Create(file); if(!dini_Exists(config)) dini_Create(config);
	for(new i = 0; i < dini_Int(config,"Count"); i++) { valstr(tmp,i); tmp2 = dini_Get(config,tmp); if(!dini_Isset(file,tmp2)) dini_IntSet(file,tmp2,0); }
}
stock GetPlayerFileVar(playerid,var[]) {
	new file[256]; file = GetPlayerFile(playerid);
	return (!dini_Exists(file)) ? 0 : dini_Int(file,var);
}
stock CreateForbiddenNames({Float,_}:...) {
	new Temp[256],i; while(i < numargs()) { GetStringArg(i,Temp); ForbidNames[i] = Temp; printf(ForbidNames[i]); i += 1; }
}
stock SetUserString(playerid,var[],value[]) { new file[256]; file = GetPlayerFile(playerid); if(!dini_Exists(file)) dini_Create(file); dini_Set(file,var,value); }
stock SetUserInt(playerid,var[],value) { new file[256]; file = GetPlayerFile(playerid); if(!dini_Exists(file)) dini_Create(file); dini_IntSet(file,var,value); return 1; }
stock SetConfigInt(var[],value) {
	new file[256]; file = "/xadmin/Configuration/Variables.ini";
	if(!dini_Isset(file,var)) return 0;
	dini_IntSet(file,var,value);
	return 1;
}
stock UpdateConfigurationVariables() {
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
    if(!dini_Isset(ConfigFile,"ForbidData")) dini_IntSet(ConfigFile,"ForbidData",1);
    if(!dini_Isset(ConfigFile,"DisableJailCommands")) dini_IntSet(ConfigFile,"DisableJailCommands",0);
    if(!dini_Isset(ConfigFile,"WireWithPM")) dini_IntSet(ConfigFile,"WireWithPM",0);
    if(!dini_Isset(ConfigFile,"ExposePMS")) dini_IntSet(ConfigFile,"ExposePMS",0);
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
    Config[ForbidData] = dini_Int(ConfigFile,"ForbidData");
    Config[DisableJailCommands] = dini_Int(ConfigFile,"DisableJailCommands");
    Config[WireWithPM] = dini_Int(ConfigFile,"WireWithPM");
    Config[ExposePMS] = dini_Int(ConfigFile,"ExposePMS");
}
//==========================[CUSTOM FUNCTIONS]==================================
stock ClearString(MaxLength,string[]) for(new i = 0; i < MaxLength; i++) format(string[i],1,"");
stock IsPlayerCommandLevel(playerid,command[]) {
	if(!dini_Isset("/xadmin/Configuration/Commands.ini",command)) return false;
	return (IsPlayerConnected(playerid) && Variables[playerid][LoggedIn] && (Variables[playerid][Level] >= dini_Int("/xadmin/Configuration/Commands.ini",command) || dini_Int("/xadmin/Configuration/Commands.ini",command) == 0)) ? true : false;
}
stock GetPlayerFile(playerid) { new string[256], PlayerName[24]; GetPlayerName(playerid,PlayerName,24); format(string,256,"/xadmin/Users/%s.ini",udb_encode(PlayerName)); return string; }
stock SendLevelErrorMessage(playerid,command[]) { new string[256]; format(string,256,"ERROR: You must be administrator level %d to use this command.",dini_Int("/xadmin/Configuration/Commands.ini",command)); return SendClientMessage(playerid,red,string); }
stock ReturnPlayerID(PlayerName[]) {
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) { new name[24]; GetPlayerName(i,name,24); if(strfind(name,PlayerName,true)!=-1) return i; }
	return INVALID_PLAYER_ID;
}
stock ReturnWeaponID(WeaponName[]) {
	if(strfind("molotov",WeaponName,true)!=-1) return 18;
	for(new i = 0; i <= 46; i++) {
		switch(i) {
			case 0,19,20,21,44,45: continue;
			default: { new name[24]; GetWeaponName(i,name,24); if(strfind(name,WeaponName,true)!=-1) return i; }
		}
	}
	return -1;
}
stock SendMessageToAdmins(text[]) { for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IsPlayerXAdmin(i)) SendClientMessage(i,blue,text); return 1; }
stock SendCommandMessageToAdmins(playerid,command[]) { if(!Config[DisplayCommandMessage]) return 1; new string[256],name[24]; GetPlayerName(playerid,name,24); format(string,256,"Admin Chat: %s has used the command \'/%s\'.",name,command); return SendMessageToAdmins(string); }
stock GetConnectedPlayers() { new Players; for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) Players++; return Players; }
stock IsPlayerXAdmin(playerid) return (Variables[playerid][LoggedIn] && Variables[playerid][Level]) ? true:false;
stock IsSkinValid(SkinID) return ((SkinID >= 0 && SkinID <= 1)||(SkinID == 2)||(SkinID == 7)||(SkinID >= 9 && SkinID <= 41)||(SkinID >= 43 && SkinID <= 85)||(SkinID >=87 && SkinID <= 118)||(SkinID >= 120 && SkinID <= 148)||(SkinID >= 150 && SkinID <= 207)||(SkinID >= 209 && SkinID <= 272)||(SkinID >= 274 && SkinID <= 288)||(SkinID >= 290 && SkinID <= 299)) ? true:false;
stock IsNumeric(string[]) { for (new i = 0, j = strlen(string); i < j; i++) if (string[i] > '9' || string[i] < '0') return 0; return 1; }
