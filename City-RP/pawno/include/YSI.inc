/*----------------------------------------------------------------------------*-
					=======================
					Y Sever Includes - Main
					=======================
Description:
	Main include to use the YSI script libraries.  Simply add:
	
	#include <YSI>
	
	to the top of your script to get the full power of all the YSI libraries
	and the functions and features they expose.
Legal:
	Copyright (C) 2007 Alex "Y_Less" Cole

	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
	MA 02110-1301, USA.
Version:
	0.1.3
Changelog:
	18/06/07:
		Updated YSI_text functions.
	18/04/07:
		Added new files.
		Moved objects and checkpoints to YSI/Visual/.
	17/04/07:
		Added new files.
	16/04/07:
		Added native definitions
	15/04/07:
		First version
Functions:
	Public:
		-
	Core:
		-
	Stock:
		-
	Static:
		-
	Inline:
		-
	API:
		-
Callbacks:
	-
Definitions:
	-
Enums:
	-
Macros:
	-
Tags:
	-
Variables:
	Global:
		-
	Static:
		-
Commands:
	-
Compile options:
	_YSI_DEBUG - Use YSI/YSI_debug.own.
	_YSI_MISC - Use YSI/YSI_misc.own.
	_YSI_CORE_BIT - Use YSI/Core/YSI_bit.own.
	_YSI_CORE_BINTREE - Use YSI/Core/YSI_bintree.own.
	_YSI_CORE_INI - Use YSI/Core/YSI_INI.own.
	_YSI_CORE_TEXT - Use YSI/Core/YSI_text.own.
	_YSI_CORE_FORMAT - Use YSI/Core/YSI_format.own.
	_YSI_CORE_LANGUAGES - Use YSI/Core/YSI_languages.own.
	_YSI_CORE_COMMANDS - Use YSI/Core/YSI_commands.own.
	_YSI_CORE_PLAYER - Use YSI/Core/YSI_player.own.
	_YSI_SERVER_MODULES - Use YSI/Server/YSI_modules.own.
	_YSI_VISUAL_OBJECTS - Use YSI/Visual/YSI_objects.own
	_YSI_VISUAL_CHECKPOINTS - Use YSI/Visual/YSI_objects.own
	_YSI_SYSTEM_DEFAULT - Use YSI/System/YSI_default.own.
Operators:
	-
-*----------------------------------------------------------------------------*/

#include <a_samp>

#if defined MAX_PLAYER_NAME
	#undef MAX_PLAYER_NAME
#endif
#define MAX_PLAYER_NAME 24

#if defined _YSI_included
	#endinput
#endif
#define _YSI_included

/*----------------------------------------------------------------------------*-
					===============
					/YSI/ Libraries
					===============
-*----------------------------------------------------------------------------*/

/*
native _DEPENDECENCY_FUNCTIONS_();
	native
*/
#include "YSI/YSI_dependencies.own"

/*
native _DEBUG_FUNCTIONS_();
	native
native Debug_Code_<level>(code);
native Debug_Print_<level>(format[], {Float,_}:...);
	native
*/
#if defined _YSI_DEBUG
	#include "YSI/YSI_debug.own"
#endif

/*
native _MISC_FUNCTIONS_();
	native
native ceildiv(num, div);
native floordiv(num, div);
native iseven(num);
native isodd(num);
native chrfind(needle, haystack[], start = 0);
native chrnfind(needle, haystack[], start = 0);
native strcpy(dest[], source[], max, len = -1);
native bernstein(string[]);
native StripNL(str[]);
native strconcat(...);
native QuickSort(numbers[], arraySize);
native chrtolower(chr);
native strtolower(str[]);
native hexstr(string[]);
native bool:binstr(string[]);
native ReturnPlayerName(playerid);
native ishex(str[]);
native numstr(num);
native chrtoupper(chr);
native strtoupper(str[]);
	native
*/
#if defined _YSI_MISC
	#include "YSI/YSI_misc.own"
#endif

/*----------------------------------------------------------------------------*-
					====================
					/YSI/Core/ Libraries
					====================
-*----------------------------------------------------------------------------*/

