/*
Fs By Splitx LS Edition
*/


#include <a_samp>

#pragma tabsize 0
#define COLOR_YELLOW 0xFFFF00AA
#define FILTERSCRIPT
forward GateClose();
#if defined FILTERSCRIPT
new police;
public OnFilterScriptInit()
{
police = CreateObject(3278, 246.4453,71.8809,1003.6406,2.1405);
	print("\n--------------------------------------");
	print(" police FS BY GaMeouT");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#endif

public OnPlayerCommandText(playerid, cmdtext[])
{
if (strcmp(cmdtext, "/poliint", true)==0)
       {
       MoveObject(police,248.9561,71.6159,1003.6406, 3.5);
      SetTimer("GateClose", 4000, 0);
      SendClientMessage(playerid, COLOR_YELLOW,"La puerta de la comisaria se a abierto, se cerrara en 4 Segundos");
      return 1;
       }
	return 0;
}

public GateClose()
{
      MoveObject (police,246.4453,71.8809,1003.6406,2.1405);
return 1;
}

