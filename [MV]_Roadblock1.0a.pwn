/*
|.----------------.
| .--------------. ||
| | ____    ____ | ||
| |_   \  /   _| | ||
| |  |   \/   |  | ||
| |  | |\  /| |  | ||
| | _| |_\/_| |_ | ||
| ||_____||_____|| ||
| |              | ||
| '--------------' ||
 '----------------'   's Roadblock

Free to use on the following conditions:

	*Do not re-release edited versions without my permision
	*Do not and NEVER clame this as your own, not even an edit!
	*Say thanks on the sa-mp forums if you like ;)
	*Give reputation if you love it :D


----------------UPDATES:--------------------------------------------------------
- You can edit the EXPIRE_MINUTES now
- CMD: /rb /deleteall
*/


#include <a_samp>
#include <zcmd>
#include <sscanf2>
#define COLOR_INVISIBLE 0xFFFFFF00
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_BLACK 0x000000FF
#define COLOR_BLUE 0x0000DDFF
#define COLOR_RED 0xAA3333AA
#define COLOR_GREEN 0x00FF00FF
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_YELLOWORANGE 0xE8D600FF
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_ORANGE 0xFF5F11FF
#define ORANGE 0xF4B906FF
#define COLOR_BROWN 0x804000FF
#define COLOR_CYAN 0x00FFFFFF
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_PINK 0xFF80C0FF

#define EXPIRE_MINUTES 	5 //after x minutes the roadblocks expire
#define MAX_ROADBLOCKS 	30//maximum roadblocks in server
#define SEND 			true//if someone adds a roadblock ? You want let everyone know ? true = yes, false = no

new block[MAX_ROADBLOCKS][MAX_PLAYERS], atblock[MAX_PLAYERS], pName[MAX_PLAYER_NAME],string[128];
#pragma tabsize 0
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" [MV]_Roadblock Loades Succesfully ");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid,COLOR_YELLOW,"This server use [MV]_Roadblock | /roadblock");
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SendClientMessage(playerid,COLOR_YELLOW,"This server use [MV]_Roadblock | /roadblock");
	return 1;
}

CMD:deleteall(playerid,params[])
{
	for(new i=0;i<=sizeof(block);i++) DestroyObject(block[i][playerid]);
	return 1;
}

CMD:rb(playerid, params[])
            return cmd_roadblock(playerid, params);

