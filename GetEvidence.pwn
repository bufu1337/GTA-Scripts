//FingerPrint system by SourceCode, You need to change the cop variable to integrate
//Check the comment
#include <a_samp>
#include <foreach>
#include <streamer>

new Cop[MAX_PLAYERS];
new killer1[MAX_PLAYERS];
new Float:Xa[MAX_PLAYERS];
new Float:Ya[MAX_PLAYERS];
new O[MAX_PLAYERS];
new Float:Za[MAX_PLAYERS];
new Reason[MAX_PLAYERS];
#define COLOR_RED 0xAA3333FF

public OnPlayerDeath(playerid, killerid, reason)
{
    DestroyDynamicObject(O[playerid]);
	GetPlayerPos(playerid, Xa[playerid], Ya[playerid], Za[playerid]);
    O[playerid] = CreateDynamicObject(3092, Xa[playerid], Ya[playerid], Za[playerid],0, 0, 274);
	Create3DTextLabel("Blood Stains and Fingerprints",0xAA3333AA,Xa[playerid],Ya[playerid],Za[playerid],40.0,0);
	killer1[playerid] = killerid;
	Reason[playerid] = reason;


}

public OnPlayerCommandText(playerid, cmdtext[])
{
    new idx;
    new cmd[128];
	cmd = strtok(cmdtext, idx);
	if(strcmp(cmd, "/getevidence", true) == 0)
    {
            if(Cop[playerid] == 0) //Your own variable u must change it
	        {
	            SendClientMessage(playerid, COLOR_RED, "   You are not a Cop / FBI / Prison Guard !");
	            return 1;
	        }
            foreach (Player, i)
			{
			  if(IsPlayerInRangeOfPoint(playerid, 3, Xa[i], Ya[i], Za[i]))
 			  {

				 new name[128];
				 new string[100]; //Not sure about this size
                 GetPlayerName(killer1[i], name, sizeof(name));
				 format(string, sizeof(string),"The body was murdered by %s , Cause: %s.",name,Reason[i]);
				 SendClientMessage(playerid, COLOR_RED, string);

			  }
			  else
 			  {
                SendClientMessage(playerid, COLOR_RED, "   You are not near any deadbody");
	            return 1;
	          }
			}
	}
	return 0;
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