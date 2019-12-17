/*============================================================================
|                        >>>   Cale's Votekick   <<<                          |
|                                   System                                    |
|                    Version 1                  Date: 10/9/2010               |
|                                                                             |
==============================================================================*/
#define FILTERSCRIPT
#include <a_samp>

#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define GREY 0xAFAFAFAA
#define GREEN 0x33AA33AA
#define YELLOW 0xFFFF00AA
#define WHITE 0xFFFFFFAA
#define LIGHTBLUE 0x33CCFFAA
#define ORANGE 0xFF9900AA
new Votes = 0;
new Voted[MAX_PLAYERS];
new VoteActive;
new thingy;
new VPlayers;
new KickName[24];
new PlayerName[24];
new IDofotherplayer;
forward CountDownTimer(playerid);
new Count;
new Timer;
new Text:TCountDown;

//====Text-Draw====//
new Text:VoteKick;
#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

#endif

public OnPlayerConnect(playerid)
{
	Voted[playerid] = 0;
	return 1;
}
public CountDownTimer(playerid)
{
	new string[3];
	Count--;
	TextDrawDestroy(TCountDown);
	format(string,sizeof(string),"%d",Count);
	TCountDown = TextDrawCreate(300.0,300.0,string);

	TextDrawTextSize(TCountDown,0.7,3.0);
	TextDrawShowForAll(TCountDown);
	
	if(Count == 0)
	{
		KillTimer(Timer);
		KillTimer(thingy);
		TextDrawDestroy(TCountDown);
		TextDrawDestroy(VoteKick);
		Voted[playerid] = 0;
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(votekick,8,cmdtext);
	dcmd(vote,4,cmdtext);
	dcmd(stopvote,8,cmdtext);
	return 0;
}
dcmd_stopvote(playerid,params[])
{
	#pragma unused params
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,LIGHTBLUE,"You are not an admin!");
	TextDrawDestroy(TCountDown);
	TextDrawDestroy(VoteKick);
	KillTimer(Timer);
	KillTimer(thingy);
	SendClientMessageToAll(0xFF0000FF,"An admin has stopped the vote kick.");
	return 1;
}
dcmd_votekick(playerid,params[])
{
	new id,n[24],on[24],str2[128],string[3];
	new tmp[256], tmp2[256], Index,str[128];
	VPlayers = GetPlayersOnServer()/2+1;
	if(GetPlayersOnServer() <= 2) return SendClientMessage(playerid,GREY,"There needs to be atleast 3 people online to use this command.");
	tmp = strtok(params,Index), tmp2 = strtok(params,Index),id = strval(tmp);
	if(IsPlayerAdmin(id)) return SendClientMessage(playerid,0xFF0000FF,"You cannot use the vote-kick feature on an admin!");
	if(VoteActive == 1) return SendClientMessage(playerid,0xFF0000FF,"There is already a votekick in proccess, please wait untill it is finished");
	IDofotherplayer = id;
	GetPlayerName(playerid,n,24),GetPlayerName(id,on,24);
	Voted[playerid] = 1;
	KickName = on;
	PlayerName = n;
	if(!strlen(params)) return SendClientMessage(playerid,GREY,"USAGE: /votekick <ID> <Reason>");
	if(!IsPlayerConnected(id))return SendClientMessage(playerid,GREY,"You have entered an incorrect ID.");
	Votes = 1;
	VoteActive = 1;
	format(str2,sizeof(str2),"~r~Votekick on ~w~%s. ~r~%d/%d",PlayerName,Votes,VPlayers);
	VoteKick = TextDrawCreate(50.0,300.0,str2);
	TextDrawLetterSize(VoteKick,0.5,2.5);
	TextDrawShowForAll(VoteKick);
	thingy = SetTimer("VoteFail",21000,false);
	Timer = SetTimer("CountDownTimer",1000,true);
	format(str,sizeof(str),"%s has started a votekick on %s. Reason: %s",n,on,params[2]);
	SendClientMessageToAll(0xFF0000FF,str);
	format(string,sizeof(string),"%d",Count);
	TCountDown = TextDrawCreate(300.0,300.0,string);
	Count = 21;
	return 1;
}
dcmd_vote(playerid,params[])
{
	#pragma unused params
	new str[128],name[24],str2[128];
	GetPlayerName(playerid,name,24);
	if(VoteActive == 0) return SendClientMessage(playerid,GREY,"There is no active vote kick on right now.");
	if(Voted[playerid] == 1) return SendClientMessage(playerid,LIGHTBLUE,"You have already voted!");
	KillTimer(thingy);
	thingy = SetTimer("VoteFail",21000,false);
	Votes++;
	Voted[playerid] = 1;
	format(str,sizeof(str),"%s has voted. %d/%d",name,Votes,VPlayers);
	SendClientMessageToAll(0xFF0000FF,str);
	TextDrawDestroy(VoteKick);
	format(str2,sizeof(str),"~r~Votekick on ~w~%s. ~r~%d/%d",KickName,Votes,VPlayers);
	TextDrawCreate(50.0,300,str2);
	TextDrawLetterSize(VoteKick,0.5,2.5);
	TextDrawShowForAll(VoteKick);
	KillTimer(Timer);
	Timer = SetTimer("CountDownTimer",1000,true);
	Count = 21;
	if(Votes == VPlayers)
	{
		format(str,sizeof(str),"%s has been kicked. %d/%d votes.",KickName,Votes,Votes);
		SendClientMessageToAll(0xFF0000FF,str);
		TextDrawDestroy(VoteKick);
		KillTimer(thingy);
		VoteActive = 0;
		Kick(IDofotherplayer);
	    return 1;
	}
	return 1;
}
	
forward VoteFail(playerid);
public VoteFail(playerid)
{
	Votes = 0;
	VoteActive = 0;
	Voted[playerid] = 0;
	SendClientMessageToAll(LIGHTBLUE,"There were not enough votes for the vote-kick.");
	TextDrawDestroy(VoteKick);
	return 1;
}

GetPlayersOnServer()
{
	new count;
	for(new x=0; x< MAX_PLAYERS; x++)
	{
 		if(IsPlayerConnected(x))
	  	{
			count++;
		}
	}
	return count;
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

