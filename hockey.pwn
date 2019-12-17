#include <a_samp>

#define FILTERSCRIPT

#define YELLOW 0xFFFF00FF
#define RED 0xFF0000FF
#define WHITE 0xFFFFFFFF
#define ORANGE 0xF97804FF
#define BLUE 0x0000FFFF

#if defined FILTERSCRIPT

new Float:HockeySpawns[10][4] =
{
{1370.3741, 2130.7910, 11.0156},
{1355.2581, 2129.7195, 11.0156},
{1336.2168, 2129.4036, 11.0156},
{1346.3798, 2144.0493, 11.0156},
{1363.4307, 2144.9565, 11.0156},
{1363.3607, 2150.4619, 11.0156},
{1344.9474, 2151.8689, 11.0156},
{1337.5403, 2170.5913, 11.0234},
{1352.0214, 2170.1721, 11.0156},
{1371.2192, 2171.7070, 11.0234}
};

//------------------------------------------------------------------------------
//--------------------------------Hockey Defines--------------------------------
//------------------------------------------------------------------------------

new PlaysHockey[MAX_PLAYERS];
new HasPuck[MAX_PLAYERS];

new Puck;

//------------------------------------------------------------------------------
//------------------------------IsObjectInArea----------------------------------
//------------------------------------------------------------------------------

stock IsObjectInArea(objectid, Float:max_x, Float:min_x, Float:max_y, Float:min_y)
{
	new Float:X, Float:Y, Float:Z;
	GetObjectPos(objectid, X, Y, Z);
	if(X <= max_x && X >= min_x && Y <= max_y && Y >= min_y) return 1;
	return 0;
}

//------------------------------------------------------------------------------
//--------------------------GetDistanceBetweenPlayers---------------------------
//------------------------------------------------------------------------------

stock GetDistanceBetweenPlayers(playerid, playerid2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	new Float:tmpdis;
	GetPlayerPos(playerid, x1, y1, z1);
	GetPlayerPos(playerid2, x2, y2, z2);
	tmpdis =

floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs

(floatsub(z2,z1)),2));
	return floatround(tmpdis);
}

//------------------------------------------------------------------------------
//----------------------------GetXYInFrontOfPlayer------------------------------
//------------------------------------------------------------------------------

stock Float:GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
    new Float:a;
    GetPlayerPos(playerid, x, y, a);
    if (IsPlayerInAnyVehicle(playerid))
        GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
    else
        GetPlayerFacingAngle(playerid, a);
    x += (distance * floatsin(-a, degrees));
    y += (distance * floatcos(-a, degrees));
    return a;
}

//------------------------------------------------------------------------------
//--------------------------------PlayerToPoint---------------------------------
//------------------------------------------------------------------------------

forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
	return 0;
}

//------------------------------------------------------------------------------
//--------------------------------ObjectToPoint---------------------------------
//------------------------------------------------------------------------------

