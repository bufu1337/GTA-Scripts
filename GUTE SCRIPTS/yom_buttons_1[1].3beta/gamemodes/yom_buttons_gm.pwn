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
	AddPlayerClass(0, 0.0, 0.0, 3.0, 0.0, 0, 0, 0, 0, 0, 0);
	
	CreateButton( 0.0, 1.5, 3.7);
	CreateButton( 1.5, 1.5, 3.7);
	CreateButton( 3.0, 1.5, 3.7);
	
	return false;
}

public OnPlayerPressButton(playerid, buttonid)
{
	new string[128];

	format(string, sizeof(string), "You pressed the button id %d!!!", buttonid);
	SendClientMessage(playerid, 0x00FF00FF, string);

	switch (buttonid)
	{
		case 1: SetPlayerHealth(playerid,   0.0);
		
		case 2: SetPlayerArmour(playerid, 100.0);
		
		case 3:
		{
			if(!IsPlayerAdmin(playerid))
				SendClientMessage(playerid, 0xFF0000FF, "Hello, login as an rcon admin, and type \"/button\"!");
			else
			    SendClientMessage(playerid, 0xFF0000FF, "Hello, type \"/button\"!");
		}
		
		case 4: SendClientMessage(playerid, 0xFF0000FF, "Well done! You created your first button :D");
	}
	
	return false;
}
