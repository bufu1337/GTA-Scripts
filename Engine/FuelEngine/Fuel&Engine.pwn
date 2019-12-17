/*
           .::Simple Fuel Script::.
				     +
            .::Engine Starting::.
            ---------------------
            .::Coded by Homer::.
                .::2008::.
              .::PAWNTeam™::.
              
    Version V1:
Command /exit when you dont have a fuel.
If you have full vehicle, you cant refill it...
Thanks to Andre9977 for Gas Stations positions!!
	Version V2:
Fixed starting - You no more start the Bike :)

Note: In public ReFill is price for the gas, change it
	  as you need ;)
*/

#include <a_samp>

#define SCM SendClientMessage

new Menu:Gas;

new FuelTimer;
new RefillTimer;

new Vgas[MAX_VEHICLES];
new VehicleStarted[MAX_VEHICLES];

new Tankuje[MAX_PLAYERS];

forward FuelUpdate();
forward ReFill(playerid);
forward Starting(playerid);
forward IsAtGasStation(playerid);

public OnFilterScriptInit()
{
   print("-------------------------------------");
   print("-----Simple-Fuel-System-by-Homer-----");
   print("------------PAWNTeam 2008------------");
   
   FuelTimer = SetTimer("FuelUpdate",7000,1);

   new RandGas;
   RandGas = random(100);
   new Car;
   for(Car=0;Car<MAX_VEHICLES;Car++)
   {
      Vgas[Car] = RandGas;
   }
   
   Gas = CreateMenu("~g~G~w~as ~g~S~w~tation:",1,50,220,200,200);
   AddMenuItem(Gas,0,"Natural 95");
   AddMenuItem(Gas,0,"Normal 98");
   AddMenuItem(Gas,0,"Super Diesel");
   AddMenuItem(Gas,0,"Exit");
	return 1;
}

public OnFilterScriptExit()
{
   DestroyMenu(Gas);
   KillTimer(FuelTimer);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    new VID = GetPlayerVehicleID(playerid);
    new MOD = GetVehicleModel(playerid);
	if(strcmp("/gas", cmdtext, true, 10) == 0)
	{
	   if(IsAtGasStation(playerid))
	   {
		  if(IsPlayerInAnyVehicle(playerid) || MOD == 510 || MOD == 509 || MOD == 481)
		  {
			 if(Vgas[VID] < 100)
			 {
	         ShowMenuForPlayer(Gas,playerid);
		     }else{
		     SCM(playerid,0xFFFF00AA,"* Your vehicle is full!");
		     }
	      }else{
	      SCM(playerid,0xFFFF00AA,"* You are not in a vehicle / You can't fill this vehicle!");
	      }
	   }else{
       SCM(playerid,0xFFFF00AA,"* You are not at a gas station!");
	   }
		return 1;
	}
	if(strcmp("/exit", cmdtext, true, 10) == 0)
	{
	   if(IsPlayerConnected(playerid))
	   {
		  if(IsPlayerInAnyVehicle(playerid))
		  {
	      RemovePlayerFromVehicle(playerid);
	      SCM(playerid,0xFFFF00AA,"* You left the vehicle.");
	      TogglePlayerControllable(playerid,1);
	      }else{
	      SCM(playerid,0xFFFF00AA,"* You are not in a vehicle!");
	      }
	   }
		return 1;
	}
	return 0;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
new CarID = GetPlayerVehicleID(playerid);
new CarMod = GetVehicleModel(playerid);

if(newstate == PLAYER_STATE_DRIVER)
{
   if(VehicleStarted[CarID] == 0 && CarMod != 510 && CarMod != 509 && CarMod != 481)
   {
   TogglePlayerControllable(playerid,0);
   SCM(playerid,0xFFFF00AA,"* This vehicle isn't started. You can start it with key: TAB");
   }else{
   SCM(playerid,0xFFFF00AA,"* This vehicle is already started!");
   }
   if(Vgas[CarID] < 1)
   {
   SCM(playerid,0xFFFF00AA,"* No fuel in vehicle!");
   }
}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
   if(newkeys == KEY_ACTION)
   {
	  if(IsPlayerInAnyVehicle(playerid))
	  {
		 if(IsPlayerConnected(playerid))
		 {
            new Vehicle = GetPlayerVehicleID(playerid);
            if(VehicleStarted[Vehicle] == 0)
   	        {
            SCM(playerid,0xFFFF00AA,"* Starting vehicle progress...");
	        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~g~Starting vehicle...",3000,3);
	        SetTimerEx("Starting",3500,0,"i",playerid);
		    }
	      }
       }
    }
}

public OnPlayerSelectedMenuRow(playerid, row)
{
new Menu:Current = GetPlayerMenu(playerid);
   if(Current == Gas)
   {
   switch(row)
      {
      case 0:
      {
      GameTextForPlayer(playerid,"~b~Natural 95 ~n~ ~w~Refueling vehicle ~n~~g~Please wait..",4000,3);
      RefillTimer = SetTimerEx("ReFill",2000,1,"i",playerid);
      Tankuje[playerid] = 1;
	  TogglePlayerControllable(playerid,0);
      }
      case 1:
      {
      GameTextForPlayer(playerid,"~b~Natural 98 ~n~ ~w~Refueling vehicle ~n~~g~Please wait..",4000,3);
      RefillTimer = SetTimerEx("ReFill",2000,1,"i",playerid);
      Tankuje[playerid] = 1;
      TogglePlayerControllable(playerid,0);
      }
      case 2:
      {
      GameTextForPlayer(playerid,"~b~Super Diesel ~n~ ~w~Refueling vehicle ~n~~g~Please wait..",4000,3);
      RefillTimer = SetTimerEx("ReFill",2000,1,"i",playerid);
      Tankuje[playerid] = 1;
      TogglePlayerControllable(playerid,0);
      }
      case 3:
      {
      GameTextForPlayer(playerid,"~y~Have a nice day!",4000,3);
      HideMenuForPlayer(Gas,playerid);
      }
    }
  }
	return 1;
}

