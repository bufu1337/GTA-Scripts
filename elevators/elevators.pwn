//==============================================================================
// Incognito's Elevator Filterscript
//
// Highly customizable elevators with the following features:
// - Opening and closing doors
// - Multiple floors with custom names
// - Call switches on each floor
// - Attachable light and support objects
// - Adjustable object move speeds
// - Easy implementation
//==============================================================================

//==============================================================================
// Includes
//==============================================================================
#include <a_samp>
//==============================================================================
// Defines:
// - MAX_ELEVATORS specifies the number of elevators (default is 2).
// - MAX_LEVELS specifies the number of levels (default is 8).
//
// If you want to change these defines, you'll have to edit a few of the
// variables below.
//==============================================================================
#define MAX_ELEVATORS 2
#define MAX_LEVELS 8
//==============================================================================
// Variables:
// If you change any of the defines above, you many need to edit the following
// arrays:
//
// 1.) ElevatorAttachableObjects
// 2.) ElevatorCoordinates
// 3.) ElevatorLevels
// 4.) ElevatorMoveSpeeds
// 5.) FloorNames
// 6.) SwitchCoordinates
//
// If you change MAX_ELEVATORS, you'll need to add or remove columns. If you
// change MAX_LEVELS, you'll need to add or remove rows from existing columns.
// Everything is explained below.
//==============================================================================
//------------------------------------------------------------------------------
// Don't touch these variables (they are set automatically in the script).
//------------------------------------------------------------------------------
enum ElevatorVariables
{
	bool:Called,
	CurrentLevel,
	bool:DoorsOpen,
	bool:LightChanged,
	bool:Moving,
	NewLevel,
	Float:NewLiftSpeed,
	bool:RequestedCall,
	bool:RequestedMove
}
new ElevatorInfo[MAX_ELEVATORS][ElevatorVariables];
//------------------------------------------------------------------------------
// These variables correspond to all of the pickups. Don't touch them unless you
// want to add more.
//------------------------------------------------------------------------------
enum PickupVariables
{
	Switch
}
new PickupInfo[MAX_ELEVATORS][MAX_LEVELS][PickupVariables];
//------------------------------------------------------------------------------
// Don't touch these variables. They are set automatically in the script.
//------------------------------------------------------------------------------
enum PlayerVariables
{
	CallLevel,
	Menu:ElevatorMenu,
	bool:InCallMenu,
	FloorSelectionMenu,
	bool:FloorSelectionEnabled
}
new PlayerInfo[MAX_PLAYERS][MAX_ELEVATORS][PlayerVariables];
//------------------------------------------------------------------------------
// These variables correspond to all of objects. Don't touch them unless you
// want to add more.
//------------------------------------------------------------------------------
enum ObjectVariables
{
	Float:Door1CurrentX,
	Float:Door1CurrentY,
	Float:Door1CurrentZ,
	Float:Door2CurrentX,
	Float:Door2CurrentY,
	Float:Door2CurrentZ,
	Door1Object,
	Door2Object,
	Float:ElevatorCurrentX,
	Float:ElevatorCurrentY,
	Float:ElevatorCurrentZ,
	ElevatorObject,
	LightObject,
	SupportObject
}
new ObjectInfo[MAX_ELEVATORS][ObjectVariables];
//------------------------------------------------------------------------------
// These boolean values specify whether to attach a light and/or a support
// object to each elevator. There are two values in each row. The first value
// corresponds to the light object and the second value corresponds to the
// support object. Specifying true will attach the object, and specifying false
// will not attach the object. Each elevator is in a separate column.
//------------------------------------------------------------------------------
new bool:ElevatorAttachableObjects[MAX_ELEVATORS][2] =
{
	{true, true},
	{true, true}
};
//------------------------------------------------------------------------------
// These numbers specify where the elevators will be placed. There are two
// numbers separated by commas in each row. The first number is the X coordinate
// and the second number is the Y coordinate. The first Z coordinate from
// ElevatorLevels will be used when the objects are created. Each elevator is in
// a separate column.
//------------------------------------------------------------------------------
new Float:ElevatorCoordinates[MAX_ELEVATORS][2] =
{
	{1880.027710, -1315.910156},
	{1883.477173, -1315.910156}
};
//------------------------------------------------------------------------------
// These numbers specify where the elevator will stop at each level. There are
// numbers separated by commas in each row (the amount is determined by
// MAX_LEVELS). These numbers are the Z coordinates the elevator will use when
// moving to a new level. Each elevator is in a separate column. (Note: insert
// 0.0 if you don't want a level to be used.)
//------------------------------------------------------------------------------
new Float:ElevatorLevels[MAX_ELEVATORS][MAX_LEVELS] =
{
	{14.840647, 19.715614, 24.715595, 29.715588, 34.715614, 39.715675, 44.715675, 49.640686},
	{14.840647, 19.715614, 24.715595, 29.715588, 34.715614, 39.715675, 44.715675, 49.640686}
};
//------------------------------------------------------------------------------
// These numbers specify how fast the elevators will move from one set of
// coordinates to another. There are four numbers separated by commas in each
// row. The first number is door open speed, the second number is the door close
// speed, the third number is the lift up speed, and the fourth number is the
// lift down speed. Don't make the lift speeds too fast or the player will
// fall through the elevator. Each elevator is in a separate column.
//------------------------------------------------------------------------------
new Float:ElevatorMoveSpeeds[MAX_ELEVATORS][4] =
{
	{1.0, 1.0, 2.0, 2.0},
	{1.0, 1.0, 2.0, 2.0}
};
//------------------------------------------------------------------------------
// These strings specify the names of the floors. There are strings separated by
// commas in each row (the amount is determined by MAX_LEVELS). These strings
// will be found in the menu that is opened when a player walks into an
// elevator. Each elevator is in a separate column. (Note: insert nothing in the
// string name, or "", if you don't want the floor to be used.)
//------------------------------------------------------------------------------
new FloorNames[MAX_ELEVATORS][MAX_LEVELS][32] =
{
	{"Lobby", "Storage Room", "Surveillance", "Drug Store", "Tools Store", "Ammu-Nation", "Viewing Room", "Roof"},
	{"Lobby", "Storage Room", "Surveillance", "Drug Store", "Tools Store", "Ammu-Nation", "Viewing Room", "Roof"}
};
//------------------------------------------------------------------------------
// These numbers specify where the elevator switches will be placed. The are
// three numbers separated by commas in each row. The first number is the X
// coordinate and the second number is the Y coordinate. The Z coordinate from
// ElevatorLevels will be used with an offset when the pickups are created. Each
// elevator is in a separate column.
//------------------------------------------------------------------------------
new Float:SwitchCoordinates[MAX_ELEVATORS][2] =
{
	{1878.035445, -1319.999963},
	{1885.636479, -1319.999963}
};
//==============================================================================
// Forwards
//==============================================================================
forward CheckElevatorStatus();
forward Float:GetPointDistanceToPointEx(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2);
forward SetElevatorLevel(elevatorid, newlevel);
//==============================================================================
// Creates the objects, pickups, menus, timers
//==============================================================================
public OnFilterScriptInit()
{
	for (new e; e < MAX_ELEVATORS; e++)
	{
		ObjectInfo[e][ElevatorObject] = CreateObject(2669, ElevatorCoordinates[e][0], ElevatorCoordinates[e][1], ElevatorLevels[e][0], 0.0, 0.0, 0.0);
		ObjectInfo[e][Door1Object] = CreateObject(2678, ElevatorCoordinates[e][0] - 0.756317, ElevatorCoordinates[e][1] - 2.648524, ElevatorLevels[e][0] - 0.133423, 0.0, 0.0, 0.0);
		ObjectInfo[e][Door2Object] = CreateObject(2679, ElevatorCoordinates[e][0] + 0.758787, ElevatorCoordinates[e][1] - 2.648524, ElevatorLevels[e][0] - 0.133423, 0.0, 0.0, 0.0);
		if (ElevatorAttachableObjects[e][0]) ObjectInfo[e][LightObject] = CreateObject(1215, ElevatorCoordinates[e][0], ElevatorCoordinates[e][1], ElevatorLevels[e][0] + 1.863229, 0.0, 0.0, 0.0);
		if (ElevatorAttachableObjects[e][1]) ObjectInfo[e][SupportObject] = CreateObject(1383, ElevatorCoordinates[e][0], ElevatorCoordinates[e][1], ElevatorLevels[e][0] - 33.785002, 0.0, 0.0, 0.0);
		for (new l; l < MAX_LEVELS; l++)
		{
			if (ElevatorLevels[e][l] == 0.0) continue;
			PickupInfo[e][l][Switch] = CreatePickup(1239, 1, SwitchCoordinates[e][0], SwitchCoordinates[e][1], ElevatorLevels[e][l] - 0.25);
		}
	}
	SetTimer("CheckElevatorStatus", 1000, 1);
	return 1;
}
//==============================================================================
// Destroys the objects, pickups, and menus
//==============================================================================
public OnFilterScriptExit()
{
	for (new e; e < MAX_ELEVATORS; e++)
	{
		for (new i; i < MAX_LEVELS; i++)
		{
			if (!IsPlayerConnected(i)) continue;
			DestroyMenu(PlayerInfo[i][e][ElevatorMenu]);
		}
		DestroyObject(ObjectInfo[e][ElevatorObject]);
		DestroyObject(ObjectInfo[e][Door1Object]);
		DestroyObject(ObjectInfo[e][Door2Object]);
		if (ElevatorAttachableObjects[e][0]) DestroyObject(ObjectInfo[e][LightObject]);
		if (ElevatorAttachableObjects[e][1]) DestroyObject(ObjectInfo[e][SupportObject]);
		for (new l; l < MAX_LEVELS; l++) DestroyPickup(PickupInfo[e][l][Switch]);
	}
	return 1;
}
//==============================================================================
// Toggles the player controllable and sets the menu ID to 0
//==============================================================================
public OnPlayerExitedMenu(playerid)
{
	for (new e; e < MAX_ELEVATORS; e++)
	{
		if (PlayerInfo[playerid][e][FloorSelectionMenu] == 1 || PlayerInfo[playerid][e][InCallMenu])
		{
		    DestroyMenu(PlayerInfo[playerid][e][ElevatorMenu]);
			PlayerInfo[playerid][e][InCallMenu] = false;
			PlayerInfo[playerid][e][FloorSelectionMenu] = 0;
			TogglePlayerControllable(playerid, 1);
			return 1;
		}
	    if (PlayerInfo[playerid][e][FloorSelectionMenu] > 1 && !PlayerInfo[playerid][e][InCallMenu])
		{
		    DestroyMenu(PlayerInfo[playerid][e][ElevatorMenu]);
			PlayerInfo[playerid][e][ElevatorMenu] = CreateMenu("Elevator", 1, 20, 140, 110);
			PlayerInfo[playerid][e][FloorSelectionMenu]--;
			for (new l; l < MAX_LEVELS; l++)
			{
				if (!strlen(FloorNames[e][l]) || l < PlayerInfo[playerid][e][FloorSelectionMenu] * 10 - 10 || l > PlayerInfo[playerid][e][FloorSelectionMenu] * 10 - 1) continue;
				AddMenuItem(PlayerInfo[playerid][e][ElevatorMenu], 0, FloorNames[e][l]);
				if (l == PlayerInfo[playerid][e][FloorSelectionMenu] * 10 - 1) AddMenuItem(PlayerInfo[playerid][e][ElevatorMenu], 0, "Next");
			}
			ShowMenuForPlayer(PlayerInfo[playerid][e][ElevatorMenu], playerid);
			return 1;
		}
	}
	return 0;
}
//==============================================================================
// Opens the menu that calls an elevator to the player's level
//==============================================================================
public OnPlayerPickUpPickup(playerid, pickupid)
{
	for (new e; e < MAX_ELEVATORS; e++)
	{
		for (new l; l < MAX_LEVELS; l++)
		{
		    if (pickupid != PickupInfo[e][l][Switch]) continue;
		    DestroyMenu(PlayerInfo[playerid][e][ElevatorMenu]);
		    PlayerInfo[playerid][e][InCallMenu] = true;
			PlayerInfo[playerid][e][CallLevel] = l + 1;
			PlayerInfo[playerid][e][ElevatorMenu] = CreateMenu("Elevator", 1, 20, 140, 110);
			AddMenuItem(PlayerInfo[playerid][e][ElevatorMenu], 0, "Call Elevator");
			ShowMenuForPlayer(PlayerInfo[playerid][e][ElevatorMenu], playerid);
			TogglePlayerControllable(playerid, 0);
			break;
		}
	}
	return 1;
}
//==============================================================================
// Sends the desired new elevator level to SetElevatorLevel based on the
// player's selection in the menu
//==============================================================================
public OnPlayerSelectedMenuRow(playerid, row)
{
	for (new e; e < MAX_ELEVATORS; e++)
	{
		if (PlayerInfo[playerid][e][FloorSelectionMenu] > 0 && !PlayerInfo[playerid][e][InCallMenu])
		{
		    DestroyMenu(PlayerInfo[playerid][e][ElevatorMenu]);
			if (row < 10)
			{
				if (ElevatorInfo[e][Called] || ElevatorInfo[e][Moving] || ElevatorInfo[e][RequestedMove])
				{
					SendClientMessage(playerid, 0xFF0000AA, "ERROR: A floor has already been selected.");
					TogglePlayerControllable(playerid, 1);
				}
				else
				{
					AdjustElevatorDoors(e, false);
					ElevatorInfo[e][RequestedMove] = true;
					SetTimerEx("SetElevatorLevel", 1000, 0, "ii", e, (((PlayerInfo[playerid][e][FloorSelectionMenu] * 10) - 9) + row));
					TogglePlayerControllable(playerid, 1);
				}
				PlayerInfo[playerid][e][FloorSelectionMenu] = 0;
			}
			else
			{
				PlayerInfo[playerid][e][ElevatorMenu] = CreateMenu("Elevator", 1, 20, 140, 110);
				PlayerInfo[playerid][e][FloorSelectionMenu]++;
				for (new l; l < MAX_LEVELS; l++)
				{
					if (!strlen(FloorNames[e][l]) || l < PlayerInfo[playerid][e][FloorSelectionMenu] * 10 - 10 || l > PlayerInfo[playerid][e][FloorSelectionMenu] * 10 - 1) continue;
					AddMenuItem(PlayerInfo[playerid][e][ElevatorMenu], 0, FloorNames[e][l]);
					if (l == PlayerInfo[playerid][e][FloorSelectionMenu] * 10 - 1 && PlayerInfo[playerid][e][FloorSelectionMenu] != floatround(floatdiv(float(MAX_LEVELS), 10.0), floatround_ceil) + 1) AddMenuItem(PlayerInfo[playerid][e][ElevatorMenu], 0, "Next");
					ShowMenuForPlayer(PlayerInfo[playerid][e][ElevatorMenu], playerid);
				}
			}
			return 1;
		}
		if (PlayerInfo[playerid][e][FloorSelectionMenu] == 0 && PlayerInfo[playerid][e][InCallMenu])
		{
		    DestroyMenu(PlayerInfo[playerid][e][ElevatorMenu]);
			if (ElevatorInfo[e][Called] || ElevatorInfo[e][Moving] || ElevatorInfo[e][RequestedMove])
			{
				if (ElevatorInfo[e][Called]) SendClientMessage(playerid, 0xFF0000AA, "ERROR: The elevator has already been called to another floor.");
				if (ElevatorInfo[e][Moving] || ElevatorInfo[e][RequestedMove]) SendClientMessage(playerid, 0xFF0000AA, "ERROR: The elevator is already moving.");
				TogglePlayerControllable(playerid, 1);
			}
			else
			{
				AdjustElevatorDoors(e, false);
				ElevatorInfo[e][RequestedCall] = true;
				SetTimerEx("SetElevatorLevel", 1000, 0, "ii", e, PlayerInfo[playerid][e][CallLevel]);
				TogglePlayerControllable(playerid, 1);
			}
			PlayerInfo[playerid][e][InCallMenu] = false;
			return 1;
		}
	}
	return 0;
}
//==============================================================================
// Opens or closes the elevator doors
//==============================================================================
AdjustElevatorDoors(elevatorid, bool:opendoors)
{
	for (new e; e < MAX_ELEVATORS; e++)
	{
	    if (elevatorid != e) continue;
	    LocateElevator(e);
		if (opendoors)
		{
		    if (!ElevatorInfo[e][DoorsOpen])
			{
			    for (new i; i < MAX_PLAYERS; i++) PlayerPlaySound(i, 1019, ObjectInfo[e][ElevatorCurrentX], ObjectInfo[e][ElevatorCurrentY], ObjectInfo[e][ElevatorCurrentZ]);
				for (new i; i < MAX_PLAYERS; i++) PlayerPlaySound(i, 1021, ObjectInfo[e][ElevatorCurrentX], ObjectInfo[e][ElevatorCurrentY], ObjectInfo[e][ElevatorCurrentZ]);
			}
			MoveObject(ObjectInfo[e][Door1Object], ObjectInfo[e][ElevatorCurrentX] - 1.493775, ObjectInfo[e][Door1CurrentY], ObjectInfo[e][Door1CurrentZ], ElevatorMoveSpeeds[e][0]);
			MoveObject(ObjectInfo[e][Door2Object], ObjectInfo[e][ElevatorCurrentX] + 1.491865, ObjectInfo[e][Door2CurrentY], ObjectInfo[e][Door2CurrentZ], ElevatorMoveSpeeds[e][0]);
            ElevatorInfo[e][DoorsOpen] = true;
            break;
		}
		else
		{
		    if (ElevatorInfo[e][DoorsOpen])
			{
			    for (new i; i < MAX_PLAYERS; i++) PlayerPlaySound(i, 1019, ObjectInfo[e][ElevatorCurrentX], ObjectInfo[e][ElevatorCurrentY], ObjectInfo[e][ElevatorCurrentZ]);
				for (new i; i < MAX_PLAYERS; i++) PlayerPlaySound(i, 1021, ObjectInfo[e][ElevatorCurrentX], ObjectInfo[e][ElevatorCurrentY], ObjectInfo[e][ElevatorCurrentZ]);
			}
			MoveObject(ObjectInfo[e][Door1Object], ObjectInfo[e][ElevatorCurrentX] - 0.756317, ObjectInfo[e][Door1CurrentY], ObjectInfo[e][Door1CurrentZ], ElevatorMoveSpeeds[e][1]);
			MoveObject(ObjectInfo[e][Door2Object], ObjectInfo[e][ElevatorCurrentX] + 0.758787, ObjectInfo[e][Door2CurrentY], ObjectInfo[e][Door2CurrentZ], ElevatorMoveSpeeds[e][1]);
			ElevatorInfo[e][DoorsOpen] = false;
			break;
		}
	}
	return 1;
}
//==============================================================================
// Shows the floor selection menu for any players inside the elevators, opens
// the doors for any players near the elevators, and moves the elevators if they
// are prepared to be moved
//==============================================================================
public CheckElevatorStatus()
{
	for (new e; e < MAX_ELEVATORS; e++)
	{
		LocateElevator(e);
		if (!ElevatorInfo[e][Called] && !ElevatorInfo[e][Moving] && !ElevatorInfo[e][RequestedCall] && !ElevatorInfo[e][RequestedMove])
		{
			if (IsAPlayerInCube(ObjectInfo[e][ElevatorCurrentX] - 2.0, ObjectInfo[e][ElevatorCurrentY] - 7.5, ObjectInfo[e][ElevatorCurrentZ] - 2.0, ObjectInfo[e][ElevatorCurrentX] + 2.0, ObjectInfo[e][ElevatorCurrentY] + 7.5, ObjectInfo[e][ElevatorCurrentZ] + 2.0)) AdjustElevatorDoors(e, true);
			else AdjustElevatorDoors(e, false);
			for (new i; i < MAX_PLAYERS; i++)
			{
			    if (!IsPlayerConnected(i)) continue;
				new Float:x, Float:y, Float:z;
				GetPlayerPos(i, x, y, z);
				if (GetPointDistanceToPointEx(x, y, z, ObjectInfo[e][ElevatorCurrentX], ObjectInfo[e][ElevatorCurrentY], ObjectInfo[e][ElevatorCurrentZ]) < 1.95 && PlayerInfo[i][e][FloorSelectionEnabled])
				{
				    PlayerInfo[i][e][ElevatorMenu] = CreateMenu("Elevator", 1, 20, 140, 110);
					PlayerInfo[i][e][FloorSelectionEnabled] = false;
					PlayerInfo[i][e][FloorSelectionMenu] = 1;
					TogglePlayerControllable(i, 0);
					for (new l; l < MAX_LEVELS; l++)
					{
						if (!strlen(FloorNames[e][l]) || l > 9) continue;
						AddMenuItem(PlayerInfo[i][e][ElevatorMenu], 0, FloorNames[e][l]);
						if (l == 9) AddMenuItem(PlayerInfo[i][e][ElevatorMenu], 0, "Next");
						ShowMenuForPlayer(PlayerInfo[i][e][ElevatorMenu], i);
					}
				}
				else if (GetPointDistanceToPointEx(x, y, z, ObjectInfo[e][ElevatorCurrentX], ObjectInfo[e][ElevatorCurrentY], ObjectInfo[e][ElevatorCurrentZ]) > 1.95 && !PlayerInfo[i][e][FloorSelectionEnabled]) PlayerInfo[i][e][FloorSelectionEnabled] = true;
			}
		}
		else if ((ElevatorInfo[e][Called] || ElevatorInfo[e][Moving]) && (!ElevatorInfo[e][RequestedCall] && !ElevatorInfo[e][RequestedMove]))
		{
			for (new i; i < MAX_PLAYERS; i++)
			{
			    if (IsPlayerInArea(i, ObjectInfo[e][ElevatorCurrentX] - 20.0, ObjectInfo[e][ElevatorCurrentX] + 20.0, ObjectInfo[e][ElevatorCurrentY] - 20.0, ObjectInfo[e][ElevatorCurrentY] + 20.0))
			    {
					PlayerPlaySound(i, 1019, 0.0, 0.0, 0.0);
					PlayerPlaySound(i, 1020, 0.0, 0.0, 0.0);
				}
				else PlayerPlaySound(i, 1022, 0.0, 0.0, 0.0);
			}
			if (ElevatorAttachableObjects[e][0] && !ElevatorInfo[e][LightChanged])
			{
				ElevatorInfo[e][LightChanged] = true;
				SwapElevatorLights(e, 1);
			}
			if (ElevatorInfo[e][NewLevel] > ElevatorInfo[e][CurrentLevel]) ElevatorInfo[e][NewLiftSpeed] = ElevatorMoveSpeeds[e][2];
			else if (ElevatorInfo[e][NewLevel] < ElevatorInfo[e][CurrentLevel]) ElevatorInfo[e][NewLiftSpeed] = ElevatorMoveSpeeds[e][3];
			MoveObject(ObjectInfo[e][ElevatorObject], ObjectInfo[e][ElevatorCurrentX], ObjectInfo[e][ElevatorCurrentY], ElevatorLevels[e][ElevatorInfo[e][NewLevel] - 1], ElevatorInfo[e][NewLiftSpeed]);
			MoveObject(ObjectInfo[e][Door1Object], ObjectInfo[e][Door1CurrentX], ObjectInfo[e][Door1CurrentY], ElevatorLevels[e][ElevatorInfo[e][NewLevel] - 1] - 0.133423, ElevatorInfo[e][NewLiftSpeed]);
			MoveObject(ObjectInfo[e][Door2Object], ObjectInfo[e][Door2CurrentX], ObjectInfo[e][Door2CurrentY], ElevatorLevels[e][ElevatorInfo[e][NewLevel] - 1] - 0.133423, ElevatorInfo[e][NewLiftSpeed]);
			if (ElevatorAttachableObjects[e][0]) MoveObject(ObjectInfo[e][LightObject], ObjectInfo[e][ElevatorCurrentX], ObjectInfo[e][ElevatorCurrentY], ElevatorLevels[e][ElevatorInfo[e][NewLevel] - 1] + 1.863229, ElevatorInfo[e][NewLiftSpeed]);
			if (ElevatorAttachableObjects[e][1]) MoveObject(ObjectInfo[e][SupportObject], ObjectInfo[e][ElevatorCurrentX], ObjectInfo[e][ElevatorCurrentY], ElevatorLevels[e][ElevatorInfo[e][NewLevel] - 1] - 33.785002, ElevatorInfo[e][NewLiftSpeed]);
			if (ObjectInfo[e][ElevatorCurrentZ] == ElevatorLevels[e][ElevatorInfo[e][NewLevel] - 1])
			{
				AdjustElevatorDoors(e, true);
				ElevatorInfo[e][CurrentLevel] = ElevatorInfo[e][NewLevel];
				if (ElevatorInfo[e][Called]) ElevatorInfo[e][Called] = false;
				if (ElevatorAttachableObjects[e][0]) ElevatorInfo[e][LightChanged] = false;
				if (ElevatorInfo[e][Moving]) ElevatorInfo[e][Moving] = false;
				if (ElevatorAttachableObjects[e][0]) SwapElevatorLights(e, 0);
			}
		}
	}
	return 1;
}
//==============================================================================
// Modified function of IsPlayerInCube (by 50p) that returns true if at least
// one player is in a cube
//==============================================================================
IsAPlayerInCube(Float:xmin, Float:ymin, Float:zmin, Float:xmax, Float:ymax, Float:zmax)
{
    new Float:x, Float:y, Float:z;
	for (new i; i < MAX_PLAYERS; i++)
	{
		if (!IsPlayerConnected(i)) continue;
		GetPlayerPos(i, x, y, z);
		if (x > xmin && y > ymin && z > zmin && x < xmax && y < ymax && z < zmax) return 1;
	}
	return 0;
}
//==============================================================================
// Checks if the player is in an area (thanks Y_Less)
//==============================================================================
IsPlayerInArea(playerid, Float:minx, Float:maxx, Float:miny, Float:maxy)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if (x > minx && x < maxx && y > miny && y < maxy) return 1;
	return 0;
}
//==============================================================================
// Gets the distance between two three-dimensional points (thanks Boylett)
//==============================================================================
Float:GetPointDistanceToPointEx(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
	new Float:x, Float:y, Float:z;
	x = x1 - x2;
	y = y1 - y2;
	z = z1 - z2;
	return floatsqroot(x * x + y * y + z * z);
}
//==============================================================================
// Gets the position of the elevators and all of the objects attached to them
//==============================================================================
LocateElevator(elevatorid)
{
	GetObjectPos(ObjectInfo[elevatorid][ElevatorObject], ObjectInfo[elevatorid][ElevatorCurrentX], ObjectInfo[elevatorid][ElevatorCurrentY], ObjectInfo[elevatorid][ElevatorCurrentZ]);
	GetObjectPos(ObjectInfo[elevatorid][Door1Object], ObjectInfo[elevatorid][Door1CurrentX], ObjectInfo[elevatorid][Door1CurrentY], ObjectInfo[elevatorid][Door1CurrentZ]);
	GetObjectPos(ObjectInfo[elevatorid][Door2Object], ObjectInfo[elevatorid][Door2CurrentX], ObjectInfo[elevatorid][Door2CurrentY], ObjectInfo[elevatorid][Door2CurrentZ]);
	return 1;
}
//==============================================================================
// Prepares the elevators to begin moving to a new level
//==============================================================================
public SetElevatorLevel(elevatorid, newlevel)
{
	for (new e; e < MAX_ELEVATORS; e++)
	{
	    if (elevatorid != e) continue;
		ElevatorInfo[e][NewLevel] = newlevel;
		if (ElevatorInfo[e][RequestedCall])
		{
			ElevatorInfo[e][Called] = true;
			ElevatorInfo[e][RequestedCall] = false;
		}
		else if (ElevatorInfo[e][RequestedMove])
		{
		    ElevatorInfo[e][Moving] = true;
			ElevatorInfo[e][RequestedMove] = false;
		}
		break;
	}
	return 1;
}
//==============================================================================
// Changes the lights on top of the elevator when it begins to move or when it
// stops
//==============================================================================
SwapElevatorLights(elevatorid, lightid)
{
    DestroyObject(ObjectInfo[elevatorid][LightObject]);
	if (lightid == 0) ObjectInfo[elevatorid][LightObject] = CreateObject(1215, ElevatorCoordinates[elevatorid][0], ElevatorCoordinates[elevatorid][1], ElevatorLevels[elevatorid][ElevatorInfo[elevatorid][NewLevel] - 1] + 1.863229, 0.0, 0.0, 0.0);
	else if (lightid == 1) CreateObject(3666, ObjectInfo[elevatorid][ElevatorCurrentX], ObjectInfo[elevatorid][ElevatorCurrentY], ObjectInfo[elevatorid][ElevatorCurrentZ] + 1.863229, 0.0, 0.0, 0.0);
	return 1;
}

