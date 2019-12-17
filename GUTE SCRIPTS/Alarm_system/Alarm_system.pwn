/*================================================================================================
						   Alarm system by James_Alex, buy alarm and
								     turn it ON and OFF
==================================================================================================*/
#include <a_samp>
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_YELLOW 0xFFFF00AA
forward Alarm();
forward SA();
new Alarmed[MAX_VEHICLES];
new Ala;
new StA;
new AlarmStatus[MAX_VEHICLES];
public OnPlayerCommandText(playerid, cmdtext[]){
	if (strcmp("/buyalarm", cmdtext, true, 10) == 0){
		new v = GetPlayerVehicleID(playerid);
		if(IsPlayerInAnyVehicle(playerid)){
		    if(GetPlayerMoney(playerid) >= 3500){
				if(Alarmed[v] == 0){
					Alarmed[v] = 1;
					SendClientMessage(playerid, COLOR_YELLOW, "You succefully buyed an alarm to your vehicle");
                    GivePlayerMoney(playerid, -3500);
                    AlarmStatus[v] = 1;
				}
				else{
    				SendClientMessage(playerid, COLOR_LIGHTRED, "You already have an alarm !");
			    	return 1;
				}
			}
			else{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You haven't enough money !");
			    return 1;
			}
		}
		else{
  			SendClientMessage(playerid, COLOR_LIGHTRED, "You are not in a vehicle !");
	    	return 1;
		}
		return 1;
	}
	if (strcmp("/turnalarm", cmdtext, true, 10) == 0){
		if(IsPlayerInAnyVehicle(playerid)){
			new v = GetPlayerVehicleID(playerid);
			if(Alarmed[v] == 1){
				if(AlarmStatus[v] == 1){
	        		AlarmStatus[v] = 0;
	        		SendClientMessage(playerid, COLOR_YELLOW, "You have succefully turned your vehicle alarm OFF");
					return 1;
	 			}
     			else if(AlarmStatus[v] == 0){
	        		AlarmStatus[v] = 1;
	        		SendClientMessage(playerid, COLOR_YELLOW, "You have succefully turned your vehicle alarm ON");
					return 1;
				}
		 	}
     		else{
     	    	SendClientMessage(playerid, COLOR_YELLOW, "You don't own an alarm");
     	    	return 1;
   	 		}
   	 	}
 	}
    return 0;
}
public OnPlayerStateChange(playerid, newstate, oldstate){
	if(newstate == PLAYER_STATE_DRIVER)	{
		new vehid = GetPlayerVehicleID(playerid);
		if(Alarmed[vehid] == 1){
			if(AlarmStatus[vehid] == 1){
				new Float:X;
				new Float:Y;
				new Float:Z;
				GetPlayerPos(playerid, X, Y, Z);
				PlayerPlaySound(playerid, 1147, X, Y, Z);
				Ala = SetTimer("Alarm", 350, 0);
			}
		}
	}
	return 1;
}
public Alarm(){
	for(new i=0; i<MAX_PLAYERS; i++){
		new Float:X;
		new Float:Y;
		new Float:Z;
		GetPlayerPos(i, X, Y, Z);
		PlayerPlaySound(i, 1147, X, Y, Z);
		KillTimer(Ala);
		Ala = SetTimer("Alarm", 350, 0);
		StA = SetTimer("SA", 12000, 0);
	}
	return 1;
}
public SA(){
	KillTimer(StA);
	KillTimer(Ala);
	return 1;
}