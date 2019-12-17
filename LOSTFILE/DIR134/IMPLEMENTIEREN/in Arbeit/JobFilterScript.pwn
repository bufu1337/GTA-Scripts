//***JOBFILTERSCRIPT BY NATE660/KANSAS(2007)***
//***Driving Script All Created By Allan/Dragsta***

#include <a_samp>
#include <Dini>
#include <dutils>

#define COLOR_YELLOW 0xFFFF00AA
#define RED 0xFF0000AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_RED 0xDC143C
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0xDC143C
#define COLOR_BLUE 0x0000FFAA
#define COLOR_RED1 0xFF0000AA
#define COLOR_VIOLET 0xEE82EEFF
#define COLOR_BLACK 0x00000000
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_GOLD 0xB8860BAA
#define COLOR_NAVY 0x000080AA
#define TEAM_SALE 0
#define TEAM_COP 1
#define TEAM_BISTRO 2
#define TEAM_TAXI 3
#define TEAM_DISCON 4
#define TEAM_PILOT 5
#define TEAM_DRIVER 6
#define TEAM_DRIVER2 7
#define TEAM_Civilian 8
#define TEAM_MEDIC 9
#define TEAM_ARMY 10
#define TEAM_FBI 11
#define TEAM_SP 12

#pragma unused TimerDST // make it shut up saying that TimerDST is unused.
#pragma unused ret_memcpy//Makes the stupid Ret Mem Warning shut the F*** up
#define TooFast 0
#define TooSlow 1000

forward Dschool_Yes(playerid);
forward Dschool_No(playerid);
forward Dschool_Dis(playerid);
forward QuitSchool(playerid);
forward Countdown();
forward CountUpTimeTaken();

new jailed[MAX_PLAYERS];
static gTeam[MAX_PLAYERS]; // Keeps track of the teams for the filterscript
new File:DSchool;

new Float:CPDSchoolData[24][4] =
{
{-2047.2,-83.0,34.8,3.0}, // DT1 and 24
{-2026.6925,-70.1228,34.8783,3.0}, // DT2
{-2004.7513,189.6104,27.2453,3.0}, // DT3
{-2005.5742,445.2907,34.7222,3.0}, // DT4
{-2004.9156,657.1252,41.4480,3.0}, // DT5
{-2003.5272,958.6751,45.0033,3.0}, // DT6
{-2002.3400,1074.9663,55.2773,3.0}, // DT7
{-2160.8247,1070.2000,55.2843,3.0},// DT8
{-2166.7864,1047.6621,55.3587,3.0},// DT9
{-2106.8022,1051.5979,55.2844,3.0}, // DT10
{-2015.2802,1051.7932,55.2764,3.0}, // DT11
{-2006.7701,1022.1216,54.4400,3.0}, // DT12
{-2009.5132,932.4048,45.0042,3.0},// DT13
{-2008.8276,749.4720,44.9973,3.0}, // DT14
{-2008.6039,657.2002,41.4607,3.0}, // DT15
{-2007.3783,557.6398,34.7220,3.0}, // DT16
{-2009.1946,291.6661,33.8823,3.0}, // DT17
{-2009.2443,148.1573,27.2452,3.0}, // DT18
{-2009.5765,78.9214,27.2453,3.0}, // DT19
{-2009.7845,34.7367,32.5174,3.0}, // DT20
{-2009.8560,-55.1156,34.8721,3.0}, // DT21
{-2033.1410,-68.0971,34.8788,3.0}, // DT22
{-2042.7212,-69.9372,35.0068,3.0}, // DT23
{-2047.2,-83.0,34.8,3.0}  // DT1 and 24
};

new TimerCD,TimerDSTime;
new TimerDST;
new PID;
new DriverTakingTest;
new DSCP[MAX_PLAYERS];

public OnFilterScriptInit()
{
        print("\n----------------------------------");
        print(" Job FilterScript Created By Nate660/Kansas");
        print(" DrivingScript By allan/Dragsta");
        print("----------------------------------\n");

        DriverTakingTest=-1;

        if(!fopen("DSchool",io_read))
        {
                print("\r\n\r\nError: No driving school data found. Creating new data file.");
                DSchool=fopen("DSchool",io_readwrite);
        }
        else
        {
                print("\r\n\r\nDriving School data found. Now loading data...");
                DSchool=fopen("DSchool",io_readwrite);
        }
        fclose(DSchool);
        return 1;
}



public OnPlayerConnect(playerid)
{
		SendClientMessage(playerid, COLOR_YELLOW, "This server uses Nate660's Job FilterScript VER:1.1!!");
    	jailed[playerid] = 0;
   		new PName[MAX_PLAYER_NAME];
        GetPlayerName(playerid,PName,sizeof(PName));
        DSchool=fopen("DSchool",io_readwrite);
        if(strcmp(dini_Get("DSchool",PName),"Y",false)==0)
        {
            if(strlen(dini_Get("DSchool",PName))==1) // seems streams with no data also run through this part.
            {
                fclose(DSchool);
                }
                else // If there is no data present,
                {
                    Dschool_No(playerid); // Make some!
                }
        }
        else if(strcmp(dini_Get("DSchool",PName),"N",false)==0)
        {
            fclose(DSchool);
        }
        else if(strcmp(dini_Get("DSchool",PName),"D",false)==0)
        {
            fclose(DSchool);
        }
        else
        {
                Dschool_No(playerid);
        }
        return 1;
}


