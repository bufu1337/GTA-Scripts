/*
				いいいいいいいいいいいいいいいいいいいいいいいいい
    						ADD THIS IN YOUR GAMEMODE
			い                                                      い
		い                                                              い
	い                                                                      い
い                                                                              い
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & 16 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    for(new M = 1; M < MAX_MACHINES; M++)
	    {
	    	new Float:A,Float:H;
	    	GetPlayerFacingAngle(playerid,A);
	    	FoodMachines[M][fmX] -= (1 * floatsin(-A, degrees));
			FoodMachines[M][fmY] -= (1 * floatcos(-A, degrees));
			if (Seif_PlayerToPoint(playerid,1,FoodMachines[M][fmX],FoodMachines[M][fmY],FoodMachines[M][fmZ]) && GetPlayerMoney(playerid) >= 1)
			{
			    if (FoodMachines[M][fmType] == 1)
			    {
		   			GetPlayerHealth(playerid,H);
		   			ApplyAnimation(playerid,"VENDING","VEND_Use",4.1,0,1,1,1,1);
					GivePlayerMoney(playerid,-1);
					PlayerPlaySound(playerid,42600,0.0,0.0,0.0);
					Anim[playerid] = 1;
					SetTimerEx("MachineAnimation",2000,0,"d",playerid);
		    		if (H <= 75) SetPlayerHealth(playerid,H+25);
		    		else SetPlayerHealth(playerid,100);
				}
				else if (FoodMachines[M][fmType] == 2)
				{
				    GetPlayerHealth(playerid,H);
		   			ApplyAnimation(playerid,"VENDING","VEND_Use",4.1,0,1,1,1,1);
					GivePlayerMoney(playerid,-1);
					PlayerPlaySound(playerid,42601,0.0,0.0,0.0);
					Anim[playerid] = 2;
					SetTimerEx("MachineAnimation",2000,0,"d",playerid);
		    		if (H <= 75) SetPlayerHealth(playerid,H+25);
		    		else SetPlayerHealth(playerid,100);
				}
			}
			FoodMachines[M][fmX] += (1 * floatsin(-A, degrees));
			FoodMachines[M][fmY] += (1 * floatcos(-A, degrees));
		}
	}
	return 1;
}

				OR IF YOU ALREADY HAVE OnPlayerKeyStateChange DEFINED, ADD THIS IN IT
				
if (newkeys & 16 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    for(new M = 1; M < MAX_MACHINES; M++)
	    {
	    	new Float:A,Float:H;
	    	GetPlayerFacingAngle(playerid,A);
	    	FoodMachines[M][fmX] -= (1 * floatsin(-A, degrees));
			FoodMachines[M][fmY] -= (1 * floatcos(-A, degrees));
			if (Seif_PlayerToPoint(playerid,1,FoodMachines[M][fmX],FoodMachines[M][fmY],FoodMachines[M][fmZ]) && GetPlayerMoney(playerid) >= 1)
			{
			    if (FoodMachines[M][fmType] == 1)
			    {
		   			GetPlayerHealth(playerid,H);
		   			ApplyAnimation(playerid,"VENDING","VEND_Use",4.1,0,1,1,1,1);
					GivePlayerMoney(playerid,-MACHINE_CASH);
					PlayerPlaySound(playerid,42600,0.0,0.0,0.0);
					Anim[playerid] = 1;
					SetTimerEx("MachineAnimation",2000,0,"d",playerid);
		    		if (H <= 75) SetPlayerHealth(playerid,H+25);
		    		else SetPlayerHealth(playerid,100);
				}
				else if (FoodMachines[M][fmType] == 2)
				{
				    GetPlayerHealth(playerid,H);
		   			ApplyAnimation(playerid,"VENDING","VEND_Use",4.1,0,1,1,1,1);
					GivePlayerMoney(playerid,-MACHINE_CASH);
					PlayerPlaySound(playerid,42601,0.0,0.0,0.0);
					Anim[playerid] = 2;
					SetTimerEx("MachineAnimation",2000,0,"d",playerid);
		    		if (H <= 75) SetPlayerHealth(playerid,H+25);
		    		else SetPlayerHealth(playerid,100);
				}
			}
			FoodMachines[M][fmX] += (1 * floatsin(-A, degrees));
			FoodMachines[M][fmY] += (1 * floatcos(-A, degrees));
		}
	}
	
*/
/*x---------------------------------Important-------------------------------------x*/
//**INCLUDES**//
#include <a_samp>
/*x---------------------------------Defining-------------------------------------x*/
#define MAX_MACHINES	150 // CHANGE IF YOU'RE USING A STREAMER AND WILLING TO ADD MORE
#define MACHINE_CASH    1   // Cost - Default is $1

//**VARIABLES**//
enum fMachines
{
	Float:fmX,
	Float:fmY,
	Float:fmZ,
	fmType
};
new FoodMachines[MAX_MACHINES][fMachines];
new Machine = 0;
new SprunkMachine[MAX_MACHINES];
new CandyMachine[MAX_MACHINES];
new Anim[200];
//**FORWARDS**//
forward MachineAnimation(playerid);
/*x---------------------------------CallBacks-------------------------------------x*/
stock Seif_PlayerToPoint(playerid,Float:radi, Float:px, Float:py, Float:pz)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:x, Float:y, Float:z;
		new Float:ox, Float:oy, Float:oz;
		GetPlayerPos(playerid, ox, oy, oz);
		x = (ox -px);
		y = (oy -py);
		z = (oz -pz);
		if (((x < radi) && (x > -radi)) && ((y < radi) && (y > -radi)) && ((z < radi) && (z > -radi))) return 1;
	}
	return 0;
}

stock AddSprunkMachine(Float:X,Float:Y,Float:Z,Float:rX,Float:rY,Float:rZ)
{
	Machine++;
	SprunkMachine[Machine] = CreateObject(955,X,Y,Z,rX,rY,rZ);
	FoodMachines[Machine][fmX] = X;
	FoodMachines[Machine][fmY] = Y;
	FoodMachines[Machine][fmZ] = Z;
	FoodMachines[Machine][fmType] = 1;
}

stock AddCandyMachine(Float:X,Float:Y,Float:Z,Float:rX,Float:rY,Float:rZ)
{
	Machine++;
	CandyMachine[Machine] = CreateObject(956,X,Y,Z,rX,rY,rZ);
	FoodMachines[Machine][fmX] = X;
	FoodMachines[Machine][fmY] = Y;
	FoodMachines[Machine][fmZ] = Z;
	FoodMachines[Machine][fmType] = 2;
}

public MachineAnimation(playerid)
{
	if (Anim[playerid] == 1) ApplyAnimation(playerid,"VENDING","VEND_Drink2_P",4.1,0,1,1,1,1), Anim[playerid] = 0 ,SetTimerEx("MachineAnimation",1000,0,"d",playerid);
	else if (Anim[playerid] == 2) ApplyAnimation(playerid,"VENDING","VEND_Eat_P",4.1,0,1,1,1,1), Anim[playerid] = 0, SetTimerEx("MachineAnimation",1000,0,"d",playerid);
	else if (Anim[playerid] == 0) ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
	return 1;
}
