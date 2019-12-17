/*----------------------------------------------------------------------------*-
					==============================
					 y_hooks - Hook any callback!
					==============================
Description:
	Automatically hooks any callbacks with a very simple syntax.
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
	1.0
Changelog:
	06/08/10:
		First version
-*----------------------------------------------------------------------------*/

#include <YSI\y_scripting>

#define Hook:%1_On%2(%3) forward %1_@%2(%3); public %1_@%2(%3)

/*----------------------------------------------------------------------------*-
Function:
	Hooks_GenFuncList
Params:
	-
Return:
	-
Notes:
	Generates a set of data describing every callback for speed later.
-*----------------------------------------------------------------------------*/

static
	gs_hasGameModeInit,
	gs_hasGameModeExit,
	gs_hasFilterScriptInit,
	gs_hasFilterScriptExit,
	gs_hasPlayerConnect,
	gs_hasPlayerDisconnect,
	gs_hasPlayerSpawn,
	gs_hasPlayerDeath,
	gs_hasVehicleSpawn,
	gs_hasVehicleDeath,
	gs_hasPlayerText,
	gs_hasPlayerCommandText,
	gs_hasPlayerRequestClass,
	gs_hasPlayerEnterVehicle,
	gs_hasPlayerExitVehicle,
	gs_hasPlayerStateChange,
	gs_hasPlayerEnterCheckpoint,
	gs_hasPlayerLeaveCheckpoint,
	gs_hasPlayerEnterRaceCheckpoint,
	gs_hasPlayerLeaveRaceCheckpoint,
	gs_hasRconCommand,
	gs_hasPlayerRequestSpawn,
	gs_hasObjectMoved,
	gs_hasPlayerObjectMoved,
	gs_hasPlayerPickUpPickup,
	gs_hasVehicleMod,
	gs_hasEnterExitModShop,
	gs_hasVehiclePaintjob,
	gs_hasVehicleRespray,
	gs_hasVehicleDamageStatusUpdate,
	gs_hasPlayerSelectedMenuRow,
	gs_hasPlayerExitedMenu,
	gs_hasPlayerInteriorChange,
	gs_hasPlayerKeyStateChange,
	gs_hasRconLoginAttempt,
	gs_hasPlayerUpdate,
	gs_hasPlayerStreamIn,
	gs_hasPlayerStreamOut,
	gs_hasVehicleStreamIn,
	gs_hasVehicleStreamOut,
	gs_hasDialogResponse;

static
	gs_hasCallbacks,
	gs_hasCallbacks1;

