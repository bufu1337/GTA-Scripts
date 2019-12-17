#include <a_samp>
new IsReplaying[200];
new ReplayOffset[200];
enum ReplayEnum{
	Float:X, Float:Y, Float:Z, Float:A, Veh, Float:Health, Float:VHealth, Float:Armour, Keys, Weapon
};
new Float:ReplayData[200][1001][ReplayEnum];
new PlayerCar[200];
new PlayerJumping[200];
new Text:Texts[4];
public OnFilterScriptInit(){
	SetTimer("UpdateReplay", 40, true);
	Texts[0] = TextDrawCreate(-10.0, -10.0, " ");
	Texts[1] = TextDrawCreate(-10.0, -10.0, "~n~~n~~n~~n~");
	TextDrawTextSize(Texts[1], 700.0, 100.0);
	TextDrawUseBox(Texts[1], true);
	TextDrawBoxColor(Texts[1], 0x000000FF);
	Texts[2] = TextDrawCreate(-10.0, 400.0, "~n~~n~~n~~n~~n~~n~~n~~n~~n~");
	TextDrawTextSize(Texts[2], 700.0, 400.0);
	TextDrawUseBox(Texts[2], true);
	TextDrawBoxColor(Texts[2], 0x000000FF);
	Texts[3] = TextDrawCreate(550.0, 10.0, "Replay");
	print("Replay system by Luby - Loaded");
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[]){
	new cmd[256], idx=0;
	cmd = strtok(cmdtext, idx);
	if(!strcmp(cmdtext, "/replay", true)){
		if(!IsReplaying[playerid]){
		    IsReplaying[playerid] = true;
		    TextDrawShowForPlayer(playerid, Texts[1]);
		    TextDrawShowForPlayer(playerid, Texts[2]);
		    TextDrawShowForPlayer(playerid, Texts[3]);
		    SendClientMessage(playerid, 0x44FF44FF, "*** Replay playing.");
		    SetPlayerVirtualWorld(playerid, 3);
		    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)ReplayData[playerid][1000][Veh] = GetPlayerVehicleID(playerid); else ReplayData[playerid][1000][Veh] = -1;
		} else {
		    ReplayOffset[playerid] = 998;
		    SendClientMessage(playerid, 0x44FF44FF, "*** Replay stopped playing.");
		}
	    return 1;
	}
	if(!strcmp(cmd, "/savereplay", true)){
	    new file[256];
	    file = strtok(cmdtext, idx);
	    if(!file[0])return SendClientMessage(playerid, 0xFF4444FF, "*** Usage : /savereplay name.");
	    if(fexist(file)) return SendClientMessage(playerid, 0xFF4444FF, "*** Name already exists.");
		SaveReplay(playerid, file);
		format(file, 256, "*** Saved replay  \"%s\". To load type /loadreplay name.", file);
		SendClientMessage(playerid, 0x44FF44FF, file);
	    return 1;
	}
	if(!strcmp(cmd, "/loadreplay", true)){
	    new file[256];
	    file = strtok(cmdtext, idx);
	    if(!file[0])return SendClientMessage(playerid, 0xFF4444FF, "*** Usage : /loadreplay name.");
	    if(!fexist(file)) return SendClientMessage(playerid, 0xFF4444FF, "*** Name doesn't exist.");
		LoadReplay(playerid, file);
		format(file, 256, "*** Replay \"%s\" loaded and played.", file);
		SendClientMessage(playerid, 0x44FF44FF, file);
	    return 1;
	}
	return 0;
}
stock strtok(const string[], &index){
        new length = strlen(string);
        while ((index < length) && (string[index] <= ' '))index++;
        new offset = index;
        new result[20];
        while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1))){
                result[index - offset] = string[index];
                index++;
        }
        result[index - offset] = EOS;
        return result;
}
public OnPlayerConnect(playerid){
	for(new g=0;g<1000;g++){
		ReplayData[playerid][g][X] = 0.0;
		ReplayData[playerid][g][Y] = 0.0;
		ReplayData[playerid][g][Z] = 0.0;
		ReplayData[playerid][g][A] = 0.0;
		ReplayData[playerid][g][Veh] = -1;
		ReplayData[playerid][g][Health] = 100.0;
		ReplayData[playerid][g][VHealth] = 1000.0;
		ReplayData[playerid][g][Armour] = 0.0;
		ReplayData[playerid][g][Keys] = 0;
		ReplayData[playerid][g][Weapon] = 0;
	}
	IsReplaying[playerid] = 0;
	ReplayOffset[playerid] = 0;
	PlayerCar[playerid] = 0;
	TextDrawShowForPlayer(playerid, Texts[0]);
}
forward UpdateReplay();
public UpdateReplay()for(new playerid = 0;playerid<200;playerid++)if(IsPlayerConnected(playerid)){
	if(IsReplaying[playerid]){
	    while(ReplayData[playerid][ReplayOffset[playerid]][X] == 0.0){
	        ReplayOffset[playerid]++;
	    }
	    if(ReplayData[playerid][ReplayOffset[playerid]][Veh] != -1 && ReplayData[playerid][ReplayOffset[playerid]][Veh]> 400){
	        if(PlayerCar[playerid] == 0){
                PlayerCar[playerid] = CreateVehicle(ReplayData[playerid][ReplayOffset[playerid]][Veh], 0.0, 0.0, 0.0, 0.0, -1,-1,9999999);
				SetVehicleVirtualWorld(PlayerCar[playerid], 3);
		 		PutPlayerInVehicle(playerid, PlayerCar[playerid], 0);
		 	}
	    }
	    if(ReplayData[playerid][ReplayOffset[playerid]][Veh] != -1){
	        SetVehiclePos(PlayerCar[playerid], ReplayData[playerid][ReplayOffset[playerid]][X], ReplayData[playerid][ReplayOffset[playerid]][Y], ReplayData[playerid][ReplayOffset[playerid]][Z]);
	        SetVehicleHealth(PlayerCar[playerid], ReplayData[playerid][ReplayOffset[playerid]][VHealth]);
	        SetVehicleZAngle(PlayerCar[playerid], ReplayData[playerid][ReplayOffset[playerid]][A]);
	        PutPlayerInVehicle(playerid, PlayerCar[playerid], 0);
	    } else {
	        //SetPlayerPos(playerid, ReplayData[playerid][ReplayOffset[playerid]][X], ReplayData[playerid][ReplayOffset[playerid]][Y], ReplayData[playerid][ReplayOffset[playerid]][Z]);
	        if(PlayerCar[playerid] > -1){
				DestroyVehicle(PlayerCar[playerid]);
				PlayerCar[playerid] = 0;
			}
	        SetPlayerFacingAngle(playerid, ReplayData[playerid][ReplayOffset[playerid]][A]);
	        if(GetPlayerWeapon(playerid) != ReplayData[playerid][ReplayOffset[playerid]][Weapon]){
	            ResetPlayerWeapons(playerid);
	            GivePlayerWeapon(playerid, ReplayData[playerid][ReplayOffset[playerid]][Weapon], 1000);
	        }
	        if(ReplayOffset[playerid] > 0 && ReplayOffset[playerid] < 999 && floatabs(ReplayData[playerid][ReplayOffset[playerid]][X] - ReplayData[playerid][ReplayOffset[playerid]-1][X])+floatabs(ReplayData[playerid][ReplayOffset[playerid]][Y] - ReplayData[playerid][ReplayOffset[playerid]-1][Y]) != 0.0){
				if(!PlayerJumping[playerid]){
					if(ReplayData[playerid][ReplayOffset[playerid]][Keys] & 8){
			   			ApplyAnimation(playerid, "ped", "sprint_civi", 15.0, 0, 1, 1, 1, 1);
			   		} else if(ReplayData[playerid][ReplayOffset[playerid]][Keys] & 1024){
			   		    ApplyAnimation(playerid, "ped", "WALK_player", 15.0, 0, 1, 1, 1, 1);
			   		} else if(ReplayData[playerid][ReplayOffset[playerid]][Keys] & 32){
			   		    ApplyAnimation(playerid, "ped", "JUMP_glide", 15.0, 0, 1, 1, 0, 0);
			   		    PlayerJumping[playerid]++;
			   		} else ApplyAnimation(playerid, "ped", "run_player", 15.0, 0, 1, 1, 1, 1);
		   		} else {
		   		    PlayerJumping[playerid]++;
		   		    if(PlayerJumping[playerid] > 17)PlayerJumping[playerid] = 0;
		   		}
	        } else {
				new Float:X2, Float:Y2, Float:Z2;
				GetPlayerPos(playerid, X2, Y2, Z2);
				if(floatabs(X2 - ReplayData[playerid][ReplayOffset[playerid]][X]) > 2.0 || floatabs(Y2 - ReplayData[playerid][ReplayOffset[playerid]][Y]) > 2.0 || ReplayOffset[playerid] == 998 || ReplayOffset[playerid] == 999){
		            ClearAnimations(playerid);
	        		SetPlayerPos(playerid, ReplayData[playerid][ReplayOffset[playerid]][X], ReplayData[playerid][ReplayOffset[playerid]][Y], ReplayData[playerid][ReplayOffset[playerid]][Z]);
				}
	        }
	    }
	    SetPlayerHealth(playerid, ReplayData[playerid][ReplayOffset[playerid]][Health]);
	    SetPlayerArmour(playerid, ReplayData[playerid][ReplayOffset[playerid]][Armour]);
	    ReplayOffset[playerid]++;
	    if(ReplayOffset[playerid] > 998){
	        ReplayOffset[playerid] = 0;
	        IsReplaying[playerid] = 0;
	        //ClearAnimations(playerid);
		    TextDrawHideForPlayer(playerid, Texts[1]);
		    TextDrawHideForPlayer(playerid, Texts[2]);
		    TextDrawHideForPlayer(playerid, Texts[3]);
		    SetPlayerVirtualWorld(playerid, 0);
	        if(PlayerCar[playerid] > -1){
				DestroyVehicle(PlayerCar[playerid]);
				PlayerCar[playerid] = 0;
			}
	    	if(ReplayData[playerid][1000][Veh] > -1){
		        SetVehiclePos(ReplayData[playerid][1000][Veh], ReplayData[playerid][1000][X], ReplayData[playerid][1000][Y], ReplayData[playerid][1000][Z]);
		        SetVehicleHealth(ReplayData[playerid][1000][Veh], ReplayData[playerid][1000][VHealth]);
		        SetVehicleZAngle(ReplayData[playerid][1000][Veh], ReplayData[playerid][1000][A]);
			//	PutPlayerInVehicle(playerid, ReplayData[playerid][1000][Veh], 0);
		    } else {
		        SetPlayerPos(playerid, ReplayData[playerid][1000][X], ReplayData[playerid][1000][Y], ReplayData[playerid][1000][Z]);
		        if(PlayerCar[playerid] > -1){
					DestroyVehicle(PlayerCar[playerid]);
					PlayerCar[playerid] = 0;
				}
		        SetPlayerFacingAngle(playerid, ReplayData[playerid][1000][A]);
		    }
		    if(ReplayData[playerid][1000][Veh] > -1){
				PutPlayerInVehicle(playerid, ReplayData[playerid][1000][Veh], 0);
			} else ClearAnimations(playerid);
	    }
	} else {
	    new Float:X1, Float:Y1, Float:Z1, Float:A1, Veh1, Float:Health1, Float:VHealth1, Float:Armour1;
	    if(IsPlayerInAnyVehicle(playerid)){
	   	 	Veh1 = GetPlayerVehicleID(playerid);
			GetVehiclePos(Veh1, X1, Y1, Z1);
			GetVehicleZAngle(Veh1, A1);
			GetVehicleHealth(Veh1, VHealth1);
			Veh1 = GetVehicleModel(Veh1);
		} else {
		    Veh1 = -1;
		    GetPlayerPos(playerid, X1, Y1, Z1);
		    GetPlayerFacingAngle(playerid, A1);
		}
		GetPlayerHealth(playerid, Health1);
		GetPlayerArmour(playerid, Armour1);
		new keys, updown, leftright, Wpn;
		GetPlayerKeys(playerid, keys, updown, leftright);
		Wpn = GetPlayerWeapon(playerid);
		for(new g=1;g<1000;g++){
			ReplayData[playerid][g-1][X] = ReplayData[playerid][g][X];
			ReplayData[playerid][g-1][Y] = ReplayData[playerid][g][Y];
			ReplayData[playerid][g-1][Z] = ReplayData[playerid][g][Z];
			ReplayData[playerid][g-1][A] = ReplayData[playerid][g][A];
			ReplayData[playerid][g-1][Veh] = ReplayData[playerid][g][Veh];
			ReplayData[playerid][g-1][Health] = ReplayData[playerid][g][Health];
			ReplayData[playerid][g-1][VHealth] = ReplayData[playerid][g][VHealth];
			ReplayData[playerid][g-1][Armour] = ReplayData[playerid][g][Armour];
			ReplayData[playerid][g-1][Keys] = ReplayData[playerid][g][Keys];
			ReplayData[playerid][g-1][Weapon] = ReplayData[playerid][g][Weapon];
		}
		ReplayData[playerid][999][X] = X1;
		ReplayData[playerid][999][Y] = Y1;
		ReplayData[playerid][999][Z] = Z1;
		ReplayData[playerid][999][A] = A1;
		ReplayData[playerid][999][Veh] = Veh1;
		ReplayData[playerid][999][Health] = Health1;
		ReplayData[playerid][999][VHealth] = VHealth1;
		ReplayData[playerid][999][Armour] = Armour1;
		ReplayData[playerid][999][Keys] = keys;
		ReplayData[playerid][999][Weapon] = Wpn;
		ReplayData[playerid][1000][X] = X1;
		ReplayData[playerid][1000][Y] = Y1;
		ReplayData[playerid][1000][Z] = Z1;
		ReplayData[playerid][1000][A] = A1;
		//if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)ReplayData[playerid][1000][Veh] = GetPlayerVehicleID(playerid); else ReplayData[playerid][1000][Veh] = -1;
		ReplayData[playerid][1000][Health] = Health1;
		ReplayData[playerid][1000][VHealth] = VHealth1;
		ReplayData[playerid][1000][Armour] = Armour1;
		ReplayData[playerid][1000][Keys] = keys;
		ReplayData[playerid][1000][Weapon] = Wpn;
	}
}
stock tostr(val){
	new str[256];
	format(str, 256, "%d", val);
	return str;
}
stock strfloat(Float:var){
	new str[256];
	format(str, 256, "%f", var);
	return str;
}
stock Split(s1[],s2[],s3[]="",s4[]="",s5[]="",s6[]="",s7[]="",s8[]="",s9[]="",s10[]="",s11[]="",s12[]="",s13[]="",s14[]="",s15[]=""){
	new str[256];
	format(str, 256, "%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s", s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15);
	return str;
}
SaveReplay(playerid, file[]){
	new File:fh = fopen(file, io_readwrite);
	new str[256];
	for(new g=0;g<1000;g++){
	    format(str, 256, "%f %f %f %f %d %f %f %f %d %d\r\n",
	    ReplayData[playerid][g][X],
	    ReplayData[playerid][g][Y],
	    ReplayData[playerid][g][Z],
	    ReplayData[playerid][g][A],
	    ReplayData[playerid][g][Veh],
	    ReplayData[playerid][g][Health],
	    ReplayData[playerid][g][VHealth],
	    ReplayData[playerid][g][Armour],
		ReplayData[playerid][g][Keys],
		ReplayData[playerid][g][Weapon]);
		fwrite(fh, str);
	}
	fclose(fh);
	return true;
}
LoadReplay(playerid, file[]){
	new File:fh = fopen(file, io_readwrite);
	new str[256], tok[256], id=0, idx=0;
	while(fread(fh, str)){
	    tok = strtok(str, idx);
		ReplayData[playerid][id][X] = floatstr(tok);
		tok = strtok(str, idx);
		ReplayData[playerid][id][Y] = floatstr(tok);
		tok = strtok(str, idx);
		ReplayData[playerid][id][Z] = floatstr(tok);
		tok = strtok(str, idx);
		ReplayData[playerid][id][A] = floatstr(tok);
		tok = strtok(str, idx);
		ReplayData[playerid][id][Veh] = strval(tok);
		tok = strtok(str, idx);
		ReplayData[playerid][id][Health] = floatstr(tok);
		tok = strtok(str, idx);
		ReplayData[playerid][id][VHealth] = floatstr(tok);
		tok = strtok(str, idx);
		ReplayData[playerid][id][Armour] = floatstr(tok);
		tok = strtok(str, idx);
		ReplayData[playerid][id][Keys] = strval(tok);
		tok = strtok(str, idx);
		ReplayData[playerid][id][Weapon] = strval(tok);
		id++;
		idx=0;
	}
	fclose(fh);
	ReplayOffset[playerid] = 0;
	IsReplaying[playerid] = 1;
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)ReplayData[playerid][1000][Veh] = GetPlayerVehicleID(playerid); else ReplayData[playerid][1000][Veh] = -1;
	TextDrawShowForPlayer(playerid, Texts[1]);
	TextDrawShowForPlayer(playerid, Texts[2]);
	TextDrawShowForPlayer(playerid, Texts[3]);
	SetPlayerVirtualWorld(playerid, 3);
	return true;
}