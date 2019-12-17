#include <a_samp>
#define FILTERSCRIPT

#define RED 0xAA3333AA

new bool:IsSpeeding[MAX_PLAYERS];
new playerspeedtimer[MAX_PLAYERS];
new CrashTimer[MAX_PLAYERS];

public OnFilterScriptInit()
{
        for(new i=0;i<GetMaxPlayers();i++)
        {
            IsSpeeding[i] = false;
        }
        return 1;
}

public OnPlayerConnect(playerid)
{
        playerspeedtimer[playerid] = SetTimerEx("VehicleSpeed", 100, 1, "i", playerid);
        return 1;
}

public OnPlayerDisconnect(playerid)
{
        KillTimer(playerspeedtimer[playerid]);
    KillTimer(CrashTimer[playerid]);
    IsSpeeding[playerid] = false;
        return 1;
}

forward VehicleSpeed(playerid);
public VehicleSpeed(playerid)
{
        new Float:ovx, Float:ovy, Float:ovz;
        if(IsPlayerInAnyVehicle(playerid))
        {
                GetVehicleVelocity(GetPlayerVehicleID(playerid), ovx, ovy, ovz);
                if(ovx < -0.4 || ovx > 0.4 || ovy < -0.4 || ovy > 0.4 && !IsSpeeding[playerid])
                {
                    CrashTimer[playerid] = SetTimerEx("Speeding", 100, 1, "i", playerid);
                    IsSpeeding[playerid] = true;
                }
                else
                {
                    KillTimer(CrashTimer[playerid]);
                    IsSpeeding[playerid] = false;
                }
        }
        return 1;
}

forward Speeding(playerid);
public Speeding(playerid)
{
        new Float:nvx, Float:nvy, Float:nvz;
        if(IsPlayerInAnyVehicle(playerid) && IsSpeeding[playerid])
        {
                GetVehicleVelocity(GetPlayerVehicleID(playerid), nvx, nvy, nvz);
                if(nvx > -0.1 && nvx < 0.1 && nvy > -0.1 && nvy < 0.1)
                {
                    new Float:crashhealth;
                    GetPlayerHealth(playerid, crashhealth);
                    crashhealth -= 10.0;
                    SetPlayerHealth(playerid, crashhealth);
                SetPlayerDrunkLevel(playerid, 50000);
                SetTimerEx("StopCameraEffect", 5000, 0, "i", playerid);
                    IsSpeeding[playerid] = false;
                }
        }
        return 1;
}

forward StopCameraEffect(playerid);
public StopCameraEffect(playerid)
{
    SetPlayerDrunkLevel(playerid, 0);
        return 1;
}