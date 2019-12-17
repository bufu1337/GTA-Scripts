#include <a_samp>

//----------------------------------------------------------------------------//

public OnFilterScriptInit() {
        print("\n-- Laser Pointer by Skiaffo --\n");
        new p = GetMaxPlayers();
        for (new i=0; i < p; i++) {
                SetPVarInt(i, "laser", 0);
                SetPVarInt(i, "color", 18643);
        }
        return 1;
}

public OnFilterScriptExit() {
        new p = GetMaxPlayers();
        for (new i=0; i < p; i++) {
                SetPVarInt(i, "laser", 0);
                RemovePlayerAttachedObject(i, 0);
        }
        return 1;
}

//----------------------------------------------------------------------------//

public OnPlayerSpawn(playerid) {
    if (!GetPVarInt(playerid, "color")) SetPVarInt(playerid, "color", 18643);
}

public OnPlayerDisconnect(playerid) {
        SetPVarInt(playerid, "laser", 0);
        RemovePlayerAttachedObject(playerid, 0);
        return 1;
}

//----------------------------------------------------------------------------//

public OnPlayerCommandText(playerid, cmdtext[]) {

        new cmd[256];
        new idx;
        cmd = strtok(cmdtext, idx);

        if (!strcmp("/laseron", cmdtext, true)) {
                SetPVarInt(playerid, "laser", 1);
                SetPVarInt(playerid, "color", GetPVarInt(playerid, "color"));
                return 1;
        }

        if (!strcmp("/laseroff", cmdtext, true)) {
                SetPVarInt(playerid, "laser", 0);
                RemovePlayerAttachedObject(playerid, 0);
                return 1;
        }

        if (!strcmp("/lasercol", cmd, true)) {
                new tmp[256];
                tmp = strtok(cmdtext, idx);
                if (!strlen(tmp)) {
                        SendClientMessage(playerid, 0x00E800FF, "Usage: /lasercol [color]");
                        return 1;
                }
                if (!strcmp(tmp, "red", true)) SetPVarInt(playerid, "color", 18643);
                else if (!strcmp(tmp, "blue", true)) SetPVarInt(playerid, "color", 19080);
                else if (!strcmp(tmp, "pink", true)) SetPVarInt(playerid, "color", 19081);
                else if (!strcmp(tmp, "orange", true)) SetPVarInt(playerid, "color", 19082);
                else if (!strcmp(tmp, "green", true)) SetPVarInt(playerid, "color", 19083);
                else if (!strcmp(tmp, "yellow", true)) SetPVarInt(playerid, "color", 19084);
                else SendClientMessage(playerid, 0x00E800FF, "Colour not available!");
                return 1;
        }

        return 0;
}

