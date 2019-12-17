/*
=================================
		FcukIt Anti-Cheat 
  		  v3.0 Ultimate
  		Coded by Scarface
=================================
*/

/*
==========================================
		  Special Thanks to:
Dracoblue: DCMD - Fast Commands Processor
Kyeman: Implementation Ideas

Beta Testers:
[CBK]Hitman
[DRuG]Evil_Gnomes
[BDC]Taipan
TroyRulz007

==========================================
*/

#include <a_samp>
#include <core>
#include <float>

#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
//#define dcmd(%1,%2) if ((strcmp(cmdtext, "/%1", true, %2+1) == 0)&&(((cmdtext[%2+1]==0)&&(dcmd_%1(playerid,"")))||((cmdtext[%2+1]==32)&&(dcmd_%1(playerid,cmdtext[%2+2]))))) return 1
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
forward MaxInterval(); aBan(); aKick(); pCheck(); pLoop(); hLoop2(); pausetest(); pauseresult(); hSelect(); pausetest1(); pausetest2(); pausetest3();

// IMPORTANT: Change "50" to your servers set maximum players for MAXIMUM EFFICIENCY
#define MP 50

/*
======================
     Declarations
======================
*/

new aWa, aCashInc, aDbkills, aHealth, aCash, aDrive, aInac, aItime, cCheck,
hCheck, aIkill, aSkill, aStime, aSlimit, aSpoof, aClone, aLog, aLagg, aOnKill; // Settings

new KickTimer[MP], BanTimer[MP]; // Kick/Ban Arrays
new Float:Health, Float:HealthB, hcStage, rp; // Health Check
new Float:hx, Float:hy, Float:hz, Float:thx, Float:thy, Float:thz;
new Cashb[MP], Cash[MP]; // Cash Check
new dbcount[MP]; // Anti Drive-By-Abuse
new settimer = 0;
new aWpn1, aWpn2, aWpn3, aWpn4, aWpn5, aWpn6, aWpn7, aWpn8, aWpn9, aWpn10, aWpn11, aWpn12; // Anti-BannedWeapons
new Float:Xb[MP], Float:Yb[MP], Float:Zb[MP], Float:Xa[MP], Float:Ya[MP], Float:Za[MP];
new sTime[MP], sCount[MP];
new activekick=0, activeban=0;
new gString[255];
new hTIME, cTIME, iTIME, sTIME, wTIME; 

enum CD_ENUM
{
	PlayerIP[32]
}

new CloneData[MP][CD_ENUM];

new bWeapons[12];

#pragma unused aWpn1

/*
=================
	Anti-LaGG
=================
*/

new pLimit;
new pIntervals;
new pTime;
new pTolerance;
new pWarning;
new pWarnings[MP];
new check[MP];
new checkcount;
new ping[MP][5];


/*
======================
         Main
======================
*/

stock PlayerName(playerid)
{
  new pName[32];
  GetPlayerName(playerid, pName, sizeof(pName));
  return pName;
}
public OnFilterScriptInit()
{
	rConfig();
	pTime = (pIntervals*2);
	bWeapons[0] = -1; bWeapons[1] = aWpn2; bWeapons[2] = aWpn3; bWeapons[3] = aWpn4;
	bWeapons[4] = aWpn5; bWeapons[5] = aWpn6; bWeapons[6] = aWpn7; bWeapons[7] = aWpn8;
	bWeapons[8] = aWpn9; bWeapons[9] = aWpn10; bWeapons[10] = aWpn11; bWeapons[11] = aWpn12;
	print("\n  FcukIt Anti-Cheat v3.0 Ultimate by Scarface [Lethal Developments]");
	print("  Loading Configuration......\n");
	print("    Configuration: ");
	if(aWa > 0){  	  print("      |Anti-BWeapons    [Activated]"); }else{ print("      |Anti-BWeapons    [Disabled]"); }
	if(aHealth > 0){  print("      |Anti-HealthHack  [Activated]"); }else{ print("      |Anti-HealthHack  [Disabled]"); }
	if(aCash > 0){    print("      |Anti-MoneyHack   [Activated]"); }else{ print("      |Anti-MoneyHack   [Disabled]"); }
	if(aDrive > 0){   print("      |Anti-DriveBy     [Activated]"); }else{ print("      |Anti-DriveBy     [Disabled]"); }
	if(aInac > 0){    print("      |Anti-Inactivity  [Activated]"); }else{ print("      |Anti-Inactivity  [Disabled]"); }
	if(aIkill > 0){   print("      |Anti-IntKills    [Activated]"); }else{ print("      |Anti-IntKills    [Disabled]"); }
	if(aSkill > 0){   print("      |Anti-SpawnKill   [Activated]"); }else{ print("      |Anti-SpawnKill   [Disabled]"); }
	if(aSpoof > 0){   print("      |Anti-Spoofing    [Activated]"); }else{ print("      |Anti-Spoofing    [Disabled]"); }
	if(aClone > 0){   print("      |Anti-Cloning     [Activated]"); }else{ print("      |Anti-Cloning     [Disabled]"); }
	if(aLog > 0){     print("      |IP-Log           [Activated]"); }else{ print("      |IP-Log           [Disabled]"); }
	if(aCash > 0){    printf("      |Max-Cash-Inc 	[%d]",aCashInc); }
	if(aDrive > 0){   printf("      |Max-DB-Kills     [%d]",aDbkills); }
	if(aInac > 0){    printf("      |Inactive-Time    [%d]",aItime); }
	if(aHealth > 0){  printf("      |CashCheck-Time   [%d]",cCheck); }
	if(aCash > 0){    printf("      |HealthCheck-Time [%d]",hCheck); }
	if(aSkill > 0){   printf("      |Spawn-Kill-Time 	[%d]",aStime); }
	if(aCash > 0){    printf("      |Max-Spawn-Kills 	[%d]\n",aSlimit); }
	if(aLagg > 0){    print("      |Anti-LaGG        [Activated]"); }else{ print("      |Anti-LaGG        [Disabled]"); }
	printf("      |Ping Limit = %d",pLimit);
	printf("      |Check Intervals = %d",pIntervals);
	if(pWarning == 1)
	{
	printf("      |Ping Tolerance = %d\n",pTolerance);
	}
	print("------------------------------------------------------");
	print("      Server Monitored by FcukIt v3.0 Ultimate");
	print("------------------------------------------------------");
	return 1;
}

