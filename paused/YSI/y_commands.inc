/*----------------------------------------------------------------------------*-
					================================
					Y Sever Includes - Commands Core
					================================
Description:
	Runs commands registered with the system and calls the required functions.
	Also handles alternate names and prefixes.  Theory based very loosely on dcmd.
Legal:
	Version: MPL 1.1
	
	The contents of this file are subject to the Mozilla Public License Version 
	1.1 (the "License"); you may not use this file except in compliance with 
	the License. You may obtain a copy of the License at 
	http://www.mozilla.org/MPL/
	
	Software distributed under the License is distributed on an "AS IS" basis,
	WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
	for the specific language governing rights and limitations under the
	License.
	
	The Original Code is the SA:MP script information include.
	
	The Initial Developer of the Original Code is Alex "Y_Less" Cole.
	Portions created by the Initial Developer are Copyright (C) 2008
	the Initial Developer. All Rights Reserved.
	
	Contributors:
		ZeeX, koolk
	
	Thanks:
		Peter, Cam - Support.
		ZeeX - Very productive conversations.
		koolk - IsPlayerinAreaEx code.
		TheAlpha - Danish translation.
		breadfish - German translation.
		Fireburn - Dutch translation.
		yom - French translation.
		50p - Polish translation.
		Zamaroht - Spanish translation.
		Dracoblue, sintax, mabako, Xtreme, other coders - Producing other modes
			for me to strive to better.
		Pixels^ - Running XScripters where the idea was born.
		Matite - Pestering me to release it and using it.
	
	Very special thanks to:
		Thiadmer - PAWN.
		Kye/Kalcor - SA:MP.
		SA:MP Team past, present and future - SA:MP.
Version:
	0.1.4
Changelog:
	06/01/08:
		Improved master and /help support.
	04/01/08:
		Fixed bad element in Command_SetDeniedReturn.
	12/08/07:
		Added master support.
	24/06/07:
		Modifed a few functions to use Bit_GetBit for speed.
	04/05/07:
		Completed command use support.
		Added invalid character protection.
	02/05/07:
		Added YSI_ prefix to all globals.
	14/04/07:
		Updated header documentation with more than changelog/functions.
		Added function name requesting.
	13/04/07:
		Added function documentation.
		Added wrapped functions for e_COMM_FLAG values missing them.
		Added header function list.
	12/04/07:
		Added command removal.
	11/04/07:
		Changed system slightly to handle names and alt names separately.  Still need
		a better way of ignoring names when alt names are used.
	10/04/07:
		First version.
Functions:
	Public:
		Command_Add - Adds a command to the array for processing.
		Command_Remove - Removes a command.
		Command_Name - Gets the name of a command in a property.
	Core:
		Command_Process - Called from OnPlayerCommandText to process entered commands.
		Command_Parse - Sorts added commands into a binary tree.
		Command_Hash - Hashes a word for command hashing.
		Command_ProcRem - Processes a help command in the master script.
	Stock:
		Command_SetDisconnectReturn - Sets the return value for unconnected players.
		Command_UseShortCuts - Toggles use of per-player command shortcuts.
		Command_SetDeniedReturn - Sets the return value for denied use commands.
		Command_UseDeniedMessage - Toggles the use of an error message for denied.
		Command_SetIllegalReturn - Sets the return value for illegal characters.
		Command_UseAltNames - Toggles the use of ini defined alternate names.
		Command_UsePrefix - Toggles the use of a global prefix.
		Command_UseSpace - Toggles the use of a space between prefix and command.
		Command_SetAltName - Sets the alternate name of a function.
		Command_SetPrefix - Sets the pfexix to be typed.
		Comamnd_SetPlayerUse - Sets wether or not a player can use a command.
		Comamnd_SetPlayerUseByID - Sets wether or not a player can use a command.
		Command_FindByName - Finds a command in a possibly sorted list.
	Static:
		Command_FindFast - Finds a function by binary search of function name.
		Command_FindAlt - Finds a function by binary search of alternate name.
		Command_SetSorted - Marks the binary tree as sorted.
		Command_FindSlow - Finds a function by linear search of function name.
		Command_Find - Finds a function from entered text.
		Command_Prefix - Checks the entered prefix.
		Command_ReturnName - Returns the name of a function.
		Command_GetPlayerCount - Gets the number of commands a player can use.
	Inline:
		Command_Command - Not used, constructor.
		Command_IsCleared - Checks a player is cleared to use a command.
		Command_DisconnectReturn - Gets the return value for disconnected players.
		Command_UsingShortCuts - Checks if short cuts are being used.
		Command_DeniedReturn - Gets the return value for prohibited commands.
		Command_IllegalReturn - Gets the return value for invalid characters.
		Command_DeniedMessage - Checks if a level error message should be sent.
		Command_IsSorted - Checks if the binary tree has been initialised.
		Command_UsingAltNames - Checks if alt names are being used.
		Command_UsingPrefix - Checks if the prefix is being used.
		Command_UsingSpace - Checks if the space option is being used.
		Command_CallFunction - Calls the required function.
		ycmd - Adds a command to the system.
	API:
		-
Callbacks:
	-
Definitions:
	MAX_COMMAND_LENGTH - The maximum length of a command string.
	COMMAND_NOT_FOUND - Indicates that a searched for string is not a function.
Enums:
	e_COMM_FLAG - Bit mappings for command options.
	E_COMMANDS - Structure of the array holding the string data.
Macros:
	Command_(%1) - Forwards and declares a standard command for calling.
	ycmd(%1) - Adds a command to the array (wrapper for Command_Add).
Tags:
	e_COMM_FLAG - Flag type.
Variables:
	Global:
		-
	Static:
		YSI_g_sCommands - Holds all the textual data of the commands.
		YSI_g_sSearchTree - Tree of hashes for function names.
		YSI_g_sAltTree - Tree of hashes for alternate names.
		YSI_g_sPrefix - The command prefix.
		YSI_g_sPrefixLength - Length of the prefix.
		YSI_g_sCommandIndex - Pointer to the next free index in the function array.
		YSI_g_sAltCount - The number of commands with altnames.
		YSI_g_sCommandFlags - Bit array of command options.
Commands:
	commands - Lists all commands available to you.
Compile options:
	_COMMANDS_SMALL - Calculates function names at call not creation (default).
	_COMMANDS_FAST - Opposite of _COMMANDS_SMALL.
-*----------------------------------------------------------------------------*/

