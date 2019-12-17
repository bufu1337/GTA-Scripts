#include <a_samp>

main()
{
	print("\n----------------------------------");
	print(" Bus-Bot Filterscript");
	print("----------------------------------\n");
}

/*
*  (c)Copyright 2009, Jason Gregory
*   VehicleMove Functions - Botdriver 0.1
*/

new Autostop;
new Float:TeleportDestveh[MAX_PLAYERS][3];
new AntiFlood[MAX_PLAYERS];
new BotCar;

#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_LIGHTBLUE 0x33CCFFAA

forward MoveVehicle(carid);
forward Autobewegung(carid);
forward xMoveVehicle(carid);
forward yMoveVehicle(carid);
forward zMoveVehicle(carid);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);

public OnFilterScriptInit()
{
	new Float: X, Float: Y, Float: Z, Float: Z_Angle;
	BotCar = AddStaticVehicle(431, X, Y, Z, Z_Angle, 0, 0);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

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

public OnPlayerConnect(playerid)
{
    SendClientMessage(playerid, COLOR_GRAD1, "Jason_Gregory´s Busdriver Bot");
    SendClientMessage(playerid, COLOR_GRAD1, "/Bothelp for Help - /Bothelp für Hilfe");
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

xMoveVehicle(carid)
{
 new Float:x1,Float:y1,Float:z1;
 GetVehiclePos(carid, x1, y1, z1);
 {
     for(new playerid=0; playerid<MAX_PLAYERS; playerid++)
     {
        if(PlayerToPoint(2.0, playerid, TeleportDestveh[playerid][0], y1, z1))
        {
        SendClientMessageToAll(COLOR_LIGHTBLUE, "X-Position erreicht/X-Coord reached");
        KillTimer(Autostop);
        }
           else if(TeleportDestveh[playerid][0] > x1)
           {
           SetVehiclePos(carid, x1+1, y1, z1);
           if(TeleportDestveh[playerid][1] > x1)
           {
           SetVehiclePos(carid, x1+1, y1, z1);
           }
           return 1;
           }
              else if(TeleportDestveh[playerid][0] < x1)
              {
              SetVehiclePos(carid, x1-1, y1, z1);
              return 1;
              }
          }
     }
 	 return 1;
  }


yMoveVehicle(carid)
{
 new Float:x2,Float:y2,Float:z2;
 GetVehiclePos(carid, x2, y2, z2);
 {
     for(new playerid=0; playerid<MAX_PLAYERS; playerid++)
     {
        if(PlayerToPoint(2.0, carid, x2,TeleportDestveh[playerid][1],z2))
        {
        SendClientMessageToAll(COLOR_LIGHTBLUE, "Y-Position erreicht/Y-Coord reached");
        KillTimer(Autostop);
        }
           else if(TeleportDestveh[playerid][1] > y2)
           {
           SetVehiclePos(carid, x2, y2+1, z2);
           }
              else if(TeleportDestveh[playerid][1] < y2)
              {
              SetVehiclePos(carid, x2, y2-1, z2);
               }
          }
     }
 	 return 1;
  }

zMoveVehicle(carid)
{
    new Float:x3,Float:y3,Float:z3;
    GetVehiclePos(carid, x3, y3, z3);
    for(new playerid=0; playerid<MAX_PLAYERS; playerid++)
     {
       if(PlayerToPoint(2.0, carid, x3, y3, TeleportDestveh[playerid][2]))
       {
       SendClientMessageToAll(COLOR_LIGHTBLUE, "Z-Position erreicht/Z-Coord reached");
       KillTimer(Autostop);
       }
          else if(TeleportDestveh[playerid][2] > z3)
          {
          SetVehiclePos(carid, x3, y3, z3+1);
          }
             else if(TeleportDestveh[playerid][2] < z3)
                 {
                 SetVehiclePos(carid, x3, y3, z3-1);
              }
          }
    return 1;
}

MoveVehicle(carid)
{
    for(new playerid=0; playerid<MAX_PLAYERS; playerid++)
    {
       if(PlayerToPoint(2.0, carid, TeleportDestveh[playerid][0], TeleportDestveh[playerid][1], TeleportDestveh[playerid][2]))
       {
       SendClientMessageToAll(COLOR_LIGHTBLUE, "Position erreicht/Complete Position reached");
       KillTimer(Autostop);
       }
          else
          {
          xMoveVehicle(carid);
          yMoveVehicle(carid);
          zMoveVehicle(carid);
          }
     }
     return 1;
}
 
public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	return 1;
}

public Autobewegung(carid)
{
	MoveVehicle(BotCar); //Remove carid and put the Vehicle Definination init / Ersetze carid und setz deine Fahrzeug Definition
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    new cmd[256];
    
    if(strcmp(cmd,"/Bothelp",true)==0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    SendClientMessage(playerid, COLOR_GRAD1, "* Botsystem Version 0.1 - Made by Jason Gregory *");
    	SendClientMessage(playerid, COLOR_GRAD1, "/Germanbothelp");
    	SendClientMessage(playerid, COLOR_GRAD1, "/Englishbothelp");
      	}
	    return 1;
	}
    if(strcmp(cmd,"/GermanBothelp",true)==0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    SendClientMessage(playerid, COLOR_GRAD1, "* Botsystem Version 0.1 - Made by Jason Gregory *");
    	SendClientMessage(playerid, COLOR_GRAD1, "/Botstart -> Um den Fahrzeug Bot zu starten");
    	SendClientMessage(playerid, COLOR_GRAD1, "/Botstop -> Um den Fahrzeug Bot zu stoppen");
    	SendClientMessage(playerid, COLOR_GRAD1, "/Vehmark -> Um einen Position zum Markieren");
    	SendClientMessage(playerid, COLOR_GRAD1, "/Speed 1 -> Langsame Fahrzeuggeschwindigkeit");
    	SendClientMessage(playerid, COLOR_GRAD1, "/Speed 2 -> Normale Fahrzeuggeschwindigkeit");
    	SendClientMessage(playerid, COLOR_GRAD1, "/Speed 3 -> Hohe Fahrzeuggeschwindigkeit");
      	}
	    return 1;
	}
	if(strcmp(cmd,"/EnglishBothelp",true)==0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	    SendClientMessage(playerid, COLOR_GRAD1, "* Botsystem Version 0.1 - Made by Jason Gregory *");
    	SendClientMessage(playerid, COLOR_GRAD1, "/Botstart -> To Start the Bot Vehicle");
    	SendClientMessage(playerid, COLOR_GRAD1, "/Botstop -> To Stop the Bot Vehicle");
    	SendClientMessage(playerid, COLOR_GRAD1, "/Vehmark -> To Mark a Position for the Bot Vehicle");
    	SendClientMessage(playerid, COLOR_GRAD1, "/Speed 1 -> Slow Speed");
    	SendClientMessage(playerid, COLOR_GRAD1, "/Speed 2 -> Normal Speed");
    	SendClientMessage(playerid, COLOR_GRAD1, "/Speed 3 -> High Speed");
      	}
	    return 1;
	}
	if(strcmp(cmd,"/Botstart",true)==0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(AntiFlood[playerid] == 0)
			{
            	Autostop = SetTimer("Autobewegung", 250, 1);
            	AntiFlood[playerid] = 1;
           	}
      	}
	    return 1;
	}
    if(strcmp(cmd,"/Botstop",true)==0)
	{
	    if(IsPlayerConnected(playerid))
	    {
    	KillTimer(Autostop);
    	AntiFlood[playerid] = 0;
    	}
	    return 1;
	}
	if(strcmp(cmd, "/vehmark", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
            if(IsPlayerAdmin(playerid))
			{
				GetPlayerPos(playerid, TeleportDestveh[playerid][0],TeleportDestveh[playerid][1],TeleportDestveh[playerid][2]);
				SendClientMessage(playerid, COLOR_GRAD1, "   Teleporter Station gesetzt");
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   INFO: Das ist ein Adminbefehl, du bist kein Admin!");
			}
		}
		return 1;
	}
	if(strcmp(cmd,"/Speed1",true)==0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		     KillTimer(Autostop);
           	 Autostop = SetTimer("Autostop", 250, 1); //Dont worry it can take 250 ;)
            }
	    return 1;
	}
    if(strcmp(cmd,"/Speed2",true)==0)
	{
	    if(IsPlayerConnected(playerid))
	    {
            KillTimer(Autostop);
        	Autostop = SetTimer("Autostop", 150, 1);
            }
 	    return 1;
	}
    if(strcmp(cmd,"/Speed3",true)==0)
	{
	    if(IsPlayerConnected(playerid))
	    {
             KillTimer(Autostop);
        	 Autostop = SetTimer("Autostop", 50, 1); //If u want it faster just edit it
            }
 	    return 1;
	}
	return 0;
}

public OnPlayerInfoChange(playerid)
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(BotCar)
	{
	   SendClientMessage(playerid, COLOR_GRAD1, "/Bothelp for Help - /Bothelp für Hilfe");
	   return 0;
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

