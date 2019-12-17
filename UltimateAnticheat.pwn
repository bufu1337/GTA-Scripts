/*				 _       _____
				| |     | ____|
				| |     | |__
				| |     |  __|
				| |___  | |___
				|_____| |_____|
_________________________________________________
|             Scriptname : Ultimate AntiCheat	  |
|             Version : 1.2                       |
|                                                 |
|   Eine Produktion vom LE Script Team            |
|                13.02.2009                       |
|   Letztes Update am: 14.02.2009                 |
|                                                 |
|   Hauptscripter: [HC]Littlejohnny               |
|   Co-Scripter: [HC]E4sTsId3			          |
|   Tester: [HC]Littlejohnny		              |
|									              |
|   Credits:                                      |
|   eAdmin - Weaponhack/Badnames/Badwords  		  |
|   Pixels^ & KineticNRG - SA:MP Punkbuster       |
|_________________________________________________|
|                                                 |
|   ICQ Messenger:  492-670-404 (Littlejohnny)    |
|					456-118-961 (E4sTsId3)        |
|                                                 |
|       Copyright 2009 by LE Script Team          |
|_________________________________________________|
*/

#include <a_samp>

new Spawned[MAX_PLAYERS];

//======================= [Anti-HealthHack] ==================================//
forward HealthUpdate();
forward HealthCheck();
forward HealthUpdate2();
new Checking[MAX_PLAYERS];

forward xHealthUpdate();
forward xHealthCheck();
forward xHealthUpdate2();
new xChecking[MAX_PLAYERS];

new Float:health;
new Float:ohealth;

//======================= [Anti-ArmourHack] ==================================//
forward ArmourUpdate();
forward ArmourCheck();
forward ArmourUpdate2();
new Checking2[MAX_PLAYERS];

//======================= [Anti-JetPackHack] =================================//
forward AntiJetpack();

//======================= [Anti-WeaponHack] ==================================//
forward WeaponCheck();

//========================== [Anti-Spam] =====================================//
forward ResetSpam(playerid);
forward ResetSpamCMD(playerid);
forward ResetMute(playerid);
#define MAX_SPAM_MESSAGES 	3
#define MAX_SPAM_CMDS 		3
new Spam[MAX_PLAYERS];
new SpamCMD[MAX_PLAYERS];
new Mute[MAX_PLAYERS];

//========================== [Anti-HighPing] =================================//
#define MAX_PING 400
forward HighPingKick();

//========================== [ForbiddenWords] ================================//
#define FWORDS "Badwords.cfg"
new ForbiddenWords[100][100], ForbiddenWordCount = 0;

//========================== [ForbiddenNames] ================================//
#define BNAMES "Badnames.cfg"
new BadNames[100][100], BadNameCount = 0;

//========================== [Anti-Bot] ======================================//
forward AntiBot();

//======================= [Anti-SpeedHack] ===================================//
forward SpeedCheck();
forward SpeedUpdate();
new Speed[MAX_PLAYERS];
enum SavePlayerPosEnum
{
    Float:LastX,
    Float:LastY,
    Float:LastZ
}
new SavePlayerPos[MAX_PLAYERS][SavePlayerPosEnum];

//=========================== [Colors] =======================================//
#define RED 		0xFF0000AA
#define LIGHTGREEN 	0x99FF00AA