#include <a_samp>

#include <YSI\y_debug>

#include <YSI\y_bintree>
#include <YSI\y_scripting>
#include <YSI\y_bit>
#include <YSI\y_utils>

#include <YSI\y_master>

// Define the CMD: macro.  This uses the prefix "@yC_" as it's 32 bits so allows
// for fast command string searching in the publics table and makes the commands
// public without the need for the public keyword.
#if YSIM_HAS_MASTER
	#if YSIM_IS_CLIENT
		#define YCMD:%1(%2) static stock yC@_%1(%2)
	#else
		#if YSIM_IS_SERVER
			#define YCMD:%1(%2) forward @yC_%1(a,b[],c);@yC_%1(a,b[],c)U@(8,YSIM_RETURN,yC@_%1(a,b,c));static yC@_%1(%2)
		#else
			#define YCMD:%1(%2) forward @yC_%1(a,b[],c);@yC_%1(a,b[],c)<>{}@yC_%1(a,b[],c)<_YCM:y>U@(8,YSIM_RETURN,yC@_%1(a,b,c));static yC@_%1(%2)
		#endif
	#endif
#else
	#define YCMD:%1(%2) forward @yC_%1(%2);@yC_%1(%2)
#endif

// ZCMD compatibility.
#define CMD:%1(%2) YCMD:%1(%2,help)
#define COMMAND CMD

// This is opposite Scripting_FastString as that's in C, not packed, order.
#define Commands_FastString(%1,%2,%3,%4) \
	(((%1) << 24) | ((%2) << 16) | ((%3) << 8) | ((%4) << 0))

#if !defined MAX_COMMANDS
	#define MAX_COMMANDS                (1024)
#endif

#define MAX_COMMAND_LENGTH              (32)

#define COMMAND_NOT_FOUND               (-1)

#if defined COMMAND_INSENSITIVE
	#define TOLOWER(%0) (%0)
#else
	#if defined COMMAND_ACCURATE
		#define TOLOWER(%0) tolower(%0)
	#else
		#define TOLOWER(%0) ((%0) | 0x20)
	#endif
#endif

// Don't forget the Scripting_FastString below if you change this.
#define COMMAND_FUNCTION_PREFIX         (Commands_FastString('@', 'y', 'C', '_'))

enum e_COMM_FLAG (<<= 1)
{
	e_COMM_FLAG_SORTED = 1,
	e_COMM_FLAG_PERMISSION_WARN,
	e_COMM_FLAG_USE_ALTNAMES,
	e_COMM_FLAG_PERMISSION_RET,
	e_COMM_FLAG_USE_PREFIX,
	e_COMM_FLAG_USE_SPACE,
	e_COMM_FLAG_USE_SHORTCUTS,
	e_COMM_FLAG_DISCONNECT,
	e_COMM_FLAG_ILLEGAL,
	e_COMM_FLAG_OPCT,
	e_COMM_FLAG_COLLISION
}

enum E_COMMANDS
{
	E_COMMANDS_FUNCTION[MAX_COMMAND_LENGTH char],
	BitArray:E_COMMANDS_PLAYERS<MAX_PLAYERS>,
	E_COMMANDS_FUNC_POINTER
}

static stock
	YSI_g_sCommands[MAX_COMMANDS][E_COMMANDS],
	BinaryTree:YSI_g_sSearchTree<MAX_COMMANDS>,
	e_COMM_FLAG:YSI_g_sCommandFlags,
	YSI_g_sCommandIndex,
	YSI_g_sCommandDialog[MAX_PLAYERS] = {-1, ...};

/*----------------------------------------------------------------------------*-
Function:
	Command_Name
Params:
	index - Index of the command to operate on.
Return:
	-
Notes:
	Gets the name of a function from the array.
-*----------------------------------------------------------------------------*/

#define Command_Name(%1) \
	(YSI_g_sCommands[(%1)][E_COMMANDS_FUNCTION][1])

/*----------------------------------------------------------------------------*-
Function:
	Command_GetFuncName
Params:
	index - Index of the command to operate on.
Return:
	-
Notes:
	Gets the full function name for a slot - note that this may not be the right
	function if this slot points to another one.
-*----------------------------------------------------------------------------*/

#define Command_GetFuncName(%1) \
	(YSI_g_sCommands[(%1)][E_COMMANDS_FUNCTION])

/*----------------------------------------------------------------------------*-
Function:
	Command_GetPointer
Params:
	index - Index of the command to operate on.
Return:
	-
Notes:
	Gets the pointer for a function from the array.
-*----------------------------------------------------------------------------*/

#define Command_GetPointer(%1) \
	(YSI_g_sCommands[(%1)][E_COMMANDS_FUNC_POINTER])

/*----------------------------------------------------------------------------*-
Function:
	Command_GetFunction
Params:
	index - Index of the command to operate on.
Return:
	-
Notes:
	Gets the real function for this slot.
-*----------------------------------------------------------------------------*/

#define Command_GetFunction(%1) \
	(Command_GetFuncName(Command_GetPointer((%1))))

/*----------------------------------------------------------------------------*-
Function:
	Command_CheckPlayer
Params:
	index - Index of the command to operate on.
	playerid - The player to check for.
Return:
	-
Notes:
	Gets wether a player can use a command.
-*----------------------------------------------------------------------------*/

#define Command_CheckPlayer(%1,%2) \
	(Bit_Get(YSI_g_sCommands[(%1)][E_COMMANDS_PLAYERS], (%2)))

/*----------------------------------------------------------------------------*-
Function:
	Command_DeniedReturn
Params:
	-
Return:
	e_COMM_FLAG_PERMISSION_RET
Notes:
	-
-*----------------------------------------------------------------------------*/

#define Command_DeniedReturn() \
	(YSI_g_sCommandFlags & e_COMM_FLAG_PERMISSION_RET)

