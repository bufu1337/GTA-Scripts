#include <a_samp>

#pragma tabsize 0

#define COLOR_GREEN 0x33AA33AA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_RED 0xFF3366FF

#define Filterscript
#if defined Filterscript

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" GPS by Jofi");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" GPS by Jofi");
	print("----------------------------------\n");
}

#endif

public OnGameModeInit()
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
		if (strcmp(cmdtext, "/gps", true)==0)
		{
				if(IsPlayerConnected(playerid))
		{
				SendClientMessage(playerid, COLOR_RED, "-----------------------------------------------------------------------");
				SendClientMessage(playerid, COLOR_GREEN, "/gps [location]");
				SendClientMessage(playerid, COLOR_GREEN, "/exitgps (Remove Mark)");
				SendClientMessage(playerid, COLOR_GREEN, "/gps2 (Next Page)");
				SendClientMessage(playerid, COLOR_ORANGE, "License, Bank, 24/7, CityHall, Airport");
				SendClientMessage(playerid, COLOR_ORANGE, "Dock, GunShop, Farm, CarPaint, Police,");
				SendClientMessage(playerid, COLOR_ORANGE, "Pizza, Taxi, PigPen, Alhambra, FBI, BurgerShot,");
				SendClientMessage(playerid, COLOR_ORANGE, "BurgerShot2, GasStation, GasStation2, GasStation3,");
				SendClientMessage(playerid, COLOR_ORANGE, "CarMarket, CarMarket2, Hospital, Hospital2");
				SendClientMessage(playerid, COLOR_RED, "-----------------------------------------------------------------------");
			}
   }
   		if (strcmp(cmdtext, "/gps2", true)==0)
		{
				if(IsPlayerConnected(playerid))
		{
				SendClientMessage(playerid, COLOR_RED, "-----------------------------------------------------------------------");
				SendClientMessage(playerid, COLOR_GREEN, "/gps [location]");
				SendClientMessage(playerid, COLOR_GREEN, "/exitgps (Remove Mark)");
				SendClientMessage(playerid, COLOR_ORANGE, "GroveStreet, Jefferson, Rodeo, SantaMaria, VeronaBeach");
				SendClientMessage(playerid, COLOR_ORANGE, "Marina, Mulholland, Richman, FlintCounty, EastBeach");
				SendClientMessage(playerid, COLOR_ORANGE, "LosFlores, ElCorona, Ganton, Mall, Vinewood");
				SendClientMessage(playerid, COLOR_ORANGE, "Dillimore, Blueberry, Montgomery, PalominoCreek");
				SendClientMessage(playerid, COLOR_RED, "-----------------------------------------------------------------------");
			}
   }


                if(IsPlayerConnected(playerid))
                
				if (strcmp(cmdtext, "/gps License", true)==0)
				SetPlayerCheckpoint(playerid,2053.2761,-1909.5160,13.5469,5);
				
				if (strcmp(cmdtext, "/gps Bank", true)==0)
				SetPlayerCheckpoint(playerid,1461.7273,-1023.7429,23.4017,5);

				if (strcmp(cmdtext, "/gps 24/7", true)==0)
				SetPlayerCheckpoint(playerid,1315.3618,-899.8662,39.1489,5);

				if (strcmp(cmdtext, "/gps CarMarket", true)==0)
				SetPlayerCheckpoint(playerid,2127.3984,-1139.6178,24.8447,5);

				if (strcmp(cmdtext, "/gps CarMarket2", true)==0)
				SetPlayerCheckpoint(playerid,548.8578,-1275.4779,16.8200,5);

				if (strcmp(cmdtext, "/gps Dock", true)==0)
				SetPlayerCheckpoint(playerid,370.7815,-2041.0538,7.2422,5);

				if (strcmp(cmdtext, "/gps Airport", true)==0)
				SetPlayerCheckpoint(playerid,1599.2776,-2328.4224,13.5366,5);

				if (strcmp(cmdtext, "/gps CityHall", true)==0)
				SetPlayerCheckpoint(playerid,1480.8268,-1744.1536,13.1170,5);

				if (strcmp(cmdtext, "/gps Police", true)==0)
				SetPlayerCheckpoint(playerid,1544.0143,-1675.6829,13.5576,5);

				if (strcmp(cmdtext, "/gps GroveStreet", true)==0)
				SetPlayerCheckpoint(playerid,2493.8511,-1669.5573,12.9113,5);

				if (strcmp(cmdtext, "/gps Jefferson", true)==0)
				SetPlayerCheckpoint(playerid,2220.9824,-1148.7661,25.3504,5);

				if (strcmp(cmdtext, "/gps GasStation", true)==0)
				SetPlayerCheckpoint(playerid,1005.4007,-940.1948,41.7549,5);

				if (strcmp(cmdtext, "/gps Rodeo", true)==0)
				SetPlayerCheckpoint(playerid,347.7415,-1367.7371,13.9776,5);

				if (strcmp(cmdtext, "/SantaMaria -", true)==0)
				SetPlayerCheckpoint(playerid,327.8009,-1797.7816,4.2844,5);

				if (strcmp(cmdtext, "/gps VeronaBeach", true)==0)
				SetPlayerCheckpoint(playerid,831.8949,-1819.0989,11.8452,5);

				if (strcmp(cmdtext, "/gps Marina", true)==0)
				SetPlayerCheckpoint(playerid,728.5689,-1593.4337,13.9832,5);

				if (strcmp(cmdtext, "/gps GunShop", true)==0)
				SetPlayerCheckpoint(playerid,1364.6945,-1279.8040,13.1127,5);

				if (strcmp(cmdtext, "/gps Hospital", true)==0)
				SetPlayerCheckpoint(playerid,1183.3936,-1323.9601,13.1430,5);

				if (strcmp(cmdtext, "/gps BurgerShot", true)==0)
				SetPlayerCheckpoint(playerid,1200.4105,-923.6525,42.5841,5);

				if (strcmp(cmdtext, "/gps Mulholland", true)==0)
				SetPlayerCheckpoint(playerid,1338.9668,-694.6091,91.4037,5);

				if (strcmp(cmdtext, "/gps Richman", true)==0)
				SetPlayerCheckpoint(playerid,675.6179,-1061.0540,48.9433,5);

				if (strcmp(cmdtext, "/gps FlintCounty", true)==0)
				SetPlayerCheckpoint(playerid,-116.5864,-1186.2360,2.2648,5);

				if (strcmp(cmdtext, "/gps GasStation2", true)==0)
				SetPlayerCheckpoint(playerid,-116.5864,-1186.2360,2.2648,5);

				if (strcmp(cmdtext, "/gps Farm", true)==0)
				SetPlayerCheckpoint(playerid,-376.0385,-1440.0708,25.2968,5);

				if (strcmp(cmdtext, "/gps BurgerShot2", true)==0)
				SetPlayerCheckpoint(playerid,819.6470,-1619.0469,13.1127,5);

				if (strcmp(cmdtext, "/gps Taxi", true)==0)
				SetPlayerCheckpoint(playerid,1809.1172,-1864.4482,13.1492,5);

				if (strcmp(cmdtext, "/gps Pizza", true)==0)
				SetPlayerCheckpoint(playerid,2093.0984,-1807.0825,13.1196,5);

				if (strcmp(cmdtext, "/gps CarPaint", true)==0)
				SetPlayerCheckpoint(playerid,2074.3252,-1830.9292,13.1171,5);

				if (strcmp(cmdtext, "/gps EastBeach", true)==0)
				SetPlayerCheckpoint(playerid,2732.0156,-1662.9469,12.8089,5);

				if (strcmp(cmdtext, "/gps LosFlores", true)==0)
				SetPlayerCheckpoint(playerid,2729.4907,-1258.4280,59.1302,5);

				if (strcmp(cmdtext, "/gps PigPen", true)==0)
				SetPlayerCheckpoint(playerid,2418.3625,-1234.1200,23.9079,5);

				if (strcmp(cmdtext, "/gps Alhambra", true)==0)
				SetPlayerCheckpoint(playerid,1827.9978,-1683.6870,13.1136,5);

				if (strcmp(cmdtext, "/gps Hospital2", true)==0)
				SetPlayerCheckpoint(playerid,2000.3309,-1446.3424,13.1316,5);

				if (strcmp(cmdtext, "/gps FBI", true)==0)
				SetPlayerCheckpoint(playerid,1534.5702,-1448.2894,12.9553,5);

				if (strcmp(cmdtext, "/gps ElCorona", true)==0)
				SetPlayerCheckpoint(playerid,1822.0739,-2081.0579,12.9534,5);

				if (strcmp(cmdtext, "/gps Ganton", true)==0)
				SetPlayerCheckpoint(playerid,2314.2036,-1742.4119,12.9531,5);

				if (strcmp(cmdtext, "/gps Mall", true)==0)
				SetPlayerCheckpoint(playerid,1120.2430,-1389.5569,13.2156,5);

				if (strcmp(cmdtext, "/gps Vinewood", true)==0)
				SetPlayerCheckpoint(playerid,1103.8586,-941.0670,42.4828,5);

				if (strcmp(cmdtext, "/gps Dillimore", true)==0)
				SetPlayerCheckpoint(playerid,635.8654,-570.4843,15.9069,5);

				if (strcmp(cmdtext, "/gps GasStation3", true)==0)
				SetPlayerCheckpoint(playerid,651.2009,-563.4557,15.8840,5);

				if (strcmp(cmdtext, "/gps Blueberry", true)==0)
				SetPlayerCheckpoint(playerid,161.5037,-205.9166,1.1486,5);

				if (strcmp(cmdtext, "/gps Montgomery", true)==0)
				SetPlayerCheckpoint(playerid,1340.4523,257.0470,19.1249,5);

				if (strcmp(cmdtext, "/gps PalominoCreek", true)==0)
				SetPlayerCheckpoint(playerid,2337.7549,43.0897,26.0518,5);

			{
				if(IsPlayerAdmin(playerid))
				{
				
		if (strcmp(cmdtext, "/agps", true)==0)
		{
				if(IsPlayerConnected(playerid))
		{
				SendClientMessage(playerid, COLOR_RED, "-----------------------------------------------------------------------");
				SendClientMessage(playerid, COLOR_GREEN, "/agps [location]");
				SendClientMessage(playerid, COLOR_GREEN, "/agps2 (Next Page)");
				SendClientMessage(playerid, COLOR_ORANGE, "License, Bank, 24/7, CityHall, Airport");
				SendClientMessage(playerid, COLOR_ORANGE, "Dock, GunShop, Farm, CarPaint, Police,");
				SendClientMessage(playerid, COLOR_ORANGE, "Pizza, Taxi, PigPen, Alhambra, FBI, BurgerShot,");
				SendClientMessage(playerid, COLOR_ORANGE, "BurgerShot2, GasStation, GasStation2, GasStation3,");
				SendClientMessage(playerid, COLOR_ORANGE, "CarMarket, CarMarket2, Hospital, Hospital2");
				SendClientMessage(playerid, COLOR_RED, "-----------------------------------------------------------------------");
			}
   }
   		if (strcmp(cmdtext, "/agps2", true)==0)
		{
				if(IsPlayerConnected(playerid))
		{
				SendClientMessage(playerid, COLOR_RED, "-----------------------------------------------------------------------");
				SendClientMessage(playerid, COLOR_GREEN, "/agps [location]");
				SendClientMessage(playerid, COLOR_ORANGE, "GroveStreet, Jefferson, Rodeo, SantaMaria, VeronaBeach");
				SendClientMessage(playerid, COLOR_ORANGE, "Marina, Mulholland, Richman, FlintCounty, EastBeach");
				SendClientMessage(playerid, COLOR_ORANGE, "LosFlores, ElCorona, Ganton, Mall, Vinewood");
				SendClientMessage(playerid, COLOR_ORANGE, "Dillimore, Blueberry, Montgomery, PalominoCreek");
				SendClientMessage(playerid, COLOR_RED, "-----------------------------------------------------------------------");
				}
  		 	}
   		}
   }
   			{
				if(IsPlayerAdmin(playerid))
				{

				if (strcmp(cmdtext, "/agps License", true)==0)
				SetPlayerPos(playerid,2053.2761,-1909.5160,13.5469);

				if (strcmp(cmdtext, "/agps Bank", true)==0)
				SetPlayerPos(playerid,1461.7273,-1023.7429,23.4017);

				if (strcmp(cmdtext, "/agps 24/7", true)==0)
				SetPlayerPos(playerid,1315.3618,-899.8662,39.1489);

				if (strcmp(cmdtext, "/agps CarMarket", true)==0)
				SetPlayerPos(playerid,2127.3984,-1139.6178,24.8447);

				if (strcmp(cmdtext, "/agps CarMarket2", true)==0)
				SetPlayerPos(playerid,548.8578,-1275.4779,16.8200);

				if (strcmp(cmdtext, "/agps Dock", true)==0)
				SetPlayerPos(playerid,370.7815,-2041.0538,7.2422);

				if (strcmp(cmdtext, "/agps Airport", true)==0)
				SetPlayerPos(playerid,1599.2776,-2328.4224,13.5366);

				if (strcmp(cmdtext, "/agps CityHall", true)==0)
				SetPlayerPos(playerid,1480.8268,-1744.1536,13.1170);

				if (strcmp(cmdtext, "/agps Police", true)==0)
				SetPlayerPos(playerid,1544.0143,-1675.6829,13.5576);

				if (strcmp(cmdtext, "/agps GroveStreet", true)==0)
				SetPlayerPos(playerid,2493.8511,-1669.5573,12.9113);

				if (strcmp(cmdtext, "/agps Jefferson", true)==0)
				SetPlayerPos(playerid,2220.9824,-1148.7661,25.3504);

				if (strcmp(cmdtext, "/agps GasStation", true)==0)
				SetPlayerPos(playerid,1005.4007,-940.1948,41.7549);

				if (strcmp(cmdtext, "/agps Rodeo", true)==0)
				SetPlayerPos(playerid,347.7415,-1367.7371,13.9776);

				if (strcmp(cmdtext, "/SantaMaria -", true)==0)
				SetPlayerPos(playerid,327.8009,-1797.7816,4.2844);

				if (strcmp(cmdtext, "/agps VeronaBeach", true)==0)
				SetPlayerPos(playerid,831.8949,-1819.0989,11.8452);

				if (strcmp(cmdtext, "/agps Marina", true)==0)
				SetPlayerPos(playerid,728.5689,-1593.4337,13.9832);

				if (strcmp(cmdtext, "/agps GunShop", true)==0)
				SetPlayerPos(playerid,1364.6945,-1279.8040,13.1127);

				if (strcmp(cmdtext, "/agps Hospital", true)==0)
				SetPlayerPos(playerid,1183.3936,-1323.9601,13.1430);

				if (strcmp(cmdtext, "/agps BurgerShot", true)==0)
				SetPlayerPos(playerid,1200.4105,-923.6525,42.5841);

				if (strcmp(cmdtext, "/agps Mulholland", true)==0)
				SetPlayerPos(playerid,1338.9668,-694.6091,91.4037);

				if (strcmp(cmdtext, "/agps Richman", true)==0)
				SetPlayerPos(playerid,675.6179,-1061.0540,48.9433);

				if (strcmp(cmdtext, "/agps FlintCounty", true)==0)
				SetPlayerPos(playerid,-116.5864,-1186.2360,2.2648);

				if (strcmp(cmdtext, "/agps GasStation2", true)==0)
				SetPlayerPos(playerid,-116.5864,-1186.2360,2.2648);

				if (strcmp(cmdtext, "/agps Farm", true)==0)
				SetPlayerPos(playerid,-376.0385,-1440.0708,25.2968);

				if (strcmp(cmdtext, "/agps BurgerShot2", true)==0)
				SetPlayerPos(playerid,819.6470,-1619.0469,13.1127);

				if (strcmp(cmdtext, "/agps Taxi", true)==0)
				SetPlayerPos(playerid,1809.1172,-1864.4482,13.1492);

				if (strcmp(cmdtext, "/agps Pizza", true)==0)
				SetPlayerPos(playerid,2093.0984,-1807.0825,13.1196);

				if (strcmp(cmdtext, "/agps CarPaint", true)==0)
				SetPlayerPos(playerid,2074.3252,-1830.9292,13.1171);

				if (strcmp(cmdtext, "/agps EastBeach", true)==0)
				SetPlayerPos(playerid,2732.0156,-1662.9469,12.8089);

				if (strcmp(cmdtext, "/agps LosFlores", true)==0)
				SetPlayerPos(playerid,2729.4907,-1258.4280,59.1302);

				if (strcmp(cmdtext, "/agps PigPen", true)==0)
				SetPlayerPos(playerid,2418.3625,-1234.1200,23.9079);

				if (strcmp(cmdtext, "/agps Alhambra", true)==0)
				SetPlayerPos(playerid,1827.9978,-1683.6870,13.1136);

				if (strcmp(cmdtext, "/agps Hospital2", true)==0)
				SetPlayerPos(playerid,2000.3309,-1446.3424,13.1316);

				if (strcmp(cmdtext, "/agps FBI", true)==0)
				SetPlayerPos(playerid,1534.5702,-1448.2894,12.9553);

				if (strcmp(cmdtext, "/agps ElCorona", true)==0)
				SetPlayerPos(playerid,1822.0739,-2081.0579,12.9534);

				if (strcmp(cmdtext, "/agps Ganton", true)==0)
				SetPlayerPos(playerid,2314.2036,-1742.4119,12.9531);

				if (strcmp(cmdtext, "/agps Mall", true)==0)
				SetPlayerPos(playerid,1120.2430,-1389.5569,13.2156);

				if (strcmp(cmdtext, "/agps Vinewood", true)==0)
				SetPlayerPos(playerid,1103.8586,-941.0670,42.4828);

				if (strcmp(cmdtext, "/agps Dillimore", true)==0)
				SetPlayerPos(playerid,635.8654,-570.4843,15.9069);

				if (strcmp(cmdtext, "/agps GasStation3", true)==0)
				SetPlayerPos(playerid,651.2009,-563.4557,15.8840);

				if (strcmp(cmdtext, "/agps Blueberry", true)==0)
				SetPlayerPos(playerid,161.5037,-205.9166,1.1486);

				if (strcmp(cmdtext, "/agps Montgomery", true)==0)
				SetPlayerPos(playerid,1340.4523,257.0470,19.1249);

				if (strcmp(cmdtext, "/agps PalominoCreek", true)==0)
				SetPlayerPos(playerid,2337.7549,43.0897,26.0518);

				}
			}
				if(strcmp(cmdtext,"/exitgps",true)==0)
 	{
		if(IsPlayerConnected(playerid))
		{
				DisablePlayerCheckpoint(playerid);
			}
		}

	return 0;
}
