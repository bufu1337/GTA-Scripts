#include <a_samp>

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA

new Text:Textdraww;
new workingouttimer[MAX_PLAYERS];
new workingout[MAX_PLAYERS];
new benchpress[MAX_PLAYERS];

forward benchpressing(playerid);
forward workoutcomplete(playerid);
forward workoutcomplete2(playerid);
forward workoutnotcomplete(playerid);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Work out in the LS Gym");
	print(" Created By: Trey Fresh");
	print("--------------------------------------\n");
	
   	Textdraww = TextDrawCreate(572.000000,318.000000,"--");
    TextDrawUseBox(Textdraww,1);
    TextDrawBoxColor(Textdraww,0x00000066);
    TextDrawTextSize(Textdraww,643.000000,0.000000);
    TextDrawAlignment(Textdraww,0);
    TextDrawBackgroundColor(Textdraww,0x000000ff);
    TextDrawFont(Textdraww,3);
    TextDrawLetterSize(Textdraww,0.999999,2.900000);
    TextDrawColor(Textdraww,0xffffffff);
    TextDrawSetOutline(Textdraww,1);
    TextDrawSetProportional(Textdraww,1);
    TextDrawSetShadow(Textdraww,1);

	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{

    workingout[playerid] = 0;

	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{


    if (workingout[playerid] == 1)
   	{
	if ((newkeys==KEY_SPRINT))
    {
   	benchpressing(playerid);
    }
    }

    if (workingout[playerid] == 1)
   	{
   	if ((newkeys==KEY_FIRE))
    {
   	workingout[playerid] = 0;
   	ApplyAnimation(playerid,"benchpress","gym_bp_getoff", 4.0, 0, 0, 0, 1, 0);
   	SetTimerEx("workoutnotcomplete",5000, false, "i", playerid);
    }
    }


}

strtok(const string[], &index)
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

public OnPlayerCommandText(playerid, cmdtext[])
{

	new cmd[256];
	new idx;
	new sendername[MAX_PLAYER_NAME];
	new string[255];
	cmd = strtok(cmdtext, idx);

 	if(strcmp(cmd, "/workout", true) == 0) {
    for(new i=0; i<MAX_PLAYERS; i++)
	{
    if (!PlayerToPoint(9, playerid,773.1721,1.4100,1000.7208))
    {
    SendClientMessage(playerid, COLOR_GREY, "You are not at the LS gym bench");
    return 1;
    }
    if(workingouttimer[playerid] == 1)
    {
    SendClientMessage(playerid, COLOR_GREY, "You must wait 1 minute to use the bench");
    return 1;
    }
    if(workingout[playerid] == 1)
    {
    SendClientMessage(playerid, COLOR_GREY, "You are currently working out right now");
    return 1;
    }
    if(workingout[i] == 1)
    {
	GetPlayerName(i, sendername, sizeof(sendername));
	format(string, 256, "%s is currently using the bench right now you must wait.", sendername);
	SendClientMessage(playerid, COLOR_GREY, string);
    return 1;
    }
   	new Float:health;
    GetPlayerHealth(playerid,health);
    if (health > 100)
    {
	SendClientMessage(playerid,COLOR_GREY,"Your health is currently full you must be lower then 100 hp");
   	return 1;
	}
	SendClientMessage(playerid, COLOR_WHITE, "Press Fire key to cancel");
    SendClientMessage(playerid, COLOR_WHITE, "Press Space To Bench Press");
 	TextDrawShowForPlayer(playerid,Textdraww);
    format(string, sizeof(string), "%d", benchpress[playerid]);
 	TextDrawSetString(Text:Textdraww, string);
 	TogglePlayerControllable(playerid,false);
    SetPlayerPos(playerid, 773.1721,1.4100,1000.7208);
    SetPlayerFacingAngle(playerid,271.7761);
    SetPlayerInterior(playerid, 5);
	SetPlayerCameraPos(playerid, 771.9297,-0.3985,1000.7253);
	SetPlayerCameraLookAt(playerid, 774.0267,1.0166,1000.7209);
 	ApplyAnimation(playerid,"benchpress","gym_bp_geton", 4.0, 0, 0, 0, 1, 0);
    workingout[playerid] = 1;
 	return 1;
	}
	}

	return 0;
}

public benchpressing(playerid)
{

    if (benchpress[playerid] <= 99)
	{
    new string[255];
    format(string, sizeof(string), "%d", benchpress[playerid]);
    TextDrawSetString(Text:Textdraww, string);
    benchpress[playerid] += 1;
   	ApplyAnimation(playerid,"benchpress","gym_bp_up_B", 4.0, 0, 0, 0, 1, 0);
   	return 1;
	}

    if (benchpress[playerid] >= 99)
	{
    new string[255];
    format(string, sizeof(string), "%d", benchpress[playerid]);
    TextDrawSetString(Text:Textdraww, string);
    workingout[playerid] = 0;
   	ApplyAnimation(playerid,"benchpress","gym_bp_getoff", 4.0, 0, 0, 0, 1, 0);
   	SetTimer("workoutcomplete",5000, false);
   	return 1;
	}

	return 1;
}

public workoutcomplete(playerid)
{

    for(new i=0; i<MAX_PLAYERS; i++)
	{
	workingouttimer[i] = 1;
    benchpress[playerid] = 0;
    TextDrawHideForPlayer(playerid,Textdraww);
	SendClientMessage(playerid,COLOR_YELLOW,"Workout completed you now have 100 hp");
    TogglePlayerControllable(playerid,true);
    SetPlayerHealth(playerid,100);
    SetCameraBehindPlayer(playerid);
    ApplyAnimation(playerid,"benchpress","gym_bp_celebrate", 4.0, 0, 0, 0, 0, 0);
    SetTimer("workoutcomplete2",60000, false);
    benchpress[playerid] = 0;
    return 1;
    }

	return 1;
}

public workoutnotcomplete(playerid)
{

    for(new i=0; i<MAX_PLAYERS; i++)
	{
    new string[255];
    format(string, sizeof(string), "Workout completed you have gained %d hp", benchpress[playerid]);
    SendClientMessage(playerid,COLOR_YELLOW, string);
	new Float:hp;
	new extra = benchpress[playerid];
    GetPlayerHealth(playerid,hp);
    SetPlayerHealth(playerid,hp+extra);
	workingouttimer[i] = 1;
    TextDrawHideForPlayer(playerid,Textdraww);
    SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid,true);
    ApplyAnimation(playerid,"benchpress","gym_bp_celebrate", 4.0, 0, 0, 0, 0, 0);
    SetTimer("workoutcomplete2",60000, false);
    benchpress[playerid] = 0;
    return 1;
    }

	return 1;
}

public workoutcomplete2(playerid)
{

    for(new i=0; i<MAX_PLAYERS; i++)
	{
	workingouttimer[i] = 0;
    return 1;
    }

	return 1;
}

stock PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	return 1;

	return 0;
}