public OnGameModeExit()
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    			new tmp[256];
				new name[256];
				new string[256];
				new sendername[MAX_PLAYER_NAME];
				new giveplayer[MAX_PLAYER_NAME];
				new cmd[256];
 				new idx;
    			new giveplayerid;
				cmd = strtok(cmdtext, idx);


				if(strcmp(cmd,"/l-suspend",true)==0)
        {
                new tracedID;
                new tracedIDName[MAX_PLAYER_NAME];
                new PName[MAX_PLAYER_NAME];

                tmp = strtok(cmdtext, idx);
                if(strlen(tmp)==0)
                {
                        SendClientMessage(playerid, 0xFF000000, "USAGE: /l-suspend (playerid)");
                        return 1;
                }
                tracedID = strval(tmp);

                if(tracedID!=INVALID_PLAYER_ID)
                {
                        if(IsPlayerConnected(tracedID))
                        {
                                GetPlayerName(tracedID, tracedIDName, sizeof(tracedIDName));
                                GetPlayerName(playerid, PName, sizeof(PName));
                                DSchool=fopen("DSchool",io_readwrite);
                                if(strcmp(dini_Get("DSchool",tracedIDName),"Y",true)==0)
                                {
                                        format(string, sizeof(string), "%s (ID:%d) has had their licence suspended.",tracedIDName,tracedID);
                                        printf("%s (ID:%d) has been licence suspended.",tracedIDName,tracedID);
                                        SendClientMessage(playerid,0xFF000000,string);
                                        format(string, sizeof(string), "%s (ID:%d) has had their licence suspended by %s (ID:%d).",tracedIDName,tracedID,PName,playerid);
                                        SendClientMessageToAll(0xFF800000,string);
                                        Dschool_Dis(tracedID);
                                        fclose(DSchool);
                                        return 1;
                                }
                                else if(strcmp(dini_Get("DSchool",tracedIDName),"N",true)==0)
                                {
                                        format(string, sizeof(string), "%s (ID:%d) have a licence to suspend!",tracedIDName,tracedID);
                                        SendClientMessage(playerid,0xFF000000,string);
                                        printf("%s (ID:%d) is being licence suspended, but doesn't have a licence.",tracedIDName,tracedID);
                                        fclose(DSchool);
                                        return 1;
                                }
                                else if(strcmp(dini_Get("DSchool",tracedIDName),"D",true)==0)
                                {
                                        format(string, sizeof(string), "%s (ID:%d) is already disqualified from driving.",tracedIDName,tracedID);
                                        SendClientMessage(playerid,0xFF000000,string);
                                        printf("%s (ID:%d) is being licence suspended, but the licence is already suspended.",tracedIDName,tracedID);
                                        fclose(DSchool);
                                        return 1;
                                }
                                else
                                {
                                        SendClientMessage(playerid,0xFF000000,"Error: Unable to establish licence status.");
                                        fclose(DSchool);
                                        return 1;
                                }
                        }
                        else
                        {
                                SendClientMessage(playerid,0xFF000000,"That player is not in the server.");
                        }
                }
                else
                {
                    SendClientMessage(playerid,0xFF000000,"You have specified an invalid Player ID.");
                }
                return 1;
        }

        //=======================================
        // Renew a Licence.
        //=======================================

        		if(strcmp(cmd,"/l-renew",true)==0)
        {
                new tracedID;
                new tracedIDName[MAX_PLAYER_NAME];
                new PName[MAX_PLAYER_NAME];

                tmp = strtok(cmdtext, idx);
                if(strlen(tmp)==0)
                {
                        SendClientMessage(playerid, 0xFF000000, "USAGE: /l-renew (playerid)");
                        return 1;
                }
                tracedID = strval(tmp);

                if(tracedID!=INVALID_PLAYER_ID)
                {
                        if(IsPlayerConnected(tracedID))
                        {
                                GetPlayerName(tracedID, tracedIDName, sizeof(tracedIDName));
                                GetPlayerName(playerid, PName, sizeof(PName));
                                DSchool=fopen("DSchool",io_readwrite);
                                if(strcmp(dini_Get("DSchool",tracedIDName),"D",true)==0)
                                {
                                        format(string, sizeof(string), "%s (ID:%d) has had their licence renewed.",tracedIDName,tracedID);
                                        SendClientMessage(playerid,0xFF000000,string);
                                        printf("%s (ID:%d) is being licence suspended, but the licence is already suspended.",tracedIDName,tracedID);
                                        format(string, sizeof(string), "%s (ID:%d) has had their licence suspended by %s (ID:%d).",tracedIDName,tracedID,PName,playerid);
                                        SendClientMessageToAll(0xFF800000,string);
                                        Dschool_Yes(tracedID);
                                        fclose(DSchool);
                                        return 1;
                                }
                                else
                                {
                                        SendClientMessage(playerid,0xFF000000,"Error: Unable to establish licence status.");
                                        fclose(DSchool);
                                        return 1;
                                }
                        }
                        else
                        {
                                SendClientMessage(playerid,0xFF000000,"That player is not in the server.");
                        }
                }
                else
                {
                    SendClientMessage(playerid,0xFF000000,"You have specified an invalid Player ID.");
                }
                return 1;
        }

        //=======================================
        // Go to Driving School.
        //=======================================

        		if (strcmp(cmdtext, "/dschool", true)==0)
        {
                new tracedIDName[MAX_PLAYER_NAME];
                new strn[255];
                if(DriverTakingTest==-1)
                {
                        if(GetPlayerMoney(playerid)>=500)
                        {
                                GetPlayerName(playerid,tracedIDName,sizeof(tracedIDName));
                                if(strcmp(dini_Get("DSchool",tracedIDName),"Y",true)==0)
                                {
                                        SendClientMessage(playerid, 0xFF000000, "Error: You already have a valid licence!");
                                        return 1;
                                }
                                DriverTakingTest=playerid;
                                GivePlayerMoney(playerid,-500);
                                SetPlayerCheckpoint(playerid,CPDSchoolData[0][0],CPDSchoolData[0][1],CPDSchoolData[0][2],CPDSchoolData[0][3]);
                                DSCP[playerid]=0;
                                SetPlayerPos(playerid,-2077.3,-81.4,34.8);
                                SendClientMessage(playerid, 0xFF000000, "You are now on the Driving School program. Drive safe, yet speedy.");
                                return 1;
                        }
                        else
                        {
                                SendClientMessage(playerid, 0xFF000000, "Error: Insufficient funds to take the test.");
                                return 1;
                        }
                }
        				else
        {
                        GetPlayerName(DriverTakingTest,tracedIDName,sizeof(tracedIDName));
                        format(strn, sizeof(strn), "%s(ID:%d) is currently taking the Driving School Test. Try again later.",tracedIDName,DriverTakingTest);
                        SendClientMessage(playerid, 0xFF000000, strn);
                        return 1;
        }
        }

        //=======================================
        // Licence Checker.
        //=======================================

        		if(strcmp(cmd,"/licence",true)==0)
        {
                new tracedID;
                new tracedIDName[MAX_PLAYER_NAME];

                tmp = strtok(cmdtext, idx);
                if(strlen(tmp)==0)
                {
                        SendClientMessage(playerid, 0xFF000000, "USAGE: /licence (playerid)");
                        return 1;
                }
                tracedID = strval(tmp);

                if(tracedID!=INVALID_PLAYER_ID)
                {
                        if(IsPlayerConnected(tracedID))
                        {
                                GetPlayerName(tracedID, tracedIDName, sizeof(tracedIDName));
                                DSchool=fopen("DSchool",io_readwrite);
                                if(strcmp(dini_Get("DSchool",tracedIDName),"Y",true)==0)
                                {
                                        format(string, sizeof(string), "%s (ID:%d) has a valid drivers licence.",tracedIDName,tracedID);
                                        printf("%s (ID:%d) has been licence checked. Status: Clean licence.",tracedIDName,tracedID);
                                        SendClientMessage(playerid,0xFF000000,string);
                                        fclose(DSchool);
                                        return 1;
                                }
                                else if(strcmp(dini_Get("DSchool",tracedIDName),"N",true)==0)
                                {
                                        format(string, sizeof(string), "%s (ID:%d) doesn't carry a drivers licence.",tracedIDName,tracedID);
                                        SendClientMessage(playerid,0xFF000000,string);
                                        SendClientMessage(playerid,0xFF000000,"COA: Jail them, or send them to driving school.");
                                        printf("%s (ID:%d) has been licence checked. Status: No licence.",tracedIDName,tracedID);
                                        fclose(DSchool);
                                        return 1;
                                }
                                else if(strcmp(dini_Get("DSchool",tracedIDName),"D",true)==0)
                                {
                                        format(string, sizeof(string), "%s (ID:%d) has been disqualified from driving.",tracedIDName,tracedID);
                                        SendClientMessage(playerid,0xFF000000,string);
                                        SendClientMessage(playerid,0xFF000000,"COA: Jail them, at reasonable cost.");
                                        printf("%s (ID:%d) has been licence checked. Status: Disqualified licence.",tracedIDName,tracedID);
                                        fclose(DSchool);
                                        return 1;
                                }
                                else
                                {
                                        SendClientMessage(playerid,0xFF000000,"Error: Unable to establish licence status.");
                                        fclose(DSchool);
                                        return 1;
                                }
                        }
                        else
                        {
                                SendClientMessage(playerid,0xFF000000,"That player is not in the server.");
                        }
                }
                else
                {
                    SendClientMessage(playerid,0xFF000000,"You have specified an invalid Player ID.");
                }
                return 1;
        }


//=======Start OF The JOBS=======

	
				if(strcmp(cmd, "/Civilian", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW, "Current Logins Wiped You are now civilian!!");
        gTeam[playerid] = TEAM_Civilian;
		SetPlayerColor(playerid, COLOR_WHITE);
		GivePlayerWeapon(playerid, 24, 400);
        GivePlayerWeapon(playerid, 3, 1);
		return 1;
	}
	

