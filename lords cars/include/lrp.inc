//   _____________________________________________________________
//  |_/_/_[lrp.inc]/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/[=][-][x]_|
//  |								  |
//  |    This inc file includes all of the files listed below.    |
//  |	 The main purpose of this is to remove the clutter from   |
//  |	 Your server files.					  |
//  |								  |
//  |	 Space saved by using this file instead of all files used |
//  |	 in the godfather. ~ 40kb(13 files)			  |
//  | ----------------------------------------------------------- |
//  |								  |
//  | ~ © Copyright 2005-2006, SA:MP Team <a_samp.inc>            |
//  |								  |
//  | ~ © Copyright 2005-2006, SA:MP Team <a_players.inc>         |
//  |								  |
//  | ~ © Copyright 2005-2006, SA:MP Team <a_vehicles.inc>        |
//  |								  |
//  | ~ © Copyright 2005-2006, SA:MP Team <a_objects.inc>         |
//  |								  |
//  | ~ © Copyright 2005-2006, SA:MP Team <a_sampdb.inc>          |
//  |								  |
//  | ~ © Copyright 1998-2005, ITB CompuPhase <core.inc>          |
//  |								  |
//  | ~ © Copyright 2001-2005, ITB CompuPhase <time.inc>          |
//  |								  |
//  | ~ © Copyright 2004-2005, ITB CompuPhase <file.inc>	  |
//  |								  |
//  | ~ © Copyright 2005, ITB CompuPhase <string.inc>		  |
//  |								  |
//  | ~ © Copyright 2005, ITB CompuPhase <datagram.inc>		  |
//  |								  |
//  | ~ © Copyright 1999, Artran, Inc. <float.inc>		  |
//  |   Written by Greg Garner (gmg@artran.com)			  |
//  |   Modified in March 2001 to include user defined		  |
//  |   operators for the floating point functions.		  |
//  |								  |
//  | ~ Also Listed						  |
//  |	~ <morphic.inc>	(Tratulla)				  |
//  |	~ <utils.inc>	(Tratulla)				  |
//  |	~ <lrp_colors.inc> (KineticNRG)				  |	
//  |	~ <components.inc> (KineticNRG)				  |
//  |								  |
//  |   All files are provided as is (no warranties).		  |
//  |								  |
//  | ~ Compilation by KineticNRG				  |
//  |_____________________________________________________________|
//

//____[lrp_colors.inc]________________________________________________________________________
//[Note] Thanks to Tyler for some color codes.

//----[monochrome]
#define color_white 0xffffff00
#define color_grey1 0xCCCCCC00
#define color_grey2 0xAAAAAA00
#define color_grey3 0x88888800
#define color_grey4 0x66666600
#define color_grey5 0x44444400
#define color_grey6 0x22222200
#define color_black 0x00000100

//----[chat colors]
#define color_chat1 0xF9F9F900
#define color_chat2 0xF3F3F300
#define color_chat3 0xDCDCDC00
#define color_chat4 0xD9D9D900
#define color_chat5 0xD3D3D300

//----[spectrum colors]
#define color_pred 0xff666600
#define color_lred 0xFF000000
#define color_red 0xCC000000
#define color_dred 0xAA000000

#define color_porange 0xfda57000
#define color_lorange 0xFF944D00
#define color_orange 0xFF660000
#define color_dorange 0xE65C0000

#define color_pyellow 0xffffcc00
#define color_lyellow 0xFFFF9900
#define color_yellow 0xFFFF0000
#define color_dyellow 0xE6E60000

#define color_pgreen 0xaefd9200
#define color_lgreen 0x00FF0000
#define color_green 0x00CC0000
#define color_dgreen 0x00AA0000

#define color_pblue 0xbfe9fe00
#define color_lblue 0x0000FF00
#define color_blue 0x0000CC00
#define color_dblue 0x0000AA00

#define color_ppurple 0xc8c2ff00
#define color_lpurple 0xCC00FF00
#define color_purple 0x9900CC00
#define color_dpurple 0x66009900

#define color_ppink 0xffdede00
#define color_lpink 0xFFCCCC00
#define color_pink 0xFF66FF00
#define color_dpink 0xFF33CC00

#define color_pbrown 0xe3cbad00
#define color_lbrown 0x66350000
#define color_brown 0x4D280000
#define color_dbrown 0x4D260000

//----[wanted colors]
#define color_lwanted 0xff000055
#define color_wanted 0xCC000099
#define color_dwanted 0xAA0000CC

//----[gang colors]
#define color_1  0xCCE7FF00//blue
#define color_2  0xCCFFCC00//green
#define color_3  0xFFC2FF00//pink
#define color_4  0xE0C2FF00//purple
#define color_5  0xFFFFC200//yellow
#define color_6  0xC2FFE000//seafoam
#define color_7  0xFFE0C200//peach
#define color_8  0xFFC28500//orange
#define color_9  0xCCCCCC00//grey


//   _____________________________________________________________
//  |_/_/_[Components.inc]_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/[=][-][x]_|
//  |   This inc file includes variables to make adding car       |
//  |   components easier.                                        |
//  |								  |
//  |	Credits to sareallife.org for thier SAMP wiki. All	  |
//  |	component ids came from their wiki.			  |
//  |	Anything not listed was not in the wiki.		  |
//  |								  |
//  |	Car Components Listed					  |
//  |	 ~Front Bumper						  |
//  |	 ~Rear Bumper						  |
//  |	 ~Front Bullbars					  |
//  |	 ~Rear Bullbars						  |
//  |	 ~Side Skirts						  |
//  |	 ~Hood Scoop						  |
//  |	 ~Hood Vents						  |
//  |	 ~Roof (scoop and top)					  |
//  |	 ~Spoiler						  |
//  |	 ~Wheels						  |
//  |	 ~Exhaust						  |
//  |	 ~Lights						  |
//  |	 ~Stereo						  |
//  |	 ~Nitro							  |
//  |    ~Hydros                         			  |
//  |								  |
//  |								  |
//  | ~ Created by KineticNRG					  |
//  |_____________________________________________________________|
//

