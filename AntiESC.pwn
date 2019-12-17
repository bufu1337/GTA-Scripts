#include <a_samp>

new timeesc[MAX_PLAYERS];

forward veresc(playerid);
forward verfesc(Float:vida,playerid);

public OnPlayerConnect(playerid)
{
    timeesc[playerid]=SetTimer("veresc",30000,true,"i",playerid);
    return 1;
}
public OnPlayerDisconnect(playerid)
{
    KillTimer(timeesc[playerid]);
    return 1;
}
public veresc(playerid)
{
    new Float:vida;
    GetPlayerHealth(playerid,vida);
    SetTimerEx("verfesc",1000,false,"fi",vida,playerid);
    SetPlayerHealth(playerid,vida - 1.0);
    return 1;
}
public verfesc(Float:vida,playerid)
{
    new Float:vidap;
    GetPlayerHealth(playerid,vidap);
    if(floatcmp(vida,vidap)==0)
    {
        SetPlayerHealth(playerid,vida);

        Kick(playerid);
        return 1;
    }
    SetPlayerHealth(playerid,vida);
    return 0;
}