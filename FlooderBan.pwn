// This script stops server-crashers applications which join virtual players
// several times to a server, to make it crash.
// Tenshi
#include <a_samp>
/// Start of configuration /////////////////////////////////////////////////////
#define TIME_LIMIT  	1   // In minutes
#define MAX_JOINS   	4   // Maximum allowed amount of joins from a same IP that the server allows in the TIME_LIMIT before banning.

#define EXPECTED_JOINS  50  // This value must be higher than the amount of expected player joins (from same IP or not) during TIME_LIMIT.
// more: for EXPECTED_JOINS, if you have players from 1 to 75, this is ok, over 175 players try setting to 100 to 150.
// Also, don't worry if server has 200 players and server crashes or restart, everything is already taken care of by resetting.

#define SHOW_MESSAGE   	1   // 0 or 1. Whether to show a message to all players or not when a server-crash attempt is stopped.
#define LOG_FLOODER     1 	// 0 or 1, Log bans that are caused by the flooder ( default is set to 1 = log )
////////////////////////////////////////////////// End of configuration ////////
#define MAX_IP  32
forward ResetRecord();

new IPRecord[ EXPECTED_JOINS ][ MAX_IP ],
	IPIndex;

new Timer;
new ServerRestartPause = 0;

public OnFilterScriptInit()
{
	print(" Anti-join-flooding script loaded.");
	Timer = SetTimer("ResetRecord", TIME_LIMIT * 60000, 1);

	SetTimer("ServerUptimeSetRestart", 11000, 0); // 11 seconds of pause on restarts
    // (above) This timer will ONLY work once every reload or restart (yey');
    // This is needed to prevent accidental banning from multiple PC users on the same IP
    // when the server restarts for what ever reason, removing or editing this is NOT smart.
    return 1;
}

public OnFilterScriptExit()
{
	KillTimer(Timer);
	print(" Anti-join-flooding script unloaded.");
	return 1;
}

public ServerUptimeSetRestart()	{ ServerRestartPause = 1; }
forward  ServerUptimeSetRestart();
public ResetRecord() { IPIndex = 0; } // Reset the IP list.

public OnPlayerConnect(playerid)
{
	if (ServerRestartPause){
	// start code;
	new JoinCount;

	if(IPIndex > 0)
	{
		for(new i; i < IPIndex; i ++)
		{
		    if(!strcmp(PlayerIP(playerid), IPRecord[i]))
				JoinCount ++;
		}

		if(JoinCount >= MAX_JOINS)
		{
		    BanIP(playerid);
		    ResetRecord();
		    return 1;
		}
	}

	if(IPIndex >= EXPECTED_JOINS)
	    ResetRecord();

	strmid(IPRecord[IPIndex], PlayerIP(playerid), 0, MAX_IP, MAX_IP); // Record the IP
	IPIndex ++;
	// end of code
	}

	return 1;
}
// Stock -----------------------------------------------------------------------
stock BanIP(playerid)
{
	#if LOG_FLOODER == 1
		new filename[128], y, m, d;
		getdate(y, m, d);
		format(filename, sizeof(filename), "FlooderBan.txt", y, m);
		if(!fexist(filename))
		{
			new File:tmpfile = fopen(filename, io_write);
			fclose(tmpfile);
		}
		new File:sfhandler = fopen(filename, io_append),
		sfilestr[128];
		new h,mi,s; gettime(h,mi,s);
		format(sfilestr, sizeof(sfilestr),

		// Details by Month / Day / Year / Hour / Minute / Second Then Players name and the Players IP.
		"| %02d/%02d/%d %02d:%02d:%02d (M/D/Y H:M:S) | > Flooder: %s (IP:%s). \r\n",
		// --------------------------------------------------------------------------------------------
		m, d, y, h, mi, s, PlayerName(playerid), PlayerIP(playerid));
		fwrite(sfhandler, sfilestr); fclose(sfhandler);
	#endif

	new string[128];

	#if SHOW_MESSAGE == 1
		format(string, sizeof(string), "* %s has been banned: Connection Flooding Attempt.", PlayerIP(playerid));
		SendClientMessageToAll(0xff3333ff, string);
	#endif

	printf("Banned %s(%d), %s. Connection flooding.", PlayerName(playerid), playerid, PlayerIP(playerid));

	format(string, sizeof(string), "banip %s", PlayerIP(playerid));
	SendRconCommand(string);
	SendRconCommand("reloadbans");
}
// Functions -------------------------------------------------------------------
PlayerIP(playerid)
{
	new ip[MAX_IP];
	GetPlayerIp(playerid, ip, MAX_IP);
	return ip;
}

PlayerName(playerid)
{
	new name[MAX_IP];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	return name;
}
// E.O.Functions ---------------------------------------------------------------