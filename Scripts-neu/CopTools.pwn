#include <a_samp>

/*
//////////////////////////////
//////////CopTools////////////
//////////by Geso/////////////
//////////////////////////////

These functions can be used with i.e.:

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/arm", cmdtext, true, 10) == 0)
	{
	    PutRiotShieldOnArm(playerid);
		return 1;
	}
	if (strcmp("/back", cmdtext, true, 10) == 0)
	{
	    PutRiotShieldOnBack(playerid);
		return 1;
	}
	if (strcmp("/light", cmdtext, true, 10) == 0)
	{
	    GiveFlashLight(playerid);
		return 1;
	}
	if (strcmp("/tazer", cmdtext, true, 10) == 0)
	{
	    GiveTazer(playerid);
		return 1;
	}
	if (strcmp("/removeitems", cmdtext, true, 10) == 0)
	{
	        if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
	        if(IsPlayerAttachedObjectSlotUsed(playerid,2)) RemovePlayerAttachedObject(playerid,2);
		return 1;
	}
	return 0;
}
*/

RemoveItems(playerid)
{
	        if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
	        if(IsPlayerAttachedObjectSlotUsed(playerid,2)) RemovePlayerAttachedObject(playerid,2);
}

PutRiotShieldOnBack(playerid)
{
	    if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
		SetPlayerAttachedObject(playerid, 1 , 18637, 1, 0, -0.1, 0.18, 90, 0, 272, 1, 1, 1);
}

PutRiotShieldOnArm(playerid)
{
	    if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
		SetPlayerAttachedObject(playerid, 1, 18637, 4, 0.3, 0, 0, 0, 170, 270, 1, 1, 1);
}

GiveFlashLight(playerid)
{
	    if(IsPlayerAttachedObjectSlotUsed(playerid,2)) RemovePlayerAttachedObject(playerid,2);
		SetPlayerAttachedObject(playerid, 2,18641, 5, 0.1, 0.02, -0.05, 0, 0, 0, 1, 1, 1);
}

GiveTazer(playerid)
{
	    if(IsPlayerAttachedObjectSlotUsed(playerid,2)) RemovePlayerAttachedObject(playerid,2);
		SetPlayerAttachedObject(playerid, 2,18642, 5, 0.12, 0.02, -0.05, 0, 0, 45,1,1,1);
}