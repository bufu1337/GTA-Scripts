// BeckzyBoi's Vehicle Utilities [FS] v1.0 by BeckzyBoi (c) 2007.

#include <a_samp>

#define tram 449
#define shamal 519

new InShamal[MAX_PLAYERS];
new Float:ShamalPos[MAX_VEHICLES][3];
new sExplode[MAX_VEHICLES], tCount[MAX_VEHICLES];

new Float:difc[13][4] = {
{1.13, 0.05, 1.10, 0.0},
{1.13, 2.35, 1.10, 180.0},
{1.13, 4.65, 1.10, 180.0},
{1.13, 1.05, 1.10, 0.0},
{1.13, 3.45, 1.10, 180.0},
{1.13, 5.85, 1.10, 180.0},
{1.13, 0.39, 0.56, 0.0},
{1.13, 2.69, 0.56, 180.0},
{1.13, 4.99, 0.56, 180.0},
{1.13, 0.71, 0.56, 0.0},
{1.13, 3.79, 0.56, 180.0},
{1.13, 6.19, 0.56, 180.0},
{0.00, 0.30, 1.10, 0.0}
};

public OnFilterScriptInit()
{
	print("\n");
	print("-------------------------------------------");
	print("Loaded 'BeckzyBoi's Vehicle Utilities [FS]'");
	print("------ v1.0(r) by BeckzyBoi (c) 2007 ------");
	print("-------------------------------------------");
	print("\n");
	return 1;
}

forward ExplodeShamal(vehicleid);

stock CreateShamalInt(vehicleid, Float:X, Float:Y, Float:Z)
{
	CreateObject(14404, X, Y, Z, 0.0, 0.0, 0.0);
	CreateObject(1562, floatadd(X, difc[0][0]), floatadd(Y, difc[0][1]), floatsub(Z, difc[0][2]), 0.0, 0.0, difc[0][3]);
	CreateObject(1562, floatadd(X, difc[1][0]), floatsub(Y, difc[1][1]), floatsub(Z, difc[1][2]), 0.0, 0.0, difc[1][3]);
	CreateObject(1562, floatadd(X, difc[2][0]), floatsub(Y, difc[2][1]), floatsub(Z, difc[2][2]), 0.0, 0.0, difc[2][3]);
	CreateObject(1562, floatsub(X, difc[3][0]), floatsub(Y, difc[3][1]), floatsub(Z, difc[3][2]), 0.0, 0.0, difc[3][3]);
	CreateObject(1562, floatsub(X, difc[4][0]), floatsub(Y, difc[4][1]), floatsub(Z, difc[4][2]), 0.0, 0.0, difc[4][3]);
	CreateObject(1562, floatsub(X, difc[5][0]), floatsub(Y, difc[5][1]), floatsub(Z, difc[5][2]), 0.0, 0.0, difc[5][3]);
	CreateObject(1563, floatadd(X, difc[6][0]), floatadd(Y, difc[6][1]), floatsub(Z, difc[6][2]), 0.0, 0.0, difc[6][3]);
	CreateObject(1563, floatadd(X, difc[7][0]), floatsub(Y, difc[7][1]), floatsub(Z, difc[7][2]), 0.0, 0.0, difc[7][3]);
	CreateObject(1563, floatadd(X, difc[8][0]), floatsub(Y, difc[8][1]), floatsub(Z, difc[8][2]), 0.0, 0.0, difc[8][3]);
	CreateObject(1563, floatsub(X, difc[9][0]), floatsub(Y, difc[9][1]), floatsub(Z, difc[9][2]), 0.0, 0.0, difc[9][3]);
	CreateObject(1563, floatsub(X, difc[10][0]), floatsub(Y, difc[10][1]), floatsub(Z, difc[10][2]), 0.0, 0.0, difc[10][3]);
	CreateObject(1563, floatsub(X, difc[11][0]), floatsub(Y, difc[11][1]), floatsub(Z, difc[11][2]), 0.0, 0.0, difc[11][3]);
	CreateObject(14405, X, floatsub(Y, difc[12][1]), floatsub(Z, difc[12][2]), 0.0, 0.0, difc[12][3]);
	ShamalPos[vehicleid][0] = X, ShamalPos[vehicleid][1] = Y, ShamalPos[vehicleid][2] = Z;
}

stock SetPlayerPosInShamal(playerid, shamalid)
{
	SetPlayerPos(playerid, ShamalPos[shamalid][0],
	floatsub(ShamalPos[shamalid][1], 5.87),
	floatsub(ShamalPos[shamalid][2], 0.75));
	SetPlayerFacingAngle(playerid, 0.0);
	SetCameraBehindPlayer(playerid);
}

stock ShamalExists(vehicleid)
{
	if (floatsqroot(floatadd(ShamalPos[vehicleid][0], floatadd(ShamalPos[vehicleid][1], ShamalPos[vehicleid][2]))))
		return 1;
	return 0;
}

