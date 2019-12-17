/*****************************************************************************\
*       ,-----,                                                               *
*      /----/ |                                           ,---,   ,----,      *
*      |    | |      ,------, ,----,  ,----, ,----,  ,---/---/ \ /---/ |      *
*      |    | |     /-----/ |/----/ \/---/ |/----/ \/--- \   \  /   / /       *
*      |    | |     |  ,__|/ |     \|    | ||     \|    | \   \/   / /        *
*      |    | |____ |  ---,/||      \    | ||      \    | |\      / /         *
*      |    |____/ ||  ,__|/ |   ^\      | ||   ^\      | | |    | |          *
*      |         | ||  ---,/||   | \     | /|   | \     | | |    | |          *
*      |_________|/ |_____|/ |___,/ \____,/ |___,/ \____,/  |____,/           *

* Information about THIS module/file/part of project:                         *
*                                                                     		  *
* Allowing civilians to pay the toll guard to open the tolls for them, as     *
* long as the tolls aren't locked by the police.                              *
*                                                                     		  *
* @Author of THIS file:		Lenny                                             *
* @Startdate of THIS file:	22 Dec 09                                         *
\* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////* NOTES *////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/*
	This script requires some configuration to run properly as an include,
	and obviously will only function properly with the LS-RP script.

	It works as a debug version when used as a filterscript, meaning it's not
	configured for a roleplay server - that would require some additional
	configuration.


	§§§§§§§§§§§§§§§§§§§§§§§§§§§[ INSTALL INSTRUCTIONS ]§§§§§§§§§§§§§§§§§§§§§§§§§

    The following functions need to be called in their publics and forwarded:
        - Toll_OnPlayerPickUpPickup(playerid,pickupid)
        - Toll_OnPlayerDisconnect(playerid)
        - Toll_OnPlayerUpdate(playerid)
        - Toll_OnGameModeInit()

    And the commands:
        - ycmd_opentoll(playerid, cmdtext[])
		- ycmd_toll(playerid, cmdtext[])

	Change the define of TollFS to 0.

	Please also take some time to look over the other defines for configuration.

	§§§§§§§§§§§§§§§§§§§§§§§§[ INSTALL INSTRUCTIONS END ]§§§§§§§§§§§§§§§§§§§§§§§§
*/
////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////* SCRIPT *////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// Main configuration
#define TollFS (1) 						// 0 = Include, 1 = Filterscript
#define TollCost (50) 					// How much it costs to pass the tolls
#define TollPayCops (0) 				// Amount of percent that goes to the LSPD and SASD (Ex: 20 = 20% to LSPD, 20% to SASD, total 40% to cops)

#define TollPickupModel (1239) 			// The model of the pickups
#define TollPickupType (14) 			// The type of pickups
#define TollPickupVirtualWorld (-1) 	// The virtual world of the pickups

#define TollDelayCivilian (6) 			// The timespace in seconds between each /opentoll command for the same player
#define TollDelayCop (2) 				// The timespace in seconds between each /toll command for all cops (To avoid spam)
#define TollOpenDistance (8.0) 			// The distance in units the player can be from the icon to open the toll

#define TollTimer (30)				 	// The amount of seconds that tolls are locked normally
#define TollTimerEmergency (60) 		// The amount of seconds that all tolls are locked after /toll emergency

// Other defines
#define MAX_TOLLS (3) // Amount of tolls
#define INVALID_TOLL_ID (-1)
#define RichmanToll (0)
#define FlintToll (1)
#define LVToll (2)

#define L_sz_TollStringLocked ("Toll guard says: I'm sorry, but I can't open this right now. You'll have to come back later.")
#define L_sz_TollStringNoMoney ("You don't have enough money to pay the guard.")
#define L_sz_TollStringBye ("Toll guard says: Thank you, drive safe.")
#define L_sz_TollStringHurryUp ("You have 6 seconds to get past the barrier, make sure you don't get stuck!")

// End of defines
#if TollFS == 1
	#include <a_samp>
#endif

enum E_TOLLDATA
{
	E_tAllowReq, // One timer for each toll
	E_tLocked,  // 0 = Richhman, 1 = Flint, 2 = LV, 3 = Airport
	E_tTimer // 0 = Richhman, 1 = Flint, 2 = LV, 3 = Airport
}
new aTolls[MAX_TOLLS][E_TOLLDATA];

