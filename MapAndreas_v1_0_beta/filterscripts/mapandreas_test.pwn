//
// Test FS for the MapAndreas plugin
//
// - Kye 2010

#pragma tabsize 0
#include <a_samp>
#include <mapandreas>

#include "../include/gl_common.inc"

public OnFilterScriptInit()
{
	print("\nMapAndreas Test FS Loading...\n");
	MapAndreas_Init(MAP_ANDREAS_MODE_FULL);
	
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new idx;
	cmd = strtok(cmdtext, idx);

	if(strcmp(cmd, "/glvl", true) == 0)
	{
		new Float:X, Float:Y, Float:Z;
 		GetPlayerPos(playerid,X,Y,Z);

		new msg[128];
		format(msg,128,"Your position is: X:%f Y:%f Z:%f",X,Y,Z);
		SendClientMessage(playerid,0xFFFFFFFF,msg);
		
        MapAndreas_FindZ_For2DCoord(X,Y,Z);
		format(msg,128,"Highest ground level: %f",Z);
		SendClientMessage(playerid,0xFFFFFFFF,msg);
		
	    return 1;
	}
	
	return 0;
}