/*----------------------------------------------------------------------------*-
Function:
	Command_SetDeniedReturn
Params:
	-
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

RF@v:Command_SetDeniedReturn[i](bool:set)
{
	if (set)
	{
		YSI_g_sCommandFlags |= e_COMM_FLAG_PERMISSION_RET;
	}
	else
	{
		YSI_g_sCommandFlags &= ~e_COMM_FLAG_PERMISSION_RET;
	}
}

/*----------------------------------------------------------------------------*-
Function:
	Command_GetDeniedReturn
Params:
	-
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

RF@t:bool:Command_GetDeniedReturn[]()
{
	return bool:Command_DeniedReturn();
}

/*----------------------------------------------------------------------------*-
Function:
	Command_HasCollisions
Params:
	-
Return:
	e_COMM_FLAG_COLLISION
Notes:
	-
-*----------------------------------------------------------------------------*/

#define Command_HasCollisions() \
	(YSI_g_sCommandFlags & e_COMM_FLAG_COLLISION)

/*----------------------------------------------------------------------------*-
Function:
	Command_SetCollisions
Params:
	-
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

#define Command_SetCollisions() \
	YSI_g_sCommandFlags |= e_COMM_FLAG_COLLISION

/*----------------------------------------------------------------------------*-
Function:
	Command_IllegalReturn
Params:
	-
Return:
	e_COMM_FLAG_ILLEGAL
Notes:
	-
-*----------------------------------------------------------------------------*/

#define Command_IllegalReturn() \
	(YSI_g_sCommandFlags & e_COMM_FLAG_ILLEGAL)

/*----------------------------------------------------------------------------*-
Function:
	Command_SetIllegalReturn
Params:
	-
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

RF@v:Command_SetIllegalReturn[i](bool:set)
{
	if (set)
	{
		YSI_g_sCommandFlags |= e_COMM_FLAG_ILLEGAL;
	}
	else
	{
		YSI_g_sCommandFlags &= ~e_COMM_FLAG_ILLEGAL;
	}
}

/*----------------------------------------------------------------------------*-
Function:
	Command_GetIllegalReturn
Params:
	-
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

RF@t:bool:Command_GetIllegalReturn[]()
{
	return bool:Command_IllegalReturn();
}

/*----------------------------------------------------------------------------*-
Function:
	Command_DisconnectReturn
Params:
	-
Return:
	e_COMM_FLAG_DISCONNECT
Notes:
	-
-*----------------------------------------------------------------------------*/

#define Command_DisconnectReturn() \
	(YSI_g_sCommandFlags & e_COMM_FLAG_DISCONNECT)

/*----------------------------------------------------------------------------*-
Function:
	Command_SetDisconnectReturn
Params:
	-
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

RF@v:Command_SetDisconnectReturn[i](bool:set)
{
	if (set)
	{
		YSI_g_sCommandFlags |= e_COMM_FLAG_DISCONNECT;
	}
	else
	{
		YSI_g_sCommandFlags &= ~e_COMM_FLAG_DISCONNECT;
	}
}

/*----------------------------------------------------------------------------*-
Function:
	Command_GetDisconnectReturn
Params:
	-
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

RF@t:bool:Command_GetDisconnectReturn[]()
{
	return bool:Command_DisconnectReturn();
}

/*----------------------------------------------------------------------------*-
Function:
	Command_DeniedDisplay
Params:
	-
Return:
	e_COMM_FLAG_PERMISSION_WARN
Notes:
	-
-*----------------------------------------------------------------------------*/

#define Command_DeniedDisplay() \
	(YSI_g_sCommandFlags & e_COMM_FLAG_PERMISSION_WARN)

/*----------------------------------------------------------------------------*-
Function:
	Command_SetDeniedDisplay
Params:
	-
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

RF@v:Command_SetDeniedDisplay[i](bool:set)
{
	if (set)
	{
		YSI_g_sCommandFlags |= e_COMM_FLAG_PERMISSION_WARN;
	}
	else
	{
		YSI_g_sCommandFlags &= ~e_COMM_FLAG_PERMISSION_WARN;
	}
}

/*----------------------------------------------------------------------------*-
Function:
	Command_GetDeniedDisplay
Params:
	-
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

RF@t:bool:Command_GetDeniedDisplay[]()
{
	return bool:Command_DeniedDisplay();
}

/*----------------------------------------------------------------------------*-
Function:
	Command_GetNameInt
Params:
	f - Command to get the name of.
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

/*RF:Command_GetNameInt[i](f)
{
	if (f >= 0 && f < YSI_g_sCommandIndex)
	{
		setproperty(8, "", YSIM_STRING, Command_Name(f));
		return 1;
	}
	return 0;
}*/

/*----------------------------------------------------------------------------*-
Function:
	Command_GetName
Params:
	funcid - Command to get the name of.
Return:
	-
Notes:

native Command_GetName(funcid);

-*----------------------------------------------------------------------------*/

/*stock Command_GetName(funcid)
{
	new
		buffer[33] = "";
	if (Command_GetNameInt(funcid))
	{
		getproperty(8, "", YSIM_STRING, buffer);
		strunpack(buffer, buffer);
	}
	return buffer;
}*/

/*----------------------------------------------------------------------------*-
Function:
	Command_IsSorted
Params:
	-
Return:
	e_COMM_FLAG_SORTED
Notes:
	-
-*----------------------------------------------------------------------------*/

#define Command_IsSorted() \
	(YSI_g_sCommandFlags & e_COMM_FLAG_SORTED)

