#include <a_samp>

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(hittype == BULLET_HIT_TYPE_VEHICLE)
	{
	    static Float:X, Float:Y, Float:Z;
	    /* Show in the petrol tank - It also works when the player is inside. */
		GetVehicleModelInfo(GetVehicleModel(hitid), VEHICLE_MODEL_INFO_PETROLCAP, X, Y, Z);

		if(VectorSize(fX-X, fY-Y, fZ-Z) < 0.15)
		{
		    SetVehicleHealth(hitid, -1000.0);
		    return 1;
		}

		/* Shot in empty vehicle */
		for(new i = GetPlayerPoolSize(); i > -1; i--)
		{
			if(GetPlayerVehicleID(i) == hitid && GetPlayerVehicleSeat(i) == 0)
				return 1;
		}

		GetVehicleHealth(hitid, X);
		if(X > 0)
		{
			switch(weaponid)
			{
				case 0 .. 15: SetVehicleHealth(hitid, X - 10);
				case 22 .. 23: SetVehicleHealth(hitid, X - 15);
                case 24: SetVehicleHealth(hitid, X - 50);
				case 25 .. 27: SetVehicleHealth(hitid, X - 30);
				case 28, 29, 32: SetVehicleHealth(hitid, X - 5);
				case 30, 31: SetVehicleHealth(hitid, X - 10);
				case 33, 34: SetVehicleHealth(hitid, X - 40);
				case 35 .. 38: SetVehicleHealth(hitid, X - 80);
				default: return 1;
			}
		}
	}
    return 1;
}

/* Vehicle vs Vehicle */
public OnFilterScriptInit()
{
	SetTimer("Timer", 500, true); //faster == less mistakes
	return 1;
}

new Float:PlayerVehHP[MAX_PLAYERS];

forward Timer();
public Timer()
{
    for(new i = GetPlayerPoolSize(); i > -1; i--)
	{
	    if(GetPlayerState(i) != PLAYER_STATE_DRIVER) continue;

		GetVehicleHealth(GetPlayerVehicleID(i), PlayerVehHP[i]);
	}
	return 1;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		static Float:hp, Float:hpa;
		GetVehicleHealth(GetPlayerVehicleID(playerid), hp);
		if(hp < PlayerVehHP[playerid])
		{
		    if(GetVehicleDistanceFromPoint(vehicleid, new_x, new_y, new_z) < 15.0)
		    {
				GetVehicleHealth(vehicleid, hpa);
				SetVehicleHealth(vehicleid, hpa - (PlayerVehHP[playerid] - hp));
		    }
		}
		PlayerVehHP[playerid] = hp;
	    return 1;
	}
    return 1;
}