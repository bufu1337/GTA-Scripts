#include <a_samp>
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_WHITE 0xFFFFFFAA
forward Alarm();
forward SA();
forward finishClaim();
new ClaimStarted;
new PlayerWroteSubject[MAX_PLAYERS];
new ClaimSubject[256];
new PlayerWroteN[MAX_PLAYERS];
new PlayerWroteP[MAX_PLAYERS];
new Rnegative[256];
new Rpositive[256];
new PlayerClaimed[MAX_PLAYERS];
new TotalReponseN;
new TotalReponseP;
new PlayerAC[MAX_PLAYERS];
new FC;
public OnFilterScriptInit(){
	print("\n======================================");
	print(" Claiming_system Filterscript by James_Alex");
	print("======================================\n");
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[]){
	new string[256];
	if (strcmp("/startclaim", cmdtext, true, 10) == 0)	{
		if(IsPlayerConnected(playerid))
		{
		    if(ClaimStarted == 0)
		    {
				ClaimStarted = 1;
				SendClientMessage(playerid, COLOR_YELLOW, "You succefully started a claim, now press 'T' or 'F6' and wrote your claim subject.");
				PlayerWroteSubject[playerid] = 1;
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "There is already a claim started !");
			    return 1;
			}
		}
		return 1;
	}
	if (strcmp("/claim", cmdtext, true, 10) == 0){
		if(IsPlayerConnected(playerid))
		{
			if(ClaimStarted == 1)
			{
				if(PlayerClaimed[playerid] == 0)
	    		{
	        		SendClientMessage(playerid, COLOR_YELLOW, "now press 'T' or 'F6' and wrote your reponse");
                    PlayerClaimed[playerid] = 1;
				}
     			else
     			{
     	    		SendClientMessage(playerid, COLOR_YELLOW, "You have already claimed");
     	    		return 1;
				}
		 	}
     		else
     		{
     	    	SendClientMessage(playerid, COLOR_YELLOW, "There aren't a claim started");
     	    	return 1;
   	 		}
   	 	}
 	}
	if (strcmp("/totalclaims", cmdtext, true, 10) == 0){
		if(ClaimStarted == 1)
		{
		    format(string, sizeof(string), "%s: %d | %s: %d", Rnegative, TotalReponseN, Rpositive, TotalReponseP);
	    	SendClientMessage(playerid, COLOR_WHITE, string);
	    }
	    else
	    {
	    	SendClientMessage(playerid, COLOR_LIGHTRED, "There is not claim started");
	    	return 1;
	    }
	}
	return 0;
}
public OnPlayerConnect(playerid){
	PlayerWroteSubject[playerid] = 0;
	PlayerWroteN[playerid] = 0;
	PlayerWroteP[playerid] = 0;
	PlayerClaimed[playerid] = 0;
	PlayerAC[playerid] = 0;
	return 1;
}
public OnPlayerText(playerid, text[]){
	if(PlayerWroteSubject[playerid] == 1)
	{
		format(ClaimSubject,256,"%s",text);
		PlayerWroteSubject[playerid] = 0;
        PlayerWroteN[playerid] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "now wrote the negative reponse");
		return 0;
	}
	else if(PlayerWroteN[playerid] == 1)
	{
		format(Rnegative, sizeof(Rnegative), "%s", text);
		PlayerWroteN[playerid] = 0;
        PlayerWroteP[playerid] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "now wrote the positive reponse");
		return 0;
	}
	else if(PlayerWroteP[playerid] == 1)
	{
		new plname[MAX_PLAYER_NAME];
		new string[256];
		new stringb[256];
		format(Rpositive, sizeof(Rpositive), "%s", text);
		GetPlayerName(playerid, plname, sizeof(plname));
		format(string, sizeof(string), "%s has started a claim, (/claim) to claim for him, subject ==>%s<==.", plname, ClaimSubject);
		SendClientMessageToAll(COLOR_GREEN, string);
		format(stringb, sizeof(stringb), "%s claim, Positive reponse '%s', Negative reponse '%s'.", plname, Rpositive, Rnegative);
		SendClientMessageToAll(COLOR_GREEN, stringb);
		PlayerWroteP[playerid] = 0;
		FC = SetTimer("finishClaim", 120000, 0);
		return 0;
	}
    else if(strcmp(text, Rpositive, true) == 0)
	{
		if(PlayerClaimed[playerid] == 1)
		{
		if(PlayerAC[playerid] == 0)
		{
			TotalReponseP += 1;
			SendClientMessage(playerid, COLOR_YELLOW, "your positive reponse has been taken");
			PlayerAC[playerid] = 1;
			return 0;
		}
		}
	}
 	else if(strcmp(text, Rnegative, true) == 0)
	{
		if(PlayerClaimed[playerid] == 1)
		{
		if(PlayerAC[playerid] == 0)
		{
			TotalReponseN += 1;
			SendClientMessage(playerid, COLOR_YELLOW, "your negative reponse has been taken");
			PlayerAC[playerid] = 1;
			return 0;
		}
		}
	}
	return 1;
}
public finishClaim(){
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	ClaimStarted = 0;
	PlayerAC[i] = 0;
	PlayerClaimed[i] = 0;
	new string[256];
	SendClientMessageToAll(COLOR_GREEN, "the claim has been finished with that score");
 	format(string, sizeof(string), "%s: %d | %s: %d", Rnegative, TotalReponseN, Rpositive, TotalReponseP);
 	SendClientMessageToAll(COLOR_WHITE, string);
 	KillTimer(FC);
	return 1;
	}
	return 1;
}