//First the Police Cmds And Pass:
				if(strcmp(cmd, "/cop", true) == 0) {
		SendClientMessage(playerid, COLOR_RED1, "You are now an offcial police member type /pcommands for a list of commands");
        SendClientMessage(playerid, COLOR_RED1, "Your Cmd's Are: /pu /jail /unjail, /polheli, /cophq, /copcmds and /cc (cop chat)");
        gTeam[playerid] = TEAM_COP;
		SetPlayerColor(playerid, COLOR_BLUE);
		SetPlayerPos(playerid, 2295.0293,2459.4961,10.8203);
		GivePlayerWeapon(playerid, 24, 400);
        GivePlayerWeapon(playerid, 3, 1);
		SetPlayerSkin(playerid, 280);
		return 1;
	}

				if(strcmp(cmd, "/pcommands", true) == 0) {
if (gTeam[playerid] == TEAM_COP) {
SendClientMessage(playerid, COLOR_RED1, "Your Cmd's Are: /pu /jail /unjail, /polheli, /cophq, /copcmds and /cc (cop chat)");
}else{
SendClientMessage(playerid, COLOR_RED, "You are not official police!!");
}
return 1;
}
	           

				if(strcmp(cmd,"/cc",true)==0) {//COP TEAMSPEAK
	if (gTeam[playerid] == TEAM_COP) {
	if ((strlen(cmdtext) >= 1)&&(strlen(cmdtext) <= 3)) { SendClientMessage(playerid,COLOR_RED1, "Syntax: /cc <MESSAGE>"); return 1; }
	GetPlayerName(playerid,name,sizeof(name));	format(string,sizeof(string),"Cop Chat(%s):%s",name,cmdtext[3]); SendCopMessage(COLOR_YELLOW, string);
	} else SendClientMessage(playerid, COLOR_YELLOW, "You are not official Police!");
	return 1;
}


				if(strcmp(cmd, "/polheli", true) == 0) { // goes to the LVPD roof wich is a good place for helis
    if(gTeam[playerid] == TEAM_COP)
	{
	SetPlayerPos(playerid, 2282.6584,2449.6414,46.9775);
	}
	else
	{
	SendClientMessage(playerid, COLOR_RED1, "You Are NOT official Police!!");
	}
	return 1;
	}
                if(strcmp(cmd, "/disarm", true) == 0) {//UPDATED JAIL CMD ONlY JAILS IF THE SPECIFIED PERSON ISNT JAILED!

                tmp = strtok(cmdtext, idx);
                if(!strlen(tmp)) {
                        SendClientMessage(playerid, COLOR_GREEN, "Usage: /disarm [Player ID]");
                        return 1;
                }
				giveplayerid = strval(tmp);

				if(jailed[giveplayerid]==0) {
        if (gTeam[playerid] == TEAM_COP) {
            if (IsPlayerConnected(giveplayerid)) {

					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "You have been Disarmed by %s!", sendername, playerid);
     				SendClientMessage(giveplayerid, COLOR_RED1, string);
                    format(string, sizeof(string), "%s has been disarmed by %s!", giveplayer, giveplayerid, sendername, playerid);
                    SendClientMessageToAll(COLOR_RED1, string);
                    printf(string);
                    ResetPlayerWeapons(playerid);
               		return 1;
                                        }else{
        format(string, sizeof(string), "id %d is not an active player.", giveplayerid);
		SendClientMessage(playerid, COLOR_YELLOW, string);
}
                }else{
        format(string, sizeof(string), "You are not a cop", giveplayerid);
        SendClientMessage(playerid, COLOR_YELLOW, string);
}
				}else{
format(string, sizeof(string), "That person was already disarmed", giveplayerid);
SendClientMessage(playerid, COLOR_YELLOW, string);

}

				return 1;
}
			 	
				if(strcmp(cmd, "/crimlock", true) == 0) {//UPDATED JAIL CMD ONlY JAILS IF THE SPECIFIED PERSON ISNT JAILED!

                tmp = strtok(cmdtext, idx);
                if(!strlen(tmp)) {
                        SendClientMessage(playerid, COLOR_GREEN, "Usage: /crimlock [Player ID]");
                        return 1;
                }
				giveplayerid = strval(tmp);

				if(jailed[giveplayerid]==0) {
        if (gTeam[playerid] == TEAM_COP) {
            if (IsPlayerInAnyVehicle(giveplayerid)) {

					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "You have been locked in the car by %s!", sendername, playerid);
     				SendClientMessage(giveplayerid, COLOR_RED1, string);
                    format(string, sizeof(string), "%s has been locked in the car by %s!", giveplayer, giveplayerid, sendername, playerid);
                    SendClientMessageToAll(COLOR_RED1, string);
                    printf(string);
                    TogglePlayerControllable(giveplayerid,0);   //So the player that is jailed can't use /kill
                 	return 1;
                                        }else{
        format(string, sizeof(string), "id %d is not an active player.", giveplayerid);
		SendClientMessage(playerid, COLOR_YELLOW, string);
}
				}else{
        format(string, sizeof(string), "You are not a cop why are you trying to lock someone in your car", giveplayerid);
        SendClientMessage(playerid, COLOR_YELLOW, string);
}
				}else{
format(string, sizeof(string), "You have already locked him in the car", giveplayerid);
SendClientMessage(playerid, COLOR_YELLOW, string);

}

				return 1;
}
	
	            if(strcmp(cmd, "/crimunlock", true) == 0) {//UPDATED JAIL CMD ONlY JAILS IF THE SPECIFIED PERSON ISNT JAILED!

                tmp = strtok(cmdtext, idx);
                if(!strlen(tmp)) {
                        SendClientMessage(playerid, COLOR_GREEN, "Usage: /crimunlock [Player ID]");
                        return 1;
                }
				giveplayerid = strval(tmp);

				if(jailed[giveplayerid]==0) {
        if (gTeam[playerid] == TEAM_COP) {
            if (IsPlayerInAnyVehicle(giveplayerid)) {

					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "You have been unlocked by %s!", sendername, playerid);
     				SendClientMessage(giveplayerid, COLOR_RED1, string);
                    format(string, sizeof(string), "%s has been unlocked and let out the car by %s!", giveplayer, giveplayerid, sendername, playerid);
                    SendClientMessageToAll(COLOR_GREEN, string);
                    printf(string);
                    TogglePlayerControllable(giveplayerid,1);   //So the player that is jailed can't use /kill
                 	return 1;
                                        }else{
        format(string, sizeof(string), "id %d is not an active player.", giveplayerid);
		SendClientMessage(playerid, COLOR_YELLOW, string);
}

				}else{
        format(string, sizeof(string), "You are not a cop why are you trying to unlock this player", giveplayerid);
        SendClientMessage(playerid, COLOR_YELLOW, string);
}
				}else{
format(string, sizeof(string), "This person isn't even locked in a car", giveplayerid);
SendClientMessage(playerid, COLOR_YELLOW, string);

}

				return 1;
}




				if(strcmp(cmd, "/cophq", true) == 0) { // teles the cop back to the LVPD spawn!
    if(gTeam[playerid] == TEAM_COP)
	{
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid, 2295.0293,2459.4961,10.8203);
	}
	else
	{
	SendClientMessage(playerid, COLOR_RED1, "What are you trying to pull you Not a cop!!");
	}
	return 1;
	}



				if(strcmp(cmd, "/jail", true) == 0) {//UPDATED JAIL CMD ONlY JAILS IF THE SPECIFIED PERSON ISNT JAILED!

                tmp = strtok(cmdtext, idx);
                if(!strlen(tmp)) {
                        SendClientMessage(playerid, COLOR_GREEN, "Usage: /jail [Player ID]");
                        return 1;
                }
				giveplayerid = strval(tmp);

				if(jailed[giveplayerid]==0) {
        if (gTeam[playerid] == TEAM_COP) {
            if (IsPlayerConnected(giveplayerid)) {

					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "You have been jailed by %s!", sendername, playerid);
     				SendClientMessage(giveplayerid, COLOR_RED1, string);
                    format(string, sizeof(string), "%s has been jailed by %s!", giveplayer, giveplayerid, sendername, playerid);
                    SendClientMessageToAll(COLOR_RED1, string);
                    printf(string);
                    SetPlayerInterior(giveplayerid,3);
					jailed[giveplayerid] = 1;
	    			SetPlayerPos(giveplayerid,198.3797,160.8905,1003.0300);
        			SetPlayerFacingAngle(giveplayerid,177.0350);
           			SetCameraBehindPlayer(giveplayerid);
             		PlayerPlaySound(giveplayerid,1082,198.3797,160.8905,1003.0300);
               		TogglePlayerControllable(giveplayerid,0);   //So the player that is jailed can't use /kill
                 	DisablePlayerCheckpoint(giveplayerid);
               		return 1;
                                        }else{
        format(string, sizeof(string), "id %d is not an active player.", giveplayerid);
		SendClientMessage(playerid, COLOR_YELLOW, string);
}
                }else{
        format(string, sizeof(string), "You are not a cop why are you trying to jail", giveplayerid);
        SendClientMessage(playerid, COLOR_YELLOW, string);
}
				}else{
format(string, sizeof(string), "Someone already jailed that player", giveplayerid);
SendClientMessage(playerid, COLOR_YELLOW, string);

}

				return 1;
}
				if(strcmp(cmd, "/unjail", true) == 0) {//UPDATED UNJAIL CMD ONly UNJAILS IF THE SPECIFIED PERSON IS JAILED!

                tmp = strtok(cmdtext, idx);
                if(!strlen(tmp)) {
                        SendClientMessage(playerid, COLOR_GREEN, "Usage: /unjail [Player ID]");
                        return 1;
                }
        		giveplayerid = strval(tmp);
				if(jailed[giveplayerid]==1) {
        if (gTeam[playerid] == TEAM_COP) {
            if (IsPlayerConnected(giveplayerid)) {
                      			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
                      			GetPlayerName(playerid, sendername, sizeof(sendername));
                                format(string, sizeof(string), "You have been unjailed by %s (ID:%d)!", sendername, playerid);
                                SendClientMessage(giveplayerid, COLOR_GREEN, string);
                                format(string, sizeof(string), "%s (ID:%d) has been unjailed by %s (ID:%d)", giveplayer, giveplayerid, sendername, playerid);
                                SendClientMessageToAll(COLOR_GREEN, string);
                                printf(string);
                                jailed[giveplayerid] = 0;
								SetPlayerInterior(giveplayerid,0);
                                SetPlayerFacingAngle(giveplayerid,90.00);
                                SetPlayerPos(giveplayerid,2296.4031,2468.7754,10.8203);
                                SetPlayerFacingAngle(giveplayerid,177.0350);
                                SetCameraBehindPlayer(giveplayerid);
                                TogglePlayerControllable(giveplayerid,1);
                                return 1;
                                        }else{
        format(string, sizeof(string), "id %d Is not even online Dumbass!!", giveplayerid);
		SendClientMessage(playerid, COLOR_YELLOW, string);
}
                }else{
        format(string, sizeof(string), "You Can't unjail when your not a cop", giveplayerid);
        SendClientMessage(playerid, COLOR_WHITE, string);
}
				}else{
format(string, sizeof(string), "This person Is already unjailed", giveplayerid);
SendClientMessage(playerid, COLOR_WHITE, string);
}

				return 1;
}

				

				if(strcmp(cmd, "/pu", true) == 0) { //Displays the text: "This is the LVPD, Pullover Immedietly" to all players
	if(gTeam[playerid] == TEAM_COP)
	{
	SendClientMessageToAll(COLOR_BLUE, "This Is The SAPD, Pull Over Now or You will Be Jailed!!");
	}
	else
	{
	SendClientMessage(playerid, COLOR_RED1, "You Are NOT official Police!!");
	}


	return 1;
	}

				if(strcmp(cmd, "/fbi", true) == 0) {
		SendClientMessage(playerid, COLOR_YELLOW, "You Are An Offcial FBI Member Enjoy!!");
        SendClientMessage(playerid, COLOR_YELLOW, "Your Cmd's Are: /fbihq /fbijail /fbiunjail, /fbipu /fbiheli /fb (fbiChat");
        gTeam[playerid] = TEAM_FBI;
        GameTextForAll("Player Logged Into FBI!!",6000,4);
		SetPlayerColor(playerid, COLOR_BLACK);
		SetPlayerPos(playerid, 1009.815, 1043.899, 15);
		GivePlayerWeapon(playerid, 24, 400);
        GivePlayerWeapon(playerid, 3, 1);
		SetPlayerSkin(playerid, 286);
		return 1;
	}
	
				if(strcmp(cmd,"/fb",true)==0) {//FBI TEAMSPEAK
	if (gTeam[playerid] == TEAM_FBI) {
	if ((strlen(cmdtext) >= 1)&&(strlen(cmdtext) <= 3)) { SendClientMessage(playerid,COLOR_RED1, "Syntax: /fb <MESSAGE>"); return 1; }
	GetPlayerName(playerid,name,sizeof(name));	format(string,sizeof(string),"FBI Chat(%s):%s",name,cmdtext[3]); SendFBIMessage(COLOR_YELLOW, string);
	} else SendClientMessage(playerid, COLOR_YELLOW, "You are not an official FBI Member!");
	return 1;
}
 				if(strcmp(cmd, "/fbipu", true) == 0) { //Displays the text: "This is the LVPD, Pullover Immedietly" to all players
	if(gTeam[playerid] == TEAM_FBI)
	{
	SendClientMessageToAll(COLOR_BLACK, "This Is The FBI, Pullover Or You Will be Jailed!!");
	}
	else
	{
	SendClientMessage(playerid, COLOR_RED1, "You Are Now an fbi member!!");
	}


	return 1;
	}
	
				if(!strcmp(cmdtext,"/fbihq",true)) {
    SetPlayerPos(playerid, 1009.815, 1043.899, 15);
    return 1;
}

				if(strcmp(cmd, "/fbijail", true) == 0) {//UPDATED JAIL CMD ONlY JAILS IF THE SPECIFIED PERSON ISNT JAILED!

                tmp = strtok(cmdtext, idx);
                if(!strlen(tmp)) {
                        SendClientMessage(playerid, COLOR_GREEN, "Usage: /fbijail [Player ID]");
                        return 1;
                }
				giveplayerid = strval(tmp);

				if(jailed[giveplayerid]==0) {
        		if (gTeam[playerid] == TEAM_FBI) {
            if (IsPlayerConnected(giveplayerid)) {

					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
   					GetPlayerName(playerid, sendername, sizeof(sendername));
        			format(string, sizeof(string), "You have been jailed by An FBI Member %s!", sendername, playerid);
           			SendClientMessage(giveplayerid, COLOR_RED1, string);
              		format(string, sizeof(string), "%s has been jailed by an FBI Member %s!", giveplayer, giveplayerid, sendername, playerid);
                    SendClientMessageToAll(COLOR_RED1, string);
                    printf(string);
                    SetPlayerInterior(giveplayerid,3);
					jailed[giveplayerid] = 1;
	    			SetPlayerPos(giveplayerid,198.3797,160.8905,1003.0300);
        			SetPlayerFacingAngle(giveplayerid,177.0350);
                    SetCameraBehindPlayer(giveplayerid);
                    PlayerPlaySound(giveplayerid,1082,198.3797,160.8905,1003.0300);
                    TogglePlayerControllable(giveplayerid,0);   // so that can't /kill
                    DisablePlayerCheckpoint(giveplayerid);
					return 1;
                                        }else{
        format(string, sizeof(string), "id %d Is not even in the game!", giveplayerid);
       	SendClientMessage(playerid, COLOR_YELLOW, string);
}
                }else{
        format(string, sizeof(string), "You Can't do that your not fbi", giveplayerid);
        SendClientMessage(playerid, COLOR_YELLOW, string);
}
				}else{
format(string, sizeof(string), "This person is not even jailed", giveplayerid);
SendClientMessage(playerid, COLOR_YELLOW, string);

}

				return 1;
}

				if(strcmp(cmd, "/fbiunjail", true) == 0) {//UPDATED UNJAIL CMD ONly UNJAILS IF THE SPECIFIED PERSON IS JAILED!

                tmp = strtok(cmdtext, idx);
                if(!strlen(tmp)) {
                        SendClientMessage(playerid, COLOR_GREEN, "Usage: /fbiunjail [Player ID]");
                        return 1;
                }
        		giveplayerid = strval(tmp);
				if(jailed[giveplayerid]==1) {
        if (gTeam[playerid] == TEAM_FBI) {
            if (IsPlayerConnected(giveplayerid)) {
                      GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
                      GetPlayerName(playerid, sendername, sizeof(sendername));
                      format(string, sizeof(string), "You have been unjailed by %s (ID:%d)!", sendername, playerid);
                      SendClientMessage(giveplayerid, COLOR_GREEN, string);
                      format(string, sizeof(string), "%s (ID:%d) has been unjailed by Fbi Member %s (ID:%d)", giveplayer, giveplayerid, sendername, playerid);
                      SendClientMessageToAll(COLOR_GREEN, string);
                      printf(string);
                      jailed[giveplayerid] = 0;
				      SetPlayerInterior(giveplayerid,0);
   					  SetPlayerFacingAngle(giveplayerid,90.00);
      				  SetPlayerPos(giveplayerid,2296.4031,2468.7754,10.8203);
                      SetPlayerFacingAngle(giveplayerid,177.0350);
                      SetCameraBehindPlayer(giveplayerid);
                      TogglePlayerControllable(giveplayerid,1);
				      return 1;
                                        }else{
        format(string, sizeof(string), "id %d is not an active player.", giveplayerid);
		SendClientMessage(playerid, COLOR_YELLOW, string);
}
                }else{
        format(string, sizeof(string), "You Are not an official FBI Member!!", giveplayerid);
        SendClientMessage(playerid, COLOR_WHITE, string);
}
				}else{
format(string, sizeof(string), "This person is Not jailed!", giveplayerid);
SendClientMessage(playerid, COLOR_WHITE, string);
}

				return 1;
}

				if(strcmp(cmd, "/statepolice", true) == 0) {
		SendClientMessage(playerid, COLOR_GREY, "You Are Now an offcial State PoliceMen!!");
       	gTeam[playerid] = TEAM_SP;
		SetPlayerColor(playerid, COLOR_GREY);
		SetPlayerPos(playerid, 2517.6294,2454.5466,11.0313);
		GivePlayerWeapon(playerid, 24, 400);
        GivePlayerWeapon(playerid, 3, 1);
		SetPlayerSkin(playerid, 280);
		return 1;
	}

				if(strcmp(cmd, "/spcmds", true) == 0) {
if (gTeam[playerid] == TEAM_SP) {
SendClientMessage(playerid, COLOR_RED1, "Your Cmd's Are: /sppu /spjail /spunjail, /polheli, /sphq, /spcmds and /sp (State Police chat)");
}else{
SendClientMessage(playerid, COLOR_RED, "You Are not even a State Police officer!!");
}
return 1;
}


				if(strcmp(cmd,"/sp",true)==0) {// State Police TEAMSPEAK
	if (gTeam[playerid] == TEAM_SP) {
	if ((strlen(cmdtext) >= 1)&&(strlen(cmdtext) <= 3)) { SendClientMessage(playerid,COLOR_RED1, "Syntax: /sp <MESSAGE>"); return 1; }
	GetPlayerName(playerid,name,sizeof(name));	format(string,sizeof(string),"StatePolice Chat(%s):%s",name,cmdtext[3]); SendStatePoliceMessage(COLOR_YELLOW, string);
	} else SendClientMessage(playerid, COLOR_YELLOW, "You Are not even a State Police officer!!");
	return 1;
}

				if(strcmp(cmd, "/sphq", true) == 0) { // teles the cop back to the StatePolice spawn!
    if(gTeam[playerid] == TEAM_SP)
	{
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid, 2517.6294,2454.5466,11.0313);
	}
	else
	{
	SendClientMessage(playerid, COLOR_RED1, "You Are now even a State Policemen");
	}
	return 1;
	}



				if(strcmp(cmd, "/spjail", true) == 0) {//UPDATED JAIL CMD ONlY JAILS IF THE SPECIFIED PERSON ISNT JAILED!

                tmp = strtok(cmdtext, idx);
                if(!strlen(tmp)) {
                        SendClientMessage(playerid, COLOR_GREEN, "Usage: /jail [Player ID]");
                        return 1;
                }
        		giveplayerid = strval(tmp);

				if(jailed[giveplayerid]==0) {
        	if (gTeam[playerid] == TEAM_SP) {
            if (IsPlayerConnected(giveplayerid)) {

					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
     				GetPlayerName(playerid, sendername, sizeof(sendername));
         			format(string, sizeof(string), "You have been jailed by StatePolice officer %s!", sendername, playerid);
         			SendClientMessage(giveplayerid, COLOR_RED1, string);
         			format(string, sizeof(string), "%s has been jailed by StatePolice officer %s!", giveplayer, giveplayerid, sendername, playerid);
         			SendClientMessageToAll(COLOR_RED1, string);
         			printf(string);
         			SetPlayerInterior(giveplayerid,3);
					jailed[giveplayerid] = 1;
			    	SetPlayerPos(giveplayerid,198.3797,160.8905,1003.0300);
           			SetPlayerFacingAngle(giveplayerid,177.0350);
           			SetCameraBehindPlayer(giveplayerid);
           			PlayerPlaySound(giveplayerid,1082,198.3797,160.8905,1003.0300);
           			TogglePlayerControllable(giveplayerid,0);   // so that can't /kill
           			DisablePlayerCheckpoint(giveplayerid);
					return 1;
                                        }else{
        format(string, sizeof(string), "id %d is not an active player.", giveplayerid);
        SendClientMessage(playerid, COLOR_YELLOW, string);
}
                }else{
        format(string, sizeof(string), "You Are Not official Police!!", giveplayerid);
        SendClientMessage(playerid, COLOR_YELLOW, string);
}
				}else{
format(string, sizeof(string), "This person is already jailed!", giveplayerid);
SendClientMessage(playerid, COLOR_YELLOW, string);

}

				return 1;
}
				if(strcmp(cmd, "/spunjail", true) == 0) {//UPDATED UNJAIL CMD ONly UNJAILS IF THE SPECIFIED PERSON IS JAILED!

                tmp = strtok(cmdtext, idx);
                if(!strlen(tmp)) {
                        SendClientMessage(playerid, COLOR_GREEN, "Usage: /unjail [Player ID]");
                        return 1;
                }
        		giveplayerid = strval(tmp);
				if(jailed[giveplayerid]==1) {
        if (gTeam[playerid] == TEAM_SP) {
            if (IsPlayerConnected(giveplayerid)) {
                      GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
                      GetPlayerName(playerid, sendername, sizeof(sendername));
                      format(string, sizeof(string), "You have been unjailed by %s (ID:%d)!", sendername, playerid);
                      SendClientMessage(giveplayerid, COLOR_GREEN, string);
                      format(string, sizeof(string), "%s (ID:%d) has been unjailed by %s (ID:%d)", giveplayer, giveplayerid, sendername, playerid);
                      SendClientMessageToAll(COLOR_GREEN, string);
                      printf(string);
                      jailed[giveplayerid] = 0;
	       			  SetPlayerInterior(giveplayerid,0);
         			  SetPlayerFacingAngle(giveplayerid,90.00);
           			  SetPlayerPos(giveplayerid,2296.4031,2468.7754,10.8203);
                	  SetPlayerFacingAngle(giveplayerid,177.0350);
                      SetCameraBehindPlayer(giveplayerid);
                      TogglePlayerControllable(giveplayerid,1);
					  return 1;
                                        }else{
        format(string, sizeof(string), "id %d is not an active player.", giveplayerid);
        SendClientMessage(playerid, COLOR_YELLOW, string);
}
                }else{
        format(string, sizeof(string), "You Are not even a State Police Officer", giveplayerid);
        SendClientMessage(playerid, COLOR_WHITE, string);
}
				}else{
format(string, sizeof(string), "This person is Not jailed!", giveplayerid);
SendClientMessage(playerid, COLOR_WHITE, string);
}

				return 1;
}

			

				if(strcmp(cmd, "/sppu", true) == 0) { //Displays the text: "This is the LVPD, Pullover Immedietly" to all players
	if(gTeam[playerid] == TEAM_SP)
	{
	SendClientMessageToAll(COLOR_GREY, "This Is The StatePolice PullOver Or Be Prosicuted!!");
	}
	else
	{
	SendClientMessage(playerid, COLOR_RED1, "You Are NOT even a StatePolice Officer!!");
	}


	return 1;
	}

				if(strcmp(cmd, "/carsale", true) == 0) { //makes the players name yellow tells people the buisness is open and teles you to the HQ
    SendClientMessage(playerid, COLOR_RED, "You are Now A Car Sales Men");
    SetPlayerColor(playerid, COLOR_LIGHTBLUE);
    SendClientMessage(playerid, COLOR_YELLOW, "Your Cmd's Are: /salehq, /sold /s1");
    GameTextForAll("A Player Has Logged Into A CarSalesMen!!",6000,4);
	SetPlayerPos(playerid, 2131.7268,-1148.0879,24);
    SetPlayerSkin(playerid, 228);
	gTeam[playerid] = TEAM_SALE;
	return 1;
	}
				if(strcmp(cmd, "/s1", true) == 0) { //cop skin
if (gTeam[playerid] == TEAM_SALE) {
SetPlayerSkin(playerid, 228);
}else{
SendClientMessage(playerid, COLOR_RED, "You are not an official Car Sales Men!!");
}

return 1;
}

				if(strcmp(cmd, "/sold", true) ==0) {//Sold a car
	GameTextForAll("A Car Has Just Been Bought!!",6000,4);
	gTeam[playerid] = TEAM_SALE;
	return 1;
	}




				if(!strcmp(cmdtext,"/LVtaxihq",true)) {
    SetPlayerPos(playerid, 1603.352, 2324.229, 15);
    return 1;
}
				if(!strcmp(cmdtext,"/salehq",true)) {
    SetPlayerPos(playerid, 2131.7268,-1148.0879,24);
    return 1;
}

				if(!strcmp(cmdtext,"/ODHQ",true)) {
    SetPlayerPos(playerid, 2269.447, -2341.135, 15);
    return 1;
}