forward ObjectToPoint(Float:radi, objectid, Float:x, Float:y, Float:z);
public ObjectToPoint(Float:radi, objectid, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetObjectPos(objectid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
  	return 0;
}

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("	  	-$- Hockey Filterscript -$-	  	   ");
	print("				  -| by |-				   ");
	print("			 -$- SpiderPork	-$-			   ");
	print("			 	   LOADED				   ");
	print("--------------------------------------\n");
	Puck = CreateObject(1319, 1353.296509, 2149.911621, 9.537497, 0, 0, 0); // The puck
	SetTimer("IsInArea", 1000, 1);
	CreateObject(3453, 1401.088989, 2105.528076, 16.736935, 0.0000, 0.0000, 0.0000);
	CreateObject(3452, 1371.763550, 2099.182129, 16.751028, 0.0000, 0.0000, 0.0000);
	CreateObject(3452, 1342.358398, 2099.221680, 16.765057, 0.0000, 0.0000, 0.0000);
	CreateObject(3453, 1312.165405, 2104.721436, 16.790056, 0.0000, 0.0000, 270.0000);
	CreateObject(3452, 1305.804199, 2134.033691, 16.797857, 0.0000, 0.0000, 270.0000);
	CreateObject(3452, 1305.818848, 2163.626221, 16.797857, 0.0000, 0.0000, 270.0000);
	CreateObject(3453, 1311.314209, 2201.489258, 16.797861, 0.0000, 0.0000, 180.0000);
	CreateObject(3452, 1305.795776, 2190.516357, 16.834555, 0.0000, 0.0000, 270.0000);
	CreateObject(4604, 1314.277222, 2124.585205, -18.819553, 91.1003, 0.0000, 90.0000);
	CreateObject(4604, 1389.221436, 2107.730713, -18.784601, 91.1003, 0.0000, 180.0000);
	CreateObject(983, 1352.813477, 2113.017578, 10.699176, 0.0000, 0.0000, 270.0000);
	CreateObject(983, 1352.812622, 2113.029541, 11.974175, 0.0000, 0.0000, 270.0000);
	CreateObject(983, 1349.593140, 2113.612305, 9.424180, 91.1003, 0.0000, 180.0000);
	CreateObject(983, 1349.604858, 2114.856934, 9.399184, 91.1003, 0.0000, 180.0000);
	CreateObject(983, 1356.029663, 2113.634033, 9.424177, 91.1003, 0.0000, 180.0000);
	CreateObject(983, 1356.014282, 2114.889893, 9.399177, 91.1003, 0.0000, 180.0000);
	CreateObject(983, 1352.806763, 2113.684326, 12.624177, 0.0000, 269.7592, 270.0000);
	CreateObject(983, 1352.648926, 2189.771240, 10.706992, 0.0000, 0.0000, 270.0000);
	CreateObject(983, 1352.646362, 2189.770264, 11.956988, 0.0000, 0.0000, 270.0000);
	CreateObject(983, 1355.813599, 2189.051514, 9.382001, 89.3814, 0.0000, 0.0000);
	CreateObject(983, 1355.812744, 2187.832275, 9.381993, 90.2409, 0.0000, 0.0000);
	CreateObject(983, 1349.442017, 2189.087891, 9.357001, 90.2409, 0.0000, 0.0000);
	CreateObject(983, 1349.440186, 2187.826660, 9.356994, 89.3814, 0.0000, 0.0000);
	CreateObject(983, 1352.645996, 2189.153320, 12.531980, 0.0000, 270.6186, 270.0000);
	CreateObject(983, 1352.651245, 2187.899658, 12.506980, 0.0000, 270.6186, 270.0000);
	CreateObject(983, 1352.808350, 2114.929443, 12.624185, 0.0000, 269.7591, 270.0000);
	CreateObject(3917, 1376.498901, 2133.413818, 3.568188, 0.0000, 0.0000, 270.0000);
	CreateObject(3917, 1363.439453, 2133.407715, 3.568184, 0.0000, 0.0000, 270.0000);
	CreateObject(3917, 1350.394165, 2133.401611, 3.568187, 0.0000, 0.0000, 270.0000);
	CreateObject(3917, 1337.359619, 2133.409424, 3.568185, 0.0000, 0.0000, 270.0000);
	CreateObject(3917, 1324.290527, 2133.428223, 3.568192, 0.0000, 0.0000, 270.0000);
	CreateObject(3917, 1311.237915, 2133.441895, 3.568180, 0.0000, 0.0000, 270.0000);
	CreateObject(3917, 1298.169556, 2133.442383, 3.575999, 0.0000, 0.0000, 270.0000);
	CreateObject(3915, 1306.331055, 2139.025146, 10.214546, 0.0000, 0.0000, 180.0000);
	CreateObject(3915, 1305.669189, 2180.461182, 10.251822, 0.0000, 0.0000, 180.0000);
	CreateObject(3915, 1301.370728, 2142.775146, 10.246323, 0.0000, 0.0000, 180.0000);
	CreateObject(3915, 1356.260620, 2208.066650, 10.217566, 0.0000, 0.0000, 90.0000);
	CreateObject(3915, 1397.616821, 2208.144775, 10.234627, 0.0000, 0.0000, 90.0000);
	CreateObject(18553, 1360.226685, 2192.344727, 11.315384, 0.0000, 0.0000, 270.0000);
	CreateObject(18553, 1363.993042, 2192.386230, 11.817675, 0.0000, 0.0000, 269.1406);
	CreateObject(18553, 1367.853638, 2192.401123, 11.817675, 0.0000, 0.0000, 269.1406);
	CreateObject(18553, 1371.749512, 2192.417236, 11.315384, 0.0000, 0.0000, 269.1406);
	CreateObject(18553, 1375.637451, 2192.418701, 11.817675, 0.0000, 0.0000, 269.1406);
	CreateObject(18553, 1377.774292, 2192.407715, 11.315384, 0.0000, 0.0000, 269.1406);
	CreateObject(18553, 1390.935547, 2177.283936, 11.315384, 0.0000, 0.0000, 180.0000);
	CreateObject(18553, 1390.992310, 2173.429688, 11.799865, 0.0000, 0.0000, 180.0000);
	CreateObject(18553, 1391.050781, 2169.548096, 11.817675, 0.0000, 0.0000, 180.0000);
	CreateObject(18553, 1391.061035, 2165.691406, 11.315384, 0.0000, 0.0000, 178.2812);
	CreateObject(18553, 1391.010010, 2161.809570, 11.817675, 0.0000, 0.0000, 178.2812);
	CreateObject(18553, 1390.958252, 2159.749512, 11.315384, 0.0000, 0.0000, 178.2812);
	CreateObject(3915, 1406.385986, 2155.359863, 10.238678, 0.0000, 0.0000, 0.0000);
	CreateObject(3915, 1406.347778, 2125.243652, 10.215340, 0.0000, 0.0000, 0.0000);
	CreateObject(3917, 1353.004150, 2143.817383, 3.568182, 0.0000, 0.0000, 270.0000);
	CreateObject(3917, 1339.965210, 2143.811279, 3.568185, 0.0000, 0.0000, 270.0000);
	CreateObject(3917, 1326.960571, 2143.790771, 3.568186, 0.0000, 0.0000, 270.0000);
	CreateObject(3917, 1330.618530, 2154.208008, 3.568189, 0.0000, 0.0000, 270.0000);
	CreateObject(3917, 1352.989502, 2154.223633, 3.568186, 0.0000, 0.0000, 270.0000);
	CreateObject(3917, 1343.205688, 2154.219971, 3.568185, 0.0000, 0.0000, 270.0000);
	CreateObject(3915, 1405.131226, 2159.961914, 10.259634, 0.0000, 0.0000, 0.0000);
	CreateObject(3915, 1306.640747, 2158.529053, 10.251812, 0.0000, 0.0000, 180.0000);
	CreateObject(3915, 1355.376221, 2207.078613, 10.226799, 0.0000, 0.0000, 90.0000);
	CreateObject(3917, 1351.689209, 2164.618164, 3.568186, 0.0000, 0.0000, 270.0000);
	CreateObject(3917, 1374.472046, 2160.467285, 3.568184, 0.0000, 0.0000, 180.0000);
	CreateObject(3917, 1364.061523, 2160.480469, 3.568187, 0.0000, 0.0000, 180.0000);
	CreateObject(3917, 1380.708862, 2134.976074, 3.568181, 0.0000, 0.0000, 90.0001);
	CreateObject(3917, 1360.087280, 2137.629395, 3.568186, 0.0000, 0.0000, 90.0001);
	CreateObject(3917, 1360.101074, 2148.047119, 3.568183, 0.0000, 0.0000, 90.0001);
	CreateObject(3917, 1374.768066, 2173.506104, 3.568182, 0.0000, 0.0000, 180.0000);
	CreateObject(3917, 1351.980103, 2185.395508, 3.575994, 0.0000, 0.0000, 270.0000);
	CreateObject(3917, 1351.665894, 2189.833740, 3.575998, 0.0000, 0.0000, 270.0000);
	CreateObject(3917, 1338.864624, 2189.740234, 3.593189, 0.0000, 0.0000, 270.0000);
	CreateObject(3917, 1328.149536, 2194.850586, 3.576000, 0.0000, 0.0000, 270.0000);
	return 1;
}

