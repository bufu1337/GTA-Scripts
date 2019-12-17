//////////////////////////////
//         corpse's         //
//           aka            //
//         c-middia         //
//   simple banking script  //
//         credits          //
//   thanks to Draco Blue   //
//     for reg/login,       //
//     dudb & dutils        //
//                          //
//   thanks to jerbob1992   //
//      for bank stuff      //
//                          //
//  you need dudb & dutils  //
//     in pawno/include     //
//////////////////////////////
#include <a_samp>
#include <core>
#include <float>
#include <dutils>
#include <dudb>
#pragma tabsize 0
#define CP_BANK 		0
#define CP_BANK_2 		2
#define CP_BANK_3   	3
#define COLOR_GREY 0xAFAFAFAA  //---grey
#define COLOR_GREEN 0x00AA00AA  //---green
#define COLOR_RED 0xFF0033AA  //--red
#define COLOR_YELLOW 0xFFFF00AA //---yellow
#define COLOR_WHITE 0xFFFFFFAA  //---white
#define COLOR_WHITE2 0xFF4080AA  //---pinky
#define COLOR_LIGHTBLUE 0x33CCFFAA //---light blue
#define COLOR_ORANGE 0xFF9900AA  //---orange
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define GetStringArg(%1,%2) for(new x = 0; getarg(%1,x) != '\0'; x++) %2[x] = getarg(%1,x)
#define COLOR_SYSTEM 0xEFEFF7AA
new PLAYERLIST_authed[MAX_PLAYERS];
forward getCheckpointType(playerID);
forward checkpointUpdate();
forward SendPlayerFormattedText(playerid, const str[], define);
forward SendAllFormattedText(playerid, const str[], define);
forward isPlayerInArea(playerID, Float:data[4]);
new bank[MAX_PLAYERS];
//new pmoney[MAX_PLAYERS];
new playerCheckpoint[MAX_PLAYERS];
new bankcard[MAX_PLAYERS];
#define MAX_POINTS 3
new Float:checkCoords[MAX_POINTS][4] = {
	{-36.5483,-57.9948, -17.2655,-49.2967},    		//BANK
	{-37.2183,-91.8006, -14.1099,-74.6845},      	//BANK_2
	{-34.6621,-31.4095, -2.6782,-25.6232}     		//BANK_3
};
new Float:checkpoints[MAX_POINTS][3] = {
	{-22.2549,-55.6575,1003.5469},
	{-23.0664,-90.0882,1003.5469},
	{-33.9593,-29.0792,1003.5573}
};
new checkpointType[MAX_POINTS] = {
	CP_BANK,
	CP_BANK_2,
	CP_BANK_3
};
#define MAX_GANGS 			20
new gangBank[MAX_GANGS];
new playerGang[MAX_PLAYERS];
main()
{
	print("\n--------------------------------------");
	print("Corpse's Simple Banking FilterScript 0.3");
	print("--------------------------------------\n");
}
//-----
//---
stock SystemMsg(playerid,msg[]) {
   if ((IsPlayerConnected(playerid))&&(strlen(msg)>0)) {
       SendClientMessage(playerid,COLOR_SYSTEM,msg);
   }
   return 1;
}
stock PlayerName(playerid) {
  new name[255];
  GetPlayerName(playerid, name, 255);
  return name;
}
//---
//--
public OnPlayerConnect(playerid) {
 if(udb_Exists(PlayerName(playerid))) return GivePlayerMoney(playerid,dUserINT(PlayerName(playerid)).("money")-GetPlayerMoney(playerid)); SystemMsg(playerid,"Welcome Back, bank soon !.");
 //{
     // Was loggedin, so give cash
//     GivePlayerMoney(playerid,dUserINT(PlayerName(playerid)).("money")-GetPlayerMoney(playerid));
//  }
/*  if (PLAYERLIST_authed[playerid]) {
     // Was loggedin, so save the data!
	 GivePlayerMoney(playerid,dUserINT(PlayerName(playerid)).("money")-GetPlayerMoney(playerid));
  }*/
  PLAYERLIST_authed[playerid]=false;
         bankcard[playerid]=0;
  return false;
}
public OnPlayerDisconnect(playerid)
 {
 if(udb_Exists(PlayerName(playerid))) return dUserSetINT(PlayerName(playerid)).("money",GetPlayerMoney(playerid));
 //{
     // Was loggedin, so save the data!
//	dUserINT(PlayerName(playerid)).("pmoney");
//	dUserSetINT(PlayerName(playerid)).("money",GetPlayerMoney(playerid));
//  }
/*  if (PLAYERLIST_authed[playerid]) {
     // Was loggedin, so save the data!
    dUserSetINT(PlayerName(playerid)).("money",GetPlayerMoney(playerid));
  }*/
  PLAYERLIST_authed[playerid]=false;
         bankcard[playerid]=0;
  return false;
}
//---
//-----
public isPlayerInArea(playerID, Float:data[4])
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerID, X, Y, Z);
	if(X >= data[0] && X <= data[2] && Y >= data[1] && Y <= data[3]) {
		return 1;
	}
	return 0;
}
public checkpointUpdate()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i)) {
	        for(new j=0; j < MAX_POINTS; j++) {
	            if(isPlayerInArea(i, checkCoords[j])) {
	                if(playerCheckpoint[i]!=j) {
	                    DisablePlayerCheckpoint(i);
						SetPlayerCheckpoint(i, checkpoints[j][0],checkpoints[j][1],checkpoints[j][2],2);
						playerCheckpoint[i] = j;
					}
	            } else {
	            	if(playerCheckpoint[i]==j) {
	            	    DisablePlayerCheckpoint(i);
	            	    playerCheckpoint[i] = 999;
         	    	}
	            }
	        }
		}
	}
}
//-----
public getCheckpointType(playerID) {
	return checkpointType[playerCheckpoint[playerID]];
}
//-----
/*
 *  /openaccount password
 *
 */
  dcmd_openaccount(playerid,params[]) {
	// must be in bank checkpoint
    if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK && getCheckpointType(playerid) != CP_BANK_2 && getCheckpointType(playerid) != CP_BANK_3) return SendClientMessage(playerid, COLOR_RED, "You must be at a bank area to use this. ATMs are located in convenience stores.");
    // The command shouldn't work if we already are authed
    if (PLAYERLIST_authed[playerid]) return SystemMsg(playerid,"Already authed.");
    // The command shouldn't work if an account with this
    // nick already exists
    if (udb_Exists(PlayerName(playerid))) return SystemMsg(playerid,"Account already exists, please use '/icard password'.");
    // Did he forgot the password?
    if (strlen(params)==0) return SystemMsg(playerid,"Correct usage: '/openaccount password'");
    // We save the money to the accstate
    if (udb_Create(PlayerName(playerid),params)) return SystemMsg(playerid,"Account successfully created. insert card with '/icard password' now.");
	bankcard[playerid]=0;
    return true;
}
/*
 *  /icard password
 *
 */
  dcmd_icard(playerid,params[]) {
	// must be in bank checkpoint
    if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK && getCheckpointType(playerid) != CP_BANK_2 && getCheckpointType(playerid) != CP_BANK_3) return SendClientMessage(playerid, COLOR_ORANGE, "You must be at a bank area to use this. ATMs are located in convenience stores.");
    // The command shouldn't work if we already are authed
    if (PLAYERLIST_authed[playerid]) return SystemMsg(playerid,"Already authed.");
    // The command shouldn't work if an account with this
    // nick does not exists
    if (!udb_Exists(PlayerName(playerid))) return SystemMsg(playerid,"Account doesn't exist, please use '/openaccount password'.");
    // Did he forgot the password?
    if (strlen(params)==0) return SystemMsg(playerid,"Correct usage: '/icard password'");
    if (udb_CheckLogin(PlayerName(playerid),params)) {
       // icard was correct
       // Following thing is the same like the missing SetPlayerCommand
//       GivePlayerMoney(playerid,dUserINT(PlayerName(playerid)).("bank")-GetPlayerMoney(playerid));
       PLAYERLIST_authed[playerid]=true;
       bankcard[playerid]=1;
       return SystemMsg(playerid,"Successfully authed!");
    }
    // icard was incorrect
    return SystemMsg(playerid,"icard failed!");
 }
