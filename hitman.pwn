#include <a_samp>
#include <dutils>

new bounty[MAX_PLAYERS];
new bounty2[MAX_PLAYERS][MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("----------------------------------");
	print(" Bounty system - by kevinsoftware");
	print("     kevinsoftware@live.nl");
	print("----------------------------------");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	bounty[playerid]=0;
	for(new i=0; i<MAX_PLAYERS; i++){
		bounty2[playerid][i]=0;
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    bounty[playerid]=0;
	for(new i=0; i<MAX_PLAYERS; i++){
		bounty2[playerid][i]=0;
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new string[256];
	new playername[28],killername[28];
	GetPlayerName(playerid,playername,28);
	GetPlayerName(killerid,killername,28);
	if(killerid != INVALID_PLAYER_ID) {
		if(bounty[playerid]>0){
		    format(string,256,"* %s earned $%d for bounty-kill %s.",killername,bounty[playerid],playername);
			SendClientMessageToAll(0xFF800000,string);
			GivePlayerMoney(killerid,bounty[playerid]);
			bounty[playerid]=0;
			for(new i=0; i<MAX_PLAYERS; i++){
				bounty2[i][playerid]=0;
			}
		}
 	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new tmp[256];
	new idx;
	new b_cmd[256];
	new b_data1,b_data2;
	new string[256];
	new playername[28],killername[28];
	b_cmd = strtok(cmdtext,idx);
	if (strcmp("/hitman", b_cmd, true, 6) == 0){
		tmp = strtok(cmdtext,idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, 0xFF800000, "USAGE: /hitman [playerid] [ammount]");
			return 1;
		}
		b_data1 = strval(tmp);

		tmp = strtok(cmdtext,idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, 0xFF800000, "USAGE: /hitman [playerid] [ammount]");
			return 1;
		}
		b_data2 = strval(tmp);
		if(!IsPlayerConnected(b_data1)){
		    format(string,256,"* %d is not a connected player.",b_data1);
		    SendClientMessage(playerid,0xFF800000,string);
		    return 1;
		}
		if(b_data2>GetPlayerMoney(playerid)){
		    format(string,256,"* You dont have $%d.",b_data2);
		    SendClientMessage(playerid,0xFF800000,string);
		    return 1;
		}
		if(b_data2<0){
		    format(string,256,"* WTF what are you doing you can steal cash :)");
		    SendClientMessage(playerid,0xFF800000,string);
		    return 1;
		}
		GivePlayerMoney(playerid,-b_data2);
		GetPlayerName(playerid,playername,28);
		GetPlayerName(b_data1,killername,28);
		bounty2[playerid][b_data1] = bounty2[playerid][b_data1] + b_data2;
		bounty[b_data1] = bounty[b_data1] + b_data2;
		format(string,256,"* %s has $%d bounty on his head (%s add $%d).",killername,bounty[b_data1],playername,b_data2);
        SendClientMessage(playerid,0xFF800000,string);
    	return 1;
	}

	if (strcmp("/forgive", b_cmd, true, 6) == 0){
		tmp = strtok(cmdtext,idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, 0xFF800000, "USAGE: /forgive [playerid]");
			return 1;
		}
		b_data1 = strval(tmp);

		if(!IsPlayerConnected(b_data1)){
		    format(string,256,"* %d is not a connected player.",b_data1);
		    SendClientMessage(playerid,0xFF800000,string);
		    return 1;
		}
		if(bounty2[playerid][b_data1]<1){
		    format(string,256,"* You dont have post a bounty on him");
		    SendClientMessage(playerid,0xFF800000,string);
		    return 1;
		}
		GivePlayerMoney(playerid,bounty2[playerid][b_data1]);
		GetPlayerName(playerid,playername,28);
		GetPlayerName(b_data1,killername,28);
		bounty[b_data1] = bounty[b_data1] - bounty2[playerid][b_data1];
		bounty2[playerid][b_data1]=0;
		format(string,256,"* %s has been forgiven by %s for $%d",killername,playername,bounty2[playerid][b_data1]);
        SendClientMessage(playerid,0xFF800000,string);
    	return 1;
	}

	return 0;
}