/*

#######                             ######                                     #     #
#       #####  ######  ####  #    # #     #  ####  #    # #####  #      ######  #   #
#       #    # #      #      #    # #     # #    # #    # #    # #      #        # #
#####   #    # #####   ####  ###### #     # #    # #    # #####  #      #####     #
#       #####  #           # #    # #     # #    # #    # #    # #      #        # #
#       #   #  #      #    # #    # #     # #    # #    # #    # #      #       #   #
#       #    # ######  ####  #    # ######   ####   ####  #####  ###### ###### #     #

--------------------------------------------------------------------------------------
					FreshDoubleX - Copyright © 2010
--------------------------------------------------------------------------------------

*/

/* ------- Includes ------- */
#include <a_samp.inc>

/* ----- Defines ----- */
#define Hostname1           "SAMP For The Win!" // This is your hostname 1 - Change it as you want
#define Hostname2           "SAMP Rules!" // This is your hostname 2 - Change it as you want
#define Hostname3           "SAMP is Awesome!" // This is your hostname 3 - Change it as you want

/* --- New Functions/Forwards --- */
new ChangeHostname;
new	ChangeTimer;
forward FlashHostname();

public OnFilterScriptInit()
{
    SendRconCommand("hostname " Hostname1);
	SetTimer("FlashHostname", 1000, true);
	ChangeHostname = 1;
	return 1;
}

public FlashHostname()
{
    ChangeTimer = ChangeTimer + 1;
	if(ChangeTimer == 3)
	{
		switch(ChangeHostname)
		{
		    case 1:
      		{
      		    SendRconCommand("hostname " Hostname1);
				ChangeHostname = 2;

			}
			case 2:
			{
			    SendRconCommand("hostname " Hostname2);
			    ChangeHostname = 3;
			}
			case 3:
			{
			    SendRconCommand("hostname " Hostname3);
				ChangeHostname = 1;
			}
		}
		ChangeTimer = 0;
	}
	return 1;
}