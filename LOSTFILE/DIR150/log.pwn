#include <a_samp>

forward Log(file[], log[]);

public OnFilterScriptInit()
{
	print("------------------------------");
	print("-Remote Control plugin by Web-");
	print("------------------------------");
	print("Thanks to -Seif- for the help!");
	print("------------------------------");
	return 1;
}

public OnPlayerConnect(playerid)
{
	new name[24], log[256];
	GetPlayerName(playerid, name, sizeof(name));
	format(log, sizeof(log), "%s Conectado",name);
	Log("Logs.txt", log);
	return 1;
}

public OnPlayerDisconnect(playerid)
{
	new name[24], log[256];
    GetPlayerName(playerid, name, sizeof(name));
    format(log, sizeof(log), "%s Desconectado",name);
    Log("Logs.txt", log);
    return 1;
}

public OnPlayerText(playerid, text[])
{
    new name[24], string[256];
    GetPlayerName(playerid, name, sizeof(name));
    format(string, 256, "%s: %s",name, text);
    Log("Logs.txt", string);
    return 1;
}


public Log(file[], log[])
{
    if (!fexist(file)) fopen(file,io_write);
    new File:f = fopen(file,io_append);
    if (f)
    {
        new entry[256];
        format(entry,sizeof(entry),"%s\r\n",log);
        fwrite(f,entry);
        fclose(f);
    }
}

