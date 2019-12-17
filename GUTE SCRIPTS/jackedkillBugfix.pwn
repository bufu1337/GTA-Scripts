#include <a_samp>

#define HOLDING(%0) \
    ((newkeys & (%0)) == (%0))
#define RELEASED(%0) \
    (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define PRESSED(%0) \
    (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

new IsPlayerSteppingInVehicle[MAX_PLAYERS] = -1;

public OnPlayerStateChange(playerid,newstate,oldstate)
{
    IsPlayerSteppingInVehicle[playerid] = -1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    IsPlayerSteppingInVehicle[playerid] = vehicleid;
}


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (HOLDING(KEY_SPRINT) || PRESSED(KEY_SPRINT) || RELEASED(KEY_SPRINT))
    {
        if (IsPlayerSteppingInVehicle[playerid] > -1)
        {
            for(new i = 0; i < MAX_PLAYERS; i++)
            {
                if (GetPlayerVehicleID(i) == IsPlayerSteppingInVehicle[playerid] && i != playerid)
                {
                    new Float:x,Float:y,Float:z,pName[28],string[128];
                    GetPlayerPos(playerid,x,y,z);
                    SetPlayerPos(playerid,x,y,z);
                    GameTextForPlayer(playerid,"~r~Please do NOT abuse the \r\n~w~Jack bug",5000,4);
                    IsPlayerSteppingInVehicle[playerid] = -1;
                    GetPlayerName(playerid,pName,28);
                    format(string,sizeof string,"%s(%i) has tried to abuse the jack bug!",pName,playerid);
                    print(string);
                }
            }
        }
    }
    return 1;
}