static Scripting_GenFuncList()
{
	// Check for old style hooks.
	if (funcidx("S@@@_GameModeInit") != -1)
	{
		gs_hasCallbacks |= 0x00000001;
	}
	if (funcidx("S@@@_GameModeExit") != -1)
	{
		gs_hasCallbacks |= 0x00000002;
	}
	if (funcidx("S@@@_FilterScriptInit") != -1)
	{
		gs_hasCallbacks |= 0x00000004;
	}
	if (funcidx("S@@@_FilterScriptExit") != -1)
	{
		gs_hasCallbacks |= 0x00000008;
	}
	if (funcidx("S@@@_PlayerConnect") != -1)
	{
		gs_hasCallbacks |= 0x00000010;
	}
	if (funcidx("S@@@_PlayerDisconnect") != -1)
	{
		gs_hasCallbacks |= 0x00000020;
	}
	if (funcidx("S@@@_PlayerSpawn") != -1)
	{
		gs_hasCallbacks |= 0x00000040;
	}
	if (funcidx("S@@@_PlayerDeath") != -1)
	{
		gs_hasCallbacks |= 0x00000080;
	}
	if (funcidx("S@@@_VehicleSpawn") != -1)
	{
		gs_hasCallbacks |= 0x00000100;
	}
	if (funcidx("S@@@_VehicleDeath") != -1)
	{
		gs_hasCallbacks |= 0x00000200;
	}
	if (funcidx("S@@@_PlayerText") != -1)
	{
		gs_hasCallbacks |= 0x00000400;
	}
	if (funcidx("S@@@_PlayerCommandText") != -1)
	{
		gs_hasCallbacks |= 0x00000800;
	}
	if (funcidx("S@@@_PlayerRequestClass") != -1)
	{
		gs_hasCallbacks |= 0x00001000;
	}
	if (funcidx("S@@@_PlayerEnterVehicle") != -1)
	{
		gs_hasCallbacks |= 0x00002000;
	}
	if (funcidx("S@@@_PlayerExitVehicle") != -1)
	{
		gs_hasCallbacks |= 0x00004000;
	}
	if (funcidx("S@@@_PlayerStateChange") != -1)
	{
		gs_hasCallbacks |= 0x00008000;
	}
	if (funcidx("S@@@_PlayerEnterCheckpoint") != -1)
	{
		gs_hasCallbacks |= 0x00010000;
	}
	if (funcidx("S@@@_PlayerLeaveCheckpoint") != -1)
	{
		gs_hasCallbacks |= 0x00020000;
	}
	if (funcidx("S@@@_PlayerEnterRaceCheckpoint") != -1)
	{
		gs_hasCallbacks |= 0x00040000;
	}
	if (funcidx("S@@@_PlayerLeaveRaceCheckpoint") != -1)
	{
		gs_hasCallbacks |= 0x00080000;
	}
	if (funcidx("S@@@_RconCommand") != -1)
	{
		gs_hasCallbacks |= 0x00100000;
	}
	if (funcidx("S@@@_PlayerRequestSpawn") != -1)
	{
		gs_hasCallbacks |= 0x00200000;
	}
	if (funcidx("S@@@_ObjectMoved") != -1)
	{
		gs_hasCallbacks |= 0x00400000;
	}
	if (funcidx("S@@@_PlayerObjectMoved") != -1)
	{
		gs_hasCallbacks |= 0x00800000;
	}
	if (funcidx("S@@@_PlayerPickUpPickup") != -1)
	{
		gs_hasCallbacks |= 0x01000000;
	}
	if (funcidx("S@@@_VehicleMod") != -1)
	{
		gs_hasCallbacks |= 0x02000000;
	}
	if (funcidx("S@@@_EnterExitModShop") != -1)
	{
		gs_hasCallbacks |= 0x04000000;
	}
	if (funcidx("S@@@_VehiclePaintjob") != -1)
	{
		gs_hasCallbacks |= 0x08000000;
	}
	if (funcidx("S@@@_VehicleRespray") != -1)
	{
		gs_hasCallbacks |= 0x10000000;
	}
	if (funcidx("S@@@_VehicleDamageStatusUpdate") != -1)
	{
		gs_hasCallbacks |= 0x20000000;
	}
	if (funcidx("S@@@_PlayerSelectedMenuRow") != -1)
	{
		gs_hasCallbacks |= 0x40000000;
	}
	if (funcidx("S@@@_PlayerExitedMenu") != -1)
	{
		gs_hasCallbacks |= 0x80000000;
	}
	if (funcidx("S@@@_PlayerInteriorChange") != -1)
	{
		gs_hasCallbacks1 |= 0x00000001;
	}
	if (funcidx("S@@@_PlayerKeyStateChange") != -1)
	{
		gs_hasCallbacks1 |= 0x00000002;
	}
	if (funcidx("S@@@_RconLoginAttempt") != -1)
	{
		gs_hasCallbacks1 |= 0x00000004;
	}
	if (funcidx("S@@@_PlayerUpdate") != -1)
	{
		gs_hasCallbacks1 |= 0x00000008;
	}
	if (funcidx("S@@@_PlayerStreamIn") != -1)
	{
		gs_hasCallbacks1 |= 0x00000010;
	}
	if (funcidx("S@@@_PlayerStreamOut") != -1)
	{
		gs_hasCallbacks1 |= 0x00000020;
	}
	if (funcidx("S@@@_VehicleStreamIn") != -1)
	{
		gs_hasCallbacks1 |= 0x00000040;
	}
	if (funcidx("S@@@_VehicleStreamOut") != -1)
	{
		gs_hasCallbacks1 |= 0x00000080;
	}
	if (funcidx("S@@@_DialogResponse") != -1)
	{
		gs_hasCallbacks1 |= 0x00000100;
	}
	// Check for new style hooks.  This gets the bounds of functions, to make
	// later calls very slightly faster!
	new
		buffer[33],
		lst,
		nxt;
	// OnGameModeInit
	lst = Scripting_GetPublic(0, buffer, "_@GameModeInit");
	if (lst)
	{
		gs_hasGameModeInit = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@GameModeInit")))
		{
			lst = nxt;
		}
		gs_hasGameModeInit |= lst << 16;
	}
	else
	{
		gs_hasGameModeInit = 0;
	}
	// OnGameModeExit
	lst = Scripting_GetPublic(0, buffer, "_@GameModeExit");
	if (lst)
	{
		gs_hasGameModeExit = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@GameModeExit")))
		{
			lst = nxt;
		}
		gs_hasGameModeExit |= lst << 16;
	}
	else
	{
		gs_hasGameModeExit = 0;
	}
	// OnFilterScriptInit
	lst = Scripting_GetPublic(0, buffer, "_@FilterScriptInit");
	if (lst)
	{
		gs_hasFilterScriptInit = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@FilterScriptInit")))
		{
			lst = nxt;
		}
		gs_hasFilterScriptInit |= lst << 16;
	}
	else
	{
		gs_hasFilterScriptInit = 0;
	}
	// OnFilterScriptExit
	lst = Scripting_GetPublic(0, buffer, "_@FilterScriptExit");
	if (lst)
	{
		gs_hasFilterScriptExit = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@FilterScriptExit")))
		{
			lst = nxt;
		}
		gs_hasFilterScriptExit |= lst << 16;
	}
	else
	{
		gs_hasFilterScriptExit = 0;
	}
	// OnPlayerConnect
	lst = Scripting_GetPublic(0, buffer, "_@PlayerConnect");
	if (lst)
	{
		gs_hasPlayerConnect = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerConnect")))
		{
			lst = nxt;
		}
		gs_hasPlayerConnect |= lst << 16;
	}
	else
	{
		gs_hasPlayerConnect = 0;
	}
	// OnPlayerDisconnect
	lst = Scripting_GetPublic(0, buffer, "_@PlayerDisconnect");
	if (lst)
	{
		gs_hasPlayerDisconnect = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerDisconnect")))
		{
			lst = nxt;
		}
		gs_hasPlayerDisconnect |= lst << 16;
	}
	else
	{
		gs_hasPlayerDisconnect = 0;
	}
	// OnPlayerSpawn
	lst = Scripting_GetPublic(0, buffer, "_@PlayerSpawn");
	if (lst)
	{
		gs_hasPlayerSpawn = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerSpawn")))
		{
			lst = nxt;
		}
		gs_hasPlayerSpawn |= lst << 16;
	}
	else
	{
		gs_hasPlayerSpawn = 0;
	}
	// OnPlayerDeath
	lst = Scripting_GetPublic(0, buffer, "_@PlayerDeath");
	if (lst)
	{
		gs_hasPlayerDeath = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerDeath")))
		{
			lst = nxt;
		}
		gs_hasPlayerDeath |= lst << 16;
	}
	else
	{
		gs_hasPlayerDeath = 0;
	}
	// OnVehicleSpawn
	lst = Scripting_GetPublic(0, buffer, "_@VehicleSpawn");
	if (lst)
	{
		gs_hasVehicleSpawn = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@VehicleSpawn")))
		{
			lst = nxt;
		}
		gs_hasVehicleSpawn |= lst << 16;
	}
	else
	{
		gs_hasVehicleSpawn = 0;
	}
	// OnVehicleDeath
	lst = Scripting_GetPublic(0, buffer, "_@VehicleDeath");
	if (lst)
	{
		gs_hasVehicleDeath = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@VehicleDeath")))
		{
			lst = nxt;
		}
		gs_hasVehicleDeath |= lst << 16;
	}
	else
	{
		gs_hasVehicleDeath = 0;
	}
	// OnPlayerText
	lst = Scripting_GetPublic(0, buffer, "_@PlayerText");
	if (lst)
	{
		gs_hasPlayerText = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerText")))
		{
			lst = nxt;
		}
		gs_hasPlayerText |= lst << 16;
	}
	else
	{
		gs_hasPlayerText = 0;
	}
	// OnPlayerCommandText
	lst = Scripting_GetPublic(0, buffer, "_@PlayerCommandText");
	if (lst)
	{
		gs_hasPlayerCommandText = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerCommandText")))
		{
			lst = nxt;
		}
		gs_hasPlayerCommandText |= lst << 16;
	}
	else
	{
		gs_hasPlayerCommandText = 0;
	}
	// OnPlayerRequestClass
	lst = Scripting_GetPublic(0, buffer, "_@PlayerRequestClass");
	if (lst)
	{
		gs_hasPlayerRequestClass = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerRequestClass")))
		{
			lst = nxt;
		}
		gs_hasPlayerRequestClass |= lst << 16;
	}
	else
	{
		gs_hasPlayerRequestClass = 0;
	}
	// OnPlayerEnterVehicle
	lst = Scripting_GetPublic(0, buffer, "_@PlayerEnterVehicle");
	if (lst)
	{
		gs_hasPlayerEnterVehicle = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerEnterVehicle")))
		{
			lst = nxt;
		}
		gs_hasPlayerEnterVehicle |= lst << 16;
	}
	else
	{
		gs_hasPlayerEnterVehicle = 0;
	}
	// OnPlayerExitVehicle
	lst = Scripting_GetPublic(0, buffer, "_@PlayerExitVehicle");
	if (lst)
	{
		gs_hasPlayerExitVehicle = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerExitVehicle")))
		{
			lst = nxt;
		}
		gs_hasPlayerExitVehicle |= lst << 16;
	}
	else
	{
		gs_hasPlayerExitVehicle = 0;
	}
	// OnPlayerStateChange
	lst = Scripting_GetPublic(0, buffer, "_@PlayerStateChange");
	if (lst)
	{
		gs_hasPlayerStateChange = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerStateChange")))
		{
			lst = nxt;
		}
		gs_hasPlayerStateChange |= lst << 16;
	}
	else
	{
		gs_hasPlayerStateChange = 0;
	}
	// OnPlayerEnterCheckpoint
	lst = Scripting_GetPublic(0, buffer, "_@PlayerEnterCheckpoint");
	if (lst)
	{
		gs_hasPlayerEnterCheckpoint = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerEnterCheckpoint")))
		{
			lst = nxt;
		}
		gs_hasPlayerEnterCheckpoint |= lst << 16;
	}
	else
	{
		gs_hasPlayerEnterCheckpoint = 0;
	}
	// OnPlayerLeaveCheckpoint
	lst = Scripting_GetPublic(0, buffer, "_@PlayerLeaveCheckpoint");
	if (lst)
	{
		gs_hasPlayerLeaveCheckpoint = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerLeaveCheckpoint")))
		{
			lst = nxt;
		}
		gs_hasPlayerLeaveCheckpoint |= lst << 16;
	}
	else
	{
		gs_hasPlayerLeaveCheckpoint = 0;
	}
	// OnPlayerEnterRaceCheckpoint
	lst = Scripting_GetPublic(0, buffer, "_@PlayerEnterRaceCheckpoint");
	if (lst)
	{
		gs_hasPlayerEnterRaceCheckpoint = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerEnterRaceCheckpoint")))
		{
			lst = nxt;
		}
		gs_hasPlayerEnterRaceCheckpoint |= lst << 16;
	}
	else
	{
		gs_hasPlayerEnterRaceCheckpoint = 0;
	}
	// OnPlayerLeaveRaceCheckpoint
	lst = Scripting_GetPublic(0, buffer, "_@PlayerLeaveRaceCheckpoint");
	if (lst)
	{
		gs_hasPlayerLeaveRaceCheckpoint = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerLeaveRaceCheckpoint")))
		{
			lst = nxt;
		}
		gs_hasPlayerLeaveRaceCheckpoint |= lst << 16;
	}
	else
	{
		gs_hasPlayerLeaveRaceCheckpoint = 0;
	}
	// OnRconCommand
	lst = Scripting_GetPublic(0, buffer, "_@RconCommand");
	if (lst)
	{
		gs_hasRconCommand = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@RconCommand")))
		{
			lst = nxt;
		}
		gs_hasRconCommand |= lst << 16;
	}
	else
	{
		gs_hasRconCommand = 0;
	}
	// OnPlayerRequestSpawn
	lst = Scripting_GetPublic(0, buffer, "_@PlayerRequestSpawn");
	if (lst)
	{
		gs_hasPlayerRequestSpawn = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerRequestSpawn")))
		{
			lst = nxt;
		}
		gs_hasPlayerRequestSpawn |= lst << 16;
	}
	else
	{
		gs_hasPlayerRequestSpawn = 0;
	}
	// OnObjectMoved
	lst = Scripting_GetPublic(0, buffer, "_@ObjectMoved");
	if (lst)
	{
		gs_hasObjectMoved = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@ObjectMoved")))
		{
			lst = nxt;
		}
		gs_hasObjectMoved |= lst << 16;
	}
	else
	{
		gs_hasObjectMoved = 0;
	}
	// OnPlayerObjectMoved
	lst = Scripting_GetPublic(0, buffer, "_@PlayerObjectMoved");
	if (lst)
	{
		gs_hasPlayerObjectMoved = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerObjectMoved")))
		{
			lst = nxt;
		}
		gs_hasPlayerObjectMoved |= lst << 16;
	}
	else
	{
		gs_hasPlayerObjectMoved = 0;
	}
	// OnPlayerPickUpPickup
	lst = Scripting_GetPublic(0, buffer, "_@PlayerPickUpPickup");
	if (lst)
	{
		gs_hasPlayerPickUpPickup = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerPickUpPickup")))
		{
			lst = nxt;
		}
		gs_hasPlayerPickUpPickup |= lst << 16;
	}
	else
	{
		gs_hasPlayerPickUpPickup = 0;
	}
	// OnVehicleMod
	lst = Scripting_GetPublic(0, buffer, "_@VehicleMod");
	if (lst)
	{
		gs_hasVehicleMod = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@VehicleMod")))
		{
			lst = nxt;
		}
		gs_hasVehicleMod |= lst << 16;
	}
	else
	{
		gs_hasVehicleMod = 0;
	}
	// OnEnterExitModShop
	lst = Scripting_GetPublic(0, buffer, "_@EnterExitModShop");
	if (lst)
	{
		gs_hasEnterExitModShop = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@EnterExitModShop")))
		{
			lst = nxt;
		}
		gs_hasEnterExitModShop |= lst << 16;
	}
	else
	{
		gs_hasEnterExitModShop = 0;
	}
	// OnVehiclePaintjob
	lst = Scripting_GetPublic(0, buffer, "_@VehiclePaintjob");
	if (lst)
	{
		gs_hasVehiclePaintjob = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@VehiclePaintjob")))
		{
			lst = nxt;
		}
		gs_hasVehiclePaintjob |= lst << 16;
	}
	else
	{
		gs_hasVehiclePaintjob = 0;
	}
	// OnVehicleRespray
	lst = Scripting_GetPublic(0, buffer, "_@VehicleRespray");
	if (lst)
	{
		gs_hasVehicleRespray = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@VehicleRespray")))
		{
			lst = nxt;
		}
		gs_hasVehicleRespray |= lst << 16;
	}
	else
	{
		gs_hasVehicleRespray = 0;
	}
	// OnVehicleDamageStatusUpdate
	lst = Scripting_GetPublic(0, buffer, "_@VehicleDamageStatusUpdate");
	if (lst)
	{
		gs_hasVehicleDamageStatusUpdate = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@VehicleDamageStatusUpdate")))
		{
			lst = nxt;
		}
		gs_hasVehicleDamageStatusUpdate |= lst << 16;
	}
	else
	{
		gs_hasVehicleDamageStatusUpdate = 0;
	}
	// OnPlayerSelectedMenuRow
	lst = Scripting_GetPublic(0, buffer, "_@PlayerSelectedMenuRow");
	if (lst)
	{
		gs_hasPlayerSelectedMenuRow = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerSelectedMenuRow")))
		{
			lst = nxt;
		}
		gs_hasPlayerSelectedMenuRow |= lst << 16;
	}
	else
	{
		gs_hasPlayerSelectedMenuRow = 0;
	}
	// OnPlayerExitedMenu
	lst = Scripting_GetPublic(0, buffer, "_@PlayerExitedMenu");
	if (lst)
	{
		gs_hasPlayerExitedMenu = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerExitedMenu")))
		{
			lst = nxt;
		}
		gs_hasPlayerExitedMenu |= lst << 16;
	}
	else
	{
		gs_hasPlayerExitedMenu = 0;
	}
	// OnPlayerInteriorChange
	lst = Scripting_GetPublic(0, buffer, "_@PlayerInteriorChange");
	if (lst)
	{
		gs_hasPlayerInteriorChange = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerInteriorChange")))
		{
			lst = nxt;
		}
		gs_hasPlayerInteriorChange |= lst << 16;
	}
	else
	{
		gs_hasPlayerInteriorChange = 0;
	}
	// OnPlayerKeyStateChange
	lst = Scripting_GetPublic(0, buffer, "_@PlayerKeyStateChange");
	if (lst)
	{
		gs_hasPlayerKeyStateChange = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerKeyStateChange")))
		{
			lst = nxt;
		}
		gs_hasPlayerKeyStateChange |= lst << 16;
	}
	else
	{
		gs_hasPlayerKeyStateChange = 0;
	}
	// OnRconLoginAttempt
	lst = Scripting_GetPublic(0, buffer, "_@RconLoginAttempt");
	if (lst)
	{
		gs_hasRconLoginAttempt = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@RconLoginAttempt")))
		{
			lst = nxt;
		}
		gs_hasRconLoginAttempt |= lst << 16;
	}
	else
	{
		gs_hasRconLoginAttempt = 0;
	}
	// OnPlayerUpdate
	lst = Scripting_GetPublic(0, buffer, "_@PlayerUpdate");
	if (lst)
	{
		gs_hasPlayerUpdate = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerUpdate")))
		{
			lst = nxt;
		}
		gs_hasPlayerUpdate |= lst << 16;
	}
	else
	{
		gs_hasPlayerUpdate = 0;
	}
	// OnPlayerStreamIn
	lst = Scripting_GetPublic(0, buffer, "_@PlayerStreamIn");
	if (lst)
	{
		gs_hasPlayerStreamIn = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerStreamIn")))
		{
			lst = nxt;
		}
		gs_hasPlayerStreamIn |= lst << 16;
	}
	else
	{
		gs_hasPlayerStreamIn = 0;
	}
	// OnPlayerStreamOut
	lst = Scripting_GetPublic(0, buffer, "_@PlayerStreamOut");
	if (lst)
	{
		gs_hasPlayerStreamOut = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@PlayerStreamOut")))
		{
			lst = nxt;
		}
		gs_hasPlayerStreamOut |= lst << 16;
	}
	else
	{
		gs_hasPlayerStreamOut = 0;
	}
	// OnVehicleStreamIn
	lst = Scripting_GetPublic(0, buffer, "_@VehicleStreamIn");
	if (lst)
	{
		gs_hasVehicleStreamIn = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@VehicleStreamIn")))
		{
			lst = nxt;
		}
		gs_hasVehicleStreamIn |= lst << 16;
	}
	else
	{
		gs_hasVehicleStreamIn = 0;
	}
	// OnVehicleStreamOut
	lst = Scripting_GetPublic(0, buffer, "_@VehicleStreamOut");
	if (lst)
	{
		gs_hasVehicleStreamOut = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@VehicleStreamOut")))
		{
			lst = nxt;
		}
		gs_hasVehicleStreamOut |= lst << 16;
	}
	else
	{
		gs_hasVehicleStreamOut = 0;
	}
	// OnDialogResponse
	lst = Scripting_GetPublic(0, buffer, "_@DialogResponse");
	if (lst)
	{
		gs_hasDialogResponse = lst - 1;
		while ((nxt = Scripting_GetPublic(lst, buffer, "_@DialogResponse")))
		{
			lst = nxt;
		}
		gs_hasDialogResponse |= lst << 16;
	}
	else
	{
		gs_hasDialogResponse = 0;
	}
}

