
#include <a_samp>
#include <core>
#include <float>

#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_RED 0xFF0000AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_ORANGE 0xFF9900AA


forward ClearPlayerChatBox(playerid);


	if(strcmp(cmd, "/menu", true) == 0)
		{
	    
	    {
			ShowMenuForPlayer(playerid);
		    return 1;
		}
		else
		{
			ClearPlayerChatBox(playerid);
		    SendClientMessage(playerid, COLOR_RED, "You aren't logged in!"); }
		    return 1;
		}

	if(strcmp(cmd, "/menu5", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Menu 1 (1st list of interior catagories)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/air - for all things aerodynamic (6)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/lib - locations in Liberty City (2)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/str - strip club interiors (3)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gar - garage interiors (3)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Type /menu2 to see the 2nd list of catagories");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

	if(strcmp(cmd, "/menu6", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Menu 2 (2nd list of interior catagories)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/war - warehouse interiors (3)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/cas - casino oddities (3)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus - businesses (6)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gov - government run organizations (6)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Type /menu1 to go to the 1st list of catagories");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

	if(strcmp(cmd, "/air", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Aerodynamic Interiors");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/air1 - LS Int Airport (baggage reclaim)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/air2 - Verdant Meadow AC Tower");
		    SendClientMessage(playerid, COLOR_YELLOW, "/air3 - LS Customs Cabin");
		    SendClientMessage(playerid, COLOR_YELLOW, "/air4 - SF Customs Cabin (main gates)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/air5 - SF Customs Cabin (rear gates)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/air6 - LV Customs Cabin");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

	if(strcmp(cmd, "/air1", true)==0)
		{
			SetPlayerInterior(playerid, 14);
      		SetPlayerFacingAngle(playerid, 125);
	        SetPlayerPos(playerid, -1856.061401,59.451751,1056.354492);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: -1856.061401");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 59.451751");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1056.354492");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 125");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 14");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Los Santos International Airport (baggage reclaim)");
		    SendClientMessage(playerid, COLOR_RED, "DO NOT MOVE, ROOM ISN'T SOLID!");
		    return 1;
		}

	if(strcmp(cmd, "/air2", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 180);
	        SetPlayerPos(playerid, 412.940093,2543.499267,26.582641);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 412.940093");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 2543.499267");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 26.582641");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 180");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Verdant Meadow Abandoned AC Tower");
		    SendClientMessage(playerid, COLOR_YELLOW, "Nice view =)");
		    return 1;
		}


	if(strcmp(cmd, "/air3", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 270);
	        SetPlayerPos(playerid, 1955.634033,-2181.589355,13.586477);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1955.634033");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -2181.589355");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 13.586477");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 270");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Los Santos Customs Cabin");
		    SendClientMessage(playerid, COLOR_YELLOW, "It's empty, no furniture =O");
		    return 1;
		}


	if(strcmp(cmd, "/air4", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 45);
	        SetPlayerPos(playerid, -1544.394897,-443.713562,6.100000);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: -1544.394897");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -443.713562");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 6.100000");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 45");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "San Fiero Customs Cabin (main gates)");
		    SendClientMessage(playerid, COLOR_YELLOW, "Furniture isn't solid");
		    return 1;
		}

	if(strcmp(cmd, "/air5", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 320);
	        SetPlayerPos(playerid, -1229.471191,55.351161,14.232812);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: -1229.471191");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 55.351161");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 14.232812");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 320");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "San Fiero Customs Cabin (rear gates)");
		    SendClientMessage(playerid, COLOR_YELLOW, "Furniture isn't solid");
		    return 1;
		}

	if(strcmp(cmd, "/air6", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 160);
	        SetPlayerPos(playerid, 1717.427612,1617.371337,10.117187);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1717.427612");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 1617.371337");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 10.117187");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 160");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Las Venturas Customs Cabin");
		    SendClientMessage(playerid, COLOR_YELLOW, "All complete (would be good for roleplay)");
		    return 1;
		}

	if(strcmp(cmd, "/lib", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Locations In Liberty City");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/lib1 - Liberty City Crossroads");
		    SendClientMessage(playerid, COLOR_YELLOW, "/lib2 - Liberty City Back Ally");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

	if(strcmp(cmd, "/lib1", true)==0)
		{
			SetPlayerInterior(playerid, 1);
      		SetPlayerFacingAngle(playerid, 270);
	        SetPlayerPos(playerid, -900.698913,458.643615,1346.875000);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: -900.698913");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 458.643615");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1346.875000");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 270");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 1");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Liberty City Crossroads");
		    SendClientMessage(playerid, COLOR_RED, "North, West, and South roads are NON-SOLID!");
		    return 1;
		}

	if(strcmp(cmd, "/lib2", true)==0)
		{
			SetPlayerInterior(playerid, 1);
      		SetPlayerFacingAngle(playerid, 90);
	        SetPlayerPos(playerid, -742.647227,568.901855,1371.618041);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: -742.647227");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 568.901855");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1371.618041");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 90");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 1");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Liberty City Back Ally");
		    SendClientMessage(playerid, COLOR_RED, "Only snow is solid, DO NOT LEAVE INTO THE STREETS!");
		    return 1;
		}

	if(strcmp(cmd, "/str", true) == 0)
		{
	        SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Strip Club Interiors");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/str1 - Big Spread Ranch");
		    SendClientMessage(playerid, COLOR_YELLOW, "/str2 - Big Spread Ranch (private dance room)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/str3 - Big Spread Ranch (behind bar)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

	if(strcmp(cmd, "/str1", true)==0)
		{
			SetPlayerInterior(playerid, 3);
      		SetPlayerFacingAngle(playerid, 90);
	        SetPlayerPos(playerid, 1215.219726,-30.991367,1000.960571);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1215.219726");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -30.991367");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1000.960571");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 90");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 3");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Big Spread Ranch");
		    SendClientMessage(playerid, COLOR_YELLOW, "Also same interior as 'Nude Strippers Daily'");
		    return 1;
		}

	if(strcmp(cmd, "/str2", true)==0)
		{
			SetPlayerInterior(playerid, 3);
      		SetPlayerFacingAngle(playerid, 180);
	        SetPlayerPos(playerid, 1207.651123,-42.554019,1000.953125);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1207.651123");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -42.554019");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1000.953125");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 180");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 3");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Big Spread Ranch (private dance room)");
		    SendClientMessage(playerid, COLOR_RED, "ONLY THE FLOOR IS SOLID!");
		    return 1;
		}

	if(strcmp(cmd, "/str3", true)==0)
		{
			SetPlayerInterior(playerid, 3);
      		SetPlayerFacingAngle(playerid, 270);
	        SetPlayerPos(playerid, 1206.233398,-29.270675,1000.953125);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1206.233398");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -29.270675");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1000.953125");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 270");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 3");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Big Spread Ranch (behind bar)");
		    SendClientMessage(playerid, COLOR_YELLOW, "You've never been here, roof is too low to jump ;)");
		    return 1;
		}

	if(strcmp(cmd, "/gar", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Garage Interiors");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gar1 - Garage in Esplanade North, SF");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gar2 - Garage in Commerce, LS");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gar3 - SF Bomb Shop");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

	if(strcmp(cmd, "/gar1", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 0);
	        SetPlayerPos(playerid, -1790.264160,1432.254638,7.187500);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: -1790.264160");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 1432.254638");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 7.187500");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 0");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Garage in Esplanade North, at the docks");
		    SendClientMessage(playerid, COLOR_YELLOW, "Used in a mission cut scene for storage");
		    return 1;
		}

	if(strcmp(cmd, "/gar2", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 0);
	        SetPlayerPos(playerid, 1644.026489,-1518.588500,13.567542);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1644.026489");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -1518.588500");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 13.567542");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 0");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Garage in Commerce, Los Santos");
		    SendClientMessage(playerid, COLOR_YELLOW, "Used in mission 'Life's a Beach' for OG Loc");
		    return 1;
		}


	if(strcmp(cmd, "/gar3", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 90);
	        SetPlayerPos(playerid, -1684.447631,1035.754516,45.210937);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: -1684.447631");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 1035.754516");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 45.210937");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 90");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "San Fiero Bomb Shop");
		    SendClientMessage(playerid, COLOR_YELLOW, "Remember this?");
		    return 1;
		}


	if(strcmp(cmd, "/war", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Warehouse Interiors");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/war1 - Warehouse in Blueberry, RC");
		    SendClientMessage(playerid, COLOR_YELLOW, "/war2 - Warehouse in Whitewood Estates, LV (part 1)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/war3 - Warehouse in Whitewood Estates, LV (part 2)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

	if(strcmp(cmd, "/war1", true)==0)
		{
	    	SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 180);
	        SetPlayerPos(playerid, 52.093002,-302.419616,1.700098);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 52.093002");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -302.419616");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1.700098");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 180");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Warehouse in Blueberry, Red County");
		    SendClientMessage(playerid, COLOR_YELLOW, "Good for a hideout, can't remember it ever being used");
		    return 1;
		}

	if(strcmp(cmd, "/war2", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 270);
	        SetPlayerPos(playerid, 1058.787353,2087.521240,10.820312);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1058.787353");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 2087.521240");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 10.820312");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 270");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Warehouse in Whitewood Estates, Las Venturas");
		    SendClientMessage(playerid, COLOR_YELLOW, "Used in mission 'You've Had Your Chips' for Woozie");
		    return 1;
		}
	if(strcmp(cmd, "/war3", true)==0)
		{
  			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 270);
	        SetPlayerPos(playerid, 1057.757446,2148.187988,10.820312);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1057.757446");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 2148.187988");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 10.820312");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 270");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Warehouse in Whitewood Estates, Las Venturas");
		    SendClientMessage(playerid, COLOR_YELLOW, "This is a hidden part of the warehouse never seen in San Andreas");
		    return 1;
		}
	if(strcmp(cmd, "/cas", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Caligula's >VS< Four Dragons");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/cas1 - Caligula's Casino (hidden room)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/cas2 - Caligula's Casino (office) - Don't get excited!");
		    SendClientMessage(playerid, COLOR_YELLOW, "/cas3 - Four Dragons Casino (garage)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/cas4 - Four Dragons Casino (management room)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}

	if(strcmp(cmd, "/cas1", true)==0)
		{
			SetPlayerInterior(playerid, 1);
      		SetPlayerFacingAngle(playerid, 90);
	        SetPlayerPos(playerid, 2133.730712,1599.510375,1008.359375);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 2133.730712");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 1599.510375");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1008.359375");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 90");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 1");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Caligula's Casino Hidden Room");
		    SendClientMessage(playerid, COLOR_YELLOW, "Just an empty room hidden behind a door in Caligula's");
		    return 1;
		}

	if(strcmp(cmd, "/cas3", true)==0)
		{
  			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 0);
	        SetPlayerPos(playerid, 1903.478149,970.919982,10.820312);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1903.478149");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 970.919982");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 10.820312");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 0");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "The Four Dragons Casino Garage");
		    SendClientMessage(playerid, COLOR_YELLOW, "Has been seen in end of mission cut scenes");
		    return 1;
		}


	if(strcmp(cmd, "/cas4", true)==0)
		{
			SetPlayerInterior(playerid, 11);
      		SetPlayerFacingAngle(playerid, 0);
	        SetPlayerPos(playerid, 2013.760986,1016.695556,39.091094);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 2013.760986");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 1016.695556");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 39.091094");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 0   Interior: 11");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "The Four Dragons Casino Management Room");
		    SendClientMessage(playerid, COLOR_YELLOW, "An all time favourite interior, you are safe up on the roof =)");
		    SendClientMessage(playerid, COLOR_RED, "Room isn't solid, DO NOT cross onto the north side of the roof!");
		    return 1;
		}

	if(strcmp(cmd, "/bus", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Interiors of Commerce");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus1 - Liquor Store, Blueberry");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus2 - unused Motel room 1");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus3 - unused Motel room 2");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus4 - Bank, Palomino Creek");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus5 - Bank, Palomino Creek (behind counter)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/bus6 - Atrium, LS");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;
		}


	if(strcmp(cmd, "/bus1", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 180);
	        SetPlayerPos(playerid, 252.107192,-54.828540,1.577644);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 252.107192");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -54.828540");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1.577644");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 180");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Liquor Store in Blueberry, Red County");
		    SendClientMessage(playerid, COLOR_YELLOW, "Nice place, once seen in a mission with Catalina");
		    return 1;
		}

	if(strcmp(cmd, "/bus2", true)==0)
		{
			SetPlayerInterior(playerid, 10);
      		SetPlayerFacingAngle(playerid, 270);
	        SetPlayerPos(playerid, 2261.401123,-1135.940551,1050.632812);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 2261.401123");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -1135.940551");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1050.632812");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 270");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 10");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "An unused Motel room");
		    SendClientMessage(playerid, COLOR_YELLOW, "Even got a wardrobe =D");
		    return 1;
		}

	if(strcmp(cmd, "/bus3", true)==0)
		{
			SetPlayerInterior(playerid, 9);
      		SetPlayerFacingAngle(playerid, 90);
	        SetPlayerPos(playerid, 2253.139892,-1140.089965,1050.632812);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 2253.139892");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -1140.089965");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1050.632812");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 90");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 9");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Another unused Motel room");
		    SendClientMessage(playerid, COLOR_YELLOW, "Also got a wardrobe =D");
		    return 1;
		}


	if(strcmp(cmd, "/bus4", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 270);
	        SetPlayerPos(playerid, 2306.387695,-16.136718,26.749565);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 2306.387695");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -16.136718");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 26.749565");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 270");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Bank in Palomino Creek, Red County");
		    SendClientMessage(playerid, COLOR_YELLOW, "Once seen in a mission with Catalina, would be great for Roleplay!");
		    return 1;
		}

	if(strcmp(cmd, "/bus5", true)==0)
		{
			SetPlayerInterior(playerid, 0);
      		SetPlayerFacingAngle(playerid, 90);
	        SetPlayerPos(playerid, 2318.324951,-7.291463,26.749565);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 2318.324951");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -7.291463");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 26.749565");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 90");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 0");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Bank in Palomino Creek, Red County (behind counter)");
		    SendClientMessage(playerid, COLOR_YELLOW, "'There is your change, and here is your receipt. Have a good day sir'");
		    return 1;
		}


	if(strcmp(cmd, "/bus6", true)==0)
		{
     		SetPlayerInterior(playerid, 18);
      		SetPlayerFacingAngle(playerid, 40);
	        SetPlayerPos(playerid, 1728.494995,-1668.352294,22.609375);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 1728.494995");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: -1668.352294");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 22.609375");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 40");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 18");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Atrium Hotel in Commerce, Los Santos");
		    SendClientMessage(playerid, COLOR_YELLOW, "Used in mission 'Just Business' for Big Smoke");
		    return 1;
		}


	if(strcmp(cmd, "/gov", true) == 0)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "Government Interiors");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gov1 - Area 69 lab 1");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gov2 - Area 69 lab 2");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gov3 - Area 69 lab 3");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gov4 - Dillimore PD");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gov5 - Dillimore PD (jail cell)");
		    SendClientMessage(playerid, COLOR_YELLOW, "/gov6 - Dillimore PD (private room)");
		    SendClientMessage(playerid, COLOR_YELLOW, " ");
		    return 1;

	if(strcmp(cmd, "/gov4", true)==0)
		{
			SetPlayerInterior(playerid, 6);
      		SetPlayerFacingAngle(playerid, 0);
	        SetPlayerPos(playerid, 246.682373,65.300575,1003.640625);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 246.682373");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 65.300575");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1003.640625");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 0");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 6");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Dillimore Police Dept");
		    SendClientMessage(playerid, COLOR_YELLOW, "Same interior as Los Santos PD");
		    return 1;
		}

	if(strcmp(cmd, "/gov5", true)==0)
		{
	    	SetPlayerInterior(playerid, 6);
      		SetPlayerFacingAngle(playerid, 270);
	        SetPlayerPos(playerid, 264.250000,77.507400,1001.039062);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 264.250000");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 77.507400");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1001.039062");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 270");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 6");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Dillimore Police Dept (jail cell)");
		    SendClientMessage(playerid, COLOR_YELLOW, "Very useful for RPG gamemodes =)");
		    return 1;
		}

	if(strcmp(cmd, "/gov6", true)==0)
		{
			SetPlayerInterior(playerid, 6);
      		SetPlayerFacingAngle(playerid, 0);
	        SetPlayerPos(playerid, 232.118377,66.382949,1005.039062);
			TogglePlayerControllable(playerid, 1);
		    SendClientMessage(playerid, COLOR_WHITE, "Coordinates");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "X: 232.118377");
		    SendClientMessage(playerid, COLOR_WHITE, "Y: 66.382949");
		    SendClientMessage(playerid, COLOR_WHITE, "Z: 1005.039062");
		    SendClientMessage(playerid, COLOR_WHITE, "A: 0");
		    SendClientMessage(playerid, COLOR_WHITE, "Interior: 6");
		    SendClientMessage(playerid, COLOR_WHITE, " ");
		    SendClientMessage(playerid, COLOR_WHITE, "Dillimore Police Dept (private room)");
		    SendClientMessage(playerid, COLOR_RED, "Walls are NON-solid!");
		    return 1;
		}


	if(strcmp(cmd, "/clear", true) == 0)
		{	ClearPlayerChatBox(playerid);
		    return 1;}

	if(strcmp(cmdtext, "/?", true) == 0)
  	{
     		new Float:x,Float:y,Float:z,Float:a;
    		new string1[256],string2[256],string3[256],string4[256];
     		GetPlayerPos(playerid,x,y,z);
     		GetPlayerFacingAngle(playerid,a);
     		format(string1,sizeof(string1),"X: %f",x);
     		format(string2,sizeof(string2),"Y: %f",y);
     		format(string3,sizeof(string3),"Z: %f",z);
     		format(string4,sizeof(string4),"A: %f",a);
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, "Current Position");
			SendClientMessage(playerid, COLOR_WHITE, " ");
     		SendClientMessage(playerid, COLOR_WHITE, string1);
     		SendClientMessage(playerid, COLOR_WHITE, string2);
     		SendClientMessage(playerid, COLOR_WHITE, string3);
     		SendClientMessage(playerid, COLOR_WHITE, string4);
			SendClientMessage(playerid, COLOR_WHITE, " ");
			SendClientMessage(playerid, COLOR_WHITE, " ");
     		return 1;}






public ClearPlayerChatBox(playerid)
{
	SendClientMessage(playerid, COLOR_YELLOW, " ");
 	SendClientMessage(playerid, COLOR_YELLOW, " ");
  	SendClientMessage(playerid, COLOR_YELLOW, " ");
   	SendClientMessage(playerid, COLOR_YELLOW, " ");
   	SendClientMessage(playerid, COLOR_YELLOW, " ");
    SendClientMessage(playerid, COLOR_YELLOW, " ");
    SendClientMessage(playerid, COLOR_YELLOW, " ");
    SendClientMessage(playerid, COLOR_YELLOW, " ");
    SendClientMessage(playerid, COLOR_YELLOW, " ");
    SendClientMessage(playerid, COLOR_YELLOW, " ");
}


































