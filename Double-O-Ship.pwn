#include <a_samp>
#include <mapandreas>
//$ region Rideable Ships - Forwards
	forward OnPlayerEnterShip(playerid,shipid,ispassenger);
	forward OnPlayerExitShip(playerid,shipid);
	forward OnShipCrash(shipid,captain,Float:oldhealth,Float:newhealth,crashedshipid);
	forward OnShipDeath(shipid,reason);
	forward OnShipSpawn(shipid);
	forward OnCaptainUseHorn(captain,shipid);
	forward CreateShip(modelid,Float:x,Float:y,Float:a);
	forward CreateShipEx(modelid,Float:x,Float:y,Float:a,respawndelay);
	forward DestroyShip(shipid);
	forward UpdateShipPos(shipid,Float:x,Float:y,Float:a);
	forward MoveShip(shipid,Float:speed);
	forward ActivateShipHorn(shipid);
	forward ChangePlayerCamera(playerid);
	forward TogglePlayerShipCamera(playerid,toggle);
	forward RepairShip(shipid);
	forward SetShipHealth(shipid,Float:health);
	forward SetShipToRespawn(shipid);
	forward RespawnFix(shipid);
	forward SetShipZAngle(shipid,Float:a);
	forward SetShipPos(shipid,Float:x,Float:y);
	forward RespawnUpdate();
	forward ShipUpdate();
	forward PassengerUpdate(shipid);
	forward CreateShipExplosion(shipid);
//$ endregion Rideable Ships - Forwards
//$ region Rideable Ships - Defines
	#define DEATH_REASON_NONE 0
	#define DEATH_REASON_CRASH_WITH_LAND 1
	#define DEATH_REASON_CRASH_WITH_SHIP 2
	#define DEATH_REASON_SERVERKILL 3 //Kill by Server (SetShipHealth)
	#define MAX_SHIP_MODELS (7)
	#define MAX_SHIPS (300)
	#define MAX_SHIP_OBJECTS (14)
	#define INVALID_SHIP_ID (-1)
//$ endregion Rideable Ships - Defines
//$ region Rideable Ships - Enums
	enum e_CreatedShipInfo{
		Float:e_CurrentSpeed,
		e_Created,
		e_ModelID,
		e_Captain,
		e_RespawnDelay,
		e_Unused,
		e_ShipEntered,
		e_Dead,
		e_DeathReason,
		Float:e_Health,
		Float:e_SpawnPos[3]//x y z angle
	};
	enum e_ShipModelData{
		Float:e_MaxSpeed,
		Float:e_TurnSpeed,
		Float:e_Acceleration,
		Float:e_Size[4],//breiten, y nach vorne, y nach hinten
		Float:e_CommandoBridgeOffset[6],//x y z    cy cz1 cz2
		Float:e_NorthAngle,
		e_ObjectCount,
		Float:e_MaxHealth,
		e_ShipModelName[32]
	};
