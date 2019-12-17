/*  =============================

    Limex's Swimming Include

    Made by Limex / A

    New function:
    IsPlayerSwimming(playerid)

    New callbacks:
    OnPlayerStartSwimming(playerid)
    OnPlayerStopSwimming(playerid)

    Enjoy!

    ============================= */
#include <a_samp>
new bool:swimming[MAX_PLAYERS];
forward OnPlayerStartSwimming(playerid);
forward OnPlayerStopSwimming(playerid);
forward IsPlayerSwimming(playerid);
public IsPlayerSwimming(playerid)
{
    if(swimming[playerid]) return 1;
    return 0;
}
public OnPlayerUpdate(playerid)
{
    if(GetPlayerAnimationIndex(playerid))
    {
        new animlib[32];
        new animname[32];
        GetAnimationName(GetPlayerAnimationIndex(playerid),animlib,32,animname,32);
        if(strcmp(animlib, "SWIM", true) == 0 && !swimming[playerid])
        {
            swimming[playerid] = true;
            OnPlayerStartSwimming(playerid);
        }
        else if(strcmp(animlib, "SWIM", true) != 0 && swimming[playerid] && strfind(animname, "jump", true) == -1)
        {
            swimming[playerid] = false;
            OnPlayerStopSwimming(playerid);
        }
    }
    else if(swimming[playerid])
    {
        swimming[playerid] = false;
        OnPlayerStopSwimming(playerid);
    }
    return 1;
}
public OnPlayerStartSwimming(playerid)
{
    // EXAMPLE CODE START //
    SendClientMessage(playerid, 0x33CCFFAA, "You started swimming!");
    // EXAMPLE CODE END //
    return 1;
}
public OnPlayerStopSwimming(playerid)
{
    // EXAMPLE CODE START //
    SendClientMessage(playerid, 0x33CCFFAA, "You stopped swimming!");
    // EXAMPLE CODE END //
    return 1;
}