//==============================================================================
// Incognito's Elevator Filterscript Add-On
//
// This adds a few custom objects to the default construction site in LS to make
// it a  bit more realistic (note that they are not streamed). A 36-floor
// construction site has also been added south of Area 69. This filterscript can
// be run alongside the main filterscript, but in order to add the elevators to
// the "mega" construction site, you'll need to make a few edits. This is
// explained below.
//==============================================================================

/*

--------------------------------------------------------------------------------
Adding the elevators at the "mega" construction site:
You'll need to replace a few things at the very top of the main filterscript.
Note that the first two columns in these edits correspond to the two elevators
in LS, and the last two columns correspond to the two elevators south of Area
69, which are the ones you'll be adding.

Simply replace everything that needs replacing with the text that is marked to
be copied below.
--------------------------------------------------------------------------------

*** START COPYING BELOW THIS LINE. ***

//==============================================================================
// Defines:
// - MAX_ELEVATORS specifies the number of elevators (default is 2).
// - MAX_LEVELS specifies the number of levels (default is 8).
//
// If you want to change these defines, you'll have to edit a few of the
// variables below.
//==============================================================================
#define MAX_ELEVATORS 4
#define MAX_LEVELS 36
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
	{true, true},
	{true, false},
	{true, false}
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
	{1883.477173, -1315.910156},
	{2.310921, 1537.146240},
	{5.760921, 1537.146240}
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
	{14.840647, 19.715614, 24.715595, 29.715588, 34.715614, 39.715675, 44.715675, 49.640686, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
	{14.840647, 19.715614, 24.715595, 29.715588, 34.715614, 39.715675, 44.715675, 49.640686, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
	{13.090273, 18.015270, 23.015270, 28.015270, 33.015266, 38.015266, 43.015282, 47.940323, 52.965324, 57.965324, 62.965355, 67.965340, 72.965324, 77.965355, 82.890396, 87.915398, 92.915413, 97.915428, 102.915443, 107.915428, 112.915443, 117.840424, 122.865425, 127.865440, 132.865387, 137.865387, 142.865326, 147.865265, 152.790161, 157.815033, 162.815033, 167.814850, 172.814789, 177.814667, 182.814545, 187.739441},
	{13.090273, 18.015270, 23.015270, 28.015270, 33.015266, 38.015266, 43.015282, 47.940323, 52.965324, 57.965324, 62.965355, 67.965340, 72.965324, 77.965355, 82.890396, 87.915398, 92.915413, 97.915428, 102.915443, 107.915428, 112.915443, 117.840424, 122.865425, 127.865440, 132.865387, 137.865387, 142.865326, 147.865265, 152.790161, 157.815033, 162.815033, 167.814850, 172.814789, 177.814667, 182.814545, 187.739441}
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
	{1.0, 1.0, 2.0, 2.0},
	{1.0, 1.0, 5.0, 3.5},
	{1.0, 1.0, 5.0, 3.5}
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
	{"Lobby", "Storage Room", "Surveillance", "Drug Store", "Tools Store", "Ammu-Nation", "Viewing Room", "Roof", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""},
	{"Lobby", "Storage Room", "Surveillance", "Drug Store", "Tools Store", "Ammu-Nation", "Viewing Room", "Roof", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""},
	{"Floor 1", "Floor 2", "Floor 3", "Floor 4", "Floor 5", "Floor 6", "Floor 7", "Floor 8", "Floor 9", "Floor 10", "Floor 11", "Floor 12", "Floor 13", "Floor 14", "Floor 15", "Floor 16", "Floor 17", "Floor 18", "Floor 19", "Floor 20", "Floor 21", "Floor 22", "Floor 23", "Floor 24", "Floor 25", "Floor 26", "Floor 27", "Floor 28", "Floor 29", "Floor 30", "Floor 31", "Floor 32", "Floor 33", "Floor 34", "Floor 35", "Floor 36"},
	{"Floor 1", "Floor 2", "Floor 3", "Floor 4", "Floor 5", "Floor 6", "Floor 7", "Floor 8", "Floor 9", "Floor 10", "Floor 11", "Floor 12", "Floor 13", "Floor 14", "Floor 15", "Floor 16", "Floor 17", "Floor 18", "Floor 19", "Floor 20", "Floor 21", "Floor 22", "Floor 23", "Floor 24", "Floor 25", "Floor 26", "Floor 27", "Floor 28", "Floor 29", "Floor 30", "Floor 31", "Floor 32", "Floor 33", "Floor 34", "Floor 35", "Floor 36"}
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
	{1885.636479, -1319.999963},
	{0.343653, 1533.081458},
	{7.945226, 1533.081458}
};

*** STOP COPYING ABOVE THIS LINE. ***

*/

