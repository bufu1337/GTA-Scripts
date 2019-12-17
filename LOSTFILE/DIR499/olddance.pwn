//-------------------------------------------------
//
// --- OLD DANCING SCRIPT --- (Outdated)
// Has been deprecated in favour of client-side
// dancing (more control).
//
// This script has been included as an example
// of how to set and clear player animations
// using ApplyAnimation and ClearAnimations.
//
//-------------------------------------------------

#pragma tabsize 0
#include <a_samp>
#include <core>
#include <float>

//-------------------------------------------------

new gIsDancing[MAX_PLAYERS];
new gCurrentDanceMove[MAX_PLAYERS];
new Text:txtDanceHelper;

forward ApplyDanceMove(playerid, dancemove);
forward ChangeToNextDanceMove(playerid);
forward ChangeToPreviousDanceMove(playerid);

//-------------------------------------------------

dance_strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

//------------------------------------------------

IsKeyJustDown(key, newkeys, oldkeys)
{
	if((newkeys & key) && !(oldkeys & key)) return 1;
	return 0;
}

//------------------------------------------------

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!gIsDancing[playerid]) return;
	
	if(IsKeyJustDown(KEY_FIRE,newkeys,oldkeys)) {
        ChangeToNextDanceMove(playerid);
		return;
	}
	if(IsKeyJustDown(KEY_JUMP,newkeys,oldkeys)) {
	   ChangeToPreviousDanceMove(playerid);
	}

	if(IsKeyJustDown(KEY_SPRINT,newkeys,oldkeys)) {
		gCurrentDanceMove[playerid] = 0;
        gIsDancing[playerid] = 0;
        ClearAnimations(playerid);
        TextDrawHideForPlayer(playerid,txtDanceHelper);
    }
}

//-------------------------------------------------

ApplyDanceMove(playerid, dancemove)
{
	switch(dancemove) {
		case 0:
			ApplyAnimation(playerid,"DANCING","DAN_LOOP_A",4.0,1,0,0,0,-1);
		case 1:
			ApplyAnimation(playerid,"DANCING","DNCE_M_A",4.0,1,0,0,0,-1);
		case 2:
			ApplyAnimation(playerid,"DANCING","DNCE_M_B",4.0,1,0,0,0,-1);
		case 3:
			ApplyAnimation(playerid,"DANCING","DNCE_M_C",4.0,1,0,0,0,-1);
		case 4:
			ApplyAnimation(playerid,"DANCING","DNCE_M_D",4.0,1,0,0,0,-1);
		case 5:
			ApplyAnimation(playerid,"DANCING","DNCE_M_E",4.0,1,0,0,0,-1);
	}
}

//-------------------------------------------------
	
ChangeToNextDanceMove(playerid)
{
    gCurrentDanceMove[playerid]++;
    if(gCurrentDanceMove[playerid]==6) gCurrentDanceMove[playerid]=0;
	ApplyDanceMove(playerid,gCurrentDanceMove[playerid]);
}

//-------------------------------------------------

ChangeToPreviousDanceMove(playerid)
{
    gCurrentDanceMove[playerid]--;
    if(gCurrentDanceMove[playerid]<0) gCurrentDanceMove[playerid]=5;
	ApplyDanceMove(playerid,gCurrentDanceMove[playerid]);
}

//-------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
	// if they die whilst dancing, we should reset the state
	if(gIsDancing[playerid]) {
	    gCurrentDanceMove[playerid] = 0;
        gIsDancing[playerid] = 0;
        TextDrawHideForPlayer(playerid,txtDanceHelper);
	}
	
 	return 0;
}

//-------------------------------------------------

public OnFilterScriptInit()
{
	// Init our text display
	txtDanceHelper = TextDrawCreate(610.0, 400.0,
	"~r~~k~~PED_FIREWEAPON~ ~w~next~n~~r~~k~~PED_JUMPING~ ~w~previous~n~~r~~k~~PED_SPRINT~ ~w~exit");
	TextDrawUseBox(txtDanceHelper, 0);
	TextDrawFont(txtDanceHelper, 2);
	TextDrawSetShadow(txtDanceHelper,0); // no shadow
    TextDrawSetOutline(txtDanceHelper,1); // thickness 1
    TextDrawBackgroundColor(txtDanceHelper,0x000000FF);
    TextDrawColor(txtDanceHelper,0xFFFFFFFF);
    TextDrawAlignment(txtDanceHelper,3); // align right
}

//-------------------------------------------------

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new idx;
	
	cmd = dance_strtok(cmdtext, idx);

	// START DANCING
 	if(strcmp(cmd, "/olddance", true) == 0) {
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
        	gCurrentDanceMove[playerid] = 0;
        	gIsDancing[playerid] = 1;
        	ChangeToNextDanceMove(playerid);
        	TextDrawShowForPlayer(playerid,txtDanceHelper);
 			return 1;
		}
	}

	return 0;
}

//-------------------------------------------------
// EOF