stock randomEx(randval)
{
	new rand1 = random(2), rand2;
	if (!rand1) rand2 -= random(randval);
	else rand2 += random(randval);
	return rand2;
}

public OnPlayerConnect(playerid)
{
	InShamal[playerid] = 0;
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if (GetVehicleModel(vehicleid) == shamal && ispassenger)
	{
		if (!ShamalExists(vehicleid))
			CreateShamalInt(vehicleid, float(randomEx(3000)), float(randomEx(3000)), float(random(100)+800));
		SetPlayerPosInShamal(playerid, vehicleid);
		InShamal[playerid] = vehicleid;
	}
	return 1;
}

stock IsPlayerDriverInVehicle(playerid, vehicleid, modelid)
{
	if (IsPlayerInVehicle(playerid, vehicleid) && GetPlayerState(playerid) == 2
	&& GetVehicleModel(GetPlayerVehicleID(playerid)) == modelid)
		return 1;
	return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new Float:pos[7], tvar[2];
	if (newkeys == 16)
	{
		if (InShamal[playerid])
		{
			GetVehiclePos(InShamal[playerid], pos[0], pos[1], pos[2]);
			GetVehicleZAngle(InShamal[playerid], pos[3]);
			pos[0] += floatmul(floatsin(-floatsub(pos[3], 45.0), degrees), 5.0);
			pos[1] += floatmul(floatcos(-floatsub(pos[3], 45.0), degrees), 5.0);
			SetPlayerInterior(playerid, 0);
			SetPlayerPos(playerid, pos[0], pos[1], floatsub(pos[2], 0.94));
			SetPlayerFacingAngle(playerid, pos[3]);
			SetCameraBehindPlayer(playerid);
			InShamal[playerid] = 0;
			return 1;
		}
		if (GetPlayerState(playerid) == 1)
		{
			GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
			for (new vs = 1; vs <= MAX_VEHICLES; vs++)
			{
				if (GetVehicleModel(vs) == tram)
				{
					GetVehiclePos(vs, pos[3], pos[4], pos[5]);
					GetVehicleZAngle(vs, pos[6]);
					pos[3] += floatmul(floatsin(-pos[6], degrees), 3.0);
					pos[4] += floatmul(floatcos(-pos[6], degrees), 3.0);
					if (floatcmp(floatsqroot(floatadd(floatadd(floatpower(floatsub(pos[0], pos[3]), 2.0), floatpower
					(floatsub(pos[1], pos[4]), 2.0)), floatpower(floatsub(pos[2], pos[5]), 2.0))), 3.0) != 1)
					{
						for (new a; a < MAX_PLAYERS; a++)
							if (IsPlayerConnected(a) && IsPlayerDriverInVehicle(a, vs, tram))
								tvar[0] ++;
						if (!tvar[0]) PutPlayerInVehicle(playerid, vs, 0);
					}
				}
			}
		}
		return 1;
	}
	if (newkeys == 128 && IsPlayerDriverInVehicle(playerid, GetPlayerVehicleID(playerid), 525))
	{
		GetVehiclePos(GetPlayerVehicleID(playerid), pos[0], pos[1], pos[2]);
		while (tvar[0] < MAX_VEHICLES && !tvar[1])
		{
			tvar[0] ++;
			GetVehiclePos(tvar[0], pos[3], pos[4], pos[5]);
   			if (floatcmp(floatabs(floatsub(pos[0], pos[3])), 7.0) != 1 && floatcmp(floatabs(floatsub(pos[1], pos[4])), 7.0) != 1
  			&& floatcmp(floatabs(floatsub(pos[2], pos[5])), 7.0) != 1 && tvar[0] != GetPlayerVehicleID(playerid))
			{
			    tvar[1] ++;
				if (IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
   			    AttachTrailerToVehicle(tvar[0], GetPlayerVehicleID(playerid));
			}
		}
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	InShamal[playerid] = 0;
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	if (GetVehicleModel(vehicleid) == shamal && ShamalExists(vehicleid))
	{
		CreateExplosion(ShamalPos[vehicleid][0], ShamalPos[vehicleid][1], ShamalPos[vehicleid][2], 2, 15.0);
		sExplode[vehicleid] = SetTimerEx("ExplodeShamal", 700, 1, "d", vehicleid);
		tCount[vehicleid] = true;
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	tCount[vehicleid] = false;
	return 1;
}

public ExplodeShamal(vehicleid)
{
	KillTimer(sExplode[vehicleid]);
	if (tCount[vehicleid])
	{
		CreateExplosion(ShamalPos[vehicleid][0], ShamalPos[vehicleid][1], ShamalPos[vehicleid][2], 2, 15.0);
		sExplode[vehicleid] = SetTimerEx("ExplodeShamal", random(1300)+100, 1, "d", vehicleid);
	}
}
