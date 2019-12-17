// Vehicle position saving example script, by BeckzyBoi.

#include <a_samp>
#include <dini>

#define CAR_AMOUNT 10           // Change to the exact amount of vehicles you will be adding.

forward SaveVehiclePos();

new VehAmount;

// Change each of these next lines of floats to the parameter values of your desired vehicle info.
// ModelID, X, Y, Z, Facing Angle, Color1, Color2.
// For each new vehicle that you want to add, add a new line for that vehicle.
// Make all integers both required and/or desired into a float of the same value.

new Float:VSpawnInfo[CAR_AMOUNT][7] = {
{0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
{0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
{0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
{0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
{0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
{0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
{0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
{0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
{0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
{0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0}
};

stock AddStaticVehicleSave(model, Float:X, Float:Y, Float:Z, Float:A, color1, color2)
{
	AddStaticVehicle(model, X, Y, Z, A, color1, color2);
	VehAmount ++;
	VSpawnInfo[VehAmount-1][0] = model, VSpawnInfo[VehAmount-1][1] = X,
	VSpawnInfo[VehAmount-1][2] = Y, VSpawnInfo[VehAmount-1][3] = Z,
	VSpawnInfo[VehAmount-1][4] = A, VSpawnInfo[VehAmount-1][5] = color1,
	VSpawnInfo[VehAmount-1][6] = color2;
	new vehname[12];
	format(vehname, sizeof(vehname), "Vehicle%d", VehAmount);
	dini_Create(vehname);
	dini_IntSet(vehname, "M", model), dini_FloatSet(vehname, "X", X),
	dini_FloatSet(vehname, "Y", Y), dini_FloatSet(vehname, "Z", Z),
	dini_FloatSet(vehname, "A", A), dini_IntSet(vehname, "C1", color1),
	dini_IntSet(vehname, "C2", color2);
}

stock SaveAllVehiclePositions()
{
	new Float:X, Float:Y, Float:Z, Float:A, vehname[12];
	for (new v; v < CAR_AMOUNT; v++)
	{
		format(vehname, sizeof(vehname), "Vehicle%d", v+1);
		GetVehiclePos(v+1, X, Y, Z), GetVehicleZAngle(v+1, A);
		dini_FloatSet(vehname, "X", X), dini_FloatSet(vehname, "Y", Y),
		dini_FloatSet(vehname, "Z", Z), dini_FloatSet(vehname, "A", A);
		VSpawnInfo[v][1] = X, VSpawnInfo[v][2] = Y, VSpawnInfo[v][3] = Z, VSpawnInfo[v][4] = A;
	}
}

public OnGameModeInit()
{
	new vehname[12];
	for (new a; a < CAR_AMOUNT; a++)
	{
		format(vehname, sizeof(vehname), "Vehicle%d", a+1);
		if (!dini_Exists(vehname))
		{
			AddStaticVehicleSave(floatround(VSpawnInfo[a][0]), VSpawnInfo[a][1], VSpawnInfo[a][2],
			VSpawnInfo[a][3], VSpawnInfo[a][4], floatround(VSpawnInfo[a][5]), floatround(VSpawnInfo[a][6]));
		}
		else {
			AddStaticVehicle(dini_Int(vehname, "M"), dini_Float(vehname, "X"),	dini_Float(vehname, "Y"),
  			dini_Float(vehname, "Z"), dini_Float(vehname, "A"), dini_Int(vehname, "C1"), dini_Int(vehname, "C2"));
			VehAmount ++;
		}
	}
	SetTimer("SaveVehiclePos", 3000, 1);
    return 1;
}

public OnGameModeExit()
{
	SaveAllVehiclePositions();
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
    SetVehiclePos(vehicleid, VSpawnInfo[vehicleid-1][1], VSpawnInfo[vehicleid-1][2], VSpawnInfo[vehicleid-1][3]);
    SetVehicleZAngle(vehicleid, VSpawnInfo[vehicleid-1][4]);
    return 1;
}

public SaveVehiclePos()
{
	SaveAllVehiclePositions();
}