// Hook OnGameModeInit using the old system to call the new system.
public OnGameModeInit()
{
	#if !defined FILTERSCRIPT
		// Generate the list of functions
		Scripting_GenFuncList();
	#endif
	new
		idx = gs_hasGameModeInit;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@GameModeInit");
			CallLocalFunction(buffer, "");
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00000001)
	{
		return CallLocalFunction("S@@@_GameModeInit", "");
	}
	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit S@@@_GameModeInit

forward S@@@_GameModeInit();

// Hook OnGameModeExit using the old system to call the new system.
public OnGameModeExit()
{
	new
		idx = gs_hasGameModeExit;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@GameModeExit");
			CallLocalFunction(buffer, "");
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00000002)
	{
		return CallLocalFunction("S@@@_GameModeExit", "");
	}
	return 1;
}

#if defined _ALS_OnGameModeExit
	#undef OnGameModeExit
#else
	#define _ALS_OnGameModeExit
#endif
#define OnGameModeExit S@@@_GameModeExit

forward S@@@_GameModeExit();

// Hook OnFilterScriptInit using the old system to call the new system.
public OnFilterScriptInit()
{
	#if defined FILTERSCRIPT
		// Generate the list of functions
		Scripting_GenFuncList();
	#endif
	new
		idx = gs_hasFilterScriptInit;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@FilterScriptInit");
			CallLocalFunction(buffer, "");
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00000004)
	{
		return CallLocalFunction("S@@@_FilterScriptInit", "");
	}
	return 1;
}

