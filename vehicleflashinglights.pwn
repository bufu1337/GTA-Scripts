/*
© Stefantjuh97
Mail: S.dorst1997@gmail.com
SAMP Forum name: Stefand.
Release Date: 18-6-2012
Version: 3.0


Changelog V2.0
Fixed:
- Headlights keep flashing when you are out of the vehicle.
  Thanks to BrandyPenguin

- if you did /flash 2 times without /flashoff you had a bugged vehicle.

Added:
- Working for ambulance
- Working for Firetruck

Changelog V3.0
Fixed:
- /flash for turning flash on and /flash for turning it off
  Thanks to BrandyPenguin

Added:
- Nothing
*/

#include <a_samp>
#include <zcmd>

#define FILTERSCRIPT

forward FlasherFunc();

new obj[MAX_VEHICLES] = { INVALID_OBJECT_ID, ... };
new obj2[MAX_VEHICLES] = { INVALID_OBJECT_ID, ... };
new LightPwr[MAX_VEHICLES];
new Flasher[MAX_VEHICLES] = 0;
new FlasherState[MAX_VEHICLES];
new FlashTimer;

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Police Flash lights V2.1");
	print(" By Stefantjuh97");
	print("--------------------------------------\n");

	for (new x=0; x<MAX_VEHICLES; x++)
	{
		LightPwr[x]=1;
		Flasher[x]=0;
		FlasherState[x]=0;
	}

	FlashTimer = SetTimer("FlasherFunc",200,1); // "200" is the speed from the flashing headlights
	return 1;
}

public OnFilterScriptExit()
{
	KillTimer(FlashTimer);
	for (new i = 0; i < MAX_VEHICLES; i++)
	{
		DestroyObject(obj[i]);
		DestroyObject(obj2[i]);
	}
	return 1;
}




public OnVehicleSpawn(vehicleid)
{
	DestroyObject(obj[vehicleid]);
	DestroyObject(obj2[vehicleid]);
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	DestroyObject(obj[vehicleid]);
	DestroyObject(obj2[vehicleid]);
	return 1;
}

command(flash, playerid, params[])
{
	new vehicleid,panels,doors,lights,tires;
	vehicleid = GetPlayerVehicleID(playerid);
	if(!Flasher[vehicleid]) {
		if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		{
			return SendClientMessage(playerid, -1, "* You are not the driver!");
		}
		if (!GetVehicleModel(vehicleid)) return SendClientMessage(playerid, -1, "* You are not in a vehicle!");
		if (IsValidObject(obj[vehicleid]) || IsValidObject(obj2[vehicleid]))
		{
			SendClientMessage(playerid, -1, "You switched off the lights."), DestroyObject(obj[vehicleid]), DestroyObject(obj2[vehicleid]);
			GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
			if(LightPwr[vehicleid] == 1)
			UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
			else
			UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);
			Flasher[vehicleid] = 0;
		}
		switch (GetVehicleModel(vehicleid))
		{
			case 596:
			{
				obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				obj2[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.599999,-0.375000,0.899999,0.000000,0.000000,0.000000);
				AttachObjectToVehicle(obj2[vehicleid], vehicleid, -0.599999,-0.375000,0.899999,0.000000,0.000000,0.000000);
				GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
				Flasher[vehicleid] = 1;
			}
			case 597:
			{
				obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				obj2[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.599999,-0.375000,0.899999,0.000000,0.000000,0.000000);
				AttachObjectToVehicle(obj2[vehicleid], vehicleid, -0.599999,-0.375000,0.899999,0.000000,0.000000,0.000000);

				GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
				Flasher[vehicleid] = 1;
			}
			case 598:
			{
				obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				obj2[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.524999, -0.300000, 0.899999, 0.000000, 0.000000, 0.000000);
				AttachObjectToVehicle(obj2[vehicleid], vehicleid, -0.524999, -0.300000, 0.899999, 0.000000, 0.000000, 0.000000);
				GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
				Flasher[vehicleid] = 1;
			}
			case 599:
			{
				obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				obj2[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.524999,0.000000,1.125000,0.000000,0.000000,0.000000);
				AttachObjectToVehicle(obj2[vehicleid], vehicleid, -0.524999,0.000000,1.125000,0.000000,0.000000,0.000000);
				GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
				Flasher[vehicleid] = 1;
			}
			case 541://bullet
			{
				obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.375000,0.524999,0.375000,0.000000,0.000000,0.000000);

				GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
				Flasher[vehicleid] = 1;
			}
			case 426://premier
			{
				obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.524999,0.749999,0.375000,0.000000,0.000000,0.000000);

				GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
				Flasher[vehicleid] = 1;
			}
			case 427://enforcer
			{
				GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
				Flasher[vehicleid] = 1;
			}
			case 416://Ambulance
			{
				GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
				Flasher[vehicleid] = 1;
			}
			case 407://FireTruck
			{
				GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
				Flasher[vehicleid] = 1;
			}
			case 560://sultan
			{
				obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.225000,0.750000,0.449999,0.000000,0.000000,0.000000);
				GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
				Flasher[vehicleid] = 1;
			}
			case 490://FBI
			{
				obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.000000,1.125000,0.599999,0.000000,0.000000,0.000000);
				GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
				Flasher[vehicleid] = 1;
			}
			default:
			{
				return SendClientMessage(playerid, -1, "You are not in a CODE 2 compatible police vehicle!");
			}
  		}
		return SendClientMessage(playerid, -1, "Lights on, you are now in a CODE 2 run!");
	} else {
		if (IsValidObject(obj[vehicleid]) || IsValidObject(obj2[vehicleid])) {
			SendClientMessage(playerid, -1, "You switched off the lights."), DestroyObject(obj[vehicleid]), DestroyObject(obj2[vehicleid]);
		}
		GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
		if(LightPwr[vehicleid] == 1)
			UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
		else
			UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);
		Flasher[vehicleid] = 0;
	}
	return 1;
}

public FlasherFunc() {
	new panelsx,doorsx,lightsx,tiresx;
	for (new p=0; p<MAX_VEHICLES; p++)
	{
		if (Flasher[p] == 1)
		{
			if (FlasherState[p] == 1)
			{
				GetVehicleDamageStatus(p,panelsx,doorsx,lightsx,tiresx);
				UpdateVehicleDamageStatus(p, panelsx, doorsx, 4, tiresx);
				FlasherState[p] = 0;
			}
			else
			{
				GetVehicleDamageStatus(p,panelsx,doorsx,lightsx,tiresx);
				UpdateVehicleDamageStatus(p, panelsx, doorsx, 1, tiresx);
				FlasherState[p] = 1;
			}
		}
	}
	return 1;
}