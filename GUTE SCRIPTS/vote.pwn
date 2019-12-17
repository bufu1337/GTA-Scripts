#include <a_samp>
//==============================================================================
#define LARANJA 			0xFF6600AA
#define VERDECLARO 			0x00FF0CAA
#define VERDEMEDIO          0xa5b1A3AA
#define BRANCO              0xFFFFFFAA
#define VERMELHO            0xFF0000AA
#define VERDEFRACO        	0x80cf80AA
//==============================================================================
enum e_votacao
{
	bool:iniciada,
	sim,
	nao,
	total
}
new votacao[e_votacao];
new votou[MAX_PLAYERS];
//==============================================================================
public OnFilterScriptInit()
{
	print("===================================");
	print("==>>  Filter Script of Vote!   <<==");
	print("==>> Created by [CCV]saalada[] <<==");
	print("==>>  Help of Flavio Toribio   <<==");
	print("==>>   Version ENG 0.1 BETA    <<==");
	print("==>>  www.ccvteam.com/forum    <<==");
	print("===================================");
	return 1;
}
//==============================================================================
public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[256];
	if(!strcmp(cmdtext, "/vote", true,5))
	{
		if(IsPlayerAdmin(playerid))
		{
		    if(!votacao[iniciada])
		    {
   		 		if(!strlen(cmdtext[6]))
		        	return SendClientMessage(playerid,0xFFFFFFAA, "Usage: /vote [question]");
				SendClientMessageToAll(LARANJA,"====================================");
				format(string, sizeof string, "==> New Vote: %s?", cmdtext[6]);
				SendClientMessageToAll(VERDECLARO, string);
				SendClientMessageToAll(LARANJA,"	");
				SendClientMessageToAll(LARANJA," > To vote type:");
				SendClientMessageToAll(VERDEMEDIO, "> /yes - If you agree type.");
				SendClientMessageToAll(VERDEMEDIO, "> /no - If you disagree type.");
				SendClientMessageToAll(LARANJA,"====================================");
				votacao[iniciada] = true;
				votacao[sim] = 0;
				votacao[nao] = 0;
				GameTextForAll("~w~New ~r~vote~w~ was~b~ created!",6000,3);
				for(new i; i <MAX_PLAYERS; i++)
				{
					votou[i] = false;
				}
			} else {
				SendClientMessage(playerid,BRANCO,"Already there is a vote in progress!");
			}
		} else {
			SendClientMessage(playerid,BRANCO,"You do not have permission to use this command!");
		}
		return 1;
	}
	if(!strcmp(cmdtext, "/yes", true))
	{
		if(votacao[iniciada] && !votou[playerid])
		{
			SendClientMessage(playerid,LARANJA, "Your vote has been computed successfully!");
			votacao[sim]++;
			votacao[total]++;
			votou[playerid] = true;
			return 1;
		}
		return 0;
	}
	if(!strcmp(cmdtext, "/no", true))
	{
		if(votacao[iniciada] && !votou[playerid])
		{
			SendClientMessage(playerid,LARANJA, "Your vote has been computed successfully!");
			votacao[nao]++;
			votacao[total]++;
			votou[playerid] = true;
			return 1;
		}
		return 0;
	}
	if(!strcmp(cmdtext, "/end", true))
	{
		if(IsPlayerAdmin(playerid))
		{
			if(votacao[iniciada])
			{
			    SendClientMessageToAll(LARANJA,"====================================");
				SendClientMessageToAll(LARANJA, "==> Votacâo encerrada! <<==");
				format(string, sizeof string, "> %d player(es) agreed with the question.", votacao[sim]);
				SendClientMessageToAll(VERDEMEDIO,string);
				format(string, sizeof string, "> %d player(es) disagreed with the question.", votacao[nao]);
				SendClientMessageToAll(VERDEMEDIO, string);
				format(string, sizeof string, "> This vote was %d votes",votacao[total]);
				SendClientMessageToAll(BRANCO, string);
				if(votacao[sim] == votacao[nao])
				{
					SendClientMessageToAll(VERMELHO, "==> There was a tie!");
				} else if(votacao[sim] > votacao[nao])
				{
					SendClientMessageToAll(VERMELHO, "==> Most agreed with the question.");
				} else if(votacao[sim] < votacao[nao])
				{
					SendClientMessageToAll(VERMELHO, "==> Most disagree with the question.");
				}
				SendClientMessageToAll(LARANJA,"====================================");
				GameTextForAll("~r~A Vote~w~ was~r~ ~b~finished!",6000,3);
				votacao[iniciada] = false;
				votacao[sim] = 0;
				votacao[nao] = 0;
				votacao[total] = 0;
				for(new i; i <MAX_PLAYERS; i++)
				{
					votou[i] = false;
				}
			} else {
				SendClientMessage(playerid,BRANCO, "No vote has been created!");
			}
		} else {
			SendClientMessage(playerid,BRANCO, "You do not have permission to use this command!");
		}
		return 1;
	}
	return 0;
}
//==============================================================================
public OnPlayerConnect(playerid)
{
	votou[playerid] = false;
	SendClientMessageToAll(VERDEFRACO,"This server has voting system made by [CCV]saalada[]");
	return 1;
}
//==============================================================================