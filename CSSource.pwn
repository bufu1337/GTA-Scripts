                                                                                                                  /*
------------------------------------
Counter Strike: Source by ANTH1
Please keep my credits! :)
------------------------------------
                                                                                                                  */
/*----------------------------------------------------------------------------*/
#include <a_samp>

#include <core>

#include <float>

/*----------------------------------------------------------------------------*/

static gTeam[MAX_PLAYERS];

new gPlayerClass[MAX_PLAYERS];

/*----------------------------------------------------------------------------*/

#define GREY 0xAFAFAFAA

#define GREEN 0x21DD00FF

#define RED 0xE60000FF

#define ADMIN_RED 0xFB0000FF

#define YELLOW 0xFFFF00FF

#define ORANGE 0xF97804FF

#define LIGHTRED 0xFF8080FF

#define LIGHTBLUE 0x00C2ECFF

#define PURPLE 0xB360FDFF

#define PLAYER_COLOR 0xFFFFFFFF

#define BLUE 0x1229FAFF

#define LIGHTGREEN 0x38FF06FF

#define DARKPINK 0xE100E1FF

#define DARKGREEN 0x008040FF

#define ANNOUNCEMENT 0x00CACAFB

#define AFK 0x6AF7E1FF

/*----------------------------------------------------------------------------*/

#pragma tabsize 0

/*----------------------------------------------------------------------------*/

#define TEAM_CT 0

#define TEAM_T 1

#define TEAM_SPEC 2

/*----------------------------------------------------------------------------*/

//new gRoundTime = 900000; //15 minuten
new gRoundTime = 600000; // 10 minuten

/*----------------------------------------------------------------------------*/

main()

{

	print("\n----------------------------------");

	print("Script wurde von ANTH1 gescriptet!");

	print("Script Vollständig geladen...");

	print("----------------------------------\n");

}

/*----------------------------------------------------------------------------*/

public OnGameModeInit()

