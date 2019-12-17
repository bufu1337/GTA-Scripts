/*##############################################################################


					#########################################
					#										#
					#	  BUTTONS - FILTERSCRIPT BY YOM		#
					#       Steal my work and die >:D		#
					#                                       #
					#########################################


- Informations about this file:
===============================

	-	You must #include <yom_buttons> in your gamemodes




- Copyright:
============

	-	Yom Productions © ®.
	-	You can use this script and distribute it but,
	-	You WILL NOT sell it or tell it is your own work.



- Versions changes:
===================

	-	1.0 :	Initial release.
	            Small tweaks here and there, no need to update version for that.


##############################################################################*/




#include <a_samp>

#define MAX_BUTTONS			100     //max buttons allowed..
#define BUTTON_OBJECTID		2961    //the objectid you want to use as a button
#define MAX_DISTANCE    	1.0     //distance max for pressing a button




enum BUTTON_INFOS
{
	Float:Pos[3],
	bool:Anim
};


enum PLAYER_INFOS
{
	Float:Pos[3]
};


new
	ButtonInfo[MAX_BUTTONS][BUTTON_INFOS],
	PlayerInfo[MAX_PLAYERS][PLAYER_INFOS],

	Float:MaxDistance = 0.0,
	ButtonID = 0
;




stock Float:Distance(Float:vector1[], Float:vector2[])
{
	new Float:dX = vector1[0] - vector2[0],
		Float:dY = vector1[1] - vector2[1],
		Float:dZ = vector1[2] - vector2[2];

	return (dX*dX + dY*dY + dZ*dZ);
}




forward PRIVATE_CreateButton(Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, bool:anim);
public PRIVATE_CreateButton(Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, bool:anim)
{
	ButtonInfo[ButtonID][Pos][0]	= X;
	ButtonInfo[ButtonID][Pos][1]	= Y;
	ButtonInfo[ButtonID][Pos][2]	= Z;
	ButtonInfo[ButtonID][Anim]     = anim;

	CreateObject(BUTTON_OBJECTID, X, Y, Z, rX, rY, rZ);

	return ButtonID ++;
}




forward OnPlayerPressButton_Anim_Delay(playerid, buttonid);
public OnPlayerPressButton_Anim_Delay(playerid, buttonid)
	CallRemoteFunction("OnPlayerPressButton", "ii", playerid, buttonid);




public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && newkeys & 16)
	{
	    GetPlayerPos(playerid, PlayerInfo[playerid][Pos][0], PlayerInfo[playerid][Pos][1], PlayerInfo[playerid][Pos][2]);

		for (new buttonid = 0; buttonid < ButtonID; buttonid ++)
		{
			if (Distance(PlayerInfo[playerid][Pos],ButtonInfo[buttonid][Pos]) < MaxDistance)
			{
				if (ButtonInfo[buttonid][Anim])
				{
					ApplyAnimation(playerid, "HEIST9", "Use_SwipeCard", 10.0, 0, 0, 0, 0, 0);
					SetTimerEx("OnPlayerPressButton_Anim_Delay", 500, false, "ii", playerid, buttonid);
				}
				else
					CallRemoteFunction("OnPlayerPressButton", "ii", playerid, buttonid);
			}
		}
	}

	return false;
}




public OnPlayerConnect(playerid)
{
    ApplyAnimation(playerid, "HEIST9", "Use_SwipeCard", 10.0, 0, 0, 0, 0, 0);
    return false;
}




public OnFilterScriptInit()
{
    MaxDistance = MAX_DISTANCE * MAX_DISTANCE;
	return false;
}
