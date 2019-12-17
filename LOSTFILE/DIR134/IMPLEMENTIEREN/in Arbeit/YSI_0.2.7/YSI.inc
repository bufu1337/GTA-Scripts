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
	18/02/08:
		Removed duplicate XML functions.
		Added text draw functions.
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

#if defined _YSI_included
	#endinput
#endif
#define _YSI_included

#if defined MAX_PLAYER_NAME
	#undef MAX_PLAYER_NAME
#endif
#define MAX_PLAYER_NAME 24

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
native timestamp();
native mktime(hour, minute, second, day, month, year);
native GetIP(playerid);
native endofline(line[], pos);
native sscanf(string[], format[], {Float,_}:...);
native explode(string[], dest[][], token = ' ', max = sizeof (dest), ml = sizeof (dest[]));
native IsPlayerInRangeOfPoint(playerid, Float:range, Float:x, Float:y, Float:z);
	native
*/
#if defined _YSI_MISC
	#include "YSI/YSI_misc.own"
#endif

/*----------------------------------------------------------------------------*-
					======================
					/YSI/System/ Libraries
					======================
-*----------------------------------------------------------------------------*/

/*
native _SYSTEM_ITTER_FUNCTIONS_();
	native
native foreach(name, as_new_var);
native foreachex(name, as_var);
native Itter_OnPlayerConnect(playerid);
native Itter_OnPlayerDisconnect(playerid);
native Itter_Create(name, size);
native Itter_Add(name, value);
native Itter_Remove(name, value);
	native
*/

#if defined _YSI_SYSTEM_ITTER
	#include "YSI/System/YSI_itter.own"
#endif

/*----------------------------------------------------------------------------*-
					========================
					/YSI/Setup/ Libraries
					========================
-*----------------------------------------------------------------------------*/

/*
native _SETUP_MASTER_FUNCTIONS_();
	native
*/
#if defined _YSI_SETUP_MASTER
	#include "YSI/Setup/YSI_Master.own"
#endif

/*
native _SETUP_TIMER_FUNCTIONS_();
	native
*/
#if defined _YSI_SETUP_TIMERS
	#include "YSI/Setup/YSI_Timers.own"
#endif

/*----------------------------------------------------------------------------*-
					====================
					/YSI/Core/ Libraries
					====================
-*----------------------------------------------------------------------------*/

/*
native _CORE_XML_FUNCTIONS_();
	native
native XML:XML_New();
native XML_Destroy(XML:rule);
native XML_Parse(XML:rule, filename[]);
native XML_GetKeyValue(key[], value[]);
native XML_AddHandler(XML:rule, trigger[], function[]);
native XML_RemoveHandler(XML:rule, trigger[]);
native XML_AddItem(tag[], name[] = "");
native XML_AddParameter(parent, tag[], value[] = "");
native XML_WriteItem(filename[], item);
native XML_RemoveItem(file[], tag[], name[]);
native XML_ReplaceItem(file[], tag[], name[], replacement);
	native
*/
#if defined _YSI_CORE_XML
	#include "YSI/Core/YSI_XML.own"
#endif

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
native _CORE_MD5_FUNCTIONS_();
	native
native MD5_Hash(str[]);
native MD5_Data(data[], len);
native MD5_File(filename[]);
native MD5_Init(ctx[E_MD5_CONTEXT]);
native MD5_Update(ctx[E_MD5_CONTEXT], data[], len);
native MD5_Final(ctx[E_MD5_CONTEXT], string = false);
*/
#if defined _YSI_CODE_MD5
	#include "YSI/Core/YSI_MD5.own"
#endif

/*
native _CORE_INI_FUNCTIONS_();
	native
native bool:INI_Load(filename[]);
native bool:INI_ParseFile(filename[], remoteFormat[], bool:bFileFirst = false, bool:bExtra = false, extra = 0, bool:bLocal = false, bool:bPassTag = false);
native INI_INI();
native INI:INI_Open(filename[]);
native INI_Close(INI:file);
native INI_SetTag(INI:file, tag[]);
native INI_WriteString(INI:file, name[], data[]);
native INI_WriteInt(INI:file, name[], data);
native INI_WriteFloat(INI:file, name[], Float:data, accuracy = 6);
native INI_RemoveEntry(INI:file, name[]);
	native
*/
#if defined _YSI_CORE_INI
	#include "YSI/Core/YSI_INI.own"
#endif