public OnPlayerDisconnect(playerid)
{
	KickTimer[playerid] = 0;
	BanTimer[playerid] = 0;
	dbcount[playerid] = 0;
	Cashb[playerid] = 0;
	Cash[playerid] = 0;
	sTime[playerid] = 0;
	sCount[playerid] = 0;
	KickTimer[playerid] = 0;
	check[playerid] = 0;
	pWarnings[playerid] = 0;
	ClearIPData(playerid);
	ClearPingData(playerid);
	if(playerid == rp) hcStage = 0;
	return 1;
}

public OnPlayerConnect(playerid)
{
	GetIPData(playerid);
	if(aLog > 0) Log(playerid);
    dbcount[playerid] = 0;
   	pWarnings[playerid] = 0;
   	ClearPingData(playerid);
//  Impersonator(playerid);
    Xb[playerid]=4000.0, Yb[playerid]=4000.0, Zb[playerid]=4.0;
    Cashb[playerid] = 500;
	if(settimer!=1)
	{
		SetTimer("MaxInterval",500,1);
		hTIME = (hCheck*2);
		cTIME = (cCheck*2);
		iTIME = (aItime*2);
		wTIME = 9;
		sTIME = 2;
	    settimer=1;
	}
	new iString[128];
	SendClientMessage(playerid, 0xFFFF00AA, "*** Server Monitored by FcukIt v3.0 Ultimate! [by [DRuG]Scarface]");
	if(pWarning == 0 && aLagg != 0)
	{
	format(iString, sizeof(iString), "Ping Limit: %dms", pLimit);
	SendClientMessage(playerid, 0xFFFF00AA, iString);
	}
	if(pWarning > 0 && aLagg != 0)
	{
	format(iString, sizeof(iString), "Ping Limit: %dms Tolerance: %dms", pLimit, pTolerance);
	SendClientMessage(playerid, 0xFFFF00AA, iString);
	}
	return 1;
}

public MaxInterval()
{
		hTIME--; cTIME--; iTIME--; sTIME--; pTime--; wTIME--;
		if(aHealth > 0 && hTIME == 0){ hSelect(); hTIME = (hCheck*2);} /*print("hLoop Started...");*/
		if(aWa > 0 && wTIME == 0){ rWeapon(); wTIME = (hCheck*2);} /*print("wLoop Started...");*/
		if(aCash > 0 && cTIME == 0){ cLoop(); cTIME = (cCheck*2);} /*print("cLoop Started...");*/
		if(aInac > 0 && iTIME == 0){ iLoop(); iTIME = (aItime*2);} /*print("iLoop Started...");*/
		if(aSkill > 0 && sTIME == 0){ sLoop(); sTIME = 2;} /*print("sLoop Started...");*/
		if(pTime == 0){ pLoop(); pTime = (pIntervals*2);} /*print("pingLoop Started...");*/
}

public OnPlayerSpawn(playerid)
{
	sTime[playerid] = aStime;
	return 1;
}

/*
====================
	Health Check
====================
*/

stock ActivePlayers()
{
	for(new ap=0;ap<MP;ap++)
	{
	    if(IsPlayerConnected(ap))
	    {
	        return 1;
		}
	}
	return 0;
}