//==============================================================================
// Includes
//==============================================================================
#include <a_samp>
#include <y_objects>
//==============================================================================
// Objects
//==============================================================================
new Object1, Object2, Object3, Object4, Object5, Object6, Object7, Object8, Object9, Object10, Object11, Object12,
	Object13, Object14, Object15, Object16, Object17, Object18, Object19, Object20, Object21, Object22, Object23, Object24,
	Object25, Object26, Object27, Object28, Object29, Object30, Object31, Object32, Object33, Object34, Object35, Object36,
	Object37, Object38, Object39, Object40, Object41, Object42, Object43, Object44, Object45, Object46, Object47, Object48,
	Object49, Object50, Object51, Object52, Object53, Object54, Object55, Object56, Object57, Object58, Object59, Object60,
	Object61, Object62, Object63, Object64, Object65, Object66, Object67;
//==============================================================================
// Creates the objects
//==============================================================================
public OnFilterScriptInit()
{
	Object_Object();
//------------------------------------------------------------------------------
// These objects are just a few boxes and crates that I put in the default
// construction site in LS. I think they're pretty well-placed and make the
// building much less boring.
//------------------------------------------------------------------------------
	Object1 = CreateDynamicObject(925, 1893.239380, -1307.167847, 24.554092, 0, 0, 135);
	Object2 = CreateDynamicObject(944, 1889.454956, -1316.659790, 24.381258, 0, 0, 112.5);
	Object3 = CreateDynamicObject(1431, 1889.238159, -1316.682129, 25.489967, 0, 0, 292.5);
	Object4 = CreateDynamicObject(2567, 1871.561401, -1314.821899, 25.419788, 0, 0, 90);
	Object5 = CreateDynamicObject(3576, 1872.445190, -1323.734131, 24.984859, 0, 0, 123.75);
	Object6 = CreateDynamicObject(3577, 1875.468384, -1309.620483, 24.274694, 0, 0, 157.5003);
	Object7 = CreateDynamicObject(3630, 1874.490845, -1307.927002, 34.984810, 0, 0, 180);
	Object8 = CreateDynamicObject(3761, 1883.674561, -1306.768066, 25.491169, 0, 0, 90.0001);
	Object9 = CreateDynamicObject(5260, 1873.828247, -1312.886597, 20.202702, 0, 0, 270.0001);
	Object10 = CreateDynamicObject(18257, 1889.628052, -1318.157227, 33.498913, 0, 0, 270);
	Object11 = CreateDynamicObject(12930, 1873.506348, -1323.981934, 34.347416, 0, 0, 0);
	Object12 = CreateDynamicObject(5269, 1888.052002, -1324.039063, 30.801235, 0, 0, 90);
	Object13 = CreateDynamicObject(3761, 1884.764648, -1307.738037, 35.491169, 0, 0, 90);
	Object14 = CreateDynamicObject(1431, 1891.231934, -1323.811523, 35.485687, 0, 0, 45);
	Object15 = CreateDynamicObject(944, 1891.334473, -1323.899292, 34.376976, 0, 0, 45);
	Object16 = CreateDynamicObject(3035, 1892.562378, -1324.916626, 24.262323, 0, 0, 56.25);
	Object17 = CreateDynamicObject(2971, 1881.838257, -1324.487305, 23.487110, 0, 0, 337.5);
	Object18 = CreateDynamicObject(2973, 1892.539551, -1308.899292, 28.491177, 0, 0, 236.2501);
	Object19 = CreateDynamicObject(2991, 1893.015991, -1324.423950, 19.119923, 0, 0, 45);
	Object20 = CreateDynamicObject(3630, 1888.627441, -1307.819946, 19.984810, 0, 0, 180);
	Object21 = CreateDynamicObject(3761, 1870.401367, -1324.235474, 20.491169, 0, 0, 213.7502);
	Object22 = CreateDynamicObject(3630, 1871.423706, -1320.258179, 29.984810, 0, 0, 270);
	Object23 = CreateDynamicObject(925, 1879.793945, -1307.404907, 29.554092, 0, 0, 0);
	Object24 = CreateDynamicObject(2567, 1891.997437, -1317.129517, 30.425295, 0, 0, 90);
	Object25 = CreateDynamicObject(18257, 1873.338989, -1316.051147, 28.492188, 0, 0, 270);
	Object26 = CreateDynamicObject(2991, 1871.407227, -1309.098022, 39.119923, 0, 0, 270);
	Object27 = CreateDynamicObject(944, 1877.510620, -1323.393433, 29.376974, 0, 0, 146.2501);
	Object28 = CreateDynamicObject(1431, 1877.624268, -1323.242188, 30.485683, 0, 0, 326.25);
	Object29 = CreateDynamicObject(925, 1880.400635, -1307.401978, 19.554092, 0, 0, 0);
	Object30 = CreateDynamicObject(2567, 1878.785156, -1307.287354, 40.419788, 0, 0, 0);
	Object31 = CreateDynamicObject(3577, 1889.582397, -1310.724609, 39.274696, 0, 0, 123.7499);
	Object32 = CreateDynamicObject(5269, 1892.900757, -1320.260986, 40.793556, 0, 0, 0);
	Object33 = CreateDynamicObject(18257, 1872.281250, -1321.796021, 38.492188, 0, 0, 270);
	Object34 = CreateDynamicObject(2971, 1875.913696, -1311.025757, 38.487110, 0, 0, 236.2501);
	Object35 = CreateDynamicObject(2973, 1885.352905, -1307.910522, 38.485668, 0, 0, 22.5);
	Object36 = CreateDynamicObject(2974, 1891.812256, -1314.129272, 38.483978, 0, 0, 326.25);
	Object37 = CreateDynamicObject(18092, 1886.868530, -1325.100342, 38.991608, 0, 0, 0.0002);
	Object38 = CreateDynamicObject(18092, 1876.892212, -1325.117798, 33.991608, 0, 0, 0);
	Object39 = CreateDynamicObject(2061, 1885.830322, -1324.727173, 39.784058, 0, 0, 0);
	Object40 = CreateDynamicObject(2060, 1888.750244, -1324.026367, 38.648846, 0, 0, 0);
	Object41 = CreateDynamicObject(2060, 1888.750244, -1324.026367, 38.964298, 0, 0, 0);
	Object42 = CreateDynamicObject(2228, 1879.429810, -1325.143311, 34.048134, 0, 0, 270);
	Object43 = CreateDynamicObject(2690, 1874.962524, -1324.929321, 34.851543, 0, 0, 180);
	Object44 = CreateDynamicObject(2045, 1877.953735, -1324.899658, 34.535122, 2.5783, 0, 112.5001);
	Object45 = CreateDynamicObject(3123, 1874.872070, -1326.393677, 35.516396, 355.1547, 170.9238, 356.5026);
	Object46 = CreateDynamicObject(2358, 1884.860107, -1324.736450, 39.608662, 0, 0, 180);
	Object47 = CreateDynamicObject(2358, 1884.860107, -1324.736450, 39.852974, 0, 0, 180);
	Object48 = CreateDynamicObject(3124, 1888.362793, -1324.374023, 39.696362, 313.5904, 55.8633, 216.4056);
	Object49 = CreateDynamicObject(12930, 1890.447754, -1309.073975, 19.300476, 0, 0, 180);
	Object50 = CreateDynamicObject(2709, 1886.847412, -1307.184082, 29.631788, 0, 0, 0);
	Object51 = CreateDynamicObject(1580, 1888.907715, -1306.980957, 29.480543, 0, 0, 315);
	Object52 = CreateDynamicObject(1241, 1884.999268, -1307.025146, 29.564024, 89.3814, 359.1406, 168.75);
	Object53 = CreateDynamicObject(18092, 1886.918457, -1306.878174, 28.991610, 0, 0, 180);
	Object54 = CreateDynamicObject(2709, 1887.206177, -1307.376953, 29.581789, 0, 91.1003, 307.952);
	Object55 = CreateDynamicObject(1242, 1886.917480, -1324.759399, 39.644573, 0, 0, 0);
	Object56 = CreateDynamicObject(3044, 1885.801636, -1307.086426, 29.531784, 0, 0, 45);
//------------------------------------------------------------------------------
// These objects form the "mega" construction site just south of Area 69.
// They're stacked on top of each other (with the "frame" object of each
// building's Y-axis just slightly adjusted to prevent it from flashing), making
// a grand total of 36 floors.
//------------------------------------------------------------------------------
	Object57 = CreateDynamicObject(5463, 4.078737, 1537.529541, 36.244511, 0, 0, 0);
	Object58 = CreateDynamicObject(5463, 4.078537, 1537.527541, 71.194527, 0, 0, 0);
	Object59 = CreateDynamicObject(5463, 4.078737, 1537.529541, 106.144478, 0, 0, 0);
	Object60 = CreateDynamicObject(5463, 4.078537, 1537.527541, 141.094681, 0, 0, 0);
	Object61 = CreateDynamicObject(5463, 4.078737, 1537.529541, 176.044632, 0, 0, 0);
	Object62 = CreateDynamicObject(5644, 4.078737, 1537.149536, 29.319490, 0, 0, 0);
	Object63 = CreateDynamicObject(5644, 4.078737, 1537.149536, 54.619492, 0, 0, 0);
	Object64 = CreateDynamicObject(5644, 4.078737, 1537.149536, 79.919479, 0, 0, 0);
	Object65 = CreateDynamicObject(5644, 4.078737, 1537.149536, 105.219467, 0, 0, 0);
	Object66 = CreateDynamicObject(5644, 4.078737, 1537.149536, 130.519638, 0, 0, 0);
	Object67 = CreateDynamicObject(5644, 4.078737, 1537.149536, 155.819687, 0, 0, 0);
	return 1;
}
//==============================================================================
// Destroys the objects
//==============================================================================
public OnFilterScriptExit()
{
	DestroyDynamicObject(Object1);
	DestroyDynamicObject(Object2);
	DestroyDynamicObject(Object3);
	DestroyDynamicObject(Object4);
	DestroyDynamicObject(Object5);
	DestroyDynamicObject(Object6);
	DestroyDynamicObject(Object7);
	DestroyDynamicObject(Object8);
	DestroyDynamicObject(Object9);
	DestroyDynamicObject(Object10);
	DestroyDynamicObject(Object11);
	DestroyDynamicObject(Object12);
	DestroyDynamicObject(Object13);
	DestroyDynamicObject(Object14);
	DestroyDynamicObject(Object15);
	DestroyDynamicObject(Object16);
	DestroyDynamicObject(Object17);
	DestroyDynamicObject(Object18);
	DestroyDynamicObject(Object19);
	DestroyDynamicObject(Object20);
	DestroyDynamicObject(Object21);
	DestroyDynamicObject(Object22);
	DestroyDynamicObject(Object23);
	DestroyDynamicObject(Object24);
	DestroyDynamicObject(Object25);
	DestroyDynamicObject(Object26);
	DestroyDynamicObject(Object27);
	DestroyDynamicObject(Object28);
	DestroyDynamicObject(Object29);
	DestroyDynamicObject(Object30);
	DestroyDynamicObject(Object31);
	DestroyDynamicObject(Object32);
	DestroyDynamicObject(Object33);
	DestroyDynamicObject(Object34);
	DestroyDynamicObject(Object35);
	DestroyDynamicObject(Object36);
	DestroyDynamicObject(Object37);
	DestroyDynamicObject(Object38);
	DestroyDynamicObject(Object39);
	DestroyDynamicObject(Object40);
	DestroyDynamicObject(Object41);
	DestroyDynamicObject(Object42);
	DestroyDynamicObject(Object43);
	DestroyDynamicObject(Object44);
	DestroyDynamicObject(Object45);
	DestroyDynamicObject(Object46);
	DestroyDynamicObject(Object47);
	DestroyDynamicObject(Object48);
	DestroyDynamicObject(Object49);
	DestroyDynamicObject(Object50);
	DestroyDynamicObject(Object51);
	DestroyDynamicObject(Object52);
	DestroyDynamicObject(Object53);
	DestroyDynamicObject(Object54);
	DestroyDynamicObject(Object55);
	DestroyDynamicObject(Object56);
	DestroyDynamicObject(Object57);
	DestroyDynamicObject(Object58);
	DestroyDynamicObject(Object59);
	DestroyDynamicObject(Object60);
	DestroyDynamicObject(Object61);
	DestroyDynamicObject(Object62);
	DestroyDynamicObject(Object63);
	DestroyDynamicObject(Object64);
	DestroyDynamicObject(Object65);
	DestroyDynamicObject(Object66);
	DestroyDynamicObject(Object67);
	return 1;
}