public FuelUpdate()
{
	new string[256];
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    new PCar = GetPlayerVehicleID(i);
		new PMod = GetVehicleModel(i);
	    if(IsPlayerInAnyVehicle(i))
	    {
			if(IsPlayerConnected(i))
			{
			   if(Tankuje[i] == 0 && VehicleStarted[PCar] == 1 && PMod != 510 && PMod != 509 && PMod != 481)
			   {
                  if(Vgas[PCar] >= 1)
			      {
			      Vgas[PCar] -= 1;
			      format(string, sizeof(string),"~n~~n~~n~~n~~n~~n~~n~~n~~n~~b~FUEL: ~w~%d%",Vgas[PCar]);
			      GameTextForPlayer(i,string,7500,3);
			      }else{
			      TogglePlayerControllable(i,0);
			      GameTextForPlayer(i,"~n~~n~~n~~n~~b~Your car is without fuel!",2500,3);
			      SCM(i,0xFFFF00AA,"[!] Your vehicle is without fuel! Use '/exit' to get out from vehicle.");
			      }
		      }
		  }
      }
   }
}

public ReFill(playerid)
{
   	new PCar = GetPlayerVehicleID(playerid);
	new string[256];
if(IsPlayerConnected(playerid))
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		if(Vgas[PCar] < 100)
		{
			if(GetPlayerMoney(playerid) >= 200)
			{
            Vgas[PCar] += 5;
            format(string, sizeof(string),"~n~~n~~n~~y~FUEL: ~w~%d%",Vgas[PCar]);
            GameTextForPlayer(playerid,string,2000,3);
            GivePlayerMoney(playerid,-200);
            }else{
            SCM(playerid,0xFFFF00AA,"* You dont have 200$ to pay!");
            TogglePlayerControllable(playerid,1);
            Tankuje[playerid] = 0;
            KillTimer(RefillTimer);
            }
        }else{
        SCM(playerid,0xFFFF00AA,"* Car successfully refilled!");
        Vgas[PCar] = 100;
        Tankuje[playerid] = 0;
        KillTimer(RefillTimer);
        TogglePlayerControllable(playerid,1);
   		}
 		}else{
      	SCM(playerid,0xFFFF00AA,"* Refueling vehicle canceled!");
     	}
    }
	return 1;
}

public Starting(playerid)
{
	new Vehicle = GetPlayerVehicleID(playerid);
	new RandomStart;
    if(IsPlayerConnected(playerid))
    {
		if(IsPlayerInAnyVehicle(playerid))
      	{
			RandomStart = random(4);
            switch(RandomStart)
            {
			   	case 0,1:
			   	{
               		VehicleStarted[Vehicle] = 1;
               		TogglePlayerControllable(playerid,1);
               		SendClientMessage(playerid,0xFFFF00AA,"* Vehicle started!");
               	}
               	case 2,3:
               	{
               		SendClientMessage(playerid,0xFFFF00AA,"* Starting vehicle failed!");
               	}
       		}
       	}
    }
    return 1;
}

public IsAtGasStation(playerid)
{
   if(IsPlayerConnected(playerid))
   {
	  if(PlayerToPoint(playerid,1595.5406, 2198.0520, 10.3863,10))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,2202.0649, 2472.6697, 10.5677,10))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,2115.1929, 919.9908, 10.5266,10))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,2640.7209, 1105.9565, 10.5274,10))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,608.5971, 1699.6238, 6.9922,10))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,618.4878, 1684.5792, 6.9922,10))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,2146.3467, 2748.2893, 10.5245,10))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,-1679.4595, 412.5129, 6.9973,10))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,-1327.5607, 2677.4316, 49.8093,10))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,-1470.0050, 1863.2375, 32.3521,10))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,-2409.2200, 976.2798, 45.2969,10))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,-2244.1396, -2560.5833, 31.9219,10))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,-1606.0544, -2714.3083, 48.5335,10))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,1937.4293, -1773.1865, 13.3828,10))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,-91.3854, -1169.9175, 2.4213,10))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,1383.4221, 462.5385, 20.1506,10))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,660.4590, -565.0394, 16.3359,10))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,1381.7206, 459.1907, 20.3452,10))
	  {
		 return 1;
	  }
	  if(PlayerToPoint(playerid,-1605.7156, -2714.4573, 48.5335,10))
	  {
		 return 1;
	  }
	  
   }
   return 0;
}

PlayerToPoint(playerid,Float:x,Float:y,Float:z,radius) // Not my script :)
{
   if(GetPlayerDistanceToPointEx(playerid,x,y,z) < radius)
   {
   return 1;
}
   return 0;
}

GetPlayerDistanceToPointEx(playerid,Float:x,Float:y,Float:z)
{
   new Float:x1,Float:y1,Float:z1;
   new Float:tmpdis;
   GetPlayerPos(playerid,x1,y1,z1);
   tmpdis = floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2)+floatpower(floatabs(floatsub(z,z1)),2));
   return floatround(tmpdis);
}
