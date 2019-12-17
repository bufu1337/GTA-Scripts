#include <a_samp>

// Destroy Vehicle System by Snipe
#define FILTERSCRIPT

forward destroyv();

new destroy[200];
new dv;


public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Destroy vehicle system by Snipe");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	KillTimer(dv);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
if(strcmp(cmdtext, "/destroyv", true) == 0)
{
RemovePlayerFromVehicle(playerid);
destroy[playerid] = GetPlayerVehicleID(playerid);
dv = SetTimer("destroyv", 1000, true);
return 1;
}
return 0;
}
public destroyv()
{
	 for(new i=0; i<MAX_PLAYERS; i++) if(destroy[i] != 0)
         {
               DestroyVehicle(destroy[i]);
               destroy[i] = 0;
               print("A vehicle was destroyed!");
         }
}
