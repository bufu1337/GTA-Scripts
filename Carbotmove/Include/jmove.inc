/*
*  (c)Copyright 2009, Jason Gregory
*   VehicleMove Functions - Botdriver 0.1
*/

/* Includes */

#include <a_samp>
#include <core>
#include <float>

/* News */

new MAX_PLAYERS;
new Float:TeleportDestveh[MAX_PLAYERS][3];

/* Forwards */

forward xMoveVehicle(carid);
forward yMoveVehicle(carid);
forward zMoveVehicle(carid);

/* Sonstiges/Misc */

native xMoveVehicle(carid);
native yMoveVehicle(carid);
native zMoveVehicle(carid);
native MoveVehicle(carid);

public xMoveVehicle(carid)
{
 new Float:x1,Float:y1,Float:z1;
 GetVehiclePos(carid, x1, y1, z1);
 {
     for(new playerid=0; playerid<MAX_PLAYERS; playerid++)
     {
        if(PlayerToPoint(2.0, playerid, TeleportDestveh[playerid][0], y1, z1))
        {
        SendClientMessageToAll(COLOR_LIGHTBLUE, "X-Position erreicht/X-Coord reached");
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

public yMoveVehicle(carid)
{
 new Float:x2,Float:y2,Float:z2;
 GetVehiclePos(carid, x2, y2, z2);
 {
     for(new playerid=0; playerid<MAX_PLAYERS; playerid++)
     {
        if(PlayerToPoint(2.0, carid, x2,TeleportDestveh[playerid][1],z2))
        {
        SendClientMessageToAll(COLOR_LIGHTBLUE, "Y-Position erreicht/Y-Coord reached");
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

public zMoveVehicle(carid)
{ 
    new Float:x3,Float:y3,Float:z3;
    GetVehiclePos(carid, x3, y3, z3);
    for(new playerid=0; playerid<MAX_PLAYERS; playerid++)
     {
       if(PlayerToPoint(2.0, carid, x3, y3, TeleportDestveh[playerid][2]))
       {
       SendClientMessageToAll(COLOR_LIGHTBLUE, "Z-Position erreicht/Z-Coord reached");
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

public MoveVehicle(carid)
{
     for(new playerid=0; playerid<MAX_PLAYERS; playerid++)
     {
       if(PlayerToPoint(2.0, carid, TeleportDestveh[playerid][0], TeleportDestveh[playerid][1], TeleportDestveh[playerid][2]))
       {
       SendClientMessageToAll(COLOR_LIGHTBLUE, "X, Y und Z-Position erreicht");
       }
          else
          {
          xMoveVehicle();
          yMoveVehicle();
          zMoveVehicle();
          }
     }
     return 1;
 }
 