/*
native _CORE_BIT_FUNCTIONS_();
	native
native Bit_Bits(num);
native Bit_Get(Bit:array[], slot, size = sizeof (array));
native Bit_Set(Bit:array[], slot, set, size = sizeof (array));
native Bit_SetAll(Bit:array[], set, size = sizeof (array));
native Bit_GetCount(Bit:array[], size = sizeof (array));
native Bit_GetBits(Bit:array[], slot);
	native
*/
#if defined _YSI_CORE_BIT
	#include "YSI/Core/YSI_bit.own"
#endif

/*
native _CORE_BINTREE_FUNCTIONS_();
	native
native Bintree_Sort(input[][E_BINTREE_INPUT], size);
native Bintree_Fill(Bintree:output[][E_BINTREE_INPUT], data[][E_BINTREE_INPUT], size);
native Bintree_Generate(Bintree:output[][E_BINTREE_TREE], input[][E_BINTREE_INPUT], size);
native Bintree_Reset(Bintree:tree[][E_BINTREE_TREE], pointer = 0);
native Bintree_FindValue(Bintree:tree[][E_BINTREE_TREE], value, &cont = 0, &old = 0);
native Bintree_Add(Bintree:data[][E_BINTREE_TREE], input[E_BINTREE_INPUT], offset, maxsize = sizeof (data));
native Bintree_Delete(Bintree:source[][E_BINTREE_TREE], index, count);
native Bintree_UpdatePointers(Bintree:data[][E_BINTREE_TREE], offset, size, mod = -1);
	native
*/
#if defined _YSI_CORE_BINTREE
	#include "YSI/Core/YSI_bintree.own"
#endif

/*
native _CORE_INI_FUNCTIONS_();
	native
native bool:INI_Load(filename[]);
native bool:INI_ParseFile(filename[], remoteFormat[], bool:bFileFirst = false);
native INI_GetEntryText(source[], dest[], i);
native INI_BroadcastData(function[], identifier[], text[]);
native bool:INI_GetEntryName(source[], dest[], &i);
native INI_INI();
native INI:INI_Open(filename[]);
native INI_Close(INI:file);
native INI_SetTag(INI:file, tag[]);
native INI_WriteString(INI:file, name[], data[]);
native INI_WriteInt(INI:file, name[], data);
native INI_WriteFloat(INI:file, name[], Float:data, accuracy = 6);
native INI_WriteBuffer(INI:file);
native INI_String(name[], function);
native INI_Bin(name[], function);
native INI_Hex(name[], function);
native INI_Float(name[], function);
native INI_Int(name[], function);
	native
*/
#if defined _YSI_CORE_INI
	#include "YSI/Core/YSI_INI.own"
#endif

/*
native _CORE_TEXT_FUNCTIONS_();
	native
naitve Text_Send(playerid, identifier[]);
native Text_SendToAll(identifier[]);
native Text_SendToGroup(group, identifier[]);
native Text_SendToPlayers(Bit:players[], identifier[]);
naitve Text_SendFormat(playerid, identifier[], {Float,_}:...);
native Text_SendToAllFormat(identifier[], {Float,_}:...);
native Text_SendToGroupFormat(group, identifier[], {Float,_}:...);
native Text_SendToPlayersFormat(Bit:players[], identifier[], {Float,_}:...);
native Text_Text();
native Text_AddToBuffer(identifier[], text[]);
native Text_ResetAll();
native Text_NewLanguage(Language:languageID);
native Text_Parse();
native Text_GetText(identifier[], Language:languageID);
native Text_RegisterTag(tag[]);
native Text_GetTextStyle(index);
native Text_GetTextColour(index);
native Text_GetTextTime(index);
native Text_GetTextFromIndex(index, Language:languageID, identifier[]);
native Text_GetErrorMessage(Language:languageID);
	native
*/
#if defined _YSI_CORE_TEXT
	#include "YSI/Core/YSI_text.own"
#endif

/*
native _CORE_FORMAT_FUNCTIONS_();
	native
native Format_SendFormattedText(playerid, type, colorTime, identifier[], {Float,_}:...);
	native
*/
#if defined _YSI_CORE_FORMAT
	#include "YSI/Core/YSI_format.own"
#endif

