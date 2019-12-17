#include <a_samp>

new LewoPrawo[200];
new GoraDol[200];
new Float:nx[200];
new Float:ny[200];
new Float:nz[200];
new Float:sx[200];
new Float:sy[200];
new Float:sz[200];
new Float:NHP[200];
new Float:SHP[200];
new Float:RHP[200];
new Float:NARM[200];
new Float:SARM[200];
new Float:RARM[200];
new bool:Ochrona[200];
new OchronaT[200];
new zal;

public OnFilterScriptInit()
{
	SetTimer("HeadShot", 100, 1);
	print("\n----------------------------------");
	print("   HeadShot Mode by DDaG            ");
	print("--------------Loaded--------------\n");
	return 1;
}

public OnPlayerSpawn(playerid)
{
	Ochrona[playerid] = true;
	OchronaT[playerid] = SetTimerEx("OchronaOff", 500, 0, "d", playerid);
	return 1;
}

forward HeadShot();
public HeadShot()
{
	for(new i; i<=200; i++)
	{
	    if(IsPlayerConnected(i) && GetPlayerState(i) != PLAYER_STATE_NONE)
	    {
	        if(!IsPlayerInAnyVehicle(i))
	        {
	        	GetPlayerKeys(i, zal, GoraDol[i], LewoPrawo[i]);
	        	GetPlayerPos(i, nx[i], ny[i], nz[i]);
	        	GetPlayerHealth(i, NHP[i]);
	        	RHP[i] = NHP[i] - SHP[i];
	        	GetPlayerArmour(i, NARM[i]);
	        	RARM[i] = NARM[i] - SARM[i];
	        	if(nx[i] != sx[i] && ny[i] != sy[i] && nz[i] == sz[i] && LewoPrawo[i] == 0 && GoraDol[i] == 0 && (RHP[i] <= -20) || (RARM[i] <= -20) && Ochrona[i] == false)
	        	{
	            	SetPlayerHealth(i, 0);
	            	GameTextForAll("~b~KillaH ~r~Head ~g~Shot!", 2000, 5);
	        	}
	        	GetPlayerPos(i, sx[i], sy[i], sz[i]);
	        	GetPlayerHealth(i, SHP[i]);
				GetPlayerArmour(i, SARM[i]);
	        }
	        else if(IsPlayerInAnyVehicle(i) && !IsPlayerOnBike(i) && !IsPlayerInBoat(i) && !IsPlayerOnBicycle(i))
	        {
	        	GetPlayerHealth(i, NHP[i]);
	        	GetPlayerArmour(i, NARM[i]);
	        	if((NHP[i] < SHP[i]) || (NARM[i] < SARM[i]) && Ochrona[i] == false)
	        	{
	                SetPlayerHealth(i, 0);
	            	GameTextForAll("~b~KillaH ~r~Head ~g~Shot!", 2000, 5);
	        	}
	            GetPlayerHealth(i, SHP[i]);
	            GetPlayerArmour(i, SARM[i]);
	        }
		}
	}
}

forward OchronaOff(playerid);
public OchronaOff(playerid)
{
	Ochrona[playerid] = false;
	KillTimer(OchronaT[playerid]);
	return 1;
}

IsPlayerOnBike(playerid)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 448:return 1;
   case 461:return 1;
   case 462:return 1;
   case 463:return 1;
   case 468:return 1;
   case 521:return 1;
   case 522:return 1;
   case 523:return 1;
   case 581:return 1;
   case 586:return 1;
   case 471:return 1;
  }
 }
 return 0;
}

IsPlayerInBoat(playerid)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 430:return 1;
   case 446:return 1;
   case 452:return 1;
   case 453:return 1;
   case 454:return 1;
   case 472:return 1;
   case 473:return 1;
   case 484:return 1;
   case 493:return 1;
   case 595:return 1;
  }
 }
 return 0;
}

IsPlayerOnBicycle(playerid)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 481:return 1;
   case 509:return 1;
   case 510:return 1;
  }
 }
 return 0;
}