new L_a_RequestAllowedCop, // The same timer for all /toll changes
	L_a_TollPerson[MAX_PLAYERS][2], // 0 = toll ID, 1 = UnixTime+X
	L_a_Pickup[MAX_TOLLS*2],  // 0 & 1 = Richhman, 2 & 3 = Flint, 4 & 5 = LV, 6 = Airport
	L_a_TollObject[MAX_TOLLS*2]; // 0 & 1 = Richhman, 2 & 3 = Flint, 4 & 5 = LV, 6 = Airport

#if TollFS == 1
    #define COLOR_FADE1 0xE6E6E6E6
    #define COLOR_FADE2 0xC8C8C8C8
    #define COLOR_FADE3 0xAAAAAAAA
	#define COLOR_FADE4 0x8C8C8C8C
	#define COLOR_FADE5 0x6E6E6E6E
    #define COLOR_GREY 0xAFAFAFAA
    #define COLOR_RED 0xFF6347AA
    #define COLOR_YELLOW 0xFFFF00AA
    #define COLOR_GRAD2 0xBFC0C2FF
    #define TEAM_BLUE_COLOR 0x8D8DFFC8
    #define COLOR_PURPLE 0xC2A2DAAA
    #define COLOR_GOLD 0xB8860BAA

	forward Toll_OnPlayerPickUpPickup(playerid,pickupid);
	forward Toll_OnPlayerDisconnect(playerid);
	forward Toll_OnPlayerUpdate(playerid);
	forward Toll_OnGameModeInit();

	forward ycmd_opentoll(playerid, cmdtext[]);
	forward ycmd_toll(playerid, cmdtext[]);

	new PDDuty[MAX_PLAYERS];


	#define IsNull(%1) \
	    ((%1[0] == 0) || (%1[0] == 1 && %1[1] == 0))

	public OnPlayerPickUpPickup(playerid,pickupid)
	{
	    Toll_OnPlayerPickUpPickup(playerid,pickupid);
	}
	public OnPlayerDisconnect(playerid)
	{
	    Toll_OnPlayerDisconnect(playerid);
	}
	public OnPlayerUpdate(playerid)
	{
        Toll_OnPlayerUpdate(playerid);
        return 1;
	}
	public OnFilterScriptInit()
	{
	    Toll_OnGameModeInit();
	}

	public OnPlayerCommandText(playerid, cmdtext[])
	{
	    if(!strcmp(cmdtext, "/opentoll", true, 9))
	    {
	        return ycmd_opentoll(playerid, cmdtext);
		}
		if(!strcmp(cmdtext, "/toll", true, 5))
		{
		    return ycmd_toll(playerid, cmdtext);
		}
		if(!strcmp(cmdtext, "/cash", true, 5))
		{
		    return GivePlayerMoney(playerid, 500);
		}
		if(!strcmp(cmdtext, "/duty", true, 5))
		{
		    if(PDDuty[playerid])
		    {
		        PDDuty[playerid] = 0;
		        SendClientMessage(playerid, TEAM_BLUE_COLOR, "You're now OFF duty.");
			}
			else
			{
			    PDDuty[playerid] = 1;
                SendClientMessage(playerid, TEAM_BLUE_COLOR, "You're now ON duty.");
			}
			return 1;
		}
		return 0;
	}

	stock ProxDetector(Float:radi, playerid, string[], col1, col2, col3, col4, col5)
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(GetPlayerVirtualWorld(i)==GetPlayerVirtualWorld(playerid))
				{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);
					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
						SendClientMessage(i, col1, string);
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
						SendClientMessage(i, col2, string);
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
						SendClientMessage(i, col3, string);
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
						SendClientMessage(i, col4, string);
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
						SendClientMessage(i, col5, string);
				}
			}
			else
				SendClientMessage(i,col1,string);
		}
		return 1;
	}

	GetUnixTime()
	{
	    return gettime();
	}

	CreateDynamicObj(modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, titties)
	{
	    titties++;
	    return CreateObject(modelid, X, Y, Z, rX, rY, rZ);
	}

	SetDynamicObjectRot(objectid, Float:RotX, Float:RotY, Float:RotZ)
	{
		return SetObjectRot(objectid, RotX, RotY, RotZ);
	}

	GetICName(playerid)
	{
		new name[MAX_PLAYER_NAME];
		GetPlayerName(playerid, name, MAX_PLAYER_NAME);
		return name;
	}

	stock strtok(const string[], &index)
	{
		new length = strlen(string);
		while ((index < length) && (string[index] <= ' '))
		{
			index++;
		}

		new offset = index;
		new result[20];
		while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
		{
			result[index - offset] = string[index];
			index++;
		}
		result[index - offset] = EOS;
		return result;
	}

	SendTeamTypeMessage(nothing, color, string[])
	{
	    nothing++;
	    return SendClientMessageToAll(color, string);
	}
