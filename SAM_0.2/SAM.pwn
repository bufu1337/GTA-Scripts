/*   sam site for eASTERN bASIN HELP WITH IT IN TESTING
« on: June 20, 2008, 01:50:54 PM » Quote Modify Remove Split Topic */

//--------------------------------------------------------------------------------




//                             //
//       SAM Guard 1.0         //
//       -------------         //
//    Surface to Air Missile2  //
//       By LucifeR AND Robert //
//  Lucifer@vgames.co.il   Robert_dog_karate@yahoo.com    //


#include <a_samp>


#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA


#define MAX_SAM 3
new SAM[MAX_PLAYERS][MAX_SAM];
new SAM_T[MAX_PLAYERS][MAX_SAM];
new SAM_M[MAX_PLAYERS];
new SAM_I[MAX_PLAYERS];
new SAM_re[MAX_PLAYERS];
new SAM_timervar;

forward SAM_timer();
forward SAM_lunch(playerid);
forward SAM_go(playerid, num);
forward SAM_relunch(playerid);

public OnFilterScriptInit()
{
   printf("  _                                _ ");
   printf(" ( )     _   _  ____  _  ___  ____| \\_ ");
   printf(" | |    | | | |/ ___|(_)/ __|/ __ | \\ \\ ");
   printf(" | |    | | | | |    | | |_ / / /_/ / / ");
   printf(" | |____| |_| | |___ | |  _| |___ | | \\ ");
   printf(" |______\\_____/\\____||_|_|  \\____|| |\\ \\ ");
   printf("                 SAM guard");

   SAM_timervar = SetTimer("SAM_timer", 500, 1);
   return 1;
}

public OnFilterScriptExit()
{
   return 1;
}

public OnPlayerConnect(playerid)
{
    SAM_setup(playerid);
   	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
   return 1;
}

public OnPlayerSpawn(playerid)
{
    SAM_setup(playerid);
	return 1;
}

public OnPlayerDeath(playerid)
{
	SAM_setup(playerid);
   	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
   if((strcmp(cmdtext, "/sam on", true) == 0) && IsPlayerAdmin(playerid))
   {
      new tmpstr[256], playername[256];
      GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
      
      SAM_timervar = SetTimer("SAM_timer", 599999, 1);
      format(tmpstr, 256, " ***** SAM system activated by %s!", playername);
      for(new i=0; i <= MAX_PLAYERS; i++)
      {
         SendClientMessage(i, COLOR_RED, tmpstr);
      }
      
      return 1;
   }
   if((strcmp(cmdtext, "/sam off", true) == 0) && IsPlayerAdmin(playerid))
   {
      new tmpstr[256], playername[256];
      GetPlayerName(playerid, playername, MAX_PLAYER_NAME);

      KillTimer(SAM_timervar);
      format(tmpstr, 256, " ****** SAM system has been disabled by %s!", playername);
      for(new i=0; i <= MAX_PLAYERS; i++)
      {
         SendClientMessage(i, COLOR_GREEN, tmpstr);
      }
      
      return 1;
   }
   if((strcmp(cmdtext, "/sam", true) == 0) && IsPlayerAdmin(playerid))
   {
      SendClientMessage(playerid, 0xFFFFFFFF, "usage: /sam [on/off]");
      return 1;
   }
   return 0;
}

new Float:EASTERN_BASIN_NAVAL_AREA [4] = {-1394.30,493.61,21.00};
public SAM_timer()
{
for(new playerid=0; playerid <= MAX_PLAYERS; playerid++)
if(SAM_M[playerid] == 0 && IsPlayerConnected(playerid) && isPlayerInArea(playerid, EASTERN_BASIN_NAVAL_AREA) && IsPlayerInAnyVehicle(playerid))
{
    if(SAM_M[playerid] == 0)
    {
         if(IsPlayerAdmin(playerid) == 0)
         {
        	SAM_M[playerid] = 1;
			SAM_lunch(playerid);
   		}
    }
}
}


SAM_setup(playerid)
{
	SAM_re[playerid] = 0;
   	SAM_M[playerid] = 0;
   	for(new i=(MAX_SAM-1); i <= 0; i++)
   	{
      if(SAM[playerid][0] != 0 && IsValidObject(SAM[playerid][0])) { DestroyObject(SAM[playerid][0]); }
      SAM[playerid][0] = 0;
      SAM_T[playerid][0] = 0;
   	}
}


public SAM_lunch(playerid)
{
   if(SAM_M[playerid] == 1 && !(SAM[playerid][0] > 0))
   {
      SAM[playerid][0] = CreateObject(3790,-1394.30,493.61,21.00, -180,55,-169);//I THOUGHT THIS IS WHERE THE PLAYER IS IN AREA HAS HAPPEND
      SAM_T[playerid][0] =SetTimerEx("SAM_go", 500, 1, "d d", playerid, 0);
      CreateExplosion(-1394.30,493.61,21.00, 4, 1);
   }
}

