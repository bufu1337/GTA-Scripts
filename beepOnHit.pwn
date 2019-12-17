#include <a_samp>

new Float:Aero_LastHealth[200];

public OnPlayerUpdate(playerid){
        new Float:Health;
        GetPlayerHealth(playerid, Health);
        if(Health < Aero_LastHealth[playerid]){
                CallRemoteFunction("OnPlayerLoseHealth", "df", playerid, Aero_LastHealth[playerid] - Health);
        }/* else if(Health > Aero_LastHealth[playerid]){
            CallRemoteFunction("OnPlayerGainHealth", "df", playerid, Health - Aero_LastHealth[playerid]);
        }
        if(Health != Aero_LastHealth[playerid]){
            CallRemoteFunction("OnPlayerHealthChange", "ddd", playerid, Aero_LastHealth[playerid], Health);
        }*/
        Aero_LastHealth[playerid] = Health;

        return 1;
}

IsPlayerAiming(playerid, aimid){
        new Float:X1, Float:Y1, Float:Z1, Float:X2, Float:Y2, Float:Z2;
        GetPlayerPos(playerid, X1, Y1, Z1);
        GetPlayerPos(aimid, X2, Y2, Z2);
//      new keys, own, pwn;
//      GetPlayerKeys(playerid, keys, own, pwn);
//      if(!(keys & KEY_SECONDARY_ATTACK))return false;
        new Float:Distance = floatsqroot(floatpower(floatabs(X1-X2), 2) + floatpower(floatabs(Y1-Y2), 2));
        if(Distance < 100){
                new Float:A;
                GetPlayerFacingAngle(playerid, A);
                X1 += (Distance * floatsin(-A, degrees));
                Y1 += (Distance * floatcos(-A, degrees));
            Distance = floatsqroot(floatpower(floatabs(X1-X2), 2) + floatpower(floatabs(Y1-Y2), 2));
                if(Distance < 1.0){
                    return true;
                }
        }
        return false;
}

forward OnPlayerLoseHealth(playerid, Float:lose);
public OnPlayerLoseHealth(playerid, Float:lose){
        for(new g=0;g<GetMaxPlayers();g++)if(IsPlayerConnected(g) && g!=playerid){
            if(IsPlayerAiming(g, playerid))return PlayerPlaySound(g, 1057, 0.0, 0.0, 0.0);
        }
        return true;
}