/*
native _CORE_TEXT_DRAW_FUNCTIONS_();
	native
native TD_TD();
native Style:TD_Create(Float:x = 0.0, Float:y = 0.0, Float:letterX = 0.48, Float:letterY = 1.12, Float:textX = 1280.0, Float:textY = 1280.0, colour = 0xE1E1E1FF, boxColour = 0x80808080, bgColour = 0x000000FF, shadow = 2, outline = 0, align = _:td_align_none, font = 1, bool:proportional = false, bool:box = false, time = 0, name = "\1");
native TD_Parse(filename[]);
native Style:TD_Clone(Style:styleID, name[] = "\1");
native TD_Name(Style:styleID, name[]);
native TD_TextPosition(Text:textID, Float:x, Float:y);
native TD_TextXPos(Text:textID, Float:x);
native TD_TextYPos(Text:textID, Float:y);
native TD_StylePosition(Style:styleID, Float:x, Float:y, bool:update = false);
native TD_StyleXPos(Style:styleID, Float:x, bool:update = false);
native TD_StyleYPos(Style:styleID, Float:y, bool:update = false);
native TD_LetterSize(Style:styleID, Float:x, Float:y, bool:update = true);
native TD_LetterX(Style:styleID, Float:x, bool:update = true);
native TD_LetterY(Style:styleID, Float:y, bool:update = true);
native TD_TextSize(Style:styleID, Float:x, Float:y, bool:update = true);
native TD_TextX(Style:styleID, Float:x, bool:update = true);
native TD_TextY(Style:styleID, Float:y, bool:update = true);
native TD_Alignment(Style:styleID, alignment = _:td_align_none, bool:update = true);
native TD_Color(Style:styleID, color, bool:update = true);
native TD_Colour(Style:styleID, colour, bool:update = true);
native TD_UseBox(Style:styleID, bool:use, bool:update = true);
native TD_BoxColor(Style:styleID, color, bool:update = true);
native TD_BoxColour(Style:styleID, colour, bool:update = true);
native TD_SetShadow(Style:styleID, size, bool:update = true);
native TD_SetOutline(Style:styleID, size, bool:update = true);
native TD_BackgroundColor(Style:styleID, color, bool:update = true);
native TD_BackgroundColour(Style:styleID, colour, bool:update = true);
native TD_Font(Style:styleID, font, bool:update = true);
native TD_SetProportional(Style:styleID, bool:set, bool:update = true);
native TD_SetTime(Style:styleID, time);
native TD_Delete(Style:styleId);
native TD_Destroy(Text:textDraw);
native Text:TD_Display(text[], Style:id);
native Text:TD_DisplayNamed(text[], style[]);
native TD_ShowForPlayer(playerid, Text:textDraw);
native TD_HideForPlayer(playerid, Text:textDraw);
native TD_ShowForAll(Text:textDraw);
native TD_HideForAll(Text:textDraw);
native TD_OnPlayerDisconnect(playerid, reason);
native TD_Garbage(Text:textDraw);
	native
*/
#if defined _YSI_CORE_TD
	#include "YSI/Core/YSI_td.own"
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
native formatex(output[], len, const format[], {Float,_}:...);
native printfex(const format[], {Float,_}:...);
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
native Command_FindByName(funcname[]);
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
native Command_SetPlayerUse(command[], playerid, set);
native Command_SetPlayerUseByID(command, playerid, set);
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
native Player_IsRegistered(playerid, &yid = -1);
	native
*/
#if defined _YSI_CORE_PLAYER
	#include "YSI/Core/YSI_player.own"
#endif

/*
native _CORE_HELP_FUNCTIONS_();
	native
native Help_Help();
	native
*/
#if defined _YSI_CORE_HELP
	#include "YSI/Core/YSI_help.own"
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
native Object_SetViewDistance(objectid, Float:view);
native Object_IsDescendant(objectid, ancestor);
native Object_GetGateArea(gate);
native Object_SetAreaGate(objectid, areaid, Float:tx, Float:ty, Float:tz, Float:ts, time = 10000)
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
native RemoveObjectFromParent(objectid);
native AttachObjectToObject(attachobject, toobject);
native CreateGate(modelid, Float:x, Float:y, Float:z, Float:tx, Float:ty, Float:tz, Float:rx = 0.0, Float:ry = 0.0, Float:rz = 0.0, Float:speed = 2.0);
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
native Race_GetPlayerRace(playerid);
	native
*/
#if defined _YSI_VISUAL_RACE
	#include "YSI/Visual/YSI_race.own"
#endif

/*
native _VISUAL_ZONE_FUNCTIONS_();
	native
native Zone_GetPlayerZone(playerid);
	native
*/
#if defined _YSI_VISUAL_ZONES
	#include "YSI/Visual/YSI_zones.own"
#endif

