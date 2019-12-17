/*                              						Josh's RP Bunny Hop Stop -- Josh Beverly 11/20/11
														Please do NOT remove credits!                                           */


#include <a_samp>


#define COLOR_LIGHTBLUE 0x33CCFFAA


new PressedJump[MAX_PLAYERS];

public OnPlayerConnect(playerid){
	PlayerInfo[playerid][PressedJump] = 0; // Sets variable to 0 when they first connect
	return 1;
}
forward PressJump(playerid);
forward PressJumpReset(playerid);
public PressJump(playerid){
    PlayerInfo[playerid][PressedJump] = 0; // Reset the variable
    ClearAnimations(playerid);
    return 1;
}
public PressJumpReset(playerid){
    PlayerInfo[playerid][PressedJump] = 0; // Reset the variable
    return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
	if((newkeys & KEY_JUMP) && !IsPlayerInAnyVehicle(playerid)){
        PlayerInfo[playerid][PressedJump] ++;
        SetTimerEx("PressJumpReset", 3000, false, "i", playerid); // Makes it where if they dont spam the jump key, they wont fall
        if(PlayerInfo[playerid][PressedJump] == 3){
			// change 3 to how many jump you want before they fall
            ApplyAnimation(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1); // applies the fallover animation
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You just tripped, and fell down!");
            SetTimerEx("PressJump", 9000, false, "i", playerid); // Timer for how long the animation lasts
        }
    }
    return 1;
}