#if defined _ALS_OnFilterScriptInit
	#undef OnFilterScriptInit
#else
	#define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit S@@@_FilterScriptInit

forward S@@@_FilterScriptInit();

// Hook OnFilterScriptExit using the old system to call the new system.
public OnFilterScriptExit()
{
	new
		idx = gs_hasFilterScriptExit;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@FilterScriptExit");
			CallLocalFunction(buffer, "");
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00000008)
	{
		return CallLocalFunction("S@@@_FilterScriptExit", "");
	}
	return 1;
}

#if defined _ALS_OnFilterScriptExit
	#undef OnFilterScriptExit
#else
	#define _ALS_OnFilterScriptExit
#endif
#define OnFilterScriptExit S@@@_FilterScriptExit

forward S@@@_FilterScriptExit();

// Hook OnPlayerConnect using the old system to call the new system.
public OnPlayerConnect(playerid)
{
	new
		idx = gs_hasPlayerConnect;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerConnect");
			CallLocalFunction(buffer, "i", playerid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00000010)
	{
		return CallLocalFunction("S@@@_PlayerConnect", "i", playerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect S@@@_PlayerConnect

forward S@@@_PlayerConnect(playerid);

// Hook OnPlayerDisconnect using the old system to call the new system.
public OnPlayerDisconnect(playerid, reason)
{
	new
		idx = gs_hasPlayerDisconnect;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerDisconnect");
			CallLocalFunction(buffer, "ii", playerid, reason);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00000020)
	{
		return CallLocalFunction("S@@@_PlayerDisconnect", "ii", playerid, reason);
	}
	return 1;
}

#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect S@@@_PlayerDisconnect

forward S@@@_PlayerDisconnect(playerid, reason);

// Hook OnPlayerSpawn using the old system to call the new system.
public OnPlayerSpawn(playerid)
{
	new
		idx = gs_hasPlayerSpawn;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerSpawn");
			CallLocalFunction(buffer, "i", playerid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00000040)
	{
		return CallLocalFunction("S@@@_PlayerSpawn", "i", playerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerSpawn
	#undef OnPlayerSpawn
#else
	#define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn S@@@_PlayerSpawn

forward S@@@_PlayerSpawn(playerid);

// Hook OnPlayerDeath using the old system to call the new system.
public OnPlayerDeath(playerid, killerid, reason)
{
	new
		idx = gs_hasPlayerDeath;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerDeath");
			CallLocalFunction(buffer, "iii", playerid, killerid, reason);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00000080)
	{
		return CallLocalFunction("S@@@_PlayerDeath", "iii", playerid, killerid, reason);
	}
	return 1;
}

#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif
#define OnPlayerDeath S@@@_PlayerDeath

forward S@@@_PlayerDeath(playerid, killerid, reason);

// Hook OnVehicleSpawn using the old system to call the new system.
public OnVehicleSpawn(vehicleid)
{
	new
		idx = gs_hasVehicleSpawn;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@VehicleSpawn");
			CallLocalFunction(buffer, "i", vehicleid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00000100)
	{
		return CallLocalFunction("S@@@_VehicleSpawn", "i", vehicleid);
	}
	return 1;
}

#if defined _ALS_OnVehicleSpawn
	#undef OnVehicleSpawn
#else
	#define _ALS_OnVehicleSpawn
#endif
#define OnVehicleSpawn S@@@_VehicleSpawn

forward S@@@_VehicleSpawn(vehicleid);

// Hook OnVehicleDeath using the old system to call the new system.
public OnVehicleDeath(vehicleid, killerid)
{
	new
		idx = gs_hasVehicleDeath;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@VehicleDeath");
			CallLocalFunction(buffer, "ii", vehicleid, killerid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00000200)
	{
		return CallLocalFunction("S@@@_VehicleDeath", "ii", vehicleid, killerid);
	}
	return 1;
}

#if defined _ALS_OnVehicleDeath
	#undef OnVehicleDeath
#else
	#define _ALS_OnVehicleDeath
#endif
#define OnVehicleDeath S@@@_VehicleDeath

forward S@@@_VehicleDeath(vehicleid, killerid);

// Hook OnPlayerText using the old system to call the new system.
public OnPlayerText(playerid, text[])
{
	new
		idx = gs_hasPlayerText;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerText");
			CallLocalFunction(buffer, "is", playerid, text);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00000400)
	{
		return CallLocalFunction("S@@@_PlayerText", "is", playerid, text);
	}
	return 1;
}

#if defined _ALS_OnPlayerText
	#undef OnPlayerText
#else
	#define _ALS_OnPlayerText
#endif
#define OnPlayerText S@@@_PlayerText

forward S@@@_PlayerText(playerid, text[]);

// Hook OnPlayerCommandText using the old system to call the new system.
public OnPlayerCommandText(playerid, cmdtext[])
{
	new
		idx = gs_hasPlayerCommandText;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerCommandText");
			if (CallLocalFunction(buffer, "is", playerid, cmdtext))
			{
				return 1;
			}
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00000800)
	{
		return CallLocalFunction("S@@@_PlayerCommandText", "is", playerid, cmdtext);
	}
	return 0;
}

#if defined _ALS_OnPlayerCommandText
	#undef OnPlayerCommandText
#else
	#define _ALS_OnPlayerCommandText
#endif
#define OnPlayerCommandText S@@@_PlayerCommandText

forward S@@@_PlayerCommandText(playerid, cmdtext[]);

// Hook OnPlayerRequestClass using the old system to call the new system.
public OnPlayerRequestClass(playerid, classid)
{
	new
		idx = gs_hasPlayerRequestClass;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerRequestClass");
			CallLocalFunction(buffer, "ii", playerid, classid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00001000)
	{
		return CallLocalFunction("S@@@_PlayerRequestClass", "ii", playerid, classid);
	}
	return 1;
}

#if defined _ALS_OnPlayerRequestClass
	#undef OnPlayerRequestClass
#else
	#define _ALS_OnPlayerRequestClass
#endif
#define OnPlayerRequestClass S@@@_PlayerRequestClass

forward S@@@_PlayerRequestClass(playerid, classid);

// Hook OnPlayerEnterVehicle using the old system to call the new system.
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	new
		idx = gs_hasPlayerEnterVehicle;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerEnterVehicle");
			CallLocalFunction(buffer, "iii", playerid, vehicleid, ispassenger);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00002000)
	{
		return CallLocalFunction("S@@@_PlayerEnterVehicle", "iii", playerid, vehicleid, ispassenger);
	}
	return 1;
}

