					///////////////////////////////
					//  	[FS]Career V1.0      //
					//---------------------------//
					// Made By JESSE/jesse989898 //
					//---------------------------//
					//  Thanks To Scripting Help //
					//       At SA:MP Forum      //
					// Please Keep Credits To Me //
					///////////////////////////////
					
					
#include <a_samp>

forward MedicCheck(playerid);
forward MedicMake(playerid);
forward MedicQuit(playerid);
forward	CopCheck(playerid);
forward CopMake(playerid);
forward CopQuit(playerid);
forward	FireCheck(playerid);
forward FireMake(playerid);
forward FireQuit(playerid);
forward	AgentCheck(playerid);
forward AgentMake(playerid);
forward AgentQuit(playerid);
forward	TaxiCheck(playerid);
forward TaxiMake(playerid);
forward TaxiQuit(playerid);
forward	PilotCheck(playerid);
forward PilotMake(playerid);
forward PilotQuit(playerid);

//forward change(playerid);


fdeleteline(filename[], line[]);
fcreate(filename[]);

new Job[MAX_PLAYERS];
new JobCop[MAX_PLAYERS];
new JobAgent[MAX_PLAYERS];
new JobMedic[MAX_PLAYERS];
new JobFire[MAX_PLAYERS];
new JobTaxi[MAX_PLAYERS];
new JobPilot[MAX_PLAYERS];


new Jobcp[MAX_PLAYERS];
new TaxiReady[MAX_PLAYERS];
new PlaneReady[MAX_PLAYERS];

//new gTeam[MAX_PLAYERS];

#define TEAM_COP 1
#define TEAM_MEDIC 2
#define TEAM_AGENT 3
#define TEAM_FIRE 4
#define TEAM_TAXI 5
#define TEAM_PILOT 6

#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_BLUE 0x8D8DFF00
#define COLOR_RED 0xAA3333AA
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_WHITE 0xFFFFFFAA

#define FILTERSCRIPT



public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Career Filterscript by [AZ]JESSE");
	print("--------------------------------------\n");
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{

	return 1;
}