/*
native _CORE_COMMAND_FUNCTIONS_();
	native
native Command_IsCleared(playerid, command);
native Command_SetDisconnectReturn(set);
native Command_SetIllegalReturn(set);
native Command_UseShortCuts(set);
native Command_SetDeniedReturn(set);
native Command_UseDeniedMessage(set);
native Command_UseAltNames(set);
native Command_UsePrefix(set);
native Command_UseSpace(set);
native Command_Add(funcname[]);
native Command_Parse();
native Command_SetAltName(funcname[], altname[]);.
native Comamnd_SetPlayerUse(command[], playerid, set);
native Comamnd_SetPlayerUseByID(command, playerid, set);
native Command_SetPrefix(prefix[]);
native Command_Process(playerid, cmdtext[], help = 0);
native Command_Name(funcname[]);
	native
native ycmd(command[]);
	native
*/
#if defined _YSI_CORE_COMMANDS
	#include "YSI/Core/YSI_commands.own"
#endif

/*
native _CORE_LANGUAGE_FUNCTIONS_();
	native
native Langs_Langs();
native Langs_IsActive(Language:languageID);
native Langs_GetLanguageIdentifier(Language:languageID);
native Langs_GetLanguageID(identifier[]);
native Langs_ResetAll();
native Langs_SaveEnteredData();
native bool:Langs_LoadLanguage(LanguagelanguageID);
native Langs_LoadAll();
native Langs_AddLanguage(identifer[], name[]);
native Langs_AddFile(filename[], path[] = "");
native Langs_GetLanguageName(Language:languageID);
native Langs_IsValid(Language:languageID);
	native
*/
#if defined _YSI_CORE_LANGUAGES
	#include "YSI/Core/YSI_languages.own"
#endif

/*
native _CORE_PLAYER_FUNCTIONS_();
	native
native Language:Player_GetPlayerLanguage(playerid);
native Player_OnPlayerConnect(playerid);
native Player_Player();
native Player_OnPlayerDisconnect(playerid, reason);
native Player_SetPlayerLanguage(playerid, Language:languageID);
native Player_FindShortCut(playerid, shortcut, cmdname[]);
native Player_SetTag(tag[]);
native Player_WriteString(name[], data[]);
native Player_WriteInt(name[], data);
native Player_WriteFloat(name[], Float:data, accuracy = 6);
	native
*/
#if defined _YSI_CORE_PLAYER
	#include "YSI/Core/YSI_player.own"
#endif

/*----------------------------------------------------------------------------*-
					======================
					/YSI/Server/ Libraries
					======================
-*----------------------------------------------------------------------------*/

/*
native _SERVER_MODULE_FUNCTIONS_();
	native
native Modules_Modules();
native Modules_IsActive(Module:moduleID);
native Modules_IsPrivate(Module:moduleID);
native bool:Modules_LoadAll();
native Modules_CloseAll();
native Modules_Close(name[]);
native Modules_CloseID(Module:id);
native Module:Modules_Register(name[], tag[], hidden);
native Modules_GetModuleCount();
native Modules_GetVisibleCount();
native Modules_GetHiddenCount();
	native
*/
#if defined _YSI_SERVER_MODULES
	#include "YSI/Server/YSI_modules.own"
#endif

/*----------------------------------------------------------------------------*-
					======================
					/YSI/Visual/ Libraries
					======================
-*----------------------------------------------------------------------------*/

/*
native _VISUAL_OBJECT_FUNCTIONS_();
	native
native Object_Object();
native Object_AddToPlayer(objectid, playerid);
native Object_AddToWorld(objectid, virtualworld);
native Object_AddToAllPlayers(objectid);
native Object_AddToAllWorlds(objectid);
native Object_RemoveFromPlayer(objectid, playerid);
native Object_RemoveFromWorld(objectid, virtualworld);
native Object_RemoveFromAllPlayers(objectid);
native Object_RemoveFromAllWorlds(objectid);
native Object_OnPlayerDisconnect(playerid, reason);
native Object_IsGlobal(objectid);
	native
native MoveDynamicObject(objectid, Float:X, Float:Y, Float:Z, Float:S);
native StopDynamicObject(objectid);
native IsValidDynamicObject(objectid);
native CreateDynamicObject(model, Float:X, Float:Y, Float:Z, Float:RX = 0.0, Float:RY = 0.0, Float:RZ = 0.0);
native CreatePlayerDynamicObject(playerid, model, Float:X, Float:Y, Float:Z, Float:RX = 0.0, Float:RY = 0.0, Float:RZ = 0.0);
native CreateVWDynamicObject(virtualworld, model, Float:X, Float:Y, Float:Z, Float:RX = 0.0, Float:RY = 0.0, Float:RZ = 0.0);
native CreatePlayerVWDynamicObject(playerid, virtualworld, model, Float:X, Float:Y, Float:Z, Float:RX = 0.0, Float:RY = 0.0, Float:RZ = 0.0);
native DestroyDynamicObject(objectid);
native GetDynamicObjectPos(objectid, &Float:X, &Float:Y, &Float:Z);
native GetDynamicObjectRot(objectid, &Float:RX, &Float:RY, &Float:RZ);
native SetDynamicObjectPos(objectid, Float:X, Float:Y, Float:Z);
native SetDynamicObjectRot(objectid, Float:RX, Float:RY, Float:RZ);
native AttachDynamicObjectToPlayer(objectid, playerid, Float:offX, Float:offY, Float:offZ, Float:rX, Float:rY, Float:rZ);
native DetachDynamicObjectFromPlayer(objectid);
native IsValidModel(modelid);
	native
*/
#if defined _YSI_VISUAL_OBJECTS
	#include "YSI/Visual/YSI_objects.own"
