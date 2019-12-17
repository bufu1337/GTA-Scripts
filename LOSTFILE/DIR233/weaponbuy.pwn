#include <a_samp>


public OnFilterScriptInit() {
	print("\n----------------------------------");
	print("Filterscript by >RCR<Mate v1.2 on");
	print("----------------------------------\n");
}

public OnFilterScriptExit() {
	print("\n----------------------------------");
	print("Filterscript by >RCR<Mate v1.2 off");
	print("----------------------------------\n");
}





public OnPlayerConnect(playerid)

//HUN
SendClientMessage(playerid, 0xB8860BAA, "Multiscript by >RCR<Mate type /multi for help!");


public OnPlayerSpawn(playerid)

GameTextForPlayer(playerid, "~y~M~g~u~b~l~w~t~g~i ~p~b~y~y ~r~>RCR<Mate",8000,5);


public OnPlayerExitVehicle(playerid, vehicleid)
{
	

	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(i != playerid)
		{
			SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
		}
	}


	return 1;
}


public OnPlayerDeath(playerid, killerid, reason){
  if(IsPlayerInAnyVehicle(killerid)) Kick(killerid);
    return 1;
}


public OnPlayerCommandText(playerid, cmdtext[]) {

new money;
money = GetPlayerMoney(playerid);

//car locking code (c) Mate
	if (strcmp(cmdtext, "/lock", true)==0)
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new State=GetPlayerState(playerid);
				if(State!=PLAYER_STATE_DRIVER)
				{
					SendClientMessage(playerid,0xFFFF00AA,"You can't lock it!.");
					return 1;
				}
				new i;
				for(i=0;i<MAX_PLAYERS;i++)
				{
					if(i != playerid)
					{
						SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 1);
					}
				}
				SendClientMessage(playerid, 0xFFFF00AA, "Vehicle locked!");
		    	new Float:pX, Float:pY, Float:pZ;
				GetPlayerPos(playerid,pX,pY,pZ);
				PlayerPlaySound(playerid,1056,pX,pY,pZ);
                GameTextForPlayer(playerid, "~g~locked!",8000,5);
			}
			else
			{
				SendClientMessage(playerid, 0xFFFF00AA, "You are not in a car!");
			}
		return 1;
		}


if (strcmp(cmdtext, "/unlock", true)==0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new State=GetPlayerState(playerid);
			if(State!=PLAYER_STATE_DRIVER)
			{
				SendClientMessage(playerid,0xFFFF00AA,"You can't open it.");
				return 1;
			}
			new i;
			for(i=0;i<MAX_PLAYERS;i++)
			{
				SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
			}
			SendClientMessage(playerid, 0xFFFF00AA, "Vehicle open!");
			new Float:pX, Float:pY, Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			PlayerPlaySound(playerid,1057,pX,pY,pZ);
            GameTextForPlayer(playerid, "~r~open!",8000,5);
		}
		else
		{
			SendClientMessage(playerid, 0xFFFF00AA, "You are not in a car!");
		}
	return 1;

}


if(strcmp(cmdtext, "/tele-ls", true) == 0) {
				if(IsPlayerInAnyVehicle(playerid)) {
				        new Float:X;
					new Float:Y;
					new Float:Z;
				        new VehicleID;
				        GetPlayerPos(playerid, X, Y, Z);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,2779.6001,-2010.7078,13.5547);
				} else {
					new Float:X;
					new Float:Y;
					new Float:Z;
					GetPlayerPos(playerid, X, Y, Z);
					SetPlayerPos(playerid,2779.6001,-2010.7078,13.5547);
                    GameTextForPlayer(playerid, "~r~you have teleported to ls!",8000,5);
  				}
			return 1;
		}
		
		
		if(strcmp(cmdtext, "/tele-sf", true) == 0) {
				if(IsPlayerInAnyVehicle(playerid)) {
				        new Float:X;
					new Float:Y;
					new Float:Z;
				        new VehicleID;
				        GetPlayerPos(playerid, X, Y, Z);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,-1916.0455,293.3197,41.0469);
				} else {
					new Float:X;
					new Float:Y;
					new Float:Z;
					GetPlayerPos(playerid, X, Y, Z);
					SetPlayerPos(playerid,-1916.0455,293.3197,41.0469);
                    GameTextForPlayer(playerid, "~r~you have teleported to sf!",8000,5);
  				}
			return 1;
		}
		
		if(strcmp(cmdtext, "/tele-lv", true) == 0) {
				if(IsPlayerInAnyVehicle(playerid)) {
				        new Float:X;
					new Float:Y;
					new Float:Z;
				        new VehicleID;
				        GetPlayerPos(playerid, X, Y, Z);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID,2320.2126,1390.6610,42.9666);
				} else {
					new Float:X;
					new Float:Y;
					new Float:Z;
					GetPlayerPos(playerid, X, Y, Z);
					SetPlayerPos(playerid,2320.2126,1390.6610,42.9666);
                    GameTextForPlayer(playerid, "~r~you have teleported to lv!",8000,5);
  				}
			return 1;
		}


		if(strcmp(cmdtext, "/dive", true) == 0) {
				if(IsPlayerInAnyVehicle(playerid)) {
				        new Float:X;
					new Float:Y;
					new Float:Z;
				        new VehicleID;
				        GetPlayerPos(playerid, X, Y, Z);
				        VehicleID = GetPlayerVehicleID(playerid);
					SetVehiclePos(VehicleID, X, Y, Z + 800.00);
					
					GivePlayerWeapon(playerid,46,1);
				} else {
					new Float:X;
					new Float:Y;
					new Float:Z;
					GetPlayerPos(playerid, X, Y, Z);
					SetPlayerPos(playerid, X, Y, Z + 800.00);
					
					GivePlayerWeapon(playerid,46,1);
					GameTextForPlayer(playerid, "~y~dont forget the parachute!",8000,5);
  				}
			return 1;
		}


