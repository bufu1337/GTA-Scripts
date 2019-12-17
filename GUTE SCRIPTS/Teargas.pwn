//==========================[Information]=============================
/*
	@title Teargas - V.2
	@author Carlton
	@copyright (c) 2010
	
	@information
		The old Teargas system, i've made in March was clearly bugged,
		I had some freetime on my shoulders and decided to remake it.
		
		The old Teargas bugs included:
		    - Only the first teargas thrown will work.
		    - Teargas Objects wouldn't disappear.
		    - (Not really a bug) You would do a crack animation.
		    
		I decided to use the object instead of the usless functions I did
		in the past version.

		This version was building for accuracy, unlike the old version, when
		the objects would float into the air, thanks to Kye and his Map Andreas
		plugin, this is no longer in effect (http://forum.sa-mp.com/index.php?topic=145196.0)
		Now when you're near the teargases, any of them, you will cough.

	www.epic-missions.co.cc
*/
//==========================[End]=============================
//==========================[Includes]=============================
#include <a_samp> // www.sa-mp.com
#include <mapandreas> // http://forum.sa-mp.com/index.php?topic=145196.0
//==========================[Configuration]=============================
#define TOTAL_ALLOWED_TEARGAS 50 // The max amount of teargas allowed to be used.
//#define HOLD_GAS_ENABLED // This feature is bugged, it's not suggested to enable this.
//#define DEBUG_MODE // If enabled, this FS's debug mode will be enabled.
//=========================[OnPlayerKeyStateChange defines]===============================
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))
//==========================[Enums & Variables]=============================
enum TGData {
	Float:Pos[3],
}
new
	TearGasData[TOTAL_ALLOWED_TEARGAS][TGData],
	GasUsed,
	TearGasTimer,
	bool:TimerStarted,
	Float:pPos[3];
//==========================[Functions]=============================
stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if (GetPlayerVehicleID(playerid))
	{
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}
//==========================[Timer functions]=============================
forward StopTheEffect(gasid);
public StopTheEffect(gasid) {
    GasUsed --;
	return 1;
}
forward EffectOfGas();
public EffectOfGas() {
	if(GasUsed == 0) {
	    KillTimer(TearGasTimer);
	}
	for(new i = 0; i < MAX_PLAYERS; i ++ ) {
	    if(IsPlayerConnected(i)) {
	        for(new g = 0; g < GasUsed; g ++ ){
	            if(IsPlayerInRangeOfPoint(i, 10.0, TearGasData[g][Pos][0], TearGasData[g][Pos][1], TearGasData[g][Pos][2])) {
		            if(GetPVarInt(i, "InAnim") == 0) {
	              		ApplyAnimation(i,"ped","gas_cwr",4.1,0,1,1,0,0);
			            SetPVarInt(i, "InAnim", 1);
			            #if defined DEBUG_MODE
	              			printf("Yes: %d|%d", GetPVarInt(i, "InAnim"), g);
						#endif
					}
					else {
					    ApplyAnimation(i,"ped","gas_cwr",4.1,0,1,1,0,0);
					}
				}
	            else {
	                if(GetPVarInt(i, "InAnim") == 1) {
		                SetPVarInt(i, "InAnim", 0);
		                #if defined DEBUG_MODE
	              			printf("No: %d|%d", GetPVarInt(i, "InAnim"), g);
						#endif
					}
	            }
	        }
	    }
	}
	return 1;
}
//==========================[Public functions]=============================
public OnFilterScriptInit() {
    MapAndreas_Init(MAP_ANDREAS_MODE_FULL);
    GasUsed = 0;
    return 1;
}
public OnPlayerConnect(playerid) {
    ApplyAnimation(playerid,"ped","null",0.0,0,0,0,0,0);
    SetPVarInt(playerid, "InAnim", 0);
    #if defined HOLD_GAS_ENABLED
   		SetPVarInt(playerid, "Holding", 0);
	#endif
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	if (PRESSED(KEY_FIRE)) {
        if(GetPlayerWeapon(playerid) == 17) {
            GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
            GetXYInFrontOfPlayer(playerid, pPos[0], pPos[1], 10.0);
            MapAndreas_FindZ_For2DCoord(pPos[0]+5, pPos[1]+5, pPos[2]);
           	TearGasData[GasUsed][Pos][0] = pPos[0];
           	TearGasData[GasUsed][Pos][1] = pPos[1];
           	TearGasData[GasUsed][Pos][2] = pPos[2];
           	SetTimerEx("StopTheEffect", 20000, 0, "d", GasUsed);
            GasUsed ++;
            if(TimerStarted == false) {
                TearGasTimer = SetTimer("EffectOfGas", 100, 1);
                TimerStarted = true;
            }
        }
	}
	#if defined HOLD_GAS_ENABLED
		if(HOLDING(KEY_FIRE)) {
	 		  if(GetPlayerWeapon(playerid) == 17) {
		        SetPVarInt(playerid, "Holding", 1);
		        GasUsed --;
	            GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
	            GetXYInFrontOfPlayer(playerid, pPos[0], pPos[1], 36.0);
	            MapAndreas_FindZ_For2DCoord(pPos[0], pPos[1], pPos[2]);
	           	TearGasData[GasUsed][Pos][0] = pPos[0];
	           	TearGasData[GasUsed][Pos][1] = pPos[1];
				#if defined DEBUG_MODE
		           	CreatePickup(1248, 1, pPos[0], pPos[1], pPos[2]+5); // Debug
		           	SetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]); // Debug
				#endif
	           	TearGasData[GasUsed][Pos][2] = pPos[2];
	           	SetTimerEx("StopTheEffect", 20000, 0, "d", GasUsed);
	            GasUsed ++;
	            if(TimerStarted == false) {
	                TearGasTimer = SetTimer("EffectOfGas", 100, 1);
	                TimerStarted = true;
	            }
	        }
		}
	#endif
	return 1;
}
//==========================[End]=============================