//____[Front Bumpers]_________________________________________________________________________
#define fbumper_chromer_slamvan 	1117
#define fbumper_chromer_broadway	1174
#define fbumper_chromer_remington	1179
#define fbumper_chromer_blade		1182
#define fbumper_chromer_savanna		1189
#define fbumper_chromer_tornado		1191

#define fbumper_slamin_broadway		1175
#define fbumper_slamin_remington	1185
#define fbumper_slamin_blade		1181
#define fbumper_slamin_savanna		1188
#define fbumper_slamin_tornado		1190

#define fbumper_xflow_flash 		1152
#define fbumper_xflow_stratum 		1157
#define fbumper_xflow_jester		1173
#define fbumper_xflow_uranus		1165
#define fbumper_xflow_sultan		1170
#define fbumper_xflow_elegy		1172

#define fbumper_alien_flash 		1153
#define fbumper_alien_stratum 		1155
#define fbumper_alien_jester		1160
#define fbumper_alien_uranus		1166
#define fbumper_alien_sultan		1169
#define fbumper_alien_elegy		1171


//____[Rear Bumpers]__________________________________________________________________________
#define rbumper_chromer_broadway	1176
#define rbumper_chromer_remington	1180
#define rbumper_chromer_blade		1184
#define rbumper_chromer_savanna		1187
#define rbumper_chromer_tornado		1192

#define rbumper_slamin_broadway		1177
#define rbumper_slamin_remington	1178
#define rbumper_slamin_blade		1183
#define rbumper_slamin_savanna		1186
#define rbumper_slamin_tornado		1193

#define rbumper_xflow_flash		1151
#define rbumper_xflow_stratum		1156
#define rbumper_xflow_jester		1161
#define rbumper_xflow_uranus		1167
#define rbumper_xflow_sultan		1140
#define rbumper_xflow_elegy		1148

#define rbumper_alien_flash		1150
#define rbumper_alien_stratum		1154
#define rbumper_alien_jester		1159
#define rbumper_alien_uranus		1168
#define rbumper_alien_sultan		1141
#define rbumper_alien_elegy		1149


//____[Front Bumpers]_________________________________________________________________________
#define fbullbar_chromer_slamvan	1115
#define fbullbar_chromer_remington	1100

#define fbullbar_slamin_slamvan		1116

#define fbullbar_bars_remington	1123
#define fbullbar_lights_remington	1125


//____[Rear Bumpers]__________________________________________________________________________
#define rbullbar_chromer_slamvan	1109

#define rbullbar_slamin_slamvan		1110


//____[Sideskirts]____________________________________________________________________________
//--[chrome]
//left
#define lskirt_chromer_slamvan		1120
#define lskirt_chromer_broadway		1099
#define lskirt_chromer_remington	1101
#define lskirt_chromer_blade		1107
#define lskirt_chromer_savanna		1102
#define lskirt_chromer_tornado		1137
//right
#define rskirt_chromer_slamvan		1118
#define rskirt_chromer_broadway		1042
#define rskirt_chromer_remington	1122
#define rskirt_chromer_blade		1108
#define rskirt_chromer_savanna		1133
#define rskirt_chromer_tornado		1134

//--[slamin]
//left
#define lskirt_slamin_slamvan		1121 //wheel covers
#define lskirt_slamin_remington		1124 //chrome arches
//right
#define rskirt_slamin_slamvan		1119 //wheel covers
#define rskirt_slamin_remington		1106 //chrome arches

//--[xflow]
//left
#define lskirt_xflow_flash		1048
#define lskirt_xflow_stratum		1057
#define lskirt_xflow_jester		1070
#define lskirt_xflow_uranus		1093
#define lskirt_xflow_sultan		1030
#define lskirt_xflow_elegy		1039
//right
#define rskirt_xflow_flash		1052
#define rskirt_xflow_stratum		1063
#define rskirt_xflow_jester		1072
#define rskirt_xflow_uranus		1095
#define rskirt_xflow_sultan		1031
#define rskirt_xflow_elegy		1041

//--[alien]
//left
#define lskirt_alien_flash		1047
#define lskirt_alien_stratum		1056
#define lskirt_alien_jester		1069
#define lskirt_alien_uranus		1090
#define lskirt_alien_sultan		1027
#define lskirt_alien_elegy		1040
//right
#define rskirt_alien_flash		1051
#define rskirt_alien_stratum		1062
#define rskirt_alien_jester		1071
#define rskirt_alien_uranus		1094
#define rskirt_alien_sultan		1026
#define rskirt_alien_elegy		1036

//--[transfender]
#define lskirt_transfender		1017
#define rskirt_transfender		1007


//____[Hood Scoop]____________________________________________________________________________
#define hood_champ			1004
#define hood_fury			1005
#define hood_race			1011
#define hood_worx			1012


//____[Hood Vents]____________________________________________________________________________
#define lhood_oval			1142
#define rhood_oval			1143
#define lhood_square			1144
#define rhood_square			1145


//____[Roof]__________________________________________________________________________________
#define roof_transfender		1006

#define roof_softtop_blade		1103
#define roof_softtop_savanna		1131

#define roof_hardtop_blade		1128
#define roof_hardtop_savanna		1130

#define roof_alien_flash		1054
#define roof_alien_stratum		1055
#define roof_alien_jester		1067
#define roof_alien_uranus		1088
#define roof_alien_sultan		1032
#define roof_alien_elegy		1038

#define roof_xflow_flash		1053
#define roof_xflow_stratum		1061
#define roof_xflow_jester		1068
#define roof_xflow_uranus		1091
#define roof_xflow_sultan		1033
#define roof_xflow_elegy		1035


//____[Spoiler]_______________________________________________________________________________
#define spoiler_pro			1000
#define spoiler_win			1001
#define spoiler_drag			1002
#define spoiler_alpha			1003
#define spoiler_champ			1014
#define spoiler_race			1015
#define spoiler_worx			1016
#define spoiler_fury			1023

#define spoiler_xflow_flash		1050
#define spoiler_xflow_stratum		1060
#define spoiler_xflow_jester		1158
#define spoiler_xflow_uranus		1163
#define spoiler_xflow_sultan		1139
#define spoiler_xflow_elegy		1146