/*----------------------------------------------------------------------------*-
Function:
	Command_Generate
Params:
	-
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

RF@v:Command_Generate[]()
{
	if (!Command_IsSorted())
	{
		new
			data[MAX_COMMANDS][E_BINTREE_INPUT];
		for (new i = 0; i != YSI_g_sCommandIndex; ++i)
		{
			data[i][E_BINTREE_INPUT_POINTER] = i;
			new
				hash = Command_PackHash(Command_Name(i));
			// Check for an existing command with this hash.
			if (!Command_HasCollisions())
			{
				for (new j = 0; j != i; ++j)
				{
					if (hash == data[j][E_BINTREE_INPUT_VALUE])
					{
						Command_SetCollisions();
						break;
					}
				}
			}
			data[i][E_BINTREE_INPUT_VALUE] = hash;
		}
		Bintree_Generate(YSI_g_sSearchTree, data, YSI_g_sCommandIndex);
		// Set sorted to true.
		YSI_g_sCommandFlags |= e_COMM_FLAG_SORTED;
	}
}

/*----------------------------------------------------------------------------*-
Function:
	OnScriptInit
Params:
	-
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

#if defined FILTERSCRIPT
	public OnFilterScriptInit()
#else
	public OnGameModeInit()
#endif
{
	P:1("Commands_OGM");
	// Initialise the tree.
	#if YSIM_NOT_CLIENT
		Bintree_Reset(YSI_g_sSearchTree);
	#endif
	// Loop through all the possible commands.  Note that this may need to add
	// commands to the remote command system if this is not the master system.
	// The way the master system is designed means that we will know if we are
	// master or not by the time this function is called.
	new
		buffer[33],
		idx;
	// This is the only place where Scripting_FastString is used instead of
	// Commands_FastString as the strings in the AMX are not the same as packed
	// strings - they are in different memory orders.
	while ((idx = Scripting_GetPublicFast(idx, buffer, (Scripting_FastString('@', 'y', 'C', '_')))))
	{
		Command_Add(buffer);
		P:2("Command_OnScriptInit: Adding %s", buffer);
	}
	Command_Generate();
	// Now that all commands have been added to the array, sort it.
	// Now call the next constructor.
	if (funcidx("Command_OnPlayerCommandText") != -1)
	{
		YSI_g_sCommandFlags |= e_COMM_FLAG_OPCT;
	}
	CallLocalFunction("Commands_OnScriptInit", "");
}

#if defined FILTERSCRIPT
	#if defined _ALS_OnFilterScriptInit
		#undef OnFilterScriptInit
	#else
		#define _ALS_OnFilterScriptInit
	#endif
	#define OnFilterScriptInit Commands_OnScriptInit
#else
	#if defined _ALS_OnGameModeInit
		#undef OnGameModeInit
	#else
		#define _ALS_OnGameModeInit
	#endif
	#define OnGameModeInit Commands_OnScriptInit
#endif
forward Commands_OnScriptInit();

/*----------------------------------------------------------------------------*-
Function:
	OnDialogResponse
Params:
	-
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	P:1("Commands_OGM");
	// Initialise the tree.
	#if YSIM_NOT_CLIENT
		Bintree_Reset(YSI_g_sSearchTree);
	#endif
	// Loop through all the possible commands.  Note that this may need to add
	// commands to the remote command system if this is not the master system.
	// The way the master system is designed means that we will know if we are
	// master or not by the time this function is called.
	new
		buffer[33],
		idx;
	// This is the only place where Scripting_FastString is used instead of
	// Commands_FastString as the strings in the AMX are not the same as packed
	// strings - they are in different memory orders.
	while ((idx = Scripting_GetPublicFast(idx, buffer, (Scripting_FastString('@', 'y', 'C', '_')))))
	{
		Command_Add(buffer);
		P:2("Command_OnScriptInit: Adding %s", buffer);
	}
	Command_Generate();
	// Now that all commands have been added to the array, sort it.
	// Now call the next constructor.
	if (funcidx("Command_OnPlayerCommandText") != -1)
	{
		YSI_g_sCommandFlags |= e_COMM_FLAG_OPCT;
	}
	CallLocalFunction("Commands_OnDialogResponse", "iiiis", playerid, dialogid, response, listitem, inputtext);
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif
#define OnDialogResponse Commands_OnDialogResponse
forward Commands_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);

/*----------------------------------------------------------------------------*-
Function:
	OnPlayerConnect
Params:
	-
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

public OnPlayerConnect(playerid)
{
	#if YSIM_NOT_CLIENT
		YSI_g_sCommandDialog[playerid] = -1;
		new
			slot = playerid >>> CELLSHIFT,
			Bit:mask = Bit:(1 << (playerid & (cellbits - 1)));
		for (new i = 0; i != YSI_g_sCommandIndex; ++i)
		{
			YSI_g_sCommands[i][E_COMMANDS_PLAYERS][slot] |= mask;
		}
	#endif
	// Groups will ALWAYS be called after this function - so this can reset
	// player permissions however it likes with the group system then being
	// able to override anything set in here.
	return CallLocalFunction("Commands_OnPlayerConnect", "i", playerid);
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect Commands_OnPlayerConnect
forward Commands_OnPlayerConnect(playerid);

/*----------------------------------------------------------------------------*-
Function:
	Command_
Params:
	command - Command to declare.
Return:
	-
Notes:
	Deprecated!
-*----------------------------------------------------------------------------*/

#define Command_(%1) \
	CMD:%1(playerid,params[],help)

/*----------------------------------------------------------------------------*-
Function:
	ycmd
Params:
	command[] - Command to register.
Return:
	-
Notes:
	Deprecated!
-*----------------------------------------------------------------------------*/

#define ycmd(%1);

/*----------------------------------------------------------------------------*-
Function:
	Command_FindFast
Params:
	data[] - Function name to find.
	value - Hash of function name.
Return:
	Position in functions array or COMMAND_NOT_FOUND.
Notes:
	-
-*----------------------------------------------------------------------------*/

static stock Command_FindFast(data[], value)
{
	new
		leaf,
		pointer;
	while ((pointer = Bintree_FindValue(YSI_g_sSearchTree, value, leaf)) != BINTREE_NOT_FOUND)
	{
		// Don't do an strcmp if there are no collisions.
		if (!Command_HasCollisions()) return pointer;
		if (!strcmp(Command_Name(pointer), data)) return pointer;
	}
	return COMMAND_NOT_FOUND;
}

/*----------------------------------------------------------------------------*-
Function:
	Command_AddHash
Params:
	command[] - Command text to hash.
	dest[] - Array to copy to.
	idx - Point to start copying from.
Return:
	hash value.
Notes:
	Hashes a string and copies it to a destination at the same time.
-*----------------------------------------------------------------------------*/

