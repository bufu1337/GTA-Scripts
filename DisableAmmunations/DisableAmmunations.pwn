// Created by aNdReSk
// Disable All Amunations with this script so u can use your own!
// Thanks to [HiC]TheKiller for giving me the idea :D
// Dont remember who made IsPlayerInArea!! Sry!!

#define FILTERSCRIPT

#include <a_samp>

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print(" (( Ammunations Disabled by aNdReSk ))");
	SetTimer("Ammunations",100,1);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{

}

#endif


forward Ammunations();
public Ammunations() // > xmax xmin y max y min
{
    for (new ff = 0; ff < MAX_PLAYERS; ff++)
    {
        if (IsPlayerConnected(ff))
        {
            if (GetPlayerInterior(ff)==1){
        		if (IsPlayerInArea(ff,302.0096,280.2598,-1.3643,-47.0694)){
				SetPlayerShopName(ff,"FDPIZA");}
            }else
            	if (GetPlayerInterior(ff)==6){
        			if (IsPlayerInArea(ff,299.3376,281.8868,-100.0467,-115.9412)){
					SetPlayerShopName(ff,"FDPIZA");}
					if (IsPlayerInArea(ff,322.1972,267.7277,-152.8170,-175.1066)){
					SetPlayerShopName(ff,"FDPIZA");}
            	}else

            if (GetPlayerInterior(ff)==4){
        		if (IsPlayerInArea(ff,335.1329,280.8091,-55.1193,-95.0169)){
				SetPlayerShopName(ff,"FDPIZA");}
            }

        }
     }

}

stock IsPlayerInArea(playerid,Float:max_x,Float:min_x,Float:max_y,Float:min_y)
{
	new Float:X;
	new Float:Y;
	new Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	if(X <= max_x && X >= min_x && Y <= max_y && Y >= min_y){
	return 1;}
	return 0;
}