public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid, COLOR_BLUE, "This server uses [AZ]JESSE's Career scipt ");
	Job[playerid] = 0;

	Jobcp[playerid] = 0;
 	SetPlayerMapIcon(playerid, 1, 953.4695,-911.4966,45.7656, 32, 0);
    SetPlayerMapIcon(playerid, 2, 1178.5338,-1323.4142,14.1248, 22, 0);
   	SetPlayerMapIcon(playerid, 3, 1151.0916,-1218.7781,17.7665, 20, 0);
    SetPlayerMapIcon(playerid, 4, 1543.0513,-1675.5679,13.2768, 30, 0);
	
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	new name[256];
	new string[256];
	switch (GetPlayerSkin(playerid))
	{
	    case 280..284,288:
	    {
	        if(CopCheck(playerid))
			{
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string),"Welcome Officer %s To The Police Force, /jobhelp",name);
			SendClientMessageToAll(COLOR_BLUE, string);
			JobCop[playerid] = 1;
			}
			else{
			SendClientMessage(playerid, COLOR_RED, "You Are Not A Registered Police Officer");
			ForceClassSelection(playerid);
			SetPlayerHealth(playerid, 0);
			}
			return 1;
			}
			
		case 274..276:
		{
			if(MedicCheck(playerid)){
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string),"Welcome Doctor %s To The Health System, /jobhelp",name);
			SendClientMessageToAll(COLOR_BLUE, string);
			JobMedic[playerid] = 1;

			}
            else{
			SendClientMessage(playerid, COLOR_RED, "You Are Not A Registered Doctor");
	        ForceClassSelection(playerid);
			SetPlayerHealth(playerid, 0);
			}

			return 1;
			}
			
		case 163..166:
  	    {
			if(AgentCheck(playerid)){
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string),"Welcome Agent %s To The Secret Service, /jobhelp",name);
			SendClientMessageToAll(COLOR_BLUE, string);
			JobAgent[playerid] = 1;

			}
            else{

			SendClientMessage(playerid, COLOR_RED, "You Are Not A Registered Federal Agent");
			ForceClassSelection(playerid);
			SetPlayerHealth(playerid, 0);

			}
			return 1;
			}
 	    case 277..279:
 		{
			if(FireCheck(playerid)){
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string),"Welcome Fire-Fighter %s To The Fire Brigade, /jobhelp",name);
			SendClientMessageToAll(COLOR_BLUE, string);
			JobFire[playerid] = 1;

			}
			else{
			SendClientMessage(playerid, COLOR_RED, "You Are Not A Registered Fire-Fighter");
			ForceClassSelection(playerid);
			SetPlayerHealth(playerid, 0);
			}

			return 1;
   			}
   		case 253,255:
		{
			if(TaxiCheck(playerid)){
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string),"Welcome Driver %s To The Transport System, /jobhelp",name);
			SendClientMessageToAll(COLOR_BLUE, string);
			JobTaxi[playerid] = 1;

			}
            else{
			SendClientMessage(playerid, COLOR_RED, "You Are Not A Registered Driver");
	        ForceClassSelection(playerid);
			SetPlayerHealth(playerid, 0);
			}

			return 1;
			}
   		case 61:
		{
			if(PilotCheck(playerid)){
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string),"Welcome Pilot %s To The Transport System, /jobhelp",name);
			SendClientMessageToAll(COLOR_BLUE, string);
			JobPilot[playerid] = 1;
			}
            else{
			SendClientMessage(playerid, COLOR_RED, "You Are Not A Registered Pilot");
	        ForceClassSelection(playerid);
			SetPlayerHealth(playerid, 0);
			}
			return 1;
			}
		}
		
	if (Job[playerid] == 0) {
	SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM JOB-LINK#");
	SendClientMessage(playerid, COLOR_PURPLE, "Type /searchjob To Find A Job");
	SendClientMessage(playerid, COLOR_PURPLE, "JOB-LINK, Connecting People & Jobs");
	JobCop[playerid] = 0;
	JobMedic[playerid] = 0;
	JobAgent[playerid] = 0;
	JobFire[playerid] = 0;
	JobTaxi[playerid] = 0;
	JobPilot[playerid] = 0;
	return 1;
	}
	//change(playerid);
	return 1;
	}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(GetPlayerWantedLevel(playerid) == 0){
    SetPlayerWantedLevel(killerid, GetPlayerWantedLevel(killerid)+1);
    if(GetPlayerWantedLevel(killerid == 1))
    {
        GivePlayerMoney(killerid,1000);
        SetPlayerWantedLevel(killerid,0);
    }

    
    else if(GetPlayerWantedLevel(killerid == 2))
    {
        GivePlayerMoney(killerid,2000);
        SetPlayerWantedLevel(killerid,0);
    }
    else if(GetPlayerWantedLevel(killerid == 3))
    {
        GivePlayerMoney(killerid,5000);
        SetPlayerWantedLevel(killerid,0);
    }
    else if(GetPlayerWantedLevel(killerid == 4))
    {
        GivePlayerMoney(killerid,7000);
        SetPlayerWantedLevel(killerid,0);
    }
    else if(GetPlayerWantedLevel(killerid == 5))
    {
        GivePlayerMoney(killerid,10000);
        SetPlayerWantedLevel(killerid,0);
    }
    else if(GetPlayerWantedLevel(killerid == 6))
    {
        GivePlayerMoney(killerid,20000);
        SetPlayerWantedLevel(killerid,0);
    }
    }
    
	if(JobCop[playerid] == 1){
		new name[256];
		new string[256];
		GetPlayerName(playerid,name,sizeof(name));
		format(string,sizeof(string),"Officer %s Has Died!",name);
		SendClientMessageToAll(COLOR_YELLOW, string);
		return 1;
	}
	if(JobMedic[playerid] == 1){
		new name[256];
		new string[256];
		GetPlayerName(playerid,name,sizeof(name));
		format(string,sizeof(string),"Medic %s Has Died!",name);
		SendClientMessageToAll(COLOR_YELLOW, string);
		return 1;
	}
	if(JobAgent[playerid] == 1){
		new name[256];
		new string[256];
		GetPlayerName(playerid,name,sizeof(name));
		format(string,sizeof(string),"Agent %s Has Died!",name);
		SendClientMessageToAll(COLOR_YELLOW, string);
		return 1;
	}
	if(JobFire[playerid] == 1){
		new name[256];
		new string[256];
		GetPlayerName(playerid,name,sizeof(name));
		format(string,sizeof(string),"FireFighter %s Has Died!",name);
		SendClientMessageToAll(COLOR_YELLOW, string);
		return 1;
	}
	if(JobTaxi[playerid] == 1){
		new name[256];
		new string[256];
		GetPlayerName(playerid,name,sizeof(name));
		format(string,sizeof(string),"Driver %s Has Died!",name);
		SendClientMessageToAll(COLOR_YELLOW, string);
		return 1;
	}
	if(JobPilot[playerid] == 1){
		new name[256];
		new string[256];
		GetPlayerName(playerid,name,sizeof(name));
		format(string,sizeof(string),"Pilot %s Has Died!",name);
		SendClientMessageToAll(COLOR_YELLOW, string);
		return 1;
	}
	
    return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{

	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new idx;
	new name[256];
	new cmd[256];
	new giveplayerid;

	if (strcmp("/quitcop", cmdtext, true, 10) == 0)
	{
 	CopQuit(playerid);
	SendClientMessage(playerid, COLOR_RED, "You Have Quit The Police Force");
	JobCop[playerid] = 0;
	Jobcp[playerid] = 0;
	return 1;
 	}

	if (strcmp("/quitagent", cmdtext, true, 10) == 0)
	{
	AgentQuit(playerid);
	SendClientMessage(playerid, COLOR_RED, "You Have Quit The Agent Job");
	JobAgent[playerid] = 0;
	Jobcp[playerid] = 0;
	return 1;
	}
	if (strcmp("/quitmedic", cmdtext, true, 10) == 0)
	{
	AgentQuit(playerid);
	SendClientMessage(playerid, COLOR_RED, "You Have Quit The Agent Job");
	JobMedic[playerid] = 0;
	Jobcp[playerid] = 0;
	return 1;
	}
	if (strcmp("/quitfire", cmdtext, true, 10) == 0)
	{
	AgentQuit(playerid);
	SendClientMessage(playerid, COLOR_RED, "You Have Quit The Agent Job");
	JobFire[playerid] = 0;
	Jobcp[playerid] = 0;
	return 1;
	}
	if (strcmp("/quittaxi", cmdtext, true, 10) == 0)
	{
	AgentQuit(playerid);
	SendClientMessage(playerid, COLOR_RED, "You Have Quit The Agent Job");
	JobTaxi[playerid] = 0;
	Jobcp[playerid] = 0;
	return 1;
	}
	if (strcmp("/quitpilot", cmdtext, true, 10) == 0)
	{
	AgentQuit(playerid);
	SendClientMessage(playerid, COLOR_RED, "You Have Quit The Agent Job");
	JobPilot[playerid] = 0;
	Jobcp[playerid] = 0;
	
	return 1;
	}

	if (strcmp("/searchjob", cmdtext, true, 10) == 0)
	{
	if(Job[playerid] == 0) {//0 means no job
	SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM SA JOB-LINK#");
	SendClientMessage(playerid, COLOR_PURPLE, "You Are Currently Unemployed");
	SendClientMessage(playerid, COLOR_PURPLE, "----------------------------");
	SendClientMessage(playerid, COLOR_PURPLE, "For A List Of Jobs Avalible");
	SendClientMessage(playerid, COLOR_PURPLE, "Please Come To JOB_LINK");
	SendClientMessage(playerid, COLOR_PURPLE, "Then Type /joblist ");
	Jobcp[playerid] = 0;
	Job[playerid] = 3;//searching
	SetPlayerCheckpoint(playerid,953.4695,-911.4966,45.7656,8.0);
	}
	else
	{
	SendClientMessage(playerid, COLOR_PURPLE, "You Have a Job! or You are currently looking!");
	}
	return 1;
	}
	
 	if (strcmp("/joblist", cmdtext, true, 10) == 0)
	{
	if(Job[playerid] == 3) {//3 mean searching
	if(Jobcp[playerid] == 1){
	SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM SA JOB-LINK#");
	SendClientMessage(playerid, COLOR_PURPLE, "Here Are Some Available Jobs");
	SendClientMessage(playerid, COLOR_PURPLE, "----------------------------");
	SendClientMessage(playerid, COLOR_PURPLE, "Police /applycop");
	SendClientMessage(playerid, COLOR_PURPLE, "Medic /applymedic");
	SendClientMessage(playerid, COLOR_PURPLE, "Fire /applyfire");
    SendClientMessage(playerid, COLOR_PURPLE, "Agent /applyagent");
    SendClientMessage(playerid, COLOR_PURPLE, "Taxi /applytaxi");
    SendClientMessage(playerid, COLOR_PURPLE, "Pilot /applypilot");
	}else{
 	SendClientMessage(playerid, COLOR_RED, "You Must Be At JOB-LINK");
 	}
 	}
	return 1;
	}
    
   	if (strcmp(cmdtext, "/applyagent", true)==0)
	{
	if(Job[playerid] == 3) {
	if(Jobcp[playerid] == 1){
	AgentMake(playerid);
	SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM SA JOB-LINK#");
	SendClientMessage(playerid, COLOR_PURPLE, "Your Application Was Successful");
	SendClientMessage(playerid, COLOR_PURPLE, "Welcome To The Agentcy");
	SendClientMessage(playerid, COLOR_PURPLE, "If You Want To Quit Type /agentquit");
	JobAgent[playerid] = 1;
	}
	}
	return 1;
	}
    
   	if (strcmp(cmdtext, "/applycop", true)==0)
	{
	if(Job[playerid] == 3) {
	if(Jobcp[playerid] == 11){
	SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM SA JOB-LINK#");
	SendClientMessage(playerid, COLOR_PURPLE, "Your Application Is Pending");
	SendClientMessage(playerid, COLOR_PURPLE, "Please Go To The LS-PD");
	SetPlayerCheckpoint(playerid,1543.0513,-1675.5679,13.2768,8);
	}
	}
	return 1;
    }

    
    

   	if (strcmp(cmdtext, "/applyfire", true)==0)
	{
	if(Job[playerid] == 3) {
	if(Jobcp[playerid] == 1){
	FireMake(playerid);
	SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM SA JOB-LINK#");
	SendClientMessage(playerid, COLOR_PURPLE, "Your Application Was Successful");
	SendClientMessage(playerid, COLOR_PURPLE, "Welcome To The Fire-Brigade");
	SendClientMessage(playerid, COLOR_PURPLE, "If You Want To Quit Type /firequit");
	JobFire[playerid] = 1;
	}
	}
	return 1;
    }
    
   	if (strcmp(cmdtext, "/applymedic", true)==0)
	{
	if(Job[playerid] == 3) {
	if(Jobcp[playerid] == 1){
	MedicMake(playerid);
	SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM SA JOB-LINK#");
	SendClientMessage(playerid, COLOR_PURPLE, "Your Application Was Successful");
	SendClientMessage(playerid, COLOR_PURPLE, "Welcome To The Health System");
	SendClientMessage(playerid, COLOR_PURPLE, "If You Want To Quit Type /medicquit");
	JobMedic[playerid] = 1;
	}
	}
	return 1;
  	}
   	if (strcmp(cmdtext, "/applytaxi", true)==0)
	{
	if(Job[playerid] == 3) {
	if(Jobcp[playerid] == 1){
	MedicMake(playerid);
	SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM SA JOB-LINK#");
	SendClientMessage(playerid, COLOR_PURPLE, "Your Application Was Successful");
	SendClientMessage(playerid, COLOR_PURPLE, "Welcome To The Transport System");
	SendClientMessage(playerid, COLOR_PURPLE, "If You Want To Quit Type /taxiquit");
	JobTaxi[playerid] = 1;
	}
	}
	return 1;
  	}
   	if (strcmp(cmdtext, "/applypilot", true)==0)
	{
	if(Job[playerid] == 3) {
	if(Jobcp[playerid] == 1){
	MedicMake(playerid);
	SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM SA JOB-LINK#");
	SendClientMessage(playerid, COLOR_PURPLE, "Your Application Was Successful");
	SendClientMessage(playerid, COLOR_PURPLE, "Welcome To The Transport System");
	SendClientMessage(playerid, COLOR_PURPLE, "If You Want To Quit Type /pilotquit");
	JobPilot[playerid] = 1;
	}
	}
	return 1;
  	}

	if(strcmp(cmdtext, "/healplayer", true) == 0)
	{
	    new string[256], sendername[24], giveplayer[24];
	   	new tmp[256];
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /healplayer [id]");
	    giveplayerid = strval(tmp);
	    if(JobMedic[playerid] == 1)
	    {
	        if(IsPlayerConnected(giveplayerid))
	        {
	            GetPlayerName(playerid, sendername, sizeof(sendername));
	            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
	            format(string, sizeof(string), "Medic %s(%i) Has Healed You!", sendername, playerid);
	            SendClientMessage(giveplayerid, COLOR_RED, string);
	            SetPlayerHealth(giveplayerid, 100);
	            format(string, sizeof(string), "You have healed %s(%i)", giveplayer, giveplayerid);
	            SendClientMessage(playerid, COLOR_RED, string);
	        }
	        else
	        {
	            format(string, sizeof(string), "ERROR! %d isn't connected", giveplayerid);
	            SendClientMessage(playerid, COLOR_RED, string);
	        }
	    }
	    else return SendClientMessage(playerid, COLOR_RED, "You must be medic!");
	    return 1; //Thank Andre for this script
	}

	if(strcmp(cmdtext, "/jail", true) == 0)
	{
	    new string[256], sendername[24], giveplayer[24];
	   	new tmp[256];
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /jail [id]");
	    giveplayerid = strval(tmp);
	    if(JobCop[playerid] == 1)
	    {
	        if(IsPlayerConnected(giveplayerid))
	        {
	    	    SetPlayerCheckpoint(playerid,7.0, 268.3327,77.8972,1001.0391);
	        	new id = GetPlayerWantedLevel(playerid);
	        	
				if(id == 1 || id == 2 || id == 3 || id == 4 || id == 5 || id == 6 ){
                    if(IsPlayerInCheckpoint(playerid))
					{
			            GetPlayerName(playerid, sendername, sizeof(sendername));
			            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			            format(string, sizeof(string), "Officer %s(%i) Has Jailed You!", sendername, playerid);
			            TogglePlayerControllable(giveplayerid,0);
			            SendClientMessage(giveplayerid, COLOR_RED, string);
			            SetPlayerPos(giveplayerid, 264.6288,77.5742,1001.0391);
			            format(string, sizeof(string), "You have jailed %s(%i)", giveplayer, giveplayerid);
			            SendClientMessage(playerid, COLOR_RED, string);
						DisablePlayerCheckpoint(playerid);
						}
						else
						{
						SendClientMessage(playerid, COLOR_RED, "You must be closer to Jail Cell!");
				  		}
						
		            }
	        }
	        else
	        {
	            format(string, sizeof(string), "ERROR! %d isn't connected", giveplayerid);
	            SendClientMessage(playerid, COLOR_RED, string);
	        }
	    }
	    else return SendClientMessage(playerid, COLOR_RED, "You must be a Police Officer!");
	    return 1;
	}

	
	if (strcmp("/jobhelp", cmdtext, true, 10) == 0)
	{
		if(JobCop[playerid] == 1) {
		SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM SA JOB-LINK#");
		SendClientMessage(playerid, COLOR_PURPLE, "  Current Police Commands ");
		SendClientMessage(playerid, COLOR_PURPLE, "----------------------------");
		SendClientMessage(playerid, COLOR_PURPLE, "Jail Wanted Person /jail (playerid) ");
		}
		else if(JobMedic[playerid] == 1) {
		SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM SA JOB-LINK#");
		SendClientMessage(playerid, COLOR_PURPLE, "  Current Medic Commands ");
		SendClientMessage(playerid, COLOR_PURPLE, "----------------------------");
		SendClientMessage(playerid, COLOR_PURPLE, "Heal Players /heal (playerid)");
		SendClientMessage(playerid, COLOR_PURPLE, "         More Comming");
	 	}
		else if(Job[playerid] == 3) {
		SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM SA JOB-LINK#");
		SendClientMessage(playerid, COLOR_PURPLE, "  Current Agent Commands ");
		SendClientMessage(playerid, COLOR_PURPLE, "----------------------------");
		SendClientMessage(playerid, COLOR_PURPLE, "None Available Currently");
		SendClientMessage(playerid, COLOR_PURPLE, "       Sorry :(");
	 	}
		else if(Job[playerid] == 4) {
		SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM SA JOB-LINK#");
		SendClientMessage(playerid, COLOR_PURPLE, "Current Fire-Fighter Commands ");
		SendClientMessage(playerid, COLOR_PURPLE, "----------------------------");
		SendClientMessage(playerid, COLOR_PURPLE, "None Available Currently");
		SendClientMessage(playerid, COLOR_PURPLE, "       Sorry :(");
	 	}
		else if(Job[playerid] == 5) {
		SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM SA JOB-LINK#");
		SendClientMessage(playerid, COLOR_PURPLE, "  Current Taxi Commands ");
		SendClientMessage(playerid, COLOR_PURPLE, "----------------------------");
		SendClientMessage(playerid, COLOR_PURPLE, "Show Your Ready /taxiready");
		SendClientMessage(playerid, COLOR_PURPLE, "Locate Fare- /find (playerid)");
 		SendClientMessage(playerid, COLOR_PURPLE, "Disable checkpoints /findoff");
	 	}
		else if(Job[playerid] == 6) {
		SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM SA JOB-LINK#");
		SendClientMessage(playerid, COLOR_PURPLE, "  Current Pilot Commands ");
		SendClientMessage(playerid, COLOR_PURPLE, "----------------------------");
		SendClientMessage(playerid, COLOR_PURPLE, "None Available Currently");
		SendClientMessage(playerid, COLOR_PURPLE, "/taxiready /find (playerid)");
 		SendClientMessage(playerid, COLOR_PURPLE, "/findoff - Disable checkpoints");
	 	}
		return 1;
		}

	if (strcmp("/taxiready", cmdtext, true, 10) == 0){
		if(JobTaxi[playerid] == 1){
			new string[256];
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string),"Taxi Driver %s Is Now On Duty, You Can Call A Taxi /calltaxi",name);
			SendClientMessageToAll(COLOR_YELLOW, string);
			TaxiReady[playerid] = 1;
		}
		return 1;
	}
	if (strcmp("/planeready", cmdtext, true, 10) == 0){
		if(JobPilot[playerid] == 1){
			new string[256];
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string),"Pilot %s Is Now On Duty, You Can Call A Plane /callplane",name);
			SendClientMessageToAll(COLOR_YELLOW, string);
			PlaneReady[playerid] = 1;
		}
		return 1;
	}

	if(strcmp(cmd, "/calltaxi", true) == 0) {
		new string[256];
		new message[256];
		new playername[256];
 		strmid(message, cmdtext, 8, strlen(cmdtext));
 		GetPlayerName(playerid, playername, sizeof(playername));
    	if(!strlen(message)) {
			SendClientMessage(playerid, COLOR_RED, "Usage: /calltaxi [Location]");
			return 1;
		}
		format(string, sizeof(string), "%s Needs a Taxi at %s", playername,message);
		SendTaxiReadyMessage(COLOR_BLUE,string);
		
		return 1;
	}
	
	if(strcmp(cmd, "/000", true) == 0) {
		new string[256];
		new message[256];
		new playername[256];
 		strmid(message, cmdtext, 3, strlen(cmdtext));
 		GetPlayerName(playerid, playername, sizeof(playername));
    	if(!strlen(message)) {
			SendClientMessage(playerid, COLOR_RED, "Usage: /000 [Reason]");
			return 1;
		}
		format(string, sizeof(string), "%s Dialed 000 because %s! HELP!", playername,message);
		Send000Message(COLOR_BLUE,string);

		return 1;
	}
	
	if(strcmp(cmd, "/callplane", true) == 0) {
		new string[256];
		new message[256];
		new playername[256];
 		strmid(message, cmdtext, 8, strlen(cmdtext));
 		GetPlayerName(playerid, playername, sizeof(playername));
    	if(!strlen(message)) {
			SendClientMessage(playerid, COLOR_RED, "Usage: /callplane [Location]");
			return 1;
		}
		format(string, sizeof(string), "%s Needs a Taxi at %s", playername,message);
		SendTaxiReadyMessage(COLOR_BLUE,string);
		PlaneReady[playerid] = 3;

		return 1;
	}
	
	if(strcmp(cmd, "/find", true) == 0) {
		new tmp[256];
		new giveplayer[MAX_PLAYER_NAME];

		if(TaxiReady[playerid] == 1){
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, "USAGE: /find [Playerid]");
				return 1;
			}
		giveplayerid = ReturnUser(tmp);
		if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			        if(giveplayerid == playerid) {
				        if(TaxiReady[playerid] == 3){

	   				    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						new Float:X,Float:Y,Float:Z;
						GetPlayerPos(giveplayerid, X,Y,Z);
						SetPlayerCheckpoint(playerid, X,Y,Z, 5);
						}
						else
						{
						SendClientMessage(playerid, COLOR_RED, "  This Person Has Not Called For A Taxi! !");
						}
					}
				}
				else
			{
			    SendClientMessage(playerid, COLOR_RED, "Invalid ID");
			}
		}
  	}
}

	if (strcmp("/planeready", cmdtext, true, 10) == 0){
		if(JobPilot[playerid] == 1){
			new string[256];
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string),"Taxi Driver %s Is Now On Duty, You Can Call A Taxi /calltaxi",name);
			SendClientMessageToAll(COLOR_YELLOW, string);
			PlaneReady[playerid] = 1;
		}
		return 1;
	}
	if (strcmp("/callplane", cmdtext, true, 10) == 0){
		if(JobPilot[playerid] == 1){
			new string[256];
			GetPlayerName(playerid,name,sizeof(name));
			format(string,sizeof(string)," %s Wants A Plane!",name);
			SendPlaneReadyMessage(COLOR_YELLOW, string);
		}
		return 1;
	}
	if (strcmp("/findoff", cmdtext, true, 10) == 0){
		DisablePlayerCheckpoint(playerid);
		return 1;
	}
	
	return 1;
}