//$ endregion Rideable Ships - Enums
//$ region Rideable Ships - Variablen
	new ShipCount;
	new CreatedShips[MAX_SHIPS][e_CreatedShipInfo];
	new CreatedShipObjects[MAX_SHIPS][MAX_SHIP_OBJECTS];
	new Float:CreatedShipObjectPositions[MAX_SHIPS][MAX_SHIP_OBJECTS][6];
	new Text3D:CreatedShipLabel[MAX_SHIPS]={ Text3D:INVALID_3DTEXT_ID,... };
	new ShipUpdateTimer;
	new RespawnTimer;
	new PrintTestResult=false;
	new ShipUpdateSpeed;
	new ShipUpdateCount;
	new OPES_Implemented;
	new OCUH_Implemented;
	new CaptainOnShip[MAX_PLAYERS]={INVALID_SHIP_ID,...};
	new PassengerOnShip[MAX_PLAYERS]={INVALID_SHIP_ID,...};
	new ShipCamera[MAX_PLAYERS]={true,...};
	new Float:PlayerCameraAngle[MAX_PLAYERS];
	new Float:PlayerPosOnShip[MAX_PLAYERS][3];
	new Float:PlayerShipCameraPos[MAX_PLAYERS][3];
	new ShipModelData[MAX_SHIP_MODELS][e_ShipModelData]={
		{
		    20.0,
		    0.2,
			0.07,
			{5.0,5.0,37.0,40.0},
			{2000.4471,1522.5204,8.0682,45.0,22.0,18.0},
			0.0,
			3,
			2000.0,
			"Brown Pearl"
		},
		{
		    45.0,
		    0.05,
		    0.1,
		    {16.5,16.5,112.0,112.0},//Breite, Mitte nach Vorne, Mitte nach Hinten
		    {-1327.9342,493.8543,21.2500,200.0,35.0,30.0},
		    (-90.0),//um 90° drehen
		    10,
			10000.0,
		    "USS Patriarch"
		},
		{
		    40.0,
		    0.04,
		    0.1,
		    {18.0,18.0,116.0,114.0},
		    {-2472.1042,1549.3270,33.2273,80.0,50.0,42.0},
			(-90.0),
			14,
			6000.0,
			"Cargonoob"
		},
		{
		    30.0,
		    0.1,
		    0.09,
		    {13.0,13.0,60.0,60.0},
		    {-1377.6116,1490.0973,11.2031,65.0,25.0,20.0},
			90.0,
			7,
			5000.0,
			"Shitanic"
		},
		{
		    50.0,
		    0.15,
		    0.09,
		    {4.75,4.75,50.0,50.0},
		    {-1878.6157,1455.9819,8.3681,105.0,10.0,8.0},
			180.0,
			1,
			3500.0,
			"USS Nixnutz"
		},
		{
		    40.0,
		    0.05,
		    0.1,
		    {5.0,21.0,75.0,155.0},
		    {2838.1492,-2373.5569,31.0021,80.0,50.0,42.0},
		    (-90.0),
		    14,
		    6000.0,
		    "Miami Shice"//Das Schiffe ist echt scheisse
		},
		{
			30.0,
			0.08,
			0.08,
			{20.0,20.0,115.0,115.0},
			{-1588.8120,38.7244,17.3281,80.0,50.0,42.0},
			(-90.0),
			3,
			6000.0,
			"Export 7777"
		}
	};
	new ShipModelObjects[MAX_SHIP_MODELS][MAX_SHIP_OBJECTS]={
		{
		    8493,//Schiff
		    9159,//Flagge
		    8981,//Seile
		    0,
		    0,
		    0,
		    0,
		    0,
		    0,
		    0,
		    0,
		    0,
		    0,
			0
		},
		{
		    10771,//Schiff
		    10772,//Streifen auf Landebahn
		    10770,//Commandobrücke
		    11237,//Turm auf Commandobrücke
		    11149,//Treppenhaus
		    11146,//Hangar
		    11145,//Unterdeck
		    11147,//Röhren etc. unten
	        11148,//Röhren etc. oben
	        11374,//Geländer im Treppenhaus
	        0,
		    0,
		    0,
			0
		},
		{
		    9585,//Schiff
		    9584,//Commandobrücke
		    9698,//Brücke: Innenraum
		    9761,//Fenster und Zäune
		    9821,//Türen im Innenraum
		    9820,//Brücke: Geräte
		    9819,//Brücke: Geräte
		    9818,//Brücke: Geräte
		    9822,//Brücke: Stühle
		    9586,//Deck
		    9583,//Antenne oder so
	        9590,//Frachtraum
	        9587,//Container oben
	        9588//Container im Frachtraum
		},
		{
		    10230,//Schiff
		    10140,//Frachtraum
		    10229,//Geländer
		    10227,//Innenraum oben
		    10226,//Innenraum unten
		    10231,//Container
		    10228,//Lampen
		    0,
		    0,
		    0,
	        0,
		    0,
		    0,
			0
		},
		{
		    9958,//Das Uboot
		    0,
		    0,
		    0,
	        0,
		    0,
		    0,
			0,
		    0,
		    0,
	        0,
		    0,
		    0,
			0
		},
		{
		    5160,//Schiff Mittelteil
		    5166,//Schiff Vorne
		    5167,//Schiff Hinten
		    5156,//Deck
		    3724,//Zeug oben drauf 1
		    3724,//Zeug oben drauf 2
		    5157,//Zeug oben drauf 3
		    5154,//Irgendwas
		    5165,//Irgendwas
		    5155,//Commandobrücke
		    5158,//Treppen etc.
		    0,
		    0,
			0
		},
		{
		    10794,//Schiff
		    10793,//Commandobrücke
		    10795,//Deck
		    0,
	        0,
		    0,
		    0,
			0,
		    0,
		    0,
	        0,
		    0,
		    0,
			0
		}
	};
	new Float:ShipModelObjectPositions[MAX_SHIP_MODELS][MAX_SHIP_OBJECTS][6]={
		// x y z rx ry rz - Erste Objekt ist Hauptobjekt
		{
		    {2001.14,1555.1,15.875,0.0,0.0,0.0},
		    {2001.14,1555.1,15.875,0.0,0.0,0.0},
		    {2000.59,1548.91,15.4375,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0}
		},
		{
		    {-1357.7,501.297,5.44531,0.0,0.0,0.0},//Muss um 90° gedreht werden...
		    {-1356.35,501.117,17.2734,0.0,0.0,0.0},
		    {-1354.47,493.75,38.6797,0.0,0.0,0.0},
		    {-1354.42,493.75,38.6797,0.0,0.0,0.0},
		    {-1363.77,496.094,11.9844,0.0,0.0,0.0},
		    {-1366.69,501.852,12.2891,0.0,0.0,0.0},
		    {-1420.58,501.297,4.25781,0.0,0.0,0.0},
		    {-1418.41,501.297,5.07812,0.0,0.0,0.0},
		    {-1366.69,501.297,12.8828,0.0,0.0,0.0},
		    {-1363.77,496.094,11.9844,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0}
		},
		{
		    {-2409.84,1544.95,7.0,0.0,0.0,0.0},
		    {-2485.08,1544.95,26.1953,0.0,0.0,0.0},
		    {-2473.59,1543.77,29.0781,0.0,0.0,0.0},
		    {-2411.39,1544.95,27.0781,0.0,0.0,0.0},
		    {-2474.36,1547.24,24.75,0.0,0.0,0.0},
		    {-2474.62,1545.09,33.0625,0.0,0.0,0.0},
		    {-2470.45,1551.12,33.1406,0.0,0.0,0.0},
		    {-2470.27,1544.96,33.8672,0.0,0.0,0.0},
		    {-2470.94,1550.75,32.9062,0.0,0.0,0.0},
		    {-2412.12,1544.95,17.0469,0.0,0.0,0.0},
		    {-2475.13,1559.07,31.3125,0.0,0.0,0.0},
		    {-2403.51,1544.95,8.71875,0.0,0.0,0.0},
		    {-2401.14,1544.94,23.5938,0.0,0.0,0.0},
		    {-2404.21,1544.94,7.58594,0.0,0.0,0.0}
		},
		{
		    {-1421.62,1490.86,6.96875,0.0,0.0,0.0},
		    {-1406.91,1489.8,7.125,0.0,0.0,0.0},
		    {-1421.88,1489.45,5.82031,0.0,0.0,0.0},
		    {-1376.75,1490.63,12.0234,0.0,0.0,0.0},
		    {-1377.23,1491.62,6.21094,0.0,0.0,0.0},
		    {-1422.54,1489.35,8.45312,0.0,0.0,0.0},
		    {-1411.98,1489.72,5.78906,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0}
		},
		{

		    {-1899.16,1476.79,5.74219,0.0,0.0,315.0},//Winkel im Uhrzeigersinn laut Map Editor...
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0}
		},
		{
		    {2829.95,-2479.57,5.26562,0.0,0.0,90.0},
		    {2829.95,-2479.57,5.26562,0.0,0.0,90.0},
		    {2838.03,-2371.95,7.29688,0.0,0.0,90.0},
		    {2838.04,-2423.88,10.9609,0.0,0.0,90.0},
		    {2838.2,-2488.66,29.3125,0.0,0.0,-90.0},
		    {2838.2,-2407.14,29.3125,0.0,0.0,90.0},
			{2838.04,-2532.77,17.0234,0.0,0.0,90.0},
			{2838.14,-2447.84,15.75,0.0,0.0,90.0},
			{2838.03,-2520.19,18.4141,0.0,0.0,0.0},
			{2838.02,-2358.48,21.3125,0.0,0.0,90.0},
			{2837.77,-2334.48,11.9922,0.0,0.0,180.0},
			{0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0}
		},
		{
		    {-1550.83,75.9297,7.0,0.0,0.0,315.0},//Winkel im Uhrzeigersinn laut Map Editor...
		    {-1604.04,22.7266,35.5703,0.0,0.0,315.0},
		    {-1552.44,74.3203,17.0469,0.0,0.0,315.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0},
		    {0.0,0.0,0.0,0.0,0.0,0.0}
		}
	};
	static const Float:BridgeZones[][4]={
		//max_x min_x max_y min_y
		{-2615.844, -2709.267, 1915.172, 1588.191},//SF
		{-2592.488, -2697.589, 2090.34, 1915.172},
		{-2615.844, -2709.267, 1599.869, 1518.124},
		{-1154.761, -1386.522, 866.2643, 692.6859},
		{-1116.134, -1413.561, 1134.522, 842.5945},
		{-1143.173, -1367.208, 874.1542, 692.6859},
		{-969.3519, -1119.997, 1016.173, 882.0442},//SF Ende
		{2528.039, 2429.166, -2266.128, -2329.292},//LS
		{2413.954, 2322.686, -2372.717, -2455.619},
		{2364.517, 2269.447, -2633.268, -2712.222},//LS Ende
		{-899.1964, -980.9415, -280.269, -373.692},//Pampa
		{-35.03363, -93.423, -875.8406, -922.5522},
		{116.7788, 58.38938, -992.6194, -1039.331},
		{105.1009, 23.35575, -1249.533, -1377.989},
		{105.1009, 46.7115, -1506.446, -1576.513},
		{81.74512, 11.67788, -502.1487, -572.2159},
		{326.9805, 245.2354, -350.3363, -408.7256},
		{537.1823, 490.4708, -210.2018, -268.5911},
		{1272.888, 1179.465, -116.7788, -175.1681},
		{1669.936, 1611.547, 0.0, -46.7115},
		{1926.849, 1833.426, -35.03363, -93.423},
		{2137.051, 2078.662, 116.7788, 23.35575},
		{2218.796, 2137.051, 362.0141, 186.846},
		{2814.368, 2709.267, 583.8938, 303.6248},
		{1810.071, 1646.58, 595.5717, 408.7256},
		{618.9274, 373.692, 595.5717, 362.0141},
		{-105.1009, -221.8796, 467.115, 268.5911},
		{-525.5044, -665.6389, 735.7062, 525.5044},
		{-432.0814, -525.5044, 1132.754, 945.9079},
		{-455.4371, -572.2159, 1272.888, 1132.754},
		{-2814.368, -2919.469, -957.5858, -1109.398},
		{-1599.869, -1693.292, -1588.191, -1658.258},
		{-1179.465, -1237.855, -2323.897, -2382.287},
		{-1144.432, -1202.821, -2615.844, -2685.911},
		{-1051.009, -1179.465, -2802.69, -2896.113}
	};