if (strcmp(cmdtext, "/multi", true)==0) {
		
		SendClientMessage(playerid, 0x32CD32AA,"Type: /buyweapon for the weapon list");
        SendClientMessage(playerid, 0x32CD32AA,"Type: /tele-ls Los Santos teleport");
        SendClientMessage(playerid, 0x32CD32AA,"Type: /tele-lv Las Venturas teleport");
        SendClientMessage(playerid, 0x32CD32AA,"Type: /tele-sf San Fierro teleport");
        SendClientMessage(playerid, 0x32CD32AA,"Type: /dive for dive from the sky");
        SendClientMessage(playerid, 0x32CD32AA,"Type: /lock to lock you car");
        SendClientMessage(playerid, 0x32CD32AA,"Type: /unlock to open your car");
        SendClientMessage(playerid, 0x32CD32AA,"Type: /szinek for the colours");
        SendClientMessage(playerid, 0x32CD32AA,"Type: /infok for some info");
        SendClientMessage(playerid, 0x7CFC00AA,"ANTI-Driveby script loaded!");
        GameTextForPlayer(playerid, "~r~Multi!!!",8000,5);

			return 1;
			}
if (strcmp(cmdtext, "/szinek", true)==0) {

SendClientMessage(playerid, 0x2E8B57AA,"#define COLOR_GREY 0xAFAFAFAA");
SendClientMessage(playerid, 0x2E8B57AA,"#define COLOR_GREEN 0x33AA33AA");
SendClientMessage(playerid, 0x2E8B57AA,"#define COLOR_RED 0xAA3333AA");
SendClientMessage(playerid, 0x2E8B57AA,"#define COLOR_YELLOW 0xFFFF00AA");
SendClientMessage(playerid, 0x2E8B57AA,"#define COLOR_WHITE 0xFFFFFFAA");
SendClientMessage(playerid, 0x2E8B57AA,"#define COLOR_BLUE 0x0000BBAA");
SendClientMessage(playerid, 0x2E8B57AA,"#define COLOR_LIGHTBLUE 0x33CCFFAA");
SendClientMessage(playerid, 0x2E8B57AA,"#define COLOR_ORANGE 0xFF9900AA");
SendClientMessage(playerid, 0x2E8B57AA,"#define COLOR_RED 0xAA3333AA");

           return 1;
			}

 if(strcmp(cmdtext, "/infok", true) == 0) {

SendClientMessage(playerid, 0x191970AA,"------------------");
SendClientMessage(playerid, 0x10F441AA,"Multiscript's creator:>RCR<Mate>V<");
SendClientMessage(playerid, 0x10F441AA,"Helped:[Six]raffA");
SendClientMessage(playerid, 0x10F441AA,"Mutliscript 1.2v");
SendClientMessage(playerid, 0x191970AA,"------------------");

           return 1;
			}