//-----
//------
public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[256];
	new cmd[256];
	new moneys, idx;
	cmd = strtok(cmdtext, idx);
	if(strcmp(cmd, "/bank", true) == 0 || strcmp(cmd, "/gbank", true) == 0) {
	    new gang;
	    if(strcmp(cmd, "/gbank", true) == 0)
	        gang = 1;
	    if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK && getCheckpointType(playerid) != CP_BANK_2 && getCheckpointType(playerid) != CP_BANK_3) {
	        SendClientMessage(playerid, COLOR_YELLOW, "You must be at a bank area to use this. ATMs are located in convenience stores.");
			return 1;
		}
		if(bankcard[playerid]==0){
	        SendClientMessage(playerid, COLOR_ORANGE, "/openaccount password to start account, /icard password to use account.");
			return 1;
		}
		if(gang && playerGang[playerid]==0) {
			SendClientMessage(playerid, COLOR_RED, "You are not in a gang!");
			return 1;
		}
		new tmp[256];
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /bank [amount]");
			return 1;
	    }
	    moneys = strval(tmp);
	    if(moneys < 1) {
			SendClientMessage(playerid, COLOR_YELLOW, "Hey what are you trying to pull here.");
			return 1;
		}
		if(GetPlayerMoney(playerid) < moneys) {
			moneys = GetPlayerMoney(playerid);
		}
		GivePlayerMoney(playerid, 0-moneys);
		if(gang)
			gangBank[playerGang[playerid]]+=moneys;
		else
			bank[playerid] = dUserINT(PlayerName(playerid)).("bank");
			bank[playerid]+=moneys;
			dUserSetINT(PlayerName(playerid)).("bank", bank[playerid]);
		if(gang)
			format(string, sizeof(string), "You have deposited $%d, your gang's balance is $%d.", moneys, gangBank[playerGang[playerid]]);
		else
			bank[playerid] = dUserINT(PlayerName(playerid)).("bank");
			format(string, sizeof(string), "You have deposited $%d, your current balance is $%d.", moneys, bank[playerid]);
			SendClientMessage(playerid, COLOR_GREEN, string);
		return 1;
	}
	//------------------- /withdraw
	if(strcmp(cmd, "/withdraw", true) == 0 || strcmp(cmd, "/gwithdraw", true) == 0) {
	    new gang;
	    if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK && getCheckpointType(playerid) != CP_BANK_2 && getCheckpointType(playerid) != CP_BANK_3) {
	        SendClientMessage(playerid, COLOR_YELLOW, "You must be at a bank area to use this. ATMs are located in convenience stores.");
			return 1;
		}
		if(bankcard[playerid]==0){
	        SendClientMessage(playerid, COLOR_ORANGE, "/openaccount password to start account, /icard password to use account.");
			return 1;
		}
		if(strcmp(cmd, "/gwithdraw", true) == 0)
		    gang = 1;
		if(gang && playerGang[playerid]==0) {
			SendClientMessage(playerid, COLOR_RED, "You are not in a gang!");
			return 1;
		}
	    new tmp[256];
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /(g)withdraw [amount]");
			return 1;
	    }
	    moneys = strval(tmp);

	    if(moneys < 1) {
			SendClientMessage(playerid, COLOR_YELLOW, "Hey what are you trying to pull here.");
			return 1;
		}
	    if(gang) {
			if(moneys > gangBank[playerGang[playerid]])
			    moneys = gangBank[playerGang[playerid]];
	    } else {
			bank[playerid] = dUserINT(PlayerName(playerid)).("bank");
		    if(moneys > bank[playerid])
		        moneys = bank[playerid];
     	}
		GivePlayerMoney(playerid, moneys);
		if(gang)
			gangBank[playerGang[playerid]] -= moneys;
		else
			bank[playerid] = dUserINT(PlayerName(playerid)).("bank");
			bank[playerid] -= moneys;
	    	dUserSetINT(PlayerName(playerid)).("bank",bank[playerid]);
		if(gang)
			format(string, sizeof(string), "You have withdrawn $%d, your gang's balance is $%d.", moneys, gangBank[playerGang[playerid]]);
		else
			format(string, sizeof(string), "You have withdrawn $%d, your current balance is $%d.", moneys, bank[playerid]);
		SendClientMessage(playerid, COLOR_GREEN, string);
		return 1;
   	}
	//------------------- /balance
	if(strcmp(cmd, "/balance", true) == 0 || strcmp(cmd, "/gbalance", true) == 0) {
		new gang;
		if(strcmp(cmd, "/gbalance", true) == 0)
			gang = 1;

	    if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK && getCheckpointType(playerid) != CP_BANK_2 && getCheckpointType(playerid) != CP_BANK_3) {
	        SendClientMessage(playerid, COLOR_YELLOW, "You must be at a bank area to use this. ATMs are located in convenience stores.");
			return 1;
		}
		if(bankcard[playerid]==0){
	        SendClientMessage(playerid, COLOR_ORANGE, "/openaccount password to start account, /icard password to use account.");
			return 1;
		}
		if(gang && playerGang[playerid]==0) {
			SendClientMessage(playerid, COLOR_RED, "You are not in a gang!");
			return 1;
		}
		if(gang)
			format(string, sizeof(string), "Your gang has $%d in the bank.", gangBank[playerGang[playerid]]);
		else
			bank[playerid] = dUserINT(PlayerName(playerid)).("bank");
			format(string, sizeof(string), "You have $%d in the bank.", bank[playerid]);
		SendClientMessage(playerid, COLOR_GREEN, string);
		return 1;
	}
	  dcmd(icard,5,cmdtext);