//Now for the Taxi/limo Service

				if(strcmp(cmd, "/taxi", true) == 0) { //makes the players name yellow tells people the buisness is open and teles you to the HQ
    SendClientMessage(playerid, COLOR_RED, "You are logged into The Taxi/Bus service!!");
    SetPlayerColor(playerid, COLOR_YELLOW);
    SendClientMessage(playerid, COLOR_RED, "Your Cmd's Are: /Lvtaxihq, /ODHQ /pick-up, /location and /tc (Team Speak)");
    GameTextForAll("The Taxi And Bus Service is open!!",6000,4);
	SetPlayerSkin(playerid, 255);
    gTeam[playerid] = TEAM_TAXI;
	return 1;
	}

				if(strcmp(cmd,"/tc",true)==0) {//TAXI TEAMSPEAK
	if (gTeam[playerid] == TEAM_TAXI) {
	if ((strlen(cmdtext) >= 1)&&(strlen(cmdtext) <= 3)) { SendClientMessage(playerid,COLOR_RED1, "Syntax: /tc <MESSAGE>"); return 1; }
	GetPlayerName(playerid,name,sizeof(name));	format(string,sizeof(string),"Taxi Chat(%s):%s",name,cmdtext[3]); SendTaxiMessage(COLOR_YELLOW, string);
	} else SendClientMessage(playerid, COLOR_YELLOW, "You are not an official Taxi Driver!");
	return 1;
}

    			if(strcmp(cmd, "/pick-up", true) == 0) {// Displays the text: "Type /taxi or /limo to be Transported In style!"
    if (gTeam[playerid] == TEAM_TAXI) {
	SendClientMessageToAll(COLOR_YELLOW, "Type /taxi or /Bus to be Transported In style!");
	}else{
	SendClientMessage(playerid, COLOR_RED, "You are Not an official Taxi Driver!!");
 	}
	return 1;
	}



				if(strcmp(cmd, "/location", true) == 0) {// Displays the text: "What Is your current location?"
    if (gTeam[playerid] == TEAM_TAXI) {
	SendClientMessageToAll(COLOR_YELLOW, "What Is your current location?");
	}else{
	SendClientMessage(playerid, COLOR_RED, "You are Not an official Taxi Driver!!");
 	}

	return 1;
	}

				if(strcmp(cmd, "/taxi", true) == 0) { // says: "[PLAYERID] Needs a taxi"
 	GetPlayerName(playerid,name,sizeof(name));
	format(string,sizeof(string),"%s Needs a taxi!!",name);
	SendClientMessageToAll(COLOR_YELLOW, string);

	return 1;
}

				if(strcmp(cmd, "/Bus", true) == 0) { // says: "[PLAYERID] Needs a Bus"
	GetPlayerName(playerid,name,sizeof(name));
	format(string,sizeof(string),"%s Needs a Bus!!",name);
	SendClientMessageToAll(COLOR_YELLOW, string);


	return 1;
}

