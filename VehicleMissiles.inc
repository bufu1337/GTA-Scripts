//Backwardsman97

#include <a_samp>

/*------------------------------------
native AddVehicleMissiles(vehicleid,Float:offsetx,Float:offsetz)
native RemoveVehicleMissiles(vehicleid)
native IsVehicleHot(vehicleid)
-------------------------------------*/

#define MISSILE_DETONATE_TIME 500	//milliseconds
#define MISSILE_EXPLODE_TYPE 10
#define MISSILE_EXPLODE_RADIUS 10.0
#define MISSILE_SPEED 40.0
#define MISSILE_FIRE_KEY 1

new VehicleFire[MAX_VEHICLES];
new VehicleBomb[MAX_VEHICLES][2];
new VehicleSmok[MAX_VEHICLES][2];
new Float:VehicleOffsetX[MAX_VEHICLES];
new Float:VehicleOffsetZ[MAX_VEHICLES];

forward VM_OnPlayerKeyStateChange(playerid,newkeys);
forward VM_Explode(vehicleid,mode);
forward VM_OnVehicleFire(vehicleid,slot);

stock AddVehicleMissiles(vehicleid,Float:offsetx,Float:offsetz)
{
	if(!VehicleFire[vehicleid])
	{
		new Float:x,Float:u;
		GetVehiclePos(vehicleid,x,u,u);
		if(x != 0)
		{
			if(!IsValidObject(VehicleBomb[vehicleid][1]))
			{
				
				VehicleBomb[vehicleid][0] = CreateObject(3790,0.0,0.0,0.0,0,0,0,300.0);
				VehicleBomb[vehicleid][1] = CreateObject(3790,0.0,0.0,0.0,0,0,0,300.0);

				AttachObjectToVehicle(VehicleBomb[vehicleid][0],vehicleid,offsetx,0,offsetz,0,0,270);
				AttachObjectToVehicle(VehicleBomb[vehicleid][1],vehicleid,-offsetx,0,offsetz,0,0,270);

				VehicleOffsetX[vehicleid] = offsetx;
				VehicleOffsetZ[vehicleid] = offsetz;
				return 1;
			}
		}
	}
	return 0;
}

stock RemoveVehicleMissiles(vehicleid)
{
	if(!VehicleFire[vehicleid])
	{
		if(VehicleBomb[IsValidObject(vehicleid][1]))
		{
			if(VehicleBomb[vehicleid][0])
			{
				DestroyObject(VehicleBomb[vehicleid][0]);
				DestroyObject(VehicleBomb[vehicleid][1]);
				return 1;
			}
			return DestroyObject(VehicleBomb[vehicleid][1]),1;
		}
	}
	return 0;
}

stock IsVehicleHot(vehicleid)
{
	if(IsValidObject(VehicleBomb[vehicleid][1]))
		return 1;

	return 0;
}


public VM_OnPlayerKeyStateChange(playerid,newkeys)
{
	if((newkeys & MISSILE_FIRE_KEY) == (MISSILE_FIRE_KEY))
	{
		new id = GetPlayerVehicleID(playerid);
		if(!VehicleFire[id])
		{
			if(id)
			{
				if(IsValidObject(VehicleBomb[id][1]))
				{
					new
					Float:x,
					Float:y,
					Float:z,
					Float:a;


					VehicleFire[id] = 1;

					if(IsValidObject(VehicleBomb[id][0]))
					{
						DestroyObject(VehicleBomb[id][0]);

						GetVehiclePos(id,x,y,z);
						GetVehicleZAngle(id,a);

						a += 270;
						z += VehicleOffsetZ[id];

						x += (VehicleOffsetX[id] * floatsin(-a, degrees));
						y += (VehicleOffsetX[id] * floatcos(-a, degrees));

						VehicleBomb[id][0] = CreateObject(3790,x,y,z,0,0,a,300.0);
						VehicleSmok[id][0] = CreateObject(18731,x,y,z-1.3,0,0,0,300.0);

						a += 90;

						x += (30 * floatsin(-a, degrees));
						y += (30 * floatcos(-a, degrees));

						MoveObject(VehicleBomb[id][0],x,y,z,MISSILE_SPEED);
						MoveObject(VehicleSmok[id][0],x,y,z-1.3,MISSILE_SPEED);

						SetTimerEx("VM_Explode",MISSILE_DETONATE_TIME,0,"dd",id,0);
						VM_OnVehicleFire(id,0);
						return 1;
					}
					DestroyObject(VehicleBomb[id][1]);

					GetVehiclePos(id,x,y,z);
					GetVehicleZAngle(id,a);

					a += 90;
					z += VehicleOffsetZ[id];

					x += (VehicleOffsetX[id] * floatsin(-a, degrees));
					y += (VehicleOffsetX[id] * floatcos(-a, degrees));

					VehicleBomb[id][1] = CreateObject(3790,x,y,z,0,0,a+180,300.0);
					VehicleSmok[id][1] = CreateObject(18731,x,y,z-1.3,0,0,0,300.0);

					a += 270;

					x += (30 * floatsin(-a, degrees));
					y += (30 * floatcos(-a, degrees));

					MoveObject(VehicleBomb[id][1],x,y,z,MISSILE_SPEED);
					MoveObject(VehicleSmok[id][1],x,y,z-1.3,MISSILE_SPEED);

					SetTimerEx("VM_Explode",MISSILE_DETONATE_TIME,0,"dd",id,1);
					VM_OnVehicleFire(id,1);
					return 1;
				}
			}
			return 1;
		}
	}
	return 1;
}

public VM_Explode(vehicleid,mode)
{
	if(IsValidObject(VehicleBomb[vehicleid][mode]))
	{
		new
		Float:x,
		Float:y,
		Float:z;

		GetObjectPos(VehicleBomb[vehicleid][mode],x,y,z);
		CreateExplosion(x,y,z,MISSILE_EXPLODE_TYPE,MISSILE_EXPLODE_RADIUS);

		DestroyObject(VehicleBomb[vehicleid][mode]);
		DestroyObject(VehicleSmok[vehicleid][mode]);

		VehicleFire[vehicleid] = 0;
		return 1;
	}
	return 1;
}