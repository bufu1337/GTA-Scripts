/*
*
*	[INC] Player Indicate Function
*		- By: [WsR]RyDeR
*			Please Leave My Credits
*
*
*/
/****Important****/
#include a_samp

new Indicator[MAX_PLAYERS];
new Float: Ox, Oy, Oz, Rx, Ry, Rz;

/****Function****/
// native IndicatePlayer(playerid);
// native DestroyIndicator(playerid);

/****Code****/
stock IndicatePlayer(playerid)
{
	Indicator[playerid] = CreateObject(1318, Ox, Oy, Oz, Rx, Ry, Rz); 
	AttachObjectToPlayer(Indicator[playerid], playerid, 0.0, 0.0, 1.6, 0, 1.5, 2);
}

stock DestroyIndicator(playerid)
{
	DestroyObject(Indicator[playerid]);
}