#endif

/*
native _VISUAL_CHECKPOINT_FUNCTIONS_();
	native
native Checkpoint_Checkpoint();
native Checkpoint_SetVisible(cpid, set);
native Checkpoint_SetAllWorlds(cpid, set);
native Checkpoint_SetAllPlayers(cpid, set);
native Checkpoint_AddPlayer(cpid, playerid);
native Checkpoint_RemovePlayer(cpid, playerid);
native Checkpoint_AddVW(cpid, vwid);
native Checkpoint_RemoveVW(cpid, vwid);
native Checkpoint_HasPlayer(cpid, playerid);
native Checkpoint_HasPlayerNoWorld(cpid, playerid);
native Checkpoint_Get(playerid);
native Checkpoint_OnPlayerEnterCheckpoint(playerid);
native Checkpoint_OnPlayerLeaveCheckpoint(playerid);
native Checkpoint_OnPlayerConnect(playerid);
native Checkpoint_IsGlobal(checkpoint);
	native
native CreateCheckpoint(Float:x, Float:y, Float:z, Float:size, players = 0, vws = 0);
native IsValidCheckpoint(cpid);
native DestroyCheckpoint(cpid);
	native
*/
#if defined _YSI_VISUAL_CHECKPOINTS
	#include "YSI/Visual/YSI_checkpoints.own"
#endif

/*
native _VISUAL_RACE_FUNCTIONS_();
	native
native Race_Race();
native Race_OnPlayerEnterRaceCP(playerid);
native Race_OnPlayerStateChange(playerid, newstate, oldstate);
native Race_OnPlayerDisconnect(playerid, reason);
native Race_Create(laps = 0, entry = 0, countdown = 3, bool:arial = 0, bool:fixedPrize = 1, exitTime = 0, interior = 0, world = 0, bool:restart = 0);
native Race_AddCheckpoint(raceid, Float:x, Float:y, Float:z);
native Race_AddStart(raceid, Float:x, Float:y, Float:z, Float:a);
native Race_SetFixedWin(raceid, set);
native Race_SetArial(raceid, set);
native Race_PlayerLeave(playerid, refund = 0);
native Race_SetCountdown(raceid, countdown);
native Race_SetInterior(raceid, interior);
native Race_SetWorld(raceid, world);
native Race_SetPrize(raceid, position, amount);
native Race_SetExitTime(raceid, time);
native Race_IsActive(raceid);
native Race_SetLaps(raceid, laps);
native Race_SetEntry(raceid, cost);
native Race_GetPlayerExitedTime(playerid);
native Race_PlayerJoin(playerid, race);
native Race_Start(race);
native Race_GetPlayerRaceTime(playerid);
native Race_GetPlayerPosition(playerid);
	native
*/
#if defined _YSI_VISUAL_RACE
	#include "YSI/Visual/YSI_race.own"
#endif

/*
native _VISUAL_AREA_FUNCTIONS_();
	native
native Area_Area();
native Area_OnPlayerConnect(playerid);
native Area_Delete(area);
native Area_AddCube(Float:minx, Float:miny, Float:minz, Float:maxx, Float:maxy, Float:maxz);
native Area_AddBox(Float:minx, Float:miny, Float:maxx, Float:maxy);
native Area_AddCircle(Float:x, Float:y, Float:r, Float:h = 10000.0);
native Area_AddSphere(Float:x, Float:y, Float:z, Float:r);
native Area_AddPoly(Float:x1, Float:y1, Float:x2, Float:y2, Float:x3, Float:y3, Float:...);
native Area_GetPlayerArea(playerid);
native Area_SetPlayer(area, playerid, set);
native Area_SetAllPlayers(area, set);
native Area_SetAllWorlds(area, set);
native Area_SetWorld(area, world, set);
native Area_IsValid(area);
	native
*/
#if defined _YSI_VISUAL_AREAS
	#include "YSI/Visual/YSI_areas.own"
