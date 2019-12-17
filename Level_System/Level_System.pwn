#include <a_samp>

#define white 0xFFFFFFAA
#define white 0xFFFFFFAA
#define yellow 0xFFFFF00AA
#define red 0x660000AA
#define pink 0xFF66FFAA
#define lightblue 0x33CCFFAA
#define darkred 0x660000AA
#define grey 0xAFAFAFAA
#define error 0xD2691EAA
#define orange 0xFF9900AA
#define nicepink 0xEC13COFF
#define grad1 0xB4B5B7AA
#define lightgreen 0x7CFC00AA

enum Info
{
    pPassword[128],
	pLevel,
	pExp,
	pCash,
};
new PlayerInfo[MAX_PLAYERS][Info];
new levelexp = 1;
new gPlayerLogged[MAX_PLAYERS];
new gPlayerAccount[MAX_PLAYERS];
new ScoreOld;
forward OnPlayerLogin(playerid,const string[]);
forward String(string[]);
forward ScoreUpdate();
forward PayDay(playerid);
forward PlayerPlayMusic(playerid);
forward StopMusic();

public ScoreUpdate()
{
	new Score;
	new name[MAX_PLAYER_NAME];
	//new string[256];
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, name, sizeof(name));
   			Score = PlayerInfo[i][pLevel];
			SetPlayerScore(i, Score);
			if (Score > ScoreOld)
			{
				ScoreOld = Score;
			}
		}
	}
}
// This is a comment
// uncomment the line below if you want to write a filterscript
#define FILTERSCRIPT

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	SetTimer("PayDay",10000,1);//600000
	SetTimer("ScoreUpdate", 1000, 1);
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}
#endif
public OnPlayerConnect(playerid)
{
	PlayerInfo[playerid][pLevel] = 1;
	PlayerInfo[playerid][pExp] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
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
    new cmd[256];
    new idx;
    cmd = strtok(cmdtext, idx);
   	new tmp[256];
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid,playername,sizeof(playername));
    new nxtlevel = PlayerInfo[playerid][pLevel]+1;
    new expamount = nxtlevel*levelexp;
    new info[248];
    if (strcmp(cmd, "/login", true) ==0 )
	{
	    if(IsPlayerConnected(playerid))
	    {
	        new tmppass[64];
			if(gPlayerLogged[playerid] == 1)
			{
				SendClientMessage(playerid, grey, "	You are already logged in.");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, grey, "	USAGE: /login [password]");
				return 1;
			}
			strmid(tmppass, tmp, 0, strlen(cmdtext), 255);
			String(tmppass);
			OnPlayerLogin(playerid,tmppass);
		}
		return 1;
	}
	if (strcmp(cmd, "/register", true)==0)
	{
		new string[265];
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, grey, "USAGE: /register [password]");
			return 1;
		}
		if (gPlayerAccount[playerid] == 1)
		{
			SendClientMessage(playerid, grey, "   That nickname is already registered");
			return 1;
		}

		strmid(PlayerInfo[playerid][pPassword], tmp, 0, strlen(cmdtext), 255);
		String(PlayerInfo[playerid][pPassword]);
		GetPlayerName(playerid, playername, sizeof(playername));
		format(string, sizeof(string), "%s.cer", playername);
		new File: file = fopen(string, io_read);
		if (file)
		{
			SendClientMessage(playerid, grey, "   That name is already registered");
			fclose(file);
			return 1;
		}
		new File:hFile;
		hFile = fopen(string, io_append);
		new var[32];//
        format(var, 32, "%s\n", PlayerInfo[playerid][pPassword]);fwrite(hFile, var);
        format(var, 32, "Level:%d\n",PlayerInfo[playerid][pLevel]);fwrite(hFile, var);
        format(var, 32, "Exp:%d\n",PlayerInfo[playerid][pExp]);fwrite(hFile, var);
        PlayerInfo[playerid][pCash] = GetPlayerMoney(playerid);
        format(var, 32, "Cash:%d\n",PlayerInfo[playerid][pCash]);fwrite(hFile, var);
		fclose(hFile);
		SendClientMessage(playerid, white, "Succesfully Registered!");
		SendClientMessage(playerid, white, "Next time when you come , use /login [ password ].");
		OnPlayerLogin(playerid,PlayerInfo[playerid][pPassword]);
		return 1;
	}
	if (strcmp("/buylevel", cmd, true, 10) == 0)
	{
		if(IsPlayerConnected(playerid) == 1)
	    {
	        new points[248];
	        if(PlayerInfo[playerid][pExp] < expamount)
	        {
				format(points,sizeof(points)," You need [%d] Exp Points! You cureently have [%d]",expamount,PlayerInfo[playerid][pExp]);
				SendClientMessage(playerid,white,points);
				return 1;
			}
			else
			{
				PlayerInfo[playerid][pExp] = 0;
				PlayerInfo[playerid][pLevel]++;
				format(info,sizeof(info)," ~g~ Level Up! ~w~ Your now level: [%d]",PlayerInfo[playerid][pLevel]);
				GameTextForPlayer(playerid,info,6000,1);
				return 1;
			}
		}
		return 1;
	}
	if(strcmp("/level", cmd, true, 10)  == 0)
	{
	    if(gPlayerLogged[playerid] == 0)
	    {
	        SendClientMessage(playerid,white," Error: You must be logged in to use this!");
	        return 1;
		}
		else if(gPlayerLogged[playerid] == 1)
		{
	    	new stats[248];
	    	format(stats, sizeof(stats), "_______________________");
	    	SendClientMessage(playerid,lightgreen,stats);
			format(stats, sizeof(stats), " *** %s ***",playername);
			SendClientMessage(playerid,white,stats);
    		format(stats, sizeof(stats), " General: Level [%d], Exp [%d/%d]",PlayerInfo[playerid][pLevel],PlayerInfo[playerid][pExp],expamount);
    		SendClientMessage(playerid,white,stats);
		}
		return 1;
	}
	return 0;
}
public String(string[])
{
	for(new x=0; x < strlen(string); x++)
	  {
		  string[x] += (3^x) * (x % 15);
		  if(string[x] > (0xff))
		  {
			  string[x] -= 64;
		  }
	  }
	return 1;
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
public OnPlayerLogin(playerid,const string[])
{
    new pname2[MAX_PLAYER_NAME];
	new pname3[MAX_PLAYER_NAME];
	new string2[64];
	new string3[128];
	GetPlayerName(playerid, pname2, sizeof(pname2));
	format(string2, sizeof(string2), "%s.cer", pname2);
	new File: UserFile = fopen(string2, io_read);

	if (UserFile)
	{
		new valtmp[128];
		fread(UserFile, valtmp);strmid(PlayerInfo[playerid][pPassword], valtmp, 0, strlen(valtmp)-1, 255);

		if ((strcmp(PlayerInfo[playerid][pPassword], string, true, strlen(valtmp)-1) == 0))
		{
			new key[128],val[128];
 			new Data[128];
 			while(fread(UserFile,Data,sizeof(Data)))
			{
				key = ini_GetKey(Data);
                if( strcmp( key , "Level" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pLevel] = strval( val ); }
                if( strcmp( key , "Exp" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pExp] = strval( val ); }
                if( strcmp( key , "Cash" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pCash] = strval( val ); }
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash]);
			}
			fclose(UserFile);
			gPlayerLogged[playerid] = 1;
			gPlayerAccount[playerid] = 1;
		    new score = PlayerInfo[playerid][pLevel];
            SetPlayerScore(playerid, score);
			GetPlayerName(playerid, pname3, sizeof(pname3));
			format(string3, sizeof(string3), "Succesfully logged in!");
			SendClientMessage(playerid, white,string3);
		}
		else
		{
			SendClientMessage(playerid, grey, "Invalid Password");
			fclose(UserFile);
		}
	}
	return 1;
}
stock ini_GetKey( line[] )
{
	new keyRes[128];
	keyRes[0] = 0;
    if ( strfind( line , "=" , true ) == -1 ) return keyRes;
    strmid( keyRes , line , 0 , strfind( line , "=" , true ) , sizeof( keyRes) );
    return keyRes;
}
stock ini_GetValue( line[] )
{
	new valRes[128];
	valRes[0]=0;
	if ( strfind( line , "=" , true ) == -1 ) return valRes;
	strmid( valRes , line , strfind( line , "=" , true )+1 , strlen( line ) , sizeof( valRes ) );
	return valRes;
}
public OnPlayerUpdate(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(gPlayerLogged[playerid])
		{
			new string3[32];
			new pname3[MAX_PLAYER_NAME];
			GetPlayerName(playerid, pname3, sizeof(pname3));
			format(string3, sizeof(string3), "%s.cer", pname3);
			new File: pFile = fopen(string3, io_write);
			if (pFile)
			{
				new var[32];
				format(var, 32, "%s\n", PlayerInfo[playerid][pPassword]);fwrite(pFile, var);
				fclose(pFile);
				new File: hFile = fopen(string3, io_append);
				PlayerInfo[playerid][pCash] = GetPlayerMoney(playerid);
				format(var, 32, "Kills:%d\n",PlayerInfo[playerid][pLevel]);fwrite(hFile, var);
				format(var, 32, "Deaths:%d\n",PlayerInfo[playerid][pExp]);fwrite(hFile, var);
				format(var, 32, "Cash:%d\n",PlayerInfo[playerid][pCash]);fwrite(hFile, var);
				fclose(hFile);
			}
		}
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

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
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
public PayDay(playerid)
{
	for (new i; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
		    new nxtlevel = PlayerInfo[playerid][pLevel];
		    new payday = nxtlevel*1000;
			GivePlayerMoney(i,payday);
			PlayerInfo[playerid][pExp]++;
			GameTextForPlayer(i,"  ~p~ PayDay",6,5000);
			PlayerPlayMusic(playerid);
		}
	}
}
public PlayerPlayMusic(playerid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			SetTimer("StopMusic", 5000, 0);
			PlayerPlaySound(i, 1068, 0.0, 0.0, 0.0);
		}
	}
}
public StopMusic()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			PlayerPlaySound(i, 1069, 0.0, 0.0, 0.0);
		}
	}
}