public OnFilterScriptExit()
{
	print("\n--------------------------------------");
	print("	  	-$- Hockey Filterscript -$-	  	   ");
	print("				  -| by |-				   ");
	print("			 -$- SpiderPork	-$-			   ");
	print("			 	  UNLOADED				   ");
	print("--------------------------------------\n");
	return 1;
}

#else

main()
{
	print("\n--------------------------------------");
	print("	  	-$- Hockey Filterscript -$-	  	   ");
	print("				  -| by |-				   ");
	print("			 -$- SpiderPork	-$-			   ");
	print("			 	   LOADED				   ");
	print("--------------------------------------\n");
}

#endif


public OnPlayerConnect(playerid)
{
	ApplyAnimation(playerid, "SKATE", "null", 0.0, 0, 0, 0, 0, 0); // Pre-loads the skate anim.
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/rpuck", cmdtext, true, 10) == 0) // Respawns the puck.
	{
		DestroyObject(Puck);
		Puck = CreateObject(1319, 1353.296509, 2149.911621, 9.537497, 0, 0, 0);
		SendClientMessageToAll(RED, "~ The puck went out of the hockey zone and has been respawned!"); // They threw the puck outta the hockey zone and has been respawned!
		return 1;
	}

	if (strcmp("/hhelp", cmdtext, true, 10) == 0) // Hockey help
	{
	    SendClientMessage(playerid, RED, "----------------------------------------------");
	    SendClientMessage(playerid, YELLOW, "SpiderPork's Hockey Filterscript");
	    SendClientMessage(playerid, YELLOW, "|- Help -|");
	    SendClientMessage(playerid, RED, "----------------------------------------------");
	    SendClientMessage(playerid, WHITE, "This filterscript has been made by SpiderPork.");
	    SendClientMessage(playerid, WHITE, "To hit the puck, go near it and press the fire button to shoot it.");
	    SendClientMessage(playerid, WHITE, "To shoot it harder, hold the fire button while near the puck.");
	    SendClientMessage(playerid, WHITE, "To lead the puck, press sprint while near it.");
	    SendClientMessage(playerid, WHITE, "If the puck gets outta the zone, type /rpuck to respawn it.");
	    SendClientMessage(playerid, RED, "----------------------------------------------");
		return 1;
	}

	if (strcmp("/hskate", cmdtext, true, 10) == 0) // The skate anim if it stops.
	{
		if(PlaysHockey[playerid] == 1)
		{
        	ApplyAnimation(playerid, "SKATE", "skate_sprint", 4.1, 1, 1, 1, 1, 1);
        }
        else if(PlaysHockey[playerid] == 0)
		{
			SendClientMessage(playerid, RED, "You have to be in a hockey match to use this skate animation. Type /hockey!");
		}
		return 1;
	}

	if (strcmp("/hockey", cmdtext, true, 10) == 0) // To join the hockey.
	{
		new rand = random(sizeof(HockeySpawns));
		SetPlayerPos(playerid, HockeySpawns[rand][0], HockeySpawns[rand][1], HockeySpawns[rand][2]);
		ApplyAnimation(playerid, "SKATE", "skate_sprint", 4.1, 1, 1, 1, 1, 1);
		GivePlayerWeapon(playerid, 2, 1);
		SendClientMessage(playerid, YELLOW, "You have joined the hockey match!");
		PlaysHockey[playerid] = 1;
		return 1;
	}

	if (strcmp("/leavehockey", cmdtext, true, 10) == 0) // To leave the hockey.
	{
	    new name[MAX_PLAYER_NAME];
	    new string[128];

	    if(PlaysHockey[playerid] == 0)
	    {
	        SendClientMessage(playerid, RED, "You're not even participating in a match, dummy!"); // The dude failed.
	        GetPlayerName(playerid, name, sizeof(name));
	        printf("%s failed", name);
		}
		else if(PlaysHockey[playerid] == 1)
		{
		    SpawnPlayer(playerid);
		    SendClientMessage(playerid, YELLOW, "You have left the hockey match!"); // The player has successfully left the hockey match.
	        format(string, sizeof(string), "~ %s has left the hockey match.", name);
		    PlaysHockey[playerid] = 0;
		    ResetPlayerWeapons(playerid);
		}
		return 1;
	}
	return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{

////////////////////////////////////////////////////////////////////////////////

    if (newkeys == KEY_FIRE) // The fire button
    {
        new Float:X, Float:Y, Float:Z, Float:X2, Float:Y2;
		GetObjectPos(Puck, X, Y, Z);
		GetXYInFrontOfPlayer(playerid, X2, Y2, 10.0);

        if(PlaysHockey[playerid] == 1 && PlayerToPoint(5.0, playerid, X, Y, Z)) // If the player is near the puck, hit.
        {
			MoveObject(Puck, X2, Y2, Z, 10);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
            ApplyAnimation(playerid, "BASEBALL", "Bat_3", 10, 0, 1, 1, 0, 0); // This animation looks like you'd hit a puck.
    		SetTimerEx("BackToSkating", 1000, 0, "i", playerid);
		}

		if(ObjectToPoint(10.0, Puck, 1352.8638, 2187.5947, 11.0234)) // The puck is in blue goal!
		{
			PuckInBlueGoal(playerid);
		}

		if(ObjectToPoint(10.0, Puck, 1352.5548, 2114.6733, 11.0156)) // The puck is in red goal!
		{
			PuckInRedGoal(playerid);
 		}
	}

////////////////////////////////////////////////////////////////////////////////

    if (newkeys == KEY_SPRINT) // The sprint button
    {
    	new Float:X, Float:Y, Float:Z, Float:X2, Float:Y2;
		GetObjectPos(Puck, X, Y, Z);
		GetXYInFrontOfPlayer(playerid, X2, Y2, 5.0);

        if(PlaysHockey[playerid] == 1 && PlayerToPoint(5.0, playerid, X, Y, Z) && HasPuck[playerid] == 0) // If the player is near the puck, attach.
        {
            AttachObjectToPlayer(Puck, playerid, 0, 3.0, -1.45, 0, 0, 0);
            HasPuck[playerid] = 1;
		}

		else if(PlaysHockey[playerid] == 1 && HasPuck[playerid] == 1)
		{
			GetXYInFrontOfPlayer(playerid, X2, Y2, 3.0);
		    GetPlayerPos(playerid, X, Y, Z);
			DestroyObject(Puck);
			Puck = CreateObject(1319, X2, Y2, Z-1.45, 0, 0, 0);
            HasPuck[playerid] = 0;
		}
    }
	return 1;
}

forward BackToSkating(playerid);
public BackToSkating(playerid)
{
	if(PlaysHockey[playerid] == 1)
	{
    ApplyAnimation(playerid, "SKATE", "skate_sprint", 4.1, 1, 1, 1, 1, 1); // Let's skate again!
    }
}

forward PuckInRedGoal(playerid);
public PuckInRedGoal(playerid)
{
	GameTextForPlayer(playerid, "~g~GOAL!", 5000, 5);
	DestroyObject(Puck);
	Puck = CreateObject(1319, 1353.296509, 2149.911621, 9.537497, 0, 0, 0);
}

forward PuckInBlueGoal(playerid);
public PuckInBlueGoal(playerid)
{
	GameTextForPlayer(playerid, "~g~GOAL!", 5000, 5);
	DestroyObject(Puck);
	Puck = CreateObject(1319, 1353.296509, 2149.911621, 9.537497, 0, 0, 0);
}

forward IsInArea();
public IsInArea()
{
    if(IsObjectInArea(Puck, 1394.741455, 1315.215942, 2196.875244, 2108.698242))
	{
	    return 1;
	}
	else
	{
	DestroyObject(Puck);
	Puck = CreateObject(1319, 1353.296509, 2149.911621, 9.537497, 0, 0, 0);
	SendClientMessageToAll(RED, "~ The puck went out of the hockey zone and has been respawned!"); // They threw the puck outta the hockey zone and has been respawned!
	}
	return 1;
}