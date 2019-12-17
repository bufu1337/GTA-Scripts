#include <a_samp>
enum pinfo {
	SpeedClock[4],
};
new TDSpeedClock[15];
public OnFilterScriptInit(){
	TDSpeedClock[0] = TextDrawStreamCreate(496.000000,400.000000,"~g~20");
 	TDSpeedClock[1] = TextDrawStreamCreate(487.000000,388.000000,"~g~40");
 	TDSpeedClock[2] = TextDrawStreamCreate(483.000000,375.000000,"~g~60");
 	TDSpeedClock[3] = TextDrawStreamCreate(488.000000,362.000000,"~g~80");
 	TDSpeedClock[4] = TextDrawStreamCreate(491.000000,349.000000,"~g~100");
 	TDSpeedClock[5] = TextDrawStreamCreate(508.000000,336.500000,"~g~120");
 	TDSpeedClock[6] = TextDrawStreamCreate(536.000000,332.000000,"~g~140");
 	TDSpeedClock[7] = TextDrawStreamCreate(567.000000,337.000000,"~g~160");
 	TDSpeedClock[8] = TextDrawStreamCreate(584.000000,348.000000,"~g~180");
 	TDSpeedClock[9] = TextDrawStreamCreate(595.000000,360.000000,"~g~200");
 	TDSpeedClock[10] = TextDrawStreamCreate(603.000000,374.000000,"~g~220");
 	TDSpeedClock[11] = TextDrawStreamCreate(594.000000,386.000000,"~g~240");
 	TDSpeedClock[12] = TextDrawStreamCreate(585.000000,399.000000,"~g~260");
 	TDSpeedClock[13] = TextDrawStreamCreate(534.000000,396.000000,"~r~/ \\");
 	TextDrawStreamLetterSize(TDSpeedClock[13], 1.059999, 2.100000);
 	TDSpeedClock[14] = TextDrawCreate(548.000000,401.000000,".");
	TextDrawStreamLetterSize(TDSpeedClock[14], 0.73, -2.60);
	TextDrawStreamSetOutline(TDSpeedClock[14], 0);
 	TextDrawStreamSetShadow(TDSpeedClock[14], 1);
	TextDrawStreamUseBox(TDSpeedClock[14], 0);
	for(new i; i < 14; i++){
 		TextDrawStreamSetShadow(TDSpeedClock[i], 0);
		TextDrawStreamUseBox(TDSpeedClock[i], 0);
	}
	return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate){
	if(newstate == PLAYER_STATE_DRIVER)	{
		for(new i; i < 15; i++){
			TextDrawStreamShowForPlayer(playerid, TDSpeedClock[i]);
		}
		for(new i; i < 4; i++){
	  		PlayerInfo[playerid][SpeedClock][i] = TextDrawStreamCreate(555.0, 402.0, "~b~.");
		}
	}
	else {
		for(new i; i < 4; i++){
		    TextDrawStreamHideForPlayer(playerid, PlayerInfo[playerid][SpeedClock][i]);
		}
		for(new i; i < 15; i++){
			TextDrawStreamHideForPlayer(playerid, TDSpeedClock[i]);
		}
	}
	return 1;
}
public OnPlayerUpdate(playerid){
	new Float:fPos[3], Float:Pos[4][2], Float:fSpeed;
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)	{
		GetVehicleVelocity(GetPlayerVehicleID(playerid), fPos[0], fPos[1], fPos[2]);
		fSpeed = floatsqroot(floatpower(fPos[0], 2) + floatpower(fPos[1], 2) + floatpower(fPos[2], 2)) * 200;
		new Float:alpha = 320 - fSpeed;
		for(new i; i < 4; i++){
		    TextDrawHideForPlayer(playerid, PlayerInfo[playerid][SpeedClock][i]);
		    TextDrawDestroy(PlayerInfo[playerid][SpeedClock][i]);
	  		GetDotXY(548, 401, Pos[i][0], Pos[i][1], alpha, (i + 1) * 8);
	  		PlayerInfo[playerid][SpeedClock][i] = TextDrawStreamCreate(Pos[i][0], Pos[i][1], "~b~.");
  			TextDrawLetterSize(PlayerInfo[playerid][SpeedClock][i], 0.73, -2.60);
			TextDrawSetOutline(PlayerInfo[playerid][SpeedClock][i], 0);
			TextDrawSetShadow(PlayerInfo[playerid][SpeedClock][i], 1);
			TextDrawShowForPlayer(playerid, PlayerInfo[playerid][SpeedClock][i]);
		}
	}
	return 1;
}
stock GetDotXY(Float:StartPosX, Float:StartPosY, &Float:NewX, &Float:NewY, Float:alpha, Float:dist){
	NewX = StartPosX + (dist * floatsin(alpha, degrees));
	NewY = StartPosY + (dist * floatcos(alpha, degrees));
}