public OnFilterScriptInit()
{
	print("|*****************************|");
	print("|  _   _       ___   _____    |");
	print("| | | | |     /   | |  ___|   |");
	print("| | | | |    / /| | | |       |");
	print("| | | | |   / / | | | |       |");
	print("| | |_| |  / /  | | | |___    |");
	print("| |_____| /_/   |_| |_____|   |");
	print("|*****************************|");
	print("|  Ultimate Anticheat loaded  |");
	print("|*****************************|");
	print("| Script by : LE Script Team  |");
	print("|*****************************|");
	
	print("|************************|");
	SetTimer("HealthUpdate", 29000,  1); 	// All  29 	 Sekunden wird gecheckt
	SetTimer("xHealthUpdate",50000,  1); 	// All  50 	 Sekunden wird gecheckt
	SetTimer("ArmourUpdate", 20000,  1); 	// Alle 20 	 Sekundem wird gecheckt
	SetTimer("AntiJetpack",  700,    1); 	// Alle 0.7  Sekunden wird gecheckt
	SetTimer("WeaponCheck",  800,    1); 	// Alle 0.8  Sekunden wird gecheckt
	SetTimer("ResetMute",  	 300000, 1); 	// Alle 5 	 Minuten  wird Resettet
	SetTimer("PingKick", 	 10000,  1);    // Alle 10   Sekunden wird gecheckt
	SetTimer("AntiBot", 	 150000, 1);    // Alle 2,5  Minuten  wird gecheckt
	SetTimer("SpeedUpdate",  1200,   1);    // Alle 1,2  Sekunden wird gecheckt
	SetTimer("SpeedCheck",   5000,   1);   	// Alle 5    Sekunden wird gecheckt
	
	ForbiddenWordsLoad();                   // Verbotene Wörter werden geladen
	ForbiddenNamesLoad();                   // Verbotene Namen werden geladen
	return 1;
}

public OnFilterScriptExit()
{
    print("|*******************************|");
	print("|    _   _       ___   _____    |");
	print("|   | | | |     /   | |  ___|   |");
	print("|   | | | |    / /| | | |       |");
	print("|   | | | |   / / | | | |       |");
	print("|   | |_| |  / /  | | | |___    |");
	print("|   |_____| /_/   |_| |_____|   |");
	print("|*******************************|");
	print("|  Ultimate Anticheat unloaded  |");
	print("|*******************************|");
	print("|  Script by : LE Script Team   |");
	print("|*******************************|");
	return 1;
}

public OnPlayerConnect(playerid)
{
Spawned[playerid] = 0;
Checking[playerid] = 0;
Checking2[playerid] = 0;
xChecking[playerid] = 0;
Spam[playerid] = 0;
SpamCMD[playerid] = 0;
Mute[playerid] = 0;

for(new s = 0; s < BadNameCount; s++)
{
if(!strcmp(BadNames[s],GetName(playerid),true))
{
SendClientMessage(playerid, RED, "== ANTI-CHEAT: Du wurdest gekickt weil du einen verbotenen Namen hast ! (BadName)");
Kick(playerid);
return 1;
}
}

return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
Spawned[playerid] = 0;
Checking[playerid] = 0;
Checking2[playerid] = 0;
xChecking[playerid] = 0;
Spam[playerid] = 0;
SpamCMD[playerid] = 0;
Mute[playerid] = 0;
return 1;
}

public OnPlayerSpawn(playerid)
{
Spawned[playerid] = 1;
return 1;
}

public OnPlayerDeath(playerid,killerid,reason)
{
Spawned[playerid] = 0;
return 1;
}

//============================================================================//
public HealthUpdate()
{
    for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && Spawned[i] == 1)
		{
		if(Checking[i] == 0)
 		{
 			GetPlayerHealth(i,health);
 			SetPlayerHealth(i, health-1.0);
 			Checking[i] = 1;
 			SetTimer("HealthCheck", 1000, 0);
 			SetTimer("HealthUpdate2", 3000, 0);
 		}
 		}
	}
   	return 1;
}

public HealthCheck()
{
	new hstring[128];
    for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && Spawned[i] == 1)
		{
		if(Checking[i] == 1)
 		{
 		    GetPlayerHealth(i,health);
 			if(health > 99)
 			{
 				SendClientMessage(i, RED, "== ANTI-CHEAT: Du wurdest gekickt weil du unendlich Gesundheit hast ! (HealthHack)");
 				format(hstring,sizeof(hstring), "== ANTI-CHEAT: %s (id:%d) wurde gekickt weil er unendlich Gesundheit hat ! (HealthHack)", GetName(i), i);
 				SendClientMessageToAll(LIGHTGREEN, hstring);
 				Kick(i);
 			}
 			}
 		}
	}
   	return 1;
}