//Start of Bistro System!




				if(strcmp(cmd, "/bistro", true) == 0) {
	gTeam[playerid] = TEAM_BISTRO;
	SetPlayerInterior(playerid, 1);
	SetPlayerFacingAngle(playerid, 359);
 	SetPlayerPos(playerid, -782.8555,498.3182,1371.7422);
   	SendClientMessage(playerid, COLOR_YELLOW, "You are now a bistro");
    SendClientMessage(playerid, COLOR_YELLOW, "Your Cmd's Are /givebeansoup[playerid], /givechili[playerid] and /bc (Team Chat)");
	SetPlayerSkin(playerid, 240);
	return 1;
	}

				if(strcmp(cmd,"/bc",true)==0) {//BISTRO TEAMSPEAK
	if (gTeam[playerid] == TEAM_BISTRO) {
	if ((strlen(cmdtext) >= 1)&&(strlen(cmdtext) <= 3)) { SendClientMessage(playerid,COLOR_RED1, "Syntax: /bc <MESSAGE>"); return 1; }
	GetPlayerName(playerid,name,sizeof(name));	format(string,sizeof(string),"Bistro Chat(%s):%s",name,cmdtext[3]); SendBistroMessage(COLOR_YELLOW, string);
	} else
								SendClientMessage(playerid, COLOR_YELLOW, "You are not official Bistro Staff!");
	return 1;
}


				if(strcmp(cmd, "/givechili", true) == 0) { // Gives a cake to the desired person!(Fills there health!)

                tmp = strtok(cmdtext, idx);
                if(!strlen(tmp)) {
                        		SendClientMessage(playerid, COLOR_YELLOW, "Usage: /givechili [Player ID]");
								return 1;
                }
				giveplayerid = strval(tmp);

    			if (IsPlayerConnected(giveplayerid)) {
        if (gTeam[playerid] == TEAM_BISTRO) {
   GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
   GetPlayerName(playerid, sendername, sizeof(sendername));
   SetPlayerHealth(giveplayerid, 100);
   GivePlayerMoney(playerid, 100);
   GivePlayerMoney(giveplayerid, -100);
   format(string, sizeof(string), "You have been given a bowl of chili by %s ", sendername, playerid);
   SendClientMessage(giveplayerid, COLOR_YELLOW, string);
   format(string, sizeof(string), "%s has been given a bowl of chili!!", giveplayer, giveplayerid, sendername, playerid);
   SendClientMessageToAll(COLOR_YELLOW, string);
   printf(string);
   return 1;
           }else{
                				SendClientMessage(playerid, COLOR_RED1, "You Are not official Bistro staff!!!");
}
                        }else{
        format(string, sizeof(string), "id %d is not an active player.", giveplayerid);
		SendClientMessage(playerid, COLOR_YELLOW, string);
}
				return 1;
}
				if(strcmp(cmd, "/givebeansoup", true) == 0) { // Gives a sandwich to the desired person!(Fills there health!)

                tmp = strtok(cmdtext, idx);
                if(!strlen(tmp)) {
                        		SendClientMessage(playerid, COLOR_YELLOW, "Usage: /givebeansoup [Player ID]");
								return 1;
                }
        		giveplayerid = strval(tmp);

    			if (IsPlayerConnected(giveplayerid)) {
        if (gTeam[playerid] == TEAM_BISTRO) {
   GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
   GetPlayerName(playerid, sendername, sizeof(sendername));
   SetPlayerHealth(giveplayerid, 100);
   GivePlayerMoney(playerid, 100);
   GivePlayerMoney(giveplayerid, -100);
   format(string, sizeof(string), "You have been given a bowl of beansoup by %s ", sendername, playerid);
   SendClientMessage(giveplayerid, COLOR_YELLOW, string);
   format(string, sizeof(string), "%s has been given a bowl of beansoup!!", giveplayer, giveplayerid, sendername, playerid);
   SendClientMessageToAll(COLOR_YELLOW, string);
   printf(string);
   return 1;
           }else{
                				SendClientMessage(playerid, COLOR_RED1, "You Are not official Bistro staff!!");
}
                        }else{
        format(string, sizeof(string), "id %d is not an active player.", giveplayerid);
        SendClientMessage(playerid, COLOR_YELLOW, string);
}
				return 1;
}

				if(strcmp(cmd, "/chili", true) == 0) { // Displays the Text: "[PLAYEID] would like a Cake please!"
	GetPlayerName(playerid,name,sizeof(name));
	format(string,sizeof(string),"%s would like a bowl of chili Please!",name);
	SendClientMessageToAll(COLOR_YELLOW, string);
	return 1;
}
				if(strcmp(cmd, "/beansoup", true) == 0) { // Displays the Text: "[PLAYEID] would like a Sandwich please!"
	GetPlayerName(playerid,name,sizeof(name));
	format(string,sizeof(string),"%s would like a bowl of beansoup Please!",name);
	SendClientMessageToAll(COLOR_YELLOW, string);
	return 1;
}

				if(strcmp(cmd, "/bistro", true) == 0) { //Teles you to the bistro and tells you to type /menu
	SetPlayerInterior(playerid, 1);
	SetPlayerFacingAngle(playerid, 270);
 	SetPlayerPos(playerid, -780.7914, 494.8177, 1376.195);
    GameTextForPlayer(playerid,"~W~Welcome To The Liberty Bistro!!!",6000,5);
	SendClientMessage(playerid, COLOR_YELLOW, "Type /menu to see todays selection!!");
	return 1;
	}

				if(strcmp(cmd, "/menu", true) == 0) { //Tells you what you can eat!
								SendClientMessage(playerid, COLOR_YELLOW, "Todays menu: /Chili($100) and A /beansoup($100)!!");
								return 1;
	}

				if(strcmp(cmd, "/bistrohq", true) == 0) { //Teles a bistro worker to the bistro!
    if(gTeam[playerid] == TEAM_BISTRO)
	{
	SetPlayerInterior(playerid, 1);
	SetPlayerFacingAngle(playerid, 359);
 	SetPlayerPos(playerid, -782.8555,498.3182,1371.7422);
	}
	else
	{
								SendClientMessage(playerid, COLOR_RED1, "You Are NOT official Bistro Staff!!");
	}
	return 1;
	}

				if(strcmp(cmd, "/hostage", true) == 0) { // Holds the desired person hostage in the Garden of the bistro

                tmp = strtok(cmdtext, idx);
                if(!strlen(tmp)) {
                        		SendClientMessage(playerid, COLOR_GREEN, "Usage: /hostage [Player ID]");
								return 1;
                }
        		giveplayerid = strval(tmp);

				if (gTeam[playerid] == TEAM_BISTRO) {
            if (IsPlayerConnected(giveplayerid)) {
                      GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
                      GetPlayerName(playerid, sendername, sizeof(sendername));
                      format(string, sizeof(string), "You are holding %s hostage!", giveplayer, giveplayerid);
                      SendClientMessage(playerid, COLOR_GREEN, string);
                      format(string, sizeof(string), "You are being held hostage by %s (ID:%d)!", sendername, playerid);
                      SendClientMessage(giveplayerid, COLOR_RED1, string);
                      format(string, sizeof(string), "%s is being held hostage by %s", giveplayer, giveplayerid, sendername, playerid);
                      SendClientMessageToAll(COLOR_GREEN, string);
                      printf(string);
                      SetPlayerInterior(giveplayerid,1);
                      SetPlayerPos(giveplayerid,-839.3268,529.0875,1357.1016);
                      SetPlayerFacingAngle(giveplayerid,177.0350);
                      SetCameraBehindPlayer(giveplayerid);
                      PlayerPlaySound(giveplayerid,1082,198.3797,160.8905,1003.0300);
                      TogglePlayerControllable(giveplayerid,0);   // sp that can't /kill
                      DisablePlayerCheckpoint(giveplayerid);
				      return 1;
                                        }else{
        format(string, sizeof(string), "id %d is not an active player.", giveplayerid);
        SendClientMessage(playerid, COLOR_YELLOW, string);
}
                }else{
        format(string, sizeof(string), "You Are Not official Bistro ~~staff!!!", giveplayerid);
        SendClientMessage(playerid, COLOR_WHITE, string);
}
				return 1;
}
				if(strcmp(cmd, "/unhostage", true) == 0) { //Releases the person from being held hostage!!

                tmp = strtok(cmdtext, idx);
                if(!strlen(tmp)) {
                        		SendClientMessage(playerid, COLOR_GREEN, "Usage: /unhostage [Player ID]");
                				return 1;
                }
        		giveplayerid = strval(tmp);

        		if (gTeam[playerid] == TEAM_BISTRO) {
            if (IsPlayerConnected(giveplayerid)) {
                      GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
                      GetPlayerName(playerid, sendername, sizeof(sendername));
                      format(string, sizeof(string), "You have released %s (ID:%d)", giveplayer, giveplayerid);
                      SendClientMessage(playerid, COLOR_GREEN, string);
                      format(string, sizeof(string), "You have been released by %s (ID:%d)!", sendername, playerid);
                      SendClientMessage(giveplayerid, COLOR_GREEN, string);
                      format(string, sizeof(string), "%s (ID:%d) has been released by %s (ID:%d)", giveplayer, giveplayerid, sendername, playerid);
                      SendClientMessageToAll(COLOR_GREEN, string);
                      printf(string);
                      SetPlayerInterior(giveplayerid,1);
                      SetPlayerFacingAngle(giveplayerid,90.00);
                      SetPlayerPos(giveplayerid,-780.7914, 494.8177, 1376.195);
                      SetPlayerFacingAngle(giveplayerid,177.0350);
                      SetCameraBehindPlayer(giveplayerid);
                      TogglePlayerControllable(giveplayerid,1);
                      return 1;
                                        }else{
        format(string, sizeof(string), "id %d is not an active player.", giveplayerid);
        SendClientMessage(playerid, COLOR_YELLOW, string);
}
                }else{
        format(string, sizeof(string), "You Are not official Bistro ~Staff!!", giveplayerid);
        SendClientMessage(playerid, COLOR_WHITE, string);
}
				return 1;
}