stock ActivePlayerCount()
{
	new players=0;
	for(new pc=0; pc<MP; ap++)
	{
	    if(IsPlayerConnected(pc))
	    {
	        players++;
		}
	}
	return players;
}

stock hSelect()
{
	if(aHealth > 0 && ActivePlayers())
	{
	 	rp = random(MP);
		if(IsPlayerConnected(rp))
		{
		    hcStage = 0;
			Health = 0.0;
			HealthB = 0.0;
			hcStage = 1;
			pausetest();
		}
		else
		{
			hSelect();
			return 1;
		}
	}
	return 1;
}

public pausetest()
{
	if(IsPlayerConnected(rp) && hcStage == 1 && CorrectState(rp))
	{
		GetPlayerPos(rp, hx, hy, hz);
		SetTimer("pausetest1", 1300,0);
		return 1;
	}
	return 0;
}

public pausetest1()
{
	if(IsPlayerConnected(rp) && hcStage == 1 && CorrectState(rp))
	{
		GetPlayerPos(rp, thx, thy, thz);
		if(thx != hx || thy != hy || thz != hz)
		{
		    SetTimer("pausetest2", 1300,0);
		}
		else {
		hcStage = 0;
		}
	}
	return 0;
}

public pausetest2()
{
	if(IsPlayerConnected(rp) && hcStage == 1 && CorrectState(rp))
	{
		GetPlayerPos(rp, thx, thy, thz);
		if(thx != hx || thy != hy || thz != hz)
		{
		   SetTimer("pausetest3", 1300,0);
		}
		else {
		hcStage = 0;
		}
	}
	return 0;
}

public pausetest3()
{
	if(IsPlayerConnected(rp) && hcStage == 1 && CorrectState(rp))
	{
		hcStage = 2;
		GetPlayerPos(rp, thx, thy, thz);
		if(thx != hx || thy != hy || thz != hz)
		{
		    pauseresult();
		}
		else {
		hcStage = 0;
		}
	}
	return 0;
}

public pauseresult()
{
	    if(IsPlayerConnected(rp) && hcStage == 2)
		{
		    new Float:hx2, Float:hy2, Float:hz2;
			GetPlayerPos(rp, hx2, hy2, hz2);
			if(hx2 == hx && hy2 == hy && hz == hz2)
			{
				hcStage = 0;
				return 1;
			}
			else
			{
   				if(aHealth > 0)
				{
					if(IsPlayerConnected(rp) && CorrectState(rp))
					{
						new Float:tmpVal;
						GetPlayerHealth(rp, tmpVal);
						HealthB = tmpVal;
						SetPlayerHealth(rp, (tmpVal-1.0));
						hcStage = 3;
						SetTimer("hLoop2",1500,0);
					}
				}
			}
		}
		return 0;
}
	
public hLoop2()
{
		if(IsPlayerConnected(rp) && hcStage == 3 && CorrectState(rp))
		{
			GetPlayerHealth(rp, Health);
			new Float:hx2, Float:hy2, Float:hz2;
			GetPlayerPos(rp, hx2, hy2, hz2);
			if(Health == HealthB && CorrectState(rp) && HealthB != 0.0)
			{
				{
				if(aHealth == 1)
   					{
		    			FcukKick(rp, "Health Cheating");
					}
					else if(aHealth == 2)
					{
						FcukBan(rp, "Health Cheating");
					}
				}
				return 1;
			}
			else {
   			new Float:testh2;
			GetPlayerHealth(rp,testh2);
			SetPlayerHealth(rp,(testh2+1.0));
			hcStage = 0;
			}
		}
		return 0;
}

stock CorrectState(playerid)
{
	if(GetPlayerState(playerid) == 0) return 0;
	if(GetPlayerState(playerid) == 7) return 0;
	if(GetPlayerState(playerid) == 8) return 0;
	if(GetPlayerState(playerid) == 9) return 0;
	return 1;
}

/*
====================
	Cash Check
====================
*/

stock cLoop()
{
if(aCash > 0)
{
//print("cCheck Successful");
for(new c=0;c<MP;c++)
	{
	if(IsPlayerConnected(c))
	{
	new Differance;
	
	Cash[c] = GetPlayerMoney(c);
	Differance = (Cash[c] - Cashb[c]);
	
	if(Cash[c] > Cashb[c])
	{
		if(Differance > aCashInc)
		{
		if(aCash == 1)
		    {
				FcukKick(c, "Money Cheating");
			}
			else if(aCash == 2)
			{
		    	FcukBan(c, "Money Cheating");
			}
		  }
		  else {
		  Cashb[c] = Cash[c];
		  }
		}
		}
	}
	}
}

/*
========================
	Inactivity Check
========================
*/

