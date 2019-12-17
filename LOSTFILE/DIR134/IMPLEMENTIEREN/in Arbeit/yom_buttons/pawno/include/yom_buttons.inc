/*##############################################################################


					#########################################
					#										#
					#	  BUTTONS - INCLUDE FILE BY YOM		#
					#       Steal my work and die >:D		#
					#                                       #
					#########################################


- Informations about this file:
===============================

	-	You must run the included FS in order to get it working.




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




/*-------------------------- The new awesome callback ------------------------*/
forward OnPlayerPressButton(playerid, buttonid);
/*----------------------------------------------------------------------------*/


/*----------------------------- Native definition ------------------------------
native CreateButton(Float:X, Float:Y, Float:Z, Float:rX = 0.0, Float:rY = 0.0, Float:rZ = 0.0, bool:anim = true);
------------------------------------------------------------------------------*/


/*------------------------------ Quick function ------------------------------*/
stock CreateButton(Float:X, Float:Y, Float:Z, Float:rX = 0.0, Float:rY = 0.0, Float:rZ = 0.0, bool:anim = true)
	return CallRemoteFunction("PRIVATE_CreateButton","ffffffd", X, Y, Z, rX, rY, rZ, anim);
/*----------------------------------------------------------------------------*/