#define spoiler_alien_flash		1049
#define spoiler_alien_stratum		1058
#define spoiler_alien_jester		1162
#define spoiler_alien_uranus		1164
#define spoiler_alien_sultan		1138
#define spoiler_alien_elegy		1147


//____[Wheels]________________________________________________________________________________
#define wheels_offroad			1025
#define wheels_shadow			1073
#define wheels_mega			1074
#define wheels_rimshine			1075
#define wheels_wires			1076
#define wheels_classic			1077
#define wheels_twist			1078
#define wheels_cutter			1079
#define wheels_switch			1080
#define wheels_grove			1081
#define wheels_import			1082
#define wheels_dollar			1083
#define wheels_trance			1084
#define wheels_atomic			1085
#define wheels_ahab			1096
#define wheels_virtual			1097
#define wheels_access			1098


//____[Exhaust]_______________________________________________________________________________
#define exhaust_upsweep 		1018
#define exhaust_twin			1019
#define exhaust_large			1020
#define exhaust_medium			1021
#define exhaust_small			1022

#define exhaust_chromer_slamvan		1113
#define exhaust_chromer_broadway	1044
#define exhaust_chromer_remington	1126
#define exhaust_chromer_blade		1104
#define exhaust_chromer_savanna		1129
#define exhaust_chromer_tornado		1136

#define exhaust_slamin_slamvan		1114
#define exhaust_slamin_broadway		1043
#define exhaust_slamin_remington	1127
#define exhaust_slamin_blade		1105
#define exhaust_slamin_savanna		1132
#define exhaust_slamin_tornado		1135

#define exhaust_xflow_flash		1045
#define exhaust_xflow_stratum		1059
#define exhaust_xflow_jester		1066
#define exhaust_xflow_uranus		1089
#define exhaust_xflow_sultan		1029
#define exhaust_xflow_elegy		1037

#define exhaust_alien_flash		1046
#define exhaust_alien_stratum		1064
#define exhaust_alien_jester		1065
#define exhaust_alien_uranus		1092
#define exhaust_alien_sultan		1028
#define exhaust_alien_elegy		1034


//____[Lights]________________________________________________________________________________
#define lights_square			1024
#define lights_round			1013


//____[Stereo]________________________________________________________________________________
#define stereo_bassboost		1086


//____[Nitro]_________________________________________________________________________________
#define nitro_2				1009
#define nitro_5				1008
#define nitro_10			1010

//____[Hydros]________________________________________________________________________________
#define hydralics           1087


//____[Added by Kinetic]______________________________________________________________________

#define MAX_STRING 512

#define job_none		0
#define job_police		1
#define job_mechanic		2
#define job_armsdealer		3
#define job_drugdealer		4
#define job_smuggler		5

//_____[a_samp.inc]___________________________________________________________________________
#if defined _samp_included
	#endinput
#endif
#define _samp_included
#pragma library samp

#pragma tabsize 4
// Ignores warning 217 for properly indented PAWNO code
// It's tab size is 4 and often uses 4 spaces instead, PAWNCC's is 8

// --------------------------------------------------
// Natives
// --------------------------------------------------

// Util

native print(const string[]);
native printf(const format[], {Float,_}:...);
native format(output[], len, const format[], {Float,_}:...);
native SendClientMessage(playerid, color, const message[]);
native SendClientMessageToAll(color, const message[]);
native SendPlayerMessageToPlayer(playerid, senderid, const message[]);
native SendPlayerMessageToAll(senderid, const message[]);
native SendDeathMessage(killer,killee,weapon);
native GameTextForAll(const string[],time,style);
native GameTextForPlayer(playerid,const string[],time,style);
native SetTimer(funcname[], interval, repeating);
native SetTimerEx(funcname[], interval, repeating, const format[], {Float,_}:...);
native KillTimer(timerid);
native GetTickCount();
native GetMaxPlayers();
native LimitGlobalChatRadius(Float:chat_radius);
native CallRemoteFunction(const function[], const format[], {Float,_}:...);
native CallLocalFunction(const function[], const format[], {Float,_}:...);
native Float:asin(Float:value);
native Float:acos(Float:value);
native Float:atan(Float:value);
native Float:atan2(Float:x, Float:y);

// Game
native SetGameModeText(const string[]);
native SetTeamCount(count);
native AddPlayerClass(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);
native AddPlayerClassEx(teamid, modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);
native AddStaticVehicle(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2);
native AddStaticVehicleEx(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2, respawn_delay);
native AddStaticPickup(model,type,Float:X,Float:Y,Float:Z);
native CreatePickup(model, type, Float:X, Float:Y, Float:Z);
native DestroyPickup(pickup);
native ShowNameTags(show);
native ShowPlayerMarkers(show);
native GameModeExit();
native SetWorldTime(hour);
native GetWeaponName(weaponid, const weapon[], len);
native EnableTirePopping(enable);
native AllowInteriorWeapons(allow);
native SetWeather(weatherid);
native SetGravity(Float:gravity);
native AllowAdminTeleport(allow);
native SetDeathDropAmount(amount);
native CreateExplosion(Float:X, Float:Y, Float:Z, type, Float:Radius);
native SetDisabledWeapons(...);
native EnableZoneNames(enable);
native UsePlayerPedAnims();		// Will cause the players to use CJ running/walking animations
native DisableInteriorEnterExits();  // will disable all interior enter/exits in the game.
native SetNameTagDrawDistance(Float:distance); // Distance at which nametags will start rendering on the client.

// Admin
native IsPlayerAdmin(playerid);
native Kick(playerid);
native Ban(playerid);
native BanEx(playerid, const reason[]);
native SendRconCommand(command[]);
native GetServerVarAsString(const varname[], buffer[], len);
native GetServerVarAsInt(const varname[]);
native GetServerVarAsBool(const varname[]);

// Menu
native Menu:CreateMenu(const title[], columns, Float:x, Float:y, Float:col1width, Float:col2width = 0.0);
native DestroyMenu(Menu:menuid);
native AddMenuItem(Menu:menuid, column, const menutext[]);
native SetMenuColumnHeader(Menu:menuid, column, const columnheader[]);
native ShowMenuForPlayer(Menu:menuid, playerid);
native HideMenuForPlayer(Menu:menuid, playerid);
native IsValidMenu(Menu:menuid);
native DisableMenu(Menu:menuid);
native DisableMenuRow(Menu:menuid, row);
native Menu:GetPlayerMenu(playerid);