static stock Command_AddHash(command[], dest[], idx)
{
	// Skip the function name prefix.
	new
		hash = -1,
		ch,
		dx = 1,
		end = idx + 28;
	// Copy and hash at the same time.
	do
	{
		ch = TOLOWER(command[idx++]);
		// Always NULL terminate.
		if (!(dest[dx] = ch << 24)) break;
		hash = hash * 33 + ch; //Command_ToUpper(ch);
		ch = TOLOWER(command[idx++]);
		if (!ch) break;
		dest[dx] |= ch << 16;
		hash = hash * 33 + ch; //Command_ToUpper(ch);
		ch = TOLOWER(command[idx++]);
		if (!ch) break;
		dest[dx] |= ch << 8;
		hash = hash * 33 + ch; //Command_ToUpper(ch);
		ch = TOLOWER(command[idx++]);
		if (!ch) break;
		dest[dx] |= ch << 0;
		hash = hash * 33 + ch; //Command_ToUpper(ch);
		++dx;
	}
	while (idx < end);
	return hash;
}

/*----------------------------------------------------------------------------*-
Function:
	Command_FastHash
Params:
	command[] - Command text to hash.
Return:
	hash value.
Notes:
	Just hashes the passed string.
-*----------------------------------------------------------------------------*/

static stock Command_FastHash(command[])
{
	new
		index = 0,
		hash = -1,
		ch;
	while ((ch = command[index++])) hash = hash * 33 + TOLOWER(ch);
	return hash;
}

/*----------------------------------------------------------------------------*-
Function:
	Command_PackHash
Params:
	command[] - Command text to hash.
Return:
	hash value.
Notes:
	Hashes packed strings.
-*----------------------------------------------------------------------------*/

static stock Command_PackHash(command[])
{
	new
		index = 0,
		hash = -1,
		ch;
	while ((ch = command[index++]))
	{
		if (ch & 0xFF000000)
		{
			hash = hash * 33 + TOLOWER(ch >>> 24);
		}
		else
		{
			break;
		}
		if (ch & 0x00FF0000)
		{
			hash = hash * 33 + TOLOWER(ch >> 16 & 0xFF);
		}
		else
		{
			break;
		}
		if (ch & 0x0000FF00)
		{
			hash = hash * 33 + TOLOWER(ch >> 8 & 0xFF);
		}
		else
		{
			break;
		}
		if (ch & 0x000000FF)
		{
			hash = hash * 33 + TOLOWER(ch & 0xFF);
		}
		else
		{
			break;
		}
	}
	return hash;
}

/*----------------------------------------------------------------------------*-
Function:
	Command_Hash
Params:
	command[] - Command text to hash.
	&index - Start point and variable to store end point to.
	&length - Length of the hashed word.
Return:
	hash value.
Notes:
	Hashes a string using space delimiters and returns information such as the
	length of the string hased and the start point of the next word.
-*----------------------------------------------------------------------------*/

static stock Command_Hash(command[], &index, &length)
{
	new
		hash = -1,
		ch;
	length = index;
	while ((ch = command[index++]) > ' ') hash = hash * 33 + TOLOWER(ch);
	length = index - length - 1;
	while (ch)
	{
		if (ch > ' ')
		{
			break;
		}
		ch = command[index++];
	}
	--index;
	return hash;
}

/*----------------------------------------------------------------------------*-
Function:
	Command_Find
Params:
	function[] - Function name to find.
Return:
	Position in functions array or COMMAND_NOT_FOUND.
Notes:
	Used by API functions to avoid repeated sorting checks.
-*----------------------------------------------------------------------------*/

static stock Command_Find(function[])
{
	// Find the ID of the command.
	if (Command_IsSorted())
	{
		return Command_FindFast(function, Command_FastHash(function));
	}
	else
	{
		return Command_FindSlow(function);
	}
}

/*----------------------------------------------------------------------------*-
Function:
	Command_GetID
Params:
	function[] - Function name to find.
Return:
	The ID of the passed function.
Notes:
	-

native Command_GetID(function[])

-*----------------------------------------------------------------------------*/

RF@p:Command_GetID[s](function[])<function>
{
	return Command_Find(function);
}

/*----------------------------------------------------------------------------*-
Function:
	Command_SetPlayer
Params:
	command - Command to set for.
	playerid - Player to set.
	bool:set - Wether or not this player can use this command.
Return:
	-
Notes:
	-

native bool:Command_SetPlayer(command, playerid, bool:set);

-*----------------------------------------------------------------------------*/

RF@pt:bool:Command_SetPlayer[iii](c,p,bool:s)<c,p,s>
{
	if (c < 0 || c >= YSI_g_sCommandIndex)
	{
		// Not in range,
		return false;
	}
	Bit_Set(YSI_g_sCommands[c][E_COMMANDS_PLAYERS], p, s, bits<MAX_PLAYERS>);
	return s;
}

/*----------------------------------------------------------------------------*-
Function:
	Command_SetPlayerNamed
Params:
	funcname[] - Command to set for.
	playerid - Player to set.
	set - Wether or not this player can use this command.
Return:
	-
Notes:
	Like Command_SetPlayer but for a function name.

native bool:Command_SetPlayerNamed(funcname[], playerid, bool:set);

-*----------------------------------------------------------------------------*/

RF@pt:bool:Command_SetPlayerNamed[sii](f[],p,bool:s)<f,p,s>
{
	return Command_SetPlayer(Command_Find(f), p, s);
}

/*----------------------------------------------------------------------------*-
Function:
	Command_GetPlayer
Params:
	command - Command to get for.
	playerid - Player to get.
Return:
	Wether this player can use this command.
Notes:
	-

native bool:Command_GetPlayer(command, playerid);

-*----------------------------------------------------------------------------*/

RF@t:bool:Command_GetPlayer[ii](command, playerid)
{
	if (command < 0 || command >= YSI_g_sCommandIndex)
	{
		// Not in range,
		return false;
	}
	return bool:Command_CheckPlayer(command, playerid);
}

/*----------------------------------------------------------------------------*-
Function:
	Command_GetPlayerNamed
Params:
	funcname[] - Command to get for.
	playerid - Player to get.
Return:
	-
Notes:
	Like Command_GetPlayer but for a function name.

native bool:Command_GetPlayerNamed(funcname[], playerid);

-*----------------------------------------------------------------------------*/

RF@pt:bool:Command_GetPlayerNamed[si](func[], playerid)<func, playerid>
{
	return Command_GetPlayer(Command_Find(func), playerid);
}