#endif

/*----------------------------------------------------------------------------*-
					========================
					/YSI/Gamemode/ Libraries
					========================
-*----------------------------------------------------------------------------*/

/*
native _GAMEMODE_PROPERTY_FUNCTIONS_();
	native
native Property_OnPlayerSelectedMenuRow(playerid, row);
native Property_OnPlayerExitedMenu(playerid);
native Property_OnPlayerEnterCheckpointEx(playerid, cpid);
native Property_OnPlayerLeaveCheckpointEx(playerid, cpid);
native Property_OnPlayerSpawn(playerid);
native Property_OnPlayerConnect(playerid);
native Property_OnPlayerLeaveArea(playerid, area);
native Property_OnPlayerEnterArea(playerid, area);
native Property_GetPlayerPropCount(playerid);
native Property_GetLink(property);
native Property_GetType(property);
native Property_IsValid(property);
native Property_Bank(playerid, amount);
native Property_SavePlayerWeapon(playerid, weaponslot, ammo);
native Property_SaveWeapons(playerid);
native Property_LoadWeapons(playerid, identifier[], text[]);
native Property_SaveBank(playerid);
native Property_LoadBank(playerid, identifier[], text[]);
	native
native CreateProperty(name[], Float:x, Float:y, Float:z, price, reward, interval = 60000, sell = 0, multi = 0, reduce = 0, increase = 0);
native CreateBank(Float:x, Float:y, Float:z, name[] = "");
native CreateAmmunation(Float:x, Float:y, Float:z, spawn, instant, weapon, ammo, price, ...);
native CreateMoneyArea(area, money = 100, interval = 10000);
native CreateMoneyPoint(Float:x, Float:y, Float:z, Float:s, money = 100, interval = 10000);
native CreateTeleport(Float:sx, Float:sy, Float:sz, Float:tx, Float:ty, Float:tz, cost = 0, name[] = "");
native CreateForbiddenArea(area, kick = 0, health = 1000, invert = 0, name[] = "");
native DestroyProperty(property);
	native
*/
#if defined _YSI_GAMEMODE_PROPERTIES
	#include "YSI/Gamemode/YSI_properties.own"
#endif

/*----------------------------------------------------------------------------*-
					======================
					/YSI/System/ Libraries
					======================
-*----------------------------------------------------------------------------*/

/*
native _SYSTEM_DEFAULT_FUNCTIONS_();
	native
native Default_Setup();
native Default_OnGameModeInit();
native Default_OnGameModeExit();
native Default_OnFilterScriptInit();
native Default_OnFilterScriptExit();
native Default_OnPlayerConnect(playerid);
native Default_OnPlayerDisconnect(playerid, reason);
native Default_OnPlayerSpawn(playerid);
native Default_OnPlayerDeath(playerid, killerid, reason);
native Default_OnVehicleSpawn(vehicleid);
native Default_OnVehicleDeath(vehicleid, killerid);
native Default_OnPlayerText(playerid, text[]);
native Default_OnPlayerCommandText(playerid, cmdtext[]);
native Default_OnPlayerInfoChange(playerid);
native Default_OnPlayerRequestClass(playerid, classid);
native Default_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
native Default_OnPlayerExitVehicle(playerid, vehicleid);
native Default_OnPlayerStateChange(playerid, newstate, oldstate);
native Default_OnPlayerEnterCheckpoint(playerid);
native Default_OnPlayerLeaveCheckpoint(playerid);
native Default_OnPlayerEnterRaceCheckpoint(playerid);
native Default_OnPlayerLeaveRaceCheckpoint(playerid);
native Default_OnRconCommand(cmd[]);
native Default_OnPlayerPrivmsg(playerid, recieverid, text[]);
native Default_OnPlayerRequestSpawn(playerid);
native Default_OnObjectMoved(objectid);
native Default_OnPlayerObjectMoved(playerid, objectid);
native Default_OnPlayerPickUpPickup(playerid, pickupid);
native Default_OnVehicleMod(vehicleid, componentid);
native Default_OnVehiclePaintjob(vehicleid, paintjobid);
native Default_OnVehicleRespray(vehicleid, color1, color2);
native Default_OnPlayerSelectedMenuRow(playerid, row);
native Default_OnPlayerExitedMenu(playerid);
	native
native LoadScript();
	native
*/
#if defined _YSI_SYSTEM_DEFAULT
	#include "YSI/System/YSI_default.own"