public HealthUpdate2()
{
    for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && Spawned[i] == 1)
		{
		if(Checking[i] == 1)
 		{
			GetPlayerHealth(i,health);
 			SetPlayerHealth(i, health+1.0);
			Checking[i] = 0;
		}
 		}
	}
   	return 1;
}

//============================================================================//
public xHealthUpdate()
{
    for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && Spawned[i] == 1)
		{
		if(xChecking[i] == 0)
 		{
 			GetPlayerHealth(i,ohealth);
 			SetPlayerHealth(i, ohealth-1.0);
 			xChecking[i] = 1;
 			SetTimer("xHealthCheck", 1000, 0);
 			SetTimer("xHealthUpdate2", 3000, 0);
 		}
 		}
	}
   	return 1;
}

public xHealthCheck()
{
	new hstring[128];
    for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && Spawned[i] == 1)
		{
		if(xChecking[i] == 1)
 		{
 		    GetPlayerHealth(i, health);
 			if(health == ohealth)
 			{
 				SendClientMessage(i, RED, "== ANTI-CHEAT: Du wurdest gekickt weil du unendlich Gesundheit hast ! (HealthHack)");
 				format(hstring,sizeof(hstring), "== ANTI-CHEAT: %s (id:%d) wurde gekickt weil er unendlich Gesundheit hat ! (HealthHack)", GetName(i), i);
 				SendClientMessageToAll(LIGHTGREEN, hstring);
 				Kick(i);
		}
 			}
 		}
	}
   	return 1;
}

public xHealthUpdate2()
{
    for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && Spawned[i] == 1)
		{
		if(xChecking[i] == 1)
 		{
			GetPlayerHealth(i,health);
 			SetPlayerHealth(i, health+1.0);
			xChecking[i] = 0;
		}
 		}
	}
   	return 1;
}

//============================================================================//
public ArmourUpdate()
{
	new Float:armour;
    for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && Spawned[i] == 1)
		{
		if(Checking2[i] == 0)
 		{
 			GetPlayerArmour(i,armour);
 			if(armour > 1) {
 			SetPlayerArmour(i, armour-1.0);
 			Checking2[i] = 1;
 			SetTimer("ArmourCheck", 1000, 0);
 			SetTimer("ArmourUpdate2", 3000, 0);
		}
 			}
		}
	}
   	return 1;
}

public ArmourCheck()
{
	new Float:armour;
	new hstring[128];
    for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && Spawned[i] == 1)
		{
		if(Checking2[i] == 1)
 		{
 			GetPlayerArmour(i,armour);
 			if(armour > 99)
 			{
 				SendClientMessage(i, RED, "== ANTI-CHEAT: Du wurdest gekickt weil du unendlich Panzerung hast ! (ArmourHack)");
 				format(hstring,sizeof(hstring), "== ANTI-CHEAT: %s (id:%d) wurde gekickt weil er unendlich Panzerung hat ! (ArmourHack)", GetName(i), i);
 				SendClientMessageToAll(LIGHTGREEN, hstring);
 				Kick(i);
 			}
 			}
 		}
	}
   	return 1;
}

public ArmourUpdate2()
{
	new Float:armour;
    for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && Spawned[i] == 1)
		{
		if(Checking2[i] == 1)
 		{
			GetPlayerArmour(i,armour);
 			SetPlayerArmour(i, armour+1.0);
			Checking2[i] = 0;
		}
 		}
	}
   	return 1;
}

//============================================================================//
public AntiJetpack()
{
new string[128];
for(new i; i < MAX_PLAYERS; i++)
{
    if(IsPlayerConnected(i) && Spawned[i] == 1)
	{
		if(GetPlayerSpecialAction(i) == 2) //JetPack
		{
			format(string,sizeof(string), "== ANTI-CHEAT: %s (id:%d) wurde gekickt weil er Jet-Pack benutzt ! (JetPackHack)", GetName(i), i);
			SendClientMessageToAll(LIGHTGREEN, string);
			Kick(i);
		}
	}
}
return 1;
}