//Buy weapon codes (c) Mate
if (strcmp(cmdtext, "/buyweapon", true)==0) {
        SendClientMessage(playerid, 0x32CD32AA,"Buy Tec9-t: /buytec9   700$");
        SendClientMessage(playerid, 0x32CD32AA,"Buy Uzi-t: /buyuzi    500$");
        SendClientMessage(playerid, 0x32CD32AA,"Buy Shotgun-t: /buyshotgun   600$");
        SendClientMessage(playerid, 0x32CD32AA,"Buy Mp5-t: /buymp5    2000$");
        SendClientMessage(playerid, 0x32CD32AA,"Buy Ak47-t: /buyak47      3500$");
        SendClientMessage(playerid, 0x32CD32AA,"Buy Combatshogun-t: /buycombat   2000$") ;
        SendClientMessage(playerid, 0x32CD32AA,"Buy Chainsaw: /buychain    7000$") ;
        SendClientMessage(playerid, 0x32CD32AA,"Buy Dildo: /buydildo    200$") ;
        SendClientMessage(playerid, 0x32CD32AA,"Buy Graffiti: /buyspray    300$") ;
}


     if (strcmp(cmdtext, "/buytec9", true)==0) {
	 if (money < 700)
	 {
	 SendClientMessage(playerid, 0x32CD32AA, "GET 700$!");
	 }
	 else
	 {
	 GivePlayerWeapon(playerid, 32, 200);
     GivePlayerMoney(playerid, -700);
     SendClientMessage(playerid, 0xAA3333AA,"You have buy some tec9!");
     }
  }

     
     
     if (strcmp(cmdtext, "/buyuzi", true)==0) {
     if (money < 500)
	 {
	 SendClientMessage(playerid, 0x32CD32AA, "GET 500$-t!");
	 }
	 else
	 {
	 GivePlayerWeapon(playerid, 28, 200);
     GivePlayerMoney(playerid, -500);
     SendClientMessage(playerid, 0xAA3333AA,"You have buy some uzi!");
     }
  }

     if (strcmp(cmdtext, "/buycombat", true)==0) {
     if (money < 2000)
	 {
	 SendClientMessage(playerid, 0x32CD32AA, "GET 2000$-t!");
	 }
	 else
	 {
	 GivePlayerWeapon(playerid, 27, 40);
     GivePlayerMoney(playerid, -2000);
     SendClientMessage(playerid, 0xAA3333AA,"You have buy some combatshotgun!");
     }
  }
     
          if (strcmp(cmdtext, "/buyshotgun", true)==0) {
          if (money < 600)
	 {
	 SendClientMessage(playerid, 0x32CD32AA, "GET 600$-t!");
	 }
	 else
	 {
	 GivePlayerWeapon(playerid, 25, 50);
     GivePlayerMoney(playerid, -600);
     SendClientMessage(playerid, 0xAA3333AA,"You have buy some shotgun!");
     }
 }

     
     
               if (strcmp(cmdtext, "/buymp5", true)==0) {
               if (money < 2000)
	 {
	 SendClientMessage(playerid, 0x32CD32AA, "GET 2000$-t!");
	 }
	 else
	 {
	 GivePlayerWeapon(playerid, 29, 500);
     GivePlayerMoney(playerid, -2000);
     SendClientMessage(playerid, 0xAA3333AA,"You have buy some mp5!");
     }
  }

     
     
     if (strcmp(cmdtext, "/buyak47", true)==0) {
     if (money < 3500)
	 {
	 SendClientMessage(playerid, 0x32CD32AA, "GET 3500$-t!");
	 }
	 else
	 {
	 GivePlayerWeapon(playerid, 30, 300);
     GivePlayerMoney(playerid, -3500);
     SendClientMessage(playerid, 0xAA3333AA,"You have buy some ak47!");
     }
   }


     if (strcmp(cmdtext, "/buyminigun", true)==0) {
     if (money < 3000000)
	 {
	 SendClientMessage(playerid, 0x32CD32AA, "GET 3000000$-t!");
	 }
	 else
	 {
	 GivePlayerWeapon(playerid, 38, 145);
     GivePlayerMoney(playerid, -3000000);
     SendClientMessage(playerid, 0xAA3333AA,"You have buy some minigun!");
     }
   }

     if (strcmp(cmdtext, "/buychain", true)==0) {
     if (money < 7000)
	 {
	 SendClientMessage(playerid, 0x32CD32AA, "GET 7000$-t!");
	 }
	 else
	 {
	 GivePlayerWeapon(playerid, 9, 10);
     GivePlayerMoney(playerid, -7000);
     SendClientMessage(playerid, 0xAA3333AA,"You have buy some chainsaw!");
     }
  }
      if (strcmp(cmdtext, "/buydildo", true)==0) {
      if (money < 200)
	 {
	 SendClientMessage(playerid, 0x32CD32AA, "GET 200$-t!");
	 }
	 else
	 {
	 GivePlayerWeapon(playerid, 10, 10);
     GivePlayerMoney(playerid, -200);
     SendClientMessage(playerid, 0xAA3333AA,"You have buy some dildo!");
     }
  }

     if (strcmp(cmdtext, "/buyspray", true)==0) {
     if (money < 300)
	 {
	 SendClientMessage(playerid, 0x32CD32AA, "GET 300$-t!");
	 }
	 else
	 {
	 GivePlayerWeapon(playerid, 41, 300);
     GivePlayerMoney(playerid, -300);
     SendClientMessage(playerid, 0xAA3333AA,"You have buy some graffiti!");
     }
  }


if (strcmp(cmdtext, "/multi", true) == 0) {
		SendClientMessage(playerid, 0xFFFF00AA,"Multifunction filterscript help");
		SendClientMessage(playerid, 0xFFFF00AA,"Type: /dive for dive from the sky");
        SendClientMessage(playerid, 0xFFFF00AA,"Type: /lock to lock your car");
        SendClientMessage(playerid, 0xFFFF00AA,"Type: /unlock to unlock your car");
        SendClientMessage(playerid, 0xFFFF00AA,"Type: /tele-ls Los Santos teleport");
        SendClientMessage(playerid, 0xFFFF00AA,"Type: /tele-lv Las Venturas teleport");
		SendClientMessage(playerid, 0xFFFF00AA,"Type: /tele-sf San Fierro teleport");
        SendClientMessage(playerid, 0xFFFF00AA,"Type: /buyweapon to the weaponlist");
        GameTextForPlayer(playerid, "~g~Multi!!!",8000,5);
}
return 0;
}

















		
		
		

		
