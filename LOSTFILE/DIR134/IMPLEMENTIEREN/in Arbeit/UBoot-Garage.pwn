/* This is the game mode code. */

#include <a_samp>

/* Stupid defines. */
#define COLOR_SYSTEM 0xFFFFFFAA
new AGates = 0, PrisonGates = 0, GateID[25];

public OnFilterScriptInit()
{
	print("=> Westie's Compound 2.0 has been loaded. Have fun.");
 	AGates = CreateObject(986,-1331.609,331.544,6.823,0.0,0.0,180.000);

 	GateID[0] = CreateObject(8171,-1396.862,391.361,6.169,0.0,0.0,90.000);
	GateID[1] = CreateObject(8171,-1396.950,426.899,6.155,0.0,0.0,90.000);
	GateID[2] = CreateObject(8171,-1396.979,354.607,5.333,-180.481,0.0,90.000);
	GateID[3] = CreateObject(8171,-1396.904,393.071,5.571,-180.481,0.0,90.000);
	GateID[4] = CreateObject(8171,-1396.927,426.142,5.332,-180.481,0.0,90.000);
	GateID[5] = CreateObject(987,-1327.743,331.609,6.213,0.0,0.0,90.000);
	GateID[6] = CreateObject(987,-1327.771,343.536,6.207,0.0,0.0,90.000);
	GateID[7] = CreateObject(987,-1327.774,355.498,6.198,0.0,0.0,90.000);
	GateID[8] = CreateObject(987,-1327.771,367.479,6.188,0.0,0.0,90.000);
	GateID[9] = CreateObject(987,-1327.773,379.433,6.169,0.0,0.0,90.000);
	GateID[10] = CreateObject(987,-1327.782,391.369,6.166,0.0,0.0,90.000);
	GateID[11] = CreateObject(987,-1327.745,403.327,6.194,0.0,0.0,90.000);
	GateID[12] = CreateObject(987,-1327.758,415.244,6.155,0.0,0.0,90.000);
	GateID[13] = CreateObject(987,-1327.838,427.215,6.122,0.0,0.0,90.000);
	GateID[14] = CreateObject(987,-1327.935,433.526,6.162,0.0,0.0,88.281);
	GateID[15] = CreateObject(987,-1347.602,331.713,6.107,0.0,0.0,0.0);
	GateID[16] = CreateObject(8171,-1396.878,356.212,6.162,0.0,0.0,90.000);
	GateID[17] = CreateObject(2792,-1336.618,365.823,15.079,0.0,0.0,180.000);
	GateID[18] = CreateObject(2793,-1336.695,401.566,14.579,0.0,0.0,180.000);
	GateID[19] = CreateObject(2794,-1336.657,437.316,14.067,0.0,0.0,180.000);
	GateID[20] = CreateObject(10766,-1356.490,348.813,3.798,0.0,0.0,0.0);
	GateID[21] = CreateObject(9339,-1327.814,421.791,5.449,0.0,0.0,0.0);
	GateID[22] = CreateObject(9339,-1327.814,393.016,5.449,0.0,0.0,0.0);
	GateID[23] = CreateObject(9339,-1327.814,357.516,5.449,0.0,0.0,0.0);
	GateID[24] = CreateObject(987,-1327.482,445.464,6.188,0.0,0.859,177.663);

	return 1;
}

public OnFilterScriptExit()
{
	print("=> Westie's Compound has been unloaded. Good riddance.");

	DestroyObject(AGates);
	for(new i=0; i<24; i++)  DestroyObject(GateID[i]);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if (strcmp(cmdtext, "/sfgates", true) == 0)
	{
	   	if(!PrisonGates)
	   	{
	   		MoveObject(AGates, -1339.591,331.550,6.856, 5);
	   		SystemMsg(playerid, "SERVER: SF Gates are now open.");
			PrisonGates= 1;
			return 1;
		}
		else
	   	{
   			MoveObject(AGates, -1331.609,331.544,6.823, 5);
	    	SystemMsg(playerid, "SERVER: SF Gates are now closed.");
			PrisonGates = 0;
			return 1;
		}
	}
	return 0;
}

stock SystemMsg(playerid,msg[])
{
	if ((IsPlayerConnected(playerid)) && (strlen(msg)>0))
	{
 		SendClientMessage(playerid,COLOR_SYSTEM,msg);
	}
  	return 1;
}