//$ endregion Rideable Ships - Variablen
//$ region Rideable Ships - Functions
	public CreateShip(modelid,Float:x,Float:y,Float:a){
		if(IsValidShipModel(modelid)){
			for(new i=0;i<MAX_SHIPS;i++){
			    if(!CreatedShips[i][e_Created]){
			        CreatedShips[i][e_Created]=true;
		    		CreatedShips[i][e_CurrentSpeed]=0.0;
		    		CreatedShips[i][e_SpawnPos][0]=x;
			        CreatedShips[i][e_SpawnPos][1]=y;
			        CreatedShips[i][e_SpawnPos][2]=a;
			        CreatedShips[i][e_ModelID]=modelid;
			        CreatedShips[i][e_Captain]=INVALID_PLAYER_ID;
	                CreatedShips[i][e_RespawnDelay]=3*60;//3 Minuten standard
	                CreatedShips[i][e_Unused]=0;
	                CreatedShips[i][e_ShipEntered]=false;
	                CreatedShips[i][e_Health]=ShipModelData[modelid][e_MaxHealth];
	                CreatedShips[i][e_Dead]=false;
					CreatedShips[i][e_DeathReason]=DEATH_REASON_NONE;
					for(new j=0;j<ShipModelData[modelid][e_ObjectCount];j++){
				       	CreatedShipObjects[i][j]=CreateObject(ShipModelObjects[modelid][j],0.0,0.0,0.0,0.0,0.0,0.0,300.0);
					}
					UpdateShipPos(i,x,y,a);
	                CallLocalFunction("OnShipSpawn","i",i);
	                ShipCount++;
	                /*new Float:corner_x[4],Float:corner_y[4];
					GetShipCorners(i,corner_x,corner_y);
					for(new k=0;k<4;k++)
					    CreatePickup(1240,2,corner_x[k],corner_y[k],5.0,-1);*/
			        return i;
			    }
			}
		}
		return INVALID_SHIP_ID;
	}
	public CreateShipEx(modelid,Float:x,Float:y,Float:a,respawndelay){
		if(IsValidShipModel(modelid)){
			for(new i=0;i<MAX_SHIPS;i++){
			    if(!CreatedShips[i][e_Created]){
			        CreatedShips[i][e_Created]=true;
		    		CreatedShips[i][e_CurrentSpeed]=0.0;
		    		CreatedShips[i][e_SpawnPos][0]=x;
			        CreatedShips[i][e_SpawnPos][1]=y;
			        CreatedShips[i][e_SpawnPos][2]=a;
			        CreatedShips[i][e_ModelID]=modelid;
			        CreatedShips[i][e_Captain]=INVALID_PLAYER_ID;
	                CreatedShips[i][e_RespawnDelay]=respawndelay;
	                CreatedShips[i][e_Unused]=0;
	                CreatedShips[i][e_ShipEntered]=false;
	                CreatedShips[i][e_Health]=ShipModelData[modelid][e_MaxHealth];
	                CreatedShips[i][e_Dead]=false;
					CreatedShips[i][e_DeathReason]=DEATH_REASON_NONE;
				    for(new j=0;j<ShipModelData[modelid][e_ObjectCount];j++){
				        CreatedShipObjects[i][j]=CreateObject(ShipModelObjects[modelid][j],0.0,0.0,0.0,0.0,0.0,0.0,300.0);
					}
					UpdateShipPos(i,x,y,a);
	                CallLocalFunction("OnShipSpawn","i",i);
	                ShipCount++;
	                /*new Float:corner_x[4],Float:corner_y[4];
					GetShipCorners(i,corner_x,corner_y);
					for(new k=0;k<4;k++)
					    CreatePickup(1240,2,corner_x[k],corner_y[k],5.0,-1);*/
			        return i;
			    }
			}
		}
		return INVALID_SHIP_ID;
	}
	public DestroyShip(shipid){
		if(!IsValidShip(shipid)){
		    return 0;
		}
	    for(new i=0;i<ShipModelData[CreatedShips[shipid][e_ModelID]][e_ObjectCount];i++){
		    DestroyObject(CreatedShipObjects[shipid][i]);
		    CreatedShipObjects[shipid][i]=INVALID_OBJECT_ID;
		}
		if(IsPlayerConnected(CreatedShips[shipid][e_Captain])){
			TogglePlayerControllable(CreatedShips[shipid][e_Captain],true);
			SetCameraBehindPlayer(CreatedShips[shipid][e_Captain]);
		}
		for(new i=0;i<MAX_PLAYERS;i++){
			PassengerOnShip[i]=INVALID_SHIP_ID;
		}
		Remove3DEnterExitLabel(shipid);
	    CreatedShips[shipid][e_Created]=false;
	    ShipCount--;
		return 1;
	}
	public UpdateShipPos(shipid,Float:x,Float:y,Float:a){
		if(!IsValidShip(shipid)){
		    return 0;
		}
		a-=ShipModelData[CreatedShips[shipid][e_ModelID]][e_NorthAngle];
		new Float:cos=floatcos(a,degrees),Float:sin=floatsin(a,degrees);
	    for(new i=0;i<ShipModelData[CreatedShips[shipid][e_ModelID]][e_ObjectCount];i++){
		    CreatedShipObjectPositions[shipid][i][0]=ShipModelObjectPositions[CreatedShips[shipid][e_ModelID]][i][0]+x;
			CreatedShipObjectPositions[shipid][i][1]=ShipModelObjectPositions[CreatedShips[shipid][e_ModelID]][i][1]+y;
			CreatedShipObjectPositions[shipid][i][2]=ShipModelObjectPositions[CreatedShips[shipid][e_ModelID]][i][2];
			CreatedShipObjectPositions[shipid][i][3]=ShipModelObjectPositions[CreatedShips[shipid][e_ModelID]][i][3];
			CreatedShipObjectPositions[shipid][i][4]=ShipModelObjectPositions[CreatedShips[shipid][e_ModelID]][i][4];
			CreatedShipObjectPositions[shipid][i][5]=ShipModelObjectPositions[CreatedShips[shipid][e_ModelID]][i][5]+a;
			TurnXYAroundCenterEx(CreatedShipObjectPositions[shipid][i][0],CreatedShipObjectPositions[shipid][i][1],x,y,cos,sin);
			SetObjectPos(CreatedShipObjects[shipid][i],CreatedShipObjectPositions[shipid][i][0],CreatedShipObjectPositions[shipid][i][1],CreatedShipObjectPositions[shipid][i][2]);
			SetObjectRot(CreatedShipObjects[shipid][i],CreatedShipObjectPositions[shipid][i][3],CreatedShipObjectPositions[shipid][i][4],CreatedShipObjectPositions[shipid][i][5]);
		}
		return 1;
	}
	public MoveShip(shipid,Float:speed){
	    if(!IsValidShip(shipid)){
		    return 0;
		}
		if(speed==0.0){
		    for(new i=0;i<ShipModelData[CreatedShips[shipid][e_ModelID]][e_ObjectCount];i++){
		        StopObject(CreatedShipObjects[shipid][i]);
			}
	        CreatedShips[shipid][e_CurrentSpeed]=0.0;
		    return -1;
		}
		new Float:vx,Float:vy,Float:a,Float:x,Float:y,Float:z,crashedshipid;
		GetShipZAngle(shipid,a);
		if(speed<0.0){
			vx=(-ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][3]*floatsin(-a,degrees));//rückwärts
			vy=(-ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][3]*floatcos(-a,degrees));//rückwärts
		    if(!ShipMoveCheck(shipid,false,crashedshipid)){
		        new Float:oldhealth=CreatedShips[shipid][e_Health];
		        for(new i=0;i<ShipModelData[CreatedShips[shipid][e_ModelID]][e_ObjectCount];i++){
			        StopObject(CreatedShipObjects[shipid][i]);
				}
	            CreatedShips[shipid][e_Health]+=(speed*50.0);
	            if(CreatedShips[shipid][e_Health]<0.0){
	                CreatedShips[shipid][e_Health]=0.0;
				}
		        CreatedShips[shipid][e_CurrentSpeed]=0.0;
		        CallLocalFunction("OnShipCrash","iiffi",shipid,CreatedShips[shipid][e_Captain],oldhealth,CreatedShips[shipid][e_Health],crashedshipid);
				if(IsValidShip(crashedshipid)){
				    oldhealth=CreatedShips[crashedshipid][e_Health];
				    CreatedShips[crashedshipid][e_Health]+=(speed*35.0);
				    CreatedShips[crashedshipid][e_DeathReason]=DEATH_REASON_CRASH_WITH_SHIP;
		            if(CreatedShips[crashedshipid][e_Health]<0.0){
		                CreatedShips[crashedshipid][e_Health]=0.0;
					}
			        CreatedShips[crashedshipid][e_CurrentSpeed]=0.0;
			        CallLocalFunction("OnShipCrash","iiffi",crashedshipid,CreatedShips[crashedshipid][e_Captain],oldhealth,CreatedShips[crashedshipid][e_Health],shipid);
				}
			    return -2;
		    }
		}
		else{
		    vx=(ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][2]*floatsin(-a,degrees));//vorwärts
			vy=(ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][2]*floatcos(-a,degrees));//vorwärts
			if(!ShipMoveCheck(shipid,true,crashedshipid)){
		        new Float:oldhealth=CreatedShips[shipid][e_Health];
		        for(new i=0;i<ShipModelData[CreatedShips[shipid][e_ModelID]][e_ObjectCount];i++){
			        StopObject(CreatedShipObjects[shipid][i]);
				}
	            CreatedShips[shipid][e_Health]-=(speed*50.0);
	            if(CreatedShips[shipid][e_Health]<0.0){
	                CreatedShips[shipid][e_Health]=0.0;
				}
		        CreatedShips[shipid][e_CurrentSpeed]=0.0;
		        CallLocalFunction("OnShipCrash","iiffi",shipid,CreatedShips[shipid][e_Captain],oldhealth,CreatedShips[shipid][e_Health],crashedshipid);
		        if(IsValidShip(crashedshipid)){
				    oldhealth=CreatedShips[crashedshipid][e_Health];
				    CreatedShips[crashedshipid][e_Health]-=(speed*35.0);
				    CreatedShips[crashedshipid][e_DeathReason]=DEATH_REASON_CRASH_WITH_SHIP;
		            if(CreatedShips[crashedshipid][e_Health]<0.0){
						CreatedShips[crashedshipid][e_Health]=0.0;
					}
			        CreatedShips[crashedshipid][e_CurrentSpeed]=0.0;
			        CallLocalFunction("OnShipCrash","iiffi",crashedshipid,CreatedShips[crashedshipid][e_Captain],oldhealth,CreatedShips[crashedshipid][e_Health],shipid);
				}
			    return -2;
		    }
		}
		for(new i=0;i<ShipModelData[CreatedShips[shipid][e_ModelID]][e_ObjectCount];i++){
		    StopObject(CreatedShipObjects[shipid][i]);
		    GetObjectPos(CreatedShipObjects[shipid][i],x,y,z);
		    x+=vx;
		    y+=vy;
		    MoveObject(CreatedShipObjects[shipid][i],x,y,z,floatabs(speed));
		}
	    CreatedShips[shipid][e_CurrentSpeed]=speed;
		return 1;
	}
	public ActivateShipHorn(shipid){
	    if(!IsValidShip(shipid)){
			return 0;
		}
		new Float:x,Float:y,Float:z;
		new Float:px,Float:py,Float:pz;
		GetShipCommandoBridge(shipid,x,y,z);
		for(new i=0;i<MAX_PLAYERS;i++){
		    if(IsPlayerConnected(i)){
		        if(CaptainOnShip[i]==shipid){
	                GetPlayerShipCameraPos(i,px,py,pz);
	 	 			PlayerPlaySound(i,1147,px,py,pz);
		        }
				else if(IsPlayerInRangeOfPoint(i,200.0,x,y,z)){
				    GetPlayerPos(i,px,py,pz);
	 	 			PlayerPlaySound(i,1147,px,py,pz);
				}
			}
		}
		return 1;
	}
	public ChangePlayerCamera(playerid){
		if(!IsPlayerConnected(playerid)){
		    return 0;
		}
		if(ShipCamera[playerid]){
		    ShipCamera[playerid]=false;
		}
		else{
		    ShipCamera[playerid]=true;
		}
		return 1;
	}
	public TogglePlayerShipCamera(playerid,toggle){
		if(!IsPlayerConnected(playerid)){
		    return 0;
		}
	    PlayerCameraAngle[playerid]=0.0;
		ShipCamera[playerid]=toggle;
		return 1;
	}
	public RepairShip(shipid){
	    if(!IsValidShip(shipid)){
			return 0;
		}
		if(CreatedShips[shipid][e_Dead]){
		    return -1;
		}
		CreatedShips[shipid][e_Health]=ShipModelData[CreatedShips[shipid][e_ModelID]][e_MaxHealth];
		return 1;
	}
	public SetShipHealth(shipid,Float:health){
		if(!IsValidShip(shipid)){
			return 0;
		}
	    if(CreatedShips[shipid][e_Dead]){
		    return -1;
		}
		if(health<=0.0){
		    CreatedShips[shipid][e_DeathReason]=DEATH_REASON_SERVERKILL;
		}
	    CreatedShips[shipid][e_Health]=health;
		return 1;
	}
	public SetShipToRespawn(shipid){
	    if(!IsValidShip(shipid)){
		    return 0;
		}
	    for(new i=0;i<ShipModelData[CreatedShips[shipid][e_ModelID]][e_ObjectCount];i++){
	        StopObject(CreatedShipObjects[shipid][i]);
		}
	    CreatedShips[shipid][e_CurrentSpeed]=0.0;
	    CreatedShips[shipid][e_Unused]=0;
	    CreatedShips[shipid][e_ShipEntered]=false;
	    CreatedShips[shipid][e_Health]=ShipModelData[CreatedShips[shipid][e_ModelID]][e_MaxHealth];
	    CreatedShips[shipid][e_Dead]=false;
	    CreatedShips[shipid][e_DeathReason]=DEATH_REASON_NONE;
	    UpdateShipPos(shipid,CreatedShips[shipid][e_SpawnPos][0],CreatedShips[shipid][e_SpawnPos][1],CreatedShips[shipid][e_SpawnPos][2]);
	    if(IsPlayerConnected(CreatedShips[shipid][e_Captain])){
			TogglePlayerControllable(CreatedShips[shipid][e_Captain],true);
			SetCameraBehindPlayer(CreatedShips[shipid][e_Captain]);
		}
		for(new i=0;i<MAX_PLAYERS;i++){
			PassengerOnShip[i]=INVALID_SHIP_ID;
		}
	    CreatedShips[shipid][e_Captain]=INVALID_PLAYER_ID;
	    SetTimerEx("RespawnFix",400+random(200),false,"i",shipid);
		return 1;
	}
	public RespawnFix(shipid){
	    if(!IsValidShip(shipid)){
		    return 0;
		}
	    for(new i=0;i<ShipModelData[CreatedShips[shipid][e_ModelID]][e_ObjectCount];i++){
	        StopObject(CreatedShipObjects[shipid][i]);
		}
	    UpdateShipPos(shipid,CreatedShips[shipid][e_SpawnPos][0],CreatedShips[shipid][e_SpawnPos][1],CreatedShips[shipid][e_SpawnPos][2]);
		CallLocalFunction("OnShipSpawn","i",shipid);
		Remove3DEnterExitLabel(shipid);
		return 1;
	}
	public SetShipZAngle(shipid,Float:a){
		if(!IsValidShip(shipid)){
		    return 0;
		}
		new Float:x,Float:y;
		GetShipPos(shipid,x,y);
		UpdateShipPos(shipid,x,y,a);
		return 1;
	}
	public SetShipPos(shipid,Float:x,Float:y){
		if(!IsValidShip(shipid)){
		    return 0;
		}
		new Float:a;
		GetShipZAngle(shipid,a);
		UpdateShipPos(shipid,x,y,a);
		return 1;
	}
	public RespawnUpdate(){
	    if(!ShipCount){
		    return 0;
		}
	    for(new i=0;i<MAX_SHIPS;i++){
		    if(CreatedShips[i][e_Created]){
			    if(CreatedShips[i][e_ShipEntered]){
					//Kein Respawn bevor es nicht mindestens einmal benutzt wurde
	     			if(CreatedShips[i][e_RespawnDelay]>=0 && !IsPlayerConnected(CreatedShips[i][e_Captain])){
			            CreatedShips[i][e_Unused]++;
			            if(CreatedShips[i][e_Unused]>=CreatedShips[i][e_RespawnDelay]){
			                SetShipToRespawn(i);
						}
			        }
			        else{
	                    CreatedShips[i][e_Unused]=0;
					}
			    }
			}
		}
		return 1;
	}
	public ShipUpdate(){
		if(!ShipCount){
		    return 0;
		}
		new t=GetTickCount();
		new Float:x,Float:y,Float:z,Float:a,captainconnected,keys,updown,leftright,Float:cos,Float:sin;
		for(new i=0;i<MAX_SHIPS;i++){
		    if(CreatedShips[i][e_Created] && !CreatedShips[i][e_Dead]){
				GetShipPos(i,x,y);
			    GetShipZAngle(i,a);
				for(new j=0;j<MAX_PLAYERS;j++){
					if(IsPlayerConnected(j) && j!=CreatedShips[i][e_Captain]){
					    SetPlayerMapIcon(j,99-i,x,y,0.0,9,0);
					}
				}
			    captainconnected=IsPlayerConnected(CreatedShips[i][e_Captain]);
				if(CreatedShips[i][e_Health]<=0.0){
				    CreatedShips[i][e_Dead]=true;
			        for(new j=0;j<ShipModelData[CreatedShips[i][e_ModelID]][e_ObjectCount];j++){
						//Schiff sinkt
					    GetObjectPos(CreatedShipObjects[i][j],x,y,z);
					    MoveObject(CreatedShipObjects[i][j],x,y,z-(50.0),3.50);
					}
					if(captainconnected){
					    TogglePlayerControllable(CreatedShips[i][e_Captain],true);
						SetCameraBehindPlayer(CreatedShips[i][e_Captain]);
					    CaptainOnShip[CreatedShips[i][e_Captain]]=INVALID_SHIP_ID;
					    CreatedShips[i][e_Captain]=INVALID_PLAYER_ID;
					}
					for(new j=0;j<MAX_PLAYERS;j++){
						PassengerOnShip[j]=INVALID_SHIP_ID;
					}
					SetTimerEx("CreateShipExplosion",500,false,"i",i);
					SetTimerEx("CreateShipExplosion",750,false,"i",i);
					SetTimerEx("CreateShipExplosion",1000,false,"i",i);
					SetTimerEx("CreateShipExplosion",2000,false,"i",i);
					CallLocalFunction("OnShipDeath","ii",i,CreatedShips[i][e_DeathReason]);
					SetTimerEx("SetShipToRespawn",10000,false,"i",i);
				}
				else{
					if(captainconnected || CreatedShips[i][e_CurrentSpeed]!=0.0){
					    if(captainconnected){
					        GetPlayerKeys(CreatedShips[i][e_Captain],keys,updown,leftright);
					        if(CreatedShips[i][e_CurrentSpeed]!=0.0){
					            if(leftright>0){
					                //Rechts
									a-=ShipModelData[CreatedShips[i][e_ModelID]][e_TurnSpeed];
					                if(a<0.0){
					                    a+=360.0;
									}
									UpdateShipPos(i,x,y,a);
					            }
					            else if(leftright<0){
									//Links
					                a+=ShipModelData[CreatedShips[i][e_ModelID]][e_TurnSpeed];
					                if(a>360.0){
					                	a-=360.0;
									}
									UpdateShipPos(i,x,y,a);
					            }
							}
					        if(updown<0){
								//Gibt "Gas"!
					            CreatedShips[i][e_CurrentSpeed]+=ShipModelData[CreatedShips[i][e_ModelID]][e_Acceleration];
						        if(CreatedShips[i][e_CurrentSpeed]>ShipModelData[CreatedShips[i][e_ModelID]][e_MaxSpeed]){
						            CreatedShips[i][e_CurrentSpeed]=ShipModelData[CreatedShips[i][e_ModelID]][e_MaxSpeed];
								}
								MoveShip(i,CreatedShips[i][e_CurrentSpeed]);
					        }
					        else if(updown>0){
								//will rückwärts
					            CreatedShips[i][e_CurrentSpeed]-=(ShipModelData[CreatedShips[i][e_ModelID]][e_Acceleration]*0.75);
					            if(CreatedShips[i][e_CurrentSpeed]<(-ShipModelData[CreatedShips[i][e_ModelID]][e_MaxSpeed]/2)){
					                CreatedShips[i][e_CurrentSpeed]=(-ShipModelData[CreatedShips[i][e_ModelID]][e_MaxSpeed]/2);
								}
								MoveShip(i,CreatedShips[i][e_CurrentSpeed]);
					        }
					        else if(keys & KEY_SPRINT && CreatedShips[i][e_CurrentSpeed]>0.0){
								//Captain bremst ab
						        CreatedShips[i][e_CurrentSpeed]-=(ShipModelData[CreatedShips[i][e_ModelID]][e_Acceleration]*1.7);
						        if(CreatedShips[i][e_CurrentSpeed]<0.0){
						            CreatedShips[i][e_CurrentSpeed]=0.0;
								}
								MoveShip(i,CreatedShips[i][e_CurrentSpeed]);
						    }
							else if(keys & KEY_SPRINT && CreatedShips[i][e_CurrentSpeed]<0.0){
								//Captain bremst ab
						        CreatedShips[i][e_CurrentSpeed]+=(ShipModelData[CreatedShips[i][e_ModelID]][e_Acceleration]*1.7);
						        if(CreatedShips[i][e_CurrentSpeed]>0.0){
						            CreatedShips[i][e_CurrentSpeed]=0.0;
								}
								MoveShip(i,CreatedShips[i][e_CurrentSpeed]);
						    }
							else if(CreatedShips[i][e_CurrentSpeed]>0.0){
								//Schiff wird langsam weil niemand Gas gibt
						        CreatedShips[i][e_CurrentSpeed]-=(ShipModelData[CreatedShips[i][e_ModelID]][e_Acceleration]*0.66);
						        if(CreatedShips[i][e_CurrentSpeed]<0.0){
						            CreatedShips[i][e_CurrentSpeed]=0.0;
								}
								MoveShip(i,CreatedShips[i][e_CurrentSpeed]);
						    }
						    else if(CreatedShips[i][e_CurrentSpeed]<0.0){
								//Schiff wird langsam weil niemand Gas gibt
						        CreatedShips[i][e_CurrentSpeed]+=(ShipModelData[CreatedShips[i][e_ModelID]][e_Acceleration]*0.66);
						        if(CreatedShips[i][e_CurrentSpeed]>0.0){
						            CreatedShips[i][e_CurrentSpeed]=0.0;
								}
								MoveShip(i,CreatedShips[i][e_CurrentSpeed]);
						    }
					        GetShipCommandoBridge(i,x,y,z);
					        SetPlayerPos(CreatedShips[i][e_Captain],x,y,z);
					        SetPlayerFacingAngle(CreatedShips[i][e_Captain],a);
					        if(!ShipCamera[CreatedShips[i][e_Captain]]){
		           				SetCameraBehindPlayer(CreatedShips[i][e_Captain]);
							}
							else{
							    if(keys & KEY_LOOK_BEHIND){
							        PlayerCameraAngle[CreatedShips[i][e_Captain]]=0.0;
								    cos=-floatcos(-a,degrees);
									sin=-floatsin(-a,degrees);
								}
								else{
								    if(keys & KEY_ANALOG_RIGHT){
								        PlayerCameraAngle[CreatedShips[i][e_Captain]]+=1.5;
									}
								    else if(keys & KEY_ANALOG_LEFT){
								        PlayerCameraAngle[CreatedShips[i][e_Captain]]-=1.5;
									}
								    cos=floatcos(-(a+PlayerCameraAngle[CreatedShips[i][e_Captain]]),degrees);
									sin=floatsin(-(a+PlayerCameraAngle[CreatedShips[i][e_Captain]]),degrees);
								}
								PlayerShipCameraPos[CreatedShips[i][e_Captain]][0]=x-(ShipModelData[CreatedShips[i][e_ModelID]][e_CommandoBridgeOffset][3]*sin);
								PlayerShipCameraPos[CreatedShips[i][e_Captain]][1]=y-(ShipModelData[CreatedShips[i][e_ModelID]][e_CommandoBridgeOffset][3]*cos);
								PlayerShipCameraPos[CreatedShips[i][e_Captain]][2]=ShipModelData[CreatedShips[i][e_ModelID]][e_CommandoBridgeOffset][4];
							    SetPlayerCameraPos(CreatedShips[i][e_Captain],PlayerShipCameraPos[CreatedShips[i][e_Captain]][0],PlayerShipCameraPos[CreatedShips[i][e_Captain]][1],PlayerShipCameraPos[CreatedShips[i][e_Captain]][2]);//rückwärts
								SetPlayerCameraLookAt(CreatedShips[i][e_Captain],x+(ShipModelData[CreatedShips[i][e_ModelID]][e_CommandoBridgeOffset][3]*sin),y+(ShipModelData[CreatedShips[i][e_ModelID]][e_CommandoBridgeOffset][3]*cos),ShipModelData[CreatedShips[i][e_ModelID]][e_CommandoBridgeOffset][5]);//rückwärts
							}
					    }
					    else{
							UpdateShipPos(i,x,y,a);
							if(CreatedShips[i][e_CurrentSpeed]>0.0){
								//Schiff wird langsam weil niemand Gas gibt
						        CreatedShips[i][e_CurrentSpeed]-=(ShipModelData[CreatedShips[i][e_ModelID]][e_Acceleration]*0.66);
						        if(CreatedShips[i][e_CurrentSpeed]<0.0){
						            CreatedShips[i][e_CurrentSpeed]=0.0;
								}
								MoveShip(i,CreatedShips[i][e_CurrentSpeed]);
						    }
						    else if(CreatedShips[i][e_CurrentSpeed]<0.0){
								//Schiff wird langsam weil niemand Gas gibt
						        CreatedShips[i][e_CurrentSpeed]+=(ShipModelData[CreatedShips[i][e_ModelID]][e_Acceleration]*0.66);
						        if(CreatedShips[i][e_CurrentSpeed]>0.0){
						            CreatedShips[i][e_CurrentSpeed]=0.0;
								}
								MoveShip(i,CreatedShips[i][e_CurrentSpeed]);
						    }
						}
					}
				    else{
							Set3DEnterExitLabel(i);
					}
				}
				PassengerUpdate(i);
			}
		}
		ShipUpdateCount++;
		t=(GetTickCount()-t);
		ShipUpdateSpeed+=t;
		if(ShipUpdateCount>=20){
		    if(PrintTestResult){
				printf("Durchschnittliche Berechnungszeit für ShipUpdate(): %.2f ms, t: %d ms",float(ShipUpdateSpeed)/float(ShipUpdateCount),t);
			}
		    ShipUpdateCount=0;
		    ShipUpdateSpeed=0;
		}
		return 1;
	}
	public PassengerUpdate(shipid){
	    if(!IsValidShip(shipid)){
		    return 0;
		}
		new Float:x,Float:y,Float:a;
	    GetShipPos(shipid,x,y);
	    GetShipZAngle(shipid,a);
	    new Float:px,Float:py,Float:cos=floatcos(a,degrees),Float:sin=floatsin(a,degrees);
		for(new i=0;i<MAX_PLAYERS;i++){
		    if(IsPlayerConnected(i) && PassengerOnShip[i]==shipid){
		        px=PlayerPosOnShip[i][0];
		        py=PlayerPosOnShip[i][1];
		        TurnXYAroundCenterEx(px,py,0.0,0.0,cos,sin);
		        px+=x;
		        py+=y;
		        SetPlayerPos(i,px,py,PlayerPosOnShip[i][2]);
		    }
		}
		return 1;
	}
	public CreateShipExplosion(shipid){
		if(!IsValidShip(shipid)){
		    return 0;
		}
		new Float:x,Float:y,Float:z;
		GetObjectPos(CreatedShipObjects[shipid][0],x,y,z);
		CreateExplosion(x,y,z,6,15.0);
		GetShipCommandoBridge(shipid,x,y,z);
		CreateExplosion(x,y,z,6,8.0);
		return 1;
	}
	stock ShipMoveCheck(shipid,ahead,&crashedshipid){
		if(!IsValidShip(shipid)){
		    return false;
		}
		new Float:corner_x[4],Float:corner_y[4];
		new Float:z;
		GetShipCorners(shipid,corner_x,corner_y);
		if(ahead){
	    	MapAndreas_FindZ_For2DCoord(corner_x[0],corner_y[0],z);
		    if((z>0.0 && !IsPointUnderBridge(corner_x[0],corner_y[0]))){
			    CreatedShips[shipid][e_DeathReason]=DEATH_REASON_CRASH_WITH_LAND;
		    	return false;
			}
			crashedshipid=GetShipByPoint(corner_x[0],corner_y[0],shipid);
			if(IsValidShip(crashedshipid)){
			    CreatedShips[shipid][e_DeathReason]=DEATH_REASON_CRASH_WITH_SHIP;
	    		return false;
			}
	    	MapAndreas_FindZ_For2DCoord(corner_x[1],corner_y[1],z);
		    if((z>0.0 && !IsPointUnderBridge(corner_x[1],corner_y[1]))){
				CreatedShips[shipid][e_DeathReason]=DEATH_REASON_CRASH_WITH_LAND;
		    	return false;
			}
			crashedshipid=GetShipByPoint(corner_x[1],corner_y[1],shipid);
			if(IsValidShip(crashedshipid)){
			    CreatedShips[shipid][e_DeathReason]=DEATH_REASON_CRASH_WITH_SHIP;
	    		return false;
			}
		}
		else{
		    MapAndreas_FindZ_For2DCoord(corner_x[2],corner_y[2],z);
		    if((z>0.0 && !IsPointUnderBridge(corner_x[2],corner_y[2]))){
				CreatedShips[shipid][e_DeathReason]=DEATH_REASON_CRASH_WITH_LAND;
		    	return false;
			}
			crashedshipid=GetShipByPoint(corner_x[2],corner_y[2],shipid);
			if(IsValidShip(crashedshipid)){
			    CreatedShips[shipid][e_DeathReason]=DEATH_REASON_CRASH_WITH_SHIP;
	    		return false;
			}
		    MapAndreas_FindZ_For2DCoord(corner_x[3],corner_y[3],z);
		    if((z>0.0 && !IsPointUnderBridge(corner_x[3],corner_y[3]))){
				CreatedShips[shipid][e_DeathReason]=DEATH_REASON_CRASH_WITH_LAND;
		    	return false;
			}
			crashedshipid=GetShipByPoint(corner_x[3],corner_y[3],shipid);
			if(IsValidShip(crashedshipid)){
			    CreatedShips[shipid][e_DeathReason]=DEATH_REASON_CRASH_WITH_SHIP;
	    		return false;
			}
		}
		return true;
	}
	stock Set3DEnterExitLabel(shipid){
		if(!IsValidShip(shipid)){
		    return 0;
		}
		if(CreatedShipLabel[shipid]!=Text3D:INVALID_3DTEXT_ID){
			return 0;
		}
		new Float:x,Float:y,Float:z;
		GetShipCommandoBridge(shipid,x,y,z);
	    CreatedShipLabel[shipid]=Create3DTextLabel("Press F or ENTER to enter/exit the ship!", 0xFFFFFFAA, x,y,z, 35.0,0);
		return 1;
	}
	stock Remove3DEnterExitLabel(shipid){
		if(!IsValidShip(shipid)){
		    return 0;
		}
		if(CreatedShipLabel[shipid]==Text3D:INVALID_3DTEXT_ID){
			return 0;
		}
		Delete3DTextLabel(CreatedShipLabel[shipid]);
		CreatedShipLabel[shipid]=Text3D:INVALID_3DTEXT_ID;
		return 1;
	}
	stock TurnXYAroundCenter(&Float:x,&Float:y,Float:center_x,Float:center_y,Float:a){
		new Float:cos=floatcos(a,degrees),Float:sin=floatsin(a,degrees),Float:tmp_x=x,Float:tmp_y=y;
		x=cos*tmp_x-sin*tmp_y-cos*center_x+sin*center_y+center_x;
		y=sin*tmp_x+cos*tmp_y-cos*center_y-sin*center_x+center_y;
		return 1;
	}
	stock TurnXYAroundCenterEx(&Float:x,&Float:y,Float:center_x,Float:center_y,Float:cos,Float:sin){
		new Float:tmp_x=x,Float:tmp_y=y;
		x=cos*tmp_x-sin*tmp_y-cos*center_x+sin*center_y+center_x;
		y=sin*tmp_x+cos*tmp_y-cos*center_y-sin*center_x+center_y;
		return 1;
	}
	stock Ship_IsPointInArea(Float:x,Float:y,Float:max_x,Float:min_x,Float:max_y,Float:min_y){
		return (x<=max_x && x>=min_x && y<=max_y && y>=min_y);
	}
