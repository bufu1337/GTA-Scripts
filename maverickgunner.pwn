#include <a_samp>

/*
(c) Trooper 2009
Dies ist das Filterscript "Polizei Maverick Geschütz",Original von Trooper.
Bitte lass meine Credits drinnen, ich habe ein Menge Arbeit in dieses Script gesteckt !
Würdest du dir soviel Arbeit machen, möchtest du ja schließlich auch nicht, dass es einfach so geklaut wird !

Information:
*Du musst in einen Polizei Maverick gehen
*Du brauchst einen Behördenskin (Skin ID 280 bis 288)
*Benutze die Pfeiltasten zum Zielen ( X & Y)
*Benutze die Tasten, die du eig. zum Starten/Landen der Hydra benutzen würdest, um die Höhe einzustellen

*/



//#################### Server Einstellungen ##############################

// ---------------- Section Performance ----------------------------- (Angabe in MS)
new camtime = 100; //Zeit zwischen Aktualisierung der kameraposition des Schützen
new rockettime = 200; //Zeit bei Abschuss einer Rakete um zu prüfen, ob Rakete am Ziel ist
new keytime = 100; //Zeit, um nach gedrückten Tasten des Schützen zu sehen

// ---------------- Section Testing ---------------------------------
new testing = 0; //0 = aus, 1 = an || testmodus bedeutet, dass ein Testheli gespawnt wird, und wenn man /testing eingibt, sofort zu dem Heli teleportiert wird, und einen Polizeiskin erhält

// --------------- Section General Options --------------------------
new explosiontype = 6; //Explosionstyp, siehe Wiki
new Float:explosionradius = 10.0; //Explosionsradius, siehe wiki
new Float:rocketspeed = 56.0; //Raketengeschwindigkeit

/* ---------------- Ein paar Informationen -------------------------------
1.Siehe Linie 79/80 um das Raketenmodell zu ändern
2.Ich habe eine Menge Variablen benutzt, und zu ende wusste ich nichtmehr, ob ich alle brauche ! Unbenutzte Variablen können gerne gelöscht werden
3.Wenn du nicht scripten kannst, editiere lediglich die Werte oberhalb
4.Wenn die Meldung "Geschütz nicht bereit" aus unempfindlichen Gründen dauerhaft kommt, benutze /reload
5.Du kannst gerne das Script editieren, aber bitte lasse die Credits im Script und dem Konsolen-print drinnen !
*/
//#################### End of Settings ##############################


#define COLOR_RED 0xAA3333AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFFF
forward gunnertimer(playerid);
forward IsACop(killerid);
new gunner[MAX_PLAYERS];
new driver[MAX_PLAYERS];
forward checkraket(playerid);
forward funckeys(playerid);
new string[128];
new Missile;
new Float:vx,Float:vy,Float:vz;
new checkrakettimer[MAX_PLAYERS];
new keychecktimer[MAX_PLAYERS];
new heightz[MAX_PLAYERS];
new rakready = 1;
new aimplusx[MAX_PLAYERS];
new aimplusy[MAX_PLAYERS];
new vehicle[MAX_VEHICLES] = 0;
new Float:rakshootatx[MAX_PLAYERS],Float:rakshootaty[MAX_PLAYERS],Float:rakshootatz[MAX_PLAYERS];



public OnFilterScriptInit()
{
	if(testing == 1)
	{
		AddStaticVehicle(497,2064.6187,2643.2661,10.6719,0,0,0);
 	}
	print("\n--------------------------------------");
	print(" Polizei Maverick Geschütz - Addon geladen ! (c) Trooper 2009");
	print("--------------------------------------\n");
	//Missile = CreateObject(3786,-2299.105224,1957.136596,-5000.107460,0.000000,0.000000,0.000000); //Raketen - Model (schlecht, da es sich nicht drehen kann)
	Missile = CreateObject(354,-2299.105224,1957.136596,-5000.107460,0.000000,0.000000,0.000000); //Leuchtende Rakete (so wie in Area51 im SP Modus)
	return 1;
}

