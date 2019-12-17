#include <a_samp>

new Injourney[MAX_PLAYERS];
new Watching[MAX_PLAYERS];
new Float:Pos[MAX_PLAYERS][3];
new Float:Angle[MAX_PLAYERS];
new Interior[MAX_PLAYERS];
new Goto[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("  journey Interior Loaded!");
    CreateObject(14590, 2403.928955, -1522.458496, 902.710449, 0.0000, 0.0000, 0.0000);
    CreateObject(2395, 2404.103271, -1502.100464, 897.404907, 0.0000, 0.0000, 0.0000);
    CreateObject(2395, 2406.413818, -1502.107788, 897.395752, 0.0000, 0.0000, 0.0000);
    CreateObject(2395, 2404.086670, -1502.107788, 899.998169, 0.0000, 0.0000, 0.0000);
    CreateObject(2395, 2407.817627, -1502.090088, 899.763672, 0.0000, 0.0000, 0.0000);
    CreateObject(2395, 2403.669678, -1505.095337, 897.403809, 0.0000, 0.0000, 90.0000);
    CreateObject(2395, 2403.662598, -1505.091553, 900.102295, 0.0000, 0.0000, 90.0000);
    CreateObject(2395, 2403.692139, -1508.820557, 897.397949, 0.0000, 0.0000, 90.0000);
    CreateObject(2395, 2403.686768, -1508.811646, 900.142517, 0.0000, 0.0000, 90.0000);
    CreateObject(2395, 2403.681396, -1512.540527, 897.397949, 0.0000, 0.0000, 90.0000);
    CreateObject(2395, 2403.680664, -1512.547729, 899.800293, 0.0000, 0.0000, 90.0000);
    CreateObject(2395, 2406.858887, -1512.969116, 897.397949, 0.0000, 0.0000, 180.0000);
    CreateObject(2395, 2409.426758, -1512.954224, 897.397949, 0.0000, 0.0000, 180.0000);
    CreateObject(2395, 2406.818359, -1512.972778, 900.200684, 270.6186, 0.0000, 180.0000);
    CreateObject(2395, 2409.233887, -1512.986938, 900.192261, 270.6186, 0.0000, 180.0000);
    CreateObject(2395, 2403.661377, -1516.099243, 899.793823, 0.0000, 0.0000, 90.0000);
    CreateObject(2395, 2406.802490, -1515.186646, 900.085510, 0.0000, 0.0000, 180.0000);
    CreateObject(2395, 2410.453857, -1515.182251, 900.087158, 0.0000, 0.0000, 180.0000);
    CreateObject(2395, 2409.492432, -1513.473877, 900.048706, 0.0000, 0.0000, 270.0000);
    CreateObject(2395, 2409.534668, -1509.854004, 897.397949, 0.0000, 0.0000, 270.0000);
    CreateObject(2395, 2409.529541, -1509.842896, 899.725220, 0.0000, 0.0000, 270.0000);
    CreateObject(2395, 2409.532959, -1506.127686, 897.401123, 0.0000, 0.0000, 270.0000);
    CreateObject(2395, 2409.527344, -1502.395874, 897.401184, 0.0000, 0.0000, 270.0000);
    CreateObject(2395, 2409.543213, -1506.182373, 899.750244, 0.0000, 0.0000, 270.0000);
    CreateObject(2395, 2409.541504, -1502.506592, 899.756714, 0.0000, 0.0000, 270.0000);
    CreateObject(1498, 2403.598633, -1511.002197, 897.391785, 0.0000, 0.0000, 270.0000);
    CreateObject(14806, 2406.792480, -1502.620728, 898.446045, 0.0000, 0.0000, 0.0000);
    CreateObject(14866, 2408.280273, -1514.168091, 900.716431, 0.0000, 0.0000, 270.0000);
    CreateObject(1828, 2406.489990, -1510.053101, 897.395691, 0.0000, 0.0000, 90.0000);
    CreateObject(2013, 2409.145020, -1505.728516, 897.255493, 0.0000, 0.0000, 270.0000);
    CreateObject(2017, 2409.129883, -1507.727417, 897.247803, 0.0000, 0.0000, 270.0000);
    CreateObject(1829, 2408.765625, -1504.840942, 897.871399, 0.0000, 0.0000, 270.0000);
    CreateObject(2002, 2409.028809, -1509.443237, 897.393555, 0.0000, 0.0000, 270.0000);
    CreateObject(2147, 2408.851318, -1508.713501, 897.392517, 0.0000, 0.0000, 270.0000);
    CreateObject(2517, 2409.088867, -1511.591797, 897.390137, 0.0000, 0.0000, 180.0000);
    CreateObject(2518, 2408.308594, -1512.499146, 897.536743, 0.0000, 0.0000, 180.0000);
    CreateObject(2525, 2407.055176, -1512.467163, 897.397949, 0.0000, 0.0000, 180.0000);
    CreateObject(2842, 2408.100830, -1512.016479, 897.380493, 0.0000, 0.0000, 180.0000);
    CreateObject(2292, 2404.120361, -1504.618164, 897.403442, 0.0000, 0.0000, 360.0000);
    CreateObject(2292, 2404.128662, -1505.495361, 897.403503, 0.0000, 0.0000, 90.0000);
    CreateObject(2291, 2407.270752, -1505.468506, 897.404480, 0.0000, 0.0000, 202.5000);
    CreateObject(2204, 2403.647949, -1508.846802, 897.396973, 0.0000, 0.0000, 90.0000);
    CreateObject(2200, 2403.758057, -1510.439575, 897.397156, 0.0000, 0.0000, 90.0000);
    CreateObject(2163, 2403.592285, -1514.585083, 900.138000, 0.0000, 0.0000, 90.0000);
    CreateObject(14890, 2407.861084, -1513.970947, 900.837280, 0.0000, 0.0000, 0.0000);
    CreateObject(14666, 2405.575928, -1515.255859, 901.294250, 0.0000, 0.0000, 90.0000);
    CreateObject(18084, 2405.357178, -1503.036255, 900.217224, 0.0000, 0.0000, 180.0000);
    CreateObject(18084, 2407.910156, -1501.287842, 900.211731, 0.0000, 0.0000, 0.0000);
    CreateObject(18084, 2402.776367, -1505.572754, 900.253784, 0.0000, 0.0000, 90.0000);
}