#if defined _ALS_OnPlayerEnterVehicle
	#undef OnPlayerEnterVehicle
#else
	#define _ALS_OnPlayerEnterVehicle
#endif
#define OnPlayerEnterVehicle S@@@_PlayerEnterVehicle

forward S@@@_PlayerEnterVehicle(playerid, vehicleid, ispassenger);

// Hook OnPlayerExitVehicle using the old system to call the new system.
public OnPlayerExitVehicle(playerid, vehicleid)
{
	new
		idx = gs_hasPlayerExitVehicle;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerExitVehicle");
			CallLocalFunction(buffer, "ii", playerid, vehicleid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00004000)
	{
		return CallLocalFunction("S@@@_PlayerExitVehicle", "ii", playerid, vehicleid);
	}
	return 1;
}

#if defined _ALS_OnPlayerExitVehicle
	#undef OnPlayerExitVehicle
#else
	#define _ALS_OnPlayerExitVehicle
#endif
#define OnPlayerExitVehicle S@@@_PlayerExitVehicle

forward S@@@_PlayerExitVehicle(playerid, vehicleid);

// Hook OnPlayerStateChange using the old system to call the new system.
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new
		idx = gs_hasPlayerStateChange;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerStateChange");
			CallLocalFunction(buffer, "iii", playerid, newstate, oldstate);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00008000)
	{
		return CallLocalFunction("S@@@_PlayerStateChange", "iii", playerid, newstate, oldstate);
	}
	return 1;
}