// 		because icard has 5 characters
	  dcmd(openaccount,11,cmdtext);
//		because openaccount has 11 characters
	return 0;
}
//--strtok
public OnPlayerEnterCheckpoint(playerid)
{
	switch(getCheckpointType(playerid))
	{
		case CP_BANK: {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You are at an ATM. To store money use '/bank amount', to withdraw");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "money use '/withdraw amount', and '/balance' to see your balance.");
		}
		case CP_BANK_2: {
			SendClientMessage(playerid, COLOR_WHITE2, "You are at an ATM. To store money use '/bank amount', to withdraw");
			SendClientMessage(playerid, COLOR_WHITE2, "money use '/withdraw amount', and '/balance' to see your balance.");
		}
		case CP_BANK_3: {
			SendClientMessage(playerid, COLOR_ORANGE, "You are at an ATM. To store money use '/bank amount', to withdraw");
			SendClientMessage(playerid, COLOR_ORANGE, "money use '/withdraw amount', and '/balance' to see your balance.");
		}
	}
}
//--
public OnPlayerLeaveCheckpoint(playerid)
{
  PLAYERLIST_authed[playerid]=false;
         bankcard[playerid]=0;
return false;
}
//--
public OnFilterScriptInit()
{
	SetTimer("checkpointUpdate", 1100, 1);
	print("\n--------------------------------------");
	print("Corpse's Simple Banking FilterScript 0.3");
	print("--------------------------------------\n");
	return 1;
}
//---
public OnFilterScriptExit()
{
	return 1;
}