//Start of the Army System! (SAA--San andreas Army)
				if(strcmp(cmd, "/army", true) == 0) {
		SendClientMessage(playerid, COLOR_RED1, "You Are logged into The Army!!");
        gTeam[playerid] = TEAM_ARMY;
		SetPlayerColor(playerid, COLOR_NAVY);
		SetPlayerPos(playerid, 237.4847,1860.8080,20.6406);
		GivePlayerWeapon(playerid, 30, 500);
        GivePlayerWeapon(playerid, 31, 500);
        GivePlayerWeapon(playerid, 36, 2500);
		SetPlayerSkin(playerid, 287);
		return 1;
	}

//Start of the Medic System! (SAM--San andreas Medics)

				if(strcmp(cmd, "/medic", true) == 0) {
		SendClientMessage(playerid, COLOR_RED1, "You Are logged into Medics!!");
        SendClientMessage(playerid, COLOR_RED1, "Your Cmd's Are: /heal /hospital");
        SendClientMessage(playerid, COLOR_RED1, "SKINS: /medic1");
		gTeam[playerid] = TEAM_MEDIC;
		SetPlayerColor(playerid, COLOR_GOLD);
		SetPlayerPos(playerid, 1612.6895,1824.4283,10.8203);
		SetPlayerSkin(playerid, 276);
		return 1;
	}
				if(strcmp(cmdtext, "/heal", true, 3)==0) {

if (gTeam[playerid] == TEAM_MEDIC) {
      tmp = strtok(cmdtext, idx);

      if(!strlen(tmp)) {
         SendClientMessage(playerid, COLOR_WHITE, "USAGE: /heal [ID]");
         return 1;
      }
      new pid = strval(tmp);

      if (IsPlayerConnected(pid))
      {
         SetPlayerHealth(pid,100);

      }
   }
return 1;
   }

	

 				if(strcmp(cmd, "/hospital", true) == 0) { //Teles a medic back to the HQ
    if(gTeam[playerid] == TEAM_MEDIC)
	{
	SetPlayerPos(playerid, 1612.6895,1824.4283,10.8203);
	}
	else
	{
	SendClientMessage(playerid, COLOR_RED1, "You Are NOT an official Medic!!");
	}
	return 1;
	}
				if(strcmp(cmd, "/medic", true) == 0) { //For the public to say: "[PLAYERID] Needs a private pilot!"
	GetPlayerName(playerid,name,sizeof(name));
	format(string,sizeof(string),"%s Needs a medic immediatly!!",name);
	SendClientMessageToAll(COLOR_YELLOW, string);

	return 1;
}
				if(strcmp(cmd, "/medic1", true) == 0) { //cop skin
if (gTeam[playerid] == TEAM_MEDIC) {
SetPlayerSkin(playerid, 71);
}else{
SendClientMessage(playerid, COLOR_RED, "You are not an official medic!!");
}
return 1;
}