public SAM_go(playerid, num)
{
   new Float:ox,Float:oy,Float:oz;

   GetObjectPos(SAM[playerid][num], ox, oy, oz);

   if(isPlayerNearPos(playerid, ox, oy, oz, 1))
   {
      KillTimer(SAM_T[playerid][num]);
      CreateExplosion(ox, oy, oz, 7, 2);
      CreateExplosion(ox, oy, oz, 7, 2);
      DestroyObject(SAM[playerid][num]);
      SAM[playerid][num] = 0;
      RemovePlayerMapIcon(playerid, SAM_I[playerid]);
      SetTimerEx("SAM_relunch", 3000, 0, "d", playerid);
      SAM_re[playerid] = 1;
      if(!IsPlayerConnected(playerid))
      {
 		KillTimer(SAM_T[playerid][num]);
   		DestroyObject(SAM[playerid][num]);
     	SAM[playerid][num] = 0;
      	RemovePlayerMapIcon(playerid, SAM_I[playerid]);
       	SAM_re[playerid] = 0;
      }
   }
   else
    {
       	new Float:px,Float:py,Float:pz;
       	GetPlayerPos(playerid, px, py, pz);
   		MoveObject(SAM[playerid][num], px, py, pz, 60);
      	SetObjectToFaceCords(SAM[playerid][num], px, py, pz);
      	SAM_M[playerid]-=1;
      	PlayerPlaySound(playerid, 1057, px, py, pz);
      	RemovePlayerMapIcon(playerid, SAM_I[playerid]);
      	SetPlayerMapIcon(playerid, SAM_I[playerid], ox, oy, oz, 0, COLOR_RED);

      	if(!IsPlayerConnected(playerid))
      	{
      	KillTimer(SAM_T[playerid][num]);
       	DestroyObject(SAM[playerid][num]);
       	SAM[playerid][num] = 0;
        RemovePlayerMapIcon(playerid, SAM_I[playerid]);
        SAM_re[playerid] = 0;
      }
   }
}

public SAM_relunch(playerid)
{
   	new Float:h;
   	GetPlayerHealth(playerid, h);
   	if(h > 0 && SAM_re[playerid] == 1)
   	SAM_lunch(playerid);
	SAM_re[playerid] = 0;
}

SetObjectToFaceCords(objectid, Float:x1,Float:y1,Float:z1)
{
   //   SetObjectToFaceCords() By LucifeR   //
   //                LucifeR@vgames.co.il   //

   // setting the objects cords
   new Float:x2,Float:y2,Float:z2;
   GetObjectPos(objectid, x2,y2,z2);

   // setting the distance values
   new Float:DX = floatabs(x2-x1);
   new Float:DY = floatabs(y2-y1);
   new Float:DZ = floatabs(z2-z1);

   // defining the angles and setting them to 0
   new Float:yaw = 0;
   new Float:pitch = 0;

    // check that there isnt any 0 in one of the distances,
   // if there is any  use the given parameters:
   if(DY == 0 || DX == 0)
   {
	  if(DY == 0 && DX > 0) {
         yaw = 0;
         pitch = 0; }
      else if(DY == 0 && DX < 0) {
         yaw = 180;
         pitch = 180; }
      else if(DY > 0 && DX == 0)  {
         yaw = 90;
         pitch = 90; }
      else if(DY < 0 && DX == 0) {
         yaw = 270;
         pitch = 270; }
      else if(DY == 0 && DX == 0) {
         yaw = 0;
         pitch = 0; }
   }

   // calculating the angale using atan
   else // non of the distances is 0.
   {
       // calculatin the angles
      yaw = atan(DX/DY);
      pitch = atan(floatsqroot(DX*DX + DZ*DZ) / DY);

      // there are three quarters in a circle, now i will
      // check wich circle this is and change the angles
      // according to it.
      if(x1 > x2 && y1 <= y2) {
      	 yaw = yaw + 90;
         pitch = pitch - 45; }
        else if(x1 <= x2 && y1 < y2) {
          yaw = 90 - yaw;
       	  pitch = pitch - 45; }
        else if(x1 < x2 && y1 >= y2) {
          yaw = yaw - 90;
          pitch = pitch - 45; }
        else if(x1 >= x2 && y1 > y2) {
          yaw = 270 - yaw;
          pitch = pitch + 315; }

      // the pitch could be only in two quarters, lets see wich one:
      if(z1 < z2)
        pitch = 360-pitch;
   }

   // setting the object rotation (should be twice cuz of lame GTA rotation system)
   SetObjectRot(objectid, 0, 0, yaw);
   SetObjectRot(objectid, 0, pitch, yaw);
}

isPlayerNearPos(playerID, Float:x, Float:y, Float:z, c)
{
   new Float:PX, Float:PY, Float:PZ;

   GetPlayerPos(playerID, PX, PY, PZ);
   if((x-c < PX) && (x+c > PX) && (y-c < PY) && (y+c > PY) && (z-c < PZ) && (z+c > PZ))
   {
      return 1;
   }
   return 0;
}

isPlayerInArea(playerID, Float:data[4])
{
   new Float:X, Float:Y, Float:Z;

   GetPlayerPos(playerID, X, Y, Z);
   if(X >= data[0] && X <= data[2] && Y >= data[1] && Y <= data[3]) {
      return 1;
   }
   return 0;
}