//$ endregion Rideable Ships - Functions
//$ region Rideable Ships - Callbacks
	public OnGameModeInit(){
		//Modeldaten (Koordinaten aus Map Editor) auf Ursprung verschieben und nach Norden ausrichten
		MapAndreas_Init(MAP_ANDREAS_MODE_FULL);
		for(new i=0;i<MAX_SHIPS;i++){
			for(new j=0;j<MAX_SHIP_OBJECTS;j++){
			    CreatedShipObjects[i][j]=INVALID_OBJECT_ID;
			}
		}
		new Float:a,Float:x,Float:y;
		new Float:cos,Float:sin;
		for(new i=0;i<MAX_SHIP_MODELS;i++){
			x=ShipModelObjectPositions[i][0][0];
			y=ShipModelObjectPositions[i][0][1];
			a=ShipModelObjectPositions[i][0][5];
			cos=floatcos(a,degrees);
			sin=floatsin(a,degrees);
			for(new j=0;j<ShipModelData[i][e_ObjectCount];j++){
			    ShipModelObjectPositions[i][j][0]-=x;
			    ShipModelObjectPositions[i][j][1]-=y;
			    ShipModelObjectPositions[i][j][5]-=a;
			    TurnXYAroundCenterEx(ShipModelObjectPositions[i][j][0],ShipModelObjectPositions[i][j][1],0.0,0.0,cos,sin);
		    }
		    ShipModelData[i][e_CommandoBridgeOffset][0]-=x;
		    ShipModelData[i][e_CommandoBridgeOffset][1]-=y;
		    TurnXYAroundCenterEx(ShipModelData[i][e_CommandoBridgeOffset][0],ShipModelData[i][e_CommandoBridgeOffset][1],0.0,0.0,cos,sin);
		}
		OPES_Implemented=funcidx("OnPlayerEnterShip")!=-1;
		OCUH_Implemented=funcidx("OnCaptainUseHorn")!=-1;
		ShipUpdateTimer=SetTimer("ShipUpdate",50,true);
		RespawnTimer=SetTimer("RespawnUpdate",1000,true);
		print("\n");
		print("~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~");
		print(" Double-O-Ship by Double-O-Seven geladen!");
		print("~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~");
		print("\n");
		return CallLocalFunction("Ship_OnGameModeInit","");
	}
	public OnGameModeExit(){
		for(new i=0;i<MAX_SHIPS;i++){
			DestroyShip(i);
		}
		KillTimer(ShipUpdateTimer);
		KillTimer(RespawnTimer);
		return CallLocalFunction("Ship_OnGameModeExit","");
	}
	public OnPlayerKeyStateChange(playerid,newkeys,oldkeys){
		if(newkeys==KEY_WALK && IsValidShip(CaptainOnShip[playerid])){
		    if(!OCUH_Implemented || CallLocalFunction("OnCaptainUseHorn","ii",playerid,CaptainOnShip[playerid])){
		        ActivateShipHorn(CaptainOnShip[playerid]);
			}
		}
		else if(newkeys==KEY_SECONDARY_ATTACK && GetPlayerState(playerid)==PLAYER_STATE_ONFOOT){
		    if(!IsValidShip(CaptainOnShip[playerid]) && !IsValidShip(PassengerOnShip[playerid])){
				//Nicht auf Schiff als Passagier oder Kapitän
				new Float:x,Float:y,Float:z,Float:a;
				for(new i=0;i<MAX_SHIPS;i++){
				    if(CreatedShips[i][e_Created] && !CreatedShips[i][e_Dead]){
					    GetShipCommandoBridge(i,x,y,z);
					    GetShipZAngle(i,a);
					    if(!IsPlayerConnected(CreatedShips[i][e_Captain]) && IsPlayerInRangeOfPoint(playerid,5.0,x,y,z)){
						    if(!OPES_Implemented || CallLocalFunction("OnPlayerEnterShip","iii",playerid,i,false)){
					            CreatedShips[i][e_ShipEntered]=true;
						        CreatedShips[i][e_Captain]=playerid;
								CaptainOnShip[playerid]=i;
								PlayerCameraAngle[playerid]=0.0;
								SetPlayerPos(playerid,x,y,z);
						        SetPlayerFacingAngle(playerid,a);
						        TogglePlayerControllable(playerid,false);
								GameTextForPlayer(playerid,ShipModelData[CreatedShips[i][e_ModelID]][e_ShipModelName],3000,1);
								RemovePlayerMapIcon(playerid,99-i);
								Remove3DEnterExitLabel(i);
							}
							return CallLocalFunction("Ship_OnPlayerKeyStateChange","iii",playerid,newkeys,oldkeys);
						}
						else if(IsPlayerOnShip(playerid,i)){
						    if(!OPES_Implemented || CallLocalFunction("OnPlayerEnterShip","iii",playerid,i,true)){
							    GetShipPos(i,x,y);
							    GetPlayerPos(playerid,PlayerPosOnShip[playerid][0],PlayerPosOnShip[playerid][1],PlayerPosOnShip[playerid][2]);
							    PlayerPosOnShip[playerid][0]-=x;
							    PlayerPosOnShip[playerid][1]-=y;
							    TurnXYAroundCenter(PlayerPosOnShip[playerid][0],PlayerPosOnShip[playerid][1],0.0,0.0,-a);
							    PassengerOnShip[playerid]=i;
								GameTextForPlayer(playerid,ShipModelData[CreatedShips[i][e_ModelID]][e_ShipModelName],3000,1);
							}
						}
					}
				}
			}
			else{
			    if(IsValidShip(CaptainOnShip[playerid])){
				    CallLocalFunction("OnPlayerExitShip","ii",playerid,CaptainOnShip[playerid]);
				    TogglePlayerControllable(playerid,true);
					SetCameraBehindPlayer(playerid);
				    CreatedShips[CaptainOnShip[playerid]][e_Captain]=INVALID_PLAYER_ID;
				    CaptainOnShip[playerid]=INVALID_SHIP_ID;
				}
				else if(IsValidShip(PassengerOnShip[playerid])){
				    CallLocalFunction("OnPlayerExitShip","ii",playerid,PassengerOnShip[playerid]);
					PassengerOnShip[playerid]=INVALID_SHIP_ID;
				}
			}
		}
		return CallLocalFunction("Ship_OnPlayerKeyStateChange","iii",playerid,newkeys,oldkeys);
	}
	public OnPlayerDisconnect(playerid,reason){
	    if(IsValidShip(CaptainOnShip[playerid])){
	    	TogglePlayerControllable(playerid,true);
		    CreatedShips[CaptainOnShip[playerid]][e_Captain]=INVALID_PLAYER_ID;
		    CaptainOnShip[playerid]=INVALID_SHIP_ID;
		}
		PassengerOnShip[playerid]=INVALID_SHIP_ID;
		TogglePlayerShipCamera(playerid,true);
		return CallLocalFunction("Ship_OnPlayerDisconnect","ii",playerid,reason);
	}
	public OnPlayerStateChange(playerid,newstate,oldstate){
		#pragma unused newstate
		if(oldstate==PLAYER_STATE_ONFOOT){
		    if(IsValidShip(CaptainOnShip[playerid])){
		    	TogglePlayerControllable(playerid,true);
		    	SetCameraBehindPlayer(playerid);
			    CreatedShips[CaptainOnShip[playerid]][e_Captain]=INVALID_PLAYER_ID;
			    CaptainOnShip[playerid]=INVALID_SHIP_ID;
			}
			PassengerOnShip[playerid]=INVALID_SHIP_ID;
		}
		return CallLocalFunction("Ship_OnPlayerStateChange","iii",playerid,newstate,oldstate);
	}
	public OnPlayerCommandText(playerid,cmdtext[]){
		if(!strcmp(cmdtext,"/respawn",true) && IsPlayerAdmin(playerid)){
		    for(new i=0;i<MAX_SHIPS;i++){
		        if(IsValidShip(i) && !IsPlayerConnected(GetShipCaptain(i))){
		        	SetShipToRespawn(i);
				}
			}
			SendClientMessage(playerid,0xFF00FFFF,"You have resetted unused ships!");
		    return 1;
		}
		if(!strcmp(cmdtext,"/respawnall",true) && IsPlayerAdmin(playerid)){
		    for(new i=0;i<MAX_SHIPS;i++){
		        SetShipToRespawn(i);
			}
			SendClientMessage(playerid,0x00FF00FF,"You have resetted all ships!");
		    return 1;
		}
		if(!strcmp(cmdtext,"/camera",true)){
		    ChangePlayerCamera(playerid);
		    return 1;
		}
		if(!strcmp(cmdtext,"/myship",true)){
		    new string[64];
		    format(string,sizeof(string),"Your ship: %d",GetPlayerShipID(playerid));
			SendClientMessage(playerid,0x0000FFFF,string);
			return 1;
		}
		return CallLocalFunction("Ship_OnPlayerCommandText","is",playerid,cmdtext);
	}
