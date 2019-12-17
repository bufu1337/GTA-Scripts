//                      Script to pull their vehicles!
//                               By: Woozie
// You can call it: Motors, Airplanes, Boats, Monsters, Cars

#include <a_samp>

#define PURPLE 0xA600FFFF
#define RED 0xAA3333AA
#define FLAMECOLOR 0xFF6F00FF
#define BLUE 0x0050FFFF
#define GREEN 0x33AA33AA
#define YELLOW 0xFFFF00AA

public OnFilterScriptInit()
{
	print("/n -----------------------------------------------");
	print(" Script to pull the vehicle is active, By: Woozie ");
	print("----------------------------------------------- /n");
	return 1;
}

public OnFilterScriptExit()
{
	print("/n -------------------------------------------------");
	print(" Script to pull the vehicle is inactive, By: Woozie ");
	print("------------------------------------------------- /n");
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{

	if(strcmp(cmdtext, "/vehicles", true) == 0)
	{
		SendClientMessage(playerid, RED, "Bikes: /bikes" );
		SendClientMessage(playerid, RED, "AirPlanes: /planes" );
		SendClientMessage(playerid, RED, "Boats: /boats" );
		SendClientMessage(playerid, RED, "Monsters: /monsters" );
		SendClientMessage(playerid, RED, "Cars: /cars" );
		SendClientMessage(playerid, RED, "Helicopters: /heli" );
	 	return 1;
	}

    if(strcmp(cmdtext, "/bikes", true) == 0)
	{
	    SendClientMessage(playerid, PURPLE, "/nrg-500 , /faggio , /fcr-900" );
	    SendClientMessage(playerid, PURPLE, "/pcj-600 , /freeway , /bf-400 " );
	    SendClientMessage(playerid, PURPLE, "/pizzaboy , /wayfarer , /copbike" );
	    SendClientMessage(playerid, PURPLE, "/sanchez , /quad" );
	    return 1;
	}

	if(strcmp(cmdtext, "/planes", true) == 0)
	{
	    SendClientMessage(playerid, YELLOW, "/hydra , /rustler , /dodo" );
 	  	SendClientMessage(playerid, YELLOW, "/nevada , /stuntplane , /cropdust" );
 		SendClientMessage(playerid, YELLOW, "/at-400 , /andromeda , /beagle" );
	    SendClientMessage(playerid, YELLOW, "/vortex , /skimmer , /shamal" );
	    return 1;
	}
	
	if(strcmp(cmdtext, "/boats", true) == 0)
	{
	    SendClientMessage(playerid, GREEN, "/coastguard , /dinghy , /jetmax" );
	    SendClientMessage(playerid, GREEN, "/launch , /marquis , /predator" );
	    SendClientMessage(playerid, GREEN, "/reefer , /speeder , /squalo , /tropic" );
	    return 1;
	}

	if(strcmp(cmdtext, "/monsters", true) == 0)
	{
	    SendClientMessage(playerid, BLUE, "/dumper , /duneride" );
	    SendClientMessage(playerid, BLUE, "/monster , /monstera , /monsterb" );
	    return 1;
	}

	if(strcmp(cmdtext, "/cars", true) == 0)
	{
	    SendClientMessage(playerid, FLAMECOLOR, "/alpha , /banshee , /buffalo" );
	    SendClientMessage(playerid, FLAMECOLOR, "/bullet , /cheetah , /hotring" );
	    SendClientMessage(playerid, FLAMECOLOR, "/infernus , /sultan , /uranus" );
	    SendClientMessage(playerid, FLAMECOLOR, "/supergt , /turismo" );
	    return 1;
	}
	
	if(strcmp(cmdtext, "/heli", true) == 0)
	{
	    SendClientMessage(playerid, RED, "/cargobob , /hunter , /leviathn" );
	    SendClientMessage(playerid, RED, "/maverick , /polmav , /raindanc" );
	    SendClientMessage(playerid, RED, "/seasparrow , /sparrow , /vcnmav" );

	    // From there, the pull commands!!!
	
		if (strcmp("/nrg-500", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(522,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/faggio", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(462,x+1,y+1,z,a,1,1,10000);
 	  	return 1;
		}

		if (strcmp("/fcr-900", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(521,x+1,y+1,z,a,1,1,10000);
 	  	return 1;
		}
	
		if (strcmp("/pcj-600", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(461,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/freeway", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(463,x+1,y+1,z,a,1,1,10000);
   		return 1;
		}

		if (strcmp("/bf-400", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(581,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/pizzaboy", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(448,x+1,y+1,z,a,1,1,10000);
   		return 1;
		}

		if (strcmp("/wayfarer", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(586,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/copbike", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(523,x+1,y+1,z,a,1,1,10000);
   		return 1;
		}

		if (strcmp("/sanchez", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(468,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/quad", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(471,x+1,y+1,z,a,1,1,10000);
   		return 1;
		}
	
		if (strcmp("/hydra", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(520,x+1,y+1,z,a,1,1,10000);
   		return 1;
		}

		if (strcmp("/rustler", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(476,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/dodo", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(593,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/nevada", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(553,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/stuntplane", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(513,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}
	
		if (strcmp("/cropdust", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(512,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/at-400", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new	Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(577,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/andromeda", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(592,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/beagle", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(511,x+1,y+1,z,a,1,1,10000);
   		return 1;
		}

		if (strcmp("/vortex", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(539,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/skimmer", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(460,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/shamal", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(519,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/coastguard", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(472,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/dinghy", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(473,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/jetmax", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(493,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/launch", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(595,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/marquis", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(484,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/predator", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(430,x+1,y+1,z,a,1,1,10000);
   		return 1;
		}

		if (strcmp("/reefer", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(453,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/speeder", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(452,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/squalo", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(446,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/tropic", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(454,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/alpha", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(602,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/banshee", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(429,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/buffalo", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(402,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/bullet", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(541,x+1,y+1,z,a,1,1,10000);
   		return 1;
		}
	
		if (strcmp("/cheetah", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(415,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/hotring", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(494,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/infernus", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(411,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/sultan", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(560,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/uranus", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(558,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/supergt", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(506,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/turismo", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(451,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/dumper", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(406,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/duneride", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(573,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/monster", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(444,x+1,y+1,z,a,1,1,10000);
	   	return 1;
		}

		if (strcmp("/monstera", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(556,x+1,y+1,z,a,1,1,10000);
   		return 1;
		}

		if (strcmp("/monsterb", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(557,x+1,y+1,z,a,1,1,10000);
 		return 1;
		}
		
		if (strcmp("/cargobob", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(548,x+1,y+1,z,a,1,1,10000);
 		return 1;
		}
		
		if (strcmp("/hunter", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(425,x+1,y+1,z,a,1,1,10000);
 		return 1;
		}
		
		if (strcmp("/leviathn", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(417,x+1,y+1,z,a,1,1,10000);
 		return 1;
		}
		
		if (strcmp("/maverick", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(487,x+1,y+1,z,a,1,1,10000);
 		return 1;
		}
		
		if (strcmp("/polmav", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(497,x+1,y+1,z,a,1,1,10000);
 		return 1;
		}
		
		if (strcmp("/raindanc", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(563,x+1,y+1,z,a,1,1,10000);
 		return 1;
		}
		
		if (strcmp("/seasparrow", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(447,x+1,y+1,z,a,1,1,10000);
 		return 1;
		}
		
		if (strcmp("/sparrow", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(469,x+1,y+1,z,a,1,1,10000);
 		return 1;
		}
		
		if (strcmp("/vcnmav", cmdtext, true, 10) == 0)
		{
		if(IsPlayerInAnyVehicle(playerid)) return
		SendClientMessage(playerid, 0x7CFC00AA, "Successfully is called a vehicle!!!");
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		CreateVehicle(488,x+1,y+1,z,a,1,1,10000);
 		return 1;
		}
		}
	return 0;
	}