//============================================================================//
public WeaponCheck()
{
	new string[128];
	for(new i; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && Spawned[i] == 1)
		{
		new weapon;
		new ammo;
		GetPlayerWeaponData(i, 7, weapon, ammo);
		if(weapon == 38 && ammo >= 1)
		{
		SendClientMessage(i, RED, "== ANTI-CHEAT: Du wurdest gebannt, weil du eine Minigun hast ! (WeaponHack) !");
		format(string, sizeof(string), "== ANTI-CHEAT: %s (id:%d) wurde gebannt, weil er eine Minigun hat ! (WeaponHack)", GetName(i), i);
		SendClientMessageToAll(LIGHTGREEN, string);
		Ban(i);
		}
		if(weapon == 36 && ammo >= 1)
		{
		SendClientMessage(i, RED, "== ANTI-CHEAT: Du wurdest gebannt, weil du einen Raketenwerfer hast ! (WeaponHack) !");
		format(string, sizeof(string), "== ANTI-CHEAT: %s (id:%d) wurde gebannt, weil er einen Raketenwerfer hat ! (WeaponHack)", GetName(i), i);
		SendClientMessageToAll(LIGHTGREEN, string);
		Ban(i);
		}
		if(weapon == 35 && ammo >= 1)
		{
		SendClientMessage(i, RED, "== ANTI-CHEAT: Du wurdest gebannt, weil du einen Raketenwerfer hast ! (WeaponHack) !");
		format(string, sizeof(string), "== ANTI-CHEAT: %s (id:%d) wurde gebannt, weil er einen Raketenwerfer hat ! (WeaponHack)t", GetName(i), i);
		SendClientMessageToAll(LIGHTGREEN, string);
		Ban(i);
		}
		if(weapon == 40 && ammo >= 1)
		{
		SendClientMessage(i, RED, "== ANTI-CHEAT: Du wurdest gebannt, weil du Rucksackbomben hast ! (WeaponHack) !");
		format(string, sizeof(string), "== ANTI-CHEAT: %s (id:%d) wurde gebannt, weil er Rucksackbomben hat ! (WeaponHack)", GetName(i), i);
		SendClientMessageToAll(LIGHTGREEN, string);
		Ban(i);
		}
		}
	}
	return 1;
}

//============================================================================//
public OnPlayerText(playerid, text[])
{
    new string[128];
	if(Mute[playerid] == 1)
	{
	    SendClientMessage(playerid, RED, "== ANTI-CHEAT: Du bist gemutet und kannst nichts schreiben !");
	    return 0;
	}
	
	Spam[playerid]++;
	SetTimerEx("ResetSpam", 3000, 0, "d", playerid);
	if(Spam[playerid] > MAX_SPAM_MESSAGES)
	{
  		Mute[playerid] = 1;
  		SendClientMessage(playerid, RED, "== ANTI-CHEAT: Du wurdest für 5 Minuten gemutet !");
		format(string, sizeof(string), "== ANTI-CHEAT: %s (id:%d) bekommt Chatverbot! (Grund: Spam)", GetName(playerid), playerid);
		SendClientMessageToAll(LIGHTGREEN, string);
		return 0;
	}
	
	for(new s = 0; s < ForbiddenWordCount; s++)
    {
		new pos;
		while((pos = strfind(text,ForbiddenWords[s],true)) != -1) for(new i = pos, j = pos + strlen(ForbiddenWords[s]); i < j; i++) text[i] = '*';
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	SpamCMD[playerid]++;
	SetTimerEx("ResetSpamCMD", 4000, 0, "d", playerid);
	if(Spam[playerid] > MAX_SPAM_CMDS)
	{
		SendClientMessage(playerid, RED, "== ANTI-CHEAT: Kein Command Spam ! (Befehle sind in 4 Sekunden wieder verfügbar)");
		return 1;
	}
	return 0;
}

public ResetSpam(playerid)
{
	Spam[playerid] = 0;
	return 1;
}

public ResetMute(playerid)
{
    if(Mute[playerid] == 1)
	{
		Mute[playerid] = 0;
	}
	return 1;
}

public ResetSpamCMD(playerid)
{
	SpamCMD[playerid] = 0;
	return 1;
}

//============================================================================//
public HighPingKick()
{
	new string[256];
	for(new i = 0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && Spawned[i] == 1)
		{
	   		new ping;
			ping = GetPlayerPing(i);
			if(ping > MAX_PING)
			{
			    format(string,sizeof(string), "== ANTI-CHEAT: Du wurdest gekickt, weil du einen zu hohen Ping hast ! (HighPing [Max Ping: %d])", MAX_PING);
	            SendClientMessage(i, RED, string);
		    	format(string,sizeof(string), "== ANTI-CHEAT: %s (id:%d) wurde gekickt ! (HighPing [Max Ping: %d])", GetName(i), i, MAX_PING);
		    	SendClientMessageToAll(LIGHTGREEN, string);
		    	Kick(i);
  			}
		}
	}
}

