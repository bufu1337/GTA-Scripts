/*##############################################################################


					#########################################
					#										#
					#	  BUTTONS - TEST GAMEMODE BY YOM	#
					#       Steal my work and die >:D		#
					#                                       #
					#########################################


- Informations about this file:
===============================

	-	This is a example gamemode, about how to use buttons.


##############################################################################*/




#include <a_samp>
#include <yom_buttons>

main(){}

public OnGameModeInit()
{
	AddPlayerClass(0, 1.5, 0.0, 3.0, 0.0, 0, 0, 0, 0, 0, 0);
	
	CreateButton(0.0, 3.0, 3.7);
	CreateButton(3.0, 3.0, 3.7);
	
	return false;
}

public OnPlayerPressButton(playerid, buttonid)
{
	switch(buttonid)
	{
		case 0: SetPlayerHealth(playerid,   0.0);
		case 1: SetPlayerArmour(playerid, 100.0);
	}
	
	return false;
}