stock iLoop()
{
if(aInac > 0)
{
for(new i=0;i<MP;i++)
	{
	if(IsPlayerConnected(i))
	{
		GetPlayerPos(i, Float:Xa[i], Float:Ya[i], Float:Za[i]);
		if((Float:Xa[i] == Float:Xb[i]) && (Float:Ya[i] == Float:Yb[i]))
		{
		if(aInac == 1)
		    {
				FcukKick(i, "Prolonged Inactivity");
			}
			else if(aInac == 2)
			{
				FcukBan(i, "Prolonged Inactivity");
			}
		}
		else {
		Xb[i] = Xa[i];
		Yb[i] = Ya[i];
		}
	}
	}
	}
}

/*
========================
	S-Kill Detection
========================
*/

stock sLoop()
{
for(new s=0;s<MP;s++)
	{
	if(IsPlayerConnected(s))
	{
	    if(sTime[s] > 0)
	    {
	    sTime[s]--;
	    }
	}
}
}

public OnPlayerDeath(playerid, killerid, reason)
{
    if(killerid != INVALID_PLAYER_ID)
	{

		if(aDrive > 0)
		{
			if(IsPlayerInAnyVehicle(killerid) && reason != WEAPON_VEHICLE)
			{
			dbcount[killerid]++;
			}
			else if(IsPlayerInAnyVehicle(killerid) == 0)
			{
			dbcount[killerid] = 0;
			}
		
			if(dbcount[killerid] >= aDbkills)
			{
			if(aDrive == 1)
			{
				FcukKick(killerid, "Repeatative Drive-By's");
				dbcount[killerid] = 0;
			}
			else if(aDrive == 2)
			{
				FcukBan(killerid, "Repeatative Drive-By's");
				dbcount[killerid] = 0;
			}
			else if(aDrive == 3)
			{
 			   FcukDisarm(killerid, "Repeatative Drive-By's");
	  		   dbcount[killerid] = 0;
			}
		}
	}

		if(aIkill > 0)
		{
			if(IsPlayerConnected(killerid))
			{
		if(GetPlayerInterior(killerid) != 0)
		{
		    if(!IsPlayerInAnyVehicle(killerid))
		    {
		    if(aIkill == 1)
		    {
				FcukKick(killerid, "Interior Weapon Use");
			}
			else if(aIkill == 2)
			{
		    	FcukBan(killerid, "Interior Weapon Use");
			}
			}
		}
		}
	}

		if(aSkill > 0)
		{
	    if(IsPlayerConnected(playerid) && IsPlayerConnected(killerid))
		{
		    if(sTime[playerid] > 0)
			{
			sCount[killerid]++;

			if(sCount[killerid] >= aSlimit)
			{
			if(aSkill == 1)
		    {
		    	FcukKick(killerid, "Repeatative Spawn Killing");
				sCount[killerid] = 0;
			}
			else if(aSkill == 2)
			{
		    	FcukBan(killerid, "Repeatative Spawn Killing");
				sCount[killerid] = 0;
			}
			else if(aSkill == 3)
			{
		    	FcukDisarm(killerid, "Repeatative Spawn Killing");
				sCount[killerid] = 0;
			}
	    	}
		}
	    }
   }
   
		if(aSpoof > 0)
		{
	    if(IsPlayerConnected(killerid) && IsPlayerConnected(playerid))
	    {
			new Float:spoofhealth;
			spoofhealth = GetPlayerHealth(playerid, spoofhealth);

			if(spoofhealth > 70 && reason != INVALID_PLAYER_ID)
			{
			if(aSpoof == 1)
		    {
		    	FcukKick(killerid, "ID Spoofing");
		    	return 1;
			}
			else if(aSpoof == 2)
			{
		    	FcukBan(killerid, "ID Spoofing");
		    	return 1;
			}
			}
 		}
		}
		
		if(aWa > 0)
		{
	    if(reason == aWpn1 || reason == aWpn2 || reason == aWpn3 || reason == aWpn4 || reason == aWpn5 || reason == aWpn6 || reason == aWpn7 || reason == aWpn8 || reason == aWpn9 || reason == aWpn10 || reason == aWpn11 || reason == aWpn12)
	    {
	        new wtxt2[64];
	        format(wtxt2, sizeof(wtxt2), "Used a Banned Weapon (%s)", reason);

	        if(aOnKill == 1)
		    {
		    	FcukKick(killerid, wtxt2);
			}
			else if(aOnKill == 2)
			{
		    	FcukBan(killerid, wtxt2);
			}
		}
		}


}
	return 1;
}

/*
====================
	Weapon Check
====================
*/

rWeapon()
{
	new ra = random(MP);
	if(ActivePlayers())
	{
		if(IsPlayerConnected(ra))
		{
		    WeaponCheck(ra);
		}
		else
		{
		    rWeapon();
		}
	}
	return 1;
}

