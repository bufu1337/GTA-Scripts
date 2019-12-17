#include <a_samp>

#define CMD 0x7FFFD4FF

new Version[50] = "VoteKick V0.1";

public OnFilterScriptInit()
{
    print("\n-------------------------------------");
	printf("  %s loaded               ",Version);
	print("      Created by cjllai                ");
	print("-------------------------------------\n");
}

new Voted[100];
new KickPlayer = -1;
new NowVote;
new MinVote;
new Voting;
new KickPlayerTimer;
new VoteTimer;
new reason[256];

public OnPlayerConnect(playerid)
{
    SendClientMessage(playerid,CMD,"Type /votekick can kick player with vote.");
    Voted[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid)
{
   new string[256];
   if(KickPlayer == playerid)
   {
      KillTimer(VoteTimer);
      KillTimer(KickPlayerTimer);
      NowVote = Voting = KickPlayerTimer = 0;
      format(string,256,"%s left the server.Vote cancel.",PN(playerid));
      SendClientMessageToAll(CMD,string);
      for(new i=0;i<100;i++)
      {
	     if(IsPlayerConnected(i))
	     Voted[i] = 0;
      }
      KickPlayer = -1;
   }
   if(Voted[playerid])
   {
	  NowVote--;
	  format(string,256,"%s left the server,the approval vote reduce one.Now vote:%d/%d.",PN(playerid),NowVote,MinVote);
	  SendClientMessageToAll(CMD,string);
   }
   return 1;
}

public OnPlayerCommandText(playerid,cmdtext[])
{
   new string[256];
   new cmd[256];new idx;
   cmd = strtok(cmdtext,idx);
   if(Command(cmd,"/votekick"))
   {
	  if(OnLinePlayers() < 3)
	  {
		 SendClientMessage(playerid,CMD,"Online players not enough!(3 persons at least)");
		 return 1;
	  }
	  if(Voted[playerid] || KickPlayer == playerid)return 0;
	  if(!Voting)
	  {
		 new tmp[256],tmp2[256];
		 tmp = strtok(cmdtext,idx);
		 strmid(tmp2,cmdtext,strlen(tmp)+strlen("/votekick ")+1,strlen(cmdtext));
		 new x;
		 for(new i=0;i<strlen(tmp2);i++)
		 {
			if(tmp2[i] == ' ')
			x++;
		 }
		 if(!strlen(tmp) || !strlen(tmp2) || x == strlen(tmp2))
		 {
			SendClientMessage(playerid,CMD,"USAGE: /votekick [playerid] [reason]");
			return 1;
		 }
		 if(strval(tmp) == playerid)
		 {
		 	SendClientMessage(playerid,CMD,"If you want leave the server,type '/q'.OK?");
			return 1;
		 }
		 if(!IsPlayerConnected(strval(tmp)))
		 {
		 	SendClientMessage(playerid,CMD,"That player not online!");
			return 1;
		 }
		 reason = tmp2;
		 KickPlayer = strval(tmp);
		 Voting = Voted[playerid] = 1;
		 MinVote = OnLinePlayers()/2+1;
		 NowVote++;
		 format(string,256,"%s want to kick %s.Reason:%s.You can type /votekick to vote yes.Now vote:%d/%d.",PN(playerid),PN(strval(tmp)),tmp2,NowVote,MinVote);
		 SendClientMessageToAll(CMD,string);
		 VoteTimer =SetTimer("VoteExitFunc",120000,0);
		 if(!KickPlayerTimer)
		 KickPlayerTimer = SetTimer("KickPlayerFunc",995,0);
      }
	  else
	  {
         MinVote = OnLinePlayers()/2+1;
		 Voted[playerid] = NowVote += 1;
		 format(string,256,"%s vote kick %s.You can type /votekick to vote yes.Now vote:%d/%d.",PN(playerid),PN(KickPlayer),NowVote,MinVote);
		 SendClientMessageToAll(CMD,string);
		 if(NowVote >= MinVote)
		 {
			format(string,256,"%s has been kicked!",PN(KickPlayer));
			SendClientMessageToAll(CMD,string);
            KillTimer(VoteTimer);
            KillTimer(KickPlayerTimer);
            for(new i=0;i<100;i++)
            {
	           if(IsPlayerConnected(i))
	           Voted[i] = 0;
            }
            NowVote = Voting = KickPlayerTimer = 0;
            if(IsPlayerConnected(KickPlayer))
			Kick(KickPlayer);
			KickPlayer = -1;
		 }
	  }
   return 1;
   }
   return 0;
}

public KickPlayerFunc()
{
   if(KickPlayerTimer)
   {
      new string[256];
      format(string,256,"~w~Do you want kick ~r~%s~w~?~n~reason:~r~%s~n~~w~if yes type /votekick.~n~Now vote:%d/%d",PN(KickPlayer),reason,NowVote,MinVote);
      GameTextForAll(string,2000,4);
      if(!IsPlayerConnected(KickPlayer) || OnLinePlayers() < 3)
      {
         KillTimer(KickPlayerTimer);
         KillTimer(VoteTimer);
         for(new i=0;i<100;i++)
         {
	        if(IsPlayerConnected(i))
	        Voted[i] = 0;
         }
         NowVote = Voting = KickPlayerTimer = 0;
         KickPlayer = -1;
      }
      SetTimer("KickPlayerFunc",995,0);
   }
}

public VoteExitFunc()
{
   new string[256];
   KillTimer(KickPlayerTimer);
   KillTimer(VoteTimer);
   for(new i=0;i<100;i++)
   {
	  if(IsPlayerConnected(i))
	  Voted[i] = 0;
   }
   NowVote = Voting = KickPlayerTimer = 0;
   format(string,256,"Kick %s's votes not enough,Vote cancel.",PN(KickPlayer));
   SendClientMessageToAll(CMD,string);
   KickPlayer = -1;
}

strtok(const string[],&index)
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
Command(cmdtext[],cmd[])
{
   if(!strcmp(cmdtext,cmd,true))
   return 1;
   return 0;
}
OnLinePlayers()
{
   new players;
   for(new i=0;i<100;i++)
   if(IsPlayerConnected(i))
   players++;
   return players;
}
PN(playerid)
{
   new pn[24];
   GetPlayerName(playerid,pn,24);
   return pn;
}