//Start of the Pilot System! (SAA--San andreas Airlines)
				if(strcmp(cmd, "/pilot", true) == 0) { //Changes the players color and takes you to the pilot HQ
    SetPlayerPos(playerid, -1345.7917,-252.1577,14.1484); // login pilots
	SendClientMessage(playerid, COLOR_YELLOW, "You are Now a Certified Pilot!!");
    gTeam[playerid] = TEAM_PILOT;
	SendClientMessage(playerid, COLOR_YELLOW, "Your commands are: /pickup, /plocation, /pilothq and /pc(Team Speak)");
	SetPlayerColor(playerid, COLOR_GREEN);
	return 1;
	}

    			if(strcmp(cmd,"/pc",true)==0) {//Pilot TEAMSPEAK
	if (gTeam[playerid] == TEAM_PILOT) {
	if ((strlen(cmdtext) >= 1)&&(strlen(cmdtext) <= 3)) { SendClientMessage(playerid,COLOR_RED1, "Syntax: /pc <MESSAGE>"); return 1; }
	GetPlayerName(playerid,name,sizeof(name));	format(string,sizeof(string),"Pilot Chat(%s):%s",name,cmdtext[3]); SendPilotMessage(COLOR_YELLOW, string);
	} else SendClientMessage(playerid, COLOR_YELLOW, "You are not official Police!");
	return 1;
}

				if(strcmp(cmd, "/pickup", true) == 0) { //displays the text: "Type /pilot to be flown anywhere in safety"
    if(gTeam[playerid] == TEAM_PILOT)
	{
	SendClientMessageToAll(COLOR_GREEN, "Type /pilot to be flown to anywhere in safety!!");
	}
	else
	{
	SendClientMessage(playerid, COLOR_RED1, "You Are NOT an official Pilot!!");
	}
	return 1;
	}

				if(strcmp(cmd, "/pilothq", true) == 0) { //Teles a pilot back to the HQ
    if(gTeam[playerid] == TEAM_PILOT)
	{
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid, -1345.7917,-252.1577,14.1484);
	}
	else
	{
	SendClientMessage(playerid, COLOR_RED1, "You Are NOT an official Pilot!!");
	}
	return 1;
	}
				if(strcmp(cmd, "/accept", true) == 0) {
    if(gTeam[playerid] == TEAM_PILOT)
	{
	GetPlayerName(playerid,name,sizeof(name));
	format(string,sizeof(string),"%s Has accepted The Job",name);
	SendClientMessageToAll(COLOR_YELLOW, string);
	}
	else
	{
	SendClientMessage(playerid, COLOR_RED1, "You Are NOT an official Pilot!!");
	}
	return 1;
	}

				if(strcmp(cmd, "/plocation", true) == 0) { 
    if(gTeam[playerid] == TEAM_PILOT)
	{
	SendClientMessageToAll(COLOR_GREEN, "Where is your current location please");
	}
	else
	{
	SendClientMessage(playerid, COLOR_RED1, "You Are NOT an official Pilot!!");
	}
	return 1;
	}

				if(strcmp(cmd, "/pilot", true) == 0) { //For the public to say: "[PLAYERID] Needs a private pilot!"
	GetPlayerName(playerid,name,sizeof(name));
	format(string,sizeof(string),"%s Needs a Pilot Type /accept to transport him",name);
	SendClientMessageToAll(COLOR_YELLOW, string);
//=========================END OF THE JOBS=========================
	return 1;
}
                return 0;
}
public Dschool_Yes(playerid)
{
    new PName[MAX_PLAYER_NAME];

    GetPlayerName(playerid,PName,sizeof(PName));
    DSchool=fopen("DSchool",io_readwrite);
    dini_Set("DSchool",PName,"Y");
    fclose(DSchool);
    return 1;
}