stock WeaponCheck(playerid)
{
	if(aWa > 0)
	{
 			if(IsPlayerConnected(playerid))
 			{
 			    for(new slot=0;slot<10;slot++)
				{
				new tmpwpn, ammo;
				GetPlayerWeaponData(playerid, slot, tmpwpn, ammo);
				
 				for(new s=0;s<12;s++)
	    		{
	    			if(tmpwpn == bWeapons[s])
	    			{
	    			    new wtxt[64];
	    			    new wname[32];
	    			    GetWeaponName(tmpwpn, wname, sizeof(wname));
	    			    format(wtxt, sizeof(wtxt), "has a Banned Weapon (%s)", wname);
	    			    
	        			if(aWa == 1)
		    			{
		    				FcukKick(playerid, wtxt);
		    				return 1;
						}
						else if(aWa == 2)
						{
		    				FcukBan(playerid, wtxt);
							return 1;
						}
					}
				}
			}
 		}
 	}
	return 1;
}

/*
====================
	Clone Check
====================
*/

GetIPData(playerid)
{
    new tmpip[64];
	GetPlayerIp(playerid, tmpip,64);
	strins(CloneData[playerid][PlayerIP],tmpip,0,32);
	CloneCheck(playerid);
	return 1;
}

ClearIPData(playerid)
{
	strdel(CloneData[playerid][PlayerIP],0,32);
}

CloneCheck(playerid)
{
	if(aClone > 0)
	{
 	for(new c=0;c<MP;c++)
	{
	if(playerid != c)
	{
	    new tmpIP[64];
	    GetPlayerIp(playerid, tmpIP,64);
	    if(CloneData[c][PlayerIP] == strval(tmpIP))
		{
		    new clstring[255];
			//Detected Clone
			if(aClone == 1)
			{
				format(clstring, sizeof(clstring), "<FcukIt> Detected %s and %s are Clones (Warned)", PlayerName(playerid),PlayerName(c));
				SendClientMessageToAll(COLOR_YELLOW, clstring);
			}
			else if(aClone == 2)
			{
			    format(clstring, sizeof(clstring), "is a Clone of %s",PlayerName(c));
			    FcukKick(c, clstring);
			}
		}
	}
	}
	}
}

			

/*
===================
  Kick/Ban Timers
===================
*/

public aBan()
{
for(new k=0;k<MP;k++)
	{
		if(IsPlayerConnected(k))
		{
		    if(BanTimer[k] == 1)
		    {
			activeban = 0;
		    BanTimer[k] = 0;
		    dbcount[k] = 0;
		    Cashb[k] = 0;
		    Ban(k);
		    }
		}
	}
}


public aKick()
{
for(new j=0;j<MP;j++)
	{
		if(IsPlayerConnected(j))
		{
		    if(KickTimer[j] == 1)
		    {
		    activekick = 0;
		    KickTimer[j] = 0;
		    dbcount[j] = 0;
		    Kick(j);
		    }
		}
	}
}

/*
===================
 Kick/Ban Messages
===================
*/

FcukKick(playerid, message[])
{
format(gString, sizeof(gString),"<FcukIt> Detected %s %s (Kicked)", PlayerName(playerid), message);
SendClientMessageToAll(COLOR_YELLOW, gString);
KickTimer[playerid] = 1;
SaveKDetails(playerid, message);
if(activekick == 0){ SetTimer("aKick",750,0); activekick = 1;}
printf("<FcukIt> Successful Kick (%s) - %s", PlayerName(playerid), message);
}

FcukBan(playerid, message[])
{
format(gString, sizeof(gString),"<FcukIt> Detected %s %s (Banned)", PlayerName(playerid), message);
SendClientMessageToAll(COLOR_YELLOW, gString);
BanTimer[playerid] = 1;
SaveBDetails(playerid, message);
if(activeban == 0){
SetTimer("aBan",750,0);}
activeban = 1;
printf("<FcukIt> Successful Ban (%s) - %s", PlayerName(playerid), message);
}

FcukDisarm(playerid, message[])
{
format(gString, sizeof(gString),"<FcukIt> Detected %s %s (Disarmed)", PlayerName(playerid), message);
SendClientMessageToAll(COLOR_YELLOW, gString);
ResetPlayerWeapons(playerid);
}

/*
=========================
	 Config Function
=========================
*/

