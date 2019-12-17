#define FILTERSCRIPT
#include <a_samp>
#if !defined OnUnoccupiedVehicleUpdate
    #error "Include is not up to date, OnUnoccupiedVehicleUpdate callback not found. Please update to 0.3c R5 or higher."
#endif

enum E_VEH_ENUM { E_VEH_DRIVER, E_VEH_PLACED, Float:E_VEH_X, Float:E_VEH_Y, Float:E_VEH_Z, Float:E_VEH_ROT };
new vehicles[MAX_VEHICLES][E_VEH_ENUM];
new pvehicle[MAX_PLAYERS];

forward VEH_UnPlace(vehicleid); public VEH_UnPlace(vehicleid) vehicles[vehicleid][E_VEH_PLACED] = 0;

public OnFilterScriptInit()
{
    // version check
    new pv[10], pt[2], t = 0;
    GetServerVarAsString("version", pv, 10);
    strmid(pt, pv, 2, 3);
    if (strval(pt) < 3)
    {
        printf("[!] Your server version (%s) is likely not compatible with Anti ESC Vehicle Bug FS. Please update to 0.3c R5 or higher!", pv);
    }
    else
    {
        if (strval(pt) == 3) t = 1;
        strmid(pt, pv, 3, 4);
        if (pt[0] < 'c' && t == 1)
        {
            printf("[!] Your server version (%s) is likely not compatible with Anti ESC Vehicle Bug FS. Please update to 0.3c R5 or higher!", pv);
        }
        else
        {
            strmid(pt, pv, 6, 7);
            if (strval(pt) < 5 && t == 1)
            {
                printf("[!] Your server version (%s) is likely not compatible with Anti ESC Vehicle Bug FS. Please update to 0.3c R5 or higher!", pv);
            }
        }
    }
    for (new i = 0; i < MAX_VEHICLES; i++)
    {
        vehicles[i][E_VEH_DRIVER] = INVALID_VEHICLE_ID;
    }

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (GetPlayerVehicleSeat(i) == 0)
        {
            vehicles[GetPlayerVehicleID(i)][E_VEH_DRIVER] = i;
            pvehicle[i] = GetPlayerVehicleID(i);
        }
    }

    print("\n Anti ESC Vehicle Bug FS initialized.");
    return 1;
}

public OnFilterScriptExit()
{
    print("\n Anti ESC Vehicle Bug FS deloaded.");
    return 1;
}

public OnVehicleSpawn(vehicleid)
{
    vehicles[vehicleid][E_VEH_DRIVER] = INVALID_PLAYER_ID;
    return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    vehicles[vehicleid][E_VEH_PLACED] = 1;
    vehicles[vehicleid][E_VEH_DRIVER] = INVALID_PLAYER_ID;
    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if (newstate == PLAYER_STATE_DRIVER)
    {
        new vehid = GetPlayerVehicleID(playerid);
        vehicles[vehid][E_VEH_DRIVER] = playerid;
        vehicles[vehid][E_VEH_PLACED] = 0;
        pvehicle[playerid] = vehid;
    }
    else
    {
        if (oldstate == PLAYER_STATE_DRIVER)
        {
            new vehid = pvehicle[playerid];
            pvehicle[playerid] = INVALID_VEHICLE_ID;
            vehicles[vehid][E_VEH_DRIVER] = INVALID_PLAYER_ID;
            GetVehiclePos(vehid, vehicles[vehid][E_VEH_X], vehicles[vehid][E_VEH_Y], vehicles[vehid][E_VEH_Z]);
            GetVehicleZAngle(vehid, vehicles[vehid][E_VEH_ROT]);
        }
    }
    return 1;
}

public OnPlayerConnect(playerid)
{
    pvehicle[playerid] = INVALID_VEHICLE_ID;
    return;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat)
{
    if (passenger_seat < 1) return;
    if (vehicles[vehicleid][E_VEH_DRIVER] != INVALID_PLAYER_ID) return;
    if (vehicles[vehicleid][E_VEH_PLACED]) return;
    SetVehiclePos(vehicleid, vehicles[vehicleid][E_VEH_X], vehicles[vehicleid][E_VEH_Y], vehicles[vehicleid][E_VEH_Z]);
    SetVehicleZAngle(vehicleid, vehicles[vehicleid][E_VEH_ROT]);
    vehicles[vehicleid][E_VEH_PLACED] = 1;
    SetTimerEx("VEH_UnPlace", 10000, 0, "i", vehicleid);
}