public OnFilterScriptExit()
{
	print("  journey Interior Unloaded...");
	DestroyObject(1);
	DestroyObject(2);
	DestroyObject(3);
	DestroyObject(4);
	DestroyObject(5);
	DestroyObject(6);
	DestroyObject(7);
	DestroyObject(8);
	DestroyObject(9);
	DestroyObject(10);
	DestroyObject(11);
	DestroyObject(12);
	DestroyObject(13);
	DestroyObject(14);
	DestroyObject(15);
	DestroyObject(16);
	DestroyObject(17);
	DestroyObject(18);
	DestroyObject(19);
	DestroyObject(20);
	DestroyObject(21);
	DestroyObject(22);
	DestroyObject(23);
	DestroyObject(24);
	DestroyObject(25);
	DestroyObject(26);
	DestroyObject(27);
	DestroyObject(28);
	DestroyObject(29);
	DestroyObject(30);
	DestroyObject(31);
	DestroyObject(32);
	DestroyObject(33);
	DestroyObject(34);
	DestroyObject(35);
	DestroyObject(36);
	DestroyObject(37);
	DestroyObject(38);
	DestroyObject(39);
	DestroyObject(40);
	DestroyObject(41);
	DestroyObject(42);
	DestroyObject(43);
	DestroyObject(44);
	DestroyObject(45);
	DestroyObject(46);
	DestroyObject(47);
	DestroyObject(48);
	DestroyObject(49);
	DestroyObject(50);
	DestroyObject(51);
	DestroyObject(52);
	DestroyObject(53);
	DestroyObject(54);
	DestroyObject(56);
	DestroyObject(57);
	DestroyObject(58);
	DestroyObject(59);
	DestroyObject(60);
	DestroyObject(61);
	DestroyObject(62);




	}