rConfig()
{
	new File:fhandle;
	new cname[64];
	new temp[256];
	new value[64];
	fhandle = fopen("ficonfig.txt",io_readwrite);
	while(fread(fhandle,temp,sizeof(temp),false))
		{
		    cname = strtok(temp,0);
			value = strtok(temp,(strlen(cname)+1));
			if(strcmp(cname,"Weapon1",true) == 0) aWpn1 = strval(value);
			else if(strcmp(cname,"Weapon2",true) == 0) aWpn2 = strval(value);
			else if(strcmp(cname,"Weapon3",true) == 0) aWpn3 = strval(value);
			else if(strcmp(cname,"Weapon4",true) == 0) aWpn4 = strval(value);
			else if(strcmp(cname,"Weapon5",true) == 0) aWpn5 = strval(value);
			else if(strcmp(cname,"Weapon6",true) == 0) aWpn6 = strval(value);
			else if(strcmp(cname,"Weapon7",true) == 0) aWpn7 = strval(value);
			else if(strcmp(cname,"Weapon8",true) == 0) aWpn8 = strval(value);
			else if(strcmp(cname,"Weapon9",true) == 0) aWpn9 = strval(value);
			else if(strcmp(cname,"Weapon10",true) == 0) aWpn10 = strval(value);
			else if(strcmp(cname,"Weapon11",true) == 0) aWpn11 = strval(value);
			else if(strcmp(cname,"Weapon12",true) == 0) aWpn12 = strval(value);
			else if(strcmp(cname,"Max-Cash-Increase",true) == 0) aCashInc = strval(value);
			else if(strcmp(cname,"DB-Kills",true) == 0) aDbkills = strval(value);
			else if(strcmp(cname,"A-Health",true) == 0) aHealth = strval(value);
			else if(strcmp(cname,"A-Cash",true) == 0) aCash = strval(value);
			else if(strcmp(cname,"A-DriveBy",true) == 0) aDrive = strval(value);
			else if(strcmp(cname,"A-Inactivity",true) == 0) aInac = strval(value);
			else if(strcmp(cname,"A-BWeapons",true) == 0) aWa = strval(value);
			else if(strcmp(cname,"Inactive-Period",true) == 0) aItime = strval(value);
			else if(strcmp(cname,"hCheck-Time",true) == 0) hCheck = strval(value);
			else if(strcmp(cname,"cCheck-Time",true) == 0) cCheck = strval(value);
			else if(strcmp(cname,"A-InteriorKill",true) == 0) aIkill = strval(value);
			else if(strcmp(cname,"A-SpawnKill",true) == 0) aSkill = strval(value);
			else if(strcmp(cname,"Spawn-Kill-Time",true) == 0) aStime = strval(value);
			else if(strcmp(cname,"Max-Spawn-Kills",true) == 0) aSlimit = strval(value);
			else if(strcmp(cname,"A-Spoofing",true) == 0) aSpoof = strval(value);
			else if(strcmp(cname,"A-Cloning",true) == 0) aClone = strval(value);
			else if(strcmp(cname,"Log-Enabled",true) == 0) aLog = strval(value);
			else if(strcmp(cname,"Ping-Limit",true) == 0) pLimit = strval(value);
			else if(strcmp(cname,"Ping-Intervals",true) == 0) pIntervals = strval(value);
			else if(strcmp(cname,"Ping-Warning(0/1)",true) == 0) pWarning = strval(value);
			else if(strcmp(cname,"Ping-Tolerance",true) == 0) pTolerance = strval(value);
			else if(strcmp(cname,"A-Lagg",true) == 0) aLagg = strval(value);
			else if(strcmp(cname,"A-OnKill",true) == 0) aOnKill = strval(value);
		}
	fclose(fhandle);
	return 1;
}

/*
========================
      Save Details
========================
*/

Log(playerid)
{
 	new File:fhandle;
	new temp[256];
	new IP[32];

	GetPlayerIp(playerid, IP, sizeof(IP));
	fhandle = fopen("FcukIPlog.txt",io_append);
	format(temp,sizeof(temp),"%s %s\r\n",IP,PlayerName(playerid));
	fwrite(fhandle,temp);
	fclose(fhandle);
}

SaveKDetails(playerid, reason[])
{
new File:fhandle;
new temp[256];
new month, day, year, hour, minute, second;
getdate(year, month, day);
gettime(hour, minute, second);

fhandle = fopen("Fcukkick.txt",io_append);
format(temp,sizeof(temp),"%s %s Date: %d/%d/%d Time: %d:%d\r\n",PlayerName(playerid),reason,day,month,year,hour,minute);
fwrite(fhandle,temp);
fclose(fhandle);
}

SaveBDetails(playerid, reason[])
{
new File:fhandle;
new temp[256];
new month, day, year, hour, minute, second;
getdate(year, month, day);
gettime(hour, minute, second);

fhandle = fopen("Fcukban.txt",io_append);
format(temp,sizeof(temp),"%s %s Date: %d/%d/%d Time: %d:%d\r\n",PlayerName(playerid),reason,day,month,year,hour,minute);
fwrite(fhandle,temp);
fclose(fhandle);
}

/*
========================
        Commands
========================
*/

public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(fhealth,7,cmdtext);
	dcmd(fcash,5,cmdtext);
	dcmd(finactive,9,cmdtext);
	dcmd(fbweapons,9,cmdtext);
	dcmd(fskill,6,cmdtext);
	dcmd(fclone,6,cmdtext);
	dcmd(frestart,8,cmdtext);
	dcmd(fshutdown,9,cmdtext);
	dcmd(fhelp,5,cmdtext);
	dcmd(fdriveby,8,cmdtext);
	dcmd(fcukit,6,cmdtext);
	return 0;
}

