/* ////////////////////// TRAMPOLINE FILTERSCRIPT BY VonKnox. /////////////////////////////
Usage: Use "/trampoline" to spawn a trampoline infront of you.
Get on it and have fun!
*/

#include <a_samp>

new trampoline;

public OnFilterScriptInit()
{
	SetTimer("Bounce", 750, true);
	return 1;
}

forward Float:GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance);
stock Float:GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	if (IsPlayerInAnyVehicle(playerid))
	GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	else GetPlayerFacingAngle(playerid, a);
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
	return a;
}

forward Bounce();
public Bounce()
{
	new Float:x, Float:y, Float:z;
	GetObjectPos(trampoline, x, y, z);
	for(new i; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerInRangeOfPoint(i, 2.25, x, y, z+2.0))
		{
		SetPlayerVelocity(i, 0.0, 0.0, 0.5);
		}
	}
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/trampoline", cmdtext, true, 10) == 0)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		GetXYInFrontOfPlayer(playerid, x, y, 5.0);
		trampoline = CreateObject(14449, x, y, z, 0.0, 0.0, 0.0);
		return 1;
	}
	return 0;
}