//$ endregion Rideable Ships - Callbacks
//$ region Rideable Ships - Get-Functions
	stock GetShipHealth(shipid,&Float:health){
		if(!IsValidShip(shipid)){
		    return 0;
		}
		health=CreatedShips[shipid][e_Health];
		return 1;
	}
	stock GetShipMaxHealth(shipid,&Float:maxhealth){
		if(!IsValidShip(shipid)){
		    return 0;
		}
		maxhealth=ShipModelData[CreatedShips[shipid][e_ModelID]][e_MaxHealth];
		return 1;
	}
	stock GetPlayerShipCameraPos(playerid,&Float:x,&Float:y,&Float:z){
		if(!IsPlayerConnected(playerid)){
			return 0;
		}
		if(!ShipCamera[playerid] || CaptainOnShip[playerid]==INVALID_SHIP_ID){
			GetPlayerPos(playerid,x,y,z);
		}
		else
		{
			x=PlayerShipCameraPos[playerid][0];
			y=PlayerShipCameraPos[playerid][1];
			z=PlayerShipCameraPos[playerid][2];
		}
		return 1;
	}
	stock GetShipCommandoBridge(shipid,&Float:x,&Float:y,&Float:z){
	    if(!IsValidShip(shipid)){
		    return 0;
		}
		new Float:a,Float:center_x,Float:center_y;
		GetShipZAngle(shipid,a);
		a-=ShipModelData[CreatedShips[shipid][e_ModelID]][e_NorthAngle];
		GetShipPos(shipid,center_x,center_y);
		x=center_x+ShipModelData[CreatedShips[shipid][e_ModelID]][e_CommandoBridgeOffset][0];
		y=center_y+ShipModelData[CreatedShips[shipid][e_ModelID]][e_CommandoBridgeOffset][1];
		z=ShipModelData[CreatedShips[shipid][e_ModelID]][e_CommandoBridgeOffset][2];
		TurnXYAroundCenter(x,y,center_x,center_y,a);
		return 1;
	}
	stock GetShipCorners(shipid,Float:corner_x[4],Float:corner_y[4]){
	    if(!IsValidShip(shipid)){
		    return 0;
		}
		new Float:x,Float:y,Float:a;
		GetShipPos(shipid,x,y);
		GetShipZAngle(shipid,a);
		corner_x[0]=ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][0];//Erster Quadrant
		corner_y[0]=ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][2];//Erster Quadrant
		corner_x[1]=-ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][1];//Zweiter Quadrant
		corner_y[1]=ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][2];//Zweiter Quadrant
		corner_x[2]=-ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][1];//Dritter Quadrant
		corner_y[2]=-ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][3];//Dritter Quadrant
		corner_x[3]=ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][0];//Vierter Quadrant
		corner_y[3]=-ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][3];//Vierter Quadrant
		new Float:cos=floatcos(a,degrees),Float:sin=floatsin(a,degrees);
		for(new i=0;i<4;i++){
		    TurnXYAroundCenterEx(corner_x[i],corner_y[i],0.0,0.0,cos,sin);
		    corner_x[i]+=x;
		    corner_y[i]+=y;
		}
		return 1;
	}
	stock GetShipByPoint(Float:x,Float:y,invalidshipid=INVALID_SHIP_ID){
	    for(new i=0;i<MAX_SHIPS;i++){
	        if(i!=invalidshipid && CreatedShips[i][e_Created]){
	            if(IsPointOnShip(x,y,i)){
	                return i;
				}
			}
		}
		return INVALID_SHIP_ID;
	}
	stock GetShipCaptain(shipid){
		if(!IsValidShip(shipid)){
		    return INVALID_PLAYER_ID;
		}
		return CreatedShips[shipid][e_Captain];
	}
	stock GetShipSpeed(shipid,&Float:speed){
		if(!IsValidShip(shipid)){
		    return 0;
		}
		speed=CreatedShips[shipid][e_CurrentSpeed];
		return 1;
	}
	stock GetShipModel(shipid){
		if(!IsValidShip(shipid)){
			return -1;
		}
		return CreatedShips[shipid][e_ModelID];
	}
	stock GetPlayerShipID(playerid){
		if(!IsPlayerConnected(playerid)){
		    return INVALID_SHIP_ID;
		}
		if(IsValidShip(CaptainOnShip[playerid])){
			return CaptainOnShip[playerid];
		}
		if(IsValidShip(PassengerOnShip[playerid])){
		    return PassengerOnShip[playerid];
		}
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		#pragma unused z
		return GetShipByPoint(x,y,INVALID_SHIP_ID);
	}
	stock GetShipPos(shipid,&Float:x,&Float:y){
		if(!IsValidShip(shipid)){
		    return 0;
		}
		new Float:z;
		return GetObjectPos(CreatedShipObjects[shipid][0],x,y,z);
	}
	stock GetShipZAngle(shipid,&Float:a){
	    if(!IsValidShip(shipid)){
		    return 0;
		}
		new Float:rx,Float:ry;
		GetObjectRot(CreatedShipObjects[shipid][0],rx,ry,a);
		a+=ShipModelData[CreatedShips[shipid][e_ModelID]][e_NorthAngle];
		return 1;
	}
	stock GetDefaultShipPositions(modelid,object,&Float:x,&Float:y,&Float:z,&Float:rx,&Float:ry,&Float:rz){
		if(!IsValidShipModel(modelid)){
		    return 0;
		}
		if(object<0 || object>=ShipModelData[modelid][e_ObjectCount]){
		    return 0;
		}
		x=ShipModelObjectPositions[modelid][object][0];
		y=ShipModelObjectPositions[modelid][object][1];
		z=ShipModelObjectPositions[modelid][object][2];
		rx=ShipModelObjectPositions[modelid][object][3];
		ry=ShipModelObjectPositions[modelid][object][4];
		rz=ShipModelObjectPositions[modelid][object][5];
		return 1;
	}
	stock GetShipName(shipid,name[],len){
	    if(!IsValidShip(shipid)){
		    return 0;
		}
		return format(name,len,ShipModelData[CreatedShips[shipid][e_ModelID]][e_ShipModelName]);
	}
