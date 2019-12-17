//===================================================================

#include <a_samp>
#pragma tabsize 0
//==============================variable=========================================================//
new bool:phunter[MAX_PLAYERS];
new bool:phydra[MAX_PLAYERS];
new playerhunterammo[MAX_PLAYERS];
new playerhydraammo[MAX_PLAYERS];
new bool:isreload[MAX_PLAYERS];
new freshv[MAX_PLAYERS];
new freshvv[MAX_PLAYERS];
new PlayerText:TextDraw0[MAX_PLAYERS];
new PlayerText:TextDraw1[MAX_PLAYERS];
static hunterstring[64];
static hunterstatus[32];
new bool:reloading[MAX_PLAYERS];
//=================================COLOR DEFINE=================================================//
#define COLOR_RED 0xAA3333AA
//===============================define your value here=========================================//

#define hunterammo 14 //ammo missile of hunter
#define hydraammo 12 //ammo missile of hunter
#define reloadtime 5000 //Time to relaod in Millisecond

//================================define key press fired==========================================//
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
//=================================System FS zone==================================================//
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Hunter Ammo By Colonel-Top (Promsurin Putthammawong)Loaded!");
	print("--------------------------------------\n");

	return 1;
}

public OnFilterScriptExit()
{
    print("\n--------------------------------------");
	print(" Hunter Ammo By Colonel-Top (Promsurin Putthammawong)Unloaded!");
	print("--------------------------------------\n");
	return 1;
}
//================================= Playerkeystatechanged zone==================================================//
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (PRESSED(KEY_FIRE))
	{

		if (IsPlayerInAnyVehicle(playerid))
		{

		        if (phunter[playerid] == true)
		        {
		            freshv[playerid] = hunterammo-playerhunterammo[playerid];
		            	//printf("%d",playerhunterammo[playerid]);
		        	if(playerhunterammo[playerid] >= hunterammo)
		        	{

						TogglePlayerControllable(playerid,0);
						SetTimerEx("stopfreeze", 100, false, "i", playerid);
						if(isreload[playerid] == true)
						{
						    if(reloading[playerid] == false)
						    {
								SetTimerEx("reload",reloadtime, false, "i", playerid);
								playerhunterammo[playerid] = 50;
							reloading[playerid] = true;
							}
							else if(reloading[playerid] == true)
							{
							    	playerhunterammo[playerid] = 50;
							}
							   
						}
						else if(isreload[playerid] == false)
						{
						    GameTextForPlayer(playerid,"~y~Your Missile are ~r~Empty ~n~~p~Please Wait To ~r~Reload !",2000,3);
						SendClientMessage(playerid,COLOR_RED,"[SYSTEM]:Your Missile is reloading");
						//
						 format(hunterstring,sizeof(hunterstring),"Missile: %d",freshv[playerid]);
						PlayerTextDrawSetString(playerid,TextDraw0[playerid],hunterstring);
						format(hunterstatus,sizeof(hunterstatus),"Status: Reloading");
						PlayerTextDrawSetString(playerid,TextDraw1[playerid],hunterstatus);
							playerhunterammo[playerid] = hunterammo;
						isreload[playerid] = true;
						//printf("%d",playerhunterammo[playerid]);
						}
					}
					else if(playerhunterammo[playerid] < hunterammo)
					{
                	 format(hunterstring,sizeof(hunterstring),"Missile: %d",freshv[playerid]);
						PlayerTextDrawSetString(playerid,TextDraw0[playerid],hunterstring);
						format(hunterstatus,sizeof(hunterstatus),"Status: Reloaded");
						PlayerTextDrawSetString(playerid,TextDraw1[playerid],hunterstatus);
				//	 format(texthunterformat,sizeof(texthunterformat),"~g~Missile Left : ~y~ %d",freshv[playerid]);
					// GameTextForPlayer(playerid,texthunterformat,1200,3);
					 playerhunterammo[playerid] ++;
					 isreload[playerid] = false;
					 	//printf("%d",playerhunterammo[playerid]);
					}
				}

		}
	}
	if (PRESSED(KEY_ACTION))
	{

		if (IsPlayerInAnyVehicle(playerid))
		{

		        if (phydra[playerid] == true)
		        {
		            freshvv[playerid] = hydraammo-playerhydraammo[playerid];
		            	//printf("%d",playerhunterammo[playerid]);
		        	if(playerhydraammo[playerid] >= hydraammo)
		        	{

						TogglePlayerControllable(playerid,0);
						SetTimerEx("stopfreeze", 100, false, "i", playerid);
						if(isreload[playerid] == true)
						{
						    if(reloading[playerid] == false)
						    {
								SetTimerEx("reload",reloadtime, false, "i", playerid);
								playerhydraammo[playerid] = 50;
							reloading[playerid] = true;
							}
							else if(reloading[playerid] == true)
							{
							    	playerhydraammo[playerid] = 50;
							}

						}
						else if(isreload[playerid] == false)
						{
						    GameTextForPlayer(playerid,"~y~Your Missile are ~r~Empty ~n~~p~Please Wait To ~r~Reload !",2000,3);
						SendClientMessage(playerid,COLOR_RED,"[SYSTEM]:Your Missile is reloading");
						//
						 format(hunterstring,sizeof(hunterstring),"Missile: %d",freshvv[playerid]);
						PlayerTextDrawSetString(playerid,TextDraw0[playerid],hunterstring);
						format(hunterstatus,sizeof(hunterstatus),"Status: Reloading");
						PlayerTextDrawSetString(playerid,TextDraw1[playerid],hunterstatus);
							playerhydraammo[playerid] = hydraammo;
						isreload[playerid] = true;
						//printf("%d",playerhunterammo[playerid]);
						}
					}
					else if(playerhydraammo[playerid] < hydraammo)
					{
                	 format(hunterstring,sizeof(hunterstring),"Missile: %d",freshvv[playerid]);
						PlayerTextDrawSetString(playerid,TextDraw0[playerid],hunterstring);
						format(hunterstatus,sizeof(hunterstatus),"Status: Reloaded");
						PlayerTextDrawSetString(playerid,TextDraw1[playerid],hunterstatus);
				//	 format(texthunterformat,sizeof(texthunterformat),"~g~Missile Left : ~y~ %d",freshv[playerid]);
					// GameTextForPlayer(playerid,texthunterformat,1200,3);
					 playerhydraammo[playerid] ++;
					 isreload[playerid] = false;
					 	//printf("%d",playerhunterammo[playerid]);
					}
				}

		}
	}
	return 1;
}
//=================================================forward & public zone=================================================//
forward stopfreeze(playerid);
public stopfreeze(playerid)
{
    TogglePlayerControllable(playerid,1);
	return 1;
}
forward reload(playerid);
public reload(playerid)