/*----------------------------------------------------------------------------*-
Function:
	Command_FindSlow
Params:
	funcname[] - Function to find.
Return:
	-
Notes:
	Searches through the array for function linearly - used to set altnames
	before the data has been sorted.
-*----------------------------------------------------------------------------*/

static stock Command_FindSlow(funcname[])
{
	for (new i = 0; i != YSI_g_sCommandIndex; ++i)
	{
		if (!strcmp(YSI_g_sCommands[i][E_COMMANDS_FUNCTION][1], funcname)) return i;
	}
	return COMMAND_NOT_FOUND;
}

/*----------------------------------------------------------------------------*-
Function:
	Command_Add
Params:
	funcname[] - The function to add to the array.
Return:
	-
Notes:
	If the list of commands have already been sorted into the binary tree the
	new commands will be appended, otherwise they will just be added to the
	array.

native Command_Add(funcname[]);

-*----------------------------------------------------------------------------*/

RF@pv:Command_Add[s](funcname[])<funcname>
{
	P:2("Command_Add called");
	if (YSI_g_sCommandIndex < MAX_COMMANDS)
	{
		new
			hash = Command_AddHash(funcname, YSI_g_sCommands[YSI_g_sCommandIndex][E_COMMANDS_FUNCTION], 4);
		if (Command_IsSorted())
		{
			if (Command_FindFast(funcname[4], hash) != COMMAND_NOT_FOUND)
			{
				return;
			}
			if (!Command_HasCollisions())
			{
				// Check for an existing command with this hash.
				if (Bintree_FindValue(YSI_g_sSearchTree, hash) != BINTREE_NOT_FOUND)
				{
					Command_SetCollisions();
				}
			}
			// Command doesn't exist already - good!
			Bintree_Add(YSI_g_sSearchTree, YSI_g_sCommandIndex, hash, YSI_g_sCommandIndex);
		}
		else
		{
			if (Command_FindSlow(funcname[4]) != COMMAND_NOT_FOUND)
			{
				// Command already exists.
				return;
			}
		}
		YSI_g_sCommands[YSI_g_sCommandIndex][E_COMMANDS_FUNCTION][0] = COMMAND_FUNCTION_PREFIX;
		Bit_SetAll(YSI_g_sCommands[YSI_g_sCommandIndex][E_COMMANDS_PLAYERS], true, bits<MAX_PLAYERS>);
		YSI_g_sCommands[YSI_g_sCommandIndex][E_COMMANDS_FUNC_POINTER] = YSI_g_sCommandIndex;
		++YSI_g_sCommandIndex;
		P:2("Command_Add: Command added in %d", YSI_g_sCommandIndex - 1);
		P:4("Command_Add: %08x%08x%08x%08x", YSI_g_sCommands[YSI_g_sCommandIndex - 1][E_COMMANDS_FUNCTION][0], YSI_g_sCommands[YSI_g_sCommandIndex - 1][E_COMMANDS_FUNCTION][1], YSI_g_sCommands[YSI_g_sCommandIndex - 1][E_COMMANDS_FUNCTION][2], YSI_g_sCommands[YSI_g_sCommandIndex - 1][E_COMMANDS_FUNCTION][3]);
		C:4(new str[33];strpack(str, funcname);printf("Command_Add: %08x%08x%08x%08x", str[0], str[1], str[2], str[3]););
	}
	/*else
	{
		// Not all hope is lost - check if this command name already exists.
		if (Command_IsSorted())
		{
			new
				pos = Command_FindFast(funcname[4], Command_FastHash(funcname[4]));
			if (pos != COMMAND_NOT_FOUND)
			{
				// Found it already in the array.
				return pos;
			}
		}
		else
		{
			new
				pos = Command_FindSlow(funcname[4]);
			if (pos != COMMAND_NOT_FOUND)
			{
				// Command already exists.
				return pos;
			}
		}
	}
	return COMMAND_NOT_FOUND;*/
}

/*----------------------------------------------------------------------------*-
Function:
	Command_AddAlt
Params:
	funcidx - The function this is an alternate to.
	altname[] - The new name.
Return:
	-
Notes:
	If the list of commands have already been sorted into the binary tree the
	new commands will be appended, otherwise they will just be added to the
	array.

native Command_AddAlt(funcidx, altname[]);

-*----------------------------------------------------------------------------*/

RF@p:Command_AddAlt[is](oidx, altname[])<oidx, altname>
{
	if (oidx < 0 || oidx >= YSI_g_sCommandIndex)
	{
		return COMMAND_NOT_FOUND;
	}
	if (YSI_g_sCommandIndex < MAX_COMMANDS)
	{
		new
			hash = Command_AddHash(altname, YSI_g_sCommands[YSI_g_sCommandIndex][E_COMMANDS_FUNCTION], 0);
		if (Command_IsSorted())
		{
			// Find the function this mirrors.
			//oidx = Command_FindFast(function, Command_FastHash(function));
			new
				pos = Command_FindFast(altname, hash);
			if (pos != COMMAND_NOT_FOUND)
			{
				if (YSI_g_sCommands[pos][E_COMMANDS_FUNC_POINTER] != oidx)
				{
					// Same altname, different function.
					return COMMAND_NOT_FOUND;
				}
				return pos;
			}
			// Command doesn't exist already - good!
			Bintree_Add(YSI_g_sSearchTree, YSI_g_sCommandIndex, hash, YSI_g_sCommandIndex);
		}
		else
		{
			new
				pos = Command_FindSlow(altname);
			if (pos != COMMAND_NOT_FOUND)
			{
				if (YSI_g_sCommands[pos][E_COMMANDS_FUNC_POINTER] != oidx)
				{
					// Same altname, different function.
					return COMMAND_NOT_FOUND;
				}
				// Command already exists.
				return pos;
			}
		}
		YSI_g_sCommands[YSI_g_sCommandIndex][E_COMMANDS_FUNCTION][0] = COMMAND_FUNCTION_PREFIX;
		Bit_SetAll(YSI_g_sCommands[YSI_g_sCommandIndex][E_COMMANDS_PLAYERS], true, bits<MAX_PLAYERS>);
		// Point to the original function.
		YSI_g_sCommands[YSI_g_sCommandIndex][E_COMMANDS_FUNC_POINTER] = oidx;
		return YSI_g_sCommandIndex++;
	}
	else
	{
		// Not all hope is lost - check if this command name already exists.
		new
			pos;
		if (Command_IsSorted())
		{
			pos = Command_FindFast(altname, Command_FastHash(altname));
		}
		else
		{
			pos = Command_FindSlow(altname);
		}
		if (pos != COMMAND_NOT_FOUND)
		{
			// Found it already in the array.  Check if the element it points to
			// has the correct name so we know this is the correct pair, not
			// just the correct single element.
			if (oidx == Command_GetPointer(pos))
			{
				return pos;
			}
		}
	}
	return COMMAND_NOT_FOUND;
}

