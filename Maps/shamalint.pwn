
/*

============================================================================= ®
||                  *********              ***************                  ||
||                 ***********            *****************                 ||
||                 ***                           ****                       ||
||                 ***                           ****                       ||
||                 ***                           ****                       ||
||                 ***********              *********                       ||
||                  **********             *********                        ||
=============================================================================
Please Do Not Remove The Credits.
  © August 2009 CozJoe

*/

#include <a_samp>

new InShamal[MAX_PLAYERS];
new Float:ShamalPos[MAX_VEHICLES][3];
new sExplode[MAX_VEHICLES];
new tCount[MAX_VEHICLES];


#define objects_per_shamal 14

#define SETY_DE 5.87
#define SETZ_DE 0.75

public OnFilterScriptInit()
{
	print("---------------------------------------");
	print("Loaded 'Shamal Interior'");
	print("---------------------------------------");
	return 1;
}

forward ExplodeShamal(vehicleid);

stock CreateShamalInt(vehicleid, Float:X, Float:Y, Float:Z)
{
CreateObject(14404, 3713.617676, -1861.037109, 640.462341, 0.0000, 0.0000, 0.0000);
CreateObject(1523, 3714.215820, -1867.482910, 638.818237, 0.0000, 0.0000, 270.0000);
CreateObject(2528, 3716.258301, -1868.387573, 638.712341, 0.0000, 0.0000, 270.0000);
CreateObject(1562, 3714.822021, -1865.348022, 639.367554, 0.0000, 0.0000, 180.0000);
CreateObject(1562, 3714.901855, -1862.988525, 639.367554, 0.0000, 0.0000, 180.0000);
CreateObject(1562, 3714.876221, -1861.333862, 639.367554, 0.0000, 0.0000, 0.0000);
CreateObject(1562, 3712.394043, -1866.465210, 639.367554, 0.0000, 0.0000, 180.0000);
CreateObject(1562, 3712.352295, -1864.174561, 639.367554, 0.0000, 0.0000, 180.0000);
CreateObject(1562, 3712.373535, -1862.417114, 639.367554, 0.0000, 0.0000, 0.0000);
CreateObject(1563, 3714.872803, -1860.978149, 639.867615, 0.0000, 0.0000, 0.0000);
CreateObject(1563, 3714.906250, -1863.331421, 639.867615, 0.0000, 0.0000, 180.0000);
CreateObject(1563, 3714.828125, -1865.700317, 639.892639, 0.0000, 0.0000, 180.0000);
CreateObject(1563, 3712.372314, -1862.038452, 639.892639, 0.0000, 0.0000, 0.0000);
CreateObject(1563, 3712.348877, -1864.537842, 639.892639, 0.0000, 0.0000, 180.0000);
CreateObject(1563, 3712.401123, -1866.794922, 639.892639, 0.0000, 0.0000, 180.0000);
CreateObject(1808, 3712.209229, -1868.986450, 638.707214, 0.0000, 0.0000, 90.0000);
CreateObject(1516, 3712.191895, -1867.779907, 638.862732, 0.0000, 0.0000, 270.0000);
CreateObject(1509, 3711.989990, -1868.227173, 639.562073, 0.0000, 0.0000, 191.2500);
CreateObject(1512, 3711.991455, -1868.045532, 639.548401, 0.0000, 0.0000, 258.7500);
CreateObject(1520, 3711.988525, -1867.875854, 639.439026, 0.0000, 0.0000, 180.0000);
CreateObject(1543, 3711.987793, -1867.751709, 639.380981, 0.0000, 0.0000, 0.0000);
CreateObject(1544, 3711.988281, -1867.595093, 639.377136, 0.0000, 0.0000, 0.0000);
CreateObject(1546, 3711.987549, -1867.440430, 639.477356, 0.0000, 0.0000, 0.0000);
CreateObject(1547, 3712.631836, -1867.804077, 639.394409, 0.0000, 0.0000, 90.0000);
CreateObject(1664, 3711.988770, -1867.285522, 639.542603, 0.0000, 0.0000, 303.7500);
CreateObject(1665, 3712.594971, -1868.216797, 639.423462, 0.0000, 0.0000, 247.5000);
CreateObject(1666, 3712.417725, -1867.534668, 639.468750, 0.0000, 0.0000, 0.0000);
CreateObject(1667, 3712.250488, -1867.828613, 639.476563, 0.0000, 0.0000, 0.0000);
CreateObject(1667, 3712.311279, -1868.015015, 639.476563, 0.0000, 0.0000, 0.0000);
CreateObject(1455, 3712.321045, -1868.943848, 639.480896, 0.0000, 0.0000, 0.0000);
CreateObject(2634, 3713.646729, -1856.853516, 639.914001, 0.0000, 0.0000, 0.0000);
ShamalPos[vehicleid][0] = X, ShamalPos[vehicleid][1] = Y, ShamalPos[vehicleid][2] = Z;
}