/*
========================
   Command Functions
========================
*/

stock dcmd_fhealth(playerid, params[])
{
#pragma unused params
	    if(IsPlayerAdmin(playerid))
	    {
	        if(aHealth == 1)
	        {
			aHealth=0;
			SendClientMessage(playerid, COLOR_YELLOW, "<FcukIt> Health Check Shutdown");
			}
			else {
			aHealth=1;
			SendClientMessage(playerid, COLOR_YELLOW, "<FcukIt> Health Check Activated");
			}
		}
		return 1;
	}
	
stock dcmd_fcash(playerid, params[])
{
#pragma unused params
	    if(IsPlayerAdmin(playerid))
	    {
	        if(aCash == 1)
	        {
			aCash=0;
			SendClientMessage(playerid, COLOR_YELLOW, "<FcukIt> Cash Check Shutdown");
			}
			else {
			aCash=1;
			SendClientMessage(playerid, COLOR_YELLOW, "<FcukIt> Cash Check Activated");
			}
		}
		return 1;
 	}
 	
stock dcmd_finactive(playerid,params[])
{
#pragma unused params
	    if(IsPlayerAdmin(playerid))
	    {
	        if(aInac == 1)
	        {
			aInac=0;
			SendClientMessage(playerid, COLOR_YELLOW, "<FcukIt> Inactivity Check Shutdown");
			}
			else {
			aInac=1;
			SendClientMessage(playerid, COLOR_YELLOW, "<FcukIt> Inactivity Check Activated");
			}
		}
		return 1;
 	}

stock dcmd_fbweapons(playerid,params[])
{
#pragma unused params
	    if(IsPlayerAdmin(playerid))
	    {
	        if(aWa == 1)
	        {
			aWa=0;
			SendClientMessage(playerid, COLOR_YELLOW, "<FcukIt> Anti-Banned Weapons Shutdown");
			}
			else {
			aWa=1;
			SendClientMessage(playerid, COLOR_YELLOW, "<FcukIt> Anti-Banned Weapons Activated");
			}
		}
		return 1;
 	}

stock dcmd_fskill(playerid, params[])
{
#pragma unused params
	    if(IsPlayerAdmin(playerid))
	    {
	        if(aSkill == 1)
	        {
			aSkill=0;
			SendClientMessage(playerid, COLOR_YELLOW, "<FcukIt> Anti-Spawn-Killing Shutdown");
			}
			else {
			aSkill=1;
			SendClientMessage(playerid, COLOR_YELLOW, "<FcukIt> Anti-Spawn-Killing Activated");
			}
		}
		return 1;
 	}
 	
stock dcmd_fclone(playerid, params[])
{
#pragma unused params
	    if(IsPlayerAdmin(playerid))
	    {
	        if(aClone == 1)
	        {
			aClone=0;
			SendClientMessage(playerid, COLOR_YELLOW, "<FcukIt> Anti-Clone-Detection Shutdown");
			}
			else {
			aClone=1;
			SendClientMessage(playerid, COLOR_YELLOW, "<FcukIt> Anti-Clone-Detection Activated");
			}
		}
		return 1;
 	}

stock dcmd_frestart(playerid, params[])
{
#pragma unused params
	    if(IsPlayerAdmin(playerid))
	    {
			rConfig();
			SendClientMessage(playerid, COLOR_YELLOW, "<FcukIt> FcukIt Anti-Cheat Successfully Restarted!");
		}
		return 1;
}

stock dcmd_fshutdown(playerid, params[])
{
#pragma unused params
	    if(IsPlayerAdmin(playerid))
	    {
			aHealth=0, aCash=0, aInac=0, aSkill=0, aIkill=0, aWa=0, aDrive=0;
			aWa=0, aSpoof=0, aClone=0, aLog=0, aLagg=0;
			SendClientMessage(playerid, COLOR_YELLOW, "<FcukIt> Emergency Shutdown Successful");
		}
		return 1;
	}
	
stock dcmd_fhelp(playerid, params[])
{
#pragma unused params
	    if(IsPlayerAdmin(playerid))
	    {
			SendClientMessage(playerid, COLOR_YELLOW, "FcukIt v3.0 Administrator Command List");
			SendClientMessage(playerid, COLOR_YELLOW, "Main: /frestart, /fshutdown, /fcukit");
			SendClientMessage(playerid, COLOR_YELLOW, "Toggle Checks:");
			SendClientMessage(playerid, COLOR_YELLOW, "/fclone, /fskill, /fbweapons, /finactive");
			SendClientMessage(playerid, COLOR_YELLOW, "/fdriveby, /fhealth, /fcash");
		}
		return 1;
	}