CMD:roadblock(playerid,params[])
{
	    new number, atrb = atblock[playerid];
	    if(sscanf(params,"d",number))
	    {
			SendClientMessage(playerid,COLOR_BLUE,"USAGE: /roadblock <1/2/3/4/5/6/7>");
			SendClientMessage(playerid,COLOR_BLUE,"| 1: Small Roadblock");
			SendClientMessage(playerid,COLOR_BLUE,"| 2: Medium Roadblock");
			SendClientMessage(playerid,COLOR_BLUE,"| 3: Big Roadblock");
			SendClientMessage(playerid,COLOR_BLUE,"| 4: Traffic cone");
			SendClientMessage(playerid,COLOR_BLUE,"| 5: Detour sign");
			SendClientMessage(playerid,COLOR_BLUE,"| 6: Will be sign");
			SendClientMessage(playerid,COLOR_BLUE,"| 7: Line closed sign");
			SendClientMessage(playerid,COLOR_WHITE,"----------------------");
			format(string, sizeof string,"The roadblock will expire after %i minutes, or use /deleteall",EXPIRE_MINUTES);
			SendClientMessage(playerid,COLOR_BLUE,string);
			return 1;
		}

		switch(number)
		{
			case 1:
			{
					new Float:X, Float:Y, Float:Z, Float:A;
			  		GetPlayerPos(playerid, X, Y, Z);
			  		GetPlayerFacingAngle(playerid, A);
			  		if(atblock[playerid] < MAX_ROADBLOCKS)
			  		{
			  			block[atrb][playerid] = CreateObject(1459, X, Y+1, Z-0.5,0,0,A);
			  			GameTextForPlayer(playerid,"~w~Roadblock ~b~Placed!",3000,1);
			  			#if SEND == true
			  			GetPlayerName(playerid,pName,32);
						format(string,sizeof (string)," %s added a roadblock(%i).",pName,number);
						SendClientMessageToAll(COLOR_GREEN, string);
						#else
						SetTimerEx("ExpireRoadblock", EXPIRE_MINUTES*60000, false, "i", block[atrb][playerid]);
						atblock[playerid] += 1;
						#endif
			  		} else {
			  		    format(string,sizeof string,"You cannot place more then %i Roadblocks!",MAX_ROADBLOCKS);
			  		    SendClientMessage(playerid, COLOR_RED, string);
			  		}
			  		return 1;
			}


			case 2:
			{
					new Float:X, Float:Y, Float:Z, Float:A;
			  		GetPlayerPos(playerid, X, Y, Z);
			  		GetPlayerFacingAngle(playerid, A);
			  		if(atblock[playerid] < MAX_ROADBLOCKS)
			  		{
				  		block[atrb][playerid] = CreateObject(978, X, Y+1, Z,0,0,A);
				  		GameTextForPlayer(playerid,"~w~Roadblock ~b~Placed!",3000,1);
				  		#if SEND == true
				  		GetPlayerName(playerid,pName,32);
						format(string,sizeof string,"%s added a roadblock(%i).",pName,number);
						SendClientMessageToAll(COLOR_GREEN, string);
						#else
						SetTimerEx("ExpireRoadblock", EXPIRE_MINUTES*60000, false, "i", block[atrb][playerid]);
						atblock[playerid] += 1;
						#endif
			  		} else {
			  		   format(string,sizeof string,"You cannot place more then %i Roadblocks!",MAX_ROADBLOCKS);
			  		    SendClientMessage(playerid, COLOR_RED, string);
			  		}
			  		return 1;
			}

			case 3:
			{
					new Float:X, Float:Y, Float:Z, Float:A;
			  		GetPlayerPos(playerid, X, Y, Z);
			  		GetPlayerFacingAngle(playerid, A);
			  		if(atblock[playerid] < MAX_ROADBLOCKS)
			  		{
				  		block[atrb][playerid] = CreateObject(981, X, Y+1, Z,0,0,A);
				  		GameTextForPlayer(playerid,"~w~Roadblock ~b~Placed!",3000,1);
				  		#if SEND == true
				  		GetPlayerName(playerid,pName,32);
						format(string,sizeof string," %s added a roadblock(%i).",pName,number);
						SendClientMessageToAll(COLOR_GREEN,string);
						#else
						SetTimerEx("ExpireRoadblock", EXPIRE_MINUTES*60000, false, "i", block[atrb][playerid]);
						atblock[playerid] += 1;
						#endif
			  		} else {
			  		    format(string,sizeof string,"You cannot place more then %i Roadblocks!",MAX_ROADBLOCKS);
			  		    SendClientMessage(playerid, COLOR_RED, string);
			  		}
			  		return 1;
			}

			case 4:
			{
					new Float:X, Float:Y, Float:Z, Float:A;
			  		GetPlayerPos(playerid, X, Y, Z);
			  		GetPlayerFacingAngle(playerid, A);
			  		if(atblock[playerid] < MAX_ROADBLOCKS)
			  		{
				  		block[atrb][playerid] = CreateObject(1238, X, Y+1, Z-0.5, 0, 0.0,A);
				  		GameTextForPlayer(playerid,"~w~Cone ~b~Placed!",3000,1);
				  		#if SEND == true
				  		GetPlayerName(playerid,pName,32);
						format(string,sizeof string," %s added a roadblock(%i).",pName,number);
						SendClientMessageToAll(COLOR_GREEN, string);
						#else
						SetTimerEx("ExpireRoadblock", EXPIRE_MINUTES*60000, false, "i", block[atrb][playerid]);
						atblock[playerid] += 1;
						#endif
			  		} else {
			  		    format(string,sizeof string,"You cannot place more then %i Roadblocks!",MAX_ROADBLOCKS);
			  		    SendClientMessage(playerid, COLOR_RED, string);
			  		}
			  		return 1;
			}

			case 5:
			{
					new Float:X, Float:Y, Float:Z, Float:A;
			  		GetPlayerPos(playerid, X, Y, Z);
			  		GetPlayerFacingAngle(playerid, A);
			  		if(atblock[playerid] < MAX_ROADBLOCKS)
			  		{
				  		block[atrb][playerid] = CreateObject(1425, X, Y+1, Z-0.5, 0, 0.0,A,300);
				  		GameTextForPlayer(playerid,"~w~Sign ~b~Placed!",3000,1);
				  		#if SEND == true
				  		GetPlayerName(playerid,pName,32);
						format(string,sizeof string," %s added a roadblock(%i).",pName,number);
						SendClientMessageToAll(COLOR_GREEN, string);
						#else
						SetTimerEx("ExpireRoadblock", EXPIRE_MINUTES*60000, false, "i", block[atrb][playerid]);
						atblock[playerid] += 1;
						#endif
			  		} else {
			  		    format(string,sizeof string,"You cannot place more then %i Roadblocks!",MAX_ROADBLOCKS);
			  		    SendClientMessage(playerid, COLOR_RED, string);
			  		}
			  		return 1;
			}

			case 6:
			{
					new Float:X, Float:Y, Float:Z, Float:A;
			  		GetPlayerPos(playerid, X, Y, Z);
			  		GetPlayerFacingAngle(playerid, A);
			  		if(atblock[playerid] < MAX_ROADBLOCKS)
			  		{
				  		block[atrb][playerid] = CreateObject(3265, X, Y+1, Z-0.9, 0, 0.0,A);
				  		GameTextForPlayer(playerid,"~w~Sign ~b~Placed!",3000,1);
				  		#if SEND == true
				  		GetPlayerName(playerid,pName,32);
						format(string,sizeof string," %s added a roadblock(%i).",pName,number);
						SendClientMessageToAll(COLOR_GREEN, string);
						#else
						SetTimerEx("ExpireRoadblock", EXPIRE_MINUTES*60000, false, "i", block[atrb][playerid]);
						atblock[playerid] += 1;
						#endif
			  		} else {
			  		    format(string,sizeof string,"You cannot place more then %i Roadblocks!",MAX_ROADBLOCKS);
			  		    SendClientMessage(playerid, COLOR_RED, string);
			  		}
			  		return 1;
			}

			case 7:
			{
					new Float:X, Float:Y, Float:Z, Float:A;
			  		GetPlayerPos(playerid, X, Y, Z);
			  		GetPlayerFacingAngle(playerid, A);
			  		if(atblock[playerid] < MAX_ROADBLOCKS)
			  		{
				  		block[atrb][playerid] = CreateObject(3091, X, Y+1, Z-0.25, 0, 0.0,A);
				  		GameTextForPlayer(playerid,"~w~Sign ~b~Placed!",3000,1);
				  		#if SEND == true
				  		GetPlayerName(playerid,pName,32);
						format(string,sizeof string," %s added a roadblock(%i).",pName,number);
						SendClientMessageToAll(COLOR_GREEN, string);
						#else
						SetTimerEx("ExpireRoadblock",EXPIRE_MINUTES*60000, false, "i", block[atrb][playerid]);
						atblock[playerid] += 1;
						#endif
			  		} else {
			  		    format(string,sizeof string,"You cannot place more then %i Roadblocks!",MAX_ROADBLOCKS);
			  		    SendClientMessage(playerid, COLOR_RED, string);
			  		}
			  		return 1;
			}
		}
	return 1;
}


forward ExpireRoadblock(blockid);
public ExpireRoadblock(blockid)
{
	DestroyObject(blockid);
	return 1;
}