public OnPlayerConnect(playerid)
{
	Injourney[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	Injourney[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	Injourney[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_PASSENGER && GetVehicleModel(GetPlayerVehicleID(playerid)) == 508)
	{
     	SetPlayerPos(playerid, 2404.993164, -1512.187500, 898.142944);
     	SetPlayerFacingAngle(playerid, 0);
        SetCameraBehindPlayer(playerid);
        SetPlayerInterior(playerid, 1);
		Injourney[playerid] = GetPlayerVehicleID(playerid);
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == 16 && Injourney[playerid] > 0)
	{
		new Float:X, Float:Y, Float:Z;
		GetVehiclePos(Injourney[playerid], X, Y, Z);
		SetPlayerPos(playerid, X+4, Y, Z);
		SetPlayerInterior(playerid, 0);
		Injourney[playerid] = 0;
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp("/gotojourney", cmdtext, true) == 0)
	{
	    if(IsPlayerAdmin(playerid))
	    {
	        if(Goto[playerid] == 0 && Injourney[playerid] == 0)
		    {
		        if(Watching[playerid] == 0)
		        {
		            GetPlayerPos(playerid, Pos[playerid][0], Pos[playerid][1], Pos[playerid][2]);
		            GetPlayerFacingAngle(playerid, Float:Angle[playerid]);
  		   			SetPlayerPos(playerid, 2003.3, 2284.2, 1011.1);
        		    SetPlayerFacingAngle(playerid, 0);
   	      			SetCameraBehindPlayer(playerid);
   	      			Interior[playerid] = GetPlayerInterior(playerid);
  		 			SetPlayerInterior(playerid, 1);
  		 			Goto[playerid] = 1;
        			SendClientMessage(playerid, 0xFFFFFFAA, "SERVER: You have teleported to the journey, use /exitjourney to exit.");
        		}
        		else return SendClientMessage(playerid, 0xFFFFFFAA, "SERVER: You are watching the journey, use /watchoff to stop.");
        	}
        	else return SendClientMessage(playerid, 0xFFFFFFAA, "SERVER: You are already in the journey.");
        }
		return 1;
	}
	
	if(strcmp("/exit", cmdtext, true) == 0)
	{
	    if(IsPlayerAdmin(playerid))
	    {
	        if(Goto[playerid] == 1)
		    {
		        if(Watching[playerid] == 0)
		        {
		            SetPlayerPos(playerid, Pos[playerid][0], Pos[playerid][1], Pos[playerid][2]);
   	      			SetCameraBehindPlayer(playerid);
   	      			SetPlayerFacingAngle(playerid, Float:Angle[playerid]);
  		 			SetPlayerInterior(playerid, Interior[playerid]);
        			Goto[playerid] = 0;
        		}
        		else return SendClientMessage(playerid, 0xFFFFFFAA, "SERVER: You are watching the journey, use /watchoff to stop.");
        	}
        }
		return 1;
	}
	
	if(strcmp("/watch", cmdtext, true) == 0)
	{
	    if(IsPlayerAdmin(playerid))
		{
		    if(Injourney[playerid] == 0 && Goto[playerid] == 0)
		    {
		        if(Watching[playerid] == 0)
		        {
		            TogglePlayerControllable(playerid, 0);
		    		GetPlayerPos(playerid, Pos[playerid][0], Pos[playerid][1], Pos[playerid][2]);
		    		GetPlayerFacingAngle(playerid, Float:Angle[playerid]);
		    		Interior[playerid] = GetPlayerInterior(playerid);
		    		SetPlayerInterior(playerid, 1);
		    		SetPlayerPos(playerid, 2005.0, 2283.7, 1020.0);
  	 				SetPlayerCameraPos(playerid, 2005.0, 2283.3, 1012.5);
  	 				SetPlayerCameraLookAt(playerid, 2003.0, 2287.0, 1010.8);
  	 				Watching[playerid] = 1;
  	 				SendClientMessage(playerid, 0xFFFFFFAA, "SERVER: You are now watching the journey, use /watchoff to stop.");
  	 			}
  	 			else return SendClientMessage(playerid, 0xFFFFFFAA, "SERVER: You are already watching the journey, use /watchoff to stop.");
  	 		}
  	 		else return SendClientMessage(playerid, 0xFFFFFFAA, "SERVER: Exit the journey before watching it.");
		}
		return 1;
	}
	
	if(strcmp("/watchoff", cmdtext, true) == 0)
	{
	    if(IsPlayerAdmin(playerid))
		{
		    if(Watching[playerid] == 1)
		    {
            	SetPlayerPos(playerid, Pos[playerid][0], Pos[playerid][1], Pos[playerid][2]);
            	SetPlayerInterior(playerid, Interior[playerid]);
				SetCameraBehindPlayer(playerid);
				SetPlayerFacingAngle(playerid, Float:Angle[playerid]);
				TogglePlayerControllable(playerid, 1);
				Watching[playerid] = 0;
			}
			else return SendClientMessage(playerid, 0xFFFFFFAA, "SERVER: You are not watching the journey.");
		}
		return 1;
	}
	
	if(strcmp("/journeyhelp", cmdtext, true) == 0)
	{
	    SendClientMessage(playerid, 0xDDDD2357, "To enter the journey Interior enter an journey (VehicleID: 416) as passenger.");
	    SendClientMessage(playerid, 0xDDDD2357, "You can lay on the stretcher using /stretcher and /stopanimation to get up.");
	    SendClientMessage(playerid, 0xDDDD2357, "To exit the journey press the ENTER key.");
	    SendClientMessage(playerid, 0xDDDD2357, "Or login as RCON Admin and use /gotojourney to enter and /exitjourney to exit.");
	    SendClientMessage(playerid, 0xDDDD2357, "You can also watch the journey as RCON Admin using /watchjourney and /watchoff to stop.");
	    return 1;
	}
	
	if(strcmp("/stretcher", cmdtext, true) == 0)
	{
	    if(Injourney[playerid] > 0 || Goto[playerid] == 1)
	    {
			SetPlayerPos(playerid, 2003.2, 2286.5, 1011.9);
    	    SetPlayerFacingAngle(playerid, 163);
    	    ClearAnimations(playerid);
    	    ApplyAnimation(playerid, "BEACH", "Lay_Bac_Loop", 4.0, 1, 0, 0, 0, 0);
		}
		return 1;
	}
	
	if(strcmp("/stopanimation", cmdtext, true) == 0)
	{
	    if(Injourney[playerid] > 0 || Goto[playerid] == 1)
	    {
			ClearAnimations(playerid);
		}
		return 1;
	}
	return 0;
}
