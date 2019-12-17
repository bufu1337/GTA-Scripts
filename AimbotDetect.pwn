//Made by Kyance, do NOT remove credits.
//The reason why it's in BETA is because i never had the chance to FULLY test it!
#include <a_samp>
#include <zcmd>
#include <foreach>
#include <sscanf2>
#include <callbacks>

#define COLOR_NOTES 0x2894FFFF
#define COLOR_NOTES2 0xFF0000AA
#define COLOR_RED 0xAA3333AA

#define DIALOG_SUSPECTLIST 123

#define BULLET_HIT_TYPE_NONE				0
#define BULLET_HIT_TYPE_PLAYER          	1
#define BULLET_HIT_TYPE_VEHICLE        		2
#define BULLET_HIT_TYPE_OBJECT          	3
#define BULLET_HIT_TYPE_PLAYER_OBJECT   	4

#if defined FILTERSCRIPT


public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Aimbot Detection ( v2b ) loaded. . . ");
	print("--------------------------------------\n");
	HitMarkersCreated = 0;
	foreach(Player, i)
	{
 		DetectedForAimbot{ i } = false;
		HitMarkerEnabled[i] = 0, DestroyObject(HitMarker[i]);
		HasHit[i] = 0;
		CoolDown[i] = 0;
		ToggleCoolDown[i] = 1;
		TimesShot[i] = 0;
	}
	return 1;
}

public OnFilterScriptExit()
{
	print("\n----------------------------------");
	print(" Aimbot Detection ( v2b ) unloaded. . . ");
	print("----------------------------------\n");
	
	for(new i = 0; i < MAX_OBJECTS; i++)
	{
	    if(i == 19282)
	    {
	        foreach(Player, x)
	        {
				DestroyObject(HitMarker[x]);
			}
		}
	}
	return 1;
}

#endif

//------------------------------ VARIABLES ---------------------------------------

new
	bool: DetectedForAimbot[ MAX_PLAYERS char ],
	bool: IsAFK[ MAX_PLAYERS char ],
	TimesDetected[ MAX_PLAYERS ] = 0,
	HitMarker[ MAX_PLAYERS ],
	HitMarkerEnabled[ MAX_PLAYERS ],
	HasHit[ MAX_PLAYERS ],
	CoolDown[ MAX_PLAYERS ],
	ToggleCoolDown[ MAX_PLAYERS ],
	TimesShot[ MAX_PLAYERS ],
	HitMarkersCreated
;

//------------------------------ CALLBACKS ----------------------------------

public OnPlayerPause(playerid)
{
	IsAFK{ playerid } = true;
	return 1;
}
public OnPlayerResume(playerid, time)
{
	IsAFK{ playerid } = false;
	return 1;
}

public OnPlayerConnect(playerid)
{
	DetectedForAimbot{ playerid } = false, IsAFK{ playerid } = false;
	HitMarkerEnabled[playerid] = 0, DestroyObject(HitMarker[playerid]);
	HasHit[playerid] = 0;
	CoolDown[playerid] = 1;
	ToggleCoolDown[playerid] = 0;
	TimesShot[playerid] = 0;
	TimesDetected[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	DetectedForAimbot{ playerid } = false;
	HitMarkerEnabled[playerid] = 0, DestroyObject(HitMarker[playerid]);
	HasHit[playerid] = 0;
	CoolDown[playerid] = 0;
	TimesShot[playerid] = 0;
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
    if(issuerid != INVALID_PLAYER_ID)
    {
        if(!HasHit[issuerid])
        {
            HasHit[issuerid] = 1;
			SetTimerEx("RemoveHit", 1500, false, "i", issuerid);
		}
		if(!CoolDown[issuerid] && ToggleCoolDown[issuerid])
		{
			CoolDown[issuerid] = 1;
			SetTimerEx("ResetCoolDown", 4500, false, "i", issuerid);
		}
	}
	return 1;
}
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	TimesShot[playerid]++;
	if(TimesShot[playerid] < 20)
	{
		new Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		if(HitMarkerEnabled[playerid] && HitMarkersCreated < 150)
		{
			foreach(Player, i)
   			{
		 		if(IsPlayerAdmin(i) && GetPlayerState(i) == PLAYER_STATE_SPECTATING)
				{
					if(IsPlayerInRangeOfPoint(i, 60, X, Y, Z))
					{
						HitMarker[i] = CreatePlayerObject(i, 19282, fX, fY, fZ, 0, 0, 0);
						SetTimerEx("RemoveHitMarker", 2700, false, "ii", i, HitMarker);
						HitMarkersCreated++;
					}
				}
			}
		}
		/*if(hittype == BULLET_HIT_TYPE_PLAYER)
		{
		    if(!IsAFK{ hitid })
		    {
				if(!CoolDown[playerid])
				{
					new Float:fOriginX, Float:fOriginY, Float:fOriginZ, Float:fHitPosX, Float:fHitPosY, Float:fHitPosZ;
					GetPlayerLastShotVectors(playerid, fOriginX, fOriginY, fOriginZ, fHitPosX, fHitPosY, fHitPosZ);
					CheckForAimbot(playerid, fHitPosX, fHitPosY, fHitPosZ);
				}
			}
		}*/
		if(hittype == BULLET_HIT_TYPE_PLAYER)
        {
            if(!IsAFK{ hitid })
            {
                if(!CoolDown[playerid])
                {
                    new Float:fOriginX, Float:fOriginY, Float:fOriginZ, Float:fHitPosX, Float:fHitPosY, Float:fHitPosZ;
                    GetPlayerLastShotVectors(playerid, fOriginX, fOriginY, fOriginZ, fHitPosX, fHitPosY, fHitPosZ);
                    CheckForAimbot(playerid, fHitPosX, fHitPosY, fHitPosZ, hitid);
                }
            }
        }
	}
    return 1;
}


