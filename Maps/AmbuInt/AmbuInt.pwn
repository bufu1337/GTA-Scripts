#include <a_samp>

new InAmbu[MAX_PLAYERS];
new Watching[MAX_PLAYERS];
new Float:Pos[MAX_PLAYERS][3];
new Float:Angle[MAX_PLAYERS];
new Interior[MAX_PLAYERS];
new Goto[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("  Ambulance Interior by Cybertron Loaded!");
    CreateObject(1698, 2002.0, 2285.0, 1010.0, 0.0, 0.0, 0.0);
	CreateObject(1698, 2003.36, 2285.0, 1010.0, 0.0, 0.0, 0.0);
	CreateObject(1698, 2004.72, 2285.0, 1010.0, 0.0, 0.0, 0.0);
	CreateObject(1698, 2002.0, 2288.3, 1010.0, 0.0, 0.0, 0.0);
	CreateObject(1698, 2003.36, 2288.3, 1010.0, 0.0, 0.0, 0.0);
	CreateObject(1698, 2004.72, 2288.3, 1010.0, 0.0, 0.0, 0.0);
	CreateObject(3386, 2001.58, 2285.75, 1010.1, 0.0, 0.0, 180.0);
	CreateObject(3388, 2001.58, 2284.8, 1010.1, 0.0, 0.0, 180.0);
	CreateObject(2146, 2003.3, 2286.4, 1010.6, 0.0, 0.0, 0.0);
	CreateObject(16000, 2001.3, 2281.0, 1007.5, 0.0, 0.0, 270.0);
	CreateObject(16000, 2005.4, 2281.0, 1007.5, 0.0, 0.0, 90.0);
	CreateObject(18049, 2006.0, 2279.5, 1013.05, 0.0, 0.0, 90.0);
	CreateObject(2639, 2005.0, 2285.55, 1010.7, 0.0, 0.0, 90.0);
	CreateObject(3791, 2005.3, 2288.25, 1012.4, 270.0, 0.0, 90.0);
	CreateObject(2174, 2001.7, 2286.74, 1010.1, 0.0, 0.0, 90.0);
	CreateObject(2690, 2001.41, 2287.0, 1011.25, 0.0, 0.0, 90.0);
	CreateObject(2163, 2001.3, 2286.84, 1011.9, 0.0, 0.0, 90.0);
	CreateObject(1789, 2005.1, 2284.1, 1010.7, 0.0, 0.0, 270.0);
	CreateObject(1369, 2001.85, 2283.85, 1010.7, 0.0, 0.0, 90.0);
	CreateObject(3384, 2001.9, 2288.85, 1011.1, 0.0, 0.0, 180.0);
	CreateObject(3395, 2005.3, 2288.32, 1010.05, 0.0, 0.0, 0.0);
    CreateObject(11469, 2008.6, 2294.5, 1010.1, 0.0, 0.0, 90.0);
    CreateObject(2154, 2001.55, 2289.75, 1010.0, 0.0, 0.0, 90.0);
    CreateObject(2741, 2001.4, 2289.65, 1012.0, 0.0, 0.0, 90.0);
    CreateObject(2685, 2001.35, 2289.65, 1011.5, 0.0, 0.0, 90.0);
    CreateObject(18056, 2005.4, 2290.4, 1011.9, 0.0, 0.0, 180.0);
    CreateObject(2688, 2001.4, 2283.85, 1012.0, 0.0, 0.0, 90.0);
    CreateObject(2687, 2005.35, 2286.0, 1012.0, 0.0, 0.0, 270.0);
    CreateObject(16000, 2006.5, 2290.0, 1020.0, 0.0, 180.0, 180.0);
    CreateObject(16000, 1991.0, 2283.4, 1016.0, 0.0, 90.0, 0.0);
    CreateObject(16000, 2015.7, 2283.4, 1016.0, 0.0, 270.0, 0.0);
    CreateObject(1719, 2005.0, 2284.1, 1010.6, 0.0, 0.0, 270.0);
    CreateObject(1718, 2005.1, 2284.1, 1010.73, 0.0, 0.0, 270.0);
    CreateObject(1785, 2005.1, 2284.1, 1010.95, 0.0, 0.0, 270.0);
    CreateObject(1783, 2005.05, 2284.1, 1010.4, 0.0, 0.0, 270.0);
}