public OnPlayerUpdate(playerid) {
        if (GetPVarInt(playerid, "laser")) {
                RemovePlayerAttachedObject(playerid, 0);
                if ((IsPlayerInAnyVehicle(playerid)) || (IsPlayerInWater(playerid))) return 1;
                switch (GetPlayerWeapon(playerid)) {
                        case 23: {
                                if (IsPlayerAiming(playerid)) {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SP standing aiming
                                                0.108249, 0.030232, 0.118051, 1.468254, 350.512573, 364.284240);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SP crouched aiming
                                                0.108249, 0.030232, 0.118051, 1.468254, 349.862579, 364.784240);
                                        }
                                } else {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SP standing not aiming
                                                0.078248, 0.027239, 0.113051, -11.131746, 350.602722, 362.384216);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SP crouched not aiming
                                                0.078248, 0.027239, 0.113051, -11.131746, 350.602722, 362.384216);
                        }       }       }
                        case 27: {
                                if (IsPlayerAiming(playerid)) {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
	                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SPAS standing aiming
	                                                0.588246, -0.022766, 0.138052, -11.531745, 347.712585, 352.784271);
	                                        } else {
	                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SPAS crouched aiming
	                                                0.588246, -0.022766, 0.138052, 1.468254, 350.712585, 352.784271);
	                                        }
	                                } else {
	                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
	                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SPAS standing not aiming
	                                                0.563249, -0.01976, 0.134051, -11.131746, 351.602722, 351.384216);
	                                        } else {
	                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SPAS crouched not aiming
	                                                0.563249, -0.01976, 0.134051, -11.131746, 351.602722, 351.384216);
	                        }       }       }
	                        case 30: {
	                                if (IsPlayerAiming(playerid)) {
	                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
	                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // AK standing aiming
	                                                0.628249, -0.027766, 0.078052, -6.621746, 352.552642, 355.084289);
	                                        } else {
	                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // AK crouched aiming
	                                                0.628249, -0.027766, 0.078052, -1.621746, 356.202667, 355.084289);
	                                        }
	                                } else {
	                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
	                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // AK standing not aiming
	                                                0.663249, -0.02976, 0.080051, -11.131746, 358.302734, 353.384216);
	                                        } else {
	                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // AK crouched not aiming
	                                                0.663249, -0.02976, 0.080051, -11.131746, 358.302734, 353.384216);
	                        }       }       }
	                        case 31: {
	                                if (IsPlayerAiming(playerid)) {
	                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
	                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 standing aiming
	                                                0.528249, -0.020266, 0.068052, -6.621746, 352.552642, 355.084289);
	                                        } else {
	                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 crouched aiming
	                                                0.528249, -0.020266, 0.068052, -1.621746, 356.202667, 355.084289);
	                                        }
	                                } else {
	                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
	                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 standing not aiming
	                                                0.503249, -0.02376, 0.065051, -11.131746, 357.302734, 354.484222);
	                                        } else {
	                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 crouched not aiming
	                                                0.503249, -0.02376, 0.065051, -11.131746, 357.302734, 354.484222);
	                        }       }       }
						case 34: {
							if (IsPlayerAiming(playerid)) {
								/*if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
									SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // Sniper standing aiming
									0.528249, -0.020266, 0.068052, -6.621746, 352.552642, 355.084289);
								} else {
									SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // Sniper crouched aiming
									0.528249, -0.020266, 0.068052, -1.621746, 356.202667, 355.084289);
								}*/
								return 1;
							}
							else {
								if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
									SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // Sniper standing not aiming
									0.658248, -0.03276, 0.133051, -11.631746, 355.302673, 353.584259);
								}
								else {
								SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // Sniper crouched not aiming
								0.658248, -0.03276, 0.133051, -11.631746, 355.302673, 353.584259);
								}
							}
						}
                        case 29: {
                                if (IsPlayerAiming(playerid)) {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 standing aiming
                                                0.298249, -0.02776, 0.158052, -11.631746, 359.302673, 357.584259);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 crouched aiming
                                                0.298249, -0.02776, 0.158052, 8.368253, 358.302673, 352.584259);
                                        }
                                } else {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 standing not aiming
                                                0.293249, -0.027759, 0.195051, -12.131746, 354.302734, 352.484222);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 crouched not aiming
                                                0.293249, -0.027759, 0.195051, -12.131746, 354.302734, 352.484222);
        }       }       }       }       }
        return 1;
}

stock IsPlayerInWater(playerid) {
        new anim = GetPlayerAnimationIndex(playerid);
        if (((anim >=  1538) && (anim <= 1542)) || (anim == 1544) || (anim == 1250) || (anim == 1062)) return 1;
        return 0;
}

stock IsPlayerAiming(playerid) {
	new anim = GetPlayerAnimationIndex(playerid);
	if (((anim >= 1160) && (anim <= 1163)) || (anim == 1167) || (anim == 1365) ||
	(anim == 1643) || (anim == 1453) || (anim == 220)) return 1;
        return 0;
}

//----------------------------------------------------------------------------//

strtok(const string[], &index)
{
        new length = strlen(string);
        while ((index < length) && (string[index] <= ' '))
        {
                index++;
        }

        new offset = index;
        new result[20];
        while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
        {
                result[index - offset] = string[index];
                index++;
        }
        result[index - offset] = EOS;
        return result;
}

//----------------------------------------------------------------------------//