{
	if(isreload[playerid]==true)
 {
//	printf("before reload %d",playerhunterammo[playerid]);
	isreload[playerid]=false;
    //TogglePlayerControllable(playerid,1);


    
      
   //
   reloading[playerid] = false;
   //	printf("after reload%d",playerhunterammo[playerid]);
 if (phunter[playerid] == true)
 {
   playerhunterammo[playerid] = 0;
 freshv[playerid] = hunterammo-playerhunterammo[playerid];
      
    	    format(hunterstring,sizeof(hunterstring),"Missile: %d",freshv[playerid]);
PlayerTextDrawSetString(playerid,TextDraw0[playerid],hunterstring);
}
  if (phydra[playerid] == true)
   {
    playerhydraammo[playerid]=0;
    freshvv[playerid] = hydraammo-playerhydraammo[playerid];
      
format(hunterstring,sizeof(hunterstring),"Missile: %d",freshvv[playerid]);
PlayerTextDrawSetString(playerid,TextDraw0[playerid],hunterstring);
}
format(hunterstatus,sizeof(hunterstatus),"Status: Reloaded");
PlayerTextDrawSetString(playerid,TextDraw1[playerid],hunterstatus);
}
    //GameTextForPlayer(playerid,"~r~Missile Reload!",1200,3);
	return 1;
}
//===============================================system public zone=======================================================//
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(GetVehicleModel(vehicleid) == 425) // you can changed to jet tank or anything else that need reload ! note: if u want more u need to define new variables
	{
	    phunter[playerid] = true;
	    format(hunterstring,sizeof(hunterstring),"Missile: %d",freshv[playerid]);
PlayerTextDrawSetString(playerid,TextDraw0[playerid],hunterstring);
format(hunterstatus,sizeof(hunterstatus),"Status: Reloaded");
PlayerTextDrawSetString(playerid,TextDraw1[playerid],hunterstatus);
PlayerTextDrawShow(playerid, TextDraw0[playerid]);
//	printf("first enter %d",playerhunterammo[playerid]);
PlayerTextDrawShow(playerid, TextDraw1[playerid]);
	}
	if(GetVehicleModel(vehicleid) == 520) // you can changed to jet tank or anything else that need reload ! note: if u want more u need to define new variables
	{
	    phydra[playerid] = true;
	    format(hunterstring,sizeof(hunterstring),"Missile: %d",freshvv[playerid]);
PlayerTextDrawSetString(playerid,TextDraw0[playerid],hunterstring);
format(hunterstatus,sizeof(hunterstatus),"Status: Reloaded");
PlayerTextDrawSetString(playerid,TextDraw1[playerid],hunterstatus);
PlayerTextDrawShow(playerid, TextDraw0[playerid]);
//	printf("first enter %d",playerhunterammo[playerid]);
PlayerTextDrawShow(playerid, TextDraw1[playerid]);
	}
	return 1;
}
public OnPlayerSpawn(playerid)
{
    phunter[playerid] = false;
    phydra[playerid] = false;
    playerhunterammo[playerid] = 0;
     playerhydraammo[playerid] = 0;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	phunter[playerid] = false;
		phydra[playerid] = false;
	PlayerTextDrawHide(playerid, TextDraw0[playerid]);
	PlayerTextDrawHide(playerid, TextDraw1[playerid]);
}
public OnPlayerConnect(playerid)
{
        playerhunterammo[playerid] = 0;
               playerhydraammo[playerid] = 0;
    freshv[playerid] = hunterammo-playerhunterammo[playerid];
freshvv[playerid] = hydraammo-playerhydraammo[playerid];


    TextDraw0[playerid] = CreatePlayerTextDraw(playerid,487.000000, 333.000000,"");
PlayerTextDrawBackgroundColor(playerid,TextDraw0[playerid], 255);
PlayerTextDrawFont(playerid,TextDraw0[playerid], 1);
PlayerTextDrawLetterSize(playerid,TextDraw0[playerid], 0.500000, 1.799999);
PlayerTextDrawColor(playerid,TextDraw0[playerid], -1);
PlayerTextDrawSetOutline(playerid,TextDraw0[playerid], 0);
PlayerTextDrawSetProportional(playerid,TextDraw0[playerid], 1);
PlayerTextDrawSetShadow(playerid,TextDraw0[playerid], 1);

TextDraw1[playerid] = CreatePlayerTextDraw(playerid,487.000000, 360.000000, "");
PlayerTextDrawBackgroundColor(playerid,TextDraw1[playerid], 255);
PlayerTextDrawFont(playerid,TextDraw1[playerid], 1);
PlayerTextDrawLetterSize(playerid,TextDraw1[playerid], 0.500000, 1.799999);
PlayerTextDrawColor(playerid,TextDraw1[playerid], -1);
PlayerTextDrawSetOutline(playerid,TextDraw1[playerid], 0);
PlayerTextDrawSetProportional(playerid,TextDraw1[playerid], 1);
PlayerTextDrawSetShadow(playerid,TextDraw1[playerid], 1);
freshv[playerid] = hunterammo-playerhunterammo[playerid];
	return 1;
	
}
public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(GetVehicleModel(vehicleid) == 425)
    {
         phunter[playerid] = false;
         PlayerTextDrawHide(playerid,TextDraw1[playerid]);
         PlayerTextDrawHide(playerid,TextDraw0[playerid]);
    }
    if(GetVehicleModel(vehicleid) == 520)
    {
         phydra[playerid] = false;
         PlayerTextDrawHide(playerid,TextDraw1[playerid]);
         PlayerTextDrawHide(playerid,TextDraw0[playerid]);
    }
    return 1;
}