//$ endregion Rideable Ships - Get-Functions
//$ region Rideable Ships - Is-Abfragen
	stock IsPointOnShip(Float:x,Float:y,shipid){
		if(!IsValidShip(shipid)){
		    return false;
		}
		new Float:center_x,Float:center_y,Float:a;
		new Float:corner_x[4],Float:corner_y[4];
		GetShipPos(shipid,center_x,center_y);
		GetShipZAngle(shipid,a);
		corner_x[0]=ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][0];//Erster Quadrant
		corner_y[0]=ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][2];//Erster Quadrant
		corner_x[1]=-ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][1];//Zweiter Quadrant
		corner_y[1]=ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][2];//Zweiter Quadrant
		corner_x[2]=-ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][1];//Dritter Quadrant
		corner_y[2]=-ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][3];//Dritter Quadrant
		corner_x[3]=ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][0];//Vierter Quadrant
		corner_y[3]=-ShipModelData[CreatedShips[shipid][e_ModelID]][e_Size][3];//Vierter Quadrant
		x-=center_x;//In den Ursprung verschieben, weil auch die Ecken im Ursprung sind.
		y-=center_y;
	    TurnXYAroundCenter(x,y,0.0,0.0,-a);
		return Ship_IsPointInArea(x,y,corner_x[0],corner_x[1],corner_y[1],corner_y[3]);
	}
	stock IsPointOnAnyShip(Float:x,Float:y,invalidshipid=INVALID_SHIP_ID){
		return (GetShipByPoint(x,y,invalidshipid)!=INVALID_SHIP_ID);
	}
	stock IsPlayerOnShip(playerid,shipid){
		if(!IsPlayerConnected(playerid) || !IsValidShip(shipid)){
		    return false;
		}
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		return IsPointOnShip(x,y,shipid);
	}
	stock IsValidShip(shipid){
		if(shipid<0 || shipid>=MAX_SHIPS){
		    return 0;
		}
		return CreatedShips[shipid][e_Created];
	}
	stock IsValidShipModel(modelid){
		return (modelid>=0 && modelid<MAX_SHIP_MODELS);
	}
	stock IsPointUnderBridge(Float:x,Float:y){
		for(new i=0;i<sizeof(BridgeZones);i++){
			if(Ship_IsPointInArea(x,y,BridgeZones[i][0],BridgeZones[i][1],BridgeZones[i][2],BridgeZones[i][3])){
				return true;
			}
		}
		return false;
	}
//$ endregion Rideable Ships - Is-Abfragen