// Text Draw
native Text:TextDrawCreate(Float:x, Float:y, text[]);
native TextDrawDestroy(Text:text);
native TextDrawLetterSize(Text:text, Float:x, Float:y);
native TextDrawTextSize(Text:text, Float:x, Float:y);
native TextDrawAlignment(Text:text, alignment);
native TextDrawColor(Text:text, color);
native TextDrawUseBox(Text:text, use);
native TextDrawBoxColor(Text:text, color);
native TextDrawSetShadow(Text:text, size);
native TextDrawSetOutline(Text:text, size);
native TextDrawBackgroundColor(Text:text, color);
native TextDrawFont(Text:text, font);
native TextDrawSetProportional(Text:text, set);
native TextDrawShowForPlayer(playerid, Text:text);
native TextDrawHideForPlayer(playerid, Text:text);
native TextDrawShowForAll(Text:text);
native TextDrawHideForAll(Text:text);
native TextDrawSetString(Text:text, string[]);

// Gang Zones

native GangZoneCreate(Float:minx, Float:miny, Float:maxx, Float:maxy);
native GangZoneDestroy(zone);
native GangZoneShowForPlayer(playerid, zone, color);
native GangZoneShowForAll(zone, color);
native GangZoneHideForPlayer(playerid, zone);
native GangZoneHideForAll(zone);
native GangZoneFlashForPlayer(playerid, zone, flashcolor);
native GangZoneFlashForAll(zone, flashcolor);
native GangZoneStopFlashForPlayer(playerid, zone);
native GangZoneStopFlashForAll(zone);

// --------------------------------------------------
// Defines
// --------------------------------------------------

// States
#define PLAYER_STATE_NONE				(0)
#define PLAYER_STATE_ONFOOT				(1)
#define PLAYER_STATE_DRIVER				(2)
#define PLAYER_STATE_PASSENGER				(3)
#define PLAYER_STATE_EXIT_VEHICLE			(4) // (used internally)
#define PLAYER_STATE_ENTER_VEHICLE_DRIVER		(5) // (used internally)
#define PLAYER_STATE_ENTER_VEHICLE_PASSENGER		(6) // (used internally)
#define PLAYER_STATE_WASTED				(7)
#define PLAYER_STATE_SPAWNED				(8)
#define PLAYER_STATE_SPECTATING				(9)

// Misc
#define MAX_PLAYER_NAME					(24)
#define maxplayername					24
#define MAX_PLAYERS					(200)
#define maxplayers					200
#define MAX_VEHICLES					(700)
#define INVALID_PLAYER_ID				(255)
#define INVALID_VEHICLE_ID				(0xFFFF)
#define NO_TEAM						(255)
#define MAX_OBJECTS					(150)
#define INVALID_OBJECT_ID				(255)
#define MAX_GANG_ZONES					(1024)
#define MAX_TEXT_DRAWS					(1024)
#define MAX_MENUS					(128)
#define INVALID_MENU					(0xFF)
#define INVALID_TEXT_DRAW				(0xFFFF)
#define INVALID_GANG_ZONE				(-1)

// Weapons
#define WEAPON_BRASSKNUCKLE				(1)
#define WEAPON_GOLFCLUB					(2)
#define WEAPON_NITESTICK				(3)
#define WEAPON_KNIFE					(4)
#define WEAPON_BAT					(5)
#define WEAPON_SHOVEL					(6)
#define WEAPON_POOLSTICK				(7)
#define WEAPON_KATANA					(8)
#define WEAPON_CHAINSAW					(9)
#define WEAPON_DILDO					(10)
#define WEAPON_DILDO2					(11)
#define WEAPON_VIBRATOR					(12)
#define WEAPON_VIBRATOR2				(13)
#define WEAPON_FLOWER					(14)
#define WEAPON_CANE					(15)
#define WEAPON_GRENADE					(16)
#define WEAPON_TEARGAS					(17)
#define WEAPON_MOLTOV					(18)
#define WEAPON_COLT45					(22)
#define WEAPON_SILENCED					(23)
#define WEAPON_DEAGLE					(24)
#define WEAPON_SHOTGUN					(25)
#define WEAPON_SAWEDOFF					(26)
#define WEAPON_SHOTGSPA					(27)
#define WEAPON_UZI					(28)
#define WEAPON_MP5					(29)
#define WEAPON_AK47					(30)
#define WEAPON_M4					(31)
#define WEAPON_TEC9					(32)
#define WEAPON_RIFLE					(33)
#define WEAPON_SNIPER					(34)
#define WEAPON_ROCKETLAUNCHER				(35)
#define WEAPON_HEATSEEKER				(36)
#define WEAPON_FLAMETHROWER				(37)
#define WEAPON_MINIGUN					(38)
#define WEAPON_SATCHEL					(39)
#define WEAPON_BOMB					(40)
#define WEAPON_SPRAYCAN					(41)
#define WEAPON_FIREEXTINGUISHER				(42)
#define WEAPON_CAMERA					(43)
#define WEAPON_PARACHUTE				(46)
#define WEAPON_VEHICLE					(49)
#define WEAPON_DROWN					(53)
#define WEAPON_COLLISION				(54)

// Keys
#define KEY_ACTION					(1)
#define KEY_CROUCH					(2)
#define KEY_FIRE					(4)
#define KEY_SPRINT					(8)
#define KEY_SECONDARY_ATTACK				(16)
#define KEY_JUMP					(32)
#define KEY_LOOK_RIGHT					(64)
#define KEY_HANDBRAKE					(128)
#define KEY_LOOK_LEFT					(256)
#define KEY_SUBMISSION					(512)
#define KEY_LOOK_BEHIND					(512)
#define KEY_WALK					(1024)
#define KEY_ANALOG_UP					(2048)
#define KEY_ANALOG_DOWN					(4096)
#define KEY_ANALOG_RIGHT				(16384)
#define KEY_ANALOG_LEFT					(8192)

#define KEY_UP						(65408)
#define KEY_DOWN					(128)
#define KEY_LEFT					(65408)
#define KEY_RIGHT					(128)