{

	SetGameModeText("CSS-SAMP");

	SetTeamCount(3);

	ShowNameTags(1);

	ShowPlayerMarkers(1);

	SetWorldTime(15);

	AddPlayerClass(285, -91.0983, -37.6175, 6.4844, 339.9113, 0, 0, 0, 0, 0, 0); // Counter Terrorist 1
	AddPlayerClass(285, -91.0983, -37.6175, 6.4844, 339.9113, 0, 0, 0, 0, 0, 0); // Counter Terrorist 2
	AddPlayerClass(127,-62.3435, 99.4694, 3.1172, 248.1017, 0, 0, 0, 0, 0, 0); // Terrorists 1
	AddPlayerClass(73,-62.3435, 99.4694, 3.1172, 248.1017, 0, 0, 0, 0, 0, 0); // Terrorists 2
	AddPlayerClass(165,-91.0983, -37.6175, 6.4844, 339.9113, 0, 0, 0, 0, 0, 0); // Spectator

	CreateObject(987, -124.60444641, 16.91079712, 2.18587875, 0.0000, 0.0000, 250.0000); //object(elecfence_bar) (1)
	CreateObject(987,-128.59582520,6.02115917,2.45082164,0.00000000,0.00000000,252.00000000); //object(elecfence_bar) (2)
	CreateObject(987,-132.58447266,-5.19066572,2.57560039,0.00000000,0.00000000,248.00000000); //object(elecfence_bar) (3)
	CreateObject(987,-137.03202820,-16.07564354,2.37582374,0.00000000,0.00000000,248.00000000); //object(elecfence_bar) (4)
	CreateObject(987,-141.39874268,-27.39153099,2.20954657,0.00000000,0.00000000,248.00000000); //object(elecfence_bar) (5)
	CreateObject(987,-98.98976135,-15.86578941,-56.94450378,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (6)
	CreateObject(987,-146.20811462,-38.58846283,2.11718750,0.00000000,0.00000000,248.00000000); //object(elecfence_bar) (7)
	CreateObject(987,-150.61853027,-49.48519516,2.11718750,0.00000000,0.00000000,250.00000000); //object(elecfence_bar) (8)
	CreateObject(987,-154.70486450,-60.49116516,2.11718750,0.00000000,0.00000000,248.00000000); //object(elecfence_bar) (9)
	CreateObject(987,-159.19644165,-71.41762543,2.11718750,0.00000000,0.00000000,248.00000000); //object(elecfence_bar) (10)
	CreateObject(987,-163.81930542,-82.42459106,2.11718750,0.00000000,0.00000000,250.00000000); //object(elecfence_bar) (11)
	CreateObject(987,-168.01441956,-93.37385559,2.11718845,0.00000000,0.00000000,250.00000000); //object(elecfence_bar) (12)
	CreateObject(987,-172.00561523,-104.36816406,2.11718750,0.00000000,0.00000000,348.00000000); //object(elecfence_bar) (13)
	CreateObject(987,-160.53320312,-106.86759949,2.11718750,0.00000000,0.00000000,354.00000000); //object(elecfence_bar) (14)
	CreateObject(987,-149.07377625,-108.09475708,2.11718750,0.00000000,0.00000000,350.00000000); //object(elecfence_bar) (15)
	CreateObject(987,-137.59133911,-110.13526154,2.11718655,0.00000000,0.00000000,350.00000000); //object(elecfence_bar) (16)
	CreateObject(987,-126.22240448,-112.19695282,2.11718750,0.00000000,0.00000000,350.00000000); //object(elecfence_bar) (17)
	CreateObject(987,-114.86887360,-114.12679291,2.11718750,0.00000000,0.00000000,348.00000000); //object(elecfence_bar) (18)
	CreateObject(987,-103.59810638,-116.56478119,2.11718750,0.00000000,0.00000000,348.00000000); //object(elecfence_bar) (19)
	CreateObject(987,-92.23217773,-119.04788208,2.10939693,0.00000000,0.00000000,349.00000000); //object(elecfence_bar) (20)
	CreateObject(987,-80.70663452,-121.32900238,2.11718750,0.00000000,0.00000000,352.00000000); //object(elecfence_bar) (21)
	CreateObject(987,-69.09472656,-122.92739105,2.11718750,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (22)
	CreateObject(987,-57.19941711,-123.00833130,2.10939598,0.00000000,0.00000000,72.00000000); //object(elecfence_bar) (23)
	CreateObject(987,-53.63156891,-111.96751404,2.11718750,0.00000000,0.00000000,71.00000000); //object(elecfence_bar) (24)
	CreateObject(987,-49.72676086,-100.89636230,2.11718845,0.00000000,0.00000000,72.00000000); //object(elecfence_bar) (25)
	CreateObject(987,-94.12576294,-92.79920197,-66.38467407,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (26)
	CreateObject(987,-46.15121841,-89.84993744,2.11718750,0.00000000,0.00000000,72.00000000); //object(elecfence_bar) (27)
	CreateObject(987,-42.38118744,-78.75991058,2.11718750,0.00000000,0.00000000,70.00000000); //object(elecfence_bar) (28)
	CreateObject(987,-38.30776978,-67.82318115,2.11718750,0.00000000,0.00000000,70.00000000); //object(elecfence_bar) (29)
	CreateObject(987,-34.40013885,-56.76224518,2.11718750,0.00000000,0.00000000,72.00000000); //object(elecfence_bar) (30)
	CreateObject(987,-30.70546722,-45.76206589,2.11718750,0.00000000,0.00000000,73.00000000); //object(elecfence_bar) (31)
	CreateObject(987,-27.26183319,-34.33549500,2.11718750,0.00000000,0.00000000,66.00000000); //object(elecfence_bar) (32)
	CreateObject(987,-22.25949860,-23.42306900,2.11718750,0.00000000,0.00000000,66.00000000); //object(elecfence_bar) (33)
	CreateObject(987,-17.40283203,-12.48448944,2.11718750,0.00000000,0.00000000,67.00000000); //object(elecfence_bar) (34)
	CreateObject(987,-12.69603729,-1.43245316,2.11718750,0.00000000,0.00000000,64.00000000); //object(elecfence_bar) (35)
	CreateObject(987,-7.45868683,9.38710403,2.11718750,0.00000000,0.00000000,62.00000000); //object(elecfence_bar) (36)
	CreateObject(987,-1.80080032,19.95310974,2.11718750,0.00000000,0.00000000,62.00000000); //object(elecfence_bar) (37)
	CreateObject(987,3.85367584,30.55053711,2.10964966,0.00000000,0.00000000,68.00000000); //object(elecfence_bar) (38)
	CreateObject(987,8.38282776,41.62943268,2.11718750,0.00000000,0.00000000,72.00000000); //object(elecfence_bar) (39)
	CreateObject(987,12.06781769,53.11351013,2.11718750,0.00000000,0.00000000,78.00000000); //object(elecfence_bar) (40)
	CreateObject(987,14.54330063,64.84638977,2.10964966,0.00000000,0.00000000,80.00000000); //object(elecfence_bar) (41)
	CreateObject(987,16.67079163,76.66600037,2.11718750,0.00000000,0.00000000,78.00000000); //object(elecfence_bar) (42)
	CreateObject(987,19.14863586,88.41363525,2.11718750,0.00000000,0.00000000,72.00000000); //object(elecfence_bar) (43)
	CreateObject(987,22.84498596,99.82240295,2.11718750,0.00000000,0.00000000,126.00000000); //object(elecfence_bar) (44)
	CreateObject(987,15.85869598,109.57485199,2.11718750,0.00000000,0.00000000,152.00000000); //object(elecfence_bar) (45)
	CreateObject(987,5.51436615,115.34977722,2.11718798,0.00000000,0.00000000,150.00000000); //object(elecfence_bar) (46)
	CreateObject(987,-4.85977173,121.39357758,2.11718750,0.00000000,0.00000000,150.00000000); //object(elecfence_bar) (47)
	CreateObject(987,-15.18192291,127.38355255,2.11718750,0.00000000,0.00000000,148.00000000); //object(elecfence_bar) (48)
	CreateObject(987,-25.42296600,133.69500732,2.10959911,0.00000000,0.00000000,150.00000000); //object(elecfence_bar) (49)
	CreateObject(987,-35.71679306,139.69454956,2.11718750,0.00000000,0.00000000,152.00000000); //object(elecfence_bar) (50)
	CreateObject(987,-46.30815125,145.33120728,2.11718750,0.00000000,0.00000000,154.00000000); //object(elecfence_bar) (51)
	CreateObject(987,-57.04321671,150.63404846,2.11718702,0.00000000,0.00000000,154.00000000); //object(elecfence_bar) (52)
	CreateObject(987,-67.78527832,155.97106934,2.11718750,0.00000000,0.00000000,200.00000000); //object(elecfence_bar) (53)
	CreateObject(987,-79.05757904,151.98522949,2.11718750,0.00000000,0.00000000,248.00000000); //object(elecfence_bar) (54)
	CreateObject(987,-83.60490417,140.96427917,2.11239052,0.00000000,0.00000000,248.00000000); //object(elecfence_bar) (55)
	CreateObject(987,-88.13323975,129.93150330,2.12128162,0.00000000,0.00000000,248.00000000); //object(elecfence_bar) (56)
	CreateObject(987,-92.68379974,118.97448730,2.11718750,0.00000000,0.00000000,250.00000000); //object(elecfence_bar) (57)
	CreateObject(987,-96.84473419,107.86805725,2.10960007,0.00000000,0.00000000,252.00000000); //object(elecfence_bar) (58)
	CreateObject(987,-100.53170013,96.54095459,2.11718750,0.00000000,0.00000000,250.00000000); //object(elecfence_bar) (59)
	CreateObject(987,-104.69721222,85.40911102,2.11718750,0.00000000,0.00000000,254.00000000); //object(elecfence_bar) (60)
	CreateObject(987,-108.00933075,73.95558167,2.11718750,0.00000000,0.00000000,250.00000000); //object(elecfence_bar) (61)
	CreateObject(987,-112.15306091,62.86804962,2.11718750,0.00000000,0.00000000,252.00000000); //object(elecfence_bar) (62)
	CreateObject(987,-115.90325165,51.61662292,2.11718750,0.00000000,0.00000000,256.00000000); //object(elecfence_bar) (63)
	CreateObject(987,-118.87887573,40.15527344,2.11718750,0.00000000,0.00000000,256.00000000); //object(elecfence_bar) (64)
	CreateObject(987,-121.91525269,28.69343567,2.11718750,0.00000000,0.00000000,257.00000000); //object(elecfence_bar) (65)

    SetTimer("GameModeExitFunc", gRoundTime, 0);

	return 1;

}

/*----------------------------------------------------------------------------*/

public OnGameModeExit()

{

	print("\n----------------------------------");

	print("Script von ANTH1.");

	print("----------------------------------\n");

	return 1;

}

/*----------------------------------------------------------------------------*/

public OnPlayerRequestClass(playerid, classid)

{

/*----------------------------------------------------------------------------*/

	SetPlayerClass(playerid, classid);

	SetupPlayerForClassSelection(playerid);

	gPlayerClass[playerid] = classid;

/*----------------------------------------------------------------------------*/

	switch (classid) {

	    case 0:

	        {

				GameTextForPlayer(playerid, "~b~Counter-Terrorist", 500, 3);

			}

		case 1:

		    {

				GameTextForPlayer(playerid, "~b~Counter-Terrorist", 500, 3);

			}

		case 2:

	        {

				GameTextForPlayer(playerid, "~r~Terrorist", 500, 3);

			}

		case 3:

	        {

				GameTextForPlayer(playerid, "~r~Terrorist", 500, 3);

			}

		case 4:

	        {

				GameTextForPlayer(playerid, "~g~SPECTATOR", 500, 3);

	}

}

	return 1;

}

/*----------------------------------------------------------------------------*/

SetPlayerClass(playerid, classid) {

	if(classid == 0) {

	    gTeam[playerid] = TEAM_CT;

	} else if(classid == 1) {

	    gTeam[playerid] = TEAM_CT;

	} else if(classid == 2) {

	    gTeam[playerid] = TEAM_T;

	} else if(classid == 3) {

	    gTeam[playerid] = TEAM_T;

	} else if(classid == 4) {

	    gTeam[playerid] = TEAM_SPEC;

	}

}

/*----------------------------------------------------------------------------*/

public OnPlayerConnect(playerid)

{
	GivePlayerMoney(playerid, 10000);
	SetPlayerColor(playerid, GREY);
	new string[48];
	new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, sizeof(pName));
   	format(string, sizeof(string), "%s ist dem Server Beigetreten!", pName);
   	SendClientMessageToAll(0x00C2ECFF, string);
   	SendDeathMessage(INVALID_PLAYER_ID,playerid,200);
   	return 1;
}

/*----------------------------------------------------------------------------*/

public OnPlayerDisconnect(playerid, reason)

{
   new pName[MAX_PLAYER_NAME];
   new string[56];
   GetPlayerName(playerid, pName, sizeof(pName));
   SendDeathMessage(INVALID_PLAYER_ID,playerid,201);

   switch(reason)
   {
       case 0: format(string, sizeof(string), "%s hat den Server verlassen. (Timeout)", pName);
       case 1: format(string, sizeof(string), "%s hat den Server verlassen. (Verlassen)", pName);
       case 2: format(string, sizeof(string), "%s hat den Server verlassen. (Kick/Ban)", pName);
   }
   SendClientMessageToAll(0x00C2ECFF, string);
   return 1;
}

/*----------------------------------------------------------------------------*/

public OnPlayerSpawn(playerid)

{

    SetPlayerInterior(playerid,0);

	if(gTeam[playerid] == TEAM_CT)
	{
    	SendClientMessage(playerid, BLUE, "Du bist bei der Counter-Terroriten!");
        SendClientMessage(playerid, BLUE, "Benutze /buy um Waffen zu kaufen.");
        GivePlayerWeapon(playerid, 4, 1);
        GivePlayerWeapon(playerid, 16, 1);
        GivePlayerWeapon(playerid, 24, 200);
        GivePlayerWeapon(playerid, 31, 400);
	    SetPlayerColor(playerid,BLUE); // CT
	}

	else if(gTeam[playerid] == TEAM_T)
	{
        SendClientMessage(playerid, RED, "Du bist bei der Terroristen!");
        SendClientMessage(playerid, RED, "Benutze /buy um Waffen zu kaufen.");
        GivePlayerWeapon(playerid, 4, 1);
        GivePlayerWeapon(playerid, 16, 1);
        GivePlayerWeapon(playerid, 24, 200);
        GivePlayerWeapon(playerid, 30, 400);
	    SetPlayerColor(playerid,RED); // T

	}

 	else if(gTeam[playerid] == TEAM_SPEC)
 	{
 	    SendClientMessage(playerid, LIGHTGREEN, "Du bist ein Spectator!");
        SendClientMessage(playerid, LIGHTGREEN, "Du bist eine Person, die unliminiertes Leben hat.");
        SendClientMessage(playerid, LIGHTGREEN, "Bitte zwing den anderen nicht das sie diesen server spielen sollen.");
	    SendClientMessage(playerid, LIGHTGREEN, "Und hab Spass beim Spielen, wuenscht dir dein Adminstrator!");
	    SetPlayerHealth(playerid, 100000);
	    SetPlayerColor(playerid,GREY); // Espectador
    }

	return 1;

}

/*----------------------------------------------------------------------------*/

public OnPlayerDeath(playerid, killerid, reason)

{
        SendDeathMessage(killerid,playerid,reason);
		SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
	    return 1;
}

/*----------------------------------------------------------------------------*/

public OnPlayerCommandText(playerid, cmdtext[])

{

	if (strcmp("/buy", cmdtext, true, 10) == 0)

	{
        if(gTeam[playerid] == TEAM_SPEC) {

        SendClientMessage(playerid, RED, "Fehler: Du kannst keine Waffen kaufen, du bist ein Spectator!");
        }
		//SendClientMessage(playerid, GREEN, "Write /buy [Weapon ID] to buy a weapon ( Example: /buy 4 )");

/*----------------------------------------------------------------------------*/

			    if(gTeam[playerid] == TEAM_T) {

			    SendClientMessage(playerid, GREEN, "Benutze /buy [WaffenID] um Waffen zu kaufen.(Beispiel: /buy 4)");

				SendClientMessage(playerid, ORANGE, "-(ID 1) KM .45 TACTICAL ($500)");

				SendClientMessage(playerid, ORANGE, "-(ID 2) NIGHT HAWK .50C ($700)");

				SendClientMessage(playerid, ORANGE, "-(ID 3) .40 DUAL ELITES ($800)");

				SendClientMessage(playerid, ORANGE, "-(ID 4) LEONE 12 GAUGE SUPER ($1700)");

				SendClientMessage(playerid, ORANGE, "-(ID 5) LEONE YG1265 AUTO SHOTGUN ($3000)");

				SendClientMessage(playerid, ORANGE, "-(ID 6) K&M SUB-MACHINE GUN ($1500)");

				SendClientMessage(playerid, ORANGE, "-(ID 7) CV-47 ($2500)");

                SendClientMessage(playerid, ORANGE, "-(ID 8) SCHMIDT SCOUT ($2750)");

				SendClientMessage(playerid, ORANGE, "-(ID 9) KEVLAR VEST ($650)");

				SendClientMessage(playerid, ORANGE, "-(ID 10) SMOKE GRENADE ($600)");

				SendClientMessage(playerid, ORANGE, "-(ID 11) HE GRENADE ($600)");

				}

/*----------------------------------------------------------------------------*/

		    else if(gTeam[playerid] == TEAM_CT) {

		        SendClientMessage(playerid, GREEN, "Benutze /buy [WaffenID] um Waffen zu kaufen.(Beispiel: /buy 4)");

		        SendClientMessage(playerid, ORANGE, "-(ID 1) KM .45 TACTICAL ($500)");

		        SendClientMessage(playerid, ORANGE, "-(ID 2) NIGHT HAWK .50C ($700)");

		        SendClientMessage(playerid, ORANGE, "-(ID 3) .40 DUAL ELITES ($800)");

		        SendClientMessage(playerid, ORANGE, "-(ID 4) LEONE 12 GAUGE SUPER ($1700)");

        		SendClientMessage(playerid, ORANGE, "-(ID 5) LEONE YG1265 AUTO SHOTGUN ($3000)");

        		SendClientMessage(playerid, ORANGE, "-(ID 6) K&M SUB-MACHINE GUN ($1500)");

        		SendClientMessage(playerid, ORANGE, "-(ID 7) MAVERICK M4A1 CARBINE ($3100)");

        		SendClientMessage(playerid, ORANGE, "-(ID 8) SCHMIDT SCOUT ($2750)");

        		SendClientMessage(playerid, ORANGE, "-(ID 9) KEVLAR VEST ($650)");

        		SendClientMessage(playerid, ORANGE, "-(ID 10) SMOKE GRENADE ($600)");

        		SendClientMessage(playerid, ORANGE, "-(ID 11) HE GRENADE ($600)");

		        }

        return 1;
        }

    {

/*----------------------------------------------------------------------------*/

    if (strcmp("/buy 1", cmdtext, true, 10) == 0)

    {

        GivePlayerWeapon(playerid, 23, 48);

        GivePlayerMoney(playerid, -500);

    }

    else if (strcmp("/buy 2", cmdtext, true, 10) == 0)

    {

        GivePlayerWeapon(playerid, 24, 35);

        GivePlayerMoney(playerid, -700);

    }

    else if (strcmp("/buy 3", cmdtext, true, 10) == 0)

    {

        GivePlayerWeapon(playerid, 22, 90);

        GivePlayerMoney(playerid, -800);

    }

    else if (strcmp("/buy 4", cmdtext, true, 10) == 0)

    {

        GivePlayerWeapon(playerid, 25, 50);

        GivePlayerMoney(playerid, -1700);

    }

    else if (strcmp("/buy 5", cmdtext, true, 10) == 0)

    {

        GivePlayerWeapon(playerid, 33, 50);

        GivePlayerMoney(playerid, -3000);

    }

    else if (strcmp("/buy 6", cmdtext, true, 10) == 0)

    {

        GivePlayerWeapon(playerid, 29, 90);

        GivePlayerMoney(playerid, -1500);

    }

    else if (strcmp("/buy 7", cmdtext, true, 10) == 0)

    {

    if(gTeam[playerid] == TEAM_CT) {

        GivePlayerWeapon(playerid, 31, 120);

        GivePlayerMoney(playerid, -3100);

    }

    if(gTeam[playerid] == TEAM_T)
    {

        GivePlayerWeapon(playerid, 30, 120);

        GivePlayerMoney(playerid, -2500);

    }

}

    else if (strcmp("/buy 8", cmdtext, true, 10) == 0)

    {

        GivePlayerWeapon(playerid, 34, 50);

        GivePlayerMoney(playerid, -2750);

    }

    else if (strcmp("/buy 9", cmdtext, true, 10) == 0)

    {

        SetPlayerArmour(playerid, 100);

       GivePlayerMoney(playerid, -650);

    }

    else if (strcmp("/buy 10", cmdtext, true, 10) == 0)

    {

        GivePlayerWeapon(playerid, 17, 5);

        GivePlayerMoney(playerid, -600);

    }

    else if (strcmp("/buy 11", cmdtext, true, 10) == 0)

    {

        GivePlayerWeapon(playerid, 16, 5);

        GivePlayerMoney(playerid, -600);

    }

	return 1;

}
	if (strcmp("/credits", cmdtext, true, 10) == 0) //Erstellt Befehl
	{
		SendClientMessage(playerid, 0x9CFF05FF, "Scripter: GSG9");
		SendClientMessage(playerid, 0x9CFF05FF, "Mapper: Maps werden noch von *GSG9* gemappt.");
		SendClientMessage(playerid, 0x9CFF05FF, "Server-InHaber: [Adm]GSG9");
		SendClientMessage(playerid, 0x9CFF05FF, "Server-CoInHaber: [Adm]Leonart, [Adm]Arbian, [Adm]Louis.");
		return 1;
	}
	if (strcmp("/help", cmdtext, true, 10) == 0)
	{
		SendClientMessage(playerid, 0xFF0000FF, "========================GameMode-Info========================");
		SendClientMessage(playerid, 0x8E39FFFF, "Befehl: /buy = Waffen kaufen");
		SendClientMessage(playerid, 0x8E39FFFF, "Befehl: /help = Informationen");
		SendClientMessage(playerid, 0x8E39FFFF, "Befehl: /credits = Um Credits zu sehen");
		SendClientMessage(playerid, 0x8E39FFFF, "Credits: Script wurde von [Adm]GSG9 gescriptet");
		SendClientMessage(playerid, 0x8E39FFFF, "Datum: Script vom 08.03.11 hererstellt.");
		SendClientMessage(playerid, 0xFF0000FF, "=============================================================");
		return 1;
	}
	if (strcmp("/kill", cmdtext, true, 10) == 0)
	{
		SetPlayerHealth(playerid, 0);
		return 1;
	}

	return 0;

}

/*----------------------------------------------------------------------------*/

public SetupPlayerForClassSelection(playerid)
{
	    SetPlayerInterior(playerid,14);
	    SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
    	SetPlayerFacingAngle(playerid, 90.0);
    	SetPlayerCameraPos(playerid,256.0815,-43.0475,1003.0234);
    	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
}

//------------------------Fertig!----------------------------------------------