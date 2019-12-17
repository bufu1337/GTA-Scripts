new lastkey[MAX_PLAYERS],lastkey2[MAX_PLAYERS];
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
	if(newkeys!=0)
	{
		lastkey2[playerid]=lastkey[playerid];
		lastkey[playerid]=newkeys;
	}
	new model=GetVehicleModel(GetPlayerVehicleID(playerid));
	if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER && (model==510 || model==509 || model==481) && (lastkey[playerid]==KEY_FIRE || (lastkey[playerid]==8 && lastkey2[playerid]==12)))
	      {
	       new Float:Velocity[3];
	       GetVehicleVelocity(GetPlayerVehicleID(playerid), Velocity[0], Velocity[1], Velocity[2]);
	       if(Velocity[2]>0.35)
	       {
			new str[128];
			format(str,128,"Player %s has been kicked for HJ!",PlayerName(playerid));
			SendClientMessageToAll(0xFF0000FF,str);
	                Kick(playerid);
	       }
	}
}