#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange S@@@_PlayerStateChange

forward S@@@_PlayerStateChange(playerid, newstate, oldstate);

// Hook OnPlayerEnterCheckpoint using the old system to call the new system.
public OnPlayerEnterCheckpoint(playerid)
{
	new
		idx = gs_hasPlayerEnterCheckpoint;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerEnterCheckpoint");
			CallLocalFunction(buffer, "i", playerid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00010000)
	{
		return CallLocalFunction("S@@@_PlayerEnterCheckpoint", "i", playerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerEnterCheckpoint
	#undef OnPlayerEnterCheckpoint
#else
	#define _ALS_OnPlayerEnterCheckpoint
#endif
#define OnPlayerEnterCheckpoint S@@@_PlayerEnterCheckpoint

forward S@@@_PlayerEnterCheckpoint(playerid);

// Hook OnPlayerLeaveCheckpoint using the old system to call the new system.
public OnPlayerLeaveCheckpoint(playerid)
{
	new
		idx = gs_hasPlayerLeaveCheckpoint;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerLeaveCheckpoint");
			CallLocalFunction(buffer, "i", playerid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00020000)
	{
		return CallLocalFunction("S@@@_PlayerLeaveCheckpoint", "i", playerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerLeaveCheckpoint
	#undef OnPlayerLeaveCheckpoint
#else
	#define _ALS_OnPlayerLeaveCheckpoint
#endif
#define OnPlayerLeaveCheckpoint S@@@_PlayerLeaveCheckpoint

forward S@@@_PlayerLeaveCheckpoint(playerid);

// Hook OnPlayerEnterRaceCheckpoint using the old system to call the new system.
public OnPlayerEnterRaceCheckpoint(playerid)
{
	new
		idx = gs_hasPlayerEnterRaceCheckpoint;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerEnterRaceCheckpoint");
			CallLocalFunction(buffer, "i", playerid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00040000)
	{
		return CallLocalFunction("S@@@_PlayerEnterRaceCheckpoint", "i", playerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerEnterRaceCP
	#undef OnPlayerEnterRaceCheckpoint
#else
	#define _ALS_OnPlayerEnterRaceCP
#endif
#define OnPlayerEnterRaceCheckpoint S@@@_PlayerEnterRaceCheckpoint

forward S@@@_PlayerEnterRaceCheckpoint(playerid);

// Hook OnPlayerLeaveRaceCheckpoint using the old system to call the new system.
public OnPlayerLeaveRaceCheckpoint(playerid)
{
	new
		idx = gs_hasPlayerLeaveRaceCheckpoint;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerLeaveRaceCheckpoint");
			CallLocalFunction(buffer, "i", playerid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00080000)
	{
		return CallLocalFunction("S@@@_PlayerLeaveRaceCheckpoint", "i", playerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerLeaveRaceCP
	#undef OnPlayerLeaveRaceCheckpoint
#else
	#define _ALS_OnPlayerLeaveRaceCP
#endif
#define OnPlayerLeaveRaceCheckpoint S@@@_PlayerLeaveRaceCheckpoint

forward S@@@_PlayerLeaveRaceCheckpoint(playerid);

// Hook OnRconCommand using the old system to call the new system.
public OnRconCommand(cmd[])
{
	new
		idx = gs_hasRconCommand;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@RconCommand");
			CallLocalFunction(buffer, "s", cmd);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00100000)
	{
		return CallLocalFunction("S@@@_RconCommand", "s", cmd);
	}
	return 1;
}

#if defined _ALS_OnRconCommand
	#undef OnRconCommand
#else
	#define _ALS_OnRconCommand
#endif
#define OnRconCommand S@@@_RconCommand

forward S@@@_RconCommand(cmd[]);

// Hook OnPlayerRequestSpawn using the old system to call the new system.
public OnPlayerRequestSpawn(playerid)
{
	new
		idx = gs_hasPlayerRequestSpawn;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerRequestSpawn");
			CallLocalFunction(buffer, "i", playerid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00200000)
	{
		return CallLocalFunction("S@@@_PlayerRequestSpawn", "i", playerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerRequestSpawn
	#undef OnPlayerRequestSpawn
#else
	#define _ALS_OnPlayerRequestSpawn
#endif
#define OnPlayerRequestSpawn S@@@_PlayerRequestSpawn

forward S@@@_PlayerRequestSpawn(playerid);

// Hook OnObjectMoved using the old system to call the new system.
public OnObjectMoved(objectid)
{
	new
		idx = gs_hasObjectMoved;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@ObjectMoved");
			CallLocalFunction(buffer, "i", objectid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00400000)
	{
		return CallLocalFunction("S@@@_ObjectMoved", "i", objectid);
	}
	return 1;
}

#if defined _ALS_OnObjectMoved
	#undef OnObjectMoved
#else
	#define _ALS_OnObjectMoved
#endif
#define OnObjectMoved S@@@_ObjectMoved

forward S@@@_ObjectMoved(objectid);

// Hook OnPlayerObjectMoved using the old system to call the new system.
public OnPlayerObjectMoved(playerid, objectid)
{
	new
		idx = gs_hasPlayerObjectMoved;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerObjectMoved");
			CallLocalFunction(buffer, "ii", playerid, objectid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x00800000)
	{
		return CallLocalFunction("S@@@_PlayerObjectMoved", "ii", playerid, objectid);
	}
	return 1;
}

#if defined _ALS_OnPlayerObjectMoved
	#undef OnPlayerObjectMoved
#else
	#define _ALS_OnPlayerObjectMoved
#endif
#define OnPlayerObjectMoved S@@@_PlayerObjectMoved

forward S@@@_PlayerObjectMoved(playerid, objectid);

// Hook OnPlayerPickUpPickup using the old system to call the new system.
public OnPlayerPickUpPickup(playerid, pickupid)
{
	new
		idx = gs_hasPlayerPickUpPickup;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerPickUpPickup");
			CallLocalFunction(buffer, "ii", playerid, pickupid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x01000000)
	{
		return CallLocalFunction("S@@@_PlayerPickUpPickup", "ii", playerid, pickupid);
	}
	return 1;
}

#if defined _ALS_OnPlayerPickUpPickup
	#undef OnPlayerPickUpPickup
#else
	#define _ALS_OnPlayerPickUpPickup
#endif
#define OnPlayerPickUpPickup S@@@_PlayerPickUpPickup

forward S@@@_PlayerPickUpPickup(playerid, pickupid);

// Hook OnVehicleMod using the old system to call the new system.
public OnVehicleMod(playerid, vehicleid, componentid)
{
	new
		idx = gs_hasVehicleMod;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@VehicleMod");
			CallLocalFunction(buffer, "iii", playerid, vehicleid, componentid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x02000000)
	{
		return CallLocalFunction("S@@@_VehicleMod", "iii", playerid, vehicleid, componentid);
	}
	return 1;
}

#if defined _ALS_OnVehicleMod
	#undef OnVehicleMod
#else
	#define _ALS_OnVehicleMod
#endif
#define OnVehicleMod S@@@_VehicleMod

forward S@@@_VehicleMod(playerid, vehicleid, componentid);

// Hook OnEnterExitModShop using the old system to call the new system.
public OnEnterExitModShop(playerid, enterexit, interiorid)
{
	new
		idx = gs_hasEnterExitModShop;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@EnterExitModShop");
			CallLocalFunction(buffer, "iii", playerid, enterexit, interiorid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x04000000)
	{
		return CallLocalFunction("S@@@_EnterExitModShop", "iii", playerid, enterexit, interiorid);
	}
	return 1;
}

#if defined _ALS_OnEnterExitModShop
	#undef OnEnterExitModShop
#else
	#define _ALS_OnEnterExitModShop
#endif
#define OnEnterExitModShop S@@@_EnterExitModShop

forward S@@@_EnterExitModShop(playerid, enterexit, interiorid);

// Hook OnVehiclePaintjob using the old system to call the new system.
public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	new
		idx = gs_hasVehiclePaintjob;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@VehiclePaintjob");
			CallLocalFunction(buffer, "iii", playerid, vehicleid, paintjobid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x08000000)
	{
		return CallLocalFunction("S@@@_VehiclePaintjob", "iii", playerid, vehicleid, paintjobid);
	}
	return 1;
}

#if defined _ALS_OnVehiclePaintjob
	#undef OnVehiclePaintjob
#else
	#define _ALS_OnVehiclePaintjob
#endif
#define OnVehiclePaintjob S@@@_VehiclePaintjob

forward S@@@_VehiclePaintjob(playerid, vehicleid, paintjobid);

// Hook OnVehicleRespray using the old system to call the new system.
public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	new
		idx = gs_hasVehicleRespray;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@VehicleRespray");
			CallLocalFunction(buffer, "iiii", playerid, vehicleid, color1, color2);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x10000000)
	{
		return CallLocalFunction("S@@@_VehicleRespray", "iiii", playerid, vehicleid, color1, color2);
	}
	return 1;
}

#if defined _ALS_OnVehicleRespray
	#undef OnVehicleRespray
#else
	#define _ALS_OnVehicleRespray
#endif
#define OnVehicleRespray S@@@_VehicleRespray

forward S@@@_VehicleRespray(playerid, vehicleid, color1, color2);

// Hook OnVehicleDamageStatusUpdate using the old system to call the new system.
public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	new
		idx = gs_hasVehicleDamageStatusUpdate;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@VehicleDamageStatusUpdate");
			CallLocalFunction(buffer, "ii", vehicleid, playerid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x20000000)
	{
		return CallLocalFunction("S@@@_VehicleDamageStatusUpdate", "ii", vehicleid, playerid);
	}
	return 1;
}

#if defined _ALS_OnVehicleDamageStatusUpd
	#undef OnVehicleDamageStatusUpdate
#else
	#define _ALS_OnVehicleDamageStatusUpd
#endif
#define OnVehicleDamageStatusUpdate S@@@_VehicleDamageStatusUpdate

forward S@@@_VehicleDamageStatusUpdate(vehicleid, playerid);

// Hook OnPlayerSelectedMenuRow using the old system to call the new system.
public OnPlayerSelectedMenuRow(playerid, row)
{
	new
		idx = gs_hasPlayerSelectedMenuRow;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerSelectedMenuRow");
			CallLocalFunction(buffer, "ii", playerid, row);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x40000000)
	{
		return CallLocalFunction("S@@@_PlayerSelectedMenuRow", "ii", playerid, row);
	}
	return 1;
}

#if defined _ALS_OnPlayerSelectedMenuRow
	#undef OnPlayerSelectedMenuRow
#else
	#define _ALS_OnPlayerSelectedMenuRow
#endif
#define OnPlayerSelectedMenuRow S@@@_PlayerSelectedMenuRow

forward S@@@_PlayerSelectedMenuRow(playerid, row);

// Hook OnPlayerExitedMenu using the old system to call the new system.
public OnPlayerExitedMenu(playerid)
{
	new
		idx = gs_hasPlayerExitedMenu;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerExitedMenu");
			CallLocalFunction(buffer, "i", playerid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks & 0x80000000)
	{
		return CallLocalFunction("S@@@_PlayerExitedMenu", "i", playerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerExitedMenu
	#undef OnPlayerExitedMenu
#else
	#define _ALS_OnPlayerExitedMenu
#endif
#define OnPlayerExitedMenu S@@@_PlayerExitedMenu

forward S@@@_PlayerExitedMenu(playerid);

// Hook OnPlayerInteriorChange using the old system to call the new system.
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	new
		idx = gs_hasPlayerInteriorChange;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerInteriorChange");
			CallLocalFunction(buffer, "iii", playerid, newinteriorid, oldinteriorid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks1 & 0x00000001)
	{
		return CallLocalFunction("S@@@_PlayerInteriorChange", "iii", playerid, newinteriorid, oldinteriorid);
	}
	return 1;
}

#if defined _ALS_OnPlayerInteriorChange
	#undef OnPlayerInteriorChange
#else
	#define _ALS_OnPlayerInteriorChange
#endif
#define OnPlayerInteriorChange S@@@_PlayerInteriorChange

forward S@@@_PlayerInteriorChange(playerid, newinteriorid, oldinteriorid);

// Hook OnPlayerKeyStateChange using the old system to call the new system.
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new
		idx = gs_hasPlayerKeyStateChange;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerKeyStateChange");
			CallLocalFunction(buffer, "iii", playerid, newkeys, oldkeys);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks1 & 0x00000002)
	{
		return CallLocalFunction("S@@@_PlayerKeyStateChange", "iii", playerid, newkeys, oldkeys);
	}
	return 1;
}

#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange S@@@_PlayerKeyStateChange

forward S@@@_PlayerKeyStateChange(playerid, newkeys, oldkeys);

// Hook OnRconLoginAttempt using the old system to call the new system.
public OnRconLoginAttempt( ip[], password[], success )
{
	new
		idx = gs_hasRconLoginAttempt;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@RconLoginAttempt");
			CallLocalFunction(buffer, "ssi",  ip, password, success );
		}
		while (idx != end);
	}
	if (gs_hasCallbacks1 & 0x00000004)
	{
		return CallLocalFunction("S@@@_RconLoginAttempt", "ssi",  ip, password, success );
	}
	return 1;
}

#if defined _ALS_OnRconLoginAttempt
	#undef OnRconLoginAttempt
#else
	#define _ALS_OnRconLoginAttempt
#endif
#define OnRconLoginAttempt S@@@_RconLoginAttempt

forward S@@@_RconLoginAttempt( ip[], password[], success );

// Hook OnPlayerUpdate using the old system to call the new system.
public OnPlayerUpdate(playerid)
{
	new
		idx = gs_hasPlayerUpdate;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerUpdate");
			CallLocalFunction(buffer, "i", playerid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks1 & 0x00000008)
	{
		return CallLocalFunction("S@@@_PlayerUpdate", "i", playerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate S@@@_PlayerUpdate

forward S@@@_PlayerUpdate(playerid);

// Hook OnPlayerStreamIn using the old system to call the new system.
public OnPlayerStreamIn(playerid, forplayerid)
{
	new
		idx = gs_hasPlayerStreamIn;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerStreamIn");
			CallLocalFunction(buffer, "ii", playerid, forplayerid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks1 & 0x00000010)
	{
		return CallLocalFunction("S@@@_PlayerStreamIn", "ii", playerid, forplayerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerStreamIn
	#undef OnPlayerStreamIn
#else
	#define _ALS_OnPlayerStreamIn
#endif
#define OnPlayerStreamIn S@@@_PlayerStreamIn

forward S@@@_PlayerStreamIn(playerid, forplayerid);

// Hook OnPlayerStreamOut using the old system to call the new system.
public OnPlayerStreamOut(playerid, forplayerid)
{
	new
		idx = gs_hasPlayerStreamOut;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@PlayerStreamOut");
			CallLocalFunction(buffer, "ii", playerid, forplayerid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks1 & 0x00000020)
	{
		return CallLocalFunction("S@@@_PlayerStreamOut", "ii", playerid, forplayerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerStreamOut
	#undef OnPlayerStreamOut
#else
	#define _ALS_OnPlayerStreamOut
#endif
#define OnPlayerStreamOut S@@@_PlayerStreamOut

forward S@@@_PlayerStreamOut(playerid, forplayerid);

// Hook OnVehicleStreamIn using the old system to call the new system.
public OnVehicleStreamIn(vehicleid, forplayerid)
{
	new
		idx = gs_hasVehicleStreamIn;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@VehicleStreamIn");
			CallLocalFunction(buffer, "ii", vehicleid, forplayerid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks1 & 0x00000040)
	{
		return CallLocalFunction("S@@@_VehicleStreamIn", "ii", vehicleid, forplayerid);
	}
	return 1;
}

#if defined _ALS_OnVehicleStreamIn
	#undef OnVehicleStreamIn
#else
	#define _ALS_OnVehicleStreamIn
#endif
#define OnVehicleStreamIn S@@@_VehicleStreamIn

forward S@@@_VehicleStreamIn(vehicleid, forplayerid);

// Hook OnVehicleStreamOut using the old system to call the new system.
public OnVehicleStreamOut(vehicleid, forplayerid)
{
	new
		idx = gs_hasVehicleStreamOut;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@VehicleStreamOut");
			CallLocalFunction(buffer, "ii", vehicleid, forplayerid);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks1 & 0x00000080)
	{
		return CallLocalFunction("S@@@_VehicleStreamOut", "ii", vehicleid, forplayerid);
	}
	return 1;
}

#if defined _ALS_OnVehicleStreamOut
	#undef OnVehicleStreamOut
#else
	#define _ALS_OnVehicleStreamOut
#endif
#define OnVehicleStreamOut S@@@_VehicleStreamOut

forward S@@@_VehicleStreamOut(vehicleid, forplayerid);

// Hook OnDialogResponse using the old system to call the new system.
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new
		idx = gs_hasDialogResponse;
	if (idx)
	{
		new
			buffer[33],
			end = idx >> 16;
		idx &= 0xFFFF;
		do
		{
			idx = Scripting_GetPublic(idx, buffer, "_@DialogResponse");
			CallLocalFunction(buffer, "iiiis", playerid, dialogid, response, listitem, inputtext);
		}
		while (idx != end);
	}
	if (gs_hasCallbacks1 & 0x00000100)
	{
		return CallLocalFunction("S@@@_DialogResponse", "iiiis", playerid, dialogid, response, listitem, inputtext);
	}
	return 1;
}

#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif
#define OnDialogResponse S@@@_DialogResponse

forward S@@@_DialogResponse(playerid, dialogid, response, listitem, inputtext[]);