//============================================================================//
stock ForbiddenWordsLoad()
{
    new File:file;
	new xstring[100];

	ForbiddenWordCount = 0;

	if((file = fopen(FWORDS,io_read)))
	{
	while(fread(file,xstring))
	{
 	for(new i = 0, j = strlen(xstring); i < j; i++) if(xstring[i] == '\n' || xstring[i] == '\r') xstring[i] = '\0';
 	ForbiddenWords[ForbiddenWordCount] = xstring;
 	ForbiddenWordCount++;
	}
	fclose(file);	printf("== ANTI-CHEAT: %d verbotene Woerter geladen", ForbiddenWordCount);
	}
}

stock ForbiddenNamesLoad()
{
    new File:file;
	new string[100];

 	BadNameCount = 0;

	if((file = fopen(BNAMES,io_read)))
	{
	while(fread(file,string))
	{
 	for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
 	BadNames[BadNameCount] = string;
 	BadNameCount++;
	}
	fclose(file);	printf("== ANTI-CHEAT: %d verbotene Namen geladen", BadNameCount);
	}
}

//============================================================================//
public AntiBot()
{
	for(new i = 0; i<MAX_PLAYERS; i++)
 	{
  		if(IsPlayerConnected(i))
  		{
   			if(GetPlayerPing(i) < 1)
   			{
    			Kick(i);
   			}
  		}
 	}
}