// --------------------------------------------------
// Forwards (Callback declarations)
// --------------------------------------------------

forward OnGameModeInit();
forward OnGameModeExit();
forward OnFilterScriptInit();
forward OnFilterScriptExit();
forward OnPlayerConnect(playerid);
forward OnPlayerDisconnect(playerid, reason);
forward OnPlayerSpawn(playerid);
forward OnPlayerDeath(playerid, killerid, reason);
forward OnVehicleSpawn(vehicleid);
forward OnVehicleDeath(vehicleid, killerid);
forward OnPlayerText(playerid, text[]);
forward OnPlayerCommandText(playerid, cmdtext[]);
forward OnPlayerInfoChange(playerid);
forward OnPlayerRequestClass(playerid, classid);
forward OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
forward OnPlayerExitVehicle(playerid, vehicleid);
forward OnPlayerStateChange(playerid, newstate, oldstate);
forward OnPlayerEnterCheckpoint(playerid);
forward OnPlayerLeaveCheckpoint(playerid);
forward OnPlayerEnterRaceCheckpoint(playerid);
forward OnPlayerLeaveRaceCheckpoint(playerid);
forward OnRconCommand(cmd[]);
forward OnPlayerPrivmsg(playerid, recieverid, text[]);
forward OnPlayerRequestSpawn(playerid);
forward OnObjectMoved(objectid);
forward OnPlayerObjectMoved(playerid, objectid);
forward OnPlayerPickUpPickup(playerid, pickupid);
forward OnVehicleMod(vehicleid, componentid);
forward OnVehiclePaintjob(vehicleid, paintjobid);
forward OnVehicleRespray(vehicleid, color1, color2);
forward OnPlayerSelectedMenuRow(playerid, row);
forward OnPlayerExitedMenu(playerid);
forward OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid);
forward OnPlayerKeyStateChange(playerid, newkeys, oldkeys);




//____[a_players.inc]_________________________________________________________________________
#if defined _players_included
	#endinput
#endif
#define _players_included
#pragma library players

#define SPECIAL_ACTION_NONE			0
#define SPECIAL_ACTION_USEJETPACK		2
#define SPECIAL_ACTION_DANCE1			5
#define SPECIAL_ACTION_DANCE2			6
#define SPECIAL_ACTION_DANCE3			7
#define SPECIAL_ACTION_DANCE4			8
#define SPECIAL_ACTION_HANDSUP			10
#define SPECIAL_ACTION_USECELLPHONE		11
#define SPECIAL_ACTION_SITTING			12
#define SPECIAL_ACTION_STOPUSECELLPHONE 	13

// Player
native SetSpawnInfo(playerid, team, skin, Float:x, Float:y, Float:z, Float:rotation, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);
native SpawnPlayer(playerid);

// Player info
native SetPlayerPos(playerid, Float:x, Float:y, Float:z);
native SetPlayerPosFindZ(playerid, Float:x, Float:y, Float:z);
native GetPlayerPos(playerid, &Float:x, &Float:y, &Float:z);
native SetPlayerFacingAngle(playerid,Float:ang);
native GetPlayerFacingAngle(playerid,&Float:ang);
native SetPlayerInterior(playerid,interiorid);
native GetPlayerInterior(playerid);
native SetPlayerHealth(playerid, Float:health);
native GetPlayerHealth(playerid, &Float:health);
native SetPlayerArmour(playerid, Float:armour);
native GetPlayerArmour(playerid, &Float:armour);
native SetPlayerAmmo(playerid, weaponslot, ammo);
native GetPlayerAmmo(playerid);
native SetPlayerTeam(playerid, teamid);
native GetPlayerTeam(playerid);
native SetPlayerScore(playerid,score);
native GetPlayerScore(playerid);
native SetPlayerColor(playerid,color);
native GetPlayerColor(playerid);
native SetPlayerSkin(playerid, skinid);
native GetPlayerSkin(playerid);
native GivePlayerWeapon(playerid, weaponid, ammo);
native ResetPlayerWeapons(playerid);
native GetPlayerWeaponData(playerid, slot, &weapons, &ammo);
native GivePlayerMoney(playerid,money);
native ResetPlayerMoney(playerid);
native SetPlayerName(playerid, const name[]);
native GetPlayerMoney(playerid);
native GetPlayerState(playerid);
native GetPlayerIp(playerid, name[], len);
native GetPlayerPing(playerid);
native GetPlayerWeapon(playerid);
native GetPlayerKeys(playerid, &keys, &updown, &leftright);
native GetPlayerName(playerid, const name[], len);
native SetPlayerTime(playerid, hour, minute);
native GetPlayerTime(playerid, &hour, &minute);
native TogglePlayerClock(playerid, toggle);
native SetPlayerWeather(playerid, weather);
native SetPlayerDisabledWeapons(playerid, ...);
native ForceClassSelection(playerid);
native SetPlayerWantedLevel(playerid, level);
native GetPlayerWantedLevel(playerid);

// Player controls
native PutPlayerInVehicle(playerid, vehicleid, seatid);
native GetPlayerVehicleID(playerid);
native RemovePlayerFromVehicle(playerid);
native TogglePlayerControllable(playerid, toggle);
native PlayerPlaySound(playerid, soundid, Float:x, Float:y, Float:z);
native ApplyAnimation(playerid, animlib[], animname[], Float:fS, opt1, opt2, opt3, opt4, opt5);
native ClearAnimations(playerid);
native GetPlayerSpecialAction(playerid);
native SetPlayerSpecialAction(playerid,actionid);

// Player map commands
native SetPlayerCheckpoint(playerid, Float:x, Float:y, Float:z, Float:size);
native DisablePlayerCheckpoint(playerid);
native SetPlayerRaceCheckpoint(playerid, type, Float:x, Float:y, Float:z, Float:nextx, Float:nexty, Float:nextz, Float:size);
native DisablePlayerRaceCheckpoint(playerid);
native SetPlayerWorldBounds(playerid,Float:x_max,Float:x_min,Float:y_max,Float:y_min);
native SetPlayerMarkerForPlayer(playerid, showplayerid, color);
native ShowPlayerNameTagForPlayer(playerid, showplayerid, show);
native SetPlayerMapIcon(playerid, iconid, Float:x, Float:y, Float:z, markertype, color);
native RemovePlayerMapIcon(playerid, iconid);
native SetPlayerCameraPos(playerid,Float:x, Float:y, Float:z);
native SetPlayerCameraLookAt(playerid, Float:x, Float:y, Float:z);
native SetCameraBehindPlayer(playerid);
native AllowPlayerTeleport(playerid, allow);

