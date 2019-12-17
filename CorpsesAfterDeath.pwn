// Filterscript Corpses System
// by Edinson_Walker / EdinsonWalker.

#include < a_samp >
#include < zcmd >

// New's
new Actors[MAX_PLAYERS], // Actor's
Float: Deadx[MAX_PLAYERS], // coor X
Float: Deady[MAX_PLAYERS], // coor Y
Float: Deadz[MAX_PLAYERS], // coor Z
Float: Deadr[MAX_PLAYERS], // coor R
Deadint[MAX_PLAYERS], // Int
Deadvw[MAX_PLAYERS], // VW
Deadskin[MAX_PLAYERS];

public OnFilterScriptInit() {
    print("\n|=====================================|");
    print("             Corpses System             ");
    print("|=====================================|\n");
    return 1;
}

public OnFilterScriptExit() {
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason) {
    Actors[playerid] = playerid;
    GetPlayerPos(playerid, Deadx[playerid], Deady[playerid], Deadz[playerid]);
    GetPlayerFacingAngle(playerid, Deadr[playerid]);
    Deadint[playerid] = GetPlayerInterior(playerid);
    Deadvw[playerid] = GetPlayerVirtualWorld(playerid);
    Deadskin[playerid] = GetPlayerSkin(playerid);
    Actors[playerid] = CreateActor(Deadskin[playerid], Deadx[playerid], Deady[playerid], Deadz[playerid], Deadr[playerid]);
    ApplyActorAnimation(Actors[playerid], "PED", "FLOOR_hit_f", 4.1, 0, 1, 1, 1, 1); //
    SetTimerEx("ActorDelete", 15000, false, "i", playerid); // 15000 = 15 (example time)
    return 1;
}

forward ActorDelete(playerid);
public ActorDelete(playerid) {
    DestroyActor(Actors[playerid]);
    Actors[playerid] = -1;
    return 1;
}

public OnPlayerConnect(playerid) {
    SetPlayerColor(playerid, 0xFFFFFF00);
    Actors[playerid] = -1;
}

// Optional.
/*CMD:deletecorpse(playerid, params[]) {
    new id;
    if (!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1, "* Not authorized.");
    if (sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "CMD: /deletecorpse [player id]");
    if (Actors[id] == -1) return SendClientMessage(playerid, -1, "* Player is not corpse.");
    DestroyActor(Actors[id]);
    Actors[id] = -1;
    return 1;
}*/