public OnPlayerInfoChange(playerid)
{
return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid,newstate,oldstate)
{
	if(newstate==PLAYER_STATE_PASSENGER){
		new  VID=GetPlayerVehicleID(playerid);
		if(GetVehicleModel(VID) == 420 || GetVehicleModel(VID) == 438){
     	   if(TaxiReady[playerid] == 3){
      	      DisablePlayerCheckpoint(playerid);
      	      SendClientMessage(playerid, COLOR_BLUE, "Where May I Take You?");
     		}
  		}
	}

	if(newstate==PLAYER_STATE_DRIVER){
		new  VID=GetPlayerVehicleID(playerid);
		if(GetVehicleModel(VID) == 599 || GetVehicleModel(VID) == 598 || GetVehicleModel(VID) == 597 || GetVehicleModel(VID) == 596){
     	   if(JobCop[playerid] == 1){
      	      RemovePlayerFromVehicle(playerid);
      	      SendClientMessage(playerid, COLOR_RED, "You Are Not A Police Officer!.");
     		}
  		}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(Jobcp[playerid] == 0) { Jobcp[playerid] = 1; DisablePlayerCheckpoint(playerid);
	}
	else if(Jobcp[playerid] == 11){
	SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM JOB-LINK#");
	SendClientMessage(playerid, COLOR_PURPLE, "Welcome To The Police Force");
	DisablePlayerCheckpoint(playerid);
	JobCop[playerid] = 1;
 	}/*
 	else if(Jobcp[playerid] == 12){
	SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM JOB-LINK#");
	SendClientMessage(playerid, COLOR_PURPLE, "Welcome To The Agentcy");
	DisablePlayerCheckpoint(playerid);
	JobAgent[playerid] = 1;
 	}
 	else if(Jobcp[playerid] == 13){
	SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM JOB-LINK#");
	SendClientMessage(playerid, COLOR_PURPLE, "Welcome To The Health System");
	DisablePlayerCheckpoint(playerid);
	JobMedic[playerid] = 1;
 	}
 	else if(Jobcp[playerid] == 14){
	SendClientMessage(playerid, COLOR_PURPLE, "#MESSAGE FROM JOB-LINK#");
	SendClientMessage(playerid, COLOR_PURPLE, "Welcome To The Fire Brigade");
	DisablePlayerCheckpoint(playerid);
	JobFire[playerid] = 4;
 	}
	*/
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public MedicCheck(playerid)
{
	new playername2[MAX_PLAYER_NAME];
	new storedmedicname[64];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("Medic.cfg", io_read);
	if (file)
	{
		new valtmp[MAX_PLAYER_NAME];
		while (fread(file, valtmp) > 0)
		{
			//printf("%s",valtmp);
			strmid(storedmedicname, valtmp, 0, strlen(playername2), 255);
			if ((strcmp(storedmedicname, playername2, true, strlen(playername2)) == 0) && (strlen(playername2) == strlen(storedmedicname)))
			{
				fclose(file);
				return 1;
			}
		}
	}
	fclose(file);
	return 0;
}

public MedicMake(playerid)
{
	new playername2[MAX_PLAYER_NAME];
	new string[255];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("Medic.cfg", io_append);
	format(string,sizeof(string),"%s",playername2);
	fwrite(file,string);
	fclose(file);
	return 1;
}
public MedicQuit(playerid)
{
	new playername2[MAX_PLAYER_NAME];
	new string[255];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("Medic.cfg", io_append);
	format(string,sizeof(string),"%s",playername2);
 	fdeleteline("Medic.cfg", string);
	fclose(file);
	return 1;
}
public FireCheck(playerid)
{
	new playername2[MAX_PLAYER_NAME];
	new storedfirename[64];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("Fire.cfg", io_read);
	if (file)
	{
		new valtmp[MAX_PLAYER_NAME];
		while (fread(file, valtmp) > 0)
		{
			//printf("%s",valtmp);
			strmid(storedfirename, valtmp, 0, strlen(playername2), 255);
			if ((strcmp(storedfirename, playername2, true, strlen(playername2)) == 0) && (strlen(playername2) == strlen(storedfirename)))
			{
				fclose(file);
				return 1;
			}
		}
	}
	fclose(file);
	return 0;
}

public FireMake(playerid)
{
	new playername2[MAX_PLAYER_NAME];
	new string[255];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("Fire.cfg", io_append);
	format(string,sizeof(string),"%s",playername2);
	fwrite(file,string);
	fclose(file);
	return 1;
}

public FireQuit(playerid)
{
	new playername2[MAX_PLAYER_NAME];
	new string[255];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("Fire.cfg", io_append);
	format(string,sizeof(string),"%s",playername2);
 	fdeleteline("Fire.cfg", string);
	fclose(file);
	return 1;
}
public CopCheck(playerid)
{
	new playername2[MAX_PLAYER_NAME];
	new storedcopname[64];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("Cop.cfg", io_read);
	if (file)
	{
		new valtmp[MAX_PLAYER_NAME];
		while (fread(file, valtmp) > 0)
		{
			//printf("%s",valtmp);
			strmid(storedcopname, valtmp, 0, strlen(playername2), 255);
			if ((strcmp(storedcopname, playername2, true, strlen(playername2)) == 0) && (strlen(playername2) == strlen(storedcopname)))
			{
				fclose(file);
				return 1;
			}
		}
	}
	fclose(file);
	return 0;
}

public CopMake(playerid)
{
	new playername2[MAX_PLAYER_NAME];
	new string[255];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("Cop.cfg", io_append);
	format(string,sizeof(string),"%s",playername2);
	fwrite(file,string);
	fclose(file);
	return 1;
}

public CopQuit(playerid)
{
	new playername2[MAX_PLAYER_NAME];
	new string[255];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("Cop.cfg", io_append);
	format(string,sizeof(string),"%s",playername2);
 	fdeleteline("Cop.cfg", string);
	fclose(file);
	return 1;
}


public AgentCheck(playerid)
{
	new playername2[MAX_PLAYER_NAME];
	new storedagentname[64];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("Agent.cfg", io_read);
	if (file)
	{
		new valtmp[MAX_PLAYER_NAME];
		while (fread(file, valtmp) > 0)
		{
			//printf("%s",valtmp);
			strmid(storedagentname, valtmp, 0, strlen(playername2), 255);
			if ((strcmp(storedagentname, playername2, true, strlen(playername2)) == 0) && (strlen(playername2) == strlen(storedagentname)))
			{
				fclose(file);
				return 1;
			}
		}
	}
	fclose(file);
	return 0;
}

public AgentMake(playerid)
{
	new playername2[MAX_PLAYER_NAME];
	new string[255];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("Agent.cfg", io_append);
	format(string,sizeof(string),"%s",playername2);
	fwrite(file,string);
	fclose(file);
	return 1;
}


public AgentQuit(playerid)
{
	new playername2[MAX_PLAYER_NAME];
	new string[255];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("Agent.cfg", io_append);
	format(string,sizeof(string),"%s",playername2);
	fdeleteline("Agent.cfg", string);
	fclose(file);
	return 1;
}
public PilotCheck(playerid)
{
	new playername2[MAX_PLAYER_NAME];
	new storedagentname[64];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("Pilot.cfg", io_read);
	if (file)
	{
		new valtmp[MAX_PLAYER_NAME];
		while (fread(file, valtmp) > 0)
		{
			//printf("%s",valtmp);
			strmid(storedagentname, valtmp, 0, strlen(playername2), 255);
			if ((strcmp(storedagentname, playername2, true, strlen(playername2)) == 0) && (strlen(playername2) == strlen(storedagentname)))
			{
				fclose(file);
				return 1;
			}
		}
	}
	fclose(file);
	return 0;
}

public PilotMake(playerid)
{
	new playername2[MAX_PLAYER_NAME];
	new string[255];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("Pilot.cfg", io_append);
	format(string,sizeof(string),"%s",playername2);
	fwrite(file,string);
	fclose(file);
	return 1;
}


public PilotQuit(playerid)
{
	new playername2[MAX_PLAYER_NAME];
	new string[255];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("Pilot.cfg", io_append);
	format(string,sizeof(string),"%s",playername2);
	fdeleteline("Pilot.cfg", string);
	fclose(file);
	return 1;
}
public TaxiCheck(playerid)
{
	new playername2[MAX_PLAYER_NAME];
	new storedagentname[64];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("Taxi.cfg", io_read);
	if (file)
	{
		new valtmp[MAX_PLAYER_NAME];
		while (fread(file, valtmp) > 0)
		{
			//printf("%s",valtmp);
			strmid(storedagentname, valtmp, 0, strlen(playername2), 255);
			if ((strcmp(storedagentname, playername2, true, strlen(playername2)) == 0) && (strlen(playername2) == strlen(storedagentname)))
			{
				fclose(file);
				return 1;
			}
		}
	}
	fclose(file);
	return 0;
}

public TaxiMake(playerid)
{
	new playername2[MAX_PLAYER_NAME];
	new string[255];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("Taxi.cfg", io_append);
	format(string,sizeof(string),"%s",playername2);
	fwrite(file,string);
	fclose(file);
	return 1;
}


public TaxiQuit(playerid)
{
	new playername2[MAX_PLAYER_NAME];
	new string[255];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("Taxi.cfg", io_append);
	format(string,sizeof(string),"%s",playername2);
	fdeleteline("Taxi.cfg", string);
	fclose(file);
	return 1;
}
public fdeleteline(filename[], line[]){
	if(fexist(filename)){
		new temp[256];
		new File:fhandle = fopen(filename,io_read);
		fread(fhandle,temp,sizeof(temp),false);
		if(strfind(temp,line,true)==-1){return 0;}
		else{
			fclose(fhandle);
			fremove(filename);
			for(new i=0;i<strlen(temp);i++){
				new templine[256];
				strmid(templine,temp,i,i+strlen(line));
				if(strcmp(templine, line, true) == 0){
					strdel(temp,i,i+strlen(line));
					fcreate(filename);
					fhandle = fopen(filename,io_write);
					fwrite(fhandle,temp);
					fclose(fhandle);
					return 1;
				}
			}
		}
	}
	return 0;
}
public fcreate(filename[]) {
	if (fexist(filename)){return false;}
	new File:fhandle = fopen(filename,io_write);
	fclose(fhandle);
	return true;
}
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
/*
SendCopMessage(color, text[]) {
    for(new i = 0; i < MAX_PLAYERS; i ++) {
    	if(IsPlayerConnected(i)) {
	    	if(Job[i] == 5) {
	           	SendClientMessage(i, color, text);
            }
        }
    }
}
SendMedicMessage(color, text[]) {
    for(new i = 0; i < MAX_PLAYERS; i ++) {
    	if(IsPlayerConnected(i)) {
	    	if(Job[i] == 5) {
     			SendClientMessage(i, color, text);
            }
        }
    }
}
SendAgentMessage(color, text[]) {
    for(new i = 0; i < MAX_PLAYERS; i ++) {
    	if(IsPlayerConnected(i)) {
	    	if(Job[i] == 5) {
     			SendClientMessage(i, color, text);
            }
        }
    }
}
SendFireMessage(color, text[]) {
    for(new i = 0; i < MAX_PLAYERS; i ++) {
    	if(IsPlayerConnected(i)) {
	    	if(Job[i] == 6) {
     			SendClientMessage(i, color, text);
            }
        }
    }
}*/
Send000Message(color, text[]) {
    for(new i = 0; i < MAX_PLAYERS; i ++) {
    	if(IsPlayerConnected(i)) {
	    	if(Job[i] == 1 || Job[i] == 2 || Job[i] == 4) {
     			SendClientMessage(i, color, text);
            }
        }
    }
}
SendPlaneReadyMessage(color, text[]) {
    for(new i = 0; i < MAX_PLAYERS; i ++) {
    	if(IsPlayerConnected(i)) {
	    	if(Job[i] == 5) {
		    	if(TaxiReady[i] == 1){
	            	SendClientMessage(i, color, text);
				}
            }
        }
    }
}
SendTaxiReadyMessage(color, text[]) {
    for(new i = 0; i < MAX_PLAYERS; i ++) {
    	if(IsPlayerConnected(i)) {
	    	if(Job[i] == 5) {
		    	if(TaxiReady[i] == 1){
	            	SendClientMessage(i, color, text);
				}
            }
        }
    }
}


/*
public change(playerid)
{
if (gTeam[playerid] == TEAM_COP){
Job[playerid] = 1;
}
else if (gTeam[playerid] == TEAM_MEDIC){
Job[playerid] = 2;
}
else if (gTeam[playerid] == TEAM_AGENT){
Job[playerid] = 3;
}
else if (gTeam[playerid] == TEAM_FIRE){
Job[playerid] = 4;
}
else if (gTeam[playerid] == TEAM_TAXI){
Job[playerid] = 5;
}
else if (gTeam[playerid] == TEAM_PILOT){
Job[playerid] = 6;
}
return 1;
}

stock GetPlayerArea(playerid)
{
	new pid = GetPlayerInteriorID(playerid);
	new retstr[256];
	if(pid != 0) format(retstr,sizeof(retstr),"%s",interiors[pid][INTERIOR_NAME]);
	else format(retstr,sizeof(retstr),"%s",zones[GetPlayerZone(playerid)][MAPZONE_NAME]);
	return retstr;
}*/

ReturnUser(text[], id = INVALID_PLAYER_ID)
	{
	for(new i =0; i < MAX_PLAYERS;i++){
	    if(IsPlayerConnected(i))
	    {
		new pName[MAX_PLAYER_NAME];
		GetPlayerName(i,pName,MAX_PLAYER_NAME);
		if (strfind(pName,text,true)==0)
			{
				return i;
			}
		}
		else
	id = INVALID_PLAYER_ID;
		return id;
	}
	return 1;
}