// Player conditionals
native IsPlayerConnected(playerid);
native IsPlayerInVehicle(playerid, vehicleid);
native IsPlayerInAnyVehicle(playerid);
native IsPlayerInCheckpoint(playerid);
native IsPlayerInRaceCheckpoint(playerid);

// Virtual Worlds
native SetPlayerVirtualWorld(playerid, worldid);
native GetPlayerVirtualWorld(playerid);

// Insane Stunts
native EnableStuntBonusForPlayer(playerid, enable);
native EnableStuntBonusForAll(enable);

// Spectating
#define SPECTATE_MODE_NORMAL		1
#define SPECTATE_MODE_FIXED		2
#define SPECTATE_MODE_SIDE		3

native TogglePlayerSpectating(playerid, toggle);
native PlayerSpectatePlayer(playerid, targetplayerid, mode = SPECTATE_MODE_NORMAL);
native PlayerSpectateVehicle(playerid, targetvehicleid, mode = SPECTATE_MODE_NORMAL);



//____[a_vehicles.inc]________________________________________________________________________
#if defined _vehicles_included
	#endinput
#endif
#define _vehicles_included
#pragma library vehicles

// Vehicle
native CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay);
native DestroyVehicle(vehicleid);
native GetVehiclePos(vehicleid, &Float:x, &Float:y, &Float:z);
native SetVehiclePos(vehicleid, Float:x, Float:y, Float:z);
native GetVehicleZAngle(vehicleid, &Float:z_angle);
native SetVehicleZAngle(vehicleid, Float:z_angle);
native SetVehicleParamsForPlayer(vehicleid,playerid,objective,doorslocked);
native SetVehicleToRespawn(vehicleid);
native LinkVehicleToInterior(vehicleid, interiorid);
native AddVehicleComponent(vehicleid, componentid);
native RemoveVehicleComponent(vehicleid, componentid);
native ChangeVehicleColor(vehicleid, color1, color2);
native ChangeVehiclePaintjob(vehicleid, paintjobid);
native SetVehicleHealth(vehicleid, Float:health);
native GetVehicleHealth(vehicleid, &Float:health);
native AttachTrailerToVehicle(trailerid, vehicleid);
native DetachTrailerFromVehicle(vehicleid);
native IsTrailerAttachedToVehicle(vehicleid);
native GetVehicleTrailer(vehicleid);
native SetVehicleNumberPlate(vehicleid, numberplate[]);
native GetVehicleModel(vehicleid);

// Virtual Worlds
native SetVehicleVirtualWorld(vehicleid, worldid);
native GetVehicleVirtualWorld(vehicleid);



//____[a_objects.inc]_________________________________________________________________________
#if defined _objects_included
	#endinput
#endif
#define _objects_included
#pragma library objects

// Objects

native CreateObject(modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ);
native SetObjectPos(objectid, Float:X, Float:Y, Float:Z);
native GetObjectPos(objectid, &Float:X, &Float:Y, &Float:Z);
native SetObjectRot(objectid, Float:RotX, Float:RotY, Float:RotZ);
native GetObjectRot(objectid, &Float:RotX, &Float:RotY, &Float:RotZ);
native IsValidObject(objectid);
native DestroyObject(objectid);
native MoveObject(objectid, Float:X, Float:Y, Float:Z, Float:Speed);
native StopObject(objectid);

native CreatePlayerObject(playerid, modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ);

native SetPlayerObjectPos(playerid, objectid, Float:X, Float:Y, Float:Z);
native GetPlayerObjectPos(playerid, objectid, &Float:X, &Float:Y, &Float:Z);
native SetPlayerObjectRot(playerid, objectid, Float:RotX, Float:RotY, Float:RotZ);
native GetPlayerObjectRot(playerid, objectid, &Float:RotX, &Float:RotY, &Float:RotZ);

native IsValidPlayerObject(playerid, objectid);
native DestroyPlayerObject(playerid, objectid);
native MovePlayerObject(playerid, objectid, Float:X, Float:Y, Float:Z, Float:Speed);
native StopPlayerObject(playerid, objectid);

native AttachObjectToPlayer(objectid, playerid, Float:OffsetX, Float:OffsetY, Float:OffsetZ, Float:rX, Float:rY, Float:rZ);
native AttachPlayerObjectToPlayer(objectplayer, objectid, attachplayer, Float:OffsetX, Float:OffsetY, Float:OffsetZ, Float:rX, Float:rY, Float:rZ);



//____[a_sampdb.inc]__________________________________________________________________________
#if defined _sampdb_included
	#endinput
#endif
#define _sampdb_included
#pragma library sampdb

native DB:db_open(name[]);
native db_close(DB:db);
native DBResult:db_query(DB:db,query[]);
native db_free_result(DBResult:dbresult);
native db_num_rows(DBResult:dbresult);
native db_next_row(DBResult:dbresult);
native db_num_fields(DBResult:dbresult);
native db_field_name(DBResult:dbresult, field, result[], maxlength);
native db_get_field(DBResult:dbresult, field, result[], maxlength);
native db_get_field_assoc(DBResult:dbresult, const field[], result[], maxlength);



//____[core.inc]______________________________________________________________________________
#if defined _core_included
  #endinput
#endif
#define _core_included
#pragma library Core

native heapspace();

native funcidx(const name[]);

native numargs();
native getarg(arg, index=0);
native setarg(arg, index=0, value);

native tolower(c);
native toupper(c);
native swapchars(c);

native random(max);

native min(value1, value2);
native max(value1, value2);
native clamp(value, min=cellmin, max=cellmax);

native getproperty(id=0, const name[]="", value=cellmin, string[]="");
native setproperty(id=0, const name[]="", value=cellmin, const string[]="");
native deleteproperty(id=0, const name[]="", value=cellmin);
native existproperty(id=0, const name[]="", value=cellmin);