public OnFilterScriptExit()
{
	print("  Ambulance Interior Unloaded...");
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
}

public OnPlayerConnect(playerid)
{
	InAmbu[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	InAmbu[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	InAmbu[playerid] = 0;
	Watching[playerid] = 0;
	Goto[playerid] = 0;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_PASSENGER && GetVehicleModel(GetPlayerVehicleID(playerid)) == 416)
	{
     	SetPlayerPos(playerid, 2003.3, 2284.2, 1011.1);
     	SetPlayerFacingAngle(playerid, 0);
        SetCameraBehindPlayer(playerid);
        SetPlayerInterior(playerid, 1);
		InAmbu[playerid] = GetPlayerVehicleID(playerid);
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == 16 && InAmbu[playerid] > 0)
	{
		new Float:X, Float:Y, Float:Z;
		GetVehiclePos(InAmbu[playerid], X, Y, Z);
		SetPlayerPos(playerid, X+4, Y, Z);
		SetPlayerInterior(playerid, 0);
		InAmbu[playerid] = 0;
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp("/gotoambu", cmdtext, true) == 0)
	{
	    if(IsPlayerAdmin(playerid))
	    {
	        if(Goto[playerid] == 0 && InAmbu[playerid] == 0)
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
        			SendClientMessage(playerid, 0xFFFFFFAA, "SERVER: You have teleported to the ambulance, use /exitambu to exit.");
        		}
        		else return SendClientMessage(playerid, 0xFFFFFFAA, "SERVER: You are watching the ambulance, use /watchoff to stop.");
        	}
        	else return SendClientMessage(playerid, 0xFFFFFFAA, "SERVER: You are already in the ambulance.");
        }
		return 1;
	}
	
	if(strcmp("/exitambu", cmdtext, true) == 0)
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
        		else return SendClientMessage(playerid, 0xFFFFFFAA, "SERVER: You are watching the ambulance, use /watchoff to stop.");
        	}
        }
		return 1;
	}
	
	if(strcmp("/watchambu", cmdtext, true) == 0)
	{
	    if(IsPlayerAdmin(playerid))
		{
		    if(InAmbu[playerid] == 0 && Goto[playerid] == 0)
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
  	 				SendClientMessage(playerid, 0xFFFFFFAA, "SERVER: You are now watching the ambulance, use /watchoff to stop.");
  	 			}
  	 			else return SendClientMessage(playerid, 0xFFFFFFAA, "SERVER: You are already watching the ambulance, use /watchoff to stop.");
  	 		}
  	 		else return SendClientMessage(playerid, 0xFFFFFFAA, "SERVER: Exit the ambulance before watching it.");
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
			else return SendClientMessage(playerid, 0xFFFFFFAA, "SERVER: You are not watching the ambulance.");
		}
		return 1;
	}
	
	if(strcmp("/ambuhelp", cmdtext, true) == 0)
	{
	    SendClientMessage(playerid, 0xDDDD2357, "To enter the Ambulance Interior enter an ambulance (VehicleID: 416) as passenger.");
	    SendClientMessage(playerid, 0xDDDD2357, "You can lay on the stretcher using /stretcher and /stopanimation to get up.");
	    SendClientMessage(playerid, 0xDDDD2357, "To exit the ambulance press the ENTER key.");
	    SendClientMessage(playerid, 0xDDDD2357, "Or login as RCON Admin and use /gotoambu to enter and /exitambu to exit.");
	    SendClientMessage(playerid, 0xDDDD2357, "You can also watch the ambulance as RCON Admin using /watchambu and /watchoff to stop.");
	    return 1;
	}
	
	if(strcmp("/stretcher", cmdtext, true) == 0)
	{
	    if(InAmbu[playerid] > 0 || Goto[playerid] == 1)
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
	    if(InAmbu[playerid] > 0 || Goto[playerid] == 1)
	    {
			ClearAnimations(playerid);
		}
		return 1;
	}
	return 0;
}