//------------------------------ STOCKs and TIMERs ----------------------------------

CheckForAimbot(playerid, Float:fX, Float:fY, Float:fZ, attacked = INVALID_PLAYER_ID)
{
    if(!CoolDown[playerid])
    {
        if(!DetectedForAimbot{playerid})
        {
            if(attacked != INVALID_PLAYER_ID)
            {
                if(!IsPlayerInRangeOfPoint(attacked, 3.0, fX, fY, fZ))
                {
                    TimesDetected[playerid]++;
                    if(TimesDetected[playerid] >= 3)
                    {
                        new string[110];
                        format(string, sizeof(string), "WARNING: %s(%d) is POSSIBLY using aimbot. /spec %d and /atest %d to test him.", GetName(playerid), playerid, playerid, playerid);
                        SendClientMessageToAll(COLOR_NOTES2, string);
						DetectedForAimbot{playerid} = true;
                    }
                }
            }
        }
    }
    return 1;
}

/*stock CheckForAimbot(playerid, Float:fX, Float:fY, Float:fZ)
{
	new string[118], Float:pX, Float:pY, Float:pZ;
	GetPlayerPos(playerid, pX, pY, pZ);

	if(!CoolDown[playerid])
	{
		if(!DetectedForAimbot{ playerid })
		{
			foreach(Player, i)
			{
				if(GetPlayerState(i) != PLAYER_STATE_SPECTATING)
				{
    				if(!IsPlayerInRangeOfPoint(i, 3.0, fX, fY, fZ))
				    {
				        TimesDetected[playerid]++;
				        if(TimesDetected[playerid] >= 3)
				        {
	   	    				format(string, sizeof(string), "WARNING: %s(%d) is POSSIBLY using aimbot. /spec %d and /atest %d to test him.", GetName(playerid), playerid, playerid, playerid);
					        //SendClientMessageToAll(COLOR_NOTES2, string);
						    DetectedForAimbot{ playerid } = true;
						}
					}
				}
			}
			if(TimesDetected[playerid] >= 3)
			{
				SendClientMessageToAll(COLOR_NOTES2, string);
			}
		}
	}
	string = "\0";
}*/

stock GetName(playerid)
{
	new pnameid[24];
	GetPlayerName(playerid,pnameid,sizeof(pnameid));
	return pnameid;
}


forward ResetCoolDown(playerid);
public ResetCoolDown(playerid)
{
    CoolDown[playerid] = 0;
    TimesShot[playerid] = 0;
	SetTimerEx("ToggleCoolDownTimer", 3500, false, "i", playerid);
    return 1;
}
forward ToggleCoolDownTimer(playerid);
public ToggleCoolDownTimer(playerid)
{
    ToggleCoolDown[playerid] = 1;
	return 1;
}
forward RemoveHit(playerid);
public RemoveHit(playerid)
{
	HasHit[playerid] = 0;
	return 1;
}

forward RemoveHitMarker(playerid, objectid);
public RemoveHitMarker(playerid, objectid)
{
	DestroyPlayerObject(playerid, objectid);
	HitMarkersCreated--;
	return 1;
}


//------------------------------ COMMANDS ----------------------------------

CMD:atest(playerid, params[]) {
	new id, string[90];
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_RED, "* You're not an admin!");
	if(sscanf(params, "i", id)) return SendClientMessage(playerid, COLOR_NOTES, "* /atest [ID]");
	if(!IsPlayerConnected(id) || id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED, "* Invalid ID!");

	if(!HitMarkerEnabled[id])
	{
		HitMarkerEnabled[id] = 1;
		format(string, sizeof(string), "* You will now see 'hit-markers' on %s.", GetName(id));
		SendClientMessage(playerid, COLOR_NOTES, string);
	}
	else
	{
	    HitMarkerEnabled[id] = 0;
	    format(string, sizeof(string), "* You will no longer see 'hit-markers' on %s.", GetName(id));
		SendClientMessage(playerid, COLOR_NOTES, string);
	}
	string = "\0";
	return 1;
}
CMD:suspects(playerid, params[]) {
	new count = 0, string1[48], string2[248];
	foreach(Player, i)
	{
		if(DetectedForAimbot{ i })
		{
		    count++;
		    format(string1, sizeof(string1), "%d suspects detected", count);
		    format(string2, sizeof(string2), "%s\n%s( ID: %d )", string2, GetName(i), i);
		}
	}
	if(count)
	{
		ShowPlayerDialog(playerid, DIALOG_SUSPECTLIST, DIALOG_STYLE_LIST, string1, string2, "Close", "");
	}
	else
	{
		ShowPlayerDialog(playerid, DIALOG_SUSPECTLIST, DIALOG_STYLE_LIST, string1, "No aimboters have been detected.", "Close", "");
	}
    return 1;
}
CMD:clearsuspects(playerid, params[]) {
	foreach(Player, i)
	{
		DetectedForAimbot{ i } = false;
		TimesDetected[i] = 0;
	}
	return 1;
}