/*----------------------------------------------------------------------------*-
Function:
	Command_AddAltNamed
Params:
	function[] - The function this is an alternate to.
	altname[] - The new name.
Return:
	-
Notes:
	Add an alternate command for an existing command.

native Command_AddAltNamed(function[], altname[]);

-*----------------------------------------------------------------------------*/

RF@p:Command_AddAltNamed[ss](function[], altname[])<function, altname>
{
	return Command_AddAlt(Command_Find(function), altname);
}

/*----------------------------------------------------------------------------*-
Function:
	Command_Debug
Params:
	-
Return:
	-
Notes:
	Print some random information about commands if _DEBUG is set.
-*----------------------------------------------------------------------------*/

stock Command_Debug()
{
	#if _DEBUG > 0
		for (new i = 0; i != YSI_g_sCommandIndex; ++i)
		{
			new buffer[MAX_COMMAND_LENGTH];
			strunpack(buffer, Command_Name(i));
			new pointer = YSI_g_sCommands[i][E_COMMANDS_FUNC_POINTER];
			printf("Command %d:", i);
			printf("\t%s", buffer);
			printf("\t%d", pointer);
			CallLocalFunction(YSI_g_sCommands[pointer][E_COMMANDS_FUNCTION], "isi", 0, "hi", 0);
		}
	#endif
}

/*----------------------------------------------------------------------------*-
Function:
	OnPlayerCommandText
Params:
	playerid - Player who entered the command.
	cmdtext[] - Text entered.
Return:
	true - success or hidden fail, false - fail.
Notes:
	Calls the Command_Process function if this is not a client.
-*----------------------------------------------------------------------------*/

public OnPlayerCommandText(playerid, cmdtext[])
{
	#if YSIM_NOT_CLIENT
		if (Command_Process(playerid, cmdtext, 0))
		{
			return 1;
		}
	#endif
	if (YSI_g_sCommandFlags & e_COMM_FLAG_OPCT)
	{
		return CallLocalFunction("Command_OnPlayerCommandText", "is", playerid, cmdtext);
	}
	return 0;
}

#if defined _ALS_OnPlayerCommandText
	#undef OnPlayerCommandText
#else
	#define _ALS_OnPlayerCommandText
#endif
#define OnPlayerCommandText Command_OnPlayerCommandText
forward Command_OnPlayerCommandText(playerid, cmdtext[]);

#define Command_Call(%1,%2) \
	CallRemoteFunction(Command_GetFunction((%1)), "isi", playerid, %2, help)

/*----------------------------------------------------------------------------*-
Function:
	Command_ReProcess
Params:
	playerid - Player who entered the command.
	cmdtext[] - Text entered.
	help - Called from the help commmand or OnPlayerCommandText.
Return:
	true - success or hidden fail, false - fail.
Notes:
	-
-*----------------------------------------------------------------------------*/

RF@p:Command_ReProcess[isi](p,c[],h)<p,c,h>
{
	return Command_Process(p,c,h);
}

/*----------------------------------------------------------------------------*-
Function:
	Command_Process
Params:
	playerid - Player who entered the command.
	cmdtext[] - Text entered.
	help - Called from the help commmand or OnPlayerCommandText.
Return:
	true - success or hidden fail, false - fail.
Notes:
	-
-*----------------------------------------------------------------------------*/

#if YSIM_HAS_MASTER
	#if YSIM_IS_CLIENT
		static stock _Command_Process(playerid, cmdtext[], help)
	#else
		#if YSIM_IS_SERVER
			static Command_Process(playerid, cmdtext[], help)
		#else
			static Command_Process(playerid, cmdtext[], help) <>
			{
				#pragma unused playerid, cmdtext, help
				return 0;
			}
			
			static Command_Process(playerid, cmdtext[], help) <_YCM:y>
		#endif
	#endif
#else
	static Command_Process(playerid, cmdtext[], help)
#endif
{
	// Support for very old problems!
	// TODO: Add back.
	P:2("Command_Process called: %d %s", playerid, cmdtext);
	if (!IsPlayerConnected(playerid))
	{
		return Command_DisconnectReturn();
	}
	P:4("Command_Process: Connected");
	new
		idx,
		prelen = 1,
		index = prelen;
	/*// Shortcuts.
	if (cmdtext[2] <= ' ')
	{
		// Get a player's shortcut information for this letter.
	}
	else*/
	{
		// No more faffing about with random alternate code - it's all done in
		// one nice function instead of having to handle both separately.
		new
			length,
			hash = Command_Hash(cmdtext, index, length);
		// NOTE: No prefix support here.
		cmdtext[length + prelen] = '\0';
		idx = Command_FindFast(cmdtext[prelen], hash);
		// TODO: Replace!
		//idx = Command_FindSlow(cmdtext[prelen]);//, hash);
	}
	if (idx != COMMAND_NOT_FOUND)
	{
		P:4("Command_Process: Found %d", idx);
		// Found a command with this name - check the permissions.
		//if (Bit_Get(YSI_g_sCommands[idx][E_COMMANDS_PLAYERS], playerid))
		if (Command_CheckPlayer(idx, playerid))
		{
			P:4("Command_Process: Allowed");
			// Allowed to use the command, get the real function.  Note that
			// this may well be the same as "idx", but we loose no time.
			#if YSIM_HAS_MASTER
				P:4("Command_Process: %08x%08x%08x%08x", YSI_g_sCommands[idx][E_COMMANDS_FUNCTION][0], YSI_g_sCommands[idx][E_COMMANDS_FUNCTION][1], YSI_g_sCommands[idx][E_COMMANDS_FUNCTION][2], YSI_g_sCommands[idx][E_COMMANDS_FUNCTION][3]);
				if (cmdtext[index])
				{
					// Call it!
					Command_Call(idx, cmdtext[index]);
				}
				else
				{
					Command_Call(idx, NULL);
				}
				// Get the real return.
				return getproperty(8, YSIM_RETURN);
			#else
				if (cmdtext[index])
				{
					// Call it!
					return Command_Call(idx, cmdtext[index]);
				}
				else
				{
					return Command_Call(idx, NULL);
				}
			#endif
		}
		else
		{
			return Command_DeniedReturn();
		}
	}
	return 0;
}