public Dschool_No(playerid)
{
    new PName[MAX_PLAYER_NAME];

    GetPlayerName(playerid,PName,sizeof(PName));
    DSchool=fopen("DSchool",io_readwrite);
    dini_Set("DSchool",PName,"N");
    fclose(DSchool);
    return 1;
}

public Dschool_Dis(playerid)
{
    new PName[MAX_PLAYER_NAME];

    GetPlayerName(playerid,PName,sizeof(PName));
    DSchool=fopen("DSchool",io_readwrite);
    dini_Set("DSchool",PName,"D");
    fclose(DSchool);
    return 1;
}

public QuitSchool(playerid) // Use for things which force you to quit the driving school test
{
        if(DriverTakingTest==playerid)
        {
                KillTimer(TimerDST);
                TimerDSTime=0;
                TimerCD=0;
                DriverTakingTest=-1;
                if(IsPlayerConnected(playerid))
                {
                        DisablePlayerCheckpoint(playerid);
                        GameTextForPlayer(playerid,"~r~you failed the driving test.",3000,3);
                }
                return 1;
        }
        return 0;
}


public Countdown()
{
   new Num=4;
   new string[2];
   TimerCD++;
   if(Num-TimerCD<=0)
   {
   TimerCD=0;
   GameTextForPlayer(PID,"~r~GO!!!",3000,3);
   SetPlayerCheckpoint(PID,CPDSchoolData[1][0],CPDSchoolData[1][1],CPDSchoolData[1][2],CPDSchoolData[1][3]);
   DSCP[PID]=1;
   TogglePlayerControllable(PID,1);
   TimerDST=SetTimer("CountUpTimeTaken",1000,1);
   }
   else
   {
          SetTimer("Countdown",1000,0);
 		  valstr(string,Num-TimerCD);
          GameTextForPlayer(PID,string,800,3);
   }
   return 1;
}

public CountUpTimeTaken()
{
        TimerDSTime++;
}

public OnPlayerEnterCheckpoint(playerid)
{
        switch(DSCP[playerid])
        {
       case 0:
       {
                if(IsPlayerInAnyVehicle(playerid))
        {
                PID=playerid;
                SetTimer("Countdown",1000,0);
                TogglePlayerControllable(playerid,0);
                }
                else
                {
                    GameTextForPlayer(playerid,"Get in a car!",2000,3);
                }
      }
      case 1:
      {
        if(IsPlayerInAnyVehicle(playerid))
        {
            SetPlayerCheckpoint(playerid,CPDSchoolData[2][0],CPDSchoolData[2][1],CPDSchoolData[2][2],CPDSchoolData[2][3]);
            DSCP[playerid]=2;
        }
                else
                {
                    GameTextForPlayer(playerid,"Get in a car!",2000,3);
                }
      }
      case 2..22:
      {
          if(IsPlayerInAnyVehicle(playerid))
          {
                  SetPlayerCheckpoint(playerid,CPDSchoolData[DSCP[playerid]+1][0],CPDSchoolData[DSCP[playerid]+1][1],CPDSchoolData[DSCP[playerid]+1][2],CPDSchoolData[DSCP[playerid]+1][3]);
                  DSCP[playerid]++;
          }
          else
                  {
                      GameTextForPlayer(playerid,"Get in a car!",2000,3);
                  }
      }
      case 23:
      {
         DisablePlayerCheckpoint(playerid);
         KillTimer(TimerDST);
         DSCP[playerid]=0;
         new String1[255];
         if(TimerDSTime<=TooFast)
         {
            format(String1,255,"~b~Your time was: %d Seconds.\r\n ~r~You were too wreckless, and failed the course.",TimerDSTime);
         }
         else if(TimerDSTime>=TooSlow)
         {
            format(String1,255,"~b~Your time was: %d Seconds.\r\n ~r~You were hazardously slow, and failed the course.",TimerDSTime);
         }
         else
         {
            format(String1,255,"~b~Your time was: %d Seconds.\r\n ~g~Congratulations! You passed the course.",TimerDSTime);
            Dschool_Yes(playerid); // Gain your licence! :D
         }
         GameTextForPlayer(playerid,String1,4000,3);
         printf("ID:%d finished the Driving School course in %d seconds.",playerid,TimerDSTime);
         TimerDSTime=0;
         DriverTakingTest=-1;
      }
        }
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new PName[MAX_PLAYER_NAME];

    GetPlayerName(playerid,PName,sizeof(PName));

	if((newstate==PLAYER_STATE_DRIVER)&&(strcmp(dini_Get("DSchool",PName),"N",false)==0))
        {
            SendClientMessage(playerid,0xFF000000,"You are driving without a licence. You may be arrested.");
            printf("%s(ID:%d) is driving without a licence.",PName,playerid);
        }
        else if((newstate==PLAYER_STATE_DRIVER)&&(strcmp(dini_Get("DSchool",PName),"D",false)==0))
        {
            SendClientMessage(playerid,0xFF000000,"You are driving illegally. You are likely to be arrested.");
            printf("%s(ID:%d) is driving with a suspended licence.",PName,playerid);
        }
}

SendBistroMessage(color, text[]) {
    for(new i = 0; i < MAX_PLAYERS; i ++) {
    	if(IsPlayerConnected(i)) {
	    	if (gTeam[i] == TEAM_BISTRO) {
            	SendClientMessage(i, color, text);
            }
        }
    }
}

SendCopMessage(color, text[]) {
    for(new i = 0; i < MAX_PLAYERS; i ++) {
    	if(IsPlayerConnected(i)) {
	    	if (gTeam[i] == TEAM_COP) {
            	SendClientMessage(i, color, text);
            }
        }
    }
}

SendPilotMessage(color, text[]) {
    for(new i = 0; i < MAX_PLAYERS; i ++) {
    	if(IsPlayerConnected(i)) {
	    	if (gTeam[i] == TEAM_PILOT) {
            	SendClientMessage(i, color, text);
            }
        }
    }
}

SendTaxiMessage(color, text[]) {
    for(new i = 0; i < MAX_PLAYERS; i ++) {
    	if(IsPlayerConnected(i)) {
	    	if (gTeam[i] == TEAM_TAXI) {
            	SendClientMessage(i, color, text);
            }
        }
    }
}

SendFBIMessage(color, text[]) {
    for(new i = 0; i < MAX_PLAYERS; i ++) {
    	if(IsPlayerConnected(i)) {
	    	if (gTeam[i] == TEAM_FBI) {
            	SendClientMessage(i, color, text);
            }
        }
    }
}

SendStatePoliceMessage(color, text[]) {
    for(new i = 0; i < MAX_PLAYERS; i ++) {
    	if(IsPlayerConnected(i)) {
	    	if (gTeam[i] == TEAM_SP) {
            	SendClientMessage(i, color, text);
            }
        }
    }
}

