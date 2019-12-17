#define FILTERSCRIPT
#include <a_samp>
#define COLOR_BAR        0xFF0000FF // First color of 3DText
#define HEALTH_LENGTH    3 // Max langth of damage (100 is 3, 10 is 2, 1 is 1)
#define HEALTH_DRAW      30.0 // Draw distance for the 3DText
#define HEALTH_OFFSET    0.2 // First 3DText offset
#define HEALTH_OFFSETADD 0.01 // Add every update to 3D offser - commant to disable
#define COLOR_DELETE     10 // Color brightnes to delet every update
#define TIME_FIRST       400 // Time from creation to first update
#define TIME_BLOW        66 // Time from update tp update
public OnFilterScriptInit(){
        print("\n *** DAMAGE BAR by RaFaeL successfully Loaded! v0.2.1 *** \n");
        return 1;
}
public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid) {
    if(issuerid == INVALID_PLAYER_ID) return 1; // Skip if Damaged player is invalid
    new Text3D:bar3D, damageStr[HEALTH_LENGTH];
    valstr(damageStr, floatround(amount));
    bar3D = Create3DTextLabel(damageStr, COLOR_BAR, 0.0, 0.0, 0.0, HEALTH_DRAW, 0);
    Attach3DTextLabelToPlayer(bar3D, playerid, 0.0, 0.0, HEALTH_OFFSET);
    SetTimerEx("UpdateDamageBar", TIME_FIRST, 0, "iiffii", playerid, _:bar3D, amount, HEALTH_OFFSET, 16, COLOR_BAR);
    return 1;
}
forward UpdateDamageBar(playerid, Text3D:bar3D, Float:amount, Float:offset, updated, color);
public UpdateDamageBar(playerid, Text3D:bar3D, Float:amount, Float:offset, updated, color) {
    if(!updated--) {
        Delete3DTextLabel(bar3D);
        return 1;
	}
    new damageStr[HEALTH_LENGTH];
    valstr(damageStr, floatround(amount));
    offset += HEALTH_OFFSETADD;
    color -= COLOR_DELETE;
    Update3DTextLabelText(bar3D, color, damageStr);
    #if defined HEALTH_OFFSETADD
        Attach3DTextLabelToPlayer(bar3D, playerid, 0.0, 0.0, offset);
    #endif
    SetTimerEx("UpdateDamageBar", TIME_BLOW, 0, "iiffii", playerid, _:bar3D, amount, offset, updated, color);
    return 1;
}