stock dcmd_fcukit(playerid, params[])
{
#pragma unused params
	    if(IsPlayerConnected(playerid))
	    {
		SendClientMessage(playerid, COLOR_RED, "FcukIt Anti-Cheat:");
		SendClientMessage(playerid, COLOR_YELLOW, "Version: v3.0 Ultimate [Build 264]");
		SendClientMessage(playerid, COLOR_YELLOW, "Coded by [DRuG]Scarface");
	 	}
		return 1;
}
	
stock dcmd_fdriveby(playerid, params[])
{
#pragma unused params
	    if(IsPlayerConnected(playerid) && IsPlayerAdmin(playerid))
	    {
	        if(aDrive == 1)
	        {
			aDrive=0;
			SendClientMessage(playerid, COLOR_YELLOW, "<FcukIt> Anti-Drive-By Shutdown");
			return 1;
			}
			else {
			aDrive=1;
			SendClientMessage(playerid, COLOR_YELLOW, "<FcukIt> Anti-Drive-By Activated");
			}
		}
		return 1;
	}

/*
=================
	Anti-LaGG
=================
*/

stock pLoop()
{
if(aLagg != 1) return 1;
if(checkcount == 5)
{
pCheck();
checkcount = 0;
return 1;
}
else {
checkcount++;
}
for(new h=0;h<MP;h++)
	{
	if(IsPlayerConnected(h))
	{
//	printf("Check #%d",check[h]);
	ping[h][check[h]] = GetPlayerPing(h);
	check[h]++;
	}
	}
return 1;
}

public pCheck()
{
for(new i=0;i<MP;i++)
	{
	if(IsPlayerConnected(i))
	{
	check[i] = 0;
	new kstring[128], wstring[128];
	new PingL = (pLimit + pTolerance);
	new PingAvg = ((ping[i][0] + ping[i][1] + ping[i][2] + ping[i][3] + ping[i][4]) / 5);

	if((PingAvg > pLimit) && (PingAvg > PingL))
		{
		format(kstring, sizeof(kstring), "<FcukIt> %s has been kicked (High Ping)", PlayerName(i));
		SendClientMessageToAll(0xFFFF00AA, kstring);
		KickTimer[i] = 1;
		SetTimer("aKick",1000,0);
		}
	if((PingAvg > pLimit) && (pWarning < 1))
	    {
		format(kstring, sizeof(kstring), "<FcukIt> %s has been kicked (High Ping)", PlayerName(i));
		SendClientMessageToAll(0xFFFF00AA, kstring);
		KickTimer[i] = 1;
		SetTimer("aKick",1000,0);
		}
	if((PingAvg <= PingL) && (PingAvg > pLimit))
		{
		    if(pWarnings[i] < 2)
		    {
			pWarnings[i]++;
			format(wstring, sizeof(wstring), "<FcukIt> Warning: Your ping is close to the Limit of %d (%d/3)", pLimit, pWarnings[i]);
			SendClientMessage(i, 0xFFFF00AA, wstring);
			}
			else
			{
			SendClientMessage(i, 0xFFFF00AA, "<FcukIt> You have reached your Third Warning!");
			format(kstring, sizeof(kstring), "<FcukIt> %s has been kicked (High Ping)", PlayerName(i));
			SendClientMessageToAll(0xFFFF00AA, kstring);
			pWarnings[i] = 0;
			KickTimer[i] = 1;
			SetTimer("aKick",1000,0);
			}
		}
	ClearPingData(i);
	}
	}
	}
	
ClearPingData(playerid)
{
	ping[playerid][0] = 0, ping[playerid][1] = 0;
	ping[playerid][2] = 0, ping[playerid][3] = 0;
	ping[playerid][4] = 0;
}


/*
=======================
	  Nick-Change // Currently in Development, Not Suitable for use in v3.0.
=======================


stock Impersonator(playerid)
{
	new File:fhandle;
	new fIP[32], playerIP[32];
	new temp[128], itxt[128];
	new nickname[32];
	
	GetPlayerIp(playerid, playerIP, 32);
	
	fhandle = fopen("Fcuklog.txt",io_readwrite);
	while(fread(fhandle,temp,sizeof(temp),false))
		{
		    fIP = strtok(temp,0);
			nickname = strtok(temp,(strlen(fIP)+1));
			if(nickname == PlayerName(playerid)strcmp()) return 1;
			printf("fIP: %s nickname: %s", fIP, nickname);
			if(strcmp(fIP,playerIP,true) == 0) format(itxt, sizeof(itxt), "<FcukIt Detected> %s is also known as %s (Impersonator)", PlayerName(playerid), nickname); SendClientMessageToAll(0xFFFF00AA, itxt); print("Name Match");
		}
	fclose(fhandle);
	return 1;
}*/

/*
========================
     String Defines
========================
*/

strtok(const string[],valve)
{
	new index=valve;
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
