#include <a_samp>
#include <ZCMD>
#include <foreach>
#include <sscanf>

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Audio streaming. Filterscript - Jay Gill");
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
	print("\n-----------------------------------------");
	print(" Audio streaming. Filterscript - Jay Gill");
	print("-------------------------------------------\n");
}

#endif

CMD:streamaudio(playerid, params[])
{
	new string[128];
	if(sscanf(params, "s[256]", params)) return SendClientMessage(playerid, -1,"{FF8000}ERROR{FFFFFF}: /stream [url]");

	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1, "{AA3333}You are not an RCON Admin.");
	format(string, sizeof(string), "An admin has statred global song.[ /stopmusic to stop listening ]");
	SendClientMessageToAll( 0xFFFF00AA, string);
	foreach(Player, i)
	{
		PlayAudioStreamForPlayer(i, params);
	}
	return 1;
}

CMD:streamhelp(playerid, params[])
{
    if(IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1, " '/streamaudio' - '/stopmusicforall'");
    SendClientMessage(playerid, -1, " '/stopmusic'");
    return 1;
}

CMD:stopmusic(playerid, params[])
{
    StopAudioStreamForPlayer(playerid);
    SendClientMessage(playerid, 0xAA3333AA, " You have stopped listening to music.");
    return 1;
}

CMD:stopmusicforall(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1, "{AA3333}You are not an RCON Admin.");
	foreach(Player, i)
	{
		StopAudioStreamForPlayer(i);
		SendClientMessage(i, 0xAA3333AA, " An admin has stopped your audio.");
 	}
	return 1;
}