//____[file.inc]______________________________________________________________________________
#if defined _file_included
  #endinput
#endif
#define _file_included
#pragma library File

enum filemode
    {
    io_read,            /* file must exist */
    io_write,           /* creates a new file */
    io_readwrite,       /* opens an existing file, or creates a new file */
    io_append,          /* appends to file (write-only) */
    }

enum seek_whence
    {
    seek_start,
    seek_current,
    seek_end,
    }

const EOF = -1;

native File:fopen(const name[], filemode: mode = io_readwrite);
native bool:fclose(File: handle);
native File:ftemp();
native bool:fremove(const name[]);

native fwrite(File: handle, const string[]);
native fread(File: handle, string[], size = sizeof string, bool: pack = false);
native bool:fputchar(File: handle, value, bool: utf8 = true);
native fgetchar(File: handle, value, bool: utf8 = true);
native fblockwrite(File: handle, const buffer[], size = sizeof buffer);
native fblockread(File: handle, buffer[], size = sizeof buffer);

native fseek(File: handle, position = 0, seek_whence: whence = seek_start);
native flength(File: handle);
native fexist(const pattern[]);
native bool:fmatch(name[], const pattern[], index = 0, size = sizeof name);



//____[time.inc]______________________________________________________________________________
#if defined _time_included
  #endinput
#endif
#define _time_included
#pragma library Time

native gettime(&hour=0, &minute=0, &second=0);
native getdate(&year=0, &month=0, &day=0);
native tickcount(&granularity=0);



//____[string.inc]____________________________________________________________________________
#if defined _string_included
  #endinput
#endif
#define _string_included
#pragma library String

native strlen(const string[]);
native strpack(dest[], const source[], maxlength=sizeof dest);
native strunpack(dest[], const source[], maxlength=sizeof dest);
native strcat(dest[], const source[], maxlength=sizeof dest);

native strmid(dest[], const source[], start, end, maxlength=sizeof dest);
native bool: strins(string[], const substr[], pos, maxlength=sizeof string);
native bool: strdel(string[], start, end);

native strcmp(const string1[], const string2[], bool:ignorecase=false, length=cellmax);
native strfind(const string[], const sub[], bool:ignorecase=false, pos=0);

native strval(const string[]);
native valstr(dest[], value, bool:pack=false);
native bool: ispacked(const string[]);

native uudecode(dest[], const source[], maxlength=sizeof dest);
native uuencode(dest[], const source[], numbytes, maxlength=sizeof dest);
native memcpy(dest[], const source[], index=0, numbytes, maxlength=sizeof dest);



//____[datagram.inc]__________________________________________________________________________
#if defined _datagram_included
  #endinput
#endif
#define _datagram_included
#pragma library DGram

native sendstring(const message[], const destination[]="");
native sendpacket(const packet[], size, const destination[]="");

native listenport(port);

forward @receivestring(const message[], const source[]);
forward @receivepacket(const packet[], size, const source[]);



//____[float.inc]_____________________________________________________________________________
#if defined _Float_included
  #endinput
#endif
#define _Float_included
#pragma library Float

/* Different methods of rounding */
enum floatround_method {
  floatround_round,
  floatround_floor,
  floatround_ceil,
  floatround_tozero,
  floatround_unbiased
}
enum anglemode {
  radian,
  degrees,
  grades
}

/**************************************************/
/* Convert an integer into a floating point value */
native Float:float(value);

/**************************************************/
/* Convert a string into a floating point value */
native Float:floatstr(const string[]);

/**************************************************/
/* Multiple two floats together */
native Float:floatmul(Float:oper1, Float:oper2);

/**************************************************/
/* Divide the dividend float by the divisor float */
native Float:floatdiv(Float:dividend, Float:divisor);

/**************************************************/
/* Add two floats together */
native Float:floatadd(Float:oper1, Float:oper2);

/**************************************************/
/* Subtract oper2 float from oper1 float */
native Float:floatsub(Float:oper1, Float:oper2);

/**************************************************/
/* Return the fractional part of a float */
native Float:floatfract(Float:value);

/**************************************************/
/* Round a float into a integer value */
native floatround(Float:value, floatround_method:method=floatround_round);

/**************************************************/
/* Compare two integers. If the two elements are equal, return 0.
   If the first argument is greater than the second argument, return 1,
   If the first argument is less than the second argument, return -1. */
native floatcmp(Float:oper1, Float:oper2);

/**************************************************/
/* Return the square root of the input value, same as floatpower(value, 0.5) */
native Float:floatsqroot(Float:value);

/**************************************************/
/* Return the value raised to the power of the exponent */
native Float:floatpower(Float:value, Float:exponent);

/**************************************************/
/* Return the logarithm */
native Float:floatlog(Float:value, Float:base=10.0);

/**************************************************/
/* Return the sine, cosine or tangent. The input angle may be in radian,
   degrees or grades. */
native Float:floatsin(Float:value, anglemode:mode=radian);
native Float:floatcos(Float:value, anglemode:mode=radian);
native Float:floattan(Float:value, anglemode:mode=radian);

/**************************************************/
/* Return the absolute value */
native Float:floatabs(Float:value);


/**************************************************/
#pragma rational Float

/* user defined operators */
native Float:operator*(Float:oper1, Float:oper2) = floatmul;
native Float:operator/(Float:oper1, Float:oper2) = floatdiv;
native Float:operator+(Float:oper1, Float:oper2) = floatadd;
native Float:operator-(Float:oper1, Float:oper2) = floatsub;
native Float:operator=(oper) = float;

stock Float:operator++(Float:oper)
    return oper+1.0;

stock Float:operator--(Float:oper)
    return oper-1.0;

stock Float:operator-(Float:oper)
    return oper^Float:cellmin;                  /* IEEE values are sign/magnitude */

stock Float:operator*(Float:oper1, oper2)
    return floatmul(oper1, float(oper2));       /* "*" is commutative */

stock Float:operator/(Float:oper1, oper2)
    return floatdiv(oper1, float(oper2));

stock Float:operator/(oper1, Float:oper2)
    return floatdiv(float(oper1), oper2);