/*
native _VISUAL_PICKUP_FUNCTIONS_();
	native
native Pickup_Pickup();
native Pickup_Add(model, Float:x, Float:y, Float:z, respawn = 60000, destroy = -1, foot = 1, vehicle = 0);
native Pickup_Remove(pickupid);
native Pickup_Show(pickupid, show);
native Pickup_IsPlayerOnAnyPickup(playerid);
native Pickup_IsPlayerOnPickup(playerid, pickupid);
native Pickup_OnPlayerPickUpPickup(playerid, pickupid);
	native
*/
#if defined _YSI_VISUAL_PICKUPS
	#include "YSI/Visual/YSI_pickups.own"
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
native Property_OnPlayerPickUpPickup(playerid, pickupid);
native Property_GetPlayerPropCount(playerid);
native Property_GetLink(property);
native Property_GetType(property);
native Property_IsValid(property);
native Property_SetRebuyDelay(delay);
native Property_Bank(playerid, amount);
native Property_SavePlayerWeapon(playerid, weaponslot, ammo);
native Property_SaveWeapons(playerid);
native Property_SetMaxProperties(count);
native Property_ResetMaxProperties();
native Property_LoadWeapons(playerid, identifier[], text[]);
native Property_SaveBank(playerid);
native Property_LoadBank(playerid, identifier[], text[]);
native Property_GetBank(playerid);
native Property_GetSlotWeapon(playerid, slot, &weapon, &ammo);
native Property_GetPropertyBits(playerid, Bit:properties[]);
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

/*
native _GAMEMODE_CLASSES_FUNCTIONS_();
	native
native Class_AddForGroup(group, skin, Float:x, Float:y, Float:z, Float:a, weapon1, ammo1, weapon2, ammo2, weapon3, ammo3);
native Class_Add(skin, Float:x, Float:y, Float:z, Float:a, weapon1, ammo1, weapon2, ammo2, weapon3, ammo3);
native Class_AddWithGroupSet(group, skin, Float:x, Float:y, Float:z, Float:a, weapon1, ammo1, weapon2, ammo2, weapon3, ammo3);
native Class_Class();
native Class_OnPlayerRequestSpawn(playerid);
native Class_OnPlayerRequestClass(playerid, classid);
native Class_OnPlayerConnect(playerid);
native Class_OnPlayerSpawn(playerid);
native Class_SetPlayer(classid, playerid, set);
native Class_Disable(classid);
native Class_Enable(classid);
native Class_AllowReselection(allow);
native Class_RequireSpawnLogin(allow);
native Class_RequireSelectionLogin(allow);
native Class_RequireSelectionReg(allow);
native Class_RequireSpawnReg(allow);
	native
*/
#if defined _YSI_GAMEMODE_CLASSES
	#include "YSI/Gamemode/YSI_classes.own"
#endif

/*
native _GAMEMODE_LOADER_FUNCTIONS_();
	native
native Loader_Loader();
native Loader_Parse(filename[], laps = 0, entry = 0, countdown = 3, bool:arial = false, bool:fixedPrize = true, exitTime = 0, interior = 0, world = 0, bool:restart = false);
	native
*/
#if defined _YSI_GAMEMODE_LOADER
	#include "YSI/Gamemode/YSI_loader.own"
#endif

/*----------------------------------------------------------------------------*-
					==========================
					/YSI/System/ Libraries (2)
					==========================
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
native Group_Create(name[] = "");
native Group_CreateTemp();
native Group_NameGroup(group, name[]);
native Group_SetClass(group, class, set);
native Group_SetDefaultClass(class, set);
native Group_UpdatePlayerClass(class, playerid);
native Group_SetCommand(group, command[], set);
native Group_SetCommandByID(group, command, set);
native Group_SetDefaultCommandByID(command, set)
native Group_SetDefaultCommand(command[], set)
native Group_UpdatePlayerCommand(command, playerid);
native Group_SetCheckpoint(group, checkpoint, set);
native Group_SetDefaultCheckpoint(checkpoint, set)
native Group_UpdatePlayerCheckpoint(checkpoint, playerid);
native Group_SetObject(group, object, set);
native Group_SetDefaultObject(object, set)
native Group_UpdatePlayerObject(object, playerid);
native Group_SetArea(group, area, set);
native Group_SetDefaultArea(area, set)
native Group_UpdatePlayerArea(area, playerid);
native Group_AddPlayer(group, playerid);
native Group_RemovePlayer(group, playerid);
native Group_HasPlayer(group, playerid);
native Group_RemovePlayerFromAllGroups(playerid);
native Bit:Group_GetGroupMembers(group);
native Group_GetGroups(playerid);
native Group_SetGang(group, set);
native Group_GetGangGroup(playerid, last = 0);
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

/*
native _SYSTEM_CALLBACKS_FUNCTIONS_();
	native
native Callbacks_Callbacks();
native Callbacks_OnPlayerConnect(playerid);
	native
*/
#if defined _YSI_SYSTEM_CALLBACKS
	#include "YSI/System/YSI_callbacks.own"
#endif

/*----------------------------------------------------------------------------*-
					========================
					/YSI/Tracking/ Libraries
					========================
-*----------------------------------------------------------------------------*/

/*
native _TRACKING_LIVE_FUNCTIONS_();
	native
*/
#if defined _YSI_TRACKING_LIVE
	#include "YSI/Tracking/YSI_live.own"
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