#endif

/*
native _SYSTEM_GROUP_FUNCTIONS_();
	native
native Group_NameGroup(group, name[]);
native Group_SetCommand(group, command[], set);
native Group_SetCommandByID(group, command, set);
native Group_UpdatePlayerCommand(command, playerid);
native Group_SetCheckpoint(group, checkpoint, set);
native Group_UpdatePlayerCheckpoint(checkpoint, playerid);
native Group_SetObject(group, object, set);
native Group_UpdatePlayerObject(object, playerid);
native Group_SetArea(group, area, set);
native Group_UpdatePlayerArea(area, playerid);
native Group_SetProperty(group, property, set);
native Group_UpdatePlayerProperty(property, playerid);
native Group_AddPlayer(group, playerid);
native Group_RemovePlayer(group, playerid);
native Group_RemovePlayerFromAllGroups(playerid);
native Bit:Group_GetGroupMembers(group);
native Group_GetGroups(playerid);
	native
*/
#if defined _YSI_SYSTEM_GROUPS
	#include "YSI/System/YSI_groups.own"
#endif

/*
native _SYSTEM_SCRIPT_FUNCTIONS_();
	native
native Script_OnGameModeInit();
native Script_OnGameModeExit();
native Script_OnFilterScriptInit();
native Script_OnFilterScriptExit();
native Script_OnPlayerConnect(playerid);
native Script_OnPlayerDisconnect(playerid, reason);
native Script_OnPlayerSpawn(playerid);
native Script_OnPlayerDeath(playerid, killerid, reason);
native Script_OnVehicleSpawn(vehicleid);
native Script_OnVehicleDeath(vehicleid, killerid);
native Script_OnPlayerText(playerid, text[]);
native Script_OnPlayerCommandText(playerid, cmdtext[]);
native Script_OnPlayerInfoChange(playerid);
native Script_OnPlayerRequestClass(playerid, classid);
native Script_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
native Script_OnPlayerExitVehicle(playerid, vehicleid);
native Script_OnPlayerStateChange(playerid, newstate, oldstate);
native Script_OnPlayerEnterCheckpoint(playerid);
native Script_OnPlayerLeaveCheckpoint(playerid);
native Script_OnPlayerEnterRaceCheckpoint(playerid);
native Script_OnPlayerLeaveRaceCheckpoint(playerid);
native Script_OnRconCommand(cmd[]);
native Script_OnPlayerPrivmsg(playerid, recieverid, text[]);
native Script_OnPlayerRequestSpawn(playerid);
native Script_OnObjectMoved(objectid);
native Script_OnPlayerObjectMoved(playerid, objectid);
native Script_OnPlayerPickUpPickup(playerid, pickupid);
native Script_OnVehicleMod(vehicleid, componentid);
native Script_OnVehiclePaintjob(vehicleid, paintjobid);
native Script_OnVehicleRespray(vehicleid, color1, color2);
native Script_OnPlayerSelectedMenuRow(playerid, row);
native Script_OnPlayerExitedMenu(playerid);
native Script_OnPlayerLogin(playerid, data[]);
native Script_OnPlayerLogout(playerid);
native Script_OnPlayerEnterCheckpointEx(playerid, cpid);
native Script_OnPlayerLeaveCheckpointEx(playerid, cpid);
native Script_OnPlayerEnterArea(playerid, area);
native Script_OnPlayerLeaveArea(playerid, area);
	native
*/
#if defined _YSI_SYSTEM_SCRIPT
	#include "YSI/System/YSI_script.own"
#endif

/*----------------------------------------------------------------------------*-
					===================
					/YSI/ Libraries (2)
					===================
-*----------------------------------------------------------------------------*/

/*
native _POST_FUNCTIONS_();
	native
*/
#include "YSI/YSI_post.own"