stock Float:operator+(Float:oper1, oper2)
    return floatadd(oper1, float(oper2));       /* "+" is commutative */

stock Float:operator-(Float:oper1, oper2)
    return floatsub(oper1, float(oper2));

stock Float:operator-(oper1, Float:oper2)
    return floatsub(float(oper1), oper2);

stock bool:operator==(Float:oper1, Float:oper2)
    return floatcmp(oper1, oper2) == 0;

stock bool:operator==(Float:oper1, oper2)
    return floatcmp(oper1, float(oper2)) == 0;  /* "==" is commutative */

stock bool:operator!=(Float:oper1, Float:oper2)
    return floatcmp(oper1, oper2) != 0;

stock bool:operator!=(Float:oper1, oper2)
    return floatcmp(oper1, float(oper2)) != 0;  /* "!=" is commutative */

stock bool:operator>(Float:oper1, Float:oper2)
    return floatcmp(oper1, oper2) > 0;

stock bool:operator>(Float:oper1, oper2)
    return floatcmp(oper1, float(oper2)) > 0;

stock bool:operator>(oper1, Float:oper2)
    return floatcmp(float(oper1), oper2) > 0;

stock bool:operator>=(Float:oper1, Float:oper2)
    return floatcmp(oper1, oper2) >= 0;

stock bool:operator>=(Float:oper1, oper2)
    return floatcmp(oper1, float(oper2)) >= 0;

stock bool:operator>=(oper1, Float:oper2)
    return floatcmp(float(oper1), oper2) >= 0;

stock bool:operator<(Float:oper1, Float:oper2)
    return floatcmp(oper1, oper2) < 0;

stock bool:operator<(Float:oper1, oper2)
    return floatcmp(oper1, float(oper2)) < 0;

stock bool:operator<(oper1, Float:oper2)
    return floatcmp(float(oper1), oper2) < 0;

stock bool:operator<=(Float:oper1, Float:oper2)
    return floatcmp(oper1, oper2) <= 0;

stock bool:operator<=(Float:oper1, oper2)
    return floatcmp(oper1, float(oper2)) <= 0;

stock bool:operator<=(oper1, Float:oper2)
    return floatcmp(float(oper1), oper2) <= 0;

stock bool:operator!(Float:oper)
    return (_:oper & cellmax) == 0;

/* forbidden operations */
forward operator%(Float:oper1, Float:oper2);
forward operator%(Float:oper1, oper2);
forward operator%(oper1, Float:oper2);

//____[morphic.inc]___________________________________________________________________________

new pdistance = 1;
forward NameTimer();
Float:GetPointDistanceToPointExMorph(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2)
{
new Float:x, Float:y, Float:z;
x = x1-x2;
y = y1-y2;
z = z1-z2;
return floatsqroot(x*x+y*y+z*z);
}
stock SetPDistance(dista)
{
pdistance = dista;
}
stock GetPDistance()
{
return pdistance;
}
stock EnableDistancedNameTag(delay)
{
SetTimer("NameTimer",delay,1);
}
forward NameTimer();
public NameTimer()
	{
	for(new i = 0;i < MAX_PLAYERS;i++)
 	{
 	if(IsPlayerConnected(i))
 	{
 	for(new q = 0;q < MAX_PLAYERS;q++)
 	{
	if(IsPlayerConnected(q))
	{
 	new Float:p1x;
	new Float:p1y;
	new Float:p1z;
	new Float:p2x;
	new Float:p2y;
	new Float:p2z;
	if(IsPlayerConnected(i) && IsPlayerConnected(q))
	{
	GetPlayerPos(i,p1x,p1y,p1z);
    GetPlayerPos(q,p2x,p2y,p2z);
	if(GetPointDistanceToPointExMorph(p1x,p1y,p1z,p2x,p2y,p2z) < pdistance)
		{
	    ShowPlayerNameTagForPlayer(i,q,1);
	    }
	else
		{
		ShowPlayerNameTagForPlayer(i,q,0);
		}
	}}}}}
}



//____[utils.inc]_____________________________________________________________________________
IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

ReturnUser(text[], playerid = INVALID_PLAYER_ID)
{
	new pos = 0;
	while (text[pos] < 0x21) // Strip out leading spaces
	{
		if (text[pos] == 0) return INVALID_PLAYER_ID; // No passed text
		pos++;
	}
	new userid = INVALID_PLAYER_ID;
	if (IsNumeric(text[pos])) // Check whole passed string
	{
		// If they have a numeric name you have a problem (although names are checked on id failure)
		userid = strval(text[pos]);
		if (userid >=0 && userid < MAX_PLAYERS)
		{
			if(!IsPlayerConnected(userid))
			{
				/*if (playerid != INVALID_PLAYER_ID)
				{
					SendClientMessage(playerid, 0xFF0000AA, "User not connected");
				}*/
				userid = INVALID_PLAYER_ID;
			}
			else
			{
				return userid; // A player was found
			}
		}
		/*else
		{
			if (playerid != INVALID_PLAYER_ID)
			{
				SendClientMessage(playerid, 0xFF0000AA, "Invalid user ID");
			}
			userid = INVALID_PLAYER_ID;
		}
		return userid;*/
		// Removed for fallthrough code
	}
	// They entered [part of] a name or the id search failed (check names just incase)
	new len = strlen(text[pos]);
	new count = 0;
	new name[MAX_PLAYER_NAME];
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, name, sizeof (name));
			if (strcmp(name, text[pos], true, len) == 0) // Check segment of name
			{
				if (len == strlen(name)) // Exact match
				{
					return i; // Return the exact player on an exact match
					// Otherwise if there are two players:
					// Me and MeYou any time you entered Me it would find both
					// And never be able to return just Me's id
				}
				else // Partial match
				{
					count++;
					userid = i;
				}
			}
		}
	}
	if (count != 1)
	{
		if (playerid != INVALID_PLAYER_ID)
		{
			if (count)
			{
				SendClientMessage(playerid, 0xFF0000AA, "Multiple users found, please narrow earch");
			}
			else
			{
				SendClientMessage(playerid, 0xFF0000AA, "No matching user found");
			}
		}
		userid = INVALID_PLAYER_ID;
	}
	return userid; // INVALID_USER_ID for bad return
}