stock SetPlayerPosInShamal(playerid, shamalid)
{
	SetPlayerPos(playerid, 3713.665039, -1858.494507, 639.482361);
	SetPlayerFacingAngle(playerid, 0.0);
	SetCameraBehindPlayer(playerid);
	InShamal[playerid] = shamalid;
}

stock ShamalExists(vehicleid)
{
	if (floatsqroot(ShamalPos[vehicleid][0] + ShamalPos[vehicleid][1] + ShamalPos[vehicleid][2]))
	{
		return 1;
	}
	return 0;
}

Float:randomEx(randval)
{
	new rand1 = random(2), rand2;
	return float(rand1 == 0 ? rand2 - random(randval) : rand2 + random(randval));
}

public OnPlayerConnect(playerid)
{
	InShamal[playerid] = 0;
	return 1;
}

stock get_available_objects()
{
	new objects = 0;
	for (new i = 1; i <= MAX_OBJECTS; i++) {
		if (IsValidObject(i)) objects ++;
	}
	return MAX_OBJECTS-objects;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if (ispassenger != 0)
	{
		if (GetVehicleModel(vehicleid) == 519)
		{
			if (ShamalExists(vehicleid) == 0)
			{
				if (get_available_objects() > (MAX_OBJECTS-objects_per_shamal)) return 1;
				CreateShamalInt(vehicleid, randomEx(3000), randomEx(3000), float(random(100)+800));
			}
			SetPlayerPosInShamal(playerid, vehicleid);
		}
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys == 16 && InShamal[playerid] != 0)
	{
		new Float:X, Float:Y, Float:Z, Float:A;
		GetVehiclePos(InShamal[playerid], X, Y, Z);
		GetVehicleZAngle(InShamal[playerid], A);
		X += (5.0*floatsin(-(A-45.0), degrees)), Y += (5.0*floatcos(-(A-45.0), degrees));
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid, X, Y, Z-0.94);
		SetPlayerFacingAngle(playerid, A);
		InShamal[playerid] = 0;
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	InShamal[playerid] = 0;
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	if (GetVehicleModel(vehicleid) == 519 && ShamalExists(vehicleid) != 0)
	{
		CreateExplosion(ShamalPos[vehicleid][0], ShamalPos[vehicleid][1], ShamalPos[vehicleid][2], 2, 15.0);
		sExplode[vehicleid] = SetTimerEx("ExplodeShamal", 700, 0, "d", vehicleid);
		tCount[vehicleid] = true;
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	tCount[vehicleid] = false;
	for (new i = 0; i != MAX_PLAYERS; i++)
	{
		if (InShamal[i] == vehicleid) SetPlayerHealth(i, 0.0);
	}
	return 1;
}

public ExplodeShamal(vehicleid)
{
	KillTimer(sExplode[vehicleid]);
	if (tCount[vehicleid])
	{
		CreateExplosion(ShamalPos[vehicleid][0], ShamalPos[vehicleid][1], ShamalPos[vehicleid][2], 2, 15.0);
		sExplode[vehicleid] = SetTimerEx("ExplodeShamal", random(1300) + 100, 0, "d", vehicleid);
	}
}