//============================================================================//
public SpeedUpdate()
{
	new Float:xx,Float:yy,Float:zz;
	new Float:xdistance;
	for(new i=0; i<MAX_PLAYERS; i++) if(IsPlayerConnected(i)) if(Spawned[i] == 1)
	{
	    GetPlayerPos(i,xx,yy,zz);
        xdistance = floatsqroot(floatpower(floatabs(floatsub(xx,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(yy,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(zz,SavePlayerPos[i][LastZ])),2));
    	Speed[i] = floatround(xdistance);
    	SavePlayerPos[i][LastX] = xx;
   		SavePlayerPos[i][LastY] = yy;
   		SavePlayerPos[i][LastZ] = zz;
	}
}

public SpeedCheck()
{
	new string[256];
    for(new i; i<MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && Spawned[i] == 1)
		{
	    	if(GetPlayerState(i) == 2)
	    	{
	    	    new vehicle = GetPlayerVehicleID(i);
	    	    if(GetVehicleType(vehicle) == 3 && Speed[i] > 99)
	    	    {
					SendClientMessage(i, RED, "== ANTI-CHEAT: Du wurdest gebannt, weil du Speedhack benutzt hast ! (SpeedHack) !");
					format(string, sizeof(string), "== ANTI-CHEAT: %s (id:%d) wurde gebannt, weil er Speedhack benutzt hat ! (SpeedHack)", GetName(i), i);
					SendClientMessageToAll(LIGHTGREEN, string);
					Ban(i);
	    	    }
	    	    if(GetVehicleType(vehicle) != 3 && Speed[i] > 96)
	    	    {
   	    			SendClientMessage(i, RED, "== ANTI-CHEAT: Du wurdest gebannt, weil du Speedhack benutzt hast ! (SpeedHack) !");
					format(string, sizeof(string), "== ANTI-CHEAT: %s (id:%d) wurde gebannt, weil er Speedhack benutzt hat ! (SpeedHack)", GetName(i), i);
					SendClientMessageToAll(LIGHTGREEN, string);
					Ban(i);
				}
	    	}
		}
    }
    return 1;
}

stock GetVehicleType(vid)
{
	new type;
	switch(GetVehicleModel(vid)) {
	case
	596,   //copcarla,   //car
	599,   //copcarru,   //car
	597,   //copcarsf,   //car
	416,   //ambulan  -  car
	445,   //admiral  -  car
	602,   //alpha  -  car
	485,   //baggage  -  car
	568,   //bandito  -  car
	429,   //banshee  -  car
	499,   //benson  -  car
	424,   //bfinject,   //car
	536,   //blade  -  car
	496,   //blistac  -  car
	504,   //bloodra  -  car
	422,   //bobcat  -  car
	609,   //boxburg  -  car
	498,   //boxville,   //car
	401,   //bravura  -  car
	575,   //broadway,   //car
	518,   //buccanee,   //car
	402,   //buffalo  -  car
	541,   //bullet  -  car
	482,   //burrito  -  car
	431,   //bus  -  car
	438,   //cabbie  -  car
	457,   //caddy  -  car
	527,   //cadrona  -  car
	483,   //camper  -  car
	524,   //cement  -  car
	415,   //cheetah  -  car
	542,   //clover  -  car
	589,   //club  -  car
	480,   //comet  -  car
	578,   //dft30  -  car
	486,   //dozer  -  car
	507,   //elegant  -  car
	562,   //elegy  -  car
	585,   //emperor  -  car
	427,   //enforcer,   //car
	419,   //esperant,   //car
	587,   //euros  -  car
	490,   //fbiranch,   //car
	528,   //fbitruck,   //car
	533,   //feltzer  -  car
	544,   //firela  -  car
	407,   //firetruk,   //car
	565,   //flash  -  car
	455,   //flatbed  -  car
	530,   //forklift,   //car
	526,   //fortune  -  car
	466,   //glendale,   //car
	604,   //glenshit,   //car
	492,   //greenwoo,   //car
	474,   //hermes  -  car
	434,   //hotknife,   //car
	502,   //hotrina  -  car
	503,   //hotrinb  -  car
	494,   //hotring  -  car
	579,   //huntley  -  car
	545,   //hustler  -  car
	411,   //infernus,   //car
	546,   //intruder,   //car
	559,   //jester  -  car
	508,   //journey  -  car
	571,   //kart  -  car
	400,   //landstal,   //car
	403,   //linerun  -  car
	517,   //majestic,   //car
	410,   //manana  -  car
	551,   //merit  -  car
	500,   //mesa  -  car
	418,   //moonbeam,   //car
	572,   //mower  -  car
	423,   //mrwhoop  -  car
	516,   //nebula  -  car
	582,   //newsvan  -  car
	467,   //oceanic  -  car
	404,   //peren  -  car
	514,   //petro  -  car
	603,   //phoenix  -  car
	600,   //picador  -  car
	413,   //pony  -  car
	426,   //premier  -  car
	436,   //previon  -  car
	547,   //primo  -  car
	489,   //rancher  -  car
	441,   //rcbandit,   //car
	594,   //rccam  -  car
	564,   //rctiger  -  car
	515,   //rdtrain  -  car
	479,   //regina  -  car
	534,   //remingtn,   //car
	505,   //rnchlure,   //car
	442,   //romero  -  car
	440,   //rumpo  -  car
	475,   //sabre  -  car
	543,   //sadler  -  car
	605,   //sadlshit,   //car
	495,   //sandking,   //car
	567,   //savanna  -  car
	428,   //securica,   //car
	405,   //sentinel,   //car
	535,   //slamvan  -  car
	458,   //solair  -  car
	580,   //stafford,   //car
	439,   //stallion,   //car
	561,   //stratum  -  car
	409,   //stretch  -  car
	560,   //sultan  -  car
	550,   //sunrise  -  car
	506,   //supergt  -  car
	574,   //sweeper  -  car
	566,   //tahoma  -  car
	549,   //tampa  -  car
	420,   //taxi  -  car
	459,   //topfun  -  car
	576,   //tornado  -  car
	583,   //tug  -  car
	451,   //turismo  -  car
	558,   //uranus  -  car
	552,   //utility  -  car
	540,   //vincent  -  car
	491,   //virgo  -  car
	412,   //voodoo  -  car
	478,   //walton  -  car
	421,   //washing  -  car
	529,   //willard  -  car
	555,   //windsor  -  car
	456,   //yankee  -  car
	554,   //yosemite,   //car
	477   //zr3	50  -  car
	: return 0;
	case
	581,   //bf400  -  bike
	523,   //copbike  -  bike
	462,   //faggio  -  bike
	521,   //fcr900  -  bike
	463,   //freeway  -  bike
	522,   //nrg500  -  bike
	461,   //pcj600  -  bike
	448,   //pizzaboy,   //bike
	468,   //sanchez  -  bike
	586,   //wayfarer,   //bike
	509,   //bike  -  bmx
	481,   //bmx  -  bmx
	510,   //mtbike  -  bmx
	471   //quad  -  quad
	: return 1;
	case
	472,   //coastg  -  boat
	473,   //dinghy  -  boat
	493,   //jetmax  -  boat
	595,   //launch  -  boat
	484,   //marquis  -  boat
	430,   //predator,   //boat
	453,   //reefer  -  boat
	452,   //speeder  -  boat
	446,   //squalo  -  boat
	454   //tropic  -  boat
	: return 2;
	case
	548,   //cargobob,   //heli
	425,   //hunter  -  heli
	417,   //leviathn,   //heli
	487,   //maverick,   //heli
	497,   //polmav  -  heli
	563,   //raindanc,   //heli
	501,   //rcgoblin,   //heli
	465,   //rcraider,   //heli
	447,   //seaspar  -  heli
	469,   //sparrow  -  heli
	488,   //vcnmav  -  heli
	592,   //androm  -  plane
	577,   //at	400  -  plane
	511,   //beagle  -  plane
	512,   //cropdust,   //plane
	593,   //dodo  -  plane
	520,   //hydra  -  plane
	553,   //nevada  -  plane
	464,   //rcbaron  -  plane
	476,   //rustler  -  plane
	519,   //shamal  -  plane
	460,   //skimmer  -  plane
	513,   //stunt  -  plane
	539   //vortex  -  plane
	: return 3;
	case
	588,   //hotdog  -  car
	437,   //coach  -  car
	532,   //combine  -  car
	433,   //barracks,   //car
	414,   //mule  -  car
	443,   //packer  -  car
	470,   //patriot  -  car
	432,   //rhino  -  car
	525,   //towtruck,   //car
	531,   //tractor  -  car
	408,   //trash  -  car
	406,   //dumper  -  mtruck
	573,   //duneride,   //mtruck
	444,   //monster  -  mtruck
	556,   //monstera,   //mtruck
	557,   //monsterb,   //mtruck
	435,   //artict1  -  trailer
	450,   //artict2  -  trailer
	591,   //artict3  -  trailer
	606,   //bagboxa  -  trailer
	607,   //bagboxb  -  trailer
	610,   //farmtr1  -  trailer
	584,   //petrotr  -  trailer
	608,   //tugstair,   //trailer
	611,   //utiltr1  -  trailer
	590,   //freibox  -  train
	569,   //freiflat,   //train
	537,   //freight  -  train
	538,   //streak  -  train
	570,   //streakc  -  train
	449   //tram  -  train
	: return 4;
	}
	return type;
}

//============================================================================//
stock GetName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,sizeof(name));

	return name;
}