/*----------------------------------------------------------------------------*-
Function:
	Command_GetName
Params:
	funcid - Command to get the name of.
Return:
	-
Notes:

native Command_GetName(funcid);

-*----------------------------------------------------------------------------*/

RS:Command_GetName[i](funcid)
{
	new
		buffer[64] = "";
	if (funcid >= 0 && funcid < YSI_g_sCommandIndex)
	{
		strunpack(buffer, Command_Name(funcid));
	}
	return buffer;
}

/*----------------------------------------------------------------------------*-
Function:
	Command_GetDisplay
Params:
	f - Command to get the real name of.
	p - Player to get the name for.
Return:
	The name of a command for a single player.
Notes:
	-

native Command_GetDisplay(funcid, playerid);

-*----------------------------------------------------------------------------*/

RS:Command_GetDisplay[ii](funcid, playerid)
{
	new
		buffer[64] = "";
	if (funcid >= 0 && funcid < YSI_g_sCommandIndex)
	{
		// Don't recalculate this every loop.
		new
			slot = playerid >>> CELLSHIFT,
			Bit:mask = Bit:(1 << (playerid & (cellbits - 1)));
		// Check if they can use the original version.
		if (YSI_g_sCommands[funcid][E_COMMANDS_PLAYERS][slot] & mask)
		{
			//setproperty(8, "", YSIM_STRING, Command_Name(f));
			strunpack(buffer, Command_Name(funcid));
			return buffer;
			//return 1;
		}
		// Search for a command pointing to that command which the player can use.
		for (new i = 0; i != YSI_g_sCommandIndex; ++i)
		{
			if (Command_GetPointer(i) == funcid && (YSI_g_sCommands[i][E_COMMANDS_PLAYERS][slot] & mask))
			{
				//setproperty(8, "", YSIM_STRING, Command_Name(i));
				strunpack(buffer, Command_Name(i));
				return buffer;
			}
		}
	}
	return buffer;
}

/*----------------------------------------------------------------------------*-
Function:
	Command_GetDisplayNamed
Params:
	f[] - Command to get the real name of.
	p - Player to get the name for.
Return:
	The name of a named function for one player.
Notes:
	Remote function call for Command_GetDisplayNameNamed - avoids needing to
	expose users to the master system's odd way of returning strings.  This is
	the only part I've not yet fixed up to be nice and hidden.

native Command_GetDisplayNamed(funcid[], playerid);

-*----------------------------------------------------------------------------*/

RS@p:Command_GetDisplayNamed[si](func[], playerid)<func, playerid>
{
	P:1("Command_GetDisplayNamed called %d", _@);
	new
		pointer = Command_Find(func),
		buffer[64] = "";
	if (pointer != COMMAND_NOT_FOUND)
	{
		// Don't recalculate this every loop.
		new
			slot = playerid >>> CELLSHIFT,
			Bit:mask = Bit:(1 << (playerid & (cellbits - 1)));
		// Check if they can use the original version.
		if (YSI_g_sCommands[pointer][E_COMMANDS_PLAYERS][slot] & mask)
		{
			//setproperty(8, "", YSIM_STRING, Command_Name(pointer));
			strunpack(buffer, Command_Name(pointer));
			return buffer;
		}
		// Search for a command pointing to that command which the player can use.
		for (new i = 0; i != YSI_g_sCommandIndex; ++i)
		{
			if (Command_GetPointer(i) == pointer && (YSI_g_sCommands[i][E_COMMANDS_PLAYERS][slot] & mask))
			{
				//setproperty(8, "", YSIM_STRING, Command_Name(i));
				strunpack(buffer, Command_Name(i));
				return buffer;
			}
		}
	}
	return buffer;
}

/*----------------------------------------------------------------------------*-
Function:
	Command_GetPlayerCommandCount
Params:
	playerid - Player to count for.
Return:
	-
Notes:
	Gets the number of comamnds this player can use.

native Command_GetPlayerCommandCount(playerid);

-*----------------------------------------------------------------------------*/

RF:Command_GetPlayerCommandCount[i](playerid)
{
	new
		slot = playerid >>> CELLSHIFT,
		Bit:mask = Bit:(1 << (playerid & (cellbits - 1))),
		count = 0;
	for (new i = 0; i != YSI_g_sCommandIndex; ++i)
	{
		if (YSI_g_sCommands[i][E_COMMANDS_PLAYERS][slot] & mask)
		{
			++count;
		}
	}
	return count;
}

/*----------------------------------------------------------------------------*-
Function:
	Command_GetNext
Params:
	index - Index of the next command for this player.
	playerid - Player to get the name for.
Return:
	The name of a command for a single player.
Notes:
	-

native Command_GetNext(index, playerid);

-*----------------------------------------------------------------------------*/

RS:Command_GetNext[ii](index, playerid)
{
	new
		buffer[64] = "";
	if (index >= 0 && index < YSI_g_sCommandIndex)
	{
		// Don't recalculate this every loop.
		new
			slot = playerid >>> CELLSHIFT,
			Bit:mask = Bit:(1 << (playerid & (cellbits - 1)));
		for (new i = 0; i != YSI_g_sCommandIndex; ++i)
		{
			if (YSI_g_sCommands[i][E_COMMANDS_PLAYERS][slot] & mask)
			{
				if (index)
				{
					--index;
				}
				else
				{
					strunpack(buffer, Command_Name(i));
					return buffer;
				}
			}
		}
	}
	return buffer;
}

#tryinclude <YSI\y_groups>

#undef _YCM