public OnFilterScriptExit()
{
	DestroyObject(Missile);
	return 1;
}

public OnPlayerConnect(playerid)
{
	gunner[playerid] = 0;
	driver[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    vehicle[GetPlayerVehicleID(playerid)] = 0;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(driver[playerid] == 1)
	{
        for(new i; i<MAX_PLAYERS; i++)
		{
	 		if(IsPlayerConnected(i) && IsACop(i) == 1 && GetPlayerVehicleID(i) == 497 && gunner[i] == 1)
	   		{
				SetPlayerHealth(i,0);
				DisablePlayerCheckpoint(i);
			}
		}
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate== PLAYER_STATE_DRIVER && IsACop(playerid) && GetVehicleModel(GetPlayerVehicleID(playerid)) == 497)
	{
	    driver[playerid] = 1;
	}
	if(newstate == 3 && IsACop(playerid) && GetVehicleModel(GetPlayerVehicleID(playerid)) == 497 && oldstate != newstate)
	{
		if(vehicle[GetPlayerVehicleID(playerid)] == 0)
		{
		    vehicle[GetPlayerVehicleID(playerid)] = 1;
			gunner[playerid] = 1;
			heightz[playerid] = 0;
			aimplusx[playerid] = 0;
			aimplusy[playerid] = 0;
		    SetTimerEx("gunnertimer",1000,0,"i",playerid);
		    keychecktimer[playerid] = SetTimerEx("funckeys",1000,0,"i",playerid);
		}
	}
	return 1;
}


public OnPlayerExitVehicle(playerid, vehicleid)
{
	KillTimer(keychecktimer[playerid]);
    RemovePlayerMapIcon(playerid,18);
	driver[playerid] = 0;
	if(IsACop(playerid) && gunner[playerid] == 1)
	{
	    gunner[playerid] = 0;
		SetCameraBehindPlayer(playerid);
	}
	DisablePlayerCheckpoint(playerid);

	vehicle[vehicleid] = 0;
	return 1;
}

public IsACop(killerid)
{
	if(GetPlayerSkin(killerid) == 280 || GetPlayerSkin(killerid) == 281 || GetPlayerSkin(killerid) == 282 || GetPlayerSkin(killerid) == 283 || GetPlayerSkin(killerid) == 284 || GetPlayerSkin(killerid) == 285 || GetPlayerSkin(killerid) == 286 || GetPlayerSkin(killerid) == 287 || GetPlayerSkin(killerid) == 288)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

public gunnertimer(playerid)
{
	if(gunner[playerid] == 1)
	{
		GetPlayerPos(playerid,vx,vy,vz);
		SetPlayerCameraPos(playerid, vx, vy, vz-1.5);
		SetPlayerCameraLookAt(playerid, vx + aimplusx[playerid], vy + aimplusy[playerid], vz - 40);

		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid,vx + aimplusx[playerid],vy + aimplusy[playerid],heightz[playerid],15);

		SetTimerEx("gunnertimer",camtime,0,"i",playerid);
	}
	else
	{
	    DisablePlayerCheckpoint(playerid);
	    SetCameraBehindPlayer(playerid);
	}
}

public funckeys(playerid)
{
    new keys, updown, leftright;
	GetPlayerKeys(playerid,keys,updown,leftright);
	if((keys == KEY_ANALOG_UP) && gunner[playerid] == 1)
	{
	    heightz[playerid] = heightz[playerid] + 1;
		format(string, sizeof(string), "Hoehe eingestellt auf %i", heightz[playerid] );
  		GameTextForPlayer(playerid,string,1000,3);
	}
	if((keys == KEY_ANALOG_DOWN) && gunner[playerid] == 1)
 	{
		heightz[playerid] = heightz[playerid] - 1;
		format(string, sizeof(string), "Hoehe eingestellt auf %i", heightz[playerid] );
		GameTextForPlayer(playerid,string,1000,3);
    }
    if((keys == KEY_FIRE) && gunner[playerid] == 1)
	{
	    if(rakready == 1)
	    {
			rakready = 0;
		 	GameTextForPlayer(playerid,"Rakete abgefeuert",2000,3);
			new Float:gunx,Float:guny,Float:gunz;
			GetPlayerPos(playerid,gunx,guny,gunz);
			SetPlayerMapIcon(playerid,18,gunx,guny,gunz,56,COLOR_RED);
			SetObjectPos(Missile,gunx,guny,gunz);
			MoveObject(Missile,vx + aimplusx[playerid],vy + aimplusy[playerid],heightz[playerid],rocketspeed);
			rakshootatx[playerid] = vx + aimplusx[playerid];
			rakshootaty[playerid] = vy + aimplusy[playerid];
			rakshootatz[playerid] = heightz[playerid];
			checkrakettimer[playerid] = SetTimerEx("checkraket",rockettime,0,"i",playerid);
			return 0;
		}
		else
		{
		    GameTextForPlayer(playerid,"Geschuetz nicht bereit",1000,3);
		}
	}
	if((leftright == KEY_LEFT) && gunner[playerid] == 1)
	{
	    aimplusx[playerid] = aimplusx[playerid] - 5;
	}
	if((leftright == KEY_RIGHT) && gunner[playerid] == 1)
	{
	    aimplusx[playerid] = aimplusx[playerid] + 5;
	}
	if((updown == KEY_UP) && gunner[playerid] == 1)
	{
	    aimplusy[playerid] = aimplusy[playerid] + 5;
	}
	if((updown == KEY_DOWN) && gunner[playerid] == 1)
	{
	    aimplusy[playerid] = aimplusy[playerid] - 5;
	}
	keychecktimer[playerid] = SetTimerEx("funckeys",keytime,0,"i",playerid);
    return 1;
}


public checkraket(playerid)
{
	new Float:rakstatusx[MAX_PLAYERS],Float:rakstatusy[MAX_PLAYERS],Float:rakstatusz[MAX_PLAYERS];
	GetObjectPos(Missile,rakstatusx[playerid],rakstatusy[playerid],rakstatusz[playerid]);
	RemovePlayerMapIcon(playerid,18);
	SetPlayerMapIcon(playerid,18,rakstatusx[playerid],rakstatusy[playerid],rakstatusz[playerid],56,COLOR_RED);

	if((rakstatusx[playerid] == rakshootatx[playerid]) && (rakstatusy[playerid] == rakshootaty[playerid]) && (rakstatusz[playerid] == rakshootatz[playerid]))
	{
	    rakready = 1;
	    CreateExplosion(rakstatusx[playerid],rakstatusy[playerid],rakstatusz[playerid],explosiontype,explosionradius);
	    SetObjectPos(Missile,0,0,-1000);
	    RemovePlayerMapIcon(playerid,18);
	    keychecktimer[playerid] = SetTimerEx("funckeys",keytime,0,"i",playerid);
	    return 0;
	}
	else
	{
	    checkrakettimer[playerid] = SetTimerEx("checkraket",rockettime,0,"i",playerid);
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp("/testing", cmdtext, true, 8) == 0 && testing == 1)
	{
		SetPlayerSkin(playerid,281);
		SetPlayerPos(playerid,2068.6187,2648.2661,13.6719);
		return 1;
	}
	if(strcmp("/reload", cmdtext, true, 7) == 0)
	{
		rakready = 1;
		return 1;
	}
	if(strcmp("/gunnerbug",cmdtext,true,10) == 0 && IsPlayerAdmin(playerid))
	{
	    for(new i; i<MAX_VEHICLES; i++)
	    {
			vehicle[i] = 0;
		}
		return 1;
	}
	return 0;
}