#endif

public Toll_OnPlayerPickUpPickup(playerid, pickupid) // Needs forwarding in the OnPlayerPickup function of the script
{
    if(pickupid == L_a_Pickup[0] || pickupid == L_a_Pickup[1] || pickupid == L_a_Pickup[2] || pickupid == L_a_Pickup[3] || pickupid == L_a_Pickup[4] || pickupid == L_a_Pickup[5])
	{
		if(PDDuty[playerid])
		{
			ProxDetector(20.0, playerid, "Toll guard says: Hello officer, would you like to pass?", COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
			SendClientMessage(playerid, COLOR_GOLD, "Use \"/opentoll\" to open the toll.");
			return 1;
		}
		new szCostString[56];
		format(szCostString, 56, "Toll guard says: Hello, the toll is %d dollars please.", TollCost);
		ProxDetector(20.0, playerid, szCostString, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
		SendClientMessage(playerid, COLOR_GOLD, "Use \"/opentoll\" to pay the guard.");
	}
	return 1;
}

public Toll_OnPlayerDisconnect(playerid) // And this needs forwarding in the OnPlayerDisconnect function of the script
{
	if(L_a_TollPerson[playerid][0] != INVALID_TOLL_ID)
	{
	    Toll_CloseToll(L_a_TollPerson[playerid][0]);
	    L_a_TollPerson[playerid][0] = 0;
	}
}

public Toll_OnPlayerUpdate(playerid) // Needs to be called in the OnPlayerUpdate function
{
	if(L_a_TollPerson[playerid][0] != INVALID_TOLL_ID)
	{
	    if(GetUnixTime() > L_a_TollPerson[playerid][1])
	    {
	        Toll_CloseToll(L_a_TollPerson[playerid][0]);
	        L_a_TollPerson[playerid][0] = 0;
		}

		else
		{
		    switch(L_a_TollPerson[playerid][0])
		    {
		        case RichmanToll:
		        {
				    if(IsPlayerInRangeOfPoint(playerid, 1.0, 619.2152, -1174.6862, 20.5124) || IsPlayerInRangeOfPoint(playerid, 1.0, 612.2329, -1202.9524, 18.1094))
				    {
		                Toll_CloseToll(L_a_TollPerson[playerid][0]);
	        			L_a_TollPerson[playerid][0] = 0;
					}
				}

				case FlintToll:
				{
				    if(IsPlayerInRangeOfPoint(playerid, 1.0, 29.2651,-1521.5536,4.8644) || IsPlayerInRangeOfPoint(playerid, 1.0, 73.2545, -1541.4111, 5.2093))
				    {
		                Toll_CloseToll(L_a_TollPerson[playerid][0]);
	        			L_a_TollPerson[playerid][0] = 0;
					}
				}

				case LVToll:
				{
				    if(IsPlayerInRangeOfPoint(playerid, 1.0, 1797.5039, 714.3255, 14.4545) || IsPlayerInRangeOfPoint(playerid, 1.0, 1775.9889, 691.7012, 15.9699))
				    {
		                Toll_CloseToll(L_a_TollPerson[playerid][0]);
	        			L_a_TollPerson[playerid][0] = 0;
					}
				}
			}
		}
	}
}

public Toll_OnGameModeInit() // Needs to be called in the OnGameModeInit function!
{ // Thanks to Nexus for mapping!

	printf("Initializing toll system...");
	printf("____________________________________");
	printf("                  (c) Lenny 2010    ");

	for(new i; i < MAX_PLAYERS; i++)
	    L_a_TollPerson[i][0] = INVALID_TOLL_ID;

	/* Richman */
	CreateDynamicObj( 8168, 612.73895263672, -1191.4602050781, 20.294105529785, 0.000000, 5, 318.31237792969, -1 );
	CreateDynamicObj( 8168, 620.47265625, -1188.49609375, 20.044105529785, 0.000000, 352.99621582031, 138.94409179688, -1 );
	CreateDynamicObj( 966, 613.97229003906, -1197.7174072266, 17.475030899048, 0.000000, 0.000000, 23.81982421875, -1 );
	CreateDynamicObj( 997, 614.33209228516, -1194.3870849609, 17.709369659424, 0.000000, 0.000000, 266.70568847656, -1 );
	CreateDynamicObj( 973, 602.98425292969, -1202.1643066406, 18.000516891479, 0.000000, 0.000000, 19.849853515625, -1 );
	L_a_TollObject[0] = CreateDynamicObj( 968, 613.8935546875, -1197.7329101563, 18.109180450439, 0.000000, -90.000000, 23.81982421875, -1 );
	CreateDynamicObj( 966, 619.42913818359, -1181.6597900391, 18.725030899048, 0.000000, 0.000000, 214.37744140625, -1 );
	CreateDynamicObj( 973, 629.68823242188, -1176.0551757813, 19.500516891479, 0.000000, 0.000000, 21.831787109375, -1 );
	CreateDynamicObj( 997, 619.26574707031, -1181.6518554688, 18.709369659424, 0.000000, 0.000000, 268.68908691406, -1 );
	L_a_TollObject[1] = CreateDynamicObj( 968, 619.44201660156, -1181.6903076172, 19.525806427002, 0.000000, -90.000000, 214.37744140625, -1 );
	/* End of Richman */

	/* Flint */
	CreateDynamicObj( 8168, 61.256042480469, -1533.3946533203, 6.1042537689209, 0.000000, 0.000000, 9.9252624511719, -1 );
	CreateDynamicObj( 8168, 40.966598510742, -1529.5725097656, 6.1042537689209, 0.000000, 0.000000, 188.5712890625, -1 );
	L_a_TollObject[2] = CreateDynamicObj( 968, 35.838928222656, -1525.9034423828, 5.0012145042419, 0.000000, -90.000000, 270.67565917969, -1 );
	CreateDynamicObj( 966, 35.889751434326, -1526.0096435547, 4.2410612106323, 0.000000, 0.000000, 270.67565917969, -1 );
	CreateDynamicObj( 966, 67.093727111816, -1536.8275146484, 3.9910612106323, 0.000000, 0.000000, 87.337799072266, -1 );
	L_a_TollObject[3] = CreateDynamicObj( 968, 67.116600036621, -1536.8218994141, 4.7504549026489, 0.000000, -90.000000, 87.337799072266, -1 );
	CreateDynamicObj( 973, 52.9794921875, -1531.9252929688, 5.090488910675, 0.000000, 0.000000, 352.06005859375, -1 );
	CreateDynamicObj( 973, 49.042072296143, -1531.5065917969, 5.1758694648743, 0.000000, 0.000000, 352.05688476563, -1 );
	CreateDynamicObj( 997, 68.289916992188, -1546.6020507813, 4.0626411437988, 0.000000, 0.000000, 119.09942626953, -1 );
	CreateDynamicObj( 997, 34.5198097229, -1516.1402587891, 4.0626411437988, 0.000000, 0.000000, 292.50622558594, -1 );
	CreateDynamicObj( 997, 35.903915405273, -1525.8717041016, 4.0626411437988, 0.000000, 0.000000, 342.13012695313, -1 );
	CreateDynamicObj( 997, 63.914081573486, -1535.7126464844, 4.0626411437988, 0.000000, 0.000000, 342.130859375, -1 );
	/* End of Flint */

	/* LV */
	CreateDynamicObj( 8168, 1789.83203125, 703.189453125, 15.846367835999, 0.000000, 3, 99.24951171875, -1 );
	CreateDynamicObj( 8168, 1784.8334960938, 703.94799804688, 16.070636749268, 0.000000, 357, 278.61096191406, -1 );
	CreateDynamicObj( 966, 1781.4122314453, 697.32531738281, 14.636913299561, 0.000000, 0.000000, 348.09008789063, -1 );
	CreateDynamicObj( 996, 1767.3087158203, 700.50506591797, 15.281567573547, 0.000000, 0.000000, 346.10510253906, -1 );
	CreateDynamicObj( 997, 1781.6832275391, 697.34796142578, 14.698781013489, 0.000000, 3, 77.41455078125, -1 );
	CreateDynamicObj( 997, 1792.7745361328, 706.38543701172, 13.948781013489, 0.000000, 2.999267578125, 81.379638671875, -1 );
	CreateDynamicObj( 966, 1793.4289550781, 709.87982177734, 13.636913299561, 0.000000, 0.000000, 169.43664550781, -1 );
	CreateDynamicObj( 996, 1800.8060302734, 708.38299560547, 14.281567573547, 0.000000, 0.000000, 346.10229492188, -1 );
	L_a_TollObject[4] = CreateDynamicObj( 968, 1781.4133300781, 697.31750488281, 15.420023918152, 0.000000, -90.000000, 348.10229492188, -1 );
	L_a_TollObject[5] = CreateDynamicObj( 968, 1793.6700439453, 709.84631347656, 14.405718803406, 0.000000, -90.000000, 169.43664550781, -1 );
	/* End of LV */

	Toll_CreateTollPickup(L_a_Pickup[0], 623.9500, -1183.9774, 19.2260); //  Richman 1
	Toll_CreateTollPickup(L_a_Pickup[1], 607.9684, -1194.2866, 19.0043); // Richman 2
    Toll_CreateTollPickup(L_a_Pickup[2], 39.7039, -1522.9891, 5.1995); // Flint 1
	Toll_CreateTollPickup(L_a_Pickup[3], 62.7378, -1539.9891, 5.0639); // Flint 2
    Toll_CreateTollPickup(L_a_Pickup[4], 1795.9447, 704.2550, 15.0006); // LV 1
    Toll_CreateTollPickup(L_a_Pickup[5], 1778.9886, 702.6728, 15.2574); // LV 2
}

Toll_CloseToll(TollID)
{
	if(TollID == RichmanToll)
	{
        SetDynamicObjectRot(L_a_TollObject[0], 0.000000, -90.000000, 23.81982421875);
	    SetDynamicObjectRot(L_a_TollObject[1], 0.000000, -90.000000, 214.37744140625);

	    Toll_CreateTollPickup(L_a_Pickup[0], 623.9500, -1183.9774, 19.2260); //  Richman 1
	    Toll_CreateTollPickup(L_a_Pickup[1], 607.9684, -1194.2866, 19.0043); // Richman 2
	}

	else if(TollID == FlintToll)
	{
	    SetDynamicObjectRot(L_a_TollObject[2], 0.000000, -90.000000, 270.67565917969);
	    SetDynamicObjectRot(L_a_TollObject[3], 0.000000, -90.000000, 87.337799072266);

	    Toll_CreateTollPickup(L_a_Pickup[2], 39.7039, -1522.9891, 5.1995); // Flint 1
	    Toll_CreateTollPickup(L_a_Pickup[3], 62.7378, -1539.9891, 5.0639); // Flint 2
	}

	else if(TollID == LVToll)
	{
	    SetDynamicObjectRot(L_a_TollObject[4], 0.000000, -90.000000, 348.10229492188);
	    SetDynamicObjectRot(L_a_TollObject[5], 0.000000, -90.000000, 169.43664550781);

	    Toll_CreateTollPickup(L_a_Pickup[4], 1795.9447, 704.2550, 15.0006); // LV 1
	    Toll_CreateTollPickup(L_a_Pickup[5], 1778.9886, 702.6728, 15.2574); // LV 2
	}
	return 1;
}


Toll_OpenToll(TollID, playerid)
{
	if(TollID == RichmanToll)
	{
		L_a_TollPerson[playerid][0] = RichmanToll;
		L_a_TollPerson[playerid][1] = (GetUnixTime() + 6);

        SetDynamicObjectRot(L_a_TollObject[0], 0.000000, 0.000000, 23.81982421875);
	    SetDynamicObjectRot(L_a_TollObject[1], 0.000000, 0.000000, 214.37744140625);

	    Toll_DestroyTollPickup(L_a_Pickup[0]); //  Richman 1
	    Toll_DestroyTollPickup(L_a_Pickup[1]); // Richman 2

	    L_a_Pickup[0] = 0;
	    L_a_Pickup[1] = 0;
	}

	else if(TollID == FlintToll)
	{
		L_a_TollPerson[playerid][0] = FlintToll;
		L_a_TollPerson[playerid][1] = (GetUnixTime() + 6);

	    SetDynamicObjectRot(L_a_TollObject[2], 0.000000, 0.000000, 270.67565917969);
	    SetDynamicObjectRot(L_a_TollObject[3], 0.000000, 0.000000, 87.337799072266);

	    Toll_DestroyTollPickup(L_a_Pickup[2]); // Flint 1
	    Toll_DestroyTollPickup(L_a_Pickup[3]); // Flint 2

	    L_a_Pickup[2] = 0;
	    L_a_Pickup[3] = 0;
	}

	else if(TollID == LVToll)
	{
		L_a_TollPerson[playerid][0] = LVToll;
		L_a_TollPerson[playerid][1] = (GetUnixTime() + 6);

	    SetDynamicObjectRot(L_a_TollObject[4], 0.000000, 0.000000, 348.10229492188);
	    SetDynamicObjectRot(L_a_TollObject[5], 0.000000, 0.000000, 169.43664550781);

	    Toll_DestroyTollPickup(L_a_Pickup[4]); // LV 1
	    Toll_DestroyTollPickup(L_a_Pickup[5]); // LV 2

	    L_a_Pickup[4] = 0;
	    L_a_Pickup[5] = 0;
	}
}

Toll_TimePassedCivil(TollID, playerid) // People have to wait <TollDelayCivilian> seconds between every /opentoll on the same toll
{
	new L_i_tick = GetUnixTime();
	if(L_a_Pickup[TollID*2])
	{
	    SendClientMessage(playerid, COLOR_RED, "The barrier is already open, wait for it to close before you pay.");
	    return 0;
	}
	if(aTolls[TollID][E_tAllowReq] > L_i_tick && aTolls[TollID][E_tAllowReq] != 0)
	{
	    new TollString[64];
		format(TollString, 64, "You need to wait at least %d seconds since the last time opened.", TollDelayCivilian);
		SendClientMessage(playerid, COLOR_RED, TollString);
		return 0;
	}
	aTolls[TollID][E_tAllowReq] = (L_i_tick + TollDelayCivilian);
	return 1;
}

Toll_TimePassedCops(playerid) // Cops have to wait for <TollDelayCop> seconds between every /toll (Global)
{
	new L_i_tick = GetUnixTime();
	if(L_a_RequestAllowedCop > L_i_tick && L_a_RequestAllowedCop != 0)
	{
	    new TollString[63];
		format(TollString, 63, "You need to wait at least %d seconds between each toll change.", TollDelayCop);
		SendClientMessage(playerid, COLOR_RED, TollString);
		return 0;
	}
	L_a_RequestAllowedCop = (L_i_tick + TollDelayCop);
	return 1;
}

Toll_CreateTollPickup(PickupID, Float:X, Float:Y, Float:Z) // This prevents more than one icon from being spawned at the same time
{
	if(PickupID != 0)
	    DestroyPickup(PickupID);
	PickupID = CreatePickup(TollPickupModel, TollPickupType, Float:X, Float:Y, Float:Z, TollPickupVirtualWorld);
	return 1;
}

Toll_DestroyTollPickup(PickupID)
{
	DestroyPickup(PickupID);
	PickupID = 0;
	return 1;
}

public ycmd_opentoll(playerid, cmdtext[])
{
	#if TollFS == 0
		if (cmdtext[0] == 1) cmdtext[0] = 0;

		if(!gPlayerLogged[playerid])
		{
		    SendClientMessage(playerid, COLOR_RED, "You are not logged in.");
			return 1;
		}
	#endif

 	new L_i_TollID;

	if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, 623.9500, -1183.9774, 19.2260) || IsPlayerInRangeOfPoint(playerid, 10.0, 607.9684, -1194.2866, 19.0043)) // Richman tolls
	{
		L_i_TollID = RichmanToll;
	}

	else if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, 39.7039, -1522.9891, 5.1995) || IsPlayerInRangeOfPoint(playerid, 10.0, 62.7378, -1539.9891, 5.0639)) // Flint tolls
    {
        L_i_TollID = FlintToll;
    }

	else if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, 1795.9447, 704.2550, 15.0006) || IsPlayerInRangeOfPoint(playerid, 10.0, 1778.9886, 702.6728, 15.2574)) // LV tolls
	{
        L_i_TollID = LVToll;
 	}

    else
    {
	    SendClientMessage(playerid, COLOR_RED, "You are not close enough to a toll booth.");
	    return 1;
    }

 	if(!Toll_TimePassedCivil(L_i_TollID, playerid))
  	    return 1;

    new L_sz_MessageString[156];
    if(!PDDuty[playerid])
	{
	    if(aTolls[L_i_TollID][E_tLocked] && aTolls[L_i_TollID][E_tTimer] > GetUnixTime()) // If it's locked
	    {
	        ProxDetector(20.0, playerid, L_sz_TollStringLocked, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
			return 1;
		}
		else if(aTolls[L_i_TollID][E_tLocked]) // If it's time to be unlocked
		{
		    aTolls[L_i_TollID][E_tLocked] = 0;
			new szTollsUnlocked[100];
			switch(L_i_TollID)
			{
				case RichmanToll:
				{
				    format(szTollsUnlocked, 100, "** HQ Announcement: The Richman tolls were automatically unlocked after the timer finished. **");
			    }
			    case FlintToll:
			    {
			    	format(szTollsUnlocked, 100, "** HQ Announcement: The Flint tolls were automatically unlocked after the timer finished. **");
			    }
			    case LVToll:
			    {
			    	format(szTollsUnlocked, 100, "** HQ Announcement: The Las Venturas tolls were automatically unlocked after the timer finished. **");
			    }
			}
		    #if !defined foreach
				#define foreach(%1,%2) for (new %2 = 0; %2 < MAX_PLAYERS; %2++) if (IsPlayerConnected(%2))
			#endif
			foreach(Player, i)
			{
			    if(PDDuty[i])
			        SendClientMessage(i, TEAM_BLUE_COLOR, szTollsUnlocked);
			}
		}
		if(GetPlayerMoney(playerid) < TollCost)
		{
		    SendClientMessage(playerid, COLOR_RED, L_sz_TollStringNoMoney);
		    return 1;
		}
		format(L_sz_MessageString, 156, "%s paid %d$ to the toll guard.", GetICName(playerid), TollCost);
		GivePlayerMoney(playerid, -TollCost);
		ProxDetector(20.0, playerid, L_sz_MessageString, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
		#if TollFS == 0
	        PlayerInfo[playerid][pCash] -= TollCost;
			#if TollPayCops > 0
		        FactionInfo[1][fFunds] += (TollCost/100)*TollPayCops;
		        FactionInfo[6][fFunds] += (TollCost/100)*TollPayCops;
	        #endif
        #endif
	}

	ProxDetector(20.0, playerid, L_sz_TollStringBye, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
	SendClientMessage(playerid, COLOR_RED, L_sz_TollStringHurryUp);

	Toll_OpenToll(L_i_TollID, playerid);
	return 1;
}

public ycmd_toll(playerid, cmdtext[])
{
    #if TollFS == 0
		if(cmdtext[0] == 1) cmdtext[0] = 0;

		if(!gPlayerLogged[playerid])
		{
		    SendClientMessage(playerid, COLOR_RED, "You are not logged in.");
			return 1;
		}
	#endif

	new idx,
	    L_sz_Input[256],
		L_sz_CopName[MAX_PLAYER_NAME],
		L_sz_MessageString[256],
		L_sz_Rank[56],
		L_sz_Faction[8];
	#if TollFS == 0
		if(!PolicePermission(playerid))
		{
		    SendClientMessage(playerid, COLOR_RED, "You're not a cop, cowboy.");
		    return 1;
		}

		format(L_sz_Rank, 56, "%s", FactionRank(PlayerInfo[playerid][pFamily], PlayerInfo[playerid][pFamilyRank]));
		format(L_sz_Faction, 8, "%s", FactionInfo[PlayerInfo[playerid][pFamily]][fName]);
	#else
		format(L_sz_Rank, 56, "Rank");
		format(L_sz_Faction, 8, "Faction");
		strtok(cmdtext, idx);
	#endif
	format(L_sz_CopName, MAX_PLAYER_NAME, GetICName(playerid));
	L_sz_Input = strtok(cmdtext, idx);

	if(IsNull(L_sz_Input))
	{
	    SendClientMessage(playerid, COLOR_YELLOW, "Toll barrier command central for Los Santos");
	    SendClientMessage(playerid, COLOR_GRAD2, "emergency/release - (Un)Locks all the barriers.");
	    SendClientMessage(playerid, COLOR_GRAD2, "flint - (Un)locks flint tolls.");
	    SendClientMessage(playerid, COLOR_GRAD2, "richman - (Un)locks Richman tunnel tolls.");
	    SendClientMessage(playerid, COLOR_GRAD2, "lv - (Un)locks the Las Venturas Highway tolls.");
	    return 1;
	}

	if(!Toll_TimePassedCops(playerid))
	    return 1;

    if(strcmp(L_sz_Input, "emergency", true, strlen(L_sz_Input)) == 0)
	{
	    aTolls[FlintToll][E_tLocked] = 1;
	    aTolls[RichmanToll][E_tLocked] = 1;
	    aTolls[LVToll][E_tLocked] = 1;

	    Toll_CloseToll(FlintToll);
	    Toll_CloseToll(RichmanToll);
	    Toll_CloseToll(LVToll);

	    new L_i_Time = (GetUnixTime() + TollTimerEmergency);
	    aTolls[FlintToll][E_tTimer] = L_i_Time;
	    aTolls[RichmanToll][E_tTimer] = L_i_Time;
	    aTolls[LVToll][E_tTimer] = L_i_Time;

	    format(L_sz_MessageString, 256, "** HQ Announcement: All toll booths were LOCKED by %s %s (%s)! **", L_sz_Rank, L_sz_CopName, L_sz_Faction);
	    SendTeamTypeMessage(1, TEAM_BLUE_COLOR, L_sz_MessageString);
	}
	else if(strcmp(L_sz_Input, "release", true, strlen(L_sz_Input)) == 0)
	{
	    aTolls[FlintToll][E_tLocked] = 0;
	    aTolls[RichmanToll][E_tLocked] = 0;
	    aTolls[LVToll][E_tLocked] = 0;

	    format(L_sz_MessageString, 256, "** HQ Announcement: All toll booths were UNLOCKED by %s %s (%s)! **", L_sz_Rank, L_sz_CopName, L_sz_Faction);
	    SendTeamTypeMessage(1, TEAM_BLUE_COLOR, L_sz_MessageString);
	}

	else if(strcmp(L_sz_Input, "flint", true, strlen(L_sz_Input)) == 0)
	{
	    if(aTolls[FlintToll][E_tLocked] == 0)
	    {
	        aTolls[FlintToll][E_tLocked] = 1;
	        aTolls[FlintToll][E_tTimer] = (GetUnixTime() + TollTimer);
	        Toll_CloseToll(FlintToll);
		    format(L_sz_MessageString, 256, "** HQ Announcement: Toll booths at Flint County were LOCKED by %s %s (%s). **", L_sz_Rank, L_sz_CopName, L_sz_Faction);
		    SendTeamTypeMessage(1, TEAM_BLUE_COLOR, L_sz_MessageString);
		}
		else
		{
		    aTolls[FlintToll][E_tLocked] = 0;
		    format(L_sz_MessageString, 256, "** HQ Announcement: Toll booths at Flint County were UNLOCKED by %s %s (%s). **", L_sz_Rank, L_sz_CopName, L_sz_Faction);
		    SendTeamTypeMessage(1, TEAM_BLUE_COLOR, L_sz_MessageString);
		}
	}

	else if(strcmp(L_sz_Input, "richman", true, strlen(L_sz_Input)) == 0)
	{
	    if(aTolls[RichmanToll][E_tLocked] == 0)
	    {
	        aTolls[RichmanToll][E_tLocked] = 1;
	        aTolls[RichmanToll][E_tTimer] = (GetUnixTime() + TollTimer);
	        Toll_CloseToll(RichmanToll);
		    format(L_sz_MessageString, 256, "** HQ Announcement: Toll booths at Richman were LOCKED by %s %s (%s). **", L_sz_Rank, L_sz_CopName, L_sz_Faction);
		    SendTeamTypeMessage(1, TEAM_BLUE_COLOR, L_sz_MessageString);
	    }
	    else
	    {
	        aTolls[RichmanToll][E_tLocked] = 0;
		    format(L_sz_MessageString, 256, "** HQ Announcement: Toll booths at Richman were UNLOCKED by %s %s (%s). **", L_sz_Rank, L_sz_CopName, L_sz_Faction);
		    SendTeamTypeMessage(1, TEAM_BLUE_COLOR, L_sz_MessageString);
	    }
	}

	else if(strcmp(L_sz_Input, "lv", true) == 0)
	{
	    if(aTolls[LVToll][E_tLocked] == 0)
	    {
	        aTolls[LVToll][E_tLocked] = 1;
	        aTolls[LVToll][E_tTimer] = (GetUnixTime() + TollTimer);
	        Toll_CloseToll(LVToll);
		    format(L_sz_MessageString, 256, "** HQ Announcement: Toll booths at Las Venturas were LOCKED by %s %s (%s). **", L_sz_Rank, L_sz_CopName, L_sz_Faction);
		    SendTeamTypeMessage(1, TEAM_BLUE_COLOR, L_sz_MessageString);
	    }
	    else
	    {
	        aTolls[LVToll][E_tLocked] = 0;
		    format(L_sz_MessageString, 256, "** HQ Announcement: Toll booths at Las Venturas were UNLOCKED by %s %s (%s). **", L_sz_Rank, L_sz_CopName, L_sz_Faction);
		    SendTeamTypeMessage(1, TEAM_BLUE_COLOR, L_sz_MessageString);
	    }
	}
	return 1;
}